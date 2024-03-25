-- chunkname: @scripts/settings/prizes.lua

require("scripts/settings/prizes_medals_unlocks_ui_settings")

Prizes = class(Prizes)
Prizes.COLLECTION = {
	prize_team_deathmatch = {
		stat_settings = {
			"tdm_round_finished",
			"=",
			true
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_team_deathmatch
	},
	prize_conquest = {
		stat_settings = {
			"con_round_finished",
			"=",
			true
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_conquest
	},
	prize_conquest_winner = {
		stat_settings = {
			"con_round_won",
			"=",
			true
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_conquest_winner
	},
	prize_team_deathmatch_winner = {
		stat_settings = {
			"tdm_round_won",
			"=",
			true
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_team_deathmatch_winner
	},
	prize_premium_squad = {
		stat_settings = {
			"placement_squad",
			"=",
			1
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_premium_squad
	},
	prize_gold_grand = {
		stat_settings = {
			"placement",
			"=",
			1
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_gold_grand
	},
	prize_silver_grand = {
		stat_settings = {
			"placement",
			"=",
			2
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_silver_grand
	},
	prize_bronze_grand = {
		stat_settings = {
			"placement",
			"=",
			3
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_bronze_grand
	},
	prize_surgery_efficiency = {
		stat_settings = {
			"revives",
			"=",
			5
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_surgery_efficiency
	},
	prize_medical_efficiency = {
		stat_settings = {
			"team_bandages",
			"=",
			5
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_medical_efficiency
	},
	prize_reconoiter_efficiency = {
		stat_settings = {
			"tagged_assists",
			"=",
			5
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_reconoiter_efficiency
	},
	prize_one_handed_sword = {
		stat_settings = {
			"kills_with_one_handed_sword",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_one_handed_sword
	},
	prize_bastard_sword = {
		stat_settings = {
			"kills_with_bastard_sword",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_bastard_sword
	},
	prize_two_handed_sword = {
		stat_settings = {
			"kills_with_two_handed_sword",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_two_handed_sword
	},
	prize_one_handed_axe = {
		stat_settings = {
			"kills_with_one_handed_axe",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_one_handed_axe
	},
	prize_two_handed_axe = {
		stat_settings = {
			"kills_with_two_handed_axe",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_two_handed_axe
	},
	prize_one_handed_club = {
		stat_settings = {
			"kills_with_one_handed_club",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_one_handed_club
	},
	prize_two_handed_club = {
		stat_settings = {
			"kills_with_two_handed_club",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_two_handed_club
	},
	prize_lance = {
		stat_settings = {
			"kills_with_lance",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_lance
	},
	prize_dagger = {
		stat_settings = {
			"kills_with_dagger",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_dagger
	},
	prize_polearm = {
		stat_settings = {
			"kills_with_polearm",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_polearm
	},
	prize_spear = {
		stat_settings = {
			"kills_with_spear",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_spear
	},
	prize_bow = {
		stat_settings = {
			"kills_with_bow",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_bow
	},
	prize_crossbow = {
		stat_settings = {
			"kills_with_crossbow",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_crossbow
	},
	prize_squad_wipe = {
		stat_settings = {
			"squad_wipes",
			"=",
			2
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_squad_wipe
	},
	prize_squad_spawn = {
		stat_settings = {
			"squad_spawns_round",
			"=",
			2
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_squad_spawn
	},
	prize_assist = {
		stat_settings = {
			"assists",
			"=",
			14
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_assist
	},
	prize_executioner = {
		stat_settings = {
			"executions",
			"=",
			14
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_executioner
	},
	prize_marksman = {
		stat_settings = {
			"headshots",
			"=",
			5
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_marksman
	},
	prize_corporal_punishment = {
		stat_settings = {
			"enemy_corporal_kills",
			"=",
			2
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_corporal_punishment
	},
	prize_horse_killer = {
		stat_settings = {
			"enemy_mount_kills",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_horse_killer
	},
	prize_anti_cavalry = {
		stat_settings = {
			"enemy_mounted_kills",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_anti_cavalry
	},
	prize_mounted_warfare = {
		stat_settings = {
			"enemy_kills_while_mounted",
			"=",
			7
		},
		ui_settings = PrizesMedalsUnlocksUISettings.prize_mounted_warfare
	}
}

function Prizes:init(stats_collection)
	self._stats = stats_collection
end

function Prizes:register_player(player)
	local network_id = player:network_id()

	for prize_name, props in pairs(self.COLLECTION) do
		local stat_name, condition, value = unpack(props.stat_settings)
		local callback = callback(self, "_cb_award_prize", player, prize_name)

		self._stats:register_callback(network_id, stat_name, condition, value, callback)
	end
end

function Prizes:_cb_award_prize(player, prize_name)
	if Managers.state.network:game() and Managers.state.team:stats_requirement_fulfilled() then
		printf("%q got awarded %q prize!", player:network_id(), prize_name)
		self._stats:increment(player:network_id(), prize_name, 1)
		RPC.rpc_award_prize(player:network_id(), player.game_object_id, NetworkLookup.prizes[prize_name])
	end
end
