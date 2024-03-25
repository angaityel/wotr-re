-- chunkname: @scripts/settings/material_effect_mappings.lua

MaterialEffectSettings = {
	material_query_depth = 0.4,
	blood_splat_raycast_max_range = 3,
	footstep_raycast_max_range = 0.2,
	material_contexts = {
		surface_material = {
			"stone",
			"wood_solid",
			"wood_hollow",
			"metal_solid",
			"metal_hollow",
			"dirt",
			"water",
			"cloth",
			"fruit",
			"plaster",
			"window",
			"hay",
			"snow",
			"ice",
			"sand",
			"grass"
		}
	}
}
DefaultSurfaceMaterial = "dirt"
MaterialEffectMappings = MaterialEffectMappings or {}
MaterialEffectMappings.arrow_impact = MaterialEffectMappings.arrow_impact or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_arrow_1",
			metal_solid = "hit_metal_solid_arrow_1",
			window = "hit_window_arrow_1",
			stone = "hit_stone_arrow_1",
			dirt = "hit_dirt_arrow_1",
			metal_hollow = "hit_metal_hollow_arrow_1",
			wood_solid = {
				"hit_wood_solid_arrow_1",
				"hit_wood_solid_arrow_2",
				"hit_wood_solid_arrow_3"
			},
			wood_hollow = {
				"hit_wood_hollow_arrow_1",
				"hit_wood_hollow_arrow_2",
				"hit_wood_hollow_arrow_3"
			},
			cloth = {
				"hit_cloth_arrow_1",
				"hit_cloth_arrow_1"
			},
			plaster = {
				"hit_plaster_arrow_1",
				"hit_plaster_arrow_2",
				"hit_plaster_arrow_3"
			}
		},
		settings = {
			depth = 0.1,
			height = 0.1,
			width = 0.1,
			depth_offset = -0.15
		}
	},
	sound = {
		stone = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "stone"
			}
		},
		wood_solid = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "wood_solid"
			}
		},
		wood_hollow = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "wood_hollow"
			}
		},
		metal_solid = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "metal_solid"
			}
		},
		metal_hollow = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "metal_hollow"
			}
		},
		dirt = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "dirt"
			}
		},
		water = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "water"
			}
		},
		cloth = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "cloth"
			}
		},
		fruit = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "fruit"
			}
		},
		plaster = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "plaster"
			}
		},
		window = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "window"
			}
		},
		hay = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "hay"
			}
		},
		grass = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "grass"
			}
		},
		snow = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "snow"
			}
		},
		ice = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "ice"
			}
		},
		sand = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "ice"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_pierce",
		water = "fx/hit_water_pierce",
		window = "fx/hit_metal_solid_pierce",
		stone = "fx/hit_stone_pierce",
		dirt = "fx/hit_dirt_pierce",
		wood_hollow = "fx/hit_wood_hollow_pierce",
		hay = "fx/hit_metal_solid_pierce",
		grass = "fx/hit_grass_pierce",
		fruit = "fx/hit_fruit_pierce",
		wood_solid = "fx/hit_wood_solid_pierce",
		ice = "fx/hit_ice",
		sand = "fx/hit_sand",
		metal_solid = "fx/hit_metal_solid_pierce",
		cloth = "fx/hit_cloth_pierce",
		snow = "fx/hit_snow",
		metal_hollow = "fx/hit_metal_hollow_pierce"
	}
}
MaterialEffectMappings.bullet_impact = MaterialEffectMappings.bullet_impact or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			window = "hit_window_pierce_1",
			stone = "hit_stone_pierce_1",
			dirt = "hit_dirt_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			wood_solid = {
				"hit_wood_solid_pierce_1",
				"hit_wood_solid_pierce_2",
				"hit_wood_solid_pierce_3"
			},
			wood_hollow = {
				"hit_wood_hollow_pierce_1",
				"hit_wood_hollow_pierce_2",
				"hit_wood_hollow_pierce_3"
			},
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_1"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2",
				"hit_plaster_pierce_3"
			}
		},
		settings = {
			depth = 0.15,
			height = 0.15,
			width = 0.15
		}
	},
	sound = {
		stone = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "stone"
			}
		},
		wood_solid = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "wood_solid"
			}
		},
		wood_hollow = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "dirt"
			}
		},
		metal_solid = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "metal_solid"
			}
		},
		metal_hollow = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "metal_hollow"
			}
		},
		dirt = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "dirt"
			}
		},
		water = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "water"
			}
		},
		cloth = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "cloth"
			}
		},
		fruit = {
			event = "bullet_hit_statics",
			parameters = {
				material_parameter = "fruit"
			}
		},
		plaster = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "plaster"
			}
		},
		window = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "window"
			}
		},
		hay = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "hay"
			}
		},
		grass = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "grass"
			}
		},
		snow = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "snow"
			}
		},
		ice = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "ice"
			}
		},
		sand = {
			event = "arrow_hit_statics",
			parameters = {
				material_parameter = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_pierce",
		water = "fx/hit_water_pierce",
		window = "fx/hit_metal_solid_pierce",
		stone = "fx/hit_stone_pierce",
		dirt = "fx/hit_dirt_pierce",
		wood_hollow = "fx/hit_wood_hollow_pierce",
		hay = "fx/hit_hay_pierce",
		grass = "fx/hit_grass_pierce",
		fruit = "fx/hit_fruit_pierce",
		wood_solid = "fx/hit_wood_solid_pierce",
		ice = "fx/hit_ice",
		sand = "fx/hit_sand",
		metal_solid = "fx/hit_metal_solid_pierce",
		cloth = "fx/hit_cloth_pierce",
		snow = "fx/hit_snow",
		metal_hollow = "fx/hit_metal_hollow_pierce"
	}
}
MaterialEffectMappings.blood_splat = MaterialEffectMappings.blood_splat or {}
MaterialEffectMappings.melee_hit_blunt = MaterialEffectMappings.melee_hit_blunt or {
	decal = {
		material_drawer_mapping = {
			ice = "hit_dirt_blunt_1",
			window = "hit_window_blunt_1",
			stone = "hit_stone_blunt_1",
			dirt = "hit_dirt_blunt_1",
			fruit = "hit_fruit_blunt_1",
			sand = "hit_dirt_blunt_1",
			metal_solid = "hit_metal_solid_blunt_1",
			snow = "hit_dirt_blunt_1",
			metal_hollow = "hit_metal_hollow_blunt_1",
			wood_solid = {
				"hit_wood_solid_blunt_1",
				"hit_wood_solid_blunt_2"
			},
			wood_hollow = {
				"hit_wood_hollow_blunt_1",
				"hit_wood_hollow_blunt_2"
			},
			plaster = {
				"hit_plaster_blunt_1",
				"hit_plaster_blunt_2"
			}
		},
		settings = {
			depth = 0.2,
			height = 0.2,
			width = 0.2
		}
	},
	sound = {
		stone = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "stone"
			}
		},
		wood_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "wood_solid"
			}
		},
		wood_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "wood_hollow"
			}
		},
		metal_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "metal_solid"
			}
		},
		metal_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "metal_hollow"
			}
		},
		dirt = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "dirt"
			}
		},
		water = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "water"
			}
		},
		cloth = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "cloth"
			}
		},
		fruit = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "fruit"
			}
		},
		plaster = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "plaster"
			}
		},
		window = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "window"
			}
		},
		hay = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "hay"
			}
		},
		grass = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "grass"
			}
		},
		snow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "snow"
			}
		},
		ice = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "ice"
			}
		},
		sand = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "blunt",
				material_parameter = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_blunt",
		water = "fx/hit_water_blunt",
		window = "fx/hit_metal_solid_pierce",
		stone = "fx/hit_stone_blunt",
		dirt = "fx/hit_dirt_blunt",
		wood_hollow = "fx/hit_wood_hollow_blunt",
		hay = "fx/hit_hay_blunt",
		grass = "fx/hit_grass_blunt",
		fruit = "fx/hit_fruit_blunt",
		wood_solid = "fx/hit_wood_solid_blunt",
		ice = "fx/hit_ice",
		sand = "fx/hit_sand",
		metal_solid = "fx/hit_metal_solid_blunt",
		cloth = "fx/hit_cloth_blunt",
		snow = "fx/hit_snow",
		metal_hollow = "fx/hit_metal_hollow_blunt"
	}
}
MaterialEffectMappings.melee_hit_wood_shaft = MaterialEffectMappings.melee_hit_wood_shaft or {
	sound = {
		stone = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "stone"
			}
		},
		wood_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "wood_solid"
			}
		},
		wood_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "wood_hollow"
			}
		},
		metal_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "metal_solid"
			}
		},
		metal_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "metal_hollow"
			}
		},
		dirt = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "dirt"
			}
		},
		water = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "water"
			}
		},
		cloth = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "cloth"
			}
		},
		fruit = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "fruit"
			}
		},
		plaster = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "plaster"
			}
		},
		window = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "window"
			}
		},
		hay = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "hay"
			}
		},
		grass = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "grass"
			}
		},
		snow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "snow"
			}
		},
		ice = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "wood_shaft",
				material_parameter = "ice"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_blunt",
		water = "fx/hit_water_blunt",
		window = "fx/hit_metal_solid_pierce",
		stone = "fx/hit_stone_blunt",
		dirt = "fx/hit_dirt_blunt",
		wood_hollow = "fx/hit_wood_hollow_blunt",
		hay = "fx/hit_hay_blunt",
		grass = "fx/hit_grass_blunt",
		fruit = "fx/hit_fruit_blunt",
		wood_solid = "fx/hit_wood_solid_blunt",
		ice = "fx/hit_ice",
		sand = "fx/hit_sand",
		metal_solid = "fx/hit_metal_solid_blunt",
		cloth = "fx/hit_cloth_blunt",
		snow = "fx/hit_snow",
		metal_hollow = "fx/hit_metal_hollow_blunt"
	}
}
MaterialEffectMappings.melee_hit_metal_shaft = MaterialEffectMappings.melee_hit_metal_shaft or {
	sound = {
		stone = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "stone"
			}
		},
		wood_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "wood_solid"
			}
		},
		wood_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "wood_hollow"
			}
		},
		metal_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "metal_solid"
			}
		},
		metal_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "metal_hollow"
			}
		},
		dirt = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "dirt"
			}
		},
		water = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "water"
			}
		},
		cloth = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "cloth"
			}
		},
		fruit = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "fruit"
			}
		},
		plaster = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "plaster"
			}
		},
		window = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "window"
			}
		},
		hay = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "hay"
			}
		},
		grass = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "grass"
			}
		},
		snow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "snow"
			}
		},
		ice = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "ice"
			}
		},
		sand = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "metal_shaft",
				material_parameter = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_blunt",
		water = "fx/hit_water_blunt",
		window = "fx/hit_metal_solid_pierce",
		stone = "fx/hit_stone_blunt",
		dirt = "fx/hit_dirt_blunt",
		wood_hollow = "fx/hit_wood_hollow_blunt",
		hay = "fx/hit_hay_blunt",
		grass = "fx/hit_grass_blunt",
		fruit = "fx/hit_fruit_blunt",
		wood_solid = "fx/hit_wood_solid_blunt",
		ice = "fx/hit_ice",
		sand = "fx/hit_sand",
		metal_solid = "fx/hit_metal_solid_blunt",
		cloth = "fx/hit_cloth_blunt",
		snow = "fx/hit_snow",
		metal_hollow = "fx/hit_metal_hollow_blunt"
	}
}
MaterialEffectMappings.melee_hit_piercing = MaterialEffectMappings.melee_hit_piercing or {
	decal = {
		material_drawer_mapping = {
			ice = "hit_dirt_pierce_1",
			window = "hit_window_pierce_1",
			stone = "hit_stone_pierce_1",
			dirt = "hit_dirt_pierce_1",
			fruit = "hit_fruit_pierce_1",
			sand = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			snow = "hit_dirt_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			wood_solid = {
				"hit_wood_solid_pierce_1",
				"hit_wood_solid_pierce_2",
				"hit_wood_solid_pierce_3"
			},
			wood_hollow = {
				"hit_wood_hollow_pierce_1",
				"hit_wood_hollow_pierce_2",
				"hit_wood_hollow_pierce_3"
			},
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_1"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2",
				"hit_plaster_pierce_3"
			}
		},
		settings = {
			depth = 0.15,
			height = 0.15,
			width = 0.15
		}
	},
	sound = {
		stone = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "stone"
			}
		},
		wood_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "wood_solid"
			}
		},
		wood_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "wood_hollow"
			}
		},
		metal_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "metal_solid"
			}
		},
		metal_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "metal_hollow"
			}
		},
		dirt = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "dirt"
			}
		},
		water = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "water"
			}
		},
		cloth = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "cloth"
			}
		},
		fruit = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "fruit"
			}
		},
		plaster = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "plaster"
			}
		},
		window = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "window"
			}
		},
		hay = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "hay"
			}
		},
		grass = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "grass"
			}
		},
		snow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "grass"
			}
		},
		ice = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "grass"
			}
		},
		sand = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "piercing",
				material_parameter = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_pierce",
		water = "fx/hit_water_pierce",
		window = "fx/hit_metal_solid_pierce",
		stone = "fx/hit_stone_pierce",
		dirt = "fx/hit_dirt_pierce",
		wood_hollow = "fx/hit_wood_hollow_pierce",
		hay = "fx/hit_hay_pierce",
		grass = "fx/hit_grass_pierce",
		fruit = "fx/hit_fruit_pierce",
		wood_solid = "fx/hit_wood_solid_pierce",
		ice = "fx/hit_ice",
		sand = "fx/hit_sand",
		metal_solid = "fx/hit_metal_solid_pierce",
		cloth = "fx/hit_cloth_pierce",
		snow = "fx/hit_snow",
		metal_hollow = "fx/hit_metal_hollow_pierce"
	}
}
MaterialEffectMappings.melee_hit_cutting = MaterialEffectMappings.melee_hit_cutting or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_slash_1",
			window = "hit_window_slash_1",
			stone = "hit_stone_slash_1",
			dirt = "hit_dirt_slash_1",
			snow = "hit_dirt_slash_1",
			hit = "hit_dirt_slash_1",
			wood_solid = {
				"hit_wood_solid_slash_1",
				"hit_wood_solid_slash_2",
				"hit_wood_solid_slash_3"
			},
			wood_hollow = {
				"hit_wood_hollow_slash_1",
				"hit_wood_hollow_slash_2",
				"hit_wood_hollow_slash_3"
			},
			metal_solid = {
				"hit_metal_solid_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_solid_slash_3"
			},
			metal_hollow = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			cloth = {
				"hit_cloth_slash_1",
				"hit_cloth_slash_1"
			},
			plaster = {
				"hit_plaster_slash_1",
				"hit_plaster_slash_2"
			}
		},
		settings = {
			depth = 0.25,
			height = 0.25,
			width = 0.05
		}
	},
	sound = {
		stone = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "stone"
			}
		},
		wood_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "wood_solid"
			}
		},
		wood_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "wood_hollow"
			}
		},
		metal_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "metal_solid"
			}
		},
		metal_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "metal_hollow"
			}
		},
		dirt = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "dirt"
			}
		},
		water = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "water"
			}
		},
		cloth = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "cloth"
			}
		},
		fruit = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "fruit"
			}
		},
		plaster = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "plaster"
			}
		},
		window = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "window"
			}
		},
		hay = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "hay"
			}
		},
		grass = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "grass"
			}
		},
		snow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "grass"
			}
		},
		ice = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "grass"
			}
		},
		sand = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "cutting",
				material_parameter = "grass"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_slash",
		water = "fx/hit_water_slash",
		window = "fx/hit_metal_solid_pierce",
		stone = "fx/hit_stone_slash",
		dirt = "fx/hit_dirt_slash",
		wood_hollow = "fx/hit_wood_hollow_slash",
		hay = "fx/hit_hay_slash",
		grass = "fx/hit_grass_slash",
		fruit = "fx/hit_fruit_slash",
		wood_solid = "fx/hit_wood_solid_slash",
		ice = "fx/hit_ice",
		sand = "fx/hit_sand",
		metal_solid = "fx/hit_metal_solid_slash",
		cloth = "fx/hit_cloth_slash",
		snow = "fx/hit_snow",
		metal_hollow = "fx/hit_metal_hollow_slash"
	}
}
MaterialEffectMappings.melee_hit_slashing = MaterialEffectMappings.melee_hit_slashing or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_slash_1",
			sand = "hit_dirt_slash_1",
			window = "hit_window_slash_1",
			stone = "hit_stone_slash_1",
			dirt = "hit_dirt_slash_1",
			snow = "hit_dirt_slash_1",
			ice = "hit_dirt_slash_1",
			wood_solid = {
				"hit_wood_solid_slash_1",
				"hit_wood_solid_slash_2",
				"hit_wood_solid_slash_3"
			},
			wood_hollow = {
				"hit_wood_hollow_slash_1",
				"hit_wood_hollow_slash_2",
				"hit_wood_hollow_slash_3"
			},
			metal_solid = {
				"hit_metal_solid_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_solid_slash_3"
			},
			metal_hollow = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			cloth = {
				"hit_cloth_slash_1",
				"hit_cloth_slash_1"
			},
			plaster = {
				"hit_plaster_slash_1",
				"hit_plaster_slash_2"
			}
		},
		settings = {
			depth = 0.25,
			height = 0.25,
			width = 0.05
		}
	},
	sound = {
		stone = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "stone"
			}
		},
		wood_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "wood_solid"
			}
		},
		wood_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "wood_hollow"
			}
		},
		metal_solid = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "metal_solid"
			}
		},
		metal_hollow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "metal_hollow"
			}
		},
		dirt = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "dirt"
			}
		},
		water = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "water"
			}
		},
		cloth = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "cloth"
			}
		},
		fruit = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "fruit"
			}
		},
		plaster = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "plaster"
			}
		},
		window = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "window"
			}
		},
		hay = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "hay"
			}
		},
		grass = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "grass"
			}
		},
		snow = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "grass"
			}
		},
		ice = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "grass"
			}
		},
		sand = {
			event = "melee_hit_statics",
			parameters = {
				damage_type = "slashing",
				material_parameter = "grass"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_slash",
		window = "fx/hit_metal_solid_pierce",
		hay = "fx/hit_hay_slash",
		stone = "fx/hit_stone_slash",
		dirt = "fx/hit_dirt_slash",
		wood_hollow = "fx/hit_wood_hollow_slash",
		grass = "fx/hit_grass_slash",
		ice = "fx/hit_ice",
		fruit = "fx/hit_fruit_slash",
		wood_solid = "fx/hit_wood_solid_slash",
		sand = "fx/hit_sand",
		metal_solid = "fx/hit_metal_solid_slash",
		cloth = "fx/hit_cloth_slash",
		snow = "fx/hit_snow",
		metal_hollow = "fx/hit_metal_hollow_slash"
	}
}
MaterialEffectMappings.footstep_walk = MaterialEffectMappings.footstep_walk or {
	sound = {
		stone = {
			event = "walk",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "walk",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "walk",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "walk",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "walk",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "walk",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "walk",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "walk",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "walk",
			parameters = {
				material = "fruit"
			}
		},
		plaster = {
			event = "walk",
			parameters = {
				material = "plaster"
			}
		},
		window = {
			event = "walk",
			parameters = {
				material = "window"
			}
		},
		hay = {
			event = "walk",
			parameters = {
				material = "hay"
			}
		},
		grass = {
			event = "walk",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "walk",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "walk",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "walk",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_jog_dirt",
		water = "fx/footstep_jog_dirt",
		window = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		hay = "fx/footstep_jog_dirt",
		grass = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		ice = "fx/footstep_jog_ice",
		sand = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.footstep_sneak = MaterialEffectMappings.footstep_sneak or {
	sound = {
		stone = {
			event = "sneak",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "sneak",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "sneak",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "sneak",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "sneak",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "sneak",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "sneak",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "sneak",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "sneak",
			parameters = {
				material = "fruit"
			}
		},
		plaster = {
			event = "sneak",
			parameters = {
				material = "plaster"
			}
		},
		window = {
			event = "sneak",
			parameters = {
				material = "window"
			}
		},
		hay = {
			event = "sneak",
			parameters = {
				material = "hay"
			}
		},
		grass = {
			event = "sneak",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "sneak",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "sneak",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "sneak",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_jog_dirt",
		water = "fx/footstep_jog_dirt",
		window = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		hay = "fx/footstep_jog_dirt",
		grass = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		ice = "fx/footstep_jog_ice",
		sand = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.footstep_jog = MaterialEffectMappings.footstep_jog or {
	sound = {
		stone = {
			event = "run",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "run",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "run",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "run",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "run",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "run",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "run",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "run",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "run",
			parameters = {
				material = "fruit"
			}
		},
		plaster = {
			event = "run",
			parameters = {
				material = "plaster"
			}
		},
		window = {
			event = "run",
			parameters = {
				material = "window"
			}
		},
		hay = {
			event = "run",
			parameters = {
				material = "hay"
			}
		},
		grass = {
			event = "run",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "run",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "run",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "run",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		ice = "fx/footstep_jog_ice",
		water = "fx/footstep_jog_dirt",
		sand = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.footstep_jump = MaterialEffectMappings.footstep_jump or {
	sound = {
		stone = {
			event = "jump",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "jump",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "jump",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "jump",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "jump",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "jump",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "jump",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "jump",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "jump",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "jump",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "jump",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "jump",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "jump",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		ice = "fx/footstep_jog_ice",
		water = "fx/footstep_jog_dirt",
		sand = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.footstep_land = MaterialEffectMappings.footstep_land or {
	sound = {
		stone = {
			event = "land_run",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "land_run",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "land_run",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "land_run",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "land_run",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "land_run",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "land_run",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "land_run",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "land_run",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "land_run",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "land_run",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "land_run",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "land_run",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		ice = "fx/footstep_jog_ice",
		water = "fx/footstep_jog_dirt",
		sand = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.hoof_walk = MaterialEffectMappings.hoof_walk or {
	sound = {
		stone = {
			event = "horse_walk",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "horse_walk",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "horse_walk",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "horse_walk",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "horse_walk",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "horse_walk",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "horse_walk",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "horse_walk",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "horse_walk",
			parameters = {
				material = "fruit"
			}
		},
		plaster = {
			event = "horse_walk",
			parameters = {
				material = "plaster"
			}
		},
		window = {
			event = "horse_walk",
			parameters = {
				material = "window"
			}
		},
		hay = {
			event = "horse_walk",
			parameters = {
				material = "hay"
			}
		},
		grass = {
			event = "horse_walk",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "land_run",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "land_run",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "land_run",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_jog_dirt",
		water = "fx/footstep_jog_dirt",
		window = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		hay = "fx/footstep_jog_dirt",
		grass = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		ice = "fx/footstep_jog_ice",
		sand = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.hoof_galop_rl = MaterialEffectMappings.hoof_galop_rl or {
	sound = {
		stone = {
			event = "horse_galop_rl",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "horse_galop_rl",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "horse_galop_rl",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "horse_galop_rl",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "horse_galop_rl",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "horse_galop_rl",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "horse_galop_rl",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "horse_walk",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "horse_galop_rl",
			parameters = {
				material = "fruit"
			}
		},
		plaster = {
			event = "horse_galop_rl",
			parameters = {
				material = "plaster"
			}
		},
		window = {
			event = "horse_galop_rl",
			parameters = {
				material = "window"
			}
		},
		hay = {
			event = "horse_galop_rl",
			parameters = {
				material = "hay"
			}
		},
		grass = {
			event = "horse_galop_rl",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "horse_galop_rl",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "horse_galop_rl",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "horse_galop_rl",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_jog_dirt",
		water = "fx/footstep_jog_dirt",
		window = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		hay = "fx/footstep_jog_dirt",
		grass = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		ice = "fx/footstep_jog_ice",
		sand = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.hoof_galop_rr = MaterialEffectMappings.hoof_galop_rr or {
	sound = {
		stone = {
			event = "horse_galop_rr",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "horse_galop_rr",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "horse_galop_rr",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "horse_galop_rr",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "horse_galop_rr",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "horse_galop_rr",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "horse_galop_rr",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "horse_walk",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "horse_galop_rr",
			parameters = {
				material = "fruit"
			}
		},
		plaster = {
			event = "horse_galop_rr",
			parameters = {
				material = "plaster"
			}
		},
		window = {
			event = "horse_galop_rr",
			parameters = {
				material = "window"
			}
		},
		hay = {
			event = "horse_galop_rr",
			parameters = {
				material = "hay"
			}
		},
		grass = {
			event = "horse_galop_rr",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "horse_galop_rr",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "horse_galop_rr",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "horse_galop_rr",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_jog_dirt",
		water = "fx/footstep_jog_dirt",
		window = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		hay = "fx/footstep_jog_dirt",
		grass = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		ice = "fx/footstep_jog_ice",
		sand = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.hoof_galop_fl = MaterialEffectMappings.hoof_galop_fl or {
	sound = {
		stone = {
			event = "horse_galop_fl",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "horse_galop_fl",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "horse_galop_fl",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "horse_galop_fl",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "horse_galop_fl",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "horse_galop_fl",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "horse_galop_fl",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "horse_walk",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "horse_galop_fl",
			parameters = {
				material = "fruit"
			}
		},
		plaster = {
			event = "horse_galop_fl",
			parameters = {
				material = "plaster"
			}
		},
		window = {
			event = "horse_galop_fl",
			parameters = {
				material = "window"
			}
		},
		hay = {
			event = "horse_galop_fl",
			parameters = {
				material = "hay"
			}
		},
		grass = {
			event = "horse_galop_fl",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "horse_galop_fl",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "horse_galop_fl",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "horse_galop_fl",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_jog_dirt",
		water = "fx/footstep_jog_dirt",
		window = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		hay = "fx/footstep_jog_dirt",
		grass = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		ice = "fx/footstep_jog_ice",
		sand = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialEffectMappings.hoof_galop_fr = MaterialEffectMappings.hoof_galop_fr or {
	sound = {
		stone = {
			event = "horse_galop_fr",
			parameters = {
				material = "stone"
			}
		},
		wood_solid = {
			event = "horse_galop_fr",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "horse_galop_fr",
			parameters = {
				material = "wood_hollow"
			}
		},
		metal_solid = {
			event = "horse_galop_fr",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "horse_galop_fr",
			parameters = {
				material = "metal_hollow"
			}
		},
		dirt = {
			event = "horse_galop_fr",
			parameters = {
				material = "dirt"
			}
		},
		water = {
			event = "horse_galop_fr",
			parameters = {
				material = "water"
			}
		},
		cloth = {
			event = "horse_galop_fr",
			parameters = {
				material = "cloth"
			}
		},
		fruit = {
			event = "horse_galop_fr",
			parameters = {
				material = "fruit"
			}
		},
		plaster = {
			event = "horse_galop_fr",
			parameters = {
				material = "plaster"
			}
		},
		window = {
			event = "horse_galop_fr",
			parameters = {
				material = "window"
			}
		},
		hay = {
			event = "horse_galop_fr",
			parameters = {
				material = "hay"
			}
		},
		grass = {
			event = "horse_galop_fr",
			parameters = {
				material = "grass"
			}
		},
		snow = {
			event = "horse_galop_fr",
			parameters = {
				material = "snow"
			}
		},
		ice = {
			event = "horse_galop_fr",
			parameters = {
				material = "ice"
			}
		},
		sand = {
			event = "horse_galop_fr",
			parameters = {
				material = "sand"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_jog_dirt",
		water = "fx/footstep_jog_dirt",
		window = "fx/footstep_jog_dirt",
		stone = "fx/footstep_jog_dirt",
		dirt = "fx/footstep_jog_dirt",
		wood_hollow = "fx/footstep_jog_dirt",
		hay = "fx/footstep_jog_dirt",
		grass = "fx/footstep_jog_dirt",
		fruit = "fx/footstep_jog_dirt",
		wood_solid = "fx/footstep_jog_dirt",
		ice = "fx/footstep_jog_ice",
		sand = "fx/footstep_jog_dirt",
		metal_solid = "fx/footstep_jog_dirt",
		cloth = "fx/footstep_jog_dirt",
		snow = "fx/footstep_jog_snow",
		metal_hollow = "fx/footstep_jog_dirt"
	}
}
MaterialIDToName = {}

for context_name, context_materials in pairs(MaterialEffectSettings.material_contexts) do
	MaterialIDToName[context_name] = {}

	for _, material_name in ipairs(context_materials) do
		MaterialIDToName[context_name][Unit.material_id(material_name)] = material_name
	end
end
