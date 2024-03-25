-- chunkname: @scripts/managers/hud/hud_announcements/hud_announcements.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_animated_text_element")

HUDAnnouncements = class(HUDAnnouncements, HUDBase)

function HUDAnnouncements:init(world, player)
	HUDAnnouncements.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.font_gradient_100, "material", MenuSettings.font_group_materials.hell_shark, "immediate")
	self._queue = {}
	self._history = {}
	self._elements = {}
	self._announcement_delays = {}
	self._elements_cnt = 0
	self._container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.announcements.container
	})

	Managers.state.event:register(self, "game_mode_announcement", "event_game_mode_announcement")
	Managers.state.event:register(self, "player_wounded", "event_player_wounded")
	Managers.state.event:register(self, "local_player_stats_context_created", "event_local_player_stats_context_created")
	Managers.state.event:register(self, "game_mode_side_announcement", "event_game_mode_side_announcement")

	self._longshot_cb_id = nil
end

function HUDAnnouncements:event_local_player_stats_context_created(player)
	if player == self._player then
		local stats_collection_manager = Managers.state.stats_collection

		stats_collection_manager:register_callback(player:network_id(), "headshots", ">", 0, callback(self, "cb_headshot"))
		stats_collection_manager:register_callback(player:network_id(), "kill_streak", "=", 3, callback(self, "cb_killstreak"))
		stats_collection_manager:register_callback(player:network_id(), "kill_streak", "=", 5, callback(self, "cb_multi_killstreak"))
		stats_collection_manager:register_callback(player:network_id(), "kill_streak", "=", 10, callback(self, "cb_mega_killstreak"))

		self._longshot_cb_id = Managers.state.stats_collection:register_callback(player:network_id(), "headshot_range", ">", 45.725, callback(self, "cb_longshot"))
	end
end

function HUDAnnouncements:cb_headshot()
	local announcement = "headshot"
	local param1, param2 = GameModeHelper:announcement_parameters(announcement, self._player, self._world)

	self:_add(announcement, param1, param2)
end

function HUDAnnouncements:cb_longshot(range)
	local announcement = "longshot"
	local param1, param2 = GameModeHelper:announcement_parameters(announcement, self._player, self._world)

	self:_add(announcement, range / 0.9144)

	local player = self._player

	Managers.state.stats_collection:unregister_callback(player:network_id(), "headshot_range", self._longshot_cb_id)

	self._longshot_cb_id = Managers.state.stats_collection:register_callback(player:network_id(), "headshot_range", ">", range, callback(self, "cb_longshot"))
end

function HUDAnnouncements:cb_killstreak()
	local announcement = "killstreak"
	local param1, param2 = GameModeHelper:announcement_parameters(announcement, self._player, self._world)

	self:_add(announcement, param1, param2)
end

function HUDAnnouncements:cb_multi_killstreak()
	local announcement = "multi_killstreak"
	local param1, param2 = GameModeHelper:announcement_parameters(announcement, self._player, self._world)

	self:_add(announcement, param1, param2)
end

function HUDAnnouncements:cb_mega_killstreak()
	local announcement = "mega_killstreak"
	local param1, param2 = GameModeHelper:announcement_parameters(announcement, self._player, self._world)

	self:_add(announcement, param1, param2)
end

function HUDAnnouncements:event_game_mode_side_announcement(side, announcement, param1, param2)
	if self._player.team.side == side then
		self:event_game_mode_announcement(announcement, param1, param2)
	end
end

function HUDAnnouncements:event_game_mode_announcement(announcement, param1, param2)
	if not HUDSettings.show_announcements then
		return
	end

	self:_add(announcement, param1, param2)
end

function HUDAnnouncements:event_player_wounded(player)
	if player == self._player then
		local announcement = "wounded"
		local param1, param2 = GameModeHelper:announcement_parameters(announcement, self._player, self._world)

		self:_add(announcement, param1, param2)
	end
end

function HUDAnnouncements:_update_game_mode_announcements(player)
	if not player.team or player.team.name == "unassigned" then
		return
	end

	local time_announcement, time_param1, time_param2 = Managers.state.game_mode:time_announcement(player)

	if time_announcement ~= "" and (time_announcement ~= self._time_announcement or time_param1 ~= self._time_param1 or time_param2 ~= self._time_param2) then
		self:_add(time_announcement, time_param1, time_param2)
	end

	self._time_announcement = time_announcement
	self._time_param1 = time_param1
	self._time_param2 = time_param2

	local own_score_announcement, own_score_param1, own_score_param2 = Managers.state.game_mode:own_score_announcement(player)

	if own_score_announcement ~= "" and (own_score_announcement ~= self._own_score_announcement or own_score_param1 ~= self._own_score_param1 or own_score_param2 ~= self._own_score_param2) then
		self:_add(own_score_announcement, own_score_param1, own_score_param2)
	end

	self._own_score_announcement = own_score_announcement
	self._own_score_param1 = own_score_param1
	self._own_score_param2 = own_score_param2

	local enemy_score_announcement, enemy_score_param1, enemy_score_param2 = Managers.state.game_mode:enemy_score_announcement(player)

	if enemy_score_announcement ~= "" and (enemy_score_announcement ~= self._enemy_score_announcement or enemy_score_param1 ~= self._enemy_score_param1 or enemy_score_param2 ~= self._enemy_score_param2) then
		self:_add(enemy_score_announcement, enemy_score_param1, enemy_score_param2)
	end

	self._enemy_score_announcement = enemy_score_announcement
	self._enemy_score_param1 = enemy_score_param1
	self._enemy_score_param2 = enemy_score_param2

	local own_point_announcement, own_point_param1, own_point_param2 = Managers.state.game_mode:own_capture_point_announcement(player)

	if own_point_announcement ~= "" and (own_point_announcement ~= self._own_point_announcement or own_point_param1 ~= self._own_point_param1 or own_point_param2 ~= self._own_point_param2) then
		self:_add(own_point_announcement, own_point_param1, own_point_param2)
	end

	self._own_point_announcement = own_point_announcement
	self._own_point_param1 = own_point_param1
	self._own_point_param2 = own_point_param2

	local enemy_point_announcement, enemy_point_param1, enemy_point_param2 = Managers.state.game_mode:enemy_capture_point_announcement(player)

	if enemy_point_announcement ~= "" and (enemy_point_announcement ~= self._enemy_point_announcement or enemy_point_param1 ~= self._enemy_point_param1 or enemy_point_param2 ~= self._enemy_point_param2) then
		self:_add(enemy_point_announcement, enemy_point_param1, enemy_point_param2)
	end

	self._enemy_point_announcement = enemy_point_announcement
	self._enemy_point_param1 = enemy_point_param1
	self._enemy_point_param2 = enemy_point_param2
end

function HUDAnnouncements:_add(announcement, param1, param2)
	local times_shown = self._history[announcement] or 0
	local show_max_times = Announcements[announcement].show_max_times or math.huge

	if show_max_times <= times_shown then
		return
	end

	local text, layout_settings

	if not Announcements[announcement].no_text then
		text = string.format(L(announcement), param1, param2)
		layout_settings = Announcements[announcement].layout_settings
	end

	local unique_id = Announcements[announcement].unique_id
	local sound_event = Announcements[announcement].sound_event
	local delay = Announcements[announcement].announcement_delay

	if delay then
		self._announcement_delays[announcement] = self._announcement_delays[announcement] or 0

		local t = Managers.time:time("main")

		if t < self._announcement_delays[announcement] then
			return
		else
			self._announcement_delays[announcement] = t + delay
		end
	end

	if unique_id then
		for i = #self._queue, 1, -1 do
			if unique_id == self._queue[i].unique_id then
				table.remove(self._queue, i)
			end
		end
	end

	local entry = {
		unique_id = unique_id,
		text = text,
		sound_event = sound_event,
		layout_settings = layout_settings and table.clone(layout_settings)
	}

	table.insert(self._queue, self:_next_queue_index(), entry)

	self._history[announcement] = self._history[announcement] or 0
	self._history[announcement] = self._history[announcement] + 1
end

function HUDAnnouncements:_next_queue_index()
	return #self._queue + 1
end

function HUDAnnouncements:_update_queue(dt, t)
	if #self._queue > 0 and (#self._elements == 0 or t > self._elements[1].queue_delay) then
		self:_add_element(dt, t, table.remove(self._queue, 1))
	end
end

function HUDAnnouncements:_update_elements(dt, t)
	for i = #self._elements, 1, -1 do
		local element = self._elements[i]

		if t > element.anim_length then
			self._container:remove_element(element.id)
			table.remove(self._elements, i)
		end
	end
end

function HUDAnnouncements:_add_element(dt, t, config)
	if config.text then
		local element_config = {
			z = #self._elements + 1,
			text = config.text,
			layout_settings = config.layout_settings
		}
		local id = "announcement_" .. self._elements_cnt

		self._container:add_element(id, HUDAnimatedTextElement.create_from_config(element_config))

		local layout_settings = HUDHelper:layout_settings(config.layout_settings)

		self._elements[#self._elements + 1] = {
			id = id,
			queue_delay = t + layout_settings.queue_delay,
			anim_length = t + layout_settings.anim_length
		}
		self._elements_cnt = self._elements_cnt + 1
	end

	if config.sound_event then
		local timpani_world = World.timpani_world(self._world)
		local event_id = TimpaniWorld.trigger_event(timpani_world, config.sound_event)

		TimpaniWorld.set_parameter(timpani_world, event_id, "character_announcer", HUDSettings.announcement_voice_over)
	end
end

function HUDAnnouncements:post_update(dt, t)
	self:_update_game_mode_announcements(self._player)
	self:_update_queue(dt, t)
	self:_update_elements(dt, t)

	local layout_settings = HUDHelper:layout_settings(self._container.config.layout_settings)
	local gui = self._gui

	self._container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._container, layout_settings)

	self._container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._container:render(dt, t, gui, layout_settings)
end

function HUDAnnouncements:disabled_post_update(dt, t)
	self:_update_game_mode_announcements(self._player)
end

function HUDAnnouncements:destroy()
	World.destroy_gui(self._world, self._gui)
end
