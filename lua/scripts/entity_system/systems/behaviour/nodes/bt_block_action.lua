-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_block_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTBlockAction = class(BTBlockAction, BTNode)

function BTBlockAction:init(...)
	BTBlockAction.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTBlockAction:setup(unit, blackboard, profile)
	self._ai_props = profile.properties
	self._block_directions = {
		"up",
		"down",
		"left",
		"right"
	}
end

function BTBlockAction:run(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local target_unit = blackboard[self._input]
	local target_locomotion = ScriptUnit.extension(target_unit, "locomotion_system")
	local incoming_attack_direction = target_locomotion.swing_direction or target_locomotion.pose_direction

	if not locomotion.block_or_parry then
		local block_direction = self:_calculate_block_direction(incoming_attack_direction)

		locomotion:block_attack(block_direction, target_locomotion)
	end

	return locomotion.blocking or locomotion.parrying
end

function BTBlockAction:_calculate_block_direction(incoming_attack_direction)
	local rand = math.random()

	if rand <= self._ai_props.block_chance then
		return incoming_attack_direction
	end

	while true do
		local rand = math.random(1, #self._block_directions)

		if self._block_directions[rand] ~= incoming_attack_direction then
			return self._block_directions[rand]
		end
	end
end
