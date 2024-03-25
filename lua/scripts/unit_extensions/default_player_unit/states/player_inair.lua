-- chunkname: @scripts/unit_extensions/default_player_unit/states/player_inair.lua

PlayerInair = class(PlayerInair, PlayerMovementStateBase)

function PlayerInair:update(dt, t)
	PlayerInair.super.update(self, dt, t)
	self:update_movement(dt)
	self:update_rotation(dt)
	self:update_transition(dt)
end

function PlayerInair:update_transition(dt)
	local unit = self._unit
	local mover = Unit.mover(unit)
	local internal = self._internal
	local pos = Mover.position(mover)
	local fall_distance = PlayerMechanicsHelper.calculate_fall_distance(internal, self._fall_height, pos)

	if fall_distance > PlayerUnitMovementSettings.fall.heights.dead and not self._suicided then
		PlayerMechanicsHelper.suicide(internal)

		self._suicided = true
	elseif Mover.collides_down(mover) then
		local landing = PlayerMechanicsHelper._pick_landing(internal, fall_distance)

		self:change_state("landing", landing)
	end
end

function PlayerInair:cb_evaluate_landing_transition(actor_list)
	local internal = self._internal

	if internal.current_state_name ~= "inair" then
		return
	end

	if #actor_list ~= 0 then
		local mover = Unit.mover(self._unit)
		local pos = Mover.position(mover)
		local fall_distance = PlayerMechanicsHelper.calculate_fall_distance(internal, self._fall_height, pos)
		local landing = PlayerMechanicsHelper._pick_landing(internal, fall_distance)

		self:change_state("landing", landing)
	end
end

function PlayerInair:enter(old_state, fall_height)
	local internal = self._internal

	internal.falling = true
	self._fall_height = fall_height or Unit.local_position(internal.unit, 0).z
	self._suicided = false
end

function PlayerInair:exit(new_state)
	PlayerInair.super.exit(self, new_state)

	self._internal.falling = false
	self._suicided = false
end

function PlayerInair:update_movement(dt)
	local final_position = PlayerMechanicsHelper:velocity_driven_update_movement(self._unit, self._internal, dt, false)

	self:set_local_position(final_position)
end

function PlayerInair:update_rotation(dt, t)
	self:update_aim_rotation(dt, t)

	local internal = self._internal
	local aim_vector = self._aim_vector
	local aim_vector_flat = Vector3.normalize(Vector3.flat(aim_vector))
	local aim_rot_flat = Quaternion.look(aim_vector_flat, Vector3.up())
	local velocity = internal.velocity:unbox()

	internal.speed:store(Vector3(Vector3.dot(Quaternion.right(aim_rot_flat), velocity), Vector3.dot(Quaternion.forward(aim_rot_flat), velocity), 0) / self:_move_speed())
	self:_update_current_rotation(dt, t)
end
