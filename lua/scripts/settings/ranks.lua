-- chunkname: @scripts/settings/ranks.lua

require("scripts/settings/prizes_medals_unlocks_ui_settings")

RANKS = RANKS or {
	[0] = {
		xp = {
			span = 400,
			base = 0
		},
		unlocks = {
			{
				name = "footman",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			}
		}
	},
	{
		xp = {
			span = 1100,
			base = 400
		},
		unlocks = {
			{
				name = "crossbowman",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			}
		}
	},
	{
		xp = {
			span = 1900,
			base = 1500
		},
		unlocks = {
			{
				name = "archer",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			}
		}
	},
	{
		xp = {
			span = 2600,
			base = 3400
		},
		unlocks = {
			{
				name = "footknight",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			}
		}
	},
	{
		xp = {
			span = 3400,
			base = 6000
		},
		unlocks = {
			{
				name = "customizable_profile_1",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			},
			{
				name = "armour_medium_tights",
				category = "armour",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_armour
			},
			{
				name = "helmet_bascinet",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "helmet_medium_mail_coif",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "longbow",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "hunting_crossbow",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "ballock_dagger",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "steel_domed_shield",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "pronged_bill",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "arming_sword",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "scottish_sword",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "archer",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "armour_training",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "infantry",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "man_at_arms",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "shield_bearer",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "watchman",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "eagle_eyed",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "forest_warden",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "longbowman",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "marksman_training",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "nimble_minded",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "sleight_of_hand",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "steady_aim",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "strong_of_arm",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "hardened",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "oblivious",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "regenerative",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "thick_skinned",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "cat_burglar",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "city_watch",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "field_warden",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "fleet_footed",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "runner",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "break_block",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "hamstring",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "highwayman",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "push",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "riposte",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "shield_breaker",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "shield_bash",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "shield_expert",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "shield_wall",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "keen_eyes",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "spotter",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			}
		}
	},
	{
		xp = {
			span = 4100,
			base = 9400
		},
		unlocks = {
			{
				name = "helmet_kettlehelm_round",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "short_sword",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 4900,
			base = 13500
		},
		unlocks = {
			{
				name = "armour_light_tabard",
				category = "armour",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_armour
			},
			{
				name = "helmet_medium_kettlehat",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "chiavarina",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 5600,
			base = 18400
		},
		unlocks = {
			{
				name = "helmet_light_leather_cap",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "short_pronged_bill",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 6400,
			base = 24000
		},
		unlocks = {
			{
				name = "customizable_profile_2",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			},
			{
				name = "armour_heavy_fullplate",
				category = "armour",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_armour
			},
			{
				name = "helmet_sallet",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "long_axe",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 7100,
			base = 30400
		},
		unlocks = {
			{
				name = "helmet_armorycap",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "spiked_bill",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 7900,
			base = 37500
		},
		unlocks = {
			{
				name = "helmet_armet",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "hunting_bow",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "war_lance",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "targe",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "castillon_sword",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "cavalry",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "heavy_cavalry",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "horse_master",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "horse_racer",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			}
		}
	},
	{
		xp = {
			span = 8600,
			base = 45400
		},
		unlocks = {
			{
				name = "customizable_profile_3",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			},
			{
				name = "two_handed_axe",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 9400,
			base = 54000
		},
		unlocks = {
			{
				name = "pronged_bill_halberd",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 10100,
			base = 63400
		},
		unlocks = {
			{
				name = "boar_spear",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 10900,
			base = 73500
		},
		unlocks = {
			{
				name = "customizable_profile_4",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			},
			{
				name = "battleaxe",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	},
	{
		xp = {
			span = 11600,
			base = 84400
		},
		unlocks = {
			{
				name = "helmet_cloth_hood",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "helmet_barbute",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "warbow",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "mace",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "warhammer",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "spiked_bill_halberd",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "longsword",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "surgeon",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "barber_surgeon",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "second_opinion",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "sterilised_bandages",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			}
		}
	},
	{
		xp = {
			span = 12400,
			base = 96000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 13100,
			base = 108400
		},
		unlocks = {
			{
				name = "customizable_profile_5",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			}
		}
	},
	{
		xp = {
			span = 13900,
			base = 121500
		},
		unlocks = {}
	},
	{
		xp = {
			span = 14600,
			base = 135400
		},
		unlocks = {}
	},
	{
		xp = {
			span = 56100,
			base = 150000
		},
		unlocks = {
			{
				name = "customizable_profile_6",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			},
			{
				name = "customizable_profile_7",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			},
			{
				name = "customizable_profile_8",
				category = "profile",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_profile
			},
			{
				name = "helmet_heavy_frogmouth",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "short_simple_bill",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "horsemans_hammer",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "tournament_lance",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "poleaxe",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "simple_bill",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "officer_training",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "armour",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "berserker",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "courage",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "march_speed",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "mounted_speed",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "reinforce",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			},
			{
				name = "replenish",
				category = "perk",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_perk
			}
		}
	},
	{
		xp = {
			span = 60700,
			base = 206100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 65300,
			base = 266800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 69900,
			base = 332100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 74600,
			base = 402000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 79200,
			base = 476600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 83800,
			base = 555800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 88400,
			base = 639600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 93100,
			base = 728000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 97700,
			base = 821100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 102300,
			base = 918800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 106900,
			base = 1021100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 111600,
			base = 1128000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 116200,
			base = 1239600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 120800,
			base = 1355800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 125400,
			base = 1476600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 130100,
			base = 1602000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 134700,
			base = 1732100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 139300,
			base = 1866800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 143900,
			base = 2006100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 148600,
			base = 2150000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 153200,
			base = 2298600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 157800,
			base = 2451800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 162400,
			base = 2609600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 167100,
			base = 2772000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 171700,
			base = 2939100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 176300,
			base = 3110800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 180900,
			base = 3287100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 185600,
			base = 3468000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 190200,
			base = 3653600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 194800,
			base = 3843800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 199400,
			base = 4038600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 204100,
			base = 4238000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 208700,
			base = 4442100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 213300,
			base = 4650800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 217900,
			base = 4864100
		},
		unlocks = {}
	},
	{
		xp = {
			span = 222600,
			base = 5082000
		},
		unlocks = {}
	},
	{
		xp = {
			span = 227200,
			base = 5304600
		},
		unlocks = {}
	},
	{
		xp = {
			span = 231800,
			base = 5531800
		},
		unlocks = {}
	},
	{
		xp = {
			span = 236400,
			base = 5763600
		},
		unlocks = {}
	},
	{
		xp = {
			base = 6000000,
			span = math.huge
		},
		unlocks = {
			{
				name = "armour_light_peasant_rags",
				category = "armour",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_armour
			},
			{
				name = "helmet_cloth_hat",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "helmet_light_peasant_cap",
				category = "helmet",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_helmet
			},
			{
				name = "peasant_polearm",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			},
			{
				name = "pointed_stick",
				category = "gear",
				ui_settings = PrizesMedalsUnlocksUISettings.unlock_gear
			}
		}
	}
}

function xp_to_rank(xp)
	for i = 0, #RANKS do
		local rank = RANKS[i]

		if xp >= rank.xp.base and xp <= rank.xp.base + rank.xp.span - 1 then
			return i
		end
	end

	return 0
end

if Application.build() ~= "release" then
	require("scripts/settings/gear")
	require("scripts/settings/armours")
	require("scripts/settings/helmets")
	require("scripts/settings/perk_settings")

	for rank, props in pairs(RANKS) do
		for _, unlock in pairs(props.unlocks) do
			if unlock.category == "gear" then
				if Gear[unlock.name] == nil then
					Application.warning("Unlockable gear %q doesn't exist", unlock.name)
				end
			elseif unlock.category == "armour" then
				if Armours[unlock.name] == nil then
					Application.warning("Unlockable armour %q doesn't exist", unlock.name)
				end
			elseif unlock.category == "helmet" then
				if Helmets[unlock.name] == nil then
					Application.warning("Unlockable helmet %q doesn't exist", unlock.name)
				end
			elseif unlock.category == "perk" then
				if Perks[unlock.name] == nil then
					Application.warning("Unlockable perk %q doesn't exist", unlock.name)
				end
			else
				fassert("Undefined unlock category %q", unlock.category)
			end
		end
	end
end

function default_rank_unlocks(current_rank)
	local default_unlocks = {}

	for i = 0, current_rank do
		for _, unlock in pairs(RANKS[i].unlocks) do
			if Managers.persistence:is_unlock_owned(unlock) then
				default_unlocks[unlock.category .. "|" .. unlock.name] = unlock
			end
		end
	end

	return default_unlocks
end

Ranks = class(Ranks)

function Ranks:init(stats_collection)
	self._stats = stats_collection
end

function Ranks:register_player(player)
	local network_id = player:network_id()
	local current_rank = self._stats:get(network_id, "rank")

	for rank, props in pairs(RANKS) do
		if current_rank < rank then
			local function condition(value, comp_value)
				return value >= comp_value.base and value <= comp_value.base + comp_value.span - 1
			end

			local callback = callback(self, "_cb_ranked_up", player, rank)

			self._stats:register_callback(network_id, "experience", condition, props.xp, callback)
		end
	end
end

function Ranks:_cb_ranked_up(player, rank)
	if Managers.state.network:game() and Managers.state.team:stats_requirement_fulfilled() and rank > self._stats:get(player:network_id(), "rank") then
		printf("%q has reached rank %d", player:network_id(), rank)

		local unlocks = RANKS[rank].unlocks

		Managers.persistence:process_unlocks(player.backend_profile_id, unlocks)
		self._stats:set(player:network_id(), "rank", rank)
		RPC.rpc_rank_up(player:network_id(), player.game_object_id, rank)
	end
end
