-- chunkname: @scripts/menu/menu_items/outfit_checkbox_menu_item.lua

require("scripts/menu/menu_items/checkbox_menu_item")

OutfitCheckboxMenuItem = class(OutfitCheckboxMenuItem, CheckboxMenuItem)

function OutfitCheckboxMenuItem:init(config, world)
	OutfitCheckboxMenuItem.super.init(self, config, world)
end

function OutfitCheckboxMenuItem:on_select(ignore_sound)
	if self.config.avalible then
		self.config.page = self.config.default_page

		OutfitCheckboxMenuItem.super.on_select(self, ignore_sound)
	elseif self.config.unavalible_reason == "rank_not_met" then
		self.config.page = MenuHelper:create_rank_not_met_popup_page(self._world, self.config.parent_page, self.config.unlock_type, self.config.unlock_key, self.config.ui_name, self.config.parent_page.config.z, self.config.parent_page.config.sounds)
	elseif self.config.unavalible_reason == "not_owned" then
		self.config.page = MenuHelper:create_purchase_market_item_popup_page(self._world, self.config.parent_page, self.config.entity_type, self.config.market_item_name, self.config.market_message_args, self.config.parent_page.config.z, self.config.parent_page.config.sounds)
	end
end

function OutfitCheckboxMenuItem:update_disabled()
	if GameSettingsDevelopment.unlock_all then
		self.config.avalible = true
		self.config.unavalible_reason = nil
		self.config.page = self.config.default_page
	else
		local avalible, unavalible_reason = ProfileHelper:is_entity_avalible(self.config.unlock_type, self.config.unlock_key, self.config.entity_type, self.config.entity_name, self.config.release_name)

		self.config.avalible = avalible
		self.config.unavalible_reason = unavalible_reason
	end
end

function OutfitCheckboxMenuItem:render(dt, t, gui, layout_settings)
	if not self.config.avalible then
		local texture, text, text_color = MenuHelper.outfit_menu_item_requirement_info(layout_settings, self.config)

		if texture then
			local texture_x, texture_y

			if layout_settings.texture_unavalible_align == "left" then
				texture_x = self._x + layout_settings.texture_unavalible_offset_x
				texture_y = self._y + layout_settings.texture_unavalible_offset_y
			elseif layout_settings.texture_unavalible_align == "right" then
				texture_x = self._x + self._width + layout_settings.texture_unavalible_offset_x
				texture_y = self._y + layout_settings.texture_unavalible_offset_y
			end

			Gui.bitmap(gui, texture, Vector3(math.floor(texture_x), math.floor(texture_y), self._z + 1), Vector2(math.floor(layout_settings.texture_unavalible_width), math.floor(layout_settings.texture_unavalible_height)))

			local font = layout_settings.requirement_font.font
			local font_material = layout_settings.requirement_font.material
			local font_size = layout_settings.requirement_font_size
			local color = Color(text_color[1], text_color[2], text_color[3], text_color[4])
			local shadow_color_table = layout_settings.drop_shadow_color
			local shadow_color = Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
			local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
			local text_x = texture_x + layout_settings.requirement_text_offset_x
			local text_y = self._y + layout_settings.requirement_text_offset_y

			ScriptGUI.text(gui, text, font, font_size, font_material, Vector3(math.floor(text_x), math.floor(text_y), self._z + 1), color, shadow_color, shadow_offset)
		end

		self.config.color = layout_settings.color_unavalible
	elseif self.config.disabled then
		self.config.color = layout_settings.color_unavalible
	else
		self.config.color = layout_settings.color
	end

	OutfitCheckboxMenuItem.super.render(self, dt, t, gui, layout_settings)
end

function OutfitCheckboxMenuItem:render_from_child_page(dt, t, gui, layout_settings)
	if not self.config.avalible then
		local texture, text, text_color = MenuHelper.outfit_menu_item_requirement_info(layout_settings, self.config)

		if texture then
			local texture_x, texture_y

			if layout_settings.texture_unavalible_align == "left" then
				texture_x = self._x + layout_settings.texture_unavalible_offset_x
				texture_y = self._y + layout_settings.texture_unavalible_offset_y
			elseif layout_settings.texture_unavalible_align == "right" then
				texture_x = self._x + self._width + layout_settings.texture_unavalible_offset_x
				texture_y = self._y + layout_settings.texture_unavalible_offset_y
			end

			Gui.bitmap(gui, texture, Vector3(math.floor(texture_x), math.floor(texture_y), self._z + 1), Vector2(math.floor(layout_settings.texture_unavalible_width), math.floor(layout_settings.texture_unavalible_height)))

			local font = layout_settings.requirement_font.font
			local font_material = layout_settings.requirement_font.material
			local font_size = layout_settings.requirement_font_size
			local color = Color(text_color[1], text_color[2], text_color[3], text_color[4])
			local shadow_color_table = layout_settings.drop_shadow_color
			local shadow_color = Color(shadow_color_table[1], shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
			local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
			local text_x = texture_x + layout_settings.requirement_text_offset_x
			local text_y = self._y + layout_settings.requirement_text_offset_y

			ScriptGUI.text(gui, text, font, font_size, font_material, Vector3(math.floor(text_x), math.floor(text_y), self._z + 1), color, shadow_color, shadow_offset)
		end

		self.config.color = layout_settings.color_render_from_child_page
	elseif self.config.disabled then
		self.config.color = layout_settings.color_render_from_child_page
	else
		self.config.color = layout_settings.color_render_from_child_page
	end

	OutfitCheckboxMenuItem.super.render_from_child_page(self, dt, t, gui, layout_settings)
end

function OutfitCheckboxMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		toggle_selection = true,
		type = "outfit_checkbox",
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func),
		callback_object = callback_object,
		on_enter_select = config.on_enter_select,
		on_enter_select_args = config.on_enter_select_args,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		text = config.no_localization and config.text or L(config.text),
		tooltip_text = config.tooltip_text,
		tooltip_text_2 = config.tooltip_text_2,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.checkbox,
		default_page = config.default_page,
		unlock_type = config.unlock_type,
		unlock_key = config.unlock_key,
		entity_type = config.entity_type,
		entity_name = config.entity_name,
		release_name = config.release_name,
		market_item_name = config.market_item_name,
		market_message_args = config.market_message_args,
		ui_name = config.ui_name
	}

	return OutfitCheckboxMenuItem:new(config, compiler_data.world)
end
