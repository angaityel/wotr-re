-- chunkname: @scripts/menu/menu_pages/standard_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")

StandardMenuPage = class(StandardMenuPage, MenuPage)

function StandardMenuPage:init(config, item_groups, world)
	StandardMenuPage.super.init(self, config, item_groups, world)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if layout_settings.background_rect then
		self._background_rect = RectMenuContainer.create_from_config()
	end

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

	if layout_settings.item_list then
		self._item_list = ItemListMenuContainer.create_from_config(item_groups.item_list)
	end

	if layout_settings.back_list and item_groups.back_list then
		self._back_list = ItemListMenuContainer.create_from_config(item_groups.back_list)
	end

	if layout_settings.tooltip_text_box then
		self._tooltip_text_box = TextBoxMenuContainer.create_from_config()
	end

	if layout_settings.header and config.header_text then
		self._header_text = TextMenuContainer.create_from_config(config.header_text)
	end

	if layout_settings.logo_texture then
		self._logo_texture = TextureMenuContainer.create_from_config()
	end

	if layout_settings.overlay_texture then
		self._overlay_texture = FrameTextureMenuContainer.create_from_config()
	end
end

function StandardMenuPage:on_enter()
	StandardMenuPage.super.on_enter(self)
	self:_try_callback(self.config.callback_object, self.config.on_enter_page)
end

function StandardMenuPage:on_exit()
	StandardMenuPage.super.on_exit(self)
	self:_try_callback(self.config.callback_object, self.config.on_exit_page)
end

function StandardMenuPage:_highlight_item(index, ignore_sound)
	local highlighted_item = self:_highlighted_item()

	StandardMenuPage.super._highlight_item(self, index, ignore_sound)

	if self._tooltip_text_box and self:_highlighted_item() ~= highlighted_item then
		local tooltip_text = self:_highlighted_item() and self:_highlighted_item().config.tooltip_text

		if tooltip_text then
			local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

			self._tooltip_text_box:set_text(L(tooltip_text), layout_settings.tooltip_text_box, self._gui)
		else
			self._tooltip_text_box:clear_text()
		end
	end
end

function StandardMenuPage:cb_return_to_main()
	self._menu_logic:change_page(self:parent_page())
end

function StandardMenuPage:update(dt, t)
	StandardMenuPage.super.update(self, dt, t)
	self:_update_container_size(dt, t)
	self:_update_container_position(dt, t)
end

function StandardMenuPage:_update_container_size(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if self._background_rect then
		self._background_rect:update_size(dt, t, self._gui, layout_settings.background_rect)
	end

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

	if self._item_list then
		self._item_list:update_size(dt, t, self._gui, layout_settings.item_list)
	end

	if self._back_list then
		self._back_list:update_size(dt, t, self._gui, layout_settings.back_list)
	end

	if self._tooltip_text_box then
		self._tooltip_text_box:update_size(dt, t, self._gui, layout_settings.tooltip_text_box)
	end

	if self._header_text then
		self._header_text:update_size(dt, t, self._gui, layout_settings.header)
	end

	if self._logo_texture then
		self._logo_texture:update_size(dt, t, self._gui, layout_settings.logo_texture)
	end

	if self._overlay_texture then
		self._overlay_texture:update_size(dt, t, self._gui, layout_settings.overlay_texture)
	end
end

function StandardMenuPage:_update_container_position(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if self._background_rect then
		local x, y = MenuHelper:container_position(self._background_rect, layout_settings.background_rect)

		self._background_rect:update_position(dt, t, layout_settings.background_rect, x, y, self.config.z + 5)
	end

	if self._gradient_texture then
		local x, y = MenuHelper:container_position(self._gradient_texture, layout_settings.gradient_texture)

		self._gradient_texture:update_position(dt, t, layout_settings.gradient_texture, x, y, self.config.z + 10)
	end

	if self._vertical_line_texture then
		local x, y = MenuHelper:container_position(self._vertical_line_texture, layout_settings.vertical_line_texture)

		self._vertical_line_texture:update_position(dt, t, layout_settings.vertical_line_texture, x, y, self.config.z + 15)
	end

	if self._corner_top_texture then
		local x, y = MenuHelper:container_position(self._corner_top_texture, layout_settings.corner_top_texture)

		self._corner_top_texture:update_position(dt, t, layout_settings.corner_top_texture, x, y, self.config.z + 15)
	end

	if self._corner_bottom_texture then
		local x, y = MenuHelper:container_position(self._corner_bottom_texture, layout_settings.corner_bottom_texture)

		self._corner_bottom_texture:update_position(dt, t, layout_settings.corner_bottom_texture, x, y, self.config.z + 15)
	end

	if self._item_list then
		local x, y = MenuHelper:container_position(self._item_list, layout_settings.item_list)

		self._item_list:update_position(dt, t, layout_settings.item_list, x, y, self.config.z + 15)
	end

	if self._back_list then
		local x, y = MenuHelper:container_position(self._back_list, layout_settings.back_list)

		self._back_list:update_position(dt, t, layout_settings.back_list, x, y, self.config.z + 15)
	end

	if self._tooltip_text_box then
		local x, y = MenuHelper:container_position(self._tooltip_text_box, layout_settings.tooltip_text_box)

		self._tooltip_text_box:update_position(dt, t, layout_settings.tooltip_text_box, x, y, self.config.z + 15)
	end

	if self._header_text then
		local x, y = MenuHelper:container_position(self._header_text, layout_settings.header)

		self._header_text:update_position(dt, t, layout_settings.header, x, y, self.config.z + 15)
	end

	if self._logo_texture then
		local x, y = MenuHelper:container_position(self._logo_texture, layout_settings.logo_texture)

		self._logo_texture:update_position(dt, t, layout_settings.logo_texture, x, y, self.config.z + 15)
	end

	if self._overlay_texture then
		local x, y = MenuHelper:container_position(self._overlay_texture, layout_settings.overlay_texture)

		self._overlay_texture:update_position(dt, t, layout_settings.overlay_texture, x, y, self.config.z + 40)
	end
end

function StandardMenuPage:render(dt, t)
	StandardMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	if self._background_rect then
		self._background_rect:render(dt, t, self._gui, layout_settings.background_rect)
	end

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

	if self._item_list then
		self._item_list:render(dt, t, self._gui, layout_settings.item_list)
	end

	if self._back_list then
		self._back_list:render(dt, t, self._gui, layout_settings.back_list)
	end

	if self._tooltip_text_box then
		self._tooltip_text_box:render(dt, t, self._gui, layout_settings.tooltip_text_box)
	end

	if self._header_text then
		self._header_text:render(dt, t, self._gui, layout_settings.header)
	end

	if self._logo_texture then
		self._logo_texture:render(dt, t, self._gui, layout_settings.logo_texture)
	end

	if self._overlay_texture then
		self._overlay_texture:render(dt, t, self._gui, layout_settings.overlay_texture)
	end
end

function StandardMenuPage.create_from_config(compiler_data, page_config, parent_page, item_groups, callback_object)
	local config = {
		type = "standard",
		parent_page = parent_page,
		callback_object = callback_object,
		on_enter_page = page_config.on_enter_page,
		on_exit_page = page_config.on_exit_page,
		header_text = page_config.header_text,
		z = page_config.z,
		layout_settings = page_config.layout_settings,
		sounds = page_config.sounds,
		environment = page_config.environment or parent_page and parent_page:environment()
	}

	return StandardMenuPage:new(config, item_groups, compiler_data.world)
end
