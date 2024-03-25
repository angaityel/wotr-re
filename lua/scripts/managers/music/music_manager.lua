-- chunkname: @scripts/managers/music/music_manager.lua

require("scripts/settings/sound_ducking_settings")
require("foundation/scripts/util/sound_ducking/ducking_handler")

MusicManager = class(MusicManager)

function MusicManager:init()
	self._world = Managers.world:create_world("music_world", nil, nil, nil, Application.DISABLE_PHYSICS, Application.DISABLE_RENDERING)
	self._timpani_world = World.timpani_world(self._world)
end

function MusicManager:stop_all_sounds()
	self._timpani_world:stop_all()
end

function MusicManager:trigger_event(event_name)
	return TimpaniWorld.trigger_event(self._timpani_world, event_name)
end

function MusicManager:set_parameter(id, variable, value)
	TimpaniWorld.set_parameter(self._timpani_world, id, variable, value)
end

function MusicManager:update(dt, t)
	return
end
