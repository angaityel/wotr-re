-- chunkname: @scripts/managers/stats/stats_collector_server.lua

require("scripts/managers/stats/stats_collection")
require("scripts/managers/stats/stats_contexts")
require("scripts/settings/experience_settings")
require("scripts/settings/currency_settings")

local function is_squad_wipe(victim)
	local squad_index = victim.squad_index

	if squad_index then
		for member, _ in pairs(victim.team.squads[squad_index]:members()) do
			if Unit.alive(member.player_unit) and ScriptUnit.extension(member.player_unit, "damage_system"):is_alive() then
				return false
			end
		end

		return true
	end

	return false
end

StatsCollectorServer = class(StatsCollectorServer)

function StatsCollectorServer:init(stats_collection)
	self._stats = stats_collection

	Managers.state.event:register(self, "player_self_kd", "event_player_self_kd", "player_team_kd", "event_player_team_kd", "player_enemy_kd", "event_player_enemy_kd", "player_self_kill", "event_player_self_kill", "player_team_kill", "event_player_team_kill", "player_enemy_kill", "event_player_enemy_kill", "enemy_kill_within_objective", "event_enemy_kill_within_objective", "player_spawned_at_unit", "event_player_spawned_at_unit", "player_parried", "event_player_parried", "anti_cheat_status_changed", "event_anti_cheat_status_changed", "anti_cheat_connect", "event_anti_cheat_connect", "anti_cheat_kick", "event_anti_cheat_kick")
end

function StatsCollectorServer:event_anti_cheat_status_changed(peer_id, status)
	if status == AntiCheat.USER_BANNED then
		self._stats:increment(peer_id, "anti_cheat_status_banned", 1)
	elseif status == AntiCheat.USER_DISCONNECTED then
		self._stats:increment(peer_id, "anti_cheat_status_disconnected", 1)
	elseif status == AntiCheat.USER_AUTHENTICATED then
		self._stats:increment(peer_id, "anti_cheat_status_authenticated", 1)
	end
end

function StatsCollectorServer:event_anti_cheat_connect(peer_id)
	self._stats:increment(peer_id, "anti_cheat_connects", 1)
end

function StatsCollectorServer:event_anti_cheat_kick(peer_id)
	self._stats:increment(peer_id, "anti_cheat_kicks", 1)
end

function StatsCollectorServer:event_player_self_kd(player)
	local player_id = player:network_id()

	self._stats:increment(player_id, "deaths", 1)
	self._stats:increment(player_id, "player_stats", "deaths", 1)
	self._stats:set(player_id, "first_kill_since_death", false)
	self._stats:set(player_id, "kill_streak", 0)
end

function StatsCollectorServer:event_player_team_kd(victim, attacker, gear_name, damage_type)
	local victim_id, attacker_id = victim:network_id(), attacker:network_id()

	self._stats:increment(attacker_id, "team_kills", 1)
	self._stats:increment(attacker_id, "experience_penalty", ExperienceSettings.team_kill)
	self._stats:increment(victim_id, "deaths", 1)
	self._stats:increment(victim_id, "player_stats", "deaths", 1)
	self._stats:set(victim_id, "first_kill_since_death", false)
	self._stats:set(victim_id, "kill_streak", 0)
	self:_penalty(attacker, "team_kill", 1)
end

function StatsCollectorServer:event_player_enemy_kd(victim, attacker, gear_name, damagers)
	local victim_id, attacker_id = victim:network_id(), attacker:network_id()

	self._stats:increment(attacker_id, "kills_with_" .. Gear[gear_name].stat_category, 1)
	self._stats:increment(attacker_id, "weapon_stats", gear_name, "knockdowns", 1)
	self:_player_killed(victim, attacker, gear_name, damagers, false)
end

function StatsCollectorServer:event_enemy_kill_within_objective(attacker)
	local attacker_id = attacker:network_id()

	self._stats:increment(attacker_id, "enemy_kill_within_objective", 1)
	self:_gain_xp_and_coins(attacker, "enemy_kill_within_objective")
end

function StatsCollectorServer:event_player_self_kill(player, damage_type)
	local player_id = player:network_id()

	if damage_type == "yield" then
		self._stats:increment(player_id, "yields", 1)
	else
		self._stats:increment(player_id, "deaths", 1)
		self._stats:increment(player_id, "player_stats", "deaths", 1)
	end

	self._stats:set(player_id, "first_kill_since_death", false)
	self._stats:set(player_id, "kill_streak", 0)
end

function StatsCollectorServer:event_player_team_kill(victim, attacker, gear_name, is_instakill)
	if is_instakill then
		local victim_id, attacker_id = victim:network_id(), attacker:network_id()

		self._stats:increment(attacker_id, "team_kills", 1)
		self._stats:increment(attacker_id, "experience_penalty", ExperienceSettings.team_kill)
		self._stats:increment(victim_id, "deaths", 1)
		self._stats:increment(victim_id, "player_stats", "deaths", 1)
		self._stats:set(victim_id, "first_kill_since_death", false)
		self._stats:set(victim_id, "kill_streak", 0)
		self:_penalty(attacker, "team_kill", 1)
	end
end

function StatsCollectorServer:event_player_enemy_kill(victim, attacker, gear_name, is_instakill, damagers)
	local victim_id, attacker_id = victim:network_id(), attacker:network_id()

	if is_instakill then
		self:_player_killed(victim, attacker, gear_name, damagers, true)
	elseif gear_name == "execution" then
		self._stats:increment(attacker_id, "executions", 1)
		self:_gain_xp_and_coins(attacker, "execution")
	end
end

function StatsCollectorServer:_player_killed(victim, attacker, gear_name, damagers, is_instakill)
	local victim_id, attacker_id = victim:network_id(), attacker:network_id()

	self._stats:increment(attacker_id, "enemy_kills", 1)
	self._stats:increment(attacker_id, "player_stats", "kills", 1)
	self._stats:increment(attacker_id, "kill_streak", 1)

	local kill_streak = self._stats:get(attacker_id, "kill_streak")

	self._stats:max(attacker_id, "longest_kill_streak", kill_streak)

	if is_instakill then
		self._stats:increment(attacker_id, "weapon_stats", gear_name, "instakills", 1)
		self:_gain_xp_and_coins(attacker, "enemy_instakill")
	else
		self._stats:increment(attacker_id, "weapon_stats", gear_name, "knockdowns", 1)
		self:_gain_xp_and_coins(attacker, "enemy_knockdown")
	end

	if self._stats:get(attacker_id, "first_kill_since_death") then
		self._stats:increment(attacker_id, "successive_kills", 1)
		self:_gain_xp_and_coins(attacker, "successive_kill")
	else
		self._stats:set(attacker_id, "first_kill_since_death", true)
	end

	if Unit.alive(victim.player_unit) then
		local victim_loc = ScriptUnit.extension(victim.player_unit, "locomotion_system")

		if victim_loc:mounted() then
			self._stats:increment(attacker_id, "enemy_mounted_kills", 1)
		end

		local tagger = Managers.state.tagging:tagger_by_tagged_unit(victim.player_unit)

		if tagger then
			self._stats:increment(attacker_id, "tagged_assists", 1)
			self:_gain_xp_and_coins(attacker, "tag_kill")

			if Unit.alive(tagger.player_unit) then
				local has_spotter = ScriptUnit.extension(tagger.player_unit, "locomotion_system"):has_perk("spotter")

				if has_spotter then
					self:_gain_xp_and_coins(tagger, "tagger_reward", ExperienceSettings.tagger_reward * 2, CurrencySettings.tagger_reward * 2)
				else
					self:_gain_xp_and_coins(tagger, "tagger_reward")
				end
			end
		end
	end

	if Unit.alive(attacker.player_unit) then
		local attacker_loc = ScriptUnit.extension(attacker.player_unit, "locomotion_system")

		if attacker_loc:mounted() then
			self._stats:increment(attacker_id, "enemy_kills_while_mounted", 1)
		end
	end

	if victim.is_corporal then
		self._stats:increment(attacker_id, "enemy_corporal_kills", 1)
	end

	for assister, _ in pairs(damagers) do
		if Managers.player:player_exists(assister.index) and attacker ~= assister and assister.team ~= victim.team then
			local assister_id = assister:network_id()

			self._stats:increment(assister_id, "assists", 1)
			self:_gain_xp_and_coins(assister, "assist")
		end
	end

	if is_squad_wipe(victim) then
		self._stats:increment(attacker_id, "squad_wipes", 1)
		self:_gain_xp_and_coins(attacker, "squad_wipe")
	end

	self._stats:increment(victim_id, "deaths", 1)
	self._stats:increment(victim_id, "player_stats", "deaths", 1)
	self._stats:set(victim_id, "first_kill_since_death", false)
	self._stats:set(victim_id, "kill_streak", 0)
end

function StatsCollectorServer:event_player_parried(hit_gear_unit, gear_unit)
	local user_unit = Unit.get_data(hit_gear_unit, "user_unit")
	local blocker = Managers.player:owner(user_unit)
	local blocker_id = blocker:network_id()
	local gear_name = Unit.get_data(hit_gear_unit, "gear_name")

	self._stats:increment(blocker_id, "weapon_stats", gear_name, "parries", 1)
end

function StatsCollectorServer:player_revived(revivee, reviver)
	local revivee_id, reviver_id = revivee:network_id(), reviver:network_id()

	self._stats:increment(reviver_id, "revives", 1)
	self._stats:increment(reviver_id, "player_stats", "revives", 1)
	self:_gain_xp_and_coins(reviver, "revive")
end

function StatsCollectorServer:player_self_bandage(player)
	return
end

function StatsCollectorServer:player_team_bandage(bandagee, bandager)
	local bandagee_id, bandager_id = bandagee:network_id(), bandager:network_id()

	self._stats:increment(bandager_id, "team_bandages", 1)
	self:_gain_xp_and_coins(bandager, "team_bandage")
end

function StatsCollectorServer:player_self_damage(player, damage, gear_name, hit_zone, damage_range_type, mirrored)
	if mirrored then
		self:player_team_damage(player, player, damage, gear_name, hit_zone)
	end
end

function StatsCollectorServer:player_team_damage(damagee, damager, damage, gear_name, hit_zone)
	local damager_id = damager:network_id()

	self._stats:increment(damager_id, "team_hits", 1)
	self._stats:increment(damager_id, "team_damage", damage)
	self._stats:increment(damager_id, "experience_penalty", ExperienceSettings.team_damage * damage)
	self:_penalty(damager, "team_damage", damage)
end

function StatsCollectorServer:player_enemy_damage(damagee, damager, damage, gear_name, hit_zone, damage_range_type, range)
	local damagee_id, damager_id = damagee:network_id(), damager:network_id()

	self._stats:increment(damager_id, "enemy_damage", damage)
	self:_gain_xp_and_coins(damager, "enemy_damage", ExperienceSettings.enemy_damage * damage, CurrencySettings.enemy_damage * damage)

	if hit_zone == "head" or hit_zone == "helmet" and damage > 0 then
		if Gear[gear_name].stat_category == "crossbow" then
			self._stats:increment(damager_id, "headshots_with_crossbow", 1)
		end

		if damage_range_type == "small_projectile" then
			if damage <= 0 then
				self._stats:increment(damager_id, "headshots_bounced", 1)
			else
				self._stats:increment(damager_id, "headshots", 1)

				if range then
					if range > 45.72 then
						self:_gain_xp_and_coins(damager, "longshot")
						self._stats:increment(damager_id, "longshots", 1)
					end

					self._stats:max(damager_id, "headshot_range", range)
				end
			end

			self:_gain_xp_and_coins(damager, "headshot")
		end
	end

	self._stats:increment(damager_id, "weapon_stats", gear_name, PlayerUnitDamageSettings.hit_zones[hit_zone].hit_stat, 1)
	self._stats:increment(damager_id, "weapon_stats", gear_name, PlayerUnitDamageSettings.hit_zones[hit_zone].damage_stat, damage)
end

function StatsCollectorServer:mount_stray_kill(attacker)
	return
end

function StatsCollectorServer:mount_team_kill(attacker, rider)
	return
end

function StatsCollectorServer:mount_enemy_kill(attacker, rider)
	self._stats:increment(attacker:network_id(), "enemy_mount_kills", 1)
end

function StatsCollectorServer:player_self_dotted(victim, attacker, damage_type)
	return
end

function StatsCollectorServer:player_team_dotted(victim, attacker, damage_type)
	return
end

function StatsCollectorServer:player_enemy_dotted(victim, attacker, damage_type)
	return
end

function StatsCollectorServer:event_player_spawned_at_unit(player, squad_player)
	local squad_player_id = squad_player:network_id()

	self:_gain_xp_and_coins(squad_player, "squad_spawn")
	self._stats:increment(squad_player_id, "squad_spawns", 1)
	self._stats:increment(squad_player_id, "squad_spawns_round", 1)
end

function StatsCollectorServer:weapon_missed(player, gear_name)
	self._stats:increment(player:network_id(), "weapon_stats", gear_name, "misses", 1)
end

function StatsCollectorServer:objective_captured(capturing_player)
	local player_id = capturing_player:network_id()

	self._stats:increment(player_id, "objectives_captured", 1)
	self:_gain_xp_and_coins(capturing_player, "objective_captured")
end

function StatsCollectorServer:objective_captured_assist(assist_player)
	local player_id = assist_player:network_id()

	self._stats:increment(player_id, "objectives_captured_assist", 1)
	self:_gain_xp_and_coins(assist_player, "objective_captured_assist")
end

function StatsCollectorServer:section_cleared_payload(assist_player)
	local player_id = assist_player:network_id()

	self._stats:increment(player_id, "section_cleared_payload", 1)
	self:_gain_xp_and_coins(assist_player, "section_cleared_payload")
end

function StatsCollectorServer:_gain_xp_and_coins(player, reason, xp_amount, coin_amount)
	local xp_multiplier = player.is_demo and ExperienceSettings.DEMO_MULTIPLIER or ExperienceSettings.MULTIPLIER
	local coin_multiplier = player.is_demo and CurrencySettings.DEMO_MULTIPLIER or CurrencySettings.MULTIPLIER
	local xp = xp_multiplier * (xp_amount or ExperienceSettings[reason])
	local coins = coin_multiplier * (coin_amount or CurrencySettings[reason])

	if not Managers.state.team:stats_requirement_fulfilled() then
		xp, coins = 0, 0
	end

	self._stats:increment(player:network_id(), "experience_round", xp)
	self._stats:increment(player:network_id(), "coins", coins)

	if Managers.state.network:game() then
		RPC.rpc_gain_xp_and_coins(player:network_id(), NetworkLookup.xp_reason[reason], xp, coins)
	end
end

function StatsCollectorServer:_penalty(player, reason, amount)
	local penalty_amount = amount or ExperienceSettings[reason]

	if not Managers.state.team:stats_requirement_fulfilled() then
		penalty_amount = 0
	end

	if Managers.state.network:game() then
		RPC.rpc_xp_penalty(player:network_id(), NetworkLookup.penalty_reason[reason], penalty_amount)
	end
end

function StatsCollectorServer:round_finished(game_mode_key, winning_team)
	local scores = {
		red = {},
		white = {},
		all = {}
	}
	local squad_scores = {
		red = {},
		white = {}
	}
	local players = Managers.player:players()

	for player_index, player in pairs(players) do
		local network_id = player:network_id()
		local team_name = player.team and player.team.name or nil

		if winning_team then
			local round_won = winning_team.members[player_index] ~= nil

			self._stats:set(network_id, "round_won", round_won)
			self._stats:set(network_id, game_mode_key .. "_round_won", round_won)

			if round_won then
				self._stats:increment(network_id, "player_stats", game_mode_key .. "_round_won", 1)
				self._stats:increment(network_id, "experience_bonus", ExperienceSettings.round_won)
				self._stats:increment(network_id, "coins", CurrencySettings.round_win_bonus)
				RPC.rpc_award_round_win_bonus(network_id, CurrencySettings.round_win_bonus)
				print("ROUND WON - BONUS COINS", CurrencySettings.round_win_bonus)

				local win_time = Application.utc_time()
				local last_win_time = self._stats:get(network_id, "last_win_time") or 0
				local time_diff = math.abs(os.difftime(win_time, last_win_time))

				if time_diff >= 86400 then
					self._stats:increment(network_id, "coins", CurrencySettings.daily_win_bonus)
					RPC.rpc_award_daily_win_bonus(network_id, CurrencySettings.daily_win_bonus)
					self._stats:set(network_id, "last_win_time", win_time)
					print("Daily win bonus for", player:name(), last_win_time, win_time, time_diff)
				end
			end
		end

		self._stats:set(network_id, game_mode_key .. "_round_finished", true)
		self._stats:increment(network_id, "player_stats", game_mode_key .. "_round_played", 1)

		local xp = self._stats:get(network_id, "experience_round")
		local xp_bonus = self._stats:get(network_id, "experience_bonus") / 100
		local xp_penalty = math.clamp(self._stats:get(network_id, "experience_penalty") / 100, 0, 1)
		local xp_final = xp * (1 + xp_bonus) * (1 - xp_penalty)

		self._stats:set(network_id, "experience_round", xp_final)
		self._stats:set(network_id, "experience_round_final", xp_final)
		self._stats:increment(network_id, "experience", xp_final)

		local coins = self._stats:get(network_id, "coins")
		local coins_final = coins * (1 + xp_bonus) * (1 - xp_penalty)

		self._stats:set(network_id, "coins", coins_final)

		local player_experience = self._stats:get(network_id, "experience_round")
		local player_and_exp = {
			pid = network_id,
			xp = player_experience
		}

		if team_name ~= "unassigned" then
			table.insert(scores[team_name], player_and_exp)
			table.insert(scores.all, player_and_exp)

			if player.squad_index then
				local squad = player.team.squads[player.squad_index]

				squad_scores[team_name][squad] = (squad_scores[team_name][squad] or 0) + player_experience
			end
		end
	end

	local function comparator(e1, e2)
		return e1.xp > e2.xp
	end

	table.sort(scores.red, comparator)
	table.sort(scores.white, comparator)
	table.sort(scores.all, comparator)

	for placement, player_and_exp in pairs(scores.red) do
		self._stats:set(player_and_exp.pid, "placement_team", placement)
	end

	for placement, player_and_exp in pairs(scores.white) do
		self._stats:set(player_and_exp.pid, "placement_team", placement)
	end

	for placement, player_and_exp in pairs(scores.all) do
		self._stats:set(player_and_exp.pid, "placement", placement)
	end

	local squad_placements = {
		red = {},
		white = {},
		all = {}
	}

	for squad, xp in pairs(squad_scores.red) do
		table.insert(squad_placements.red, {
			squad = squad,
			xp = xp
		})
		table.insert(squad_placements.all, {
			squad = squad,
			xp = xp
		})
	end

	for squad, xp in pairs(squad_scores.white) do
		table.insert(squad_placements.white, {
			squad = squad,
			xp = xp
		})
		table.insert(squad_placements.all, {
			squad = squad,
			xp = xp
		})
	end

	table.sort(squad_placements.red, comparator)
	table.sort(squad_placements.white, comparator)
	table.sort(squad_placements.all, comparator)

	for placement, squad_and_exp in pairs(squad_placements.all) do
		for member, _ in pairs(squad_and_exp.squad:members()) do
			self._stats:set(member:network_id(), "placement_squad", placement)
		end
	end
end
