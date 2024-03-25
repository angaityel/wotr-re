-- chunkname: @scripts/settings/player_effect_settings.lua

Buffs = Buffs or {}
Buffs.reinforce = Buffs.reinforce or {}
Buffs.reinforce.charge_time = 1
Buffs.reinforce.activation_time = 1.3
Buffs.reinforce.duration = 30
Buffs.reinforce.cooldown_time = 90
Buffs.reinforce.multiplier = 0.067
Buffs.reinforce.hud_icon = "hud_buff_icon_damage_small"
Buffs.reinforce.hud_timer_material = "hud_buff_cooldown_timer_one"
Buffs.reinforce.game_obj_level_key = "reinforce_level"
Buffs.reinforce.game_obj_end_time_key = "reinforce_end_time"
Buffs.reinforce.sound_event = "vo_banner_exclamation_reinforce"
Buffs.replenish = Buffs.replenish or {}
Buffs.replenish.charge_time = 1
Buffs.replenish.activation_time = 1.3
Buffs.replenish.duration = 30
Buffs.replenish.cooldown_time = 90
Buffs.replenish.multiplier = 1
Buffs.replenish.hud_icon = "hud_buff_icon_ammo_small"
Buffs.replenish.hud_timer_material = "hud_buff_cooldown_timer_two"
Buffs.replenish.game_obj_level_key = "replenish_level"
Buffs.replenish.game_obj_end_time_key = "replenish_end_time"
Buffs.replenish.sound_event = "vo_banner_exclamation_replenish"
Buffs.regen = Buffs.regen or {}
Buffs.regen.charge_time = 1
Buffs.regen.activation_time = 1.3
Buffs.regen.duration = 30
Buffs.regen.cooldown_time = 90
Buffs.regen.multiplier = 0.142
Buffs.regen.hud_icon = "hud_buff_icon_regen_small"
Buffs.regen.hud_timer_material = "hud_buff_cooldown_timer_three"
Buffs.regen.game_obj_level_key = "regen_level"
Buffs.regen.game_obj_end_time_key = "regen_end_time"
Buffs.regen.sound_event = "vo_banner_exclamation_regen"
Buffs.courage = Buffs.courage or {}
Buffs.courage.charge_time = 1
Buffs.courage.activation_time = 1.3
Buffs.courage.duration = 30
Buffs.courage.cooldown_time = 90
Buffs.courage.multiplier = 1
Buffs.courage.hud_icon = "hud_buff_icon_health_small"
Buffs.courage.hud_timer_material = "hud_buff_cooldown_timer_four"
Buffs.courage.game_obj_level_key = "courage_level"
Buffs.courage.game_obj_end_time_key = "courage_end_time"
Buffs.courage.sound_event = "vo_banner_exclamation_courage"
Buffs.armour = Buffs.armour or {}
Buffs.armour.charge_time = 1
Buffs.armour.activation_time = 1.3
Buffs.armour.duration = 30
Buffs.armour.cooldown_time = 90
Buffs.armour.multiplier = 0.067
Buffs.armour.hud_icon = "hud_buff_icon_armour_small"
Buffs.armour.hud_timer_material = "hud_buff_cooldown_timer_five"
Buffs.armour.game_obj_level_key = "armour_level"
Buffs.armour.game_obj_end_time_key = "armour_end_time"
Buffs.armour.sound_event = "vo_banner_exclamation_armour"
Buffs.march_speed = Buffs.march_speed or {}
Buffs.march_speed.charge_time = 1
Buffs.march_speed.activation_time = 1.3
Buffs.march_speed.duration = 30
Buffs.march_speed.cooldown_time = 90
Buffs.march_speed.multiplier = 0.1
Buffs.march_speed.hud_icon = "hud_buff_icon_foot_small"
Buffs.march_speed.hud_timer_material = "hud_buff_cooldown_timer_six"
Buffs.march_speed.game_obj_level_key = "march_speed_level"
Buffs.march_speed.game_obj_end_time_key = "march_speed_end_time"
Buffs.march_speed.sound_event = "vo_banner_exclamation_marchspeed"
Buffs.mounted_speed = Buffs.mounted_speed or {}
Buffs.mounted_speed.charge_time = 1
Buffs.mounted_speed.activation_time = 1.3
Buffs.mounted_speed.duration = 30
Buffs.mounted_speed.cooldown_time = 90
Buffs.mounted_speed.multiplier = 0.05
Buffs.mounted_speed.hud_icon = "hud_buff_icon_mounted_small"
Buffs.mounted_speed.hud_timer_material = "hud_buff_cooldown_timer_seven"
Buffs.mounted_speed.game_obj_level_key = "mounted_speed_level"
Buffs.mounted_speed.game_obj_end_time_key = "mounted_speed_end_time"
Buffs.mounted_speed.sound_event = "vo_banner_exclamation_mountedspeed"
Buffs.berserker = Buffs.berserker or {}
Buffs.berserker.charge_time = 1
Buffs.berserker.activation_time = 1.3
Buffs.berserker.duration = 20
Buffs.berserker.cooldown_time = 90
Buffs.berserker.multiplier = 0.269
Buffs.berserker.hud_icon = "hud_buff_icon_berserker_small"
Buffs.berserker.hud_timer_material = "hud_buff_cooldown_timer_eight"
Buffs.berserker.game_obj_level_key = "berserker_level"
Buffs.berserker.game_obj_end_time_key = "berserker_end_time"
Buffs.berserker.sound_event = "vo_banner_exclamation_berserker"
Debuffs = Debuffs or {}
Debuffs.wounded = Debuffs.wounded or {}
Debuffs.wounded.dps = 2
Debuffs.wounded.duration = 10
Debuffs.wounded.threshold = 0.8
Debuffs.wounded.max_dot_amount = 1
Debuffs.wounded.hud_icon = "hud_debuff_icon_wounded_small"
Debuffs.wounded.hud_timer_material = "hud_debuff_cooldown_timer_one"
Debuffs.bleeding = Debuffs.bleeding or {}
Debuffs.bleeding.dps = 2
Debuffs.bleeding.duration = 12
Debuffs.bleeding.max_dot_amount = 1
Debuffs.bleeding.hud_icon = "hud_debuff_icon_bleed_small"
Debuffs.bleeding.hud_timer_material = "hud_debuff_cooldown_timer_two"
Debuffs.burning = Debuffs.burning or {}
Debuffs.burning.duration = 6
Debuffs.burning.dps = 4
Debuffs.burning.max_dot_amount = 1
Debuffs.burning.hud_icon = "hud_debuff_icon_burn_small"
Debuffs.burning.hud_timer_material = "hud_debuff_cooldown_timer_three"
Debuffs.burning.fx_name = "fx/fire_dot"
Debuffs.burning.fx_node = "Spine2"
Debuffs.arrow = Debuffs.arrow or {}
Debuffs.arrow.duration = 20
Debuffs.arrow.hud_icon = "hud_debuff_icon_arrow_small"
Debuffs.arrow.hud_timer_material = "hud_debuff_cooldown_timer_four"
BuffLevelMultiplierFunctions = {
	reinforce = function(level)
		if level == 0 then
			return 1
		elseif level == 1 then
			return 1
		elseif level == 2 then
			return 1.05
		elseif level == 3 then
			return 1.09318181818182
		elseif level == 4 then
			return 1.11477272727272
		elseif level == 5 then
			return 1.12556818181818
		elseif level == 6 then
			return 1.1309659090909
		elseif level == 7 then
			return 1.13366477272727
		else
			return 1.13636363636363
		end
	end,
	replenish = function(level)
		if level == 0 then
			return 1
		elseif level == 1 then
			return 1
		elseif level == 2 then
			return 2
		elseif level == 3 then
			return 2.5
		elseif level == 4 then
			return 2.75
		elseif level == 5 then
			return 2.875
		elseif level == 6 then
			return 2.9375
		elseif level == 7 then
			return 2.96875
		else
			return 3
		end
	end,
	regen = function(level)
		if level == 0 then
			return 0
		elseif level == 1 then
			return 0
		elseif level == 2 then
			return 1
		elseif level == 3 then
			return 1
		elseif level == 4 then
			return 1
		elseif level == 5 then
			return 1
		elseif level == 6 then
			return 1
		elseif level == 7 then
			return 1
		else
			return 1
		end
	end,
	courage = function(level)
		if level == 0 then
			return 0
		elseif level == 1 then
			return 0
		elseif level == 2 then
			return 3
		elseif level == 3 then
			return 4
		elseif level == 4 then
			return 5
		elseif level == 5 then
			return 6
		elseif level == 6 then
			return 7
		elseif level == 7 then
			return 8
		else
			return 8.8
		end
	end,
	armour = function(level)
		if level == 0 then
			return 1
		elseif level == 1 then
			return 1
		elseif level == 2 then
			return 1.05
		elseif level == 3 then
			return 1.09318181818182
		elseif level == 4 then
			return 1.11477272727272
		elseif level == 5 then
			return 1.12556818181818
		elseif level == 6 then
			return 1.1309659090909
		elseif level == 7 then
			return 1.13366477272727
		else
			return 1.13636363636363
		end
	end,
	march_speed = function(level)
		if level == 0 then
			return 1
		elseif level == 1 then
			return 1
		elseif level == 2 then
			return 1.05
		elseif level == 3 then
			return 1.075
		elseif level == 4 then
			return 1.0875
		elseif level == 5 then
			return 1.09375
		elseif level == 6 then
			return 1.096875
		elseif level == 7 then
			return 1.0984375
		else
			return 1.1
		end
	end,
	mounted_speed = function(level)
		if level == 0 then
			return 1
		elseif level == 1 then
			return 1
		elseif level == 2 then
			return 1.05
		elseif level == 3 then
			return 1.075
		elseif level == 4 then
			return 1.0875
		elseif level == 5 then
			return 1.09375
		elseif level == 6 then
			return 1.096875
		elseif level == 7 then
			return 1.0984375
		else
			return 1.1
		end
	end,
	berserker = function(level)
		if level == 0 then
			return 1
		elseif level == 1 then
			return 1
		elseif level == 2 then
			return 1.1
		elseif level == 3 then
			return 1.2
		elseif level == 4 then
			return 1.3
		elseif level == 5 then
			return 1.4
		elseif level == 6 then
			return 1.5
		elseif level == 7 then
			return 1.55
		else
			return 1.66
		end
	end
}
PlayerEffectHUDSettings = {
	buffs = {
		container_position_y = -0.17,
		container_position_x = -0.12
	},
	debuffs = {
		container_position_y = -0.17,
		container_position_x = 0.12
	}
}
AreaBuffSettings = AreaBuffsettings or {}
AreaBuffSettings.FADE_TIME = 5
AreaBuffSettings.RANGE = 30
