-- chunkname: @scripts/managers/persistence/persistence_manager_client_offline.lua

PersistenceManagerClientOffline = class(PersistenceManagerClientOffline)

function PersistenceManagerClientOffline:init()
	print("PersistenceManagerClientOffline")
end

function PersistenceManagerClientOffline:connect(connect_callback)
	connect_callback()
end

function PersistenceManagerClientOffline:load_market(market_callback)
	market_callback({})
end

function PersistenceManagerClientOffline:load_store(store_callback)
	store_callback({})
end

function PersistenceManagerClientOffline:profile_id()
	return -1
end

function PersistenceManagerClientOffline:load_profile(profile_callback)
	profile_callback({})
end

function PersistenceManagerClientOffline:profile_data()
	return nil
end

function PersistenceManagerClientOffline:store()
	return {}
end

function PersistenceManagerClientOffline:update()
	return
end
