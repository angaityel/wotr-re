-- chunkname: @scripts/menu/menu_items/key_mapping_menu_item.lua

KeyMappingMenuItem = class(KeyMappingMenuItem, MenuItem)

function KeyMappingMenuItem:init(config, world)
	KeyMappingMenuItem.super.init(self, config, world)
	self.config.page:set_key_item(self)
end

function KeyMappingMenuItem:on_select(ignore_sound)
	KeyMappingMenuItem.super.on_select(self, ignore_sound)

	self._selected = true
end

function KeyMappingMenuItem:on_deselect()
	self._selected = false
end

function KeyMappingMenuItem:set_identical_keybinding(state)
	self._identical_binding = state
end

function KeyMappingMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	self:render(dt, t, gui, layout_settings)
end

local function get_key_locale_name(key, config)
	local controller = Managers.input:get_controller(key.controller_type)
	local key_index = controller.button_index(key.key)
	local key_locale_name

	if key.controller_type == "pad" then
		local key_name = L("pad360_" .. key.key)

		if config.prefix then
			local dirty_key_name = DirtyPlayerControllerSettings.shift_function and DirtyPlayerControllerSettings.shift_function.key
			local shift_key_name = dirty_key_name or ActivePlayerControllerSettings.pad360.shift_function.key
			local prefix = L("pad360_" .. shift_key_name)

			key_locale_name = string.format("%s + %s", prefix, key_name)
		elseif config.static_prefix then
			local prefix = L("pad360_" .. config.static_prefix)

			key_locale_name = string.format("%s + %s", prefix, key_name)
		else
			key_locale_name = string.format("%s", key_name)
		end
	elseif key.controller_type == "mouse" then
		key_locale_name = string.format("%s %s", "mouse", key.key)
	else
		key_locale_name = controller.button_locale_name(key_index)
	end

	return key_locale_name
end

function KeyMappingMenuItem:update_size(dt, t, gui, layout_settings)
	local config = self.config
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local min_com, max_com = Gui.text_extents(gui, config.text, font, layout_settings.font_size)
	local key = DirtyPlayerControllerSettings[config.key_name]

	if not key then
		if Managers.input:active_mapping(1) == "keyboard_mouse" then
			key = ActivePlayerControllerSettings.keyboard_mouse[config.key_name]
		elseif Managers.input:pad_active(1) then
			key = ActivePlayerControllerSettings.pad360[config.key_name]
		end
	end

	local key_locale_name = get_key_locale_name(key, config)
	local min_key, max_key = Gui.text_extents(gui, key_locale_name, font, layout_settings.font_size)

	self._width = layout_settings.key_name_align + (max_key[1] - min_key[1]) + layout_settings.padding_left
	self._height = max_com[3] - min_com[3] + layout_settings.padding_top + layout_settings.padding_bottom
	self._min_x = min_key[1]
end

function KeyMappingMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1
end

function KeyMappingMenuItem:render(dt, t, gui, layout_settings)
	self:_render(dt, t, gui, layout_settings, false)
end

function KeyMappingMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	self:_render(dt, t, gui, layout_settings, true)
end

function KeyMappingMenuItem:_render(dt, t, gui, layout_settings, rendered_from_child_page)
	local config = self.config
	local shadow_color_table = layout_settings.drop_shadow_color
	local shadow_color = (self._highlighted or not rendered_from_child_page) and Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	local pos_text = Vector3(math.floor(self._x + layout_settings.padding_left - self._min_x), math.floor(self._y + layout_settings.padding_bottom), self._z + 1)
	local c = self._highlighted and layout_settings.color_highlighted or rendered_from_child_page and layout_settings.color_render_from_child_page or layout_settings.color
	local color = Color(c[1], c[2], c[3], c[4])
	local same_binding_color

	if self._identical_binding then
		same_binding_color = Color(255, 100, 150, 255)
	end

	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material

	ScriptGUI.text(gui, config.text, font, layout_settings.font_size, font_material, pos_text, same_binding_color or color, shadow_color, shadow_offset)

	local pos_key = pos_text + Vector3(layout_settings.key_name_align, 0, 0)
	local key
	local size = layout_settings.font_size

	if Managers.input:active_mapping(1) == "keyboard_mouse" then
		key = DirtyPlayerControllerSettings[config.key_name] or ActivePlayerControllerSettings.keyboard_mouse[config.key_name]
	elseif Managers.input:pad_active(1) then
		key = DirtyPlayerControllerSettings[config.key_name] or ActivePlayerControllerSettings.pad360[config.key_name]
		size = layout_settings.pad_font_size
		font_material = layout_settings.pad_font.material
		font = layout_settings.pad_font.font
	end

	local key_locale_name = get_key_locale_name(key, config)

	if self._highlighted and rendered_from_child_page then
		local a = 100 * math.cos(t * 8) + 155

		color = Color(a, c[2], c[3], c[4])
		shadow_color = Color(a, shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	end

	ScriptGUI.text(gui, key_locale_name, font, size, font_material, pos_key, color, shadow_color, shadow_offset)

	if self._highlighted and not rendered_from_child_page then
		local texture_x = self._x
		local texture_y = self._y + layout_settings.texture_offset_y

		Gui.bitmap(gui, layout_settings.texture_highlighted, Vector3(math.floor(texture_x), math.floor(texture_y), self._z), Vector2(layout_settings.texture_highlighted_width, layout_settings.texture_highlighted_height))
	end
end

function KeyMappingMenuItem:key_name()
	return self.config.key_name
end

function KeyMappingMenuItem:keys()
	return self.config.keys
end

function KeyMappingMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "key_mapping",
		page = config.page,
		disabled = config.disabled,
		remove_func = config.remove_func and callback(callback_object, config.remove_func),
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func),
		prefix = config.prefix,
		static_prefix = config.static_prefix,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		text = L(config.text),
		key_name = config.keys[1],
		keys = config.keys,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.key_mapping
	}

	return KeyMappingMenuItem:new(config, compiler_data.world)
end
