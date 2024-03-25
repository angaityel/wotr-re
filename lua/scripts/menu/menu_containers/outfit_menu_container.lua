-- chunkname: @scripts/menu/menu_containers/outfit_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

OutfitMenuContainer = class(OutfitMenuContainer, MenuContainer)

function OutfitMenuContainer:init(world_name, viewport_name)
	OutfitMenuContainer.super.init(self, world_name)

	self._outfit_texture = nil
	self._attachment_icons = nil
end

function OutfitMenuContainer:clear()
	self._outfit_texture = nil
	self._attachment_icons = nil
end

function OutfitMenuContainer:load_gear(gear_name)
	self._outfit_texture = Gear[gear_name].ui_texture
end

function OutfitMenuContainer:load_gear_attachments(gear_name, player_profile)
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

function OutfitMenuContainer:load_helmet(helmet_name)
	self._outfit_texture = Helmets[helmet_name].ui_texture
end

function OutfitMenuContainer:load_armour(armour_name)
	self._outfit_texture = Armours[armour_name].ui_texture
end

function OutfitMenuContainer:load_mount(mount_name)
	self._outfit_texture = MountProfiles[mount_name].ui_texture
end

function OutfitMenuContainer:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.width
	self._height = layout_settings.height
end

function OutfitMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function OutfitMenuContainer:render(dt, t, gui, layout_settings)
	self:_render_outfit_textures(dt, t, gui, layout_settings)
	self:_render_attachment_icons(dt, t, gui, layout_settings)
end

function OutfitMenuContainer:_render_attachment_icons(dt, t, gui, layout_settings)
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

				Gui.bitmap_uv(gui, layout_settings.attachment_texture_atlas_name, uv00, uv11, Vector3(texture_x, texture_y, self._z + i + 14), texture_size)
			end

			texture_x = texture_x + layout_settings.attachment_texture_spacing_x + layout_settings.attachment_texture_size
		end
	end
end

function OutfitMenuContainer:_render_outfit_textures(dt, t, gui, layout_settings)
	if self._outfit_texture then
		local texture_x = math.floor(self._x + layout_settings.outfit_texture_offset_x)
		local texture_y = math.floor(self._y + layout_settings.outfit_texture_offset_y)
		local texture_size = Vector2(layout_settings.outfit_texture_width, layout_settings.outfit_texture_height)
		local texture_settings = layout_settings.outfit_texture_atlas_settings[self._outfit_texture]
		local uv00 = Vector2(texture_settings.uv00[1], texture_settings.uv00[2])
		local uv11 = Vector2(texture_settings.uv11[1], texture_settings.uv11[2])

		Gui.bitmap_uv(gui, layout_settings.outfit_texture_atlas_name, uv00, uv11, Vector3(texture_x, texture_y, self._z + 12), texture_size)
		Gui.bitmap(gui, layout_settings.outfit_texture_overlay, Vector3(texture_x, texture_y, self._z + 13), texture_size)
	end

	local bgr_texture_size = Vector2(layout_settings.outfit_texture_background_width, layout_settings.outfit_texture_background_height)

	Gui.bitmap(gui, layout_settings.outfit_texture_background, Vector3(math.floor(self._x), math.floor(self._y), self._z + 11), bgr_texture_size)
end

function OutfitMenuContainer.create_from_config()
	return OutfitMenuContainer:new()
end
