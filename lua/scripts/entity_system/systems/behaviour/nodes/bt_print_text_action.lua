-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_print_text_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTPrintTextAction = class(BTPrintTextAction, BTNode)

function BTPrintTextAction:init(...)
	BTPrintTextAction.super.init(self, ...)
end

function BTPrintTextAction:run(unit, blackboard, t, dt)
	print(self._data.text)
end
