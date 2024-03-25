-- chunkname: @scripts/menu/menu_items/server_menu_item.lua

ServerMenuItem = class(ServerMenuItem, MenuItem)

function ServerMenuItem:init(config, world)
	ServerMenuItem.super.init(self, config, world)

	self._server = config.server
	self._friends = config.friends
	self._is_favorite = config.server.favorite
	self._sort_values = {}

	self:set_selected(false)
	self:_update_sort_values(config.server)
end

function ServerMenuItem:server()
	return self._server
end

function ServerMenuItem:on_select(ignore_sound)
	self:set_selected(true)
	ServerMenuItem.super.on_select(self, ignore_sound)
end

function ServerMenuItem:on_deselect()
	self:set_selected(false)
end

function ServerMenuItem:set_selected(selected)
	self._selected = selected
end

function ServerMenuItem:selected()
	return self._selected
end

function ServerMenuItem:set_favorite(favorite)
	self._is_favorite = favorite
end

function ServerMenuItem:is_favorite()
	return self._is_favorite
end

function ServerMenuItem:sort_value(key)
	return self._sort_values[key]
end

function ServerMenuItem:update_size(dt, t, gui, layout_settings, w, h)
	self._width = w
	self._height = h
end

function ServerMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function ServerMenuItem:_update_sort_values(server)
	self._sort_values.password = server.password and 1 or 0
	self._sort_values.secure = server.secure and 1 or 0
	self._sort_values.favorite = self._is_favorite and 1 or 0
	self._sort_values.server_name = server.server_name or "?"
	self._sort_values.game_mode = server.game_mode_key and GameModeSettings[server.game_mode_key] and L(GameModeSettings[server.game_mode_key].display_name) or "?"
	self._sort_values.num_players = server.num_players or "?"
	self._sort_values.num_friends = self:_num_friends()
	self._sort_values.map = server.map or "?"
	self._sort_values.latency = server.ping or "?"
end

function ServerMenuItem:set_hidden(hidden)
	ServerMenuItem.super.set_hidden(self, hidden)

	self.config.favorite_item.config.hidden = hidden
end

function ServerMenuItem:render(dt, t, gui, layout_settings)
	local server = self._server

	self:_update_sort_values(server)

	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = self.config.disabled and layout_settings.text_color_disabled or self._selected and layout_settings.text_color_selected or self._highlighted and layout_settings.text_color_highlighted or layout_settings.text_color
	local color = server.valid and Color(c[1], c[2], c[3], c[4]) or Color(255, 255, 0, 0)
	local shadow_color_table = layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	local column_offset_x = 0

	if IS_DEMO then
		local game_mode_unlocked = DemoSettings.available_game_modes[server.game_mode_key]

		if not game_mode_unlocked then
			Gui.bitmap(gui, layout_settings.password_texture, Vector3(math.floor(self._x + column_offset_x + layout_settings.password_texture_offset_x), math.floor(self._y + layout_settings.password_texture_offset_y), self._z + 2), Vector2(math.floor(layout_settings.password_texture_width), math.floor(layout_settings.password_texture_height)))
			ScriptGUI.text(gui, L(layout_settings.demo_text), layout_settings.demo_text_font, layout_settings.demo_text_font_size, layout_settings.demo_text_material, Vector3(math.floor(self._x + column_offset_x + layout_settings.password_texture_offset_x + layout_settings.demo_text_offset_x), math.floor(self._y + layout_settings.password_texture_height * 0.5), self._z + 3), Color(255, 0, 0), shadow_color, shadow_offset)
		elseif server.password then
			Gui.bitmap(gui, layout_settings.password_texture, Vector3(math.floor(self._x + column_offset_x + layout_settings.password_texture_offset_x), math.floor(self._y + layout_settings.password_texture_offset_y), self._z + 2), Vector2(math.floor(layout_settings.password_texture_width), math.floor(layout_settings.password_texture_height)))
		end
	else
		local password = server.password

		if password then
			Gui.bitmap(gui, layout_settings.password_texture, Vector3(math.floor(self._x + column_offset_x + layout_settings.password_texture_offset_x), math.floor(self._y + layout_settings.password_texture_offset_y), self._z + 2), Vector2(math.floor(layout_settings.password_texture_width), math.floor(layout_settings.password_texture_height)))
		end
	end

	column_offset_x = column_offset_x + layout_settings.column_width[1]

	local secure = server.secure

	if secure then
		Gui.bitmap(gui, layout_settings.secure_texture, Vector3(math.floor(self._x + column_offset_x + layout_settings.secure_texture_offset_x), math.floor(self._y + layout_settings.secure_texture_offset_y), self._z + 2), Vector2(math.floor(layout_settings.secure_texture_width), math.floor(layout_settings.secure_texture_height)))
	end

	column_offset_x = column_offset_x + layout_settings.column_width[2]

	self:_update_favorite_item(dt, t, gui, column_offset_x, layout_settings, self._is_favorite)

	column_offset_x = column_offset_x + layout_settings.column_width[3]

	local server_name = server.server_name or "?"
	local server_name_truncated = HUDHelper:crop_text(gui, server_name, font, layout_settings.font_size, layout_settings.column_width[4] - 10, "...")

	ScriptGUI.text(gui, server_name_truncated, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x + layout_settings.text_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[4]

	local game_mode = server.game_mode_key and L(GameModeSettings[server.game_mode_key].display_name) or "?"

	ScriptGUI.text(gui, game_mode, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x + layout_settings.text_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[5]

	local num_players = server.num_players or "?"
	local max_players = server.max_players or "?"

	ScriptGUI.text(gui, num_players .. "/" .. max_players, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x + layout_settings.text_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[6]

	local num_friends = self:_num_friends()

	ScriptGUI.text(gui, num_friends, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x + layout_settings.text_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[7]

	local map = server.map or "?"

	ScriptGUI.text(gui, map, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x + layout_settings.text_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[8]

	local latency = server.ping or "?"

	ScriptGUI.text(gui, latency, font, layout_settings.font_size, font_material, Vector3(math.floor(self._x + column_offset_x + layout_settings.text_offset_x), math.floor(self._y + layout_settings.text_offset_y), self._z + 2), color, shadow_color, shadow_offset)

	column_offset_x = column_offset_x + layout_settings.column_width[9]

	if self._selected then
		local c = layout_settings.background_color_selected
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(self._x, self._y, self._z + 1), Vector2(self._width, self._height), color)
	elseif self._highlighted then
		local c = layout_settings.background_color_highlighted
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(self._x, self._y, self._z + 1), Vector2(self._width, self._height), color)
	end
end

function ServerMenuItem:_update_favorite_item(dt, t, gui, column_offset_x, layout_settings, is_favorite)
	local favorite_item = self.config.favorite_item
	local favorite_item_layout_settings = MenuHelper:layout_settings(favorite_item.config.layout_settings)
	local favorite_item_x = math.floor(self._x + column_offset_x + layout_settings.favorite_texture_offset_x)
	local favorite_item_y = math.floor(self._y + layout_settings.favorite_texture_offset_y)
	local favorite_item_z = self._z + 2

	if is_favorite then
		favorite_item_layout_settings.color = {
			255,
			255,
			255,
			255
		}
	else
		favorite_item_layout_settings.color = {
			100,
			255,
			255,
			255
		}
	end

	favorite_item:update_size(dt, t, gui, favorite_item_layout_settings)
	favorite_item:update_position(dt, t, favorite_item_layout_settings, favorite_item_x, favorite_item_y, favorite_item_z)
	favorite_item:render(dt, t, gui, favorite_item_layout_settings)
end

function ServerMenuItem:_num_friends()
	local num_friends = 0

	for id, data in pairs(self._friends) do
		local game = data.playing_game

		if game and game.app_id == Steam.app_id() and game.ip == self._server.ip_address and game.server_port == self._server.connection_port then
			num_friends = num_friends + 1
		end
	end

	return num_friends
end

function ServerMenuItem:visible_in_demo()
	return IS_DEMO and not DemoSettings.available_game_modes[self._server.game_mode_key]
end

function ServerMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "server",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.server,
		server = config.server,
		friends = config.friends,
		favorite_item = config.favorite_item
	}

	return ServerMenuItem:new(config, compiler_data.world)
end
