-- chunkname: @scripts/menu/menu_items/empty_menu_item.lua

EmptyMenuItem = class(EmptyMenuItem, MenuItem)

function EmptyMenuItem:init(config, world)
	EmptyMenuItem.super.init(self, config, world)
end

function EmptyMenuItem:update_size()
	if self.config.relative_height then
		local _, res_height = Gui.resolution()

		self._height = self.config.relative_height * res_height
	end
end

function EmptyMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function EmptyMenuItem:render()
	return
end

function EmptyMenuItem:render_from_child_page()
	return
end

function EmptyMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		disabled = true,
		type = "empty",
		name = config.name,
		page = config.page,
		layout_settings = config.layout_settings,
		relative_height = config.relative_height
	}

	return EmptyMenuItem:new(config, compiler_data.world)
end
