-- chunkname: @scripts/unit_extensions/flag/flag_offline.lua

FlagOffline = class(FlagOffline, FlagServer)
FlagOffline.SERVER_ONLY = false
FlagOffline.OFFLINE_ONLY = true

function FlagOffline:init(world, unit, team_name, lifetime_on_drop)
	self._world = world
	self._unit = unit
	self._team_name = team_name
	self._lifetime_on_drop = lifetime_on_drop
	self._kill_time = nil
	self._carried = false
	self._carrier_unit = nil

	Unit.set_data(unit, "team_name", team_name)
end
