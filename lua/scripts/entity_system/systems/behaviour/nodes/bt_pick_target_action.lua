-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_pick_target_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local function distance_weight(distance, min, max, factor)
	local proportion = math.clamp((distance - min) / (max - min), 0, 1)

	return (1 - proportion) * factor
end

BTPickTargetAction = class(BTPickTargetAction, BTNode)

function BTPickTargetAction:init(...)
	BTPickTargetAction.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)

	self._data = self._data or {}
	self._players = {}
end

function BTPickTargetAction:setup(unit, blackboard, profile)
	self._data.min_distance = self._data.min_distance or 0
	self._data.max_distance = self._data.max_distance or 50
	self._data.distance_factor = self._data.distance_factor or 20
	self._data.player_factor = self._data.player_factor or 10
	self._data.sticky_factor = self._data.sticky_factor or 10
	self._data.dog_pile_factor = self._data.dog_pile_factor or -5
end

function BTPickTargetAction:run(unit, blackboard, t, dt)
	local players = blackboard[self._input]

	for player_unit, _ in pairs(players) do
		if not Managers.state.team:is_on_same_team(unit, player_unit) and not ScriptUnit.extension(player_unit, "damage_system"):is_dead() then
			local player = Managers.player:owner(player_unit)

			self._players[player_unit] = player.local_player and self._data.player_factor or 0
		end
	end

	local unit_pos = Unit.world_position(unit, 0)
	local targets = Managers.state.ai_resource:blackboard("targets")

	for player_unit, current_weight in pairs(self._players) do
		local player_unit_pos = Unit.world_position(player_unit, 0)
		local distance = Vector3.distance(unit_pos, player_unit_pos)
		local distance_weight = distance_weight(distance, self._data.min_distance, self._data.max_distance, self._data.distance_factor)
		local dog_pile_weight = (targets[player_unit] or 0) * self._data.dog_pile_factor

		self._players[player_unit] = current_weight + distance_weight + dog_pile_weight
	end

	local target_player = blackboard[self._output]

	if target_player and self._players[target_player] then
		self._players[target_player] = self._players[target_player] + self._data.sticky_factor
	end

	local target_player = table.max(self._players)

	if target_player then
		targets[target_player] = (targets[target_player] or 0) + 1
		blackboard[self._output] = target_player
	end

	table.clear(self._players)
end
