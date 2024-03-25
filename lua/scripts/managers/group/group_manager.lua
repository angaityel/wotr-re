-- chunkname: @scripts/managers/group/group_manager.lua

require("scripts/managers/group/group")
require("scripts/managers/group/formations/block_formation")
require("scripts/managers/group/formations/skirmish_formation")
require("scripts/managers/group/formations/staggered_formation")

GroupManager = class(GroupManager)

function GroupManager:init(world)
	self._world = world
	self._groups = {}

	Managers.state.event:register(self, "create_group", "flow_cb_create_group")
	Managers.state.event:register(self, "ai_move_group", "flow_cb_ai_move_group")
end

function GroupManager:flow_cb_create_group(player_name, group_name, formation_definition)
	fassert(player_name, "Player name can't be nil")
	fassert(group_name, "Group name can't be nil")

	local formation_name = formation_definition:match("(%a+)")
	local formation_class = rawget(_G, formation_name)

	fassert(formation_class, "Formation %q does not exist", formation_name)

	local formation = formation_class.create_from_string(formation_definition)

	self:create(player_name, group_name, formation)
end

function GroupManager:flow_cb_ai_move_group(player_name, group_name, target_unit, on_arrived_event_name)
	fassert(player_name, "Player name can't be nil")
	fassert(group_name, "Group name can't be nil")

	local target_pos = Unit.world_position(target_unit, 0)
	local group = self:group(player_name, group_name)

	group:navigation():move_to(target_pos, on_arrived_event_name)
end

function GroupManager:create(player_index, name, formation, pos, rot)
	fassert(not self:exists(player_index, name), "Player %q already has a group with name %q", player_index, name)

	local group = Group:new(self._world, formation, pos, rot)

	self._groups[player_index] = self._groups[player_index] or {}
	self._groups[player_index][name] = group

	return group
end

function GroupManager:exists(player_index, name)
	local groups = self._groups[player_index]

	if groups then
		return groups[name] ~= nil
	end

	return false
end

function GroupManager:group(player_index, name)
	fassert(self:exists(player_index, name), "Player %q doesn't have any group with name %q", player_index, name)

	return self._groups[player_index][name]
end

function GroupManager:update(dt, t)
	for _, groups in pairs(self._groups) do
		for _, group in pairs(groups) do
			group:update(dt, t)
		end
	end
end
