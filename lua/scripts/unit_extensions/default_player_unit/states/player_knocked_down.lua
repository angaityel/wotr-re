-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_knocked_down.lua

PlayerKnockedDown = class(PlayerKnockedDown, PlayerMovementStateBase)

local BUTTON_THRESHOLD = 0.5

function PlayerKnockedDown:init(unit, internal, world)
	PlayerKnockedDown.super.init(self, unit, internal, world)

	self._unit = unit
	self._internal = internal
	self._yielded = false
	self._yield_time = nil
	self._execution_time = nil
	self._falling = false
end

function PlayerKnockedDown:update(dt, t)
	PlayerKnockedDown.super.update(self, dt, t)

	local unit = self._unit

	self:update_movement(dt, t)
	self:_update_tagging(dt, t)

	local execution_time = self._execution_time

	if execution_time then
		self:update_execution(t - execution_time, dt)
	end

	if not self._yielded then
		self:update_yield(dt, t)
	end
end

function PlayerKnockedDown:anim_cb_knockdown_finished()
	self._falling = false
end

function PlayerKnockedDown:update_execution(execution_t, dt)
	local curve_data = self._animation_curves_data

	if curve_data then
		curve_data.t = execution_t

		local camera_manager = Managers.state.camera
		local viewport_name = self._internal.player.viewport_name

		if not viewport_name then
			return
		end

		camera_manager:set_variable(viewport_name, "execution_victim_anim_curves", curve_data)
	end
end

function PlayerKnockedDown:begin_execution(execution_definition, attacker_unit)
	local internal = self._internal

	internal.being_executed = true
	internal.executed_camera = execution_definition.victim_camera
	self._execution_time = Managers.time:time("game")
	self._animation_curves_data = table.clone(execution_definition.victim_animation_curves_data)
	self._animation_curves_data.resource = AnimationCurves(self._animation_curves_data.resource)

	ExecutionHelper.play_execution_victim_anims(internal.unit, attacker_unit, execution_definition)
end

function PlayerKnockedDown:abort_execution()
	local internal = self._internal

	internal.being_executed = false
	internal.executed_camera = nil
	self._execution_time = nil
	self._animation_curves_data = nil

	ExecutionHelper.play_execution_abort_anim(internal.unit)
end

function PlayerKnockedDown:yield_confirmed()
	self:anim_event("yield")

	self._internal.yielded = true
end

function PlayerKnockedDown:yield_denied()
	self._yielded = false
end

function PlayerKnockedDown:can_yield(t)
	local internal = self._internal

	return InteractionHelper:can_request("yield", internal) and not self._yielded
end

function PlayerKnockedDown:update_yield(dt, t)
	local player = self._internal.player
	local spawn_timer = Managers.state.spawn:spawn_timer(player)
	local yield = spawn_timer and spawn_timer <= 0
	local yield_input = self._controller and self._controller:get("yield") or GameSettingsDevelopment.enable_robot_player

	if yield and self:can_yield(t) then
		if yield_input then
			self._yielded = true

			local internal = self._internal

			if internal.game and internal.id then
				local network_manager = Managers.state.network

				InteractionHelper:request("yield", internal, internal.id)
			end
		end
	elseif not yield then
		self._yield_time = nil
	end
end

function PlayerKnockedDown:update_movement(dt)
	if self._falling then
		local final_position, wanted_animation_pose = PlayerMechanicsHelper:animation_driven_update_movement(self._unit, self._internal, dt, false)

		self:set_local_position(final_position)
		self:_set_rotation(Matrix4x4.rotation(wanted_animation_pose))
	else
		local internal = self._internal

		internal.speed:store(Vector3(0, 0, 0))
		internal.velocity:store(Vector3(0, 0, 0))
	end
end

function PlayerKnockedDown:start_revive()
	self:anim_event_with_variable_float("revive_start", "revive_time", PlayerUnitDamageSettings.REVIVE_TIME)
end

function PlayerKnockedDown:abort_revive()
	self:anim_event("revive_abort")
end

function PlayerKnockedDown:revived()
	self:anim_event("revive_complete")
	self:recover_wielded_gear()
	self:change_state("onground")
end

function PlayerKnockedDown:enter(old_state, hit_zone, impact_direction, damage_type)
	PlayerKnockedDown.super.enter(self, old_state)
	self:safe_action_interrupt("knocked_down")

	local anim_event = self:_pick_knock_down_anim_event(hit_zone, impact_direction, damage_type)

	self:anim_event(anim_event)

	local t = Managers.time:time("game")
	local camera_manager = Managers.state.camera

	camera_manager:camera_effect_sequence_event("knocked_down", t)

	self._knocked_down_camera_effect_id = camera_manager:camera_effect_shake_event("knocked_down", t)

	self:drop_wielded_gear()

	self._falling = true

	Managers.state.event:trigger("local_player_kd", self._internal.player)
end

function PlayerKnockedDown:drop_wielded_gear()
	self._internal:inventory():set_kinematic_wielded_gear(false)
end

function PlayerKnockedDown:recover_wielded_gear()
	self._internal:inventory():set_kinematic_wielded_gear(true)
end

function PlayerKnockedDown:_pick_knock_down_anim_event(hit_zone, impact_direction, damage_type)
	local direction = self:_calculate_knock_down_direction(impact_direction)

	if direction == "none" then
		return "knocked_down_bleed_out"
	elseif direction == "front" and hit_zone == "stomach" and damage_type == "piercing" then
		return "knocked_down_front_stomach_piercing"
	elseif direction == "left_front" and (hit_zone == "head" or hit_zone == "helmet") and (damage_type == "cutting" or damage_type == "slashing") then
		return "knocked_down_left_front_face_cut"
	elseif direction == "left_front" and hit_zone == "torso" and (damage_type == "cutting" or damage_type == "slashing") then
		return "knocked_down_left_front_torso_cut"
	elseif direction == "back" and hit_zone == "torso" and (damage_type == "cutting" or damage_type == "slashing") then
		return "knocked_down_back_torso_cut"
	elseif direction == "front" and hit_zone == "torso" and damage_type == "blunt" then
		return "knocked_down_front_torso_blunt"
	elseif direction == "back" and hit_zone == "torso" and damage_type == "blunt" then
		return "knocked_down_back_torso_blunt"
	else
		return "knocked_down_bleed_out"
	end
end

local KD_DIR_SIDE_THRESHOLD = math.cos(math.pi / 3)

function PlayerKnockedDown:_calculate_knock_down_direction(impact_direction)
	local internal = self._internal
	local unit_rotation = Unit.local_rotation(internal.unit, 0)
	local fwd = Vector3.normalize(Vector3.flat(Quaternion.forward(unit_rotation)))
	local right = Quaternion.right(unit_rotation)
	local flat_impact_dir = Vector3.normalize(Vector3.flat(impact_direction))
	local impact_length_right = Vector3.dot(right, flat_impact_dir)
	local impact_length_fwd = Vector3.dot(fwd, flat_impact_dir)
	local direction

	direction = Vector3.length(impact_direction) < 0.5 and "none" or impact_length_fwd > 0 and (impact_length_right < -KD_DIR_SIDE_THRESHOLD and "left_back" or impact_length_right > KD_DIR_SIDE_THRESHOLD and "right_back" or "back") or impact_length_right < -KD_DIR_SIDE_THRESHOLD and "left_front" or impact_length_right > KD_DIR_SIDE_THRESHOLD and "right_front" or "front"

	return direction
end

function PlayerKnockedDown:_can_tag(t, tagging_player)
	local internal = self._internal

	return t >= internal.kd_tagging_cooldown and not internal.tagging
end

function PlayerKnockedDown:_tag_valid(tagged_unit)
	local player = self._internal.player
	local is_player = ScriptUnit.has_extension(tagged_unit, "locomotion_system")
	local is_valid = false

	if is_player then
		local tagged_player = Managers.player:owner(tagged_unit)

		is_valid = tagged_player.team == player.team
	end

	return is_valid and not ScriptUnit.extension(tagged_unit, "damage_system"):is_dead()
end

function PlayerKnockedDown:_process_tag(player, tagged_unit)
	local internal = self._internal
	local network_manager = Managers.state.network
	local tagged_unit_id = network_manager:game_object_id(tagged_unit)
	local own_unit_id = network_manager:game_object_id(self._unit)

	network_manager:send_rpc_server("rpc_request_knocked_down_help", own_unit_id, tagged_unit_id)

	internal.kd_tagging_cooldown = Managers.time:time("game") + PlayerActionSettings.tagging.knocked_down_cooldown
	internal.unit_being_tagged = nil
	internal.time_to_tag = 0
	internal.tagging = false

	Managers.state.event:trigger("stopped_tagging", player)
end

function PlayerKnockedDown:_update_tagging_nothing(dt, t)
	local internal = self._internal

	if t >= internal.tag_start_time + PlayerActionSettings.tagging.request_squad_help_activation_time then
		local network_manager = Managers.state.network
		local own_unit_id = network_manager:game_object_id(self._unit)

		network_manager:send_rpc_server("rpc_request_squad_knocked_down_help", own_unit_id)
		Managers.state.event:trigger("stopped_tagging", internal.player)

		internal.tagging = false
		internal.tag_start_time = 0
		internal.kd_tagging_cooldown = Managers.time:time("game") + PlayerActionSettings.tagging.knocked_down_cooldown
	end
end

function PlayerKnockedDown:exit(new_state)
	PlayerKnockedDown.super.exit(self, new_state)

	self._animation_curves_data = nil
	self._execution_time = nil
	self._yielded = false
	self._yield_time = nil

	local camera_manager = Managers.state.camera

	if camera_manager then
		camera_manager:stop_camera_effect_shake_event(self._knocked_down_camera_effect_id)
	end

	Managers.state.event:trigger("local_player_no_longer_kd", self._internal.player)
end

function PlayerKnockedDown:destroy()
	PlayerKnockedDown.super.destroy(self)
end
