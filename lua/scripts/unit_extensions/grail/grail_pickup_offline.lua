-- chunkname: @scripts/unit_extensions/grail/grail_pickup_offline.lua

GrailPickupOffline = class(GrailPickupOffline, GrailPickupServer)
GrailPickupOffline.SERVER_ONLY = false
GrailPickupOffline.OFFLINE_ONLY = true

function GrailPickupOffline:init(world, unit, team_name, lifetime_on_drop)
	self._world = world
	self._unit = unit
	self._team_name = team_name
	self._lifetime_on_drop = lifetime_on_drop
	self._kill_time = nil
	self._carried = false
	self._carrier_unit = nil
end
