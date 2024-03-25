-- chunkname: @scripts/unit_extensions/weapons/weapon_ranged_base.lua

require("scripts/helpers/weapon_helper")

WeaponRangedBase = class(WeaponRangedBase)

function WeaponRangedBase:init(world, unit, user_unit, player, id, ai_gear, attachments, properties, attachment_multipliers)
	self._world = world
	self._unit = unit
	self._user_unit = user_unit
	self._player = player
	self._game_object_id = id
	self._timpani_world = World.timpani_world(world)
	self._settings = Unit.get_data(unit, "settings")
	self._gear_name = Unit.get_data(unit, "gear_name")
	self._projectile_name = attachments and attachments.projectile_head and attachments.projectile_head[1] or "standard"
	self._projectile_settings = WeaponHelper:attachment_settings(self._gear_name, "projectile_head", self._projectile_name)
	self._reload_time = nil
	self._finish_reload_anim_name = nil
	self._fire_anim_name = nil
	self._aim_anim_name = nil
	self._aim_anim_var_name = nil
	self._unaim_anim_name = nil
	self._loaded = true
	self._reloading = false
	self._wield_finished_anim_name = nil
	self._firing_timer = nil
	self._firing_event = false
	self._firing = false
	self._needs_unaiming = false
end

function WeaponRangedBase:projectile_name()
	return self._projectile_name
end

function WeaponRangedBase:loaded()
	return self._loaded
end

function WeaponRangedBase:set_loaded(loaded)
	self._loaded = loaded
end

function WeaponRangedBase:reloading()
	return self._reloading
end

function WeaponRangedBase:firing_event()
	return self._firing_event
end

function WeaponRangedBase:fire_anim_name()
	return self._fire_anim_name
end

function WeaponRangedBase:wield_finished_anim_name()
	return self._wield_finished_anim_name
end

function WeaponRangedBase:update(dt, t)
	return
end

function WeaponRangedBase:start_reload(reload_time, reload_blackboard)
	self._reload_time = reload_time
	self._reload_blackboard = reload_blackboard
	self._reloading = true
end

function WeaponRangedBase:update_reload(dt, t, fire_input)
	return
end

function WeaponRangedBase:finish_reload(reload_successful)
	self._reloading = false

	return self._finish_reload_anim_name
end

function WeaponRangedBase:uses_ammo()
	return false
end

function WeaponRangedBase:needs_unaiming()
	return self._needs_unaiming
end

function WeaponRangedBase:set_needs_unaiming(needs_unaiming)
	self._needs_unaiming = needs_unaiming
end

function WeaponRangedBase:can_wield()
	return true
end

function WeaponRangedBase:can_reload()
	return true
end

function WeaponRangedBase:can_aim()
	return true
end

function WeaponRangedBase:can_steady()
	return false
end

function WeaponRangedBase:can_fire()
	return self._loaded
end

function WeaponRangedBase:category()
	return self._weapon_category
end

function WeaponRangedBase:aim()
	return self._aim_anim_name, self._aim_anim_var_name
end

function WeaponRangedBase:unaim()
	return self._unaim_anim_name
end

function WeaponRangedBase:ready_projectile(slot_name)
	return
end

function WeaponRangedBase:release_projectile(slot_name, draw_time)
	self._loaded = false
end

function WeaponRangedBase:set_wielded(wielded)
	return
end

function WeaponRangedBase:hot_join_synch(sender, player, player_object_id, slot_name)
	return
end

function WeaponRangedBase:enter_ghost_mode()
	self._ghost_mode = true
end

function WeaponRangedBase:exit_ghost_mode()
	self._ghost_mode = false
end

function WeaponRangedBase:destroy()
	return
end
