-- chunkname: @scripts/entity_system/systems/behaviour/behaviour_trees.lua

BehaviourTreeDefinitions = BehaviourTreeDefinitions or {
	default_avoidance = {
		{
			data = {
				max = 1,
				min = 0.5
			},
			{
				{
					class = "BTAvoidPlayersAction",
					input = "players",
					data = {
						team_filter = "ally"
					}
				},
				class = "BTPlayersDetectedCondition",
				input = "players"
			},
			class = "BTUpdateFilter"
		}
	},
	default_targeting = {
		{
			data = {
				max = 1,
				min = 0.5
			},
			{
				{
					output = "target_player",
					class = "BTPickTargetAction",
					input = "players"
				},
				class = "BTPlayersDetectedCondition",
				input = "players"
			},
			class = "BTUpdateFilter"
		}
	},
	ai_only_targeting = {
		{
			data = {
				max = 1,
				min = 0.5
			},
			{
				{
					output = "target_player",
					class = "BTPickTargetAction",
					input = "players",
					data = {
						player_factor = -5
					}
				},
				class = "BTPlayersDetectedCondition",
				input = "players"
			},
			class = "BTUpdateFilter"
		}
	},
	default_pathing = {
		{
			data = {
				max = 1,
				min = 0.5
			},
			{
				{
					{
						class = "BTMoveAgentToSpawnAction"
					},
					class = "BTAgentTetheredCondition"
				},
				{
					{
						class = "BTFollowPlayerAction",
						input = "target_player"
					},
					class = "BTUnitAliveCondition",
					input = "target_player"
				},
				{
					class = "BTProcessMoveOrdersAction",
					input = "move_orders"
				},
				class = "BTSelector"
			},
			class = "BTUpdateFilter"
		}
	},
	melee = {
		{
			{
				{
					class = "BTMeleeAimAction",
					input = "target_player"
				},
				class = "BTUnitAliveCondition",
				input = "target_player"
			},
			{
				data = {
					max = 1,
					min = 0.5
				},
				{
					data = {
						range = "attack_range"
					},
					{
						data = {
							negate = true
						},
						{
							class = "BTMeleeAttackAction",
							data = {
								swing_weights = {
									down = 1,
									up = 1,
									left = 1,
									right = 1
								}
							}
						},
						class = "BTUnitKnockedDownCondition",
						input = "target_player"
					},
					class = "BTWithinRangeCondition",
					input = "target_player"
				},
				class = "BTUpdateFilter"
			},
			class = "BTSequence"
		}
	},
	ranged = {
		{
			{
				{
					class = "BTRangedAimAction",
					input = "target_player"
				},
				class = "BTUnitAliveCondition",
				input = "target_player"
			},
			{
				data = {
					max = 1,
					min = 0.5
				},
				{
					data = {
						range = 50
					},
					{
						data = {
							negate = true
						},
						{
							class = "BTRangedAttackAction",
							input = "target_player"
						},
						class = "BTUnitKnockedDownCondition",
						input = "target_player"
					},
					class = "BTWithinRangeCondition",
					input = "target_player"
				},
				class = "BTUpdateFilter"
			},
			class = "BTSequence"
		}
	},
	melee_manager = {
		{
			{
				{
					{
						class = "BTChangeBehaviourAction",
						data = {
							behaviour = "melee_offensive",
							slot = "main"
						}
					},
					{
						class = "BTChangeBehaviourAction",
						data = {
							behaviour = "melee_defensive",
							slot = "main"
						}
					},
					{
						class = "BTChangeBehaviourAction",
						data = {
							behaviour = "melee_crazy",
							slot = "main"
						}
					},
					class = "BTPickRandomMoraleStateFilter"
				},
				class = "BTMoraleStateUpdateFilter"
			},
			class = "BTUnitAliveCondition",
			input = "target_player"
		}
	},
	melee_offensive = {
		{
			{
				data = {
					ignore_child_result = true
				},
				{
					data = {
						slot_name = "two_handed_weapon",
						wielded = true,
						negate = true
					},
					{
						data = {
							slot_name = "two_handed_weapon",
							wielded = false
						},
						{
							class = "BTSwitchGearAction",
							data = {
								slot_name = "two_handed_weapon"
							}
						},
						class = "BTUnitHasWeaponCondition"
					},
					class = "BTUnitHasWeaponCondition"
				},
				{
					data = {
						range = 2
					},
					{
						{
							data = {
								pose_duration = 2
							},
							{
								class = "BTMeleeAttackAction",
								data = {
									swing_weights = {
										down = 2,
										up = 2,
										left = 1,
										right = 1
									}
								}
							},
							class = "BTUnitPosingCondition",
							input = "target_player"
						},
						{
							{
								class = "BTBlockAction",
								input = "target_player"
							},
							class = "BTUnitAttackingCondition",
							input = "target_player"
						},
						{
							class = "BTMeleeAttackAction",
							data = {
								swing_weights = {
									down = 2,
									up = 2,
									left = 1,
									right = 1
								}
							}
						},
						class = "BTSelector"
					},
					class = "BTWithinRangeCondition",
					input = "target_player"
				},
				class = "BTSequence"
			},
			class = "BTUnitAliveCondition",
			input = "target_player"
		}
	},
	melee_defensive = {
		{
			{
				data = {
					ignore_child_result = true
				},
				{
					data = {
						slot_name = "shield",
						wielded = true,
						negate = true
					},
					{
						data = {
							slot_name = "shield",
							wielded = false
						},
						{
							{
								class = "BTSwitchGearAction",
								data = {
									slot_name = "shield"
								}
							},
							{
								{
									data = {
										slot_name = "one_handed_weapon",
										wielded = false
									},
									{
										class = "BTSwitchGearAction",
										data = {
											slot_name = "one_handed_weapon"
										}
									},
									class = "BTUnitHasWeaponCondition"
								},
								{
									class = "BTSwitchGearAction",
									data = {
										slot_name = "dagger"
									}
								},
								class = "BTSelector"
							},
							class = "BTSequence"
						},
						class = "BTUnitHasWeaponCondition"
					},
					class = "BTUnitHasWeaponCondition"
				},
				{
					data = {
						range = 2
					},
					{
						{
							data = {
								pose_duration = 2
							},
							{
								class = "BTMeleeAttackAction",
								data = {
									swing_weights = {
										down = 1,
										up = 1,
										left = 1,
										right = 1
									}
								}
							},
							class = "BTUnitPosingCondition",
							input = "target_player"
						},
						{
							{
								class = "BTBlockAction",
								input = "target_player"
							},
							class = "BTUnitAttackingCondition",
							input = "target_player"
						},
						{
							data = {
								max = 1,
								min = 0.5
							},
							{
								class = "BTMeleeAttackAction",
								data = {
									swing_weights = {
										down = 1,
										up = 1,
										left = 2,
										right = 2
									}
								}
							},
							class = "BTUpdateFilter"
						},
						class = "BTSelector"
					},
					class = "BTWithinRangeCondition",
					input = "target_player"
				},
				class = "BTSequence"
			},
			class = "BTUnitAliveCondition",
			input = "target_player"
		}
	},
	melee_crazy = {
		{
			{
				data = {
					range = 2
				},
				{
					class = "BTMeleeAttackAction",
					data = {
						swing_weights = {
							down = 1,
							up = 1,
							left = 2,
							right = 2
						}
					}
				},
				class = "BTWithinRangeCondition",
				input = "target_player"
			},
			class = "BTUnitAliveCondition",
			input = "target_player"
		}
	},
	revive_target = {
		{
			{
				{
					{
						data = {
							range = 2
						},
						{
							data = {
								max = 1,
								min = 0.5
							},
							{
								class = "BTReviveAction",
								input = "target_ally"
							},
							class = "BTUpdateFilter"
						},
						class = "BTWithinRangeCondition",
						input = "target_ally"
					},
					{
						class = "BTFollowPlayerAction",
						input = "target_ally"
					},
					class = "BTSelector"
				},
				class = "BTUnitKnockedDownCondition",
				input = "target_ally"
			},
			class = "BTUnitAliveCondition",
			input = "target_ally"
		}
	},
	execute_target = {
		{
			{
				{
					{
						data = {
							range = 2
						},
						{
							{
								data = {
									max = 1,
									min = 0.5
								},
								{
									class = "BTExecuteAction",
									input = "target_player"
								},
								class = "BTUpdateFilter"
							},
							{
								class = "BTChangeBehaviourAction",
								data = {
									behaviour = "melee_manager",
									slot = "morale_manager"
								}
							},
							{
								class = "BTChangeBehaviourAction",
								data = {
									behaviour = "melee_defensive",
									slot = "main"
								}
							},
							class = "BTSequence"
						},
						class = "BTWithinRangeCondition",
						input = "target_player"
					},
					{
						class = "BTFollowPlayerAction",
						input = "target_player",
						data = {
							aim_node = "Neck"
						}
					},
					class = "BTSelector"
				},
				class = "BTUnitKnockedDownCondition",
				input = "target_player"
			},
			class = "BTUnitAliveCondition",
			input = "target_player"
		}
	},
	retreat = {
		{
			{
				{
					{
						data = {
							range = 4
						},
						{
							{
								class = "BTChangeBehaviourAction",
								data = {
									behaviour = "perception_near",
									slot = "perception"
								}
							},
							{
								class = "BTChangeBehaviourAction",
								data = {
									behaviour = "pick_nearest_enemy",
									slot = "target_picking"
								}
							},
							{
								class = "BTChangeBehaviourAction",
								data = {
									behaviour = "melee_main",
									slot = "morale_manager"
								}
							},
							{
								class = "BTChangeBehaviourAction",
								data = {
									behaviour = "melee_defensive",
									slot = "main"
								}
							},
							class = "BTSequence"
						},
						class = "BTWithinRangeCondition",
						input = "target_ally"
					},
					{
						class = "BTFollowPlayerAction",
						input = "target_ally"
					},
					class = "BTSelector"
				},
				class = "BTUnitAliveCondition",
				input = "target_ally"
			},
			class = "BTSelector"
		}
	},
	nil_tree = {
		{
			class = "BTNilAction"
		}
	},
	dead = {
		{
			class = "BTNilAction"
		}
	}
}
