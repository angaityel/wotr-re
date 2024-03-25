-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_ranged_aim_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTRangedAimAction = class(BTRangedAimAction, BTNode)

function BTRangedAimAction:init(...)
	BTRangedAimAction.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)

	self._data = self._data or {}
end

function BTRangedAimAction:setup(unit, blackboard, profile)
	self._aim_node = self._data.aim_node or "Neck"
	self._projectile_gravity = ProjectileSettings.gravity:unbox()[3]
end

function BTRangedAimAction:run(unit, blackboard, t, dt)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local inventory = locomotion:inventory()
	local slot_name = inventory:wielded_ranged_weapon_slot()

	if slot_name then
		local gear = inventory:_gear(slot_name)
		local gear_unit = gear:unit()
		local gear_settings = Unit.get_data(gear_unit, "attacks").ranged
		local projectile_speed = gear_settings.speed_max
		local projectile_name = gear:extensions().base:projectile_name()
		local projectile_pos = WeaponHelper:projectile_fire_position_from_ranged_weapon(gear_unit, unit, projectile_name)
		local aim_unit = blackboard[self._input]
		local aim_node = self._aim_node and Unit.node(aim_unit, self._aim_node) or 0
		local aim_unit_pos = Unit.world_position(aim_unit, aim_node)
		local offset_to_target = aim_unit_pos - projectile_pos
		local travel_time = Vector3.length(offset_to_target) / projectile_speed
		local target_vel = ScriptUnit.extension(aim_unit, "locomotion_system"):get_velocity()
		local look_target = aim_unit_pos + target_vel * travel_time

		locomotion:set_look_target(look_target)

		local angle_1, angle_2 = WeaponHelper:wanted_projectile_angle(offset_to_target, self._projectile_gravity, projectile_speed)

		locomotion.projectile_angle = angle_1 and angle_2 and math.min(angle_1, angle_2) or nil
	end
end
