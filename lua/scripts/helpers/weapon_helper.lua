-- chunkname: @scripts/helpers/weapon_helper.lua

require("scripts/helpers/effect_helper")

WeaponHelper = WeaponHelper or {}

function WeaponHelper:locomotion_velocity(u)
	local unit = Unit.has_data(u, "user_unit") and Unit.get_data(u, "user_unit") or u
	local velocity = Vector3(0, 0, 0)

	if Unit.alive(unit) then
		local has_locomotion = ScriptUnit.has_extension(unit, "locomotion_system")

		if has_locomotion then
			velocity = ScriptUnit.extension(unit, "locomotion_system"):get_velocity()
		end
	end

	return velocity
end

function WeaponHelper:gear_impact(hit_gear_unit, gear_unit, target_type, direction, damage, damage_without_armour, position, normal, world, fully_charged_attack)
	local hit_gear_owner_unit = Unit.get_data(hit_gear_unit, "user_unit")
	local gear_owner_unit = Unit.get_data(gear_unit, "user_unit")
	local rotation

	if position and normal then
		rotation = Quaternion.look(normal, Vector3.up())
	else
		position = Unit.world_position(gear_unit, 0) + 0.75 * Quaternion.up(Unit.world_rotation(gear_unit, 0))
		rotation = Quaternion.identity()
	end

	Unit.set_flow_variable(gear_unit, "lua_hit_position", position)
	Unit.set_flow_variable(gear_unit, "lua_hit_rotation", rotation)

	if target_type == "blocking" then
		Unit.flow_event(gear_unit, "lua_hit_blocking_target")
		Unit.flow_event(gear_unit, "lua_hit_blocking_target_" .. direction)
		Unit.animation_event(hit_gear_owner_unit, "hit_reaction_shield_impact")
	elseif target_type == "parrying" then
		Unit.flow_event(gear_unit, "lua_hit_parrying_target")
		Unit.flow_event(gear_unit, "lua_hit_parrying_target_" .. direction)
		Unit.animation_event(hit_gear_owner_unit, "hit_reaction_parry_impact_" .. direction)
		Managers.state.event:trigger("player_parried", hit_gear_unit, gear_unit, fully_charged_attack)
	else
		ferror("[WeaponHelper:gear_impact()]Incorrect target type '%s'", target_type)
	end

	self:_hit_sound_event(world, gear_unit, hit_gear_unit, "gear", damage, damage_without_armour, direction)
end

function WeaponHelper:shield_impact_character(hit_character_unit, damage, position, normal, world, hit_zone, impact_direction)
	self:_player_hit_by_damaging_source(hit_character_unit, damage)

	local damage_ext = ScriptUnit.extension(hit_character_unit, "damage_system")
	local kd = damage_ext.is_knocked_down and damage_ext:is_knocked_down()
	local dead = damage_ext:is_dead()

	if not kd and not dead then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")

		locomotion_ext:stun(hit_zone, impact_direction, "shield_bash_impact")
	end
end

function WeaponHelper:push_impact_character(hit_character_unit, damage, position, normal, world, hit_zone, impact_direction)
	self:_player_hit_by_damaging_source(hit_character_unit, damage)

	local damage_ext = ScriptUnit.extension(hit_character_unit, "damage_system")
	local kd = damage_ext.is_knocked_down and damage_ext:is_knocked_down()
	local dead = damage_ext:is_dead()

	if not kd and not dead then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")

		locomotion_ext:stun(hit_zone, impact_direction, "push_impact")
	end
end

function WeaponHelper:rush_impact_character(hit_character_unit, position, normal, world, impact_direction)
	local damage_ext = ScriptUnit.extension(hit_character_unit, "damage_system")
	local kd = damage_ext.is_knocked_down and damage_ext:is_knocked_down()
	local dead = damage_ext:is_dead()

	if not kd and not dead then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")

		locomotion_ext:stun(nil, impact_direction, "rush_impact")
	end
end

function WeaponHelper:mount_impact_character(hit_character_unit, damage_without_armour, position, normal, world, hit_zone, impact_direction)
	local damage_ext = ScriptUnit.extension(hit_character_unit, "damage_system")
	local kd = damage_ext.is_knocked_down and damage_ext:is_knocked_down()
	local dead = damage_ext:is_dead()

	if not kd and not dead then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")

		locomotion_ext:stun(hit_zone, impact_direction, "mount_impact")
	end
end

function WeaponHelper:weapon_impact_character(hit_character_unit, gear_unit, target_type, direction, stun, damage, damage_without_armour, position, normal, world, hit_zone, impact_direction, weapon_damage_direction)
	self:_player_hit_by_damaging_source(hit_character_unit, damage, impact_direction)

	local damage_ext = ScriptUnit.extension(hit_character_unit, "damage_system")
	local kd = damage_ext.is_knocked_down and damage_ext:is_knocked_down()
	local dead = damage_ext:is_dead()

	if stun and not kd and not dead then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")

		locomotion_ext:stun(hit_zone, impact_direction, "melee_damage")
	elseif not kd and not dead and target_type ~= "not_penetrated" then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")

		locomotion_ext:damage_interrupt(hit_zone, impact_direction, "melee_damage")
	end

	local rotation

	if position and normal then
		rotation = Quaternion.look(normal, Vector3.up())
	else
		position = Unit.world_position(gear_unit, 0) + 0.75 * Quaternion.up(Unit.world_rotation(gear_unit, 0))
		rotation = Quaternion.identity()
	end

	Unit.set_flow_variable(gear_unit, "lua_hit_position", position)
	Unit.set_flow_variable(gear_unit, "lua_hit_rotation", rotation)

	if target_type == "not_penetrated" then
		Unit.flow_event(gear_unit, "lua_hit_blocking_target")
		Unit.flow_event(gear_unit, "lua_hit_blocking_target_" .. direction)
	elseif target_type == "hard" then
		Unit.flow_event(gear_unit, "lua_hit_hard_target")
		Unit.flow_event(gear_unit, "lua_hit_hard_target_" .. direction)
	elseif target_type == "soft" then
		Unit.flow_event(gear_unit, "lua_hit_soft_target")
		Unit.flow_event(gear_unit, "lua_hit_soft_target_" .. direction)
	else
		ferror("[WeaponHelper:weapon_impact_character()]Incorrect target type '%s'", target_type)
	end

	self:_hit_sound_event(world, gear_unit, hit_character_unit, "character", damage, damage_without_armour, direction)

	if target_type ~= "not_penetrated" then
		self:_blood_trail(world, gear_unit, position, weapon_damage_direction)
		self:_blood_splat_decal(world, position, impact_direction)
	end

	self:_hurt_sound_event(hit_character_unit, damage, world)
end

function WeaponHelper:_blood_trail(world, unit, position, weapon_damage_direction)
	local unit_rot = Unit.world_rotation(unit, 0)
	local unit_pos = Unit.world_position(unit, 0)
	local offset_pos = position - unit_pos
	local local_offset_pos = Vector3(Vector3.dot(Quaternion.right(unit_rot), offset_pos), Vector3.dot(Quaternion.forward(unit_rot), offset_pos), Vector3.dot(Quaternion.up(unit_rot), offset_pos))
	local local_offset_rotation = Quaternion.look(weapon_damage_direction, Vector3.up())
	local pose = Matrix4x4.from_quaternion_position(local_offset_rotation, local_offset_pos)
	local effect_name = "fx/impact_blood_weapon_trail"

	ScriptWorld.create_particles_linked(world, effect_name, unit, 0, "stop", pose)
end

function WeaponHelper:handgonne_impact_character(hit_character_unit, position, damage, world, stun, hit_zone, impact_direction)
	self:_player_hit_by_damaging_source(hit_character_unit, damage)

	local damage_ext = ScriptUnit.extension(hit_character_unit, "damage_system")
	local kd = damage_ext.is_knocked_down and damage_ext:is_knocked_down()
	local dead = damage_ext:is_dead()

	if stun and not kd and not dead then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")

		locomotion_ext:stun(hit_zone, impact_direction, "projectile_damage")
	elseif not kd and not dead then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")

		locomotion_ext:damage_interrupt(hit_zone, impact_direction, "projectile_damage")
	end

	local armour_type = Unit.get_data(hit_character_unit, "armour_type")

	if not armour_type then
		return
	end

	local armour_type_short

	if string.sub(armour_type, 0, string.len("weapon_")) == "weapon_" then
		armour_type_short = string.sub(armour_type, string.len("weapon_") + 1)
	elseif string.sub(armour_type, 0, string.len("armour_")) == "armour_" then
		armour_type_short = string.sub(armour_type, string.len("armour_") + 1)
	end

	if armour_type_short then
		local timpani_world = World.timpani_world(world)
		local event_id = TimpaniWorld.trigger_event(timpani_world, "bullet_hit", position)

		TimpaniWorld.set_parameter(timpani_world, event_id, "armour_type", armour_type_short)
	end

	self:_hurt_sound_event(hit_character_unit, damage, world)

	local effect_name = "fx/impact_blood"

	World.create_particles(world, effect_name, position)
end

function WeaponHelper:projectile_impact(world, hit_unit, projectile_unit, player, position, rotation, damage, penetrated, target_type, hit_zone, impact_direction, normal, stun)
	if target_type == "character" then
		self:_player_hit_by_damaging_source(hit_unit, damage)

		local damage_ext = ScriptUnit.extension(hit_unit, "damage_system")
		local kd = damage_ext.is_knocked_down and damage_ext:is_knocked_down()
		local dead = damage_ext:is_dead()

		if stun and not kd and not dead then
			local locomotion_ext = ScriptUnit.extension(hit_unit, "locomotion_system")

			locomotion_ext:stun(hit_zone, impact_direction, "projectile_damage")
		elseif not kd and not dead then
			local locomotion_ext = ScriptUnit.extension(hit_unit, "locomotion_system")

			locomotion_ext:damage_interrupt(hit_zone, impact_direction, "projectile_damage")
		end

		if not penetrated then
			World.create_particles(world, "fx/sword_no_damage", position)
		elseif Unit.get_data(hit_unit, "soft_target") then
			World.create_particles(world, "fx/impact_blood", position)
			self:_hurt_sound_event(hit_unit, damage, world)
		else
			World.create_particles(world, "fx/arrow_hit_generic", position)
			self:_hurt_sound_event(hit_unit, damage, world)
		end

		self:_projectile_impact_sound_event(hit_unit, position, penetrated, player, world, hit_zone)
	elseif target_type == "blocking_gear" then
		World.create_particles(world, "fx/sword_sparks", position)

		local gear_owner_unit = Unit.get_data(hit_unit, "user_unit")

		Unit.animation_event(gear_owner_unit, "hit_reaction_shield_impact")
	elseif target_type == "gear" then
		World.create_particles(world, "fx/sword_sparks", position)
	elseif target_type == "prop" then
		EffectHelper.play_surface_material_effects("arrow_impact", world, hit_unit, position, rotation, normal)
	end

	Unit.flow_event(projectile_unit, "lua_hit_target")
end

function WeaponHelper:_projectile_impact_sound_event(hit_unit, position, penetrated, player, world, hit_zone)
	local timpani_world = World.timpani_world(world)

	if player and not player.remote and not player.ai_player then
		local event

		event = not (hit_zone ~= "head" and hit_zone ~= "helmet") and (penetrated and "arrow_hit_headshot" or "arrow_hit_headshot_helmet") or "arrow_hit_feedback"

		local event_id = TimpaniWorld.trigger_event(timpani_world, event)

		Managers.state.event:trigger("event_hit_marker_activated", player, Managers.player:owner(hit_unit))
	end

	local armour_type = Unit.get_data(hit_unit, "armour_type")

	if not armour_type then
		return
	end

	local armour_type_short

	if string.sub(armour_type, 0, string.len("weapon_")) == "weapon_" then
		armour_type_short = string.sub(armour_type, string.len("weapon_") + 1)
	elseif string.sub(armour_type, 0, string.len("armour_")) == "armour_" then
		armour_type_short = string.sub(armour_type, string.len("armour_") + 1)
	end

	if not armour_type_short then
		return
	end

	local damage_description = penetrated and "penetrated" or "no_damage"
	local event_id = TimpaniWorld.trigger_event(timpani_world, "arrow_hit", position)

	TimpaniWorld.set_parameter(timpani_world, event_id, "armour_type", armour_type_short)
	TimpaniWorld.set_parameter(timpani_world, event_id, "damage", damage_description)
end

function WeaponHelper:_hurt_sound_event(hit_character_unit, damage, world)
	local timpani_world = World.timpani_world(world)
	local damage_level = "light"

	if damage > DamageLevels.penetrated.heavy then
		damage_level = "heavy"
	elseif damage > DamageLevels.penetrated.medium then
		damage_level = "medium"
	end

	local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")
	local event_name = locomotion_ext:hurt_sound_event()

	if event_name then
		local hit_unit_position = Unit.world_position(hit_character_unit, 0)
		local event_id = TimpaniWorld.trigger_event(timpani_world, event_name, hit_unit_position)

		TimpaniWorld.set_parameter(timpani_world, event_id, "damage", damage_level)
		TimpaniWorld.set_parameter(timpani_world, event_id, "character_vo", locomotion_ext:inventory():voice())
	end
end

function WeaponHelper:_blood_splat_decal(world, raycast_position, raycast_direction)
	local physics_world = World.physics_world(world)
	local hit_cb = callback(self, "_blood_splat_decal_raycast_result", raycast_direction, world)
	local max_range = MaterialEffectSettings.blood_splat_raycast_max_range

	PhysicsWorld.make_raycast(physics_world, hit_cb, "closest", "types", "statics"):cast(raycast_position, raycast_direction, max_range, world)

	if script_data.debug_material_effects then
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "DEBUG_DRAW_IMPACT_DECAL_HIT"
		})

		drawer:vector(raycast_position, raycast_direction * 0.5, Color(0, 255, 0))
		drawer:sphere(raycast_position, 0.05, Color(0, 255, 0))
	end
end

function WeaponHelper:_blood_splat_decal_raycast_result(raycast_direction, world, hit, position, distance, normal, actor)
	if hit and actor then
		local unit = Actor.unit(actor)
		local rotation = Quaternion.look(-normal, Vector3.up())

		EffectHelper.play_surface_material_effects("blood_splat", world, unit, position, rotation, normal)
	elseif hit then
		print("[WeaponHelper] ERROR! Trying to project blood decal and got hit without getting actor.")

		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "DEBUG_DRAW_IMPACT_DECAL_HIT"
		})

		drawer:sphere(position, 0.1, Color(255, 105, 180))
	end
end

function WeaponHelper:_player_hit_by_damaging_source(hit_character_unit, damage, impact_direction)
	if damage > 0 then
		local locomotion_ext = ScriptUnit.extension(hit_character_unit, "locomotion_system")
		local front_back, direction

		if impact_direction then
			front_back, direction = self:_impact_direction_strings(hit_character_unit, impact_direction)
		end

		locomotion_ext:received_damage(damage, front_back, direction)
	end
end

local UP_HIT_REACTION_THRESHOLD = -math.sin(math.pi * 0.25)
local SIDE_HIT_REACTION_THRESHOLD = math.cos(math.pi * 0.3333)
local HIT_REACTION_ANIM_EVENTS = {
	front = {
		helmet = {
			down = "hurt_front_head_down",
			up = "hurt_front_head_up",
			left = "hurt_front_head_left",
			right = "hurt_front_head_right"
		},
		head = {
			down = "hurt_front_head_down",
			up = "hurt_front_head_up",
			left = "hurt_front_head_left",
			right = "hurt_front_head_right"
		},
		torso = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		},
		stomach = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		},
		arms = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		},
		forearms = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		},
		legs = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		},
		hands = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		},
		feet = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		},
		calfs = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		}
	},
	back = {
		helmet = {
			down = "hurt_back_head_down",
			up = "hurt_back_head_up",
			left = "hurt_back_head_left",
			right = "hurt_back_head_right"
		},
		head = {
			down = "hurt_back_head_down",
			up = "hurt_back_head_up",
			left = "hurt_back_head_left",
			right = "hurt_back_head_right"
		},
		torso = {
			down = "hurt_back_torso_down",
			up = "hurt_back_torso_up",
			left = "hurt_back_torso_left",
			right = "hurt_back_torso_right"
		},
		stomach = {
			down = "hurt_front_torso_down",
			up = "hurt_front_torso_up",
			left = "hurt_front_torso_left",
			right = "hurt_front_torso_right"
		},
		arms = {
			down = "hurt_back_torso_down",
			up = "hurt_back_torso_up",
			left = "hurt_back_torso_left",
			right = "hurt_back_torso_right"
		},
		forearms = {
			down = "hurt_back_torso_down",
			up = "hurt_back_torso_up",
			left = "hurt_back_torso_left",
			right = "hurt_back_torso_right"
		},
		legs = {
			down = "hurt_back_torso_down",
			up = "hurt_back_torso_up",
			left = "hurt_back_torso_left",
			right = "hurt_back_torso_right"
		},
		hands = {
			down = "hurt_back_torso_down",
			up = "hurt_back_torso_up",
			left = "hurt_back_torso_left",
			right = "hurt_back_torso_right"
		},
		feet = {
			down = "hurt_back_torso_down",
			up = "hurt_back_torso_up",
			left = "hurt_back_torso_left",
			right = "hurt_back_torso_right"
		},
		calfs = {
			down = "hurt_back_torso_down",
			up = "hurt_back_torso_up",
			left = "hurt_back_torso_left",
			right = "hurt_back_torso_right"
		}
	}
}
local UP_STUN_THRESHOLD = -math.sin(math.pi * 0.25)
local SIDE_STUN_THRESHOLD = math.cos(math.pi * 0.3333)
local STUN_ANIM_EVENTS = {
	front = {
		mounted_stun_dismount = {
			up = {
				event = "mounted_stun_land",
				duration = PlayerUnitDamageSettings.stun_dismount.duration
			},
			down = {
				event = "mounted_stun_land",
				duration = PlayerUnitDamageSettings.stun_dismount.duration
			},
			left = {
				event = "mounted_stun_land",
				duration = PlayerUnitDamageSettings.stun_dismount.duration
			},
			right = {
				event = "mounted_stun_land",
				duration = PlayerUnitDamageSettings.stun_dismount.duration
			}
		},
		mount_impact_slow = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		mount_impact_fast = {
			up = {
				event = "stun_front_legs_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_legs_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_legs_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_legs_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		shield_bash_impact = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitDamageSettings.stun_shield_bash.duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitDamageSettings.stun_shield_bash.duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitDamageSettings.stun_shield_bash.duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitDamageSettings.stun_shield_bash.duration
			}
		},
		push_impact = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitDamageSettings.stun_push.duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitDamageSettings.stun_push.duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitDamageSettings.stun_push.duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitDamageSettings.stun_push.duration
			}
		},
		rush_impact = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitMovementSettings.rush.stun_front_duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitMovementSettings.rush.stun_front_duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitMovementSettings.rush.stun_front_duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitMovementSettings.rush.stun_front_duration
			}
		},
		head = {
			up = {
				event = "stun_front_head_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_head_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_head_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_head_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		helmet = {
			up = {
				event = "stun_front_head_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_head_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_head_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_head_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		torso = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		stomach = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		arms = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		forearms = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		legs = {
			up = {
				event = "stun_front_legs_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_legs_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_legs_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_legs_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		hands = {
			up = {
				event = "stun_front_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		feet = {
			up = {
				event = "stun_front_legs_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_legs_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_legs_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_legs_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		calfs = {
			up = {
				event = "stun_front_legs_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_front_legs_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_front_legs_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_front_legs_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		}
	},
	back = {
		mounted_stun_dismount = {
			up = {
				event = "mounted_stun_land",
				duration = PlayerUnitDamageSettings.stun_dismount.duration
			},
			down = {
				event = "mounted_stun_land",
				duration = PlayerUnitDamageSettings.stun_dismount.duration
			},
			left = {
				event = "mounted_stun_land",
				duration = PlayerUnitDamageSettings.stun_dismount.duration
			},
			right = {
				event = "mounted_stun_land",
				duration = PlayerUnitDamageSettings.stun_dismount.duration
			}
		},
		mount_impact_slow = {
			up = {
				event = "stun_back_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		mount_impact_fast = {
			up = {
				event = "stun_back_legs_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_legs_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_legs_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_legs_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		shield_bash_impact = {
			up = {
				event = "stun_back_torso_up",
				duration = PlayerUnitDamageSettings.stun_shield_bash.duration
			},
			down = {
				event = "stun_back_torso_down",
				duration = PlayerUnitDamageSettings.stun_shield_bash.duration
			},
			left = {
				event = "stun_back_torso_left",
				duration = PlayerUnitDamageSettings.stun_shield_bash.duration
			},
			right = {
				event = "stun_back_torso_right",
				duration = PlayerUnitDamageSettings.stun_shield_bash.duration
			}
		},
		push_impact = {
			up = {
				event = "stun_back_torso_up",
				duration = PlayerUnitDamageSettings.stun_push.duration
			},
			down = {
				event = "stun_back_torso_down",
				duration = PlayerUnitDamageSettings.stun_push.duration
			},
			left = {
				event = "stun_back_torso_left",
				duration = PlayerUnitDamageSettings.stun_push.duration
			},
			right = {
				event = "stun_back_torso_right",
				duration = PlayerUnitDamageSettings.stun_push.duration
			}
		},
		rush_impact = {
			up = {
				event = "stun_front_legs_up",
				duration = PlayerUnitMovementSettings.rush.stun_back_duration
			},
			down = {
				event = "stun_front_legs_down",
				duration = PlayerUnitMovementSettings.rush.stun_back_duration
			},
			left = {
				event = "stun_front_legs_right",
				duration = PlayerUnitMovementSettings.rush.stun_back_duration
			},
			right = {
				event = "stun_front_legs_left",
				duration = PlayerUnitMovementSettings.rush.stun_back_duration
			}
		},
		head = {
			up = {
				event = "stun_back_head_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_head_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_head_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_head_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		helmet = {
			up = {
				event = "stun_back_head_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_head_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_head_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_head_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		torso = {
			up = {
				event = "stun_back_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		stomach = {
			up = {
				event = "stun_back_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		arms = {
			up = {
				event = "stun_back_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		forearms = {
			up = {
				event = "stun_back_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		legs = {
			up = {
				event = "stun_back_legs_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_legs_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_legs_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_legs_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		hands = {
			up = {
				event = "stun_back_torso_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_torso_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_torso_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_torso_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		feet = {
			up = {
				event = "stun_back_legs_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_legs_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_legs_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_legs_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		},
		calfs = {
			up = {
				event = "stun_back_legs_up",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			down = {
				event = "stun_back_legs_down",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			left = {
				event = "stun_back_legs_left",
				duration = PlayerUnitDamageSettings.stun.duration
			},
			right = {
				event = "stun_back_legs_right",
				duration = PlayerUnitDamageSettings.stun.duration
			}
		}
	}
}

function WeaponHelper:player_unit_hit_reaction_animation(unit, hit_zone, impact_direction, aim_direction)
	if script_data.impact_direction_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "weapon"
		})

		drawer:vector(Unit.world_position(unit, 0), impact_direction, Color(255, 0, 0))
	end

	local flat_aim_dir = Vector3.normalize(Vector3.flat(aim_direction))
	local flat_impact_dir = Vector3.normalize(Vector3.flat(impact_direction))
	local up = impact_direction.z < UP_HIT_REACTION_THRESHOLD
	local front_back = Vector3.dot(flat_impact_dir, flat_aim_dir) > 0 and "back" or "front"
	local anim_event

	if up then
		anim_event = HIT_REACTION_ANIM_EVENTS[front_back][hit_zone].up
	else
		local aim_right = Vector3.cross(flat_aim_dir, Vector3.up())
		local damage_dot = Vector3.dot(aim_right, flat_impact_dir)
		local direction = damage_dot > SIDE_HIT_REACTION_THRESHOLD and "left" or damage_dot < -SIDE_HIT_REACTION_THRESHOLD and "right" or "down"

		anim_event = HIT_REACTION_ANIM_EVENTS[front_back][hit_zone][direction]
	end

	Unit.animation_event(unit, anim_event)
end

function WeaponHelper:player_unit_stun_animation(unit, hit_zone, impact_direction)
	if script_data.impact_direction_debug then
		local drawer = Managers.state.debug:drawer({
			mode = "retained",
			name = "weapon"
		})

		drawer:vector(Unit.world_position(unit, 0), impact_direction, Color(255, 0, 0))
	end

	local unit_rot = Unit.world_rotation(unit, 0)
	local unit_forward = Quaternion.forward(unit_rot)
	local flat_impact_dir = Vector3.normalize(Vector3.flat(impact_direction))
	local up = impact_direction.z < UP_STUN_THRESHOLD
	local front_back = Vector3.dot(flat_impact_dir, unit_forward) > 0 and "back" or "front"
	local anim_event, anim_time

	if up then
		local stun = STUN_ANIM_EVENTS[front_back][hit_zone].up

		anim_event = stun.event
		anim_time = stun.duration
	else
		local unit_right = Quaternion.right(unit_rot)
		local damage_dot = Vector3.dot(unit_right, flat_impact_dir)
		local direction = damage_dot > SIDE_STUN_THRESHOLD and "left" or damage_dot < -SIDE_STUN_THRESHOLD and "right" or "down"
		local stun = STUN_ANIM_EVENTS[front_back][hit_zone][direction]

		anim_event = stun.event
		anim_time = stun.duration
	end

	return anim_event, anim_time
end

function WeaponHelper:_impact_direction_strings(unit, impact_direction)
	local unit_rot = Unit.world_rotation(unit, 0)
	local unit_forward = Quaternion.forward(unit_rot)
	local flat_impact_dir = Vector3.normalize(Vector3.flat(impact_direction))
	local unit_right = Quaternion.right(unit_rot)
	local damage_dot = Vector3.dot(unit_right, flat_impact_dir)
	local front_back = Vector3.dot(flat_impact_dir, unit_forward) > 0 and "back" or "front"
	local direction = impact_direction.z < UP_STUN_THRESHOLD and "up" or damage_dot > SIDE_STUN_THRESHOLD and "left" or damage_dot < -SIDE_STUN_THRESHOLD and "right" or "down"

	return front_back, direction
end

function WeaponHelper:_hit_sound_event(world, weapon_unit, hit_unit, hit_unit_type, damage, damage_without_armor, attack_name)
	local weapon_gear_name = Unit.get_data(weapon_unit, "gear_name")
	local damage_type = Gear[weapon_gear_name].attacks[attack_name].damage_type
	local armour_type_short = self:_armour_type_sound_parameter(hit_unit)
	local damage_level, damage_description

	if damage > 0 then
		damage_level = damage > DamageLevels.penetrated.heavy and "heavy" or damage > DamageLevels.penetrated.medium and "medium" or "light"
		damage_description = "penetrated"
	else
		damage_level = damage_without_armor > DamageLevels.no_damage.heavy and "heavy" or "light"
		damage_description = "no_damage"
	end

	WeaponHelper:_play_melee_hit_sound_event(hit_unit, weapon_unit, world, damage_type, armour_type_short, damage_level, damage_description)
end

local SHORT_ARMOUR_TYPES = {
	armour_mail = "mail",
	weapon_metal = "metal",
	weapon_wood = "wood",
	armour_cloth = "cloth",
	armour_plate = "plate",
	armour_leather = "leather",
	none = "none"
}
local SHAFT_TYPES = {
	metal = "metal_shaft",
	wood = "wood_shaft"
}

function WeaponHelper:_armour_type_sound_parameter(unit)
	local armour_type = Unit.get_data(unit, "armour_type")
	local armour_type_short = SHORT_ARMOUR_TYPES[armour_type]

	fassert(armour_type_short, "[WeaponHelper:_hit_sound_event()] Hit unit %q with incorrect armour_type %q", unit, armour_type)

	return armour_type_short
end

function WeaponHelper:_play_melee_hit_sound_event(hit_unit, weapon_unit, world, damage_type, armour_type_short, damage_level, damage_description)
	local event_id
	local timpani_world = World.timpani_world(world)
	local attacker_is_husk = Unit.get_data(weapon_unit, "husk") or Unit.get_data(weapon_unit, "ai_gear")
	local victim_is_local = false
	local unit_owner = Managers.player:owner(hit_unit)

	if unit_owner then
		victim_is_local = unit_owner.local_player
	end

	local melee_hit_sound_event = Unit.get_data(hit_unit, "melee_hit_sound_event")

	if melee_hit_sound_event then
		event_id = TimpaniWorld.trigger_event(timpani_world, melee_hit_sound_event, weapon_unit)
	elseif damage_level == "heavy" then
		local event = victim_is_local and "melee_hit_heavy_self" or attacker_is_husk and "melee_hit_heavy_husk" or "melee_hit_heavy"

		event_id = TimpaniWorld.trigger_event(timpani_world, event, weapon_unit)
	else
		local event = victim_is_local and "melee_hit_self" or attacker_is_husk and "melee_hit_husk" or "melee_hit"

		event_id = TimpaniWorld.trigger_event(timpani_world, event, weapon_unit)
	end

	if event_id then
		local melee_hit_damage_type = Unit.get_data(weapon_unit, "melee_hit_damage_type")

		if melee_hit_damage_type then
			TimpaniWorld.set_parameter(timpani_world, event_id, "damage_type", melee_hit_damage_type)
		else
			TimpaniWorld.set_parameter(timpani_world, event_id, "damage_type", damage_type)
		end

		TimpaniWorld.set_parameter(timpani_world, event_id, "armour_type", armour_type_short)

		if damage_level then
			TimpaniWorld.set_parameter(timpani_world, event_id, "damage_level", damage_level)
		end

		if damage_description then
			TimpaniWorld.set_parameter(timpani_world, event_id, "damage", damage_description)
		end
	else
		print("[WeaponHelper:_hit_sound_event] missing melee_hit sound event for:", weapon_unit)
	end

	if script_data.sound_debug then
		print("damage_type: " .. tostring(damage_type) .. "  armour_type: " .. tostring(armour_type_short) .. "  damage_level: " .. tostring(damage_level) .. "  damage: " .. tostring(damage_description))
	end
end

function WeaponHelper:shaft_damage_type(weapon_unit)
	return SHAFT_TYPES[self:_armour_type_sound_parameter(weapon_unit)]
end

function WeaponHelper:non_damage_hit_sound_event(world, weapon_unit, hit_unit)
	local armour_type_short = self:_armour_type_sound_parameter(hit_unit)
	local damage_type = self:shaft_damage_type(weapon_unit)

	WeaponHelper:_play_melee_hit_sound_event(hit_unit, weapon_unit, world, damage_type, armour_type_short)
end

function WeaponHelper:melee_weapon_velocity(weapon_unit, attack_name, attack_time, attachment_multipliers, duration)
	if attack_name == "couch" then
		local attack_settings = Unit.get_data(weapon_unit, "attacks")[attack_name]
		local forward_direction = attack_settings.forward_direction:unbox()
		local rotation = Unit.world_rotation(weapon_unit, 0)
		local direction = Quaternion.rotate(rotation, forward_direction)
		local velocity = direction * attachment_multipliers.lance_speed_max

		return velocity
	end

	local attack_settings = Unit.get_data(weapon_unit, "attacks")[attack_name]
	local speed_func = attack_settings.speed_function
	local speed_max = attack_settings.speed_max * attachment_multipliers.lance_speed_max
	local forward_direction = attack_settings.forward_direction:unbox()
	local t = math.min(attack_time, duration) / duration
	local speed = AttackSpeedFunctions[speed_func](t, speed_max)
	local rotation = Unit.world_rotation(weapon_unit, 0)
	local direction = Quaternion.rotate(rotation, forward_direction)
	local velocity = speed * direction

	return velocity
end

function WeaponHelper:calculate_melee_damage(attacker_velocity, weapon_velocity, victim_velocity, weapon_unit, attacker_unit, victim_unit, attack_name, damage_type, charge_time, actor, attachment_multipliers, properties, impact_direction)
	local attack_settings = Unit.get_data(weapon_unit, "attacks")[attack_name]
	local impact_speed = self:_weapon_impact_speed(attacker_velocity, weapon_velocity, victim_velocity)
	local base_damage = attack_settings.base_damage * (DamageDirectionDebugMultipliers[attack_name] or 1)
	local damage_range_type = attack_settings.damage_range_type
	local charge_value = attack_name == "couch" and 1 or charge_time and math.min(1, attack_settings.uncharged_damage_factor + (1 - attack_settings.uncharged_damage_factor) * (charge_time / attack_settings.charge_time)) or 1
	local weapon_speed_max = attack_settings.speed_max * attachment_multipliers.lance_speed_max
	local hit_zones = Unit.get_data(victim_unit, "hit_zone_lookup_table")
	local hit_zone_hit = hit_zones and hit_zones[actor]
	local hit_zone_multiplier = hit_zone_hit and hit_zone_hit.damage_multiplier or 1
	local armour_type, penetration_value, absorption_value = self:_armour_values(victim_unit, hit_zone_hit, actor, impact_direction)
	local penetration_coefficient = self:_weapon_has_property(properties, "penetration") and PenetrationPropertyMultipliers[damage_type].penetration_multipliers[armour_type] * DamageTypes[damage_type].penetration_modifiers[armour_type] or DamageTypes[damage_type].penetration_modifiers[armour_type]
	local damage_without_armor = base_damage * charge_value * math.pow(impact_speed, 2) / math.pow(weapon_speed_max, 2)
	local penetrated
	local absorption_coefficient = DamageTypes[damage_type].absorption_modifiers[armour_type]
	local damage = damage_without_armor - damage_without_armor * absorption_value * absorption_coefficient

	if damage > penetration_value * penetration_coefficient then
		penetrated = true
		damage = damage * hit_zone_multiplier
	else
		penetrated = false
		damage = 0
	end

	if script_data.damage_debug then
		self:_debug_melee_damage(base_damage, charge_value, impact_speed, weapon_speed_max, damage_without_armor, penetration_value, penetration_coefficient, penetrated, actor, hit_zone_multiplier, absorption_value, absorption_coefficient, damage)
	end

	return damage, damage_range_type, damage_without_armor, penetrated
end

function WeaponHelper:calculate_perk_attack_damage(weapon_unit, attacker_unit, victim_unit, attack_name, damage_type, charge_time, actor, impact_direction)
	local attack_settings = Unit.get_data(weapon_unit, "attacks")[attack_name]
	local base_damage = attack_settings.base_damage
	local damage_range_type = attack_settings.damage_range_type
	local hit_zones = Unit.get_data(victim_unit, "hit_zone_lookup_table")
	local hit_zone_hit = hit_zones and hit_zones[actor]
	local hit_zone_multiplier = hit_zone_hit and hit_zone_hit.damage_multiplier or 1
	local armour_type, penetration_value, absorption_value = self:_armour_values(victim_unit, hit_zone_hit, actor, impact_direction)
	local penetration_coefficient = DamageTypes[damage_type].penetration_modifiers[armour_type]
	local charge_value = charge_time and charge_time > 0 and math.min(1, attack_settings.uncharged_damage_factor + (1 - attack_settings.uncharged_damage_factor) * (charge_time / attack_settings.charge_time)) or 1
	local damage_without_armor = base_damage * charge_value
	local absorption_coefficient = DamageTypes[damage_type].absorption_modifiers[armour_type]
	local damage = base_damage - damage_without_armor * absorption_value * absorption_coefficient
	local penetrated

	if damage > penetration_value * penetration_coefficient then
		penetrated = true
	else
		penetrated = false
		damage = 0
	end

	return damage, damage_range_type, damage_without_armor, penetrated
end

function WeaponHelper:calculate_projectile_damage(attacker_velocity, weapon_velocity, victim_velocity, firing_gear_name, projectile_unit, victim_unit, projectile_name, actor, position, normal, impact_direction, properties, damage_multiplier)
	local attack_settings = Gear[firing_gear_name].attacks.ranged
	local projectile_settings = self:attachment_settings(firing_gear_name, "projectile_head", projectile_name)
	local impact_speed = self:_weapon_impact_speed(attacker_velocity, weapon_velocity, victim_velocity)
	local base_damage = attack_settings.base_damage
	local damage_type = projectile_settings.damage_type
	local damage_range_type = attack_settings.damage_range_type
	local weapon_speed_max = attack_settings.speed_max
	local hit_zones = Unit.get_data(victim_unit, "hit_zone_lookup_table")
	local hit_zone_hit = hit_zones and hit_zones[actor]
	local hit_zone_multiplier = hit_zone_hit and (hit_zone_hit.damage_multiplier_ranged or hit_zone_hit.damage_multiplier) or 1
	local armour_type, penetration_value, absorption_value = self:_armour_values(victim_unit, hit_zone_hit, actor, impact_direction)
	local impact_dot = Vector3.dot(normal, impact_direction)
	local scaled_penetration_value

	if impact_dot > 0 then
		scaled_penetration_value = 10 * penetration_value
	else
		local angle = math.acos(-impact_dot)
		local val = math.max((angle - math.pi * 0.25) * 2, 0)

		scaled_penetration_value = math.min(penetration_value + math.tan(val) * penetration_value, 10 * penetration_value)
	end

	local penetration_property_multiplier = self:_weapon_has_property(properties, "penetration") and PenetrationPropertyMultipliers[damage_type].penetration_multipliers[armour_type] or 1
	local penetration_coefficient = penetration_property_multiplier * DamageTypes[damage_type].penetration_modifiers[armour_type]
	local damage_without_armor = base_damage * damage_multiplier * math.pow(impact_speed, 2) / math.pow(weapon_speed_max, 2)
	local damage, absorption_coefficient, penetrated

	absorption_coefficient = DamageTypes[damage_type].absorption_modifiers[armour_type]
	damage = damage_without_armor - damage_without_armor * absorption_value * absorption_coefficient

	if damage > penetration_value * penetration_coefficient then
		penetrated = true
		damage = damage * hit_zone_multiplier
	else
		penetrated = false
		damage = 0
	end

	if script_data.damage_debug then
		self:_debug_projectile_damage(base_damage, impact_speed, weapon_speed_max, damage_without_armor, penetration_value, penetration_coefficient, penetrated, actor, hit_zone_multiplier, absorption_value, absorption_coefficient, damage, scaled_penetration_value)
		self:_debug_projectile_penetration(position, normal, impact_direction)
	end

	return damage, damage_range_type, penetrated
end

function WeaponHelper:_debug_projectile_penetration(position, normal, impact_direction)
	local drawer = Managers.state.debug:drawer({
		mode = "retained",
		name = "weapon"
	})

	drawer:vector(position, normal * 0.25, Color(255, 255, 0))
	drawer:vector(position, impact_direction * 0.25, Color(255, 0, 0))
end

function WeaponHelper:calculate_handgonne_damage(weapon_unit, attacker_unit, victim_unit, projectile_name, actor, properties, impact_direction, distance, weapon_settings, projectile_settings)
	local attack_settings = Unit.get_data(weapon_unit, "attacks").ranged
	local weapon_name = Unit.get_data(weapon_unit, "gear_name")
	local base_damage = attack_settings.base_damage * attack_settings.damage_function(distance, weapon_settings, projectile_settings)
	local damage_type = projectile_settings.damage_type
	local damage_range_type = attack_settings.damage_range_type
	local hit_zones = Unit.get_data(victim_unit, "hit_zone_lookup_table")
	local hit_zone_hit = hit_zones and hit_zones[actor]
	local hit_zone_multiplier = hit_zone_hit and hit_zone_hit.damage_multiplier or 1
	local armour_type, penetration_value, absorption_value = self:_armour_values(victim_unit, hit_zone_hit, actor, impact_direction)
	local penetration_coefficient = self:_weapon_has_property(properties, "penetration") and PenetrationPropertyMultipliers[damage_type].penetration_multipliers[armour_type] * DamageTypes[damage_type].penetration_modifiers[armour_type] or DamageTypes[damage_type].penetration_modifiers[armour_type]
	local damage_without_armor = base_damage
	local damage, absorption_coefficient, penetrated

	absorption_coefficient = DamageTypes[damage_type].absorption_modifiers[armour_type]
	damage = damage_without_armor - damage_without_armor * absorption_value * absorption_coefficient

	if damage > penetration_value * penetration_coefficient then
		penetrated = true
		damage = damage * hit_zone_multiplier
	else
		penetrated = false
		damage = 0
	end

	if script_data.damage_debug then
		self:_debug_handgonne_damage(base_damage, damage_without_armor, penetration_value, penetration_coefficient, penetrated, actor, hit_zone_multiplier, absorption_value, absorption_coefficient, damage)
	end

	local stun = false

	if self:_weapon_has_property(properties, "stun") and PlayerUnitDamageSettings.stun.damage_types_with_stun_property[damage_type] then
		stun = damage_without_armor > PlayerUnitDamageSettings.stun.damage_threshold_with_stun_property
	elseif PlayerUnitDamageSettings.stun.damage_types_without_stun_property[damage_type] then
		stun = damage_without_armor > PlayerUnitDamageSettings.stun.damage_threshold
	end

	return damage, damage_range_type, stun, hit_zone_hit and hit_zone_hit.name
end

function WeaponHelper:hit_zone(unit, actor)
	local hit_zones = Unit.get_data(unit, "hit_zone_lookup_table")
	local hit_zone_hit = hit_zones and hit_zones[actor] and hit_zones[actor].name

	return hit_zone_hit
end

function WeaponHelper:_weapon_impact_speed(attacker_velocity, weapon_velocity, victim_velocity)
	local weapon_speed = Vector3.length(weapon_velocity)
	local weapon_direction = Vector3.normalize(weapon_velocity)
	local attacker_speed = Vector3.dot(attacker_velocity, weapon_direction)
	local victim_speed = Vector3.dot(victim_velocity, weapon_direction)
	local impact_speed = math.max(weapon_speed + attacker_speed - victim_speed, 0)

	return impact_speed
end

function WeaponHelper:_armour_values(victim_unit, hit_zone_hit, actor, impact_direction)
	local armour_type, penetration_value, absorption_value, inventory

	if ScriptUnit.has_extension(victim_unit, "locomotion_system") then
		local locomotion_ext = ScriptUnit.extension(victim_unit, "locomotion_system")

		inventory = locomotion_ext.inventory and locomotion_ext:inventory()
	end

	if inventory then
		local actor_forward

		fassert(hit_zone_hit, "Unit %s, Actor %s", victim_unit, actor)

		local forward = hit_zone_hit.forward
		local actor_rotation = Actor.rotation(actor)

		actor_forward = forward.x * Quaternion.right(actor_rotation) + forward.y * Quaternion.forward(actor_rotation) + forward.z * Quaternion.up(actor_rotation)

		if script_data.armor_debug then
			local drawer = Managers.state.debug:drawer({
				mode = "retained",
				name = "armor_debug"
			})

			drawer:reset()
			drawer:quaternion(Actor.position(actor), Actor.rotation(actor))
		end

		armour_type, penetration_value, absorption_value = inventory:armour_values(hit_zone_hit and hit_zone_hit.name, Vector3.dot(actor_forward, impact_direction) > 0)
	else
		armour_type = Unit.get_data(victim_unit, "armour_type") or "none"
		penetration_value = Unit.get_data(victim_unit, "penetration_value") or 0
		absorption_value = Unit.get_data(victim_unit, "absorption_value") or 0
	end

	local locomotion = ScriptUnit.has_extension(victim_unit, "locomotion_system") and ScriptUnit.extension(victim_unit, "locomotion_system") or nil
	local area_buff_ext = ScriptUnit.has_extension(victim_unit, "area_buff_system") and ScriptUnit.extension(victim_unit, "area_buff_system") or nil
	local absorption_multiplier = locomotion and locomotion:has_perk("thick_skinned") and Perks.thick_skinned.absorption_multiplier or 1

	absorption_multiplier = area_buff_ext and absorption_multiplier * area_buff_ext:buff_multiplier("armour") or absorption_multiplier

	return armour_type, penetration_value, absorption_value * absorption_multiplier
end

function WeaponHelper:_debug_melee_damage(base_damage, charge_value, impact_speed, weapon_speed_max, damage_without_armor, penetration_value, penetration_coefficient, penetrated, actor, hit_zone_multiplier, absorption_value, absorption_coefficient, damage)
	print("*** DAMAGE DEBUG START ***************************")
	print("base_damage = " .. base_damage)
	print("charge_value = " .. charge_value)
	print("impact_speed = " .. impact_speed)
	print("weapon_speed_max = " .. weapon_speed_max)
	print("damage_without_armor = " .. damage_without_armor .. " = base_damage * charge_value * math.pow( impact_speed, 2 ) / math.pow( weapon_speed_max, 2 )")
	print("penetration_value = " .. penetration_value)
	print("penetration_coefficient = " .. penetration_coefficient)

	if penetrated then
		print("ARMOUR PENETRATED")
		print("actor = " .. tostring(actor))
		print("hit_zone_multiplier = " .. hit_zone_multiplier)
		print("absorption_value = " .. absorption_value)
		print("absorption_coefficient = " .. absorption_coefficient)
		print("damage = " .. damage .. " = hit_zone_multiplier * ( damage_without_armor  - ( absorption_value * absorption_coefficient ) )")
	else
		print("ARMOUR NOT PENETRATED")
		print("damage = " .. damage)
	end

	print("*** DAMAGE DEBUG END ****************************")
end

function WeaponHelper:_debug_projectile_damage(base_damage, impact_speed, weapon_speed_max, damage_without_armor, penetration_value, penetration_coefficient, penetrated, actor, hit_zone_multiplier, absorption_value, absorption_coefficient, damage, scaled_penetration_value)
	print("*** DAMAGE DEBUG START ***************************")
	print("base_damage = " .. base_damage)
	print("impact_speed = " .. impact_speed)
	print("weapon_speed_max = " .. weapon_speed_max)
	print("damage_without_armor = " .. damage_without_armor .. " = base_damage * math.pow( impact_speed, 2 ) / math.pow( weapon_speed_max, 2 )")
	print("penetration_value = " .. penetration_value)
	print("penetration_coefficient = " .. penetration_coefficient)
	print("impact_angle_scaled_penetration_value = " .. scaled_penetration_value)

	if penetrated then
		print("ARMOUR PENETRATED")
		print("actor = " .. tostring(actor))
		print("hit_zone_multiplier = " .. hit_zone_multiplier)
		print("absorption_value = " .. absorption_value)
		print("absorption_coefficient = " .. absorption_coefficient)
		print("damage = " .. damage .. " = hit_zone_multiplier * ( damage_without_armor  - ( absorption_value * absorption_coefficient ) )")
	else
		print("ARMOUR NOT PENETRATED")
		print("damage = " .. damage)
	end

	print("*** DAMAGE DEBUG END ****************************")
end

function WeaponHelper:_debug_handgonne_damage(base_damage, damage_without_armor, penetration_value, penetration_coefficient, penetrated, actor, hit_zone_multiplier, absorption_value, absorption_coefficient, damage)
	print("*** DAMAGE DEBUG START ***************************")
	print("base_damage = " .. base_damage)
	print("damage_without_armor = " .. damage_without_armor .. " = base_damage")
	print("penetration_value = " .. penetration_value)
	print("penetration_coefficient = " .. penetration_coefficient)

	if penetrated then
		print("ARMOUR PENETRATED")
		print("actor = " .. tostring(actor))
		print("hit_zone_multiplier = " .. hit_zone_multiplier)
		print("absorption_value = " .. absorption_value)
		print("absorption_coefficient = " .. absorption_coefficient)
		print("damage = " .. damage .. " = hit_zone_multiplier * ( damage_without_armor  - ( absorption_value * absorption_coefficient ) )")
	else
		print("ARMOUR NOT PENETRATED")
		print("damage = " .. damage)
	end

	print("*** DAMAGE DEBUG END ****************************")
end

function WeaponHelper:projectile_fire_position_from_camera(weapon_unit, user_unit, projectile_name)
	local attack_settings = Unit.get_data(weapon_unit, "attacks").ranged
	local weapon_name = Unit.get_data(weapon_unit, "gear_name")
	local projectile_settings = self:attachment_settings(weapon_name, "projectile_head", projectile_name)
	local parent_link_node_name = projectile_settings.parent_link_node
	local parent_link_node = Unit.node(user_unit, parent_link_node_name)
	local projectile_position = Unit.world_position(user_unit, parent_link_node)
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(user_unit, "viewport_name")
	local camera_position = camera_manager:camera_position(viewport_name)
	local camera_rotation = camera_manager:camera_rotation(viewport_name)
	local camera_forward = Quaternion.forward(camera_rotation)

	if script_data.weapon_debug then
		local dot = Vector3.dot(projectile_position - camera_position, camera_forward)

		print("projectile_release_distance: " .. dot)
	end

	local position = camera_position + camera_forward * attack_settings.projectile_release_distance

	return position
end

function WeaponHelper:handgonne_fire_position_from_camera(gear_unit, user_unit, muzzle_position, max_bullet_spread)
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(user_unit, "viewport_name")
	local camera_position = camera_manager:camera_position(viewport_name)
	local camera_rotation = camera_manager:camera_rotation(viewport_name)
	local camera_forward = Quaternion.forward(camera_rotation)
	local resultant_vector = muzzle_position - camera_position
	local resultant_distance = Vector3.dot(resultant_vector, camera_forward)
	local relative_position = resultant_distance * camera_forward
	local raycast_position = relative_position + camera_position
	local direction = self:_add_spread(camera_rotation, max_bullet_spread, user_unit)

	return raycast_position, direction
end

function WeaponHelper:handgonne_fire_position_from_handgonne(gear_unit, user_unit, muzzle_position, max_bullet_spread)
	local locomotion_ext = ScriptUnit.extension(user_unit, "locomotion_system")
	local look_target = locomotion_ext:look_target()
	local resultant_vector = look_target - muzzle_position
	local rotation = Quaternion.look(resultant_vector, Vector3.up())
	local direction = self:_add_spread(rotation, max_bullet_spread, user_unit)

	return muzzle_position, direction
end

function WeaponHelper:_add_spread(rotation, max_spread_angle, user_unit)
	local locomotion_ext = ScriptUnit.extension(user_unit, "locomotion_system")
	local spread_multiplier = locomotion_ext:has_perk("handgonner_training") and Perks.handgonner_training.spread_multiplier or 1
	local spread_angle = math.random() * (max_spread_angle / 180) * math.pi * spread_multiplier
	local rand_roll = math.random() * math.pi * 2
	local roll_rotation = Quaternion(Vector3.forward(), rand_roll)
	local pitch_rotation = Quaternion(Vector3.right(), spread_angle)
	local final_rotation = Quaternion.multiply(Quaternion.multiply(rotation, roll_rotation), pitch_rotation)
	local fire_dir = Quaternion.forward(final_rotation)

	return fire_dir
end

function WeaponHelper:bow_projectile_fire_velocity_from_camera(weapon_unit, user_unit, draw_time, draw_time_loss)
	local attack_settings = Unit.get_data(weapon_unit, "attacks").ranged
	local settings
	local speed_func = attack_settings.speed_function
	local speed_max = attack_settings.speed_max
	local locomotion_ext = ScriptUnit.extension(user_unit, "locomotion_system")
	local draw_time_multiplier = locomotion_ext:has_perk("longbowman") and Perks.longbowman.draw_time_multiplier or 1
	local draw_max_time = attack_settings.bow_draw_time * draw_time_multiplier + attack_settings.bow_tense_time
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(user_unit, "viewport_name")
	local camera_position = camera_manager:camera_position(viewport_name)
	local camera_rotation = camera_manager:camera_rotation(viewport_name)
	local final_draw_time = math.min(draw_time, draw_max_time) - draw_time_loss
	local t = math.min(final_draw_time, draw_max_time) / draw_max_time
	local speed = AttackSpeedFunctions[speed_func](t, speed_max)
	local pitch = attack_settings.projectile_release_pitch * math.pi / 180
	local rotation = Quaternion.multiply(camera_rotation, Quaternion(Vector3(1, 0, 0), pitch))
	local direction = Quaternion.forward(rotation)
	local velocity = speed * direction

	return velocity, direction
end

function WeaponHelper:crossbow_projectile_fire_velocity_from_camera(weapon_unit, user_unit)
	local attack_settings = Unit.get_data(weapon_unit, "attacks").ranged
	local speed_max = attack_settings.speed_max
	local camera_manager = Managers.state.camera
	local viewport_name = Unit.get_data(user_unit, "viewport_name")
	local camera_position = camera_manager:camera_position(viewport_name)
	local camera_rotation = camera_manager:camera_rotation(viewport_name)
	local pitch = attack_settings.projectile_release_pitch * math.pi / 180
	local rotation = Quaternion.multiply(camera_rotation, Quaternion(Vector3(1, 0, 0), pitch))
	local direction = Quaternion.forward(rotation)
	local velocity = speed_max * direction

	fassert(Vector3.length(velocity) < 200, "Speed_max = %f, direction = %s, pitch = %f, rotation = %s, direction = %s, camera_rotation = %s", speed_max, direction, pitch, rotation, direction, camera_rotation)

	return velocity, direction
end

function WeaponHelper:projectile_fire_position_from_ranged_weapon(weapon_unit, user_unit, projectile_name)
	local weapon_name = Unit.get_data(weapon_unit, "gear_name")
	local projectile_settings = self:attachment_settings(weapon_name, "projectile_head", projectile_name)
	local parent_link_node_name = projectile_settings.parent_link_node
	local parent_link_node = Unit.node(user_unit, parent_link_node_name)
	local projectile_position = Unit.world_position(user_unit, parent_link_node)

	return projectile_position
end

function WeaponHelper:projectile_fire_velocity_from_bow(weapon_unit, aim_direction, draw_time)
	local attack_settings = Unit.get_data(weapon_unit, "attacks").ranged
	local speed_func = attack_settings.speed_function
	local speed_max = attack_settings.speed_max
	local draw_max_time = attack_settings.bow_draw_time + attack_settings.bow_tense_time
	local t = 1
	local speed = AttackSpeedFunctions[speed_func](t, speed_max)

	return speed * aim_direction
end

function WeaponHelper:wanted_projectile_angle(distance_vector, projectile_gravity, projectile_speed)
	local x = Vector3.length(Vector3.flat(distance_vector))
	local y = distance_vector.z
	local g = projectile_gravity
	local v = projectile_speed
	local aux = x^2 - g^2 * x^4 / v^4 + 2 * g * x^2 * y / v^2

	if aux >= 0 then
		local angle_1 = math.atan(v^2 * (-x + math.sqrt(aux)) / (g * x^2))
		local angle_2 = math.atan(v^2 * (-x - math.sqrt(aux)) / (g * x^2))

		return angle_1, angle_2
	end
end

function WeaponHelper:wanted_projectile_speed(distance_vector, projectile_gravity, wanted_angle)
	local x = Vector3.length(Vector3.flat(distance_vector))
	local y = distance_vector.z
	local g = math.abs(projectile_gravity)
	local aux = g / (2 * (x * math.tan(wanted_angle) - y))

	if aux >= 0 then
		return x / math.cos(wanted_angle) * math.sqrt(aux)
	end
end

function WeaponHelper:remove_projectiles(unit)
	local projectiles = Unit.get_data(unit, "linked_dummy_projectiles")

	if projectiles then
		for _, projectile_unit in ipairs(projectiles) do
			if Unit.alive(projectile_unit) then
				Managers.state.projectile:remove_linked_projectile(projectile_unit)
			end
		end
	end
end

function WeaponHelper:add_damage(world, victim_unit, player, player_unit, damage_type, damage, position, normal, actor, damage_range_type, gear_name, hit_zone, impact_direction, real_damage, show_damage, range)
	local network_manager = Managers.state.network

	real_damage = real_damage or damage

	local damage_extension = ScriptUnit.has_extension(victim_unit, "damage_system") and ScriptUnit.extension(victim_unit, "damage_system")
	local friendly_fire_multiplier = Managers.state.team:friendly_fire_multiplier(player_unit, victim_unit, damage_range_type)
	local ff_damage = friendly_fire_multiplier * damage
	local hit_zones = Unit.get_data(victim_unit, "hit_zone_lookup_table")
	local hit_zone_hit = hit_zones and hit_zones[actor]
	local armour_type = self:_armour_values(victim_unit, hit_zone_hit, actor, impact_direction)

	if network_manager:game() then
		local victim_obj_id = network_manager:unit_game_object_id(victim_unit)
		local player_obj_id = network_manager:unit_game_object_id(player_unit)
		local player_id = player:player_id()

		damage = math.clamp(damage, NetworkConstants.damage.min, NetworkConstants.damage.max)
		real_damage = math.clamp(real_damage, NetworkConstants.damage.min, NetworkConstants.damage.max)

		if show_damage then
			if damage_range_type == "small_projectile" and Managers.lobby.server and (not damage_extension or not damage_extension.can_receive_damage or damage_extension:can_receive_damage(player_unit, damage_range_type)) then
				local player_network_id = player:network_id()

				RPC.rpc_show_ranged_damage_number(player_network_id, player_id, NetworkLookup.damage_types[damage_type], ff_damage, position, NetworkLookup.damage_range_types[damage_range_type], impact_direction, NetworkLookup.armour_types[armour_type])
			elseif not damage_extension or not damage_extension.can_receive_damage or damage_extension:can_receive_damage(player_unit, damage_range_type) then
				Managers.state.event:trigger("show_damage_number", player, damage_type, ff_damage, position, damage_range_type, impact_direction, armour_type)
			end
		end

		if victim_obj_id then
			network_manager:send_rpc_server("rpc_add_damage", player_id, player_obj_id, victim_obj_id, NetworkLookup.damage_types[damage_type], damage, position, normal, NetworkLookup.damage_range_types[damage_range_type], NetworkLookup.gear_names[gear_name], NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction, real_damage, range or 0)

			return
		end

		local current_level = LevelHelper:current_level(world)
		local victim_lvl_id = Level.unit_index(current_level, victim_unit)

		if victim_lvl_id then
			network_manager:send_rpc_server("rpc_add_generic_damage", player_id, player_obj_id, victim_lvl_id, NetworkLookup.damage_types[damage_type], damage, position, normal, NetworkLookup.damage_range_types[damage_range_type], NetworkLookup.gear_names[gear_name], NetworkLookup.hit_zones[hit_zone or "n/a"], impact_direction)

			return
		end
	elseif not Managers.lobby.lobby and show_damage and (not damage_extension or not damage_extension.can_receive_damage or damage_extension:can_receive_damage(player_unit)) then
		Managers.state.event:trigger("show_damage_number", player, damage_type, ff_damage, position, damage_range_type, impact_direction, armour_type)
	end

	damage_extension:add_damage(player, player_unit, damage_type, damage, position, normal, actor, damage_range_type, gear_name, hit_zone, impact_direction, real_damage)
end

function WeaponHelper:add_damage_over_time(world, victim_unit, player, damage_type)
	local network_manager = Managers.state.network

	if network_manager:game() then
		local victim_obj_id = network_manager:unit_game_object_id(victim_unit)
		local player_id = player:player_id()

		if victim_obj_id then
			network_manager:send_rpc_server("rpc_add_damage_over_time", player_id, victim_obj_id, NetworkLookup.damage_over_time_types[damage_type])

			return
		end

		local current_level = LevelHelper:current_level(world)
		local victim_lvl_id = Level.unit_index(current_level, victim_unit)

		if victim_lvl_id then
			return
		end
	end

	local damage_extension = ScriptUnit.extension(victim_unit, "damage_system")

	damage_extension:add_damage_over_time(player, damage_type)
end

function WeaponHelper:damage_over_time_property(property)
	return property == "bleeding" or property == "burning"
end

function WeaponHelper:new_attachment_multipliers()
	local attachment_multipliers = {
		swing_speed = 1,
		crossbow_hit_section = 0,
		pose_movement_speed = 1,
		reload_speed = 1,
		absorption_armour = 1,
		lance_speed_max = 1,
		lance_couch_time = 1,
		crossbow_miss = 1,
		penetration_armour = 1,
		blocked_penalty = 1,
		amunition_amount = 1,
		encumbrance = 1,
		pose_speed = 1,
		gravity = 1,
		damage = 1,
		miss_penalty = 1,
		amunition_regeneration = 1,
		crossbow_hit = 1,
		health = 1
	}

	return attachment_multipliers
end

function WeaponHelper:attachment_items_by_category(gear_name, category)
	local gear_settings = Gear[gear_name]

	for _, config in ipairs(gear_settings.attachments) do
		if config.category == category then
			return config.items
		end
	end
end

function WeaponHelper:attachment_settings(gear_name, category, name)
	local attachment_items = self:attachment_items_by_category(gear_name, category) or {}

	for _, item in ipairs(attachment_items) do
		if item.name == name then
			return item
		end
	end
end

function WeaponHelper:_weapon_has_property(properties, value)
	for _, property in ipairs(properties) do
		if property == value then
			return true
		end
	end

	return false
end

function WeaponHelper:current_impact_direction(weapon_unit, current_attack_name)
	local settings = Unit.get_data(weapon_unit, "settings")
	local unit_rot = Unit.world_rotation(weapon_unit, 0)
	local hit_direction = settings.attacks[current_attack_name].forward_direction:unbox()

	return Quaternion.right(unit_rot) * hit_direction.x + Quaternion.forward(unit_rot) * hit_direction.y + Quaternion.up(unit_rot) * hit_direction.z
end

function WeaponHelper:perk_attack_hit_damagable_prop(world, user_unit, weapon_unit, hit_unit, position, normal, actor, current_attack, impact_direction)
	self:add_perk_attack_damage(world, user_unit, weapon_unit, hit_unit, position, normal, actor, nil, true, current_attack, impact_direction)

	return not Unit.get_data(hit_unit, "soft_target")
end

function WeaponHelper:perk_attack_hit_non_damagable_prop(world, user_unit, weapon_unit, hit_unit, position, normal, actor, current_attack, impact_direction)
	if not Unit.get_data(hit_unit, "soft_target") then
		local raw_damage, damage_type, damage, damage_range_type, penetrated = self:add_perk_attack_damage(world, user_unit, weapon_unit, hit_unit, position, normal, actor, nil, false, current_attack, impact_direction)

		if raw_damage then
			self:apply_damage_to_self(world, user_unit, weapon_unit, damage_type, raw_damage, position, normal, damage_range_type, impact_direction)
		end

		return true
	end

	return false
end

function WeaponHelper:add_perk_attack_damage(world, user_unit, weapon_unit, victim_unit, position, normal, actor, hit_zone, apply_damage, current_attack, impact_direction)
	local hits_table = current_attack.hits[victim_unit]
	local attack_name = current_attack.attack_name
	local attacks = Unit.get_data(weapon_unit, "attacks")
	local attack = attacks[attack_name]
	local damage_type = attack.damage_type
	local damage, damage_range_type, raw_damage, penetrated = self:calculate_perk_attack_damage(weapon_unit, user_unit, victim_unit, attack_name, damage_type, current_attack.charge_time, actor, impact_direction)

	if ScriptUnit.has_extension(user_unit, "area_buff_system") then
		local area_buff_ext = ScriptUnit.extension(user_unit, "area_buff_system")

		damage = damage * area_buff_ext:buff_multiplier("reinforce")
	end

	if not hits_table then
		hits_table = {
			damage = damage,
			hit_zones = {},
			penetrated = penetrated
		}
		current_attack.hits[victim_unit] = hits_table
	end

	if apply_damage then
		self:apply_damage(world, user_unit, weapon_unit, victim_unit, position, normal, actor, damage_type, damage, damage_range_type, raw_damage, current_attack, hit_zone, impact_direction)
	end

	return raw_damage, damage_type, damage, damage_range_type, penetrated
end

function WeaponHelper:apply_damage(world, user_unit, weapon_unit, victim_unit, position, normal, actor, damage_type, damage, damage_range_type, raw_damage, current_attack, hit_zone, impact_direction, weapon_properties, real_damage)
	local victim_position = Unit.world_position(victim_unit, 0)
	local user_player = Managers.player:owner(user_unit)
	local gear_name = Unit.get_data(weapon_unit, "gear_name")

	self:add_damage(world, victim_unit, user_player, user_unit, damage_type, damage, position, normal, actor, damage_range_type, gear_name, hit_zone, impact_direction, real_damage, true)

	weapon_properties = weapon_properties or {}

	for _, property in ipairs(weapon_properties) do
		if self:damage_over_time_property(property) and damage > 0 then
			self:add_damage_over_time(world, victim_unit, user_player, property)
		end
	end

	self:apply_damage_to_self(world, user_unit, weapon_unit, damage_type, raw_damage, position, normal, damage_range_type, impact_direction)
end

function WeaponHelper:apply_damage_to_self(world, user_unit, weapon_unit, damage_type, damage, position, normal, damage_range_type, impact_direction)
	local settings = Unit.get_data(weapon_unit, "settings")
	local damage_thresh_min = settings.damage_feedback_threshold_min
	local damage_thresh_max = settings.damage_feedback_threshold_max
	local user_player = Managers.player:owner(user_unit)
	local gear_name = Unit.get_data(weapon_unit, "gear_name")

	if damage_thresh_max < damage then
		self:add_damage(world, weapon_unit, user_player, user_unit, damage_type, damage, position, normal, nil, damage_range_type, gear_name, nil, impact_direction, nil, false)
	elseif damage > 26 then
		local weapon_damage = (damage - damage_thresh_min) / (damage_thresh_max - damage_thresh_min) * damage

		self:add_damage(world, weapon_unit, user_player, user_unit, damage_type, weapon_damage, position, normal, nil, damage_range_type, gear_name, nil, impact_direction, nil, false)
	end
end

function WeaponHelper:helmet_hack(hit_unit, actor)
	if Unit.has_data(hit_unit, "armour_owner") then
		local owner_unit = Unit.get_data(hit_unit, "armour_owner")

		if actor == Unit.actor(hit_unit, "c_head") or actor == Unit.actor(hit_unit, "c_neck") then
			actor = Unit.actor(owner_unit, "c_head")
		else
			actor = Unit.actor(owner_unit, "helmet")
		end

		hit_unit = owner_unit
	end

	return hit_unit, actor
end
