-- chunkname: @scripts/unit_extensions/grail/grail_pickup_server.lua

GrailPickupServer = class(GrailPickupServer)
GrailPickupServer.SERVER_ONLY = true
GrailPickupServer.SYSTEM = "flag_system"

function GrailPickupServer:init(world, unit, team_name, lifetime_on_drop, spawn_point)
	self._world = world
	self._unit = unit
	self._init_team_name = team_name
	self._lifetime_on_drop = lifetime_on_drop
	self._spawn_point = spawn_point
	self._kill_time = nil
	self._id = nil
	self._carried = false
	self._carrier_unit = nil

	Unit.set_data(unit, "team_name", team_name)

	if Managers.state.network:game() then
		self:_create_game_object()
	end

	local color = Managers.state.team:team_color_by_name(team_name)

	self._blackboard = {
		color = {
			255,
			color.x * 255,
			color.y * 255,
			color.z * 255
		}
	}

	Managers.state.event:trigger("event_flag_spawned", self._blackboard, self._unit)
end

function GrailPickupServer:_create_game_object()
	local data_table = {
		game_object_created_func = NetworkLookup.game_object_functions.cb_spawn_flag,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_destroy_object,
		object_destroy_func = NetworkLookup.game_object_functions.cb_destroy_unit,
		husk_unit = NetworkLookup.husks[Unit.get_data(self._unit, "husk_unit")],
		position = Unit.local_position(self._unit, 0),
		rotation = Unit.local_rotation(self._unit, 0),
		team_name = NetworkLookup.team[self._init_team_name]
	}
	local callback = callback(self, "cb_game_session_disconnect")

	self._id = Managers.state.network:create_game_object("flag_unit", data_table, callback, "cb_local_unit_spawned", self._unit)
	self._game = Managers.state.network:game()
end

function GrailPickupServer:cb_game_session_disconnect()
	self._frozen = true
	self._id = nil
	self._game = nil
end

function GrailPickupServer:update(unit, input, dt, context)
	if self._frozen then
		return
	end

	GameSession.set_game_object_field(self._game, self._id, "position", Unit.world_position(self._unit, 0))
	GameSession.set_game_object_field(self._game, self._id, "rotation", Unit.world_rotation(self._unit, 0))

	if self._kill_time and Managers.time:time("game") > self._kill_time then
		self:despawn_on_drop()

		self._kill_time = nil
	end
end

function GrailPickupServer:despawn_on_drop()
	self._spawn_point:grail_drop_time_out()
	self:die()
end

function GrailPickupServer:despawn_on_plant()
	self:die()
end

function GrailPickupServer:die()
	Managers.state.event:trigger("event_flag_destroyed", self._unit)

	local game = Managers.state.network:game()

	if game and self._id then
		Managers.state.network:destroy_game_object(self._id)
	else
		local unit = self._unit

		Managers.state.entity:remove_unit(self._unit)
		World.destroy_unit(self._world, unit)
	end
end

function GrailPickupServer:can_be_picked_up(picker_unit)
	return not self._carried
end

function GrailPickupServer:pickup(carrier_unit)
	self._carried = true
	self._carrier_unit = carrier_unit
	self._kill_time = nil

	World.link_unit(self._world, self._unit, carrier_unit, Unit.node(carrier_unit, "a_left_hand"))

	local player = Managers.player:owner(carrier_unit)
	local team_name = player.team.name
	local color = Managers.state.team:team_color_by_name(team_name)

	self._blackboard.color = {
		255,
		color.x * 255,
		color.y * 255,
		color.z * 255
	}

	Unit.set_data(self._unit, "team_name", team_name)

	if self._game and self._id then
		GameSession.set_game_object_field(self._game, self._id, "team_name", NetworkLookup.team[team_name])
	end
end

function GrailPickupServer:can_be_dropped(carrier_unit)
	return self._carried and self._carrier_unit == carrier_unit
end

function GrailPickupServer:drop()
	self._carried = false

	World.unlink_unit(self._world, self._unit)

	if self._lifetime_on_drop then
		self._kill_time = Managers.time:time("game") + self._lifetime_on_drop
	end

	self._blackboard.color = {
		255,
		255,
		255,
		0
	}

	Unit.set_data(self._unit, "team_name", "neutral")

	if self._game and self._id then
		GameSession.set_game_object_field(self._game, self._id, "team_name", NetworkLookup.team.neutral)
	end
end

function GrailPickupServer:destroy()
	return
end
