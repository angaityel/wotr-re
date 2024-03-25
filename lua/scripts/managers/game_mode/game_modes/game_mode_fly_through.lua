-- chunkname: @scripts/managers/game_mode/game_modes/game_mode_fly_through.lua

require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeFlyThrough = class(GameModeFlyThrough, GameModeBase)

function GameModeFlyThrough:init(settings, world, ...)
	GameModeFlyThrough.super.init(self, settings, world, ...)

	if not Managers.lobby.server and Managers.lobby.lobby then
		Managers.state.event:register(self, "game_started", "event_game_started")
	end
end

function GameModeFlyThrough:event_game_started()
	local level = LevelHelper:current_level(self._world)

	Level.trigger_event(level, "client_fly_through")
end
