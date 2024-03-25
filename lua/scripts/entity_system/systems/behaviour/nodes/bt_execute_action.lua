-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_execute_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTExecuteAction = class(BTExecuteAction, BTNode)

function BTExecuteAction:init(...)
	BTExecuteAction.super.init(self, ...)
end

function BTExecuteAction:run(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local target_unit = blackboard[self._input]

	if not locomotion.executing then
		locomotion:execute_target(target_unit, t)
	end

	return locomotion.executing
end
