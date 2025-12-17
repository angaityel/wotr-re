-- chunkname: @scripts/settings/player_profiles.lua

require("scripts/settings/perk_settings")
require("scripts/settings/script_input_settings")

function populate_player_profiles_from_save(save_data)
	if save_data.profiles then
		local saved_profiles = save_data.profiles

		for index, profile in pairs(PlayerProfiles) do
			local unlock_key = profile.unlock_key
			local release_name = profile.release_name
			local saved_profile = saved_profiles[index]

			if saved_profile and not profile.no_editing and index > 4 then
				saved_profile.unlock_key = unlock_key
				saved_profile.release_name = release_name
				PlayerProfiles[index] = saved_profile
			end
		end
	end

	save_data.profiles = PlayerProfiles
	
	create_grail_profiles(table.clone(PlayerProfiles))
end

function create_grail_profiles(profiles)
	for key, profile in ipairs(profiles) do
		local mount = profile.mount

		if mount then
			profile.mount = nil
		end

		GrailProfiles[key] = profile
	end
end

PlayerProfiles = PlayerProfiles or {
	{
		display_name = "profile_slot_1",
		demo_unlocked = true,
		unlock_key = "footman",
		head_material = "knight",
		release_name = "main",
		voice = "noble",
		head = "knight",
		armour = "armour_medium_swiss",
		market_price = 500,
		no_editing = true,
		armour_attachments = {
			patterns = 6
		},
		perks = {
			supportive_basic = "surgeon",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "reinforce",
			offensive_specialization_2 = "hamstring",
			defensive_specialization_1 = "shield_expert",
			defensive_basic = "shield_bearer",
			movement_basic = "infantry",
			supportive_specialization_2 = "second_opinion",
			defensive_specialization_2 = "shield_bash",
			officer_basic = "officer_training",
			supportive_specialization_1 = "sterilised_bandages",
			movement_specialization_1 = "runner",
			officer_specialization_2 = "courage",
			offensive_specialization_1 = "break_block",
			offensive_basic = "man_at_arms"
		},
		wielded_gear = {
			{
				name = "warwick_dark"
			},
			{
				name = "steel_domed_shield"
			}
		},
		helmet = {
			name = "helmet_sallet",
			show_crest = false,
			attachments = {
				pattern = "pattern_black_as_knight",
				visor = "visor_standard",
				coif = "bevor_01"
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
				name = "hospitaller_sword_hilted_dagger",
				attachments = {
					fighting_style = {
						"german_style"
					}
				}
			},
			{
				name = "warwick_dark",
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
						"hollow_ground"
					}
				}
			}
		}
	},
	{
		display_name = "profile_slot_2",
		demo_unlocked = true,
		unlock_key = "crossbowman",
		head_material = "squire",
		release_name = "main",
		voice = "noble",
		head = "squire",
		armour = "armour_medium_tights",
		market_price = 6000,
		no_editing = true,
		armour_attachments = {
			patterns = 6
		},
		gear = {
			{
				name = "hospitaller_sword_hilted_dagger",
				attachments = {
					fighting_style = {
						"german_style"
					}
				}
			},
			{
				name = "pronged_bill",
				attachments = {
					fighting_style = {
						"german_style"
					},
					wooden_shaft = {
						"standard"
					},
					edge_grind = {
						"convex"
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
						"german_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					}
				}
			}
		},
		wielded_gear = {
			{
				name = "pronged_bill"
			}
		},
		helmet = {
			name = "helmet_bascinet",
			show_crest = false,
			attachments = {
				pattern = "pattern_black_as_knight",
				visor = "visor_pigface",
				coif = "armorycap"
			}
		},
		perks = {
			supportive_basic = "surgeon",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "courage",
			offensive_specialization_2 = "hamstring",
			supportive_specialization_2 = "second_opinion",
			defensive_basic = "armour_training",
			defensive_specialization_1 = "thick_skinned",
			movement_basic = "infantry",
			defensive_specialization_2 = "regenerative",
			officer_basic = "officer_training",
			supportive_specialization_1 = "sterilised_bandages",
			movement_specialization_1 = "runner",
			officer_specialization_2 = "armour",
			offensive_specialization_1 = "shield_breaker",
			offensive_basic = "man_at_arms"
		}
	},
	{
		display_name = "profile_slot_3",
		demo_unlocked = true,
		unlock_key = "archer",
		head_material = "squire",
		release_name = "main",
		head = "peasant",
		armour = "armour_light_tabard",
		market_price = 12000,
		no_editing = true,
		armour_attachments = {
			patterns = 6
		},
		wielded_gear = {
			{
				name = "longbow"
			}
		},
		helmet = {
			name = "helmet_light_leather_cap",
			show_crest = false,
			attachments = {
				coif = "armorycap"
			}
		},
		perks = {
			supportive_basic = "surgeon",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "reinforce",
			offensive_specialization_2 = "forest_warden",
			movement_basic = "infantry",
			defensive_basic = "armour_training",
			supportive_specialization_2 = "second_opinion",
			defensive_specialization_1 = "thick_skinned",
			supportive_specialization_1 = "sterilised_bandages",
			officer_basic = "officer_training",
			defensive_specialization_2 = "regenerative",
			movement_specialization_1 = "field_warden",
			officer_specialization_2 = "courage",
			offensive_specialization_1 = "longbowman",
			offensive_basic = "archer"
		},
		gear = {
			{
				name = "short_pronged_bill",
				attachments = {
					fighting_style = {
						"german_style"
					},
					wooden_shaft = {
						"standard"
					},
					head = {
						"steel"
					},
					edge_grind = {
						"convex"
					}
				}
			},
			{
				name = "hospitaller_sword_hilted_dagger",
				attachments = {
					fighting_style = {
						"german_style"
					}
				}
			},
			{
				name = "longbow",
				attachments = {
					projectile_head = {
						"armour_piercing"
					},
					misc = {}
				}
			}
		}
	},
	{
		display_name = "profile_slot_4",
		demo_unlocked = true,
		unlock_key = "footknight",
		head_material = "lady",
		release_name = "main",
		head = "peasant",
		armour = "armour_heavy_milanese",
		market_price = 18000,
		no_editing = true,
		armour_attachments = {
			patterns = 7
		},
		wielded_gear = {
			{
				name = "flemish_greatsword"
			}
		},
		gear = {
			{
				name = "hospitaller_sword_hilted_dagger",
				attachments = {
					fighting_style = {
						"german_style"
					}
				}
			},
			{
				name = "hansa_merc_1h_mace",
				attachments = {
					fighting_style = {
						"german_style"
					},
					head = {
						"steel"
					}
				}
			},
			{
				name = "flemish_greatsword",
				attachments = {
					fighting_style = {
						"german_style"
					},
					pommel = {
						"balanced"
					},
					blade = {
						"steel"
					},
					edge_grind = {
						"hollow_ground"
					}
				}
			}
		},
		helmet = {
			name = "helmet_armet",
			show_crest = false,
			attachments = {
				pattern = "pattern_black_as_knight",
				coif = "bevor_01"
			}
		},
		perks = {
			supportive_basic = "surgeon",
			movement_specialization_2 = "fleet_footed",
			officer_specialization_1 = "courage",
			offensive_specialization_2 = "shield_breaker",
			supportive_specialization_2 = "second_opinion",
			defensive_basic = "armour_training",
			defensive_specialization_1 = "thick_skinned",
			movement_basic = "infantry",
			defensive_specialization_2 = "regenerative",
			officer_basic = "officer_training",
			supportive_specialization_1 = "sterilised_bandages",
			movement_specialization_1 = "runner",
			officer_specialization_2 = "berserker",
			offensive_specialization_1 = "highwayman",
			offensive_basic = "man_at_arms"
		}
	},
	{
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "profile_slot_custom_1",
		market_price = 500,
		unlock_key = "customizable_profile_1",
		demo_locked = true,
		release_name = "main",
		armour_attachments = {
			patterns = 1
		},
		perks = {},
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
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		}
	},
	{
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "profile_slot_custom_2",
		market_price = 6000,
		unlock_key = "customizable_profile_2",
		demo_locked = true,
		release_name = "main",
		armour_attachments = {
			patterns = 1
		},
		perks = {},
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
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		}
	},
	{
		head = "knight",
		armour = "armour_medium_tights",
		display_name = "profile_slot_custom_3",
		market_price = 12000,
		unlock_key = "customizable_profile_3",
		demo_locked = true,
		release_name = "main",
		armour_attachments = {
			patterns = 1
		},
		perks = {},
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
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		}
	},
	{
		head = "peasant",
		armour = "armour_medium_tights",
		display_name = "profile_slot_custom_4",
		market_price = 18000,
		unlock_key = "customizable_profile_4",
		demo_locked = true,
		release_name = "main",
		armour_attachments = {
			patterns = 1
		},
		perks = {},
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
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		}
	},
	{
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "profile_slot_custom_5",
		market_price = 100000,
		unlock_key = "customizable_profile_5",
		demo_locked = true,
		release_name = "sherwood",
		armour_attachments = {
			patterns = 1
		},
		perks = {},
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
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		}
	},
	{
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "profile_slot_custom_6",
		market_price = 100000,
		unlock_key = "customizable_profile_6",
		demo_locked = true,
		release_name = "jwp",
		armour_attachments = {
			patterns = 1
		},
		perks = {},
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
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		}
	},
	{
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "profile_slot_custom_7",
		market_price = 250000,
		unlock_key = "customizable_profile_7",
		demo_locked = true,
		release_name = "jwp",
		armour_attachments = {
			patterns = 1
		},
		perks = {},
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
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		}
	},
	{
		head = "squire",
		armour = "armour_medium_tights",
		display_name = "profile_slot_custom_8",
		market_price = 500000,
		unlock_key = "customizable_profile_8",
		demo_locked = true,
		release_name = "jwp",
		armour_attachments = {
			patterns = 1
		},
		perks = {},
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
			name = "helmet_medium_mail_coif",
			show_crest = false,
			attachments = {}
		}
	}
}

local EMPTY_CUSTOM = {
	head = "squire",
	armour = "armour_medium_tights",
	display_name = "profile_slot_custom",
	market_price = 500000,
	unlock_key = "customizable_profile",
	demo_locked = true,
	release_name = "jwp",
	armour_attachments = {
		patterns = 1
	},
	perks = {},
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
		name = "helmet_medium_mail_coif",
		show_crest = false,
		attachments = {}
	}
}

local function add_custom_profile(profile_template, display_name, unlock_key, index)
	local profile = table.clone(profile_template)

	profile.unlock_key = unlock_key
	profile.display_name = display_name
	profile.original_display_name = profile.display_name
	PlayerProfiles[index] = profile
end

local CUSTOM_SLOTS = 33
local LOCKED_SLOTS = 4

for i = 1, CUSTOM_SLOTS do
	local index = LOCKED_SLOTS + i
	add_custom_profile(EMPTY_CUSTOM, "Custom " .. i, "profile_custom_" .. i, index)
end

function profile_index_by_unlock(unlock_key)
	for index, profile in pairs(PlayerProfiles) do
		if profile.unlock_key == unlock_key then
			return index
		end
	end
end

PlayerProfilesDefault = PlayerProfilesDefault or table.clone(PlayerProfiles)
GrailProfiles = table.clone(PlayerProfiles)
