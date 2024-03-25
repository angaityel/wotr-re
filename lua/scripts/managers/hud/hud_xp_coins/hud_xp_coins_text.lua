-- chunkname: @scripts/managers/hud/hud_xp_coins/hud_xp_coins_text.lua

require("scripts/managers/hud/shared_hud_elements/hud_text_element")

local FADE_IN_DURATION = 0.3
local STAY_DURATION = 1
local FADE_OUT_DURATION = 2

HUDXPCoinsText = class(HUDXPCoinsText, HUDTextElement)

function HUDXPCoinsText:init(config)
	HUDXPCoinsText.super.init(self, config)
end

function HUDXPCoinsText:set_start_time(start_time)
	self._start_time = start_time
end

function HUDXPCoinsText:start_time()
	return self._start_time
end

function HUDXPCoinsText:start(t)
	self._state = "fade_in"
	self._end_time = t + FADE_IN_DURATION
end

function HUDXPCoinsText:update(dt, t, x, y, layout_settings, gui)
	if self._state == "fade_in" then
		self:_update_fade_in(dt, t, layout_settings)
	elseif self._state == "stay" then
		self:_update_stay(dt, t, layout_settings)
	elseif self._state == "fade_out" then
		self:_update_fade_out(dt, t, layout_settings)
	else
		return true
	end

	self:update_size(dt, t, gui, layout_settings)
	self:update_position(dt, t, layout_settings, x, y, 0)
	self:render(dt, t, gui, layout_settings)
end

function HUDXPCoinsText:_update_fade_in(dt, t, layout_settings)
	local progress = math.clamp((self._end_time - t) / FADE_IN_DURATION, 0, 1)

	layout_settings.text_color[1] = math.lerp(255, 0, progress)

	if t >= self._end_time then
		self._state = "stay"
		self._end_time = t + STAY_DURATION
	end
end

function HUDXPCoinsText:_update_stay(dt, t, layout_settings)
	if t >= self._end_time then
		self._state = "fade_out"
		self._end_time = t + FADE_OUT_DURATION
	end
end

function HUDXPCoinsText:_update_fade_out(dt, t, layout_settings)
	local progress = math.clamp(1 - (self._end_time - t) / FADE_OUT_DURATION, 0, 1)

	layout_settings.text_color[1] = math.lerp(255, 0, progress^2)

	if t >= self._end_time then
		self._state = "done"
	end
end

function HUDXPCoinsText.create_from_config(reason, xp, coins)
	local text = "%s: "

	text = text .. (xp > 0 and "%d (XP) " or "")
	text = text .. (coins > 0 and "%d (Coins)" or "")

	local config = {
		text = string.format(text, L("xp_" .. reason), xp, coins),
		layout_settings = table.clone(HUDSettings.xp_and_coins)
	}

	return HUDXPCoinsText:new(config)
end
