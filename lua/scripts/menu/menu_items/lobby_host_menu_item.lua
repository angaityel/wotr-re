-- chunkname: @scripts/menu/menu_items/lobby_host_menu_item.lua

LobbyHostMenuItem = class(LobbyHostMenuItem, MenuItem)

function LobbyHostMenuItem:init(config, world)
	LobbyHostMenuItem.super.init(self, config, world)

	self._levels, self._num_levels = self:_level_list()
	self._selected_level_index = 1
	self._game_modes = self:_game_mode_list()
	self._selected_game_mode_index = 1

	if Managers.lobby.lobby then
		self._refresh_lobby_data = true
	else
		self._create_lobby = true
	end
end

function LobbyHostMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = 600
	self._height = 30
end

function LobbyHostMenuItem:update_position(dt, t, layout_settings, x, y)
	self._x = x
	self._y = y
end

function LobbyHostMenuItem:render(dt, t, gui, layout_settings)
	local text_offset_y = -34
	local text_y = self._y
	local x = self._x
	local font_material = MenuSettings.fonts.menu_font.material
	local font = MenuSettings.fonts.menu_font.font

	if self._create_lobby then
		Managers.lobby:create_lobby(callback(self, "cb_lobby_created"))

		self._create_lobby = false
	end

	if self._refresh_lobby_data then
		Managers.lobby:set_lobby_data("lobby_name", Managers.lobby.lobby_name)
		Managers.lobby:set_lobby_data("level_key", self:selected_level())
		Managers.lobby:set_lobby_data("game_mode_key", self:selected_game_mode())
		Managers.lobby:set_lobby_data("game_started", "false")
		Managers.lobby:set_lobby_data("win_score", GameSettingsDevelopment.default_win_score)
		Managers.lobby:set_lobby_data("time_limit", GameSettingsDevelopment.default_time_limit)

		self._refresh_lobby_data = false
	end

	if Managers.lobby.state == LobbyState.OFFLINE or Managers.lobby.state == LobbyState.FAILED then
		ScriptGUI.text(gui, "[h] Start Hosting", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		if Keyboard.pressed(Keyboard.button_index("h")) then
			self._create_lobby = true
		end
	else
		local lobby_name = Managers.lobby.lobby_name
		local player_name = Managers.lobby:player_name()
		local lobby_members = Managers.lobby:lobby_members()
		local level_key = self:selected_level()
		local game_mode_key = self:selected_game_mode()

		ScriptGUI.text(gui, "PLAYER", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, player_name, font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y * 2

		ScriptGUI.text(gui, "GAME SETTINGS", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "Game Name: " .. lobby_name, font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "Map: " .. (level_key and L(LevelSettings[level_key].display_name) or "?"), font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

		text_y = text_y + text_offset_y

		ScriptGUI.text(gui, "Game Mode: " .. (game_mode_key and L(GameModeSettings[game_mode_key].display_name) or "?"), font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))

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

		if Managers.input:active_mapping(1) == "keyboard_mouse" then
			ScriptGUI.text(gui, "[s] Start Game   [m] Change Map   [g] Change Game Mode   [q] [Exit Lobby]", font, layout_settings.font_size, font_material, Vector3(x, text_y, 1), Color(255, 255, 255))
		end

		text_y = text_y + text_offset_y

		if Keyboard.pressed(Keyboard.button_index("m")) or Pad1.pressed(Pad1.button_index("x")) then
			self:select_next_level()
			Managers.lobby:set_lobby_data("level_key", self:selected_level())
			Managers.lobby:set_lobby_data("game_mode_key", self:selected_game_mode())
		elseif Keyboard.pressed(Keyboard.button_index("g")) or Pad1.pressed(Pad1.button_index("y")) then
			self:select_next_game_mode()
			Managers.lobby:set_lobby_data("game_mode_key", self:selected_game_mode())
		elseif Keyboard.pressed(Keyboard.button_index("s")) or Pad1.pressed(Pad1.button_index("a")) then
			Managers.lobby:set_server(true)

			local level = self:selected_level()
			local game_mode = self:selected_game_mode()

			Managers.state.network:start_server_game(level, game_mode, GameSettingsDevelopment.default_win_score, GameSettingsDevelopment.default_time_limit)
			Managers.lobby:set_lobby_data("game_started", "true")
		elseif Managers.input:active_mapping(1) == "keyboard_mouse" and Keyboard.pressed(Keyboard.button_index("q")) then
			Managers.lobby:reset()
		end
	end
end

function LobbyHostMenuItem:cb_lobby_created()
	self._refresh_lobby_data = true
end

function LobbyHostMenuItem:_level_list()
	local options = {}
	local num_options = 0

	for key, config in pairs(LevelSettings) do
		if config.visible then
			options[config.sort_index] = config
			options[config.sort_index].level_key = key
			num_options = num_options + 1
		end
	end

	return options, num_options
end

function LobbyHostMenuItem:select_next_level()
	local selected_level_index = self._selected_level_index

	selected_level_index = selected_level_index >= self._num_levels and 1 or selected_level_index + 1
	self._selected_level_index = selected_level_index
	self._game_modes = self:_game_mode_list()
	self._selected_game_mode_index = 1
end

function LobbyHostMenuItem:selected_level()
	return self._levels[self._selected_level_index].level_key
end

function LobbyHostMenuItem:_game_mode_list()
	return LevelSettings[self:selected_level()].game_modes or {}
end

function LobbyHostMenuItem:select_next_game_mode()
	local selected_game_mode_index = self._selected_game_mode_index

	selected_game_mode_index = selected_game_mode_index >= #self._game_modes and 1 or selected_game_mode_index + 1
	self._selected_game_mode_index = selected_game_mode_index
end

function LobbyHostMenuItem:selected_game_mode()
	return self._game_modes[self._selected_game_mode_index] and self._game_modes[self._selected_game_mode_index].key
end

function LobbyHostMenuItem:on_select()
	self:_try_callback(self.config.callback_object, self.config.on_select, unpack(self.config.on_select_args))
end

function LobbyHostMenuItem:on_deselect()
	LobbyHostMenuItem.super.on_deselect(self)
	Managers.lobby:reset()

	self._create_lobby = true
end

function LobbyHostMenuItem:on_page_exit()
	LobbyHostMenuItem.super.on_page_exit(self)
	Managers.lobby:reset()

	self._create_lobby = true
end

function LobbyHostMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "lobby_host",
		page = config.page,
		disabled = config.disabled,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		layout_settings = config.layout_settings
	}

	return LobbyHostMenuItem:new(config, compiler_data.world)
end
