-- chunkname: @scripts/managers/game_mode/spawn_modes/single_player_spawning.lua

require("scripts/managers/game_mode/spawn_modes/spawning_base")

SinglePlayerSpawning = class(SinglePlayerSpawning, SpawningBase)

function SinglePlayerSpawning:next_spawn_time(player)
	return 0
end
