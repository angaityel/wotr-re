-- chunkname: @scripts/unit_extensions/human/ai_player_unit/states/ai_reviving_teammate.lua

require("scripts/unit_extensions/human/base/states/human_reviving_teammate")

AIRevivingTeammate = class(AIRevivingTeammate, HumanRevivingTeammate)

function AIRevivingTeammate:enter(old_state, target_unit, t)
	AIRevivingTeammate.super.enter(self, old_state, target_unit, t)

	local internal = self._internal
	local damage_ext = ScriptUnit.extension(target_unit, "damage_system")

	damage_ext:start_revive(self._unit, internal.player.index)

	self._interaction_confirmed = true
end

function AIRevivingTeammate:_exit_on_fail()
	AIRevivingTeammate.super._exit_on_fail(self)

	local damage_ext = ScriptUnit.extension(self._target_unit, "damage_system")

	damage_ext:abort_revive(self._unit, self._target_unit)
end

function AIRevivingTeammate:update(dt, t)
	self._player.state_data.interaction_progress = self._complete_time - t

	if t > self._complete_time and self._internal.interacting and self._interaction_confirmed then
		self:_exit_on_complete()
	elseif t > self._complete_time and self._interaction_confirmed then
		self:change_state("onground")
	end
end
