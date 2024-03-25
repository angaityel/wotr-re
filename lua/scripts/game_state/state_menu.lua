-- chunkname: @scripts/game_state/state_menu.lua

require("scripts/managers/network/menu_network_manager")
require("scripts/settings/level_settings")

StateMenu = class(StateMenu)

function StateMenu:on_enter()
	Managers.time:register_timer("menu", "main")

	self.level_package_name = self.parent.loading_context.level_package_name
	self.level_world = self.parent.loading_context.level_world
	self.level = self.parent.loading_context.level
	self.camera_dummy_units = self.parent.loading_context.camera_dummy_units
	self.alignment_dummy_units = self.parent.loading_context.alignment_dummy_units

	self:setup_state_context()
	self:_setup_input()

	self.machine = StateMachine:new(self, StateMenuMain)

	Managers.transition:fade_out(MenuSettings.transitions.fade_out_speed)
end

function StateMenu:_setup_input(param_block)
	local im = Managers.input

	im:map_controller(Keyboard, 1)
	im:map_controller(Mouse, 1)
	im:map_controller(Pad1, 1)
end

function StateMenu:_release_input()
	local im = Managers.input

	im:unmap_controller(Keyboard)
	im:unmap_controller(Mouse)
	im:unmap_controller(Pad1)
end

function StateMenu:update(dt)
	local t = Managers.time:time("menu")

	Managers.input:update(dt)
	Managers.state.event:trigger("event_update_active_input")
	Managers.music:update(dt)
	Managers.lobby:update(dt)
	Managers.state.network:update(dt)
	Managers.state.camera:update(dt, "menu_level_viewport")

	local drop_in_settings = Managers.state.network:drop_in_settings() or self.single_player_loading_context

	if drop_in_settings and not self._fading_in then
		self.loading_context = {}
		self.loading_context.state = StateLoading
		self.loading_context.level_key = drop_in_settings.level_key
		self.loading_context.game_mode_key = drop_in_settings.game_mode_key
		self.loading_context.time_limit = drop_in_settings.time_limit
		self.loading_context.win_score = drop_in_settings.win_score
		self.loading_context.level_cycle = drop_in_settings.level_cycle
		self.loading_context.level_cycle_count = drop_in_settings.level_cycle_count
		self.loading_context.game_start_countdown = drop_in_settings.game_start_countdown
		self.loading_context.disable_loading_screen_menu = drop_in_settings.disable_loading_screen_menu
		self.parent.loading_context = self.loading_context
		self._fading_in = true

		Window.set_show_cursor(false)
		Managers.state.event:trigger("disable_menu_input")
		Managers.transition:fade_in(MenuSettings.transitions.fade_in_speed, callback(self, "cb_transition_fade_in_done", self.loading_context.state))
	elseif drop_in_settings then
		self.loading_context.level_key = drop_in_settings.level_key
		self.loading_context.game_mode_key = drop_in_settings.game_mode_key
		self.loading_context.time_limit = drop_in_settings.time_limit
		self.loading_context.win_score = drop_in_settings.win_score
		self.loading_context.level_cycle = drop_in_settings.level_cycle
		self.loading_context.level_cycle_count = drop_in_settings.level_cycle_count
		self.loading_context.game_start_countdown = drop_in_settings.game_start_countdown
		self.loading_context.disable_loading_screen_menu = drop_in_settings.disable_loading_screen_menu
	end

	self.machine:update(dt, t)

	if self._new_state then
		return self._new_state
	end
end

function StateMenu:post_update(dt)
	Managers.state.camera:post_update(dt, "menu_level_viewport")
end

function StateMenu:cb_transition_fade_in_done(new_state)
	self._new_state = new_state
end

function StateMenu:set_new_state(new_state)
	self._new_state = new_state
end

function StateMenu:on_exit()
	self.machine:destroy()
	self:_release_input()
	Managers.time:unregister_timer("menu")
	Window.set_show_cursor(false)
	Managers.state.camera:destroy_viewport("menu_level_viewport")
	World.destroy_level(self.level_world, self.level)
	PackageManager:unload(self.level_package_name)
	Managers.world:destroy_world(self.level_world)
end

function StateMenu:setup_state_context()
	Managers.state.event = EventManager:new()
	Managers.state.network = MenuNetworkManager:new(self, Managers.lobby.lobby)
	Managers.state.camera = CameraManager:new(self.level_world)
end
