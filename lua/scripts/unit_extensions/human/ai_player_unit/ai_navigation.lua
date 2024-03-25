-- chunkname: @scripts/unit_extensions/human/ai_player_unit/ai_navigation.lua

require("scripts/utils/path_finder")

AINavigation = class(AINavigation)

local settings = AISettings.navigation

local function remove_spline_points(spline)
	local stripped_spline, next_point_index = {
		spline[1]
	}, 4

	for i = 1, #spline do
		if i == next_point_index then
			stripped_spline[#stripped_spline + 1] = spline[i]
			next_point_index = next_point_index + 3
		end
	end

	return stripped_spline
end

local function project_points_to_navigation_mesh(nav_mesh, points, spline_name)
	for i, point in pairs(points) do
		local poly = NavigationMesh.find_polygon(nav_mesh, point)

		fassert(poly, "Spline point %s for spline %q is outside the navigation mesh", point, spline_name)

		points[i] = NavigationMesh.project_to_polygon(nav_mesh, point, poly)
	end
end

function AINavigation:init(world, unit, steering)
	self._level = LevelHelper:current_level(world)
	self._nav_mesh = Level.navigation_mesh(self._level)
	self._unit = unit
	self._steering = steering
	self._follow_path_callback = callback(self, "_follow_arrived")
	self._patrol_path_callback = callback(self, "_patrol_arrived")
	self._unfinished_paths = {}
end

function AINavigation:follow_spline(spline_name, callback)
	self._command_callback = callback

	local unfinished_path = self._unfinished_paths[spline_name]

	if unfinished_path then
		self:follow_path(unfinished_path)
	else
		local spline = Level.spline(self._level, spline_name)

		fassert(#spline > 0, "Invalid spline name to follow %q", spline_name)

		local points = remove_spline_points(spline)

		project_points_to_navigation_mesh(self._nav_mesh, points, spline_name)

		local path = NavigationPath:new(spline_name, points, callback)

		self._unfinished_paths[spline_name] = path

		self:follow_path(path)
	end
end

function AINavigation:patrol_spline(spline_name)
	local spline = Level.spline(self._level, spline_name)

	fassert(#spline > 0, "Invalid spline name to patrol %q", spline_name)

	local points = remove_spline_points(spline)

	project_points_to_navigation_mesh(self._nav_mesh, points, spline_name)

	local path = NavigationPath:new(nil, points)

	self:patrol_path(path)
end

function AINavigation:move_to_unit(unit, callback)
	self._command_callback = callback

	local unit_pos = Unit.world_position(self._unit, 0)
	local target_pos = Unit.world_position(unit, 0)
	local poly = NavigationMesh.find_polygon(self._nav_mesh, target_pos)

	fassert(poly, "Waypoint %s is outside the navigation mesh", unit)

	local projected_pos = NavigationMesh.project_to_polygon(self._nav_mesh, target_pos, poly)
	local path = PathFinder.find_path(self._nav_mesh, unit_pos, projected_pos, callback)

	if path then
		self:follow_path(path)
	else
		print("AINavigation:move_to_unit - Path Error")
	end
end

function AINavigation:move_to(target_pos)
	local distance = math.huge

	if self._path then
		local goal_pos = self._path:last()

		distance = Vector3.distance(target_pos, goal_pos)
	end

	if distance > settings.renavigate_threshold then
		local unit_pos = Unit.world_position(self._unit, 0)
		local path = PathFinder.find_path(self._nav_mesh, unit_pos, target_pos)

		if path then
			self:follow_path(path)
		end
	end
end

function AINavigation:follow_path(path)
	local position = path:current()

	if path:is_last() then
		self._steering:arrive(position, self._follow_path_callback)
	else
		self._steering:seek(position, self._follow_path_callback)
	end

	self._path = path
end

function AINavigation:_follow_arrived(unit)
	if self._path:is_last() then
		local callback = self._path:callback()

		if callback then
			callback()
		end

		local path_name = self._path:name()

		if path_name then
			self._unfinished_paths[path_name] = nil
		end
	else
		self._path:advance()
		self:follow_path(self._path)
	end
end

function AINavigation:patrol_path(path)
	local position = path:current()

	self._steering:seek(position, self._patrol_path_callback)

	self._path = path
end

function AINavigation:_patrol_arrived(unit)
	if self._path:is_last() then
		self._path:reverse()
		self._path:reset()
	else
		self._path:advance()
	end

	self:patrol_path(self._path)
end
