-- chunkname: @scripts/settings/camera_transition_templates.lua

CameraTransitionTemplates = CameraTransitionTemplates or {}

local DURATION = 0.3

CameraTransitionTemplates.instant_cut = {}
CameraTransitionTemplates.player_fast = {
	position = {
		class = "CameraTransitionPositionLinear",
		duration = DURATION,
		transition_func = function(t)
			return math.sin(0.5 * t * math.pi)
		end
	},
	rotation = {
		class = "CameraTransitionRotationLerp",
		duration = DURATION * 0.8
	},
	vertical_fov = {
		class = "CameraTransitionFOVLinear",
		duration = DURATION * 0.8
	},
	pitch_offset = {
		class = "CameraTransitionGeneric",
		parameter = "pitch_offset",
		duration = DURATION * 0.8,
		transition_func = function(t)
			return math.sin(0.5 * t * math.pi)
		end
	}
}
CameraTransitionTemplates.dead = {
	position = {
		class = "CameraTransitionPositionLinear",
		duration = 1,
		transition_func = function(t)
			return math.sin(0.5 * t * math.pi)
		end
	},
	rotation = {
		class = "CameraTransitionRotationLerp",
		duration = 0.8
	},
	vertical_fov = {
		class = "CameraTransitionFOVLinear",
		duration = 0.8
	}
}
CameraTransitionTemplates.swing_blend_to_swing = {
	pitch_speed = {
		parameter = "pitch_speed",
		duration = 0.3,
		class = "CameraTransitionGeneric",
		transition_func = function(t)
			return math.sin(0.5 * t * math.pi)
		end
	},
	yaw_speed = {
		parameter = "yaw_speed",
		duration = 0.3,
		class = "CameraTransitionGeneric",
		transition_func = function(t)
			return math.sin(0.5 * t * math.pi)
		end
	},
	vertical_fov = {
		class = "CameraTransitionFOVLinear",
		duration = DURATION * 0.8
	}
}
CameraTransitionTemplates.swing_blend_to_other = {
	position = {
		class = "CameraTransitionPositionLinear",
		duration = DURATION,
		transition_func = function(t)
			return math.sin(0.5 * t * math.pi)
		end
	},
	rotation = {
		class = "CameraTransitionRotationLerp",
		duration = DURATION * 0.8
	},
	pitch_speed = {
		parameter = "pitch_speed",
		duration = 0.3,
		class = "CameraTransitionGeneric",
		transition_func = function(t)
			return math.sin(0.5 * t * math.pi)
		end
	},
	yaw_speed = {
		parameter = "yaw_speed",
		duration = 0.3,
		class = "CameraTransitionGeneric",
		transition_func = function(t)
			return math.sin(0.5 * t * math.pi)
		end
	},
	vertical_fov = {
		class = "CameraTransitionFOVLinear",
		duration = DURATION * 0.8
	}
}
CameraTransitionTemplates.between_units_fast = {
	inherit_aim_rotation = true,
	position = {
		class = "CameraTransitionPositionLinear",
		freeze_start_node = true,
		duration = DURATION
	},
	rotation = {
		class = "CameraTransitionRotationLerp",
		freeze_start_node = true,
		duration = DURATION * 0.8
	}
}
CameraTransitionTemplates.mounting = {
	inherit_aim_rotation = true,
	position = {
		class = "CameraTransitionPositionLinear",
		duration = DURATION
	},
	rotation = {
		class = "CameraTransitionRotationLerp",
		freeze_start_node = true,
		duration = DURATION * 0.8
	}
}
CameraTransitionTemplates.between_units_fast = {
	inherit_aim_rotation = true,
	position = {
		class = "CameraTransitionPositionLinear",
		freeze_start_node = true,
		duration = DURATION
	},
	rotation = {
		class = "CameraTransitionRotationLerp",
		freeze_start_node = true,
		duration = DURATION * 0.8
	}
}
