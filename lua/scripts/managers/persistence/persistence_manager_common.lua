-- chunkname: @scripts/managers/persistence/persistence_manager_common.lua

local function real_value(stat, value)
	local type_name = type(stat.value)

	if type_name == "number" then
		return tonumber(value)
	elseif type_name == "boolean" then
		return to_boolean(value)
	else
		return value
	end
end

local function check_unlock(source, key)
	local market_price = source[key].market_price
	local required_dlc = source[key].required_dlc
	local demo_locked = source[key].demo_locked

	if IS_DEMO and demo_locked then
		return false
	end

	if required_dlc then
		return true
	else
		return market_price == nil
	end
end

local function check_unlock_attachment(attachment)
	local market_price = attachment.market_price
	local required_dlc = attachment.required_dlc

	if required_dlc then
		return true
	else
		return market_price == nil
	end
end

local IsUnlockOwned = {
	gear = function(unlock)
		return check_unlock(Gear, unlock.name)
	end,
	gear_attachment = function()
		return true
	end,
	armour = function(unlock)
		return check_unlock(Armours, unlock.name)
	end,
	armour_attachment = function(unlock)
		return check_unlock_attachment(unlock.attachment)
	end,
	helmet = function(unlock)
		return check_unlock(Helmets, unlock.name)
	end,
	helmet_attachment = function(unlock)
		return check_unlock_attachment(unlock.attachment)
	end,
	perk = function(unlock)
		return check_unlock(Perks, unlock.name)
	end,
	profile = function(unlock)
		return check_unlock(PlayerProfiles, profile_index_by_unlock(unlock.name))
	end,
	coat_of_arms = function()
		return false
	end
}

PersistenceManagerCommon = class(PersistenceManagerCommon)

function PersistenceManagerCommon:init()
	self._entity_types = {}
end

function PersistenceManagerCommon:is_unlock_owned(unlock)
	return IsUnlockOwned[unlock.category](unlock)
end

function PersistenceManagerCommon:process_unlocks(player_backend_profile_id, unlocks, cb)
	local entities = {}

	for full_name, unlock in pairs(unlocks) do
		if self:is_unlock_owned(unlock) then
			entities[#entities + 1] = {
				profile_id = player_backend_profile_id,
				type = self._entity_types[unlock.category],
				name = unlock.name,
				full_name = full_name
			}
		end
	end

	if table.size(entities) > 0 then
		local callback = callback(self, "cb_unlocks_processed", player_backend_profile_id, cb, entities)

		Managers.backend:create_entities(entities, callback)
	elseif cb then
		cb(entities)
	end
end

function PersistenceManagerCommon:cb_unlocks_processed(player_backend_profile_id, cb, unlocked_entities, response)
	if response.error == nil then
		printf("Unlocks successfully processed for player with profile id = %d", player_backend_profile_id)

		if cb then
			cb(unlocked_entities)
		end
	else
		printf("Error processing unlocks for player with profile id = %d: %s", player_backend_profile_id, response.error)
	end
end

function PersistenceManagerCommon:_parse_profile_attributes(attributes)
	for name, value in pairs(attributes) do
		local stat = StatsContexts.player[name]

		if stat then
			attributes[name] = real_value(stat, attributes[name])
		else
			Application.warning("Stat %q doesn't exist in StatsContexts", name)
		end
	end

	if not attributes.experience then
		table.dump(attributes, "Attributes", 2)
	end

	attributes.rank = xp_to_rank(attributes.experience)

	return attributes
end

function PersistenceManagerCommon:_parse_profile_entities(entities)
	for _, entity in pairs(entities) do
		entity.type = self._entity_types[entity.type]
	end

	return entities
end

function PersistenceManagerCommon:_parse_entity_types(entity_types)
	for _, entity_type in pairs(entity_types) do
		self._entity_types[entity_type.name] = entity_type.type_id
		self._entity_types[entity_type.type_id] = entity_type.name
	end
end

function PersistenceManagerCommon:update(t, dt)
	return
end
