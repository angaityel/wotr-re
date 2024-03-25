-- chunkname: @scripts/menu/menu_items/battle_report_summary_award_menu_item.lua

BattleReportSummaryAwardMenuItem = class(BattleReportSummaryAwardMenuItem, MenuItem)

function BattleReportSummaryAwardMenuItem:init(config, world)
	BattleReportSummaryAwardMenuItem.super.init(self, config, world)

	self._award_name = config.award_name
	self._award_amount = config.award_amount
	self._award_textures = config.award_textures
	self._fade_in_speed = 2
	self._fade_in_alpha = 0
	self._fade_in_alpha_finished = 0.55
	self._finished = false
	self._animations = {}
end

function BattleReportSummaryAwardMenuItem:start(play_animation)
	if play_animation then
		self._animations[self._anim_fade_in] = true
	else
		self.config.on_finished(self)

		self._fade_in_alpha = 1
		self._animations[self._anim_idle] = true
	end
end

function BattleReportSummaryAwardMenuItem:_anim_fade_in(dt, t, gui, layout_settings)
	self._fade_in_alpha = math.lerp(self._fade_in_alpha, 1, dt * self._fade_in_speed)

	if self._fade_in_alpha > self._fade_in_alpha_finished and not self._finished then
		self.config.on_finished(self)

		self._finished = true
	end
end

function BattleReportSummaryAwardMenuItem:_anim_idle()
	return
end

function BattleReportSummaryAwardMenuItem:update_size(dt, t, gui, layout_settings, w, h)
	self._width = w
	self._height = h

	BattleReportSummaryAwardMenuItem.super.update_size(self, dt, t, gui)
end

function BattleReportSummaryAwardMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z or 1

	BattleReportSummaryAwardMenuItem.super.update_position(self, dt, t)
end

function BattleReportSummaryAwardMenuItem:render(dt, t, gui, layout_settings)
	if table.size(self._animations) == 0 then
		return
	end

	for anim, update in pairs(self._animations) do
		if update then
			anim(self, dt, t, gui, layout_settings)
		end
	end

	self:_render_gui(dt, t, gui, layout_settings)
	BattleReportSummaryAwardMenuItem.super.render(self, dt, t, gui)
end

function BattleReportSummaryAwardMenuItem:_render_gui(dt, t, gui, layout_settings)
	local textures = self._award_textures
	local num_textures = #textures
	local texture_w = layout_settings.texture_width
	local texture_h = layout_settings.texture_height
	local texture_x = math.floor(self._x + (self._width - texture_w) / 2)
	local texture_y = math.floor(self._y + (self._height - texture_h) / 2)
	local texture_size = Vector2(texture_w, texture_h)
	local texture_color = Color(255 * self._fade_in_alpha, 255, 255, 255)
	local texture_offset_z

	for i, texture in ipairs(textures) do
		local texture_settings = layout_settings.texture_atlas_settings[texture]
		local uv00 = Vector2(texture_settings.uv00[1], texture_settings.uv00[2])
		local uv11 = Vector2(texture_settings.uv11[1], texture_settings.uv11[2])

		texture_offset_z = num_textures - i

		Gui.bitmap_uv(gui, layout_settings.texture_atlas_name, uv00, uv11, Vector3(texture_x, texture_y, self._z + texture_offset_z + 1), texture_size, texture_color)
	end

	if self._award_amount > 1 then
		local amount_text = "x" .. self._award_amount
		local min, max = Gui.text_extents(gui, amount_text, layout_settings.font.font, layout_settings.font_size)
		local amount_text_width = max[1] - min[1]
		local amount_text_height = max[3] - min[3]
		local amount_text_x = texture_x + texture_w - amount_text_width + layout_settings.amount_text_offset_x
		local amount_text_y = texture_y + layout_settings.amount_text_offset_y
		local amount_text_z = self._z + texture_offset_z + 3
		local amount_text_color = Color(layout_settings.amount_text_color[1] * self._fade_in_alpha, layout_settings.amount_text_color[2], layout_settings.amount_text_color[3], layout_settings.amount_text_color[4])
		local amount_text_shadow_color = Color(layout_settings.amount_text_shadow_color[1] * self._fade_in_alpha, layout_settings.amount_text_shadow_color[2], layout_settings.amount_text_shadow_color[3], layout_settings.amount_text_shadow_color[4])
		local amount_text_shadow_offset = Vector2(layout_settings.amount_text_shadow_offset[1], layout_settings.amount_text_shadow_offset[2])

		ScriptGUI.text(gui, amount_text, layout_settings.font.font, layout_settings.font_size, layout_settings.font.material, Vector3(math.floor(amount_text_x), math.floor(amount_text_y), amount_text_z), amount_text_color, amount_text_shadow_color, amount_text_shadow_offset)

		local amount_rect_color = Color(layout_settings.amount_rect_color[1] * self._fade_in_alpha, layout_settings.amount_rect_color[2], layout_settings.amount_rect_color[3], layout_settings.amount_rect_color[4])
		local amount_rect_width = amount_text_width + math.abs(layout_settings.amount_text_offset_x) * 2
		local amount_rect_height = amount_text_height + math.abs(layout_settings.amount_text_offset_y) * 2
		local amount_rect_x = texture_x + texture_w - amount_rect_width
		local amount_rect_y = texture_y
		local amount_rect_z = self._z + texture_offset_z + 2

		Gui.rect(gui, Vector3(math.floor(amount_rect_x), math.floor(amount_rect_y), amount_rect_z), Vector2(amount_rect_width, amount_rect_height), amount_rect_color)
	end

	local name_text = HUDHelper:crop_text(gui, L(self._award_name), layout_settings.font.font, layout_settings.font_size, layout_settings.name_text_max_width, "...")
	local min, max = Gui.text_extents(gui, name_text, layout_settings.font.font, layout_settings.font_size)
	local name_text_width = max[1] - min[1]
	local name_text_x = texture_x + texture_w / 2 - name_text_width / 2 - min[1]
	local name_text_y = texture_y + layout_settings.name_text_offset_y
	local name_text_color = Color(layout_settings.name_text_color[1] * self._fade_in_alpha, layout_settings.name_text_color[2], layout_settings.name_text_color[3], layout_settings.name_text_color[4])

	ScriptGUI.text(gui, name_text, layout_settings.font.font, layout_settings.font_size, layout_settings.font.material, Vector3(math.floor(name_text_x), math.floor(name_text_y), self._z), name_text_color)
end

function BattleReportSummaryAwardMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		type = "battle_report_summary_award",
		page = config.page,
		name = config.name,
		disabled = config.disabled,
		callback_object = callback_object,
		on_finished = callback(callback_object, config.on_finished),
		award_name = config.award_name,
		award_amount = config.award_amount,
		award_textures = config.award_textures,
		layout_settings = config.layout_settings,
		floating_tooltip = config.floating_tooltip,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.battle_report_summary_award
	}

	return BattleReportSummaryAwardMenuItem:new(config, compiler_data.world)
end
