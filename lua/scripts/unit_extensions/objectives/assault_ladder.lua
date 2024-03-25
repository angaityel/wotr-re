-- chunkname: @scripts/unit_extensions/objectives/assault_ladder.lua

require("scripts/unit_extensions/objectives/objective_unit_interactable")

AssaultLadder = class(AssaultLadder, ObjectiveUnitInteractable)
AssaultLadder.SYSTEM = "objective_system"

function AssaultLadder:init(world, unit, input)
	AssaultLadder.super.init(self, world, unit, input)

	self._raised = false
	self._raise_speed = Unit.get_data(self._unit, "raise_speed")

	Unit.set_unit_visibility(self._unit, false)

	local raised_pose = Unit.world_pose(self._unit, 0)

	self._raised_pose = Matrix4x4Box(raised_pose)

	self:_align_to_pivot_point()

	self._drawer = Managers.state.debug:drawer({
		mode = "retained",
		name = "ladder"
	})
end

function AssaultLadder:_align_to_pivot_point()
	local function callback(hit, position, distance, normal, actor)
		fassert(hit, "Unable to find pivot point for unit %s", self._unit)

		self._pivot_point = Vector3Box(position)

		local objective_icon_offset = Vector3(Unit.get_data(self._unit, "hud", "icon_world_fixed_position_offset", "x"), Unit.get_data(self._unit, "hud", "icon_world_fixed_position_offset", "y"), Unit.get_data(self._unit, "hud", "icon_world_fixed_position_offset", "z"))
		local objective_icon_position = position - Unit.local_position(self._unit, 0) + objective_icon_offset

		Unit.set_data(self._unit, "hud", "icon_world_fixed_position_offset", "x", objective_icon_position.x)
		Unit.set_data(self._unit, "hud", "icon_world_fixed_position_offset", "y", objective_icon_position.y)
		Unit.set_data(self._unit, "hud", "icon_world_fixed_position_offset", "z", objective_icon_position.z)

		local rot = Unit.local_rotation(self._unit, 0)
		local right = Quaternion.right(rot)
		local target_angle = math.degrees_to_radians(105)
		local target_rot = Quaternion.multiply(Quaternion(right, target_angle), rot)

		Unit.set_local_rotation(self._unit, 0, target_rot)

		local unraised_pose = Unit.local_pose(self._unit, 0)

		self._unraised_pose = Matrix4x4Box(unraised_pose)
	end

	local physics_world = World.physics_world(self._world)
	local raycast = PhysicsWorld.make_raycast(physics_world, callback, "closest", "types", "statics")
	local pose = Unit.world_pose(self._unit, Unit.node(self._unit, "ladder_top"))

	Raycast.cast(raycast, Matrix4x4.translation(pose), -Matrix4x4.up(pose), math.huge)
end

function AssaultLadder:update(unit, input, dt, context, t)
	AssaultLadder.super.update(self, unit, input, dt, context, t)

	if self._animate then
		self._animation_progress = (self._animation_progress or 0) + dt * self._raise_speed

		local raised_pose = self._raised_pose:unbox()
		local raised_pos = Matrix4x4.translation(raised_pose)
		local rotation_axis = Matrix4x4.right(raised_pose)
		local angle = -math.lerp(-105, 0, math.clamp(self._animation_progress, 0, 1))

		self:_rotate_unit_around_pivot(self._unit, raised_pos, self._pivot_point:unbox(), rotation_axis, angle)

		if self._animation_progress >= 1 then
			self._animation_progress = 0
			self._animate = false

			Unit.set_data(self._unit, "interacts", "climb", "climb")
			Managers.state.event:trigger("update_hud_objective_icons", self._unit, "blank_icon", "blank_icon")
			Unit.flow_event(self._unit, "lua_animation_done")
		end
	end
end

function AssaultLadder:_rotate_unit_around_pivot(unit, position, pivot_position, rotation_axis, angle)
	local up = Matrix4x4.up(Unit.local_pose(unit, 0))
	local base_rot = Matrix4x4.rotation(self._raised_pose:unbox())
	local rotation = Quaternion.multiply(Quaternion(rotation_axis, math.degrees_to_radians(angle)), base_rot)
	local mat = Matrix4x4.from_quaternion_position(rotation, pivot_position)
	local base_pos = Matrix4x4.translation(mat)
	local distance = pivot_position - position

	Matrix4x4.set_translation(mat, base_pos - up * Vector3.length(distance))
	Unit.set_local_pose(unit, 0, mat)
end

function AssaultLadder:_raise()
	self._raised = true
	self._animate = true

	Unit.set_unit_visibility(self._unit, true)
	Unit.set_visibility(self._unit, "align_cube", false)
	Unit.set_data(self._unit, "interacts", "trigger", nil)
	Unit.flow_event(self._unit, "lua_start_animation")
end

function AssaultLadder:interaction_complete(player)
	if Managers.lobby.server then
		self:_raise()
		Managers.state.network:send_rpc_clients("rpc_raise_assault_ladder", self._game_object_id)
	end
end

function AssaultLadder:rpc_raise_assault_ladder()
	if self._raised == false then
		self:_raise()
	end
end

function AssaultLadder:hot_join_synch(sender)
	RPC.rpc_synch_assault_ladder(sender, self._game_object_id, self._raised)
end

function AssaultLadder:rpc_synch_assault_ladder(raised)
	if raised then
		self:_raise()
	end
end

function AssaultLadder:can_interact(player)
	if not self._raised then
		local ladder_height = self._pivot_point:unbox()[3]
		local player_height = Unit.local_position(player.player_unit, 0)[3]

		if math.abs(player_height - ladder_height) > 2 then
			return false
		end
	end

	return AssaultLadder.super.can_interact(self, player)
end
