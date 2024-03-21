-- chunkname: @scripts/menu/menu_items/lobby_join_menu_item.lua

LobbyJoinMenuItem = class(LobbyJoinMenuItem, MenuItem)

function LobbyJoinMenuItem:init(config, world)
	LobbyJoinMenuItem.super.init(self, config, world)

	self._refresh = true
end

function LobbyJoinMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = 800
	self._height = 30
end

function LobbyJoinMenuItem:update_position(dt, t, layout_settings, x, y)
	self._x = x
	self._y = y
end

function LobbyJoinMenuItem:render(dt, t, gui, layout_settings)
	local text_offset_y = -34
	local text_y = self._y
	local x = self._x
	local lobby_manager = Managers.lobby
	local font = MenuSettings.fonts.menu_font.font
	local font_material = MenuSettings.fonts.menu_font.material

	if self._refresh then
		lobby_manager:refresh_lobby_browser()

		if GameSettingsDevelopment.network_mode == "steam" then
			lobby_manager:refresh_server_browser()
		end

		self._refresh = false
	end

	if lobby_manager.state == LobbyState.JOINED then
		local lobby_name = Managers.lobby:get_lobby_data("lobby_name")
		local player_name = Managers.lobby:player_name()
		local lobby_members = Managers.lobby:lobby_members()
		local level_key = Managers.lobby:get_lobby_data("level_key")
		local game_mode_key = Managers.lobby:get_lobby_data("game_mode_key")

		ScriptGUI.text(gui, "PLAYER", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, player_name, font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y * 2

		ScriptGUI.text(gui, "GAME SETTINGS", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "Game Name: " .. (lobby_name or "?"), font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "Map: " .. (level_key and L(LevelSettings[level_key].display_name) or "?"), font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "Game Mode: " .. (game_mode_key and GameModeSettings[game_mode_key] and L(GameModeSettings[game_mode_key].display_name) or "?"), font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y * 2

		ScriptGUI.text(gui, "LOBBY MEMBERS (" .. tostring(#lobby_members) .. "/" .. tostring(Managers.lobby.LOBBY_MAX_MEMBERS) .. ")", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		for i = 1, #lobby_members do
			local lobby_member = lobby_members[i]
			local lobby_role = Managers.lobby:is_lobby_owner(lobby_member) and " [HOST]" or " [CLIENT]"
			local lobby_member_name = GameSettingsDevelopment.network_mode == "steam" and Steam.user_name(lobby_member) or lobby_member

			ScriptGUI.text(gui, tostring(i) .. ". " .. lobby_member_name .. lobby_role, font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

			text_y = text_y + text_offset_y
		end

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "---------------------------------------------------------", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "[q] Exit Lobby", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		if Keyboard.pressed(Keyboard.button_index("q")) then
			Managers.lobby:reset()

			self._refresh = true
		end
	elseif lobby_manager.state == LobbyState.JOINING then
		ScriptGUI.text(gui, "Joining...", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))
	elseif lobby_manager.state == LobbyState.FAILED then
		ScriptGUI.text(gui, "Join FAILED", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "---------------------------------------------------------", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "[q] Return to browser", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		if Keyboard.pressed(Keyboard.button_index("q")) then
			Managers.lobby:reset()

			self._refresh = true
		end
	else
		local lobby_manager = Managers.lobby
		local lobbies = lobby_manager:lobby_browser_content({
			"level_key",
			"game_mode_key",
			"game_started"
		})

		if #lobbies == 0 then
			ScriptGUI.text(gui, "No lobbies found", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

			text_y = text_y + text_offset_y
		else
			for i, lobby in ipairs(lobbies) do
				local text = i .. ". \"" .. (lobby.lobby_name or "?") .. "\"" .. " [Map: " .. (lobby.level_key and LevelSettings[lobby.level_key] and L(LevelSettings[lobby.level_key].display_name) or "?") .. "]" .. " [Game Mode: " .. (lobby.game_mode_key and GameModeSettings[lobby.game_mode_key] and L(GameModeSettings[lobby.game_mode_key].display_name) or "?") .. "]" .. " [Host Status: " .. (to_boolean(lobby.game_started) and "Game in progress" or "In lobby") .. "]" .. " [IP: " .. (lobby.address or "?") .. "]"

				ScriptGUI.text(gui, text, font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), lobby.valid and Color(255, 255, 255) or Color(100, 100, 100))

				text_y = text_y + text_offset_y

				if lobby.valid and Keyboard.pressed(Keyboard.button_index(i)) then
					Managers.lobby:join_lobby(lobby.lobby_num)
				end
			end
		end

		if GameSettingsDevelopment.network_mode == "steam" then
			local servers = lobby_manager:server_browser_content({
				"level_key",
				"game_mode_key",
				"game_started"
			})

			if #servers == 0 then
				ScriptGUI.text(gui, "No servers found", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

				text_y = text_y + text_offset_y
			else
				for i, lobby in ipairs(servers) do
					local text = i + #lobbies .. ". \"" .. (lobby.lobby_name or "?") .. "\"" .. " [Map: " .. (lobby.level_key and LevelSettings[lobby.level_key] and L(LevelSettings[lobby.level_key].display_name) or "?") .. "]" .. " [Game Mode: " .. (lobby.game_mode_key and GameModeSettings[lobby.game_mode_key] and L(GameModeSettings[lobby.game_mode_key].display_name) or "?") .. "]" .. " [Host Status: " .. (to_boolean(lobby.game_started) and "Game in progress" or "In lobby") .. "]" .. " [IP: " .. (lobby.address or "?") .. "]"

					ScriptGUI.text(gui, text, font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), lobby.valid and Color(255, 255, 255) or Color(100, 100, 100))

					text_y = text_y + text_offset_y

					if lobby.valid and Keyboard.pressed(Keyboard.button_index(i + #lobbies)) then
						Managers.lobby:join_server(lobby.lobby_num)
					end
				end
			end
		end

		if GameSettingsDevelopment.network_mode == "steam" then
			local refreshing_lobbies = lobby_manager:is_refreshing_lobby_browser()
			local refreshing_servers = lobby_manager:is_refreshing_server_browser()

			if refreshing_lobbies then
				ScriptGUI.text(gui, "Refreshing lobbies...", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

				text_y = text_y + text_offset_y
			end

			if refreshing_servers then
				ScriptGUI.text(gui, "Refreshing servers...", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

				text_y = text_y + text_offset_y
			end
		end

		ScriptGUI.text(gui, "---------------------------------------------------------------------", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		local mode_text

		if lobby_manager.server_browse_mode then
			if Keyboard.pressed(Keyboard.button_index("m")) then
				if lobby_manager.server_browse_mode == "lan" then
					lobby_manager:set_server_browse_mode("internet")
				else
					lobby_manager:set_server_browse_mode("lan")
				end
			end

			mode_text = "   [m] Server Browse Mode: " .. lobby_manager.server_browse_mode
		else
			mode_text = ""
		end

		ScriptGUI.text(gui, "[1-9] Join Lobby   [r] Refresh" .. mode_text, font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		if Keyboard.pressed(Keyboard.button_index("r")) then
			self._refresh = true
		end
	end
end

function LobbyJoinMenuItem:on_select()
	self:_try_callback(self.config.callback_object, self.config.on_select, unpack(self.config.on_select_args))
end

function LobbyJoinMenuItem:on_deselect()
	LobbyJoinMenuItem.super.on_deselect(self)
	Managers.lobby:reset()

	self._refresh = true
end

function LobbyJoinMenuItem:on_page_exit()
	LobbyJoinMenuItem.super.on_page_exit(self)
	Managers.lobby:reset()

	self._refresh = true
end

function LobbyJoinMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "lobby_join",
		page = config.page,
		disabled = config.disabled,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		layout_settings = config.layout_settings
	}

	return LobbyJoinMenuItem:new(config, compiler_data.world)
end
