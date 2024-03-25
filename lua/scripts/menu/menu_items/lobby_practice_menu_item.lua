-- chunkname: @scripts/menu/menu_items/lobby_practice_menu_item.lua

LobbyPracticeMenuItem = class(LobbyPracticeMenuItem, MenuItem)

function LobbyPracticeMenuItem:init(config, world)
	LobbyPracticeMenuItem.super.init(self, config, world)

	self._levels, self._num_levels = self:_level_list()
	self._selected_level_index = 17
	self._game_modes = self:_game_mode_list()
	self._selected_game_mode_index = 1

	if Managers.lobby.lobby then
		self._refresh_lobby_data = true
	else
		self._create_lobby = true
	end
end

function LobbyPracticeMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = 600
	self._height = 30
end

function LobbyPracticeMenuItem:update_position(dt, t, layout_settings, x, y)
	self._x = x
	self._y = y
end

function LobbyPracticeMenuItem:render(dt, t, gui, layout_settings)
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
		Managers.lobby:set_lobby_data("time_limit", 60)

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

		Managers.lobby:set_server(true)

		local level = self:selected_level()
		local game_mode = self:selected_game_mode()

		Managers.state.network:start_server_game(level, game_mode, GameSettingsDevelopment.default_win_score, GameSettingsDevelopment.default_time_limit)
		Managers.lobby:set_lobby_data("game_started", "true")
	end
end

function LobbyPracticeMenuItem:cb_lobby_created()
	self._refresh_lobby_data = true
end

function LobbyPracticeMenuItem:_level_list()
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

function LobbyPracticeMenuItem:select_next_level()
	local selected_level_index = self._selected_level_index

	selected_level_index = selected_level_index >= self._num_levels and 1 or selected_level_index + 1
	self._selected_level_index = selected_level_index
	self._game_modes = self:_game_mode_list()
	self._selected_game_mode_index = 1
end

function LobbyPracticeMenuItem:selected_level()
	return self._levels[self._selected_level_index].level_key
end

function LobbyPracticeMenuItem:_game_mode_list()
	return LevelSettings[self:selected_level()].game_modes or {}
end

function LobbyPracticeMenuItem:select_next_game_mode()
	local selected_game_mode_index = self._selected_game_mode_index

	selected_game_mode_index = selected_game_mode_index >= #self._game_modes and 1 or selected_game_mode_index + 1
	self._selected_game_mode_index = selected_game_mode_index
end

function LobbyPracticeMenuItem:selected_game_mode()
	return self._game_modes[self._selected_game_mode_index] and self._game_modes[self._selected_game_mode_index].key
end

function LobbyPracticeMenuItem:on_select()
	self:_try_callback(self.config.callback_object, self.config.on_select, unpack(self.config.on_select_args))
end

function LobbyPracticeMenuItem:on_deselect()
	LobbyHostMenuItem.super.on_deselect(self)
	Managers.lobby:reset()

	self._create_lobby = true
end

function LobbyPracticeMenuItem:on_page_exit()
	LobbyHostMenuItem.super.on_page_exit(self)
	Managers.lobby:reset()

	self._create_lobby = true
end

function LobbyPracticeMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "lobby_practice",
		page = config.page,
		disabled = config.disabled,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		layout_settings = config.layout_settings
	}

	return LobbyPracticeMenuItem:new(config, compiler_data.world)
end
