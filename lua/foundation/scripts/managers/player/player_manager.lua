-- chunkname: @foundation/scripts/managers/player/player_manager.lua

PlayerManager = class(PlayerManager)
PlayerManager.MAX_PLAYERS = 4

function PlayerManager:init()
	self._players = {}
	self._unit_owners = {}
end

function PlayerManager:add_player(player_index, controller_map_index, input_source, viewport_name, viewport_world_name)
	fassert(self._players[player_index] == nil, "[PlayerManager:add_player] Trying to add player %q to already existing index.", player_index)

	self._players[player_index] = Player:new(player_index, controller_map_index, input_source, viewport_name, viewport_world_name)
end

function PlayerManager:assign_unit_ownership(unit, player_index)
	fassert(self._unit_owners[unit] == nil, "[PlayerManager:add_unit_ownership] Unit %s already is owned by player %q and can't be assigned to player %q", unit, self._unit_owners[unit] and self._unit_owners[unit].index, player_index)
	fassert(self._players[player_index], "[PlayerManager:add_unit_ownership] Unit %s cannot be assigned to be owned by player %q as this player does not exist.", unit, player_index)

	self._unit_owners[unit] = self._players[player_index]
	self._players[player_index].owned_units[unit] = unit

	Unit.set_data(unit, "owner_player_index", player_index)
end

function PlayerManager:relinquish_unit_ownership(unit)
	fassert(self._unit_owners[unit], "[PlayerManager:relinquish_unit_ownership] Unit %s ownership cannot be relinquished, not owned.", unit)

	local unit_owner = self._unit_owners[unit]

	self._unit_owners[unit] = nil
	unit_owner.owned_units[unit] = nil

	Unit.set_data(unit, "owner_player_index", nil)
end

function PlayerManager:remove_player(player_index)
	local player = self._players[player_index]
	local owned_units = player.owned_units

	for unit, _ in pairs(owned_units) do
		self:relinquish_unit_ownership(unit)
	end

	self._players[player_index] = nil

	player:destroy()
end

function PlayerManager:player_exists(player_index)
	return self._players[player_index] ~= nil
end

function PlayerManager:player(index)
	local player = self._players[index]

	fassert(player, "Player with index %q does not exist", index)

	return player
end

function PlayerManager:players()
	return self._players
end

function PlayerManager:owner(unit)
	return self._unit_owners[unit]
end
