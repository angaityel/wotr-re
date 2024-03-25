-- chunkname: @scripts/managers/group/formations/skirmish_formation.lua

SkirmishFormation = class(SkirmishFormation)

function SkirmishFormation:init()
	self._num_slots = 0
	self._offsets = {}
end

function SkirmishFormation:request_slot()
	return
end

function SkirmishFormation:relinquish_slot(slot)
	return
end
