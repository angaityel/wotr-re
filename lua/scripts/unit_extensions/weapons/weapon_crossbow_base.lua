-- chunkname: @scripts/unit_extensions/weapons/weapon_crossbow_base.lua

require("scripts/unit_extensions/weapons/weapon_ranged_projectile_base")

WeaponCrossbowBase = class(WeaponCrossbowBase, WeaponRangedProjectileBase)

function WeaponCrossbowBase:init(world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)
	WeaponCrossbowBase.super.init(self, world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)

	self._fire_sound_event = "release_crossbow"
	self._fire_anim_name = "crossbow_recoil"
	self._aim_anim_name = "crossbow_aim"
	self._unaim_anim_name = "crossbow_unaim"
	self._weapon_category = "crossbow"
end

function WeaponCrossbowBase:_play_fire_sound()
	local fire_sound_position = Unit.world_position(self._unit, 0)
	local timpani_world = self._timpani_world
	local fire_sound_event = self._fire_sound_event
	local event_id = TimpaniWorld.trigger_event(timpani_world, fire_sound_event, fire_sound_position)

	TimpaniWorld.set_parameter(timpani_world, event_id, "shot", "shot_mono")
end

function WeaponCrossbowBase:finish_reload(reload_successful, slot_name)
	self._finish_reload_anim_name = reload_successful and "crossbow_hand_reload_finished" or "crossbow_empty"

	if reload_successful then
		self:ready_projectile(slot_name)
	end

	return WeaponCrossbowBase.super.finish_reload(self, reload_successful)
end

function WeaponCrossbowBase:wield_finished_anim_name()
	self._wield_finished_anim_name = self._loaded and "crossbow_ready" or "crossbow_empty"

	return WeaponCrossbowBase.super.wield_finished_anim_name(self)
end
