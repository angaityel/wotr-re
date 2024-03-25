-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_ranged_attack_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTRangedAttackAction = class(BTRangedAttackAction, BTNode)

function BTRangedAttackAction:init(...)
	BTRangedAttackAction.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTRangedAttackAction:run(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	if not locomotion.ranged_attack and locomotion.projectile_angle then
		local inventory = locomotion:inventory()
		local slot_name = inventory:wielded_ranged_weapon_slot()

		if slot_name then
			local gear = inventory:_gear(slot_name)
			local gear_unit = gear:unit()
			local gear_settings = Unit.get_data(gear_unit, "attacks").ranged

			locomotion:begin_ranged_attack(gear_settings.bow_draw_time or 2)
		end
	end
end
