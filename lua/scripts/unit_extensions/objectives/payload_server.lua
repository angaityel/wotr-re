-- chunkname: @scripts/unit_extensions/objectives/payload_server.lua

require("scripts/unit_extensions/objectives/payload_base")

PayloadServer = class(PayloadServer, PayloadBase)
PayloadServer.SERVER_ONLY = true
PayloadServer.SYSTEM = "objective_system"

local FRAMES = 100

function PayloadServer:init(world, unit)
	self._world = world
	self._unit = unit
	self._units_in_proximity = {}
	self._active = {}
	self._blackboard = {
		owner_team_side = "neutral",
		active_team_sides = {
			defenders = false,
			attackers = false
		}
	}

	self:_init_movement_spline(world, unit)

	local current_level = LevelHelper:current_level(world)
	local level_unit_index = Level.unit_index(current_level, unit)

	Unit.set_data(unit, "level_unit_index", level_unit_index)
	Managers.state.event:register(self, "event_start_round", "event_start_round", "event_round_started", "event_round_started")

	local from = 0
	local to = FRAMES / 30
	local loop = true
	local speed = 0

	Unit.play_simple_animation(unit, from, to, loop, speed, "movement")

	self._buff_refresh_time = 0
	self._friendly_units = {}
	self._last_spline = 0
	self._last_forced_speed = nil
	self._spline_limits = {
		min = {},
		max = {}
	}
	self._state = "stopped"
	self._last_status = "start"
end

function PayloadServer:event_start_round(params)
	self:_init_teams()
end

function PayloadServer:flow_cb_set_spline_limit(limit_type, spline, acceleration)
	local limit = self._spline_limits[limit_type]

	limit.spline = spline
	limit.acceleration = acceleration
end

function PayloadServer:event_round_started(params)
	if Managers.state.network:game() then
		self:_create_game_object()
	end
end

function PayloadServer:flow_cb_add_player_unit(unit)
	self._units_in_proximity[unit] = true
end

function PayloadServer:flow_cb_remove_player_unit(unit)
	self._units_in_proximity[unit] = nil
end

function PayloadServer:flow_cb_set_owner(team)
	self:set_owner(team)
end

function PayloadServer:set_owner(team)
	Unit.set_flow_variable(self._unit, "owner", team)

	self._blackboard.owner_team_side = team

	local game = Managers.state.network:game()
	local id = self._id

	if game and id then
		GameSession.set_game_object_field(game, id, "owner", NetworkLookup.team[team])
	end
end

function PayloadServer:flow_cb_set_active(team, active)
	self:_set_active(team, active)
end

function PayloadServer:_set_active(team, active)
	local no_active_before = true
	local no_active_after = true
	local unit = self._unit
	local bb = self._blackboard

	bb.active_team_sides[team] = active

	for _, team_side in pairs(Managers.state.team:sides()) do
		if bb.active_team_sides[team_side] then
			no_active_after = false
		end

		if self._active[team_side] then
			no_active_before = false
		end
	end

	if active and no_active_before then
		Managers.state.event:trigger("objective_activated", bb, unit)
	elseif not active and no_active_after then
		Managers.state.event:trigger("objective_deactivated", unit)
	end

	self._active[team] = active

	local game = Managers.state.network:game()
	local id = self._id

	if game and id then
		GameSession.set_game_object_field(game, id, team .. "_active", active)
	end
end

function PayloadServer:active(side)
	return self._active[side]
end

function PayloadServer:owned(side)
	return self._owner == side
end

function PayloadServer:_init_teams()
	local teams = Managers.state.team:sides()

	for _, team in pairs(teams) do
		self._active[team] = false
	end
end

function PayloadServer:flow_cb_set_auto_move(set)
	self._auto_moving = set
end

function PayloadServer:update(unit, input, dt, context, t)
	local owning_side = self._blackboard.owner_team_side

	if owning_side == "neutral" or not self._active[owning_side] and not self._auto_moving then
		Unit.set_simple_animation_speed(self._unit, 0, "movement")
		Unit.flow_event(self._unit, "lua_stopped")

		local game = Managers.state.network:game()

		if game and self._id then
			GameSession.set_game_object_field(game, self._id, "speed", 0, true)
		end

		return
	end

	local has_friendlies_in_proximity, has_hostiles_in_proximity = self:_update_units_in_proximity(dt, t)

	self:_update_movement(dt, t, has_friendlies_in_proximity or self._auto_moving, has_hostiles_in_proximity)
	self:_update_buff(t, dt)
	self:_update_player_collision(t, dt)
end

local OVERLAP_HALF_WIDTH = 0.6
local OVERLAP_HALF_DEPTH = 1.6
local OVERLAP_HALF_HEIGHT = 0.8

function PayloadServer:_update_player_collision(t, dt)
	local physics_world = World.physics_world(self._world)
	local unit = self._unit
	local root_pose = Unit.local_pose(unit, 0)
	local extents = Vector3(OVERLAP_HALF_WIDTH, OVERLAP_HALF_DEPTH, OVERLAP_HALF_HEIGHT)
	local rot = Matrix4x4.rotation(root_pose)
	local pos = Matrix4x4.translation(root_pose)
	local pose = Matrix4x4.from_quaternion_position(rot, pos + Vector3(0, 0, OVERLAP_HALF_HEIGHT))

	if script_data.payload_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "immediate",
			name = "payload"
		})

		drawer:box(pose, extents, Color(255, 0, 0))
	end

	local actors = PhysicsWorld.overlap(physics_world, nil, "shape", "oobb", "pose", pose, "size", extents, "types", "dynamics", "collision_filter", "kill_trigger")

	if actors then
		for _, actor in ipairs(actors) do
			local unit = Actor.unit(actor)

			if Unit.alive(unit) and ScriptUnit.has_extension(unit, "damage_system") then
				local damage_ext = ScriptUnit.extension(unit, "damage_system")

				if not damage_ext:is_dead() then
					local owner = Managers.player:owner(unit)

					damage_ext:die(owner, nil, false, "crush")
				end
			end
		end
	end
end

function PayloadServer:_update_buff(t, dt)
	local buff_duration = 60

	if Unit.has_data(self._unit, "area_buff") and self._id and t > self._buff_refresh_time then
		self._buff_refresh_time = t + buff_duration

		self:_create_area_buff(buff_duration)
	end
end

function PayloadServer:cb_calculate_eligble_buff_targets()
	return self:friendly_units()
end

function PayloadServer:friendly_units()
	local new_table = {}

	for index, unit in ipairs(self._friendly_units) do
		if Unit.alive(unit) and ScriptUnit.has_extension(unit, "damage_system") then
			local damage_extension = ScriptUnit.extension(unit, "damage_system")

			if not damage_extension:is_knocked_down() and not damage_extension:is_dead() and ScriptUnit.has_extension(unit, "locomotion_system") and not ScriptUnit.extension(unit, "locomotion_system").ghost_mode then
				new_table[#new_table + 1] = unit
			end
		end
	end

	return new_table
end

function PayloadServer:is_contributing(player)
	for _, unit in pairs(self._friendly_units) do
		if unit == player.player_unit then
			return true
		end
	end
end

function PayloadServer:_create_area_buff(duration, eligible_targets_function)
	local unit = self._unit
	local buff_type = Unit.get_data(unit, "area_buff", "type")
	local level = Unit.get_data(unit, "area_buff", "level")

	local function level_calculation_function()
		return level
	end

	local eligible_targets_function = callback(self, "cb_calculate_eligble_buff_targets")
	local shape = Unit.get_data(unit, "area_buff", "shape")
	local radius = Unit.get_data(unit, "area_buff", "radius")
	local source_name = buff_type .. tostring(self._id)

	Managers.state.area_buff:create_area_buff(unit, buff_type, level_calculation_function, eligible_targets_function, duration, shape, radius, source_name)
end

function PayloadServer:_update_units_in_proximity(dt, t)
	local has_hostiles_in_proximity = 0
	local has_friendlies_in_proximity = 0
	local owning_side = self._blackboard.owner_team_side
	local player_manager = Managers.player
	local units = self._units_in_proximity

	table.clear(self._friendly_units)

	for unit, _ in pairs(units) do
		if Unit.alive(unit) then
			local damage_extension = ScriptUnit.extension(unit, "damage_system")

			if not damage_extension:is_knocked_down() and not damage_extension:is_dead() and not ScriptUnit.extension(unit, "locomotion_system").ghost_mode then
				local player = player_manager:owner(unit)
				local side_name = player and player.team and player.team.side

				if side_name == owning_side then
					has_friendlies_in_proximity = has_friendlies_in_proximity + 1
					self._friendly_units[#self._friendly_units + 1] = unit
				elseif side_name == "attackers" or side_name == "defenders" then
					has_hostiles_in_proximity = has_hostiles_in_proximity + 1
				end
			end
		else
			units[unit] = nil
		end
	end

	return has_friendlies_in_proximity, has_hostiles_in_proximity
end

function PayloadServer:_update_movement(dt, t, has_friendlies_in_proximity, has_hostiles_in_proximity)
	local spline_curve = self._spline_curve
	local spline_movement = spline_curve:movement()
	local current_spline = spline_movement:_current_spline()
	local metadata = current_spline.metadata
	local speed_settings = metadata.speed_settings
	local used_speed_settings

	if has_hostiles_in_proximity < has_friendlies_in_proximity then
		used_speed_settings = speed_settings.most_friendlies
	elseif has_friendlies_in_proximity < has_hostiles_in_proximity then
		used_speed_settings = speed_settings.most_hostiles
	elseif has_friendlies_in_proximity == has_hostiles_in_proximity and has_friendlies_in_proximity + has_hostiles_in_proximity > 0 then
		used_speed_settings = speed_settings.equal_amount
	else
		used_speed_settings = speed_settings.not_pushed
	end

	local new_target_speed = used_speed_settings.speed
	local acceleration
	local max_limit = self._spline_limits.max
	local min_limit = self._spline_limits.min
	local old_spline_index = spline_movement:current_spline_index()

	if max_limit.spline and new_target_speed > 0 and old_spline_index >= max_limit.spline then
		new_target_speed = 0
		acceleration = max_limit.acceleration
	elseif min_limit.spline and new_target_speed < 0 and old_spline_index <= min_limit.spline then
		new_target_speed = 0
		acceleration = min_limit.acceleration
	else
		acceleration = used_speed_settings.acceleration
	end

	if new_target_speed > 0 and self._last_status == "end" or new_target_speed < 0 and self._last_status == "start" then
		new_target_speed = 0
	end

	self:_set_speed(new_target_speed, acceleration, dt)

	local status = spline_movement:update(dt, t)

	self._last_status = status

	self:_set_position(spline_movement:current_position())
	self:_set_rotation(Quaternion.look(spline_movement:current_tangent_direction(), Vector3.up()))

	local current_spline_index = spline_movement:current_spline_index()

	self:_throw_flow_events(dt, t, current_spline_index)
	self:_update_spline_game_object_fields(dt, t, current_spline_index, spline_movement:current_subdivision_index(), spline_movement:current_t())

	if status == "end" then
		self:_end_reached()
	end
end

function PayloadServer:_set_spline_index(new_spline_index)
	self._last_spline = new_spline_index

	local unit = self._unit

	Unit.set_flow_variable(unit, "lua_spline", new_spline_index)
	Unit.flow_event(unit, "lua_spline_changed")
end

local EPSILON = 0.01

function PayloadServer:_throw_flow_events(dt, t, current_spline_index)
	while math.abs(self._last_spline - current_spline_index) > EPSILON do
		if current_spline_index > self._last_spline then
			self:_set_spline_index(self._last_spline + 1)
		elseif current_spline_index < self._last_spline then
			self:_set_spline_index(self._last_spline - 1)
		end
	end
end

function PayloadServer:_update_spline_game_object_fields(dt, t, index, subdivision, spline_t)
	local game = Managers.state.network:game()
	local id = self._id

	if game and id then
		GameSession.set_game_object_field(game, id, "spline_index", index)
		GameSession.set_game_object_field(game, id, "subdivision_index", subdivision)
		GameSession.set_game_object_field(game, id, "spline_t", spline_t)
	end
end

function PayloadServer:_end_reached()
	local unit = self._unit

	if self._auto_moving then
		Unit.flow_event(unit, "lua_target_auto_reached_server")
		Unit.flow_event(unit, "lua_target_auto_reached_all")
		Managers.state.network:send_rpc_clients("rpc_payload_target_reached", self._id, true)
	else
		Unit.flow_event(unit, "lua_target_reached_server")
		Unit.flow_event(unit, "lua_target_reached_all")
		Managers.state.network:send_rpc_clients("rpc_payload_target_reached", self._id, false)
	end
end

local WHEEL_DIAMETER = 0.108
local WHEEL_CIRCUMFERENCE = WHEEL_DIAMETER * math.pi
local ANIM_SPEED = 30 / FRAMES / WHEEL_CIRCUMFERENCE
local MOVING_THRESHOLD = 0.1

function PayloadServer:_set_speed(target_speed, acceleration, dt)
	local force_speed = false
	local unit = self._unit
	local movement = self._spline_curve:movement()
	local old_speed = movement:speed()
	local wanted_speed_change = target_speed - old_speed
	local new_speed

	if wanted_speed_change > 0 then
		new_speed = math.min(old_speed + acceleration * dt, target_speed)
	elseif wanted_speed_change < 0 then
		new_speed = math.max(old_speed - acceleration * dt, target_speed)
	else
		new_speed = target_speed
	end

	if target_speed == new_speed then
		if self._last_forced_speed ~= target_speed then
			self._last_forced_speed = target_speed
			force_speed = true
		end
	else
		self._last_forced_speed = nil
	end

	Unit.set_simple_animation_speed(unit, new_speed / ANIM_SPEED, "movement")
	movement:set_speed(new_speed)

	if self._state ~= "stopped" and math.abs(new_speed) < MOVING_THRESHOLD then
		self._state = "stopped"

		Unit.flow_event(unit, "lua_stopped")
	elseif self._state ~= "moving" and math.abs(new_speed) >= MOVING_THRESHOLD then
		self._state = "moving"

		Unit.flow_event(unit, "lua_moving")
	end

	local game = Managers.state.network:game()
	local id = self._id

	if game and id then
		GameSession.set_game_object_field(game, id, "speed", new_speed, force_speed)
	end
end

function PayloadServer:_set_position(pos)
	Unit.set_local_position(self._unit, 0, pos)

	local game = Managers.state.network:game()
	local id = self._id
end

function PayloadServer:_set_rotation(rot)
	Unit.set_local_rotation(self._unit, 0, rot)

	local game = Managers.state.network:game()
	local id = self._id
end

function PayloadServer:destroy()
	return
end

function PayloadServer:_create_game_object()
	local unit = self._unit
	local movement = self._spline_curve:movement()
	local data_table = {
		game_object_created_func = NetworkLookup.game_object_functions.cb_payload_created,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		object_destroy_func = NetworkLookup.game_object_functions.cb_payload_destroyed,
		level_unit_index = Unit.get_data(self._unit, "level_unit_index"),
		owner = NetworkLookup.team[self._blackboard.owner_team_side],
		spline_index = movement:current_spline_index(),
		subdivision_index = movement:current_subdivision_index(),
		spline_t = movement:current_t(),
		speed = self._spline_curve:movement():speed()
	}

	for team, active in pairs(self._active) do
		data_table[team .. "_active"] = active
	end

	local callback = callback(self, "cb_game_session_disconnect")

	self._id = Managers.state.network:create_game_object("payload", data_table, callback, "cb_local_payload_created", unit)
	self._game = Managers.state.network:game()
end

function PayloadServer:set_game_object_id(id)
	self._id = id
end

function PayloadServer:cb_game_session_disconnect()
	self._game = nil
end
