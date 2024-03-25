-- chunkname: @scripts/settings/execution_definitions.lua

ExecutionDefinitions = ExecutionDefinitions or {}
ExecutionDefinitions.sword_omni = {
	victim_camera = "victim_execution_camera",
	attacker_camera = "attacker_execution_camera",
	victim_anim_event = "execute_victim_sword_omni",
	attacker_anim_event = "execute_attacker_sword_omni",
	attacker_position_offset = Vector3Box(-0.662, -0.1, 0),
	attacker_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/attacker/onground_execute_2h",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	victim_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/victim/onground_execute_2h",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov",
			"fade_to_black"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	attacker_events = {
		anim_cb_execute_attacker_exit1 = {
			{
				node = "fx_aux_01",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_execution_weapon_drip"
				}
			}
		},
		sfx_execute_husk_start = {
			{
				event = "execution_sword_omni_2h_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_husk_vce",
				node = "a_head",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_husk_end = {
			{
				event = "stop_execution_sword_omni_2h_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_husk_vce",
				node = "a_head",
				type = "sound"
			}
		},
		sfx_execute_player_start = {
			{
				event = "execution_sword_omni_2h_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_player_vce",
				node = "root_point",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_sword_omni_2h_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	},
	victim_events = {
		anim_cb_execute_victim_mouth = {
			{
				node = "fx_aux_05",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_mouth"
				}
			}
		},
		anim_cb_execute_victim_entry1 = {
			{
				node = "fx_aux_01",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_directional"
				}
			},
			{
				event = "wield_sword",
				node = "a_head",
				armour_location = "head",
				type = "sound"
			}
		},
		sfx_execute_player_start = {
			{
				event = "execution_sword_omni_2h_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_player_vce",
				node = "root_point",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_sword_omni_2h_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	}
}
ExecutionDefinitions.dagger = {
	victim_camera = "victim_execution_camera",
	attacker_camera = "attacker_execution_camera",
	victim_anim_event = "execute_victim_dagger",
	attacker_anim_event = "execute_attacker_dagger",
	attacker_position_offset = Vector3Box(-0.662, -0.1, 0),
	attacker_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/attacker/onground_execute_dagger",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	victim_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/victim/onground_execute_dagger",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov",
			"fade_to_black"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	attacker_events = {
		anim_cb_execute_attacker_exit1 = {
			{
				node = "fx_aux_01",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_execution_weapon_drip"
				}
			}
		},
		anim_cb_execute_attacker_exit2 = {
			{
				node = "fx_aux_01",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_execution_weapon_drip"
				}
			}
		},
		anim_cb_execute_attacker_exit3 = {
			{
				node = "fx_aux_01",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_execution_weapon_drip"
				}
			}
		},
		sfx_execute_husk_start = {
			{
				event = "execution_dagger_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "execution_dagger_husk_vce",
				node = "a_head",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_husk_end = {
			{
				event = "stop_execution_dagger_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "stop_execution_dagger_husk_vce",
				node = "a_head",
				type = "sound"
			}
		},
		sfx_execute_player_start = {
			{
				event = "execution_dagger_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_dagger_player_vce",
				node = "root_point",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_dagger_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_dagger_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	},
	victim_events = {
		anim_cb_execute_victim_mouth = {
			{
				node = "fx_aux_05",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_directional_small"
				}
			}
		},
		anim_cb_execute_victim_entry1 = {
			{
				node = "fx_aux_01",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_directional_small"
				}
			}
		},
		anim_cb_execute_victim_entry2 = {
			{
				node = "fx_aux_02",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_directional_small"
				}
			}
		},
		anim_cb_execute_victim_entry3 = {
			{
				node = "fx_aux_03",
				armour_location = "head",
				type = "particle",
				particle_name = {
					default = "fx/blood_directional_small"
				}
			}
		},
		sfx_execute_player_start = {
			{
				event = "execution_dagger_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_dagger_player_vce",
				node = "root_point",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_dagger_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_dagger_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	}
}
ExecutionDefinitions.shield = {
	victim_camera = "victim_execution_camera",
	attacker_camera = "attacker_execution_camera",
	victim_anim_event = "execute_victim_shield",
	attacker_anim_event = "execute_attacker_shield",
	attacker_position_offset = Vector3Box(-0.662, -0.1, 0),
	attacker_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/attacker/onground_execute_shield",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	victim_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/victim/onground_execute_shield",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov",
			"fade_to_black"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	attacker_events = {
		sfx_execute_husk_start = {
			{
				event = "execution_shield_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_husk_vce",
				node = "a_head",
				voice = false,
				type = "sound"
			}
		},
		sfx_execute_husk_end = {
			{
				event = "stop_execution_shield_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_husk_vce",
				node = "a_head",
				type = "sound"
			}
		},
		sfx_execute_player_start = {
			{
				event = "execution_shield_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_player_vce",
				node = "root_point",
				voice = false,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_shield_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	},
	victim_events = {
		sfx_execute_player_start = {
			{
				event = "execution_shield_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_player_vce",
				node = "root_point",
				voice = false,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_shield_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	}
}
ExecutionDefinitions.two_handed_axe = {
	victim_camera = "victim_execution_camera",
	attacker_camera = "attacker_execution_camera",
	victim_anim_event = "execute_victim_2h_axe",
	attacker_anim_event = "execute_attacker_2h_axe",
	attacker_position_offset = Vector3Box(-0.662, -0.1, 0),
	attacker_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/attacker/onground_execute_2h_axe",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	victim_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/victim/onground_execute_2h_axe",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov",
			"fade_to_black"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	attacker_events = {
		sfx_execute_husk_start = {
			{
				event = "execution_2h_axe_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_husk_vce",
				node = "a_head",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_husk_end = {
			{
				event = "stop_execution_2h_axe_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_husk_vce",
				node = "a_head",
				type = "sound"
			}
		},
		sfx_execute_player_start = {
			{
				event = "execution_2h_axe_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_player_vce",
				node = "root_point",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_2h_axe_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	},
	victim_events = {
		sfx_execute_player_start = {
			{
				event = "execution_2h_axe_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_player_vce",
				node = "root_point",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_2h_axe_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	}
}
ExecutionDefinitions.club = {
	victim_camera = "victim_execution_camera",
	attacker_camera = "attacker_execution_camera",
	victim_anim_event = "execute_victim_club",
	attacker_anim_event = "execute_attacker_club",
	attacker_position_offset = Vector3Box(-0.662, -0.1, 0),
	attacker_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/attacker/onground_execute_2h_axe",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	victim_animation_curves_data = {
		use_step_sampling = false,
		resource = "units/beings/chr_wotr_man/anims/onground/execution/victim/onground_execute_2h_axe",
		camera_parameters = {
			"near_clip",
			"far_clip",
			"yfov",
			"fade_to_black"
		},
		environment_parameters = {
			"dof_near_focus",
			"dof_far_focus",
			"dof_near_blur",
			"dof_far_blur"
		}
	},
	attacker_events = {
		sfx_execute_husk_start = {
			{
				event = "execution_club_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_husk_vce",
				node = "a_head",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_husk_end = {
			{
				event = "stop_execution_club_husk",
				node = "a_head",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_husk_vce",
				node = "a_head",
				type = "sound"
			}
		},
		sfx_execute_player_start = {
			{
				event = "execution_club_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_player_vce",
				node = "root_point",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_club_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	},
	victim_events = {
		sfx_execute_player_start = {
			{
				event = "execution_club_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "execution_sword_omni_2h_player_vce",
				node = "root_point",
				voice = true,
				type = "sound"
			}
		},
		sfx_execute_player_end = {
			{
				event = "stop_execution_club_player",
				node = "root_point",
				type = "sound"
			},
			{
				event = "stop_execution_sword_omni_2h_player_vce",
				node = "root_point",
				type = "sound"
			}
		}
	}
}
ExecutionDefinitions.dagger_fallback = table.clone(ExecutionDefinitions.dagger)
ExecutionDefinitions.dagger_fallback.hide_wielded_weapons = true
