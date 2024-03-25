-- chunkname: @scripts/menu/menu_definitions/main_menu_settings_low.lua

MainMenuSettings.pages.level_2_character_profiles = MainMenuSettings.pages.level_2_character_profiles or {}
MainMenuSettings.pages.level_2_character_profiles[1] = MainMenuSettings.pages.level_2_character_profiles[1] or {}
MainMenuSettings.pages.level_2_character_profiles[1][1] = MainMenuSettings.pages.level_2_character_profiles[1][1] or table.clone(MainMenuSettings.pages.level_2_character_profiles[1366][768])
MainMenuSettings.pages.level_2_character_profiles[1][1].xp_progress_bar.pivot_offset_x = function(res_w, res_h)
	return res_w < 1366 and res_h < 720 and -140 or 0
end
