-- chunkname: @scripts/managers/backend/backend_manager.lua

require("scripts/managers/backend/script_backend_token")

BackendManager = class(BackendManager)

function BackendManager:available()
	return script_data.settings.backend and rawget(_G, "Backend") ~= nil
end

function BackendManager:connect(ip_address, project_id, connection_type, port, interface, callback)
	local token = Backend.connect(ip_address, project_id, connection_type, port, interface)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:connected()
	return Backend.connected()
end

function BackendManager:login(username, password, callback)
	local token = Backend.login(username, password)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:steam_login(callback)
	local token = Backend.steam_login()
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:create_profile(profile_name, profile_data, profile_attributes, callback)
	local token = Backend.create_profile(profile_name, profile_data, profile_attributes)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:select_profile(profile_id, callback)
	local token = Backend.select_profile(profile_id)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:update_profile(profile_data, callback)
	local token = Backend.update_profile(profile_data)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:drop_profile(profile_id, callback)
	local token = Backend.drop_profile(profile_id)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:set_profile_attribute(profile_id, attribute_name, attribute_value, callback)
	local token = Backend.set_profile_attribute(profile_id, attribute_name, attribute_value)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:set_profile_attributes(profile_id, attributes, callback)
	local token = Backend.set_profile_attributes(profile_id, attributes)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:update_profile_attributes(profile_id, attributes, callback)
	local token = Backend.update_profile_attributes(profile_id, attributes, callback)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:get_profile_attributes(profile_id, callback)
	local token = Backend.get_profile_attributes(profile_id)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:create_entity(profile_id, entity_type_id, entity_name, entity_attributes, callback)
	local token = Backend.create_entity(profile_id, entity_type_id, entity_name, entity_attributes)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:create_entities(entities, callback)
	local token = Backend.create_entities(entities)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:drop_entity(entity_id, callback)
	local token = Backend.drop_entity(entity_id)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:get_entities(profile_id, callback)
	local token = Backend.get_entities(profile_id)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:get_entity_types(callback)
	local token = Backend.get_entity_types()
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:set_entity_attribute(entity_id, attribute_name, attribute_value, callback)
	local token = Backend.set_entity_attribute(entity_id, attribute_name, attribute_value)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:save_stats(stats, callback)
	local token = Backend.save_stats(stats)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:load_stats(group_name, owners, callback)
	local token = Backend.load_stats(group_name, type(owners) == "table" and unpack(owners) or owners)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:save_telemetry(group_name, data, callback)
	local token = Backend.save_telemetry(group_name, data)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:get_currencies(callback)
	local token = Backend.get_currencies()
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:get_market_items(all_items, callback)
	local token = Backend.get_market_items(all_items or false)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:purchase_item(market_item_id, currency_id, callback)
	local token = Backend.purchase_item(market_item_id, currency_id)
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:get_store_items(callback)
	local token = Backend.get_store_items()
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:purchase_store_item(item_id, quantity, callback)
	local token = Backend.purchase_store_item(item_id, quantity, Steam:language())
	local backend_token = ScriptBackendToken:new(token)

	Managers.token:register_token(backend_token, callback)
end

function BackendManager:logout(callback)
	Backend.logout()
end

function BackendManager:disconnect(callback)
	Backend.disconnect()
end
