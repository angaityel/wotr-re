-- chunkname: @scripts/managers/hud/hud_mount_charge/hud_mount_charge.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_mount_charge/hud_mount_charge_icon")
require("scripts/managers/hud/hud_mount_charge/hud_mount_charge_timer")
require("scripts/managers/hud/hud_mount_charge/hud_mount_charge_timer_background")
require("scripts/managers/hud/hud_mount_charge/hud_mount_charge_cooldown")

HUDMountCharge = class(HUDMountCharge, HUDBase)

function HUDMountCharge:init(world, player)
	HUDMountCharge.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.arial, "material", MenuSettings.font_group_materials.hell_shark, "immediate")

	self:_setup()
	Managers.state.event:register(self, "local_player_mounted", "event_local_player_mounted")
	Managers.state.event:register(self, "local_player_dismounted", "event_local_player_dismounted")
end

function HUDMountCharge:_setup()
	self._container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.mount_charge.container
	})

	local icon_config = {
		z = 1,
		layout_settings = table.clone(HUDSettings.mount_charge.icon)
	}

	self._container:add_element("icon", HUDMountChargeIcon.create_from_config(icon_config))

	local cooldown_config = {
		z = 2,
		layout_settings = table.clone(HUDSettings.call_horse.cooldown)
	}

	self._container:add_element("cooldown", HUDMountChargeCooldown.create_from_config(cooldown_config))

	local key_circle_config = {
		z = 3,
		layout_settings = table.clone(HUDSettings.mount_charge.key_circle)
	}

	self._container:add_element("key_circle", HUDTextureElement.create_from_config(key_circle_config))

	local key_text_config = {
		text = "",
		z = 4,
		layout_settings = table.clone(HUDSettings.mount_charge.key_text)
	}

	self._container:add_element("key_text", HUDTextElement.create_from_config(key_text_config))

	local timer_background_config = {
		z = 1,
		layout_settings = table.clone(HUDSettings.mount_charge.timer_background)
	}

	self._container:add_element("timer_background", HUDMountChargeTimerBackground.create_from_config(timer_background_config))

	local timer_config = {
		z = 2,
		layout_settings = table.clone(HUDSettings.mount_charge.timer)
	}

	self._container:add_element("timer", HUDMountChargeTimer.create_from_config(timer_config))
end

function HUDMountCharge:event_local_player_mounted(player, mount_locomotion, blackboard)
	if player == self._player then
		self._active = true

		local elements = self._container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = blackboard
		end
	end
end

function HUDMountCharge:event_local_player_dismounted(player)
	if player == self._player then
		self._active = false

		local elements = self._container:elements()

		for id, element in pairs(elements) do
			element.config.blackboard = nil
		end
	end
end

function HUDMountCharge:_set_key(element, pad_active)
	local controller_settings = pad_active and "pad360" or "keyboard_mouse"
	local charge_key = ActivePlayerControllerSettings[controller_settings].mounted_charge.key
	local key_locale_name = pad_active and L("pad360_" .. charge_key) or ActivePlayerControllerSettings[controller_settings].mounted_charge.key

	key_locale_name = HUDHelper:trunkate_text(key_locale_name, 3, "...", true)

	return key_locale_name
end

function HUDMountCharge:post_update(dt, t)
	if not self._active then
		return
	end

	self:_handle_input_switch({
		"key_text"
	}, self._container, callback(self, "_set_key"))

	local layout_settings = HUDHelper:layout_settings(self._container.config.layout_settings)
	local gui = self._gui

	self._container:update_size(dt, t, gui, layout_settings)

	local x, y = HUDHelper:element_position(nil, self._container, layout_settings)

	self._container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
	self._container:render(dt, t, gui, layout_settings)
end

function HUDMountCharge:destroy()
	World.destroy_gui(self._world, self._gui)
end
