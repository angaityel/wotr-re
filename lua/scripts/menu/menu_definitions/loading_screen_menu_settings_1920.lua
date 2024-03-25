-- chunkname: @scripts/menu/menu_definitions/loading_screen_menu_settings_1920.lua

LoadingScreenMenuSettings = LoadingScreenMenuSettings or {}
LoadingScreenMenuSettings.items = LoadingScreenMenuSettings.items or {}
LoadingScreenMenuSettings.pages = LoadingScreenMenuSettings.pages or {}
LoadingScreenMenuSettings.music_events = {}
LoadingScreenMenuSettings.items.loading_indicator = LoadingScreenMenuSettings.items.loading_indicator or {}
LoadingScreenMenuSettings.items.loading_indicator[1680] = LoadingScreenMenuSettings.items.loading_indicator[1680] or {}
LoadingScreenMenuSettings.items.loading_indicator[1680][1050] = LoadingScreenMenuSettings.items.loading_indicator[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = -0.04,
	pivot_align_y = "bottom",
	fade_end_delay = 1,
	pivot_offset_y = 0,
	texture_scale = 0.6,
	screen_align_x = "right",
	texture_rotation_angle = 90,
	font_size = 30,
	text_padding = 20,
	pivot_offset_x = 0,
	screen_offset_y = 0.08,
	pivot_align_x = "right",
	fade_start_delay = 2,
	texture = "loading_icon_mockup",
	texture_color = {
		255,
		255,
		255,
		255
	},
	text_color = {
		255,
		255,
		255,
		255
	},
	font = MenuSettings.fonts.hell_shark_30,
	loading_icon_config = {
		animation_speed = 30,
		padding_right = 0,
		texture_atlas = "loading_atlas",
		padding_left = 0,
		padding_top = 18,
		padding_bottom = -50,
		texture_width = 40,
		scale = 0.5,
		texture_height = 40,
		frames = {},
		texture_atlas_settings = LoadingAtlas
	}
}

for i = 1, 72 do
	LoadingScreenMenuSettings.items.loading_indicator[1680][1050].loading_icon_config.frames[i] = string.format("loading_shield_%.2d", i)
end

LoadingScreenMenuSettings.items.loading_screen_header_right_aligned = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned or {}
LoadingScreenMenuSettings.items.loading_screen_header_right_aligned[1680] = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned[1680] or {}
LoadingScreenMenuSettings.items.loading_screen_header_right_aligned[1680][1050] = LoadingScreenMenuSettings.items.loading_screen_header_right_aligned[1680][1050] or {
	texture_alignment = "right",
	texture_disabled = "selected_item_bgr_right_1920",
	padding_left = 0,
	font_size = 32,
	padding_top = 15,
	texture_disabled_width = 652,
	padding_bottom = 15,
	line_height = 21,
	texture_disabled_height = 36,
	padding_right = 20,
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
LoadingScreenMenuSettings.items.server_banner = LoadingScreenMenuSettings.items.server_banner or {}
LoadingScreenMenuSettings.items.server_banner[1680] = LoadingScreenMenuSettings.items.server_banner[1680] or {}
LoadingScreenMenuSettings.items.server_banner[1680][1050] = LoadingScreenMenuSettings.items.server_banner[1680][1050] or {
	texture = "server_banner_1920",
	padding_bottom = 10,
	texture_width = 512,
	padding_left = 0,
	padding_top = 20,
	padding_right = 20,
	texture_height = 128
}
LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned or {}
LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned[1680] = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned[1680] or {}
LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned[1680][1050] = LoadingScreenMenuSettings.items.loading_screen_text_box_right_aligned[1680][1050] or {
	line_height = 26,
	width = 440,
	padding_left = 0,
	padding_right = 20,
	font_size = 20,
	padding_top = 0,
	text_align = "right",
	padding_bottom = 50,
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
	drop_shadow_offset = {
		2,
		-2
	}
}
LoadingScreenMenuSettings.pages.loading_screen = LoadingScreenMenuSettings.pages.loading_screen or {}
LoadingScreenMenuSettings.pages.loading_screen[1680] = LoadingScreenMenuSettings.pages.loading_screen[1680] or {}
LoadingScreenMenuSettings.pages.loading_screen[1680][1050] = LoadingScreenMenuSettings.pages.loading_screen[1680][1050] or table.clone(MainMenuSettings.pages.level_1[1680][1050])
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].item_list.screen_align_y = "center"
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].item_list.pivot_align_y = "center"
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].item_list.screen_offset_y = 0
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].logo_texture = nil
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].do_not_render_buttons = true
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].countdown = {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	texture_background_height = 36,
	pivot_offset_y = 0,
	text_offset_y = 8,
	screen_align_x = "center",
	texture_background = "selected_item_bgr_centered_1920",
	texture_background_width = 652,
	font_size = 32,
	pivot_offset_x = 0,
	screen_offset_y = -0.06,
	pivot_align_x = "center",
	no_localization = true,
	texture_background_alignment = "center",
	font = MenuSettings.fonts.hell_shark_32,
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
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].tip_of_the_day = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	pivot_align_y = "center",
	screen_align_x = "right",
	pivot_offset_y = 0,
	tip_background_texture = {
		texture = "right_info_bgr_1920",
		texture_height = 860,
		texture_width = 700,
		texture_color = {
			210,
			255,
			255,
			255
		}
	},
	tip_graphics = {
		video_key = "video_1920",
		height = 332,
		texture_key = "texture_1920",
		offset_y = 436,
		offset_x = 22,
		width = 596
	},
	tip_text = {
		line_height = 30,
		width = 500,
		offset_x = 24,
		offset_y = 410,
		font_size = 22,
		text_align = "left",
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
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].background_level_texture = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "loading_screen_background",
	pivot_offset_y = 0,
	texture_width = 300,
	screen_align_x = "left",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_height = 168
}
LoadingScreenMenuSettings.pages.loading_screen[1680][1050].demo_screen = {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	resize_to_relative_width = 540,
	pivot_offset_y = 0,
	texture_width = 1300,
	screen_align_x = "right",
	texture = "demo_loading_splash_1920",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	texture_height = 856
}
