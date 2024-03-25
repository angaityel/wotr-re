-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_unit_attacking_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTUnitAttackingCondition = class(BTUnitAttackingCondition, BTCondition)

function BTUnitAttackingCondition:init(...)
	BTUnitAttackingCondition.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTUnitAttackingCondition:accept(unit, blackboard, t, dt)
	local target_unit = blackboard[self._input]
	local target_locomotion = ScriptUnit.extension(target_unit, "locomotion_system")
	local is_attacking = target_locomotion.posing or target_locomotion.swinging

	return is_attacking
end
