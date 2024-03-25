-- chunkname: @scripts/managers/stats/stats_contexts.lua

require("scripts/settings/gear")
require("scripts/settings/gear_templates")
require("scripts/settings/player_unit_damage_settings")
require("scripts/settings/achievements")
require("scripts/settings/prizes")
require("scripts/settings/medals")
require("scripts/settings/game_mode_settings")
require("scripts/settings/ranks")

StatsContexts = StatsContexts or {
	player = {
		rank = {
			value = 0,
			backend = {
				load = true,
				save = false
			}
		},
		coins = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		round_won = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		enemy_kills = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		enemy_mount_kills = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		enemy_mounted_kills = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		enemy_kills_while_mounted = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		enemy_corporal_kills = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		team_hits = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		team_kills = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		team_damage = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		enemy_damage = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		executions = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		headshots = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		longshots = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		headshot_range = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		headshots_bounced = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		headshots_with_crossbow = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		enemy_kill_within_objective = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		first_kill_since_death = {
			value = false,
			backend = {
				load = false,
				save = false
			}
		},
		successive_kills = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		kill_streak = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		longest_kill_streak = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		deaths = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		yields = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		squad_spawns = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		squad_spawns_round = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		squad_wipes = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		assists = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		tagged_assists = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		revives = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		team_bandages = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		objectives_captured = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		objectives_captured_assist = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		section_cleared_payload = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		teabags = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		placement = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		placement_team = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		placement_squad = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		experience = {
			value = 0,
			backend = {
				load = true,
				save = true,
				save_mode = {
					inc = "experience_round"
				}
			}
		},
		experience_round = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		experience_bonus = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		experience_penalty = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		experience_round_final = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		},
		last_win_time = {
			value = 0,
			backend = {
				save_mode = "set",
				save = true,
				load = true
			}
		},
		coins_unlocked_50k = {
			value = false,
			backend = {
				save_mode = "set",
				save = true,
				load = true
			}
		},
		coins_unlocked_100k = {
			value = false,
			backend = {
				save_mode = "set",
				save = true,
				load = true
			}
		},
		anti_cheat_connects = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		anti_cheat_kicks = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		anti_cheat_status_authenticated = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		anti_cheat_status_banned = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		anti_cheat_status_disconnected = {
			value = 0,
			backend = {
				save_mode = "inc",
				save = true,
				load = false
			}
		},
		weapon_stats = {
			type = "compound",
			data = {},
			set = function(self, weapon_name, attribute, value)
				self.data[weapon_name][attribute] = value
			end,
			get = function(self, weapon_name, attribute)
				return self.data[weapon_name][attribute]
			end,
			increment = function(self, weapon_name, attribute, value)
				self.data[weapon_name][attribute] = self.data[weapon_name][attribute] + value
			end,
			decrement = function(self, weapon_name, attribute, value)
				self.data[weapon_name][attribute] = self.data[weapon_name][attribute] - value
			end,
			value = function(self, weapon_name, attribute)
				return self.data[weapon_name][attribute]
			end,
			get_backend_data = function(self)
				local data = {}

				for weapon_name, attributes in pairs(self.data) do
					for attribute_name, attribute_value in pairs(attributes) do
						if attribute_value > 0 then
							data[#data + 1] = {
								key = attribute_name,
								value = attribute_value,
								scopes = Gear[weapon_name].hash
							}
						end
					end
				end

				return data
			end,
			backend = {
				load = false,
				save = true
			}
		},
		player_stats = {
			type = "compound",
			data = {},
			set = function(self, stat, value)
				self.data[stat] = value
			end,
			get = function(self, stat)
				return self.data[stat]
			end,
			increment = function(self, stat, value)
				self.data[stat] = self.data[stat] + value
			end,
			decrement = function(self, stat, value)
				self.data[stat] = self.data[stat] - value
			end,
			value = function(self, stat)
				return self.data[stat]
			end,
			get_backend_data = function(self, profile_id)
				local data = {}

				for stat_name, value in pairs(self.data) do
					if value > 0 then
						data[#data + 1] = {
							scopes = 0,
							key = stat_name,
							value = value
						}
					end
				end

				return data
			end,
			backend = {
				load = false,
				save = true
			}
		}
	}
}

local gear_categories = {}

for name, props in pairs(GearTemplates) do
	local gear_category = props.stat_category

	if not table.contains(gear_categories, gear_category) then
		gear_categories[#gear_categories + 1] = gear_category
	end
end

for name, props in pairs(Gear) do
	if props.attacks then
		local stats_table = {
			knockdowns = 0,
			misses = 0,
			parries = 0,
			instakills = 0
		}

		for zone_name, zone in pairs(PlayerUnitDamageSettings.hit_zones) do
			stats_table[zone.hit_stat] = 0
			stats_table[zone.damage_stat] = 0
		end

		StatsContexts.player.weapon_stats.data[name] = stats_table
	end
end

StatsContexts.player.player_stats.data = {
	ass_round_won = 0,
	ass_round_played = 0,
	con_round_played = 0,
	battle_round_played = 0,
	deaths = 0,
	con_round_won = 0,
	kills = 0,
	tdm_round_played = 0,
	tdm_round_won = 0,
	battle_round_won = 0,
	revives = 0
}

for _, category_name in ipairs(gear_categories) do
	StatsContexts.player["kills_with_" .. category_name] = {
		value = 0,
		backend = {
			load = false,
			save = false
		}
	}
end

for id, _ in pairs(Achievements.COLLECTION) do
	StatsContexts.player["achievement_" .. id] = {
		value = false,
		backend = {
			load = false,
			save = false
		}
	}
end

for name, _ in pairs(Prizes.COLLECTION) do
	StatsContexts.player[name] = {
		value = 0,
		backend = {
			save_mode = "set",
			save = true,
			load = true
		}
	}
end

local mounted_prizes = {
	"prize_horse_killer",
	"prize_anti_cavalry",
	"prize_mounted_warfare"
}

StatsContexts.player.all_mounted_prizes = {
	type = "derived",
	dependencies = mounted_prizes,
	value = function(stats)
		for _, prize_name in pairs(mounted_prizes) do
			if stats[prize_name].value(stats) == 0 then
				return false
			end
		end

		return true
	end,
	backend = {
		load = false,
		save = false
	}
}

local weapon_prizes = {
	"prize_one_handed_sword",
	"prize_bastard_sword",
	"prize_two_handed_sword",
	"prize_one_handed_axe",
	"prize_two_handed_axe",
	"prize_one_handed_club",
	"prize_two_handed_club",
	"prize_lance",
	"prize_dagger",
	"prize_polearm",
	"prize_spear",
	"prize_bow",
	"prize_crossbow"
}

StatsContexts.player.all_weapon_prizes = {
	type = "derived",
	dependencies = weapon_prizes,
	value = function(stats)
		for _, prize_name in pairs(weapon_prizes) do
			if stats[prize_name].value(stats) == 0 then
				return false
			end
		end

		return true
	end,
	backend = {
		load = false,
		save = false
	}
}

local support_prizes = {
	"prize_surgery_efficiency",
	"prize_medical_efficiency"
}

StatsContexts.player.all_support_prizes = {
	type = "derived",
	dependencies = weapon_prizes,
	value = function(stats)
		for _, prize_name in pairs(support_prizes) do
			if stats[prize_name].value(stats) == 0 then
				return false
			end
		end

		return true
	end,
	backend = {
		load = false,
		save = false
	}
}

local all_prizes = {}

for name, _ in pairs(Prizes.COLLECTION) do
	all_prizes[#all_prizes + 1] = name
end

StatsContexts.player.all_prizes = {
	type = "derived",
	dependencies = all_prizes,
	value = function(stats)
		for _, prize_name in pairs(all_prizes) do
			if stats[prize_name].value(stats) == 0 then
				return false
			end
		end

		return true
	end,
	backend = {
		load = false,
		save = false
	}
}

for name, props in pairs(Medals.COLLECTION) do
	StatsContexts.player[name] = {
		value = false,
		backend = {
			save_mode = "set",
			save = true,
			load = true
		}
	}
end

local exclude_game_modes = {
	"base",
	"coop_wave"
}

for name, props in pairs(GameModeSettings) do
	if not table.contains(exclude_game_modes, name) then
		StatsContexts.player[props.key .. "_round_won"] = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		}
		StatsContexts.player[props.key .. "_round_finished"] = {
			value = 0,
			backend = {
				load = false,
				save = false
			}
		}
	end
end
