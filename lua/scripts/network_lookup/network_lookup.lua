-- chunkname: @scripts/network_lookup/network_lookup.lua

require("scripts/settings/gear_require")
require("scripts/settings/ai_profiles")
require("scripts/settings/player_profiles")
require("scripts/settings/mount_profiles")
require("scripts/settings/level_settings")
require("scripts/settings/game_mode_settings")
require("scripts/settings/heads")
require("scripts/settings/helmets")
require("scripts/settings/armours")
require("scripts/settings/execution_definitions")
require("scripts/settings/coat_of_arms")
require("scripts/settings/player_data")
require("scripts/settings/prizes")
require("scripts/settings/medals")
require("scripts/settings/material_effect_mappings")
require("scripts/managers/voting/voting_manager")

NetworkLookup = {}
NetworkLookup.husks = {
	"units/beings/chr_horse/chr_horse",
	"units/beings/chr_horse/chr_horse_heavy",
	"units/beings/chr_template_char/chr_template_char_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_peasant_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_light_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_light_winter_husk",
	"units/beings/chr_wotr_man/chr_wotr_italian_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_medium_husk",
	"units/beings/chr_wotr_man/chr_wotr_swiss_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_medium_winter_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_heavy_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_light_juipon_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_medium_brigandine_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_galloglass_husk",
	"units/beings/chr_wotr_man/chr_wotr_man_heavy_milanese_husk",
	"units/gamemode/grail_pickup",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_barbed",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_cresent_moon",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_fire",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_long_bodkin",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_short_bodkin",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_standard",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_long_arrow_swallow_tail",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_barbed",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_cresent_moon",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_fire",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_long_bodkin",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_short_bodkin",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_standard",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_medium_arrow_swallow_tail",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_barbed",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_cresent_moon",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_fire",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_long_bodkin",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_short_bodkin",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_standard",
	"units/weapons/wpn_projectiles/wpn_arrow/wpn_short_arrow_swallow_tail",
	"units/weapons/wpn_projectiles/wpn_crossbow_bolt_standard/wpn_crossbow_bolt_standard",
	"units/weapons/wpn_projectiles/wpn_crossbow_bolt_firebolt/wpn_crossbow_bolt_firebolt",
	"units/weapons/wpn_projectiles/wpn_crossbow_bolt_frogleg/wpn_crossbow_bolt_frogleg",
	"units/weapons/wpn_projectiles/wpn_crossbow_bolt_hammerbolt/wpn_crossbow_bolt_hammerbolt",
	"units/weapons/wpn_projectiles/wpn_crossbow_bolt_whalerhead/wpn_crossbow_bolt_whalerhead",
	"units/weapons/wpn_capture_flag/wpn_capture_flag_red",
	"units/weapons/wpn_capture_flag/wpn_capture_flag_white"
}
NetworkLookup.squad_spawn_modes = {
	"off",
	"on",
	"no_combat"
}
NetworkLookup.assault_announcements = {
	"assault_capturing_point",
	"assault_enemy_at_the_gate",
	"assault_pulling_lever"
}
NetworkLookup.game_object_functions = {
	"cb_player_stats_created",
	"cb_player_stats_destroyed",
	"cb_player_damage_extension_game_object_created",
	"cb_player_damage_extension_game_object_destroyed",
	"cb_generic_damage_extension_game_object_created",
	"cb_generic_damage_extension_game_object_destroyed",
	"cb_generic_unit_interactable_created",
	"cb_generic_unit_interactable_destroyed",
	"cb_spawn_unit",
	"cb_spawn_gear",
	"cb_spawn_flag",
	"cb_spawn_projectile",
	"cb_destroy_object",
	"cb_destroy_player_unit",
	"cb_destroy_unit",
	"cb_destroy_gear",
	"cb_do_nothing",
	"cb_local_unit_spawned",
	"cb_migrate_object",
	"cb_local_gear_unit_spawned",
	"cb_local_projectile_spawned",
	"cb_spawn_point_created",
	"cb_player_game_object_created",
	"cb_player_game_object_destroyed",
	"cb_team_created",
	"cb_team_destroyed",
	"cb_spawn_point_game_object_created",
	"cb_capture_point_created",
	"cb_capture_point_destroyed",
	"cb_payload_created",
	"cb_payload_destroyed",
	"cb_player_profile_created",
	"cb_camera_game_object_destroyed",
	"cb_camera_game_object_created",
	"cb_projectile_game_object_destroyed",
	"cb_coat_of_arms_created",
	"cb_area_buff_game_object_created",
	"cb_area_buff_game_object_destroyed",
	"cb_vote_destroyed",
	"cb_vote_created"
}
NetworkLookup.perks = {}

for name, _ in pairs(Perks) do
	NetworkLookup.perks[#NetworkLookup.perks + 1] = name
end

NetworkLookup.movement_states = {
	"climbing",
	"dead",
	"executing",
	"jumping",
	"inair",
	"knocked_down",
	"landing",
	"mounted",
	"onground",
	"onground/idle",
	"onground/moving",
	"planting_flag",
	"reviving_teammate",
	"bandaging_teammate",
	"bandaging_self",
	"stunned",
	"triggering",
	"shield_bashing",
	"pushing",
	"calling_horse",
	"rushing",
	"mounted/dismounting",
	"mounted/mount_dead"
}
NetworkLookup.anims = {
	"bandage_end",
	"bandage_self",
	"bandage_team_mate",
	"banner_bonus_action",
	"banner_bonus_charge",
	"banner_bonus_finished",
	"both_hands/empty",
	"bow_aim",
	"bow_draw",
	"bow_action_cancel",
	"bow_action_finished",
	"bow_aim_cancel",
	"bow_empty",
	"bow_ready",
	"bow_release",
	"bow_release_reload",
	"bow_reload",
	"bow_tense",
	"cavalry_whistle_end",
	"cavalry_whistle_start",
	"charge_finished",
	"charge_hit_hard",
	"charge_start",
	"climb_end",
	"climb_enter",
	"climb_idle",
	"climb_idle_left",
	"climb_idle_mid",
	"climb_idle_right",
	"climb_move",
	"climb_top_enter",
	"climb_top_exit",
	"crossbow_aim",
	"crossbow_empty",
	"crossbow_hand_reload",
	"crossbow_hand_reload_finished",
	"crossbow_ready",
	"crossbow_recoil",
	"crossbow_unaim",
	"death",
	"death_decap",
	"dismount_horse",
	"dismount_horse_idle_left",
	"dismount_horse_idle_right",
	"dismount_horse_moving_right",
	"dismount_horse_moving_left",
	"execute_attacker_1h_sword_shield_front",
	"execute_attacker_2h_axe",
	"execute_attacker_club",
	"execute_attacker_dagger",
	"execute_attacker_dagger_kneeling",
	"execute_attacker_end",
	"execute_attacker_shield",
	"execute_attacker_sword_omni",
	"execute_victim_1h_sword_shield_front",
	"execute_victim_2h_axe",
	"execute_victim_club",
	"execute_victim_dagger",
	"execute_victim_dagger_kneeling",
	"execute_victim_shield",
	"execute_victim_sword_omni",
	"grenade_light_1h",
	"grenade_light_2h",
	"grenade_light_finished_1h",
	"grenade_light_finished_2h",
	"grenade_ready",
	"grenade_throw_1h",
	"grenade_throw_2h",
	"handgonne_aim",
	"handgonne_ignite",
	"handgonne_ready",
	"handgonne_recoil",
	"horse_aim_pose",
	"hit_reaction_lance_impact",
	"horse_dismounted",
	"horse_mounted",
	"idle",
	"interaction_end",
	"interaction_fire_cannon",
	"interaction_generic",
	"interaction_pull_lever",
	"interaction_raise_flag",
	"jump_fwd",
	"jump_idle",
	"knocked_down",
	"knocked_down_back_torso_blunt",
	"knocked_down_back_torso_cut",
	"knocked_down_bleed_out",
	"knocked_down_front_stomach_piercing",
	"knocked_down_front_torso_blunt",
	"knocked_down_left_front_face_cut",
	"knocked_down_left_front_torso_cut",
	"lance_couch",
	"lance_uncouch",
	"land_knocked_down",
	"land_heavy_moving_bwd",
	"land_heavy_moving_fwd",
	"land_heavy_moving_still",
	"land_heavy_still",
	"land_moving_bwd",
	"land_moving_fwd",
	"land_moving_still",
	"land_still",
	"lean",
	"left_hand/empty",
	"left_hand/shield",
	"mount_horse",
	"mounted_stun_backward",
	"mounted_stun_forward",
	"mounted_stun_land",
	"mounted_stun_left",
	"mounted_stun_right",
	"stun_spawn",
	"move_bwd",
	"move_fwd",
	"parry_pose_exit",
	"parry_pose_down",
	"parry_pose_left",
	"parry_pose_right",
	"parry_pose_up",
	"push_finished",
	"push_hit",
	"push_hit_hard",
	"push_miss",
	"push_start",
	"quick_swing_attack_down",
	"quick_swing_attack_finished",
	"quick_swing_attack_left",
	"quick_swing_attack_right",
	"quick_swing_attack_up",
	"reset",
	"revive_complete",
	"revive_abort",
	"revive_start",
	"revive_team_mate",
	"revive_team_mate_end",
	"right_hand/empty",
	"right_hand/1h_sword",
	"rush_fwd",
	"shield_bash_finished",
	"shield_bash_hit",
	"shield_bash_hit_hard",
	"shield_bash_miss",
	"shield_bash_pose_start",
	"shield_bash_start",
	"shield_up",
	"shield_down",
	"stun_back_head_down",
	"stun_back_head_left",
	"stun_back_head_right",
	"stun_back_head_up",
	"stun_back_legs_down",
	"stun_back_legs_left",
	"stun_back_legs_right",
	"stun_back_legs_up",
	"stun_back_stomach_down",
	"stun_back_stomach_left",
	"stun_back_stomach_right",
	"stun_back_stomach_up",
	"stun_back_torso_down",
	"stun_back_torso_left",
	"stun_back_torso_right",
	"stun_back_torso_up",
	"stun_end",
	"stun_front_head_down",
	"stun_front_head_left",
	"stun_front_head_right",
	"stun_front_head_up",
	"stun_front_legs_down",
	"stun_front_legs_left",
	"stun_front_legs_right",
	"stun_front_legs_up",
	"stun_front_stomach_down",
	"stun_front_stomach_left",
	"stun_front_stomach_right",
	"stun_front_stomach_up",
	"stun_front_torso_down",
	"stun_front_torso_left",
	"stun_front_torso_right",
	"stun_front_torso_up",
	"stun_horse_back",
	"stun_horse_front",
	"swing_attack_down",
	"swing_attack_finished",
	"swing_attack_interrupt",
	"swing_attack_left",
	"swing_attack_right",
	"swing_attack_up",
	"swing_attack_penalty_finished",
	"swing_attack_penalty_start",
	"swing_pose_blend",
	"swing_pose_exit",
	"to_1h_club",
	"to_1h_weapon",
	"to_2h_club",
	"to_2h_weapon",
	"to_arquebus",
	"to_bastard_weapon",
	"to_dagger",
	"to_longbow",
	"to_crossbow",
	"to_crouch",
	"to_grenade",
	"to_handgonne",
	"to_huntingbow",
	"to_inair",
	"to_lance",
	"to_onground",
	"to_polearm",
	"to_shield",
	"to_shortbow",
	"to_spear",
	"to_unarmed",
	"to_uncrouch",
	"to_unshield",
	"unlean",
	"weapon_unflip",
	"weapon_flip",
	"wield_longbow",
	"wield_crossbow",
	"wield_finished",
	"wield_handgonne",
	"wield_huntingbow",
	"wield_left_arm_back",
	"wield_left_arm_targe",
	"wield_polearm",
	"wield_right_arm_back",
	"wield_right_arm_right_hip",
	"wield_right_arm_left_hip",
	"wield_shortbow",
	"yield",
	"horse_backing",
	"horse_break",
	"horse_canter",
	"horse_charge",
	"horse_death",
	"horse_gallop",
	"horse_idle",
	"horse_idle_turn_left",
	"horse_idle_turn_right",
	"horse_jump",
	"horse_landing",
	"horse_to_inair",
	"horse_to_onground",
	"horse_trot",
	"horse_walk",
	"attack_time",
	"bow_draw_time",
	"bow_reload_time",
	"bow_shake",
	"bow_tense_time",
	"bow_hold_time",
	"charge_hit_hard_penalty_time",
	"climb_enter_exit_speed",
	"grenade_light_time",
	"lance_couch_time",
	"lance_uncouch_time",
	"push_hit_hard_penalty_time",
	"push_miss_penalty_time",
	"push_time",
	"revive_team_mate_time",
	"revive_time",
	"shield_bash_hit_hard_penalty_time",
	"shield_bash_miss_penalty_time",
	"shield_bash_pose_time",
	"shield_bash_time",
	"stun_time",
	"wield_time"
}
NetworkLookup.weapon_hit_parameters = {
	"parrying",
	"blocking",
	"up",
	"left",
	"right",
	"down",
	"up_switched",
	"left_switched",
	"right_switched",
	"down_switched",
	"soft",
	"hard",
	"couch",
	"not_penetrated",
	"prop",
	"gear",
	"blocking_gear",
	"character"
}
NetworkLookup.damage_types = {
	"yield",
	"kinetic",
	"cutting",
	"piercing",
	"slashing",
	"blunt",
	"piercing_projectile",
	"piercing_projectile2",
	"piercing_projectile3",
	"slashing_projectile2",
	"slashing_projectile",
	"blunt_projectile",
	"damage_over_time",
	"death_zone",
	"crush"
}
NetworkLookup.voices = {
	"commoner",
	"noble",
	"brian_blessed_commoner",
	"brian_blessed_noble"
}
NetworkLookup.damage_over_time_types = {
	"bleeding",
	"burning"
}
NetworkLookup.weapon_properties = {
	"bleeding",
	"burning",
	"stun",
	"penetration"
}
NetworkLookup.buff_types = {
	"reinforce",
	"replenish",
	"regen",
	"courage",
	"armour",
	"march_speed",
	"mounted_speed",
	"berserker"
}
NetworkLookup.debuff_types = {
	"burning",
	"bleeding",
	"wounded",
	"arrow"
}
NetworkLookup.inventory_slots = {
	"shield",
	"dagger",
	"one_handed_weapon",
	"two_handed_weapon"
}
NetworkLookup.armour_types = {
	"none",
	"armour_cloth",
	"armour_leather",
	"armour_mail",
	"armour_plate",
	"weapon_wood",
	"weapon_metal"
}
NetworkLookup.executions = {}

for name, _ in pairs(ExecutionDefinitions) do
	NetworkLookup.executions[#NetworkLookup.executions + 1] = name
end

NetworkLookup.level_keys = {}

for name, _ in pairs(LevelSettings) do
	NetworkLookup.level_keys[#NetworkLookup.level_keys + 1] = name
end

local unique_server_map_names = {}

for _, map in pairs(LevelSettings) do
	if map.game_server_map_name then
		unique_server_map_names[map.game_server_map_name] = true
	end
end

NetworkLookup.server_map_names = {}

for map_name, _ in pairs(unique_server_map_names) do
	NetworkLookup.server_map_names[#NetworkLookup.server_map_names + 1] = map_name:lower()
end

NetworkLookup.game_mode_keys = {}

for name, _ in pairs(GameModeSettings) do
	NetworkLookup.game_mode_keys[#NetworkLookup.game_mode_keys + 1] = name
end

NetworkLookup.inventory_gear = {}

for name, _ in pairs(Gear) do
	NetworkLookup.inventory_gear[#NetworkLookup.inventory_gear + 1] = name
end

NetworkLookup.mount_profiles = {}

for name, _ in pairs(MountProfiles) do
	NetworkLookup.mount_profiles[#NetworkLookup.mount_profiles + 1] = name
end

NetworkLookup.damage_range_types = {}

for name, _ in pairs(AttackDamageRangeTypes) do
	NetworkLookup.damage_range_types[#NetworkLookup.damage_range_types + 1] = name
end

NetworkLookup.heads = {}

for name, _ in pairs(Heads) do
	NetworkLookup.heads[#NetworkLookup.heads + 1] = name
end

NetworkLookup.head_materials = {}

for name, _ in pairs(HeadMaterials) do
	NetworkLookup.head_materials[#NetworkLookup.head_materials + 1] = name
end

NetworkLookup.helmets = {}

for name, _ in pairs(Helmets) do
	NetworkLookup.helmets[#NetworkLookup.helmets + 1] = name
end

NetworkLookup.helmet_attachments = {}

for _, attachments in pairs(HelmetAttachments) do
	for attachment_name, _ in pairs(attachments) do
		if not table.contains(NetworkLookup.helmet_attachments, attachment_name) then
			NetworkLookup.helmet_attachments[#NetworkLookup.helmet_attachments + 1] = attachment_name
		end
	end
end

NetworkLookup.armours = {}

for name, _ in pairs(Armours) do
	NetworkLookup.armours[#NetworkLookup.armours + 1] = name
end

NetworkLookup.directions = {
	"up",
	"down",
	"left",
	"right"
}
NetworkLookup.team = {
	"red",
	"white",
	"attackers",
	"defenders",
	"unassigned",
	"neutral",
	"draw",
	false
}
NetworkLookup.effects = {
	"fx/handgonne_muzzle_flash",
	"fx/impact_blood",
	"fx/bullet_sand"
}
NetworkLookup.projectiles = {
	"standard",
	"frogleg",
	"broad",
	"fire",
	"barbed",
	"bodkin",
	"armour_piercing",
	"hammer"
}
NetworkLookup.localized_strings = {
	"attackers_win",
	"flag_captured",
	"flag_lost_fallback",
	"defenders_win",
	"attackers_zone",
	"defenders_zone",
	"neutral_zone"
}
NetworkLookup.chat_channels = {
	"all",
	"dead",
	"team_red",
	"dead_team_red",
	"team_white",
	"dead_team_white",
	"team_unassigned",
	"dead_team_unassigned"
}
NetworkLookup.hit_zones = {
	"helmet",
	"head",
	"torso",
	"stomach",
	"forearms",
	"arms",
	"legs",
	"hands",
	"calfs",
	"feet",
	"body",
	"n/a"
}
NetworkLookup.surface_material_effects = {}

for name, _ in pairs(MaterialEffectMappings) do
	NetworkLookup.surface_material_effects[#NetworkLookup.surface_material_effects + 1] = name
end

NetworkLookup.gear_names = {}

for name, _ in pairs(Gear) do
	NetworkLookup.gear_names[#NetworkLookup.gear_names + 1] = name
end

NetworkLookup.coat_of_arms_field_colors = {}

for _, config in ipairs(CoatOfArms.field_colors) do
	NetworkLookup.coat_of_arms_field_colors[#NetworkLookup.coat_of_arms_field_colors + 1] = config.name
end

NetworkLookup.coat_of_arms_division_colors = {}

for _, config in ipairs(CoatOfArms.division_colors) do
	NetworkLookup.coat_of_arms_division_colors[#NetworkLookup.coat_of_arms_division_colors + 1] = config.name
end

NetworkLookup.coat_of_arms_division_types = {}

for _, config in ipairs(CoatOfArms.division_types) do
	NetworkLookup.coat_of_arms_division_types[#NetworkLookup.coat_of_arms_division_types + 1] = config.name
end

NetworkLookup.coat_of_arms_variation_types = {}

for _, config in ipairs(CoatOfArms.material_variation_types) do
	NetworkLookup.coat_of_arms_variation_types[#NetworkLookup.coat_of_arms_variation_types + 1] = config.name
end

NetworkLookup.coat_of_arms_variation_colors = {}

for _, config in ipairs(CoatOfArms.material_variation_colors) do
	NetworkLookup.coat_of_arms_variation_colors[#NetworkLookup.coat_of_arms_variation_colors + 1] = config.name
end

NetworkLookup.coat_of_arms_ordinary_colors = {}

for _, config in ipairs(CoatOfArms.ordinary_colors) do
	NetworkLookup.coat_of_arms_ordinary_colors[#NetworkLookup.coat_of_arms_ordinary_colors + 1] = config.name
end

NetworkLookup.coat_of_arms_ordinary_types = {}

for _, config in ipairs(CoatOfArms.ordinary_types) do
	NetworkLookup.coat_of_arms_ordinary_types[#NetworkLookup.coat_of_arms_ordinary_types + 1] = config.name
end

NetworkLookup.coat_of_arms_charge_colors = {}

for _, config in ipairs(CoatOfArms.charge_colors) do
	NetworkLookup.coat_of_arms_charge_colors[#NetworkLookup.coat_of_arms_charge_colors + 1] = config.name
end

NetworkLookup.coat_of_arms_charge_types = {}

for _, config in ipairs(CoatOfArms.charge_types) do
	NetworkLookup.coat_of_arms_charge_types[#NetworkLookup.coat_of_arms_charge_types + 1] = config.name
end

NetworkLookup.coat_of_arms_crests = {}

for _, config in ipairs(CoatOfArms.crests) do
	NetworkLookup.coat_of_arms_crests[#NetworkLookup.coat_of_arms_crests + 1] = config.name
end

NetworkLookup.prizes = {}

for name, _ in pairs(Prizes.COLLECTION) do
	NetworkLookup.prizes[#NetworkLookup.prizes + 1] = name
end

NetworkLookup.medals = {}

for name, _ in pairs(Medals.COLLECTION) do
	NetworkLookup.medals[#NetworkLookup.medals + 1] = name
end

NetworkLookup.network_dump_tags = {
	"LAG!"
}
NetworkLookup.xp_reason = {
	"enemy_damage",
	"headshot",
	"longshot",
	"squad_spawn",
	"objective_captured",
	"objective_captured_assist",
	"execution",
	"enemy_instakill",
	"enemy_knockdown",
	"successive_kill",
	"assist",
	"squad_wipe",
	"tag_kill",
	"revive",
	"team_bandage",
	"tagger_reward",
	"enemy_kill_within_objective",
	"section_cleared_payload"
}
NetworkLookup.penalty_reason = {
	"team_kill",
	"team_damage"
}
NetworkLookup.voting_types = {}

for name, _ in pairs(VotingTypes) do
	local index = #NetworkLookup.voting_types + 1

	NetworkLookup.voting_types[index] = name
end

NetworkLookup.gate_states = {
	"open",
	"closed"
}

local function init(self, name)
	for index, str in ipairs(self) do
		assert(not self[str], "[NetworkLookup.lua] Duplicate entry in " .. name .. ".")

		self[str] = index
	end

	local index_error_print = "[NetworkLookup.lua] Table " .. name .. " does not contain key: "
	local meta = {
		__index = function(_, key)
			assert(false, index_error_print .. tostring(key))
		end
	}

	setmetatable(self, meta)
end

for key, lookup_table in pairs(NetworkLookup) do
	init(lookup_table, key)
end
