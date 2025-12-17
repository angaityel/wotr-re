-- chunkname: @scripts/managers/spawn/spawn_manager.lua

SpawnManager = class(SpawnManager)

local SPAWN_UPWARD_OFFSET = Vector3Box(0, 0, 0.1)
local CHECKED_SQUAD_SPAWN_POINT_POSITIONS = 10
local MAX_SQUAD_SPAWN_DISTANCE = 8

function SpawnManager:init(world)
	self._world = world
	self._spawn_areas = {}
	self._sp_spawn_area_names = {}
	self._active_spawn_areas_per_team = {}
	self._spawn_area_priority_per_team = {}
	self._highest_spawn_area_priority = {}

	for _, team_name in pairs(Managers.state.team:names()) do
		self._active_spawn_areas_per_team[team_name] = {}
		self._spawn_area_priority_per_team[team_name] = {}
		self._highest_spawn_area_priority[team_name] = 1
	end

	self._num_spawn_areas = 0
	self._spawning = false

	Managers.state.event:register(self, "player_knocked_down", "event_player_knocked_down")
	Managers.state.event:register(self, "player_instakilled", "event_player_instakilled")
	Managers.state.event:register(self, "player_unit_dead", "event_player_unit_dead")
	Managers.state.event:register(self, "team_set", "event_team_set")
end

function SpawnManager:event_team_set(player)
	if player.team and (Managers.lobby.server or not Managers.lobby.lobby) then
		self:set_spawn_timer(player)
	end
end

function SpawnManager:event_player_knocked_down(knocked_down_player, attacking_player, gear_name, damagers, damage_type)
	if Managers.lobby.server or not Managers.lobby.lobby then
		self:set_spawn_timer(knocked_down_player)
	end
end

function SpawnManager:event_player_instakilled(instakilled_player, attacking_player, gear_name, damagers, damage_type)
	if Managers.lobby.server or not Managers.lobby.lobby then
		self:set_spawn_timer(instakilled_player)
	end
end

function SpawnManager:event_player_unit_dead(player)
	local spawn_data = player.spawn_data

	spawn_data.state = "dead"
	spawn_data.mode = nil
end

function SpawnManager:set_spawn_timer(player)
	local spawn_timer = Managers.state.game_mode:next_spawn_time(player)

	player.spawn_data.timer = spawn_timer

	local game = Managers.state.network:game()

	if player.game_object_id and game then
		if spawn_timer == math.huge then
			spawn_timer = -1
		end

		GameSession.set_game_object_field(game, player.game_object_id, "spawn_timer", spawn_timer)
	end
end

function SpawnManager:destroy()
	return
end

function SpawnManager:activate_editor_spawnpoint(unit)
	self._editor_spawn_point = unit
end

function SpawnManager:create_spawn_area(name, volumes)
	fassert(not self._spawn_areas[name], "Trying to create spawn area with name %s but there already exists a spawn with such a name.", name)

	local spawn_area_index = self._num_spawn_areas + 1
	local level = LevelHelper:current_level(self._world)
	local pos = Vector3(0, 0, 0)

	for _, volume in ipairs(volumes) do
		pos = pos + Level.random_point_inside_volume(level, volume)
	end

	pos = pos / #volumes
	self._spawn_areas[name] = {
		volumes = volumes,
		network_lookup = spawn_area_index,
		position = Vector3Box(pos),
		spawn_rotations = {}
	}
	self._num_spawn_areas = spawn_area_index
end

function SpawnManager:activate_spawn_area(name, team_name, spawn_direction)
	if self._active_spawn_areas_per_team[team_name][name] then
		printf("Trying to activate spawn area %s for side %s that is already activated.", name, team_name)
	end

	fassert(self._spawn_areas[name], "Trying to activate spawn area %s that doesn't exist.", name)

	self._active_spawn_areas_per_team[team_name][name] = true

	local lobby_manager = Managers.lobby
	local multiplayer = lobby_manager.lobby
	local server = lobby_manager.server
	local spawn_area

	if not multiplayer or server then
		spawn_area = self._spawn_areas[name]
		spawn_area.spawn_rotations[team_name] = QuaternionBox(Quaternion.look(Vector3.flat(spawn_direction), Vector3.up()))
	end

	if server then
		Managers.state.network:send_rpc_clients("rpc_activate_spawn_area", spawn_area.network_lookup, NetworkLookup.team[team_name])
	end
end

function SpawnManager:deactivate_spawn_area(name, team_name)
	if not self._active_spawn_areas_per_team[team_name][name] then
		printf("Trying to deactivate spawn area %s for side %s that is already deactivated.", name, team_name)
	end

	fassert(self._spawn_areas[name], "Trying to deactivate spawn area %s that doesn't exist.", name)

	self._active_spawn_areas_per_team[team_name][name] = nil

	if Managers.lobby.server then
		local spawn_area = self._spawn_areas[name]

		Managers.state.network:send_rpc_clients("rpc_deactivate_spawn_area", spawn_area.network_lookup, NetworkLookup.team[team_name])
	end
end

function SpawnManager:activate_sp_spawn_area(name, team_name, spawn_direction, spawn_profile)
	if self._active_spawn_areas_per_team[team_name][name] then
		printf("Trying to activate spawn area %s for side %s that is already activated.", name, team_name)
	end

	fassert(self._spawn_areas[name], "Trying to activate spawn area %s that doesn't exist.", name)

	self._active_spawn_areas_per_team[team_name][name] = true

	local spawn_area = self._spawn_areas[name]

	spawn_area.spawn_rotations[team_name] = QuaternionBox(Quaternion.look(Vector3.flat(spawn_direction), Vector3.up()))
	spawn_area.spawn_profile = spawn_profile
	self._sp_spawn_area_names[#self._sp_spawn_area_names + 1] = name
end

function SpawnManager:deactivate_sp_spawn_area(name, team_name)
	if not self._active_spawn_areas_per_team[team_name][name] then
		printf("Trying to deactivate spawn area %s for side %s that is already deactivated.", name, team_name)
	end

	fassert(self._spawn_areas[name], "Trying to deactivate spawn area %s that doesn't exist.", name)

	self._active_spawn_areas_per_team[team_name][name] = nil

	for key, area_name in ipairs(self._sp_spawn_area_names) do
		if name == area_name then
			table.remove(self._sp_spawn_area_names, key)
		end
	end
end

function SpawnManager:set_spawn_area_priority(name, team_name, priority)
	fassert(self._spawn_areas[name], "Trying to activate spawn area %s that doesn't exist.", name)

	for prio, areas in pairs(self._spawn_area_priority_per_team[team_name]) do
		if areas[name] then
			areas[name] = nil

			break
		end
	end

	self._spawn_area_priority_per_team[team_name][priority] = self._spawn_area_priority_per_team[team_name][priority] or {}
	self._spawn_area_priority_per_team[team_name][priority][name] = true

	if priority > self._highest_spawn_area_priority[team_name] then
		self._highest_spawn_area_priority[team_name] = priority
	end

	if Managers.lobby.server then
		Managers.state.network:send_rpc_clients("rpc_set_spawn_area_priority", self._spawn_areas[name].network_lookup, NetworkLookup.team[team_name], priority)
	end
end

function SpawnManager:spawn_area_with_highest_priority(team_name)
	local active_areas = {}

	for i = self._highest_spawn_area_priority[team_name], 1, -1 do
		local areas = self._spawn_area_priority_per_team[team_name][i]

		if areas and table.size(areas) > 0 then
			local found_area

			for area_name, _ in pairs(areas) do
				if self._active_spawn_areas_per_team[team_name][area_name] then
					active_areas[#active_areas + 1] = area_name
					found_area = true
				end
			end

			if found_area then
				break
			end
		end
	end

	return active_areas[math.random(1, #active_areas)]
end

function SpawnManager:random_area_name(team_name)
	local active_areas = {}

	for area_name, _ in pairs(self._active_spawn_areas_per_team[team_name]) do
		active_areas[#active_areas + 1] = area_name
	end

	if #active_areas > 0 then
		return active_areas[math.random(1, #active_areas)]
	end
end

function SpawnManager:activate_spawning()
	self._spawning = true
end

function SpawnManager:deactivate_spawning()
	self._spawning = false
end

function SpawnManager:spawn_areas()
	return self._spawn_areas
end

function SpawnManager:active_spawn_areas(team_name)
	return self._active_spawn_areas_per_team[team_name]
end

function SpawnManager:set_unconfirmed_squad_spawn_target(player, squad_unit)
	if Managers.lobby.server or not Managers.lobby.lobby then
		if not self:valid_squad_spawn_target(player, squad_unit, false) then
			RPC.rpc_spawn_target_denied(player:network_id())

			return
		end

		if player.spawn_data.state == "ghost_mode" then
			self:despawn_player_unit(player)
		end

		player.spawn_data.mode = "unconfirmed_squad_member"
		player.spawn_data.squad_unit = squad_unit

		if player.remote and Managers.state.network:game() then
			local unit_game_object_id = Managers.state.network:game_object_id(squad_unit)

			RPC.rpc_unconf_sq_spawn_target_set(player:network_id(), player:player_id(), unit_game_object_id)
		end
	else
		local unit_game_object_id = Managers.state.network:game_object_id(squad_unit)

		Managers.state.network:send_rpc_server("rpc_request_unconf_squad_spawn", player:player_id(), unit_game_object_id)
	end
end

function SpawnManager:rpc_request_unconf_squad_spawn(player, squad_unit)
	self:set_unconfirmed_squad_spawn_target(player, squad_unit)
end

function SpawnManager:rpc_unconf_sq_spawn_target_set(player, squad_unit)
	player.spawn_data.mode = "unconfirmed_squad_member"
	player.spawn_data.squad_unit = squad_unit
end

function SpawnManager:set_squad_spawn_target(player, squad_unit)
	if Managers.lobby.server or not Managers.lobby.lobby then
		if not self:valid_squad_spawn_target(player, squad_unit) then
			if Managers.state.network:game() then
				RPC.rpc_spawn_target_denied(player:network_id())
			end

			return
		end

		if player.spawn_data.state == "ghost_mode" then
			self:despawn_player_unit(player)
		end

		player.spawn_data.mode = "squad_member"
		player.spawn_data.squad_unit = squad_unit

		if player.remote and Managers.state.network:game() then
			local unit_game_object_id = Managers.state.network:game_object_id(squad_unit)

			RPC.rpc_squad_spawn_target_set(player:network_id(), player:player_id(), unit_game_object_id)
		end
	elseif Managers.state.network:game() then
		local unit_game_object_id = Managers.state.network:game_object_id(squad_unit)

		Managers.state.network:send_rpc_server("rpc_request_squad_spawn_target", player:player_id(), unit_game_object_id)
	end
end

function SpawnManager:rpc_request_squad_spawn_target(player, squad_unit)
	self:set_squad_spawn_target(player, squad_unit)
end

function SpawnManager:rpc_squad_spawn_target_set(player, squad_unit)
	player.spawn_data.mode = "squad_member"
	player.spawn_data.squad_unit = squad_unit
end

function SpawnManager:set_area_spawn_target(player, area_name)
	if Managers.lobby.server or not Managers.lobby.lobby then
		if not self:valid_area_spawn_target(player, area_name) then
			if Managers.state.network:game() then
				RPC.rpc_spawn_target_denied(player:network_id())
			end

			return
		end

		if player.spawn_data.state == "ghost_mode" then
			self:despawn_player_unit(player)
		end

		player.spawn_data.mode = "area"
		player.spawn_data.area_name = area_name
	elseif Managers.state.network:game() then
		Managers.state.network:send_rpc_server("rpc_request_area_spawn_target", player.temp_random_user_id, self._spawn_areas[area_name].network_lookup)
	end
end

function SpawnManager:rpc_request_area_spawn_target(player, area_name_network_lookup)
	local area_name = self:network_lookup_to_area_name(area_name_network_lookup)

	self:set_area_spawn_target(player, area_name)
end

function SpawnManager:network_lookup_to_area_name(network_lookup)
	for area_name, area in pairs(self._spawn_areas) do
		if area.network_lookup == network_lookup then
			return area_name
		end
	end

	ferror("[SpawnManager] Can't find area with lookup %s.", network_lookup)
end

function SpawnManager:update(dt, t)
	local round_timer = Managers.time:time("round")

	if EDITOR_LAUNCH then
		self:_update_spawn_editor_simulation(dt, t)
	else
		self:_update_spawn(dt, round_timer)
	end
end

function SpawnManager:_update_spawn(dt, t)
	local network_game = Managers.state.network:game()

	if Managers.lobby.lobby and (not network_game or not Managers.lobby.server) or self._spawning == false then
		return
	end

	local player_manager = Managers.player
	local players = player_manager:players()

	for player_index, player in pairs(players) do
		if not player.ai_player then
			local spawn_data = player.spawn_data

			if spawn_data.timer == math.huge then
				self:set_spawn_timer(player)
			end

			if spawn_data.state == "dead" or spawn_data.state == "not_spawned" then
				self:_check_spawn(player, spawn_data)

				if not Managers.state.game_mode:squad_screen_spawning() then
					self:_update_sp_spawn(spawn_data)
				end

				if spawn_data.mode == "area" and spawn_data.area_name then
					self:_spawn_player_unit_in_area(player, spawn_data.area_name)
				elseif spawn_data.mode == "squad_member" and t >= spawn_data.timer then
					local spawn_unit = Unit.alive(spawn_data.squad_unit) and spawn_data.squad_unit

					if spawn_unit then
						self:_spawn_player_unit_at_unit(player, spawn_unit)
					end
				end
			elseif spawn_data.state == "ghost_mode" then
				self:_check_spawn(player, spawn_data)
			end
		end
	end
end

function SpawnManager:force_spawn()
	local network_game = Managers.state.network:game()

	if Managers.lobby.lobby and (not network_game or not Managers.lobby.server) then
		return
	end

	local player_manager = Managers.player
	local players = player_manager:players()

	for player_index, player in pairs(players) do
		if not player.ai_player then
			local spawn_data = player.spawn_data

			if spawn_data.state == "dead" or spawn_data.state == "not_spawned" then
				self:_check_spawn(player, spawn_data)

				if not Managers.state.game_mode:squad_screen_spawning() then
					self:_update_sp_spawn(spawn_data)
				end

				if spawn_data.mode == "area" and spawn_data.area_name then
					self:_spawn_player_unit_in_area(player, spawn_data.area_name)
				elseif spawn_data.mode == "squad_member" and t >= spawn_data.timer then
					self:_spawn_player_unit_at_unit(player, spawn_data.squad_unit, true)
				end
			elseif spawn_data.state == "ghost_mode" then
				self:_check_spawn(player, spawn_data)

				if spawn_data.mode == "area" then
					self:_force_leave_ghost_mode(player)
				end
			end
		end
	end
end

function SpawnManager:_update_sp_spawn(spawn_data)
	local sp_spawn_area_amount = #self._sp_spawn_area_names

	if spawn_data.mode ~= "area" and sp_spawn_area_amount >= 1 then
		spawn_data.mode = "area"
		spawn_data.area_name = self._sp_spawn_area_names[math.random(1, sp_spawn_area_amount)]

		local level = LevelHelper:current_level(self._world)

		Level.trigger_event(level, "sp_player_spawned")
	end
end

function SpawnManager:spawn_timer(player)
	local t = Managers.time:time("round")

	if t then
		if Managers.lobby.server or not Managers.lobby.lobby then
			if player.spawn_data.timer then
				return player.spawn_data.timer - t
			end
		elseif Managers.state.network:game() then
			local spawn_timer = GameSession.game_object_field(Managers.state.network:game(), player.game_object_id, "spawn_timer")

			if spawn_timer == -1 then
				spawn_timer = math.huge
			end

			return spawn_timer - t
		end
	end
end

function SpawnManager:allowed_to_leave_ghost_mode(player)
	local robot_player = GameSettingsDevelopment.enable_robot_player and player.spawn_data.state == "ghost_mode"
	local ready_to_spawn = player.spawn_data.state == "ghost_mode" and Managers.time:time("round") >= 0 and self:spawn_timer(player) <= 0

	return robot_player or ready_to_spawn
end

function SpawnManager:request_leave_ghost_mode(player, ghost_player_unit)
	if Managers.lobby.server or not Managers.lobby.lobby then
		self:_leave_ghost_mode(player, ghost_player_unit)
	else
		Managers.state.network:send_rpc_server("rpc_request_leave_ghost_mode", player:player_id(), Managers.state.network:game_object_id(ghost_player_unit))
	end
end

function SpawnManager:_leave_ghost_mode(player, ghost_player_unit)
	player.spawn_data.state = "spawned"
	player.spawn_data.spawns = player.spawn_data.spawns + 1

	local locomotion = ScriptUnit.extension(ghost_player_unit, "locomotion_system")

	locomotion:blend_out_of_ghost_mode()

	if GameSettingsDevelopment.enable_robot_player then
		local profile_name = Unit.get_data(ghost_player_unit, "player_profile")
		local profile = PlayerProfiles[profile_name]

		Managers.input:start_script_input(profile.script_input, true)
	end
end

function SpawnManager:_force_leave_ghost_mode(player)
	local player_unit = player.player_unit

	if not Unit.alive(player_unit) then
		return false
	end

	if player.remote then
		player.spawn_data.state = "spawned"
		player.spawn_data.spawns = player.spawn_data.spawns + 1

		RPC.rpc_leave_ghost_mode(player:network_id(), player:player_id(), Managers.state.network:game_object_id(player_unit))
	else
		self:_leave_ghost_mode(player, player_unit)
	end
end

function SpawnManager:rpc_request_leave_ghost_mode(sender, player, ghost_player_unit)
	if self:allowed_to_leave_ghost_mode(player) then
		player.spawn_data.state = "spawned"
		player.spawn_data.spawns = player.spawn_data.spawns + 1

		RPC.rpc_leave_ghost_mode(sender, player:player_id(), Managers.state.network:game_object_id(ghost_player_unit))
	end
end

function SpawnManager:rpc_leave_ghost_mode(player, player_unit)
	self:_leave_ghost_mode(player, player_unit)
end

function SpawnManager:_check_spawn(player, spawn_data)
	if spawn_data.mode == "unconfirmed_squad_member" or spawn_data.mode == "squad_member" then
		if not self:valid_squad_spawn_target(player, spawn_data.squad_unit) then
			spawn_data.mode = nil

			if Managers.lobby.lobby then
				RPC.rpc_spawn_target_denied(player:network_id())
			end
		end
	elseif spawn_data.mode == "area" and not self:valid_area_spawn_target(player, spawn_data.area_name) then
		spawn_data.mode = nil

		if Managers.lobby.lobby then
			RPC.rpc_spawn_target_denied(player:network_id())
		end
	end
end

function SpawnManager:valid_squad_spawn_target(player, squad_unit, verbose)
	local player_team = player.team
	local squad_spawn_mode = Managers.state.game_mode:squad_spawn_mode(player_team)

	if squad_spawn_mode == "off" then
		return false
	end

	if player.spawn_data.spawns >= Managers.state.game_mode:allowed_spawns(player.team) then
		return false
	end

	local squad_member = Managers.player:owner(squad_unit)

	if not squad_member or not squad_member.is_corporal or not player_team or player_team ~= squad_member.team or player.squad_index ~= squad_member.squad_index or player == squad_member then
		if verbose and squad_member then
			print("[SpawnManager:valid_squad_spawn_target] SPAWN DENIED!", "squad_member:", squad_member, "squad_member.is_corporal:", squad_member.is_corporal, "player.team:", player.team, "player.team == squad_member.team:", player_team == squad_member.team, "player.squad_index == squad_member.squad_index:", player.squad_index == squad_member.squad_index, "player ~= squad_member", player ~= squad_member)
		elseif verbose then
			print("[SpawnManager:valid_squad_spawn_target] SPAWN DENIED! squad_member == ", squad_member)
		end

		return false
	end

	if not Unit.alive(squad_unit) then
		if verbose then
			print("[SpawnManager:valid_squad_spawn_target] SPAWN DENIED!", "not Unit.alive( squad_unit ):", not Unit.alive(squad_unit))
		end

		return false
	end

	local damage_system = ScriptUnit.extension(squad_unit, "damage_system")
	local locomotion_system = ScriptUnit.extension(squad_unit, "locomotion_system")

	if damage_system:is_knocked_down() or damage_system:is_dead() or locomotion_system.ghost_mode then
		if verbose then
			print("[SpawnManager:valid_squad_spawn_target] SPAWN DENIED!", "damage_system:is_knocked_down():", damage_system:is_knocked_down(), "damage_system:is_dead():", damage_system:is_dead(), "locomotion_system.ghost_mode:", locomotion_system.ghost_mode)
		end

		return false
	end

	return true
end

function SpawnManager:valid_area_spawn_target(player, area_name)
	local allowed_spawns = Managers.state.game_mode:allowed_spawns(player.team)
	local spawns = player.spawn_data.spawns

	if allowed_spawns <= spawns then
		return false
	end

	if player.team and self._active_spawn_areas_per_team[player.team.name][area_name] then
		return true
	end
end

function SpawnManager:valid_spawn_areas_per_team(team_name)
	return self._active_spawn_areas_per_team[team_name]
end

function SpawnManager:valid_squad_spawn_targets_per_team(team_name)
	local team = Managers.state.team:team_by_name(team_name)
	local valid_targets = {}

	for _, squad in pairs(team.squads) do
		local corporal = squad:corporal()

		if corporal then
			local corporal_unit = corporal.player_unit

			if Unit.alive(corporal_unit) then
				local damage_system = ScriptUnit.extension(corporal_unit, "damage_system")
				local locomotion_system = ScriptUnit.extension(corporal_unit, "locomotion_system")

				if not damage_system:is_knocked_down() and not damage_system:is_dead() and not locomotion_system.ghost_mode then
					valid_targets[#valid_targets + 1] = corporal
				end
			end
		end
	end

	return valid_targets
end

function SpawnManager:_spawn_player_unit_in_area(player, area_name)
	local poly, spawn_point
	local world = self._world
	local physics_world = World.physics_world(world)
	local level = LevelHelper:current_level(world)
	local nav_mesh = Level.navigation_mesh(level)
	local area = self._spawn_areas[area_name]
	local profile = area.spawn_profile
	local volumes = area.volumes
	local volume
	local ghost_mode = true
	local drawer = Managers.state.debug:drawer({
		mode = "retained",
		name = "spawn_debug"
	})
	local count = 1
	local pos

	while not poly and count < 25 do
		volume = #volumes == 1 and volumes[1] or volumes[Math.random(#volumes)]
		spawn_point = Level.random_point_inside_volume(level, volume)
		poly = NavigationMesh.find_polygon(nav_mesh, spawn_point)
		count = count + 1

		if poly then
			pos = NavigationMesh.project_to_polygon(nav_mesh, spawn_point, poly) + SPAWN_UPWARD_OFFSET:unbox()

			if pos and not Managers.lobby.lobby then
				break
			end

			local hits = PhysicsWorld.overlap(physics_world, nil, "shape", "capsule", "position", pos + Vector3(0, 0, 0.675), "size", Vector3(0.49, 0.49, 0.675), "types", "statics", "collision_filter", "ghost_mode_mover")

			if #hits > 0 then
				if script_data.spawn_debug then
					drawer:capsule(pos, pos + Vector3(0, 0, 1.35), 0.49, Color(255, 0, 0))
				end

				poly = nil
			end

			if script_data.spawn_debug then
				drawer:capsule(pos, pos + Vector3(0, 0, 1.35), 0.49, Color(50, 50, 50))
			end
		end
	end

	if not poly then
		print("[SpawnManager] No valid spawn found at spawn", area_name, " check nav graph at location.")

		local level_key = Managers.state.game_mode:level_key()
		local level_list = {"level_test_01", "de_dust2"}

		local level_in_list = false
		for _, item in ipairs(level_list) do
		    if item == level_key then
		        level_in_list = true
		        break
		    end
		end

		if GameSettingsDevelopment.prototype_spawn_fallback or level_in_list then
			local rot = QuaternionBox.unbox(area.spawn_rotations[player.team.name])

			self:_spawn_player_unit(player, spawn_point, rot, ghost_mode, profile)
		end

		return
	end

	local rot = QuaternionBox.unbox(area.spawn_rotations[player.team.name] or QuaternionBox())

	if script_data.spawn_debug then
		print("Spawn:", rot, Quaternion.forward(rot))
	end

	self:_spawn_player_unit(player, pos, rot, ghost_mode, profile)
	Managers.state.event:trigger("player_spawned_in_area", player, pos)
end

function SpawnManager:_spawn_player_unit_at_unit(player, squad_unit, override_combat_check)
	local reason, pos, rot = self:calculate_valid_squad_spawn_point(player, squad_unit, override_combat_check)

	if not pos then
		return
	end

	local squad_player = Managers.player:owner(squad_unit)
	local camera_fwd_vector = Quaternion.forward(rot)
	local camera_flat_rot = Quaternion.look(Vector3.flat(camera_fwd_vector), Vector3.up())

	self:_spawn_player_unit(player, pos, camera_flat_rot, false)
	Managers.state.event:trigger("player_spawned_at_unit", player, squad_player, pos)
end

function SpawnManager:_squad_spawn_sanity_check(pos, squad_unit_pos)
	local world = self._world
	local physics_world = World.physics_world(world)
	local drawer = Managers.state.debug:drawer({
		mode = "retained",
		name = "spawn_debug"
	})
	local hits = PhysicsWorld.overlap(physics_world, nil, "shape", "capsule", "position", pos + Vector3(0, 0, 0.675), "size", Vector3(0.49, 0.49, 0.675), "types", "statics", "collision_filter", "ghost_mode_mover")

	if #hits > 0 then
		if script_data.spawn_debug then
			drawer:capsule(pos, pos + Vector3(0, 0, 1.35), 0.49, Color(255, 0, 0))
		end

		return false
	elseif script_data.spawn_debug then
		drawer:capsule(pos, pos + Vector3(0, 0, 1.35), 0.49, Color(50, 50, 50))
	end

	return Vector3.length(Vector3.flat(pos - squad_unit_pos)) < MAX_SQUAD_SPAWN_DISTANCE
end

function SpawnManager:calculate_valid_squad_spawn_point(player, squad_unit, override_combat_check)
	local squad_unit_pos = Unit.world_position(squad_unit, 0)
	local camera_pos, camera_rot
	local squad_spawn_mode = Managers.state.game_mode:squad_spawn_mode(player.team)
	local locomotion = squad_unit and ScriptUnit.has_extension(squad_unit, "locomotion_system") and ScriptUnit.extension(squad_unit, "locomotion_system")
	local in_combat = locomotion and locomotion.in_combat

	if squad_spawn_mode == "off" then
		return "spawn_error_no_squad_spawn"
	elseif squad_spawn_mode == "no_combat" and in_combat then
		return "spawn_error_in_combat"
	end

	if player.remote then
		local game = Managers.state.network:game()
		local obj_id = player.camera_game_object_id

		if game and obj_id then
			camera_pos = GameSession.game_object_field(game, obj_id, "position")
			camera_rot = GameSession.game_object_field(game, obj_id, "rotation")
		else
			return "spawn_error_no_camera"
		end
	else
		local camera_manager = Managers.state.camera
		local viewport = player.viewport_name

		camera_pos = camera_manager:camera_position(viewport)
		camera_rot = camera_manager:camera_rotation(viewport)
	end

	local poly
	local level = LevelHelper:current_level(self._world)
	local nav_mesh = Level.navigation_mesh(level)
	local spawn_point, pos
	local squad_member_poly = NavigationMesh.find_polygon(nav_mesh, squad_unit_pos)

	if not squad_member_poly then
		return "spawn_error_outside_navmesh"
	end

	for i = 1, CHECKED_SQUAD_SPAWN_POINT_POSITIONS do
		spawn_point = Vector3.lerp(camera_pos, squad_unit_pos, i / CHECKED_SQUAD_SPAWN_POINT_POSITIONS)
		poly = NavigationMesh.find_polygon(nav_mesh, spawn_point)

		local path = poly and NavigationMesh.search(nav_mesh, poly, squad_member_poly, 1.1, 5)

		if path and #path > 0 then
			local moved

			pos, moved = NavigationMesh.constrain_to_polygon(nav_mesh, spawn_point, poly)
			pos = NavigationMesh.project_to_polygon(nav_mesh, spawn_point, poly)

			if script_data.spawn_debug then
				Managers.state.debug:drawer({
					mode = "retained",
					name = "navmesh"
				}):navigation_mesh_search(nav_mesh)
			end

			pos = pos + SPAWN_UPWARD_OFFSET:unbox()

			if self:_squad_spawn_sanity_check(pos, squad_unit_pos) then
				break
			else
				pos = nil
			end
		end
	end

	if not pos then
		return "spawn_error_sanity_check_fail"
	end

	return "success", pos, camera_rot
end

function SpawnManager:spawn_mount(mount_profile, pos, rot, player_unit, ghost_mode)
	local unit_name = MountProfiles[mount_profile].unit
	local spawner_id
	local network_manager = Managers.state.network

	if network_manager:game() then
		spawner_id = network_manager:game_object_id(player_unit)
	end

	local mount_unit = World.spawn_unit(self._world, unit_name, pos, rot)

	Unit.set_data(mount_unit, "mount_profile", mount_profile)
	Managers.state.entity:register_unit(self._world, mount_unit, nil, nil, ghost_mode, spawner_id)

	return mount_unit
end

function SpawnManager:rpc_spawn_player_unit(player, pos, rot, ghost_mode, profile_index)
	self:_spawn_player_unit(player, pos, rot, ghost_mode, profile_index)
end

function SpawnManager:_spawn_player_unit(player, pos, rot, ghost_mode, profile_index)
	local spawn_data = player.spawn_data

	spawn_data.state = ghost_mode and "ghost_mode" or "spawned"

	if not ghost_mode then
		spawn_data.spawns = spawn_data.spawns + 1
	end

	if player.remote then
		RPC.rpc_spawn_player_unit(player:network_id(), player.index, pos, rot, ghost_mode, profile_index or 0)

		return
	end

	local profile_name = player.state_data.spawn_profile or profile_index
	local profile = Managers.state.game_mode:squad_screen_spawning() and PlayerProfiles[profile_name] or SPProfiles[profile_name]

	local game_mode = Managers.state.game_mode:game_mode_key()
	if game_mode == "grail" then
		profile = Managers.state.game_mode:squad_screen_spawning() and GrailProfiles[profile_name]
	end

	fassert(profile, "[SpawnManager] Trying to spawn with profile %q that doesn't exist in %q.", profile_name, Managers.lobby.lobby and "PlayerProfiles" or "SPProfiles")

	local unit_name = Armours[profile.armour].player_unit
	local unit = World.spawn_unit(self._world, unit_name, pos, rot)

	Unit.set_data(unit, "player_profile", profile_name)
	Managers.state.entity:register_unit(self._world, unit, player.index, ghost_mode, profile)

	if player.viewport_name then
		local viewport_name = player.viewport_name

		Unit.set_data(unit, "viewport_name", viewport_name)
	end

	return unit
end

function SpawnManager:rpc_player_unit_despawned(player)
	self:despawn_player_unit(player)
end

function SpawnManager:despawn_player_unit(player)
	player.spawn_data.state = "dead"

	if player.remote then
		RPC.rpc_player_unit_despawned(player:network_id(), player:player_id())

		return
	end

	local player_unit = player.player_unit
	local network_manager = Managers.state.network
	local game = network_manager:game()
	local entity_manager = Managers.state.entity
	local locomotion = ScriptUnit.extension(player_unit, "locomotion_system")
	local mounted_unit = locomotion.mounted_unit

	Managers.player:relinquish_unit_ownership(player_unit)

	if game then
		local object_id = network_manager:unit_game_object_id(player_unit)

		network_manager:destroy_game_object(object_id)
	else
		entity_manager:unregister_unit(player_unit)
		World.destroy_unit(self._world, player_unit)
	end

	if mounted_unit then
		if game then
			local object_id = network_manager:unit_game_object_id(mounted_unit)

			network_manager:destroy_game_object(object_id)
		else
			entity_manager:remove_unit(mounted_unit)
			World.destroy_unit(self._world, mounted_unit)
		end
	end
end

function SpawnManager:_update_spawn_editor_simulation(dt, t)
	local player_manager = Managers.player

	for player_index, player in ipairs(player_manager:players()) do
		local spawn_data = player.spawn_data
		local team_name = player.team.name

		if (spawn_data.state == "dead" or spawn_data.state == "not_spawned") and (team_name == "red" or team_name == "white") then
			local pose = Application.get_data("camera")
			local pos = Matrix4x4.translation(pose)
			local rot = Matrix4x4.rotation(pose)

			self:_spawn_player_unit(player, pos, rot, false)
		end
	end
end

function SpawnManager:hot_join_synch(sender, player)
	for team_name, areas in pairs(self._active_spawn_areas_per_team) do
		for area_name, _ in pairs(areas) do
			local spawn_area = self._spawn_areas[area_name]

			RPC.rpc_activate_spawn_area(sender, spawn_area.network_lookup, NetworkLookup.team[team_name])
		end
	end

	for team_name, priorities in pairs(self._spawn_area_priority_per_team) do
		for priority, areas in pairs(priorities) do
			for area_name, _ in pairs(areas) do
				Managers.state.network:send_rpc_clients("rpc_set_spawn_area_priority", self._spawn_areas[area_name].network_lookup, NetworkLookup.team[team_name], priority)
			end
		end
	end
end
