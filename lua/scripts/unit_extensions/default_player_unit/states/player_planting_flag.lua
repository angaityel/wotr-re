-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_planting_flag.lua

require("scripts/unit_extensions/human/base/states/human_interacting")

PlayerPlantingFlag = class(PlayerPlantingFlag, HumanInteracting)

local BUTTON_THRESHOLD = 0.5

function PlayerPlantingFlag:init(unit, internal, world)
	PlayerPlantingFlag.super.init(self, unit, internal, world, "flag_plant")

	self._capture_point_unit = nil
end

function PlayerPlantingFlag:enter(old_state, capture_point_unit, t)
	PlayerPlantingFlag.super.enter(self, old_state, t)

	local internal = self._internal
	local level = LevelHelper:current_level(internal.world)

	self._capture_point_unit = capture_point_unit

	if internal.id and internal.game then
		local capture_point_unit_index = Level.unit_index(level, capture_point_unit)

		Managers.state.network:send_rpc_server("rpc_request_flag_plant", internal.id, Unit.get_data(internal.carried_flag, "game_object_id"), capture_point_unit_index)
	elseif not Managers.lobby.lobby then
		local objective_ext = ScriptUnit.extension(capture_point_unit, "objective_system")
		local flag_ext = ScriptUnit.extension(internal.carried_flag, "flag_system")
		local planter_unit = self._unit

		objective_ext:set_current_planter(planter_unit)

		self._interaction_confirmed = true
	end

	internal.planting_flag = true
end

function PlayerPlantingFlag:exit(new_state)
	PlayerPlantingFlag.super.exit(self, new_state)

	self._capture_point_unit = nil
end

function PlayerPlantingFlag:_exit_on_fail()
	PlayerPlantingFlag.super._exit_on_fail(self)

	local internal = self._internal
	local objective_unit = self._capture_point_unit

	if internal.id and internal.game then
		local level = LevelHelper:current_level(internal.world)
		local capture_point_unit_index = Level.unit_index(level, objective_unit)

		Managers.state.network:send_rpc_server("rpc_flag_plant_fail", internal.id, capture_point_unit_index)
	elseif not Managers.lobby.lobby then
		local objective_ext = ScriptUnit.extension(objective_unit, "objective_system")

		objective_ext:set_current_planter(nil)
	end

	internal.planting_flag = false
end

function PlayerPlantingFlag:_exit_on_complete()
	PlayerPlantingFlag.super._exit_on_complete(self)

	local internal = self._internal
	local level = LevelHelper:current_level(internal.world)
	local capture_point_unit = self._capture_point_unit

	if internal.id and internal.game then
		local capture_point_unit_index = Level.unit_index(level, capture_point_unit)

		Managers.state.network:send_rpc_server("rpc_flag_plant_complete", internal.id, Unit.get_data(internal.carried_flag, "game_object_id"), capture_point_unit_index)
	else
		local objective_ext = ScriptUnit.extension(capture_point_unit, "objective_system")

		objective_ext:plant_flag(self._unit)

		local flag_ext = ScriptUnit.extension(internal.carried_flag, "flag_system")

		flag_ext:die()
	end

	internal.carried_flag = nil
	internal.planting_flag = false
end

function PlayerPlantingFlag:_interact_duration()
	local internal = self._internal
	local interact_multiplier = internal:has_perk("watchman") and Perks.watchman.interact_multiplier or 1

	return PlayerPlantingFlag.super._interact_duration(self) * interact_multiplier
end
