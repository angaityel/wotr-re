-- chunkname: @foundation/scripts/managers/chat/chat_manager.lua

require("foundation/scripts/managers/chat/chat_logger")

ChatManager = class(ChatManager)

function ChatManager:init()
	self._channels = {}

	local logger_settings = Application:settings().chat_log

	if logger_settings and logger_settings.enabled and logger_settings.file then
		self._logger = ChatLogger:new(logger_settings.file)
	end
end

function ChatManager:register_channel(channel_id, members_func)
	local channels = self._channels

	fassert(channels[channel_id] == nil, "[ChatManager] Tried to add already registered channel %q", channel_id)

	channels[channel_id] = {
		members_func = members_func
	}
end

function ChatManager:unregister_channel(channel_id)
	self._channels[channel_id] = nil
end

function ChatManager:send_chat_message(channel_id, message, rpc)
	local rpc_name = rpc or "rpc_chat_message"

	if Managers.lobby.hosting or Managers.lobby.server then
		local members = self:channel_members(channel_id)

		for _, member in pairs(members) do
			if member ~= Network.peer_id() then
				RPC[rpc_name](member, channel_id, Network.peer_id(), message)
			end
		end
	else
		local host = Managers.lobby:game_server_set()

		if host then
			RPC[rpc_name](host, channel_id, Network.peer_id(), message)
		end
	end

	Managers.state.event:trigger("event_chat_message", channel_id, Network.peer_id(), message)
end

function ChatManager:channel_members(channel_id)
	local channel = self._channels[channel_id]

	fassert(channel, "[ChatManager] Trying to get members from unregistered channel %q", channel_id)

	local members = channel.members_func()

	return members
end

function ChatManager:is_channel_member(channel_id)
	local channel = self._channels[channel_id]
	local members = channel.members_func()

	for _, member in pairs(members) do
		if member == Network.peer_id() then
			return true
		end
	end
end

function ChatManager:destroy()
	self._channels = nil
end

function ChatManager:register_chat_rpc_callbacks(callback_table)
	fassert(not callback_table.rpc_chat_message, "[ChatManager] Tried to add already registered rpc callback")

	callback_table.rpc_chat_message = ChatManagerCallbacks.rpc_chat_message
end

function ChatManager:has_channel(channel_id)
	return self._channels[channel_id] and true
end

function ChatManager:enable_logger()
	if self._logger then
		self._logger:subscribe()
	end
end

function ChatManager:set_chatlog_format_callback(name, func)
	if self._logger then
		self._logger:set_stringformat_callback(name, func)
	end
end

ChatManagerCallbacks = {}

function ChatManagerCallbacks:rpc_chat_message(sender, channel_id, message_sender, message)
	if not Managers.chat:has_channel(channel_id) then
		return
	end

	if Managers.lobby.hosting or Managers.lobby.server then
		local members = Managers.chat:channel_members(channel_id)

		for _, member in pairs(members) do
			if member ~= Network.peer_id() and member ~= sender then
				RPC.rpc_chat_message(member, channel_id, message_sender, message)
			end
		end
	end

	if Managers.chat:is_channel_member(channel_id) then
		Managers.state.event:trigger("event_chat_message", channel_id, message_sender, message)
	end
end
