-- chunkname: @scripts/menu/menu_items/battle_report_summary_menu_item.lua

BattleReportSummaryMenuItem = class(BattleReportSummaryMenuItem, MenuItem)

function BattleReportSummaryMenuItem:init(config, world)
	BattleReportSummaryMenuItem.super.init(self, config, world)

	self._fade_in_speed = 3
	self._fade_in_finished = 0.1
	self._increment_speed_xp = 1100
	self._fade_out_speed = 3
	self._fade_out_size_target = 2
	self._fade_out_finished = 0.95
	self._pulse_speed = 3
	self._pulse_size_amplitude = 0.075
	self._fade_in_alpha = 0
	self._fade_out_alpha = 1
	self._fade_out_size = 1
	self._pulse_size = 1
	self._pulse_time = 0
	self._xp = 0
	self._multiplier = 0
	self._coins = 0
	self._finished = false
	self._animations = {}
end

function BattleReportSummaryMenuItem:start(data, play_animation)
	if play_animation then
		self._xp_target = IS_DEMO and data.xp / ExperienceSettings.DEMO_MULTIPLIER or data.xp
		self._multiplier_target = data.count
		self._coins_target = IS_DEMO and data.coins / ExperienceSettings.DEMO_MULTIPLIER or data.coins

		if self._xp_target > 0 then
			self._increment_speed_multiplier = self._multiplier_target / self._xp_target * self._increment_speed_xp
			self._increment_speed_coins = self._coins_target / self._xp_target * self._increment_speed_xp
		end

		self._animations[self._anim_fade_in] = true
	else
		self._xp = IS_DEMO and data.xp / ExperienceSettings.DEMO_MULTIPLIER or data.xp
		self._multiplier = data.count
		self._coins = IS_DEMO and data.coins / ExperienceSettings.DEMO_MULTIPLIER or data.coins

		self.config.on_increment(data.xp, data.coins)
		self.config.on_finished(self)

		self._finished = true
		self._fade_in_alpha = 1
		self._animations[self._anim_idle] = true
	end
end

function BattleReportSummaryMenuItem:update_size(dt, t, gui, layout_settings, w, h)
	self._width = w
	self._height = h
end

function BattleReportSummaryMenuItem:update_position(dt, t, layout_settings, x, y, z)
	self._x = x
	self._y = y
	self._z = z
end

function BattleReportSummaryMenuItem:render(dt, t, gui, layout_settings)
	if table.size(self._animations) == 0 then
		return
	end

	for anim, update in pairs(self._animations) do
		if update then
			anim(self, dt, t, gui, layout_settings)
		end
	end

	self:_render_gui(dt, t, gui, layout_settings)
end

function BattleReportSummaryMenuItem:_anim_fade_in(dt, t, gui, layout_settings)
	self._fade_in_alpha = math.lerp(self._fade_in_alpha, 1, dt * self._fade_in_speed)

	if self._fade_in_alpha > self._fade_in_finished and self._animations[self._anim_increment] == nil then
		self._animations[self._anim_increment] = true
	end
end

function BattleReportSummaryMenuItem:_anim_increment(dt, t, gui, layout_settings)
	local xp_delta = 0
	local coins_delta = 0

	if self._xp < self._xp_target then
		xp_delta = dt * self._increment_speed_xp

		if self._xp + xp_delta > self._xp_target then
			xp_delta = self._xp_target - self._xp
		end

		self._xp = self._xp + xp_delta

		local multiplier_delta = dt * self._increment_speed_multiplier

		if self._multiplier + multiplier_delta > self._multiplier_target then
			multiplier_delta = self._multiplier_target - self._multiplier
		end

		self._multiplier = self._multiplier + multiplier_delta
		coins_delta = dt * self._increment_speed_coins

		if self._coins + coins_delta > self._coins_target then
			coins_delta = self._coins_target - self._coins
		end

		self._coins = self._coins + coins_delta
	end

	self.config.on_increment(xp_delta, coins_delta)

	if self._xp == self._xp_target then
		self._multiplier = self._multiplier_target
		self._coins = self._coins_target
		self._animations[self._anim_increment] = false
		self._animations[self._anim_fade_out] = true
	end
end

function BattleReportSummaryMenuItem:_anim_fade_out(dt, t, gui, layout_settings)
	self._fade_out_alpha = math.lerp(self._fade_out_alpha, 0, dt * self._fade_out_speed)
	self._fade_out_size = math.lerp(self._fade_out_size, self._fade_out_size_target, dt * self._fade_out_speed)

	if self._fade_out_alpha < self._fade_out_finished and not self._finished then
		self.config.on_finished(self)

		self._finished = true
	end
end

function BattleReportSummaryMenuItem:_anim_pulse(dt, t, gui, layout_settings)
	self._pulse_time = self._pulse_time + dt
	self._pulse_size = self._pulse_size_amplitude * math.sin(self._pulse_time * math.pi * self._pulse_speed) + 1

	if self._pulse_size <= 1 then
		self._pulse_size = 1
	end
end

function BattleReportSummaryMenuItem:_anim_idle()
	return
end

function BattleReportSummaryMenuItem:_render_gui(dt, t, gui, layout_settings)
	local column_offset_x = layout_settings.text_offset_x

	self:_render_text(L(self.config.header), column_offset_x, layout_settings.text_offset_y, gui, layout_settings)

	column_offset_x = column_offset_x + layout_settings.column_width[1]

	if self._multiplier then
		local multiplier_text = string.format("%.0f", math.ceil(self._multiplier))

		self:_render_text("x" .. multiplier_text, column_offset_x, layout_settings.text_offset_y, gui, layout_settings)
	end

	column_offset_x = column_offset_x + layout_settings.column_width[2]

	local xp_text = string.format("%s%.0f", self.config.text_prefix, math.ceil(self._xp))

	self:_render_text(xp_text, column_offset_x, layout_settings.text_offset_y, gui, layout_settings)

	if self._animations[self._anim_fade_out] then
		self:_render_fade_out_text(xp_text, column_offset_x, layout_settings.text_offset_y, gui, layout_settings)
	end

	column_offset_x = column_offset_x + layout_settings.column_width[3]

	local coins_text = string.format("%s%.0f", self.config.text_prefix, math.ceil(self._coins))

	self:_render_text(coins_text, column_offset_x, layout_settings.text_offset_y, gui, layout_settings)

	if self._animations[self._anim_fade_out] then
		self:_render_fade_out_text(coins_text, column_offset_x, layout_settings.text_offset_y, gui, layout_settings)
	end

	if layout_settings.background_color then
		local c = layout_settings.background_color
		local color = Color(c[1], c[2], c[3], c[4])

		Gui.rect(gui, Vector3(math.floor(self._x), math.floor(self._y), self._z + 15), Vector2(self._width, self._height), color)
	end
end

function BattleReportSummaryMenuItem:_render_text(text, offset_x, offset_y, gui, layout_settings)
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = layout_settings.text_color
	local color = Color(c[1] * self._fade_in_alpha, c[2], c[3], c[4])
	local shadow_color_table = layout_settings.drop_shadow_color
	local shadow_color = shadow_color_table and Color(shadow_color_table[1] * self._fade_in_alpha, shadow_color_table[2], shadow_color_table[3], shadow_color_table[4])
	local shadow_offset = layout_settings.drop_shadow_offset and Vector2(layout_settings.drop_shadow_offset[1], layout_settings.drop_shadow_offset[2])
	local min_1, max_1 = Gui.text_extents(gui, text, font, layout_settings.font_size)
	local width_1 = max_1[1] - min_1[1]
	local height_1 = max_1[3] - min_1[3]
	local min_2, max_2 = Gui.text_extents(gui, text, font, layout_settings.font_size * self._pulse_size)
	local width_2 = max_2[1] - min_2[1]
	local height_2 = max_2[3] - min_2[3]
	local x = self._x + offset_x - (width_2 - width_1) / 2 - min_1[1]
	local y = self._y + offset_y - (height_2 - height_1) / 2 - min_1[3]

	if self._pulse_size == 1 then
		x = math.floor(x)
		y = math.floor(y)
	end

	ScriptGUI.text(gui, text, font, layout_settings.font_size * self._pulse_size, font_material, Vector3(x, y, self._z + 20), color, shadow_color, shadow_offset)
end

function BattleReportSummaryMenuItem:_render_fade_out_text(text, offset_x, offset_y, gui, layout_settings)
	local font = layout_settings.font and layout_settings.font.font or MenuSettings.fonts.menu_font.font
	local font_material = layout_settings.font and layout_settings.font.material or MenuSettings.fonts.menu_font.material
	local c = layout_settings.text_color
	local color = Color(c[1], c[2], c[3], c[4])
	local min, max = Gui.text_extents(gui, text, font, layout_settings.font_size)
	local width = max[1] - min[1]
	local height = max[3] - min[3]
	local fade_c = layout_settings.text_color
	local fade_color = Color(fade_c[1] * self._fade_out_alpha, fade_c[2], fade_c[3], fade_c[4])
	local fade_min, fade_max = Gui.text_extents(gui, text, font, layout_settings.font_size * self._fade_out_size)
	local fade_width = fade_max[1] - fade_min[1]
	local fade_height = fade_max[3] - fade_min[3]
	local fade_x = self._x + offset_x + width / 2 - fade_width / 2 - fade_min[1]
	local fade_y = self._y + offset_y + height / 2 - fade_height / 2 - fade_min[3]

	ScriptGUI.text(gui, text, font, layout_settings.font_size * self._fade_out_size, font_material, Vector3(fade_x, fade_y, self._z + 20), fade_color)
end

function BattleReportSummaryMenuItem.create_from_config(compiler_data, config, callback_object)
	local config = {
		disabled = true,
		type = "battle_report_summary",
		page = config.page,
		name = config.name,
		remove_func = config.remove_func and callback(callback_object, config.remove_func),
		callback_object = callback_object,
		on_increment = callback(callback_object, config.on_increment),
		on_finished = callback(callback_object, config.on_finished),
		layout_settings = config.layout_settings,
		parent_page = config.parent_page,
		sounds = config.parent_page.config.sounds.items.battle_report_summary,
		z = config.z,
		header = config.header,
		text_prefix = config.text_prefix or ""
	}

	return BattleReportSummaryMenuItem:new(config, compiler_data.world)
end
