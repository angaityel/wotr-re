-- chunkname: @scripts/settings/armours.lua

ArmourCategories = {
	light = {
		ui_description = "armour_category_description_light",
		ui_texture = "armour_flawed_mockup",
		ui_header = "armour_category_name_light",
		ui_sort_index = 1
	},
	medium = {
		ui_description = "armour_category_description_medium",
		ui_texture = "armour_flawed_mockup",
		ui_header = "armour_category_name_medium",
		ui_sort_index = 2
	},
	heavy = {
		ui_description = "armour_category_description_heavy",
		ui_texture = "armour_flawed_mockup",
		ui_header = "armour_category_name_heavy",
		ui_sort_index = 3
	}
}

local PEASANT_MESHES = {
	g_chr_wotr_peasant_lod0 = {
		"wotr_man_peasant_cloth_mat",
		"wotr_man_peasant_double_sided_cloth_mat",
		"wotr_man_peasant_leather_mat",
		"wotr_man_peasant_cloth_proj_mat"
	},
	g_chr_wotr_peasant_lod1 = {
		"wotr_man_peasant_cloth_mat",
		"wotr_man_peasant_double_sided_cloth_mat",
		"wotr_man_peasant_leather_mat",
		"wotr_man_peasant_cloth_proj_mat"
	},
	g_chr_wotr_peasant_lod2 = {
		"wotr_man_peasant_cloth_mat"
	}
}
local LIGHT_MESHES = {
	g_wotr_light_body_lod0 = {
		"chr_wotr_light_body_cloth_mat",
		"chr_wotr_light_body_leather_mat",
		"chr_wotr_light_body_metal_mat",
		"chr_wotr_light_body_cloth_proj_mat"
	},
	g_wotr_light_body_lod1 = {
		"chr_wotr_light_body_cloth_mat",
		"chr_wotr_light_body_leather_mat",
		"chr_wotr_light_body_metal_mat",
		"chr_wotr_light_body_cloth_proj_mat"
	},
	g_wotr_light_body_lod2 = {
		"chr_wotr_light_body_cloth_mat"
	}
}
local LIGHT_JUIPON_MESHES = {
	g_wotr_light_body_lod0 = {
		"chr_wotr_light_juipon_body_cloth_mat",
		"chr_wotr_light_juipon_body_metal_mat",
		"chr_wotr_light_juipon_body_leather_mat",
		"chr_wotr_light_juipon_body_skin_mat"
	},
	g_wotr_light_body_lod1 = {
		"chr_wotr_light_juipon_body_cloth_mat",
		"chr_wotr_light_juipon_body_metal_mat",
		"chr_wotr_light_juipon_body_leather_mat",
		"chr_wotr_light_juipon_body_skin_mat"
	},
	g_wotr_light_body_lod2 = {
		"chr_wotr_light_juipon_body_cloth_mat",
		"chr_wotr_light_juipon_body_metal_mat",
		"chr_wotr_light_juipon_body_leather_mat",
		"chr_wotr_light_juipon_body_skin_mat"
	}
}
local LIGHT_WINTER_MESHES = {
	g_wotr_light_body_lod0 = {
		"chr_wotr_light_body_cloth_mat",
		"chr_wotr_light_body_leather_mat",
		"chr_wotr_light_body_metal_mat",
		"chr_wotr_light_body_cloth_proj_mat"
	},
	g_wotr_light_body_lod1 = {
		"chr_wotr_light_body_cloth_mat",
		"chr_wotr_light_body_leather_mat",
		"chr_wotr_light_body_metal_mat",
		"chr_wotr_light_body_cloth_proj_mat"
	},
	g_wotr_light_body_lod2 = {
		"chr_wotr_light_body_cloth_mat"
	}
}
local ITALIAN_MESHES = {
	g_wotr_italian_lod0 = {
		"wotr_italian_cloth_mat",
		"wotr_italian_leather_mat",
		"wotr_italian_metal_mat",
		"wotr_italian_proj_mat"
	},
	g_wotr_italian_lod1 = {
		"wotr_italian_cloth_mat",
		"wotr_italian_leather_mat",
		"wotr_italian_metal_mat",
		"wotr_italian_proj_mat"
	},
	g_wotr_italian_lod2 = {
		"wotr_italian_cloth_mat"
	}
}
local MEDIUM_MESHES = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	},
	g_wotr_medium_body_lod1 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	},
	g_wotr_medium_body_lod2 = {
		"chr_wotr_medium_body_metal_mat"
	}
}
local MEDIUM_WINTER_MESHES = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	},
	g_wotr_medium_body_lod1 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	},
	g_wotr_medium_body_lod2 = {
		"chr_wotr_medium_body_metal_mat"
	}
}
local MEDIUM_BRIGANDINE_MESHES = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_proj_mat"
	},
	g_wotr_medium_body_lod1 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_proj_mat"
	},
	g_wotr_medium_body_lod2 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_proj_mat"
	}
}
local GALLOGLASS_MESHES = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat"
	},
	g_wotr_medium_body_lod1 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat"
	},
	g_wotr_medium_body_lod2 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat"
	}
}
local SWISS_MESHES = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	},
	g_wotr_medium_body_lod1 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	},
	g_wotr_medium_body_lod2 = {
		"chr_wotr_medium_body_metal_mat"
	}
}
local HEAVY_MESHES = {
	g_wotr_heavy_body_lod0 = {
		"wotr_heavy_body_metal_mat",
		"wotr_heavy_body_metal_proj_mat"
	},
	g_wotr_heavy_body_lod1 = {
		"wotr_heavy_body_metal_mat",
		"wotr_heavy_body_metal_proj_mat"
	},
	g_wotr_heavy_body_lod2 = {
		"wotr_heavy_body_metal_mat",
		"wotr_heavy_body_metal_proj_mat"
	}
}
local HEAVY_MILANESE_MESHES = {
	g_wotr_heavy_body_lod0 = {
		"wotr_heavy_body_metal_mat",
		"wotr_heavy_body_metal_proj_mat"
	},
	g_wotr_heavy_body_lod1 = {
		"wotr_heavy_body_metal_mat",
		"wotr_heavy_body_metal_proj_mat"
	},
	g_wotr_heavy_body_lod2 = {
		"wotr_heavy_body_metal_mat"
	}
}
local PEASANT_MESHES_PREVIEW = {
	g_chr_wotr_peasant_lod0 = {
		"wotr_man_peasant_cloth_mat",
		"wotr_man_peasant_double_sided_cloth_mat",
		"wotr_man_peasant_leather_mat",
		"wotr_man_peasant_cloth_proj_mat"
	}
}
local LIGHT_MESHES_PREVIEW = {
	g_wotr_light_body_lod0 = {
		"chr_wotr_light_body_cloth_mat",
		"chr_wotr_light_body_leather_mat",
		"chr_wotr_light_body_metal_mat",
		"chr_wotr_light_body_cloth_proj_mat"
	}
}
local LIGHT_WINTER_MESHES_PREVIEW = {
	g_wotr_light_body_lod0 = {
		"chr_wotr_light_body_cloth_mat",
		"chr_wotr_light_body_leather_mat",
		"chr_wotr_light_body_metal_mat",
		"chr_wotr_light_body_cloth_proj_mat"
	}
}
local LIGHT_JUIPON_MESHES_PREVIEW = {
	g_wotr_light_body_lod0 = {
		"chr_wotr_light_juipon_body_cloth_mat",
		"chr_wotr_light_juipon_body_metal_mat",
		"chr_wotr_light_juipon_body_leather_mat",
		"chr_wotr_light_juipon_body_skin_mat"
	}
}
local ITALIAN_MESHES_PREVIEW = {
	g_wotr_italian_lod0 = {
		"wotr_italian_cloth_mat",
		"wotr_italian_leather_mat",
		"wotr_italian_metal_mat",
		"wotr_italian_proj_mat"
	}
}
local MEDIUM_MESHES_PREVIEW = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	}
}
local MEDIUM_WINTER_MESHES_PREVIEW = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	}
}
local MEDIUM_BRIGANDINE_MESHES_PREVIEW = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_proj_mat"
	}
}
local GALLOGLASS_MESHES_PREVIEW = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat"
	}
}
local SWISS_MESHES_PREVIEW = {
	g_wotr_medium_body_lod0 = {
		"chr_wotr_medium_body_mat",
		"chr_wotr_medium_body_leather_mat",
		"chr_wotr_medium_body_metal_mat",
		"chr_wotr_medium_body_metal_proj_mat"
	}
}
local HEAVY_MESHES_PREVIEW = {
	g_wotr_heavy_body_lod0 = {
		"wotr_heavy_body_metal_mat",
		"wotr_heavy_body_metal_proj_mat"
	}
}
local HEAVY_MILANESE_MESHES_PREVIEW = {
	g_wotr_heavy_body_lod0 = {
		"wotr_heavy_body_metal_mat",
		"wotr_heavy_body_metal_proj_mat"
	}
}

PeasantPatterns = {
	pattern_standard = {
		ui_description = "armour_light_peasant_rags_standard_description",
		name = "armour_light_peasant_rags_standard",
		team_pattern_u = 0,
		unlock_key = 1,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_peasant_rags_standard_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_white_preorder = {
		ui_description = "armour_light_peasant_pattern_white_preorder_description",
		name = "armour_light_peasant_pattern_white_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 2,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_peasant_pattern_white_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(0.007, 0.01, 0.055),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(1, 1, 1),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_red_preorder = {
		ui_description = "armour_light_peasant_pattern_red_preorder_description",
		name = "armour_light_peasant_pattern_red_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 3,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_peasant_pattern_red_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.05, 0.005, 0),
		personal_pattern_tint_secondary = Vector3Box(0.05, 0.005, 0),
		team_pattern_tint_primary = Vector3Box(0.035, 0.045, 0.06),
		team_pattern_tint_secondary = Vector3Box(0.035, 0.045, 0.06),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_coal_miner = {
		ui_description = "armour_light_peasant_rags_coal_miner_description",
		name = "armour_light_peasant_rags_coal_miner",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 4,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_peasant_rags_coal_miner_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.1, 0.2, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.1, 0.2, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_fifty_fifty = {
		ui_description = "armour_light_peasant_rags_50_50_description",
		name = "armour_light_peasant_rags_50_50",
		team_pattern_u = 0.5,
		market_price = 20000,
		unlock_key = 5,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_peasant_rags_50_50_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.2, 0.3, 0.2),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_rags_red = {
		ui_description = "armour_light_peasant_rags_red_description",
		name = "armour_light_peasant_rags_red",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 6,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_peasant_rags_red_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.11, 0.12, 0.097),
		personal_pattern_tint_secondary = Vector3Box(0.13, 0.13, 0.086),
		team_pattern_tint_primary = Vector3Box(0.2, 0.034, 0.073),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.21, 0.1)
	},
	pattern_rags_green = {
		ui_description = "armour_light_peasant_rags_green_description",
		name = "armour_light_peasant_rags_green",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 7,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_peasant_rags_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.15, 0.165, 0.073),
		team_pattern_tint_secondary = Vector3Box(0.135, 0.175, 0.15)
	},
	pattern_rags_brown = {
		ui_description = "armour_light_peasant_rags_brown_description",
		name = "armour_light_peasant_rags_brown",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 8,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_peasant_rags_brown_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.15, 0.145, 0.173),
		team_pattern_tint_secondary = Vector3Box(0.135, 0.127, 0.15)
	},
	pattern_rags_blue = {
		ui_description = "armour_light_peasant_rags_blue_description",
		name = "armour_light_peasant_rags_blue",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 9,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_peasant_rags_blue_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.1, 0.12, 0.44),
		team_pattern_tint_secondary = Vector3Box(0.1, 0.228, 0.5)
	},
	pattern_pig_wrestler = {
		ui_description = "armour_light_peasant_rags_pig_wrestler_description",
		name = "armour_light_peasant_rags_pig_wrestler",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 10,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_peasant_rags_pig_wrestler_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.035, 0.03, 0.05),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.09, 0.025, 0.01),
		team_pattern_tint_secondary = Vector3Box(0.1, 0.228, 0.5)
	},
	pattern_red_undershirt = {
		ui_description = "armour_light_peasant_rags_red_undershirt_description",
		name = "armour_light_peasant_rags_red_undershirt",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 11,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_peasant_rags_red_undershirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.05, 0.03, 0.01),
		personal_pattern_tint_secondary = Vector3Box(0.347, 0.06, 0.11),
		team_pattern_tint_primary = Vector3Box(0.05, 0.03, 0.01),
		team_pattern_tint_secondary = Vector3Box(0.347, 0.06, 0.11)
	},
	pattern_green_undershirt = {
		ui_description = "armour_light_peasant_rags_green_undershirt_description",
		name = "armour_light_peasant_rags_green_undershirt",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 12,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_peasant_rags_green_undershirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.07, 0.05, 0.02),
		personal_pattern_tint_secondary = Vector3Box(0.17, 0.23, 0.16),
		team_pattern_tint_primary = Vector3Box(0.07, 0.05, 0.02),
		team_pattern_tint_secondary = Vector3Box(0.17, 0.23, 0.16)
	},
	pattern_rags_mixed_01 = {
		ui_description = "armour_light_peasant_rags_mixed_01_description",
		name = "armour_light_peasant_rags_mixed_01",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 13,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_peasant_rags_mixed_01_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.54, 0.22, 0.2),
		team_pattern_tint_primary = Vector3Box(0.15, 0.31, 0.13),
		team_pattern_tint_secondary = Vector3Box(0.135, 0.35, 0.15)
	},
	pattern_rags_mixed_02 = {
		ui_description = "armour_light_peasant_rags_mixed_02_description",
		name = "armour_light_peasant_rags_mixed_02",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 14,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_peasant_rags_mixed_02_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.02, 0.015, 0.016),
		personal_pattern_tint_secondary = Vector3Box(0.24, 0.22, 0.62),
		team_pattern_tint_primary = Vector3Box(0.05, 0.03, 0.01),
		team_pattern_tint_secondary = Vector3Box(0.35, 0.14, 0.25)
	}
}
LightTabardPatterns = {
	pattern_standard = {
		ui_description = "armour_light_tabard_pattern_standard_white_description",
		name = "armour_light_tabard_pattern_standard_white",
		team_pattern_u = 0,
		unlock_key = 15,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_standard_white_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_white_preorder = {
		ui_description = "armour_light_tabard_pattern_white_preorder_description",
		name = "armour_light_tabard_pattern_white_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 16,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_white_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.6, 0.6, 0.6),
		personal_pattern_tint_secondary = Vector3Box(0.6, 0.6, 0.6),
		team_pattern_tint_primary = Vector3Box(0.6, 0.6, 0.6),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.4, 0.9),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_red_preorder = {
		ui_description = "armour_light_tabard_pattern_red_preorder_description",
		name = "armour_light_tabard_pattern_red_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 17,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_red_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.22, 0.06, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.35, 0.45, 0.6),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_standard_red = {
		ui_description = "armour_light_tabard_pattern_standard_red_description",
		name = "armour_light_tabard_pattern_standard_red",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 18,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_standard_red_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.8, 0.8, 0.8),
		personal_pattern_tint_secondary = Vector3Box(0.8, 0.8, 0.8),
		team_pattern_tint_primary = Vector3Box(0.22, 0.06, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.37, 0.55, 0.35)
	},
	pattern_standard_green = {
		ui_description = "armour_light_tabard_pattern_standard_green_description",
		name = "armour_light_tabard_pattern_standard_green",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 19,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_standard_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.42, 0.26, 0.25)
	},
	pattern_standard_black = {
		ui_description = "armour_light_tabard_pattern_standard_black_description",
		name = "armour_light_tabard_pattern_standard_black",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 20,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_standard_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.02511, 0.025112, 0.02511),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_standard_blue = {
		ui_description = "armour_light_tabard_pattern_standard_blue_description",
		name = "armour_light_tabard_pattern_standard_blue",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 21,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_standard_blue_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.35),
		team_pattern_tint_secondary = Vector3Box(0.8, 0.8, 0.3)
	},
	pattern_red_blue_blocks = {
		ui_description = "armour_light_tabard_pattern_red_blue_blocks_description",
		name = "armour_light_tabard_pattern_red_blue_blocks",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 22,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_red_blue_blocks_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.87, 0.18, 0.08),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_green_white_blocks = {
		ui_description = "armour_light_tabard_pattern_green_white_blocks_description",
		name = "armour_light_tabard_pattern_green_white_blocks",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 23,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_green_white_blocks_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.05),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_square_red_white = {
		ui_description = "armour_light_tabard_pattern_embroidered_square_red_white_description",
		name = "armour_light_tabard_pattern_embroidered_square_red_white",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 24,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_tabard_pattern_embroidered_square_red_white_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.1, 0.08),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_square_black_green = {
		ui_description = "armour_light_tabard_pattern_embroidered_square_black_green_description",
		name = "armour_light_tabard_pattern_embroidered_square_black_green",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 25,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_tabard_pattern_embroidered_square_black_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.118, 0.075, 0.23),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.107, 0.228, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_square_blue_yellow = {
		ui_description = "armour_light_tabard_pattern_embroidered_square_blue_yellow_description",
		name = "armour_light_tabard_pattern_embroidered_square_blue_yellow",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 26,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_tabard_pattern_embroidered_square_blue_yellow_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.06, 0.1, 0.94),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.4, 0.42, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_divide_yellow_blue = {
		ui_description = "armour_light_tabard_pattern_embroidered_divide_yellow_blue_description",
		name = "armour_light_tabard_pattern_embroidered_divide_yellow_blue",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 27,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_embroidered_divide_yellow_blue_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.06, 0.1, 0.94),
		personal_pattern_tint_secondary = Vector3Box(0.6, 0.62, 0.307),
		team_pattern_tint_primary = Vector3Box(0.4, 0.42, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.26, 0.3, 0.94)
	},
	pattern_divide_black_red = {
		ui_description = "armour_light_tabard_pattern_embroidered_divide_black_red_description",
		name = "armour_light_tabard_pattern_embroidered_divide_black_red",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 28,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_embroidered_divide_black_red_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.03, 0.03, 0.03),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.22, 0.06, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_divide_black_yellow = {
		ui_description = "armour_light_tabard_pattern_embroidered_divide_black_yellow_description",
		name = "armour_light_tabard_pattern_embroidered_divide_black_yellow",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 29,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_tabard_pattern_embroidered_divide_black_yellow_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.114, 0.12, 0.178),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.4, 0.42, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_white_blue = {
		ui_description = "armour_light_tabard_pattern_embroidered_pattern_white_blue_description",
		name = "armour_light_tabard_pattern_embroidered_pattern_white_blue",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 30,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_tabard_pattern_embroidered_pattern_white_blue_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_yellow_green = {
		ui_description = "armour_light_tabard_pattern_embroidered_pattern_yellow_green_description",
		name = "armour_light_tabard_pattern_embroidered_pattern_yellow_green",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 31,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_tabard_pattern_embroidered_pattern_yellow_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.07, 0.234, 0.21),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.4, 0.42, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_orange_split_vertical = {
		ui_description = "armour_light_tabard_pattern_orange_split_vertical_description",
		name = "armour_light_tabard_pattern_orange_split_vertical",
		team_pattern_u = 0.5,
		market_price = 10000,
		unlock_key = 75,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_light_tabard_pattern_orange_split_vertical_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.2, 0.03, 0),
		team_pattern_tint_secondary = Vector3Box(2.1, 1.1, 0.1)
	}
}
LightTabardWinterPatterns = {
	pattern_standard = {
		ui_description = "armour_light_winter_tabard_pattern_standard_white_description",
		name = "armour_light_winter_tabard_pattern_standard_white",
		team_pattern_u = 0,
		unlock_key = 200,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_standard_white_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_white_preorder = {
		ui_description = "armour_light_winter_tabard_pattern_white_preorder_description",
		name = "armour_light_winter_tabard_pattern_white_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 201,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_white_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.6, 0.6, 0.6),
		personal_pattern_tint_secondary = Vector3Box(0.6, 0.6, 0.6),
		team_pattern_tint_primary = Vector3Box(0.6, 0.6, 0.6),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.4, 0.9),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_red_preorder = {
		ui_description = "armour_light_winter_tabard_pattern_red_preorder_description",
		name = "armour_light_winter_tabard_pattern_red_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 202,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_red_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.22, 0.06, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.35, 0.45, 0.6),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_standard_red = {
		ui_description = "armour_light_winter_tabard_pattern_standard_red_description",
		name = "armour_light_winter_tabard_pattern_standard_red",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 203,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_standard_red_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.8, 0.8, 0.8),
		personal_pattern_tint_secondary = Vector3Box(0.8, 0.8, 0.8),
		team_pattern_tint_primary = Vector3Box(0.22, 0.06, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.37, 0.55, 0.35)
	},
	pattern_standard_green = {
		ui_description = "armour_light_winter_tabard_pattern_standard_green_description",
		name = "armour_light_winter_tabard_pattern_standard_green",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 204,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_standard_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.42, 0.26, 0.25)
	},
	pattern_standard_black = {
		ui_description = "armour_light_winter_tabard_pattern_standard_black_description",
		name = "armour_light_winter_tabard_pattern_standard_black",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 205,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_standard_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.02511, 0.025112, 0.02511),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_standard_blue = {
		ui_description = "armour_light_winter_tabard_pattern_standard_blue_description",
		name = "armour_light_winter_tabard_pattern_standard_blue",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 206,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_standard_blue_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.35),
		team_pattern_tint_secondary = Vector3Box(0.8, 0.8, 0.3)
	},
	pattern_red_blue_blocks = {
		ui_description = "armour_light_winter_tabard_pattern_red_blue_blocks_description",
		name = "armour_light_winter_tabard_pattern_red_blue_blocks",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 207,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_red_blue_blocks_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.87, 0.18, 0.08),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_green_white_blocks = {
		ui_description = "armour_light_winter_tabard_pattern_green_white_blocks_description",
		name = "armour_light_winter_tabard_pattern_green_white_blocks",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 208,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_green_white_blocks_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.05),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_square_red_white = {
		ui_description = "armour_light_winter_tabard_pattern_embroidered_square_red_white_description",
		name = "armour_light_winter_tabard_pattern_embroidered_square_red_white",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 209,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_winter_tabard_pattern_embroidered_square_red_white_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.1, 0.08),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_square_black_green = {
		ui_description = "armour_light_winter_tabard_pattern_embroidered_square_black_green_description",
		name = "armour_light_winter_tabard_pattern_embroidered_square_black_green",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 210,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_winter_tabard_pattern_embroidered_square_black_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.118, 0.075, 0.23),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.107, 0.228, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_square_blue_yellow = {
		ui_description = "armour_light_winter_tabard_pattern_embroidered_square_blue_yellow_description",
		name = "armour_light_winter_tabard_pattern_embroidered_square_blue_yellow",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 211,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_winter_tabard_pattern_embroidered_square_blue_yellow_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.06, 0.1, 0.94),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.4, 0.42, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_divide_yellow_blue = {
		ui_description = "armour_light_winter_tabard_pattern_embroidered_divide_yellow_blue_description",
		name = "armour_light_winter_tabard_pattern_embroidered_divide_yellow_blue",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 212,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_embroidered_divide_yellow_blue_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.06, 0.1, 0.94),
		personal_pattern_tint_secondary = Vector3Box(0.6, 0.62, 0.307),
		team_pattern_tint_primary = Vector3Box(0.4, 0.42, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.26, 0.3, 0.94)
	},
	pattern_divide_black_red = {
		ui_description = "armour_light_winter_tabard_pattern_embroidered_divide_black_red_description",
		name = "armour_light_winter_tabard_pattern_embroidered_divide_black_red",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 213,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_embroidered_divide_black_red_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.03, 0.03, 0.03),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.22, 0.06, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_divide_black_yellow = {
		ui_description = "armour_light_winter_abard_pattern_embroidered_divide_black_yellow_description",
		name = "armour_light_winter_tabard_pattern_embroidered_divide_black_yellow",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 214,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_winter_tabard_pattern_embroidered_divide_black_yellow_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.114, 0.12, 0.178),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.4, 0.42, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_white_blue = {
		ui_description = "armour_light_winter_tabard_pattern_embroidered_pattern_white_blue_description",
		name = "armour_light_winter_tabard_pattern_embroidered_pattern_white_blue",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 215,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_winter_tabard_pattern_embroidered_pattern_white_blue_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_yellow_green = {
		ui_description = "armour_light_winter_tabard_pattern_embroidered_pattern_yellow_green_description",
		name = "armour_light_winter_tabard_pattern_embroidered_pattern_yellow_green",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 216,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_winter_tabard_pattern_embroidered_pattern_yellow_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.07, 0.234, 0.21),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.4, 0.42, 0.107),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_orange_split_vertical = {
		ui_description = "armour_light_winter_tabard_pattern_orange_split_vertical_description",
		name = "armour_light_winter_tabard_pattern_orange_split_vertical",
		team_pattern_u = 0.5,
		market_price = 20000,
		unlock_key = 217,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_orange_split_vertical_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.2, 0.03, 0),
		team_pattern_tint_secondary = Vector3Box(2.1, 1.1, 0.1)
	},
	pattern_winter_gray_white = {
		ui_description = "armour_light_winter_abard_pattern_winter_gray_white_description",
		name = "armour_light_winter_tabard_pattern_winter_gray_white",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 218,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_winter_tabard_pattern_winter_gray_white_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.117, 0.141, 0.123),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_winter_white = {
		ui_description = "armour_light_winter_tabard_pattern_winter_white_description",
		name = "armour_light_winter_tabard_pattern_winter_white",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 219,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_winter_white_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(1, 1, 1)
	},
	pattern_winter_gray = {
		ui_description = "armour_light_winter_tabard_pattern_winter_gray_description",
		name = "armour_light_winter_tabard_pattern_winter_gray",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 220,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_light_winter_tabard_pattern_winter_gray_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.217, 0.241, 0.223),
		personal_pattern_tint_secondary = Vector3Box(0.117, 0.141, 0.123),
		team_pattern_tint_primary = Vector3Box(0.117, 0.141, 0.123),
		team_pattern_tint_secondary = Vector3Box(0.217, 0.241, 0.223)
	}
}
LightJuiponPatterns = {
	pattern_standard = {
		ui_description = "armour_light_juipon_pattern_standard_white_description",
		name = "armour_light_juipon_pattern_standard_white",
		team_pattern_u = 0,
		unlock_key = 150,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_standard_white_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_yellow_blue_hosen_dirt = {
		ui_description = "armour_light_juipon_pattern_yellow_blue_hosen_dirt_description",
		name = "armour_light_juipon_pattern_yellow_blue_hosen_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 151,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_yellow_blue_hosen_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.432, 0.337, 0.08),
		team_pattern_tint_secondary = Vector3Box(0.06, 0.151, 0.367)
	},
	pattern_yellow_black_dirt = {
		ui_description = "armour_light_juipon_pattern_yellow_black_dirt_description",
		name = "armour_light_juipon_pattern_yellow_black_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 152,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_yellow_black_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 5),
		team_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.432, 0.337, 0.08)
	},
	pattern_red_dirt = {
		ui_description = "armour_light_juipon_pattern_red_dirt_description",
		name = "armour_light_juipon_pattern_red_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 153,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_red_dirt_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.196, 0.035, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.364, 0.043, 0.01),
		team_pattern_tint_secondary = Vector3Box(0.176, 0.01, 0)
	},
	pattern_brown_green_hosen_dirt = {
		ui_description = "armour_light_juipon_pattern_brown_green_hosen_dirt_description",
		name = "armour_light_juipon_pattern_brown_green_hosen_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 154,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_brown_green_hosen_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.043, 0.177, 0.043),
		team_pattern_tint_secondary = Vector3Box(0.071, 0.071, 0.026)
	},
	pattern_red_white_hosen_dirt = {
		ui_description = "armour_light_juipon_pattern_red_white_hosen_dirt_description",
		name = "armour_light_juipon_pattern_red_white_hosen_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 155,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_red_white_hosen_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.241, 0.035, 0),
		team_pattern_tint_secondary = Vector3Box(0.579, 0.727, 1)
	},
	pattern_red_blue_green_hosen_dirt = {
		ui_description = "armour_light_juipon_pattern_red_blue_green_hosen_dirt_description",
		name = "armour_light_juipon_pattern_red_blue_green_hosen_dirt",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 156,
		release_name = "sherwood",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_juipon_pattern_red_blue_green_hosen_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.065, 0.116, 0),
		team_pattern_tint_primary = Vector3Box(0.116, 0.03, 0),
		team_pattern_tint_secondary = Vector3Box(0.05, 0.131, 0.307)
	},
	pattern_gray_blood = {
		ui_description = "armour_light_juipon_pattern_gray_blood_description",
		name = "armour_light_juipon_pattern_gray_blood",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 157,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_gray_blood_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.196, 0.01, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.081, 0.129, 0.234),
		team_pattern_tint_secondary = Vector3Box(0.191, 0.239, 0.388)
	},
	pattern_beige_brown_dirt = {
		ui_description = "armour_light_juipon_pattern_beige_brown_dirt_description",
		name = "armour_light_juipon_pattern_beige_brown_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 158,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_beige_brown_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.25, 0.25, 0.25),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.101, 0.055, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_blue_green_yellow_dirt = {
		ui_description = "armour_light_juipon_pattern_blue_green_yellow_dirt_description",
		name = "armour_light_juipon_pattern_blue_green_yellow_dirt",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 159,
		release_name = "sherwood",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_juipon_pattern_blue_green_yellow_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.072, 0.23, 0.766),
		team_pattern_tint_primary = Vector3Box(0.432, 0.263, 0),
		team_pattern_tint_secondary = Vector3Box(0.121, 0.186, 0.02)
	},
	pattern_green_dirt = {
		ui_description = "armour_light_juipon_pattern_green_dirt_description",
		name = "armour_light_juipon_pattern_green_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 160,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_green_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.307, 0.161, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.176, 0.241, 0.07),
		team_pattern_tint_secondary = Vector3Box(0.033, 0.129, 0.053)
	},
	pattern_blue_dirt = {
		ui_description = "armour_light_juipon_pattern_blue_dirt_description",
		name = "armour_light_juipon_pattern_blue_dirt",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 161,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_blue_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.101, 0.161, 0.628),
		team_pattern_tint_secondary = Vector3Box(0.206, 0.271, 0.77)
	},
	pattern_black_dirt = {
		ui_description = "armour_light_juipon_pattern_black_dirt_description",
		name = "armour_light_juipon_pattern_black_dirt",
		team_pattern_u = 0,
		market_price = 200000,
		unlock_key = 162,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_black_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		team_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05)
	},
	pattern_beige_brown_gray = {
		ui_description = "armour_light_juipon_pattern_beige_brown_gray_description",
		name = "armour_light_juipon_pattern_beige_brown_gray",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 163,
		release_name = "sherwood",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_juipon_pattern_beige_brown_gray_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.4, 0.4),
		team_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.077, 0.048, 0.043)
	},
	pattern_orange_green_dirt = {
		ui_description = "armour_light_juipon_pattern_orange_green_dirt_description",
		name = "armour_light_juipon_pattern_orange_green_dirt",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 164,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_orange_green_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.241, 0.151, 0),
		team_pattern_tint_secondary = Vector3Box(0.04, 0.117, 0.015)
	},
	pattern_brown_dirt = {
		ui_description = "armour_light_juipon_pattern_brown_dirt_description",
		name = "armour_light_juipon_pattern_brown_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 165,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_brown_dirt_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.148, 0.105, 0.086),
		team_pattern_tint_secondary = Vector3Box(0.201, 0.215, 0.258)
	},
	pattern_brown_white_black = {
		ui_description = "armour_light_juipon_pattern_brown_white_black_description",
		name = "armour_light_juipon_pattern_brown_white_black",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 166,
		release_name = "sherwood",
		personal_pattern_v = 0.5,
		ui_header = "armour_light_juipon_pattern_brown_white_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.133, 0.071, 0.039),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.378, 0.478, 0.77),
		team_pattern_tint_secondary = Vector3Box(0.07, 0.08, 0.1)
	},
	pattern_blue_white_dirt = {
		ui_description = "armour_light_juipon_pattern_blue_white_dirt_description",
		name = "armour_light_juipon_pattern_blue_white_dirt",
		team_pattern_u = 0.5,
		market_price = 100000,
		unlock_key = 167,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_blue_white_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.3, 0.3, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.077, 0.196, 0.847),
		team_pattern_tint_secondary = Vector3Box(0.297, 0.44, 0.828)
	},
	pattern_blue_black_dirt = {
		ui_description = "armour_light_juipon_pattern_blue_black_dirt_description",
		name = "armour_light_juipon_pattern_blue_black_dirt",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 168,
		release_name = "sherwood",
		personal_pattern_v = 0,
		ui_header = "armour_light_juipon_pattern_blue_black_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.043, 0.1, 0.421)
	}
}
MediumPatterns = {
	pattern_rusted = {
		ui_description = "armour_medium_tights_pattern_rusted_description",
		name = "armour_medium_tights_pattern_rusted",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 32,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_rusted_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17)
	},
	pattern_white_preorder = {
		ui_description = "armour_medium_tights_pattern_white_preorder_description",
		name = "armour_medium_tights_pattern_white_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 33,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_white_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(0.4, 0.4, 0.9),
		team_pattern_tint_secondary = Vector3Box(1, 1, 1),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_red_preorder = {
		ui_description = "armour_medium_tights_pattern_red_preorder_description",
		name = "armour_medium_tights_pattern_red_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 34,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_red_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.215, 0.225, 0.24),
		personal_pattern_tint_secondary = Vector3Box(0.215, 0.225, 0.24),
		team_pattern_tint_primary = Vector3Box(0.215, 0.225, 0.24),
		team_pattern_tint_secondary = Vector3Box(1, 0.025, 0.05),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_standard = {
		ui_description = "armour_medium_tights_pattern_standard_description",
		name = "armour_medium_tights_pattern_standard",
		team_pattern_u = 0,
		unlock_key = 35,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_standard_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.78, 0.36, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.78, 0.36, 0.17),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_brown = {
		ui_description = "armour_medium_tights_pattern_brown_description",
		name = "armour_medium_tights_pattern_brown",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 37,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_brown_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17)
	},
	pattern_black = {
		ui_description = "armour_medium_tights_pattern_black_description",
		name = "armour_medium_tights_pattern_black",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 38,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.11, 0.112, 0.11),
		personal_pattern_tint_secondary = Vector3Box(0.11, 0.112, 0.11),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_blued_metal = {
		ui_description = "armour_medium_tights_pattern_blued_metal_description",
		name = "armour_medium_tights_pattern_blued_metal",
		team_pattern_u = 0,
		market_price = 200000,
		unlock_key = 39,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_blued_metal_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.315, 0.325, 0.34),
		personal_pattern_tint_secondary = Vector3Box(0.415, 0.425, 0.44),
		team_pattern_tint_primary = Vector3Box(0.415, 0.425, 0.44),
		team_pattern_tint_secondary = Vector3Box(0.065, 0.085, 0.27)
	},
	pattern_green = {
		ui_description = "armour_medium_tights_pattern_green_description",
		name = "armour_medium_tights_pattern_green",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 40,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.23, 0.5, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.23, 0.5, 0.3),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.33, 0.5, 0.4)
	},
	pattern_red = {
		ui_description = "armour_medium_tights_pattern_red_description",
		name = "armour_medium_tights_pattern_red",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 41,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_red_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.97, 0.33, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.97, 0.33, 0.2),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.97, 0.33, 0.2)
	},
	pattern_red_blue = {
		ui_description = "armour_medium_tights_pattern_red_blue_pattern_description",
		name = "armour_medium_tights_pattern_red_blue_pattern",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 42,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_red_blue_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.12, 0.33, 0.98),
		personal_pattern_tint_secondary = Vector3Box(0.9, 0.45, 0.4),
		team_pattern_tint_primary = Vector3Box(0.12, 0.33, 0.98),
		team_pattern_tint_secondary = Vector3Box(0.12, 0.33, 0.98)
	},
	pattern_mixedcolor = {
		ui_description = "armour_medium_tights_pattern_mixedcolor_pattern_description",
		name = "armour_medium_tights_pattern_mixedcolor_pattern",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 43,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_mixedcolor_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.23, 0.5, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.23, 0.5, 0.3),
		team_pattern_tint_primary = Vector3Box(0.016, 0.016, 0.013),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_brown_black = {
		ui_description = "armour_medium_tights_pattern_brown_black_pattern_description",
		name = "armour_medium_tights_pattern_brown_black_pattern",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 44,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_brown_black_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_primary = Vector3Box(0.016, 0.016, 0.013),
		team_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17)
	},
	pattern_blue_black = {
		ui_description = "armour_medium_tights_pattern_blue_black_pattern_description",
		name = "armour_medium_tights_pattern_blue_black_pattern",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 45,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_blue_black_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.5, 0.8),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.8),
		team_pattern_tint_primary = Vector3Box(0.016, 0.016, 0.013),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.8)
	},
	pattern_polished = {
		ui_description = "armour_medium_tights_pattern_polished_description",
		name = "armour_medium_tights_pattern_polished",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 46,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_medium_tights_pattern_polished_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_green_square = {
		ui_description = "armour_medium_tights_pattern_red_green_square_pattern_description",
		name = "armour_medium_tights_pattern_red_green_square_pattern",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 47,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_red_green_square_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.76, 0.24, 0.19),
		personal_pattern_tint_secondary = Vector3Box(0.76, 0.24, 0.19),
		team_pattern_tint_primary = Vector3Box(0.23, 0.6, 0.3),
		team_pattern_tint_secondary = Vector3Box(0.23, 0.6, 0.3)
	},
	pattern_red_green_split = {
		ui_description = "armour_medium_tights_pattern_red_green_split_description",
		name = "armour_medium_tights_pattern_red_green_split",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 48,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_red_green_split_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.76, 0.24, 0.19),
		personal_pattern_tint_secondary = Vector3Box(0.23, 0.6, 0.3),
		team_pattern_tint_primary = Vector3Box(0.76, 0.24, 0.19),
		team_pattern_tint_secondary = Vector3Box(0.33, 0.7, 0.4)
	},
	pattern_black_blue_split = {
		ui_description = "armour_medium_tights_pattern_black_blue_split_description",
		name = "armour_medium_tights_pattern_black_blue_split",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 49,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_black_blue_split_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.11, 0.112, 0.11),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.7),
		team_pattern_tint_primary = Vector3Box(0.11, 0.112, 0.11),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.7)
	},
	pattern_black_blue_split_vertical = {
		ui_description = "armour_medium_tights_pattern_black_blue_split_vertical_description",
		name = "armour_medium_tights_pattern_black_blue_split_vertical",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 50,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_black_blue_split_vertical_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.5, 0.7),
		personal_pattern_tint_secondary = Vector3Box(0.11, 0.112, 0.11),
		team_pattern_tint_primary = Vector3Box(0.11, 0.112, 0.11),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.7)
	},
	pattern_orange_split_vertical = {
		ui_description = "armour_medium_tights_pattern_orange_split_vertical_description",
		name = "armour_medium_tights_pattern_orange_split_vertical",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 73,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_tights_pattern_orange_split_vertical_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1.27, 0.3, 0.1),
		personal_pattern_tint_secondary = Vector3Box(2.2, 1.2, 0.2),
		team_pattern_tint_primary = Vector3Box(2.2, 1.2, 0.2),
		team_pattern_tint_secondary = Vector3Box(1.27, 0.3, 0.1)
	}
}
MediumWinterPatterns = {
	pattern_standard = {
		ui_description = "armour_medium_winter_tights_pattern_standard_description",
		name = "armour_medium_winter_tights_pattern_standard",
		team_pattern_u = 0,
		unlock_key = 223,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_standard_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.78, 0.36, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.78, 0.36, 0.17),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_white_preorder = {
		ui_description = "armour_medium_winter_tights_pattern_white_preorder_description",
		name = "armour_medium_winter_tights_pattern_white_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 221,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_white_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(0.4, 0.4, 0.9),
		team_pattern_tint_secondary = Vector3Box(1, 1, 1),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_red_preorder = {
		ui_description = "armour_medium_winter_tights_pattern_red_preorder_description",
		name = "armour_medium_winter_tights_pattern_red_preorder",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 222,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_red_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.215, 0.225, 0.24),
		personal_pattern_tint_secondary = Vector3Box(0.215, 0.225, 0.24),
		team_pattern_tint_primary = Vector3Box(0.215, 0.225, 0.24),
		team_pattern_tint_secondary = Vector3Box(1, 0.025, 0.05),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_rusted = {
		ui_description = "armour_medium_winter_tights_pattern_rusted_description",
		name = "armour_medium_winter_tights_pattern_rusted",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 239,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_rusted_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17)
	},
	pattern_brown = {
		ui_description = "armour_medium_winter_tights_pattern_brown_description",
		name = "armour_medium_winter_tights_pattern_brown",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 224,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_brown_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17)
	},
	pattern_black = {
		ui_description = "armour_medium_winter_tights_pattern_black_description",
		name = "armour_medium_winter_tights_pattern_black",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 225,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.11, 0.112, 0.11),
		personal_pattern_tint_secondary = Vector3Box(0.11, 0.112, 0.11),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_blued_metal = {
		ui_description = "armour_medium_winter_tights_pattern_blued_metal_description",
		name = "armour_medium_winter_tights_pattern_blued_metal",
		team_pattern_u = 0,
		market_price = 200000,
		unlock_key = 226,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_blued_metal_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.315, 0.325, 0.34),
		personal_pattern_tint_secondary = Vector3Box(0.415, 0.425, 0.44),
		team_pattern_tint_primary = Vector3Box(0.415, 0.425, 0.44),
		team_pattern_tint_secondary = Vector3Box(0.065, 0.085, 0.27)
	},
	pattern_green = {
		ui_description = "armour_medium_winter_tights_pattern_green_description",
		name = "armour_medium_winter_tights_pattern_green",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 227,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.23, 0.5, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.23, 0.5, 0.3),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.33, 0.5, 0.4)
	},
	pattern_red = {
		ui_description = "armour_medium_winter_tights_pattern_red_description",
		name = "armour_medium_winter_tights_pattern_red",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 228,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_red_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.97, 0.33, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.97, 0.33, 0.2),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.97, 0.33, 0.2)
	},
	pattern_red_blue = {
		ui_description = "armour_medium_winter_tights_pattern_red_blue_pattern_description",
		name = "armour_medium_winter_tights_pattern_red_blue_pattern",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 229,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_red_blue_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.12, 0.33, 0.98),
		personal_pattern_tint_secondary = Vector3Box(0.9, 0.45, 0.4),
		team_pattern_tint_primary = Vector3Box(0.12, 0.33, 0.98),
		team_pattern_tint_secondary = Vector3Box(0.12, 0.33, 0.98)
	},
	pattern_mixedcolor = {
		ui_description = "armour_medium_winter_tights_pattern_mixedcolor_pattern_description",
		name = "armour_medium_winter_tights_pattern_mixedcolor_pattern",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 230,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_mixedcolor_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.23, 0.5, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.23, 0.5, 0.3),
		team_pattern_tint_primary = Vector3Box(0.016, 0.016, 0.013),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_brown_black = {
		ui_description = "armour_medium_winter_tights_pattern_brown_black_pattern_description",
		name = "armour_medium_winter_tights_pattern_brown_black_pattern",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 231,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_brown_black_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_primary = Vector3Box(0.016, 0.016, 0.013),
		team_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17)
	},
	pattern_blue_black = {
		ui_description = "armour_medium_winter_tights_pattern_blue_black_pattern_description",
		name = "armour_medium_winter_tights_pattern_blue_black_pattern",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 232,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_blue_black_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.5, 0.8),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.8),
		team_pattern_tint_primary = Vector3Box(0.016, 0.016, 0.013),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.8)
	},
	pattern_polished = {
		ui_description = "armour_medium_winter_tights_pattern_polished_description",
		name = "armour_medium_winter_tights_pattern_polished",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 233,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_polished_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_green_square = {
		ui_description = "armour_medium_winter_tights_pattern_red_green_square_pattern_description",
		name = "armour_medium_winter_tights_pattern_red_green_square_pattern",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 234,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_red_green_square_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.76, 0.24, 0.19),
		personal_pattern_tint_secondary = Vector3Box(0.76, 0.24, 0.19),
		team_pattern_tint_primary = Vector3Box(0.23, 0.6, 0.3),
		team_pattern_tint_secondary = Vector3Box(0.23, 0.6, 0.3)
	},
	pattern_red_green_split = {
		ui_description = "armour_medium_winter_tights_pattern_red_green_split_description",
		name = "armour_medium_winter_tights_pattern_red_green_split",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 235,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_red_green_split_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.76, 0.24, 0.19),
		personal_pattern_tint_secondary = Vector3Box(0.23, 0.6, 0.3),
		team_pattern_tint_primary = Vector3Box(0.76, 0.24, 0.19),
		team_pattern_tint_secondary = Vector3Box(0.33, 0.7, 0.4)
	},
	pattern_black_blue_split = {
		ui_description = "armour_medium_winter_tights_pattern_black_blue_split_description",
		name = "armour_medium_winter_tights_pattern_black_blue_split",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 236,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_black_blue_split_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.11, 0.112, 0.11),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.7),
		team_pattern_tint_primary = Vector3Box(0.11, 0.112, 0.11),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.7)
	},
	pattern_black_blue_split_vertical = {
		ui_description = "armour_medium_winter_tights_pattern_black_blue_split_vertical_description",
		name = "armour_medium_winter_tights_pattern_black_blue_split_vertical",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 237,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_black_blue_split_vertical_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.5, 0.7),
		personal_pattern_tint_secondary = Vector3Box(0.11, 0.112, 0.11),
		team_pattern_tint_primary = Vector3Box(0.11, 0.112, 0.11),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.5, 0.7)
	},
	pattern_orange_split_vertical = {
		ui_description = "armour_medium_winter_tights_pattern_orange_split_vertical_description",
		name = "armour_medium_winter_tights_pattern_orange_split_vertical",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 238,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_orange_split_vertical_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1.27, 0.3, 0.1),
		personal_pattern_tint_secondary = Vector3Box(2.2, 1.2, 0.2),
		team_pattern_tint_primary = Vector3Box(2.2, 1.2, 0.2),
		team_pattern_tint_secondary = Vector3Box(1.27, 0.3, 0.1)
	},
	pattern_worn_gray = {
		ui_description = "armour_medium_winter_tights_pattern_worn_gray_description",
		name = "armour_medium_winter_tights_pattern_worn_gray",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 240,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_worn_gray_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.45, 0.45, 0.45),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_white_gray = {
		ui_description = "armour_medium_winter_tights_pattern_white_gray_pattern_description",
		name = "armour_medium_winter_tights_pattern_white_gray_pattern",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 241,
		release_name = "winter",
		personal_pattern_v = 0,
		ui_header = "armour_medium_winter_tights_pattern_white_gray_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.2),
		team_pattern_tint_primary = Vector3Box(2, 2, 2),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.2)
	},
	pattern_half_white = {
		ui_description = "armour_medium_winter_tights_pattern_half_white_pattern_description",
		name = "armour_medium_winter_tights_pattern_half_white_pattern",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 242,
		release_name = "winter",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_winter_tights_pattern_half_white_pattern_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(2, 2, 2),
		personal_pattern_tint_secondary = Vector3Box(2, 2, 2),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(1, 1, 1)
	}
}
HeavyPatterns = {
	pattern_standard = {
		ui_description = "armour_heavy_fullplate_pattern_standard_description",
		name = "armour_heavy_fullplate_pattern_standard",
		team_pattern_u = 0,
		unlock_key = 51,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_fullplate_pattern_standard_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.3, 0.17, 0.03),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.16, 0.05, 0.02),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_worn_polished_black = {
		ui_description = "armour_heavy_fullplate_pattern_painted_worn_polished_black_description",
		name = "armour_heavy_fullplate_pattern_painted_worn_polished_black",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 52,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_fullplate_pattern_painted_worn_polished_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_cross = {
		ui_description = "armour_heavy_fullplate_pattern_red_cross_description",
		name = "armour_heavy_fullplate_pattern_red_cross",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 53,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_red_cross_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.25, 0, 0.01),
		team_pattern_tint_secondary = Vector3Box(0.25, 0, 0.01)
	},
	pattern_gilded_royal = {
		ui_description = "armour_heavy_fullplate_pattern_gilded_royal_description",
		name = "armour_heavy_fullplate_pattern_gilded_royal",
		team_pattern_u = 0,
		market_price = 200000,
		unlock_key = 54,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_gilded_royal_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.9, 0.7, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.9, 0.7, 0.3),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_knight = {
		ui_description = "armour_heavy_fullplate_pattern_red_knight_description",
		name = "armour_heavy_fullplate_pattern_red_knight",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 55,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_red_knight_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.1, 0.1),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_black_and_blue = {
		ui_description = "armour_heavy_fullplate_pattern_black_and_blue_description",
		name = "armour_heavy_fullplate_pattern_black_and_blue",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 56,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_black_and_blue_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.45, 0.6, 0.75),
		personal_pattern_tint_secondary = Vector3Box(0.45, 0.6, 0.75),
		team_pattern_tint_primary = Vector3Box(0.02, 0.02, 0.02),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_black_as_knight = {
		ui_description = "armour_heavy_fullplate_pattern_black_as_knight_description",
		name = "armour_heavy_fullplate_pattern_black_as_knight",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 57,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_black_as_knight_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.12),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_blued_metal = {
		ui_description = "armour_heavy_fullplate_pattern_blued_metal_description",
		name = "armour_heavy_fullplate_pattern_blued_metal",
		team_pattern_u = 0,
		market_price = 500000,
		unlock_key = 58,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_fullplate_pattern_blued_metal_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.065, 0.085, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.065, 0.085, 0.17),
		team_pattern_tint_primary = Vector3Box(0.065, 0.085, 0.17),
		team_pattern_tint_secondary = Vector3Box(0.065, 0.085, 0.17)
	},
	pattern_green_knight = {
		ui_description = "armour_heavy_fullplate_pattern_green_knight_description",
		name = "armour_heavy_fullplate_pattern_green_knight",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 59,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_green_knight_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.32, 0.27),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_brown_knight = {
		ui_description = "armour_heavy_fullplate_pattern_brown_knight_description",
		name = "armour_heavy_fullplate_pattern_brown_knight",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 60,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_brown_knight_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.24, 0.16, 0.07),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_legs = {
		ui_description = "armour_heavy_fullplate_pattern_red_legs_description",
		name = "armour_heavy_fullplate_pattern_red_legs",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 61,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_red_legs_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.3, 0.42, 0.57),
		personal_pattern_tint_secondary = Vector3Box(0.47, 0.22, 0.22),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_green = {
		ui_description = "armour_heavy_fullplate_pattern_red_and_green_description",
		name = "armour_heavy_fullplate_pattern_red_and_green",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 62,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_red_and_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.63, 0.34, 0.26),
		personal_pattern_tint_secondary = Vector3Box(0.63, 0.34, 0.26),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.18, 0.77, 0.56)
	},
	pattern_red_black = {
		ui_description = "armour_heavy_fullplate_pattern_red_and_black_description",
		name = "armour_heavy_fullplate_pattern_red_and_black",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 63,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_red_and_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.7, 0.3, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.04, 0.03, 0.04),
		team_pattern_tint_primary = Vector3Box(0.03, 0.3, 0.01),
		team_pattern_tint_secondary = Vector3Box(0.18, 0.77, 0.56)
	},
	pattern_fires_of_hell = {
		ui_description = "armour_heavy_fullplate_pattern_fires_of_hell_description",
		name = "armour_heavy_fullplate_pattern_fires_of_hell",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 64,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_fires_of_hell_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.48, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.4, 0.08, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_nightfire = {
		ui_description = "armour_heavy_fullplate_pattern_nightfire_description",
		name = "armour_heavy_fullplate_pattern_nightfire",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 65,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_nightfire_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.12, 0.14, 0.15),
		personal_pattern_tint_secondary = Vector3Box(0.51, 0.116, 0),
		team_pattern_tint_primary = Vector3Box(0.8, 0.72, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_green_and_black = {
		ui_description = "armour_heavy_fullplate_green_and_black_description",
		team_pattern_u = 0,
		name = "armour_heavy_fullplate_pattern_green_and_black",
		market_price = 20000,
		unlock_key = 66,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_green_and_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.848, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.848, 0),
		team_pattern_tint_primary = Vector3Box(0.04, 0.08, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.04, 0.08, 0.05)
	},
	pattern_red_preorder = {
		ui_description = "armour_heavy_fullplate_red_preorder_description",
		team_pattern_u = 0,
		name = "armour_heavy_fullplate_pattern_red_preorder",
		market_price = 50000,
		unlock_key = 67,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_red_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0.5,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.45, 0.0715, 0.0715),
		personal_pattern_tint_secondary = Vector3Box(0.45, 0.0715, 0.0715),
		team_pattern_tint_primary = Vector3Box(0.07, 0.1, 0.055),
		team_pattern_tint_secondary = Vector3Box(0.37, 0.18, 0.03),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_white_preorder = {
		ui_description = "armour_heavy_fullplate_pattern_white_preorder_description",
		team_pattern_u = 0,
		name = "armour_heavy_fullplate_white_preorder",
		market_price = 50000,
		unlock_key = 68,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_white_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0.5,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(0.07, 0.1, 0.055),
		team_pattern_tint_secondary = Vector3Box(0.07, 0.1, 0.055),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_worn_and_repainted = {
		ui_description = "armour_heavy_fullplate_pattern_worn_and_repainted_description",
		name = "armour_heavy_fullplate_pattern_worn_and_repainted",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 69,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_worn_and_repainted_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.36, 0.29, 0.12),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.36, 0.29, 0.12),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_bloodflames = {
		ui_description = "armour_heavy_fullplate_pattern_bloodflames_description",
		name = "armour_heavy_fullplate_pattern_bloodflames",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 70,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_bloodflames_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.22, 0.33, 0.44),
		personal_pattern_tint_secondary = Vector3Box(0.96, 0.48, 0.49),
		team_pattern_tint_primary = Vector3Box(0.28, 0.08, 0.06),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_polished_black = {
		ui_description = "armour_heavy_fullplate_pattern_painted_worn_polished_black_description",
		name = "armour_heavy_fullplate_pattern_painted_worn_polished_black",
		team_pattern_u = 0,
		market_price = 120000,
		unlock_key = 71,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_fullplate_pattern_painted_worn_polished_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.37, 0.18, 0.03),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.11, 0.12, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_polished_green = {
		ui_description = "armour_heavy_fullplate_pattern_painted_worn_polished_green_description",
		name = "armour_heavy_fullplate_pattern_painted_worn_polished_green",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 72,
		release_name = "main",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_fullplate_pattern_painted_worn_polished_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.37, 0.18, 0.03),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.05, 0.74, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_orange_split_vertical = {
		ui_description = "armour_heavy_fullplate_pattern_orange_split_vertical_description",
		name = "armour_heavy_fullplate_pattern_orange_split_vertical",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 74,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_orange_split_vertical_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1.17, 0.2, 0),
		personal_pattern_tint_secondary = Vector3Box(2.1, 1.1, 0.1),
		team_pattern_tint_primary = Vector3Box(2.1, 1.1, 0.1),
		team_pattern_tint_secondary = Vector3Box(1.17, 0.2, 0)
	},
	pattern_solid_black = {
		ui_description = "armour_heavy_fullplate_pattern_solid_black_description",
		name = "armour_heavy_fullplate_pattern_solid_black",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 320,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_solid_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		personal_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05)
	}
}
HeavyMilanesePatterns = {
	pattern_standard = {
		ui_description = "armour_heavy_milanese_pattern_standard_description",
		name = "armour_heavy_milanese_pattern_standard",
		team_pattern_u = 0,
		unlock_key = 97,
		release_name = "hospitaller",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_milanese_pattern_standard_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.3, 0.17, 0.03),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.16, 0.05, 0.02),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_worn_polished_black = {
		ui_description = "armour_heavy_milanese_pattern_painted_worn_polished_black_description",
		name = "armour_heavy_milanese_pattern_painted_worn_polished_black",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 98,
		release_name = "hospitaller",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_milanese_pattern_painted_worn_polished_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_cross = {
		ui_description = "armour_heavy_milanese_pattern_red_cross_description",
		name = "armour_heavy_milanese_pattern_red_cross",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 76,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_red_cross_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.25, 0, 0.01),
		team_pattern_tint_secondary = Vector3Box(0.25, 0, 0.01)
	},
	pattern_alternating_yellows = {
		ui_description = "armour_heavy_milanese_pattern_gilded_royal_description",
		name = "armour_heavy_milanese_pattern_gilded_royal",
		team_pattern_u = 0,
		market_price = 200000,
		unlock_key = 77,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_gilded_royal_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.9, 0.7, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.9, 0.7, 0.3),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_knight = {
		ui_description = "armour_heavy_milanese_pattern_red_knight_description",
		name = "armour_heavy_milanese_pattern_red_knight",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 78,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_red_knight_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.1, 0.1),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_black_and_blue = {
		ui_description = "armour_heavy_milanese_pattern_black_and_blue_description",
		name = "armour_heavy_milanese_pattern_black_and_blue",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 79,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_black_and_blue_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.45, 0.6, 0.75),
		personal_pattern_tint_secondary = Vector3Box(0.45, 0.6, 0.75),
		team_pattern_tint_primary = Vector3Box(0.02, 0.02, 0.02),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_black_as_knight = {
		ui_description = "armour_heavy_milanese_pattern_black_as_knight_description",
		name = "armour_heavy_milanese_pattern_black_as_knight",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 80,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_black_as_knight_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.12),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_blued_metal = {
		ui_description = "armour_heavy_milanese_pattern_blued_metal_description",
		name = "armour_heavy_milanese_pattern_blued_metal",
		team_pattern_u = 0,
		market_price = 500000,
		unlock_key = 81,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_milanese_pattern_blued_metal_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.065, 0.085, 0.17),
		personal_pattern_tint_secondary = Vector3Box(0.065, 0.085, 0.17),
		team_pattern_tint_primary = Vector3Box(0.065, 0.085, 0.17),
		team_pattern_tint_secondary = Vector3Box(0.065, 0.085, 0.17)
	},
	pattern_green_knight = {
		ui_description = "armour_heavy_milanese_pattern_green_knight_description",
		name = "armour_heavy_milanese_pattern_green_knight",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 82,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_green_knight_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.32, 0.27),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_brown_knight = {
		ui_description = "armour_heavy_milanese_pattern_brown_knight_description",
		name = "armour_heavy_milanese_pattern_brown_knight",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 83,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_brown_knight_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.24, 0.16, 0.07),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_alternating_reds = {
		ui_description = "armour_heavy_milanese_pattern_red_legs_description",
		name = "armour_heavy_milanese_pattern_red_legs",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 84,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_red_legs_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.3, 0.42, 0.57),
		personal_pattern_tint_secondary = Vector3Box(0.47, 0.22, 0.22),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_green = {
		ui_description = "armour_heavy_milanese_pattern_red_and_green_description",
		name = "armour_heavy_milanese_pattern_red_and_green",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 85,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_red_and_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.63, 0.34, 0.26),
		personal_pattern_tint_secondary = Vector3Box(0.63, 0.34, 0.26),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.18, 0.77, 0.56)
	},
	pattern_red_black = {
		ui_description = "armour_heavy_milanese_pattern_red_and_black_description",
		name = "armour_heavy_milanese_pattern_red_and_black",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 86,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_red_and_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.7, 0.3, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.04, 0.03, 0.04),
		team_pattern_tint_primary = Vector3Box(0.03, 0.3, 0.01),
		team_pattern_tint_secondary = Vector3Box(0.18, 0.77, 0.56)
	},
	pattern_alternating_yellows = {
		ui_description = "armour_heavy_milanese_pattern_fires_of_hell_description",
		name = "armour_heavy_milanese_pattern_fires_of_hell",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 99,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_fires_of_hell_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.48, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.4, 0.08, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_alternating_blues = {
		ui_description = "armour_heavy_milanese_pattern_nightfire_description",
		name = "armour_heavy_milanese_pattern_nightfire",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 88,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_nightfire_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.12, 0.14, 0.15),
		personal_pattern_tint_secondary = Vector3Box(0.51, 0.116, 0),
		team_pattern_tint_primary = Vector3Box(0.8, 0.72, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_green_and_black = {
		ui_description = "armour_heavy_milanese_green_and_black_description",
		team_pattern_u = 0,
		name = "armour_heavy_milanese_pattern_green_and_black",
		market_price = 20000,
		unlock_key = 89,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_green_and_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.848, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.848, 0),
		team_pattern_tint_primary = Vector3Box(0.04, 0.08, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.04, 0.08, 0.05)
	},
	pattern_red_preorder = {
		ui_description = "armour_heavy_milanese_red_preorder_description",
		team_pattern_u = 0,
		name = "armour_heavy_milanese_pattern_red_preorder",
		market_price = 50000,
		unlock_key = 90,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_red_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.45, 0.0715, 0.0715),
		personal_pattern_tint_secondary = Vector3Box(0.45, 0.0715, 0.0715),
		team_pattern_tint_primary = Vector3Box(0.07, 0.1, 0.055),
		team_pattern_tint_secondary = Vector3Box(0.37, 0.18, 0.03),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_white_preorder = {
		ui_description = "armour_heavy_milanese_pattern_white_preorder_description",
		team_pattern_u = 0,
		name = "armour_heavy_milanese_white_preorder",
		market_price = 50000,
		unlock_key = 91,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_white_preorder_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(0.07, 0.1, 0.055),
		team_pattern_tint_secondary = Vector3Box(0.07, 0.1, 0.055),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_worn_and_repainted = {
		ui_description = "armour_heavy_milanese_pattern_worn_and_repainted_description",
		name = "armour_heavy_milanese_pattern_worn_and_repainted",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 92,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_worn_and_repainted_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.36, 0.29, 0.12),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.36, 0.29, 0.12),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_alternating_greens = {
		ui_description = "armour_heavy_milanese_pattern_bloodflames_description",
		name = "armour_heavy_milanese_pattern_bloodflames",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 93,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_bloodflames_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.22, 0.33, 0.44),
		personal_pattern_tint_secondary = Vector3Box(0.96, 0.48, 0.49),
		team_pattern_tint_primary = Vector3Box(0.28, 0.08, 0.06),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_polished_black = {
		ui_description = "armour_heavy_milanese_pattern_painted_worn_polished_black_description",
		name = "armour_heavy_milanese_pattern_painted_worn_polished_black",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 94,
		release_name = "hospitaller",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_milanese_pattern_painted_worn_polished_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.37, 0.18, 0.03),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.11, 0.12, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_polished_green = {
		ui_description = "armour_heavy_milanese_pattern_painted_worn_polished_green_description",
		name = "armour_heavy_milanese_pattern_painted_worn_polished_green",
		team_pattern_u = 0,
		market_price = 132000,
		unlock_key = 95,
		release_name = "hospitaller",
		personal_pattern_v = 0.5,
		ui_header = "armour_heavy_milanese_pattern_painted_worn_polished_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.37, 0.18, 0.03),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.05, 0.74, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_alternating_oranges = {
		ui_description = "armour_heavy_milanese_pattern_orange_split_vertical_description",
		name = "armour_heavy_milanese_pattern_orange_split_vertical",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 96,
		release_name = "hospitaller",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_milanese_pattern_orange_split_vertical_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1.17, 0.2, 0),
		personal_pattern_tint_secondary = Vector3Box(2.1, 1.1, 0.1),
		team_pattern_tint_primary = Vector3Box(2.1, 1.1, 0.1),
		team_pattern_tint_secondary = Vector3Box(1.17, 0.2, 0)
	},
	pattern_solid_black = {
		ui_description = "armour_heavy_fullplate_pattern_solid_black_description",
		name = "armour_heavy_fullplate_pattern_solid_black",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 320,
		release_name = "main",
		personal_pattern_v = 0,
		ui_header = "armour_heavy_fullplate_pattern_solid_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		personal_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05)
	}
}
MediumBrigandinePatterns = {
	pattern_rusted = {
		ui_description = "armour_medium_brigandine_pattern_rusted_description",
		name = "armour_medium_brigandine_pattern_rusted",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 117,
		release_name = "burgundy",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_brigandine_pattern_rusted_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.155, 0.05, 0),
		personal_pattern_tint_secondary = Vector3Box(0.155, 0.05, 0),
		team_pattern_tint_primary = Vector3Box(0.187, 0.045, 0),
		team_pattern_tint_secondary = Vector3Box(0.187, 0.045, 0)
	},
	pattern_white_preorder = {
		ui_description = "armour_medium_brigandine_pattern_white_preorder_description",
		name = "armour_medium_brigandine_pattern_white_preorder",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 118,
		release_name = "burgundy",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_brigandine_pattern_white_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(1, 1, 1),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_red_preorder = {
		ui_description = "armour_medium_brigandine_pattern_red_preorder_description",
		name = "armour_medium_brigandine_pattern_red_preorder",
		team_pattern_u = 0,
		market_price = 100000,
		unlock_key = 116,
		release_name = "burgundy",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_brigandine_pattern_red_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.005, 0),
		personal_pattern_tint_secondary = Vector3Box(0.2, 0.005, 0),
		team_pattern_tint_primary = Vector3Box(0.2, 0.005, 0),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.005, 0),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_standard = {
		ui_description = "armour_medium_brigandine_pattern_standard_description",
		name = "armour_medium_brigandine_pattern_standard",
		team_pattern_u = 0,
		unlock_key = 100,
		release_name = "burgundy",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_brigandine_pattern_standard_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.155, 0.05, 0),
		team_pattern_tint_primary = Vector3Box(0.187, 0.045, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_brown = {
		ui_description = "armour_medium_brigandine_pattern_brown_description",
		name = "armour_medium_brigandine_pattern_brown",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 101,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_brown_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.145, 0.127, 0.095),
		team_pattern_tint_primary = Vector3Box(0.05, 0.027, 0.009),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_black = {
		ui_description = "armour_medium_brigandine_pattern_black_description",
		name = "armour_medium_brigandine_pattern_black",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 102,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.005, 0.005, 0.005),
		personal_pattern_tint_secondary = Vector3Box(0.01, 0.01, 0.01),
		team_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_secondary = Vector3Box(0, 0, 0)
	},
	pattern_blued_metal = {
		ui_description = "armour_medium_brigandine_pattern_blued_metal_description",
		name = "armour_medium_brigandine_pattern_blued_metal",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 103,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_blued_metal_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.166, 0.315, 1),
		team_pattern_tint_primary = Vector3Box(0.054, 0.116, 0.336),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_green = {
		ui_description = "armour_medium_brigandine_pattern_green_description",
		name = "armour_medium_brigandine_pattern_green",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 104,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.034, 0.149, 0.01),
		team_pattern_tint_primary = Vector3Box(0.115, 0.38, 0),
		team_pattern_tint_secondary = Vector3Box(0.034, 0.149, 0.01)
	},
	pattern_red_white = {
		ui_description = "armour_medium_brigandine_pattern_red_white_description",
		name = "armour_medium_brigandine_pattern_red_white",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 105,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_red_white_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.291, 0, 0),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_blue = {
		ui_description = "armour_medium_brigandine_pattern_red_blue_pattern_description",
		name = "armour_medium_brigandine_pattern_red_blue_pattern",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 106,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_red_blue_pattern_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.072, 0.139, 0.462),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.115, 0, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_blue_green = {
		ui_description = "armour_medium_brigandine_pattern_blue_green_description",
		name = "armour_medium_brigandine_pattern_blue_green",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 107,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_blue_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.016, 0.37, 0),
		team_pattern_tint_primary = Vector3Box(0.082, 0.082, 0.688),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_brown_black = {
		ui_description = "armour_medium_brigandine_pattern_brown_black_description",
		name = "armour_medium_brigandine_pattern_brown_black",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 108,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_brown_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_primary = Vector3Box(0.064, 0.03, 0.02),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_blue_black = {
		ui_description = "armour_medium_brigandine_pattern_blue_black_description",
		name = "armour_medium_brigandine_pattern_blue_black",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 109,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_blue_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		personal_pattern_tint_secondary = Vector3Box(0.099, 0.222, 0.616),
		team_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.099, 0.222, 0.616)
	},
	pattern_polished = {
		ui_description = "armour_medium_brigandine_pattern_polished_description",
		name = "armour_medium_brigandine_pattern_polished",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 110,
		release_name = "burgundy",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_brigandine_pattern_polished_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.3, 0.3, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.3, 0.3, 0.3)
	},
	pattern_red_green_square = {
		ui_description = "armour_medium_brigandine_pattern_red_green_square_description",
		name = "armour_medium_brigandine_pattern_red_green_square",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 111,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_red_green_square_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.438, 0, 0),
		team_pattern_tint_primary = Vector3Box(0, 0.167, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_green_split = {
		ui_description = "armour_medium_brigandine_pattern_red_green_split_description",
		name = "armour_medium_brigandine_pattern_red_green_split",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 112,
		release_name = "burgundy",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_brigandine_pattern_red_green_split_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.246, 0, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0, 0.335, 0)
	},
	pattern_black_blue = {
		ui_description = "armour_medium_brigandine_pattern_black_blue_description",
		name = "armour_medium_brigandine_pattern_black_blue",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 113,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_black_blue_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0, 0.094, 0.488),
		team_pattern_tint_primary = Vector3Box(0.005, 0.005, 0.005),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_black_blue_split = {
		ui_description = "armour_medium_brigandine_pattern_black_blue_split_description",
		name = "armour_medium_brigandine_pattern_black_blue_split",
		team_pattern_u = 0,
		market_price = 20000,
		unlock_key = 114,
		release_name = "burgundy",
		personal_pattern_v = 0.5,
		ui_header = "armour_medium_brigandine_pattern_black_blue_split_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.005, 0.005, 0.005),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0, 0.074, 0.419)
	},
	pattern_orange = {
		ui_description = "armour_medium_brigandine_pattern_orange_description",
		name = "armour_medium_brigandine_pattern_orange",
		team_pattern_u = 0,
		market_price = 10000,
		unlock_key = 115,
		release_name = "burgundy",
		personal_pattern_v = 0,
		ui_header = "armour_medium_brigandine_pattern_orange_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(1, 0.246, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	}
}
GalloglassPatterns = {
	pattern_standard = {
		ui_description = "armour_galloglass_standard_description",
		name = "armour_galloglass_standard",
		team_pattern_u = 0,
		unlock_key = 119,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_standard_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0, 0, 0),
		team_pattern_tint_primary = Vector3Box(0.766, 0.766, 0.646),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.2)
	},
	pattern_whole_blue_dirt = {
		ui_description = "armour_galloglass_whole_blue_dirt_description",
		name = "armour_galloglass_whole_blue_dirt",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 120,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_whole_blue_dirt_header",
		personal_pattern_u = 0,
		team_pattern_v = 0.5,
		personal_pattern_tint_primary = Vector3Box(0.053, 0.11, 0.498),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.4, 0.4),
		team_pattern_tint_primary = Vector3Box(0.282, 0.077, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_whole_red_dirt = {
		ui_description = "armour_galloglass_whole_red_dirt_description",
		name = "armour_galloglass_whole_red_dirt",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 121,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_whole_red_dirt_header",
		personal_pattern_u = 0,
		team_pattern_v = 0.5,
		personal_pattern_tint_primary = Vector3Box(0.282, 0.077, 0),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.4, 0.4),
		team_pattern_tint_primary = Vector3Box(0.282, 0.077, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_whole_green_dirt = {
		ui_description = "armour_galloglass_whole_green_dirt_description",
		name = "armour_galloglass_whole_green_dirt",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 122,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_whole_green_dirt_header",
		personal_pattern_u = 0,
		team_pattern_v = 0.5,
		personal_pattern_tint_primary = Vector3Box(0.077, 0.33, 0),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.4, 0.4),
		team_pattern_tint_primary = Vector3Box(0.282, 0.077, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_whole_white_rust_dirt = {
		ui_description = "armour_galloglass_whole_white_rust_dirt_description",
		name = "armour_galloglass_whole_white_rust_dirt",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 123,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_galloglass_whole_white_rust_dirt_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0, 0, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.416, 0.158, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_diamond_white_black_dirt = {
		ui_description = "armour_galloglass_diamond_white_black_dirt_description",
		name = "armour_galloglass_diamond_white_black_dirt",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 124,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_galloglass_diamond_white_black_dirt_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.116, 0.0058, 0),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.1)
	},
	pattern_diamond_yellow_red = {
		ui_description = "armour_galloglass_diamond_yellow_red_description",
		name = "armour_galloglass_diamond_yellow_red",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 125,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_galloglass_diamond_yellow_red_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.234, 0.15, 0.15),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.809, 0.057, 0),
		team_pattern_tint_secondary = Vector3Box(0.904, 0.5306, 0)
	},
	pattern_diamond_yellow_blue = {
		ui_description = "armour_galloglass_diamond_yellow_blue_description",
		name = "armour_galloglass_diamond_yellow_blue",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 126,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_galloglass_diamond_yellow_blue_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.234, 0.15, 0.15),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0, 0.1, 0.88),
		team_pattern_tint_secondary = Vector3Box(0.904, 0.5306, 0)
	},
	pattern_half_black_chain_black = {
		ui_description = "armour_galloglass_half_black_chain_black_description",
		name = "armour_galloglass_half_black_chain_black",
		team_pattern_u = 0.5,
		market_price = 500000,
		unlock_key = 127,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_half_black_chain_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0, 0, 0),
		team_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.25, 0.25, 0.25)
	},
	pattern_half_yellow_chain_black = {
		ui_description = "armour_galloglass_half_yellow_chain_black_description",
		name = "armour_galloglass_half_yellow_chain_black",
		team_pattern_u = 0.5,
		market_price = 50000,
		unlock_key = 128,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_half_yellow_chain_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0, 0, 0),
		team_pattern_tint_primary = Vector3Box(1, 0.742, 0),
		team_pattern_tint_secondary = Vector3Box(0.852, 0.402, 0)
	},
	pattern_half_white_grey_chain_black = {
		ui_description = "armour_galloglass_half_white_grey_chain_black_description",
		name = "armour_galloglass_half_white_grey_chain_black",
		team_pattern_u = 0.5,
		market_price = 50000,
		unlock_key = 129,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_half_white_grey_chain_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0, 0, 0),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.2)
	},
	pattern_half_black_chain_black_polished = {
		ui_description = "armour_galloglass_half_black_chain_black_polished_description",
		name = "armour_galloglass_half_black_chain_black_polished",
		team_pattern_u = 0.5,
		market_price = 200000,
		unlock_key = 130,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_half_black_chain_black_polished_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0, 0, 0),
		team_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.1)
	},
	pattern_half_white_chain_polished = {
		ui_description = "armour_galloglass_half_white_chain_polished_description",
		name = "armour_galloglass_half_white_chain_polished",
		team_pattern_u = 0.5,
		market_price = 50000,
		unlock_key = 131,
		release_name = "scottish",
		personal_pattern_v = 0,
		ui_header = "armour_galloglass_half_white_chain_polished_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.8, 0.8, 0.8)
	},
	pattern_diamond_grey_chain_black_torned = {
		ui_description = "armour_galloglass_diamond_grey_chain_black_torned_description",
		name = "armour_galloglass_diamond_grey_chain_black_torned",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 132,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_galloglass_diamond_grey_chain_black_torned_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_primary = Vector3Box(0.25, 0.25, 0.25),
		team_pattern_tint_secondary = Vector3Box(0.35, 0.35, 0.35)
	},
	pattern_diamond_red_green_chain_black_torned = {
		ui_description = "armour_galloglass_diamond_red_green_chain_black_torned_description",
		name = "armour_galloglass_diamond_red_green_chain_black_torned",
		team_pattern_u = 0,
		market_price = 50000,
		unlock_key = 133,
		release_name = "scottish",
		personal_pattern_v = 0.5,
		ui_header = "armour_galloglass_diamond_red_green_chain_black_torned_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_primary = Vector3Box(0.282, 0.077, 0),
		team_pattern_tint_secondary = Vector3Box(0.077, 0.33, 0)
	}
}
Armours = {
	armour_light_peasant_rags = {
		category = "light",
		ui_texture = "armour_light_peasant_rags",
		encumbrance = 5,
		armour_type = "armour_cloth",
		release_name = "main",
		voice = "commoner",
		market_price = 20000,
		penetration_value = 0,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_peasant_ai",
		ui_description = "armour_description_light_peasant_rags",
		absorption_value = 0.05,
		ui_fluff_text = "armour_fluff_light_peasant_rags",
		ui_sort_index = 2,
		husk_voice = "commoner_husk",
		ui_header = "armour_name_light_peasant_rags",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_peasant",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_peasant_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 0,
				absorption_value = 0.05,
				armour_type = "armour_cloth"
			},
			stomach = {
				penetration_value = 0,
				absorption_value = 0.05,
				armour_type = "armour_cloth"
			},
			arms = {
				penetration_value = 0,
				absorption_value = 0.05,
				armour_type = "armour_cloth"
			},
			forearms = {
				penetration_value = 0,
				absorption_value = 0.05,
				armour_type = "armour_cloth"
			},
			hands = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			calfs = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.05,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_light_peasant_rags_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				PeasantPatterns.pattern_standard,
				PeasantPatterns.pattern_white_preorder,
				PeasantPatterns.pattern_red_preorder,
				PeasantPatterns.pattern_coal_miner,
				PeasantPatterns.pattern_fifty_fifty,
				PeasantPatterns.pattern_rags_red,
				PeasantPatterns.pattern_rags_green,
				PeasantPatterns.pattern_rags_brown,
				PeasantPatterns.pattern_rags_blue,
				PeasantPatterns.pattern_pig_wrestler,
				PeasantPatterns.pattern_red_undershirt,
				PeasantPatterns.pattern_green_undershirt,
				PeasantPatterns.pattern_rags_mixed_01,
				PeasantPatterns.pattern_rags_mixed_02
			}
		},
		meshes = PEASANT_MESHES,
		preview_unit_meshes = PEASANT_MESHES_PREVIEW
	},
	armour_light_juipon = {
		category = "light",
		ui_texture = "armour_light_juipon",
		encumbrance = 4.5,
		armour_type = "armour_cloth",
		release_name = "sherwood",
		voice = "commoner",
		market_price = 50000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_light_juipon_ai",
		ui_description = "armour_description_light_juipon",
		absorption_value = 0.15,
		ui_fluff_text = "armour_fluff_light_juipon",
		ui_sort_index = 20,
		husk_voice = "commoner_husk",
		ui_header = "armour_name_light_juipon",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_light_juipon",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_light_juipon_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			forearms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_light_juipon_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				LightJuiponPatterns.pattern_standard,
				LightJuiponPatterns.pattern_yellow_blue_hosen_dirt,
				LightJuiponPatterns.pattern_yellow_black_dirt,
				LightJuiponPatterns.pattern_red_dirt,
				LightJuiponPatterns.pattern_brown_green_hosen_dirt,
				LightJuiponPatterns.pattern_red_white_hosen_dirt,
				LightJuiponPatterns.pattern_red_blue_green_hosen_dirt,
				LightJuiponPatterns.pattern_gray_blood,
				LightJuiponPatterns.pattern_beige_brown_dirt,
				LightJuiponPatterns.pattern_blue_green_yellow_dirt,
				LightJuiponPatterns.pattern_green_dirt,
				LightJuiponPatterns.pattern_blue_dirt,
				LightJuiponPatterns.pattern_black_dirt,
				LightJuiponPatterns.pattern_beige_brown_gray,
				LightJuiponPatterns.pattern_orange_green_dirt,
				LightJuiponPatterns.pattern_brown_dirt,
				LightJuiponPatterns.pattern_brown_white_black,
				LightJuiponPatterns.pattern_blue_white_dirt,
				LightJuiponPatterns.pattern_blue_black_dirt
			}
		},
		meshes = LIGHT_JUIPON_MESHES,
		preview_unit_meshes = LIGHT_JUIPON_MESHES_PREVIEW
	},
	armour_light_tabard = {
		category = "light",
		ui_texture = "armour_light_tabard",
		encumbrance = 8.5,
		armour_type = "armour_cloth",
		release_name = "main",
		voice = "commoner",
		market_price = 20000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_light_ai",
		ui_description = "armour_description_light_tabard",
		absorption_value = 0.1,
		ui_fluff_text = "armour_fluff_light_tabard",
		ui_sort_index = 1,
		husk_voice = "commoner_husk",
		ui_header = "armour_name_light_tabard",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_light",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_light_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_mail"
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_mail"
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			forearms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_light_tabard_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				LightTabardPatterns.pattern_standard,
				LightTabardPatterns.pattern_white_preorder,
				LightTabardPatterns.pattern_red_preorder,
				LightTabardPatterns.pattern_standard_red,
				LightTabardPatterns.pattern_standard_green,
				LightTabardPatterns.pattern_standard_black,
				LightTabardPatterns.pattern_standard_blue,
				LightTabardPatterns.pattern_red_blue_blocks,
				LightTabardPatterns.pattern_green_white_blocks,
				LightTabardPatterns.pattern_square_red_white,
				LightTabardPatterns.pattern_square_black_green,
				LightTabardPatterns.pattern_square_blue_yellow,
				LightTabardPatterns.pattern_divide_yellow_blue,
				LightTabardPatterns.pattern_divide_black_red,
				LightTabardPatterns.pattern_divide_black_yellow,
				LightTabardPatterns.pattern_white_blue,
				LightTabardPatterns.pattern_yellow_green,
				LightTabardPatterns.pattern_orange_split_vertical
			}
		},
		meshes = LIGHT_MESHES,
		preview_unit_meshes = LIGHT_MESHES_PREVIEW
	},
	armour_light_winter_tabard = {
		category = "light",
		ui_texture = "armour_medium_winter",
		encumbrance = 8,
		armour_type = "armour_cloth",
		release_name = "winter",
		voice = "commoner",
		market_price = 50000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_light_winter_ai",
		ui_description = "armour_towton_light_winter_tabard_description",
		absorption_value = 0.1,
		ui_fluff_text = "armour_towton_light_winter_tabard_fluff",
		ui_sort_index = 5,
		husk_voice = "commoner_husk",
		ui_header = "armour_towton_light_winter_tabard_name",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_light_winter",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_light_winter_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.3,
				armour_type = "armour_mail"
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.3,
				armour_type = "armour_mail"
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_light_winter_tabard_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				LightTabardWinterPatterns.pattern_standard,
				LightTabardWinterPatterns.pattern_white_preorder,
				LightTabardWinterPatterns.pattern_red_preorder,
				LightTabardWinterPatterns.pattern_standard_red,
				LightTabardWinterPatterns.pattern_standard_green,
				LightTabardWinterPatterns.pattern_standard_black,
				LightTabardWinterPatterns.pattern_standard_blue,
				LightTabardWinterPatterns.pattern_red_blue_blocks,
				LightTabardWinterPatterns.pattern_green_white_blocks,
				LightTabardWinterPatterns.pattern_square_red_white,
				LightTabardWinterPatterns.pattern_square_black_green,
				LightTabardWinterPatterns.pattern_square_blue_yellow,
				LightTabardWinterPatterns.pattern_divide_yellow_blue,
				LightTabardWinterPatterns.pattern_divide_black_red,
				LightTabardWinterPatterns.pattern_divide_black_yellow,
				LightTabardWinterPatterns.pattern_white_blue,
				LightTabardWinterPatterns.pattern_yellow_green,
				LightTabardWinterPatterns.pattern_orange_split_vertical,
				LightTabardWinterPatterns.pattern_winter_gray_white,
				LightTabardWinterPatterns.pattern_winter_white,
				LightTabardWinterPatterns.pattern_winter_gray
			}
		},
		meshes = LIGHT_WINTER_MESHES,
		preview_unit_meshes = LIGHT_WINTER_MESHES_PREVIEW
	},
	armour_italian = {
		category = "light",
		ui_texture = "italian_armour",
		encumbrance = 8.5,
		armour_type = "armour_cloth",
		release_name = "italian",
		voice = "commoner",
		market_price = 100000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_italian_ai",
		ui_description = "armour_italian_light_armour_description",
		absorption_value = 0.1,
		ui_fluff_text = "armour_italian_light_armour_fluff",
		ui_sort_index = 60,
		husk_voice = "commoner_husk",
		ui_header = "armour_italian_light_armour_name",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_italian",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_italian_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_cloth"
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_cloth"
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			forearms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_italian_light_armour_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				MediumBrigandinePatterns.pattern_standard,
				MediumBrigandinePatterns.pattern_white_preorder,
				MediumBrigandinePatterns.pattern_red_preorder,
				MediumBrigandinePatterns.pattern_rusted,
				MediumBrigandinePatterns.pattern_brown,
				MediumBrigandinePatterns.pattern_black,
				MediumBrigandinePatterns.pattern_blued_metal,
				MediumBrigandinePatterns.pattern_green,
				MediumBrigandinePatterns.pattern_red_white,
				MediumBrigandinePatterns.pattern_blue_green,
				MediumBrigandinePatterns.pattern_brown_black,
				MediumBrigandinePatterns.pattern_blue_black,
				MediumBrigandinePatterns.pattern_polished,
				MediumBrigandinePatterns.pattern_red_green_square,
				MediumBrigandinePatterns.pattern_red_green_split,
				MediumBrigandinePatterns.pattern_black_blue,
				MediumBrigandinePatterns.pattern_black_blue_split,
				MediumBrigandinePatterns.pattern_orange
			}
		},
		meshes = ITALIAN_MESHES,
		preview_unit_meshes = ITALIAN_MESHES_PREVIEW,
		extra_coat_of_arms = {
			material = "heraldry_projection_back",
			mesh = "g_heraldry_back_projection"
		}
	},
	armour_medium_tights = {
		ui_description = "armour_description_medium_tights",
		absorption_value = 0.25,
		encumbrance = 11.25,
		category = "medium",
		armour_type = "armour_cloth",
		ui_texture = "armour_medium_tights",
		ui_fluff_text = "armour_fluff_medium_tights",
		voice = "commoner",
		husk_voice = "commoner_husk",
		ui_header = "armour_name_medium_tights",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium_preview",
		penetration_value = 15,
		ui_sort_index = 1,
		release_name = "main",
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium_ai",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate",
				back = {
					penetration_value = 15,
					absorption_value = 0.3,
					armour_type = "armour_mail"
				}
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate",
				back = {
					penetration_value = 15,
					absorption_value = 0.3,
					armour_type = "armour_mail"
				}
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			forearms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			legs = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			calfs = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_medium_tights_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				MediumPatterns.pattern_standard,
				MediumPatterns.pattern_white_preorder,
				MediumPatterns.pattern_red_preorder,
				MediumPatterns.pattern_rusted,
				MediumPatterns.pattern_brown,
				MediumPatterns.pattern_black,
				MediumPatterns.pattern_blued_metal,
				MediumPatterns.pattern_green,
				MediumPatterns.pattern_red,
				MediumPatterns.pattern_mixedcolor,
				MediumPatterns.pattern_brown_black,
				MediumPatterns.pattern_blue_black,
				MediumPatterns.pattern_polished,
				MediumPatterns.pattern_red_green_square,
				MediumPatterns.pattern_red_green_split,
				MediumPatterns.pattern_black_blue_split,
				MediumPatterns.pattern_black_blue_split_vertical,
				MediumPatterns.pattern_orange_split_vertical
			}
		},
		meshes = MEDIUM_MESHES,
		preview_unit_meshes = MEDIUM_MESHES_PREVIEW
	},
	armour_medium_winter_tights = {
		category = "medium",
		ui_texture = "armour_light_winter",
		encumbrance = 13.25,
		armour_type = "armour_cloth",
		release_name = "winter",
		voice = "commoner",
		market_price = 50000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium_winter_ai",
		ui_description = "armour_towton_medium_winter_tights_description",
		absorption_value = 0.25,
		ui_fluff_text = "armour_towton_medium_winter_tights_fluff",
		ui_sort_index = 5,
		husk_voice = "commoner_husk",
		ui_header = "armour_towton_medium_winter_tights_name",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium_winter",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium_winter_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate",
				back = {
					penetration_value = 15,
					absorption_value = 0.3,
					armour_type = "armour_mail"
				}
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate",
				back = {
					penetration_value = 15,
					absorption_value = 0.3,
					armour_type = "armour_mail"
				}
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			legs = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate",
				back = {
					penetration_value = 15,
					absorption_value = 0.1,
					armour_type = "armour_cloth"
				}
			},
			calfs = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_medium_winter_tights_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				MediumWinterPatterns.pattern_standard,
				MediumWinterPatterns.pattern_white_preorder,
				MediumWinterPatterns.pattern_red_preorder,
				MediumWinterPatterns.pattern_rusted,
				MediumWinterPatterns.pattern_brown,
				MediumWinterPatterns.pattern_black,
				MediumWinterPatterns.pattern_blued_metal,
				MediumWinterPatterns.pattern_green,
				MediumWinterPatterns.pattern_red,
				MediumWinterPatterns.pattern_mixedcolor,
				MediumWinterPatterns.pattern_brown_black,
				MediumWinterPatterns.pattern_blue_black,
				MediumWinterPatterns.pattern_polished,
				MediumWinterPatterns.pattern_red_green_square,
				MediumWinterPatterns.pattern_red_green_split,
				MediumWinterPatterns.pattern_black_blue_split,
				MediumWinterPatterns.pattern_black_blue_split_vertical,
				MediumWinterPatterns.pattern_orange_split_vertical,
				MediumWinterPatterns.pattern_worn_gray,
				MediumWinterPatterns.pattern_white_gray,
				MediumWinterPatterns.pattern_half_white
			}
		},
		meshes = MEDIUM_WINTER_MESHES,
		preview_unit_meshes = MEDIUM_WINTER_MESHES_PREVIEW
	},
	armour_medium_brigandine = {
		category = "medium",
		ui_texture = "armour_medium_brigandine",
		encumbrance = 16,
		armour_type = "armour_cloth",
		release_name = "burgundy",
		voice = "commoner",
		market_price = 100000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium_brigandine_ai",
		ui_description = "armour_burgundy_medium_brigandine_description",
		absorption_value = 0.3,
		ui_fluff_text = "armour_burgundy_medium_brigandine_fluff",
		ui_sort_index = 40,
		husk_voice = "commoner_husk",
		ui_header = "armour_burgundy_medium_brigandine_name",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium_brigandine",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_medium_brigandine_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate"
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate"
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			forearms = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			legs = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			calfs = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_medium_brigandine_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				MediumBrigandinePatterns.pattern_standard,
				MediumBrigandinePatterns.pattern_white_preorder,
				MediumBrigandinePatterns.pattern_red_preorder,
				MediumBrigandinePatterns.pattern_rusted,
				MediumBrigandinePatterns.pattern_brown,
				MediumBrigandinePatterns.pattern_black,
				MediumBrigandinePatterns.pattern_blued_metal,
				MediumBrigandinePatterns.pattern_green,
				MediumBrigandinePatterns.pattern_red_white,
				MediumBrigandinePatterns.pattern_blue_green,
				MediumBrigandinePatterns.pattern_brown_black,
				MediumBrigandinePatterns.pattern_blue_black,
				MediumBrigandinePatterns.pattern_polished,
				MediumBrigandinePatterns.pattern_red_green_square,
				MediumBrigandinePatterns.pattern_red_green_split,
				MediumBrigandinePatterns.pattern_black_blue,
				MediumBrigandinePatterns.pattern_black_blue_split,
				MediumBrigandinePatterns.pattern_orange
			}
		},
		meshes = MEDIUM_BRIGANDINE_MESHES,
		preview_unit_meshes = MEDIUM_BRIGANDINE_MESHES_PREVIEW
	},
	armour_galloglass = {
		category = "medium",
		ui_texture = "armour_medium_gallowglass",
		encumbrance = 9.5,
		armour_type = "armour_cloth",
		release_name = "scottish",
		voice = "commoner",
		market_price = 50000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_galloglass_ai",
		ui_description = "armour_galloglass_mail_description",
		absorption_value = 0.3,
		ui_fluff_text = "armour_galloglass_mail_fluff",
		ui_sort_index = 10,
		husk_voice = "commoner_husk",
		ui_header = "armour_galloglass_mail_name",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_galloglass",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_galloglass_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.3,
				armour_type = "armour_mail"
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.3,
				armour_type = "armour_mail"
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			forearms = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			legs = {
				penetration_value = 15,
				absorption_value = 0.3,
				armour_type = "armour_mail",
				back = {
					penetration_value = 15,
					absorption_value = 0.1,
					armour_type = "armour_cloth"
				}
			},
			calfs = {
				penetration_value = 15,
				absorption_value = 0.1,
				armour_type = "armour_cloth"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_galloglass_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				GalloglassPatterns.pattern_standard,
				GalloglassPatterns.pattern_whole_blue_dirt,
				GalloglassPatterns.pattern_whole_red_dirt,
				GalloglassPatterns.pattern_whole_green_dirt,
				GalloglassPatterns.pattern_whole_white_rust_dirt,
				GalloglassPatterns.pattern_diamond_white_black_dirt,
				GalloglassPatterns.pattern_diamond_yellow_red,
				GalloglassPatterns.pattern_diamond_yellow_blue,
				GalloglassPatterns.pattern_half_black_chain_black,
				GalloglassPatterns.pattern_half_yellow_chain_black,
				GalloglassPatterns.pattern_half_white_grey_chain_black,
				GalloglassPatterns.pattern_half_black_chain_black_polished,
				GalloglassPatterns.pattern_half_white_chain_polished,
				GalloglassPatterns.pattern_diamond_grey_chain_black_torned,
				GalloglassPatterns.pattern_diamond_red_green_chain_black_torned
			}
		},
		meshes = GALLOGLASS_MESHES,
		preview_unit_meshes = GALLOGLASS_MESHES_PREVIEW
	},
	armour_medium_swiss = {
		category = "medium",
		ui_texture = "armour_swiss",
		encumbrance = 11.25,
		armour_type = "armour_cloth",
		release_name = "swiss",
		voice = "commoner",
		market_price = 100000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_swiss_ai",
		ui_description = "gear_swiss_medium_armour_desc",
		absorption_value = 0.25,
		ui_fluff_text = "gear_swiss_medium_armour_fluff",
		ui_sort_index = 11,
		husk_voice = "commoner_husk",
		ui_header = "gear_swiss_medium_armour_name",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_swiss",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_swiss_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			},
			torso = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate",
				back = {
					penetration_value = 15,
					absorption_value = 0.3,
					armour_type = "armour_mail"
				}
			},
			stomach = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate",
				back = {
					penetration_value = 15,
					absorption_value = 0.3,
					armour_type = "armour_mail"
				}
			},
			arms = {
				penetration_value = 15,
				absorption_value = 0.3,
				armour_type = "armour_mail"
			},
			forearms = {
				penetration_value = 15,
				absorption_value = 0.3,
				armour_type = "armour_mail"
			},
			hands = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			legs = {
				penetration_value = 15,
				absorption_value = 0.6,
				armour_type = "armour_plate"
			},
			calfs = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			},
			feet = {
				penetration_value = 15,
				absorption_value = 0.2,
				armour_type = "armour_leather"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "gear_swiss_medium_armour_name",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				MediumPatterns.pattern_standard,
				MediumPatterns.pattern_white_preorder,
				MediumPatterns.pattern_red_preorder,
				MediumPatterns.pattern_rusted,
				MediumPatterns.pattern_brown,
				MediumPatterns.pattern_black,
				MediumPatterns.pattern_blued_metal,
				MediumPatterns.pattern_green,
				MediumPatterns.pattern_red,
				MediumPatterns.pattern_mixedcolor,
				MediumPatterns.pattern_brown_black,
				MediumPatterns.pattern_blue_black,
				MediumPatterns.pattern_polished,
				MediumPatterns.pattern_red_green_square,
				MediumPatterns.pattern_red_green_split,
				MediumPatterns.pattern_black_blue_split,
				MediumPatterns.pattern_black_blue_split_vertical,
				MediumPatterns.pattern_orange_split_vertical
			}
		},
		meshes = SWISS_MESHES,
		preview_unit_meshes = SWISS_MESHES_PREVIEW
	},
	armour_heavy_fullplate = {
		category = "heavy",
		ui_texture = "armour_heavy_fullplate",
		encumbrance = 25,
		armour_type = "armour_plate",
		release_name = "main",
		voice = "noble",
		market_price = 20000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_heavy_ai",
		ui_description = "armour_description_heavy_fullplate",
		absorption_value = 0.6,
		ui_fluff_text = "armour_fluff_heavy_fullplate",
		ui_sort_index = 1,
		husk_voice = "noble_husk",
		ui_header = "armour_name_heavy_fullplate",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_heavy",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_heavy_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_heavy_fullplate_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				HeavyPatterns.pattern_standard,
				HeavyPatterns.pattern_worn_polished_black,
				HeavyPatterns.pattern_red_cross,
				HeavyPatterns.pattern_gilded_royal,
				HeavyPatterns.pattern_red_knight,
				HeavyPatterns.pattern_black_and_blue,
				HeavyPatterns.pattern_black_as_knight,
				HeavyPatterns.pattern_blued_metal,
				HeavyPatterns.pattern_green_knight,
				HeavyPatterns.pattern_brown_knight,
				HeavyPatterns.pattern_red_legs,
				HeavyPatterns.pattern_red_green,
				HeavyPatterns.pattern_red_black,
				HeavyPatterns.pattern_fires_of_hell,
				HeavyPatterns.pattern_nightfire,
				HeavyPatterns.pattern_green_and_black,
				HeavyPatterns.pattern_red_preorder,
				HeavyPatterns.pattern_white_preorder,
				HeavyPatterns.pattern_worn_and_repainted,
				HeavyPatterns.pattern_bloodflames,
				HeavyPatterns.pattern_polished_black,
				HeavyPatterns.pattern_polished_green,
				HeavyPatterns.pattern_orange_split_vertical,
				HeavyPatterns.pattern_solid_black
			}
		},
		meshes = HEAVY_MESHES,
		preview_unit_meshes = HEAVY_MESHES_PREVIEW
	},
	armour_heavy_milanese = {
		category = "heavy",
		ui_texture = "armour_heavy_milanese",
		encumbrance = 25,
		armour_type = "armour_plate",
		release_name = "hospitaller",
		voice = "noble",
		market_price = 50000,
		penetration_value = 15,
		ai_unit = "units/beings/chr_wotr_man/chr_wotr_man_heavy_milanese_ai",
		ui_description = "armour_description_heavy_milanese",
		absorption_value = 0.6,
		ui_fluff_text = "armour_fluff_heavy_milanese",
		ui_sort_index = 10,
		husk_voice = "noble_husk",
		ui_header = "armour_name_heavy_milanese",
		player_unit = "units/beings/chr_wotr_man/chr_wotr_man_heavy_milanese",
		preview_unit = "units/beings/chr_wotr_man/chr_wotr_man_heavy_milanese_preview",
		hit_zones = {
			head = {
				penetration_value = 0,
				absorption_value = 0,
				armour_type = "none"
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					y = 190
				}
			},
			camera_position = Vector3Box(0, 1, 1.15)
		},
		attachments = {
			{
				ui_header = "armour_heavy_milanese_patterns_header",
				menu_page_type = "text",
				category = "patterns"
			}
		},
		attachment_definitions = {
			patterns = {
				HeavyMilanesePatterns.pattern_standard,
				HeavyMilanesePatterns.pattern_worn_polished_black,
				HeavyMilanesePatterns.pattern_red_cross,
				HeavyMilanesePatterns.pattern_alternating_yellows,
				HeavyMilanesePatterns.pattern_red_knight,
				HeavyMilanesePatterns.pattern_black_and_blue,
				HeavyMilanesePatterns.pattern_black_as_knight,
				HeavyMilanesePatterns.pattern_blued_metal,
				HeavyMilanesePatterns.pattern_green_knight,
				HeavyMilanesePatterns.pattern_brown_knight,
				HeavyMilanesePatterns.pattern_alternating_reds,
				HeavyMilanesePatterns.pattern_red_green,
				HeavyMilanesePatterns.pattern_red_black,
				HeavyMilanesePatterns.pattern_alternating_yellows,
				HeavyMilanesePatterns.pattern_alternating_blues,
				HeavyMilanesePatterns.pattern_green_and_black,
				HeavyMilanesePatterns.pattern_red_preorder,
				HeavyMilanesePatterns.pattern_white_preorder,
				HeavyMilanesePatterns.pattern_worn_and_repainted,
				HeavyMilanesePatterns.pattern_alternating_greens,
				HeavyMilanesePatterns.pattern_polished_black,
				HeavyMilanesePatterns.pattern_polished_green,
				HeavyMilanesePatterns.pattern_alternating_oranges,
				HeavyMilanesePatterns.pattern_solid_black
			}
		},
		meshes = HEAVY_MILANESE_MESHES,
		preview_unit_meshes = HEAVY_MILANESE_MESHES_PREVIEW
	}
}

local attachment_to_key = {}

for armour_name, props in pairs(Armours) do
	for cat_name, category in pairs(props.attachment_definitions) do
		for _, attachment in pairs(category) do
			attachment_to_key[attachment.name] = attachment.unlock_key
		end
	end

	local meshes = props.meshes

	fassert(meshes, "Missing meshes in armour: %s", armour_name)

	local preview_meshes = props.preview_unit_meshes

	fassert(preview_meshes, "Missing preview_unit_meshes in armour: %s", armour_name)
	fassert(props.ui_header, "Missing ui_header in armour: %s", armour_name)
	fassert(props.ui_description, "Missing ui_description in armour: %s", armour_name)
	fassert(props.ui_fluff_text, "Missing ui_fluff_text in armour: %s", armour_name)
	fassert(props.ui_texture, "Missing ui_texture in armour: %s", armour_name)
	fassert(props.ui_sort_index, "Missing ui_sort_index in armour: %s", armour_name)
	fassert(props.category, "Missing category in armour: %s", armour_name)
end

local key_to_attachment = {}

for attachment_name, unlock_key in pairs(attachment_to_key) do
	if key_to_attachment[unlock_key] then
		local colliding_attachment = table.find(attachment_to_key, unlock_key)

		ferror("Attachment %q with key %d collides with %q", attachment_name, unlock_key, colliding_attachment)
	end

	key_to_attachment[unlock_key] = true
end

key_to_attachment = nil
attachment_to_key = nil

function default_armour_attachment_unlocks()
	local default_unlocks = {}

	for armour_name, props in pairs(Armours) do
		for _, categories in pairs(props.attachment_definitions) do
			for index, attachment in pairs(categories) do
				if attachment.unlock_this_item ~= false and (index == 1 or attachment.required_dlc) then
					local entity_type = "armour_attachment"
					local entity_name = armour_name .. "|" .. attachment.unlock_key

					default_unlocks[entity_type .. "|" .. entity_name] = {
						category = entity_type,
						name = entity_name,
						attachment = attachment
					}
				end
			end
		end
	end

	return default_unlocks
end
