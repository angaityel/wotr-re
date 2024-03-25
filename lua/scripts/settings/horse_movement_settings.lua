-- chunkname: @scripts/settings/horse_movement_settings.lua

local KMPH_TO_MPS = 0.2777777777777778

HorseUnitMovementSettings = HorseUnitMovementSettings or {}
HorseUnitMovementSettings.gaits = HorseUnitMovementSettings.gaits or {}
HorseUnitMovementSettings.gaits.back = HorseUnitMovementSettings.back or {}
HorseUnitMovementSettings.gaits.back.speed_min = -2.22
HorseUnitMovementSettings.gaits.back.speed_max = -0.83
HorseUnitMovementSettings.gaits.back.shifted_to_min_speed = HorseUnitMovementSettings.gaits.back.speed_min
HorseUnitMovementSettings.gaits.back.shifted_to_max_speed = HorseUnitMovementSettings.gaits.back.speed_max
HorseUnitMovementSettings.gaits.back.anim_event = "horse_backing"
HorseUnitMovementSettings.gaits.idle = HorseUnitMovementSettings.idle or {}
HorseUnitMovementSettings.gaits.idle.speed_min = -0.03
HorseUnitMovementSettings.gaits.idle.speed_max = 0.03
HorseUnitMovementSettings.gaits.idle.shifted_to_min_speed = HorseUnitMovementSettings.gaits.idle.speed_min
HorseUnitMovementSettings.gaits.idle.shifted_to_max_speed = HorseUnitMovementSettings.gaits.idle.speed_max
HorseUnitMovementSettings.gaits.idle.anim_event = "horse_idle"
HorseUnitMovementSettings.gaits.idle.anim_rot_right_event = "horse_idle_turn_right"
HorseUnitMovementSettings.gaits.idle.anim_rot_left_event = "horse_idle_turn_left"
HorseUnitMovementSettings.gaits.idle.animation_driven_rotation = true
HorseUnitMovementSettings.gaits.walk = HorseUnitMovementSettings.walk or {}
HorseUnitMovementSettings.gaits.walk.speed_min = 0.83
HorseUnitMovementSettings.gaits.walk.speed_max = 1.67
HorseUnitMovementSettings.gaits.walk.shifted_to_min_speed = HorseUnitMovementSettings.gaits.walk.speed_min
HorseUnitMovementSettings.gaits.walk.shifted_to_max_speed = HorseUnitMovementSettings.gaits.walk.speed_max
HorseUnitMovementSettings.gaits.walk.anim_event = "horse_walk"
HorseUnitMovementSettings.gaits.trot = HorseUnitMovementSettings.trot or {}
HorseUnitMovementSettings.gaits.trot.speed_min = 2.78
HorseUnitMovementSettings.gaits.trot.speed_max = 4.17
HorseUnitMovementSettings.gaits.trot.shifted_to_min_speed = HorseUnitMovementSettings.gaits.trot.speed_min
HorseUnitMovementSettings.gaits.trot.shifted_to_max_speed = HorseUnitMovementSettings.gaits.trot.speed_max
HorseUnitMovementSettings.gaits.trot.anim_event = "horse_trot"
HorseUnitMovementSettings.gaits.canter = HorseUnitMovementSettings.canter or {}
HorseUnitMovementSettings.gaits.canter.speed_min = 5.28
HorseUnitMovementSettings.gaits.canter.speed_max = 7.5
HorseUnitMovementSettings.gaits.canter.shifted_to_min_speed = HorseUnitMovementSettings.gaits.canter.speed_min
HorseUnitMovementSettings.gaits.canter.shifted_to_max_speed = HorseUnitMovementSettings.gaits.canter.speed_max
HorseUnitMovementSettings.gaits.canter.anim_event = "horse_canter"
HorseUnitMovementSettings.gaits.canter.allow_brake = true
HorseUnitMovementSettings.gaits.gallop = HorseUnitMovementSettings.gallop or {}
HorseUnitMovementSettings.gaits.gallop.speed_min = 7.78
HorseUnitMovementSettings.gaits.gallop.speed_max = 8.6
HorseUnitMovementSettings.gaits.gallop.shifted_to_min_speed = HorseUnitMovementSettings.gaits.gallop.speed_min
HorseUnitMovementSettings.gaits.gallop.shifted_to_max_speed = HorseUnitMovementSettings.gaits.gallop.speed_max
HorseUnitMovementSettings.gaits.gallop.anim_event = "horse_gallop"
HorseUnitMovementSettings.gaits.gallop.allow_brake = true
HorseUnitMovementSettings.gait_order = {
	"back",
	"idle",
	"walk",
	"trot",
	"canter",
	"gallop"
}
HorseUnitMovementSettings.gait_lookup = {}

for index, key in ipairs(HorseUnitMovementSettings.gait_order) do
	HorseUnitMovementSettings.gait_lookup[key] = index
end

HorseUnitMovementSettings.gait_tap_threshold = 0.1

function HorseUnitMovementSettings.acceleration_function(speed, dt)
	return speed + dt * 5 * KMPH_TO_MPS
end

function HorseUnitMovementSettings.brake_function(speed, dt)
	return speed - dt * 5 * KMPH_TO_MPS
end

HorseUnitMovementSettings.ai_speed_decay = 3
HorseUnitMovementSettings.cruise_control = HorseUnitMovementSettings.cruise_control or {}
HorseUnitMovementSettings.cruise_control.start_gear = 2
HorseUnitMovementSettings.cruise_control.gears = {
	{
		speed = -2.22,
		name = "reverse",
		gait = "back"
	},
	{
		speed = 0,
		name = "stop",
		gait = "idle"
	},
	{
		speed = 1.67,
		name = "slow",
		gait = "walk"
	},
	{
		speed = 4.17,
		name = "maneuver",
		gait = "trot"
	},
	{
		speed = 7.5,
		name = "fast",
		gait = "canter"
	}
}
HorseUnitMovementSettings.charge = HorseUnitMovementSettings.charge or {}
HorseUnitMovementSettings.charge.speed_min = HorseUnitMovementSettings.gaits.gallop.speed_min
HorseUnitMovementSettings.charge.speed_max = 9.72
HorseUnitMovementSettings.charge.speed_when_out_of_stamina = HorseUnitMovementSettings.gaits.gallop.speed_max^3 / HorseUnitMovementSettings.charge.speed_max^2
HorseUnitMovementSettings.charge.anim_event = "horse_charge"
HorseUnitMovementSettings.charge.charge_acceleration_time = 1
HorseUnitMovementSettings.charge.lateral_movement_type = "turn"
HorseUnitMovementSettings.charge.trigger_mode = "hold"
HorseUnitMovementSettings.charge.strafe_speed = 2.5
HorseUnitMovementSettings.hand_brake = HorseUnitMovementSettings.hand_brake or {}
HorseUnitMovementSettings.hand_brake.duration = 1.2
HorseUnitMovementSettings.hand_brake.turn_speed = 2.1
HorseUnitMovementSettings.hand_brake.full_stop = 0.1
HorseUnitMovementSettings.hand_brake.allow_interrupt = false
HorseUnitMovementSettings.behaviour = {}
HorseUnitMovementSettings.behaviour.debug = false
HorseUnitMovementSettings.behaviour.look_ahead_length = 2.1
HorseUnitMovementSettings.behaviour.min_look_ahead = 1
HorseUnitMovementSettings.behaviour.slow_down = {}
HorseUnitMovementSettings.behaviour.slow_down.min_speed = HorseUnitMovementSettings.cruise_control.gears[3].speed
HorseUnitMovementSettings.behaviour.slow_down.max_speed = HorseUnitMovementSettings.gaits[HorseUnitMovementSettings.gait_order[#HorseUnitMovementSettings.gait_order]].speed_max
HorseUnitMovementSettings.behaviour.stop = {}
HorseUnitMovementSettings.behaviour.stop.threshold_angle = 20
HorseUnitMovementSettings.behaviour.stop.threshold_distance = 2
HorseUnitMovementSettings.behaviour.deflect = {}
HorseUnitMovementSettings.behaviour.deflect.threshold_distance = 3
HorseUnitMovementSettings.obstacle_impact = HorseUnitMovementSettings.obstacle or {}
HorseUnitMovementSettings.obstacle_impact.energy_transfer_rate = 0.25
HorseUnitMovementSettings.despawn_settings = HorseUnitMovementSettings.despawn_settings or {}
HorseUnitMovementSettings.despawn_settings.time_before_despawn = 15
HorseUnitMovementSettings.despawn_settings.range_before_despawn = 25
