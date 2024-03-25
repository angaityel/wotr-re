-- chunkname: @scripts/unit_extensions/objectives/grail_spawn_point_server.lua

require("scripts/unit_extensions/objectives/capture_point_server_base")

GrailSpawnPointServer = class(GrailSpawnPointServer, CapturePointServerBase)

local DROPPED_GRAIL_LIFETIME = 15

function GrailSpawnPointServer:init(world, unit)
	GrailSpawnPointServer.super.init(self, world, unit)
end

function GrailSpawnPointServer:can_spawn_flag(picker_unit)
	local picker_player = Managers.player:owner(picker_unit)
	local picker_team_side = picker_player.team.side

	return self._active[picker_team_side]
end

function GrailSpawnPointServer:spawn_flag(picker_unit)
	local picker_player = Managers.player:owner(picker_unit)
	local picker_team_name = picker_player.team.name
	local grail_unit_name = "units/gamemode/grail_pickup"
	local grail_unit = World.spawn_unit(self._world, grail_unit_name, Unit.world_position(self._unit, 0), Unit.world_rotation(self._unit, 0))

	Managers.state.entity:register_unit(self._world, grail_unit, picker_team_name, DROPPED_GRAIL_LIFETIME, self)
	Unit.flow_event(self._unit, "lua_grail_picked")

	return grail_unit
end

function GrailSpawnPointServer:grail_drop_time_out()
	Unit.flow_event(self._unit, "lua_grail_drop_time_out")
end

function GrailSpawnPointServer:update(unit, input, dt, context)
	return
end

function GrailSpawnPointServer:can_plant_flag(planter_unit)
	return false
end
