-- chunkname: @scripts/menu/menu_controller_settings/main_menu_controller_settings.lua

MainMenuControllerSettings = {}
MainMenuControllerSettings.pad360 = {
	select = {
		controller_type = "pad",
		key = "a",
		func = "pressed"
	},
	cancel = {
		controller_type = "pad",
		key = "b",
		func = "pressed"
	},
	refresh = {
		controller_type = "pad",
		key = "x",
		func = "pressed"
	},
	apply = {
		controller_type = "pad",
		key = "x",
		func = "pressed"
	},
	reset = {
		controller_type = "pad",
		key = "y",
		func = "pressed"
	},
	mark_favorite = {
		controller_type = "pad",
		key = "y",
		func = "pressed"
	},
	show_filters = {
		controller_type = "pad",
		key = "right_thumb",
		func = "pressed"
	},
	tab_left = {
		controller_type = "pad",
		key = "left_shoulder",
		func = "pressed"
	},
	tab_right = {
		controller_type = "pad",
		key = "right_shoulder",
		func = "pressed"
	},
	move_up_value = {
		controller_type = "pad",
		key = "d_up",
		func = "button"
	},
	move_down_value = {
		controller_type = "pad",
		key = "d_down",
		func = "button"
	},
	move_left_value = {
		controller_type = "pad",
		key = "d_left",
		func = "button"
	},
	move_right_value = {
		controller_type = "pad",
		key = "d_right",
		func = "button"
	},
	wheel = {
		controller_type = "pad",
		key = "left",
		func = "axis"
	},
	right_wheel = {
		controller_type = "pad",
		key = "right",
		func = "axis"
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
	},
	move_up = {
		type = "FilterControllerMenuMovement",
		controller_type = "pad",
		func = "filter",
		input = {
			input = "move_up_value"
		}
	},
	move_down = {
		type = "FilterControllerMenuMovement",
		controller_type = "pad",
		func = "filter",
		input = {
			input = "move_down_value"
		}
	},
	move_left = {
		type = "FilterControllerMenuMovement",
		controller_type = "pad",
		func = "filter",
		input = {
			input = "move_left_value"
		}
	},
	move_right = {
		type = "FilterControllerMenuMovement",
		controller_type = "pad",
		func = "filter",
		input = {
			input = "move_right_value"
		}
	},
	move_up_button = {
		controller_type = "pad",
		key = "d_up",
		func = "button"
	},
	move_down_button = {
		controller_type = "pad",
		key = "d_down",
		func = "button"
	},
	move_left_button = {
		controller_type = "pad",
		key = "d_left",
		func = "button"
	},
	move_right_button = {
		controller_type = "pad",
		key = "d_right",
		func = "button"
	}
}
MainMenuControllerSettings.padps3 = {
	select = {
		controller_type = "pad",
		key = "cross",
		func = "pressed"
	},
	cancel = {
		controller_type = "pad",
		key = "circle",
		func = "pressed"
	},
	replay = {
		controller_type = "pad",
		key = "square",
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
	wheel = {
		controller_type = "pad",
		key = "left",
		func = "axis"
	},
	close_menu = {
		controller_type = "pad",
		key = "start",
		func = "pressed"
	},
	select_left_click = {
		controller_type = "pad",
		key = "square",
		func = "pressed"
	},
	select_right_click = {
		controller_type = "pad",
		key = "cross",
		func = "pressed"
	},
	select_down = {
		controller_type = "pad",
		key = "d_down",
		func = "button"
	}
}
MainMenuControllerSettings.keyboard_mouse = {
	select = {
		controller_type = "keyboard",
		key = "enter",
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
	move_up_hold = {
		controller_type = "keyboard",
		key = "up",
		func = "button"
	},
	move_down_hold = {
		controller_type = "keyboard",
		key = "down",
		func = "button"
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
