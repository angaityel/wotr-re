-- chunkname: @scripts/unit_extensions/human/ai_player_unit/ai_brain.lua

require("scripts/entity_system/systems/behaviour/behaviour_tree")
require("scripts/entity_system/systems/behaviour/behaviour_trees")

AIBrain = class(AIBrain)

function AIBrain:init(world, unit, blackboard, profile)
	self._unit = unit
	self._blackboard = blackboard
	self._profile = profile
	self._behaviours = {}

	self:_init_behaviours()
end

function AIBrain:_init_behaviours()
	for _, behaviour_slot in ipairs(self._profile.brain.behaviours) do
		local slot_name, behaviour_name = next(behaviour_slot)

		self:_register_behaviour(slot_name, behaviour_name)
	end
end

function AIBrain:_register_behaviour(slot_name, behaviour_name)
	fassert(not self:has_behaviour(slot_name), "Slot %q already contains behaviour %q", slot_name, behaviour_name)

	local index = #self._behaviours + 1

	self._behaviours[index] = self:_create_behaviour(behaviour_name)
	self._behaviours[slot_name] = index
end

function AIBrain:_create_behaviour(behaviour_name)
	local tree = BehaviourTreeDefinitions[behaviour_name]

	fassert(tree, "Behaviour tree %q doesn't exist", behaviour_name)

	local behaviour = BehaviourTree:new(behaviour_name, tree)

	behaviour:setup(self._unit, self._blackboard, self._profile)

	return behaviour
end

function AIBrain:set_behaviours(...)
	table.clear(self._behaviours)

	for i = 1, select("#", ...), 2 do
		local slot_name = select(i, ...)
		local behaviour_name = select(i + 1, ...)

		self:_register_behaviour(slot_name, behaviour_name)
	end
end

function AIBrain:change_behaviour(slot_name, behaviour_name)
	fassert(self:has_behaviour(slot_name), "Slot %q doesn't exist", slot_name)

	local index = self._behaviours[slot_name]

	self._behaviours[index] = self:_create_behaviour(behaviour_name)
end

function AIBrain:has_behaviour(slot_name)
	return self._behaviours[slot_name] ~= nil
end

function AIBrain:update(t, dt)
	Profiler.start("AIBrain")

	for _, behaviour in ipairs(self._behaviours) do
		behaviour:run(self._unit, self._blackboard, t, dt)
	end

	Profiler.stop()
end
