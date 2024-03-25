-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_unit_aiming_condition.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_condition")

BTUnitAimingCondition = class(BTUnitAimingCondition, BTCondition)

function BTUnitAimingCondition:init(...)
	BTUnitAimingCondition.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTUnitAimingCondition:accept(unit, blackboard, t, dt)
	local target_unit = blackboard[self._input]
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local target_locomotion = ScriptUnit.extension(target_unit, "locomotion_system")
	local is_aiming = target_locomotion.aiming and self:aiming_at_me(unit, target_unit, locomotion, target_locomotion)

	return is_aiming
end

function BTUnitAimingCondition:aiming_at_me(unit, target_unit, locomotion, target_locomotion)
	local aim_dir = locomotion:aim_direction()
	local target_aim_dir = target_locomotion:aim_direction()
	local aim_dir_flat = Vector3.normalize(Vector3.flat(aim_dir))
	local target_aim_dir_flat = Vector3.normalize(Vector3.flat(target_aim_dir))
	local dot = Vector3.dot(aim_dir_flat, target_aim_dir_flat)

	return dot < -0.95
end
