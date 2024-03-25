-- chunkname: @foundation/scripts/util/sound_ducking/ducking_handler.lua

require("foundation/scripts/util/sound_ducking/sound_ducker")

DuckingHandler = class(DuckingHandler)

function DuckingHandler:init()
	self._sound_duckers = {}

	self:_hijack_timpani_events()
end

function DuckingHandler:_hijack_timpani_events()
	self._original_timpani_trigger_event = TimpaniWorld.trigger_event

	function TimpaniWorld.trigger_event(timpani_world, event_name, ...)
		local event_id = self._original_timpani_trigger_event(timpani_world, event_name, ...)

		self:add_ducking(event_name, event_id, timpani_world)

		return event_id
	end
end

function DuckingHandler:flow_trigger_ducking(params)
	self:add_ducking(params.event_name, params.event_id)
end

function DuckingHandler:update(dt)
	if Managers.state.event and not self._registered then
		Managers.state.event:register(self, "flow_trigger_ducking", "flow_trigger_ducking")

		self._registered = true
	end

	for bus_name, bus in pairs(self._sound_duckers) do
		local volume = math.huge

		for id, ducker in pairs(bus) do
			local ducker_volume = ducker:update(dt)

			volume = math.min(volume, ducker_volume)

			if ducker:is_done() then
				ducker:destroy()

				bus[id] = nil
			end
		end

		if volume ~= math.huge then
			Timpani.set_bus_volume(bus_name, volume)
		end
	end
end

function DuckingHandler:add_ducking(event_name, event_id, timpani_world)
	if DuckingConfigs[event_name] then
		local config = DuckingConfigs[event_name]
		local ducker = SoundDucker:new(config, timpani_world, event_id)
		local bus_name = ducker:bus_name()

		self._sound_duckers[bus_name] = self._sound_duckers[bus_name] or {}

		table.insert(self._sound_duckers[bus_name], ducker)
	end
end

function DuckingHandler:destroy()
	for bus_name, bus in pairs(self._sound_duckers) do
		local default_volume = BusVolumeDefaults[bus_name]

		Timpani.set_bus_volume(bus_name, default_volume)

		for id, ducker in pairs(bus) do
			ducker:destroy()

			bus[id] = nil
		end
	end

	TimpaniWorld.trigger_event = self._original_timpani_trigger_event
end
