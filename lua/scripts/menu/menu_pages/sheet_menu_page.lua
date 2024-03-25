-- chunkname: @scripts/menu/menu_pages/sheet_menu_page.lua

require("scripts/menu/menu_containers/item_list_menu_container")
require("scripts/menu/menu_containers/texture_menu_container")
require("scripts/menu/menu_containers/rect_menu_container")
require("scripts/menu/menu_containers/text_box_menu_container")

SheetMenuPage = class(SheetMenuPage, MenuPage)

function SheetMenuPage:init(config, item_groups, world)
	SheetMenuPage.super.init(self, config, item_groups, world)

	self._world = world

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_rect = RectMenuContainer.create_from_config()
	self._corner_texture_top_left = TextureMenuContainer.create_from_config()
	self._corner_texture_top_right = TextureMenuContainer.create_from_config()
	self._corner_texture_bottom_left = TextureMenuContainer.create_from_config()
	self._corner_texture_bottom_right = TextureMenuContainer.create_from_config()
	self._horizontal_line_texture_top = TextureMenuContainer.create_from_config()
	self._horizontal_line_texture_bottom = TextureMenuContainer.create_from_config()
end

function SheetMenuPage:update(dt, t)
	SheetMenuPage.super.update(self, dt, t)
	self:_update_container_size(dt, t)
	self:_update_container_position(dt, t)
end

function SheetMenuPage:_update_container_size(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_rect:update_size(dt, t, self._gui, layout_settings.background_rect)
	self._corner_texture_top_left:update_size(dt, t, self._gui, layout_settings.corner_texture_top_left)
	self._corner_texture_top_right:update_size(dt, t, self._gui, layout_settings.corner_texture_top_right)
	self._corner_texture_bottom_left:update_size(dt, t, self._gui, layout_settings.corner_texture_bottom_left)
	self._corner_texture_bottom_right:update_size(dt, t, self._gui, layout_settings.corner_texture_bottom_right)
	self._horizontal_line_texture_top:update_size(dt, t, self._gui, layout_settings.horizontal_line_texture_top)
	self._horizontal_line_texture_bottom:update_size(dt, t, self._gui, layout_settings.horizontal_line_texture_bottom)
end

function SheetMenuPage:_update_container_position(dt, t)
	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)
	local x, y = MenuHelper:container_position(self._background_rect, layout_settings.background_rect)

	self._background_rect:update_position(dt, t, layout_settings.background_rect, x, y, self.config.z)

	local x, y = MenuHelper:container_position(self._corner_texture_top_left, layout_settings.corner_texture_top_left)

	self._corner_texture_top_left:update_position(dt, t, layout_settings.corner_texture_top_left, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._corner_texture_top_right, layout_settings.corner_texture_top_right)

	self._corner_texture_top_right:update_position(dt, t, layout_settings.corner_texture_top_right, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._corner_texture_bottom_left, layout_settings.corner_texture_bottom_left)

	self._corner_texture_bottom_left:update_position(dt, t, layout_settings.corner_texture_bottom_left, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._corner_texture_bottom_right, layout_settings.corner_texture_bottom_right)

	self._corner_texture_bottom_right:update_position(dt, t, layout_settings.corner_texture_bottom_right, x, y, self.config.z + 2)

	local x, y = MenuHelper:container_position(self._horizontal_line_texture_top, layout_settings.horizontal_line_texture_top)

	self._horizontal_line_texture_top:update_position(dt, t, layout_settings.horizontal_line_texture_top, x, y, self.config.z + 1)

	local x, y = MenuHelper:container_position(self._horizontal_line_texture_bottom, layout_settings.horizontal_line_texture_bottom)

	self._horizontal_line_texture_bottom:update_position(dt, t, layout_settings.horizontal_line_texture_bottom, x, y, self.config.z + 1)
end

function SheetMenuPage:render(dt, t)
	SheetMenuPage.super.render(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(self.config.layout_settings)

	self._background_rect:render(dt, t, self._gui, layout_settings.background_rect)
	self._corner_texture_top_left:render(dt, t, self._gui, layout_settings.corner_texture_top_left)
	self._corner_texture_top_right:render(dt, t, self._gui, layout_settings.corner_texture_top_right)
	self._corner_texture_bottom_left:render(dt, t, self._gui, layout_settings.corner_texture_bottom_left)
	self._corner_texture_bottom_right:render(dt, t, self._gui, layout_settings.corner_texture_bottom_right)
	self._horizontal_line_texture_top:render(dt, t, self._gui, layout_settings.horizontal_line_texture_top)
	self._horizontal_line_texture_bottom:render(dt, t, self._gui, layout_settings.horizontal_line_texture_bottom)
end
