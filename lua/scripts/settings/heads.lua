-- chunkname: @scripts/settings/heads.lua

require("scripts/settings/attachment_node_linking")

Voices = {
	commoner = {},
	noble = {},
	brian_blessed_commoner = {
		required_dlc = DLCSettings.brian_blessed()
	},
	brian_blessed_noble = {
		required_dlc = DLCSettings.brian_blessed()
	}
}
HeadMaterials = {
	knight = {
		material_name = "units/beings/chr_wotr_heads/chr_wotr_head_01/chr_wotr_head_01",
		ui_name = "menu_knight"
	},
	peasant = {
		material_name = "units/beings/chr_wotr_heads/chr_wotr_head_02/chr_wotr_head_02",
		ui_name = "menu_peasant"
	},
	squire = {
		material_name = "units/beings/chr_wotr_heads/chr_wotr_head_03/chr_wotr_head_03",
		ui_name = "menu_squire"
	},
	lady = {
		material_name = "units/beings/chr_wotr_heads/chr_wotr_head_04/chr_wotr_head_04",
		ui_name = "menu_lady"
	}
}
Heads = {
	knight = {
		husk_voice = "noble_husk",
		unit = "units/beings/chr_wotr_heads/chr_wotr_head_01/chr_wotr_head_01",
		ui_name = "menu_knight",
		voice = "noble",
		attachment_node_linking = AttachmentNodeLinking.heads.standard,
		material_variations = {
			"knight"
		}
	},
	peasant = {
		husk_voice = "commoner_husk",
		unit = "units/beings/chr_wotr_heads/chr_wotr_head_02/chr_wotr_head_02",
		ui_name = "menu_peasant",
		voice = "commoner",
		attachment_node_linking = AttachmentNodeLinking.heads.standard,
		material_variations = {
			"peasant",
			"squire",
			"lady"
		}
	},
	squire = {
		husk_voice = "commoner_husk",
		unit = "units/beings/chr_wotr_heads/chr_wotr_head_03/chr_wotr_head_03",
		ui_name = "menu_squire",
		voice = "commoner",
		attachment_node_linking = AttachmentNodeLinking.heads.standard,
		material_variations = {
			"squire",
			"peasant",
			"lady"
		}
	},
	lady = {
		husk_voice = "commoner_husk",
		unit = "units/beings/chr_wotr_heads/chr_wotr_head_04/chr_wotr_head_04",
		ui_name = "menu_lady",
		voice = "commoner",
		attachment_node_linking = AttachmentNodeLinking.heads.standard,
		material_variations = {
			"lady",
			"peasant",
			"squire"
		}
	}
}
