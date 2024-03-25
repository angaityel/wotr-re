-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_nil_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTNilAction = class(BTNilAction, BTNode)

function BTNilAction:init(...)
	BTNilAction.super.init(self, ...)
end

function BTNilAction:run(unit, blackboard, t, dt)
	return
end
