-- chunkname: @scripts/menu/menu_definitions/character_sheet_page_settings_1366.lua

CharacterSheetSettings = CharacterSheetSettings or {}
CharacterSheetSettings.items = CharacterSheetSettings.items or {}
CharacterSheetSettings.pages = CharacterSheetSettings.pages or {}
SCALE_1366 = 0.7114583333333333
CharacterSheetSettings.items.ddl_closed_text = CharacterSheetSettings.items.ddl_closed_text or {}
CharacterSheetSettings.items.ddl_closed_text[1366] = CharacterSheetSettings.items.ddl_closed_text[1366] or {}
CharacterSheetSettings.items.ddl_closed_text[1366][768] = CharacterSheetSettings.items.ddl_closed_text[1366][768] or {
	texture_arrow_offset_x = -1,
	texture_alignment = "left",
	texture_arrow = "drop_down_list_arrow",
	padding_right = 0,
	font_size = 22,
	texture_background = "header_item_bgr_left_small_1920",
	font = MenuSettings.fonts.hell_shark_22,
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
		255,
		100,
		100,
		100
	},
	color_render_from_child_page = {
		80,
		0,
		0,
		0
	},
	texture_background_width = 476 * SCALE_1366,
	texture_background_height = 36 * SCALE_1366,
	texture_arrow_width = 20 * SCALE_1366,
	texture_arrow_height = 12 * SCALE_1366,
	texture_arrow_offset_y = -16 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 8 * SCALE_1366
}
CharacterSheetSettings.items.ddl_open_text = CharacterSheetSettings.items.ddl_open_text or {}
CharacterSheetSettings.items.ddl_open_text[1366] = CharacterSheetSettings.items.ddl_open_text[1366] or {}
CharacterSheetSettings.items.ddl_open_text[1366][768] = CharacterSheetSettings.items.ddl_open_text[1366][768] or {
	font_size = 22,
	texture_highlighted = "selected_item_bgr_left_1920",
	texture_alignment = "left",
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		0,
		0,
		0
	},
	color_highlighted = {
		255,
		255,
		255,
		255
	},
	color_disabled = {
		255,
		50,
		50,
		50
	},
	drop_shadow_color = {
		60,
		0,
		0,
		0
	},
	drop_shadow_color_disabled = {
		0,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	texture_highlighted_width = 652 * SCALE_1366,
	texture_highlighted_height = 36 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 20 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
CharacterSheetSettings.items.user_name = CharacterSheetSettings.items.user_name or {}
CharacterSheetSettings.items.user_name[1366] = CharacterSheetSettings.items.user_name[1366] or {}
CharacterSheetSettings.items.user_name[1366][768] = CharacterSheetSettings.items.user_name[1366][768] or {
	texture_alignment = "center",
	font_size = 22,
	padding_right = 0,
	padding_left = 0,
	texture_disabled = "selected_item_bgr_centered_1920",
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366
}
CharacterSheetSettings.pages.ddl = CharacterSheetSettings.pages.ddl or {}
CharacterSheetSettings.pages.ddl[1366] = CharacterSheetSettings.pages.ddl[1366] or {}
CharacterSheetSettings.pages.ddl[1366][768] = CharacterSheetSettings.pages.ddl[1366][768] or {
	drop_down_list = {
		texture_background = "ddl_background_left_1920",
		texture_background_align = "left",
		list_alignment = "left",
		offset_x = 22 * SCALE_1366,
		offset_y = -5 * SCALE_1366,
		texture_background_width = 568 * SCALE_1366,
		item_config = CharacterSheetSettings.items.ddl_open_text,
		items = {
			columns = {
				{
					align = "left",
					width = 568 * SCALE_1366
				}
			},
			rows = {
				{
					align = "bottom",
					height = 36 * SCALE_1366
				}
			}
		}
	}
}
CharacterSheetSettings.pages.character_sheet = CharacterSheetSettings.pages.character_sheet or {}
CharacterSheetSettings.pages.character_sheet[1366] = CharacterSheetSettings.pages.character_sheet[1366] or {}
CharacterSheetSettings.pages.character_sheet[1366][768] = CharacterSheetSettings.pages.character_sheet[1366][768] or {
	user_name = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = 440 * SCALE_1366
	},
	title_selection = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		screen_align_x = "center",
		pivot_offset_x = 40 * SCALE_1366,
		pivot_offset_y = 360 * SCALE_1366
	},
	character_selection = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		screen_align_x = "center",
		pivot_offset_x = -420 * SCALE_1366,
		pivot_offset_y = 360 * SCALE_1366
	},
	skill_header = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 3,
		screen_align_x = "center",
		pivot_offset_x = 40 * SCALE_1366,
		pivot_offset_y = 172 * SCALE_1366,
		column_width = {
			277,
			53,
			53
		},
		column_alignment = {
			"left",
			"center",
			"center"
		}
	},
	skill_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 6,
		screen_align_x = "center",
		pivot_offset_x = 40 * SCALE_1366,
		pivot_offset_y = 134 * SCALE_1366,
		column_width = {
			275 * SCALE_1366,
			4 * SCALE_1366,
			49 * SCALE_1366,
			4 * SCALE_1366,
			49 * SCALE_1366,
			4 * SCALE_1366
		},
		column_alignment = {
			"left",
			"left",
			"center",
			"left",
			"center",
			"left"
		}
	},
	weapon_header = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 5,
		screen_align_x = "center",
		pivot_offset_x = -420 * SCALE_1366,
		pivot_offset_y = 310 * SCALE_1366,
		column_width = {
			211 * SCALE_1366,
			43 * SCALE_1366,
			43 * SCALE_1366,
			43 * SCALE_1366,
			43 * SCALE_1366
		},
		column_alignment = {
			"left",
			"center",
			"center",
			"center",
			"center"
		}
	},
	weapon_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 10,
		screen_align_x = "center",
		pivot_offset_x = -420 * SCALE_1366,
		pivot_offset_y = 272 * SCALE_1366,
		column_width = {
			209 * SCALE_1366,
			4 * SCALE_1366,
			39 * SCALE_1366,
			4 * SCALE_1366,
			39 * SCALE_1366,
			4 * SCALE_1366,
			39 * SCALE_1366,
			4 * SCALE_1366,
			39 * SCALE_1366,
			4 * SCALE_1366
		},
		column_alignment = {
			"left",
			"left",
			"center",
			"left",
			"center",
			"left",
			"center",
			"left",
			"center",
			"left"
		}
	},
	armour_header = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 4,
		screen_align_x = "center",
		pivot_offset_x = 40 * SCALE_1366,
		pivot_offset_y = 310 * SCALE_1366,
		column_width = {
			254 * SCALE_1366,
			43 * SCALE_1366,
			43 * SCALE_1366,
			43 * SCALE_1366
		},
		column_alignment = {
			"left",
			"center",
			"center",
			"center"
		}
	},
	armour_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 8,
		screen_align_x = "center",
		pivot_offset_x = 40 * SCALE_1366,
		pivot_offset_y = 272 * SCALE_1366,
		column_width = {
			252 * SCALE_1366,
			4 * SCALE_1366,
			39 * SCALE_1366,
			4 * SCALE_1366,
			39 * SCALE_1366,
			4 * SCALE_1366,
			39 * SCALE_1366,
			4 * SCALE_1366
		},
		column_alignment = {
			"left",
			"left",
			"center",
			"left",
			"center",
			"left",
			"center",
			"left"
		}
	},
	modification_header = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 2,
		screen_align_x = "center",
		pivot_offset_x = -420 * SCALE_1366,
		pivot_offset_y = 100 * SCALE_1366,
		column_width = {
			340 * SCALE_1366,
			43 * SCALE_1366
		},
		column_alignment = {
			"left",
			"center"
		}
	},
	modification_items = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 4,
		screen_align_x = "center",
		pivot_offset_x = -420 * SCALE_1366,
		pivot_offset_y = 62 * SCALE_1366,
		column_width = {
			338 * SCALE_1366,
			4 * SCALE_1366,
			39 * SCALE_1366,
			4 * SCALE_1366
		},
		column_alignment = {
			"left",
			"left",
			"center",
			"left"
		}
	},
	xp_progress_bar = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		number_of_columns = 1,
		pivot_offset_y = -486 * SCALE_1366,
		column_alignment = {
			"center"
		}
	},
	split_delimiter_texture_top = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		texture = "split_delimitier_1920",
		pivot_offset_y = 485 * SCALE_1366,
		texture_width = 352 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		color = {
			70,
			255,
			255,
			255
		}
	},
	split_delimiter_texture_left = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture = "split_delimitier_1920",
		screen_align_x = "center",
		pivot_offset_x = -34 * SCALE_1366,
		pivot_offset_y = 340 * SCALE_1366,
		texture_width = 352 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		color = {
			70,
			255,
			255,
			255
		}
	},
	split_delimiter_texture_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture = "split_delimitier_1920",
		screen_align_x = "center",
		pivot_offset_x = 70 * SCALE_1366,
		pivot_offset_y = 340 * SCALE_1366,
		texture_width = 352 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		color = {
			70,
			255,
			255,
			255
		}
	},
	vertical_line_texture_left = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_vertical_line_right_1920",
		pivot_offset_y = 0,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_width = 16 * SCALE_1366,
		texture_height = 1016 * SCALE_1366,
		color = {
			100,
			255,
			255,
			255
		}
	},
	vertical_line_texture_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_vertical_line_1920",
		pivot_offset_y = 0,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_width = 16 * SCALE_1366,
		texture_height = 1016 * SCALE_1366,
		color = {
			100,
			255,
			255,
			255
		}
	},
	coat_of_arms_viewer = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		screen_align_x = "center",
		pivot_offset_x = 80 * SCALE_1366,
		pivot_offset_y = 150 * SCALE_1366,
		width = 270 * SCALE_1366,
		height = 280 * SCALE_1366
	},
	split_delimiter_texture_outer_left = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture = "split_delimitier_1920",
		screen_align_x = "center",
		pivot_offset_x = 30 * SCALE_1366,
		pivot_offset_y = 126 * SCALE_1366,
		texture_width = 352 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		color = {
			70,
			255,
			255,
			255
		}
	},
	perk_header = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		screen_align_x = "center",
		pivot_offset_x = 30 * SCALE_1366,
		pivot_offset_y = 80 * SCALE_1366
	},
	perks = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "top",
		screen_offset_y = 0,
		basic_header_font_size = 18,
		basic_text_font_size = 11,
		screen_align_x = "center",
		texture_atlas_name = "menu_atlas",
		specialized_2_header_font_size = 13,
		show_no_perk_rect = true,
		specialized_1_header_font_size = 13,
		hide_description = true,
		pivot_align_x = "left",
		pivot_offset_x = 40 * SCALE_1366,
		pivot_offset_y = 84 * SCALE_1366,
		width = 500 * SCALE_1366,
		height = 76 * SCALE_1366,
		no_perk_rect_color = {
			100,
			80,
			80,
			80
		},
		basic_texture_width = 46 * SCALE_1366,
		basic_texture_height = 46 * SCALE_1366,
		basic_texture_offset_x = 24 * SCALE_1366,
		basic_texture_offset_y = 2 * SCALE_1366,
		basic_header_offset_x = 78 * SCALE_1366,
		basic_header_offset_y = 18 * SCALE_1366,
		basic_header_font = MenuSettings.fonts.hell_shark_18,
		basic_text_offset_x = 78 * SCALE_1366,
		basic_text_offset_y = 7 * SCALE_1366,
		basic_text_font = MenuSettings.fonts.hell_shark_11,
		specialized_1_texture_width = 20 * SCALE_1366,
		specialized_1_texture_height = 20 * SCALE_1366,
		specialized_1_texture_offset_x = 90 * SCALE_1366,
		specialized_1_texture_offset_y = -12 * SCALE_1366,
		specialized_1_header_offset_x = 122 * SCALE_1366,
		specialized_1_header_offset_y = -6 * SCALE_1366,
		specialized_1_header_font = MenuSettings.fonts.hell_shark_13,
		specialized_2_texture_width = 20 * SCALE_1366,
		specialized_2_texture_height = 20 * SCALE_1366,
		specialized_2_texture_offset_x = 90 * SCALE_1366,
		specialized_2_texture_offset_y = -37 * SCALE_1366,
		specialized_2_header_offset_x = 122 * SCALE_1366,
		specialized_2_header_offset_y = -33 * SCALE_1366,
		specialized_2_header_font = MenuSettings.fonts.hell_shark_13,
		texture_atlas_settings = MenuAtlas,
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
	background_texture_left = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "center",
		texture = "item_list_gradient_1920",
		pivot_offset_y = 0,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_width = 624 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		stretch_width = 420 * SCALE_1366,
		stretch_height = 1000 * SCALE_1366,
		color = {
			35,
			255,
			255,
			255
		}
	},
	vertical_line_texture_outer_left = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "center",
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture = "item_list_vertical_line_1920",
		pivot_offset_x = 420 * SCALE_1366,
		texture_width = 16 * SCALE_1366,
		texture_height = 1016 * SCALE_1366,
		color = {
			100,
			255,
			255,
			255
		}
	},
	skeleton_texture = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture = "skeleton_1920",
		screen_align_x = "center",
		pivot_offset_x = 90 * SCALE_1366,
		pivot_offset_y = -430 * SCALE_1366,
		texture_width = 276 * SCALE_1366,
		texture_height = 328 * SCALE_1366
	},
	profile_viewer = {
		screen_align_y = "center",
		screen_offset_x = 0.48,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "right",
		screen_align_x = "center",
		pivot_offset_x = -80 * SCALE_1366,
		pivot_offset_y = 150 * SCALE_1366,
		width = 270 * SCALE_1366,
		height = 280 * SCALE_1366
	},
	background_texture_right = {
		screen_align_y = "center",
		screen_offset_x = 0.48,
		pivot_align_y = "center",
		texture = "item_list_gradient_right_1920",
		pivot_offset_y = 0,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_width = 624 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		stretch_width = 420 * SCALE_1366,
		stretch_height = 1000 * SCALE_1366,
		color = {
			35,
			255,
			255,
			255
		}
	},
	vertical_line_texture_outer_right = {
		screen_align_y = "center",
		screen_offset_x = 0.48,
		pivot_align_y = "center",
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "center",
		texture = "item_list_vertical_line_right_1920",
		pivot_offset_x = -420 * SCALE_1366,
		texture_width = 16 * SCALE_1366,
		texture_height = 1016 * SCALE_1366,
		color = {
			100,
			255,
			255,
			255
		}
	},
	split_delimiter_texture_outer_right = {
		screen_align_y = "center",
		screen_offset_x = 0.48,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture = "split_delimitier_1920",
		screen_align_x = "center",
		pivot_offset_x = -390 * SCALE_1366,
		pivot_offset_y = -100 * SCALE_1366,
		texture_width = 352 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		color = {
			70,
			255,
			255,
			255
		}
	},
	horse_name = {
		screen_align_y = "center",
		screen_offset_x = 0.48,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		screen_align_x = "center",
		pivot_offset_x = -390 * SCALE_1366,
		pivot_offset_y = -470 * SCALE_1366
	},
	background_rect = ServerBrowserSettings.pages.server_browser[1366][768].background_rect,
	corner_texture_top_left = ServerBrowserSettings.pages.server_browser[1366][768].corner_texture_top_left,
	corner_texture_top_right = ServerBrowserSettings.pages.server_browser[1366][768].corner_texture_top_right,
	corner_texture_bottom_left = ServerBrowserSettings.pages.server_browser[1366][768].corner_texture_bottom_left,
	corner_texture_bottom_right = ServerBrowserSettings.pages.server_browser[1366][768].corner_texture_bottom_right,
	horizontal_line_texture_top = ServerBrowserSettings.pages.server_browser[1366][768].horizontal_line_texture_top,
	horizontal_line_texture_bottom = ServerBrowserSettings.pages.server_browser[1366][768].horizontal_line_texture_bottom
}
CharacterSheetSettings.items.list_header_first_column = CharacterSheetSettings.items.list_header_first_column or {}
CharacterSheetSettings.items.list_header_first_column[1366] = CharacterSheetSettings.items.list_header_first_column[1366] or {}
CharacterSheetSettings.items.list_header_first_column[1366][768] = CharacterSheetSettings.items.list_header_first_column[1366][768] or {
	font_size = 22,
	texture_alignment = "left",
	texture_disabled = "header_item_bgr_left_small_1920",
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color_disabled = {
		255,
		0,
		0,
		0
	},
	color_render_from_child_page = {
		160,
		0,
		0,
		0
	},
	texture_disabled_width = 476 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 8 * SCALE_1366
}
CharacterSheetSettings.items.horse_name_text = CharacterSheetSettings.items.horse_name_text or {}
CharacterSheetSettings.items.horse_name_text[1366] = CharacterSheetSettings.items.horse_name_text[1366] or {}
CharacterSheetSettings.items.horse_name_text[1366][768] = CharacterSheetSettings.items.horse_name_text[1366][768] or {
	font_size = 22,
	texture_alignment = "left",
	texture_disabled = "selected_item_bgr_left_small_1920",
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	texture_disabled_width = 388 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	padding_top = 9 * SCALE_1366,
	padding_bottom = 9 * SCALE_1366,
	padding_left = 8 * SCALE_1366
}
CharacterSheetSettings.items.rename_horse_text = CharacterSheetSettings.items.rename_horse_text or {}
CharacterSheetSettings.items.rename_horse_text[1366] = CharacterSheetSettings.items.rename_horse_text[1366] or {}
CharacterSheetSettings.items.rename_horse_text[1366][768] = CharacterSheetSettings.items.rename_horse_text[1366][768] or {
	font_size = 14,
	texture_highlighted = "assigned_background_1920",
	texture_alignment = "left",
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_14,
	line_height = 16 * SCALE_1366,
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
	drop_shadow_color_disabled = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	texture_highlighted_width = 172 * SCALE_1366,
	texture_highlighted_height = 24 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 9 * SCALE_1366,
	padding_left = 8 * SCALE_1366
}
CharacterSheetSettings.items.money_text = CharacterSheetSettings.items.money_text or {}
CharacterSheetSettings.items.money_text[1366] = CharacterSheetSettings.items.money_text[1366] or {}
CharacterSheetSettings.items.money_text[1366][768] = CharacterSheetSettings.items.money_text[1366][768] or {
	texture_disabled = "coins_1920",
	padding_right = 0,
	font_size = 16,
	padding_top = 0,
	texture_alignment = "left",
	font = MenuSettings.fonts.hell_shark_16,
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
	drop_shadow_color_disabled = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	texture_disabled_width = 20 * SCALE_1366,
	texture_disabled_height = 16 * SCALE_1366,
	texture_offset_x = -10 * SCALE_1366,
	texture_offset_y = 1 * SCALE_1366,
	padding_bottom = 12 * SCALE_1366,
	padding_left = 12 * SCALE_1366
}
CharacterSheetSettings.items.list_header = CharacterSheetSettings.items.list_header or {}
CharacterSheetSettings.items.list_header[1366] = CharacterSheetSettings.items.list_header[1366] or {}
CharacterSheetSettings.items.list_header[1366][768] = CharacterSheetSettings.items.list_header[1366][768] or {
	texture_alignment = "center",
	font_size = 11,
	padding_right = 0,
	padding_left = 0,
	texture_disabled = "item_gradient_bgr_vertical_1920",
	font = MenuSettings.fonts.hell_shark_11,
	line_height = 16 * SCALE_1366,
	color_disabled = {
		255,
		0,
		0,
		0
	},
	texture_disabled_width = 48 * SCALE_1366,
	texture_disabled_height = 108 * SCALE_1366,
	texture_offset_y = -37 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 12 * SCALE_1366
}
CharacterSheetSettings.items.list_header_narrow = CharacterSheetSettings.items.list_header_narrow or {}
CharacterSheetSettings.items.list_header_narrow[1366] = CharacterSheetSettings.items.list_header_narrow[1366] or {}
CharacterSheetSettings.items.list_header_narrow[1366][768] = CharacterSheetSettings.items.list_header_narrow[1366][768] or table.clone(CharacterSheetSettings.items.list_header[1366][768])
CharacterSheetSettings.items.list_header_narrow[1366][768].texture_disabled_width = 38 * SCALE_1366
CharacterSheetSettings.items.list_text_first_column = CharacterSheetSettings.items.list_text_first_column or {}
CharacterSheetSettings.items.list_text_first_column[1366] = CharacterSheetSettings.items.list_text_first_column[1366] or {}
CharacterSheetSettings.items.list_text_first_column[1366][768] = CharacterSheetSettings.items.list_text_first_column[1366][768] or {
	font_size = 16,
	texture_alignment = "left",
	texture_disabled = "item_gradient_bgr_small_1920",
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_16,
	line_height = 16 * SCALE_1366,
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
	drop_shadow_color_disabled = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	texture_disabled_width = 384 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	padding_top = 10 * SCALE_1366,
	padding_bottom = 10 * SCALE_1366,
	padding_left = 8 * SCALE_1366
}
CharacterSheetSettings.items.list_text = CharacterSheetSettings.items.list_text or {}
CharacterSheetSettings.items.list_text[1366] = CharacterSheetSettings.items.list_text[1366] or {}
CharacterSheetSettings.items.list_text[1366][768] = CharacterSheetSettings.items.list_text[1366][768] or {
	padding_left = 0,
	font_size = 16,
	padding_right = 0,
	font = MenuSettings.fonts.arial_16,
	line_height = 16 * SCALE_1366,
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
	drop_shadow_color_disabled = {
		120,
		0,
		0,
		0
	},
	drop_shadow_offset = {
		2,
		-2
	},
	padding_top = 10 * SCALE_1366,
	padding_bottom = 10 * SCALE_1366
}
CharacterSheetSettings.items.column_delimiter_texture = CharacterSheetSettings.items.column_delimiter_texture or {}
CharacterSheetSettings.items.column_delimiter_texture[1366] = CharacterSheetSettings.items.column_delimiter_texture[1366] or {}
CharacterSheetSettings.items.column_delimiter_texture[1366][768] = CharacterSheetSettings.items.column_delimiter_texture[1366][768] or {
	texture = "item_list_column_delimiter_1920",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	texture_width = 4 * SCALE_1366,
	texture_height = 36 * SCALE_1366,
	color_disabled = {
		30,
		255,
		255,
		255
	}
}
CharacterSheetSettings.items.xp_progress_bar = CharacterSheetSettings.items.xp_progress_bar or {}
CharacterSheetSettings.items.xp_progress_bar[1366] = CharacterSheetSettings.items.xp_progress_bar[1366] or {}
CharacterSheetSettings.items.xp_progress_bar[1366][768] = CharacterSheetSettings.items.xp_progress_bar[1366][768] or {
	text_bar_font_size = 16,
	texture_bar_bgr = "xp_progress_bar_bgr_1920",
	text_sides_font_size = 22,
	texture_bar = "xp_progress_bar_1920",
	bar_width = 804 * SCALE_1366,
	bar_height = 32 * SCALE_1366,
	border_size = 2 * SCALE_1366,
	border_color = {
		255,
		150,
		150,
		150
	},
	text_bar_font = MenuSettings.fonts.hell_shark_16,
	text_bar_drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	text_bar_drop_shadow_offset = {
		2,
		-2
	},
	text_bar_offset_y = 9 * SCALE_1366,
	text_sides_font = MenuSettings.fonts.hell_shark_22,
	text_sides_drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	text_sides_drop_shadow_offset = {
		2,
		-2
	},
	text_sides_padding = 12 * SCALE_1366,
	text_sides_offset_y = 8 * SCALE_1366
}
