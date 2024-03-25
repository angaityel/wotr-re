-- chunkname: @scripts/settings/profiling_profiles.lua

AIProfiles.profiling_ai_red_1 = AIProfiles.profiling_ai_red_1 or {
	head = "peasant",
	armour = "armour_light_peasant_rags",
	display_name = "Profiling AI",
	mount = "barded_horse1",
	gear = {
		{
			name = "peasant_polearm",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "peasant_polearm"
		}
	},
	helmet = {
		name = "helmet_light_peasant_cap",
		attachments = {}
	},
	armour_attachments = {
		patterns = 1
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	brain = {
		behaviours = {
			{
				avoidance = "nil_tree"
			},
			{
				targeting = "nil_tree"
			},
			{
				pathing = "nil_tree"
			},
			{
				morale_manager = "nil_tree"
			},
			{
				main = "nil_tree"
			}
		}
	},
	locomotion = {
		class_name = "AISimpleLocomotion"
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
}
AIProfiles.profiling_ai_red_2 = AIProfiles.profiling_ai_red_2 or {
	head = "squire",
	armour = "armour_medium_tights",
	display_name = "Profiling AI",
	gear = {
		{
			name = "longbow",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "short_sword",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "longbow"
		}
	},
	helmet = {
		name = "helmet_light_leather_cap",
		attachments = {}
	},
	armour_attachments = {
		patterns = 2
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	brain = {
		behaviours = {
			{
				avoidance = "nil_tree"
			},
			{
				targeting = "nil_tree"
			},
			{
				pathing = "nil_tree"
			},
			{
				morale_manager = "nil_tree"
			},
			{
				main = "nil_tree"
			}
		}
	},
	locomotion = {
		class_name = "AISimpleLocomotion"
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
}
AIProfiles.profiling_ai_red_3 = AIProfiles.profiling_ai_red_3 or {
	head = "knight",
	armour = "armour_heavy_fullplate",
	display_name = "Profiling AI",
	gear = {
		{
			name = "warhammer",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "horsemans_hammer",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "battleaxe"
		}
	},
	helmet = {
		name = "helmet_cloth_hat",
		attachments = {}
	},
	armour_attachments = {
		patterns = 3
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	brain = {
		behaviours = {
			{
				avoidance = "nil_tree"
			},
			{
				targeting = "nil_tree"
			},
			{
				pathing = "nil_tree"
			},
			{
				morale_manager = "nil_tree"
			},
			{
				main = "nil_tree"
			}
		}
	},
	locomotion = {
		class_name = "AISimpleLocomotion"
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
}
AIProfiles.profiling_ai_white_1 = AIProfiles.profiling_ai_white_1 or {
	head = "squire",
	armour = "armour_light_tabard",
	display_name = "Profiling AI",
	gear = {
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "long_axe",
			attachments = {}
		},
		{
			name = "castillon_sword",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "ballock_dagger"
		}
	},
	helmet = {
		name = "helmet_armorycap",
		attachments = {}
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	armour_attachments = {
		patterns = 4
	},
	brain = {
		behaviours = {
			{
				avoidance = "nil_tree"
			},
			{
				targeting = "nil_tree"
			},
			{
				pathing = "nil_tree"
			},
			{
				morale_manager = "nil_tree"
			},
			{
				main = "nil_tree"
			}
		}
	},
	locomotion = {
		class_name = "AISimpleLocomotion"
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
}
AIProfiles.profiling_ai_white_2 = AIProfiles.profiling_ai_white_2 or {
	head = "knight",
	armour = "armour_medium_tights",
	display_name = "Profiling AI",
	gear = {
		{
			name = "hunting_crossbow",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "short_sword",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "hunting_crossbow"
		}
	},
	helmet = {
		name = "helmet_medium_kettlehat",
		attachments = {}
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	armour_attachments = {
		patterns = 5
	},
	brain = {
		behaviours = {
			{
				avoidance = "nil_tree"
			},
			{
				targeting = "nil_tree"
			},
			{
				pathing = "nil_tree"
			},
			{
				morale_manager = "nil_tree"
			},
			{
				main = "nil_tree"
			}
		}
	},
	locomotion = {
		class_name = "AISimpleLocomotion"
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
}
AIProfiles.profiling_ai_white_3 = AIProfiles.profiling_ai_white_3 or {
	head = "peasant",
	armour = "armour_heavy_fullplate",
	display_name = "Profiling AI",
	gear = {
		{
			name = "boar_spear",
			attachments = {}
		},
		{
			name = "longsword",
			attachments = {}
		},
		{
			name = "steel_domed_shield",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "longsword"
		},
		{
			name = "steel_domed_shield"
		}
	},
	helmet = {
		name = "helmet_kettlehelm_round",
		attachments = {}
	},
	armour_attachments = {
		patterns = 6
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	brain = {
		behaviours = {
			{
				avoidance = "nil_tree"
			},
			{
				targeting = "nil_tree"
			},
			{
				pathing = "nil_tree"
			},
			{
				morale_manager = "nil_tree"
			},
			{
				main = "nil_tree"
			}
		}
	},
	locomotion = {
		class_name = "AISimpleLocomotion"
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
}
AIProfiles.cpu_profile_red_1 = AIProfiles.cpu_profile_red_1 or {
	head = "squire",
	armour = "armour_light_peasant_rags",
	display_name = "Profiling AI",
	gear = {
		{
			name = "peasant_polearm",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "mace",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "peasant_polearm"
		}
	},
	helmet = {
		name = "helmet_medium_mail_coif",
		attachments = {}
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	armour_attachments = {
		patterns = 7
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
}
AIProfiles.cpu_profile_red_2 = AIProfiles.cpu_profile_red_2 or {
	head = "peasant",
	armour = "armour_medium_tights",
	display_name = "Profiling AI",
	gear = {
		{
			name = "longbow",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "short_sword",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "longbow"
		}
	},
	helmet = {
		name = "helmet_cloth_hood",
		attachments = {}
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	armour_attachments = {
		patterns = 8
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
}
AIProfiles.cpu_profile_red_3 = AIProfiles.cpu_profile_red_3 or {
	head = "squire",
	armour = "armour_heavy_fullplate",
	display_name = "Profiling AI",
	gear = {
		{
			name = "warhammer",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "horsemans_hammer",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "battleaxe"
		}
	},
	helmet = {
		name = "helmet_heavy_frogmouth",
		attachments = {}
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	armour_attachments = {
		patterns = 9
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
}
AIProfiles.cpu_profile_white_1 = AIProfiles.cpu_profile_white_1 or {
	head = "knight",
	armour = "armour_light_peasant_rags",
	display_name = "Profiling AI",
	gear = {
		{
			name = "chiavarina",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "short_sword",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "chiavarina"
		}
	},
	helmet = {
		name = "helmet_sallet",
		attachments = {}
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	armour_attachments = {
		patterns = 1
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
}
AIProfiles.cpu_profile_white_2 = AIProfiles.cpu_profile_white_2 or {
	head = "knight",
	armour = "armour_medium_tights",
	display_name = "Profiling AI",
	gear = {
		{
			name = "hunting_crossbow",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		},
		{
			name = "short_sword",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "hunting_crossbow"
		}
	},
	helmet = {
		name = "helmet_bascinet",
		attachments = {}
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	armour_attachments = {
		patterns = 2
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
}
AIProfiles.cpu_profile_white_3 = AIProfiles.cpu_profile_white_3 or {
	head = "peasant",
	armour = "armour_heavy_fullplate",
	display_name = "Profiling AI",
	gear = {
		{
			name = "boar_spear",
			attachments = {}
		},
		{
			name = "longsword",
			attachments = {}
		},
		{
			name = "steel_domed_shield",
			attachments = {}
		},
		{
			name = "ballock_dagger",
			attachments = {}
		}
	},
	wielded_gear = {
		{
			name = "longsword"
		},
		{
			name = "steel_domed_shield"
		}
	},
	helmet = {
		name = "helmet_barbute",
		attachments = {}
	},
	perception = {
		filter = "ai_player_scan",
		radius = 20
	},
	armour_attachments = {
		patterns = 3
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
}
