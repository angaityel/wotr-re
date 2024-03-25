-- chunkname: @scripts/menu/menu_containers/outfit_viewer_menu_container.lua

require("scripts/menu/menu_containers/unit_viewer_menu_container")

OutfitViewerMenuContainer = class(OutfitViewerMenuContainer, UnitViewerMenuContainer)

function OutfitViewerMenuContainer:init(world_name, viewport_name)
	OutfitViewerMenuContainer.super.init(self, world_name)

	self._viewport_name = viewport_name
	self._attachment_icons = nil
end

function OutfitViewerMenuContainer:clear()
	self:remove_unit("main_item")

	self._attachment_icons = nil
end

function OutfitViewerMenuContainer:load_level_with_camera(level_key, camera_position)
	local level_settings = LevelSettings[level_key]

	self:load_level(level_settings.level_name)
	self:_setup_camera(camera_position)
end

function OutfitViewerMenuContainer:load_gear(gear_name, level_key)
	local gear_settings = Gear[gear_name]
	local unit_name = gear_settings.husk_unit
	local unit_rotation_table = gear_settings.ui_unit.rotation
	local unit_position = Vector3(0, 0, 0)
	local camera_position = Vector3Box.unbox(gear_settings.ui_unit.camera_position)

	self:_load(level_key, unit_name, unit_rotation_table, unit_position, camera_position)

	if gear_settings.show_coat_of_arms then
		CoatOfArmsHelper:set_material_properties(PlayerCoatOfArms, self:unit("main_item"), "g_heraldry_projector", "heraldry_projector", PlayerCoatOfArms.ui_team_name)
	end
end

function OutfitViewerMenuContainer:load_gear_attachments(gear_name, player_profile)
	local gear_settings = Gear[gear_name]
	local profile_gear = ProfileHelper:find_gear_by_name(player_profile.gear, gear_name)
	local icons = {}

	for _, icon_categories in ipairs(gear_settings.ui_small_attachment_icons) do
		local icon

		for _, icon_category in ipairs(icon_categories) do
			local attachment_names = profile_gear.attachments[icon_category]

			if attachment_names then
				local textures = OutfitHelper.small_attachment_textures(gear_name, icon_category, attachment_names[1])

				for i = #textures, 1, -1 do
					icon = icon or {}
					icon[#icon + 1] = textures[i]
				end
			end
		end

		icons[#icons + 1] = icon
	end

	self._attachment_icons = icons
end

function OutfitViewerMenuContainer:load_helmet(helmet_name, level_key)
	local helmet_settings = Helmets[helmet_name]
	local unit_name = helmet_settings.unit
	local unit_rotation_table = helmet_settings.ui_unit.rotation
	local unit_position = Vector3(0, 0, 0.1)
	local camera_position = Vector3Box.unbox(helmet_settings.ui_unit.camera_position)

	self:_load(level_key, unit_name, unit_rotation_table, unit_position, camera_position)
end

function OutfitViewerMenuContainer:load_armour(armour_name, level_key)
	local armour_settings = Armours[armour_name]
	local unit_name = armour_settings.preview_unit
	local unit_rotation_table = armour_settings.ui_unit.rotation
	local unit_position = Vector3(0, 0, 0.4)
	local camera_position = Vector3Box.unbox(armour_settings.ui_unit.camera_position)

	self:_load(level_key, unit_name, unit_rotation_table, unit_position, camera_position)
	CoatOfArmsHelper:set_material_properties(PlayerCoatOfArms, self:unit("main_item"), "g_heraldry_projection", "heraldry_projection", PlayerCoatOfArms.ui_team_name)
end

function OutfitViewerMenuContainer:load_mount(mount_name, level_key)
	local mount_settings = MountProfiles[mount_name]
	local unit_name = mount_settings.preview_unit
	local unit_rotation_table = mount_settings.ui_unit.rotation
	local unit_position = Vector3(0, 0, 1)
	local camera_position = Vector3Box.unbox(mount_settings.ui_unit.camera_position)
	local material_variation = mount_settings.material_variation

	self:_load(level_key, unit_name, unit_rotation_table, unit_position, camera_position, material_variation)
end

function OutfitViewerMenuContainer:_load(level_key, unit_name, unit_rotation_table, unit_position, camera_position, material_variation)
	local level_settings = LevelSettings[level_key]

	self:load_level(level_settings.level_name)
	self:remove_unit("main_item")

	local unit_rotation = Quaternion.identity()
	local tmp_rot

	for _, rotation in ipairs(unit_rotation_table) do
		local tmp_rot

		if rotation.x then
			tmp_rot = Quaternion(Vector3(1, 0, 0), rotation.x * (math.pi / 180))
		elseif rotation.y then
			tmp_rot = Quaternion(Vector3(0, 1, 0), rotation.y * (math.pi / 180))
		elseif rotation.z then
			tmp_rot = Quaternion(Vector3(0, 0, 1), rotation.z * (math.pi / 180))
		end

		unit_rotation = Quaternion.multiply(tmp_rot, unit_rotation)
	end

	local spawn_config = {
		unit_name = unit_name,
		position = unit_position,
		rotation = unit_rotation,
		material_variation = material_variation
	}

	self:spawn_unit(nil, "main_item", spawn_config)
	self:_setup_camera(camera_position)
end

function OutfitViewerMenuContainer:_setup_camera(camera_position)
	local world = Managers.world:world(self._world_name)
	local viewport = ScriptWorld.viewport(world, self._viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local camera_rotation = Quaternion.look(Vector3(0, 0, -1), Vector3.up())

	ScriptCamera.set_local_position(camera, camera_position)
	ScriptCamera.set_local_rotation(camera, camera_rotation)
end

function OutfitViewerMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function OutfitViewerMenuContainer:render(dt, t, gui, layout_settings)
	local world = Managers.world:world(self._world_name)
	local viewport = ScriptWorld.viewport(world, self._viewport_name)
	local res_width, res_height = Gui.resolution()
	local width = self._width / res_width
	local height = self._height / res_height

	self._viewport_x = self._x / res_width
	self._viewport_y = math.floor(res_height - self._y - self._height) / res_height

	Viewport.set_rect(viewport, self._viewport_x, self._viewport_y, width, height)
	self:_render_attachment_icons(dt, t, gui, layout_settings)
end

function OutfitViewerMenuContainer:_render_attachment_icons(dt, t, gui, layout_settings)
	if self._attachment_icons then
		local texture_x = math.floor(self._x + layout_settings.attachment_texture_offset_x)
		local texture_y = math.floor(self._y + layout_settings.attachment_texture_offset_y)
		local texture_size = Vector2(layout_settings.attachment_texture_size, layout_settings.attachment_texture_size)

		for i, textures in ipairs(self._attachment_icons) do
			local num_textures = #textures

			for i, texture in ipairs(textures) do
				local texture_settings = layout_settings.attachment_texture_atlas_settings[texture]
				local uv00 = Vector2(texture_settings.uv00[1], texture_settings.uv00[2])
				local uv11 = Vector2(texture_settings.uv11[1], texture_settings.uv11[2])

				Gui.bitmap_uv(gui, layout_settings.attachment_texture_atlas_name, uv00, uv11, Vector3(texture_x, texture_y, self._z + i), texture_size)
			end

			texture_x = texture_x + layout_settings.attachment_texture_spacing_x + layout_settings.attachment_texture_size
		end
	end
end

function OutfitViewerMenuContainer:viewport_position()
	return self._viewport_x, self._viewport_y
end

function OutfitViewerMenuContainer.create_from_config(world_name, viewport_name)
	return OutfitViewerMenuContainer:new(world_name, viewport_name)
end
