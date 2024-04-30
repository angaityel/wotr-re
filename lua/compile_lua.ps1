foreach($path_lua in Get-Content changed_lua_files.txt) {
	if($path_lua -match $regex){
		$folders = Split-Path -Parent $path_lua
		$create_folders = -join("../lua_compiled/", $folders);
		$path_lua_compiled = -join("../lua_compiled/", $path_lua);
		If(!(test-path -PathType container $create_folders))
		{
			New-Item -ItemType Directory -Path $create_folders
		}
		& ".\luajit.exe" "-b" "-g" $path_lua $path_lua_compiled
	}
}
