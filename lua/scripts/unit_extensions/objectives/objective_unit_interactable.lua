-- chunkname: @scripts/unit_extensions/objectives/objective_unit_interactable.lua

require("scripts/unit_extensions/generic/generic_unit_interactable")

local OBJECTIVE_CAPTURE_ASSIST_RADIUS = 15

ObjectiveUnitInteractable = class(ObjectiveUnitInteractable, GenericUnitInteractable)
ObjectiveUnitInteractable.SYSTEM = "objective_system"

function ObjectiveUnitInteractable:init(world, unit, input)
	ObjectiveUnitInteractable.super.init(self, world, unit, input)

	self._blackboard = {
		owner_team_side = "neutral",
		active_team_sides = {}
	}

	self:_set_owner("neutral")
end

function ObjectiveUnitInteractable:can_interact(player)
	if player.team and self._active[player.team.side] and player.team.side ~= self._owner then
		return true
	end
end

function ObjectiveUnitInteractable:objective(side)
	local unit = self._unit

	return Unit.get_data(unit, "hud", "objective", side, "name"), Unit.get_data(unit, "hud", "objective", side, "priority")
end

function ObjectiveUnitInteractable:set_dead()
	self._dead = true

	Managers.state.event:trigger("objective_deactivated", self._unit)
end

function ObjectiveUnitInteractable:_create_game_object()
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
		data_table[side .. "_destructible"] = false
	end

	local callback = callback(self, "cb_game_session_disconnect")

	self._game_object_id = Managers.state.network:create_game_object("generic_unit_interactable", data_table, callback)
	self._game = Managers.state.network:game()
end

function ObjectiveUnitInteractable:flow_cb_set_owner(side)
	self:_set_owner(side)

	if self._game_object_id then
		GameSession.set_game_object_field(self._game, self._game_object_id, "owner", NetworkLookup.team[side])
	end
end

function ObjectiveUnitInteractable:_set_owner(owner)
	self._owner = owner

	Unit.set_data(self._unit, "side", owner)

	self._blackboard.owner_team_side = owner

	local team = Managers.state.team:team_by_side(owner)
	local team_name

	if team then
		team_name = team.name
	else
		team_name = "neutral"
	end

	Unit.flow_event(self._unit, "lua_set_team_name_" .. team_name)
end

function ObjectiveUnitInteractable:_client_update(t, dt)
	ObjectiveUnitInteractable.super._client_update(self, t, dt)

	local owner = NetworkLookup.team[GameSession.game_object_field(self._game, self._game_object_id, "owner")]

	if owner ~= self._owner then
		self:_set_owner(owner)
	end
end

function ObjectiveUnitInteractable:interaction_complete(player)
	if Managers.lobby.server then
		if not self:can_interact(player) then
			return
		end

		Managers.state.event:trigger("objective_captured", player, self._unit)

		local physics_world = World.physics_world(self._world)
		local callback = callback(self, "cb_capture_assists", player, self._unit)
		local unit_pos = Unit.world_position(self._unit, 0)

		PhysicsWorld.overlap(physics_world, callback, "position", unit_pos, "size", OBJECTIVE_CAPTURE_ASSIST_RADIUS, "types", "dynamics", "collision_filter", "player_scan")
	end
end

function ObjectiveUnitInteractable:cb_capture_assists(capturing_player, capture_unit, actors)
	local capturing_player_unit = capturing_player.player_unit

	for _, actor in pairs(actors) do
		local player_unit = Actor.unit(actor)

		if player_unit ~= capturing_player_unit and Managers.state.team:is_on_same_team(capturing_player_unit, player_unit) then
			local player = Managers.player:owner(player_unit)

			Managers.state.event:trigger("objective_captured_assist", player, capture_unit)
		end
	end
end

function ObjectiveUnitInteractable:flow_cb_activate_interactable(team_side)
	self:_objective_activated(team_side, true)
	ObjectiveUnitInteractable.super.flow_cb_activate_interactable(self, team_side)
end

function ObjectiveUnitInteractable:flow_cb_deactivate_interactable(team_side)
	self:_objective_activated(team_side, false)
	ObjectiveUnitInteractable.super.flow_cb_deactivate_interactable(self, team_side)
end

function ObjectiveUnitInteractable:owned(side)
	return self._owner == side
end

function ObjectiveUnitInteractable:_on_client_active_changed(team_side, active)
	self:_objective_activated(team_side, active)
end

function ObjectiveUnitInteractable:_objective_activated(team_side, active)
	if self._dead then
		return
	end

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

	if active and no_active_before and not self._dead then
		Managers.state.event:trigger("objective_activated", self._blackboard, self._unit)
	elseif not active and no_active_after then
		Managers.state.event:trigger("objective_deactivated", self._unit)
	end
end
