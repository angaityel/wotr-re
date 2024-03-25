-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_bandaging_teammate.lua

require("scripts/unit_extensions/human/base/states/human_interacting")

PlayerBandagingTeammate = class(PlayerBandagingTeammate, HumanInteracting)

local BUTTON_THRESHOLD = 0.5

function PlayerBandagingTeammate:init(unit, internal, world)
	PlayerBandagingTeammate.super.init(self, unit, internal, world, "bandage")

	self._target_unit = nil
end

function PlayerBandagingTeammate:enter(old_state, target_unit, t)
	PlayerBandagingTeammate.super.enter(self, old_state, t)

	local internal = self._internal

	self._target_unit = target_unit

	if internal.id and internal.game then
		local network_manager = Managers.state.network

		InteractionHelper:request("bandage", internal, internal.id, network_manager:game_object_id(target_unit))
	elseif not Managers.lobby.lobby then
		local damage_ext = ScriptUnit.extension(target_unit, "damage_system")
		local can_be_bandaged = damage_ext:can_be_bandaged()

		if can_be_bandaged then
			internal:bandage_interaction_confirmed()
			damage_ext:start_bandage(self._unit, target_unit)
		else
			internal:bandage_interaction_denied()
		end
	else
		internal:bandage_interaction_confirmed()
	end
end

function PlayerBandagingTeammate:update(dt, t)
	PlayerBandagingTeammate.super.update(self, dt, t)

	if self._internal.current_state ~= self then
		return
	end

	if not Unit.alive(self._target_unit) then
		self:_exit_on_fail()
		self:change_state("onground")
	end

	if self._internal.interacting and Vector3.length(Unit.world_position(self._unit, 0) - Unit.world_position(self._target_unit, 0)) > PlayerUnitMovementSettings.interaction.settings.bandage.break_distance then
		self:_exit_on_fail()
		self:change_state("onground")
	end
end

function PlayerBandagingTeammate:exit(new_state)
	PlayerBandagingTeammate.super.exit(self, new_state)

	self._target_unit = nil
end

function PlayerBandagingTeammate:_exit_on_fail()
	PlayerBandagingTeammate.super._exit_on_fail(self)

	local internal = self._internal
	local target_unit = self._target_unit

	if internal.id and internal.game then
		local network_manager = Managers.state.network

		InteractionHelper:abort("bandage", internal, internal.id, network_manager:game_object_id(target_unit))
	elseif not Managers.lobby.lobby and Unit.alive(self._target_unit) then
		local damage_ext = ScriptUnit.extension(self._target_unit, "damage_system")

		damage_ext:abort_bandage(self._unit, self._target_unit)
	end
end

function PlayerBandagingTeammate:_exit_on_complete()
	PlayerBandagingTeammate.super._exit_on_complete(self)

	local internal = self._internal
	local timpani_world = World.timpani_world(internal.world)
	local event_id = TimpaniWorld.trigger_event(timpani_world, "heal_completed")
end

function PlayerBandagingTeammate:_interact_duration()
	local internal = self._internal
	local duration_multiplier = internal:has_perk("surgeon") and Perks.surgeon.teammate_duration_multiplier or 1

	return PlayerBandagingTeammate.super._interact_duration(self) * duration_multiplier
end
