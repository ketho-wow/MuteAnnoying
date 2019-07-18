require "parser"

local function GetListfileSounds()
	local sounds = {}

	local function ParseListfile(file)
		print("Parsing listfile...")
		for line in file:lines() do
			local fdid, path = line[1], line[2]
			if path:find("%.ogg$") then
				sounds[fdid] = path
			end
		end
		print("Finished parsing!\n")
	end

	print("Getting listfile...")
	GetListfile(ParseListfile)
	return sounds
end

local listfileSounds = GetListfileSounds()

-- dumped with powershell https://www.curseforge.com/wow/addons/mute-wow-sounds
local MuteAnnoyingWowSounds = require("input/muteannoyingwowsounds")

-- reverse lookup table
local revListFile = {}
for k, v in pairs(listfileSounds) do
	revListFile[v] = k
end

local function WriteMuteAnnoying(file)
	file:write('local sounds = {\n')
	for _, v in pairs(MuteAnnoyingWowSounds) do
		local fdid = revListFile[v:lower()]
		if fdid then
			file:write(string.format('\t[%d] = "%s",\n', fdid, v))
		end
	end
	file:write([[
}

for fdid in pairs(sounds) do
	MuteSoundFile(fdid)
end
]])
	return file
end

local numFound, numMissing = 0, 0

local function WriteMuteSoundFile(file)
	-- MuteSoundFile addon savedvariables
	-- Im confused why Funkydude uses file paths instead of fdids as keys
	file:write('\t\t\t["soundList"] = {\n')
	for _, v in pairs(MuteAnnoyingWowSounds) do
		local fdid = revListFile[v:lower()]
		if fdid then
			file:write(string.format('\t\t\t\t["%s"] = %d,\n', v, fdid))
			numFound = numFound + 1
		end
	end
	file:write('\t\t\t},\n')
	return file
end

local function WriteMissing(file)
	for _, v in pairs(MuteAnnoyingWowSounds) do
		local fdid = revListFile[v:lower()]
		if not fdid then
			file:write(string.format('%s\n', v))
			numMissing = numMissing + 1
		end
	end
	return file
end

local output = {
	["MuteAnnoying.lua"] = WriteMuteAnnoying,
	["MuteSoundFile_soundList.lua"] = WriteMuteSoundFile,
	["missing.lua"] = WriteMissing,
}

for name, func in pairs(output) do
	print("Writing "..name)
	local file = io.open("output/"..name, "w")
	func(file):close()
end

print("\nsizeAnnoying", #MuteAnnoyingWowSounds)
print("numFound", numFound)
print("numMissing", numMissing)
