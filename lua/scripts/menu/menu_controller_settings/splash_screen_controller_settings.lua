-- chunkname: @scripts/menu/menu_controller_settings/splash_screen_controller_settings.lua

SplashScreenControllerSettings = {}
SplashScreenControllerSettings.keyboard_mouse = {
	select = {
		controller_type = "keyboard",
		key = "enter",
		func = "pressed"
	},
	space = {
		controller_type = "keyboard",
		key = "space",
		func = "pressed"
	},
	cancel = {
		controller_type = "keyboard",
		key = "esc",
		func = "pressed"
	},
	replay = {
		controller_type = "keyboard",
		key = "r",
		func = "pressed"
	},
	move_up = {
		controller_type = "keyboard",
		key = "up",
		func = "pressed"
	},
	move_down = {
		controller_type = "keyboard",
		key = "down",
		func = "pressed"
	},
	move_left = {
		controller_type = "keyboard",
		key = "left",
		func = "pressed"
	},
	move_right = {
		controller_type = "keyboard",
		key = "right",
		func = "pressed"
	},
	close_menu = {
		controller_type = "keyboard",
		key = "q",
		func = "pressed"
	},
	cursor = {
		controller_type = "mouse",
		key = "cursor",
		func = "axis"
	},
	select_left_click = {
		controller_type = "mouse",
		key = "left",
		func = "pressed"
	},
	select_right_click = {
		controller_type = "mouse",
		key = "right",
		func = "pressed"
	},
	select_down = {
		controller_type = "mouse",
		key = "left",
		func = "button"
	},
	wheel = {
		controller_type = "mouse",
		key = "wheel",
		func = "axis"
	}
}
SplashScreenControllerSettings.pad360 = {
	select = {
		controller_type = "pad",
		key = "a",
		func = "pressed"
	},
	space = {
		controller_type = "pad",
		key = "a",
		func = "pressed"
	},
	cancel = {
		controller_type = "pad",
		key = "b",
		func = "pressed"
	},
	replay = {
		controller_type = "pad",
		key = "x",
		func = "pressed"
	},
	move_up = {
		controller_type = "pad",
		key = "d_up",
		func = "pressed"
	},
	move_down = {
		controller_type = "pad",
		key = "d_down",
		func = "pressed"
	},
	move_left = {
		controller_type = "pad",
		key = "d_left",
		func = "pressed"
	},
	move_right = {
		controller_type = "pad",
		key = "d_right",
		func = "pressed"
	},
	close_menu = {
		controller_type = "pad",
		key = "start",
		func = "pressed"
	},
	select_left_click = {
		controller_type = "pad",
		key = "x",
		func = "pressed"
	},
	select_right_click = {
		controller_type = "pad",
		key = "a",
		func = "pressed"
	},
	select_down = {
		controller_type = "pad",
		key = "d_down",
		func = "button"
	}
}
