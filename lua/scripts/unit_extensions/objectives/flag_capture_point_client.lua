-- chunkname: @scripts/unit_extensions/objectives/flag_capture_point_client.lua

require("scripts/unit_extensions/objectives/capture_point_client_base")

FlagCapturePointClient = class(FlagCapturePointClient, CapturePointClientBase)

local CAPTURE_POINT_FLAG_HEALTH = 1

function FlagCapturePointClient:init(world, unit)
	FlagCapturePointClient.super.init(self, world, unit)
	Unit.set_data(unit, "health", CAPTURE_POINT_FLAG_HEALTH)
end

function FlagCapturePointClient:can_spawn_flag(picker_unit)
	local picker_player = Managers.player:owner(picker_unit)

	if not picker_player.team then
		return false
	end

	local picker_team_name = picker_player.team.name
	local owner_team = Managers.state.team:team_by_side(self._owner)

	return owner_team and owner_team.name == picker_team_name
end

function FlagCapturePointClient:can_plant_flag(planter_unit)
	local planter_player = Managers.player:owner(planter_unit)

	if not planter_player.team then
		return false
	end

	local planter_team_side = planter_player.team.side

	return self._owner == "neutral" and self._active[planter_team_side]
end

function FlagCapturePointClient:destroy()
	return
end
