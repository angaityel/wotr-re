-- chunkname: @scripts/managers/group/formations/block_formation.lua

BlockFormation = class(BlockFormation)

local settings = AISettings.group.formation.block

function BlockFormation:init(ranks, files, rank_distance, file_distance)
	self._ranks = ranks
	self._files = files
	self._num_slots = ranks * files
	self._rank_distance = rank_distance or settings.default_rank_distance
	self._file_distance = file_distance or settings.default_file_distance

	self:_init_slots()
	self:_init_offsets()
	self:_calculate_offsets()
end

function BlockFormation.create_from_string(definition)
	local args = {}

	for arg in definition:gmatch("(%d+)") do
		args[#args + 1] = arg
	end

	return BlockFormation:new(unpack(args))
end

function BlockFormation:_init_slots()
	self._slots = {}

	for i = 0, self._num_slots - 1 do
		self._slots[i] = false
	end
end

function BlockFormation:_init_offsets()
	self._offsets = {}

	for i = 0, self._num_slots - 1 do
		self._offsets[i] = Vector3Box()
	end
end

function BlockFormation:_calculate_offsets()
	local mid_x = (self._files - 1) / 2
	local mid_y = (self._ranks - 1) / 2

	for slot = 0, self._num_slots - 1 do
		local slot_x = slot % self._files
		local slot_y = math.floor(slot / self._files)
		local slot_dist_x = slot_x - mid_x
		local slot_dist_y = slot_y - mid_y
		local offset = Vector3(slot_dist_x * self._rank_distance, slot_dist_y * self._file_distance, 0)

		self._offsets[slot]:store(offset)
	end
end

function BlockFormation:set_rank_distance(distance)
	self._rank_distance = distance

	self:_calculate_offsets()
end

function BlockFormation:set_file_distance(distance)
	self._file_distance = distance

	self:_calculate_offsets()
end

function BlockFormation:request_slot()
	local free_slot = -1

	for i = 0, self._num_slots - 1 do
		if self._slots[i] == false then
			free_slot = i

			break
		end
	end

	fassert(free_slot ~= -1, "Formation overflow (max slots = %d)", self._num_slots)

	self._slots[free_slot] = true

	return free_slot
end

function BlockFormation:relinquish_slot(slot)
	self._slots[slot] = false
end

function BlockFormation:offset(slot)
	return self._offsets[slot]:unbox()
end

function BlockFormation:num_slots()
	return self._num_slots
end
