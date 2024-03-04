-- chunkname: @scripts/game_state/state_splash_screen.lua

StateSplashScreen = class(StateSplashScreen)
StateSplashScreen.packages_to_load = {
	"resource_packages/menu",
	"resource_packages/ingame",
	"resource_packages/weapons"
}

function StateSplashScreen:on_enter()
	Managers.time:register_timer("splash_screen", "main")
	Managers.transition:force_fade_in()

	self._camera_dummy_units = {}
	self._alignment_dummy_units = {}
	self._num_loaded_packages = 0

	self:_setup_state_context()
	self:_setup_splash_screen_menu()

	if self.parent.loading_context.reload_packages then
		self:_unload_packages()
	end

	if self.parent.loading_context.leave_reason then
		self._splash_screen_menu:goto("disconnect_reason_popup")
	end

	self:_load_packages()
	self:_load_save_data()
	self:_load_menu_level()
	Managers.state.event:register(self, "coin_dlc_purchased", "event_coin_dlc_purchased")
	Managers.persistence:connect(callback(self, "cb_backend_setup"))
	Managers.state.event:trigger("load_started")

	local event_manager = Managers.state.event

	event_manager:register(self, "menu_camera_dummy_spawned", "event_menu_camera_dummy_spawned")
	event_manager:register(self, "menu_alignment_dummy_spawned", "event_menu_alignment_dummy_spawned")
end

function StateSplashScreen:event_menu_camera_dummy_spawned(name, unit)
	self._camera_dummy_units[name] = unit
end

function StateSplashScreen:event_menu_alignment_dummy_spawned(name, unit)
	self._alignment_dummy_units[name] = unit
end

function StateSplashScreen:_setup_state_context()
	Managers.state.event = EventManager:new()
end

function StateSplashScreen:_setup_splash_screen_menu()
	require("scripts/menu/menus/splash_screen")
	self:_setup_input()
	self:_setup_menu()

	if self.parent.loading_context.show_splash_screens then
		self._splash_screen_menu:goto("splash_screen_start")
	else
		self._wanted_state = self:_get_wanted_state()
	end
end

function StateSplashScreen:_setup_input()
	local im = Managers.input

	im:map_controller(Keyboard, 1)
	im:map_controller(Mouse, 1)
	im:map_controller(Pad1, 1)
end

function StateSplashScreen:_release_input()
	local im = Managers.input

	im:unmap_controller(Keyboard)
	im:unmap_controller(Mouse)
	im:unmap_controller(Pad1)
end

function StateSplashScreen:_setup_menu()
	self._splash_screen_world = Managers.world:create_world("splash_screen_world", GameSettingsDevelopment.default_environment, nil, 991, Application.DISABLE_PHYSICS)

	ScriptWorld.create_viewport(self._splash_screen_world, "splash_screen_viewport", "overlay", 1)

	local menu_data = {
		viewport_name = "splash_screen_viewport"
	}

	self._splash_screen_menu = SplashScreen:new(self, self._splash_screen_world, SplashScreenControllerSettings, SplashScreenSettings, SplashScreenDefinition, SplashScreenCallbacks, menu_data)

	self._splash_screen_menu:set_active(true)
end

function StateSplashScreen:_destroy_menu()
	if self._splash_screen_menu then
		self._splash_screen_menu:destroy()

		self._splash_screen_menu = nil
	end

	if self._splash_screen_world then
		Managers.world:destroy_world(self._splash_screen_world)

		self._splash_screen_world = nil
	end
end

function StateSplashScreen:update(dt, t)
	Managers.input:update(dt)

	local t = Managers.time:time("splash_screen")

	Managers.state.event:trigger("event_update_active_input")

	if self._splash_screen_menu then
		self._splash_screen_menu:update(dt, t)
	end

	if self:_load_finished() and not self._load_finished_event then
		Managers.state.event:trigger("load_finished")

		self._load_finished_event = true
	end

	local state = self:_next_state()

	return state
end

function StateSplashScreen:render()
	if self._splash_screen_menu:current_page().application_render then
		self._splash_screen_menu:current_page():application_render()
	end
end

function StateSplashScreen:_next_state()
	if not self:_load_finished() or not self._wanted_state then
		return
	end

	if not self._dependencies_checked then
		if self:_check_dependencies() then
			return self._wanted_state
		end

		self._wanted_state = nil
		self._dependencies_checked = true
	end

	if self._dependencies_checked then
		return self._wanted_state
	end
end

function StateSplashScreen:_check_dependencies()
	local is_fatal = self._is_fatal
	local dependency_error = self._dependency_error

	if GameSettingsDevelopment.network_mode == "steam" and not script_data.settings.dedicated_server and not self._dependency_error then
		if not rawget(_G, "Steam") then
			dependency_error = "error_steam_not_initialized"
			is_fatal = true
		elseif not Steam.connected() then
			dependency_error = "error_no_connection_to_steam_servers"
			is_fatal = true
		elseif not Managers.backend:connected() then
			dependency_error = "error_no_connection_to_backend"
			is_fatal = true
		elseif GameSettingsDevelopment.show_nda_in_splash_screen and not SaveData.nda_confirm then
			dependency_error = "error_need_nda_confirm"
			is_fatal = false
			SaveData.nda_confirm = true
		end
	end

	if dependency_error then
		self._dependency_error = dependency_error

		if is_fatal then
			if dependency_error == "error_no_connection_to_backend" then
				self._splash_screen_menu:goto("fatal_error_with_http_link_popup")
			else
				self._splash_screen_menu:goto("fatal_error_popup")
			end
		elseif dependency_error == "error_need_nda_confirm" then
			self._splash_screen_menu:goto("nda_confirm_popup")
		else
			self._splash_screen_menu:goto("error_popup")
		end

		return false
	end

	if self:_show_changelog() then
		return false
	end

	return true
end

function StateSplashScreen:_load_finished()
	return self._packages_loaded and self._save_data_loaded and self._profile_data_loaded and self._menu_level_loaded and self._market_loaded and self._store_loaded and self._changelog_loaded and not self.parent.loading_context.leave_reason
end

function StateSplashScreen:_unload_packages()
	for i, name in ipairs(StateSplashScreen.packages_to_load) do
		if PackageManager:has_loaded(name) then
			PackageManager:unload(name)
		end
	end
end

function StateSplashScreen:_load_packages()
	for i, name in ipairs(StateSplashScreen.packages_to_load) do
		if PackageManager:has_loaded(name) then
			self:cb_package_loaded()
		else
			PackageManager:load(name, callback(self, "cb_package_loaded"))
		end
	end
end

function StateSplashScreen:cb_package_loaded(package_num)
	self._num_loaded_packages = self._num_loaded_packages + 1

	if self._num_loaded_packages == #StateSplashScreen.packages_to_load then
		self._packages_loaded = true
	end
end

function StateSplashScreen:_load_save_data()
	Managers.save:auto_load(SaveFileName, callback(self, "cb_save_data_loaded"))
end

function StateSplashScreen:cb_save_data_loaded(info)
	if info.error then
		Application.warning("Load error %q", info.error)
	else
		populate_save_data(info.data)
	end

	self._save_data_loaded = true
end

function StateSplashScreen:cb_backend_setup(error_code)
	if error_code == nil then
		Managers.persistence:load_profile(callback(self, "cb_profile_loaded"))
		Managers.persistence:load_market(callback(self, "cb_market_loaded"))
		Managers.persistence:load_store(callback(self, "cb_store_loaded"))
	else
		self._is_fatal = true
		self._dependency_error = "error_no_connection_to_backend"
		self._profile_data_loaded = true
		self._market_loaded = true
		self._store_loaded = true
	end

	self:_load_changelog()
end

function StateSplashScreen:cb_profile_loaded(profile_data)
	if profile_data == nil then
		self._is_fatal = true
		self._dependency_error = "error_profile"
	end

	self._profile_data_loaded = true
end

function StateSplashScreen:cb_market_loaded(market)
	if market == nil then
		self._is_fatal = true
		self._dependency_error = "error_market"
	end

	self._market_loaded = true
end

function StateSplashScreen:cb_store_loaded(store)
	if store == nil then
		self._is_fatal = false
		self._dependency_error = "store_error"
	end

	self._store_loaded = true
end

function StateSplashScreen:_load_menu_level()
	if self:_get_wanted_state() == StateInviteJoin then
		self._menu_level_loaded = true

		return
	end

	local level_settings = MainMenuSettings.level

	self._level_name = LevelSettings[level_settings.level_name].level_name
	self._level_package_name = LevelSettings[level_settings.level_name].package_name
	self._level_world = Managers.world:create_world("menu_level_world", nil, MenuHelper.light_adaption_fix_shading_callback, 1, Application.DISABLE_PHYSICS)

	print("LEVEL NAME: ", self._level_name)
	print("PACKAGE NAME: ", self._level_package_name)
	PackageManager:load(self._level_package_name, callback(self, "cb_menu_level_package_loaded"))
end

function StateSplashScreen:cb_menu_level_package_loaded()
	self._level = ScriptWorld.load_level(self._level_world, self._level_name)

	Level.spawn_background(self._level)
	Level.trigger_level_loaded(self._level)

	local nested_levels = Level.nested_levels(self._level)

	for _, level in ipairs(nested_levels) do
		Level.trigger_level_loaded(level)
	end

	self._level_viewport = ScriptWorld.create_viewport(self._level_world, "menu_level_viewport", "default", 1)
	self._menu_level_loaded = true
end

function StateSplashScreen:_load_changelog()
	if self.parent.loading_context.load_changelog then
		Managers.changelog:get_changelog(callback(self, "cb_changelog_loaded"))
	else
		self._changelog_loaded = true
	end
end

function StateSplashScreen:cb_changelog_loaded(info)
	self._changelog_loaded = true

	local text = info.body

	if text == "" then
		text = nil
	end

	self._changelog_text = text or info.error or "Error"
end

function StateSplashScreen:cb_error_popup_enter(args)
	Window.set_show_cursor(true)

	local reason = self.parent.loading_context.leave_reason or L(self._dependency_error)

	args.popup_page:find_item_by_name("popup_text"):set_text(reason)
end

function StateSplashScreen:cb_error_popup_item_selected(args)
	if args.action == "quit_game" then
		self.parent.quit_game = true
	elseif args.action == "continue" then
		if self.parent.loading_context.leave_reason then
			self.parent.loading_context.leave_reason = nil
		end

		if not self:_show_changelog() then
			self._wanted_state = self:_get_wanted_state()
		end
	end
end

function StateSplashScreen:_show_changelog()
	if self._changelog_text then
		local omit_revision = Application.user_setting("omit_revision_changelog")
		local current_revision = script_data.settings.content_revision

		if current_revision and (not omit_revision or omit_revision < current_revision) then
			self._splash_screen_menu:goto("changelog_popup")

			return true
		end
	end

	return false
end

function StateSplashScreen:cb_changelog_popup_enter(args)
	Window.set_show_cursor(true)

	local header = string.format(L("latest_updates_in_revision"), script_data.settings.content_revision)

	args.popup_page:find_item_by_name("popup_header"):set_text(header)
	args.popup_page:find_item_by_name("popup_text"):set_text(self._changelog_text)
end

function StateSplashScreen:cb_changelog_popup_item_selected(args)
	local checkbox = args.popup_page:find_item_by_name("omit_changelog_checkbox")
	local current_revision = script_data.settings.content_revision

	if checkbox:selected() then
		Application.set_user_setting("omit_revision_changelog", current_revision)
		Application.save_user_settings()
	end

	self._wanted_state = self:_get_wanted_state()
end

function StateSplashScreen:cb_goto(id)
	self._splash_screen_menu:cb_goto(id)
end

function StateSplashScreen:cb_goto_next_splash_screen()
	self._splash_screen_menu:current_page():goto_first_items_page()
end

function StateSplashScreen:cb_goto_main_menu()
	self._wanted_state = self:_get_wanted_state()
end

function StateSplashScreen:_get_wanted_state()
	return self.parent.loading_context.invite_type and StateInviteJoin or StateMenu
end

function StateSplashScreen:on_exit()
	local loading_context = {}

	loading_context.level_package_name = self._level_package_name
	loading_context.level_world = self._level_world
	loading_context.level = self._level
	loading_context.level_viewport = self._level_viewport
	loading_context.camera_dummy_units = self._camera_dummy_units
	loading_context.alignment_dummy_units = self._alignment_dummy_units
	loading_context.invite_type = self.parent.loading_context.invite_type
	loading_context.invite_lobby_id = self.parent.loading_context.invite_lobby_id
	loading_context.invite_ip = self.parent.loading_context.invite_ip
	self.parent.loading_context = loading_context

	self:_release_input()
	self:_destroy_menu()
	Managers.time:unregister_timer("splash_screen")
end

function StateSplashScreen:event_coin_dlc_purchased(coins)
	Managers.sale_popup:create_coin_dlc_item(coins)
end
