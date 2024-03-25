-- chunkname: @scripts/managers/hud/hud_player_effects/hud_buffs.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_player_effects/hud_player_effect_icon")
require("scripts/managers/hud/hud_player_effects/hud_player_effect_information_icon")
require("scripts/managers/hud/hud_player_effects/hud_player_effect_information_text")
require("scripts/managers/hud/hud_player_effects/hud_player_effect_container_element")
require("scripts/managers/hud/hud_player_effects/hud_player_effect_timer_background")
require("scripts/managers/hud/hud_player_effects/hud_player_effect_timer")

HUDBuffs = class(HUDBuffs, HUDBase)

function HUDBuffs:init(world, player)
	HUDBuffs.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_buff()

	self._active = false

	Managers.state.event:register(self, "buffs_activated", "event_hud_buffs_activated", "buffs_deactivated", "event_hud_buffs_deactivated")
end

function HUDBuffs:_setup_buff()
	self._buffs_container = HUDPlayerEffectContainerElement.create_from_config({
		layout_settings = HUDSettings.buffs.container
	})

	for buff_name, _ in pairs(Buffs) do
		local buff_container = HUDContainerElement.create_from_config({
			layout_settings = HUDSettings.buffs.buff.container
		})
		local buff_icon_config = {
			z = 10,
			layout_settings = table.clone(HUDSettings.buffs.buff.icon)
		}

		buff_container:add_element(buff_name .. "_icon", HUDPlayerEffectIcon.create_from_config(buff_icon_config))

		local buff_level_circle_config = {
			z = 20,
			layout_settings = table.clone(HUDSettings.buffs.buff.level_circle)
		}

		buff_container:add_element(buff_name .. "_level_circle", HUDPlayerEffectInformationIcon.create_from_config(buff_level_circle_config))

		local buff_level_text_config = {
			text = "",
			z = 30,
			layout_settings = table.clone(HUDSettings.buffs.buff.level_text)
		}

		buff_container:add_element(buff_name .. "_level_text", HUDPlayerEffectInformationText.create_from_config(buff_level_text_config))

		local timer_bg_circle_config = {
			z = 5,
			layout_settings = table.clone(HUDSettings.buffs.buff.timer_background)
		}

		buff_container:add_element(buff_name .. "_timer_background", HUDPlayerEffectTimerBackground.create_from_config(timer_bg_circle_config))

		local timer_circle_config = {
			z = 7,
			layout_settings = table.clone(HUDSettings.buffs.buff.timer)
		}

		buff_container:add_element(buff_name .. "_timer", HUDPlayerEffectTimer.create_from_config(timer_circle_config))
		self._buffs_container:add_element(buff_name, buff_container)
	end
end

function HUDBuffs:event_hud_buffs_activated(player, blackboard)
	if player == self._player then
		self._active = true
		self._blackboard = blackboard

		local buffs_container = self._buffs_container
		local buff_containers = buffs_container:elements()

		buffs_container.config.is_buff_container = true

		for buff_name, buff_container in pairs(buff_containers) do
			buff_container.config.blackboard = blackboard
			buff_container.config.effect_type = buff_name

			local elements = buff_container:elements()

			for id, element in pairs(elements) do
				element.config.blackboard = blackboard
				element.config.name = id
				element.config.effect_type = buff_name
			end
		end
	end
end

function HUDBuffs:event_hud_buffs_deactivated(player)
	if player == self._player then
		self._active = false
		self._blackboard = nil

		local buff_containers = self._buffs_container:elements()

		for buff_name, buff_container in pairs(buff_containers) do
			buff_container.config.blackboard = nil
			buff_container.config.effect_type = nil

			local elements = buff_container:elements()

			for id, element in pairs(elements) do
				element.config.blackboard = nil
			end
		end
	end
end

function HUDBuffs:post_update(dt, t)
	local layout_settings = HUDHelper:layout_settings(self._buffs_container.config.layout_settings)
	local gui = self._gui

	if self._active then
		self._buffs_container:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._buffs_container, layout_settings)

		self._buffs_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._buffs_container:render(dt, t, gui, layout_settings)
	end
end

function HUDBuffs:destroy()
	World.destroy_gui(self._world, self._gui)
end
