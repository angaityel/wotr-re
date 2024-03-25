-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_stunned.lua

require("scripts/unit_extensions/default_player_unit/states/player_movement_state_base")

PlayerStunned = class(PlayerStunned, PlayerMovementStateBase)

function PlayerStunned:update(dt, t)
	PlayerStunned.super.update(self, dt, t)
	self:update_aim_rotation(dt, t)
	self:update_speed(dt, t)
	self:update_movement(dt, t)
	self:update_transitions(dt, t)
end

function PlayerStunned:update_movement(dt, t)
	local final_position, wanted_animation_pose = PlayerMechanicsHelper:animation_driven_update_movement(self._unit, self._internal, dt, false)

	self:set_local_position(final_position)
end

function PlayerStunned:update_speed(dt, t)
	local internal = self._internal
	local target_speed

	if self._stun_type == "rooted" then
		target_speed = Vector3(0, 0, 0)
	elseif self._stun_type == "moving" then
		target_speed = self._controller and self._controller:get("move") or Vector3(0, 0, 0)
	else
		target_speed = Vector3.lerp(internal.speed:unbox(), Vector3(0, 0, 0), dt * 3)
	end

	local encumbrance = internal:inventory():encumbrance()
	local speed = self:_calculate_speed(dt, internal.speed:unbox(), target_speed, encumbrance)
	local move_length = Vector3.length(speed)
	local move_speed = move_length * self:_move_speed()

	internal.move_speed = move_speed

	internal.speed:store(speed)
end

function PlayerStunned:_calculate_speed(dt, current_speed, target_speed, encumbrance)
	local x = current_speed.x
	local y = current_speed.y
	local internal = self._internal
	local acceleration_multiplier = internal:has_perk("fleet_footed") and Perks.fleet_footed.acceleration_multiplier or 1
	local encumbrance_factor = PlayerUnitMovementSettings.encumbrance.functions.movement_acceleration(encumbrance)
	local new_x = PlayerUnitMovementSettings.movement_acceleration(dt, current_speed.x, target_speed.x, encumbrance_factor, acceleration_multiplier)
	local new_y = PlayerUnitMovementSettings.movement_acceleration(dt, current_speed.y, target_speed.y, encumbrance_factor, acceleration_multiplier)
	local ret = Vector3(new_x, new_y, 0)

	return ret
end

local STUN_FORCE = 0.3
local MOUNTED_IMPACT_FAST_THRESHOLD = 3.6

function PlayerStunned:enter(old_state, hit_zone, impact_direction, impact_type)
	PlayerStunned.super.enter(self, old_state)
	self:safe_action_interrupt("stunned")

	local t = Managers.time:time("game")
	local animation_stun_time, animation_event, stun_type, stun_time

	if impact_type == "squad_spawn" then
		animation_event = "stun_spawn"
		stun_type = "rooted"
		stun_time = 1.65
	else
		stun_type = hit_zone == "legs" and "rooted" or not (hit_zone ~= "head" and hit_zone ~= "helmet") and "moving" or "forced"

		local camera_manager = Managers.state.camera

		camera_manager:camera_effect_sequence_event("stunned", t)
		camera_manager:camera_effect_shake_event("stunned", t)

		if impact_type == "mounted_stun_dismount" then
			animation_event, animation_stun_time = WeaponHelper:player_unit_stun_animation(self._unit, "mounted_stun_dismount", impact_direction)
		elseif impact_type == "shield_bash_impact" then
			animation_event, animation_stun_time = WeaponHelper:player_unit_stun_animation(self._unit, "shield_bash_impact", impact_direction)
		elseif impact_type == "push_impact" then
			animation_event, animation_stun_time = WeaponHelper:player_unit_stun_animation(self._unit, "push_impact", impact_direction)
		elseif impact_type == "rush_impact" then
			animation_event, animation_stun_time = WeaponHelper:player_unit_stun_animation(self._unit, "rush_impact", impact_direction)
		elseif impact_type == "mount_impact" then
			local mounted_impact_type = Vector3.length(impact_direction) > MOUNTED_IMPACT_FAST_THRESHOLD and "mount_impact_fast" or "mount_impact_slow"

			animation_event, animation_stun_time = WeaponHelper:player_unit_stun_animation(self._unit, mounted_impact_type, impact_direction)
		else
			animation_event, animation_stun_time = WeaponHelper:player_unit_stun_animation(self._unit, hit_zone, impact_direction)
		end

		stun_time = PlayerUnitMovementSettings.encumbrance.functions.stun_time(self._internal:inventory():encumbrance()) * animation_stun_time
	end

	self:anim_event_with_variable_float(animation_event, "stun_time", stun_time)

	self._stun_time = stun_time + Managers.time:time("game")

	local internal = self._internal
	local unit = internal.unit

	if stun_type == "forced" then
		local speed = internal.speed:unbox()
		local move_rot_local = internal.move_rotation_local:unbox()
		local move_rot = internal.move_rot:unbox()
		local rot = Quaternion.multiply(Quaternion.inverse(move_rot_local), move_rot)
		local impulse = Vector3(Vector3.dot(impact_direction, Quaternion.right(rot)), Vector3.dot(impact_direction, Quaternion.forward(rot)), 0)

		if impact_type == "mount_impact" then
			speed = speed + impulse
		else
			speed = Vector3.normalize(speed + impulse * STUN_FORCE)
		end

		internal.speed:store(speed)
	end

	self._stun_type = stun_type
end

function PlayerStunned:exit(new_state)
	PlayerStunned.super.exit(self, new_state)
	self:anim_event("stun_end")

	self._stun_time = nil
end

function PlayerStunned:update_transitions(dt, t)
	if t > self._stun_time then
		self:change_state("onground")
	end
end

function PlayerStunned:destroy()
	return
end
