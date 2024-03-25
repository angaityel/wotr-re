-- chunkname: @scripts/game_state/state_ingame_running.lua

require("scripts/settings/controller_settings")
require("scripts/settings/mount_profiles")
require("scripts/settings/ai_profiles")
require("scripts/settings/player_profiles")
require("scripts/settings/sp_profiles")
require("scripts/settings/heads")
require("scripts/settings/helmets")
require("scripts/settings/armours")
require("scripts/settings/material_effect_mappings")
require("scripts/settings/player_data")
require("scripts/helpers/level_helper")
require("scripts/helpers/achievement/achievement_helper")
require("scripts/menu/menus/ingame_menu")
require("scripts/menu/menus/scoreboard")
require("scripts/menu/menus/final_scoreboard_menu")
require("scripts/utils/big_picture_input_handler")

StateInGameRunning = class(StateInGameRunning)

local BUTTON_THRESHOLD = 0.5
local CHAT_INPUT_DEFAULT_COMMAND = "say"
local MAX_CHAT_INPUT_CHARS = 150

function StateInGameRunning:on_enter(params)
	self.world = self.parent.world
	self.params = params
	self.viewport_name = self.params.viewport_name
	self._default_camera_position = Vector3Box(0, 0, 0)
	self._default_camera_rotation = QuaternionBox(Quaternion.identity())
	self.player_index = self.params.player

	local player = Managers.player:player(self.player_index)

	self.player = player

	self:_setup_viewport()
	self:_setup_input()
	self:_setup_camera()
	self:_setup_menus()

	self._input_source_look = nil
	self._gained_xp_and_coins = {}
	self._penalty_xp = {}
	self._awarded_prizes = {}
	self._awarded_medals = {}
	self._awarded_ranks = {}

	if GameSettingsDevelopment.enable_robot_player then
		self.player.state_data.spawn_profile = Math.random(1, 4)
	elseif Managers.lobby.lobby then
		player.state_data.spawn_profile = nil
	else
		player.state_data.spawn_profile = 2
	end

	Managers.state.hud:add_player(self.player, self._menu_world)

	local event_manager = Managers.state.event

	event_manager:register(self, "ghost_mode_deactivated", "event_ghost_mode_deactivated")
	event_manager:register(self, "dead_player_unit_despawned", "event_dead_player_unit_despawned")
	event_manager:register(self, "game_started", "event_game_started")
	event_manager:register(self, "close_ingame_menu", "event_close_ingame_menu")
	event_manager:register(self, "force_close_ingame_menu", "event_force_close_ingame_menu")
	event_manager:register(self, "spawn_target_denied", "event_spawn_target_denied")
	event_manager:register(self, "gm_event_end_conditions_met", "gm_event_end_conditions_met")
	event_manager:register(self, "set_default_camera_pose", "event_set_default_camera_pose")
	event_manager:register(self, "event_level_ended", "event_level_ended")
	event_manager:register(self, "event_sp_level_ended", "event_level_ended")
	event_manager:register(self, "join_team_confirmed", "event_join_team_confirmed")
	event_manager:register(self, "location_print_requested", "event_location_print_requested")
	event_manager:register(self, "gained_xp_and_coins", "event_gained_xp_and_coins")
	event_manager:register(self, "penalty_xp", "event_penalty_xp")
	event_manager:register(self, "awarded_prize", "event_awarded_prize")
	event_manager:register(self, "awarded_medal", "event_awarded_medal")
	event_manager:register(self, "player_killed_by_enemy", "event_player_killed_by_enemy")

	self._chat_input_blackboard = {
		text = ""
	}
	self._light_chat_shutdown = false

	Managers.state.event:trigger("event_chat_initiated", self._chat_input_blackboard)

	self._game_mode_events = GameModeEvents:new(self.world, player)

	if Managers.lobby.server or not Managers.lobby.lobby then
		Managers.state.event:trigger("game_started")
	end

	self._big_picture_input_handler = BigPictureInputHandler:new()
	self._gui = World.create_screen_gui(self._menu_world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")
	self._environment_state = "default"
	self._observer_camera_controller = ObserverCameraController:new(player)
end

ObserverCameraController = class(ObserverCameraController)

function ObserverCameraController:init(player)
	self._player = player
	self._target_player_id = nil
	self._mode = "limited"
end

local BUTTON_THRESHOLD = 0.5

function ObserverCameraController:_pick_observer_target(dt, t, last_id, own_player, input)
	local player_manager = Managers.player
	local last_player = player_manager:player_exists(last_id) and player_manager:player(last_id)
	local targets = self:_get_targets()
	local move_left = input:get("select_left_click")
	local move_right = input:get("select_right_click")
	local player, unit

	if not last_player then
		player, unit = self:_first_target(targets, own_player)
	elseif move_right then
		player, unit = self:_next_target(targets, last_player, own_player)
	elseif move_left or not Unit.alive(last_player.player_unit) then
		player, unit = self:_last_target(targets, last_player, own_player)
	else
		player = last_player
		unit = last_player.player_unit
	end

	return player and player:player_id() or nil, unit
end

function ObserverCameraController:_first_target(targets, own_player)
	for _, player in pairs(targets) do
		if player ~= own_player and Unit.alive(player.player_unit) then
			return player, player.player_unit
		end
	end
end

function ObserverCameraController:_next_target(targets, current, own_player)
	local found_current, target

	for _, player in pairs(targets) do
		if player ~= own_player then
			local unit = player.player_unit

			if player == current then
				found_current = true

				if Unit.alive(unit) then
					target = target or player
				end
			elseif found_current and Unit.alive(unit) then
				return player, unit
			elseif Unit.alive(unit) then
				target = target or player
			end
		end
	end

	return target, target and target.player_unit
end

function ObserverCameraController:_last_target(targets, current, own_player)
	local found_current, target

	for _, player in pairs(targets) do
		if player ~= own_player then
			local unit = player.player_unit

			if player == current and target then
				return target, unit
			elseif Unit.alive(unit) then
				target = player
			end
		end
	end

	return target, target and target.player_unit
end

function ObserverCameraController:_get_targets()
	local team = self._player.team

	if team and Managers.state.game_mode:team_locked_observer_cam(team) then
		return Managers.player:players()
	elseif team then
		return team:get_members()
	else
		return {}
	end
end

function ObserverCameraController:update(dt, t, player, viewport_name, camera_manager, input)
	local tree_name = "player"
	local node_name = "squad_spawn_camera"
	local current_cam_unit = camera_manager:current_node_tree_root_unit(viewport_name)
	local owning_player_id, target = self:_pick_observer_target(dt, t, self._target_player_id, player, input)

	if target then
		player.camera_follow_unit = target
		self._target_player_id = owning_player_id

		camera_manager:set_frozen(false)

		if target ~= current_cam_unit then
			local preserve_aim_yaw = current_cam_unit ~= nil

			camera_manager:set_node_tree_root_unit(viewport_name, tree_name, target, nil, preserve_aim_yaw)
			camera_manager:set_camera_node(viewport_name, tree_name, node_name)
		end

		return true
	else
		player.camera_follow_unit = nil
		self._target_player_id = nil

		return false
	end
end

function ObserverCameraController:destroy()
	return
end

function StateInGameRunning:gm_event_end_conditions_met(winning_team_name, red_team_score, white_team_score, end_of_round_only)
	self:_set_all_menus_active(false)
	self._final_scoreboard_menu:set_active(true)
	self._final_scoreboard_menu:goto("final_scoreboard")

	local you_win = winning_team_name == (self.player.team and self.player.team.name)

	self:_set_battle_report_data(you_win)
	Managers.state.game_mode:stop_game_mode_music()

	if you_win then
		Managers.music:trigger_event("Play_win_match")
	else
		Managers.music:trigger_event("Play_lose_match")
	end
end

function StateInGameRunning:event_gained_xp_and_coins(reason, xp, coins)
	if not self._gained_xp_and_coins[reason] then
		self._gained_xp_and_coins[reason] = {
			count = 1,
			xp = xp,
			coins = coins
		}
	else
		local gained = self._gained_xp_and_coins[reason]

		gained.count = gained.count + 1
		gained.xp = gained.xp + xp
		gained.coins = gained.coins + coins
	end
end

function StateInGameRunning:event_penalty_xp(reason, amount)
	if not self._penalty_xp[reason] then
		self._penalty_xp[reason] = {
			count = 1,
			amount = amount
		}
	else
		local penalty = self._penalty_xp[reason]

		penalty.count = penalty.count + 1
		penalty.amount = penalty.amount + amount
	end
end

function StateInGameRunning:event_awarded_prize(name)
	if not self._awarded_prizes[name] then
		self._awarded_prizes[name] = 1
	else
		self._awarded_prizes[name] = self._awarded_prizes[name] + 1
	end
end

function StateInGameRunning:event_awarded_medal(name)
	if not self._awarded_medals[name] then
		self._awarded_medals[name] = 1
	else
		self._awarded_medals[name] = self._awarded_medals[name] + 1
	end
end

function StateInGameRunning:event_awarded_rank(rank)
	self._awarded_ranks[#self._awarded_ranks + 1] = rank
end

function StateInGameRunning:_set_battle_report_data(local_player_won)
	local players = {}

	for player_index, player in pairs(Managers.player:players()) do
		players[player_index] = {
			player_id = player:network_id(),
			player_name = player:name(),
			team_name = player.team.name
		}
	end

	local loading_context = self.parent.parent.loading_context

	loading_context.players = players
	loading_context.local_player_index = self.player.index
	loading_context.local_player_won = local_player_won
	loading_context.stats_collection = table.clone_instance(Managers.state.stats_collection)
	loading_context.gained_xp_and_coins = self._gained_xp_and_coins
	loading_context.penalty_xp = self._penalty_xp
	loading_context.awarded_prizes = self._awarded_prizes
	loading_context.awarded_medals = self._awarded_medals
	loading_context.awarded_ranks = self._awarded_ranks
end

function StateInGameRunning:_set_all_menus_active(active)
	self._ingame_menu:set_active(active)
	self._scoreboard:set_active(active)
	self._final_scoreboard_menu:set_active(active)
end

function StateInGameRunning:_setup_viewport()
	Managers.state.camera:create_viewport(self.viewport_name, Vector3.zero(), Quaternion.identity())
end

function StateInGameRunning:_setup_input()
	Window.set_show_cursor(false)
end

function StateInGameRunning:event_location_print_requested()
	local viewport_name = self.viewport_name
	local camera_pos = Managers.state.camera:camera_position(viewport_name)
	local camera_rot = Managers.state.camera:camera_rotation(viewport_name)

	Managers.state.hud:output_console_text("Camera position: " .. camera_pos .. "  Camera rotation: " .. camera_rot)
end

function StateInGameRunning:_setup_camera()
	local viewport_name = self.viewport_name
	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local camera_manager = Managers.state.camera

	camera_manager:load_node_tree(viewport_name, "default", "world")
	camera_manager:load_node_tree(viewport_name, "player", "player")
	camera_manager:load_node_tree(viewport_name, "horse", "horse")
	camera_manager:load_node_tree(viewport_name, "player_dead", "player_dead")
	camera_manager:load_node_tree(viewport_name, "cutscene", "cutscene")
	self:_set_default_camera(camera_manager, viewport_name)

	self._zoom_target = 0
	self._zoom_scale = 1
	self._zoom = 0

	local pad_active = Managers.input:pad_active(1)

	if pad_active then
		self._zoom_target = 1
	end
end

function StateInGameRunning:_setup_menus()
	self._menu_world = Managers.world:create_world("menu_world", GameSettingsDevelopment.default_environment, nil, 3, Application.DISABLE_PHYSICS)

	ScriptWorld.create_viewport(self._menu_world, "menu_viewport", "overlay", 3)

	local menu_data = {
		viewport_name = "menu_viewport",
		local_player = self.player
	}

	Profiler.start("INGAME MENU")

	self._ingame_menu = IngameMenu:new(self, self._menu_world, menu_data)
	self._scoreboard = Scoreboard:new(self, self._menu_world, menu_data)
	self._final_scoreboard_menu = FinalScoreboardMenu:new(self, self._menu_world, menu_data)

	Profiler.stop()
end

function StateInGameRunning:event_set_default_camera_pose(position, rotation)
	self._default_camera_position:store(position)
	self._default_camera_rotation:store(rotation)
end

function StateInGameRunning:_set_default_camera(camera_manager, viewport_name)
	camera_manager:set_node_tree_root_position(viewport_name, "default", self._default_camera_position:unbox())
	camera_manager:set_node_tree_root_rotation(viewport_name, "default", self._default_camera_rotation:unbox())
	camera_manager:set_camera_node(viewport_name, "default", "default")
end

function StateInGameRunning:update(dt, t)
	self:_update_director_mode(dt, t)

	local player = self.player
	local input = player.input_source

	self:_update_input(dt, t, input)

	local free_flight_active = Managers.free_flight:active(self.player_index) or Managers.free_flight:active("global")
	local free_flight_mode = Managers.free_flight:mode(self.player_index) == "player_mechanics"
	local cutscene_active = Managers.state.entity:system("cutscene_system"):active()

	self._disable_input = self._ingame_menu:active() or self._final_scoreboard_menu:active() or self._chat_input_active or free_flight_active and free_flight_mode ~= "player_mechanics" or cutscene_active or self._overlay_active

	if not self._disable_input then
		self:_update_locomotion_input(dt)
	end

	local spawn_data = player.spawn_data

	if self._ingame_menu:active() and Managers.time:time("round") >= 0 then
		if self._ingame_menu:current_page_type() == "outfit_editor" or self._ingame_menu:current_parent_page_type() == "outfit_editor" then
			self._ingame_menu:goto("select_team")
		end
	elseif (spawn_data.state == "dead" or spawn_data.state == "not_spawned") and spawn_data.mode == "unconfirmed_squad_member" then
		local spawn_target = spawn_data.squad_unit

		if Unit.alive(spawn_target) then
			local result = Managers.state.spawn:calculate_valid_squad_spawn_point(player, spawn_target, false)

			if result == "success" and not self._disable_input and player.input_source:get("leave_ghost_mode") then
				Managers.state.spawn:set_squad_spawn_target(player, spawn_target)
			end
		end
	end

	self:_update_environment(dt, t)
	self:_update_camera(dt, t, input)
	self._ingame_menu:update(dt, t)
	self._scoreboard:update(dt, t)
	self._final_scoreboard_menu:update(dt, t)
	Managers.state.debug_text:update(dt, self.viewport_name)

	if GameSettingsDevelopment.show_version_info then
		HUDHelper:render_version_info(self._gui)
	end

	if GameSettingsDevelopment.show_fps then
		HUDHelper:render_fps(self._gui, dt)
	end

	if Application.build() ~= "release" and Keyboard.pressed(Keyboard.button_index("numpad +")) and Managers.lobby.lobby then
		Network.write_dump_tag("LAG!")

		local network_manager = Managers.state.network

		if network_manager:game() and not Managers.lobby.server then
			network_manager:send_rpc_server("rpc_write_network_dump_tag", NetworkLookup.network_dump_tags["LAG!"])
		end

		Managers.state.hud:output_console_text("Lag description 'LAG!' written to network dump.")
	end

	local out_of_spawns = Managers.state.game_mode:allowed_spawns(player.team) <= player.spawn_data.spawns

	if self._ingame_menu:active() and self._ingame_menu:current_page_type() == "pre_spawn_select_spawnpoint" and out_of_spawns then
		self._force_close_ingame_menu = true
	end

	if self._delayed_controller_overlay_deactivate then
		self._overlay_active = self._big_picture_input_handler:is_deactivating()

		if not self._overlay_active then
			self._delayed_controller_overlay_deactivate = nil
		end
	end

	if self._overlay_active then
		local text, done, submitted = self._big_picture_input_handler:poll_text_input_done()

		if done then
			if submitted then
				self:_execute_controller_chat_input(text)
			end

			self._delayed_controller_overlay_deactivate = true
		end
	end

	if self._force_close_ingame_menu then
		self._force_close_ingame_menu = false

		self._ingame_menu:set_active(false)
	end

	if self._delayed_chat_input_deactivate then
		self._chat_input_active = false
		self._delayed_chat_input_deactivate = nil
	end
end

function StateInGameRunning:_update_environment(dt, t)
	local player = self.player
	local player_unit = Unit.alive(player.player_unit) and player.player_unit
	local damage_ext = player_unit and ScriptUnit.has_extension(player_unit, "damage_system") and ScriptUnit.extension(player_unit, "damage_system")
	local locomotion_ext = player_unit and ScriptUnit.has_extension(player_unit, "locomotion_system") and ScriptUnit.extension(player_unit, "locomotion_system")
	local new_state

	new_state = not player_unit and "default" or locomotion_ext and locomotion_ext.being_executed and "executed" or damage_ext and not (not damage_ext:is_knocked_down() and not damage_ext:is_dead()) and "knocked_down" or damage_ext and not (not damage_ext:is_wounded() and not damage_ext:is_knocked_down() and not damage_ext:is_dead()) and "wounded" or locomotion_ext and locomotion_ext._ghost_mode_blend_timer and "ghost_mode_blend" or locomotion_ext and locomotion_ext.ghost_mode and "ghost_mode" or "default"

	local level_settings = LevelSettings[Managers.state.game_mode:level_key()]

	if new_state == "ghost_mode" and self._environment_state ~= "ghost_mode" then
		local state = level_settings.ghost_mode_setting or "default"

		Managers.state.camera:change_environment(state, 0)
	elseif new_state == "executed" and self._environment_state ~= "executed" then
		local state = level_settings.executed_setting or "default"

		Managers.state.camera:change_environment(state, EnvironmentTweaks.time_to_blend_env)
	elseif new_state == "knocked_down" and self._environment_state ~= "knocked_down" then
		local state = level_settings.knocked_down_setting or "default"

		Managers.state.camera:change_environment(state, EnvironmentTweaks.time_to_blend_env)
	elseif new_state == "wounded" and self._environment_state ~= "wounded" then
		local state = level_settings.wounded_setting or "default"

		Managers.state.camera:change_environment(state, EnvironmentTweaks.time_to_blend_env)
	elseif new_state == "ghost_mode_blend" and self._environment_state ~= "ghost_mode_blend" then
		local state = level_settings.ghost_mode_setting and "ghost_mode_blend" or "default"

		Managers.state.camera:change_environment(state, EnvironmentTweaks.time_to_blend_env)
	elseif new_state == "default" and self._environment_state ~= "default" then
		local state = "default"
		local time = self._environment_state == "ghost_mode_blend" and EnvironmentTweaks.time_to_default_env or EnvironmentTweaks.time_to_blend_env

		Managers.state.camera:change_environment(state, time)
	end

	self._environment_state = new_state
end

function StateInGameRunning:_update_input(dt, t, input)
	local player = self.player

	if input:get("vote_yes") then
		Managers.state.voting:client_vote("yes", player)
	elseif input:get("vote_no") then
		Managers.state.voting:client_vote("no", player)
	end

	if self._chat_input_active then
		self:_modify_chat_input_blackboard(dt, t, input)

		if self._ingame_menu:active() or self._final_scoreboard_menu:active() or self._scoreboard:active() or self.parent.is_exiting then
			self:_deactivate_chat_input(true)
			Window.set_show_cursor(true)
		elseif input:get("execute_chat_input") then
			self:_execute_chat_input()
		elseif input:get("deactivate_chat_input") then
			self:_deactivate_chat_input()
		end
	else
		if input:get("activate_chat_input") and not self._ingame_menu:active() and not self._final_scoreboard_menu:active() and not self._scoreboard:active() and not self.parent.is_exiting then
			self:_activate_chat_input(input, nil)
		elseif input:get("activate_chat_input_all") and not self._ingame_menu:active() and not self._final_scoreboard_menu:active() and not self._scoreboard:active() and not self.parent.is_exiting then
			if not self._overlay_active then
				self:_activate_chat_input(input, Managers.command_parser:build_command_line("say", ""), true)
			end
		elseif input:get("activate_chat_input_team") and player.team and player.team.name ~= "unassigned" and not self._ingame_menu:active() and not self._final_scoreboard_menu:active() and not self._scoreboard:active() and not self.parent.is_exiting then
			self:_activate_chat_input(input, Managers.command_parser:build_command_line("say_team", ""))
		elseif Managers.lobby.server and input:get("exit_to_menu_lobby") then
			self.parent.exit_all_to_menu_lobby = true
		elseif Managers.lobby.server and input:get("load_next_level") then
			self.parent.load_next_level = true
		elseif input:get("cancel") then
			if not self.parent.is_exiting and Managers.time:has_timer("round") and not self._ingame_menu:active() and not self._final_scoreboard_menu:active() and not self._scoreboard:active() then
				self._ingame_menu:set_active(true)
				self._ingame_menu:cancel_to("root")
			elseif self._ingame_menu:active() and self._ingame_menu:current_page_is_root() then
				self._ingame_menu:set_active(false)
			end
		end

		if not self._final_scoreboard_menu:active() and not self._ingame_menu:active() then
			local show_scoreboard = Managers.lobby.lobby and input:get("scoreboard") == 1

			if show_scoreboard and not self._scoreboard:active() or not show_scoreboard and self._scoreboard:active() then
				self._scoreboard:set_active(show_scoreboard)
			end
		end

		local cutscene_system = Managers.state.entity:system("cutscene_system")

		if cutscene_system:active() and input:get("skip_cutscene") then
			cutscene_system:skip()
		end
	end
end

function StateInGameRunning:_update_locomotion_input(dt)
	for unit, _ in pairs(self.player.owned_units) do
		if ScriptUnit.has_extension_input(unit, "locomotion_system") then
			local locomotion_input = ScriptUnit.extension_input(unit, "locomotion_system")

			locomotion_input.controller = self.player.input_source
		end
	end
end

function StateInGameRunning:post_update(dt, t)
	Profiler.start("StateInGameRunning:post_update()")
	Profiler.start("Managers.state.camera:post_update()")
	Managers.state.camera:post_update(dt, self.viewport_name, self._input_source_look)
	Profiler.stop()

	if not Managers.lobby.lobby or Managers.state.network:game() then
		Profiler.start("Managers.state.hud:post_update()")
		Managers.state.hud:post_update(dt, t, self.player)
		Profiler.stop()
	end

	Profiler.stop()
end

function StateInGameRunning:_activate_chat_input(input, prefix, try_big_picture)
	if GameSettingsDevelopment.network_mode ~= "steam" or not Managers.lobby.lobby or self._overlay_active then
		return
	end

	if try_big_picture then
		local reason = ""

		self._overlay_active, reason = self._big_picture_input_handler:show_text_input(L("enter_chat_message"), 0, MAX_CHAT_INPUT_CHARS)

		if self._overlay_active then
			self._disable_input = true

			local text = prefix or self._chat_input_prefix or Managers.command_parser:build_command_line(CHAT_INPUT_DEFAULT_COMMAND, "")

			self._chat_input_blackboard.text = text

			return
		elseif reason == "deactivating" then
			return
		end
	end

	self._chat_input_active = true

	local chat_bb = self._chat_input_blackboard
	local text

	if self._light_chat_shutdown then
		text = chat_bb.text
		self._light_chat_shutdown = false
	else
		text = prefix or self._chat_input_prefix or Managers.command_parser:build_command_line(CHAT_INPUT_DEFAULT_COMMAND, "")
		chat_bb.text = text
	end

	local length = string.len(text)
	local index = 1
	local utf8chars = 0
	local _

	while index <= length do
		_, index = Utf8.location(text, index)
		utf8chars = utf8chars + 1
	end

	chat_bb.input_index = utf8chars + 1

	Managers.state.event:trigger("event_chat_input_activated")
end

function StateInGameRunning:_execute_chat_input()
	self._chat_input_active = false

	local command = Managers.command_parser:execute(self._chat_input_blackboard.text, self.player)

	if command then
		self._chat_input_prefix = Managers.command_parser:build_command_line(command, "")
	end

	Managers.state.event:trigger("event_chat_input_deactivated")
end

function StateInGameRunning:_execute_controller_chat_input(text)
	local command = Managers.command_parser:execute(self._chat_input_blackboard.text .. text, self.player)

	if command then
		self._chat_input_prefix = Managers.command_parser:build_command_line(command, "")
	end
end

function StateInGameRunning:_deactivate_chat_input(shutdown_light)
	self._delayed_chat_input_deactivate = true
	self._light_chat_shutdown = shutdown_light

	Managers.state.event:trigger("event_chat_input_deactivated")
end

function StateInGameRunning:_modify_chat_input_blackboard(dt, t, input)
	local text = self._chat_input_blackboard.text
	local index = self._chat_input_blackboard.input_index
	local mode = self._chat_input_blackboard.input_mode or "insert"
	local keystrokes = Keyboard.keystrokes()
	local new_text, new_index, new_mode = KeystrokeHelper.parse_strokes(text, index, mode, keystrokes)

	if KeystrokeHelper.num_utf8chars(new_text) > MAX_CHAT_INPUT_CHARS then
		return
	end

	self._chat_input_blackboard.text = new_text
	self._chat_input_blackboard.input_index = new_index
	self._chat_input_blackboard.input_mode = new_mode
end

KeystrokeHelper = KeystrokeHelper or {}

function KeystrokeHelper.num_utf8chars(text)
	local length = string.len(text)
	local index = 1
	local num_chars = 0
	local _

	while index <= length do
		_, index = Utf8.location(text, index)
		num_chars = num_chars + 1
	end

	return num_chars
end

function KeystrokeHelper.parse_strokes(text, index, mode, keystrokes)
	local text_table = KeystrokeHelper._build_utf8_table(text)

	for _, stroke in ipairs(keystrokes) do
		if type(stroke) == "string" then
			index, mode = KeystrokeHelper._add_character(text_table, stroke, index, mode)
		elseif stroke == Keyboard.ENTER then
			break
		elseif KeystrokeHelper[stroke] then
			index, mode = KeystrokeHelper[stroke](text_table, index, mode)
		end
	end

	local new_text = ""

	for _, text_snippet in ipairs(text_table) do
		new_text = new_text .. text_snippet
	end

	return new_text, index, mode
end

function KeystrokeHelper._build_utf8_table(text)
	local text_table = {}
	local character_index = 1
	local index = 1
	local length = string.len(text)

	while index <= length do
		local start_index, end_index = Utf8.location(text, index)

		text_table[character_index] = string.sub(text, index, end_index - 1)
		character_index = character_index + 1
		index = end_index
	end

	return text_table
end

function KeystrokeHelper._add_character(text_table, text, index, mode)
	if mode == "insert" then
		table.insert(text_table, index, text)
	else
		text_table[index] = text
	end

	return index + 1, mode
end

KeystrokeHelper[Keyboard.LEFT] = function(text_table, index, mode)
	return math.max(index - 1, 1), mode
end
KeystrokeHelper[Keyboard.RIGHT] = function(text_table, index, mode)
	return math.min(index + 1, #text_table + 1), mode
end
KeystrokeHelper[Keyboard.UP] = nil
KeystrokeHelper[Keyboard.DOWN] = nil
KeystrokeHelper[Keyboard.INSERT] = function(text_table, index, mode)
	return index, mode == "insert" and "overwrite" or "insert"
end
KeystrokeHelper[Keyboard.HOME] = function(text_table, index, mode)
	return 1, mode
end
KeystrokeHelper[Keyboard.END] = function(text_table, index, mode)
	return #text_table + 1, mode
end
KeystrokeHelper[Keyboard.BACKSPACE] = function(text_table, index, mode)
	local backspace_index = index - 1

	if backspace_index < 1 then
		return index, mode
	end

	table.remove(text_table, backspace_index)

	return backspace_index, mode
end
KeystrokeHelper[Keyboard.TAB] = function(text_table, index, mode)
	return KeystrokeHelper._add_character(text_table, "\t", index, mode)
end
KeystrokeHelper[Keyboard.PAGE_UP] = nil
KeystrokeHelper[Keyboard.PAGE_DOWN] = nil
KeystrokeHelper[Keyboard.ESCAPE] = nil
KeystrokeHelper[Keyboard.DELETE] = function(text_table, index, mode)
	if text_table[index] then
		table.remove(text_table, index)
	end

	return index, mode
end

function StateInGameRunning:event_player_killed_by_enemy(own_player, attacking_player)
	if own_player ~= self.player then
		return
	end

	self._killer_player = attacking_player
	self._killer_player_time = Managers.time:time("game") + 2
end

function StateInGameRunning:_update_camera(dt, t, input)
	local player = self.player
	local viewport_name = player.viewport_name
	local camera_manager = Managers.state.camera
	local spawn_data = player.spawn_data
	local spawn_state = spawn_data.state
	local spawns = spawn_data.spawns
	local wants_observer = (spawn_state == "dead" or spawn_state == "not_spawned") and Managers.state.game_mode:allowed_spawns(player.team) <= player.spawn_data.spawns
	local observer = not self._killer_player and not self._show_killer_profile and wants_observer

	if observer and self._observer_camera_controller:update(dt, t, player, viewport_name, camera_manager, input) then
		-- block empty
	else
		self:_update_camera_target(dt, t, player, viewport_name, camera_manager, input, wants_observer)
	end

	self._input_source_look = Vector3(0, 0, 0)

	local pad_active

	if not self._disable_input then
		local player_unit = player.player_unit

		pad_active = Managers.input:pad_active(1)

		local locomotion = Unit.alive(player_unit) and ScriptUnit.extension(player_unit, "locomotion_system")
		local attempting_parry = locomotion and locomotion.attempting_parry and not locomotion.parrying
		local attempting_swing = locomotion and locomotion.attempting_pose and not locomotion.pose_ready
		local lock_camera_time = pad_active and PlayerUnitMovementSettings.lock_camera_when_attacking_time
		local sensitivity_x, sensitivity_y

		if pad_active then
			sensitivity_x = ActivePlayerControllerSettings.pad_sensitivity_x / 2
			sensitivity_y = ActivePlayerControllerSettings.pad_sensitivity_y / 2
		else
			sensitivity_x = ActivePlayerControllerSettings.sensitivity / 2
			sensitivity_y = sensitivity_x
		end

		if not self._lock_time or not attempting_parry and not attempting_swing and (not self._lock_time or t > self._lock_time) then
			self._lock_time = nil

			if locomotion and (locomotion.aiming or locomotion.tagging) then
				self._input_source_look = input:get("look_aiming") * sensitivity_x * (camera_manager:fov(viewport_name) / 0.785)
			else
				self._input_source_look = input:get("look") * (camera_manager:fov(viewport_name) / 0.785)
				self._input_source_look.x = self._input_source_look.x * sensitivity_x
				self._input_source_look.y = self._input_source_look.y * sensitivity_y
			end
		elseif not self._lock_time then
			self._lock_time = t + lock_camera_time
		end
	end

	local zoom_in = input:has("zoom_in")
	local zoom_out = input:has("zoom_out")
	local zoom = input:has("zoom")

	if not self._chat_input_active and zoom_in and zoom_out then
		if input:has("zoom") then
			local zoom_delta = input:get("zoom_in") * dt - input:get("zoom_out") * dt - input:get("zoom").y

			self._zoom_target = math.clamp(self._zoom_target + zoom_delta * CameraTweaks.zoom.scale, 0, 1)
		elseif pad_active then
			local zoom_delta = dt * (input:get("zoom_out") - input:get("zoom_in"))

			if zoom_delta ~= 0 then
				self._zoom_target = math.clamp(self._zoom_target + zoom_delta * CameraTweaks.zoom.pad_scale, 0, 1)
			end
		end
	end

	self._zoom = CameraTweaks.zoom.interpolation_function(self._zoom, self._zoom_target, dt)

	local zoom_variable = self._zoom

	camera_manager:set_variable(viewport_name, "look_controller_input", self._input_source_look)
	camera_manager:set_variable(viewport_name, "zoom", zoom_variable)
	camera_manager:update(dt, viewport_name)

	local node, tree, unit, zoom, yaw, pitch

	player:update_camera_game_object(camera_manager:camera_position(viewport_name), camera_manager:camera_rotation(viewport_name))
end

function StateInGameRunning:_update_camera_target(dt, t, player, viewport_name, camera_manager, input, wants_observer)
	local current_cam_unit = camera_manager:current_node_tree_root_unit(viewport_name)
	local unit = player.camera_follow_unit
	local spawn_data = player.spawn_data
	local tree_name, node_name

	if self._killer_player and (self._ingame_menu:active() or self._final_scoreboard_menu:active() or self._scoreboard:active() or not Unit.alive(self._killer_player.player_unit) or not spawn_data.state == "dead" or wants_observer and t > self._killer_player_time + 2 and (input:get("select_left_click") or input:get("select_right_click"))) then
		if self._show_killer_profile then
			self._show_killer_profile = false

			Managers.state.event:trigger("hide_profile")
		end

		self._killer_player = nil
		self._killer_player_time = nil
	end

	if (spawn_data.state == "dead" or spawn_data.state == "not_spawned") and (spawn_data.mode == "squad_member" or spawn_data.mode == "unconfirmed_squad_member") and Unit.alive(spawn_data.squad_unit) then
		player.camera_follow_unit = spawn_data.squad_unit
		unit = spawn_data.squad_unit
		tree_name = "player"
		node_name = "squad_spawn_camera"
	elseif self._killer_player and t > self._killer_player_time then
		local player_unit = self._killer_player.player_unit

		player.camera_follow_unit = player_unit
		tree_name = "player"
		node_name = "killer_cam"

		local game = Managers.state.network:game()

		if game and ScriptUnit.has_extension(player_unit, "locomotion_system") and not self._show_killer_profile then
			local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")
			local game_object = locomotion._player_profile_game_obj_id

			self._show_killer_profile = true

			if game_object then
				local profile = ProfileHelper:build_profile_from_game_object(game, game_object, locomotion:inventory())

				Managers.state.event:trigger("show_profile", profile, self._killer_player:name(), "instakill")
			end
		end
	end

	if (not unit or not Unit.alive(unit)) and (not current_cam_unit or not Unit.alive(current_cam_unit)) then
		self:_set_default_camera(camera_manager, viewport_name)

		player.camera_follow_unit = nil

		camera_manager:update(dt, viewport_name)

		return
	elseif not unit or not Unit.alive(unit) then
		unit = current_cam_unit
	end

	tree_name = tree_name or Unit.get_data(unit, "camera", "settings_tree")
	node_name = node_name or Unit.get_data(unit, "camera", "settings_node")

	if tree_name and node_name then
		camera_manager:set_frozen(false)
	else
		camera_manager:set_frozen(true)
		camera_manager:update(dt, viewport_name)

		return
	end

	if current_cam_unit ~= unit then
		local preserve_aim_yaw = current_cam_unit ~= nil

		camera_manager:set_node_tree_root_unit(viewport_name, tree_name, unit, nil, preserve_aim_yaw)
		camera_manager:set_camera_node(viewport_name, tree_name, node_name)
	elseif node_name ~= camera_manager:current_camera_node(viewport_name) then
		camera_manager:set_camera_node(viewport_name, tree_name, node_name)
	end
end

function StateInGameRunning:on_exit()
	self._ingame_menu:destroy()

	self._ingame_menu = nil

	self._scoreboard:destroy()

	self._scoreboard = nil

	self._final_scoreboard_menu:destroy()

	self._final_scoreboard_menu = nil

	World.destroy_gui(self._menu_world, self._gui)
	Managers.world:destroy_world(self._menu_world)
end

function StateInGameRunning:event_dead_player_unit_despawned(player)
	if player == self.player and not self._final_scoreboard_menu:active() and Managers.state.game_mode:squad_screen_spawning() and Managers.state.game_mode:allowed_spawns(player.team) > player.spawn_data.spawns then
		self._scoreboard:set_active(false)
		self._ingame_menu:set_active(true)

		if GameSettingsDevelopment.enable_robot_player then
			self._ingame_menu:goto("select_spawnpoint")
		else
			self._ingame_menu:goto("select_profile")
		end
	end
end

function StateInGameRunning:event_game_started(skip_team_selection)
	local squad_screen, auto_team = Managers.state.game_mode:squad_screen_spawning()

	if squad_screen then
		if EDITOR_LAUNCH then
			self._ingame_menu:goto("select_team")
		elseif skip_team_selection then
			self._ingame_menu:goto("select_profile")
		elseif Managers.time:has_timer("round") and Managers.time:time("round") < 0 then
			self._ingame_menu:goto("outfit_editor")
		else
			self._ingame_menu:goto("select_team")
		end

		self._scoreboard:set_active(false)
		self._ingame_menu:set_active(true)
	end

	local world = self.parent.world
	local level = LevelHelper:current_level(world)

	Level.trigger_event(level, "game_started")
end

function StateInGameRunning:event_join_team_confirmed()
	if not self._final_scoreboard_menu:active() then
		if self.player.state_data.spawn_profile then
			self._ingame_menu:goto("select_spawnpoint")
		else
			self._ingame_menu:goto("select_profile")
		end
	end
end

function StateInGameRunning:event_ghost_mode_deactivated()
	self._ingame_menu:set_active(false)
end

function StateInGameRunning:event_close_ingame_menu()
	self._ingame_menu:set_active(false)
end

function StateInGameRunning:event_force_close_ingame_menu()
	self._force_close_ingame_menu = true
end

function StateInGameRunning:event_spawn_target_denied()
	if not self._final_scoreboard_menu:active() then
		self._scoreboard:set_active(false)
		self._ingame_menu:set_active(true)
		self._ingame_menu:goto("select_spawnpoint")
	end
end

function StateInGameRunning:event_level_ended()
	if not Managers.lobby.lobby then
		local level_settings = LevelHelper:current_level_settings()

		self:_save_level_progression_id(level_settings.sp_progression_id)
		self:ingame_menu():set_active(false)

		self.parent.exit_to_menu = true
	end

	if false then
		-- block empty
	end
end

function StateInGameRunning:_save_level_progression_id(id)
	PlayerData.sp_level_progression_id = id > PlayerData.sp_level_progression_id and id or PlayerData.sp_level_progression_id
	SaveData.player_data = PlayerData

	Managers.save:auto_save(SaveFileName, SaveData, callback(self, "cb_player_data_saved"))
	Managers.state.event:trigger("event_save_started", "menu_saving_profile", "menu_profile_saved")
end

function StateInGameRunning:cb_player_data_saved(info)
	if info.error then
		Application.warning("Save error %q", info.error)
	end

	Managers.state.event:trigger("event_save_finished")
end

function StateInGameRunning:ingame_menu()
	return self._ingame_menu
end

function StateInGameRunning:_update_director_mode(dt, t)
	if script_data.director_mode then
		local player_unit = self.player.player_unit

		if not Unit.alive(player_unit) or not Managers.state.network:game() then
			return
		end

		if Keyboard.pressed(Keyboard.button_index("f5")) then
			Managers.state.network:send_rpc_server("rpc_teleport_team_to", NetworkLookup.team.white, Unit.world_position(player_unit, 0), Unit.world_rotation(player_unit, 0), Managers.state.camera:camera_rotation(self.viewport_name))
		end

		if Keyboard.pressed(Keyboard.button_index("f6")) then
			Managers.state.network:send_rpc_server("rpc_teleport_team_to", NetworkLookup.team.red, Unit.world_position(player_unit, 0), Unit.world_rotation(player_unit, 0), Managers.state.camera:camera_rotation(self.viewport_name))
		end

		if Keyboard.pressed(Keyboard.button_index("f7")) then
			Managers.state.network:send_rpc_server("rpc_teleport_all_to", Unit.world_position(player_unit, 0), Unit.world_rotation(player_unit, 0), Managers.state.camera:camera_rotation(self.viewport_name))
		end

		if Keyboard.pressed(Keyboard.button_index("f4")) then
			local physics_world = World.physics_world(self.world)

			local function callback(hit, position, distance, normal, actor)
				if not hit then
					return
				end

				if not actor then
					return
				end

				local unit = Actor.unit(actor)

				if not Unit.alive(unit) then
					return
				end

				local owner = Managers.player:owner(unit)

				if not owner then
					return
				end

				if Unit.alive(owner.player_unit) then
					Managers.state.network:send_rpc_server("rpc_teleport_unit_to", Managers.state.network:game_object_id(owner.player_unit), Unit.world_position(player_unit, 0), Unit.world_rotation(player_unit, 0), Managers.state.camera:camera_rotation(self.viewport_name))
				end
			end

			local raycast = PhysicsWorld.make_raycast(physics_world, callback, "collision_filter", "horse_collision_sweep")
			local from = Managers.state.camera:camera_position(self.viewport_name)
			local dir = Quaternion.forward(Managers.state.camera:camera_rotation(self.viewport_name))

			Raycast.cast(raycast, from, dir)
		end

		if Keyboard.pressed(Keyboard.button_index("f1")) then
			Managers.state.network:send_rpc_server("rpc_toggle_disable_damage")
		end

		if Keyboard.pressed(Keyboard.button_index("f2")) then
			Managers.state.network:send_rpc_server("rpc_toggle_unlimited_ammo", true)
		end
	end
end

function StateInGameRunning:ingame_menu_cancel_to(page_id)
	self._ingame_menu:cancel_to(page_id)
end
