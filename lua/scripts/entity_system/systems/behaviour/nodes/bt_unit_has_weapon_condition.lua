-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_unit_has_weapon_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTUnitHasWeaponCondition = class(BTUnitHasWeaponCondition, BTCondition)

function BTUnitHasWeaponCondition:init(...)
	BTUnitHasWeaponCondition.super.init(self, ...)
	fassert(self._data.slot_name, "No weapon set for node to check %q", self._name)
end

function BTUnitHasWeaponCondition:setup(unit, blackboard, profile)
	BTUnitHasWeaponCondition.super.setup(self, unit, blackboard, profile)

	self._wielded = self._data.wielded
	self._slot_name = self._data.slot_name
end

function BTUnitHasWeaponCondition:accept(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local inventory = locomotion:inventory()
	local slot_name = self._slot_name
	local slot_name_wielded = inventory:is_wielded(slot_name)
	local slot_name_equipped = inventory:is_equipped(slot_name)

	if self._wielded then
		return slot_name_wielded
	else
		return slot_name_equipped
	end
end
