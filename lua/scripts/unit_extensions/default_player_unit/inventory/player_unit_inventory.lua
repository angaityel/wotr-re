-- chunkname: @scripts/unit_extensions/default_player_unit/inventory/player_unit_inventory.lua

require("scripts/unit_extensions/default_player_unit/inventory/player_base_inventory")
require("scripts/unit_extensions/default_player_unit/inventory/player_gear")

PlayerUnitInventory = class(PlayerUnitInventory, PlayerBaseInventory)
PlayerUnitInventory.GEAR_CLASS = "PlayerGear"

function PlayerUnitInventory:init(world, user_unit, player, player_unit_game_object_id, tint_color, secondary_tint_color)
	PlayerBaseInventory.init(self, world, user_unit, player, tint_color, secondary_tint_color)

	self._game_object_id = player_unit_game_object_id
	self._rejuvenating_gear = {}
	self._encumbrance = 0
	self._voice_type = "voice"
end

function PlayerUnitInventory:fallback_slot()
	for _, slot_name in ipairs(InventorySlotPriority) do
		if self:can_wield(slot_name) then
			return slot_name
		end
	end

	assert(false, "[PlayerUnitInventory:fallback_slot()] No fallback slot available, did the dagger break?")
end

function PlayerUnitInventory:add_armour(armour_name, pattern_index, encumbrance_multiplier)
	self._encumbrance = self._encumbrance + Armours[armour_name].encumbrance * encumbrance_multiplier

	PlayerUnitInventory.super.add_armour(self, armour_name, pattern_index)
end

function PlayerUnitInventory:gear_dead(slot_name, attachments)
	local gear_name = self:_gear(slot_name):name()

	PlayerUnitInventory.super.gear_dead(self, slot_name)
	self:_add_rejuvenating_gear(slot_name, gear_name, attachments)
end

function PlayerUnitInventory:_add_rejuvenating_gear(slot_name, gear_name, attachments)
	local gear_data = Gear[gear_name]
	local is_lance = gear_data and (gear_name == "tournament_lance" or gear_name == "war_lance")
	local rejuvenation_time = is_lance and Managers.time:time("game") + gear_data.rejuvenation_delay or math.huge

	if is_lance then
		local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
		local blackboard = locomotion.lance_recharge_blackboard

		blackboard.timer = rejuvenation_time
		blackboard.max_time = gear_data.rejuvenation_delay

		Managers.state.event:trigger("event_lance_recharge_activated", nil, nil, locomotion.player, blackboard)
	end

	self._rejuvenating_gear[slot_name] = {
		gear_name = gear_name,
		rejuvenation_time = rejuvenation_time,
		attachments = attachments
	}
end

function PlayerUnitInventory:_rejuvenate_gear(slot_name, rejuvenation_data)
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local is_lance = rejuvenation_data and (rejuvenation_data.gear_name == "tournament_lance" or rejuvenation_data.gear_name == "war_lance")

	if is_lance then
		Managers.state.event:trigger("event_lance_recharge_deactivated", locomotion.player)
	end

	self:add_gear(rejuvenation_data.gear_name, nil, nil, rejuvenation_data.attachments, locomotion)
	assert(not self._rejuvenating_gear[slot_name], "[PlayerUnitInventory:_rejuvenate_gear()] Gear rejuvenation failed, slot is still in rejuvenation mode")
end

function PlayerUnitInventory:update(dt, t)
	for name, slot in pairs(self._slots) do
		local rejuvenation_data = self._rejuvenating_gear[name]

		if rejuvenation_data and t > rejuvenation_data.rejuvenation_time then
			self:_rejuvenate_gear(name, rejuvenation_data)
		elseif slot.gear then
			slot.gear:update(dt, t)
		end
	end
end

function PlayerUnitInventory:bandage_rejuvenate_gear()
	for name, slot in pairs(self._slots) do
		local rejuvenation_data = self._rejuvenating_gear[name]
		local is_lance = rejuvenation_data and (rejuvenation_data.gear_name == "tournament_lance" or rejuvenation_data.gear_name == "war_lance")

		if rejuvenation_data and not is_lance then
			self:_rejuvenate_gear(name, rejuvenation_data)
		elseif not is_lance and slot.gear then
			local gear_unit = slot.gear:unit()
			local damage_ext = ScriptUnit.has_extension(gear_unit, "damage_system") and ScriptUnit.extension(gear_unit, "damage_system")

			if damage_ext then
				damage_ext:reset_damage()
			end
		end
	end
end

function PlayerUnitInventory:add_gear(gear_name, obj_id, ai_gear, attachments, locomotion)
	local gear_settings = Gear[gear_name]

	fassert(gear_settings, "No gear found with name %q", gear_name)

	local wanted_slot = GearTypes[gear_settings.gear_type].inventory_slot

	self._rejuvenating_gear[wanted_slot] = nil

	local unit, gear = PlayerUnitInventory.super.add_gear(self, gear_name, obj_id, ai_gear, attachments)
	local encumbrance_multiplier = gear:attachment_multiplier("encumbrance")

	encumbrance_multiplier = gear_settings.category == "large_shield" and locomotion:has_perk("shield_expert") and Perks.shield_expert.encumbrance_multiplier * encumbrance_multiplier or encumbrance_multiplier
	encumbrance_multiplier = locomotion:has_perk("infantry") and Perks.infantry.encumbrance_multiplier * encumbrance_multiplier or encumbrance_multiplier

	local encumbrance = gear_settings.encumbrance * encumbrance_multiplier

	self._encumbrance = self._encumbrance + encumbrance

	return unit, gear
end

function PlayerUnitInventory:remove_gear(slot_name)
	local gear = self:_gear(slot_name)
	local gear_settings = gear:settings()
	local encumbrance_multiplier = gear:attachment_multiplier("encumbrance")
	local encumbrance = gear_settings.encumbrance * encumbrance_multiplier

	self._encumbrance = self._encumbrance - encumbrance

	PlayerUnitInventory.super.remove_gear(self, slot_name)
end

function PlayerUnitInventory:add_helmet(helmet_name, team_name)
	PlayerUnitInventory.super.add_helmet(self, helmet_name, team_name)

	local helmet = Helmets[helmet_name]

	self._encumbrance = self._encumbrance + helmet.encumbrance
end

function PlayerUnitInventory:add_helmet_attachment(helmet_name, attachment_type, attachment_name, team_name)
	PlayerUnitInventory.super.add_helmet_attachment(self, helmet_name, attachment_type, attachment_name, team_name)

	local helmet = Helmets[helmet_name]
	local helmet_attachment = helmet.attachments[attachment_name]

	self._encumbrance = self._encumbrance + helmet_attachment.encumbrance
end

function PlayerUnitInventory:add_helmet_crest(crest_name, team_name)
	PlayerUnitInventory.super.add_helmet_crest(self, crest_name, team_name)

	local crest_settings = HelmetCrests[crest_name]

	self._encumbrance = self._encumbrance + crest_settings.encumbrance
end

function PlayerUnitInventory:encumbrance()
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")

	return PlayerUnitMovementSettings.debug_encumbrance or self._encumbrance * (locomotion:has_perk("cavalry") and Perks.cavalry.encumbrance_multiplier or 1)
end

function PlayerUnitInventory:can_wield(slot_name, player_state_name)
	local gear = self:_gear(slot_name)

	if not gear then
		return false
	end

	local extensions = gear:extensions()
	local weapon_ext = extensions and extensions.base
	local weapon_can_wield = true

	if weapon_ext then
		weapon_can_wield = weapon_ext:can_wield(player_state_name)
	end

	return not gear:wielded() and weapon_can_wield
end

function PlayerUnitInventory:can_unwield(slot_name)
	local gear = self:_gear(slot_name)

	return gear and gear:wielded()
end

function PlayerUnitInventory:can_toggle(slot_name)
	return InventorySlots[slot_name].wield_toggle
end

function PlayerUnitInventory:is_wielded(slot_name)
	local gear = self:_gear(slot_name)

	return gear and gear:wielded()
end

function PlayerUnitInventory:is_equipped(slot_name)
	local gear = self:_gear(slot_name)

	return gear and true
end

function PlayerUnitInventory:is_two_handed(slot_name)
	local gear = self:_gear(slot_name)

	return gear and gear:is_two_handed()
end

function PlayerUnitInventory:is_one_handed(slot_name)
	local gear = self:_gear(slot_name)

	return gear and gear:is_one_handed()
end

function PlayerUnitInventory:is_left_handed(slot_name)
	local gear = self:_gear(slot_name)

	return gear and gear:is_left_handed()
end

function PlayerUnitInventory:is_right_handed(slot_name)
	local gear = self:_gear(slot_name)

	return gear and gear:is_right_handed()
end

function PlayerUnitInventory:wielded_weapon_slot()
	for slot_name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear and gear:wielded() and not gear:is_shield() then
			return slot_name
		end
	end
end

function PlayerUnitInventory:wielded_melee_weapon_slot()
	for slot_name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear and gear:wielded() and gear:is_melee_weapon() then
			return slot_name
		end
	end
end

function PlayerUnitInventory:wielded_block_slot()
	local block_priority = math.huge
	local block_slot_name

	for slot_name, slot in pairs(self._slots) do
		if self:can_block(slot_name) and block_priority > self:block_priority(slot_name) then
			block_priority = self:block_priority(slot_name)
			block_slot_name = slot_name
		end
	end

	return block_slot_name
end

function PlayerUnitInventory:allows_couch()
	for slot_name, slot in pairs(self._slots) do
		local gear = slot.gear

		if gear and gear:wielded() and gear:settings().allows_couch then
			return slot_name
		end
	end
end

function PlayerUnitInventory:gear_couch_settings(slot_name)
	return self:_gear(slot_name):settings().attacks.couch
end

function PlayerUnitInventory:gear_unit(slot_name)
	return self:_gear(slot_name):unit()
end

function PlayerUnitInventory:start_melee_attack(slot_name, charge_time, swing_direction, gear_cb_abort_swing, swing_time_multiplier)
	local gear = self:_gear(slot_name)
	local attack_tweak_data = gear:settings().attacks[swing_direction]
	local quick_swing = charge_time < attack_tweak_data.quick_swing_charge_time
	local swing_time = (quick_swing and attack_tweak_data.quick_swing_attack_time or attack_tweak_data.attack_time) * swing_time_multiplier

	gear:start_melee_attack(charge_time, swing_direction, quick_swing, gear_cb_abort_swing, swing_time)

	return swing_time, quick_swing
end

function PlayerUnitInventory:start_couch(slot_name, abort_func)
	local gear = self:_gear(slot_name)

	gear:start_couch(abort_func)
end

function PlayerUnitInventory:end_couch(slot_name)
	local gear = self:_gear(slot_name)

	gear:end_couch()
end

function PlayerUnitInventory:end_melee_attack(slot_name, reason)
	local gear = self:_gear(slot_name)
	local swing_direction, quick_swing, hit = gear:end_melee_attack()
	local attack_tweak_data = Gear[gear:name()].attacks[swing_direction]
	local total_swing_recovery, swing_recovery, quick_swing_multiplier, total_parry_recovery, parry_recovery
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local has_perk = locomotion:has_perk("man_at_arms")
	local perk = Perks.man_at_arms
	local enc = self._encumbrance

	if reason == "not_penetrated" then
		local not_penetrated_modifier = (has_perk and perk.not_penetrated_modifier or 1) * PlayerUnitMovementSettings.encumbrance.functions.not_penetrated_penalty(enc)

		swing_recovery = attack_tweak_data.penalties.not_penetrated * not_penetrated_modifier
		parry_recovery = (attack_tweak_data.penalties.not_penetrated_parry or attack_tweak_data.penalties.not_penetrated) * not_penetrated_modifier
	elseif reason == "hard" then
		local hard_multiplier = (has_perk and perk.hard_multiplier or 1) * PlayerUnitMovementSettings.encumbrance.functions.hard_penalty(enc)

		swing_recovery = attack_tweak_data.penalties.hard * hard_multiplier
		parry_recovery = (attack_tweak_data.penalties.hard_parry or attack_tweak_data.penalties.hard) * hard_multiplier
	elseif reason == "blocking" then
		local blocked_multiplier = (has_perk and perk.blocked_multiplier or 1) * gear:attachment_multipliers().blocked_penalty * PlayerUnitMovementSettings.encumbrance.functions.blocked_penalty(enc)

		swing_recovery = attack_tweak_data.penalties.blocked * blocked_multiplier
		parry_recovery = (attack_tweak_data.penalties.blocked_parry or attack_tweak_data.penalties.blocked) * blocked_multiplier
	elseif reason == "parrying" then
		local parried_multiplier = (has_perk and perk.parried_multiplier or 1) * gear:attachment_multipliers().blocked_penalty * PlayerUnitMovementSettings.encumbrance.functions.parried_penalty(enc)

		swing_recovery = attack_tweak_data.penalties.parried * parried_multiplier
		parry_recovery = (attack_tweak_data.penalties.parried_parry or attack_tweak_data.penalties.parried) * parried_multiplier
	elseif not hit then
		local miss_multiplier = (has_perk and perk.miss_multiplier or 1) * PlayerUnitMovementSettings.encumbrance.functions.miss_penalty(enc) * gear:attachment_multipliers().miss_penalty

		swing_recovery = attack_tweak_data.penalties.miss * miss_multiplier
		parry_recovery = (attack_tweak_data.penalties.miss_parry or attack_tweak_data.penalties.miss) * miss_multiplier
	else
		parry_recovery = 0
		swing_recovery = 0
	end

	if quick_swing and attack_tweak_data.quick_swing_attack_time then
		quick_swing_multiplier = attack_tweak_data.quick_swing_attack_time / attack_tweak_data.attack_time
		total_swing_recovery = swing_recovery * quick_swing_multiplier
		total_parry_recovery = parry_recovery * quick_swing_multiplier
	else
		total_swing_recovery = swing_recovery
		total_parry_recovery = parry_recovery
	end

	if script_data.damage_debug then
		Managers.state.hud:output_console_text("Total Swing Recovery = " .. tostring(total_swing_recovery) .. " [Hit type = " .. (hit and (reason or "hit") or "miss") .. ", Base Swing Recovery = " .. swing_recovery .. ", Quick swing multiplier = " .. (quick_swing_multiplier or "none") .. "]", Vector3(255, 30, 0))
	end

	return total_swing_recovery, total_parry_recovery
end

function PlayerUnitInventory:can_block(slot_name)
	local gear = self:_gear(slot_name)

	return gear and gear:wielded() and gear:can_block()
end

function PlayerUnitInventory:can_reload(slot_name)
	local gear = self:_gear(slot_name)
	local extensions = gear:extensions()
	local weapon_ext = extensions and extensions.base
	local return_value = true

	if weapon_ext then
		return_value = weapon_ext:can_reload()
	end

	return return_value
end

function PlayerUnitInventory:block_priority(slot_name)
	local gear = self:_gear(slot_name)
	local block_type = self:block_type(slot_name)

	return BlockTypes[block_type].priority
end

function PlayerUnitInventory:block_type(slot_name)
	local gear = self:_gear(slot_name)
	local gear_settings = gear:settings()

	return gear_settings.block_type
end

function PlayerUnitInventory:weapon_wield_time(slot_name)
	local gear = self:_gear(slot_name)
	local gear_settings = gear:settings()
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local wield_time_multiplier = locomotion:has_perk("highwayman") and Perks.highwayman.wield_time_multiplier or 1

	return gear_settings.wield_time * wield_time_multiplier * PlayerUnitMovementSettings.encumbrance.functions.wield_time(self._encumbrance)
end

function PlayerUnitInventory:weapon_uncharged_damage_factor(slot_name, swing_direction)
	local gear = self:_gear(slot_name)
	local gear_settings = gear:settings()
	local attacks = gear_settings.attacks
	local attack_settings = attacks[swing_direction]

	return attack_settings.uncharged_damage_factor
end

function PlayerUnitInventory:weapon_pose_movement_multiplier(slot_name)
	local gear = self:_gear(slot_name)
	local gear_settings = gear:settings()
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local perk_movement_multiplier = locomotion:has_perk("forest_warden") and gear:is_ranged_weapon() and Perks.forest_warden.movement_multiplier or 1

	perk_movement_multiplier = locomotion:has_perk("shield_wall") and gear:is_shield() and Perks.shield_wall.movement_multiplier or perk_movement_multiplier

	local attachment_movement_multiplier = gear:attachment_multiplier("pose_movement_speed")

	return gear_settings.pose_movement_multiplier * perk_movement_multiplier * attachment_movement_multiplier
end

function PlayerUnitInventory:ranged_weapon_draw_time(slot_name)
	local gear = self:_gear(slot_name)
	local gear_settings = gear:settings()
	local attack_settings = gear_settings.attacks.ranged
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local draw_time_multiplier = locomotion:has_perk("longbowman") and Perks.longbowman.draw_time_multiplier or 1

	return (attack_settings.bow_draw_time or 0) * draw_time_multiplier
end

function PlayerUnitInventory:ranged_weapon_reload_time(slot_name)
	local gear = self:_gear(slot_name)
	local gear_settings = gear:settings()
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local reload_time_multiplier = locomotion:has_perk("sleight_of_hand") and Perks.sleight_of_hand.reload_time_multiplier or 1

	return gear_settings.attacks.ranged.reload_time * PlayerUnitMovementSettings.encumbrance.functions.reload_time(self:encumbrance()) * reload_time_multiplier
end

function PlayerUnitInventory:unwield_slots_on_wield(wield_slot_name)
	local gear_type_name = self:gear_settings(wield_slot_name).gear_type
	local gear_type = GearTypes[gear_type_name]

	return gear_type.unwield_slots_on_wield, gear_type.unwield_slot_exception_gear_types
end

function PlayerUnitInventory:weapon_wield_anim(slot_name)
	local gear = self:_gear(slot_name)
	local gear_settings = Gear[gear:name()]

	return gear_settings.wield_anim
end

function PlayerUnitInventory:set_gear_wielded(slot_name, wielded, ignore_sound)
	local gear = self:_gear(slot_name)

	gear:set_wielded(wielded)

	local game_object_id = self._game_object_id
	local network_manager = Managers.state.network

	if game_object_id and network_manager:game() then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_set_gear_wielded", game_object_id, NetworkLookup.inventory_slots[slot_name], wielded, ignore_sound)
		else
			network_manager:send_rpc_server("rpc_set_gear_wielded", game_object_id, NetworkLookup.inventory_slots[slot_name], wielded, ignore_sound)
		end
	end

	if not ignore_sound and wielded and Gear[gear:name()].timpani_events and Gear[gear:name()].timpani_events.wield then
		gear:trigger_timpani_event("wield")
	end

	local main_body_state, hand_anim = self:player_unit_gear_anims(gear)

	return main_body_state, hand_anim
end

function PlayerUnitInventory:enter_ghost_mode()
	local slots = self._slots

	for slot_name, slot in pairs(slots) do
		local gear = slot.gear

		if gear then
			gear:enter_ghost_mode()
		end
	end
end

function PlayerUnitInventory:exit_ghost_mode()
	local slots = self._slots

	for slot_name, slot in pairs(slots) do
		local gear = slot.gear

		if gear then
			gear:exit_ghost_mode()
		end
	end
end

function PlayerUnitInventory:wield_reload_anim(slot_name)
	local gear = self:_gear(slot_name)
	local gear_settings = Gear[gear:name()]

	return GearTypes[gear_settings.gear_type].wield_reload_anim
end

function PlayerUnitInventory:toggle_visor()
	if not self._visor_name then
		return
	end

	if self:visor_open() then
		self:set_visor_open(false)
	else
		self:set_visor_open(true)
	end

	local game_object_id = self._game_object_id

	if game_object_id then
		if Managers.lobby.server then
			Managers.state.network:send_rpc_clients("rpc_set_visor_open", game_object_id, self:visor_open(), false)
		else
			Managers.state.network:send_rpc_server("rpc_set_visor_open", game_object_id, self:visor_open(), false)
		end
	end
end

function PlayerUnitInventory:weapon_grip_switched()
	return self._weapon_grip_switched
end

function PlayerUnitInventory:set_grip_switched(switched)
	self._weapon_grip_switched = switched
end

function PlayerUnitInventory:can_switch_weapon_grip()
	local slot_name = self:wielded_weapon_slot()

	if not slot_name then
		return false
	end

	local gear = self:_gear(slot_name)
	local settings = gear:settings()

	return settings.can_switch_grip
end
