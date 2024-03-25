-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_update_filter.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTUpdateFilter = class(BTUpdateFilter, BTNode)

function BTUpdateFilter:init(...)
	BTUpdateFilter.super.init(self, ...)
end

function BTUpdateFilter:setup(unit, blackboard, profile)
	self._time = 0
	self._period = Math.random_range(self._data.min, self._data.max)

	self._child:setup(unit, blackboard, profile)
end

function BTUpdateFilter:run(unit, blackboard, t, dt)
	self._time = self._time + dt

	if self._time >= self._period then
		self._time = self._time - self._period

		return self._child:run(unit, blackboard, t, dt)
	end
end

function BTUpdateFilter:add_child(node)
	self._child = node
end
