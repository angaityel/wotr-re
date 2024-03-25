-- chunkname: @scripts/unit_extensions/horse/horse_onground_behaviour.lua

HorseOngroundBehaviour = class(HorseOngroundBehaviour)

local settings = HorseUnitMovementSettings.behaviour
local settings_drawer = settings.debug and {
	mode = "immediate",
	name = "horse_feeler"
}

function HorseOngroundBehaviour:init(locomotion)
	self._locomotion = locomotion
	self._world = locomotion.world
	self._unit = locomotion.unit
	self._ray_node = 0

	self:_setup_raycast()
end

function HorseOngroundBehaviour:destroy()
	self._raycast = nil
end

function HorseOngroundBehaviour:_setup_raycast()
	local physics_world = World.physics_world(self._world)
	local callback = callback(self, "on_raycast_result")

	self._raycast = PhysicsWorld.make_raycast(physics_world, callback, "closest", "types", "statics", "collision_filter", "horse_behaviour_raycast")
end

function HorseOngroundBehaviour:on_raycast_result(hit, pos, distance, normal, actor)
	if self._locomotion.current_state_name == "onground" then
		if hit and self._locomotion.speed >= 0 then
			local unit_pose = Unit.world_pose(self._unit, 0)
			local unit_forward = Matrix4x4.forward(unit_pose)
			local y = math.abs(Vector3.dot(normal, unit_forward))
			local angle = math.radians_to_degrees(math.asin(y))
			local diff = 90 - angle
			local stop_distance = settings.stop.threshold_distance

			if settings.debug then
				Managers.state.debug:drawer(settings_drawer):sphere(pos, 0.1, Color(255, 0, 0))
				Managers.state.debug:drawer(settings_drawer):vector(pos, normal, Color(255, 0, 0))
			end

			if diff <= settings.stop.threshold_angle and distance <= stop_distance then
				self._locomotion.current_state:stop()
			else
				self._locomotion.current_state:go()

				local distance_to_stop = math.max(distance - stop_distance, 0.001)
				local max_speed = settings.slow_down.max_speed
				local min_speed = settings.slow_down.min_speed
				local speed_diff = max_speed - min_speed
				local look_ahead_length = settings.look_ahead_length
				local speed_factor = distance_to_stop / (look_ahead_length - stop_distance)
				local scaled_speed_factor = speed_factor

				self._locomotion.current_state:cap_speed(scaled_speed_factor * speed_diff + min_speed)

				if diff > settings.stop.threshold_angle and distance <= settings.deflect.threshold_distance then
					local turn = math.sign(Vector3.cross(normal, unit_forward).z)
					local align_vector = Vector3.zero()

					if turn == 1 then
						align_vector = Vector3.cross(Vector3.up(), normal)
					else
						align_vector = Vector3.cross(normal, Vector3.up())
					end

					self._locomotion.current_state:set_deflect(true)
					self._locomotion.current_state:set_align_direction(align_vector)
				end
			end
		else
			if not hit then
				self._locomotion.current_state:go()
			end

			self._locomotion.current_state:cap_speed(math.huge)
			self._locomotion.current_state:set_deflect(false)
		end
	end
end

function HorseOngroundBehaviour:update(t, dt)
	local unit_pose = Unit.local_pose(self._unit, 0)
	local ray_dir = Matrix4x4.forward(unit_pose)
	local ray_pos = Unit.local_position(self._unit, 0) + Matrix4x4.up(unit_pose)
	local speed = math.clamp(self._locomotion.speed, 0, math.huge)
	local look_ahead_length = settings.look_ahead_length

	if settings.debug then
		Managers.state.debug:drawer(settings_drawer):vector(ray_pos, ray_dir * look_ahead_length, Color(255, 0, 0))
	end

	Raycast.cast(self._raycast, ray_pos, ray_dir, look_ahead_length)
end
