-- chunkname: @scripts/settings/helmets.lua

require("scripts/settings/attachment_node_linking")

HelmetCategories = {
	light = {
		ui_description = "helmet_category_description_light",
		ui_texture = "helmet_flawed_mockup",
		ui_header = "helmet_category_name_light",
		ui_sort_index = 1
	},
	medium = {
		ui_description = "helmet_category_description_medium",
		ui_texture = "helmet_flawed_mockup",
		ui_header = "helmet_category_name_medium",
		ui_sort_index = 2
	},
	heavy = {
		ui_description = "helmet_category_description_heavy",
		ui_texture = "helmet_flawed_mockup",
		ui_header = "helmet_category_name_heavy",
		ui_sort_index = 3
	}
}
HelmetCrests = {
	crest_bird = {
		ui_description = "helmet_attachment_description_crest_bird",
		ui_header = "helmet_attachment_name_crest_bird",
		player_name_offset = 0.4,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_eagle/arm_wotr_helmet_attachment_crest_eagle",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_badger = {
		ui_description = "helmet_attachment_description_crest_badger",
		ui_header = "helmet_attachment_name_crest_badger",
		player_name_offset = 0.4,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_badger/arm_wotr_helmet_attachment_crest_badger",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_badger_preorder = {
		ui_description = "helmet_attachment_description_crest_badger_preorder",
		ui_header = "helmet_attachment_name_crest_badger_preorder",
		player_name_offset = 0.4,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_badger/arm_wotr_helmet_attachment_crest_badger_preorder",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_cow = {
		ui_description = "helmet_attachment_description_crest_cow",
		ui_header = "helmet_attachment_name_crest_cow",
		player_name_offset = 0.4,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_cow/arm_wotr_helmet_attachment_crest_cow",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_small_eagle = {
		ui_description = "helmet_attachment_description_crest_small_eagle",
		ui_header = "helmet_attachment_name_crest_small_eagle",
		player_name_offset = 0.4,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_small_eagle/arm_wotr_helmet_attachment_crest_small_eagle",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_dog = {
		ui_description = "helmet_attachment_description_crest_dog",
		ui_header = "helmet_attachment_name_crest_dog",
		player_name_offset = 0.2,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_dog_w_head/arm_wotr_helmet_attachment_crest_dog_w_head",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_fleur_de_lys = {
		ui_description = "helmet_attachment_description_crest_fleur_de_lys",
		ui_header = "helmet_attachment_name_fleur_de_lys",
		player_name_offset = 0.4,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_fleur_de_lys/arm_wotr_helmet_attachment_crest_fleur_de_lys",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_fringe = {
		ui_description = "helmet_attachment_description_crest_fringe",
		ui_header = "helmet_attachment_name_crest_fringe",
		player_name_offset = 0.4,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_fringe/arm_wotr_helmet_attachment_crest_fringe",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_horns_w_plates = {
		ui_description = "helmet_attachment_description_crest_horns_w_star",
		ui_header = "helmet_attachment_name_crest_horns_w_star",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_horns_w_plates/arm_wotr_helmet_attachment_crest_horns_w_plates",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_horns_w_star = {
		ui_description = "helmet_attachment_description_crest_horns_w_star",
		ui_header = "helmet_attachment_name_crest_horns_w_star",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_horns_w_star/arm_wotr_helmet_attachment_crest_horns_w_star",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_keytower = {
		ui_description = "helmet_attachment_description_crest_keytower",
		ui_header = "helmet_attachment_name_crest_keytower",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_keytower/arm_wotr_helmet_attachment_crest_keytower",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_antlers = {
		ui_description = "helmet_attachment_description_crest_antlers",
		ui_header = "helmet_attachment_name_crest_antlers",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_antlers/arm_wotr_helmet_attachment_crest_antlers",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_plumes_one = {
		ui_description = "helmet_attachment_description_plumes_one",
		ui_header = "helmet_attachment_name_plumes_one",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_one",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_plumes_one_long = {
		ui_description = "helmet_attachment_description_plumes_one_long",
		ui_header = "helmet_attachment_name_plumes_one_long",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_one_long",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_plumes_two = {
		ui_description = "helmet_attachment_description_plumes_two",
		ui_header = "helmet_attachment_name_plumes_two",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_two",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_plumes_three = {
		ui_description = "helmet_attachment_description_plumes_three",
		ui_header = "helmet_attachment_name_plumes_three",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_three",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_plumes_three_2 = {
		ui_description = "helmet_attachment_description_plumes_three_2",
		ui_header = "helmet_attachment_name_plumes_three_2",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_three_2",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_plumes_group_1 = {
		ui_description = "helmet_attachment_description_plumes_group_1",
		ui_header = "helmet_attachment_name_plumes_group_1",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_1",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_plumes_group_2 = {
		ui_description = "helmet_attachment_description_plumes_group_2",
		ui_header = "helmet_attachment_name_plumes_group_2",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_2",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_plumes_group_3 = {
		ui_description = "helmet_attachment_description_plumes_group_3",
		ui_header = "helmet_attachment_name_plumes_group_3",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_3",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_plumes_group_4 = {
		ui_description = "helmet_attachment_description_plumes_group_4",
		ui_header = "helmet_attachment_name_plumes_group_4",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_4",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_shield_french_lilies = {
		ui_description = "helmet_attachment_description_french_lillies",
		ui_header = "helmet_attachment_name_shield_french_lillies",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_shield_french_lillies/arm_wotr_helmet_attachment_crest_shield_french_lillies",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_shield_peacock = {
		ui_description = "helmet_attachment_description_shield_peacock",
		ui_header = "helmet_attachment_name_shield_peacock",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_shield_peakock/arm_wotr_helmet_attachment_crest_shield_peakock",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	crest_torse = {
		ui_description = "helmet_attachment_description_crest_torse",
		ui_header = "helmet_attachment_name_crest_torse",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_torse/arm_wotr_helmet_frogmouth_attachment_torse",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	},
	crest_webbed_horns = {
		ui_description = "helmet_attachment_description_crest_webbed_horns",
		ui_header = "helmet_attachment_name_crest_webbed_horns",
		player_name_offset = 0,
		type = "crest",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_webbed_horns/arm_wotr_helmet_attachment_crest_webbed_horns",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.crests.standard
	}
}
HelmetCoifs = {
	mail_coif_01 = {
		ui_description = "helmet_attachment_description_mail_coif",
		no_decapitation = true,
		type = "coif",
		unlock_key = 1,
		release_name = "main",
		ui_sort_index = 1,
		ui_header = "helmet_attachment_name_mail_coif",
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_mail_coif/arm_wotr_helmet_attachment_mail_coif",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.coifs.standard
	},
	mail_coif_galloglass = {
		ui_description = "helmet_attachment_description_mail_coif_galloglass",
		ui_sort_index = 2,
		type = "coif",
		unlock_key = 156,
		release_name = "scottish",
		no_decapitation = true,
		ui_header = "helmet_attachment_name_mail_coif_galloglass",
		market_price = 20000,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_mail_coif_galloglass/arm_wotr_helmet_attachment_mail_coif_galloglass",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.coifs.standard
	},
	armorycap = {
		ui_description = "helmet_attachment_description_armorycap",
		type = "coif",
		unlock_key = 2,
		release_name = "main",
		ui_sort_index = 3,
		ui_header = "helmet_attachment_name_armorycap",
		market_price = 3000,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_armorycap/arm_wotr_helmet_attachment_armorycap",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.coifs.standard
	},
	cloth_hood_down = {
		ui_description = "helmet_attachment_cloth_hood_down_desc",
		use_helmet_material_variations = true,
		hud_overlay_texture = "mockup_hud_cloth_hood_down",
		type = "coif",
		unlock_key = 57,
		release_name = "main",
		ui_sort_index = 4,
		ui_header = "helmet_attachment_cloth_hood_down_name",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_cloth_hood_down/arm_wotr_helmet_attachment_cloth_hood_down",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.coifs.standard
	},
	cloth_hood_tuckedin = {
		ui_description = "helmet_attachment_cloth_hood_tuckedin_desc",
		use_helmet_material_variations = true,
		hud_overlay_texture = "mockup_hud_cloth_hood_down",
		type = "coif",
		unlock_key = 58,
		no_decapitation = true,
		release_name = "main",
		ui_sort_index = 5,
		ui_header = "helmet_attachment_cloth_hood_tuckedin_name",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_cloth_hood_tuckedin/arm_wotr_helmet_attachment_cloth_hood_tuckedin",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.coifs.standard
	},
	face_cloth = {
		ui_description = "gear_sherwood_helmet_attachment_face_cloth_descr",
		use_helmet_material_variations = true,
		hud_overlay_texture = "mockup_hud_cloth_hood_down",
		type = "coif",
		unlock_key = 300,
		release_name = "undecided",
		ui_sort_index = 7,
		ui_header = "gear_sherwood_helmet_attachment_face_cloth_name",
		market_price = 500000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_face_cloth/arm_wotr_helmet_attachment_face_cloth",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.coifs.standard
	},
	face_cloth_armoury_cap = {
		ui_description = "gear_sherwood_helmet_attachment_face_cloth_desc",
		use_helmet_material_variations = true,
		hud_overlay_texture = "mockup_hud_cloth_hood_down",
		type = "coif",
		unlock_key = 301,
		release_name = "sherwood",
		ui_sort_index = 8,
		ui_header = "gear_sherwood_helmet_attachment_face_cloth_name",
		market_price = 500000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_face_cloth/arm_wotr_helmet_attachment_face_cloth_armoury_cap",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.coifs.standard
	}
}
HelmetPlumes = {
	plumes_one = {
		ui_description = "helmet_attachment_description_plumes_one",
		type = "plume",
		unlock_key = 3,
		release_name = "main",
		ui_sort_index = 1,
		ui_header = "helmet_attachment_name_plumes_one",
		market_price = 600,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_one",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	plumes_one_long = {
		ui_description = "helmet_attachment_description_plumes_one_long",
		type = "plume",
		unlock_key = 4,
		release_name = "main",
		ui_sort_index = 2,
		ui_header = "helmet_attachment_name_plumes_one_long",
		market_price = 800,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_one_long",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	plumes_two = {
		ui_description = "helmet_attachment_description_plumes_two",
		type = "plume",
		unlock_key = 5,
		release_name = "main",
		ui_sort_index = 3,
		ui_header = "helmet_attachment_name_plumes_two",
		market_price = 1100,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_two",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	plumes_three = {
		ui_description = "helmet_attachment_description_plumes_three",
		type = "plume",
		unlock_key = 6,
		release_name = "main",
		ui_sort_index = 4,
		ui_header = "helmet_attachment_name_plumes_three",
		market_price = 1800,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_three",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	plumes_three_2 = {
		ui_description = "helmet_attachment_description_plumes_three_2",
		type = "plume",
		unlock_key = 7,
		release_name = "main",
		ui_sort_index = 5,
		ui_header = "helmet_attachment_name_plumes_three_2",
		market_price = 1800,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_three_2",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	plumes_group_1 = {
		ui_description = "helmet_attachment_description_plumes_group_1",
		type = "plume",
		unlock_key = 8,
		release_name = "main",
		ui_sort_index = 6,
		ui_header = "helmet_attachment_name_plumes_group_1",
		market_price = 2200,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_1",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	plumes_group_2 = {
		ui_description = "helmet_attachment_description_plumes_group_2",
		type = "plume",
		unlock_key = 9,
		release_name = "main",
		ui_sort_index = 7,
		ui_header = "helmet_attachment_name_plumes_group_2",
		market_price = 2300,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_2",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	plumes_group_3 = {
		ui_description = "helmet_attachment_description_plumes_group_3",
		type = "plume",
		unlock_key = 10,
		release_name = "main",
		ui_sort_index = 8,
		ui_header = "helmet_attachment_name_plumes_group_3",
		market_price = 3900,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_3",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	},
	plumes_group_4 = {
		ui_description = "helmet_attachment_description_plumes_group_4",
		type = "plume",
		unlock_key = 11,
		release_name = "main",
		ui_sort_index = 9,
		ui_header = "helmet_attachment_name_plumes_group_4",
		market_price = 4000,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_plumes/arm_wotr_helmet_attachment_plumes_group_4",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.plumes.standard
	}
}
HelmetFeathers = {
	feathers_one = {
		ui_description = "helmet_attachment_description_feather_single_1",
		type = "feathers",
		unlock_key = 12,
		release_name = "main",
		ui_sort_index = 1,
		ui_header = "helmet_attachment_name_feather_single_1",
		market_price = 500,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_single_1",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_one_long = {
		ui_description = "helmet_attachment_description_feather_single_2",
		type = "feathers",
		unlock_key = 13,
		release_name = "main",
		ui_sort_index = 2,
		ui_header = "helmet_attachment_name_feather_single_2",
		market_price = 600,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_single_2",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_two = {
		ui_description = "helmet_attachment_description_feather_single_3",
		type = "feathers",
		unlock_key = 14,
		release_name = "main",
		ui_sort_index = 3,
		ui_header = "helmet_attachment_name_feather_single_3",
		market_price = 1100,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_single_3",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_three = {
		ui_description = "helmet_attachment_description_feather_single_4",
		type = "feathers",
		unlock_key = 15,
		release_name = "main",
		ui_sort_index = 4,
		ui_header = "helmet_attachment_name_feather_single_4",
		market_price = 600,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_single_4",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_three_2 = {
		ui_description = "helmet_attachment_description_feather_single_5",
		type = "feathers",
		unlock_key = 16,
		release_name = "main",
		ui_sort_index = 5,
		ui_header = "helmet_attachment_name_feather_single_5",
		market_price = 400,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_single_5",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feather_single_6 = {
		ui_description = "helmet_attachment_description_feather_single_6",
		type = "feathers",
		unlock_key = 17,
		release_name = "main",
		ui_sort_index = 6,
		ui_header = "helmet_attachment_name_feather_single_6",
		market_price = 400,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_single_6",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feather_single_7 = {
		ui_description = "helmet_attachment_description_feather_single_7",
		type = "feathers",
		unlock_key = 18,
		release_name = "main",
		ui_sort_index = 7,
		ui_header = "helmet_attachment_name_feather_single_7",
		market_price = 800,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_single_7",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_group_1 = {
		ui_description = "helmet_attachment_description_feather_group_1",
		type = "feathers",
		unlock_key = 19,
		release_name = "main",
		ui_sort_index = 8,
		ui_header = "helmet_attachment_name_feather_group_1",
		market_price = 3200,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_group_1",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_group_2 = {
		ui_description = "helmet_attachment_description_feather_group_2",
		type = "feathers",
		unlock_key = 20,
		release_name = "main",
		ui_sort_index = 9,
		ui_header = "helmet_attachment_name_feather_group_2",
		market_price = 1600,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_group_2",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_group_3 = {
		ui_description = "helmet_attachment_description_feather_group_3",
		type = "feathers",
		unlock_key = 21,
		release_name = "main",
		ui_sort_index = 10,
		ui_header = "helmet_attachment_name_feather_group_3",
		market_price = 2700,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_group_3",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_group_4 = {
		ui_description = "helmet_attachment_description_feather_group_4",
		type = "feathers",
		unlock_key = 22,
		release_name = "main",
		ui_sort_index = 11,
		ui_header = "helmet_attachment_name_feather_group_4",
		market_price = 2200,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_group_4",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	},
	feathers_group_5 = {
		ui_description = "helmet_attachment_description_feather_group_5",
		type = "feathers",
		unlock_key = 23,
		release_name = "main",
		ui_sort_index = 12,
		ui_header = "helmet_attachment_name_feather_group_5",
		market_price = 1600,
		encumbrance = 0.1,
		unit = "units/armour/helmets/arm_wotr_helmet_attachment_feathers/arm_wotr_helmet_attachment_feather_group_5",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.feathers.standard
	}
}
TournamentWinnerHelmetPatterns = {
	pattern_gilded = {
		ui_description = "helmet_metal_pattern_gilded_royal_description",
		name = "helmet_metal_pattern_gilded_royal",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 200,
		hide_if_unavailable = true,
		ui_sort_index = 7,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_eurocup_2013",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.9, 0.7, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.9, 0.7, 0.3),
		team_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.124),
		team_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.124)
	}
}
PlateHelmetPatterns = {
	pattern_standard = {
		ui_description = "helmet_metal_pattern_rusty_description",
		name = "helmet_metal_pattern_rusty",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 24,
		release_name = "main",
		ui_sort_index = 1,
		personal_pattern_v = 0.5,
		ui_header = "helmet_metal_pattern_rusty_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.02, 0.02, 0.02),
		personal_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_primary = Vector3Box(0.58, 0.36, 0.17),
		team_pattern_tint_secondary = Vector3Box(0.58, 0.36, 0.17)
	},
	pattern_red_and_black_preorder = {
		ui_description = "helmet_metal_pattern_red_and_black_preorder_description",
		name = "helmet_metal_pattern_red_and_black_preorder",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 25,
		market_price = 20000,
		release_name = "main",
		ui_sort_index = 2,
		personal_pattern_v = 0.5,
		ui_header = "helmet_metal_pattern_red_and_black_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.45, 0.0715, 0.0715),
		personal_pattern_tint_secondary = Vector3Box(0.45, 0.0715, 0.0715),
		team_pattern_tint_primary = Vector3Box(0.45, 0.0715, 0.0715),
		team_pattern_tint_secondary = Vector3Box(0.45, 0.0715, 0.0715),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_red_and_black_preorder_bascinet = {
		ui_description = "helmet_metal_pattern_red_and_black_preorder_bascinet_description",
		name = "helmet_metal_pattern_red_and_black_preorder_bascinet",
		team_pattern_u = -0.5,
		type = "pattern",
		unlock_key = 26,
		market_price = 20000,
		release_name = "main",
		ui_sort_index = 3,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_red_and_black_preorder_bascinet_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.9, 0.025, 0.05),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.025, 0.05),
		team_pattern_tint_primary = Vector3Box(0.9, 0.025, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.9, 0.025, 0.05),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_white_and_blue_preorder = {
		ui_description = "helmet_metal_pattern_white_and_blue_preorder_description",
		name = "helmet_metal_pattern_white_and_blue_preorder",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 27,
		market_price = 15000,
		release_name = "main",
		ui_sort_index = 4,
		personal_pattern_v = 0.5,
		ui_header = "helmet_metal_pattern_white_and_blue_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.25, 0.2, 0.55),
		personal_pattern_tint_secondary = Vector3Box(0.25, 0.2, 0.55),
		team_pattern_tint_primary = Vector3Box(2.5, 2.5, 2.5),
		team_pattern_tint_secondary = Vector3Box(2.5, 2.5, 2.5),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_polished = {
		ui_description = "helmet_metal_pattern_polished_description",
		name = "helmet_metal_pattern_polished",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 28,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 5,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_polished_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_blued = {
		ui_description = "helmet_metal_pattern_blued_description",
		name = "helmet_metal_pattern_blued",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 29,
		market_price = 500000,
		release_name = "swiss",
		ui_sort_index = 6,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_blued_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.075, 0.095, 0.18),
		personal_pattern_tint_secondary = Vector3Box(0.075, 0.095, 0.18),
		team_pattern_tint_primary = Vector3Box(0.075, 0.095, 0.18),
		team_pattern_tint_secondary = Vector3Box(0.075, 0.095, 0.18)
	},
	pattern_gilded = {
		ui_description = "helmet_metal_pattern_gilded_royal_description",
		name = "helmet_metal_pattern_gilded_royal",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 30,
		market_price = 500000,
		release_name = "swiss",
		ui_sort_index = 7,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_gilded_royal_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.9, 0.7, 0.3),
		personal_pattern_tint_secondary = Vector3Box(0.9, 0.7, 0.3),
		team_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.124),
		team_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.124)
	},
	pattern_red_knight = {
		ui_description = "helmet_metal_pattern_red_knight_description",
		name = "helmet_metal_pattern_red_knight",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 31,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 8,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_red_knight_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.7, 0.3, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.7, 0.3, 0.2),
		team_pattern_tint_primary = Vector3Box(0.7, 0.3, 0.2),
		team_pattern_tint_secondary = Vector3Box(0.7, 0.3, 0.2)
	},
	pattern_black_and_blue = {
		ui_description = "helmet_metal_pattern_black_and_blue_description",
		name = "helmet_metal_pattern_black_and_blue",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 32,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 9,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_black_and_blue_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.35, 0.5, 0.85),
		personal_pattern_tint_secondary = Vector3Box(0.35, 0.5, 0.85),
		team_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.24),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.24)
	},
	pattern_black_as_knight = {
		ui_description = "helmet_metal_pattern_black_as_knight_description",
		name = "helmet_metal_pattern_black_as_knight",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 33,
		market_price = 20000,
		release_name = "main",
		ui_sort_index = 10,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_black_as_knight_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.24),
		personal_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.24),
		team_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.24),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.24)
	},
	pattern_brown_knight = {
		ui_description = "helmet_metal_pattern_brown_knight_description",
		name = "helmet_metal_pattern_brown_knight",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 34,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 11,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_brown_knight_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.3, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.3, 0.2),
		team_pattern_tint_primary = Vector3Box(0.4, 0.3, 0.2),
		team_pattern_tint_secondary = Vector3Box(0.4, 0.3, 0.2)
	},
	pattern_red_details = {
		ui_description = "helmet_metal_pattern_red_details_description",
		name = "helmet_metal_pattern_red_details",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 35,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 12,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_red_details_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(2, 2, 2),
		personal_pattern_tint_secondary = Vector3Box(2, 2, 2),
		team_pattern_tint_primary = Vector3Box(0.8, 0.2, 0.3),
		team_pattern_tint_secondary = Vector3Box(0.8, 0.2, 0.3)
	},
	pattern_red_and_green = {
		ui_description = "helmet_metal_pattern_red_and_green_description",
		name = "helmet_metal_pattern_red_and_green",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 36,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 13,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_red_and_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.7, 0.3, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.7, 0.3, 0.2),
		team_pattern_tint_primary = Vector3Box(0.35, 0.67, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.35, 0.67, 0.5)
	},
	pattern_red_and_black = {
		ui_description = "helmet_metal_pattern_red_and_black_description",
		name = "helmet_metal_pattern_red_and_black",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 37,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 14,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_red_and_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.7, 0.3, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.7, 0.3, 0.2),
		team_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.24),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.24)
	},
	pattern_green_and_black = {
		ui_description = "helmet_metal_pattern_green_and_black_description",
		name = "helmet_metal_pattern_green_and_black",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 38,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 15,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_green_and_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.35, 0.67, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.35, 0.67, 0.5),
		team_pattern_tint_primary = Vector3Box(0.2, 0.2, 0.24),
		team_pattern_tint_secondary = Vector3Box(0.2, 0.2, 0.24)
	},
	pattern_orange_split = {
		ui_description = "helmet_metal_pattern_orange_split_description",
		name = "helmet_metal_pattern_orange_split",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 76,
		market_price = 20000,
		release_name = "scottish",
		ui_sort_index = 16,
		personal_pattern_v = 0,
		ui_header = "helmet_metal_pattern_orange_split_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(1.27, 0.3, 0.1),
		personal_pattern_tint_secondary = Vector3Box(2.2, 1.2, 0.2),
		team_pattern_tint_primary = Vector3Box(2.2, 1.2, 0.2),
		team_pattern_tint_secondary = Vector3Box(1.27, 0.3, 0.1)
	}
}
ClothHelmetPatterns = {
	pattern_base = {
		ui_description = "helmet_cloth_no_tint_description",
		name = "helmet_cloth_no_tint",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 39,
		release_name = "main",
		ui_sort_index = 1,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_no_tint_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0, 0, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0, 0, 0),
		team_pattern_tint_secondary = Vector3Box(0, 0, 0)
	},
	pattern_standard = {
		ui_description = "helmet_cloth_pattern_standard_description",
		name = "helmet_cloth_pattern_standard",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 40,
		release_name = "main",
		ui_sort_index = 2,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_standard_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.4, 0.3, 0.2),
		personal_pattern_tint_secondary = Vector3Box(0.4, 0.3, 0.2),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_red_and_black_preorder = {
		ui_description = "helmet_cloth_pattern_red_and_black_preorder_description",
		name = "helmet_cloth_pattern_red_and_black_preorder",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 41,
		market_price = 20000,
		release_name = "main",
		ui_sort_index = 3,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_red_and_black_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.07, 0.07, 0.07),
		team_pattern_tint_secondary = Vector3Box(0.24, 0.02, 0.07),
		required_dlc = DLCSettings.house_of_lancaster_armor_set()
	},
	pattern_white_and_blue_preorder = {
		ui_description = "helmet_cloth_pattern_white_and_blue_preorder_description",
		name = "helmet_cloth_pattern_white_and_blue_preorder",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 42,
		market_price = 20000,
		release_name = "main",
		ui_sort_index = 4,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_white_and_blue_preorder_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.07, 0.07, 0.07),
		personal_pattern_tint_secondary = Vector3Box(0.027, 0.027, 0.08),
		team_pattern_tint_primary = Vector3Box(0.7, 0.7, 0.7),
		team_pattern_tint_secondary = Vector3Box(0.07, 0.07, 0.25),
		required_dlc = DLCSettings.house_of_york_armor_set()
	},
	pattern_gilded = {
		ui_description = "helmet_cloth_pattern_gilded_royal_description",
		name = "helmet_cloth_pattern_gilded_royal",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 43,
		market_price = 20000,
		release_name = "main",
		ui_sort_index = 5,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_gilded_royal_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.09, 0.07, 0.03),
		team_pattern_tint_secondary = Vector3Box(0.9, 0.7, 0.3)
	},
	pattern_red_knight = {
		ui_description = "helmet_cloth_pattern_red_knight_description",
		name = "helmet_cloth_pattern_red_knight",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 44,
		market_price = 5000,
		release_name = "main",
		ui_sort_index = 6,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_red_knight_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.1),
		personal_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.1),
		team_pattern_tint_primary = Vector3Box(0.24, 0.05, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.24, 0.05, 0.05)
	},
	pattern_black_and_blue = {
		ui_description = "helmet_cloth_pattern_black_and_blue_description",
		name = "helmet_cloth_pattern_black_and_blue",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 45,
		market_price = 5000,
		release_name = "main",
		ui_sort_index = 7,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_black_and_blue_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.07, 0.15, 0.4),
		team_pattern_tint_secondary = Vector3Box(0.07, 0.07, 0.07)
	},
	pattern_black_as_knight = {
		ui_description = "helmet_cloth_pattern_black_as_knight_description",
		name = "helmet_cloth_pattern_black_as_knight",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 46,
		market_price = 50000,
		release_name = "main",
		ui_sort_index = 8,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_black_as_knight_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(1, 1, 1),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(0.07, 0.07, 0.07),
		team_pattern_tint_secondary = Vector3Box(0.07, 0.07, 0.07)
	},
	pattern_brown_knight = {
		ui_description = "helmet_cloth_pattern_brown_knight_description",
		name = "helmet_cloth_pattern_brown_knight",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 47,
		market_price = 5000,
		release_name = "main",
		ui_sort_index = 9,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_brown_knight_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.24, 0.16, 0.07),
		personal_pattern_tint_secondary = Vector3Box(0.24, 0.16, 0.07),
		team_pattern_tint_primary = Vector3Box(0.24, 0.16, 0.07),
		team_pattern_tint_secondary = Vector3Box(0.24, 0.16, 0.07)
	},
	pattern_red_details = {
		ui_description = "helmet_cloth_pattern_red_details_description",
		name = "helmet_cloth_pattern_red_details",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 48,
		market_price = 5000,
		release_name = "main",
		ui_sort_index = 10,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_red_details_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.24, 0.05, 0.05)
	},
	pattern_red_and_green = {
		ui_description = "helmet_cloth_pattern_red_and_green_description",
		name = "helmet_cloth_pattern_red_and_green",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 49,
		market_price = 5000,
		release_name = "main",
		ui_sort_index = 11,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_red_and_green_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.63, 0.34, 0.26),
		personal_pattern_tint_secondary = Vector3Box(0.63, 0.34, 0.26),
		team_pattern_tint_primary = Vector3Box(0.05, 0.13, 0.07),
		team_pattern_tint_secondary = Vector3Box(0.24, 0.13, 0.1)
	},
	pattern_red_and_black = {
		ui_description = "helmet_cloth_pattern_red_and_black_description",
		name = "helmet_cloth_pattern_red_and_black",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 50,
		market_price = 10000,
		release_name = "main",
		ui_sort_index = 12,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_red_and_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.1),
		personal_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.1),
		team_pattern_tint_primary = Vector3Box(0.35, 0.13, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.35, 0.13, 0.1)
	},
	pattern_green_and_black = {
		ui_description = "helmet_cloth_pattern_green_and_black_description",
		name = "helmet_cloth_pattern_green_and_black",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 51,
		market_price = 5000,
		release_name = "main",
		ui_sort_index = 13,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_green_and_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.848, 0),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.848, 0),
		team_pattern_tint_primary = Vector3Box(0.04, 0.08, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.04, 0.08, 0.05)
	},
	pattern_orange = {
		ui_description = "helmet_cloth_pattern_orange_description",
		name = "helmet_cloth_pattern_orange",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 77,
		market_price = 20000,
		release_name = "scottish",
		ui_sort_index = 14,
		personal_pattern_v = 0,
		ui_header = "helmet_cloth_pattern_orange_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.1),
		personal_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.1),
		team_pattern_tint_primary = Vector3Box(0.65, 0.37, 0.03),
		team_pattern_tint_secondary = Vector3Box(0.35, 0.075, 0.01)
	}
}
BearHelmetPatterns = {
	pattern_base = {
		ui_description = "helmet_bear_helmet_base_description",
		name = "helmet_bear_helmet_base",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 100,
		release_name = "winter",
		ui_sort_index = 1,
		personal_pattern_v = 0,
		ui_header = "helmet_bear_helmet_base_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_red = {
		ui_description = "helmet_bear_helmet_base_red_description",
		name = "helmet_bear_helmet_base_red",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 101,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 2,
		personal_pattern_v = 0,
		ui_header = "helmet_bear_helmet_base_red_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.258, 0.005, 0.029),
		team_pattern_tint_primary = Vector3Box(0.258, 0.005, 0.029),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_blue = {
		ui_description = "helmet_bear_helmet_base_blue_description",
		name = "helmet_bear_helmet_base_blue",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 102,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 3,
		personal_pattern_v = 0,
		ui_header = "helmet_bear_helmet_base_blue_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.077, 0.072, 0.923),
		team_pattern_tint_primary = Vector3Box(0.077, 0.072, 0.923),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_green = {
		ui_description = "helmet_bear_helmet_base_green_description",
		name = "helmet_bear_helmet_base_green",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 103,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 4,
		personal_pattern_v = 0,
		ui_header = "helmet_bear_helmet_base_green_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.263, 0.746, 0.234),
		team_pattern_tint_primary = Vector3Box(0.263, 0.746, 0.234),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_gray_square_rim = {
		ui_description = "helmet_bear_helmet_base_gray_square_rim_description",
		name = "helmet_bear_helmet_base_gray_square_rim",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 104,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 5,
		personal_pattern_v = 0,
		ui_header = "helmet_bear_helmet_base_gray_square_rim_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0, 0, 0),
		personal_pattern_tint_secondary = Vector3Box(0.025, 0.025, 0.025),
		team_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.1),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_green_square_rim = {
		ui_description = "helmet_bear_helmet_base_green_square_rim_description",
		name = "helmet_bear_helmet_base_green_square_rim",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 105,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 6,
		personal_pattern_v = 0,
		ui_header = "helmet_bear_helmet_base_green_square_rim_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0, 0, 0),
		personal_pattern_tint_secondary = Vector3Box(0.23, 0.364, 0),
		team_pattern_tint_primary = Vector3Box(0.01, 0.23, 0.062),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_blue_white_trishape_rim = {
		ui_description = "helmet_bear_helmet_base_blue_white_trishape_rim_description",
		name = "helmet_bear_helmet_base_blue_white_trishape_rim",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 106,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 7,
		personal_pattern_v = 0.5,
		ui_header = "helmet_bear_helmet_base_blue_white_trishape_rim_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.1, 0.1, 0.1),
		personal_pattern_tint_secondary = Vector3Box(0, 0.115, 0.742),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_red_green_trishape_rim = {
		ui_description = "helmet_bear_helmet_base_red_green_trishape_rim_description",
		name = "helmet_bear_helmet_base_red_green_trishape_rim",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 107,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 8,
		personal_pattern_v = 0.5,
		ui_header = "helmet_bear_helmet_base_red_green_trishape_rim_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0, 0, 0),
		personal_pattern_tint_secondary = Vector3Box(0.191, 0, 0),
		team_pattern_tint_primary = Vector3Box(0, 0.148, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_blooded = {
		ui_description = "helmet_bear_helmet_base_blooded_description",
		name = "helmet_bear_helmet_base_blooded",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 108,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 9,
		personal_pattern_v = 0,
		ui_header = "helmet_bear_helmet_base_blooded_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0, 0, 0),
		personal_pattern_tint_secondary = Vector3Box(0.129, 0, 0),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_base_red_light_fur = {
		ui_description = "helmet_bear_helmet_base_red_light_fur_description",
		name = "helmet_bear_helmet_base_red_light_fur",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 109,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 10,
		personal_pattern_v = 0.5,
		ui_header = "helmet_bear_helmet_base_red_light_fur_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.75, 0.75, 0.75),
		personal_pattern_tint_secondary = Vector3Box(0.129, 0, 0),
		team_pattern_tint_primary = Vector3Box(0.191, 0, 0),
		team_pattern_tint_secondary = Vector3Box(2, 2, 2)
	},
	pattern_base_black_dark_fur = {
		ui_description = "helmet_bear_helmet_base_black_dark_fur_description",
		name = "helmet_bear_helmet_base_black_dark_fur",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 110,
		market_price = 100000,
		release_name = "winter",
		ui_sort_index = 11,
		personal_pattern_v = 0,
		ui_header = "helmet_bear_helmet_base_black_dark_fur_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.05, 0.05, 0.05),
		team_pattern_tint_secondary = Vector3Box(0.05, 0.05, 0.05)
	}
}
MailcoifPatterns = {
	pattern_standard = {
		ui_description = "helmet_mailcoif_standard_description",
		name = "helmet_mailcoif_standard",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 150,
		market_price = 25000,
		release_name = "scottish",
		ui_sort_index = 1,
		personal_pattern_v = 0,
		ui_header = "helmet_mailcoif_standard_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.35, 0.35, 0.35),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	},
	pattern_black = {
		ui_description = "helmet_mailcoif_black_description",
		name = "helmet_mailcoif_black",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 151,
		market_price = 100000,
		release_name = "scottish",
		ui_sort_index = 2,
		personal_pattern_v = 0,
		ui_header = "helmet_mailcoif_black_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(0, 0, 0)
	},
	pattern_white = {
		ui_description = "helmet_mailcoif_white_description",
		name = "helmet_mailcoif_white",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 152,
		market_price = 20000,
		release_name = "scottish",
		ui_sort_index = 3,
		personal_pattern_v = 0,
		ui_header = "helmet_mailcoif_white_header",
		personal_pattern_u = 0,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_secondary = Vector3Box(1, 1, 1)
	},
	pattern_torned_black = {
		ui_description = "helmet_mailcoif_torned_black_description",
		name = "helmet_mailcoif_torned_black",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 153,
		market_price = 50000,
		release_name = "scottish",
		ui_sort_index = 4,
		personal_pattern_v = 0.5,
		ui_header = "helmet_mailcoif_torned_black_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.116, 0.0058, 0),
		personal_pattern_tint_secondary = Vector3Box(0, 0, 0),
		team_pattern_tint_primary = Vector3Box(1, 1, 1),
		team_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.1)
	},
	pattern_torned = {
		ui_description = "helmet_mailcoif_torned_description",
		name = "helmet_mailcoif_torned",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 154,
		market_price = 20000,
		release_name = "scottish",
		ui_sort_index = 5,
		personal_pattern_v = 0.5,
		ui_header = "helmet_mailcoif_torned_header",
		personal_pattern_u = 0.5,
		team_pattern_v = 0,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.116, 0.0058, 0),
		personal_pattern_tint_secondary = Vector3Box(1, 1, 1),
		team_pattern_tint_primary = Vector3Box(0, 0, 0),
		team_pattern_tint_secondary = Vector3Box(0.1, 0.1, 0.1)
	},
	pattern_rust = {
		ui_description = "helmet_mailcoif_rust_description",
		name = "helmet_mailcoif_rust",
		team_pattern_u = 0,
		type = "pattern",
		unlock_key = 155,
		market_price = 20000,
		release_name = "scottish",
		ui_sort_index = 6,
		personal_pattern_v = 0,
		ui_header = "helmet_mailcoif_rust_header",
		personal_pattern_u = 0,
		team_pattern_v = 0.5,
		encumbrance = 0,
		personal_pattern_tint_primary = Vector3Box(0.5, 0.5, 0.5),
		personal_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5),
		team_pattern_tint_primary = Vector3Box(0.282, 0.077, 0),
		team_pattern_tint_secondary = Vector3Box(0.5, 0.5, 0.5)
	}
}
HelmetVisors = {
	sallet_visor_standard = {
		ui_description = "helmet_attachment_description_visor_standard",
		use_helmet_material_variations = true,
		hud_overlay_texture = "mockup_hud_visor_sallet_standard",
		type = "visor",
		unlock_key = 52,
		release_name = "main",
		ui_sort_index = 1,
		ui_header = "helmet_attachment_name_visor_standard",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_sallet/arm_wotr_helmet_sallet_attachment_visor",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.visors.standard,
		meshes = {
			g_wotr_helmet_sallet_visor_lod0 = {
				"wotr_helmet_heavy_002_mat"
			},
			g_wotr_helmet_sallet_visor_lod1 = {
				"wotr_helmet_heavy_002_mat"
			},
			g_wotr_helmet_sallet_visor_lod2 = {
				"wotr_helmet_heavy_002_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_sallet_visor_lod0 = {
				"wotr_helmet_heavy_002_mat"
			},
			g_wotr_helmet_sallet_visor_lod1 = {
				"wotr_helmet_heavy_002_mat"
			},
			g_wotr_helmet_sallet_visor_lod2 = {
				"wotr_helmet_heavy_002_mat"
			}
		}
	},
	sallet_bevor_01 = {
		ui_description = "helmet_attachment_description_bevor_01",
		use_helmet_material_variations = true,
		hud_overlay_texture = "mockup_hud_visor_sallet_standard",
		type = "coif",
		unlock_key = 53,
		release_name = "main",
		ui_sort_index = 2,
		ui_header = "helmet_attachment_name_bevor_01",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_sallet/arm_wotr_helmet_sallet_attachment_bevor",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.coifs.standard,
		meshes = {
			g_wotr_helmet_sallet_bevor_lod0 = {
				"wotr_helmet_sallet_bevor_skinned_mat",
				"wotr_helmet_sallet_bevor_skinned_metal_mat"
			},
			g_wotr_helmet_sallet_bevor_lod1 = {
				"wotr_helmet_sallet_bevor_skinned_metal_mat"
			},
			g_wotr_helmet_sallet_bevor_lod2 = {
				"wotr_helmet_sallet_bevor_skinned_metal_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_sallet_bevor_lod0 = {
				"wotr_helmet_sallet_bevor_skinned_mat",
				"wotr_helmet_sallet_bevor_skinned_metal_mat"
			},
			g_wotr_helmet_sallet_bevor_lod1 = {
				"wotr_helmet_sallet_bevor_skinned_metal_mat"
			},
			g_wotr_helmet_sallet_bevor_lod2 = {
				"wotr_helmet_sallet_bevor_skinned_metal_mat"
			}
		}
	},
	armet_bevor_01 = {
		ui_description = "helmet_attachment_description_bevor_02",
		use_helmet_material_variations = true,
		type = "coif",
		unlock_key = 54,
		release_name = "main",
		ui_sort_index = 3,
		ui_header = "helmet_attachment_name_bevor_02",
		market_price = 3000,
		encumbrance = 10,
		unit = "units/armour/helmets/arm_wotr_helmet_armet/arm_wotr_helmet_armet_bevor",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.bevors.armet,
		meshes = {
			g_wotr_helmet_armet_bevor_lod0 = {
				"wotr_helmet_armet_metal_mat"
			},
			g_wotr_helmet_armet_bevor_lod1 = {
				"wotr_helmet_armet_metal_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_armet_bevor_lod0 = {
				"wotr_helmet_armet_metal_mat"
			},
			g_wotr_helmet_armet_bevor_lod1 = {
				"wotr_helmet_armet_metal_mat"
			}
		}
	},
	bascinet_visor_roundface = {
		ui_description = "helmet_attachment_description_visor_roundface",
		use_helmet_material_variations = false,
		hud_overlay_texture = "mockup_hud_visor_bascinet_roundface",
		type = "visor",
		unlock_key = 55,
		release_name = "main",
		ui_sort_index = 4,
		ui_header = "helmet_attachment_name_visor_roundface",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_bascinet/arm_wotr_helmet_bascinet_attachment_visor_roundface",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.visors.standard,
		meshes = {
			g_wotr_helmet_bascinet_roundface_lod0 = {
				"wotr_helmet_bascinet_roundface_metall_mat"
			},
			g_wotr_helmet_bascinet_roundface_lod0 = {
				"wotr_helmet_bascinet_roundface_metall_mat"
			},
			g_wotr_helmet_bascinet_roundface_lod0 = {
				"wotr_helmet_bascinet_roundface_metall_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_bascinet_roundface_lod0 = {
				"wotr_helmet_bascinet_roundface_metall_mat"
			},
			g_wotr_helmet_bascinet_roundface_lod0 = {
				"wotr_helmet_bascinet_roundface_metall_mat"
			},
			g_wotr_helmet_bascinet_roundface_lod0 = {
				"wotr_helmet_bascinet_roundface_metall_mat"
			}
		}
	},
	bascinet_visor_pigface = {
		ui_description = "helmet_attachment_description_visor_pigface",
		use_helmet_material_variations = true,
		hud_overlay_texture = "mockup_hud_visor_bascinet_pigface",
		type = "visor",
		unlock_key = 56,
		release_name = "main",
		ui_sort_index = 5,
		ui_header = "helmet_attachment_name_visor_pigface",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_bascinet/arm_wotr_helmet_bascinet_attachment_visor_pigface",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.visors.standard,
		meshes = {
			g_wotr_helmet_bascinet_pigface_lod0 = {
				"wotr_helmet_bascinet_metall_mat",
				"wotr_helmet_bascinet_metall_ds_mat"
			},
			g_wotr_helmet_bascinet_pigface_lod1 = {
				"wotr_helmet_bascinet_metall_mat",
				"wotr_helmet_bascinet_metall_ds_mat"
			},
			g_wotr_helmet_bascinet_pigface_lod2 = {
				"wotr_helmet_bascinet_metall_mat",
				"wotr_helmet_bascinet_metall_ds_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_bascinet_pigface_lod0 = {
				"wotr_helmet_bascinet_metall_mat",
				"wotr_helmet_bascinet_metall_ds_mat"
			},
			g_wotr_helmet_bascinet_pigface_lod1 = {
				"wotr_helmet_bascinet_metall_mat",
				"wotr_helmet_bascinet_metall_ds_mat"
			},
			g_wotr_helmet_bascinet_pigface_lod2 = {
				"wotr_helmet_bascinet_metall_mat",
				"wotr_helmet_bascinet_metall_ds_mat"
			}
		}
	},
	bascinet_visor_dogface = {
		ui_description = "helmet_attachment_description_visor_dogface",
		use_helmet_material_variations = false,
		hud_overlay_texture = "mockup_hud_visor_bascinet_dogface",
		type = "visor",
		unlock_key = 60,
		release_name = "hospitaller",
		ui_sort_index = 6,
		ui_header = "helmet_attachment_name_visor_dogface",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_bascinet/arm_wotr_helmet_bascinet_attachment_visor_dogface",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.visors.front,
		meshes = {
			g_wotr_helmet_bascinet_dogface_lod0 = {
				"wotr_helmet_bascinet_dogface_metall_mat"
			},
			g_wotr_helmet_bascinet_dogface_lod1 = {
				"wotr_helmet_bascinet_dogface_metall_mat"
			},
			g_wotr_helmet_bascinet_dogface_lod2 = {
				"wotr_helmet_bascinet_dogface_metall_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_bascinet_dogface_lod0 = {
				"wotr_helmet_bascinet_dogface_metall_mat"
			},
			g_wotr_helmet_bascinet_dogface_lod1 = {
				"wotr_helmet_bascinet_dogface_metall_mat"
			},
			g_wotr_helmet_bascinet_dogface_lod2 = {
				"wotr_helmet_bascinet_dogface_metall_mat"
			}
		}
	},
	bascinet_visor_dogface_holes = {
		ui_description = "helmet_attachment_description_visor_dogface_holes",
		use_helmet_material_variations = false,
		hud_overlay_texture = "mockup_hud_visor_bascinet_dogface_holes",
		type = "visor",
		unlock_key = 59,
		release_name = "hospitaller",
		ui_sort_index = 7,
		ui_header = "helmet_attachment_name_visor_dogface_holes",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_bascinet/arm_wotr_helmet_bascinet_attachment_visor_dogface_holes",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.visors.front,
		meshes = {
			g_wotr_helmet_bascinet_dogface_lod0 = {
				"wotr_helmet_bascinet_dogface_metall_mat1"
			},
			g_wotr_helmet_bascinet_dogface_lod1 = {
				"wotr_helmet_bascinet_dogface_metall_mat1"
			},
			g_wotr_helmet_bascinet_dogface_lod2 = {
				"wotr_helmet_bascinet_dogface_metall_mat1"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_bascinet_dogface_lod0 = {
				"wotr_helmet_bascinet_dogface_metall_mat1"
			},
			g_wotr_helmet_bascinet_dogface_lod1 = {
				"wotr_helmet_bascinet_dogface_metall_mat1"
			},
			g_wotr_helmet_bascinet_dogface_lod2 = {
				"wotr_helmet_bascinet_dogface_metall_mat1"
			}
		}
	},
	bascinet_visor_flatface = {
		ui_description = "helmet_attachment_description_visor_flatface",
		use_helmet_material_variations = false,
		hud_overlay_texture = "mockup_hud_visor_bascinet_flatface",
		type = "visor",
		unlock_key = 61,
		release_name = "hospitaller",
		ui_sort_index = 8,
		ui_header = "helmet_attachment_name_visor_flatface",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_bascinet/arm_wotr_helmet_bascinet_attachment_visor_flatface",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.visors.front,
		meshes = {
			g_wotr_helmet_bascinet_flatface_lod0 = {
				"wotr_helmet_bascinet_flatface_metall_mat"
			},
			g_wotr_helmet_bascinet_flatface_lod1 = {
				"wotr_helmet_bascinet_flatface_metall_mat"
			},
			g_wotr_helmet_bascinet_flatface_lod2 = {
				"wotr_helmet_bascinet_flatface_metall_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_bascinet_flatface_lod0 = {
				"wotr_helmet_bascinet_flatface_metall_mat"
			},
			g_wotr_helmet_bascinet_flatface_lod1 = {
				"wotr_helmet_bascinet_flatface_metall_mat"
			},
			g_wotr_helmet_bascinet_flatface_lod2 = {
				"wotr_helmet_bascinet_flatface_metall_mat"
			}
		}
	},
	bascinet_visor_pointyface = {
		ui_description = "helmet_attachment_description_visor_pointyface",
		use_helmet_material_variations = false,
		hud_overlay_texture = "mockup_hud_visor_bascinet_pointyface",
		type = "visor",
		unlock_key = 62,
		release_name = "hospitaller",
		ui_sort_index = 9,
		ui_header = "helmet_attachment_name_visor_pointyface",
		market_price = 3000,
		encumbrance = 1,
		unit = "units/armour/helmets/arm_wotr_helmet_bascinet/arm_wotr_helmet_bascinet_attachment_visor_pointyface",
		attachment_node_linking = AttachmentNodeLinking.helmet_attachments.visors.front,
		meshes = {
			g_wotr_helmet_bascinet_pointyface_lod0 = {
				"wotr_helmet_bascinet_pointyface_metall_mat"
			},
			g_wotr_helmet_bascinet_pointyface_lod1 = {
				"wotr_helmet_bascinet_pointyface_metall_mat"
			},
			g_wotr_helmet_bascinet_pointyface_lod2 = {
				"wotr_helmet_bascinet_pointyface_metall_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_bascinet_pointyface_lod0 = {
				"wotr_helmet_bascinet_pointyface_metall_mat"
			},
			g_wotr_helmet_bascinet_pointyface_lod1 = {
				"wotr_helmet_bascinet_pointyface_metall_mat"
			},
			g_wotr_helmet_bascinet_pointyface_lod2 = {
				"wotr_helmet_bascinet_pointyface_metall_mat"
			}
		}
	}
}
HelmetAttachments = {
	sallet = {
		visor_standard = HelmetVisors.sallet_visor_standard,
		bevor_01 = HelmetVisors.sallet_bevor_01,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		armorycap = HelmetCoifs.armorycap,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	bascinet = {
		visor_roundface = HelmetVisors.bascinet_visor_roundface,
		visor_pigface = HelmetVisors.bascinet_visor_pigface,
		visor_dogface = HelmetVisors.bascinet_visor_dogface,
		visor_dogface_holes = HelmetVisors.bascinet_visor_dogface_holes,
		visor_flatface = HelmetVisors.bascinet_visor_flatface,
		visor_pointyface = HelmetVisors.bascinet_visor_pointyface,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		armorycap = HelmetCoifs.armorycap,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		cloth_hood_tuckedin = HelmetCoifs.cloth_hood_tuckedin,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder_bascinet,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	armet = {
		bevor_01 = HelmetVisors.armet_bevor_01,
		armorycap = HelmetCoifs.armorycap,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			armorycap = HelmetCoifs.armorycap,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	light_peasant_cap = {
		feathers_one = HelmetFeathers.feathers_one,
		feathers_one_long = HelmetFeathers.feathers_one_long,
		feathers_two = HelmetFeathers.feathers_two,
		feathers_three = HelmetFeathers.feathers_three,
		feathers_single_6 = HelmetFeathers.feather_single_6,
		feathers_single_7 = HelmetFeathers.feather_single_7,
		feathers_three_2 = HelmetFeathers.feathers_three_2,
		feathers_group_1 = HelmetFeathers.feathers_group_1,
		feathers_group_2 = HelmetFeathers.feathers_group_2,
		feathers_group_3 = HelmetFeathers.feathers_group_3,
		feathers_group_4 = HelmetFeathers.feathers_group_4,
		feathers_group_5 = HelmetFeathers.feathers_group_5,
		default_unlocks = {}
	},
	light_leather_cap = {
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		armorycap = HelmetCoifs.armorycap,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		feathers_one = HelmetFeathers.feathers_one,
		feathers_one_long = HelmetFeathers.feathers_one_long,
		feathers_two = HelmetFeathers.feathers_two,
		feathers_three = HelmetFeathers.feathers_three,
		feathers_single_6 = HelmetFeathers.feather_single_6,
		feathers_single_7 = HelmetFeathers.feather_single_7,
		feathers_three_2 = HelmetFeathers.feathers_three_2,
		feathers_group_1 = HelmetFeathers.feathers_group_1,
		feathers_group_2 = HelmetFeathers.feathers_group_2,
		feathers_group_3 = HelmetFeathers.feathers_group_3,
		feathers_group_4 = HelmetFeathers.feathers_group_4,
		feathers_group_5 = HelmetFeathers.feathers_group_5,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01
		}
	},
	cloth_hat = {
		feathers_one = HelmetFeathers.feathers_one,
		feathers_one_long = HelmetFeathers.feathers_one_long,
		feathers_two = HelmetFeathers.feathers_two,
		feathers_three = HelmetFeathers.feathers_three,
		feathers_single_6 = HelmetFeathers.feather_single_6,
		feathers_single_7 = HelmetFeathers.feather_single_7,
		feathers_three_2 = HelmetFeathers.feathers_three_2,
		feathers_group_1 = HelmetFeathers.feathers_group_1,
		feathers_group_2 = HelmetFeathers.feathers_group_2,
		feathers_group_3 = HelmetFeathers.feathers_group_3,
		feathers_group_4 = HelmetFeathers.feathers_group_4,
		feathers_group_5 = HelmetFeathers.feathers_group_5,
		pattern_standard = ClothHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = ClothHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = ClothHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = ClothHelmetPatterns.pattern_polished,
		pattern_gilded = ClothHelmetPatterns.pattern_gilded,
		pattern_red_knight = ClothHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = ClothHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = ClothHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = ClothHelmetPatterns.pattern_brown_knight,
		pattern_red_details = ClothHelmetPatterns.pattern_red_details,
		pattern_red_and_green = ClothHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = ClothHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = ClothHelmetPatterns.pattern_green_and_black,
		default_unlocks = {
			pattern_standard = ClothHelmetPatterns.pattern_standard
		}
	},
	robin_hood_hat = {
		feathers_one = HelmetFeathers.feathers_one,
		feathers_one_long = HelmetFeathers.feathers_one_long,
		feathers_two = HelmetFeathers.feathers_two,
		feathers_single_6 = HelmetFeathers.feather_single_6,
		feathers_single_7 = HelmetFeathers.feather_single_7,
		feathers_three_2 = HelmetFeathers.feathers_three_2,
		pattern_standard = ClothHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = ClothHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = ClothHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = ClothHelmetPatterns.pattern_polished,
		pattern_gilded = ClothHelmetPatterns.pattern_gilded,
		pattern_red_knight = ClothHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = ClothHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = ClothHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = ClothHelmetPatterns.pattern_brown_knight,
		pattern_red_details = ClothHelmetPatterns.pattern_red_details,
		pattern_red_and_green = ClothHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = ClothHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = ClothHelmetPatterns.pattern_green_and_black,
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		default_unlocks = {
			pattern_standard = ClothHelmetPatterns.pattern_standard,
			mail_coif_01 = HelmetCoifs.mail_coif_01
		}
	},
	chaveron = {
		feathers_one = HelmetFeathers.feathers_one,
		feathers_one_long = HelmetFeathers.feathers_one_long,
		feathers_two = HelmetFeathers.feathers_two,
		feathers_three = HelmetFeathers.feathers_three,
		feathers_single_6 = HelmetFeathers.feather_single_6,
		feathers_single_7 = HelmetFeathers.feather_single_7,
		feathers_three_2 = HelmetFeathers.feathers_three_2,
		feathers_group_1 = HelmetFeathers.feathers_group_1,
		feathers_group_2 = HelmetFeathers.feathers_group_2,
		feathers_group_3 = HelmetFeathers.feathers_group_3,
		feathers_group_4 = HelmetFeathers.feathers_group_4,
		feathers_group_5 = HelmetFeathers.feathers_group_5,
		pattern_standard = ClothHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = ClothHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = ClothHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = ClothHelmetPatterns.pattern_polished,
		pattern_gilded = ClothHelmetPatterns.pattern_gilded,
		pattern_red_knight = ClothHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = ClothHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = ClothHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = ClothHelmetPatterns.pattern_brown_knight,
		pattern_red_details = ClothHelmetPatterns.pattern_red_details,
		pattern_red_and_green = ClothHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = ClothHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = ClothHelmetPatterns.pattern_green_and_black,
		default_unlocks = {
			pattern_standard = ClothHelmetPatterns.pattern_standard
		}
	},
	armorycap = {
		feathers_one = HelmetFeathers.feathers_one,
		feathers_one_long = HelmetFeathers.feathers_one_long,
		feathers_two = HelmetFeathers.feathers_two,
		feathers_three = HelmetFeathers.feathers_three,
		feathers_single_6 = HelmetFeathers.feather_single_6,
		feathers_single_7 = HelmetFeathers.feather_single_7,
		feathers_three_2 = HelmetFeathers.feathers_three_2,
		feathers_group_1 = HelmetFeathers.feathers_group_1,
		feathers_group_2 = HelmetFeathers.feathers_group_2,
		feathers_group_3 = HelmetFeathers.feathers_group_3,
		feathers_group_4 = HelmetFeathers.feathers_group_4,
		feathers_group_5 = HelmetFeathers.feathers_group_5,
		default_unlocks = {}
	},
	medium_kettlehat = {
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	kettlehelm_round = {
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	medium_mail_coif = {
		pattern_standard = MailcoifPatterns.pattern_standard,
		pattern_black = MailcoifPatterns.pattern_black,
		pattern_white = MailcoifPatterns.pattern_white,
		pattern_torned_black = MailcoifPatterns.pattern_torned_black,
		pattern_torned = MailcoifPatterns.pattern_torned,
		pattern_rust = MailcoifPatterns.pattern_rust,
		default_unlocks = {
			pattern_standard = MailcoifPatterns.pattern_standard
		}
	},
	medium_mail_coif_galloglass = {
		pattern_standard = MailcoifPatterns.pattern_standard,
		pattern_black = MailcoifPatterns.pattern_black,
		pattern_white = MailcoifPatterns.pattern_white,
		pattern_torned_black = MailcoifPatterns.pattern_torned_black,
		pattern_torned = MailcoifPatterns.pattern_torned,
		pattern_rust = MailcoifPatterns.pattern_rust,
		default_unlocks = {
			pattern_standard = MailcoifPatterns.pattern_standard
		}
	},
	cloth_hood = {
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		feathers_one = HelmetFeathers.feathers_one,
		feathers_one_long = HelmetFeathers.feathers_one_long,
		feathers_two = HelmetFeathers.feathers_two,
		feathers_three = HelmetFeathers.feathers_three,
		feathers_three_2 = HelmetFeathers.feathers_three_2,
		feathers_group_1 = HelmetFeathers.feathers_group_1,
		feathers_group_2 = HelmetFeathers.feathers_group_2,
		feathers_group_3 = HelmetFeathers.feathers_group_3,
		feathers_group_4 = HelmetFeathers.feathers_group_4,
		pattern_standard = ClothHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = ClothHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = ClothHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = ClothHelmetPatterns.pattern_polished,
		pattern_gilded = ClothHelmetPatterns.pattern_gilded,
		pattern_red_knight = ClothHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = ClothHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = ClothHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = ClothHelmetPatterns.pattern_brown_knight,
		pattern_red_details = ClothHelmetPatterns.pattern_red_details,
		pattern_red_and_green = ClothHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = ClothHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = ClothHelmetPatterns.pattern_green_and_black,
		default_unlocks = {
			pattern_standard = ClothHelmetPatterns.pattern_standard
		}
	},
	heavy_frogmouth = {
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	barbute = {
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		cloth_hood_tuckedin = HelmetCoifs.cloth_hood_tuckedin,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	barbute_y = {
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		cloth_hood_tuckedin = HelmetCoifs.cloth_hood_tuckedin,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	bear_helmet = {
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		cloth_hood_tuckedin = HelmetCoifs.cloth_hood_tuckedin,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_base = BearHelmetPatterns.pattern_base,
		pattern_base_red = BearHelmetPatterns.pattern_base_red,
		pattern_base_blue = BearHelmetPatterns.pattern_base_blue,
		pattern_base_green = BearHelmetPatterns.pattern_base_green,
		pattern_base_gray = BearHelmetPatterns.pattern_base_gray_square_rim,
		pattern_base_green = BearHelmetPatterns.pattern_base_green_square_rim,
		pattern_base_blue_white_trishape_rim = BearHelmetPatterns.pattern_base_blue_white_trishape_rim,
		pattern_base_red_green_trishape_rim = BearHelmetPatterns.pattern_base_red_green_trishape_rim,
		pattern_base_blooded = BearHelmetPatterns.pattern_base_blooded,
		pattern_base_red_light_fur = BearHelmetPatterns.pattern_base_red_light_fur,
		pattern_base_black_dark_fur = BearHelmetPatterns.pattern_base_black_dark_fur,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_base = BearHelmetPatterns.pattern_base
		}
	},
	kettlesallet = {
		bevor_01 = HelmetVisors.sallet_bevor_01,
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		cloth_hood_tuckedin = HelmetCoifs.cloth_hood_tuckedin,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	swiss = {
		bevor_01 = HelmetVisors.sallet_bevor_01,
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		cloth_hood_tuckedin = HelmetCoifs.cloth_hood_tuckedin,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	italian = {
		visor_roundface = HelmetVisors.bascinet_visor_roundface,
		visor_pigface = HelmetVisors.bascinet_visor_pigface,
		visor_dogface = HelmetVisors.bascinet_visor_dogface,
		visor_dogface_holes = HelmetVisors.bascinet_visor_dogface_holes,
		visor_flatface = HelmetVisors.bascinet_visor_flatface,
		visor_pointyface = HelmetVisors.bascinet_visor_pointyface,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder_bascinet,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	conventry_sallet = {
		bevor_01 = HelmetVisors.sallet_bevor_01,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			bevor_01 = HelmetVisors.sallet_bevor_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	great_helm = {
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		pattern_gilded = TournamentWinnerHelmetPatterns.pattern_gilded,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	},
	swiss_helmet = {
		armorycap = HelmetCoifs.armorycap,
		mail_coif_01 = HelmetCoifs.mail_coif_01,
		mail_coif_galloglass = HelmetCoifs.mail_coif_galloglass,
		cloth_hood_down = HelmetCoifs.cloth_hood_down,
		face_cloth_armoury_cap = HelmetCoifs.face_cloth_armoury_cap,
		plumes_one = HelmetPlumes.plumes_one,
		plumes_one_long = HelmetPlumes.plumes_one_long,
		plumes_two = HelmetPlumes.plumes_two,
		plumes_three = HelmetPlumes.plumes_three,
		plumes_three_2 = HelmetPlumes.plumes_three_2,
		plumes_group_1 = HelmetPlumes.plumes_group_1,
		plumes_group_2 = HelmetPlumes.plumes_group_2,
		plumes_group_3 = HelmetPlumes.plumes_group_3,
		plumes_group_4 = HelmetPlumes.plumes_group_4,
		pattern_standard = PlateHelmetPatterns.pattern_standard,
		pattern_red_and_black_preorder = PlateHelmetPatterns.pattern_red_and_black_preorder,
		pattern_white_and_blue_preorder = PlateHelmetPatterns.pattern_white_and_blue_preorder,
		pattern_polished = PlateHelmetPatterns.pattern_polished,
		pattern_blued = PlateHelmetPatterns.pattern_blued,
		pattern_gilded = PlateHelmetPatterns.pattern_gilded,
		pattern_red_knight = PlateHelmetPatterns.pattern_red_knight,
		pattern_black_and_blue = PlateHelmetPatterns.pattern_black_and_blue,
		pattern_black_as_knight = PlateHelmetPatterns.pattern_black_as_knight,
		pattern_brown_knight = PlateHelmetPatterns.pattern_brown_knight,
		pattern_red_details = PlateHelmetPatterns.pattern_red_details,
		pattern_red_and_green = PlateHelmetPatterns.pattern_red_and_green,
		pattern_red_and_black = PlateHelmetPatterns.pattern_red_and_black,
		pattern_green_and_black = PlateHelmetPatterns.pattern_green_and_black,
		pattern_orange_split = PlateHelmetPatterns.pattern_orange_split,
		default_unlocks = {
			mail_coif_01 = HelmetCoifs.mail_coif_01,
			pattern_standard = PlateHelmetPatterns.pattern_standard
		}
	}
}
Helmets = {
	helmet_light_peasant_cap = {
		ui_description = "helmet_description_light_peasant_cap",
		absorption_value = 0.05,
		encumbrance = 0.2,
		category = "light",
		ui_texture = "helmet_light_peasant_cap",
		ui_sort_index = 1,
		ui_fluff_text = "helmet_fluff_light_peasant_cap",
		armour_type = "armour_cloth",
		release_name = "main",
		ui_header = "helmet_name_light_peasant_cap",
		market_price = 3000,
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_peasant_cap/arm_wotr_helmet_peasant_cap",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.light_peasant_cap,
		default_unlocks = HelmetAttachments.light_peasant_cap.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		}
	},
	helmet_light_leather_cap = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.2,
		encumbrance = 2,
		market_price = 3000,
		ui_description = "helmet_description_light_leather_cap",
		ui_texture = "helmet_light_leather_cap",
		ui_fluff_text = "helmet_fluff_light_leather_cap",
		armour_type = "armour_leather",
		ui_sort_index = 2,
		ui_header = "helmet_name_light_leather_cap",
		release_name = "main",
		category = "light",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_leather_cap/arm_wotr_helmet_leather_cap",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.light_leather_cap,
		default_unlocks = HelmetAttachments.light_leather_cap.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		}
	},
	helmet_cloth_hat = {
		ui_description = "helmet_description_cloth_hat",
		absorption_value = 0.1,
		encumbrance = 1,
		category = "light",
		ui_texture = "helmet_cloth_hat",
		ui_sort_index = 3,
		ui_fluff_text = "helmet_fluff_cloth_hat",
		armour_type = "armour_cloth",
		release_name = "main",
		ui_header = "helmet_name_cloth_hat",
		market_price = 3000,
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_cloth_hat/arm_wotr_helmet_cloth_hat",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.cloth_hat,
		default_unlocks = HelmetAttachments.cloth_hat.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_cloth_hat_lod0 = {
				"wotr_helmet_cloth_hat_mat"
			},
			g_wotr_helmet_cloth_hat_lod1 = {
				"wotr_helmet_cloth_hat_mat"
			},
			g_wotr_helmet_cloth_hat_lod2 = {
				"wotr_helmet_cloth_hat_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_cloth_hat_lod0 = {
				"wotr_helmet_cloth_hat_mat"
			},
			g_wotr_helmet_cloth_hat_lod1 = {
				"wotr_helmet_cloth_hat_mat"
			},
			g_wotr_helmet_cloth_hat_lod2 = {
				"wotr_helmet_cloth_hat_mat"
			}
		}
	},
	helmet_chaveron = {
		ui_description = "helmet_towton_chaveron_description",
		absorption_value = 0.1,
		encumbrance = 1,
		category = "light",
		ui_texture = "helmet_chaveron",
		ui_sort_index = 3,
		ui_fluff_text = "helmet_towton_chaveron_fluff",
		armour_type = "armour_cloth",
		release_name = "winter",
		ui_header = "helmet_towton_chaveron_name",
		market_price = 50000,
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_chaveron/arm_wotr_helmet_chaveron",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.cloth_hat,
		default_unlocks = HelmetAttachments.cloth_hat.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_chaveron_lod0 = {
				"wotr_helmet_chaveron_mat"
			},
			g_wotr_helmet_chaveron_lod1 = {
				"wotr_helmet_chaveron_mat"
			},
			g_wotr_helmet_chaveron_lod2 = {
				"wotr_helmet_chaveron_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_chaveron_lod0 = {
				"wotr_helmet_chaveron_mat"
			},
			g_wotr_helmet_chaveron_lod1 = {
				"wotr_helmet_chaveron_mat"
			},
			g_wotr_helmet_chaveron_lod2 = {
				"wotr_helmet_chaveron_mat"
			}
		}
	},
	helmet_armorycap = {
		ui_description = "helmet_description_armorycap",
		absorption_value = 0.1,
		encumbrance = 1,
		category = "light",
		ui_texture = "helmet_armorycap",
		ui_sort_index = 4,
		ui_fluff_text = "helmet_fluff_armorycap",
		armour_type = "armour_cloth",
		release_name = "main",
		ui_header = "helmet_name_armorycap",
		market_price = 3000,
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_armorycap/arm_wotr_helmet_armorycap",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.armorycap,
		default_unlocks = HelmetAttachments.armorycap.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		}
	},
	helmet_cloth_hood = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.1,
		encumbrance = 1,
		market_price = 3000,
		ui_description = "helmet_description_cloth_hood",
		no_coif_allowed = true,
		ui_fluff_text = "helmet_fluff_cloth_hood",
		armour_type = "armour_cloth",
		ui_sort_index = 9,
		ui_header = "helmet_name_cloth_hood",
		no_decapitation = true,
		category = "light",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_cloth_hood/arm_wotr_helmet_cloth_hood",
		release_name = "main",
		ui_texture = "helmet_cloth_hood",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.cloth_hood,
		default_unlocks = HelmetAttachments.cloth_hood.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_cloth_hood_lod0 = {
				"wotr_helmet_cloth_hood_001_mat"
			},
			g_wotr_helmet_cloth_hood_lod1 = {
				"wotr_helmet_cloth_hood_001_mat"
			},
			g_wotr_helmet_cloth_hood_lod2 = {
				"wotr_helmet_cloth_hood_001_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_cloth_hood_lod0 = {
				"wotr_helmet_cloth_hood_001_mat"
			},
			g_wotr_helmet_cloth_hood_lod1 = {
				"wotr_helmet_cloth_hood_001_mat"
			},
			g_wotr_helmet_cloth_hood_lod2 = {
				"wotr_helmet_cloth_hood_001_mat"
			}
		}
	},
	helmet_robin_hood_hat = {
		ui_description = "gear_sherwood_helmet_robin_hood_hat_desc",
		absorption_value = 0.1,
		encumbrance = 1,
		category = "light",
		ui_texture = "helmet_robin_hood_hat",
		no_coif_allowed = true,
		ui_fluff_text = "gear_sherwood_helmet_robin_hood_hat_fluff",
		armour_type = "armour_cloth",
		no_decapitation = false,
		ui_header = "gear_sherwood_helmet_robin_hood_hat_name",
		ui_sort_index = 10,
		market_price = 15000,
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_robin_hood_hat/arm_wotr_helmet_robin_hood_hat",
		release_name = "sherwood",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.robin_hood_hat,
		default_unlocks = HelmetAttachments.robin_hood_hat.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_cloth_hood_lod0 = {
				"wotr_helmet_cloth_hood_001_mat"
			},
			g_wotr_helmet_cloth_hood_lod1 = {
				"wotr_helmet_cloth_hood_001_mat"
			},
			g_wotr_helmet_cloth_hood_lod2 = {
				"wotr_helmet_cloth_hood_001_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_cloth_hood_lod0 = {
				"wotr_helmet_cloth_hood_001_mat"
			},
			g_wotr_helmet_cloth_hood_lod1 = {
				"wotr_helmet_cloth_hood_001_mat"
			},
			g_wotr_helmet_cloth_hood_lod2 = {
				"wotr_helmet_cloth_hood_001_mat"
			}
		}
	},
	helmet_medium_kettlehat = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 3,
		market_price = 3000,
		ui_description = "helmet_description_medium_kettlehat",
		ui_texture = "helmet_medium_kettlehat",
		ui_fluff_text = "helmet_fluff_medium_kettlehat",
		armour_type = "armour_plate",
		ui_sort_index = 5,
		ui_header = "helmet_name_medium_kettlehat",
		release_name = "main",
		category = "medium",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_kettlehat/arm_wotr_helmet_kettlehat",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.medium_kettlehat,
		default_unlocks = HelmetAttachments.medium_kettlehat.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_kettlehat_lod0 = {
				"wotr_helmet_kettlehat_metal_mat"
			},
			g_wotr_helmet_kettlehat_lod1 = {
				"wotr_helmet_kettlehat_metal_mat"
			},
			g_wotr_helmet_kettlehat_lod2 = {
				"wotr_helmet_kettlehat_metal_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_kettlehat_lod0 = {
				"wotr_helmet_kettlehat_metal_mat"
			},
			g_wotr_helmet_kettlehat_lod1 = {
				"wotr_helmet_kettlehat_metal_mat"
			},
			g_wotr_helmet_kettlehat_lod2 = {
				"wotr_helmet_kettlehat_metal_mat"
			}
		}
	},
	helmet_kettlehelm_round = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 3,
		market_price = 3000,
		ui_description = "helmet_description_medium_kettlehelm_round",
		ui_texture = "helmet_kettlehelm_round",
		ui_fluff_text = "helmet_fluff_medium_kettlehelm_round",
		armour_type = "armour_plate",
		ui_sort_index = 6,
		ui_header = "helmet_name_medium_kettlehelm_round",
		release_name = "main",
		category = "medium",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_kettlehelm_round/arm_wotr_helmet_kettlehelm_round",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.kettlehelm_round,
		default_unlocks = HelmetAttachments.kettlehelm_round.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_kettlehelm_round_lod0 = {
				"wotr_helmet_kettlehelm_round_metal_mat"
			},
			g_wotr_helmet_kettlehelm_round_lod1 = {
				"wotr_helmet_kettlehelm_round_metal_mat"
			},
			g_wotr_helmet_kettlehelm_round_lod2 = {
				"wotr_helmet_kettlehelm_round_metal_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_kettlehelm_round_lod0 = {
				"wotr_helmet_kettlehelm_round_metal_mat"
			},
			g_wotr_helmet_kettlehelm_round_lod1 = {
				"wotr_helmet_kettlehelm_round_metal_mat"
			},
			g_wotr_helmet_kettlehelm_round_lod2 = {
				"wotr_helmet_kettlehelm_round_metal_mat"
			}
		}
	},
	helmet_medium_mail_coif = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.3,
		encumbrance = 3,
		ui_description = "helmet_description_medium_mail_coif",
		ui_texture = "helmet_medium_mail_coif",
		ui_sort_index = 7,
		ui_fluff_text = "helmet_fluff_medium_mail_coif",
		armour_type = "armour_mail",
		no_decapitation = true,
		ui_header = "helmet_name_medium_mail_coif",
		release_name = "main",
		category = "medium",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_mail_coif/arm_wotr_helmet_mail_coif",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.medium_mail_coif,
		default_unlocks = HelmetAttachments.medium_mail_coif.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_mail_coif_lod0 = {
				"wotr_helmet_mail_coif_001_mat"
			},
			g_wotr_helmet_mail_coif_lod1 = {
				"wotr_helmet_mail_coif_001_mat"
			},
			g_wotr_helmet_mail_coif_lod2 = {
				"wotr_helmet_mail_coif_001_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_mail_coif_lod0 = {
				"wotr_helmet_mail_coif_001_mat"
			},
			g_wotr_helmet_mail_coif_lod1 = {
				"wotr_helmet_mail_coif_001_mat"
			},
			g_wotr_helmet_mail_coif_lod2 = {
				"wotr_helmet_mail_coif_001_mat"
			}
		}
	},
	helmet_medium_mail_coif_galloglass = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.3,
		encumbrance = 3,
		market_price = 20000,
		ui_description = "helmet_galloglass_medium_mail_coif_description",
		ui_texture = "helmet_gallowglass_mail",
		ui_fluff_text = "helmet_galloglass_medium_mail_coif_fluff",
		armour_type = "armour_mail",
		ui_sort_index = 8,
		ui_header = "helmet_galloglass_medium_mail_coif_name",
		no_decapitation = true,
		category = "medium",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_mail_coif_galloglass/arm_wotr_helmet_mail_coif_galloglass",
		release_name = "scottish",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.medium_mail_coif,
		default_unlocks = HelmetAttachments.medium_mail_coif.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_mail_coif_galloglass_lod0 = {
				"wotr_helmet_mail_coif_galloglass_mat"
			},
			g_wotr_helmet_mail_coif_galloglass_lod1 = {
				"wotr_helmet_mail_coif_galloglass_mat"
			},
			g_wotr_helmet_mail_coif_galloglass_lod2 = {
				"wotr_helmet_mail_coif_galloglass_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_mail_coif_galloglass_lod0 = {
				"wotr_helmet_mail_coif_galloglass_mat"
			},
			g_wotr_helmet_mail_coif_galloglass_lod1 = {
				"wotr_helmet_mail_coif_galloglass_mat"
			},
			g_wotr_helmet_mail_coif_galloglass_lod2 = {
				"wotr_helmet_mail_coif_galloglass_mat"
			}
		}
	},
	helmet_sallet = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 6,
		market_price = 3000,
		ui_description = "helmet_description_sallet",
		ui_texture = "helmet_sallet",
		ui_fluff_text = "helmet_fluff_sallet",
		armour_type = "armour_plate",
		ui_sort_index = 11,
		ui_header = "helmet_name_sallet",
		release_name = "main",
		category = "medium",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_sallet/arm_wotr_helmet_sallet",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.sallet,
		default_unlocks = HelmetAttachments.sallet.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_sallet_lod0 = {
				"wotr_helmet_heavy_002_mat"
			},
			g_wotr_helmet_sallet_lod1 = {
				"wotr_helmet_heavy_002_mat"
			},
			g_wotr_helmet_sallet_lod2 = {
				"wotr_helmet_heavy_002_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_sallet_lod0 = {
				"wotr_helmet_heavy_002_mat"
			},
			g_wotr_helmet_sallet_lod1 = {
				"wotr_helmet_heavy_002_mat"
			},
			g_wotr_helmet_sallet_lod2 = {
				"wotr_helmet_heavy_002_mat"
			}
		}
	},
	helmet_bascinet = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.5,
		encumbrance = 6,
		market_price = 3000,
		ui_description = "helmet_description_bascinet",
		ui_texture = "helmet_bascinet",
		ui_fluff_text = "helmet_fluff_bascinet",
		armour_type = "armour_plate",
		ui_sort_index = 12,
		ui_header = "helmet_name_bascinet",
		release_name = "main",
		category = "heavy",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_bascinet/arm_wotr_helmet_bascinet",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.bascinet,
		default_unlocks = HelmetAttachments.bascinet.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_bascinet_lod0 = {
				"wotr_helmet_bascinet_metall_mat"
			},
			g_wotr_helmet_bascinet_lod1 = {
				"wotr_helmet_bascinet_metall_mat"
			},
			g_wotr_helmet_bascinet_lod2 = {
				"wotr_helmet_bascinet_metall_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_bascinet_lod0 = {
				"wotr_helmet_bascinet_metall_mat"
			},
			g_wotr_helmet_bascinet_lod1 = {
				"wotr_helmet_bascinet_metall_mat"
			},
			g_wotr_helmet_bascinet_lod2 = {
				"wotr_helmet_bascinet_metall_mat"
			}
		}
	},
	helmet_barbute = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 8,
		market_price = 3000,
		ui_description = "helmet_description_barbute",
		ui_texture = "helmet_barbute",
		ui_fluff_text = "helmet_fluff_barbute",
		armour_type = "armour_plate",
		ui_sort_index = 13,
		ui_header = "helmet_name_barbute",
		release_name = "main",
		category = "heavy",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_barbute/arm_wotr_helmet_barbute",
		built_in_overlay = "mockup_hud_visor_barbute_standard",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.barbute,
		default_unlocks = HelmetAttachments.barbute.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_barbute_lod0 = {
				"wotr_helmet_barbute_mat"
			},
			g_wotr_helmet_barbute_lod1 = {
				"wotr_helmet_barbute_mat"
			},
			g_wotr_helmet_barbute_lod2 = {
				"wotr_helmet_barbute_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_barbute_lod0 = {
				"wotr_helmet_barbute_mat"
			},
			g_wotr_helmet_barbute_lod1 = {
				"wotr_helmet_barbute_mat"
			},
			g_wotr_helmet_barbute_lod2 = {
				"wotr_helmet_barbute_mat"
			}
		}
	},
	helmet_barbute_y = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 8,
		market_price = 3000,
		ui_description = "helmet_description_barbute_y",
		ui_texture = "helmet_barbute_y",
		ui_fluff_text = "helmet_fluff_barbute_y",
		armour_type = "armour_plate",
		ui_sort_index = 14,
		ui_header = "helmet_name_barbute_y",
		release_name = "hospitaller",
		category = "heavy",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_barbute_y/arm_wotr_helmet_barbute_y",
		built_in_overlay = "mockup_hud_visor_barbute_y_standard",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.barbute_y,
		default_unlocks = HelmetAttachments.barbute_y.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_barbute_y_lod0 = {
				"wotr_helmet_barbute_y_mat"
			},
			g_wotr_helmet_barbute_y_lod1 = {
				"wotr_helmet_barbute_y_mat"
			},
			g_wotr_helmet_barbute_y_lod2 = {
				"wotr_helmet_barbute_y_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_barbute_y_lod0 = {
				"wotr_helmet_barbute_y_mat"
			},
			g_wotr_helmet_barbute_y_lod1 = {
				"wotr_helmet_barbute_y_mat"
			},
			g_wotr_helmet_barbute_y_lod2 = {
				"wotr_helmet_barbute_y_mat"
			}
		}
	},
	helmet_bear_helmet = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 6,
		market_price = 500000,
		ui_description = "helmet_towton_bear_helmet_description",
		ui_texture = "helmet_bear_helmet",
		ui_fluff_text = "helmet_towton_bear_helmet_fluff",
		armour_type = "armour_plate",
		ui_sort_index = 15,
		ui_header = "helmet_towton_bear_helmet_name",
		release_name = "winter",
		category = "medium",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_bear_helmet/arm_wotr_helmet_bear_helmet",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.bear_helmet,
		default_unlocks = HelmetAttachments.bear_helmet.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_bear_helmet_lod0 = {
				"chr_wotr_helmet_bear_helmet_mat",
				"chr_wotr_helmet_bear_helmet_fur_mat",
				"chr_wotr_helmet_bear_helmet_fur_ds_mat",
				"chr_wotr_helmet_bear_helmet_cloth_mat"
			},
			g_wotr_helmet_bear_helmet_lod1 = {
				"chr_wotr_helmet_bear_helmet_mat",
				"chr_wotr_helmet_bear_helmet_fur_mat",
				"chr_wotr_helmet_bear_helmet_fur_ds_mat",
				"chr_wotr_helmet_bear_helmet_cloth_mat"
			},
			g_wotr_helmet_bear_helmet_lod2 = {
				"chr_wotr_helmet_bear_helmet_mat",
				"chr_wotr_helmet_bear_helmet_fur_mat",
				"chr_wotr_helmet_bear_helmet_fur_ds_mat",
				"chr_wotr_helmet_bear_helmet_cloth_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_bear_helmet_lod0 = {
				"chr_wotr_helmet_bear_helmet_mat",
				"chr_wotr_helmet_bear_helmet_fur_mat",
				"chr_wotr_helmet_bear_helmet_fur_ds_mat",
				"chr_wotr_helmet_bear_helmet_cloth_mat"
			},
			g_wotr_helmet_bear_helmet_lod1 = {
				"chr_wotr_helmet_bear_helmet_mat",
				"chr_wotr_helmet_bear_helmet_fur_mat",
				"chr_wotr_helmet_bear_helmet_fur_ds_mat",
				"chr_wotr_helmet_bear_helmet_cloth_mat"
			},
			g_wotr_helmet_bear_helmet_lod2 = {
				"chr_wotr_helmet_bear_helmet_mat",
				"chr_wotr_helmet_bear_helmet_fur_mat",
				"chr_wotr_helmet_bear_helmet_fur_ds_mat",
				"chr_wotr_helmet_bear_helmet_cloth_mat"
			}
		}
	},
	helmet_kettlesallet = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 9,
		market_price = 50000,
		ui_description = "gear_burgundy_helmet_kettlesallet_description",
		ui_texture = "helmet_kettlesallet",
		ui_fluff_text = "gear_burgundy_helmet_kettlesallet_fluff",
		armour_type = "armour_plate",
		ui_sort_index = 16,
		ui_header = "gear_burgundy_helmet_kettlesallet_name",
		release_name = "burgundy",
		category = "medium",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_kettlesallet/arm_wotr_helmet_kettlesallet",
		built_in_overlay = "mockup_hud_visor_kettle_sallet_standard",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.kettlesallet,
		default_unlocks = HelmetAttachments.kettlesallet.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_kettlesallet_lod0 = {
				"wotr_helmet_kettlesallet_mat"
			},
			g_wotr_helmet_kettlesallet_lod1 = {
				"wotr_helmet_kettlesallet_mat"
			},
			g_wotr_helmet_kettlesallet_lod2 = {
				"wotr_helmet_kettlesallet_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_kettlesallet_lod0 = {
				"wotr_helmet_kettlesallet_mat"
			},
			g_wotr_helmet_kettlesallet_lod1 = {
				"wotr_helmet_kettlesallet_mat"
			},
			g_wotr_helmet_kettlesallet_lod2 = {
				"wotr_helmet_kettlesallet_mat"
			}
		}
	},
	helmet_italian = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 4,
		market_price = 500000,
		ui_description = "gear_italian_helmet_bascinet_desc",
		ui_texture = "helmet_italian",
		ui_fluff_text = "gear_italian_helmet_bascinet_fluff",
		armour_type = "armour_plate",
		no_decapitation = true,
		ui_header = "gear_italian_helmet_bascinet_name",
		ui_sort_index = 30,
		category = "heavy",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_italian/arm_wotr_helmet_italian",
		release_name = "italian",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.italian,
		default_unlocks = HelmetAttachments.italian.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_leather_cap_lod0 = {
				"wotr_helmet_leathercap_leather_mat",
				"wotr_helmet_leathercap_metall_mat"
			},
			g_wotr_helmet_leather_cap_lod1 = {
				"wotr_helmet_leathercap_leather_mat",
				"wotr_helmet_leathercap_metall_mat"
			},
			g_wotr_helmet_leather_cap_lod2 = {
				"wotr_helmet_leathercap_leather_mat",
				"wotr_helmet_leathercap_metall_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_leather_cap_lod0 = {
				"wotr_helmet_leathercap_leather_mat",
				"wotr_helmet_leathercap_metall_mat"
			},
			g_wotr_helmet_leather_cap_lod1 = {
				"wotr_helmet_leathercap_leather_mat",
				"wotr_helmet_leathercap_metall_mat"
			},
			g_wotr_helmet_leather_cap_lod2 = {
				"wotr_helmet_leathercap_leather_mat",
				"wotr_helmet_leathercap_metall_mat"
			}
		}
	},
	helmet_heavy_frogmouth = {
		hide_head_visibility_group = "head_all",
		ui_texture = "helmet_heavy_frogmouth",
		penetration_value = 15,
		ui_sort_index = 10,
		release_name = "main",
		armour_type = "armour_plate",
		market_price = 3000,
		encumbrance = 12,
		unit = "units/armour/helmets/arm_wotr_helmet_frogsmouth/arm_wotr_helmet_frogsmouth",
		built_in_overlay = "mockup_hud_visor_frogmouth_standard",
		ui_description = "helmet_description_heavy_frogmouth",
		absorption_value = 0.6,
		ui_fluff_text = "helmet_fluff_heavy_frogmouth",
		no_decapitation = true,
		ui_header = "helmet_name_heavy_frogmouth",
		has_crest = true,
		category = "heavy",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.heavy_frogmouth,
		default_unlocks = HelmetAttachments.heavy_frogmouth.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_frogmouth_lod0 = {
				"wotr_helmet_frogmouth_mat"
			},
			g_wotr_helmet_frogmouth_lod1 = {
				"wotr_helmet_frogmouth_mat"
			},
			g_wotr_helmet_frogmouth_lod2 = {
				"wotr_helmet_frogmouth_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_frogmouth_lod0 = {
				"wotr_helmet_frogmouth_mat"
			},
			g_wotr_helmet_frogmouth_lod1 = {
				"wotr_helmet_frogmouth_mat"
			},
			g_wotr_helmet_frogmouth_lod2 = {
				"wotr_helmet_frogmouth_mat"
			}
		}
	},
	helmet_armet = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		penetration_value = 15,
		category = "heavy",
		ui_description = "helmet_description_armet",
		built_in_visor = "mockup_hud_visor_armet_standard",
		ui_fluff_text = "helmet_fluff_armet",
		armour_type = "armour_plate",
		ui_sort_index = 17,
		ui_header = "helmet_name_armet",
		has_crest = true,
		market_price = 3000,
		encumbrance = 12,
		unit = "units/armour/helmets/arm_wotr_helmet_armet/arm_wotr_helmet_armet",
		ui_texture = "helmet_armet",
		release_name = "main",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.armet,
		default_unlocks = HelmetAttachments.armet.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_armet_lod0 = {
				"wotr_helmet_armet_metal_mat"
			},
			g_wotr_helmet_armet_lod1 = {
				"wotr_helmet_armet_metal_mat"
			},
			g_wotr_helmet_armet_lod2 = {
				"wotr_helmet_armet_metal_mat"
			},
			g_wotr_helmet_armet_visor_lod0 = {
				"wotr_helmet_armet_metal_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_armet_lod0 = {
				"wotr_helmet_armet_metal_mat"
			},
			g_wotr_helmet_armet_lod1 = {
				"wotr_helmet_armet_metal_mat"
			},
			g_wotr_helmet_armet_lod2 = {
				"wotr_helmet_armet_metal_mat"
			},
			g_wotr_helmet_armet_visor_lod0 = {
				"wotr_helmet_armet_metal_mat"
			}
		}
	},
	helmet_great_helm = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		penetration_value = 15,
		ui_description = "helmet_description_great_helm",
		ui_texture = "helmet_armet",
		ui_sort_index = 4711,
		armour_type = "armour_plate",
		hide_if_unavailable = true,
		ui_header = "helmet_name_great_helm",
		has_crest = true,
		category = "heavy",
		encumbrance = 12,
		unit = "units/armour/helmets/arm_wotr_helmet_great_helm/arm_wotr_helmet_great_helm",
		built_in_overlay = "mockup_hud_visor_frogmouth_standard",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.great_helm,
		default_unlocks = HelmetAttachments.great_helm.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_great_helm_lod0 = {
				"wotr_helmet_great_helm_metall_mat",
				"wotr_helmet_great_helm_metall_ds_mat"
			},
			g_wotr_helmet_great_helm_lod1 = {
				"wotr_helmet_great_helm_metall_mat",
				"wotr_helmet_great_helm_metall_ds_mat"
			},
			g_wotr_helmet_great_helm_lod2 = {
				"wotr_helmet_great_helm_metall_mat",
				"wotr_helmet_great_helm_metall_ds_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_great_helm_lod0 = {
				"wotr_helmet_great_helm_metall_mat",
				"wotr_helmet_great_helm_metall_ds_mat"
			},
			g_wotr_helmet_great_helm_lod1 = {
				"wotr_helmet_great_helm_metall_mat",
				"wotr_helmet_great_helm_metall_ds_mat"
			},
			g_wotr_helmet_great_helm_lod2 = {
				"wotr_helmet_great_helm_metall_mat",
				"wotr_helmet_great_helm_metall_ds_mat"
			}
		}
	},
	helmet_swiss = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 9,
		market_price = 50000,
		ui_description = "gear_swiss_bunhead_helmet_desc",
		ui_texture = "helmet_swiss",
		ui_fluff_text = "gear_swiss_bunhead_helmet_fluff",
		armour_type = "armour_plate",
		ui_sort_index = 17,
		ui_header = "gear_swiss_bunhead_helmet_name",
		release_name = "swiss",
		category = "medium",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_swiss/arm_wotr_helmet_swiss",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.swiss,
		default_unlocks = HelmetAttachments.swiss.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_kettlesallet_lod0 = {
				"wotr_helmet_kettlesallet_mat"
			},
			g_wotr_helmet_kettlesallet_lod1 = {
				"wotr_helmet_kettlesallet_mat"
			},
			g_wotr_helmet_kettlesallet_lod2 = {
				"wotr_helmet_kettlesallet_mat"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_kettlesallet_lod0 = {
				"wotr_helmet_kettlesallet_mat"
			},
			g_wotr_helmet_kettlesallet_lod1 = {
				"wotr_helmet_kettlesallet_mat"
			},
			g_wotr_helmet_kettlesallet_lod2 = {
				"wotr_helmet_kettlesallet_mat"
			}
		}
	},
	helmet_conventry_sallet = {
		hide_head_visibility_group = "head_top",
		absorption_value = 0.6,
		encumbrance = 9,
		market_price = 500000,
		ui_description = "gear_conventry_sallet_helmet_desc",
		ui_texture = "helmet_conventry_sallet",
		ui_fluff_text = "gear_conventry_sallet_helmet_fluff",
		armour_type = "armour_plate",
		ui_sort_index = 18,
		ui_header = "gear_conventry_sallet_helmet_name",
		release_name = "ripwotr",
		category = "heavy",
		penetration_value = 15,
		unit = "units/armour/helmets/arm_wotr_helmet_conventry_sallet/arm_wotr_helmet_conventry_sallet",
		built_in_overlay = "mockup_hud_visor_kettle_sallet_standard",
		attachment_node_linking = AttachmentNodeLinking.helmets.standard,
		attachments = HelmetAttachments.conventry_sallet,
		default_unlocks = HelmetAttachments.conventry_sallet.default_unlocks,
		ui_unit = {
			rotation = {
				{
					y = -90
				},
				{
					x = -85
				},
				{
					y = -15
				}
			},
			camera_position = Vector3Box(0, 0.4, 0.7)
		},
		meshes = {
			g_wotr_helmet_lod0 = {
				"m_iron"
			},
			g_wotr_helmet_lod1 = {
				"m_iron"
			},
			g_wotr_helmet_lod2 = {
				"m_iron"
			}
		},
		preview_unit_meshes = {
			g_wotr_helmet_lod0 = {
				"m_iron"
			},
			g_wotr_helmet_lod1 = {
				"m_iron"
			},
			g_wotr_helmet_lod2 = {
				"m_iron"
			}
		}
	}
}

local unlock_keys = {}

local function check_unlock_keys(helmet_table)
	for _, props in pairs(helmet_table) do
		fassert(unlock_keys[props.unlock_key] == nil, "Duplicate unlock key found for %d", props.unlock_key)

		unlock_keys[props.unlock_key] = true
	end
end

check_unlock_keys(HelmetCoifs)
check_unlock_keys(HelmetPlumes)
check_unlock_keys(HelmetFeathers)
check_unlock_keys(PlateHelmetPatterns)
check_unlock_keys(ClothHelmetPatterns)
check_unlock_keys(HelmetVisors)

unlock_keys = nil

function default_helmet_attachment_unlocks()
	local default_unlocks = {}

	for helmet_name, props in pairs(Helmets) do
		fassert(props.default_unlocks, "No default unlocks found for helmet %q", helmet_name)

		for attachment_name, attachment in pairs(props.default_unlocks) do
			local entity_type = "helmet_attachment"
			local entity_name = helmet_name .. "|" .. attachment.unlock_key

			default_unlocks[entity_type .. "|" .. entity_name] = {
				category = entity_type,
				name = entity_name,
				attachment = attachment
			}
		end

		for attachment_name, attachment in pairs(props.attachments) do
			if attachment_name ~= "default_unlocks" and attachment.required_dlc then
				local entity_type = "helmet_attachment"
				local entity_name = helmet_name .. "|" .. attachment.unlock_key

				default_unlocks[entity_type .. "|" .. entity_name] = {
					category = entity_type,
					name = entity_name,
					attachment = attachment
				}
			end
		end
	end

	return default_unlocks
end
