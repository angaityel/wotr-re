-- chunkname: @scripts/managers/backend/script_backend_token.lua

ScriptBackendToken = class(ScriptBackendToken)

function ScriptBackendToken:init(token)
	self._token = token
	self._info = {}
	self._name = "ScriptBackendToken"
end

function ScriptBackendToken:name()
	return self._name
end

function ScriptBackendToken:update()
	self._info = Backend.progress(self._token)
end

function ScriptBackendToken:info()
	return self._info
end

function ScriptBackendToken:done()
	return self._info.done
end

function ScriptBackendToken:close()
	Backend.close(self._token)
end
