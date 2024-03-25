-- chunkname: @scripts/helpers/player_mechanics_helper.lua

PlayerMechanicsHelper = PlayerMechanicsHelper or {}

function PlayerMechanicsHelper.suicide(internal)
	local network_manager = Managers.state.network

	if network_manager:game() then
		network_manager:send_rpc_server("rpc_suicide", internal.id)
	elseif not Managers.lobby.lobby then
		ScriptUnit.extension(internal.unit, "damage_system"):die(internal.player)
	end
end

function PlayerMechanicsHelper.player_unit_tagged(local_player, other_player_unit)
	local squad = local_player.team.squads[local_player.squad_index]

	if squad then
		local members = squad:members()
		local network_manager = Managers.state.network
		local game = network_manager:game()

		for player, _ in pairs(members) do
			local tagged_unit_id = GameSession.game_object_field(game, player.game_object_id, "tagged_player_object_id")
			local tagged_unit = network_manager:game_object_unit(tagged_unit_id)

			if tagged_unit == other_player_unit then
				return true
			end
		end
	end

	return false
end

function PlayerMechanicsHelper.time_to_tag(player_unit, tagged_unit)
	local pos_one = Unit.world_position(player_unit, 0)
	local pos_two = Unit.world_position(tagged_unit, 0)
	local distance = Vector3.distance(pos_one, pos_two)
	local max_distance = 100
	local max_time = 1.3
	local extra_time = 0.2
	local time_to_tag = (distance < max_distance and distance / max_distance * max_time or max_time) + extra_time

	return time_to_tag
end

function PlayerMechanicsHelper.calculate_fall_distance(internal, fall_height, landing_position)
	local height = fall_height - landing_position.z
	local height_multiplier = internal:has_perk("cat_burglar") and Perks.cat_burglar.height_multiplier or 1

	return height / height_multiplier
end

function PlayerMechanicsHelper._pick_landing(internal, fall_distance)
	local heights = PlayerUnitMovementSettings.fall.heights

	if fall_distance >= heights.knocked_down then
		return "knocked_down"
	elseif fall_distance >= heights.heavy * PlayerUnitMovementSettings.encumbrance.functions.heavy_landing_height(internal:inventory():encumbrance()) then
		return "heavy"
	else
		return "light"
	end
end

function PlayerMechanicsHelper:horse_update_movement_inair(unit, internal, dt)
	local mover = Unit.mover(unit)
	local velocity = internal.velocity:unbox()
	local current_position = Unit.local_position(unit, 0)
	local fall_velocity = velocity.z - 9.82 * dt

	velocity.z = fall_velocity

	local speed = Vector3.length(velocity)
	local dir = Vector3.normalize(velocity)
	local drag = 0.0225 * speed * speed
	local dragged_speed = speed - drag * dt
	local dragged_velocity = dir * dragged_speed
	local delta = dragged_velocity * dt

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)

	internal.velocity:store(dragged_velocity)

	return final_position
end

function PlayerMechanicsHelper:velocity_driven_update_movement(unit, internal, dt, allow_upward_velocity)
	local mover = Unit.mover(unit)
	local velocity = internal.velocity:unbox()
	local speed = Vector3.length(velocity)
	local drag_force = 0.00225 * speed * speed * Vector3.normalize(-velocity)
	local dragged_velocity = velocity + drag_force * dt
	local z_velocity = Vector3.z(dragged_velocity)
	local fall_velocity = z_velocity - 9.82 * dt

	if not allow_upward_velocity and fall_velocity > 0 then
		fall_velocity = 0
	end

	Vector3.set_z(dragged_velocity, fall_velocity)

	local delta = dragged_velocity * dt
	local current_position = Unit.local_position(unit, 0)

	delta = PlayerMechanicsHelper.clamp_delta_vs_husks(current_position, delta, internal)

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)

	internal.velocity:store(delta / dt)

	internal.move_speed = Vector3.length(Vector3.flat(internal.velocity))

	return final_position
end

function PlayerMechanicsHelper:animation_driven_update_movement(unit, internal, dt, allow_upward_velocity)
	local mover = Unit.mover(unit)
	local wanted_pose = Unit.animation_wanted_root_pose(unit)
	local wanted_position = Matrix4x4.translation(wanted_pose)
	local current_position = Unit.local_position(unit, 0)
	local velocity = internal.velocity:unbox()
	local speed = Vector3.length(velocity)
	local drag_force = 0.00225 * speed * speed * Vector3.normalize(-velocity)
	local dragged_velocity = velocity + drag_force * dt
	local z_velocity = Vector3.z(dragged_velocity)
	local fall_velocity = z_velocity - 9.82 * dt

	if not allow_upward_velocity and fall_velocity > 0 then
		fall_velocity = 0
	end

	local anim_delta = wanted_position - current_position
	local anim_delta_length = Vector3.length(anim_delta)
	local delta = anim_delta + Vector3(0, 0, fall_velocity) * dt

	delta = PlayerMechanicsHelper.clamp_delta_vs_husks(current_position, delta, internal)
	delta = PlayerMechanicsHelper.clamp_delta_vs_dyanmic_objects(current_position, delta, internal)

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)
	local move_delta = final_position - current_position

	internal.velocity:store(move_delta / dt)

	return final_position, wanted_pose
end

local DISTANCE_BETWEEN_PLAYERS = 1
local PLAYER_HEIGHT = 1.7

function PlayerMechanicsHelper.clamp_delta_vs_husks(current_position, delta, internal)
	local actors = internal.husks_in_proximity

	for actor_box, unit in pairs(actors) do
		local actor = ActorBox.unbox(actor_box)

		if Unit.alive(unit) and actor then
			local actor_unit = Actor.unit(actor)
			local physics_collision_type = Unit.get_data(actor_unit, "physics", "overlap_shape")

			if not physics_collision_type then
				local position = Actor.position(actor)

				if math.abs(current_position.z - position.z) < PLAYER_HEIGHT then
					local offset = position - current_position

					offset.z = 0

					local dir = Vector3.normalize(offset)
					local length = Vector3.length(offset)
					local delta_dot = Vector3.dot(delta, dir)

					if delta_dot > 0 then
						local dist = length - delta_dot
						local overlap = dist - DISTANCE_BETWEEN_PLAYERS

						if overlap < 0 then
							overlap = math.max(-delta_dot, overlap)
							delta = delta + overlap * dir
						end
					end
				end
			end
		end
	end

	return delta
end

function math.closest_point_on_line_2d(position, line_start, line_end)
	local point_vec = position - line_start
	local line_vec = line_end - line_start
	local line_hypotenuse_squared = line_vec.x * line_vec.x + line_vec.y * line_vec.y
	local line = point_vec.x * line_vec.x + point_vec.y * line_vec.y
	local scale = line / line_hypotenuse_squared

	if scale < 0 then
		scale = 0
	elseif scale > 1 then
		scale = 1
	end

	return line_start + line_vec * scale
end

function PlayerMechanicsHelper.clamp_delta_vs_dyanmic_objects(current_position, delta, internal)
	local actors = internal.husks_in_proximity

	for actor_box, unit in pairs(actors) do
		local actor = ActorBox.unbox(actor_box)

		if Unit.alive(unit) and actor then
			local actor_unit = Actor.unit(actor)
			local physics_collision_type = Unit.get_data(actor_unit, "physics", "overlap_shape")

			if physics_collision_type == "oobb" then
				local x = Unit.get_data(actor_unit, "physics", "size", "x")
				local y = Unit.get_data(actor_unit, "physics", "size", "y")
				local z = Unit.get_data(actor_unit, "physics", "size", "z")
				local actor_position = Unit.local_position(actor_unit, 0)
				local unit_position = current_position + delta
				local actor_rotation = Unit.local_rotation(actor_unit, 0)
				local forward = Quaternion.forward(actor_rotation) * y
				local right = Quaternion.right(actor_rotation) * x

				if z < math.abs(unit_position[3] - actor_position[3]) then
					return delta
				end

				local positions = {
					bl = actor_position - right - forward,
					tr = actor_position + right + forward,
					tl = actor_position + forward - right,
					br = actor_position - forward + right
				}
				local bl = Vector3(positions.bl[1], positions.bl[2], 0)
				local tl = Vector3(positions.tl[1], positions.tl[2], 0)
				local br = Vector3(positions.br[1], positions.br[2], 0)
				local tr = Vector3(positions.tr[1], positions.tr[2], 0)
				local pos = Vector3(unit_position[1], unit_position[2], 0)
				local is_inside = Geometry.is_point_inside_triangle(pos, bl, tl, br)

				is_inside = Geometry.is_point_inside_triangle(pos, tl, br, tr) or is_inside

				local min_dist = 1

				if is_inside then
					local closest_positions = {
						closest_bottom = math.closest_point_on_line_2d(unit_position, positions.bl, positions.br),
						closest_top = math.closest_point_on_line_2d(unit_position, positions.tl, positions.tr),
						closest_left = math.closest_point_on_line_2d(unit_position, positions.bl, positions.tl),
						closest_right = math.closest_point_on_line_2d(unit_position, positions.br, positions.tr)
					}
					local closest = unit_position
					local closest_dist = math.huge

					for _, closest_pos in pairs(closest_positions) do
						local dist = Vector3.length(closest_pos - unit_position)

						if dist < closest_dist then
							closest = closest_pos
							closest_dist = dist
						end
					end

					delta = closest - current_position

					return delta
				end
			end
		end
	end

	return delta
end

function PlayerMechanicsHelper:script_driven_camera_relative_update_movement(unit, internal, dt, allow_upward_velocity)
	local mover = Unit.mover(unit)
	local current_position = Unit.local_position(unit, 0)
	local velocity = internal.velocity:unbox()
	local speed = Vector3.length(velocity)
	local drag_force = 0.00225 * speed * speed * Vector3.normalize(-velocity)
	local dragged_velocity = velocity + drag_force * dt
	local z_velocity = Vector3.z(dragged_velocity)
	local fall_velocity = z_velocity - 9.82 * dt

	if not allow_upward_velocity and fall_velocity > 0 then
		fall_velocity = 0
	end

	local fwd = Quaternion.forward(internal.move_rot:unbox())
	local move_velocity = internal.move_speed * fwd
	local delta = (move_velocity + Vector3(0, 0, fall_velocity)) * dt

	delta = PlayerMechanicsHelper.clamp_delta_vs_husks(current_position, delta, internal)
	delta = PlayerMechanicsHelper.clamp_delta_vs_dyanmic_objects(current_position, delta, internal)

	Mover.move(mover, delta, dt)

	local final_position = Mover.position(mover)

	delta = final_position - current_position

	internal.velocity:store(delta / dt)

	return final_position
end
