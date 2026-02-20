-- chunkname: @scripts/unit_extensions/default_player_unit/player_unit_locomotion.lua

require("scripts/settings/player_movement_settings")
require("scripts/unit_extensions/human/base/human_locomotion")
require("scripts/unit_extensions/default_player_unit/states/player_movement_state_base")
require("scripts/unit_extensions/default_player_unit/states/player_onground")
require("scripts/unit_extensions/default_player_unit/states/player_inair")
require("scripts/unit_extensions/default_player_unit/states/player_jumping")
require("scripts/unit_extensions/default_player_unit/states/player_landing")
require("scripts/unit_extensions/default_player_unit/states/player_mounted")
require("scripts/unit_extensions/default_player_unit/states/player_knocked_down")
require("scripts/unit_extensions/default_player_unit/states/player_dead")
require("scripts/unit_extensions/default_player_unit/states/player_planting_flag")
require("scripts/unit_extensions/default_player_unit/states/player_executing")
require("scripts/unit_extensions/default_player_unit/states/player_climbing")
require("scripts/unit_extensions/default_player_unit/states/player_reviving_teammate")
require("scripts/unit_extensions/default_player_unit/states/player_bandaging_teammate")
require("scripts/unit_extensions/default_player_unit/states/player_bandaging_self")
require("scripts/unit_extensions/default_player_unit/states/player_stunned")
require("scripts/unit_extensions/default_player_unit/states/player_triggering")
require("scripts/unit_extensions/default_player_unit/states/player_triggering_sp")
require("scripts/unit_extensions/default_player_unit/states/player_shield_bashing")
require("scripts/unit_extensions/default_player_unit/states/player_pushing")
require("scripts/unit_extensions/default_player_unit/states/player_calling_horse")
require("scripts/unit_extensions/default_player_unit/inventory/player_unit_inventory")

PlayerUnitLocomotion = class(PlayerUnitLocomotion, HumanLocomotion)
PlayerUnitLocomotion.SYSTEM = "locomotion_system"

function PlayerUnitLocomotion:_force_unit_to_ground(unit)
	local mover = Unit.mover(unit)

	Mover.move(mover, Vector3(0, 0, -2))

	local pos = Mover.position(mover)

	Unit.set_local_position(unit, 0, pos)
end

function PlayerUnitLocomotion:init(world, unit, player_index, ghost_mode, profile)
	PlayerUnitLocomotion.super.init(self, world, unit)
	self:_force_unit_to_ground(unit)

	local player_manager = Managers.player
	local player = player_manager:player(player_index)
	local fwd_vector = Quaternion.forward(Unit.local_rotation(unit, 0))
	local yaw = -math.atan2(fwd_vector.x, fwd_vector.y)
	local pitch = math.asin(fwd_vector.z)

	Managers.state.camera:set_pitch_yaw(player.viewport_name, pitch, yaw)

	self._perks = nil

	self:_setup_debug_variables(unit)
	self:_init_internal_variables(unit, player)
	Unit.set_data(unit, "player_index", player_index)

	self.game = nil

	player_manager:assign_unit_ownership(unit, player_index, true)

	self.player = player

	player:set_camera_follow_unit(unit)

	local mount_profile = profile.mount
	local spawn_horse = mount_profile and ghost_mode

	self:_setup_states()

	if ghost_mode or spawn_horse or not Managers.state.game_mode:squad_spawn_stun(player.team) then
		self:_set_init_state("onground")
	else
		self:_set_init_state("stunned", "n/a", Vector3.up(), "squad_spawn")
	end

	if Managers.state.network:game() then
		self:_create_game_object(unit, ghost_mode)
	end

	self:_setup_player_profile(profile)
	self:_setup_team_dependants(unit, player)

	if spawn_horse then
		self:spawn_new_mount(player, mount_profile, unit, ghost_mode, false)
	elseif mount_profile then
		local blackboard = self.call_horse_blackboard

		blackboard.player_unit = unit
		blackboard.mount_unit = nil
		blackboard.cooldown_duration = PlayerActionSettings.calling_horse.cooldown_duration
		blackboard.cooldown_time = 0

		Managers.state.event:trigger("own_horse_spawned", player, blackboard)
	end

	self:_setup_inventory(player)
	Managers.state.event:trigger("player_spawned", player, unit)

	if ghost_mode then
		self:_enter_ghost_mode()
	end

	Managers.state.event:register(self, "teleport_all_to", "event_teleport_all_to", "teleport_team_to", "event_teleport_team_to", "teleport_unit_to", "event_teleport_unit_to")
	Managers.state.event:trigger("event_sprint_hud_activated", self.player, self.sprint_hud_blackboard)
	Managers.state.event:trigger("activate_officer_buff_activation", player, self.officer_buff_activation_blackboard)
	Managers.state.event:trigger("event_parry_helper_activated", player, self.parry_helper_blackboard)

	if HUDSettings.show_damage_numbers then
		Managers.state.event:trigger("event_damage_numbers_activated", player)
	end

	local level_settings = LevelHelper:current_level_settings()
	local flow_event = level_settings.on_spawn_flow_event

	if flow_event then
		Unit.flow_event(unit, flow_event)
	end

	self._auto_leave_ghost_mode_time = 0

	local level_list = {"seasick_01", "tower_01", "de_dust2", "level_test_01"}
	self.level_in_list = false
	for _, item in ipairs(level_list) do
		if item == level_settings.level_key then
			self.level_in_list = true
			self._auto_leave_ghost_mode_time = Managers.time:time("game") + 5
			break
		end
	end
end

function PlayerUnitLocomotion:_setup_debug_variables(unit)
	self.debug_drawer = Managers.state.debug:drawer({
		name = "PLAYER_DEBUG"
	})
	self.debug_color = 0
end

function PlayerUnitLocomotion:_setup_states()
	self:_create_state("onground", PlayerOnground)
	self:_create_state("inair", PlayerInair)
	self:_create_state("jumping", PlayerJumping)
	self:_create_state("landing", PlayerLanding)
	self:_create_state("mounted", PlayerMounted)
	self:_create_state("knocked_down", PlayerKnockedDown)
	self:_create_state("dead", PlayerDead)
	self:_create_state("planting_flag", PlayerPlantingFlag)
	self:_create_state("executing", PlayerExecuting)
	self:_create_state("reviving_teammate", PlayerRevivingTeammate)
	self:_create_state("bandaging_teammate", PlayerBandagingTeammate)
	self:_create_state("bandaging_self", PlayerBandagingSelf)
	self:_create_state("climbing", PlayerClimbing)
	self:_create_state("stunned", PlayerStunned)
	self:_create_state("triggering", not Managers.lobby.lobby and PlayerTriggeringSP or PlayerTriggering)
	self:_create_state("shield_bashing", PlayerShieldBashing)
	self:_create_state("pushing", PlayerPushing)
	self:_create_state("rushing", PlayerRushing)
	self:_create_state("calling_horse", PlayerCallingHorse)
end

function PlayerUnitLocomotion:_create_game_object(unit, ghost_mode)
	local mover = Unit.mover(unit)
	local player = self.player
	local data_table = {
		yaw_speed = 0,
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
		aim_target = self.aim_target:unbox() - Unit.local_position(unit, 0),
		movement_state = NetworkLookup.movement_states[self.current_state_name],
		ghost_mode = ghost_mode,
		velocity = Vector3(0, 0, 0),
		in_combat = self.in_combat
	}
	local callback = callback(self, "cb_game_session_disconnect")

	self.id = Managers.state.network:create_game_object("player_unit", data_table, callback, "cb_local_unit_spawned", unit)
	self.game = Managers.state.network:game()
end

function PlayerUnitLocomotion:_setup_player_profile(profile)
	local unit = self.unit
	local player_profile = profile
	local t = Managers.time:time("game")
	local perks = player_profile.perks

	Unit.set_data(unit, "armour_type", Armours[player_profile.armour].armour_type)
	Unit.set_data(unit, "penetration_value", Armours[player_profile.armour].penetration_value)
	Unit.set_data(unit, "absorption_value", Armours[player_profile.armour].absorption_value)
	Unit.set_data(unit, "helmet_armour_type", Helmets[player_profile.helmet.name].armour_type)
	Unit.set_data(unit, "helmet_penetration_value", Helmets[player_profile.helmet.name].penetration_value)
	Unit.set_data(unit, "helmet_absorption_value", Helmets[player_profile.helmet.name].absorption_value)

	local helmet_attachments = player_profile.helmet.attachments

	if self.id then
		local head_material = player_profile.head_material or Heads[player_profile.head].material_variations[1]
		local voice = player_profile.voice or Heads[player_profile.head].voice
		local data_table = {
			player_game_obj_id = self.id,
			head = NetworkLookup.heads[player_profile.head],
			head_material = NetworkLookup.head_materials[head_material],
			helmet = NetworkLookup.helmets[player_profile.helmet.name],
			helmet_visor = helmet_attachments.visor and NetworkLookup.helmet_attachments[helmet_attachments.visor] or 0,
			helmet_plume = helmet_attachments.plume and NetworkLookup.helmet_attachments[helmet_attachments.plume] or 0,
			helmet_feathers = helmet_attachments.feathers and NetworkLookup.helmet_attachments[helmet_attachments.feathers] or 0,
			helmet_coif = helmet_attachments.coif and NetworkLookup.helmet_attachments[helmet_attachments.coif] or 0,
			helmet_bevor = helmet_attachments.bevor and NetworkLookup.helmet_attachments[helmet_attachments.bevor] or 0,
			helmet_pattern = helmet_attachments.pattern and NetworkLookup.helmet_attachments[helmet_attachments.pattern] or 0,
			helmet_show_crest = player_profile.helmet.show_crest,
			armour = NetworkLookup.armours[player_profile.armour],
			armour_pattern = player_profile.armour_attachments.patterns or 1,
			game_object_created_func = NetworkLookup.game_object_functions.cb_player_profile_created,
			owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
			object_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
			voice = NetworkLookup.voices[voice]
		}

		for _, slot in ipairs(PerkSlots) do
			local perk = perks[slot.name]

			data_table[slot.game_object_field] = perk and NetworkLookup.perks[perk] or 0
		end

		local callback = callback(self, "cb_game_session_disconnect")

		self._player_profile_game_obj_id = Managers.state.network:create_game_object("player_profile", data_table, callback)
	end

	local perk_table = {}
	local activatable_officer_buffs = {}

	for _, perk in pairs(perks) do
		perk_table[perk] = true

		local perk_settings = Perks[perk]

		if perk_settings.activatable then
			local i = #activatable_officer_buffs + 1
			local buff = Buffs[perk]
			local blackboard = self.officer_buff_activation_blackboard[i]

			activatable_officer_buffs[i] = perk
			blackboard.buff_type = perk
		end
	end

	self._perks = perk_table
	self.officer_buffs = activatable_officer_buffs
	self._player_profile = player_profile

	local stamina_capacity_multiplier = self:has_perk("infantry") and Perks.infantry.stamina_capacity_multiplier or 1

	self.rush_stamina = self.rush_stamina * stamina_capacity_multiplier
end

function PlayerUnitLocomotion:spawn_new_mount(player, mount_profile, unit, ghost_mode, cavalry_perk_used)
	local pos = Unit.local_position(unit, 0)
	local rot = Unit.local_rotation(unit, 0)

	if cavalry_perk_used then
		pos = Vector3(pos.x, pos.y, pos.z + 0.3)
	end

	self.owned_mount_unit = Managers.state.spawn:spawn_mount(mount_profile, pos, rot, unit, ghost_mode)

	local blackboard = self.call_horse_blackboard

	blackboard.player_unit = unit
	blackboard.mount_unit = self.owned_mount_unit
	blackboard.cooldown_duration = PlayerActionSettings.calling_horse.cooldown_duration
	blackboard.cooldown_time = Managers.time:time("game") + PlayerActionSettings.calling_horse.cooldown_duration

	if not ghost_mode then
		Managers.state.event:trigger("own_horse_spawned", player, blackboard)
	end

	self:force_mount_unit(self.owned_mount_unit)
end

function PlayerUnitLocomotion:has_perk(perk_name, perks)
	if perks then
		return perks[perk_name] and true or false
	else
		return self._perks[perk_name] and true or false
	end
end

function PlayerUnitLocomotion:_setup_team_dependants(unit, player)
	local team = player.team
	local team_manager = Managers.state.team

	if team then
		Unit.set_data(unit, "team_name", team.name)
	end

	self:_disable_team_specific_actors()
end

function PlayerUnitLocomotion:_setup_inventory(player, spawn_horse)
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
	local player_profile = self._player_profile

	if team then
		tint_color = team.color
		secondary_tint_color = team.secondary_color
	end

	local inventory = PlayerUnitInventory:new(self.world, self.unit, player, self.id, tint_color, secondary_tint_color)

	self._inventory = inventory

	for _, profile_gear in ipairs(player_profile.gear) do
		inventory:add_gear(profile_gear.name, nil, false, profile_gear.attachments, self)
	end

	local wielded = false

	local function set_init_gear(slot)
		local main_body_state, hand_anim = inventory:set_gear_wielded(slot, true, true)

		if main_body_state then
			self.current_state:anim_event(main_body_state, true)
		end

		if hand_anim then
			self.current_state:anim_event(hand_anim, true)
		end
	end

	for _, profile_gear in ipairs(player_profile.wielded_gear) do
		local slot = GearTypes[Gear[profile_gear.name].gear_type].inventory_slot

		if inventory:can_wield(slot, self.current_state_name) then
			set_init_gear(slot)

			if slot ~= "shield" then
				wielded = true
			end
		end
	end

	if not wielded then
		local fallback_slot = inventory:fallback_slot()

		set_init_gear(fallback_slot)
	end

	local encumbrance_multiplier = self:has_perk("armour_training") and Perks.armour_training.encumbrance_multiplier or 1

	inventory:add_armour(player_profile.armour, player_profile.armour_attachments.patterns, encumbrance_multiplier)
	inventory:add_head(self._player_profile.head, self._player_profile.head_material, self._player_profile.voice)
	inventory:add_helmet(self._player_profile.helmet.name, team.name)

	local helmet_name = self._player_profile.helmet.name
	local helmet_settings = Helmets[helmet_name]
	local helmet = self._player_profile.helmet
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

function PlayerUnitLocomotion:_enter_ghost_mode()
	self.ghost_mode = true

	Managers.state.event:trigger("ghost_mode_activated")

	local world = self.world

	self._ghost_mode_camera_particle_effect_id = World.create_particles(world, "fx/screenspace_ghostmode", Vector3(0, 0, 0))

	local unit = self.unit

	for _, actor_name in ipairs(PlayerUnitMovementSettings.ghost_mode.local_actors) do
		local actor = Unit.actor(unit, actor_name)

		if actor then
			Actor.set_collision_enabled(actor, false)
			Actor.set_scene_query_enabled(actor, false)
		end
	end

	local inventory = self._inventory

	inventory:enter_ghost_mode()

	local mover = Unit.mover(unit)

	Mover.set_collision_filter(mover, "ghost_mode_mover")
end

function PlayerUnitLocomotion:blend_out_of_ghost_mode()
	self._ghost_mode_blend_timer = Managers.time:time("game")
end

function PlayerUnitLocomotion:exit_ghost_mode()
	self.ghost_mode = false
	self.leaving_ghost_mode = true

	Managers.state.event:trigger("ghost_mode_deactivated")

	if self.game and self.id then
		GameSession.set_game_object_field(self.game, self.id, "ghost_mode", self.ghost_mode)
	end

	local world = self.world

	World.destroy_particles(world, self._ghost_mode_camera_particle_effect_id)

	self._ghost_mode_camera_particle_effect_id = nil

	local unit = self.unit

	for _, actor_name in ipairs(PlayerUnitMovementSettings.ghost_mode.local_actors) do
		local actor = Unit.actor(unit, actor_name)

		if actor then
			Actor.set_collision_enabled(actor, true)
			Actor.set_scene_query_enabled(actor, true)
		end
	end

	self:_disable_team_specific_actors()

	local inventory = self._inventory

	inventory:exit_ghost_mode()

	local mover = Unit.mover(unit)

	Mover.set_collision_filter(mover, "mover")
end

function PlayerUnitLocomotion:_disable_team_specific_actors()
	local team = self.player.team
	local team_manager = Managers.state.team

	for _, team_name in ipairs(team_manager:names()) do
		if not team or team_name == team.name then
			local actor = Unit.actor(self.unit, team_name)

			if actor then
				Actor.set_collision_enabled(actor, false)
				Actor.set_scene_query_enabled(actor, false)
			end
		end
	end
end

function PlayerUnitLocomotion:cb_game_session_disconnect()
	self:_freeze()

	self.id = nil
	self._player_profile_game_obj_id = nil
	self.game = nil
end

function PlayerUnitLocomotion:inventory()
	return self._inventory
end

function PlayerUnitLocomotion:_init_internal_variables(unit, player)
	local rot = Unit.local_rotation(unit, 0)
	local pos = Unit.local_position(unit, 0)
	local t = Managers.time:time("game")

	PlayerUnitLocomotion.super._init_internal_variables(self, unit, t, pos, rot)

	self.couch_cooldown_time = 0
	self.current_rotation = QuaternionBox()
	self.target_rotation = QuaternionBox()
	self.double_time_direction = Vector3Box(Quaternion.forward(rot))
	self.move_rot = QuaternionBox(rot)
	self.move_rotation_local = QuaternionBox()
	self.velocity = Vector3Box(0, 0, 0)
	self.speed = Vector3Box(0, 0, 0)
	self.target_world_rotation = QuaternionBox(rot)
	self.move_speed = 0
	self.movement_state = nil
	self.accumulated_pose = Vector3Box(Vector3(0, 0, 0))
	self.accumulated_parry_direction = Vector3Box(Vector3(0, 0, 0))
	self.aim_target = Vector3Box(pos + Quaternion.forward(rot) * 3)
	self.look_angle = 0
	self.in_combat = false
	self._in_combat_cd_time = 0
	self.crossbow_reload_blackboard = {
		missing = false,
		circle_pos_y = 0,
		shader_value = 0,
		attempts = 3,
		texture_offset = 0,
		hitting = false,
		grab_area_rot_angle = 0,
		hook_rot_angle = 0,
		circle_pos_x = 0
	}

	local controller_settings = Managers.input:pad_active(1) and "pad360" or "keyboard_mouse"

	self.sprint_hud_blackboard = {
		cooldown_shader_value = 0,
		player = player,
		text = ActivePlayerControllerSettings[controller_settings].rush.key
	}
	self.mount_hud_blackboard = {
		shader_value = 0,
		cooldown_shader_value = 0,
		player = player,
		text = ActivePlayerControllerSettings[controller_settings].mounted_charge.key
	}
	self.bow_aim_blackboard = {
		aim_start_time = 0,
		hitting = false,
		shader_value = 0,
		marker_rotations = {
			marker_two = 0,
			marker_one = 0,
			marker_four = 0,
			marker_three = 0
		},
		timer_rotations = {
			timer_two = 0,
			timer_one = 0
		},
		marker_offset = 0.06666666666666667 * math.pi
	}
	self.pose_charge_blackboard = {
		pose_factor = 0,
		direction_offset_angle = 0,
		shader_value = 0,
		gradient_rot_angle = 0,
		marker_rotations = {
			marker_two = 0,
			marker_one = 0
		}
	}
	self.parry_helper_blackboard = {}
	self.handgonne_reload_blackboard = {
		max_time = 0,
		timer = 0
	}
	self.lance_recharge_blackboard = {
		max_time = 0,
		timer = 0
	}
	self.officer_buff_activation_blackboard = {
		{
			cooldown = 0,
			duration = 0,
			buff_name = "officer_buff_one",
			level = 0,
			text = ActivePlayerControllerSettings[controller_settings].officer_buff_one.key
		},
		{
			cooldown = 0,
			duration = 0,
			buff_name = "officer_buff_two",
			level = 0,
			text = ActivePlayerControllerSettings[controller_settings].officer_buff_two.key
		}
	}
	self.perk_fast_swings = {
		fencing_master = {
			cooldown = 0,
			timer = 0,
			can_use = false
		},
		riposte = {
			cooldown = 0,
			timer = 0,
			can_use = false
		}
	}
	self.call_horse_blackboard = {
		timer = 0,
		cooldown_time = 0,
		cooldown_duration = PlayerActionSettings.calling_horse.max_time,
		max_time = Perks.cavalry.duration
	}
	self.tagging_blackboard = {
		cooldown_time = 0,
		cooldown_duration = 0,
		timer = 0,
		max_time = 0,
		player = player,
		text = ActivePlayerControllerSettings[controller_settings].activate_tag.key
	}
	self.dual_wield_config = {}
	self.wielding = false
	self.posing = false
	self.swinging = false
	self.aiming = false
	self.reloading = false
	self.blocking = false
	self.parrying = false
	self.block_start_time = 0
	self.pose_time = 0
	self.crouching = false
	self.attempting_parry = false
	self.pose_ready = false
	self.swing_direction = nil
	self.rush_stamina = PlayerUnitMovementSettings.rush.max_rush_stamina
	self.rush_cooldown_time = 0
	self.rush_start_time = 0
	self.double_time_timer = t + PlayerUnitMovementSettings.double_time.timer_time
	self.picking_flag = false
	self.carried_flag = nil
	self.planting_flag = false
	self.current_breathing_state = "normal"
	self.current_sway_settings = nil
	self.sway_camera = {
		pitch_angle = 0,
		previous_angle = 0,
		yaw_angle = 0
	}
	self.breathing_transition_time = 0
	self.hold_breath_timer = 0
	self.freeze = true
	self.activating_officer_buff_index = nil
	self.officer_buff_cooldown_times = {
		0,
		0
	}
	self.officer_buff_actiavtion_time = 0
	self.ranged_weapon_zoom_value = 1
	self.block_broken = false
	self.tagging = false
	self.unit_being_tagged = nil
	self.time_to_tag = 0
	self.tagging_cooldown = 0
	self.tag_start_time = 0
	self.kd_tagging_cooldown = 0
	self.shield_bash_cooldown = 0
	self.push_cooldown = 0
	self.husks_in_proximity = {}
end

function PlayerUnitLocomotion:_husks_in_proximity_overlap(dt, t)
	local physics_world = World.physics_world(self.world)
	local pose = Unit.world_pose(self.unit, 0)
	local cb = callback(self, "husks_in_proximity_overlap_cb")

	PhysicsWorld.overlap(physics_world, cb, "shape", "sphere", "pose", pose, "size", 4, "types", "dynamics", "collision_filter", "player_locomotion_overlap")
end

function PlayerUnitLocomotion:husks_in_proximity_overlap_cb(actors)
	table.clear(self.husks_in_proximity)

	for _, actor in ipairs(actors) do
		self.husks_in_proximity[ActorBox(actor)] = Actor.unit(actor)
	end
end

function PlayerUnitLocomotion:update(unit, input, dt, context, t)
	if self.frozen then
		return
	end

	self:_husks_in_proximity_overlap(dt, t)
	Profiler.start("PlayerUnitLocomotion:update")

	self.controller = input.controller

	self:_update_leave_ghost_mode(dt, t)
	self.current_state:update(dt, t)

	if not self.__destroyed then
		self:_update_state_data(dt, t)
		self.current_state:post_update(dt, t)
		self._inventory:update(dt, t)
		self._inventory:set_eye_target(self.aim_target:unbox())

		if self.controller and self.controller:get("toggle_visor") then
			self._inventory:toggle_visor()
		end

		self:_update_in_combat(dt, t)
	end

	self.last_controller = self.controller
	input.controller = nil
	self.controller = nil
	self.leaving_ghost_mode = false

	Profiler.stop()
end

local IN_COMBAT_TOLERANCE = 5

function PlayerUnitLocomotion:_update_in_combat(dt, t)
	local in_combat = self.in_combat
	local game = Managers.state.network:game()
	local id = self.id
	local husks_in_proximity = self.husks_in_proximity
	local player_manager = Managers.player
	local enemies_close = false

	for _, unit in pairs(self.husks_in_proximity) do
		local owner = Unit.alive(unit) and player_manager:owner(unit)

		if owner and owner.team ~= self.player.team then
			enemies_close = true

			break
		end
	end

	local cooled_down = t > self._in_combat_cd_time

	if enemies_close then
		self._in_combat_cd_time = t + IN_COMBAT_TOLERANCE
		self.in_combat = true
	elseif not enemies_close and in_combat and cooled_down then
		self.in_combat = false
	end

	if game and id then
		GameSession.set_game_object_field(game, id, "in_combat", in_combat)
	end
end

function PlayerUnitLocomotion:_update_leave_ghost_mode(dt, t)
	local controller = self.controller
	local player = self.player

	if self.level_in_list and self.ghost_mode and t >= self._auto_leave_ghost_mode_time then
		self._auto_leave_ghost_mode_time = t + 2

		Managers.state.spawn:request_leave_ghost_mode(player, self.unit)
	end

	if GameSettingsDevelopment.enable_robot_player and self.ghost_mode and t >= self._auto_leave_ghost_mode_time or controller and controller:get("leave_ghost_mode") and self.ghost_mode and Managers.state.spawn:allowed_to_leave_ghost_mode(player) then
		self._auto_leave_ghost_mode_time = t + 2

		Managers.state.spawn:request_leave_ghost_mode(player, self.unit)
	end

	local ghost_mode_blend_timer = self._ghost_mode_blend_timer

	if ghost_mode_blend_timer and t >= ghost_mode_blend_timer + EnvironmentTweaks.time_to_blend_env then
		self:exit_ghost_mode()

		if self.mounted_unit then
			local mount_locomotion = ScriptUnit.extension(self.mounted_unit, "locomotion_system")

			mount_locomotion:exit_ghost_mode()
			Managers.state.event:trigger("own_horse_spawned", player, self.call_horse_blackboard)
		end

		self._ghost_mode_blend_timer = nil
	end
end

function PlayerUnitLocomotion:post_update(unit, input, dt, context, t)
	if self.current_state.post_world_update then
		self.current_state:post_world_update(dt, t)
	end
end

function PlayerUnitLocomotion:_update_state_data(dt, t)
	local player = self.player
	local state_data = player.state_data

	if Unit.alive(self.mounted_unit) then
		local mount_locomotion = ScriptUnit.extension(self.mounted_unit, "locomotion_system")

		state_data.rush_cooldown_time = mount_locomotion.charge_cooldown
	else
		state_data.rush_cooldown_time = self.rush_cooldown_time
	end

	local built_in_overlay = self._inventory:built_in_overlay()

	if built_in_overlay then
		state_data.visor_open = false
		state_data.visor_name = built_in_overlay
	else
		state_data.visor_open = self._inventory:visor_open()
		state_data.visor_name = self._inventory:visor_name()
	end

	state_data.helmet_name = self._inventory:helmet_name()
end

function PlayerUnitLocomotion:destroy()
	PlayerUnitLocomotion.super.destroy(self)

	self.__destroyed = true
	self.id = nil

	if self.ghost_mode then
		World.destroy_particles(self.world, self._ghost_mode_camera_particle_effect_id)

		self._ghost_mode_camera_particle_effect_id = nil
	end

	Managers.state.event:unregister("teleport_all_to", self)
	Managers.state.event:unregister("teleport_team_to", self)
	Managers.state.event:unregister("teleport_unit_to", self)

	if self.sprint_hud_blackboard then
		Managers.state.event:trigger("event_sprint_hud_deactivated", self.player)
	end

	self._inventory:destroy()
	Managers.state.event:trigger("player_destroyed", self.unit)

	local flag = self.carried_flag

	if flag and Unit.alive(flag) and ScriptUnit.has_extension(flag, "flag_system") then
		local flag_ext = ScriptUnit.extension(flag, "flag_system")

		flag_ext:drop()
	end

	local network_manager = Managers.state.network
	local unit = self.unit
	local player_manager = Managers.player

	if player_manager:owner(unit) then
		Managers.player:relinquish_unit_ownership(unit)
	end

	if self._player_profile_game_obj_id and network_manager:game() then
		network_manager:destroy_game_object(self._player_profile_game_obj_id)

		self._player_profile_game_obj_id = nil
	end
end

function PlayerUnitLocomotion:force_mount_unit(mount_unit)
	self.mounted_unit = mount_unit

	self:_change_state("mounted")
end

function PlayerUnitLocomotion:rpc_mount_denied(mount_object_id, mount_unit)
	if self.current_state_name == "mounted" and self.mounted_unit == mount_unit then
		self.current_state:force_unmount("mount_denied")
	end
end

function PlayerUnitLocomotion:rpc_unmount(mount_unit)
	self:unmount(mount_unit)
end

function PlayerUnitLocomotion:unmount(mount_unit)
	if self.current_state_name == "mounted" and self.mounted_unit == mount_unit then
		self.current_state:force_unmount("unmount")
	end
end

function PlayerUnitLocomotion:mounted()
	return self.current_state_name == "mounted"
end

function PlayerUnitLocomotion:stun(hit_zone, impact_direction, impact_type, ...)
	if type(self.current_state.stun) == "function" then
		self.current_state:stun(hit_zone, impact_direction, impact_type, ...)
	else
		self:_change_state("stunned", hit_zone, impact_direction, impact_type, ...)
	end

	local timpani_world = World.timpani_world(self.world)
	local unit = self.unit

	TimpaniWorld.trigger_event(timpani_world, "stunned_player_short", unit, Unit.node(unit, "Head"))

	local id = TimpaniWorld.trigger_event(timpani_world, "stunned_player_vce", unit, Unit.node(unit, "Head"))
	local voice = self._inventory:voice()

	TimpaniWorld.set_parameter(timpani_world, id, "character_vo", voice)
end

function PlayerUnitLocomotion:damage_interrupt(hit_zone, impact_direction, impact_type)
	self.current_state:safe_action_interrupt(impact_type)
	WeaponHelper:player_unit_hit_reaction_animation(self.unit, hit_zone, impact_direction, self:aim_direction(), impact_type)
end

function PlayerUnitLocomotion:received_damage(damage, front_back, direction)
	local t = Managers.time:time("game")
	local camera_manager = Managers.state.camera
	local event = front_back and "damaged_" .. front_back .. "_" .. direction or "damaged"

	camera_manager:camera_effect_sequence_event(event, t)
	camera_manager:camera_effect_shake_event(event, t)
end

function PlayerUnitLocomotion:rpc_start_revive()
	assert(self.current_state_name == "knocked_down")
	self.current_state:start_revive()
end

function PlayerUnitLocomotion:rpc_abort_revive()
	assert(self.current_state_name == "knocked_down")
	self.current_state:abort_revive()
end

function PlayerUnitLocomotion:rpc_completed_revive()
	assert(self.current_state_name == "knocked_down")
	self.current_state:revived()
end

function PlayerUnitLocomotion:rpc_gear_dead(unit)
	self:gear_dead(unit)
end

function PlayerUnitLocomotion:player_knocked_down(hit_zone, impact_direction, damage_type)
	self:_change_state("knocked_down", hit_zone, impact_direction, damage_type)
end

function PlayerUnitLocomotion:player_dead(is_instakill, damage_type, hit_zone, impact_direction)
	self:_change_state("dead", is_instakill, damage_type, hit_zone, impact_direction)
end

function PlayerUnitLocomotion:get_velocity()
	return self.velocity:unbox()
end

function PlayerUnitLocomotion:rpc_flag_plant_complete(flag_unit)
	return
end

function PlayerUnitLocomotion:rpc_flag_pickup_confirmed(flag_unit)
	self.picking_flag = false
	self.carried_flag = flag_unit
end

function PlayerUnitLocomotion:rpc_flag_drop(flag_unit)
	assert(flag_unit == self.carried_flag, "Trying to drop other flag than the one carried.")

	self.carried_flag = nil
end

function PlayerUnitLocomotion:rpc_flag_pickup_denied()
	self.picking_flag = false
end

function PlayerUnitLocomotion:rpc_flag_plant_confirmed()
	if self.current_state_name == "planting_flag" then
		self.current_state:interaction_confirmed()
	else
		print(Script.callstack())
	end
end

function PlayerUnitLocomotion:rpc_flag_plant_denied()
	if self.current_state_name == "planting_flag" then
		self:_change_state("onground")
	end
end

function PlayerUnitLocomotion:hot_join_synch(sender, player)
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

	if self.current_state_name == "climbing" then
		self.current_state:synch_ladder_unit(sender)
	end

	self._inventory:hot_join_synch(sender, player, player_object_id)
end

function PlayerUnitLocomotion:yield_interaction_confirmed()
	fassert(self.current_state_name == "knocked_down", "Yield confirmed but player unit %s is dead.", tostring(self.unit))
	self.current_state:yield_confirmed()
end

function PlayerUnitLocomotion:yield_interaction_denied()
	if self.current_state_name == "knocked_down" then
		self.current_state:yield_denied()
	end
end

function PlayerUnitLocomotion:execute_interaction_confirmed()
	if self.current_state_name == "executing" then
		self.current_state:interaction_confirmed()
	end
end

function PlayerUnitLocomotion:execute_interaction_denied()
	if self.current_state_name == "executing" then
		self.current_state:interaction_denied()
		self:_change_state("onground")
	end
end

function PlayerUnitLocomotion:bandage_interaction_confirmed()
	if self.current_state_name == "bandaging_teammate" or self.current_state_name == "bandaging_self" then
		self.current_state:interaction_confirmed()
	end
end

function PlayerUnitLocomotion:bandage_interaction_denied()
	if self.current_state_name == "bandaging_teammate" or self.current_state_name == "bandaging_self" then
		self.current_state:interaction_denied()
		self:_change_state("onground")
	end
end

function PlayerUnitLocomotion:revive_interaction_confirmed()
	if self.current_state_name == "reviving_teammate" then
		self.current_state:interaction_confirmed()
	end
end

function PlayerUnitLocomotion:revive_interaction_denied()
	if self.current_state_name == "reviving_teammate" then
		self.current_state:interaction_denied()
		self:_change_state("onground")
	end
end

function PlayerUnitLocomotion:trigger_interaction_confirmed()
	if self.current_state_name == "triggering" then
		self.current_state:interaction_confirmed()
	end
end

function PlayerUnitLocomotion:trigger_interaction_denied()
	if self.current_state_name == "triggering" then
		self.current_state:interaction_denied()
		self:_change_state("onground")
	end
end

function PlayerUnitLocomotion:aim_direction()
	return self.current_state:aim_direction()
end

function PlayerUnitLocomotion:start_execution_victim(execution_definition, attacker_unit)
	self.current_state:begin_execution(execution_definition, attacker_unit)
end

function PlayerUnitLocomotion:abort_execution_victim()
	if self.current_state_name == "dead" then
		-- block empty
	elseif self.current_state_name == "knocked_down" then
		self.current_state:abort_execution()
	else
		ferror("Trying to abort execution for player unit %q in state %q", self.unit, self.current_state_name)
	end
end

function PlayerUnitLocomotion:event_teleport_all_to(position, rotation, camera_rotation)
	self:_teleport_to(position, rotation, camera_rotation)
end

function PlayerUnitLocomotion:event_teleport_unit_to(unit, position, rotation, camera_rotation)
	if self.unit == unit then
		self:_teleport_to(position, rotation, camera_rotation)
	end
end

function PlayerUnitLocomotion:event_teleport_team_to(team_name, position, rotation, camera_rotation)
	if team_name == self.player.team.name then
		self:_teleport_to(position, rotation, camera_rotation)
	end
end

function PlayerUnitLocomotion:_teleport_to(position, rotation, camera_rotation)
	if self.current_state_name == "dead" then
		return
	end

	local fwd_vector = Quaternion.forward(camera_rotation)
	local yaw = -math.atan2(fwd_vector.x, fwd_vector.y)
	local pitch = math.asin(fwd_vector.z)

	Managers.state.camera:set_pitch_yaw(self.player.viewport_name, pitch, yaw)

	if Unit.alive(self.mounted_unit) then
		local locomotion = ScriptUnit.extension(self.mounted_unit, "locomotion_system")

		locomotion:teleport(position, rotation)
	else
		self.current_state:set_local_position(position)
		self.current_state:set_local_rotation(rotation)
		Mover.set_position(Unit.mover(self.unit), position)
	end
end

function PlayerUnitLocomotion:set_ladder_unit(ladder_unit)
	return
end
