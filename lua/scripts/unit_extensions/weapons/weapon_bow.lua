-- chunkname: @scripts/unit_extensions/weapons/weapon_bow.lua

require("scripts/helpers/weapon_helper")
require("scripts/unit_extensions/weapons/weapon_bow_base")

WeaponBow = class(WeaponBow, WeaponBowBase)

function WeaponBow:init(world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)
	WeaponBow.super.init(self, world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)

	self._ai_gear = ai_gear
	self._player_gear = not ai_gear
	self._firing_event = true
	self._aim_blackboard = nil
	self._stop_aim_timer = nil
	self._aim_start_time = 0
	self._aim_shake_start_time = nil
	self._loaded = false
	self._breath_up_sound = true
	self._arm_shake_sound = true
end

function WeaponBow:ready_projectile(slot_name)
	WeaponBow.super.ready_projectile(self, slot_name)

	local projectile_name = self._projectile_name
	local network_manager = Managers.state.network
	local user_unit_game_object_id = network_manager:game_object_id(self._user_unit)

	if user_unit_game_object_id and network_manager:game() then
		if Managers.lobby.server then
			network_manager:send_rpc_clients("rpc_ready_projectile", user_unit_game_object_id, NetworkLookup.inventory_slots[slot_name], NetworkLookup.projectiles[projectile_name])
		else
			network_manager:send_rpc_server("rpc_ready_projectile", user_unit_game_object_id, NetworkLookup.inventory_slots[slot_name], NetworkLookup.projectiles[projectile_name])
		end
	end

	self._breath_up_sound = true
	self._arm_shake_sound = true
	self._aim_shake_start_time = nil
end

function WeaponBow:start_release_projectile(slot_name, draw_time, callback, t)
	if self._ai_gear or self._aim_blackboard.hitting then
		local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
		local shake_time_multiplier = locomotion:has_perk("steady_aim") and Perks.steady_aim.shake_time_multiplier or 1
		local shake_time = self._aim_shake_start_time and t - self._aim_shake_start_time or 0
		local attack_settings = self._settings.attacks.ranged
		local draw_time_loss = shake_time / (attack_settings.bow_shake_time * shake_time_multiplier) * attack_settings.bow_tense_time

		self:release_projectile(slot_name, draw_time, draw_time_loss)
	else
		local timpani_world = self._timpani_world
		local fail_fire_sound_event = self._fail_fire_sound_event
		local event_id = TimpaniWorld.trigger_event(timpani_world, fail_fire_sound_event)

		TimpaniWorld.set_parameter(timpani_world, event_id, "shot", "shot_stereo")
		callback(self._weapon_category)
	end
end

function WeaponBow:release_projectile(slot_name, draw_time, draw_time_loss)
	WeaponBow.super.release_projectile(self, slot_name, draw_time)

	local gear_unit = self._unit
	local user_unit = self._user_unit
	local projectile_name = self._projectile_name
	local projectile_position, projectile_velocity
	local settings = self._settings.attacks.ranged
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local draw_time_multiplier = locomotion:has_perk("longbowman") and Perks.longbowman.draw_time_multiplier or 1
	local ready_bow_time = settings.bow_draw_time * draw_time_multiplier
	local draw_bow_time = settings.bow_tense_time
	local draw_time_max = ready_bow_time + draw_bow_time
	local modified_draw_time = math.min(draw_time, draw_time_max) - draw_time_loss
	local damage_multiplier = 0.7 + 0.3 * ((modified_draw_time - ready_bow_time) / draw_bow_time)
	local dir

	if not self._ai_gear then
		projectile_position = WeaponHelper:projectile_fire_position_from_camera(gear_unit, user_unit, projectile_name)
		projectile_velocity, dir = WeaponHelper:bow_projectile_fire_velocity_from_camera(gear_unit, user_unit, draw_time, draw_time_loss)
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
		projectile_velocity = WeaponHelper:projectile_fire_velocity_from_bow(gear_unit, aim_look_rotated_forward, draw_time)
	end

	self:fire(projectile_position, projectile_velocity, dir, damage_multiplier)

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

function WeaponBow:fire(projectile_position, projectile_velocity, forward_direction, damage_multiplier)
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
	damage_multiplier = damage_multiplier * attachment_multipliers.damage

	if ScriptUnit.has_extension(user_unit, "area_buff_system") then
		local area_buff_ext = ScriptUnit.extension(user_unit, "area_buff_system")

		damage_multiplier = damage_multiplier * area_buff_ext:buff_multiplier("reinforce")
	end

	local player = self._player

	self._aiming = false

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

function WeaponBow:_play_fire_sound()
	if self._ai_gear then
		WeaponBow.super._play_fire_sound(self)
	else
		local timpani_world = self._timpani_world
		local fire_sound_event = self._fire_sound_event
		local event_id = TimpaniWorld.trigger_event(timpani_world, fire_sound_event)

		TimpaniWorld.set_parameter(timpani_world, event_id, "shot", "shot_stereo")
	end
end

function WeaponBow:update(dt, t)
	WeaponBow.super.update(self, dt, t)
	self:_update_ammunition(dt, t)

	if self._aiming then
		self:update_aim(dt, t)
	end

	if self._stop_aim_timer and t >= self._stop_aim_timer then
		self._stop_aim_timer = nil
	end
end

function WeaponBow:can_aim()
	return not self._stop_aim_timer
end

function WeaponBow:unaim()
	self._aim_blackboard = nil

	if not self._ai_gear then
		Managers.state.event:trigger("event_bow_minigame_deactivated", self._player)

		self._aiming = false
	end

	self._aim_shake_start_time = nil

	return WeaponBow.super.unaim(self)
end

function WeaponBow:_reset_blackboard(blackboard)
	local marker_offset = blackboard.marker_offset
	local pi = math.pi
	local offset_right = pi - marker_offset
	local offset_left = pi + marker_offset

	blackboard.marker_rotations.marker_one = offset_right
	blackboard.marker_rotations.marker_two = offset_left
	blackboard.marker_rotations.marker_three = math.pi - blackboard.marker_offset
	blackboard.marker_rotations.marker_four = math.pi + blackboard.marker_offset
	blackboard.timer_rotations.timer_one = offset_left
	blackboard.timer_rotations.timer_two = offset_right
end

function WeaponBow:aim(t)
	if not self._ai_gear then
		local user_unit = self._user_unit

		self._aiming = true

		local user_unit_locomotion = ScriptUnit.extension(user_unit, "locomotion_system")
		local blackboard = user_unit_locomotion.bow_aim_blackboard

		self._aim_blackboard = blackboard

		self:_reset_blackboard(blackboard)

		self._aim_start_time = t

		Managers.state.event:trigger("event_bow_minigame_activated", self._player, blackboard)
	end

	return WeaponBow.super.aim(self)
end

function WeaponBow:update_aim(dt, t)
	local blackboard = self._aim_blackboard
	local attack_settings = self._settings.attacks.ranged
	local locomotion = ScriptUnit.extension(self._user_unit, "locomotion_system")
	local draw_time_multiplier = locomotion:has_perk("longbowman") and Perks.longbowman.draw_time_multiplier or 1
	local ready_bow_time = attack_settings.bow_draw_time * draw_time_multiplier
	local draw_bow_time = attack_settings.bow_tense_time
	local shake_time_multiplier = locomotion:has_perk("steady_aim") and Perks.steady_aim.shake_time_multiplier or 1
	local bow_shake_time = attack_settings.bow_shake_time * shake_time_multiplier
	local marker_offset = blackboard.marker_offset
	local hit_section_halved = HUDSettings.bow_minigame.hit_section_size / 2 / 180 * math.pi
	local speed = 0
	local aim_start_time = self._aim_start_time
	local timpani_world = World.timpani_world(self._world)

	if t <= aim_start_time + ready_bow_time then
		speed = (math.pi - marker_offset - hit_section_halved) / ready_bow_time
	elseif t <= aim_start_time + draw_bow_time + ready_bow_time then
		speed = hit_section_halved / draw_bow_time

		if self._breath_up_sound then
			local event_id = TimpaniWorld.trigger_event(timpani_world, "chr_vce_breathe_up")

			self._breath_up_sound = false
		end
	elseif locomotion:has_perk("strong_of_arm") then
		if t <= aim_start_time + draw_bow_time + ready_bow_time + Perks.strong_of_arm.bow_hold_time then
			speed = 0
			blackboard.marker_rotations.marker_three = 0
			blackboard.marker_rotations.marker_four = 0
		elseif t <= aim_start_time + draw_bow_time + ready_bow_time + Perks.strong_of_arm.bow_hold_time + bow_shake_time then
			speed = self:_bow_shake_speed(t, hit_section_halved, bow_shake_time)
		else
			self:_force_lower_aim(t)
		end
	elseif t <= aim_start_time + draw_bow_time + ready_bow_time + bow_shake_time then
		speed = self:_bow_shake_speed(t, hit_section_halved, bow_shake_time)
	else
		self:_force_lower_aim(t)
	end

	blackboard.marker_rotations.marker_three = blackboard.marker_rotations.marker_three - speed * dt
	blackboard.marker_rotations.marker_four = blackboard.marker_rotations.marker_four + speed * dt
	blackboard.shader_value = blackboard.marker_rotations.marker_three / (math.pi * 2)

	if blackboard.marker_rotations.marker_three <= 0.2777777777777778 * math.pi then
		blackboard.hitting = true
	else
		blackboard.hitting = false
	end
end

function WeaponBow:_bow_shake_speed(t, hit_section_halved, bow_shake_time)
	if self._arm_shake_sound then
		local timpani_world = World.timpani_world(self._world)
		local event_id = TimpaniWorld.trigger_event(timpani_world, "bow_aim_fatigue")

		self._arm_shake_sound = false
		self._aim_shake_start_time = t
	end

	return hit_section_halved / bow_shake_time * -1
end

function WeaponBow:_force_lower_aim(t)
	local timpani_world = World.timpani_world(self._world)

	self._stop_aim_timer = t + 0.4
	self._needs_unaiming = true

	local event_id = TimpaniWorld.trigger_event(timpani_world, "chr_vce_breathe_down")
end

function WeaponBow:set_wielded(wielded)
	WeaponBow.super.set_wielded(self, wielded)

	if not self._husk_gear then
		local player = self._player

		if wielded then
			Managers.state.event:trigger("bow_wielded", player, self._hud_ammo_counter_blackboard)
		else
			Managers.state.event:trigger("bow_unwielded", player)
		end
	end
end

function WeaponBow:fire_anim_name()
	return not self:can_reload() and WeaponBow.super.fire_anim_name(self)
end
