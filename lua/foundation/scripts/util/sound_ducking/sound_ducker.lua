-- chunkname: @foundation/scripts/util/sound_ducking/sound_ducker.lua

SoundDucker = class(SoundDucker)

function SoundDucker:init(config, timpani_world, event_id, callback)
	fassert(BusVolumeDefaults[config.bus_name], "[MusicManager:lerp_bus()] No default value for the bus named %q", config.bus_name)

	self._default_volume = BusVolumeDefaults[config.bus_name]
	self._config = config
	self._timpani_world = timpani_world
	self._timer = 0
	self._callback = callback
	self._event_id = event_id
	self._state = "delay"
	self._delay_time = config.delay or DuckingConfigs.defaults.delay
	self._fade_in_time = self._delay_time + config.fade_in_time or DuckingConfigs.defaults.fade_in_time
	self._fade_out_duration = self._config.fade_out_time or DuckingConfigs.defaults.fade_out_time

	if config.duration then
		self._hold_time = self._fade_in_time + config.duration
	end
end

function SoundDucker:bus_name()
	return self._config.bus_name
end

function SoundDucker:update(dt)
	self._timer = self._timer + dt

	if self._state == "delay" then
		local delay_done = self._timer > self._delay_time

		if delay_done and self._fade_in_time > self._delay_time then
			self:_setup_fade_in()
		elseif delay_done then
			self._state = "hold"
		end

		return self._default_volume
	elseif self._state == "fade_in" then
		if self._timer > self._fade_in_time then
			self._state = "hold"
		end

		return self:_interpolate(dt)
	elseif self._state == "hold" then
		local holding = self:_is_holding()

		if not holding and self._fade_out_duration > 0 then
			self:_setup_fade_out()
		elseif not holding then
			self:_done()

			return self._default_volume
		end

		return self._config.volume
	elseif self._state == "fade_out" then
		if self._timer > self._fade_out_time then
			self:_done()

			return self._default_volume
		end

		return self:_interpolate(dt)
	else
		return self._default_volume
	end
end

function SoundDucker:is_done()
	return self._state == "done"
end

function SoundDucker:_is_holding()
	if self._hold_time then
		return self._timer <= self._hold_time
	else
		return TimpaniWorld.is_playing(self._timpani_world, self._event_id)
	end
end

function SoundDucker:_setup_fade_in()
	self._state = "fade_in"
	self._fade_timer = 0
	self._fade_to_value = self._config.volume
	self._fade_from_value = self._default_volume
	self._fade_duration = self._config.fade_in_time
end

function SoundDucker:_setup_fade_out()
	self._fade_out_time = self._fade_out_duration + self._timer
	self._state = "fade_out"
	self._fade_timer = 0
	self._fade_to_value = self._default_volume
	self._fade_from_value = self._config.volume
	self._fade_duration = self._config.fade_out_time
end

function SoundDucker:_done()
	self._state = "done"

	if self._callback then
		self._callback()
	end
end

function SoundDucker:_interpolate(dt)
	self._fade_timer = self._fade_timer + dt

	return math.lerp(self._fade_from_value, self._fade_to_value, math.clamp(self._fade_timer / self._fade_duration, 0, 1))
end

function SoundDucker:destroy()
	return
end
