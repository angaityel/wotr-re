-- chunkname: @scripts/managers/hud/hud_ammo_counter/hud_ammo_counter.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_text_element")
require("scripts/managers/hud/shared_hud_elements/hud_texture_element")
require("scripts/managers/hud/hud_ammo_counter/hud_ammo_counter_timer")

HUDAmmoCounter = class(HUDAmmoCounter, HUDBase)

function HUDAmmoCounter:init(world, player)
	HUDAmmoCounter.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_ammo_counter()

	self._active = false

	local event_manager = Managers.state.event

	event_manager:register(self, "bow_wielded", "event_hud_ammo_counter_activated")
	event_manager:register(self, "crossbow_wielded", "event_hud_ammo_counter_activated")
	event_manager:register(self, "bow_unwielded", "event_hud_ammo_counter_deactivated")
	event_manager:register(self, "crossbow_unwielded", "event_hud_ammo_counter_deactivated")
	event_manager:register(self, "player_unit_dead", "event_hud_ammo_counter_deactivated")
	event_manager:register(self, "event_hud_ammo_counter_deactivated", "event_hud_ammo_counter_deactivated")
end

function HUDAmmoCounter:_setup_ammo_counter()
	self._ammo_counter_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.ammo_counter.container
	})

	local ammo_counter_ammo_text_config = {
		z = 20,
		layout_settings = table.clone(HUDSettings.ammo_counter.ammo_text)
	}

	self._ammo_counter_container:add_element("ammo_text", HUDTextElement.create_from_config(ammo_counter_ammo_text_config))

	local timer_bg_circle_config = {
		z = 5,
		layout_settings = table.clone(HUDSettings.ammo_counter.timer_background)
	}

	self._ammo_counter_container:add_element("timer_background", HUDTextureElement.create_from_config(timer_bg_circle_config))

	local timer_circle_config = {
		z = 7,
		layout_settings = table.clone(HUDSettings.ammo_counter.timer)
	}

	self._ammo_counter_container:add_element("timer", HUDAmmoCounterTimer.create_from_config(timer_circle_config))
end

function HUDAmmoCounter:event_hud_ammo_counter_activated(player, blackboard)
	if player == self._player then
		self._active = true
		self._blackboard = blackboard

		for id, element in pairs(self._ammo_counter_container:elements()) do
			element.config.blackboard = blackboard
			element.config.name = id
		end
	end
end

function HUDAmmoCounter:event_hud_ammo_counter_deactivated(player)
	if player == self._player then
		self._active = false
		self._blackboard = nil

		for id, element in pairs(self._ammo_counter_container:elements()) do
			element.config.blackboard = nil
			element.config.name = nil
		end
	end
end

function HUDAmmoCounter:post_update(dt, t)
	local layout_settings = HUDHelper:layout_settings(self._ammo_counter_container.config.layout_settings)
	local gui = self._gui

	if self._active then
		self._ammo_counter_container:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._ammo_counter_container, layout_settings)

		self._ammo_counter_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._ammo_counter_container:render(dt, t, gui, layout_settings)
	end
end

function HUDAmmoCounter:destroy()
	World.destroy_gui(self._world, self._gui)
end
