-- chunkname: @scripts/unit_extensions/human/base/states/human_mounted.lua

require("scripts/unit_extensions/default_player_unit/states/player_movement_state_base")

HumanMounted = class(HumanMounted, PlayerMovementStateBase)

function HumanMounted:can_unmount(t)
	local internal = self._internal

	if (not internal.swing_recovery_time or t > internal.swing_recovery_time) and Managers.player:owner(internal.mounted_unit) and not internal.mounting and not internal.dismounting and not internal.ghost_mode then
		return true
	end

	return false
end

function HumanMounted:_can_activate_officer_buff(buff_index, t)
	local internal = self._internal
	local buff_type = internal.officer_buffs[buff_index]
	local buff_settings = Buffs[buff_type]

	return internal.player.is_corporal and buff_index ~= 0 and buff_settings and not internal.charging_officer_buff and not internal.activating_officer_buff and not internal.wielding and not internal.posing and not internal.swinging and not internal.attempting_pose and not internal.attempting_parry and not internal.aiming and not internal.parrying and not internal.blocking and not internal.reloading and not internal.mounting and not internal.dismounting and not internal.ghost_mode
end

function HumanMounted:can_wield_weapon(slot_name, t)
	local internal = self._internal

	if not internal.wielding and not internal.posing and not internal.crouching and not internal.swinging and not internal.attempting_pose and not internal.blocking and not internal.parrying and not internal.attempting_parry and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.mounting and not internal.dismounting and not internal.ghost_mode then
		local inventory = internal:inventory()

		if slot_name and inventory:can_wield(slot_name, internal.current_state_name) then
			return true
		end
	end

	return false
end

function HumanMounted:can_toggle_weapon(slot_name, t)
	local internal = self._internal

	if not internal.posing and not internal.swinging and not internal.crouching and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.mounting and not internal.dismounting and not internal.ghost_mode then
		local inventory = internal:inventory()

		if slot_name and inventory:can_unwield(slot_name) and inventory:can_toggle(slot_name) then
			return true
		end
	end

	return false
end

function HumanMounted:can_attempt_pose_melee_weapon(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_melee_weapon_slot()

	if slot_name and not internal.wielding and not internal.posing and not internal.crouching and not internal.swinging and not internal.pose_ready and not internal.blocking and not internal.parrying and not internal.attempting_parry and not internal.crouching and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.mounting and not internal.dismounting and not internal.ghost_mode then
		return true, slot_name
	end

	return false, nil
end

function HumanMounted:can_pose_melee_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_melee_weapon_slot()

	if slot_name and not internal.crouching and not internal.posing and not internal.swinging and internal.pose_ready and not internal.blocking and not internal.parrying and not internal.attempting_parry and not internal.crouching and not internal.mounting and not internal.dismounting and not internal.ghost_mode then
		return true, slot_name
	end

	return false, nil
end

function HumanMounted:can_swing_melee_weapon(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.pose_slot_name

	if internal.posing and not internal.crouching and (not internal.swing_recovery_time or t > internal.swing_recovery_time) and not internal.swinging and slot_name and inventory:is_wielded(slot_name) and not internal.ghost_mode then
		return true, slot_name
	end

	return false, nil
end

function HumanMounted:can_abort_melee_swing()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.swing_slot_name

	if internal.swinging and slot_name and inventory:is_wielded(slot_name) then
		return true, slot_name
	end

	return false, nil
end

function HumanMounted:can_aim_ranged_weapon()
	do return false end

	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_ranged_weapon_slot()
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions and extensions.base
	local weapon_can_aim = true

	if weapon_ext then
		weapon_can_aim = weapon_ext:can_aim()
	end

	if slot_name and not internal.wielding and not internal.crouching and not internal.reloading and not internal.mounting and not internal.dismounting and not internal.ghost_mode and weapon_can_aim then
		return true, slot_name
	end

	return false, nil
end

function HumanMounted:can_unaim_ranged_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.aim_slot_name

	if internal.aiming and slot_name and inventory:is_wielded(slot_name) then
		return true, slot_name
	end

	return false, nil
end

function HumanMounted:can_reload(slot_name, aim_input)
	local internal = self._internal
	local inventory = internal:inventory()
	local gear = inventory:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions.base
	local weapon_category = weapon_ext:category()

	if inventory:can_reload(slot_name) and (weapon_category ~= "crossbow" or gear:has_attachment("reload_mechanism", "crossbow_reload_cranequin") and aim_input) and (weapon_category == "bow" or not internal.aiming) and not internal.mounting and not internal.dismounting and not internal.ghost_mode then
		return true
	end

	return false
end

function HumanMounted:can_fire_ranged_weapon()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.aim_slot_name

	if internal.aiming and not internal.crouching and not internal.reloading and slot_name and inventory:is_wielded(slot_name) and not internal.mounting and not internal.dismounting and not internal.ghost_mode then
		local gear = inventory:_gear(slot_name)
		local extensions = gear:extensions()
		local weapon_ext = extensions.base

		if weapon_ext:can_fire() then
			return true, slot_name
		end
	end

	return false, nil
end

function HumanMounted:can_raise_block(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:wielded_block_slot()
	local block_type = slot_name and inventory:block_type(slot_name)

	if block_type and (not internal.swinging or t < internal.swing_abort_time) and (block_type == "shield" or block_type == "buckler" or not internal.wielding) and not internal.parrying and not internal.crouching and (not internal.swing_parry_recovery_time or t > internal.swing_parry_recovery_time) and not internal.mounting and not internal.dismounting and not internal.ghost_mode and (not internal.swing_recovery_time or t > internal.swing_recovery_time or block_type ~= "shield" and block_type ~= "buckler") then
		return true, slot_name
	end

	return false, nil
end

function HumanMounted:can_lower_block()
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = internal.block_slot_name

	if (internal.blocking or internal.parrying) and slot_name and inventory:is_wielded(slot_name) then
		return true, slot_name
	end

	return false, nil
end

function HumanMounted:can_couch(t)
	local internal = self._internal
	local inventory = internal:inventory()
	local slot_name = inventory:allows_couch()
	local mount_locomotion = ScriptUnit.extension(internal.mounted_unit, "locomotion_system")

	if t > internal.couch_cooldown_time and not internal.mounting and not internal.dismounting and slot_name and not internal.wielding and (not self._couch_slot or self._couch_slot == slot_name) and not internal.ghost_mode then
		return true, slot_name
	end

	return false, nil
end
