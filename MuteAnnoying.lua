MuteAnnoying = {}
MuteAnnoying.mute = {}
local db

local defaults = {
	db_version = 0.1,
	custom_mute = {},
	custom_unmute = {},
}

local f = CreateFrame("Frame")

function f:OnEvent(event, addon)
	if addon == "MuteAnnoying" then
		-- set up db
		if not MuteAnnoyingDB or MuteAnnoyingDB.db_version < defaults.db_version then
			MuteAnnoyingDB = CopyTable(defaults)
		end
		db = MuteAnnoyingDB

		-- import custom sounds
		custom_mute = db.custom_mute
		custom_unmute = db.custom_unmute
		for k, v in pairs(MuteAnnoying.custom) do
			custom_mute[k] = v
		end
		for k, v in pairs(MuteAnnoying.unmute) do
			custom_unmute[k] = v
		end

		MuteAnnoying:MuteSounds()
		MuteAnnoying:MuteCustomSounds()
		self:UnregisterEvent(event)
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)

function MuteAnnoying:MuteSounds()
	local unmute = MuteAnnoying.unmute
	for _, group in pairs(self.mute) do
		for fdid in pairs(group) do
			if not unmute[fdid] then
				MuteSoundFile(fdid)
			end
		end
	end
end

function MuteAnnoying:MuteCustomSounds()
	for fdid in pairs(custom_mute) do
		MuteSoundFile(fdid)
	end
end
