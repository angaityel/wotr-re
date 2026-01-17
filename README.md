# War of the Roses Launch Fix
Launch War of the Roses game without backend.
- Everything's unlocked.
- Practice and training with bots works.
- Multiplayer works! Select Multiplayer - Server Browser (dedicated servers) or Multiplayer - Join or Host (player hosted servers).
## Using
> [!WARNING]
> Use at your own risk.
- Download [latest release](https://github.com/angaityel/wotr-re/releases)
- Unpack files from bundle.zip to game bundle folder (e.g. C:\Program Files (x86)\Steam\steamapps\common\War of the Roses\bundle\\)
- In game folder: Shift + Right-click on wotr.exe - select Copy as path
- Go to Steam - Library - right click War of the Roses - Properties - LAUNCH OPTIONS
- Paste your copied path and add %command% at the end after space
- "your path to wotr.exe" %command%

Examples of how it should look like:
```
"C:\Program Files (x86)\Steam\steamapps\common\War of the Roses\wotr.exe" %command%
or
"D:\Games\SteamLibrary\steamapps\common\War of the Roses\wotr.exe" %command%
or similar
```
- Launch game
## Alternative method for Linux (Works for Windows too)

- Download [latest release](https://github.com/angaityel/wotr-re/releases)
- Unpack files from bundle.zip to bundle folder
- Delete run_game.exe
- Make copy of wotr.exe
- Rename copy to run_game.exe
- Run it with Proton 9.0-4

## Additional launch options

Main menu themes:
- -main_menu_old
- -main_menu_winter
- -main_menu_halloween_01
- -main_menu_hospitaller
- -main_menu_scottish
![wotr](https://github.com/user-attachments/assets/e076098a-2fa5-45fb-8148-43a46899a16a)

## Dedicated server
> [!WARNING]
> Server is VAC secured

Create steam_appid.txt in game folder with wotr appid 42160

Check server_settings.ini and map_rotation.ini first.

Maps and available modes:
```
St_Albans - town_02 - tdm, con, battle, ass
Mortimers_Cross - village_02 - tdm, con, battle, ass
Bamburgh_Castle - castle_02 - tdm, con, battle, ass
Clitheroe_Forest - forest_01 - tdm, con, battle, ass, grail
London_Tournament - tournament_01 - tdm, battle
Edgecote_Moor - moor_01 - tdm, con, battle, grail
Barnet - field_01 - tdm, con, battle
Wakefield1 - wakefield_01 - tdm, con, battle
Towton - towton_01 - tdm, con, battle
Ravenspurn - ravenspurn_01 - tdm, con, battle, ass
Greenwood - greenwood_01 - tdm, battle
Wakefield - wakefield_02 - ass
Practice - practice - tdm
Whitebox - whitebox - tdm
Dust2 - de_dust2 - tdm, con, battle, ass
Bamburgh_Castle_Night - castle_02_night - tdm, con, battle, ass
Towton_Day - towton_01_day - tdm, con, battle
```
To launch (number = server_port from server_settings.ini - 10):
```
wotr_server.exe -bundle-dir bundle -no-rendering -canary-physics -ini dedicated_server_settings -server_server_port 27020
```
Random rotation
```
-random-map
```
Using -random-map [number], you can limit how many maps are in random rotation. For example, with 52 total variants, setting -random-map 38 would exclude last 14 maps (e.g., all Battle mode maps), but they remain available for voting.
## "Backend"
Add one of the commands to the server launch options:
```
-localbackend
```
Server will save stats for each player locally (gamefolder/stats). 

## Player hosted games
Lobby name and player limit:
- -lobbyname "server name": custom names for servers.
- -lobbymaxmembers 256: server player limit, default value without command is 256.
- -timelimit 123456: round time in seconds.
- -winscore 123: round win score (up to 1000).

And lobby visibility:
- -lobbyprivate: private server (probably useless, invites don't seem to work).
- -lobbyfriends: friends only server (only friends can see or join? Not tested).

You can add these commands to game launch options after %command%.

Should look something like this:
```
"your path to wotr.exe" %command% -lobbyname "my super-duper server" -lobbymaxmembers 8
```
Or you can create a .bat file in game folder with:
```
wotr.exe -bundle-dir bundle -lobbyname "my super-duper server" -lobbymaxmembers 8
```
And launch game through .bat file.

## Hosting games with map rotation and commands

Change map_rotation.ini. First map must be specified in launch options. For example:
```
maps = [
	{
		game_mode = "tdm"
		level = "castle_02"
		game_mode_size = 64
		time_limit = 1234
		win_score = 100
	}
	{
	...
```
Then launch options should look like this:
```
wotr.exe -bundle-dir bundle -autohost -network-hash "" -level castle_02 -game-mode tdm -timelimit 1234 -lobbyname "server name" -ini launch_server_settings
```

## Build
Use this version of LuaJIT for compiling lua files:

https://github.com/LuaJIT/LuaJIT/releases/tag/v2.0.0-beta10

To create patch files, use:

https://github.com/angaityel/bundle-explorer
