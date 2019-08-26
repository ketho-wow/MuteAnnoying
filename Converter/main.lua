require "parser"

local folders = {
	"ambience",
	"character",
	"creature",
	"doodad",
	"emitters",
	"event",
	"events",
	"interface",
	"item",
	"spells",
	"universal",
	"vehicles",
}

local function GetSoundsListfile()
	print("Getting listfile...")
	local lfPath, lfStem = {}, {}
	GetListfile(function(file)
		print("Parsing listfile...") -- this gonna take a while
		for line in file:lines() do
			local fdid, path = tonumber(line[1]), line[2]
			local _, _, stem = path:find(".+/(.-)%.ogg$") -- cba to include mp3
			if stem then
				lfPath[fdid] = path
				lfStem[stem] = fdid
			end
		end
		print("Finished parsing!")
	end)
	return lfPath, lfStem
end

local function FindFileDataID(lfPath, lfStem)
	-- https://www.curseforge.com/wow/addons/mute-wow-sounds
	local in_MAWS = require("input/muteannoyingwowsounds")
	local sounds, missing = {}, {}
	for _, path in pairs(in_MAWS) do
		-- get only file stem since some paths changed while the stem didnt
		local _, _, stem = path:lower():find(".+/(.-)%.ogg$")
		local fdid = tonumber(lfStem[stem])
		if fdid then
			sounds[fdid] = lfPath[fdid]
		else
			table.insert(missing, path)
		end
	end
	return sounds, missing
end

local function WriteFiles()
	local path, stem = GetSoundsListfile()
	local sounds, missing = FindFileDataID(path, stem)
	-- get github added data
	local added_github = require("input/added_github")
	for fdid, path in pairs(added_github) do
		sounds[fdid] = path
	end
	-- write files
	for _, group in pairs(folders) do
		local file = io.open("output/"..group..".lua", "w")
		local sorted = {}
		for fdid, path in pairs(sounds) do
			if path:find("sound/"..group) then
				table.insert(sorted, {fdid, path})
			end
		end
		table.sort(sorted, function(a, b)
			return a[2] < b[2]
		end)
		file:write("MuteAnnoying.mute."..group.." = {\n")
		for _, v in pairs(sorted) do
			file:write(string.format('\t[%d] = "%s",\n', v[1], v[2]))
		end
		file:write("}\n")
		file:close()
	end

	table.sort(missing)
	local missingFile = io.open("output/missing.txt", "w")
	for _, path in pairs(missing) do
		missingFile:write(path.."\n")
	end
	missingFile:close()
	--[[ print added sounds from found.txt by schlumpf
	local found_schlumpf = require("input/found_schlumpf")
	for fdid, path in pairs(found_schlumpf) do
		if not sounds[fdid] and path:find("%.ogg$") then
			print("found schlumpf", fdid, path)
		end
	end
	]]
	print("Finished writing files")
end

WriteFiles()
