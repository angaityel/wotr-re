-- chunkname: @scripts/managers/game_mode/game_modes/game_mode_gpu_prof.lua

require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeGpuProf = class(GameModeGpuProf, GameModeBase)

function GameModeGpuProf:init(settings, world, ...)
	GameModeGpuProf.super.init(self, settings, world, ...)

	if not Managers.lobby.server and Managers.lobby.lobby then
		Managers.state.event:register(self, "game_started", "event_game_started")
	end
end

function GameModeGpuProf:event_game_started()
	local level = LevelHelper:current_level(self._world)

	Level.trigger_event(level, "client_gpu_prof")
end

function GameModeGpuProf:evaluate_end_conditions()
	return false
end
