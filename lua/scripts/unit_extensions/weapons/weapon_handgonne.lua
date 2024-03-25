-- chunkname: @scripts/unit_extensions/weapons/weapon_handgonne.lua

require("scripts/unit_extensions/weapons/weapon_handgonne_base")

WeaponHandgonne = class(WeaponHandgonne, WeaponHandgonneBase)

function WeaponHandgonne:init(world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)
	WeaponHandgonne.super.init(self, world, unit, user_unit, player, id)
	self:_init_raycast()

	self._drawer = Managers.state.debug:drawer("handgonne")
	self._ai_gear = ai_gear
	self._attachment_multipliers = attachment_multipliers
	self._properties = properties

	self:_spawn_fuse_dummy()
	self:hide_fuse_dummy()

	self._ai_gear = ai_gear
	self._firing_timer = 0
	self._firing_event = true
	self._slot_name = nil
	self._played_handgonne_ignite_sound = false
end

function WeaponHandgonne:destroy()
	self._fire_raycast_from_camera = nil
	self._fire_raycast_from_muzzle = nil
end

function WeaponHandgonne:_init_raycast()
	local function fire_raycast_result_one(hit, position, distance, normal, actor)
		self:_fire_raycast_result_one(hit, position, distance, normal, actor)
	end

	local function fire_raycast_result_two(hits)
		if hits then
			for _, hit_info in pairs(hits) do
				self:_fire_raycast_result_two(true, hit_info[1], hit_info[2], hit_info[3], hit_info[4])
			end
		end
	end

	local physics_world = World.physics_world(self._world)

	self._fire_raycast_from_camera = PhysicsWorld.make_raycast(physics_world, fire_raycast_result_one, "closest", "collision_filter", "ray_projectile")
	self._fire_raycast_from_muzzle = PhysicsWorld.make_raycast(physics_world, fire_raycast_result_two, "all", "collision_filter", "ray_projectile")
end

function WeaponHandgonne:start_release_projectile(slot_name, draw_time, callback, t)
	self._firing_event_callback = callback
	self._firing = true

	local time_before_firing = self._settings.time_before_firing
	local random_fire_delay = time_before_firing.min + math.random() * (time_before_firing.max - time_before_firing.min)

	self._firing_timer = random_fire_delay + Managers.time:time("game")
	self._slot_name = slot_name

	local event_id = TimpaniWorld.trigger_event(self._timpani_world, "handgonne_ignite_start")
	local event_id_two = TimpaniWorld.trigger_event(self._timpani_world, "handgonne_ignite_loop")
end

function WeaponHandgonne:release_projectile(slot_name, draw_time)
	WeaponHandgonne.super.release_projectile(self, slot_name, draw_time)

	self._played_handgonne_ignite_sound = false

	self._firing_event_callback(self._weapon_category)

	local gear_unit = self._unit
	local user_unit = self._user_unit
	local raycast_position, raycast_direction
	local muzzle_position = self._alt_muzzle_position or self._muzzle_position

	if not self._ai_gear then
		raycast_position, raycast_direction = WeaponHelper:handgonne_fire_position_from_camera(gear_unit, user_unit, muzzle_position, self._settings.max_spread_angle)
	else
		raycast_position, raycast_direction = WeaponHelper:handgonne_fire_position_from_handgonne(gear_unit, user_unit, muzzle_position, self._settings.max_spread_angle)
	end

	self:fire(raycast_position, raycast_direction)

	local network_manager = Managers.state.network
	local user_unit_game_object_id = network_manager:game_object_id(self._user_unit)

	if user_unit_game_object_id then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_release_projectile", user_unit_game_object_id, NetworkLookup.inventory_slots[slot_name])
		else
			network_manager:send_rpc_server("rpc_release_projectile", user_unit_game_object_id, NetworkLookup.inventory_slots[slot_name])
		end
	end
end

function WeaponHandgonne:update_fire(dt, t)
	if t >= self._firing_timer then
		self:release_projectile(self._slot_name, nil)

		self._firing = false
	elseif t >= self._firing_timer - self._settings.time_before_firing.min and not self._played_handgonne_ignite_sound then
		local event_id = TimpaniWorld.trigger_event(self._timpani_world, "hangonne_ignite")

		self._played_handgonne_ignite_sound = true
	end
end

function WeaponHandgonne:fire(raycast_position, raycast_direction)
	local from_pos = raycast_position

	self._penetration_force = 1

	if script_data.handgonne_debug then
		self._drawer:line(from_pos, from_pos + raycast_direction * self._settings.max_range, Color(0, 255, 0))
	end

	self._fire_raycast_from_camera:cast(from_pos, raycast_direction, self._settings.max_range)
end

function WeaponHandgonne:_fire_raycast_result_one(hit, position, distance, normal, actor)
	if hit then
		local muzzle_node_index = self._alt_muzzle_node_index or self._muzzle_node_index
		local from_pos = Unit.world_position(self._unit, muzzle_node_index)
		local direction = position - from_pos

		if script_data.handgonne_debug then
			self._drawer:line(from_pos, from_pos + direction * self._settings.max_range, Color(255, 0, 0))
		end

		self._temp_raycast_direction = Vector3Box(Vector3.normalize(direction))

		self._fire_raycast_from_muzzle:cast(from_pos, direction, self._settings.max_range)
	end
end

function WeaponHandgonne:_fire_raycast_result_two(hit, position, distance, normal, actor, direction)
	if hit then
		local hit_unit = Actor.unit(actor)

		hit_unit, actor = WeaponHelper:helmet_hack(hit_unit, actor)

		self:_hit(position, normal, actor, hit_unit, distance)
	end
end

function WeaponHandgonne:_hit(position, normal, actor, victim_unit, distance)
	if victim_unit and victim_unit ~= self._user_unit and self._penetration_force > 0 then
		if script_data.handgonne_debug then
			self._drawer:sphere(position, 0.05, Color(0, 255 * self._penetration_force, 0))
		end

		self._penetration_force = 0

		local network_manager = Managers.state.network
		local gear_unit = self._unit
		local user_unit = self._user_unit
		local user_player = self._player
		local damage_type = self._projectile_settings.damage_type
		local impact_direction = self._temp_raycast_direction:unbox()
		local impact_rotation = Quaternion.look(impact_direction, Vector3.up())

		if Unit.get_data(victim_unit, "health") then
			local stun_property = false
			local damage, damage_range_type, stun, hit_zone = WeaponHelper:calculate_handgonne_damage(gear_unit, user_unit, victim_unit, self._projectile_name, actor, self._properties, impact_direction, distance, self._settings, self._projectile_settings)

			damage = damage * self._attachment_multipliers.damage

			if ScriptUnit.has_extension(user_unit, "area_buff_system") then
				local area_buff_ext = ScriptUnit.extension(user_unit, "area_buff_system")

				damage = damage * area_buff_ext:buff_multiplier("reinforce")
			end

			if ScriptUnit.has_extension(victim_unit, "locomotion_system") then
				self:_hit_character(victim_unit, position, damage, stun, hit_zone, impact_direction)
			else
				EffectHelper.play_surface_material_effects("bullet_impact", self._world, victim_unit, position, impact_rotation, normal)

				if Managers.state.network:game() then
					EffectHelper.remote_play_surface_material_effects("bullet_impact", self._world, victim_unit, position, impact_rotation, normal)
				end
			end

			WeaponHelper:add_damage(self._world, victim_unit, user_player, user_unit, damage_type, damage, position, normal, actor, damage_range_type, self._gear_name, hit_zone, impact_direction, nil, true)
		else
			EffectHelper.play_surface_material_effects("bullet_impact", self._world, victim_unit, position, impact_rotation, normal)

			if Managers.state.network:game() then
				EffectHelper.remote_play_surface_material_effects("bullet_impact", self._world, victim_unit, position, impact_rotation, normal)
			end

			Managers.state.stats_collector:weapon_missed(user_player, self._gear_name)
		end
	end
end

function WeaponHandgonne:_hit_character(victim_unit, position, damage, stun, hit_zone, impact_direction)
	WeaponHelper:handgonne_impact_character(victim_unit, position, damage, self._world, stun, hit_zone, impact_direction)

	local network_manager = Managers.state.network

	if not self._ai_gear then
		local event_id = TimpaniWorld.trigger_event(self._timpani_world, "bullet_hit_feedback")

		Managers.state.event:trigger("event_hit_marker_activated", self._player)
	end

	if Managers.state.network:game() then
		local victim_unit_game_object_id = network_manager:game_object_id(victim_unit)

		damage = math.clamp(damage, NetworkConstants.damage.min, NetworkConstants.damage.max)

		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_handgonne_impact_character", victim_unit_game_object_id, position, damage, stun, NetworkLookup.hit_zones[hit_zone], impact_direction)
		else
			network_manager:send_rpc_server("rpc_handgonne_impact_character", victim_unit_game_object_id, position, damage, stun, NetworkLookup.hit_zones[hit_zone], impact_direction)
		end
	end
end

function WeaponHandgonne:_spawn_fuse_dummy()
	local unit = self._unit
	local user_unit = self._user_unit
	local fuse_dummy_unit = World.spawn_unit(self._world, "units/weapons/wpn_handgonne_fuse_stick/wpn_handgonne_fuse_stick")
	local link_node = Unit.node(fuse_dummy_unit, "rp_wpn_handgonne_fuse_stick")
	local user_link_node = Unit.node(user_unit, "a_right_hand")
	local user_link_pose = Unit.local_pose(user_unit, user_link_node)

	Unit.set_local_pose(fuse_dummy_unit, link_node, user_link_pose)
	World.link_unit(self._world, fuse_dummy_unit, user_unit, user_link_node)

	self._fuse_dummy_unit = fuse_dummy_unit
end

function WeaponHandgonne:hide_fuse_dummy()
	Unit.set_unit_visibility(self._fuse_dummy_unit, false)
end

function WeaponHandgonne:show_fuse_dummy()
	Unit.set_unit_visibility(self._fuse_dummy_unit, true)
end

function WeaponHandgonne:_play_fire_sound()
	if self._ai_gear then
		WeaponHandgonne.super._play_fire_sound(self)
	else
		local fire_sound_event = self._fire_sound_event
		local timpani_world = self._timpani_world
		local event_id = TimpaniWorld.trigger_event(timpani_world, fire_sound_event)

		TimpaniWorld.set_parameter(timpani_world, event_id, fire_sound_event, "shot_stereo")
	end
end

function WeaponHandgonne:update(dt, t)
	if self._firing then
		self:update_fire(dt, t)
	elseif self._reloading then
		self:update_reload(dt, t)
	end
end

function WeaponHandgonne:update_reload(dt, t, fire_input)
	if t >= self._reload_time then
		self._loaded = true

		self:finish_reload()
	end
end

function WeaponHandgonne:finish_reload(reload_successful)
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")

	Managers.state.event:trigger("event_handgonne_reload_deactivated", locomotion.player)

	return WeaponHandgonne.super.finish_reload(self, reload_successful)
end

function WeaponHandgonne:can_wield()
	return not self._reloading
end

function WeaponHandgonne:start_reload(reload_time, reload_blackboard)
	WeaponHandgonne.super.start_reload(self, reload_time, reload_blackboard)

	local t = Managers.time:time("game")

	if not self._ai_gear then
		reload_blackboard.timer = reload_time
		reload_blackboard.max_time = reload_time - t

		Managers.state.event:trigger("event_handgonne_reload_activated", nil, t, self._player, reload_blackboard)
	end
end

function WeaponHandgonne:can_fire()
	return not self._firing and WeaponHandgonne.super.can_fire(self)
end

function WeaponHandgonne:aim()
	self:show_fuse_dummy()

	return WeaponHandgonne.super.aim(self)
end

function WeaponHandgonne:unaim()
	self._firing = false

	self:hide_fuse_dummy()

	return WeaponHandgonne.super.unaim(self)
end
