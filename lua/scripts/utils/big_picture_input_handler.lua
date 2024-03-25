-- chunkname: @scripts/utils/big_picture_input_handler.lua

BigPictureInputHandler = class(BigPictureInputHandler)

local MAX_INPUT_CHARS = 512
local DEFAULT_INPUT_DELAY = 0.5

function BigPictureInputHandler:init()
	self:_setup_variables()
end

function BigPictureInputHandler:_setup_variables()
	self._overlay_active = false
	self._overlay_deactivate_time = Managers.time:time("main")
	self._max_length = MAX_INPUT_CHARS
	self._min_length = 0
end

function BigPictureInputHandler:is_deactivating()
	return self._overlay_deactivate_time and self._overlay_deactivate_time > Managers.time:time("main")
end

function BigPictureInputHandler:show_text_input(description, min_length, max_length, password)
	description = description or ""
	self._max_length = max_length or MAX_INPUT_CHARS
	self._min_length = min_length or 0

	local reason = "failed_to_open"

	if rawget(_G, "Steam") then
		if self._overlay_active then
			return false, "overlay_active"
		elseif not self._overlay_deactivate_time or Managers.time:time("main") > self._overlay_deactivate_time then
			if password then
				self._overlay_active = Steam.show_password_text_input_overlay(description, max_length)
			else
				self._overlay_active = Steam.show_text_input_overlay(description, max_length)
			end
		else
			reason = "deactivating"
		end
	end

	return self._overlay_active, reason
end

function BigPictureInputHandler:poll_text_input_done()
	local text = ""
	local submitted = false

	if self._overlay_active then
		local data = Steam.get_overlay_text_input()

		if not data.overlay_active then
			if data.submitted and data.text_length >= self._min_length then
				text = data.text
				submitted = true
			end

			self._overlay_active = false
			self._overlay_deactivate_time = Managers.time:time("main") + DEFAULT_INPUT_DELAY
		end
	end

	return text, self._overlay_active == false, submitted
end
