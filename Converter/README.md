### Converts sounds from [Mute Annoying WoW Sounds](https://www.curseforge.com/wow/addons/mute-wow-sounds) to FileDataIDs.

In Patch 8.2.0 you can't replace sounds anymore by placing a file in the **Sound**\ folder, they can now only be muted with [MuteSoundFile](https://wow.gamepedia.com/API_MuteSoundFile)(FileDataID)

#### Getting FileDataIDs from your Sound\ folder (Windows)
1. `muteannoyingwowsounds.lua` Run the [PowerShell script](https://github.com/ketho-wow/MuteAnnoying/blob/master/input/muteannoyingwowsounds.ps1) from 1 level above your **Sound**\ folder.
    * Turn the results into a Lua table (with regex).  
      `(.*)` → `\t"$1",`  
      Replace `\` backslashes with `/` forward slashes (so that it matches the listfile).

2. Run `main.lua`

* Dependencies, partially from [WoWtoolsParser](https://github.com/Ketho/WoWtoolsParser):
    * curl: https://curl.haxx.se/
    * lua-curl: https://luarocks.org/modules/moteus/lua-curl
    * csv: https://luarocks.org/modules/geoffleyland/csv

* Output:
    * `MuteAnnoying.lua` Example with FDIDs (and unused sound path).
    * `MuteSoundFile_soundList.lua` FDIDs you can paste into the [MuteSoundFile](https://github.com/funkydude/MuteSoundFile) addon's savedvariables.
    * `missing.lua` Sound paths that failed to match a FDID.
