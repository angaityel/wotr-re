-- chunkname: @scripts/game_state/state_ingame.lua

require("scripts/flow/flow_callbacks")
require("scripts/managers/camera/camera_manager")
require("scripts/managers/debug/debug_text_manager")
require("scripts/managers/network/game_network_manager")
require("scripts/managers/spawn/spawn_manager")
require("scripts/managers/team/team_manager")
require("scripts/managers/game_mode/game_mode_manager")
require("scripts/managers/hud/hud_manager")
require("scripts/managers/group/group_manager")
require("scripts/managers/debug/debug_manager")
require("scripts/managers/profiling/profiling_manager")
require("scripts/managers/stats/stats_collector_client")
require("scripts/managers/stats/stats_collector_server")
require("scripts/managers/stats/stats_collection")
require("scripts/managers/stats/stats_synchronizer")
require("scripts/managers/projectile/projectile_manager")
require("scripts/managers/ai_resource/ai_resource_manager")
require("scripts/managers/area_buff/area_buff_manager")
require("scripts/managers/tagging/tagging_manager")
require("scripts/managers/broken_gear/broken_gear_manager")
require("scripts/managers/voting/voting_manager")
require("scripts/managers/death_zone/death_zone_manager")
require("scripts/managers/input/input_filters")
require("foundation/scripts/util/bezier")
require("foundation/scripts/util/spline_curve")

StateIngame = class(StateIngame)

local argv = {
	Application.argv()
}

function StateIngame:on_enter()
	Managers.time:register_timer("game", "main")

	local loading_context = self.parent.loading_context
	local level_key = loading_context.level_key
	local game_mode_key = loading_context.game_mode_key

	self._level_key = level_key
	self._game_mode_key = game_mode_key
	self._win_score = loading_context.win_score
	self._time_limit = loading_context.time_limit
	self._game_start_countdown = loading_context.game_start_countdown

	local reload_level_context = loading_context.reload_level_data

	loading_context.reload_level_data = nil
	self._max_number_of_players = PlayerManager.MAX_PLAYERS
	self._start_round = false
	self._editor_spawn_point = nil
	self._spawn_points = {}
	self._server_spawn_points = {}
	self.world_name = "level_world"

	self:_setup_world()
	self:setup_state_context(reload_level_context)

	local event_manager = Managers.state.event

	event_manager:register(self, "event_start_round", "event_start_round")
	event_manager:register(self, "event_play_particle_effect", "event_play_particle_effect")
	event_manager:register(self, "local_player_created", "event_player_created")
	event_manager:register(self, "remote_player_created", "event_player_created")
	event_manager:register(self, "ai_player_created", "event_player_created")
	event_manager:register(self, "event_level_ended", "event_level_ended")
	event_manager:register(self, "next_level", "event_next_level")
	event_manager:register(self, "reload_level", "event_reload_level")
	event_manager:register(self, "change_level", "event_change_level")
	event_manager:register(self, "kicked_from_game", "event_kicked_from_game")
	event_manager:register(self, "apply_max_fps_cap", "event_apply_max_fps_cap")
	event_manager:register(self, "daily_win_bonus_awarded", "event_daily_win_bonus_awarded")
	event_manager:register(self, "round_win_bonus_awarded", "event_round_win_bonus_awarded")

	local level = self:_create_level()

	self:_setup_input()

	self.machines = {}
	self.number_active_players = Application.settings().dedicated_server and 0 or self.parent.loading_context.number_players or 1

	local input = Managers.input
	local player_manager = Managers.player

	for i = 1, self._max_number_of_players do
		if i <= self.number_active_players then
			local viewport_name = "player_" .. i
			local input_slot = i
			local input_source

			if GameSettingsDevelopment.enable_robot_player then
				input_source = input:map_robot_slot(input_slot, ActivePlayerControllerSettings, nil)
			else
				input_source = input:map_slot(input_slot, ActivePlayerControllerSettings, nil)
			end

			player_manager:add_player(PlayerCoatOfArms, i, input_slot, input_source, viewport_name, self.world_name)

			local params = {
				player = i,
				viewport_name = viewport_name
			}

			self.machines[i] = StateMachine:new(self, StateInGameRunning, params)

			Managers.state.camera:apply_level_particle_effects(LevelSettings[level_key].level_particle_effects, viewport_name)
			Managers.state.camera:apply_level_screen_effects(LevelSettings[level_key].level_screen_effects, viewport_name)
		end
	end

	Level.trigger_level_loaded(level)

	local nested_levels = Level.nested_levels(level)

	for _, level in ipairs(nested_levels) do
		Level.trigger_level_loaded(level)
	end

	if Application.platform() == "win32" then
		Window.set_mouse_focus(true)
	end

	self._spawning = false
	self._spawn_method = "pulse"
	self._active_spawn_points = {}
	self._last_spawn_point = 0
	self._num_active_spawn_points = 0
	self._frame = 0
	self._game_license_check_list = {}

	if Managers.lobby.lobby then
		Network.write_dump_tag("start of game")
		Managers.chat:register_channel(NetworkLookup.chat_channels.dead, callback(Managers.lobby, "lobby_members"))
	end

	Managers.transition:fade_out(MenuSettings.transitions.fade_out_speed)

	local max_fps = Application.user_setting("max_fps")

	if max_fps then
		self:event_apply_max_fps_cap(max_fps)
	end
end

function StateIngame:event_apply_max_fps_cap(max_fps)
	if max_fps == 0 then
		Application.set_time_step_policy("no_throttle")
	else
		Application.set_time_step_policy("throttle", max_fps)
	end
end

function StateIngame:_setup_world()
	local shading_callback = callback(self, "shading_callback")

	self.world = Managers.world:create_world(self.world_name, nil, shading_callback)
end

function StateIngame:shading_callback(world, shading_env)
	Managers.state.camera:shading_callback(world, shading_env)
end

function StateIngame:_teardown_world()
	Managers.world:destroy_world(self.world_name)
end

function StateIngame:spawn_unit(world, unit, ...)
	Managers.state.entity:register_unit(world, unit, ...)
end

function StateIngame:unspawn_unit(u)
	Managers.state.entity:unregister_unit(u)
end

function StateIngame:_setup_input()
	local input = Managers.input

	input:map_controller(Keyboard, 1)
	input:map_controller(Mouse, 1)
	input:map_controller(Pad1, 1)
	input:map_controller(Pad2, 3)
	input:map_controller(Pad3, 4)
end

function StateIngame:_release_input()
	local input = Managers.input

	input:unmap_controller(Keyboard)
	input:unmap_controller(Mouse)
	input:unmap_controller(Pad1)
	input:unmap_controller(Pad2)
	input:unmap_controller(Pad3)
end

function StateIngame:_create_level()
	local level_key = self._level_key
	local game_mode_key = self._game_mode_key
	local level_name = LevelSettings[level_key].level_name
	local game_mode_manager = Managers.state.game_mode
	local game_mode_object_sets = game_mode_manager:object_sets()
	local spawned_object_sets = {}
	local object_sets = {}
	local available_level_sets = LevelResource.object_set_names(level_name)

	for key, set in ipairs(available_level_sets) do
		local object_set_table = {
			type = "",
			key = key,
			units = LevelResource.unit_indices_in_object_set(level_name, set)
		}

		if game_mode_object_sets[set] or set == "shadow_lights" then
			spawned_object_sets[#spawned_object_sets + 1] = set
		elseif string.sub(set, 1, 5) == "team_" then
			spawned_object_sets[#spawned_object_sets + 1] = set
			object_set_table.type = "team"
		end

		object_sets[set] = object_set_table
	end

	local level = ScriptWorld.load_level(self.world, level_name, spawned_object_sets)

	game_mode_manager:register_object_sets(object_sets)
	World.set_flow_callback_object(self.world, self)
	Managers.state.entity:register_units(self.world, World.units(self.world))
	Level.spawn_background(level)

	if GameSettingsDevelopment.performance_profiling.active then
		Managers.state.profiling:level_loaded(level_name)
	end

	return level
end

function StateIngame:update(dt)
	local t = Managers.time:time("game")

	Managers.input:update(dt)
	Managers.state.event:trigger("event_update_active_input")

	if script_data.settings.dedicated_server then
		Managers.admin:update(dt, t)
		self:_check_game_licenses(dt, t)
	end

	if self._game_start_countdown then
		self._game_start_countdown = math.max(0, self._game_start_countdown - dt)
	end

	local network_manager = Managers.state.network

	if GameSettingsDevelopment.performance_profiling.active then
		Managers.state.profiling:update(dt)
	end

	self._ducking_handler:update(dt)
	Managers.music:update(dt)
	Managers.lobby:update(dt)

	if Managers.lobby.server then
		Managers.persistence:update(t, dt)
	end

	network_manager:update(dt)

	local network_game = network_manager:game()
	local is_spawn_owner = Managers.lobby.server and network_game or not Managers.lobby.lobby
	local squad_screen, auto_team = Managers.state.game_mode:squad_screen_spawning()

	if self._start_round and is_spawn_owner then
		local player_manager = Managers.player
		local team_manager = Managers.state.team

		for i = 1, self.number_active_players do
			local player = player_manager:player(i)

			if network_game then
				player:create_game_object()
			end

			if squad_screen then
				team_manager:add_player_to_team_by_name(player, "unassigned")
			else
				team_manager:add_player_to_team_by_side(player, auto_team)
			end
		end

		if network_game then
			team_manager:create_game_objects()
		end

		self._start_round = false

		local game_start_countdown = self:game_start_countdown() and -self:game_start_countdown() or 0

		Managers.time:register_timer("round", "main", game_start_countdown)
		Managers.state.game_mode:round_started()
	end

	if Managers.time:has_timer("round") then
		Managers.state.spawn:update(dt, t)
		Managers.state.voting:update(dt, t)
	end

	for _, machine in pairs(self.machines) do
		machine:update(dt, t)
	end

	Managers.state.entity_system:update(dt)

	if Managers.lobby.server or not Managers.lobby.lobby then
		Managers.state.game_mode:server_update(dt, t)
		Managers.state.area_buff:update(dt, t)
		Managers.state.tagging:update(dt, t)
		Managers.state.death_zone:update(dt, t)
	else
		Managers.state.game_mode:client_update(dt, t)

		if Managers.time:has_timer("round") and network_game then
			network_manager:update_round_time_report(dt, t)
		end
	end

	Managers.state.team:update(dt)

	if self.exit_to_menu and not self.is_exiting then
		self.is_exiting = true

		if network_game then
			network_manager:leave_game()
		else
			if Managers.lobby.lobby then
				self._leave_lobby = true
			end

			print("[StateIngame] Transition to StateSplashScreen on \"exit_to_menu\"")

			return StateSplashScreen
		end
	end

	if self.exit_all_to_menu_lobby and not self.is_exiting then
		self.is_exiting = true

		if network_game then
			network_manager:exit_all_to_menu_lobby()
		end
	end

	if self.reload_level and not self.exiting and network_game then
		network_manager:reload_level()
	end

	if self.load_next_level and not self.is_exiting then
		self.is_exiting = true

		if network_game then
			local level_cycle = self.parent.loading_context.level_cycle
			local level_cycle_length = #level_cycle
			local level_cycle_count = self.parent.loading_context.level_cycle_count % level_cycle_length + 1

			if table.find(argv, "-random-map") then
				level_cycle_count = math.random(1, level_cycle_length)
			end

			self.parent.loading_context.level_cycle_count = level_cycle_count

			local next_level = level_cycle[level_cycle_count]
			local level_key = next_level.level
			local game_mode_key = next_level.game_mode
			local game_mode_size = next_level.game_mode_size
			local win_score = next_level.win_score
			local time_limit = next_level.time_limit
			local level = LevelSettings[level_key]
			local lobby_manager = Managers.lobby
			local lobby = lobby_manager.lobby

			if lobby_manager.server and lobby and lobby.set_map then
				local map = level.game_server_map_name

				lobby_manager.lobby:set_map(map)
				lobby_manager:set_game_tag("game_mode_key", game_mode_key)
			end

			network_manager:load_next_level(level_key, game_mode_key, win_score, time_limit, game_mode_size)
		end
	end

	if self.change_level then
		self.change_level.countdown = self.change_level.countdown - dt

		if self.change_level.countdown <= 0 and not self.is_exiting then
			self.is_exiting = true

			if network_game then
				local level_key = self.change_level.name
				local game_mode_key = self.change_level.settings.game_mode
				local game_mode_size = self.change_level.settings.game_mode_size
				local win_score = self.change_level.settings.win_score
				local time_limit = self.change_level.settings.time_limit
				local lobby_manager = Managers.lobby
				local lobby = lobby_manager.lobby

				if lobby_manager.server and lobby and lobby.set_map then
					local map = LevelSettings[level_key].game_server_map_name

					lobby_manager.lobby:set_map(map)
					lobby_manager:set_game_tag("game_mode_key", game_mode_key)
				end

				Managers.admin:set_rcon_admin(nil)
				network_manager:load_next_level(level_key, game_mode_key, win_score, time_limit, game_mode_size)
			end
		end
	end

	local new_state = self:_check_exit(t)

	if new_state then
		return new_state
	end

	Managers.state.debug:update(dt, t)
	Managers.state.group:update(dt, t)

	if GameModeSettings[self._game_mode_key].has_ai then
		Managers.state.ai_resource:update(dt, t)
	end

	if Managers.lobby.lobby and network_game then
		self._stats_synchronizer:update(dt, t, network_game)
	end
end

function StateIngame:_check_game_licenses(dt, t)
	for player, _ in pairs(self._game_license_check_list) do
		local network_id = player:network_id()
		local result = SteamGameServer.has_license(network_id, 230940)

		if result == SteamGameServer.USER_HAS_LICENSE or SteamGameServer.app_id() ~= 42160 then
			self._game_license_check_list[player] = nil
		elseif result == SteamGameServer.USER_HAS_NOT_LICENSE or player.is_demo then
			local game_mode_key = Managers.state.game_mode:game_mode_key()

			if not Managers.admin:is_demo_player_allowed(game_mode_key) then
				Managers.admin:kick_player(network_id, "demo")
			end

			self._game_license_check_list[player] = nil
		end
	end
end

function StateIngame:cb_transition_fade_in_done(new_state)
	self._new_state = new_state
end

function StateIngame:game_start_countdown()
	return self._game_start_countdown
end

function StateIngame:event_level_ended(end_of_round_only)
	print("StateIngame:event_level_ended(", end_of_round_only, ")")

	if not Managers.lobby.lobby then
		self.exit_to_menu = true
		self.parent.goto_menu_node = "single_player_level_select"
	elseif end_of_round_only then
		self.reload_level = true

		self:_save_reload_level_loading_context()
	else
		self.load_next_level = true
	end
end

function StateIngame:_save_reload_level_loading_context()
	local reload_loading_context = {}

	reload_loading_context.team = Managers.state.team:reload_loading_context()
	reload_loading_context.stats = Managers.state.stats_collection:reload_loading_context()
	self.parent.loading_context.reload_level_data = reload_loading_context
end

function StateIngame:_check_exit(t)
	local network_manager = Managers.state.network

	if network_manager:exit_to_menu_lobby() and not self.exit_type then
		self.exit_type = "server_exit_to_lobby"
		self.exit_time = t + 2

		Window.set_show_cursor(false)
		Managers.state.event:trigger("disable_menu_input")
		Managers.state.hud:output_console_text("Server ended game, exiting to menu lobby...")
		Managers.transition:fade_in(MenuSettings.transitions.fade_in_speed, nil)
	end

	if network_manager:join_lobby_failed() and not self.exit_type then
		self.exit_type = "join_lobby_failed"
		self.exit_time = t + 2

		Window.set_show_cursor(false)
		Managers.state.event:trigger("disable_menu_input")
		Managers.state.hud:output_console_text("Lost connection with server, returning to menu...")
		Managers.transition:fade_in(MenuSettings.transitions.fade_in_speed, nil)
	end

	if network_manager:next_level_settings() == "reload_level" and not self.exit_type then
		self.exit_type = "reload_level"
		self.exit_time = t + 2

		Window.set_show_cursor(false)
		Managers.state.event:trigger("disable_menu_input")

		local next_level_settings = network_manager:next_level_settings()

		Managers.state.hud:output_console_text("Reloading level")
		Managers.transition:fade_in(MenuSettings.transitions.fade_in_speed, nil)
	end

	if network_manager:next_level_settings() and not self.exit_type then
		self.exit_type = "load_next_level"
		self.exit_time = t + 2

		Window.set_show_cursor(false)
		Managers.state.event:trigger("disable_menu_input")

		local next_level_settings = network_manager:next_level_settings()

		Managers.state.hud:output_console_text("Loading next level: " .. L(LevelSettings[next_level_settings.level_key].display_name) .. " ( " .. L(GameModeSettings[next_level_settings.game_mode_key].display_name) .. " )")
		Managers.transition:fade_in(MenuSettings.transitions.fade_in_speed, nil)
	end

	if network_manager:has_left_game() and not self.exit_type then
		self.exit_type = "left_game"
		self.exit_time = t + 2

		Window.set_show_cursor(false)
		Managers.state.event:trigger("disable_menu_input")
		Managers.state.hud:output_console_text("Left game, returning to menu...")
		Managers.transition:fade_in(MenuSettings.transitions.fade_in_speed, nil)
	end

	if self.exit_time and t >= self.exit_time then
		if self.exit_type == "server_exit_to_lobby" then
			if Managers.lobby.server then
				self.parent.goto_menu_node = "lobby_host"
			else
				self.parent.goto_menu_node = "lobby_join"
			end

			print("[StateIngame] Transition to StateSplashScreen on \"server_exit_to_lobby\"")

			return StateSplashScreen
		elseif self.exit_type == "left_game" then
			self._leave_lobby = true

			print("[StateIngame] Transition to StateSplashScreen on \"left_game\"")

			return StateSplashScreen
		elseif self.exit_type == "join_lobby_failed" then
			self._leave_lobby = true

			print("[StateIngame] Transition to StateSplashScreen on \"join_lobby_failed\"")

			return StateSplashScreen
		elseif self.exit_type == "reload_level" then
			self.parent.loading_context.game_start_countdown = 0

			return StateIngame
		elseif self.exit_type == "load_next_level" then
			local next_level_settings = network_manager:next_level_settings()

			self.parent.loading_context.level_key = next_level_settings.level_key
			self.parent.loading_context.game_mode_key = next_level_settings.game_mode_key
			self.parent.loading_context.time_limit = next_level_settings.time_limit
			self.parent.loading_context.win_score = next_level_settings.win_score
			self.parent.loading_context.game_start_countdown = next_level_settings.game_start_countdown
			self.parent.loading_context.game_mode_size = next_level_settings.game_mode_size

			print("[StateIngame] Transition to StateLoading on \"load_next_level\"")

			return StateLoading
		end
	end
end

function StateIngame:post_update(dt)
	local t = Managers.time:time("game")

	for _, machine in pairs(self.machines) do
		if machine.post_update then
			machine:post_update(dt, t)
		end
	end

	Managers.state.entity_system:post_update(dt)
end

function StateIngame:on_exit()
	for _, machine in pairs(self.machines) do
		machine:destroy()
	end

	if Managers.lobby.lobby then
		Managers.chat:unregister_channel(NetworkLookup.chat_channels.dead)
		Network.write_dump_tag("end of game")
	end

	self:_release_input()
	self:_teardown_state_context()
	self:_teardown_world()
	self:_clear_players()
	self:_release_level_resources()

	if self._leave_lobby then
		Managers.lobby:reset()
	end

	Managers.time:unregister_timer("game")

	if Managers.time:has_timer("round") then
		Managers.time:unregister_timer("round")
	end

	Application.set_time_step_policy("throttle", 60)
end

function StateIngame:_clear_players()
	local input = Managers.input
	local player_manager = Managers.player

	for i = 1, self._max_number_of_players do
		if i <= self.number_active_players then
			local player = player_manager:player(i)

			if not GameSettingsDevelopment.enable_robot_player then
				input:unmap_input_source(player.input_source)
			end

			player_manager:remove_player(i)
		end
	end

	for name, player in pairs(player_manager:players()) do
		if player.ai_player then
			player_manager:remove_player(name)
		end
	end
end

function StateIngame:_release_level_resources()
	local level_key = self._level_key
	local package_name = LevelSettings[level_key].package_name

	assert(package_name)

	if self.exit_type ~= "reload_level" then
		Managers.package:unload(package_name)
	end
end

function StateIngame:setup_state_context(reload_level_context)
	self._ducking_handler = DuckingHandler:new()
	Managers.state.event = EventManager:new()

	local server_game_mode_scale

	if Managers.lobby.server then
		server_game_mode_scale = self.parent.loading_context.game_mode_size or self.parent.loading_context.level_cycle[self.parent.loading_context.level_cycle_count].game_mode_size
	end

	Managers.state.game_mode = GameModeManager:new(self.world, self._game_mode_key, self._level_key, self._win_score, self._time_limit, server_game_mode_scale)

	if reload_level_context then
		Managers.state.stats_collection = StatsCollection:new(reload_level_context.stats)
		reload_level_context.stats = nil
	else
		Managers.state.stats_collection = StatsCollection:new()
	end

	if script_data.settings.dedicated_server then
		Managers.admin:setup()
		Managers.persistence:setup(Managers.state.stats_collection)
	end

	Managers.state.debug_text = DebugTextManager:new(self.world)

	if Managers.lobby.lobby then
		self._stats_synchronizer = StatsSynchronizer:new(Managers.state.stats_collection)
	end

	if GameModeSettings[self._game_mode_key].has_ai then
		Managers.state.ai_resource = AIResourceManager:new()
	end

	if Managers.lobby.server or not Managers.lobby.lobby then
		Managers.state.stats_collector = StatsCollectorServer:new(Managers.state.stats_collection)
		Managers.state.area_buff = AreaBuffManager:new(self.world)
		Managers.state.tagging = TaggingManager:new(self.world)
		Managers.state.death_zone = DeathZoneManager:new(self.world)
	elseif Managers.lobby.lobby then
		Managers.state.stats_collector = StatsCollectorClient:new()
	end

	Managers.state.camera = CameraManager:new(self.world)
	Managers.state.network = GameNetworkManager:new(self, self.world, Managers.lobby.lobby, Managers.state.entity)
	Managers.state.entity = EntityManager:new()
	Managers.state.team = TeamManager:new({
		red = {},
		white = {},
		unassigned = {}
	}, reload_level_context and reload_level_context.team)
	Managers.state.entity_system = EntitySystem:new({
		entity_manager = Managers.state.entity,
		world = self.world
	})
	Managers.state.hud = HUDManager:new(self.world)
	Managers.state.group = GroupManager:new(self.world)
	Managers.state.debug = DebugManager:new(self.world)
	Managers.state.profiling = ProfilingManager:new()
	Managers.state.projectile = ProjectileManager:new(self.world)
	Managers.state.spawn = SpawnManager:new(self.world)
	Managers.state.broken_gear = BrokenGearManager:new(self.world)
	Managers.state.voting = VotingManager:new()
end

function StateIngame:_teardown_state_context()
	self._ducking_handler:destroy()
	Managers.state:destroy()
end

function StateIngame:event_play_particle_effect(effect_name, unit, node, offset, rotation_offset, linked)
	if linked then
		ScriptWorld.create_particles_linked(self.world, effect_name, unit, node, "destroy", Matrix4x4.from_quaternion_position(rotation_offset, offset))
	else
		local pos, rot

		if unit then
			pos = Unit.world_position(unit, node)
			rot = Unit.world_rotation(unit, node)
		else
			pos = Vector3(0, 0, 0)
			rot = Quaternion.identity()
		end

		local global_transform = Matrix4x4.from_quaternion_position(rot, pos)
		local local_transform = Matrix4x4.from_quaternion_position(rotation_offset, offset)
		local transform = Matrix4x4.multiply(local_transform, global_transform)

		World.create_particles(self.world, effect_name, Matrix4x4.translation(transform), Matrix4x4.rotation(transform))
	end
end

function StateIngame:event_start_round()
	self._start_round = true
end

function StateIngame:spawn_allowed()
	return self._spawning
end

function StateIngame:event_player_created(player)
	if player.remote and GameSettingsDevelopment.server_license_check then
		self._game_license_check_list[player] = true
	end

	local network_id = player:network_id()
	local stats = Managers.state.stats_collection

	if not stats:has_context(network_id) then
		stats:create_context(network_id, StatsContexts.player)
		Managers.state.event:trigger("local_player_stats_context_created", player)
	end

	Managers.state.event:trigger("player_joined", player)
end

function StateIngame:event_next_level()
	self.load_next_level = true
end

function StateIngame:event_reload_level()
	self.reload_level = true
end

function StateIngame:event_change_level(level_key, map_settings)
	self.change_level = {
		countdown = 3,
		name = level_key,
		settings = map_settings
	}
end

function StateIngame:event_kicked_from_game(msg)
	self.parent.loading_context.leave_reason = "You were kicked (" .. msg .. ")."
end

function StateIngame:event_daily_win_bonus_awarded(amount)
	Managers.sale_popup:create_daily_award_item(amount)
end

function StateIngame:event_round_win_bonus_awarded(amount)
	Managers.sale_popup:create_round_award_item(amount)
end
