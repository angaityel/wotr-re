-- chunkname: @scripts/managers/admin/script_rcon_server.lua

ScriptRconServer = class(ScriptRconServer)

function ScriptRconServer:init(settings)
	if settings then
		self._port = settings.port or 20000
		self._password = settings.password
		self._clients = {}
		self._enabled = true

		if RConServer.start(self._port) then
			cprintf("[RCON] Started")

			self._enabled = true
		else
			cprintf("[RCON] Failed to start")

			self._enabled = false
		end
	else
		cprintf("[RCON] Not started")

		self._enabled = false
	end
end

function ScriptRconServer:update(dt, t)
	if self._enabled then
		RConServer.update(dt, self)
	end
end

function ScriptRconServer:rcon_connect(id, ip_port, password)
	if password == self._password then
		cprintf("[RCON] Client with ID %s successfully connected", id)

		self._clients[id] = true

		return true
	end

	cprintf("[RCON] Client with ID %s supplied bad password", id)

	return false
end

function ScriptRconServer:rcon_command(id, command_string)
	cprintf("[RCON] Client %s issued the following command string: %s", id, command_string)

	local command, argument = unpack_string(command_string)

	if self._clients[id] then
		if command == "shutdown" then
			Application.quit()
		elseif command == "list_players" then
			local player_list = ""

			for _, player in pairs(Managers.player:players()) do
				player_list = player_list .. player:name() .. " " .. player:network_id() .. "\n"
			end

			return player_list
		elseif command == "kick_player" then
			Commands:kick_player(argument)
		elseif command == "ban_player" then
			Commands:ban_player(argument)
		elseif command == "say" then
			local say_text = vararg.join(" ", select(2, unpack_string(command_string)))

			Commands:say_admin(say_text)
		elseif command == "unban_player" then
			Commands:unban_player(argument)
		else
			return "unknown command"
		end
	else
		return "unauthorized"
	end
end

function ScriptRconServer:rcon_disconnect(id)
	cprintf("[RCON] Client with ID %s disconnected", id)

	self._clients[id] = nil
end
