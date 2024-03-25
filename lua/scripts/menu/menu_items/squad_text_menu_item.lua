-- chunkname: @scripts/menu/menu_items/squad_text_menu_item.lua

require("scripts/menu/menu_items/text_menu_item")

SquadTextMenuItem = class(SquadTextMenuItem, TextMenuItem)

function SquadTextMenuItem:init(config, world)
	SquadTextMenuItem.super.init(self, config, world)

	self._num_members = 0
	self._num_max_members = "?"
	self._joined = false
end

function SquadTextMenuItem:set_joined(joined)
	self._joined = joined
end

function SquadTextMenuItem:set_num_max_members(num_max_members)
	self._num_max_members = num_max_members
end

function SquadTextMenuItem:set_num_members(num_members)
	self._num_members = num_members
end

function SquadTextMenuItem:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.width
	self._height = layout_settings.texture_height + layout_settings.padding_top + layout_settings.padding_bottom
end

function SquadTextMenuItem:render(dt, t, gui, layout_settings)
	local c = self._highlighted and layout_settings.color_highlighted or self._joined and layout_settings.color_joined or layout_settings.color
	local color = Color(c[1], c[2], c[3], c[4])
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local column_1_text = self.config.text
	local column_1_x = self._x + layout_settings.column_1_offset_x
	local column_1_y = self._y + layout_settings.padding_bottom + layout_settings.text_offset_y

	ScriptGUI.text(gui, column_1_text, font, layout_settings.font_size, font_material, Vector3(math.floor(column_1_x), math.floor(column_1_y), self._z + 1), color)

	local column_2_text = self._num_members .. " / " .. self._num_max_members
	local min, max = Gui.text_extents(gui, column_2_text, font, layout_settings.font_size)
	local column_2_text_width = max[1] - min[1]
	local column_2_x = self._x + layout_settings.column_2_offset_x - column_2_text_width
	local column_2_y = self._y + layout_settings.padding_bottom + layout_settings.text_offset_y

	ScriptGUI.text(gui, column_2_text, font, layout_settings.font_size, font_material, Vector3(math.floor(column_2_x), math.floor(column_2_y), self._z + 1), color)

	local texture_c = self._highlighted and layout_settings.texture_color_highlighted or self._joined and layout_settings.texture_color_joined or layout_settings.texture_color
	local texture_color = Color(texture_c[1], texture_c[2], texture_c[3], texture_c[4])
	local texture_x = self._x + self._width - layout_settings.texture_width
	local texture_y = self._y + layout_settings.padding_bottom

	Gui.bitmap(gui, layout_settings.texture, Vector3(math.floor(texture_x), math.floor(texture_y), self._z), Vector2(layout_settings.texture_width, layout_settings.texture_height), texture_color)

	if self._joined then
		local joined_texture_x = self._x + self._width
		local joined_texture_y = self._y + self._height / 2 - layout_settings.joined_texture_height / 2

		Gui.bitmap(gui, layout_settings.joined_texture, Vector3(math.floor(joined_texture_x), math.floor(joined_texture_y), self._z), Vector2(layout_settings.joined_texture_width, layout_settings.joined_texture_height))

		local joined_text_c = layout_settings.joined_text_color
		local joined_text_color = Color(joined_text_c[1], joined_text_c[2], joined_text_c[3], joined_text_c[4])

		ScriptGUI.text(gui, L("menu_assigned"), font, layout_settings.joined_font_size, font_material, Vector3(math.floor(joined_texture_x + layout_settings.joined_text_offset_x), math.floor(joined_texture_y + layout_settings.joined_text_offset_y), self._z + 1), joined_text_color)
	end
end

function SquadTextMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "squad_text",
		page = config.page,
		disabled = config.disabled,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		visible_func = config.visible_func and callback(callback_object, config.visible_func, config.visible_func_args),
		text = config.no_localization and config.text or L(config.text),
		tooltip_text = config.tooltip_text,
		layout_settings = config.layout_settings
	}

	return SquadTextMenuItem:new(config, compiler_data.world)
end
