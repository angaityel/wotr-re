-- chunkname: @scripts/menu/menu_containers/news_ticker_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

NewsTickerMenuContainer = class(NewsTickerMenuContainer, MenuContainer)

function NewsTickerMenuContainer:init()
	NewsTickerMenuContainer.super.init(self)

	self._text_table = nil
end

function NewsTickerMenuContainer:load()
	self._anim_offset_x = 0

	Managers.news_ticker:load(callback(self, "cb_news_ticker_loaded"))
end

function NewsTickerMenuContainer:cb_news_ticker_loaded(info)
	if not info.error and info.body ~= "" then
		self._text_table = MenuHelper:lines(info.body)
	else
		self._text_table = nil
	end
end

function NewsTickerMenuContainer:update_size(dt, t, gui, layout_settings)
	local res_width, res_height = Gui.resolution()

	self._width = res_width
	self._height = layout_settings.height
end

function NewsTickerMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function NewsTickerMenuContainer:render(dt, t, gui, layout_settings)
	if not self._text_table then
		return
	end

	self._anim_offset_x = self._anim_offset_x - dt * MenuSettings.news_ticker_speed

	local text_color = Color(layout_settings.text_color[1], layout_settings.text_color[2], layout_settings.text_color[3], layout_settings.text_color[4])
	local shadow_color_table = layout_settings.text_shadow_color
	local shadow_color = Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = Vector2(layout_settings.text_shadow_offset[1], layout_settings.text_shadow_offset[2])
	local text_y = self._y + layout_settings.text_offset_y
	local text_z = self._z + 2
	local text_offset_x = 0
	local delimiter_texture_y = math.floor(self._y + layout_settings.delimiter_texture_offset_y)
	local delimiter_texture_color = Color(layout_settings.delimiter_texture_color[1], layout_settings.delimiter_texture_color[2], layout_settings.delimiter_texture_color[3], layout_settings.delimiter_texture_color[4])

	for i, text in ipairs(self._text_table) do
		local text_x = self._width + text_offset_x + self._anim_offset_x + layout_settings.text_spacing
		local text_position = Vector3(text_x, math.floor(text_y), text_z)

		ScriptGUI.text(gui, text, layout_settings.font.font, layout_settings.font_size, layout_settings.font.material, text_position, text_color, shadow_color, shadow_offset)

		local min, max = Gui.text_extents(gui, text, layout_settings.font.font, layout_settings.font_size)
		local text_width = max[1] - min[1]

		text_offset_x = text_offset_x + text_width + layout_settings.text_spacing

		if i == 1 then
			Gui.bitmap(gui, layout_settings.delimiter_texture, Vector3(text_x - layout_settings.text_spacing / 2 - layout_settings.delimiter_texture_width / 2, delimiter_texture_y, text_z + 1), Vector2(layout_settings.delimiter_texture_width, layout_settings.delimiter_texture_height), delimiter_texture_color)
		end

		Gui.bitmap(gui, layout_settings.delimiter_texture, Vector3(text_x + text_width + layout_settings.text_spacing / 2 - layout_settings.delimiter_texture_width / 2, delimiter_texture_y, text_z + 1), Vector2(layout_settings.delimiter_texture_width, layout_settings.delimiter_texture_height), delimiter_texture_color)

		if i == #self._text_table and text_x + text_width + layout_settings.text_spacing < 0 then
			self._anim_offset_x = 0
		end
	end

	local background_rect_color = Color(layout_settings.background_rect_color[1], layout_settings.background_rect_color[2], layout_settings.background_rect_color[3], layout_settings.background_rect_color[4])

	Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(self._width, self._height), background_rect_color)

	local background_texture_color = Color(layout_settings.background_texture_color[1], layout_settings.background_texture_color[2], layout_settings.background_texture_color[3], layout_settings.background_texture_color[4])

	Gui.bitmap(gui, layout_settings.left_background_texture, Vector3(math.floor(self._x), self._y, self._z + 1), Vector2(layout_settings.left_background_texture_width, layout_settings.left_background_texture_height), background_texture_color)
	Gui.bitmap(gui, layout_settings.right_background_texture, Vector3(math.floor(self._x + self._width - layout_settings.right_background_texture_width), self._y, self._z + 1), Vector2(layout_settings.right_background_texture_width, layout_settings.right_background_texture_height), background_texture_color)
end
