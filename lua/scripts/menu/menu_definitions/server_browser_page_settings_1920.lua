-- chunkname: @scripts/menu/menu_definitions/server_browser_page_settings_1920.lua

require("scripts/menu/menu_definitions/main_menu_settings_1920")
require("scripts/menu/menu_definitions/main_menu_settings_1366")
require("scripts/menu/menu_definitions/main_menu_settings_low")
require("scripts/menu/menu_definitions/main_menu_definition")

ServerBrowserSettings = ServerBrowserSettings or {}
ServerBrowserSettings.items = ServerBrowserSettings.items or {}
ServerBrowserSettings.pages = ServerBrowserSettings.pages or {}
ServerBrowserSettings.pages.server_browser = ServerBrowserSettings.pages.server_browser or {}
ServerBrowserSettings.pages.server_browser[1680] = ServerBrowserSettings.pages.server_browser[1680] or {}
ServerBrowserSettings.pages.server_browser[1680][1050] = ServerBrowserSettings.pages.server_browser[1680][1050] or {
	server_type_tabs = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = -745,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = 390,
		items = {
			columns = {
				{
					width = 0,
					align = "left"
				},
				{
					align = "left"
				},
				{
					align = "left"
				},
				{
					align = "left"
				},
				{
					align = "left"
				},
				{
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 36
				}
			},
			rows = {
				{
					align = "bottom",
					height = 4
				}
			}
		}
	},
	browser = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		background_min_height = 607,
		pivot_offset_y = 60,
		screen_align_x = "center",
		number_of_visible_rows = 19,
		pivot_offset_x = -745,
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
					width = 60,
					align = "left"
				},
				{
					width = 60,
					align = "left"
				},
				{
					width = 60,
					align = "left"
				},
				{
					width = 560,
					align = "left"
				},
				{
					width = 240,
					align = "left"
				},
				{
					width = 120,
					align = "left"
				},
				{
					width = 60,
					align = "left"
				},
				{
					width = 210,
					align = "left"
				},
				{
					width = 120,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 32
				}
			}
		},
		items = {
			columns = {
				{
					width = 1490,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 32
				}
			}
		},
		scroll_bar = {
			offset_z = 10,
			align = "right"
		}
	},
	browser_frame = {
		texture_lower = "frame_lower_1920",
		screen_offset_x = 0,
		texture_lower_right = "frame_lower_right_1920",
		texture_upper = "frame_upper_1920",
		pivot_align_y = "center",
		texture_upper_right = "frame_upper_right_1920",
		texture_right = "frame_right_1920",
		stretch_height = 607,
		frame_thickness = 60,
		screen_align_y = "center",
		texture_left = "frame_left_1920",
		texture_upper_left = "frame_upper_left_1920",
		pivot_offset_y = 44,
		screen_align_x = "center",
		texture_lower_left = "frame_lower_left_1920",
		pivot_offset_x = -745,
		screen_offset_y = 0,
		pivot_align_x = "left",
		stretch_width = 1490
	},
	browser_compact = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		background_min_height = 607,
		pivot_offset_y = 60,
		screen_align_x = "center",
		number_of_visible_rows = 19,
		pivot_offset_x = -745,
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
					width = 60,
					align = "left"
				},
				{
					width = 60,
					align = "left"
				},
				{
					width = 60,
					align = "left"
				},
				{
					width = 560,
					align = "left"
				},
				{
					width = 240,
					align = "left"
				},
				{
					width = 0,
					align = "left"
				},
				{
					width = 0,
					align = "left"
				},
				{
					width = 0,
					align = "left"
				},
				{
					width = 0,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 32
				}
			}
		},
		items = {
			columns = {
				{
					width = 978,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 32
				}
			}
		},
		scroll_bar = {
			offset_z = 10,
			align = "right"
		}
	},
	browser_frame_compact = {
		texture_lower = "frame_lower_1920",
		screen_offset_x = 0,
		texture_lower_right = "frame_lower_right_1920",
		texture_upper = "frame_upper_1920",
		pivot_align_y = "center",
		texture_upper_right = "frame_upper_right_1920",
		texture_right = "frame_right_1920",
		stretch_height = 607,
		frame_thickness = 60,
		screen_align_y = "center",
		texture_left = "frame_left_1920",
		texture_upper_left = "frame_upper_left_1920",
		pivot_offset_y = 44,
		screen_align_x = "center",
		texture_lower_left = "frame_lower_left_1920",
		pivot_offset_x = -745,
		screen_offset_y = 0,
		pivot_align_x = "left",
		stretch_width = 978
	},
	server_info = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		background_min_height = 400,
		pivot_offset_y = 180,
		screen_align_x = "center",
		pivot_offset_x = 745,
		screen_offset_y = 0,
		pivot_align_x = "right",
		rect_background_color = {
			255,
			45,
			45,
			45
		},
		items = {
			columns = {
				{
					width = 250,
					align = "left"
				},
				{
					width = 250,
					align = "right"
				},
				{
					width = 0,
					align = "right"
				}
			},
			rows = {
				{
					align = "center",
					height = 32
				},
				{
					align = "top",
					height = 160
				},
				{
					align = "center",
					height = 20
				},
				{
					align = "center",
					height = 22
				}
			}
		}
	},
	player_info = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		background_min_height = 288,
		pivot_offset_y = -99,
		screen_align_x = "center",
		number_of_visible_rows = 9,
		pivot_offset_x = 757,
		screen_offset_y = 0,
		pivot_align_x = "right",
		rect_background_color = {
			255,
			30,
			30,
			30
		},
		headers = {
			columns = {
				{
					width = 40,
					align = "left"
				},
				{
					width = 260,
					align = "left"
				},
				{
					width = 100,
					align = "left"
				},
				{
					width = 100,
					align = "right"
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
					width = 500,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 32,
					color_padding_right = 20,
					color_padding_left = 20,
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
	},
	info_frame = {
		texture_lower = "frame_lower_1920",
		screen_offset_x = 0,
		texture_lower_right = "frame_lower_right_1920",
		texture_upper = "frame_upper_1920",
		pivot_align_y = "center",
		texture_upper_right = "frame_upper_right_1920",
		texture_right = "frame_right_1920",
		stretch_height = 607,
		frame_thickness = 60,
		screen_align_y = "center",
		texture_left = "frame_left_1920",
		texture_upper_left = "frame_upper_left_1920",
		pivot_offset_y = 44,
		screen_align_x = "center",
		texture_lower_left = "frame_lower_left_1920",
		pivot_offset_x = 745,
		screen_offset_y = 0,
		pivot_align_x = "right",
		stretch_width = 500
	},
	browser_local_filters = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = -745,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = -270,
		items = {
			columns = {
				{
					width = 330,
					align = "left"
				}
			},
			rows = {
				{
					align = "center",
					height = 50
				}
			}
		}
	},
	browser_query_filters = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 770,
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = -270,
		items = {
			columns = {
				{
					align = "left"
				},
				{
					width = 330,
					align = "left"
				}
			},
			rows = {
				{
					align = "center",
					height = 50
				}
			}
		}
	},
	browser_buttons = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 758,
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = -430,
		items = {
			columns = {
				{
					align = "left"
				},
				{
					align = "left"
				},
				{
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 32
				},
				{
					align = "bottom",
					height = 0
				}
			}
		}
	},
	button_info = {
		text_data = {
			font_size = 28,
			font = MenuSettings.fonts.hell_shark_28,
			drop_shadow = {
				2,
				-2
			}
		},
		default_buttons = {
			{
				button_name = "a",
				text = "server_menu_select_join"
			},
			{
				button_name = "x",
				text = "server_menu_refresh"
			},
			{
				button_name = "y",
				text = "server_menu_favorite"
			},
			{
				button_name = "b",
				text = "server_menu_cancel_back"
			},
			{
				button_name = "right_stick",
				text = "server_menu_filters"
			}
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
	background_rect = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		absolute_height = 1000,
		pivot_offset_y = 0,
		screen_align_x = "center",
		absolute_width = 1700,
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
		pivot_offset_y = 510,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = -864,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 308
	},
	corner_texture_top_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		texture = "item_list_top_corner_1920",
		pivot_offset_y = 510,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = 864,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 308
	},
	corner_texture_bottom_left = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_bottom_corner_right_1920",
		pivot_offset_y = -510,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = -864,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 308
	},
	corner_texture_bottom_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_bottom_corner_1920",
		pivot_offset_y = -510,
		texture_width = 416,
		screen_align_x = "center",
		pivot_offset_x = 864,
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
	}
}
ServerBrowserSettings.items.server_browser_header_password = ServerBrowserSettings.items.server_browser_header_password or {}
ServerBrowserSettings.items.server_browser_header_password[1680] = ServerBrowserSettings.items.server_browser_header_password[1680] or {}
ServerBrowserSettings.items.server_browser_header_password[1680][1050] = ServerBrowserSettings.items.server_browser_header_password[1680][1050] or {
	rect_delimiter_height = 32,
	texture_sort_width = 16,
	rect_delimiter_offset_y = 0,
	texture_sort_offset_y = 10,
	texture_offset_z = 1,
	texture_sort_height = 12,
	texture_offset_y = 6,
	texture_width = 16,
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending",
	texture_height = 20,
	texture = "lock_1920",
	texture_sort_offset_x = -26,
	texture_offset_x = 8,
	rect_delimiter_offset_z = 2,
	rect_delimiter_offset_x = -2,
	texture_sort_asc = "sort_ascending",
	texture_sort_offset_z = 1,
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
ServerBrowserSettings.items.server_browser_header_secure = ServerBrowserSettings.items.server_browser_header_secure or {}
ServerBrowserSettings.items.server_browser_header_secure[1680] = ServerBrowserSettings.items.server_browser_header_secure[1680] or {}
ServerBrowserSettings.items.server_browser_header_secure[1680][1050] = ServerBrowserSettings.items.server_browser_header_secure[1680][1050] or {
	rect_delimiter_height = 32,
	texture_sort_width = 16,
	rect_delimiter_offset_y = 0,
	texture_sort_offset_y = 10,
	texture_offset_z = 1,
	texture_sort_height = 12,
	texture_offset_y = 6,
	texture_width = 20,
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending",
	texture_height = 20,
	texture = "shield_1920",
	texture_sort_offset_x = -26,
	texture_offset_x = 8,
	rect_delimiter_offset_z = 2,
	rect_delimiter_offset_x = -2,
	texture_sort_asc = "sort_ascending",
	texture_sort_offset_z = 1,
	rect_delimiter_color = {
		255,
		60,
		60,
		60
	},
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server_browser_header_favorite = ServerBrowserSettings.items.server_browser_header_favorite or {}
ServerBrowserSettings.items.server_browser_header_favorite[1680] = ServerBrowserSettings.items.server_browser_header_favorite[1680] or {}
ServerBrowserSettings.items.server_browser_header_favorite[1680][1050] = ServerBrowserSettings.items.server_browser_header_favorite[1680][1050] or {
	rect_delimiter_height = 32,
	texture_sort_width = 16,
	rect_delimiter_offset_y = 0,
	texture_sort_offset_y = 10,
	texture_offset_z = 1,
	texture_sort_height = 12,
	texture_offset_y = 2,
	texture_width = 28,
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending",
	texture_height = 28,
	texture = "favorite_1920",
	texture_sort_offset_x = -26,
	texture_offset_x = 6,
	rect_delimiter_offset_z = 2,
	rect_delimiter_offset_x = -2,
	texture_sort_asc = "sort_ascending",
	texture_sort_offset_z = 1,
	rect_delimiter_color = {
		255,
		60,
		60,
		60
	},
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server_browser_header_friends = ServerBrowserSettings.items.server_browser_header_friends or {}
ServerBrowserSettings.items.server_browser_header_friends[1680] = ServerBrowserSettings.items.server_browser_header_friends[1680] or {}
ServerBrowserSettings.items.server_browser_header_friends[1680][1050] = ServerBrowserSettings.items.server_browser_header_friends[1680][1050] or {
	rect_delimiter_height = 32,
	texture_sort_width = 16,
	rect_delimiter_offset_y = 0,
	texture_sort_offset_y = 10,
	texture_offset_z = 1,
	texture_sort_height = 12,
	texture_offset_y = 6,
	texture_width = 12,
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending",
	texture_height = 16,
	texture = "friends_1920",
	texture_sort_offset_x = -26,
	texture_offset_x = 8,
	rect_delimiter_offset_z = 2,
	rect_delimiter_offset_x = -2,
	texture_sort_asc = "sort_ascending",
	texture_sort_offset_z = 1,
	rect_delimiter_color = {
		255,
		60,
		60,
		60
	},
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server_browser_header_text = ServerBrowserSettings.items.server_browser_header_text or {}
ServerBrowserSettings.items.server_browser_header_text[1680] = ServerBrowserSettings.items.server_browser_header_text[1680] or {}
ServerBrowserSettings.items.server_browser_header_text[1680][1050] = ServerBrowserSettings.items.server_browser_header_text[1680][1050] or {
	font_size = 20,
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
	text_offset_x = 8,
	font = MenuSettings.fonts.hell_shark_20,
	text_color = {
		255,
		255,
		255,
		255
	},
	rect_delimiter_color = {
		255,
		60,
		60,
		60
	},
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server = ServerBrowserSettings.items.server or {}
ServerBrowserSettings.items.server[1680] = ServerBrowserSettings.items.server[1680] or {}
ServerBrowserSettings.items.server[1680][1050] = ServerBrowserSettings.items.server[1680][1050] or {
	secure_texture_offset_x = 8,
	favorite_texture_offset_x = 6,
	secure_texture_offset_y = 6,
	demo_text_font_size = 14,
	password_texture_offset_y = 6,
	demo_text = "menu_demo_text",
	secure_texture = "shield_1920",
	password_texture = "lock_1920",
	demo_text_material = "hell_shark_14",
	password_texture_offset_x = 8,
	demo_text_offset_x = 20,
	text_offset_y = 10,
	demo_text_font = "materials/fonts/hell_shark_14",
	secure_texture_height = 20,
	text_offset_x = 8,
	font_size = 18,
	password_texture_height = 20,
	favorite_texture_offset_y = 4,
	password_texture_width = 16,
	secure_texture_width = 20,
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
		60,
		60,
		60,
		560,
		240,
		120,
		60,
		210,
		120
	},
	background_color_highlighted = {
		80,
		60,
		60,
		60
	},
	background_color_selected = {
		255,
		40,
		40,
		40
	}
}
ServerBrowserSettings.items.favorite = ServerBrowserSettings.items.favorite or {}
ServerBrowserSettings.items.favorite[1680] = ServerBrowserSettings.items.favorite[1680] or {}
ServerBrowserSettings.items.favorite[1680][1050] = ServerBrowserSettings.items.favorite[1680][1050] or {
	texture = "favorite_1920",
	texture_highlighted = "favorite_glow_1920",
	texture_highlighted_offset_x = -12,
	texture_highlighted_height = 52,
	padding_left = 0,
	padding_top = 0,
	texture_highlighted_width = 52,
	padding_bottom = 0,
	texture_highlighted_offset_y = -11,
	padding_right = 22,
	texture_width = 28,
	texture_highlighted_offset_z = 0,
	texture_height = 28
}
ServerBrowserSettings.items.server_browser_scroll_bar = ServerBrowserSettings.items.server_browser_scroll_bar or {}
ServerBrowserSettings.items.server_browser_scroll_bar[1680] = ServerBrowserSettings.items.server_browser_scroll_bar[1680] or {}
ServerBrowserSettings.items.server_browser_scroll_bar[1680][1050] = ServerBrowserSettings.items.server_browser_scroll_bar[1680][1050] or {
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
		255,
		50,
		50,
		50
	}
}
ServerBrowserSettings.items.server_info_description = ServerBrowserSettings.items.server_info_description or {}
ServerBrowserSettings.items.server_info_description[1680] = ServerBrowserSettings.items.server_info_description[1680] or {}
ServerBrowserSettings.items.server_info_description[1680][1050] = ServerBrowserSettings.items.server_info_description[1680][1050] or {
	line_height = 20,
	width = 440,
	padding_left = 20,
	padding_right = 0,
	font_size = 18,
	padding_top = 10,
	text_align = "left",
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_18,
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
ServerBrowserSettings.items.thin_delimiter_texture = ServerBrowserSettings.items.thin_delimiter_texture or {}
ServerBrowserSettings.items.thin_delimiter_texture[1680] = ServerBrowserSettings.items.thin_delimiter_texture[1680] or {}
ServerBrowserSettings.items.thin_delimiter_texture[1680][1050] = ServerBrowserSettings.items.thin_delimiter_texture[1680][1050] or {
	texture = "thin_horizontal_delimiter_1920",
	padding_bottom = 0,
	texture_width = 464,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_height = 4
}
ServerBrowserSettings.items.server_info_properties = ServerBrowserSettings.items.server_info_properties or {}
ServerBrowserSettings.items.server_info_properties[1680] = ServerBrowserSettings.items.server_info_properties[1680] or {}
ServerBrowserSettings.items.server_info_properties[1680][1050] = ServerBrowserSettings.items.server_info_properties[1680][1050] or {
	line_height = 13,
	padding_left = 20,
	font_size = 18,
	padding_top = 0,
	padding_right = 20,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_18,
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
ServerBrowserSettings.items.player_info_header_text = ServerBrowserSettings.items.player_info_header_text or {}
ServerBrowserSettings.items.player_info_header_text[1680] = ServerBrowserSettings.items.player_info_header_text[1680] or {}
ServerBrowserSettings.items.player_info_header_text[1680][1050] = ServerBrowserSettings.items.player_info_header_text[1680][1050] or {
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
ServerBrowserSettings.items.player_info_header_text_right_aligned = ServerBrowserSettings.items.player_info_header_text_right_aligned or {}
ServerBrowserSettings.items.player_info_header_text_right_aligned[1680] = ServerBrowserSettings.items.player_info_header_text_right_aligned[1680] or {}
ServerBrowserSettings.items.player_info_header_text_right_aligned[1680][1050] = ServerBrowserSettings.items.player_info_header_text_right_aligned[1680][1050] or table.clone(ServerBrowserSettings.items.player_info_header_text[1680][1050])
ServerBrowserSettings.items.player_info_header_text_right_aligned[1680][1050].text_align = "right"
ServerBrowserSettings.items.player_info_header_text_right_aligned[1680][1050].text_offset_x = -40
ServerBrowserSettings.items.server_info_header_text = ServerBrowserSettings.items.server_info_header_text or {}
ServerBrowserSettings.items.server_info_header_text[1680] = ServerBrowserSettings.items.server_info_header_text[1680] or {}
ServerBrowserSettings.items.server_info_header_text[1680][1050] = ServerBrowserSettings.items.server_info_header_text[1680][1050] or table.clone(ServerBrowserSettings.items.player_info_header_text[1680][1050])
ServerBrowserSettings.items.server_info_header_text[1680][1050].text_max_width = 460
ServerBrowserSettings.items.player_info = ServerBrowserSettings.items.player_info or {}
ServerBrowserSettings.items.player_info[1680] = ServerBrowserSettings.items.player_info[1680] or {}
ServerBrowserSettings.items.player_info[1680][1050] = ServerBrowserSettings.items.player_info[1680][1050] or {
	friend_texture_height = 16,
	friend_texture = "friends_1920",
	friend_texture_offset_x = 30,
	font_size = 18,
	text_offset_y = 10,
	friend_texture_width = 12,
	friend_texture_offset_y = 6,
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
		60,
		260,
		140
	}
}
ServerBrowserSettings.items.server_info_close_texture = ServerBrowserSettings.items.server_info_close_texture or {}
ServerBrowserSettings.items.server_info_close_texture[1680] = ServerBrowserSettings.items.server_info_close_texture[1680] or {}
ServerBrowserSettings.items.server_info_close_texture[1680][1050] = ServerBrowserSettings.items.server_info_close_texture[1680][1050] or {
	texture = "checkbox_close",
	texture_highlighted = "checkbox_close",
	texture_highlighted_height = 40,
	texture_background_height = 40,
	padding_top = 0,
	texture_background = "checkbox_off",
	padding_bottom = 0,
	texture_offset_z = 2,
	texture_background_offset_z = 1,
	texture_width = 40,
	padding_right = 0,
	texture_height = 40,
	texture_background_alignment = "center",
	padding_left = 0,
	texture_background_width = 40,
	texture_highlighted_offset_z = 2,
	texture_highlighted_width = 40,
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
ServerBrowserSettings.items.server_type_tab = ServerBrowserSettings.items.server_type_tab or {}
ServerBrowserSettings.items.server_type_tab[1680] = ServerBrowserSettings.items.server_type_tab[1680] or {}
ServerBrowserSettings.items.server_type_tab[1680][1050] = ServerBrowserSettings.items.server_type_tab[1680][1050] or {
	texture = "tab_background_1920",
	height = 36,
	text_padding_right = 16,
	font_size = 20,
	text_padding_left = 0,
	text_offset_y = 10,
	text_align = "right",
	texture_align = "right",
	texture_width = 140,
	min_width = 140,
	texture_height = 36,
	font = MenuSettings.fonts.hell_shark_20,
	text_color = {
		180,
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
	text_color_selected = {
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
	texture_color = {
		70,
		255,
		255,
		255
	},
	texture_color_highlighted = {
		255,
		255,
		255,
		255
	},
	texture_color_selected = {
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
	}
}
ServerBrowserSettings.items.tab_gradient_texture = ServerBrowserSettings.items.tab_gradient_texture or {}
ServerBrowserSettings.items.tab_gradient_texture[1680] = ServerBrowserSettings.items.tab_gradient_texture[1680] or {}
ServerBrowserSettings.items.tab_gradient_texture[1680][1050] = ServerBrowserSettings.items.tab_gradient_texture[1680][1050] or {
	texture = "tab_gradient_1920",
	padding_bottom = 0,
	texture_width = 1550,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_height = 4
}
ServerBrowserSettings.items.server_browser_button = ServerBrowserSettings.items.server_browser_button or {}
ServerBrowserSettings.items.server_browser_button[1680] = ServerBrowserSettings.items.server_browser_button[1680] or {}
ServerBrowserSettings.items.server_browser_button[1680][1050] = ServerBrowserSettings.items.server_browser_button[1680][1050] or {
	text_padding = 0,
	texture_right_width = 24,
	texture_left = "shiny_button_left_end_1920",
	text_offset_y = 24,
	font_size = 20,
	texture_middle = "shiny_button_center_1920",
	texture_right = "shiny_button_right_end_1920",
	padding_bottom = 0,
	texture_middle_highlighted = "shiny_button_center_highlighted_1920",
	texture_right_highlighted = "shiny_button_right_end_highlighted_1920",
	padding_top = 0,
	texture_left_width = 24,
	texture_left_highlighted = "shiny_button_left_end_highlighted_1920",
	padding_left = 0,
	padding_right = 8,
	texture_height = 60,
	font = MenuSettings.fonts.hell_shark_20,
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
ServerBrowserSettings.items.server_filter_ddl_closed_text = ServerBrowserSettings.items.server_filter_ddl_closed_text or {}
ServerBrowserSettings.items.server_filter_ddl_closed_text[1680] = ServerBrowserSettings.items.server_filter_ddl_closed_text[1680] or {}
ServerBrowserSettings.items.server_filter_ddl_closed_text[1680][1050] = ServerBrowserSettings.items.server_filter_ddl_closed_text[1680][1050] or {
	texture_arrow_offset_x = -1,
	texture_background_height = 36,
	texture_background = "selected_item_bgr_left_small_1920",
	texture_arrow_width = 20,
	font_size = 20,
	padding_top = 0,
	texture_background_width = 388,
	padding_bottom = 0,
	line_height = 12,
	texture_arrow_offset_y = -28,
	texture_arrow = "drop_down_list_arrow",
	texture_arrow_height = 12,
	texture_alignment = "left",
	padding_left = 10,
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_20,
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
ServerBrowserSettings.items.server_filter_ddl_open_text = ServerBrowserSettings.items.server_filter_ddl_open_text or {}
ServerBrowserSettings.items.server_filter_ddl_open_text[1680] = ServerBrowserSettings.items.server_filter_ddl_open_text[1680] or {}
ServerBrowserSettings.items.server_filter_ddl_open_text[1680][1050] = ServerBrowserSettings.items.server_filter_ddl_open_text[1680][1050] or {
	padding_left = 20,
	texture_highlighted = "selected_item_bgr_left_1920",
	texture_highlighted_height = 36,
	font_size = 20,
	padding_top = 9,
	texture_alignment = "left",
	padding_bottom = 9,
	line_height = 12,
	padding_right = 20,
	texture_highlighted_width = 652,
	font = MenuSettings.fonts.hell_shark_20,
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
ServerBrowserSettings.pages.server_filter_ddl = ServerBrowserSettings.pages.server_filter_ddl or {}
ServerBrowserSettings.pages.server_filter_ddl[1680] = ServerBrowserSettings.pages.server_filter_ddl[1680] or {}
ServerBrowserSettings.pages.server_filter_ddl[1680][1050] = ServerBrowserSettings.pages.server_filter_ddl[1680][1050] or {
	drop_down_list = {
		number_of_visible_rows = 5,
		texture_background = "ddl_background_left_1920",
		texture_background_align = "left",
		offset_y = -18,
		offset_x = 22,
		texture_background_width = 568,
		list_alignment = "left",
		item_config = ServerBrowserSettings.items.server_filter_ddl_open_text,
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
		},
		scroll_bar = {
			offset_z = 10,
			align = "left"
		}
	}
}
ServerBrowserSettings.items.drop_down_list_scroll_bar = ServerBrowserSettings.items.drop_down_list_scroll_bar or {}
ServerBrowserSettings.items.drop_down_list_scroll_bar[1680] = ServerBrowserSettings.items.drop_down_list_scroll_bar[1680] or {}
ServerBrowserSettings.items.drop_down_list_scroll_bar[1680][1050] = ServerBrowserSettings.items.drop_down_list_scroll_bar[1680][1050] or {
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
ServerBrowserSettings.items.server_filter_checkbox = ServerBrowserSettings.items.server_filter_checkbox or {}
ServerBrowserSettings.items.server_filter_checkbox[1680] = ServerBrowserSettings.items.server_filter_checkbox[1680] or {}
ServerBrowserSettings.items.server_filter_checkbox[1680][1050] = ServerBrowserSettings.items.server_filter_checkbox[1680][1050] or {
	texture_selected_width = 40,
	texture_selected_offset_x = -8,
	texture_selected_height = 40,
	texture_selected = "checkbox_on",
	font_size = 20,
	texture_deselected_width = 40,
	texture_deselected_height = 40,
	padding_bottom = 0,
	line_height = 13,
	padding_top = 0,
	texture_deselected_offset_x = -8,
	padding_left = 40,
	texture_deselected = "checkbox_off",
	padding_right = 30,
	font = MenuSettings.fonts.hell_shark_20,
	color = {
		255,
		128,
		128,
		128
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
	color_render_from_child_page = {
		160,
		0,
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
	texture_disabled_color = {
		80,
		255,
		255,
		255
	}
}
ServerBrowserSettings.items.popup_filter_checkbox = ServerBrowserSettings.items.popup_filter_checkbox or {}
ServerBrowserSettings.items.popup_filter_checkbox[1680] = ServerBrowserSettings.items.popup_filter_checkbox[1680] or {}
ServerBrowserSettings.items.popup_filter_checkbox[1680][1050] = ServerBrowserSettings.items.popup_filter_checkbox[1680][1050] or table.clone(ServerBrowserSettings.items.server_filter_checkbox[1680][1050])
ServerBrowserSettings.items.popup_filter_checkbox[1680][1050].padding_top = 10
ServerBrowserSettings.items.popup_filter_checkbox[1680][1050].padding_bottom = 10
ServerBrowserSettings.items.popup_filter_checkbox[1680][1050].color_highlighted = {
	255,
	255,
	255,
	255
}
ServerBrowserSettings.items.popup_filter_checkbox[1680][1050].color = {
	128,
	255,
	255,
	255
}
ServerBrowserSettings.items.popup_filter_checkbox[1680][1050].color_selected = nil
