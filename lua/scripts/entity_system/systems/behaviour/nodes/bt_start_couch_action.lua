-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_start_couch_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTStartCouchAction = class(BTStartCouchAction, BTNode)

function BTStartCouchAction:init(...)
	BTStartCouchAction.super.init(self, ...)
end

function BTStartCouchAction:run(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local target_player = blackboard[self._input]

	if not locomotion.couching then
		local look_target = Unit.world_position(target_player, Unit.node(target_player, "Neck"))

		locomotion:set_look_target(look_target)
		locomotion:begin_couch(t, target_player)
	end

	return locomotion.couching
end
