-- chunkname: @scripts/menu/menu_definitions/battle_report_page_settings_1366.lua

BattleReportSettings = BattleReportSettings or {}
BattleReportSettings.items = BattleReportSettings.items or {}
BattleReportSettings.pages = BattleReportSettings.pages or {}
SCALE_1366 = 0.7114583333333333
BattleReportSettings.items.header = BattleReportSettings.items.header or {}
BattleReportSettings.items.header[1366] = BattleReportSettings.items.header[1366] or {}
BattleReportSettings.items.header[1366][768] = BattleReportSettings.items.header[1366][768] or {
	font_size = 26,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_26,
	line_height = 22 * SCALE_1366,
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
BattleReportSettings.items.header_delimiter_top = BattleReportSettings.items.header_delimiter_top or {}
BattleReportSettings.items.header_delimiter_top[1366] = BattleReportSettings.items.header_delimiter_top[1366] or {}
BattleReportSettings.items.header_delimiter_top[1366][768] = BattleReportSettings.items.header_delimiter_top[1366][768] or {
	texture = "item_list_top_horizontal_line_1920",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	texture_width = 1000 * SCALE_1366,
	texture_height = 12 * SCALE_1366,
	color = {
		255,
		200,
		200,
		200
	}
}
BattleReportSettings.items.header_delimiter_bottom = BattleReportSettings.items.header_delimiter_bottom or {}
BattleReportSettings.items.header_delimiter_bottom[1366] = BattleReportSettings.items.header_delimiter_bottom[1366] or {}
BattleReportSettings.items.header_delimiter_bottom[1366][768] = BattleReportSettings.items.header_delimiter_bottom[1366][768] or {
	texture = "item_list_bottom_horizontal_line_1920",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	texture_width = 1000 * SCALE_1366,
	texture_height = 12 * SCALE_1366,
	color = {
		255,
		200,
		200,
		200
	}
}
BattleReportSettings.items.countdown = BattleReportSettings.items.countdown or {}
BattleReportSettings.items.countdown[1366] = BattleReportSettings.items.countdown[1366] or {}
BattleReportSettings.items.countdown[1366][768] = BattleReportSettings.items.countdown[1366][768] or {
	texture_disabled = "countdown_background_1920",
	padding_left = 0,
	padding_right = 0,
	font_size = 16,
	padding_top = 0,
	texture_alignment = "center",
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_16,
	line_height = 14 * SCALE_1366,
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
	},
	texture_disabled_width = 508 * SCALE_1366,
	texture_disabled_height = 32 * SCALE_1366
}
BattleReportSettings.items.scoreboard_scroll_bar = BattleReportSettings.items.scoreboard_scroll_bar or {}
BattleReportSettings.items.scoreboard_scroll_bar[1366] = BattleReportSettings.items.scoreboard_scroll_bar[1366] or {}
BattleReportSettings.items.scoreboard_scroll_bar[1366][768] = BattleReportSettings.items.scoreboard_scroll_bar[1366][768] or {
	scroll_bar_handle_width = 6,
	width = 20,
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
BattleReportSettings.items.scoreboard_player = BattleReportSettings.items.scoreboard_player or {}
BattleReportSettings.items.scoreboard_player[1366] = BattleReportSettings.items.scoreboard_player[1366] or {}
BattleReportSettings.items.scoreboard_player[1366][768] = BattleReportSettings.items.scoreboard_player[1366][768] or {
	font_size = 13,
	texture_team_rose_red = "small_rose_red_1920",
	texture_team_rose_white = "small_rose_white_1920",
	texture_coat_of_arms_dummy = "small_coat_of_arms_dummy",
	font = MenuSettings.fonts.hell_shark_13,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_offset_x = 20 * SCALE_1366,
	text_offset_y = 10 * SCALE_1366,
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
		100 * SCALE_1366,
		100 * SCALE_1366,
		100 * SCALE_1366,
		600 * SCALE_1366,
		100 * SCALE_1366,
		100 * SCALE_1366,
		100 * SCALE_1366,
		100 * SCALE_1366,
		100 * SCALE_1366
	},
	texture_coat_of_arms_dummy_offset_y = 5 * SCALE_1366,
	texture_coat_of_arms_dummy_width = 16 * SCALE_1366,
	texture_coat_of_arms_dummy_height = 24 * SCALE_1366,
	texture_team_rose_offset_y = 2 * SCALE_1366,
	texture_team_rose_width = 32 * SCALE_1366,
	texture_team_rose_height = 32 * SCALE_1366,
	background_color_highlighted = {
		100,
		200,
		200,
		200
	}
}
BattleReportSettings.items.scoreboard_header_text = BattleReportSettings.items.scoreboard_header_text or {}
BattleReportSettings.items.scoreboard_header_text[1366] = BattleReportSettings.items.scoreboard_header_text[1366] or {}
BattleReportSettings.items.scoreboard_header_text[1366][768] = BattleReportSettings.items.scoreboard_header_text[1366][768] or {
	font_size = 13,
	texture_sort_offset_z = 1,
	text_offset_z = 1,
	rect_delimiter_offset_y = 0,
	rect_delimiter_offset_z = 1,
	rect_delimiter_offset_x = -2,
	texture_sort_asc = "sort_ascending",
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending",
	font = MenuSettings.fonts.hell_shark_13,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_offset_x = 16 * SCALE_1366,
	text_offset_y = 10 * SCALE_1366,
	rect_delimiter_color = {
		0,
		0,
		0,
		0
	},
	rect_delimiter_height = 32 * SCALE_1366,
	texture_sort_width = 16 * SCALE_1366,
	texture_sort_height = 12 * SCALE_1366,
	texture_sort_offset_x = -26 * SCALE_1366,
	texture_sort_offset_y = 10 * SCALE_1366,
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
BattleReportSettings.items.scoreboard_header_delimiter = BattleReportSettings.items.scoreboard_header_delimiter or {}
BattleReportSettings.items.scoreboard_header_delimiter[1366] = BattleReportSettings.items.scoreboard_header_delimiter[1366] or {}
BattleReportSettings.items.scoreboard_header_delimiter[1366][768] = BattleReportSettings.items.scoreboard_header_delimiter[1366][768] or {
	texture = "tab_gradient_1920",
	padding_top = 0,
	padding_right = 0,
	padding_left = 0,
	texture_width = 1550 * SCALE_1366,
	texture_height = 4 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
	},
	padding_bottom = -2 * SCALE_1366
}
BattleReportSettings.items.summary = BattleReportSettings.items.summary or {}
BattleReportSettings.items.summary[1366] = BattleReportSettings.items.summary[1366] or {}
BattleReportSettings.items.summary[1366][768] = BattleReportSettings.items.summary[1366][768] or {
	font_size = 13,
	font = MenuSettings.fonts.hell_shark_13,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_offset_x = 16 * SCALE_1366,
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
		440 * SCALE_1366,
		160 * SCALE_1366,
		160 * SCALE_1366,
		160 * SCALE_1366,
		480 * SCALE_1366
	}
}
BattleReportSettings.items.summary_demo = BattleReportSettings.items.summary_demo or {}
BattleReportSettings.items.summary_demo[1366] = BattleReportSettings.items.summary_demo[1366] or {}
BattleReportSettings.items.summary_demo[1366][768] = BattleReportSettings.items.summary_demo[1366][768] or table.clone(BattleReportSettings.items.summary[1366][768])
BattleReportSettings.items.summary_demo[1366][768].text_color = {
	255,
	255,
	255,
	0
}
BattleReportSettings.items.summary_total = BattleReportSettings.items.summary_total or {}
BattleReportSettings.items.summary_total[1366] = BattleReportSettings.items.summary_total[1366] or {}
BattleReportSettings.items.summary_total[1366][768] = BattleReportSettings.items.summary_total[1366][768] or {
	font_size = 13,
	font = MenuSettings.fonts.hell_shark_13,
	text_color = {
		255,
		0,
		0,
		0
	},
	text_offset_x = 16 * SCALE_1366,
	text_offset_y = 8 * SCALE_1366,
	drop_shadow_color = {
		120,
		255,
		255,
		255
	},
	drop_shadow_offset = {
		2,
		-2
	},
	background_color = {
		255,
		170,
		170,
		170
	},
	column_width = {
		440 * SCALE_1366,
		160 * SCALE_1366,
		160 * SCALE_1366,
		160 * SCALE_1366,
		480 * SCALE_1366
	}
}
BattleReportSettings.items.xp_progress_bar = BattleReportSettings.items.xp_progress_bar or {}
BattleReportSettings.items.xp_progress_bar[1366] = BattleReportSettings.items.xp_progress_bar[1366] or {}
BattleReportSettings.items.xp_progress_bar[1366][768] = BattleReportSettings.items.xp_progress_bar[1366][768] or table.clone(CharacterSheetSettings.items.xp_progress_bar[1366][768])
BattleReportSettings.items.xp_progress_bar[1366][768].left_aligned = true
BattleReportSettings.items.summary_award = BattleReportSettings.items.summary_award or {}
BattleReportSettings.items.summary_award[1366] = BattleReportSettings.items.summary_award[1366] or {}
BattleReportSettings.items.summary_award[1366][768] = BattleReportSettings.items.summary_award[1366][768] or {
	name_text_offset_y = -10,
	font_size = 11,
	amount_text_offset_y = 2,
	name_text_max_width = 96,
	amount_text_offset_x = -2,
	texture_atlas_name = "prizes_medals_unlocks_atlas",
	texture_width = 128 * SCALE_1366,
	texture_height = 128 * SCALE_1366,
	texture_atlas_settings = PrizesMedalsUnlocksAtlas,
	font = MenuSettings.fonts.hell_shark_11,
	amount_text_color = {
		255,
		255,
		255,
		255
	},
	amount_text_shadow_color = {
		255,
		100,
		100,
		100
	},
	amount_text_shadow_offset = {
		1,
		-1
	},
	amount_rect_color = {
		255,
		0,
		0,
		0
	},
	name_text_color = {
		255,
		255,
		255,
		255
	}
}
BattleReportSettings.items.summary_award_tooltip = BattleReportSettings.items.summary_award_tooltip or {}
BattleReportSettings.items.summary_award_tooltip[1366] = BattleReportSettings.items.summary_award_tooltip[1366] or {}
BattleReportSettings.items.summary_award_tooltip[1366][768] = BattleReportSettings.items.summary_award_tooltip[1366][768] or table.clone(MainMenuSettings.items.floating_tooltip[1366][768])
BattleReportSettings.pages.base = BattleReportSettings.pages.base or {}
BattleReportSettings.pages.base[1366] = BattleReportSettings.pages.base[1366] or {}
BattleReportSettings.pages.base[1366][768] = BattleReportSettings.pages.base[1366][768] or {
	header_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = 480 * SCALE_1366,
		items = {
			columns = {
				{
					align = "center"
				}
			},
			rows = {
				{
					align = "center",
					height = 12 * SCALE_1366
				},
				{
					align = "center",
					height = 34 * SCALE_1366
				},
				{
					align = "center",
					height = 12 * SCALE_1366
				},
				{
					align = "center",
					height = 44 * SCALE_1366
				}
			}
		}
	},
	page_links = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "right",
		number_of_columns = 2,
		screen_align_x = "center",
		pivot_offset_x = 710 * SCALE_1366,
		pivot_offset_y = -420 * SCALE_1366,
		column_alignment = {
			"right"
		}
	},
	background_rect = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "center",
		screen_align_x = "center",
		pivot_offset_y = 0,
		absolute_width = 1570 * SCALE_1366,
		absolute_height = 1000 * SCALE_1366,
		color = {
			240,
			50,
			50,
			50
		}
	},
	corner_texture_top_left = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture = "item_list_top_corner_right_1920",
		screen_align_x = "center",
		pivot_offset_x = -790 * SCALE_1366,
		pivot_offset_y = 500 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	},
	corner_texture_top_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture = "item_list_top_corner_1920",
		screen_align_x = "center",
		pivot_offset_x = 790 * SCALE_1366,
		pivot_offset_y = 500 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	},
	corner_texture_bottom_left = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture = "item_list_bottom_corner_right_1920",
		screen_align_x = "center",
		pivot_offset_x = -790 * SCALE_1366,
		pivot_offset_y = -500 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	},
	corner_texture_bottom_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture = "item_list_bottom_corner_1920",
		screen_align_x = "center",
		pivot_offset_x = 790 * SCALE_1366,
		pivot_offset_y = -500 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	},
	horizontal_line_texture_top = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		texture = "item_list_top_horizontal_line_1920",
		pivot_offset_y = 500 * SCALE_1366,
		texture_width = 1000 * SCALE_1366,
		texture_height = 12 * SCALE_1366
	},
	horizontal_line_texture_bottom = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "top",
		screen_align_x = "center",
		texture = "item_list_bottom_horizontal_line_1920",
		pivot_offset_y = -500 * SCALE_1366,
		texture_width = 1000 * SCALE_1366,
		texture_height = 12 * SCALE_1366
	},
	background_level_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "loading_screen_background",
		pivot_offset_y = 0,
		screen_align_x = "left",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_width = 804 * SCALE_1366,
		texture_height = 452 * SCALE_1366
	}
}
BattleReportSettings.pages.scoreboard = BattleReportSettings.pages.scoreboard or {}
BattleReportSettings.pages.scoreboard[1366] = BattleReportSettings.pages.scoreboard[1366] or {}
BattleReportSettings.pages.scoreboard[1366][768] = BattleReportSettings.pages.scoreboard[1366][768] or table.clone(BattleReportSettings.pages.base[1366][768])
BattleReportSettings.pages.scoreboard[1366][768].scoreboard = BattleReportSettings.pages.scoreboard[1366][768].scoreboard or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	screen_offset_y = 0,
	pivot_align_x = "left",
	number_of_visible_rows = 12,
	screen_align_x = "center",
	pivot_offset_x = -700 * SCALE_1366,
	pivot_offset_y = 144 * SCALE_1366,
	rect_background_color = {
		255,
		30,
		30,
		30
	},
	background_min_height = 420 * SCALE_1366,
	headers = {
		columns = {
			{
				align = "left",
				width = 900 * SCALE_1366
			},
			{
				align = "left",
				width = 100 * SCALE_1366
			},
			{
				align = "left",
				width = 100 * SCALE_1366
			},
			{
				align = "left",
				width = 100 * SCALE_1366
			},
			{
				align = "left",
				width = 100 * SCALE_1366
			},
			{
				align = "left",
				width = 100 * SCALE_1366
			}
		},
		rows = {
			{
				align = "bottom",
				height = 1
			},
			{
				align = "center",
				height = 32 * SCALE_1366
			},
			{
				align = "bottom",
				height = 1
			}
		}
	},
	items = {
		columns = {
			{
				align = "left",
				width = 1400 * SCALE_1366
			}
		},
		rows = {
			{
				align = "bottom",
				height = 35 * SCALE_1366,
				odd_color = {
					255,
					40,
					40,
					40
				},
				even_color = {
					255,
					65,
					65,
					65
				}
			}
		}
	},
	scroll_bar = {
		offset_z = 10,
		align = "right"
	}
}
BattleReportSettings.pages.scoreboard[1366][768].player_details = table.clone(ScoreboardSettings.pages.main_page[1366][768].player_details)
BattleReportSettings.pages.scoreboard[1366][768].player_details.pivot_offset_y = -70 * SCALE_1366
BattleReportSettings.pages.scoreboard[1366][768].button_info = {
	text_data = {
		font_size = 16,
		font = MenuSettings.fonts.hell_shark_16,
		offset_x = 25 * SCALE_1366,
		offset_y = 85 * SCALE_1366,
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
			button_name = "a",
			text = "menu_summary"
		}
	}
}
BattleReportSettings.pages.summary = BattleReportSettings.pages.summary or {}
BattleReportSettings.pages.summary[1366] = BattleReportSettings.pages.summary[1366] or {}
BattleReportSettings.pages.summary[1366][768] = BattleReportSettings.pages.summary[1366][768] or table.clone(BattleReportSettings.pages.base[1366][768])
BattleReportSettings.pages.summary[1366][768].summary_list = BattleReportSettings.pages.summary[1366][768].summary_list or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	screen_offset_y = 0,
	pivot_align_x = "left",
	screen_align_x = "center",
	pivot_offset_x = -700 * SCALE_1366,
	pivot_offset_y = 18 * SCALE_1366,
	headers = {
		columns = {
			{
				width = 0,
				align = "left"
			},
			{
				align = "left",
				width = 440 * SCALE_1366
			},
			{
				align = "left",
				width = 160 * SCALE_1366
			},
			{
				align = "left",
				width = 160 * SCALE_1366
			},
			{
				align = "left",
				width = 360 * SCALE_1366
			},
			{
				align = "left",
				width = 280 * SCALE_1366
			}
		},
		rows = {
			{
				align = "bottom",
				height = 1
			},
			{
				align = "center",
				height = 32 * SCALE_1366
			},
			{
				align = "bottom",
				height = 1
			}
		}
	},
	items = {
		columns = {
			{
				align = "left",
				width = 1400 * SCALE_1366
			}
		},
		rows = {
			{
				align = "bottom",
				height = 32 * SCALE_1366,
				odd_color = {
					255,
					40,
					40,
					40
				},
				even_color = {
					255,
					65,
					65,
					65
				}
			}
		}
	},
	scroll_bar = {
		offset_z = 10,
		align = "right"
	}
}
BattleReportSettings.pages.summary[1366][768].button_info = {
	text_data = {
		font_size = 16,
		font = MenuSettings.fonts.hell_shark_16,
		offset_x = 180 * SCALE_1366,
		offset_y = 85 * SCALE_1366,
		drop_shadow = {
			1,
			-1
		}
	},
	default_buttons = {
		{
			button_name = "x",
			text = "menu_scoreboard"
		},
		{
			button_name = "a",
			text = "menu_close"
		}
	}
}
BattleReportSettings.pages.summary[1366][768].award_list = BattleReportSettings.pages.summary[1366][768].award_list or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	screen_offset_y = 0,
	pivot_align_x = "left",
	number_of_visible_rows = 4,
	screen_align_x = "center",
	pivot_offset_x = 270 * SCALE_1366,
	pivot_offset_y = 17 * SCALE_1366,
	rect_background_color = {
		255,
		0,
		0,
		0
	},
	background_min_height = 640 * SCALE_1366,
	items = {
		columns = {
			{
				align = "center",
				width = 150 * SCALE_1366
			},
			{
				align = "center",
				width = 130 * SCALE_1366
			},
			{
				align = "center",
				width = 150 * SCALE_1366
			}
		},
		rows = {
			{
				align = "center",
				height = 158 * SCALE_1366
			}
		}
	},
	scroll_bar = {
		offset_z = 10,
		align = "right"
	}
}
BattleReportSettings.pages.summary[1366][768].xp_progress_bar = BattleReportSettings.pages.summary[1366][768].xp_progress_bar or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	screen_offset_y = 0,
	pivot_align_x = "left",
	number_of_columns = 1,
	screen_align_x = "center",
	pivot_offset_x = -690 * SCALE_1366,
	pivot_offset_y = -380 * SCALE_1366,
	column_alignment = {
		"center"
	}
}
