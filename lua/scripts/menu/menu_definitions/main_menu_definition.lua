-- chunkname: @scripts/menu/menu_definitions/main_menu_definition.lua

require("scripts/settings/menu_settings")
require("scripts/settings/coat_of_arms")
require("gui/textures/loading_atlas")

FieldColorItems = {}

for i, config in ipairs(CoatOfArms.field_colors) do
	FieldColorItems[i] = {
		callback_object = "page",
		on_select = "cb_field_color_selected",
		type = "CoatOfArmsColorPickerMenuItem",
		on_select_args = {
			config.name
		},
		color = config.menu_color,
		color_2 = config.menu_color_2,
		layout_settings = MainMenuSettings.items.color_picker
	}
end

DivisionColorItems = {}

for i, config in ipairs(CoatOfArms.division_colors) do
	DivisionColorItems[i] = {
		callback_object = "page",
		on_select = "cb_division_color_selected",
		type = "CoatOfArmsColorPickerMenuItem",
		on_select_args = {
			config.name
		},
		color = config.menu_color,
		color_2 = config.menu_color_2,
		layout_settings = MainMenuSettings.items.color_picker
	}
end

FieldVariationColorItems = {}

for i, config in ipairs(CoatOfArms.material_variation_colors) do
	FieldVariationColorItems[i] = {
		callback_object = "page",
		on_select = "cb_field_variation_color_selected",
		type = "CoatOfArmsColorPickerMenuItem",
		on_select_args = {
			config.name
		},
		color = config.menu_color,
		color_2 = config.menu_color_2,
		layout_settings = MainMenuSettings.items.color_picker
	}
end

FieldVariationTypeItems = {}

for i, config in ipairs(CoatOfArms.material_variation_types) do
	FieldVariationTypeItems[i] = {
		callback_object = "page",
		on_select = "cb_field_variation_type_selected",
		type = "CoatOfArmsMenuItem",
		on_select_args = {
			config.name
		},
		layout_settings = MainMenuSettings.items["field_variation_type_picker_" .. config.name]
	}
end

DivisionVariationColorItems = {}

for i, config in ipairs(CoatOfArms.material_variation_colors) do
	DivisionVariationColorItems[i] = {
		callback_object = "page",
		on_select = "cb_division_variation_color_selected",
		type = "CoatOfArmsColorPickerMenuItem",
		on_select_args = {
			config.name
		},
		color = config.menu_color,
		color_2 = config.menu_color_2,
		layout_settings = MainMenuSettings.items.color_picker
	}
end

DivisionVariationTypeItems = {}

for i, config in ipairs(CoatOfArms.material_variation_types) do
	DivisionVariationTypeItems[i] = {
		callback_object = "page",
		on_select = "cb_division_variation_type_selected",
		type = "CoatOfArmsMenuItem",
		on_select_args = {
			config.name
		},
		layout_settings = MainMenuSettings.items["division_variation_type_picker_" .. config.name]
	}
end

DivisionTypeItems = {}

for i, config in ipairs(CoatOfArms.division_types) do
	DivisionTypeItems[i] = {
		callback_object = "page",
		on_select = "cb_division_type_selected",
		type = "CoatOfArmsMenuItem",
		on_select_args = {
			config.name
		},
		layout_settings = MainMenuSettings.items["division_type_picker_" .. config.name]
	}
end

OrdinaryColorItems = {}

for i, config in ipairs(CoatOfArms.ordinary_colors) do
	OrdinaryColorItems[i] = {
		callback_object = "page",
		on_select = "cb_ordinary_color_selected",
		type = "CoatOfArmsColorPickerMenuItem",
		on_select_args = {
			config.name
		},
		color = config.menu_color,
		color_2 = config.menu_color_2,
		layout_settings = MainMenuSettings.items.color_picker
	}
end

OrdinaryTypeItems = {}

for i, config in ipairs(CoatOfArms.ordinary_types) do
	OrdinaryTypeItems[i] = {
		callback_object = "page",
		on_select = "cb_ordinary_type_selected",
		type = "CoatOfArmsMenuItem",
		on_select_args = {
			config.name
		},
		layout_settings = MainMenuSettings.items["ordinary_type_picker_" .. config.name]
	}
end

ChargeColorItems = {}

for i, config in ipairs(CoatOfArms.charge_colors) do
	ChargeColorItems[i] = {
		callback_object = "page",
		on_select = "cb_charge_color_selected",
		type = "CoatOfArmsColorPickerMenuItem",
		on_select_args = {
			config.name
		},
		color = config.menu_color,
		color_2 = config.menu_color_2,
		layout_settings = MainMenuSettings.items.color_picker
	}
end

ChargeTypeItems = {}

for i, config in ipairs(CoatOfArms.charge_types) do
	ChargeTypeItems[i] = {
		callback_object = "page",
		on_select = "cb_charge_type_selected",
		type = "CoatOfArmsMenuItem",
		on_select_args = {
			config.name
		},
		layout_settings = MainMenuSettings.items["charge_type_picker_" .. config.name]
	}
end

CrestItems = {}

for i, config in ipairs(CoatOfArms.crests) do
	CrestItems[i] = {
		callback_object = "page",
		on_select = "cb_crest_selected",
		type = "CoatOfArmsMenuItem",
		on_select_args = {
			config.name
		},
		layout_settings = MainMenuSettings.items["crest_picker_" .. config.name]
	}
end

require("scripts/menu/menu_definitions/character_sheet_page_definition")
require("scripts/menu/menu_definitions/server_browser_page_definition")
require("scripts/menu/menu_definitions/server_browser_page_settings_1920")
require("scripts/menu/menu_definitions/server_browser_page_settings_1366")
require("scripts/menu/menu_definitions/key_mapping_page_definition")
require("scripts/menu/menu_definitions/credits_page_definition")
require("scripts/menu/menu_definitions/credits_page_settings_1920")
require("scripts/menu/menu_definitions/credits_page_settings_1366")

if GameSettingsDevelopment.allow_host_game then
	HOST_ITEM = {
		text = "main_menu_host",
		type = "TextMenuItem",
		layout_settings = MainMenuSettings.items.text_right_aligned,
		page = {
			z = 100,
			type = "StandardMenuPage",
			layout_settings = MainMenuSettings.pages.lobby,
			sounds = MenuSettings.sounds.default,
			item_groups = {
				item_list = {
					{
						id = "lobby_host",
						disabled = true,
						type = "LobbyHostMenuItem",
						layout_settings = MainMenuSettings.items.lobby_host
					}
				}
			}
		}
	}
end

if GameSettingsDevelopment.allow_old_join_game then
	JOIN_ITEM = {
		text = "main_menu_join",
		type = "TextMenuItem",
		layout_settings = MainMenuSettings.items.text_right_aligned,
		page = {
			z = 100,
			type = "StandardMenuPage",
			layout_settings = MainMenuSettings.pages.join_lobby,
			sounds = MenuSettings.sounds.default,
			item_groups = {
				item_list = {
					{
						id = "lobby_join",
						disabled = true,
						type = "LobbyJoinMenuItem",
						layout_settings = MainMenuSettings.items.lobby_join
					}
				}
			}
		}
	}
end

if GameSettingsDevelopment.allow_host_practice then
	PRACTICE_ITEM = {
		text = "main_menu_practice",
		type = "TextMenuItem",
		layout_settings = MainMenuSettings.items.text_right_aligned,
		page = {
			z = 100,
			type = "StandardMenuPage",
			layout_settings = MainMenuSettings.pages.lobby,
			sounds = MenuSettings.sounds.default,
			item_groups = {
				item_list = {
					{
						id = "lobby_practice",
						disabled = true,
						type = "LobbyPracticeMenuItem",
						layout_settings = MainMenuSettings.items.lobby_practice
					}
				}
			}
		}
	}
end

MainMenuDefinition = {
	page = {
		environment = "default",
		z = 1,
		camera = "title_screen",
		type = "Level1MenuPage",
		layout_settings = MainMenuSettings.pages.level_1,
		sounds = MenuSettings.sounds.default,
		item_groups = {
			item_list = {
				{
					text = "main_menu_multiplayer",
					type = "TextMenuItem",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						environment = "blurred",
						z = 50,
						type = "Level2MenuPage",
						layout_settings = MainMenuSettings.pages.level_2,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									text = "main_menu_multiplayer",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.header_text_right_aligned
								},
								ServerBrowserPageDefinition,
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
								},
								JOIN_ITEM or HOST_ITEM,
								JOIN_ITEM and HOST_ITEM or nil,
								PRACTICE_ITEM
							}
						}
					}
				},
				{
					text = "main_menu_single_player_start",
					disabled_func = "cb_disable_single_player",
					demo_icon = true,
					type = "TextMenuItem",
					id = "single_player_level_select",
					callback_object = "page",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						environment = "blurred",
						z = 50,
						type = "Level2MenuPage",
						layout_settings = MainMenuSettings.pages.level_2,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									text = "main_menu_single_player_start",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.header_text_right_aligned
								},
								{
									on_enter_text = "cb_on_enter_single_player_ddl_text",
									type = "DropDownListMenuItem",
									layout_settings = MainMenuSettings.items.ddl_closed_text_right_aligned,
									page = {
										on_option_changed = "cb_single_player_ddl_option_changed",
										z = 100,
										on_enter_options = "cb_single_player_ddl_options",
										type = "DropDownListMenuPage",
										layout_settings = MainMenuSettings.pages.ddl_right_aligned_no_scroll,
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
									text = "main_menu_start_game",
									on_select = "cb_single_player_start",
									disabled_func = "cb_start_single_player_game_disabled",
									type = "TextMenuItem",
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
					text = "main_menu_edit_profiles",
					type = "TextMenuItem",
					disabled = GameSettingsDevelopment.disable_character_profiles_editor,
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						on_cancel_exit = "cb_deactivate_outfit_editor",
						environment = "profile_editor",
						z = 50,
						type = "OutfitEditorProfileMenuPage",
						on_cancel_exit_callback_object = "page",
						camera = "character_editor",
						layout_settings = MainMenuSettings.pages.level_2_character_profiles,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							back_list = {},
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
							}
						}
					}
				},
				{
					text = "menu_coat_of_arms",
					disabled_func = "cb_disable_coat_of_arms",
					demo_icon = true,
					type = "TextMenuItem",
					callback_object = "page",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						camera = "coat_of_arms",
						environment = "coat_of_arms",
						z = 50,
						type = "CoatOfArmsMenuPage",
						layout_settings = MainMenuSettings.pages.level_2_coat_of_arms,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {},
							header = {
								{
									text = "menu_coat_of_arms",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.header_text_right_aligned
								}
							},
							header_division = {
								{
									text = "menu_division",
									name = "division",
									disabled_func = "cb_controller_disabled",
									type = "DivisionTextMenuItem",
									on_select = "cb_division_selected",
									division_index = 1,
									callback_object = "page",
									on_select_args = {
										"division"
									},
									layout_settings = MainMenuSettings.items.division_header_devision_left_aligned
								}
							},
							division_field_color_picker = FieldColorItems,
							division_field_variation_type_picker = FieldVariationTypeItems,
							division_field_variation_color_picker = FieldVariationColorItems,
							division_color_picker = DivisionColorItems,
							division_variation_color_picker = DivisionVariationColorItems,
							division_variation_type_picker = DivisionVariationTypeItems,
							division_type_picker = DivisionTypeItems,
							header_ordinary = {
								{
									text = "menu_ordinary",
									name = "ordinary",
									disabled_func = "cb_controller_disabled",
									type = "DivisionTextMenuItem",
									callback_object = "page",
									division_index = 2,
									on_select = "cb_division_selected",
									on_select_args = {
										"ordinary"
									},
									layout_settings = MainMenuSettings.items.division_header_ordinary_left_aligned
								}
							},
							ordinary_color_picker = OrdinaryColorItems,
							ordinary_type_picker = OrdinaryTypeItems,
							header_charge = {
								{
									text = "menu_charge",
									name = "charge",
									disabled_func = "cb_controller_disabled",
									type = "DivisionTextMenuItem",
									callback_object = "page",
									division_index = 3,
									on_select = "cb_division_selected",
									on_select_args = {
										"charge"
									},
									layout_settings = MainMenuSettings.items.division_header_charge_left_aligned
								}
							},
							charge_color_picker = ChargeColorItems,
							charge_type_picker = ChargeTypeItems,
							charge_type_picker_scroll = {
								{
									remove_func = "cb_controller_enabled",
									callback_object = "page",
									on_select = "cb_scroll_up_charge_type_picker",
									type = "TextureMenuItem",
									layout_settings = MainMenuSettings.items.scroll_up
								},
								{
									remove_func = "cb_controller_enabled",
									callback_object = "page",
									on_select = "cb_scroll_down_charge_type_picker",
									type = "TextureMenuItem",
									layout_settings = MainMenuSettings.items.scroll_down
								},
								{
									text = "",
									disabled = true,
									type = "TextMenuItem",
									remove_func = "cb_controller_enabled",
									no_localization = true,
									callback_object = "page",
									layout_settings = MainMenuSettings.items.scroll_text
								}
							},
							header_crest = {
								{
									text = "menu_crest",
									name = "crest",
									disabled_func = "cb_controller_disabled",
									type = "DivisionTextMenuItem",
									callback_object = "page",
									division_index = 4,
									on_select = "cb_division_selected",
									on_select_args = {
										"crest"
									},
									layout_settings = MainMenuSettings.items.division_header_crest_left_aligned
								}
							},
							crest_picker = CrestItems,
							back_list = {
								{
									remove_func = "cb_controller_enabled",
									disabled = true,
									callback_object = "page",
									type = "TextureMenuItem",
									layout_settings = MainMenuSettings.items.delimiter_texture_left
								},
								{
									text = "main_menu_cancel",
									on_select = "cb_cancel",
									type = "TextMenuItem",
									remove_func = "cb_controller_enabled",
									callback_object = "page",
									layout_settings = MainMenuSettings.items.text_left_aligned
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
						environment = "blurred",
						show_revision = true,
						type = "Level2MenuPage",
						layout_settings = MainMenuSettings.pages.level_2,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
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
										header_text = "menu_audio_settings",
										z = 100,
										show_revision = true,
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
										show_revision = true,
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
														show_revision = true,
														type = "DropDownListMenuPage",
														on_option_changed = "cb_resolution_option_changed",
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
														sounds = MenuSettings.sounds.none,
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
																	text = "changes_need_restart_main_menu",
																	disabled = true,
																	type = "TextBoxMenuItem",
																	layout_settings = MainMenuSettings.items.popup_textbox
																}
															},
															button_list = {
																{
																	text = "restart",
																	on_select = "cb_item_selected",
																	callback_object = "page",
																	type = "TextureButtonMenuItem",
																	on_select_args = {
																		"close",
																		"restart"
																	},
																	layout_settings = MainMenuSettings.items.popup_button
																},
																{
																	text = "ignore",
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
										show_revision = true,
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
												KeyMappingPageDefinition.main_menu_definition,
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
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_pad360_sensitivity_x",
													on_init_options = "cb_pad_sensitivity_x_options",
													on_option_changed = "cb_pad_sensitivity_x_option_changed",
													type = "EnumMenuItem",
													remove_func = "cb_controller_disabled",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_pad360_sensitivity_y",
													on_init_options = "cb_pad_sensitivity_y_options",
													on_option_changed = "cb_pad_sensitivity_y_option_changed",
													type = "EnumMenuItem",
													remove_func = "cb_controller_disabled",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_keyboard_parry",
													on_init_options = "cb_keyboard_parry_options",
													on_option_changed = "cb_keyboard_parry_option_changed",
													type = "EnumMenuItem",
													remove_func = "cb_controller_enabled",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_keyboard_pose",
													on_init_options = "cb_keyboard_pose_options",
													on_option_changed = "cb_keyboard_pose_option_changed",
													type = "EnumMenuItem",
													remove_func = "cb_controller_enabled",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_invert_swing_control_x",
													on_init_options = "cb_invert_pose_control_x_options",
													on_option_changed = "cb_invert_pose_control_x_option_changed",
													type = "EnumMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_invert_swing_control_y",
													on_init_options = "cb_invert_pose_control_y_options",
													on_option_changed = "cb_invert_pose_control_y_option_changed",
													type = "EnumMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_invert_parry_control_x",
													on_init_options = "cb_invert_parry_control_x_options",
													on_option_changed = "cb_invert_parry_control_x_option_changed",
													type = "EnumMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_invert_parry_control_y",
													on_init_options = "cb_invert_parry_control_y_options",
													on_option_changed = "cb_invert_parry_control_y_option_changed",
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
									text = "menu_gameplay_settings",
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.text_right_aligned,
									page = {
										z = 100,
										show_revision = true,
										type = "Level3MenuPage",
										layout_settings = MainMenuSettings.pages.level_3,
										sounds = MenuSettings.sounds.default,
										item_groups = {
											item_list = {
												{
													text = "menu_gameplay_settings",
													disabled = true,
													type = "TextMenuItem",
													layout_settings = MainMenuSettings.items.header_text_right_aligned
												},
												{
													text = "menu_show_reticule",
													on_init_options = "cb_show_reticule_options",
													on_option_changed = "cb_show_reticule_option_changed",
													type = "EnumMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_show_damage_numbers",
													on_init_options = "cb_show_damage_numbers_options",
													on_option_changed = "cb_show_damage_numbers_option_changed",
													type = "EnumMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_show_xp_awards",
													on_init_options = "cb_show_xp_awards",
													on_option_changed = "cb_show_xp_awards_option_changed",
													type = "EnumMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_show_parry_helper",
													on_init_options = "cb_show_parry_helper",
													on_option_changed = "cb_show_parry_helper_option_changed",
													type = "EnumMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_show_pose_charge_helper",
													on_init_options = "cb_show_pose_charge_helper",
													on_option_changed = "cb_show_pose_charge_helper_option_changed",
													type = "EnumMenuItem",
													layout_settings = MainMenuSettings.items.text_right_aligned
												},
												{
													text = "menu_show_announcements",
													on_init_options = "cb_show_announcements",
													on_option_changed = "cb_show_announcements_option_changed",
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
				CreditsPageDefinition,
				{
					text = "main_menu_buy_game",
					remove_func = "cb_is_not_demo",
					type = "TextMenuItem",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						z = 50,
						environment = "blurred",
						type = "Level2MenuPage",
						layout_settings = MainMenuSettings.pages.level_2,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									text = "main_menu_confirm_buy_game",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.header_text_right_aligned
								},
								{
									text = "main_menu_yes",
									callback_object = "page",
									on_select = "cb_buy_game",
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.text_right_aligned,
									on_select_args = {
										"confirm"
									}
								},
								{
									text = "main_menu_no",
									callback_object = "page",
									on_select = "cb_return_to_main",
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.text_right_aligned
								}
							}
						}
					}
				},
				{
					text = "main_menu_exit_game",
					type = "TextMenuItem",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						z = 50,
						environment = "blurred",
						type = "Level2MenuPage",
						layout_settings = MainMenuSettings.pages.level_2,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
								{
									text = "main_menu_confirm_exit_game",
									disabled = true,
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.header_text_right_aligned
								},
								{
									text = "main_menu_yes",
									on_select = "cb_exit_game",
									type = "TextMenuItem",
									layout_settings = MainMenuSettings.items.text_right_aligned
								},
								{
									text = "main_menu_no",
									callback_object = "page",
									on_select = "cb_return_to_main",
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
					disabled = true,
					text = GameSettingsDevelopment.fix_version,
					type = "TextMenuItem",
					layout_settings = MainMenuSettings.items.text_right_aligned,
					page = {
						z = 50,
						environment = "blurred",
						type = "Level2MenuPage",
						layout_settings = MainMenuSettings.pages.level_2,
						sounds = MenuSettings.sounds.default,
						item_groups = {
							item_list = {
							}
						}
					}
				},
				{
					remove_func = "cb_controller_enabled",
					name = "discord",
					on_select = "cb_open_link",
					type = "TextureLinkButtonMenuItem",
					on_select_args = {
						GameSettingsDevelopment.discord_url
					},
					layout_settings = MainMenuSettings.items.discord
				},
				{
					remove_func = "cb_controller_enabled",
					name = "steam_chat",
					on_select = "cb_open_link",
					type = "TextureLinkButtonMenuItem",
					on_select_args = {
						GameSettingsDevelopment.steam_chat_url
					},
					layout_settings = MainMenuSettings.items.steam_chat
				}
			}
		}
	}
}

local function name_items(table)
	for key, item in pairs(table) do
		if item[1366] and item[1366][768] then
			item[1366][768].layout_name = key
		end

		if item[1680] and item[1680][1050] then
			item[1680][1050].layout_name = key
		end
	end
end

name_items(MainMenuSettings.items)
name_items(MainMenuSettings.pages)
