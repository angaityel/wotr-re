-- chunkname: @scripts/unit_extensions/human/ai_player_unit/ai_unit_inventory.lua

require("scripts/unit_extensions/default_player_unit/inventory/player_unit_inventory")

AIUnitInventory = class(AIUnitInventory, PlayerUnitInventory)
AIUnitInventory.GEAR_CLASS = "PlayerGear"

function AIUnitInventory:projectile_position()
	local projectile_name = self:_projectile_name()
	local projectile_position = WeaponHelper:projectile_fire_position_from_ranged_weapon(self._user_unit, projectile_name)

	return projectile_position
end

function AIUnitInventory:optimal_weapon_distance()
	local slot_name = self:wielded_weapon_slot()

	if slot_name then
		local gear_type = self:gear_settings(slot_name).gear_type
		local distance = AISettings.weapon_distance[gear_type]

		fassert(distance, "No AI weapon distance setting found for gear type %q", gear_type)

		return distance
	else
		return 100
	end
end
