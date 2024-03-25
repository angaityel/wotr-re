-- chunkname: @scripts/unit_extensions/weapons/weapon_shield.lua

WeaponShield = WeaponShield or class()

function WeaponShield:init(world, unit, user_unit, player, id)
	self._world = world
	self._unit = unit
	self._user_unit = user_unit
	self._player = player
	self._game_object_id = id
	self._settings = Unit.get_data(unit, "settings")
	self._attacks = Unit.get_data(unit, "attacks")
	self._attacking = false
	self._sweep_collision = false
	self._current_attack = nil
	self._weapon_category = "shield"
end

function WeaponShield:update(dt, t)
	self:debug_draw_sweep_area()

	if self._sweep_collision then
		self:_update_sweep_collision(dt, self._current_attack.sweep)
	end
end

function WeaponShield:start_reload()
	return
end

function WeaponShield:can_wield()
	return true
end

function WeaponShield:category()
	return self._weapon_category
end

function WeaponShield:wield_finished_anim_name()
	return
end

function WeaponShield:set_wielded(wielded)
	return
end

function WeaponShield:start_attack(charge_time, attack_name, quick_swing, abort_attack_func)
	self._attacking = true
	self._current_attack = {
		last_attack_time = 0,
		charge_time = charge_time,
		attack_name = attack_name,
		abort_func = abort_attack_func,
		hits = {}
	}

	self:_activate_sweep_collision()
end

function WeaponShield:end_attack()
	self._attacking = false

	self:_deactivate_sweep_collision()

	local current_attack = self._current_attack

	self._current_attack = nil

	return current_attack.attack_name, false, next(current_attack.hits)
end

function WeaponShield:_activate_sweep_collision()
	self._sweep_collision = true

	local unit = self._unit
	local current_attack = self._current_attack
	local pos = Unit.world_position(unit, 0)
	local rot = Unit.world_rotation(unit, 0)
	local fwd = Quaternion.forward(rot)
	local up = Quaternion.up(rot)
	local right = Quaternion.right(rot)
	local attack_settings = self._settings.attacks[current_attack.attack_name].sweep
	local sweep_settings = {}

	current_attack.sweep = sweep_settings
	sweep_settings.inner_node = Unit.node(unit, attack_settings.inner_node)
	sweep_settings.outer_node = Unit.node(unit, attack_settings.outer_node)
	sweep_settings.width = attack_settings.width
	sweep_settings.thickness = attack_settings.thickness
	sweep_settings.hit_callback = "shield_bash_hit_cb"
	sweep_settings.height_offset = attack_settings.height_offset or 0
	sweep_settings.height_scale = attack_settings.height_scale or 1
	sweep_settings.width_offset = attack_settings.width_offset or 0

	local middle_local_pos = (Unit.local_position(unit, sweep_settings.inner_node) + Unit.local_position(unit, sweep_settings.outer_node)) * 0.5

	sweep_settings.last_pos = Vector3Box(pos + middle_local_pos.x * right + middle_local_pos.y * fwd + middle_local_pos.z * up)
end

function WeaponShield:_update_sweep_collision(dt, sweep_settings)
	local from_center = sweep_settings.last_pos:unbox()
	local to_center, weapon_extents, rot = self:_calculate_sweep_extents(sweep_settings)

	if Vector3.length(from_center - to_center) < SWEEP_DISTANCE_EPSILON then
		return
	end

	local physics_world = World.physics_world(self._world)
	local hits = PhysicsWorld.linear_obb_sweep(physics_world, from_center, to_center, weapon_extents, rot, 10, "types", "both", "collision_filter", "melee_trigger")

	if script_data.weapon_collision_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "weapon"
		})

		drawer:box_sweep(Matrix4x4.from_quaternion_position(rot, from_center), weapon_extents, to_center - from_center)
	end

	if hits then
		for _, hit in pairs(hits) do
			local actor = hit.actor
			local hit_unit = Actor.unit(actor)

			hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

			local normal = hit.normal
			local position = hit.position

			if self[sweep_settings.hit_callback](self, hit_unit, actor, normal, position) then
				return true
			end
		end
	end

	if false then
		-- block empty
	end

	sweep_settings.last_pos:store(to_center)
end

function WeaponShield:_calculate_sweep_extents(sweep_settings)
	local unit = self._unit
	local inner_pos = Unit.local_position(unit, sweep_settings.inner_node)
	local inner_rot = Unit.local_rotation(unit, sweep_settings.inner_node)
	local outer_pos = Unit.local_position(unit, sweep_settings.outer_node)
	local pos = Unit.world_position(unit, 0)
	local unit_rot = Unit.world_rotation(unit, 0)
	local middle_pos = (inner_pos + outer_pos) * 0.5
	local fwd = Quaternion.forward(unit_rot)
	local up = Quaternion.up(unit_rot)
	local right = Quaternion.right(unit_rot)
	local height = Vector3.dot(Quaternion.up(inner_rot), outer_pos - inner_pos) * sweep_settings.height_scale
	local to_center = pos + (sweep_settings.width_offset * sweep_settings.width + middle_pos.x) * right + middle_pos.y * fwd + (sweep_settings.height_offset * height + middle_pos.z) * up
	local weapon_extents = Vector3(sweep_settings.width, sweep_settings.thickness, height) / 2
	local rot = Quaternion.multiply(unit_rot, inner_rot)

	return to_center, weapon_extents, rot
end

function WeaponShield:_deactivate_sweep_collision()
	self._sweep_collision = false
end

function WeaponShield:_abort_attack(reason)
	local abort_func = self._current_attack.abort_func

	if abort_func then
		abort_func(reason)
	end
end

function WeaponShield:debug_draw_sweep_area()
	if script_data.weapon_collision_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "immediate",
			name = "weapon_immediate"
		})
		local unit = self._unit
		local epsilon = 0.002
		local total_epsilon = 0

		drawer:matrix4x4(Unit.world_pose(unit, 0), 0.2)

		for attack, color in pairs({
			shield_bash = Color(0, 255, 0)
		}) do
			script_data.attack_debug = self._attacks[attack]

			local attack_settings = self._attacks[attack]
			local sweep_data = attack_settings and attack_settings.sweep

			if sweep_data then
				local sweep_settings = {}

				sweep_settings.inner_node = Unit.node(unit, sweep_data.inner_node)
				sweep_settings.outer_node = Unit.node(unit, sweep_data.outer_node)
				sweep_settings.width = sweep_data.width
				sweep_settings.thickness = sweep_data.thickness
				sweep_settings.height_offset = sweep_data.height_offset or 0
				sweep_settings.height_scale = sweep_data.height_scale or 1
				sweep_settings.width_offset = sweep_data.width_offset or 0

				local to_center, weapon_extents, rot = self:_calculate_sweep_extents(sweep_settings)

				drawer:box(Matrix4x4.from_quaternion_position(rot, to_center), weapon_extents + Vector3(total_epsilon, total_epsilon, total_epsilon), color)

				total_epsilon = total_epsilon + epsilon
			end
		end
	end
end

function WeaponShield:shield_bash_hit_cb(hit_unit, actor, normal, position)
	if not hit_unit or not Unit.alive(hit_unit) or not self._attacking then
		return
	end

	local world = self._world
	local unit = self._unit
	local user_unit = self._user_unit
	local current_attack = self._current_attack

	if hit_unit == user_unit or Unit.get_data(hit_unit, "user_unit") == user_unit then
		return
	end

	local hit_zones = Unit.get_data(hit_unit, "hit_zone_lookup_table")
	local hit_zone_hit = hit_zones and hit_zones[actor] and hit_zones[actor].name

	normal = normal or Vector3(0, 1, 0)
	position = position or Vector3(0, 0, 0)

	local hard_hit
	local impact_direction = WeaponHelper:current_impact_direction(self._unit, current_attack.attack_name)

	if ScriptUnit.has_extension(hit_unit, "locomotion_system") then
		local victim_locomotion = ScriptUnit.extension(hit_unit, "locomotion_system")

		if victim_locomotion.parrying and self:_check_parry(user_unit, hit_unit) then
			hard_hit = true
		elseif victim_locomotion.blocking and self:_check_blocking(user_unit, hit_unit) then
			hard_hit = true
		else
			local actor = Unit.actor(hit_unit, "c_hips")

			hard_hit = self:_shield_bash_hit_character(hit_unit, position, normal, actor, hit_zone_hit, impact_direction)
		end
	elseif Unit.has_data(hit_unit, "gear_name") then
		local gear_settings = Gear[Unit.get_data(hit_unit, "gear_name")]
		local gear_user = Unit.get_data(hit_unit, "user_unit")

		if not Unit.alive(gear_user) then
			return
		end

		local gear_user_locomotion = ScriptUnit.extension(gear_user, "locomotion_system")

		if gear_user_locomotion.parrying and gear_user_locomotion.block_unit == hit_unit and self:_check_parry(user_unit, gear_user) then
			hard_hit = true
		elseif gear_user_locomotion.blocking and gear_user_locomotion.block_unit == hit_unit then
			hard_hit = true
		else
			return
		end
	elseif Unit.get_data(hit_unit, "health") then
		hard_hit = WeaponHelper:perk_attack_hit_damagable_prop(world, user_unit, unit, hit_unit, position, normal, actor, current_attack, impact_direction)
	else
		hard_hit = WeaponHelper:perk_attack_hit_non_damagable_prop(world, self._user_unit, unit, hit_unit, position, normal, actor, current_attack, impact_direction, self._properties)
	end

	local hard = hard_hit and "hard" or "soft"

	self:_abort_attack(hard)

	return hard_hit
end

function WeaponShield:_shield_bash_hit_character(hit_unit, position, normal, actor, hit_zone, impact_direction)
	local current_attack = self._current_attack
	local network_manager = Managers.state.network
	local game = network_manager:game()
	local world = self._world
	local unit = self._unit
	local user_unit = self._user_unit
	local raw_damage, damage_type, damage, damage_range_type, penetrated = WeaponHelper:add_perk_attack_damage(world, user_unit, unit, hit_unit, position, normal, actor, hit_zone, false, current_attack, impact_direction)

	if game and self._game_object_id then
		damage = math.clamp(damage, NetworkConstants.damage.min, NetworkConstants.damage.max)
	end

	if raw_damage then
		WeaponHelper:apply_damage(world, user_unit, unit, hit_unit, position, normal, actor, damage_type, damage, damage_range_type, raw_damage, current_attack, hit_zone, impact_direction)
	end

	WeaponHelper:shield_impact_character(hit_unit, damage, position, normal, world, hit_zone, impact_direction)

	if game and self._game_object_id then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_shield_impact_character", self._game_object_id, network_manager:game_object_id(hit_unit), damage, position, normal, NetworkLookup.hit_zones[hit_zone], impact_direction)
		else
			network_manager:send_rpc_server("rpc_shield_impact_character", self._game_object_id, network_manager:game_object_id(hit_unit), damage, position, normal, NetworkLookup.hit_zones[hit_zone], impact_direction)
		end
	end

	return false
end

function WeaponShield:hot_join_synch(sender, player, player_object_id, slot_name)
	return
end

function WeaponShield:enter_ghost_mode()
	self._ghost_mode = true
end

function WeaponShield:exit_ghost_mode()
	self._ghost_mode = false
end

function WeaponShield:destroy()
	return
end

WeaponShield._check_parry = WeaponOneHanded._check_parry
WeaponShield._check_blocking = WeaponOneHanded._check_blocking
