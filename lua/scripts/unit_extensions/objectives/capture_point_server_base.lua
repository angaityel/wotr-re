-- chunkname: @scripts/unit_extensions/objectives/capture_point_server_base.lua

CapturePointServerBase = class(CapturePointServerBase)
CapturePointServerBase.SERVER_ONLY = true
CapturePointServerBase.SYSTEM = "objective_system"

function CapturePointServerBase:init(world, unit)
	self._world = world
	self._unit = unit
	self._active = {}
	self._id = nil
	self._owner = "neutral"
	self._blackboard = {
		owner_team_side = "neutral",
		active_team_sides = {}
	}

	local current_level = LevelHelper:current_level(self._world)
	local level_unit_index = Level.unit_index(current_level, unit)

	Unit.set_data(unit, "level_unit_index", level_unit_index)
	Managers.state.event:register(self, "event_start_round", "event_start_round", "event_round_started", "event_round_started")
	self:set_owner("neutral", true)
end

function CapturePointServerBase:event_start_round(params)
	self:_init_teams()
end

function CapturePointServerBase:objective(side)
	local unit = self._unit

	return Unit.get_data(unit, "hud", "objective", side, "name"), Unit.get_data(unit, "hud", "objective", side, "priority")
end

function CapturePointServerBase:event_round_started(params)
	if Managers.state.network:game() then
		self:_create_game_object()
	end
end

function CapturePointServerBase:_init_teams()
	local teams = Managers.state.team:sides()

	for _, team in pairs(teams) do
		self._active[team] = false
	end
end

function CapturePointServerBase:_create_game_object()
	local unit = self._unit
	local data_table = {
		game_object_created_func = NetworkLookup.game_object_functions.cb_capture_point_created,
		owner_destroy_func = NetworkLookup.game_object_functions.cb_do_nothing,
		object_destroy_func = NetworkLookup.game_object_functions.cb_capture_point_destroyed,
		level_unit_index = Unit.get_data(self._unit, "level_unit_index"),
		owner = NetworkLookup.team[self._owner]
	}

	for team, active in pairs(self._active) do
		data_table[team .. "_active"] = active
	end

	local callback = callback(self, "cb_game_session_disconnect")

	self._id = Managers.state.network:create_game_object("capture_point", data_table, callback, "cb_local_capture_point_created", unit)
	self._game = Managers.state.network:game()
end

function CapturePointServerBase:cb_game_session_disconnect()
	self._frozen = true
	self._id = nil
end

function CapturePointServerBase:set_owner(owner, no_flow_events)
	local unit = self._unit

	Unit.set_data(unit, "side", owner)

	if not no_flow_events then
		if self._owner ~= "neutral" then
			Unit.flow_event(unit, "lua_neutralized_" .. self._owner)
		end

		if owner ~= "neutral" then
			Unit.flow_event(unit, "lua_captured_" .. owner)
		end
	end

	self._owner = owner
	self._blackboard.owner_team_side = owner

	local game = Managers.state.network:game()

	if game and self._id then
		GameSession.set_game_object_field(game, self._id, "owner", NetworkLookup.team[owner])
	end

	local team = Managers.state.team:team_by_side(owner)
	local team_name

	if team then
		team_name = team.name
	else
		team_name = "neutral"
	end

	Unit.flow_event(self._unit, "lua_set_team_name_" .. team_name)
end

function CapturePointServerBase:flow_cb_set_active(team_side, active)
	local no_active_before = true
	local no_active_after = true

	self._blackboard.active_team_sides[team_side] = active

	for _, team_side in pairs(Managers.state.team:sides()) do
		if self._blackboard.active_team_sides[team_side] then
			no_active_after = false
		end

		if self._active[team_side] then
			no_active_before = false
		end
	end

	if active and no_active_before then
		Managers.state.event:trigger("objective_activated", self._blackboard, self._unit)
	elseif not active and no_active_after then
		Managers.state.event:trigger("objective_deactivated", self._unit)
	end

	self._active[team_side] = active

	if self._id and Managers.state.network:game() then
		GameSession.set_game_object_field(Managers.state.network:game(), self._id, team_side .. "_active", active)
	end
end

function CapturePointServerBase:level_index()
	return Unit.get_data(self._unit, "level_unit_index")
end

function CapturePointServerBase:active(side)
	return self._active[side]
end

function CapturePointServerBase:owned(side)
	return self._owner == side
end

function CapturePointServerBase:destroy()
	return
end
