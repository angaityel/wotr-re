-- chunkname: @scripts/unit_extensions/weapons/weapon_crossbow.lua

require("scripts/unit_extensions/weapons/weapon_crossbow_base")

WeaponCrossbow = class(WeaponCrossbow, WeaponCrossbowBase)

function WeaponCrossbow:init(world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)
	WeaponCrossbow.super.init(self, world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)

	self._ai_gear = ai_gear
	self._player_gear = not ai_gear
	self._reload_timer = 0
	self._modification_timer = 0
	self._hook_state = "normal"
	self._hook_speed_multiplier = 1
	self._reload_speed_multiplier = 1
	self._has_safety_attachment = attachments.misc and self:_has_safety(attachments.misc) or false
	self._loaded = false
	self._random_hook_rotation = 0
	self._hook_transitioning = false
	self._full_rot = false

	local proposed_hit_section_size = self._settings.reload_hit_section_size + attachment_multipliers.crossbow_hit_section * 15

	self._hit_section_size = proposed_hit_section_size >= 15 and proposed_hit_section_size or 15
	self._raise_timer = 0
	self._raising_crossbow = false
end

function WeaponCrossbow:ready_projectile(slot_name)
	WeaponCrossbow.super.ready_projectile(self, slot_name)

	local projectile_name = self._projectile_name
	local network_manager = Managers.state.network
	local user_unit_game_object_id = network_manager:game_object_id(self._user_unit)

	if ScriptUnit.has_extension(self._user_unit, "locomotion_system") then
		local user_unit_locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")

		user_unit_locomotion.reload_slot_name = nil
	end

	if user_unit_game_object_id then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_ready_projectile", user_unit_game_object_id, NetworkLookup.inventory_slots[slot_name], NetworkLookup.projectiles[projectile_name])
		else
			network_manager:send_rpc_server("rpc_ready_projectile", user_unit_game_object_id, NetworkLookup.inventory_slots[slot_name], NetworkLookup.projectiles[projectile_name])
		end
	end
end

function WeaponCrossbow:release_projectile(slot_name, draw_time)
	WeaponCrossbow.super.release_projectile(self, slot_name, draw_time)

	local gear_unit = self._unit
	local user_unit = self._user_unit
	local projectile_name = self._projectile_name
	local projectile_position, projectile_velocity, dir

	if not self._ai_gear then
		projectile_position = WeaponHelper:projectile_fire_position_from_camera(gear_unit, user_unit, projectile_name)
		projectile_velocity, dir = WeaponHelper:crossbow_projectile_fire_velocity_from_camera(gear_unit, user_unit)
	else
		local locomotion = ScriptUnit.extension(user_unit, "locomotion_system")
		local ai_profile = ScriptUnit.extension(user_unit, "ai_system"):profile()
		local accuracy = 1 - ai_profile.properties.accuracy
		local error_pitch = accuracy * ai_profile.properties.max_vertical_spread
		local error_yaw = accuracy * ai_profile.properties.max_horizontal_spread
		local look_target = locomotion:look_target()

		projectile_position = WeaponHelper:projectile_fire_position_from_ranged_weapon(gear_unit, user_unit, projectile_name)

		local aim_direction = Vector3.normalize(look_target - projectile_position)
		local aim_direction_flat = Vector3.flat(aim_direction)
		local rotator = Quaternion.multiply(Quaternion(Vector3.right(), locomotion.projectile_angle), Quaternion(Vector3.right(), (Math.random() - 0.5) * 2 * (error_pitch / 180 * math.pi)))
		local aim_look = Quaternion.multiply(Quaternion.look(aim_direction_flat, Vector3.up()), Quaternion(Vector3.up(), (Math.random() - 0.5) * 2 * (error_yaw / 180 * math.pi)))
		local aim_look_rotated = Quaternion.multiply(aim_look, rotator)
		local aim_look_rotated_forward = Quaternion.forward(aim_look_rotated)

		dir = aim_look_rotated_forward
		projectile_velocity = aim_look_rotated_forward * self._settings.attacks.ranged.speed_max
	end

	self:fire(projectile_position, projectile_velocity, dir)

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

function WeaponCrossbow:fire(projectile_position, projectile_velocity, forward_direction)
	local projectile_name = self._projectile_name
	local gear_name = self._gear_name
	local network_manager = Managers.state.network
	local unit = self._unit
	local user_unit = self._user_unit
	local user_velocity = WeaponHelper:locomotion_velocity(user_unit)
	local exit_velocity = projectile_velocity + forward_direction * Vector3.dot(user_velocity, forward_direction)
	local locomotion = ScriptUnit.extension(user_unit, "locomotion_system")
	local attachment_multipliers = self._attachment_multipliers
	local gravity_multiplier = locomotion:has_perk("marksman_training") and Perks.marksman_training.gravity_multiplier or 1

	gravity_multiplier = gravity_multiplier * attachment_multipliers.gravity

	local damage_multiplier = attachment_multipliers.damage

	if ScriptUnit.has_extension(user_unit, "area_buff_system") then
		local area_buff_ext = ScriptUnit.extension(user_unit, "area_buff_system")

		damage_multiplier = damage_multiplier * area_buff_ext:buff_multiplier("reinforce")
	end

	local player = self._player

	if network_manager:game() then
		local user_object_id = network_manager:game_object_id(user_unit)
		local bow_object_id = network_manager:game_object_id(unit)
		local projectile_name_id = NetworkLookup.projectiles[projectile_name]
		local gear_name_id = NetworkLookup.inventory_gear[gear_name]
		local player_index = player:player_id()

		network_manager:send_rpc_server("rpc_spawn_projectile", player_index, user_object_id, bow_object_id, projectile_name_id, gear_name_id, projectile_position, exit_velocity, gravity_multiplier, damage_multiplier, self:_projectile_properties_id(self._properties))
	else
		local projectile_unit_name = self._projectile_settings.unit
		local projectile_rotation = Quaternion.look(exit_velocity, Vector3.up())
		local projectile_unit = World.spawn_unit(self._world, projectile_unit_name, projectile_position, projectile_rotation)
		local player_index = player.index

		Managers.state.entity:register_unit(self._world, projectile_unit, player_index, user_unit, unit, false, network_manager:game(), projectile_name, gear_name, exit_velocity, gravity_multiplier, damage_multiplier, self:_projectile_properties_id(self._properties))
	end
end

function WeaponCrossbow:_play_fire_sound()
	if self._ai_gear then
		WeaponCrossbow.super._play_fire_sound(self)
	else
		local timpani_world = self._timpani_world
		local fire_sound_event = self._fire_sound_event
		local event_id = TimpaniWorld.trigger_event(timpani_world, fire_sound_event)

		TimpaniWorld.set_parameter(timpani_world, event_id, "shot", "shot_stereo")
	end
end

function WeaponCrossbow:update(dt, t)
	WeaponCrossbow.super.update(self, dt, t)
	self:_update_ammunition(dt, t)

	if self._raising_crossbow and t >= self._raise_timer then
		self._raising_crossbow = false
	end
end

function WeaponCrossbow:can_aim()
	return not self._raising_crossbow
end

function WeaponCrossbow:can_steady()
	return true
end

function WeaponCrossbow:update_reload(dt, t, fire_input)
	local reload_blackboard = self._reload_blackboard
	local reload_length = self._reload_time
	local settings = self._settings
	local pi = math.pi
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local extra_notches = locomotion:has_perk("nimble_minded") and Perks.nimble_minded.extra_notches or 0
	local hit_section_size = self._hit_section_size + extra_notches * 15
	local hit_section_halved = hit_section_size / 2 / 180 * pi
	local attachment_multipliers = self._attachment_multipliers

	if not self._ai_gear then
		local grab_area_start_rot = hit_section_halved
		local grab_area_end_rot = pi * 2 - hit_section_halved
		local difference = grab_area_start_rot - grab_area_end_rot

		reload_blackboard.texture_offset = hit_section_halved
		reload_blackboard.grab_area_rot_angle = grab_area_start_rot - difference * (self._reload_timer / reload_length)
		reload_blackboard.shader_value = (reload_blackboard.grab_area_rot_angle - hit_section_halved) / (2 * pi)
		reload_blackboard.cross_alpha = 255

		self:_update_hook_rotation(dt, t, grab_area_start_rot)

		if self._hook_state == "normal" and fire_input and not self._hook_transitioning then
			self._hook_state = self:_hit_grab_area(settings, hit_section_size) and "hitting" or "missing"

			if self._hook_state == "hitting" then
				self._reload_speed_multiplier = 4
				self._modification_timer = t + 0.25 * settings.reload_hit_time * attachment_multipliers.crossbow_hit
				self._hook_offset = reload_blackboard.hook_rot_angle - reload_blackboard.grab_area_rot_angle
				reload_blackboard.hitting = true

				local event_id = TimpaniWorld.trigger_event(self._timpani_world, "crossbow_load_strike")
			else
				self._hook_speed_multiplier = 0.04
				self._reload_speed_multiplier = 0
				self._modification_timer = t + settings.reload_miss_time * attachment_multipliers.crossbow_miss
				reload_blackboard.missing = true

				local event_id = TimpaniWorld.trigger_event(self._timpani_world, "crossbow_fail")
			end
		elseif self._hook_state ~= "normal" and t >= self._modification_timer then
			reload_blackboard.hitting = false
			reload_blackboard.missing = false
			self._hook_state = "normal"
			self._hook_transitioning = true
			self._hook_speed_multiplier = 0
			self._hook_transition_time = t + TRANSITION_TIME
			reload_blackboard.hook_rot_angle = self:_random_angle()
			reload_blackboard.cross_alpha = 0
			self._reload_speed_multiplier = 1
		elseif self._hook_transitioning and t > self._hook_transition_time then
			self._hook_speed_multiplier = 1
			self._hook_transitioning = false
		elseif self._hook_transitioning then
			local transition_time = TRANSITION_TIME - (self._hook_transition_time - t)

			if transition_time < INVISIBLE_TIME then
				reload_blackboard.cross_alpha = 0
			elseif transition_time < BLEND_IN_TIME then
				reload_blackboard.cross_alpha = 255 * (transition_time - INVISIBLE_TIME) / (BLEND_IN_TIME - INVISIBLE_TIME)
			end

			self._hook_speed_multiplier = math.max((transition_time - BLEND_IN_TIME) / SPEED_UP_TIME, 0)^2
		end
	end

	if reload_length > self._reload_timer then
		self._reload_timer = self._reload_timer + dt * self._reload_speed_multiplier
	else
		self._loaded = true
	end
end

TRANSITION_TIME = 0.5
INVISIBLE_TIME = 0.1
BLEND_IN_TIME = 0.2
SPEED_UP_TIME = TRANSITION_TIME - BLEND_IN_TIME

function WeaponCrossbow:_random_angle()
	return (self._reload_blackboard.grab_area_rot_angle - (math.pi + (math.random() - 0.5) * (math.pi / 2))) % (2 * math.pi)
end

function WeaponCrossbow:_update_hook_rotation(dt, t, grab_area_start_rot)
	local reload_blackboard = self._reload_blackboard
	local rot_angle = reload_blackboard.hook_rot_angle
	local pi = math.pi

	if self._hook_state == "hitting" then
		rot_angle = reload_blackboard.grab_area_rot_angle + self._hook_offset
	elseif rot_angle >= pi * 2 + grab_area_start_rot then
		rot_angle = grab_area_start_rot
		self._full_rot = false
	else
		rot_angle = rot_angle + 360 * pi / 180 * dt * self._settings.hook_rotations_per_second * self._hook_speed_multiplier
	end

	reload_blackboard.hook_rot_angle = rot_angle
end

function WeaponCrossbow:_hit_grab_area(settings, hit_section_size)
	local reload_blackboard = self._reload_blackboard
	local hit_section_halved = hit_section_size / 2 / 180 * math.pi
	local rot_angle_difference = math.abs(reload_blackboard.hook_rot_angle - reload_blackboard.grab_area_rot_angle)

	if rot_angle_difference > math.pi then
		rot_angle_difference = math.pi * 2 - rot_angle_difference
	end

	return rot_angle_difference <= hit_section_halved
end

function WeaponCrossbow:finish_reload(reload_successful, slot_name)
	self._reload_timer = 0
	self._modification_timer = 0
	self._hook_state = "normal"
	self._hook_speed_multiplier = 1
	self._reload_speed_multiplier = 1
	self._hook_transitioning = false
	self._full_rot = false

	local settings = self._settings

	if not self._ai_gear then
		local reload_blackboard = self._reload_blackboard
		local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
		local extra_notches = locomotion:has_perk("nimble_minded") and Perks.nimble_minded.extra_notches or 0
		local hit_section_size = self._hit_section_size + extra_notches * 15

		reload_blackboard.grab_area_rot_angle = hit_section_size / 2 / 180 * math.pi
		reload_blackboard.hook_rot_angle = self:_random_angle()
	end

	local timpani_world = World.timpani_world(self._world)
	local event_id = TimpaniWorld.trigger_event(timpani_world, "crossbow_load_loop_stop")

	if reload_successful then
		self._raise_timer = settings.raise_time + Managers.time:time("game")
		self._raising_crossbow = true
	end

	return WeaponCrossbow.super.finish_reload(self, reload_successful, slot_name)
end

function WeaponCrossbow:set_wielded(wielded)
	WeaponCrossbow.super.set_wielded(self, wielded)

	if not wielded and self._loaded then
		self._loaded = self._has_safety_attachment
	elseif wielded and self._loaded then
		self:_show_projectile_dummy()
	end

	if not self._husk_gear then
		local player = self._player

		if wielded then
			Managers.state.event:trigger("crossbow_wielded", player, self._hud_ammo_counter_blackboard)
		else
			Managers.state.event:trigger("crossbow_unwielded", player)
		end
	end
end

function WeaponCrossbow:_has_safety(misc_attachments)
	for _, attachment in ipairs(misc_attachments) do
		if attachment == "safety" then
			return true
		end
	end

	return false
end
