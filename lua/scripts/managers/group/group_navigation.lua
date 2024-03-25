-- chunkname: @scripts/managers/group/group_navigation.lua

GroupNavigation = class(GroupNavigation)

function GroupNavigation:init(world, locomotion)
	self._level = LevelHelper:current_level(world)
	self._nav_mesh = Level.navigation_mesh(self._level)
	self._locomotion = locomotion
	self._arrive_callback = callback(self, "_arrived")
end

function GroupNavigation:move_to(wanted_pos, flow_event_name)
	local current_pos = self._locomotion:position()
	local path = PathFinder.find_path(self._nav_mesh, current_pos, wanted_pos)

	self._flow_event_name = flow_event_name

	if path then
		local new_pos = path:current()

		self._locomotion:set_move_target(new_pos, self._arrive_callback)
	end

	self._path = path
end

function GroupNavigation:_arrived()
	if self._path:is_last() then
		self._path = nil

		if self._flow_event_name then
			Level.trigger_event(self._level, self._flow_event_name)
		end
	else
		self._path:advance()

		local position = self._path:current()

		self._locomotion:set_move_target(position, self._arrive_callback)
	end
end
