-- chunkname: @scripts/unit_extensions/default_player_unit/player_husk_locomotion.lua

require("scripts/unit_extensions/default_player_unit/inventory/player_husk_inventory")
require("scripts/settings/hud_settings")

local MOUNT_LINK_NODE = "CharacterAttach"

PlayerHuskLocomotion = class(PlayerHuskLocomotion)
PlayerHuskLocomotion.SYSTEM = "locomotion_system"

function PlayerHuskLocomotion:init(world, unit, id, game, ghost_mode)
	self._world = world
	self._unit = unit
	self._game = game
	self._id = id

	Unit.set_animation_merge_options(unit)

	self._velocity = Vector3Box(0, 0, 0)
	self._bone_lod = 0

	if script_data.network_debug then
		print("[PlayerHuskLocomotion:init( world, unit, id, game )", world, unit, id, game)
	end

	self._look_direction_anim_var = Unit.animation_find_variable(unit, "aim_direction")
	self._move_speed_anim_var = Unit.animation_find_variable(unit, "move_speed")
	self._rush_speed_anim_var = Unit.animation_find_variable(unit, "rush_speed")
	self._move_speed_multiplier_anim_var = Unit.animation_find_variable(unit, "double_time_speed")
	self._aim_constraint_anim_var = Unit.animation_find_constraint_target(unit, "aim_constraint_target")
	self._camera_attach_node = Unit.node(unit, "camera_attach")

	local player_index = GameSession.game_object_field(self._game, self._id, "player")
	local player_team_name = NetworkLookup.team[GameSession.game_object_field(self._game, self._id, "team_name")]

	Unit.set_data(unit, "player_index", player_index)
	Managers.player:assign_unit_ownership(unit, player_index, true)

	local team_manager = Managers.state.team
	local team = team_manager:team_by_name(player_team_name)

	for _, team_name in ipairs(team_manager:names()) do
		if not team or team_name == player_team_name then
			local actor = Unit.actor(unit, team_name)

			if actor then
				Actor.set_collision_enabled(actor, false)
				Actor.set_scene_query_enabled(actor, false)
			end
		end
	end

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

	if team then
		Unit.set_data(unit, "team_name", player_team_name)

		tint_color = team.color
		secondary_tint_color = team.secondary_color
	end

	local player = Managers.player:player(player_index)

	self:_setup_inventory(world, unit, player, tint_color, secondary_tint_color)
	Managers.state.event:trigger("player_spawned", player, unit)

	if ghost_mode then
		self.ghost_mode = true

		self:_enter_ghost_mode()
	else
		self.ghost_mode = false
	end

	self.player = player
	self._ladder_anim_var = Unit.animation_find_variable(unit, "climb_time")
	self._physics_culled = false

	local level_settings = LevelHelper:current_level_settings()
	local flow_event = level_settings.on_spawn_flow_event

	if flow_event then
		Unit.flow_event(unit, flow_event)
	end

	self.in_combat = GameSession.game_object_field(game, id, "in_combat")
	self._movement_collision_shape_active = true
end

function PlayerHuskLocomotion:_enter_ghost_mode()
	self.ghost_mode_hide = true

	local unit = self._unit

	Unit.set_unit_visibility(unit, false)

	for _, actor_name in ipairs(PlayerUnitMovementSettings.ghost_mode.husk_actors) do
		local actor = Unit.actor(unit, actor_name)

		if actor then
			Actor.set_collision_enabled(actor, false)
			Actor.set_scene_query_enabled(actor, false)
		end
	end

	local inventory = self._inventory

	inventory:enter_ghost_mode()
	Unit.flow_event(unit, "disable_vfx")
end

function PlayerHuskLocomotion:_exit_ghost_mode()
	self.ghost_mode_hide = false

	local unit = self._unit

	Unit.set_unit_visibility(unit, true)
	Unit.set_visibility(unit, "decapitated", false)

	for _, actor_name in ipairs(PlayerUnitMovementSettings.ghost_mode.husk_actors) do
		local actor = Unit.actor(unit, actor_name)

		if actor then
			Actor.set_collision_enabled(actor, true)
			Actor.set_scene_query_enabled(actor, true)
		end
	end

	local inventory = self._inventory

	inventory:exit_ghost_mode()
	Unit.flow_event(unit, "enable_vfx")
end

function PlayerHuskLocomotion:set_ladder_unit(ladder_unit)
	self.ladder_unit = ladder_unit
end

function PlayerHuskLocomotion:rpc_add_instakill_push(velocity, mass, hit_zone_name)
	self._instakill_push = {
		velocity = velocity,
		mass = mass,
		hit_zone_name = hit_zone_name
	}
end

function PlayerHuskLocomotion:_apply_instakill_push(instakill_table)
	local hit_zone = PlayerUnitDamageSettings.hit_zones[instakill_table.hit_zone_name]
	local ragdoll_actor = hit_zone.ragdoll_actor
	local actor = Unit.actor(self._unit, ragdoll_actor)

	Actor.push(actor, instakill_table.velocity, instakill_table.mass)
end

function PlayerHuskLocomotion:setup_player_profile(obj_id)
	self._player_profile_game_obj_id = obj_id

	local inventory = self._inventory
	local unit = self._unit
	local armour = NetworkLookup.armours[GameSession.game_object_field(self._game, obj_id, "armour")]
	local head = NetworkLookup.heads[GameSession.game_object_field(self._game, obj_id, "head")]
	local head_material = NetworkLookup.heads[GameSession.game_object_field(self._game, obj_id, "head_material")]
	local helmet_name = NetworkLookup.helmets[GameSession.game_object_field(self._game, obj_id, "helmet")]
	local pattern_index = GameSession.game_object_field(self._game, obj_id, "armour_pattern")
	local voice = GameSession.game_object_field(self._game, obj_id, "voice")

	inventory:add_armour(armour, pattern_index)
	inventory:add_head(head, head_material, NetworkLookup.voices[voice] .. "_husk")
	inventory:add_helmet(helmet_name)

	local helmet_attachments = {
		visor = GameSession.game_object_field(self._game, obj_id, "helmet_visor"),
		plume = GameSession.game_object_field(self._game, obj_id, "helmet_plume"),
		feathers = GameSession.game_object_field(self._game, obj_id, "helmet_feathers"),
		coif = GameSession.game_object_field(self._game, obj_id, "helmet_coif"),
		bevor = GameSession.game_object_field(self._game, obj_id, "helmet_bevor"),
		pattern = GameSession.game_object_field(self._game, obj_id, "helmet_pattern")
	}
	local helmet_settings = Helmets[helmet_name]
	local pattern

	for attachment_type, attachment_name_id in pairs(helmet_attachments) do
		if attachment_name_id ~= 0 then
			local attachment_name = NetworkLookup.helmet_attachments[attachment_name_id]

			if attachment_type == "pattern" then
				pattern = helmet_settings.attachments[attachment_name]
			else
				inventory:add_helmet_attachment(helmet_name, attachment_type, attachment_name, Unit.get_data(unit, "team_name"))
			end
		end
	end

	if pattern then
		ProfileHelper:set_gear_patterns(inventory:helmet_unit(), helmet_settings.meshes, pattern)

		for attachment_type, attachment_name_id in pairs(helmet_attachments) do
			if attachment_name_id ~= 0 then
				local attachment = helmet_settings.attachments[NetworkLookup.helmet_attachments[attachment_name_id]]
				local attachment_meshes = attachment.meshes

				if attachment_meshes then
					local unit = inventory:helmet_attachment_unit(attachment_type)

					ProfileHelper:set_gear_patterns(unit, attachment_meshes, pattern)
				end
			end
		end
	end

	local player_coat_of_arms = self.player.coat_of_arms
	local show_crest = GameSession.game_object_field(self._game, obj_id, "helmet_show_crest")
	local crest_name = CoatOfArmsHelper:coat_of_arms_setting("crests", player_coat_of_arms.crest).crest_name

	if show_crest and crest_name then
		self._inventory:add_helmet_crest(crest_name, Unit.get_data(unit, "team_name"))
	end

	self._inventory:add_coat_of_arms(player_coat_of_arms, Unit.get_data(unit, "team_name"))
end

function PlayerHuskLocomotion:has_perk(perk_name)
	local obj_id = self._player_profile_game_obj_id

	if not obj_id then
		print("[PlayerHuskLocomotion:has_perk] WARNING! husk does not yet have perk game object synchronized!")

		return false
	end

	if not GameSession.game_object_exists(self._game, obj_id) then
		print("[PlayerHuskLocomotion:has_perk] WARNING! husk has already destroyed perk game object!")

		return false
	end

	for _, slot in ipairs(PerkSlots) do
		local perk_lookup = GameSession.game_object_field(self._game, obj_id, slot.game_object_field)
		local perk

		if perk_lookup ~= 0 then
			perk = NetworkLookup.perks[perk_lookup]
		end

		if perk and perk == perk_name then
			return true
		end
	end

	return false
end

function PlayerHuskLocomotion:update(unit, input, dt, context)
	Profiler.start("PlayerHuskLocomotion:update")

	if self._game and self._id then
		local movement_state = NetworkLookup.movement_states[GameSession.game_object_field(self._game, self._id, "movement_state")]

		self:update_movement(dt, unit, movement_state)
		self:update_aim_target(dt, unit)

		local game = self._game
		local id = self._id
		local pose_blend = GameSession.game_object_field(game, id, "pose_anim_blend_value")
		local x_variable_index = Unit.animation_find_variable(unit, "pose_x")
		local y_variable_index = Unit.animation_find_variable(unit, "pose_y")

		Unit.animation_set_variable(unit, x_variable_index, pose_blend.x)
		Unit.animation_set_variable(unit, y_variable_index, pose_blend.y)

		local lean_values = GameSession.game_object_field(game, id, "pose_lean_anim_blend_value")
		local height_var = Unit.animation_find_variable(unit, "horse_lean_swing_height")
		local lean_var = Unit.animation_find_variable(unit, "horse_lean")

		Unit.animation_set_variable(unit, lean_var, math.clamp(lean_values.x, -0.99, 0.99))
		Unit.animation_set_variable(unit, height_var, lean_values.y)

		if script_data.husk_lean_debug then
			Managers.state.debug_text:output_screen_text(string.format("lean: %.2f height: %.2f ", lean_values.x, lean_values.y), 40, 0, Vector3(255, 255, 255))
		end

		local ghost_mode = GameSession.game_object_field(self._game, self._id, "ghost_mode")
		local player_manager = Managers.player
		local local_player = player_manager:player_exists(1) and player_manager:player(1)

		self.ghost_mode = ghost_mode

		local ghost_mode_hide = ghost_mode and (not local_player or local_player.team ~= self.player.team or local_player.spawn_data.state ~= "ghost_mode")

		if not ghost_mode_hide and self.ghost_mode_hide then
			self:_exit_ghost_mode()
		elseif ghost_mode_hide and not self.ghost_mode_hide then
			self:_enter_ghost_mode()
		end

		self:_update_collision(dt, unit, movement_state)

		if not Managers.lobby.server then
			self:_update_culling(dt)
		end

		self.in_combat = GameSession.game_object_field(game, id, "in_combat")
	end

	Profiler.stop()
end

function PlayerHuskLocomotion:_update_collision(dt, unit, movement_state)
	if self.ghost_mode then
		return
	end

	local collision_active = self._movement_collision_shape_active

	if collision_active and (movement_state == "dead" or movement_state == "knocked_down") then
		local actor = Unit.actor(unit, "husk")

		Actor.set_collision_enabled(actor, false)
		Actor.set_scene_query_enabled(actor, false)

		self._movement_collision_shape_active = false
	elseif not collision_active and movement_state ~= "dead" and movement_state ~= "knocked_down" then
		local actor = Unit.actor(unit, "husk")

		Actor.set_collision_enabled(actor, true)
		Actor.set_scene_query_enabled(actor, true)

		self._movement_collision_shape_active = true
	end
end

function PlayerHuskLocomotion:_update_culling(dt)
	local unit = self._unit
	local position = Unit.world_position(unit, 0)
	local viewport_name = Managers.player:player(1).viewport_name
	local camera_position = Managers.state.camera:camera_position(viewport_name)
	local distance = Vector3.length(position - camera_position)

	if GameSettingsDevelopment.bone_lod_husks then
		self:_update_bone_lod(dt, unit, distance)
	end

	if GameSettingsDevelopment.physics_cull_husks then
		self:_update_physics_culling(dt, unit, distance)
	end
end

function PlayerHuskLocomotion:_update_bone_lod(dt, unit, distance)
	local bone_lod = self._bone_lod
	local ranged_weapon = self._inventory:wielded_ranged_weapon_slot()

	if bone_lod == 0 and distance > GameSettingsDevelopment.bone_lod_husks.lod_out_range then
		self._bone_lod = ranged_weapon and 1 or 2
	elseif bone_lod > 0 and distance < GameSettingsDevelopment.bone_lod_husks.lod_in_range then
		self._bone_lod = 0
	elseif bone_lod == 2 and ranged_weapon then
		self._bone_lod = 1
	elseif bone_lod == 1 and not ranged_weapon then
		self._bone_lod = 2
	end

	Unit.set_bones_lod(unit, self._bone_lod)

	local head = self._inventory:head()

	if head then
		Unit.set_bones_lod(head, math.clamp(self._bone_lod, 0, 1))
	end
end

function PlayerHuskLocomotion:_update_physics_culling(dt, unit, distance)
	if not self._physics_culled and distance > GameSettingsDevelopment.physics_cull_husks.cull_range then
		Unit.flow_event(unit, "lua_disable_hit_detection")

		local helmet = self._inventory:helmet()

		if helmet then
			Unit.flow_event(helmet, "lua_disable_hit_detection")
		end

		self._physics_culled = true
	elseif self._physics_culled and distance < GameSettingsDevelopment.physics_cull_husks.uncull_range then
		Unit.flow_event(unit, "lua_enable_hit_detection")

		local helmet = self._inventory:helmet()

		if helmet then
			Unit.flow_event(helmet, "lua_enable_hit_detection")
		end

		local damage_ext = ScriptUnit.extension(unit, "damage_system")

		damage_ext:_setup_hit_zones(PlayerUnitDamageSettings.hit_zones)

		self._physics_culled = false
	end
end

function PlayerHuskLocomotion:rpc_gear_dead(unit)
	self:gear_dead(unit)
end

function PlayerHuskLocomotion:gear_dead(unit)
	local inventory = self._inventory
	local slot_name = inventory:find_slot_by_unit(unit)

	inventory:gear_dead(slot_name)
end

local POS_EPSILON = 0.01
local POS_LERP_TIME = 0.1

function PlayerHuskLocomotion:update_movement(dt, unit, movement_state)
	local old_pos = Unit.local_position(unit, 0)
	local new_pos = GameSession.game_object_field(self._game, self._id, "position")
	local new_rot = GameSession.game_object_field(self._game, self._id, "rotation")
	local mounted = self._mounted
	local velocity = GameSession.game_object_field(self._game, self._id, "velocity")

	if Vector3.length(velocity) < NetworkConstants.VELOCITY_EPSILON then
		velocity = Vector3(0, 0, 0)
	end

	if not mounted and movement_state ~= "mounted/dismounting" and movement_state ~= "mounted" then
		self:_extrapolation_movement(unit, dt, old_pos, new_pos, new_rot, movement_state, mounted, velocity)
	elseif mounted and movement_state == "mounted/dismounting" then
		self:_dismount_movement(unit, dt, old_pos, new_pos, new_rot, movement_state, mounted, velocity)
	elseif not mounted and movement_state == "mounted/dismounting" then
		local last_linked_mount = self._last_linked_mount
		local offset_position

		if Unit.alive(last_linked_mount) then
			local link_node = Unit.node(last_linked_mount, MOUNT_LINK_NODE)

			offset_position = Unit.world_position(last_linked_mount, link_node)
		elseif self._last_linked_mount_pos then
			offset_position = self._last_linked_mount_pos:unbox()
		end

		if offset_position then
			self:_dismount_movement(unit, dt, old_pos, new_pos + offset_position, new_rot, movement_state, mounted, velocity)
		end
	elseif mounted and movement_state == "mounted" then
		self:_mounted_movement(unit, dt, old_pos, new_pos, new_rot, movement_state, mounted, velocity)
	elseif not mounted and movement_state == "mounted" then
		self:_extrapolation_movement(unit, dt, old_pos, new_pos, new_rot, movement_state, mounted, velocity)
	end

	self._velocity:store(velocity)

	if not self._mounted then
		self:_update_speed_variable()
	end
end

function PlayerHuskLocomotion:_dismount_movement(unit, dt, old_pos, new_pos, new_rot, movement_state, mounted, velocity)
	local new_dismounting_pos = Vector3.lerp(old_pos, new_pos, dt * 15)

	Unit.set_local_position(unit, 0, new_dismounting_pos)

	self._pos_lerp_time = 0

	Unit.set_data(unit, "last_lerp_position", Unit.world_position(unit, 0))
	Unit.set_data(unit, "last_lerp_position_offset", Vector3(0, 0, 0))
	Unit.set_data(unit, "accumulated_movement", Vector3(0, 0, 0))
end

function PlayerHuskLocomotion:_mounted_movement(unit, dt, old_pos, new_pos, new_rot, movement_state, mounted, velocity)
	self._pos_lerp_time = 0

	Unit.set_data(unit, "last_lerp_position", Unit.world_position(unit, 0))
	Unit.set_data(unit, "last_lerp_position_offset", Vector3(0, 0, 0))
	Unit.set_data(unit, "accumulated_movement", Vector3(0, 0, 0))
end

function PlayerHuskLocomotion:_extrapolation_movement(unit, dt, old_pos, new_pos, new_rot, movement_state, mounted, velocity)
	local last_pos = Unit.get_data(unit, "last_lerp_position") or old_pos
	local last_pos_offset = Unit.get_data(unit, "last_lerp_position_offset") or Vector3(0, 0, 0)
	local accumulated_movement = Unit.get_data(unit, "accumulated_movement") or Vector3(0, 0, 0)

	self._pos_lerp_time = (self._pos_lerp_time or 0) + dt

	local lerp_t = self._pos_lerp_time / POS_LERP_TIME
	local move_delta = velocity * dt

	accumulated_movement = accumulated_movement + move_delta

	local lerp_pos = Vector3.lerp(last_pos_offset, Vector3(0, 0, 0), math.min(lerp_t, 1))
	local pos = last_pos + accumulated_movement + lerp_pos

	Profiler.record_statistics("move_delta", Vector3.length(move_delta))
	Profiler.record_statistics("husk_speed", Vector3.length(velocity))
	Profiler.record_statistics("dt", dt)
	Unit.set_data(unit, "accumulated_movement", accumulated_movement)

	if Vector3.length(new_pos - last_pos) > POS_EPSILON then
		self._pos_lerp_time = 0

		Unit.set_data(unit, "last_lerp_position", new_pos)
		Unit.set_data(unit, "last_lerp_position_offset", pos - new_pos)
		Unit.set_data(unit, "accumulated_movement", Vector3(0, 0, 0))
	end

	Unit.set_local_position(unit, 0, pos)

	local old_rot = Unit.local_rotation(unit, 0)

	Unit.set_local_rotation(unit, 0, Quaternion.lerp(old_rot, new_rot, math.min(dt * 15, 1)))

	local ladder_unit = self.ladder_unit

	if Unit.alive(ladder_unit) then
		local ladder_pos = Unit.world_position(ladder_unit, 0)
		local ladder_rot = Unit.world_rotation(ladder_unit, 0)
		local ladder_dist = Vector3.dot(pos - ladder_pos, Quaternion.up(ladder_rot))
		local ladder_anim_val = ClimbHelper.ladder_anim_val(ladder_dist)

		Unit.animation_set_variable(unit, self._ladder_anim_var, ladder_anim_val)
	end
end

local WALK_THRESHOLD = 0.97
local JOG_THRESHOLD = 3.23
local RUN_THRESHOLD = 6.14

function PlayerHuskLocomotion:_update_speed_variable()
	local velocity = self._velocity:unbox()
	local flat_velocity = Vector3(velocity.x, velocity.y, 0)
	local speed = Vector3.length(flat_velocity)
	local unit = self._unit
	local move_speed_var_value, speed_multiplier = self:_calculate_move_speed_var_from_mps(speed)

	Unit.animation_set_variable(unit, self._move_speed_anim_var, move_speed_var_value)
	Unit.animation_set_variable(unit, self._move_speed_multiplier_anim_var, speed_multiplier)
	Unit.animation_set_variable(unit, self._rush_speed_anim_var, speed)
end

function PlayerHuskLocomotion:_calculate_move_speed_var_from_mps(move_speed)
	local speed_var
	local speed_multiplier = 1

	if move_speed <= WALK_THRESHOLD then
		speed_var = 0
		speed_multiplier = move_speed / WALK_THRESHOLD
	elseif move_speed <= JOG_THRESHOLD then
		speed_var = (move_speed - WALK_THRESHOLD) / (JOG_THRESHOLD - WALK_THRESHOLD)
	elseif move_speed <= RUN_THRESHOLD then
		speed_var = 1 + (move_speed - JOG_THRESHOLD) / (RUN_THRESHOLD - JOG_THRESHOLD)
	else
		speed_var = 3
		speed_multiplier = move_speed / RUN_THRESHOLD
	end

	return speed_var, speed_multiplier
end

function PlayerHuskLocomotion:update_aim_target(dt, unit)
	local aim_target = GameSession.game_object_field(self._game, self._id, "aim_target")
	local from_pos = Unit.world_position(unit, self._camera_attach_node)

	if script_data.lerp_debug or script_data.extrapolation_debug then
		local old_target = Matrix4x4.translation(Unit.animation_get_constraint_target(unit, self._aim_constraint_anim_var))
		local new_target = from_pos + aim_target
		local lerp_aim_target = Vector3.lerp(old_target, new_target, math.min(dt * 20, 1))

		Unit.animation_set_constraint_target(unit, self._aim_constraint_anim_var, lerp_aim_target)
		self._inventory:set_eye_target(lerp_aim_target)
	else
		Unit.animation_set_constraint_target(unit, self._aim_constraint_anim_var, from_pos + aim_target)
		self._inventory:set_eye_target(from_pos + aim_target)
	end

	local new_rot = GameSession.game_object_field(self._game, self._id, "rotation")
	local fwd_dir = Quaternion.forward(new_rot)

	Vector3.set_z(fwd_dir, 0)
	Vector3.set_z(aim_target, 0)

	local fwd_flat = Vector3.normalize(fwd_dir)
	local aim_dir_flat = Vector3.normalize(aim_target)
	local aim_angle = math.atan2(aim_dir_flat.y, aim_dir_flat.x) - math.atan2(fwd_flat.y, fwd_flat.x)
	local aim_direction = -((aim_angle / math.pi + 1) % 2 - 1) * 2

	Unit.animation_set_variable(unit, self._look_direction_anim_var, aim_direction)
end

function PlayerHuskLocomotion:set_mounted(mounted)
	self._mounted = mounted

	if mounted then
		local mount_node = Unit.node(mounted, MOUNT_LINK_NODE)

		World.link_unit(self._world, self._unit, mounted, mount_node)

		self._last_linked_mount = mounted
		self._last_linked_mount_pos = Vector3Box(Unit.local_position(mounted, mount_node))
	else
		World.unlink_unit(self._world, self._unit)
	end
end

function PlayerHuskLocomotion:mounted()
	return self._mounted ~= nil
end

function PlayerHuskLocomotion:destroy(u, input)
	local unit = self._unit
	local player_manager = Managers.player

	if player_manager:owner(unit) then
		player_manager:relinquish_unit_ownership(unit)
	end

	self._inventory:destroy()
	Managers.state.event:trigger("player_destroyed", unit)

	local flag = self.carried_flag

	if flag and Unit.alive(flag) and ScriptUnit.has_extension(flag, "flag_system") then
		local flag_ext = ScriptUnit.extension(flag, "flag_system")

		flag_ext:drop()
	end
end

function PlayerHuskLocomotion:_setup_inventory(world, unit, player, tint_color, secondary_tint_color, coat_of_arms)
	self._inventory = PlayerHuskInventory:new(world, unit, player, tint_color, secondary_tint_color, coat_of_arms)
end

function PlayerHuskLocomotion:inventory()
	return self._inventory
end

function PlayerHuskLocomotion:anim_cb(callback, unit, param)
	local func = self[callback]

	if func then
		func(self, param)
	end
end

function PlayerHuskLocomotion:anim_cb_hide_wielded_weapons()
	self._inventory:anim_cb_hide_wielded_weapons(true)
end

function PlayerHuskLocomotion:anim_cb_unhide_wielded_weapons()
	self._inventory:anim_cb_hide_wielded_weapons(false)
end

function PlayerHuskLocomotion:player_knocked_down()
	self._inventory:set_kinematic_wielded_gear(false)
end

function PlayerHuskLocomotion:player_dead(is_instakill, damage_type, hit_zone, impact_direction)
	local inventory = self._inventory

	if is_instakill and hit_zone == "head" and (damage_type == "cutting" or damage_type == "slashing") and GameSettingsDevelopment.allow_decapitation and inventory:allow_decapitation() then
		local head_unit = inventory:head()

		if head_unit and Unit.alive(head_unit) then
			Unit.set_visibility(head_unit, "head_all", false)
			Unit.set_visibility(head_unit, "head_decap", true)

			local unit = self._unit
			local actor = Unit.create_actor(unit, "decap_head", 0.9)

			Unit.set_visibility(unit, "undecapitated", false)
			Unit.set_visibility(unit, "decapitated", true)

			local impulse = impact_direction * 2 * 0.001

			Actor.add_impulse_at(actor, impulse, Vector3(0, 0, -0.1))
			Actor.add_impulse_at(actor, Vector3(0, 0, 0.006), Vector3(0, 0, -0.1))
		end
	end
end

function PlayerHuskLocomotion:rpc_start_revive()
	return
end

function PlayerHuskLocomotion:rpc_abort_revive()
	return
end

function PlayerHuskLocomotion:rpc_completed_revive()
	self._inventory:set_kinematic_wielded_gear(true)
end

function PlayerHuskLocomotion:rpc_raise_parry_block(slot_name, direction, delay)
	self.block_slot_name = slot_name
	self.block_unit = self._inventory:gear_unit(slot_name)
	self.block_direction = direction

	local t = Managers.time:time("game")

	self.block_start_time = t
	self.block_raised_time = t + delay
	self.parrying = true

	Unit.animation_event(self._unit, "parry_pose_" .. direction)
end

function PlayerHuskLocomotion:rpc_lower_parry_block()
	self.block_slot_name = nil
	self.block_unit = nil
	self.block_direction = nil
	self.parrying = false

	Unit.animation_event(self._unit, "parry_pose_exit")
end

function PlayerHuskLocomotion:rpc_hot_join_synch_parry_block(slot_name, direction)
	self.block_slot_name = slot_name
	self.block_unit = self._inventory:gear_unit(slot_name)
	self.block_direction = direction
	self.block_raised_time = 0
	self.parrying = true
end

function PlayerHuskLocomotion:rpc_raise_shield_block(slot_name)
	self.block_slot_name = slot_name
	self.block_unit = self._inventory:gear_unit(slot_name)
	self.blocking = true

	Unit.animation_event(self._unit, "shield_up")
end

function PlayerHuskLocomotion:rpc_lower_shield_block()
	self.block_slot_name = nil
	self.block_unit = nil
	self.blocking = false

	Unit.animation_event(self._unit, "shield_down")
end

function PlayerHuskLocomotion:rpc_hot_join_synch_shield_block(slot_name)
	self.block_slot_name = slot_name
	self.block_unit = self._inventory:gear_unit(slot_name)
	self.block_raised_time = 0
	self.blocking = true
end

function PlayerHuskLocomotion:rpc_pose_melee_weapon(direction)
	self.pose_direction = direction
	self.posing = true
end

function PlayerHuskLocomotion:rpc_stop_posing_melee_weapon()
	self.pose_direction = nil
	self.posing = false
end

function PlayerHuskLocomotion:rpc_hot_join_synch_pose(direction)
	self.pose_direction = direction
	self.posing = true
end

function PlayerHuskLocomotion:get_velocity()
	if self._mounted then
		local mount_locomotion = ScriptUnit.extension(self._mounted, "locomotion_system")

		return mount_locomotion:get_velocity()
	else
		return self._velocity:unbox()
	end
end

function PlayerHuskLocomotion:rpc_flag_pickup_confirmed(flag_unit)
	self.carried_flag = flag_unit
end

function PlayerHuskLocomotion:rpc_flag_plant_complete(flag_unit)
	assert(self.carried_flag == flag_unit, "Trying to plant flag not carried.")

	self.carried_flag = nil
end

function PlayerHuskLocomotion:rpc_drop_flag(flag_unit)
	self.carried_flag = nil

	local flag_ext = ScriptUnit.extension(flag_unit, "flag_system")

	flag_ext:drop()
end

function PlayerHuskLocomotion:rpc_animation_event(event)
	Unit.animation_event(self._unit, event)
end

function PlayerHuskLocomotion:rpc_animation_set_variable(index, variable)
	Unit.animation_set_variable(self._unit, index, variable)
end

function PlayerHuskLocomotion:hot_join_synch(sender, player)
	local network_manager = Managers.state.network
	local player_object_id = self._id
	local unit = self._unit

	RPC.rpc_synch_player_anim_state(sender, player_object_id, Unit.animation_get_state(unit))

	if Unit.alive(self._mounted) then
		local mount_object_id = network_manager:unit_game_object_id(self._mounted)

		RPC.rpc_mounted_husk(sender, player_object_id, mount_object_id, Unit.get_data(unit, "player_index"))
	end

	if self.parrying then
		RPC.rpc_hot_join_synch_parry_block(sender, player_object_id, NetworkLookup.inventory_slots[self.block_slot_name], NetworkLookup.directions[self.block_direction])
	end

	if self.blocking then
		RPC.rpc_hot_join_synch_shield_block(sender, player_object_id, NetworkLookup.inventory_slots[self.block_slot_name])
	end

	if self.carried_flag then
		RPC.rpc_flag_pickup_confirmed(sender, player_object_id, network_manager:game_object_id(self.carried_flag))
	end

	if self.posing then
		RPC.rpc_hot_join_synch_pose(sender, player_object_id, NetworkLookup.directions[self.pose_direction])
	end

	local ladder_unit = self.ladder_unit

	if Unit.alive(ladder_unit) then
		local ladder_lvl_id = network_manager:level_object_id(ladder_unit)

		RPC.rpc_climb_ladder(sender, player_object_id, ladder_lvl_id)
	end

	self._inventory:hot_join_synch(sender, player, player_object_id)
end

function PlayerHuskLocomotion:stun()
	local timpani_world = World.timpani_world(self._world)
	local unit = self._unit
	local event_id = TimpaniWorld.trigger_event(timpani_world, "stunned_husk", unit, Unit.node(unit, "Head"))
	local armour_type_short = WeaponHelper:_armour_type_sound_parameter(unit)

	if armour_type_short then
		TimpaniWorld.set_parameter(timpani_world, event_id, "armour_type", armour_type_short)
	end

	local id = TimpaniWorld.trigger_event(timpani_world, "stunned_husk_vce", unit, Unit.node(unit, "Head"))
	local voice = self._inventory:voice()

	TimpaniWorld.set_parameter(timpani_world, id, "character_vo", voice)
end

function PlayerHuskLocomotion:received_damage()
	return
end

function PlayerHuskLocomotion:damage_interrupt(hit_zone, impact_direction, impact_type)
	WeaponHelper:player_unit_hit_reaction_animation(self._unit, hit_zone, impact_direction, self:aim_direction(), impact_type)
end

function PlayerHuskLocomotion:aim_direction()
	return GameSession.game_object_field(self._game, self._id, "aim_target")
end

function PlayerHuskLocomotion:_attachment_node_linking(source_unit, target_unit, linking_setup)
	for i, attachment_nodes in ipairs(linking_setup) do
		local source_node = attachment_nodes.source
		local target_node = attachment_nodes.target
		local source_node_index = type(source_node) == "string" and Unit.node(source_unit, source_node) or source_node
		local target_node_index = type(target_node) == "string" and Unit.node(target_unit, target_node) or target_node

		World.link_unit(self._world, target_unit, target_node_index, source_unit, source_node_index)
	end
end

function PlayerHuskLocomotion:abort_execution_victim()
	ExecutionHelper.play_execution_abort_anim(self._unit)
end

function PlayerHuskLocomotion:start_execution_victim(execution_definition, attacker_unit)
	ExecutionHelper.play_execution_victim_anims(self._unit, attacker_unit, execution_definition)
end

function PlayerHuskLocomotion:start_execution_attacker(execution_definition, victim_unit)
	ExecutionHelper.play_execution_attacker_anims(self._unit, victim_unit, execution_definition)
end

function PlayerHuskLocomotion:hurt_sound_event()
	return "husk_vce_hurt"
end

function PlayerHuskLocomotion:post_update(dt)
	local push = self._instakill_push

	if push then
		self:_apply_instakill_push(push)

		self._instakill_push = nil
	end
end
