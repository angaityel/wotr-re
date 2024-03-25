-- chunkname: @scripts/settings/medals.lua

require("scripts/settings/prizes_medals_unlocks_ui_settings")

Medals = class(Medals)
Medals.COLLECTION = {
	medal_team_deathmatch = {
		stat_settings = {
			"prize_team_deathmatch",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_team_deathmatch
	},
	medal_conquest = {
		stat_settings = {
			"prize_conquest",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_conquest
	},
	medal_conquest_winner = {
		stat_settings = {
			"prize_conquest_winner",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_conquest_winner
	},
	medal_team_deathmatch_winner = {
		stat_settings = {
			"prize_team_deathmatch_winner",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_team_deathmatch_winner
	},
	medal_premium_squad = {
		stat_settings = {
			"prize_premium_squad",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_premium_squad
	},
	medal_gold_grand = {
		stat_settings = {
			"prize_gold_grand",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_gold_grand
	},
	medal_silver_grand = {
		stat_settings = {
			"prize_silver_grand",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_silver_grand
	},
	medal_bronze_grand = {
		stat_settings = {
			"prize_bronze_grand",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_bronze_grand
	},
	medal_surgery_efficiency = {
		stat_settings = {
			"prize_surgery_efficiency",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_surgery_efficiency
	},
	medal_medical_efficiency = {
		stat_settings = {
			"prize_medical_efficiency",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_medical_efficiency
	},
	medal_reconoiter_efficiency = {
		stat_settings = {
			"prize_reconoiter_efficiency",
			">=",
			30
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_reconoiter_efficiency
	},
	medal_one_handed_sword = {
		stat_settings = {
			"prize_one_handed_sword",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_one_handed_sword
	},
	medal_bastard_sword = {
		stat_settings = {
			"prize_bastard_sword",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_bastard_sword
	},
	medal_two_handed_sword = {
		stat_settings = {
			"prize_two_handed_sword",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_two_handed_sword
	},
	medal_one_handed_axe = {
		stat_settings = {
			"prize_one_handed_axe",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_one_handed_axe
	},
	medal_two_handed_axe = {
		stat_settings = {
			"prize_two_handed_axe",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_two_handed_axe
	},
	medal_one_handed_club = {
		stat_settings = {
			"prize_one_handed_club",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_one_handed_club
	},
	medal_two_handed_club = {
		stat_settings = {
			"prize_two_handed_club",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_two_handed_club
	},
	medal_lance = {
		stat_settings = {
			"prize_lance",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_lance
	},
	medal_dagger = {
		stat_settings = {
			"prize_dagger",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_dagger
	},
	medal_polearm = {
		stat_settings = {
			"prize_polearm",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_polearm
	},
	medal_spear = {
		stat_settings = {
			"prize_spear",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_spear
	},
	medal_bow = {
		stat_settings = {
			"prize_bow",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_bow
	},
	medal_crossbow = {
		stat_settings = {
			"prize_crossbow",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_crossbow
	},
	medal_spawner = {
		stat_settings = {
			"squad_spawns",
			">=",
			100
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_spawner
	},
	medal_squad_wipe = {
		stat_settings = {
			"prize_squad_wipe",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_squad_wipe
	},
	medal_squad_spawn = {
		stat_settings = {
			"prize_squad_spawn",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_squad_spawn
	},
	medal_assist = {
		stat_settings = {
			"prize_assist",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_assist
	},
	medal_executioner = {
		stat_settings = {
			"prize_executioner",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_executioner
	},
	medal_marksman = {
		stat_settings = {
			"prize_marksman",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_marksman
	},
	medal_corporal_punishment = {
		stat_settings = {
			"prize_corporal_punishment",
			">=",
			50
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_corporal_punishment
	},
	medal_horse_killer = {
		stat_settings = {
			"prize_horse_killer",
			">=",
			30
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_horse_killer
	},
	medal_anti_cavalry = {
		stat_settings = {
			"prize_anti_cavalry",
			">=",
			30
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_anti_cavalry
	},
	medal_mounted_warfare = {
		stat_settings = {
			"prize_mounted_warfare",
			">=",
			30
		},
		ui_settings = PrizesMedalsUnlocksUISettings.medal_mounted_warfare
	}
}

function Medals:init(stats_collection)
	self._stats = stats_collection
end

function Medals:register_player(player)
	local network_id = player:network_id()

	for medal_name, props in pairs(self.COLLECTION) do
		if not self._stats:get(network_id, medal_name) then
			local stat_name, condition, value = unpack(props.stat_settings)
			local callback = callback(self, "_cb_award_medal", player, medal_name)

			self._stats:register_callback(network_id, stat_name, condition, value, callback)
		end
	end
end

function Medals:_cb_award_medal(player, medal_name)
	if Managers.state.network:game() and Managers.state.team:stats_requirement_fulfilled() then
		printf("%q got awarded %q medal!", player:network_id(), medal_name)
		self._stats:set(player:network_id(), medal_name, true)
		RPC.rpc_award_medal(player:network_id(), player.game_object_id, NetworkLookup.medals[medal_name])
	end
end
