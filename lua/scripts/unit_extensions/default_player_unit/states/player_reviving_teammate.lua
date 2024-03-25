-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_reviving_teammate.lua

require("scripts/unit_extensions/human/base/states/human_reviving_teammate")

PlayerRevivingTeammate = class(PlayerRevivingTeammate, HumanRevivingTeammate)

function PlayerRevivingTeammate:enter(old_state, target_unit, t)
	PlayerRevivingTeammate.super.enter(self, old_state, target_unit, t)

	local internal = self._internal
	local network_manager = Managers.state.network

	InteractionHelper:request("revive", internal, internal.id, network_manager:game_object_id(target_unit))
end

function PlayerRevivingTeammate:_exit_on_fail()
	PlayerRevivingTeammate.super._exit_on_fail(self)

	local internal = self._internal
	local network_manager = Managers.state.network

	if not Unit.alive(self._target_unit) then
		return
	end

	local target_id = network_manager:game_object_id(self._target_unit)

	if not target_id then
		return
	end

	InteractionHelper:abort("revive", internal, internal.id, target_id)
end

function PlayerRevivingTeammate:_exit_on_complete()
	PlayerRevivingTeammate.super._exit_on_complete(self)

	if Unit.alive(self._target_unit) then
		Managers.state.event:trigger("completed_revive", self._target_unit)
	end
end

function PlayerRevivingTeammate:_interact_duration()
	local internal = self._internal
	local revive_duration_multiplier = internal:has_perk("barber_surgeon") and Perks.barber_surgeon.revive_duration_multiplier or 1
	local target_locomotion = ScriptUnit.extension(self._target_unit, "locomotion_system")

	revive_duration_multiplier = target_locomotion:has_perk("hardened") and Perks.hardened.revive_duration_multiplier * revive_duration_multiplier or revive_duration_multiplier

	return PlayerRevivingTeammate.super._interact_duration(self) * revive_duration_multiplier
end
