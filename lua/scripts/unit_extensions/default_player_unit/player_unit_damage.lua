-- chunkname: @scripts/unit_extensions/default_player_unit/player_unit_damage.lua

require("scripts/settings/player_unit_damage_settings")

PlayerUnitDamage = class(PlayerUnitDamage)
PlayerUnitDamage.SYSTEM = "damage_system"

function PlayerUnitDamage:init(world, unit, player_index)
	self._world = world
	self._unit = unit
	self._damage = 0
	self._wounded = false
	self._was_wounded = false
	self._knocked_down = false
	self._dead = false
	self._health = PlayerUnitDamageSettings.MAX_HP
	self._dead_threshold = PlayerUnitDamageSettings.MAX_HP + PlayerUnitDamageSettings.KD_MAX_HP
	self._game_object_id = nil
	self._revived_by = nil
	self._revive_time = 0
	self._bandaged_by = nil
	self._bandage_time = 0
	self._damagers = {}
	self._effect_ids = {}
	self._damage_over_time_sources = table.clone(PlayerUnitDamageSettings.dot_types)
	self.wounded_camera_effect_active = false
	self.wounded_camera_shake_effect_id = nil
	self.wounded_camera_particle_effect_id = nil

	if Managers.lobby.server then
		self:_create_game_object()

		self._is_client = false
	elseif not Managers.lobby.lobby then
		self._is_client = false
	end

	self._is_husk = false

	local player_manager = Managers.player
	local player = player_manager:player(player_index)

	player.state_data.health = self._health
	player.state_data.damage = self._damage
	self._player = player
	self._invulnerable = player.spawn_as_invulnerable
	self._last_damager = nil
	self._drawer = Managers.state.debug:drawer()

	self:_setup_hit_zones(PlayerUnitDamageSettings.hit_zones)

	self._hud_debuff_blackboard = {
		wounded = {
			end_time = 0,
			level = 0
		},
		burning = {
			end_time = 0,
			level = 0
		},
		bleeding = {
			end_time = 0,
			level = 0
		},
		arrow = {
			end_time = 0,
			level = 0
		}
	}

	Managers.state.event:trigger("debuffs_activated", player, self._hud_debuff_blackboard)
end

function PlayerUnitDamage:_setup_hit_zones(hit_zones)
	local actor_table = {}
	local unit = self._unit

	for zone_name, data in pairs(hit_zones) do
		for _, actor_name in ipairs(data.actors) do
			local actor = Unit.actor(unit, actor_name)

			assert(not actor_table[actor], "Actor exists in multiple hit zones, fix in PlayerUnitDamageSettings.hit_zones")

			actor_table[actor] = {
				name = zone_name,
				damage_multiplier = data.damage_multiplier,
				damage_multiplier_ranged = data.damage_multiplier_ranged,
				forward = data.forward
			}
		end

		actor_table[zone_name] = {
			name = zone_name,
			damage_multiplier = data.damage_multiplier,
			damage_multiplier_ranged = data.damage_multiplier_ranged,
			forward = data.forward
		}
	end

	Unit.set_data(unit, "hit_zone_lookup_table", actor_table)
end

function PlayerUnitDamage:_create_game_object()
	local data_table = {
		burning_end_time = 0,
		bleeding_end_time = 0,
		arrow_level = 0,
		wounded_end_time = 0,
		arrow_end_time = 0,
		burning_level = 0,
		bleeding_level = 0,
		game_object_created_func = NetworkLookup.game_object_functions.cb_player_damage_extension_game_object_created,
		object_destroy_func = NetworkLookup.game_object_functions.cb_player_damage_extension_game_object_destroyed,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		player_unit_game_object_id = Unit.get_data(self._unit, "game_object_id"),
		wounded = self._wounded,
		dead = self._dead,
		health = self._health,
		damage = self._damage
	}
	local callback = callback(self, "cb_game_session_disconnect")

	self._game_object_id = Managers.state.network:create_game_object("player_unit_damage", data_table, callback)
	self._game = Managers.state.network:game()
end

function PlayerUnitDamage:cb_game_session_disconnect()
	self._frozen = true

	self:remove_game_object_id()
end

function PlayerUnitDamage:set_invulnerable(invulnerable)
	self._invulnerable = invulnerable
end

function PlayerUnitDamage:set_game_object_id(game_object_id, game)
	self._game_object_id = game_object_id
	self._game = game
	self._is_client = true
end

function PlayerUnitDamage:remove_game_object_id()
	self._game_object_id = nil
	self._game = nil
	self._is_client = nil
end

function PlayerUnitDamage:network_recieve_add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, damage_range_type, gear_name, hit_zone, impact_direction, real_damage, range, mirrored)
	self:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, nil, damage_range_type, gear_name, hit_zone, impact_direction, real_damage, range, mirrored)
end

function PlayerUnitDamage:add_damage(attacking_player, attacking_unit, damage_type, damage, position, normal, actor, damage_range_type, gear_name, hit_zone, impact_direction, real_damage, range, mirrored)
	if self._executed_by or script_data.disable_damage or self._invulnerable then
		return
	end

	damage = math.floor(damage)

	if not self._knocked_down and not self._dead then
		Managers.state.event:trigger("player_damaged", self._player, attacking_player, damage, gear_name, hit_zone, damage_range_type, range, mirrored)
	end

	local remaining_health = self._health - self._damage

	self._damage = self._damage + damage

	local own_player = self._player

	if self._revived_by then
		local id = Unit.get_data(self._unit, "game_object_id")

		self:abort_revive(self._revived_by, id)
	end

	if script_data.damage_debug then
		print("damage:", damage, "real damage:", real_damage, "instakill threshold: ", remaining_health * PlayerUnitDamageSettings.INSTAKILL_HEALTH_FACTOR + PlayerUnitDamageSettings.INSTAKILL_THRESHOLD)
	end

	if not self._knocked_down and not self._dead and self._damage >= self._health and real_damage < remaining_health * PlayerUnitDamageSettings.INSTAKILL_HEALTH_FACTOR + PlayerUnitDamageSettings.INSTAKILL_THRESHOLD then
		local damager = attacking_player ~= own_player and attacking_player or self._last_damager or own_player

		self:knocked_down(damager, gear_name, hit_zone, impact_direction, damage_type)
	elseif not self._knocked_down and not self._dead and self._damage >= self._health then
		local damager = attacking_player ~= own_player and attacking_player or self._last_damager or own_player

		self:die(damager, gear_name, true, damage_type, hit_zone, impact_direction)
		Managers.state.event:trigger("player_instakilled", self._player, damager, gear_name, self._damagers, damage_type)

		if attacking_player == own_player or attacking_player.team == own_player.team or not Managers.lobby.lobby then
			-- block empty
		elseif not own_player.remote then
			Managers.state.event:trigger("player_killed_by_enemy", own_player, attacking_player)
		elseif Managers.state.network:game() then
			RPC.rpc_player_killed_by_enemy(own_player:network_id(), own_player:player_id(), attacking_player:player_id())
		end
	elseif not self._dead and self._damage >= self._dead_threshold then
		local damager = attacking_player ~= own_player and attacking_player or self._last_damager or own_player

		self:die(damager, gear_name, false, damage_type)
	end

	if script_data.damage_debug then
		print("[PlayerUnitDamage] add_damage " .. self._damage .. "/" .. self._health)
	end

	if attacking_player and attacking_player ~= own_player then
		self._last_damager = attacking_player
		self._last_damagers_gear_name = gear_name
		self._damagers[attacking_player] = true
	end
end

function PlayerUnitDamage:network_recieve_add_damage_over_time(attacking_player, damage_type)
	self:add_damage_over_time(attacking_player, damage_type)
end

function PlayerUnitDamage:add_damage_over_time(attacking_player, damage_type)
	local locomotion = ScriptUnit.extension(self._unit, "locomotion_system")

	if locomotion:has_perk("oblivious") or script_data.disable_damage then
		return
	end

	local settings = Debuffs[damage_type]
	local dots = self._damage_over_time_sources[damage_type]
	local dot_to_replace
	local end_time = settings.duration + Managers.time:time("round")
	local own_player = self._player

	if attacking_player and attacking_player ~= own_player then
		self._damagers[attacking_player] = true
	end

	local dot_applied = false

	for i = 1, settings.max_dot_amount do
		local dot = dots[i]

		if dot then
			dot.end_time = end_time
			dot.applier = attacking_player
			dot.dps = settings.dps
		elseif not dot_applied then
			dot_applied = true

			self:_increment_hud_blackboard_level(damage_type, 1)

			dots[i] = {
				dps = settings.dps,
				end_time = end_time,
				applier = attacking_player
			}
		end
	end

	self:_set_hud_blackboard_end_time(damage_type, end_time)
	Managers.state.event:trigger("player_dotted", self._player, attacking_player, damage_type)
end

function PlayerUnitDamage:_update_dot_effects()
	if self._game then
		for dot_name, dot_data in pairs(Debuffs) do
			if dot_data.fx_name then
				local dot_level = GameSession.game_object_field(self._game, self._game_object_id, dot_name .. "_level")

				if dot_level > 0 and not self._effect_ids[dot_name] then
					self:play_dot_effect(dot_name, dot_data.fx_name, dot_data.fx_node)
				elseif dot_level == 0 and self._effect_ids[dot_name] then
					self:stop_dot_effect(dot_name)
				end
			end
		end
	end
end

function PlayerUnitDamage:play_dot_effect(damage_over_time_type, effect_name, node_name)
	if effect_name and node_name then
		if not GameSettingsDevelopment.allow_multiple_dot_effects then
			for dot_name, id in pairs(self._effect_ids) do
				self:stop_dot_effect(dot_name)
			end
		end

		local node = Unit.node(self._unit, node_name)

		self._effect_ids[damage_over_time_type] = ScriptWorld.create_particles_linked(self._world, "fx/fire_dot", self._unit, node, "stop", Matrix4x4.identity())
	end
end

function PlayerUnitDamage:stop_dot_effect(damage_over_time_type)
	local effect_id = self._effect_ids[damage_over_time_type]

	World.stop_spawning_particles(self._world, effect_id)

	self._effect_ids[damage_over_time_type] = nil
end

function PlayerUnitDamage:update(unit, input, dt, context, t)
	self:_update_health(t, dt)

	if self._player and self._player.state_data then
		self._player.state_data.damage = self._damage
		self._player.state_data.health = self._health
	end

	self:_update_dot_effects()

	if self._dead or self._frozen then
		return
	end

	if self._is_client == true then
		self:_client_update(t, dt)
	elseif self._is_client == false then
		self:_server_update(t, dt)
	elseif self._is_client == nil then
		-- block empty
	end

	if self._wounded and not self._was_wounded then
		if not self._wounded_sound_id and not self._is_husk then
			local timpani_world = World.timpani_world(self._world)

			self._wounded_sound_id = TimpaniWorld.trigger_event(timpani_world, "chr_heartbeat_loop")
		end

		self._wound_timer = t

		Managers.state.event:trigger("player_wounded", self._player)
	elseif not self._wounded and self._was_wounded and self._wounded_sound_id then
		local timpani_world = World.timpani_world(self._world)

		TimpaniWorld.trigger_event(timpani_world, "Stop_chr_heartbeat_loop")

		self._wounded_sound_id = nil
	end

	if self._wounded and self._damage ~= self._prev_damage then
		local wound_value_clamped = 1

		if self._wounded_sound_id then
			local timpani_world = World.timpani_world(self._world)

			TimpaniWorld.set_parameter(timpani_world, self._wounded_sound_id, "heart_frequency_volume", wound_value_clamped)
			TimpaniWorld.set_parameter(timpani_world, self._wounded_sound_id, "heart_frequency_pitch", wound_value_clamped)
		end
	end

	self._was_wounded = self._wounded
	self._prev_damage = self._damage
end

function PlayerUnitDamage:_client_update(t, dt)
	if self._game and self._game_object_id then
		self._damage = GameSession.game_object_field(self._game, self._game_object_id, "damage")
		self._wounded = GameSession.game_object_field(self._game, self._game_object_id, "wounded")

		if not self._is_husk then
			self:_set_debuff_blackboard_fields()
		end
	end
end

function PlayerUnitDamage:_server_update(t, dt)
	local locomotion = ScriptUnit.extension(self._unit, "locomotion_system")

	self:_update_buff_regeneration(t, dt)

	local has_dot_applied = self:_has_damage_over_time_applied()
	local oblivious = locomotion:has_perk("oblivious")

	if oblivious or self._knocked_down or self._dead or self._damage / self._health < Debuffs.wounded.threshold then
		self._wounded = false

		if not self._is_husk then
			self._hud_debuff_blackboard.wounded.level = 0
			self._hud_debuff_blackboard.wounded.end_time = 0
		end
	elseif not self._wounded and self._damage / self._health > Debuffs.wounded.threshold and not self._knocked_down and not self._dead then
		self._wounded = true

		local end_time = Managers.time:time("round") + Debuffs.wounded.duration

		self._wounded_end_time = end_time

		if not self._is_husk then
			self._hud_debuff_blackboard.wounded.level = 1
			self._hud_debuff_blackboard.wounded.end_time = end_time
		end

		if self._game and self._game_object_id then
			GameSession.set_game_object_field(self._game, self._game_object_id, "wounded_end_time", end_time)
		end
	elseif self._wounded and self._bandaged_by then
		local end_time = self._wounded_end_time + dt

		self._wounded_end_time = end_time

		if not self._is_husk then
			self._hud_debuff_blackboard.wounded.end_time = end_time
		end

		if self._game and self._game_object_id then
			GameSession.set_game_object_field(self._game, self._game_object_id, "wounded_end_time", end_time)
		end
	elseif self._wounded and self._wounded_end_time < Managers.time:time("round") then
		self:knocked_down(self._last_damager, self._last_damagers_gear_name, nil, Vector3(0, 0, 0), "damage_over_time")
	end

	if self._knocked_down and self._executed_by then
		if t >= self._execution_time then
			self:die(self._executor_id, "execution", false)
		end
	elseif self._knocked_down and self._revived_by then
		if t >= self._revive_time then
			self:completed_revive()
		end
	elseif self._knocked_down and not self._revived_by and not self._executed_by then
		self._damage = self._damage + PlayerUnitDamageSettings.kd_bleeding.dps * dt

		if self._damage >= self._dead_threshold then
			self:die(self._player, nil, false, "damage_over_time")
		end
	elseif self._bandaged_by then
		if t >= self._bandage_time then
			self:completed_bandage()
		end
	elseif has_dot_applied then
		self._damage = self._damage + self:_calculate_current_dot_damage(t, dt)

		if self._damage >= self._health then
			self:knocked_down(self._last_damager, self._last_damagers_gear_name, nil, Vector3(0, 0, 0), "damage_over_time")
		end
	end

	if false then
		-- block empty
	end

	if self._game and self._game_object_id then
		local health_constants = NetworkConstants.health

		GameSession.set_game_object_field(self._game, self._game_object_id, "damage", math.clamp(self._damage, health_constants.min, health_constants.max))
		GameSession.set_game_object_field(self._game, self._game_object_id, "wounded", self._wounded)
	end
end

function PlayerUnitDamage:_update_health(t, dt)
	if self._game and self._game_object_id then
		local area_buff_ext = ScriptUnit.extension(self._unit, "area_buff_system")

		if area_buff_ext:buff_level("berserker") > 0 then
			self._health = PlayerUnitDamageSettings.MAX_HP * area_buff_ext:buff_multiplier("berserker")
		else
			self._health = PlayerUnitDamageSettings.MAX_HP
		end
	end
end

function PlayerUnitDamage:_has_damage_over_time_applied()
	for dot_type, instances in pairs(self._damage_over_time_sources) do
		for _, instance in ipairs(instances) do
			return true
		end
	end
end

function PlayerUnitDamage:_calculate_current_dot_damage(t, dt)
	local t = Managers.time:time("round")
	local total_dps = 0

	for dot_type, instances in pairs(self._damage_over_time_sources) do
		for i = #instances, 1, -1 do
			if t >= instances[i].end_time then
				self:_increment_hud_blackboard_level(dot_type, -1)
				table.remove(instances, i)
			else
				total_dps = total_dps + instances[i].dps
			end
		end
	end

	return total_dps * dt
end

function PlayerUnitDamage:self_knock_down()
	if not self:is_dead() and not self:is_knocked_down() then
		self:knocked_down(self._player, nil, nil, Vector3(0, 0, 0), "kinetic")
	end
end

function PlayerUnitDamage:knocked_down(attacker, gear_name, hit_zone, impact_direction, damage_type)
	if not attacker or not attacker:alive() then
		attacker = nil
		gear_name = nil
	end

	local network_manager = Managers.state.network
	local area_buff_ext = ScriptUnit.extension(self._unit, "area_buff_system")

	if Managers.lobby.lobby == nil then
		self:die(attacker, gear_name, false)

		return
	elseif area_buff_ext:buff_level("berserker") > 0 then
		self:die(attacker, gear_name, true, damage_type, hit_zone, impact_direction)

		return
	end

	self._damage = self._health

	self:player_knocked_down()

	if network_manager:game() then
		local object_id = Unit.get_data(self._unit, "game_object_id")

		network_manager:send_rpc_clients("rpc_player_knocked_down", object_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, NetworkLookup.damage_types[damage_type])

		if gear_name then
			network_manager:update_combat_log(attacker, self._player, gear_name)
		end
	end

	local locomotion = ScriptUnit.extension(self._unit, "locomotion_system")

	locomotion:player_knocked_down(hit_zone, impact_direction, damage_type)

	if attacker and Managers.player:player_exists(attacker.index) then
		Managers.state.event:trigger("player_knocked_down", self._player, attacker, gear_name, self._damagers, damage_type)
	end
end

function PlayerUnitDamage:can_yield()
	return self._knocked_down and not self._dead and not self._executed_by and not self._revived_by
end

function PlayerUnitDamage:yield()
	self:die(self._player, nil, false, "yield")
end

function PlayerUnitDamage:die(attacker, gear_name, is_instakill, damage_type, hit_zone, impact_direction)
	if not attacker or not attacker:alive() then
		attacker = nil
		gear_name = nil
	end

	self:player_dead()

	local network_manager = Managers.state.network

	if network_manager:game() then
		local object_id = Unit.get_data(self._unit, "game_object_id")

		network_manager:send_rpc_clients("rpc_player_dead", object_id, is_instakill or false, NetworkLookup.damage_types[damage_type or "kinetic"], NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction or Vector3(0, 0, 0))

		if is_instakill and gear_name then
			network_manager:update_combat_log(attacker, self._player, gear_name)
		end
	end

	if attacker and Managers.player:player_exists(attacker.index) then
		Managers.state.event:trigger("player_unit_died", self._player, attacker, gear_name, is_instakill, self._damagers, damage_type)
	end

	local locomotion = ScriptUnit.extension(self._unit, "locomotion_system")

	locomotion:player_dead(is_instakill, damage_type, hit_zone, impact_direction)
end

function PlayerUnitDamage:is_wounded()
	return self._wounded
end

function PlayerUnitDamage:is_dead()
	return self._dead
end

function PlayerUnitDamage:is_knocked_down()
	return self._knocked_down
end

function PlayerUnitDamage:is_alive()
	return not self._knocked_down and not self._dead
end

function PlayerUnitDamage:destroy()
	if Managers.lobby.server and self._game and self._game_object_id then
		Managers.state.network:destroy_game_object(self._game_object_id)
	end

	WeaponHelper:remove_projectiles(self._unit)
end

function PlayerUnitDamage:player_dead()
	local player = self._player
	local unit = self._unit

	if player.player_unit == unit then
		Managers.state.event:trigger("player_unit_dead", player)

		if not Managers.lobby.lobby then
			local level = LevelHelper:current_level(self._world)

			Level.trigger_event(level, "sp_player_died")
		end
	end

	Unit.flow_event(unit, "lua_player_dead")

	if self._wounded_sound_id then
		local timpani_world = World.timpani_world(self._world)

		TimpaniWorld.trigger_event(timpani_world, "Stop_chr_heartbeat_loop")

		self._wounded_sound_id = nil
	end

	self._dead = true
end

function PlayerUnitDamage:player_knocked_down()
	Unit.flow_event(self._unit, "lua_player_knocked_down")

	self._knocked_down = true
end

function PlayerUnitDamage:can_be_executed()
	return not self._dead and self._knocked_down and not self._revived_by and not self._executed_by
end

function PlayerUnitDamage:start_execution(executor_id, player_id)
	self._executed_by = executor_id
	self._executor_id = player_id
	self._execution_time = Managers.time:time("game") + PlayerUnitMovementSettings.interaction.settings.execute.duration
end

function PlayerUnitDamage:abort_execution(executor_id)
	if self._executed_by == executor_id then
		self._executed_by = nil
		self._executor_id = nil

		return true
	end
end

function PlayerUnitDamage:can_be_bandaged()
	return not self._dead and not self._knocked_down and not self._bandaged_by
end

function PlayerUnitDamage:can_be_revived()
	return not self._dead and self._knocked_down and not self._revived_by and not self._executed_by
end

function PlayerUnitDamage:start_revive(reviver_id, revivee_id)
	self._revived_by = reviver_id
	self._revive_time = Managers.time:time("game") + PlayerUnitDamageSettings.REVIVE_TIME

	local locomotion_ext = ScriptUnit.extension(self._unit, "locomotion_system")

	locomotion_ext:rpc_start_revive()

	if Managers.state.network:game() and Managers.lobby.server then
		Managers.state.network:send_rpc_clients("rpc_start_revive_teammate", reviver_id, revivee_id)
	end
end

function PlayerUnitDamage:start_bandage(bandager_id, bandagee_id)
	self._bandaged_by = bandager_id

	local interaction_type
	local surgeon_perk = Perks.surgeon
	local regenerative_perk = Perks.regenerative
	local locomotion_ext = ScriptUnit.extension(self._unit, "locomotion_system")
	local has_surgeon_perk = locomotion_ext:has_perk("surgeon")
	local has_regenerative_perk = locomotion_ext:has_perk("regenerative")
	local duration_multiplier

	if bandager_id == bandagee_id then
		interaction_type = "bandage_self"
		duration_multiplier = (has_surgeon_perk and surgeon_perk.self_duration_multiplier or 1) * (has_regenerative_perk and regenerative_perk.self_duration_multiplier or 1)
	else
		interaction_type = "bandage"

		local network_manager = Managers.state.network
		local bandager_unit = network_manager:game_object_unit(bandager_id)
		local bandager_locomotion = ScriptUnit.extension(bandager_unit, "locomotion_system")

		duration_multiplier = bandager_locomotion:has_perk("surgeon") and surgeon_perk.teammate_duration_multiplier or 1
	end

	self._bandage_time = Managers.time:time("game") + PlayerUnitMovementSettings.interaction.settings[interaction_type].duration * duration_multiplier
end

function PlayerUnitDamage:completed_revive()
	local locomotion_ext = ScriptUnit.extension(self._unit, "locomotion_system")

	locomotion_ext:rpc_completed_revive()
	WeaponHelper:remove_projectiles(self._unit)

	if Managers.lobby.server then
		self._wounded = false

		local reviver_unit = Managers.state.network:game_object_unit(self._revived_by)
		local revived_hp = PlayerUnitDamageSettings.REVIVED_HP

		if Unit.alive(reviver_unit) then
			local reviver_locomotion = ScriptUnit.extension(reviver_unit, "locomotion_system")

			revived_hp = reviver_locomotion:has_perk("sterilised_bandages") and self._health or revived_hp

			local reviver_player = Managers.player:owner(reviver_unit)

			Managers.state.stats_collector:player_revived(self._player, reviver_player)
		end

		self._damage = self._health - revived_hp

		self:_clear_damagers()
		self:_clear_damage_over_time()

		if self._game then
			Managers.state.network:send_rpc_clients("rpc_completed_revive", Unit.get_data(self._unit, "game_object_id"))
		end
	end

	self._revived_by = nil
	self._knocked_down = false
end

function PlayerUnitDamage:_clear_damagers()
	table.clear(self._damagers)
end

function PlayerUnitDamage:_clear_damage_over_time()
	for damage_type, instances in pairs(self._damage_over_time_sources) do
		table.clear(instances)

		if not self._is_husk then
			local blackboard = self._hud_debuff_blackboard[damage_type]

			blackboard.level = 0
		end

		if self._game then
			GameSession.set_game_object_field(self._game, self._game_object_id, damage_type .. "_level", 0)
		end
	end
end

function PlayerUnitDamage:rpc_bandage_completed_client()
	WeaponHelper:remove_projectiles(self._unit)

	local locomotion_ext = ScriptUnit.extension(self._unit, "locomotion_system")
	local inventory = locomotion_ext:inventory()

	if inventory.bandage_rejuvenate_gear then
		inventory:bandage_rejuvenate_gear()
	end
end

function PlayerUnitDamage:completed_bandage()
	if Managers.lobby.lobby then
		Managers.state.network:send_rpc_clients("rpc_bandage_completed_client", Unit.get_data(self._unit, "game_object_id"))
	end

	WeaponHelper:remove_projectiles(self._unit)

	local bandager_unit

	if Managers.lobby.lobby then
		bandager_unit = Managers.state.network:game_object_unit(self._bandaged_by)
	else
		bandager_unit = self._bandaged_by
	end

	self._bandaged_by = nil
	self._wounded = false

	local bandaged_hp = PlayerUnitDamageSettings.BANDAGED_HP

	if Unit.alive(bandager_unit) then
		local bandager_player = Managers.player:owner(bandager_unit)

		Managers.state.event:trigger("player_bandaged", self._player, bandager_player)

		local locomotion_ext = ScriptUnit.extension(bandager_unit, "locomotion_system")

		if locomotion_ext:has_perk("sterilised_bandages") then
			self._damage = 0
		else
			self._damage = math.max(0, self._damage - PlayerUnitDamageSettings.BANDAGED_HP)
		end
	else
		self._damage = math.max(0, self._damage - PlayerUnitDamageSettings.BANDAGED_HP)
	end

	local locomotion_ext = ScriptUnit.extension(self._unit, "locomotion_system")
	local inventory = locomotion_ext:inventory()

	if inventory.bandage_rejuvenate_gear then
		inventory:bandage_rejuvenate_gear()
	end

	self:_clear_damagers()
	self:_clear_damage_over_time()
end

function PlayerUnitDamage:abort_bandage(bandager_id, bandagee_id)
	if self._bandaged_by ~= bandager_id then
		return
	end

	self._bandaged_by = nil
end

function PlayerUnitDamage:abort_revive(reviver_id, revivee_id)
	if self._revived_by ~= reviver_id then
		return
	end

	self._revived_by = nil

	local locomotion_ext = ScriptUnit.extension(self._unit, "locomotion_system")

	locomotion_ext:rpc_abort_revive()

	if Managers.lobby.server and self._game then
		Managers.state.network:send_rpc_clients("rpc_abort_revive_teammate", reviver_id, revivee_id)
	end
end

function PlayerUnitDamage:_set_hud_blackboard_end_time(debuff_type, value)
	if not self._is_husk then
		self._hud_debuff_blackboard[debuff_type].end_time = value
	end

	if self._game then
		GameSession.set_game_object_field(self._game, self._game_object_id, debuff_type .. "_end_time", value)
	end
end

function PlayerUnitDamage:_increment_hud_blackboard_level(debuff_type, modifier)
	if not self._is_husk then
		local blackboard = self._hud_debuff_blackboard[debuff_type]

		blackboard.level = blackboard.level + modifier
	end

	local level = GameSession.game_object_field(self._game, self._game_object_id, debuff_type .. "_level") + modifier

	if self._game then
		GameSession.set_game_object_field(self._game, self._game_object_id, debuff_type .. "_level", level)
	end
end

function PlayerUnitDamage:_update_buff_regeneration(t, dt)
	local area_buff_ext = ScriptUnit.extension(self._unit, "area_buff_system")
	local regen_val = area_buff_ext:buff_multiplier("courage") * dt

	self._damage = math.max(0, self._damage - regen_val)
end

function PlayerUnitDamage:_set_debuff_blackboard_fields()
	local blackboard = self._hud_debuff_blackboard

	blackboard.wounded.level = GameSession.game_object_field(self._game, self._game_object_id, "wounded") and 1 or 0
	blackboard.wounded.end_time = GameSession.game_object_field(self._game, self._game_object_id, "wounded_end_time")
	blackboard.bleeding.level = GameSession.game_object_field(self._game, self._game_object_id, "bleeding_level")
	blackboard.bleeding.end_time = GameSession.game_object_field(self._game, self._game_object_id, "bleeding_end_time")
	blackboard.burning.level = GameSession.game_object_field(self._game, self._game_object_id, "burning_level")
	blackboard.burning.end_time = GameSession.game_object_field(self._game, self._game_object_id, "burning_end_time")
	blackboard.arrow.level = GameSession.game_object_field(self._game, self._game_object_id, "arrow_level")
	blackboard.arrow.end_time = GameSession.game_object_field(self._game, self._game_object_id, "arrow_end_time")
end

function PlayerUnitDamage:debuff_blackboard()
	return self._hud_debuff_blackboard
end
