-- chunkname: @scripts/menu/menu_definitions/scoreboard_settings_1366.lua

require("scripts/settings/hud_settings")

ScoreboardSettings = ScoreboardSettings or {}
ScoreboardSettings.items = ScoreboardSettings.items or {}
ScoreboardSettings.pages = ScoreboardSettings.pages or {}
SCALE_1366 = 0.7114583333333333
ScoreboardSettings.pages.main_page = ScoreboardSettings.pages.main_page or {}
ScoreboardSettings.pages.main_page[1366] = ScoreboardSettings.pages.main_page[1366] or {}
ScoreboardSettings.pages.main_page[1366][768] = ScoreboardSettings.pages.main_page[1366][768] or {
	center_items = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = -80 * SCALE_1366,
		column_alignment = {
			"center"
		}
	},
	left_team_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "right",
		number_of_columns = 3,
		screen_align_x = "center",
		pivot_offset_x = -110 * SCALE_1366,
		pivot_offset_y = 470 * SCALE_1366,
		column_width = {
			110 * SCALE_1366,
			280 * SCALE_1366,
			170 * SCALE_1366
		},
		column_alignment = {
			"left",
			"left",
			"right"
		}
	},
	left_team_players = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		texture_background = "scoreboard_bgr_left_1366",
		pivot_offset_y = 213,
		texture_background_width = 500,
		screen_align_x = "center",
		texture_background_align = "right",
		number_of_visible_rows = 12,
		background_min_height = 348,
		pivot_offset_x = -18,
		screen_offset_y = 0,
		pivot_align_x = "right",
		headers = {
			columns = {
				{
					width = 43,
					align = "left"
				},
				{
					width = 206,
					align = "left"
				},
				{
					width = 70,
					align = "left"
				},
				{
					width = 43,
					align = "left"
				},
				{
					width = 71,
					align = "left"
				},
				{
					width = 57,
					align = "left"
				}
			},
			rows = {
				{
					align = "center",
					height = 28
				}
			}
		},
		items = {
			columns = {
				{
					width = 490,
					align = "left"
				}
			},
			rows = {
				{
					align = "center",
					height = 28
				}
			}
		},
		scroll_bar = {
			offset_z = 10,
			align = "left"
		}
	},
	right_team_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 3,
		screen_align_x = "center",
		pivot_offset_x = 110 * SCALE_1366,
		pivot_offset_y = 470 * SCALE_1366,
		column_width = {
			170 * SCALE_1366,
			280 * SCALE_1366,
			110 * SCALE_1366
		},
		column_alignment = {
			"left",
			"right",
			"right"
		}
	},
	right_team_players = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		texture_background = "scoreboard_bgr_right_1366",
		pivot_offset_y = 213,
		texture_background_width = 500,
		screen_align_x = "center",
		texture_background_align = "left",
		number_of_visible_rows = 12,
		background_min_height = 348,
		pivot_offset_x = 18,
		screen_offset_y = 0,
		pivot_align_x = "left",
		headers = {
			columns = {
				{
					width = 43,
					align = "left"
				},
				{
					width = 206,
					align = "left"
				},
				{
					width = 70,
					align = "left"
				},
				{
					width = 43,
					align = "left"
				},
				{
					width = 71,
					align = "left"
				},
				{
					width = 57,
					align = "left"
				}
			},
			rows = {
				{
					align = "center",
					height = 28
				}
			}
		},
		items = {
			columns = {
				{
					width = 490,
					align = "left"
				}
			},
			rows = {
				{
					align = "center",
					height = 28
				}
			}
		},
		scroll_bar = {
			offset_z = 10,
			align = "right"
		}
	},
	player_details = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_align_x = "center",
		texture_background_align = "left",
		texture_background = "scoreboard_player_details_bgr_1920",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_offset_y = -250 * SCALE_1366,
		texture_background_width = 1400 * SCALE_1366,
		background_offset_y = 54 * SCALE_1366,
		background_min_height = 210 * SCALE_1366,
		headers = {
			columns = {
				{
					align = "right",
					width = 200 * SCALE_1366
				},
				{
					align = "left",
					width = 600 * SCALE_1366
				},
				{
					align = "right",
					width = 600 * SCALE_1366
				}
			},
			rows = {
				{
					align = "center",
					height = 50 * SCALE_1366
				},
				{
					align = "center",
					height = 4 * SCALE_1366
				}
			}
		},
		items = {
			columns = {
				{
					align = "right",
					width = 160 * SCALE_1366
				},
				{
					align = "right",
					width = 250 * SCALE_1366
				},
				{
					align = "left",
					width = 60 * SCALE_1366
				},
				{
					align = "right",
					width = 250 * SCALE_1366
				},
				{
					align = "left",
					width = 60 * SCALE_1366
				},
				{
					align = "right",
					width = 250 * SCALE_1366
				},
				{
					align = "left",
					width = 60 * SCALE_1366
				},
				{
					align = "right",
					width = 250 * SCALE_1366
				},
				{
					align = "left",
					width = 60 * SCALE_1366
				}
			},
			rows = {
				{
					align = "center",
					height = 36 * SCALE_1366
				}
			}
		}
	},
	coat_of_arms_viewer = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		screen_align_x = "center",
		pivot_offset_x = 30 * SCALE_1366,
		pivot_offset_y = 60 * SCALE_1366,
		width = 300 * SCALE_1366,
		height = 360 * SCALE_1366
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
		screen_align_y = "center",
		texture_left = "frame_left_1920",
		texture_upper_left = "frame_upper_left_1920",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture_lower_left = "frame_lower_left_1920",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		frame_thickness = 180 * SCALE_1366
	},
	left_gradient_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_gradient_1920",
		pivot_offset_y = 0,
		stretch_relative_height = 1,
		screen_align_x = "center",
		pivot_offset_x = -18,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_width = 636 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		stretch_width = 750 * SCALE_1366,
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
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture = "item_list_vertical_line_1920",
		pivot_offset_x = -25 * SCALE_1366,
		texture_width = 16 * SCALE_1366,
		texture_height = 1016 * SCALE_1366
	},
	left_corner_top_texture = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture = "item_list_top_corner_1920",
		pivot_offset_x = -30 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	},
	left_corner_bottom_texture = {
		screen_align_y = "bottom",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture = "item_list_bottom_corner_1920",
		pivot_offset_x = -30 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	},
	right_gradient_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_gradient_right_1920",
		pivot_offset_y = 0,
		stretch_relative_height = 1,
		screen_align_x = "center",
		pivot_offset_x = 18,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_width = 636 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		stretch_width = 750 * SCALE_1366,
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
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture = "item_list_vertical_line_right_1920",
		pivot_offset_x = 25 * SCALE_1366,
		texture_width = 16 * SCALE_1366,
		texture_height = 1016 * SCALE_1366
	},
	right_corner_top_texture = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture = "item_list_top_corner_right_1920",
		pivot_offset_x = 30 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	},
	right_corner_bottom_texture = {
		screen_align_y = "bottom",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture = "item_list_bottom_corner_right_1920",
		pivot_offset_x = 30 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	}
}
ScoreboardSettings.pages.main_page[1366][768].do_not_render_buttons = true
ScoreboardSettings.items.left_team_rose = ScoreboardSettings.items.left_team_rose or {}
ScoreboardSettings.items.left_team_rose[1366] = ScoreboardSettings.items.left_team_rose[1366] or {}
ScoreboardSettings.items.left_team_rose[1366][768] = ScoreboardSettings.items.left_team_rose[1366][768] or {
	texture_red = "medium_rose_red_1920",
	texture_white = "medium_rose_white_1920",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_width = 108 * SCALE_1366,
	texture_height = 108 * SCALE_1366,
	padding_bottom = -20 * SCALE_1366
}
ScoreboardSettings.items.right_team_rose = ScoreboardSettings.items.right_team_rose or {}
ScoreboardSettings.items.right_team_rose[1366] = ScoreboardSettings.items.right_team_rose[1366] or {}
ScoreboardSettings.items.right_team_rose[1366][768] = ScoreboardSettings.items.right_team_rose[1366][768] or {
	texture_red = "medium_rose_red_1920",
	texture_white = "medium_rose_white_1920",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_width = 108 * SCALE_1366,
	texture_height = 108 * SCALE_1366,
	padding_bottom = -20 * SCALE_1366
}
ScoreboardSettings.items.left_team_text = ScoreboardSettings.items.left_team_text or {}
ScoreboardSettings.items.left_team_text[1366] = ScoreboardSettings.items.left_team_text[1366] or {}
ScoreboardSettings.items.left_team_text[1366][768] = ScoreboardSettings.items.left_team_text[1366][768] or {
	texture_disabled = "selected_item_bgr_right_1920",
	padding_left = 0,
	padding_right = 0,
	font_size = 22,
	padding_top = 0,
	texture_alignment = "left",
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
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
	},
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	texture_offset_x = -118 * SCALE_1366
}
ScoreboardSettings.items.right_team_text = ScoreboardSettings.items.right_team_text or {}
ScoreboardSettings.items.right_team_text[1366] = ScoreboardSettings.items.right_team_text[1366] or {}
ScoreboardSettings.items.right_team_text[1366][768] = ScoreboardSettings.items.right_team_text[1366][768] or {
	texture_disabled = "selected_item_bgr_left_1920",
	padding_left = 0,
	padding_right = 0,
	font_size = 22,
	padding_top = 0,
	texture_alignment = "right",
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
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
	},
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	texture_offset_x = 118 * SCALE_1366
}
ScoreboardSettings.items.team_score = ScoreboardSettings.items.team_score or {}
ScoreboardSettings.items.team_score[1366] = ScoreboardSettings.items.team_score[1366] or {}
ScoreboardSettings.items.team_score[1366][768] = ScoreboardSettings.items.team_score[1366][768] or {
	font_size = 70,
	padding_top = 0,
	padding_right = 0,
	padding_left = 0,
	font = MenuSettings.fonts.font_gradient_100,
	line_height = 60 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		0
	},
	padding_bottom = 8 * SCALE_1366
}
ScoreboardSettings.items.team_num_members = ScoreboardSettings.items.team_num_members or {}
ScoreboardSettings.items.team_num_members[1366] = ScoreboardSettings.items.team_num_members[1366] or {}
ScoreboardSettings.items.team_num_members[1366][768] = ScoreboardSettings.items.team_num_members[1366][768] or {
	font_size = 22,
	padding_left = 0,
	padding_right = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
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
	},
	padding_top = 14 * SCALE_1366
}
ScoreboardSettings.items.players_header = ScoreboardSettings.items.players_header or {}
ScoreboardSettings.items.players_header[1366] = ScoreboardSettings.items.players_header[1366] or {}
ScoreboardSettings.items.players_header[1366][768] = ScoreboardSettings.items.players_header[1366][768] or {
	line_height = 0,
	font_size = 22,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_22,
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
	},
	padding_bottom = -16 * SCALE_1366
}
ScoreboardSettings.items.players_header_bgr_texture_left = ScoreboardSettings.items.players_header_bgr_texture_left or {}
ScoreboardSettings.items.players_header_bgr_texture_left[1366] = ScoreboardSettings.items.players_header_bgr_texture_left[1366] or {}
ScoreboardSettings.items.players_header_bgr_texture_left[1366][768] = ScoreboardSettings.items.players_header_bgr_texture_left[1366][768] or {
	font_size = 22,
	texture_alignment = "right",
	texture_disabled = "scoreboard_header_bgr_left_1366",
	padding_left = 0,
	texture_offset_x = 19,
	padding_top = 0,
	texture_disabled_width = 500,
	line_height = 0,
	texture_disabled_height = 28,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_22,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	padding_bottom = -16 * SCALE_1366
}
ScoreboardSettings.items.players_header_bgr_texture_right = ScoreboardSettings.items.players_header_bgr_texture_right or {}
ScoreboardSettings.items.players_header_bgr_texture_right[1366] = ScoreboardSettings.items.players_header_bgr_texture_right[1366] or {}
ScoreboardSettings.items.players_header_bgr_texture_right[1366][768] = ScoreboardSettings.items.players_header_bgr_texture_right[1366][768] or {
	font_size = 22,
	texture_alignment = "left",
	texture_disabled = "scoreboard_header_bgr_right_1366",
	padding_left = 0,
	texture_offset_x = -43,
	padding_top = 0,
	texture_disabled_width = 500,
	line_height = 0,
	texture_disabled_height = 28,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_22,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	padding_bottom = -16 * SCALE_1366
}
ScoreboardSettings.items.player_left = ScoreboardSettings.items.player_left or {}
ScoreboardSettings.items.player_left[1366] = ScoreboardSettings.items.player_left[1366] or {}
ScoreboardSettings.items.player_left[1366][768] = ScoreboardSettings.items.player_left[1366][768] or {
	texture_status_knocked_down = "knocked_down_1920",
	texture_highlighted = "scoreboard_bgr_highlighted_left_1366",
	texture_highlighted_height = 28,
	font_size = 22,
	texture_status_wounded = "wounded_1920",
	texture_status_offset_y = 0,
	texture_status_dead = "dead_1920",
	texture_coat_of_arms_dummy = "small_coat_of_arms_dummy",
	texture_highlighted_align = "right",
	texture_highlighted_width = 500,
	font = MenuSettings.fonts.hell_shark_22,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_offset_y = 8 * SCALE_1366,
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
	column_width = {
		43,
		206,
		70,
		43,
		71,
		57
	},
	texture_highlighted_color = {
		100,
		255,
		255,
		255
	},
	texture_coat_of_arms_dummy_offset_x = 20 * SCALE_1366,
	texture_coat_of_arms_dummy_offset_y = 5 * SCALE_1366,
	texture_coat_of_arms_dummy_width = 16 * SCALE_1366,
	texture_coat_of_arms_dummy_height = 24 * SCALE_1366,
	texture_status_width = 40 * SCALE_1366,
	texture_status_height = 40 * SCALE_1366,
	texture_status_offset_x = 10 * SCALE_1366
}
ScoreboardSettings.items.player_right = ScoreboardSettings.items.player_right or {}
ScoreboardSettings.items.player_right[1366] = ScoreboardSettings.items.player_right[1366] or {}
ScoreboardSettings.items.player_right[1366][768] = ScoreboardSettings.items.player_right[1366][768] or table.clone(ScoreboardSettings.items.player_left[1366][768])
ScoreboardSettings.items.player_right[1366][768].texture_highlighted = "scoreboard_bgr_highlighted_right_1366"
ScoreboardSettings.items.player_right[1366][768].texture_highlighted_align = "left"
ScoreboardSettings.items.players_scroll_bar = ScoreboardSettings.items.players_scroll_bar or {}
ScoreboardSettings.items.players_scroll_bar[1366] = ScoreboardSettings.items.players_scroll_bar[1366] or {}
ScoreboardSettings.items.players_scroll_bar[1366][768] = ScoreboardSettings.items.players_scroll_bar[1366][768] or {
	scroll_bar_handle_width = 6,
	width = 12,
	scroll_bar_width = 2,
	scroll_bar_handle_color = {
		255,
		215,
		215,
		215
	},
	scroll_bar_color = {
		255,
		130,
		130,
		130
	},
	background_color = {
		0,
		50,
		50,
		50
	}
}
ScoreboardSettings.items.player_details_stat = ScoreboardSettings.items.player_details_stat or {}
ScoreboardSettings.items.player_details_stat[1366] = ScoreboardSettings.items.player_details_stat[1366] or {}
ScoreboardSettings.items.player_details_stat[1366][768] = ScoreboardSettings.items.player_details_stat[1366][768] or {
	line_height = 0,
	padding_top = 0,
	font_size = 20,
	padding_left = 0,
	font = MenuSettings.fonts.hell_shark_20,
	color_disabled = {
		255,
		200,
		0,
		0
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
	},
	padding_bottom = -16 * SCALE_1366,
	padding_right = 10 * SCALE_1366
}
ScoreboardSettings.items.player_details_stat_score = ScoreboardSettings.items.player_details_stat_score or {}
ScoreboardSettings.items.player_details_stat_score[1366] = ScoreboardSettings.items.player_details_stat_score[1366] or {}
ScoreboardSettings.items.player_details_stat_score[1366][768] = ScoreboardSettings.items.player_details_stat_score[1366][768] or {
	font_size = 26,
	padding_top = 0,
	padding_left = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.wotr_hud_text_26,
	line_height = 26 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		0
	},
	padding_right = 40 * SCALE_1366
}
ScoreboardSettings.items.player_details_delimiter = ScoreboardSettings.items.player_details_delimiter or {}
ScoreboardSettings.items.player_details_delimiter[1366] = ScoreboardSettings.items.player_details_delimiter[1366] or {}
ScoreboardSettings.items.player_details_delimiter[1366][768] = ScoreboardSettings.items.player_details_delimiter[1366][768] or {
	texture = "tab_gradient_1920",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	texture_width = 1550 * SCALE_1366,
	texture_height = 4 * SCALE_1366,
	color = {
		255,
		255,
		0,
		0
	}
}
ScoreboardSettings.items.player_details_coat_of_arms = ScoreboardSettings.items.player_details_coat_of_arms or {}
ScoreboardSettings.items.player_details_coat_of_arms[1366] = ScoreboardSettings.items.player_details_coat_of_arms[1366] or {}
ScoreboardSettings.items.player_details_coat_of_arms[1366][768] = ScoreboardSettings.items.player_details_coat_of_arms[1366][768] or {
	texture = "big_coat_of_arms_dummy",
	padding_top = 0,
	texture_width = 264 * SCALE_1366,
	texture_height = 240 * SCALE_1366,
	padding_bottom = -170 * SCALE_1366,
	padding_left = 10 * SCALE_1366,
	padding_right = 10 * SCALE_1366
}
