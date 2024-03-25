-- chunkname: @scripts/settings/gear_attachments.lua

require("gui/textures/menu_atlas")

GearAttachments = {
	melee = {
		fighting_style = {
			{
				ui_description = "melee_english_style_description",
				ui_header = "melee_english_style_header",
				name = "english_style",
				release_name = "main",
				unlock_key = 1,
				ui_fluff_text = "melee_english_style_fluff",
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0033_english",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0033_english",
					"menu_attachment_icon_32_0034_background"
				},
				multipliers = {
					damage = 1,
					pose_speed = 1,
					pose_movement_speed = 1,
					swing_speed = 1
				}
			},
			{
				ui_description = "melee_german_style_description",
				ui_header = "melee_german_style_header",
				name = "german_style",
				market_price = 4000,
				unlock_key = 2,
				release_name = "main",
				ui_fluff_text = "melee_german_style_fluff",
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0032_german",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0032_german",
					"menu_attachment_icon_32_0034_background"
				},
				multipliers = {
					damage = 1.2,
					pose_speed = 1.2,
					pose_movement_speed = 1,
					swing_speed = 1
				}
			},
			{
				ui_description = "melee_italian_style_description",
				ui_header = "melee_italian_style_header",
				name = "italian_style",
				market_price = 4000,
				unlock_key = 3,
				release_name = "main",
				ui_fluff_text = "melee_italian_style_fluff",
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0031_italy",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0031_italy",
					"menu_attachment_icon_32_0034_background"
				},
				multipliers = {
					damage = 0.8,
					pose_speed = 0.8,
					pose_movement_speed = 0.9,
					swing_speed = 1
				}
			}
		},
		blade = {
			{
				ui_description = "melee_blade_steel_description",
				ui_header = "melee_blade_steel_header",
				name = "steel",
				release_name = "main",
				unlock_key = 4,
				ui_fluff_text = "melee_blade_steel_fluff",
				multipliers = {
					health = 1,
					absorption_armour = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0013_blade",
					"menu_attachment_icon_128_0026_steel"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0013_blade",
					"menu_attachment_icon_32_0026_steel"
				}
			},
			{
				ui_description = "melee_blade_hardened_steel_description",
				ui_header = "melee_blade_hardened_steel_header",
				name = "hardened_steel",
				market_price = 4000,
				unlock_key = 5,
				release_name = "main",
				ui_fluff_text = "melee_blade_hardened_steel_fluff",
				multipliers = {
					health = 0.8,
					absorption_armour = 1.1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0013_blade",
					"menu_attachment_icon_128_0025_hardened_steel"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0013_blade",
					"menu_attachment_icon_32_0025_hardened_steel"
				}
			},
			{
				ui_description = "melee_blade_damascus_steel_description",
				ui_header = "melee_blade_damascus_steel_header",
				name = "damascus_steel",
				market_price = 4000,
				unlock_key = 6,
				release_name = "main",
				ui_fluff_text = "melee_blade_damascus_steel_fluff",
				multipliers = {
					health = 1,
					absorption_armour = 0.9
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0013_blade",
					"menu_attachment_icon_128_0024_damascus_steel"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0013_blade",
					"menu_attachment_icon_32_0024_damascus_steel"
				}
			}
		},
		head = {
			{
				ui_description = "melee_head_steel_description",
				ui_header = "melee_head_steel_header",
				name = "steel",
				release_name = "main",
				unlock_key = 7,
				ui_fluff_text = "melee_head_steel_fluff",
				multipliers = {
					health = 1,
					absorption_armour = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0012_axe",
					"menu_attachment_icon_128_0026_steel"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0012_axe",
					"menu_attachment_icon_32_0026_steel"
				}
			},
			{
				ui_description = "melee_head_hardened_steel_description",
				ui_header = "melee_head_hardened_steel_header",
				name = "hardened_steel",
				market_price = 4000,
				unlock_key = 8,
				release_name = "main",
				ui_fluff_text = "melee_head_hardened_steel_fluff",
				multipliers = {
					health = 0.8,
					absorption_armour = 1.1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0012_axe",
					"menu_attachment_icon_128_0025_hardened_steel"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0012_axe",
					"menu_attachment_icon_32_0025_hardened_steel"
				}
			}
		},
		edge_grind = {
			{
				ui_description = "melee_edge_grind_flat_description",
				ui_header = "melee_edge_grind_flat_header",
				name = "flat",
				release_name = "main",
				unlock_key = 9,
				ui_fluff_text = "melee_edge_grind_flat_fluff",
				multipliers = {
					damage = 1,
					health = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0011_flat_grind",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0011_flat_grind"
				}
			},
			{
				ui_description = "melee_edge_grind_double_beveled_description",
				ui_header = "melee_edge_grind_double_beveled_header",
				name = "double_beveled",
				market_price = 4000,
				unlock_key = 10,
				release_name = "main",
				ui_fluff_text = "melee_edge_grind_double_beveled_fluff",
				multipliers = {
					damage = 1,
					health = 1.5
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0010_double_bevel_grind",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0010_double_bevel_grind"
				}
			},
			{
				ui_description = "melee_edge_grind_convex_description",
				ui_header = "melee_edge_grind_convex_header",
				name = "convex",
				market_price = 4000,
				unlock_key = 11,
				release_name = "main",
				ui_fluff_text = "melee_edge_grind_convex_fluff",
				multipliers = {
					damage = 1.15,
					health = 0.5
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0009_convex_grind",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0009_convex_grind"
				}
			},
			{
				ui_description = "melee_edge_grind_hollow_ground_description",
				ui_header = "melee_edge_grind_hollow_ground_header",
				name = "hollow_ground",
				market_price = 4000,
				unlock_key = 12,
				release_name = "main",
				ui_fluff_text = "melee_edge_grind_hollow_ground_fluff",
				multipliers = {
					damage = 1,
					health = 0.7
				},
				properties = {
					"penetration"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0008_hollow_grind",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0008_hollow_grind"
				}
			}
		},
		pommel = {
			{
				ui_description = "melee_pommel_standard_description",
				ui_header = "melee_pommel_standard_header",
				name = "standard",
				release_name = "main",
				unlock_key = 13,
				ui_fluff_text = "melee_pommel_standard_fluff",
				multipliers = {
					encumbrance = 1,
					pose_speed = 1,
					swing_speed = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0041_pommel_standard",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0041_pommel_standard",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "melee_pommel_balanced_description",
				ui_header = "melee_pommel_balanced_header",
				name = "balanced",
				market_price = 4000,
				unlock_key = 14,
				release_name = "main",
				ui_fluff_text = "melee_pommel_balanced_fluff",
				multipliers = {
					encumbrance = 1.05,
					pose_speed = 0.95,
					swing_speed = 0.95
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0040_pommel_balanced",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0040_pommel_balanced",
					"menu_attachment_icon_32_0034_background"
				}
			}
		},
		wooden_shaft = {
			{
				ui_description = "melee_wooden_shaft_standard_description",
				ui_header = "melee_wooden_shaft_standard_header",
				name = "standard",
				release_name = "main",
				unlock_key = 15,
				ui_fluff_text = "melee_wooden_shaft_standard_fluff",
				multipliers = {
					encumbrance = 1,
					pose_speed = 1,
					health = 1,
					swing_speed = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0023_shaft",
					"menu_attachment_icon_128_0030_softwood"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0023_shaft",
					"menu_attachment_icon_32_0030_softwood"
				}
			},
			{
				ui_description = "melee_wooden_shaft_hardwood_description",
				ui_header = "melee_wooden_shaft_hardwood_header",
				name = "hardwood",
				market_price = 4000,
				unlock_key = 16,
				release_name = "main",
				ui_fluff_text = "melee_wooden_shaft_hardwood_fluff",
				multipliers = {
					encumbrance = 1.5,
					pose_speed = 1.1,
					health = 1.5,
					swing_speed = 1.1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0023_shaft",
					"menu_attachment_icon_128_0029_hardwood"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0023_shaft",
					"menu_attachment_icon_32_0029_hardwood"
				}
			}
		},
		lance_shaft = {
			{
				ui_description = "melee_wooden_shaft_standard_description",
				ui_header = "melee_wooden_shaft_standard_header",
				name = "standard",
				release_name = "main",
				unlock_key = 17,
				ui_fluff_text = "melee_wooden_shaft_standard_fluff",
				multipliers = {
					encumbrance = 1,
					health = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0023_shaft",
					"menu_attachment_icon_128_0030_softwood"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0023_shaft",
					"menu_attachment_icon_32_0030_softwood"
				}
			},
			{
				ui_description = "melee_wooden_shaft_hardwood_description",
				ui_header = "melee_wooden_shaft_hardwood_header",
				name = "hardwood",
				market_price = 4000,
				unlock_key = 18,
				release_name = "main",
				ui_fluff_text = "melee_wooden_shaft_hardwood_fluff",
				multipliers = {
					encumbrance = 1.5,
					health = 1.5
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0023_shaft",
					"menu_attachment_icon_128_0029_hardwood"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0023_shaft",
					"menu_attachment_icon_32_0029_hardwood"
				}
			}
		},
		lance_tip = {
			{
				ui_description = "melee_lance_tip_sharp_description",
				ui_header = "melee_lance_tip_sharp_header",
				name = "sharp",
				damage_type = "piercing",
				unlock_key = 19,
				release_name = "main",
				ui_fluff_text = "melee_lance_tip_sharp_fluff",
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0003_sharp_tip",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0003_sharp_tip",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "melee_lance_tip_coronel_description",
				ui_header = "melee_lance_tip_coronel_header",
				name = "coronel",
				damage_type = "blunt",
				unlock_key = 20,
				market_price = 4000,
				ui_fluff_text = "melee_lance_tip_coronel_fluff",
				release_name = "main",
				properties = {
					"stun"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0002_blunt_tip",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0002_blunt_tip",
					"menu_attachment_icon_32_0034_background"
				}
			}
		},
		lance_misc = {
			{
				ui_description = "melee_lance_graper_description",
				ui_header = "melee_lance_graper_header",
				name = "graper",
				market_price = 4000,
				unlock_key = 22,
				release_name = "main",
				ui_fluff_text = "melee_lance_graper_fluff",
				multipliers = {
					encumbrance = 1.05,
					lance_speed_max = 1.05,
					lance_couch_time = 1.05
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {}
			}
		}
	},
	plate_shield = {
		plate = {
			{
				ui_description = "plate_shield_steel_description",
				ui_header = "plate_shield_steel_header",
				name = "steel",
				release_name = "main",
				unlock_key = 23,
				ui_fluff_text = "plate_shield_steel_fluff",
				multipliers = {
					encumbrance = 1,
					health = 1,
					absorption_armour = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0007_shield",
					"menu_attachment_icon_128_0026_steel"
				},
				ui_textures_small = {}
			},
			{
				ui_description = "plate_shield_hardened_steel_description",
				ui_header = "plate_shield_hardened_steel_header",
				name = "hardened_steel",
				market_price = 4000,
				unlock_key = 24,
				release_name = "main",
				ui_fluff_text = "plate_shield_hardened_steel_fluff",
				multipliers = {
					encumbrance = 1.5,
					health = 0.8,
					absorption_armour = 1.2
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0007_shield",
					"menu_attachment_icon_128_0025_hardened_steel"
				},
				ui_textures_small = {}
			}
		}
	},
	wooden_shield = {
		rim = {
			{
				ui_description = "wooden_shield_rim_norim_description",
				ui_header = "wooden_shield_rim_norim_header",
				name = "norim",
				release_name = "main",
				unlock_key = 25,
				ui_fluff_text = "wooden_shield_rim_norim_fluff",
				multipliers = {
					encumbrance = 1,
					health = 1,
					pose_movement_speed = 1,
					absorption_armour = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0006_steel_rim",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {}
			},
			{
				ui_description = "wooden_shield_rim_steel_description",
				ui_header = "wooden_shield_rim_steel_header",
				name = "steel",
				market_price = 4000,
				unlock_key = 26,
				release_name = "main",
				ui_fluff_text = "wooden_shield_rim_steel_fluff",
				multipliers = {
					encumbrance = 1.5,
					health = 0.8,
					pose_movement_speed = 0.95,
					absorption_armour = 1.04
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0006_steel_rim",
					"menu_attachment_icon_128_0026_steel"
				},
				ui_textures_small = {}
			},
			{
				ui_description = "wooden_shield_rim_hardened_steel_description",
				ui_header = "wooden_shield_rim_hardened_steel_header",
				name = "hardened_steel",
				market_price = 4000,
				unlock_key = 27,
				release_name = "main",
				ui_fluff_text = "wooden_shield_rim_hardened_steel_fluff",
				multipliers = {
					encumbrance = 2,
					health = 0.6,
					pose_movement_speed = 0.9,
					absorption_armour = 1.07
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0006_steel_rim",
					"menu_attachment_icon_128_0025_hardened_steel"
				},
				ui_textures_small = {}
			}
		},
		woodwork = {
			{
				ui_description = "wooden_shield_woodwork_standard_description",
				ui_header = "wooden_shield_woodwork_standard_header",
				name = "standard",
				release_name = "main",
				unlock_key = 30,
				ui_fluff_text = "wooden_shield_woodwork_standard_fluff",
				multipliers = {
					encumbrance = 1,
					health = 1,
					pose_movement_speed = 1,
					absorption_armour = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0007_shield",
					"menu_attachment_icon_128_0030_softwood"
				},
				ui_textures_small = {}
			},
			{
				ui_description = "wooden_shield_woodwork_hardwood_description",
				ui_header = "wooden_shield_woodwork_hardwood_header",
				name = "hardwood",
				market_price = 4000,
				unlock_key = 31,
				release_name = "main",
				ui_fluff_text = "wooden_shield_woodwork_hardwood_fluff",
				multipliers = {
					encumbrance = 2,
					health = 1.2,
					pose_movement_speed = 0.95,
					absorption_armour = 1.2
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0007_shield",
					"menu_attachment_icon_128_0029_hardwood"
				},
				ui_textures_small = {}
			}
		},
		cover = {
			{
				ui_description = "wooden_shield_cover_standard_description",
				ui_header = "wooden_shield_cover_standard_header",
				name = "standard",
				release_name = "main",
				unlock_key = 32,
				ui_fluff_text = "wooden_shield_cover_standard_fluff",
				multipliers = {
					encumbrance = 1,
					health = 1,
					pose_movement_speed = 1,
					absorption_armour = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0007_shield",
					"menu_attachment_icon_128_0028_canvas"
				},
				ui_textures_small = {}
			},
			{
				ui_description = "wooden_shield_cover_leather_description",
				ui_header = "wooden_shield_cover_leather_header",
				name = "leather",
				market_price = 4000,
				unlock_key = 33,
				release_name = "main",
				ui_fluff_text = "wooden_shield_cover_leather_fluff",
				multipliers = {
					encumbrance = 1.2,
					health = 1.1,
					pose_movement_speed = 0.95,
					absorption_armour = 1.1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0007_shield",
					"menu_attachment_icon_128_0027_leather",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0007_shield",
					"menu_attachment_icon_32_0027_leather",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "wooden_shield_cover_boiled_leather_description",
				ui_header = "wooden_shield_cover_boiled_leather_header",
				name = "boiled_leather",
				market_price = 4000,
				unlock_key = 34,
				release_name = "main",
				ui_fluff_text = "wooden_shield_cover_boiled_leather_fluff",
				multipliers = {
					encumbrance = 1.4,
					health = 1.1,
					pose_movement_speed = 0.9,
					absorption_armour = 0.8
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0007_shield",
					"menu_attachment_icon_128_0042_boiled_leather",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0007_shield",
					"menu_attachment_icon_32_0042_boiled_leather",
					"menu_attachment_icon_32_0034_background"
				}
			}
		},
		buckle = {
			{
				ui_description = "wooden_shield_buckle_description",
				ui_header = "wooden_shield_buckle_header",
				name = "buckle",
				market_price = 4000,
				unlock_key = 28,
				unlock_this_item = false,
				ui_fluff_text = "wooden_shield_buckle_fluff",
				release_name = "main",
				multipliers = {
					encumbrance = 2,
					health = 0.8,
					pose_movement_speed = 0.95,
					absorption_armour = 1.1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0005_shield_buckle",
					"menu_attachment_icon_128_0026_steel"
				},
				ui_textures_small = {}
			}
		}
	},
	bow = {
		misc = {
			{
				ui_description = "bow_double_quiver_description",
				ui_header = "bow_double_quiver_header",
				name = "double_quiver",
				market_price = 4000,
				unlock_key = 35,
				unlock_this_item = false,
				ui_fluff_text = "bow_double_quiver_fluff",
				release_name = "main",
				multipliers = {
					encumbrance = 2,
					amunition_regeneration = 0.5,
					amunition_amount = 2
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0001_double_quiver",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {}
			},
			{
				ui_description = "bow_footed_shafts_description",
				ui_header = "bow_footed_shafts_header",
				name = "footed_shafts",
				market_price = 4000,
				unlock_key = 36,
				release_name = "main",
				ui_fluff_text = "bow_footed_shafts_fluff",
				multipliers = {
					gravity = 0.9,
					amunition_regeneration = 0.5
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0022_arrowshaft",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {}
			}
		}
	},
	longbow = {
		projectile_heads = {
			{
				ui_description = "bow_head_standard_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "standard",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 37,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_standard_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_standard_dummy",
				release_name = "main",
				ui_header = "bow_head_standard_header",
				damage_type = "slashing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_standard",
				multipliers = {
					gravity = 1,
					damage = 1,
					amunition_amount = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0021_standard_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0021_standard_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_frogleg_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "frogleg",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 38,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_frogleg_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_cresent_moon_dummy",
				market_price = 4000,
				ui_header = "bow_head_frogleg_header",
				release_name = "main",
				damage_type = "slashing_projectile",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_cresent_moon",
				multipliers = {
					gravity = 1,
					damage = 1.3,
					amunition_amount = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0015_frogleg_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0015_frogleg_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_broad_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "broad",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 39,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_broad_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_swallow_tail_dummy",
				market_price = 4000,
				ui_header = "bow_head_broad_header",
				release_name = "main",
				damage_type = "piercing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_swallow_tail",
				multipliers = {
					gravity = 1.2,
					damage = 0.9,
					amunition_amount = 0.8
				},
				properties = {
					"bleeding"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0014_broadhead_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0014_broadhead_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_fire_description",
				remote_arrow_trail_particle = "fx/remote_fire_trail",
				name = "fire",
				local_arrow_trail_particle = "fx/fire_arrow_trail",
				unlock_key = 40,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_fire_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_fire_dummy",
				release_name = "sherwood",
				ui_header = "bow_head_fire_header",
				kill_effect = true,
				damage_type = "slashing_projectile2",
				market_price = 25000,
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_fire",
				multipliers = {
					gravity = 3,
					damage = 1,
					amunition_amount = 1
				},
				properties = {
					"burning"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0016_fire_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0016_fire_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_barbed_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "barbed",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 41,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_barbed_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_barbed_dummy",
				market_price = 4000,
				ui_header = "bow_head_barbed_header",
				release_name = "main",
				damage_type = "piercing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_barbed",
				multipliers = {
					gravity = 1,
					damage = 0.9,
					amunition_amount = 1.4
				},
				properties = {
					"bleeding"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0020_barbed_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0020_barbed_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_bodkin_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "bodkin",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 42,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_bodkin_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_long_bodkin_dummy",
				market_price = 4000,
				ui_header = "bow_head_bodkin_header",
				release_name = "main",
				damage_type = "slashing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_long_bodkin",
				multipliers = {
					gravity = 0.8,
					damage = 1,
					amunition_amount = 0.8
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0018_bodkin_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0018_bodkin_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_armour_piercing_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "armour_piercing",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 43,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_armour_piercing_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_short_bodkin_dummy",
				market_price = 4000,
				ui_header = "bow_head_armour_piercing_header",
				release_name = "main",
				damage_type = "piercing_projectile3",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_short_bodkin",
				multipliers = {
					gravity = 1,
					damage = 0.9,
					amunition_amount = 1
				},
				properties = {
					"penetration"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0019_armour_piercing_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0019_armour_piercing_head",
					"menu_attachment_icon_32_0034_background"
				}
			}
		}
	},
	huntingbow = {
		projectile_heads = {
			{
				ui_description = "bow_head_standard_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "standard",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 44,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_standard_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_standard_dummy",
				release_name = "main",
				ui_header = "bow_head_standard_header",
				damage_type = "slashing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_standard",
				multipliers = {
					gravity = 1,
					damage = 1,
					amunition_amount = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0021_standard_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0021_standard_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_frogleg_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "frogleg",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 45,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_frogleg_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_cresent_moon_dummy",
				market_price = 4000,
				ui_header = "bow_head_frogleg_header",
				release_name = "main",
				damage_type = "slashing_projectile",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_cresent_moon",
				multipliers = {
					gravity = 1,
					damage = 1.3,
					amunition_amount = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0015_frogleg_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0015_frogleg_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_broad_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "broad",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 46,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_broad_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_swallow_tail_dummy",
				market_price = 4000,
				ui_header = "bow_head_broad_header",
				release_name = "main",
				damage_type = "piercing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_swallow_tail",
				multipliers = {
					gravity = 1.2,
					damage = 0.9,
					amunition_amount = 0.8
				},
				properties = {
					"bleeding"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0014_broadhead_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0014_broadhead_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_fire_description",
				remote_arrow_trail_particle = "fx/remote_fire_trail",
				name = "fire",
				local_arrow_trail_particle = "fx/fire_arrow_trail",
				unlock_key = 47,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_fire_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_fire_dummy",
				release_name = "sherwood",
				ui_header = "bow_head_fire_header",
				kill_effect = true,
				damage_type = "slashing_projectile2",
				market_price = 25000,
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_fire",
				multipliers = {
					gravity = 3,
					damage = 1,
					amunition_amount = 1
				},
				properties = {
					"burning"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0016_fire_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0016_fire_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_barbed_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "barbed",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 48,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_barbed_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_barbed_dummy",
				market_price = 4000,
				ui_header = "bow_head_barbed_header",
				release_name = "main",
				damage_type = "piercing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_barbed",
				multipliers = {
					gravity = 1,
					damage = 0.9,
					amunition_amount = 1.4
				},
				properties = {
					"bleeding"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0020_barbed_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0020_barbed_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_bodkin_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "bodkin",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 49,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_bodkin_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_long_bodkin_dummy",
				market_price = 4000,
				ui_header = "bow_head_bodkin_header",
				release_name = "main",
				damage_type = "slashing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_long_bodkin",
				multipliers = {
					gravity = 0.8,
					damage = 1,
					amunition_amount = 0.8
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0018_bodkin_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0018_bodkin_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_armour_piercing_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "armour_piercing",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 50,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_armour_piercing_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_short_bodkin_dummy",
				market_price = 4000,
				ui_header = "bow_head_armour_piercing_header",
				release_name = "main",
				damage_type = "piercing_projectile3",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_short_bodkin",
				multipliers = {
					gravity = 1,
					damage = 0.9,
					amunition_amount = 1
				},
				properties = {
					"penetration"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0019_armour_piercing_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0019_armour_piercing_head",
					"menu_attachment_icon_32_0034_background"
				}
			}
		}
	},
	shortbow = {
		projectile_heads = {
			{
				ui_description = "bow_head_standard_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "standard",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 51,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_standard_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_standard_dummy",
				release_name = "main",
				ui_header = "bow_head_standard_header",
				damage_type = "slashing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_standard",
				multipliers = {
					gravity = 1,
					damage = 1,
					amunition_amount = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0021_standard_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0021_standard_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_frogleg_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "frogleg",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 52,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_frogleg_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_cresent_moon_dummy",
				market_price = 4000,
				ui_header = "bow_head_frogleg_header",
				release_name = "main",
				damage_type = "slashing_projectile",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_cresent_moon",
				multipliers = {
					gravity = 1,
					damage = 1.3,
					amunition_amount = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0015_frogleg_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0015_frogleg_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_broad_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "broad",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 53,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_broad_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_swallow_tail_dummy",
				market_price = 4000,
				ui_header = "bow_head_broad_header",
				release_name = "main",
				damage_type = "piercing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_swallow_tail",
				multipliers = {
					gravity = 1.2,
					damage = 0.9,
					amunition_amount = 0.8
				},
				properties = {
					"bleeding"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0014_broadhead_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0014_broadhead_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_fire_description",
				remote_arrow_trail_particle = "fx/remote_fire_trail",
				name = "fire",
				local_arrow_trail_particle = "fx/fire_arrow_trail",
				unlock_key = 54,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_fire_fluff",
				release_name = "sherwood",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_fire_dummy",
				ui_header = "bow_head_fire_header",
				kill_effect = true,
				damage_type = "slashing_projectile2",
				market_price = 25000,
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_fire",
				multipliers = {
					gravity = 3,
					damage = 1,
					amunition_amount = 1
				},
				properties = {
					"burning"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0016_fire_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0016_fire_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_barbed_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "barbed",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 55,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_barbed_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_barbed_dummy",
				market_price = 4000,
				ui_header = "bow_head_barbed_header",
				release_name = "main",
				damage_type = "piercing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_barbed",
				multipliers = {
					gravity = 1,
					damage = 0.9,
					amunition_amount = 1.4
				},
				properties = {
					"bleeding"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0020_barbed_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0020_barbed_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_bodkin_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "bodkin",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 56,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_bodkin_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_long_bodkin_dummy",
				market_price = 4000,
				ui_header = "bow_head_bodkin_header",
				release_name = "main",
				damage_type = "slashing_projectile2",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_long_bodkin",
				multipliers = {
					gravity = 0.8,
					damage = 1,
					amunition_amount = 0.8
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0018_bodkin_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0018_bodkin_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "bow_head_armour_piercing_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "armour_piercing",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 57,
				parent_link_node = "a_right_hand",
				ui_fluff_text = "bow_head_armour_piercing_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_short_bodkin_dummy",
				market_price = 4000,
				ui_header = "bow_head_armour_piercing_header",
				release_name = "main",
				damage_type = "piercing_projectile3",
				unit = "units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_short_bodkin",
				multipliers = {
					gravity = 1,
					damage = 0.9,
					amunition_amount = 1
				},
				properties = {
					"penetration"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0019_armour_piercing_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0019_armour_piercing_head",
					"menu_attachment_icon_32_0034_background"
				}
			}
		}
	},
	crossbow = {
		misc = {
			{
				ui_description = "crossbow_double_quiver_description",
				ui_header = "crossbow_double_quiver_header",
				name = "double_quiver",
				market_price = 4000,
				unlock_key = 58,
				unlock_this_item = false,
				ui_fluff_text = "crossbow_double_quiver_fluff",
				release_name = "main",
				multipliers = {
					encumbrance = 2,
					amunition_regeneration = 0.5,
					amunition_amount = 2
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0001_double_quiver",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0001_double_quiver",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_safety_description",
				ui_header = "crossbow_safety_header",
				name = "safety",
				market_price = 4000,
				unlock_key = 59,
				release_name = "main",
				ui_fluff_text = "crossbow_safety_fluff",
				multipliers = {
					reload_speed = 1.5,
					amunition_regeneration = 0.5
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {}
			}
		},
		reload_mechanism = {
			{
				ui_description = "crossbow_reload_none_description",
				ui_header = "crossbow_reload_none_header",
				name = "crossbow_reload_none",
				release_name = "main",
				unlock_key = 61,
				ui_fluff_text = "crossbow_reload_none_fluff",
				multipliers = {
					crossbow_hit = 1,
					crossbow_hit_section = 1,
					damage = 1,
					reload_speed = 1,
					crossbow_miss = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {}
			},
			{
				ui_description = "crossbow_reload_pull_lever_description",
				ui_header = "crossbow_reload_pull_lever_header",
				name = "crossbow_reload_pull_lever",
				market_price = 4000,
				unlock_key = 62,
				release_name = "main",
				ui_fluff_text = "crossbow_reload_pull_lever_fluff",
				multipliers = {
					crossbow_hit = 4.5,
					crossbow_hit_section = -4,
					damage = 0.95,
					reload_speed = 1.4,
					crossbow_miss = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0038_Crossbow_reload_pull_lever",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0038_Crossbow_reload_pull_lever",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_reload_push_lever_description",
				ui_header = "crossbow_reload_push_lever_header",
				name = "crossbow_reload_push_lever",
				market_price = 4000,
				unlock_key = 63,
				release_name = "main",
				ui_fluff_text = "crossbow_reload_push_lever_fluff",
				multipliers = {
					crossbow_hit = 3.5,
					crossbow_hit_section = -3,
					damage = 0.95,
					reload_speed = 1.2,
					crossbow_miss = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0037_Crossbow_reload_push_lever",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0037_Crossbow_reload_push_lever",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_reload_windlass_description",
				ui_header = "crossbow_reload_windlass_header",
				name = "crossbow_reload_windlass",
				market_price = 4000,
				unlock_key = 65,
				release_name = "main",
				ui_fluff_text = "crossbow_reload_windlass_fluff",
				multipliers = {
					crossbow_hit = 0.3,
					crossbow_hit_section = -1,
					damage = 1.4,
					reload_speed = 2.5,
					crossbow_miss = 0.5
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0035_Crossbow_reload_windlass",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0035_Crossbow_reload_windlass",
					"menu_attachment_icon_32_0034_background"
				}
			}
		},
		projectile_heads = {
			{
				ui_description = "crossbow_head_standard_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "standard",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 66,
				parent_link_node = "a_left_weap_13",
				ui_fluff_text = "crossbow_head_standard_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_standard/wpn_crossbow_bolt_standard_dummy",
				release_name = "main",
				ui_header = "crossbow_head_standard_header",
				damage_type = "piercing_projectile",
				unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_standard/wpn_crossbow_bolt_standard",
				multipliers = {
					gravity = 1,
					damage = 1,
					amunition_amount = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0021_standard_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0021_standard_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_head_hammer_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "hammer",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 67,
				parent_link_node = "a_left_weap_13",
				ui_fluff_text = "crossbow_head_hammer_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_hammerbolt/wpn_crossbow_bolt_hammerbolt_dummy",
				market_price = 4000,
				ui_header = "crossbow_head_hammer_header",
				release_name = "main",
				damage_type = "blunt",
				unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_hammerbolt/wpn_crossbow_bolt_hammerbolt",
				properties = {
					"stun"
				},
				multipliers = {
					gravity = 4,
					damage = 0.5,
					amunition_amount = 0.5
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0017_hammer_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0017_hammer_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_head_frogleg_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "frogleg",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 68,
				parent_link_node = "a_left_weap_13",
				ui_fluff_text = "crossbow_head_frogleg_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_frogleg/wpn_crossbow_bolt_frogleg_dummy",
				market_price = 4000,
				ui_header = "crossbow_head_frogleg_header",
				release_name = "main",
				damage_type = "slashing_projectile",
				unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_frogleg/wpn_crossbow_bolt_frogleg",
				multipliers = {
					gravity = 1,
					damage = 1.3,
					amunition_amount = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0015_frogleg_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0015_frogleg_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_head_broad_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "broad",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 69,
				parent_link_node = "a_left_weap_13",
				ui_fluff_text = "crossbow_head_broad_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_whalerhead/wpn_crossbow_bolt_whalerhead_dummy",
				market_price = 4000,
				ui_header = "crossbow_head_broad_header",
				release_name = "main",
				damage_type = "piercing_projectile",
				unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_whalerhead/wpn_crossbow_bolt_whalerhead",
				multipliers = {
					gravity = 1.2,
					damage = 0.8,
					amunition_amount = 0.8
				},
				properties = {
					"bleeding"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0014_broadhead_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0014_broadhead_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_head_fire_description",
				remote_arrow_trail_particle = "fx/remote_fire_trail",
				name = "fire",
				local_arrow_trail_particle = "fx/fire_arrow_trail",
				unlock_key = 70,
				parent_link_node = "a_left_weap_13",
				ui_fluff_text = "crossbow_head_fire_fluff",
				release_name = "sherwood",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_firebolt/wpn_crossbow_bolt_firebolt_dummy",
				ui_header = "crossbow_head_fire_header",
				kill_effect = true,
				damage_type = "piercing_projectile",
				market_price = 25000,
				unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_firebolt/wpn_crossbow_bolt_firebolt",
				multipliers = {
					gravity = 3,
					damage = 0.7,
					amunition_amount = 1
				},
				properties = {
					"burning"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0016_fire_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0016_fire_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_head_barbed_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "barbed",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 71,
				parent_link_node = "a_left_weap_13",
				ui_fluff_text = "crossbow_head_barbed_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_standard/wpn_crossbow_bolt_standard_dummy",
				market_price = 4000,
				ui_header = "crossbow_head_barbed_header",
				release_name = "main",
				damage_type = "piercing_projectile",
				unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_standard/wpn_crossbow_bolt_standard",
				multipliers = {
					gravity = 1,
					damage = 0.8,
					amunition_amount = 1.4
				},
				properties = {
					"bleeding"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0020_barbed_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0020_barbed_head",
					"menu_attachment_icon_32_0034_background"
				}
			},
			{
				ui_description = "crossbow_head_armour_piercing_description",
				remote_arrow_trail_particle = "fx/arrow_trail",
				name = "armour_piercing",
				local_arrow_trail_particle = "fx/player_arrow_trail",
				unlock_key = 72,
				parent_link_node = "a_left_weap_13",
				ui_fluff_text = "crossbow_head_armour_piercing_fluff",
				dummy_unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_standard/wpn_crossbow_bolt_standard_dummy",
				market_price = 4000,
				ui_header = "crossbow_head_armour_piercing_header",
				release_name = "main",
				damage_type = "piercing_projectile",
				unit = "units/weapons/wpn_projectiles/wpn_crossbow_bolt_standard/wpn_crossbow_bolt_standard",
				multipliers = {
					gravity = 1,
					damage = 0.9,
					amunition_amount = 1
				},
				properties = {
					"penetration"
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0019_armour_piercing_head",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {
					"menu_attachment_icon_32_0000_overlay",
					"menu_attachment_icon_32_0019_armour_piercing_head",
					"menu_attachment_icon_32_0034_background"
				}
			}
		}
	},
	handgonne = {
		projectile_heads = {
			{
				ui_description = "handgonne_head_standard_description",
				ui_header = "handgonne_head_standard_header",
				name = "standard",
				damage_type = "blunt_projectile",
				unlock_key = 73,
				release_name = "burgundy",
				ui_fluff_text = "handgonne_head_standard_fluff",
				properties = {
					"stun"
				},
				multipliers = {
					damage = 1,
					reload_speed = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {}
			}
		}
	},
	arquebus = {
		projectile_heads = {
			{
				ui_description = "handgonne_head_standard_description",
				ui_header = "handgonne_head_standard_header",
				name = "standard",
				damage_type = "blunt_projectile",
				unlock_key = 74,
				release_name = "burgundy",
				ui_fluff_text = "handgonne_head_standard_fluff",
				properties = {
					"stun"
				},
				multipliers = {
					damage = 1,
					reload_speed = 1
				},
				ui_textures_big = {
					"menu_attachment_icon_128_0000_overlay",
					"menu_attachment_icon_128_0034_background"
				},
				ui_textures_small = {}
			}
		}
	}
}

local unlock_keys = {}

for _, category1 in pairs(GearAttachments) do
	for _, category2 in pairs(category1) do
		for _, attachment in pairs(category2) do
			fassert(unlock_keys[attachment.unlock_key] == nil, "Unlock key %d already exists", unlock_key)

			unlock_keys[attachment.unlock_key] = true
		end
	end
end

unlock_keys = nil
