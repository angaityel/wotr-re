-- chunkname: @scripts/menu/menu_items/menu_item.lua

require("scripts/menu/menu_containers/floating_tooltip_menu_container")

MenuItem = class(MenuItem)

function MenuItem:init(config, world)
	self.config = config
	self._world = world
	self._highlighted = false
	self._width = 0
	self._height = 0
	self._x = 0
	self._y = 0
	self._mouse_x = nil
	self._mouse_y = nil
	self._mouse_area_x = nil
	self._mouse_area_y = nil
	self._mouse_area_width = nil
	self._mouse_area_height = nil

	if config.visible == nil then
		config.visible = true
	end

	if config.removed == nil then
		config.removed = false
	end

	if self.config.page then
		self.config.page:set_parent_item(self)
	end

	if self.config.floating_tooltip then
		self._floating_tooltip = FloatingTooltipMenuContainer.create_from_config(self.config.floating_tooltip.header, self.config.floating_tooltip.text, self)
	end
end

function MenuItem:set_mouse_position(x, y)
	self._mouse_x = x
	self._mouse_y = y
end

function MenuItem:on_highlight(ignore_sound)
	self._highlighted = true

	if self.config.on_highlight then
		self:_try_callback(self.config.callback_object, self.config.on_highlight, unpack(self.config.on_highlight_args or {}))
	end

	if not ignore_sound and self.config.sounds.hover then
		local timpani_world = World.timpani_world(self._world)

		TimpaniWorld.trigger_event(timpani_world, self.config.sounds.hover)
	end
end

function MenuItem:on_lowlight()
	self._highlighted = false
end

function MenuItem:on_select(ignore_sound)
	self:_try_callback(self.config.callback_object, self.config.on_select, unpack(self.config.on_select_args or {}))

	if not ignore_sound and self.config.sounds.select then
		local timpani_world = World.timpani_world(self._world)

		TimpaniWorld.trigger_event(timpani_world, self.config.sounds.select)
	end
end

function MenuItem:on_select_down(mouse_pos)
	return
end

function MenuItem:set_callback_name(event_name, function_name)
	self.config[event_name] = function_name
end

function MenuItem:on_page_enter(on_cancel)
	return
end

function MenuItem:on_page_exit(on_cancel)
	return
end

function MenuItem:disabled()
	return self.config.disabled
end

function MenuItem:update_disabled()
	if self.config.disabled_func then
		self.config.disabled = self.config.disabled_func()
	end
end

function MenuItem:visible()
	return self.config.visible
end

function MenuItem:update_visible()
	if self.config.visible_func then
		self.config.visible = self.config.visible_func()
	end
end

function MenuItem:visible_in_demo()
	return false
end

function MenuItem:removed()
	return self.config.removed
end

function MenuItem:update_remove()
	if self.config.remove_func then
		self.config.removed = self.config.remove_func()
	end
end

function MenuItem:set_hidden(hidden)
	self.config.hidden = hidden
end

function MenuItem:set_column(column)
	self.config.column = column
end

function MenuItem:set_page(page)
	self.config.page = page
end

function MenuItem:page()
	return self.config.page
end

function MenuItem:is_mouse_inside(mouse_x, mouse_y)
	local x1 = self._mouse_area_x or self._x
	local y1 = self._mouse_area_y or self._y
	local x2 = x1 + (self._mouse_area_width or self._width)
	local y2 = y1 + (self._mouse_area_height or self._height)

	return x1 <= mouse_x and mouse_x <= x2 and y1 <= mouse_y and mouse_y <= y2
end

function MenuItem:on_move_left()
	return
end

function MenuItem:on_move_right()
	return
end

function MenuItem:_try_callback(callback_object, callback_name, ...)
	if callback_object and callback_name and callback_object[callback_name] then
		return callback_object[callback_name](callback_object, ...)
	end
end

function MenuItem:highlightable()
	return not self:disabled() and self:visible() and not self:removed()
end

function MenuItem:width()
	return self._width
end

function MenuItem:height()
	return self._height
end

function MenuItem:x()
	return self._x
end

function MenuItem:y()
	return self._y
end

function MenuItem:z()
	return self._z
end

function MenuItem:name()
	return self.config.name
end

function MenuItem:menu_activated()
	if self.config.page then
		self.config.page:menu_activated()
	end
end

function MenuItem:menu_deactivated(tab)
	tab = tab or {}

	if tab[self] then
		-- block empty
	end

	tab[self] = true

	if self.config.page then
		self.config.page:menu_deactivated(tab)
	end
end

function MenuItem:update_size(dt, t, gui)
	if self._floating_tooltip then
		if self._mouse_x and self._mouse_y and not self._floating_tooltip:is_playing() and self:visible() and not self.config.hidden then
			self._floating_tooltip:play()
		elseif (not self._mouse_x or not self._mouse_y) and self._floating_tooltip:is_playing() then
			self._floating_tooltip:stop()
		end

		local layout_settings = MenuHelper:layout_settings(self.config.floating_tooltip.layout_settings)

		self._floating_tooltip:update_size(dt, t, gui, layout_settings)
	end
end

function MenuItem:update_position(dt, t)
	if self._floating_tooltip then
		local layout_settings = MenuHelper:layout_settings(self.config.floating_tooltip.layout_settings)

		self._floating_tooltip:update_position(dt, t, layout_settings, self._mouse_x, self._mouse_y, 999)
	end
end

function MenuItem:render(dt, t, gui)
	if self._floating_tooltip then
		local layout_settings = MenuHelper:layout_settings(self.config.floating_tooltip.layout_settings)

		self._floating_tooltip:render(dt, t, gui, layout_settings)
	end
end

function MenuItem:destroy()
	if self.__destroyed then
		return
	end

	self.__destroyed = true

	if self.config.page then
		self.config.page:destroy()
	end
end
