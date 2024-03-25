-- chunkname: @scripts/menu/menu_definitions/main_menu_settings_1366.lua

require("scripts/settings/menu_settings")
require("scripts/settings/coat_of_arms")
require("gui/textures/loading_atlas")
require("gui/textures/outfit_atlas")
require("gui/textures/sale_popup_atlas")
require("scripts/menu/menu_definitions/final_scoreboard_menu_settings_1366")

SCALE_1366 = 0.7114583333333333
MainMenuSettings = MainMenuSettings or {}
MainMenuSettings.items = MainMenuSettings.items or {}
MainMenuSettings.pages = MainMenuSettings.pages or {}
MainMenuSettings.level = MainMenuSettings.level or {
	level_name = "main_menu_kingmaker"
}
MainMenuSettings.music_events = {
	on_menu_init = {
		"Play_menu_music"
	}
}
MainMenuSettings.items.xp_progress_bar = MainMenuSettings.items.xp_progress_bar or {}
MainMenuSettings.items.xp_progress_bar[1366] = MainMenuSettings.items.xp_progress_bar[1366] or {}
MainMenuSettings.items.xp_progress_bar[1366][768] = MainMenuSettings.items.xp_progress_bar[1366][768] or {
	texture_bar_bgr = "xp_progress_bar_bgr_1920",
	text_sides_font_size = 18,
	text_bar_font_size = 11,
	border_size = 1,
	texture_bar = "xp_progress_bar_1920",
	bar_width = 340 * SCALE_1366,
	bar_height = 20 * SCALE_1366,
	border_color = {
		200,
		150,
		150,
		150
	},
	texture_bar_bgr_color = {
		255,
		255,
		255,
		255
	},
	texture_bar_color = {
		255,
		255,
		255,
		255
	},
	text_bar_font = MenuSettings.fonts.hell_shark_11,
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
	text_bar_offset_y = 6 * SCALE_1366,
	text_sides_font = MenuSettings.fonts.hell_shark_18,
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
	text_sides_padding = 8 * SCALE_1366,
	text_sides_offset_y = 4 * SCALE_1366
}
MainMenuSettings.items.money_text = MainMenuSettings.items.money_text or {}
MainMenuSettings.items.money_text[1366] = MainMenuSettings.items.money_text[1366] or {}
MainMenuSettings.items.money_text[1366][768] = MainMenuSettings.items.money_text[1366][768] or {
	texture_alignment = "left",
	padding_right = 0,
	texture_offset_y = 0,
	font_size = 13,
	padding_top = 0,
	texture_disabled = "coins_1920",
	font = MenuSettings.fonts.hell_shark_13,
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
	padding_bottom = 10 * SCALE_1366,
	padding_left = 12 * SCALE_1366
}
MainMenuSettings.items.popup_header = MainMenuSettings.items.popup_header or {}
MainMenuSettings.items.popup_header[1366] = MainMenuSettings.items.popup_header[1366] or {}
MainMenuSettings.items.popup_header[1366][768] = MainMenuSettings.items.popup_header[1366][768] or {
	texture_disabled = "popup_title_bar_1920",
	padding_right = 0,
	font_size = 14,
	padding_top = 0,
	texture_alignment = "left",
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_14,
	line_height = 13 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	texture_disabled_width = 604 * SCALE_1366,
	texture_disabled_height = 32 * SCALE_1366,
	padding_left = 25 * SCALE_1366
}
MainMenuSettings.items.popup_header_alert = MainMenuSettings.items.popup_header_alert or {}
MainMenuSettings.items.popup_header_alert[1366] = MainMenuSettings.items.popup_header_alert[1366] or {}
MainMenuSettings.items.popup_header_alert[1366][768] = MainMenuSettings.items.popup_header_alert[1366][768] or table.clone(MainMenuSettings.items.popup_header[1366][768])
MainMenuSettings.items.popup_header_alert[1366][768].color_disabled = {
	255,
	255,
	50,
	50
}
MainMenuSettings.items.popup_input = MainMenuSettings.items.popup_input or {}
MainMenuSettings.items.popup_input[1366] = MainMenuSettings.items.popup_input[1366] or {}
MainMenuSettings.items.popup_input[1366][768] = MainMenuSettings.items.popup_input[1366][768] or {
	font_size = 14,
	texture_offset_y = 0,
	texture_background = "popup_input_background_1920",
	font = MenuSettings.fonts.hell_shark_14,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_offset_y = 11 * SCALE_1366,
	texture_background_width = 520 * SCALE_1366,
	texture_background_height = 36 * SCALE_1366,
	marker_width = 2 * SCALE_1366,
	marker_height = 24 * SCALE_1366,
	marker_offset_y = 7 * SCALE_1366,
	width = 520 * SCALE_1366,
	height = 36 * SCALE_1366
}
MainMenuSettings.items.popup_text = MainMenuSettings.items.popup_text or {}
MainMenuSettings.items.popup_text[1366] = MainMenuSettings.items.popup_text[1366] or {}
MainMenuSettings.items.popup_text[1366][768] = MainMenuSettings.items.popup_text[1366][768] or {
	font_size = 14,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_14,
	line_height = 13 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		255
	}
}
MainMenuSettings.items.popup_textbox = MainMenuSettings.items.popup_textbox or {}
MainMenuSettings.items.popup_textbox[1366] = MainMenuSettings.items.popup_textbox[1366] or {}
MainMenuSettings.items.popup_textbox[1366][768] = MainMenuSettings.items.popup_textbox[1366][768] or {
	padding_left = 0,
	padding_right = 0,
	font_size = 13,
	padding_top = 0,
	text_align = "left",
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_13,
	color = {
		255,
		255,
		255,
		255
	},
	line_height = 25 * SCALE_1366,
	width = 550 * SCALE_1366,
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
MainMenuSettings.items.popup_loading_texture = MainMenuSettings.items.popup_loading_texture or {}
MainMenuSettings.items.popup_loading_texture[1366] = MainMenuSettings.items.popup_loading_texture[1366] or {}
MainMenuSettings.items.popup_loading_texture[1366][768] = MainMenuSettings.items.popup_loading_texture[1366][768] or {
	padding_left = 0,
	padding_right = 0,
	texture_atlas = "loading_atlas",
	frames = {},
	texture_width = 40 * SCALE_1366,
	texture_height = 40 * SCALE_1366,
	texture_atlas_settings = LoadingAtlas,
	animation_speed = 30 * SCALE_1366,
	padding_top = 18 * SCALE_1366,
	padding_bottom = -50 * SCALE_1366,
	scale = 0.5 * SCALE_1366
}

for i = 1, 72 do
	MainMenuSettings.items.popup_loading_texture[1366][768].frames[i] = string.format("loading_shield_%.2d", i)
end

MainMenuSettings.items.popup_button = MainMenuSettings.items.popup_button or {}
MainMenuSettings.items.popup_button[1366] = MainMenuSettings.items.popup_button[1366] or {}
MainMenuSettings.items.popup_button[1366][768] = MainMenuSettings.items.popup_button[1366][768] or {
	text_padding = 0,
	texture_right_width = 20,
	texture_left = "shiny_button_left_end_1366",
	text_offset_y = 16,
	font_size = 18,
	texture_middle = "shiny_button_center_1366",
	texture_right = "shiny_button_right_end_1366",
	padding_bottom = 3,
	texture_middle_highlighted = "shiny_button_center_highlighted_1366",
	texture_right_highlighted = "shiny_button_right_end_highlighted_1366",
	padding_top = 0,
	texture_left_width = 20,
	texture_left_highlighted = "shiny_button_left_end_highlighted_1366",
	padding_left = 7,
	padding_right = 7,
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
MainMenuSettings.items.demo_popup_buy_button = MainMenuSettings.items.demo_popup_buy_button or {}
MainMenuSettings.items.demo_popup_buy_button[1366] = MainMenuSettings.items.demo_popup_buy_button[1366] or {}
MainMenuSettings.items.demo_popup_buy_button[1366][768] = MainMenuSettings.items.demo_popup_buy_button[1366][768] or {
	text_padding = 0,
	no_middle_texture = true,
	texture_right_width = 0,
	font_size = 18,
	texture_middle_highlighted = "demo_popup_1920_lit",
	text_offset_y = 0,
	padding_top = 0,
	padding_bottom = 0,
	padding_left = 0,
	texture_left_width = 0,
	padding_right = 0,
	text_offset_x = 0,
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
	texture_height = 384 * SCALE_1366,
	texture_forced_width = 264 * SCALE_1366,
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
MainMenuSettings.items.demo_popup_cancel_button = MainMenuSettings.items.demo_popup_cancel_button or {}
MainMenuSettings.items.demo_popup_cancel_button[1366] = MainMenuSettings.items.demo_popup_cancel_button[1366] or {}
MainMenuSettings.items.demo_popup_cancel_button[1366][768] = MainMenuSettings.items.demo_popup_cancel_button[1366][768] or table.clone(MainMenuSettings.items.demo_popup_buy_button[1366][768])
MainMenuSettings.items.demo_popup_cancel_button[1366][768].no_middle_texture = nil
MainMenuSettings.items.demo_popup_cancel_button[1366][768].texture_middle = "demo_popup_wotr_close"
MainMenuSettings.items.demo_popup_cancel_button[1366][768].texture_middle_highlighted = "demo_popup_wotr_close_lit"
MainMenuSettings.items.demo_popup_cancel_button[1366][768].texture_forced_width = 88 * SCALE_1366
MainMenuSettings.items.demo_popup_cancel_button[1366][768].texture_height = 88 * SCALE_1366
MainMenuSettings.items.demo_popup_cancel_button[1366][768].texture_offset_x = 250 * SCALE_1366
MainMenuSettings.items.demo_popup_cancel_button[1366][768].texture_offset_y = 400 * SCALE_1366
MainMenuSettings.items.coins_amount_button = MainMenuSettings.items.coins_amount_button or {}
MainMenuSettings.items.coins_amount_button[1366] = MainMenuSettings.items.coins_amount_button[1366] or {}
MainMenuSettings.items.coins_amount_button[1366][768] = MainMenuSettings.items.coins_amount_button[1366][768] or {
	text_padding = 0,
	texture_height = 120,
	texture_left_width = 0,
	texture_middle = "gold_button_",
	font_size = 16,
	text_offset_y = 25,
	texture_middle_highlighted = "gold_button_hover_",
	padding_bottom = -10,
	texture_forced_width = 700,
	padding_top = -10,
	padding_left = 0,
	texture_right_width = 0,
	padding_right = 0,
	text_offset_x = 280,
	font = MenuSettings.fonts.hell_shark_16,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_color_highlighted = {
		255,
		255,
		255,
		255
	},
	text_color_disabled = {
		255,
		255,
		255,
		255
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
		255,
		255,
		255,
		255
	}
}
MainMenuSettings.items.popup_button_small = MainMenuSettings.items.popup_button_small or {}
MainMenuSettings.items.popup_button_small[1366] = MainMenuSettings.items.popup_button_small[1366] or {}
MainMenuSettings.items.popup_button_small[1366][768] = MainMenuSettings.items.popup_button_small[1366][768] or table.clone(MainMenuSettings.items.popup_button[1366][768])
MainMenuSettings.items.popup_button_small[1366][768].font = MenuSettings.fonts.hell_shark_14
MainMenuSettings.items.popup_button_small[1366][768].font_size = 14
MainMenuSettings.items.popup_button_small[1366][768].text_offset_y = 18
MainMenuSettings.items.popup_button_small[1366][768].padding_left = 2
MainMenuSettings.items.popup_button_small[1366][768].padding_right = 2
MainMenuSettings.items.popup_button_small[1366][768].text_padding = -8
MainMenuSettings.items.popup_close_texture = MainMenuSettings.items.popup_close_texture or {}
MainMenuSettings.items.popup_close_texture[1366] = MainMenuSettings.items.popup_close_texture[1366] or {}
MainMenuSettings.items.popup_close_texture[1366][768] = MainMenuSettings.items.popup_close_texture[1366][768] or {
	texture = "checkbox_close_1366",
	texture_highlighted = "checkbox_close_1366",
	texture_highlighted_height = 28,
	texture_background_height = 28,
	padding_top = -9,
	texture_background = "checkbox_off_1366",
	padding_bottom = -9,
	texture_offset_z = 2,
	texture_background_offset_z = 1,
	texture_width = 28,
	padding_right = 0,
	texture_height = 28,
	texture_background_alignment = "center",
	padding_left = 0,
	texture_background_width = 28,
	texture_highlighted_offset_z = 2,
	texture_highlighted_width = 28,
	color = {
		160,
		255,
		255,
		255
	},
	color_highlighted = {
		255,
		255,
		255,
		255
	}
}
MainMenuSettings.items.expandable_popup_header = MainMenuSettings.items.expandable_popup_header or {}
MainMenuSettings.items.expandable_popup_header[1366] = MainMenuSettings.items.expandable_popup_header[1366] or {}
MainMenuSettings.items.expandable_popup_header[1366][768] = MainMenuSettings.items.expandable_popup_header[1366][768] or {
	texture_alignment = "left",
	texture_disabled = "popup_title_bar_1366",
	padding_left = 18,
	font_size = 16,
	padding_top = 14,
	texture_disabled_width = 432,
	padding_bottom = 14,
	line_height = 9,
	texture_disabled_height = 24,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_16,
	color_disabled = {
		255,
		255,
		255,
		255
	}
}
MainMenuSettings.items.expandable_popup_textbox = MainMenuSettings.items.expandable_popup_textbox or {}
MainMenuSettings.items.expandable_popup_textbox[1366] = MainMenuSettings.items.expandable_popup_textbox[1366] or {}
MainMenuSettings.items.expandable_popup_textbox[1366][768] = MainMenuSettings.items.expandable_popup_textbox[1366][768] or {
	render_from_top = true,
	max_height = 500,
	min_height = 284,
	padding_left = 18,
	font_size = 14,
	padding_top = 0,
	text_align = "left",
	padding_bottom = 0,
	line_height = 18,
	padding_right = 0,
	width = 390,
	font = MenuSettings.fonts.hell_shark_14_masked,
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
MainMenuSettings.items.centered_button = MainMenuSettings.items.centered_button or {}
MainMenuSettings.items.centered_button[1366] = MainMenuSettings.items.centered_button[1366] or {}
MainMenuSettings.items.centered_button[1366][768] = MainMenuSettings.items.centered_button[1366][768] or {
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
MainMenuSettings.items.header_text_left_aligned = MainMenuSettings.items.header_text_left_aligned or {}
MainMenuSettings.items.header_text_left_aligned[1366] = MainMenuSettings.items.header_text_left_aligned[1366] or {}
MainMenuSettings.items.header_text_left_aligned[1366][768] = MainMenuSettings.items.header_text_left_aligned[1366][768] or {
	font_size = 22,
	texture_alignment = "left",
	texture_disabled = "header_item_bgr_left_1920",
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
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	texture_color_render_from_child_page = {
		100,
		255,
		255,
		255
	},
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 20 * SCALE_1366
}
MainMenuSettings.items.header_text_right_aligned = MainMenuSettings.items.header_text_right_aligned or {}
MainMenuSettings.items.header_text_right_aligned[1366] = MainMenuSettings.items.header_text_right_aligned[1366] or {}
MainMenuSettings.items.header_text_right_aligned[1366][768] = MainMenuSettings.items.header_text_right_aligned[1366][768] or {
	font_size = 22,
	texture_alignment = "right",
	texture_disabled = "header_item_bgr_right_1920",
	padding_left = 0,
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
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	texture_color_render_from_child_page = {
		100,
		255,
		255,
		255
	},
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
MainMenuSettings.items.sub_header_left_aligned = MainMenuSettings.items.sub_header_left_aligned or {}
MainMenuSettings.items.sub_header_left_aligned[1366] = MainMenuSettings.items.sub_header_left_aligned[1366] or {}
MainMenuSettings.items.sub_header_left_aligned[1366][768] = MainMenuSettings.items.sub_header_left_aligned[1366][768] or {
	texture = "header_item_bgr_left_1920",
	texture_highlighted = "header_item_bgr_left_1920",
	texture_alignment = "left",
	font_size = 22,
	texture_disabled = "header_item_bgr_left_1920",
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color_disabled = {
		255,
		0,
		0,
		0
	},
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
	texture_disabled_width = 652 * SCALE_1366,
	texture_disabled_height = 36 * SCALE_1366,
	texture_width = 652 * SCALE_1366,
	texture_height = 36 * SCALE_1366,
	texture_highlighted_width = 652 * SCALE_1366,
	texture_highlighted_height = 36 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 20 * SCALE_1366,
	padding_right = 20 * SCALE_1366,
	division_rect = {
		540 * SCALE_1366,
		270 * SCALE_1366
	}
}
MainMenuSettings.items.division_header_devision_left_aligned = MainMenuSettings.items.division_header_devision_left_aligned or {}
MainMenuSettings.items.division_header_devision_left_aligned[1366] = MainMenuSettings.items.division_header_devision_left_aligned[1366] or {}
MainMenuSettings.items.division_header_devision_left_aligned[1366][768] = MainMenuSettings.items.division_header_devision_left_aligned[1366][768] or table.clone(MainMenuSettings.items.sub_header_left_aligned[1366][768])
MainMenuSettings.items.division_header_devision_left_aligned[1366][768].division_rect = {
	540 * SCALE_1366,
	270 * SCALE_1366
}
MainMenuSettings.items.division_header_ordinary_left_aligned = MainMenuSettings.items.division_header_ordinary_left_aligned or {}
MainMenuSettings.items.division_header_ordinary_left_aligned[1366] = MainMenuSettings.items.division_header_ordinary_left_aligned[1366] or {}
MainMenuSettings.items.division_header_ordinary_left_aligned[1366][768] = MainMenuSettings.items.division_header_ordinary_left_aligned[1366][768] or table.clone(MainMenuSettings.items.sub_header_left_aligned[1366][768])
MainMenuSettings.items.division_header_ordinary_left_aligned[1366][768].division_rect = {
	540 * SCALE_1366,
	105 * SCALE_1366
}
MainMenuSettings.items.division_header_charge_left_aligned = MainMenuSettings.items.division_header_charge_left_aligned or {}
MainMenuSettings.items.division_header_charge_left_aligned[1366] = MainMenuSettings.items.division_header_charge_left_aligned[1366] or {}
MainMenuSettings.items.division_header_charge_left_aligned[1366][768] = MainMenuSettings.items.division_header_charge_left_aligned[1366][768] or table.clone(MainMenuSettings.items.sub_header_left_aligned[1366][768])
MainMenuSettings.items.division_header_charge_left_aligned[1366][768].division_rect = {
	540 * SCALE_1366,
	145 * SCALE_1366
}
MainMenuSettings.items.division_header_crest_left_aligned = MainMenuSettings.items.division_header_crest_left_aligned or {}
MainMenuSettings.items.division_header_crest_left_aligned[1366] = MainMenuSettings.items.division_header_crest_left_aligned[1366] or {}
MainMenuSettings.items.division_header_crest_left_aligned[1366][768] = MainMenuSettings.items.division_header_crest_left_aligned[1366][768] or table.clone(MainMenuSettings.items.sub_header_left_aligned[1366][768])
MainMenuSettings.items.division_header_crest_left_aligned[1366][768].division_rect = {
	540 * SCALE_1366,
	100 * SCALE_1366
}
MainMenuSettings.items.sub_header_2_left_aligned = MainMenuSettings.items.sub_header_2_left_aligned or {}
MainMenuSettings.items.sub_header_2_left_aligned[1366] = MainMenuSettings.items.sub_header_2_left_aligned[1366] or {}
MainMenuSettings.items.sub_header_2_left_aligned[1366][768] = MainMenuSettings.items.sub_header_2_left_aligned[1366][768] or {
	font_size = 22,
	texture_alignment = "left",
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 20 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
MainMenuSettings.items.color_picker = MainMenuSettings.items.color_picker or {}
MainMenuSettings.items.color_picker[1366] = MainMenuSettings.items.color_picker[1366] or {}
MainMenuSettings.items.color_picker[1366][768] = MainMenuSettings.items.color_picker[1366][768] or {
	texture = "color_picker_1920",
	padding_right = 0,
	texture_selected_background = "color_picker_selected_background_1920",
	texture_2 = "color_picker_2_1920",
	texture_width = 20 * SCALE_1366,
	texture_height = 20 * SCALE_1366,
	texture_2_width = 20 * SCALE_1366,
	texture_2_height = 20 * SCALE_1366,
	texture_selected_background_width = 20 * SCALE_1366,
	texture_selected_background_height = 20 * SCALE_1366,
	border_size = {
		255,
		0,
		0,
		0
	},
	border_color = {
		255,
		0,
		0,
		0
	},
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 10 * SCALE_1366
}
MainMenuSettings.items.floating_tooltip = MainMenuSettings.items.floating_tooltip or {}
MainMenuSettings.items.floating_tooltip[1366] = MainMenuSettings.items.floating_tooltip[1366] or {}
MainMenuSettings.items.floating_tooltip[1366][768] = MainMenuSettings.items.floating_tooltip[1366][768] or {
	fade_out_delay = 0,
	texture_middle_left = "tooltip_mid_left",
	texture_center = "tooltip_cent",
	fade_in_delay = 0.6,
	header_font_size = 16,
	fade_in_speed = 5,
	text_font_size = 16,
	texture_top_middle = "tooltip_top_mid",
	texture_top_left = "tooltip_top_left",
	texture_middle_right = "tooltip_mid_right",
	texture_down_right = "tooltip_down_right",
	texture_top_right = "tooltip_top_right",
	texture_down_left = "tooltip_down_left",
	fade_out_speed = 10,
	texture_down_middle = "tooltip_down_mid",
	texture_width = 20 * SCALE_1366,
	texture_height = 20 * SCALE_1366,
	header_font = MenuSettings.fonts.arial_16,
	header_color = {
		255,
		255,
		255,
		255
	},
	header_shadow_color = {
		255,
		100,
		100,
		100
	},
	header_shadow_offset = {
		1,
		-1
	},
	text_font = MenuSettings.fonts.arial_16,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_shadow_color = {
		255,
		100,
		100,
		100
	},
	text_shadow_offset = {
		1,
		-1
	},
	text_line_height = 20 * SCALE_1366,
	text_padding_top = 10 * SCALE_1366,
	min_center_width = 200 * SCALE_1366,
	cursor_offset_y = -14 * SCALE_1366
}

local COAT_OF_ARMS_TYPE_1600_900 = COAT_OF_ARMS_TYPE_1600_900 or {
	texture_background = "coat_of_arms_background_1920",
	texture_selected_background = "coat_of_arms_background_selected_1920",
	texture_mask = "coat_of_arms_mask_1920",
	texture_width = 29 * SCALE_1366,
	texture_height = 29 * SCALE_1366,
	texture_background_width = 28 * SCALE_1366,
	texture_background_height = 32 * SCALE_1366,
	texture_selected_background_width = 28 * SCALE_1366,
	texture_selected_background_height = 32 * SCALE_1366,
	texture_mask_width = 30 * SCALE_1366,
	texture_mask_height = 34 * SCALE_1366,
	padding_top = 5 * SCALE_1366,
	padding_bottom = 5 * SCALE_1366,
	padding_left = -1 * SCALE_1366,
	padding_right = -2 * SCALE_1366
}

for item_type, coat_of_arms_type in pairs({
	division_variation_type_picker_ = "material_variation_types",
	charge_type_picker_ = "charge_types",
	ordinary_type_picker_ = "ordinary_types",
	division_type_picker_ = "division_types",
	field_variation_type_picker_ = "material_variation_types",
	crest_picker_ = "crests"
}) do
	for _, config in ipairs(CoatOfArms[coat_of_arms_type]) do
		local item_name = item_type .. config.name

		MainMenuSettings.items[item_name] = MainMenuSettings.items[item_name] or {}
		MainMenuSettings.items[item_name][1366] = MainMenuSettings.items[item_name][1366] or {}
		MainMenuSettings.items[item_name][1366][768] = MainMenuSettings.items[item_name][1366][768] or {}

		for key, value in pairs(COAT_OF_ARMS_TYPE_1600_900) do
			MainMenuSettings.items[item_name][1366][768][key] = value
		end

		MainMenuSettings.items[item_name][1366][768].texture_atlas = config.texture_atlas
		MainMenuSettings.items[item_name][1366][768].texture_atlas_settings = config.texture_atlas_settings
		MainMenuSettings.items[item_name][1366][768].display_name = config.display_name
	end
end

MainMenuSettings.items.scroll_up = MainMenuSettings.items.scroll_up or {}
MainMenuSettings.items.scroll_up[1366] = MainMenuSettings.items.scroll_up[1366] or {}
MainMenuSettings.items.scroll_up[1366][768] = MainMenuSettings.items.scroll_up[1366][768] or {
	texture = "scroll_up_1920",
	padding_left = 0,
	padding_right = 0,
	padding_bottom = 0,
	texture_width = 24 * SCALE_1366,
	texture_height = 12 * SCALE_1366,
	color_disabled = {
		80,
		255,
		255,
		255
	},
	offset_x = 490 * SCALE_1366,
	padding_top = 4 * SCALE_1366
}
MainMenuSettings.items.scroll_down = MainMenuSettings.items.scroll_down or {}
MainMenuSettings.items.scroll_down[1366] = MainMenuSettings.items.scroll_down[1366] or {}
MainMenuSettings.items.scroll_down[1366][768] = MainMenuSettings.items.scroll_down[1366][768] or {
	texture = "scroll_down_1920",
	padding_top = 0,
	padding_right = 0,
	padding_left = 0,
	texture_width = 24 * SCALE_1366,
	texture_height = 12 * SCALE_1366,
	color_disabled = {
		80,
		255,
		255,
		255
	},
	offset_x = 490 * SCALE_1366,
	padding_bottom = 4 * SCALE_1366
}
MainMenuSettings.items.scroll_text = MainMenuSettings.items.scroll_text or {}
MainMenuSettings.items.scroll_text[1366] = MainMenuSettings.items.scroll_text[1366] or {}
MainMenuSettings.items.scroll_text[1366][768] = MainMenuSettings.items.scroll_text[1366][768] or {
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_14,
	font_size = 14 * SCALE_1366,
	line_height = 10 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	offset_x = 490 * SCALE_1366
}
MainMenuSettings.items.scroll_up_left_aligned = MainMenuSettings.items.scroll_up_left_aligned or {}
MainMenuSettings.items.scroll_up_left_aligned[1366] = MainMenuSettings.items.scroll_up_left_aligned[1366] or {}
MainMenuSettings.items.scroll_up_left_aligned[1366][768] = MainMenuSettings.items.scroll_up_left_aligned[1366][768] or {
	texture = "scroll_up_1920",
	padding_left = 0,
	padding_right = 0,
	padding_bottom = 0,
	texture_width = 24 * SCALE_1366,
	texture_height = 12 * SCALE_1366,
	color_disabled = {
		80,
		255,
		255,
		255
	},
	offset_x = -40 * SCALE_1366,
	padding_top = 4 * SCALE_1366
}
MainMenuSettings.items.scroll_down_left_aligned = MainMenuSettings.items.scroll_down_left_aligned or {}
MainMenuSettings.items.scroll_down_left_aligned[1366] = MainMenuSettings.items.scroll_down_left_aligned[1366] or {}
MainMenuSettings.items.scroll_down_left_aligned[1366][768] = MainMenuSettings.items.scroll_down_left_aligned[1366][768] or {
	texture = "scroll_down_1920",
	padding_top = 0,
	padding_right = 0,
	padding_left = 0,
	texture_width = 24 * SCALE_1366,
	texture_height = 12 * SCALE_1366,
	color_disabled = {
		80,
		255,
		255,
		255
	},
	offset_x = -40 * SCALE_1366,
	padding_bottom = 4 * SCALE_1366
}
MainMenuSettings.items.scroll_text_left_aligned = MainMenuSettings.items.scroll_text_left_aligned or {}
MainMenuSettings.items.scroll_text_left_aligned[1366] = MainMenuSettings.items.scroll_text_left_aligned[1366] or {}
MainMenuSettings.items.scroll_text_left_aligned[1366][768] = MainMenuSettings.items.scroll_text_left_aligned[1366][768] or {
	font_size = 14,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_14,
	line_height = 10 * SCALE_1366,
	color_disabled = {
		255,
		255,
		255,
		255
	},
	offset_x = -40 * SCALE_1366
}
MainMenuSettings.items.text_left_aligned = MainMenuSettings.items.text_left_aligned or {}
MainMenuSettings.items.text_left_aligned[1366] = MainMenuSettings.items.text_left_aligned[1366] or {}
MainMenuSettings.items.text_left_aligned[1366][768] = MainMenuSettings.items.text_left_aligned[1366][768] or {
	font_size = 22,
	texture_highlighted = "selected_item_bgr_left_1920",
	texture_alignment = "left",
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
	},
	color_highlighted = {
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
	padding_left = 20 * SCALE_1366
}
MainMenuSettings.items.buy_coins = MainMenuSettings.items.buy_coins or {}
MainMenuSettings.items.buy_coins[1366] = MainMenuSettings.items.buy_coins[1366] or {}
MainMenuSettings.items.buy_coins[1366][768] = MainMenuSettings.items.buy_coins[1366][768] or {
	font_size = 22,
	texture_highlighted = "selected_item_bgr_left_1920",
	texture_alignment = "left",
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		215,
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
	padding_left = 20 * SCALE_1366
}
MainMenuSettings.items.buy_coins_right_aligned = MainMenuSettings.items.buy_coins_right_aligned or {}
MainMenuSettings.items.buy_coins_right_aligned[1366] = MainMenuSettings.items.buy_coins_right_aligned[1366] or {}
MainMenuSettings.items.buy_coins_right_aligned[1366][768] = MainMenuSettings.items.buy_coins_right_aligned[1366][768] or {
	font_size = 22,
	texture_highlighted = "selected_item_bgr_right_1920",
	texture_alignment = "right",
	padding_left = 0,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		215,
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
	padding_right = 20 * SCALE_1366
}
MainMenuSettings.items.text_right_aligned = MainMenuSettings.items.text_right_aligned or {}
MainMenuSettings.items.text_right_aligned[1366] = MainMenuSettings.items.text_right_aligned[1366] or {}
MainMenuSettings.items.text_right_aligned[1366][768] = MainMenuSettings.items.text_right_aligned[1366][768] or {
	font_size = 22,
	texture_highlighted = "selected_item_bgr_right_1920",
	demo_font_size = 13,
	padding_left = 0,
	texture_unavailable_offset_x = 0.05,
	demo_text = "menu_demo_text",
	texture_alignment = "right",
	texture_unavalible_demo = "locked_demo_1920",
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
	},
	color_highlighted = {
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
	texture_unavalible_width = 64 * SCALE_1366,
	texture_unavalible_height = 32 * SCALE_1366,
	demo_font = MenuSettings.fonts.hell_shark_13,
	demo_color = {
		255,
		0,
		0
	},
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
MainMenuSettings.items.outfit_editor_text_left_aligned = MainMenuSettings.items.outfit_editor_text_left_aligned or {}
MainMenuSettings.items.outfit_editor_text_left_aligned[1366] = MainMenuSettings.items.outfit_editor_text_left_aligned[1366] or {}
MainMenuSettings.items.outfit_editor_text_left_aligned[1366][768] = MainMenuSettings.items.outfit_editor_text_left_aligned[1366][768] or {
	texture_unavalible_rank_not_met = "locked_xp_1920",
	texture_unavalible_perk_required = "locked_perk_1920",
	texture_unavalible_align = "left",
	texture_highlighted = "selected_item_bgr_left_1920",
	font_size = 22,
	padding_right = 0,
	texture_alignment = "left",
	texture_unavalible_demo = "locked_demo_1920",
	texture_unavalible_not_owned = "locked_money_1920",
	requirement_font_size = 13,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
	},
	color_highlighted = {
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
	color_unavalible = {
		255,
		100,
		100,
		100
	},
	color_render_from_child_page = {
		80,
		100,
		100,
		100
	},
	drop_shadow_color = {
		120,
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
	requirement_font = MenuSettings.fonts.hell_shark_13,
	requirement_text_offset_x = 52 * SCALE_1366,
	requirement_text_offset_y = 20 * SCALE_1366,
	requirement_not_met_color = {
		255,
		255,
		0,
		0
	},
	texture_highlighted_width = 652 * SCALE_1366,
	texture_highlighted_height = 36 * SCALE_1366,
	texture_unavalible_width = 64 * SCALE_1366,
	texture_unavalible_height = 32 * SCALE_1366,
	texture_unavalible_offset_x = 300 * SCALE_1366,
	texture_unavalible_offset_y = 1 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 20 * SCALE_1366
}
MainMenuSettings.items.outfit_editor_text_right_aligned = MainMenuSettings.items.outfit_editor_text_right_aligned or {}
MainMenuSettings.items.outfit_editor_text_right_aligned[1366] = MainMenuSettings.items.outfit_editor_text_right_aligned[1366] or {}
MainMenuSettings.items.outfit_editor_text_right_aligned[1366][768] = MainMenuSettings.items.outfit_editor_text_right_aligned[1366][768] or {
	texture_unavalible_rank_not_met = "locked_xp_1920",
	texture_unavalible_perk_required = "locked_perk_1920",
	texture_unavalible_align = "right",
	texture_highlighted = "selected_item_bgr_right_1920",
	font_size = 22,
	padding_left = 0,
	texture_alignment = "right",
	texture_unavalible_demo = "locked_demo_1920",
	texture_unavalible_not_owned = "locked_money_1920",
	requirement_font_size = 13,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
	},
	color_highlighted = {
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
	color_unavalible = {
		255,
		100,
		100,
		100
	},
	color_render_from_child_page = {
		80,
		100,
		100,
		100
	},
	drop_shadow_color = {
		120,
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
	requirement_font = MenuSettings.fonts.hell_shark_13,
	requirement_text_offset_x = 52 * SCALE_1366,
	requirement_text_offset_y = 20 * SCALE_1366,
	requirement_not_met_color = {
		255,
		255,
		0,
		0
	},
	texture_highlighted_width = 652 * SCALE_1366,
	texture_highlighted_height = 36 * SCALE_1366,
	texture_unavalible_width = 64 * SCALE_1366,
	texture_unavalible_height = 32 * SCALE_1366,
	texture_unavalible_offset_x = -360 * SCALE_1366,
	texture_unavalible_offset_y = 1 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
MainMenuSettings.items.outfit_editor_checkbox_left_aligned = MainMenuSettings.items.outfit_editor_checkbox_left_aligned or {}
MainMenuSettings.items.outfit_editor_checkbox_left_aligned[1366] = MainMenuSettings.items.outfit_editor_checkbox_left_aligned[1366] or {}
MainMenuSettings.items.outfit_editor_checkbox_left_aligned[1366][768] = MainMenuSettings.items.outfit_editor_checkbox_left_aligned[1366][768] or {
	texture_highlighted = "selected_item_bgr_left_1920",
	texture_unavalible_rank_not_met = "locked_xp_1920",
	texture_unavalible_align = "left",
	texture_unavalible_perk_required = "locked_perk_1920",
	font_size = 22,
	texture_selected = "checkbox_on",
	texture_alignment = "left",
	texture_unavalible_demo = "locked_demo_1920",
	texture_unavalible_not_owned = "locked_money_1920",
	padding_right = 0,
	texture_deselected = "checkbox_off",
	requirement_font_size = 13,
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
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
		40,
		255,
		255,
		255
	},
	color_unavalible = {
		40,
		255,
		255,
		255
	},
	color_render_from_child_page = {
		160,
		0,
		0,
		0
	},
	requirement_font = MenuSettings.fonts.hell_shark_13,
	requirement_text_offset_x = 52 * SCALE_1366,
	requirement_text_offset_y = 20 * SCALE_1366,
	requirement_not_met_color = {
		255,
		255,
		0,
		0
	},
	texture_highlighted_width = 652 * SCALE_1366,
	texture_highlighted_height = 36 * SCALE_1366,
	texture_selected_width = 40 * SCALE_1366,
	texture_selected_height = 40 * SCALE_1366,
	texture_selected_offset_x = 10 * SCALE_1366,
	texture_deselected_width = 40 * SCALE_1366,
	texture_deselected_height = 40 * SCALE_1366,
	texture_deselected_offset_x = 10 * SCALE_1366,
	texture_disabled_color = {
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
	texture_unavalible_width = 64 * SCALE_1366,
	texture_unavalible_height = 32 * SCALE_1366,
	texture_unavalible_offset_x = 300 * SCALE_1366,
	texture_unavalible_offset_y = 1 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 60 * SCALE_1366
}
MainMenuSettings.items.ddl_closed_text_left_aligned = MainMenuSettings.items.ddl_closed_text_left_aligned or {}
MainMenuSettings.items.ddl_closed_text_left_aligned[1366] = MainMenuSettings.items.ddl_closed_text_left_aligned[1366] or {}
MainMenuSettings.items.ddl_closed_text_left_aligned[1366][768] = MainMenuSettings.items.ddl_closed_text_left_aligned[1366][768] or {
	padding_right = 0,
	texture_highlighted = "selected_item_bgr_left_1920",
	texture_arrow = "drop_down_list_arrow",
	font_size = 22,
	texture_alignment = "left",
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
	},
	color_highlighted = {
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
	texture_highlighted_width = 652 * SCALE_1366,
	texture_highlighted_height = 36 * SCALE_1366,
	texture_arrow_width = 20 * SCALE_1366,
	texture_arrow_height = 12 * SCALE_1366,
	texture_arrow_offset_x = 10 * SCALE_1366,
	texture_arrow_offset_y = 3 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 8 * SCALE_1366,
	padding_left = 36 * SCALE_1366
}
MainMenuSettings.items.ddl_closed_text_right_aligned = MainMenuSettings.items.ddl_closed_text_right_aligned or {}
MainMenuSettings.items.ddl_closed_text_right_aligned[1366] = MainMenuSettings.items.ddl_closed_text_right_aligned[1366] or {}
MainMenuSettings.items.ddl_closed_text_right_aligned[1366][768] = MainMenuSettings.items.ddl_closed_text_right_aligned[1366][768] or {
	texture_arrow_offset_x = 0,
	texture_highlighted = "selected_item_bgr_right_1920",
	texture_arrow = "drop_down_list_arrow",
	padding_left = 0,
	font_size = 22,
	texture_alignment = "right",
	font = MenuSettings.fonts.hell_shark_22,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
	},
	color_highlighted = {
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
	texture_arrow_width = 20 * SCALE_1366,
	texture_arrow_height = 12 * SCALE_1366,
	texture_arrow_offset_y = 3 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_right = 26 * SCALE_1366
}
MainMenuSettings.items.ddl_open_text_right_aligned = MainMenuSettings.items.ddl_open_text_right_aligned or {}
MainMenuSettings.items.ddl_open_text_right_aligned[1366] = MainMenuSettings.items.ddl_open_text_right_aligned[1366] or {}
MainMenuSettings.items.ddl_open_text_right_aligned[1366][768] = MainMenuSettings.items.ddl_open_text_right_aligned[1366][768] or {
	font_size = 22,
	texture_highlighted = "selected_item_bgr_right_1920",
	texture_alignment = "right",
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
MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll = MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll or {}
MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll[1366] = MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll[1366] or {}
MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll[1366][768] = MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll[1366][768] or table.clone(MainMenuSettings.items.ddl_open_text_right_aligned[1366][768])
MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll[1366][768].padding_left = 4
MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll[1366][768].padding_right = 4
MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll[1366][768].texture_offset_x = 15
MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll[1366][768].offset_z = 10
MainMenuSettings.items.ddl_open_text_left_aligned = MainMenuSettings.items.ddl_open_text_left_aligned or {}
MainMenuSettings.items.ddl_open_text_left_aligned[1366] = MainMenuSettings.items.ddl_open_text_left_aligned[1366] or {}
MainMenuSettings.items.ddl_open_text_left_aligned[1366][768] = MainMenuSettings.items.ddl_open_text_left_aligned[1366][768] or {
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
MainMenuSettings.items.outfit_ddl_open_text_left_aligned = MainMenuSettings.items.outfit_ddl_open_text_left_aligned or {}
MainMenuSettings.items.outfit_ddl_open_text_left_aligned[1366] = MainMenuSettings.items.outfit_ddl_open_text_left_aligned[1366] or {}
MainMenuSettings.items.outfit_ddl_open_text_left_aligned[1366][768] = MainMenuSettings.items.outfit_ddl_open_text_left_aligned[1366][768] or {
	texture_unavalible_rank_not_met = "locked_xp_1920",
	texture_unavalible_perk_required = "locked_perk_1920",
	texture_unavalible_align = "left",
	texture_highlighted = "selected_item_bgr_left_1920",
	font_size = 22,
	texture_alignment = "left",
	texture_unavalible_demo = "locked_demo_1920",
	texture_unavalible_not_owned = "locked_money_1920",
	requirement_font_size = 13,
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
		100,
		100,
		100
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
	requirement_font = MenuSettings.fonts.hell_shark_13,
	requirement_text_offset_x = 52 * SCALE_1366,
	requirement_text_offset_y = 20 * SCALE_1366,
	requirement_not_met_color = {
		255,
		255,
		0,
		0
	},
	texture_unavalible_width = 64 * SCALE_1366,
	texture_unavalible_height = 32 * SCALE_1366,
	texture_unavalible_offset_x = 360 * SCALE_1366,
	texture_unavalible_offset_y = 1 * SCALE_1366,
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366,
	padding_left = 20 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
MainMenuSettings.items.drop_down_list_scroll_bar = MainMenuSettings.items.drop_down_list_scroll_bar or {}
MainMenuSettings.items.drop_down_list_scroll_bar[1366] = MainMenuSettings.items.drop_down_list_scroll_bar[1366] or {}
MainMenuSettings.items.drop_down_list_scroll_bar[1366][768] = MainMenuSettings.items.drop_down_list_scroll_bar[1366][768] or {
	scroll_bar_handle_width = 6,
	width = 16,
	scroll_bar_width = 2,
	scroll_bar_handle_color = {
		255,
		100,
		100,
		100
	},
	scroll_bar_color = {
		255,
		130,
		130,
		130
	},
	background_color = {
		255,
		255,
		255,
		255
	}
}
MainMenuSettings.items.texture_button_left_aligned = MainMenuSettings.items.texture_button_left_aligned or {}
MainMenuSettings.items.texture_button_left_aligned[1366] = MainMenuSettings.items.texture_button_left_aligned[1366] or {}
MainMenuSettings.items.texture_button_left_aligned[1366][768] = MainMenuSettings.items.texture_button_left_aligned[1366][768] or {
	text_padding = 1,
	texture_right_width = 8,
	texture_left = "small_button_left_1366",
	text_offset_y = 7,
	font_size = 18,
	texture_middle = "small_button_center_1366",
	texture_right = "small_button_right_1366",
	padding_bottom = 5,
	texture_middle_highlighted = "small_button_center_highlighted_1366",
	texture_right_highlighted = "small_button_right_highlighted_1366",
	padding_top = 10,
	texture_left_width = 8,
	texture_left_highlighted = "small_button_left_highlighted_1366",
	padding_left = 12,
	padding_right = 0,
	texture_height = 24,
	font = MenuSettings.fonts.hell_shark_18,
	text_color = {
		255,
		255,
		255,
		255
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
MainMenuSettings.items.delimiter_texture = MainMenuSettings.items.delimiter_texture or {}
MainMenuSettings.items.delimiter_texture[1366] = MainMenuSettings.items.delimiter_texture[1366] or {}
MainMenuSettings.items.delimiter_texture[1366][768] = MainMenuSettings.items.delimiter_texture[1366][768] or {
	padding_left = 0,
	texture = "item_list_horizontal_line_1920",
	padding_right = 0,
	texture_width = 340 * SCALE_1366,
	texture_height = 4 * SCALE_1366,
	color_render_from_child_page = {
		80,
		255,
		255,
		255
	},
	padding_top = 6 * SCALE_1366,
	padding_bottom = 4 * SCALE_1366
}
MainMenuSettings.items.delimiter_texture_left = MainMenuSettings.items.delimiter_texture_left or {}
MainMenuSettings.items.delimiter_texture_left[1366] = MainMenuSettings.items.delimiter_texture_left[1366] or {}
MainMenuSettings.items.delimiter_texture_left[1366][768] = MainMenuSettings.items.delimiter_texture_left[1366][768] or {
	padding_left = 0,
	texture = "item_list_horizontal_line_left_1920",
	padding_right = 0,
	texture_width = 340 * SCALE_1366,
	texture_height = 4 * SCALE_1366,
	color_render_from_child_page = {
		80,
		255,
		255,
		255
	},
	padding_top = 6 * SCALE_1366,
	padding_bottom = 4 * SCALE_1366
}
MainMenuSettings.items.thin_delimiter_texture = MainMenuSettings.items.thin_delimiter_texture or {}
MainMenuSettings.items.thin_delimiter_texture[1366] = MainMenuSettings.items.thin_delimiter_texture[1366] or {}
MainMenuSettings.items.thin_delimiter_texture[1366][768] = MainMenuSettings.items.thin_delimiter_texture[1366][768] or {
	texture = "thin_horizontal_delimiter_1920",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	texture_width = 464 * SCALE_1366,
	texture_height = 4 * SCALE_1366
}
MainMenuSettings.items.empty = MainMenuSettings.items.empty or {}
MainMenuSettings.items.empty[1366] = MainMenuSettings.items.empty[1366] or {}
MainMenuSettings.items.empty[1366][768] = MainMenuSettings.items.empty[1366][768] or {}
MainMenuSettings.items.text_back = MainMenuSettings.items.text_back or {}
MainMenuSettings.items.text_back[1366] = MainMenuSettings.items.text_back[1366] or {}
MainMenuSettings.items.text_back[1366][768] = MainMenuSettings.items.text_back[1366][768] or {
	font_size = 14,
	font = MenuSettings.fonts.hell_shark_14,
	line_height = 21 * SCALE_1366,
	color = {
		255,
		255,
		255,
		255
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
	drop_shadow_color = {
		120,
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
	padding_top = 6 * SCALE_1366,
	padding_bottom = 6 * SCALE_1366,
	padding_left = 6 * SCALE_1366,
	padding_right = 6 * SCALE_1366
}
MainMenuSettings.items.lobby_host = MainMenuSettings.items.lobby_host or {}
MainMenuSettings.items.lobby_host[1366] = MainMenuSettings.items.lobby_host[1366] or {}
MainMenuSettings.items.lobby_host[1366][768] = MainMenuSettings.items.lobby_host[1366][768] or {
	font_size = 14,
	font = MenuSettings.fonts.hell_shark_14
}
MainMenuSettings.items.lobby_join = MainMenuSettings.items.lobby_join or {}
MainMenuSettings.items.lobby_join[1366] = MainMenuSettings.items.lobby_join[1366] or {}
MainMenuSettings.items.lobby_join[1366][768] = {
	font_size = 14,
	font = MenuSettings.fonts.hell_shark_14
}
MainMenuSettings.items.outfit_selection = MainMenuSettings.items.outfit_selection or {}
MainMenuSettings.items.outfit_selection[1366] = MainMenuSettings.items.outfit_selection[1366] or {}
MainMenuSettings.items.outfit_selection[1366][768] = MainMenuSettings.items.outfit_selection[1366][768] or {
	padding_left = 0,
	font_size = 16,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_16,
	color = {
		255,
		150,
		150,
		150
	},
	color_highlighted = {
		255,
		150,
		0,
		0
	},
	color_disabled = {
		255,
		50,
		50,
		50
	},
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366
}
MainMenuSettings.items.outfit_multiple_selection = MainMenuSettings.items.outfit_multiple_selection or {}
MainMenuSettings.items.outfit_multiple_selection[1366] = MainMenuSettings.items.outfit_multiple_selection[1366] or {}
MainMenuSettings.items.outfit_multiple_selection[1366][768] = MainMenuSettings.items.outfit_multiple_selection[1366][768] or {
	padding_left = 0,
	font_size = 16,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_16,
	color = {
		255,
		150,
		150,
		150
	},
	color_highlighted = {
		255,
		150,
		0,
		0
	},
	color_selected = {
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
	padding_top = 7 * SCALE_1366,
	padding_bottom = 7 * SCALE_1366
}
MainMenuSettings.items.loading_indicator = MainMenuSettings.items.loading_indicator or {}
MainMenuSettings.items.loading_indicator[1366] = MainMenuSettings.items.loading_indicator[1366] or {}
MainMenuSettings.items.loading_indicator[1366][768] = MainMenuSettings.items.loading_indicator[1366][768] or {
	screen_align_y = "bottom",
	screen_offset_x = -0.04,
	pivot_align_y = "bottom",
	fade_end_delay = 1,
	pivot_offset_y = 0,
	font_size = 20,
	screen_align_x = "right",
	texture_rotation_angle = 90,
	fade_start_delay = 2,
	texture = "loading_icon_mockup",
	pivot_offset_x = 0,
	screen_offset_y = 0.08,
	pivot_align_x = "right",
	texture_color = {
		255,
		255,
		255,
		255
	},
	texture_scale = 0.6 * SCALE_1366,
	text_color = {
		255,
		255,
		255,
		255
	},
	font = MenuSettings.fonts.hell_shark_20,
	text_padding = 20 * SCALE_1366,
	loading_icon_config = {
		padding_left = 0,
		padding_right = 0,
		texture_atlas = "loading_atlas",
		animation_speed = 30,
		frames = {},
		texture_width = 40 * SCALE_1366,
		texture_height = 40 * SCALE_1366,
		texture_atlas_settings = LoadingAtlas,
		padding_top = 18 * SCALE_1366,
		padding_bottom = -50 * SCALE_1366,
		scale = 0.5 * SCALE_1366
	}
}

for i = 1, 72 do
	MainMenuSettings.items.loading_indicator[1366][768].loading_icon_config.frames[i] = string.format("loading_shield_%.2d", i)
end

MainMenuSettings.items.popup_twitter_link = MainMenuSettings.items.popup_twitter_link or {}
MainMenuSettings.items.popup_twitter_link[1366] = MainMenuSettings.items.popup_twitter_link[1366] or {}
MainMenuSettings.items.popup_twitter_link[1366][768] = MainMenuSettings.items.popup_twitter_link[1366][768] or {
	texture = "twitter_1366",
	texture_highlighted = "twitter_highlighted_1366",
	texture_highlighted_height = 32,
	texture_width = 32,
	texture_highlighted_width = 32,
	texture_highlighted_offset_z = 2,
	texture_height = 32,
	padding_top = 19 * SCALE_1366,
	padding_bottom = 13 * SCALE_1366,
	padding_left = 10 * SCALE_1366,
	padding_right = 10 * SCALE_1366
}
MainMenuSettings.items.sale_popup_item_texture = MainMenuSettings.items.sale_popup_item_texture or {}
MainMenuSettings.items.sale_popup_item_texture[1366] = MainMenuSettings.items.sale_popup_item_texture[1366] or {}
MainMenuSettings.items.sale_popup_item_texture[1366][768] = MainMenuSettings.items.sale_popup_item_texture[1366][768] or {
	padding_left = 5,
	padding_top = 0,
	padding_right = 5,
	padding_bottom = 5
}
MainMenuSettings.items.sale_popup_item_header = MainMenuSettings.items.sale_popup_item_header or {}
MainMenuSettings.items.sale_popup_item_header[1366] = {}
MainMenuSettings.items.sale_popup_item_header[1366][768] = {
	line_height = 20,
	padding_left = 10,
	padding_x = 20,
	padding_y = 20,
	font_size = 36,
	padding_top = 10,
	padding_right = 10,
	padding_bottom = 10,
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
MainMenuSettings.items.sale_popup_button = MainMenuSettings.items.sale_popup_button or {}
MainMenuSettings.items.sale_popup_button[1366] = MainMenuSettings.items.sale_popup_button[1366] or {}
MainMenuSettings.items.sale_popup_button[1366][768] = MainMenuSettings.items.sale_popup_button[1366][768] or {
	line_height = 26,
	padding_left = 10,
	padding_x = 20,
	padding_y = 20,
	font_size = 24,
	padding_top = 10,
	padding_right = 10,
	padding_bottom = 10,
	font = MenuSettings.fonts.hell_shark_20,
	color = {
		255,
		255,
		255,
		255
	},
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
MainMenuSettings.items.sale_popup_item_desc = MainMenuSettings.items.sale_popup_item_desc or {}
MainMenuSettings.items.sale_popup_item_desc[1366] = {}
MainMenuSettings.items.sale_popup_item_desc[1366][768] = {
	line_height = 20,
	width = 590,
	padding_left = 5,
	padding_right = 5,
	font_size = 18,
	padding_top = 0,
	text_align = "left",
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_20,
	color = {
		255,
		255,
		255,
		255
	},
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
MainMenuSettings.items.sale_popup_arrow_left = MainMenuSettings.items.sale_popup_arrow_left or {}
MainMenuSettings.items.sale_popup_arrow_left[1366] = {}
MainMenuSettings.items.sale_popup_arrow_left[1366][768] = {
	texture = "sale_popup",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	atlas_settings = sale_popup_atlas.sale_popup_arow_left
}
MainMenuSettings.items.sale_popup_arrow_right = MainMenuSettings.items.sale_popup_arrow_right or {}
MainMenuSettings.items.sale_popup_arrow_right[1366] = {}
MainMenuSettings.items.sale_popup_arrow_right[1366][768] = {
	texture = "sale_popup",
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0,
	atlas_settings = sale_popup_atlas.sale_popup_arow_right
}
MainMenuSettings.items.sale_popup_close_button = MainMenuSettings.items.sale_popup_close_button or {}
MainMenuSettings.items.sale_popup_close_button[1366] = {}
MainMenuSettings.items.sale_popup_close_button[1366][768] = {
	texture = "sale_popup",
	padding_left = 20,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 65,
	atlas_settings = sale_popup_atlas.sale_popup_close
}
MainMenuSettings.items.sale_popup_header_text_price_off = MainMenuSettings.items.sale_popup_header_text_price_off or {}
MainMenuSettings.items.sale_popup_header_text_price_off[1366] = MainMenuSettings.items.sale_popup_header_text_price_off[1366] or {}
MainMenuSettings.items.sale_popup_header_text_price_off[1366][768] = MainMenuSettings.items.sale_popup_header_text_price_off[1366][768] or {
	line_height = 36,
	padding_left = 0,
	font_size = 32,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 20,
	font = MenuSettings.fonts.hell_shark_28,
	color = {
		255,
		255,
		145,
		48
	},
	color_disabled = {
		255,
		255,
		145,
		48
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
MainMenuSettings.items.sale_popup_header_text = MainMenuSettings.items.sale_popup_header_text or {}
MainMenuSettings.items.sale_popup_header_text[1366] = MainMenuSettings.items.sale_popup_header_text[1366] or {}
MainMenuSettings.items.sale_popup_header_text[1366][768] = MainMenuSettings.items.sale_popup_header_text[1366][768] or {
	line_height = 36,
	padding_left = 0,
	font_size = 40,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 12,
	font = MenuSettings.fonts.hell_shark_36,
	color = {
		255,
		255,
		145,
		48
	},
	color_disabled = {
		255,
		255,
		145,
		48
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
MainMenuSettings.items.sale_popup_price_text = MainMenuSettings.items.sale_popup_price_text or {}
MainMenuSettings.items.sale_popup_price_text[1366] = MainMenuSettings.items.sale_popup_price_text[1366] or {}
MainMenuSettings.items.sale_popup_price_text[1366][768] = MainMenuSettings.items.sale_popup_price_text[1366][768] or {
	texture_disabled = "coins_1920",
	padding_left = 0,
	font_size = 40,
	padding_top = 0,
	texture_alignment = "left",
	padding_bottom = 12,
	line_height = 36,
	texture_offset_y = 0,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_36,
	texture_disabled_width = 40 * SCALE_1366,
	texture_disabled_height = 26 * SCALE_1366,
	texture_offset_x = -40 * SCALE_1366,
	color = {
		255,
		255,
		145,
		48
	},
	color_disabled = {
		255,
		255,
		145,
		48
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
MainMenuSettings.items.sale_popup_header_icon = MainMenuSettings.items.sale_popup_header_icon or {}
MainMenuSettings.items.sale_popup_header_icon[1366] = MainMenuSettings.items.sale_popup_header_icon[1366] or {}
MainMenuSettings.items.sale_popup_header_icon[1366][768] = MainMenuSettings.items.sale_popup_header_icon[1366][768] or {
	texture = "sale_popup",
	padding_left = -15,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = -8,
	atlas_settings = sale_popup_atlas.sale_popup_seal_fg
}
MainMenuSettings.items.sale_popup_index_indicator = MainMenuSettings.items.sale_popup_index_indicator or {}
MainMenuSettings.items.sale_popup_index_indicator[1366] = {}
MainMenuSettings.items.sale_popup_index_indicator[1366][768] = {
	selected_texture = "sale_popup",
	texture_width = 9,
	texture_spacing = 14,
	unselected_texture = "sale_popup",
	texture_height = 9,
	unselected_texture_settings = sale_popup_atlas.sale_popup_dot_black,
	selected_texture_settings = sale_popup_atlas.sale_popup_dot_white,
	selected_texture_color = {
		255,
		255,
		255,
		255
	},
	unselected_texture_color = {
		80,
		255,
		255,
		255
	}
}
MainMenuSettings.pages.text_input_popup = MainMenuSettings.pages.text_input_popup or {}
MainMenuSettings.pages.text_input_popup[1366] = MainMenuSettings.pages.text_input_popup[1366] or {}
MainMenuSettings.pages.text_input_popup[1366][768] = MainMenuSettings.pages.text_input_popup[1366][768] or {
	header_list = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "center",
		screen_align_x = "center",
		number_of_columns = 1,
		pivot_offset_y = 100 * SCALE_1366,
		column_width = {
			604 * SCALE_1366
		},
		column_alignment = {
			"left"
		}
	},
	item_list = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "center",
		screen_align_x = "center",
		number_of_columns = 1,
		pivot_offset_y = 34 * SCALE_1366,
		column_width = {
			604 * SCALE_1366
		},
		column_alignment = {
			"center"
		}
	},
	button_list = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "center",
		screen_align_x = "center",
		number_of_columns = 2,
		pivot_offset_y = -60 * SCALE_1366,
		column_alignment = {
			"right",
			"left"
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
		absolute_width = 604 * SCALE_1366,
		absolute_height = 230 * SCALE_1366,
		color = {
			220,
			20,
			20,
			20
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
	}
}
MainMenuSettings.pages.text_input_popup_no_overlay = MainMenuSettings.pages.text_input_popup_no_overlay or {}
MainMenuSettings.pages.text_input_popup_no_overlay[1366] = MainMenuSettings.pages.text_input_popup_no_overlay[1366] or {}
MainMenuSettings.pages.text_input_popup_no_overlay[1366][768] = MainMenuSettings.pages.text_input_popup_no_overlay[1366][768] or table.clone(MainMenuSettings.pages.text_input_popup[1366][768])
MainMenuSettings.pages.text_input_popup_no_overlay[1366][768].overlay_texture = nil
MainMenuSettings.pages.demo_popup = MainMenuSettings.pages.demo_popup or {}
MainMenuSettings.pages.demo_popup[1366] = MainMenuSettings.pages.demo_popup[1366] or {}
MainMenuSettings.pages.demo_popup[1366][768] = MainMenuSettings.pages.demo_popup[1366][768] or table.clone(MainMenuSettings.pages.text_input_popup[1366][768])
MainMenuSettings.pages.demo_popup[1366][768].button_list.number_of_columns = 2
MainMenuSettings.pages.demo_popup[1366][768].button_list.column_alignment = {
	"left",
	"right"
}
MainMenuSettings.pages.demo_popup[1366][768].button_list.pivot_align_x = "right"
MainMenuSettings.pages.demo_popup[1366][768].button_list.pivot_offset_x = 210 * SCALE_1366
MainMenuSettings.pages.demo_popup[1366][768].button_list.pivot_offset_y = -70 * SCALE_1366
MainMenuSettings.pages.demo_popup[1366][768].background_texture = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "demo_popup_1920",
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	texture_width = 676 * SCALE_1366,
	texture_height = 592 * SCALE_1366
}
MainMenuSettings.pages.buy_gold_popup = MainMenuSettings.pages.buy_gold_popup or {}
MainMenuSettings.pages.buy_gold_popup[1366] = MainMenuSettings.pages.buy_gold_popup[1366] or {}
MainMenuSettings.pages.buy_gold_popup[1366][768] = MainMenuSettings.pages.buy_gold_popup[1366][768] or table.clone(MainMenuSettings.pages.text_input_popup[1366][768])
MainMenuSettings.pages.buy_gold_popup[1366][768].background_rect.absolute_height = 710
MainMenuSettings.pages.buy_gold_popup[1366][768].background_rect.absolute_width = 664
MainMenuSettings.pages.buy_gold_popup[1366][768].header_list.number_of_columns = 2
MainMenuSettings.pages.buy_gold_popup[1366][768].header_list.column_width = {
	327,
	327
}
MainMenuSettings.pages.buy_gold_popup[1366][768].header_list.column_alignment = {
	"left",
	"right"
}
MainMenuSettings.pages.buy_gold_popup[1366][768].header_list.pivot_offset_y = (MainMenuSettings.pages.buy_gold_popup[1366][768].background_rect.absolute_height - 30) * 0.5
MainMenuSettings.pages.buy_gold_popup[1366][768].item_list.pivot_offset_y = MainMenuSettings.pages.buy_gold_popup[1366][768].header_list.pivot_offset_y - 36
MainMenuSettings.pages.buy_gold_popup[1366][768].button_list.number_of_columns = 1
MainMenuSettings.pages.buy_gold_popup[1366][768].button_list.column_alignment = {
	"center"
}
MainMenuSettings.pages.buy_gold_popup[1366][768].button_list.column_width = {
	650
}
MainMenuSettings.pages.buy_gold_popup[1366][768].button_list.pivot_offset_y = -20
MainMenuSettings.pages.message_popup = MainMenuSettings.pages.message_popup or {}
MainMenuSettings.pages.message_popup[1366] = MainMenuSettings.pages.message_popup[1366] or {}
MainMenuSettings.pages.message_popup[1366][768] = MainMenuSettings.pages.message_popup[1366][768] or table.clone(MainMenuSettings.pages.text_input_popup[1366][768])
MainMenuSettings.pages.message_popup[1366][768].button_list.number_of_columns = 1
MainMenuSettings.pages.message_popup[1366][768].button_list.column_width = nil
MainMenuSettings.pages.message_popup[1366][768].button_list.column_alignment = {
	"center"
}
MainMenuSettings.pages.message_popup_no_overlay = MainMenuSettings.pages.message_popup_no_overlay or {}
MainMenuSettings.pages.message_popup_no_overlay[1366] = MainMenuSettings.pages.message_popup_no_overlay[1366] or {}
MainMenuSettings.pages.message_popup_no_overlay[1366][768] = MainMenuSettings.pages.message_popup_no_overlay[1366][768] or table.clone(MainMenuSettings.pages.message_popup[1366][768])
MainMenuSettings.pages.message_popup_no_overlay[1366][768].overlay_texture = nil
MainMenuSettings.pages.expandable_popup = MainMenuSettings.pages.expandable_popup or {}
MainMenuSettings.pages.expandable_popup[1366] = MainMenuSettings.pages.expandable_popup[1366] or {}
MainMenuSettings.pages.expandable_popup[1366][768] = MainMenuSettings.pages.expandable_popup[1366][768] or {
	item_list = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		pivot_offset_y = 0,
		screen_align_x = "center",
		number_of_columns = 3,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		column_alignment = {
			"left",
			"center",
			"center"
		},
		column_width = {
			144,
			144,
			144
		}
	},
	background_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "skeleton_flipped_1366",
		pivot_offset_y = 0,
		texture_width = 192,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_height = 228
	},
	background_rect = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		pivot_offset_y = 0,
		screen_align_x = "center",
		absolute_width = 432,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		border_size = 1,
		color = {
			220,
			20,
			20,
			20
		},
		border_color = {
			220,
			80,
			80,
			80
		}
	}
}
MainMenuSettings.pages.changelog_popup = MainMenuSettings.pages.changelog_popup or {}
MainMenuSettings.pages.changelog_popup[1366] = MainMenuSettings.pages.changelog_popup[1366] or {}
MainMenuSettings.pages.changelog_popup[1366][768] = MainMenuSettings.pages.changelog_popup[1366][768] or {
	item_list = {
		headers = {
			columns = {
				{
					width = 500,
					align = "center"
				}
			},
			rows = {
				{
					align = "center",
					height = 60
				}
			}
		},
		items = {
			columns = {
				{
					width = 144,
					align = "left"
				},
				{
					width = 144,
					align = "center"
				},
				{
					width = 144,
					align = "center"
				}
			},
			rows = {
				{
					align = "center",
					height = 140
				}
			}
		}
	},
	background_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "skeleton_flipped_1366",
		pivot_offset_y = 0,
		texture_width = 192,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_height = 228
	},
	background_rect = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		pivot_offset_y = 0,
		screen_align_x = "center",
		absolute_width = 432,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		border_size = 1,
		color = {
			220,
			20,
			20,
			20
		},
		border_color = {
			220,
			80,
			80,
			80
		}
	}
}
MainMenuSettings.pages.level_1 = MainMenuSettings.pages.level_1 or {}
MainMenuSettings.pages.level_1[1366] = MainMenuSettings.pages.level_1[1366] or {}
MainMenuSettings.pages.level_1[1366][768] = MainMenuSettings.pages.level_1[1366][768] or {
	item_list = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = -0.25,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "left",
		pivot_offset_x = 540 * SCALE_1366,
		column_alignment = {
			"right"
		}
	},
	news_ticker = {
		screen_align_x = "left",
		height = 32,
		pivot_offset_y = -8,
		pivot_align_y = "top",
		screen_offset_x = 0,
		text_offset_y = 9,
		screen_align_y = "top",
		left_background_texture_height = 32,
		right_background_texture = "news_ticker_right_1366",
		left_background_texture = "news_ticker_left_1366",
		right_background_texture_width = 392,
		delimiter_texture = "news_ticker_delimiter_1366",
		delimiter_texture_height = 28,
		right_background_texture_height = 32,
		font_size = 18,
		text_spacing = 156,
		delimiter_texture_offset_y = 2,
		delimiter_texture_width = 64,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "left",
		left_background_texture_width = 392,
		font = MenuSettings.fonts.hell_shark_18,
		text_color = {
			255,
			255,
			255,
			255
		},
		text_shadow_color = {
			200,
			0,
			0,
			0
		},
		text_shadow_offset = {
			2,
			-2
		},
		delimiter_texture_color = {
			200,
			255,
			255,
			255
		},
		background_rect_color = {
			80,
			0,
			0,
			0
		},
		background_texture_color = {
			150,
			255,
			255,
			255
		}
	},
	tooltip_text_box = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		pivot_offset_y = 0,
		font_size = 16,
		text_align = "right",
		screen_align_x = "left",
		screen_offset_y = -0.6,
		pivot_align_x = "right",
		pivot_offset_x = 520 * SCALE_1366,
		font = MenuSettings.fonts.hell_shark_16,
		color = {
			255,
			255,
			255,
			255
		},
		line_height = 28 * SCALE_1366,
		width = 440 * SCALE_1366,
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
	logo_texture = {
		screen_align_y = "bottom",
		screen_offset_x = -0.02,
		pivot_align_y = "bottom",
		texture = "menu_logo_1366",
		pivot_offset_y = 0,
		texture_width = 596,
		screen_align_x = "right",
		pivot_offset_x = 0,
		screen_offset_y = 0.04,
		pivot_align_x = "right",
		texture_height = 316
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
	gradient_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_gradient_1920",
		pivot_offset_y = 0,
		stretch_relative_height = 1,
		screen_align_x = "left",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_width = 636 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		stretch_width = 540 * SCALE_1366
	},
	vertical_line_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_offset_y = 0,
		screen_align_x = "left",
		texture = "item_list_vertical_line_1920",
		pivot_offset_x = 540 * SCALE_1366,
		texture_width = 16 * SCALE_1366,
		texture_height = 1016 * SCALE_1366
	},
	corner_top_texture = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "left",
		texture = "item_list_top_corner_1920",
		pivot_offset_x = 536 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	},
	corner_bottom_texture = {
		screen_align_y = "bottom",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "left",
		texture = "item_list_bottom_corner_1920",
		pivot_offset_x = 536 * SCALE_1366,
		texture_width = 416 * SCALE_1366,
		texture_height = 308 * SCALE_1366
	}
}
MainMenuSettings.pages.level_2 = MainMenuSettings.pages.level_2 or {}
MainMenuSettings.pages.level_2[1366] = MainMenuSettings.pages.level_2[1366] or {}
MainMenuSettings.pages.level_2[1366][768] = MainMenuSettings.pages.level_2[1366][768] or {
	item_list = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = -0.25,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "left",
		pivot_offset_x = 540 * SCALE_1366,
		column_alignment = {
			"right"
		}
	},
	tooltip_text_box = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		pivot_offset_y = 0,
		font_size = 16,
		text_align = "right",
		screen_align_x = "left",
		screen_offset_y = -0.6,
		pivot_align_x = "right",
		pivot_offset_x = 520 * SCALE_1366,
		font = MenuSettings.fonts.hell_shark_16,
		color = {
			255,
			255,
			255,
			255
		},
		line_height = 28 * SCALE_1366,
		width = 440 * SCALE_1366,
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
	back_list = {
		screen_align_y = "bottom",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 2,
		screen_align_x = "left",
		pivot_offset_x = 0 * SCALE_1366,
		pivot_offset_y = 30 * SCALE_1366,
		column_alignment = {
			"left",
			"left"
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
	background_texture = {
		texture = "item_list_gradient_2_1920",
		stretch_relative_width = 1,
		texture_width = 4 * SCALE_1366,
		texture_height = 600 * SCALE_1366
	},
	horizontal_line_top_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_top_horizontal_line_1920",
		pivot_offset_y = 0,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_width = 1000 * SCALE_1366,
		texture_height = 12 * SCALE_1366
	},
	horizontal_line_bottom_texture = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		texture = "item_list_bottom_horizontal_line_1920",
		pivot_offset_y = 0,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_height = 12,
		texture_width = 1000 * SCALE_1366
	}
}
MainMenuSettings.pages.level_3 = MainMenuSettings.pages.level_3 or {}
MainMenuSettings.pages.level_3[1366] = MainMenuSettings.pages.level_3[1366] or {}
MainMenuSettings.pages.level_3[1366][768] = MainMenuSettings.pages.level_3[1366][768] or {
	item_list = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = -0.25,
		pivot_align_x = "right",
		pivot_offset_y = 0,
		screen_align_x = "left",
		pivot_offset_x = 540 * SCALE_1366,
		column_alignment = {
			"right"
		}
	},
	tooltip_text_box = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		pivot_offset_y = 0,
		font_size = 16,
		text_align = "right",
		screen_align_x = "left",
		screen_offset_y = -0.6,
		pivot_align_x = "right",
		pivot_offset_x = 520 * SCALE_1366,
		font = MenuSettings.fonts.hell_shark_16,
		color = {
			255,
			255,
			255,
			255
		},
		line_height = 28 * SCALE_1366,
		width = 440 * SCALE_1366,
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
	back_list = {
		screen_align_y = "bottom",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 2,
		screen_align_x = "left",
		pivot_offset_x = 0 * SCALE_1366,
		pivot_offset_y = 30 * SCALE_1366,
		column_alignment = {
			"left",
			"left"
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
	background_texture = {
		texture = "item_list_gradient_3_1920",
		texture_width = 568 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		texture_color_render_from_child_page = {
			80,
			255,
			255,
			255
		}
	}
}
MainMenuSettings.pages.level_4 = MainMenuSettings.pages.level_4 or {}
MainMenuSettings.pages.level_4[1366] = MainMenuSettings.pages.level_4[1366] or {}
MainMenuSettings.pages.level_4[1366][768] = MainMenuSettings.pages.level_4[1366][768] or {
	item_list = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_offset_y = -0.25,
		pivot_align_x = "left",
		pivot_offset_y = 0,
		screen_align_x = "left",
		max_visible_rows = 11,
		pivot_offset_x = 192 * SCALE_1366,
		column_width = {
			460 * SCALE_1366
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
	tooltip_text_box = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		font_size = 16,
		pivot_offset_y = 0,
		text_align = "right",
		screen_align_x = "right",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "right",
		width = 270,
		padding_top = 20 * SCALE_1366,
		padding_right = 26 * SCALE_1366,
		padding_bottom = 20 * SCALE_1366,
		font = MenuSettings.fonts.hell_shark_16,
		color = {
			255,
			255,
			255,
			255
		},
		line_height = 28 * SCALE_1366,
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
	tooltip_text_box_2 = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		font_size = 14,
		pivot_offset_y = 0,
		padding_top = 0,
		screen_align_x = "right",
		text_align = "right",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "right",
		width = 270,
		padding_right = 26 * SCALE_1366,
		padding_bottom = 20 * SCALE_1366,
		font = MenuSettings.fonts.hell_shark_italic_14,
		color = {
			255,
			255,
			255,
			255
		},
		line_height = 28 * SCALE_1366,
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
	back_list = {
		screen_align_y = "bottom",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_offset_y = 0,
		pivot_align_x = "left",
		number_of_columns = 2,
		screen_align_x = "left",
		pivot_offset_x = 0 * SCALE_1366,
		pivot_offset_y = 30 * SCALE_1366,
		column_alignment = {
			"left",
			"left"
		}
	},
	background_texture = {
		texture = "item_list_gradient_4_1920",
		stretch_relative_width = 1,
		texture_width = 1920 * SCALE_1366,
		texture_height = 4 * SCALE_1366,
		texture_min_height = 260 * SCALE_1366,
		texture_color_render_from_child_page = {
			80,
			255,
			255,
			255
		}
	},
	background_texture_top_line = {
		width = 1,
		absolute_height = 1,
		color = {
			255,
			200,
			200,
			200
		}
	},
	background_texture_bottom_shadow = {
		texture = "item_list_shadow_4_1920",
		stretch_relative_width = 1,
		texture_height = 8 * SCALE_1366
	}
}
MainMenuSettings.pages.level_3_video_settings = MainMenuSettings.pages.level_3_video_settings or {}
MainMenuSettings.pages.level_3_video_settings[1366] = MainMenuSettings.pages.level_3_video_settings[1366] or {}
MainMenuSettings.pages.level_3_video_settings[1366][768] = MainMenuSettings.pages.level_3_video_settings[1366][768] or table.clone(MainMenuSettings.pages.level_3[1366][768])
MainMenuSettings.pages.level_3_video_settings[1366][768].item_list.screen_align_y = "center"
MainMenuSettings.pages.level_3_video_settings[1366][768].item_list.screen_offset_y = 0
MainMenuSettings.pages.level_3_video_settings[1366][768].item_list.pivot_align_y = "center"
MainMenuSettings.pages.level_2_character_profiles = MainMenuSettings.pages.level_2_character_profiles or {}
MainMenuSettings.pages.level_2_character_profiles[1366] = MainMenuSettings.pages.level_2_character_profiles[1366] or {}
MainMenuSettings.pages.level_2_character_profiles[1366][768] = MainMenuSettings.pages.level_2_character_profiles[1366][768] or table.clone(MainMenuSettings.pages.level_2[1366][768])
MainMenuSettings.pages.level_2_character_profiles[1366][768].text = MainMenuSettings.items.outfit_editor_text_right_aligned
MainMenuSettings.pages.level_2_character_profiles[1366][768].header_text = MainMenuSettings.items.header_text_right_aligned
MainMenuSettings.pages.level_2_character_profiles[1366][768].delimiter_texture = MainMenuSettings.items.delimiter_texture
MainMenuSettings.pages.level_2_character_profiles[1366][768].text_back = MainMenuSettings.items.text_right_aligned
MainMenuSettings.pages.level_2_character_profiles[1366][768].buy_coins = MainMenuSettings.items.buy_coins_right_aligned
MainMenuSettings.pages.level_2_character_profiles[1366][768].center_items = table.clone(FinalScoreboardMenuSettings.pages.main_page[1366][768].center_items)
MainMenuSettings.pages.level_2_character_profiles[1366][768].center_items.pivot_offset_y = 0
MainMenuSettings.pages.level_2_character_profiles[1366][768].profile_info = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	dagger_name_font_size = 22,
	pivot_offset_y = 0,
	profile_name_font_size = 22,
	screen_align_x = "right",
	sidearm_name_font_size = 22,
	main_weapon_name_font_size = 22,
	header_bgr_texture = "header_item_bgr_left_1920",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	bgr_texture = "profile_info_bgr_1920",
	shield_name_font_size = 22,
	bgr_texture_width = 700 * SCALE_1366,
	bgr_texture_height = 860 * SCALE_1366,
	header_bgr_texture_width = 652 * SCALE_1366,
	header_bgr_texture_height = 36 * SCALE_1366,
	header_bgr_texture_offset_y = -8 * SCALE_1366,
	profile_name_font = MenuSettings.fonts.hell_shark_22,
	profile_name_color = {
		255,
		255,
		255,
		255
	},
	profile_name_offset_x = 20 * SCALE_1366,
	profile_name_offset_y = 812 * SCALE_1366,
	main_weapon_name_font = MenuSettings.fonts.hell_shark_22,
	main_weapon_name_color = {
		255,
		0,
		0,
		0
	},
	main_weapon_name_offset_x = 20 * SCALE_1366,
	main_weapon_name_offset_y = 768 * SCALE_1366,
	sidearm_name_font = MenuSettings.fonts.hell_shark_22,
	sidearm_name_color = {
		255,
		0,
		0,
		0
	},
	sidearm_name_offset_x = 20 * SCALE_1366,
	sidearm_name_offset_y = 556 * SCALE_1366,
	dagger_name_font = MenuSettings.fonts.hell_shark_22,
	dagger_name_color = {
		255,
		0,
		0,
		0
	},
	dagger_name_offset_x = 20 * SCALE_1366,
	dagger_name_offset_y = 342 * SCALE_1366,
	shield_name_font = MenuSettings.fonts.hell_shark_22,
	shield_name_color = {
		255,
		0,
		0,
		0
	},
	shield_name_offset_x = 422 * SCALE_1366,
	shield_name_offset_y = 342 * SCALE_1366,
	main_weapon_viewer = {
		outfit_texture_background = "outfit_background_1920",
		outfit_texture_overlay = "outfit_overlay_1920",
		attachment_texture_atlas_name = "menu_atlas",
		offset_x = 0,
		outfit_texture_atlas_name = "outfit_atlas",
		offset_y = 592 * SCALE_1366,
		width = 588 * SCALE_1366,
		height = 160 * SCALE_1366,
		outfit_texture_offset_x = 24 * SCALE_1366,
		outfit_texture_offset_y = 15 * SCALE_1366,
		outfit_texture_width = 400 * SCALE_1366,
		outfit_texture_height = 128 * SCALE_1366,
		outfit_texture_atlas_settings = OutfitAtlas,
		outfit_texture_background_width = 588 * SCALE_1366,
		outfit_texture_background_height = 160 * SCALE_1366,
		attachment_texture_offset_x = 436 * SCALE_1366,
		attachment_texture_offset_y = 106 * SCALE_1366,
		attachment_texture_size = 32 * SCALE_1366,
		attachment_texture_spacing_x = 10 * SCALE_1366,
		attachment_texture_atlas_settings = MenuAtlas
	},
	sidearm_viewer = {
		outfit_texture_background = "outfit_background_1920",
		outfit_texture_overlay = "outfit_overlay_1920",
		attachment_texture_atlas_name = "menu_atlas",
		offset_x = 0,
		outfit_texture_atlas_name = "outfit_atlas",
		offset_y = 379 * SCALE_1366,
		width = 588 * SCALE_1366,
		height = 160 * SCALE_1366,
		outfit_texture_offset_x = 24 * SCALE_1366,
		outfit_texture_offset_y = 15 * SCALE_1366,
		outfit_texture_width = 400 * SCALE_1366,
		outfit_texture_height = 128 * SCALE_1366,
		outfit_texture_atlas_settings = OutfitAtlas,
		outfit_texture_background_width = 588 * SCALE_1366,
		outfit_texture_background_height = 160 * SCALE_1366,
		attachment_texture_offset_x = 436 * SCALE_1366,
		attachment_texture_offset_y = 106 * SCALE_1366,
		attachment_texture_size = 32 * SCALE_1366,
		attachment_texture_spacing_x = 10 * SCALE_1366,
		attachment_texture_atlas_settings = MenuAtlas
	},
	perk_offensive_offset_y = 272 * SCALE_1366,
	perk_defensive_offset_y = 211 * SCALE_1366,
	perk_supportive_offset_y = 150 * SCALE_1366,
	perk_movement_offset_y = 89 * SCALE_1366,
	perk_officer_offset_y = 28 * SCALE_1366,
	perks = {
		basic_header_font_size = 18,
		specialized_2_header_font_size = 13,
		specialized_1_header_font_size = 13,
		basic_text_font_size = 11,
		texture_atlas_name = "menu_atlas",
		width = 500 * SCALE_1366,
		height = 54 * SCALE_1366,
		basic_texture_width = 32 * SCALE_1366,
		basic_texture_height = 32 * SCALE_1366,
		basic_texture_offset_x = 24 * SCALE_1366,
		basic_texture_offset_y = 10 * SCALE_1366,
		basic_header_offset_x = 70 * SCALE_1366,
		basic_header_offset_y = 28 * SCALE_1366,
		basic_header_font = MenuSettings.fonts.hell_shark_18,
		basic_text_offset_x = 70 * SCALE_1366,
		basic_text_offset_y = 4 * SCALE_1366,
		basic_text_font = MenuSettings.fonts.hell_shark_11,
		specialized_1_texture_width = 20 * SCALE_1366,
		specialized_1_texture_height = 20 * SCALE_1366,
		specialized_1_texture_offset_x = 424 * SCALE_1366,
		specialized_1_texture_offset_y = 28 * SCALE_1366,
		specialized_1_header_offset_x = 456 * SCALE_1366,
		specialized_1_header_offset_y = 34 * SCALE_1366,
		specialized_1_header_font = MenuSettings.fonts.hell_shark_13,
		specialized_2_texture_width = 20 * SCALE_1366,
		specialized_2_texture_height = 20 * SCALE_1366,
		specialized_2_texture_offset_x = 424 * SCALE_1366,
		specialized_2_texture_offset_y = 3 * SCALE_1366,
		specialized_2_header_offset_x = 456 * SCALE_1366,
		specialized_2_header_offset_y = 7 * SCALE_1366,
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
MainMenuSettings.pages.level_2_character_profiles[1366][768].profile_viewer = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	pivot_align_y = "center",
	screen_align_x = "center",
	pivot_offset_y = 0
}
MainMenuSettings.pages.level_2_character_profiles[1366][768].xp_progress_bar = {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	pivot_align_y = "bottom",
	screen_align_x = "center",
	number_of_columns = 1,
	pivot_offset_y = 30 * SCALE_1366,
	column_alignment = {
		"center"
	}
}
MainMenuSettings.pages.level_2_character_profiles[1366][768].background_texture = {
	texture = "item_list_gradient_2_1920",
	texture_width = 4 * SCALE_1366,
	texture_height = 600 * SCALE_1366,
	stretch_width = 540 * SCALE_1366
}
MainMenuSettings.pages.level_2_character_profiles[1366][768].horizontal_line_top_texture = table.clone(MainMenuSettings.pages.level_2[1366][768].horizontal_line_top_texture)
MainMenuSettings.pages.level_2_character_profiles[1366][768].horizontal_line_top_texture.color = {
	0,
	0,
	0,
	0
}
MainMenuSettings.pages.level_2_character_profiles[1366][768].horizontal_line_bottom_texture = table.clone(MainMenuSettings.pages.level_2[1366][768].horizontal_line_bottom_texture)
MainMenuSettings.pages.level_2_character_profiles[1366][768].horizontal_line_bottom_texture.color = {
	0,
	0,
	0,
	0
}
MainMenuSettings.pages.level_3_character_profiles = MainMenuSettings.pages.level_3_character_profiles or {}
MainMenuSettings.pages.level_3_character_profiles[1366] = MainMenuSettings.pages.level_3_character_profiles[1366] or {}
MainMenuSettings.pages.level_3_character_profiles[1366][768] = MainMenuSettings.pages.level_3_character_profiles[1366][768] or table.clone(MainMenuSettings.pages.level_3[1366][768])
MainMenuSettings.pages.level_3_character_profiles[1366][768].text = MainMenuSettings.items.text_right_aligned
MainMenuSettings.pages.level_3_character_profiles[1366][768].header_text = MainMenuSettings.items.header_text_right_aligned
MainMenuSettings.pages.level_3_character_profiles[1366][768].delimiter_texture = MainMenuSettings.items.delimiter_texture
MainMenuSettings.pages.level_3_character_profiles[1366][768].text_back = MainMenuSettings.items.text_right_aligned
MainMenuSettings.pages.level_3_character_profiles[1366][768].buy_coins = MainMenuSettings.items.buy_coins_right_aligned
MainMenuSettings.pages.level_3_character_profiles[1366][768].center_items = table.clone(FinalScoreboardMenuSettings.pages.main_page[1366][768].center_items)
MainMenuSettings.pages.level_3_character_profiles[1366][768].center_items.screen_offset_y = -0.015
MainMenuSettings.pages.level_4_character_profiles = MainMenuSettings.pages.level_4_character_profiles or {}
MainMenuSettings.pages.level_4_character_profiles[1366] = MainMenuSettings.pages.level_4_character_profiles[1366] or {}
MainMenuSettings.pages.level_4_character_profiles[1366][768] = MainMenuSettings.pages.level_4_character_profiles[1366][768] or table.clone(MainMenuSettings.pages.level_4[1366][768])
MainMenuSettings.pages.level_4_character_profiles[1366][768].item_list.max_visible_rows = 20
MainMenuSettings.pages.level_4_character_profiles[1366][768].text = MainMenuSettings.items.outfit_editor_text_left_aligned
MainMenuSettings.pages.level_4_character_profiles[1366][768].drop_down_list = MainMenuSettings.items.ddl_closed_text_left_aligned
MainMenuSettings.pages.level_4_character_profiles[1366][768].checkbox = MainMenuSettings.items.outfit_editor_checkbox_left_aligned
MainMenuSettings.pages.level_4_character_profiles[1366][768].header_text = MainMenuSettings.items.header_text_left_aligned
MainMenuSettings.pages.level_4_character_profiles[1366][768].delimiter_texture = MainMenuSettings.items.delimiter_texture_left
MainMenuSettings.pages.level_4_character_profiles[1366][768].text_back = MainMenuSettings.items.text_left_aligned
MainMenuSettings.pages.level_4_character_profiles[1366][768].buy_coins = MainMenuSettings.items.buy_coins
MainMenuSettings.pages.level_4_character_profiles[1366][768].texture_button = MainMenuSettings.items.texture_button_left_aligned
MainMenuSettings.pages.level_4_character_profiles[1366][768].outfit_info = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	pivot_offset_y = 0,
	font_size = 13,
	bar_filling_texture = "bar_filling",
	screen_align_x = "center",
	bar_background_texture = "bar_background",
	screen_offset_y = 0,
	pivot_align_x = "center",
	pivot_offset_x = 120 * SCALE_1366,
	padding_top = 35 * SCALE_1366,
	padding_bottom = 30 * SCALE_1366,
	width = 605 * SCALE_1366,
	outfit_viewer = {
		outfit_texture_background = "outfit_background_1920",
		outfit_texture_atlas_name = "outfit_atlas",
		outfit_texture_overlay = "outfit_overlay_1920",
		width = 588 * SCALE_1366,
		height = 160 * SCALE_1366,
		outfit_texture_offset_x = 24 * SCALE_1366,
		outfit_texture_offset_y = 15 * SCALE_1366,
		outfit_texture_width = 400 * SCALE_1366,
		outfit_texture_height = 128 * SCALE_1366,
		outfit_texture_atlas_settings = OutfitAtlas,
		outfit_texture_background_width = 588 * SCALE_1366,
		outfit_texture_background_height = 160 * SCALE_1366
	},
	font = MenuSettings.fonts.hell_shark_13,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_start_offset_y = -4 * SCALE_1366,
	text_offset_y = -21 * SCALE_1366,
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
	bar_filling_texture_height = 8 * SCALE_1366,
	bar_background_texture_height = 8 * SCALE_1366,
	bar_offset_y = -15 * SCALE_1366,
	bar_width = 450 * SCALE_1366
}
MainMenuSettings.pages.level_4_character_profiles[1366][768].perks = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	screen_align_x = "center",
	pivot_offset_y = 0,
	texture_background = "perk_background_1920",
	texture_atlas_name = "menu_atlas",
	screen_offset_y = 0,
	pivot_align_x = "left",
	pivot_offset_x = -140 * SCALE_1366,
	padding_top = 35 * SCALE_1366,
	basic_texture_width = 64 * SCALE_1366,
	basic_texture_height = 64 * SCALE_1366,
	basic_texture_offset_x = 19 * SCALE_1366,
	basic_texture_offset_y = 77 * SCALE_1366,
	specialized_1_texture_width = 64 * SCALE_1366,
	specialized_1_texture_height = 64 * SCALE_1366,
	specialized_1_texture_offset_x = 164 * SCALE_1366,
	specialized_1_texture_offset_y = 51 * SCALE_1366,
	specialized_2_texture_width = 64 * SCALE_1366,
	specialized_2_texture_height = 64 * SCALE_1366,
	specialized_2_texture_offset_x = 253 * SCALE_1366,
	specialized_2_texture_offset_y = 51 * SCALE_1366,
	texture_background_width = 580 * SCALE_1366,
	texture_background_height = 124 * SCALE_1366,
	texture_atlas_settings = MenuAtlas
}
MainMenuSettings.pages.level_4_character_profiles[1366][768].attachment_info = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 13,
	pivot_offset_y = 0,
	bar_filling_texture = "bar_filling",
	screen_align_x = "center",
	texture_atlas_name = "menu_atlas",
	bar_background_texture = "bar_background",
	bar_filling_light_texture = "bar_filling_light",
	bar_infinite_texture = "infinity_icon_1920",
	screen_offset_y = 0,
	pivot_align_x = "center",
	texture_background = "attachments_background_1920",
	bar_filling_dark_texture = "bar_filling_dark",
	pivot_offset_x = 130 * SCALE_1366,
	padding_top = 35 * SCALE_1366,
	padding_bottom = 30 * SCALE_1366,
	width = 605 * SCALE_1366,
	texture_size = 128 * SCALE_1366,
	texture_atlas_settings = MenuAtlas,
	texture_offset_x = 19 * SCALE_1366,
	texture_offset_y = -17 * SCALE_1366,
	font = MenuSettings.fonts.hell_shark_13,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_start_offset_y = -4 * SCALE_1366,
	text_offset_y = -21 * SCALE_1366,
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
	bar_filling_texture_height = 8 * SCALE_1366,
	bar_filling_light_texture_height = 8 * SCALE_1366,
	bar_filling_dark_texture_height = 8 * SCALE_1366,
	bar_background_texture_height = 8 * SCALE_1366,
	bar_infinite_texture_width = 32 * SCALE_1366,
	bar_infinite_texture_height = 32 * SCALE_1366,
	bar_offset_y = -15 * SCALE_1366,
	bar_width = 450 * SCALE_1366,
	texture_background_width = 588 * SCALE_1366,
	texture_background_height = 164 * SCALE_1366
}
MainMenuSettings.pages.level_4_character_profiles[1024] = MainMenuSettings.pages.level_4_character_profiles[1024] or {}
MainMenuSettings.pages.level_4_character_profiles[1024][768] = MainMenuSettings.pages.level_4_character_profiles[1024][768] or table.clone(MainMenuSettings.pages.level_4_character_profiles[1366][768])
MainMenuSettings.pages.level_4_character_profiles[1024][768].item_list.pivot_offset_x = 50
MainMenuSettings.pages.level_4_character_profiles[1024][768].item_list.max_visible_rows = 20
MainMenuSettings.pages.level_4_armour_attachments = MainMenuSettings.pages.level_4_armour_attachments or {}
MainMenuSettings.pages.level_4_armour_attachments[1366] = MainMenuSettings.pages.level_4_armour_attachments[1366] or {}
MainMenuSettings.pages.level_4_armour_attachments[1366][768] = MainMenuSettings.pages.level_4_armour_attachments[1366][768] or table.clone(MainMenuSettings.pages.level_4_character_profiles[1366][768])
MainMenuSettings.pages.level_4_armour_attachments[1366][768].item_list.max_visible_rows = 7
MainMenuSettings.pages.level_2_coat_of_arms = MainMenuSettings.pages.level_2_coat_of_arms or {}
MainMenuSettings.pages.level_2_coat_of_arms[1366] = MainMenuSettings.pages.level_2_coat_of_arms[1366] or {}
MainMenuSettings.pages.level_2_coat_of_arms[1366][768] = MainMenuSettings.pages.level_2_coat_of_arms[1366][768] or table.clone(MainMenuSettings.pages.level_3[1366][768])
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].item_list = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	screen_offset_y = 0,
	pivot_align_x = "center",
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 540 * SCALE_1366,
	column_alignment = {
		"right"
	}
}
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].back_list.number_of_columns = 1
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	screen_offset_y = -0.06,
	pivot_align_x = "right",
	pivot_offset_y = 0,
	screen_align_x = "left",
	pivot_offset_x = 540 * SCALE_1366,
	column_alignment = {
		"right"
	}
}
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = -0.06,
	pivot_align_x = "left",
	pivot_align_y = "top",
	screen_align_x = "left",
	pivot_offset_y = 0
}
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].button_info = {
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
			button_name = "a",
			text = "main_menu_select"
		},
		{
			button_name = "b",
			text = "main_menu_cancel"
		}
	},
	division_selected_buttons = {
		{
			button_name = "d_pad",
			text = "main_menu_move"
		},
		{
			button_name = "a",
			text = "main_menu_select"
		},
		{
			button_name = "b",
			text = "menu_cancel"
		}
	},
	division_specific_rendering = {
		charge = "_render_charge_buttons"
	}
}
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_division = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_division or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_division.pivot_offset_y = -36 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_type_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_type_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_type_picker.pivot_offset_y = -80 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_type_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_type_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_type_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_type_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_type_picker.pivot_offset_y = -130 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_type_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_type_picker.number_of_columns = 20
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_color_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_color_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_color_picker.pivot_offset_y = -160 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_color_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_color_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_color_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_color_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_color_picker.pivot_offset_y = -180 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_color_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_field_variation_color_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_type_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_type_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_type_picker.pivot_offset_y = -220 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_type_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_type_picker.number_of_columns = 20
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_color_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_color_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_color_picker.pivot_offset_y = -250 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_color_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_color_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_color_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_color_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_color_picker.pivot_offset_y = -270 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_color_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].division_variation_color_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_ordinary = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_ordinary or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_ordinary.pivot_offset_y = -340 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_color_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_color_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_color_picker.pivot_offset_y = -380 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_color_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_color_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_type_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_type_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_type_picker.pivot_offset_y = -420 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_type_picker.pivot_offset_x = 14 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].ordinary_type_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_charge = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_charge or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_charge.pivot_offset_y = -480 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_color_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_color_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_color_picker.pivot_offset_y = -520 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_color_picker.pivot_offset_x = 10 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_color_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_type_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_type_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_type_picker.pivot_offset_y = -560 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_type_picker.pivot_offset_x = 14 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_type_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_type_picker.number_of_visible_rows = 2
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].charge_type_picker.scroll_number_of_rows = 2
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_crest = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_crest or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].header_crest.pivot_offset_y = -660 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].crest_picker = MainMenuSettings.pages.level_2_coat_of_arms[1366][768].crest_picker or table.clone(MainMenuSettings.pages.level_2_coat_of_arms[1366][768].sub_header)
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].crest_picker.pivot_offset_y = -710 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].crest_picker.pivot_offset_x = 14 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].crest_picker.number_of_columns = 15
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].back_list.pivot_offset_y = 20 * SCALE_1366
MainMenuSettings.pages.level_2_coat_of_arms[1366][768].coat_of_arms_viewer = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	pivot_align_y = "center",
	screen_align_x = "center",
	pivot_offset_y = 0
}
MainMenuSettings.pages.lobby = MainMenuSettings.pages.lobby or {}
MainMenuSettings.pages.lobby[1366] = MainMenuSettings.pages.lobby[1366] or {}
MainMenuSettings.pages.lobby[1366][768] = MainMenuSettings.pages.lobby[1366][768] or {
	item_list = {
		screen_align_y = "top",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = -0.2,
		pivot_align_x = "center",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = 0,
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
	}
}
MainMenuSettings.pages.lobby[1366][768].button_info = {
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
			button_name = "a",
			text = "main_menu_select"
		},
		{
			button_name = "x",
			text = "main_menu_change_map"
		},
		{
			button_name = "y",
			text = "main_menu_change_game_mode"
		},
		{
			button_name = "b",
			text = "main_menu_cancel"
		}
	}
}
MainMenuSettings.pages.join_lobby = MainMenuSettings.pages.join_lobby or {}
MainMenuSettings.pages.join_lobby[1366] = MainMenuSettings.pages.join_lobby[1366] or {}
MainMenuSettings.pages.join_lobby[1366][768] = MainMenuSettings.pages.join_lobby[1366][768] or table.clone(MainMenuSettings.pages.lobby[1366][768])
MainMenuSettings.pages.join_lobby[1366][768].do_not_render_buttons = true
MainMenuSettings.pages.ddl_right_aligned = MainMenuSettings.pages.ddl_right_aligned or {}
MainMenuSettings.pages.ddl_right_aligned[1366] = MainMenuSettings.pages.ddl_right_aligned[1366] or {}
MainMenuSettings.pages.ddl_right_aligned[1366][768] = MainMenuSettings.pages.ddl_right_aligned[1366][768] or table.clone(MainMenuSettings.pages.level_4[1366][768])
MainMenuSettings.pages.ddl_right_aligned[1366][768].drop_down_list = {
	number_of_visible_rows = 10,
	texture_background = "ddl_background_right_1920",
	offset_y = 0,
	offset_x = 0,
	texture_background_align = "right",
	list_alignment = "right",
	texture_background_width = 568 * SCALE_1366,
	item_config = MainMenuSettings.items.ddl_open_text_right_aligned,
	items = {
		columns = {
			{
				align = "right",
				width = 568 * SCALE_1366
			}
		},
		rows = {
			{
				align = "bottom",
				height = 36 * SCALE_1366
			}
		}
	},
	scroll_bar = {
		offset_z = 10,
		align = "right"
	}
}
MainMenuSettings.pages.ddl_right_aligned[1366][768].tooltip_text_box = nil
MainMenuSettings.pages.ddl_right_aligned[1366][768].tooltip_text_box_2 = nil
MainMenuSettings.pages.ddl_right_aligned_no_scroll = MainMenuSettings.pages.ddl_right_aligned_no_scroll or {}
MainMenuSettings.pages.ddl_right_aligned_no_scroll[1366] = MainMenuSettings.pages.ddl_right_aligned_no_scroll[1366] or {}
MainMenuSettings.pages.ddl_right_aligned_no_scroll[1366][768] = MainMenuSettings.pages.ddl_right_aligned_no_scroll[1366][768] or table.clone(MainMenuSettings.pages.ddl_right_aligned[1366][768])
MainMenuSettings.pages.ddl_right_aligned_no_scroll[1366][768].drop_down_list.item_config = MainMenuSettings.items.ddl_open_text_right_aligned_no_scroll
MainMenuSettings.pages.outfit_ddl_left_aligned = MainMenuSettings.pages.outfit_ddl_left_aligned or {}
MainMenuSettings.pages.outfit_ddl_left_aligned[1366] = MainMenuSettings.pages.outfit_ddl_left_aligned[1366] or {}
MainMenuSettings.pages.outfit_ddl_left_aligned[1366][768] = MainMenuSettings.pages.outfit_ddl_left_aligned[1366][768] or table.clone(MainMenuSettings.pages.level_4[1366][768])
MainMenuSettings.pages.outfit_ddl_left_aligned[1366][768].drop_down_list = {
	number_of_visible_rows = 8,
	texture_background_align = "left",
	texture_background = "ddl_background_left_1920",
	offset_y = 0,
	list_alignment = "left",
	offset_x = 22 * SCALE_1366,
	texture_background_width = 568 * SCALE_1366,
	item_config = MainMenuSettings.items.outfit_ddl_open_text_left_aligned,
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
	},
	scroll_bar = {
		offset_z = 10,
		align = "left"
	}
}
MainMenuSettings.pages.outfit_ddl_left_aligned[1366][768].tooltip_text_box = nil
MainMenuSettings.pages.outfit_ddl_left_aligned[1366][768].tooltip_text_box_2 = nil
MainMenuSettings.items.twitter = MainMenuSettings.items.twitter or {}
MainMenuSettings.items.twitter[1366] = MainMenuSettings.items.twitter[1366] or {}
MainMenuSettings.items.twitter[1366][768] = MainMenuSettings.items.twitter[1366][768] or {
	texture = "twitter",
	texture_align = "bottom_left",
	texture_width = 50,
	indentation = 0.04,
	texture_height = 50
}
MainMenuSettings.items.filter_popup_header = MainMenuSettings.items.filter_popup_header or {}
MainMenuSettings.items.filter_popup_header[1366] = MainMenuSettings.items.filter_popup_header[1366] or {}
MainMenuSettings.items.filter_popup_header[1366][768] = MainMenuSettings.items.filter_popup_header[1366][768] or table.clone(MainMenuSettings.items.popup_header[1366][768])
MainMenuSettings.items.filter_popup_header[1366][768].texture_disabled = nil
MainMenuSettings.items.filter_popup_header[1366][768].texture_disabled_width = 400 * SCALE_1366
MainMenuSettings.items.filter_popup_header[1366][768].texture_disabled_height = 50 * SCALE_1366
MainMenuSettings.items.filter_popup_header[1366][768].texture_disabled_color = {
	100,
	255,
	255,
	255
}
MainMenuSettings.items.filter_popup_header[1366][768].font = MenuSettings.fonts.hell_shark_32
MainMenuSettings.items.filter_popup_header[1366][768].font_size = 32
MainMenuSettings.items.filter_popup_header[1366][768].texture_alignment = "center"
MainMenuSettings.items.filter_popup_header[1366][768].padding_left = 0
MainMenuSettings.items.filter_popup_header[1366][768].texture_disabled_width = 470 * SCALE_1366
MainMenuSettings.items.facebook = MainMenuSettings.items.facebook or {}
MainMenuSettings.items.facebook[1366] = MainMenuSettings.items.facebook[1366] or {}
MainMenuSettings.items.facebook[1366][768] = MainMenuSettings.items.facebook[1366][768] or {
	texture_extra_offset = 60,
	texture = "facebook",
	texture_align = "bottom_left",
	texture_width = 50,
	indentation = 0.04,
	texture_height = 50
}
MainMenuSettings.items.survey = MainMenuSettings.items.survey or {}
MainMenuSettings.items.survey[1366] = MainMenuSettings.items.survey[1366] or {}
MainMenuSettings.items.survey[1366][768] = MainMenuSettings.items.survey[1366][768] or {
	texture_extra_offset = 120,
	texture = "survey",
	texture_align = "bottom_left",
	texture_width = 50,
	indentation = 0.04,
	texture_height = 50
}
MainMenuSettings.pages.filter_popup = MainMenuSettings.pages.filter_popup or {}
MainMenuSettings.pages.filter_popup[1366] = MainMenuSettings.pages.filter_popup[1366] or {}
MainMenuSettings.pages.filter_popup[1366][768] = MainMenuSettings.pages.filter_popup[1366][768] or table.clone(MainMenuSettings.pages.text_input_popup[1366][768])
MainMenuSettings.pages.filter_popup[1366][768].item_list.column_alignment = {
	"left"
}
MainMenuSettings.pages.filter_popup[1366][768].item_list.screen_offset_x = 0.13 * SCALE_1366
MainMenuSettings.pages.filter_popup[1366][768].item_list.pivot_offset_y = 0
MainMenuSettings.pages.filter_popup[1366][768].background_rect.absolute_width = 400 * SCALE_1366
MainMenuSettings.pages.filter_popup[1366][768].background_rect.absolute_height = 470 * SCALE_1366
MainMenuSettings.pages.filter_popup[1366][768].background_rect.border_size = 1
MainMenuSettings.pages.filter_popup[1366][768].background_rect.border_color = {
	255,
	192,
	192,
	192
}
MainMenuSettings.pages.filter_popup[1366][768].background_rect.color = {
	255,
	20,
	20,
	20
}
MainMenuSettings.pages.filter_popup[1366][768].header_list.column_width = {
	400 * SCALE_1366
}
MainMenuSettings.pages.filter_popup[1366][768].header_list.column_alignment = {
	"center"
}
MainMenuSettings.pages.filter_popup[1366][768].header_list.pivot_offset_y = 200 * SCALE_1366
MainMenuSettings.items.filter_popup_text_left_aligned = MainMenuSettings.items.filter_popup_text_left_aligned or {}
MainMenuSettings.items.filter_popup_text_left_aligned[1366] = MainMenuSettings.items.filter_popup_text_left_aligned[1366] or {}
MainMenuSettings.items.filter_popup_text_left_aligned[1366][768] = MainMenuSettings.items.filter_popup_text_left_aligned[1366][768] or table.clone(MainMenuSettings.items.text_left_aligned[1366][768])
MainMenuSettings.items.filter_popup_text_left_aligned[1366][768].padding_left = 0
MainMenuSettings.items.filter_popup_text_left_aligned[1366][768].texture_highlighted_width = 325 * SCALE_1366
MainMenuSettings.items.filter_popup_text_left_aligned[1366][768].texture_highlighted = "selected_item_bgr_left_small_1366"
MainMenuSettings.default_button_info = MainMenuSettings.default_button_info or {}
MainMenuSettings.default_button_info[1366] = MainMenuSettings.default_button_info[1366] or {}
MainMenuSettings.default_button_info[1366][768] = MainMenuSettings.default_button_info[1366][768] or {
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
			button_name = "a",
			text = "main_menu_select"
		},
		{
			button_name = "b",
			text = "main_menu_cancel"
		}
	}
}
MainMenuSettings.pages.sale_popup = MainMenuSettings.pages.sale_popup or {}
MainMenuSettings.pages.sale_popup[1366] = {}
MainMenuSettings.pages.sale_popup[1366][768] = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	padding_left = 15,
	pivot_offset_y = 0,
	padding_top = 25,
	screen_align_x = "center",
	padding_bottom = 25,
	pivot_offset_x = 0,
	screen_offset_y = -0.2,
	pivot_align_x = "center",
	padding_right = 15,
	background_color = {
		140,
		0,
		0,
		0
	},
	header_list = {
		atlas_texture_background = "sale_popup",
		texture_background_align = "left",
		atlas_texture_background_settings = sale_popup_atlas.sale_popup_seal_bg,
		items = {
			columns = {
				{
					width = 65,
					align = "center"
				},
				{
					width = 100,
					align = "center"
				},
				{
					width = 134,
					align = "left"
				},
				{
					width = 280,
					align = "right"
				},
				{
					width = 16,
					align = "center"
				}
			},
			rows = {
				{
					align = "center",
					height = 40
				}
			}
		}
	},
	content_list = {
		headers = {
			columns = {
				{
					width = 595,
					align = "center"
				}
			},
			rows = {
				{
					align = "center",
					height = 60
				}
			}
		},
		items = {
			columns = {
				{
					width = 75,
					align = "right"
				},
				{
					width = 445,
					align = "center"
				},
				{
					width = 75,
					align = "left"
				}
			},
			rows = {
				{
					align = "center",
					height = 140
				}
			}
		}
	},
	content_description = {},
	navigation = {}
}
