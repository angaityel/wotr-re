-- chunkname: @scripts/managers/hud/hud_chat/chat_output_window.lua

require("scripts/settings/hud_settings")

ChatOutputWindow = class(ChatOutputWindow)

local debug = true

CLEAR = false

local tweak_variables = HUDSettings.chat.output_window
local window_settings = HUDSettings.chat.output_window.window_settings

local function smoothstep(a, b, t)
	local c = math.max(0, math.min(t, 1))

	return a + c * c * (3 - 2 * c) * (b - a)
end

function ChatOutputWindow:init(world)
	self:_setup_variables()
	self:_setup_window()
	self:_setup_gui(world)
	self:_register_events()
end

function ChatOutputWindow:_setup_window()
	local w, h = Application.resolution()
end

function ChatOutputWindow:_setup_variables()
	self._flood_control = {}
	self._texts = {}
	self._active = false
	self._shutdown_light = false
	self._scroll_offset = 0
	self._scroll_value = 0
	self._total_extents = 0
end

function ChatOutputWindow:_setup_gui(world)
	self._gui = World.create_screen_gui(world, "material", tweak_variables.gui_material, "material", "materials/hud/buttons", "material", "materials/fonts/hell_shark_font", "immediate")
end

function ChatOutputWindow:_register_events()
	Managers.state.event:register(self, "event_chat_input_activated", "event_chat_activated")
	Managers.state.event:register(self, "event_chat_input_deactivated", "event_chat_deactivated")
	Managers.state.event:register(self, "event_chat_message", "event_chat_message")
	Managers.state.event:register(self, "event_admin_chat_message", "event_admin_chat_message")
	Managers.state.event:register(self, "event_rcon_chat_message", "event_rcon_chat_message")
end

function ChatOutputWindow:event_chat_activated()
	Window.set_show_cursor(true)

	self._active = true
end

function ChatOutputWindow:event_chat_deactivated(shutdown_light)
	Window.set_show_cursor(false)

	self._active = false
	self._shutdown_light = shutdown_light
end

function ChatOutputWindow:post_update(dt, t, player)
	if CLEAR and debug then
		self._texts = {}
		self._total_extents = 0
		CLEAR = false
	end

	self:_update_scroll_input(player)
	self:_update_scroll(dt)
	self:_render_texts(dt)
	self:_render_window()
end

function ChatOutputWindow:_update_scroll_input(player, dt)
	if self._active then
		local input_source = player.input_source

		if input_source:has("mouse_scroll") then
			self._scroll_value = math.abs(input_source:get("mouse_scroll").y) > 0 and input_source:get("mouse_scroll").y or self._scroll_value or 0
		else
			self._scroll_value = 0
		end
	else
		self._scroll_value = 0
	end
end

function ChatOutputWindow:_update_scroll(dt)
	if self._active then
		if self._scroll_value >= 0 then
			self._scroll_value = math.max(self._scroll_value - math.sign(self._scroll_value) * dt * 4, 0)
		else
			self._scroll_value = math.min(self._scroll_value - math.sign(self._scroll_value) * dt * 4, 0)
		end

		self._scroll_offset = math.clamp(self._scroll_offset + self._scroll_value * tweak_variables.scroll_speed * dt, 0, math.max(self._total_extents - (window_settings.inner_window.size_y - tweak_variables.font_size), 0))
	else
		self._scroll_offset = 0
	end
end

function ChatOutputWindow:_render_window()
	if self._active then
		local w, h = Application.resolution()
		local window = window_settings.outer_window

		Gui.rect(self._gui, Vector3(window.x, h - window.y_offset, 1), Vector2(window.size_x, window.size_y), Color(128, 0, 0, 0))
		self:_render_border({
			window.x,
			h - window.y_offset,
			window.size_x,
			window.size_y
		}, 1, Color(0, 0, 0), 500)

		window = window_settings.chat_field

		local pos1 = Vector3(0, 0, h - window.y_offset + window.size_y)
		local pos2 = Vector3(0, 0, h - window.y_offset)
		local pos3 = Vector3(window.x + 5, 0, h - window.y_offset)

		Gui.triangle(self._gui, pos1, pos2, pos3, 0, Color(0, 0, 0, 0), "triangle_mask")

		local pos1 = Vector3(0, 0, h - window.y_offset + window.size_y)
		local pos2 = Vector3(window.x + 5, 0, h - window.y_offset)
		local pos3 = Vector3(window.x + 5, 0, h - window.y_offset + window.size_y)

		Gui.triangle(self._gui, pos1, pos2, pos3, 0, Color(0, 0, 0, 0), "triangle_mask")
		self:_render_border({
			window.x,
			h - window.y_offset,
			window.size_x,
			window.size_y
		}, 1, Color(0, 0, 0), 500)

		window = window_settings.inner_window

		Gui.rect(self._gui, Vector3(window.x, h - window.y_offset, 2), Vector2(window.size_x, window.size_y), Color(90, 0, 0, 0))
		self:_render_border({
			window.x,
			h - window.y_offset,
			window.size_x,
			window.size_y
		}, 1, Color(0, 0, 0), 500)

		if Managers.input:pad_active(1) then
			self:_render_buttons()
		end
	end
end

function ChatOutputWindow:_render_buttons()
	local fitta = HUDSettings
	local layout_settings = MenuHelper:layout_settings(HUDSettings.default_button_info)
	local button_config = layout_settings.default_buttons
	local text_data = layout_settings.text_data
	local w, h = Gui.resolution()
	local x = text_data.offset_x or 0
	local y = text_data.offset_y or 0
	local offset_x = 0
	local standard_button_size = {
		56,
		56
	}

	for _, button in ipairs(button_config) do
		local material, uv00, uv11, size = self:get_button_bitmap(button.button_name)
		local button_offset = {
			type(button.button_name) == "table" and #button.button_name * standard_button_size[1] or standard_button_size[1],
			size[2] == standard_button_size[2] and standard_button_size[2] or size[2] * 1.3
		}

		if type(button.button_name) == "table" then
			for i, button_name in ipairs(button.button_name) do
				local material, uv00, uv11, size = self:get_button_bitmap(button_name)
				local inner_button_offset = {
					type(button.button_name) == "table" and #button.button_name * standard_button_size[1] or standard_button_size[1],
					size[2] == standard_button_size[2] and standard_button_size[2] or size[2] * 1.3
				}

				Gui.bitmap_uv(self._gui, material, uv00, uv11, Vector3(x + offset_x + (i - 1) * standard_button_size[1], y - inner_button_offset[2], 999), size)
			end
		else
			Gui.bitmap_uv(self._gui, material, uv00, uv11, Vector3(x + offset_x, y - button_offset[2], 999), size)
		end

		local text = string.upper(L(button.text))

		Gui.text(self._gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + button_offset[1] + offset_x, y - standard_button_size[2] * 0.62, 999))

		if text_data.drop_shadow then
			local drop_x, drop_y = unpack(text_data.drop_shadow)

			Gui.text(self._gui, text, text_data.font.font, text_data.font_size, text_data.font.material, Vector3(x + button_offset[1] + offset_x + drop_x, y - standard_button_size[2] * 0.62 + drop_y, 998), Color(0, 0, 0))
		end

		local min, max = Gui.text_extents(self._gui, text, text_data.font.font, text_data.font_size)

		offset_x = offset_x + (max[1] - min[1]) + button_offset[1]
	end
end

function ChatOutputWindow:_calculate_offset(top, bottom)
	local font_size = tweak_variables.font_size
	local lines = 1
	local offset = 0
	local new_text_offset = 0
	local time = Managers.time:time("game")

	for i = #self._texts, 1, -1 do
		local text_table = self._texts[i].message_table
		local extents = self._texts[i].extents
		local text_time = self._texts[i].time
		local material = tweak_variables.font.material
		local font = tweak_variables.font.font
		local time_diff = time - text_time

		if time_diff < tweak_variables.text_scroll_time then
			new_text_offset = new_text_offset + smoothstep(extents[2], 0, time_diff / tweak_variables.text_scroll_time)
		end

		if self._active or time_diff < tweak_variables.life_time + tweak_variables.text_scroll_time then
			local multiplier = not self._active and smoothstep(1, 0, (time_diff - tweak_variables.life_time) / tweak_variables.text_scroll_time) or 1

			for j = #text_table, 1, -1 do
				if lines > tweak_variables.max_lines - 1 then
					return offset, new_text_offset
				end

				lines = lines + 1
				offset = offset + font_size * multiplier
			end
		end
	end

	return offset, 0
end

function ChatOutputWindow:_render_texts(gui, texts, active, scroll_offset)
	if debug then
		local w, h = Application.resolution()
		local gui = self._gui
		local texts = self._texts
		local active = self._active
		local scroll_offset = self._scroll_offset
		local font_size = tweak_variables.font_size
		local lines = 1
		local top = h - window_settings.inner_window.y_offset + window_settings.inner_window.size_y
		local bottom = top - window_settings.inner_window.size_y
		local offset, new_text_offset = self:_calculate_offset(gui, texts, active, top, bottom)
		local pos = Vector3(30, math.max(top - offset, bottom + 5) - new_text_offset - scroll_offset, 500)
		local width = window_settings.outer_window.size_x

		Gui.triangle(gui, Vector3(0, 0, 0), Vector3(0, 0, h), Vector3(w, 0, 0), -1, Color(0, 0, 0), "clear_mask")
		Gui.triangle(gui, Vector3(0, 0, h), Vector3(w, 0, 0), Vector3(w, 0, h), -1, Color(0, 0, 0), "clear_mask")
		Gui.triangle(gui, Vector3(0, 0, top - 5), Vector3(0, 0, top + 100), Vector3(width, 0, top - 5), 100, Color(0, 0, 0, 0), "triangle_mask")
		Gui.triangle(gui, Vector3(0, 0, top + 100), Vector3(width, 0, top - 5), Vector3(width, 0, top + 100), 100, Color(0, 0, 0, 0), "triangle_mask")
		Gui.triangle(gui, Vector3(0, 0, bottom), Vector3(0, 0, bottom - 18), Vector3(width, 0, bottom), 0, Color(0, 0, 0, 0), "triangle_mask")
		Gui.triangle(gui, Vector3(0, 0, bottom - 18), Vector3(width, 0, bottom - 18), Vector3(width, 0, bottom), 0, Color(0, 0, 0, 0), "triangle_mask")

		for i = #texts, 1, -1 do
			local channel_name = texts[i].channel_name
			local name = texts[i].name
			local text_table = texts[i].message_table
			local extents = texts[i].extents
			local material = tweak_variables.font.material
			local font = tweak_variables.font.font
			local text_time = texts[i].time
			local time = Managers.time:time("game")
			local time_diff = time - text_time

			if active or time_diff <= tweak_variables.life_time then
				local alpha

				alpha = not active and smoothstep(1, 0, time_diff - tweak_variables.life_time + 1) or 1

				local color = texts[i].color and texts[i].color:unbox() or Vector3(255, 55, 255)

				for j = #text_table, 1, -1 do
					local text = text_table[j]
					local extent_y = 0

					if pos[2] > bottom - 16 and top > pos[2] then
						Gui.text(gui, text, font, font_size, material, pos, Color(alpha * 255, color[1], color[2], color[3]))
						Gui.text(gui, text, font, font_size, material, pos + Vector3(1, -1, -1), Color(alpha * alpha * 255, 0, 0, 0))

						if j == 1 and name then
							local name_text = name .. ": "
							local name_color = Color(alpha * 255, color[1], color[2], color[3])
							local offset = Vector3(0, 0, 1)

							if channel_name then
								local text_min, text_max = Gui.text_extents(gui, "[" .. channel_name .. "] ", font, font_size, material)

								offset = offset + Vector3(text_max.x - text_min.x, 0, 0)
							end

							Gui.text(gui, name_text, font, font_size, material, pos + offset, name_color)
						end

						lines = lines + 1

						if lines > tweak_variables.max_lines + 1 then
							return
						end
					end

					pos[2] = pos[2] + font_size
				end
			end
		end
	end
end

function ChatOutputWindow:_render_border(rect, thickness, color, layer)
	Gui.rect(self._gui, Vector3(rect[1] - thickness, rect[2], layer or 1), Vector2(rect[3] + thickness * 2, -thickness), color)
	Gui.rect(self._gui, Vector3(rect[1], rect[2], layer or 1), Vector2(-thickness, rect[4]), color)
	Gui.rect(self._gui, Vector3(rect[1] + rect[3], rect[2], layer or 1), Vector2(thickness, rect[4]), color)
	Gui.rect(self._gui, Vector3(rect[1] - thickness, rect[2] + rect[4], layer or 1), Vector2(rect[3] + thickness * 2, thickness), color)
end

function ChatOutputWindow:post(channel_name, name, message, color)
	local message_table, extents, lines = self:_format_message(message)

	if self:_post_allowed(name) then
		self._texts[#self._texts + 1] = {
			name = name,
			channel_name = channel_name,
			message_table = message_table,
			extents = extents,
			color = color and Vector3Box(color),
			time = Managers.time:time("game")
		}
		self._total_extents = self._total_extents + lines * tweak_variables.font_size
	end
end

function ChatOutputWindow:_post_allowed(name)
	if not name then
		return true
	end

	local current_time = math.floor(Managers.time:time("game") + 0.5)

	self._flood_control[name] = self._flood_control[name] or {
		posts = 1,
		post_time = current_time
	}

	if current_time - self._flood_control[name].post_time > tweak_variables.post_time then
		self._flood_control[name] = {
			posts = 1,
			post_time = current_time
		}
	elseif self._flood_control[name].posts > tweak_variables.max_posts then
		return false
	else
		self._flood_control[name].posts = self._flood_control[name].posts + 1
	end

	return true
end

function ChatOutputWindow:_format_message(message)
	local max_width = window_settings.inner_window.size_x - 10
	local text_to_format = message
	local text = message
	local font = tweak_variables.font.font
	local font_size = tweak_variables.font_size
	local min, max = Gui.text_extents(self._gui, text, font, font_size)
	local extents = {
		max[1] - min[1],
		max[3] - min[3]
	}
	local strings = {}
	local iterations = 0
	local text_chunk_extents = {
		max_width,
		extents[2]
	}
	local lines = 0

	while max_width < extents[1] and iterations <= 150 do
		local percentage = max_width / extents[1]
		local length = string.len(text_to_format)
		local index = math.max(math.floor(length * percentage), 1)
		local verified_index, _ = Utf8.location(text_to_format, index)
		local test_string = string.sub(text_to_format, 1, verified_index - 1)
		local _, space_index = string.find(test_string, ".* ")

		space_index = space_index and space_index > 1 and space_index or nil

		local real_string = test_string

		if space_index then
			real_string = string.sub(text_to_format, 1, space_index)
		end

		if #strings > 0 then
			local new_space_index, _ = string.find(real_string, ".* ")

			if new_space_index and new_space_index < 2 then
				real_string = string.sub(real_string, 2)
			end
		end

		strings[#strings + 1] = real_string
		lines = lines + 1
		text_to_format = string.sub(text_to_format, space_index or verified_index)
		min, max = Gui.text_extents(self._gui, text_to_format, font, font_size)
		extents = {
			max[1] - min[1],
			max[3] - min[3]
		}
		text_chunk_extents[2] = text_chunk_extents[2] + extents[2]
		iterations = iterations + 1
	end

	if iterations > 150 then
		return {}
	end

	local tail = string.sub(text_to_format, 1)

	if #strings > 0 then
		local new_space_index, _ = string.find(tail, ".* ")

		if new_space_index and new_space_index < 2 then
			tail = string.sub(tail, 2)
		end
	end

	table.insert(strings, tail)

	lines = lines + 1

	return strings, text_chunk_extents, lines
end

function ChatOutputWindow:event_chat_message(channel_id, sender, message)
	local channel = NetworkLookup.chat_channels[channel_id]
	local channel_name = L("chat_" .. channel)
	local name = rawget(_G, "Steam") and Steam.user_name(sender) or ""
	local color_table = HUDSettings.chat_text_colors
	local color = Vector3(255, 255, 255)

	if channel == "dead_team_red" or channel == "dead_team_white" or channel == "dead_unassigned" then
		local state = Managers.player:player_exists(1) and Managers.player:player(1).spawn_data.state

		if state == "dead" or state == "not_spawned" then
			if Network.peer_id() == sender then
				color = Vector3(color_table.self_team[1], color_table.self_team[2], color_table.self_team[3])
			else
				color = Vector3(color_table.team[1], color_table.team[2], color_table.team[3])
			end
		else
			return
		end
	elseif channel == "team_red" or channel == "team_white" or channel == "team_unassigned" then
		if Network.peer_id() == sender then
			color = Vector3(color_table.self_team[1], color_table.self_team[2], color_table.self_team[3])
		else
			color = Vector3(color_table.team[1], color_table.team[2], color_table.team[3])
		end
	elseif channel == "dead" then
		local state = Managers.player:player_exists(1) and Managers.player:player(1).spawn_data.state

		if state == "dead" or state == "not_spawned" then
			if Network.peer_id() == sender then
				color = Vector3(color_table.self_all[1], color_table.self_all[2], color_table.self_all[3])
			else
				color = Vector3(color_table.all[1], color_table.all[2], color_table.all[3])
			end
		else
			return
		end
	elseif channel == "all" then
		if Network.peer_id() == sender then
			color = Vector3(color_table.self_all[1], color_table.self_all[2], color_table.self_all[3])
		else
			color = Vector3(color_table.all[1], color_table.all[2], color_table.all[3])
		end
	end

	self:post(channel_name, name, "[" .. channel_name .. "] " .. name .. ": " .. message, color)
end

function ChatOutputWindow:event_admin_chat_message(channel_id, sender, message)
	local channel = NetworkLookup.chat_channels[channel_id]
	local channel_name = L("chat_" .. channel)

	self:post(nil, nil, "Admin: " .. message, Vector3(255, 255, 255))
end

function ChatOutputWindow:event_rcon_chat_message(channel_id, sender, message)
	local channel = NetworkLookup.chat_channels[channel_id]
	local channel_name = L("chat_" .. channel)

	self:post(nil, nil, message, Vector3(255, 255, 255))
end

function ChatOutputWindow:output_console_text(text, color)
	self:post(nil, nil, text, color)
end

function ChatOutputWindow:network_output_console_text(text_id, color, display_time)
	local network_manager = Managers.state.network

	assert(network_manager:game(), "[DebugTextManager] Tried to send network synched debug text without a network game")

	if Managers.lobby.server then
		network_manager:send_rpc_clients("rpc_output_debug_console_text", NetworkLookup.localized_strings[text_id], color, display_time or 0)
	else
		network_manager:send_rpc_server("rpc_output_debug_console_text", NetworkLookup.localized_strings[text_id], color, display_time or 0)
	end

	self:post(nil, nil, L(text_id), color)
end

function ChatOutputWindow:get_button_bitmap(button_name)
	if button_name and X360Buttons[button_name] then
		local uv00 = X360Buttons[button_name].uv00
		local uv11 = X360Buttons[button_name].uv11
		local size = X360Buttons[button_name].size

		return "x360_buttons", Vector2(uv00[1], uv00[2]), Vector2(uv11[1], uv11[2]), Vector2(size[1], size[2])
	else
		local uv00 = X360Buttons.default.uv00
		local uv11 = X360Buttons.default.uv11
		local size = X360Buttons.default.size

		return "x360_buttons", Vector2(uv00[1], uv00[2]), Vector2(uv11[1], uv11[2]), Vector2(size[1], size[2])
	end
end

function ChatOutputWindow:on_activated(active)
	return
end

function ChatOutputWindow:on_deactivated(active)
	return
end

function ChatOutputWindow:set_enabled(enabled)
	return
end

function ChatOutputWindow:disabled_post_update(dt, t)
	return
end

function ChatOutputWindow:destroy()
	return
end

function ChatOutputWindow:enabled()
	return true
end
