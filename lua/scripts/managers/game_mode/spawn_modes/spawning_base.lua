-- chunkname: @scripts/managers/game_mode/spawn_modes/spawning_base.lua

SpawningBase = class(SpawningBase)

function SpawningBase:init(settings, game_mode)
	self._settings = settings

	local mode = settings.squad_spawn_mode

	fassert(not mode or mode == "on" or mode == "off" or mode == "no_combat", "[SpawningBase] Server setting spawning.squad_spawn_mode is: %q. Valid values are: \"on\", \"off\", \"no_combat\".")
end

function SpawningBase:round_started()
	return
end

function SpawningBase:squad_spawn_mode()
	return self._settings.squad_spawn_mode or "on"
end

function SpawningBase:squad_spawn_stun()
	return self._settings.squad_spawn_stun or false
end

function SpawningBase:setup()
	return
end

function SpawningBase:next_spawn_time(player)
	ferror("[SpawningBase] next_spawn_time not implemented!")
end

function SpawningBase:update(dt, t)
	return
end
