-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_selector.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTSelector = class(BTSelector, BTNode)

function BTSelector:init(...)
	BTSelector.super.init(self, ...)

	self._children = {}
end

function BTSelector:setup(unit, blackboard, profile)
	for _, child_node in ipairs(self._children) do
		child_node:setup(unit, blackboard, profile)
	end
end

function BTSelector:run(unit, blackboard, t, dt)
	for _, child_node in ipairs(self._children) do
		local success = child_node:run(unit, blackboard, t, dt)

		if success == true or success == nil then
			return true
		end
	end

	return false
end

function BTSelector:add_child(node)
	self._children[#self._children + 1] = node
end
