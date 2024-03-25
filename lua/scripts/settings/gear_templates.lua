-- chunkname: @scripts/settings/gear_templates.lua

require("scripts/settings/gear_settings")
require("scripts/settings/gear_attachments")
require("scripts/settings/attachment_node_linking")

local DEFAULT_SWING_ABORT_TIME_FACTOR = 0.5
local DEFAULT_SWING_ABORT_TIME_FACTOR_UP = 0.645
local DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT = 0.58
local DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT = 0.45
local DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN = 0.455

GearTemplates = {
	sword_1h = {
		health = 100,
		ui_texture = "gear_flawed_mockup",
		wield_time = 1,
		block_type = "weapon",
		stat_category = "one_handed_sword",
		reach = 1.96,
		encumbrance = 5,
		armour_type = "weapon_metal",
		gear_type = "one_handed_sword",
		hand = "right_hand",
		ui_combat_log_texture = "combat_log_wpn_sword",
		penetration_value = 0,
		wield_anim = "wield_right_arm_left_hip",
		unit = "units/weapons/wpn_1h_sword_01/wpn_1h_sword_01",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_1h_sword_01/wpn_1h_sword_01_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		pose_movement_multiplier = 0.5,
		hand_anim = "1h_sword",
		attachment_node_linking = AttachmentNodeLinking.one_handed_weapon.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_cutting",
				speed_max = 10,
				damage_type = "cutting",
				abort_time_factor = 0.65,
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.65,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				}
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				abort_time_factor = 0.58,
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.58,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				}
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				abort_time_factor = 0.45,
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.45,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				}
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 40.625,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.506,
				charge_time = 0.555,
				impact_material_effects = "melee_hit_piercing",
				speed_max = 10,
				damage_type = "piercing",
				abort_time_factor = 0.455,
				attack_time = 0.429,
				quick_swing_attack_time = 0.342,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.455,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				}
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.25,
					width = 0.2,
					thickness = 0.01
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(0.4, 0, 0.4)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_blade",
				menu_page_type = "text",
				category = "blade",
				items = GearAttachments.melee.blade
			},
			{
				ui_header = "melee_edge_grind",
				menu_page_type = "text",
				category = "edge_grind",
				items = GearAttachments.melee.edge_grind
			},
			{
				ui_header = "melee_pommel",
				menu_page_type = "text",
				category = "pommel",
				items = GearAttachments.melee.pommel
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"blade",
				"edge_grind"
			},
			{
				"pommel"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_sword",
				parameters = {
					{
						value = "sword_1h_medium",
						name = "weapon_type_base"
					}
				}
			}
		}
	},
	club_1h = {
		health = 100,
		ui_texture = "gear_flawed_mockup",
		wield_time = 1,
		block_type = "weapon",
		stat_category = "one_handed_club",
		reach = 0.67,
		encumbrance = 5,
		armour_type = "weapon_wood",
		gear_type = "one_handed_club",
		hand = "right_hand",
		ui_combat_log_texture = "combat_log_wpn_sword",
		penetration_value = 0,
		wield_anim = "wield_right_arm_left_hip",
		unit = "units/weapons/wpn_1h_mace_01/wpn_1h_mace_01",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_1h_mace_01/wpn_1h_mace_01_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		pose_movement_multiplier = 0.5,
		hand_anim = "1h_sword",
		attachment_node_linking = AttachmentNodeLinking.one_handed_weapon.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_blunt",
				speed_max = 10,
				damage_type = "blunt",
				abort_time_factor = 0.645,
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.65,
					outer_node = "c_hammer_high_point",
					inner_node = "c_hammer_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.65,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				}
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_blunt",
				speed_max = 10,
				damage_type = "blunt",
				abort_time_factor = 0.638,
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.638,
					outer_node = "c_hammer_high_point",
					inner_node = "c_hammer_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.638,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				}
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_blunt",
				speed_max = 10,
				damage_type = "blunt",
				abort_time_factor = 0.475,
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.475,
					outer_node = "c_hammer_high_point",
					inner_node = "c_hammer_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.475,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				}
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 40.625,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.506,
				charge_time = 0.555,
				impact_material_effects = "melee_hit_blunt",
				speed_max = 10,
				damage_type = "blunt",
				attack_time = 0.429,
				quick_swing_attack_time = 0.342,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.65,
					outer_node = "c_hammer_high_point",
					inner_node = "c_hammer_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.65,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.25,
					width = 0.2,
					thickness = 0.01
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(0.25, 0, 0.35)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_head",
				menu_page_type = "text",
				category = "head",
				items = GearAttachments.melee.head
			},
			{
				ui_header = "melee_wooden_shaft",
				menu_page_type = "text",
				category = "wooden_shaft",
				items = GearAttachments.melee.wooden_shaft
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"head"
			},
			{
				"wooden_shaft"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_club"
			}
		}
	},
	axe_1h = {
		health = 100,
		ui_texture = "gear_flawed_mockup",
		wield_time = 1,
		block_type = "weapon",
		stat_category = "one_handed_axe",
		reach = 0.61,
		encumbrance = 5,
		armour_type = "weapon_wood",
		gear_type = "one_handed_axe",
		hand = "right_hand",
		ui_combat_log_texture = "combat_log_wpn_sword",
		penetration_value = 0,
		wield_anim = "wield_right_arm_left_hip",
		unit = "units/weapons/wpn_1h_battle_axe/wpn_1h_battle_axe",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_1h_battle_axe/wpn_1h_battle_axe_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		pose_movement_multiplier = 0.5,
		hand_anim = "1h_sword",
		attachment_node_linking = AttachmentNodeLinking.one_handed_weapon.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_cutting",
				speed_max = 10,
				damage_type = "cutting",
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.65,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.65,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_UP
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_cutting",
				speed_max = 10,
				damage_type = "cutting",
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.62,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.62,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 54,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.691,
				charge_time = 0.759,
				impact_material_effects = "melee_hit_cutting",
				speed_max = 10,
				damage_type = "cutting",
				attack_time = 0.586,
				quick_swing_attack_time = 0.468,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.4,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.4,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 40.625,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.506,
				charge_time = 0.555,
				impact_material_effects = "melee_hit_blunt",
				speed_max = 10,
				damage_type = "blunt",
				attack_time = 0.429,
				quick_swing_attack_time = 0.342,
				penalties = {
					parried = 0.9,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.6,
					hard = 0.3
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.65,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.65,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.25,
					width = 0.2,
					thickness = 0.01
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(0.3, 0, 0.45)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_head",
				menu_page_type = "text",
				category = "head",
				items = GearAttachments.melee.head
			},
			{
				ui_header = "melee_edge_grind",
				menu_page_type = "text",
				category = "edge_grind",
				items = GearAttachments.melee.edge_grind
			},
			{
				ui_header = "melee_wooden_shaft",
				menu_page_type = "text",
				category = "wooden_shaft",
				items = GearAttachments.melee.wooden_shaft
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"head",
				"edge_grind"
			},
			{
				"wooden_shaft"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_axe"
			}
		}
	},
	lance = {
		wield_anim = "wield_right_arm_back",
		ui_texture = "gear_flawed_mockup",
		gear_type = "lance",
		stat_category = "lance",
		block_type = "weapon",
		reach = 4.53,
		encumbrance = 5,
		armour_type = "weapon_metal",
		pose_movement_multiplier = 0.5,
		hand = "right_hand",
		ui_combat_log_texture = "combat_log_wpn_sword",
		damage_feedback_threshold_max = 100,
		penetration_value = 0,
		damage_feedback_threshold_min = 5,
		wield_time = 1,
		ui_sort_index = 1,
		absorption_value = 0,
		sweep_collision = true,
		rejuvenation_delay = 10,
		allows_couch = true,
		hide_unwielded = true,
		ui_header = "gear_name_flawed",
		health = 100,
		hand_anim = "1h_sword",
		attachment_node_linking = AttachmentNodeLinking.lance.standard,
		menu_stats_attacks = {
			"couch"
		},
		attacks = {
			couch = {
				uncouch_time = 2,
				damage_range_type = "melee",
				base_damage = 1,
				parry_direction = "couch",
				user_unit_align_node = "a_right_hand",
				impact_material_effects = "melee_hit_piercing",
				screen_space_target_point_unit_node = "c_lance_tip",
				speed_max = 1,
				damage_type = "piercing",
				couch_time = 1,
				forward_direction = Vector3Box(0, 0, 1),
				screen_space_target_point = {
					0.5,
					0.4
				},
				sweep = {
					inner_node = "c_lance_tip_low_point",
					outer_node = "c_lance_tip",
					delay = 0.25,
					width = 0.2,
					thickness = 0.2
				}
			}
		},
		properties = {
			stun = false
		},
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(1.2, 0, 1.4)
		},
		attachments = {
			{
				ui_header = "melee_wooden_shaft",
				menu_page_type = "text",
				category = "lance_shaft",
				items = GearAttachments.melee.lance_shaft
			},
			{
				ui_header = "melee_lance_tip",
				menu_page_type = "text",
				category = "lance_tip",
				items = GearAttachments.melee.lance_tip
			}
		},
		ui_small_attachment_icons = {
			{
				"lance_shaft"
			},
			{
				"lance_tip"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_polearm"
			}
		}
	},
	sword_2h = {
		health = 100,
		ui_texture = "gear_flawed_mockup",
		wield_time = 2,
		block_type = "weapon",
		stat_category = "two_handed_sword",
		reach = 1.23,
		encumbrance = 5,
		armour_type = "weapon_metal",
		gear_type = "two_handed_sword",
		hand = "both_hands",
		ui_combat_log_texture = "combat_log_wpn_sword",
		penetration_value = 0,
		wield_anim = "wield_right_arm_back",
		unit = "units/weapons/wpn_longsword_02/wpn_longsword_02",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_longsword_02/wpn_longsword_02_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		pose_movement_multiplier = 0.5,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.two_handed_weapon.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 91.15,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 1.159,
				charge_time = 1.272,
				impact_material_effects = "melee_hit_cutting",
				speed_max = 10,
				damage_type = "cutting",
				attack_time = 0.982,
				quick_swing_attack_time = 0.784,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.7,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_UP
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 91.15,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 1.159,
				charge_time = 1.272,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.9,
				quick_swing_attack_time = 0.784,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.58,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 91.15,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 1.159,
				charge_time = 1.272,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.982,
				quick_swing_attack_time = 0.784,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.68,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.25,
				base_damage = 89.625,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 1.131,
				charge_time = 1.242,
				impact_material_effects = "melee_hit_piercing",
				speed_max = 10,
				damage_type = "piercing",
				attack_time = 0.959,
				quick_swing_attack_time = 0.765,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.55,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.25,
					width = 0.2,
					thickness = 0.01
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(0.4, 0, 0.5)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_blade",
				menu_page_type = "text",
				category = "blade",
				items = GearAttachments.melee.blade
			},
			{
				ui_header = "melee_edge_grind",
				menu_page_type = "text",
				category = "edge_grind",
				items = GearAttachments.melee.edge_grind
			},
			{
				ui_header = "melee_pommel",
				menu_page_type = "text",
				category = "pommel",
				items = GearAttachments.melee.pommel
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"blade",
				"edge_grind"
			},
			{
				"pommel"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_sword",
				parameters = {
					{
						value = "sword_2h",
						name = "weapon_type_base"
					}
				}
			}
		}
	},
	spear = {
		penetration_value = 0,
		ui_texture = "gear_flawed_mockup",
		wield_time = 2,
		block_type = "weapon",
		gear_type = "spear",
		reach = 1.11,
		encumbrance = 5,
		armour_type = "weapon_metal",
		pose_movement_multiplier = 0.5,
		hand = "right_hand",
		ui_combat_log_texture = "combat_log_wpn_sword",
		stat_category = "spear",
		wield_anim = "wield_polearm",
		unit = "units/weapons/wpn_poleaxe/wpn_poleaxe",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_poleaxe/wpn_poleaxe_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		only_thrust_with_shield = true,
		ui_header = "gear_name_flawed",
		health = 100,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.polearm.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.48,
				quick_swing_attack_time = 0.48,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.71,
					outer_node = "c_spearhead_high_point",
					inner_node = "c_spearhead_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.71,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_UP
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.516,
				quick_swing_attack_time = 0.602,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(1, 0, 0),
				sweep = {
					delay = 0.68,
					outer_node = "c_spearhead_high_point",
					inner_node = "c_spearhead_low_point",
					width = 0.1,
					thickness = 0.1
				},
				non_damage_sweep = {
					delay = 0.68,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.516,
				quick_swing_attack_time = 0.602,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.69,
					outer_node = "c_spearhead_high_point",
					inner_node = "c_spearhead_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.69,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 75,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.35,
				impact_material_effects = "melee_hit_piercing",
				speed_max = 10,
				damage_type = "piercing",
				attack_time = 0.34400000000000003,
				quick_swing_attack_time = 0.34400000000000003,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.55,
					outer_node = "c_spearhead_high_point",
					inner_node = "c_spearhead_low_point",
					width = 0.1,
					thickness = 0.1
				},
				non_damage_sweep = {
					delay = 0.55,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.4,
					width = 0.1,
					thickness = 0.1
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(1, 0, 0.8)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_head",
				menu_page_type = "text",
				category = "head",
				items = GearAttachments.melee.head
			},
			{
				ui_header = "melee_edge_grind",
				menu_page_type = "text",
				category = "edge_grind",
				items = GearAttachments.melee.edge_grind
			},
			{
				ui_header = "melee_wooden_shaft",
				menu_page_type = "text",
				category = "wooden_shaft",
				items = GearAttachments.melee.wooden_shaft
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"head",
				"edge_grind"
			},
			{
				"wooden_shaft"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_polearm"
			}
		}
	},
	polearm = {
		health = 100,
		ui_texture = "gear_flawed_mockup",
		wield_time = 2,
		block_type = "weapon",
		stat_category = "polearm",
		reach = 1.01,
		encumbrance = 5,
		armour_type = "weapon_metal",
		gear_type = "polearm",
		hand = "both_hands",
		ui_combat_log_texture = "combat_log_wpn_sword",
		penetration_value = 0,
		wield_anim = "wield_polearm",
		unit = "units/weapons/wpn_poleaxe/wpn_poleaxe",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_poleaxe/wpn_poleaxe_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		pose_movement_multiplier = 0.5,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.polearm.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_cutting",
				speed_max = 10,
				damage_type = "cutting",
				attack_time = 0.48,
				quick_swing_attack_time = 0.48,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.71,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.71,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_UP
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.516,
				quick_swing_attack_time = 0.602,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.6,
					outer_node = "c_hammer_high_point",
					inner_node = "c_hammer_low_point",
					width = 0.1,
					thickness = 0.1
				},
				non_damage_sweep = {
					delay = 0.6,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.516,
				quick_swing_attack_time = 0.602,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.61,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.61,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 75,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.35,
				impact_material_effects = "melee_hit_piercing",
				speed_max = 10,
				damage_type = "piercing",
				attack_time = 0.34400000000000003,
				quick_swing_attack_time = 0.34400000000000003,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.55,
					outer_node = "c_spearhead_high_point",
					inner_node = "c_spearhead_low_point",
					width = 0.1,
					thickness = 0.1
				},
				non_damage_sweep = {
					delay = 0.55,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.4,
					width = 0.1,
					thickness = 0.1
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(1.1, 0, 0.8)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_head",
				menu_page_type = "text",
				category = "head",
				items = GearAttachments.melee.head
			},
			{
				ui_header = "melee_edge_grind",
				menu_page_type = "text",
				category = "edge_grind",
				items = GearAttachments.melee.edge_grind
			},
			{
				ui_header = "melee_wooden_shaft",
				menu_page_type = "text",
				category = "wooden_shaft",
				items = GearAttachments.melee.wooden_shaft
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"head",
				"edge_grind"
			},
			{
				"wooden_shaft"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_polearm"
			}
		}
	},
	axe_2h = {
		wield_anim = "wield_right_arm_back",
		ui_texture = "gear_flawed_mockup",
		wield_time = 2,
		armour_value = 45,
		stat_category = "two_handed_axe",
		reach = 1.12,
		block_type = "weapon",
		armour_type = "weapon_metal",
		gear_type = "two_handed_axe",
		hand = "both_hands",
		ui_combat_log_texture = "combat_log_wpn_sword",
		pose_movement_multiplier = 0.5,
		encumbrance = 5,
		unit = "units/weapons/wpn_2h_axe_01/wpn_2h_axe_01",
		husk_unit = "units/weapons/wpn_2h_axe_01/wpn_2h_axe_01_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		health = 100,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.two_handed_weapon.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_cutting",
				speed_max = 10,
				damage_type = "cutting",
				attack_time = 0.48,
				quick_swing_attack_time = 0.48,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.74,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.74,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_UP
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.516,
				quick_swing_attack_time = 0.602,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(1, 0, 0),
				sweep = {
					delay = 0.63,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.63,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.516,
				quick_swing_attack_time = 0.602,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.65,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.65,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 75,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.35,
				impact_material_effects = "melee_hit_cutting",
				speed_max = 10,
				damage_type = "cutting",
				attack_time = 0.34400000000000003,
				quick_swing_attack_time = 0.34400000000000003,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.6,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.6,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.25,
					width = 0.2,
					thickness = 0.01
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(0.3, -0.05, 0.45)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_head",
				menu_page_type = "text",
				category = "head",
				items = GearAttachments.melee.head
			},
			{
				ui_header = "melee_edge_grind",
				menu_page_type = "text",
				category = "edge_grind",
				items = GearAttachments.melee.edge_grind
			},
			{
				ui_header = "melee_wooden_shaft",
				menu_page_type = "text",
				category = "wooden_shaft",
				items = GearAttachments.melee.wooden_shaft
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"head",
				"edge_grind"
			},
			{
				"wooden_shaft"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_axe"
			}
		}
	},
	club_2h = {
		wield_anim = "wield_right_arm_back",
		ui_texture = "gear_flawed_mockup",
		wield_time = 2,
		armour_value = 45,
		stat_category = "two_handed_club",
		reach = 1.7,
		block_type = "weapon",
		armour_type = "weapon_metal",
		gear_type = "two_handed_club",
		hand = "both_hands",
		ui_combat_log_texture = "combat_log_wpn_sword",
		pose_movement_multiplier = 0.5,
		encumbrance = 5,
		unit = "units/weapons/wpn_2h_axe_01/wpn_2h_axe_01",
		husk_unit = "units/weapons/wpn_2h_axe_01/wpn_2h_axe_01_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		health = 100,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.two_handed_weapon.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_blunt",
				speed_max = 10,
				damage_type = "blunt",
				attack_time = 0.48,
				quick_swing_attack_time = 0.48,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.74,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.74,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_UP
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_blunt",
				speed_max = 10,
				damage_type = "blunt",
				attack_time = 0.516,
				quick_swing_attack_time = 0.602,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(1, 0, 0),
				sweep = {
					delay = 0.63,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.63,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 79,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.33,
				impact_material_effects = "melee_hit_blunt",
				speed_max = 10,
				damage_type = "blunt",
				attack_time = 0.516,
				quick_swing_attack_time = 0.602,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.65,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.65,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 75,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1.35,
				impact_material_effects = "melee_hit_piercing",
				speed_max = 10,
				damage_type = "piercing",
				attack_time = 0.34400000000000003,
				quick_swing_attack_time = 0.34400000000000003,
				penalties = {
					parried = 1,
					not_penetrated = 0,
					miss = 1.5,
					blocked = 0.5,
					hard = 0.5
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.6,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				non_damage_sweep = {
					delay = 0.6,
					outer_node = "c_pole_high_point",
					inner_node = "c_pole_low_point",
					width = 0.05,
					thickness = 0.05
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.25,
					width = 0.2,
					thickness = 0.01
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(0.3, -0.05, 0.45)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_head",
				menu_page_type = "text",
				category = "head",
				items = GearAttachments.melee.head
			},
			{
				ui_header = "melee_wooden_shaft",
				menu_page_type = "text",
				category = "wooden_shaft",
				items = GearAttachments.melee.wooden_shaft
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"head",
				"edge_grind"
			},
			{
				"wooden_shaft"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_polearm"
			}
		}
	},
	sword_bastard = {
		health = 100,
		ui_texture = "gear_flawed_mockup",
		wield_time = 2,
		block_type = "weapon",
		stat_category = "bastard_sword",
		reach = 0.1,
		encumbrance = 5,
		armour_type = "weapon_metal",
		gear_type = "one_handed_sword",
		hand = "right_hand",
		ui_combat_log_texture = "combat_log_wpn_sword",
		penetration_value = 0,
		wield_anim = "wield_right_arm_left_hip",
		unit = "units/weapons/wpn_longsword/wpn_longsword",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_longsword/wpn_longsword_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		pose_movement_multiplier = 0.5,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.one_handed_weapon.sword_bastard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 65,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.48,
				quick_swing_attack_time = 0.48,
				penalties = {
					parried = 0.6,
					not_penetrated = 0,
					miss = 0.9,
					blocked = 0.3,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.65,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_UP
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 65,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.516,
				quick_swing_attack_time = 0.48160000000000003,
				penalties = {
					parried = 0.6,
					not_penetrated = 0,
					miss = 0.9,
					blocked = 0.3,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.55,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 66,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.516,
				quick_swing_attack_time = 0.48160000000000003,
				penalties = {
					parried = 0.6,
					not_penetrated = 0,
					miss = 0.9,
					blocked = 0.3,
					hard = 0.3
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.4,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 59,
				minimum_pose_time = 0.2,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.9,
				charge_time = 1,
				impact_material_effects = "melee_hit_piercing",
				speed_max = 10,
				damage_type = "piercing",
				attack_time = 0.48160000000000003,
				quick_swing_attack_time = 0.34400000000000003,
				penalties = {
					parried = 0.6,
					not_penetrated = 0,
					miss = 0.9,
					blocked = 0.3,
					hard = 0.3
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.5,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.2,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.25,
					width = 0.2,
					thickness = 0.01
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(0.4, 0, 0.45)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_blade",
				menu_page_type = "text",
				category = "blade",
				items = GearAttachments.melee.blade
			},
			{
				ui_header = "melee_edge_grind",
				menu_page_type = "text",
				category = "edge_grind",
				items = GearAttachments.melee.edge_grind
			},
			{
				ui_header = "melee_pommel",
				menu_page_type = "text",
				category = "pommel",
				items = GearAttachments.melee.pommel
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"blade",
				"edge_grind"
			},
			{
				"pommel"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_sword",
				parameters = {
					{
						value = "sword_1h_medium",
						name = "weapon_type_base"
					}
				}
			}
		}
	},
	dagger = {
		wield_anim = "wield_right_arm_right_hip",
		ui_texture = "gear_flawed_mockup",
		wield_time = 1,
		stat_category = "dagger",
		gear_type = "dagger",
		reach = 12.3,
		armour_type = "weapon_metal",
		encumbrance = 5,
		hand = "right_hand",
		ui_combat_log_texture = "combat_log_wpn_sword",
		penetration_value = 0,
		unit = "units/weapons/wpn_dagger_02/wpn_dagger_02",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_dagger_02/wpn_dagger_02_husk",
		sweep_collision = true,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		pose_movement_multiplier = 0.5,
		hand_anim = "1h_sword",
		attachment_node_linking = AttachmentNodeLinking.dagger.standard,
		menu_stats_attacks = {
			"up",
			"down",
			"left",
			"right"
		},
		attacks = {
			up = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 24,
				minimum_pose_time = 0.15,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.25,
				charge_time = 0.2,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.37,
				quick_swing_attack_time = 0.4,
				penalties = {
					parried = 0.2,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.1,
					hard = 0.1
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.4,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.1,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_UP
			},
			left = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 24,
				minimum_pose_time = 0.15,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.25,
				charge_time = 0.2,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.33,
				quick_swing_attack_time = 0.4,
				penalties = {
					parried = 0.2,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.1,
					hard = 0.1
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.4,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.1,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_LEFT
			},
			right = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 24,
				minimum_pose_time = 0.15,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.25,
				charge_time = 0.2,
				impact_material_effects = "melee_hit_slashing",
				speed_max = 10,
				damage_type = "slashing",
				attack_time = 0.36,
				quick_swing_attack_time = 0.39,
				penalties = {
					parried = 0.2,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.1,
					hard = 0.1
				},
				forward_direction = Vector3Box(-1, 0, 0),
				sweep = {
					delay = 0.4,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.1,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_RIGHT
			},
			down = {
				normal_swing_pose_anim_blend_value = 0.8,
				uncharged_damage_factor = 0.8,
				base_damage = 24,
				minimum_pose_time = 0.15,
				speed_function = "standard_melee",
				damage_range_type = "melee",
				quick_swing_charge_time = 0.25,
				charge_time = 0.2,
				impact_material_effects = "melee_hit_piercing",
				speed_max = 10,
				damage_type = "piercing",
				attack_time = 0.37,
				quick_swing_attack_time = 0.4,
				penalties = {
					parried = 0.2,
					not_penetrated = 0,
					miss = 0.3,
					blocked = 0.1,
					hard = 0.1
				},
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					delay = 0.2,
					outer_node = "c_blade_high_point",
					inner_node = "c_blade_low_point",
					width = 0.1,
					thickness = 0.01
				},
				abort_time_factor = DEFAULT_SWING_ABORT_TIME_FACTOR_DOWN
			},
			push = {
				base_damage = 0,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.33,
				quick_swing_charge_time = 0,
				charge_time = 0,
				forward_direction = Vector3Box(0, 0, 1),
				sweep = {
					inner_node = "c_push_low_point",
					outer_node = "c_push_high_point",
					delay = 0.25,
					width = 0.1,
					thickness = 0.01
				},
				penalties = {
					miss = 1,
					hard = 1
				}
			}
		},
		properties = {
			stun = false
		},
		health = math.huge,
		damage_feedback_threshold_min = math.huge,
		damage_feedback_threshold_max = math.huge,
		ui_unit = {
			rotation = {
				{
					z = 90
				},
				{
					y = 90
				}
			},
			camera_position = Vector3Box(0.1, 0, 0.2)
		},
		attachments = {
			{
				ui_header = "melee_fighting_style",
				menu_page_type = "text",
				category = "fighting_style",
				items = GearAttachments.melee.fighting_style
			},
			{
				ui_header = "melee_blade",
				menu_page_type = "text",
				category = "blade",
				items = GearAttachments.melee.blade
			},
			{
				ui_header = "melee_edge_grind",
				menu_page_type = "text",
				category = "edge_grind",
				items = GearAttachments.melee.edge_grind
			},
			{
				ui_header = "melee_pommel",
				menu_page_type = "text",
				category = "pommel",
				items = GearAttachments.melee.pommel
			}
		},
		ui_small_attachment_icons = {
			{
				"fighting_style"
			},
			{
				"head",
				"edge_grind"
			},
			{
				"pommel"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_dagger"
			}
		}
	},
	large_shield = {
		wield_anim = "wield_left_arm_back",
		ui_texture = "gear_flawed_mockup",
		wield_time = 1.1,
		block_type = "shield",
		unit = "units/weapons/wpn_steel_domed_shield/wpn_steel_domed_shield",
		reach = 12.3,
		pose_movement_multiplier = 0.4,
		armour_type = "weapon_wood",
		encumbrance = 5,
		hand = "left_hand",
		gear_type = "shield",
		damage_feedback_threshold_max = 100,
		penetration_value = 0,
		damage_feedback_threshold_min = 5,
		stat_category = "shield",
		absorption_value = 0,
		husk_unit = "units/weapons/wpn_steel_domed_shield/wpn_steel_domed_shield_husk",
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		health = 100,
		small_shield = false,
		hand_anim = "shield",
		attachment_node_linking = AttachmentNodeLinking.shield.standard,
		menu_stats_attacks = {},
		attacks = {
			shield_bash = {
				base_damage = 60,
				uncharged_damage_factor = 0.262,
				damage_range_type = "melee",
				damage_type = "blunt",
				attack_time = 0.35,
				quick_swing_charge_time = 0.8,
				charge_time = 0.75,
				forward_direction = Vector3Box(0, -1, 0),
				sweep = {
					inner_node = "c_shield_low_point",
					width = 0.6,
					outer_node = "c_shield_high_point",
					thickness = 0.01
				},
				penalties = {
					miss = 2,
					hard = 1
				}
			}
		},
		ui_unit = {
			rotation = {
				{
					x = -90
				},
				{
					z = -30
				}
			},
			camera_position = Vector3Box(0, -0.05, 0.9)
		},
		attachments = {
			{
				ui_header = "plate_shield_plate",
				menu_page_type = "text",
				category = "plate_shield_plate",
				items = GearAttachments.plate_shield.plate
			}
		},
		ui_small_attachment_icons = {
			{
				"plate_shield_plate"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_shield"
			}
		}
	},
	bow = {
		health = 1,
		ui_texture = "gear_flawed_mockup",
		wield_time = 1,
		stat_category = "bow",
		gear_type = "longbow",
		reach = 12.3,
		encumbrance = 5,
		armour_type = "weapon_wood",
		hand = "both_hands",
		ui_combat_log_texture = "combat_log_wpn_bow",
		penetration_value = 0,
		wield_anim = "wield_longbow",
		unit = "units/weapons/wpn_longbow/wpn_longbow",
		ammo_regen_rate = 0.067,
		absorption_value = 1,
		husk_unit = "units/weapons/wpn_longbow/wpn_longbow_husk",
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		pose_movement_multiplier = 0.1,
		starting_ammo = 5,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.bow.standard,
		menu_stats_attacks = {
			"ranged"
		},
		attacks = {
			ranged = {
				speed_function = "standard_bow",
				base_damage = 80,
				damage_range_type = "small_projectile",
				projectile_release_pitch = 0,
				projectile_release_distance = 0,
				bow_tense_time = 3,
				speed_max = 52,
				bow_shake_time = 4,
				reload_time = 2.5,
				bow_draw_time = 1
			}
		},
		ui_unit = {
			rotation = {
				{
					y = 90
				},
				{
					x = -90
				}
			},
			camera_position = Vector3Box(-0.05, -0.05, 0.65)
		},
		attachments = {
			{
				ui_header = "arrow_head",
				menu_page_type = "text",
				category = "projectile_head",
				items = GearAttachments.longbow.projectile_heads
			},
			{
				ui_header = "attachments",
				menu_page_type = "checkbox",
				category = "misc",
				items = GearAttachments.bow.misc
			}
		},
		ui_small_attachment_icons = {
			{
				"projectile_head"
			},
			{
				"misc"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_bow"
			}
		},
		quiver = {
			unit = "units/weapons/quivers/arrowbag/arrowbag_01",
			attachment_node_linking = AttachmentNodeLinking.quivers.bow
		}
	},
	crossbow = {
		penetration_value = 0,
		ui_texture = "gear_flawed_mockup",
		wield_time = 1.5,
		stat_category = "crossbow",
		pose_movement_multiplier = 0.1,
		reach = 12.3,
		encumbrance = 5,
		armour_type = "weapon_wood",
		length_of_breath_hold = 6.2,
		hand = "both_hands",
		ui_combat_log_texture = "combat_log_wpn_bow",
		hook_rotations_per_second = 1,
		wield_anim = "wield_crossbow",
		unit = "units/weapons/wpn_hunting_crossbow/wpn_hunting_crossbow",
		reload_hit_time = 1,
		ammo_regen_rate = 0.067,
		absorption_value = 1,
		husk_unit = "units/weapons/wpn_hunting_crossbow/wpn_hunting_crossbow_husk",
		gear_type = "crossbow",
		reload_hit_section_size = 45,
		reload_miss_time = 1,
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		health = 1,
		starting_ammo = 5,
		raise_time = 0.5,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.crossbow.standard,
		menu_stats_attacks = {
			"ranged"
		},
		attacks = {
			ranged = {
				projectile_release_pitch = 0,
				speed_max = 100,
				base_damage = 70,
				damage_range_type = "small_projectile",
				projectile_release_distance = 0,
				reload_time = 5,
				speed_function = "standard_crossbow"
			}
		},
		sway = {
			breath_held = {
				time = {
					horizontal = 8,
					vertical = 9
				},
				distance = {
					horizontal = 0.05,
					vertical = 0.05
				},
				transition_time_to = {
					breath_normal = 3.91,
					breath_fast = 0.2
				}
			},
			breath_normal = {
				time = {
					horizontal = 3.9,
					vertical = 2.78
				},
				distance = {
					horizontal = 0.3,
					vertical = 0.2
				},
				transition_time_to = {
					breath_held = 1.92
				}
			},
			breath_fast = {
				time = {
					horizontal = 1.01,
					vertical = 0.84
				},
				distance = {
					horizontal = 3.5,
					vertical = 4.5
				},
				transition_time_to = {
					breath_normal = 9.67
				}
			}
		},
		ui_unit = {
			rotation = {
				{
					z = -90
				}
			},
			camera_position = Vector3Box(0.2, 0, 0.9)
		},
		attachments = {
			{
				ui_header = "reload_mechanism",
				menu_page_type = "text",
				category = "reload_mechanism",
				items = GearAttachments.crossbow.reload_mechanism
			},
			{
				ui_header = "bolt_head",
				menu_page_type = "text",
				category = "projectile_head",
				items = GearAttachments.crossbow.projectile_heads
			},
			{
				ui_header = "attachments",
				menu_page_type = "checkbox",
				category = "misc",
				items = GearAttachments.crossbow.misc
			}
		},
		ui_small_attachment_icons = {
			{
				"reload_mechanism"
			},
			{
				"projectile_head"
			},
			{
				"misc"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_crossbow"
			}
		},
		quiver = {
			unit = "units/weapons/quivers/crossbow_quiver/crossbow_quiver",
			attachment_node_linking = AttachmentNodeLinking.quivers.crossbow
		}
	},
	handgonne = {
		max_range = 100,
		ui_texture = "gear_flawed_mockup",
		wield_time = 1.5,
		stat_category = "handgonne",
		penetration_value = 0,
		reach = 12.3,
		gear_type = "handgonne",
		armour_type = "weapon_wood",
		max_spread_angle = 3,
		hand = "both_hands",
		ui_combat_log_texture = "combat_log_wpn_bow",
		wield_anim = "wield_handgonne",
		unit = "units/weapons/wpn_handgonne_01/wpn_handgonne",
		pose_movement_multiplier = 0.1,
		encumbrance = 5,
		absorption_value = 1,
		husk_unit = "units/weapons/wpn_handgonne_01/wpn_handgonne_husk",
		projectile_name = "standard_handgonne_bullet",
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		health = 1,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.handgonne.standard,
		menu_stats_attacks = {
			"ranged"
		},
		attacks = {
			ranged = {
				projectile_release_pitch = 0,
				base_damage = 134,
				damage_range_type = "small_projectile",
				projectile_release_distance = 0,
				reload_time = 20,
				damage_function = function(distance, weapon_settings, projectile_settings)
					local close_range = 2
					local long_range = weapon_settings.max_range
					local damage_multiplier = math.clamp(math.auto_lerp(close_range, long_range, 1, 0.2, distance), 0.2, 1)

					return damage_multiplier
				end
			}
		},
		time_before_firing = {
			max = 2,
			min = 0.5
		},
		ui_unit = {
			rotation = {
				{
					z = -90
				},
				{
					x = -90
				}
			},
			camera_position = Vector3Box(-0.15, 0, 0.6)
		},
		attachments = {
			{
				ui_header = "ball_head",
				menu_page_type = "text",
				category = "projectile_head",
				items = GearAttachments.handgonne.projectile_heads
			}
		},
		ui_small_attachment_icons = {
			{
				"projectile_head"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_handgonne"
			}
		}
	},
	arquebus = {
		max_range = 100,
		ui_texture = "gear_flawed_mockup",
		wield_time = 1.5,
		stat_category = "handgonne",
		penetration_value = 0,
		reach = 12.3,
		gear_type = "arquebus",
		armour_type = "weapon_wood",
		max_spread_angle = 3,
		hand = "both_hands",
		ui_combat_log_texture = "combat_log_wpn_bow",
		wield_anim = "wield_handgonne",
		unit = "units/weapons/wpn_handgonne_01/wpn_handgonne",
		pose_movement_multiplier = 0.1,
		encumbrance = 5,
		absorption_value = 1,
		husk_unit = "units/weapons/wpn_handgonne_01/wpn_handgonne_husk",
		projectile_name = "standard_handgonne_bullet",
		rejuvenation_delay = 10,
		ui_sort_index = 1,
		ui_header = "gear_name_flawed",
		health = 1,
		hand_anim = "empty",
		attachment_node_linking = AttachmentNodeLinking.handgonne.standard,
		menu_stats_attacks = {
			"ranged"
		},
		attacks = {
			ranged = {
				projectile_release_pitch = 0,
				base_damage = 134,
				damage_range_type = "small_projectile",
				projectile_release_distance = 0,
				reload_time = 20,
				damage_function = function(distance, weapon_settings, projectile_settings)
					local close_range = 2
					local long_range = weapon_settings.max_range
					local damage_multiplier = math.clamp(math.auto_lerp(close_range, long_range, 1, 0.2, distance), 0.2, 1)

					return damage_multiplier
				end
			}
		},
		time_before_firing = {
			max = 2,
			min = 0.5
		},
		ui_unit = {
			rotation = {
				{
					z = -90
				},
				{
					x = -90
				}
			},
			camera_position = Vector3Box(-0.15, 0, 0.6)
		},
		attachments = {
			{
				ui_header = "ball_head",
				menu_page_type = "text",
				category = "projectile_head",
				items = GearAttachments.arquebus.projectile_heads
			}
		},
		ui_small_attachment_icons = {
			{
				"projectile_head"
			}
		},
		timpani_events = {
			wield = {
				event = "wield_handgonne"
			}
		}
	}
}

for template_name, template in pairs(GearTemplates) do
	if template.sweep_collision then
		for attack_name, attack in pairs(template.attacks) do
			local sweep = attack.sweep

			fassert(sweep, "[GearTemplates] Missing sweep definition for attack \"%s\" in gear template \"%s\".", attack_name, template_name)
			fassert(type(sweep.inner_node) == "string", "[GearTemplates] Missing inner_node in sweep for attack \"%s\" in gear template \"%s\".", attack_name, template_name)
			fassert(type(sweep.outer_node) == "string", "[GearTemplates] Missing outer_node in sweep for attack \"%s\" in gear template \"%s\".", attack_name, template_name)
			fassert(type(sweep.width) == "number", "[GearTemplates] Missing width in sweep for attack \"%s\" in gear template \"%s\".", attack_name, template_name)
			fassert(type(sweep.thickness) == "number", "[GearTemplates] Missing thickness in sweep for attack \"%s\" in gear template \"%s\".", attack_name, template_name)
		end
	end
end
