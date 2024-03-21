-- chunkname: @scripts/managers/command_parser/command_parser_manager.lua

CommandParserManager = class(CommandParserManager)

local COMMAND_PREFIX = "/"
local ARGUMENT_PREFIX = " "

function CommandParserManager:init()
	return
end

function CommandParserManager:execute(command_line, player)
	local command, argument = self:_parse_command_line(command_line)
	local command_func = Commands[command]
	local success, message

	if command_func then
		success, message = command_func(self, argument, player)
	end

	return success, message, command, argument
end

function CommandParserManager:_is_valid_command_line(command_line)
	if string.sub(command_line, 1, string.len(COMMAND_PREFIX)) == COMMAND_PREFIX then
		return true
	end
end

function CommandParserManager:_parse_command_line(command_line)
	if self:_is_valid_command_line(command_line) then
		local cmd_prefix_start, cmd_prefix_end = string.find(command_line, COMMAND_PREFIX)
		local arg_prefix_start, arg_prefix_end = string.find(command_line, ARGUMENT_PREFIX, cmd_prefix_end)
		local command, argument

		if arg_prefix_start then
			command = string.sub(command_line, cmd_prefix_end + 1, arg_prefix_start - 1)
		else
			command = string.sub(command_line, cmd_prefix_end + 1)
		end

		if arg_prefix_end then
			argument = string.sub(command_line, arg_prefix_end + 1)
		end

		return command, argument
	end
end

function CommandParserManager:build_command_line(command, argument)
	local cmd_line = COMMAND_PREFIX .. command

	if argument then
		cmd_line = cmd_line .. ARGUMENT_PREFIX .. argument
	end

	return cmd_line
end

function CommandParserManager:destroy()
	return
end

Commands = {}

function Commands:script(lua_code, player)
	local code_function = loadstring(lua_code)

	if code_function then
		local ret = {
			code_function()
		}

		if #ret == 0 then
			Managers.state.hud:output_console_text("nil")
		else
			for _, val in ipairs(ret) do
				Managers.state.hud:output_console_text(tostring(val))
			end
		end
	else
		local code_function2 = loadstring("return " .. lua_code)

		if code_function2 then
			Managers.state.hud:output_console_text(tostring(code_function2()))
		end
	end
end

function Commands:lag(text)
	if Managers.lobby.lobby and text then
		Network.write_dump_tag(text)
		Managers.state.hud:output_console_text("Lag description '" .. text .. "' written to network dump.")
	elseif Managers.lobby.lobby then
		Managers.state.hud:output_console_text("No lag description written to network dump.")
	else
		Managers.state.hud:output_console_text("Lag description '" .. text .. "' not written to network dump since network is not initialized.")
	end
end

function Commands:location(text)
	Managers.state.event:trigger("location_print_requested")
end

function Commands:say(text, player)
	if text and text ~= "" then
		local spawn_state = player.spawn_data.state
		local channel_name = not (not Managers.state.game_mode:allow_ghost_talking() and (spawn_state == "dead" or spawn_state == "not_spawned")) and "all" or "dead"
		local channel_id = NetworkLookup.chat_channels[channel_name]

		Managers.chat:send_chat_message(channel_id, text)
	end
end

function Commands:say_team(text, player)
	if text and text ~= "" and player and player.team then
		local spawn_state = player.spawn_data.state
		local dead = not Managers.state.game_mode:allow_ghost_talking() and (spawn_state == "dead" or spawn_state == "not_spawned")
		local channel_id = player.team:team_chat_channel_id(dead)

		Managers.chat:send_chat_message(channel_id, text)
	end
end

function Commands:say_admin(text, player)
	if Managers.lobby.server and text ~= "" then
		Managers.chat:send_chat_message(1, text, "rpc_admin_chat_message")

		return true, ""
	end
end

function Commands:kill(text, player)
	local network_manager = Managers.state.network
	local unit = player.player_unit

	if unit and Unit.alive(unit) then
		if Managers.lobby.server or not network_manager:game() then
			local damage = ScriptUnit.extension(unit, "damage_system")

			if not damage:is_knocked_down() and not damage:is_dead() and not damage:is_wounded() then
				damage:die()
			end
		else
			local damage = ScriptUnit.extension(unit, "damage_system")

			if not damage:is_knocked_down() and not damage:is_dead() and not damage:is_wounded() then
				local object_id = network_manager:game_object_id(unit)

				network_manager:send_rpc_server("rpc_suicide", object_id)
			end
		end
	end
end

function Commands:console(args, player)
	if Application.build() ~= "dev" then
		return
	end

	local args_table = string.split(args, " ")
	local console_command_name = table.remove(args_table, 1)

	if #args_table > 0 then
		Application.console_command(console_command_name, unpack(args_table))
	else
		Application.console_command(console_command_name)
	end
end

function Commands:game_speed(args, player)
	if Application.build() ~= "dev" then
		return
	end

	local args_table = string.split(args, " ")
	local multiplier = tonumber(args_table[1])

	if type(multiplier) == "number" and Managers.state.network:game() then
		multiplier = math.clamp(multiplier, NetworkConstants.time_multiplier.min, NetworkConstants.time_multiplier.max)

		Managers.state.network:send_rpc_server("rpc_set_game_speed", multiplier)
	end
end

function Commands:fov(args, player)
	if Application.build() ~= "dev" then
		return
	end

	local args_table = string.split(args, " ")
	local fov = tonumber(args_table[1])

	script_data.fov_override = fov
end

function Commands:free_flight_settings(args, player)
	if Application.build() ~= "dev" or not player then
		return
	end

	local args_table = string.split(args, " ")
	local translation_acceleration = tonumber(args_table[1])
	local rotation_speed = tonumber(args_table[2])
	local return_string = "f8 free flight:"

	if translation_acceleration then
		player.free_flight_acceleration_factor = translation_acceleration
		return_string = return_string .. " translation acceleration: " .. translation_acceleration
	end

	if rotation_speed then
		player.free_flight_movement_filter_speed = rotation_speed
		return_string = return_string .. " rotation speed: " .. rotation_speed
	end

	Managers.state.hud:output_console_text(return_string)
end

function Commands:rcon(args, player)
	if player.rcon_admin then
		Managers.state.network:send_rpc_server("rpc_rcon", "", args)
	else
		local b, e = args:find("%s")

		if b and e then
			local hash = Application.make_hash(args:sub(1, b - 1))
			local command = args:sub(e + 1)

			Managers.state.network:send_rpc_server("rpc_rcon", hash, command)
		else
			Managers.state.hud:output_console_text(sprintf("Invalid command %q", args))
		end
	end
end

function Commands:next_level()
	Managers.state.event:trigger("next_level")
end

function Commands:list_players()
	local players = Managers.player:players()

	for _, player in pairs(players) do
		Managers.state.hud:output_console_text(player:name() .. "\t\t" .. player:network_id())
	end
end

function Commands:kick_player(args)
	if Managers.lobby.server then
		args = string.split(args, " ")

		local peer_id = args[1]
		local peer_id, reason = peer_id, args[2] or "kicked"

		if Managers.state.network:is_valid_peer(peer_id) then
			Managers.admin:kick_player(peer_id, reason)

			return true, sprintf("Player with ID %s kicked", peer_id)
		else
			return false, sprintf("No player found with ID %s", peer_id)
		end
	end
end

function Commands:ban_player(args)
	if Managers.lobby.server then
		args = string.split(args, " ")

		local peer_id = args[1]
		local peer_id, reason = peer_id, args[2] or "banned"

		if Managers.state.network:is_valid_peer(peer_id) then
			Managers.admin:ban_player(peer_id, reason)

			return true, sprintf("Player with ID %s banned", peer_id)
		else
			return false, sprintf("No player found with ID %s", peer_id)
		end
	end
end

function Commands:temp_ban_player(args)
	if Managers.lobby.server then
		args = string.split(args, " ")

		local peer_id = args[1]
		local duration = tonumber(args[2])
		local peer_id, duration, reason = peer_id, duration, args[3] or "banned"

		if Managers.state.network:is_valid_peer(peer_id) and duration then
			duration = 3600 * duration

			Managers.admin:ban_player(peer_id, reason, duration)

			return true, sprintf("Player with ID %s banned for %d hours", peer_id, duration)
		else
			return false, sprintf("No player found with ID %s", peer_id)
		end
	end
end

function Commands:unban_player(id_or_name)
	local response = Managers.admin:unban_player(id_or_name)

	if response then
		return false, sprintf("No player found with name/ID %s", response)
	else
		return true, sprintf("Player with name/ID %s unbanned", id_or_name)
	end
end

function Commands:kill_player(peer_id)
	if Managers.lobby.server then
		if Managers.state.network:is_valid_peer(peer_id) then
			Managers.admin:kill_player(peer_id)

			return true, sprintf("Player with ID %s killed", peer_id)
		else
			return false, sprintf("No player found with ID %s", peer_id)
		end
	end
end

Commands.ban = Commands.ban_player
Commands.kick = Commands.kick_player
Commands.temp_ban = Commands.temp_ban_player
Commands.unban = Commands.unban_player
Commands.kill_player = Commands.kill_player

function Commands:set_friendly_fire(config)
	if Managers.lobby.server then
		local melee_value, melee_mirrored, ranged_value, ranged_mirrored = unpack_string(config)

		melee_value, melee_mirrored, ranged_value, ranged_mirrored = Managers.admin:set_friendly_fire(melee_value, melee_mirrored, ranged_value, ranged_mirrored)

		return true, sprintf("Friendly fire settings changed: Melee damage multiplier = %s Mirror melee damage = %s Range damage multiplier = %s Mirror range damage = %s", tostring(melee_value), tostring(melee_mirrored), tostring(ranged_value), tostring(ranged_mirrored))
	end
end

function Commands:vote_kick(peer_id, player)
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if game then
		network_manager:send_rpc_server("rpc_vote_kick", peer_id, player:player_id())
	end
end

function Commands:y(_, player)
	Managers.state.voting:client_vote("yes", player)
end

function Commands:n(_, player)
	Managers.state.voting:client_vote("no", player)
end

function Commands:reload_level()
	if Managers.lobby.server then
		Managers.state.event:trigger("reload_level")
	end
end

function Commands:change_level(map_pair)
	if Managers.lobby.server then
		local server_map_name, game_mode = unpack_string(map_pair or "")

		if not server_map_name then
			return false, "Map name missing. For example: /rcon <password> /change_level St_Albans tdm"
		end

		if not game_mode then
			return true, "Game mode missing. For example: /rcon <password> /change_level St_Albans tdm"
		end

		local level_key = server_map_name_to_level_key(server_map_name)

		if not level_key then
			return true, sprintf("Invalid map name: %s", server_map_name)
		end

		local settings = Managers.admin:map_rotation_settings(level_key, game_mode)

		if not settings then
			return true, sprintf("Map %q and game mode %q is not defined in map_rotations settings file. Run /list_levels to see which maps are available.", server_map_name, game_mode)
		end

		local level_name = L(LevelSettings[level_key].display_name)
		local message = "Changing level to " .. level_name .. "..."

		Managers.chat:send_chat_message(1, message, "rpc_admin_chat_message")
		Managers.state.event:trigger("change_level", level_key, settings)

		return true, ""
	end
end

function Commands:save_progress(flag)
	if Managers.lobby.server then
		local flag = to_boolean(flag)

		Managers.persistence:set_save_progress(flag)

		return true, sprintf("Save progression set to %s", tostring(flag))
	end
end

function Commands:move_player(peer_team_pair)
	if Managers.lobby.server then
		local peer_id, team_name = unpack_string(peer_team_pair or "")
		local player = Managers.state.network:player_from_peer_id(peer_id)

		if not peer_id then
			return true, "Player ID missing"
		end

		if not player then
			return true, sprintf("Invalid player ID %q. See list of available peers with /list_players", peer_id)
		end

		if not team_name then
			return true, "Team name is missing. Available teams are 'red' and 'white'"
		end

		team_name = team_name:lower()

		if team_name ~= "red" and team_name ~= "white" then
			return true, sprintf("Invalid team name %q. Available teams are 'red' and 'white'", team_name)
		end

		if team_name == player.team.name then
			return true, sprintf("Player %q (%s) is already member of team %q", player:name(), peer_id, team_name)
		end

		local message = sprintf("Moving player %q (%s) to team %q", player:name(), peer_id, team_name)

		Managers.chat:send_chat_message(1, message, "rpc_admin_chat_message")
		Managers.state.team:move_player_to_team_by_name(player, team_name)
		Managers.admin:kill_player(peer_id)

		return true, message
	end
end

function Commands:add_reserved_slot(peer_id)
	if Managers.lobby.server then
		if not peer_id then
			return true, "Player ID missing"
		end

		local result = Managers.admin:add_reserved_slot(peer_id)

		if not result then
			return true, sprintf("A slot is already reserved for player %s", peer_id)
		else
			return true, sprintf("A slot has been reserved for player %s", peer_id)
		end
	end
end

function Commands:remove_reserved_slot(peer_id)
	if Managers.lobby.server then
		if not peer_id then
			return true, "Player ID missing"
		end

		local result = Managers.admin:remove_reserved_slot(peer_id)

		if not result then
			return true, sprintf("No reserved slot found for player %s", peer_id)
		else
			return true, sprintf("Reserved slot removed for player %s", peer_id)
		end
	end
end

function Commands:login(_, player)
	if Managers.lobby.server then
		local peer_id = player:network_id()
		local rcon_admin = Managers.admin:rcon_admin()
		local rcon_player = Managers.state.network:player_from_peer_id(rcon_admin)

		if not rcon_player then
			rcon_admin = nil

			Managers.admin:set_rcon_admin(nil)
		end

		if rcon_admin == peer_id then
			return true, "You are already logged in as RCON admin"
		elseif rcon_admin and rcon_admin ~= peer_id then
			return true, sprintf("Player with ID %s is currently logged in as RCON admin", rcon_admin)
		end

		Managers.admin:set_rcon_admin(peer_id)
		RPC.rpc_rcon_logged_in(peer_id, player:player_id())

		return true, "Successfully logged in as RCON admin"
	end
end

function Commands:logout(_, player)
	if Managers.lobby.server then
		local peer_id = player:network_id()
		local rcon_admin = Managers.admin:rcon_admin()

		if rcon_admin ~= peer_id then
			return true, "You are not logged in as RCON admin"
		end

		Managers.admin:set_rcon_admin(nil)
		RPC.rpc_rcon_logged_out(peer_id, player:player_id())

		return true, "Successfully logged out as RCON admin"
	end
end

function Commands:list_levels()
	local network_manager = Managers.state.network

	if network_manager:game() then
		network_manager:send_rpc_server("rpc_map_rotation")
	end
end

function Commands:vote_map(map_pair, player)
	if not Managers.lobby.server then
		local network_manager = Managers.state.network

		if network_manager:game() then
			network_manager:send_rpc_server("rpc_vote_map", player:player_id(), map_pair or "")
		end
	else
		return true, "/vote_map can't be executed as an RCON command."
	end
end
