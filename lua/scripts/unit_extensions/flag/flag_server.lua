-- chunkname: @scripts/unit_extensions/flag/flag_server.lua

FlagServer = class(FlagServer)
FlagServer.SERVER_ONLY = true
FlagServer.SYSTEM = "flag_system"

function FlagServer:init(world, unit, team_name, lifetime_on_drop)
	self._world = world
	self._unit = unit
	self._team_name = team_name
	self._lifetime_on_drop = lifetime_on_drop
	self._kill_time = nil
	self._id = nil
	self._carried = false
	self._carrier_unit = nil

	Unit.set_data(unit, "team_name", team_name)

	if Managers.state.network:game() then
		self:_create_game_object()
	end

	local team = Managers.state.team:team_by_name(team_name)

	self._flag_hud_blackboard = {
		owner_team_side = team.side
	}

	Managers.state.event:trigger("event_flag_spawned", self._flag_hud_blackboard, self._unit)
end

function FlagServer:_create_game_object()
	local data_table = {
		game_object_created_func = NetworkLookup.game_object_functions.cb_spawn_flag,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_destroy_object,
		object_destroy_func = NetworkLookup.game_object_functions.cb_destroy_unit,
		husk_unit = NetworkLookup.husks[Unit.get_data(self._unit, "husk_unit")],
		position = Unit.local_position(self._unit, 0),
		rotation = Unit.local_rotation(self._unit, 0),
		team_name = NetworkLookup.team[self._team_name]
	}
	local callback = callback(self, "cb_game_session_disconnect")

	self._id = Managers.state.network:create_game_object("flag_unit", data_table, callback, "cb_local_unit_spawned", self._unit)
	self._game = Managers.state.network:game()
end

function FlagServer:cb_game_session_disconnect()
	self._frozen = true
	self._id = nil
	self._game = nil
end

function FlagServer:update(unit, input, dt, context)
	if self._frozen then
		return
	end

	if Managers.state.network:game() then
		GameSession.set_game_object_field(self._game, self._id, "position", Unit.world_position(self._unit, 0))
		GameSession.set_game_object_field(self._game, self._id, "rotation", Unit.world_rotation(self._unit, 0))
	end

	if self._kill_time and Managers.time:time("game") > self._kill_time then
		self:die()

		self._kill_time = nil
	end
end

function FlagServer:die()
	local game = Managers.state.network:game()

	Managers.state.event:trigger("event_flag_destroyed", self._unit)

	if game and self._id then
		Managers.state.network:destroy_game_object(self._id)
	else
		local unit = self._unit

		Managers.state.entity:remove_unit(self._unit)
		World.destroy_unit(self._world, unit)
	end
end

function FlagServer:can_be_picked_up(picker_unit)
	local picker_player = Managers.player:owner(picker_unit)
	local picker_team_name = picker_player.team.name

	return not self._carried and picker_team_name == self._team_name
end

function FlagServer:pickup(carrier_unit)
	local network_manager = Managers.state.network

	self._carried = true
	self._carrier_unit = carrier_unit
	self._kill_time = nil

	World.link_unit(self._world, self._unit, carrier_unit, Unit.node(carrier_unit, "a_left_hand"))

	local game = network_manager:game()

	if game and self._id then
		-- block empty
	end
end

function FlagServer:can_be_dropped(carrier_unit)
	return self._carried and self._carrier_unit == carrier_unit
end

function FlagServer:drop()
	self._carried = false

	World.unlink_unit(self._world, self._unit)

	if self._lifetime_on_drop then
		self._kill_time = Managers.time:time("game") + self._lifetime_on_drop
	end
end

function FlagServer:team_name()
	return self._team_name
end

function FlagServer:destroy()
	return
end
