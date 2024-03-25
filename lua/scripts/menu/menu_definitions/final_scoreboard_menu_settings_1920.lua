-- chunkname: @scripts/menu/menu_definitions/final_scoreboard_menu_settings_1920.lua

require("scripts/settings/hud_settings")

FinalScoreboardMenuSettings = FinalScoreboardMenuSettings or {}
FinalScoreboardMenuSettings.items = FinalScoreboardMenuSettings.items or {}
FinalScoreboardMenuSettings.pages = FinalScoreboardMenuSettings.pages or {}
FinalScoreboardMenuSettings.items.battle_result = FinalScoreboardMenuSettings.items.battle_result or {}
FinalScoreboardMenuSettings.items.battle_result[1680] = FinalScoreboardMenuSettings.items.battle_result[1680] or {}
FinalScoreboardMenuSettings.items.battle_result[1680][1050] = FinalScoreboardMenuSettings.items.battle_result[1680][1050] or {
	texture_alignment = "center",
	texture_disabled = "selected_item_bgr_big_centered_1920",
	padding_left = 0,
	font_size = 80,
	padding_top = 20,
	texture_disabled_width = 1080,
	padding_bottom = 24,
	line_height = 54,
	texture_disabled_height = 60,
	padding_right = 0,
	font = MenuSettings.fonts.font_gradient_100,
	color_disabled = {
		255,
		255,
		255,
		255
	}
}
FinalScoreboardMenuSettings.items.battle_details = FinalScoreboardMenuSettings.items.battle_details or {}
FinalScoreboardMenuSettings.items.battle_details[1680] = FinalScoreboardMenuSettings.items.battle_details[1680] or {}
FinalScoreboardMenuSettings.items.battle_details[1680][1050] = FinalScoreboardMenuSettings.items.battle_details[1680][1050] or {
	texture_alignment = "center",
	texture_disabled = "selected_item_bgr_centered_1920",
	padding_left = 0,
	font_size = 32,
	padding_top = 8,
	texture_disabled_width = 652,
	padding_bottom = 9,
	line_height = 21,
	texture_disabled_height = 36,
	padding_right = 0,
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
FinalScoreboardMenuSettings.items.left_team_rose = FinalScoreboardMenuSettings.items.left_team_rose or {}
FinalScoreboardMenuSettings.items.left_team_rose[1680] = FinalScoreboardMenuSettings.items.left_team_rose[1680] or {}
FinalScoreboardMenuSettings.items.left_team_rose[1680][1050] = FinalScoreboardMenuSettings.items.left_team_rose[1680][1050] or {
	texture_red = "big_rose_red",
	padding_bottom = 0,
	padding_left = 0,
	texture_width = 444,
	texture_white = "big_rose_white",
	padding_top = 0,
	padding_right = 0,
	texture_height = 488
}
FinalScoreboardMenuSettings.items.center_team_rose = FinalScoreboardMenuSettings.items.center_team_rose or {}
FinalScoreboardMenuSettings.items.center_team_rose[1680] = FinalScoreboardMenuSettings.items.center_team_rose[1680] or {}
FinalScoreboardMenuSettings.items.center_team_rose[1680][1050] = FinalScoreboardMenuSettings.items.center_team_rose[1680][1050] or {
	texture_red = "big_rose_red",
	padding_bottom = 0,
	padding_left = 0,
	texture_width = 444,
	texture_white = "big_rose_white",
	padding_top = 100,
	padding_right = 0,
	texture_height = 488
}
FinalScoreboardMenuSettings.items.right_team_rose = FinalScoreboardMenuSettings.items.right_team_rose or {}
FinalScoreboardMenuSettings.items.right_team_rose[1680] = FinalScoreboardMenuSettings.items.right_team_rose[1680] or {}
FinalScoreboardMenuSettings.items.right_team_rose[1680][1050] = FinalScoreboardMenuSettings.items.right_team_rose[1680][1050] or {
	texture_red = "big_rose_red",
	padding_bottom = 0,
	padding_left = 0,
	texture_width = 444,
	texture_white = "big_rose_white",
	padding_top = 0,
	padding_right = 0,
	texture_height = 488
}
FinalScoreboardMenuSettings.items.left_team_score = FinalScoreboardMenuSettings.items.left_team_score or {}
FinalScoreboardMenuSettings.items.left_team_score[1680] = FinalScoreboardMenuSettings.items.left_team_score[1680] or {}
FinalScoreboardMenuSettings.items.left_team_score[1680][1050] = FinalScoreboardMenuSettings.items.left_team_score[1680][1050] or {
	line_height = 60,
	padding_left = 0,
	font_size = 150,
	padding_top = 20,
	padding_right = 0,
	padding_bottom = 60,
	font = MenuSettings.fonts.font_gradient_100,
	color_disabled = {
		255,
		255,
		255,
		0
	}
}
FinalScoreboardMenuSettings.items.right_team_score = FinalScoreboardMenuSettings.items.right_team_score or {}
FinalScoreboardMenuSettings.items.right_team_score[1680] = FinalScoreboardMenuSettings.items.right_team_score[1680] or {}
FinalScoreboardMenuSettings.items.right_team_score[1680][1050] = FinalScoreboardMenuSettings.items.right_team_score[1680][1050] or {
	line_height = 60,
	padding_left = 0,
	font_size = 150,
	padding_top = 20,
	padding_right = 0,
	padding_bottom = 60,
	font = MenuSettings.fonts.font_gradient_100,
	color_disabled = {
		255,
		255,
		255,
		0
	}
}
FinalScoreboardMenuSettings.items.left_team_text = FinalScoreboardMenuSettings.items.left_team_text or {}
FinalScoreboardMenuSettings.items.left_team_text[1680] = FinalScoreboardMenuSettings.items.left_team_text[1680] or {}
FinalScoreboardMenuSettings.items.left_team_text[1680][1050] = FinalScoreboardMenuSettings.items.left_team_text[1680][1050] or {
	font_size = 32,
	texture_alignment = "center",
	texture_disabled = "selected_item_bgr_right_1920",
	padding_left = 0,
	texture_offset_x = -66,
	padding_top = 7,
	texture_disabled_width = 652,
	padding_bottom = 7,
	line_height = 21,
	texture_disabled_height = 36,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_32,
	color_red = HUDSettings.player_colors.red_team,
	color_white = HUDSettings.player_colors.white_team,
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
FinalScoreboardMenuSettings.items.right_team_text = FinalScoreboardMenuSettings.items.right_team_text or {}
FinalScoreboardMenuSettings.items.right_team_text[1680] = FinalScoreboardMenuSettings.items.right_team_text[1680] or {}
FinalScoreboardMenuSettings.items.right_team_text[1680][1050] = FinalScoreboardMenuSettings.items.right_team_text[1680][1050] or {
	font_size = 32,
	texture_alignment = "center",
	texture_disabled = "selected_item_bgr_left_1920",
	padding_left = 0,
	texture_offset_x = 66,
	padding_top = 7,
	texture_disabled_width = 652,
	padding_bottom = 7,
	line_height = 21,
	texture_disabled_height = 36,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_32,
	color_red = HUDSettings.player_colors.red_team,
	color_white = HUDSettings.player_colors.white_team,
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
FinalScoreboardMenuSettings.pages.main_page = FinalScoreboardMenuSettings.pages.main_page or {}
FinalScoreboardMenuSettings.pages.main_page[1680] = FinalScoreboardMenuSettings.pages.main_page[1680] or {}
FinalScoreboardMenuSettings.pages.main_page[1680][1050] = FinalScoreboardMenuSettings.pages.main_page[1680][1050] or {
	center_items = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = -50,
		column_alignment = {
			"center"
		}
	},
	left_team_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = -300,
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = -300,
		column_alignment = {
			"center"
		}
	},
	right_team_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 300,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = -300,
		column_alignment = {
			"center"
		}
	},
	overlay_texture = {
		texture_lower = "frame_lower_1920",
		screen_offset_x = 0,
		texture_lower_right = "frame_lower_right_1920",
		stretch_relative_width = 1,
		pivot_align_y = "center",
		texture_upper_right = "frame_upper_right_1920",
		stretch_relative_height = 1,
		texture_upper = "frame_upper_1920",
		texture_right = "frame_right_1920",
		frame_thickness = 180,
		screen_align_y = "center",
		texture_left = "frame_left_1920",
		texture_upper_left = "frame_upper_left_1920",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture_lower_left = "frame_lower_left_1920",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center"
	},
	left_gradient_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_gradient_1920",
		pivot_offset_y = 0,
		texture_width = 636,
		screen_align_x = "center",
		stretch_relative_height = 1,
		pivot_offset_x = -262,
		screen_offset_y = 0,
		pivot_align_x = "right",
		stretch_width = 540,
		texture_height = 4,
		color_red = {
			255,
			255,
			180,
			180
		},
		color_white = {
			255,
			255,
			255,
			255
		}
	},
	left_vertical_line_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_vertical_line_1920",
		pivot_offset_y = 0,
		texture_width = 16,
		screen_align_x = "center",
		pivot_offset_x = -262,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 1016
	},
	left_corner_top_texture = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		texture = "item_list_top_corner_1920",
		pivot_offset_y = 0,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = -266,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 308
	},
	left_corner_bottom_texture = {
		screen_align_y = "bottom",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_bottom_corner_1920",
		pivot_offset_y = 0,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = -266,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 308
	},
	right_gradient_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_gradient_right_1920",
		pivot_offset_y = 0,
		texture_width = 636,
		screen_align_x = "center",
		stretch_relative_height = 1,
		pivot_offset_x = 262,
		screen_offset_y = 0,
		pivot_align_x = "left",
		stretch_width = 540,
		texture_height = 4,
		color_red = {
			255,
			255,
			180,
			180
		},
		color_white = {
			255,
			255,
			255,
			255
		}
	},
	right_vertical_line_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_vertical_line_right_1920",
		pivot_offset_y = 0,
		texture_width = 16,
		screen_align_x = "center",
		pivot_offset_x = 262,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 1016
	},
	right_corner_top_texture = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		texture = "item_list_top_corner_right_1920",
		pivot_offset_y = 0,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = 266,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 308
	},
	right_corner_bottom_texture = {
		screen_align_y = "bottom",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_bottom_corner_right_1920",
		pivot_offset_y = 0,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = 266,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 308
	}
}
FinalScoreboardMenuSettings.pages.main_page[1680][1050].button_info = {
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
	default_buttons = {}
}
