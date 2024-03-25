-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_unit_posing_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTUnitPosingCondition = class(BTUnitPosingCondition, BTCondition)

function BTUnitPosingCondition:init(...)
	BTUnitPosingCondition.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTUnitPosingCondition:setup(unit, blackboard, profile)
	BTUnitPosingCondition.super.setup(self, unit, blackboard, profile)

	self._pose_duration = self._data.pose_duration or 0
end

function BTUnitPosingCondition:accept(unit, blackboard, t, dt)
	local target_unit = blackboard[self._input]
	local target_locomotion = ScriptUnit.extension(target_unit, "locomotion_system")
	local length_of_pose = target_locomotion.pose_time + self._pose_duration
	local is_posing = target_locomotion.posing and length_of_pose <= t

	return is_posing
end
