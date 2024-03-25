-- chunkname: @scripts/settings/controller_settings.lua

function populate_player_controls_from_save(save_data)
	if save_data.controls then
		if not save_data.controls.big_picture or PlayerControllerSettings.big_picture ~= save_data.controls.big_picture then
			print("Resetting Big Picture settings from:", save_data.controls.big_picture, ", to:", PlayerControllerSettings.big_picture)

			save_data.controls.pad360 = PlayerControllerSettings.pad360
			save_data.controls.big_picture = PlayerControllerSettings.big_picture
		end

		for k, v in pairs(save_data.controls) do
			if type(v) == "table" then
				for k1, v1 in pairs(v) do
					ActivePlayerControllerSettings[k][k1] = v1

					if k1 == "shield_bash_pose" then
						ActivePlayerControllerSettings[k].shield_bash_initiate = table.clone(v1)
						ActivePlayerControllerSettings[k].shield_bash_initiate.func = "pressed"
					end
				end
			else
				ActivePlayerControllerSettings[k] = v
			end
		end
	end
end

PlayerControllerSettings = {}
PlayerControllerSettings.sensitivity = 1
PlayerControllerSettings.pad_sensitivity_x = 0.9
PlayerControllerSettings.pad_sensitivity_y = 0.4
PlayerControllerSettings.big_picture = 1
PlayerControllerSettings.pad360 = {
	scoreboard = {
		controller_type = "pad",
		key = "back",
		state_blocked = "shifted",
		func = "button"
	},
	cancel = {
		controller_type = "pad",
		key = "start",
		func = "pressed"
	},
	leave_ghost_mode = {
		controller_type = "pad",
		key = "a",
		state_blocked = "shifted",
		func = "pressed"
	},
	skip_cutscene = {
		controller_type = "pad",
		key = "start",
		func = "pressed"
	},
	select_left_click = {
		controller_type = "pad",
		key = "a",
		state_blocked = "shifted",
		func = "pressed"
	},
	select_left_click = {
		controller_type = "pad",
		key = "b",
		state_blocked = "shifted",
		func = "pressed"
	},
	move = {
		controller_type = "pad",
		key = "left",
		func = "axis"
	},
	mount_move = {
		controller_type = "pad",
		key = "left",
		func = "axis"
	},
	look_raw = {
		controller_type = "pad",
		key = "right",
		func = "axis"
	},
	melee_pose = {
		controller_type = "pad",
		key = "right_trigger",
		func = "button"
	},
	melee_swing = {
		controller_type = "pad",
		key = "right_trigger",
		func = "released"
	},
	raise_block = {
		controller_type = "pad",
		key = "left_trigger",
		func = "pressed"
	},
	lower_block = {
		controller_type = "pad",
		key = "left_trigger",
		func = "released"
	},
	block = {
		controller_type = "pad",
		key = "left_trigger",
		func = "button"
	},
	ranged_weapon_aim = {
		controller_type = "pad",
		key = "left_trigger",
		func = "button"
	},
	ranged_weapon_fire = {
		controller_type = "pad",
		key = "right_trigger",
		func = "pressed"
	},
	wield_shield = {
		controller_type = "pad",
		key = "d_up",
		state_blocked = "shifted",
		func = "pressed"
	},
	wield_dagger = {
		controller_type = "pad",
		key = "d_down",
		state_blocked = "shifted",
		func = "pressed"
	},
	wield_one_handed_weapon = {
		controller_type = "pad",
		key = "d_left",
		state_blocked = "shifted",
		func = "pressed"
	},
	wield_two_handed_weapon = {
		controller_type = "pad",
		key = "d_right",
		state_blocked = "shifted",
		func = "pressed"
	},
	interact = {
		controller_type = "pad",
		key = "x",
		state_blocked = "shifted",
		func = "pressed"
	},
	interacting = {
		controller_type = "pad",
		key = "x",
		state_blocked = "shifted",
		func = "button"
	},
	jump = {
		controller_type = "pad",
		key = "a",
		state_blocked = "shifted",
		func = "pressed"
	},
	crouch = {
		controller_type = "pad",
		key = "right_thumb",
		state_blocked = "shifted",
		func = "pressed"
	},
	rush = {
		controller_type = "pad",
		key = "left_shoulder",
		state_blocked = "shifted",
		func = "button"
	},
	rush_pressed = {
		controller_type = "pad",
		key = "left_shoulder",
		state_blocked = "shifted",
		func = "pressed"
	},
	mounted_charge = {
		controller_type = "pad",
		key = "left_shoulder",
		state_blocked = "shifted",
		func = "button"
	},
	mounted_charge_pressed = {
		controller_type = "pad",
		key = "left_shoulder",
		state_blocked = "shifted",
		func = "pressed"
	},
	bandage = {
		controller_type = "pad",
		key = "b",
		state_blocked = "shifted",
		func = "button"
	},
	bandage_start = {
		controller_type = "pad",
		key = "b",
		state_blocked = "shifted",
		func = "pressed"
	},
	mount_brake = {
		controller_type = "pad",
		key = "b",
		state_blocked = "shifted",
		func = "button"
	},
	shield_bash_pose = {
		controller_type = "pad",
		key = "right_trigger",
		state_blocked = "shifted",
		func = "button"
	},
	shield_bash_initiate = {
		controller_type = "pad",
		key = "right_trigger",
		state_blocked = "shifted",
		func = "pressed"
	},
	push = {
		controller_type = "pad",
		key = "right_trigger",
		state_blocked = "shifted",
		func = "pressed"
	},
	couch_lance = {
		controller_type = "pad",
		key = "right_trigger",
		state_blocked = "shifted",
		func = "button"
	},
	hold_breath = {
		controller_type = "pad",
		key = "right_shoulder",
		func = "button"
	},
	ranged_weapon_zoom = {
		controller_type = "pad",
		key = "right_thumb",
		state_blocked = "shifted",
		func = "pressed"
	},
	yield = {
		controller_type = "pad",
		key = "a",
		state_blocked = "shifted",
		func = "pressed"
	},
	activate_tag = {
		controller_type = "pad",
		key = "left_thumb",
		state_blocked = "shifted",
		func = "button"
	},
	switch_weapon_grip = {
		controller_type = "pad",
		key = "y",
		state_blocked = "shifted",
		func = "pressed"
	},
	deactivate_chat_input = {
		controller_type = "pad",
		key = "b",
		func = "pressed"
	},
	shift_function = {
		set_state = "shifted",
		key = "right_shoulder",
		controller_type = "pad",
		func = "button"
	},
	officer_buff_one = {
		controller_type = "pad",
		key = "a",
		state = "shifted",
		func = "pressed"
	},
	officer_buff_two = {
		controller_type = "pad",
		key = "b",
		state = "shifted",
		func = "pressed"
	},
	call_horse_released = {
		controller_type = "pad",
		key = "x",
		state = "shifted",
		func = "released"
	},
	call_horse = {
		controller_type = "pad",
		key = "x",
		state = "shifted",
		func = "button"
	},
	toggle_visor = {
		controller_type = "pad",
		key = "y",
		state = "shifted",
		func = "pressed"
	},
	vote_yes = {
		controller_type = "pad",
		key = "d_left",
		state = "shifted",
		func = "pressed"
	},
	vote_no = {
		controller_type = "pad",
		key = "d_right",
		state = "shifted",
		func = "pressed"
	},
	exit_to_menu_lobby = {
		controller_type = "pad",
		key = "back",
		state = "shifted",
		func = "pressed"
	},
	activate_chat_input_all = {
		controller_type = "pad",
		key = "right_thumb",
		state = "shifted",
		func = "pressed"
	},
	zoom_in = {
		controller_type = "pad",
		key = "d_up",
		state = "shifted",
		func = "button"
	},
	zoom_out = {
		controller_type = "pad",
		key = "d_down",
		state = "shifted",
		func = "button"
	},
	look = {
		type = "FilterAxisScaleRampDt",
		controller_type = "pad",
		func = "filter",
		input = {
			type = "look",
			scale_x = 1,
			axis = "look_raw",
			scale_y = 1,
			min_move = 0.3
		}
	},
	look_aiming = {
		type = "FilterAxisScaleRampDt",
		controller_type = "pad",
		func = "filter",
		input = {
			type = "look_aiming",
			time_acc_multiplier = 1.8,
			scale_x = 0.1,
			axis = "look_raw",
			scale_y = 0.1,
			hi_scale_x = 0.1,
			min_move = 0
		}
	}
}
PlayerControllerSettings.padps3 = {
	move = {
		controller_type = "pad",
		key = "left",
		func = "axis"
	},
	look_raw = {
		controller_type = "pad",
		key = "right",
		func = "axis"
	},
	enter_free_flight = {
		controller_type = "pad",
		key = "start",
		func = "pressed"
	},
	jump = {
		controller_type = "pad",
		key = "cross",
		func = "pressed"
	},
	look = {
		type = "FilterAxisScale",
		controller_type = "pad",
		func = "filter",
		input = {
			scale = 0.3,
			axis = "look_raw"
		}
	}
}
PlayerControllerSettings.keyboard_mouse = {
	scoreboard = {
		controller_type = "keyboard",
		key = "tab",
		func = "button"
	},
	cancel = {
		controller_type = "keyboard",
		key = "esc",
		func = "pressed"
	},
	enter_free_flight = {
		controller_type = "keyboard",
		key = "f8",
		func = "pressed"
	},
	activate_chat_input = {
		controller_type = "keyboard",
		key = "enter",
		func = "pressed"
	},
	activate_chat_input_all = {
		controller_type = "keyboard",
		key = "y",
		func = "pressed"
	},
	activate_chat_input_team = {
		controller_type = "keyboard",
		key = "u",
		func = "pressed"
	},
	execute_chat_input = {
		controller_type = "keyboard",
		key = "enter",
		func = "pressed"
	},
	deactivate_chat_input = {
		controller_type = "keyboard",
		key = "esc",
		func = "pressed"
	},
	suicide = {
		controller_type = "keyboard",
		key = "f3",
		func = "pressed"
	},
	exit_to_menu_lobby = {
		controller_type = "keyboard",
		key = "l",
		func = "pressed"
	},
	load_next_level = {
		controller_type = "keyboard",
		key = "n",
		func = "pressed"
	},
	hud_debug_text_test = {
		controller_type = "keyboard",
		key = "o",
		func = "pressed"
	},
	look_raw = {
		controller_type = "mouse",
		key = "mouse",
		func = "axis"
	},
	couch_lance = {
		controller_type = "mouse",
		key = "left",
		func = "button"
	},
	melee_pose = {
		controller_type = "mouse",
		key = "left",
		func = "button"
	},
	melee_swing = {
		controller_type = "mouse",
		key = "left",
		func = "released"
	},
	raise_block = {
		controller_type = "mouse",
		key = "right",
		func = "pressed"
	},
	lower_block = {
		controller_type = "mouse",
		key = "right",
		func = "released"
	},
	block = {
		controller_type = "mouse",
		key = "right",
		func = "button"
	},
	ranged_weapon_aim = {
		controller_type = "mouse",
		key = "right",
		func = "button"
	},
	toggle_visor = {
		controller_type = "keyboard",
		key = "v",
		func = "pressed"
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
	leave_ghost_mode = {
		controller_type = "mouse",
		key = "left",
		func = "pressed"
	},
	bandage = {
		controller_type = "keyboard",
		key = "b",
		func = "button"
	},
	bandage_start = {
		controller_type = "keyboard",
		key = "b",
		func = "pressed"
	},
	ranged_weapon_fire = {
		controller_type = "mouse",
		key = "left",
		func = "pressed"
	},
	cursor = {
		controller_type = "mouse",
		key = "cursor",
		func = "axis"
	},
	wield_shield = {
		controller_type = "keyboard",
		key = "4",
		func = "pressed"
	},
	wield_dagger = {
		controller_type = "keyboard",
		key = "3",
		func = "pressed"
	},
	wield_one_handed_weapon = {
		controller_type = "keyboard",
		key = "2",
		func = "pressed"
	},
	wield_two_handed_weapon = {
		controller_type = "keyboard",
		key = "1",
		func = "pressed"
	},
	mount_cruise_control_gear_up = {
		controller_type = "keyboard",
		key = "w",
		func = "pressed"
	},
	mount_cruise_control_gear_down = {
		controller_type = "keyboard",
		key = "s",
		func = "pressed"
	},
	interact = {
		controller_type = "keyboard",
		key = "e",
		func = "pressed"
	},
	interacting = {
		controller_type = "keyboard",
		key = "e",
		func = "button"
	},
	jump = {
		controller_type = "keyboard",
		key = "space",
		func = "pressed"
	},
	yield = {
		controller_type = "mouse",
		key = "left",
		func = "pressed"
	},
	mount_brake = {
		controller_type = "keyboard",
		key = "space",
		func = "button"
	},
	crouch = {
		controller_type = "keyboard",
		key = "left ctrl",
		func = "pressed"
	},
	move_left = {
		controller_type = "keyboard",
		key = "a",
		func = "button"
	},
	move_right = {
		controller_type = "keyboard",
		key = "d",
		func = "button"
	},
	mount_move_back_pressed = {
		controller_type = "keyboard",
		key = "f",
		func = "pressed"
	},
	move_back = {
		controller_type = "keyboard",
		key = "s",
		func = "button"
	},
	mount_move_forward_pressed = {
		controller_type = "keyboard",
		key = "r",
		func = "pressed"
	},
	move_forward = {
		controller_type = "keyboard",
		key = "w",
		func = "button"
	},
	mount_move_left = {
		controller_type = "keyboard",
		key = "a",
		func = "button"
	},
	mount_move_right = {
		controller_type = "keyboard",
		key = "d",
		func = "button"
	},
	mount_move_back = {
		controller_type = "keyboard",
		key = "f",
		func = "button"
	},
	mount_move_forward = {
		controller_type = "keyboard",
		key = "r",
		func = "button"
	},
	rush = {
		controller_type = "keyboard",
		key = "f",
		func = "button"
	},
	rush_pressed = {
		controller_type = "keyboard",
		key = "f",
		func = "pressed"
	},
	mounted_charge = {
		controller_type = "keyboard",
		key = "left shift",
		func = "button"
	},
	mounted_charge_pressed = {
		controller_type = "keyboard",
		key = "left shift",
		func = "pressed"
	},
	ranged_weapon_zoom = {
		controller_type = "keyboard",
		key = "left ctrl",
		func = "pressed"
	},
	hold_breath = {
		controller_type = "keyboard",
		key = "left shift",
		func = "button"
	},
	left_shift_down = {
		controller_type = "keyboard",
		key = "left shift",
		func = "button"
	},
	backspace_pressed = {
		controller_type = "keyboard",
		key = "backspace",
		func = "pressed"
	},
	backspace_down = {
		controller_type = "keyboard",
		key = "backspace",
		func = "button"
	},
	officer_buff_one = {
		controller_type = "keyboard",
		key = "z",
		func = "pressed"
	},
	officer_buff_two = {
		controller_type = "keyboard",
		key = "x",
		func = "pressed"
	},
	activate_tag = {
		controller_type = "keyboard",
		key = "t",
		func = "button"
	},
	shield_bash_pose = {
		controller_type = "mouse",
		key = "left",
		func = "button"
	},
	shield_bash_initiate = {
		controller_type = "mouse",
		key = "left",
		func = "pressed"
	},
	push = {
		controller_type = "mouse",
		key = "left",
		func = "pressed"
	},
	call_horse_released = {
		controller_type = "keyboard",
		key = "c",
		func = "released"
	},
	call_horse = {
		controller_type = "keyboard",
		key = "c",
		func = "button"
	},
	switch_weapon_grip = {
		controller_type = "keyboard",
		key = "q",
		func = "pressed"
	},
	delete_pressed = {
		controller_type = "keyboard",
		key = "delete",
		func = "pressed"
	},
	space_pressed = {
		controller_type = "keyboard",
		key = "space",
		func = "pressed"
	},
	left_ctrl_down = {
		controller_type = "keyboard",
		key = "left ctrl",
		func = "button"
	},
	zoom_in = {
		controller_type = "mouse",
		key = "wheel_up",
		func = "button"
	},
	zoom_out = {
		controller_type = "mouse",
		key = "wheel_down",
		func = "button"
	},
	zoom = {
		controller_type = "mouse",
		key = "wheel",
		func = "axis"
	},
	mouse_scroll = {
		controller_type = "mouse",
		key = "wheel",
		func = "axis"
	},
	skip_cutscene = {
		controller_type = "mouse",
		key = "left",
		func = "pressed"
	},
	vote_yes = {
		controller_type = "keyboard",
		key = "f1",
		func = "pressed"
	},
	vote_no = {
		controller_type = "keyboard",
		key = "f2",
		func = "pressed"
	},
	move = {
		type = "FilterVirtualAxis",
		controller_type = "mouse",
		func = "filter",
		input = {
			neg_y = "move_back",
			pos_x = "move_right",
			neg_x = "move_left",
			pos_y = "move_forward"
		}
	},
	mount_move = {
		type = "FilterVirtualAxis",
		controller_type = "mouse",
		func = "filter",
		input = {
			neg_y = "mount_move_back",
			pos_x = "mount_move_right",
			neg_x = "mount_move_left",
			pos_y = "mount_move_forward"
		}
	},
	look = {
		type = "FilterInvertAxisY",
		controller_type = "mouse",
		func = "filter",
		input = {
			scale = 0.0002,
			axis = "look_raw"
		}
	},
	look_aiming = {
		type = "FilterInvertAxisY",
		controller_type = "mouse",
		func = "filter",
		input = {
			scale = 0.0002,
			axis = "look_raw"
		}
	}
}
ActivePlayerControllerSettings = ActivePlayerControllerSettings or table.clone(PlayerControllerSettings)
