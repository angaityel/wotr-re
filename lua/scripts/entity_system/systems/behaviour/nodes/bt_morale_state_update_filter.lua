-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_morale_state_update_filter.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTMoraleStateUpdateFilter = class(BTMoraleStateUpdateFilter, BTNode)

function BTMoraleStateUpdateFilter:init(...)
	BTMoraleStateUpdateFilter.super.init(self, ...)
end

function BTMoraleStateUpdateFilter:setup(unit, blackboard, profile)
	self._time = 0

	local player_profile = Unit.get_data(unit, "player_profile")

	self._morale_time = AIProfiles[player_profile].morale.times
	self._period = Math.random_range(self._morale_time.min, self._morale_time.max)

	self._child:setup(unit, blackboard, profile)
end

function BTMoraleStateUpdateFilter:run(unit, blackboard, t, dt)
	self._time = self._time + dt

	if self._time >= self._period then
		self._time = self._time - self._period
		self._period = Math.random_range(self._morale_time.min, self._morale_time.max)

		return self._child:run(unit, blackboard, t, dt)
	end
end

function BTMoraleStateUpdateFilter:add_child(node)
	self._child = node
end
