-- chunkname: @scripts/managers/broken_gear/broken_gear_manager.lua

BrokenGearManager = class(BrokenGearManager)

local MAX_BROKEN_GEAR = 30

function BrokenGearManager:init(world)
	self._world = world
	self._max_broken_gear = Application.user_setting("max_broken_gear") or MAX_BROKEN_GEAR
	self._active_index = 1
	self._broken_gear = {}
end

function BrokenGearManager:register_gear(gear_unit)
	self._active_index = self._active_index % self._max_broken_gear + 1

	local unit = self._broken_gear[self._active_index]

	if unit then
		World.destroy_unit(self._world, unit)
	end

	self._broken_gear[self._active_index] = gear_unit
end
