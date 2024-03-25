-- chunkname: @scripts/unit_extensions/generic/generic_unit_interactable.lua

GenericUnitInteractable = class(GenericUnitInteractable)
GenericUnitInteractable.SYSTEM = "objective_system"

function GenericUnitInteractable:init(world, unit, input)
	self._world = world
	self._unit = unit
	self._active = {}
	self._interactor = 0

	local current_level = LevelHelper:current_level(self._world)
	local level_unit_index = Level.unit_index(current_level, unit)

	Unit.set_data(unit, "level_unit_index", level_unit_index)
	Managers.state.event:register(self, "event_start_round", "event_start_round", "event_round_started", "event_round_started")
end

function GenericUnitInteractable:event_start_round()
	for _, side in pairs(Managers.state.team:sides()) do
		self._active[side] = false
	end
end

function GenericUnitInteractable:event_round_started()
	if Managers.lobby.server and Managers.state.network:game() then
		self:_create_game_object()
	end
end

function GenericUnitInteractable:_create_game_object()
	local data_table = {
		game_object_created_func = NetworkLookup.game_object_functions.cb_generic_unit_interactable_created,
		object_destroy_func = NetworkLookup.game_object_functions.cb_generic_unit_interactable_destroyed,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		level_unit_index = Unit.get_data(self._unit, "level_unit_index"),
		interactor = self._interactor
	}

	for side, active in pairs(self._active) do
		data_table[side .. "_active"] = active
		data_table[side .. "_destructible"] = false
	end

	local callback = callback(self, "cb_game_session_disconnect")

	self._game_object_id = Managers.state.network:create_game_object("generic_unit_interactable", data_table, callback)
	self._game = Managers.state.network:game()
end

function GenericUnitInteractable:cb_game_session_disconnect()
	self._frozen = true

	self:remove_game_object_id()
end

function GenericUnitInteractable:flow_cb_activate_interactable(side)
	self._active[side] = true

	if self._game_object_id then
		GameSession.set_game_object_field(self._game, self._game_object_id, side .. "_active", true)
	end
end

function GenericUnitInteractable:flow_cb_deactivate_interactable(side)
	self._active[side] = false

	if self._game_object_id then
		GameSession.set_game_object_field(self._game, self._game_object_id, side .. "_active", false)
	end
end

function GenericUnitInteractable:active(side)
	return self._active[side]
end

function GenericUnitInteractable:interactor()
	if self._interactor == 0 then
		return nil
	else
		return self._interactor
	end
end

function GenericUnitInteractable:can_interact(player)
	return true
end

function GenericUnitInteractable:interaction_complete(player)
	return
end

function GenericUnitInteractable:set_interactor(player_unit_id)
	if player_unit_id == nil then
		self._interactor = 0
	else
		self._interactor = player_unit_id
	end

	if Managers.state.network:game() then
		GameSession.set_game_object_field(self._game, self._game_object_id, "interactor", self._interactor)
	end
end

function GenericUnitInteractable:set_game_object_id(game_object_id, game)
	self._game_object_id = game_object_id
	self._game = game
end

function GenericUnitInteractable:remove_game_object_id()
	self._game_object_id = nil
	self._game = nil
end

function GenericUnitInteractable:set_dead()
	self._dead = true
end

function GenericUnitInteractable:update(unit, input, dt, context, t)
	if self._dead then
		return
	end

	if Managers.lobby.server then
		self:_server_update(t, dt)
	elseif Managers.lobby.lobby and self._game then
		self:_client_update(t, dt)
	else
		self:_local_update(t, dt)
	end
end

function GenericUnitInteractable:_server_update(t, dt)
	return
end

function GenericUnitInteractable:_client_update(t, dt)
	for _, side in pairs(Managers.state.team:sides()) do
		local active_before = self._active[side]
		local active = GameSession.game_object_field(self._game, self._game_object_id, side .. "_active")

		if active ~= active_before then
			self:_on_client_active_changed(side, active)
		end

		self._active[side] = active
	end

	self._interactor = GameSession.game_object_field(self._game, self._game_object_id, "interactor")
end

function GenericUnitInteractable:level_index()
	return Unit.get_data(self._unit, "level_unit_index")
end

function GenericUnitInteractable:active(side)
	return self._active[side]
end

function GenericUnitInteractable:_on_client_active_changed(team_side, active)
	return
end

function GenericUnitInteractable:_local_update(t, dt)
	return
end

function GenericUnitInteractable:destroy()
	return
end
