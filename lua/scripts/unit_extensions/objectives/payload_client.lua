-- chunkname: @scripts/unit_extensions/objectives/payload_client.lua

require("scripts/unit_extensions/objectives/payload_base")

PayloadClient = class(PayloadClient, PayloadBase)
PayloadClient.CLIENT_ONLY = true
PayloadClient.SYSTEM = "objective_system"

local FRAMES = 100

function PayloadClient:init(world, unit)
	self._world = world
	self._unit = unit
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

	self._last_synched_spline_values = {
		last_synch_time = 0,
		error_compensation_speed = 0,
		spline_index = 1,
		subdivision_index = 1,
		spline_t = 0
	}
	self._state = "stopped"
end

function PayloadClient:event_start_round(params)
	self:_init_teams()
end

function PayloadClient:event_round_started(params)
	return
end

function PayloadClient:flow_cb_add_player_unit(unit)
	return
end

function PayloadClient:flow_cb_remove_player_unit(unit)
	return
end

function PayloadClient:_init_teams()
	local teams = Managers.state.team:sides()
	local active_sides = self._blackboard.active_team_sides

	for _, team in pairs(teams) do
		active_sides[team] = false
	end
end

local WHEEL_DIAMETER = 0.108
local WHEEL_CIRCUMFERENCE = WHEEL_DIAMETER * math.pi
local ANIM_SPEED = 30 / FRAMES / WHEEL_CIRCUMFERENCE
local ERROR_RECOUP_TIME = 0.5

function PayloadClient:_error_speed_calculation(dt, t, game, id, movement)
	local spline_index = GameSession.game_object_field(game, id, "spline_index")
	local subdiv = GameSession.game_object_field(game, id, "subdivision_index")
	local spline_t = GameSession.game_object_field(game, id, "spline_t")
	local old_vals = self._last_synched_spline_values

	if old_vals.spline_index ~= spline_index or old_vals.subdivision_index ~= subdiv or old_vals.spline_t ~= spline_t then
		local curr_spline_index = movement:current_spline_index()
		local curr_subdivision_index = movement:current_subdivision_index()
		local curr_spline_t = movement:current_t()
		local error_distance = movement:distance(curr_spline_index, curr_subdivision_index, curr_spline_t, spline_index, subdiv, spline_t)

		old_vals.spline_index = spline_index
		old_vals.subdivision_index = subdiv
		old_vals.spline_t = spline_t
		old_vals.error_compensation_speed = error_distance / ERROR_RECOUP_TIME
		old_vals.last_synch_time = t
	elseif t - old_vals.last_synch_time >= ERROR_RECOUP_TIME then
		old_vals.error_compensation_speed = 0
	end

	return old_vals.error_compensation_speed
end

local MOVING_THRESHOLD = 0.1

function PayloadClient:update(unit, input, dt, context, t)
	local game = Managers.state.network:game()
	local id = self._id

	if id and game then
		local movement = self._spline_curve:movement()
		local error_compensation_speed = self:_error_speed_calculation(dt, t, game, id, movement)
		local speed = GameSession.game_object_field(game, id, "speed") + error_compensation_speed

		movement:set_speed(speed, movement)
		movement:update(dt, t)

		if self._state ~= "stopped" and math.abs(speed) < MOVING_THRESHOLD then
			self._state = "stopped"

			Unit.flow_event(unit, "lua_stopped")
		elseif self._state ~= "moving" and math.abs(speed) >= MOVING_THRESHOLD then
			self._state = "moving"

			Unit.flow_event(unit, "lua_moving")
		end

		Unit.set_local_position(unit, 0, movement:current_position())
		Unit.set_local_rotation(unit, 0, Quaternion.look(movement:current_tangent_direction(), Vector3.up()))
		Unit.set_simple_animation_speed(self._unit, speed / ANIM_SPEED, "movement")

		local owner = NetworkLookup.team[GameSession.game_object_field(game, self._id, "owner")]

		if not self:owned(owner) then
			self:set_owner(owner)
		end

		local active_sides = self._blackboard.active_team_sides

		for _, team in pairs(Managers.state.team:sides()) do
			local active = GameSession.game_object_field(game, self._id, team .. "_active")

			if not self:active(team) then
				self:set_active(team, active)
			end
		end
	end

	if script_data.payload_debug then
		self:debug_draw_collision()
	end
end

local OVERLAP_HALF_WIDTH = 0.6
local OVERLAP_HALF_DEPTH = 1.6
local OVERLAP_HALF_HEIGHT = 0.8

function PayloadClient:debug_draw_collision()
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
end

function PayloadClient:set_active(team_side, active)
	local no_active_before = true
	local no_active_after = true
	local sides = Managers.state.team:sides()

	for _, team_side in pairs(sides) do
		no_active_before = no_active_before and not self:active(team_side)
	end

	self._blackboard.active_team_sides[team_side] = active

	for _, team_side in pairs(sides) do
		no_active_after = no_active_after and not self:active(team_side)
	end

	if active and no_active_before then
		Managers.state.event:trigger("objective_activated", self._blackboard, self._unit)
	elseif not active and no_active_after then
		Managers.state.event:trigger("objective_deactivated", self._unit)
	end
end

function PayloadClient:set_game_object_id(id, game)
	self._id = id
	self._game = game

	if id == nil then
		self._spline_curve:movement():set_speed(0)
	else
		local spline_index = GameSession.game_object_field(game, id, "spline_index")
		local subdivision_index = GameSession.game_object_field(game, id, "subdivision_index")
		local spline_t = GameSession.game_object_field(game, id, "spline_t")
		local speed = GameSession.game_object_field(game, id, "speed")
		local movement = self._spline_curve:movement()

		movement:set_spline_index(spline_index, subdivision_index, spline_t)
		movement:set_speed(speed)
	end
end

function PayloadClient:destroy()
	return
end

function PayloadClient:set_owner(owner)
	Unit.set_flow_variable(self._unit, "owner", owner)

	self._blackboard.owner_team_side = owner
end

function PayloadClient:active(side)
	return self._blackboard.active_team_sides[side]
end

function PayloadClient:owned(side)
	return self._blackboard.owner_team_side == side
end
