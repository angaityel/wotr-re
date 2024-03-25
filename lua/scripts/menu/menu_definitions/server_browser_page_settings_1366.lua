-- chunkname: @scripts/menu/menu_definitions/server_browser_page_settings_1366.lua

SCALE_1366 = 0.7114583333333333
ServerBrowserSettings.pages.server_browser = ServerBrowserSettings.pages.server_browser or {}
ServerBrowserSettings.pages.server_browser[1366] = ServerBrowserSettings.pages.server_browser[1366] or {}
ServerBrowserSettings.pages.server_browser[1366][768] = ServerBrowserSettings.pages.server_browser[1366][768] or {
	server_type_tabs = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = -482,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = 390 * SCALE_1366,
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
					height = 36 * SCALE_1366
				}
			},
			rows = {
				{
					align = "bottom",
					height = 4 * SCALE_1366
				}
			}
		}
	},
	browser = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		background_min_height = 437,
		pivot_offset_y = 43,
		screen_align_x = "center",
		number_of_visible_rows = 18,
		pivot_offset_x = -482,
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
					width = 43,
					align = "left"
				},
				{
					width = 43,
					align = "left"
				},
				{
					width = 43,
					align = "left"
				},
				{
					width = 309,
					align = "left"
				},
				{
					width = 168,
					align = "left"
				},
				{
					width = 85,
					align = "left"
				},
				{
					width = 43,
					align = "left"
				},
				{
					width = 148,
					align = "left"
				},
				{
					width = 85,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 23
				}
			}
		},
		items = {
			columns = {
				{
					width = 967,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 23
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
		stretch_height = 437,
		frame_thickness = 43,
		screen_align_y = "center",
		texture_left = "frame_left_1920",
		texture_upper_left = "frame_upper_left_1920",
		pivot_offset_y = 31,
		screen_align_x = "center",
		texture_lower_left = "frame_lower_left_1920",
		pivot_offset_x = -482,
		screen_offset_y = 0,
		pivot_align_x = "left",
		stretch_width = 967
	},
	browser_compact = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		background_min_height = 437,
		pivot_offset_y = 43,
		screen_align_x = "center",
		number_of_visible_rows = 19,
		pivot_offset_x = -482,
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
					width = 43,
					align = "left"
				},
				{
					width = 43,
					align = "left"
				},
				{
					width = 43,
					align = "left"
				},
				{
					width = 309,
					align = "left"
				},
				{
					width = 168,
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
					height = 23
				}
			}
		},
		items = {
			columns = {
				{
					width = 602,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 23
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
		stretch_height = 437,
		frame_thickness = 43,
		screen_align_y = "center",
		texture_left = "frame_left_1920",
		texture_upper_left = "frame_upper_left_1920",
		pivot_offset_y = 31,
		screen_align_x = "center",
		texture_lower_left = "frame_lower_left_1920",
		pivot_offset_x = -482,
		screen_offset_y = 0,
		pivot_align_x = "left",
		stretch_width = 602
	},
	server_info = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		background_min_height = 290,
		pivot_offset_y = 128,
		screen_align_x = "center",
		pivot_offset_x = 485,
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
					width = 178,
					align = "left"
				},
				{
					width = 178,
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
					height = 23
				},
				{
					align = "top",
					height = 114
				},
				{
					align = "center",
					height = 14
				},
				{
					align = "center",
					height = 14
				}
			}
		}
	},
	player_info = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		background_min_height = 204,
		pivot_offset_y = -71,
		screen_align_x = "center",
		number_of_visible_rows = 9,
		pivot_offset_x = 494,
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
					width = 28,
					align = "left"
				},
				{
					width = 186,
					align = "left"
				},
				{
					width = 71,
					align = "left"
				},
				{
					width = 71,
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
					height = 23
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
					width = 356,
					align = "left"
				}
			},
			rows = {
				{
					align = "bottom",
					height = 23,
					color_padding_right = 14,
					color_padding_left = 14,
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
		stretch_height = 437,
		frame_thickness = 43,
		screen_align_y = "center",
		texture_left = "frame_left_1920",
		texture_upper_left = "frame_upper_left_1920",
		pivot_offset_y = 31,
		screen_align_x = "center",
		texture_lower_left = "frame_lower_left_1920",
		pivot_offset_x = 485,
		screen_offset_y = 0,
		pivot_align_x = "right",
		stretch_width = 356
	},
	browser_local_filters = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = -482,
		screen_offset_y = 0,
		pivot_align_x = "left",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = -270 * SCALE_1366,
		items = {
			columns = {
				{
					align = "left",
					width = 330 * SCALE_1366
				}
			},
			rows = {
				{
					align = "center",
					height = 50 * SCALE_1366
				}
			}
		}
	},
	browser_query_filters = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 488,
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_align_y = "top",
		screen_align_x = "center",
		pivot_offset_y = -270 * SCALE_1366,
		items = {
			columns = {
				{
					align = "left"
				},
				{
					align = "left",
					width = 330 * SCALE_1366
				}
			},
			rows = {
				{
					align = "center",
					height = 50 * SCALE_1366
				}
			}
		}
	},
	browser_buttons = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 494,
		screen_offset_y = 0,
		pivot_align_x = "right",
		pivot_align_y = "bottom",
		screen_align_x = "center",
		pivot_offset_y = -430 * SCALE_1366,
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
					height = 32 * SCALE_1366
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
			font_size = 16,
			font = MenuSettings.fonts.hell_shark_16,
			drop_shadow = {
				1,
				-1
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
	background_rect = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "center",
		pivot_offset_y = 0,
		screen_align_x = "center",
		absolute_width = 1100,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
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
		texture = "item_list_top_corner_right_1366",
		pivot_offset_y = 362,
		texture_width = 292,
		screen_align_x = "center",
		pivot_offset_x = -560,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 216
	},
	corner_texture_top_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "top",
		texture = "item_list_top_corner_1366",
		pivot_offset_y = 362,
		texture_width = 292,
		screen_align_x = "center",
		pivot_offset_x = 560,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 216
	},
	corner_texture_bottom_left = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_bottom_corner_right_1366",
		pivot_offset_y = -362,
		texture_width = 292,
		screen_align_x = "center",
		pivot_offset_x = -560,
		screen_offset_y = 0,
		pivot_align_x = "left",
		texture_height = 216
	},
	corner_texture_bottom_right = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		texture = "item_list_bottom_corner_1366",
		pivot_offset_y = -362,
		texture_width = 292,
		screen_align_x = "center",
		pivot_offset_x = 560,
		screen_offset_y = 0,
		pivot_align_x = "right",
		texture_height = 216
	},
	horizontal_line_texture_top = {
		texture = "item_list_top_horizontal_line_1366",
		screen_offset_x = 0,
		pivot_align_y = "bottom",
		screen_align_y = "center",
		texture_width = 700,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_height = 8,
		pivot_offset_y = 500 * SCALE_1366
	},
	horizontal_line_texture_bottom = {
		texture = "item_list_bottom_horizontal_line_1366",
		screen_offset_x = 0,
		pivot_align_y = "top",
		screen_align_y = "center",
		texture_width = 700,
		screen_align_x = "center",
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		texture_height = 8,
		pivot_offset_y = -500 * SCALE_1366
	}
}
ServerBrowserSettings.items.server_browser_header_password = ServerBrowserSettings.items.server_browser_header_password or {}
ServerBrowserSettings.items.server_browser_header_password[1366] = ServerBrowserSettings.items.server_browser_header_password[1366] or {}
ServerBrowserSettings.items.server_browser_header_password[1366][768] = ServerBrowserSettings.items.server_browser_header_password[1366][768] or {
	texture = "lock_1366",
	texture_sort_asc = "sort_ascending_1366",
	texture_sort_width = 12,
	texture_sort_offset_z = 1,
	rect_delimiter_offset_y = 0,
	rect_delimiter_offset_z = 2,
	texture_sort_offset_y = 10,
	texture_offset_z = 1,
	texture_sort_height = 12,
	rect_delimiter_offset_x = -2,
	texture_width = 12,
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending_1366",
	texture_height = 16,
	texture_offset_x = 8 * SCALE_1366,
	texture_offset_y = 6 * SCALE_1366,
	rect_delimiter_height = 32 * SCALE_1366,
	rect_delimiter_color = {
		0,
		0,
		0,
		0
	},
	texture_sort_offset_x = -26 * SCALE_1366,
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server_browser_header_secure = ServerBrowserSettings.items.server_browser_header_secure or {}
ServerBrowserSettings.items.server_browser_header_secure[1366] = ServerBrowserSettings.items.server_browser_header_secure[1366] or {}
ServerBrowserSettings.items.server_browser_header_secure[1366][768] = ServerBrowserSettings.items.server_browser_header_secure[1366][768] or {
	texture = "shield_1366",
	texture_sort_asc = "sort_ascending_1366",
	texture_sort_width = 12,
	texture_sort_offset_z = 1,
	rect_delimiter_offset_y = 0,
	rect_delimiter_offset_z = 2,
	texture_offset_z = 1,
	texture_sort_height = 12,
	rect_delimiter_offset_x = -2,
	texture_width = 16,
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending_1366",
	texture_height = 16,
	texture_offset_x = 8 * SCALE_1366,
	texture_offset_y = 6 * SCALE_1366,
	rect_delimiter_height = 32 * SCALE_1366,
	rect_delimiter_color = {
		255,
		60,
		60,
		60
	},
	texture_sort_offset_x = -26 * SCALE_1366,
	texture_sort_offset_y = 10 * SCALE_1366,
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server_browser_header_favorite = ServerBrowserSettings.items.server_browser_header_favorite or {}
ServerBrowserSettings.items.server_browser_header_favorite[1366] = ServerBrowserSettings.items.server_browser_header_favorite[1366] or {}
ServerBrowserSettings.items.server_browser_header_favorite[1366][768] = ServerBrowserSettings.items.server_browser_header_favorite[1366][768] or {
	texture = "favorite_1366",
	texture_offset_y = 2,
	texture_sort_asc = "sort_ascending_1366",
	texture_sort_width = 12,
	rect_delimiter_offset_y = 0,
	texture_sort_offset_z = 1,
	rect_delimiter_offset_z = 2,
	texture_offset_z = 1,
	texture_sort_height = 12,
	rect_delimiter_offset_x = -2,
	texture_width = 20,
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending_1366",
	texture_height = 20,
	texture_offset_x = 6 * SCALE_1366,
	rect_delimiter_height = 32 * SCALE_1366,
	rect_delimiter_color = {
		255,
		60,
		60,
		60
	},
	texture_sort_offset_x = -26 * SCALE_1366,
	texture_sort_offset_y = 10 * SCALE_1366,
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server_browser_header_friends = ServerBrowserSettings.items.server_browser_header_friends or {}
ServerBrowserSettings.items.server_browser_header_friends[1366] = ServerBrowserSettings.items.server_browser_header_friends[1366] or {}
ServerBrowserSettings.items.server_browser_header_friends[1366][768] = ServerBrowserSettings.items.server_browser_header_friends[1366][768] or {
	texture = "friends_1366",
	texture_sort_asc = "sort_ascending_1366",
	texture_sort_width = 12,
	texture_sort_offset_z = 1,
	rect_delimiter_offset_y = 0,
	rect_delimiter_offset_z = 2,
	texture_offset_z = 1,
	texture_sort_height = 12,
	rect_delimiter_offset_x = -2,
	texture_width = 12,
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending_1366",
	texture_height = 16,
	texture_offset_x = 8 * SCALE_1366,
	texture_offset_y = 6 * SCALE_1366,
	rect_delimiter_height = 32 * SCALE_1366,
	rect_delimiter_color = {
		255,
		60,
		60,
		60
	},
	texture_sort_offset_x = -26 * SCALE_1366,
	texture_sort_offset_y = 10 * SCALE_1366,
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server_browser_header_text = ServerBrowserSettings.items.server_browser_header_text or {}
ServerBrowserSettings.items.server_browser_header_text[1366] = ServerBrowserSettings.items.server_browser_header_text[1366] or {}
ServerBrowserSettings.items.server_browser_header_text[1366][768] = ServerBrowserSettings.items.server_browser_header_text[1366][768] or {
	font_size = 14,
	texture_sort_width = 12,
	texture_sort_offset_z = 1,
	text_offset_z = 1,
	rect_delimiter_offset_y = 0,
	rect_delimiter_offset_z = 1,
	texture_sort_height = 12,
	rect_delimiter_offset_x = -2,
	texture_sort_asc = "sort_ascending_1366",
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending_1366",
	font = MenuSettings.fonts.hell_shark_14,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_offset_x = 8 * SCALE_1366,
	text_offset_y = 10 * SCALE_1366,
	rect_delimiter_color = {
		255,
		60,
		60,
		60
	},
	rect_delimiter_height = 32 * SCALE_1366,
	texture_sort_offset_x = -26 * SCALE_1366,
	texture_sort_offset_y = 10 * SCALE_1366,
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.server = ServerBrowserSettings.items.server or {}
ServerBrowserSettings.items.server[1366] = ServerBrowserSettings.items.server[1366] or {}
ServerBrowserSettings.items.server[1366][768] = ServerBrowserSettings.items.server[1366][768] or {
	demo_text = "menu_demo_text",
	demo_text_offset_x = 12,
	secure_texture = "shield_1366",
	demo_text_font_size = 11,
	font_size = 13,
	secure_texture_height = 16,
	password_texture_height = 16,
	password_texture = "lock_1366",
	demo_text_material = "hell_shark_11",
	demo_text_font = "materials/fonts/hell_shark_11",
	password_texture_width = 12,
	secure_texture_width = 16,
	font = MenuSettings.fonts.hell_shark_13,
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
	text_offset_x = 8 * SCALE_1366,
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
	password_texture_offset_x = 8 * SCALE_1366,
	password_texture_offset_y = 6 * SCALE_1366,
	secure_texture_offset_x = 8 * SCALE_1366,
	secure_texture_offset_y = 6 * SCALE_1366,
	favorite_texture_offset_x = 6 * SCALE_1366,
	favorite_texture_offset_y = 4 * SCALE_1366,
	column_width = {
		43,
		43,
		43,
		309,
		168,
		85,
		43,
		148,
		85
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
ServerBrowserSettings.items.favorite[1366] = ServerBrowserSettings.items.favorite[1366] or {}
ServerBrowserSettings.items.favorite[1366][768] = ServerBrowserSettings.items.favorite[1366][768] or {
	texture = "favorite_1366",
	texture_highlighted = "favorite_glow_1366",
	texture_highlighted_height = 36,
	texture_highlighted_width = 36,
	padding_left = 0,
	padding_top = 0,
	padding_bottom = 0,
	texture_width = 20,
	texture_highlighted_offset_z = 0,
	texture_height = 20,
	texture_highlighted_offset_x = -12 * SCALE_1366,
	texture_highlighted_offset_y = -11 * SCALE_1366,
	padding_right = 22 * SCALE_1366
}
ServerBrowserSettings.items.server_browser_scroll_bar = ServerBrowserSettings.items.server_browser_scroll_bar or {}
ServerBrowserSettings.items.server_browser_scroll_bar[1366] = ServerBrowserSettings.items.server_browser_scroll_bar[1366] or {}
ServerBrowserSettings.items.server_browser_scroll_bar[1366][768] = ServerBrowserSettings.items.server_browser_scroll_bar[1366][768] or {
	scroll_bar_handle_width = 5,
	width = 9,
	scroll_bar_width = 1,
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
ServerBrowserSettings.items.server_info_description[1366] = ServerBrowserSettings.items.server_info_description[1366] or {}
ServerBrowserSettings.items.server_info_description[1366][768] = ServerBrowserSettings.items.server_info_description[1366][768] or {
	font_size = 13,
	padding_right = 0,
	text_align = "left",
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_13,
	color = {
		255,
		255,
		255,
		255
	},
	line_height = 20 * SCALE_1366,
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
	},
	padding_top = 10 * SCALE_1366,
	padding_left = 20 * SCALE_1366
}
ServerBrowserSettings.items.thin_delimiter_texture = ServerBrowserSettings.items.thin_delimiter_texture or {}
ServerBrowserSettings.items.thin_delimiter_texture[1366] = ServerBrowserSettings.items.thin_delimiter_texture[1366] or {}
ServerBrowserSettings.items.thin_delimiter_texture[1366][768] = ServerBrowserSettings.items.thin_delimiter_texture[1366][768] or {
	texture = "thin_horizontal_delimiter_1366",
	padding_bottom = 0,
	texture_width = 324,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_height = 4
}
ServerBrowserSettings.items.server_info_properties = ServerBrowserSettings.items.server_info_properties or {}
ServerBrowserSettings.items.server_info_properties[1366] = ServerBrowserSettings.items.server_info_properties[1366] or {}
ServerBrowserSettings.items.server_info_properties[1366][768] = ServerBrowserSettings.items.server_info_properties[1366][768] or {
	font_size = 13,
	padding_top = 0,
	padding_bottom = 0,
	font = MenuSettings.fonts.hell_shark_13,
	line_height = 13 * SCALE_1366,
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
	padding_left = 20 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
ServerBrowserSettings.items.player_info_header_text = ServerBrowserSettings.items.player_info_header_text or {}
ServerBrowserSettings.items.player_info_header_text[1366] = ServerBrowserSettings.items.player_info_header_text[1366] or {}
ServerBrowserSettings.items.player_info_header_text[1366][768] = ServerBrowserSettings.items.player_info_header_text[1366][768] or {
	font_size = 13,
	texture_sort_width = 12,
	texture_sort_offset_z = 1,
	text_offset_z = 1,
	rect_delimiter_offset_y = 0,
	rect_delimiter_offset_z = 1,
	texture_sort_height = 12,
	rect_delimiter_offset_x = -2,
	texture_sort_asc = "sort_ascending_1366",
	rect_delimiter_width = 2,
	texture_sort_desc = "sort_descending_1366",
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
	texture_sort_offset_x = -26 * SCALE_1366,
	texture_sort_offset_y = 10 * SCALE_1366,
	rect_background_color = {
		255,
		0,
		0,
		0
	}
}
ServerBrowserSettings.items.player_info_header_text_right_aligned = ServerBrowserSettings.items.player_info_header_text_right_aligned or {}
ServerBrowserSettings.items.player_info_header_text_right_aligned[1366] = ServerBrowserSettings.items.player_info_header_text_right_aligned[1366] or {}
ServerBrowserSettings.items.player_info_header_text_right_aligned[1366][768] = ServerBrowserSettings.items.player_info_header_text_right_aligned[1366][768] or table.clone(ServerBrowserSettings.items.player_info_header_text[1366][768])
ServerBrowserSettings.items.player_info_header_text_right_aligned[1366][768].text_align = "right"
ServerBrowserSettings.items.player_info_header_text_right_aligned[1366][768].text_offset_x = -40 * SCALE_1366
ServerBrowserSettings.items.server_info_header_text = ServerBrowserSettings.items.server_info_header_text or {}
ServerBrowserSettings.items.server_info_header_text[1366] = ServerBrowserSettings.items.server_info_header_text[1366] or {}
ServerBrowserSettings.items.server_info_header_text[1366][768] = ServerBrowserSettings.items.server_info_header_text[1366][768] or table.clone(ServerBrowserSettings.items.player_info_header_text[1366][768])
ServerBrowserSettings.items.server_info_header_text[1366][768].text_max_width = 320
ServerBrowserSettings.items.player_info = ServerBrowserSettings.items.player_info or {}
ServerBrowserSettings.items.player_info[1366] = ServerBrowserSettings.items.player_info[1366] or {}
ServerBrowserSettings.items.player_info[1366][768] = ServerBrowserSettings.items.player_info[1366][768] or {
	font_size = 13,
	friend_texture_width = 12,
	friend_texture = "friends_1366",
	friend_texture_height = 16,
	font = MenuSettings.fonts.hell_shark_13,
	text_color = {
		255,
		255,
		255,
		255
	},
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
	friend_texture_offset_x = 30 * SCALE_1366,
	friend_texture_offset_y = 6 * SCALE_1366,
	column_width = {
		60 * SCALE_1366,
		260 * SCALE_1366,
		140 * SCALE_1366
	}
}
ServerBrowserSettings.items.server_info_close_texture = ServerBrowserSettings.items.server_info_close_texture or {}
ServerBrowserSettings.items.server_info_close_texture[1366] = ServerBrowserSettings.items.server_info_close_texture[1366] or {}
ServerBrowserSettings.items.server_info_close_texture[1366][768] = ServerBrowserSettings.items.server_info_close_texture[1366][768] or {
	texture = "checkbox_close_1366",
	texture_highlighted = "checkbox_close_1366",
	texture_highlighted_height = 28,
	texture_background_height = 28,
	padding_top = 0,
	texture_background = "checkbox_off_1366",
	padding_bottom = 0,
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
ServerBrowserSettings.items.server_type_tab = ServerBrowserSettings.items.server_type_tab or {}
ServerBrowserSettings.items.server_type_tab[1366] = ServerBrowserSettings.items.server_type_tab[1366] or {}
ServerBrowserSettings.items.server_type_tab[1366][768] = ServerBrowserSettings.items.server_type_tab[1366][768] or {
	texture = "tab_background_1366",
	height = 28,
	font_size = 14,
	text_padding_left = 0,
	text_align = "right",
	texture_align = "right",
	texture_width = 108,
	min_width = 108,
	texture_height = 28,
	font = MenuSettings.fonts.hell_shark_14,
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
	text_padding_right = 16 * SCALE_1366,
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
ServerBrowserSettings.items.tab_gradient_texture[1366] = ServerBrowserSettings.items.tab_gradient_texture[1366] or {}
ServerBrowserSettings.items.tab_gradient_texture[1366][768] = ServerBrowserSettings.items.tab_gradient_texture[1366][768] or {
	texture = "tab_gradient_1366",
	padding_bottom = 0,
	texture_width = 1000,
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	texture_height = 4
}
ServerBrowserSettings.items.server_browser_button = ServerBrowserSettings.items.server_browser_button or {}
ServerBrowserSettings.items.server_browser_button[1366] = ServerBrowserSettings.items.server_browser_button[1366] or {}
ServerBrowserSettings.items.server_browser_button[1366][768] = ServerBrowserSettings.items.server_browser_button[1366][768] or {
	text_padding = 0,
	texture_right_width = 20,
	texture_left = "shiny_button_left_end_1366",
	text_offset_y = 17,
	font_size = 14,
	texture_middle = "shiny_button_center_1366",
	texture_right = "shiny_button_right_end_1366",
	padding_bottom = 0,
	texture_middle_highlighted = "shiny_button_center_highlighted_1366",
	texture_right_highlighted = "shiny_button_right_end_highlighted_1366",
	padding_top = 0,
	texture_left_width = 20,
	texture_left_highlighted = "shiny_button_left_end_highlighted_1366",
	padding_left = 0,
	padding_right = 6,
	texture_height = 44,
	font = MenuSettings.fonts.hell_shark_14,
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
ServerBrowserSettings.items.server_filter_ddl_closed_text[1366] = ServerBrowserSettings.items.server_filter_ddl_closed_text[1366] or {}
ServerBrowserSettings.items.server_filter_ddl_closed_text[1366][768] = ServerBrowserSettings.items.server_filter_ddl_closed_text[1366][768] or {
	texture_arrow_offset_x = -1,
	texture_background_height = 24,
	texture_alignment = "left",
	texture_arrow_width = 16,
	font_size = 14,
	padding_top = 0,
	texture_arrow_height = 12,
	padding_bottom = 0,
	texture_background_width = 264,
	texture_background = "selected_item_bgr_left_small_1366",
	texture_arrow = "drop_down_list_arrow_1366",
	padding_right = 0,
	font = MenuSettings.fonts.hell_shark_14,
	line_height = 12 * SCALE_1366,
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
	},
	texture_arrow_offset_y = -28 * SCALE_1366,
	padding_left = 10 * SCALE_1366
}
ServerBrowserSettings.items.server_filter_ddl_open_text = ServerBrowserSettings.items.server_filter_ddl_open_text or {}
ServerBrowserSettings.items.server_filter_ddl_open_text[1366] = ServerBrowserSettings.items.server_filter_ddl_open_text[1366] or {}
ServerBrowserSettings.items.server_filter_ddl_open_text[1366][768] = ServerBrowserSettings.items.server_filter_ddl_open_text[1366][768] or {
	texture_highlighted = "selected_item_bgr_left_1366",
	texture_highlighted_height = 24,
	font_size = 14,
	texture_alignment = "left",
	texture_highlighted_width = 440,
	font = MenuSettings.fonts.hell_shark_14,
	line_height = 12 * SCALE_1366,
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
	padding_top = 9 * SCALE_1366,
	padding_bottom = 9 * SCALE_1366,
	padding_left = 20 * SCALE_1366,
	padding_right = 20 * SCALE_1366
}
ServerBrowserSettings.pages.server_filter_ddl = ServerBrowserSettings.pages.server_filter_ddl or {}
ServerBrowserSettings.pages.server_filter_ddl[1366] = ServerBrowserSettings.pages.server_filter_ddl[1366] or {}
ServerBrowserSettings.pages.server_filter_ddl[1366][768] = ServerBrowserSettings.pages.server_filter_ddl[1366][768] or {
	drop_down_list = {
		number_of_visible_rows = 5,
		texture_background_width = 400,
		offset_y = -10,
		texture_background = "ddl_background_left_1366",
		texture_background_align = "left",
		list_alignment = "left",
		offset_x = 22 * SCALE_1366,
		item_config = ServerBrowserSettings.items.server_filter_ddl_open_text,
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
}
ServerBrowserSettings.items.drop_down_list_scroll_bar = ServerBrowserSettings.items.drop_down_list_scroll_bar or {}
ServerBrowserSettings.items.drop_down_list_scroll_bar[1366] = ServerBrowserSettings.items.drop_down_list_scroll_bar[1366] or {}
ServerBrowserSettings.items.drop_down_list_scroll_bar[1366][768] = ServerBrowserSettings.items.drop_down_list_scroll_bar[1366][768] or {
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
ServerBrowserSettings.items.server_filter_checkbox[1366] = ServerBrowserSettings.items.server_filter_checkbox[1366] or {}
ServerBrowserSettings.items.server_filter_checkbox[1366][768] = ServerBrowserSettings.items.server_filter_checkbox[1366][768] or {
	texture_selected_width = 28,
	texture_selected_height = 28,
	texture_deselected_width = 28,
	texture_selected = "checkbox_on_1366",
	font_size = 14,
	padding_top = 0,
	texture_deselected_height = 28,
	padding_bottom = 0,
	texture_deselected = "checkbox_off_1366",
	font = MenuSettings.fonts.hell_shark_14,
	line_height = 13 * SCALE_1366,
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
	texture_selected_offset_x = -8 * SCALE_1366,
	texture_deselected_offset_x = -8 * SCALE_1366,
	texture_disabled_color = {
		80,
		255,
		255,
		255
	},
	padding_left = 40 * SCALE_1366,
	padding_right = 30 * SCALE_1366
}
ServerBrowserSettings.items.popup_filter_checkbox = ServerBrowserSettings.items.popup_filter_checkbox or {}
ServerBrowserSettings.items.popup_filter_checkbox[1366] = ServerBrowserSettings.items.popup_filter_checkbox[1366] or {}
ServerBrowserSettings.items.popup_filter_checkbox[1366][768] = ServerBrowserSettings.items.popup_filter_checkbox[1366][768] or table.clone(ServerBrowserSettings.items.server_filter_checkbox[1366][768])
ServerBrowserSettings.items.popup_filter_checkbox[1366][768].padding_top = 10 * SCALE_1366
ServerBrowserSettings.items.popup_filter_checkbox[1366][768].padding_bottom = 10 * SCALE_1366
ServerBrowserSettings.items.popup_filter_checkbox[1366][768].color_highlighted = {
	255,
	255,
	255,
	255
}
ServerBrowserSettings.items.popup_filter_checkbox[1366][768].color = {
	128,
	255,
	255,
	255
}
ServerBrowserSettings.items.popup_filter_checkbox[1366][768].color_selected = nil
ServerBrowserSettings.items.popup_filter_ddl_closed_text = ServerBrowserSettings.items.popup_filter_ddl_closed_text or {}
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366] = ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366] or {}
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768] = ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768] or table.clone(ServerBrowserSettings.items.server_filter_ddl_closed_text[1366][768])
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768].padding_top = 20 * SCALE_1366
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768].padding_bottom = 20 * SCALE_1366
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768].color_highlighted = {
	255,
	255,
	255,
	255
}
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768].color = {
	128,
	255,
	255,
	255
}
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768].hide_arrow_when_unselected = true
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768].texture_arrow_offset_x = 0
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768].texture_arrow_offset_y = 0
ServerBrowserSettings.items.popup_filter_ddl_closed_text[1366][768].padding_left = 30 * SCALE_1366
ServerBrowserSettings.pages.popup_server_filter_ddl = ServerBrowserSettings.pages.popup_server_filter_ddl or {}
ServerBrowserSettings.pages.popup_server_filter_ddl[1366] = ServerBrowserSettings.pages.popup_server_filter_ddl[1366] or {}
ServerBrowserSettings.pages.popup_server_filter_ddl[1366][768] = ServerBrowserSettings.pages.popup_server_filter_ddl[1366][768] or table.clone(ServerBrowserSettings.pages.server_filter_ddl[1366][768])
ServerBrowserSettings.pages.popup_server_filter_ddl[1366][768].drop_down_list.offset_x = 0
ServerBrowserSettings.pages.popup_server_filter_ddl[1366][768].drop_down_list.offset_y = 45 * SCALE_1366
