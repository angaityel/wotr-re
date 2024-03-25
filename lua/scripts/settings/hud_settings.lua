-- chunkname: @scripts/settings/hud_settings.lua

require("gui/textures/hud_atlas")
require("scripts/settings/level_settings")

SCALE_1366 = 0.7114583333333333
HUDSettings = HUDSettings or {}
HUDSettings.show_hud = true
HUDSettings.show_reticule = true
HUDSettings.show_damage_numbers = true
HUDSettings.show_xp_awards = true
HUDSettings.show_parry_helper = true
HUDSettings.show_pose_charge_helper = true
HUDSettings.show_announcements = true
HUDSettings.chat_output_vertical_align = "top"
HUDSettings.circle_section_size = 105
HUDSettings.marker_offset = 5

if DLCSettings.brian_blessed() then
	HUDSettings.announcement_voice_over = "brian_blessed"
else
	HUDSettings.announcement_voice_over = "normal"
end

HUDSettings.side_select_sound_events = {
	white = "york_side_select",
	red = "lancaster_side_select"
}
HUDSettings.player_colors = HUDSettings.player_colors or {}
HUDSettings.player_colors.white_team = {
	255,
	255,
	255,
	255
}
HUDSettings.player_colors.red_team = {
	255,
	160,
	33,
	0
}
HUDSettings.player_colors.neutral_team = {
	255,
	255,
	255,
	255
}
HUDSettings.player_colors.team_member = {
	255,
	0,
	209,
	164
}
HUDSettings.player_colors.squad_member = {
	255,
	96,
	237,
	252
}
HUDSettings.player_colors.enemy = {
	255,
	254,
	111,
	32
}
HUDSettings.player_colors.shadow = {
	255,
	0,
	0,
	0
}
HUDSettings.chat_text_colors = HUDSettings.chat_text_colors or {
	all = {
		210,
		210,
		210
	},
	self_all = {
		245,
		245,
		245
	},
	team = {
		0,
		209,
		164
	},
	self_team = {
		30,
		239,
		194
	}
}
HUDSettings.player_icons = HUDSettings.player_icons or {
	hide_fade_time = 0.3,
	far_enemy_hide_delay = 1,
	far_enemy_show_delay_min = 1,
	team_member_hide_delay = 1,
	default_far_enemy_max_distance = 50,
	squad_member_hide_delay = 1,
	far_enemy_show_delay_max = 3,
	near_enemy_show_delay = 0,
	tagged_enemy_hide_delay = 0,
	team_member_show_delay = 0,
	team_member_max_distance = 150,
	squad_member_show_delay = 0,
	near_enemy_max_distance = 15,
	near_enemy_hide_delay = 1,
	tagged_enemy_show_delay = 0,
	squad_member_max_distance = math.huge,
	line_of_sight_nodes = {
		"Head"
	}
}
HUDSettings.player_icons.level_far_enemy_max_distance = {}

for level_key, _ in pairs(LevelSettings) do
	HUDSettings.player_icons.level_far_enemy_max_distance[level_key] = HUDSettings.player_icons.default_far_enemy_max_distance
end

HUDSettings.attention_zone = HUDSettings.attention_zone or {}
HUDSettings.attention_zone.x_radius = 0.2
HUDSettings.attention_zone.y_radius = 0.3
HUDSettings.default_zone = HUDSettings.default_zone or {
	y_radius = 0.95,
	x_radius = 0.97
}
HUDSettings.fade_to_black = HUDSettings.fade_to_black or {
	layer = 101,
	color = {
		0,
		0,
		0,
		0
	}
}
HUDSettings.default_button_info = HUDSettings.default_button_info or {}
HUDSettings.default_button_info[1366] = HUDSettings.default_button_info[1366] or {}
HUDSettings.default_button_info[1366][768] = HUDSettings.default_button_info[1366][768] or {
	text_data = {
		font_size = 16,
		font = MenuSettings.fonts.hell_shark_16,
		offset_x = 25 * SCALE_1366,
		offset_y = 100 * SCALE_1366,
		drop_shadow = {
			1,
			-1
		}
	},
	default_buttons = {
		{
			button_name = "b",
			text = "main_menu_cancel"
		}
	}
}
HUDSettings.default_button_info[1680] = HUDSettings.default_button_info[1680] or {}
HUDSettings.default_button_info[1680][1050] = HUDSettings.default_button_info[1680][1050] or {
	text_data = {
		font_size = 28,
		font = MenuSettings.fonts.hell_shark_28,
		offset_x = 25 * SCALE_1366,
		offset_y = 100 * SCALE_1366,
		drop_shadow = {
			2,
			-2
		}
	},
	default_buttons = {
		{
			button_name = "b",
			text = "main_menu_cancel"
		}
	}
}
HUDSettings.crossbow_minigame = HUDSettings.crossbow_minigame or {}
HUDSettings.crossbow_minigame.container = HUDSettings.crossbow_minigame.container or {}
HUDSettings.crossbow_minigame.container[1680] = HUDSettings.crossbow_minigame.container[1680] or {}
HUDSettings.crossbow_minigame.container[1680][1050] = HUDSettings.crossbow_minigame.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 256,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 256,
	background_color = {
		0,
		0,
		0,
		0
	}
}
HUDSettings.crossbow_minigame.circle = HUDSettings.crossbow_minigame.circle or {}
HUDSettings.crossbow_minigame.circle[1680] = HUDSettings.crossbow_minigame.circle[1680] or {}
HUDSettings.crossbow_minigame.circle[1680][1050] = HUDSettings.crossbow_minigame.circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_crossbow_minigame_grab_area",
	pivot_offset_y = 0,
	texture_width = 256,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 256
}
HUDSettings.crossbow_minigame.cross = HUDSettings.crossbow_minigame.cross or {}
HUDSettings.crossbow_minigame.cross[1680] = HUDSettings.crossbow_minigame.cross[1680] or {}
HUDSettings.crossbow_minigame.cross[1680][1050] = HUDSettings.crossbow_minigame.cross[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_crossbow_minigame_hook",
	pivot_offset_y = 0,
	texture_width = 32,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 64,
	color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.crossbow_minigame.timer = HUDSettings.crossbow_minigame.timer or {}
HUDSettings.crossbow_minigame.timer[1680] = HUDSettings.crossbow_minigame.timer[1680] or {}
HUDSettings.crossbow_minigame.timer[1680][1050] = HUDSettings.crossbow_minigame.timer[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_crossbow_minigame_timer",
	pivot_offset_y = 0,
	texture_width = 256,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 256
}
HUDSettings.crossbow_minigame.background_circle = HUDSettings.crossbow_minigame.background_circle or {}
HUDSettings.crossbow_minigame.background_circle[1680] = HUDSettings.crossbow_minigame.background_circle[1680] or {}
HUDSettings.crossbow_minigame.background_circle[1680][1050] = HUDSettings.crossbow_minigame.background_circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_crossbow_minigame_timer_background",
	pivot_offset_y = 0,
	texture_width = 256,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 256,
	color = {
		100,
		255,
		255,
		255
	}
}
HUDSettings.bow_minigame = HUDSettings.bow_minigame or {}
HUDSettings.bow_minigame.container = HUDSettings.bow_minigame.container or {}
HUDSettings.bow_minigame.container[1680] = HUDSettings.bow_minigame.container[1680] or {}
HUDSettings.bow_minigame.container[1680][1050] = HUDSettings.bow_minigame.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 160,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 160,
	background_color = {
		0,
		0,
		0,
		0
	}
}
HUDSettings.bow_minigame.hit_section = HUDSettings.bow_minigame.hit_section or {}
HUDSettings.bow_minigame.hit_section[1680] = HUDSettings.bow_minigame.hit_section[1680] or {}
HUDSettings.bow_minigame.hit_section[1680][1050] = HUDSettings.bow_minigame.hit_section[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_bow_minigame_hit_section",
	pivot_offset_y = 0,
	texture_width = 160,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 160
}
HUDSettings.bow_minigame.marker = HUDSettings.bow_minigame.marker or {}
HUDSettings.bow_minigame.marker[1680] = HUDSettings.bow_minigame.marker[1680] or {}
HUDSettings.bow_minigame.marker[1680][1050] = HUDSettings.bow_minigame.marker[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_bow_minigame_marker",
	pivot_offset_y = 0,
	texture_width = 16,
	screen_align_x = "center",
	circle_radius = 76,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 16
}
HUDSettings.bow_minigame.timer_one = HUDSettings.bow_minigame.timer_one or {}
HUDSettings.bow_minigame.timer_one[1680] = HUDSettings.bow_minigame.timer_one[1680] or {}
HUDSettings.bow_minigame.timer_one[1680][1050] = HUDSettings.bow_minigame.timer_one[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_bow_minigame_timer_clockwise",
	pivot_offset_y = 0,
	texture_width = 160,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 160
}
HUDSettings.bow_minigame.timer_two = HUDSettings.bow_minigame.timer_two or {}
HUDSettings.bow_minigame.timer_two[1680] = HUDSettings.bow_minigame.timer_two[1680] or {}
HUDSettings.bow_minigame.timer_two[1680][1050] = HUDSettings.bow_minigame.timer_two[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_bow_minigame_timer_anti_clockwise",
	pivot_offset_y = 0,
	texture_width = 160,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 160
}
HUDSettings.bow_minigame.background_circle = HUDSettings.bow_minigame.background_circle or {}
HUDSettings.bow_minigame.background_circle[1680] = HUDSettings.bow_minigame.background_circle[1680] or {}
HUDSettings.bow_minigame.background_circle[1680][1050] = HUDSettings.bow_minigame.background_circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_bow_minigame_background_circle",
	pivot_offset_y = 0,
	texture_width = 160,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 160
}
HUDSettings.bow_minigame.crosshair = HUDSettings.bow_minigame.crosshair or {}
HUDSettings.bow_minigame.crosshair[1680] = HUDSettings.bow_minigame.crosshair[1680] or {}
HUDSettings.bow_minigame.crosshair[1680][1050] = HUDSettings.bow_minigame.crosshair[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_projectile_crosshair",
	pivot_offset_y = 0,
	texture_width = 120,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.435,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 144
}
HUDSettings.hit_marker = HUDSettings.hit_marker or {}
HUDSettings.hit_marker.container = HUDSettings.hit_marker.container or {}
HUDSettings.hit_marker.container[1680] = HUDSettings.hit_marker.container[1680] or {}
HUDSettings.hit_marker.container[1680][1050] = HUDSettings.hit_marker.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 24,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 24,
	background_color = {
		0,
		0,
		0,
		0
	}
}
HUDSettings.hit_marker.marker = HUDSettings.hit_marker.marker or {}
HUDSettings.hit_marker.marker[1680] = HUDSettings.hit_marker.marker[1680] or {}
HUDSettings.hit_marker.marker[1680][1050] = HUDSettings.hit_marker.marker[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_hit_marker",
	pivot_offset_y = 0,
	texture_width = 24,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 24,
	color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.parry_helper = HUDSettings.parry_helper or {}
HUDSettings.parry_helper.container = HUDSettings.parry_helper.container or {}
HUDSettings.parry_helper.container[1680] = HUDSettings.parry_helper.container[1680] or {}
HUDSettings.parry_helper.container[1680][1050] = HUDSettings.parry_helper.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 500,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 500
}
HUDSettings.parry_helper.parry_direction = HUDSettings.parry_helper.parry_direction or {}
HUDSettings.parry_helper.parry_direction[1680] = HUDSettings.parry_helper.parry_direction[1680] or {}
HUDSettings.parry_helper.parry_direction[1680][1050] = HUDSettings.parry_helper.parry_direction[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_parry_helper_parry",
	pivot_offset_y = 0,
	texture_width = 184,
	screen_align_x = "center",
	texture_2 = "hud_parry_helper_parry_delay",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 80,
	color = HUDSettings.player_colors.team_member,
	color_2 = {
		150,
		150,
		150,
		150
	}
}
HUDSettings.parry_helper.attack_direction = HUDSettings.parry_helper.attack_direction or {}
HUDSettings.parry_helper.attack_direction[1680] = HUDSettings.parry_helper.attack_direction[1680] or {}
HUDSettings.parry_helper.attack_direction[1680][1050] = HUDSettings.parry_helper.attack_direction[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_parry_helper_attack",
	pivot_offset_y = 0,
	texture_width = 348,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 144,
	color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.death_text = HUDSettings.death_text or {}
HUDSettings.death_text[1680] = HUDSettings.death_text[1680] or {}
HUDSettings.death_text[1680][1050] = HUDSettings.death_text[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0.3,
	pivot_align_y = "top",
	font_size = 80,
	pivot_offset_y = 0,
	z = 20,
	screen_align_x = "left",
	pivot_offset_x = 0,
	screen_offset_y = -0.25,
	pivot_align_x = "center",
	font = MenuSettings.fonts.font_gradient_100,
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.killer_name_text = HUDSettings.killer_name_text or table.clone(HUDSettings.death_text)
HUDSettings.killer_name_text[1680][1050].pivot_offset_y = -100 * SCALE_1366
HUDSettings.killer_name_text[1680][1050].font_size = 100
HUDSettings.killer_name_text[1680][1050].relative_max_width_limiter = 900
HUDSettings.death_text[1366] = HUDSettings.death_text[1366] or {}
HUDSettings.death_text[1366][768] = HUDSettings.death_text[1366][768] or table.clone(HUDSettings.death_text[1680][1050])
HUDSettings.death_text[1366][768].font_size = 65 * SCALE_1366
HUDSettings.killer_name_text[1366] = HUDSettings.killer_name_text[1366] or {}
HUDSettings.killer_name_text[1366][768] = HUDSettings.killer_name_text[1366][768] or table.clone(HUDSettings.killer_name_text[1680][1050])
HUDSettings.killer_name_text[1366][768].font_size = 85 * SCALE_1366
HUDSettings.buffs = HUDSettings.buffs or {}
HUDSettings.buffs.container = HUDSettings.buffs.container or {}
HUDSettings.buffs.container[1680] = HUDSettings.buffs.container[1680] or {}
HUDSettings.buffs.container[1680][1050] = HUDSettings.buffs.container[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 60,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "left",
	width = 480
}
HUDSettings.buffs.wounded_countdown = HUDSettings.buffs.wounded_countdown or {}
HUDSettings.buffs.wounded_countdown.container = HUDSettings.buffs.wounded_countdown.container or {}
HUDSettings.buffs.wounded_countdown.container[1680] = HUDSettings.buffs.wounded_countdown.container[1680] or {}
HUDSettings.buffs.wounded_countdown.container[1680][1050] = HUDSettings.buffs.wounded_countdown.container[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.25,
	pivot_align_x = "center"
}
HUDSettings.buffs.wounded_countdown.wounded_timer_text = HUDSettings.buffs.wounded_countdown.wounded_timer_text or {}
HUDSettings.buffs.wounded_countdown.wounded_timer_text[1680] = HUDSettings.buffs.wounded_countdown.wounded_timer_text[1680] or {}
HUDSettings.buffs.wounded_countdown.wounded_timer_text[1680][1050] = HUDSettings.buffs.wounded_countdown.wounded_timer_text[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 100,
	pivot_offset_y = -20,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.font_gradient_100,
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.buffs.wounded_countdown.wounded_bandage1_text = HUDSettings.buffs.wounded_countdown.wounded_bandage1_text or {}
HUDSettings.buffs.wounded_countdown.wounded_bandage1_text[1680] = HUDSettings.buffs.wounded_countdown.wounded_bandage1_text[1680] or {}
HUDSettings.buffs.wounded_countdown.wounded_bandage1_text[1680][1050] = HUDSettings.buffs.wounded_countdown.wounded_bandage1_text[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 36,
	pivot_offset_y = 30,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.wotr_hud_text_36,
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.buffs.wounded_countdown.wounded_bandage2_text = HUDSettings.buffs.wounded_countdown.wounded_bandage2_text or {}
HUDSettings.buffs.wounded_countdown.wounded_bandage2_text[1680] = HUDSettings.buffs.wounded_countdown.wounded_bandage2_text[1680] or {}
HUDSettings.buffs.wounded_countdown.wounded_bandage2_text[1680][1050] = HUDSettings.buffs.wounded_countdown.wounded_bandage2_text[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 36,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.wotr_hud_text_36,
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.buffs.buff = HUDSettings.buffs.buff or {}
HUDSettings.buffs.buff.container = HUDSettings.buffs.buff.container or {}
HUDSettings.buffs.buff.container[1680] = HUDSettings.buffs.buff.container[1680] or {}
HUDSettings.buffs.buff.container[1680][1050] = HUDSettings.buffs.buff.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 60,
	screen_align_x = "left",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 60
}
HUDSettings.buffs.buff.icon = HUDSettings.buffs.buff.icon or {}
HUDSettings.buffs.buff.icon[1680] = HUDSettings.buffs.buff.icon[1680] or {}
HUDSettings.buffs.buff.icon[1680][1050] = HUDSettings.buffs.buff.icon[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	screen_align_x = "center",
	texture_width = 44,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 44,
	color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.buffs.buff.level_circle = HUDSettings.buffs.buff.level_circle or {}
HUDSettings.buffs.buff.level_circle[1680] = HUDSettings.buffs.buff.level_circle[1680] or {}
HUDSettings.buffs.buff.level_circle[1680][1050] = HUDSettings.buffs.buff.level_circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0.25,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 20,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.25,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 20,
	texture_atlas_settings = HUDAtlas.buff_number_bg_small
}
HUDSettings.buffs.buff.level_text = HUDSettings.buffs.buff.level_text or {}
HUDSettings.buffs.buff.level_text[1680] = HUDSettings.buffs.buff.level_text[1680] or {}
HUDSettings.buffs.buff.level_text[1680][1050] = HUDSettings.buffs.buff.level_text[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0.24,
	pivot_align_y = "center",
	font_size = 15,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.24,
	pivot_align_x = "center",
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.buffs.buff.timer_background = HUDSettings.buffs.buff.timer_background or {}
HUDSettings.buffs.buff.timer_background[1680] = HUDSettings.buffs.buff.timer_background[1680] or {}
HUDSettings.buffs.buff.timer_background[1680][1050] = HUDSettings.buffs.buff.timer_background[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 60,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 60,
	texture_atlas_settings = HUDAtlas.cooldowncircle_small
}
HUDSettings.buffs.buff.timer = HUDSettings.buffs.buff.timer or {}
HUDSettings.buffs.buff.timer[1680] = HUDSettings.buffs.buff.timer[1680] or {}
HUDSettings.buffs.buff.timer[1680][1050] = HUDSettings.buffs.buff.timer[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture_width = 60,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 60
}
HUDSettings.debuffs = HUDSettings.debuffs or {}
HUDSettings.debuffs.container = HUDSettings.debuffs.container or {}
HUDSettings.debuffs.container[1680] = HUDSettings.debuffs.container[1680] or {}
HUDSettings.debuffs.container[1680][1050] = HUDSettings.debuffs.container[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 60,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "left",
	width = 480
}
HUDSettings.call_horse = HUDSettings.call_horse or {}
HUDSettings.call_horse.container = HUDSettings.call_horse.container or {}
HUDSettings.call_horse.container[1680] = HUDSettings.call_horse.container[1680] or {}
HUDSettings.call_horse.container[1680][1050] = HUDSettings.call_horse.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = 1,
	pivot_offset_y = 110,
	height = 100,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 100
}
HUDSettings.call_horse.icon = HUDSettings.call_horse.icon or {}
HUDSettings.call_horse.icon[1680] = HUDSettings.call_horse.icon[1680] or {}
HUDSettings.call_horse.icon[1680][1050] = HUDSettings.call_horse.icon[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	screen_align_x = "center",
	texture_width = 80,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 80
}
HUDSettings.call_horse.key_circle = HUDSettings.call_horse.key_circle or {}
HUDSettings.call_horse.key_circle[1680] = HUDSettings.call_horse.key_circle[1680] or {}
HUDSettings.call_horse.key_circle[1680][1050] = HUDSettings.call_horse.key_circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.3,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 32,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.3,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 32,
	texture_atlas_settings = HUDAtlas.buff_number_bg
}
HUDSettings.call_horse.key_circle2 = HUDSettings.call_horse.key_circle2 or {}
HUDSettings.call_horse.key_circle2[1680] = HUDSettings.call_horse.key_circle2[1680] or {}
HUDSettings.call_horse.key_circle2[1680][1050] = HUDSettings.call_horse.key_circle2[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.45,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 32,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.05,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 32,
	texture_atlas_settings = HUDAtlas.buff_number_bg
}
HUDSettings.call_horse.key_text = HUDSettings.call_horse.key_text or {}
HUDSettings.call_horse.key_text[1680] = HUDSettings.call_horse.key_text[1680] or {}
HUDSettings.call_horse.key_text[1680][1050] = HUDSettings.call_horse.key_text[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.3,
	text_max_length = 1,
	font_size = 30,
	pivot_offset_y = 0,
	pivot_align_y = "center",
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.3,
	pivot_align_x = "center",
	text_color = {
		255,
		255,
		255,
		255
	},
	font = MenuSettings.fonts.hell_shark_30
}
HUDSettings.call_horse.key_text2 = HUDSettings.call_horse.key_text2 or {}
HUDSettings.call_horse.key_text2[1680] = HUDSettings.call_horse.key_text2[1680] or {}
HUDSettings.call_horse.key_text2[1680][1050] = HUDSettings.call_horse.key_text2[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.45,
	text_max_length = 1,
	font_size = 30,
	pivot_offset_y = 0,
	pivot_align_y = "center",
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.05,
	pivot_align_x = "center",
	text_color = {
		255,
		255,
		255,
		255
	},
	font = MenuSettings.fonts.hell_shark_30
}
HUDSettings.call_horse.timer_background = HUDSettings.call_horse.timer_background or {}
HUDSettings.call_horse.timer_background[1680] = HUDSettings.call_horse.timer_background[1680] or {}
HUDSettings.call_horse.timer_background[1680][1050] = HUDSettings.call_horse.timer_background[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 100,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 100,
	texture_atlas_settings = HUDAtlas.cooldowncircle_large
}
HUDSettings.call_horse.timer = HUDSettings.call_horse.timer or {}
HUDSettings.call_horse.timer[1680] = HUDSettings.call_horse.timer[1680] or {}
HUDSettings.call_horse.timer[1680][1050] = HUDSettings.call_horse.timer[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_call_horse_cooldown_timer",
	pivot_offset_y = 0,
	texture_width = 100,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 100
}
HUDSettings.call_horse.cooldown = HUDSettings.call_horse.cooldown or {}
HUDSettings.call_horse.cooldown[1680] = HUDSettings.call_horse.cooldown[1680] or {}
HUDSettings.call_horse.cooldown[1680][1050] = HUDSettings.call_horse.cooldown[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_sprint_gradient_circle",
	pivot_offset_y = 0,
	texture_width = 70,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	texture_height = 70,
	color = {
		255,
		20,
		10,
		0
	}
}
HUDSettings.officer_buff_activation = HUDSettings.officer_buff_activation or {}
HUDSettings.officer_buff_activation.container = HUDSettings.officer_buff_activation.container or {}
HUDSettings.officer_buff_activation.container[1680] = HUDSettings.officer_buff_activation.container[1680] or {}
HUDSettings.officer_buff_activation.container[1680][1050] = HUDSettings.officer_buff_activation.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = 1,
	pivot_offset_y = 76,
	container_element_spacing_x = 130,
	screen_align_x = "center",
	height = 100,
	pivot_offset_x = 120,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 500
}
HUDSettings.officer_buff_activation.element = HUDSettings.officer_buff_activation.element or {}
HUDSettings.officer_buff_activation.element.container = HUDSettings.officer_buff_activation.element.container or {}
HUDSettings.officer_buff_activation.element.container[1680] = HUDSettings.officer_buff_activation.element.container[1680] or {}
HUDSettings.officer_buff_activation.element.container[1680][1050] = HUDSettings.officer_buff_activation.element.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 100,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 100
}
HUDSettings.officer_buff_activation.element.icon = HUDSettings.officer_buff_activation.element.icon or {}
HUDSettings.officer_buff_activation.element.icon[1680] = HUDSettings.officer_buff_activation.element.icon[1680] or {}
HUDSettings.officer_buff_activation.element.icon[1680][1050] = HUDSettings.officer_buff_activation.element.icon[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	screen_align_x = "center",
	texture_width = 80,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 80
}
HUDSettings.officer_buff_activation.element.level_circle = HUDSettings.officer_buff_activation.element.level_circle or {}
HUDSettings.officer_buff_activation.element.level_circle[1680] = HUDSettings.officer_buff_activation.element.level_circle[1680] or {}
HUDSettings.officer_buff_activation.element.level_circle[1680][1050] = HUDSettings.officer_buff_activation.element.level_circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0.3,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 32,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.3,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 32,
	texture_atlas_settings = HUDAtlas.buff_number_bg
}
HUDSettings.officer_buff_activation.element.level_text = HUDSettings.officer_buff_activation.element.level_text or {}
HUDSettings.officer_buff_activation.element.level_text[1680] = HUDSettings.officer_buff_activation.element.level_text[1680] or {}
HUDSettings.officer_buff_activation.element.level_text[1680][1050] = HUDSettings.officer_buff_activation.element.level_text[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0.3,
	pad_offset_x = 2,
	pivot_align_y = "center",
	pivot_offset_y = 0,
	font_size = 30,
	screen_align_x = "center",
	pad_offset_y = 2,
	pivot_offset_x = 0,
	screen_offset_y = -0.3,
	pivot_align_x = "center",
	font = MenuSettings.fonts.hell_shark_30,
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.officer_buff_activation.element.key_circle = HUDSettings.officer_buff_activation.element.key_circle or {}
HUDSettings.officer_buff_activation.element.key_circle[1680] = HUDSettings.officer_buff_activation.element.key_circle[1680] or {}
HUDSettings.officer_buff_activation.element.key_circle[1680][1050] = HUDSettings.officer_buff_activation.element.key_circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.3,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 32,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.3,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 32,
	texture_atlas_settings = HUDAtlas.buff_number_bg
}
HUDSettings.officer_buff_activation.element.key_circle2 = HUDSettings.officer_buff_activation.element.key_circle2 or {}
HUDSettings.officer_buff_activation.element.key_circle2[1680] = HUDSettings.officer_buff_activation.element.key_circle2[1680] or {}
HUDSettings.officer_buff_activation.element.key_circle2[1680][1050] = HUDSettings.officer_buff_activation.element.key_circle2[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.45,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 32,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.05,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 32,
	texture_atlas_settings = HUDAtlas.buff_number_bg
}
HUDSettings.officer_buff_activation.element.key_text = HUDSettings.officer_buff_activation.element.key_text or {}
HUDSettings.officer_buff_activation.element.key_text[1680] = HUDSettings.officer_buff_activation.element.key_text[1680] or {}
HUDSettings.officer_buff_activation.element.key_text[1680][1050] = HUDSettings.officer_buff_activation.element.key_text[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.3,
	pad_offset_x = 0,
	pivot_align_y = "center",
	pivot_offset_y = 0,
	font_size = 30,
	screen_align_x = "center",
	text_max_length = 1,
	pad_offset_y = 2,
	pivot_offset_x = 0,
	screen_offset_y = -0.3,
	pivot_align_x = "center",
	font = MenuSettings.fonts.hell_shark_30,
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.officer_buff_activation.element.key_text2 = HUDSettings.officer_buff_activation.element.key_text2 or {}
HUDSettings.officer_buff_activation.element.key_text2[1680] = HUDSettings.officer_buff_activation.element.key_text2[1680] or {}
HUDSettings.officer_buff_activation.element.key_text2[1680][1050] = HUDSettings.officer_buff_activation.element.key_text2[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.45,
	pad_offset_x = 0,
	pivot_align_y = "center",
	pivot_offset_y = 0,
	font_size = 30,
	screen_align_x = "center",
	text_max_length = 1,
	pad_offset_y = 2,
	pivot_offset_x = 0,
	screen_offset_y = -0.05,
	pivot_align_x = "center",
	font = MenuSettings.fonts.hell_shark_30,
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.officer_buff_activation.cooldown = HUDSettings.officer_buff_activation.cooldown or {}
HUDSettings.officer_buff_activation.cooldown[1680] = HUDSettings.officer_buff_activation.cooldown[1680] or {}
HUDSettings.officer_buff_activation.cooldown[1680][1050] = HUDSettings.officer_buff_activation.cooldown[1680][1050] or table.clone(HUDSettings.call_horse.cooldown[1680][1050])
HUDSettings.officer_buff_activation.cooldown[1680][1050].texture_buff_1 = "hud_officer_buff_activation_cooldown_timer_one"
HUDSettings.officer_buff_activation.cooldown[1680][1050].texture_buff_2 = "hud_officer_buff_activation_cooldown_timer_two"
HUDSettings.cruise_control = HUDSettings.cruise_control or {}
HUDSettings.cruise_control.container = HUDSettings.cruise_control.container or {}
HUDSettings.cruise_control.container[1680] = HUDSettings.cruise_control.container[1680] or {}
HUDSettings.cruise_control.container[1680][1050] = HUDSettings.cruise_control.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = -1,
	pivot_offset_y = 110,
	height = 100,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 100
}
HUDSettings.cruise_control.icon = HUDSettings.cruise_control.icon or {}
HUDSettings.cruise_control.icon[1680] = HUDSettings.cruise_control.icon[1680] or {}
HUDSettings.cruise_control.icon[1680][1050] = HUDSettings.cruise_control.icon[1680][1050] or table.clone(HUDSettings.call_horse.icon[1680][1050])
HUDSettings.cruise_control.icon[1680][1050].gear_textures = {
	slow = "horse_speed_slow",
	maneuver = "horse_speed_maneuver",
	fast = "horse_speed_fast",
	reverse = "horse_speed_back",
	stop = "horse_speed_stop"
}
HUDSettings.sprint = HUDSettings.sprint or {}
HUDSettings.sprint.container = HUDSettings.sprint.container or {}
HUDSettings.sprint.container[1680] = HUDSettings.sprint.container[1680] or {}
HUDSettings.sprint.container[1680][1050] = HUDSettings.sprint.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = -1,
	pivot_offset_y = 76,
	height = 100,
	screen_align_x = "center",
	pivot_offset_x = -120,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 100
}
HUDSettings.sprint.icon = HUDSettings.sprint.icon or {}
HUDSettings.sprint.icon[1680] = HUDSettings.sprint.icon[1680] or {}
HUDSettings.sprint.icon[1680][1050] = HUDSettings.sprint.icon[1680][1050] or table.clone(HUDSettings.call_horse.icon[1680][1050])
HUDSettings.sprint.key_circle = HUDSettings.sprint.key_circle or {}
HUDSettings.sprint.key_circle[1680] = HUDSettings.sprint.key_circle[1680] or {}
HUDSettings.sprint.key_circle[1680][1050] = HUDSettings.sprint.key_circle[1680][1050] or table.clone(HUDSettings.call_horse.key_circle[1680][1050])
HUDSettings.sprint.key_text = HUDSettings.sprint.key_text or {}
HUDSettings.sprint.key_text[1680] = HUDSettings.sprint.key_text[1680] or {}
HUDSettings.sprint.key_text[1680][1050] = HUDSettings.sprint.key_text[1680][1050] or table.clone(HUDSettings.call_horse.key_text[1680][1050])
HUDSettings.sprint.timer_background = HUDSettings.sprint.timer_background or {}
HUDSettings.sprint.timer_background[1680] = HUDSettings.sprint.timer_background[1680] or {}
HUDSettings.sprint.timer_background[1680][1050] = HUDSettings.sprint.timer_background[1680][1050] or table.clone(HUDSettings.call_horse.timer_background[1680][1050])
HUDSettings.sprint.timer = HUDSettings.sprint.timer or {}
HUDSettings.sprint.timer[1680] = HUDSettings.sprint.timer[1680] or {}
HUDSettings.sprint.timer[1680][1050] = HUDSettings.sprint.timer[1680][1050] or table.clone(HUDSettings.call_horse.timer[1680][1050])
HUDSettings.sprint.cooldown = HUDSettings.sprint.cooldown or {}
HUDSettings.sprint.cooldown[1680] = HUDSettings.sprint.cooldown[1680] or {}
HUDSettings.sprint.cooldown[1680][1050] = HUDSettings.sprint.cooldown[1680][1050] or table.clone(HUDSettings.call_horse.cooldown[1680][1050])
HUDSettings.mount_charge = HUDSettings.mount_charge or {}
HUDSettings.mount_charge.container = HUDSettings.mount_charge.container or {}
HUDSettings.mount_charge.container[1680] = HUDSettings.mount_charge.container[1680] or {}
HUDSettings.mount_charge.container[1680][1050] = HUDSettings.mount_charge.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = -1,
	pivot_offset_y = 76,
	height = 100,
	screen_align_x = "center",
	pivot_offset_x = -120,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 100
}
HUDSettings.mount_charge.icon = HUDSettings.mount_charge.icon or {}
HUDSettings.mount_charge.icon[1680] = HUDSettings.mount_charge.icon[1680] or {}
HUDSettings.mount_charge.icon[1680][1050] = HUDSettings.mount_charge.icon[1680][1050] or table.clone(HUDSettings.call_horse.icon[1680][1050])
HUDSettings.mount_charge.key_circle = HUDSettings.mount_charge.key_circle or {}
HUDSettings.mount_charge.key_circle[1680] = HUDSettings.mount_charge.key_circle[1680] or {}
HUDSettings.mount_charge.key_circle[1680][1050] = HUDSettings.mount_charge.key_circle[1680][1050] or table.clone(HUDSettings.call_horse.key_circle[1680][1050])
HUDSettings.mount_charge.key_text = HUDSettings.mount_charge.key_text or {}
HUDSettings.mount_charge.key_text[1680] = HUDSettings.mount_charge.key_text[1680] or {}
HUDSettings.mount_charge.key_text[1680][1050] = HUDSettings.mount_charge.key_text[1680][1050] or table.clone(HUDSettings.call_horse.key_text[1680][1050])
HUDSettings.mount_charge.timer_background = HUDSettings.mount_charge.timer_background or {}
HUDSettings.mount_charge.timer_background[1680] = HUDSettings.mount_charge.timer_background[1680] or {}
HUDSettings.mount_charge.timer_background[1680][1050] = HUDSettings.mount_charge.timer_background[1680][1050] or table.clone(HUDSettings.call_horse.timer_background[1680][1050])
HUDSettings.mount_charge.timer = HUDSettings.mount_charge.timer or {}
HUDSettings.mount_charge.timer[1680] = HUDSettings.mount_charge.timer[1680] or {}
HUDSettings.mount_charge.timer[1680][1050] = HUDSettings.mount_charge.timer[1680][1050] or table.clone(HUDSettings.call_horse.timer[1680][1050])
HUDSettings.mount_charge.cooldown = HUDSettings.mount_charge.cooldown or {}
HUDSettings.mount_charge.cooldown[1680] = HUDSettings.mount_charge.cooldown[1680] or {}
HUDSettings.mount_charge.cooldown[1680][1050] = HUDSettings.mount_charge.cooldown[1680][1050] or table.clone(HUDSettings.call_horse.cooldown[1680][1050])
HUDSettings.tagging_activation = HUDSettings.tagging_activation or {}
HUDSettings.tagging_activation.container = HUDSettings.tagging_activation.container or {}
HUDSettings.tagging_activation.container[1680] = HUDSettings.tagging_activation.container[1680] or {}
HUDSettings.tagging_activation.container[1680][1050] = HUDSettings.tagging_activation.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = -1,
	pivot_offset_y = 76,
	height = 100,
	screen_align_x = "center",
	pivot_offset_x = -250,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 100
}
HUDSettings.tagging_activation.icon = HUDSettings.tagging_activation.icon or {}
HUDSettings.tagging_activation.icon[1680] = HUDSettings.tagging_activation.icon[1680] or {}
HUDSettings.tagging_activation.icon[1680][1050] = HUDSettings.tagging_activation.icon[1680][1050] or table.clone(HUDSettings.call_horse.icon[1680][1050])
HUDSettings.tagging_activation.key_circle = HUDSettings.tagging_activation.key_circle or {}
HUDSettings.tagging_activation.key_circle[1680] = HUDSettings.tagging_activation.key_circle[1680] or {}
HUDSettings.tagging_activation.key_circle[1680][1050] = HUDSettings.tagging_activation.key_circle[1680][1050] or table.clone(HUDSettings.call_horse.key_circle[1680][1050])
HUDSettings.tagging_activation.key_text = HUDSettings.tagging_activation.key_text or {}
HUDSettings.tagging_activation.key_text[1680] = HUDSettings.tagging_activation.key_text[1680] or {}
HUDSettings.tagging_activation.key_text[1680][1050] = HUDSettings.tagging_activation.key_text[1680][1050] or table.clone(HUDSettings.call_horse.key_text[1680][1050])
HUDSettings.tagging_activation.timer_background = HUDSettings.tagging_activation.timer_background or {}
HUDSettings.tagging_activation.timer_background[1680] = HUDSettings.tagging_activation.timer_background[1680] or {}
HUDSettings.tagging_activation.timer_background[1680][1050] = HUDSettings.tagging_activation.timer_background[1680][1050] or table.clone(HUDSettings.call_horse.timer_background[1680][1050])
HUDSettings.tagging_activation.timer = HUDSettings.tagging_activation.timer or {}
HUDSettings.tagging_activation.timer[1680] = HUDSettings.tagging_activation.timer[1680] or {}
HUDSettings.tagging_activation.timer[1680][1050] = HUDSettings.tagging_activation.timer[1680][1050] or table.clone(HUDSettings.call_horse.timer[1680][1050])
HUDSettings.tagging_activation.cooldown = HUDSettings.tagging_activation.cooldown or {}
HUDSettings.tagging_activation.cooldown[1680] = HUDSettings.tagging_activation.cooldown[1680] or {}
HUDSettings.tagging_activation.cooldown[1680][1050] = HUDSettings.tagging_activation.cooldown[1680][1050] or table.clone(HUDSettings.call_horse.cooldown[1680][1050])
HUDSettings.xp_and_coins = HUDSettings.xp_and_coins or {}
HUDSettings.xp_and_coins[1680] = HUDSettings.xp_and_coins[1680] or {}
HUDSettings.xp_and_coins[1680][1050] = HUDSettings.xp_and_coins[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0.1,
	pivot_align_y = "bottom",
	font_size = 32,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.2,
	pivot_align_x = "left",
	font = MenuSettings.fonts.wotr_hud_text_36,
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.tagging = HUDSettings.tagging or {}
HUDSettings.tagging.container = HUDSettings.tagging.container or {}
HUDSettings.tagging.container[1680] = HUDSettings.tagging.container[1680] or {}
HUDSettings.tagging.container[1680][1050] = HUDSettings.tagging.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = -1,
	pivot_offset_y = 0,
	height = 32,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 32
}
HUDSettings.tagging.loading_circle = HUDSettings.tagging.loading_circle or {}
HUDSettings.tagging.loading_circle[1680] = HUDSettings.tagging.loading_circle[1680] or {}
HUDSettings.tagging.loading_circle[1680][1050] = HUDSettings.tagging.loading_circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_hit_marker",
	pivot_offset_y = 0,
	texture_width = 32,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 32
}
HUDSettings.damage_numbers = HUDSettings.damage_numbers or {}
HUDSettings.damage_numbers.container = HUDSettings.damage_numbers.container or {}
HUDSettings.damage_numbers.container[1680] = HUDSettings.damage_numbers.container[1680] or {}
HUDSettings.damage_numbers.container[1680][1050] = HUDSettings.damage_numbers.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 0,
	pivot_offset_y = 0,
	height = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 0
}
HUDSettings.damage_numbers.number = HUDSettings.damage_numbers.number or {}
HUDSettings.damage_numbers.number[1680] = HUDSettings.damage_numbers.number[1680] or {}
HUDSettings.damage_numbers.number[1680][1050] = HUDSettings.damage_numbers.number[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	pivot_align_y = "center",
	screen_align_x = "center",
	pivot_offset_y = 0
}
HUDSettings.interaction = HUDSettings.interaction or {}
HUDSettings.interaction.container = HUDSettings.interaction.container or {}
HUDSettings.interaction.container[1680] = HUDSettings.interaction.container[1680] or {}
HUDSettings.interaction.container[1680][1050] = HUDSettings.interaction.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = 1,
	pivot_offset_y = 260,
	height = 40,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 400
}
HUDSettings.interaction.objective_bar = HUDSettings.interaction.objective_bar or {}
HUDSettings.interaction.objective_bar[1680] = HUDSettings.interaction.objective_bar[1680] or {}
HUDSettings.interaction.objective_bar[1680][1050] = HUDSettings.interaction.objective_bar[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	bar_height = 16,
	pivot_offset_y = 0,
	texture = "hud_interaction_bar_filling",
	screen_align_x = "center",
	texture_2 = "hud_interaction_bar_filling",
	texture_offset_x = 1,
	texture_offset_y = 1,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	bar_width = 396,
	background_texture = "hud_interaction_bar_background"
}
HUDSettings.ammo_counter = HUDSettings.ammo_counter or {}
HUDSettings.ammo_counter.container = HUDSettings.ammo_counter.container or {}
HUDSettings.ammo_counter.container[1680] = HUDSettings.ammo_counter.container[1680] or {}
HUDSettings.ammo_counter.container[1680][1050] = HUDSettings.ammo_counter.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0.04,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 60,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.09,
	pivot_align_x = "center",
	width = 60
}
HUDSettings.ammo_counter.ammo_text = HUDSettings.ammo_counter.ammo_text or {}
HUDSettings.ammo_counter.ammo_text[1680] = HUDSettings.ammo_counter.ammo_text[1680] or {}
HUDSettings.ammo_counter.ammo_text[1680][1050] = HUDSettings.ammo_counter.ammo_text[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.034,
	pivot_align_y = "center",
	font_size = 30,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.ammo_counter.timer_background = HUDSettings.ammo_counter.timer_background or {}
HUDSettings.ammo_counter.timer_background[1680] = HUDSettings.ammo_counter.timer_background[1680] or {}
HUDSettings.ammo_counter.timer_background[1680][1050] = HUDSettings.ammo_counter.timer_background[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "center",
	pivot_offset_y = 0,
	texture_width = 60,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 60,
	texture_atlas_settings = HUDAtlas.cooldowncircle_small
}
HUDSettings.ammo_counter.timer = HUDSettings.ammo_counter.timer or {}
HUDSettings.ammo_counter.timer[1680] = HUDSettings.ammo_counter.timer[1680] or {}
HUDSettings.ammo_counter.timer[1680][1050] = HUDSettings.ammo_counter.timer[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_ammo_cooldown_timer",
	pivot_offset_y = 0,
	texture_width = 60,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 60
}
HUDSettings.hit_indicator = HUDSettings.hit_indicator or {}
HUDSettings.hit_indicator[1680] = HUDSettings.hit_indicator[1680] or {}
HUDSettings.hit_indicator[1680][1050] = HUDSettings.hit_indicator[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hit_indicator",
	pivot_offset_y = 0,
	texture_width = 512,
	screen_align_x = "center",
	z = 1,
	pivot_offset_x = 0,
	screen_offset_y = -0.37037037037037035,
	pivot_align_x = "center",
	texture_height = 256,
	color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.pose_charge = HUDSettings.pose_charge or {}
HUDSettings.pose_charge.container = HUDSettings.pose_charge.container or {}
HUDSettings.pose_charge.container[1680] = HUDSettings.pose_charge.container[1680] or {}
HUDSettings.pose_charge.container[1680][1050] = HUDSettings.pose_charge.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	height = 300,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 300,
	background_color = {
		0,
		0,
		0,
		0
	}
}
HUDSettings.pose_charge.marker = HUDSettings.pose_charge.marker or {}
HUDSettings.pose_charge.marker[1680] = HUDSettings.pose_charge.marker[1680] or {}
HUDSettings.pose_charge.marker[1680][1050] = HUDSettings.pose_charge.marker[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_pose_charge_marker",
	pivot_offset_y = 0,
	texture_width = 12,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 12,
	color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.pose_charge.gradient_circle = HUDSettings.pose_charge.gradient_circle or {}
HUDSettings.pose_charge.gradient_circle[1680] = HUDSettings.pose_charge.gradient_circle[1680] or {}
HUDSettings.pose_charge.gradient_circle[1680][1050] = HUDSettings.pose_charge.gradient_circle[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_pose_charge_gradient_circle",
	pivot_offset_y = 0,
	texture_width = 300,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 300,
	color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.pose_charge.circle_segment = HUDSettings.pose_charge.circle_segment or {}
HUDSettings.pose_charge.circle_segment[1680] = HUDSettings.pose_charge.circle_segment[1680] or {}
HUDSettings.pose_charge.circle_segment[1680][1050] = HUDSettings.pose_charge.circle_segment[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_pose_charge_circle_segment",
	pivot_offset_y = 0,
	texture_width = 240,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 128,
	color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.world_icons = HUDSettings.world_icons or {}
HUDSettings.world_icons.player = HUDSettings.world_icons.player or {}
HUDSettings.world_icons.player[1680] = HUDSettings.world_icons.player[1680] or {}
HUDSettings.world_icons.player[1680][1050] = HUDSettings.world_icons.player[1680][1050] or {}
HUDSettings.world_icons.player[1680][1050].attention_screen_zone = HUDSettings.world_icons.player[1680][1050].attention_screen_zone or {}
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.font_size = 26
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.texture_scale = 0.5
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.texture_atlas = "hud_atlas"
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.texture_wounded = HUDAtlas.wounded_inhud
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.texture_knocked_down = HUDAtlas.knocked_down_inhud
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.texture_dead = HUDAtlas.dead_inhud
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.max_scale = 0.7
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.max_scale_distance = 0
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.min_scale = 0.2
HUDSettings.world_icons.player[1680][1050].attention_screen_zone.min_scale_distance = 100
HUDSettings.world_icons.player[1680][1050].default_screen_zone = HUDSettings.world_icons.player[1680][1050].default_screen_zone or {}
HUDSettings.world_icons.player[1680][1050].default_screen_zone.font_size = 26
HUDSettings.world_icons.player[1680][1050].default_screen_zone.texture_scale = 0.5
HUDSettings.world_icons.player[1680][1050].default_screen_zone.texture_atlas = "hud_atlas"
HUDSettings.world_icons.player[1680][1050].default_screen_zone.texture_wounded = HUDAtlas.wounded_inhud
HUDSettings.world_icons.player[1680][1050].default_screen_zone.texture_knocked_down = HUDAtlas.knocked_down_inhud
HUDSettings.world_icons.player[1680][1050].default_screen_zone.texture_dead = HUDAtlas.dead_inhud
HUDSettings.world_icons.player[1680][1050].default_screen_zone.max_scale = 0.7
HUDSettings.world_icons.player[1680][1050].default_screen_zone.max_scale_distance = 0
HUDSettings.world_icons.player[1680][1050].default_screen_zone.min_scale = 0.2
HUDSettings.world_icons.player[1680][1050].default_screen_zone.min_scale_distance = 50
HUDSettings.world_icons.local_player = HUDSettings.world_icons.local_player or {}
HUDSettings.world_icons.local_player[1680] = HUDSettings.world_icons.local_player[1680] or {}
HUDSettings.world_icons.local_player[1680][1050] = HUDSettings.world_icons.local_player[1680][1050] or {}
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone = HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone or {}
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.font_size = 26
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.texture_scale = 1
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.texture_atlas = "hud_atlas"
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.texture_wounded = HUDAtlas.wounded_inhud
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.texture_knocked_down = HUDAtlas.knocked_down_inhud
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.texture_dead = HUDAtlas.dead_inhud
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.max_scale = 1
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.max_scale_distance = 0
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.min_scale = 1
HUDSettings.world_icons.local_player[1680][1050].attention_screen_zone.min_scale_distance = 100
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone = HUDSettings.world_icons.local_player[1680][1050].default_screen_zone or {}
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.font_size = 26
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.texture_scale = 1
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.texture_atlas = "hud_atlas"
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.texture_wounded = HUDAtlas.wounded_inhud
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.texture_knocked_down = HUDAtlas.knocked_down_inhud
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.texture_dead = HUDAtlas.dead_inhud
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.max_scale = 1
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.max_scale_distance = 0
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.min_scale = 1
HUDSettings.world_icons.local_player[1680][1050].default_screen_zone.min_scale_distance = 50
HUDSettings.world_icons.capture_flag = HUDSettings.world_icons.capture_flag or {}
HUDSettings.world_icons.capture_flag[1680] = HUDSettings.world_icons.capture_flag[1680] or {}
HUDSettings.world_icons.capture_flag[1680][1050] = HUDSettings.world_icons.capture_flag[1680][1050] or {
	attention_screen_zone = {
		min_scale_distance = 200,
		min_scale = 0.5,
		texture_atlas = "hud_atlas",
		max_scale_distance = 20,
		max_scale = 1,
		texture_func = function(blackboard, player)
			return HUDAtlas.hud_flag
		end
	},
	default_screen_zone = {
		min_scale_distance = 200,
		min_scale = 0.5,
		texture_atlas = "hud_atlas",
		max_scale_distance = 20,
		max_scale = 1,
		texture_func = function(blackboard, player)
			return HUDAtlas.hud_flag
		end
	},
	clamped_screen_zone = {
		texture = "mockup_hud_flag_icon",
		texture_atlas = "hud_atlas",
		scale = 1,
		texture_func = function(blackboard, player)
			return HUDAtlas.hud_flag
		end
	},
	spawn_map = {
		texture = "mockup_hud_flag_icon",
		texture_atlas = "hud_atlas",
		scale = 1,
		texture_func = function(blackboard, player)
			return HUDAtlas.hud_flag
		end
	}
}
HUDSettings.world_icons.grail_plant_point = HUDSettings.world_icons.grail_plant_point or {}
HUDSettings.world_icons.grail_plant_point[1680] = HUDSettings.world_icons.grail_plant_point[1680] or {}
HUDSettings.world_icons.grail_plant_point[1680][1050] = HUDSettings.world_icons.grail_plant_point[1680][1050] or {
	attention_screen_zone = {
		min_scale_distance = 200,
		min_scale = 0.5,
		texture_atlas = "hud_atlas",
		max_scale_distance = 20,
		max_scale = 1,
		texture_func = function(blackboard, player)
			local player_unit = player.player_unit
			local carried_flag = Unit.alive(player_unit) and ScriptUnit.extension(player_unit, "locomotion_system").carried_flag

			return carried_flag and player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_plant_point or nil
		end
	},
	default_screen_zone = {
		min_scale_distance = 200,
		min_scale = 0.5,
		texture_atlas = "hud_atlas",
		max_scale_distance = 20,
		max_scale = 1,
		texture_func = function(blackboard, player)
			local player_unit = player.player_unit
			local carried_flag = Unit.alive(player_unit) and ScriptUnit.extension(player_unit, "locomotion_system").carried_flag

			return carried_flag and player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_plant_point or nil
		end
	},
	clamped_screen_zone = {
		scale = 1,
		texture_atlas = "hud_atlas",
		texture_func = function(blackboard, player)
			local player_unit = player.player_unit
			local carried_flag = Unit.alive(player_unit) and ScriptUnit.extension(player_unit, "locomotion_system").carried_flag

			return carried_flag and player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_plant_point or nil
		end
	},
	spawn_map = {
		scale = 1,
		texture_atlas = "hud_atlas",
		texture_func = function(blackboard, player)
			local player_unit = player.player_unit
			local carried_flag = Unit.alive(player_unit) and ScriptUnit.extension(player_unit, "locomotion_system").carried_flag

			return carried_flag and player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_plant_point or nil
		end
	}
}
HUDSettings.world_icons.objective_circle = HUDSettings.world_icons.objective_circle or {}
HUDSettings.world_icons.objective_circle[1680] = HUDSettings.world_icons.objective_circle[1680] or {}
HUDSettings.world_icons.objective_circle[1680][1050] = HUDSettings.world_icons.objective_circle[1680][1050] or {
	attention_screen_zone = {
		min_scale_distance = 200,
		min_scale = 0.5,
		texture_atlas = "hud_atlas",
		show_progress = true,
		max_scale_distance = 20,
		max_scale = 1,
		texture_func = function(blackboard, player)
			return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_circle or nil
		end
	},
	default_screen_zone = {
		min_scale_distance = 200,
		min_scale = 0.5,
		texture_atlas = "hud_atlas",
		show_progress = true,
		max_scale_distance = 20,
		max_scale = 1,
		texture_func = function(blackboard, player)
			return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_circle or nil
		end
	},
	clamped_screen_zone = {
		scale = 1,
		texture_atlas = "hud_atlas",
		texture_func = function(blackboard, player)
			return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_circle or nil
		end
	},
	spawn_map = {
		scale = 1,
		texture_atlas = "hud_atlas",
		show_progress = true,
		texture_func = function(blackboard, player)
			return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_circle or nil
		end
	}
}
HUDSettings.world_icons.blank_icon = HUDSettings.world_icons.blank_icon or {}
HUDSettings.world_icons.blank_icon[1680] = HUDSettings.world_icons.blank_icon[1680] or {}
HUDSettings.world_icons.blank_icon[1680][1050] = HUDSettings.world_icons.blank_icon[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.blank_icon[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return HUDAtlas.hud_blank_icon
end
HUDSettings.world_icons.blank_icon[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return HUDAtlas.hud_blank_icon
end
HUDSettings.world_icons.blank_icon[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return HUDAtlas.hud_blank_icon
end
HUDSettings.world_icons.blank_icon[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return HUDAtlas.hud_blank_icon
end
HUDSettings.world_icons.interactable_destructable_gate = HUDSettings.world_icons.interactable_destructable_gate or {}
HUDSettings.world_icons.interactable_destructable_gate[1680] = HUDSettings.world_icons.interactable_destructable_gate[1680] or {}
HUDSettings.world_icons.interactable_destructable_gate[1680][1050] = HUDSettings.world_icons.interactable_destructable_gate[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].attention_screen_zone.texture_func = function(blackboard, player, objective_unit, world)
	local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
	local distance = Vector3.length(Unit.world_position(objective_unit, 0) - camera_pos)
	local show = distance < 20 and distance > 3

	if show then
		local team_side = player.team.side

		if blackboard.active_team_sides[team_side] then
			return HUDAtlas.open_gate_icon
		elseif blackboard.active_team_sides_destructible[team_side] and blackboard.destructible_enabled then
			return HUDAtlas.break_gate_icon
		end
	end
end
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].attention_screen_zone.max_scale = 0.75
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].attention_screen_zone.min_scale = 0.25
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].attention_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].attention_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].default_screen_zone.texture_func = function(blackboard, player, objective_unit, world)
	local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
	local distance = Vector3.length(Unit.world_position(objective_unit, 0) - camera_pos)
	local show = distance < 20 and distance > 3

	if show then
		local team_side = player.team.side

		if blackboard.active_team_sides[team_side] then
			return HUDAtlas.open_gate_icon
		elseif blackboard.active_team_sides_destructible[team_side] and blackboard.destructible_enabled then
			return HUDAtlas.break_gate_icon
		end
	end
end
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].default_screen_zone.max_scale = 0.75
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].default_screen_zone.min_scale = 0.25
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].default_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].default_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return nil
end
HUDSettings.world_icons.interactable_destructable_gate[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return
end
HUDSettings.world_icons.interactable_destructable_gate_2 = HUDSettings.world_icons.interactable_destructable_gate_2 or {}
HUDSettings.world_icons.interactable_destructable_gate_2[1680] = HUDSettings.world_icons.interactable_destructable_gate_2[1680] or {}
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050] = HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].default_screen_zone.texture_func = function(blackboard, player, objective_unit, world)
	local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
	local distance = Vector3.length(Unit.world_position(objective_unit, 0) - camera_pos)
	local show = distance > 20 and distance < 50

	if show then
		local team_side = player.team.side

		if blackboard.active_team_sides[team_side] then
			return HUDAtlas.hud_objective_diamond
		end
	else
		return nil
	end
end
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].default_screen_zone.max_scale = 0.5
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].default_screen_zone.min_scale = 0.5
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].default_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].default_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return
end
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].attention_screen_zone.max_scale = 0.5
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].attention_screen_zone.min_scale = 0.5
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].attention_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].attention_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.interactable_destructable_gate_2[1680][1050].attention_screen_zone.texture_func = function(blackboard, player, objective_unit, world)
	local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
	local distance = Vector3.length(Unit.world_position(objective_unit, 0) - camera_pos)
	local show = distance > 20 and distance < 50

	if show then
		local team_side = player.team.side

		if blackboard.active_team_sides[team_side] then
			return HUDAtlas.hud_objective_diamond
		end
	else
		return nil
	end
end
HUDSettings.world_icons.objective_cart = HUDSettings.world_icons.objective_cart or {}
HUDSettings.world_icons.objective_cart[1680] = HUDSettings.world_icons.objective_cart[1680] or {}
HUDSettings.world_icons.objective_cart[1680][1050] = HUDSettings.world_icons.objective_cart[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.objective_cart[1680][1050].attention_screen_zone.texture_func = function(blackboard, player, objective_unit, world)
	local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
	local distance = Vector3.length(Unit.world_position(objective_unit, 0) - camera_pos)
	local show = distance > 10

	if show then
		return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.cart_icon or nil
	else
		return nil
	end
end
HUDSettings.world_icons.objective_cart[1680][1050].attention_screen_zone.max_scale = 1
HUDSettings.world_icons.objective_cart[1680][1050].attention_screen_zone.min_scale = 1
HUDSettings.world_icons.objective_cart[1680][1050].attention_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.objective_cart[1680][1050].attention_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.objective_cart[1680][1050].default_screen_zone.texture_func = function(blackboard, player, objective_unit, world)
	local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
	local distance = Vector3.length(Unit.world_position(objective_unit, 0) - camera_pos)
	local show = distance > 10

	if show then
		return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.cart_icon or nil
	else
		return nil
	end
end
HUDSettings.world_icons.objective_cart[1680][1050].default_screen_zone.max_scale = 1
HUDSettings.world_icons.objective_cart[1680][1050].default_screen_zone.min_scale = 1
HUDSettings.world_icons.objective_cart[1680][1050].default_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.objective_cart[1680][1050].default_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.objective_cart[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.cart_icon or nil
end
HUDSettings.world_icons.objective_cart[1680][1050].clamped_screen_zone.scale = 1
HUDSettings.world_icons.objective_cart[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.cart_icon or nil
end
HUDSettings.world_icons.objective_cart[1680][1050].spawn_map.scale = 1
HUDSettings.world_icons.ladder_objective = HUDSettings.world_icons.ladder_objective or {}
HUDSettings.world_icons.ladder_objective[1680] = HUDSettings.world_icons.ladder_objective[1680] or {}
HUDSettings.world_icons.ladder_objective[1680][1050] = HUDSettings.world_icons.ladder_objective[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.ladder_objective[1680][1050].attention_screen_zone.texture_func = function()
	return HUDAtlas.ladder_objective
end
HUDSettings.world_icons.ladder_objective[1680][1050].attention_screen_zone.max_scale = 1
HUDSettings.world_icons.ladder_objective[1680][1050].attention_screen_zone.min_scale = 0.25
HUDSettings.world_icons.ladder_objective[1680][1050].attention_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.ladder_objective[1680][1050].attention_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.ladder_objective[1680][1050].avoid_menu_rendering = true
HUDSettings.world_icons.ladder_objective[1680][1050].default_screen_zone.texture_func = function(blackboard, player, objective_unit, world)
	local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
	local show = Vector3.length(Unit.world_position(objective_unit, 0) - camera_pos) < 10

	if show then
		return HUDAtlas.ladder_objective
	else
		return nil
	end
end
HUDSettings.world_icons.ladder_objective[1680][1050].default_screen_zone.max_scale = 1
HUDSettings.world_icons.ladder_objective[1680][1050].default_screen_zone.min_scale = 0.25
HUDSettings.world_icons.ladder_objective[1680][1050].default_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.ladder_objective[1680][1050].default_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.ladder_objective[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return
end
HUDSettings.world_icons.ladder_objective[1680][1050].spawn_map.texture_func = function()
	return nil
end
HUDSettings.world_icons.ladder_objective[1680][1050].spawn_map.scale = 0.25
HUDSettings.world_icons.ladder_objective_2 = HUDSettings.world_icons.ladder_objective_2 or {}
HUDSettings.world_icons.ladder_objective_2[1680] = HUDSettings.world_icons.ladder_objective_2[1680] or {}
HUDSettings.world_icons.ladder_objective_2[1680][1050] = HUDSettings.world_icons.ladder_objective_2[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.ladder_objective_2[1680][1050].default_screen_zone.texture_func = function(blackboard, player, objective_unit, world)
	local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
	local show = Vector3.length(Unit.world_position(objective_unit, 0) - camera_pos) < 10

	if show then
		return nil
	else
		return HUDAtlas.hud_objective_diamond
	end
end
HUDSettings.world_icons.ladder_objective_2[1680][1050].default_screen_zone.max_scale = 0.5
HUDSettings.world_icons.ladder_objective_2[1680][1050].default_screen_zone.min_scale = 0.5
HUDSettings.world_icons.ladder_objective_2[1680][1050].default_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.ladder_objective_2[1680][1050].default_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.ladder_objective_2[1680][1050].attention_screen_zone.max_scale = 0.5
HUDSettings.world_icons.ladder_objective_2[1680][1050].attention_screen_zone.min_scale = 0.5
HUDSettings.world_icons.ladder_objective_2[1680][1050].attention_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.ladder_objective_2[1680][1050].attention_screen_zone.min_scale_distance = 20
HUDSettings.world_icons.ladder_objective_2[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return
end
HUDSettings.world_icons.objective_diamond = HUDSettings.world_icons.objective_diamond or {}
HUDSettings.world_icons.objective_diamond[1680] = HUDSettings.world_icons.objective_diamond[1680] or {}
HUDSettings.world_icons.objective_diamond[1680][1050] = HUDSettings.world_icons.objective_diamond[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.objective_diamond[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_diamond or nil
end
HUDSettings.world_icons.objective_diamond[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_diamond or nil
end
HUDSettings.world_icons.objective_diamond[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_diamond or nil
end
HUDSettings.world_icons.objective_diamond[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_diamond or nil
end
HUDSettings.world_icons.objective_square = HUDSettings.world_icons.objective_square or {}
HUDSettings.world_icons.objective_square[1680] = HUDSettings.world_icons.objective_square[1680] or {}
HUDSettings.world_icons.objective_square[1680][1050] = HUDSettings.world_icons.objective_square[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.objective_square[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_square or nil
end
HUDSettings.world_icons.objective_square[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_square or nil
end
HUDSettings.world_icons.objective_square[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_square or nil
end
HUDSettings.world_icons.objective_square[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_square or nil
end
HUDSettings.world_icons.objective_triangle = HUDSettings.world_icons.objective_triangle or {}
HUDSettings.world_icons.objective_triangle[1680] = HUDSettings.world_icons.objective_triangle[1680] or {}
HUDSettings.world_icons.objective_triangle[1680][1050] = HUDSettings.world_icons.objective_triangle[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.objective_triangle[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_triangle or nil
end
HUDSettings.world_icons.objective_triangle[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_triangle or nil
end
HUDSettings.world_icons.objective_triangle[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_triangle or nil
end
HUDSettings.world_icons.objective_triangle[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_triangle or nil
end
HUDSettings.world_icons.objective_a = HUDSettings.world_icons.objective_a or {}
HUDSettings.world_icons.objective_a[1680] = HUDSettings.world_icons.objective_a[1680] or {}
HUDSettings.world_icons.objective_a[1680][1050] = HUDSettings.world_icons.objective_a[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.objective_a[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_a or nil
end
HUDSettings.world_icons.objective_a[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_a or nil
end
HUDSettings.world_icons.objective_a[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_a or nil
end
HUDSettings.world_icons.objective_a[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_a or nil
end
HUDSettings.world_icons.objective_a[1680][1050].attention_screen_zone.show_progress = false
HUDSettings.world_icons.objective_a[1680][1050].clamped_screen_zone.show_progress = false
HUDSettings.world_icons.objective_a[1680][1050].spawn_map.show_progress = false
HUDSettings.world_icons.objective_a[1680][1050].default_screen_zone.show_progress = false
HUDSettings.world_icons.objective_b = HUDSettings.world_icons.objective_b or {}
HUDSettings.world_icons.objective_b[1680] = HUDSettings.world_icons.objective_b[1680] or {}
HUDSettings.world_icons.objective_b[1680][1050] = HUDSettings.world_icons.objective_b[1680][1050] or table.clone(HUDSettings.world_icons.objective_a[1680][1050])
HUDSettings.world_icons.objective_b[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_b or nil
end
HUDSettings.world_icons.objective_b[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_b or nil
end
HUDSettings.world_icons.objective_b[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_b or nil
end
HUDSettings.world_icons.objective_b[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_b or nil
end
HUDSettings.world_icons.objective_c = HUDSettings.world_icons.objective_c or {}
HUDSettings.world_icons.objective_c[1680] = HUDSettings.world_icons.objective_c[1680] or {}
HUDSettings.world_icons.objective_c[1680][1050] = HUDSettings.world_icons.objective_c[1680][1050] or table.clone(HUDSettings.world_icons.objective_a[1680][1050])
HUDSettings.world_icons.objective_c[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_c or nil
end
HUDSettings.world_icons.objective_c[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_c or nil
end
HUDSettings.world_icons.objective_c[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_c or nil
end
HUDSettings.world_icons.objective_c[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_c or nil
end
HUDSettings.world_icons.objective_d = HUDSettings.world_icons.objective_d or {}
HUDSettings.world_icons.objective_d[1680] = HUDSettings.world_icons.objective_d[1680] or {}
HUDSettings.world_icons.objective_d[1680][1050] = HUDSettings.world_icons.objective_d[1680][1050] or table.clone(HUDSettings.world_icons.objective_a[1680][1050])
HUDSettings.world_icons.objective_d[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_d or nil
end
HUDSettings.world_icons.objective_d[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_d or nil
end
HUDSettings.world_icons.objective_d[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_d or nil
end
HUDSettings.world_icons.objective_d[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_d or nil
end
HUDSettings.world_icons.objective_e = HUDSettings.world_icons.objective_e or {}
HUDSettings.world_icons.objective_e[1680] = HUDSettings.world_icons.objective_e[1680] or {}
HUDSettings.world_icons.objective_e[1680][1050] = HUDSettings.world_icons.objective_e[1680][1050] or table.clone(HUDSettings.world_icons.objective_a[1680][1050])
HUDSettings.world_icons.objective_e[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_e or nil
end
HUDSettings.world_icons.objective_e[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_e or nil
end
HUDSettings.world_icons.objective_e[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_e or nil
end
HUDSettings.world_icons.objective_e[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_e or nil
end
HUDSettings.world_icons.objective_f = HUDSettings.world_icons.objective_f or {}
HUDSettings.world_icons.objective_f[1680] = HUDSettings.world_icons.objective_f[1680] or {}
HUDSettings.world_icons.objective_f[1680][1050] = HUDSettings.world_icons.objective_f[1680][1050] or table.clone(HUDSettings.world_icons.objective_a[1680][1050])
HUDSettings.world_icons.objective_f[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_f or nil
end
HUDSettings.world_icons.objective_f[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_f or nil
end
HUDSettings.world_icons.objective_f[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_f or nil
end
HUDSettings.world_icons.objective_f[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_f or nil
end
HUDSettings.world_icons.objective_g = HUDSettings.world_icons.objective_g or {}
HUDSettings.world_icons.objective_g[1680] = HUDSettings.world_icons.objective_g[1680] or {}
HUDSettings.world_icons.objective_g[1680][1050] = HUDSettings.world_icons.objective_g[1680][1050] or table.clone(HUDSettings.world_icons.objective_a[1680][1050])
HUDSettings.world_icons.objective_g[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_g or nil
end
HUDSettings.world_icons.objective_g[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_g or nil
end
HUDSettings.world_icons.objective_g[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_g or nil
end
HUDSettings.world_icons.objective_g[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_g or nil
end
HUDSettings.world_icons.objective_h = HUDSettings.world_icons.objective_h or {}
HUDSettings.world_icons.objective_h[1680] = HUDSettings.world_icons.objective_h[1680] or {}
HUDSettings.world_icons.objective_h[1680][1050] = HUDSettings.world_icons.objective_h[1680][1050] or table.clone(HUDSettings.world_icons.objective_a[1680][1050])
HUDSettings.world_icons.objective_h[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_h or nil
end
HUDSettings.world_icons.objective_h[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_h or nil
end
HUDSettings.world_icons.objective_h[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_h or nil
end
HUDSettings.world_icons.objective_h[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_objective_h or nil
end
HUDSettings.world_icons.objective_x = HUDSettings.world_icons.objective_x or {}
HUDSettings.world_icons.objective_x[1680] = HUDSettings.world_icons.objective_x[1680] or {}
HUDSettings.world_icons.objective_x[1680][1050] = HUDSettings.world_icons.objective_x[1680][1050] or table.clone(HUDSettings.world_icons.objective_a[1680][1050])
HUDSettings.world_icons.objective_x[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_buff_icon_damage_small or nil
end
HUDSettings.world_icons.objective_x[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_buff_icon_damage_small or nil
end
HUDSettings.world_icons.objective_x[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_buff_icon_damage_small or nil
end
HUDSettings.world_icons.objective_x[1680][1050].spawn_map.texture_func = function(blackboard, player)
	return player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_buff_icon_damage_small or nil
end
HUDSettings.world_icons.objective_assault = HUDSettings.world_icons.objective_assault or {}
HUDSettings.world_icons.objective_assault[1680] = HUDSettings.world_icons.objective_assault[1680] or {}
HUDSettings.world_icons.objective_assault[1680][1050] = HUDSettings.world_icons.objective_assault[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.objective_assault[1680][1050].attention_screen_zone.texture_func = function(blackboard, player)
	local side = player.team.side

	if not side or not player.team or not blackboard.active_team_sides[side] then
		return nil
	end

	return side == "attackers" and HUDAtlas.danger_icon_melee or side == "defenders" and HUDAtlas.danger_icon_armour_med or nil
end
HUDSettings.world_icons.objective_assault[1680][1050].default_screen_zone.texture_func = function(blackboard, player)
	local side = player.team.side

	if not side or not player.team or not blackboard.active_team_sides[side] then
		return nil
	end

	return side == "attackers" and HUDAtlas.danger_icon_melee or side == "defenders" and HUDAtlas.danger_icon_armour_med or nil
end
HUDSettings.world_icons.objective_assault[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player)
	local side = player.team.side

	if not side or not player.team or not blackboard.active_team_sides[side] then
		return nil
	end

	return side == "attackers" and HUDAtlas.danger_icon_melee or side == "defenders" and HUDAtlas.danger_icon_armour_med or nil
end
HUDSettings.world_icons.objective_assault[1680][1050].spawn_map.texture_func = function(blackboard, player)
	local side = player.team.side

	if not side or not player.team or not blackboard.active_team_sides[side] then
		return nil
	end

	return side == "attackers" and HUDAtlas.danger_icon_melee or side == "defenders" and HUDAtlas.danger_icon_armour_med or nil
end
HUDSettings.world_icons.objective_assault[1680][1050].attention_screen_zone.show_progress = false
HUDSettings.world_icons.objective_assault[1680][1050].clamped_screen_zone.show_progress = false
HUDSettings.world_icons.objective_assault[1680][1050].spawn_map.show_progress = false
HUDSettings.world_icons.objective_assault[1680][1050].default_screen_zone.show_progress = false
HUDSettings.world_icons.objective_tag = HUDSettings.world_icons.objective_tag or {}
HUDSettings.world_icons.objective_tag[1680] = HUDSettings.world_icons.objective_tag[1680] or {}
HUDSettings.world_icons.objective_tag[1680][1050] = HUDSettings.world_icons.objective_tag[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.objective_tag[1680][1050].attention_screen_zone.texture_func = function(blackboard, player, unit, world)
	local squad = player.team and player.team.squads[player.squad_index]
	local texture, objective_system, tagged_unit
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if squad and game then
		local members = squad:members()

		for squad_player, _ in pairs(members) do
			if squad_player.is_corporal then
				local tagged_objective_unit_level_index = GameSession.game_object_field(game, squad_player.game_object_id, "tagged_objective_level_id")
				local level = LevelHelper:current_level(world)

				tagged_unit = Level.unit_by_index(level, tagged_objective_unit_level_index)
			end

			objective_system = tagged_unit and ScriptUnit.has_extension(tagged_unit, "objective_system") and ScriptUnit.extension(tagged_unit, "objective_system")
		end
	end

	local texture = objective_system and tagged_unit == unit and (player.team and objective_system:owned(player.team.side) and HUDAtlas.hud_buff_icon_armour_small or player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_buff_icon_damage_small) or nil

	return texture
end
HUDSettings.world_icons.objective_tag[1680][1050].default_screen_zone.texture_func = function(blackboard, player, unit, world)
	local squad = player.team and player.team.squads[player.squad_index]
	local texture, objective_system, tagged_unit
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if squad and game then
		local members = squad:members()

		for squad_player, _ in pairs(members) do
			if squad_player.is_corporal then
				local tagged_objective_unit_level_index = GameSession.game_object_field(game, squad_player.game_object_id, "tagged_objective_level_id")
				local level = LevelHelper:current_level(world)

				tagged_unit = Level.unit_by_index(level, tagged_objective_unit_level_index)
			end

			objective_system = tagged_unit and ScriptUnit.has_extension(tagged_unit, "objective_system") and ScriptUnit.extension(tagged_unit, "objective_system")
		end
	end

	local texture = objective_system and tagged_unit == unit and (player.team and objective_system:owned(player.team.side) and HUDAtlas.hud_buff_icon_armour_small or player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_buff_icon_damage_small) or nil

	return texture
end
HUDSettings.world_icons.objective_tag[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player, unit, world)
	local squad = player.team and player.team.squads[player.squad_index]
	local texture, objective_system, tagged_unit
	local network_manager = Managers.state.network
	local game = network_manager:game()

	if squad and game then
		local members = squad:members()

		for squad_player, _ in pairs(members) do
			if squad_player.is_corporal then
				local tagged_objective_unit_level_index = GameSession.game_object_field(game, squad_player.game_object_id, "tagged_objective_level_id")
				local level = LevelHelper:current_level(world)

				tagged_unit = Level.unit_by_index(level, tagged_objective_unit_level_index)
			end

			objective_system = tagged_unit and ScriptUnit.has_extension(tagged_unit, "objective_system") and ScriptUnit.extension(tagged_unit, "objective_system")
		end
	end

	local texture = objective_system and tagged_unit == unit and (player.team and objective_system:owned(player.team.side) and HUDAtlas.hud_buff_icon_armour_small or player.team and blackboard.active_team_sides[player.team.side] and HUDAtlas.hud_buff_icon_damage_small) or nil

	return texture
end
HUDSettings.world_icons.player_tag = HUDSettings.world_icons.player_tag or {}
HUDSettings.world_icons.player_tag[1680] = HUDSettings.world_icons.player_tag[1680] or {}
HUDSettings.world_icons.player_tag[1680][1050] = HUDSettings.world_icons.player_tag[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.player_tag[1680][1050].attention_screen_zone.texture_func = function(blackboard, player, unit, world, player_unit)
	local tagged = Managers.player:owner(unit) ~= player and PlayerMechanicsHelper.player_unit_tagged(player, unit)

	return tagged and HUDAtlas.buff_number_bg or nil
end
HUDSettings.world_icons.player_tag[1680][1050].attention_screen_zone.max_scale = 0.6
HUDSettings.world_icons.player_tag[1680][1050].attention_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.player_tag[1680][1050].attention_screen_zone.min_scale = 0.2
HUDSettings.world_icons.player_tag[1680][1050].attention_screen_zone.min_scale_distance = 200
HUDSettings.world_icons.player_tag[1680][1050].default_screen_zone.texture_func = function(blackboard, player, unit, world, player_unit)
	local tagged = Managers.player:owner(unit) ~= player and PlayerMechanicsHelper.player_unit_tagged(player, unit)

	return tagged and HUDAtlas.buff_number_bg or nil
end
HUDSettings.world_icons.player_tag[1680][1050].default_screen_zone.max_scale = 0.6
HUDSettings.world_icons.player_tag[1680][1050].default_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.player_tag[1680][1050].default_screen_zone.min_scale = 0.2
HUDSettings.world_icons.player_tag[1680][1050].default_screen_zone.min_scale_distance = 200
HUDSettings.world_icons.player_tag[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player, unit, world, player_unit)
	local tagged = Managers.player:owner(unit) ~= player and PlayerMechanicsHelper.player_unit_tagged(player, unit)

	return tagged and HUDAtlas.buff_number_bg or nil
end
HUDSettings.world_icons.player_tag[1680][1050].clamped_screen_zone.max_scale = 0.6
HUDSettings.world_icons.player_tag[1680][1050].clamped_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.player_tag[1680][1050].clamped_screen_zone.min_scale = 0.2
HUDSettings.world_icons.player_tag[1680][1050].clamped_screen_zone.min_scale_distance = 200
HUDSettings.world_icons.help_request_tag = HUDSettings.world_icons.help_request_tag or {}
HUDSettings.world_icons.help_request_tag[1680] = HUDSettings.world_icons.help_request_tag[1680] or {}
HUDSettings.world_icons.help_request_tag[1680][1050] = HUDSettings.world_icons.help_request_tag[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.help_request_tag[1680][1050].attention_screen_zone.texture_func = function(blackboard, player, unit, world, player_unit)
	return HUDAtlas.hud_buff_icon_health_small
end
HUDSettings.world_icons.help_request_tag[1680][1050].attention_screen_zone.max_scale = 1
HUDSettings.world_icons.help_request_tag[1680][1050].attention_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.help_request_tag[1680][1050].attention_screen_zone.min_scale = 0.5
HUDSettings.world_icons.help_request_tag[1680][1050].attention_screen_zone.min_scale_distance = 200
HUDSettings.world_icons.help_request_tag[1680][1050].default_screen_zone.texture_func = function(blackboard, player, unit, world, player_unit)
	return HUDAtlas.hud_buff_icon_health_small
end
HUDSettings.world_icons.help_request_tag[1680][1050].default_screen_zone.max_scale = 1
HUDSettings.world_icons.help_request_tag[1680][1050].default_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.help_request_tag[1680][1050].default_screen_zone.min_scale = 0.5
HUDSettings.world_icons.help_request_tag[1680][1050].default_screen_zone.min_scale_distance = 200
HUDSettings.world_icons.help_request_tag[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player, unit, world, player_unit)
	return HUDAtlas.hud_buff_icon_health_small
end
HUDSettings.world_icons.help_request_tag[1680][1050].clamped_screen_zone.max_scale = 1
HUDSettings.world_icons.help_request_tag[1680][1050].clamped_screen_zone.max_scale_distance = 10
HUDSettings.world_icons.help_request_tag[1680][1050].clamped_screen_zone.min_scale = 0.5
HUDSettings.world_icons.help_request_tag[1680][1050].clamped_screen_zone.min_scale_distance = 200
HUDSettings.world_icons.current_horse = HUDSettings.world_icons.current_horse or {}
HUDSettings.world_icons.current_horse[1680] = HUDSettings.world_icons.current_horse[1680] or {}
HUDSettings.world_icons.current_horse[1680][1050] = HUDSettings.world_icons.current_horse[1680][1050] or table.clone(HUDSettings.world_icons.objective_circle[1680][1050])
HUDSettings.world_icons.current_horse[1680][1050].attention_screen_zone.texture_func = function(blackboard, player, mount_unit, world, player_unit)
	local player_unit_locomotion = ScriptUnit.extension(player_unit, "locomotion_system")
	local owned_mount_unit = player_unit_locomotion.owned_mount_unit
	local rider = Unit.get_data(mount_unit, "user_unit")
	local mount_damage = ScriptUnit.extension(mount_unit, "damage_system")

	if owned_mount_unit == mount_unit and not mount_damage:is_dead() then
		if rider then
			if rider ~= player_unit then
				return HUDAtlas.others_horse
			end
		else
			return HUDAtlas.own_horse
		end
	end

	return nil
end
HUDSettings.world_icons.current_horse[1680][1050].default_screen_zone.texture_func = function(blackboard, player, mount_unit, world, player_unit)
	local player_unit_locomotion = ScriptUnit.extension(player_unit, "locomotion_system")
	local owned_mount_unit = player_unit_locomotion.owned_mount_unit
	local rider = Unit.get_data(mount_unit, "user_unit")
	local mount_damage = ScriptUnit.extension(mount_unit, "damage_system")

	if owned_mount_unit == mount_unit and not mount_damage:is_dead() then
		if rider then
			if rider ~= player_unit then
				return HUDAtlas.others_horse
			end
		else
			return HUDAtlas.own_horse
		end
	end

	return nil
end
HUDSettings.world_icons.current_horse[1680][1050].clamped_screen_zone.texture_func = function(blackboard, player, mount_unit, world, player_unit)
	local player_unit_locomotion = ScriptUnit.extension(player_unit, "locomotion_system")
	local owned_mount_unit = player_unit_locomotion.owned_mount_unit
	local rider = Unit.get_data(mount_unit, "user_unit")
	local mount_damage = ScriptUnit.extension(mount_unit, "damage_system")

	if owned_mount_unit == mount_unit and not mount_damage:is_dead() then
		if rider then
			if rider ~= player_unit then
				return HUDAtlas.others_horse
			end
		else
			return HUDAtlas.own_horse
		end
	end

	return nil
end
HUDSettings.chat = HUDSettings.chat or {}
HUDSettings.chat.container = HUDSettings.chat.container or {}
HUDSettings.chat.container[1680] = HUDSettings.chat.container[1680] or {}
HUDSettings.chat.container[1680][1050] = HUDSettings.chat.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 1,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center"
}
HUDSettings.chat.input_text = HUDSettings.chat.input_text or {}
HUDSettings.chat.input_text[1680] = HUDSettings.chat.input_text[1680] or {}
HUDSettings.chat.input_text[1680][1050] = HUDSettings.chat.input_text[1680][1050] or {
	pivot_offset_y = -280,
	height = 26,
	pivot_align_y = "bottom",
	screen_offset_x = 0,
	avoid_growth = true,
	text_offset_y = 8,
	marker_height = 18,
	marker_width = 2,
	border_size = 1,
	text_offset_x = 5,
	screen_align_y = "top",
	font_size = 16,
	screen_align_x = "left",
	pivot_offset_x = 25,
	screen_offset_y = 0,
	pivot_align_x = "left",
	width = 380,
	font = MenuSettings.fonts.arial_16_masked,
	text_color = {
		255,
		255,
		255,
		255
	},
	background_color = {
		100,
		0,
		0,
		0
	},
	border_color = {
		150,
		0,
		0,
		0
	},
	marker_color = {
		255,
		255,
		255
	}
}
HUDSettings.chat.output_window = HUDSettings.chat.output_window or {
	post_time = 10,
	life_time = 15,
	max_lines = 15,
	scroll_speed = 800,
	font_size = 16,
	max_posts = 50,
	gui_material = "materials/fonts/arial",
	text_scroll_time = 0.25,
	font = MenuSettings.fonts.arial_16_masked,
	window_settings = {
		outer_window = {
			size_x = 410,
			size_y = 285,
			x = 15,
			y_offset = 290
		},
		chat_field = {
			size_x = 390,
			size_y = 26,
			x = 25,
			y_offset = 280
		},
		inner_window = {
			size_x = 390,
			size_y = 233,
			x = 25,
			y_offset = 245
		}
	}
}
HUDSettings.handgonne_reload = HUDSettings.handgonne_reload or {}
HUDSettings.handgonne_reload.container = HUDSettings.handgonne_reload.container or {}
HUDSettings.handgonne_reload.container[1680] = HUDSettings.handgonne_reload.container[1680] or {}
HUDSettings.handgonne_reload.container[1680][1050] = HUDSettings.handgonne_reload.container[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = -0.03,
	pivot_align_y = "top",
	z = 1,
	pivot_offset_y = 0,
	height = 80,
	screen_align_x = "right",
	pivot_offset_x = 0,
	screen_offset_y = -0.05,
	pivot_align_x = "right",
	width = 80,
	background_color = {
		0,
		0,
		0,
		0
	}
}
HUDSettings.handgonne_reload.timer = HUDSettings.handgonne_reload.timer or {}
HUDSettings.handgonne_reload.timer[1680] = HUDSettings.handgonne_reload.timer[1680] or {}
HUDSettings.handgonne_reload.timer[1680][1050] = HUDSettings.handgonne_reload.timer[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.03,
	texture_atlas = "hud_atlas",
	texture_width = 80,
	pivot_offset_y = 0,
	shine_time = 0.2,
	screen_align_x = "center",
	shine_texture = "hud_icon_shine",
	shine = true,
	pivot_align_y = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.05,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 80,
	shine_offset = {
		5,
		10
	},
	shine_size = {
		70,
		60
	},
	texture_atlas_settings = HUDAtlas.handgun,
	texture_atlas_settings2 = HUDAtlas.handgun_full
}
HUDSettings.lance_recharge = HUDSettings.lance_recharge or {}
HUDSettings.lance_recharge.container = HUDSettings.lance_recharge.container or {}
HUDSettings.lance_recharge.container[1680] = HUDSettings.lance_recharge.container[1680] or {}
HUDSettings.lance_recharge.container[1680][1050] = HUDSettings.lance_recharge.container[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = -0.03,
	pivot_align_y = "top",
	z = 1,
	pivot_offset_y = 0,
	height = 80,
	screen_align_x = "right",
	pivot_offset_x = 0,
	screen_offset_y = -0.05,
	pivot_align_x = "right",
	width = 80,
	background_color = {
		0,
		0,
		0,
		0
	}
}
HUDSettings.lance_recharge.timer = HUDSettings.lance_recharge.timer or {}
HUDSettings.lance_recharge.timer[1680] = HUDSettings.lance_recharge.timer[1680] or {}
HUDSettings.lance_recharge.timer[1680][1050] = HUDSettings.lance_recharge.timer[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = -0.03,
	texture_atlas = "hud_atlas",
	texture_width = 80,
	pivot_offset_y = 0,
	shine_time = 0.2,
	screen_align_x = "center",
	shine_texture = "hud_icon_shine",
	shine = true,
	pivot_align_y = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.05,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 80,
	shine_offset = {
		5,
		10
	},
	shine_size = {
		70,
		60
	},
	texture_atlas_settings = HUDAtlas.lance,
	texture_atlas_settings2 = HUDAtlas.lance_full
}
HUDSettings.spawn = HUDSettings.spawn or {}
HUDSettings.spawn.container = HUDSettings.spawn.container or {}
HUDSettings.spawn.container[1680] = HUDSettings.spawn.container[1680] or {}
HUDSettings.spawn.container[1680][1050] = HUDSettings.spawn.container[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	z = 10,
	pivot_offset_y = -90,
	height = 36,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 652
}
HUDSettings.spawn.container[1366] = HUDSettings.spawn.container[1366] or {}
HUDSettings.spawn.container[1366][768] = HUDSettings.spawn.container[1366][768] or table.clone(HUDSettings.spawn.container[1680][1050])
HUDSettings.spawn.container[1366][768].pivot_offset_y = -54
HUDSettings.spawn.mount_warning = HUDSettings.spawn.mount_warning or {}
HUDSettings.spawn.mount_warning[1680] = HUDSettings.spawn.mount_warning[1680] or {}
HUDSettings.spawn.mount_warning[1680][1050] = HUDSettings.spawn.mount_warning[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 36,
	pivot_offset_y = 44,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.hell_shark_36,
	text_color = {
		255,
		255,
		255,
		255
	},
	shadow_color = {
		120,
		0,
		0,
		0
	},
	shadow_offset = {
		2,
		-2
	}
}
HUDSettings.spawn.mount_warning[1366] = HUDSettings.spawn.mount_warning[1366] or {}
HUDSettings.spawn.mount_warning[1366][768] = HUDSettings.spawn.mount_warning[1366][768] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 32,
	pivot_offset_y = 44,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.hell_shark_32,
	text_color = {
		255,
		255,
		255,
		255
	},
	shadow_color = {
		120,
		0,
		0,
		0
	},
	shadow_offset = {
		2,
		-2
	}
}
HUDSettings.spawn.mount_warning_texture = HUDSettings.spawn.mount_warning_texture or {}
HUDSettings.spawn.mount_warning_texture[1680] = HUDSettings.spawn.mount_warning_texture[1680] or {}
HUDSettings.spawn.mount_warning_texture[1680][1050] = HUDSettings.spawn.mount_warning_texture[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_spawn_timer_background",
	pivot_offset_y = 38,
	texture_width = 652,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 36
}
HUDSettings.spawn.mount_warning_texture[1366] = HUDSettings.spawn.mount_warning_texture[1366] or {}
HUDSettings.spawn.mount_warning_texture[1366][768] = HUDSettings.spawn.mount_warning_texture[1366][768] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_spawn_timer_background",
	pivot_offset_y = 38,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_width = 652 * SCALE_1366,
	texture_height = 36 * SCALE_1366
}
HUDSettings.spawn.timer_text = HUDSettings.spawn.timer_text or {}
HUDSettings.spawn.timer_text[1680] = HUDSettings.spawn.timer_text[1680] or {}
HUDSettings.spawn.timer_text[1680][1050] = HUDSettings.spawn.timer_text[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 32,
	pivot_offset_y = 4,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.hell_shark_32,
	text_color = {
		255,
		255,
		255,
		255
	},
	shadow_color = {
		120,
		0,
		0,
		0
	},
	shadow_offset = {
		2,
		-2
	}
}
HUDSettings.spawn.timer_text[1366] = HUDSettings.spawn.timer_text[1366] or {}
HUDSettings.spawn.timer_text[1366][768] = HUDSettings.spawn.timer_text[1366][768] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 22,
	pivot_offset_y = 4,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.hell_shark_22,
	text_color = {
		255,
		255,
		255,
		255
	},
	shadow_color = {
		120,
		0,
		0,
		0
	},
	shadow_offset = {
		2,
		-2
	}
}
HUDSettings.spawn.timer_texture = HUDSettings.spawn.timer_texture or {}
HUDSettings.spawn.timer_texture[1680] = HUDSettings.spawn.timer_texture[1680] or {}
HUDSettings.spawn.timer_texture[1680][1050] = HUDSettings.spawn.timer_texture[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_spawn_timer_background",
	pivot_offset_y = 0,
	texture_width = 652,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_height = 36
}
HUDSettings.spawn.timer_texture[1366] = HUDSettings.spawn.timer_texture[1366] or {}
HUDSettings.spawn.timer_texture[1366][768] = HUDSettings.spawn.timer_texture[1366][768] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	texture = "hud_spawn_timer_background",
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	scale = 1,
	texture_width = 652 * SCALE_1366,
	texture_height = 36 * SCALE_1366
}
HUDSettings.deserting = HUDSettings.deserting or {}
HUDSettings.deserting.container = HUDSettings.deserting.container or {}
HUDSettings.deserting.container[1680] = HUDSettings.deserting.container[1680] or {}
HUDSettings.deserting.container[1680][1050] = HUDSettings.deserting.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 100,
	pivot_offset_y = 0,
	height = 2000,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 2000,
	background_color = {
		100,
		210,
		0,
		0
	}
}
HUDSettings.deserting.text_line_1 = HUDSettings.deserting.text_line_1 or {}
HUDSettings.deserting.text_line_1[1680] = HUDSettings.deserting.text_line_1[1680] or {}
HUDSettings.deserting.text_line_1[1680][1050] = HUDSettings.deserting.text_line_1[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 60,
	pivot_offset_y = 100,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.deserting.text_line_2 = HUDSettings.deserting.text_line_2 or {}
HUDSettings.deserting.text_line_2[1680] = HUDSettings.deserting.text_line_2[1680] or {}
HUDSettings.deserting.text_line_2[1680][1050] = HUDSettings.deserting.text_line_2[1680][1050] or table.clone(HUDSettings.deserting.text_line_1[1680][1050])
HUDSettings.deserting.text_line_2[1680][1050].pivot_offset_y = -100
HUDSettings.deserting.timer = HUDSettings.deserting.timer or {}
HUDSettings.deserting.timer[1680] = HUDSettings.deserting.timer[1680] or {}
HUDSettings.deserting.timer[1680][1050] = HUDSettings.deserting.timer[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	font_size = 60,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	text_color = {
		255,
		255,
		255,
		255
	}
}
HUDSettings.game_mode_status = HUDSettings.game_mode_status or {}
HUDSettings.game_mode_status.container = HUDSettings.game_mode_status.container or {}
HUDSettings.game_mode_status.container[1680] = HUDSettings.game_mode_status.container[1680] or {}
HUDSettings.game_mode_status.container[1680][1050] = HUDSettings.game_mode_status.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = 1,
	pivot_offset_y = 20,
	height = 90,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	width = 870
}
HUDSettings.game_mode_status.own_team_score = HUDSettings.game_mode_status.own_team_score or {}
HUDSettings.game_mode_status.own_team_score[1680] = HUDSettings.game_mode_status.own_team_score[1680] or {}
HUDSettings.game_mode_status.own_team_score[1680][1050] = HUDSettings.game_mode_status.own_team_score[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	font_size = 36,
	pivot_offset_y = 20,
	screen_align_x = "left",
	pivot_offset_x = 38,
	screen_offset_y = 0,
	pivot_align_x = "right",
	font = MenuSettings.fonts.wotr_hud_text_36,
	text_color = {
		255,
		255,
		255,
		0
	}
}
HUDSettings.game_mode_status.enemy_team_score = HUDSettings.game_mode_status.enemy_team_score or {}
HUDSettings.game_mode_status.enemy_team_score[1680] = HUDSettings.game_mode_status.enemy_team_score[1680] or {}
HUDSettings.game_mode_status.enemy_team_score[1680][1050] = HUDSettings.game_mode_status.enemy_team_score[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	font_size = 36,
	pivot_offset_y = 20,
	screen_align_x = "right",
	pivot_offset_x = -38,
	screen_offset_y = 0,
	pivot_align_x = "left",
	font = MenuSettings.fonts.wotr_hud_text_36,
	text_color = {
		255,
		255,
		255,
		0
	}
}
HUDSettings.game_mode_status.own_team_rose = HUDSettings.game_mode_status.own_team_rose or {}
HUDSettings.game_mode_status.own_team_rose[1680] = HUDSettings.game_mode_status.own_team_rose[1680] or {}
HUDSettings.game_mode_status.own_team_rose[1680][1050] = HUDSettings.game_mode_status.own_team_rose[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 0,
	screen_align_x = "left",
	pivot_offset_x = 46,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_atlas_settings_func = function(blackboard)
		return not (blackboard.player.team.name ~= "unassigned" and blackboard.player.team.name ~= "red") and HUDAtlas.team_rose_red or HUDAtlas.team_rose_white
	end
}
HUDSettings.game_mode_status.enemy_team_rose = HUDSettings.game_mode_status.enemy_team_rose or {}
HUDSettings.game_mode_status.enemy_team_rose[1680] = HUDSettings.game_mode_status.enemy_team_rose[1680] or {}
HUDSettings.game_mode_status.enemy_team_rose[1680][1050] = HUDSettings.game_mode_status.enemy_team_rose[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 0,
	screen_align_x = "right",
	pivot_offset_x = -46,
	screen_offset_y = 0,
	pivot_align_x = "right",
	texture_atlas_settings_func = function(blackboard)
		return not (blackboard.player.team.name ~= "red" and blackboard.player.team.name ~= "unassigned") and HUDAtlas.team_rose_white or HUDAtlas.team_rose_red
	end
}
HUDSettings.game_mode_status.objective_text = HUDSettings.game_mode_status.objective_text or {}
HUDSettings.game_mode_status.objective_text[1680] = HUDSettings.game_mode_status.objective_text[1680] or {}
HUDSettings.game_mode_status.objective_text[1680][1050] = HUDSettings.game_mode_status.objective_text[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	font_size = 36,
	pivot_offset_y = 20,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.wotr_hud_text_36,
	text_color = {
		255,
		255,
		255,
		0
	}
}
HUDSettings.game_mode_status.own_progress_bar = HUDSettings.game_mode_status.own_progress_bar or {}
HUDSettings.game_mode_status.own_progress_bar[1680] = HUDSettings.game_mode_status.own_progress_bar[1680] or {}
HUDSettings.game_mode_status.own_progress_bar[1680][1050] = HUDSettings.game_mode_status.own_progress_bar[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 14,
	progress_bar_offset_x = 120,
	screen_align_x = "left",
	texture_width = 0,
	progress_bar_max_width = 630,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_atlas_settings = HUDAtlas.bottom_bar_bg,
	texture_height = HUDAtlas.bottom_bar_bg.size[2],
	color = HUDSettings.player_colors.team_member
}
HUDSettings.game_mode_status.enemy_progress_bar = HUDSettings.game_mode_status.enemy_progress_bar or {}
HUDSettings.game_mode_status.enemy_progress_bar[1680] = HUDSettings.game_mode_status.enemy_progress_bar[1680] or {}
HUDSettings.game_mode_status.enemy_progress_bar[1680][1050] = HUDSettings.game_mode_status.enemy_progress_bar[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 14,
	progress_bar_offset_x = 120,
	screen_align_x = "left",
	texture_width = 0,
	progress_bar_max_width = 630,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_atlas_settings = HUDAtlas.bottom_bar_bg,
	texture_height = HUDAtlas.bottom_bar_bg.size[2],
	color = HUDSettings.player_colors.enemy
}
HUDSettings.game_mode_status.progress_bar_bgr = HUDSettings.game_mode_status.progress_bar_bgr or {}
HUDSettings.game_mode_status.progress_bar_bgr[1680] = HUDSettings.game_mode_status.progress_bar_bgr[1680] or {}
HUDSettings.game_mode_status.progress_bar_bgr[1680][1050] = HUDSettings.game_mode_status.progress_bar_bgr[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 14,
	screen_align_x = "left",
	pivot_offset_x = 120,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_atlas_settings = HUDAtlas.bottom_bar_swirl_bg,
	texture_width = HUDAtlas.bottom_bar_swirl_bg.size[1],
	texture_height = HUDAtlas.bottom_bar_swirl_bg.size[2],
	color = {
		150,
		255,
		255,
		255
	}
}
HUDSettings.game_mode_status.own_progress_bar_cap = HUDSettings.game_mode_status.own_progress_bar_cap or {}
HUDSettings.game_mode_status.own_progress_bar_cap[1680] = HUDSettings.game_mode_status.own_progress_bar_cap[1680] or {}
HUDSettings.game_mode_status.own_progress_bar_cap[1680][1050] = HUDSettings.game_mode_status.own_progress_bar_cap[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 14,
	screen_align_x = "left",
	pivot_offset_x = 119,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_atlas_settings = HUDAtlas.bottom_bar_cap,
	texture_width = HUDAtlas.bottom_bar_cap.size[1],
	texture_height = HUDAtlas.bottom_bar_cap.size[2]
}
HUDSettings.game_mode_status.enemy_progress_bar_cap = HUDSettings.game_mode_status.enemy_progress_bar_cap or {}
HUDSettings.game_mode_status.enemy_progress_bar_cap[1680] = HUDSettings.game_mode_status.enemy_progress_bar_cap[1680] or {}
HUDSettings.game_mode_status.enemy_progress_bar_cap[1680][1050] = HUDSettings.game_mode_status.enemy_progress_bar_cap[1680][1050] or table.clone(HUDSettings.game_mode_status.own_progress_bar_cap[1680][1050])
HUDSettings.game_mode_status.enemy_progress_bar_cap[1680][1050].pivot_offset_x = 750
HUDSettings.game_mode_status.progress_bar_divider = HUDSettings.game_mode_status.progress_bar_divider or {}
HUDSettings.game_mode_status.progress_bar_divider[1680] = HUDSettings.game_mode_status.progress_bar_divider[1680] or {}
HUDSettings.game_mode_status.progress_bar_divider[1680][1050] = HUDSettings.game_mode_status.progress_bar_divider[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 8,
	progress_bar_offset_x = 120,
	screen_align_x = "left",
	progress_bar_max_width = 630,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_atlas_settings = HUDAtlas.bottom_bar_divider,
	texture_width = HUDAtlas.bottom_bar_divider.size[1],
	texture_height = HUDAtlas.bottom_bar_divider.size[2]
}
HUDSettings.game_mode_status.progress_bar_center = HUDSettings.game_mode_status.progress_bar_center or {}
HUDSettings.game_mode_status.progress_bar_center[1680] = HUDSettings.game_mode_status.progress_bar_center[1680] or {}
HUDSettings.game_mode_status.progress_bar_center[1680][1050] = HUDSettings.game_mode_status.progress_bar_center[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 8,
	screen_align_x = "left",
	pivot_offset_x = 431,
	screen_offset_y = 0,
	pivot_align_x = "left",
	texture_atlas_settings = HUDAtlas.bottom_bar_center_marking,
	texture_width = HUDAtlas.bottom_bar_center_marking.size[1],
	texture_height = HUDAtlas.bottom_bar_center_marking.size[2]
}
HUDSettings.game_mode_status.round_timer = HUDSettings.game_mode_status.round_timer or {}
HUDSettings.game_mode_status.round_timer[1680] = HUDSettings.game_mode_status.round_timer[1680] or {}
HUDSettings.game_mode_status.round_timer[1680][1050] = HUDSettings.game_mode_status.round_timer[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	font_size = 36,
	pivot_offset_y = 64,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.wotr_hud_text_36,
	text_color = {
		255,
		255,
		255,
		0
	}
}
HUDSettings.game_mode_status.round_timer_menu = HUDSettings.game_mode_status.round_timer_menu or {}
HUDSettings.game_mode_status.round_timer_menu[1680] = HUDSettings.game_mode_status.round_timer_menu[1680] or {}
HUDSettings.game_mode_status.round_timer_menu[1680][1050] = HUDSettings.game_mode_status.round_timer_menu[1680][1050] or table.clone(HUDSettings.game_mode_status.round_timer[1680][1050])
HUDSettings.game_mode_status.round_timer_menu[1680][1050].pivot_offset_y = 80 * SCALE_1366
HUDSettings.combat_log = HUDSettings.combat_log or {}
HUDSettings.combat_log.container = HUDSettings.combat_log.container or {}
HUDSettings.combat_log.container[1680] = HUDSettings.combat_log.container[1680] or {}
HUDSettings.combat_log.container[1680][1050] = HUDSettings.combat_log.container[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	pivot_align_y = "bottom",
	z = 1,
	pivot_offset_y = -26,
	height = 210,
	screen_align_x = "right",
	pivot_offset_x = 0,
	screen_offset_y = 0.047,
	pivot_align_x = "right",
	width = 300
}
HUDSettings.combat_log = HUDSettings.combat_log or {}
HUDSettings.combat_log.bgr_gradient = HUDSettings.combat_log.bgr_gradient or {}
HUDSettings.combat_log.bgr_gradient[1680] = HUDSettings.combat_log.bgr_gradient[1680] or {}
HUDSettings.combat_log.bgr_gradient[1680][1050] = HUDSettings.combat_log.bgr_gradient[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "top",
	pivot_offset_y = 0,
	screen_align_x = "right",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	texture_height = 210,
	texture_atlas_settings = HUDAtlas.combat_log_bgr_gradient,
	texture_width = HUDAtlas.combat_log_bgr_gradient.size[1],
	color = {
		70,
		255,
		255,
		255
	}
}
HUDSettings.combat_log = HUDSettings.combat_log or {}
HUDSettings.combat_log.top_line = HUDSettings.combat_log.top_line or {}
HUDSettings.combat_log.top_line[1680] = HUDSettings.combat_log.top_line[1680] or {}
HUDSettings.combat_log.top_line[1680][1050] = HUDSettings.combat_log.top_line[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "top",
	pivot_offset_y = 0,
	screen_align_x = "right",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	texture_atlas_settings = HUDAtlas.combat_log_top_line,
	texture_width = HUDAtlas.combat_log_top_line.size[1],
	texture_height = HUDAtlas.combat_log_top_line.size[2]
}
HUDSettings.combat_log = HUDSettings.combat_log or {}
HUDSettings.combat_log.bottom_line = HUDSettings.combat_log.bottom_line or {}
HUDSettings.combat_log.bottom_line[1680] = HUDSettings.combat_log.bottom_line[1680] or {}
HUDSettings.combat_log.bottom_line[1680][1050] = HUDSettings.combat_log.bottom_line[1680][1050] or {
	screen_align_y = "bottom",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	pivot_align_y = "bottom",
	pivot_offset_y = 0,
	screen_align_x = "right",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "right",
	texture_atlas_settings = HUDAtlas.combat_log_bottom_line,
	texture_width = HUDAtlas.combat_log_bottom_line.size[1],
	texture_height = HUDAtlas.combat_log_bottom_line.size[2]
}
HUDSettings.combat_log = HUDSettings.combat_log or {}
HUDSettings.combat_log.log_entry = HUDSettings.combat_log.log_entry or {}
HUDSettings.combat_log.log_entry[1680] = HUDSettings.combat_log.log_entry[1680] or {}
HUDSettings.combat_log.log_entry[1680][1050] = HUDSettings.combat_log.log_entry[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	texture_atlas = "hud_atlas",
	font_size = 16,
	pivot_offset_y = 0,
	height = 20,
	screen_align_x = "right",
	alpha_multiplier = 1,
	text_max_width = 105,
	pivot_align_y = "top",
	pivot_offset_x = -10,
	screen_offset_y = 0,
	pivot_align_x = "right",
	width = 275,
	padding = 4,
	font = MenuSettings.fonts.player_name_font,
	texture_atlas_settings = HUDAtlas
}
HUDSettings.announcements = HUDSettings.announcements or {}
HUDSettings.announcements.container = HUDSettings.announcements.container or {}
HUDSettings.announcements.container[1680] = HUDSettings.announcements.container[1680] or {}
HUDSettings.announcements.container[1680][1050] = HUDSettings.announcements.container[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	z = 20,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = -0.2,
	pivot_align_x = "center"
}
HUDSettings.announcements = HUDSettings.announcements or {}
HUDSettings.announcements.objective = HUDSettings.announcements.objective or {}
HUDSettings.announcements.objective[1680] = HUDSettings.announcements.objective[1680] or {}
HUDSettings.announcements.objective[1680][1050] = HUDSettings.announcements.objective[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	text_align = "center",
	pivot_offset_y = 0,
	font_size = 80,
	screen_align_x = "center",
	anim_length = 5,
	line_height = 70,
	queue_delay = 5,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.font_gradient_100,
	text_color = {
		255,
		255,
		255,
		0
	},
	animations = {
		alpha_multiplier = function(t)
			local t1 = 0.1
			local t2 = 0.9

			if t < t1 then
				return math.lerp(0, 1, t * 10)
			elseif t < t2 then
				return 1
			else
				return math.lerp(1, 0, (t - t2) * (1 / (1 - t2)))
			end
		end
	}
}
HUDSettings.announcements.defender_event = nil
HUDSettings.announcements.defender_event = HUDSettings.announcements.defender_event or {}
HUDSettings.announcements.defender_event[1680] = HUDSettings.announcements.defender_event[1680] or {}
HUDSettings.announcements.defender_event[1680][1050] = HUDSettings.announcements.defender_event[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	text_align = "center",
	pivot_offset_y = 0,
	font_size = 36,
	screen_align_x = "center",
	anim_length = 5,
	line_height = 70,
	queue_delay = 5,
	pivot_offset_x = 0,
	screen_offset_y = 0.1,
	pivot_align_x = "center",
	font = MenuSettings.fonts.hell_shark_36,
	text_color = {
		255,
		255,
		0,
		0
	},
	drop_shadow = {
		1,
		-1
	},
	drop_shadow_color = {
		128,
		0,
		0,
		0
	},
	animations = {
		alpha_multiplier = function(t)
			local t1 = 0.1
			local t2 = 0.9
			local alpha_multiplier = 0

			if t < t1 then
				alpha_multiplier = math.lerp(0, 1, t / t1)
			else
				alpha_multiplier = t < t2 and 1 or math.lerp(1, 0, (t - t2) / (1 - t2))
			end

			local pulses = 8

			return math.lerp(0, 1, 0.75 + math.sin(t * pulses * 4) * 0.25) * alpha_multiplier
		end,
		offset_y = function(t)
			return 0
		end,
		font_size_multiplier = function(t)
			local pulses = 8

			return math.lerp(0, 1, 0.95 + math.sin(t * pulses * 4) * 0.05)
		end
	}
}
HUDSettings.announcements.time_extended = HUDSettings.announcements.time_extended or {}
HUDSettings.announcements.time_extended[1680] = HUDSettings.announcements.time_extended[1680] or {}
HUDSettings.announcements.time_extended[1680][1050] = HUDSettings.announcements.time_extended[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	text_align = "center",
	pivot_offset_y = 0,
	font_size = 40,
	screen_align_x = "center",
	anim_length = 5,
	line_height = 70,
	queue_delay = 5,
	pivot_offset_x = 0,
	screen_offset_y = -0.45,
	pivot_align_x = "center",
	font = MenuSettings.fonts.font_gradient_100,
	text_color = {
		255,
		255,
		255,
		0
	},
	animations = {
		alpha_multiplier = function(t)
			local t1 = 0.1
			local t2 = 0.9

			if t < t1 then
				return math.lerp(0, 1, t * 10)
			elseif t < t2 then
				return 1
			else
				return math.lerp(1, 0, (t - t2) * (1 / (1 - t2)))
			end
		end,
		offset_y = function(t)
			local t2 = 0.9

			if t < t2 then
				return 0
			else
				return math.lerp(0, -100, (t - t2) * (1 / (1 - t2)))
			end
		end,
		font_size_multiplier = function(t)
			local t2 = 0.9

			if t < t2 then
				return 1
			else
				return math.lerp(1, 0.3, (t - t2) * (1 / (1 - t2)))
			end
		end
	}
}
HUDSettings.announcements.round_timer = HUDSettings.announcements.round_timer or {}
HUDSettings.announcements.round_timer[1680] = HUDSettings.announcements.round_timer[1680] or {}
HUDSettings.announcements.round_timer[1680][1050] = HUDSettings.announcements.round_timer[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	text_align = "center",
	pivot_offset_y = 0,
	font_size = 80,
	screen_align_x = "center",
	anim_length = 1,
	line_height = 70,
	queue_delay = 1,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.font_gradient_100,
	text_color = {
		255,
		255,
		255,
		0
	},
	animations = {
		alpha_multiplier = function(t)
			return math.lerp(1, 0, t)
		end
	}
}
HUDSettings.announcements.deserter_timer = HUDSettings.announcements.deserter_timer or {}
HUDSettings.announcements.deserter_timer[1680] = HUDSettings.announcements.deserter_timer[1680] or {}
HUDSettings.announcements.deserter_timer[1680][1050] = HUDSettings.announcements.deserter_timer[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	text_align = "center",
	pivot_offset_y = 0,
	font_size = 80,
	screen_align_x = "center",
	anim_length = 1,
	line_height = 70,
	queue_delay = 1,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.font_gradient_100,
	text_color = {
		255,
		255,
		255,
		0
	},
	animations = {}
}
HUDSettings.announcements.winning_losing = HUDSettings.announcements.winning_losing or {}
HUDSettings.announcements.winning_losing[1680] = HUDSettings.announcements.winning_losing[1680] or {}
HUDSettings.announcements.winning_losing[1680][1050] = HUDSettings.announcements.winning_losing[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	text_align = "center",
	pivot_offset_y = 0,
	font_size = 80,
	screen_align_x = "center",
	anim_length = 3,
	line_height = 70,
	queue_delay = 3,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.font_gradient_100,
	text_color = {
		255,
		255,
		255,
		0
	},
	animations = {
		alpha_multiplier = function(t)
			local t1 = 0.8

			if t < t1 then
				return 1
			else
				return math.lerp(1, 0, (t - t1) * (1 / (1 - t1)))
			end
		end
	}
}
HUDSettings.announcements.achievement = HUDSettings.announcements.achievement or {}
HUDSettings.announcements.achievement[1680] = HUDSettings.announcements.achievement[1680] or {}
HUDSettings.announcements.achievement[1680][1050] = HUDSettings.announcements.achievement[1680][1050] or {
	screen_align_y = "top",
	screen_offset_x = 0,
	pivot_align_y = "top",
	font_size = 80,
	pivot_offset_y = 0,
	anim_length = 2,
	screen_align_x = "center",
	queue_delay = 2,
	line_height = 70,
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center",
	font = MenuSettings.fonts.font_gradient_100,
	text_color = {
		255,
		255,
		255,
		0
	},
	animations = {
		alpha_multiplier = function(t)
			local t1 = 0.9

			if t < t1 then
				return 1
			else
				return math.lerp(1, 0, (t - t1) * (1 / (1 - t1)))
			end
		end
	}
}
HUDSettings.sp_tutorial = HUDSettings.sp_tutorial or {}
HUDSettings.sp_tutorial.container = HUDSettings.sp_tutorial.container or {}
HUDSettings.sp_tutorial.container[1680] = HUDSettings.sp_tutorial.container[1680] or {}
HUDSettings.sp_tutorial.container[1680][1050] = HUDSettings.sp_tutorial.container[1680][1050] or {
	screen_align_y = "center",
	screen_offset_x = 0,
	pivot_align_y = "center",
	z = 30,
	pivot_offset_y = 0,
	screen_align_x = "center",
	pivot_offset_x = 0,
	screen_offset_y = 0,
	pivot_align_x = "center"
}
HUDSettings.sp_tutorial.tutorial_text = HUDSettings.sp_tutorial.tutorial_text or {}
HUDSettings.sp_tutorial.tutorial_text[1680] = HUDSettings.sp_tutorial.tutorial_text[1680] or {}
HUDSettings.sp_tutorial.tutorial_text[1680][1050] = HUDSettings.sp_tutorial.tutorial_text[1680][1050] or {
	header_padding_left = 16,
	screen_offset_x = 0,
	pivot_align_y = "top",
	pivot_offset_y = 0,
	header_font_size = 26,
	screen_align_y = "top",
	text_padding_left = 16,
	header_texture_height = 40,
	line_height = 24,
	top_line_texture_atlas = "hud_atlas",
	header_texture_offset_y = -12,
	bottom_line_texture_atlas = "hud_atlas",
	header_texture_atlas = "hud_atlas",
	text_width = 320,
	gradient_texture_atlas = "hud_atlas",
	font_size = 22,
	text_padding_bottom = 20,
	screen_align_x = "left",
	header_padding_bottom = 16,
	text_padding_top = 56,
	pivot_offset_x = 0,
	screen_offset_y = -0.15,
	pivot_align_x = "left",
	header_font = MenuSettings.fonts.hell_shark_26,
	header_color = {
		255,
		255,
		255,
		255
	},
	header_shadow_color = {
		120,
		0,
		0,
		0
	},
	header_shadow_offset = {
		2,
		-2
	},
	font = MenuSettings.fonts.hell_shark_22,
	text_color = {
		255,
		255,
		255,
		255
	},
	text_shadow_color = {
		120,
		0,
		0,
		0
	},
	text_shadow_offset = {
		2,
		-2
	},
	header_texture_atlas_settings = HUDAtlas.tutorial_bgr_gradient,
	header_texture_color = {
		255,
		255,
		255,
		255
	},
	gradient_texture_atlas_settings = HUDAtlas.tutorial_bgr_gradient,
	gradient_texture_color = {
		200,
		255,
		255,
		255
	},
	top_line_texture_atlas_settings = HUDAtlas.tutorial_top_line,
	bottom_line_texture_atlas_settings = HUDAtlas.tutorial_bottom_line
}
HUDSettings.fonts = {
	wotr_comb_text = {
		material = "materials/fonts/wotr_comb_text",
		sizes = {}
	}
}
HUDSettings.fonts.wotr_comb_text.sizes[20] = {
	material = "materials/fonts/wotr_comb_text_20",
	font = "wotr_comb_text_20"
}
HUDSettings.fonts.wotr_comb_text.sizes[25] = {
	material = "materials/fonts/wotr_comb_text_25",
	font = "wotr_comb_text_25"
}
HUDSettings.fonts.wotr_comb_text.sizes[30] = {
	material = "materials/fonts/wotr_comb_text_30",
	font = "wotr_comb_text_30"
}
HUDSettings.fonts.wotr_comb_text.sizes[35] = {
	material = "materials/fonts/wotr_comb_text_35",
	font = "wotr_comb_text_35"
}
HUDSettings.fonts.wotr_comb_text.sizes[40] = {
	material = "materials/fonts/wotr_comb_text_40",
	font = "wotr_comb_text_40"
}
HUDSettings.fonts.wotr_comb_text.sizes[45] = {
	material = "materials/fonts/wotr_comb_text_45",
	font = "wotr_comb_text_45"
}
HUDSettings.fonts.wotr_comb_text.sizes[50] = {
	material = "materials/fonts/wotr_comb_text_50",
	font = "wotr_comb_text_50"
}
HUDSettings.fonts.wotr_comb_text.sizes[55] = {
	material = "materials/fonts/wotr_comb_text_55",
	font = "wotr_comb_text_55"
}
HUDSettings.fonts.wotr_comb_text.sizes[60] = {
	material = "materials/fonts/wotr_comb_text_60",
	font = "wotr_comb_text_60"
}
HUDSettings.fonts.wotr_comb_text.sizes[65] = {
	material = "materials/fonts/wotr_comb_text_65",
	font = "wotr_comb_text_65"
}
HUDSettings.fonts.wotr_comb_text.sizes[70] = {
	material = "materials/fonts/wotr_comb_text_70",
	font = "wotr_comb_text_70"
}
HUDSettings.fonts.wotr_comb_text.sizes[75] = {
	material = "materials/fonts/wotr_comb_text_75",
	font = "wotr_comb_text_75"
}
HUDSettings.fonts.wotr_comb_text.sizes[80] = {
	material = "materials/fonts/wotr_comb_text_80",
	font = "wotr_comb_text_80"
}
HUDSettings.fonts.wotr_comb_text.sizes[85] = {
	material = "materials/fonts/wotr_comb_text_85",
	font = "wotr_comb_text_85"
}
HUDSettings.fonts.wotr_comb_text.sizes[90] = {
	material = "materials/fonts/wotr_comb_text_90",
	font = "wotr_comb_text_90"
}
HUDSettings.parry_helper.scan_radius = 3
HUDSettings.parry_helper.activation_angle = 180
HUDSettings.bow_minigame.hit_section_size = 100
