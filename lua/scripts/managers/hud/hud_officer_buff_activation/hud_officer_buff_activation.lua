-- chunkname: @scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_icon")
require("scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_information_text")
require("scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_information_icon")
require("scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_container_element")
require("scripts/managers/hud/hud_officer_buff_activation/hud_officer_buff_activation_cooldown")

HUDOfficerBuffActivation = class(HUDOfficerBuffActivation, HUDBase)

function HUDOfficerBuffActivation:init(world, player)
	HUDOfficerBuffActivation.super.init(self, world, player)

	self._world = world
	self._player = player
	self._shift_key_circle_element = {}
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.arial, "material", MenuSettings.font_group_materials.hell_shark, "immediate")

	self:_setup_buff()

	self._active = false
	self._player_is_corporal = false

	Managers.state.event:register(self, "activate_officer_buff_activation", "event_hud_officer_buff_activation_register_blackboard", "player_became_corporal", "event_hud_officer_buff_activation_set_active", "player_no_longer_corporal", "event_hud_officer_buff_activation_set_unactive")
end

function HUDOfficerBuffActivation:_setup_buff()
	self._officer_buff_element_containers = HUDOfficerBuffActivationContainerElement.create_from_config({
		layout_settings = HUDSettings.officer_buff_activation.container
	})

	for i = 1, 2 do
		local element_container = HUDContainerElement.create_from_config({
			layout_settings = HUDSettings.officer_buff_activation.element.container
		})
		local element_icon_config = {
			z = 1,
			layout_settings = table.clone(HUDSettings.officer_buff_activation.element.icon)
		}

		element_container:add_element("icon", HUDOfficerBuffActivationIcon.create_from_config(element_icon_config))

		local cooldown_config = {
			z = 2,
			layout_settings = table.clone(HUDSettings.officer_buff_activation.cooldown)
		}

		element_container:add_element("cooldown", HUDOfficerBuffActivationCooldown.create_from_config(cooldown_config))

		local element_level_circle_config = {
			z = 3,
			layout_settings = table.clone(HUDSettings.officer_buff_activation.element.level_circle)
		}

		element_container:add_element("level_circle", HUDOfficerBuffActivationInformationIcon.create_from_config(element_level_circle_config))

		local element_level_text_config = {
			text = "",
			z = 4,
			layout_settings = table.clone(HUDSettings.officer_buff_activation.element.level_text)
		}

		element_container:add_element("level_text", HUDOfficerBuffActivationText.create_from_config(element_level_text_config))

		local element_key_circle_config = {
			z = 3,
			layout_settings = table.clone(HUDSettings.officer_buff_activation.element.key_circle)
		}

		element_container:add_element("key_circle", HUDOfficerBuffActivationInformationIcon.create_from_config(element_key_circle_config))

		local element_key_text_config = {
			text = "",
			z = 4,
			layout_settings = table.clone(HUDSettings.officer_buff_activation.element.key_text)
		}

		element_container:add_element("key_text", HUDOfficerBuffActivationText.create_from_config(element_key_text_config))

		local element_key_circle_config2 = {
			z = 3,
			layout_settings = table.clone(HUDSettings.officer_buff_activation.element.key_circle2)
		}

		element_container:add_element("key_circle2", HUDOfficerBuffActivationInformationIcon.create_from_config(element_key_circle_config2))

		self._shift_key_circle_element[i] = element_container:element("key_circle2")

		local element_key_text_config2 = {
			text = "",
			z = 4,
			key_name = "shift_function",
			layout_settings = table.clone(HUDSettings.officer_buff_activation.element.key_text2)
		}

		element_container:add_element("key_text2", HUDOfficerBuffActivationText.create_from_config(element_key_text_config2))
		self._officer_buff_element_containers:add_element(i, element_container)
	end
end

function HUDOfficerBuffActivation:event_hud_officer_buff_activation_register_blackboard(player, blackboard)
	if player == self._player then
		self._active = true
		self._blackboard = blackboard

		for key, element_container in ipairs(self._officer_buff_element_containers:elements()) do
			element_container.config.blackboard = blackboard[key]

			for id, element in pairs(element_container:elements()) do
				element.config.blackboard = blackboard[key]
				element.config.name = id
				element.config.container_id = key
			end
		end
	end
end

function HUDOfficerBuffActivation:event_hud_officer_buff_activation_set_active(player)
	if player == self._player then
		self._player_is_corporal = true
	end
end

function HUDOfficerBuffActivation:event_hud_officer_buff_activation_set_unactive(player)
	if player == self._player then
		self._player_is_corporal = false
	end
end

function HUDOfficerBuffActivation:post_update(dt, t)
	local layout_settings = HUDHelper:layout_settings(self._officer_buff_element_containers.config.layout_settings)
	local gui = self._gui

	if self._active and self._player_is_corporal then
		self._officer_buff_element_containers:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._officer_buff_element_containers, layout_settings)

		self._officer_buff_element_containers:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._officer_buff_element_containers:render(dt, t, gui, layout_settings)
	end
end

function HUDOfficerBuffActivation:disabled_post_update(dt, t)
	for key, element_container in ipairs(self._officer_buff_element_containers:elements()) do
		for id, element in pairs(element_container:elements()) do
			if element.disabled_post_update then
				element:disabled_post_update(dt, t)
			end
		end
	end
end

function HUDOfficerBuffActivation:destroy()
	World.destroy_gui(self._world, self._gui)
end
