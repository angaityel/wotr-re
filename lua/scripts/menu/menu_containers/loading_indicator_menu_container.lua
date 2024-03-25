-- chunkname: @scripts/menu/menu_containers/loading_indicator_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

LoadingIndicatorMenuContainer = class(LoadingIndicatorMenuContainer, MenuContainer)

function LoadingIndicatorMenuContainer:init(config, world)
	LoadingIndicatorMenuContainer.super.init(self, config, world)

	local animated_texture_config = config.loading_icon_config

	self._loading_icon_item = AnimatedTextureMenuItem:new(self, animated_texture_config, world)
end

function LoadingIndicatorMenuContainer:load_started(text_loading, text_loaded)
	self._render = true
end

function LoadingIndicatorMenuContainer:load_finished()
	self._render = false
end

function LoadingIndicatorMenuContainer:save_started(text_saving, text_saved)
	self._render = true
end

function LoadingIndicatorMenuContainer:save_finished()
	self._render = false
end

function LoadingIndicatorMenuContainer:update_size(dt, t, gui, layout_settings)
	if not self._render then
		return
	end

	self._loading_icon_item:update_size(dt, t, gui, layout_settings.loading_icon_config)
end

function LoadingIndicatorMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z

	self._loading_icon_item:update_position(dt, t, layout_settings.loading_icon_config, x, y, z)
end

function LoadingIndicatorMenuContainer:render(dt, t, gui, layout_settings)
	if not self._render then
		return
	end

	self._loading_icon_item:render(dt, t, gui, layout_settings.loading_icon_config)
end

function LoadingIndicatorMenuContainer:_alpha(t, layout_settings)
	local alpha_multiplier = 1

	if self._finished_time and t > self._finished_time + layout_settings.fade_start_delay then
		alpha_multiplier = -1 / layout_settings.fade_end_delay * (t - (self._finished_time + layout_settings.fade_start_delay)) + 1
		alpha_multiplier = math.max(0, alpha_multiplier)
	end

	return alpha_multiplier
end

function LoadingIndicatorMenuContainer.create_from_config(config)
	return LoadingIndicatorMenuContainer:new(config)
end
