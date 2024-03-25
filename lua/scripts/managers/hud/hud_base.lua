-- chunkname: @scripts/managers/hud/hud_base.lua

HUDBase = class(HUDBase)

function HUDBase:init(world, player)
	self._enabled = true
end

function HUDBase:on_activated()
	return
end

function HUDBase:on_deactivated()
	return
end

function HUDBase:set_enabled(enabled)
	self._enabled = enabled
end

function HUDBase:enabled()
	return self._enabled
end

function HUDBase:post_update(dt, t)
	return
end

function HUDBase:disabled_post_update(dt, t)
	return
end

function HUDBase:_handle_input_switch(elements, container, text_callback)
	local pad_active = Managers.input:pad_active(1)

	if self._pad_active == nil or pad_active ~= self._pad_active then
		self._pad_active = pad_active

		for _, id in pairs(elements) do
			local element = container:element(id)

			element.config.blackboard.text = text_callback(element, self._pad_active)
		end

		return pad_active
	end
end
