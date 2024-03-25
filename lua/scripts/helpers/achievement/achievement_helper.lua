-- chunkname: @scripts/helpers/achievement/achievement_helper.lua

require("scripts/helpers/achievement/script_achievement_token")

AchievementHelper = class(AchievementHelper)

function AchievementHelper:unlock(achievement_id, callback)
	local token = Achievement.unlock(achievement_id)
	local achievement_token = ScriptAchievementToken:new(token)

	Managers.token:register_token(achievement_token, callback)
end
