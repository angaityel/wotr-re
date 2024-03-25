-- chunkname: @scripts/unit_extensions/human/ai_player_unit/ai_unit_damage.lua

require("scripts/settings/player_unit_damage_settings")

AIUnitDamage = class(AIUnitDamage)
AIUnitDamage.SYSTEM = "damage_system"

function AIUnitDamage:init(world, unit)
	self._world = world
	self._unit = unit
	self._damage = 0
	self._dead = false
	self._health = PlayerUnitDamageSettings.MAX_HP
	self._ai_base = ScriptUnit.extension(unit, "ai_system")
	self._ai_profile = self._ai_base:profile()

	self:setup_hit_zones()
end

function AIUnitDamage:setup_hit_zones()
	local actor_table = {}
	local unit = self._unit
	local hit_zones = PlayerUnitDamageSettings.hit_zones

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

function AIUnitDamage:network_recieve_add_damage_over_time(...)
	self:add_damage_over_time(...)
end

function AIUnitDamage:add_damage_over_time(...)
	return
end

function AIUnitDamage:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, actor, damage_range_type)
	self._damage = self._damage + damage

	if self._damage >= self._health and not self._dead then
		self:die(attacker_player)
	end

	local locomotion = self._ai_base:locomotion()
	local morale_states = self._ai_profile.morale.states
	local current_health = self:current_health()

	if current_health > morale_states.passive.value then
		locomotion.morale_state = "active"
	elseif current_health > morale_states.panic.value then
		locomotion.morale_state = "passive"
	else
		locomotion.morale_state = "panic"
	end

	if Unit.alive(attacker_unit) and ScriptUnit.has_extension(attacker_unit, "locomotion_system") then
		self._ai_base:alerted()

		self._ai_base:blackboard().players[attacker_unit] = true
	end
end

function AIUnitDamage:network_recieve_add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, damage_range_type)
	self:add_damage(attacker_player, attacker_unit, damage_type, damage, position, normal, nil, damage_range_type)
end

function AIUnitDamage:die(attacker_player)
	Managers.state.event:trigger("ai_unit_died", self._unit, attacker_player)
	self:player_dead()
	self._ai_base:player_dead()
end

function AIUnitDamage:player_dead()
	Unit.flow_event(self._unit, "lua_player_dead")

	self._dead = true
end

function AIUnitDamage:is_dead()
	return self._dead
end

function AIUnitDamage:is_knocked_down()
	return false
end

function AIUnitDamage:destroy()
	WeaponHelper:remove_projectiles(self._unit)
end

function AIUnitDamage:current_health()
	return self._health - self._damage
end
