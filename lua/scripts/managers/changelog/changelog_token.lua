-- chunkname: @scripts/managers/changelog/changelog_token.lua

ChangelogToken = class(ChangelogToken)

function ChangelogToken:init(loader, job)
	self._loader = loader
	self._job = job
	self._name = "ChangelogToken"
end

function ChangelogToken:name()
	return self._name
end

function ChangelogToken:info()
	local info = {}

	if self:done() and UrlLoader.success(self._loader, self._job) then
		info.body = UrlLoader.text(self._loader, self._job)
	else
		info.body = [[[0.3.5 - 26.04.2026]
- Domination mode for St_Albans map.
- Less spawns for ffa mode (only tdm spawns). And ffa game_mode_size setting can be adjusted in the map_rotation.ini.

 

[0.3.4 - 28.03.2026]
- Free-For-All (ffa) mode for all maps.
- Friendly fire damage numbers now show real damage.
- 1 minute delay for /vote_map at the round start.
- Headhunter achievement requirement lowered from 2001 to 21.
- Faster leveling (10x).

 

[0.3.3 - 10.03.2026]
- The default font size for chat has been increased from 16 to 26. If it is still too small or too large, you can change it in the main menu settings - new settings (Available sizes: 16-56, restart the game to apply the changes).
- Bots in training can now use block.
- You can now select the previous level in the host menu using the "N" key.

 

[0.3.2 - 20.02.2026]
- New maps:
 Tower_of_London
 Seasick
- Fixed fps drop on Clitheroe_Forest map.

 

[0.3.1 - 17.01.2026]
- Assault mode for Ravenspurn map.
- Grail mode for Clitheroe_Forest map.
- Practice map is now brighter.
- Horses are now disabled in Grail mode.
- Transition between rounds in Battle mode is now faster.
- Using -random-map [number], you can limit how many maps are in random rotation. For example, with 52 total variants, setting -random-map 38 would exclude last 14 maps (e.g., all Battle mode maps), but they remain available for voting.
- Gate on St_Albans map now close automatically, even if there are defenders nearby.
- Battle mode should now only start if there are at least two players, if minimum_players_per_team in server_settings.ini changed to 1.
- On Dust2 map, players now spawn automatically after 5sec to prevent ghost mode abuse.
- Fixed tiebreak volumes in Battle mode for Dust2 map.
- Fixed squad spawning on Dust2 map.

 

[0.3.0 - 25.11.2025]
- New maps:
 Dust2
 Bamburgh_Castle_Night
 Towton_Day
- Copy/paste builds now uses winapi instead of clip and powershell.
- Custom capture speed for conquest mode.
- Renamed maps (fixed: if different maps have the same name, you can only vote for one of them):
 Whitebox (Practice) to Practice
 Wakefield (tdm, con, battle) to Wakefield1
- Added random map rotation (add -random-map to the server launch options).
- Added voter name for /vote_map.
- Auto join team button should now assign players evenly (and you cannot manually join a team with more players).
- Battle mode on the castle map has been reverted to its original version..
- Ghosts can now talk (in battle mode).
- Fixed server browser crash if client doesn't have server map/mode.
- Fixed server crash when using /list_levels if map rotation has too many maps/modes (and /list_levels output looks more compact).
- Fixed wrong tdm game_mode_size when map is loaded from /vote_map.
- Fixed(?) when a new player gets another player's stats when connecting to a server with stats enabled.

 

[0.2.12 - 12.08.2025]
- Copy/paste builds. 
- Now only small part of the Castle map available for pitched battle mode (More like the arena mode from War of the Vikings).
- Added missing Cyrillic fonts to fix Russian localization.
- (?)Fixed voting crash at the end of the round.

 

[0.2.11 - 06.05.2025]
- Restored compatibility with previous versions.
- Added 33 custom class slots.
- You can now use editor in-game without leaving the server.
- Added fix version to main menu.

 

[0.2.10 - 29.04.2025]
- Game mode - Grail (One flag capture the flag)
- Unlocked dlc (Two armor sets (may have already been available) and Brian Blessed voiceover (Settings - Audio - Voice over)).
- Added Steam chat link to main menu.
- Added additional command aliases.
 Instead of /list_levels, you can use /list_maps, /list, /maps or /l
 Instead of /vote_map, you can use /vote or /v

 

[0.2.9 - 04.04.2025]
- Player hosted games with map rotation and commands.

 

[0.2.8 - 03.12.2024]
- Custom profiles in training with bots.
- Added Discord link to main menu.
- Main menu themes.

 

[0.2.7 - 28.05.2024]
- Fixed server crash when someone ranks up.

 

[0.2.6 - 23.05.2024]
- Fixed: Some players are unable to join assault and battle modes.

 

[0.2.5 - 07.05.2024]
- Fixed game crash when connecting to the server.

 

[0.2.4 - 30.04.2024]
- Saving and loading stats for achievements.
- Telemetry (kills and spawn stats).
- Version info and fps are no longer displayed.

 

[0.2.3 - 22.03.2024]
- Invisible weapons fix (Thanks to k|Volucris).
- Join menu now shows only player hosted games to avoid game crashes when there are more than 9 servers.
- Chat commands are re-enabled (they're works on dedicated servers, but still crash player hosted games).

 

[0.2.2 - 17.03.2024]
- Dedicated servers are unlocked.
-winscore option limit is set to 1000 to prevent hosted games from crashing.

 

[0.2.1 - 16.03.2024]
New launch options:
 -timelimit 123456: round time in seconds.
 -winscore 123456: round win score.

 

[0.2.0 - 14.03.2024]
- Chat commands are disabled.
- Friendly fire damage multiplier is set to 1, mirror damage is disabled.
Added new launch options for hosters:
 -lobbyname "server name": custom names for servers.
 -lobbymaxmembers 256: server player limit, default value without command is 256.
And lobby visibility:
 -lobbyprivate: private server (probably useless, invites don't seem to work).
 -lobbyfriends: friends only server (only friends can see or join? Not tested).

 

[0.1.0 - 05.03.2024]
- Resurrected

]]
		info.error = "Failed loading changelog"
	end

	return info
end

function ChangelogToken:update()
	return
end

function ChangelogToken:done()
	return UrlLoader.done(self._loader, self._job)
end

function ChangelogToken:close()
	UrlLoader.unload(self._loader, self._job)
end
