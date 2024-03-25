-- chunkname: @scripts/unit_extensions/human/ai_player_unit/ai_locomotion.lua

require("scripts/unit_extensions/human/base/human_locomotion")
require("scripts/unit_extensions/human/ai_player_unit/states/ai_onground")
require("scripts/unit_extensions/human/ai_player_unit/states/ai_dead")
require("scripts/unit_extensions/human/ai_player_unit/states/ai_stunned")
require("scripts/unit_extensions/human/ai_player_unit/states/ai_executing")
require("scripts/unit_extensions/human/ai_player_unit/states/ai_reviving_teammate")
require("scripts/unit_extensions/human/ai_player_unit/states/ai_mounted")
require("scripts/settings/ai_settings")
require("scripts/unit_extensions/human/ai_player_unit/ai_unit_inventory")

AILocomotion = class(AILocomotion, HumanLocomotion)

local settings = AISettings.locomotion

function AILocomotion:init(world, unit, profile, player)
	AILocomotion.super.init(self, world, unit)

	self.player = player
	self._move_speed_var = Unit.animation_find_variable(unit, "move_speed")
	self._rush_speed_var = Unit.animation_find_variable(unit, "rush_speed")
	self._move_multiplier_var = Unit.animation_find_variable(unit, "double_time_speed")
	self._look_direction_var = Unit.animation_find_variable(unit, "aim_direction")
	self._aim_constraint_var = Unit.animation_find_constraint_target(unit, "aim_constraint_target")
	self._pose_x_var = Unit.animation_find_variable(unit, "pose_x")
	self._pose_y_var = Unit.animation_find_variable(unit, "pose_y")
	self._move_events = {
		move_backward = "move_bwd",
		move_forward = "move_fwd",
		idle = "idle"
	}
	self._mover = Unit.mover(unit)
	self._velocity = Vector3Box()
	self._look_target = Vector3Box()
	self._wanted_look_target = Vector3Box()
	self._aim_direction = Vector3Box(0, 3, 0)
	self._bone_lod = 0

	self:_create_states()
	self:_set_init_state("onground")

	if Managers.state.network:game() then
		self:_create_game_object(unit)
	end

	self:_init_public_variables(unit)
	self:_init_inventory(profile)
	Unit.set_animation_merge_options(unit)
end

function AILocomotion:finalize(profile)
	self._states.onground:finalize(profile)
end

function AILocomotion:_create_game_object(unit)
	local mover = Unit.mover(unit)
	local player = self.player
	local data_table = {
		ghost_mode = false,
		husk_unit = NetworkLookup.husks[Unit.get_data(unit, "husk_unit")],
		position = Mover.position(mover),
		rotation = Unit.local_rotation(unit, 0),
		game_object_created_func = NetworkLookup.game_object_functions.cb_spawn_unit,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_destroy_object,
		object_destroy_func = NetworkLookup.game_object_functions.cb_destroy_player_unit,
		player = player.temp_random_user_id,
		team_name = NetworkLookup.team[player.team.name],
		pose_anim_blend_value = Vector3(0, 0, 0),
		pose_lean_anim_blend_value = Vector3(0, 0, 0),
		aim_target = self:aim_direction(),
		movement_state = NetworkLookup.movement_states[self.current_state_name]
	}
	local callback = callback(self, "cb_game_session_disconnect")

	self.id = Managers.state.network:create_game_object("player_unit", data_table, callback, "cb_local_unit_spawned", unit)
	self.game = Managers.state.network:game()
end

function AILocomotion:cb_game_session_disconnect()
	self.id = nil
	self.game = nil
end

function AILocomotion:_create_states()
	self:_create_state("onground", AIOnground)
	self:_create_state("executing", AIExecuting)
	self:_create_state("reviving", AIRevivingTeammate)
	self:_create_state("dead", AIDead)
	self:_create_state("stunned", AIStunned)
	self:_create_state("mounted", AIMounted)
end

function AILocomotion:_init_public_variables(unit)
	local t = Managers.time:time("game")
	local pos = Unit.world_position(unit, 0)
	local rot = Unit.world_rotation(unit, 0)

	self:_init_internal_variables(self, unit, t, pos, rot)

	self.pose_ready = false
	self.pose_progress_time = 0
	self.swinging = false
	self.melee_attack = false
	self.ranged_attack = false
	self.ranged_attack_cooldown = 0
	self.wield_new_weapon = false
	self.block_or_parry = false
	self.block_start_time = 0
	self.start_or_stop_crouch = false
	self.projectile_angle = nil
	self.morale_state = "active"
	self.executing = false
	self.reviving = false
	self.dual_wield_config = {}
	self.tether_timer = 0
	self.in_movement_area = false
	self.random_safe_area_location = nil
	self.unit_in_spawn = false
	self.couch_cooldown_time = 0
	self.aim_time = 0
	self.pose_time = 0
	self.bonus_aim_time = 0
	self.perk_fast_swings = {}
end

function AILocomotion:_init_inventory(profile)
	local helmet_attachments = profile.helmet.attachments
	local armour_name = profile.armour
	local pattern_index = profile.armour_pattern_index or 1

	if self.id then
		local data_table = {
			player_game_obj_id = self.id,
			head = NetworkLookup.heads[profile.head],
			helmet = NetworkLookup.helmets[profile.helmet.name],
			helmet_visor = helmet_attachments.visor and NetworkLookup.helmet_attachments[helmet_attachments.visor] or 0,
			helmet_plume = helmet_attachments.plume and NetworkLookup.helmet_attachments[helmet_attachments.plume] or 0,
			helmet_feathers = helmet_attachments.feathers and NetworkLookup.helmet_attachments[helmet_attachments.feathers] or 0,
			helmet_coif = helmet_attachments.coif and NetworkLookup.helmet_attachments[helmet_attachments.coif] or 0,
			helmet_bevor = helmet_attachments.bevor and NetworkLookup.helmet_attachments[helmet_attachments.bevor] or 0,
			helmet_pattern = helmet_attachments.bevor and NetworkLookup.helmet_attachments[helmet_attachments.bevor] or 0,
			helmet_show_crest = profile.helmet.show_crest,
			armour = NetworkLookup.armours[armour_name],
			armour_pattern = pattern_index,
			game_object_created_func = NetworkLookup.game_object_functions.cb_player_profile_created,
			owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
			object_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing
		}

		for _, slot in ipairs(PerkSlots) do
			data_table[slot.game_object_field] = 0
		end

		local callback = callback(self, "cb_game_session_disconnect")

		self._player_profile_game_obj_id = Managers.state.network:create_game_object("player_profile", data_table, callback)
	end

	self:_setup_inventory(profile)
end

function AILocomotion:_setup_inventory(player_profile)
	local player = self.player
	local tint_color = {
		1,
		0,
		0.5
	}
	local secondary_tint_color = {
		1,
		1,
		1
	}
	local team = player.team

	if team then
		tint_color = team.color
		secondary_tint_color = team.secondary_color
	end

	local inventory = AIUnitInventory:new(self.world, self.unit, player, self.id, tint_color, secondary_tint_color)

	self._inventory = inventory

	for _, profile_gear in ipairs(player_profile.gear) do
		inventory:add_gear(profile_gear.name, nil, true, profile_gear.attachments, self)
	end

	for _, profile_gear in ipairs(player_profile.wielded_gear) do
		local wield_slot_name = GearTypes[Gear[profile_gear.name].gear_type].inventory_slot
		local main_body_state, hand_anim = inventory:set_gear_wielded(wield_slot_name, true, true)

		if main_body_state then
			self.current_state:anim_event(main_body_state, true)
		end

		if hand_anim then
			self.current_state:anim_event(hand_anim, true)
		end
	end

	local encumbrance_multiplier = self:has_perk("armour_training") and Perks.armour_training.encumbrance_multiplier or 1

	inventory:add_armour(player_profile.armour, player_profile.armour_attachments.patterns, encumbrance_multiplier)
	inventory:add_head(player_profile.head, player_profile.head_material)
	inventory:add_helmet(player_profile.helmet.name, team.name)

	local helmet_name = player_profile.helmet.name
	local helmet_settings = Helmets[helmet_name]
	local helmet = player_profile.helmet
	local pattern

	for attachment_type, attachment_name in pairs(helmet.attachments) do
		if attachment_type == "pattern" then
			pattern = helmet_settings.attachments[attachment_name]
		else
			inventory:add_helmet_attachment(helmet_name, attachment_type, attachment_name, team.name)
		end
	end

	if pattern then
		ProfileHelper:set_gear_patterns(inventory:helmet_unit(), helmet_settings.meshes, pattern)

		for attachment_type, attachment_name in pairs(helmet.attachments) do
			local attachment = helmet_settings.attachments[attachment_name]
			local attachment_meshes = attachment.meshes

			if attachment_meshes then
				local unit = inventory:helmet_attachment_unit(attachment_type)

				ProfileHelper:set_gear_patterns(unit, attachment_meshes, pattern)
			end
		end
	end

	local crest_name = CoatOfArmsHelper:coat_of_arms_setting("crests", PlayerCoatOfArms.crest).crest_name

	if helmet.show_crest and crest_name then
		inventory:add_helmet_crest(crest_name, team.name)
	end

	inventory:add_coat_of_arms(PlayerCoatOfArms, team.name)
end

function AILocomotion:update(t, dt, context, force)
	Profiler.start("AILocomotion")

	self._force = force

	self.current_state:update(dt, t)
	self.current_state:post_update(dt, t)
	self._inventory:update(dt, t)
	Profiler.stop()
end

function AILocomotion:_update_culling(dt, t)
	local unit = self.unit
	local position = Unit.world_position(unit, 0)
	local viewport_name = Managers.player:player(1).viewport_name
	local camera_position = Managers.state.camera:camera_position(viewport_name)
	local distance = Vector3.length(position - camera_position)

	if GameSettingsDevelopment.bone_lod_ais then
		self:_update_bone_lod(dt, unit, distance)
	end
end

function AILocomotion:_update_bone_lod(dt, unit, distance)
	local bone_lod = self._bone_lod
	local ranged_weapon = self._inventory:wielded_ranged_weapon_slot()

	if bone_lod == 0 and distance > GameSettingsDevelopment.bone_lod_ais.lod_out_range then
		self._bone_lod = ranged_weapon and 1 or 2
	elseif bone_lod > 0 and distance < GameSettingsDevelopment.bone_lod_ais.lod_in_range then
		self._bone_lod = 0
	elseif bone_lod == 2 and ranged_weapon then
		self._bone_lod = 1
	elseif bone_lod == 1 and not ranged_weapon then
		self._bone_lod = 2
	end

	Unit.set_bones_lod(unit, self._bone_lod)

	local head = self._inventory:head()

	Unit.set_bones_lod(head, math.clamp(self._bone_lod, 0, 1))
end

function AILocomotion:update_locomotion(t, dt)
	local wanted_vel = self:_calculate_wanted_velocity(t, dt)

	self:_update_look(t, dt, wanted_vel)
	self:_update_animation(t, dt, wanted_vel)
	self:_update_rotation(t, dt, wanted_vel)
	self:_update_movement(t, dt, wanted_vel)

	if not Managers.lobby.server then
		self:_update_culling(dt, t)
	end
end

function AILocomotion:_calculate_wanted_velocity(t, dt)
	local accel = Vector3.flat(self._force)
	local accel_mag = Vector3.length(accel)
	local current_flat_vel = Vector3.flat(self._velocity:unbox())
	local target_vel = current_flat_vel + accel
	local target_speed = Vector3.length(target_vel)
	local wanted_vel = math.lerp(target_speed * Vector3.normalize(current_flat_vel), target_vel, settings.rotation_speed * dt)
	local wanted_speed = Vector3.length(wanted_vel)

	if wanted_speed > settings.jog_threshold then
		wanted_vel = Vector3.normalize(wanted_vel) * settings.jog_threshold
	end

	if wanted_speed < 0.25 * settings.walk_threshold and accel_mag < 0.25 then
		wanted_vel = Vector3.zero()
	end

	if self.aiming then
		wanted_vel = wanted_vel * self._inventory:weapon_pose_movement_multiplier(self.aim_slot_name)
	elseif self.posing then
		wanted_vel = wanted_vel * self._inventory:weapon_pose_movement_multiplier(self.pose_slot_name)
	elseif self.blocking or self.parrying then
		wanted_vel = wanted_vel * self._inventory:weapon_pose_movement_multiplier(self.block_slot_name)
	end

	local slot_name = self._inventory:wielded_ranged_weapon_slot()

	if slot_name then
		local gear = self._inventory:_gear(slot_name)
		local weapon_ext = gear:extensions().base

		if weapon_ext:reloading() or not weapon_ext:can_aim() then
			wanted_vel = Vector3.zero()
		end
	end

	return wanted_vel
end

function AILocomotion:_update_look(t, dt, wanted_vel)
	local unit_rot = Unit.world_rotation(self.unit, 0)
	local unit_fwd = Quaternion.forward(unit_rot)
	local unit_rot_fwd = Quaternion.look(Vector3.flat(unit_fwd), Vector3.up())

	if not self._override_look_target then
		local new_look_dir = Vector3.normalize(wanted_vel)
		local wanted_speed = Vector3.length(wanted_vel)

		if wanted_speed == 0 then
			new_look_dir = Quaternion.forward(unit_rot)
		end

		local old_look_target = self._look_target:unbox()
		local unit_head_pos = Unit.world_position(self.unit, Unit.node(self.unit, "camera_attach"))
		local new_look_target = unit_head_pos + 3 * new_look_dir

		self._wanted_look_target:store(new_look_target)
	end

	self._override_look_target = false

	local current_look_target = self._look_target:unbox()
	local wanted_look_target = self._wanted_look_target:unbox()
	local look_target = math.lerp(current_look_target, wanted_look_target, settings.aim_speed * dt)

	self._look_target:store(look_target)

	local unit_pos = Unit.world_position(self.unit, 0)
	local aim_dir = 3 * Vector3.normalize(Vector3.flat(look_target - unit_pos))
	local aim_rot = Quaternion.look(aim_dir, Vector3.up())

	self._aim_direction:store(aim_dir)

	local rot_diff = Quaternion.multiply(Quaternion.inverse(unit_rot_fwd), aim_rot)
	local rot_diff_fwd = Quaternion.forward(rot_diff)
	local angle = math.atan2(rot_diff_fwd.x, rot_diff_fwd.y)
	local scaled_angle = 2 * angle / math.pi

	fassert(Math.is_valid(scaled_angle), "Invalid angle %d", scaled_angle)
	Unit.animation_set_variable(self.unit, self._look_direction_var, scaled_angle)
	fassert(Vector3.is_valid(look_target), "Invalid vector %q", look_target)
	Unit.animation_set_constraint_target(self.unit, self._aim_constraint_var, look_target)
	self._inventory:set_eye_target(look_target)

	if self.game and self.id then
		GameSession.set_game_object_field(self.game, self.id, "aim_target", aim_dir)
	end
end

function AILocomotion:_update_animation(t, dt, wanted_vel)
	local wanted_speed = Vector3.length(wanted_vel)

	if wanted_speed == 0 then
		self:_change_movement_type("idle")
	else
		local aim_dir = self._aim_direction:unbox()
		local move_dir = Vector3.dot(wanted_vel, aim_dir)

		if move_dir > 0 then
			self:_change_movement_type("move_forward")
		elseif move_dir < 0 then
			self:_change_movement_type("move_backward")

			wanted_vel = wanted_vel * PlayerUnitMovementSettings.BWD_MOVE_SPEED_SCALE
		end
	end

	local anim_speed_var, anim_speed_multiplier, anim_rush_var = self:_calculate_anim_speed_from_mps(wanted_speed)

	Unit.animation_set_variable(self.unit, self._move_speed_var, anim_speed_var)
	Unit.animation_set_variable(self.unit, self._move_multiplier_var, anim_speed_multiplier)
	Unit.animation_set_variable(self.unit, self._rush_speed_var, anim_rush_var)
end

function AILocomotion:_change_movement_type(move_type)
	if self._move_type ~= move_type then
		if move_type == "idle" then
			Managers.state.event:trigger("ai_event_stopped", self.unit)
		else
			Managers.state.event:trigger("ai_event_moving", self.unit)
		end

		self._move_type = move_type

		local anim_event = self._move_events[move_type]

		fassert(anim_event, "No animation associated with movement type %q", move_type)
		self.current_state:anim_event(anim_event)
	end
end

function AILocomotion:_calculate_anim_speed_from_mps(wanted_speed)
	local speed_var, speed_multiplier = 0, 1

	if wanted_speed <= settings.walk_threshold then
		speed_var = 0
		speed_multiplier = wanted_speed / settings.walk_threshold
	elseif wanted_speed <= settings.jog_threshold then
		speed_var = (wanted_speed - settings.walk_threshold) / (settings.jog_threshold - settings.walk_threshold)
	elseif wanted_speed <= settings.run_threshold then
		speed_var = 1 + (wanted_speed - settings.jog_threshold) / (settings.run_threshold - settings.jog_threshold)
	else
		speed_var = 3
		speed_multiplier = wanted_speed / settings.run_threshold
	end

	return speed_var, speed_multiplier, wanted_speed
end

function AILocomotion:_update_rotation(t, dt, wanted_vel)
	local move_bwd = self._move_type == "move_backward" and -1 or 1
	local wanted_speed = Vector3.length(wanted_vel)
	local new_rot

	if wanted_speed == 0 then
		local aim_dir = self._aim_direction:unbox()

		new_rot = Quaternion.look(aim_dir, Vector3.up())
	else
		new_rot = Quaternion.look(move_bwd * wanted_vel, Vector3.up())
	end

	Unit.set_local_rotation(self.unit, 0, new_rot)

	if self.game and self.id then
		fassert(Quaternion.is_valid(new_rot), "Invalid new_rot %s", new_rot)
		GameSession.set_game_object_field(self.game, self.id, "rotation", new_rot)
	end
end

function AILocomotion:_update_movement(t, dt, wanted_vel)
	local current_vel = self._velocity:unbox()
	local z_velocity = current_vel.z
	local inv_drag_force = 0.00225 * math.abs(z_velocity) * z_velocity

	wanted_vel.z = current_vel.z - (9.82 + inv_drag_force) * dt

	local unit_pos = Mover.position(self._mover)

	Mover.move(self._mover, wanted_vel * dt, dt)

	local final_pos = Mover.position(self._mover)
	local final_vel = (final_pos - unit_pos) / dt

	if final_vel.z > 0 then
		final_vel.z = 0
	end

	self._velocity:store(final_vel)
	Unit.set_local_position(self.unit, 0, final_pos)

	if self.game and self.id then
		fassert(Vector3.is_valid(final_pos), "Invalid final_pos %s", final_pos)

		local max = NetworkConstants.position.max
		local min = NetworkConstants.position.min

		GameSession.set_game_object_field(self.game, self.id, "position", Vector3.min(Vector3.max(final_pos, Vector3(min, min, min)), Vector3(max, max, max)))
		fassert(Vector3.is_valid(final_vel), "Invalid final vel %s", final_vel)
		GameSession.set_game_object_field(self.game, self.id, "velocity", final_vel)
	end
end

function AILocomotion:set_pose(pose)
	local pos = Matrix4x4.translation(pose)

	Mover.set_position(self._mover, pos)
	Unit.set_local_pose(self.unit, 0, pose)

	if self.game and self.id then
		fassert(Vector3.is_valid(pos), "Invalid pos %s", pos)

		local max = NetworkConstants.position.max
		local min = NetworkConstants.position.min

		GameSession.set_game_object_field(self.game, self.id, "position", Vector3.min(Vector3.max(pos, Vector3(min, min, min)), Vector3(max, max, max)))
	end
end

function AILocomotion:set_look_target(pos)
	self._override_look_target = true

	self._wanted_look_target:store(pos)
end

function AILocomotion:look_target()
	return self._look_target:unbox()
end

function AILocomotion:player()
	return self._player
end

function AILocomotion:set_velocity(velocity)
	self._velocity:store(velocity)
end

function AILocomotion:get_velocity()
	return self._velocity:unbox()
end

function AILocomotion:set_pose_blends(pose_x, pose_y)
	Unit.animation_set_variable(self.unit, self._pose_x_var, pose_x)
	Unit.animation_set_variable(self.unit, self._pose_y_var, pose_y)

	if self.game and self.id then
		GameSession.set_game_object_field(self.game, self.id, "pose_anim_blend_value", Vector3(pose_x, pose_y, 0))
	end
end

function AILocomotion:get_pose_blends()
	return Unit.animation_get_variable(self.unit, self._pose_x_var), Unit.animation_get_variable(self.unit, self._pose_y_var)
end

function AILocomotion:inventory()
	return self._inventory
end

function AILocomotion:aim_direction()
	return self._aim_direction:unbox()
end

function AILocomotion:player_dead()
	self:_change_state("dead")
end

function AILocomotion:has_perk(perk_name)
	return false
end

function AILocomotion:mount(mount_unit)
	self.mounted_unit = mount_unit

	self:_change_state("mounted")
end

function AILocomotion:unmount(mount_unit)
	if self.current_state_name == "mounted" and self.mounted_unit == mount_unit then
		self:_change_state("onground")
	end
end

function AILocomotion:mounted()
	return self.current_state_name == "mounted"
end

function AILocomotion:destroy()
	self._inventory:destroy()
end

function AILocomotion:destroy_game_objects()
	Managers.state.network:destroy_game_object(self.id)
	Managers.state.network:destroy_game_object(self._player_profile_game_obj_id)
end

function AILocomotion:wield_weapon(slot_name)
	for name, _ in pairs(self._inventory:wielded_slots()) do
		if name ~= slot_name then
			self.current_state:wield_weapon(slot_name)
		end
	end
end

function AILocomotion:begin_melee_attack(swing_dir, charge_time)
	self.current_state:melee_attack(swing_dir, charge_time)
end

function AILocomotion:begin_ranged_attack(draw_time)
	self.current_state:ranged_attack(draw_time)
end

function AILocomotion:block_attack(direction, attacking_units_locomotion)
	self.current_state:block_attack(direction, attacking_units_locomotion)
end

function AILocomotion:hot_join_synch(sender, player)
	local network_manager = Managers.state.network
	local player_object_id = self.id
	local unit = self.unit

	RPC.rpc_synch_player_anim_state(sender, player_object_id, Unit.animation_get_state(unit))

	if self.mounted_unit and Managers.player:owner(self.mounted_unit) == self.player then
		local mount_object_id = network_manager:unit_game_object_id(self.mounted_unit)

		RPC.rpc_mounted_husk(sender, player_object_id, mount_object_id, self.player.temp_random_user_id)
	end

	if self.block_direction then
		RPC.rpc_hot_join_synch_parry_block(sender, player_object_id, NetworkLookup.inventory_slots[self.block_slot_name], NetworkLookup.directions[self.block_direction])
	end

	if self.carried_flag then
		RPC.rpc_flag_pickup_confirmed(sender, self.id, network_manager:game_object_id(self.carried_flag))
	end

	if self.posing then
		RPC.rpc_hot_join_synch_pose(sender, player_object_id, NetworkLookup.directions[self.pose_direction])
	end

	self._inventory:hot_join_synch(sender, player, player_object_id)
end

function AILocomotion:damage_interrupt(hit_zone, impact_direction, impact_type)
	self.current_state:safe_action_interrupt(impact_type)
	WeaponHelper:player_unit_hit_reaction_animation(self.unit, hit_zone, impact_direction, self:aim_direction(), impact_type)
end

function AILocomotion:hurt_sound_event()
	return "husk_vce_hurt"
end
