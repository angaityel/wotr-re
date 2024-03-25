-- chunkname: @foundation/scripts/managers/token/token_manager.lua

TokenManager = class(TokenManager)

function TokenManager:init()
	self._tokens = {}
end

function TokenManager:register_token(token, callback, timeout)
	self._tokens[#self._tokens + 1] = {
		token = token,
		callback = callback,
		timeout = timeout or Managers.time:time("main") + (GameSettingsDevelopment.backend_timeout or 60)
	}
end

function TokenManager:update(dt, t)
	for id, entry in pairs(self._tokens) do
		local token = entry.token

		token:update()

		local timed_out = t >= entry.timeout

		if token:done() or timed_out then
			local callback = entry.callback

			if callback then
				local info = {}

				if token:done() then
					info = token:info()
				else
					info.code = 408
					info.body = ""
					info.failed = true
					info.error = "Request Timeout"

					printf("[TokenManager] %s %s", info.error, token:name())
				end

				callback(info)
			end

			token:close()

			self._tokens[id] = nil
		end
	end
end

function TokenManager:destroy()
	return
end
