-- chunkname: @scripts/settings/attachment_node_linking.lua

AttachmentNodeLinking = {
	one_handed_weapon = {
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_right_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_hips_left"
				}
			}
		},
		sword_bastard = {
			wielded = {
				{
					target = 0,
					source = "a_right_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_hips_left"
				}
			}
		}
	},
	two_handed_weapon = {
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_right_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_back_right"
				}
			}
		}
	},
	dagger = {
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_right_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_hips_right"
				}
			}
		}
	},
	lance = {
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_right_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_back_right"
				}
			}
		}
	},
	polearm = {
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_right_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_back_polearm"
				}
			}
		}
	},
	bow = {
		noanim = {
			wielded = {
				{
					target = 0,
					source = "a_left_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_back_bow"
				}
			}
		},
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_left_hand"
				},
				{
					target = "weap_root",
					source = "a_left_weap_1"
				},
				{
					target = "weap_1",
					source = "a_left_weap_2"
				},
				{
					target = "weap_2",
					source = "a_left_weap_3"
				},
				{
					target = "weap_3",
					source = "a_left_weap_4"
				},
				{
					target = "weap_4",
					source = "a_left_weap_5"
				},
				{
					target = "weap_5",
					source = "a_left_weap_6"
				},
				{
					target = "weap_6",
					source = "a_left_weap_7"
				},
				{
					target = "weap_7",
					source = "a_left_weap_8"
				},
				{
					target = "weap_8",
					source = "a_left_weap_9"
				},
				{
					target = "weap_9",
					source = "a_left_weap_10"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_back_bow"
				}
			}
		}
	},
	crossbow = {
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_left_hand"
				},
				{
					target = "wpn_1",
					source = "a_left_weap_1"
				},
				{
					target = "wpn_2",
					source = "a_left_weap_2"
				},
				{
					target = "wpn_3",
					source = "a_left_weap_3"
				},
				{
					target = "wpn_4",
					source = "a_left_weap_4"
				},
				{
					target = "wpn_5",
					source = "a_left_weap_5"
				},
				{
					target = "wpn_6",
					source = "a_left_weap_6"
				},
				{
					target = "wpn_7",
					source = "a_left_weap_7"
				},
				{
					target = "wpn_8",
					source = "a_left_weap_8"
				},
				{
					target = "wpn_9",
					source = "a_left_weap_9"
				},
				{
					target = "wpn_10",
					source = "a_left_weap_10"
				},
				{
					target = "wpn_11",
					source = "a_left_weap_11"
				},
				{
					target = "wpn_12",
					source = "a_left_weap_12"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_back_crossbow"
				}
			}
		}
	},
	handgonne = {
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_left_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_back_handgonne"
				}
			}
		}
	},
	shield = {
		standard = {
			wielded = {
				{
					target = 0,
					source = "a_left_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_back_left"
				}
			}
		},
		buckler = {
			wielded = {
				{
					target = 0,
					source = "a_left_hand"
				}
			},
			unwielded = {
				{
					target = 0,
					source = "a_hips_targe"
				}
			}
		}
	},
	helmets = {
		standard = {
			{
				target = 0,
				source = "Spine1"
			},
			{
				target = "Spine2",
				source = "Spine2"
			},
			{
				target = "Neck",
				source = "Neck"
			},
			{
				target = "Head",
				source = "Head"
			},
			{
				target = "LeftShoulder",
				source = "LeftShoulder"
			},
			{
				target = "LeftArm",
				source = "LeftArm"
			},
			{
				target = "LeftArmRoll",
				source = "LeftArmRoll"
			},
			{
				target = "RightShoulder",
				source = "RightShoulder"
			},
			{
				target = "RightArm",
				source = "RightArm"
			},
			{
				target = "RightArmRoll",
				source = "RightArmRoll"
			}
		},
		coat_of_arms = {
			{
				target = 0,
				source = "Spine1"
			},
			{
				target = "Spine2",
				source = "Spine2"
			},
			{
				target = "Neck",
				source = "Neck"
			},
			{
				target = "Head",
				source = "Head"
			}
		}
	},
	helmet_attachments = {
		visors = {
			standard = {
				{
					target = 0,
					source = "Visor"
				}
			},
			front = {
				{
					target = 0,
					source = "Head"
				},
				{
					target = "Visor_front",
					source = "Visor_front"
				}
			}
		},
		bevors = {
			standard = {
				{
					target = 0,
					source = "Spine2"
				}
			},
			armet = {
				{
					target = 0,
					source = 0
				},
				{
					target = "Spine2",
					source = "Spine2"
				},
				{
					target = "Neck",
					source = "Neck"
				},
				{
					target = "Head",
					source = "Head"
				}
			}
		},
		coifs = {
			standard = {
				{
					target = 0,
					source = 0
				},
				{
					target = "Spine2",
					source = "Spine2"
				},
				{
					target = "Neck",
					source = "Neck"
				},
				{
					target = "Head",
					source = "Head"
				},
				{
					target = "LeftShoulder",
					source = "LeftShoulder"
				},
				{
					target = "LeftArm",
					source = "LeftArm"
				},
				{
					target = "LeftArmRoll",
					source = "LeftArmRoll"
				},
				{
					target = "RightShoulder",
					source = "RightShoulder"
				},
				{
					target = "RightArm",
					source = "RightArm"
				},
				{
					target = "RightArmRoll",
					source = "RightArmRoll"
				}
			}
		},
		crests = {
			standard = {
				{
					target = 0,
					source = "a_crest"
				}
			}
		},
		plumes = {
			standard = {
				{
					target = 0,
					source = "a_plumes"
				}
			}
		},
		feathers = {
			standard = {
				{
					target = 0,
					source = "a_feather"
				}
			}
		}
	},
	heads = {
		standard = {
			{
				target = 0,
				source = "a_head"
			},
			{
				target = "Spine2",
				source = "Spine2"
			},
			{
				target = "Neck",
				source = "Neck"
			},
			{
				target = "Head",
				source = "Head"
			}
		}
	},
	quivers = {
		bow = {
			{
				target = 0,
				source = "a_quiver_back"
			}
		},
		crossbow = {
			{
				target = 0,
				source = "a_crossbow_quiver"
			}
		}
	}
}
