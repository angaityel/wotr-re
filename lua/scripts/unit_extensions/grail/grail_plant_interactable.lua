-- chunkname: @scripts/unit_extensions/grail/grail_plant_interactable.lua

require("scripts/unit_extensions/generic/generic_unit_interactable")

GrailPlantInteractable = class(GrailPlantInteractable, GenericUnitInteractable)
GrailPlantInteractable.SYSTEM = "objective_system"

function GrailPlantInteractable:init(world, unit, input)
	GrailPlantInteractable.super.init(self, world, unit, input)

	self._blackboard = {
		color = {
			255,
			255,
			255,
			0
		},
		active_team_sides = {}
	}
end

function GrailPlantInteractable:can_interact(player)
	local locomotion_ext = ScriptUnit.extension(player.player_unit, "locomotion_system")

	return locomotion_ext.carried_flag and true or false
end

function GrailPlantInteractable:interaction_complete(player)
	if Managers.lobby.server then
		local locomotion_ext = ScriptUnit.extension(player.player_unit, "locomotion_system")
		local grail_ext = ScriptUnit.extension(locomotion_ext.carried_flag, "flag_system")

		grail_ext:despawn_on_plant()
		Unit.flow_event(self._unit, "lua_grail_planted_" .. player.team.side)
		Managers.state.event:trigger("flag_planted", player, self._unit)
	end

	local locomotion_ext = ScriptUnit.extension(player.player_unit, "locomotion_system")

	locomotion_ext.carried_flag = nil
end

function GrailPlantInteractable:flow_cb_activate_interactable(team_side)
	self:_objective_activated(team_side, true)
	GrailPlantInteractable.super.flow_cb_activate_interactable(self, team_side)
end

function GrailPlantInteractable:flow_cb_deactivate_interactable(team_side)
	self:_objective_activated(team_side, false)
	GrailPlantInteractable.super.flow_cb_deactivate_interactable(self, team_side)
end

function GrailPlantInteractable:_on_client_active_changed(team_side, active)
	self:_objective_activated(team_side, active)
end

function GrailPlantInteractable:_objective_activated(team_side, active)
	local no_active_before = true
	local no_active_after = true

	self._blackboard.active_team_sides[team_side] = active

	for _, team_side in pairs(Managers.state.team:sides()) do
		if self._blackboard.active_team_sides[team_side] then
			no_active_after = false
		end

		if self._active[team_side] then
			no_active_before = false
		end
	end

	if active and no_active_before then
		Managers.state.event:trigger("objective_activated", self._blackboard, self._unit)
	elseif not active and no_active_after then
		Managers.state.event:trigger("objective_deactivated", self._unit)
	end
end
