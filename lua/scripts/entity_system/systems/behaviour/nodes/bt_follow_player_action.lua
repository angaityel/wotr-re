-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_follow_player_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTFollowPlayerAction = class(BTFollowPlayerAction, BTNode)

local settings = AISettings.behaviour

function BTFollowPlayerAction:init(...)
	BTFollowPlayerAction.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)

	self._data = self._data or {}
end

function BTFollowPlayerAction:setup(unit, blackboard, profile)
	self._aim_node_name = self._data.aim_node or "Neck"
end

function BTFollowPlayerAction:run(unit, blackboard, t, dt)
	local unit_pos = Unit.local_position(unit, 0)
	local target_player = blackboard[self._input]
	local target_player_pos = Unit.local_position(target_player, 0)
	local offset_to_player = unit_pos - target_player_pos
	local distance = Vector3.length(offset_to_player)

	if offset_to_player.z <= settings.height_avoid_distance then
		local ai_base = ScriptUnit.extension(unit, "ai_system")
		local keep_distance = ai_base:locomotion():inventory():optimal_weapon_distance()
		local target_pos = target_player_pos + keep_distance * Vector3.normalize(offset_to_player)

		ai_base:blackboard().move_to = true

		ai_base:navigation():move_to(target_pos)
	end
end
