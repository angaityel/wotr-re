-- chunkname: @scripts/menu/menu_containers/profile_viewer_menu_container.lua

require("scripts/menu/menu_containers/unit_viewer_menu_container")

ProfileViewerMenuContainer = class(ProfileViewerMenuContainer, UnitViewerMenuContainer)

function ProfileViewerMenuContainer:init(world_name, viewport_name, menu_settings)
	ProfileViewerMenuContainer.super.init(self, world_name)

	self._viewport_name = viewport_name
	self._menu_settings = menu_settings
	self._alignment_units = {}
end

function ProfileViewerMenuContainer:add_alignment_unit(name, unit)
	self._alignment_units[name] = unit
end

function ProfileViewerMenuContainer:clear()
	self:remove_unit("player")
	self:remove_unit("mount")
end

function ProfileViewerMenuContainer:remove_unit(name)
	ProfileViewerMenuContainer.super.remove_unit(self, name)

	if name == "mount" and self:unit("player") then
		if self._alignment_units.player_without_mount then
			self:_align_unit_position_rotation("player", self._alignment_units.player_without_mount)
		else
			local position_offset = self._menu_settings.units.player_without_mount.position_offset:unbox()
			local rotation_offset = self._menu_settings.units.player_without_mount.rotation_offset

			self:_set_unit_position_rotation("player", position_offset, rotation_offset)
		end
	end
end

function ProfileViewerMenuContainer:_set_unit_position_rotation(unit_name, position_offset, rotation_offset)
	local camera_unit = self:_camera_unit()
	local cam_pos = Unit.local_position(camera_unit, 0)
	local cam_rot = Unit.local_rotation(camera_unit, 0)
	local position = cam_pos + Quaternion.forward(cam_rot) * position_offset.y + Quaternion.up(cam_rot) * position_offset.z + Quaternion.right(cam_rot) * position_offset.x

	self:set_unit_position(unit_name, position)

	local rotation = Quaternion.multiply(cam_rot, Quaternion(Vector3(0, 0, 1), rotation_offset))

	self:set_unit_rotation(unit_name, rotation)
end

function ProfileViewerMenuContainer:_align_unit_position_rotation(unit_name, alignment_unit)
	local position = Unit.local_position(alignment_unit, 0)

	self:set_unit_position(unit_name, position)

	local rotation = Unit.local_rotation(alignment_unit, 0)

	self:set_unit_rotation(unit_name, rotation)
end

function ProfileViewerMenuContainer:load_profile(player_profile)
	self:remove_unit("player")
	self:remove_unit("mount")
	self:load_player(player_profile)
	self:load_gear(player_profile)
	self:load_head(player_profile)
	self:load_helmet(player_profile)
	self:load_helmet_attachments(player_profile)

	if player_profile.mount then
		self:load_mount(MountProfiles[player_profile.mount])
	end
end

function ProfileViewerMenuContainer:_camera_unit()
	local world = Managers.world:world(self._world_name)
	local viewport = ScriptWorld.viewport(world, self._viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local camera_unit = Camera.get_data(camera, "unit")

	return camera_unit
end

function ProfileViewerMenuContainer:load_player(player_profile)
	local armour = Armours[player_profile.armour]
	local spawn_config = {
		unit_name = armour.preview_unit
	}

	self:spawn_unit(nil, "player", spawn_config)

	local position_offset, rotation_offset

	if player_profile.mount then
		if self._alignment_units.player_with_mount then
			self:_align_unit_position_rotation("player", self._alignment_units.player_with_mount)
		else
			local position_offset = self._menu_settings.units.player_with_mount.position_offset:unbox()
			local rotation_offset = self._menu_settings.units.player_with_mount.rotation_offset

			self:_set_unit_position_rotation("player", position_offset, rotation_offset)
		end
	elseif self._alignment_units.player_without_mount then
		self:_align_unit_position_rotation("player", self._alignment_units.player_without_mount)
	else
		local position_offset = self._menu_settings.units.player_without_mount.position_offset:unbox()
		local rotation_offset = self._menu_settings.units.player_without_mount.rotation_offset

		self:_set_unit_position_rotation("player", position_offset, rotation_offset)
	end

	local pattern = armour.attachment_definitions.patterns[player_profile.armour_attachments.patterns]
	local meshes = armour.preview_unit_meshes

	ProfileHelper:set_gear_patterns(self._units.player:unit(), meshes, pattern)
end

function ProfileViewerMenuContainer:player_unit()
	return self:unit("player")
end

function ProfileViewerMenuContainer:update_coat_of_arms(team_name)
	CoatOfArmsHelper:set_material_properties(PlayerCoatOfArms, self:unit("player"), "g_heraldry_projection", "heraldry_projection", team_name)

	local shield = self:unit("shield")

	if shield then
		local shield_name = self:unit_meta_data("shield", "gear_name")

		if Gear[shield_name].show_coat_of_arms then
			CoatOfArmsHelper:set_material_properties(PlayerCoatOfArms, shield, "g_heraldry_projector", "heraldry_projector", team_name)
		end
	end
end

function ProfileViewerMenuContainer:load_mount(mount_profile)
	local spawn_config = {
		unit_name = mount_profile.preview_unit,
		material_variation = mount_profile.material_variation
	}

	self:spawn_unit(nil, "mount", spawn_config)

	if self._alignment_units.mount then
		self:_align_unit_position_rotation("mount", self._alignment_units.mount)
	else
		local position_offset = self._menu_settings.units.mount.position_offset:unbox()
		local rotation_offset = self._menu_settings.units.mount.rotation_offset

		self:_set_unit_position_rotation("mount", position_offset, rotation_offset)
	end

	if self:unit("player") then
		if self._alignment_units.player_with_mount then
			self:_align_unit_position_rotation("player", self._alignment_units.player_with_mount)
		else
			local position_offset = self._menu_settings.units.player_with_mount.position_offset:unbox()
			local rotation_offset = self._menu_settings.units.player_with_mount.rotation_offset

			self:_set_unit_position_rotation("player", position_offset, rotation_offset)
		end
	end
end

function ProfileViewerMenuContainer:load_gear(player_profile)
	for _, gear in ipairs(player_profile.gear) do
		local gear_name = gear.name
		local gear_settings = Gear[gear_name]
		local slot = GearTypes[gear_settings.gear_type].inventory_slot
		local wielded = ProfileHelper:find_gear_by_name(player_profile.wielded_gear, gear_name)

		if wielded then
			self:_load_wielded_gear(slot, gear_name, player_profile.wielded_gear)
		else
			self:_load_unwielded_gear(slot, gear_name)
		end
	end
end

function ProfileViewerMenuContainer:_load_wielded_gear(name, gear_name, wielded_gear)
	local gear_settings = Gear[gear_name]
	local gear_type = gear_settings.gear_type
	local hand = gear_settings.hand
	local main_body_state = ""

	if gear_type ~= "shield" then
		if ProfileHelper:find_gear_by_slot(wielded_gear, "shield") then
			main_body_state = GearTypes.shield.cd_wield_main_body_state .. "_"
		end

		main_body_state = main_body_state .. GearTypes[gear_type].cd_wield_main_body_state
	end

	local hand_anim = gear_settings.hand .. "/empty"

	if gear_settings.hand_anim then
		hand_anim = gear_settings.hand .. "/" .. gear_settings.hand_anim
	end

	local spawn_config = {
		unit_name = gear_settings.husk_unit,
		attachment_node_linking = gear_settings.attachment_node_linking.wielded,
		animation_events = {
			main_body_state,
			hand_anim
		}
	}

	self:spawn_unit("player", name, spawn_config, {
		gear_name = gear_name
	})
end

function ProfileViewerMenuContainer:_load_unwielded_gear(name, gear_name)
	local gear_settings = Gear[gear_name]
	local spawn_config = {
		unit_name = gear_settings.husk_unit,
		attachment_node_linking = gear_settings.attachment_node_linking.unwielded,
		animation_events = {}
	}

	self:spawn_unit("player", name, spawn_config, {
		gear_name = gear_name
	})
end

function ProfileViewerMenuContainer:load_head(player_profile)
	local head = Heads[player_profile.head]
	local material = HeadMaterials[player_profile.head_material]
	local material_variation = material and material.material_name or nil
	local spawn_config = {
		unit_name = head.unit,
		attachment_node_linking = head.attachment_node_linking,
		animation_events = {},
		material_variation = material_variation
	}

	self:spawn_unit("player", "head", spawn_config)
end

function ProfileViewerMenuContainer:load_helmet(player_profile)
	local helmet = Helmets[player_profile.helmet.name]
	local spawn_config = {
		unit_name = helmet.unit,
		attachment_node_linking = helmet.attachment_node_linking,
		animation_events = {}
	}

	self:spawn_unit("player", "helmet", spawn_config)
	self:set_unit_visibility("head", "head_all", true)

	if helmet.hide_head_visibility_group then
		self:set_unit_visibility("head", helmet.hide_head_visibility_group, false)
	end
end

function ProfileViewerMenuContainer:load_helmet_attachments(player_profile)
	local helmet = Helmets[player_profile.helmet.name]
	local pattern

	for attachment_type, attachment_name in pairs(player_profile.helmet.attachments) do
		local attachment = helmet.attachments[attachment_name]

		if attachment_type == "pattern" then
			pattern = attachment
		else
			local spawn_config = {
				unit_name = attachment.unit,
				attachment_node_linking = attachment.attachment_node_linking,
				animation_events = {}
			}

			self:spawn_unit("helmet", attachment_type, spawn_config)
		end
	end

	if pattern then
		ProfileHelper:set_gear_patterns(self:unit("helmet"), helmet.preview_unit_meshes, pattern)

		for attachment_type, attachment_name in pairs(player_profile.helmet.attachments) do
			local attachment = helmet.attachments[attachment_name]
			local attachment_meshes = attachment.preview_unit_meshes

			if attachment_meshes then
				local unit = self:unit(attachment_type)

				ProfileHelper:set_gear_patterns(unit, attachment_meshes, pattern)
			end
		end
	end

	local crest_name = CoatOfArmsHelper:coat_of_arms_setting("crests", PlayerCoatOfArms.crest).crest_name

	if player_profile.helmet.show_crest and crest_name then
		local crest_settings = HelmetCrests[crest_name]
		local spawn_config = {
			unit_name = crest_settings.unit,
			attachment_node_linking = crest_settings.attachment_node_linking,
			animation_events = {}
		}

		self:spawn_unit("helmet", "crest", spawn_config)
	end
end

function ProfileViewerMenuContainer:load_armour_attachments(player_profile)
	local armour = Armours[player_profile.armour]
	local pattern = armour.attachment_definitions.patterns[player_profile.armour_attachments.patterns]
	local meshes = armour.preview_unit_meshes

	ProfileHelper:set_gear_patterns(self._units.player:unit(), meshes, pattern)
end

function ProfileViewerMenuContainer:render(dt, t, gui, layout_settings)
	local world = Managers.world:world(self._world_name)
	local viewport = ScriptWorld.viewport(world, self._viewport_name)
	local res_width, res_height = Gui.resolution()
	local width = self._width / res_width
	local height = self._height / res_height

	self._viewport_x = self._x / res_width
	self._viewport_y = math.floor(res_height - self._y - self._height) / res_height

	Viewport.set_rect(viewport, self._viewport_x, self._viewport_y, width, height)
end

function ProfileViewerMenuContainer.create_from_config(world_name, viewport_name, menu_settings)
	return ProfileViewerMenuContainer:new(world_name, viewport_name, menu_settings)
end
