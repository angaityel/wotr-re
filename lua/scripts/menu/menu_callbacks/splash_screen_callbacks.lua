-- chunkname: @scripts/menu/menu_callbacks/splash_screen_callbacks.lua

SplashScreenCallbacks = class(SplashScreenCallbacks)

function SplashScreenCallbacks:init(state)
	self._state = state
end

function SplashScreenCallbacks:cb_error_popup_enter(args)
	self._state:cb_error_popup_enter(args)
end

function SplashScreenCallbacks:cb_error_popup_item_selected(args)
	self._state:cb_error_popup_item_selected(args)
end

function SplashScreenCallbacks:cb_changelog_popup_enter(args)
	self._state:cb_changelog_popup_enter(args)
end

function SplashScreenCallbacks:cb_changelog_popup_item_selected(args)
	self._state:cb_changelog_popup_item_selected(args)
end

function SplashScreenCallbacks:cb_goto_next_splash_screen()
	self._state:cb_goto_next_splash_screen()
end

function SplashScreenCallbacks:cb_check_changelog()
	self._state:cb_check_changelog()
end

function SplashScreenCallbacks:cb_goto_main_menu()
	self._state:cb_goto_main_menu()
end

function SplashScreenCallbacks:cb_open_url_in_browser(url)
	Application.open_url_in_browser(url)
end
