-- chunkname: @scripts/unit_extensions/human/base/states/human_onground.lua

require("scripts/unit_extensions/default_player_unit/states/player_movement_state_base")

HumanOnground = class(HumanOnground, PlayerMovementStateBase)

function HumanOnground:_can_activate_officer_buff(buff_index, t)
	local internal = self._internal
	local buff_type = internal.officer_buffs[buff_index]
	local buff_settings = Buffs[buff_type]

	return t > internal.anim_forced_upper_body_block and internal.player.is_corporal and buff_index ~= 0 and buff_settings and not internal.charging_officer_buff and not internal.activating_officer_buff and not internal.wielding and not internal.posing and not internal.swinging and not internal.attempting_pose and not internal.attempting_parry and not internal.aiming and not internal.parrying and not internal.blocking and not internal.reloading and not internal.ghost_mode
end

function HumanOnground:can_double_time()
	local internal = self._internal

	return not internal.double_time_recovery and not internal.crouching and not internal.swinging and not internal.attempting_parry and not internal.aiming and not internal.parrying and not internal.blocking
end

function HumanOnground:can_wield_weapon(slot_name, t)
	local internal = self._internal

	if t > internal.anim_forced_upper_body_block and not internal.wielding and not internal.posing and not internal.swinging and not internal.attempting_pose and not internal.attempting_parry and not internal.aiming and (not internal.swing_recovery_time or t > internal.swing_recovery_time) then
		local inventory = internal:inventory()

		if slot_name and inventory:can_wield(slot_name, internal.current_state_name) then
			return true
		end
	end

	return false
end

function HumanOnground:can_toggle_weapon(slot_name, t)
	local internal = self._internal

	if t > internal.anim_forced_upper_body_block and not internal.posing and not internal.swinging and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.ghost_mode then
		local inventory = internal:inventory()

		if slot_name and inventory:can_unwield(slot_name) and inventory:can_toggle(slot_name) then
			return true
		end
	end

	return false
end

function HumanOnground:can_attempt_pose_melee_weapon(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_melee_weapon_slot()

	if t > internal.anim_forced_upper_body_block and slot_name and not internal.wielding and not internal.posing and not internal.swinging and not internal.pose_ready and not internal.blocking and not internal.parrying and not internal.attempting_parry and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.ghost_mode then
		return true, slot_name
	end

	return false, nil
end

function HumanOnground:can_pose_melee_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_melee_weapon_slot()

	if slot_name and not internal.posing and not internal.swinging and internal.pose_ready and not internal.blocking and not internal.parrying and not internal.attempting_parry and not internal.ghost_mode then
		return true, slot_name
	end

	return false, nil
end

function HumanOnground:can_swing_melee_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.pose_slot_name

	if internal.posing and not internal.swinging and not internal.crouching and slot_name and inventory:is_wielded(slot_name) then
		return true, slot_name
	end

	return false, nil
end

function HumanOnground:can_shield_bash(t)
	local internal = self._internal

	return t > internal.shield_bash_cooldown and t > internal.anim_forced_upper_body_block and internal.blocking and internal:has_perk("shield_bash") and not internal.ghost_mode
end

function HumanOnground:can_push(t)
	local internal = self._internal

	return t > internal.push_cooldown and t > internal.anim_forced_upper_body_block and internal.parrying and internal:has_perk("push") and not internal.ghost_mode
end

function HumanOnground:can_call_horse(unit, t)
	local internal = self._internal
	local owned_mount = internal.owned_mount_unit
	local mount_locomotion = Unit.alive(owned_mount) and ScriptUnit.extension(owned_mount, "locomotion_system")
	local mount_stolen = mount_locomotion and Unit.get_data(owned_mount, "user_unit")

	return internal:has_perk("cavalry") and internal._player_profile.mount and not mount_stolen and not internal.call_horse_release_button and t >= internal.call_horse_blackboard.cooldown_time and not internal.posing and not internal.swinging and not internal.wielding and not internal.blocking and not internal.parrying and not internal.reloading and not internal.attempting_pose and not internal.attempting_parry and not internal.aiming and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.ghost_mode
end

function HumanOnground:can_mount(t)
	local internal = self._internal

	return not internal.posing and not internal.swinging and not internal.wielding and not internal.blocking and not internal.parrying and not internal.reloading and not internal.attempting_pose and not internal.attempting_parry and not internal.aiming and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.ghost_mode
end

function HumanOnground:can_rush(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local enc = inventory:encumbrance()
	local max_stamina = self:_max_stamina(internal, enc)

	return internal:has_perk("man_at_arms") and not internal.wielding and not internal.attempting_parry and not internal.blocking and not internal.parrying and not internal.aiming and t > internal.rush_cooldown_time and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.reloading and max_stamina <= internal.rush_stamina
end

local EPSILON = 0.01

function HumanOnground:_double_time_speed()
	local internal = self._internal
	local inventory = self._internal:inventory()
	local enc = inventory:encumbrance()

	if internal:has_perk("runner") then
		local perk = Perks.runner

		return PlayerUnitMovementSettings.double_time.move_speed * perk.move_speed_multiplier * PlayerUnitMovementSettings.encumbrance.functions.double_time_speed(enc)
	else
		return PlayerUnitMovementSettings.double_time.move_speed * PlayerUnitMovementSettings.encumbrance.functions.double_time_speed(enc)
	end
end

function HumanOnground:_max_speed()
	local internal = self._internal
	local max_speed = self:_double_time_speed()
	local unit = internal.unit

	if ScriptUnit.has_extension(unit, "area_buff_system") then
		max_speed = max_speed * ScriptUnit.extension(unit, "area_buff_system"):buff_multiplier("march_speed")
	end

	return max_speed + EPSILON
end

function HumanOnground:can_jump(t)
	local internal = self._internal

	return not internal.ghost_mode and not internal.aiming and not internal.posing and not internal.swinging and not internal.crouching and not internal.wielding and not internal.reloading and not internal.blocking and not internal.parrying and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and Vector3.length(internal.speed:unbox()) < self:_max_speed()
end

function HumanOnground:can_revive(t)
	local internal = self._internal

	return InteractionHelper:can_request("revive", internal) and self:_can_interact(t)
end

function HumanOnground:can_abort_melee_swing()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.swing_slot_name

	if internal.swinging and slot_name and inventory:is_wielded(slot_name) then
		return true, slot_name
	end

	return false, nil
end

function HumanOnground:can_aim_ranged_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_ranged_weapon_slot()

	if slot_name then
		local gear = inventory:_gear(slot_name)
		local extensions = gear:extensions()
		local weapon_ext = extensions and extensions.base
		local weapon_can_aim = true

		if weapon_ext then
			weapon_can_aim = weapon_ext:can_aim()
		end

		local t = Managers.time:time("game")

		if t > internal.anim_forced_upper_body_block and not internal.wielding and not internal.reloading and not internal.ghost_mode and weapon_can_aim then
			return true, slot_name
		end
	end

	return false, nil
end

function HumanOnground:can_unaim_ranged_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.aim_slot_name

	if internal.aiming and slot_name and inventory:is_wielded(slot_name) then
		return true, slot_name
	end

	return false, nil
end

function HumanOnground:can_fire_ranged_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.aim_slot_name

	if internal.aiming and not internal.reloading and slot_name and inventory:is_wielded(slot_name) and not internal.ghost_mode then
		local gear = inventory:_gear(slot_name)
		local extensions = gear:extensions()
		local weapon_ext = extensions.base

		if weapon_ext:can_fire() then
			return true, slot_name
		end
	end

	return false, nil
end

function HumanOnground:can_reload(slot_name, aim_input)
	local internal = self._internal
	local inventory = internal:inventory()
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base
	local weapon_category = weapon_ext:category()
	local t = Managers.time:time("game")

	if t > internal.anim_forced_upper_body_block and inventory:can_reload(slot_name) and (weapon_category ~= "crossbow" or aim_input) and (weapon_category == "bow" or not internal.aiming) and not internal.wielding and not internal.ghost_mode then
		return true
	end

	return false
end

function HumanOnground:can_raise_block(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_block_slot()
	local block_type = slot_name and inventory:block_type(slot_name)

	if t > internal.anim_forced_upper_body_block and block_type and (not internal.swinging or t < internal.swing_abort_time) and (not internal.swing_parry_recovery_time or t > internal.swing_parry_recovery_time) and (block_type == "shield" or block_type == "buckler" or not internal.wielding and not internal.block_broken) and (block_type ~= "shield" and block_type ~= "buckler" or not internal.swing_recovery_time or not (t < internal.swing_recovery_time)) and not internal.ghost_mode then
		return true, slot_name
	end

	return false, nil
end

function HumanOnground:can_lower_block()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.block_slot_name

	if (internal.blocking or internal.parrying) and slot_name and inventory:is_wielded(slot_name) then
		return true, slot_name
	end

	return false, nil
end

function HumanOnground:can_crouch(t)
	local internal = self._internal

	return not internal.posing and not internal.swinging and not internal.blocking and not internal.parrying and not internal.attempting_parry and not internal.attempting_pose and not internal.aiming and not internal.wielding and not internal.reloading and (not internal.swing_recovery_time or t > internal.swing_recovery_time)
end

function HumanOnground:can_pickup_flag()
	local internal = self._internal

	return not internal.carried_flag and not internal.picking_flag and not internal.ghost_mode
end

function HumanOnground:can_drop_flag()
	local internal = self._internal

	return internal.carried_flag
end

function HumanOnground:can_plant_flag()
	local internal = self._internal

	return internal.carried_flag
end

function HumanOnground:_can_interact(t)
	local internal = self._internal

	return not internal.posing and not internal.swinging and not internal.blocking and not internal.parrying and not internal.attempting_parry and not internal.attempting_pose and not internal.aiming and not internal.wielding and not internal.reloading and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.interacting and not internal.ghost_mode
end

function HumanOnground:can_climb(t)
	local internal = self._internal

	return not internal.posing and not internal.swinging and not internal.blocking and not internal.parrying and not internal.attempting_parry and not internal.attempting_pose and not internal.aiming and not internal.wielding and not internal.reloading and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.interacting
end

function HumanOnground:can_execute(t)
	local internal = self._internal

	return InteractionHelper:can_request("execute", internal) and self:_can_interact(t)
end

function HumanOnground:can_bandage(t)
	local internal = self._internal

	return InteractionHelper:can_request("bandage", internal) and self:_can_interact(t) and not internal:has_perk("oblivious")
end

function HumanOnground:can_trigger(t)
	local internal = self._internal

	return InteractionHelper:can_request("trigger", internal) and self:_can_interact(t)
end
