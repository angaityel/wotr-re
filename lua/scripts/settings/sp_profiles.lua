-- chunkname: @scripts/settings/sp_profiles.lua

require("scripts/settings/perk_settings")

SPProfiles = {
	{
		head = "squire",
		no_editing = true,
		display_name = "1 Footman",
		armour = "armour_medium_tights",
		unlock_key = "footman",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "watchman",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "armour",
			offensive_specialization_2 = "break_block",
			supportive_specialization_2 = "spotter",
			defensive_basic = "shield_bearer",
			defensive_specialization_2 = "shield_expert",
			defensive_specialization_1 = "shield_wall",
			movement_basic = "infantry",
			officer_basic = "officer_training",
			supportive_specialization_1 = "keen_eyes",
			movement_specialization_1 = "runner",
			offensive_specialization_1 = "shield_breaker",
			offensive_basic = "man_at_arms"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "steel_domed_shield"
			}
		},
		gear = {
			{
				name = "steel_domed_shield",
				attachments = {
					plate_shield_plate = {
						"steel"
					}
				}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"italian_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"convex"
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
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard",
				visor = "visor_standard",
				coif = "bevor_01"
			}
		}
	},
	{
		head = "squire",
		no_editing = true,
		display_name = "2 Longbowman",
		armour = "armour_light_tabard",
		unlock_key = "archer",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "watchman",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "march_speed",
			offensive_specialization_2 = "strong_of_arm",
			supportive_specialization_2 = "spotter",
			defensive_basic = "shield_bearer",
			defensive_specialization_1 = "shield_wall",
			defensive_specialization_2 = "shield_bash",
			movement_basic = "infantry",
			officer_basic = "officer_training",
			supportive_specialization_1 = "keen_eyes",
			movement_specialization_1 = "runner",
			offensive_specialization_1 = "longbowman",
			offensive_basic = "archer"
		},
		wielded_gear = {
			{
				name = "longbow"
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
				name = "targe",
				attachments = {
					wooden_shield_buckle = {},
					wooden_shield_woodwork = {
						"hardwood"
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
				name = "short_sword",
				attachments = {
					fighting_style = {
						"italian_style"
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
				name = "longbow",
				attachments = {
					misc = {
						"footed_shafts"
					},
					projectile_head = {
						"standard"
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
		}
	},
	{
		head = "knight",
		no_editing = true,
		display_name = "3 Crossbowman",
		armour = "armour_medium_tights",
		unlock_key = "crossbowman",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "watchman",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "replenish",
			offensive_specialization_2 = "forest_warden",
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			supportive_specialization_2 = "spotter",
			defensive_specialization_1 = "shield_bash",
			officer_basic = "officer_training",
			supportive_specialization_1 = "keen_eyes",
			movement_specialization_1 = "runner",
			offensive_specialization_1 = "nimble_minded",
			offensive_basic = "archer"
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
				name = "hunting_crossbow",
				attachments = {
					misc = {
						"safety"
					},
					reload_mechanism = {
						"crossbow_reload_none"
					},
					projectile_head = {
						"standard"
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
						"hardwood"
					}
				}
			}
		},
		helmet = {
			name = "helmet_medium_kettlehat",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard",
				coif = "armorycap"
			}
		}
	},
	{
		head = "peasant",
		armour = "armour_light_tabard",
		display_name = "4 Forest",
		gear = {
			{
				name = "ballock_dagger",
				attachments = {}
			},
			{
				name = "short_sword",
				attachments = {
					fighting_style = {
						"english_style"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"flat"
					},
					pommel = {
						"standard"
					}
				}
			},
			{
				name = "hunting_crossbow",
				attachments = {
					misc = {
						"safety"
					},
					reload_mechanism = {
						"crossbow_reload_none"
					},
					projectile_head = {
						"standard"
					}
				}
			}
		},
		wielded_gear = {
			{
				name = "hunting_crossbow"
			}
		},
		helmet = {
			show_crest = false,
			name = "helmet_medium_kettlehat",
			attachments = {
				coif = "mail_coif_01"
			}
		},
		perks = {
			movement_basic = "infantry",
			offensive_specialization_1 = "marksman_training",
			offensive_basic = "archer",
			offensive_specialization_2 = "sleight_of_hand"
		},
		armour_attachments = {
			patterns = 1
		}
	},
	{
		head = "squire",
		armour = "armour_light_tabard",
		display_name = "5 Tournament Standard",
		armour_attachments = {
			patterns = 16
		},
		perks = {
			defensive_specialization_1 = "thick_skinned",
			movement_specialization_2 = "fleet_footed",
			defensive_specialization_2 = "regenerative",
			movement_specialization_1 = "runner",
			movement_basic = "infantry",
			defensive_basic = "armour_training"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
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
			}
		},
		helmet = {
			name = "helmet_light_leather_cap",
			show_crest = false,
			attachments = {
				coif = "armorycap"
			}
		}
	},
	{
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "6 Heavy Crossbowman",
		mount = "barded_horse2",
		gear = {
			{
				name = "ballock_dagger",
				attachments = {}
			},
			{
				name = "longsword",
				attachments = {}
			}
		},
		wielded_gear = {
			{
				name = "longsword"
			}
		},
		helmet = {
			show_crest = false,
			name = "helmet_sallet",
			attachments = {
				visor = "visor_standard",
				bevor = "bevor_01"
			}
		},
		perks = {
			supportive_basic = "watchman",
			movement_specialization_2 = "horse_racer",
			officer_specialization_1 = "reinforce",
			offensive_specialization_2 = "sleight_of_hand",
			movement_basic = "cavalry",
			defensive_basic = "armour_training",
			officer_specialization_2 = "mounted_speed",
			officer_basic = "officer_training",
			movement_specialization_1 = "heavy_cavalry",
			offensive_specialization_1 = "marksman_training",
			offensive_basic = "archer"
		},
		armour_attachments = {
			patterns = 1
		}
	},
	{
		head = "knight",
		armour = "armour_heavy_fullplate",
		display_name = "7 Field",
		mount = "standard_horse1",
		armour_attachments = {
			patterns = 1
		},
		wielded_gear = {
			{
				name = "war_lance"
			},
			{
				name = "steel_domed_shield"
			}
		},
		gear = {
			{
				name = "war_lance",
				attachments = {
					lance_tip = {
						"sharp"
					},
					lance_shaft = {
						"standard"
					}
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
						"steel"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard",
				coif = "bevor_01"
			}
		},
		perks = {
			defensive_basic = "shield_bearer",
			offensive_specialization_2 = "shield_breaker",
			movement_basic = "cavalry",
			offensive_specialization_1 = "highwayman",
			offensive_basic = "man_at_arms"
		}
	},
	{
		head = "squire",
		no_editing = true,
		display_name = "8 Tournament Longbowman",
		armour = "armour_light_tabard",
		unlock_key = "archer",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "watchman",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "march_speed",
			offensive_specialization_2 = "strong_of_arm",
			supportive_specialization_2 = "spotter",
			defensive_basic = "shield_bearer",
			defensive_specialization_1 = "shield_wall",
			defensive_specialization_2 = "shield_bash",
			movement_basic = "infantry",
			officer_basic = "officer_training",
			supportive_specialization_1 = "keen_eyes",
			movement_specialization_1 = "runner",
			offensive_specialization_1 = "longbowman",
			offensive_basic = "archer"
		},
		wielded_gear = {
			{
				name = "longbow"
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
				name = "targe",
				attachments = {
					wooden_shield_buckle = {},
					wooden_shield_woodwork = {
						"hardwood"
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
				name = "short_sword",
				attachments = {
					fighting_style = {
						"italian_style"
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
				name = "longbow",
				attachments = {
					misc = {
						"footed_shafts"
					},
					projectile_head = {
						"standard"
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
		}
	},
	{
		head = "squire",
		no_editing = true,
		display_name = "9 Tournament Footman",
		armour = "armour_medium_tights",
		unlock_key = "footman",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "watchman",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "armour",
			offensive_specialization_2 = "break_block",
			supportive_specialization_2 = "spotter",
			defensive_basic = "shield_bearer",
			defensive_specialization_2 = "shield_expert",
			defensive_specialization_1 = "shield_wall",
			movement_basic = "infantry",
			officer_basic = "officer_training",
			supportive_specialization_1 = "keen_eyes",
			movement_specialization_1 = "runner",
			offensive_specialization_1 = "shield_breaker",
			offensive_basic = "man_at_arms"
		},
		wielded_gear = {
			{
				name = "castillon_sword"
			},
			{
				name = "steel_domed_shield"
			}
		},
		gear = {
			{
				name = "steel_domed_shield",
				attachments = {
					plate_shield_plate = {
						"steel"
					}
				}
			},
			{
				name = "castillon_sword",
				attachments = {
					fighting_style = {
						"italian_style"
					},
					pommel = {
						"standard"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"convex"
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
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard",
				visor = "visor_standard",
				coif = "bevor_01"
			}
		}
	},
	{
		head = "knight",
		no_editing = true,
		display_name = "10 Tournament Footknight",
		armour = "armour_heavy_fullplate",
		unlock_key = "footknight",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "surgeon",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "berserker",
			supportive_specialization_2 = "barber_surgeon",
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			defensive_specialization_1 = "hardened",
			defensive_specialization_2 = "regenerative",
			officer_basic = "officer_training",
			supportive_specialization_1 = "sterilised_bandages",
			movement_specialization_1 = "city_watch",
			offensive_specialization_1 = "shield_breaker",
			offensive_basic = "man_at_arms"
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
				name = "poleaxe",
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
				name = "longsword",
				attachments = {
					fighting_style = {
						"german_style"
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
				pattern = "pattern_standard",
				visor = "visor_pigface",
				coif = "armorycap"
			}
		}
	},
	{
		head = "knight",
		no_editing = true,
		display_name = "Tournament 11 Footknight",
		armour = "armour_heavy_fullplate",
		unlock_key = "footknight",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "surgeon",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "berserker",
			supportive_specialization_2 = "barber_surgeon",
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			defensive_specialization_1 = "hardened",
			defensive_specialization_2 = "regenerative",
			officer_basic = "officer_training",
			supportive_specialization_1 = "sterilised_bandages",
			movement_specialization_1 = "city_watch",
			offensive_specialization_1 = "shield_breaker",
			offensive_basic = "man_at_arms"
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
				name = "poleaxe",
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
				name = "longsword",
				attachments = {
					fighting_style = {
						"german_style"
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
				pattern = "pattern_standard",
				visor = "visor_pigface",
				coif = "armorycap"
			}
		}
	},
	{
		head = "knight",
		no_editing = true,
		display_name = "12 Tournament Footknight",
		armour = "armour_heavy_fullplate",
		unlock_key = "footknight",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "surgeon",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "berserker",
			supportive_specialization_2 = "barber_surgeon",
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			defensive_specialization_1 = "hardened",
			defensive_specialization_2 = "regenerative",
			officer_basic = "officer_training",
			supportive_specialization_1 = "sterilised_bandages",
			movement_specialization_1 = "city_watch",
			offensive_specialization_1 = "shield_breaker",
			offensive_basic = "man_at_arms"
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
				name = "poleaxe",
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
				name = "longsword",
				attachments = {
					fighting_style = {
						"german_style"
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
				pattern = "pattern_standard",
				visor = "visor_pigface",
				coif = "armorycap"
			}
		}
	},
	{
		head = "knight",
		no_editing = true,
		display_name = "13 Tournament Crossbowman",
		armour = "armour_medium_tights",
		unlock_key = "crossbowman",
		armour_attachments = {
			patterns = 1
		},
		perks = {
			supportive_basic = "watchman",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "replenish",
			offensive_specialization_2 = "forest_warden",
			movement_basic = "infantry",
			defensive_basic = "shield_bearer",
			supportive_specialization_2 = "spotter",
			defensive_specialization_1 = "shield_bash",
			officer_basic = "officer_training",
			supportive_specialization_1 = "keen_eyes",
			movement_specialization_1 = "runner",
			offensive_specialization_1 = "nimble_minded",
			offensive_basic = "archer"
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
				name = "hunting_crossbow",
				attachments = {
					misc = {
						"safety"
					},
					reload_mechanism = {
						"crossbow_reload_none"
					},
					projectile_head = {
						"standard"
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
						"hardwood"
					}
				}
			}
		},
		helmet = {
			name = "helmet_medium_kettlehat",
			show_crest = false,
			attachments = {
				pattern = "pattern_standard",
				coif = "armorycap"
			}
		}
	},
	{
		head = "knight",
		mount = "standard_horse4",
		display_name = "14 Tournament Racer",
		market_price = 12000,
		unlock_key = "customizable_profile_3",
		armour = "armour_light_tabard",
		armour_attachments = {
			patterns = 13
		},
		perks = {
			movement_basic = "cavalry"
		},
		wielded_gear = {
			{
				name = "arming_sword"
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
				name = "tournament_lance",
				attachments = {
					lance_tip = {
						"sharp"
					},
					lance_shaft = {
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
			name = "helmet_light_leather_cap",
			show_crest = false,
			attachments = {
				coif = "armorycap"
			}
		}
	}
}
