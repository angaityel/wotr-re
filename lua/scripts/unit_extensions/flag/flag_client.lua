-- chunkname: @scripts/unit_extensions/flag/flag_client.lua

FlagClient = class(FlagClient)
FlagClient.CLIENT_ONLY = true
FlagClient.SYSTEM = "flag_system"

function FlagClient:init(world, unit)
	self._world = world
	self._unit = unit
	self._team_name = nil
	self._id = nil
	self._carried = false
	self._carrier_unit = nil
	self._flag_spawned_event_triggered = false
end

function FlagClient:set_game_object_id(obj_id, game)
	self._id = obj_id

	local team_name = NetworkLookup.team[GameSession.game_object_field(game, obj_id, "team_name")]

	self._team_name = team_name

	Unit.set_data(self._unit, "team_name", team_name)

	local team = Managers.state.team:team_by_name(team_name)

	self._flag_hud_blackboard = {
		owner_team_side = team.side
	}

	Managers.state.event:trigger("event_flag_spawned", self._flag_hud_blackboard, self._unit)

	self._flag_spawned_event_triggered = true
end

function FlagClient:update(unit, input, dt, context)
	local game = Managers.state.network:game()
	local id = self._id

	if not self._carried and game and id then
		local unit = self._unit

		Unit.set_local_position(unit, 0, GameSession.game_object_field(game, id, "position", Unit.local_position(self._unit, 0)))
		Unit.set_local_rotation(unit, 0, GameSession.game_object_field(game, id, "rotation", Unit.local_rotation(self._unit, 0)))
	end
end

function FlagClient:can_be_picked_up(picker_unit)
	local picker_player = Managers.player:owner(picker_unit)
	local picker_team = picker_player.team

	if not picker_team then
		return
	end

	local picker_team_name = picker_team.name

	return not self._carried and picker_team_name == self._team_name
end

function FlagClient:pickup(carrier_unit)
	self._carried = true
	self._carrier_unit = carrier_unit

	World.link_unit(self._world, self._unit, carrier_unit, Unit.node(carrier_unit, "a_left_hand"))
end

function FlagClient:can_be_dropped(dropper_unit)
	return self._carried and self._carrier_unit == dropper_unit
end

function FlagClient:drop()
	self._carried = false
	self._carrier_unit = nil

	World.unlink_unit(self._world, self._unit)

	local game = Managers.state.network:game()
	local id = self._id

	if game and id then
		local unit = self._unit

		Unit.set_local_position(unit, 0, GameSession.game_object_field(game, id, "position", Unit.local_position(self._unit, 0)))
		Unit.set_local_rotation(unit, 0, GameSession.game_object_field(game, id, "rotation", Unit.local_rotation(self._unit, 0)))
	end
end

function FlagClient:destroy()
	if self._flag_spawned_event_triggered then
		Managers.state.event:trigger("event_flag_destroyed", self._unit)
	end
end
