-- chunkname: @foundation/scripts/util/gui/gui_aux.lua

WindowInfo = WindowInfo or {}

function WindowInfo.new(w, h, llx, lly, urx, ury)
	return {
		w = w,
		h = h,
		llx = llx,
		lly = lly,
		urx = urx,
		ury = ury
	}
end

function WindowInfo.make(pos, size)
	local w = size.x
	local h = size.y

	return WindowInfo.new(w, h, pos.x, pos.y, pos.x + w, pos.y + h)
end

function WindowInfo.size(w)
	return Vector3(w.w, w.h, 0)
end

function WindowInfo.center(w)
	return WindowInfo.size(w) * 0.5
end

function WindowInfo.position(w)
	return Vector3(w.llx, w.lly, 0)
end

function WindowInfo.quadrant_ur(wi)
	local half_width = wi.w * 0.5
	local half_height = wi.h * 0.5

	return {
		w = half_width,
		h = half_height,
		llx = wi.urx - half_width,
		lly = wi.ury - half_height,
		urx = wi.urx,
		ury = wi.ury
	}
end

function WindowInfo.scale_height(wi, percentage)
	local height_mod = wi.h * (percentage - 1)
	local half_height_mod = height_mod * 0.5

	wi.w = wi.w
	wi.h = wi.h * percentage
	wi.llx = wi.llx
	wi.lly = wi.lly - half_height_mod
	wi.urx = wi.urx
	wi.ury = wi.ury + half_height_mod
end

function WindowInfo.scale_width(wi, percentage)
	local width_mod = wi.w * (percentage - 1)
	local half_width_mod = width_mod * 0.5

	wi.w = wi.w * percentage
	wi.h = wi.h
	wi.llx = wi.llx - half_width_mod
	wi.lly = wi.lly
	wi.urx = wi.urx + half_width_mod
	wi.ury = wi.ury
end

function WindowInfo.uniform_scale(wi, percentage)
	local height_mod = wi.h * (percentage - 1)
	local width_mod = wi.w * (percentage - 1)
	local half_height_mod = height_mod * 0.5
	local half_width_mod = width_mod * 0.5

	wi.w = wi.w * percentage
	wi.h = wi.h * percentage
	wi.llx = wi.llx - half_width_mod
	wi.lly = wi.lly - half_height_mod
	wi.urx = wi.urx + half_width_mod
	wi.ury = wi.ury + half_height_mod
	wi.percentage = percentage
end

function WindowInfo.hud_uniform_scale(wi, percentage, gui)
	local height_mod = wi.h * (percentage - 1)
	local width_mod = wi.h * (percentage - 1)
	local half_height_mod = height_mod * 0.5
	local half_width_mod = width_mod * 0.5

	wi.w = wi.w * percentage
	wi.h = wi.h * percentage
	wi.llx = wi.llx - half_width_mod
	wi.lly = wi.lly - half_height_mod
	wi.urx = wi.urx + half_width_mod
	wi.ury = wi.ury + half_height_mod
	wi.percentage = percentage

	if gui then
		-- block empty
	end
end

function WindowInfo.split_horizontal(wi)
	local width = wi.w
	local half_height = wi.h * 0.5
	local size = {
		x = width,
		y = half_height
	}
	local top = {
		x = wi.llx,
		y = wi.lly + half_height
	}
	local bottom = {
		x = wi.llx,
		y = wi.lly
	}
	local top_win = WindowInfo.make(top, size)
	local bottom_win = WindowInfo.make(bottom, size)

	return top_win, bottom_win
end

function WindowInfo.to_string(wi)
	return sprintf("WindowInfo : width(%d), height(%d), lower left(%d, %d), upper right(%d, %d)", wi.w, wi.h, wi.llx, wi.lly, wi.urx, wi.ury)
end

GuiDock = {}
GuiDock.left = 0
GuiDock.right = 1
GuiDock.center = 2
GuiDock.top = 3
GuiDock.bottom = 4
GuiDock.center = 5
GuiAux = {}

function GuiAux.rect_position(rw, rh, wi, dih, div)
	local x, y
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()
	local height_mod = 720 * (wi.percentage - 1)
	local half_height_mod = height_mod * 0.5
	local real_ury = 720 + half_height_mod

	if div == GuiDock.bottom then
		y = wi.lly
	elseif div == GuiDock.top then
		y = real_ury - rh
	else
		local half_screen_height = wi.h * 0.5
		local half_rect_height = rh * 0.5

		y = wi.lly + half_screen_height - half_rect_height
	end

	if dih == GuiDock.left then
		x = wi.llx
	elseif dih == GuiDock.right then
		x = wi.urx - rw
	else
		local half_screen_width = wi.w * 0.5
		local half_rect_width = rw * 0.5

		x = wi.llx + half_screen_width - half_rect_width
	end

	return Vector3(x, y, 0), Vector3(rw, rh, 0)
end

function GuiAux.drawer_text_extents(gui_proxy, text, font, font_size)
	local min, max = Gui.text_extents(gui_proxy:gui(), text, font, font_size)
	local text_width = math.abs(min.x) + math.abs(max.x)
	local text_height = math.abs(min.z) + math.abs(max.z)

	return Vector3(text_width, text_height, 0)
end

function GuiAux.text_extents(gui, text, material, font_size)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	font_size = font_size * scale

	return Gui.text_extents(gui, text, material, font_size)
end

function GuiAux.text(gui, text, material, font_size, font, position, color)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	font_size = font_size * w_scale
	material, font = GuiAux.handle_huggable(material, font, font_size)
	position = Vector3(position.x * w_scale, position.y * h_scale, position.z)

	Gui.text(gui, text, material, font_size, font, position, color)
end

function GuiAux.handle_huggable(material, font, font_size)
	if font ~= "huggable" then
		return material, font
	elseif font_size < 35 then
		local rest_26 = math.abs(font_size - 26)
		local rest_35 = math.abs(font_size - 35)

		if rest_26 < rest_35 then
			return "materials/fonts/huggable_26", "huggable_26"
		else
			return "materials/fonts/huggable_35", "huggable_35"
		end
	elseif font_size < 50 then
		local rest_35 = math.abs(font_size - 35)
		local rest_50 = math.abs(font_size - 50)

		if rest_35 < rest_50 then
			return "materials/fonts/huggable_35", "huggable_35"
		else
			return "materials/fonts/huggable_50", "huggable_50"
		end
	else
		local rest_50 = math.abs(font_size - 50)
		local rest_90 = math.abs(font_size - 90)

		if rest_50 < rest_90 then
			return "materials/fonts/huggable_50", "huggable_50"
		else
			return "materials/fonts/huggable_90", "huggable_90"
		end
	end
end

function GuiAux.bitmap_uv(gui, material, uv00, uv11, pos, size, color, uniform_w, uniform_h)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	size_scale_w = unifrom_w and w_scale or uniform_h and h_scale or w_scale
	size_scale_h = unifrom_w and w_scale or uniform_h and h_scale or h_scale

	local uniform_size = Vector2(size.x * w_scale, size.y * h_scale)

	size = Vector2(size.x * size_scale_w, size.y * size_scale_h)

	local center_diff = (uniform_size - size) * 0.5

	pos = Vector3(pos.x * w_scale + center_diff.x, pos.y * h_scale + center_diff.y, pos.z)

	Gui.bitmap_uv(gui, material, uv00, uv11, pos, size, color)
end

function GuiAux.bitmap(gui, material, position, size, color, uniform_w, uniform_h)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	size_scale_w = unifrom_w and w_scale or uniform_h and h_scale or w_scale
	size_scale_h = unifrom_w and w_scale or uniform_h and h_scale or h_scale

	local uniform_size = Vector2(size.x * w_scale, size.y * h_scale)

	size = Vector2(size.x * size_scale_w, size.y * size_scale_h)

	local center_diff = (uniform_size - size) * 0.5
	local pos = Vector3(position.x * w_scale + center_diff.x, position.y * h_scale + center_diff.y, position.z)

	Gui.bitmap(gui, material, pos, size, color)
end

function GuiAux.bitmap_3d(gui, material, angle_in_radians, position, layer, size, color, uniform_w, uniform_h)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	size_scale_w = unifrom_w and w_scale or uniform_h and h_scale or w_scale
	size_scale_h = unifrom_w and w_scale or uniform_h and h_scale or h_scale

	local uniform_size = Vector2(size.x * w_scale, size.y * h_scale)

	size = Vector2(size.x * size_scale_w, size.y * size_scale_h)

	local center_diff = (uniform_size - size) * 0.5
	local pos = Vector3(position.x * w_scale + center_diff.x, position.y * h_scale + center_diff.y, position.z)
	local transform = Rotation2D(Vector2(0, 0), angle_in_radians, Vector2(pos[1] + size[1] * 0.5, pos[2] + size[2] * 0.5))

	Gui.bitmap_3d(gui, material, transform, pos, layer, size, color)
end

function GuiAux.bitmap_hud(dock_horizontal, dock_vertical, gui, material, position, size, color)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()
	local w, h = Application.resolution()

	position = Vector3(position.x * h_scale, position.y * h_scale, position.z)
	position = GuiAux.handle_docking(dock_horizontal, dock_vertical, position)
	size = Vector2(size.x * h_scale, size.y * h_scale)

	Gui.bitmap(gui, material, position, size, color)
end

function GuiAux.handle_docking(d_h, d_v, pos)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()
	local w, h = Application.resolution()

	if d_h and (d_h == GuiDock.right or d_h == "right") then
		pos.x = pos.x + (w - w * h_scale)
	elseif d_h and (d_h == GuiDock.center or d_h == "center") then
		pos.x = pos.x + (w * 0.5 - w * h_scale * 0.5)
	end

	return pos
end

function GuiAux.bitmap_uv_hud(dock_horizontal, dock_vertical, gui, material, uv00, uv11, pos, size, color)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	pos = Vector3(pos.x * h_scale, pos.y * h_scale, pos.z)
	position = GuiAux.handle_docking(dock_horizontal, dock_vertical, pos)
	size = Vector2(size.x * h_scale, size.y * h_scale)

	Gui.bitmap_uv(gui, material, uv00, uv11, pos, size, color)
end

function GuiAux.rect_hud(dock_horizontal, dock_vertical, gui, pos, size, color)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	pos = Vector3(pos.x * h_scale, pos.y * h_scale, pos.z)
	pos = GuiAux.handle_docking(dock_horizontal, dock_vertical, pos)
	size = Vector2(size.x * h_scale, size.y * h_scale)

	Gui.rect(gui, pos, size, color)
end

function GuiAux.handle_aspect_resolution(pos)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	return Vector3(pos.x * w_scale, pos.y * h_scale, pos.z)
end

function GuiAux.handle_aspect_resolution_hud(dock_h, dock_v, pos)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	pos = Vector3(pos.x * h_scale, pos.y * h_scale, pos.z)
	pos = GuiAux.handle_docking(dock_h, dock_v, pos)

	return pos
end

function GuiAux.rect_3d(gui, tm, position, layer, size, color)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	position = Vector3(position.x * w_scale, position.y * h_scale, position.z)
	size = Vector2(size.x * w_scale, size.y * h_scale)

	Gui.rect_3d(gui, tm, position, layer, size, color)
end

function GuiAux.rect(gui, position, size, color)
	local scale, w_scale, h_scale = GuiAux.get_scaled_resolution()

	position = Vector3(position.x * w_scale, position.y * h_scale, position.z)
	size = Vector2(size.x * w_scale, size.y * h_scale)

	Gui.rect(gui, position, size, color)
end

function GuiAux.get_scaled_resolution(uniform_w, uniform_h)
	local w, h = Application.resolution()
	local aspect = w / h

	return aspect / 1.7777777777777777, w / 1280, h / 720
end

ColorTable = ColorTable or {}

function ColorTable.orange()
	return Color(255, 159, 0)
end

function ColorTable.white()
	return Color(255, 255, 255)
end

function ColorTable.yellow()
	return Color(255, 204, 1)
end

function ColorTable.red()
	return Color(255, 0, 0)
end

function ColorTable.green()
	return Color(0, 255, 0)
end

function ColorTable.blue()
	return Color(0, 0, 255)
end

GuiDrawer = GuiDrawer or {}

function GuiDrawer:setup(gui_proxy, font, material, font_size, color)
	self.proxy = gui_proxy
	self.gui = gui_proxy:gui()
	self.font = font
	self.material = material
	self.font_size = font_size
	self.color = color or ColorTable.white()
	self.rect = nil

	return self
end

function GuiDrawer:set_color(color_string)
	self.color = ColorTable[color_string] and ColorTable[color_string]() or ColorTable.white()
end

function GuiDrawer:set_fontsize(size)
	self.font_size = size
end

function GuiDrawer:set_font(font, material, font_size)
	self.font = font
	self.material = material
	self.font_size = font_size or self.font_size
end

function GuiDrawer:screen_text(text, position, color)
	position[3] = 998

	Gui.text(self.gui, text, self.font, self.font_size, self.material, position, color or self.color)
end

function GuiDrawer:screen_text_docked(text, dock_horizontal, dock_vertical, horizontal_offset, vertical_offset, color)
	color = color or Color(255, 255, 255)
	horizontal_offset = horizontal_offset or 0
	vertical_offset = vertical_offset or 0

	local extents = self:text_extents(text)
	local text_width = extents.x
	local text_height = extents.y
	local pos, size = GuiAux.rect_position(text_width, text_height, self.rect, dock_horizontal, dock_vertical)

	pos[1], pos[2] = pos[1] + horizontal_offset, pos[2] + vertical_offset

	self:screen_text(text, pos, color)
end

function GuiDrawer:get_text_position(text, dock_horizontal, dock_vertical, horizontal_offset, vertical_offset)
	horizontal_offset = horizontal_offset or 0
	vertical_offset = vertical_offset or 0

	local extents = self:text_extents(text)
	local text_width = extents.x
	local text_height = extents.y
	local pos, size = GuiAux.rect_position(text_width, text_height, self.rect, dock_horizontal, dock_vertical)

	pos[1], pos[2] = pos[1] + horizontal_offset, pos[2] + vertical_offset

	return pos
end

function GuiDrawer:screen_text_centered(text, y_pos, color)
	if not self.rect then
		print("GuiDrawer : no rect set. Dismissing!")

		return
	end

	local extents = self:text_extents(text)
	local text_width = extents.x
	local text_height = extents.y
	local pos, size = GuiAux.rect_position(text_width, text_height, self.rect, GuiDock.center, GuiDock.center)

	if y_pos then
		Vector3.set_y(pos, y_pos)
	end

	self:screen_text(text, pos, color)
end

function GuiDrawer:text_extents(text)
	return GuiAux.drawer_text_extents(self.proxy, text, self.font, self.font_size)
end

function GuiDrawer:set_viewport_target(name)
	local win = Managers.world:window(name)
	local saferect_percentage = 0.95

	WindowInfo.uniform_scale(win, saferect_percentage)

	self.rect = win
end
