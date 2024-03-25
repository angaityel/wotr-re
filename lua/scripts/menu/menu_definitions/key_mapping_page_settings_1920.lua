-- chunkname: @scripts/menu/menu_definitions/key_mapping_page_settings_1920.lua

KeyMappingPageDefinition = KeyMappingPageDefinition or {}

local page_settings = KeyMappingPageDefinition.page_settings or {}

page_settings[1680] = page_settings[1680] or {}
page_settings[1680][1050] = page_settings[1680][1050] or table.clone(MainMenuSettings.pages.level_4[1680][1050])
page_settings[1680][1050].item_list.number_of_columns = 2
page_settings[1680][1050].item_list.max_visible_rows = 30
page_settings[1680][1050].item_list.column_width = {
	580
}
page_settings[1680][1050].background_texture.texture_color_render_from_child_page = {
	255,
	255,
	255,
	255
}

local item_page_settings = KeyMappingPageDefinition.item_page_settings or {}

item_page_settings[1680] = item_page_settings[1680] or {}
item_page_settings[1680][1050] = item_page_settings[1680][1050] or table.clone(MainMenuSettings.pages.level_4[1680][1050])

local key_map_item_settings = KeyMappingPageDefinition.key_map_item_settings or {}

key_map_item_settings[1680] = key_map_item_settings[1680] or {}
key_map_item_settings[1680][1050] = key_map_item_settings[1680][1050] or {
	padding_top = 6,
	texture_highlighted = "selected_item_bgr_left_1920",
	texture_highlighted_height = 36,
	padding_left = 20,
	font_size = 26,
	pad_font_size = 36,
	padding_bottom = 3,
	texture_offset_y = -6,
	key_name_align = 360,
	texture_highlighted_width = 652,
	font = MenuSettings.fonts.hell_shark_26,
	pad_font = MenuSettings.fonts.hell_shark_36,
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
		2,
		-2
	}
}
page_settings[1680][1050].button_info = {
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
			button_name = "b",
			text = "main_menu_cancel"
		},
		{
			button_name = "y",
			text = "menu_reset"
		}
	},
	apply_buttons = {
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
		},
		{
			button_name = "x",
			text = "main_menu_apply_settings"
		},
		{
			button_name = "y",
			text = "menu_reset"
		}
	}
}

local delimiter_item_settings = KeyMappingPageDefinition.delimiter_item_settings or {}

delimiter_item_settings[1680] = delimiter_item_settings[1680] or {}
delimiter_item_settings[1680][1050] = delimiter_item_settings[1680][1050] or table.clone(MainMenuSettings.items.delimiter_texture_left[1680][1050])
delimiter_item_settings[1680][1050].padding_top = 14
KeyMappingPageDefinition.page_settings = page_settings
KeyMappingPageDefinition.item_page_settings = item_page_settings
KeyMappingPageDefinition.key_map_item_settings = key_map_item_settings
KeyMappingPageDefinition.delimiter_item_settings = delimiter_item_settings
