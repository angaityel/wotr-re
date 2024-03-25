-- chunkname: @scripts/menu/menu_definitions/battle_report_page_settings_1920.lua

BattleReportSettings = BattleReportSettings or {}
BattleReportSettings.items = BattleReportSettings.items or {}
BattleReportSettings.pages = BattleReportSettings.pages or {}
BattleReportSettings.items.header = BattleReportSettings.items.header or {}
BattleReportSettings.items.header[1680] = BattleReportSettings.items.header[1680] or {}
BattleReportSettings.items.header[1680][1050] = BattleReportSettings.items.header[1680][1050] or {
	line_height = 22,
	padding_left = 0,
	font_size = 36,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_36,
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
BattleReportSettings.items.header_delimiter_top[1680] = BattleReportSettings.items.header_delimiter_top[1680] or {}
BattleReportSettings.items.header_delimiter_top[1680][1050] = BattleReportSettings.items.header_delimiter_top[1680][1050] or {
	texture = "item_list_top_horizontal_line_1920",
	padding_bottom = 0,
	texture_width = 1000,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_height = 12,
	color = {
		255,
		200,
		200,
		200
	}
}
BattleReportSettings.items.header_delimiter_bottom = BattleReportSettings.items.header_delimiter_bottom or {}
BattleReportSettings.items.header_delimiter_bottom[1680] = BattleReportSettings.items.header_delimiter_bottom[1680] or {}
BattleReportSettings.items.header_delimiter_bottom[1680][1050] = BattleReportSettings.items.header_delimiter_bottom[1680][1050] or {
	texture = "item_list_bottom_horizontal_line_1920",
	padding_bottom = 0,
	texture_width = 1000,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_height = 12,
	color = {
		255,
		200,
		200,
		200
	}
}
BattleReportSettings.items.countdown = BattleReportSettings.items.countdown or {}
BattleReportSettings.items.countdown[1680] = BattleReportSettings.items.countdown[1680] or {}
BattleReportSettings.items.countdown[1680][1050] = BattleReportSettings.items.countdown[1680][1050] or {
	texture_alignment = "center",
	texture_disabled = "countdown_background_1920",
	padding_left = 0,
	font_size = 22,
	padding_top = 0,
	texture_disabled_width = 508,
	padding_bottom = 0,
	line_height = 14,
	texture_disabled_height = 32,
	padding_right = 0,
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
BattleReportSettings.items.scoreboard_scroll_bar = BattleReportSettings.items.scoreboard_scroll_bar or {}
BattleReportSettings.items.scoreboard_scroll_bar[1680] = BattleReportSettings.items.scoreboard_scroll_bar[1680] or {}
BattleReportSettings.items.scoreboard_scroll_bar[1680][1050] = BattleReportSettings.items.scoreboard_scroll_bar[1680][1050] or {
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
BattleReportSettings.items.scoreboard_player[1680] = BattleReportSettings.items.scoreboard_player[1680] or {}
BattleReportSettings.items.scoreboard_player[1680][1050] = BattleReportSettings.items.scoreboard_player[1680][1050] or {
	texture_team_rose_offset_y = 2,
	texture_coat_of_arms_dummy_width = 16,
	texture_team_rose_height = 32,
	font_size = 18,
	texture_team_rose_red = "small_rose_red_1920",
	text_offset_y = 10,
	texture_team_rose_width = 32,
	texture_coat_of_arms_dummy_height = 24,
	texture_coat_of_arms_dummy_offset_y = 5,
	texture_coat_of_arms_dummy = "small_coat_of_arms_dummy",
	texture_team_rose_white = "small_rose_white_1920",
	text_offset_x = 20,
	font = MenuSettings.fonts.hell_shark_18,
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
	},
	column_width = {
		100,
		100,
		100,
		600,
		100,
		100,
		100,
		100,
		100
	},
	background_color_highlighted = {
		100,
		200,
		200,
		200
	}
}
BattleReportSettings.items.scoreboard_header_text = BattleReportSettings.items.scoreboard_header_text or {}
BattleReportSettings.items.scoreboard_header_text[1680] = BattleReportSettings.items.scoreboard_header_text[1680] or {}
BattleReportSettings.items.scoreboard_header_text[1680][1050] = BattleReportSettings.items.scoreboard_header_text[1680][1050] or {
	font_size = 18,
	texture_sort_offset_x = -26,
	texture_sort_width = 16,
	text_offset_z = 1,
	rect_delimiter_offset_y = 0,
	text_offset_y = 10,
	rect_delimiter_offset_z = 1,
	texture_sort_offset_y = 10,
	rect_delimiter_width = 2,
	texture_sort_height = 12,
	rect_delimiter_offset_x = -2,
	texture_sort_asc = "sort_ascending",
	rect_delimiter_height = 32,
	texture_sort_desc = "sort_descending",
	texture_sort_offset_z = 1,
	text_offset_x = 16,
	font = MenuSettings.fonts.hell_shark_18,
	text_color = {
		255,
		255,
		255,
		255
	},
	rect_delimiter_color = {
		0,
		0,
		0,
		0
	},
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
BattleReportSettings.items.scoreboard_header_delimiter = BattleReportSettings.items.scoreboard_header_delimiter or {}
BattleReportSettings.items.scoreboard_header_delimiter[1680] = BattleReportSettings.items.scoreboard_header_delimiter[1680] or {}
BattleReportSettings.items.scoreboard_header_delimiter[1680][1050] = BattleReportSettings.items.scoreboard_header_delimiter[1680][1050] or {
	texture = "tab_gradient_1920",
	padding_bottom = -2,
	texture_width = 1550,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_height = 4,
	color = {
		255,
		255,
		255,
		255
	}
}
BattleReportSettings.items.summary = BattleReportSettings.items.summary or {}
BattleReportSettings.items.summary[1680] = BattleReportSettings.items.summary[1680] or {}
BattleReportSettings.items.summary[1680][1050] = BattleReportSettings.items.summary[1680][1050] or {
	font_size = 18,
	text_offset_y = 8,
	text_offset_x = 16,
	font = MenuSettings.fonts.hell_shark_18,
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
	},
	column_width = {
		440,
		160,
		160,
		160,
		480
	}
}
BattleReportSettings.items.summary_demo = BattleReportSettings.items.summary_demo or {}
BattleReportSettings.items.summary_demo[1680] = BattleReportSettings.items.summary_demo[1680] or {}
BattleReportSettings.items.summary_demo[1680][1050] = BattleReportSettings.items.summary_demo[1680][1050] or table.clone(BattleReportSettings.items.summary[1680][1050])
BattleReportSettings.items.summary_demo[1680][1050].text_color = {
	255,
	255,
	255,
	0
}
BattleReportSettings.items.summary_total = BattleReportSettings.items.summary_total or {}
BattleReportSettings.items.summary_total[1680] = BattleReportSettings.items.summary_total[1680] or {}
BattleReportSettings.items.summary_total[1680][1050] = BattleReportSettings.items.summary_total[1680][1050] or {
	font_size = 18,
	text_offset_y = 8,
	text_offset_x = 16,
	font = MenuSettings.fonts.hell_shark_18,
	text_color = {
		255,
		0,
		0,
		0
	},
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
		440,
		160,
		160,
		160,
		480
	}
}
BattleReportSettings.items.xp_progress_bar = BattleReportSettings.items.xp_progress_bar or {}
BattleReportSettings.items.xp_progress_bar[1680] = BattleReportSettings.items.xp_progress_bar[1680] or {}
BattleReportSettings.items.xp_progress_bar[1680][1050] = BattleReportSettings.items.xp_progress_bar[1680][1050] or table.clone(CharacterSheetSettings.items.xp_progress_bar[1680][1050])
BattleReportSettings.items.xp_progress_bar[1680][1050].left_aligned = true
BattleReportSettings.items.summary_award = BattleReportSettings.items.summary_award or {}
BattleReportSettings.items.summary_award[1680] = BattleReportSettings.items.summary_award[1680] or {}
BattleReportSettings.items.summary_award[1680][1050] = BattleReportSettings.items.summary_award[1680][1050] or {
	name_text_offset_y = -14,
	amount_text_offset_x = -3,
	amount_text_offset_y = 3,
	texture_width = 128,
	font_size = 16,
	texture_atlas_name = "prizes_medals_unlocks_atlas",
	name_text_max_width = 134,
	texture_height = 128,
	texture_atlas_settings = PrizesMedalsUnlocksAtlas,
	font = MenuSettings.fonts.hell_shark_16,
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
BattleReportSettings.items.summary_award_tooltip[1680] = BattleReportSettings.items.summary_award_tooltip[1680] or {}
BattleReportSettings.items.summary_award_tooltip[1680][1050] = BattleReportSettings.items.summary_award_tooltip[1680][1050] or table.clone(MainMenuSettings.items.floating_tooltip[1680][1050])
BattleReportSettings.pages.base = BattleReportSettings.pages.base or {}
BattleReportSettings.pages.base[1680] = BattleReportSettings.pages.base[1680] or {}
BattleReportSettings.pages.base[1680][1050] = BattleReportSettings.pages.base[1680][1050] or {
	header_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = 480,
		items = {
			columns = {
				{
					align = "center"
				}
			},
			rows = {
				{
					align = "center",
					height = 12
				},
				{
					align = "center",
					height = 34
				},
				{
					align = "center",
					height = 12
				},
				{
					align = "center",
					height = 44
				}
			}
		}
	},
	page_links = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		pivot_offset_y = -420,
		screen_align_x = "center",
		number_of_columns = 2,
		pivot_offset_x = 710,
		screen_offset_y = 0,
		pivot_align_x = "right",
		column_alignment = {
			"right"
		}
	},
	background_rect = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		absolute_height = 1000,
		pivot_offset_y = 0,
		screen_align_x = "center",
		absolute_width = 1570,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
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
		texture = "item_list_top_corner_right_1920",
		pivot_offset_y = 500,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = -790,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 308
	},
	corner_texture_top_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		texture = "item_list_top_corner_1920",
		pivot_offset_y = 500,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = 790,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 308
	},
	corner_texture_bottom_left = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_bottom_corner_right_1920",
		pivot_offset_y = -500,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = -790,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 308
	},
	corner_texture_bottom_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_bottom_corner_1920",
		pivot_offset_y = -500,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = 790,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 308
	},
	horizontal_line_texture_top = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_top_horizontal_line_1920",
		pivot_offset_y = 500,
		texture_width = 1000,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_height = 12
	},
	horizontal_line_texture_bottom = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		texture = "item_list_bottom_horizontal_line_1920",
		pivot_offset_y = -500,
		texture_width = 1000,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_height = 12
	},
	background_level_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "loading_screen_background",
		pivot_offset_y = 0,
		texture_width = 804,
		screen_align_x = "left",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 452
	}
}
BattleReportSettings.pages.scoreboard = BattleReportSettings.pages.scoreboard or {}
BattleReportSettings.pages.scoreboard[1680] = BattleReportSettings.pages.scoreboard[1680] or {}
BattleReportSettings.pages.scoreboard[1680][1050] = BattleReportSettings.pages.scoreboard[1680][1050] or table.clone(BattleReportSettings.pages.base[1680][1050])
BattleReportSettings.pages.scoreboard[1680][1050].scoreboard = BattleReportSettings.pages.scoreboard[1680][1050].scoreboard or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	background_min_height = 420,
	pivot_offset_y = 144,
	screen_align_x = "center",
	number_of_visible_rows = 12,
	pivot_offset_x = -700,
	screen_offset_y = 0,
	pivot_align_x = "left",
	rect_background_color = {
		255,
		30,
		30,
		30
	},
	headers = {
		columns = {
			{
				width = 900,
				align = "left"
			},
			{
				width = 100,
				align = "left"
			},
			{
				width = 100,
				align = "left"
			},
			{
				width = 100,
				align = "left"
			},
			{
				width = 100,
				align = "left"
			},
			{
				width = 100,
				align = "left"
			}
		},
		rows = {
			{
				align = "bottom",
				height = 1
			},
			{
				align = "center",
				height = 32
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
				width = 1400,
				align = "left"
			}
		},
		rows = {
			{
				align = "bottom",
				height = 35,
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
BattleReportSettings.pages.scoreboard[1680][1050].player_details = table.clone(ScoreboardSettings.pages.main_page[1680][1050].player_details)
BattleReportSettings.pages.scoreboard[1680][1050].player_details.pivot_offset_y = -120
BattleReportSettings.pages.scoreboard[1680][1050].button_info = {
	text_data = {
		font_size = 28,
		font = MenuSettings.fonts.hell_shark_28,
		offset_x = 25 * SCALE_1366,
		offset_y = 85 * SCALE_1366,
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
			text = "menu_summary"
		}
	}
}
BattleReportSettings.pages.summary = BattleReportSettings.pages.summary or {}
BattleReportSettings.pages.summary[1680] = BattleReportSettings.pages.summary[1680] or {}
BattleReportSettings.pages.summary[1680][1050] = BattleReportSettings.pages.summary[1680][1050] or table.clone(BattleReportSettings.pages.base[1680][1050])
BattleReportSettings.pages.summary[1680][1050].summary_list = BattleReportSettings.pages.summary[1680][1050].summary_list or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_offset_x = -700,
	screen_offset_y = 0,
	pivot_align_x = "left",
	pivot_align_y = "center",
	screen_align_x = "center",
	pivot_offset_y = 18,
	headers = {
		columns = {
			{
				width = 0,
				align = "left"
			},
			{
				width = 440,
				align = "left"
			},
			{
				width = 160,
				align = "left"
			},
			{
				width = 160,
				align = "left"
			},
			{
				width = 360,
				align = "left"
			},
			{
				width = 280,
				align = "left"
			}
		},
		rows = {
			{
				align = "bottom",
				height = 1
			},
			{
				align = "center",
				height = 32
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
				width = 1400,
				align = "left"
			}
		},
		rows = {
			{
				align = "bottom",
				height = 32,
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
BattleReportSettings.pages.summary[1680][1050].button_info = {
	text_data = {
		font_size = 28,
		font = MenuSettings.fonts.hell_shark_28,
		offset_x = 180 * SCALE_1366,
		offset_y = 85 * SCALE_1366,
		drop_shadow = {
			2,
			-2
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
BattleReportSettings.pages.summary[1680][1050].award_list = BattleReportSettings.pages.summary[1680][1050].award_list or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	background_min_height = 640,
	pivot_offset_y = 17,
	screen_align_x = "center",
	number_of_visible_rows = 4,
	pivot_offset_x = 270,
	screen_offset_y = 0,
	pivot_align_x = "left",
	rect_background_color = {
		255,
		0,
		0,
		0
	},
	items = {
		columns = {
			{
				width = 150,
				align = "center"
			},
			{
				width = 130,
				align = "center"
			},
			{
				width = 150,
				align = "center"
			}
		},
		rows = {
			{
				align = "center",
				height = 158
			}
		}
	},
	scroll_bar = {
		offset_z = 10,
		align = "right"
	}
}
BattleReportSettings.pages.summary[1680][1050].xp_progress_bar = BattleReportSettings.pages.summary[1680][1050].xp_progress_bar or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	pivot_offset_y = -380,
	screen_align_x = "center",
	number_of_columns = 1,
	pivot_offset_x = -690,
	screen_offset_y = 0,
	pivot_align_x = "left",
	column_alignment = {
		"center"
	}
}
