-- chunkname: @scripts/unit_extensions/objectives/grail_spawn_point_client.lua

require("scripts/unit_extensions/objectives/capture_point_client_base")

GrailSpawnPointClient = class(GrailSpawnPointClient, CapturePointClientBase)

function GrailSpawnPointClient:init(world, unit)
	GrailSpawnPointClient.super.init(self, world, unit)
end

function GrailSpawnPointClient:can_spawn_flag(picker_unit)
	local picker_player = Managers.player:owner(picker_unit)

	if not picker_player.team then
		return false
	end

	local picker_team_side = picker_player.team.side

	return self._active[picker_team_side]
end

function GrailSpawnPointClient:can_plant_flag(planter_unit)
	return false
end

function GrailSpawnPointClient:set_active(team, active)
	GrailSpawnPointClient.super.set_active(self, team, active)

	if active then
		Unit.flow_event(self._unit, "lua_activated_on_client_" .. team)
	else
		Unit.flow_event(self._unit, "lua_deactivated_on_client_" .. team)
	end
end

function GrailSpawnPointClient:destroy()
	return
end
