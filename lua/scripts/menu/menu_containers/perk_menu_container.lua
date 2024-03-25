-- chunkname: @scripts/menu/menu_containers/perk_menu_container.lua

require("scripts/menu/menu_containers/menu_container")

PerkMenuContainer = class(PerkMenuContainer, MenuContainer)

function PerkMenuContainer:init()
	PerkMenuContainer.super.init(self)
	self:clear()
end

function PerkMenuContainer:clear()
	self._basic = nil
	self._specialized_1 = nil
	self._specialized_2 = nil
end

function PerkMenuContainer:load(profile, perk_type)
	self:clear()

	if profile then
		local basic = profile.perks[perk_type .. "_basic"]
		local specialized_1 = profile.perks[perk_type .. "_specialization_1"]
		local specialized_2 = profile.perks[perk_type .. "_specialization_2"]

		if basic then
			self._basic = {
				textures = Perks[basic].ui_textures_big,
				header = Perks[basic].ui_header,
				description = Perks[basic].ui_short_description
			}
		end

		if specialized_1 then
			self._specialized_1 = {
				textures = Perks[specialized_1].ui_textures_big,
				header = Perks[specialized_1].ui_header
			}
		end

		if specialized_2 then
			self._specialized_2 = {
				textures = Perks[specialized_2].ui_textures_big,
				header = Perks[specialized_2].ui_header
			}
		end
	end
end

function PerkMenuContainer:basic_perk()
	return self._basic
end

function PerkMenuContainer:update_size(dt, t, gui, layout_settings)
	self._width = layout_settings.width
	self._height = layout_settings.height
end

function PerkMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function PerkMenuContainer:_render_perk_text(gui, text, font, font_size, color_table, offset_x, offset_y, drop_shadow_table, drop_shadow_offset)
	local shadow_color = Color(drop_shadow_table[1], drop_shadow_table[2], drop_shadow_table[3], drop_shadow_table[4])
	local shadow_offset = Vector2(drop_shadow_offset[1], drop_shadow_offset[2])
	local text_color = Color(color_table[1], color_table[2], color_table[3], color_table[4])

	ScriptGUI.text(gui, text, font.font, font_size, font.material, Vector3(math.floor(self._x + offset_x), math.floor(self._y + offset_y), self._z + 1), text_color, shadow_color, shadow_offset)
end

function PerkMenuContainer:render(dt, t, gui, layout_settings)
	if self._basic then
		self:_render_perk_textures(gui, self._basic.textures, layout_settings.basic_texture_offset_x, layout_settings.basic_texture_offset_y, layout_settings.basic_texture_width, layout_settings.basic_texture_height, layout_settings)
		self:_render_perk_text(gui, L(self._basic.header), layout_settings.basic_header_font, layout_settings.basic_header_font_size, layout_settings.text_color, layout_settings.basic_header_offset_x, layout_settings.basic_header_offset_y, layout_settings.drop_shadow_color, layout_settings.drop_shadow_offset)

		if not layout_settings.hide_description then
			self:_render_perk_text(gui, L(self._basic.description), layout_settings.basic_text_font, layout_settings.basic_text_font_size, layout_settings.text_color, layout_settings.basic_text_offset_x, layout_settings.basic_text_offset_y, layout_settings.drop_shadow_color, layout_settings.drop_shadow_offset)
		end
	end

	if self._specialized_1 then
		self:_render_perk_textures(gui, self._specialized_1.textures, layout_settings.specialized_1_texture_offset_x, layout_settings.specialized_1_texture_offset_y, layout_settings.specialized_1_texture_width, layout_settings.specialized_1_texture_height, layout_settings)
		self:_render_perk_text(gui, L(self._specialized_1.header), layout_settings.specialized_1_header_font, layout_settings.specialized_1_header_font_size, layout_settings.text_color, layout_settings.specialized_1_header_offset_x, layout_settings.specialized_1_header_offset_y, layout_settings.drop_shadow_color, layout_settings.drop_shadow_offset)
	elseif layout_settings.show_no_perk_rect and self._basic then
		local c = layout_settings.no_perk_rect_color
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(math.floor(self._x + layout_settings.specialized_1_texture_offset_x), math.floor(self._y + layout_settings.specialized_1_texture_offset_y), self._z), Vector2(math.floor(layout_settings.specialized_1_texture_width), math.floor(layout_settings.specialized_1_texture_height)), color)
	end

	if self._specialized_2 then
		self:_render_perk_textures(gui, self._specialized_2.textures, layout_settings.specialized_2_texture_offset_x, layout_settings.specialized_2_texture_offset_y, layout_settings.specialized_2_texture_width, layout_settings.specialized_2_texture_height, layout_settings)
		self:_render_perk_text(gui, L(self._specialized_2.header), layout_settings.specialized_2_header_font, layout_settings.specialized_2_header_font_size, layout_settings.text_color, layout_settings.specialized_2_header_offset_x, layout_settings.specialized_2_header_offset_y, layout_settings.drop_shadow_color, layout_settings.drop_shadow_offset)
	elseif layout_settings.show_no_perk_rect and self._basic then
		local c = layout_settings.no_perk_rect_color
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(math.floor(self._x + layout_settings.specialized_2_texture_offset_x), math.floor(self._y + layout_settings.specialized_2_texture_offset_y), self._z), Vector2(math.floor(layout_settings.specialized_2_texture_width), math.floor(layout_settings.specialized_2_texture_height)), color)
	end
end

function PerkMenuContainer:_render_perk_textures(gui, textures, offset_x, offset_y, width, height, layout_settings)
	local num_textures = #textures
	local texture_x = math.floor(self._x + offset_x)
	local texture_y = math.floor(self._y + offset_y)
	local texture_size = Vector2(math.floor(width), math.floor(height))

	for i, texture in ipairs(textures) do
		local texture_settings = layout_settings.texture_atlas_settings[texture]
		local uv00 = Vector2(texture_settings.uv00[1], texture_settings.uv00[2])
		local uv11 = Vector2(texture_settings.uv11[1], texture_settings.uv11[2])
		local offset_z = num_textures - i

		Gui.bitmap_uv(gui, layout_settings.texture_atlas_name, uv00, uv11, Vector3(texture_x, texture_y, self._z + offset_z + 1), texture_size)
	end
end

function PerkMenuContainer.create_from_config(text)
	return PerkMenuContainer:new(text)
end
