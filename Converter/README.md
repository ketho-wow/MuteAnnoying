### Converts sounds from [Mute Annoying WoW Sounds](https://www.curseforge.com/wow/addons/mute-wow-sounds) to FileDataIDs.

In Patch 8.2.0 you can't replace sounds anymore by placing a file in the **Sound**\ folder, they can now only be muted with [MuteSoundFile](https://wow.gamepedia.com/API_MuteSoundFile)(FileDataID)

#### Getting FileDataIDs from your Sound\ folder (Windows)
1. Run the PowerShell script in the **Sound**\ folder.
```powershell
Get-ChildItem -Recurse -Name -Filter *.ogg | Out-File -FilePath sounds.txt
```
2. Turn the results into a Lua table (with regex).  
`(.*)` → `\t"$1",`  
Replace `\` backslashes with `/` forward slashes (so that it matches the listfile).

3. Run `main.lua` to export sound lists, e.g. `output/creature.lua`

#### Dependencies:
* curl: https://curl.haxx.se/
* lua-curl: https://luarocks.org/modules/moteus/lua-curl
* csv: https://luarocks.org/modules/geoffleyland/csv
