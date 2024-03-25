-- chunkname: @scripts/managers/hud/hud_damage_numbers/hud_damage_numbers.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/hud_damage_numbers/hud_damage_number")
require("scripts/managers/hud/shared_hud_elements/hud_text_element")
require("scripts/managers/hud/shared_hud_elements/hud_texture_element")

HUDDamageNumbers = class(HUDDamageNumbers, HUDBase)

function HUDDamageNumbers:init(world, player)
	HUDDamageNumbers.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_world_gui(world, Matrix4x4:identity(), 1, 1, "material", "materials/hud/hud", "material", "materials/fonts/hell_shark_font", "immediate")
	self._active = false
	self._available_ids = {}

	for i = 1, 10 do
		self._available_ids["damage_number_" .. i] = true
	end

	self._damage_numbers_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.damage_numbers.container
	})
	self._colours = {
		none = {
			255,
			238,
			19,
			19
		},
		armour_cloth = {
			255,
			230,
			106,
			20
		},
		armour_leather = {
			255,
			238,
			215,
			19
		},
		armour_mail = {
			255,
			167,
			221,
			241
		},
		armour_plate = {
			255,
			22,
			124,
			240
		},
		weapon_wood = {
			255,
			255,
			255,
			255
		},
		weapon_metal = {
			255,
			255,
			255,
			255
		}
	}

	Managers.state.event:register(self, "event_damage_numbers_activated", "event_damage_numbers_activated")
	Managers.state.event:register(self, "event_damage_numbers_deactivated", "event_damage_numbers_deactivated")
	Managers.state.event:register(self, "show_damage_number", "event_show_damage_number")
end

function HUDDamageNumbers:event_show_damage_number(player, damage_type, damage, position, damage_range_type, impact_direction, armour_type)
	if self._player == player then
		local container = self._damage_numbers_container
		local elements = container:elements()
		local element_id, oldest_element_id
		local oldest_time = math.huge

		for id, available in pairs(self._available_ids) do
			if available then
				element_id = id
				self._available_ids[id] = false

				break
			else
				local element = elements[id]
				local start_time = element.config.start_time

				if start_time < oldest_time then
					oldest_element_id = id
					oldest_time = start_time
				end
			end
		end

		if element_id == nil then
			container:remove_element(oldest_element_id)

			element_id = oldest_element_id
		end

		local camera_pos = Managers.state.camera:camera_position(player.viewport_name)
		local camera_rot = Managers.state.camera:camera_rotation(player.viewport_name)
		local distance = Vector3.distance(camera_pos, position)
		local pos_box = Vector3Box()

		pos_box:store(position)

		local dir_box = Vector3Box()

		dir_box:store(impact_direction)

		local config = {
			font_size = 0,
			z = 0,
			id = element_id,
			start_time = Managers.time:time("game"),
			damage_type = damage_type,
			damage_range_type = damage_range_type,
			damage = damage,
			position = pos_box,
			direction = dir_box,
			colour = self._colours[armour_type],
			ranged_size_multiplier = distance / 40 + 0.975,
			viewport_name = player.viewport_name,
			ended_function = callback(self, "cb_number_time_out"),
			layout_settings = HUDSettings.damage_numbers.number
		}
		local element = HUDDamageNumber.create_from_config(config)

		container:add_element(element_id, element)
	end
end

function HUDDamageNumbers:cb_number_time_out(id)
	self._damage_numbers_container:remove_element(id)

	self._available_ids[id] = true
end

function HUDDamageNumbers:event_damage_numbers_activated(player)
	if player == self._player then
		self._active = true
	end
end

function HUDDamageNumbers:event_damage_numbers_deactivated(player)
	if player == self._player then
		self._active = false
	end
end

function HUDDamageNumbers:post_update(dt, t)
	local layout_settings = HUDHelper:layout_settings(self._damage_numbers_container.config.layout_settings)
	local gui = self._gui

	if self._active then
		self._damage_numbers_container:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._damage_numbers_container, layout_settings)

		self._damage_numbers_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._damage_numbers_container:render(dt, t, gui, layout_settings)
	end
end

function HUDDamageNumbers:destroy()
	World.destroy_gui(self._world, self._gui)
end
