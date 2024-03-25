-- chunkname: @scripts/settings/camera_settings.lua

CameraSettings = CameraSettings or {}
PITCH_SPEED = 720
YAW_SPEED = 720
EnvironmentTweaks = EnvironmentTweaks or {}
EnvironmentTweaks.time_to_blend_env = 0.1
EnvironmentTweaks.time_to_default_env = 0.8
CameraTweaks = CameraTweaks or {}
CameraTweaks.zoom = {
	scale = 0.1,
	pad_scale = 2.5,
	interpolation_function = function(current, target, dt)
		return math.lerp(current, target, dt * 7)
	end
}
CameraSettings.player = {
	_node = {
		pitch_min = -71,
		name = "root_node",
		class = "RootCamera",
		vertical_fov = 45,
		pitch_offset = 0,
		pitch_max = 65,
		root_object_name = "camera_attach",
		pitch_speed = PITCH_SPEED,
		yaw_speed = YAW_SPEED,
		safe_position_offset = Vector3Box(0, 0, 1.55),
		tree_transitions = {
			horse = CameraTransitionTemplates.mounting,
			standard_bow_arrow = CameraTransitionTemplates.between_units_fast,
			player_dead = CameraTransitionTemplates.between_units_fast
		},
		node_transitions = {
			default = CameraTransitionTemplates.player_fast,
			dead = CameraTransitionTemplates.dead,
			attacker_execution_camera = CameraTransitionTemplates.instant_cut,
			victim_execution_camera = CameraTransitionTemplates.instant_cut
		}
	},
	{
		_node = {
			animation_curve_parameter_name = "execution_attacker_anim_curves",
			name = "attacker_execution_camera_motion_builder",
			class = "ObjectLinkCamera",
			root_object_name = "execution_camera"
		},
		{
			_node = {
				offset_pitch = -90,
				name = "attacker_execution_camera",
				class = "RotationCamera",
				offset_yaw = -90,
				tree_transitions = {
					default = CameraTransitionTemplates.instant_cut
				},
				node_transitions = {
					default = CameraTransitionTemplates.instant_cut
				}
			}
		}
	},
	{
		_node = {
			animation_curve_parameter_name = "execution_victim_anim_curves",
			name = "victim_execution_camera_motion_builder",
			class = "ObjectLinkCamera",
			root_object_name = "execution_camera"
		},
		{
			_node = {
				offset_pitch = -90,
				name = "victim_execution_camera",
				class = "RotationCamera",
				offset_yaw = -90,
				tree_transitions = {
					default = CameraTransitionTemplates.instant_cut
				},
				node_transitions = {
					default = CameraTransitionTemplates.instant_cut
				}
			}
		}
	},
	{
		_node = {
			yaw = true,
			name = "yaw_aim",
			class = "AimCamera",
			pitch_offset = 22.5,
			pitch = false
		},
		{
			_node = {
				class = "TransformCamera",
				name = "up_translation",
				offset_position = {
					z = 0.25,
					x = 0,
					y = 0
				}
			},
			{
				_node = {
					pitch = true,
					name = "pitch_aim",
					class = "AimCamera",
					yaw = true
				},
				{
					_node = {
						class = "TransformCamera",
						name = "onground_no_scale",
						offset_position = {
							z = 0.18,
							x = 0,
							y = -2
						}
					},
					{
						_node = {
							class = "TransformCamera",
							name = "killer_cam",
							offset_position = {
								z = 0,
								x = 2,
								y = -5
							}
						}
					},
					{
						_node = {
							vertical_fov = 48,
							name = "onground",
							class = "ScalableTransformCamera",
							scale_variable = "zoom",
							offset_position = {
								z = 0,
								x = 0,
								y = -2
							},
							scale_function = function(scale)
								return scale
							end
						},
						{
							_node = {
								class = "TransformCamera",
								name = "dead",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "squad_spawn_camera",
								offset_position = {
									z = 0,
									x = 0,
									y = -5
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "climbing",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "planting_flag",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "reviving_teammate",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "bandaging_self",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "bandaging_teammate",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "stunned",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "BlendCamera",
								name = "swing_pose_blend",
								pitch_speed = PITCH_SPEED / 10,
								yaw_speed = YAW_SPEED / 10,
								child_node_blend_definitions = {
									{
										match_value_y = 0,
										match_value_x = 0,
										blend_parameter_x = "swing_x",
										blend_function = "match_2d",
										blend_parameter_y = "swing_y"
									},
									{
										match_value = -1,
										blend_parameter = "swing_x",
										blend_function = "match"
									},
									{
										match_value = 1,
										blend_parameter = "swing_x",
										blend_function = "match"
									},
									{
										match_value = 1,
										blend_parameter = "swing_y",
										blend_function = "match"
									},
									{
										match_value = -1,
										blend_parameter = "swing_y",
										blend_function = "match"
									}
								},
								node_transitions = {
									swing_pose_mid = CameraTransitionTemplates.swing_blend_to_swing,
									swing_pose_left = CameraTransitionTemplates.swing_blend_to_swing,
									swing_pose_right = CameraTransitionTemplates.swing_blend_to_swing,
									swing_pose_up = CameraTransitionTemplates.swing_blend_to_swing,
									swing_pose_down = CameraTransitionTemplates.swing_blend_to_swing,
									default = CameraTransitionTemplates.swing_blend_to_other
								}
							},
							{
								_node = {
									class = "TransformCamera",
									name = "swing_pose_mid",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									},
									pitch_speed = PITCH_SPEED,
									yaw_speed = YAW_SPEED
								}
							},
							{
								_node = {
									class = "TransformCamera",
									name = "swing_pose_left",
									offset_position = {
										z = 0,
										y = 0,
										x = -0
									},
									pitch_speed = PITCH_SPEED,
									yaw_speed = YAW_SPEED
								}
							},
							{
								_node = {
									class = "TransformCamera",
									name = "swing_pose_right",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									},
									pitch_speed = PITCH_SPEED,
									yaw_speed = YAW_SPEED
								}
							},
							{
								_node = {
									class = "TransformCamera",
									name = "swing_pose_up",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									},
									pitch_speed = PITCH_SPEED,
									yaw_speed = YAW_SPEED
								}
							},
							{
								_node = {
									class = "TransformCamera",
									name = "swing_pose_down",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									},
									pitch_speed = PITCH_SPEED,
									yaw_speed = YAW_SPEED
								}
							}
						},
						{
							_node = {
								vertical_fov = 45,
								name = "knocked_down",
								class = "TransformCamera",
								offset_position = {
									z = -1,
									x = 0.1,
									y = -0.5
								}
							}
						},
						{
							_node = {
								vertical_fov = 45,
								name = "crouch",
								class = "TransformCamera",
								offset_position = {
									z = -0.5,
									x = 0.1,
									y = 0.15
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "parry_pose_right",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "parry_pose_left",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "parry_pose_up",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "parry_pose_down",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						}
					}
				},
				{
					_node = {
						vertical_fov = 60,
						name = "jump_scale",
						class = "ScalableTransformCamera",
						scale_variable = "zoom",
						offset_position = {
							z = 0,
							x = 0,
							y = -3
						},
						scale_function = function(scale)
							return scale
						end
					},
					{
						_node = {
							class = "TransformCamera",
							name = "jump",
							offset_position = {
								z = 0.1,
								x = 0,
								y = -1.9
							}
						}
					},
					{
						_node = {
							class = "TransformCamera",
							name = "fall",
							offset_position = {
								z = 0.18,
								x = 0,
								y = -1.85
							}
						}
					},
					{
						_node = {
							class = "TransformCamera",
							name = "land_base",
							offset_position = {
								z = 0.1,
								x = 0,
								y = -1.9
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "land_heavy",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "land_light",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "land_knocked_down",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "land_dead",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						}
					}
				},
				{
					_node = {
						vertical_fov = 55,
						name = "rush_base",
						class = "TransformCamera",
						offset_position = {
							z = 0.18,
							x = 0,
							y = -2
						}
					},
					{
						_node = {
							vertical_fov = 58,
							name = "rush",
							class = "ScalableTransformCamera",
							scale_variable = "zoom",
							offset_position = {
								z = 0,
								x = 0,
								y = -2
							},
							scale_function = function(scale)
								return scale
							end
						},
						{
							_node = {
								class = "BlendCamera",
								name = "rush_swing_pose_blend",
								pitch_speed = PITCH_SPEED / 10,
								yaw_speed = YAW_SPEED / 10,
								child_node_blend_definitions = {
									{
										match_value_y = 0,
										match_value_x = 0,
										blend_parameter_x = "swing_x",
										blend_function = "match_2d",
										blend_parameter_y = "swing_y"
									},
									{
										match_value = -1,
										blend_parameter = "swing_x",
										blend_function = "match"
									},
									{
										match_value = 1,
										blend_parameter = "swing_x",
										blend_function = "match"
									},
									{
										match_value = 1,
										blend_parameter = "swing_y",
										blend_function = "match"
									},
									{
										match_value = -1,
										blend_parameter = "swing_y",
										blend_function = "match"
									}
								},
								node_transitions = {
									rush_swing_pose_mid = CameraTransitionTemplates.swing_blend_to_swing,
									rush_swing_pose_left = CameraTransitionTemplates.swing_blend_to_swing,
									rush_swing_pose_right = CameraTransitionTemplates.swing_blend_to_swing,
									rush_swing_pose_up = CameraTransitionTemplates.swing_blend_to_swing,
									rush_swing_pose_down = CameraTransitionTemplates.swing_blend_to_swing,
									default = CameraTransitionTemplates.swing_blend_to_other
								}
							},
							{
								_node = {
									vertical_fov = 40,
									name = "rush_swing_pose_mid",
									class = "TransformCamera",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									}
								}
							},
							{
								_node = {
									vertical_fov = 40,
									name = "rush_swing_pose_left",
									class = "TransformCamera",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									}
								}
							},
							{
								_node = {
									vertical_fov = 40,
									name = "rush_swing_pose_right",
									class = "TransformCamera",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									}
								}
							},
							{
								_node = {
									vertical_fov = 40,
									name = "rush_swing_pose_up",
									class = "TransformCamera",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									}
								}
							},
							{
								_node = {
									vertical_fov = 40,
									name = "rush_swing_pose_down",
									class = "TransformCamera",
									offset_position = {
										z = 0,
										x = 0,
										y = 0
									}
								}
							}
						}
					}
				}
			}
		}
	},
	{
		_node = {
			pitch_min = -85,
			name = "zoom_pitch_aim",
			class = "AimCamera",
			pitch_max = 85,
			pitch_speed = PITCH_SPEED,
			yaw_speed = YAW_SPEED
		},
		{
			_node = {
				vertical_fov = 45,
				name = "zoom",
				class = "TransformCamera",
				offset_position = {
					z = 0.15,
					x = 0.28,
					y = -0.1
				}
			}
		},
		{
			_node = {
				name = "bow_hand",
				class = "ObjectLinkCamera",
				root_object_name = "crossbow_camera_align"
			},
			{
				_node = {
					dof_near_focus = 0.4,
					name = "zoom_bow_base",
					class = "TransformCamera",
					dof_amount = 1,
					vertical_fov = 45,
					dof_near_blur = 0.25,
					offset_position = {
						z = 0.01,
						x = -0.01,
						y = 0
					}
				},
				{
					_node = {
						vertical_fov = 5,
						name = "zoom_bow",
						class = "ScalableTransformCamera",
						scale_variable = "aim_zoom",
						offset_position = {
							z = 0,
							x = 0,
							y = 0
						},
						scale_function = function(scale)
							return 1 - scale
						end
					}
				}
			}
		},
		{
			_node = {
				dof_near_focus = 0.4,
				name = "zoom_handgonne_base",
				class = "TransformCamera",
				vertical_fov = 45,
				dof_near_blur = 0,
				offset_position = {
					z = 0.15,
					x = 0.28,
					y = -0.51
				}
			},
			{
				_node = {
					vertical_fov = 5,
					name = "zoom_handgonne",
					class = "ScalableTransformCamera",
					scale_variable = "aim_zoom",
					offset_position = {
						z = 0,
						x = 0,
						y = 0
					},
					scale_function = function(scale)
						return 1 - scale
					end
				}
			}
		},
		{
			_node = {
				name = "crossbow_hand",
				class = "ObjectLinkCamera",
				root_object_name = "crossbow_camera_align"
			},
			{
				_node = {
					vertical_fov = 35,
					name = "zoom_crossbow_base",
					class = "TransformCamera",
					offset_position = {
						z = 0.03,
						x = 0,
						y = -0.3
					}
				},
				{
					_node = {
						vertical_fov = 5,
						name = "xoom_crossbow_scaled",
						class = "ScalableTransformCamera",
						scale_variable = "aim_zoom",
						offset_position = {
							z = 0,
							x = 0,
							y = 0
						},
						scale_function = function(scale)
							return 1 - scale
						end
					},
					{
						_node = {
							dof_near_focus = 0.5,
							name = "zoom_crossbow",
							class = "SwayCamera",
							dof_amount = 1,
							dof_near_blur = 0.1
						}
					}
				}
			}
		}
	}
}

local function COUCH_CONSTRAINT_FUNCTION(relative_yaw, relative_pitch, yaw_delta, pitch_delta)
	local yaw, pitch
	local max_angle = math.pi * 0.25
	local half_multiple = max_angle / math.pi
	local multiple = 2 * half_multiple
	local scale_factor = 2
	local flat_point = math.sqrt(1 / scale_factor - 1 / (scale_factor * scale_factor))

	if math.sign(relative_pitch) == math.sign(pitch_delta) then
		pitch = 0.5 * math.atan(math.tan(math.clamp(relative_pitch * 2, -math.pi * 0.5, math.pi * 0.5)) + pitch_delta / 2)
	else
		pitch = relative_pitch + pitch_delta
	end

	if math.sign(relative_pitch) ~= math.sign(pitch_delta) and flat_point < math.abs(relative_pitch) then
		yaw = math.clamp(multiple * math.atan(math.tan(math.clamp(math.pi * 0.5 * relative_pitch / max_angle, -math.half_pi, math.half_pi)) + pitch_delta * scale_factor), -max_angle, max_angle)
	else
		yaw = relative_pitch + pitch_delta
	end

	if math.sign(relative_yaw) ~= math.sign(yaw_delta) and flat_point < math.abs(relative_yaw) then
		yaw = math.clamp(multiple * math.atan(math.tan(math.clamp(math.pi * 0.5 * relative_yaw / max_angle, -math.half_pi, math.half_pi)) - yaw_delta * scale_factor), -max_angle, max_angle)
	else
		yaw = math.clamp(relative_yaw - yaw_delta, -max_angle, max_angle)
	end

	return yaw, pitch
end

function MOUNTED_CONSTRAINT_FUNCTION(relative_yaw, relative_pitch, yaw_delta, pitch_delta)
	local yaw
	local max_angle = math.pi * 0.45
	local half_multiple = max_angle / math.pi
	local multiple = 2 * half_multiple
	local scale_factor = 1.25
	local flat_point = math.sqrt(1 / scale_factor - 1 / (scale_factor * scale_factor))

	if math.sign(relative_yaw) ~= math.sign(yaw_delta) and flat_point < math.abs(relative_yaw) then
		yaw = math.clamp(multiple * math.atan(math.tan(math.clamp(math.pi * 0.5 * relative_yaw / max_angle, -math.half_pi, math.half_pi)) - yaw_delta * scale_factor), -max_angle, max_angle)
	else
		yaw = math.clamp(relative_yaw - yaw_delta, -max_angle, max_angle)
	end

	return yaw
end

CameraSettings.horse = {
	_node = {
		pitch_min = -90,
		name = "root_node",
		class = "RootCamera",
		vertical_fov = 45,
		pitch_offset = 0,
		pitch_max = 90,
		root_object_name = "camera_attach",
		pitch_speed = PITCH_SPEED,
		yaw_speed = YAW_SPEED,
		safe_position_offset = Vector3Box(0, 0, 2),
		tree_transitions = {
			player = CameraTransitionTemplates.between_units_fast,
			standard_bow_arrow = CameraTransitionTemplates.between_units_fast,
			player_dead = CameraTransitionTemplates.between_units_fast
		},
		node_transitions = {
			default = CameraTransitionTemplates.player_fast
		}
	},
	{
		_node = {
			vertical_fov = 55,
			name = "couch_up_translation",
			class = "TransformCamera",
			offset_position = {
				z = 0.2,
				x = 0.1,
				y = 0.4
			}
		},
		{
			_node = {
				yaw = true,
				name = "couch",
				class = "AimCamera",
				pitch_offset = 0,
				yaw_origin = 0,
				pitch = true,
				pitch_origin = 0,
				constraint = COUCH_CONSTRAINT_FUNCTION
			}
		}
	},
	{
		_node = {
			name = "mounting_rotation",
			class = "RotationCamera",
			offset_pitch = 0,
			pitch_offset = 22.5,
			offset_yaw = 0
		},
		{
			_node = {
				class = "TransformCamera",
				name = "mount_up_translation",
				offset_position = {
					z = 0.25,
					x = 0,
					y = 0
				}
			},
			{
				_node = {
					pitch = true,
					name = "mount_pitch_aim",
					class = "AimCamera",
					yaw = true
				},
				{
					_node = {
						class = "TransformCamera",
						name = "mount_onground_no_scale",
						offset_position = {
							z = 0.18,
							x = 0,
							y = -2
						}
					},
					{
						_node = {
							vertical_fov = 48,
							name = "mounting",
							class = "ScalableTransformCamera",
							scale_variable = "zoom",
							offset_position = {
								z = 0,
								x = 0,
								y = -2
							},
							scale_function = function(scale)
								return scale
							end
						}
					}
				}
			}
		}
	},
	{
		_node = {
			yaw = true,
			name = "dismount_yaw_aim",
			class = "AimCamera",
			pitch_offset = 22.5,
			pitch = false
		},
		{
			_node = {
				class = "TransformCamera",
				name = "dismount_up_translation",
				offset_position = {
					z = 0.25,
					x = 0,
					y = 0
				}
			},
			{
				_node = {
					pitch = true,
					name = "dismount_pitch_aim",
					class = "AimCamera",
					yaw = true
				},
				{
					_node = {
						class = "TransformCamera",
						name = "dismount_onground_no_scale",
						offset_position = {
							z = 0.18,
							x = 0,
							y = -2
						}
					},
					{
						_node = {
							vertical_fov = 48,
							name = "dismounting",
							class = "ScalableTransformCamera",
							scale_variable = "zoom",
							offset_position = {
								z = 0,
								x = 0,
								y = -2
							},
							scale_function = function(scale)
								return scale
							end
						}
					}
				}
			}
		}
	},
	{
		_node = {
			yaw = true,
			name = "yaw_aim",
			class = "AimCamera",
			pitch_offset = 10,
			pitch = false,
			constraint = MOUNTED_CONSTRAINT_FUNCTION
		},
		{
			_node = {
				class = "TransformCamera",
				name = "up_translation",
				offset_position = {
					z = 0,
					x = 0,
					y = 0
				}
			},
			{
				_node = {
					class = "TransformCamera",
					name = "left_side_translation",
					offset_position = {
						z = 0,
						x = 0,
						y = 0
					}
				},
				{
					_node = {
						pitch = true,
						name = "pitch_aim",
						class = "AimCamera",
						yaw = true,
						constraint = MOUNTED_CONSTRAINT_FUNCTION
					},
					{
						_node = {
							class = "TransformCamera",
							name = "base_horse_offset",
							offset_position = {
								z = 0.5,
								x = 0,
								y = -5
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "onground_offset",
								offset_position = {
									z = 0,
									x = 0,
									y = 2
								}
							},
							{
								_node = {
									name = "onground",
									class = "ScalableTransformCamera",
									scale_variable = "zoom",
									offset_position = {
										z = 0,
										x = 0,
										y = -6
									},
									scale_function = function(scale)
										return scale
									end
								},
								{
									_node = {
										class = "BlendCamera",
										name = "swing_pose_blend",
										child_node_blend_definitions = {
											{
												match_value_y = 0,
												match_value_x = 0,
												blend_parameter_x = "swing_x",
												blend_function = "match_2d",
												blend_parameter_y = "swing_y"
											},
											{
												match_value = -1,
												blend_parameter = "swing_x",
												blend_function = "match"
											},
											{
												match_value = 1,
												blend_parameter = "swing_x",
												blend_function = "match"
											},
											{
												match_value = 1,
												blend_parameter = "swing_y",
												blend_function = "match"
											},
											{
												match_value = -1,
												blend_parameter = "swing_y",
												blend_function = "match"
											}
										},
										node_transitions = {
											swing_pose_mid = CameraTransitionTemplates.swing_blend_to_swing,
											swing_pose_left = CameraTransitionTemplates.swing_blend_to_swing,
											swing_pose_right = CameraTransitionTemplates.swing_blend_to_swing,
											swing_pose_up = CameraTransitionTemplates.swing_blend_to_swing,
											swing_pose_down = CameraTransitionTemplates.swing_blend_to_swing,
											default = CameraTransitionTemplates.swing_blend_to_other
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "swing_pose_mid",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "swing_pose_left",
											offset_position = {
												z = 0,
												y = 0,
												x = -0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "swing_pose_right",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "swing_pose_up",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "swing_pose_down",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "parry_pose_right",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "parry_pose_left",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "parry_pose_up",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "parry_pose_down",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "jump_offset",
								offset_position = {
									z = 0,
									x = 0,
									y = 2
								}
							},
							{
								_node = {
									name = "jump",
									class = "ScalableTransformCamera",
									scale_variable = "zoom",
									offset_position = {
										z = 0,
										x = 0,
										y = -6
									},
									scale_function = function(scale)
										return scale
									end
								},
								{
									_node = {
										class = "BlendCamera",
										name = "jump_swing_pose_blend",
										child_node_blend_definitions = {
											{
												match_value_y = 0,
												match_value_x = 0,
												blend_parameter_x = "swing_x",
												blend_function = "match_2d",
												blend_parameter_y = "swing_y"
											},
											{
												match_value = -1,
												blend_parameter = "swing_x",
												blend_function = "match"
											},
											{
												match_value = 1,
												blend_parameter = "swing_x",
												blend_function = "match"
											},
											{
												match_value = 1,
												blend_parameter = "swing_y",
												blend_function = "match"
											},
											{
												match_value = -1,
												blend_parameter = "swing_y",
												blend_function = "match"
											}
										},
										node_transitions = {
											jump_swing_pose_mid = CameraTransitionTemplates.swing_blend_to_swing,
											jump_swing_pose_left = CameraTransitionTemplates.swing_blend_to_swing,
											jump_swing_pose_right = CameraTransitionTemplates.swing_blend_to_swing,
											jump_swing_pose_up = CameraTransitionTemplates.swing_blend_to_swing,
											jump_swing_pose_down = CameraTransitionTemplates.swing_blend_to_swing,
											default = CameraTransitionTemplates.swing_blend_to_other
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "jump_swing_pose_mid",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "jump_swing_pose_left",
											offset_position = {
												z = 0,
												y = 0,
												x = -0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "jump_swing_pose_right",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "jump_swing_pose_up",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "jump_swing_pose_down",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "jump_parry_pose_right",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "jump_parry_pose_left",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "jump_parry_pose_up",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "jump_parry_pose_down",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								}
							}
						},
						{
							_node = {
								class = "TransformCamera",
								name = "charge_offset",
								offset_position = {
									z = 0,
									x = 0,
									y = 2
								}
							},
							{
								_node = {
									name = "charge",
									class = "ScalableTransformCamera",
									scale_variable = "zoom",
									offset_position = {
										z = 0,
										x = 0,
										y = -6
									},
									scale_function = function(scale)
										return scale
									end
								},
								{
									_node = {
										class = "BlendCamera",
										name = "charge_swing_pose_blend",
										child_node_blend_definitions = {
											{
												match_value_y = 0,
												match_value_x = 0,
												blend_parameter_x = "swing_x",
												blend_function = "match_2d",
												blend_parameter_y = "swing_y"
											},
											{
												match_value = -1,
												blend_parameter = "swing_x",
												blend_function = "match"
											},
											{
												match_value = 1,
												blend_parameter = "swing_x",
												blend_function = "match"
											},
											{
												match_value = 1,
												blend_parameter = "swing_y",
												blend_function = "match"
											},
											{
												match_value = -1,
												blend_parameter = "swing_y",
												blend_function = "match"
											}
										},
										node_transitions = {
											charge_swing_pose_mid = CameraTransitionTemplates.swing_blend_to_swing,
											charge_swing_pose_left = CameraTransitionTemplates.swing_blend_to_swing,
											charge_swing_pose_right = CameraTransitionTemplates.swing_blend_to_swing,
											charge_swing_pose_up = CameraTransitionTemplates.swing_blend_to_swing,
											charge_swing_pose_down = CameraTransitionTemplates.swing_blend_to_swing,
											default = CameraTransitionTemplates.swing_blend_to_other
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "charge_swing_pose_mid",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "charge_swing_pose_left",
											offset_position = {
												z = 0,
												y = 0,
												x = -0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "charge_swing_pose_right",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "charge_swing_pose_up",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									},
									{
										_node = {
											class = "TransformCamera",
											name = "charge_swing_pose_down",
											offset_position = {
												z = 0,
												x = 0,
												y = 0
											},
											pitch_speed = PITCH_SPEED,
											yaw_speed = YAW_SPEED
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "charge_parry_pose_right",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "charge_parry_pose_left",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "charge_parry_pose_up",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								},
								{
									_node = {
										class = "TransformCamera",
										name = "charge_parry_pose_down",
										offset_position = {
											z = 0,
											x = 0,
											y = 0
										}
									}
								}
							}
						}
					}
				}
			}
		},
		{
			_node = {
				class = "TransformCamera",
				name = "zoom",
				offset_position = {
					z = 0,
					x = 0.5,
					y = -1
				}
			}
		},
		{
			_node = {
				dof_near_focus = 0.8,
				name = "zoom_bow_base",
				class = "TransformCamera",
				vertical_fov = 45,
				dof_near_blur = 0,
				offset_position = {
					z = 0.15,
					x = 0.28,
					y = -0.1
				}
			},
			{
				_node = {
					vertical_fov = 5,
					name = "zoom_bow",
					class = "ScalableTransformCamera",
					scale_variable = "aim_zoom",
					offset_position = {
						z = 0,
						x = 0,
						y = 0
					},
					scale_function = function(scale)
						return 1 - scale
					end
				}
			}
		},
		{
			_node = {
				dof_near_focus = 0.4,
				name = "zoom_handgonne_base",
				class = "TransformCamera",
				vertical_fov = 45,
				dof_near_blur = 0,
				offset_position = {
					z = 0.15,
					x = 0.28,
					y = -0.51
				}
			},
			{
				_node = {
					vertical_fov = 5,
					name = "zoom_handgonne",
					class = "ScalableTransformCamera",
					scale_variable = "aim_zoom",
					offset_position = {
						z = 0,
						x = 0,
						y = 0
					},
					scale_function = function(scale)
						return 1 - scale
					end
				}
			}
		},
		{
			_node = {
				vertical_fov = 35,
				name = "zoom_crossbow_base",
				class = "TransformCamera",
				offset_position = {
					z = 0.12,
					x = 0.15,
					y = 0.15
				}
			},
			{
				_node = {
					vertical_fov = 15,
					name = "xoom_crossbow_scaled",
					class = "ScalableTransformCamera",
					scale_variable = "aim_zoom",
					offset_position = {
						z = 0,
						x = 0,
						y = 0
					},
					scale_function = function(scale)
						return 1 - scale
					end
				},
				{
					_node = {
						class = "SwayCamera",
						name = "zoom_crossbow"
					}
				}
			}
		},
		{
			_node = {
				class = "TransformCamera",
				name = "jump_zoom",
				offset_position = {
					z = 0,
					x = 0.5,
					y = -1.1
				}
			}
		}
	}
}
CameraSettings.world = {
	_node = {
		pitch_min = -90,
		name = "default",
		class = "RootCamera",
		vertical_fov = 45,
		yaw_speed = 0,
		pitch_max = -90,
		pitch_speed = 0,
		tree_transitions = {},
		node_transitions = {}
	}
}
CameraSettings.main_menu = {
	_node = {
		pitch_min = 0,
		name = "default",
		near_range = 1,
		far_range = 4000,
		pitch_max = 0,
		class = "RootCamera",
		yaw_speed = 0,
		vertical_fov = 45,
		pitch_speed = 0,
		tree_transitions = {},
		node_transitions = {}
	}
}
CameraSettings.ingame_menu = {
	_node = {
		pitch_min = 0,
		name = "default",
		near_range = 1,
		far_range = 4000,
		pitch_max = 0,
		class = "RootCamera",
		yaw_speed = 0,
		vertical_fov = 45,
		pitch_speed = 0,
		tree_transitions = {},
		node_transitions = {}
	}
}
CameraSettings.player_dead = {
	_node = {
		pitch_min = -90,
		name = "root_node",
		class = "RootCamera",
		vertical_fov = 45,
		pitch_offset = 0,
		pitch_max = 90,
		root_object_name = "camera_attach",
		pitch_speed = PITCH_SPEED,
		yaw_speed = YAW_SPEED,
		safe_position_offset = Vector3Box(0, 0, 1.55),
		tree_transitions = {},
		node_transitions = {
			default = CameraTransitionTemplates.dead
		}
	},
	{
		_node = {
			yaw = true,
			name = "yaw_aim",
			class = "AimCamera",
			pitch_offset = 22.5,
			pitch = false
		},
		{
			_node = {
				class = "TransformCamera",
				name = "up_translation",
				offset_position = {
					z = -1,
					x = 0,
					y = 0
				}
			},
			{
				_node = {
					pitch = true,
					name = "pitch_aim",
					class = "AimCamera",
					yaw = true
				},
				{
					_node = {
						class = "TransformCamera",
						name = "onground_no_scale",
						offset_position = {
							z = 0.18,
							x = 0,
							y = -2
						}
					},
					{
						_node = {
							vertical_fov = 48,
							name = "onground",
							class = "ScalableTransformCamera",
							scale_variable = "zoom",
							offset_position = {
								z = 0,
								x = 0,
								y = -2
							},
							scale_function = function(scale)
								return scale
							end
						},
						{
							_node = {
								class = "TransformCamera",
								name = "default",
								offset_position = {
									z = 0,
									x = 0,
									y = 0
								}
							}
						}
					}
				}
			}
		}
	}
}
CameraSettings.standard_bow_arrow = {
	_node = {
		pitch_min = -90,
		name = "root_node",
		pitch_speed = 0,
		offset_pitch = -10,
		pitch_max = -90,
		class = "RootCamera",
		yaw_speed = 0,
		vertical_fov = 80,
		root_object_name = "rp_wpn_arrow_01",
		safe_position_offset = Vector3Box(0, 0, 1.55),
		tree_transitions = {},
		node_transitions = {}
	},
	{
		_node = {
			class = "TransformCamera",
			name = "default",
			offset_position = {
				z = 0.03,
				x = 0,
				y = -0.1
			}
		}
	}
}
CameraSettings.cutscene = {
	_node = {
		pitch_min = -90,
		name = "root_node",
		class = "RootCamera",
		vertical_fov = 80,
		yaw_speed = 0,
		pitch_max = -90,
		offset_pitch = -10,
		pitch_speed = 0,
		safe_position_offset = Vector3Box(0, 0, 1.55),
		tree_transitions = {},
		node_transitions = {}
	}
}
