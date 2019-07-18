# dumps all .ogg sounds in the cwd
Get-ChildItem -Recurse -Name -Filter *.ogg |
	Out-File -FilePath sounds.txt
