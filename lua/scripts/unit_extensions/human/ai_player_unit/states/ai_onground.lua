-- chunkname: @scripts/unit_extensions/human/ai_player_unit/states/ai_onground.lua

require("scripts/unit_extensions/human/base/states/human_onground")

AIOnground = class(AIOnground, HumanOnground)

local function swing_dir_to_target_pose(swing_dir)
	if swing_dir == "right" then
		return 1, 0
	elseif swing_dir == "left" then
		return -1, 0
	elseif swing_dir == "up" then
		return 0, 1
	elseif swing_dir == "down" then
		return 0, -1
	else
		ferror("Incorrect swing direction %q", swing_dir)
	end
end

function AIOnground:init(unit, internal)
	AIOnground.super.init(self, unit, internal)

	self._level = LevelHelper:current_level(self._internal.world)
end

function AIOnground:finalize(profile)
	self._ai_props = profile.properties
end

function AIOnground:enter()
	return
end

function AIOnground:melee_attack(swing_direction, charge_time)
	local internal = self._internal

	internal.pose_direction = swing_direction
	self._charge_time = charge_time
	self._charge_done = false
	internal.melee_attack = true

	internal:set_pose_blends(0, 0)
	self:anim_event("swing_pose_blend")
end

function AIOnground:swing_finished()
	AIOnground.super.swing_finished(self)

	self._internal.melee_attack = false
end

function AIOnground:ranged_attack(draw_time)
	self._draw_time = draw_time
	self._internal.ranged_attack = true
end

function AIOnground:wield_weapon(slot_name)
	self._slot_name = slot_name
	self._internal.wield_new_weapon = true
end

function AIOnground:block_attack(direction, attacking_units_locomotion)
	self._direction_to_block = direction
	self._attacking_units_locomotion = attacking_units_locomotion
	self._internal.block_or_parry = true
end

function AIOnground:crouch()
	self._internal.start_or_stop_crouch = true
end

function AIOnground:update(dt, t)
	local internal = self._internal

	internal:update_locomotion(t, dt)
	self:_update_weapons(t, dt)

	if self._ai_props.tethered == true then
		self:_update_tether(t, dt)
	end

	if self._internal.start_or_stop_crouch then
		self:_update_crouch(t, dt)
	end
end

function AIOnground:_update_weapons(t, dt)
	local internal = self._internal

	if internal.swing_recovery_time and t > internal.swing_recovery_time then
		self:_end_swing_recovery()
	end

	if internal.melee_attack then
		self:_update_swing(t, dt)
	end

	self:_update_ranged_weapons(t, dt)

	if internal.wield_new_weapon then
		if internal.aiming then
			self:_unaim_ranged_weapon()
		end

		self:_update_weapon_wield(t, dt)
	end

	if internal.block_or_parry then
		self:_update_block(t, dt)
	end
end

function AIOnground:_update_tether(t, dt)
	local unit = self._unit
	local mover = Unit.mover(unit)
	local position = Mover.position(mover)
	local internal = self._internal
	local in_movement_area = Level.is_point_inside_volume(self._level, self._ai_props.movement_area, position)

	internal.in_movement_area = in_movement_area

	if not in_movement_area then
		internal.tether_timer = internal.tether_timer - dt
	elseif in_movement_area then
		internal.tether_timer = self._ai_props.tether_time
	end

	internal.unit_in_spawn = Level.is_point_inside_volume(self._level, self._ai_props.spawn_area, position)
end

function AIOnground:_update_crouch(t, dt)
	local internal = self._internal

	if internal.crouching then
		self:_abort_crouch()
	elseif self:can_crouch(t) then
		self:safe_action_interrupt("crouch")
		self:_crouch()
	end

	internal.start_or_stop_crouch = false
end

function AIOnground:_update_swing(t, dt)
	local can_pose, slot_name = self:can_pose_melee_weapon()

	if self:can_attempt_pose_melee_weapon(t) then
		self:_update_pose_attempt(dt)
	elseif can_pose then
		self:_pose_melee_weapon(slot_name, t)
	elseif self:can_swing_melee_weapon() and self._charge_done then
		self:_swing_melee_weapon(t)
	elseif self._internal.posing then
		self:_update_charge(dt, t)
	end
end

function AIOnground:_update_pose_attempt(dt)
	local internal = self._internal

	internal.attempting_pose = true
	internal.pose_progress_time = internal.pose_progress_time + 0.8 * dt

	local pose_x_val, pose_y_val = internal:get_pose_blends()
	local target_pose_x, target_pose_y = swing_dir_to_target_pose(internal.pose_direction)

	pose_x_val = math.lerp(0, target_pose_x, internal.pose_progress_time^4)
	pose_y_val = math.lerp(0, target_pose_y, internal.pose_progress_time^4)

	local inventory = internal:inventory()
	local slot_name = inventory:wielded_melee_weapon_slot()
	local gear_settings = inventory:gear_settings(slot_name)
	local proportion_x = pose_x_val > 0 and pose_x_val / gear_settings.attacks.right.normal_swing_pose_anim_blend_value or pose_x_val / gear_settings.attacks.left.normal_swing_pose_anim_blend_value
	local proportion_y = pose_y_val > 0 and pose_y_val / gear_settings.attacks.up.normal_swing_pose_anim_blend_value or pose_y_val / gear_settings.attacks.down.normal_swing_pose_anim_blend_value

	self._internal:set_pose_blends(pose_x_val, pose_y_val)

	if math.abs(proportion_x) + math.abs(proportion_y) >= 1 then
		internal.pose_ready = true
		internal.attempting_pose = false
		internal.pose_progress_time = 0
		self._current_pose_x = pose_x_val
		self._current_pose_y = pose_y_val
		self._target_pose_x = target_pose_x
		self._target_pose_y = target_pose_y
		self._charge_time_end = Managers.state.entity_system.t + self._charge_time
	end
end

function AIOnground:_update_charge(dt, t)
	if t >= self._charge_time_end then
		self._charge_done = true
	end
end

function AIOnground:_update_ranged_weapons(t, dt)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_ranged_weapon_slot()

	if slot_name then
		local gear = inventory:_gear(slot_name)
		local gear_extension = gear:extensions().base

		if internal.reloading and gear_extension:loaded() then
			self:_finish_reloading_weapon(true)
		elseif gear_extension:loaded() and internal.ranged_attack then
			if not internal.aiming then
				if self:can_aim_ranged_weapon() then
					self._draw_time_end = self._draw_time + t

					self:_aim_ranged_weapon(slot_name, t)
				end
			elseif self:can_fire_ranged_weapon() and t >= self._draw_time_end then
				self:_fire_ranged_weapon(t)
				self:_unaim_ranged_weapon()

				internal.ranged_attack = false
			end
		elseif not gear_extension:loaded() and self:can_reload(slot_name) then
			if internal.reloading then
				gear_extension:update_reload(dt, t)
			else
				self:_start_reloading_weapon(dt, t, slot_name)
			end
		elseif internal.reloading then
			self:_finish_reloading_weapon(false)
		end
	end
end

function AIOnground:can_reload(slot_name, aim_input)
	local internal = self._internal
	local inventory = internal:inventory()

	if inventory:can_reload(slot_name) and not internal.wielding then
		return true
	end

	return false
end

function AIOnground:_update_weapon_wield(t, dt)
	local slot_name = self._slot_name

	if self:can_wield_weapon(slot_name, t) then
		self:safe_action_interrupt("wield")
		self:_wield_weapon(slot_name)
	end

	self._internal.wield_new_weapon = false
end

function AIOnground:_update_block(t, dt)
	local can_raise, slot_name = self:can_raise_block(t)
	local block_type

	if can_raise then
		local inventory = self._internal:inventory()

		block_type = inventory:block_type(slot_name)

		if block_type == "shield" then
			self:safe_action_interrupt("block")
			self:_raise_shield_block(slot_name)
		elseif block_type == "buckler" or block_type == "weapon" then
			self:_raise_parry_block(slot_name, block_type, self._direction_to_block)
		else
			ferror("AIOnground:_update_block() Invalid block type: %q", block_type)
		end

		self._internal.block_start_time = t
	end

	if not self._attacking_units_locomotion.posing and not self._attacking_units_locomotion.swinging and not self._attacking_units_locomotion.aiming then
		self:_lower_block()
	end
end

function AIOnground:can_raise_block(t, dt)
	local can_raise, slot_name = AIOnground.super.can_raise_block(self, t, dt)

	can_raise = can_raise and not self._internal.melee_attack

	return can_raise, slot_name
end

function AIOnground:_crouch()
	self:anim_event("to_crouch")

	self._internal.crouching = true
end

function AIOnground:_abort_pose()
	AIOnground.super._abort_pose(self)

	self._internal.melee_attack = false
end

function AIOnground:post_update(dt, t)
	return
end
