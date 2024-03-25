-- chunkname: @scripts/menu/menu_definitions/character_sheet_page_settings_1920.lua

CharacterSheetSettings = CharacterSheetSettings or {}
CharacterSheetSettings.items = CharacterSheetSettings.items or {}
CharacterSheetSettings.pages = CharacterSheetSettings.pages or {}
CharacterSheetSettings.items.ddl_closed_text = CharacterSheetSettings.items.ddl_closed_text or {}
CharacterSheetSettings.items.ddl_closed_text[1680] = CharacterSheetSettings.items.ddl_closed_text[1680] or {}
CharacterSheetSettings.items.ddl_closed_text[1680][1050] = CharacterSheetSettings.items.ddl_closed_text[1680][1050] or {
	texture_arrow_offset_x = -1,
	texture_background_height = 36,
	texture_background = "header_item_bgr_left_small_1920",
	texture_arrow_width = 20,
	font_size = 32,
	padding_top = 7,
	texture_background_width = 476,
	padding_bottom = 7,
	line_height = 21,
	texture_arrow_offset_y = -16,
	texture_arrow = "drop_down_list_arrow",
	texture_arrow_height = 12,
	texture_alignment = "left",
	padding_left = 8,
	padding_right = 0,
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
	}
}
CharacterSheetSettings.items.ddl_open_text = CharacterSheetSettings.items.ddl_open_text or {}
CharacterSheetSettings.items.ddl_open_text[1680] = CharacterSheetSettings.items.ddl_open_text[1680] or {}
CharacterSheetSettings.items.ddl_open_text[1680][1050] = CharacterSheetSettings.items.ddl_open_text[1680][1050] or {
	padding_left = 20,
	texture_highlighted = "selected_item_bgr_left_1920",
	texture_highlighted_height = 36,
	font_size = 32,
	padding_top = 7,
	texture_alignment = "left",
	padding_bottom = 7,
	line_height = 21,
	padding_right = 20,
	texture_highlighted_width = 652,
	font = MenuSettings.fonts.hell_shark_32,
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
	}
}
CharacterSheetSettings.items.user_name = CharacterSheetSettings.items.user_name or {}
CharacterSheetSettings.items.user_name[1680] = CharacterSheetSettings.items.user_name[1680] or {}
CharacterSheetSettings.items.user_name[1680][1050] = CharacterSheetSettings.items.user_name[1680][1050] or {
	texture_alignment = "center",
	texture_disabled = "selected_item_bgr_centered_1920",
	padding_left = 0,
	font_size = 32,
	padding_top = 7,
	texture_disabled_width = 652,
	padding_bottom = 7,
	line_height = 21,
	texture_disabled_height = 36,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_32,
	color_disabled = {
		255,
		255,
		255,
		255
	}
}
CharacterSheetSettings.pages.ddl = CharacterSheetSettings.pages.ddl or {}
CharacterSheetSettings.pages.ddl[1680] = CharacterSheetSettings.pages.ddl[1680] or {}
CharacterSheetSettings.pages.ddl[1680][1050] = CharacterSheetSettings.pages.ddl[1680][1050] or {
	drop_down_list = {
		offset_y = -5,
		texture_background = "ddl_background_left_1920",
		texture_background_align = "left",
		offset_x = 22,
		texture_background_width = 568,
		list_alignment = "left",
		item_config = CharacterSheetSettings.items.ddl_open_text,
		items = {
			columns = {
				{
					width = 568,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 36
				}
			}
		}
	}
}
CharacterSheetSettings.pages.character_sheet = CharacterSheetSettings.pages.character_sheet or {}
CharacterSheetSettings.pages.character_sheet[1680] = CharacterSheetSettings.pages.character_sheet[1680] or {}
CharacterSheetSettings.pages.character_sheet[1680][1050] = CharacterSheetSettings.pages.character_sheet[1680][1050] or {
	user_name = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = 440
	},
	title_selection = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 40,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = 360
	},
	character_selection = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = -420,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = 360
	},
	skill_header = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		pivot_offset_y = 172,
		screen_align_x = "center",
		number_of_columns = 3,
		pivot_offset_x = 40,
		screen_offset_y = 0,
		pivot_align_x = "left",
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
		pivot_offset_y = 134,
		screen_align_x = "center",
		number_of_columns = 6,
		pivot_offset_x = 40,
		screen_offset_y = 0,
		pivot_align_x = "left",
		column_width = {
			275,
			4,
			49,
			4,
			49,
			4
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
		pivot_offset_y = 310,
		screen_align_x = "center",
		number_of_columns = 5,
		pivot_offset_x = -420,
		screen_offset_y = 0,
		pivot_align_x = "left",
		column_width = {
			211,
			43,
			43,
			43,
			43
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
		pivot_offset_y = 272,
		screen_align_x = "center",
		number_of_columns = 10,
		pivot_offset_x = -420,
		screen_offset_y = 0,
		pivot_align_x = "left",
		column_width = {
			209,
			4,
			39,
			4,
			39,
			4,
			39,
			4,
			39,
			4
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
		pivot_offset_y = 310,
		screen_align_x = "center",
		number_of_columns = 4,
		pivot_offset_x = 40,
		screen_offset_y = 0,
		pivot_align_x = "left",
		column_width = {
			254,
			43,
			43,
			43
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
		pivot_offset_y = 272,
		screen_align_x = "center",
		number_of_columns = 8,
		pivot_offset_x = 40,
		screen_offset_y = 0,
		pivot_align_x = "left",
		column_width = {
			252,
			4,
			39,
			4,
			39,
			4,
			39,
			4
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
		pivot_offset_y = 100,
		screen_align_x = "center",
		number_of_columns = 2,
		pivot_offset_x = -420,
		screen_offset_y = 0,
		pivot_align_x = "left",
		column_width = {
			340,
			43
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
		pivot_offset_y = 62,
		screen_align_x = "center",
		number_of_columns = 4,
		pivot_offset_x = -420,
		screen_offset_y = 0,
		pivot_align_x = "left",
		column_width = {
			338,
			4,
			39,
			4
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
		pivot_align_y = "bottom",
		pivot_offset_y = -486,
		screen_align_x = "center",
		number_of_columns = 1,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		column_alignment = {
			"center"
		}
	},
	split_delimiter_texture_top = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "split_delimitier_1920",
		pivot_offset_y = 485,
		texture_width = 352,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_height = 4,
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
		texture = "split_delimitier_1920",
		pivot_offset_y = 340,
		texture_width = 352,
		screen_align_x = "center",
		pivot_offset_x = -34,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 4,
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
		texture = "split_delimitier_1920",
		pivot_offset_y = 340,
		texture_width = 352,
		screen_align_x = "center",
		pivot_offset_x = 70,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 4,
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
		texture_width = 16,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 1016,
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
		texture_width = 16,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 1016,
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
		height = 280,
		pivot_offset_y = 150,
		screen_align_x = "center",
		pivot_offset_x = 80,
		screen_offset_y = 0,
		pivot_align_x = "left",
		width = 270
	},
	split_delimiter_texture_outer_left = {
		screen_align_y = "center",
		screen_offset_x = -0.48,
		pivot_align_y = "bottom",
		texture = "split_delimitier_1920",
		pivot_offset_y = 126,
		texture_width = 352,
		screen_align_x = "center",
		pivot_offset_x = 30,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 4,
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
		pivot_offset_x = 30,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = 80
	},
	perks = {
		pivot_align_y = "top",
		specialized_1_header_font_size = 18,
		specialized_1_texture_offset_y = -12,
		specialized_1_header_offset_y = -6,
		basic_text_offset_y = 7,
		basic_text_offset_x = 78,
		basic_text_font_size = 16,
		screen_offset_x = -0.48,
		specialized_1_texture_offset_x = 90,
		specialized_1_texture_height = 20,
		specialized_2_header_offset_x = 122,
		specialized_2_texture_offset_y = -37,
		basic_texture_height = 46,
		specialized_1_header_offset_x = 122,
		specialized_2_header_offset_y = -33,
		specialized_2_header_font_size = 18,
		screen_align_y = "center",
		basic_header_offset_y = 18,
		specialized_2_texture_height = 20,
		pivot_offset_y = 84,
		screen_align_x = "center",
		texture_atlas_name = "menu_atlas",
		specialized_2_texture_width = 20,
		pivot_offset_x = 40,
		hide_description = true,
		width = 500,
		basic_header_offset_x = 78,
		height = 76,
		basic_texture_offset_y = 2,
		specialized_2_texture_offset_x = 90,
		basic_texture_width = 46,
		specialized_1_texture_width = 20,
		basic_header_font_size = 26,
		show_no_perk_rect = true,
		screen_offset_y = 0,
		pivot_align_x = "left",
		basic_texture_offset_x = 24,
		no_perk_rect_color = {
			100,
			80,
			80,
			80
		},
		basic_header_font = MenuSettings.fonts.hell_shark_26,
		basic_text_font = MenuSettings.fonts.hell_shark_16,
		specialized_1_header_font = MenuSettings.fonts.hell_shark_18,
		specialized_2_header_font = MenuSettings.fonts.hell_shark_18,
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
		texture_width = 624,
		screen_align_x = "center",
		stretch_height = 1000,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "left",
		stretch_width = 420,
		texture_height = 4,
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
		texture = "item_list_vertical_line_1920",
		pivot_offset_y = 0,
		texture_width = 16,
		screen_align_x = "center",
		pivot_offset_x = 420,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 1016,
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
		texture = "skeleton_1920",
		pivot_offset_y = -430,
		texture_width = 276,
		screen_align_x = "center",
		pivot_offset_x = 90,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 328
	},
	profile_viewer = {
		screen_align_y = "center",
		screen_offset_x = 0.48,
		pivot_align_y = "bottom",
		height = 280,
		pivot_offset_y = 150,
		screen_align_x = "center",
		pivot_offset_x = -80,
		screen_offset_y = 0,
		pivot_align_x = "right",
		width = 270
	},
	background_texture_right = {
		screen_align_y = "center",
		screen_offset_x = 0.48,
		pivot_align_y = "center",
		texture = "item_list_gradient_right_1920",
		pivot_offset_y = 0,
		texture_width = 624,
		screen_align_x = "center",
		stretch_height = 1000,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "right",
		stretch_width = 420,
		texture_height = 4,
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
		texture = "item_list_vertical_line_right_1920",
		pivot_offset_y = 0,
		texture_width = 16,
		screen_align_x = "center",
		pivot_offset_x = -420,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 1016,
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
		texture = "split_delimitier_1920",
		pivot_offset_y = -100,
		texture_width = 352,
		screen_align_x = "center",
		pivot_offset_x = -390,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 4,
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
		pivot_offset_x = -390,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = -470
	},
	background_rect = ServerBrowserSettings.pages.server_browser[1680][1050].background_rect,
	corner_texture_top_left = ServerBrowserSettings.pages.server_browser[1680][1050].corner_texture_top_left,
	corner_texture_top_right = ServerBrowserSettings.pages.server_browser[1680][1050].corner_texture_top_right,
	corner_texture_bottom_left = ServerBrowserSettings.pages.server_browser[1680][1050].corner_texture_bottom_left,
	corner_texture_bottom_right = ServerBrowserSettings.pages.server_browser[1680][1050].corner_texture_bottom_right,
	horizontal_line_texture_top = ServerBrowserSettings.pages.server_browser[1680][1050].horizontal_line_texture_top,
	horizontal_line_texture_bottom = ServerBrowserSettings.pages.server_browser[1680][1050].horizontal_line_texture_bottom
}
CharacterSheetSettings.items.list_header_first_column = CharacterSheetSettings.items.list_header_first_column or {}
CharacterSheetSettings.items.list_header_first_column[1680] = CharacterSheetSettings.items.list_header_first_column[1680] or {}
CharacterSheetSettings.items.list_header_first_column[1680][1050] = CharacterSheetSettings.items.list_header_first_column[1680][1050] or {
	texture_alignment = "left",
	texture_disabled = "header_item_bgr_left_small_1920",
	padding_left = 8,
	font_size = 32,
	padding_top = 7,
	texture_disabled_width = 476,
	padding_bottom = 7,
	line_height = 21,
	texture_disabled_height = 36,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_32,
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
	}
}
CharacterSheetSettings.items.horse_name_text = CharacterSheetSettings.items.horse_name_text or {}
CharacterSheetSettings.items.horse_name_text[1680] = CharacterSheetSettings.items.horse_name_text[1680] or {}
CharacterSheetSettings.items.horse_name_text[1680][1050] = CharacterSheetSettings.items.horse_name_text[1680][1050] or {
	texture_alignment = "left",
	texture_disabled = "selected_item_bgr_left_small_1920",
	padding_left = 8,
	font_size = 32,
	padding_top = 9,
	texture_disabled_width = 388,
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
	}
}
CharacterSheetSettings.items.rename_horse_text = CharacterSheetSettings.items.rename_horse_text or {}
CharacterSheetSettings.items.rename_horse_text[1680] = CharacterSheetSettings.items.rename_horse_text[1680] or {}
CharacterSheetSettings.items.rename_horse_text[1680][1050] = CharacterSheetSettings.items.rename_horse_text[1680][1050] or {
	padding_left = 8,
	texture_highlighted = "assigned_background_1920",
	texture_highlighted_height = 24,
	font_size = 20,
	padding_top = 7,
	texture_alignment = "left",
	padding_bottom = 9,
	line_height = 16,
	padding_right = 0,
	texture_highlighted_width = 172,
	font = MenuSettings.fonts.hell_shark_20,
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
	}
}
CharacterSheetSettings.items.money_text = CharacterSheetSettings.items.money_text or {}
CharacterSheetSettings.items.money_text[1680] = CharacterSheetSettings.items.money_text[1680] or {}
CharacterSheetSettings.items.money_text[1680][1050] = CharacterSheetSettings.items.money_text[1680][1050] or {
	texture_disabled_width = 20,
	font_size = 24,
	texture_alignment = "left",
	padding_left = 12,
	texture_offset_x = -10,
	padding_top = 0,
	texture_disabled = "coins_1920",
	padding_bottom = 12,
	line_height = 21,
	texture_disabled_height = 16,
	texture_offset_y = 1,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_24,
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
	}
}
CharacterSheetSettings.items.list_header = CharacterSheetSettings.items.list_header or {}
CharacterSheetSettings.items.list_header[1680] = CharacterSheetSettings.items.list_header[1680] or {}
CharacterSheetSettings.items.list_header[1680][1050] = CharacterSheetSettings.items.list_header[1680][1050] or {
	texture_disabled_width = 48,
	texture_disabled = "item_gradient_bgr_vertical_1920",
	padding_left = 0,
	font_size = 16,
	padding_top = 7,
	texture_alignment = "center",
	padding_bottom = 12,
	line_height = 16,
	texture_disabled_height = 108,
	texture_offset_y = -37,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_16,
	color_disabled = {
		255,
		0,
		0,
		0
	}
}
CharacterSheetSettings.items.list_header_narrow = CharacterSheetSettings.items.list_header_narrow or {}
CharacterSheetSettings.items.list_header_narrow[1680] = CharacterSheetSettings.items.list_header_narrow[1680] or {}
CharacterSheetSettings.items.list_header_narrow[1680][1050] = CharacterSheetSettings.items.list_header_narrow[1680][1050] or table.clone(CharacterSheetSettings.items.list_header[1680][1050])
CharacterSheetSettings.items.list_header_narrow[1680][1050].texture_disabled_width = 38
CharacterSheetSettings.items.list_text_first_column = CharacterSheetSettings.items.list_text_first_column or {}
CharacterSheetSettings.items.list_text_first_column[1680] = CharacterSheetSettings.items.list_text_first_column[1680] or {}
CharacterSheetSettings.items.list_text_first_column[1680][1050] = CharacterSheetSettings.items.list_text_first_column[1680][1050] or {
	texture_alignment = "left",
	texture_disabled = "item_gradient_bgr_small_1920",
	padding_left = 8,
	font_size = 24,
	padding_top = 10,
	texture_disabled_width = 384,
	padding_bottom = 10,
	line_height = 16,
	texture_disabled_height = 36,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_24,
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
	}
}
CharacterSheetSettings.items.list_text = CharacterSheetSettings.items.list_text or {}
CharacterSheetSettings.items.list_text[1680] = CharacterSheetSettings.items.list_text[1680] or {}
CharacterSheetSettings.items.list_text[1680][1050] = CharacterSheetSettings.items.list_text[1680][1050] or {
	line_height = 16,
	padding_left = 0,
	font_size = 16,
	padding_top = 10,
	padding_right = 0,
	padding_bottom = 10,
	font = MenuSettings.fonts.arial_16,
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
	}
}
CharacterSheetSettings.items.column_delimiter_texture = CharacterSheetSettings.items.column_delimiter_texture or {}
CharacterSheetSettings.items.column_delimiter_texture[1680] = CharacterSheetSettings.items.column_delimiter_texture[1680] or {}
CharacterSheetSettings.items.column_delimiter_texture[1680][1050] = CharacterSheetSettings.items.column_delimiter_texture[1680][1050] or {
	texture = "item_list_column_delimiter_1920",
	padding_bottom = 0,
	texture_width = 4,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_height = 36,
	color_disabled = {
		30,
		255,
		255,
		255
	}
}
CharacterSheetSettings.items.xp_progress_bar = CharacterSheetSettings.items.xp_progress_bar or {}
CharacterSheetSettings.items.xp_progress_bar[1680] = CharacterSheetSettings.items.xp_progress_bar[1680] or {}
CharacterSheetSettings.items.xp_progress_bar[1680][1050] = CharacterSheetSettings.items.xp_progress_bar[1680][1050] or {
	text_bar_offset_y = 9,
	texture_bar_bgr = "xp_progress_bar_bgr_1920",
	bar_height = 32,
	text_sides_offset_y = 8,
	text_sides_font_size = 32,
	texture_bar = "xp_progress_bar_1920",
	text_sides_padding = 12,
	text_bar_font_size = 24,
	bar_width = 804,
	border_size = 2,
	border_color = {
		255,
		150,
		150,
		150
	},
	text_bar_font = MenuSettings.fonts.hell_shark_24,
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
	text_sides_font = MenuSettings.fonts.hell_shark_32,
	text_sides_drop_shadow_color = {
		120,
		0,
		0,
		0
	},
	text_sides_drop_shadow_offset = {
		2,
		-2
	}
}
