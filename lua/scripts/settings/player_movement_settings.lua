-- chunkname: @scripts/settings/player_movement_settings.lua

PlayerUnitMovementSettings = PlayerUnitMovementSettings or {}
PlayerUnitMovementSettings.functions = PlayerUnitMovementSettings.functions or {}

function PlayerUnitMovementSettings.functions.SIN(t)
	return math.sin(t)
end

function PlayerUnitMovementSettings.functions.LOG(t)
	return math.log(t)
end

function PlayerUnitMovementSettings.functions.QUAD(t)
	return t * t
end

PlayerUnitMovementSettings.FWD_MOVE_SPEED_SCALE = 1
PlayerUnitMovementSettings.BWD_MOVE_SPEED_SCALE = 0.85
PlayerUnitMovementSettings.STRAFE_MOVE_SPEED_SCALE = 1

local ENC_LIGHT = 0.8
local ENC_METER = 18.16
local ENC_HEAVY = 34.18
local ENC_MAX = 100

PlayerUnitMovementSettings.crouch_move_speed = 1.4
PlayerUnitMovementSettings.move_speed = 2.8
PlayerUnitMovementSettings.backward_move_scale = 0.7
PlayerUnitMovementSettings.strafe_move_scale = 0.9

function PlayerUnitMovementSettings.movement_acceleration(dt, current_speed, target_speed, encumbrance_factor, acceleration_multiplier)
	local acceleration = (math.abs(current_speed - target_speed) * 1 + 3) * dt * encumbrance_factor * acceleration_multiplier

	if target_speed < current_speed then
		return math.max(current_speed - acceleration, target_speed)
	else
		return math.min(current_speed + acceleration, target_speed)
	end
end

PlayerUnitMovementSettings.double_time = PlayerUnitMovementSettings.double_time or {}
PlayerUnitMovementSettings.double_time.move_speed = 1.5
PlayerUnitMovementSettings.double_time.timer_time = 3
PlayerUnitMovementSettings.double_time.ramp_up_time = 0.5
PlayerUnitMovementSettings.double_time.ramp_down_time = 1.5
PlayerUnitMovementSettings.double_time.rotation_penalty_multiplier = 0.001
PlayerUnitMovementSettings.lock_camera_when_attacking_time = 0.3
PlayerUnitMovementSettings.rush = PlayerUnitMovementSettings.rush or {}
PlayerUnitMovementSettings.rush.speed = 4.44444444444444
PlayerUnitMovementSettings.rush.speed_swinging = 3.88888888888889
PlayerUnitMovementSettings.rush.speed_posing = 4.16666666666667
PlayerUnitMovementSettings.rush.duration = math.huge
PlayerUnitMovementSettings.rush.SPEED_FUNCTION = PlayerUnitMovementSettings.functions.LOG
PlayerUnitMovementSettings.rush.cooldown = 0
PlayerUnitMovementSettings.rush.RUSH_CONTROL = "hold"
PlayerUnitMovementSettings.rush.MAX_ROTATION_SPEED = 90
PlayerUnitMovementSettings.rush.strafe_speed_proportion = 0.9
PlayerUnitMovementSettings.rush.strafe_move_scale = 0.9
PlayerUnitMovementSettings.rush.max_rush_stamina = 30
PlayerUnitMovementSettings.rush.stun_front_duration = 0.3
PlayerUnitMovementSettings.rush.stun_back_duration = 1.5
PlayerUnitMovementSettings.jump = PlayerUnitMovementSettings.jump or {}
PlayerUnitMovementSettings.jump.stamina_cost = 0
PlayerUnitMovementSettings.jump.forward_jump = PlayerUnitMovementSettings.jump.forward_jump or {}
PlayerUnitMovementSettings.jump.forward_jump.minimum_horizontal_velocity = 1
PlayerUnitMovementSettings.jump.forward_jump.initial_vertical_velocity = 4
PlayerUnitMovementSettings.jump.stationary_jump = PlayerUnitMovementSettings.jump.stationary_jump or {}
PlayerUnitMovementSettings.jump.stationary_jump.initial_vertical_velocity = 4
PlayerUnitMovementSettings.fall = PlayerUnitMovementSettings.fall or {}
PlayerUnitMovementSettings.fall.heights = PlayerUnitMovementSettings.fall.heights or {}
PlayerUnitMovementSettings.fall.heights.dead = 9
PlayerUnitMovementSettings.fall.heights.knocked_down = 6
PlayerUnitMovementSettings.fall.heights.heavy = 3
PlayerUnitMovementSettings.landing = PlayerUnitMovementSettings.landing or {}
PlayerUnitMovementSettings.landing.anim_forced_upper_body_block = 0.3
PlayerUnitMovementSettings.mounted = PlayerUnitMovementSettings.mounted or {}
PlayerUnitMovementSettings.mounted.aim_target_constraint_left = -math.pi * 0.75
PlayerUnitMovementSettings.mounted.aim_target_constraint_right = math.pi * 0.75
PlayerUnitMovementSettings.mounted.use_lean = true
PlayerUnitMovementSettings.swing = PlayerUnitMovementSettings.swing or {}
PlayerUnitMovementSettings.swing.REQUIRED_MOVEMENT_TO_POSE = 0.003
PlayerUnitMovementSettings.swing.REQUIRED_MOVEMENT_TO_POSE_SCALE_Y_UP = 1.8
PlayerUnitMovementSettings.swing.REQUIRED_MOVEMENT_TO_POSE_SCALE_Y_DOWN = 2.2
PlayerUnitMovementSettings.swing.MAX_MOVEMENT_TO_POSE_SPEED = 0.21
PlayerUnitMovementSettings.swing.invert_pose_control_x = false
PlayerUnitMovementSettings.swing.invert_pose_control_y = false
PlayerUnitMovementSettings.swing.keyboard_controlled = false
PlayerUnitMovementSettings.swing.mounted_lean_swing_top = 0
PlayerUnitMovementSettings.swing.mounted_lean_swing_range = 30
PlayerUnitMovementSettings.encumbrance = PlayerUnitMovementSettings.encumbrance or {}
PlayerUnitMovementSettings.encumbrance.functions = PlayerUnitMovementSettings.encumbrance.functions or {}

function PlayerUnitMovementSettings.encumbrance.functions.pose_time(enc)
	if enc < ENC_LIGHT then
		return 0.9
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.9, 1.1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1.1, 1.3, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.3, 1.5, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.reload_time(enc)
	if enc < ENC_LIGHT then
		return 1
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.35, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.35, 3.75, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.movement_acceleration(enc)
	if enc < ENC_LIGHT then
		return 1.4
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.4, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.525, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.525, 0.45, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.movement_speed(enc)
	if enc < ENC_LIGHT then
		return 1.1
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.1, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.9, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.9, 0.8, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.double_time_speed(enc)
	if enc < ENC_LIGHT then
		return 0.97
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.97, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.04, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.04, 1.15, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.charge_duration(enc)
	if enc < ENC_LIGHT then
		return 1.3
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.3, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.7, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.7, 0.35, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.charge_cooldown(enc)
	if enc < ENC_LIGHT then
		return 0.95
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.95, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.3, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.3, 1.5, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.charge_speed(enc)
	if enc < ENC_LIGHT then
		return 1.05
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.05, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.95, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.95, 0.85, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.climbing_ladders_speed(enc)
	if enc < ENC_LIGHT then
		return 1.3
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.3, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.71, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.71, 0.5, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.miss_penalty(enc)
	if enc < ENC_LIGHT then
		return 0.9
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.9, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.2, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.2, 1.3, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.not_penetrated_penalty(enc)
	if enc < ENC_LIGHT then
		return 0.9
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.9, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.1, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.1, 1.2, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.parried_penalty(enc)
	if enc < ENC_LIGHT then
		return 0.9
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.9, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.2, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.2, 1.3, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.hard_penalty(enc)
	if enc < ENC_LIGHT then
		return 0.9
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.9, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.2, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.2, 1.3, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.blocked_penalty(enc)
	if enc < ENC_LIGHT then
		return 0.9
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.9, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.2, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.2, 1.3, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.double_time_acceleration(enc)
	if enc < ENC_LIGHT then
		return 0.9
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.9, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.1, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.1, 1.15, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.ammo_regen_rate(enc)
	if enc < ENC_LIGHT then
		return 1.5
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.5, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.5, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.5, 0.25, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.wield_time(enc)
	if enc < ENC_LIGHT then
		return 0.8
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.8, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.2, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.2, 2, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.stun_time(enc)
	if enc < ENC_LIGHT then
		return 0.8
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.8, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.2, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.2, 1.4, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.heavy_landing_height(enc)
	if enc < ENC_LIGHT then
		return 1.5
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.5, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.75, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.75, 0.65, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.stamina_regen(enc)
	if enc < ENC_LIGHT then
		return 1.05
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.05, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.75, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.75, 0.5, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.stamina_max(enc)
	if enc < ENC_LIGHT then
		return 0.8
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 0.8, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 1.5, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 1.5, 2, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.movement_speed_backwards(enc)
	if enc < ENC_LIGHT then
		return 1.1
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.1, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.8, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.8, 0.7, enc)
	end
end

function PlayerUnitMovementSettings.encumbrance.functions.movement_speed_strafe(enc)
	if enc < ENC_LIGHT then
		return 1.1
	elseif enc < ENC_METER then
		return math.auto_lerp(ENC_LIGHT, ENC_METER, 1.1, 1, enc)
	elseif enc < ENC_HEAVY then
		return math.auto_lerp(ENC_METER, ENC_HEAVY, 1, 0.8, enc)
	else
		return math.auto_lerp(ENC_HEAVY, ENC_MAX, 0.8, 0.7, enc)
	end
end

PlayerUnitMovementSettings.parry = PlayerUnitMovementSettings.parry or {}
PlayerUnitMovementSettings.parry.REQUIRED_MOVEMENT_TO_POSE = 0.003
PlayerUnitMovementSettings.parry.invert_parry_control_x = false
PlayerUnitMovementSettings.parry.invert_parry_control_y = false
PlayerUnitMovementSettings.parry.keyboard_controlled = false
PlayerUnitMovementSettings.parry.raise_delay = 0.01
PlayerUnitMovementSettings.block = PlayerUnitMovementSettings.block or {}
PlayerUnitMovementSettings.block.raise_delay = 0.01
PlayerUnitMovementSettings.revive_teammate = PlayerUnitMovementSettings.revive_teammate or {}
PlayerUnitMovementSettings.revive_teammate.DURATION = 1
PlayerUnitMovementSettings.interaction = PlayerUnitMovementSettings.interaction or {}
PlayerUnitMovementSettings.interaction.priorities = {
	"flag_plant",
	"flag_pickup",
	"revive",
	"execute",
	"bandage",
	"dismount",
	"climb",
	"mount",
	"trigger",
	"flag_drop",
	"flag_spawn"
}
PlayerUnitMovementSettings.interaction.settings = {
	flag_plant = {
		duration = 5
	},
	execute = {
		begin_anim_event = "idle",
		duration = 5.3,
		duration_after_kill = 0,
		end_anim_event = "execute_attacker_end"
	},
	revive = {
		begin_anim_event = "revive_team_mate",
		duration = 6,
		animation_time_var = "revive_team_mate_time",
		end_anim_event = "revive_team_mate_end"
	},
	bandage = {
		break_distance = 2,
		duration = 3,
		begin_anim_event = "bandage_team_mate",
		end_anim_event = "bandage_end"
	},
	bandage_self = {
		break_distance = 2,
		duration = 6,
		begin_anim_event = "bandage_self",
		end_anim_event = "bandage_end"
	},
	climb = {
		speed = 1
	}
}
PlayerUnitMovementSettings.ghost_mode = {
	local_actors = {
		"c_hips",
		"c_leftupleg",
		"c_leftleg",
		"c_leftfoot",
		"c_rightupleg",
		"c_rightleg",
		"c_rightfoot",
		"c_spine",
		"c_spine1",
		"c_spine2",
		"c_leftarm",
		"c_leftforearm",
		"c_lefthand",
		"c_rightarm",
		"c_rightforearm",
		"c_righthand",
		"afro_projectile_trigger",
		"simple_hit_box"
	},
	husk_actors = {
		"c_hips",
		"c_leftupleg",
		"c_leftleg",
		"c_leftfoot",
		"c_rightupleg",
		"c_rightleg",
		"c_rightfoot",
		"c_spine",
		"c_spine1",
		"c_spine2",
		"c_leftarm",
		"c_leftforearm",
		"c_lefthand",
		"c_rightarm",
		"c_rightforearm",
		"c_righthand",
		"c_afro",
		"interaction_shape",
		"husk",
		"simple_hit_box"
	}
}
