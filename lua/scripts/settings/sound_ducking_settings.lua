-- chunkname: @scripts/settings/sound_ducking_settings.lua

BusVolumeDefaults = {
	game_group = 0
}
DuckingConfigs = {}
DuckingConfigs.defaults = {
	fade_out_time = 0,
	volume = 0,
	bus_name = "game_group",
	fade_in_time = 0,
	delay = 0
}
DuckingConfigs.Play_objective_fail = {
	fade_out_time = 0.2,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0,
	delay = 0,
	duration = 1.5
}
DuckingConfigs.Play_objective_win = {
	fade_out_time = 0.2,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0,
	delay = 0,
	duration = 1.5
}
DuckingConfigs.lancaster_side_select = {
	fade_out_time = 0.2,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 2
}
DuckingConfigs.york_side_select = {
	fade_out_time = 0.2,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 2
}
DuckingConfigs.menu_battle_report_level_up = {
	fade_out_time = 0.2,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 2.5
}
DuckingConfigs.chr_heartbeat_loop = {
	fade_out_time = 0.1,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 2.5
}
DuckingConfigs.melee_hit_heavy = {
	fade_out_time = 0.1,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 0.5
}
DuckingConfigs.cannon_fire_near = {
	fade_out_time = 0.5,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.stunned_player_long = {
	fade_out_time = 1,
	volume = -16,
	bus_name = "game_group",
	fade_in_time = 0.2,
	delay = 0.3,
	duration = 2
}
DuckingConfigs.stunned_player_medium = {
	fade_out_time = 1,
	volume = -16,
	bus_name = "game_group",
	fade_in_time = 0.2,
	delay = 0.3,
	duration = 1
}
DuckingConfigs.stunned_player_short = {
	fade_out_time = 1,
	volume = -16,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0.1,
	duration = 0.7
}
DuckingConfigs.execution_sword_omni_2h_player = {
	fade_out_time = 0.3,
	volume = -100,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_dagger_player = {
	fade_out_time = 0.3,
	volume = -100,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_shield_player = {
	fade_out_time = 0.3,
	volume = -100,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_club_player = {
	fade_out_time = 0.3,
	volume = -100,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_sword_omni_2h_player_attacker = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_dagger_player_attacker = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_shield_player_attacker = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_sword_omni_2h_player_attacker = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_dagger_player_attacker = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.execution_shield_player_attacker = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 5
}
DuckingConfigs.vo_announcement_new_tdm_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_new_objective_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_warning_10seconds_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_warning_objective_all_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = ´1
}
DuckingConfigs.vo_announcement_exclamation_tdm_fewleft_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = ´1
}
DuckingConfigs.vo_announcement_new_defend_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_new_destroy_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_new_defend_gate_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_new_destroy_gate_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_new_destroy_tower_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_new_defend_tower_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_new_defend_church_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_announcement_new_destroy_church_both = {
	fade_out_time = 0.3,
	volume = -5,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0,
	duration = 1
}
DuckingConfigs.vo_intro_sp_bamburgh_both = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_sp_barnet_both = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_sp_clitheroe_both = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_sp_edgecote_both = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_sp_mortimerscross_both = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_sp_stalbans_both = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_sp_tournament_both = {
	fade_out_time = 0.3,
	volume = -10,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_outro_sp_bamburgh_both = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_outro_sp_barnet_both = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_outro_sp_clitheroe_both = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_outro_sp_edgecote_both = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_outro_sp_mortimerscross_both = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_outro_sp_stalbans_both = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_outro_sp_tournament_both = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_mp_bamburgh_both_01 = {
	fade_out_time = 1,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 1,
	delay = 0
}
DuckingConfigs.vo_intro_mp_barnet_both_01 = {
	fade_out_time = 1,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 1,
	delay = 0
}
DuckingConfigs.vo_intro_mp_clitheroe_both_01 = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_mp_edgecote_both_01 = {
	fade_out_time = 0.3,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 0.1,
	delay = 0
}
DuckingConfigs.vo_intro_mp_mortimerscross_both_01 = {
	fade_out_time = 1,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 1,
	delay = 0
}
DuckingConfigs.vo_intro_mp_stalbans_both_01 = {
	fade_out_time = 1,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 1,
	delay = 0
}
DuckingConfigs.vo_intro_mp_tournament_both_01 = {
	fade_out_time = 1,
	volume = -15,
	bus_name = "game_group",
	fade_in_time = 1,
	delay = 0
}
