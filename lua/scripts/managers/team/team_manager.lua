-- chunkname: @scripts/managers/team/team_manager.lua

require("scripts/managers/team/team")
require("scripts/settings/team_settings")

TeamManager = class(TeamManager)

function TeamManager:init(teams, reload_level_context)
	self._teams_by_side = {}
	self._teams_by_name = {}
	self._teams = {}
	self._sides = {}

	self:_init_teams(teams, reload_level_context or {})
end

function TeamManager:destroy()
	for _, team in pairs(self._teams_by_name) do
		team:destroy()
	end
end

function TeamManager:create_game_objects()
	for name, team in pairs(self._teams_by_name) do
		team:create_game_object()
	end
end

function TeamManager:cb_game_object_created(team_name, object_id)
	self._teams_by_name[team_name]:cb_game_object_created(object_id)
end

function TeamManager:cb_game_object_destroyed(team_name, object_id)
	self._teams_by_name[team_name]:cb_game_object_destroyed(object_id)
end

function TeamManager:_init_teams(teams, reload_level_context)
	for name, _ in pairs(teams) do
		self._teams[#self._teams + 1] = name
		self._teams_by_name[name] = Team:new(name, TeamSettings[name], reload_level_context[name] or {})
	end
end

function TeamManager:flow_cb_give_score(side, score)
	self:give_score_to_side(side, score)
end

function TeamManager:flow_cb_set_team_side(team_name, new_side)
	local team = self._teams_by_name[team_name]
	local old_side = team.side

	if old_side then
		self._teams_by_side[old_side] = nil
		self._sides[old_side] = nil
	end

	self._teams_by_side[new_side] = team

	team:set_side(new_side)

	self._sides[new_side] = new_side
end

function TeamManager:names()
	return self._teams
end

function TeamManager:sides()
	return self._sides
end

function TeamManager:name(side)
	fassert(self._teams_by_side[side], "Trying to get team name side %q that doesn't exist", side)

	return self._teams_by_side[side].name
end

function TeamManager:side(name)
	fassert(self._teams_by_name[name], "Trying to get side name of team %q that doesn't exist", name)

	return self._teams_by_name[name].side
end

function TeamManager:team_color_by_side(side)
	fassert(self._teams_by_side[side], "Trying to get team color of side %q that doesn't exist", side)

	return self._teams_by_side[side].color
end

function TeamManager:team_color_by_name(name)
	fassert(self._teams_by_name[name], "Trying to get team color of team %q that doesn't exist", name)

	return self._teams_by_name[name].color
end

function TeamManager:synch_teams(sender)
	for name, team in pairs(self._teams_by_name) do
		team:synch_team(sender)
	end
end

function TeamManager:add_player_to_team_by_name(player, team_name)
	self._teams_by_name[team_name]:add_member(player)
end

function TeamManager:remove_player_from_team_by_name(player, team_name)
	self._teams_by_name[team_name]:remove_member(player)
end

function TeamManager:move_player_to_team_by_name(player, team_name)
	self._teams_by_name[player.team.name]:remove_member_local(player)
	self._teams_by_name[team_name]:add_member_local(player)

	if Managers.lobby.server then
		Managers.state.network:send_rpc_clients("rpc_move_player_to_team", player.game_object_id, NetworkLookup.team[team_name])
	end
end

function TeamManager:add_player_to_team_by_side(player, side)
	self._teams_by_side[side]:add_member(player)
end

function TeamManager:remove_player_from_team_by_side(player, side)
	self._teams_by_side[side]:remove_member(player)
end

function TeamManager:team_by_name(name)
	return self._teams_by_name[name]
end

function TeamManager:team_by_side(side)
	return self._teams_by_side[side]
end

function TeamManager:give_score_to_side(side, score)
	self._teams_by_side[side]:give_score(score)
end

function TeamManager:give_score_to_team(team_name, score)
	self._teams_by_name[team_name]:give_score(score)
end

function TeamManager:add_player_by_reload_context(player)
	local network_id = player:network_id()

	for _, team in pairs(self._teams_by_name) do
		local members_table = team.reload_level_context.members
		local squad_index = members_table[network_id]

		if squad_index then
			members_table[network_id] = nil

			team:add_member(player)

			local squad = team.squads[squad_index]

			if squad and squad:can_join(player) then
				squad:add_member(player)
			end

			return true
		end
	end

	return false
end

function TeamManager:add_player_evenly(player)
	assert(next(self._teams_by_name), "[TeamManager:add_player_evenly()] Trying to add player to team without any teams defined.")

	local lowest_member_count = math.huge
	local smallest_team

	for _, team in pairs(self._teams_by_name) do
		if lowest_member_count > team.num_members or GameSettingsDevelopment.all_on_same_team then
			lowest_member_count = team.num_members
			smallest_team = team
		end
	end

	smallest_team:add_member(player)

	return smallest_team.name
end

function TeamManager:hot_join_synch(sender, player)
	self:synch_teams(sender)

	if not self:add_player_by_reload_context(player) then
		self:add_player_to_team_by_name(player, "unassigned")
	end
end

function TeamManager:objective_unit_side(objective_unit, unit)
	local objective_unit_side = Unit.get_data(objective_unit, "side")

	return objective_unit_side
end

function TeamManager:unit_side(unit)
	local owner = Managers.player:owner(unit)

	return owner and owner.team and owner.team.side or nil
end

function TeamManager:unit_team(unit)
	local owner = Managers.player:owner(unit)

	return owner and owner.team and owner.team.name or nil
end

function TeamManager:friendly_fire_multiplier(attacker_unit, victim_unit, damage_range_type)
	if self:is_on_same_team(attacker_unit, victim_unit) then
		return AttackDamageRangeTypes[damage_range_type].friendly_fire_multiplier
	else
		return 1
	end
end

function TeamManager:is_on_same_team(unit1, unit2)
	local player1 = Managers.player:owner(unit1)
	local player2 = Managers.player:owner(unit2)
	local player1_team = player1 and player1.team
	local player2_team = player2 and player2.team

	return player1_team and player2_team and player1_team == player2_team
end

function TeamManager:is_team_kill(player1, player2)
	return player1.team == player2.team
end

function TeamManager:is_team_knock_down(player1, player2)
	return player1.team == player2.team
end

function TeamManager:update(dt)
	for name, team in pairs(self._teams_by_name) do
		team:update(dt)
	end
end

function TeamManager:request_join_team(player, team_name)
	if player.team and player.team.name == team_name then
		Managers.state.event:trigger("join_team_confirmed")

		return
	end

	if Managers.lobby.server or not Managers.lobby.lobby then
		if not self:verify_join_team(player, team_name) then
			if Managers.state.network:game() then
				RPC.rpc_join_team_denied(player:network_id())
			end

			return
		end

		if player.spawn_data.state ~= "not_spawned" and player.spawn_data.state ~= "dead" then
			Managers.state.spawn:despawn_player_unit(player)
		end

		if player.team then
			self:move_player_to_team_by_name(player, team_name)
		else
			self:add_player_to_team_by_name(player, team_name)
		end

		if Managers.state.network:game() then
			RPC.rpc_join_team_confirmed(player:network_id())
		else
			Managers.state.event:trigger("join_team_confirmed")
		end
	else
		Managers.state.network:send_rpc_server("rpc_request_join_team", player:player_id(), NetworkLookup.team[team_name])
	end
end

function TeamManager:verify_join_team(player, team_name)
	local join_team = self:team_by_name(team_name)
	local other_team_name = team_name == "red" and "white" or "red"
	local other_team = self:team_by_name(other_team_name)
	local num_members_join_team = join_team.num_members
	local num_members_other_team = other_team.num_members

	if player.team and player.team.name ~= "unassigned" then
		if player.team == join_team then
			num_members_join_team = num_members_join_team - 1
		else
			num_members_other_team = num_members_other_team - 1
		end
	end

	return GameSettingsDevelopment.enable_robot_player or GameSettingsDevelopment.all_on_same_team or num_members_join_team <= num_members_other_team
end

function TeamManager:opposite_team(team)
	if team.name == "white" then
		return self:team_by_name("red")
	elseif team.name == "red" then
		return self:team_by_name("white")
	end
end

function TeamManager:stats_requirement_fulfilled()
	local min_team_size = GameSettingsDevelopment.min_team_size_to_save_stats
	local attackers = self:team_by_side("attackers")
	local defenders = self:team_by_side("defenders")

	return min_team_size <= table.size(attackers.members) and min_team_size <= table.size(defenders.members)
end

function TeamManager:reload_loading_context()
	local context = {}

	for name, team in pairs(self._teams_by_name) do
		context[name] = team:reload_loading_context()
	end

	return context
end
