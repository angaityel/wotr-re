-- chunkname: @scripts/unit_extensions/human/ai_player_unit/states/ai_executing.lua

require("scripts/unit_extensions/human/base/states/human_executing")

AIExecuting = class(AIExecuting, HumanExecuting)

function AIExecuting:enter(old_state, target_unit, t)
	AIExecuting.super.enter(self, old_state, target_unit, t)

	local damage_ext = ScriptUnit.extension(target_unit, "damage_system")

	damage_ext:start_execution(self._unit, self._internal.player.index)

	self._interaction_confirmed = true
end

function AIExecuting:_exit_on_fail()
	AIExecuting.super._exit_on_fail(self)

	local damage_ext = ScriptUnit.extension(self._target_unit, "damage_system")

	damage_ext:abort_execution(self._unit)
end
