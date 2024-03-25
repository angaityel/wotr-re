-- chunkname: @scripts/helpers/level_helper.lua

LevelHelper = LevelHelper or {}

function LevelHelper:current_level_settings()
	local level_key = Managers.state.game_mode:level_key()

	return LevelSettings[level_key]
end

function LevelHelper:current_level(world)
	local level_settings = self:current_level_settings()
	local level = ScriptWorld.level(world, level_settings.level_name)

	return level
end
