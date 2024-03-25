-- chunkname: @scripts/unit_extensions/horse/states/horse_onground_ai.lua

HorseOngroundAi = class(HorseOngroundAi, HorseOnground)

local ROTATION_MAX_SPEED = 3
local ROTATION_ACCELERATION = ROTATION_MAX_SPEED * 3
local ANIM_ROTATION_MAX_SPEED = 1
local IDLE_TURN_ANIM_ROTATION_SPEED_THRESHOLD = 0.3
local ANIM_ROTATION_ACCELERATION = ANIM_ROTATION_MAX_SPEED * 6

function HorseOngroundAi:enter(old_state)
	HorseOngroundAi.super.enter(self, old_state)

	if old_state == "onground" then
		self._move_style = self._internal._states[old_state]._move_style
	end

	self._internal.cruise_control = false
end
