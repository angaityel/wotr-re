-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_unit_blocking_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTUnitBlockingCondition = class(BTUnitBlockingCondition, BTCondition)

function BTUnitBlockingCondition:init(...)
	BTUnitBlockingCondition.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTUnitBlockingCondition:setup(unit, blackboard, profile)
	BTUnitBlockingCondition.super.setup(self, unit, blackboard, profile)

	self._block_duration = self._data.block_duration or 0
	self._block_slot_name = self._data.block_slot_name or "shield"
end

function BTUnitBlockingCondition:accept(unit, blackboard, t, dt)
	local target_unit = blackboard[self._input]
	local target_locomotion = ScriptUnit.extension(target_unit, "locomotion_system")
	local target_block_slot_name = target_locomotion.block_slot_name
	local block_start_time = target_locomotion.block_start_time
	local length_of_block = block_start_time + self._block_duration
	local is_blocking = (target_locomotion.blocking or target_locomotion.parrying) and self._block_slot_name == target_block_slot_name and length_of_block <= t

	return is_blocking
end
