-- chunkname: @scripts/unit_extensions/objectives/objective_unit_damage.lua

ObjectiveUnitDamage = class(ObjectiveUnitDamage, GenericUnitDamage)

function ObjectiveUnitDamage:init(world, unit, input)
	ObjectiveUnitDamage.super.init(self, world, unit, input)

	self._current_damage_level = 0

	self:_parse_damage_levels()

	self.attackers_active = true
	self.defenders_active = true

	Managers.state.event:register(self, "event_round_started", "event_round_started")
end

function ObjectiveUnitDamage:event_round_started()
	if Managers.lobby.server then
		self:_create_game_object()

		self._is_client = false
	end
end

function ObjectiveUnitDamage:enable_destructible(team_side, enable)
	if Managers.lobby.server then
		local team_side_active = team_side .. "_active"

		self[team_side_active] = enable

		if Managers.state.network:game() and self._game_object_id then
			GameSession.set_game_object_field(self._game, self._game_object_id, team_side_active, enable)
		end
	end
end

function ObjectiveUnitDamage:can_receive_damage(attacker_unit)
	local player_manager = Managers.player
	local player = player_manager:owner(attacker_unit)
	local side_name = player and player.team and player.team.side

	if side_name and Managers.state.network:game() and self._game_object_id then
		local field_name = side_name .. "_active"

		return GameSession.game_object_field(self._game, self._game_object_id, field_name)
	end

	return true
end

function ObjectiveUnitDamage:_parse_damage_levels()
	local damage_levels = {}
	local i = 0

	while Unit.has_data(self._unit, "damage_levels", i) do
		local event_name = Unit.get_data(self._unit, "damage_levels", i, "event_name")
		local damage = Unit.get_data(self._unit, "damage_levels", i, "damage")

		i = i + 1
		damage_levels[i] = damage_levels[i] or {}
		damage_levels[i][event_name] = damage
	end

	local function comparator(e1, e2)
		local event_name_1, damage_1 = next(e1)
		local event_name_2, damage_2 = next(e2)

		return damage_1 < damage_2
	end

	table.sort(damage_levels, comparator)

	self._damage_levels = damage_levels
end

function ObjectiveUnitDamage:_create_game_object()
	local current_level = LevelHelper:current_level(self._world)
	local network_manager = Managers.state.network
	local data_table = {
		game_object_created_func = NetworkLookup.game_object_functions.cb_generic_damage_extension_game_object_created,
		object_destroy_func = NetworkLookup.game_object_functions.cb_generic_damage_extension_game_object_destroyed,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		unit_game_object_id = Level.unit_index(current_level, self._unit),
		damage = self._damage,
		attackers_active = self.attackers_active,
		defenders_active = self.defenders_active
	}
	local callback = callback(self, "cb_game_session_disconnect")

	self._game_object_id = network_manager:create_game_object("generic_unit_damage", data_table, callback)
	self._game = network_manager:game()
end

function ObjectiveUnitDamage:cb_game_session_disconnect()
	self._frozen = true
	self._game_object_id = nil
	self._game = nil
end

function ObjectiveUnitDamage:set_game_object_id(game_object_id, game)
	self._game_object_id = game_object_id
	self._game = game
	self._is_client = true
end

function ObjectiveUnitDamage:remove_game_object_id()
	self._game_object_id = nil
	self._game = nil
	self._is_client = nil
end

function ObjectiveUnitDamage:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, actor, damage_range_type)
	if self._dead then
		return
	end

	if not self:can_receive_damage(attacker_unit, damage_range_type) then
		return
	end

	local modified_damage = self:_calculate_modified_damage(damage, attacker_player, damage_range_type)

	self._damage = self._damage + modified_damage

	self:_update_damage_level()

	if not self:is_dead() and self._damage >= self._health then
		self:die(modified_damage)
	end

	if script_data.damage_debug then
		print("[ObjectiveUnitDamage] add_damage " .. self._damage .. "/" .. self._health)
	end

	if Managers.state.network:game() and self._game_object_id then
		GameSession.set_game_object_field(self._game, self._game_object_id, "damage", self._damage)
	end
end

function ObjectiveUnitDamage:die(damage)
	if self._dead then
		return
	end

	self._dead = true

	for i = self._current_damage_level + 1, #self._damage_levels do
		local damage_level = self._damage_levels[i]
		local event_name, _ = next(damage_level)

		Unit.flow_event(self._unit, event_name)
	end

	local network_manager = Managers.state.network

	if network_manager:game() and Managers.lobby.server and self._game_object_id then
		network_manager:send_rpc_clients("rpc_destroy_objective", self._game_object_id, damage)
		Unit.set_flow_variable(self._unit, "damage", damage)
		Unit.flow_event(self._unit, "lua_server_dead")
	else
		Unit.flow_event(self._unit, "lua_client_dead")
	end

	local objective_ext = ScriptUnit.has_extension(self._unit, "objective_system") and ScriptUnit.extension(self._unit, "objective_system")

	if objective_ext then
		objective_ext:set_dead()
	end
end

function ObjectiveUnitDamage:_calculate_modified_damage(damage, attacker_player, damage_range_type)
	local unit = self._unit

	if not ScriptUnit.has_extension(unit, "objective_system") then
		return damage
	end

	if not attacker_player or not attacker_player.team then
		return 0
	end

	local team_manager = Managers.state.team
	local side = team_manager:objective_unit_side(unit)
	local objective_ext = ScriptUnit.extension(unit, "objective_system")
	local attacker_side = attacker_player.team.side
	local active = objective_ext:active(attacker_side)

	return damage * Managers.state.game_mode:objective_unit_damage_multiplier(unit, active, damage_range_type, attacker_side == side)
end

function ObjectiveUnitDamage:_update_damage_level()
	for i = 1, #self._damage_levels do
		local damage_level = self._damage_levels[i]
		local event_name, damage = next(damage_level)

		if damage <= self._damage and i > self._current_damage_level then
			self._current_damage_level = i

			Unit.flow_event(self._unit, event_name)
		end
	end
end

function ObjectiveUnitDamage:update(unit, input, dt, context, t)
	if self._frozen or self._dead then
		return
	end

	if Managers.state.network:game() and self._is_client == true then
		self:_client_update(t, dt)
	end
end

function ObjectiveUnitDamage:_client_update(t, dt)
	local current_damage = self._damage

	self._damage = GameSession.game_object_field(self._game, self._game_object_id, "damage")

	if self._damage ~= current_damage then
		self:_update_damage_level()
	end
end

function ObjectiveUnitDamage:hot_join_synch(sender, player)
	RPC.rpc_synch_unit_damage_level(sender, self._game_object_id, self._current_damage_level, self._dead)
end

function ObjectiveUnitDamage:rpc_synch_unit_damage_level(damage_level, dead)
	for i = 1, damage_level do
		local damage_level = self._damage_levels[i]
		local event_name, _ = next(damage_level)

		Unit.flow_event(self._unit, "set_" .. event_name)
	end

	if dead then
		Unit.flow_event(self._unit, "set_lua_client_dead")
	end

	self._dead = dead
end
