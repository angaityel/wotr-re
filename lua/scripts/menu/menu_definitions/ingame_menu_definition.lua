-- chunkname: @scripts/menu/menu_definitions/ingame_menu_definition.lua

require("scripts/menu/menu_definitions/key_mapping_page_definition")
require("scripts/menu/menu_definitions/squad_menu_settings_1920")
require("scripts/menu/menu_definitions/squad_menu_settings_1366")
require("scripts/menu/menu_definitions/final_scoreboard_menu_settings_1920")
require("scripts/menu/menu_definitions/final_scoreboard_menu_settings_1366")

IngameMenuSettings = IngameMenuSettings or {}
IngameMenuSettings.items = IngameMenuSettings.items or {}
IngameMenuSettings.pages = IngameMenuSettings.pages or {}
IngameMenuSettingsItems = {
	{
		text = "menu_settings",
		disabled = true,
		type = "TextMenuItem",
		layout_settings = MainMenuSettings.items.header_text_right_aligned
	},
	{
		text = "menu_audio_settings",
		type = "TextMenuItem",
		layout_settings = MainMenuSettings.items.text_right_aligned,
		page = {
			z = 100,
			header_text = "menu_audio_settings",
			type = "Level3MenuPage",
			layout_settings = MainMenuSettings.pages.level_3,
			sounds = MenuSettings.sounds.default,
			item_groups = {
				item_list = {
					{
						text = "menu_audio_settings",
						disabled = true,
						type = "TextMenuItem",
						layout_settings = MainMenuSettings.items.header_text_right_aligned
					},
					{
						text = "menu_master_volume",
						on_init_options = "cb_master_volumes",
						on_option_changed = "cb_master_volume_changed",
						type = "EnumMenuItem",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_music_volume",
						on_init_options = "cb_music_volumes",
						on_option_changed = "cb_music_volume_changed",
						type = "EnumMenuItem",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_sfx_volume",
						on_init_options = "cb_sfx_volumes",
						on_option_changed = "cb_sfx_volume_changed",
						type = "EnumMenuItem",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_voice_over_volume",
						on_init_options = "cb_voice_over_volumes",
						on_option_changed = "cb_voice_over_volume_changed",
						type = "EnumMenuItem",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_voice_over",
						on_init_options = "cb_voice_overs",
						on_option_changed = "cb_voice_over_changed",
						type = "EnumMenuItem",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						disabled = true,
						type = "TextureMenuItem",
						layout_settings = MainMenuSettings.items.delimiter_texture
					},
					{
						text = "main_menu_cancel",
						callback_object = "page",
						on_select = "cb_cancel",
						type = "TextMenuItem",
						layout_settings = MainMenuSettings.items.text_right_aligned
					}
				}
			}
		}
	},
	{
		text = "menu_video_settings",
		type = "TextMenuItem",
		layout_settings = MainMenuSettings.items.text_right_aligned,
		page = {
			z = 100,
			header_text = "menu_video_settings",
			type = "VideoSettingsMenuPage",
			layout_settings = MainMenuSettings.pages.level_3_video_settings,
			sounds = MenuSettings.sounds.default,
			item_groups = {
				item_list = {
					{
						text = "menu_video_settings",
						disabled = true,
						type = "TextMenuItem",
						layout_settings = MainMenuSettings.items.header_text_right_aligned
					},
					{
						callback_object = "page",
						name = "screen_resolution",
						on_enter_text = "cb_resolution_drop_down_list_text",
						type = "DropDownListMenuItem",
						layout_settings = MainMenuSettings.items.ddl_closed_text_right_aligned,
						page = {
							on_enter_options = "cb_resolution_options",
							z = 150,
							type = "DropDownListMenuPage",
							on_option_changed = "cb_resolution_option_changed",
							render_parent_page = true,
							callback_object = "parent_page",
							layout_settings = MainMenuSettings.pages.ddl_right_aligned,
							sounds = MenuSettings.sounds.default,
							item_groups = {
								scroll_bar = {
									{
										callback_object = "page",
										on_select_down = "cb_scroll_bar_select_down",
										disabled_func = "cb_scroll_bar_disabled",
										type = "ScrollBarMenuItem",
										layout_settings = MainMenuSettings.items.drop_down_list_scroll_bar
									}
								}
							}
						}
					},
					{
						text = "menu_gamma",
						on_enter_options = "cb_gamma_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_gamma_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_fullscreen",
						on_enter_options = "cb_fullscreen_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_fullscreen_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_fullscreen_output",
						on_enter_options = "cb_fullscreen_output_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_fullscreen_output_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_vertical_sync",
						on_enter_options = "cb_vertical_sync_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_vertical_sync_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_max_fps",
						on_enter_options = "cb_max_fps_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_max_fps_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_max_stacking_frames",
						on_enter_options = "cb_max_stacking_frames_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_max_stacking_frames_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_graphics_quality",
						name = "graphics_quality",
						on_enter_options = "cb_graphics_quality_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_graphics_quality_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						disabled = true,
						type = "TextureMenuItem",
						layout_settings = MainMenuSettings.items.delimiter_texture
					},
					{
						text = "menu_shadow_quality",
						on_enter_options = "cb_shadow_quality_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_shadow_quality_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_light_casts_shadows",
						on_enter_options = "cb_light_casts_shadows_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_light_casts_shadows_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_texture_quality_characters",
						on_enter_options = "cb_texture_quality_characters_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_texture_quality_characters_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_texture_quality_environment",
						on_enter_options = "cb_texture_quality_environment_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_texture_quality_environment_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_texture_quality_coat_of_arms",
						on_enter_options = "cb_texture_quality_coat_of_arms_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_texture_quality_coat_of_arms_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_anti_aliasing",
						on_enter_options = "cb_anti_aliasing_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_anti_aliasing_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_ssao",
						on_enter_options = "cb_ssao_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_ssao_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_lod",
						on_enter_options = "cb_lod_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_lod_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_landscape_decoration",
						on_enter_options = "cb_landscape_decoration_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_landscape_decoration_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_scatter",
						on_enter_options = "cb_scatter_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_scatter_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_particles_quality",
						on_enter_options = "cb_particles_quality_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_particles_quality_option_changed",
						callback_object = "page",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						disabled = true,
						type = "TextureMenuItem",
						layout_settings = MainMenuSettings.items.delimiter_texture
					},
					{
						text = "menu_apply_settings",
						callback_object = "page",
						disabled_func = "cb_apply_changes_disabled",
						type = "TextMenuItem",
						on_select = "cb_apply_changes",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "main_menu_cancel",
						callback_object = "page",
						on_select = "cb_cancel",
						type = "TextMenuItem",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						name = "unapplied_changes_popup",
						type = "EmptyMenuItem",
						layout_settings = MainMenuSettings.items.empty,
						page = {
							callback_object = "parent_page",
							z = 200,
							on_item_selected = "cb_unapplied_changes_popup_item_selected",
							type = "PopupMenuPage",
							layout_settings = MainMenuSettings.pages.text_input_popup,
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
										text = "unapplied_video_changes",
										disabled = true,
										type = "TextBoxMenuItem",
										layout_settings = MainMenuSettings.items.popup_textbox
									}
								},
								button_list = {
									{
										text = "apply",
										on_select = "cb_item_selected",
										callback_object = "page",
										type = "TextureButtonMenuItem",
										on_select_args = {
											"close",
											"apply_changes"
										},
										layout_settings = MainMenuSettings.items.popup_button
									},
									{
										text = "discard",
										on_select = "cb_item_selected",
										callback_object = "page",
										type = "TextureButtonMenuItem",
										on_select_args = {
											"close",
											"discard_changes"
										},
										layout_settings = MainMenuSettings.items.popup_button
									}
								}
							}
						}
					},
					{
						name = "keep_changes_popup",
						type = "EmptyMenuItem",
						layout_settings = MainMenuSettings.items.empty,
						page = {
							z = 200,
							no_cancel_to_parent_page = true,
							type = "PopupMenuPage",
							on_item_selected = "cb_keep_changes_popup_item_selected",
							callback_object = "parent_page",
							layout_settings = MainMenuSettings.pages.text_input_popup,
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
										text = "keep_video_changes",
										disabled = true,
										type = "TextBoxMenuItem",
										layout_settings = MainMenuSettings.items.popup_textbox
									}
								},
								button_list = {
									{
										text = "keep",
										on_select = "cb_item_selected",
										callback_object = "page",
										type = "TextureButtonMenuItem",
										on_select_args = {
											"close",
											"keep_changes"
										},
										layout_settings = MainMenuSettings.items.popup_button
									},
									{
										on_countdown_done = "cb_item_selected",
										on_select = "cb_item_selected",
										text = "revert",
										type = "TextureButtonCountdownMenuItem",
										countdown_time = 10,
										callback_object = "page",
										on_countdown_done_args = {
											"close",
											"revert_changes"
										},
										on_select_args = {
											"close",
											"revert_changes"
										},
										layout_settings = MainMenuSettings.items.popup_button
									}
								}
							}
						}
					},
					{
						name = "changes_need_restart_popup",
						type = "EmptyMenuItem",
						layout_settings = MainMenuSettings.items.empty,
						page = {
							z = 200,
							no_cancel_to_parent_page = true,
							type = "PopupMenuPage",
							on_item_selected = "cb_restart_popup_item_selected",
							callback_object = "parent_page",
							layout_settings = MainMenuSettings.pages.text_input_popup,
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
										text = "changes_need_restart_ingame_menu",
										disabled = true,
										type = "TextBoxMenuItem",
										layout_settings = MainMenuSettings.items.popup_textbox
									}
								},
								button_list = {
									{
										text = "close",
										on_select = "cb_item_selected",
										callback_object = "page",
										type = "TextureButtonMenuItem",
										on_select_args = {
											"close"
										},
										layout_settings = MainMenuSettings.items.popup_button
									}
								}
							}
						}
					}
				}
			}
		}
	},
	{
		text = "menu_control_settings",
		type = "TextMenuItem",
		layout_settings = MainMenuSettings.items.text_right_aligned,
		page = {
			static_tooltip_callback = "cb_controller_help_func",
			z = 100,
			header_text = "menu_control_settings",
			type = "Level3MenuPage",
			layout_settings = MainMenuSettings.pages.level_3,
			sounds = MenuSettings.sounds.default,
			item_groups = {
				item_list = {
					{
						text = "menu_control_settings",
						disabled = true,
						type = "TextMenuItem",
						layout_settings = MainMenuSettings.items.header_text_right_aligned
					},
					KeyMappingPageDefinition.ingame_menu_definition,
					{
						text = "menu_look_invert",
						on_init_options = "cb_look_invert_options",
						on_option_changed = "cb_look_invert_changed",
						type = "EnumMenuItem",
						remove_func = "cb_controller_enabled",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_look_invert_pad360",
						on_init_options = "cb_look_invert_options_pad360",
						on_option_changed = "cb_look_invert_changed_pad360",
						type = "EnumMenuItem",
						remove_func = "cb_controller_disabled",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_mouse_sensitivity",
						on_init_options = "cb_mouse_sensitivity_options",
						on_option_changed = "cb_mouse_sensitivity_option_changed",
						type = "EnumMenuItem",
						remove_func = "cb_controller_enabled",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_pad360_sensitivity_x",
						on_init_options = "cb_pad_sensitivity_x_options",
						on_option_changed = "cb_pad_sensitivity_x_option_changed",
						type = "EnumMenuItem",
						remove_func = "cb_controller_disabled",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_pad360_sensitivity_y",
						on_init_options = "cb_pad_sensitivity_y_options",
						on_option_changed = "cb_pad_sensitivity_y_option_changed",
						type = "EnumMenuItem",
						remove_func = "cb_controller_disabled",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_keyboard_parry",
						on_init_options = "cb_keyboard_parry_options",
						on_option_changed = "cb_keyboard_parry_option_changed",
						type = "EnumMenuItem",
						remove_func = "cb_controller_enabled",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_keyboard_pose",
						on_init_options = "cb_keyboard_pose_options",
						on_option_changed = "cb_keyboard_pose_option_changed",
						type = "EnumMenuItem",
						remove_func = "cb_controller_enabled",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_invert_swing_control_x",
						on_init_options = "cb_invert_pose_control_x_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_invert_pose_control_x_option_changed",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_invert_swing_control_y",
						on_init_options = "cb_invert_pose_control_y_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_invert_pose_control_y_option_changed",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_invert_parry_control_x",
						on_init_options = "cb_invert_parry_control_x_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_invert_parry_control_x_option_changed",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						text = "menu_invert_parry_control_y",
						on_init_options = "cb_invert_parry_control_y_options",
						type = "EnumMenuItem",
						on_option_changed = "cb_invert_parry_control_y_option_changed",
						callback_object = "MainMenuCallbacks",
						layout_settings = MainMenuSettings.items.text_right_aligned
					},
					{
						disabled = true,
						type = "TextureMenuItem",
						layout_settings = MainMenuSettings.items.delimiter_texture
					},
					{
						text = "main_menu_cancel",
						callback_object = "page",
						on_select = "cb_cancel",
						type = "TextMenuItem",
						layout_settings = MainMenuSettings.items.text_right_aligned
					}
				}
			}
		}
	},
	{
		disabled = true,
		type = "TextureMenuItem",
		layout_settings = MainMenuSettings.items.delimiter_texture
	},
	{
		text = "main_menu_cancel",
		callback_object = "page",
		on_select = "cb_cancel",
		type = "TextMenuItem",
		layout_settings = MainMenuSettings.items.text_right_aligned
	}
}
LeaveBattlePopupPage = {
	z = 200,
	on_item_selected = "cb_leave_game_popup_item_selected",
	type = "PopupMenuPage",
	layout_settings = MainMenuSettings.pages.text_input_popup,
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
				text = "menu_popup_confirm_leave_battle",
				disabled = true,
				type = "TextMenuItem",
				layout_settings = MainMenuSettings.items.popup_text
			}
		},
		button_list = {
			{
				text = "menu_yes",
				on_select = "cb_item_selected",
				callback_object = "page",
				type = "TextureButtonMenuItem",
				on_select_args = {
					"close",
					"leave_game"
				},
				layout_settings = MainMenuSettings.items.popup_button
			},
			{
				text = "menu_no",
				on_select = "cb_item_selected",
				callback_object = "page",
				type = "TextureButtonMenuItem",
				on_select_args = {
					"close",
					"cancel"
				},
				layout_settings = MainMenuSettings.items.popup_button
			}
		}
	}
}
IngameMenuDefinition = {
	page = {
		id = "root",
		z = 1,
		type = "Level1MenuPage",
		layout_settings = MainMenuSettings.pages.level_1,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			item_list = {
				{
					id = "outfit_editor",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty,
					page = {
						on_enter_highlight_item = "cb_outfit_editor_highlight_item",
						z = 50,
						no_cancel_to_parent_page = true,
						type = "OutfitEditorProfileMenuPage",
						on_cancel_exit = "cb_deactivate_outfit_editor",
						on_cancel_exit_callback_object = "page",
						camera = "character_editor",
						layout_settings = SquadMenuSettings.pages.level_2_character_profiles,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {},
							xp_progress_bar = {
								{
									text = "",
									name = "coins",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									callback_object = "page",
									layout_settings = MainMenuSettings.items.money_text
								},
								{
									text = "menu_progress_xp",
									name = "xp_progress_bar",
									disabled = true,
									type = "ProgressBarMenuItem",
									callback_object = "page",
									layout_settings = MainMenuSettings.items.xp_progress_bar
								}
							},
							center_items = {
								{
									text = "main_menu_edit_profiles",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.battle_result
								}
							},
							page_links = {
								{
									text = "menu_select_team",
									name = "goto_select_team_button",
									disabled_func = "cb_goto_select_team_disabled",
									type = "TextureButtonMenuItem",
									on_select = "cb_goto",
									on_select_args = {
										"select_team"
									},
									layout_settings = SquadMenuSettings.items.next_button
								}
							},
							back_list = {
								{
									text = "menu_ingame_leave_battle_lower",
									type = "TextureButtonMenuItem",
									layout_settings = SquadMenuSettings.items.centered_button,
									page = LeaveBattlePopupPage
								}
							}
						}
					}
				},
				{
					id = "select_team",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty,
					page = {
						on_enter_highlight_item = "cb_team_selection_highlight_item",
						z = 50,
						no_cancel_to_parent_page = true,
						type = "TeamSelectionMenuPage",
						do_not_select_first_index = true,
						layout_settings = SquadMenuSettings.pages.select_team,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							center_items = {
								{
									text = "menu_choose_your_king",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.battle_result
								},
								{
									relative_height = 0.03,
									type = "EmptyMenuItem",
									layout_settings = MainMenuSettings.items.empty
								},
								{
									disabled = true,
									name = "quote_text",
									on_enter_text = "cb_quote_text",
									type = "TextBoxMenuItem",
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.quote_text
								}
							},
							left_team_items = {
								{
									disabled_func_args = "red",
									name = "red_team_rose",
									disabled_func = "cb_join_team_selection_disabled",
									type = "TextureMenuItem",
									callback_object = "page",
									on_select = "cb_join_team_selected",
									on_select_args = {
										"red"
									},
									layout_settings = SquadMenuSettings.items.red_team_rose
								},
								{
									text = "lancaster_upper",
									name = "red_team_text",
									disabled = true,
									type = "TextMenuItem",
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.red_team_text
								},
								{
									text = "",
									name = "red_num_members",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = SquadMenuSettings.items.red_team_num_players
								}
							},
							right_team_items = {
								{
									disabled_func_args = "white",
									name = "white_team_rose",
									disabled_func = "cb_join_team_selection_disabled",
									type = "TextureMenuItem",
									callback_object = "page",
									on_select = "cb_join_team_selected",
									on_select_args = {
										"white"
									},
									layout_settings = SquadMenuSettings.items.white_team_rose
								},
								{
									text = "york_upper",
									name = "white_team_text",
									disabled = true,
									type = "TextMenuItem",
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.white_team_text
								},
								{
									text = "",
									name = "white_num_members",
									disabled = true,
									type = "TextMenuItem",
									no_localization = true,
									layout_settings = SquadMenuSettings.items.white_team_num_players
								}
							},
							page_links = {
								{
									text = "main_menu_edit_profiles_lower",
									on_select = "cb_goto",
									disabled_func = "cb_goto_outfit_editor_disabled",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"outfit_editor"
									},
									layout_settings = SquadMenuSettings.items.previous_button
								},
								{
									text = "menu_auto_join_team",
									name = "auto_join_team_button",
									disabled_func = "cb_auto_join_team_disabled",
									type = "TextureButtonMenuItem",
									on_select = "cb_auto_join_team",
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.next_button
								}
							},
							back_list = {
								{
									text = "menu_ingame_leave_battle_lower",
									type = "TextureButtonMenuItem",
									layout_settings = SquadMenuSettings.items.centered_button,
									page = LeaveBattlePopupPage
								},
								{
									text = "main_menu_edit_profiles_lower",
									on_select = "cb_goto",
									disabled_func = "cb_goto_outfit_editor_disabled",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"outfit_editor"
									},
									layout_settings = SquadMenuSettings.items.centered_button
								}
							}
						}
					}
				},
				{
					id = "select_profile",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty,
					page = {
						on_enter_highlight_item = "cb_character_profile_highlight_item",
						z = 50,
						no_cancel_to_parent_page = true,
						type = "SelectCharacterMenuPage",
						on_cancel_input = "cb_select_character_cancelled",
						camera = "character_editor",
						on_enter_selected_option = "cb_character_profile_selected_option",
						on_init_options = "cb_character_profiles_options",
						on_option_changed = "cb_character_profiles_option_changed",
						layout_settings = SquadMenuSettings.pages.select_character,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {},
							center_items = {
								{
									text = "menu_select_character",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.battle_result
								}
							},
							page_links = {
								{
									remove_func = "cb_controller_enabled",
									text = "menu_select_team",
									on_select = "cb_goto",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"select_team"
									},
									layout_settings = SquadMenuSettings.items.previous_button
								},
								{
									text = "menu_select_spawnpoint_lower",
									name = "select_spawnpoint_button",
									disabled_func = "cb_goto_select_spawnpoint_disabled",
									type = "TextureButtonMenuItem",
									remove_func = "cb_controller_enabled",
									on_select = "cb_goto",
									on_select_args = {
										"select_spawnpoint"
									},
									layout_settings = SquadMenuSettings.items.next_button
								}
							},
							back_list = {
								{
									remove_func = "cb_controller_enabled",
									callback_object = "page",
									text = "menu_ingame_leave_battle_lower",
									type = "TextureButtonMenuItem",
									layout_settings = SquadMenuSettings.items.centered_button,
									page = LeaveBattlePopupPage
								},
								{
									text = "main_menu_edit_profiles_lower",
									on_select = "cb_goto",
									disabled_func = "cb_goto_outfit_editor_disabled",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"outfit_editor"
									},
									layout_settings = SquadMenuSettings.items.centered_button
								}
							}
						}
					}
				},
				{
					id = "select_spawnpoint",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty,
					page = {
						on_enter_highlight_item = "cb_select_spawnpoint_highlight_item",
						on_cancel_input_args = "pre_spawn_ingame_menu",
						type_override = "pre_spawn_select_spawnpoint",
						type = "SelectSpawnpointMenuPage",
						on_cancel_input = "cb_goto",
						no_cancel_to_parent_page = true,
						z = 50,
						layout_settings = SquadMenuSettings.pages.select_spawnpoint,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {},
							center_items = {
								{
									text = "menu_select_spawnpoint",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.battle_result
								}
							},
							squad_header = {
								{
									text = "menu_select_squad",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = SquadMenuSettings.items.squad_header
								}
							},
							squad_info = {
								{
									text = "menu_squad_1",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 1,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_2",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 2,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_3",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 3,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_4",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 4,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_5",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 5,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_6",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 6,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_7",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 7,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_8",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 8,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								}
							},
							squad_button = {
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 1,
									on_select = "cb_join_squad",
									disabled_func_args = 1,
									callback_object = "page",
									on_select_args = {
										1
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 2,
									on_select = "cb_join_squad",
									disabled_func_args = 2,
									callback_object = "page",
									on_select_args = {
										2
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 3,
									on_select = "cb_join_squad",
									disabled_func_args = 3,
									callback_object = "page",
									on_select_args = {
										3
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 4,
									on_select = "cb_join_squad",
									disabled_func_args = 4,
									callback_object = "page",
									on_select_args = {
										4
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 5,
									on_select = "cb_join_squad",
									disabled_func_args = 5,
									callback_object = "page",
									on_select_args = {
										5
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 6,
									on_select = "cb_join_squad",
									disabled_func_args = 6,
									callback_object = "page",
									on_select_args = {
										6
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 7,
									on_select = "cb_join_squad",
									disabled_func_args = 7,
									callback_object = "page",
									on_select_args = {
										7
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 8,
									on_select = "cb_join_squad",
									disabled_func_args = 8,
									callback_object = "page",
									on_select_args = {
										8
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								}
							},
							page_links = {
								{
									remove_func = "cb_controller_enabled",
									text = "menu_switch_character_lower",
									on_select = "cb_goto",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"select_profile"
									},
									layout_settings = SquadMenuSettings.items.previous_button
								},
								{
									text = "menu_spawn",
									name = "spawn_button",
									disabled_func = "cb_request_spawn_disabled",
									type = "TextureButtonMenuItem",
									remove_func = "cb_controller_enabled",
									on_select = "cb_request_spawn_target",
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.next_button
								}
							},
							back_list = {
								{
									remove_func = "cb_controller_enabled",
									text = "menu_ingame_leave_battle_lower",
									type = "TextureButtonMenuItem",
									layout_settings = SquadMenuSettings.items.centered_button,
									page = LeaveBattlePopupPage
								},
								{
									text = "main_menu_edit_profiles_lower",
									on_select = "cb_goto",
									disabled_func = "cb_goto_outfit_editor_disabled",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"outfit_editor"
									},
									layout_settings = SquadMenuSettings.items.centered_button
								}
							}
						}
					}
				},
				{
					id = "pre_spawn_ingame_menu",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty,
					page = {
						on_cancel_input = "cb_goto",
						on_cancel_input_args = "select_spawnpoint",
						no_cancel_to_parent_page = true,
						type = "Level1MenuPage",
						on_enter_highlight_item = "cb_pre_spawn_ingame_menu_highlight_item",
						z = 50,
						layout_settings = MainMenuSettings.pages.level_1,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									text = "menu_select_spawnpoint",
									name = "back_to_select_spawnpoint",
									on_select = "cb_goto",
									type = "TextMenuItem",
									on_select_args = {
										"select_spawnpoint"
									},
									layout_settings = table.clone(SquadMenuSettings.items.pulse_text_right_aligned)
								},
								{
									text = "menu_settings",
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.text_right_aligned,
									page = {
										z = 50,
										header_text = "menu_settings",
										type = "Level3MenuPage",
										layout_settings = MainMenuSettings.pages.level_3,
										sounds = MenuSettings.sounds.default,
										item_groups = {
											item_list = IngameMenuSettingsItems
										}
									}
								},
								{
									text = "menu_ingame_leave_battle",
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.text_right_aligned,
									page = {
										z = 100,
										type = "Level2MenuPage",
										layout_settings = MainMenuSettings.pages.level_2,
										sounds = MenuSettings.sounds.default,
										item_groups = {
											item_list = {
												{
													text = "menu_confirm_leave_battle",
													disabled = true,
													type = "TextMenuItem",
													layout_settings = MainMenuSettings.items.header_text_right_aligned
												},
												{
													text = "main_menu_yes",
													on_select = "cb_leave_game",
													type = "TextMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "main_menu_no",
													callback_object = "page",
													on_select = "cb_cancel",
													type = "TextMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												}
											}
										}
									}
								}
							}
						}
					}
				},
				{
					id = "select_spawnpoint_ingame",
					visible_func = "cb_ingame_select_spawnpoint_visible",
					text = "menu_select_spawnpoint",
					type = "TextMenuItem",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						z = 50,
						type = "SelectSpawnpointMenuPage",
						layout_settings = SquadMenuSettings.pages.select_spawnpoint,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							center_items = {
								{
									text = "menu_select_spawnpoint",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.battle_result
								}
							},
							item_list = {},
							squad_header = {
								{
									text = "menu_select_squad",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = SquadMenuSettings.items.squad_header
								}
							},
							squad_info = {
								{
									text = "menu_squad_1",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 1,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_2",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 2,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_3",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 3,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_4",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 4,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_5",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 5,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_6",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 6,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_7",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 7,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								},
								{
									text = "menu_squad_8",
									visible_func = "cb_squad_text_visible",
									disabled = true,
									type = "SquadTextMenuItem",
									visible_func_args = 8,
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.squad_info_text
								}
							},
							squad_button = {
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 1,
									on_select = "cb_join_squad",
									disabled_func_args = 1,
									callback_object = "page",
									on_select_args = {
										1
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 2,
									on_select = "cb_join_squad",
									disabled_func_args = 2,
									callback_object = "page",
									on_select_args = {
										2
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 3,
									on_select = "cb_join_squad",
									disabled_func_args = 3,
									callback_object = "page",
									on_select_args = {
										3
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 4,
									on_select = "cb_join_squad",
									disabled_func_args = 4,
									callback_object = "page",
									on_select_args = {
										4
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 5,
									on_select = "cb_join_squad",
									disabled_func_args = 5,
									callback_object = "page",
									on_select_args = {
										5
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 6,
									on_select = "cb_join_squad",
									disabled_func_args = 6,
									callback_object = "page",
									on_select_args = {
										6
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 7,
									on_select = "cb_join_squad",
									disabled_func_args = 7,
									callback_object = "page",
									on_select_args = {
										7
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								},
								{
									text = "menu_join",
									visible_func = "cb_squad_button_visible",
									disabled_func = "cb_squad_button_disabled",
									type = "TextureButtonMenuItem",
									visible_func_args = 8,
									on_select = "cb_join_squad",
									disabled_func_args = 8,
									callback_object = "page",
									on_select_args = {
										8
									},
									layout_settings = SquadMenuSettings.items.squad_join_button
								}
							},
							page_links = {
								{
									remove_func = "cb_controller_enabled",
									text = "menu_switch_character_lower",
									on_select = "cb_goto",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"select_profile_ingame"
									},
									layout_settings = SquadMenuSettings.items.previous_button
								},
								{
									text = "menu_ingame_return_to_battle_lower",
									name = "spawn_button",
									disabled_func = "cb_request_spawn_disabled",
									type = "TextureButtonMenuItem",
									remove_func = "cb_controller_enabled",
									on_select = "cb_request_spawn_target",
									callback_object = "page",
									layout_settings = SquadMenuSettings.items.next_button
								}
							},
							back_list = {
								{
									remove_func = "cb_controller_enabled",
									text = "menu_ingame_leave_battle_lower",
									type = "TextureButtonMenuItem",
									layout_settings = SquadMenuSettings.items.centered_button,
									page = LeaveBattlePopupPage
								},
								{
									text = "main_menu_edit_profiles_lower",
									on_select = "cb_goto",
									disabled_func = "cb_goto_outfit_editor_disabled",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"outfit_editor"
									},
									layout_settings = SquadMenuSettings.items.centered_button
								}
							}
						}
					}
				},
				{
					id = "select_profile_ingame",
					type = "EmptyMenuItem",
					layout_settings = MainMenuSettings.items.empty,
					page = {
						on_enter_selected_option = "cb_character_profile_selected_option",
						z = 50,
						no_cancel_to_parent_page = true,
						type = "SelectCharacterMenuPage",
						on_option_changed = "cb_character_profiles_option_changed",
						on_init_options = "cb_character_profiles_options",
						on_cancel_input = "cb_select_character_ingame_cancelled",
						camera = "character_editor",
						layout_settings = SquadMenuSettings.pages.select_character,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							center_items = {
								{
									text = "menu_select_character",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = FinalScoreboardMenuSettings.items.battle_result
								}
							},
							item_list = {},
							page_links = {
								{
									text = "menu_select_spawnpoint_lower",
									name = "select_spawnpoint_button_ingame",
									on_select = "cb_goto",
									type = "TextureButtonMenuItem",
									on_select_args = {
										"select_spawnpoint_ingame"
									},
									layout_settings = SquadMenuSettings.items.next_button
								}
							},
							back_list = {
								{
									text = "menu_ingame_leave_battle_lower",
									type = "TextureButtonMenuItem",
									layout_settings = SquadMenuSettings.items.centered_button,
									page = LeaveBattlePopupPage
								}
							}
						}
					}
				},
				{
					text = "menu_settings",
					type = "TextMenuItem",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						z = 50,
						header_text = "menu_settings",
						type = "Level2MenuPage",
						layout_settings = MainMenuSettings.pages.level_2,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = IngameMenuSettingsItems
						}
					}
				},
				{
					text = "menu_ingame_leave_battle",
					type = "TextMenuItem",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						z = 100,
						type = "Level2MenuPage",
						layout_settings = MainMenuSettings.pages.level_2,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									text = "menu_confirm_leave_battle",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.header_text_right_aligned
								},
								{
									text = "main_menu_yes",
									on_select = "cb_leave_game",
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.text_right_aligned
								},
								{
									text = "main_menu_no",
									callback_object = "page",
									on_select = "cb_cancel",
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.text_right_aligned
								}
							}
						}
					}
				},
				{
					disabled = true,
					type = "TextureMenuItem",
					layout_settings = MainMenuSettings.items.delimiter_texture
				},
				{
					text = "menu_ingame_return_to_battle",
					on_select = "cb_return_to_battle",
					type = "TextMenuItem",
					layout_settings = MainMenuSettings.items.text_right_aligned
				}
			}
		}
	}
}
