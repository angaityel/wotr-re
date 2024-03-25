-- chunkname: @scripts/entity_system/systems/deserting/deserting_system.lua

require("scripts/unit_extensions/default_player_unit/player_unit_deserter")

DesertingSystem = class(DesertingSystem)

function DesertingSystem:init(context, system_name)
	local em = context.entity_manager

	em:register_system(self, system_name)

	self.entity_manager = em
	self._extensions = {}
	self._world = context.world
	self._active_team_boundary_areas = {}

	for _, team_name in pairs(Managers.state.team:names()) do
		self._active_team_boundary_areas[team_name] = {}
	end

	local event_manager = Managers.state.event

	event_manager:register(self, "activate_boundary_area", "flow_cb_activate_boundary_area")
	event_manager:register(self, "deactivate_boundary_area", "flow_cb_deactivate_boundary_area")
end

function DesertingSystem:on_add_extension(world, unit, extension_name, extension_class, ...)
	if script_data.extension_debug then
		print(string.format("%s:on_add_component(unit, %s)", self.NAME, extension_name))
	end

	self._extensions[extension_name] = (self._extensions[extension_name] or 0) + 1
end

function DesertingSystem:on_remove_extension(unit, extension_name)
	return
end

function DesertingSystem:update(context, t)
	for extension_name, _ in pairs(self._extensions) do
		self:update_extension(extension_name, context, t)
	end
end

function DesertingSystem:update_extension(extension_name, context, t)
	local units = self.entity_manager:get_entities(extension_name)

	for unit, _ in pairs(units) do
		local timer = Unit.get_data(unit, "deserter_timer")
		local player = Managers.player:owner(unit)

		if player then
			local damage_extension = ScriptUnit.extension(unit, "damage_system")

			if self:_unit_in_active_boundary(unit) then
				if timer then
					self:_remove_desert_timer(unit, player)
				end
			elseif timer then
				if timer <= t then
					self:_kill_player(unit, player, damage_extension)
				end

				if damage_extension:is_dead() then
					self:_remove_desert_timer(unit, player)
				end
			elseif not damage_extension:is_dead() then
				self:_set_desert_timer(unit, player, t)
			end
		end
	end
end

function DesertingSystem:_set_desert_timer(unit, player, t)
	local game_mode_key = Managers.state.game_mode:game_mode_key()
	local deserter_timer = t + GameModeSettings[game_mode_key].deserter_timer

	Unit.set_data(unit, "deserter_timer", deserter_timer)

	if player.remote then
		local network_manager = Managers.state.network
		local player_network_id = player:network_id()
		local player_id = player:player_id()

		RPC.rpc_player_deserting(player_network_id, player_id, true, deserter_timer - t)
	else
		Managers.state.event:trigger("event_deserting_activated", player, deserter_timer - t)
	end
end

function DesertingSystem:_remove_desert_timer(unit, player)
	Unit.set_data(unit, "deserter_timer", nil)

	if player.remote then
		local network_manager = Managers.state.network
		local player_network_id = player:network_id()
		local player_id = player:player_id()

		RPC.rpc_player_deserting(player_network_id, player_id, false, 0)
	else
		Managers.state.event:trigger("event_deserting_deactivated", player)
	end
end

function DesertingSystem:_unit_in_active_boundary(unit)
	local position = Unit.world_position(unit, 0)
	local team_name = Unit.get_data(unit, "team_name")
	local team_boundaries = self._active_team_boundary_areas[team_name]
	local level = LevelHelper:current_level(self._world)

	if table.is_empty(team_boundaries) then
		return true
	end

	for boundary, _ in pairs(team_boundaries) do
		if Level.is_point_inside_volume(level, boundary, position) then
			return true
		end
	end

	return false
end

function DesertingSystem:_kill_player(unit, player, damage_extension)
	if player.remote then
		local network_manager = Managers.state.network
		local game_object_id = network_manager:game_object_id(unit)

		network_manager:send_rpc_server("rpc_suicide", game_object_id)
	else
		damage_extension:die(Managers.player:owner(unit))
	end
end

function DesertingSystem:flow_cb_activate_boundary_area(params)
	local team_name = Managers.state.team:name(params.side)
	local area = params.boundary_area

	self._active_team_boundary_areas[team_name][area] = true
end

function DesertingSystem:flow_cb_deactivate_boundary_area(params)
	local team_name = Managers.state.team:name(params.side)
	local area = params.boundary_area

	self._active_team_boundary_areas[team_name][area] = nil
end

function DesertingSystem:hot_join_synch(sender, player)
	return
end

function DesertingSystem:destroy()
	return
end
