-- chunkname: @scripts/managers/group/group_commands.lua

SynchedShot = class(SynchedShot)

function SynchedShot:init(target)
	self._target = Vector3Box(target)
end

function SynchedShot:cb_fire_result(unit, aim_x, aim_y, aim_z, hit, position, distance, normal, actor)
	local drawer = Managers.state.debug:drawer({
		name = "ai_fire_check"
	})

	if hit then
		local other_unit = Actor.unit(actor)
		local same_unit = unit == other_unit

		if same_unit then
			print("[SynchedShot]: Same unit hit - this should not happen")

			return
		end

		local same_team = Managers.state.team:is_on_same_team(unit, other_unit)

		if not same_team then
			local locomotion = ScriptUnit.extension(unit, "locomotion_system")
			local aim_target = Vector3(aim_x, aim_y, aim_z)

			locomotion:attempt_ranged_attack(aim_target)
		end
	else
		local locomotion = ScriptUnit.extension(unit, "locomotion_system")
		local aim_target = Vector3(aim_x, aim_y, aim_z)

		locomotion:attempt_ranged_attack(aim_target)
	end
end

function SynchedShot:exec(group, units)
	local world = group:world()
	local physics_world = World.physics_world(world)
	local target = self._target:unbox()
	local group_pos = group:locomotion():position()
	local distance_vector = target - group_pos
	local aim_dir = Vector3.normalize(distance_vector)

	for unit, _ in pairs(units) do
		local unit_pose = Unit.world_pose(unit, 0)
		local unit_pos = Unit.world_position(unit, 0)
		local unit_fwd = Matrix4x4.forward(unit_pose)
		local aim_target = unit_pos + distance_vector
		local locomotion = ScriptUnit.extension(unit, "locomotion_system")

		locomotion:set_look_target(aim_target)
		locomotion:turn_to(aim_dir)

		local aim_x, aim_y, aim_z = aim_target.x, aim_target.y, aim_target.z
		local callback = callback(self, "cb_fire_result", unit, aim_x, aim_y, aim_z)
		local raycast = PhysicsWorld.make_raycast(physics_world, callback, "closest", "types", "both", "collision_filter", "ai_fire_check")
		local ray_from = locomotion:inventory():projectile_position() + 0.4 * Matrix4x4.up(unit_pose)

		Raycast.cast(raycast, ray_from, aim_dir, 3)
	end
end
