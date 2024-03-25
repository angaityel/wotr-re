-- chunkname: @scripts/menu/menu_pages/main_menu_page.lua

require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/frame_texture_menu_container")

MainMenuPage = class(MainMenuPage, MenuPage)

function MainMenuPage:init(config, item_groups, world)
	MainMenuPage.super.init(self, config, item_groups, world)

	self._world = world

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if layout_settings.gradient_texture then
		self._gradient_texture = TextureMenuContainer.create_from_config()
	end

	if layout_settings.vertical_line_texture then
		self._vertical_line_texture = TextureMenuContainer.create_from_config()
	end

	if layout_settings.corner_top_texture then
		self._corner_top_texture = TextureMenuContainer.create_from_config()
	end

	if layout_settings.corner_bottom_texture then
		self._corner_bottom_texture = TextureMenuContainer.create_from_config()
	end

	if layout_settings.logo_texture then
		self._logo_texture = TextureMenuContainer.create_from_config()
	end

	if layout_settings.tooltip_text_box then
		self._tooltip_text_box = TextBoxMenuContainer.create_from_config()
	end

	if layout_settings.tooltip_text_box_2 then
		self._tooltip_text_box_2 = TextBoxMenuContainer.create_from_config()
	end

	if layout_settings.overlay_texture then
		self._overlay_texture = FrameTextureMenuContainer.create_from_config()
	end

	if layout_settings.back_list and item_groups.back_list then
		self._back_list = ItemListMenuContainer.create_from_config(item_groups.back_list)
	end

	if layout_settings.page_links and item_groups.page_links then
		self._page_links = ItemListMenuContainer.create_from_config(item_groups.page_links)
	end

	if layout_settings.center_items and item_groups.center_items then
		self._center_items_container = ItemListMenuContainer.create_from_config(item_groups.center_items)
	end

	if not IS_DEMO and GameSettingsDevelopment.enable_micro_transactions and self.config.type == "outfit_editor" then
		self:_setup_buy_gold()
	end

	self:_setup_demo_page()
end

function MainMenuPage:_on_left_click(change_page_delay, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	if not highlighted_item then
		return
	end

	if highlighted_item:disabled() and IS_DEMO then
		if highlighted_item.on_left_click then
			highlighted_item:on_left_click(ignore_sound)
		end

		local demo_page = highlighted_item.demo_page and highlighted_item:demo_page() or self._demo_page

		if demo_page then
			self._menu_logic:change_page(demo_page, change_page_delay)
		end
	elseif highlighted_item.on_left_click then
		highlighted_item:on_left_click(ignore_sound)

		local child_page = highlighted_item:page()

		if child_page then
			self._menu_logic:change_page(child_page, change_page_delay)
		end
	else
		self:_select_item(change_page_delay, ignore_sound)
	end
end

function MainMenuPage:_setup_demo_page()
	self._demo_page = MenuHelper:create_locked_in_demo_popup_page(self._world, self, self.config.z, self.config.sounds)
end

function MainMenuPage:_setup_buy_gold()
	self._popup_page = MenuHelper:create_buy_gold_popup_page(self._world, self, self, "cb_buy_gold_popup_enter", "cb_buy_gold_popup_item_selected", self.config.z + 50, self.config.sounds)
end

function MainMenuPage:cb_disable_single_player()
	if IS_DEMO or GameSettingsDevelopment.disable_singleplayer then
		return true
	end
end

function MainMenuPage:cb_disable_coat_of_arms()
	if IS_DEMO or GameSettingsDevelopment.disable_coat_of_arms_editor then
		return true
	end
end

function MainMenuPage:cb_buy_gold_popup_enter(args)
	self:enable_buy_gold_popup_buttons(true)
	self._popup_page:find_item_by_name("text_message"):set_text(L("buy_gold_select_amount"))
end

function MainMenuPage:cb_buy_gold_popup_item_selected(args)
	local item_id = args.action
	local quantity = 1

	if item_id then
		Managers.persistence:purchase_store_item(item_id, quantity, callback(self, "cb_gold_purchase_done"))
		self:enable_buy_gold_popup_buttons(false)
		self._popup_page:find_item_by_name("text_message"):set_text(L("buy_gold_contacting_steam_store"))
	end
end

function MainMenuPage:cb_gold_purchase_done(success, data)
	if data ~= "cancelled" then
		if success then
			self._popup_page:find_item_by_name("text_message"):set_text(L("buy_gold_success"))

			if MenuSettings.sounds.buy_gold_success then
				local timpani_world = World.timpani_world(self._world)

				TimpaniWorld.trigger_event(timpani_world, MenuSettings.sounds.buy_gold_success)
				Managers.persistence:reload_profile_attributes(callback(self, "cb_profile_gold_reloaded"))
			end
		else
			self._popup_page:find_item_by_name("text_message"):set_text(L("buy_gold_fail"))
		end
	else
		self._popup_page:find_item_by_name("text_message"):set_text(L("buy_gold_select_amount"))
	end

	self:enable_buy_gold_popup_buttons(true)
end

function MainMenuPage:enable_buy_gold_popup_buttons(enabled)
	for _, item in ipairs(self._popup_page:items_in_group("button_list")) do
		item.config.disabled = not enabled
	end
end

function MainMenuPage:cb_profile_gold_reloaded(success)
	Managers.state.event:trigger("profile_gold_reloaded")
end

function MainMenuPage:cb_wants_buy_gold()
	if self._popup_page then
		self._menu_logic:change_page(self._popup_page)
	end
end

function MainMenuPage:on_enter()
	MainMenuPage.super.on_enter(self)
	self:_try_callback(self.config.callback_object, self.config.on_enter_page)
end

function MainMenuPage:on_exit(on_cancel)
	MainMenuPage.super.on_exit(self, on_cancel)

	if self._tooltip_text_box then
		self._tooltip_text_box:clear_text()
	end

	if self._tooltip_text_box_2 then
		self._tooltip_text_box_2:clear_text()
	end

	self:_try_callback(self.config.callback_object, self.config.on_exit_page)
end

function MainMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	MainMenuPage.super._highlight_item(self, index, ignore_sound)

	if self._tooltip_text_box then
		if self.config.static_tooltip_callback then
			local text = self[self.config.static_tooltip_callback]()
			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._tooltip_text_box:set_text(text, layout_settings.tooltip_text_box, self._gui)
		elseif self:_highlighted_item() ~= highlighted_item then
			local tooltip_text = self:_highlighted_item() and self:_highlighted_item().config.tooltip_text

			if tooltip_text then
				local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

				self._tooltip_text_box:set_text(L(tooltip_text), layout_settings.tooltip_text_box, self._gui)
			else
				self._tooltip_text_box:clear_text()
			end
		end
	end

	if self._tooltip_text_box_2 and self:_highlighted_item() ~= highlighted_item then
		local tooltip_text = self:_highlighted_item() and self:_highlighted_item().config.tooltip_text_2

		if tooltip_text then
			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._tooltip_text_box_2:set_text(L(tooltip_text), layout_settings.tooltip_text_box_2, self._gui)
		else
			self._tooltip_text_box_2:clear_text()
		end
	end
end

function MainMenuPage:cb_return_to_main()
	self._menu_logic:change_page(self:parent_page())
end

function MainMenuPage:cb_buy_game(args)
	if args == "confirm" or args.action == "confirm" then
		MainMenuPage.super.cb_buy_game(self, args)
		self:cb_return_to_main()
	end
end

function MainMenuPage:update(dt, t)
	MainMenuPage.super.update(self, dt, t)
	self:_update_container_size(dt, t)
	self:_update_container_position(dt, t)
end

function MainMenuPage:_update_container_size(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if self._gradient_texture then
		self._gradient_texture:update_size(dt, t, self._gui, layout_settings.gradient_texture)
	end

	if self._vertical_line_texture then
		self._vertical_line_texture:update_size(dt, t, self._gui, layout_settings.vertical_line_texture)
	end

	if self._corner_top_texture then
		self._corner_top_texture:update_size(dt, t, self._gui, layout_settings.corner_top_texture)
	end

	if self._corner_bottom_texture then
		self._corner_bottom_texture:update_size(dt, t, self._gui, layout_settings.corner_bottom_texture)
	end

	if self._logo_texture then
		self._logo_texture:update_size(dt, t, self._gui, layout_settings.logo_texture)
	end

	if self._tooltip_text_box then
		self._tooltip_text_box:update_size(dt, t, self._gui, layout_settings.tooltip_text_box)
	end

	if self._tooltip_text_box_2 then
		self._tooltip_text_box_2:update_size(dt, t, self._gui, layout_settings.tooltip_text_box_2)
	end

	if self._back_list then
		self._back_list:update_size(dt, t, self._gui, layout_settings.back_list)
	end

	if self._page_links then
		self._page_links:update_size(dt, t, self._gui, layout_settings.page_links)
	end

	if self._overlay_texture then
		self._overlay_texture:update_size(dt, t, self._gui, layout_settings.overlay_texture)
	end

	if self._center_items_container then
		self._center_items_container:update_size(dt, t, self._gui, layout_settings.center_items)
	end

	if self._buy_gold_list then
		self._buy_gold_list:update_size(dt, t, self._gui, layout_settings.buy_gold_list)
	end
end

function MainMenuPage:_update_container_position(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if self._gradient_texture then
		local x, y = MenuHelper:container_position(self._gradient_texture, layout_settings.gradient_texture)

		self._gradient_texture:update_position(dt, t, layout_settings.gradient_texture, x, y, self.config.z + 5)
	end

	if self._vertical_line_texture then
		local x, y = MenuHelper:container_position(self._vertical_line_texture, layout_settings.vertical_line_texture)

		self._vertical_line_texture:update_position(dt, t, layout_settings.vertical_line_texture, x, y, self.config.z + 10)
	end

	if self._corner_top_texture then
		local x, y = MenuHelper:container_position(self._corner_top_texture, layout_settings.corner_top_texture)

		self._corner_top_texture:update_position(dt, t, layout_settings.corner_top_texture, x, y, self.config.z + 10)
	end

	if self._corner_bottom_texture then
		local x, y = MenuHelper:container_position(self._corner_bottom_texture, layout_settings.corner_bottom_texture)

		self._corner_bottom_texture:update_position(dt, t, layout_settings.corner_bottom_texture, x, y, self.config.z + 10)
	end

	if self._logo_texture then
		local x, y = MenuHelper:container_position(self._logo_texture, layout_settings.logo_texture)

		self._logo_texture:update_position(dt, t, layout_settings.logo_texture, x, y, self.config.z + 10)
	end

	if self._tooltip_text_box then
		local x, y = MenuHelper:container_position(self._tooltip_text_box, layout_settings.tooltip_text_box)

		self._tooltip_text_box:update_position(dt, t, layout_settings.tooltip_text_box, x, y, self.config.z + 15)
	end

	if self._tooltip_text_box_2 then
		local x, y = MenuHelper:container_position(self._tooltip_text_box_2, layout_settings.tooltip_text_box_2)

		self._tooltip_text_box_2:update_position(dt, t, layout_settings.tooltip_text_box_2, x, y, self.config.z + 15)
	end

	if self._back_list then
		local x, y = MenuHelper:container_position(self._back_list, layout_settings.back_list)

		self._back_list:update_position(dt, t, layout_settings.back_list, x, y, self.config.z + 15)
	end

	if self._page_links then
		local x, y = MenuHelper:container_position(self._page_links, layout_settings.page_links)

		self._page_links:update_position(dt, t, layout_settings.page_links, x, y, self.config.z + 15)
	end

	if self._overlay_texture then
		local x, y = MenuHelper:container_position(self._overlay_texture, layout_settings.overlay_texture)

		self._overlay_texture:update_position(dt, t, layout_settings.overlay_texture, x, y, self.config.z + 40)
	end

	if self._center_items_container then
		local x, y = MenuHelper:container_position(self._center_items_container, layout_settings.center_items)

		self._center_items_container:update_position(dt, t, layout_settings.center_items, x, y, self.config.z + 15)
	end

	if self._buy_gold_list then
		local x, y = MenuHelper:container_position(self._buy_gold_list, layout_settings.buy_gold_list)

		self._buy_gold_list:update_position(dt, t, layout_settings.buy_gold_list, x, y, self.config.z + 15)
	end
end

function MainMenuPage:render(dt, t)
	MainMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local pad_active = Managers.input:pad_active(1)

	if self._gradient_texture then
		self._gradient_texture:render(dt, t, self._gui, layout_settings.gradient_texture)
	end

	if self._vertical_line_texture then
		self._vertical_line_texture:render(dt, t, self._gui, layout_settings.vertical_line_texture)
	end

	if self._corner_top_texture then
		self._corner_top_texture:render(dt, t, self._gui, layout_settings.corner_top_texture)
	end

	if self._corner_bottom_texture then
		self._corner_bottom_texture:render(dt, t, self._gui, layout_settings.corner_bottom_texture)
	end

	if self._logo_texture then
		self._logo_texture:render(dt, t, self._gui, layout_settings.logo_texture)
	end

	if self._tooltip_text_box then
		self._tooltip_text_box:render(dt, t, self._gui, layout_settings.tooltip_text_box)
	end

	if self._tooltip_text_box_2 then
		self._tooltip_text_box_2:render(dt, t, self._gui, layout_settings.tooltip_text_box_2)
	end

	if self._back_list and not pad_active then
		self._back_list:render(dt, t, self._gui, layout_settings.back_list)
	end

	if self._page_links and not pad_active then
		self._page_links:render(dt, t, self._gui, layout_settings.page_links)
	end

	if self._overlay_texture then
		self._overlay_texture:render(dt, t, self._gui, layout_settings.overlay_texture)
	end

	if self._center_items_container then
		self._center_items_container:render(dt, t, self._gui, layout_settings.center_items)
	end

	if self._buy_gold_list then
		self._buy_gold_list:render(dt, t, self._gui, layout_settings.buy_gold_list)
	end

	if self.config.show_revision and not GameSettingsDevelopment.show_version_info then
		local settings = MenuSettings.revision
		local res_width, _ = Gui.resolution()
		local gui = self._gui
		local revision = script_data.settings.content_revision or "???"
		local build = script_data.build_identifier or "???"
		local text = "Revision: " .. revision .. "/" .. build
		local min, max = Gui.text_extents(gui, text, settings.font, settings.font_size)
		local text_width = max[1] - min[1]
		local position = Vector3(res_width - text_width + settings.position.x, settings.position.y, settings.position.z)
		local color = Color(settings.color[1], settings.color[2], settings.color[3], settings.color[4])
		local shadow_color = Color(settings.shadow_color[1], settings.shadow_color[2], settings.shadow_color[3], settings.shadow_color[4])
		local shadow_offset = Vector2(settings.shadow_offset[1], settings.shadow_offset[2])

		ScriptGUI.text(gui, text, settings.font, settings.font_size, settings.material, position, color, shadow_color, shadow_offset)
	end
end

function MainMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = page_config.type,
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return MainMenuPage:new(config, item_groups, compiler_data.world)
end
