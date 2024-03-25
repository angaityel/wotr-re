-- chunkname: @scripts/game_state/state_loading.lua

require("scripts/managers/network/loading_network_manager")
require("scripts/menu/menus/loading_screen_menu")
require("scripts/menu/menu_controller_settings/loading_screen_menu_controller_settings")
require("scripts/menu/menu_definitions/loading_screen_menu_definition")
require("scripts/menu/menu_callbacks/loading_screen_menu_callbacks")

StateLoading = class(StateLoading)

function StateLoading:on_enter(param_block)
	Managers.time:register_timer("loading", "main")
	self:setup_state_context()

	self._menu_world = Managers.world:create_world("menu_world", GameSettingsDevelopment.default_environment, nil, nil, Application.DISABLE_PHYSICS)
	self._viewport = ScriptWorld.create_viewport(self._menu_world, "menu_viewport", "default")
	self._gui = World.create_screen_gui(self._menu_world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	if not self.loading_context.disable_loading_screen_menu and not GameSettingsDevelopment.disable_loading_screen_menu then
		self:_setup_menu()
	end

	self._time_in_loading_screen = 0

	self:_setup_package_loading()

	self._game_start_countdown = self.loading_context.game_start_countdown
	self._game_start_countdown_tick = nil

	Managers.transition:fade_out(MenuSettings.transitions.fade_out_speed)
end

function StateLoading:game_start_countdown()
	return self._game_start_countdown
end

function StateLoading:update(dt)
	local t = Managers.time:time("loading")

	Managers.input:update(dt)
	Managers.state.event:trigger("event_update_active_input")

	if self._game_start_countdown then
		self._game_start_countdown = math.max(0, self._game_start_countdown - dt)
	end

	Managers.music:update(dt)
	Managers.state.network:update(dt)
	self:_update_loading_screen(dt, t)

	return self:_update_loading_state(dt, t)
end

function StateLoading:_update_loading_state(dt, t)
	local drop_in_settings = Managers.state.network:drop_in_settings()

	if drop_in_settings then
		local old_level_key = self.parent.loading_context.level_key

		self.parent.loading_context.level_key = drop_in_settings.level_key
		self.parent.loading_context.game_mode_key = drop_in_settings.game_mode_key
		self.parent.loading_context.time_limit = drop_in_settings.time_limit
		self.parent.loading_context.win_score = drop_in_settings.win_score
		self.parent.loading_context.level_cycle = drop_in_settings.level_cycle
		self.parent.loading_context.level_cycle_count = drop_in_settings.level_cycle_count
		self.parent.loading_context.game_start_countdown = drop_in_settings.game_start_countdown
		self.parent.loading_context.disable_loading_screen_menu = drop_in_settings.disable_loading_screen_menu
		self.enter_game = false
		self.parent.permission_to_enter_game = false
		self._game_start_countdown = drop_in_settings.game_start_countdown
		self._time_in_loading_screen = 0

		if self._level_package_loaded then
			self._level_package_loaded = false

			local level_package = LevelSettings[old_level_key].package_name

			Managers.package:unload(level_package)
			self:_setup_package_loading()
		else
			self.reload_package = true
		end

		if self._fading_in then
			self._fading_in = false

			Managers.transition:fade_out(MenuSettings.transitions.fade_out_speed, nil)
		end
	elseif self.enter_game and not self._fading_in then
		print("Level loaded, starting game")

		self._fading_in = true

		Window.set_show_cursor(false)
		Managers.state.event:trigger("disable_menu_input")
		Managers.transition:fade_in(MenuSettings.transitions.fade_in_speed, callback(self, "cb_transition_fade_in_done", StateIngame))
	end

	return self._new_state
end

function StateLoading:_update_loading_screen(dt, t)
	Profiler.start("StateLoading:_update_loading_screen - 1")
	self:_update_game_start_countdown_tick()
	self:_update_time_in_loading_screen(dt)
	self:_check_enter_game()
	Profiler.stop("StateLoading:_update_loading_screen - 1")

	if self._menu then
		Profiler.start("StateLoading:_update_loading_screen - 2")
		self._menu:update(dt, t)
		Profiler.stop("StateLoading:_update_loading_screen - 2")
	end

	if GameSettingsDevelopment.show_version_info then
		HUDHelper:render_version_info(self._gui)
	end

	if GameSettingsDevelopment.show_fps then
		HUDHelper:render_fps(self._gui, dt)
	end
end

function StateLoading:_update_game_start_countdown_tick()
	local countdown = self._game_start_countdown

	if countdown then
		local countdown_tick = math.ceil(countdown)

		if countdown_tick ~= self._game_start_countdown_tick then
			self._game_start_countdown_tick = countdown_tick

			Managers.state.event:trigger("game_start_countdown_tick", countdown_tick)
		end
	end
end

function StateLoading:_update_time_in_loading_screen(dt)
	if self._menu and self._menu:current_page_type() == "loading_screen" then
		self._time_in_loading_screen = self._time_in_loading_screen + dt
	end
end

function StateLoading:_check_enter_game()
	if not self._level_package_loaded or self.enter_game then
		return
	end

	if not Managers.lobby:is_dedicated_server() and self._menu and self._time_in_loading_screen < GameSettingsDevelopment.loading_screen_minimum_show_time then
		return
	end

	Managers.state.event:trigger("event_load_finished")

	if Managers.lobby.server and not self.parent.enter_game then
		for _, member in ipairs(Managers.lobby:lobby_members()) do
			if member ~= Network.peer_id() then
				RPC.rpc_permission_to_enter_game(member)
			end
		end

		self.enter_game = true
	elseif not Managers.lobby.lobby then
		self.enter_game = true
	elseif self.parent.permission_to_enter_game then
		self.enter_game = true
		self.parent.permission_to_enter_game = false
	end
end

function StateLoading:_async_package_loaded_callback(package_name)
	if self.reload_package then
		Managers.package:unload(package_name)
		self:_setup_package_loading()

		self.reload_package = false
	else
		self._level_package_loaded = true
	end
end

function StateLoading:_setup_package_loading()
	local level_key = self.parent.loading_context.level_key
	local level_package = LevelSettings[level_key].package_name

	Managers.package:load(level_package, callback(self, "_async_package_loaded_callback", level_package))
	Managers.state.event:trigger("event_load_started", "menu_loading_level", "menu_level_loaded")
end

function StateLoading:_setup_menu()
	self:_setup_input()

	local loading_context = self.loading_context
	local menu_data = {
		viewport_name = "menu_viewport",
		players = loading_context.players,
		local_player_index = loading_context.local_player_index,
		local_player_won = loading_context.local_player_won,
		stats_collection = loading_context.stats_collection,
		gained_xp_and_coins = loading_context.gained_xp_and_coins,
		penalty_xp = loading_context.penalty_xp,
		awarded_prizes = loading_context.awarded_prizes,
		awarded_medals = loading_context.awarded_medals,
		awarded_ranks = loading_context.awarded_ranks
	}

	loading_context.stats_collection = nil
	self._menu = LoadingScreenMenu:new(self, self._menu_world, LoadingScreenMenuControllerSettings, LoadingScreenMenuSettings, LoadingScreenMenuDefinition, LoadingScreenMenuCallbacks, menu_data)

	self._menu:set_active(true)

	if menu_data.stats_collection and not GameSettingsDevelopment.enable_robot_player then
		self._menu:goto("battle_report_scoreboard")
	else
		self._menu:goto("loading_screen")
	end
end

function StateLoading:_destroy_menu()
	self._menu:destroy()

	self._menu = nil

	self:_release_input()
	Window.set_show_cursor(false)
end

function StateLoading:_setup_input(param_block)
	local im = Managers.input

	im:map_controller(Keyboard, 1)
	im:map_controller(Mouse, 1)
	im:map_controller(Pad1, 1)
end

function StateLoading:_release_input()
	local im = Managers.input

	im:unmap_controller(Keyboard)
	im:unmap_controller(Mouse)
	im:unmap_controller(Pad1)
end

function StateLoading:_on_exit_loading_screen()
	if self._menu then
		self:_destroy_menu()
	end

	Managers.music:trigger_event("Stop_menu_music")
	Managers.music:trigger_event("Stop_battlereport_music")
	World.destroy_gui(self._menu_world, self._gui)
	Managers.world:destroy_world(self._menu_world)

	local loading_context = self.loading_context

	loading_context.players = nil
	loading_context.local_player_index = nil
	loading_context.stats_collection = nil
end

function StateLoading:cb_transition_fade_in_done(new_state)
	self._new_state = new_state
end

function StateLoading:on_exit()
	Managers.time:unregister_timer("loading")
	self:_on_exit_loading_screen()

	self.parent.loading_context.game_start_countdown = self._game_start_countdown

	Managers.state:destroy()
end

function StateLoading:setup_state_context()
	local sc = self.parent

	self.loading_context = sc.loading_context

	assert(sc.loading_context)
	assert(sc.loading_context.level_key)
	assert(sc.loading_context.game_mode_key)
	print("Load level :", tostring(sc.loading_context.level_key))

	Managers.state.event = EventManager:new()
	Managers.state.network = LoadingNetworkManager:new(self, Managers.lobby.lobby)
end
