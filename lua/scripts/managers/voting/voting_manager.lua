-- chunkname: @scripts/managers/voting/voting_manager.lua

VotingManager = class(VotingManager)
VotingTypes = VotingTypes or {}
VotingTypes.kick = VotingTypes.kick or {}
VotingTypes.kick.object_template = "vote_kick"
VotingTypes.kick.object_destroy_func = "cb_vote_destroyed"
VotingTypes.kick.game_object_created_func = "cb_vote_created"
VotingTypes.kick.owner_destroy_func = "cb_do_nothing"
VotingTypes.kick.time_limit = 30
VotingTypes.kick.minimum_votes_pass = 1
VotingTypes.kick.minimum_procent_pass = 0.51

function VotingTypes.kick.text(game, id)
	local vote_player_id = GameSession.game_object_field(game, id, "vote_player_id")
	local kicked_player_id = GameSession.game_object_field(game, id, "kicked_player_id")
	local player_manager = Managers.state.player
	local network_manager = Managers.state.network
	local vote_player = Managers.player:player(network_manager:temp_player_index(vote_player_id))
	local kicked_player = Managers.player:player(network_manager:temp_player_index(kicked_player_id))

	return L("vote_kick") .. kicked_player:name() .. "\t" .. L("vote_kick_initiator") .. vote_player:name()
end

function VotingTypes.kick.extra_game_object_fields(data_table, kicked_id)
	data_table.kicked_id = kicked_id

	for _, player in pairs(Managers.player:players()) do
		if player:network_id() == kicked_id then
			data_table.kicked_player_id = player:player_id()
		end
	end
end

function VotingTypes.kick:voter_eligible(kicked_id, voter_id)
	return true
end

function VotingTypes.kick:pass(peer_id)
	Managers.admin:ban_player(peer_id, "You were voted out.", 1800)
end

function VotingTypes.kick:fail()
	return
end

function VotingTypes.kick:valid(vote_player_id, peer_id)
	if not Managers.player:player_exists(vote_player_id) then
		return false
	end

	for _, player in pairs(Managers.player:players()) do
		if player:network_id() == peer_id then
			return true
		end
	end
end

function VotingTypes.kick:cancel()
	return
end

VotingTypes.change_level = VotingTypes.change_level or {}
VotingTypes.change_level.object_template = "vote_change_level"
VotingTypes.change_level.object_destroy_func = "cb_vote_destroyed"
VotingTypes.change_level.game_object_created_func = "cb_vote_created"
VotingTypes.change_level.owner_destroy_func = "cb_do_nothing"
VotingTypes.change_level.time_limit = 30
VotingTypes.change_level.minimum_votes_pass = 1
VotingTypes.change_level.minimum_procent_pass = 0.51

function VotingTypes.change_level.text(game, id)
	local vote_player_id = GameSession.game_object_field(game, id, "vote_player_id")
	local network_manager = Managers.state.network
	local vote_player = Managers.player:player(network_manager:temp_player_index(vote_player_id))
	local map_name = GameSession.game_object_field(game, id, "map")

	map_name = NetworkLookup.server_map_names[map_name]

	local level_key = server_map_name_to_level_key(map_name)
	local display_name = L(LevelSettings[level_key].display_name)
	local game_mode = GameSession.game_object_field(game, id, "game_mode")

	game_mode = NetworkLookup.game_mode_keys[game_mode]

	return sprintf("Change level to: %s (%s) - %s", display_name, game_mode:upper(), vote_player:name())
end

function VotingTypes.change_level:voter_eligible(...)
	--print("VotingTypes.change_level.voter_eligible", ...)

	return true
end

function VotingTypes.change_level:pass(map_game_mode_pair)
	Commands:change_level(map_game_mode_pair)
end

function VotingTypes.change_level:fail(...)
	print("VotingTypes.change_level.fail")
end

function VotingTypes.change_level:cancel(...)
	print("VotingTypes.change_level.cancel")
end

function VotingTypes.change_level:valid(voter_id, map_game_mode_pair)
	return true
end

function VotingTypes.change_level.extra_game_object_fields(data_table, map_game_mode_pair)
	local map, game_mode = unpack_string(map_game_mode_pair)

	data_table.map = NetworkLookup.server_map_names[map]
	data_table.game_mode = NetworkLookup.game_mode_keys[game_mode]
end

function VotingManager:init()
	self._current_vote = nil
end

function VotingManager:destroy()
	return
end

function VotingManager:update(dt, t)
	if Managers.lobby.server then
		self:_server_update(dt, t)
	else
		self:_client_update(dt, t)
	end
end

function VotingManager:_server_update(dt, t)
	local current_vote = self._current_vote

	if current_vote then
		if not current_vote.valid() then
			self:_end_vote("cancel")

			return
		end

		local round_time = Managers.time:time("round")
		local network_manager = Managers.state.network
		local game = network_manager:game()
		if game then
			local settings = current_vote.settings
			local id = current_vote.id
			local end_time = GameSession.game_object_field(game, id, "end_time")
			local result = self:_is_enough_votes(current_vote)

			if result then
				self:_end_vote(result)
			elseif end_time < round_time then
				self:_end_vote("fail")
			end
		else
			self._current_vote = nil
		end
	end
end

function VotingManager:_end_vote(end_type)
	local current_vote = self._current_vote

	self._current_vote = nil

	local network_manager = Managers.state.network

	if network_manager:game() then
		network_manager:destroy_game_object(current_vote.id)
		current_vote[end_type]()
	end
end

function VotingManager:_is_enough_votes(current_vote)
	local votes = current_vote.voted
	local players = Managers.player:players()
	local voters = 0
	local game = Managers.state.network:game()

	for _, player in pairs(players) do
		local player_id = player:player_id()
		local eligible = current_vote.voter_eligible(player)

		if eligible then
			voters = voters + 1
		elseif votes.yes[player_id] then
			self:_remove_vote("yes", player_id)
		elseif votes.no[player_id] then
			self:_remove_vote("no", player_id)
		end
	end

	local id = current_vote.id

	GameSession.set_game_object_field(game, id, "voters", voters)

	local yes_votes = GameSession.game_object_field(game, id, "yes")
	local settings = current_vote.settings
	local minimum_votes_pass = yes_votes >= settings.minimum_votes_pass
	local minimum_procent_pass = yes_votes / voters >= settings.minimum_procent_pass

	if minimum_votes_pass and minimum_procent_pass then
		return "pass"
	end

	local no_votes = GameSession.game_object_field(game, id, "no")
	local settings = current_vote.settings
	local minimum_votes_fail = yes_votes > voters - settings.minimum_votes_pass
	local minimum_procent_fail = no_votes / voters > 1 - settings.minimum_procent_pass

	if minimum_votes_fail or minimum_procent_fail then
		return "fail"
	end
end

function VotingManager:_remove_vote(vote, player_id)
	local current_vote = self._current_vote
	local votes = current_vote.voted[vote]

	votes[player_id] = nil

	local game = Managers.state.network:game()
	local id = current_vote.id
	local number_votes = GameSession.game_object_field(game, id, vote)

	GameSession.set_game_object_field(game, id, vote, number_votes - 1)
end

function VotingManager:_add_vote(vote, player_id)
	local current_vote = self._current_vote
	local votes = current_vote.voted[vote]

	votes[player_id] = true

	local game = Managers.state.network:game()
	local id = current_vote.id
	local number_votes = GameSession.game_object_field(game, id, vote)

	GameSession.set_game_object_field(game, id, vote, number_votes + 1)
end

function VotingManager:start_vote(vote_type, vote_player, ...)
	if self._current_vote then
		return false
	end

	local vote_player_id = vote_player:player_id()
	local network_manager = Managers.state.network
	local game = network_manager:game()
	local type_settings = VotingTypes[vote_type]
	local is_valid_callback = callback(type_settings, "valid", vote_player_id, ...)

	if not is_valid_callback() then
		return
	end

	local data_table = {
		yes = 1,
		voters = 0,
		no = 0,
		object_destroy_func = NetworkLookup.game_object_functions[type_settings.object_destroy_func],
		game_object_created_func = NetworkLookup.game_object_functions[type_settings.game_object_created_func],
		owner_destroy_func = NetworkLookup.game_object_functions[type_settings.owner_destroy_func],
		type = NetworkLookup.voting_types[vote_type],
		end_time = Managers.time:time("round") + type_settings.time_limit,
		vote_player_id = vote_player_id
	}

	type_settings.extra_game_object_fields(data_table, ...)

	local id = network_manager:create_game_object(type_settings.object_template, data_table)

	self._current_vote = {
		id = id,
		settings = type_settings,
		voted = {
			yes = {
				vote_player_id = true
			},
			no = {}
		},
		voter_eligible = callback(type_settings, "voter_eligible", ...),
		pass = callback(type_settings, "pass", ...),
		fail = callback(type_settings, "fail", ...),
		cancel = callback(type_settings, "cancel", ...),
		valid = is_valid_callback
	}

	return id
end

function VotingManager:rpc_vote(vote_cast, voter, id)
	local current_vote = self._current_vote

	if not current_vote or current_vote.id ~= id or not current_vote.voter_eligible(voter) then
		return
	end

	local voter_id = voter:player_id()
	local votes = current_vote.voted
	local opposite = vote_cast == "yes" and "no" or "yes"

	if votes[vote_cast][voter_id] then
		return
	elseif votes[opposite][voter_id] then
		self:_remove_vote(opposite, voter_id)
	end

	self:_add_vote(vote_cast, voter_id)
end

function VotingManager:client_vote_created(id)
	local current_vote = self._current_vote

	fassert(not current_vote, "VotingManager:client_vote_created( %0.i ) called when existing vote with id %0.i exists.", id, current_vote and current_vote.id)

	local blackboard = {
		text = "",
		header_text = ""
	}

	self._current_vote = {
		id = id,
		blackboard = blackboard
	}

	Managers.state.event:trigger("tutorial_box_activated", blackboard)
end

function VotingManager:client_vote_destroyed(id)
	local current_vote = self._current_vote

	fassert(current_vote and current_vote.id == id, "VotingManager:client_vote_destroyed( %0.i ) called when existing vote with id %0.i does not match.", id, current_vote and current_vote.id)

	self._current_vote = nil

	Managers.state.event:trigger("tutorial_box_deactivated")
end

function VotingManager:_client_update(dt, t)
	local current_vote = self._current_vote

	if current_vote then
		local round_time = Managers.time:time("round")
		local id = current_vote.id
		local game = Managers.state.network:game()
		local yes = GameSession.game_object_field(game, id, "yes")
		local no = GameSession.game_object_field(game, id, "no")
		local voters = GameSession.game_object_field(game, id, "voters")
		local end_time = GameSession.game_object_field(game, id, "end_time")
		local type = NetworkLookup.voting_types[GameSession.game_object_field(game, id, "type")]
		local settings = VotingTypes[type]
		local header_text = settings.text(game, id)
		local pad_active = Managers.input:pad_active(1)
		local text

		if pad_active then
			text = L("vote_yes_pad360") .. yes .. "\t" .. L("vote_no_pad360") .. no .. "\t" .. L("vote_undecided") .. voters - (yes + no) .. "\t" .. L("vote_time_left") .. string.format("%.0i", end_time - round_time)
		else
			text = L("vote_yes") .. yes .. "\t" .. L("vote_no") .. no .. "\t" .. L("vote_undecided") .. voters - (yes + no) .. "\t" .. L("vote_time_left") .. string.format("%.0i", end_time - round_time)
		end

		current_vote.blackboard.header_text = header_text
		current_vote.blackboard.text = text
	end
end

function VotingManager:client_vote(vote, player)
	local network_manager = Managers.state.network
	local current_vote = self._current_vote

	if not current_vote or not network_manager:game() then
		return
	end

	fassert(vote == "yes" or vote == "no", "VotingManager:client_vote( %s ) Incorrect vote cast %s.", tostring(vote), tostring(vote))
	network_manager:send_rpc_server("rpc_vote", vote == "yes" or false, player:player_id(), current_vote.id)
end

function VotingManager:vote_in_progress()
	return self._current_vote ~= nil
end
