-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_unit_knocked_down_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTUnitKnockedDownCondition = class(BTUnitKnockedDownCondition, BTCondition)

function BTUnitKnockedDownCondition:init(...)
	BTUnitKnockedDownCondition.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTUnitKnockedDownCondition:accept(unit, blackboard, t, dt)
	local target_unit = blackboard[self._input]
	local target_damage_system = ScriptUnit.extension(target_unit, "damage_system")
	local is_unit_down = target_damage_system:is_knocked_down()

	return is_unit_down
end
