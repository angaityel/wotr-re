-- chunkname: @scripts/menu/menu_items/outfit_text_menu_item.lua

require("scripts/menu/menu_items/text_menu_item")

OutfitTextMenuItem = class(OutfitTextMenuItem, TextMenuItem)

function OutfitTextMenuItem:init(config, world)
	OutfitTextMenuItem.super.init(self, config, world)
end

function OutfitTextMenuItem:on_select(ignore_sound)
	if self.config.no_editing then
		self.config.page = nil
	elseif self.config.avalible then
		self.config.page = self.config.default_page

		OutfitTextMenuItem.super.on_select(self, ignore_sound)
	elseif self.config.unavalible_reason == "locked_in_demo" then
		self.config.page = MenuHelper:create_locked_in_demo_popup_page(self._world, self.config.parent_page, self.config.parent_page.config.z, self.config.parent_page.config.sounds)
	elseif self.config.unavalible_reason == "required_perk" then
		self.config.page = MenuHelper:create_required_perk_popup_page(self._world, self.config.parent_page, self.config.ui_name, self.config.required_perk, self.config.parent_page.config.z, self.config.parent_page.config.sounds)
	elseif self.config.unavalible_reason == "rank_not_met" then
		self.config.page = MenuHelper:create_rank_not_met_popup_page(self._world, self.config.parent_page, self.config.unlock_type, self.config.unlock_key, self.config.ui_name, self.config.parent_page.config.z, self.config.parent_page.config.sounds)
	elseif self.config.unavalible_reason == "not_owned" then
		self.config.page = MenuHelper:create_purchase_market_item_popup_page(self._world, self.config.parent_page, self.config.entity_type, self.config.market_item_name, self.config.market_message_args, self.config.parent_page.config.z, self.config.parent_page.config.sounds)
	end
end

function OutfitTextMenuItem:update_disabled()
	if self.config.required_perk and not ProfileHelper:has_perk(self.config.required_perk, self.config.character_profile) then
		self.config.avalible = false
		self.config.unavalible_reason = "required_perk"
		self.config.disabled = false
	else
		self.config.avalible = true
		self.config.unavalible_reason = nil
		self.config.disabled = false
	end

	if not self.config.unlock_key then
		return
	end

	if GameSettingsDevelopment.unlock_all then
		self.config.avalible = true
		self.config.unavalible_reason = nil
		self.config.disabled = false
		self.config.page = self.config.default_page
	elseif not self.config.loading_profile then
		local avalible, unavalible_reason = ProfileHelper:is_entity_avalible(self.config.unlock_type, self.config.unlock_key, self.config.entity_type, self.config.entity_name, self.config.release_name)

		self.config.avalible = avalible
		self.config.unavalible_reason = unavalible_reason
		self.config.disabled = false
	else
		self.config.avalible = false
		self.config.unavalible_reason = nil
		self.config.disabled = true
		self.config.page = nil
	end
end

function OutfitTextMenuItem:render(dt, t, gui, layout_settings)
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
	else
		self.config.color = layout_settings.color
	end

	OutfitTextMenuItem.super.render(self, dt, t, gui, layout_settings)
end

function OutfitTextMenuItem:render_from_child_page(dt, t, gui, layout_settings)
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
	else
		self.config.color = layout_settings.color_render_from_child_page
	end

	OutfitTextMenuItem.super.render_from_child_page(self, dt, t, gui, layout_settings)
end

function OutfitTextMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "outfit_text",
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		callback_object = callback_object,
		no_editing = config.no_editing,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		on_highlight = config.on_highlight,
		on_highlight_args = config.on_highlight_args or {},
		on_enter_text = config.on_enter_text,
		on_enter_text_args = config.on_enter_text_args or {},
		toggle_selection = config.toggle_selection,
		text = config.no_localization and config.text or L(config.text),
		color = config.color,
		tooltip_text = config.tooltip_text,
		tooltip_text_2 = config.tooltip_text_2,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.text,
		release_name = config.release_name,
		default_page = config.default_page,
		unlock_type = config.unlock_type,
		unlock_key = config.unlock_key,
		entity_type = config.entity_type,
		entity_name = config.entity_name,
		market_item_name = config.market_item_name,
		market_message_args = config.market_message_args,
		ui_name = config.ui_name,
		loading_profile = config.loading_profile,
		required_perk = config.required_perk,
		character_profile = config.character_profile
	}

	return OutfitTextMenuItem:new(config, compiler_data.world)
end
