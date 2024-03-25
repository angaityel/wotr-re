-- chunkname: @scripts/menu/menu_definitions/server_browser_page_definition.lua

require("scripts/menu/menu_definitions/server_browser_page_settings_1920")
require("scripts/menu/menu_definitions/server_browser_page_settings_1366")

ServerBrowserPageDefinition = {
	text = "menu_main_serverbrowser",
	disabled_func = "cb_steam_server_browser_disabled",
	type = "TextMenuItem",
	layout_settings = MainMenuSettings.items.text_right_aligned,
	page = {
		z = 100,
		type = "ServerBrowserMenuPage",
		layout_settings = ServerBrowserSettings.pages.server_browser,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			server_type_tabs = {
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "menu_internet",
					name = "server_type_internet",
					on_select = "cb_set_server_type",
					type = "TabMenuItem",
					callback_object = "page",
					on_select_args = {
						"internet"
					},
					layout_settings = ServerBrowserSettings.items.server_type_tab
				},
				{
					text = "menu_favorites",
					name = "server_type_favorites",
					on_select = "cb_set_server_type",
					type = "TabMenuItem",
					callback_object = "page",
					on_select_args = {
						"favorites"
					},
					layout_settings = ServerBrowserSettings.items.server_type_tab
				},
				{
					text = "menu_history",
					name = "server_type_history",
					on_select = "cb_set_server_type",
					type = "TabMenuItem",
					callback_object = "page",
					on_select_args = {
						"history"
					},
					layout_settings = ServerBrowserSettings.items.server_type_tab
				},
				{
					text = "menu_friends",
					name = "server_type_friends",
					on_select = "cb_set_server_type",
					type = "TabMenuItem",
					callback_object = "page",
					on_select_args = {
						"friends"
					},
					layout_settings = ServerBrowserSettings.items.server_type_tab
				},
				{
					text = "menu_lan",
					name = "server_type_lan",
					visible_func = "cb_server_type_lan_visible",
					type = "TabMenuItem",
					on_select = "cb_set_server_type",
					callback_object = "page",
					on_select_args = {
						"lan"
					},
					layout_settings = ServerBrowserSettings.items.server_type_tab
				},
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = ServerBrowserSettings.items.tab_gradient_texture
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				}
			},
			browser_header = {
				{
					callback_object = "page",
					type = "ColumnHeaderTextureMenuItem",
					default_sort_order = "desc",
					sort_column = "password",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_password
				},
				{
					callback_object = "page",
					type = "ColumnHeaderTextureMenuItem",
					default_sort_order = "desc",
					sort_column = "secure",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_secure
				},
				{
					callback_object = "page",
					type = "ColumnHeaderTextureMenuItem",
					default_sort_order = "desc",
					sort_column = "favorite",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_favorite
				},
				{
					text = "",
					name = "server_name_column_header",
					callback_object = "page",
					type = "ColumnHeaderTextMenuItem",
					default_sort_order = "asc",
					sort_column = "server_name",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_text
				},
				{
					text = "menu_game_mode",
					callback_object = "page",
					type = "ColumnHeaderTextMenuItem",
					default_sort_order = "asc",
					sort_column = "game_mode",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_text
				},
				{
					text = "menu_players",
					callback_object = "page",
					type = "ColumnHeaderTextMenuItem",
					default_sort_order = "desc",
					sort_column = "num_players",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_text
				},
				{
					callback_object = "page",
					type = "ColumnHeaderTextureMenuItem",
					default_sort_order = "desc",
					sort_column = "num_friends",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_friends
				},
				{
					text = "menu_map",
					callback_object = "page",
					type = "ColumnHeaderTextMenuItem",
					default_sort_order = "asc",
					sort_column = "map",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_text
				},
				{
					text = "menu_latency",
					name = "latency",
					callback_object = "page",
					type = "ColumnHeaderTextMenuItem",
					default_sort_order = "asc",
					sort_column = "latency",
					on_select = "cb_sort_browser",
					layout_settings = ServerBrowserSettings.items.server_browser_header_text
				}
			},
			browser_items = {},
			favorite_items = {},
			browser_scroll_bar = {
				{
					callback_object = "page",
					on_select_down = "cb_browser_scroll_select_down",
					disabled_func = "cb_browser_scroll_disabled",
					type = "ScrollBarMenuItem",
					layout_settings = ServerBrowserSettings.items.server_browser_scroll_bar
				}
			},
			browser_local_filters = {
				{
					callback_object = "page",
					on_enter_text = "cb_on_enter_text_local_filter_game_mode",
					type = "DropDownListMenuItem",
					layout_settings = ServerBrowserSettings.items.server_filter_ddl_closed_text,
					page = {
						on_enter_options = "cb_on_enter_options_local_filter_game_mode",
						z = 150,
						type = "DropDownListMenuPage",
						on_option_changed = "cb_on_option_changed_local_filter_game_mode",
						callback_object = "parent_page",
						layout_settings = ServerBrowserSettings.pages.server_filter_ddl,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							scroll_bar = {
								{
									callback_object = "page",
									on_select_down = "cb_scroll_bar_select_down",
									disabled_func = "cb_scroll_bar_disabled",
									type = "ScrollBarMenuItem",
									layout_settings = ServerBrowserSettings.items.drop_down_list_scroll_bar
								}
							}
						}
					}
				},
				{
					text = "menu_password_protected",
					name = "local_filter_password",
					on_select = "cb_on_select_local_filter_password",
					type = "CheckboxMenuItem",
					on_enter_select = "cb_on_enter_local_filter_password",
					callback_object = "page",
					layout_settings = ServerBrowserSettings.items.server_filter_checkbox
				},
				{
					text = "menu_demo",
					name = "local_filter_demo",
					on_enter_select = "cb_on_enter_local_filter_demo",
					type = "CheckboxMenuItem",
					remove_func = "cb_demo_checkbox_remove",
					on_select = "cb_on_select_local_filter_demo",
					callback_object = "page",
					layout_settings = ServerBrowserSettings.items.server_filter_checkbox
				},
				{
					text = "menu_only_available",
					name = "local_filter_only_available",
					on_select = "cb_on_select_local_filter_only_available",
					type = "CheckboxMenuItem",
					on_enter_select = "cb_on_enter_local_filter_only_available",
					callback_object = "page",
					layout_settings = ServerBrowserSettings.items.server_filter_checkbox
				}
			},
			browser_query_filters = {
				{
					text = "menu_server_not_full",
					name = "query_filter_not_full",
					on_select = "cb_on_select_query_filter_not_full",
					type = "CheckboxMenuItem",
					on_enter_select = "cb_on_enter_query_filter_not_full",
					callback_object = "page",
					layout_settings = ServerBrowserSettings.items.server_filter_checkbox
				},
				{
					callback_object = "page",
					on_enter_text = "cb_on_enter_text_query_filter_level",
					type = "DropDownListMenuItem",
					layout_settings = ServerBrowserSettings.items.server_filter_ddl_closed_text,
					page = {
						on_enter_options = "cb_on_enter_options_query_filter_level",
						z = 150,
						type = "DropDownListMenuPage",
						on_option_changed = "cb_on_option_changed_query_filter_level",
						callback_object = "parent_page",
						layout_settings = ServerBrowserSettings.pages.server_filter_ddl,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							scroll_bar = {
								{
									callback_object = "page",
									on_select_down = "cb_scroll_bar_select_down",
									disabled_func = "cb_scroll_bar_disabled",
									type = "ScrollBarMenuItem",
									layout_settings = ServerBrowserSettings.items.drop_down_list_scroll_bar
								}
							}
						}
					}
				},
				{
					text = "menu_server_has_players",
					name = "query_filter_has_players",
					on_select = "cb_on_select_query_filter_has_players",
					type = "CheckboxMenuItem",
					on_enter_select = "cb_on_enter_query_filter_has_players",
					callback_object = "page",
					layout_settings = ServerBrowserSettings.items.server_filter_checkbox
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				}
			},
			browser_buttons = {
				{
					text = "menu_quick_refresh",
					name = "quick_refresh",
					disabled_func = "cb_quick_refresh_button_disabled",
					type = "TextureButtonMenuItem",
					on_select = "cb_quick_refresh",
					callback_object = "page",
					layout_settings = ServerBrowserSettings.items.server_browser_button
				},
				{
					text = "menu_refresh_all",
					callback_object = "page",
					on_select = "cb_refresh_all",
					type = "TextureButtonMenuItem",
					layout_settings = ServerBrowserSettings.items.server_browser_button
				},
				{
					text = "menu_connect",
					name = "connect",
					disabled_func = "cb_connect_button_disabled",
					type = "TextureButtonMenuItem",
					on_select = "cb_connect",
					callback_object = "page",
					layout_settings = ServerBrowserSettings.items.server_browser_button
				},
				{
					name = "password_popup",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty,
					page = {
						try_big_picture_input = true,
						z = 200,
						on_enter_options = "cb_password_popup_enter",
						type = "PopupMenuPage",
						on_item_selected = "cb_password_popup_item_selected",
						callback_object = "parent_page",
						layout_settings = MainMenuSettings.pages.text_input_popup_no_overlay,
						sounds = MenuSettings.sounds.default,
						big_picture_input_params = {
							description = "menu_enter_server_password",
							bp_callback_object = "parent_page",
							min_text_length = 1,
							max_text_length = 40,
							bp_callback_name = "cb_password_entered_from_controller_input",
							password = true
						},
						item_groups = {
							header_list = {
								{
									text = "menu_enter_server_password",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_header
								}
							},
							item_list = {
								{
									max_text_length = 40,
									name = "password_input",
									min_text_length = 1,
									type = "TextInputMenuItem",
									layout_settings = MainMenuSettings.items.popup_input
								}
							},
							button_list = {
								{
									text = "menu_cancel",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close"
									},
									layout_settings = MainMenuSettings.items.popup_button
								},
								{
									disabled_func_args = "cb_password_popup_continue_disabled",
									on_select = "cb_item_selected",
									disabled_func = "cb_item_disabled",
									type = "TextureButtonMenuItem",
									text = "menu_ok",
									callback_object = "page",
									on_select_args = {
										"close",
										"continue"
									},
									layout_settings = MainMenuSettings.items.popup_button
								}
							}
						}
					}
				},
				{
					name = "connecting_popup",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty,
					page = {
						on_enter_options = "cb_connecting_popup_enter",
						z = 200,
						on_cancel_exit = "cb_connecting_popup_cancel",
						type = "PopupMenuPage",
						on_item_selected = "cb_connecting_popup_item_selected",
						callback_object = "parent_page",
						layout_settings = MainMenuSettings.pages.message_popup_no_overlay,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							header_list = {
								{
									text = "menu_empty",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_header
								}
							},
							item_list = {
								{
									text = "menu_empty",
									name = "connecting_text",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_text
								},
								{
									disabled = true,
									name = "connecting_texture",
									type = "AnimatedTextureMenuItem",
									layout_settings = MainMenuSettings.items.popup_loading_texture
								}
							},
							button_list = {
								{
									type = "EmptyMenuItem",
									layout_settings = MainMenuSettings.items.empty
								},
								{
									text = "menu_close_upper",
									name = "close_button",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select = "cb_item_selected",
									on_select_args = {
										"close"
									},
									layout_settings = MainMenuSettings.items.popup_button
								}
							}
						}
					}
				}
			},
			server_info = {
				{
					text = "",
					name = "info_server_name",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_header_text
				},
				{
					text = "",
					no_localization = true,
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = ServerBrowserSettings.items.server_info_header_text
				},
				{
					callback_object = "page",
					on_select = "cb_close_server_info",
					type = "TextureMenuItem",
					layout_settings = ServerBrowserSettings.items.server_info_close_texture
				},
				{
					text = "",
					name = "server_info_description",
					disabled = true,
					type = "TextBoxMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_description
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = ServerBrowserSettings.items.thin_delimiter_texture
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "",
					name = "info_server_map",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_properties
				},
				{
					text = "",
					name = "info_server_type",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_properties
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "",
					name = "info_server_game_mode",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_properties
				},
				{
					text = "",
					name = "info_server_password",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_properties
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "",
					name = "info_server_players",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_properties
				},
				{
					text = "",
					name = "info_server_secure",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_properties
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "",
					name = "info_server_latency",
					disabled = true,
					type = "TextMenuItem",
					no_localization = true,
					layout_settings = ServerBrowserSettings.items.server_info_properties
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				}
			},
			player_info_header = {
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = ServerBrowserSettings.items.thin_delimiter_texture
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					text = "",
					no_localization = true,
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = ServerBrowserSettings.items.player_info_header_text
				},
				{
					text = "menu_player_name_lower",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = ServerBrowserSettings.items.player_info_header_text
				},
				{
					text = "menu_score_lower",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = ServerBrowserSettings.items.player_info_header_text
				},
				{
					text = "menu_rank_lower",
					disabled = true,
					type = "ColumnHeaderTextMenuItem",
					layout_settings = ServerBrowserSettings.items.player_info_header_text_right_aligned
				},
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = ServerBrowserSettings.items.thin_delimiter_texture
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				},
				{
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty
				}
			},
			player_info_items = {},
			player_info_scroll_bar = {
				{
					callback_object = "page",
					on_select_down = "cb_player_info_scroll_select_down",
					disabled_func = "cb_player_info_scroll_disabled",
					type = "ScrollBarMenuItem",
					layout_settings = ServerBrowserSettings.items.server_browser_scroll_bar
				}
			}
		}
	}
}
