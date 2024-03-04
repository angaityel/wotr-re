-- chunkname: @scripts/boot.lua

require("foundation/scripts/boot/boot")

Boot.foundation_update = Boot.update

function Boot:update(dt)
	Managers.perfhud:update(dt)
	Boot:foundation_update(dt)
	Managers.transition:update(dt)
	Managers.changelog:update(dt)
	Managers.news_ticker:update(dt)
	Window.set_clip_cursor(false)
end

Postman = Postman or {}

function project_setup()
	Postman:setup()

	return Postman.entrypoint()
end

function Postman:setup()
	script_data.settings = Application.settings()

	self:_require_scripts()

	if script_data.settings.dedicated_server then
		Application.set_time_step_policy("no_smoothing", "throttle", script_data.settings.dedicated_server_fps or 30)
		CommandWindow.open(self:_server_window_name())
		CommandWindow.print("Starting dedicated server")
	else
		Application.set_time_step_policy("no_smoothing")
		Application.set_time_step_policy("throttle", 60)
		self:_load_user_settings()
	end

	Application.set_time_step_policy("external_step_range", 0, 100)
	Application.set_time_step_policy("system_step_range", 0, 100)

	if GameSettingsDevelopment.remove_debug_stuff then
		remove_debug_stuff()
	end

	if script_data.settings.physics_dump then
		enable_physics_dump()
	end

	script_data.build_identifier = Application.build_identifier()

	self:_init_random()
	self:_init_mouse()
	self:_init_demo()

	if GameSettingsDevelopment.network_mode == "steam" and not script_data.settings.dedicated_server then
		rawset(_G, "STEAM", true)
	end

	self:_init_managers()

	if rawget(_G, "Steam") then
		print("User ID:", Steam.user_id(), Steam.user_name())
	end

	print("Engine revision:", script_data.build_identifier)
	print("Content revision:", script_data.settings.content_revision)
end

function Postman:_server_window_name()
	local settings = script_data.settings.steam.game_server_settings.server_init_settings
	local name = "WOTR - " .. settings.server_name .. ", process:" .. Application.process_id()

	name = name .. ", auth:" .. (settings.authentication_port or "8766")
	name = name .. ", query:" .. (settings.query_port or "27016")
	name = name .. ", game:" .. (settings.server_port or "27015")
	name = name .. ", rev:" .. (script_data.settings.content_revision or "?")
	name = name .. ", eng:" .. (Application.build_identifier() or "?")

	if rawget(_G, "Steam") then
		name = name .. ", appid: " .. Steam.app_id()
	end

	return name
end

function Postman:_require_scripts()
	local function core_require(path, ...)
		for _, s in ipairs({
			...
		}) do
			require("core/" .. path .. "/" .. s)
		end
	end

	local function game_require(path, ...)
		for _, s in ipairs({
			...
		}) do
			require("scripts/" .. path .. "/" .. s)
		end
	end

	local function foundation_require(path, ...)
		for _, s in ipairs({
			...
		}) do
			require("foundation/scripts/" .. path .. "/" .. s)
		end
	end

	Managers.package:load("resource_packages/script")
	core_require("bitsquid_splash", "bitsquid_splash")
	foundation_require("managers", "localization/localization_manager", "event/event_manager")
	game_require("settings", "dlc_settings", "ai_settings", "game_settings", "game_settings_development", "controller_settings")
	game_require("game_state", "state_context", "state_splash_screen", "state_menu", "state_menu_main", "state_loading", "state_ingame", "state_ingame_running", "state_dedicated_server_init", "state_automatic_dedicated_server_join", "state_invite_join", "state_test_gear")
	game_require("entity_system", "entity_system")
	game_require("managers", "command_parser/command_parser_manager", "player/player_manager", "save/save_manager", "save/save_data", "perfhud/perfhud_manager", "backend/backend_manager", "music/music_manager", "admin/admin_manager", "persistence/persistence_manager_server", "persistence/persistence_manager_server_offline", "persistence/persistence_manager_client", "persistence/persistence_manager_client_offline", "persistence/persistence_manager_common", "transition/transition_manager", "changelog/changelog_manager", "changelog/changelog_manager_offline", "news_ticker/news_ticker_manager", "sale_popup/sale_popup_manager")

	if GameSettingsDevelopment.enable_robot_player then
		game_require("managers", "input/input_manager")
	end

	game_require("utils", "util")
end

function Postman:_init_random()
	local seed = os.clock() * 10000 % 1000

	math.randomseed(seed)
	math.random(5, 30000)
end

function Postman:_init_mouse()
	Window.set_mouse_focus(true)
	Window.set_cursor("gui/cursors/mouse_cursor")
	Window.set_clip_cursor(true)
end

function Postman:_init_demo()
	if rawget(_G, "Steam") then
		IS_DEMO = not DLCSettings.full_game()
	else
		IS_DEMO = true

		print("NOT steam check")
	end
end

function Postman:_init_managers()
	self:_init_localizer()
	self:_init_lobby_manager()

	if script_data.settings.dedicated_server then
		local server_settings = Managers.lobby.game_server_settings or {
			server_init_settings = {}
		}

		Managers.admin = AdminManager:new(server_settings)
	elseif GameSettingsDevelopment.anti_cheat_enabled then
		Postman.anti_cheat_key = AntiCheatClient.generate_key()

		AntiCheatClient.initialize(13, Postman.anti_cheat_key)
	else
		Postman.anti_cheat_key = Application.make_hash()
	end

	self:_init_backend()

	Managers.input = InputManager:new()
	Managers.command_parser = CommandParserManager:new()
	Managers.save = SaveManager:new(script_data.settings.disable_cloud_save)
	Managers.perfhud = PerfhudManager:new()
	Managers.music = MusicManager:new()
	Managers.transition = TransitionManager:new()
	Managers.changelog = rawget(_G, "UrlLoader") ~= nil and ChangelogManager:new() or ChangelogManagerOffline:new()
	Managers.news_ticker = NewsTickerManager:new()
	Managers.sale_popup = SalePopupManager:new("http://services.paradoxplaza.com/head/feeds/wotr-sales-popup-config/content")
end

function Postman:_init_backend()
	Managers.backend = BackendManager:new()

	if script_data.settings.dedicated_server then
		if Managers.backend:available() then
			local backend_settings = {
				connection = {}
			}

			table.merge(backend_settings, Managers.admin:settings().backend)

			if type(script_data.settings.backend) == "table" then
				table.merge(backend_settings, script_data.settings.backend)
			end

			Managers.persistence = PersistenceManagerServer:new(backend_settings)
		else
			Managers.persistence = PersistenceManagerServerOffline:new()
		end
	elseif Managers.backend:available() and GameSettingsDevelopment.network_mode == "steam" then
		local backend_settings = {
			connection = {}
		}

		if type(script_data.settings.backend) == "table" then
			table.merge(backend_settings, script_data.settings.backend)
		end

		backend_settings.connection.address = GameSettingsDevelopment.backend_address
		Managers.persistence = PersistenceManagerClient:new(backend_settings)
	else
		Managers.persistence = PersistenceManagerClientOffline:new()
	end
end

function Postman:_load_user_settings()
	local show_hud_saved = Application.win32_user_setting("show_hud")

	if show_hud_saved ~= nil then
		HUDSettings.show_hud = show_hud_saved
	end

	local show_reticule_saved = Application.win32_user_setting("show_reticule")

	if show_reticule_saved ~= nil then
		HUDSettings.show_reticule = show_reticule_saved
	end

	local show_xp_awards = Application.user_setting("show_xp_awards")

	if show_xp_awards ~= nil then
		HUDSettings.show_xp_awards = show_xp_awards
	end

	local show_parry_helper = Application.user_setting("show_parry_helper")

	if show_parry_helper ~= nil then
		HUDSettings.show_parry_helper = show_parry_helper
	end

	local show_pose_charge_helper = Application.user_setting("show_pose_charge_helper")

	if show_pose_charge_helper ~= nil then
		HUDSettings.show_pose_charge_helper = show_pose_charge_helper
	end

	local invert_pose_control_x_saved = Application.win32_user_setting("invert_pose_control_x")

	if invert_pose_control_x_saved ~= nil then
		PlayerUnitMovementSettings.swing.invert_pose_control_x = invert_pose_control_x_saved
	end

	local invert_pose_control_y_saved = Application.win32_user_setting("invert_pose_control_y")

	if invert_pose_control_y_saved ~= nil then
		PlayerUnitMovementSettings.swing.invert_pose_control_y = invert_pose_control_y_saved
	end

	local invert_parry_control_x_saved = Application.win32_user_setting("invert_parry_control_x")

	if invert_parry_control_x_saved ~= nil then
		PlayerUnitMovementSettings.parry.invert_parry_control_x = invert_parry_control_x_saved
	end

	local invert_parry_control_y_saved = Application.win32_user_setting("invert_parry_control_y")

	if invert_parry_control_y_saved ~= nil then
		PlayerUnitMovementSettings.parry.invert_parry_control_y = invert_parry_control_y_saved
	end

	local mouse_sensitivity_saved = Application.win32_user_setting("mouse_sensitivity")

	if mouse_sensitivity_saved ~= nil then
		ActivePlayerControllerSettings.sensitivity = mouse_sensitivity_saved
	end

	local pad_sensitivity_x_saved = Application.win32_user_setting("pad_sensitivity_x")

	if pad_sensitivity_x_saved ~= nil then
		ActivePlayerControllerSettings.pad_sensitivity_x = pad_sensitivity_x_saved
	end

	local pad_sensitivity_y_saved = Application.win32_user_setting("pad_sensitivity_y")

	if pad_sensitivity_y_saved ~= nil then
		ActivePlayerControllerSettings.pad_sensitivity_y = pad_sensitivity_y_saved
	end

	local keyboard_parry_saved = Application.win32_user_setting("keyboard_parry")

	if keyboard_parry_saved ~= nil then
		PlayerUnitMovementSettings.parry.keyboard_controlled = keyboard_parry_saved
	end

	local keyboard_pose_saved = Application.win32_user_setting("keyboard_pose")

	if keyboard_pose_saved ~= nil then
		PlayerUnitMovementSettings.swing.keyboard_controlled = keyboard_pose_saved
	end

	local show_damage_numbers_saved = Application.win32_user_setting("show_damage_numbers")

	if show_damage_numbers_saved ~= nil then
		HUDSettings.show_damage_numbers = show_damage_numbers_saved
	end

	local music_volume = Application.win32_user_setting("music_volume")

	if music_volume then
		Timpani.set_bus_volume("music", music_volume)
	end

	local sfx_volume = Application.win32_user_setting("sfx_volume")

	if sfx_volume then
		Timpani.set_bus_volume("sfx", sfx_volume)
		Timpani.set_bus_volume("special", sfx_volume)
	end

	local master_volume = Application.win32_user_setting("master_volume")

	if master_volume then
		Timpani.set_bus_volume("Master Bus", master_volume)
	end

	local voice_over = Application.win32_user_setting("voice_over")

	if voice_over then
		Timpani.set_bus_volume("voice_over", voice_over)
	end

	local max_frames = Application.win32_user_setting("max_stacking_frames")

	if max_frames then
		Application.set_max_frame_stacking(max_frames)
	end

	local announcement_voice_over = Application.user_setting("announcement_voice_over")

	if announcement_voice_over then
		if announcement_voice_over == "brian_blessed" and DLCSettings.brian_blessed() then
			HUDSettings.announcement_voice_over = announcement_voice_over
		else
			HUDSettings.announcement_voice_over = "normal"
		end
	end
end

function Postman:_init_lobby_manager(network_mode)
	local network_mode = GameSettingsDevelopment.network_mode
	local options = {
		project_hash = "",
		port = GameSettingsDevelopment.network_port
	}

	if network_mode == "lan" then
		require("foundation/scripts/managers/network/lobby_manager_lan")

		Managers.lobby = LobbyManagerLan:new(options)
	elseif network_mode == "steam" then
		require("foundation/scripts/managers/network/lobby_manager_steam")

		Managers.lobby = LobbyManagerSteam:new(options)
	else
		ferror("Unknown network mode %q", network_mode)
	end
end

function Postman:_init_localizer()
	local language_id = "en"

	if rawget(_G, "Steam") then
		language_id = Steam:language()

		if language_id == "plhungarian" then
			language_id = "pl"
		elseif language_id == "ja" then
			language_id = "jp"
		end
	end

	Application.set_resource_property_preference_order(language_id)
	Managers.package:load("resource_packages/buttons")
	Managers.package:load("resource_packages/strings")
	Managers.package:load("resource_packages/post_localization_boot")

	Managers.localizer = LocalizationManager:new("localization/game_strings", language_id)

	for _, profile in pairs(PlayerProfiles) do
		profile.display_name = L(profile.display_name)
	end

	local function key_parser(key_name)
		local key = ActivePlayerControllerSettings[Managers.input:active_mapping(1)][key_name]

		if not key then
			print("MISSING CONTROLLER BUTTON: ", key_name)

			return
		end

		local key_locale_name

		if key.controller_type == "mouse" then
			key_locale_name = string.format("%s %s", "mouse", key.key)
		elseif key.controller_type == "pad" then
			key_locale_name = L("pad360_" .. key.key)
		else
			local controller = Managers.input:get_controller(key.controller_type)
			local key_index = controller.button_index(key.key)

			key_locale_name = controller.button_locale_name(key_index)
		end

		return key_locale_name
	end

	Managers.localizer:add_macro("KEY", key_parser)
end

function Postman:entrypoint()
	local application_settings = Application.settings()
	local args = {
		Application.argv()
	}
	local flythrough_command_line = false
	local test_gear_command_line = false

	for i = 1, #args do
		if args[i] == "-flythrough" then
			flythrough_command_line = true
		end
	end

	local function parse_lan_invite(args)
		for i = 1, #args do
			if args[i] == "+connect" then
				return "lobby2", args[i + 1]
			end
		end
	end

	if table.contains(args, "-test-gear") then
		test_gear_command_line = true
	end

	local invite_type, invite_id

	if GameSettingsDevelopment.network_mode == "lan" then
		invite_type, invite_id = parse_lan_invite(args)
	elseif rawget(_G, "Steam") and rawget(_G, "Friends") then
		invite_type, invite_id = Friends.boot_invite()
	end

	if test_gear_command_line then
		Managers.package:load("resource_packages/menu")
		Managers.package:load("resource_packages/ingame")
		Managers.package:load("resource_packages/weapons")

		return StateTestGear
	elseif invite_type and invite_type == Friends.INVITE_SERVER then
		local loading_context = {}

		loading_context.invite_type = "server"
		loading_context.invite_ip = invite_id
		loading_context.show_splash_screens = true
		loading_context.load_changelog = false
		Boot.loading_context = loading_context

		return StateSplashScreen
	elseif invite_type and invite_type == Friends.INVITE_LOBBY then
		local loading_context = {}

		loading_context.invite_type = "lobby"
		loading_context.invite_ip = invite_id
		loading_context.show_splash_screens = true
		loading_context.load_changelog = false
		Boot.loading_context = loading_context

		return StateSplashScreen
	elseif invite_type and invite_type == "lobby2" then
		local loading_context = {}

		loading_context.invite_type = "lobby2"
		loading_context.invite_ip = invite_id
		loading_context.show_splash_screens = true
		loading_context.load_changelog = false
		Boot.loading_context = loading_context

		return StateSplashScreen
	elseif application_settings.invite_debug_ip then
		Managers.package:load("resource_packages/menu")
		Managers.package:load("resource_packages/ingame")
		Managers.package:load("resource_packages/weapons")

		local loading_context = {}

		loading_context.invite_type = "server"
		loading_context.invite_ip = application_settings.invite_debug_ip
		loading_context.show_splash_screens = true
		loading_context.load_changelog = false
		Boot.loading_context = loading_context

		return StateSplashScreen
	elseif GameSettingsDevelopment.start_state == "fly_through" or flythrough_command_line then
		Managers.package:load("resource_packages/menu")
		Managers.package:load("resource_packages/ingame")
		Managers.package:load("resource_packages/weapons")

		Boot.loading_context = {}
		Boot.loading_context.level_key = "village_02"
		Boot.loading_context.game_mode_key = "fly_through"
		Boot.loading_context.win_score = GameSettingsDevelopment.default_win_score
		Boot.loading_context.time_limit = GameSettingsDevelopment.default_time_limit
		Boot.loading_context.number_players = GameSettingsDevelopment.quicklaunch_params.number_players

		return StateLoading
	elseif GameSettingsDevelopment.start_state == "gpu_prof" then
		Managers.package:load("resource_packages/menu")
		Managers.package:load("resource_packages/ingame")
		Managers.package:load("resource_packages/weapons")

		Boot.loading_context = {}
		Boot.loading_context.level_key = "village_02"
		Boot.loading_context.game_mode_key = "gpu_prof"
		Boot.loading_context.win_score = GameSettingsDevelopment.default_win_score
		Boot.loading_context.time_limit = GameSettingsDevelopment.default_time_limit
		Boot.loading_context.number_players = GameSettingsDevelopment.quicklaunch_params.number_players

		return StateLoading
	elseif GameSettingsDevelopment.start_state == "game" then
		Managers.package:load("resource_packages/menu")
		Managers.package:load("resource_packages/ingame")
		Managers.package:load("resource_packages/weapons")

		local level_key = GameSettingsDevelopment.quicklaunch_params.level_key
		local game_mode_key = GameSettingsDevelopment.quicklaunch_params.game_mode_key

		Boot.loading_context = {}
		Boot.loading_context.level_key = level_key
		Boot.loading_context.game_mode_key = game_mode_key
		Boot.loading_context.win_score = GameSettingsDevelopment.default_win_score
		Boot.loading_context.time_limit = GameSettingsDevelopment.default_time_limit
		Boot.loading_context.number_players = GameSettingsDevelopment.quicklaunch_params.number_players

		return StateLoading
	elseif application_settings.dedicated_server then
		Managers.package:load("resource_packages/menu")
		Managers.package:load("resource_packages/ingame")
		Managers.package:load("resource_packages/weapons")

		return StateDedicatedServerInit
	elseif application_settings.auto_join_server_name then
		Managers.package:load("resource_packages/menu")
		Managers.package:load("resource_packages/ingame")
		Managers.package:load("resource_packages/weapons")

		return StateAutomaticDedicatedServerJoin
	elseif GameSettingsDevelopment.start_state == "menu" then
		Boot.loading_context = {}
		Boot.loading_context.show_splash_screens = true
		Boot.loading_context.load_changelog = true

		return StateSplashScreen
	elseif GameSettingsDevelopment.start_state == "cpu_prof" then
		Managers.package:load("resource_packages/menu")
		Managers.package:load("resource_packages/ingame")
		Managers.package:load("resource_packages/weapons")

		Boot.loading_context = {}
		Boot.loading_context.level_key = "village_02"
		Boot.loading_context.game_mode_key = "cpu_prof"
		Boot.loading_context.win_score = GameSettingsDevelopment.default_win_score
		Boot.loading_context.time_limit = GameSettingsDevelopment.default_time_limit
		Boot.loading_context.number_players = GameSettingsDevelopment.quicklaunch_params.number_players

		return StateLoading
	end

	return StateSplashScreen
end

script_data = script_data or {}
