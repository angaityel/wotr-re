-- chunkname: @scripts/settings/game_mode_settings.lua

require("scripts/settings/player_scoring")

GameModeMusicSettings = GameModeMusicSettings or {}
GameModeMusicSettings.normal = GameModeMusicSettings.normal or {}
GameModeMusicSettings.normal.minimum_play_time = 10
GameModeMusicSettings.intense = GameModeMusicSettings.intense or {}
GameModeMusicSettings.intense.minimum_play_time = 10
GameModeMusicSettings.intense.fade_out_time = 0
GameModeMusicSettings.intense.win_scale_criteria = 0.7
GameModeMusicSettings.critical = GameModeMusicSettings.critical or {}
GameModeMusicSettings.critical.minimum_play_time = 10
GameModeMusicSettings.critical.fade_out_time = 0
GameModeMusicSettings.critical.win_scale_criteria = 0.7
GameModeSettings = GameModeSettings or {}
GameModeSettings.base = {
	time_limit_alert = 30,
	class_name = "GameModeBase",
	visible = false,
	tagging_objectives = true,
	deserter_timer = 10,
	allow_ghost_talking = true,
	object_sets = {},
	objectives = {
		damage_multiplier = {
			melee = 1,
			default = 1,
			small_projectile = 0
		},
		friendly_damage_multiplier = {
			default = 0
		}
	},
	player_scoring = {
		attackers = PlayerScoring.default,
		defenders = PlayerScoring.default
	},
	spawn_settings = {
		squad_screen = true,
		pulse_offset_for_side = "attackers",
		pulse_length = 6,
		type = "pulse"
	},
	allowed_spawning = {
		pulse = true,
		single_player = false,
		personal = true,
		battle = false
	},
	ui_description = {
		unassigned = "gm_description_unassigned_missing",
		defenders = "gm_description_defenders_missing",
		attackers = "gm_description_attackers_missing"
	},
	battle_details = {
		lost = "battle_details_missing",
		lost_round = "battle_details_missing",
		draw_round = "battle_details_missing",
		won = "battle_details_missing",
		draw = "battle_details_missing",
		won_round = "battle_details_missing"
	},
	tip_of_the_day = {}
}
GameModeSettings.sp = table.clone(GameModeSettings.base)
GameModeSettings.sp.key = "sp"
GameModeSettings.sp.class_name = "GameModeSP"
GameModeSettings.sp.display_name = "gm_single_player"
GameModeSettings.sp.object_sets = {
	gm_sp = true
}
GameModeSettings.sp.spawn_settings.type = "single_player"
GameModeSettings.sp.allowed_spawning.single_player = true
GameModeSettings.sp.allowed_spawning.pulse = false
GameModeSettings.sp.allowed_spawning.personal = false
GameModeSettings.sp.allowed_spawning.battle = false
GameModeSettings.sp.spawn_settings.pulse_length = 0
GameModeSettings.sp.has_ai = true
GameModeSettings.sp.spawn_settings.squad_screen = true
GameModeSettings.sp.player_team = "defenders"
GameModeSettings.tdm = table.clone(GameModeSettings.base)
GameModeSettings.tdm.key = "tdm"
GameModeSettings.tdm.class_name = "GameModeTDM"
GameModeSettings.tdm.time_limit = 60
GameModeSettings.tdm.display_name = "gm_team_deathmatch"
GameModeSettings.tdm.battle_details = {
	lost = "battle_details_tdm_lost",
	won = "battle_details_tdm_won",
	draw = "battle_details_tdm_draw"
}
GameModeSettings.tdm.object_sets = {
	gm_tdm = true
}
GameModeSettings.tdm.visible = true
GameModeSettings.tdm.show_in_server_browser = true
GameModeSettings.tdm.ui_description = {
	unassigned = "gm_description_unassigned_tdm",
	defenders = "gm_description_defenders_tdm",
	attackers = "gm_description_attackers_tdm"
}
GameModeSettings.tdm.tip_of_the_day = {
	"tdm_tip_01"
}
GameModeSettings.battle = table.clone(GameModeSettings.base)
GameModeSettings.battle.key = "battle"
GameModeSettings.battle.class_name = "GameModeBattle"
GameModeSettings.battle.spawn_settings = {
	squad_screen = true,
	spawn_timer = 15,
	yield_timer = 5,
	type = "battle"
}
GameModeSettings.battle.allow_ghost_talking = false
GameModeSettings.battle.allowed_spawning.single_player = false
GameModeSettings.battle.allowed_spawning.pulse = false
GameModeSettings.battle.allowed_spawning.personal = false
GameModeSettings.battle.allowed_spawning.battle = true
GameModeSettings.battle.time_limit = 1200
GameModeSettings.battle.display_name = "gm_pitched_battle"
GameModeSettings.battle.object_sets = {
	gm_battle = true
}
GameModeSettings.battle.visible = true
GameModeSettings.battle.show_in_server_browser = true
GameModeSettings.battle.ui_description = {
	unassigned = "gm_description_unassigned_battle",
	defenders = "gm_description_defenders_battle",
	attackers = "gm_description_attackers_battle"
}
GameModeSettings.battle.tip_of_the_day = {
	"battle_tip_01",
	"battle_tip_02",
	"battle_tip_03",
	"battle_tip_04"
}
GameModeSettings.con = table.clone(GameModeSettings.base)
GameModeSettings.con.key = "con"
GameModeSettings.con.display_name = "gm_conquest"
GameModeSettings.con.class_name = "GameModeConquest"
GameModeSettings.con.time_limit = 900
GameModeSettings.con.object_sets = {
	gm_conquest = true
}
GameModeSettings.con.visible = true
GameModeSettings.con.show_in_server_browser = true
GameModeSettings.con.ui_description = {
	unassigned = "gm_description_unassigned_con",
	defenders = "gm_description_defenders_con",
	attackers = "gm_description_attackers_con"
}
GameModeSettings.con.tip_of_the_day = {
	"con_tip_01",
	"con_tip_02",
	"con_tip_03"
}
GameModeSettings.ttdm = table.clone(GameModeSettings.base)
GameModeSettings.ttdm.key = "ttdm"
GameModeSettings.ttdm.display_name = "gm_tactical_team_deathmatch"
GameModeSettings.ttdm.object_sets = {
	gm_ttdm = true
}
GameModeSettings.coop_wave = table.clone(GameModeSettings.base)
GameModeSettings.coop_wave.key = "coop_wave"
GameModeSettings.coop_wave.display_name = "gm_coop_wave"
GameModeSettings.coop_wave.has_ai = true
GameModeSettings.coop_wave.spawn_settings.squad_screen = false
GameModeSettings.coop_wave.player_team = "defenders"
GameModeSettings.ter = table.clone(GameModeSettings.base)
GameModeSettings.ter.key = "ter"
GameModeSettings.ter.display_name = "gm_territory"
GameModeSettings.ter.battle_details = {
	lost = "battle_details_ter_lost",
	won = "battle_details_ter_won",
	draw = "battle_details_ter_draw"
}
GameModeSettings.ter.object_sets = {
	gm_ter = true
}
GameModeSettings.ass = table.clone(GameModeSettings.base)
GameModeSettings.ass.key = "ass"
GameModeSettings.ass.display_name = "gm_assault"
GameModeSettings.ass.class_name = "GameModeAssault"
GameModeSettings.ass.time_limit = 300
GameModeSettings.ass.object_sets = {
	gm_assault = true
}
GameModeSettings.ass.visible = true
GameModeSettings.ass.tagging_objectives = false
GameModeSettings.ass.show_in_server_browser = true
GameModeSettings.ass.ui_description = {
	unassigned = "gm_description_unassigned_assault",
	defenders = "gm_description_defenders_assault",
	attackers = "gm_description_attackers_assault"
}
GameModeSettings.sie = table.clone(GameModeSettings.base)
GameModeSettings.sie.key = "sie"
GameModeSettings.sie.display_name = "gm_siege"
GameModeSettings.sie.battle_details = {
	lost = "battle_details_sie_lost",
	won = "battle_details_sie_won",
	draw = "battle_details_sie_draw"
}
GameModeSettings.sie.object_sets = {
	gm_siege = true
}
GameModeSettings.jou = table.clone(GameModeSettings.base)
GameModeSettings.jou.key = "jou"
GameModeSettings.jou.display_name = "gm_tourney_joust"
GameModeSettings.arc = table.clone(GameModeSettings.base)
GameModeSettings.arc.key = "arc"
GameModeSettings.arc.display_name = "gm_tourney_archery"
GameModeSettings.pas = table.clone(GameModeSettings.base)
GameModeSettings.pas.key = "pas"
GameModeSettings.pas.display_name = "gm_tourney_pas_darmes"
GameModeSettings.rac = table.clone(GameModeSettings.base)
GameModeSettings.rac.key = "rac"
GameModeSettings.rac.display_name = "gm_tourney_race"
GameModeSettings.mou = table.clone(GameModeSettings.base)
GameModeSettings.mou.key = "mou"
GameModeSettings.mou.display_name = "gm_tourney_mounted"
GameModeSettings.grail = table.clone(GameModeSettings.base)
GameModeSettings.grail.key = "grail"
GameModeSettings.grail.class_name = "GameModeGrail"
GameModeSettings.grail.deserter_timer = 3600
GameModeSettings.grail.display_name = "gm_grail"
GameModeSettings.grail.battle_details = {
	lost = "battle_details_grail_lost",
	won = "battle_details_grail_won",
	draw = "battle_details_grail_draw"
}
GameModeSettings.grail.object_sets = {
	gm_grail = true
}
GameModeSettings.grail.visible = true
GameModeSettings.grail.show_in_server_browser = true
GameModeSettings.gpu_prof = table.clone(GameModeSettings.base)
GameModeSettings.gpu_prof.class_name = "GameModeGpuProf"
GameModeSettings.gpu_prof.key = "gpu_prof"
GameModeSettings.gpu_prof.display_name = "gm_gpu_profile"
GameModeSettings.gpu_prof.object_sets = {
	gm_gpu_prof = true
}
GameModeSettings.gpu_prof.has_ai = true
GameModeSettings.gpu_prof.spawn_settings.squad_screen = false
GameModeSettings.gpu_prof.player_team = "defenders"
GameModeSettings.cpu_prof = table.clone(GameModeSettings.base)
GameModeSettings.cpu_prof.class_name = "GameModeCpuProf"
GameModeSettings.cpu_prof.key = "cpu_prof"
GameModeSettings.cpu_prof.display_name = "gm_cpu_profile"
GameModeSettings.cpu_prof.object_sets = {
	gm_cpu_prof = true
}
GameModeSettings.cpu_prof.has_ai = true
GameModeSettings.cpu_prof.spawn_settings.squad_screen = false
GameModeSettings.fly_through = table.clone(GameModeSettings.base)
GameModeSettings.fly_through.class_name = "GameModeFlyThrough"
GameModeSettings.fly_through.key = "fly_through"
GameModeSettings.fly_through.display_name = "gm_fly_through"
GameModeSettings.fly_through.object_sets = {
	gm_fly_through = true
}
GameModeSettings.fly_through.has_ai = true
GameModeSettings.fly_through.spawn_settings.squad_screen = false

for table_key, settings in pairs(GameModeSettings) do
	if table_key ~= "base" then
		fassert(settings.key, "[GameModeSettings] game mode %q is missing parameter \"key\".", table_key)
		fassert(settings.display_name, "[GameModeSettings] game mode %q is missing parameter \"display_name\".", table_key)
	end
end
