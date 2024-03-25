-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_melee_aim_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTMeleeAimAction = class(BTMeleeAimAction, BTNode)

function BTMeleeAimAction:init(...)
	BTMeleeAimAction.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)

	self._data = self._data or {}
end

function BTMeleeAimAction:setup(unit, blackboard, profile)
	self._aim_node = self._data.aim_node or "Neck"
end

function BTMeleeAimAction:run(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local target_unit = blackboard[self._input]
	local target_unit_pos = Unit.world_position(target_unit, Unit.node(target_unit, self._aim_node))

	locomotion:set_look_target(target_unit_pos)
end
