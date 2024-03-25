-- chunkname: @scripts/utils/path_finder.lua

require("scripts/utils/navigation_path")

PathFinder = PathFinder or {}

local settings = AISettings.navigation

local function triangle_area2(a, b, c)
	local ax = b.x - a.x
	local ay = b.y - a.y
	local bx = c.x - a.x
	local by = c.y - a.y

	return bx * ay - ax * by
end

local function string_pull(l_vertices, r_vertices)
	local apex_index, left_index, right_index = 1, 1, 1
	local portal_apex, portal_left, portal_right = l_vertices[1], l_vertices[1], r_vertices[1]
	local path = {
		portal_apex
	}
	local skip

	if script_data.debug_pathfinder then
		Managers.state.debug_text:clear_world_text("string_pull")
	end

	local i = 2

	while i <= #l_vertices do
		local left, right = l_vertices[i], r_vertices[i]

		skip = false

		if script_data.debug_pathfinder then
			Managers.state.debug_text:output_world_text("r" .. i, 0.1, right + Vector3.up() * 0.05 * i, nil, "string_pull", Vector3(0, 0, 255))
		end

		if triangle_area2(portal_apex, portal_right, right) <= 0 then
			if Vector3.equal(portal_apex, portal_right) or triangle_area2(portal_apex, portal_left, right) > 0 then
				portal_right = right
				right_index = i
			else
				path[#path + 1] = portal_left
				portal_apex, apex_index = portal_left, left_index
				portal_left, portal_right = portal_apex, portal_apex
				left_index, right_index = apex_index, apex_index
				i = apex_index
				skip = true

				if script_data.debug_pathfinder then
					Managers.state.debug_text:output_world_text(#path .. "," .. apex_index, 0.1, path[#path] + Vector3.up() * 0.1, nil, "string_pull", Vector3(0, 0, 255))
				end
			end
		end

		if script_data.debug_pathfinder then
			Managers.state.debug_text:output_world_text("l" .. i, 0.1, left + Vector3.up() * 0.05 * i, nil, "string_pull", Vector3(255, 0, 0))
		end

		if not skip and triangle_area2(portal_apex, portal_left, left) >= 0 then
			if Vector3.equal(portal_apex, portal_left) or triangle_area2(portal_apex, portal_right, left) < 0 then
				portal_left = left
				left_index = i
			else
				path[#path + 1] = portal_right
				portal_apex, apex_index = portal_right, right_index
				portal_left, portal_right = portal_apex, portal_apex
				left_index, right_index = apex_index, apex_index
				i = apex_index

				if script_data.debug_pathfinder then
					Managers.state.debug_text:output_world_text(#path .. "," .. apex_index, 0.1, path[#path] + Vector3.up() * 0.1, nil, "string_pull", Vector3(255, 0, 0))
				end
			end
		end

		i = i + 1
	end

	local last = path[#path]
	local goal = l_vertices[#l_vertices]

	if not Vector3.equal(last, goal) then
		path[#path + 1] = goal
	end

	table.remove(path, 1)

	return path
end

function PathFinder.find_path(nav_mesh, from_pos, to_pos, callback)
	local start_poly = NavigationMesh.find_polygon(nav_mesh, from_pos)
	local end_poly = NavigationMesh.find_polygon(nav_mesh, to_pos)

	if start_poly and end_poly then
		local path = NavigationMesh.search(nav_mesh, start_poly, end_poly, settings.search_focus)

		if script_data.debug_pathfinder then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "PathFinder"
			})

			drawer:reset()
			NavigationMesh.visualize_last_search(nav_mesh, drawer:line_object())
		end

		if #path > 0 then
			local l_side, r_side = NavigationMesh.funnel(nav_mesh, path)
			local l_vertices, r_vertices = {
				from_pos
			}, {
				from_pos
			}

			for i = 1, #l_side do
				l_vertices[i + 1] = NavigationMesh.vertex(nav_mesh, l_side[i])
				r_vertices[i + 1] = NavigationMesh.vertex(nav_mesh, r_side[i])
			end

			l_vertices[#l_vertices + 1] = to_pos
			r_vertices[#r_vertices + 1] = to_pos

			local points = string_pull(l_vertices, r_vertices)

			return NavigationPath:new(nil, points, callback)
		end
	end

	if false then
		-- block empty
	end
end
