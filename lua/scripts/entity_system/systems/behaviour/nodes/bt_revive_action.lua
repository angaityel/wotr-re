-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_revive_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTReviveAction = class(BTReviveAction, BTNode)

function BTReviveAction:init(...)
	BTReviveAction.super.init(self, ...)
end

function BTReviveAction:run(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local target_unit = blackboard[self._input]

	if not locomotion.reviving then
		locomotion:revive_target(target_unit, t)
	end

	return locomotion.reviving
end
