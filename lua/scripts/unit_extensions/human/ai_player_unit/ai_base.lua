-- chunkname: @scripts/unit_extensions/human/ai_player_unit/ai_base.lua

require("scripts/unit_extensions/human/ai_player_unit/ai_locomotion")
require("scripts/unit_extensions/human/ai_player_unit/ai_simple_locomotion")
require("scripts/unit_extensions/human/ai_player_unit/ai_steering")
require("scripts/unit_extensions/human/ai_player_unit/ai_navigation")
require("scripts/unit_extensions/human/ai_player_unit/ai_brain")
require("scripts/unit_extensions/human/ai_player_unit/ai_perception")
require("scripts/unit_extensions/human/ai_player_unit/ai_event_handler")

AIBase = class(AIBase)
AIBase.SYSTEM = "ai_system"

function AIBase:init(world, unit, player_index, profile, spawner)
	self._world = world
	self._unit = unit
	self._blackboard = {
		world = world,
		move_orders = {}
	}
	self._spawner = spawner
	self._profile = profile

	self:_parse_properties()

	self._player = Managers.player:player(player_index)

	Unit.set_data(self._unit, "player_index", player_index)
	Managers.player:assign_unit_ownership(self._unit, player_index, true)
	self:_init_player_profile()
	self:_init_locomotion()
	self:_init_steering()
	self:_init_navigation()
	self:_init_event_handler()
	self:_init_brain()
	self:_init_perception()
	self:_finalize()
end

function AIBase:set_properties(params)
	for _, property in pairs(params) do
		local prop_name, prop_value = property:match("(%S+) (%S+)")
		local prop_type = type(self._profile.properties[prop_name])

		if prop_type == "table" then
			prop_value = AIProperties

			local prop_iterator = property:gmatch("(%S+)")

			prop_iterator()

			for i = 1, 10 do
				local index = prop_iterator()

				if index == nil then
					break
				end

				fassert(prop_value[index], "Table index %q not found in AIProperties", index)

				prop_value = prop_value[index]
			end
		elseif prop_type == "number" then
			prop_value = tonumber(prop_value)
		elseif prop_type == "boolean" then
			prop_value = to_boolean(prop_value)
		end

		self._profile.properties[prop_name] = prop_value
	end

	self:_parse_properties()
end

function AIBase:_parse_properties()
	for prop_name, prop_value in pairs(self._profile.properties) do
		if type(prop_value) == "table" then
			for key, value in pairs(prop_value) do
				self._profile.properties[key] = value
			end
		end
	end
end

function AIBase:_init_player_profile()
	local armour = Armours[self._profile.armour]
	local helmet = Helmets[self._profile.helmet.name]

	fassert(armour, "%q armour doesn't exist", self._profile.armour)
	fassert(helmet, "%q helmet doesn't exist", self._profile.helmet.name)
	Unit.set_data(self._unit, "armour_type", armour.armour_type)
	Unit.set_data(self._unit, "penetration_value", armour.penetration_value)
	Unit.set_data(self._unit, "absorption_value", armour.absorption_value)
	Unit.set_data(self._unit, "helmet_armour_type", helmet.armour_type)
	Unit.set_data(self._unit, "helmet_penetration_value", helmet.penetration_value)
	Unit.set_data(self._unit, "helmet_absorption_value", helmet.absorption_value)
end

function AIBase:_init_locomotion()
	if self._profile.locomotion then
		local class_name = self._profile.locomotion.class_name

		self._locomotion = _G[class_name]:new(self._world, self._unit, self._profile, self._player)
	else
		self._locomotion = AILocomotion:new(self._world, self._unit, self._profile, self._player)
	end

	Unit.set_data(self._unit, "locomotion_system", "extension", self._locomotion)
end

function AIBase:_init_steering()
	self._steering = AISteering:new(self._unit, self._locomotion)
end

function AIBase:_init_navigation()
	self._navigation = AINavigation:new(self._world, self._unit, self._steering)
end

function AIBase:_init_event_handler()
	if self._profile.event then
		local class_name = self._profile.event.class_name

		self._event_handler = _G[class_name]:new(self._unit)
	else
		self._event_handler = AIEventHandler:new(self._unit)
	end
end

function AIBase:_init_brain()
	fassert(self._profile.brain, "No brain configuration found for profile %q", Unit.get_data(self._unit, "player_profile"))

	self._brain = AIBrain:new(self._world, self._unit, self._blackboard, self._profile)
end

function AIBase:_init_perception()
	fassert(self._profile.perception, "No perception configuration found for profile %q", Unit.get_data(self._unit, "player_profile"))

	self._perception = AIPerception:new(self._world, self._unit, self._blackboard, self._profile.perception)
end

function AIBase:_finalize()
	self._locomotion:finalize(self._profile)
end

function AIBase:locomotion()
	return self._locomotion
end

function AIBase:steering()
	return self._steering
end

function AIBase:navigation()
	return self._navigation
end

function AIBase:brain()
	return self._brain
end

function AIBase:perception()
	return self._perception
end

function AIBase:profile()
	return self._profile
end

function AIBase:blackboard()
	return self._blackboard
end

function AIBase:update(unit, input, dt, context, t)
	Profiler.start("AIBase")

	local damage = ScriptUnit.extension(unit, "damage_system")

	if not damage:is_dead() then
		self._perception:update(t, dt)
		self._brain:update(t, dt)
	end

	self._steering:update(t, dt)

	local force = self._steering:force()

	self._locomotion:update(t, dt, context, force)
	Profiler.stop()
end

function AIBase:player_dead()
	self._locomotion:player_dead()
end

function AIBase:alerted()
	Unit.flow_event(self._spawner, "lua_on_alerted")
end

function AIBase:destroy()
	if Managers.player:owner(self._unit) then
		Managers.player:relinquish_unit_ownership(self._unit)
	end

	self._locomotion:destroy()
end
