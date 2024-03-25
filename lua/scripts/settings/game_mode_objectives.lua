-- chunkname: @scripts/settings/game_mode_objectives.lua

require("scripts/settings/hud_settings")

GameModeObjectives = GameModeObjectives or {}
GameModeObjectives = {
	[""] = {},
	kill_the_enemy_team = {
		announcement = "kill_the_enemy_team",
		param1 = "enemy_team_ui_name_definite_plural"
	},
	capture_level = {
		announcement = "capture_level",
		param1 = "current_level_name"
	},
	interact_with_attackers_objective = {
		announcement = "interact_with_attackers_objective",
		param1 = "attackers_objectives_grouped_on_interaction"
	},
	defend_attackers_objective = {
		announcement = "defend_attackers_objective",
		param1 = "attackers_objective_ui_names"
	},
	kill_tagged_enemy = {
		announcement = "kill_tagged_enemy",
		param1 = "name_of_player_tagged_by_squad_corporal"
	},
	execute_tagged_enemy = {
		announcement = "execute_tagged_enemy",
		param1 = "name_of_player_tagged_by_squad_corporal"
	},
	defend_tagged_team_member = {
		announcement = "defend_tagged_team_member",
		param1 = "name_of_player_tagged_by_squad_corporal"
	},
	revive_tagged_team_member = {
		announcement = "revive_tagged_team_member",
		param1 = "name_of_player_tagged_by_squad_corporal"
	},
	attack_tagged_objective = {
		announcement = "attack_tagged_objective",
		param2 = "name_of_objective_tagged_by_squad_corporal",
		param1 = "interaction_of_objective_tagged_by_squad_corporal"
	},
	defend_tagged_objective = {
		announcement = "defend_tagged_objective",
		param1 = "name_of_objective_tagged_by_squad_corporal"
	},
	pitched_battle_tiebreak_objective = {
		announcement = "pitched_battle_tiebreak"
	},
	attack_cart = {
		announcement = "assault_attack_cart"
	},
	defend_cart = {
		announcement = "assault_defend_cart"
	},
	raise_gate = {
		announcement = "assault_raise_gate"
	},
	defend_switch = {
		announcement = "assault_defend_switch"
	},
	attack_tower = {
		announcement = "assault_attack_tower"
	},
	defend_tower = {
		announcement = "assault_defend_tower"
	},
	attack_manor = {
		announcement = "assault_attack_manor"
	},
	defend_manor = {
		announcement = "assault_defend_manor"
	},
	attack_cottage = {
		announcement = "assault_attack_cottage"
	},
	defend_cottage = {
		announcement = "assault_defend_cottage"
	},
	attack_church = {
		announcement = "assault_attack_church"
	},
	defend_church = {
		announcement = "assault_defend_church"
	},
	attack_bombard = {
		announcement = "assault_attack_bombard"
	},
	defend_bombard = {
		announcement = "assault_defend_bombard"
	},
	raise_gate_nocannon = {
		announcement = "assault_raise_gate_nocannon"
	},
	destroy_gate = {
		announcement = "assault_destroy_gate"
	},
	defend_gate = {
		announcement = "assault_defend_gate"
	},
	attack_smithy = {
		announcement = "assault_attack_smithy"
	},
	defend_smithy = {
		announcement = "assault_defend_smithy"
	},
	attack_barn = {
		announcement = "assault_attack_barn"
	},
	defend_barn = {
		announcement = "assault_defend_barn"
	},
	attack_gatehouse = {
		announcement = "assault_attack_gatehouse"
	},
	defend_gatehouse = {
		announcement = "assault_defend_gatehouse"
	},
	capture_outpost = {
		announcement = "assault_capture_outpost"
	},
	reinforce_outpost = {
		announcement = "assault_reinforce_outpost"
	},
	sp_interact_with_objective = {
		announcement = "interact_with_attackers_objective",
		param1 = "sp_objectives_grouped_on_interaction"
	},
	sp_tutorial_description_objective_battle = {
		announcement = "kill_the_enemy_team",
		param1 = "enemy_team_ui_name_definite_plural"
	},
	sp_tutorial_description_objective_push = {
		announcement = "sp_tutorial_description_objective_push"
	},
	sp_tutorial_name_objective_5enemies = {
		announcement = "kill_the_enemy_team",
		param1 = "enemy_team_ui_name_definite_plural"
	},
	sp_tutorial_name_objective_10enemies = {
		announcement = "kill_the_enemy_team",
		param1 = "enemy_team_ui_name_definite_plural"
	},
	sp_tutorial_name_objective_25enemies = {
		announcement = "kill_the_enemy_team",
		param1 = "enemy_team_ui_name_definite_plural"
	},
	sp_tutorial_description_objective_assault = {
		param1 = "attackers_objectives_grouped_on_interaction"
	},
	sp_tutorial_name_tournament_sc_event = {
		announcement = "kill_the_enemy_team",
		param1 = "enemy_team_ui_name_definite_plural"
	},
	sp_tutorial_name_tournament_pasdarmes_event = {
		announcement = "interact_with_attackers_objective"
	},
	sp_tutorial_name_tournament_koth_event = {
		announcement = "defend_attackers_objective",
		param1 = "attackers_objective_ui_names"
	},
	sp_tutorial_name_tournament_arena_event = {
		announcement = "kill_the_enemy_team",
		param1 = "enemy_team_ui_name_definite_plural"
	},
	sp_tutorial_name_tournament_archery_event = {},
	sp_tutorial_name_tournament_ride_event = {},
	sp_tutorial_description_objective_capture = {},
	sp_tutorial_name_objective_completed = {
		announcement = "sp_tutorial_name_objective_completed"
	}
}
