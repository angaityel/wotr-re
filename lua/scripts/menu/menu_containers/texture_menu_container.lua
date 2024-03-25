-- chunkname: @scripts/menu/menu_containers/texture_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

TextureMenuContainer = class(TextureMenuContainer, MenuContainer)

function TextureMenuContainer:init()
	TextureMenuContainer.super.init(self)
end

function TextureMenuContainer:update_size(dt, t, gui, layout_settings)
	local width, height

	if layout_settings.stretch_width then
		width = layout_settings.stretch_width
	elseif layout_settings.stretch_relative_width then
		local res_width, res_height = Gui.resolution()

		width = res_width * layout_settings.stretch_relative_width
	else
		width = layout_settings.texture_width
	end

	if layout_settings.stretch_height then
		height = layout_settings.stretch_height
	elseif layout_settings.stretch_relative_height then
		local res_width, res_height = Gui.resolution()

		height = res_height * layout_settings.stretch_relative_height
	elseif layout_settings.resize_to_relative_width then
		local w, h = Gui.resolution()

		width = w - layout_settings.resize_to_relative_width

		local scale = width / layout_settings.texture_width

		height = layout_settings.texture_height * scale
	else
		height = layout_settings.texture_height
	end

	self._width = math.clamp(width, layout_settings.texture_min_width or 0, width)
	self._height = math.clamp(height, layout_settings.texture_min_height or 0, height)
end

function TextureMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function TextureMenuContainer:render_from_child_page(dt, t, gui, layout_settings)
	local c = layout_settings.texture_color_render_from_child_page
	local color = Color(c[1], c[2], c[3], c[4])

	Gui.bitmap(gui, layout_settings.texture, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(math.floor(self._width), math.floor(self._height)), color)
end

function TextureMenuContainer:render(dt, t, gui, layout_settings)
	local color = layout_settings.color and Color(layout_settings.color[1], layout_settings.color[2], layout_settings.color[3], layout_settings.color[4]) or Color(255, 255, 255, 255)

	Gui.bitmap(gui, layout_settings.texture, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(math.floor(self._width), math.floor(self._height)), color)
end

function TextureMenuContainer.create_from_config()
	return TextureMenuContainer:new()
end
