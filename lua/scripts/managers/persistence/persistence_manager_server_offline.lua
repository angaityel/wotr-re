-- chunkname: @scripts/managers/persistence/persistence_manager_server_offline.lua

PersistenceManagerServerOffline = class(PersistenceManagerServerOffline)

function PersistenceManagerServerOffline:init()
	print("PersistenceManagerServerOffline:init")
end

function PersistenceManagerServerOffline:post_init()
	return
end

function PersistenceManagerServerOffline:setup()
	return
end

function PersistenceManagerServerOffline:save(callback)
	callback()
end

function PersistenceManagerServerOffline:process_unlocks()
	return
end

function PersistenceManagerServerOffline:update(t, dt)
	return
end
