-- chunkname: @scripts/game_state/state_menu_main.lua

require("scripts/menu/menus/main_menu")
require("scripts/menu/menu_controller_settings/main_menu_controller_settings")
require("scripts/menu/menu_definitions/main_menu_settings_1920")
require("scripts/menu/menu_definitions/main_menu_settings_1366")
require("scripts/menu/menu_definitions/main_menu_settings_low")
require("scripts/menu/menu_definitions/main_menu_definition")
require("scripts/menu/menu_callbacks/main_menu_callbacks")

StateMenuMain = class(StateMenuMain)

function StateMenuMain:on_enter(params)
	self._menu_world = Managers.world:create_world("menu_world", GameSettingsDevelopment.default_environment, nil, 3, Application.DISABLE_PHYSICS)

	ScriptWorld.create_viewport(self._menu_world, "menu_viewport", "overlay", 3)

	self._gui = World.create_screen_gui(self._menu_world, "material", "materials/hud/mockup_hud", "material", "materials/fonts/arial", "immediate")

	local menu_data = {
		viewport_name = "menu_viewport",
		level_world = self.parent.level_world,
		camera_dummy_units = self.parent.camera_dummy_units
	}

	Profiler.start("MAIN MENU")

	self._menu = MainMenu:new(self, self._menu_world, MainMenuControllerSettings, MainMenuSettings, MainMenuDefinition, MainMenuCallbacks, menu_data)

	Profiler.stop()
	self._menu:set_active(true)
	Managers.sale_popup:load_sale_config()

	local event_manager = Managers.state.event

	event_manager:register(self, "restart_game", "event_restart_game")
end

function StateMenuMain:on_exit()
	self._menu:destroy()

	self._menu = nil

	World.destroy_gui(self._menu_world, self._gui)
	Managers.world:destroy_world(self._menu_world)
end

function StateMenuMain:update(dt, t)
	if self.parent.parent.goto_menu_node then
		self._menu:goto(self.parent.parent.goto_menu_node)

		self.parent.parent.goto_menu_node = nil
	end

	self._menu:update(dt, t)
	Managers.sale_popup:update()

	if Managers.sale_popup:new_data(true) then
		if Managers.sale_popup:important_data(true) then
			self._menu:current_page():open_sale_popup(Managers.sale_popup:get_loaded_data())
		else
			local date = os.date("*t")
			local current_time = os.time(date)
			local last_sale_popup_display_time = SaveData.last_sale_popup_display_time or 0

			if math.abs(os.difftime(current_time, last_sale_popup_display_time)) >= 86400 then
				SaveData.last_sale_popup_display_time = current_time

				Managers.save:auto_save(SaveFileName, SaveData)
				self._menu:current_page():open_sale_popup(Managers.sale_popup:get_loaded_data())
			end
		end
	end

	if GameSettingsDevelopment.show_version_info then
		HUDHelper:render_version_info(self._gui)
	end

	if GameSettingsDevelopment.show_fps then
		HUDHelper:render_fps(self._gui, dt)
	end
end

function StateMenuMain:event_restart_game()
	self:_stop_all_sounds()

	self.parent.parent.loading_context.reload_packages = true

	self.parent:set_new_state(StateSplashScreen)
end

function StateMenuMain:_stop_all_sounds()
	local menu_timpani_world = World.timpani_world(self._menu_world)

	menu_timpani_world:stop_all()

	local level_timpani_world = World.timpani_world(self.parent.level_world)

	level_timpani_world:stop_all()
	Managers.music:stop_all_sounds()
end

function StateMenuMain:exit_game()
	self.parent.parent.quit_game = not EDITOR_LAUNCH
end

function StateMenuMain:single_player_start(level_key)
	self.parent.single_player_loading_context = {}
	self.parent.single_player_loading_context.state = StateLoading
	self.parent.single_player_loading_context.level_key = level_key
	self.parent.single_player_loading_context.game_mode_key = LevelSettings[level_key].single_player_game_mode or "sp"
	self.parent.single_player_loading_context.win_score = GameSettingsDevelopment.default_win_score
	self.parent.single_player_loading_context.time_limit = GameSettingsDevelopment.default_time_limit
	self.parent.single_player_loading_context.disable_loading_screen_menu = true
end

function StateMenuMain:menu_cancel_to(page_id)
	self._menu:cancel_to(page_id)
end
