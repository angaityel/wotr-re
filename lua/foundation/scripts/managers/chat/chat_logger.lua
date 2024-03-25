-- chunkname: @foundation/scripts/managers/chat/chat_logger.lua

ChatLogger = class(ChatLogger)

function ChatLogger:init(file_name)
	self._filepath = file_name
	self._stringformat_callback = {}
end

function ChatLogger:subscribe()
	self._file = TextFile(self._filepath, "w")

	Managers.state.event:register(self, "event_chat_message", "event_chat_message")
	Managers.state.event:register(self, "event_admin_chat_message", "event_admin_chat_message")
	Managers.state.event:register(self, "event_rcon_chat_message", "event_rcon_chat_message")
end

function ChatLogger:set_stringformat_callback(name, func)
	self._stringformat_callback[name] = func
end

function ChatLogger:event_chat_message(channel_id, sender, message)
	if self._stringformat_callback.chat then
		self._file:write(self._stringformat_callback.chat(channel_id, sender, message))
	else
		self._file:write(self:_default_string_forchat(channel_id, sender, message))
	end
end

function ChatLogger:event_admin_chat_message(channel_id, sender, message)
	if self._stringformat_callback.admin then
		self._file:write(self._stringformat_callback.admin(channel_id, sender, message))
	else
		self._file:write(self:_default_string_foradmin(channel_id, sender, message))
	end
end

function ChatLogger:event_rcon_chat_message(channel_id, sender, message)
	if self._stringformat_callback.rcon then
		self._file:write(self._stringformat_callback.rcon(channel_id, sender, message))
	else
		self._file:write(self:_default_string_forrcon(channel_id, sender, message))
	end
end

function ChatLogger:write_to_log(string)
	self._file:write(string)
end

function ChatLogger:_default_string_forchat(channel_id, sender, message)
	local channel = NetworkLookup.chat_channels[channel_id]
	local channel_name = L("chat_" .. channel)
	local name = rawget(_G, "Steam") and Steam.user_name(sender) or ""

	return os.date("%a %c ") .. "[" .. channel_name .. "] " .. name .. ": " .. message .. "\n"
end

function ChatLogger:_default_string_foradmin(channel_id, sender, message)
	return os.date("%a %c ") .. "[ Admin ]" .. message
end

function ChatLogger:_default_string_forrcon(channel_id, sender, message)
	return os.date("%a %c ") .. message
end
