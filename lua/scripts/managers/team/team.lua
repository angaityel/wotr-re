-- chunkname: @scripts/managers/team/team.lua

require("scripts/managers/team/squad")

Team = class(Team)

function Team:init(name, config, team_reload_context)
	self.name = name
	self.side = nil
	self.members = {}
	self.color = config.color
	self.secondary_color = config.secondary_color
	self.ui_name = config.ui_name and L(config.ui_name)
	self.ui_name_plural = config.ui_name_plural and L(config.ui_name_plural)
	self.ui_name_definite_plural = config.ui_name_definite_plural and L(config.ui_name_definite_plural)
	self.num_members = 0
	self.num_spawns = 0
	self.network_game = nil
	self.game_object_id = nil
	self.score = team_reload_context.score or 0
	self.squads = {}
	team_reload_context.members = team_reload_context.members or {}
	self.reload_level_context = team_reload_context

	for i = 1, config.number_of_squads do
		self.squads[i] = Squad:new(i, config.max_squad_members)
	end

	Managers.chat:register_channel(self:team_chat_channel_id(), callback(self, "members_network_ids"))
	Managers.chat:register_channel(self:team_chat_channel_id(true), callback(self, "members_network_ids"))
end

function Team:reload_loading_context()
	local context = {
		score = self.score,
		members = {}
	}

	for index, player in pairs(self.members) do
		context.members[player:network_id()] = player.squad_index or -1
	end

	return context
end

function Team:create_game_object()
	fassert(not self.game_object_id, "Team:create_game_object() Trying to create game object when game object already is created")

	local side = self.side or "unassigned"
	local allowed_spawns = Managers.state.game_mode:allowed_spawns(self)
	local squad_spawn_mode = Managers.state.game_mode:squad_spawn_mode(self)
	local squad_spawn_stun = Managers.state.game_mode:squad_spawn_stun(self)
	local team_locked_observer_cam = self.name ~= "observer" and not Managers.state.game_mode:team_locked_observer_cam(self)
	local force_limited_observer_cam = self.name ~= "observer" and Managers.state.game_mode:force_limited_observer_cam(self)

	if allowed_spawns == math.huge then
		allowed_spawns = -1
	end

	local data_table = {
		name = NetworkLookup.team[self.name],
		side = NetworkLookup.team[side],
		score = self.score,
		game_object_created_func = NetworkLookup.game_object_functions.cb_team_created,
		object_destroy_func = NetworkLookup.game_object_functions.cb_team_destroyed,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		allowed_spawns = allowed_spawns,
		squad_spawn_mode = NetworkLookup.squad_spawn_modes[squad_spawn_mode],
		squad_spawn_stun = squad_spawn_stun,
		team_locked_observer_cam = team_locked_observer_cam,
		force_limited_observer_cam = force_limited_observer_cam
	}

	self.network_game = Managers.state.network:game()

	local callback = callback(self, "cb_game_session_disconnect")

	self.game_object_id = Managers.state.network:create_game_object("team", data_table, callback)

	return self.game_object_id
end

function Team:cb_game_session_disconnect()
	self._frozen = true
	self.game_object_id = nil
	self.network_game = nil
end

function Team:cb_game_object_created(object_id)
	self.game_object_id = object_id
end

function Team:cb_game_object_destroyed(object_id)
	fassert(self.game_object_id == object_id, "[Team] destroying game object id %d, but game object id assigned to team %s is game_object id %d", object_id, self.name, self.game_object_id)

	self.game_object_id = nil
end

function Team:set_side(side)
	self.side = side

	if Managers.lobby.server and self.game_object_id then
		GameSession.set_game_object_field(self.network_game, self.game_object_id, "side", NetworkLookup.team[self.side])
	end
end

function Team:set_max_squad_size(max_squad_size)
	for _, squad in pairs(self.squads) do
		squad:set_max_size(max_squad_size)
	end
end

function Team:synch_team(sender)
	fassert(Managers.lobby.server, "Trying to synch teams from peer that isn't server.")

	for _, player in pairs(self.members) do
		RPC.rpc_add_player_to_team(sender, player.game_object_id, NetworkLookup.team[self.name])
	end

	for _, squad in pairs(self.squads) do
		squad:synch(sender)
	end
end

function Team:add_member(player)
	self.members[player.index] = player
	self.num_members = self.num_members + 1

	player:set_team(self)

	if Managers.lobby.server then
		Managers.state.network:send_rpc_clients("rpc_add_player_to_team", player.game_object_id, NetworkLookup.team[self.name])
	end

	Managers.state.event:trigger("player_joined_team", player)
end

function Team:remove_member(player)
	self.members[player.index] = nil
	self.num_members = self.num_members - 1

	Managers.state.event:trigger("player_left_team", player)
	player:set_team(nil)

	if Managers.lobby.server then
		if player.squad_index then
			self.squads[player.squad_index]:remove_member(player)
		end

		Managers.state.network:send_rpc_clients("rpc_remove_player_from_team", player.game_object_id, NetworkLookup.team[self.name])
	end
end

function Team:add_member_local(player)
	self.members[player.index] = player
	self.num_members = self.num_members + 1

	player:set_team(self)
	Managers.state.event:trigger("player_joined_team", player)
end

function Team:remove_member_local(player)
	self.members[player.index] = nil
	self.num_members = self.num_members - 1

	if Managers.lobby.server and player.squad_index then
		self.squads[player.squad_index]:remove_member(player)
	end

	Managers.state.event:trigger("player_left_team", player)
	player:set_team(nil)
end

function Team:set_score(score)
	self.score = score

	local network_game = Managers.state.network:game()

	if Managers.lobby.server and network_game and self.game_object_id then
		local score = math.clamp(self.score, NetworkConstants.team_score.min, NetworkConstants.team_score.max)

		GameSession.set_game_object_field(network_game, self.game_object_id, "score", score)
	end

	if script_data.team_debug then
		print("Team:set_score( ", score, " ) total:", self.score)
	end
end

function Team:give_score(score)
	local score = Managers.state.game_mode:game_mode_modified_score(score)

	self.score = self.score + score

	local network_game = Managers.state.network:game()

	if Managers.lobby.server and network_game and self.game_object_id then
		local score = math.clamp(self.score, NetworkConstants.team_score.min, NetworkConstants.team_score.max)

		GameSession.set_game_object_field(network_game, self.game_object_id, "score", score)
	end

	if script_data.team_debug then
		print("Team:give_score( ", score, " ) total:", self.score)
	end
end

function Team:team_chat_channel_id(dead)
	if dead then
		return NetworkLookup.chat_channels["dead_team_" .. self.name]
	else
		return NetworkLookup.chat_channels["team_" .. self.name]
	end
end

function Team:members_network_ids()
	local network_ids = {}

	for _, member in pairs(self.members) do
		network_ids[#network_ids + 1] = member:network_id()
	end

	return network_ids
end

function Team:update(dt)
	if self._frozen then
		return
	end

	local network_game = Managers.state.network:game()

	if not Managers.lobby.server and network_game then
		self.score = GameSession.game_object_field(network_game, self.game_object_id, "score")
	elseif network_game then
		local allowed_spawns = Managers.state.game_mode:allowed_spawns(self)

		if allowed_spawns == math.huge then
			allowed_spawns = -1
		end

		GameSession.set_game_object_field(network_game, self.game_object_id, "allowed_spawns", allowed_spawns)
	end
end

function Team:get_members()
	return self.members
end

function Team:destroy()
	for _, member in pairs(self.members) do
		member.team = nil
	end

	Managers.chat:unregister_channel(self:team_chat_channel_id())
	Managers.chat:unregister_channel(self:team_chat_channel_id(true))
end
