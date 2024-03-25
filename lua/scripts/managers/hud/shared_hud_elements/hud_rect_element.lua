-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_rect_element.lua

HUDRectElement = class(HUDRectElement)

function HUDRectElement:init(gui, config)
	self._gui = gui
	self._blackboard = config.blackboard
	self.config = config
end

function HUDRectElement:render(dt, t, x, y)
	local config = self.config
	local color = self._blackboard and self._blackboard.color or self.config.color

	Gui.rect(self._gui, Vector3(x, y, config.layer), Vector2(config.width, config.height), Color(color[1], color[2], color[3], color[4]))
end
