-- chunkname: @scripts/settings/announcements.lua

require("scripts/settings/hud_settings")

Announcements = Announcements or {}
Announcements = {
	[""] = {},
	kill_the_enemy_team = {
		sound_event = "vo_announcement_new_tdm_both",
		show_max_times = 1,
		unique_id = "objective_description",
		param1 = "enemy_team_ui_name_definite_plural",
		layout_settings = HUDSettings.announcements.objective
	},
	capture_level = {
		sound_event = "vo_announcement_new_objective_both",
		show_max_times = 1,
		unique_id = "objective_description",
		param1 = "current_level_name",
		layout_settings = HUDSettings.announcements.objective
	},
	interact_with_attackers_objective = {
		sound_event = "vo_announcement_tag_objective_fortification_both",
		show_max_times = 1,
		unique_id = "objective_description",
		param1 = "attackers_objectives_grouped_on_interaction",
		layout_settings = HUDSettings.announcements.objective
	},
	defend_attackers_objective = {
		sound_event = "vo_announcement_tag_defend_fortification_both",
		show_max_times = 1,
		unique_id = "objective_description",
		param1 = "attackers_objective_ui_names",
		layout_settings = HUDSettings.announcements.objective
	},
	kill_tagged_enemy = {
		sound_event = "vo_announcement_tag_kill_character_both",
		unique_id = "objective_description",
		no_text = true
	},
	execute_tagged_enemy = {
		sound_event = "vo_announcement_tag_execute_character_both",
		unique_id = "objective_description",
		no_text = true
	},
	defend_tagged_team_member = {
		sound_event = "vo_announcement_tag_defend_character_both",
		unique_id = "objective_description",
		no_text = true
	},
	revive_tagged_team_member = {
		sound_event = "vo_announcement_tag_revive_character_both",
		unique_id = "objective_description",
		no_text = true,
		layout_settings = HUDSettings.announcements.objective
	},
	attack_tagged_objective = {
		sound_event = "vo_announcement_tag_objective_fortification_both",
		unique_id = "objective_description",
		no_text = true
	},
	defend_tagged_objective = {
		sound_event = "vo_announcement_tag_defend_fortification_both",
		unique_id = "objective_description",
		no_text = true
	},
	pitched_battle_tiebreak = {
		sound_event = "vo_announcement_new_tdm_both",
		show_max_times = 1,
		uniue_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_cart = {
		sound_event = "vo_announcement_new_defend_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_cart = {
		sound_event = "vo_announcement_new_destroy_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_switch = {
		sound_event = "vo_announcement_new_defend_gate_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_raise_gate = {
		sound_event = "vo_announcement_new_destroy_gate_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_tower = {
		sound_event = "vo_announcement_new_destroy_tower_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_tower = {
		sound_event = "vo_announcement_new_defend_tower_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_bombard = {
		sound_event = "vo_announcement_new_destroy_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_bombard = {
		sound_event = "vo_announcement_new_defend_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_raise_gate_nocannon = {
		sound_event = "vo_announcement_new_destroy_gate_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_destroy_gate = {
		sound_event = "vo_announcement_new_destroy_gate_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_gate = {
		sound_event = "vo_announcement_new_defend_gate_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_smithy = {
		sound_event = "vo_announcement_new_destroy_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_smithy = {
		sound_event = "vo_announcement_new_defend_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_manor = {
		sound_event = "vo_announcement_new_destroy_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_manor = {
		sound_event = "vo_announcement_new_defend_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_cottage = {
		sound_event = "vo_announcement_new_destroy_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_cottage = {
		sound_event = "vo_announcement_new_defend_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_church = {
		sound_event = "vo_announcement_new_destroy_church_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_church = {
		sound_event = "vo_announcement_new_defend_church_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_barn = {
		sound_event = "vo_announcement_new_destroy_stable_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_barn = {
		sound_event = "vo_announcement_new_defend_stable_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_attack_gatehouse = {
		sound_event = "vo_announcement_new_destroy_gatehouse_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_gatehouse = {
		sound_event = "vo_announcement_new_defend_gatehouse_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_reinforce_outpost = {
		sound_event = "vo_announcement_new_defend_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_capture_outpost = {
		sound_event = "vo_announcement_new_destroy_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	assault_defend_keep = {
		sound_event = "vo_announcement_new_defend_keep_both",
		unique_id = "objective_description",
		layout_settings = HUDSettings.announcements.objective
	},
	attackers_time_extended = {
		layout_settings = HUDSettings.announcements.time_extended
	},
	defenders_time_extended = {
		layout_settings = HUDSettings.announcements.time_extended
	},
	assault_capturing_point = {
		announcement_delay = 15,
		layout_settings = HUDSettings.announcements.defender_event
	},
	assault_enemy_at_the_gate = {
		announcement_delay = 15,
		layout_settings = HUDSettings.announcements.defender_event
	},
	assault_pulling_lever = {
		announcement_delay = 15,
		layout_settings = HUDSettings.announcements.defender_event
	},
	only_time_left = {
		sound_event = "hud_countdown",
		unique_id = "timer",
		param1 = "round_time_left",
		layout_settings = HUDSettings.announcements.round_timer
	},
	own_team_is_winning = {
		sound_event = "vo_announcement_exclamation_pointsleft_twentyfive_both",
		param1 = "own_team_ui_name",
		layout_settings = HUDSettings.announcements.winning_losing
	},
	own_team_have_nearly_won = {
		sound_event = "vo_announcement_exclamation_pointsleft_five_both",
		param1 = "own_team_ui_name",
		layout_settings = HUDSettings.announcements.winning_losing
	},
	own_team_is_losing = {
		sound_event = "vo_announcement_warning_pointsleft_twentyfive_both",
		param1 = "own_team_ui_name",
		layout_settings = HUDSettings.announcements.winning_losing
	},
	own_team_have_nearly_lost = {
		sound_event = "vo_announcement_warning_pointsleft_five_both",
		param1 = "own_team_ui_name",
		layout_settings = HUDSettings.announcements.winning_losing
	},
	team_interacted_with_objective = {
		layout_settings = HUDSettings.announcements.winning_losing
	},
	own_team_only_need_last_point = {
		sound_event = "vo_announcement_exclamation_tdm_fewleft_both",
		param2 = "last_objective_ui_name",
		param1 = "own_team_ui_name",
		layout_settings = HUDSettings.announcements.winning_losing
	},
	own_team_have_captured_all_points = {
		sound_event = "vo_announcement_exclamation_objective_all_both",
		param1 = "own_team_ui_name",
		layout_settings = HUDSettings.announcements.winning_losing
	},
	enemy_team_only_need_last_point = {
		sound_event = "vo_announcement_tag_defend_fortification_both",
		param2 = "last_objective_ui_name",
		param1 = "enemy_team_ui_name",
		layout_settings = HUDSettings.announcements.winning_losing
	},
	enemy_team_have_captured_all_points = {
		sound_event = "vo_announcement_warning_objective_all_both",
		param1 = "enemy_team_ui_name",
		layout_settings = HUDSettings.announcements.winning_losing
	},
	headshot = {
		sound_event = "vo_announcement_exclamation_headshot_both",
		layout_settings = HUDSettings.announcements.achievement
	},
	longshot = {
		layout_settings = HUDSettings.announcements.achievement
	},
	killstreak = {
		sound_event = "vo_announcement_exclamation_killstreak_both",
		layout_settings = HUDSettings.announcements.achievement
	},
	multi_killstreak = {
		sound_event = "vo_announcement_exclamation_multikillstreak_both",
		layout_settings = HUDSettings.announcements.achievement
	},
	mega_killstreak = {
		sound_event = "vo_announcement_exclamation_megakillstreak_both",
		layout_settings = HUDSettings.announcements.achievement
	},
	wounded = {
		sound_event = "vo_announcement_exclamation_attack_both",
		layout_settings = HUDSettings.announcements.achievement
	},
	deserter_out_of_bonds = {
		sound_event = "hud_countdown",
		unique_id = "timer",
		layout_settings = HUDSettings.announcements.deserter_timer
	},
	traitor_out_of_bonds = {
		sound_event = "hud_countdown",
		unique_id = "timer",
		layout_settings = HUDSettings.announcements.deserter_timer
	},
	sp_tutorial_name_objective_completed = {
		sound_event = "Play_objective_win",
		layout_settings = HUDSettings.announcements.objective
	},
	sp_tutorial_description_objective_push = {
		layout_settings = HUDSettings.announcements.objective
	}
}
