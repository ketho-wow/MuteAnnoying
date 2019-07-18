MuteAnnoying = {}
MuteAnnoying.mute = {}
-- New updates will ovewrwrite this file but custom sounds will be automatically stored
-- in savedvariables. its still advised to keep a backup

-- Use the following table to ADD additional sounds to be muted which are not included
-- in the addon proper.  For example, this would be the place to add sounds which you
-- find annoying, but other players may enjoy, etc.  (Note: The structure of this table 
-- is identical to the other files found in this directory.)
MuteAnnoying.custom = {
	--[569593] = "Sound/Spells/LevelUp.ogg",
}

-- Use the following table to REMOVE sounds included in this addon from being muted. For 
-- example, the Flight Master "takeoff" sound is typically muted via this addon.  So, if
-- you wanted to un-mute it, you would include the following line in the table below:
MuteAnnoying.unmute = {
	--[569838] = "Sound/Universal/FM_Takeoff.ogg",
}
