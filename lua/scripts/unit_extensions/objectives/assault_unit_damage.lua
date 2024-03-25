-- chunkname: @scripts/unit_extensions/objectives/assault_unit_damage.lua

AssaultUnitDamage = class(AssaultUnitDamage, ObjectiveUnitDamage)

function AssaultUnitDamage:init(world, unit, input)
	AssaultUnitDamage.super.init(self, world, unit, input)

	self._enable_damage = true
	self._projectile_damage = Unit.get_data(self._unit, "projectile_damage")
end

function AssaultUnitDamage:_calculate_modified_damage(damage)
	return self._enable_damage and damage or 0
end

function AssaultUnitDamage:enable_damage(enable_damage)
	self._enable_damage = enable_damage

	local objective_ext = ScriptUnit.extension(self._unit, "objective_system")

	if objective_ext then
		objective_ext:enable_destructible(enable_damage)
	end
end

function AssaultUnitDamage:can_receive_damage(attacker_unit, damage_range_type)
	local player_index = Unit.get_data(attacker_unit, "owner_player_index")
	local player = Managers.player:player(player_index)
	local team_side = player.team.side
	local damage_enabled = self:_damage_enabled(team_side)

	if not damage_enabled or not self._projectile_damage and damage_range_type ~= "melee" then
		return false
	end

	return AssaultUnitDamage.super.can_receive_damage(self, attacker_unit)
end

function AssaultUnitDamage:_damage_enabled(team_side)
	if self._dead then
		return false
	end

	local objective_ext = ScriptUnit.extension(self._unit, "objective_system")

	if objective_ext then
		local destructible_active = objective_ext:destructible_active(team_side)

		if not destructible_active then
			return false
		else
			return self._enable_damage
		end
	end
end

function AssaultUnitDamage:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, actor, damage_range_type)
	if self._dead then
		return
	end

	if self._projectile_damage or damage_range_type == "melee" then
		AssaultUnitDamage.super.add_damage(self, attacker_player, attacker_unit, damage_type, damage, position, normal, actor, damage_range_type)
	end

	local damage_enabled = self:_damage_enabled(attacker_player.team.side)

	if attacker_player.team.side ~= Unit.get_data(self._unit, "side") and damage_enabled then
		Unit.flow_event(self._unit, "lua_assault_announcement")
	end
end

function AssaultUnitDamage:enable_destructible(team_side, enable)
	if self._dead then
		return
	end

	AssaultUnitDamage.super.enable_destructible(self, team_side, enable)

	local objective_ext = ScriptUnit.extension(self._unit, "objective_system")

	if objective_ext then
		objective_ext:destructible_objective_activated(team_side, enable)
	end
end

function AssaultUnitDamage:_client_update(t, dt)
	if self._dead then
		return
	end

	local current_damage = self._damage

	self._damage = GameSession.game_object_field(self._game, self._game_object_id, "damage")

	if self._damage ~= current_damage then
		self:_update_damage_level()
	end
end
