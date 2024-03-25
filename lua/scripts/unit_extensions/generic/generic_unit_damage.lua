-- chunkname: @scripts/unit_extensions/generic/generic_unit_damage.lua

GenericUnitDamage = class(GenericUnitDamage)
GenericUnitDamage.SYSTEM = "damage_system"

function GenericUnitDamage:init(world, unit, input)
	self._world = world
	self._unit = unit
	self._damage = 0
	self._dead = false

	local health = Unit.get_data(unit, "health")

	if health == -1 then
		Unit.set_data(unit, "health", nil)

		self._health = math.huge
	else
		self._health = health
	end
end

function GenericUnitDamage:network_recieve_add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, damage_range_type)
	self:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, nil, damage_range_type)
end

function GenericUnitDamage:network_recieve_add_damage_over_time(...)
	self:add_damage_over_time(...)
end

function GenericUnitDamage:reset_damage()
	self._damage = 0
end

function GenericUnitDamage:add_damage_over_time(...)
	return
end

function GenericUnitDamage:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, actor, damage_range_type)
	self._damage = self._damage + damage

	if not self:is_dead() and self._damage >= self._health then
		self:die(damage)
	end

	if script_data.damage_debug then
		print("[GenericUnitDamage] add_damage " .. self._damage .. "/" .. self._health)
	end
end

function GenericUnitDamage:die(damage)
	self._dead = true

	if Unit.has_data(self._unit, "gear_name") then
		self:_gear_dead(damage)
	else
		self:_prop_dead(damage)
	end
end

function GenericUnitDamage:_gear_dead(damage)
	local unit = self._unit
	local network_manager = Managers.state.network

	if not Managers.lobby.lobby then
		local user_unit = Unit.get_data(unit, "user_unit")
		local locomotion = ScriptUnit.extension(user_unit, "locomotion_system")

		locomotion:gear_dead(unit)
	elseif network_manager:game() then
		local object_id = network_manager:game_object_id(unit)
		local owner = network_manager:game_object_owner(object_id)

		if owner == Network.peer_id() then
			local user_unit = Unit.get_data(unit, "user_unit")
			local locomotion = ScriptUnit.extension(user_unit, "locomotion_system")

			locomotion:gear_dead(unit)
		else
			RPC.rpc_gear_destroyed(owner, object_id)
		end
	end
end

function GenericUnitDamage:_prop_dead(damage)
	local unit = self._unit

	Unit.set_flow_variable(unit, "damage", damage)
	Unit.flow_event(unit, "lua_dead")
end

function GenericUnitDamage:is_dead()
	return self._dead
end

function GenericUnitDamage:is_alive()
	return not self._dead
end

function GenericUnitDamage:destroy()
	WeaponHelper:remove_projectiles(self._unit)
end
