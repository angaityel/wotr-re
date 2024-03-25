-- chunkname: @scripts/unit_extensions/weapons/weapon_one_handed.lua

require("scripts/helpers/weapon_helper")

WeaponOneHanded = WeaponOneHanded or class()
SWEEP_DISTANCE_EPSILON = 0.001

function WeaponOneHanded:init(world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)
	self._world = world
	self._unit = unit
	self._user_unit = user_unit
	self._player = player
	self._game_object_id = id
	self._settings = Unit.get_data(unit, "settings")
	self._attacks = Unit.get_data(unit, "attacks")
	self._current_attack = nil
	self._attacking = false
	self._ai_gear = ai_gear
	self._attachments = attachments
	self._attachment_multipliers = attachment_multipliers
	self._properties = properties

	Unit.set_data(unit, "extension", self)

	self._weapon_category = "melee"
	self._pose_blackboard = nil
	self._hit_characters = 0
	self._collision_actors = {
		Unit.actor(unit, "hit_collision"),
		Unit.actor(unit, "non_damage_hit_collision")
	}

	self:_disable_hit_collision()
end

function WeaponOneHanded:category()
	return self._weapon_category
end

function WeaponOneHanded:set_wielded(wielded)
	if not wielded and self._attacking then
		self:end_attack()
	end
end

function WeaponOneHanded:_enable_hit_collision()
	for _, actor in ipairs(self._collision_actors) do
		Actor.set_collision_enabled(actor, true)
	end
end

function WeaponOneHanded:_disable_hit_collision()
	for _, actor in ipairs(self._collision_actors) do
		Actor.set_collision_enabled(actor, false)
	end
end

function WeaponOneHanded:update(dt, t)
	if self._attacking then
		local current_attack = self._current_attack
		local new_time = current_attack.attack_time + dt

		if script_data.damage_debug then
			local attack_name = current_attack.attack_name
			local attack_settings = self._attacks[attack_name]
			local abort_time_factor = attack_settings.abort_time_factor
			local abort_time = current_attack.attack_duration * abort_time_factor

			if abort_time > current_attack.attack_time and abort_time <= new_time then
				local unit = self._unit
				local drawer = Managers.state.debug:drawer({
					mode = "retained",
					name = "DEBUG_DRAW_WEAPON_VELOCITY" .. tostring(unit)
				})
				local position = Unit.world_position(unit, 0)
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

					local to_center, _, _ = self:_calculate_sweep_extents(sweep_settings)

					position = to_center
				end

				drawer:sphere(position, 0.05, Color(0, 255, 0))
			end
		end

		current_attack.last_attack_time = current_attack.attack_time
		current_attack.attack_time = new_time

		if script_data.damage_debug or script_data.weapon_velocity_debug then
			self:_debug_draw_weapon_velocity()
		end
	elseif self._posing then
		self:update_pose(dt, t)
	end

	self:debug_draw_sweep_area()

	if self._sweep_collision then
		local current_attack = self._current_attack
		local hit_hard_target = self:_update_sweep_collision(dt, current_attack.sweep, current_attack)
		local non_damage_sweep = current_attack.non_damage_sweep

		if not hit_hard_target and non_damage_sweep then
			self:_update_sweep_collision(dt, non_damage_sweep, current_attack)
		end
	end
end

function WeaponOneHanded:can_wield()
	return true
end

function WeaponOneHanded:wield_finished_anim_name()
	return nil
end

function WeaponOneHanded:start_attack(charge_time, swing_direction, quick_swing, abort_attack_func, attack_duration)
	self._attacking = true
	self._current_attack = {
		last_attack_time = 0,
		attack_time = 0,
		attack_duration = attack_duration,
		charge_time = charge_time,
		attack_name = swing_direction,
		quick_swing = quick_swing,
		abort_func = abort_attack_func,
		hits = {}
	}

	if quick_swing then
		Unit.set_flow_variable(self._unit, "swing_time", attack_duration)
		Unit.flow_event(self._unit, "lua_attack_started_quick_" .. swing_direction)
	else
		Unit.set_flow_variable(self._unit, "swing_time", attack_duration)
		Unit.flow_event(self._unit, "lua_attack_started_" .. swing_direction)
	end

	if self._settings.sweep_collision then
		self:_activate_sweep_collision()
	else
		self:_enable_hit_collision()
	end
end

function WeaponOneHanded:end_attack()
	if self._hit_characters == 0 then
		local gear_name = Unit.get_data(self._unit, "gear_name")

		Managers.state.stats_collector:weapon_missed(self._player, gear_name)
	end

	self._attacking = false
	self._hit_characters = 0

	if self._settings.sweep_collision then
		self:_deactivate_sweep_collision()
	else
		self:_disable_hit_collision()
	end

	local current_attack = self._current_attack

	self._current_attack = nil

	local swing_direction = current_attack.attack_name
	local quick_swing = current_attack.quick_swing

	Unit.flow_event(self._unit, "lua_attack_ended_" .. swing_direction)

	return swing_direction, quick_swing, next(current_attack.hits)
end

function WeaponOneHanded:_activate_sweep_collision()
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
	sweep_settings.hit_callback = current_attack.attack_name == "push" and "push_hit_cb" or "hit_cb"
	sweep_settings.delay = attack_settings.delay or 0
	sweep_settings.height_offset = attack_settings.height_offset or 0
	sweep_settings.height_scale = attack_settings.height_scale or 1
	sweep_settings.width_offset = attack_settings.width_offset or 0

	local middle_local_pos = (Unit.local_position(unit, sweep_settings.inner_node) + Unit.local_position(unit, sweep_settings.outer_node)) * 0.5

	sweep_settings.last_pos = Vector3Box(pos + middle_local_pos.x * right + middle_local_pos.y * fwd + middle_local_pos.z * up)

	local non_damage_attack_settings = self._settings.attacks[current_attack.attack_name].non_damage_sweep

	if non_damage_attack_settings then
		local non_damage_sweep_settings = {}

		current_attack.non_damage_sweep = non_damage_sweep_settings
		non_damage_sweep_settings.inner_node = Unit.node(unit, non_damage_attack_settings.inner_node)
		non_damage_sweep_settings.outer_node = Unit.node(unit, non_damage_attack_settings.outer_node)
		non_damage_sweep_settings.width = non_damage_attack_settings.width
		non_damage_sweep_settings.thickness = non_damage_attack_settings.thickness
		non_damage_sweep_settings.hit_callback = "non_damage_hit_cb"
		non_damage_sweep_settings.delay = non_damage_attack_settings.delay or 0
		non_damage_sweep_settings.height_offset = non_damage_attack_settings.height_offset or 0
		non_damage_sweep_settings.height_scale = non_damage_attack_settings.height_scale or 1
		non_damage_sweep_settings.width_offset = non_damage_attack_settings.width_offset or 0

		local non_damage_middle_local_pos = (Unit.local_position(unit, non_damage_sweep_settings.inner_node) + Unit.local_position(unit, non_damage_sweep_settings.outer_node)) * 0.5

		non_damage_sweep_settings.last_pos = Vector3Box(pos + non_damage_middle_local_pos.x * right + non_damage_middle_local_pos.y * fwd + non_damage_middle_local_pos.z * up)
	end
end

function WeaponOneHanded:_calculate_sweep_extents(sweep_settings)
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

	return to_center, weapon_extents, rot, pos + outer_pos.x * right + outer_pos.y * fwd + outer_pos.z * up
end

function WeaponOneHanded:debug_draw_sweep_area()
	if script_data.weapon_collision_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "immediate",
			name = "weapon_immediate"
		})
		local unit = self._unit
		local epsilon = 0.002
		local total_epsilon = 0

		drawer:matrix4x4(Unit.world_pose(unit, 0), 0.2)
		Managers.state.debug_text:output_screen_text("up = red, down = green, left = blue, right = yellow, couch = magenta", 40, 0, Vector3(255, 255, 255))

		for attack, color in pairs({
			up = Color(255, 0, 0),
			down = Color(0, 255, 0),
			left = Color(0, 0, 255),
			right = Color(255, 255, 0),
			couch = Color(255, 0, 255)
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

			local non_damage_sweep = attack_settings and attack_settings.non_damage_sweep

			if non_damage_sweep then
				local sweep_settings = {}

				sweep_settings.inner_node = Unit.node(unit, non_damage_sweep.inner_node)
				sweep_settings.outer_node = Unit.node(unit, non_damage_sweep.outer_node)
				sweep_settings.width = non_damage_sweep.width
				sweep_settings.thickness = non_damage_sweep.thickness
				sweep_settings.height_offset = non_damage_sweep.height_offset or 0
				sweep_settings.height_scale = non_damage_sweep.height_scale or 1
				sweep_settings.width_offset = non_damage_sweep.width_offset or 0

				local to_center, weapon_extents, rot = self:_calculate_sweep_extents(sweep_settings)

				drawer:box(Matrix4x4.from_quaternion_position(rot, to_center), weapon_extents + Vector3(total_epsilon, total_epsilon, total_epsilon), color)

				total_epsilon = total_epsilon + epsilon
			end
		end
	end
end

function WeaponOneHanded:_update_sweep_collision(dt, sweep_settings, current_attack)
	local from_center = sweep_settings.last_pos:unbox()
	local to_center, weapon_extents, rot, outer_pos2 = self:_calculate_sweep_extents(sweep_settings)

	if sweep_settings.delay > current_attack.attack_time / current_attack.attack_duration then
		sweep_settings.last_pos:store(to_center)

		return
	end

	if Vector3.length(from_center - to_center) < SWEEP_DISTANCE_EPSILON then
		return
	end

	local hits = {}
	local physics_world = World.physics_world(self._world)
	local outer_pos1 = outer_pos2 - to_center + from_center

	if sweep_settings.last_outer_pos then
		local last_outer_pos = sweep_settings.last_outer_pos:unbox()
		local sweep_dir = outer_pos1 - last_outer_pos
		local dir_to_from_center = from_center - last_outer_pos
		local plane_normal = Vector3.cross(dir_to_from_center, sweep_dir)
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "weapon"
		})
		local sweep_height_dir = Vector3.normalize(Vector3.cross(sweep_dir, plane_normal))
		local half_height = Vector3.dot(sweep_height_dir, dir_to_from_center) / 2
		local sweep_extents = Vector3(sweep_settings.thickness * 0.5, 0.001, half_height)
		local from = last_outer_pos + sweep_height_dir * half_height
		local to = outer_pos1 + sweep_height_dir * half_height
		local rotation = Quaternion.look(Vector3.normalize(sweep_dir), sweep_height_dir)

		if Vector3.length(from - to) > SWEEP_DISTANCE_EPSILON then
			hits = PhysicsWorld.linear_obb_sweep(physics_world, from, to, sweep_extents, rotation, 10, "types", "both", "collision_filter", "melee_trigger") or hits

			if script_data.weapon_collision_debug then
				local drawer = Managers.state.debug:drawer({
					mode = "retained",
					name = "weapon"
				})

				drawer:box_sweep(Matrix4x4.from_quaternion_position(rotation, from), sweep_extents, to - from)
			end
		end
	end

	sweep_settings.last_outer_pos = Vector3Box(outer_pos2)

	local from_bottom = from_center - Quaternion.up(rot) * weapon_extents.z
	local from_top = from_center + Quaternion.up(rot) * weapon_extents.z
	local from_extents = Vector3(weapon_extents.x, weapon_extents.y, 0.01)

	if Vector3.length(from_bottom - from_top) > SWEEP_DISTANCE_EPSILON then
		local new_hits = PhysicsWorld.linear_obb_sweep(physics_world, from_bottom, from_top, from_extents, rot, 10, "types", "both", "collision_filter", "melee_trigger")

		if script_data.weapon_collision_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "weapon"
			})

			drawer:box_sweep(Matrix4x4.from_quaternion_position(rot, from_bottom), from_extents, from_top - from_bottom)
		end

		if script_data.weapon_collision_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "weapon"
			})

			drawer:sphere(from_bottom, 0.01, Color(0, 0, 255))
			drawer:sphere(from_top, 0.01, Color(0, 255, 255))
		end

		if new_hits then
			for _, hit in ipairs(new_hits) do
				hits[#hits + 1] = hit
			end
		end
	end

	local new_hits = PhysicsWorld.linear_obb_sweep(physics_world, from_center, to_center, weapon_extents, rot, 10, "types", "both", "collision_filter", "melee_trigger")

	if new_hits then
		for _, hit in ipairs(new_hits) do
			hits[#hits + 1] = hit
		end
	end

	if script_data.weapon_collision_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "weapon"
		})

		drawer:box_sweep(Matrix4x4.from_quaternion_position(rot, from_center), weapon_extents, to_center - from_center)
	end

	if script_data.damage_debug then
		local player_root_pos = Unit.world_position(self._user_unit, 0)
		local sweep_outer_node_pos = Unit.world_position(self._unit, sweep_settings.outer_node)
		local distance_vector = Vector3.flat(sweep_outer_node_pos - player_root_pos)
		local camera_rotation = Managers.state.camera:camera_rotation(Managers.player:player(1).viewport_name)
		local camera_fwd_flat = Vector3.normalize(Vector3.flat(Quaternion.forward(camera_rotation)))
		local current_range_forward = Vector3.dot(camera_fwd_flat, distance_vector)
		local current_range = Vector3.length(distance_vector)

		sweep_settings.max_range = math.max(sweep_settings.max_range or 0, current_range)
		sweep_settings.max_range_forward = math.max(sweep_settings.max_range_forward or 0, current_range_forward)

		Managers.state.debug_text:output_screen_text(string.format("RANGE: max: %.2f current: %.2f max fwd: %.2f current fwd: %.2f", sweep_settings.max_range, current_range, sweep_settings.max_range_forward, current_range_forward), 30, 3, Vector3(255, 255, 255))
	end

	if hits then
		local sweep_vector = to_center - from_center
		local sweep_direction = Vector3.normalize(sweep_vector)
		local sweep_length = Vector3.length(sweep_vector)

		for _, hit in ipairs(hits) do
			local hit_unit = Actor.unit(hit.actor)
			local actor = hit.actor
			local normal = hit.normal
			local position = hit.position

			if script_data.weapon_collision_debug then
				local drawer = Managers.state.debug:drawer({
					mode = "retained",
					name = "weapon_hit"
				})

				drawer:sphere(position, 0.02, Color(255, 0, 0))
			end

			local sweep_t = math.clamp(Vector3.dot(position - from_center, sweep_direction) / sweep_length, 0, 1)
			local attack_time = math.lerp(current_attack.last_attack_time, current_attack.attack_time, sweep_t)

			if self[sweep_settings.hit_callback](self, hit_unit, actor, normal, position, nil, false, attack_time) then
				return true
			end
		end
	end

	if false then
		-- block empty
	end

	sweep_settings.last_pos:store(to_center)
end

function WeaponOneHanded:_deactivate_sweep_collision()
	self._sweep_collision = false
end

function WeaponOneHanded:_abort_attack(reason)
	local abort_func = self._current_attack.abort_func

	if abort_func then
		abort_func(reason)
	end
end

function WeaponOneHanded:non_damage_hit_cb(hit_unit, actor, normal, position, self_actor, couching, interpolated_attack_time)
	if not hit_unit or not Unit.alive(hit_unit) or not self._attacking and not couching then
		return
	end

	local unit = self._unit
	local user_unit = self._user_unit
	local current_attack = self._current_attack

	hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

	if hit_unit == user_unit or Unit.get_data(hit_unit, "user_unit") == user_unit or self._current_attack.hits[hit_unit] then
		return
	end

	local hard_hit
	local impact_direction = WeaponHelper:current_impact_direction(self._unit, current_attack.attack_name)

	if ScriptUnit.has_extension(hit_unit, "locomotion_system") then
		local hit_zones = Unit.get_data(hit_unit, "hit_zone_lookup_table")
		local hit_zone_hit = hit_zones and hit_zones[actor] and hit_zones[actor].name

		if hit_zone_hit == "arms" or hit_zone_hit == "hands" then
			return
		end

		local victim_locomotion = ScriptUnit.extension(hit_unit, "locomotion_system")

		if victim_locomotion.parrying and self:_check_parry(user_unit, hit_unit) then
			hard_hit = self:_hit_parrying_gear(hit_unit, victim_locomotion.block_unit, position, normal, actor, impact_direction, interpolated_attack_time, true)
		elseif victim_locomotion.blocking and self:_check_blocking(user_unit, hit_unit) then
			hard_hit = self:_hit_blocking_gear(hit_unit, victim_locomotion.block_unit, position, normal, actor, impact_direction, interpolated_attack_time, true)
		else
			WeaponHelper:non_damage_hit_sound_event(self._world, unit, hit_unit)
			self:_abort_attack("hard")

			hard_hit = true
		end
	elseif Unit.has_data(hit_unit, "gear_name") then
		local gear_settings = Gear[Unit.get_data(hit_unit, "gear_name")]
		local gear_user = Unit.get_data(hit_unit, "user_unit")

		if not Unit.alive(gear_user) then
			return
		end

		local gear_user_locomotion = ScriptUnit.extension(gear_user, "locomotion_system")

		if gear_user_locomotion.parrying and gear_user_locomotion.block_unit == hit_unit and self:_check_parry(user_unit, gear_user) then
			hard_hit = self:_hit_parrying_gear(gear_user, gear_user_locomotion.block_unit, position, normal, actor, impact_direction, interpolated_attack_time, true)
		elseif gear_user_locomotion.blocking and gear_user_locomotion.block_unit == hit_unit then
			hard_hit = self:_hit_blocking_gear(gear_user, gear_user_locomotion.block_unit, position, normal, actor, impact_direction, interpolated_attack_time, true)
		end
	else
		local material_effects_name = "melee_hit_" .. WeaponHelper:shaft_damage_type(unit)
		local impact_direction = WeaponHelper:current_impact_direction(unit, current_attack.attack_name)
		local impact_rotation = Quaternion.look(impact_direction, Quaternion.up(Unit.world_rotation(unit, 0)))

		EffectHelper.play_surface_material_effects(material_effects_name, self._world, hit_unit, position, impact_rotation, normal)

		if Managers.state.network:game() then
			EffectHelper.remote_play_surface_material_effects(material_effects_name, self._world, hit_unit, position, impact_rotation, normal)
		end

		self:_abort_attack("hard")

		hard_hit = true
	end

	return hard_hit
end

function WeaponOneHanded:hit_cb(hit_unit, actor, normal, position, self_actor, couching, interpolated_attack_time)
	if not hit_unit or not Unit.alive(hit_unit) or not self._attacking and not couching then
		return
	end

	local unit = self._unit
	local user_unit = self._user_unit
	local current_attack = self._current_attack

	hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

	if hit_unit == user_unit or Unit.get_data(hit_unit, "user_unit") == user_unit then
		return
	end

	local hit_zones = Unit.get_data(hit_unit, "hit_zone_lookup_table")
	local hit_zone_hit = hit_zones and hit_zones[actor] and hit_zones[actor].name
	local hits_to_unit = current_attack.hits[hit_unit]
	local no_hit_zones_and_first_hit = not hit_zones and not hits_to_unit
	local has_hit_zones_and_zone_hit = hit_zones and hit_zone_hit
	local unit_previously_hit_in_zone = hits_to_unit and (hits_to_unit.hit_zones[hit_zone_hit] or self._settings.attacks[self._current_attack.attack_name].only_hit_once)
	local hit_zone_not_hit = no_hit_zones_and_first_hit or has_hit_zones_and_zone_hit and not unit_previously_hit_in_zone

	if not hit_zone_not_hit then
		return
	end

	normal = normal or Vector3(0, 1, 0)
	position = position or Vector3(0, 0, 0)

	local hard_hit
	local impact_direction = WeaponHelper:current_impact_direction(self._unit, current_attack.attack_name)

	if ScriptUnit.has_extension(hit_unit, "locomotion_system") then
		local victim_locomotion = ScriptUnit.extension(hit_unit, "locomotion_system")

		if victim_locomotion.parrying and self:_check_parry(user_unit, hit_unit) then
			hard_hit = self:_hit_parrying_gear(hit_unit, victim_locomotion.block_unit, position, normal, actor, impact_direction, interpolated_attack_time)
		elseif victim_locomotion.blocking and self:_check_blocking(user_unit, hit_unit) then
			hard_hit = self:_hit_blocking_gear(hit_unit, victim_locomotion.block_unit, position, normal, actor, impact_direction, interpolated_attack_time)
		else
			hard_hit = self:_hit_character(hit_unit, position, normal, actor, hit_zone_hit, impact_direction, interpolated_attack_time)
		end
	elseif Unit.has_data(hit_unit, "gear_name") then
		local gear_settings = Gear[Unit.get_data(hit_unit, "gear_name")]
		local gear_user = Unit.get_data(hit_unit, "user_unit")

		if not Unit.alive(gear_user) then
			return
		end

		local gear_user_locomotion = ScriptUnit.extension(gear_user, "locomotion_system")

		if gear_user_locomotion.parrying and gear_user_locomotion.block_unit == hit_unit and self:_check_parry(user_unit, gear_user, not hits_to_unit) then
			hard_hit = self:_hit_parrying_gear(gear_user, gear_user_locomotion.block_unit, position, normal, actor, impact_direction, interpolated_attack_time)
		elseif gear_user_locomotion.blocking and gear_user_locomotion.block_unit == hit_unit then
			hard_hit = self:_hit_blocking_gear(gear_user, gear_user_locomotion.block_unit, position, normal, actor, impact_direction, interpolated_attack_time)
		end
	elseif Unit.get_data(hit_unit, "health") then
		hard_hit = self:_hit_damagable_prop(hit_unit, position, normal, actor, impact_direction, interpolated_attack_time)
	else
		hard_hit = self:_hit_non_damagable_prop(hit_unit, position, normal, actor, impact_direction, interpolated_attack_time)
	end

	return hard_hit
end

function WeaponOneHanded:push_hit_cb(hit_unit, actor, normal, position, self_actor, couching)
	if not hit_unit or not Unit.alive(hit_unit) or not self._attacking then
		return
	end

	local world = self._world
	local unit = self._unit
	local user_unit = self._user_unit
	local current_attack = self._current_attack

	hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

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

			hard_hit = self:_push_hit_character(hit_unit, position, normal, actor, hit_zone_hit, impact_direction)
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

function WeaponOneHanded:_check_parry(attacker_unit, victim_unit, not_previously_hit)
	local victim_locomotion = ScriptUnit.extension(victim_unit, "locomotion_system")
	local attack_settings = self._settings.attacks[self._current_attack.attack_name]

	if not Unit.alive(victim_locomotion.block_unit) then
		return false
	end

	if victim_locomotion.block_raised_time > Managers.time:time("game") then
		return false
	end

	if not_previously_hit and (attack_settings.parry_direction == "left" or attack_settings.parry_direction == "right") and (victim_locomotion.block_direction == "left" or victim_locomotion.block_direction == "right") then
		return true
	end

	if victim_locomotion.block_direction ~= attack_settings.parry_direction then
		return false
	end

	local attacker_locomotion = ScriptUnit.extension(attacker_unit, "locomotion_system")
	local attacker_aim = attacker_locomotion:aim_direction()
	local victim_aim = victim_locomotion:aim_direction()
	local attacker_aim_flat = Vector3(attacker_aim.x, attacker_aim.y, 0)
	local victim_aim_flat = Vector3(victim_aim.x, victim_aim.y, 0)
	local dot = Vector3.dot(attacker_aim_flat, victim_aim_flat)

	return dot < 0
end

function WeaponOneHanded:_check_blocking(attacker_unit, victim_unit)
	local victim_locomotion = ScriptUnit.extension(victim_unit, "locomotion_system")

	if not Unit.alive(victim_locomotion.block_unit) then
		return false
	end

	local attacker_locomotion = ScriptUnit.extension(attacker_unit, "locomotion_system")
	local attacker_aim = attacker_locomotion:aim_direction()
	local victim_aim = victim_locomotion:aim_direction()
	local attacker_aim_flat = Vector3.flat(attacker_aim)
	local victim_aim_flat = Vector3.flat(victim_aim)
	local dot = Vector3.dot(attacker_aim_flat, victim_aim_flat)

	return dot < 0
end

function WeaponOneHanded:_target_type(hit_unit, current_attack)
	local target_type
	local abort = false

	if not current_attack.hits[hit_unit].penetrated then
		target_type = "not_penetrated"
		abort = true

		self:_abort_attack(target_type)
	elseif Unit.get_data(hit_unit, "soft_target") then
		target_type = "soft"
	else
		target_type = "hard"
		abort = true

		self:_abort_attack(target_type)
	end

	return target_type, abort
end

function WeaponOneHanded:_hit_character(hit_unit, position, normal, actor, hit_zone, impact_direction, interpolated_attack_time)
	local current_attack = self._current_attack
	local attack_name = current_attack.attack_name
	local settings = self._settings
	local network_manager = Managers.state.network
	local game = network_manager:game()
	local stun = false
	local raw_damage, damage_type, damage, damage_range_type, real_damage = self:_add_damage(hit_unit, position, normal, actor, hit_zone, false, current_attack, impact_direction, nil, interpolated_attack_time)
	local target_type, abort = self:_target_type(hit_unit, current_attack)
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")

	if raw_damage then
		local attack_data_for_victim = current_attack.hits[hit_unit]
		local player_manager = Managers.player
		local hit_player = player_manager:owner(hit_unit)
		local own_player = self._player
		local interrupt = true

		if hit_player and own_player and hit_player.team == own_player.team then
			stun = false
			interrupt = false
		elseif (settings.properties.stun or table.contains(self._properties, "stun")) and PlayerUnitDamageSettings.stun.damage_types_with_stun_property[damage_type] then
			stun = not attack_data_for_victim.stun and self:_fully_charged_attack(current_attack)
		elseif PlayerUnitDamageSettings.stun.damage_types_without_stun_property[damage_type] then
			stun = not attack_data_for_victim.stun and raw_damage > PlayerUnitDamageSettings.stun.damage_threshold
		elseif self:_valid_hamstring_attack(hit_unit, impact_direction, hit_zone, current_attack) then
			stun = not attack_data_for_victim.stun
		end

		if stun then
			attack_data_for_victim.stun = true
		end

		local weapon_damage_direction = settings.attacks[attack_name].forward_direction:unbox()

		WeaponHelper:weapon_impact_character(hit_unit, self._unit, target_type, attack_name, stun, damage, raw_damage, position, normal, self._world, hit_zone, impact_direction, weapon_damage_direction)

		if game then
			local hit_unit_game_object_id = network_manager:game_object_id(hit_unit)
			local self_gear_game_object_id = network_manager:game_object_id(self._unit)
			local direction_id = NetworkLookup.weapon_hit_parameters[attack_name]
			local target_type_id = NetworkLookup.weapon_hit_parameters[target_type]

			damage = math.clamp(damage, NetworkConstants.damage.min, NetworkConstants.damage.max)
			raw_damage = math.clamp(raw_damage, NetworkConstants.damage.min, NetworkConstants.damage.max)

			if position and normal then
				if Managers.lobby.server then
					network_manager:send_rpc_clients("rpc_weapon_impact_character", hit_unit_game_object_id, self_gear_game_object_id, target_type_id, direction_id, stun, damage, raw_damage, NetworkLookup.hit_zones[hit_zone] or 0, position, normal, impact_direction, weapon_damage_direction)
				else
					network_manager:send_rpc_server("rpc_weapon_impact_character", hit_unit_game_object_id, self_gear_game_object_id, target_type_id, direction_id, stun, damage, raw_damage, NetworkLookup.hit_zones[hit_zone] or 0, position, normal, impact_direction, weapon_damage_direction)
				end
			elseif Managers.lobby.server then
				network_manager:send_rpc_clients("rpc_wpn_impact_char_no_pos_norm", hit_unit_game_object_id, self_gear_game_object_id, target_type_id, direction_id, stun, damage, raw_damage, NetworkLookup.hit_zones[hit_zone] or 0, impact_direction)
			else
				network_manager:send_rpc_server("rpc_wpn_impact_char_no_pos_norm", hit_unit_game_object_id, self_gear_game_object_id, target_type_id, direction_id, stun, damage, raw_damage, NetworkLookup.hit_zones[hit_zone] or 0, impact_direction)
			end
		end

		WeaponHelper:apply_damage(self._world, self._user_unit, self._unit, hit_unit, position, normal, actor, damage_type, damage, damage_range_type, raw_damage, current_attack, hit_zone, impact_direction, self._properties, real_damage)
	end

	return abort
end

function WeaponOneHanded:_fully_charged_attack(current_attack)
	local attack_name = current_attack.attack_name
	local attack_settings = self._settings.attacks[attack_name]

	return attack_name == "couch" or current_attack.charge_time >= attack_settings.charge_time * 0.95
end

function WeaponOneHanded:_push_hit_character(hit_unit, position, normal, actor, hit_zone, impact_direction)
	local current_attack = self._current_attack
	local network_manager = Managers.state.network
	local game = network_manager:game()
	local world = self._world
	local unit = self._unit
	local user_unit = self._user_unit
	local raw_damage, damage_type, damage, damage_range_type, penetrated = WeaponHelper:add_perk_attack_damage(world, user_unit, unit, hit_unit, position, normal, actor, hit_zone, false, current_attack, impact_direction)

	damage = math.clamp(damage, NetworkConstants.damage.min, NetworkConstants.damage.max)

	if raw_damage then
		WeaponHelper:apply_damage(world, user_unit, unit, hit_unit, position, normal, actor, damage_type, damage, damage_range_type, raw_damage, current_attack, hit_zone, impact_direction)
	end

	WeaponHelper:push_impact_character(hit_unit, damage, position, normal, world, hit_zone, impact_direction)

	if game and self._game_object_id then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_push_impact_character", self._game_object_id, network_manager:game_object_id(hit_unit), damage, position, normal, NetworkLookup.hit_zones[hit_zone], impact_direction)
		else
			network_manager:send_rpc_server("rpc_push_impact_character", self._game_object_id, network_manager:game_object_id(hit_unit), damage, position, normal, NetworkLookup.hit_zones[hit_zone], impact_direction)
		end
	end

	return false
end

function WeaponOneHanded:_hit_parrying_gear(gear_owner, hit_gear, position, normal, actor, impact_direction, interpolated_attack_time, no_damage)
	local target_type = "parrying"
	local current_attack = self._current_attack
	local attack_name = current_attack.attack_name
	local attack_settings = self._settings.attacks[attack_name]
	local fully_charged_attack = self:_fully_charged_attack(current_attack)
	local parry_direction = attack_settings.parry_direction

	self:_abort_attack(target_type)

	local raw_damage, damage_type, damage, damage_range_type = self:_add_damage(hit_gear, position, normal, actor, nil, false, current_attack, impact_direction, nil, interpolated_attack_time)

	if raw_damage then
		WeaponHelper:gear_impact(hit_gear, self._unit, target_type, parry_direction, damage, raw_damage, position, normal, self._world, fully_charged_attack)

		local network_manager = Managers.state.network
		local game = network_manager:game()

		if game then
			local direction_id = NetworkLookup.weapon_hit_parameters[parry_direction]
			local target_type_id = NetworkLookup.weapon_hit_parameters[target_type]
			local hit_gear_game_object_id = network_manager:game_object_id(hit_gear)
			local self_gear_game_object_id = network_manager:game_object_id(self._unit)

			damage = math.clamp(damage, NetworkConstants.damage.min, NetworkConstants.damage.max)
			raw_damage = math.clamp(raw_damage, NetworkConstants.damage.min, NetworkConstants.damage.max)

			if Managers.lobby.server then
				network_manager:send_rpc_clients("rpc_weapon_impact_gear", hit_gear_game_object_id, self_gear_game_object_id, target_type_id, direction_id, damage, raw_damage, fully_charged_attack, position, normal)
			else
				network_manager:send_rpc_server("rpc_weapon_impact_gear", hit_gear_game_object_id, self_gear_game_object_id, target_type_id, direction_id, damage, raw_damage, fully_charged_attack, position, normal)
			end
		end

		if not no_damage then
			WeaponHelper:apply_damage(self._world, self._user_unit, self._unit, hit_gear, position, normal, actor, damage_type, damage, damage_range_type, raw_damage, current_attack, nil, impact_direction, self._properties)
		end
	end

	return true
end

function WeaponOneHanded:_hit_blocking_gear(gear_owner, hit_gear, position, normal, actor, impact_direction, interpolated_attack_time, no_damage)
	local target_type = "blocking"
	local current_attack = self._current_attack
	local attack_name = current_attack.attack_name
	local attack_settings = self._settings.attacks[attack_name]
	local fully_charged_attack = self:_fully_charged_attack(current_attack)
	local parry_direction = attack_settings.parry_direction
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local damage_multiplier = locomotion:has_perk("shield_breaker") and Perks.shield_breaker.damage_multiplier
	local raw_damage, damage_type, damage, damage_range_type, real_damage = self:_add_damage(hit_gear, position, normal, actor, nil, false, current_attack, impact_direction, damage_multiplier, interpolated_attack_time)

	self:_abort_attack(target_type)

	if raw_damage then
		WeaponHelper:gear_impact(hit_gear, self._unit, target_type, parry_direction, damage, raw_damage, position, normal, self._world, fully_charged_attack)

		local network_manager = Managers.state.network
		local game = network_manager:game()

		if game then
			local direction_id = NetworkLookup.weapon_hit_parameters[parry_direction]
			local target_type_id = NetworkLookup.weapon_hit_parameters[target_type]
			local hit_gear_game_object_id = network_manager:game_object_id(hit_gear)
			local self_gear_game_object_id = network_manager:game_object_id(self._unit)

			damage = math.clamp(damage, NetworkConstants.damage.min, NetworkConstants.damage.max)
			raw_damage = math.clamp(raw_damage, NetworkConstants.damage.min, NetworkConstants.damage.max)

			if Managers.lobby.server then
				network_manager:send_rpc_clients("rpc_weapon_impact_gear", hit_gear_game_object_id, self_gear_game_object_id, target_type_id, direction_id, damage, raw_damage, fully_charged_attack, position, normal)
			else
				network_manager:send_rpc_server("rpc_weapon_impact_gear", hit_gear_game_object_id, self_gear_game_object_id, target_type_id, direction_id, damage, raw_damage, fully_charged_attack, position, normal)
			end
		end

		if not no_damage then
			WeaponHelper:apply_damage(self._world, self._user_unit, self._unit, hit_gear, position, normal, actor, damage_type, damage, damage_range_type, raw_damage, current_attack, nil, impact_direction, self._properties)
		end
	end

	return true
end

function WeaponOneHanded:_hit_damagable_prop(hit_unit, position, normal, actor, impact_direction, interpolated_attack_time)
	local target_type
	local current_attack = self._current_attack
	local attack_name = current_attack.attack_name
	local gear_settings = Gear[Unit.get_data(self._unit, "gear_name")]
	local material_effects_name = gear_settings.attacks[attack_name].impact_material_effects

	if material_effects_name then
		local impact_rotation = Quaternion.look(impact_direction, Quaternion.up(Unit.world_rotation(self._unit, 0)))

		EffectHelper.play_surface_material_effects(material_effects_name, self._world, hit_unit, position, impact_rotation, normal)

		if Managers.state.network:game() then
			EffectHelper.remote_play_surface_material_effects(material_effects_name, self._world, hit_unit, position, impact_rotation, normal)
		end
	end

	if Unit.get_data(hit_unit, "soft_target") then
		target_type = "soft"
	else
		target_type = "hard"

		self:_abort_attack(target_type)
	end

	self:_add_damage(hit_unit, position, normal, actor, nil, true, current_attack, impact_direction, nil, interpolated_attack_time)

	if target_type == "hard" then
		return true
	end
end

function WeaponOneHanded:_hit_non_damagable_prop(hit_unit, position, normal, actor, impact_direction, interpolated_attack_time)
	local gear_owner = self._player
	local gear_name = Unit.get_data(self._unit, "gear_name")

	Managers.state.stats_collector:weapon_missed(gear_owner, gear_name)

	local current_attack = self._current_attack
	local attack_name = current_attack.attack_name
	local gear_settings = Gear[gear_name]
	local material_effects_name = gear_settings.attacks[attack_name].impact_material_effects

	if material_effects_name then
		local impact_rotation = Quaternion.look(impact_direction, Quaternion.up(Unit.world_rotation(self._unit, 0)))

		EffectHelper.play_surface_material_effects(material_effects_name, self._world, hit_unit, position, impact_rotation, normal)

		if Managers.state.network:game() then
			EffectHelper.remote_play_surface_material_effects(material_effects_name, self._world, hit_unit, position, impact_rotation, normal)
		end
	end

	local current_attack = self._current_attack
	local attack_name = current_attack.attack_name

	if position and normal then
		Unit.set_flow_variable(self._unit, "lua_hit_position", position)

		local rotation = Quaternion.look(normal, Vector3.up())

		Unit.set_flow_variable(self._unit, "lua_hit_rotation", rotation)
	end

	if not Unit.get_data(hit_unit, "soft_target") then
		local raw_damage, damage_type, damage, damage_range_type, real_damage = self:_add_damage(hit_unit, position, normal, actor, nil, false, current_attack, nil, impact_direction, interpolated_attack_time)

		self:_abort_attack("hard")

		if raw_damage then
			WeaponHelper:apply_damage_to_self(self._world, self._user_unit, self._unit, damage_type, raw_damage, position, normal, damage_range_type, impact_direction)
		end

		return true
	end
end

function WeaponOneHanded:_add_damage(victim_unit, position, normal, actor, hit_zone, apply_damage, current_attack, impact_direction, damage_multiplier, interpolated_attack_time)
	Profiler.start("WeaponOneHanded:_add_damage")

	local hits_table = current_attack.hits[victim_unit]
	local unit = self._unit
	local user_unit = self._user_unit
	local attack_name = current_attack.attack_name
	local attack = self._attacks[attack_name]
	local damage_type = self:_damage_type(attack)
	local attachment_multipliers = self._attachment_multipliers
	local weapon_velocity = WeaponHelper:melee_weapon_velocity(unit, attack_name, interpolated_attack_time, attachment_multipliers, current_attack.attack_duration)
	local attacker_velocity = WeaponHelper:locomotion_velocity(user_unit)
	local victim_velocity = WeaponHelper:locomotion_velocity(victim_unit)
	local damage, damage_range_type, raw_damage, penetrated = WeaponHelper:calculate_melee_damage(attacker_velocity, weapon_velocity, victim_velocity, unit, user_unit, victim_unit, attack_name, damage_type, current_attack.charge_time, actor, attachment_multipliers, self._properties, impact_direction)

	damage = damage * attachment_multipliers.damage * (self._attachments.blade and self._attachments.blade[1] == "damascus_steel" and 1 or PlayerUnitDamageSettings.MULTIPLE_HIT_MULTIPLIER^self._hit_characters)
	damage = damage * (damage_multiplier or 1)

	if ScriptUnit.has_extension(user_unit, "area_buff_system") then
		local area_buff_ext = ScriptUnit.extension(user_unit, "area_buff_system")

		damage = damage * area_buff_ext:buff_multiplier("reinforce")
	end

	local real_damage = damage

	if not hits_table then
		hits_table = {
			damage = damage,
			hit_zones = {},
			penetrated = penetrated
		}
		current_attack.hits[victim_unit] = hits_table
		self._hit_characters = self._hit_characters + 1
	else
		local current_damage = hits_table.damage

		if current_damage < damage then
			hits_table.damage = damage
			damage = damage - current_damage
		else
			if hit_zone then
				hits_table.hit_zones[hit_zone] = true
			end

			Profiler.stop()

			return
		end
	end

	if hit_zone then
		hits_table.hit_zones.head = true

		if hit_zone == "helmet" or hit_zone == "head" then
			hits_table.hit_zones.helmet = true
		else
			hits_table.hit_zones[hit_zone] = true
		end
	end

	if apply_damage then
		WeaponHelper:apply_damage(self._world, self._user_unit, self._unit, victim_unit, position, normal, actor, damage_type, damage, damage_range_type, raw_damage, current_attack, hit_zone, impact_direction, self._properties, real_damage)
	end

	Profiler.stop()

	return raw_damage, damage_type, damage, damage_range_type, real_damage
end

function WeaponOneHanded:_damage_type(attack)
	return attack.damage_type
end

function WeaponOneHanded:_valid_hamstring_attack(unit, impact_direction, hit_zone, current_attack)
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local unit_rot = Unit.world_rotation(unit, 0)
	local unit_forward = Quaternion.forward(unit_rot)
	local flat_impact_dir = Vector3.normalize(Vector3.flat(impact_direction))

	return locomotion:has_perk("hamstring") and Vector3.dot(flat_impact_dir, unit_forward) > 0 and hit_zone == "legs" and self:_fully_charged_attack(current_attack)
end

function WeaponOneHanded:_debug_draw_weapon_velocity()
	local unit = self._unit
	local current_attack = self._current_attack
	local attack_name = current_attack.attack_name
	local t = math.clamp(current_attack.attack_time / current_attack.attack_duration, 0, 1)
	local old_t = self.__old_t or 0

	self.__old_t = t

	if t < old_t then
		old_t = 0
	end

	local velocity = WeaponHelper:melee_weapon_velocity(unit, attack_name, current_attack.attack_time, self._attachment_multipliers, current_attack.attack_duration)
	local speed = Vector3.length(velocity)
	local speed_max = self._attacks[attack_name].speed_max
	local color = Color(255, 255 - speed / speed_max * 255, 0)
	local drawer = Managers.state.debug:drawer({
		mode = "retained",
		name = "DEBUG_DRAW_WEAPON_VELOCITY" .. tostring(unit)
	})
	local pos = Unit.world_position(unit, 0)
	local attack_settings = self._attacks[attack_name]
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

		local to_center, _, _ = self:_calculate_sweep_extents(sweep_settings)

		pos = to_center
	end

	if math.floor(t * 20) > math.floor(old_t * 20) then
		local t_str = string.format("%1.2f", t)

		Managers.state.debug_text:output_world_text(t_str, 0.05, pos + Vector3(0, 0, 0.1), 10, "none")
	end

	drawer:vector(pos, 0.1 * Vector3.normalize(velocity), color)
end

function WeaponOneHanded:hot_join_synch(sender, player, player_object_id, slot_name)
	return
end

function WeaponOneHanded:enter_ghost_mode()
	return
end

function WeaponOneHanded:exit_ghost_mode()
	self:_disable_hit_collision()
end

function WeaponOneHanded:parry(direction, block_time, max_delay)
	if not self._ai_gear then
		local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
		local rot_angle = 0

		if direction == "down" then
			rot_angle = math.pi
		elseif direction == "left" then
			rot_angle = math.pi / 2
		elseif direction == "right" then
			rot_angle = math.pi / 2 * 3
		end

		locomotion.parry_helper_blackboard.parry_direction = rot_angle
		locomotion.parry_helper_blackboard.parry_direction_delay_time = block_time
	end
end

function WeaponOneHanded:stop_parry()
	if not self._ai_gear then
		local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")

		locomotion.parry_helper_blackboard.parry_direction = nil
	end
end

function WeaponOneHanded:pose(t, pose_direction)
	if not self._ai_gear then
		local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
		local blackboard = locomotion.pose_charge_blackboard

		self._pose_blackboard = blackboard
		self._pose_direction = pose_direction
		self._posing = true

		self:_reset_blackboard(blackboard)
		Managers.state.event:trigger("event_pose_charge_activated", self._player, blackboard)
	end
end

function WeaponOneHanded:_reset_blackboard(blackboard)
	blackboard.pose_factor = 0
end

function WeaponOneHanded:update_pose(dt, t)
	local blackboard = self._pose_blackboard
	local circle_section_size = HUDSettings.circle_section_size / 180 * math.pi
	local pose_direction = self._pose_direction

	if pose_direction == "up" then
		blackboard.direction_offset_angle = 0
		blackboard.charge_rotation = 0
	elseif pose_direction == "down" then
		blackboard.direction_offset_angle = math.pi
		blackboard.charge_rotation = 180
	elseif pose_direction == "left" then
		blackboard.direction_offset_angle = math.pi + math.pi / 2
		blackboard.charge_rotation = 270
	else
		blackboard.direction_offset_angle = math.pi * 0.5
		blackboard.charge_rotation = 90
	end

	local pose_factor = blackboard.pose_factor

	blackboard.charge_factor = pose_factor

	local marker_offset = HUDSettings.marker_offset / 180 * math.pi

	blackboard.shader_value = (1 - pose_factor + pose_factor * (marker_offset * 3 / math.pi)) * (circle_section_size / (math.pi * 2))
	blackboard.gradient_rot_angle = blackboard.direction_offset_angle - (1 - pose_factor) * (circle_section_size / 2 - marker_offset) - marker_offset
	blackboard.marker_rotations.marker_one = blackboard.gradient_rot_angle
	blackboard.marker_rotations.marker_two = blackboard.gradient_rot_angle + (1 - pose_factor) * circle_section_size + pose_factor * marker_offset * 2
end

function WeaponOneHanded:stop_pose()
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")

	self._posing = false

	Managers.state.event:trigger("event_pose_charge_fade", Managers.time:time("game"), locomotion.player)

	self._pose_blackboard = nil
end

function WeaponOneHanded:destroy()
	return
end
