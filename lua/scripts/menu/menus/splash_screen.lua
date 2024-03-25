-- chunkname: @scripts/menu/menus/splash_screen.lua

require("scripts/menu/menus/menu")
require("scripts/menu/menu_containers/loading_indicator_menu_container")
require("scripts/menu/menu_controller_settings/splash_screen_controller_settings")
require("scripts/menu/menu_definitions/splash_screen_definition")
require("scripts/menu/menu_callbacks/splash_screen_callbacks")

SplashScreen = class(SplashScreen, Menu)

function SplashScreen:init(state, world, controller_settings, menu_settings, menu_definition, menu_callbacks, menu_data)
	SplashScreen.super.init(self, state, world, controller_settings, menu_settings, menu_definition, menu_callbacks, menu_data)

	local layout_settings = MenuHelper:layout_settings(SplashScreenSettings.items.loading_indicator)

	self._loading_indicator = LoadingIndicatorMenuContainer.create_from_config(layout_settings, world)

	Managers.state.event:register(self, "load_started", "event_load_started")
	Managers.state.event:register(self, "load_finished", "event_load_finished")
end

function SplashScreen:_create_gui()
	self._gui = World.create_screen_gui(self._world, "material", "materials/menu/loading_atlas", "material", MenuSettings.videos.fatshark_splash.material, "material", MenuSettings.videos.paradox_splash.material, "material", MenuSettings.videos.physx_splash.material, "material", "materials/menu/splash_screen", "material", "materials/fonts/hell_shark_font", "material", "materials/hud/buttons", "immediate")
end

function SplashScreen:event_load_started(text_loading, text_loaded)
	self._loading_indicator:load_started(text_loading, text_loaded)
end

function SplashScreen:event_load_finished()
	self._loading_indicator:load_finished()
end

function SplashScreen:update(dt, t)
	SplashScreen.super.update(self, dt, t)

	local layout_settings = MenuHelper:layout_settings(SplashScreenSettings.items.loading_indicator)

	self._loading_indicator:update_size(dt, t, self._gui, layout_settings)

	local x, y = MenuHelper:container_position(self._loading_indicator, layout_settings)

	self._loading_indicator:update_position(dt, t, layout_settings, x, y, 992)
	self._loading_indicator:render(dt, t, self._gui, layout_settings)
end

function SplashScreen:set_active(active)
	SplashScreen.super.set_active(self, active)
end
