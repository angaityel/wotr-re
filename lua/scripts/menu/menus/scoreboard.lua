-- chunkname: @scripts/menu/menus/scoreboard.lua

require("scripts/menu/menus/menu")
require("scripts/menu/menu_controller_settings/scoreboard_controller_settings")
require("scripts/menu/menu_definitions/scoreboard_definition")
require("scripts/menu/menu_callbacks/scoreboard_callbacks")

Scoreboard = class(Scoreboard, Menu)

function Scoreboard:init(game_state, world, data)
	Scoreboard.super.init(self, game_state, world, ScoreboardControllerSettings, ScoreboardSettings, ScoreboardDefinition, ScoreboardCallbacks, data)
end

function Scoreboard:set_active(flag)
	Scoreboard.super.set_active(self, flag)
	Window.set_show_cursor(flag)

	if flag then
		Managers.state.hud:set_huds_enabled_except(false)
	else
		Managers.state.hud:set_huds_enabled_except(true)
	end
end
