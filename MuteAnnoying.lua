local _, ns = ...
local unmute = ns.unmute

for _, group in pairs(ns.mute) do
	for fdid in pairs(group) do
		if not unmute[fdid] then 
			MuteSoundFile(fdid)
		end
	end
end

-- allow access by any other addon
-- in case they want to modify mute.custom or ns.unmute
MuteAnnoying = ns
