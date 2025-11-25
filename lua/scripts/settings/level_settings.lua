-- chunkname: @scripts/settings/level_settings.lua

require("scripts/settings/game_mode_settings")
require("scripts/settings/menu_settings")

local DEFAULT_TIP_LIST = {
	"tip_1",
	"tip_2",
	"tip_3",
	"tip_4",
	"tip_5",
	"tip_6",
	"tip_7",
	"tip_8",
	"tip_9",
	"tip_10",
	"tip_11",
	"tip_12",
	"tip_13",
	"tip_14",
	"tip_15",
	"tip_16",
	"tip_18",
	"tip_19",
	"tip_20",
	"tip_21",
	"tip_22",
	"tip_23",
	"tip_25",
	"tip_26",
	"tip_27",
	"tip_28"
}

LevelSettings = {
	editor_level = {
		ui_description = "level_description_missing",
		level_name = "__level_editor_test",
		display_name = "level_editor",
		sort_index = 999,
		map_id = 1,
		game_server_map_name = "Editor Level",
		sp_requirement_id = 0,
		knocked_down_setting = "knocked_down",
		wounded_setting = "wounded",
		package_name = "resource_packages/levels/whitebox",
		sp_progression_id = 0,
		visible = false,
		ghost_mode_setting = "ghost_mode",
		single_player = true,
		executed_setting = "executed",
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			rot = 180,
			p1 = Vector3Box(1, 1, 0),
			p2 = Vector3Box(-1, -1, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con
		},
		level_particle_effects = {},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "mockup_loading_1920",
			texture_1366 = "mockup_loading_1920"
		}
	},
	whitebox = {
		ui_description = "level_description_whitebox",
		level_name = "levels/whitebox/world",
		display_name = "level_whitebox",
		sort_index = 1,
		map_id = 2,
		game_server_map_name = "Whitebox",
		sp_requirement_id = 0,
		knocked_down_setting = "knocked_down",
		wounded_setting = "wounded",
		package_name = "resource_packages/levels/whitebox",
		sp_progression_id = 0,
		visible = true,
		ghost_mode_setting = "ghost_mode",
		single_player = false,
		executed_setting = "executed",
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(131.056, 10.4095, 0),
			p2 = Vector3Box(-68.825, -189.709, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle
		},
		level_particle_effects = {},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "whitebox_loading_1920",
			texture_1366 = "whitebox_loading_1920"
		}
	},
	level_test_01 = {
		ui_description = "level_description_whitebox",
		level_name = "levels/debug/level_test_01/world",
		display_name = "level_test_01",
		sort_index = 1,
		map_id = 20,
		game_server_map_name = "Whitebox",
		sp_requirement_id = 0,
		knocked_down_setting = "knocked_down",
		wounded_setting = "wounded",
		package_name = "resource_packages/levels/level_test_01",
		sp_progression_id = 0,
		visible = true,
		ghost_mode_setting = "ghost_mode",
		single_player = false,
		executed_setting = "executed",
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			rot = 180,
			p1 = Vector3Box(40, 40, 0),
			p2 = Vector3Box(-40, -40, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con
		},
		level_particle_effects = {},
		level_screen_effects = {
			"fx/screenspace_raindrops"
		},
		loading_screen_preview = {
			texture_1920 = "mockup_loading_1920",
			texture_1366 = "mockup_loading_1920"
		}
	},
	town_02 = {
		package_name = "resource_packages/levels/town_02",
		game_server_map_name = "St_Albans",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 3,
		sort_index = 2,
		display_name = "level_town_02",
		voice_intro = "vo_intro_mp_stalbans_both_01",
		stop_music = "Stop_town_music",
		visible = true,
		single_player = true,
		minimap_texture = "map_town",
		ui_description = "level_description_mp_town_02",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_town_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/town_02/world",
		sp_progression_id = 1,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-94.8922, -131.574, 0),
			p2 = Vector3Box(191.989, 94.9614, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle,
			GameModeSettings.ass
		},
		level_particle_effects = {
			"fx/environment_fire_flakes"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "town_loading_1920",
			texture_1366 = "town_loading_1920"
		},
		custom_win_scale_criteria = {
			ass = {
				critical = 0.6,
				intense = 0.6
			}
		}
	},
	village_02 = {
		package_name = "resource_packages/levels/village_02",
		game_server_map_name = "Mortimers_Cross",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 4,
		sort_index = 3,
		display_name = "level_village_02",
		voice_intro = "vo_intro_mp_mortimerscross_both_01",
		stop_music = "Stop_castle_music",
		visible = true,
		single_player = true,
		minimap_texture = "map_village",
		ui_description = "level_description_mp_village_02",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_castle_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/village_02/world",
		sp_progression_id = 2,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(22.8671, -338.735, 0),
			p2 = Vector3Box(376.854, 225.383, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.gpu_prof,
			GameModeSettings.cpu_prof,
			GameModeSettings.sp,
			GameModeSettings.fly_through,
			GameModeSettings.battle,
			GameModeSettings.ass
		},
		level_particle_effects = {
			"fx/environment_fields_dust"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "village_loading_1920",
			texture_1366 = "village_loading_1920"
		}
	},
	castle_02 = {
		game_server_map_name = "Bamburgh_Castle",
		package_name = "resource_packages/levels/castle_02",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 5,
		sort_index = 4,
		display_name = "level_castle_02",
		executed_setting = "executed",
		voice_intro = "vo_intro_mp_bamburgh_both_01",
		visible = true,
		single_player = true,
		minimap_texture = "map_castle",
		ui_description = "level_description_mp_castle_02",
		stop_music = "Stop_castle_music",
		wounded_setting = "wounded",
		music = "Play_castle_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/castle_02/world",
		sp_progression_id = 3,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-159.819, -21.1483, 0),
			p2 = Vector3Box(80.5617, -383.136, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle,
			GameModeSettings.ass
		},
		level_particle_effects = {
			"fx/environment_rain_castle"
		},
		level_screen_effects = {
			"fx/screenspace_raindrops"
		},
		loading_screen_preview = {
			texture_1920 = "castle_loading_1920",
			texture_1366 = "castle_loading_1920"
		},
		custom_win_scale_criteria = {
			ass = {
				critical = 0.6,
				intense = 0.6
			}
		}
	},
	forest_01 = {
		package_name = "resource_packages/levels/forest_01",
		game_server_map_name = "Clitheroe_Forest",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 6,
		sort_index = 5,
		display_name = "level_forest_01",
		voice_intro = "vo_intro_mp_clitheroe_both_01",
		stop_music = "Stop_field_music",
		visible = true,
		single_player = false,
		minimap_texture = "map_forest",
		ui_description = "level_description_mp_forest_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_field_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/forest_01/world",
		sp_progression_id = 4,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-360.247, -152.382, 0),
			p2 = Vector3Box(222.179, 150.389, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle,
			GameModeSettings.ass
		},
		level_particle_effects = {
			"fx/environment_flies_forest"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "forest_loading_1920",
			texture_1366 = "forest_loading_1920"
		},
		custom_win_scale_criteria = {
			ass = {
				critical = 0.6,
				intense = 0.6
			}
		}
	},
	tournament_01 = {
		package_name = "resource_packages/levels/tournament_01",
		game_server_map_name = "London_Tournament",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 7,
		sort_index = 6,
		display_name = "level_tournament_01",
		voice_intro = "vo_intro_mp_tournament_both_01",
		stop_music = "Stop_tournament_music",
		visible = true,
		single_player = true,
		minimap_texture = "map_tournament",
		ui_description = "level_description_mp_tournament_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_tournament_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/tournament_01/world",
		sp_progression_id = 5,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-219.587, -71.2003, 0),
			p2 = Vector3Box(42.0897, -336.675, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.battle
		},
		level_particle_effects = {
			"fx/environment_tourney_dust"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "tournament_loading_1920",
			texture_1366 = "tournament_loading_1920"
		}
	},
	moor_01 = {
		package_name = "resource_packages/levels/moor_01",
		game_server_map_name = "Edgecote_Moor",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 8,
		sort_index = 7,
		display_name = "level_moor_01",
		voice_intro = "vo_intro_mp_edgecote_both_01",
		stop_music = "Stop_castle_music",
		visible = true,
		single_player = false,
		minimap_texture = "map_moor",
		ui_description = "level_description_mp_moor_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_castle_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/moor_01/world",
		sp_progression_id = 6,
		sp_requirement_id = 5,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(146.587, 186.353, 0),
			p2 = Vector3Box(128.041, -225.604, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.grail,
			GameModeSettings.con,
			GameModeSettings.battle
		},
		level_particle_effects = {
			"fx/rain_cylinder"
		},
		level_screen_effects = {
			"fx/screenspace_raindrops"
		},
		loading_screen_preview = {
			texture_1920 = "moor_loading_1920",
			texture_1366 = "moor_loading_1920"
		}
	},
	field_01 = {
		package_name = "resource_packages/levels/field_01",
		game_server_map_name = "Barnet",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 9,
		sort_index = 8,
		display_name = "level_field_01",
		voice_intro = "vo_intro_mp_barnet_both_01",
		stop_music = "Stop_field_music",
		visible = true,
		single_player = true,
		minimap_texture = "map_field",
		ui_description = "level_description_mp_field_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_field_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/field_01/world",
		sp_progression_id = 6,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(320.92, 31.4317, 0),
			p2 = Vector3Box(-138.175, 104.199, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle
		},
		level_particle_effects = {
			"fx/environment_fields_dust"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "field_loading_1920",
			texture_1366 = "field_loading_1920"
		}
	},
	ai = {
		ui_description = "level_description_missing",
		level_name = "levels/ai/world",
		display_name = "level_ai",
		sort_index = 9,
		map_id = 10,
		game_server_map_name = "AI_Test_Level",
		sp_requirement_id = 0,
		knocked_down_setting = "knocked_down",
		wounded_setting = "wounded",
		package_name = "resource_packages/levels/ai",
		sp_progression_id = 0,
		visible = true,
		ghost_mode_setting = "ghost_mode",
		single_player = false,
		executed_setting = "executed",
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			rot = 0,
			p1 = Vector3Box(-50, -50, 0),
			p2 = Vector3Box(50, 50, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con
		},
		level_particle_effects = {},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "mockup_loading_1920",
			texture_1366 = "mockup_loading_1920"
		}
	},
	level_test_01 = {
		ui_description = "level_description_missing",
		level_name = "levels/debug/level_test_01/world",
		display_name = "level_test_01",
		sort_index = 10,
		map_id = 11,
		game_server_map_name = "Level Test 01",
		sp_requirement_id = 0,
		knocked_down_setting = "knocked_down",
		wounded_setting = "wounded",
		package_name = "resource_packages/levels/level_test_01",
		sp_progression_id = 0,
		visible = true,
		ghost_mode_setting = "ghost_mode",
		single_player = false,
		executed_setting = "executed",
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			rot = 180,
			p1 = Vector3Box(40, 40, 0),
			p2 = Vector3Box(-40, -40, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con
		},
		level_particle_effects = {},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "mockup_loading_1920",
			texture_1366 = "mockup_loading_1920"
		}
	},
	cpu_profiling = {
		ui_description = "level_description_missing",
		level_name = "levels/cpu_profiling/world",
		display_name = "level_cpu_profiling",
		sort_index = 11,
		map_id = 12,
		game_server_map_name = "CPU Profiling",
		sp_requirement_id = 0,
		knocked_down_setting = "knocked_down",
		wounded_setting = "wounded",
		package_name = "resource_packages/levels/cpu_profiling",
		sp_progression_id = 0,
		visible = true,
		ghost_mode_setting = "ghost_mode",
		single_player = false,
		executed_setting = "executed",
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			rot = 180,
			p1 = Vector3Box(40, 40, 0),
			p2 = Vector3Box(-40, -40, 0)
		},
		game_modes = {
			GameModeSettings.cpu_prof
		},
		level_particle_effects = {},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "mockup_loading_1920",
			texture_1366 = "mockup_loading_1920"
		}
	},
	wakefield_01 = {
		package_name = "resource_packages/levels/wakefield_01",
		game_server_map_name = "Wakefield1",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 13,
		sort_index = 12,
		display_name = "level_wakefield_01",
		stop_music = "Stop_winter_music",
		visible = true,
		single_player = false,
		minimap_texture = "map_wakefield",
		ui_description = "level_description_mp_wakefield_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_winter_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/wakefield_01/world",
		sp_progression_id = 6,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-195.055, -271.668, 0),
			p2 = Vector3Box(245.883, 128.848, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle
		},
		level_particle_effects = {
			"fx/snow_test"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "wakefield_loading_1920",
			texture_1366 = "wakefield_loading_1920"
		}
	},
	towton_01 = {
		package_name = "resource_packages/levels/towton_01",
		game_server_map_name = "Towton",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 14,
		sort_index = 13,
		display_name = "level_towton_01",
		on_spawn_flow_event = "cold_breath_activate",
		stop_music = "Stop_winter_music",
		visible = true,
		single_player = false,
		minimap_texture = "map_towton",
		ui_description = "level_description_mp_towton_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_winter_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/towton_01/world",
		sp_progression_id = 6,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-181.723, -373.175, 0),
			p2 = Vector3Box(170.159, 256.795, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle
		},
		level_particle_effects = {
			"fx/snow_storm"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "towton_loading_1920",
			texture_1366 = "towton_loading_1920"
		}
	},
	ravenspurn_01 = {
		package_name = "resource_packages/levels/ravenspurn_01",
		game_server_map_name = "Ravenspurn",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 15,
		sort_index = 14,
		display_name = "level_ravenspurn_01",
		on_spawn_flow_event = "cold_breath_activate",
		stop_music = "Stop_ravenspurn_music",
		visible = true,
		single_player = false,
		minimap_texture = "map_ravenspurn",
		ui_description = "level_description_mp_ravenspurn_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_ravenspurn_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/ravenspurn_01/world",
		sp_progression_id = 6,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-106, 270.768, 0),
			p2 = Vector3Box(120.577, -421.764, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle
		},
		level_particle_effects = {},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "ravenspurn_loading_1920",
			texture_1366 = "ravenspurn_loading_1920"
		}
	},
	greenwood_01 = {
		package_name = "resource_packages/levels/sherwood_01",
		game_server_map_name = "Greenwood",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 16,
		sort_index = 15,
		display_name = "level_greenwood_01",
		on_spawn_flow_event = "cold_breath_activate",
		stop_music = "Stop_sherwood_music",
		visible = true,
		single_player = false,
		minimap_texture = "map_sherwood",
		ui_description = "level_description_mp_sherwood_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_sherwood_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/sherwood_01/world",
		sp_progression_id = 6,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-1.1184, 129.988, 0),
			p2 = Vector3Box(119.013, -222.812, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.battle
		},
		level_particle_effects = {
			"fx/environment_fields_dust"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "sherwood_loading_1920",
			texture_1366 = "sherwood_loading_1920"
		}
	},
	wakefield_02 = {
		package_name = "resource_packages/levels/wakefield_02",
		game_server_map_name = "Wakefield",
		show_in_server_browser = true,
		ghost_mode_setting = "ghost_mode",
		map_id = 17,
		sort_index = 16,
		display_name = "level_wakefield_01",
		stop_music = "Stop_winter_music",
		visible = true,
		single_player = false,
		minimap_texture = "map_wakefield",
		ui_description = "level_description_mp_wakefield_01",
		executed_setting = "executed",
		wounded_setting = "wounded",
		music = "Play_winter_music",
		knocked_down_setting = "knocked_down",
		level_name = "levels/wakefield_02/world",
		sp_progression_id = 6,
		sp_requirement_id = 0,
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(-195.055, -271.668, 0),
			p2 = Vector3Box(245.883, 128.848, 0)
		},
		game_modes = {
			GameModeSettings.ass
		},
		level_particle_effects = {
			"fx/snow_test"
		},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "wakefield_loading_1920",
			texture_1366 = "wakefield_loading_1920"
		},
		custom_win_scale_criteria = {
			ass = {
				critical = 0.8,
				intense = 0.8
			}
		}
	},
	practice = {
		ui_description = "level_description_practice",
		level_name = "levels/practice/world",
		display_name = "level_practice",
		sort_index = 17,
		map_id = 18,
		game_server_map_name = "Practice",
		single_player_game_mode = "tdm",
		knocked_down_setting = "knocked_down",
		ghost_mode_setting = "ghost_mode",
		package_name = "resource_packages/levels/practice",
		sp_progression_id = 0,
		visible = true,
		wounded_setting = "wounded",
		single_player = true,
		sp_requirement_id = 0,
		executed_setting = "executed",
		tip_of_the_day = DEFAULT_TIP_LIST,
		minimap = {
			p1 = Vector3Box(131.056, 10.4095, 0),
			p2 = Vector3Box(-68.825, -189.709, 0)
		},
		game_modes = {
			GameModeSettings.tdm,
			GameModeSettings.con,
			GameModeSettings.battle
		},
		level_particle_effects = {},
		level_screen_effects = {},
		loading_screen_preview = {
			texture_1920 = "whitebox_loading_1920",
			texture_1366 = "whitebox_loading_1920"
		}
	},
	character_sheet = {
		ui_description = "level_description_missing",
		level_name = "levels/outfit_display/character_sheet/world",
		display_name = "level_character_sheet",
		sort_index = 999,
		visible = false,
		minimap = {},
		game_modes = {}
	},
	outfit_display = {
		ui_description = "level_description_missing",
		level_name = "levels/outfit_display/outfit_display/world",
		display_name = "level_outfit_display",
		sort_index = 999,
		visible = false,
		minimap = {},
		game_modes = {}
	},
	main_menu = {
		ui_description = "level_description_missing",
		level_name = "levels/menu/mainmenu_01/world",
		display_name = "",
		sort_index = 999,
		visible = false,
		package_name = "resource_packages/levels/menu/mainmenu_01",
		minimap = {},
		game_modes = {}
	},
	main_menu_halloween_01 = {
		ui_description = "level_description_missing",
		level_name = "levels/menu/mainmenu_halloween/main_menu_halloween_01",
		display_name = "",
		sort_index = 999,
		visible = false,
		package_name = "resource_packages/levels/menu/main_menu_halloween_01",
		minimap = {},
		game_modes = {}
	},
	main_menu_hospitaller = {
		ui_description = "level_description_missing",
		level_name = "levels/menu/main_menu_hospitaller/world",
		display_name = "",
		sort_index = 999,
		visible = false,
		package_name = "resource_packages/levels/menu/main_menu_hospitaller",
		minimap = {},
		game_modes = {}
	},
	main_menu_winter = {
		ui_description = "level_description_missing",
		level_name = "levels/menu/main_menu_winter/world",
		display_name = "",
		sort_index = 999,
		visible = false,
		package_name = "resource_packages/levels/menu/main_menu_winter",
		minimap = {},
		game_modes = {}
	},
	main_menu_scottish = {
		ui_description = "level_description_missing",
		level_name = "levels/menu/main_menu_scottish/world",
		display_name = "",
		sort_index = 999,
		visible = false,
		package_name = "resource_packages/levels/menu/main_menu_scottish",
		minimap = {},
		game_modes = {}
	},
	main_menu_kingmaker = {
		ui_description = "level_description_missing",
		level_name = "levels/menu/main_menu_kingmaker/world",
		display_name = "",
		sort_index = 999,
		visible = false,
		package_name = "resource_packages/levels/menu/main_menu_kingmaker",
		minimap = {},
		game_modes = {}
	}
}

function server_map_name_to_level_key(name)
	for level_key, level_settings in pairs(LevelSettings) do
		if level_settings.game_server_map_name and level_settings.game_server_map_name:lower() == name:lower() then
			return level_key
		end
	end
end
