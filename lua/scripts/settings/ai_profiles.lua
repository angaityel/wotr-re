-- chunkname: @scripts/settings/ai_profiles.lua

AIProfiles = {
	debug_ai_profile = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "armour_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			times = {
				max = 10,
				min = 5
			},
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			}
		},
		properties = {
			tethered = false,
			tether_time = 5,
			difficulty = AIProperties.difficulty.medium
		}
	},
	peasant_rake_01_lan = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "armour_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	peasant_rake_01_aionly_lan = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "armour_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	peasant_dagger_01_lan = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "armour_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	peasant_dagger_01_aionly_lan = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "armour_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	peasant_archer_01_lan = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Huntsman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "hunting_bow"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			},
			{
				name = "hunting_bow",
				attachments = {
					projectile_head = {
						"standard"
					},
					misc = {}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_cloth_hood",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 5,
			ranged_attack_cooldown = 20,
			charge_time_max = 4,
			accuracy = 0.6,
			max_horizontal_spread = 5,
			tethered = false,
			tether_time = 0,
			charge_time_min = 2,
			block_chance = 0.7
		}
	},
	peasant_archer_01_aionly_lan = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Huntsman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "hunting_bow"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			},
			{
				name = "hunting_bow",
				attachments = {
					projectile_head = {
						"standard"
					},
					misc = {}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_cloth_hood",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 5,
			ranged_attack_cooldown = 20,
			charge_time_max = 4,
			accuracy = 0.6,
			max_horizontal_spread = 5,
			tethered = false,
			tether_time = 0,
			charge_time_min = 2,
			block_chance = 0.7
		}
	},
	footman_light_sword_01_lan = {
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "Lancaster light",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "archer",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "arming_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {},
					wooden_shield_woodwork = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_cover = {
						"standard"
					}
				}
			},
			{
				name = "arming_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armorycap",
			show_crest = false,
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.3,
			accuracy = 0.9,
			tether_time = 10,
			charge_time_min = 0.1,
			max_vertical_spread = 1,
			block_chance = 1,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_light_sword_01_aionly_lan = {
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "Lancaster light",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "archer",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "arming_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {},
					wooden_shield_woodwork = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_cover = {
						"standard"
					}
				}
			},
			{
				name = "arming_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armorycap",
			show_crest = false,
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						0,
						100,
						0
					}
				},
				passive = {
					value = 50,
					state_percents = {
						0,
						100,
						0
					}
				},
				panic = {
					value = 15,
					state_percents = {
						0,
						100,
						0
					}
				}
			},
			times = {
				max = 7,
				min = 4
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.6,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_light_sword_guard_01_lan = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Footman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_bascinet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_and_black_preorder",
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 5,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	archer_light_01_lan = {
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "Longbowman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		gear = {
			{
				name = "longbow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_kettlehelm_round",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_and_black_preorder",
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 30
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 2,
			ranged_attack_cooldown = 10,
			charge_time_max = 3,
			accuracy = 0.6,
			max_horizontal_spread = 2,
			tethered = false,
			tether_time = 0,
			charge_time_min = 1,
			block_chance = 0.7
		}
	},
	archer_light_01_aionly_lan = {
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "Longbowman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		gear = {
			{
				name = "longbow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_kettlehelm_round",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_and_black_preorder",
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 30
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 2,
			ranged_attack_cooldown = 10,
			charge_time_max = 3,
			accuracy = 0.6,
			max_horizontal_spread = 2,
			tethered = false,
			tether_time = 3,
			charge_time_min = 1,
			block_chance = 0.7
		}
	},
	archer_light_02_lan = {
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "Longbowman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		gear = {
			{
				name = "longbow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_kettlehelm_round",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_and_black_preorder",
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 50
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 2,
			ranged_attack_cooldown = 10,
			charge_time_max = 2,
			accuracy = 1,
			max_horizontal_spread = 2,
			tethered = false,
			tether_time = 0,
			charge_time_min = 0.75,
			block_chance = 0.7
		}
	},
	archer_light_02_aionly_lan = {
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "Longbowman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		gear = {
			{
				name = "longbow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_kettlehelm_round",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_and_black_preorder",
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 50
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 2,
			ranged_attack_cooldown = 10,
			charge_time_max = 2,
			accuracy = 0.7,
			max_horizontal_spread = 2,
			tethered = false,
			tether_time = 3,
			charge_time_min = 0.75,
			block_chance = 0.7
		}
	},
	footman_medium_sword_01_lan = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Footman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_bascinet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_and_black_preorder",
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_medium_sword_01_aionly_lan = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Footman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_bascinet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_and_black_preorder",
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_medium_scottish_sword_01_lan = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Footman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_bascinet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_and_black_preorder",
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_medium_poleaxe_01_lan = {
		head = "knight",
		display_name = "Mounted Knight",
		armour = "armour_medium_tights",
		armour_attachments = {
			patterns = 3
		},
		wielded_gear = {
			{
				name = "long_axe"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "long_axe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "short_simple_bill",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			}
		},
		helmet = {
			name = "helmet_barbute",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "mail_coif_01"
			}
		},
		perks = {
			movement_basic = "cavalry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms"
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_medium_poleaxe_01_aionly_lan = {
		head = "knight",
		display_name = "Mounted Knight",
		armour = "armour_medium_tights",
		armour_attachments = {
			patterns = 3
		},
		wielded_gear = {
			{
				name = "long_axe"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "long_axe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "short_simple_bill",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			}
		},
		helmet = {
			name = "helmet_barbute",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "mail_coif_01"
			}
		},
		perks = {
			movement_basic = "cavalry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms"
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_scottish_sword_01_lan = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 17
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "bevor_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_scottish_sword_01_aionly_lan = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 17
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "bevor_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_longsword_01_lan = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 17
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "bevor_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_longsword_01_aionly_lan = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 17
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "bevor_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_poleaxe_01_lan = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 17
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "poleaxe"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "poleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "bevor_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 25
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	boss_footman_heavy_sword_01_lan = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 17
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "battleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {
						"buckle"
					},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "bevor_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "melee_manager"
				},
				{
					main = "melee_offensive"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.9,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	boss_footman_medium_pollaxe_01_lan = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 17
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "battleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {
						"buckle"
					},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_details",
				coif = "bevor_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "melee_manager"
				},
				{
					main = "melee_offensive"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.9,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	crossbow_light_01_lan = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Crossbowman",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "hunting_crossbow"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			},
			{
				name = "hunting_crossbow",
				attachments = {
					projectile_head = {
						"standard"
					},
					reload_mechanism = {
						"crossbow_reload_none"
					},
					misc = {}
				}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_medium_kettlehat",
			show_crest = false,
			attachments = {
				pattern = "pattern_red_knight",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 0,
			ranged_attack_cooldown = 10,
			charge_time_max = 0.75,
			accuracy = 1,
			max_horizontal_spread = 0,
			tethered = false,
			tether_time = 0,
			charge_time_min = 0.25,
			block_chance = 0.7
		}
	},
	peasant_rake_01_yor = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	peasant_rake_01_aionly_yor = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	peasant_dagger_01_yor = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	peasant_dagger_01_aionly_yor = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Militia",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "peasant_polearm"
			}
		},
		gear = {
			{
				name = "peasant_polearm",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "mace",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "pointed_stick",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_peasant_cap",
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	peasant_archer_01_yor = {
		head = "peasant",
		armour = "armour_light_peasant_rags",
		display_name = "Huntsman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "archer",
			defensive_basic = "armour_training"
		},
		wielded_gear = {
			{
				name = "hunting_bow"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			},
			{
				name = "hunting_bow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_cloth_hat",
			show_crest = false,
			attachments = {
				pattern = "pattern_white_and_blue_preorder"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 5,
			ranged_attack_cooldown = 20,
			charge_time_max = 4,
			accuracy = 0.6,
			max_horizontal_spread = 5,
			tethered = false,
			tether_time = 0,
			charge_time_min = 2,
			block_chance = 0.7
		}
	},
	footman_light_sword_01_yor = {
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "York light",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_leather_cap",
			show_crest = false,
			attachments = {
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						0,
						100,
						0
					}
				},
				passive = {
					value = 50,
					state_percents = {
						0,
						100,
						0
					}
				},
				panic = {
					value = 15,
					state_percents = {
						0,
						100,
						0
					}
				}
			},
			times = {
				max = 7,
				min = 4
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.6,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_light_sword_01_aionly_yor = {
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "York light",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_light_leather_cap",
			show_crest = false,
			attachments = {
				coif = "armorycap"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						0,
						100,
						0
					}
				},
				passive = {
					value = 50,
					state_percents = {
						0,
						100,
						0
					}
				},
				panic = {
					value = 15,
					state_percents = {
						0,
						100,
						0
					}
				}
			},
			times = {
				max = 7,
				min = 4
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 3,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.6,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_light_sword_guard_01_yor = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Footman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 5,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	archer_light_01_yor = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Longbowman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		gear = {
			{
				name = "longbow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_kettlehelm_round",
			show_crest = false,
			attachments = {
				pattern = "pattern_white_and_blue_preorder",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 30
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 2,
			ranged_attack_cooldown = 10,
			charge_time_max = 3,
			accuracy = 0.6,
			max_horizontal_spread = 2,
			tethered = false,
			tether_time = 0,
			charge_time_min = 1,
			block_chance = 0.7
		}
	},
	archer_light_01_aionly_yor = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Longbowman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		gear = {
			{
				name = "longbow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_kettlehelm_round",
			show_crest = false,
			attachments = {
				pattern = "pattern_white_and_blue_preorder",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 30
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 2,
			ranged_attack_cooldown = 10,
			charge_time_max = 3,
			accuracy = 0.6,
			max_horizontal_spread = 2,
			tethered = false,
			tether_time = 3,
			charge_time_min = 1,
			block_chance = 0.7
		}
	},
	archer_light_02_yor = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Longbowman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		gear = {
			{
				name = "longbow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_kettlehelm_round",
			show_crest = false,
			attachments = {
				pattern = "pattern_white_and_blue_preorder",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 50
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 2,
			ranged_attack_cooldown = 10,
			charge_time_max = 0.75,
			accuracy = 1,
			max_horizontal_spread = 2,
			tethered = false,
			tether_time = 0,
			charge_time_min = 0.25,
			block_chance = 0.7
		}
	},
	archer_light_02_aionly_yor = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Longbowman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		gear = {
			{
				name = "longbow",
				attachments = {
					misc = {},
					projectile_head = {
						"standard"
					}
				}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_kettlehelm_round",
			show_crest = false,
			attachments = {
				pattern = "pattern_white_and_blue_preorder",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 50
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "ai_only_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 2,
			ranged_attack_cooldown = 10,
			charge_time_max = 2,
			accuracy = 0.7,
			max_horizontal_spread = 2,
			tethered = false,
			tether_time = 3,
			charge_time_min = 0.75,
			block_chance = 0.7
		}
	},
	footman_medium_sword_01_yor = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Footman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_medium_scottish_sword_01_yor = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Footman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "targe"
			}
		},
		gear = {
			{
				name = "targe",
				attachments = {}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_medium_poleaxe_01_yor = {
		head = "knight",
		display_name = "Mounted Knight",
		armour = "armour_medium_tights",
		armour_attachments = {
			patterns = 2
		},
		wielded_gear = {
			{
				name = "poleaxe"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "short_simple_bill",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "poleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_bascinet",
			show_crest = false,
			attachments = {
				pattern = "pattern_white_and_blue_preorder",
				coif = "mail_coif_01"
			}
		},
		perks = {
			movement_basic = "cavalry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms"
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_scottish_sword_01_yor = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 18
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "battleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {
						"buckle"
					},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_polished",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_longsword_01_yor = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 18
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "battleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {
						"buckle"
					},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_polished",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_poleaxe_01_yor = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 18
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "battleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {
						"buckle"
					},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_polished",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 25
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	boss_footman_heavy_sword_01_yor = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 18
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "battleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {
						"buckle"
					},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_polished",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "melee_manager"
				},
				{
					main = "melee_offensive"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.9,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	boss_footman_medium_pollaxe_01_yor = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 18
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "battleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {
						"buckle"
					},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_polished",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "melee_manager"
				},
				{
					main = "melee_offensive"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.9,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	crossbow_light_01_yor = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "Crossbowman",
		armour_attachments = {
			patterns = 2
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "archer",
			officer_basic = "officer_training"
		},
		wielded_gear = {
			{
				name = "hunting_crossbow"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					}
				}
			},
			{
				name = "hunting_crossbow",
				attachments = {
					projectile_head = {
						"standard"
					},
					reload_mechanism = {
						"crossbow_reload_none"
					},
					misc = {}
				}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_medium_kettlehat",
			show_crest = false,
			attachments = {
				pattern = "pattern_white_and_blue_preorder",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "ranged"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			max_vertical_spread = 0,
			ranged_attack_cooldown = 10,
			charge_time_max = 0.75,
			accuracy = 1,
			max_horizontal_spread = 0,
			tethered = false,
			tether_time = 0,
			charge_time_min = 0.25,
			block_chance = 0.7
		}
	},
	footman_medium_axe_01_war = {
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "FootmanWarwck",
		armour_attachments = {
			patterns = 16
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			offensive_basic = "man_at_arms"
		},
		wielded_gear = {
			{
				name = "short_pronged_bill"
			},
			{
				name = "steel_domed_shield"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "steel_domed_shield",
				attachments = {
					plate_shield_plate = {
						"hardened_steel"
					}
				}
			},
			{
				name = "short_pronged_bill",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_barbute",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	boss_warwick_01_war = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "Footknight",
		armour_attachments = {
			patterns = 18
		},
		perks = {
			movement_basic = "infantry",
			officer_basic = "officer_training",
			offensive_basic = "man_at_arms",
			defensive_basic = "shield_bearer"
		},
		wielded_gear = {
			{
				name = "scottish_sword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "scottish_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "battleaxe",
				attachments = {
					fighting_style = {
						"english_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"flat"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "targe",
				attachments = {
					wooden_shield_buckle = {
						"buckle"
					},
					wooden_shield_cover = {
						"standard"
					},
					wooden_shield_rim = {
						"norim"
					},
					wooden_shield_woodwork = {
						"standard"
					}
				}
			}
		},
		helmet = {
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_polished",
				coif = "mail_coif_01"
			}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 20
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "melee_manager"
				},
				{
					main = "melee_offensive"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.9,
			tethered = false,
			max_horizontal_spread = 1
		}
	},
	footman_heavy_sword_01_war = {
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "FootknightWarwick",
		armour_attachments = {
			patterns = 3
		},
		perks = {
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			offensive_basic = "man_at_arms"
		},
		wielded_gear = {
			{
				name = "longsword"
			}
		},
		gear = {
			{
				name = "ballock_dagger",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					}
				}
			},
			{
				name = "longsword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"hardened_steel"
					},
					edge_grind = {
						"flat"
					}
				}
			}
		},
		helmet = {
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		},
		perception = {
			filter = "ai_player_scan",
			radius = 15
		},
		brain = {
			behaviours = {
				{
					avoidance = "default_avoidance"
				},
				{
					targeting = "default_targeting"
				},
				{
					pathing = "default_pathing"
				},
				{
					morale_manager = "nil_tree"
				},
				{
					main = "melee"
				}
			}
		},
		morale = {
			states = {
				active = {
					value = 100,
					state_percents = {
						80,
						19,
						1
					}
				},
				passive = {
					value = 50,
					state_percents = {
						35,
						60,
						5
					}
				},
				panic = {
					value = 15,
					state_percents = {
						20,
						70,
						10
					}
				}
			},
			times = {
				max = 10,
				min = 5
			}
		},
		properties = {
			charge_time_max = 0.75,
			accuracy = 0.9,
			tether_time = 0,
			charge_time_min = 0.25,
			max_vertical_spread = 3,
			block_chance = 0.7,
			tethered = false,
			max_horizontal_spread = 1
		}
	}
}

require("scripts/settings/profiling_profiles")
