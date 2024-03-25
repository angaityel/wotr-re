-- chunkname: @scripts/menu/menu_items/texture_button_countdown_menu_item.lua

require("scripts/menu/menu_items/menu_item")

TextureButtonCountdownMenuItem = class(TextureButtonCountdownMenuItem, TextureButtonMenuItem)

function TextureButtonCountdownMenuItem:init(config, world)
	TextureButtonCountdownMenuItem.super.init(self, config, world)
end

function TextureButtonCountdownMenuItem:on_page_enter(on_cancel)
	TextureButtonCountdownMenuItem.super.on_page_enter(self, on_cancel)

	self._timer = self.config.countdown_time
end

function TextureButtonCountdownMenuItem:set_text(text)
	self.config.original_text = text
end

function TextureButtonCountdownMenuItem:update_size(dt, t, gui, layout_settings)
	self._timer = self._timer - dt
	self.config.text = self.config.original_text .. " " .. math.ceil(self._timer)

	if self._timer <= 0 then
		self:_try_callback(self.config.callback_object, self.config.on_countdown_done, unpack(self.config.on_countdown_done_args or {}))
	end

	TextureButtonCountdownMenuItem.super.update_size(self, dt, t, gui, layout_settings)
end

function TextureButtonCountdownMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "texture_button",
		name = config.name,
		page = config.page,
		callback_object = callback_object,
		on_select = config.on_select,
		on_select_args = config.on_select_args or {},
		countdown_time = config.countdown_time,
		on_countdown_done = config.on_countdown_done,
		on_countdown_done_args = config.on_countdown_done_args or {},
		disabled = config.disabled,
		disabled_func = config.disabled_func and callback(callback_object, config.disabled_func, config.disabled_func_args),
		visible_func = config.visible_func and callback(callback_object, config.visible_func, config.visible_func_args),
		text = L(config.text),
		original_text = L(config.text),
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.texture_button
	}

	return TextureButtonCountdownMenuItem:new(config, compiler_data.world)
end
