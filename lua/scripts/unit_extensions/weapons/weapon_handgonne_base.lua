-- chunkname: @scripts/unit_extensions/weapons/weapon_handgonne_base.lua

require("scripts/unit_extensions/weapons/weapon_ranged_base")

WeaponHandgonneBase = class(WeaponHandgonneBase, WeaponRangedBase)

function WeaponHandgonneBase:init(world, unit, user_unit, player, id)
	WeaponHandgonneBase.super.init(self, world, unit, user_unit, player, id)

	self._muzzle_node_index = Unit.node(unit, "fire_position")
	self._alt_muzzle_node_index = Unit.node(unit, "fire_position_alt")
	self._muzzle_position = nil
	self._alt_muzzle_position = nil
	self._fire_sound_event = "handgonne_shot"
	self._fire_anim_name = "handgonne_ignite"
	self._aim_anim_name = "handgonne_aim"
	self._unaim_anim_name = "handgonne_ready"
	self._penetration_force = 1
	self._weapon_category = "handgonne"
end

function WeaponHandgonneBase:release_projectile(slot_name, draw_time)
	WeaponHandgonneBase.super.release_projectile(self, slot_name, draw_time)

	local muzzle_node_index = self._muzzle_node_index
	local alt_muzzle_node_index = self._alt_muzzle_node_index

	self._muzzle_position = Unit.world_position(self._unit, muzzle_node_index)

	if alt_muzzle_node_index then
		self._alt_muzzle_position = Unit.world_position(self._unit, alt_muzzle_node_index)
	end

	local network_manager = Managers.state.network
	local effect_name = "fx/handgonne_muzzle_flash"
	local unit_id = network_manager:game_object_id(self._unit)

	ScriptWorld.create_particles_linked(self._world, effect_name, self._unit, muzzle_node_index, "stop")
	self:_play_fire_sound()
end

function WeaponHandgonneBase:_play_fire_sound()
	local fire_sound_event = self._fire_sound_event
	local fire_sound_position = self._muzzle_position
	local timpani_world = self._timpani_world
	local event_id = TimpaniWorld.trigger_event(timpani_world, fire_sound_event, fire_sound_position)

	TimpaniWorld.set_parameter(timpani_world, event_id, fire_sound_event, "mono_near")
end

function WeaponHandgonneBase:unaim()
	local event_id = TimpaniWorld.trigger_event(self._timpani_world, "handgonne_ignite_loop_stop")

	return WeaponHandgonneBase.super.unaim(self)
end
