-- chunkname: @scripts/helpers/achievement/script_achievement_token.lua

ScriptAchievementToken = class(ScriptAchievementToken)

function ScriptAchievementToken:init(token)
	self._token = token
	self._name = "ScriptAchievementToken"
end

function ScriptAchievementToken:name()
	return self._name
end

function ScriptAchievementToken:update()
	self._info = Achievement.progress(self._token)
end

function ScriptAchievementToken:info()
	return self._info
end

function ScriptAchievementToken:done()
	return self._info.done
end

function ScriptAchievementToken:close()
	Achievement.close(self._token)
end
