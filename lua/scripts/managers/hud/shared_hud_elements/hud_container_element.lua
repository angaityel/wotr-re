-- chunkname: @scripts/managers/hud/shared_hud_elements/hud_container_element.lua

require("scripts/helpers/hud_helper")

HUDContainerElement = class(HUDContainerElement)

function HUDContainerElement:init(config)
	self.config = config
	self._elements = {}
	self._width = nil
	self._height = nil
end

function HUDContainerElement:width()
	return self._width
end

function HUDContainerElement:height()
	return self._height
end

function HUDContainerElement:add_element(id, element)
	self._elements[id] = element
end

function HUDContainerElement:remove_element(id)
	self._elements[id] = nil
end

function HUDContainerElement:elements()
	return self._elements
end

function HUDContainerElement:has_element(id)
	return self._elements[id] and true or false
end

function HUDContainerElement:element(id)
	return self._elements[id]
end

function HUDContainerElement:num_of_elements()
	return table.size(self._elements)
end

function HUDContainerElement:update_size(dt, t, gui, layout_settings)
	local res_width, res_height = Gui.resolution()

	self._width = layout_settings.width or res_width
	self._height = layout_settings.height or res_height

	for id, element in pairs(self._elements) do
		element:update_size(dt, t, gui, HUDHelper:layout_settings(element.config.layout_settings))
	end
end

function HUDContainerElement:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z

	for id, element in pairs(self._elements) do
		local element_layout_settings = HUDHelper:layout_settings(element.config.layout_settings)
		local offset_x, offset_y = HUDHelper:element_position(self, element, element_layout_settings)
		local element_x = offset_x + x
		local element_y = offset_y + y
		local element_z = (element.config.z or 1) + z

		element:update_position(dt, t, element_layout_settings, element_x, element_y, element_z)
	end
end

function HUDContainerElement:render(dt, t, gui, layout_settings)
	for id, element in pairs(self._elements) do
		element:render(dt, t, gui, HUDHelper:layout_settings(element.config.layout_settings))
	end

	if layout_settings.background_color then
		local color = Color(layout_settings.background_color[1], layout_settings.background_color[2], layout_settings.background_color[3], layout_settings.background_color[4])

		Gui.rect(gui, Vector3(self._x, self._y, self._z), Vector2(self._width, self._height), color)
	end
end

function HUDContainerElement.create_from_config(config)
	return HUDContainerElement:new(config)
end
