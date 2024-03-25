-- chunkname: @scripts/menu/menu_containers/server_info_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

ServerInfoMenuContainer = class(ServerInfoMenuContainer, MenuContainer)

function ServerInfoMenuContainer:init(page, player_list_item_group)
	ServerInfoMenuContainer.super.init(self)

	self._page = page
	self._player_list_item_group = player_list_item_group
	self._player_list = ItemListMenuContainer.create_from_config(player_list_item_group)

	self:clear()
end

function ServerInfoMenuContainer:clear()
	self._player_list_item_group = {}
	self._server = nil
end

function ServerInfoMenuContainer:set_server(server)
	self:clear()

	self._server = server

	Managers.lobby:request_players(server.lobby_num)
end

function ServerInfoMenuContainer:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.width
	self._height = layout_settings.height

	local server = self._server

	if not self._server_description then
		self._server_description = TextBoxMenuContainer.create_from_config()
	end

	local server_desc_text = server and server.game_description or ""

	self._server_description:set_text(server_desc_text, layout_settings.server_description, gui)
	self._server_description:update_size(dt, t, gui, layout_settings.server_description)

	if not self._server_info_left then
		self._server_info_left = TextBoxMenuContainer.create_from_config()
	end

	local server_info_left_text = ""

	server_info_left_text = server_info_left_text .. L("menu_map_lower") .. ": " .. (server and server.level_key and L(LevelSettings[server.level_key].display_name) or "?") .. "\n"
	server_info_left_text = server_info_left_text .. L("menu_game_mode_lower") .. ": " .. (server and server.game_mode_key and L(GameModeSettings[server.game_mode_key].display_name) or "?") .. "\n"
	server_info_left_text = server_info_left_text .. L("menu_type_lower") .. ": " .. "?\n"
	server_info_left_text = server_info_left_text .. L("menu_players_lower") .. ": " .. (server and server.num_players or "?") .. "/" .. (server and server.max_players or "?") .. "\n"
	server_info_left_text = server_info_left_text .. L("menu_latency_lower") .. ": " .. (server and server.ping or "?") .. "\n"

	self._server_info_left:set_text(server_info_left_text, layout_settings.server_info_left, gui)
	self._server_info_left:update_size(dt, t, gui, layout_settings.server_info_left)

	if not self._server_info_right then
		self._server_info_right = TextBoxMenuContainer.create_from_config()
	end

	local server_info_right_text = ""

	server_info_right_text = server_info_right_text .. L("menu_location_lower") .. ": " .. "?\n"
	server_info_right_text = server_info_right_text .. L("menu_queue_lower") .. ": " .. "?\n"
	server_info_right_text = server_info_right_text .. L("menu_password_protected_lower") .. ": " .. (server and server.password and L("menu_yes_lower") or L("menu_no_lower")) .. "\n"
	server_info_right_text = server_info_right_text .. L("menu_anti_cheat_lower") .. ": " .. (server and server.secure and L("menu_yes_lower") or L("menu_no_lower")) .. "\n"

	self._server_info_right:set_text(server_info_right_text, layout_settings.server_info_right, gui)
	self._server_info_right:update_size(dt, t, gui, layout_settings.server_info_right)
	self._player_list:update_size(dt, t, self._gui, layout_settings.player_list)
end

function ServerInfoMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	local server_desc_x = x + layout_settings.server_description.offset_x
	local server_desc_y = y + self._height - self._server_description:height() + layout_settings.server_description.offset_y

	self._server_description:update_position(dt, t, layout_settings.server_description, server_desc_x, server_desc_y, z + 1)

	local server_info_left_x = x + layout_settings.server_info_left.offset_x
	local server_info_left_y = y + self._height - self._server_info_left:height() + layout_settings.server_info_left.offset_y

	self._server_info_left:update_position(dt, t, layout_settings.server_info_left, server_info_left_x, server_info_left_y, z + 1)

	local server_info_right_x = x + layout_settings.server_info_right.offset_x
	local server_info_right_y = y + self._height - self._server_info_right:height() + layout_settings.server_info_right.offset_y

	self._server_info_right:update_position(dt, t, layout_settings.server_info_right, server_info_right_x, server_info_right_y, z + 1)

	local player_list_x = x + layout_settings.player_list.offset_x
	local player_list_y = y + self._height + layout_settings.player_list.offset_y

	self._player_list:update_position(dt, t, layout_settings.player_list, player_list_x, player_list_y, z + 1)

	self._x = x
	self._y = y
	self._z = z
end

function ServerInfoMenuContainer:render(dt, t, gui, layout_settings)
	local server = self._server

	if not server then
		return
	end

	local font = layout_settings.server_name.font and layout_settings.server_name.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.server_name.font and layout_settings.server_name.font.material or MenuSettings.fonts.menu_font.material
	local c = layout_settings.server_name.text_color
	local color = Color(c[1], c[2], c[3], c[4])
	local server_name = server.server_name or "?"

	ScriptGUI.text(gui, server_name, font, layout_settings.server_name.font_size, font_material, Vector3(math.floor(self._x + layout_settings.server_name.text_offset_x), math.floor(self._y + self._height + layout_settings.server_name.text_offset_y), self._z + 2), color)

	local c = layout_settings.server_name.background_color
	local color = Color(c[1], c[2], c[3], c[4])

	Gui.rect(gui, Vector3(math.floor(self._x + layout_settings.server_name.background_offset_x), math.floor(self._y + self._height + layout_settings.server_name.background_offset_y), self._z + 1), Vector2(self._width - layout_settings.server_name.background_offset_x, layout_settings.server_name.background_height), color)
	self._server_description:render(dt, t, gui, layout_settings.server_description)
	Gui.bitmap(gui, layout_settings.delimiter.texture, Vector3(math.floor(self._x + layout_settings.delimiter.offset_x), math.floor(self._y + self._height + layout_settings.delimiter.offset_y), self._z + 1), Vector2(layout_settings.delimiter.texture_width, layout_settings.delimiter.texture_height))
	self._server_info_left:render(dt, t, gui, layout_settings.server_info_left)
	self._server_info_right:render(dt, t, gui, layout_settings.server_info_right)
	Gui.bitmap(gui, layout_settings.player_list_header.texture_delimiter_upper, Vector3(math.floor(self._x + layout_settings.player_list_header.texture_delimiter_upper_offset_x), math.floor(self._y + self._height + layout_settings.player_list_header.texture_delimiter_upper_offset_y), self._z + 2), Vector2(layout_settings.player_list_header.texture_delimiter_upper_width, layout_settings.player_list_header.texture_delimiter_upper_height))
	Gui.bitmap(gui, layout_settings.player_list_header.texture_delimiter_lower, Vector3(math.floor(self._x + layout_settings.player_list_header.texture_delimiter_lower_offset_x), math.floor(self._y + self._height + layout_settings.player_list_header.texture_delimiter_lower_offset_y), self._z + 2), Vector2(layout_settings.player_list_header.texture_delimiter_lower_width, layout_settings.player_list_header.texture_delimiter_lower_height))

	local c = layout_settings.player_list_header.background_color
	local color = Color(c[1], c[2], c[3], c[4])

	Gui.rect(gui, Vector3(math.floor(self._x + layout_settings.player_list_header.background_offset_x), math.floor(self._y + self._height + layout_settings.player_list_header.background_offset_y), self._z + 1), Vector2(self._width - layout_settings.player_list_header.background_offset_x, layout_settings.player_list_header.background_height), color)

	local font = layout_settings.player_list_header.font and layout_settings.player_list_header.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.player_list_header.font and layout_settings.player_list_header.font.material or MenuSettings.fonts.menu_font.material
	local c = layout_settings.player_list_header.text_color
	local color = Color(c[1], c[2], c[3], c[4])

	ScriptGUI.text(gui, L("menu_player_name_lower"), font, layout_settings.player_list_header.font_size, font_material, Vector3(math.floor(self._x + layout_settings.player_list_header.text_player_name_offset_x), math.floor(self._y + self._height + layout_settings.player_list_header.text_player_name_offset_y), self._z + 2), color)
	ScriptGUI.text(gui, L("menu_rank_lower"), font, layout_settings.player_list_header.font_size, font_material, Vector3(math.floor(self._x + layout_settings.player_list_header.text_rank_offset_x), math.floor(self._y + self._height + layout_settings.player_list_header.text_rank_offset_y), self._z + 2), color)
	ScriptGUI.text(gui, L("menu_latency_lower"), font, layout_settings.player_list_header.font_size, font_material, Vector3(math.floor(self._x + layout_settings.player_list_header.text_latency_offset_x), math.floor(self._y + self._height + layout_settings.player_list_header.text_latency_offset_y), self._z + 2), color)
	self._player_list:render(dt, t, self._gui, layout_settings.player_list)

	local c = layout_settings.background_color
	local color = Color(c[1], c[2], c[3], c[4])

	Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(layout_settings.width, layout_settings.height), color)
end

function ServerInfoMenuContainer.create_from_config(page, player_list_item_group)
	return ServerInfoMenuContainer:new(page, player_list_item_group)
end
