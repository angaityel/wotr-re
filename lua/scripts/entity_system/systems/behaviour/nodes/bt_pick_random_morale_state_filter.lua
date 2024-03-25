-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_pick_random_morale_state_filter.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_pick_random_node_filter")

BTPickRandomMoraleStateFilter = class(BTPickRandomMoraleStateFilter, BTPickRandomNodeFilter)

function BTPickRandomMoraleStateFilter:init(...)
	BTPickRandomMoraleStateFilter.super.init(self, ...)

	self._current_morale_state = nil
end

function BTPickRandomMoraleStateFilter:_setup_weights(unit)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local morale_state = locomotion.morale_state
	local player_profile = Unit.get_data(unit, "player_profile")

	self._weights = AIProfiles[player_profile].morale.states[morale_state].state_percents
end

function BTPickRandomMoraleStateFilter:run(unit)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local morale_state = locomotion.morale_state
	local player_profile = Unit.get_data(unit, "player_profile")

	if self._current_morale_state ~= morale_state then
		self._current_morale_state = morale_state
		self._weights = AIProfiles[player_profile].morale.states[morale_state].state_percents

		table.dump(self._weights)
	end

	BTPickRandomMoraleStateFilter.super.run(self, unit)
end
