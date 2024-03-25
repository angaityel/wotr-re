-- chunkname: @scripts/managers/hud/hud_call_horse/hud_call_horse.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_texture_element")
require("scripts/managers/hud/shared_hud_elements/hud_text_element_alt")
require("scripts/managers/hud/hud_call_horse/hud_call_horse_icon")
require("scripts/managers/hud/hud_call_horse/hud_call_horse_timer")
require("scripts/managers/hud/hud_call_horse/hud_call_horse_timer_background")
require("scripts/managers/hud/hud_call_horse/hud_call_horse_cooldown")

HUDCallHorse = class(HUDCallHorse, HUDBase)

function HUDCallHorse:init(world, player)
	HUDCallHorse.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", "materials/fonts/hell_shark_font", "material", MenuSettings.font_group_materials.hell_shark, "immediate")

	self:_setup_buff()

	self._active = false

	Managers.state.event:register(self, "own_horse_spawned", "event_hud_call_horse_activated")
	Managers.state.event:register(self, "player_unit_dead", "event_hud_call_horse_deactivated")
end

function HUDCallHorse:_setup_buff()
	self._call_horse_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.call_horse.container
	})

	local icon_config = {
		z = 11,
		layout_settings = table.clone(HUDSettings.call_horse.icon)
	}

	self._call_horse_container:add_element("icon", HUDCallHorseIcon.create_from_config(icon_config))

	local cooldown_config = {
		z = 12,
		layout_settings = table.clone(HUDSettings.call_horse.cooldown)
	}

	self._call_horse_container:add_element("cooldown", HUDCallHorseCooldown.create_from_config(cooldown_config))

	local key_circle_config = {
		z = 13,
		layout_settings = table.clone(HUDSettings.call_horse.key_circle)
	}

	self._call_horse_container:add_element("key_circle", HUDTextureElement.create_from_config(key_circle_config))

	local key_text_config = {
		text = "",
		z = 14,
		key_name = "call_horse",
		layout_settings = table.clone(HUDSettings.call_horse.key_text)
	}

	self._call_horse_container:add_element("key_text", HUDTextElementAlt.create_from_config(key_text_config))

	local key_circle_config2 = {
		z = 13,
		layout_settings = table.clone(HUDSettings.call_horse.key_circle2)
	}

	self._call_horse_container:add_element("key_circle2", HUDTextureElement.create_from_config(key_circle_config2))

	local key_text_config2 = {
		text = "",
		z = 14,
		key_name = "shift_function",
		layout_settings = table.clone(HUDSettings.call_horse.key_text2)
	}

	self._call_horse_container:add_element("key_text2", HUDTextElementAlt.create_from_config(key_text_config2))

	local timer_background_config = {
		z = 11,
		layout_settings = table.clone(HUDSettings.call_horse.timer_background)
	}

	self._call_horse_container:add_element("timer_background", HUDCallHorseTimerBackground.create_from_config(timer_background_config))

	local timer_config = {
		z = 12,
		layout_settings = table.clone(HUDSettings.call_horse.timer)
	}

	self._call_horse_container:add_element("timer", HUDCallHorseTimer.create_from_config(timer_config))
end

function HUDCallHorse:event_hud_call_horse_activated(player, blackboard)
	self._blackboard = blackboard

	if player == self._player then
		self._active = true

		local elements = self._call_horse_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
		end
	end
end

function HUDCallHorse:event_hud_call_horse_deactivated(player)
	self._blackboard = nil

	if player == self._player then
		self._active = false

		local elements = self._call_horse_container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDCallHorse:_update_pad360(pad_active)
	if pad_active then
		if not self._call_horse_container:element("key_circle2") then
			local key_circle_config2 = {
				z = 13,
				layout_settings = table.clone(HUDSettings.call_horse.key_circle2)
			}

			self._call_horse_container:add_element("key_circle2", HUDTextureElement.create_from_config(key_circle_config2))
		end

		if not self._call_horse_container:element("key_text2") then
			local key_text_config2 = {
				text = "",
				z = 14,
				key_name = "shift_function",
				layout_settings = table.clone(HUDSettings.call_horse.key_text2)
			}

			self._call_horse_container:add_element("key_text2", HUDTextElementAlt.create_from_config(key_text_config2))

			local element = self._call_horse_container:element("key_text2")

			element.config.blackboard = self._blackboard
		end
	else
		if self._call_horse_container:element("key_circle2") then
			self._call_horse_container:remove_element("key_circle2")
		end

		if self._call_horse_container:element("key_text2") then
			self._call_horse_container:remove_element("key_text2")
		end
	end
end

function HUDCallHorse:_set_key(element, pad_active)
	local controller_settings = pad_active and "pad360" or "keyboard_mouse"
	local key_name = element.config.key_name
	local key = ActivePlayerControllerSettings[controller_settings][key_name].key
	local key_locale_name = pad_active and L("pad360_" .. key) or ActivePlayerControllerSettings[controller_settings][key_name].key

	return key_locale_name
end

function HUDCallHorse:post_update(dt, t)
	if not self._active then
		return
	end

	local changed_input = self:_handle_input_switch({}, self._call_horse_container, callback(self, "_set_key"))

	if changed_input ~= nil then
		self:_update_pad360(changed_input)
	end

	local player_unit = self._player.player_unit
	local locomotion = Unit.alive(player_unit) and ScriptUnit.extension(player_unit, "locomotion_system")

	if not locomotion or locomotion.mounted_unit then
		return
	end

	local layout_settings = HUDHelper:layout_settings(self._call_horse_container.config.layout_settings)
	local gui = self._gui

	self._call_horse_container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._call_horse_container, layout_settings)

	self._call_horse_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._call_horse_container:render(dt, t, gui, layout_settings)
end

function HUDCallHorse:destroy()
	World.destroy_gui(self._world, self._gui)
end
