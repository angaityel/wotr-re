-- chunkname: @scripts/settings/coat_of_arms.lua

require("decals/coat_of_arms/coat_of_arms_atlas")
require("decals/coat_of_arms/coat_of_arms_charges_atlas")
require("scripts/settings/attachment_node_linking")

function populate_player_coat_of_arms_from_save(save_data)
	if save_data.player_coat_of_arms then
		PlayerCoatOfArms = save_data.player_coat_of_arms
	else
		save_data.player_coat_of_arms = PlayerCoatOfArms
	end
end

DefaultCoatOfArms = {
	shield = "standard",
	variation_2_type = "variations_00",
	ordinary_color = "team_secondary",
	helmet = "frogmouth",
	variation_1_type = "variations_00",
	title = "none",
	division_color = "team_secondary",
	division_type = "divisions_00",
	ordinary_type = "ordinaries_08",
	field_color = "team_primary",
	charge_color = "team_primary",
	charge_type = "charge_38",
	crest = "crest_torse",
	variation_1_color = "team_secondary",
	ui_team_name = "red",
	variation_2_color = "team_primary"
}
PlayerCoatOfArms = table.clone(DefaultCoatOfArms)
PlayerTitles = {
	{
		name = "none",
		ui_name = "title_ui_none",
		format_string = "title_none"
	},
	{
		name = "lord_earl_of_kent",
		ui_name = "title_ui_lord_earl_of_kent",
		format_string = "title_lord_earl_of_kent"
	},
	{
		name = "the_merciless",
		ui_name = "title_ui_the_merciless",
		format_string = "title_the_merciless"
	},
	{
		name = "sir_knight_bachelor",
		ui_name = "title_ui_sir_knight_bachelor",
		format_string = "title_sir_knight_bachelor"
	}
}
CoatOfArmsColors = {
	argent = {
		menu_color = {
			255,
			231,
			235,
			236
		},
		material_color = {
			206,
			210,
			236
		},
		material_complement_color = {
			201,
			178,
			72
		},
		mantling_color = {
			60,
			60,
			60
		}
	},
	["or"] = {
		menu_color = {
			255,
			242,
			215,
			58
		},
		material_color = {
			237,
			193,
			81
		},
		material_complement_color = {
			151,
			114,
			21
		},
		mantling_color = {
			30,
			30,
			0
		}
	},
	azure = {
		menu_color = {
			255,
			33,
			39,
			214
		},
		material_color = {
			33,
			92,
			214
		},
		material_complement_color = {
			114,
			185,
			208
		},
		mantling_color = {
			0,
			0,
			30
		}
	},
	gules = {
		menu_color = {
			255,
			199,
			21,
			21
		},
		material_color = {
			199,
			21,
			21
		},
		material_complement_color = {
			49,
			138,
			17
		},
		mantling_color = {
			20,
			0,
			0
		}
	},
	purpure = {
		menu_color = {
			255,
			141,
			26,
			200
		},
		material_color = {
			141,
			26,
			200
		},
		material_complement_color = {
			180,
			140,
			30
		},
		mantling_color = {
			10,
			0,
			10
		}
	},
	sable = {
		menu_color = {
			255,
			0,
			0,
			0
		},
		material_color = {
			49,
			45,
			41
		},
		material_complement_color = {
			237,
			193,
			81
		},
		mantling_color = {
			2,
			2,
			2
		}
	},
	vert = {
		menu_color = {
			255,
			45,
			110,
			48
		},
		material_color = {
			55,
			120,
			48
		},
		material_complement_color = {
			237,
			193,
			81
		},
		mantling_color = {
			0,
			10,
			0
		}
	}
}
CoatOfArmsColors.team_red_primary = CoatOfArmsColors.gules
CoatOfArmsColors.team_red_secondary = CoatOfArmsColors["or"]
CoatOfArmsColors.team_white_primary = CoatOfArmsColors.argent
CoatOfArmsColors.team_white_secondary = CoatOfArmsColors.azure
CoatOfArms = {
	field_colors = {
		{
			ui_text = "menu_color_argent",
			name = "argent",
			menu_color = CoatOfArmsColors.argent.menu_color,
			material_color = CoatOfArmsColors.argent.material_color,
			mantling_color = CoatOfArmsColors.argent.mantling_color
		},
		{
			ui_text = "menu_color_or",
			name = "or",
			menu_color = CoatOfArmsColors["or"].menu_color,
			material_color = CoatOfArmsColors["or"].material_color,
			mantling_color = CoatOfArmsColors["or"].mantling_color
		},
		{
			ui_text = "menu_color_azure",
			name = "azure",
			menu_color = CoatOfArmsColors.azure.menu_color,
			material_color = CoatOfArmsColors.azure.material_color,
			mantling_color = CoatOfArmsColors.azure.mantling_color
		},
		{
			ui_text = "menu_color_gules",
			name = "gules",
			menu_color = CoatOfArmsColors.gules.menu_color,
			material_color = CoatOfArmsColors.gules.material_color,
			mantling_color = CoatOfArmsColors.gules.mantling_color
		},
		{
			ui_text = "menu_color_purpure",
			name = "purpure",
			menu_color = CoatOfArmsColors.purpure.menu_color,
			material_color = CoatOfArmsColors.purpure.material_color,
			mantling_color = CoatOfArmsColors.purpure.mantling_color
		},
		{
			ui_text = "menu_color_sable",
			name = "sable",
			menu_color = CoatOfArmsColors.sable.menu_color,
			material_color = CoatOfArmsColors.sable.material_color,
			mantling_color = CoatOfArmsColors.sable.mantling_color
		},
		{
			ui_text = "menu_color_vert",
			name = "vert",
			menu_color = CoatOfArmsColors.vert.menu_color,
			material_color = CoatOfArmsColors.vert.material_color,
			mantling_color = CoatOfArmsColors.vert.mantling_color
		},
		{
			ui_text = "menu_color_team_primary",
			name = "team_primary",
			menu_color = CoatOfArmsColors.team_red_primary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_primary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_primary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_primary.material_color,
			mantling_color_team_red = CoatOfArmsColors.team_red_primary.mantling_color,
			mantling_color_team_white = CoatOfArmsColors.team_white_primary.mantling_color
		},
		{
			ui_text = "menu_color_team_secondary",
			name = "team_secondary",
			menu_color = CoatOfArmsColors.team_red_secondary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_secondary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_secondary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_secondary.material_color,
			mantling_color_team_red = CoatOfArmsColors.team_red_secondary.mantling_color,
			mantling_color_team_white = CoatOfArmsColors.team_white_secondary.mantling_color
		}
	},
	material_variation_colors = {
		{
			name = "argent",
			menu_color = CoatOfArmsColors.argent.menu_color,
			material_color = CoatOfArmsColors.argent.material_color,
			mantling_color = CoatOfArmsColors.argent.mantling_color
		},
		{
			name = "or",
			menu_color = CoatOfArmsColors["or"].menu_color,
			material_color = CoatOfArmsColors["or"].material_color,
			mantling_color = CoatOfArmsColors["or"].mantling_color
		},
		{
			name = "azure",
			menu_color = CoatOfArmsColors.azure.menu_color,
			material_color = CoatOfArmsColors.azure.material_color,
			mantling_color = CoatOfArmsColors.azure.mantling_color
		},
		{
			name = "gules",
			menu_color = CoatOfArmsColors.gules.menu_color,
			material_color = CoatOfArmsColors.gules.material_color,
			mantling_color = CoatOfArmsColors.gules.mantling_color
		},
		{
			name = "purpure",
			menu_color = CoatOfArmsColors.purpure.menu_color,
			material_color = CoatOfArmsColors.purpure.material_color,
			mantling_color = CoatOfArmsColors.purpure.mantling_color
		},
		{
			name = "sable",
			menu_color = CoatOfArmsColors.sable.menu_color,
			material_color = CoatOfArmsColors.sable.material_color,
			mantling_color = CoatOfArmsColors.sable.mantling_color
		},
		{
			name = "vert",
			menu_color = CoatOfArmsColors.vert.menu_color,
			material_color = CoatOfArmsColors.vert.material_color,
			mantling_color = CoatOfArmsColors.vert.mantling_color
		},
		{
			ui_text = "menu_color_team_primary",
			name = "team_primary",
			menu_color = CoatOfArmsColors.team_red_primary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_primary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_primary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_primary.material_color,
			mantling_color_team_red = CoatOfArmsColors.team_red_primary.mantling_color,
			mantling_color_team_white = CoatOfArmsColors.team_white_primary.mantling_color
		},
		{
			ui_text = "menu_color_team_secondary",
			name = "team_secondary",
			menu_color = CoatOfArmsColors.team_red_secondary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_secondary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_secondary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_secondary.material_color,
			mantling_color_team_red = CoatOfArmsColors.team_red_secondary.mantling_color,
			mantling_color_team_white = CoatOfArmsColors.team_white_secondary.mantling_color
		}
	},
	division_colors = {
		{
			name = "argent",
			menu_color = CoatOfArmsColors.argent.menu_color,
			material_color = CoatOfArmsColors.argent.material_color,
			mantling_color = CoatOfArmsColors.argent.mantling_color
		},
		{
			name = "or",
			menu_color = CoatOfArmsColors["or"].menu_color,
			material_color = CoatOfArmsColors["or"].material_color,
			mantling_color = CoatOfArmsColors["or"].mantling_color
		},
		{
			name = "azure",
			menu_color = CoatOfArmsColors.azure.menu_color,
			material_color = CoatOfArmsColors.azure.material_color,
			mantling_color = CoatOfArmsColors.azure.mantling_color
		},
		{
			name = "gules",
			menu_color = CoatOfArmsColors.gules.menu_color,
			material_color = CoatOfArmsColors.gules.material_color,
			mantling_color = CoatOfArmsColors.gules.mantling_color
		},
		{
			name = "purpure",
			menu_color = CoatOfArmsColors.purpure.menu_color,
			material_color = CoatOfArmsColors.purpure.material_color,
			mantling_color = CoatOfArmsColors.purpure.mantling_color
		},
		{
			name = "sable",
			menu_color = CoatOfArmsColors.sable.menu_color,
			material_color = CoatOfArmsColors.sable.material_color,
			mantling_color = CoatOfArmsColors.sable.mantling_color
		},
		{
			name = "vert",
			menu_color = CoatOfArmsColors.vert.menu_color,
			material_color = CoatOfArmsColors.vert.material_color,
			mantling_color = CoatOfArmsColors.vert.mantling_color
		},
		{
			ui_text = "menu_color_team_primary",
			name = "team_primary",
			menu_color = CoatOfArmsColors.team_red_primary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_primary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_primary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_primary.material_color,
			mantling_color_team_red = CoatOfArmsColors.team_red_primary.mantling_color,
			mantling_color_team_white = CoatOfArmsColors.team_white_primary.mantling_color
		},
		{
			ui_text = "menu_color_team_secondary",
			name = "team_secondary",
			menu_color = CoatOfArmsColors.team_red_secondary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_secondary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_secondary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_secondary.material_color,
			mantling_color_team_red = CoatOfArmsColors.team_red_secondary.mantling_color,
			mantling_color_team_white = CoatOfArmsColors.team_white_secondary.mantling_color
		}
	},
	ordinary_colors = {
		{
			name = "argent",
			menu_color = CoatOfArmsColors.argent.menu_color,
			material_color = CoatOfArmsColors.argent.material_color
		},
		{
			name = "or",
			menu_color = CoatOfArmsColors["or"].menu_color,
			material_color = CoatOfArmsColors["or"].material_color
		},
		{
			name = "azure",
			menu_color = CoatOfArmsColors.azure.menu_color,
			material_color = CoatOfArmsColors.azure.material_color
		},
		{
			name = "gules",
			menu_color = CoatOfArmsColors.gules.menu_color,
			material_color = CoatOfArmsColors.gules.material_color
		},
		{
			name = "purpure",
			menu_color = CoatOfArmsColors.purpure.menu_color,
			material_color = CoatOfArmsColors.purpure.material_color
		},
		{
			name = "sable",
			menu_color = CoatOfArmsColors.sable.menu_color,
			material_color = CoatOfArmsColors.sable.material_color
		},
		{
			name = "vert",
			menu_color = CoatOfArmsColors.vert.menu_color,
			material_color = CoatOfArmsColors.vert.material_color
		},
		{
			ui_text = "menu_color_team_primary",
			name = "team_primary",
			menu_color = CoatOfArmsColors.team_red_primary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_primary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_primary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_primary.material_color
		},
		{
			ui_text = "menu_color_team_secondary",
			name = "team_secondary",
			menu_color = CoatOfArmsColors.team_red_secondary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_secondary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_secondary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_secondary.material_color
		}
	},
	charge_colors = {
		{
			name = "argent",
			menu_color = CoatOfArmsColors.argent.menu_color,
			material_color = CoatOfArmsColors.argent.material_color,
			material_complement_color = CoatOfArmsColors.argent.material_complement_color
		},
		{
			name = "or",
			menu_color = CoatOfArmsColors["or"].menu_color,
			material_color = CoatOfArmsColors["or"].material_color,
			material_complement_color = CoatOfArmsColors["or"].material_complement_color
		},
		{
			name = "azure",
			menu_color = CoatOfArmsColors.azure.menu_color,
			material_color = CoatOfArmsColors.azure.material_color,
			material_complement_color = CoatOfArmsColors.azure.material_complement_color
		},
		{
			name = "gules",
			menu_color = CoatOfArmsColors.gules.menu_color,
			material_color = CoatOfArmsColors.gules.material_color,
			material_complement_color = CoatOfArmsColors.gules.material_complement_color
		},
		{
			name = "purpure",
			menu_color = CoatOfArmsColors.purpure.menu_color,
			material_color = CoatOfArmsColors.purpure.material_color,
			material_complement_color = CoatOfArmsColors.purpure.material_complement_color
		},
		{
			name = "sable",
			menu_color = CoatOfArmsColors.sable.menu_color,
			material_color = CoatOfArmsColors.sable.material_color,
			material_complement_color = CoatOfArmsColors.sable.material_complement_color
		},
		{
			name = "vert",
			menu_color = CoatOfArmsColors.vert.menu_color,
			material_color = CoatOfArmsColors.vert.material_color,
			material_complement_color = CoatOfArmsColors.vert.material_complement_color
		},
		{
			ui_text = "menu_color_team_primary",
			name = "team_primary",
			menu_color = CoatOfArmsColors.team_red_primary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_primary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_primary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_primary.material_color,
			material_complement_color_team_white = CoatOfArmsColors.team_white_primary.material_complement_color,
			material_complement_color_team_red = CoatOfArmsColors.team_red_primary.material_complement_color
		},
		{
			ui_text = "menu_color_team_secondary",
			name = "team_secondary",
			menu_color = CoatOfArmsColors.team_red_secondary.menu_color,
			menu_color_2 = CoatOfArmsColors.team_white_secondary.menu_color,
			material_color_team_red = CoatOfArmsColors.team_red_secondary.material_color,
			material_color_team_white = CoatOfArmsColors.team_white_secondary.material_color,
			material_complement_color_team_white = CoatOfArmsColors.team_white_secondary.material_complement_color,
			material_complement_color_team_red = CoatOfArmsColors.team_red_secondary.material_complement_color
		}
	},
	charge_layouts = {
		{
			unlock_key = "normal",
			name = "normal",
			scale = 1,
			modulo = Vector3Box(1, 1, 0),
			offset = Vector3Box(0, 0, 0),
			start_clamp = Vector3Box(0, 0, 0),
			end_clamp = Vector3Box(1, 1, 0)
		},
		{
			unlock_key = "top_left",
			name = "top_left",
			scale = 0.3333333333333333,
			modulo = Vector3Box(1, 1, 0),
			offset = Vector3Box(0, 0, 0),
			start_clamp = Vector3Box(0, 0, 0),
			end_clamp = Vector3Box(0.3333333333333333, 0.3333333333333333, 0)
		},
		{
			unlock_key = "top",
			name = "top",
			scale = 0.3333333333333333,
			modulo = Vector3Box(1, 1, 0),
			offset = Vector3Box(0, 0, 0),
			start_clamp = Vector3Box(0, 0, 0),
			end_clamp = Vector3Box(1, 0.3333333333333333, 0)
		},
		{
			unlock_key = "top_right",
			name = "top_right",
			scale = 0.3333333333333333,
			modulo = Vector3Box(1, 1, 0),
			offset = Vector3Box(0, 0, 0),
			start_clamp = Vector3Box(0.6666666666666666, 0, 0),
			end_clamp = Vector3Box(1, 0.3333333333333333, 0)
		},
		{
			unlock_key = "2x2",
			name = "2x2",
			scale = 0.5,
			modulo = Vector3Box(1, 1, 0),
			offset = Vector3Box(0, 0, 0),
			start_clamp = Vector3Box(0, 0, 0),
			end_clamp = Vector3Box(2, 2, 0)
		},
		{
			unlock_key = "medium",
			name = "medium",
			scale = 0.5,
			modulo = Vector3Box(1, 1, 0),
			offset = Vector3Box(-0.25, -0.25, 0),
			start_clamp = Vector3Box(0.25, 0.25, 0),
			end_clamp = Vector3Box(0.75, 0.75, 0)
		},
		{
			unlock_key = "small",
			name = "small",
			scale = 0.3333333333333333,
			modulo = Vector3Box(1, 1, 0),
			offset = Vector3Box(0, 0, 0),
			start_clamp = Vector3Box(0.3333333333333333, 0.3333333333333333, 0),
			end_clamp = Vector3Box(0.6666666666666666, 0.6666666666666666, 0)
		}
	},
	crests = {
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_torse",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_torse/arm_wotr_helmet_frogmouth_attachment_torse",
			unlock_key = "crest_torse",
			crest_name = "crest_torse",
			display_name = "A",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_antlers",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_antlers/arm_wotr_helmet_attachment_crest_antlers",
			unlock_key = "crest_antlers",
			crest_name = "crest_antlers",
			display_name = "B",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_bird",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_eagle/arm_wotr_helmet_attachment_crest_eagle",
			unlock_key = "crest_bird",
			crest_name = "crest_bird",
			display_name = "C",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_dog",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_dog_w_head/arm_wotr_helmet_attachment_crest_dog_w_head",
			unlock_key = "crest_dog",
			crest_name = "crest_dog",
			display_name = "D",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_horns_w_star",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_horns_w_star/arm_wotr_helmet_attachment_crest_horns_w_star",
			unlock_key = "crest_horns_w_star",
			crest_name = "crest_horns_w_star",
			display_name = "E",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_keytower",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_keytower/arm_wotr_helmet_attachment_crest_keytower",
			unlock_key = "crest_keytower",
			crest_name = "crest_keytower",
			display_name = "F",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_fringe",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_fringe/arm_wotr_helmet_attachment_crest_fringe",
			unlock_key = "crest_fringe",
			crest_name = "crest_fringe",
			display_name = "G",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_small_eagle",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_small_eagle/arm_wotr_helmet_attachment_crest_small_eagle",
			unlock_key = "crest_small_eagle",
			crest_name = "crest_small_eagle",
			display_name = "H",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_badger",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_badger/arm_wotr_helmet_attachment_crest_badger",
			unlock_key = "crest_badger",
			crest_name = "crest_badger",
			display_name = "I",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_badger_preorder",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_badger/arm_wotr_helmet_attachment_crest_badger_preorder",
			unlock_key = "crest_badger_preorder",
			crest_name = "crest_badger_preorder",
			display_name = "J",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_cow",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_cow/arm_wotr_helmet_attachment_crest_cow",
			unlock_key = "crest_cow",
			crest_name = "crest_cow",
			display_name = "K",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_fleur_de_lys",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_fleur_de_lys/arm_wotr_helmet_attachment_crest_fleur_de_lys",
			unlock_key = "crest_fleur_de_lys",
			crest_name = "crest_fleur_de_lys",
			display_name = "L",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_horns_w_plates",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_horns_w_plates/arm_wotr_helmet_attachment_crest_horns_w_plates",
			unlock_key = "crest_horns_w_plates",
			crest_name = "crest_horns_w_plates",
			display_name = "M",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_shield_french_lilies",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_shield_french_lillies/arm_wotr_helmet_attachment_crest_shield_french_lillies",
			unlock_key = "crest_shield_french_lilies",
			crest_name = "crest_shield_french_lilies",
			display_name = "N",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_shield_peacock",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_shield_peakock/arm_wotr_helmet_attachment_crest_shield_peakock",
			unlock_key = "crest_shield_peacock",
			crest_name = "crest_shield_peacock",
			display_name = "O",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_webbed_horns",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_webbed_horns/arm_wotr_helmet_attachment_crest_webbed_horns",
			unlock_key = "crest_webbed_horns",
			crest_name = "crest_webbed_horns",
			display_name = "P",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_one",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_one",
			unlock_key = "crest_plumes_one",
			crest_name = "crest_plumes_one",
			display_name = "Q",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_one_long",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_one_long",
			unlock_key = "crest_plumes_one_long",
			crest_name = "crest_plumes_one_long",
			display_name = "R",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_two",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_two",
			unlock_key = "crest_plumes_two",
			crest_name = "crest_plumes_two",
			display_name = "S",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_three",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_three",
			unlock_key = "crest_plumes_three",
			crest_name = "crest_plumes_three",
			display_name = "T",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_three_2",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_three_2",
			unlock_key = "crest_plumes_three_2",
			crest_name = "crest_plumes_three_2",
			display_name = "U",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_group_1",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_1",
			unlock_key = "crest_plumes_group_1",
			crest_name = "crest_plumes_group_1",
			display_name = "V",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_group_2",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_2",
			unlock_key = "crest_plumes_group_2",
			crest_name = "crest_plumes_group_2",
			display_name = "W",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_group_3",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_3",
			unlock_key = "crest_plumes_group_3",
			crest_name = "crest_plumes_group_3",
			display_name = "X",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		},
		{
			texture_atlas = "coat_of_arms_atlas",
			name = "crest_plumes_group_4",
			ui_unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_4",
			unlock_key = "crest_plumes_group_4",
			crest_name = "crest_plumes_group_4",
			display_name = "Y",
			texture_atlas_settings = CoatOfArmsAtlas.variations_00,
			ui_attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
		}
	},
	shields = {
		{
			ui_unit = "units/menu/coat_of_arms",
			name = "standard"
		}
	},
	helmets = {
		{
			ui_unit = "units/armour/helmets/arm_wotr_helmet_frogsmouth/arm_wotr_helmet_frogsmouth",
			name = "frogmouth",
			ui_attachment_node_linking = AttachmentNodeLinking.helmets.coat_of_arms
		}
	}
}
CoatOfArms.division_types = {}

for name, settings in pairs(CoatOfArmsAtlas) do
	if string.find(name, "divisions_") then
		CoatOfArms.division_types[#CoatOfArms.division_types + 1] = {
			texture_atlas = "coat_of_arms_atlas",
			name = name,
			texture_atlas_settings = settings,
			unlock_key = name
		}
	end
end

CoatOfArms.ordinary_types = {}

for name, settings in pairs(CoatOfArmsAtlas) do
	if string.find(name, "ordinaries_") then
		CoatOfArms.ordinary_types[#CoatOfArms.ordinary_types + 1] = {
			texture_atlas = "coat_of_arms_atlas",
			name = name,
			texture_atlas_settings = settings,
			unlock_key = name
		}
	end
end

CoatOfArms.material_variation_types = {}

for name, settings in pairs(CoatOfArmsAtlas) do
	if string.find(name, "variations_") then
		CoatOfArms.material_variation_types[#CoatOfArms.material_variation_types + 1] = {
			texture_atlas = "coat_of_arms_atlas",
			name = name,
			texture_atlas_settings = settings,
			unlock_key = name
		}
	end
end

CoatOfArms.charge_types = {}

for name, settings in pairs(CoatOfArmsChargesAtlas) do
	if string.find(name, "charge_") then
		CoatOfArms.charge_types[#CoatOfArms.charge_types + 1] = {
			texture_atlas = "coat_of_arms_charges_atlas",
			name = name,
			texture_atlas_settings = settings,
			unlock_key = name
		}
	end
end

local unlock_keys = {}

local function check_unlock_keys(unlock_table)
	for _, props in pairs(unlock_table) do
		fassert(props.unlock_key, "No unlock key found for %q", props.name)
		fassert(unlock_keys[props.unlock_key] == nil, "Duplicate unlock key found for %d", props.unlock_key)

		unlock_keys[props.unlock_key] = true
	end
end

check_unlock_keys(CoatOfArms.material_variation_types)
check_unlock_keys(CoatOfArms.division_types)
check_unlock_keys(CoatOfArms.ordinary_types)
check_unlock_keys(CoatOfArms.charge_types)
check_unlock_keys(CoatOfArms.charge_layouts)
check_unlock_keys(CoatOfArms.crests)

unlock_keys = nil
