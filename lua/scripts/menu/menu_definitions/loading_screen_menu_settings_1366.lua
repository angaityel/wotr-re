-- chunkname: @scripts/menu/menu_definitions/loading_screen_menu_settings_1366.lua

SCALE_1366 = 0.7114583333333333
LoadingScreenMenuSettings = LoadingScreenMenuSettings or {}
LoadingScreenMenuSettings.items = LoadingScreenMenuSettings.items or {}
LoadingScreenMenuSettings.pages = LoadingScreenMenuSettings.pages or {}
LoadingScreenMenuSettings.music_events = {}
LoadingScreenMenuSettings.items.loading_indicator = LoadingScreenMenuSettings.items.loading_indicator or {}
LoadingScreenMenuSettings.items.loading_indicator[1366] = LoadingScreenMenuSettings.items.loading_indicator[1366] or {}
LoadingScreenMenuSettings.items.loading_indicator[1366][768] = LoadingScreenMenuSettings.items.loading_indicator[1366][768] or {
	screen_align_y = "bottom",
	screen_offset_x = -0.04,
	pivot_align_y = "bottom",
	fade_end_delay = 1,
	pivot_offset_y = 0,
	font_size = 22,
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
	font = MenuSettings.fonts.hell_shark_22,
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
	LoadingScreenMenuSettings.items.loading_indicator[1366][768].loading_icon_config.frames[i] = string.format("loading_shield_%.2d", i)
end

LoadingScreenMenuSettings.items.loading_screen_header_right_aligned = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned or {}
LoadingScreenMenuSettings.items.loading_screen_header_right_aligned[1366] = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned[1366] or {}
LoadingScreenMenuSettings.items.loading_screen_header_right_aligned[1366][768] = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned[1366][768] or {
	texture_alignment = "right",
	texture_disabled = "selected_item_bgr_right_1366",
	padding_left = 0,
	font_size = 22,
	padding_top = 11,
	texture_disabled_width = 440,
	padding_bottom = 11,
	line_height = 15,
	texture_disabled_height = 24,
	padding_right = 14,
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
	}
}
LoadingScreenMenuSettings.items.server_banner = LoadingScreenMenuSettings.items.server_banner or {}
LoadingScreenMenuSettings.items.server_banner[1366] = LoadingScreenMenuSettings.items.server_banner[1366] or {}
LoadingScreenMenuSettings.items.server_banner[1366][768] = LoadingScreenMenuSettings.items.server_banner[1366][768] or {
	texture = "server_banner_1920",
	padding_left = 0,
	padding_top = 14,
	padding_right = 14,
	padding_bottom = 7,
	texture_width = 512 * SCALE_1366,
	texture_height = 128 * SCALE_1366
}
LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned or {}
LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned[1366] = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned[1366] or {}
LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned[1366][768] = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned[1366][768] or {
	line_height = 21,
	padding_left = 0,
	font_size = 16,
	padding_top = 0,
	text_align = "right",
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
	},
	width = 440 * SCALE_1366,
	padding_bottom = 50 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
LoadingScreenMenuSettings.pages.loading_screen = LoadingScreenMenuSettings.pages.loading_screen or {}
LoadingScreenMenuSettings.pages.loading_screen[1366] = LoadingScreenMenuSettings.pages.loading_screen[1366] or {}
LoadingScreenMenuSettings.pages.loading_screen[1366][768] = LoadingScreenMenuSettings.pages.loading_screen[1366][768] or table.clone(MainMenuSettings.pages.level_1[1366][768])
LoadingScreenMenuSettings.pages.loading_screen[1366][768].item_list.screen_align_y = "center"
LoadingScreenMenuSettings.pages.loading_screen[1366][768].item_list.pivot_align_y = "center"
LoadingScreenMenuSettings.pages.loading_screen[1366][768].item_list.screen_offset_y = 0
LoadingScreenMenuSettings.pages.loading_screen[1366][768].logo_texture = nil
LoadingScreenMenuSettings.pages.loading_screen[1366][768].do_not_render_buttons = true
LoadingScreenMenuSettings.pages.loading_screen[1366][768].countdown = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	texture_background_height = 24,
	pivot_offset_y = 0,
	texture_background = "selected_item_bgr_centered_1366",
	screen_align_x = "center",
	texture_background_width = 440,
	font_size = 22,
	texture_background_alignment = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.06,
	pivot_align_x = "center",
	no_localization = true,
	font = MenuSettings.fonts.hell_shark_22,
	text_offset_y = 8 * SCALE_1366,
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
}
LoadingScreenMenuSettings.pages.loading_screen[1366][768].tip_of_the_day = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	pivot_align_y = "center",
	screen_align_x = "right",
	pivot_offset_y = 0,
	tip_background_texture = {
		texture = "right_info_bgr_1366",
		texture_height = 604,
		texture_width = 492,
		texture_color = {
			210,
			255,
			255,
			255
		}
	},
	tip_graphics = {
		video_key = "video_1920",
		texture_key = "texture_1920",
		width = 424,
		height = 236,
		offset_x = 22 * SCALE_1366,
		offset_y = 436 * SCALE_1366
	},
	tip_text = {
		font_size = 16,
		text_align = "left",
		font = MenuSettings.fonts.hell_shark_16,
		color = {
			255,
			255,
			255,
			255
		},
		line_height = 30 * SCALE_1366,
		width = 500 * SCALE_1366,
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
		offset_x = 24 * SCALE_1366,
		offset_y = 410 * SCALE_1366
	},
	corner_top_texture = {
		texture = "item_list_top_corner_1366",
		texture_height = 216,
		texture_width = 292,
		texture_offset_x = 290 * SCALE_1366,
		texture_offset_y = 542 * SCALE_1366
	},
	corner_bottom_texture = {
		texture = "item_list_bottom_corner_1366",
		texture_height = 216,
		texture_width = 292,
		texture_offset_x = 290 * SCALE_1366,
		texture_offset_y = 10 * SCALE_1366
	}
}
LoadingScreenMenuSettings.pages.loading_screen[1366][768].background_level_texture = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "loading_screen_background",
	pivot_offset_y = 0,
	screen_align_x = "left",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_width = 300 * SCALE_1366,
	texture_height = 168 * SCALE_1366
}
LoadingScreenMenuSettings.pages.loading_screen[1366][768].demo_screen = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "demo_loading_splash_1920",
	pivot_offset_y = 0,
	texture_width = 1300,
	screen_align_x = "right",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	texture_height = 856,
	resize_to_relative_width = 540 * SCALE_1366
}
