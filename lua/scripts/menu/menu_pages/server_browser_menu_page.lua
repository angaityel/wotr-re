-- chunkname: @scripts/menu/menu_pages/server_browser_menu_page.lua

require("scripts/menu/menu_containers/item_grid_menu_container")
require("scripts/helpers/steam_helper")
require("scripts/settings/demo_settings")

ServerBrowserMenuPage = class(ServerBrowserMenuPage, SheetMenuPage)

function ServerBrowserMenuPage:init(config, item_groups, world)
	ServerBrowserMenuPage.super.init(self, config, item_groups, world)

	self._world = world

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._server_type_tabs = ItemGridMenuContainer.create_from_config(item_groups.server_type_tabs)
	self._browser = ItemGridMenuContainer.create_from_config(item_groups.browser_items, item_groups.browser_header, item_groups.browser_scroll_bar)
	self._browser_frame = FrameTextureMenuContainer.create_from_config()
	self._browser_local_filters = ItemGridMenuContainer.create_from_config(item_groups.browser_local_filters)
	self._browser_query_filters = ItemGridMenuContainer.create_from_config(item_groups.browser_query_filters)
	self._browser_buttons = ItemGridMenuContainer.create_from_config(item_groups.browser_buttons)
	self._overlay_texture = FrameTextureMenuContainer.create_from_config()
	self._server_info = ItemGridMenuContainer.create_from_config(item_groups.server_info)
	self._player_info = ItemGridMenuContainer.create_from_config(item_groups.player_info_items, item_groups.player_info_header, item_groups.player_info_scroll_bar)
	self._info_frame = FrameTextureMenuContainer.create_from_config()
	self._selected_server_num = nil
	self._render_info = false
	self._server_item_select_time = 0
	self._server_list = {}
	self._query_filters = {}
	self._local_filters = {}
	self._friends = {}

	self:_setup_popups()
	Managers.state.event:register(self, "denied_to_enter_game", "event_denied_to_enter_game")
end

function ServerBrowserMenuPage:event_denied_to_enter_game(reason)
	self._error_reason = reason
end

function ServerBrowserMenuPage:_setup_popups()
	self._demo_page = MenuHelper:create_locked_in_demo_popup_page(self._world, self, self.config.z, self.config.sounds)
	self._filter_page = MenuHelper:create_filter_popup_page(self._world, self, self.config.z, self.config.sounds)
end

function ServerBrowserMenuPage:on_enter(on_cancel)
	ServerBrowserMenuPage.super.on_enter(self, on_cancel)

	if not on_cancel then
		local sort_item = self:find_item_by_name("latency")

		sort_item:set_selected(false)
		sort_item:on_select()
		self:_update_server_type_tabs()
		self:_refresh_all_servers()
	end

	if self._debug then
		local num_servers = math.random(1, 100)

		for i = 1, num_servers do
			local server = {
				max_players = 20,
				valid = true,
				lobby_num = i,
				password = math.random(1, 2) == 1,
				secure = math.random(1, 2) == 1,
				favorite = math.random(1, 2) == 1,
				server_name = "Test " .. i,
				game_mode_key = math.random(1, 2) == 1 and "tdm" or "con",
				num_players = math.random(1, 20),
				map = L(LevelSettings[math.random(1, 2) == 1 and "town_02" or "forest_01"].display_name),
				ping = math.random(1, 20),
				steam_id = "Steam_id_" .. i
			}

			self:_add_server(server)
		end
	end
end

function ServerBrowserMenuPage:_create_debug_players()
	local players = {}
	local num_players = math.random(1, 64)

	for i = 1, num_players do
		local player = {
			name = "Player " .. i,
			score = math.random(1, 200),
			rank = math.random(1, 20)
		}

		players[#players + 1] = player
	end

	self._debug_players = players
end

function ServerBrowserMenuPage:on_exit(on_cancel)
	ServerBrowserMenuPage.super.on_exit(self, on_cancel)

	if on_cancel then
		Managers.lobby:reset()
	end
end

function ServerBrowserMenuPage:_refresh_all_servers()
	self._selected_server_num = nil

	self:find_item_by_name("quick_refresh"):update_disabled()
	self:find_item_by_name("connect"):update_disabled()

	self._render_info = false
	self._server_list = {}

	self:remove_items("browser_items")
	self:remove_items("favorite_items")
	self:remove_items("player_info_items")
	Managers.lobby:set_server_browser_filters(self._query_filters)
	Managers.lobby:refresh_server_browser()
	self:_refresh_friends()
end

function ServerBrowserMenuPage:_refresh_selected_server()
	Managers.lobby:refresh_server(self._selected_server_num)
	self:_request_players(self._selected_server_num)
	self:_refresh_friends()
end

function ServerBrowserMenuPage:_refresh_friends()
	local friends = SteamHelper.friends()

	for id, data in pairs(self._friends) do
		if not friends[id] then
			self._friends[id] = nil
		end
	end

	for id, data in pairs(friends) do
		if not self._friends[id] then
			self._friends[id] = data
		end
	end
end

function ServerBrowserMenuPage:update(dt, t)
	local lobby_manager = Managers.lobby

	if lobby_manager.client then
		self:_update_server_items()

		if self._render_info then
			self:_update_server_info(self._selected_server_num)
			self:_update_player_items(self._selected_server_num)
		end
	end

	if self._connecting_popup_text then
		if lobby_manager.state == LobbyState.JOINING then
			self._connecting_popup_text:set_text(L("menu_connecting_to_server"))

			self._connecting_popup_texture.config.visible = true
			self._connecting_popup_close_button.config.visible = false
			self._popup_page.config.no_cancel_to_parent_page = true
		elseif lobby_manager.state == LobbyState.FAILED then
			local reason = lobby_manager:fail_reason()

			self._connecting_popup_text:set_text(L("menu_connecting_to_server_failed_" .. reason))

			self._connecting_popup_texture.config.visible = false
			self._connecting_popup_close_button.config.visible = true
			self._popup_page.config.no_cancel_to_parent_page = false

			Managers.lobby:reset()
		elseif lobby_manager.state == LobbyState.JOINED and self._error_reason then
			self._connecting_popup_text:set_text(L("menu_reason_" .. self._error_reason))

			self._connecting_popup_texture.config.visible = false
			self._connecting_popup_close_button.config.visible = true
			self._popup_page.config.no_cancel_to_parent_page = false

			Managers.lobby:reset()
		end
	end

	ServerBrowserMenuPage.super.update(self, dt, t)

	if self._controller_password_text then
		self:_connect(self._controller_password_text)

		self._controller_password_text = nil
	end
end

function ServerBrowserMenuPage:_update_server_items()
	local lobby_manager = Managers.lobby
	local servers = lobby_manager:server_browser_content_no_data_request({
		"level_key",
		"game_mode_key"
	})

	if #self._server_list < #servers then
		for _, server in ipairs(servers) do
			if not table.contains(self._server_list, server) then
				self:_add_server(server)

				if self._current_sort then
					self:_sort_server_items(self._current_sort.column, self._current_sort.sort_order)
				end
			end
		end
	end

	self:find_item_by_name("server_name_column_header").config.text = L("menu_servers") .. " (" .. #self._server_list .. ")"

	if self._sort_requested then
		self:_sort_server_items(self._sort_requested.column, self._sort_requested.default_order)

		self._sort_requested = nil
	end
end

function ServerBrowserMenuPage:_update_player_items(server_num)
	local lobby_manager = Managers.lobby
	local players

	if not self._debug then
		players = lobby_manager:players(server_num)
	else
		players = self._debug_players
	end

	if self._players_requested and players then
		for i = 1, #players do
			self:_insert_player_item(players[i])
		end

		self._players_requested = nil
	end
end

function ServerBrowserMenuPage:_update_server_info(server_num)
	local item = self:find_item_by_name(server_num)
	local server = item:server()

	self:find_item_by_name("info_server_name").config.text = server.server_name or ""
	self:find_item_by_name("server_info_description").config.text = server.game_description or ""
	self:find_item_by_name("info_server_map").config.text = L("menu_map_lower") .. ": " .. (server.level_key and LevelSettings[server.level_key] and L(LevelSettings[server.level_key].display_name) or server.level_key or "?")
	self:find_item_by_name("info_server_game_mode").config.text = L("menu_game_mode_lower") .. ": " .. (server.game_mode_key and GameModeSettings[server.game_mode_key] and L(GameModeSettings[server.game_mode_key].display_name) or server.game_mode_key or "?")
	self:find_item_by_name("info_server_type").config.text = L("menu_type_lower") .. ": " .. "?"
	self:find_item_by_name("info_server_password").config.text = L("menu_password_protected_lower") .. ": " .. (server.password == true and L("menu_yes_lower") or server.password == false and L("menu_no_lower") or "?")
	self:find_item_by_name("info_server_players").config.text = L("menu_players_lower") .. ": " .. (server.num_players or "?") .. "/" .. (server and server.max_players or "?")
	self:find_item_by_name("info_server_secure").config.text = L("menu_anti_cheat_lower") .. ": " .. (server.secure == true and L("menu_yes_lower") or server.secure == false and L("menu_no_lower") or "?")
	self:find_item_by_name("info_server_latency").config.text = L("menu_latency_lower") .. ": " .. (server.ping or "?")
end

function ServerBrowserMenuPage:_sort_server_items(column, sort_order)
	local items = self:items_in_group("browser_items")

	if sort_order == "asc" then
		table.sort(items, function(item1, item2)
			return item1:sort_value(column) < item2:sort_value(column)
		end)
	else
		table.sort(items, function(item1, item2)
			return item1:sort_value(column) > item2:sort_value(column)
		end)
	end

	self:_deselect_header_items(column)

	self._current_sort = {
		column = column,
		sort_order = sort_order
	}
end

function ServerBrowserMenuPage:_deselect_server_items(except_server_num)
	local items = self:items_in_group("browser_items")

	for i, item in ipairs(items) do
		if not except_server_num or item.config.name ~= except_server_num then
			item:set_selected(false)
		end
	end
end

function ServerBrowserMenuPage:_deselect_header_items(except_column)
	local header_items = self:items_in_group("browser_header")

	for _, item in ipairs(header_items) do
		if not except_column or item.config.sort_column ~= except_column then
			item:set_selected(false)
		end
	end
end

function ServerBrowserMenuPage:_add_server(server)
	self._server_list[#self._server_list + 1] = server

	if self:_matches_local_server_filters(server) then
		self:_insert_server_item(server)
	end
end

function ServerBrowserMenuPage:_matches_local_server_filters(server)
	local game_mode_match = not self._local_filters.game_mode or self._local_filters.game_mode == server.game_mode_key
	local password_protected_match = self._local_filters.password or not server.password
	local demo_match = not IS_DEMO or not self._local_filters.demo or DemoSettings.available_game_modes[server.game_mode_key]
	local only_available_match = not self._local_filters.only_available or server.valid

	if game_mode_match and password_protected_match and demo_match and only_available_match then
		return true
	end
end

function ServerBrowserMenuPage:_local_server_filters_updated()
	self._selected_server_num = nil
	self._render_info = false

	self:remove_items("browser_items")
	self:remove_items("favorite_items")

	for i, server in ipairs(self._server_list) do
		if self:_matches_local_server_filters(server) then
			self:_insert_server_item(server)
		end
	end

	if self._current_sort then
		self:_sort_server_items(self._current_sort.column, self._current_sort.sort_order)
	end
end

function ServerBrowserMenuPage:_insert_server_item(server)
	local favorite_item_config = {
		on_select = "cb_favorite_item_selected",
		callback_object = "page",
		parent_page = self,
		on_select_args = {
			server
		},
		z = self.config.z + 2,
		layout_settings = ServerBrowserSettings.items.favorite,
		sounds = self.config.sounds.items.texture
	}
	local favorite_item = TextureMenuItem.create_from_config({
		world = self._world
	}, favorite_item_config, self)

	self:add_item(favorite_item, "favorite_items")

	local server_item_config = {
		disabled_func = "cb_server_item_disabled",
		on_select = "cb_server_item_selected",
		name = server.lobby_num,
		on_select_args = {
			server.lobby_num
		},
		disabled_func_args = server,
		z = self.config.z + 1,
		layout_settings = ServerBrowserSettings.items.server,
		parent_page = self,
		server = server,
		friends = self._friends,
		favorite_item = favorite_item
	}
	local server_item = ServerMenuItem.create_from_config({
		world = self._world
	}, server_item_config, self)

	self:add_item(server_item, "browser_items")
end

function ServerBrowserMenuPage:_insert_player_item(player)
	local player_item_config = {
		disabled = true,
		z = self.config.z + 1,
		layout_settings = ServerBrowserSettings.items.player_info,
		parent_page = self,
		player = player
	}
	local player_item = PlayerInfoMenuItem.create_from_config({
		world = self._world
	}, player_item_config, self)

	self:add_item(player_item, "player_info_items")
end

function ServerBrowserMenuPage:_request_players(server_num)
	self:remove_items("player_info_items")

	if not self._debug then
		Managers.lobby:request_players(server_num)
	else
		self:_create_debug_players()
	end

	self._players_requested = true
end

function ServerBrowserMenuPage:_update_server_type_tabs(server_type)
	local server_type = Managers.lobby.server_browse_mode

	self:find_item_by_name("server_type_internet"):set_selected(server_type == "internet")
	self:find_item_by_name("server_type_favorites"):set_selected(server_type == "favorites")
	self:find_item_by_name("server_type_history"):set_selected(server_type == "history")
	self:find_item_by_name("server_type_friends"):set_selected(server_type == "friends")
	self:find_item_by_name("server_type_lan"):set_selected(server_type == "lan")
end

function ServerBrowserMenuPage:_update_container_size(dt, t)
	ServerBrowserMenuPage.super._update_container_size(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._server_type_tabs:update_size(dt, t, self._gui, layout_settings.server_type_tabs)

	if self._render_info then
		self._browser:update_size(dt, t, self._gui, layout_settings.browser_compact)
		self._browser_frame:update_size(dt, t, self._gui, layout_settings.browser_frame_compact)
	else
		self._browser:update_size(dt, t, self._gui, layout_settings.browser)
		self._browser_frame:update_size(dt, t, self._gui, layout_settings.browser_frame)
	end

	self._browser_query_filters:update_size(dt, t, self._gui, layout_settings.browser_query_filters)
	self._browser_local_filters:update_size(dt, t, self._gui, layout_settings.browser_local_filters)
	self._browser_buttons:update_size(dt, t, self._gui, layout_settings.browser_buttons)
	self._overlay_texture:update_size(dt, t, self._gui, layout_settings.overlay_texture)
	self._server_info:update_size(dt, t, self._gui, layout_settings.server_info)
	self._player_info:update_size(dt, t, self._gui, layout_settings.player_info)
	self._info_frame:update_size(dt, t, self._gui, layout_settings.info_frame)
end

function ServerBrowserMenuPage:_update_container_position(dt, t)
	ServerBrowserMenuPage.super._update_container_position(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._server_type_tabs, layout_settings.server_type_tabs)

	self._server_type_tabs:update_position(dt, t, layout_settings.server_type_tabs, x, y, self.config.z + 5)

	if self._render_info then
		local x, y = MenuHelper:container_position(self._browser, layout_settings.browser_compact)

		self._browser:update_position(dt, t, layout_settings.browser_compact, x, y, self.config.z + 5)

		local x, y = MenuHelper:container_position(self._browser_frame, layout_settings.browser_frame_compact)

		self._browser_frame:update_position(dt, t, layout_settings.browser_frame_compact, x, y, self.config.z + 10)
	else
		local x, y = MenuHelper:container_position(self._browser, layout_settings.browser)

		self._browser:update_position(dt, t, layout_settings.browser, x, y, self.config.z + 5)

		local x, y = MenuHelper:container_position(self._browser_frame, layout_settings.browser_frame)

		self._browser_frame:update_position(dt, t, layout_settings.browser_frame, x, y, self.config.z + 10)
	end

	local x, y = MenuHelper:container_position(self._browser_local_filters, layout_settings.browser_local_filters)

	self._browser_local_filters:update_position(dt, t, layout_settings.browser_local_filters, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._browser_query_filters, layout_settings.browser_query_filters)

	self._browser_query_filters:update_position(dt, t, layout_settings.browser_query_filters, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._browser_buttons, layout_settings.browser_buttons)

	self._browser_buttons:update_position(dt, t, layout_settings.browser_buttons, x, y, self.config.z + 5)

	local x, y = MenuHelper:container_position(self._overlay_texture, layout_settings.overlay_texture)

	self._overlay_texture:update_position(dt, t, layout_settings.overlay_texture, x, y, self.config.z + 40)

	local x, y = MenuHelper:container_position(self._server_info, layout_settings.server_info)

	self._server_info:update_position(dt, t, layout_settings.server_info, x, y, self.config.z + 15)

	local x, y = MenuHelper:container_position(self._player_info, layout_settings.player_info)

	self._player_info:update_position(dt, t, layout_settings.player_info, x, y, self.config.z + 20)

	local x, y = MenuHelper:container_position(self._info_frame, layout_settings.info_frame)

	self._info_frame:update_position(dt, t, layout_settings.info_frame, x, y, self.config.z + 25)
end

function ServerBrowserMenuPage:render(dt, t)
	ServerBrowserMenuPage.super.render(self, dt, t)

	local controller_active = Managers.input:pad_active(1)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._server_type_tabs:render(dt, t, self._gui, layout_settings.server_type_tabs)

	if self._render_info then
		self._browser:render(dt, t, self._gui, layout_settings.browser_compact)
		self._browser_frame:render(dt, t, self._gui, layout_settings.browser_frame_compact)
	else
		self._browser:render(dt, t, self._gui, layout_settings.browser)
		self._browser_frame:render(dt, t, self._gui, layout_settings.browser_frame)
	end

	if not controller_active then
		self._browser_local_filters:render(dt, t, self._gui, layout_settings.browser_local_filters)
		self._browser_query_filters:render(dt, t, self._gui, layout_settings.browser_query_filters)
		self._browser_buttons:render(dt, t, self._gui, layout_settings.browser_buttons)
	end

	self._overlay_texture:render(dt, t, self._gui, layout_settings.overlay_texture)

	if self._render_info then
		self._server_info:render(dt, t, self._gui, layout_settings.server_info)
		self._player_info:render(dt, t, self._gui, layout_settings.player_info)
		self._info_frame:render(dt, t, self._gui, layout_settings.info_frame)
	end
end

function ServerBrowserMenuPage:_render_button_info(layout_settings)
	local x = self._server_type_tabs:x()
	local y = self._server_type_tabs:y()
	local width = self._server_type_tabs:width()
	local w, h = Gui.resolution()
	local material, uv00, uv11, size = self:get_button_bitmap("left_button")

	Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(x - size[1], y, 999), size)

	local material, uv00, uv11, size = self:get_button_bitmap("right_button")

	Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(w - x, y, 999), size)

	local button_config = layout_settings.default_buttons
	local text_data = layout_settings.text_data
	local x = self._browser_frame:x() + (text_data.offset_x or 0)
	local y = self._browser_frame:y() + (text_data.offset_x or 0)
	local offset_x = 0

	for _, button in ipairs(button_config) do
		local material, uv00, uv11, size = self:get_button_bitmap(button.button_name)

		Gui.bitmap_uv(self._button_gui, material, uv00, uv11, Vector3(x + offset_x, y - size[2], 999), size)

		local text = string.upper(L(button.text))

		Gui.text(self._button_gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + size[1] + offset_x, y - size[2] * 0.62, 999))

		if text_data.drop_shadow then
			local drop_x, drop_y = unpack(text_data.drop_shadow)

			Gui.text(self._button_gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + size[1] + offset_x + drop_x, y - size[2] * 0.62 + drop_y, 998), Color(0, 0, 0))
		end

		local min, max = Gui.text_extents(self._button_gui, text, text_data.font.font, text_data.font_size)

		offset_x = offset_x + (max[1] - min[1]) + size[2]
	end
end

function ServerBrowserMenuPage:_update_server_highlight(direction)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if layout_settings.browser.number_of_visible_rows then
		local new_index = self._browser:top_visible_row() - 1 + (self._relative_index or 1)
		local items = self._browser:items()
		local server_item, server_index

		for i = new_index, #items do
			if items[i]:highlightable() then
				server_index = i
				server_item = items[i]

				break
			end
		end

		if not server_item or not server_index then
			return nil
		end

		for index, item in pairs(self._items) do
			local is_server = item.config.type == "server"

			if is_server and item._server.steam_id == server_item._server.steam_id then
				self._server_item_highlighted_index = server_index

				self:_highlight_item(index)

				break
			end
		end
	end
end

function ServerBrowserMenuPage:_find_first_server_item()
	local server_item, server_index

	for index, potential_server_item in ipairs(self._browser:items()) do
		if potential_server_item:highlightable() then
			server_index = index
			server_item = potential_server_item

			break
		end
	end

	if not server_item or not server_index then
		return nil
	end

	for index, item in pairs(self._items) do
		local is_server = item.config.type == "server"

		if is_server and item._server.steam_id == server_item._server.steam_id then
			self._server_item_highlighted_index = server_index
			self._relative_index = 1

			return index
		end
	end
end

function ServerBrowserMenuPage:_highlight_next_server_item_index()
	local current_index = self._server_item_highlighted_index or 1
	local items = self._browser:items()
	local server_item, server_index

	for i = current_index + 1, #items do
		if items[i] and items[i]:highlightable() then
			server_index = i
			server_item = items[i]

			break
		end
	end

	if not server_item or not server_index then
		return nil
	end

	for index, item in pairs(self._items) do
		local is_server = item.config.type == "server"

		if is_server and item._server.steam_id == server_item._server.steam_id then
			self._server_item_highlighted_index = server_index

			self:_highlight_item(index)

			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._relative_index = (self._relative_index or 0) + 1

			if self._relative_index > layout_settings.browser.number_of_visible_rows then
				self._relative_index = layout_settings.browser.number_of_visible_rows

				self._browser:scroll_down(layout_settings.browser)
				self:_update_server_highlight()
			end

			break
		end
	end

	print(self._server_item_highlighted_index, self._current_highlight)
end

function ServerBrowserMenuPage:_highlight_prev_server_item_index()
	local current_index = self._server_item_highlighted_index or 1
	local items = self._browser:items()
	local server_item, server_index

	for i = current_index - 1, 1, -1 do
		if items[i] and items[i]:highlightable() then
			server_index = i
			server_item = items[i]

			break
		end
	end

	if not server_item or not server_index then
		return nil
	end

	for index, item in pairs(self._items) do
		local is_server = item.config.type == "server"

		if is_server and item._server.steam_id == server_item._server.steam_id then
			self._server_item_highlighted_index = server_index

			self:_highlight_item(index)

			self._relative_index = (self._relative_index or 0) - 1

			if self._relative_index < 1 then
				self._relative_index = 1

				self._browser:scroll_up()
				self:_update_server_highlight()
			end

			break
		end
	end

	print(self._server_item_highlighted_index, self._current_highlight)
end

function ServerBrowserMenuPage:move_up()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		self:_highlight_prev_server_item_index()
	else
		MenuPage.move_up(self)
	end
end

function ServerBrowserMenuPage:move_down()
	local controller_active = Managers.input:pad_active(1)

	if controller_active then
		self:_highlight_next_server_item_index()
	else
		MenuPage.move_down(self)
	end
end

function ServerBrowserMenuPage:_update_input(input)
	ServerBrowserMenuPage.super._update_input(self, input)

	local controller_active = Managers.input:pad_active(1)

	if (not input or not self._mouse) and not controller_active then
		return
	end

	if controller_active then
		local highlighted_item = self:_highlighted_item()

		if not highlighted_item or highlighted_item.config.type ~= "server" then
			local index = self:_find_first_server_item()

			self:_highlight_item(index)
		end

		local y = input:get("right_wheel").y

		if y > 0.9 then
			self._player_info:scroll_up()
		elseif y < -0.9 then
			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._player_info:scroll_down(layout_settings.player_info)
		end
	end

	if input:has("wheel") and input:get("wheel").y ~= 0 then
		local y = input:get("wheel").y
		local mouse_pos = input:get("cursor")

		if y > 0.9 then
			if controller_active or self._browser:is_mouse_inside(mouse_pos.x, mouse_pos.y) then
				self._browser:scroll_up()

				if controller_active then
					self:_update_server_highlight()
				end
			elseif mouse_pos and self._player_info:is_mouse_inside(mouse_pos.x, mouse_pos.y) then
				self._player_info:scroll_up()
			end
		elseif y < -0.9 then
			if controller_active or self._browser:is_mouse_inside(mouse_pos.x, mouse_pos.y) then
				local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

				self._browser:scroll_down(layout_settings.browser)

				if controller_active then
					self:_update_server_highlight()
				end
			elseif mouse_pos and self._player_info:is_mouse_inside(mouse_pos.x, mouse_pos.y) then
				local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

				self._player_info:scroll_down(layout_settings.player_info)
			end
		end
	end

	if controller_active then
		if input:get("show_filters") then
			self._menu_logic:change_page(self._filter_page)
		end

		if input:get("refresh") then
			self:cb_refresh_all()
		end

		if input:get("mark_favorite") then
			self:mark_server_as_favorite()
		end

		if input:get("tab_left") then
			local tabs = self:find_items_by_type_in_group("server_type_tabs", "tab")
			local selected_tab = self:_find_selected_item(tabs)
			local new_tab = math.max(selected_tab - 1, 1)

			self:cb_set_server_type(tabs[new_tab].config.on_select_args[1])
		end

		if input:get("tab_right") then
			local tabs = self:find_items_by_type_in_group("server_type_tabs", "tab")
			local num_tabs = #tabs
			local selected_tab = self:_find_selected_item(tabs)
			local new_tab = math.min(selected_tab + 1, num_tabs)

			self:cb_set_server_type(tabs[new_tab].config.on_select_args[1])
		end
	end
end

function ServerBrowserMenuPage:_find_selected_item(items)
	for i, item in pairs(items) do
		if item:selected() then
			return i
		end
	end
end

function ServerBrowserMenuPage:_connect(password)
	local item = self:find_item_by_name(self._selected_server_num)

	if not item then
		return
	end

	if IS_DEMO then
		local game_mode_unlocked = DemoSettings.available_game_modes[item:server().game_mode_key]

		if not game_mode_unlocked then
			self._menu_logic:change_page(self._demo_page)

			return
		end
	end

	if item.config.server.password and not password then
		self._menu_logic:change_page(self:find_item_by_name("password_popup").config.page)
	else
		self._menu_logic:change_page(self:find_item_by_name("connecting_popup").config.page)

		self._error_reason = nil

		Managers.lobby:join_server(self._selected_server_num, password)
	end
end

function ServerBrowserMenuPage:cb_set_server_type(server_type)
	Managers.lobby:set_server_browse_mode(server_type)
	self:_refresh_all_servers()
	self:_update_server_type_tabs()
end

function ServerBrowserMenuPage:cb_server_type_lan_visible()
	return not GameSettingsDevelopment.hide_lan_tab
end

function ServerBrowserMenuPage:cb_sort_browser(column, default_order)
	self._sort_requested = {
		column = column,
		default_order = default_order
	}
end

function ServerBrowserMenuPage:_cancel()
	if self._render_info then
		self:cb_close_server_info()
	else
		self.super._cancel(self)
	end
end

function ServerBrowserMenuPage:cb_server_item_selected(server_num)
	self:_deselect_server_items(server_num)

	if self._selected_server_num ~= server_num then
		Managers.lobby:request_server_data(server_num)
		self:_request_players(server_num)
	end

	local same_server = self._selected_server_num == server_num

	self._selected_server_num = server_num

	local controller_active = Managers.input:pad_active(1)

	if controller_active and self._render_info and same_server then
		self:_connect(nil)
	else
		local t = Managers.time:time("main")

		if t - self._server_item_select_time < MenuSettings.double_click_threshold then
			self:_connect(nil)
		end

		self._server_item_select_time = t
	end

	self._render_info = true
end

function ServerBrowserMenuPage:cb_favorite_item_selected(server)
	local server_num = server.lobby_num
	local item = self:find_item_by_name(server_num)

	if item:is_favorite() then
		Managers.lobby:remove_favorite(server_num)
		item:set_favorite(false)
	else
		Managers.lobby:add_favorite(server_num)
		item:set_favorite(true)
	end
end

function ServerBrowserMenuPage:mark_server_as_favorite()
	local current_index = self._server_item_highlighted_index or 1
	local items = self._browser:items()
	local item = items[current_index]

	if not item then
		return
	end

	if item:is_favorite() then
		Managers.lobby:remove_favorite(item._server.lobby_num)
		item:set_favorite(false)
	else
		Managers.lobby:add_favorite(item._server.lobby_num)
		item:set_favorite(true)
	end
end

function ServerBrowserMenuPage:cb_server_item_disabled(server)
	return not server.valid
end

function ServerBrowserMenuPage:cb_quick_refresh()
	self:_refresh_selected_server()
end

function ServerBrowserMenuPage:cb_refresh_all()
	self:_refresh_all_servers()
end

function ServerBrowserMenuPage:cb_connect()
	self:_connect(nil)
end

function ServerBrowserMenuPage:cb_quick_refresh_button_disabled()
	return not self._selected_server_num
end

function ServerBrowserMenuPage:cb_connect_button_disabled()
	return not self._selected_server_num
end

function ServerBrowserMenuPage:cb_browser_scroll_select_down(row)
	self._browser:set_top_visible_row(row)
end

function ServerBrowserMenuPage:cb_player_info_scroll_select_down(row)
	self._player_info:set_top_visible_row(row)
end

function ServerBrowserMenuPage:cb_browser_scroll_disabled()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if self._render_info then
		return not self._browser:can_scroll(layout_settings.browser_compact)
	else
		return not self._browser:can_scroll(layout_settings.browser)
	end
end

function ServerBrowserMenuPage:cb_player_info_scroll_disabled()
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local can_scroll = self._player_info:can_scroll(layout_settings.player_info)

	return not can_scroll or not self._render_info
end

function ServerBrowserMenuPage:cb_close_server_info()
	self:_deselect_server_items(nil)

	self._selected_server_num = nil
	self._render_info = false
end

function ServerBrowserMenuPage:cb_demo_checkbox_remove()
	return not IS_DEMO
end

function ServerBrowserMenuPage:cb_on_enter_query_filter_not_full()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "not_full")

	if saved_option == true then
		self._query_filters.full = ""
	else
		self._query_filters.full = nil
	end

	return saved_option == true
end

function ServerBrowserMenuPage:cb_on_select_query_filter_not_full_popup()
	local value = Application.win32_user_setting("server_browser_filter_settings", "not_full")

	value = not value
	self._query_filters.full = value and "" or nil

	self:_refresh_all_servers()
	Application.set_win32_user_setting("server_browser_filter_settings", "not_full", value)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_select_query_filter_not_full()
	local checkbox_item = self:find_item_by_name("query_filter_not_full")
	local checkbox_selected = checkbox_item:selected()

	if checkbox_selected == true then
		self._query_filters.full = ""
	else
		self._query_filters.full = nil
	end

	Application.set_win32_user_setting("server_browser_filter_settings", "not_full", checkbox_selected)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_enter_query_filter_has_players()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "has_players")

	if saved_option == true then
		self._query_filters.empty = ""
	else
		self._query_filters.empty = nil
	end

	return saved_option == true
end

function ServerBrowserMenuPage:cb_on_select_query_filter_has_players_popup()
	local value = Application.win32_user_setting("server_browser_filter_settings", "has_players")

	value = not value
	self._query_filters.empty = value and "" or nil

	self:_refresh_all_servers()
	Application.set_win32_user_setting("server_browser_filter_settings", "has_players", value)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_select_query_filter_has_players()
	local checkbox_item = self:find_item_by_name("query_filter_has_players")
	local checkbox_selected = checkbox_item:selected()

	if checkbox_selected == true then
		self._query_filters.empty = ""
	else
		self._query_filters.empty = nil
	end

	Application.set_win32_user_setting("server_browser_filter_settings", "has_players", checkbox_selected)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_enter_text_query_filter_level()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "level")
	local description_text = L("menu_map") .. ": "
	local value_text = saved_option and saved_option ~= "" and LevelSettings[saved_option] and L(LevelSettings[saved_option].display_name) or L("menu_server_all")

	if saved_option and saved_option ~= "" and LevelSettings[saved_option] then
		self._query_filters.map = LevelSettings[saved_option].game_server_map_name
	else
		self._query_filters.map = nil
	end

	return description_text, value_text
end

function ServerBrowserMenuPage:cb_on_enter_options_query_filter_level()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "level")
	local options = {}
	local selected_index = 1

	options[#options + 1] = {
		key = "",
		value = L("menu_server_all")
	}

	for key, level in pairs(LevelSettings) do
		if level.show_in_server_browser then
			options[#options + 1] = {
				key = key,
				value = L(level.display_name)
			}

			if saved_option and saved_option == key then
				selected_index = #options
			end
		end
	end

	return options, selected_index
end

function ServerBrowserMenuPage:cb_on_option_changed_query_filter_level_popup(option)
	if option.key ~= "" and LevelSettings[option.key] then
		self._query_filters.map = LevelSettings[option.key].game_server_map_name
	else
		self._query_filters.map = nil
	end

	self:_refresh_all_servers()
	Application.set_win32_user_setting("server_browser_filter_settings", "level", option.key)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_option_changed_query_filter_level(option)
	if option.key ~= "" and LevelSettings[option.key] then
		self._query_filters.map = LevelSettings[option.key].game_server_map_name
	else
		self._query_filters.map = nil
	end

	Application.set_win32_user_setting("server_browser_filter_settings", "level", option.key)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_enter_local_filter_password()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "password_protected")

	if saved_option == true then
		self._local_filters.password = true
	else
		self._local_filters.password = false
	end

	return saved_option == true
end

function ServerBrowserMenuPage:cb_on_select_local_filter_password_popup()
	local value = Application.win32_user_setting("server_browser_filter_settings", "password_protected")

	value = not value
	self._local_filters.password = value

	self:_local_server_filters_updated()
	Application.set_win32_user_setting("server_browser_filter_settings", "password_protected", value)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_select_local_filter_password()
	local checkbox_item = self:find_item_by_name("local_filter_password")
	local checkbox_selected = checkbox_item:selected()

	if checkbox_selected == true then
		self._local_filters.password = true
	else
		self._local_filters.password = false
	end

	self:_local_server_filters_updated()
	Application.set_win32_user_setting("server_browser_filter_settings", "password_protected", checkbox_selected)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_enter_local_filter_demo()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "demo")

	if saved_option == true then
		self._local_filters.demo = true
	else
		self._local_filters.demo = false
	end

	return saved_option == true
end

function ServerBrowserMenuPage:cb_on_select_local_filter_demo_popup()
	local value = Application.win32_user_setting("server_browser_filter_settings", "demo")

	value = not value
	self._local_filters.demo = value

	self:_local_server_filters_updated()
	Application.set_win32_user_setting("server_browser_filter_settings", "demo", value)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_select_local_filter_demo()
	local checkbox_item = self:find_item_by_name("local_filter_demo")
	local checkbox_selected = checkbox_item:selected()

	if checkbox_selected == true then
		self._local_filters.demo = true
	else
		self._local_filters.demo = false
	end

	self:_local_server_filters_updated()
	Application.set_win32_user_setting("server_browser_filter_settings", "demo", checkbox_selected)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_enter_local_filter_only_available()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "only_available")

	if saved_option == true then
		self._local_filters.only_available = true
	else
		self._local_filters.only_available = false
	end

	return saved_option == true
end

function ServerBrowserMenuPage:cb_on_select_local_filter_only_available_popup()
	local value = Application.win32_user_setting("server_browser_filter_settings", "only_available")

	value = not value
	self._local_filters.only_available = value

	self:_local_server_filters_updated()
	Application.set_win32_user_setting("server_browser_filter_settings", "only_available", value)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_select_local_filter_only_available()
	local checkbox_item = self:find_item_by_name("local_filter_only_available")
	local checkbox_selected = checkbox_item:selected()

	if checkbox_selected == true then
		self._local_filters.only_available = true
	else
		self._local_filters.only_available = false
	end

	self:_local_server_filters_updated()
	Application.set_win32_user_setting("server_browser_filter_settings", "only_available", checkbox_selected)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_on_enter_text_local_filter_game_mode()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "game_mode")
	local description_text = L("menu_game_mode") .. ": "
	local value_text = saved_option and saved_option ~= "" and GameModeSettings[saved_option] and L(GameModeSettings[saved_option].display_name) or L("menu_server_all")

	if saved_option and saved_option ~= "" and GameModeSettings[saved_option] then
		self._local_filters.game_mode = saved_option
	else
		self._local_filters.game_mode = nil
	end

	return description_text, value_text
end

function ServerBrowserMenuPage:cb_on_enter_options_local_filter_game_mode()
	local saved_option = Application.win32_user_setting("server_browser_filter_settings", "game_mode")
	local options = {}
	local selected_index = 1
	local levels = {}

	options[#options + 1] = {
		key = "",
		value = L("menu_server_all")
	}

	for key, config in pairs(GameModeSettings) do
		if config.show_in_server_browser then
			options[#options + 1] = {
				key = key,
				value = L(config.display_name)
			}

			if saved_option and saved_option == key then
				selected_index = #options
			end
		end
	end

	return options, selected_index
end

function ServerBrowserMenuPage:cb_on_option_changed_local_filter_game_mode(option)
	if option.key ~= "" and GameModeSettings[option.key] then
		self._local_filters.game_mode = option.key
	else
		self._local_filters.game_mode = nil
	end

	self:_local_server_filters_updated()
	Application.set_win32_user_setting("server_browser_filter_settings", "game_mode", option.key)
	Application.save_win32_user_settings()
end

function ServerBrowserMenuPage:cb_password_popup_enter(args)
	args.popup_page:find_item_by_name("password_input"):set_text(self._password_text or "")
end

function ServerBrowserMenuPage:cb_password_popup_item_selected(args)
	if args.action == "continue" then
		local password_text = args.popup_page:find_item_by_name("password_input"):text()

		self:_connect(password_text)

		self._password_text = password_text
	end
end

function ServerBrowserMenuPage:cb_password_entered_from_controller_input(password_text)
	self._controller_password_text = password_text
end

function ServerBrowserMenuPage:cb_password_popup_continue_disabled(args)
	local password_input_item = args.popup_page:find_item_by_name("password_input")

	if not password_input_item:validate_text_length() then
		return true
	end
end

function ServerBrowserMenuPage:cb_connecting_popup_enter(args)
	self._connecting_popup_text = args.popup_page:find_item_by_name("connecting_text")
	self._connecting_popup_texture = args.popup_page:find_item_by_name("connecting_texture")
	self._connecting_popup_close_button = args.popup_page:find_item_by_name("close_button")
	self._popup_page = args.popup_page
end

function ServerBrowserMenuPage:cb_connecting_popup_item_selected(args)
	self._connecting_popup_text = nil
	self._connecting_popup_texture.config.visible = false
	self._connecting_popup_close_button.config.visible = false
end

function ServerBrowserMenuPage:cb_connecting_popup_cancel(args)
	self._connecting_popup_text = nil
	self._connecting_popup_texture.config.visible = false
	self._connecting_popup_close_button.config.visible = false

	self:_refresh_all_servers()
end

function ServerBrowserMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "server_browser",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment(),
		camera = page_config.camera or parent_page and parent_page:camera()
	}

	return ServerBrowserMenuPage:new(config, item_groups, compiler_data.world)
end
