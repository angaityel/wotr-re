-- chunkname: @scripts/managers/debug/debug_manager.lua

require("scripts/managers/debug/debug_drawer")

DebugManager = class(DebugManager)

function DebugManager:init(world)
	self._world = world
	self._drawers = {}
	self._actor_draw = {}
	self._actors = {}
end

function DebugManager:drawer(options)
	options = options or {}

	local drawer_name = options.name
	local drawer

	if drawer_name == nil then
		local line_object = World.create_line_object(self._world)

		drawer = DebugDrawer:new(line_object, options.mode)
		self._drawers[#self._drawers + 1] = drawer
	elseif self._drawers[drawer_name] == nil then
		local line_object = World.create_line_object(self._world)

		drawer = DebugDrawer:new(line_object, options.mode)
		self._drawers[drawer_name] = drawer
	else
		drawer = self._drawers[drawer_name]
	end

	return drawer
end

function DebugManager:update(dt)
	self:_update_actor_draw(dt)

	for _, drawer in pairs(self._drawers) do
		drawer:update(self._world)
	end
end

function DebugManager:_update_actor_draw(dt)
	local world = self._world
	local physics_world = World.physics_world(world)
	local pose = World.debug_camera_pose(world)

	for _, data in pairs(self._actor_draw) do
		PhysicsWorld.overlap(physics_world, function(...)
			self:_actor_draw_overlap_callback(data, ...)
		end, "shape", "sphere", "size", data.range, "pose", pose, "types", "both", "collision_filter", data.collision_filter)

		if data.actors then
			local drawer = self._actor_drawer

			for _, actor in ipairs(data.actors) do
				drawer:actor(actor, data.color:unbox(), pose)
			end
		end
	end

	self._actors = self._actors or {}

	local actors = self._actors

	for actor_box, color_box in pairs(actors) do
		local drawer = self._actor_drawer
		local actor = actor_box:unbox()

		if actor then
			drawer:actor(actor, color_box:unbox(), pose)
		else
			actors[actor_box] = nil
		end
	end
end

function DebugManager:enable_actor_draw(actor, color)
	self._actor_drawer = self:drawer({
		mode = "immediate",
		name = "_actor_drawer"
	})
	color = Color(125, 255, 50, 50)
	self._actors[ActorBox(actor)] = QuaternionBox(color)
end

function DebugManager:disable_actor_draw(actor)
	local actors = self._actors

	for box, _ in pairs(actors) do
		if box:unbox() == actor then
			actors[box] = nil
		end
	end
end

function DebugManager:_actor_draw_overlap_callback(data, actors)
	data.actors = actors
end

function DebugManager:enable_overlap_actor_draw(collision_filter, color, range)
	self._actor_drawer = self:drawer({
		mode = "immediate",
		name = "_actor_drawer"
	})
	self._actor_draw[collision_filter] = {
		color = QuaternionBox(color),
		range = range,
		collision_filter = collision_filter
	}
end

function DebugManager:disable_actor_draw(collision_filter)
	self._actor_draw[collision_filter] = nil
end
