-- chunkname: @scripts/entity_system/systems/behaviour/nodes/bt_avoid_players_action.lua

require("scripts/entity_system/systems/behaviour/nodes/bt_node")

BTAvoidPlayersAction = class(BTAvoidPlayersAction, BTNode)

function BTAvoidPlayersAction:init(...)
	BTAvoidPlayersAction.super.init(self, ...)
	fassert(self._input, "No input set for node %q", self._name)
end

function BTAvoidPlayersAction:setup(unit, blackboard, profile)
	self._team_filter = self._data and self._data.team_filter or "ally"
	self._picked_players = {}
end

function BTAvoidPlayersAction:run(unit, blackboard, t, dt)
	local players = blackboard[self._input]
	local steering = ScriptUnit.extension(unit, "ai_system"):steering()

	self._picked_players = self:_filter_players(unit, players)

	for player_unit, _ in pairs(self._picked_players) do
		steering:avoid(player_unit)
	end
end

function BTAvoidPlayersAction:_filter_players(unit, players)
	if self._team_filter == "all" then
		return self._players
	end

	table.clear(self._picked_players)

	if self._team_filter == "enemy" then
		for player_unit, _ in pairs(players) do
			if not Managers.state.team:is_on_same_team(unit, player_unit) then
				self._picked_players[player_unit] = true
			end
		end
	elseif self._team_filter == "ally" then
		for player_unit, _ in pairs(players) do
			if Managers.state.team:is_on_same_team(unit, player_unit) then
				self._picked_players[player_unit] = true
			end
		end
	end

	return self._picked_players
end
