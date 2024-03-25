-- chunkname: @scripts/unit_extensions/default_player_unit/player_unit_deserter.lua

PlayerUnitDeserter = class(PlayerUnitDeserter)
PlayerUnitDeserter.OFFLINE_AND_SERVER_ONLY = true
PlayerUnitDeserter.SYSTEM = "deserting_system"

function PlayerUnitDeserter:destroy()
	return
end
