-- chunkname: @scripts/menu/menu_controller_settings/final_scoreboard_menu_controller_settings.lua

FinalScoreboardMenuControllerSettings = {}
FinalScoreboardMenuControllerSettings.pad360 = {
	select = {
		controller_type = "pad",
		key = "a",
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
	move = {
		controller_type = "pad",
		key = "left",
		func = "axis"
	},
	close_menu = {
		controller_type = "pad",
		key = "start",
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
	}
}
FinalScoreboardMenuControllerSettings.padps3 = {
	select = {
		controller_type = "pad",
		key = "cross",
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
	move = {
		controller_type = "pad",
		key = "left",
		func = "axis"
	},
	close_menu = {
		controller_type = "pad",
		key = "start",
		func = "pressed"
	}
}
FinalScoreboardMenuControllerSettings.keyboard_mouse = {
	select = {
		controller_type = "keyboard",
		key = "enter",
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
	}
}
