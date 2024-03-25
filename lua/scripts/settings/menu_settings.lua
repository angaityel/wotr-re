-- chunkname: @scripts/settings/menu_settings.lua

local FONT_GRADIENT_100, WOTR_HUD_TEXT_36, WOTR_HUD_TEXT_MATERIAL, FONT_GRADIENT_100_MATERIAL

if rawget(_G, "Steam") and Steam:language() == "ja" then
	FONT_GRADIENT_100 = {
		material = "hell_shark_36",
		font = "materials/fonts/hell_shark_36"
	}
	WOTR_HUD_TEXT_36 = {
		material = "hell_shark_36",
		font = "materials/fonts/hell_shark_36"
	}
	WOTR_HUD_TEXT_MATERIAL = "materials/fonts/hell_shark_font"
	FONT_GRADIENT_100_MATERIAL = "materials/fonts/hell_shark_font"
else
	FONT_GRADIENT_100 = {
		material = "font_gradient_100",
		font = "materials/fonts/font_gradient_100"
	}
	WOTR_HUD_TEXT_36 = {
		material = "wotr_hud_text_36",
		font = "materials/fonts/wotr_hud_text_36"
	}
	WOTR_HUD_TEXT_MATERIAL = "materials/fonts/wotr_hud_text"
	FONT_GRADIENT_100_MATERIAL = "materials/fonts/font_gradient_100"
end

MenuSettings = {
	camera_lerp_speed = 3,
	double_click_threshold = 0.18,
	news_ticker_speed = 110,
	revision = {
		font_size = 18,
		font = "materials/fonts/hell_shark_18",
		material = "hell_shark_18",
		color = {
			255,
			255,
			255,
			255
		},
		shadow_color = {
			120,
			0,
			0,
			0
		},
		shadow_offset = {
			2,
			-2
		},
		position = {
			z = 999,
			x = -30,
			y = 20
		}
	},
	transitions = {
		fade_out_speed = 1,
		fade_in_speed = 1
	},
	viewports = {
		main_menu_profile_viewer = {
			units = {
				player_without_mount = {
					position_offset = Vector3Box(-0.2, 4.8, -0.7),
					rotation_offset = math.pi
				},
				player_with_mount = {
					position_offset = Vector3Box(-0.2, 4.2, -0.74),
					rotation_offset = math.pi
				},
				mount = {
					position_offset = Vector3Box(-0.6, 5.3, -0.66),
					rotation_offset = math.pi * 1.4
				}
			}
		},
		spawn_menu_profile_viewer = {
			units = {
				player_without_mount = {
					position_offset = Vector3Box(-0.2, 4.2, -0.74),
					rotation_offset = math.pi
				},
				player_with_mount = {
					position_offset = Vector3Box(-0.2, 4.2, -0.74),
					rotation_offset = math.pi
				},
				mount = {
					position_offset = Vector3Box(-0.6, 5.3, -0.66),
					rotation_offset = math.pi * 1.4
				}
			}
		},
		character_sheet_profile_viewer = {
			units = {
				player_without_mount = {
					position_offset = Vector3Box(-0.2, 2.5, -0.7),
					rotation_offset = math.pi
				}
			}
		},
		main_weapon_viewer = {
			default_camera_position = Vector3Box(0.4, 0, 0.4)
		},
		sidearm_viewer = {
			default_camera_position = Vector3Box(0.4, 0, 0.4)
		}
	},
	textures = {
		gear = {
			width = 256,
			height = 128
		},
		perks = {
			width = 128,
			height = 128
		},
		armour = {
			width = 256,
			height = 128
		},
		helmet = {
			width = 256,
			height = 128
		},
		mount = {
			width = 256,
			height = 128
		},
		loading_indicator = {
			width = 128,
			height = 128
		}
	},
	sounds = {
		buy_item_success = "menu_buy_item",
		buy_gold_success = "menu_buy_money",
		none = {
			page = {},
			items = {
				texture_button = {}
			}
		},
		default = {
			page = {
				back = "menu_back"
			},
			items = {
				checkbox = {
					hover = "menu_hover",
					select = "menu_select"
				},
				coat_of_arms_color_picker = {
					hover = "menu_hover",
					select = "menu_select"
				},
				coat_of_arms = {
					hover = "menu_hover",
					select = "menu_select"
				},
				drop_down_list = {
					hover = "menu_hover",
					select = "menu_select"
				},
				enum = {
					hover = "menu_hover",
					select = "menu_select"
				},
				key_mapping = {
					hover = "menu_hover",
					select = "menu_select"
				},
				spawn_area_marker = {
					hover = "menu_hover",
					select = "menu_select"
				},
				squad_marker = {
					hover = "menu_hover",
					select = "menu_select"
				},
				text = {
					hover = "menu_hover",
					select = "menu_select"
				},
				texture_button = {
					hover = "menu_hover",
					select = "menu_select"
				},
				texture = {
					hover = "menu_hover",
					select = "menu_select"
				},
				progress_bar = {
					hover = "menu_hover",
					select = "menu_select"
				},
				text_input = {
					hover = "menu_hover",
					select = "menu_select"
				},
				text_box = {
					hover = "menu_hover",
					select = "menu_select"
				},
				server = {
					hover = "menu_hover",
					select = "menu_select"
				},
				scroll_bar = {
					hover = "menu_hover",
					select = "menu_select"
				},
				tab = {
					hover = "menu_hover",
					select = "menu_select"
				},
				scoreboard_player = {
					hover = "menu_hover",
					select = "menu_select"
				},
				loading_texture = {
					hover = "menu_hover",
					select = "menu_select"
				},
				battle_report_scoreboard = {
					hover = "menu_hover"
				},
				battle_report_summary = {},
				battle_report_summary_award = {}
			}
		}
	},
	videos = {
		fatshark_splash = {
			sound_event = "fatshark_splash",
			video = "fatshark_splash",
			material = "video/fatshark_splash",
			ivf = "video/fatshark_splash"
		},
		paradox_splash = {
			video = "paradox_splash",
			material = "video/paradox_splash",
			ivf = "video/paradox_splash"
		},
		physx_splash = {
			video = "physx_splash",
			material = "video/physx_splash",
			ivf = "video/physx_splash"
		},
		stalbans_intro = {
			video = "stalbans_intro",
			material = "video/stalbans_intro",
			ivf = "video/stalbans_intro"
		},
		mortimerscross_intro = {
			video = "mortimerscross_intro",
			material = "video/mortimerscross_intro",
			ivf = "video/mortimerscross_intro"
		},
		bamburgh_intro = {
			video = "bamburgh_intro",
			material = "video/bamburgh_intro",
			ivf = "video/bamburgh_intro"
		},
		tournament_intro = {
			video = "tournament_intro",
			material = "video/tournament_intro",
			ivf = "video/tournament_intro"
		},
		barnet_intro = {
			video = "barnet_intro",
			material = "video/barnet_intro",
			ivf = "video/barnet_intro"
		}
	},
	fonts = {
		hell_shark_11 = {
			material = "hell_shark_11",
			font = "materials/fonts/hell_shark_11"
		},
		hell_shark_13 = {
			material = "hell_shark_13",
			font = "materials/fonts/hell_shark_13"
		},
		hell_shark_14 = {
			material = "hell_shark_14",
			font = "materials/fonts/hell_shark_14"
		},
		hell_shark_16 = {
			material = "hell_shark_16",
			font = "materials/fonts/hell_shark_16"
		},
		hell_shark_18 = {
			material = "hell_shark_18",
			font = "materials/fonts/hell_shark_18"
		},
		hell_shark_20 = {
			material = "hell_shark_20",
			font = "materials/fonts/hell_shark_20"
		},
		hell_shark_italic_14 = {
			material = "hell_shark_italic_14",
			font = "materials/fonts/hell_shark_italic_14"
		},
		hell_shark_italic_20 = {
			material = "hell_shark_italic_20",
			font = "materials/fonts/hell_shark_italic_20"
		},
		hell_shark_22 = {
			material = "hell_shark_22",
			font = "materials/fonts/hell_shark_22"
		},
		hell_shark_24 = {
			material = "hell_shark_24",
			font = "materials/fonts/hell_shark_24"
		},
		hell_shark_26 = {
			material = "hell_shark_26",
			font = "materials/fonts/hell_shark_26"
		},
		hell_shark_28 = {
			material = "hell_shark_28",
			font = "materials/fonts/hell_shark_28"
		},
		hell_shark_30 = {
			material = "hell_shark_30",
			font = "materials/fonts/hell_shark_30"
		},
		hell_shark_32 = {
			material = "hell_shark_32",
			font = "materials/fonts/hell_shark_32"
		},
		hell_shark_36 = {
			material = "hell_shark_36",
			font = "materials/fonts/hell_shark_36"
		},
		font_gradient_100 = FONT_GRADIENT_100,
		arial_16 = {
			material = "arial_16",
			font = "materials/fonts/arial_16"
		},
		hell_shark_14_masked = {
			material = "hell_shark_14_masked",
			font = "materials/fonts/hell_shark_14"
		},
		hell_shark_20_masked = {
			material = "hell_shark_20_masked",
			font = "materials/fonts/hell_shark_20"
		},
		arial_16_masked = {
			material = "arial_16_masked",
			font = "materials/fonts/arial_16"
		},
		wotr_hud_text_36 = WOTR_HUD_TEXT_36,
		ingame_font = {
			material = "debug",
			font = "core/performance_hud/debug"
		},
		menu_font = {
			material = "arial_16",
			font = "materials/fonts/arial_16"
		},
		player_name_font = {
			material = "arial_16",
			font = "materials/fonts/arial_16"
		}
	}
}
MenuSettings.font_group_materials = {
	hell_shark = "materials/fonts/hell_shark_font",
	arial = "materials/fonts/arial",
	fat_unicorn = "materials/fonts/fat_unicorn_16",
	font_gradient_100 = FONT_GRADIENT_100_MATERIAL,
	wotr_hud_text = WOTR_HUD_TEXT_MATERIAL
}
