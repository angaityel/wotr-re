-- chunkname: @scripts/managers/persistence/persistence_manager_server.lua

require("scripts/managers/persistence/persistence_manager_common")
require("scripts/managers/persistence/telemetry_collector")
require("scripts/managers/persistence/telemetry_collector_offline")
require("scripts/managers/persistence/external_tweaks")
require("scripts/managers/persistence/external_tweaks_offline")
require("scripts/settings/achievements")
require("scripts/settings/prizes")
require("scripts/settings/medals")
require("scripts/settings/server_browser_score")

PersistenceManagerServer = class(PersistenceManagerServer, PersistenceManagerCommon)

function PersistenceManagerServer:init(settings)
	PersistenceManagerServer.super.init(self)
	fassert(settings, "No backend settings supplied")

	self._state = "uninitialized"

	Managers.admin:lock_server()

	self._settings = {
		connection_type = Backend.DEDICATED_TRUSTED,
		callback = callback(self, "cb_connected")
	}

	table.merge(self._settings, settings)

	self._settings.save_progress = T(settings.save_progress, true)
end

function PersistenceManagerServer:post_init()
	local app_id = SteamGameServer.app_id()
	local backend_address

	if script_data.settings.content_revision then
		if app_id == 42160 then
			backend_address = GameSettingsDevelopment.backend_address or "ftdata.fatshark.se"
		else
			backend_address = GameSettingsDevelopment.backend_address or "fttest01.fatshark.se"
		end
	elseif Application.build() == "dev" or Application.build() == "debug" then
		backend_address = GameSettingsDevelopment.backend_address or "fttest01.fatshark.se"
	end

	self._telemetry = self._settings.telemetry.enabled == true and TelemetryCollector:new(self._settings.telemetry.template_name) or TelemetryCollectorOffline:new()
	self._external_tweaks = self._settings.external_tweaks == true and ExternalTweaks:new(self._settings.connection.address) or ExternalTweaksOffline:new()
	self._settings.connection.address = backend_address
	self._settings.project_id = app_id

	--self:connect()
end

function PersistenceManagerServer:connect()
	cprint("[Backend]", "Connecting to", self._settings.connection.address)

	self._state = "connecting"

	Managers.backend:connect(self._settings.connection.address, self._settings.project_id, self._settings.connection_type, self._settings.connection.port, self._settings.connection.interface, self._settings.callback)
end

function PersistenceManagerServer:cb_connected(response)
	if response.error == nil then
		cprint("[Backend]", "Authenticating...")

		self._state = "authenticating"

		Managers.backend:steam_login(callback(self, "cb_authenticated"))
	else
		cprint("[Backend]", "Error (cb_connected)", response.error)

		self._state = "error"
	end
end

function PersistenceManagerServer:cb_authenticated(response)
	if response.error == nil then
		local _, profile = next(response.profiles)

		cprint("[Backend]", "Selecting server profile...")

		self._state = "selecting_profile"

		Managers.backend:select_profile(profile.id, callback(self, "cb_profile_selected"))
	else
		cprint("[Backend]", "Error (cb_authenticated)", response.error)

		self._state = "error"
	end
end

function PersistenceManagerServer:cb_profile_created(response)
	if response.error == nil then
		cprint("[Backend]", "Fetching entity types...")

		self._state = "fetching_entities"

		Managers.backend:select_profile(response.profile.id, callback(self, "cb_entity_types_fetched"))
	else
		cprint("[Backend]", "Error (cb_profile_created)", response.error)

		self._state = "error"
	end
end

function PersistenceManagerServer:cb_profile_selected(response)
	if response.error == nil then
		cprint("[Backend]", "Fetching entity types...")

		self._state = "fetching_entities"

		Managers.backend:get_entity_types(callback(self, "cb_entity_types_fetched"))
	else
		cprint("[Backend]", "Error (cb_fetch_entity_types)", response.error)

		self._state = "error"
	end
end

function PersistenceManagerServer:cb_entity_types_fetched(response)
	if response.error == nil then
		cprint("[Backend]", "Parsing entity types...")
		self:_parse_entity_types(response.entity_types or {})
		cprint("[Backend]", "Backend setup successfully!")

		self._state = "connected"

		Managers.admin:unlock_server()

		if Managers.state.event then
			Managers.chat:send_chat_message(1, "Successfully connected to the backend.")
		end
	else
		cprint("[Backend]", "Error (cb_entity_types_fetched)", response.error)

		self._state = "error"
	end
end

function PersistenceManagerServer:set_save_progress(flag)
	self._settings.save_progress = flag
end

function PersistenceManagerServer:setup(stats_collection)
	self._stats = stats_collection
	self._profiles = {}
	self._achievements = Achievements:new(stats_collection)
	self._prizes = Prizes:new(stats_collection)
	self._medals = Medals:new(stats_collection)
	self._ranks = Ranks:new(stats_collection)
	self._server_browser_score = ServerBrowserScore:new(stats_collection)

	if Managers.backend:connected() then
		self._telemetry:setup()
		self._external_tweaks:refresh()
		Managers.state.event:register(self, "player_joined", "event_player_joined")
	else
		--self:connect()
	end
end

function PersistenceManagerServer:event_player_joined(player)
	local profile_id = player.backend_profile_id

	if player.remote and profile_id ~= -1 then
		player.round_time_joined = Managers.time:time("round")

		print("Player joined at round time", player.round_time_joined)

		if self._profiles[profile_id] == nil then
			self._profiles[profile_id] = {
				player = player,
				entities = {},
				attributes = {},
				stats = {}
			}
		end

		Managers.backend:get_profile_attributes(profile_id, callback(self, "cb_profile_attributes_received", profile_id, player))
	else
		print("Ignoring player", player:name(), "with backend profile id", profile_id)
		CommandWindow.print("[Backend]", "Ignoring player", player:name(), "with backend profile id", profile_id)
	end
end

function PersistenceManagerServer:cb_profile_attributes_received(profile_id, player, response)
	if response.error == nil then
		printf("Profile attributes received for player %q (%d)", player:name(), player.backend_profile_id)

		local network_id = player:network_id()
		local profile = self._profiles[profile_id]

		profile.attributes = self:_parse_profile_attributes(response.attributes or {})

		for name, value in pairs(profile.attributes) do
			local stat = StatsContexts.player[name]

			if stat then
				if stat.backend.load then
					self._stats:set(network_id, name, value)
				end
			else
				printf("Stat %q exists in backend but not in StatsContexts.player", name)
			end
		end

		if GameSettingsDevelopment.network_mode == "steam" then
			self._achievements:register_player(player)
			self._server_browser_score:register_player(player)
		end

		self._prizes:register_player(player)
		self._medals:register_player(player)
		self._ranks:register_player(player)

		for name, value in pairs(profile.attributes) do
			local stat = StatsContexts.player[name]

			if stat and stat.backend.save and not stat.backend.load then
				self._stats:trigger(network_id, name, value)
			end
		end
	else
		printf("No profile attributes received for player %q (%d): %s", player:name(), player.backend_profile_id, response.error)

		self._profiles[player] = nil
	end
end

function PersistenceManagerServer:cb_profile_entities_received(profile_id, player, response)
	if response.error == nil then
		printf("Profile entities received for player %q (%d)", player:name(), player.backend_profile_id)

		self._profiles[player].entities = self:_parse_profile_entities(response.entities or {})
	else
		printf("Error receiving profile entities for player %q (%d): %s", player:name(), player.backend_profile_id, response.error)
	end
end

function PersistenceManagerServer:save(callback)
	print("Save progress", self._settings.save_progress)

	if self:_check_requirements() and self._settings.save_progress then
		self._callback = callback

		self:_save_profiles()
		self:_save_telemetry()
		self._telemetry:finalize()
	else
		print("[PersistenceManagerServer] No save performed as we are not connected!")
		callback()
	end
end

function PersistenceManagerServer:_check_requirements()
	if not Managers.backend:connected() then
		print("Skipping saving stats to backend due to no connection...")

		return false
	end

	if Managers.admin:is_server_password_protected() then
		print("Skipping saving stats to backend due to server being password protected...")

		return false
	end

	return true
end

function PersistenceManagerServer:_save_profiles()
	self._profiles_saving = {}

	local profile_stats_to_save = {}

	for profile_id, profile_data in pairs(self._profiles) do
		local player = profile_data.player
		local network_id = player:network_id()
		local profile_attributes = profile_data.attributes
		local profile_attributes_to_save = {}

		for stat_name, stat_props in pairs(StatsContexts.player) do
			if stat_props.backend.save then
				if stat_props.type == "compound" then
					profile_stats_to_save[stat_name] = profile_stats_to_save[stat_name] or {}

					local compound_stat = self._stats:get(network_id, stat_name)

					profile_stats_to_save[stat_name][profile_id] = compound_stat:get_backend_data(profile_id)
				else
					local stat_value = self._stats:get(network_id, stat_name)

					if stat_props.backend.save_mode == "set" and profile_attributes[stat_name] ~= stat_value then
						profile_attributes_to_save[stat_name] = {
							[Backend.PROFILE_ATTRIBUTE_SET] = tostring(stat_value)
						}
					elseif stat_props.backend.save_mode == "inc" and stat_value > 0 then
						profile_attributes_to_save[stat_name] = {
							[Backend.PROFILE_ATTRIBUTE_INC] = stat_value
						}
					elseif type(stat_props.backend.save_mode) == "table" then
						local save_mode, source_stat = next(stat_props.backend.save_mode)
						local source_value = self._stats:get(network_id, source_stat)

						profile_attributes_to_save[stat_name] = {
							[Backend.PROFILE_ATTRIBUTE_INC] = source_value
						}
					end
				end
			end
		end

		if not table.is_empty(profile_attributes_to_save) then
			self._profiles_saving[player] = true

			local callback = callback(self, "cb_attributes_saved", player)

			Managers.backend:update_profile_attributes(profile_id, profile_attributes_to_save, callback)
		end
	end

	if not table.is_empty(profile_stats_to_save) and self._settings.stats then
		cprint("[Backend] Saving profile stats")

		local callback = callback(self, "cb_stats_saved")

		Managers.backend:save_stats(profile_stats_to_save, callback)
	end

	if table.is_empty(self._profiles) then
		self._callback()
	end
end

function PersistenceManagerServer:_save_telemetry()
	for profile_id, profile_data in pairs(self._profiles) do
		self._telemetry:save_round(profile_data.player)
	end
end

function PersistenceManagerServer:cb_stats_saved(response)
	if response.error == nil then
		printf("Stats saved")
	else
		printf("Error saving stats: %s", response.error)
	end
end

function PersistenceManagerServer:cb_attributes_saved(player, response)
	if response.error == nil then
		printf("Profile attributes saved for player %q (%d)", player:name(), player.backend_profile_id)
	else
		printf("Error saving profile attributes for player %q (%d): %s", player:name(), player.backend_profile_id, response.error)
	end

	self._profiles_saving[player] = nil

	print(table.size(self._profiles_saving), " profiles to save")

	if table.is_empty(self._profiles_saving) then
		self._callback()
	end
end

function PersistenceManagerServer:update(t, dt)
	--[[
	local reconnect = self._state == "error" or self._state == "connected" and not Managers.backend:connected()

	if reconnect then
		Managers.admin:lock_server()
		self:connect()
		Managers.chat:send_chat_message(1, "Connection to the backend has been lost. Your progress may not be saved.")
		Managers.chat:send_chat_message(1, "Reconnecting...")
	end
	--]]
end

function PersistenceManagerServer:destroy()
	Managers.backend:logout()
	Managers.backend:disconnect()
end
