-- chunkname: @scripts/menu/menu_containers/profile_info_menu_container.lua

require("scripts/menu/menu_containers/menu_container")
require("scripts/menu/menu_containers/perk_menu_container")
require("scripts/menu/menu_containers/outfit_menu_container")

ProfileInfoMenuContainer = class(ProfileInfoMenuContainer, MenuContainer)

function ProfileInfoMenuContainer:init()
	ProfileInfoMenuContainer.super.init(self)

	self._perk_offensive = PerkMenuContainer.create_from_config()
	self._perk_defensive = PerkMenuContainer.create_from_config()
	self._perk_supportive = PerkMenuContainer.create_from_config()
	self._perk_movement = PerkMenuContainer.create_from_config()
	self._perk_officer = PerkMenuContainer.create_from_config()
	self._weapon_main = OutfitMenuContainer.create_from_config()
	self._weapon_sidearm = OutfitMenuContainer.create_from_config()
end

function ProfileInfoMenuContainer:clear()
	self._profile_name = nil
	self._main_weapon_name = nil
	self._sidearm_name = nil
	self._dagger_name = nil
	self._shield_name = nil

	self._perk_offensive:clear()
	self._perk_defensive:clear()
	self._perk_supportive:clear()
	self._perk_movement:clear()
	self._perk_officer:clear()
	self._weapon_main:clear()
	self._weapon_sidearm:clear()
end

function ProfileInfoMenuContainer:set_active(active)
	self._active = active
end

function ProfileInfoMenuContainer:load(profile)
	self:clear()

	if profile then
		self._profile_name = profile.display_name

		local main_weapon = ProfileHelper:find_gear_by_slot(profile.gear, "two_handed_weapon")

		if main_weapon then
			self._main_weapon_name = L(Gear[main_weapon.name].ui_header)

			self._weapon_main:load_gear(main_weapon.name, "outfit_display")
			self._weapon_main:load_gear_attachments(main_weapon.name, profile)
		end

		local sidearm = ProfileHelper:find_gear_by_slot(profile.gear, "one_handed_weapon")

		if sidearm then
			self._sidearm_name = L(Gear[sidearm.name].ui_header)

			self._weapon_sidearm:load_gear(sidearm.name, "outfit_display")
			self._weapon_sidearm:load_gear_attachments(sidearm.name, profile)
		end

		local dagger = ProfileHelper:find_gear_by_slot(profile.gear, "dagger")

		if dagger then
			self._dagger_name = L(Gear[dagger.name].ui_header)
		end

		local shield = ProfileHelper:find_gear_by_slot(profile.gear, "shield")

		if shield then
			self._shield_name = L(Gear[shield.name].ui_header)
		end

		self._perk_offensive:load(profile, "offensive")
		self._perk_defensive:load(profile, "defensive")
		self._perk_supportive:load(profile, "supportive")
		self._perk_movement:load(profile, "movement")
		self._perk_officer:load(profile, "officer")
	end
end

function ProfileInfoMenuContainer:update_size(dt, t, gui, layout_settings)
	if not self._active then
		return
	end

	self._width = layout_settings.bgr_texture_width
	self._height = layout_settings.bgr_texture_height

	self._perk_offensive:update_size(dt, t, gui, layout_settings.perks)
	self._perk_defensive:update_size(dt, t, gui, layout_settings.perks)
	self._perk_supportive:update_size(dt, t, gui, layout_settings.perks)
	self._perk_movement:update_size(dt, t, gui, layout_settings.perks)
	self._perk_officer:update_size(dt, t, gui, layout_settings.perks)
	self._weapon_main:update_size(dt, t, gui, layout_settings.main_weapon_viewer)
	self._weapon_sidearm:update_size(dt, t, gui, layout_settings.sidearm_viewer)
end

function ProfileInfoMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	if not self._active then
		return
	end

	self._x = x
	self._y = y
	self._z = z

	self._perk_offensive:update_position(dt, t, layout_settings.perks, x, y + layout_settings.perk_offensive_offset_y, z)
	self._perk_defensive:update_position(dt, t, layout_settings.perks, x, y + layout_settings.perk_defensive_offset_y, z)
	self._perk_supportive:update_position(dt, t, layout_settings.perks, x, y + layout_settings.perk_supportive_offset_y, z)
	self._perk_movement:update_position(dt, t, layout_settings.perks, x, y + layout_settings.perk_movement_offset_y, z)
	self._perk_officer:update_position(dt, t, layout_settings.perks, x, y + layout_settings.perk_officer_offset_y, z)
	self._weapon_main:update_position(dt, t, layout_settings.main_weapon_viewer, x + layout_settings.main_weapon_viewer.offset_x, y + layout_settings.main_weapon_viewer.offset_y, z)
	self._weapon_sidearm:update_position(dt, t, layout_settings.sidearm_viewer, x + layout_settings.sidearm_viewer.offset_x, y + layout_settings.sidearm_viewer.offset_y, z)
end

function ProfileInfoMenuContainer:render(dt, t, gui, layout_settings)
	if not self._active then
		return
	end

	Gui.bitmap(gui, layout_settings.bgr_texture, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(layout_settings.bgr_texture_width, layout_settings.bgr_texture_height))
	Gui.bitmap(gui, layout_settings.corner_top_texture.texture, Vector3(math.floor(self._x + layout_settings.corner_top_texture.texture_offset_x), math.floor(self._y + layout_settings.corner_top_texture.texture_offset_y), self._z + 1), Vector2(layout_settings.corner_top_texture.texture_width, layout_settings.corner_top_texture.texture_height))
	Gui.bitmap(gui, layout_settings.corner_bottom_texture.texture, Vector3(math.floor(self._x + layout_settings.corner_bottom_texture.texture_offset_x), math.floor(self._y + layout_settings.corner_bottom_texture.texture_offset_y), self._z + 1), Vector2(layout_settings.corner_bottom_texture.texture_width, layout_settings.corner_bottom_texture.texture_height))
	Gui.bitmap(gui, layout_settings.header_bgr_texture, Vector3(math.floor(self._x), math.floor(self._y + layout_settings.main_weapon_name_offset_y + layout_settings.header_bgr_texture_offset_y), self._z + 1), Vector2(layout_settings.header_bgr_texture_width, layout_settings.header_bgr_texture_height))
	Gui.bitmap(gui, layout_settings.header_bgr_texture, Vector3(math.floor(self._x), math.floor(self._y + layout_settings.sidearm_name_offset_y + layout_settings.header_bgr_texture_offset_y), self._z + 1), Vector2(layout_settings.header_bgr_texture_width, layout_settings.header_bgr_texture_height))
	Gui.bitmap(gui, layout_settings.header_bgr_texture, Vector3(math.floor(self._x), math.floor(self._y + layout_settings.dagger_name_offset_y + layout_settings.header_bgr_texture_offset_y), self._z + 1), Vector2(layout_settings.header_bgr_texture_width, layout_settings.header_bgr_texture_height))
	self:_render_texts(dt, t, gui, layout_settings)
	self._perk_offensive:render(dt, t, gui, layout_settings.perks)
	self._perk_defensive:render(dt, t, gui, layout_settings.perks)
	self._perk_supportive:render(dt, t, gui, layout_settings.perks)
	self._perk_movement:render(dt, t, gui, layout_settings.perks)
	self._perk_officer:render(dt, t, gui, layout_settings.perks)
	self._weapon_main:render(dt, t, gui, layout_settings.main_weapon_viewer)
	self._weapon_sidearm:render(dt, t, gui, layout_settings.sidearm_viewer)
end

function ProfileInfoMenuContainer:_render_texts(dt, t, gui, layout_settings)
	if self._profile_name then
		local c = layout_settings.profile_name_color
		local color = Color(c[1], c[2], c[3], c[4])
		local font = layout_settings.profile_name_font and layout_settings.profile_name_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.profile_name_font and layout_settings.profile_name_font.material or MenuSettings.fonts.menu_font.material

		ScriptGUI.text(gui, self._profile_name, font, layout_settings.profile_name_font_size, font_material, Vector3(math.floor(self._x + layout_settings.profile_name_offset_x), math.floor(self._y + layout_settings.profile_name_offset_y), self._z + 2), color)
	end

	if self._main_weapon_name then
		local c = layout_settings.main_weapon_name_color
		local color = Color(c[1], c[2], c[3], c[4])
		local font = layout_settings.main_weapon_name_font and layout_settings.main_weapon_name_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.main_weapon_name_font and layout_settings.main_weapon_name_font.material or MenuSettings.fonts.menu_font.material

		ScriptGUI.text(gui, self._main_weapon_name, font, layout_settings.main_weapon_name_font_size, font_material, Vector3(math.floor(self._x + layout_settings.main_weapon_name_offset_x), math.floor(self._y + layout_settings.main_weapon_name_offset_y), self._z + 2), color)
	end

	if self._sidearm_name then
		local c = layout_settings.sidearm_name_color
		local color = Color(c[1], c[2], c[3], c[4])
		local font = layout_settings.sidearm_name_font and layout_settings.sidearm_name_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.sidearm_name_font and layout_settings.sidearm_name_font.material or MenuSettings.fonts.menu_font.material

		ScriptGUI.text(gui, self._sidearm_name, font, layout_settings.sidearm_name_font_size, font_material, Vector3(math.floor(self._x + layout_settings.sidearm_name_offset_x), math.floor(self._y + layout_settings.sidearm_name_offset_y), self._z + 2), color)
	end

	if self._dagger_name then
		local c = layout_settings.dagger_name_color
		local color = Color(c[1], c[2], c[3], c[4])
		local font = layout_settings.dagger_name_font and layout_settings.dagger_name_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.dagger_name_font and layout_settings.dagger_name_font.material or MenuSettings.fonts.menu_font.material

		ScriptGUI.text(gui, self._dagger_name, font, layout_settings.dagger_name_font_size, font_material, Vector3(math.floor(self._x + layout_settings.dagger_name_offset_x), math.floor(self._y + layout_settings.dagger_name_offset_y), self._z + 2), color)
	end

	if self._shield_name then
		local c = layout_settings.shield_name_color
		local color = Color(c[1], c[2], c[3], c[4])
		local font = layout_settings.shield_name_font and layout_settings.shield_name_font.font or MenuSettings.fonts.menu_font.font
		local font_material = layout_settings.shield_name_font and layout_settings.shield_name_font.material or MenuSettings.fonts.menu_font.material

		ScriptGUI.text(gui, self._shield_name, font, layout_settings.shield_name_font_size, font_material, Vector3(math.floor(self._x + layout_settings.shield_name_offset_x), math.floor(self._y + layout_settings.shield_name_offset_y), self._z + 2), color)
	end
end

function ProfileInfoMenuContainer.create_from_config()
	return ProfileInfoMenuContainer:new()
end
