-- chunkname: @scripts/managers/hud/hud_spawn/hud_spawn.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_text_element")

HUDSpawn = class(HUDSpawn, HUDBase)

function HUDSpawn:init(world, player)
	HUDSpawn.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", "materials/fonts/hell_shark_font", "immediate")

	self:_setup()

	self._colors = {
		disabled = {
			255,
			125,
			125,
			125
		},
		enabled = {
			255,
			255,
			255,
			255
		},
		pulsing = {
			255,
			255,
			255,
			255
		},
		pulsing_red = {
			255,
			255,
			255,
			255
		},
		invisible = {
			0,
			255,
			255,
			255
		}
	}

	Managers.state.event:register(self, "ghost_mode_activated", "event_ghost_mode_activated")
	Managers.state.event:register(self, "ghost_mode_deactivated", "event_ghost_mode_deactivated")
	Managers.state.event:register(self, "ingame_menu_set_active", "event_ingame_menu_set_active")
end

function HUDSpawn:event_ingame_menu_set_active(active)
	self._ingame_menu_active = active
end

function HUDSpawn:_setup()
	self._container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.spawn.container
	})
	self._timer_text_blackboard = {}

	local timer_text_config = {
		text = "",
		z = 2,
		blackboard = self._timer_text_blackboard,
		layout_settings = HUDSettings.spawn.timer_text
	}

	self._container:add_element("timer_text", HUDTextElement.create_from_config(timer_text_config))

	local timer_texture_config = {
		z = 1,
		layout_settings = HUDSettings.spawn.timer_texture
	}

	self._container:add_element("timer_texture", HUDTextureElement.create_from_config(timer_texture_config))

	self._mount_warning_blackboard = {}

	local mount_warning_config = {
		text = "",
		z = 2,
		blackboard = self._mount_warning_blackboard,
		layout_settings = HUDSettings.spawn.mount_warning
	}

	self._mount_warning = self._container:add_element("mount_warning", HUDTextElement.create_from_config(mount_warning_config))
	self._mount_warning_texture_blackboard = {}

	local mount_warning_texture_config = {
		z = 1,
		layout_settings = HUDSettings.spawn.mount_warning_texture,
		blackboard = self._mount_warning_texture_blackboard
	}

	self._container:add_element("mount_warning_texture", HUDTextureElement.create_from_config(mount_warning_texture_config))
end

function HUDSpawn:event_ghost_mode_activated()
	self._ghost_mode = true
end

function HUDSpawn:event_ghost_mode_deactivated()
	self._ghost_mode = false
end

function HUDSpawn:post_update(dt, t)
	self._timer_text_blackboard.color = self._colors.enabled
	self._mount_warning_blackboard.text = ""
	self._mount_warning_texture_blackboard.color = self._colors.invisible

	local render = false
	local spawn_timer = Managers.state.spawn:spawn_timer(self._player)
	local round_time = Managers.time:time("round")

	if round_time and round_time < 0 then
		self._timer_text_blackboard.text = L("battle_starts_in") .. " " .. string.format("%.0f", math.abs(round_time))
		render = true
	elseif spawn_timer then
		local damage_ext = Unit.alive(self._player.player_unit) and ScriptUnit.extension(self._player.player_unit, "damage_system")

		render = false

		local spawn_data = self._player.spawn_data

		if spawn_data.state == "ghost_mode" and not self._ingame_menu_active then
			if spawn_timer == math.huge then
				self._timer_text_blackboard.text = L("menu_waiting_for_more_players")
			elseif spawn_timer > 0 then
				self._timer_text_blackboard.text = L("menu_time_to_spawn") .. " " .. string.format("%.0f", math.max(0, spawn_timer))
			else
				self._timer_text_blackboard.text = L("menu_press_to_spawn")
				self._timer_text_blackboard.color = self._colors.pulsing
			end

			render = true
		elseif damage_ext and damage_ext:is_knocked_down() and not damage_ext:is_dead() then
			if spawn_timer > 0 then
				self._timer_text_blackboard.text = L("menu_time_to_spawn") .. " " .. string.format("%.0f", math.max(0, spawn_timer))
			else
				self._timer_text_blackboard.text = L("menu_press_to_yield")
			end

			render = true
		elseif spawn_data.mode == "unconfirmed_squad_member" and (spawn_data.state == "dead" or spawn_data.state == "not_spawned") then
			local spawn_target = spawn_data.squad_unit

			if Unit.alive(spawn_target) then
				local result = Managers.state.spawn:calculate_valid_squad_spawn_point(self._player, spawn_target, false)

				if result == "success" then
					self._timer_text_blackboard.text = L("menu_press_to_spawn")
					self._timer_text_blackboard.color = self._colors.pulsing
				else
					self._timer_text_blackboard.text = L(result)
					self._timer_text_blackboard.color = self._colors.disabled
				end

				local spawn_profile = self._player.state_data.spawn_profile

				if spawn_profile and PlayerProfiles[spawn_profile].mount then
					self._mount_warning_blackboard.text = L("menu_squad_spawn_mount_warning")
					self._mount_warning_blackboard.color = self._colors.pulsing_red
					self._mount_warning_texture_blackboard.color = self._colors.enabled
				end

				render = true
			else
				render = false
			end
		end
	end

	if render then
		local pulsing = self._colors.pulsing
		local pulse_phase = math.lerp(100, 255, 0.5 * (math.sin(0.8 * t * math.pi % math.pi * 2) + 1))

		pulsing[4] = pulse_phase
		pulsing[2] = pulse_phase
		pulsing[3] = pulse_phase

		local pulsing_red = self._colors.pulsing_red

		pulsing_red[3] = pulse_phase
		pulsing_red[4] = pulse_phase

		local layout_settings = HUDHelper:layout_settings(self._container.config.layout_settings)
		local gui = self._gui

		self._container:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._container, layout_settings)

		self._container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._container:render(dt, t, gui, layout_settings)
	end
end

function HUDSpawn:destroy()
	World.destroy_gui(self._world, self._gui)
end
