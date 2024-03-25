-- chunkname: @scripts/menu/menu_items/bitsquid_splash_menu_item.lua

BitsquidSplashMenuItem = class(BitsquidSplashMenuItem, MenuItem)

function BitsquidSplashMenuItem:init(config, world)
	BitsquidSplashMenuItem.super.init(self, config, world)

	self._splash = BitsquidSplash.create("overlay", "core/rendering/default_outdoor", true)
end

function BitsquidSplashMenuItem:destroy()
	BitsquidSplashMenuItem.super.destroy(self)
	BitsquidSplash.destroy(self._splash)
end

function BitsquidSplashMenuItem:update_size(dt, t, gui, layout_settings)
	local res_width, res_height = Gui.resolution()

	self._width = res_width
	self._height = res_height
end

function BitsquidSplashMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function BitsquidSplashMenuItem:render(dt, t, gui, layout_settings)
	if not self._done then
		self._done = BitsquidSplash.update(self._splash, dt)
	end

	if self._done then
		self:_try_callback(self.config.callback_object, self.config.on_video_end, unpack(self.config.on_video_end_args or {}))
	end
end

function BitsquidSplashMenuItem:application_render()
	if not self._done then
		BitsquidSplash.render(self._splash)
	end
end

function BitsquidSplashMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "text_input",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		on_video_end = config.on_video_end,
		on_video_end_args = config.on_video_end_args or {},
		callback_object = callback_object,
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.text_input
	}

	return BitsquidSplashMenuItem:new(config, compiler_data.world)
end
