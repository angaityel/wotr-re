-- chunkname: @scripts/unit_extensions/horse/horse_damage.lua

HorseDamage = class(HorseDamage)
HorseDamage.SYSTEM = "damage_system"

function HorseDamage:init(world, unit, input)
	self._world = world
	self._unit = unit
	self._damage = 0
	self._dead = false

	local mount_profile = MountProfiles[Unit.get_data(unit, "mount_profile")]

	self:_setup_hit_zones(mount_profile.hit_zones)
	Unit.set_data(unit, "health", mount_profile.health)
	Unit.set_data(unit, "armour_type", mount_profile.armour_type)
	Unit.set_data(unit, "penetration_value", mount_profile.penetration_value)
	Unit.set_data(unit, "absorption_value", mount_profile.absorption_value)

	self._health = mount_profile.health
end

function HorseDamage:_setup_hit_zones(hit_zones)
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
				armour = data.armour
			}
		end
	end

	Unit.set_data(unit, "hit_zone_lookup_table", actor_table)
end

function HorseDamage:network_recieve_add_damage_over_time(...)
	self:add_damage_over_time(...)
end

function HorseDamage:add_damage_over_time(...)
	return
end

function HorseDamage:network_recieve_add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, damage_range_type, gear_name, hit_zone, impact_direction, real_damage, range, mirrored)
	self:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, nil, damage_range_type, gear_name, hit_zone, impact_direction, real_damage, range, mirrored)
end

function HorseDamage:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, actor, damage_range_type, gear_name, hit_zone, impact_direction, real_damage, range, mirrored)
	if not script_data.disable_damage then
		self._damage = self._damage + damage
	end

	if not self:is_dead() and self._damage >= self._health then
		self:die(attacker_player, damage_type, damage, position, normal, actor, impact_direction)
	end

	if script_data.damage_debug then
		print("[HorseDamage] add_damage " .. self._damage .. "/" .. self._health)
	end
end

function HorseDamage:die(attacker_player, damage_type, damage, position, normal, actor, impact_direction)
	self._dead = true

	local network_manager = Managers.state.network
	local player_manager = Managers.player
	local unit = self._unit
	local horse_owner = player_manager:owner(unit)
	local rider_unit = Unit.get_data(unit, "user_unit")

	if attacker_player then
		Managers.state.event:trigger("mount_unit_dead", attacker_player, horse_owner)
	end

	impact_direction = impact_direction or Vector3(0, 0, 0)

	if network_manager:game() then
		local horse_object_id = network_manager:unit_game_object_id(unit)
		local horse_locomotion = ScriptUnit.extension(unit, "locomotion_system")

		horse_locomotion:set_dead(impact_direction)

		local horse_game_obj_owner = network_manager:game_object_owner(horse_object_id)

		network_manager:send_rpc_clients("rpc_horse_dead", horse_object_id, impact_direction)
	else
		local horse_locomotion = ScriptUnit.extension(unit, "locomotion_system")

		horse_locomotion:set_dead(impact_direction)
	end
end

function HorseDamage:rpc_set_dead()
	self._dead = true
end

function HorseDamage:is_dead()
	return self._dead
end

function HorseDamage:is_alive()
	return not self._dead
end

function HorseDamage:destroy()
	WeaponHelper:remove_projectiles(self._unit)
end
