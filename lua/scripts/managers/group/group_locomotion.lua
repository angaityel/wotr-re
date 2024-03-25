-- chunkname: @scripts/managers/group/group_locomotion.lua

GroupLocomotion = class(GroupLocomotion)

local settings = AISettings.group.locomotion

function GroupLocomotion:init(group, units, pos, rot)
	self._group = group
	self._units = units
	self._arrived = true
	self._speed = settings.max_speed
	self._move_target = Vector3Box()

	local pos = pos or Vector3.zero()
	local rot = rot or Quaternion.identity()
	local pose = Matrix4x4.from_quaternion_position(rot, pos)

	self._pose = Matrix4x4Box(pose)
end

function GroupLocomotion:position_rotation_from_offset(offset)
	local group_pose = self:pose()
	local group_pos = Matrix4x4.translation(group_pose)
	local group_rot = Matrix4x4.rotation(group_pose)
	local rotated_offset = Quaternion.rotate(group_rot, offset)
	local final_pos = group_pos + rotated_offset

	return final_pos, group_rot
end

function GroupLocomotion:unit_added(unit)
	local formation = self._group:formation()
	local group_pose = self:pose()
	local group_pos = Matrix4x4.translation(group_pose)
	local group_rot = Matrix4x4.rotation(group_pose)
	local slot = self._units[unit]
	local offset = formation:offset(slot)
	local rotated_offset = Quaternion.rotate(group_rot, offset)
	local final_pos = group_pos + rotated_offset
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")
	local wanted_pose = Matrix4x4.from_quaternion_position(group_rot, final_pos)

	locomotion:set_pose(wanted_pose)
end

function GroupLocomotion:unit_removed()
	return
end

function GroupLocomotion:set_pose(pose)
	self._pose:store(pose)
end

function GroupLocomotion:pose()
	return self._pose:unbox()
end

function GroupLocomotion:position()
	local pose = self:pose()

	return Matrix4x4.translation(pose)
end

function GroupLocomotion:set_move_target(wanted_pos, arrive_callback)
	self._arrived = false

	self._move_target:store(wanted_pos)

	self._arrive_callback = arrive_callback
end

function GroupLocomotion:update(dt, t)
	if not self._arrived then
		self:_update_group_rotation(dt, t)
		self:_update_group_movement(dt, t)
		self:_update_units_movement(dt, t)
	end
end

function GroupLocomotion:_debug_draw()
	local drawer = Managers.state.debug:drawer({
		mode = "immediate",
		name = "group_locomotion"
	})

	drawer:matrix4x4(self._pose:unbox())
end

function GroupLocomotion:_update_group_rotation(dt, t)
	local move_target = self._move_target:unbox()
	local current_pose = self:pose()
	local current_pos = Matrix4x4.translation(current_pose)
	local wanted_dir = Vector3.normalize(Vector3.flat(move_target - current_pos))
	local wanted_rot = Quaternion.look(wanted_dir, Vector3.up())
	local current_rot = Matrix4x4.rotation(current_pose)
	local lerped_rot = Quaternion.lerp(current_rot, wanted_rot, settings.rotation_speed * dt)

	Matrix4x4.set_rotation(current_pose, lerped_rot)
	self._pose:store(current_pose)
end

function GroupLocomotion:_update_group_movement(dt, t)
	local move_target = self._move_target:unbox()
	local current_pose = self:pose()
	local current_pos = Matrix4x4.translation(current_pose)
	local current_fwd = Matrix4x4.forward(current_pose)
	local wanted_pos = current_pos + self._speed * current_fwd * dt

	Matrix4x4.set_translation(current_pose, wanted_pos)
	self._pose:store(current_pose)

	local distance = Vector3.distance(wanted_pos, move_target)

	if distance <= 0.1 then
		self._arrived = true

		self:_update_units_movement()

		if self._arrive_callback then
			self._arrive_callback()
		end
	end
end

function GroupLocomotion:cb_unit_arrived(unit)
	local group_pose = self:pose()
	local group_fwd = Matrix4x4.forward(group_pose)
	local locomotion = ScriptUnit.extension(unit, "locomotion_system")

	locomotion:turn_to(group_fwd)
	locomotion:stop()
end

function GroupLocomotion:_update_units_movement(dt, t)
	local sum_distance = 0
	local formation = self._group:formation()
	local group_pose = self:pose()
	local group_pos = Matrix4x4.translation(group_pose)
	local group_rot = Matrix4x4.rotation(group_pose)

	for unit, slot in pairs(self._units) do
		local offset = formation:offset(slot)
		local rotated_offset = Quaternion.rotate(group_rot, offset)
		local final_pos = group_pos + rotated_offset
		local locomotion = ScriptUnit.extension(unit, "locomotion_system")

		locomotion:steering():arrive(final_pos, callback(self, "cb_unit_arrived"), "move_forward")

		local unit_pose = Unit.world_pose(unit, 0)
		local unit_pos = Matrix4x4.translation(unit_pose)
		local distance = Vector3.distance(unit_pos, final_pos)

		sum_distance = sum_distance + distance

		local unit_forward = Matrix4x4.forward(unit_pose)

		locomotion:set_look_target(unit_pos + 100 * unit_forward)
	end

	local speed_factor = 10 / sum_distance

	self._speed = math.clamp(speed_factor * settings.max_speed, settings.min_speed, settings.max_speed)
end
