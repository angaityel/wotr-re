-- chunkname: @scripts/managers/hud/hud_deserting/hud_deserting.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_text_element")
require("scripts/managers/hud/hud_deserting/hud_deserting_timer")

HUDDeserting = class(HUDDeserting, HUDBase)

function HUDDeserting:init(world, player)
	HUDDeserting.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/mockup_hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	Managers.state.event:register(self, "event_deserting_activated", "event_deserting_activated", "event_deserting_deactivated", "event_deserting_deactivated")
end

function HUDDeserting:event_deserting_activated(player, deserter_timer)
	if player == self._player then
		self._deserting_timer = deserter_timer
	end
end

function HUDDeserting:event_deserting_deactivated(player)
	if player == self._player then
		self._deserting_timer = nil
	end
end

function HUDDeserting:post_update(dt, t)
	if not self._deserting_timer then
		return
	end

	self._deserting_timer = self._deserting_timer - dt

	local announcement_time_param = string.format("%.0f", math.ceil(self._deserting_timer))

	if announcement_time_param ~= self._announcement_time_param then
		Managers.state.event:trigger("game_mode_announcement", "deserter_out_of_bonds", announcement_time_param)
	end

	self._announcement_time_param = announcement_time_param
end

function HUDDeserting:destroy()
	World.destroy_gui(self._world, self._gui)
end
