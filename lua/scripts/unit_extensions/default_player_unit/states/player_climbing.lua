-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_climbing.lua

require("scripts/unit_extensions/default_player_unit/states/player_movement_state_base")

PlayerClimbing = class(PlayerClimbing, PlayerMovementStateBase)

local BUTTON_THRESHOLD = 0.5
local LADDER_ROOT_POINT_OFFSET = 0.5
local LADDER_STEP_LENGTH = 1
local LADDER_STEP_TIME = 1.6663333333333334
local LADDER_BOTTOM_POS_OFFSET = -0.085
local LADDER_EXIT_TIME = 1.9666666666666666
local ALLOWED_LADDER_POSES = {
	0,
	0.25,
	0.5,
	0.75
}
local LADDER_IDLE = {
	"climb_idle_right",
	"climb_idle_mid",
	"climb_idle_left",
	"climb_idle_mid"
}

function PlayerClimbing:init(unit, internal, world)
	PlayerClimbing.super.init(self, unit, internal, world)

	self._unit = unit
	self._internal = internal
	self._ladder_unit = nil
	self._interaction_type = "climb"
	self._ladder_anim_var = Unit.animation_find_variable(unit, "climb_time")
	self._ladder_exit_anim_var = Unit.animation_find_variable(unit, "climb_enter_exit_speed")
	self._transition = nil
end

function PlayerClimbing:stun()
	return
end

function PlayerClimbing:update(dt, t)
	PlayerClimbing.super.update(self, dt, t)
	self:update_aim_rotation(dt, t)
	self:update_movement(dt, t)
	self:_update_tagging(dt, t)

	local interact = self._controller and self._controller:get("interact")

	if interact and not self._transition then
		self._transition = "onground"
	end

	if self._transition then
		self:change_state(self._transition)
	end
end

function PlayerClimbing:_calculate_move_dir(dt, t)
	local move = self._controller and self._controller:get("move") or Vector3(0, 0, 0)

	return move.y
end

function PlayerClimbing:update_movement(dt, t)
	local unit = self._unit
	local old_pos = Unit.local_position(self._unit, 0)
	local ladder_unit = self._ladder_unit
	local ladder_bottom_index = Unit.node(ladder_unit, "ladder_bottom")
	local ladder_bottom_rot = Unit.world_rotation(ladder_unit, ladder_bottom_index)
	local ladder_up_dir = Quaternion.up(ladder_bottom_rot)
	local wanted_move_dir = self:_calculate_move_dir(dt, t)
	local enc = self._internal:inventory():encumbrance()
	local speed = self:_interaction_settings().speed * PlayerUnitMovementSettings.encumbrance.functions.climbing_ladders_speed(enc)
	local ladder_pos, ladder_anim_factor
	local last_move_dir = self._last_move_dir
	local wants_to_move = math.abs(wanted_move_dir) > BUTTON_THRESHOLD

	if self._exiting then
		self:_update_movement_top_enter_exit(unit, dt)

		self._last_dt = dt
		self._last_move_dir = 1

		return
	elseif self._top_enter then
		self:_update_movement_top_enter_exit(unit, dt)

		self._last_dt = dt
		self._last_move_dir = -1

		return
	elseif self._idle and not wants_to_move then
		self._internal.velocity:store(Vector3(0, 0, 0))
		self:update_lerped_rotation(dt)

		return
	elseif not wants_to_move then
		local dir = math.sign(last_move_dir)
		local old_ladder_pos, old_ladder_factor, old_exiting = self:_calculate_ladder_pos(old_pos)
		local old_allowed_ladder_pose = self._old_allowed_ladder_pose or self:_calculate_allowed_ladder_pose(old_ladder_factor, dir)

		self._old_allowed_ladder_pose = old_allowed_ladder_pose

		local wanted_ladder_delta = ladder_up_dir * self._last_move_dir * speed * dt
		local wanted_new_pos = old_pos + wanted_ladder_delta
		local wanted_ladder_pos, wanted_ladder_anim_factor, exiting = self:_calculate_ladder_pos(wanted_new_pos)
		local wanted_allowed_ladder_pose = self:_calculate_allowed_ladder_pose(wanted_ladder_anim_factor, dir)

		if old_allowed_ladder_pose == wanted_allowed_ladder_pose then
			ladder_pos = wanted_ladder_pos
			ladder_anim_factor = wanted_ladder_anim_factor
		else
			self._exiting = false
			self._old_allowed_ladder_pose = nil
			self._idle = true

			self:anim_event(LADDER_IDLE[old_allowed_ladder_pose])

			self._last_move_dir = 0
			ladder_pos = old_ladder_pos
			ladder_anim_factor = ALLOWED_LADDER_POSES[old_allowed_ladder_pose]
		end
	else
		self._old_allowed_ladder_pose = nil

		local ladder_delta = ladder_up_dir * wanted_move_dir * speed * dt

		self._last_move_dir = wanted_move_dir

		local new_pos = old_pos + ladder_delta
		local exiting

		ladder_pos, ladder_anim_factor, exiting = self:_calculate_ladder_pos(new_pos)

		if exiting and wanted_move_dir > 0 then
			self._last_dt = dt

			self:_enter_exiting()
		end

		if self._idle and not exiting then
			self._exiting = false

			self:anim_event("climb_move")

			self._idle = false
		end
	end

	local ladder_anim_val = LADDER_STEP_TIME * ladder_anim_factor

	Unit.animation_set_variable(self._unit, self._ladder_anim_var, ladder_anim_val)

	if script_data.climbing_debug then
		Managers.state.debug_text:output_screen_text("LADDER ANIM VAL:" .. string.format("%2.2f", ladder_anim_val) .. " EXITING: " .. tostring(self._exiting), 40)
	end

	local mover = Unit.mover(unit)
	local delta_pos = ladder_pos - old_pos

	Mover.move(mover, delta_pos, dt)

	local mover_pos = Mover.position(mover)

	self._internal.velocity:store(ladder_up_dir * wanted_move_dir * speed)
	self:set_local_position(mover_pos)
	self:set_target_world_rotation(ladder_bottom_rot)
	self:update_lerped_rotation(dt)
end

ClimbHelper = ClimbHelper or {}

function ClimbHelper.ladder_anim_val(distance)
	return LADDER_STEP_TIME * ((distance + LADDER_BOTTOM_POS_OFFSET) % LADDER_STEP_LENGTH / LADDER_STEP_LENGTH)
end

function PlayerClimbing:anim_cb_climb_exit_finished()
	if self._top_enter then
		self._top_enter = false

		self:anim_event("climb_move")
	elseif self._exiting then
		self._transition = "onground"
	end
end

function PlayerClimbing:_enter_exiting()
	self._exiting = true
	self._exiting_accumulated_error = Vector3Box()

	local enc = self._internal:inventory():encumbrance()
	local speed = self:_interaction_settings().speed * PlayerUnitMovementSettings.encumbrance.functions.climbing_ladders_speed(enc)

	self:anim_event_with_variable_float("climb_top_exit", "climb_enter_exit_speed", speed * 2)
end

function PlayerClimbing:_update_movement_top_enter_exit(unit, dt)
	local internal = self._internal
	local mover = Unit.mover(unit)
	local wanted_pose = Unit.animation_wanted_root_pose(unit)
	local wanted_position = Matrix4x4.translation(wanted_pose) + self._exiting_accumulated_error:unbox()
	local current_position = Unit.local_position(unit, 0)
	local velocity = internal.velocity:unbox()
	local speed = Vector3.length(velocity)
	local anim_delta = wanted_position - current_position

	Mover.move(mover, anim_delta, dt)

	local final_position = Mover.position(mover)

	internal.velocity:store(anim_delta / self._last_dt)
	self._exiting_accumulated_error:store(wanted_position - final_position)
	self:set_local_position(final_position)

	if self._top_enter and false then
		local wanted_delta_rot = Quaternion.multiply(Quaternion.inverse(Unit.local_rotation(unit, 0)), Matrix4x4.rotation(wanted_pose))
		local rot = Quaternion.multiply(self._enter_top_target_rot:unbox(), wanted_delta_rot)

		self:set_target_world_rotation(rot)
		self._enter_top_target_rot:store(rot)
	else
		self:set_world_rotation(Matrix4x4.rotation(wanted_pose))
		self:update_lerped_rotation(dt)
	end
end

function PlayerClimbing:_calculate_allowed_ladder_pose(wanted_ladder_anim_factor, dir)
	if dir > 0 then
		for i = 1, #ALLOWED_LADDER_POSES do
			local val = ALLOWED_LADDER_POSES[i]

			if wanted_ladder_anim_factor <= val then
				return i
			end
		end

		return 1
	else
		for i = #ALLOWED_LADDER_POSES, 1, -1 do
			local val = ALLOWED_LADDER_POSES[i]

			if val <= wanted_ladder_anim_factor then
				return i
			end
		end

		return #ALLOWED_LADDER_POSES
	end
end

function PlayerClimbing:_interaction_settings()
	return PlayerUnitMovementSettings.interaction.settings[self._interaction_type]
end

function PlayerClimbing:enter(old_state, ladder_unit)
	PlayerClimbing.super.enter(self, old_state)

	local internal = self._internal

	self._ladder_unit = ladder_unit

	local ladder_bottom_index = Unit.node(ladder_unit, "ladder_bottom")
	local ladder_bottom_rot = Unit.world_rotation(ladder_unit, ladder_bottom_index)
	local unit = self._unit
	local pos, value, exiting = self:_calculate_ladder_pos(Unit.local_position(self._unit, 0))

	self._last_move_dir = 1

	if exiting then
		self:_start_top_enter(ladder_bottom_rot)
	else
		self:set_local_position(pos)
		self:update_aim_rotation()
		self:set_target_world_rotation(ladder_bottom_rot)
		self:anim_event("climb_enter")
	end

	self:synch_ladder_unit()
	internal:inventory():set_faux_unwielded(true)
end

function PlayerClimbing:synch_ladder_unit(peer)
	local internal = self._internal
	local network_manager = Managers.state.network
	local ladder_unit = self._ladder_unit

	if internal.game and internal.id then
		local ladder_lvl_id = network_manager:level_object_id(ladder_unit)

		if peer then
			RPC.rpc_climb_ladder(peer, internal.id, ladder_lvl_id)
		else
			network_manager:send_rpc_server("rpc_climb_ladder", internal.id, ladder_lvl_id)
		end
	end
end

function PlayerClimbing:_start_top_enter(ladder_bottom_rot)
	self._top_enter = true
	self._last_dt = Managers.time:mean_dt()

	local ladder = self._ladder_unit
	local node = Unit.node(ladder, "character_start")
	local pos = Unit.world_position(ladder, node)
	local rot = Unit.world_rotation(ladder, node)

	Mover.set_position(Unit.mover(self._unit), pos)
	self:set_local_position(pos)
	self:update_aim_rotation()
	self:set_target_world_rotation(rot)

	self._enter_top_target_rot = QuaternionBox(rot)

	self:_set_rotation(rot)

	if script_data.climb_debug then
		Managers.state.debug:drawer({
			mode = "retained"
		}):quaternion(pos, rot)
	end

	self._exiting_accumulated_error = Vector3Box()

	local enc = self._internal:inventory():encumbrance()
	local speed = self:_interaction_settings().speed * PlayerUnitMovementSettings.encumbrance.functions.climbing_ladders_speed(enc)

	self:anim_event_with_variable_float("climb_top_enter", "climb_enter_exit_speed", speed * 2)
end

function PlayerClimbing:_calculate_ladder_pos(player_pos)
	local ladder_unit = self._ladder_unit
	local ladder_top_index = Unit.node(ladder_unit, "ladder_top")
	local ladder_bottom_index = Unit.node(ladder_unit, "ladder_bottom")
	local ladder_bottom_rot = Unit.world_rotation(ladder_unit, ladder_bottom_index)
	local ladder_bottom_pos = Unit.world_position(ladder_unit, ladder_bottom_index)
	local ladder_top_pos = Unit.world_position(ladder_unit, ladder_top_index)
	local ladder_up_dir = Quaternion.up(ladder_bottom_rot)
	local ladder_length = Vector3.dot(ladder_top_pos - ladder_bottom_pos, ladder_up_dir)
	local ladder_dist = math.clamp(Vector3.dot(player_pos - ladder_bottom_pos, ladder_up_dir) + LADDER_BOTTOM_POS_OFFSET, 0, ladder_length)
	local exit_value = ladder_dist - (ladder_length - LADDER_STEP_LENGTH * 1.5)
	local exiting = exit_value > -0.5
	local ladder_anim_factor = ladder_dist % LADDER_STEP_LENGTH / LADDER_STEP_LENGTH
	local player_ladder_pos = ladder_bottom_pos + (ladder_dist - LADDER_BOTTOM_POS_OFFSET) * ladder_up_dir
	local ladder_forward_dir = Quaternion.forward(ladder_bottom_rot)
	local extruded_ladder_pos = player_ladder_pos - ladder_forward_dir * LADDER_ROOT_POINT_OFFSET

	return extruded_ladder_pos, ladder_anim_factor, exiting
end

function PlayerClimbing:exit(new_state)
	PlayerClimbing.super.exit(self, new_state)

	local internal = self._internal
	local unit = self._unit
	local pos = Unit.local_position(unit, 0)
	local mover = Unit.mover(unit)

	Mover.set_position(mover, pos)

	self._idle = false
	self._ladder_unit = nil
	self._exiting = false
	self._top_enter = false
	self._transition = nil

	self._internal.speed:store(Vector3(0, self._last_move_dir, 0))
	self:anim_event("climb_end")
	internal:inventory():set_faux_unwielded(false)
end

function PlayerClimbing:destroy()
	return
end
