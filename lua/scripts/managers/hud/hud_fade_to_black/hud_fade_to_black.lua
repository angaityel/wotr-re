-- chunkname: @scripts/managers/hud/hud_fade_to_black/hud_fade_to_black.lua

require("scripts/managers/hud/shared_hud_elements/hud_rect_element")

HUDFadeToBlack = class(HUDFadeToBlack, HUDBase)

function HUDFadeToBlack:init(world, player)
	HUDFadeToBlack.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup_black_plane()
end

function HUDFadeToBlack:_setup_black_plane()
	local config = table.clone(HUDSettings.fade_to_black)

	self._black_plane_config = config
	self._black_plane = HUDRectElement:new(self._gui, config)
end

function HUDFadeToBlack:post_update(dt, t)
	local w, h = Gui.resolution()
	local config = self._black_plane_config

	config.width = w
	config.height = h
	config.color[1] = Managers.state.camera:variable(self._player.viewport_name, "fade_to_black") * 255

	self._black_plane:render(dt, t, 0, 0)
end

function HUDFadeToBlack:destroy()
	World.destroy_gui(self._world, self._gui)
end
