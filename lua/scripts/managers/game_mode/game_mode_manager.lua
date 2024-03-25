-- chunkname: @scripts/managers/game_mode/game_mode_manager.lua

require("scripts/helpers/game_mode_helper")
require("scripts/settings/announcements")
require("scripts/settings/game_mode_settings")
require("scripts/settings/game_mode_objectives")
require("scripts/managers/game_mode/game_mode_events")
require("scripts/managers/game_mode/game_modes/game_mode_tdm")
require("scripts/managers/game_mode/game_modes/game_mode_battle")
require("scripts/managers/game_mode/game_modes/game_mode_conquest")
require("scripts/managers/game_mode/game_modes/game_mode_assault")
require("scripts/managers/game_mode/game_modes/game_mode_sp")
require("scripts/managers/game_mode/game_modes/game_mode_fly_through")
require("scripts/managers/game_mode/game_modes/game_mode_gpu_prof")
require("scripts/managers/game_mode/game_modes/game_mode_cpu_prof")
require("scripts/managers/game_mode/spawn_modes/pulse_spawning")
require("scripts/managers/game_mode/spawn_modes/single_player_spawning")
require("scripts/managers/game_mode/spawn_modes/battle_spawning")

GameModeManager = class(GameModeManager)

function GameModeManager:init(world, game_mode_key, level_key, win_score, time_limit, server_game_mode_scale)
	self._world = world
	self._game_mode_key = game_mode_key
	self._level_key = level_key
	self._end_conditions_met = false

	self:_init_game_mode(game_mode_key, win_score, time_limit)

	local event_manager = Managers.state.event

	event_manager:register(self, "player_unit_died", "event_player_unit_died")
	event_manager:register(self, "flag_planted", "event_flag_planted")
	event_manager:register(self, "objective_captured", "event_objective_captured")
	event_manager:register(self, "objective_captured_assist", "event_objective_captured_assist")
	event_manager:register(self, "section_cleared_payload", "event_section_cleared_payload")
	event_manager:register(self, "player_knocked_down", "event_player_knocked_down")
	event_manager:register(self, "player_bandaged", "event_player_bandaged")
	event_manager:register(self, "player_damaged", "event_player_damaged")
	event_manager:register(self, "mount_unit_dead", "event_mount_unit_dead")
	event_manager:register(self, "player_dotted", "event_player_dotted")
	event_manager:register(self, "reload_application_settings", "event_reload_application_settings")

	self._object_sets = nil
	self._modified_team_variations = {}
	self._team_variation_sets = {}
	self._object_set_names = nil
	self._server_game_mode_scale = server_game_mode_scale

	if Managers.lobby.lobby then
		self._game_mode_music = GameModeMusic:new(level_key, "normal", 0)
	else
		self._game_mode_music = GameModeMusicSP:new()
	end
end

function GameModeManager:force_limited_observer_cam(team)
	local locked = self._game_mode:force_limited_observer_cam(team)

	return locked
end

function GameModeManager:team_locked_observer_cam(team)
	local allowed = self._game_mode:team_locked_observer_cam(team)

	return allowed
end

function GameModeManager:squad_spawn_mode(team)
	local spawning = self._spawning
	local game = Managers.state.network:game()

	if spawning then
		local squad_spawn_mode = spawning:squad_spawn_mode(team)

		return squad_spawn_mode
	elseif game then
		local squad_spawn_mode = NetworkLookup.squad_spawn_modes[GameSession.game_object_field(game, team.game_object_id, "squad_spawn_mode")]

		return squad_spawn_mode
	else
		return "off"
	end
end

function GameModeManager:squad_spawn_stun(team)
	local spawning = self._spawning
	local game = Managers.state.network:game()

	if spawning then
		local squad_spawn_stun = spawning:squad_spawn_stun(team)

		return squad_spawn_stun
	elseif game then
		local squad_spawn_stun = GameSession.game_object_field(game, team.game_object_id, "squad_spawn_stun")

		return squad_spawn_stun
	else
		return "off"
	end
end

function GameModeManager:allowed_spawns(team)
	local spawns = self._game_mode:allowed_spawns(team)

	return spawns
end

function GameModeManager:allow_ghost_talking()
	return GameModeSettings[self._game_mode_key].allow_ghost_talking
end

GameModeMusic = class(GameModeMusic)

function GameModeMusic:init(level_key, start_state, start_volume)
	self._level_key = level_key
	self._start_event = LevelSettings[level_key].music
	self._stop_event = LevelSettings[level_key].stop_music
	self._state = start_state
	self._volume = start_volume
	self._cooldown = 0
	self._fade_time = 1
	self._transition_state = nil
	self._id = nil
end

function GameModeMusic:_get_win_scale_criterias(game_mode_key, level_key)
	local custom_win_scale_settings = LevelSettings[level_key].custom_win_scale_criteria
	local custom_game_mode_win_scale_settings = custom_win_scale_settings and custom_win_scale_settings[game_mode_key]

	if custom_game_mode_win_scale_settings then
		return custom_game_mode_win_scale_settings.critical, custom_game_mode_win_scale_settings.intense
	else
		return GameModeMusicSettings.critical.win_scale_criteria, GameModeMusicSettings.intense.win_scale_criteria
	end
end

function GameModeMusic:update(dt, t, win_scale, game_mode_key, level_key)
	if not self._start_event or not self._stop_event then
		return
	end

	local transition_state = self._transition_state
	local allow_transition = not transition_state and t > self._cooldown
	local state = self._state
	local critical_win_scale_criteria, intense_win_scale_criteria = self:_get_win_scale_criterias(game_mode_key, level_key)

	if state == "normal" then
		if allow_transition and critical_win_scale_criteria < win_scale then
			self:_start_critical("normal", t)

			self._id = Managers.music:trigger_event(self._start_event)
		elseif allow_transition and intense_win_scale_criteria < win_scale then
			self:_start_intense("normal", t)

			self._id = Managers.music:trigger_event(self._start_event)
		end
	elseif state == "intense" then
		if allow_transition and critical_win_scale_criteria < win_scale then
			self._cooldown = t + GameModeMusicSettings.critical.minimum_play_time
			self._transition_state = "critical"
			self._fade_time = t + GameModeMusicSettings.intense.fade_out_time
		elseif allow_transition and win_scale < intense_win_scale_criteria then
			self._cooldown = t + GameModeMusicSettings.critical.minimum_play_time
			self._transition_state = "normal"
			self._fade_time = t + GameModeMusicSettings.intense.fade_out_time
		elseif transition_state and t > self._fade_time then
			self["_start_" .. transition_state](self, "intense", t)
		elseif transition_state == "critical" then
			self._volume = math.clamp(1 - (self._fade_time - t) / GameModeMusicSettings.intense.fade_out_time, 0, 1)
		end
	elseif state == "critical" then
		if allow_transition and win_scale < intense_win_scale_criteria then
			self._cooldown = t + GameModeMusicSettings.critical.minimum_play_time
			self._transition_state = "normal"
			self._fade_time = t + GameModeMusicSettings.intense.fade_out_time
		elseif allow_transition and win_scale < critical_win_scale_criteria then
			self._cooldown = t + GameModeMusicSettings.intense.minimum_play_time
			self._transition_state = "intense"
			self._fade_time = t + GameModeMusicSettings.critical.fade_out_time
		elseif transition_state and t > self._fade_time then
			self["_start_" .. transition_state](self, "critical", t)
		elseif transition_state == "intense" then
			self._volume = math.clamp((self._fade_time - t) / GameModeMusicSettings.critical.fade_out_time, 0, 1)
		end
	end

	if script_data.sound_debug then
		print("GAME MODE MUSIC: state: ", self._state, " volume: ", self._volume)
	end

	self:_set_volume(self._volume)
end

function GameModeMusic:_set_volume(volume)
	local id = self._id

	if id then
		Managers.music:set_parameter(id, "music_stripped_volume", volume)
		Managers.music:set_parameter(id, "music_full_volume", volume)
	end
end

function GameModeMusic:_start_intense(from, t)
	self._state = "intense"
	self._volume = 0
	self._cooldown = t + GameModeMusicSettings.intense.minimum_play_time
	self._transition_state = nil
end

function GameModeMusic:_start_critical(from, t)
	self._state = "critical"
	self._volume = 1
	self._cooldown = t + GameModeMusicSettings.critical.minimum_play_time
	self._transition_state = nil
end

function GameModeMusic:_start_normal(from, t)
	Managers.music:trigger_event(self._stop_event)

	self._id = nil
	self._state = "normal"
	self._cooldown = t + GameModeMusicSettings.normal.minimum_play_time
	self._transition_state = nil
end

function GameModeMusic:destroy()
	self:stop()
end

function GameModeMusic:stop()
	if self._start_event and self._stop_event then
		self:_start_normal(self._state, 0)
	end

	self._fade_time = 0
end

GameModeMusicSP = class(GameModeMusicSP)

function GameModeMusicSP:init()
	return
end

function GameModeMusicSP:update(t, dt)
	return
end

function GameModeMusicSP:stop()
	return
end

function GameModeMusicSP:destroy()
	return
end

function GameModeManager:object_sets()
	return self._game_mode:object_sets()
end

function GameModeManager:register_object_sets(object_sets)
	self._object_sets = {}
	self._object_set_names = {}

	for set_name, set in pairs(object_sets) do
		self._object_sets[set_name] = set
		self._object_set_names[set.key] = set_name

		if set.type == "team" then
			self:_set_team_object_set_visibility(set, false)
		end

		if set_name == "shadow_lights" then
			local camera_manager = Managers.state.camera

			camera_manager:register_shadow_lights(set)
			camera_manager:set_shadow_lights(T(Application.user_setting("light_casts_shadows"), false), 1)
		end
	end
end

function GameModeManager:rpc_set_team_object_set_visible(key, visibility)
	local set = self._object_sets[self._object_set_names[key]]

	self:_set_team_object_set_visibility(set, visibility)
end

function GameModeManager:event_reload_application_settings()
	local shadow_lights = self._object_sets.shadow_lights

	if shadow_lights then
		Managers.state.camera:set_shadow_lights(T(Application.user_setting("light_casts_shadows"), false), 1)
	end
end

function GameModeManager:_hot_join_synch_object_sets(sender, player)
	for name, set in pairs(self._object_sets) do
		if set.visible then
			RPC.rpc_set_team_object_set_visible(sender, set.key, true)
		end

		if set.material_variation then
			RPC.rpc_set_object_set_variation(sender, set.key, NetworkLookup.team[set.material_variation])
		end
	end
end

function GameModeManager:flow_cb_set_team_set_variation(side, set_name)
	local team_name

	team_name = side == "neutral" and "neutral" or Managers.state.team:name(side)

	self:_set_object_set_team_material_variation(set_name, team_name)
end

function GameModeManager:_set_object_set_team_material_variation(set_name, team_name)
	local set = self._object_sets[set_name]

	set.material_variation = team_name

	local level = LevelHelper:current_level(self._world)

	for _, unit_index in ipairs(set.units) do
		local unit = Level.unit_by_index(level, unit_index)

		if Unit.alive(unit) then
			local material_name = Unit.has_data(unit, "material_variations") and Unit.get_data(unit, "material_variations", team_name)

			if material_name then
				Unit.set_material_variation(unit, material_name)
			else
				print("[GameModeManager:flow_cb_set_team_set_variation()] ERROR, unit " .. tostring(unit) .. " does not have script data material_variations." .. tostring(team_name))
			end
		else
			print("[GameModeManager:flow_cb_set_team_set_variation()] ERROR, unit " .. tostring(unit_index) .. " not spawned!")
		end
	end

	if Managers.lobby.server then
		Managers.state.network:send_rpc_clients("rpc_set_object_set_variation", set.key, NetworkLookup.team[team_name])
	end
end

function GameModeManager:rpc_set_object_set_variation(set_key, team_name)
	local set_name = self._object_set_names[set_key]

	self:_set_object_set_team_material_variation(set_name, team_name)
end

function GameModeManager:flow_cb_set_team_set_visibility(side, set_alias, visibility)
	local team_name

	team_name = side == "neutral" and "neutral" or Managers.state.team:name(side)

	fassert(team_name, "[GameModeManager:flow_cb_set_team_set_visibility()] Side name %s does not exist (yet?).", side)

	local set_name = "team_" .. team_name .. "_" .. set_alias
	local set = self._object_sets[set_name]

	fassert(set, "[GameModeManager:flow_cb_set_team_set_visibility()] Object set %s does not exist.", set_name)
	self:_set_team_object_set_visibility(set, visibility)

	if Managers.lobby.server then
		Managers.state.network:send_rpc_clients("rpc_set_team_object_set_visible", set.key, visibility)
	end
end

function GameModeManager:_set_team_object_set_visibility(set, visibility)
	set.visible = visibility

	local level = LevelHelper:current_level(self._world)

	for _, index in ipairs(set.units) do
		local unit = Level.unit_by_index(level, index)

		Unit.set_unit_visibility(unit, visibility)

		if visibility then
			Unit.flow_event(unit, "hide_helper_mesh")
		end
	end
end

local SPAWNING_CLASSES = {
	pulse = "PulseSpawning",
	single_player = "SinglePlayerSpawning",
	personal = "PersonalSpawning",
	battle = "BattleSpawning"
}

function GameModeManager:_init_game_mode(game_mode_key, win_score, time_limit)
	fassert(GameModeSettings[game_mode_key], "[GameModeManager] Tried to set unknown game mode %q", tostring(game_mode_key))

	local settings = GameModeSettings[game_mode_key]
	local class = rawget(_G, settings.class_name)

	self._game_mode = class:new(settings, self._world, win_score, time_limit)

	local allowed_spawning = settings.allowed_spawning
	local spawning_settings = table.clone(settings.spawn_settings)

	if script_data.settings.dedicated_server then
		local admin_spawning = Managers.admin:spawning()

		if admin_spawning then
			for key, value in pairs(admin_spawning) do
				if key ~= "type" or allowed_spawning[value] then
					spawning_settings[key] = value
				end
			end
		end
	end

	if Managers.lobby.server or not Managers.lobby.lobby then
		local class = rawget(_G, SPAWNING_CLASSES[spawning_settings.type])

		self._spawning = class:new(spawning_settings, self._game_mode)
	end
end

function GameModeManager:objective_unit_damage_multiplier(objective_unit, objective_active, damage_range_type, friendly_fire)
	local objective_game_mode_settings = GameModeSettings[self._game_mode_key].objectives

	if not objective_active then
		return 0
	end

	if friendly_fire then
		return objective_game_mode_settings.friendly_damage_multiplier[damage_range_type] or objective_game_mode_settings.friendly_damage_multiplier.default
	else
		return objective_game_mode_settings.damage_multiplier[damage_range_type] or objective_game_mode_settings.damage_multiplier.default
	end
end

function GameModeManager:round_started()
	local level = LevelHelper:current_level(self._world)
	local round_started_string = self._game_mode_key .. "_round_started"

	Managers.state.event:trigger("event_round_pre_started")
	Level.trigger_event(level, round_started_string)

	local game_mode_scale = self._server_game_mode_scale or 64

	if game_mode_scale then
		Level.trigger_event(level, round_started_string .. "_" .. game_mode_scale)
	end

	Managers.state.event:trigger("event_round_started", {})
	self._spawning:round_started()
end

function GameModeManager:next_spawn_time(player)
	return self._spawning:next_spawn_time(player)
end

function GameModeManager:squad_screen_spawning()
	local game_mode_settings = GameModeSettings[self._game_mode_key]

	return game_mode_settings.spawn_settings.squad_screen, game_mode_settings.player_team or "defenders"
end

function GameModeManager:client_update(dt, t)
	local win_scale = self._game_mode:win_scale()

	self._game_mode_music:update(dt, t, win_scale, self._game_mode_key, self._level_key)
end

function GameModeManager:server_update(dt, t)
	self._spawning:update(dt, t)

	if not self._end_conditions_met and not EDITOR_LAUNCH then
		local ended, winning_team, end_of_round_only = self._game_mode:evaluate_end_conditions()
		local win_scale = self._game_mode:win_scale()

		self._game_mode_music:update(dt, t, win_scale, self._game_mode_key, self._level_key)

		if ended then
			if not end_of_round_only then
				if Managers.lobby.server then
					Managers.state.stats_collector:round_finished(self._game_mode_key, winning_team)
				end

				if script_data.settings.dedicated_server then
					local callback = callback(self, "ready_to_transition", end_of_round_only)

					Managers.persistence:save(callback)
				end
			end

			self:trigger_end(end_of_round_only, t)

			local win_score = self._game_mode:win_score()
			local red_team_score = Managers.state.team:team_by_name("red").score
			local red_team_score_clamped = math.clamp(red_team_score, 0, win_score)
			local white_team_score = Managers.state.team:team_by_name("white").score
			local white_team_score_clamped = math.clamp(white_team_score, 0, win_score)
			local winning_team_name = winning_team and winning_team.name or "draw"

			self._winning_team_name = winning_team_name

			self:trigger_event("end_conditions_met", winning_team_name, math.floor(red_team_score_clamped), math.floor(white_team_score_clamped), end_of_round_only or false)
		end
	elseif self._end_timer and (self._ready_to_transition and t >= self._end_timer or t >= self._end_timer + GameSettingsDevelopment.backend_save_timeout) then
		Managers.state.event:trigger("event_level_ended", self._round_end)

		self._end_timer = nil
	end
end

function GameModeManager:ready_to_transition()
	self._ready_to_transition = true
end

function GameModeManager:stop_game_mode_music()
	self._game_mode_music:stop()
end

function GameModeManager:trigger_end(round_end, t)
	print("GameModeManager:trigger_end()")

	self._end_conditions_met = true

	self._game_mode_music:stop()

	self._round_end = round_end

	local level = LevelHelper:current_level(self._world)

	if not Managers.lobby.lobby then
		local side = Managers.state.team:side(self._winning_team_name or "red")

		Level.trigger_event(level, side .. "_win")
	else
		self._end_timer = t + 5
	end
end

function GameModeManager:game_mode_key()
	return self._game_mode_key
end

function GameModeManager:level_key()
	return self._level_key
end

function GameModeManager:objective(local_player)
	return self._game_mode:objective(local_player)
end

function GameModeManager:time_announcement(local_player)
	return self._game_mode:time_announcement(local_player)
end

function GameModeManager:own_score_announcement(local_player)
	return self._game_mode:own_score_announcement(local_player)
end

function GameModeManager:enemy_score_announcement(local_player)
	return self._game_mode:enemy_score_announcement(local_player)
end

function GameModeManager:own_capture_point_announcement(local_player)
	return self._game_mode:own_capture_point_announcement(local_player)
end

function GameModeManager:enemy_capture_point_announcement(local_player)
	return self._game_mode:enemy_capture_point_announcement(local_player)
end

function GameModeManager:hud_score_text(team_name)
	return self._game_mode:hud_score_text(team_name)
end

function GameModeManager:hud_progress(local_player)
	return self._game_mode:hud_progress(local_player)
end

function GameModeManager:hud_timer_text()
	return self._game_mode:hud_timer_text()
end

function GameModeManager:objective_units()
	local objective_entities = Managers.state.entity_system:get_entities("objective_system")
	local objective_units = {}

	for _, units in pairs(objective_entities) do
		for unit, _ in pairs(units) do
			objective_units[#objective_units + 1] = unit
		end
	end

	return objective_units
end

function GameModeManager:num_owned_objectives(team_name)
	local objective_units = self:objective_units()
	local team_side = Managers.state.team:side(team_name)
	local num_owned_objectives = 0

	for _, unit in ipairs(objective_units) do
		if team_side == Unit.get_data(unit, "side") then
			num_owned_objectives = num_owned_objectives + 1
		end
	end

	return num_owned_objectives
end

function GameModeManager:owned_objectives(team_name)
	local objective_units = self:objective_units()
	local team_side = Managers.state.team:side(team_name)
	local objectives_table = {}

	for _, unit in ipairs(objective_units) do
		if team_side == Unit.get_data(unit, "side") then
			objectives_table[#objectives_table + 1] = unit
		end
	end

	return objectives_table
end

function GameModeManager:not_owned_objectives(team_name)
	local objective_units = self:objective_units()
	local team_side = Managers.state.team:side(team_name)
	local objectives_table = {}

	for _, unit in ipairs(objective_units) do
		if team_side ~= Unit.get_data(unit, "side") then
			objectives_table[#objectives_table + 1] = unit
		end
	end

	return objectives_table
end

function GameModeManager:active_objectives_by_side(team_side)
	local objective_units = self:objective_units()
	local active_objectives = {}

	for _, unit in ipairs(objective_units) do
		if ScriptUnit.extension(unit, "objective_system"):active(team_side) then
			active_objectives[#active_objectives + 1] = unit
		end
	end

	return active_objectives
end

function GameModeManager:trigger_event(event, ...)
	local gm_event = "gm_event_" .. event

	Managers.state.event:trigger(gm_event, ...)

	if Managers.lobby.server then
		Managers.state.network[gm_event](Managers.state.network, ...)
	end
end

function GameModeManager:give_score_for_kill(scoring_table)
	self._game_mode:give_score_for_kill(scoring_table)
end

function GameModeManager:give_score_for_flag_planted(scoring_table)
	self._game_mode:give_score_for_flag_planted(scoring_table)
end

function GameModeManager:event_player_unit_died(dead_player, attacking_player, gear_name, is_instakill, damagers, damage_type)
	local level_event, level_instakill_event
	local game_mode_key = self:game_mode_key()
	local self_kill = not attacking_player or dead_player == attacking_player

	if self_kill then
		level_event = game_mode_key .. "_" .. dead_player.team.side .. "_selfkill"

		local level_prefix = game_mode_key .. "_" .. dead_player.team.side

		level_instakill_event = level_prefix .. "_selfinstakill"

		Managers.state.event:trigger("player_self_kill", dead_player, damage_type)
	else
		local attacker_team_side = attacking_player.team.side
		local is_team_kill = Managers.state.team:is_team_kill(dead_player, attacking_player)
		local level_prefix = game_mode_key .. "_" .. attacker_team_side

		if is_team_kill then
			level_event = level_prefix .. "_teamkill"
			level_instakill_event = level_prefix .. "_teaminstakill"

			Managers.state.event:trigger("player_team_kill", dead_player, attacking_player, gear_name, is_instakill)
		else
			level_event = level_prefix .. "_kill"
			level_instakill_event = level_prefix .. "_instakill"

			if Managers.lobby.server then
				local active_objectives = self:active_objectives_by_side(dead_player.team.side)

				for _, objective_unit in pairs(active_objectives) do
					local objective_ext = ScriptUnit.extension(objective_unit, "objective_system")

					if objective_ext and objective_ext.is_contributing and objective_ext:is_contributing(dead_player) then
						Managers.state.event:trigger("enemy_kill_within_objective", attacking_player)

						break
					end
				end
			end

			Managers.state.event:trigger("player_enemy_kill", dead_player, attacking_player, gear_name, is_instakill, damagers)
		end
	end

	local level = ScriptWorld.level(self._world, LevelSettings[self:level_key()].level_name)

	Level.trigger_event(level, level_event)

	if is_instakill then
		Level.trigger_event(level, level_instakill_event)
	end
end

function GameModeManager:event_player_knocked_down(knocked_down_player, attacking_player, gear_name, damagers, damage_type)
	local level_event
	local game_mode_key = self:game_mode_key()
	local self_knock_down = not attacking_player or knocked_down_player == attacking_player

	if self_knock_down then
		level_event = game_mode_key .. "_" .. knocked_down_player.team.side .. "_selfkd"

		Managers.state.event:trigger("player_self_kd", knocked_down_player)
	else
		local attacker_team_side = attacking_player.team.side
		local is_team_knock_down = Managers.state.team:is_team_knock_down(knocked_down_player, attacking_player)

		if is_team_knock_down then
			level_event = game_mode_key .. "_" .. attacker_team_side .. "_teamkd"

			Managers.state.event:trigger("player_team_kd", knocked_down_player, attacking_player, gear_name, damage_type)
		else
			level_event = game_mode_key .. "_" .. attacker_team_side .. "_kd"

			if Managers.lobby.server then
				local active_objectives = self:active_objectives_by_side(knocked_down_player.team.side)

				for _, objective_unit in pairs(active_objectives) do
					local objective_ext = ScriptUnit.extension(objective_unit, "objective_system")

					if objective_ext and objective_ext.is_contributing and objective_ext:is_contributing(knocked_down_player) then
						Managers.state.event:trigger("enemy_kill_within_objective", attacking_player)

						break
					end
				end
			end

			Managers.state.event:trigger("player_enemy_kd", knocked_down_player, attacking_player, gear_name, damagers, damage_type)
		end
	end

	local level = ScriptWorld.level(self._world, LevelSettings[self:level_key()].level_name)

	Level.trigger_event(level, level_event)
end

function GameModeManager:destroy()
	self._game_mode_music:destroy()
end

function GameModeManager:event_flag_planted(planter_player, interactable_unit)
	self:trigger_event("flag_planted", planter_player, interactable_unit)
end

function GameModeManager:event_objective_captured(capturing_player, captured_unit)
	self:trigger_event("objective_captured", capturing_player, captured_unit)
	Managers.state.stats_collector:objective_captured(capturing_player, captured_unit)
end

function GameModeManager:event_objective_captured_assist(assist_player, captured_unit)
	self:trigger_event("objective_captured_assist", assist_player, captured_unit)
	Managers.state.stats_collector:objective_captured_assist(assist_player, captured_unit)
end

function GameModeManager:event_section_cleared_payload(assist_player, payload_unit)
	Managers.state.stats_collector:section_cleared_payload(assist_player, payload_unit)
end

function GameModeManager:event_player_bandaged(bandagee, bandager)
	if bandagee == bandager then
		Managers.state.stats_collector:player_self_bandage(bandagee)
	else
		Managers.state.stats_collector:player_team_bandage(bandagee, bandager)
	end
end

function GameModeManager:event_player_damaged(damagee, damager, damage, gear_name, hit_zone, damage_range_type, range, mirrored)
	if damagee == damager then
		Managers.state.stats_collector:player_self_damage(damagee, damage, gear_name, hit_zone, damage_range_type, mirrored)
	elseif damagee.team == damager.team then
		Managers.state.stats_collector:player_team_damage(damagee, damager, damage, gear_name, hit_zone, damage_range_type)
	else
		Managers.state.stats_collector:player_enemy_damage(damagee, damager, damage, gear_name, hit_zone, damage_range_type, range)
	end
end

function GameModeManager:event_mount_unit_dead(attacker, rider)
	if not rider then
		Managers.state.stats_collector:mount_stray_kill(attacker)
	elseif attacker.team == rider.team then
		Managers.state.stats_collector:mount_team_kill(attacker, rider)
	else
		Managers.state.stats_collector:mount_enemy_kill(attacker, rider)
	end
end

function GameModeManager:event_player_dotted(victim, attacker, damage_type)
	if victim == attacker then
		Managers.state.stats_collector:player_self_dotted(victim, damage_type)
	elseif victim.team == attacker.team then
		Managers.state.stats_collector:player_team_dotted(victim, attacker, damage_type)
	else
		Managers.state.stats_collector:player_enemy_dotted(victim, attacker, damage_type)
	end
end

function GameModeManager:game_mode_modified_score(score)
	return self._game_mode:modified_score(score)
end

function GameModeManager:set_time_limit(t)
	self._game_mode:set_time_limit(t)
end

function GameModeManager:modify_time_limit(t)
	self._game_mode:modify_time_limit(t)
end

function GameModeManager:time_limit()
	return self._game_mode:time_limit()
end

function GameModeManager:hot_join_synch(sender, player)
	self._game_mode:hot_join_synch(sender, player)
	self:_hot_join_synch_object_sets(sender, player)
end
