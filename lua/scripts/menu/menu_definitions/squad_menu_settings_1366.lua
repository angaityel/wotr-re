-- chunkname: @scripts/menu/menu_definitions/squad_menu_settings_1366.lua

require("scripts/menu/menu_definitions/final_scoreboard_menu_settings_1366")

SCALE_1366 = 0.7114583333333333
SquadMenuSettings = SquadMenuSettings or {}
SquadMenuSettings.items = SquadMenuSettings.items or {}
SquadMenuSettings.pages = SquadMenuSettings.pages or {}
SquadMenuSettings.items.pulse_text_right_aligned = SquadMenuSettings.items.pulse_text_right_aligned or {}
SquadMenuSettings.items.pulse_text_right_aligned[1366] = SquadMenuSettings.items.pulse_text_right_aligned[1366] or {}
SquadMenuSettings.items.pulse_text_right_aligned[1366][768] = SquadMenuSettings.items.pulse_text_right_aligned[1366][768] or table.clone(MainMenuSettings.items.text_right_aligned[1366][768])
SquadMenuSettings.items.pulse_text_right_aligned[1366][768].pulse_speed = 5
SquadMenuSettings.items.pulse_text_right_aligned[1366][768].pulse_alpha_min = 20
SquadMenuSettings.items.pulse_text_right_aligned[1366][768].pulse_alpha_max = 255
SquadMenuSettings.items.spawn_map = SquadMenuSettings.items.spawn_map or {}
SquadMenuSettings.items.spawn_map[1366] = SquadMenuSettings.items.spawn_map[1366] or {}
SquadMenuSettings.items.spawn_map[1366][768] = SquadMenuSettings.items.spawn_map[1366][768] or {
	width = 512 * SCALE_1366,
	height = 512 * SCALE_1366,
	color = {
		255,
		64,
		128,
		255
	}
}
SquadMenuSettings.items.local_player_marker = SquadMenuSettings.items.local_player_marker or {}
SquadMenuSettings.items.local_player_marker[1366] = SquadMenuSettings.items.local_player_marker[1366] or {}
SquadMenuSettings.items.local_player_marker[1366][768] = SquadMenuSettings.items.local_player_marker[1366][768] or {
	texture = "map_icon_local_player",
	texture_height = 12,
	texture_width = 12
}
SquadMenuSettings.items.spawn_area_marker = SquadMenuSettings.items.spawn_area_marker or {}
SquadMenuSettings.items.spawn_area_marker[1366] = SquadMenuSettings.items.spawn_area_marker[1366] or {}
SquadMenuSettings.items.spawn_area_marker[1366][768] = SquadMenuSettings.items.spawn_area_marker[1366][768] or {
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
SquadMenuSettings.items.squad_marker[1366] = SquadMenuSettings.items.squad_marker[1366] or {}
SquadMenuSettings.items.squad_marker[1366][768] = SquadMenuSettings.items.squad_marker[1366][768] or {
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
SquadMenuSettings.items.squad_header[1366] = SquadMenuSettings.items.squad_header[1366] or {}
SquadMenuSettings.items.squad_header[1366][768] = SquadMenuSettings.items.squad_header[1366][768] or {
	texture_disabled = "selected_item_bgr_right_1920",
	texture_alignment = "right",
	font = MenuSettings.fonts.hell_shark_32,
	font_size = 32 * SCALE_1366,
	line_height = 21 * SCALE_1366,
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
		2 * SCALE_1366,
		-2 * SCALE_1366
	},
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	padding_top = 14 * SCALE_1366,
	padding_bottom = 14 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
SquadMenuSettings.items.squad_info_text = SquadMenuSettings.items.squad_info_text or {}
SquadMenuSettings.items.squad_info_text[1366] = SquadMenuSettings.items.squad_info_text[1366] or {}
SquadMenuSettings.items.squad_info_text[1366][768] = SquadMenuSettings.items.squad_info_text[1366][768] or {
	texture = "header_item_bgr_right_1920",
	joined_texture = "assigned_background_1920",
	padding_top = 10,
	padding_bottom = 10,
	font = MenuSettings.fonts.hell_shark_32,
	font_size = 32 * SCALE_1366,
	line_height = 21 * SCALE_1366,
	text_offset_y = 8 * SCALE_1366,
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
	column_1_offset_x = 80 * SCALE_1366,
	column_2_offset_x = 420 * SCALE_1366,
	texture_width = 652 * SCALE_1366,
	texture_height = 36 * SCALE_1366,
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
	joined_texture_width = 172 * SCALE_1366,
	joined_texture_height = 24 * SCALE_1366,
	joined_font_size = 20 * SCALE_1366,
	joined_text_offset_x = 10 * SCALE_1366,
	joined_text_offset_y = 6 * SCALE_1366,
	joined_text_color = {
		255,
		255,
		255,
		255
	},
	width = 540 * SCALE_1366
}
SquadMenuSettings.items.squad_join_button = SquadMenuSettings.items.squad_join_button or {}
SquadMenuSettings.items.squad_join_button[1366] = SquadMenuSettings.items.squad_join_button[1366] or {}
SquadMenuSettings.items.squad_join_button[1366][768] = SquadMenuSettings.items.squad_join_button[1366][768] or {
	text_padding = 1,
	texture_right_width = 8,
	texture_left = "small_button_left_1366",
	text_offset_y = 6,
	font_size = 18,
	texture_middle = "small_button_center_1366",
	texture_right = "small_button_right_1366",
	padding_bottom = 10,
	texture_middle_highlighted = "small_button_center_highlighted_1366",
	texture_right_highlighted = "small_button_right_highlighted_1366",
	padding_top = 12,
	texture_left_width = 8,
	texture_left_highlighted = "small_button_left_highlighted_1366",
	padding_left = 14,
	padding_right = 0,
	texture_height = 24,
	font = MenuSettings.fonts.hell_shark_18,
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
SquadMenuSettings.items.page_link[1366] = SquadMenuSettings.items.page_link[1366] or {}
SquadMenuSettings.items.page_link[1366][768] = SquadMenuSettings.items.page_link[1366][768] or {
	texture = "header_item_bgr_right_1920",
	texture_highlighted = "header_item_bgr_right_1920",
	texture_disabled = "header_item_bgr_right_1920",
	texture_alignment = "right",
	font = MenuSettings.fonts.hell_shark_32,
	font_size = 32 * SCALE_1366,
	line_height = 21 * SCALE_1366,
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
	texture_width = 652 * SCALE_1366,
	texture_height = 36 * SCALE_1366,
	texture_highlighted_color = {
		255,
		255,
		255,
		255
	},
	texture_highlighted_width = 652 * SCALE_1366,
	texture_highlighted_height = 36 * SCALE_1366,
	texture_disabled_color = {
		0,
		215,
		215,
		215
	},
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	padding_top = 12 * SCALE_1366,
	padding_bottom = 12 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
SquadMenuSettings.items.next_button = SquadMenuSettings.items.next_button or {}
SquadMenuSettings.items.next_button[1366] = SquadMenuSettings.items.next_button[1366] or {}
SquadMenuSettings.items.next_button[1366][768] = SquadMenuSettings.items.next_button[1366][768] or {
	text_padding = 0,
	texture_right_width = 24,
	texture_left = "shiny_button_left_end_1366",
	text_offset_y = 16,
	font_size = 18,
	texture_middle = "shiny_button_center_1366",
	texture_right = "shiny_button_right_tip_1366",
	padding_bottom = 0,
	texture_middle_highlighted = "shiny_button_center_highlighted_1366",
	texture_right_highlighted = "shiny_button_right_tip_highlighted_1366",
	padding_top = 0,
	texture_left_width = 20,
	texture_left_highlighted = "shiny_button_left_end_highlighted_1366",
	padding_left = 14,
	padding_right = 14,
	texture_height = 44,
	font = MenuSettings.fonts.hell_shark_18,
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
SquadMenuSettings.items.previous_button[1366] = SquadMenuSettings.items.previous_button[1366] or {}
SquadMenuSettings.items.previous_button[1366][768] = SquadMenuSettings.items.previous_button[1366][768] or {
	text_padding = 0,
	texture_right_width = 20,
	texture_left = "shiny_button_left_tip_1366",
	text_offset_y = 16,
	font_size = 18,
	texture_middle = "shiny_button_center_1366",
	texture_right = "shiny_button_right_end_1366",
	padding_bottom = 0,
	texture_middle_highlighted = "shiny_button_center_highlighted_1366",
	texture_right_highlighted = "shiny_button_right_end_highlighted_1366",
	padding_top = 0,
	texture_left_width = 24,
	texture_left_highlighted = "shiny_button_left_tip_highlighted_1366",
	padding_left = 14,
	padding_right = 14,
	texture_height = 44,
	font = MenuSettings.fonts.hell_shark_18,
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
SquadMenuSettings.items.centered_button[1366] = SquadMenuSettings.items.centered_button[1366] or {}
SquadMenuSettings.items.centered_button[1366][768] = SquadMenuSettings.items.centered_button[1366][768] or {
	text_padding = 0,
	texture_right_width = 20,
	texture_left = "shiny_button_left_end_1366",
	text_offset_y = 16,
	font_size = 18,
	texture_middle = "shiny_button_center_1366",
	texture_right = "shiny_button_right_end_1366",
	padding_bottom = 0,
	texture_middle_highlighted = "shiny_button_center_highlighted_1366",
	texture_right_highlighted = "shiny_button_right_end_highlighted_1366",
	padding_top = 0,
	texture_left_width = 20,
	texture_left_highlighted = "shiny_button_left_end_highlighted_1366",
	padding_left = 14,
	padding_right = 14,
	texture_height = 44,
	font = MenuSettings.fonts.hell_shark_18,
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
SquadMenuSettings.items.character_selection_text[1366] = SquadMenuSettings.items.character_selection_text[1366] or {}
SquadMenuSettings.items.character_selection_text[1366][768] = SquadMenuSettings.items.character_selection_text[1366][768] or {
	texture_unavalible_rank_not_met = "locked_xp_1920",
	texture_highlighted = "selected_item_bgr_right_1920",
	texture_unavalible_align = "right",
	texture_unavalible_perk_required = "locked_perk_1920",
	texture_unavalible_not_owned = "locked_money_1920",
	texture_alignment = "right",
	font = MenuSettings.fonts.hell_shark_32,
	font_size = 32 * SCALE_1366,
	line_height = 21 * SCALE_1366,
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
		2 * SCALE_1366,
		-2 * SCALE_1366
	},
	texture_highlighted_width = 652 * SCALE_1366,
	texture_highlighted_height = 36 * SCALE_1366,
	texture_unavalible_width = 64 * SCALE_1366,
	texture_unavalible_height = 32 * SCALE_1366,
	texture_unavalible_offset_x = -360 * SCALE_1366,
	texture_unavalible_offset_y = 1 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
SquadMenuSettings.items.quote_text = SquadMenuSettings.items.quote_text or {}
SquadMenuSettings.items.quote_text[1366] = SquadMenuSettings.items.quote_text[1366] or {}
SquadMenuSettings.items.quote_text[1366][768] = SquadMenuSettings.items.quote_text[1366][768] or {
	text_align = "left",
	font = MenuSettings.fonts.hell_shark_22,
	font_size = 22 * SCALE_1366,
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
		2 * SCALE_1366,
		-2 * SCALE_1366
	},
	line_height = 32 * SCALE_1366,
	width = 440 * SCALE_1366,
	padding_top = 40 * SCALE_1366,
	padding_bottom = 40 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 0 * SCALE_1366
}
SquadMenuSettings.items.red_team_rose = SquadMenuSettings.items.red_team_rose or {}
SquadMenuSettings.items.red_team_rose[1366] = SquadMenuSettings.items.red_team_rose[1366] or {}
SquadMenuSettings.items.red_team_rose[1366][768] = SquadMenuSettings.items.red_team_rose[1366][768] or {
	texture = "big_rose_red",
	texture_highlighted = "team_selection_highlighted_1920",
	texture_disabled = "team_selection_disabled_1920",
	texture_width = 444 * SCALE_1366,
	texture_height = 488 * SCALE_1366,
	color_disabled = {
		150,
		100,
		100,
		100
	},
	padding_top = 0 * SCALE_1366,
	padding_bottom = 0 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 0 * SCALE_1366,
	texture_highlighted_offset_x = -44 * SCALE_1366,
	texture_highlighted_offset_y = -22 * SCALE_1366,
	texture_highlighted_offset_z = 0 * SCALE_1366,
	texture_highlighted_width = 532 * SCALE_1366,
	texture_highlighted_height = 532 * SCALE_1366,
	texture_disabled_offset_x = 136 * SCALE_1366,
	texture_disabled_offset_y = 150 * SCALE_1366,
	texture_disabled_offset_z = 2 * SCALE_1366,
	texture_disabled_width = 184 * SCALE_1366,
	texture_disabled_height = 184 * SCALE_1366
}
SquadMenuSettings.items.white_team_rose = SquadMenuSettings.items.white_team_rose or {}
SquadMenuSettings.items.white_team_rose[1366] = SquadMenuSettings.items.white_team_rose[1366] or {}
SquadMenuSettings.items.white_team_rose[1366][768] = SquadMenuSettings.items.white_team_rose[1366][768] or {
	texture = "big_rose_white",
	texture_highlighted = "team_selection_highlighted_1920",
	texture_disabled = "team_selection_disabled_1920",
	texture_width = 444 * SCALE_1366,
	texture_height = 488 * SCALE_1366,
	color_disabled = {
		150,
		100,
		100,
		100
	},
	padding_top = 0 * SCALE_1366,
	padding_bottom = 0 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 0 * SCALE_1366,
	texture_highlighted_offset_x = -44 * SCALE_1366,
	texture_highlighted_offset_y = -22 * SCALE_1366,
	texture_highlighted_offset_z = 0 * SCALE_1366,
	texture_highlighted_width = 532 * SCALE_1366,
	texture_highlighted_height = 532 * SCALE_1366,
	texture_disabled_offset_x = 140 * SCALE_1366,
	texture_disabled_offset_y = 156 * SCALE_1366,
	texture_disabled_offset_z = 2 * SCALE_1366,
	texture_disabled_width = 184 * SCALE_1366,
	texture_disabled_height = 184 * SCALE_1366
}
SquadMenuSettings.items.red_team_text = SquadMenuSettings.items.red_team_text or {}
SquadMenuSettings.items.red_team_text[1366] = SquadMenuSettings.items.red_team_text[1366] or {}
SquadMenuSettings.items.red_team_text[1366][768] = SquadMenuSettings.items.red_team_text[1366][768] or {
	texture = "selected_item_bgr_right_1920",
	texture_alignment = "center",
	texture_disabled = "selected_item_bgr_right_1920",
	font = MenuSettings.fonts.hell_shark_32,
	font_size = 32 * SCALE_1366,
	line_height = 21 * SCALE_1366,
	color = HUDSettings.player_colors.red_team,
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2 * SCALE_1366,
		-2 * SCALE_1366
	},
	texture_width = 652 * SCALE_1366,
	texture_height = 36 * SCALE_1366,
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	texture_offset_x = -66 * SCALE_1366,
	padding_top = 40 * SCALE_1366,
	padding_bottom = 40 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 0 * SCALE_1366
}
SquadMenuSettings.items.white_team_text = SquadMenuSettings.items.white_team_text or {}
SquadMenuSettings.items.white_team_text[1366] = SquadMenuSettings.items.white_team_text[1366] or {}
SquadMenuSettings.items.white_team_text[1366][768] = SquadMenuSettings.items.white_team_text[1366][768] or {
	texture = "selected_item_bgr_left_1920",
	texture_alignment = "center",
	texture_disabled = "selected_item_bgr_left_1920",
	font = MenuSettings.fonts.hell_shark_32,
	font_size = 32 * SCALE_1366,
	line_height = 21 * SCALE_1366,
	color = HUDSettings.player_colors.white_team,
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2 * SCALE_1366,
		-2 * SCALE_1366
	},
	texture_width = 652 * SCALE_1366,
	texture_height = 36 * SCALE_1366,
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	texture_offset_x = 66 * SCALE_1366,
	padding_top = 40 * SCALE_1366,
	padding_bottom = 40 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 0 * SCALE_1366
}
SquadMenuSettings.items.red_team_num_players = SquadMenuSettings.items.red_team_num_players or {}
SquadMenuSettings.items.red_team_num_players[1366] = SquadMenuSettings.items.red_team_num_players[1366] or {}
SquadMenuSettings.items.red_team_num_players[1366][768] = SquadMenuSettings.items.red_team_num_players[1366][768] or {
	font = MenuSettings.fonts.hell_shark_32,
	font_size = 32 * SCALE_1366,
	line_height = 21 * SCALE_1366,
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
		2 * SCALE_1366,
		-2 * SCALE_1366
	},
	padding_top = 0 * SCALE_1366,
	padding_bottom = 0 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 0 * SCALE_1366
}
SquadMenuSettings.items.white_team_num_players = SquadMenuSettings.items.white_team_num_players or {}
SquadMenuSettings.items.white_team_num_players[1366] = SquadMenuSettings.items.white_team_num_players[1366] or {}
SquadMenuSettings.items.white_team_num_players[1366][768] = SquadMenuSettings.items.white_team_num_players[1366][768] or {
	font = MenuSettings.fonts.hell_shark_32,
	drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2 * SCALE_1366,
		-2 * SCALE_1366
	},
	font_size = 32 * SCALE_1366,
	line_height = 21 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	padding_top = 0 * SCALE_1366,
	padding_bottom = 0 * SCALE_1366,
	padding_left = 0 * SCALE_1366,
	padding_right = 0 * SCALE_1366
}
SquadMenuSettings.pages.select_team = SquadMenuSettings.pages.select_team or {}
SquadMenuSettings.pages.select_team[1366] = SquadMenuSettings.pages.select_team[1366] or {}
SquadMenuSettings.pages.select_team[1366][768] = SquadMenuSettings.pages.select_team[1366][768] or table.clone(FinalScoreboardMenuSettings.pages.main_page[1366][768])
SquadMenuSettings.pages.select_team[1366][768].center_items.pivot_offset_y = 0
SquadMenuSettings.pages.select_team[1366][768].back_list = table.clone(MainMenuSettings.pages.level_2[1366][768].back_list)
SquadMenuSettings.pages.select_team[1366][768].back_list.number_of_columns = 2
SquadMenuSettings.pages.select_team[1366][768].page_links = {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	screen_offset_y = 0,
	pivot_align_x = "right",
	number_of_columns = 2,
	screen_align_x = "right",
	pivot_offset_x = -40 * SCALE_1366,
	pivot_offset_y = 30 * SCALE_1366,
	column_alignment = {
		"right"
	}
}
SquadMenuSettings.pages.select_team[1366][768].button_info = {
	text_data = {
		font_size = 16,
		font = MenuSettings.fonts.hell_shark_16,
		offset_x = 25 * SCALE_1366,
		offset_y = 100 * SCALE_1366,
		drop_shadow = {
			1,
			-1
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
SquadMenuSettings.pages.select_spawnpoint[1366] = SquadMenuSettings.pages.select_spawnpoint[1366] or {}
SquadMenuSettings.pages.select_spawnpoint[1366][768] = SquadMenuSettings.pages.select_spawnpoint[1366][768] or table.clone(MainMenuSettings.pages.level_3[1366][768])
SquadMenuSettings.pages.select_spawnpoint[1366][768].center_items = table.clone(FinalScoreboardMenuSettings.pages.main_page[1680][1050].center_items)
SquadMenuSettings.pages.select_spawnpoint[1366][768].center_items.pivot_offset_y = 0
SquadMenuSettings.pages.select_spawnpoint[1366][768].squad_header = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	screen_offset_y = -0.25,
	pivot_align_x = "right",
	screen_align_x = "left",
	pivot_offset_x = 540 * SCALE_1366,
	pivot_offset_y = 60 * SCALE_1366,
	column_alignment = {
		"right"
	}
}
SquadMenuSettings.pages.select_spawnpoint[1366][768].squad_info = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	screen_offset_y = -0.25,
	pivot_align_x = "right",
	screen_align_x = "left",
	pivot_offset_x = 540 * SCALE_1366,
	pivot_offset_y = 0 * SCALE_1366,
	column_alignment = {
		"right"
	}
}
SquadMenuSettings.pages.select_spawnpoint[1366][768].squad_button = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	screen_offset_y = -0.25,
	pivot_align_x = "center",
	screen_align_x = "left",
	pivot_offset_x = 490 * SCALE_1366,
	pivot_offset_y = 3 * SCALE_1366,
	column_alignment = {
		"center"
	}
}
SquadMenuSettings.pages.select_spawnpoint[1366][768].page_links = table.clone(SquadMenuSettings.pages.select_team[1366][768].page_links)
SquadMenuSettings.pages.select_spawnpoint[1366][768].page_links.number_of_columns = 2
SquadMenuSettings.pages.select_spawnpoint[1366][768].spawnpoint = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	screen_offset_y = 0,
	pivot_align_x = "right",
	screen_align_x = "right",
	pivot_offset_x = 0 * SCALE_1366,
	pivot_offset_y = 0 * SCALE_1366,
	background = {
		texture = "right_info_bgr_1920",
		texture_width = 700 * SCALE_1366,
		texture_height = 860 * SCALE_1366
	},
	header = {
		texture = "header_item_bgr_left_1920",
		font = MenuSettings.fonts.hell_shark_32,
		font_size = 32 * SCALE_1366,
		text_color = {
			255,
			0,
			0,
			0
		},
		text_offset_x = 20 * SCALE_1366,
		text_offset_y = 768 * SCALE_1366,
		texture_width = 652 * SCALE_1366,
		texture_height = 36 * SCALE_1366,
		texture_offset_y = 760 * SCALE_1366
	},
	map = {
		offset_x = 20 * SCALE_1366,
		offset_y = 226 * SCALE_1366
	},
	objectives_header = {
		font = MenuSettings.fonts.hell_shark_22,
		font_size = 22 * SCALE_1366,
		text_color = {
			255,
			255,
			255,
			255
		},
		text_offset_x = 22 * SCALE_1366,
		text_offset_y = 194 * SCALE_1366,
		drop_shadow_color = {
			120,
			0,
			0,
			0
		},
		drop_shadow_offset = {
			2 * SCALE_1366,
			-2 * SCALE_1366
		}
	},
	objectives_description = {
		text_align = "left",
		font = MenuSettings.fonts.hell_shark_16,
		font_size = 16 * SCALE_1366,
		color = {
			255,
			255,
			255,
			255
		},
		line_height = 18 * SCALE_1366,
		width = 580 * SCALE_1366,
		drop_shadow_color = {
			120,
			0,
			0,
			0
		},
		drop_shadow_offset = {
			2 * SCALE_1366,
			-2 * SCALE_1366
		},
		offset_x = 20 * SCALE_1366,
		offset_y = 190 * SCALE_1366
	},
	level_header = {
		font = MenuSettings.fonts.hell_shark_22,
		font_size = 22 * SCALE_1366,
		text_color = {
			255,
			255,
			255,
			255
		},
		text_offset_x = 22 * SCALE_1366,
		text_offset_y = -36 * SCALE_1366,
		drop_shadow_color = {
			120,
			0,
			0,
			0
		},
		drop_shadow_offset = {
			2 * SCALE_1366,
			-2 * SCALE_1366
		}
	},
	level_description = {
		text_align = "left",
		font = MenuSettings.fonts.hell_shark_16,
		font_size = 16 * SCALE_1366,
		color = {
			255,
			255,
			255,
			255
		},
		line_height = 18 * SCALE_1366,
		width = 580 * SCALE_1366,
		drop_shadow_color = {
			120,
			0,
			0,
			0
		},
		drop_shadow_offset = {
			2 * SCALE_1366,
			-2 * SCALE_1366
		},
		offset_x = 20 * SCALE_1366,
		offset_y = -38 * SCALE_1366
	},
	corner_top_texture = {
		texture = "item_list_top_corner_1920",
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366,
		texture_offset_x = 290 * SCALE_1366,
		texture_offset_y = 542 * SCALE_1366
	},
	corner_bottom_texture = {
		texture = "item_list_bottom_corner_1920",
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366,
		texture_offset_x = 290 * SCALE_1366,
		texture_offset_y = 10 * SCALE_1366
	}
}
SquadMenuSettings.pages.select_spawnpoint[1366][768].button_info = {
	text_data = {
		font_size = 16,
		font = MenuSettings.fonts.hell_shark_16,
		offset_x = 25 * SCALE_1366,
		offset_y = 100 * SCALE_1366,
		drop_shadow = {
			1,
			-1
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
SquadMenuSettings.pages.select_character[1366] = SquadMenuSettings.pages.select_character[1366] or {}
SquadMenuSettings.pages.select_character[1366][768] = SquadMenuSettings.pages.select_character[1366][768] or table.clone(MainMenuSettings.pages.level_2_character_profiles[1366][768])
SquadMenuSettings.pages.select_character[1366][768].page_links = table.clone(SquadMenuSettings.pages.select_team[1366][768].page_links)
SquadMenuSettings.pages.select_character[1366][768].profile_viewer = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	screen_offset_y = 0,
	pivot_align_x = "center",
	screen_align_x = "center",
	pivot_offset_x = 0 * SCALE_1366,
	pivot_offset_y = 0 * SCALE_1366
}
SquadMenuSettings.pages.select_character[1366][768].text = SquadMenuSettings.items.character_selection_text
SquadMenuSettings.pages.select_character[1366][768].page_links.number_of_columns = 2
SquadMenuSettings.pages.select_character[1366][768].button_info = {
	text_data = {
		font_size = 16,
		font = MenuSettings.fonts.hell_shark_16,
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
SquadMenuSettings.pages.level_2_character_profiles[1366] = SquadMenuSettings.pages.level_2_character_profiles[1366] or {}
SquadMenuSettings.pages.level_2_character_profiles[1366][768] = SquadMenuSettings.pages.level_2_character_profiles[1366][768] or table.clone(MainMenuSettings.pages.level_2_character_profiles[1366][768])
SquadMenuSettings.pages.level_2_character_profiles[1366][768].page_links = table.clone(SquadMenuSettings.pages.select_team[1366][768].page_links)
SquadMenuSettings.pages.level_2_character_profiles[1366][768].button_info = {
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
