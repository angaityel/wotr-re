-- chunkname: @scripts/settings/mount_profiles.lua

local default_hit_zones = {
	head = {
		damage_multiplier = 1.8,
		actors = {
			"c_head",
			"c_neck",
			"c_neck1",
			"c_neck2",
			"c_neck3"
		}
	},
	body = {
		damage_multiplier = 1.2,
		actors = {
			"c_hips",
			"c_spine",
			"c_spine1",
			"c_leftshoulder",
			"c_rightshoulder"
		}
	},
	legs = {
		damage_multiplier = 1.5,
		actors = {
			"c_leftupleg",
			"c_rightupleg",
			"c_leftleg",
			"c_rightleg",
			"c_leftfoot",
			"c_rightfoot",
			"c_lefttoe",
			"c_righttoe",
			"c_leftfingerbase",
			"c_rightfingerbase",
			"c_leftforearm",
			"c_rightforearm",
			"c_lefthand",
			"c_righthand"
		}
	}
}

MountCategories = {
	standard = {
		ui_description = "mount_category_description_standard",
		ui_texture = "mount_flawed_mockup",
		ui_header = "mount_category_name_standard",
		ui_sort_index = 1
	},
	barded = {
		ui_description = "mount_category_description_barded",
		ui_texture = "mount_flawed_mockup",
		ui_header = "mount_category_name_barded",
		ui_sort_index = 2
	},
	none = {
		ui_texture = "mount_none_mockup",
		ui_header = "mount_none",
		ui_sort_index = 3
	}
}
MountProfileTemplates = {
	standard_horse = {
		absorption_value = 0,
		burst_acceleration = 3,
		acceleration_change = -1,
		health = 100,
		cruise_control_accelerate_speed = 5,
		cruise_control_brake_speed = 5,
		material_variation = "units/beings/chr_horse/chr_horse",
		armour_type = "none",
		jump_vertical_velocity = 5,
		wanted_acceleration = -1,
		max_charge_stamina = 10,
		preview_unit = "units/beings/chr_horse/chr_horse_preview",
		penetration_value = 0,
		unit = "units/beings/chr_horse/chr_horse",
		hit_zones = default_hit_zones,
		ui_unit = {
			rotation = {
				{
					z = -90
				},
				{
					x = -90
				},
				{
					y = -20
				}
			},
			camera_position = Vector3Box(0.6, 1.5, 2.5)
		}
	},
	barded_horse = {
		max_charge_stamina = 5,
		absorption_value = 0.6,
		acceleration_change = -1,
		burst_acceleration = 3,
		cruise_control_accelerate_speed = 5,
		cruise_control_brake_speed = 5,
		material_variation = "units/beings/chr_horse/chr_horse_heavy",
		armour_type = "armour_plate",
		health = 100,
		wanted_acceleration = -1,
		jump_vertical_velocity = 5,
		preview_unit = "units/beings/chr_horse/chr_horse_heavy_preview",
		penetration_value = 15,
		unit = "units/beings/chr_horse/chr_horse_heavy",
		hit_zones = default_hit_zones,
		ui_unit = {
			rotation = {
				{
					z = -90
				},
				{
					x = -90
				},
				{
					y = -20
				}
			},
			camera_position = Vector3Box(0.6, 1.5, 2.5)
		}
	}
}
MountProfiles = {}
MountProfiles.standard_horse1 = MountProfiles.standard_horse1 or table.clone(MountProfileTemplates.standard_horse)
MountProfiles.standard_horse1.material_variation = "units/beings/chr_horse/chr_horse_red"
MountProfiles.standard_horse1.category = "standard"
MountProfiles.standard_horse1.ui_header = "mount_name_standard_horse_red"
MountProfiles.standard_horse1.ui_description = "mount_description_standard_horse_red"
MountProfiles.standard_horse1.ui_fluff_text = ""
MountProfiles.standard_horse1.ui_texture = "mount_horse_red"
MountProfiles.standard_horse1.ui_sort_index = 1
MountProfiles.standard_horse1.health = 100
MountProfiles.standard_horse1.max_charge_stamina = 12.4
MountProfiles.standard_horse1.market_price = 12000
MountProfiles.standard_horse1.release_name = "main"
MountProfiles.standard_horse1.burst_acceleration = 4.6
MountProfiles.standard_horse1.wanted_acceleration = -0.6
MountProfiles.standard_horse1.acceleration_change = -4.6
MountProfiles.standard_horse1.cruise_control_brake_speed = 4.5
MountProfiles.standard_horse1.cruise_control_accelerate_speed = 5.5
MountProfiles.standard_horse2 = MountProfiles.standard_horse2 or table.clone(MountProfileTemplates.standard_horse)
MountProfiles.standard_horse2.material_variation = "units/beings/chr_horse/chr_horse_black"
MountProfiles.standard_horse2.category = "standard"
MountProfiles.standard_horse2.ui_header = "mount_name_standard_horse_black"
MountProfiles.standard_horse2.ui_description = "mount_description_standard_horse_black"
MountProfiles.standard_horse2.ui_fluff_text = ""
MountProfiles.standard_horse2.ui_texture = "mount_horse_black"
MountProfiles.standard_horse2.ui_sort_index = 2
MountProfiles.standard_horse2.health = 100
MountProfiles.standard_horse2.max_charge_stamina = 13
MountProfiles.standard_horse2.market_price = 120000
MountProfiles.standard_horse2.release_name = "main"
MountProfiles.standard_horse2.burst_acceleration = 5
MountProfiles.standard_horse2.wanted_acceleration = -0.5
MountProfiles.standard_horse2.acceleration_change = -5
MountProfiles.standard_horse2.cruise_control_brake_speed = 5
MountProfiles.standard_horse2.cruise_control_accelerate_speed = 6
MountProfiles.standard_horse3 = MountProfiles.standard_horse3 or table.clone(MountProfileTemplates.standard_horse)
MountProfiles.standard_horse3.material_variation = "units/beings/chr_horse/chr_horse_brown"
MountProfiles.standard_horse3.category = "standard"
MountProfiles.standard_horse3.ui_header = "mount_name_standard_horse_brown"
MountProfiles.standard_horse3.ui_description = "mount_description_standard_horse_brown"
MountProfiles.standard_horse3.ui_fluff_text = ""
MountProfiles.standard_horse3.ui_texture = "mount_horse_brown"
MountProfiles.standard_horse3.ui_sort_index = 3
MountProfiles.standard_horse3.health = 100
MountProfiles.standard_horse3.max_charge_stamina = 11.5
MountProfiles.standard_horse3.market_price = 12000
MountProfiles.standard_horse3.release_name = "main"
MountProfiles.standard_horse3.burst_acceleration = 4.1
MountProfiles.standard_horse3.wanted_acceleration = -0.8
MountProfiles.standard_horse3.acceleration_change = -4.1
MountProfiles.standard_horse3.cruise_control_brake_speed = 3.8
MountProfiles.standard_horse3.cruise_control_accelerate_speed = 4.8
MountProfiles.standard_horse4 = MountProfiles.standard_horse4 or table.clone(MountProfileTemplates.standard_horse)
MountProfiles.standard_horse4.material_variation = "units/beings/chr_horse/chr_horse_white"
MountProfiles.standard_horse4.category = "standard"
MountProfiles.standard_horse4.ui_header = "mount_name_standard_horse_white"
MountProfiles.standard_horse4.ui_description = "mount_description_standard_horse_white"
MountProfiles.standard_horse4.ui_fluff_text = ""
MountProfiles.standard_horse4.ui_texture = "mount_horse_white"
MountProfiles.standard_horse4.ui_sort_index = 4
MountProfiles.standard_horse4.health = 100
MountProfiles.standard_horse4.max_charge_stamina = 11.9
MountProfiles.standard_horse4.market_price = 120000
MountProfiles.standard_horse4.release_name = "main"
MountProfiles.standard_horse4.burst_acceleration = 4.3
MountProfiles.standard_horse4.wanted_acceleration = -0.7
MountProfiles.standard_horse4.acceleration_change = -4.3
MountProfiles.standard_horse4.cruise_control_brake_speed = 4.2
MountProfiles.standard_horse4.cruise_control_accelerate_speed = 5.2
MountProfiles.barded_horse1 = MountProfiles.barded_horse1 or table.clone(MountProfileTemplates.barded_horse)
MountProfiles.barded_horse1.material_variation = "units/beings/chr_horse/chr_horse_heavy_red"
MountProfiles.barded_horse1.category = "barded"
MountProfiles.barded_horse1.ui_header = "mount_name_barded_horse_red"
MountProfiles.barded_horse1.ui_description = "mount_description_barded_horse_red"
MountProfiles.barded_horse1.ui_fluff_text = "mount_fluff_barded_horse_red"
MountProfiles.barded_horse1.ui_texture = "mount_horse_heavy_red"
MountProfiles.barded_horse1.ui_sort_index = 5
MountProfiles.barded_horse1.health = 100
MountProfiles.barded_horse1.max_charge_stamina = 5.9
MountProfiles.barded_horse1.market_price = 36000
MountProfiles.barded_horse1.release_name = "main"
MountProfiles.barded_horse1.burst_acceleration = 2.7
MountProfiles.barded_horse1.wanted_acceleration = -1.5
MountProfiles.barded_horse1.acceleration_change = -2.7
MountProfiles.barded_horse1.cruise_control_brake_speed = 4.3
MountProfiles.barded_horse1.cruise_control_accelerate_speed = 3.3
MountProfiles.barded_horse2 = MountProfiles.barded_horse2 or table.clone(MountProfileTemplates.barded_horse)
MountProfiles.barded_horse2.material_variation = "units/beings/chr_horse/chr_horse_heavy_black"
MountProfiles.barded_horse2.category = "barded"
MountProfiles.barded_horse2.ui_header = "mount_name_barded_horse_black"
MountProfiles.barded_horse2.ui_description = "mount_description_barded_horse_black"
MountProfiles.barded_horse2.ui_fluff_text = "mount_fluff_barded_horse_black"
MountProfiles.barded_horse2.ui_texture = "mount_horse_heavy_black"
MountProfiles.barded_horse2.ui_sort_index = 6
MountProfiles.barded_horse2.health = 100
MountProfiles.barded_horse2.max_charge_stamina = 6.5
MountProfiles.barded_horse2.market_price = 360000
MountProfiles.barded_horse2.release_name = "main"
MountProfiles.barded_horse2.burst_acceleration = 2.9
MountProfiles.barded_horse2.wanted_acceleration = -1.4
MountProfiles.barded_horse2.acceleration_change = -2.9
MountProfiles.barded_horse2.cruise_control_brake_speed = 4.6
MountProfiles.barded_horse2.cruise_control_accelerate_speed = 3.6
MountProfiles.barded_horse3 = MountProfiles.barded_horse3 or table.clone(MountProfileTemplates.barded_horse)
MountProfiles.barded_horse3.material_variation = "units/beings/chr_horse/chr_horse_heavy_brown"
MountProfiles.barded_horse3.category = "barded"
MountProfiles.barded_horse3.ui_header = "mount_name_barded_horse_brown"
MountProfiles.barded_horse3.ui_description = "mount_description_barded_horse_brown"
MountProfiles.barded_horse3.ui_fluff_text = "mount_fluff_barded_horse_brown"
MountProfiles.barded_horse3.ui_texture = "mount_horse_heavy_brown"
MountProfiles.barded_horse3.ui_sort_index = 7
MountProfiles.barded_horse3.health = 100
MountProfiles.barded_horse3.max_charge_stamina = 5
MountProfiles.barded_horse3.market_price = 36000
MountProfiles.barded_horse3.release_name = "main"
MountProfiles.barded_horse3.burst_acceleration = 2.4
MountProfiles.barded_horse3.wanted_acceleration = -1.7
MountProfiles.barded_horse3.acceleration_change = -2.4
MountProfiles.barded_horse3.cruise_control_brake_speed = 3.9
MountProfiles.barded_horse3.cruise_control_accelerate_speed = 2.9
MountProfiles.barded_horse4 = MountProfiles.barded_horse4 or table.clone(MountProfileTemplates.barded_horse)
MountProfiles.barded_horse4.material_variation = "units/beings/chr_horse/chr_horse_heavy_white"
MountProfiles.barded_horse4.category = "barded"
MountProfiles.barded_horse4.ui_header = "mount_name_barded_horse_white"
MountProfiles.barded_horse4.ui_description = "mount_description_barded_horse_white"
MountProfiles.barded_horse4.ui_fluff_text = "mount_fluff_barded_horse_white"
MountProfiles.barded_horse4.ui_texture = "mount_horse_heavy_white"
MountProfiles.barded_horse4.ui_sort_index = 8
MountProfiles.barded_horse4.health = 100
MountProfiles.barded_horse4.max_charge_stamina = 5.4
MountProfiles.barded_horse4.market_price = 360000
MountProfiles.barded_horse4.release_name = "main"
MountProfiles.barded_horse4.burst_acceleration = 2.5
MountProfiles.barded_horse4.wanted_acceleration = -1.6
MountProfiles.barded_horse4.acceleration_change = -2.5
MountProfiles.barded_horse4.cruise_control_brake_speed = 4.1
MountProfiles.barded_horse4.cruise_control_accelerate_speed = 3.1
