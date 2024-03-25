-- chunkname: @scripts/managers/projectile/projectile_manager.lua

ProjectileManager = class(ProjectileManager)

local MAX_LINKED_PROJECTILES = 30
local MAX_PHYSICAL_PROJECTILES = 5

function ProjectileManager:init(world)
	self._world = world
	self._active_projectiles = {}
	self._linked_projectiles = {}
	self._linked_projectile_index = 1
	self._physical_projectiles = {}
	self._physical_projectile_index = 1
end

function ProjectileManager:destroy()
	for _, unit in pairs(self._linked_projectiles) do
		if unit and Unit.alive(unit) then
			self:_remove_projectile(unit)
		end
	end

	for _, unit in pairs(self._physical_projectiles) do
		if unit and Unit.alive(unit) then
			self:_remove_projectile(unit)
		end
	end
end

function ProjectileManager:update(dt, t)
	return
end

function ProjectileManager:remove_linked_projectile(unit)
	self:_remove_projectile(unit)
end

function ProjectileManager:remove_projectiles(owner)
	local network_manager = Managers.state.network
	local player_index = network_manager:temp_player_index(owner)
	local active_projectiles = self._active_projectiles[player_index]
	local replicate_remove = Managers.lobby.server and network_manager:game()

	if active_projectiles then
		for unit, ext in pairs(active_projectiles) do
			if replicate_remove then
				network_manager:send_rpc_clients("rpc_remove_projectiles", owner)
			end

			Managers.state.entity:unregister_unit(unit)
		end
	end

	self._active_projectiles[player_index] = nil
end

function ProjectileManager:spawn_projectile(player_index, user_unit, weapon_unit, projectile_name_id, gear_name_id, position, exit_velocity, gravity_multiplier, damage_multiplier, properties_id)
	local projectile_name = NetworkLookup.projectiles[projectile_name_id]
	local gear_name = NetworkLookup.inventory_gear[gear_name_id]
	local projectile_settings = WeaponHelper:attachment_settings(gear_name, "projectile_head", projectile_name)
	local rotation = Quaternion.look(exit_velocity, Vector3.up())
	local projectile_unit_name = projectile_settings.unit
	local unit = World.spawn_unit(self._world, projectile_unit_name, position, rotation)
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if game then
		network_manager:create_projectile_game_object(player_index, user_unit, weapon_unit, projectile_name_id, gear_name_id, position, exit_velocity, gravity_multiplier, damage_multiplier, properties_id, projectile_unit_name, unit)
	end

	player_index = network_manager:temp_player_index(player_index)
	self._active_projectiles[player_index] = self._active_projectiles[player_index] or {}

	Managers.state.entity:register_unit(self._world, unit, player_index, user_unit, weapon_unit, false, game, projectile_name, gear_name, exit_velocity, gravity_multiplier, damage_multiplier, properties_id)

	self._active_projectiles[player_index][unit] = ScriptUnit.extension(unit, "projectile_system")
end

function ProjectileManager:link_projectile(hit_unit, node_index, position, rotation, damage, penetrated, target_type, projectile_unit, local_projectile, hit_zone, impact_direction, normal)
	local network_manager = Managers.state.network

	if local_projectile and network_manager:game() then
		local level = LevelHelper:current_level(self._world)
		local hit_unit_index = Level.unit_index(level, hit_unit)
		local hit_unit_game_object_id = network_manager:game_object_id(hit_unit)
		local target_type_id = NetworkLookup.weapon_hit_parameters[target_type]
		local damage_constant = NetworkConstants.damage
		local network_damage = math.clamp(damage, damage_constant.min, damage_constant.max)

		if hit_unit_game_object_id then
			if Managers.lobby.server then
				network_manager:send_rpc_clients("rpc_link_projectile_obj_id", hit_unit_game_object_id, node_index, network_manager:game_object_id(projectile_unit), position, rotation, network_damage, penetrated, target_type_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, normal)
			else
				network_manager:send_rpc_server("rpc_link_projectile_obj_id", hit_unit_game_object_id, node_index, network_manager:game_object_id(projectile_unit), position, rotation, network_damage, penetrated, target_type_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, normal)
			end
		elseif hit_unit_index then
			if Managers.lobby.server then
				network_manager:send_rpc_clients("rpc_link_projectile_lvl_id", hit_unit_index, node_index, network_manager:game_object_id(projectile_unit), position, rotation, network_damage, penetrated, target_type_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, normal)
			else
				network_manager:send_rpc_server("rpc_link_projectile_lvl_id", hit_unit_index, node_index, network_manager:game_object_id(projectile_unit), position, rotation, network_damage, penetrated, target_type_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, normal)
			end
		else
			self:drop_projectile(hit_unit, position, rotation, damage, penetrated, target_type, projectile_unit, local_projectile, hit_zone, impact_direction, normal)

			return
		end
	end

	local projectile_extension = ScriptUnit.extension(projectile_unit, "projectile_system")
	local projectile_table = Unit.get_data(hit_unit, "linked_dummy_projectiles") or {}

	projectile_table[#projectile_table + 1] = projectile_unit

	Unit.set_data(hit_unit, "linked_dummy_projectiles", projectile_table)
	projectile_extension:link_projectile(hit_unit, node_index, position, rotation, damage, penetrated, target_type, hit_zone, impact_direction, normal)

	for _, projs in pairs(self._active_projectiles) do
		projs[projectile_unit] = nil
	end

	Managers.state.entity:unregister_unit(projectile_unit)

	local new_projectile_index = self._linked_projectile_index
	local existing_projectile = self._linked_projectiles[new_projectile_index]

	if Unit.alive(existing_projectile) then
		self:_remove_projectile(existing_projectile)
	end

	self._linked_projectiles[new_projectile_index] = projectile_unit
	self._linked_projectile_index = new_projectile_index % MAX_LINKED_PROJECTILES + 1
end

function ProjectileManager:clear_projectiles(from_unit)
	local projectile_table = Unit.get_data(from_unit, "linked_dummy_projectiles")

	if projectile_table then
		for _, unit in ipairs(projectile_table) do
			if Unit.alive(unit) then
				self:_remove_projectile(unit)
			end
		end

		Unit.set_data(from_unit, "linked_dummy_projectiles", nil)
	end
end

function ProjectileManager:_remove_projectile(unit)
	World.destroy_unit(self._world, unit)
end

function ProjectileManager:drop_projectile(hit_unit, position, rotation, damage, penetrated, target_type, projectile_unit, local_projectile, hit_zone, impact_direction, normal)
	local network_manager = Managers.state.network

	if local_projectile and network_manager:game() then
		local level = LevelHelper:current_level(self._world)
		local hit_unit_index = Level.unit_index(level, hit_unit)
		local hit_unit_game_object_id = network_manager:game_object_id(hit_unit)
		local target_type_id = NetworkLookup.weapon_hit_parameters[target_type]
		local damage_constant = NetworkConstants.damage
		local network_damage = math.clamp(damage, damage_constant.min, damage_constant.max)

		if hit_unit_game_object_id then
			if Managers.lobby.server then
				network_manager:send_rpc_clients("rpc_drop_projectile_obj_id", hit_unit_game_object_id, network_manager:game_object_id(projectile_unit), position, rotation, damage, penetrated, target_type_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, normal)
			else
				network_manager:send_rpc_server("rpc_drop_projectile_obj_id", hit_unit_game_object_id, network_manager:game_object_id(projectile_unit), position, rotation, damage, penetrated, target_type_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, normal)
			end
		elseif hit_unit_index then
			if Managers.lobby.server then
				network_manager:send_rpc_clients("rpc_drop_projectile_lvl_id", hit_unit_index, network_manager:game_object_id(projectile_unit), position, rotation, damage, penetrated, target_type_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, normal)
			else
				network_manager:send_rpc_server("rpc_drop_projectile_lvl_id", hit_unit_index, network_manager:game_object_id(projectile_unit), position, rotation, damage, penetrated, target_type_id, NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, normal)
			end
		end
	end

	local projectile_extension = ScriptUnit.extension(projectile_unit, "projectile_system")

	projectile_extension:drop_projectile(hit_unit, position, rotation, damage, penetrated, target_type, hit_zone, impact_direction, normal)

	for _, projs in pairs(self._active_projectiles) do
		projs[projectile_unit] = nil
	end

	Managers.state.entity:unregister_unit(projectile_unit)

	local new_projectile_index = self._physical_projectile_index
	local existing_projectile = self._physical_projectiles[new_projectile_index]

	if Unit.alive(existing_projectile) then
		self:_remove_projectile(existing_projectile)
	end

	self._physical_projectiles[new_projectile_index] = projectile_unit
	self._physical_projectile_index = new_projectile_index % MAX_LINKED_PROJECTILES + 1
end
