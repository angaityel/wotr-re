-- chunkname: @scripts/managers/debug/debug_text_manager.lua

DebugTextManager = class(DebugTextManager)

function DebugTextManager:init(world)
	self._world = world
	self._gui = World.create_screen_gui(world, "material", MenuSettings.font_group_materials.arial)
	self._world_gui = World.create_world_gui(world, Matrix4x4.identity(), 1, 1, "material", MenuSettings.font_group_materials.arial)
	self._time = 0
	self._screen_text_size = 50
	self._screen_text_time = 5
	self._screen_text_bgr = nil
	self._screen_text = nil
	self._unit_text_size = 0.2
	self._unit_text_time = math.huge
	self._unit_texts = {}
	self._world_text_size = 0.6
	self._world_text_time = math.huge
	self._world_texts = {}
end

function DebugTextManager:update(dt, viewport_name)
	self._time = self._time + dt

	self:_update_unit_texts(viewport_name)
	self:_update_world_texts(viewport_name)
	self:_update_screen_text()
end

function DebugTextManager:_update_unit_texts(viewport_name)
	local camera_rotation = Managers.state.camera:camera_rotation(viewport_name)
	local world_gui = self._world_gui
	local material = MenuSettings.fonts.menu_font.material
	local text_size = self._unit_text_size
	local font = MenuSettings.fonts.menu_font.font

	for unit, categories in pairs(self._unit_texts) do
		if Unit.alive(unit) then
			for category, gui_texts in pairs(categories) do
				for i, gui_text in ipairs(gui_texts) do
					if self._time > gui_text.time then
						Gui.destroy_text_3d(self._world_gui, gui_text.id)
						table.remove(gui_texts, i)
					else
						local offset = Vector3(gui_text.offset.x, gui_text.offset.y, gui_text.offset.z)
						local tm = Matrix4x4.from_quaternion_position(camera_rotation, Unit.world_position(unit, gui_text.node_index) + offset)
						local text_offset = Vector3(gui_text.text_offset.x, gui_text.text_offset.y, gui_text.text_offset.z)
						local color = Color(gui_text.color.r, gui_text.color.g, gui_text.color.b)

						Gui.update_text_3d(world_gui, gui_text.id, gui_text.text, material, gui_text.text_size, font, tm, text_offset, 0, color)
					end
				end
			end
		else
			self:_destroy_unit_texts(unit)
		end
	end
end

function DebugTextManager:_update_world_texts(viewport_name)
	local camera_rotation = Managers.state.camera:camera_rotation(viewport_name)
	local world_gui = self._world_gui
	local text_size = self._world_text_size
	local font = MenuSettings.fonts.menu_font.font
	local material = MenuSettings.fonts.menu_font.material

	for category, gui_texts in pairs(self._world_texts) do
		for i, gui_text in ipairs(gui_texts) do
			if self._time > gui_text.time then
				Gui.destroy_text_3d(self._world_gui, gui_text.id)
				table.remove(gui_texts, i)
			else
				local position = Vector3(gui_text.position.x, gui_text.position.y, gui_text.position.z)
				local text_offset = Vector3(gui_text.text_offset.x, gui_text.text_offset.y, gui_text.text_offset.z)
				local tm = Matrix4x4.from_quaternion_position(camera_rotation, position)
				local color = Color(gui_text.color.r, gui_text.color.g, gui_text.color.b)

				Gui.update_text_3d(world_gui, gui_text.id, gui_text.text, font, gui_text.text_size, material, tm, text_offset, 0, color)
			end
		end
	end
end

function DebugTextManager:_update_screen_text()
	if self._screen_text and self._time > self._screen_text.time then
		Gui.destroy_text(self._gui, self._screen_text.text_id)
		Gui.destroy_rect(self._gui, self._screen_text.bgr_id)

		self._screen_text = nil
	end
end

function DebugTextManager:network_output_unit_text(text_id, text_size, unit, node_index, offset, time, category, color, viewport_name)
	local network_manager = Managers.state.network

	assert(network_manager:game(), "[DebugTextManager] Tried to send network synched debug text without a network game")

	local network_text_size = text_size or -1
	local level = LevelHelper:current_level(self._world)

	if network_manager:unit_game_object_id(unit) then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_output_debug_unit_text", NetworkLookup.localized_strings[text_id], network_text_size, network_manager:unit_game_object_id(unit), node_index, offset, time, color)
		else
			network_manager:send_rpc_server("rpc_output_debug_unit_text", NetworkLookup.localized_strings[text_id], network_text_size, network_manager:unit_game_object_id(unit), node_index, offset, time, color)
		end
	elseif Level.unit_index(level, unit) then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_output_debug_lvl_unit_text", NetworkLookup.localized_strings[text_id], network_text_size, Level.unit_index(level, unit), node_index, offset, time, color)
		else
			network_manager:send_rpc_server("rpc_output_debug_lvl_unit_text", NetworkLookup.localized_strings[text_id], network_text_size, Level.unit_index(level, unit), node_index, offset, time, color)
		end
	else
		assert(false, "[DebugTextManager] Unit " .. tostring(unit) .. " is not registered in network manager or statically spawned in level.")
	end

	self:output_unit_text(L(text_id), text_size, unit, node_index, offset, time, category, color, viewport_name)
end

function DebugTextManager:output_unit_text(text, text_size, unit, node_index, offset, time, category, color, viewport_name)
	node_index = node_index or 0
	text_size = text_size or self._unit_text_size

	local gui = self._world_gui
	local material = MenuSettings.fonts.menu_font.material
	local font = MenuSettings.fonts.menu_font.font
	local tm

	if viewport_name then
		local camera_rotation = Managers.state.camera:camera_rotation(viewport_name)

		tm = Matrix4x4.from_quaternion_position(camera_rotation, Unit.world_position(unit, node_index) + offset)
	else
		tm = Unit.world_pose(unit, node_index)
	end

	local text_extent_min, text_extent_max = Gui.text_extents(gui, text, font, text_size)
	local text_width = text_extent_max[1] - text_extent_min[1]
	local text_height = text_extent_max[3] - text_extent_min[3]
	local text_offset = Vector3(-text_width / 2, -text_height / 2, 0)

	offset = offset or Vector3(0, 0, 0)
	category = category or "none"
	color = color or Vector3(255, 255, 255)

	local new_text = {
		id = Gui.text_3d(gui, text, font, text_size, material, tm, text_offset, 0, Color(color.x, color.y, color.z)),
		text = text,
		text_size = text_size,
		node_index = node_index,
		offset = {
			x = offset.x,
			y = offset.y,
			z = offset.z
		},
		text_offset = {
			x = text_offset.x,
			y = text_offset.y,
			z = text_offset.z
		},
		color = {
			r = color.x,
			g = color.y,
			b = color.z
		},
		time = self._time + (time or self._unit_text_time)
	}

	self._unit_texts[unit] = self._unit_texts[unit] or {}
	self._unit_texts[unit][category] = self._unit_texts[unit][category] or {}
	self._unit_texts[unit][category][#self._unit_texts[unit][category] + 1] = new_text
end

function DebugTextManager:clear_unit_text(clear_unit, clear_category)
	for unit, categories in pairs(self._unit_texts) do
		if not clear_unit or clear_unit == unit then
			for category, gui_texts in pairs(categories) do
				if not clear_category or category == "none" or clear_category == category then
					for i, gui_text in ipairs(gui_texts) do
						Gui.destroy_text_3d(self._world_gui, gui_text.id)
						table.remove(gui_texts, i)
					end
				end
			end
		end
	end
end

function DebugTextManager:network_output_world_text(text_id, text_size, position, time, category, color)
	local network_manager = Managers.state.network

	assert(network_manager:game(), "[DebugTextManager] Tried to send network synched debug text without a network game")

	local network_time = time or -1
	local network_text_size = text_size or -1

	if Managers.lobby.server then
		network_manager:send_rpc_clients("rpc_output_debug_world_text", category, NetworkLookup.localized_strings[text_id], network_text_size, position, network_time, color)
	else
		network_manager:send_rpc_server("rpc_output_debug_world_text", category, NetworkLookup.localized_strings[text_id], network_text_size, position, network_time, color)
	end

	self:output_world_text(L(text_id), text_size, position, time, category, color)
end

function DebugTextManager:output_world_text(text, text_size, position, time, category, color)
	text_size = text_size or self._world_text_size

	local gui = self._world_gui
	local font = MenuSettings.fonts.menu_font.font
	local material = MenuSettings.fonts.menu_font.material
	local tm = Matrix4x4.from_quaternion_position(Quaternion.identity(), position)
	local text_extent_min, text_extent_max = Gui.text_extents(gui, text, font, text_size)
	local text_width = text_extent_max[1] - text_extent_min[1]
	local text_height = text_extent_max[3] - text_extent_min[3]
	local text_offset = Vector3(-text_width / 2, -text_height / 2, 0)

	category = category or "none"
	color = color or Vector3(255, 255, 255)

	local new_text = {
		id = Gui.text_3d(gui, text, font, text_size, material, tm, text_offset, 0, Color(color.x, color.y, color.z)),
		text = text,
		text_size = text_size,
		position = {
			x = position.x,
			y = position.y,
			z = position.z
		},
		text_offset = {
			x = text_offset.x,
			y = text_offset.y,
			z = text_offset.z
		},
		color = {
			r = color.x,
			g = color.y,
			b = color.z
		},
		time = self._time + (time or self._world_text_time)
	}

	self._world_texts[category] = self._world_texts[category] or {}
	self._world_texts[category][#self._world_texts[category] + 1] = new_text
end

function DebugTextManager:clear_world_text(clear_category)
	for category, gui_texts in pairs(self._world_texts) do
		if not clear_category or category == "none" or clear_category == category then
			for i, gui_text in ipairs(gui_texts) do
				Gui.destroy_text_3d(self._world_gui, gui_text.id)
				table.remove(gui_texts, i)
			end
		end
	end
end

function DebugTextManager:network_output_screen_text(text_id, text_size, time, color)
	local network_manager = Managers.state.network

	assert(network_manager:game(), "[DebugTextManager] Tried to send network synched debug text without a network game")

	local network_text_size = text_size or -1
	local network_time = time or -1

	if Managers.lobby.server then
		network_manager:send_rpc_clients("rpc_output_debug_screen_text", NetworkLookup.localized_strings[text_id], network_text_size, network_time, color)
	else
		network_manager:send_rpc_server("rpc_output_debug_screen_text", NetworkLookup.localized_strings[text_id], network_text_size, network_time, color)
	end

	self:output_screen_text(L(text_id), text_size, time, color)
end

function DebugTextManager:output_screen_text(text, text_size, time, color)
	text_size = text_size or self._screen_text_size
	color = color or Vector3(255, 255, 255)

	local gui = self._gui
	local resolution = Vector2(Application.resolution())
	local material = MenuSettings.fonts.menu_font.material
	local font = MenuSettings.fonts.menu_font.font
	local text_extent_min, text_extent_max = Gui.text_extents(gui, text, font, text_size)
	local text_w = text_extent_max[1] - text_extent_min[1]
	local text_h = text_extent_max[3] - text_extent_min[3]
	local text_position = Vector3(resolution.x / 2 - text_w / 2, resolution.y / 2 - text_h / 2, 11)
	local bgr_margin = 10
	local bgr_x = text_position.x - bgr_margin
	local bgr_y = text_position.y - bgr_margin
	local bgr_w = text_w + bgr_margin * 2
	local bgr_h = text_h + bgr_margin * 2
	local bgr_position = Vector3(bgr_x, bgr_y, 10)
	local bgr_size = Vector2(bgr_w, bgr_h)

	if self._screen_text then
		Gui.update_text(gui, self._screen_text.text_id, text, font, text_size, material, text_position, Color(color.x, color.y, color.z))
		Gui.update_rect(gui, self._screen_text.bgr_id, bgr_position, bgr_size, Color(120, 0, 0, 0))

		self._screen_text.time = self._time + (time or self._screen_text_time)
	else
		local screen_text = {
			text_id = Gui.text(gui, text, font, text_size, material, text_position, Color(color.x, color.y, color.z)),
			bgr_id = Gui.rect(gui, bgr_position, bgr_size, Color(120, 0, 0, 0)),
			time = self._time + (time or self._screen_text_time)
		}

		self._screen_text = screen_text
	end
end

function DebugTextManager:destroy()
	if self._screen_text then
		Gui.destroy_text(self._gui, self._screen_text.text_id)
		Gui.destroy_rect(self._gui, self._screen_text.bgr_id)

		self._screen_text = nil
	end

	for unit, categories in pairs(self._unit_texts) do
		self:_destroy_unit_texts(unit)
	end

	for category, gui_texts in pairs(self._world_texts) do
		for i, gui_text in ipairs(gui_texts) do
			Gui.destroy_text_3d(self._world_gui, gui_text.id)
		end
	end
end

function DebugTextManager:_destroy_unit_texts(unit)
	local categories = self._unit_texts[unit]

	for category, gui_texts in pairs(categories) do
		for i, gui_text in ipairs(gui_texts) do
			Gui.destroy_text_3d(self._world_gui, gui_text.id)
		end
	end

	self._unit_texts[unit] = nil
end
