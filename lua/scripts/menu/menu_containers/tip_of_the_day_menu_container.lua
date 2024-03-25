-- chunkname: @scripts/menu/menu_containers/tip_of_the_day_menu_container.lua

require("scripts/menu/menu_containers/menu_container")
require("scripts/settings/tip_of_the_day")

TipOfTheDayMenuContainer = class(TipOfTheDayMenuContainer, MenuContainer)

function TipOfTheDayMenuContainer:init(world)
	TipOfTheDayMenuContainer.super.init(self)

	self._tip_text = TextBoxMenuContainer.create_from_config()
	self._world = world
end

function TipOfTheDayMenuContainer:load_tip(tip_name, level_name, layout_settings, gui)
	local tip_settings = TipOfTheDay[tip_name]
	local level_settings = LevelSettings[level_name]
	local text = tip_settings.text

	if tip_settings.text_pad360 and Managers.input:pad_active(1) then
		text = tip_settings.text_pad360
	end

	self._tip_text:set_text(L(text), layout_settings.tip_text, gui)

	local tip_video = tip_settings[layout_settings.tip_graphics.video_key] or level_settings.loading_screen_preview[layout_settings.tip_graphics.video_key]

	if tip_video then
		self._tip_video_gui = World.create_screen_gui(self._world, "material", tip_video.material, "immediate")
		self._tip_video_player = World.create_video_player(self._world, tip_video.ivf, layout_settings.loop)
		self._tip_video = tip_video
	else
		self._tip_texture = tip_settings[layout_settings.tip_graphics.texture_key] or level_settings.loading_screen_preview[layout_settings.tip_graphics.texture_key]
	end
end

function TipOfTheDayMenuContainer:update_size(dt, t, gui, layout_settings)
	self._tip_text:update_size(dt, t, gui, layout_settings.tip_text)

	self._width = layout_settings.tip_background_texture.texture_width
	self._height = layout_settings.tip_background_texture.texture_height
end

function TipOfTheDayMenuContainer:update_position(dt, t, layout_settings, x, y, z)
	local text_x = x + layout_settings.tip_text.offset_x
	local text_y = y - self._tip_text:height() + layout_settings.tip_text.offset_y

	self._tip_text:update_position(dt, t, layout_settings.tip_text, text_x, text_y, z + 2)

	self._x = x
	self._y = y
	self._z = z
end

function TipOfTheDayMenuContainer:render(dt, t, gui, layout_settings)
	local tip_x = self._x + layout_settings.tip_graphics.offset_x
	local tip_y = self._y + layout_settings.tip_graphics.offset_y
	local tip_z = self._z + 2
	local tip_w = layout_settings.tip_graphics.width
	local tip_h = layout_settings.tip_graphics.height

	if self._tip_video_player then
		Gui.video(self._tip_video_gui, self._tip_video.video, self._tip_video_player, Vector3(math.floor(tip_x), math.floor(tip_y), tip_z), Vector2(tip_w, tip_h))
	elseif self._tip_texture then
		Gui.bitmap(gui, self._tip_texture, Vector3(math.floor(tip_x), math.floor(tip_y), tip_z), Vector2(tip_w, tip_h))
	end

	self._tip_text:render(dt, t, gui, layout_settings.tip_text)

	local c = layout_settings.tip_background_texture.texture_color
	local texture_color = Color(c[1], c[2], c[3], c[4])

	Gui.bitmap(gui, layout_settings.tip_background_texture.texture, Vector3(math.floor(self._x), math.floor(self._y), self._z), Vector2(layout_settings.tip_background_texture.texture_width, layout_settings.tip_background_texture.texture_height), texture_color)
	Gui.bitmap(gui, layout_settings.corner_top_texture.texture, Vector3(math.floor(self._x + layout_settings.corner_top_texture.texture_offset_x), math.floor(self._y + layout_settings.corner_top_texture.texture_offset_y), self._z + 1), Vector2(layout_settings.corner_top_texture.texture_width, layout_settings.corner_top_texture.texture_height))
	Gui.bitmap(gui, layout_settings.corner_bottom_texture.texture, Vector3(math.floor(self._x + layout_settings.corner_bottom_texture.texture_offset_x), math.floor(self._y + layout_settings.corner_bottom_texture.texture_offset_y), self._z + 1), Vector2(layout_settings.corner_bottom_texture.texture_width, layout_settings.corner_bottom_texture.texture_height))
end

function TipOfTheDayMenuContainer:destroy()
	TipOfTheDayMenuContainer.super.destroy(self)

	if self._tip_video_gui then
		World.destroy_gui(self._world, self._tip_video_gui)

		self._tip_video_gui = nil
	end

	if self._tip_video_player then
		World.destroy_video_player(self._world, self._tip_video_player)

		self._tip_video_player = nil
	end
end

function TipOfTheDayMenuContainer.create_from_config(world)
	return TipOfTheDayMenuContainer:new(world)
end
