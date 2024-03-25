-- chunkname: @scripts/menu/menu_callbacks/main_menu_callbacks.lua

MainMenuCallbacks = class(MainMenuCallbacks)

function MainMenuCallbacks:init(menu_state)
	self._menu_state = menu_state
end

function MainMenuCallbacks:cb_exit_game()
	self._menu_state:exit_game()
end

function MainMenuCallbacks:cb_is_not_demo()
	return not IS_DEMO
end

function MainMenuCallbacks:cb_single_player_start()
	self._menu_state:single_player_start(self._selected_single_player_level)
end

function MainMenuCallbacks:cb_start_single_player_game_disabled()
	if script_data.sp_level_unlock then
		return false
	end

	return not (PlayerData.sp_level_progression_id >= LevelSettings[self._selected_single_player_level].sp_requirement_id)
end

function MainMenuCallbacks:cb_on_enter_single_player_ddl_text()
	local levels = MenuHelper.single_player_levels_sorted()
	local saved_level_key = Application.win32_user_setting("single_player_level")
	local level_key = saved_level_key or levels[1].level_key
	local description_text = L("main_menu_level") .. ": "
	local value_text = L(LevelSettings[level_key].display_name)

	self._selected_single_player_level = level_key

	return description_text, value_text
end

function MainMenuCallbacks:cb_single_player_ddl_options()
	local levels = MenuHelper.single_player_levels_sorted()
	local saved_level_key = Application.win32_user_setting("single_player_level")
	local selected_index = 1
	local options = {}

	for i, config in ipairs(levels) do
		options[#options + 1] = {
			key = config.level_key,
			value = L(LevelSettings[config.level_key].display_name)
		}

		if saved_level_key and saved_level_key == config.level_key then
			selected_index = i
		end
	end

	self._selected_single_player_level = options[selected_index].key

	return options, selected_index
end

function MainMenuCallbacks:cb_single_player_ddl_option_changed(option)
	Application.set_win32_user_setting("single_player_level", option.key)
	Application.save_win32_user_settings()

	self._selected_single_player_level = option.key
end

function MainMenuCallbacks:cb_show_hud_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = HUDSettings.show_hud and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_show_hud_option_changed(option)
	Application.set_win32_user_setting("show_hud", option.key)
	Application.save_win32_user_settings()

	HUDSettings.show_hud = option.key
end

function MainMenuCallbacks:cb_show_reticule_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = HUDSettings.show_reticule and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_show_reticule_option_changed(option)
	Application.set_win32_user_setting("show_reticule", option.key)
	Application.save_win32_user_settings()

	HUDSettings.show_reticule = option.key
end

function MainMenuCallbacks:cb_show_damage_numbers_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = HUDSettings.show_damage_numbers and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_show_damage_numbers_option_changed(option)
	Application.set_win32_user_setting("show_damage_numbers", option.key)
	Application.save_win32_user_settings()

	HUDSettings.show_damage_numbers = option.key
end

function MainMenuCallbacks:cb_show_xp_awards()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = HUDSettings.show_xp_awards and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_show_xp_awards_option_changed(option)
	Application.set_user_setting("show_xp_awards", option.key)
	Application.save_user_settings()

	HUDSettings.show_xp_awards = option.key
end

function MainMenuCallbacks:cb_show_parry_helper()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = HUDSettings.show_parry_helper and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_show_parry_helper_option_changed(option)
	Application.set_user_setting("show_parry_helper", option.key)
	Application.save_user_settings()

	HUDSettings.show_parry_helper = option.key
end

function MainMenuCallbacks:cb_show_pose_charge_helper()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = HUDSettings.show_pose_charge_helper and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_show_pose_charge_helper_option_changed(option)
	Application.set_user_setting("show_pose_charge_helper", option.key)
	Application.save_user_settings()

	HUDSettings.show_pose_charge_helper = option.key
end

function MainMenuCallbacks:cb_show_announcements()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = HUDSettings.show_announcements and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_show_announcements_option_changed(option)
	Application.set_user_setting("show_announcements", option.key)
	Application.save_user_settings()

	HUDSettings.show_announcements = option.key
end

function MainMenuCallbacks:cb_invert_pose_control_x_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = PlayerUnitMovementSettings.swing.invert_pose_control_x and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_invert_pose_control_x_option_changed(option)
	Application.set_win32_user_setting("invert_pose_control_x", option.key)
	Application.save_win32_user_settings()

	PlayerUnitMovementSettings.swing.invert_pose_control_x = option.key
end

function MainMenuCallbacks:cb_invert_pose_control_y_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = PlayerUnitMovementSettings.swing.invert_pose_control_y and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_invert_pose_control_y_option_changed(option)
	Application.set_win32_user_setting("invert_pose_control_y", option.key)
	Application.save_win32_user_settings()

	PlayerUnitMovementSettings.swing.invert_pose_control_y = option.key
end

function MainMenuCallbacks:cb_invert_parry_control_x_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = PlayerUnitMovementSettings.parry.invert_parry_control_x and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_invert_parry_control_x_option_changed(option)
	Application.set_win32_user_setting("invert_parry_control_x", option.key)
	Application.save_win32_user_settings()

	PlayerUnitMovementSettings.parry.invert_parry_control_x = option.key
end

function MainMenuCallbacks:cb_invert_parry_control_y_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = PlayerUnitMovementSettings.parry.invert_parry_control_y and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_invert_parry_control_y_option_changed(option)
	Application.set_win32_user_setting("invert_parry_control_y", option.key)
	Application.save_win32_user_settings()

	PlayerUnitMovementSettings.parry.invert_parry_control_y = option.key
end

function MainMenuCallbacks:_set_sensitivity_options(option_name)
	local negative_step = 0.85
	local positive_step = 1.1764705882352942
	local negative_steps = 10
	local positive_steps = 10
	local options = {
		{
			value = 0,
			key = 1
		}
	}
	local sensitivity = ActivePlayerControllerSettings[option_name]
	local selected_index = negative_steps + 1
	local error = math.abs(sensitivity - 1)

	for i = 1, positive_steps do
		local key = options[#options].key * positive_step
		local difference = math.abs(sensitivity - key)

		if difference < error then
			selected_index = negative_steps + #options + 1
			error = difference
		end

		options[#options + 1] = {
			value = i,
			key = key
		}
	end

	for i = -1, -negative_steps, -1 do
		local key = options[1].key * negative_step
		local difference = math.abs(sensitivity - key)

		if difference < error then
			selected_index = negative_steps + i + 1
			error = difference
		end

		table.insert(options, 1, {
			value = i,
			key = key
		})
	end

	return options, selected_index
end

function MainMenuCallbacks:cb_mouse_sensitivity_options()
	local options, selected_index = self:_set_sensitivity_options("sensitivity")

	return options, selected_index
end

function MainMenuCallbacks:cb_mouse_sensitivity_option_changed(option)
	Application.set_win32_user_setting("mouse_sensitivity", option.key)
	Application.save_win32_user_settings()

	ActivePlayerControllerSettings.sensitivity = option.key
end

function MainMenuCallbacks:cb_pad_sensitivity_x_options()
	local options, selected_index = self:_set_sensitivity_options("pad_sensitivity_x")

	return options, selected_index
end

function MainMenuCallbacks:cb_pad_sensitivity_x_option_changed(option)
	Application.set_win32_user_setting("pad_sensitivity_x", option.key)
	Application.save_win32_user_settings()

	ActivePlayerControllerSettings.pad_sensitivity_x = option.key
end

function MainMenuCallbacks:cb_pad_sensitivity_y_options()
	local options, selected_index = self:_set_sensitivity_options("pad_sensitivity_y")

	return options, selected_index
end

function MainMenuCallbacks:cb_pad_sensitivity_y_option_changed(option)
	Application.set_win32_user_setting("pad_sensitivity_y", option.key)
	Application.save_win32_user_settings()

	ActivePlayerControllerSettings.pad_sensitivity_y = option.key
end

function MainMenuCallbacks:cb_keyboard_parry_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = PlayerUnitMovementSettings.parry.keyboard_controlled and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_keyboard_parry_option_changed(option)
	Application.set_win32_user_setting("keyboard_parry", option.key)
	Application.save_win32_user_settings()

	PlayerUnitMovementSettings.parry.keyboard_controlled = option.key
end

function MainMenuCallbacks:cb_keyboard_pose_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = PlayerUnitMovementSettings.swing.keyboard_controlled and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_keyboard_pose_option_changed(option)
	Application.set_win32_user_setting("keyboard_pose", option.key)
	Application.save_win32_user_settings()

	PlayerUnitMovementSettings.swing.keyboard_controlled = option.key
end

function MainMenuCallbacks:cb_cancel_to(page_id)
	self._menu_state:menu_cancel_to(page_id)
end

function MainMenuCallbacks:cb_master_volumes()
	local options, index = SoundHelper.sound_volume_options("master_volume")

	return options, index
end

function MainMenuCallbacks:cb_master_volume_changed(option)
	Application.set_win32_user_setting("master_volume", option.key)
	Application.save_win32_user_settings()
	Timpani.set_bus_volume("Master Bus", option.key)
end

function MainMenuCallbacks:cb_voice_over_volume_changed(option)
	Application.set_win32_user_setting("voice_over", option.key)
	Application.save_win32_user_settings()
	Timpani.set_bus_volume("voice_over", option.key)
end

function MainMenuCallbacks:cb_voice_over_volumes()
	local options, index = SoundHelper.sound_volume_options("voice_over")

	return options, index
end

function MainMenuCallbacks:cb_voice_overs()
	local options = {
		{
			key = "normal",
			value = L("main_menu_voice_over_normal")
		}
	}

	if DLCSettings.brian_blessed() then
		options[#options + 1] = {
			key = "brian_blessed",
			value = L("main_menu_voice_over_brian_blessed")
		}
	end

	return options, HUDSettings.announcement_voice_over == "normal" and 1 or 2
end

function MainMenuCallbacks:cb_voice_over_changed(option)
	HUDSettings.announcement_voice_over = option.key

	Application.set_user_setting("announcement_voice_over", option.key)
	Application.save_user_settings()
end

function MainMenuCallbacks:cb_music_volumes()
	local options, index = SoundHelper.sound_volume_options("music_volume")

	return options, index
end

function MainMenuCallbacks:cb_music_volume_changed(option)
	Application.set_win32_user_setting("music_volume", option.key)
	Application.save_win32_user_settings()
	Timpani.set_bus_volume("music", option.key)
end

function MainMenuCallbacks:cb_sfx_volumes()
	local options, index = SoundHelper.sound_volume_options("sfx_volume")

	return options, index
end

function MainMenuCallbacks:cb_sfx_volume_changed(option)
	Application.set_win32_user_setting("sfx_volume", option.key)
	Application.save_win32_user_settings()
	Timpani.set_bus_volume("sfx", option.key)
	Timpani.set_bus_volume("special", option.key)
end

function MainMenuCallbacks:cb_steam_server_browser_disabled()
	return GameSettingsDevelopment.network_mode ~= "steam"
end

function MainMenuCallbacks:cb_look_invert_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = ActivePlayerControllerSettings.keyboard_mouse.look.type == "FilterAxisScale" and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_look_invert_changed(option)
	local invert = option.key

	ActivePlayerControllerSettings.keyboard_mouse.look.type = invert and "FilterAxisScale" or "FilterInvertAxisY"
	ActivePlayerControllerSettings.keyboard_mouse.look_aiming.type = invert and "FilterAxisScale" or "FilterInvertAxisY"
	SaveData.controls = table.clone(ActivePlayerControllerSettings)

	Managers.save:auto_save(SaveFileName, SaveData)

	if Managers.player:player_exists(1) then
		local player = Managers.player:player(1)

		Managers.input:unmap_input_source(player.input_source)

		local input_source = Managers.input:map_slot(player.input_slot, ActivePlayerControllerSettings, nil)

		player.input_source = input_source
	end
end

function MainMenuCallbacks:cb_look_invert_options_pad360()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = ActivePlayerControllerSettings.pad360.look.type == "FilterAxisScaleRampInvertedYDt" and 1 or 2

	return options, selected_index
end

function MainMenuCallbacks:cb_look_invert_changed_pad360(option)
	local invert = option.key
	local pad_active = Managers.input:pad_active(1)

	assert(pad_active)

	ActivePlayerControllerSettings.pad360.look.type = invert and "FilterAxisScaleRampInvertedYDt" or "FilterAxisScaleRampDt"
	ActivePlayerControllerSettings.pad360.look_aiming.type = invert and "FilterAxisScaleRampInvertedYDt" or "FilterAxisScaleRampDt"
	SaveData.controls = table.clone(ActivePlayerControllerSettings)

	Managers.save:auto_save(SaveFileName, SaveData)

	if Managers.player:player_exists(1) then
		local player = Managers.player:player(1)

		Managers.input:unmap_input_source(player.input_source)

		local input_source = Managers.input:map_slot(player.input_slot, ActivePlayerControllerSettings, nil)

		player.input_source = input_source
	end
end

function MainMenuCallbacks:cb_disable_controller_options()
	local options = {
		{
			key = true,
			value = L("main_menu_yes")
		},
		{
			key = false,
			value = L("main_menu_no")
		}
	}
	local selected_index = ActivePlayerControllerSettings.disable_controller == false and 2 or 1

	return options, selected_index
end

function MainMenuCallbacks:cb_disable_controller_changed(option)
	local disable_controller = option.key

	ActivePlayerControllerSettings.disable_controller = disable_controller
	SaveData.controls = table.clone(ActivePlayerControllerSettings)

	Managers.save:auto_save(SaveFileName, SaveData)
end

function MainMenuCallbacks:cb_profile_viewer_world_name()
	return "menu_level_world"
end

function MainMenuCallbacks:cb_profile_viewer_viewport_name()
	return "menu_level_viewport"
end

function MainMenuCallbacks:cb_alignment_dummy_units()
	return self._menu_state.parent.alignment_dummy_units
end

function MainMenuCallbacks:cb_open_link(url)
	if url then
		Application.open_url_in_browser(url)
		Window.minimize()
	end
end

function MainMenuCallbacks:cb_controller_enabled()
	return Managers.input:pad_active(1)
end

function MainMenuCallbacks:cb_controller_disabled()
	return not Managers.input:pad_active(1)
end
