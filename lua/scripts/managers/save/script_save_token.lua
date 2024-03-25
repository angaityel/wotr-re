-- chunkname: @scripts/managers/save/script_save_token.win32.lua

ScriptSaveToken = class(ScriptSaveToken)

function ScriptSaveToken:init(adapter, token)
	self._adapter = adapter
	self._token = token
	self._info = {}
	self._name = "ScriptSaveToken"
end

function ScriptSaveToken:name()
	return self._name
end

function ScriptSaveToken:update()
	self._info = self._adapter.progress(self._token)
end

function ScriptSaveToken:info()
	return self._info
end

function ScriptSaveToken:done()
	return self._info.done
end

function ScriptSaveToken:close()
	self._adapter.close(self._token)
end
