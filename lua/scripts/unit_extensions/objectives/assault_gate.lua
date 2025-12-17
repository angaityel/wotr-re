-- chunkname: @scripts/unit_extensions/objectives/assault_gate.lua

require("scripts/unit_extensions/objectives/objective_unit_interactable")

AssaultGate = class(AssaultGate, ObjectiveUnitInteractable)
AssaultGate.SYSTEM = "objective_system"
GATE_DELAY = 4

function AssaultGate:init(world, unit, input)
	AssaultGate.super.init(self, world, unit, input)

	self._state = "closed"
	self._perma_open = false
	self._close_timer = Unit.get_data(self._unit, "unattended_open_time")
	self._nearby_defenders = {}
	self._destructible_active = {}
	self._blackboard.active_team_sides_destructible = {}
	self._blackboard.destructible_enabled = true
	self._interaction_timer = nil
	self._level_key = Managers.state.game_mode:level_key()
end

function AssaultGate:event_start_round()
	AssaultGate.super.event_start_round(self)

	for _, side in pairs(Managers.state.team:sides()) do
		self._destructible_active[side] = false
	end
end

function AssaultGate:update(unit, input, dt, context, t)
	GenericUnitInteractable.update(self, unit, input, dt, context, t)
end

function AssaultGate:_create_game_object()
	local data_table = {
		game_object_created_func = NetworkLookup.game_object_functions.cb_generic_unit_interactable_created,
		object_destroy_func = NetworkLookup.game_object_functions.cb_generic_unit_interactable_destroyed,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		level_unit_index = Unit.get_data(self._unit, "level_unit_index"),
		interactor = self._interactor,
		owner = NetworkLookup.team[self._owner]
	}

	for side, active in pairs(self._active) do
		data_table[side .. "_active"] = active
	end

	for side, active in pairs(self._destructible_active) do
		data_table[side .. "_destructible"] = active
	end

	local callback = callback(self, "cb_game_session_disconnect")

	self._game_object_id = Managers.state.network:create_game_object("generic_unit_interactable", data_table, callback)
	self._game = Managers.state.network:game()
end

function AssaultGate:enable_destructible(enable)
	self._blackboard.destructible_enabled = enable
end

function AssaultGate:_server_update(t, dt)
	if self._perma_open == false and self._state == "open" then
		local num_nearby_defenders = table.size(self._nearby_defenders)

		if num_nearby_defenders == 0 or self._level_key == "town_02" then
			self._close_timer = self._close_timer - dt

			if self._close_timer <= 0 then
				self._interacting_player = nil

				self:close_gate(GATE_DELAY)
			end
		else
			self._close_timer = Unit.get_data(self._unit, "unattended_open_time")
		end
	end
end

function AssaultGate:_client_update(t, dt)
	ObjectiveUnitInteractable._client_update(self, t, dt)

	for side, active in pairs(self._destructible_active) do
		local server_active = GameSession.game_object_field(self._game, self._game_object_id, side .. "_destructible")

		self:destructible_objective_activated(side, server_active)
	end
end

function AssaultGate:interaction_complete(player)
	local interacting_unit = Managers.state.network:game_object_unit(self._interactor)

	self._interacting_player = Managers.player:owner(interacting_unit)
end

function AssaultGate:flow_cb_add_player_unit(player_unit)
	local player = Managers.player:owner(player_unit)

	if player.team.side == "defenders" then
		self._nearby_defenders[player_unit] = player_unit
	end
end

function AssaultGate:flow_cb_remove_player_unit(player_unit)
	self._nearby_defenders[player_unit] = nil
end

function AssaultGate:can_interact(player)
	return (not self._interaction_timer or self._interaction_timer < Managers.time:time("game")) and not self._perma_open
end

function AssaultGate:interact_gate()
	if Managers.lobby.server then
		if self._state == "closed" then
			self:open_gate(GATE_DELAY)
		else
			self:close_gate(GATE_DELAY)
		end
	else
		Managers.state.network:send_rpc_server("rpc_interact_assault_gate", self._game_object_id)
	end
end

function AssaultGate:open_gate(interaction_timer)
	Unit.flow_event(self._unit, "open_gate")

	if Managers.lobby.server then
		self._state = "open"
		self._close_timer = Unit.get_data(self._unit, "unattended_open_time")

		Managers.state.network:send_rpc_clients("rpc_open_assault_gate", self._game_object_id, interaction_timer)
	else
		Unit.set_data(self._unit, "interacts", "trigger", "close_gate")
	end

	self._interaction_timer = Managers.time:time("game") + interaction_timer
end

function AssaultGate:close_gate(interaction_timer)
	if Managers.lobby.server then
		self._state = "closed"

		Managers.state.network:send_rpc_clients("rpc_close_assault_gate", self._game_object_id, interaction_timer)
		Unit.flow_event(self._unit, "close_gate_server")
	else
		Unit.flow_event(self._unit, "close_gate")
		Unit.set_data(self._unit, "interacts", "trigger", "open_gate")
	end

	self._interaction_timer = Managers.time:time("game") + interaction_timer
end

function AssaultGate:perma_open_gate()
	self._perma_open = true

	self:open_gate(GATE_DELAY)
end

function AssaultGate:crush_player_unit(player_unit)
	if Unit.alive(player_unit) and ScriptUnit.has_extension(player_unit, "damage_system") then
		local extension = ScriptUnit.extension(player_unit, "damage_system")

		if extension:is_alive() then
			extension:die(self._interacting_player, nil, nil, "crush")
		end
	end
end

function AssaultGate:hot_join_synch(sender)
	local unit = self._unit

	if not ScriptUnit.has_extension(unit, "damage_system") or not ScriptUnit.extension(unit, "damage_system"):is_dead() then
		RPC.rpc_synch_assault_gate(sender, self._game_object_id, NetworkLookup.gate_states[self._state])
	end
end

function AssaultGate:rpc_synch_assault_gate(gate_state)
	Unit.flow_event(self._unit, "set_" .. gate_state)
	Unit.set_data(self._unit, "interacts", "trigger", gate_state == "open" and "close_gate" or "open_gate")
end

function AssaultGate:destructible_objective_activated(team_side, active)
	local no_active_before = true
	local no_active_after = true

	self._blackboard.active_team_sides_destructible[team_side] = active

	for _, team_side in pairs(Managers.state.team:sides()) do
		if self._blackboard.active_team_sides[team_side] or self._blackboard.active_team_sides_destructible[team_side] then
			no_active_after = false
		end

		if self._active[team_side] or self._destructible_active[team_side] then
			no_active_before = false
		end
	end

	self._destructible_active[team_side] = active

	if active and no_active_before and not self:is_dead() then
		Managers.state.event:trigger("objective_activated", self._blackboard, self._unit)
	elseif not active and no_active_after then
		Managers.state.event:trigger("objective_deactivated", self._unit)
	end

	if self._game and self._game_object_id and Managers.lobby.server then
		GameSession.set_game_object_field(self._game, self._game_object_id, team_side .. "_destructible", self._destructible_active[team_side])
	end
end

function AssaultGate:is_dead()
	if not ScriptUnit.has_extension(self._unit, "damage_system") then
		return false
	else
		return ScriptUnit.extension(self._unit, "damage_system"):is_dead()
	end
end

function AssaultGate:_objective_activated(team_side, active)
	local no_active_before = true
	local no_active_after = true

	self._blackboard.active_team_sides[team_side] = active

	for _, team_side in pairs(Managers.state.team:sides()) do
		if self._blackboard.active_team_sides[team_side] or self._blackboard.active_team_sides_destructible[team_side] then
			no_active_after = false
		end

		if self._active[team_side] or self._destructible_active[team_side] then
			no_active_before = false
		end
	end

	if active and no_active_before and not self:is_dead() then
		Managers.state.event:trigger("objective_activated", self._blackboard, self._unit)
	elseif not active and no_active_after then
		Managers.state.event:trigger("objective_deactivated", self._unit)
	end

	if self._game and self._game_object_id and Managers.lobby.server then
		GameSession.set_game_object_field(self._game, self._game_object_id, team_side .. "_destructible", self._destructible_active[team_side])
	end
end

function AssaultGate:destructible_active(team_side)
	if Managers.lobby.server then
		return self._destructible_active[team_side]
	elseif self._game and self._game_object_id then
		return GameSession.game_object_field(self._game, self._game_object_id, team_side .. "_destructible")
	else
		return self._destructible_active[team_side]
	end
end
