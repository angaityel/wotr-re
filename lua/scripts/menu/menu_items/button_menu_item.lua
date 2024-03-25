-- chunkname: @scripts/menu/menu_items/button_menu_item.lua

require("scripts/menu/menu_items/menu_item")

ButtonMenuItem = class(ButtonMenuItem, MenuItem)

function ButtonMenuItem:init(config, world)
	ButtonMenuItem.super.init(self, config, world)
end

function ButtonMenuItem:set_text(text)
	self.config.text = text
end

function ButtonMenuItem:update_size(dt, t, gui, layout_settings)
	local min, max = Gui.text_extents(gui, self.config.text, MenuSettings.fonts.menu_font.material, layout_settings.font_size)

	self._text_width = max[1] - min[1]
	self._text_height = max[3] - min[3]
	self._width = layout_settings.background_width + layout_settings.padding_left + layout_settings.padding_right
	self._height = layout_settings.background_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function ButtonMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
	self._text_x = x + layout_settings.padding_left + (layout_settings.background_width / 2 - self._text_width / 2)
	self._text_y = y + layout_settings.text_y
end

function ButtonMenuItem:render(dt, t, gui, layout_settings)
	if self.config.disabled_func then
		self.config.disabled = self.config.disabled_func()
	end

	self:_render_background(gui, layout_settings)
	self:_render_text(gui, layout_settings)
end

function ButtonMenuItem:_render_background(gui, layout_settings)
	local color = self.config.disabled and layout_settings.background_color_disabled or self._highlighted and layout_settings.background_color_highlighted or layout_settings.background_color

	Gui.rect(gui, Vector3(math.floor(self._x + layout_settings.padding_left), math.floor(self._y + layout_settings.padding_bottom), self._z), Vector2(math.floor(layout_settings.background_width), math.floor(layout_settings.background_height)), Color(color[1], color[2], color[3], color[4]))
end

function ButtonMenuItem:_render_text(gui, layout_settings)
	local config = self.config
	local color = config.disabled and layout_settings.text_color_disabled or self._highlighted and layout_settings.text_color_highlighted or layout_settings.text_color

	ScriptGUI.text(gui, config.text, MenuSettings.fonts.menu_font.font, layout_settings.font_size, MenuSettings.fonts.menu_font.material, Vector3(math.floor(self._text_x), math.floor(self._text_y), self._z + 1), Color(color[1], color[2], color[3], color[4]))
end

function ButtonMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = config.type,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func),
		text = L(config.text),
		layout_settings = config.layout_settings
	}

	return ButtonMenuItem:new(config, compiler_data.world)
end
