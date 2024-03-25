-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_within_range_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTWithinRangeCondition = class(BTWithinRangeCondition, BTCondition)

function BTWithinRangeCondition:init(...)
	BTWithinRangeCondition.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
	fassert(self._data.range, "No range set for node %q", self._name)
end

function BTWithinRangeCondition:setup(unit, blackboard, profile)
	BTWithinRangeCondition.super.setup(self, unit, blackboard, profile)

	self._range = self._data.range
end

function BTWithinRangeCondition:accept(unit, blackboard, t, dt)
	local unit_pos = Unit.local_position(unit, 0)
	local target_unit = blackboard[self._input]
	local target_unit_pos = Unit.local_position(target_unit, 0)
	local distance = Vector3.distance(unit_pos, target_unit_pos)

	if self._range == "attack_range" then
		local locomotion = ScriptUnit.extension(unit, "locomotion_system")
		local optimal_weapon_distance = 1.5 * locomotion:inventory():optimal_weapon_distance()

		return distance <= optimal_weapon_distance
	else
		return distance <= self._range
	end
end
