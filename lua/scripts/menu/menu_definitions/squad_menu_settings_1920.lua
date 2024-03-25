-- chunkname: @scripts/menu/menu_definitions/squad_menu_settings_1920.lua

require("scripts/menu/menu_definitions/final_scoreboard_menu_settings_1920")

SquadMenuSettings = SquadMenuSettings or {}
SquadMenuSettings.items = SquadMenuSettings.items or {}
SquadMenuSettings.pages = SquadMenuSettings.pages or {}
SquadMenuSettings.items.pulse_text_right_aligned = SquadMenuSettings.items.pulse_text_right_aligned or {}
SquadMenuSettings.items.pulse_text_right_aligned[1680] = SquadMenuSettings.items.pulse_text_right_aligned[1680] or {}
SquadMenuSettings.items.pulse_text_right_aligned[1680][1050] = SquadMenuSettings.items.pulse_text_right_aligned[1680][1050] or table.clone(MainMenuSettings.items.text_right_aligned[1680][1050])
SquadMenuSettings.items.pulse_text_right_aligned[1680][1050].pulse_speed = 5
SquadMenuSettings.items.pulse_text_right_aligned[1680][1050].pulse_alpha_min = 20
SquadMenuSettings.items.pulse_text_right_aligned[1680][1050].pulse_alpha_max = 255
SquadMenuSettings.items.spawn_map = SquadMenuSettings.items.spawn_map or {}
SquadMenuSettings.items.spawn_map[1680] = SquadMenuSettings.items.spawn_map[1680] or {}
SquadMenuSettings.items.spawn_map[1680][1050] = SquadMenuSettings.items.spawn_map[1680][1050] or {
	width = 512,
	height = 512,
	color = {
		255,
		64,
		128,
		255
	}
}
SquadMenuSettings.items.local_player_marker = SquadMenuSettings.items.local_player_marker or {}
SquadMenuSettings.items.local_player_marker[1680] = SquadMenuSettings.items.local_player_marker[1680] or {}
SquadMenuSettings.items.local_player_marker[1680][1050] = SquadMenuSettings.items.local_player_marker[1680][1050] or {
	texture = "map_icon_local_player",
	texture_height = 12,
	texture_width = 12
}
SquadMenuSettings.items.spawn_area_marker = SquadMenuSettings.items.spawn_area_marker or {}
SquadMenuSettings.items.spawn_area_marker[1680] = SquadMenuSettings.items.spawn_area_marker[1680] or {}
SquadMenuSettings.items.spawn_area_marker[1680][1050] = SquadMenuSettings.items.spawn_area_marker[1680][1050] or {
	spawn_target_texture = "map_icon_spawn_target",
	spawn_area_texture_width = 40,
	spawn_area_texture_highlighted = "map_icon_spawn_area_highlighted",
	spawn_target_texture_height = 40,
	spawn_area_texture_height = 40,
	spawn_target_anim_speed = 1.5,
	spawn_target_texture_width = 40,
	spawn_target_offset_y = 14,
	spawn_target_anim_amplitude = 8,
	spawn_area_texture = "map_icon_spawn_area"
}
SquadMenuSettings.items.squad_marker = SquadMenuSettings.items.squad_marker or {}
SquadMenuSettings.items.squad_marker[1680] = SquadMenuSettings.items.squad_marker[1680] or {}
SquadMenuSettings.items.squad_marker[1680][1050] = SquadMenuSettings.items.squad_marker[1680][1050] or {
	spawn_target_texture_width = 40,
	spawn_target_texture = "map_icon_spawn_target",
	spawn_target_offset_y = 20,
	squad_textures_height = 28,
	spawn_target_texture_height = 40,
	squad_textures_width = 28,
	spawn_target_anim_amplitude = 8,
	spawn_target_anim_speed = 1.5,
	squad_member = {
		texture = "map_icon_squad_member",
		texture_highlighted = "map_icon_squad_member_highlighted",
		texture_disabled = "map_icon_squad_member_disabled"
	},
	squad_corporal = {
		texture = "map_icon_squad_corporal",
		texture_highlighted = "map_icon_squad_corporal_highlighted",
		texture_disabled = "map_icon_squad_corporal_disabled"
	}
}
SquadMenuSettings.items.squad_header = SquadMenuSettings.items.squad_header or {}
SquadMenuSettings.items.squad_header[1680] = SquadMenuSettings.items.squad_header[1680] or {}
SquadMenuSettings.items.squad_header[1680][1050] = SquadMenuSettings.items.squad_header[1680][1050] or {
	texture_alignment = "right",
	texture_disabled = "selected_item_bgr_right_1920",
	padding_left = 0,
	font_size = 32,
	padding_top = 14,
	texture_disabled_width = 652,
	padding_bottom = 14,
	line_height = 21,
	texture_disabled_height = 36,
	padding_right = 20,
	font = MenuSettings.fonts.hell_shark_32,
	color = {
		255,
		255,
		255,
		255
	},
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	}
}
SquadMenuSettings.items.squad_info_text = SquadMenuSettings.items.squad_info_text or {}
SquadMenuSettings.items.squad_info_text[1680] = SquadMenuSettings.items.squad_info_text[1680] or {}
SquadMenuSettings.items.squad_info_text[1680][1050] = SquadMenuSettings.items.squad_info_text[1680][1050] or {
	column_1_offset_x = 80,
	joined_texture_height = 24,
	joined_text_offset_x = 10,
	text_offset_y = 8,
	joined_texture = "assigned_background_1920",
	padding_top = 14,
	column_2_offset_x = 420,
	padding_bottom = 14,
	line_height = 21,
	texture_width = 652,
	joined_text_offset_y = 6,
	texture_height = 36,
	texture = "header_item_bgr_right_1920",
	joined_font_size = 20,
	font_size = 32,
	joined_texture_width = 172,
	width = 540,
	font = MenuSettings.fonts.hell_shark_32,
	color = {
		255,
		0,
		0,
		0
	},
	color_highlighted = {
		255,
		0,
		0,
		0
	},
	color_joined = {
		255,
		0,
		0,
		0
	},
	texture_color = {
		255,
		215,
		215,
		215
	},
	texture_color_highlighted = {
		255,
		255,
		255,
		255
	},
	texture_color_joined = {
		255,
		255,
		255,
		255
	},
	joined_text_color = {
		255,
		255,
		255,
		255
	}
}
SquadMenuSettings.items.squad_join_button = SquadMenuSettings.items.squad_join_button or {}
SquadMenuSettings.items.squad_join_button[1680] = SquadMenuSettings.items.squad_join_button[1680] or {}
SquadMenuSettings.items.squad_join_button[1680][1050] = SquadMenuSettings.items.squad_join_button[1680][1050] or {
	text_padding = 4,
	texture_right_width = 8,
	texture_left = "small_button_left_1920",
	text_offset_y = 8,
	font_size = 26,
	texture_middle = "small_button_center_1920",
	texture_right = "small_button_right_1920",
	padding_bottom = 13,
	texture_middle_highlighted = "small_button_center_highlighted_1920",
	texture_right_highlighted = "small_button_right_highlighted_1920",
	padding_top = 19,
	texture_left_width = 8,
	texture_left_highlighted = "small_button_left_highlighted_1920",
	padding_left = 20,
	padding_right = 0,
	texture_height = 32,
	font = MenuSettings.fonts.hell_shark_26,
	text_color = {
		255,
		0,
		0,
		0
	},
	text_color_highlighted = {
		255,
		255,
		255,
		255
	},
	text_color_disabled = {
		255,
		150,
		150,
		150
	},
	drop_shadow_color_highlighted = {
		255,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	texture_color = {
		255,
		255,
		255,
		255
	},
	texture_color_disabled = {
		100,
		0,
		0,
		0
	}
}
SquadMenuSettings.items.page_link = SquadMenuSettings.items.page_link or {}
SquadMenuSettings.items.page_link[1680] = SquadMenuSettings.items.page_link[1680] or {}
SquadMenuSettings.items.page_link[1680][1050] = SquadMenuSettings.items.page_link[1680][1050] or {
	texture = "header_item_bgr_right_1920",
	texture_highlighted = "header_item_bgr_right_1920",
	texture_highlighted_height = 36,
	texture_highlighted_width = 652,
	font_size = 32,
	padding_top = 12,
	texture_disabled = "header_item_bgr_right_1920",
	padding_bottom = 12,
	line_height = 21,
	texture_disabled_height = 36,
	texture_disabled_width = 652,
	texture_width = 652,
	texture_alignment = "right",
	padding_left = 0,
	padding_right = 20,
	texture_height = 36,
	font = MenuSettings.fonts.hell_shark_32,
	color = {
		255,
		0,
		0,
		0
	},
	color_highlighted = {
		255,
		0,
		0,
		0
	},
	color_disabled = {
		0,
		110,
		110,
		110
	},
	texture_color = {
		255,
		215,
		215,
		215
	},
	texture_highlighted_color = {
		255,
		255,
		255,
		255
	},
	texture_disabled_color = {
		0,
		215,
		215,
		215
	}
}
SquadMenuSettings.items.next_button = SquadMenuSettings.items.next_button or {}
SquadMenuSettings.items.next_button[1680] = SquadMenuSettings.items.next_button[1680] or {}
SquadMenuSettings.items.next_button[1680][1050] = SquadMenuSettings.items.next_button[1680][1050] or {
	text_padding = 0,
	texture_right_width = 32,
	texture_left = "shiny_button_left_end_1920",
	text_offset_y = 22,
	font_size = 26,
	texture_middle = "shiny_button_center_1920",
	texture_right = "shiny_button_right_tip_1920",
	padding_bottom = 0,
	texture_middle_highlighted = "shiny_button_center_highlighted_1920",
	texture_right_highlighted = "shiny_button_right_tip_highlighted_1920",
	padding_top = 0,
	texture_left_width = 24,
	texture_left_highlighted = "shiny_button_left_end_highlighted_1920",
	padding_left = 20,
	padding_right = 20,
	texture_height = 60,
	font = MenuSettings.fonts.hell_shark_26,
	text_color = {
		255,
		0,
		0,
		0
	},
	text_color_highlighted = {
		255,
		255,
		255,
		255
	},
	text_color_disabled = {
		255,
		40,
		40,
		40
	},
	drop_shadow_color_highlighted = {
		255,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	texture_color = {
		255,
		255,
		255,
		255
	},
	texture_color_disabled = {
		100,
		0,
		0,
		0
	}
}
SquadMenuSettings.items.previous_button = SquadMenuSettings.items.previous_button or {}
SquadMenuSettings.items.previous_button[1680] = SquadMenuSettings.items.previous_button[1680] or {}
SquadMenuSettings.items.previous_button[1680][1050] = SquadMenuSettings.items.previous_button[1680][1050] or {
	text_padding = 0,
	texture_right_width = 24,
	texture_left = "shiny_button_left_tip_1920",
	text_offset_y = 22,
	font_size = 26,
	texture_middle = "shiny_button_center_1920",
	texture_right = "shiny_button_right_end_1920",
	padding_bottom = 0,
	texture_middle_highlighted = "shiny_button_center_highlighted_1920",
	texture_right_highlighted = "shiny_button_right_end_highlighted_1920",
	padding_top = 0,
	texture_left_width = 32,
	texture_left_highlighted = "shiny_button_left_tip_highlighted_1920",
	padding_left = 20,
	padding_right = 20,
	texture_height = 60,
	font = MenuSettings.fonts.hell_shark_26,
	text_color = {
		255,
		0,
		0,
		0
	},
	text_color_highlighted = {
		255,
		255,
		255,
		255
	},
	text_color_disabled = {
		255,
		40,
		40,
		40
	},
	drop_shadow_color_highlighted = {
		255,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	texture_color = {
		255,
		255,
		255,
		255
	},
	texture_color_disabled = {
		100,
		0,
		0,
		0
	}
}
SquadMenuSettings.items.centered_button = SquadMenuSettings.items.centered_button or {}
SquadMenuSettings.items.centered_button[1680] = SquadMenuSettings.items.centered_button[1680] or {}
SquadMenuSettings.items.centered_button[1680][1050] = SquadMenuSettings.items.centered_button[1680][1050] or {
	text_padding = 0,
	texture_right_width = 24,
	texture_left = "shiny_button_left_end_1920",
	text_offset_y = 22,
	font_size = 26,
	texture_middle = "shiny_button_center_1920",
	texture_right = "shiny_button_right_end_1920",
	padding_bottom = 0,
	texture_middle_highlighted = "shiny_button_center_highlighted_1920",
	texture_right_highlighted = "shiny_button_right_end_highlighted_1920",
	padding_top = 0,
	texture_left_width = 24,
	texture_left_highlighted = "shiny_button_left_end_highlighted_1920",
	padding_left = 20,
	padding_right = 20,
	texture_height = 60,
	font = MenuSettings.fonts.hell_shark_26,
	text_color = {
		255,
		0,
		0,
		0
	},
	text_color_highlighted = {
		255,
		255,
		255,
		255
	},
	text_color_disabled = {
		255,
		110,
		110,
		110
	},
	drop_shadow_color_highlighted = {
		255,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	texture_color = {
		255,
		255,
		255,
		255
	},
	texture_color_disabled = {
		100,
		0,
		0,
		0
	}
}
SquadMenuSettings.items.character_selection_text = SquadMenuSettings.items.character_selection_text or {}
SquadMenuSettings.items.character_selection_text[1680] = SquadMenuSettings.items.character_selection_text[1680] or {}
SquadMenuSettings.items.character_selection_text[1680][1050] = SquadMenuSettings.items.character_selection_text[1680][1050] or {
	texture_unavalible_offset_y = 1,
	texture_unavalible_rank_not_met = "locked_xp_1920",
	texture_highlighted_height = 36,
	texture_unavalible_offset_x = -360,
	texture_highlighted = "selected_item_bgr_right_1920",
	padding_top = 7,
	texture_alignment = "right",
	padding_bottom = 7,
	line_height = 21,
	padding_left = 0,
	texture_unavalible_height = 32,
	texture_unavalible_not_owned = "locked_money_1920",
	padding_right = 20,
	texture_unavalible_perk_required = "locked_perk_1920",
	texture_unavalible_align = "right",
	font_size = 32,
	texture_unavalible_width = 64,
	texture_highlighted_width = 652,
	font = MenuSettings.fonts.hell_shark_32,
	color = {
		255,
		155,
		155,
		155
	},
	color_highlighted = {
		255,
		255,
		255,
		255
	},
	color_selected = {
		255,
		255,
		255,
		255
	},
	color_disabled = {
		255,
		100,
		100,
		100
	},
	color_render_from_child_page = {
		80,
		255,
		255,
		255
	},
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	}
}
SquadMenuSettings.items.quote_text = SquadMenuSettings.items.quote_text or {}
SquadMenuSettings.items.quote_text[1680] = SquadMenuSettings.items.quote_text[1680] or {}
SquadMenuSettings.items.quote_text[1680][1050] = SquadMenuSettings.items.quote_text[1680][1050] or {
	line_height = 32,
	width = 440,
	padding_left = 0,
	padding_right = 0,
	font_size = 22,
	padding_top = 40,
	text_align = "left",
	padding_bottom = 40,
	font = MenuSettings.fonts.hell_shark_22,
	color = {
		255,
		255,
		255,
		255
	},
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	}
}
SquadMenuSettings.items.red_team_rose = SquadMenuSettings.items.red_team_rose or {}
SquadMenuSettings.items.red_team_rose[1680] = SquadMenuSettings.items.red_team_rose[1680] or {}
SquadMenuSettings.items.red_team_rose[1680][1050] = SquadMenuSettings.items.red_team_rose[1680][1050] or {
	texture_width = 444,
	texture_highlighted = "team_selection_highlighted_1920",
	texture_highlighted_height = 532,
	texture_disabled_width = 184,
	padding_top = 0,
	padding_bottom = 0,
	texture_highlighted_offset_y = -22,
	texture_disabled_height = 184,
	texture_disabled_offset_y = 150,
	padding_right = 0,
	texture_height = 488,
	texture = "big_rose_red",
	texture_disabled_offset_z = 2,
	texture_highlighted_offset_x = -44,
	padding_left = 0,
	texture_disabled_offset_x = 136,
	texture_disabled = "team_selection_disabled_1920",
	texture_highlighted_offset_z = 0,
	texture_highlighted_width = 532,
	color_disabled = {
		150,
		100,
		100,
		100
	}
}
SquadMenuSettings.items.white_team_rose = SquadMenuSettings.items.white_team_rose or {}
SquadMenuSettings.items.white_team_rose[1680] = SquadMenuSettings.items.white_team_rose[1680] or {}
SquadMenuSettings.items.white_team_rose[1680][1050] = SquadMenuSettings.items.white_team_rose[1680][1050] or {
	texture_width = 444,
	texture_highlighted = "team_selection_highlighted_1920",
	texture_highlighted_height = 532,
	texture_disabled_width = 184,
	padding_top = 0,
	padding_bottom = 0,
	texture_highlighted_offset_y = -22,
	texture_disabled_height = 184,
	texture_disabled_offset_y = 156,
	padding_right = 0,
	texture_height = 488,
	texture = "big_rose_white",
	texture_disabled_offset_z = 2,
	texture_highlighted_offset_x = -44,
	padding_left = 0,
	texture_disabled_offset_x = 140,
	texture_disabled = "team_selection_disabled_1920",
	texture_highlighted_offset_z = 0,
	texture_highlighted_width = 532,
	color_disabled = {
		150,
		100,
		100,
		100
	}
}
SquadMenuSettings.items.red_team_text = SquadMenuSettings.items.red_team_text or {}
SquadMenuSettings.items.red_team_text[1680] = SquadMenuSettings.items.red_team_text[1680] or {}
SquadMenuSettings.items.red_team_text[1680][1050] = SquadMenuSettings.items.red_team_text[1680][1050] or {
	texture = "selected_item_bgr_right_1920",
	texture_disabled_width = 652,
	texture_alignment = "center",
	texture_offset_x = -66,
	font_size = 32,
	padding_top = 40,
	texture_disabled = "selected_item_bgr_right_1920",
	padding_bottom = 40,
	line_height = 21,
	texture_disabled_height = 36,
	padding_left = 0,
	texture_width = 652,
	padding_right = 0,
	texture_height = 36,
	font = MenuSettings.fonts.hell_shark_32,
	color = HUDSettings.player_colors.red_team,
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	}
}
SquadMenuSettings.items.white_team_text = SquadMenuSettings.items.white_team_text or {}
SquadMenuSettings.items.white_team_text[1680] = SquadMenuSettings.items.white_team_text[1680] or {}
SquadMenuSettings.items.white_team_text[1680][1050] = SquadMenuSettings.items.white_team_text[1680][1050] or {
	texture = "selected_item_bgr_left_1920",
	texture_disabled_width = 652,
	texture_alignment = "center",
	texture_offset_x = 66,
	font_size = 32,
	padding_top = 40,
	texture_disabled = "selected_item_bgr_left_1920",
	padding_bottom = 40,
	line_height = 21,
	texture_disabled_height = 36,
	padding_left = 0,
	texture_width = 652,
	padding_right = 0,
	texture_height = 36,
	font = MenuSettings.fonts.hell_shark_32,
	color = HUDSettings.player_colors.white_team,
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	}
}
SquadMenuSettings.items.red_team_num_players = SquadMenuSettings.items.red_team_num_players or {}
SquadMenuSettings.items.red_team_num_players[1680] = SquadMenuSettings.items.red_team_num_players[1680] or {}
SquadMenuSettings.items.red_team_num_players[1680][1050] = SquadMenuSettings.items.red_team_num_players[1680][1050] or {
	line_height = 21,
	padding_left = 0,
	font_size = 32,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_32,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	}
}
SquadMenuSettings.items.white_team_num_players = SquadMenuSettings.items.white_team_num_players or {}
SquadMenuSettings.items.white_team_num_players[1680] = SquadMenuSettings.items.white_team_num_players[1680] or {}
SquadMenuSettings.items.white_team_num_players[1680][1050] = SquadMenuSettings.items.white_team_num_players[1680][1050] or {
	line_height = 21,
	padding_left = 0,
	font_size = 32,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_32,
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	color_disabled = {
		255,
		255,
		255,
		255
	}
}
SquadMenuSettings.pages.select_team = SquadMenuSettings.pages.select_team or {}
SquadMenuSettings.pages.select_team[1680] = SquadMenuSettings.pages.select_team[1680] or {}
SquadMenuSettings.pages.select_team[1680][1050] = SquadMenuSettings.pages.select_team[1680][1050] or table.clone(FinalScoreboardMenuSettings.pages.main_page[1680][1050])
SquadMenuSettings.pages.select_team[1680][1050].center_items.pivot_offset_y = 0
SquadMenuSettings.pages.select_team[1680][1050].back_list = table.clone(MainMenuSettings.pages.level_2[1680][1050].back_list)
SquadMenuSettings.pages.select_team[1680][1050].back_list.number_of_columns = 2
SquadMenuSettings.pages.select_team[1680][1050].page_links = {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	pivot_offset_y = 30,
	screen_align_x = "right",
	number_of_columns = 2,
	pivot_offset_x = -40,
	screen_offset_y = 0,
	pivot_align_x = "right",
	column_alignment = {
		"right"
	}
}
SquadMenuSettings.pages.select_team[1680][1050].button_info = {
	text_data = {
		font_size = 28,
		font = MenuSettings.fonts.hell_shark_28,
		offset_x = 25 * SCALE_1366,
		offset_y = 100 * SCALE_1366,
		drop_shadow = {
			2,
			-2
		}
	},
	default_buttons = {
		{
			button_name = "d_pad",
			text = "main_menu_move"
		},
		{
			button_name = "x",
			text = "menu_auto_join_team"
		},
		{
			button_name = "a",
			text = "main_menu_select"
		},
		{
			button_name = "back",
			text = "menu_ingame_leave_battle_lower"
		}
	}
}
SquadMenuSettings.pages.select_spawnpoint = SquadMenuSettings.pages.select_spawnpoint or {}
SquadMenuSettings.pages.select_spawnpoint[1680] = SquadMenuSettings.pages.select_spawnpoint[1680] or {}
SquadMenuSettings.pages.select_spawnpoint[1680][1050] = SquadMenuSettings.pages.select_spawnpoint[1680][1050] or table.clone(MainMenuSettings.pages.level_3[1680][1050])
SquadMenuSettings.pages.select_spawnpoint[1680][1050].center_items = table.clone(FinalScoreboardMenuSettings.pages.main_page[1680][1050].center_items)
SquadMenuSettings.pages.select_spawnpoint[1680][1050].center_items.pivot_offset_y = 0
SquadMenuSettings.pages.select_spawnpoint[1680][1050].squad_header = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_offset_x = 540,
	screen_offset_y = -0.25,
	pivot_align_x = "right",
	pivot_align_y = "top",
	screen_align_x = "left",
	pivot_offset_y = 60,
	column_alignment = {
		"right"
	}
}
SquadMenuSettings.pages.select_spawnpoint[1680][1050].squad_info = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_offset_x = 540,
	screen_offset_y = -0.25,
	pivot_align_x = "right",
	pivot_align_y = "top",
	screen_align_x = "left",
	pivot_offset_y = 0,
	column_alignment = {
		"right"
	}
}
SquadMenuSettings.pages.select_spawnpoint[1680][1050].squad_button = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_offset_x = 490,
	screen_offset_y = -0.25,
	pivot_align_x = "center",
	pivot_align_y = "top",
	screen_align_x = "left",
	pivot_offset_y = 3,
	column_alignment = {
		"center"
	}
}
SquadMenuSettings.pages.select_spawnpoint[1680][1050].page_links = table.clone(SquadMenuSettings.pages.select_team[1680][1050].page_links)
SquadMenuSettings.pages.select_spawnpoint[1680][1050].page_links.number_of_columns = 2
SquadMenuSettings.pages.select_spawnpoint[1680][1050].spawnpoint = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	pivot_align_y = "center",
	screen_align_x = "right",
	pivot_offset_y = 0,
	background = {
		texture = "right_info_bgr_1920",
		texture_height = 860,
		texture_width = 700
	},
	header = {
		texture = "header_item_bgr_left_1920",
		texture_height = 36,
		texture_offset_y = 760,
		texture_width = 652,
		font_size = 32,
		text_offset_y = 768,
		text_offset_x = 20,
		font = MenuSettings.fonts.hell_shark_32,
		text_color = {
			255,
			0,
			0,
			0
		}
	},
	map = {
		offset_x = 20,
		offset_y = 226
	},
	objectives_header = {
		font_size = 22,
		text_offset_y = 194,
		text_offset_x = 22,
		font = MenuSettings.fonts.hell_shark_22,
		text_color = {
			255,
			255,
			255,
			255
		},
		drop_shadow_color = {
			120,
			0,
			0,
			0
		},
		drop_shadow_offset = {
			2,
			-2
		}
	},
	objectives_description = {
		line_height = 18,
		width = 580,
		offset_x = 20,
		offset_y = 190,
		font_size = 16,
		text_align = "left",
		font = MenuSettings.fonts.hell_shark_16,
		color = {
			255,
			255,
			255,
			255
		},
		drop_shadow_color = {
			120,
			0,
			0,
			0
		},
		drop_shadow_offset = {
			2,
			-2
		}
	},
	level_header = {
		font_size = 22,
		text_offset_y = -36,
		text_offset_x = 22,
		font = MenuSettings.fonts.hell_shark_22,
		text_color = {
			255,
			255,
			255,
			255
		},
		drop_shadow_color = {
			120,
			0,
			0,
			0
		},
		drop_shadow_offset = {
			2,
			-2
		}
	},
	level_description = {
		line_height = 18,
		width = 580,
		offset_x = 20,
		offset_y = -38,
		font_size = 16,
		text_align = "left",
		font = MenuSettings.fonts.hell_shark_16,
		color = {
			255,
			255,
			255,
			255
		},
		drop_shadow_color = {
			120,
			0,
			0,
			0
		},
		drop_shadow_offset = {
			2,
			-2
		}
	},
	corner_top_texture = {
		texture = "item_list_top_corner_1920",
		texture_offset_y = 542,
		texture_width = 416,
		texture_offset_x = 290,
		texture_height = 308
	},
	corner_bottom_texture = {
		texture = "item_list_bottom_corner_1920",
		texture_offset_y = 10,
		texture_width = 416,
		texture_offset_x = 290,
		texture_height = 308
	}
}
SquadMenuSettings.pages.select_spawnpoint[1680][1050].button_info = {
	text_data = {
		font_size = 28,
		font = MenuSettings.fonts.hell_shark_28,
		offset_x = 25 * SCALE_1366,
		offset_y = 100 * SCALE_1366,
		drop_shadow = {
			2,
			-2
		}
	},
	default_buttons = {
		{
			button_name = "d_pad",
			text = "menu_ingame_join_leave_squad"
		},
		{
			button_name = "x",
			text = "menu_switch_character_lower"
		},
		{
			text = "menu_ingame_select_spawnpoint",
			button_name = {
				"left_button",
				"right_button"
			}
		},
		{
			button_name = "a",
			text = "menu_spawn"
		},
		{
			button_name = "back",
			text = "menu_ingame_leave_battle"
		}
	}
}
SquadMenuSettings.pages.select_character = SquadMenuSettings.pages.select_character or {}
SquadMenuSettings.pages.select_character[1680] = SquadMenuSettings.pages.select_character[1680] or {}
SquadMenuSettings.pages.select_character[1680][1050] = SquadMenuSettings.pages.select_character[1680][1050] or table.clone(MainMenuSettings.pages.level_2_character_profiles[1680][1050])
SquadMenuSettings.pages.select_character[1680][1050].page_links = table.clone(SquadMenuSettings.pages.select_team[1680][1050].page_links)
SquadMenuSettings.pages.select_character[1680][1050].profile_viewer = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	pivot_align_y = "center",
	screen_align_x = "center",
	pivot_offset_y = 0
}
SquadMenuSettings.pages.select_character[1680][1050].text = SquadMenuSettings.items.character_selection_text
SquadMenuSettings.pages.select_character[1680][1050].page_links.number_of_columns = 2
SquadMenuSettings.pages.select_character[1680][1050].button_info = {
	text_data = {
		font_size = 28,
		font = MenuSettings.fonts.hell_shark_28,
		offset_x = 25 * SCALE_1366,
		offset_y = 100 * SCALE_1366
	},
	default_buttons = {
		{
			button_name = "d_pad",
			text = "main_menu_move"
		},
		{
			button_name = "a",
			text = "main_menu_select"
		},
		{
			button_name = "x",
			text = "menu_select_team"
		},
		{
			button_name = "y",
			text = "menu_select_spawnpoint_lower"
		},
		{
			button_name = "back",
			text = "menu_ingame_leave_battle_lower"
		}
	}
}
SquadMenuSettings.pages.level_2_character_profiles = SquadMenuSettings.pages.level_2_character_profiles or {}
SquadMenuSettings.pages.level_2_character_profiles[1680] = SquadMenuSettings.pages.level_2_character_profiles[1680] or {}
SquadMenuSettings.pages.level_2_character_profiles[1680][1050] = SquadMenuSettings.pages.level_2_character_profiles[1680][1050] or table.clone(MainMenuSettings.pages.level_2_character_profiles[1680][1050])
SquadMenuSettings.pages.level_2_character_profiles[1680][1050].page_links = table.clone(SquadMenuSettings.pages.select_team[1680][1050].page_links)
SquadMenuSettings.pages.level_2_character_profiles[1680][1050].button_info = {
	text_data = {
		font_size = 28,
		font = MenuSettings.fonts.hell_shark_28,
		offset_x = 25 * SCALE_1366,
		offset_y = 100 * SCALE_1366,
		drop_shadow = {
			2,
			-2
		}
	},
	default_buttons = {
		{
			button_name = "d_pad",
			text = "main_menu_move"
		},
		{
			button_name = "a",
			text = "main_menu_select"
		},
		{
			button_name = "x",
			text = "menu_select_team"
		},
		{
			button_name = "back",
			text = "menu_ingame_leave_battle_lower"
		}
	}
}
