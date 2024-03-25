-- chunkname: @scripts/managers/group/group.lua

require("scripts/managers/group/group_locomotion")
require("scripts/managers/group/group_navigation")
require("scripts/managers/group/group_commands")

Group = class(Group)

function Group:init(world, formation, pos, rot)
	self._world = world
	self._formation = formation
	self._units = {}
	self._locomotion = GroupLocomotion:new(self, self._units, pos, rot)
	self._navigation = GroupNavigation:new(world, self._locomotion)

	Managers.state.event:register(self, "ai_unit_died", "cb_unit_died")
end

function Group:world()
	return self._world
end

function Group:cb_unit_died(unit)
	self:remove_unit(unit)
	Managers.state.event:trigger("unit_in_group_died", unit)
end

function Group:add_unit(unit)
	local slot = self._formation:request_slot()

	self._units[unit] = slot

	self._locomotion:unit_added(unit)
end

function Group:spawn_in(world, unit_name)
	local slot = self._formation:request_slot()
	local offset = self._formation:offset(slot)
	local pos, rot = self._locomotion:position_rotation_from_offset(offset)
	local unit = World.spawn_unit(world, unit_name, pos, rot)

	self._units[unit] = slot

	return unit
end

function Group:remove_unit(unit)
	local slot = self._units[unit]

	if slot then
		self._formation:relinquish_slot(slot)

		self._units[unit] = nil

		self._locomotion:unit_removed()
	end
end

function Group:num_members()
	return table.size(self._units)
end

function Group:update(dt, t)
	self._locomotion:update(dt, t)
end

function Group:formation()
	return self._formation
end

function Group:locomotion()
	return self._locomotion
end

function Group:navigation()
	return self._navigation
end
