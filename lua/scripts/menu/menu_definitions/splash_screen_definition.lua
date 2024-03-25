-- chunkname: @scripts/menu/menu_definitions/splash_screen_definition.lua

require("scripts/menu/menu_definitions/main_menu_settings_1920")
require("scripts/menu/menu_definitions/main_menu_settings_1366")
require("scripts/menu/menu_definitions/main_menu_settings_low")

SplashScreenSettings = SplashScreenSettings or {}
SplashScreenSettings.items = SplashScreenSettings.items or {}
SplashScreenSettings.pages = SplashScreenSettings.pages or {}
SplashScreenSettings.items.loading_indicator = SplashScreenSettings.items.loading_indicator or {}
SplashScreenSettings.items.loading_indicator[1680] = SplashScreenSettings.items.loading_indicator[1680] or {}
SplashScreenSettings.items.loading_indicator[1680][1050] = SplashScreenSettings.items.loading_indicator[1680][1050] or table.clone(LoadingScreenMenuSettings.items.loading_indicator[1680][1050])
SplashScreenSettings.items.loading_indicator[1680][1050].screen_align_x = "left"
SplashScreenSettings.items.loading_indicator[1680][1050].screen_offset_x = 0.03
SplashScreenSettings.items.loading_indicator[1680][1050].pivot_align_x = "right"
SplashScreenSettings.items.fatshark_splash = SplashScreenSettings.items.fatshark_splash or {}
SplashScreenSettings.items.fatshark_splash[1680] = SplashScreenSettings.items.fatshark_splash[1680] or {}
SplashScreenSettings.items.fatshark_splash[1680][1050] = SplashScreenSettings.items.fatshark_splash[1680][1050] or {
	padding_top = 0,
	padding_bottom = 0,
	video_height = 720,
	padding_left = 0,
	fullscreen = true,
	padding_right = 0,
	video_width = 1280,
	video = MenuSettings.videos.fatshark_splash
}
SplashScreenSettings.items.paradox_splash = SplashScreenSettings.items.paradox_splash or {}
SplashScreenSettings.items.paradox_splash[1680] = SplashScreenSettings.items.paradox_splash[1680] or {}
SplashScreenSettings.items.paradox_splash[1680][1050] = SplashScreenSettings.items.paradox_splash[1680][1050] or {
	padding_top = 0,
	padding_bottom = 0,
	video_height = 720,
	padding_left = 0,
	fullscreen = true,
	padding_right = 0,
	video_width = 1280,
	video = MenuSettings.videos.paradox_splash
}
SplashScreenSettings.items.physx_splash = SplashScreenSettings.items.physx_splash or {}
SplashScreenSettings.items.physx_splash[1680] = SplashScreenSettings.items.physx_splash[1680] or {}
SplashScreenSettings.items.physx_splash[1680][1050] = SplashScreenSettings.items.physx_splash[1680][1050] or {
	padding_top = 0,
	padding_bottom = 0,
	video_height = 720,
	padding_left = 0,
	fullscreen = true,
	padding_right = 0,
	video_width = 1280,
	video = MenuSettings.videos.physx_splash
}
SplashScreenSettings.items.bitsquid_splash = SplashScreenSettings.items.bitsquid_splash or {}
SplashScreenSettings.items.bitsquid_splash[1680] = SplashScreenSettings.items.bitsquid_splash[1680] or {}
SplashScreenSettings.items.bitsquid_splash[1680][1050] = SplashScreenSettings.items.bitsquid_splash[1680][1050] or {
	padding_left = 0,
	padding_top = 0,
	padding_right = 0,
	padding_bottom = 0
}
SplashScreenSettings.items.popup_button_small_text = SplashScreenSettings.items.popup_button_small_text or {}
SplashScreenSettings.items.popup_button_small_text[1680] = SplashScreenSettings.items.popup_button_small_text[1680] or {}
SplashScreenSettings.items.popup_button_small_text[1680][1050] = SplashScreenSettings.items.popup_button_small_text[1680][1050] or table.clone(MainMenuSettings.items.popup_button[1680][1050])
SplashScreenSettings.items.popup_button_small_text[1680][1050].font = MenuSettings.fonts.hell_shark_20
SplashScreenSettings.items.popup_button_small_text[1680][1050].font_size = 20
SplashScreenSettings.items.popup_button_small_text[1680][1050].text_offset_y = 24
SplashScreenSettings.items.popup_button_small_text[1680][1050].padding_left = 0
SplashScreenSettings.items.popup_button_small_text[1680][1050].padding_right = 0
SplashScreenSettings.items.expandable_popup_checkbox = SplashScreenSettings.items.expandable_popup_checkbox or {}
SplashScreenSettings.items.expandable_popup_checkbox[1680] = SplashScreenSettings.items.expandable_popup_checkbox[1680] or {}
SplashScreenSettings.items.expandable_popup_checkbox[1680][1050] = SplashScreenSettings.items.expandable_popup_checkbox[1680][1050] or table.clone(ServerBrowserSettings.items.server_filter_checkbox[1680][1050])
SplashScreenSettings.items.expandable_popup_checkbox[1680][1050].texture_selected_offset_x = 5
SplashScreenSettings.items.expandable_popup_checkbox[1680][1050].texture_deselected_offset_x = 5
SplashScreenSettings.items.expandable_popup_checkbox[1680][1050].padding_top = 20
SplashScreenSettings.items.expandable_popup_checkbox[1680][1050].padding_bottom = 20
SplashScreenSettings.items.expandable_popup_checkbox[1680][1050].padding_left = 46
SplashScreenSettings.items.expandable_popup_checkbox[1680][1050].padding_right = 0
SplashScreenSettings.pages.splash_screen = SplashScreenSettings.pages.splash_screen or {}
SplashScreenSettings.pages.splash_screen[1680] = SplashScreenSettings.pages.splash_screen[1680] or {}
SplashScreenSettings.pages.splash_screen[1680][1050] = SplashScreenSettings.pages.splash_screen[1680][1050] or {
	do_not_render_buttons = true,
	item_list = {
		screen_align_y = "center",
		screen_offset_x = 0,
		pivot_offset_x = 0,
		screen_offset_y = 0,
		pivot_align_x = "center",
		pivot_align_y = "center",
		screen_align_x = "center",
		pivot_offset_y = 0
	}
}
SplashScreenSettings.pages.error_popup = SplashScreenSettings.pages.error_popup or {}
SplashScreenSettings.pages.error_popup[1680] = SplashScreenSettings.pages.error_popup[1680] or {}
SplashScreenSettings.pages.error_popup[1680][1050] = SplashScreenSettings.pages.error_popup[1680][1050] or table.clone(MainMenuSettings.pages.text_input_popup[1680][1050])
SplashScreenSettings.pages.error_popup[1680][1050].overlay_texture = nil
SplashScreenSettings.items.popup_button_small_text = SplashScreenSettings.items.popup_button_small_text or {}
SplashScreenSettings.items.popup_button_small_text[1366] = SplashScreenSettings.items.popup_button_small_text[1366] or {}
SplashScreenSettings.items.popup_button_small_text[1366][768] = SplashScreenSettings.items.popup_button_small_text[1366][768] or table.clone(MainMenuSettings.items.popup_button[1366][768])
SplashScreenSettings.items.popup_button_small_text[1366][768].font = MenuSettings.fonts.hell_shark_16
SplashScreenSettings.items.popup_button_small_text[1366][768].font_size = 16
SplashScreenSettings.items.popup_button_small_text[1366][768].text_offset_y = 18
SplashScreenSettings.items.popup_button_small_text[1366][768].padding_left = 0
SplashScreenSettings.items.popup_button_small_text[1366][768].padding_right = 0
SplashScreenSettings.items.expandable_popup_checkbox = SplashScreenSettings.items.expandable_popup_checkbox or {}
SplashScreenSettings.items.expandable_popup_checkbox[1366] = SplashScreenSettings.items.expandable_popup_checkbox[1366] or {}
SplashScreenSettings.items.expandable_popup_checkbox[1366][768] = SplashScreenSettings.items.expandable_popup_checkbox[1366][768] or table.clone(ServerBrowserSettings.items.server_filter_checkbox[1366][768])
SplashScreenSettings.items.expandable_popup_checkbox[1366][768].texture_selected_offset_x = 4
SplashScreenSettings.items.expandable_popup_checkbox[1366][768].texture_deselected_offset_x = 4
SplashScreenSettings.items.expandable_popup_checkbox[1366][768].padding_top = 14
SplashScreenSettings.items.expandable_popup_checkbox[1366][768].padding_bottom = 14
SplashScreenSettings.items.expandable_popup_checkbox[1366][768].padding_left = 33
SplashScreenSettings.items.expandable_popup_checkbox[1366][768].padding_right = 0
SplashScreenSettings.pages.error_popup = SplashScreenSettings.pages.error_popup or {}
SplashScreenSettings.pages.error_popup[1366] = SplashScreenSettings.pages.error_popup[1366] or {}
SplashScreenSettings.pages.error_popup[1366][768] = SplashScreenSettings.pages.error_popup[1366][768] or table.clone(MainMenuSettings.pages.text_input_popup[1366][768])
SplashScreenSettings.pages.error_popup[1366][768].overlay_texture = nil
SplashScreenDefinition = {
	page = {
		type = "EmptyMenuPage",
		item_groups = {
			item_list = {
				{
					id = "disconnect_reason_popup",
					type = "EmptyMenuItem",
					page = {
						on_enter_options = "cb_error_popup_enter",
						z = 200,
						no_cancel_to_parent_page = true,
						type = "PopupMenuPage",
						in_splash_screen = true,
						on_item_selected = "cb_error_popup_item_selected",
						layout_settings = SplashScreenSettings.pages.error_popup,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							header_list = {
								{
									text = "error_server_disconnect",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_header
								}
							},
							item_list = {
								{
									text = "menu_empty",
									name = "popup_text",
									disabled = true,
									type = "TextBoxMenuItem",
									layout_settings = MainMenuSettings.items.popup_textbox
								}
							},
							button_list = {
								{
									text = "menu_ok",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
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
					id = "error_popup",
					type = "EmptyMenuItem",
					page = {
						on_enter_options = "cb_error_popup_enter",
						z = 200,
						no_cancel_to_parent_page = true,
						type = "PopupMenuPage",
						in_splash_screen = true,
						on_item_selected = "cb_error_popup_item_selected",
						layout_settings = SplashScreenSettings.pages.error_popup,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							header_list = {
								{
									text = "error_an_error_occured",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_header
								}
							},
							item_list = {
								{
									text = "menu_empty",
									name = "popup_text",
									disabled = true,
									type = "TextBoxMenuItem",
									layout_settings = MainMenuSettings.items.popup_textbox
								}
							},
							button_list = {
								{
									text = "error_continue_anyway",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close",
										"continue"
									},
									layout_settings = MainMenuSettings.items.popup_button
								},
								{
									text = "error_exit_game",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close",
										"quit_game"
									},
									layout_settings = MainMenuSettings.items.popup_button
								}
							}
						}
					}
				},
				{
					id = "nda_confirm_popup",
					type = "EmptyMenuItem",
					page = {
						on_enter_options = "cb_error_popup_enter",
						z = 200,
						no_cancel_to_parent_page = true,
						type = "PopupMenuPage",
						in_splash_screen = true,
						on_item_selected = "cb_error_popup_item_selected",
						layout_settings = SplashScreenSettings.pages.error_popup,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							header_list = {
								{
									text = "nda_confirm_needed",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_header
								}
							},
							item_list = {
								{
									text = "menu_empty",
									name = "popup_text",
									disabled = true,
									type = "TextBoxMenuItem",
									layout_settings = MainMenuSettings.items.popup_textbox
								}
							},
							button_list = {
								{
									text = "i_agree",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close",
										"continue"
									},
									layout_settings = SplashScreenSettings.items.popup_button_small_text
								},
								{
									text = "error_exit_game",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close",
										"quit_game"
									},
									layout_settings = MainMenuSettings.items.popup_button
								}
							}
						}
					}
				},
				{
					id = "fatal_error_popup",
					type = "EmptyMenuItem",
					page = {
						on_enter_options = "cb_error_popup_enter",
						z = 200,
						no_cancel_to_parent_page = true,
						type = "PopupMenuPage",
						in_splash_screen = true,
						on_item_selected = "cb_error_popup_item_selected",
						layout_settings = SplashScreenSettings.pages.error_popup,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							header_list = {
								{
									text = "error_an_error_occured",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_header
								}
							},
							item_list = {
								{
									text = "menu_empty",
									name = "popup_text",
									disabled = true,
									type = "TextBoxMenuItem",
									layout_settings = MainMenuSettings.items.popup_textbox
								}
							},
							button_list = {
								{
									text = "error_exit_game",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close",
										"quit_game"
									},
									layout_settings = MainMenuSettings.items.popup_button
								}
							}
						}
					}
				},
				{
					id = "fatal_error_with_http_link_popup",
					type = "EmptyMenuItem",
					page = {
						on_enter_options = "cb_error_popup_enter",
						z = 200,
						no_cancel_to_parent_page = true,
						type = "PopupMenuPage",
						in_splash_screen = true,
						on_item_selected = "cb_error_popup_item_selected",
						layout_settings = SplashScreenSettings.pages.error_popup,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							header_list = {
								{
									text = "error_an_error_occured",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.popup_header
								}
							},
							item_list = {
								{
									text = "menu_empty",
									name = "popup_text",
									disabled = true,
									type = "TextBoxMenuItem",
									layout_settings = MainMenuSettings.items.popup_textbox
								}
							},
							button_list = {
								{
									on_select = "cb_open_url_in_browser",
									type = "TextureMenuItem",
									on_select_args = {
										"https://twitter.com/WotRSupport"
									},
									layout_settings = MainMenuSettings.items.popup_twitter_link
								},
								{
									text = "error_exit_game",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close",
										"quit_game"
									},
									layout_settings = MainMenuSettings.items.popup_button
								}
							}
						}
					}
				},
				{
					id = "changelog_popup",
					type = "EmptyMenuItem",
					page = {
						on_enter_options = "cb_changelog_popup_enter",
						z = 200,
						no_cancel_to_parent_page = true,
						type = "ChangelogPopupMenuPage",
						in_splash_screen = true,
						on_item_selected = "cb_changelog_popup_item_selected",
						layout_settings = table.clone(MainMenuSettings.pages.expandable_popup),
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									text = "",
									name = "popup_header",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = MainMenuSettings.items.expandable_popup_header
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
									name = "popup_text",
									disabled = false,
									type = "ScrollingTextBoxMenuItem",
									no_localization = true,
									layout_settings = MainMenuSettings.items.expandable_popup_textbox
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
									text = "dont_show_this_again",
									name = "omit_changelog_checkbox",
									type = "CheckboxMenuItem",
									layout_settings = SplashScreenSettings.items.expandable_popup_checkbox
								},
								{
									text = "close",
									on_select = "cb_item_selected",
									callback_object = "page",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"close"
									},
									layout_settings = MainMenuSettings.items.popup_button
								},
								{
									type = "EmptyMenuItem",
									layout_settings = MainMenuSettings.items.empty
								}
							}
						}
					}
				},
				{
					id = "splash_screen_start",
					type = "EmptyMenuItem",
					page = {
						on_continue_input = "cb_goto_next_splash_screen",
						z = 200,
						no_cancel_to_parent_page = true,
						type = "SplashScreenMenuPage",
						layout_settings = SplashScreenSettings.pages.splash_screen,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									on_video_end = "cb_goto_next_splash_screen",
									disabled = true,
									type = "VideoMenuItem",
									layout_settings = SplashScreenSettings.items.paradox_splash,
									page = {
										on_continue_input = "cb_goto_next_splash_screen",
										z = 200,
										no_cancel_to_parent_page = true,
										type = "SplashScreenMenuPage",
										layout_settings = SplashScreenSettings.pages.splash_screen,
										sounds = MenuSettings.sounds.default,
										item_groups = {
											item_list = {
												{
													on_video_end = "cb_goto_next_splash_screen",
													disabled = true,
													type = "VideoMenuItem",
													layout_settings = SplashScreenSettings.items.fatshark_splash,
													page = {
														on_continue_input = "cb_goto_next_splash_screen",
														z = 200,
														no_cancel_to_parent_page = true,
														type = "SplashScreenMenuPage",
														layout_settings = SplashScreenSettings.pages.splash_screen,
														sounds = MenuSettings.sounds.default,
														item_groups = {
															item_list = {
																{
																	on_video_end = "cb_goto_next_splash_screen",
																	disabled = true,
																	type = "BitsquidSplashMenuItem",
																	layout_settings = SplashScreenSettings.items.bitsquid_splash,
																	page = {
																		on_continue_input = "cb_goto_main_menu",
																		z = 200,
																		no_cancel_to_parent_page = true,
																		type = "SplashScreenMenuPage",
																		layout_settings = SplashScreenSettings.pages.splash_screen,
																		sounds = MenuSettings.sounds.default,
																		item_groups = {
																			item_list = {
																				{
																					on_video_end = "cb_goto_main_menu",
																					disabled = true,
																					type = "VideoMenuItem",
																					layout_settings = SplashScreenSettings.items.physx_splash
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
