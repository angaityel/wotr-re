-- chunkname: @scripts/settings/perk_settings.lua

PerkSlotTypes = PerkSlotTypes or {}
PerkSlotTypes.offensive = {
	"archer",
	"man_at_arms"
}
PerkSlotTypes.defensive = {
	"armour_training",
	"shield_bearer"
}
PerkSlotTypes.supportive = {
	"watchman",
	"surgeon"
}
PerkSlotTypes.movement = {
	"infantry",
	"cavalry"
}
PerkSlotTypes.officer = {
	"officer_training"
}
PerkSlots = {
	{
		game_object_field = "offensive_basic",
		name = "offensive_basic",
		type = "offensive"
	},
	{
		game_object_field = "offensive_specialization_1",
		name = "offensive_specialization_1",
		type = "offensive"
	},
	{
		game_object_field = "offensive_specialization_2",
		name = "offensive_specialization_2",
		type = "offensive"
	},
	{
		game_object_field = "defensive_basic",
		name = "defensive_basic",
		type = "defensive"
	},
	{
		game_object_field = "defensive_specialization_1",
		name = "defensive_specialization_1",
		type = "defensive"
	},
	{
		game_object_field = "defensive_specialization_2",
		name = "defensive_specialization_2",
		type = "defensive"
	},
	{
		game_object_field = "supportive_basic",
		name = "supportive_basic",
		type = "supportive"
	},
	{
		game_object_field = "supportive_specialization_1",
		name = "supportive_specialization_1",
		type = "supportive"
	},
	{
		game_object_field = "supportive_specialization_2",
		name = "supportive_specialization_2",
		type = "supportive"
	},
	{
		game_object_field = "movement_basic",
		name = "movement_basic",
		type = "movement"
	},
	{
		game_object_field = "movement_specialization_1",
		name = "movement_specialization_1",
		type = "movement"
	},
	{
		game_object_field = "movement_specialization_2",
		name = "movement_specialization_2",
		type = "movement"
	},
	{
		game_object_field = "officer_basic",
		name = "officer_basic",
		type = "officer"
	},
	{
		game_object_field = "officer_specialization_1",
		name = "officer_specialization_1",
		type = "officer"
	},
	{
		game_object_field = "officer_specialization_2",
		name = "officer_specialization_2",
		type = "officer"
	}
}
Perks = Perks or {}
Perks.archer = Perks.archer or {}
Perks.archer.specializations = {
	"longbowman",
	"nimble_minded",
	"forest_warden",
	"sleight_of_hand",
	"marksman_training",
	"steady_aim",
	"eagle_eyed",
	"strong_of_arm"
}
Perks.archer.ui_header = "perk_name_archer"
Perks.archer.ui_description = "perk_description_archer"
Perks.archer.ui_short_description = "perk_short_description_archer"
Perks.archer.ui_fluff_text = "perk_fluff_archer"
Perks.archer.ui_texture = "perk_basic_dummy"
Perks.archer.market_price = 1000
Perks.archer.release_name = "main"
Perks.archer.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0058_archer",
	"menu_perk_icon_64_0059_background"
}
Perks.archer.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0058_archer",
	"menu_perk_icon_32_0059_background"
}
Perks.longbowman = Perks.longbowman or {}
Perks.longbowman.draw_time_multiplier = 0.5
Perks.longbowman.ui_header = "perk_name_longbowman"
Perks.longbowman.ui_description = "perk_description_longbowman"
Perks.longbowman.ui_fluff_text = "perk_fluff_longbowman"
Perks.longbowman.ui_texture = "perk_specialized_dummy"
Perks.longbowman.market_price = 2000
Perks.longbowman.release_name = "main"
Perks.longbowman.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0050_longbowman",
	"menu_perk_icon_64_0059_background"
}
Perks.longbowman.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0050_longbowman",
	"menu_perk_icon_32_0059_background"
}
Perks.nimble_minded = Perks.nimble_minded or {}
Perks.nimble_minded.extra_notches = 1
Perks.nimble_minded.ui_header = "perk_name_nimble_minded"
Perks.nimble_minded.ui_description = "perk_description_nimble_minded"
Perks.nimble_minded.ui_fluff_text = "perk_fluff_nimble_minded"
Perks.nimble_minded.ui_texture = "perk_specialized_dummy"
Perks.nimble_minded.market_price = 2000
Perks.nimble_minded.release_name = "main"
Perks.nimble_minded.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0048_nimble_minded",
	"menu_perk_icon_64_0059_background"
}
Perks.nimble_minded.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0048_nimble_minded",
	"menu_perk_icon_32_0059_background"
}
Perks.forest_warden = Perks.forest_warden or {}
Perks.forest_warden.movement_multiplier = 1.2
Perks.forest_warden.ui_header = "perk_name_forest_warden"
Perks.forest_warden.ui_description = "perk_description_forest_warden"
Perks.forest_warden.ui_fluff_text = "perk_fluff_forest_warden"
Perks.forest_warden.ui_texture = "perk_specialized_dummy"
Perks.forest_warden.market_price = 2000
Perks.forest_warden.release_name = "main"
Perks.forest_warden.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0054_forest_warden",
	"menu_perk_icon_64_0059_background"
}
Perks.forest_warden.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0054_forest_warden",
	"menu_perk_icon_32_0059_background"
}
Perks.sleight_of_hand = Perks.sleight_of_hand or {}
Perks.sleight_of_hand.reload_time_multiplier = 0.75
Perks.sleight_of_hand.ui_header = "perk_name_sleight_of_hand"
Perks.sleight_of_hand.ui_description = "perk_description_sleight_of_hand"
Perks.sleight_of_hand.ui_fluff_text = "perk_fluff_sleight_of_hand"
Perks.sleight_of_hand.ui_texture = "perk_specialized_dummy"
Perks.sleight_of_hand.market_price = 2000
Perks.sleight_of_hand.release_name = "main"
Perks.sleight_of_hand.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0053_sleight_of_hand",
	"menu_perk_icon_64_0059_background"
}
Perks.sleight_of_hand.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0053_sleight_of_hand",
	"menu_perk_icon_32_0059_background"
}
Perks.marksman_training = Perks.marksman_training or {}
Perks.marksman_training.gravity_multiplier = 0.7
Perks.marksman_training.ui_header = "perk_name_marksman_training"
Perks.marksman_training.ui_description = "perk_description_marksman_training"
Perks.marksman_training.ui_fluff_text = "perk_fluff_marksman_training"
Perks.marksman_training.ui_texture = "perk_specialized_dummy"
Perks.marksman_training.market_price = 2000
Perks.marksman_training.release_name = "main"
Perks.marksman_training.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0055_marksman_training",
	"menu_perk_icon_64_0059_background"
}
Perks.marksman_training.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0055_marksman_training",
	"menu_perk_icon_32_0059_background"
}
Perks.steady_aim = Perks.steady_aim or {}
Perks.steady_aim.shake_time_multiplier = 1.3
Perks.steady_aim.ui_header = "perk_name_steady_aim"
Perks.steady_aim.ui_description = "perk_description_steady_aim"
Perks.steady_aim.ui_fluff_text = "perk_fluff_steady_aim"
Perks.steady_aim.ui_texture = "perk_specialized_dummy"
Perks.steady_aim.market_price = 2000
Perks.steady_aim.release_name = "main"
Perks.steady_aim.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0056_steady_aim",
	"menu_perk_icon_64_0059_background"
}
Perks.steady_aim.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0056_steady_aim",
	"menu_perk_icon_32_0059_background"
}
Perks.eagle_eyed = Perks.eagle_eyed or {}
Perks.eagle_eyed.ui_header = "perk_name_eagle_eyed"
Perks.eagle_eyed.ui_description = "perk_description_eagle_eyed"
Perks.eagle_eyed.ui_fluff_text = "perk_fluff_eagle_eyed"
Perks.eagle_eyed.ui_texture = "perk_specialized_dummy"
Perks.eagle_eyed.market_price = 2000
Perks.eagle_eyed.release_name = "main"
Perks.eagle_eyed.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0052_eagle_eyed",
	"menu_perk_icon_64_0059_background"
}
Perks.eagle_eyed.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0052_eagle_eyed",
	"menu_perk_icon_32_0059_background"
}
Perks.strong_of_arm = Perks.strong_of_arm or {}
Perks.strong_of_arm.bow_hold_time = 1.3
Perks.strong_of_arm.ui_header = "perk_name_strong_of_arm"
Perks.strong_of_arm.ui_description = "perk_description_strong_of_arm"
Perks.strong_of_arm.ui_fluff_text = "perk_fluff_strong_of_arm"
Perks.strong_of_arm.ui_texture = "perk_specialized_dummy"
Perks.strong_of_arm.market_price = 2000
Perks.strong_of_arm.release_name = "main"
Perks.strong_of_arm.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0051_strong_arm",
	"menu_perk_icon_64_0059_background"
}
Perks.strong_of_arm.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0051_strong_arm",
	"menu_perk_icon_32_0059_background"
}
Perks.man_at_arms = Perks.man_at_arms or {}
Perks.man_at_arms.specializations = {
	"highwayman",
	"shield_breaker",
	"riposte",
	"break_block",
	"hamstring",
	"push"
}
Perks.man_at_arms.hard_multiplier = 0.5
Perks.man_at_arms.not_penetrated_modifier = 0.9
Perks.man_at_arms.blocked_multiplier = 1
Perks.man_at_arms.parried_multiplier = 1
Perks.man_at_arms.miss_multiplier = 0.8
Perks.man_at_arms.move_speed_multiplier = 1.1
Perks.man_at_arms.ui_header = "perk_name_man_at_arms"
Perks.man_at_arms.ui_description = "perk_description_man_at_arms"
Perks.man_at_arms.ui_short_description = "perk_short_description_man_at_arms"
Perks.man_at_arms.ui_fluff_text = "perk_fluff_man_at_arms"
Perks.man_at_arms.ui_texture = "perk_basic_dummy"
Perks.man_at_arms.market_price = 1000
Perks.man_at_arms.release_name = "main"
Perks.man_at_arms.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0057_man_at_arms",
	"menu_perk_icon_64_0059_background"
}
Perks.man_at_arms.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0057_man_at_arms",
	"menu_perk_icon_32_0059_background"
}
Perks.highwayman = Perks.highwayman or {}
Perks.highwayman.wield_time_multiplier = 0.6
Perks.highwayman.ui_header = "perk_name_highwayman"
Perks.highwayman.ui_description = "perk_description_highwayman"
Perks.highwayman.ui_fluff_text = "perk_fluff_highwayman"
Perks.highwayman.ui_texture = "perk_specialized_dummy"
Perks.highwayman.market_price = 2000
Perks.highwayman.release_name = "main"
Perks.highwayman.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0045_highwayman",
	"menu_perk_icon_64_0059_background"
}
Perks.highwayman.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0045_highwayman",
	"menu_perk_icon_32_0059_background"
}
Perks.shield_breaker = Perks.shield_breaker or {}
Perks.shield_breaker.damage_multiplier = 2
Perks.shield_breaker.ui_header = "perk_name_shield_breaker"
Perks.shield_breaker.ui_description = "perk_description_shield_breaker"
Perks.shield_breaker.ui_fluff_text = "perk_fluff_shield_breaker"
Perks.shield_breaker.ui_texture = "perk_specialized_dummy"
Perks.shield_breaker.market_price = 2000
Perks.shield_breaker.release_name = "main"
Perks.shield_breaker.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0042_shield_breaker",
	"menu_perk_icon_64_0059_background"
}
Perks.shield_breaker.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0042_shield_breaker",
	"menu_perk_icon_32_0059_background"
}
Perks.riposte = Perks.riposte or {}
Perks.riposte.pose_speed_multiplier = 0.75
Perks.riposte.timer = 3
Perks.riposte.cooldown = 0
Perks.riposte.ui_header = "perk_name_riposte"
Perks.riposte.ui_description = "perk_description_riposte"
Perks.riposte.ui_fluff_text = "perk_fluff_riposte"
Perks.riposte.ui_texture = "perk_specialized_dummy"
Perks.riposte.market_price = 2000
Perks.riposte.release_name = "main"
Perks.riposte.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0046_riposte",
	"menu_perk_icon_64_0059_background"
}
Perks.riposte.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0046_riposte",
	"menu_perk_icon_32_0059_background"
}
Perks.break_block = Perks.break_block or {}
Perks.break_block.ui_header = "perk_name_break_block"
Perks.break_block.ui_description = "perk_description_break_block"
Perks.break_block.ui_fluff_text = "perk_fluff_break_block"
Perks.break_block.ui_texture = "perk_specialized_dummy"
Perks.break_block.market_price = 2000
Perks.break_block.release_name = "main"
Perks.break_block.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0043_fencing_master",
	"menu_perk_icon_64_0059_background"
}
Perks.break_block.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0043_fencing_master",
	"menu_perk_icon_32_0059_background"
}
Perks.hamstring = Perks.hamstring or {}
Perks.hamstring.ui_header = "perk_name_hamstring"
Perks.hamstring.ui_description = "perk_description_hamstring"
Perks.hamstring.ui_fluff_text = "perk_fluff_hamstring"
Perks.hamstring.ui_texture = "perk_specialized_dummy"
Perks.hamstring.market_price = 2000
Perks.hamstring.release_name = "main"
Perks.hamstring.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0041_hamstring",
	"menu_perk_icon_64_0059_background"
}
Perks.hamstring.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0041_hamstring",
	"menu_perk_icon_32_0059_background"
}
Perks.push = Perks.push or {}
Perks.push.ui_header = "perk_name_push"
Perks.push.ui_description = "perk_description_push"
Perks.push.ui_fluff_text = "perk_fluff_push"
Perks.push.ui_texture = "perk_specialized_dummy"
Perks.push.market_price = 2000
Perks.push.release_name = "main"
Perks.push.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0044_push",
	"menu_perk_icon_64_0059_background"
}
Perks.push.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0044_push",
	"menu_perk_icon_32_0059_background"
}
Perks.shield_bearer = Perks.shield_bearer or {}
Perks.shield_bearer.specializations = {
	"shield_wall",
	"shield_expert",
	"shield_bash"
}
Perks.shield_bearer.ui_header = "perk_name_shield_bearer"
Perks.shield_bearer.ui_description = "perk_description_shield_bearer"
Perks.shield_bearer.ui_short_description = "perk_short_description_shield_bearer"
Perks.shield_bearer.ui_fluff_text = "perk_fluff_shield_bearer"
Perks.shield_bearer.ui_texture = "perk_basic_dummy"
Perks.shield_bearer.market_price = 1000
Perks.shield_bearer.release_name = "main"
Perks.shield_bearer.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0039_shield_bearer",
	"menu_perk_icon_64_0059_background"
}
Perks.shield_bearer.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0039_shield_bearer",
	"menu_perk_icon_32_0059_background"
}
Perks.shield_wall = Perks.shield_wall or {}
Perks.shield_wall.movement_multiplier = 1.2
Perks.shield_wall.ui_header = "perk_name_shield_wall"
Perks.shield_wall.ui_description = "perk_description_shield_wall"
Perks.shield_wall.ui_fluff_text = "perk_fluff_shield_wall"
Perks.shield_wall.ui_texture = "perk_specialized_dummy"
Perks.shield_wall.market_price = 2000
Perks.shield_wall.release_name = "main"
Perks.shield_wall.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0039_shield_bearer",
	"menu_perk_icon_64_0059_background"
}
Perks.shield_wall.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0039_shield_bearer",
	"menu_perk_icon_32_0059_background"
}
Perks.shield_expert = Perks.shield_expert or {}
Perks.shield_expert.encumbrance_multiplier = 0.1
Perks.shield_expert.market_price = 2000
Perks.shield_expert.release_name = "main"
Perks.shield_expert.ui_header = "perk_name_shield_expert"
Perks.shield_expert.ui_description = "perk_description_shield_expert"
Perks.shield_expert.ui_fluff_text = "perk_fluff_shield_expert"
Perks.shield_expert.ui_texture = "perk_specialized_dummy"
Perks.shield_expert.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0033_shield_expert",
	"menu_perk_icon_64_0059_background"
}
Perks.shield_expert.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0033_shield_expert",
	"menu_perk_icon_32_0059_background"
}
Perks.shield_bash = Perks.shield_bash or {}
Perks.shield_bash.market_price = 2000
Perks.shield_bash.release_name = "main"
Perks.shield_bash.ui_header = "perk_name_shield_bash"
Perks.shield_bash.ui_description = "perk_description_shield_bash"
Perks.shield_bash.ui_fluff_text = "perk_fluff_shield_bash"
Perks.shield_bash.ui_texture = "perk_specialized_dummy"
Perks.shield_bash.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0034_shield_bash",
	"menu_perk_icon_64_0059_background"
}
Perks.shield_bash.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0034_shield_bash",
	"menu_perk_icon_32_0059_background"
}
Perks.armour_training = Perks.armour_training or {}
Perks.armour_training.specializations = {
	"hardened",
	"thick_skinned",
	"regenerative",
	"oblivious"
}
Perks.armour_training.encumbrance_multiplier = 0.75
Perks.armour_training.market_price = 1000
Perks.armour_training.release_name = "main"
Perks.armour_training.ui_header = "perk_name_armour_training"
Perks.armour_training.ui_description = "perk_description_armour_training"
Perks.armour_training.ui_short_description = "perk_short_description_armour_training"
Perks.armour_training.ui_fluff_text = "perk_fluff_armour_training"
Perks.armour_training.ui_texture = "perk_basic_dummy"
Perks.armour_training.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0040_armour_training",
	"menu_perk_icon_64_0059_background"
}
Perks.armour_training.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0040_armour_training",
	"menu_perk_icon_32_0059_background"
}
Perks.hardened = Perks.hardened or {}
Perks.hardened.revive_duration_multiplier = 0.75
Perks.hardened.market_price = 2000
Perks.hardened.release_name = "main"
Perks.hardened.ui_header = "perk_name_hardened"
Perks.hardened.ui_description = "perk_description_hardened"
Perks.hardened.ui_fluff_text = "perk_fluff_hardened"
Perks.hardened.ui_texture = "perk_specialized_dummy"
Perks.hardened.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0036_hardened",
	"menu_perk_icon_64_0059_background"
}
Perks.hardened.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0036_hardened",
	"menu_perk_icon_32_0059_background"
}
Perks.thick_skinned = Perks.thick_skinned or {}
Perks.thick_skinned.absorption_multiplier = 1.15
Perks.thick_skinned.market_price = 2000
Perks.thick_skinned.release_name = "main"
Perks.thick_skinned.ui_header = "perk_name_thick_skinned"
Perks.thick_skinned.ui_description = "perk_description_thick_skinned"
Perks.thick_skinned.ui_fluff_text = "perk_fluff_thick_skinned"
Perks.thick_skinned.ui_texture = "perk_specialized_dummy"
Perks.thick_skinned.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0038_thick_skinned",
	"menu_perk_icon_64_0059_background"
}
Perks.thick_skinned.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0038_thick_skinned",
	"menu_perk_icon_32_0059_background"
}
Perks.regenerative = Perks.regenerative or {}
Perks.regenerative.self_duration_multiplier = 0.7
Perks.regenerative.market_price = 2000
Perks.regenerative.release_name = "main"
Perks.regenerative.ui_header = "perk_name_regenerative"
Perks.regenerative.ui_description = "perk_description_regenerative"
Perks.regenerative.ui_fluff_text = "perk_fluff_regenerative"
Perks.regenerative.ui_texture = "perk_specialized_dummy"
Perks.regenerative.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0035_regenerative",
	"menu_perk_icon_64_0059_background"
}
Perks.regenerative.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0035_regenerative",
	"menu_perk_icon_32_0059_background"
}
Perks.oblivious = Perks.oblivious or {}
Perks.oblivious.market_price = 2000
Perks.oblivious.release_name = "main"
Perks.oblivious.ui_header = "perk_name_oblivious"
Perks.oblivious.ui_description = "perk_description_oblivious"
Perks.oblivious.ui_fluff_text = "perk_fluff_oblivious"
Perks.oblivious.ui_texture = "perk_specialized_dummy"
Perks.oblivious.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0037_oblivious",
	"menu_perk_icon_64_0059_background"
}
Perks.oblivious.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0037_oblivious",
	"menu_perk_icon_32_0059_background"
}
Perks.watchman = Perks.watchman or {}
Perks.watchman.specializations = {
	"keen_eyes",
	"spotter"
}
Perks.watchman.interact_multiplier = 0.7
Perks.watchman.market_price = 1000
Perks.watchman.release_name = "main"
Perks.watchman.ui_header = "perk_name_watchman"
Perks.watchman.ui_description = "perk_description_watchman"
Perks.watchman.ui_short_description = "perk_short_description_watchman"
Perks.watchman.ui_fluff_text = nil
Perks.watchman.ui_texture = "perk_basic_dummy"
Perks.watchman.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0031_watchman",
	"menu_perk_icon_64_0059_background"
}
Perks.watchman.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0031_watchman",
	"menu_perk_icon_32_0059_background"
}
Perks.keen_eyes = Perks.keen_eyes or {}
Perks.keen_eyes.delay_multiplier = 0.2
Perks.keen_eyes.market_price = 2000
Perks.keen_eyes.release_name = "main"
Perks.keen_eyes.ui_header = "perk_name_keen_eyes"
Perks.keen_eyes.ui_description = "perk_description_keen_eyes"
Perks.keen_eyes.ui_fluff_text = "perk_fluff_keen_eyes"
Perks.keen_eyes.ui_texture = "perk_specialized_dummy"
Perks.keen_eyes.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0027_keen_eyes",
	"menu_perk_icon_64_0059_background"
}
Perks.keen_eyes.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0027_keen_eyes",
	"menu_perk_icon_32_0059_background"
}
Perks.spotter = Perks.spotter or {}
Perks.spotter.tagging_duration_multiplier = 1.3
Perks.spotter.market_price = 2000
Perks.spotter.release_name = "main"
Perks.spotter.ui_header = "perk_name_spotter"
Perks.spotter.ui_description = "perk_description_spotter"
Perks.spotter.ui_fluff_text = "perk_fluff_spotter"
Perks.spotter.ui_texture = "perk_specialized_dummy"
Perks.spotter.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0028_spotter",
	"menu_perk_icon_64_0059_background"
}
Perks.spotter.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0028_spotter",
	"menu_perk_icon_32_0059_background"
}
Perks.surgeon = Perks.surgeon or {}
Perks.surgeon.specializations = {
	"sterilised_bandages",
	"second_opinion",
	"barber_surgeon"
}
Perks.surgeon.teammate_duration_multiplier = 0.6
Perks.surgeon.self_duration_multiplier = 1
Perks.surgeon.market_price = 1000
Perks.surgeon.release_name = "main"
Perks.surgeon.ui_header = "perk_name_surgeon"
Perks.surgeon.ui_description = "perk_description_surgeon"
Perks.surgeon.ui_short_description = "perk_short_description_surgeon"
Perks.surgeon.ui_fluff_text = "perk_fluff_surgeon"
Perks.surgeon.ui_texture = "perk_basic_dummy"
Perks.surgeon.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0030_surgeon",
	"menu_perk_icon_64_0059_background"
}
Perks.surgeon.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0030_surgeon",
	"menu_perk_icon_32_0059_background"
}
Perks.sterilised_bandages = Perks.sterilised_bandages or {}
Perks.sterilised_bandages.market_price = 2000
Perks.sterilised_bandages.release_name = "main"
Perks.sterilised_bandages.ui_header = "perk_name_sterilised_bandages"
Perks.sterilised_bandages.ui_description = "perk_description_sterilised_bandages"
Perks.sterilised_bandages.ui_fluff_text = "perk_fluff_sterilised_bandages"
Perks.sterilised_bandages.ui_texture = "perk_specialized_dummy"
Perks.sterilised_bandages.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0026_sterilised_bandages",
	"menu_perk_icon_64_0059_background"
}
Perks.sterilised_bandages.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0026_sterilised_bandages",
	"menu_perk_icon_32_0059_background"
}
Perks.barber_surgeon = Perks.barber_surgeon or {}
Perks.barber_surgeon.revive_duration_multiplier = 0.7
Perks.barber_surgeon.market_price = 2000
Perks.barber_surgeon.release_name = "main"
Perks.barber_surgeon.ui_header = "perk_name_barber_surgeon"
Perks.barber_surgeon.ui_description = "perk_description_barber_surgeon"
Perks.barber_surgeon.ui_fluff_text = "perk_fluff_barber_surgeon"
Perks.barber_surgeon.ui_texture = "perk_specialized_dummy"
Perks.barber_surgeon.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0024_barber_surgeon",
	"menu_perk_icon_64_0059_background"
}
Perks.barber_surgeon.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0024_barber_surgeon",
	"menu_perk_icon_32_0059_background"
}
Perks.second_opinion = Perks.second_opinion or {}
Perks.second_opinion.market_price = 2000
Perks.second_opinion.release_name = "main"
Perks.second_opinion.ui_header = "perk_name_second_opinion"
Perks.second_opinion.ui_description = "perk_description_second_opinion"
Perks.second_opinion.ui_fluff_text = "perk_fluff_second_opinion"
Perks.second_opinion.ui_texture = "perk_specialized_dummy"
Perks.second_opinion.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0025_second_opinion",
	"menu_perk_icon_64_0059_background"
}
Perks.second_opinion.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0025_second_opinion",
	"menu_perk_icon_32_0059_background"
}
Perks.cavalry = Perks.cavalry or {}
Perks.cavalry.specializations = {
	"heavy_cavalry",
	"horse_racer",
	"horse_master"
}
Perks.cavalry.duration = 8
Perks.cavalry.market_price = 1000
Perks.cavalry.release_name = "main"
Perks.cavalry.encumbrance_multiplier = 1.2
Perks.cavalry.ui_header = "perk_name_cavalry"
Perks.cavalry.ui_description = "perk_description_cavalry"
Perks.cavalry.ui_short_description = "perk_short_description_cavalry"
Perks.cavalry.ui_fluff_text = "perk_fluff_cavalry"
Perks.cavalry.ui_texture = "perk_basic_dummy"
Perks.cavalry.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0023_cavalry",
	"menu_perk_icon_64_0059_background"
}
Perks.cavalry.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0023_cavalry",
	"menu_perk_icon_32_0059_background"
}
Perks.heavy_cavalry = Perks.heavy_cavalry or {}
Perks.heavy_cavalry.market_price = 2000
Perks.heavy_cavalry.release_name = "main"
Perks.heavy_cavalry.ui_header = "perk_name_heavy_cavalry"
Perks.heavy_cavalry.ui_description = "perk_description_heavy_cavalry"
Perks.heavy_cavalry.ui_fluff_text = "perk_fluff_heavy_cavalry"
Perks.heavy_cavalry.ui_texture = "perk_basic_dummy"
Perks.heavy_cavalry.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0020_heavy_cavalry",
	"menu_perk_icon_64_0059_background"
}
Perks.heavy_cavalry.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0020_heavy_cavalry",
	"menu_perk_icon_32_0059_background"
}
Perks.horse_racer = Perks.horse_racer or {}
Perks.horse_racer.move_speed_multiplier = 1.15
Perks.horse_racer.market_price = 2000
Perks.horse_racer.release_name = "main"
Perks.horse_racer.ui_header = "perk_name_horse_racer"
Perks.horse_racer.ui_description = "perk_description_horse_racer"
Perks.horse_racer.ui_fluff_text = "perk_fluff_horse_racer"
Perks.horse_racer.ui_texture = "perk_basic_dummy"
Perks.horse_racer.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0016_horse_racer",
	"menu_perk_icon_64_0059_background"
}
Perks.horse_racer.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0016_horse_racer",
	"menu_perk_icon_32_0059_background"
}
Perks.horse_master = Perks.horse_master or {}
Perks.horse_master.rotation_multiplier = 100
Perks.horse_master.market_price = 2000
Perks.horse_master.release_name = "main"
Perks.horse_master.ui_header = "perk_name_horse_master"
Perks.horse_master.ui_description = "perk_description_horse_master"
Perks.horse_master.ui_fluff_text = "perk_fluff_horse_master"
Perks.horse_master.ui_texture = "perk_basic_dummy"
Perks.horse_master.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0021_horse_master",
	"menu_perk_icon_64_0059_background"
}
Perks.horse_master.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0021_horse_master",
	"menu_perk_icon_32_0059_background"
}
Perks.infantry = Perks.infantry or {}
Perks.infantry.specializations = {
	"runner",
	"field_warden",
	"city_watch",
	"cat_burglar",
	"fleet_footed"
}
Perks.infantry.encumbrance_multiplier = 0.5
Perks.infantry.stamina_regen_multiplier = 1.2
Perks.infantry.stamina_capacity_multiplier = 1.2
Perks.infantry.market_price = 1000
Perks.infantry.release_name = "main"
Perks.infantry.ui_header = "perk_name_infantry"
Perks.infantry.ui_description = "perk_description_infantry"
Perks.infantry.ui_short_description = "perk_short_description_infantry"
Perks.infantry.ui_fluff_text = "perk_fluff_infantry"
Perks.infantry.ui_texture = "perk_basic_dummy"
Perks.infantry.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0022_infantry",
	"menu_perk_icon_64_0059_background"
}
Perks.infantry.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0022_infantry",
	"menu_perk_icon_32_0059_background"
}
Perks.runner = Perks.runner or {}
Perks.runner.move_speed_multiplier = 1.1
Perks.runner.market_price = 2000
Perks.runner.release_name = "main"
Perks.runner.ui_header = "perk_name_runner"
Perks.runner.ui_description = "perk_description_runner"
Perks.runner.ui_fluff_text = "perk_fluff_runner"
Perks.runner.ui_texture = "perk_specialized_dummy"
Perks.runner.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0012_Runner",
	"menu_perk_icon_64_0059_background"
}
Perks.runner.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0012_Runner",
	"menu_perk_icon_32_0059_background"
}
Perks.field_warden = Perks.field_warden or {}
Perks.field_warden.height_multiplier = 1.15
Perks.field_warden.market_price = 2000
Perks.field_warden.release_name = "main"
Perks.field_warden.ui_header = "perk_name_field_warden"
Perks.field_warden.ui_description = "perk_description_field_warden"
Perks.field_warden.ui_fluff_text = "perk_fluff_field_warden"
Perks.field_warden.ui_texture = "perk_specialized_dummy"
Perks.field_warden.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0013_Field_Warden",
	"menu_perk_icon_64_0059_background"
}
Perks.field_warden.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0013_Field_Warden",
	"menu_perk_icon_32_0059_background"
}
Perks.fleet_footed = Perks.fleet_footed or {}
Perks.fleet_footed.acceleration_multiplier = 1.5
Perks.fleet_footed.market_price = 2000
Perks.fleet_footed.release_name = "main"
Perks.fleet_footed.ui_header = "perk_name_fleet_footed"
Perks.fleet_footed.ui_description = "perk_description_fleet_footed"
Perks.fleet_footed.ui_fluff_text = "perk_fluff_fleet_footed"
Perks.fleet_footed.ui_texture = "perk_specialized_dummy"
Perks.fleet_footed.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0011_Fleet_footed",
	"menu_perk_icon_64_0059_background"
}
Perks.fleet_footed.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0011_Fleet_footed",
	"menu_perk_icon_32_0059_background"
}
Perks.city_watch = Perks.city_watch or {}
Perks.city_watch.climbing_ladders_speed_multiplier = 1.5
Perks.city_watch.market_price = 2000
Perks.city_watch.release_name = "main"
Perks.city_watch.ui_header = "perk_name_city_watch"
Perks.city_watch.ui_description = "perk_description_city_watch"
Perks.city_watch.ui_fluff_text = "perk_fluff_city_watch"
Perks.city_watch.ui_texture = "perk_specialized_dummy"
Perks.city_watch.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0010_city_watch",
	"menu_perk_icon_64_0059_background"
}
Perks.city_watch.ui_textures_small = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0010_city_watch",
	"menu_perk_icon_64_0059_background"
}
Perks.cat_burglar = Perks.cat_burglar or {}
Perks.cat_burglar.height_multiplier = 1.3
Perks.cat_burglar.market_price = 2000
Perks.cat_burglar.release_name = "main"
Perks.cat_burglar.ui_header = "perk_name_cat_burglar"
Perks.cat_burglar.ui_description = "perk_description_cat_burglar"
Perks.cat_burglar.ui_fluff_text = "perk_fluff_cat_burglar"
Perks.cat_burglar.ui_texture = "perk_specialized_dummy"
Perks.cat_burglar.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0015_cat_burglar",
	"menu_perk_icon_64_0059_background"
}
Perks.cat_burglar.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0015_cat_burglar",
	"menu_perk_icon_32_0059_background"
}
Perks.officer_training = Perks.officer_training or {}
Perks.officer_training.specializations = {
	"reinforce",
	"replenish",
	"courage",
	"armour",
	"march_speed",
	"mounted_speed",
	"berserker"
}
Perks.officer_training.market_price = 1000
Perks.officer_training.release_name = "main"
Perks.officer_training.ui_header = "perk_name_officer_training"
Perks.officer_training.ui_description = "perk_description_officer_training"
Perks.officer_training.ui_short_description = "perk_short_description_officer_training"
Perks.officer_training.ui_fluff_text = "perk_fluff_officer_training"
Perks.officer_training.ui_texture = "perk_basic_dummy"
Perks.officer_training.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0009_experienced_Officer",
	"menu_perk_icon_64_0059_background"
}
Perks.officer_training.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0009_experienced_Officer",
	"menu_perk_icon_32_0059_background"
}
Perks.reinforce = Perks.reinforce or {}
Perks.reinforce.activatable = true
Perks.reinforce.activate_animation = "activate_anaimation"
Perks.reinforce.hud_activation_icon = "hud_buff_icon_damage"
Perks.reinforce.market_price = 2000
Perks.reinforce.release_name = "main"
Perks.reinforce.ui_header = "perk_name_reinforce_banner_bonus"
Perks.reinforce.ui_description = "perk_description_reinforce_banner_bonus"
Perks.reinforce.ui_fluff_text = "perk_fluff_reinforce_banner_bonus"
Perks.reinforce.ui_texture = "perk_specialized_dummy"
Perks.reinforce.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0007_reinforce_banner",
	"menu_perk_icon_64_0059_background"
}
Perks.reinforce.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0007_reinforce_banner",
	"menu_perk_icon_32_0059_background"
}
Perks.replenish = Perks.replenish or {}
Perks.replenish.activatable = true
Perks.replenish.activate_animation = "activate_anaimation"
Perks.replenish.hud_activation_icon = "hud_buff_icon_ammo"
Perks.replenish.market_price = 2000
Perks.replenish.release_name = "main"
Perks.replenish.ui_header = "perk_name_replenish_banner_bonus"
Perks.replenish.ui_description = "perk_description_replenish_banner_bonus"
Perks.replenish.ui_fluff_text = "perk_fluff_replenish_banner_bonus"
Perks.replenish.ui_texture = "perk_specialized_dummy"
Perks.replenish.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0008_replenish_banner",
	"menu_perk_icon_64_0059_background"
}
Perks.replenish.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0008_replenish_banner",
	"menu_perk_icon_32_0059_background"
}
Perks.regen = Perks.regen or {}
Perks.regen.activatable = true
Perks.regen.activate_animation = "activate_anaimation"
Perks.regen.hud_activation_icon = "hud_buff_icon_regen"
Perks.regen.market_price = 2000
Perks.regen.release_name = "main"
Perks.regen.ui_header = "perk_name_regen_banner_bonus"
Perks.regen.ui_description = "perk_description_regen_banner_bonus"
Perks.regen.ui_fluff_text = "perk_fluff_regen_banner_bonus"
Perks.regen.ui_texture = "perk_specialized_dummy"
Perks.regen.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0005_regen_banner",
	"menu_perk_icon_64_0059_background"
}
Perks.regen.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0005_regen_banner",
	"menu_perk_icon_32_0059_background"
}
Perks.courage = Perks.courage or {}
Perks.courage.activatable = true
Perks.courage.activate_animation = "activate_anaimation"
Perks.courage.hud_activation_icon = "hud_buff_icon_health"
Perks.courage.market_price = 2000
Perks.courage.release_name = "main"
Perks.courage.ui_header = "perk_name_courage_banner_bonus"
Perks.courage.ui_description = "perk_description_courage_banner_bonus"
Perks.courage.ui_fluff_text = "perk_fluff_courage_banner_bonus"
Perks.courage.ui_texture = "perk_specialized_dummy"
Perks.courage.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0006_courage_banner",
	"menu_perk_icon_64_0059_background"
}
Perks.courage.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0006_courage_banner",
	"menu_perk_icon_32_0059_background"
}
Perks.armour = Perks.armour or {}
Perks.armour.activatable = true
Perks.armour.activate_animation = "activate_anaimation"
Perks.armour.hud_activation_icon = "hud_buff_icon_armour"
Perks.armour.market_price = 2000
Perks.armour.release_name = "main"
Perks.armour.ui_header = "perk_name_armour_banner_bonus"
Perks.armour.ui_description = "perk_description_armour_banner_bonus"
Perks.armour.ui_fluff_text = "perk_fluff_armour_banner_bonus"
Perks.armour.ui_texture = "perk_specialized_dummy"
Perks.armour.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0004_armour_banner",
	"menu_perk_icon_64_0059_background"
}
Perks.armour.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0004_armour_banner",
	"menu_perk_icon_32_0059_background"
}
Perks.march_speed = Perks.march_speed or {}
Perks.march_speed.activatable = true
Perks.march_speed.activate_animation = "activate_anaimation"
Perks.march_speed.hud_activation_icon = "hud_buff_icon_foot"
Perks.march_speed.market_price = 2000
Perks.march_speed.release_name = "main"
Perks.march_speed.ui_header = "perk_name_march_speed_banner_bonus"
Perks.march_speed.ui_description = "perk_description_march_speed_banner_bonus"
Perks.march_speed.ui_fluff_text = "perk_fluff_march_speed_banner_bonus"
Perks.march_speed.ui_texture = "perk_specialized_dummy"
Perks.march_speed.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0003_march_speed_banner",
	"menu_perk_icon_64_0059_background"
}
Perks.march_speed.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0003_march_speed_banner",
	"menu_perk_icon_32_0059_background"
}
Perks.mounted_speed = Perks.mounted_speed or {}
Perks.mounted_speed.activatable = true
Perks.mounted_speed.activate_animation = "activate_anaimation"
Perks.mounted_speed.hud_activation_icon = "hud_buff_icon_mounted"
Perks.mounted_speed.market_price = 2000
Perks.mounted_speed.release_name = "main"
Perks.mounted_speed.ui_header = "perk_name_mounted_speed_banner_bonus"
Perks.mounted_speed.ui_description = "perk_description_mounted_speed_banner_bonus"
Perks.mounted_speed.ui_fluff_text = "perk_fluff_mounted_speed_banner_bonus"
Perks.mounted_speed.ui_texture = "perk_specialized_dummy"
Perks.mounted_speed.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0002_mounted_Speed_banner",
	"menu_perk_icon_64_0059_background"
}
Perks.mounted_speed.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0002_mounted_Speed_banner",
	"menu_perk_icon_32_0059_background"
}
Perks.berserker = Perks.berserker or {}
Perks.berserker.activatable = true
Perks.berserker.activate_animation = "activate_anaimation"
Perks.berserker.hud_activation_icon = "hud_buff_icon_berserker"
Perks.berserker.market_price = 2000
Perks.berserker.release_name = "main"
Perks.berserker.ui_header = "perk_name_berserker_banner_bonus"
Perks.berserker.ui_description = "perk_description_berserker_banner_bonus"
Perks.berserker.ui_fluff_text = "perk_fluff_berserker_banner_bonus"
Perks.berserker.ui_texture = "perk_specialized_dummy"
Perks.berserker.ui_textures_big = {
	"menu_perk_icon_64_0000_overlay",
	"menu_perk_icon_64_0001_berserker_banner",
	"menu_perk_icon_64_0059_background"
}
Perks.berserker.ui_textures_small = {
	"menu_perk_icon_32_0000_overlay",
	"menu_perk_icon_32_0001_berserker_banner",
	"menu_perk_icon_32_0059_background"
}
UIPerkModifications = {}
