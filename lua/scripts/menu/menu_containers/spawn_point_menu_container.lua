-- chunkname: @scripts/menu/menu_containers/spawn_point_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

SpawnPointMenuContainer = class(SpawnPointMenuContainer, MenuContainer)

function SpawnPointMenuContainer:init(local_player, map, squad_markers, spawn_areas, objective_markers, local_player_marker)
	SpawnPointMenuContainer.super.init(self)

	self._local_player = local_player
	self._map = map
	self._squad_markers = squad_markers
	self._spawn_areas = spawn_areas
	self._objective_markers = objective_markers
	self._local_player_marker = local_player_marker
	self._scale_x = 1
	self._scale_y = 1
	self._bottom_left = Vector3Box()

	self:_init_map_bounding_box()
end

function SpawnPointMenuContainer:_init_map_bounding_box()
	local level_settings = LevelHelper:current_level_settings()
	local minimap_settings = level_settings.minimap

	if minimap_settings.p1 and minimap_settings.p2 then
		local p1 = minimap_settings.p1:unbox()
		local p2 = minimap_settings.p2:unbox()
		local diagonal = p2 - p1
		local diagonal_dir = Vector3.normalize(diagonal)
		local quarter_pi = math.pi * 0.25
		local x_axis = Quaternion.rotate(Quaternion(Vector3.up(), -quarter_pi), diagonal_dir)
		local y_axis = Quaternion.rotate(Quaternion(Vector3.up(), quarter_pi), diagonal_dir)
		local x_scale = Vector3.dot(x_axis, diagonal)
		local y_scale = Vector3.dot(y_axis, diagonal)

		self._minimap_props = {
			origo = minimap_settings.p1,
			x_axis = Vector3Box(Vector3.normalize(x_axis)),
			y_axis = Vector3Box(Vector3.normalize(y_axis)),
			x_scale = x_scale,
			y_scale = y_scale
		}
	else
		printf("No bounding box specified for level %q!", level_settings.level_name)
	end
end

function SpawnPointMenuContainer:_update_objectives_description_text(gui, layout_settings)
	if self._local_player.team then
		local game_mode_key = Managers.state.game_mode:game_mode_key()
		local objectives_desc = GameModeSettings[game_mode_key].ui_description[self._local_player.team.side]

		self._objectives_description:set_text(L(objectives_desc), layout_settings.objectives_description, gui)
	else
		self._objectives_description:set_text("", layout_settings.objectives_description, gui)
	end
end

function SpawnPointMenuContainer:_set_level_description(gui, layout_settings)
	local level_desc = LevelHelper:current_level_settings().ui_description

	self._level_description = TextBoxMenuContainer.create_from_config()

	self._level_description:set_text(L(level_desc), layout_settings.level_description, gui)
end

function SpawnPointMenuContainer:update_size(dt, t, gui, layout_settings)
	local map = self._map[1]
	local map_layout_settings = MenuHelper:layout_settings(map.config.layout_settings)

	map:update_size(dt, t, gui, map_layout_settings)

	for _, marker in ipairs(self._objective_markers) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)
		local marker_layout_settings_2

		if marker.config.layout_settings_2 then
			marker_layout_settings_2 = MenuHelper:layout_settings(marker.config.layout_settings_2)
		end

		marker:update_size(dt, t, gui, marker_layout_settings, marker_layout_settings_2)
	end

	for _, marker in ipairs(self._squad_markers) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)

		marker:update_size(dt, t, gui, marker_layout_settings)
	end

	for _, marker in ipairs(self._local_player_marker) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)

		marker:update_size(dt, t, gui, marker_layout_settings)
	end

	for _, spawn_area in ipairs(self._spawn_areas) do
		local spawn_area_layout_settings = MenuHelper:layout_settings(spawn_area.config.layout_settings)

		spawn_area:update_size(dt, t, gui, spawn_area_layout_settings)
	end

	if not self._objectives_description then
		self._objectives_description = TextBoxMenuContainer.create_from_config()
	end

	self:_update_objectives_description_text(gui, layout_settings)
	self._objectives_description:update_size(dt, t, self._gui, layout_settings.objectives_description)

	if not self._level_description then
		self:_set_level_description(gui, layout_settings)
	elseif self._level_description then
		self._level_description:update_size(dt, t, self._gui, layout_settings.level_description)
	end

	self._width = layout_settings.background.texture_width
	self._height = layout_settings.background.texture_height
end

function SpawnPointMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	local map = self._map[1]
	local map_layout_settings = MenuHelper:layout_settings(map.config.layout_settings)

	map:update_position(dt, t, map_layout_settings, x + layout_settings.map.offset_x, y + layout_settings.map.offset_y, z + 1)

	local minimap_props = self._minimap_props
	local marker_x = x + layout_settings.map.offset_x
	local marker_y = y + layout_settings.map.offset_y

	minimap_props.texture_scale_x = map:width()
	minimap_props.texture_scale_y = map:height()

	local marker_offset_z = 2

	for _, marker in ipairs(self._objective_markers) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)
		local marker_layout_settings_2

		if marker.config.layout_settings_2 then
			marker_layout_settings_2 = MenuHelper:layout_settings(marker.config.layout_settings_2)
		end

		marker:update_position(dt, t, marker_layout_settings, marker_layout_settings_2, marker_x, marker_y, z + marker_offset_z, minimap_props)

		marker_offset_z = marker_offset_z + 1
	end

	for _, marker in ipairs(self._local_player_marker) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)

		marker:update_position(dt, t, marker_layout_settings, marker_x, marker_y, z + marker_offset_z, minimap_props)

		marker_offset_z = marker_offset_z + 1
	end

	for _, spawn_area in ipairs(self._spawn_areas) do
		local spawn_area_layout_settings = MenuHelper:layout_settings(spawn_area.config.layout_settings)

		spawn_area:update_position(dt, t, spawn_area_layout_settings, marker_x, marker_y, z + marker_offset_z, minimap_props)

		marker_offset_z = marker_offset_z + 1
	end

	for _, marker in ipairs(self._squad_markers) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)

		marker:update_position(dt, t, marker_layout_settings, marker_x, marker_y, z + marker_offset_z, minimap_props)

		marker_offset_z = marker_offset_z + 1
	end

	local obj_desc_x = x + layout_settings.objectives_description.offset_x
	local obj_desc_y = y + layout_settings.objectives_description.offset_y - self._objectives_description:height()

	self._objectives_description:update_position(dt, t, layout_settings.objectives_description, obj_desc_x, obj_desc_y, z + 1)

	local level_desc_x = x + layout_settings.level_description.offset_x
	local level_desc_y = obj_desc_y + layout_settings.level_description.offset_y - self._level_description:height()

	self._level_description:update_position(dt, t, layout_settings.objectives_description, level_desc_x, level_desc_y, z + 1)

	self._x = x
	self._y = y
	self._z = z
end

function SpawnPointMenuContainer:render(dt, t, gui, layout_settings)
	local map = self._map[1]
	local map_layout_settings = MenuHelper:layout_settings(map.config.layout_settings)

	map:render(dt, t, gui, map_layout_settings, self._minimap_props)

	for _, marker in ipairs(self._objective_markers) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)
		local marker_layout_settings_2

		if marker.config.layout_settings_2 then
			marker_layout_settings_2 = MenuHelper:layout_settings(marker.config.layout_settings_2)
		end

		marker:render(dt, t, gui, marker_layout_settings, marker_layout_settings_2, self._minimap_props)
	end

	for _, marker in ipairs(self._squad_markers) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)

		marker:render(dt, t, gui, marker_layout_settings, self._minimap_props)
	end

	for _, marker in ipairs(self._local_player_marker) do
		local marker_layout_settings = MenuHelper:layout_settings(marker.config.layout_settings)

		marker:render(dt, t, gui, marker_layout_settings, self._minimap_props)
	end

	for _, spawn_area in ipairs(self._spawn_areas) do
		local spawn_area_layout_settings = MenuHelper:layout_settings(spawn_area.config.layout_settings)

		spawn_area:render(dt, t, gui, spawn_area_layout_settings, self._minimap_props)
	end

	Gui.bitmap(gui, layout_settings.background.texture, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(layout_settings.background.texture_width, layout_settings.background.texture_height))
	Gui.bitmap(gui, layout_settings.corner_top_texture.texture, Vector3(math.floor(self._x + layout_settings.corner_top_texture.texture_offset_x), math.floor(self._y + layout_settings.corner_top_texture.texture_offset_y), self._z + 1), Vector2(layout_settings.corner_top_texture.texture_width, layout_settings.corner_top_texture.texture_height))
	Gui.bitmap(gui, layout_settings.corner_bottom_texture.texture, Vector3(math.floor(self._x + layout_settings.corner_bottom_texture.texture_offset_x), math.floor(self._y + layout_settings.corner_bottom_texture.texture_offset_y), self._z + 1), Vector2(layout_settings.corner_bottom_texture.texture_width, layout_settings.corner_bottom_texture.texture_height))
	Gui.bitmap(gui, layout_settings.header.texture, Vector3(math.floor(self._x), math.floor(self._y + layout_settings.header.texture_offset_y), self._z + 1), Vector2(layout_settings.header.texture_width, layout_settings.header.texture_height))

	local header_c = layout_settings.header.text_color
	local header_color = Color(header_c[1], header_c[2], header_c[3], header_c[4])

	ScriptGUI.text(gui, L("menu_select_a_spawnpoint"), MenuSettings.fonts.menu_font.font, layout_settings.header.font_size, MenuSettings.fonts.menu_font.material, Vector3(math.floor(self._x + layout_settings.header.text_offset_x), math.floor(self._y + layout_settings.header.text_offset_y), self._z + 2), header_color)

	local font = layout_settings.objectives_header.font and layout_settings.objectives_header.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.objectives_header.font and layout_settings.objectives_header.font.material or MenuSettings.fonts.menu_font.material
	local obj_header_c = layout_settings.objectives_header.text_color
	local obj_header_color = Color(obj_header_c[1], obj_header_c[2], obj_header_c[3], obj_header_c[4])

	ScriptGUI.text(gui, L("menu_objectives"), font, layout_settings.objectives_header.font_size, font_material, Vector3(math.floor(self._x + layout_settings.objectives_header.text_offset_x), math.floor(self._y + layout_settings.objectives_header.text_offset_y), self._z + 2), obj_header_color)
	self._objectives_description:render(dt, t, gui, layout_settings.objectives_description)

	local font = layout_settings.level_header.font and layout_settings.level_header.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.level_header.font and layout_settings.level_header.font.material or MenuSettings.fonts.menu_font.material
	local level_header_y = self._objectives_description:y() + layout_settings.level_header.text_offset_y
	local level_header_c = layout_settings.level_header.text_color
	local level_header_color = Color(level_header_c[1], level_header_c[2], level_header_c[3], level_header_c[4])
	local level_name = LevelHelper:current_level_settings().display_name

	ScriptGUI.text(gui, L(level_name), font, layout_settings.level_header.font_size, font_material, Vector3(math.floor(self._x + layout_settings.level_header.text_offset_x), math.floor(level_header_y), self._z + 2), level_header_color)
	self._level_description:render(dt, t, gui, layout_settings.level_description)
end

function SpawnPointMenuContainer.create_from_config(local_player, map, markers, spawn_areas, objective_markers, local_player_marker)
	return SpawnPointMenuContainer:new(local_player, map, markers, spawn_areas, objective_markers, local_player_marker)
end
