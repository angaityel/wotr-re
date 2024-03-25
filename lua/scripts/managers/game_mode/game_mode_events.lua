-- chunkname: @scripts/managers/game_mode/game_mode_events.lua

require("scripts/settings/game_mode_event_settings")

GameModeEvents = class(GameModeEvents)

function GameModeEvents:init(world, player)
	self._world = world
	self._player = player

	Managers.state.event:register(self, "gm_event_flag_planted", "event_flag_planted")
	Managers.state.event:register(self, "gm_event_objective_captured", "event_objective_captured")
end

function GameModeEvents:event_flag_planted(planter_player, interactable_unit)
	if not planter_player.team and not self._player.team then
		return
	end

	if planter_player.team == self._player.team then
		self:_trigger_timpani_event("own_team_planted_flag")
	else
		self:_trigger_timpani_event("enemy_team_planted_flag")
	end
end

function GameModeEvents:event_objective_captured(capuring_player, captured_unit)
	if not capuring_player.team and not self._player.team then
		return
	end

	if capuring_player.team == self._player.team then
		self:_trigger_timpani_event("own_team_planted_flag")
	else
		self:_trigger_timpani_event("enemy_team_planted_flag")
	end
end

function GameModeEvents:_trigger_timpani_event(gm_event)
	local timpani_event = GameModeEventSettings[gm_event].timpani_event

	if timpani_event then
		local tw = World.timpani_world(self._world)

		TimpaniWorld.trigger_event(tw, timpani_event)
		print("[GameModeEvents] _trigger_timpani_event " .. timpani_event)
	end
end
