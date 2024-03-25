-- chunkname: @scripts/managers/hud/hud_interaction/hud_interaction.lua

require("scripts/managers/hud/shared_hud_elements/hud_container_element")
require("scripts/managers/hud/shared_hud_elements/hud_text_element")
require("scripts/managers/hud/shared_hud_elements/hud_bar_element")

HUDInteraction = class(HUDInteraction, HUDBase)

function HUDInteraction:init(world, player)
	HUDInteraction.super.init(self, world, player)

	self._world = world
	self._player = player
	self._gui = World.create_screen_gui(world, "material", "materials/hud/hud", "material", MenuSettings.font_group_materials.arial, "immediate")

	self:_setup()
end

function HUDInteraction:_setup()
	self._interaction_container = HUDContainerElement.create_from_config({
		layout_settings = HUDSettings.interaction.container
	})

	local objective_bar_config = {
		z = 20,
		layout_settings = table.clone(HUDSettings.interaction.objective_bar)
	}

	self._interaction_container:add_element("objective_bar", HUDBarElement.create_from_config(objective_bar_config))
end

function HUDInteraction:post_update(dt, t)
	local layout_settings = HUDHelper:layout_settings(self._interaction_container.config.layout_settings)
	local gui = self._gui
	local objectives_blackboard = self._player.state_data.objectives_blackboard
	local render = false

	if objectives_blackboard and objectives_blackboard.capture_scale and objectives_blackboard.capture_scale ~= 0 then
		local progress = objectives_blackboard.capture_scale
		local player = self._player
		local team = player.team
		local side = team and team.side

		if side then
			local color1, color2, capturing_team, color_table1, color_table2

			if objectives_blackboard.owner_team_side == side then
				color_table2 = HUDSettings.player_colors.team_member
			elseif objectives_blackboard.owner_team_side == "neutral" then
				color_table2 = HUDSettings.player_colors.neutral_team
			else
				color_table2 = HUDSettings.player_colors.enemy
			end

			if objectives_blackboard.capturing_team then
				if objectives_blackboard.owner_team_side == "neutral" or objectives_blackboard.instant_capture then
					if objectives_blackboard.capturing_team == side then
						color_table1 = HUDSettings.player_colors.team_member
					else
						color_table1 = HUDSettings.player_colors.enemy
					end
				else
					color_table1 = HUDSettings.player_colors.neutral_team
				end
			end

			local bar = self._interaction_container:elements().objective_bar

			bar.config.progress = progress
			bar.config.texture_color = color_table1
			bar.config.texture_2_color = color_table2

			if not self._render then
				bar:set_progress(progress)
			end

			render = true
		end
	end

	self._player.state_data.objectives_blackboard = {}

	if render then
		self._interaction_container:update_size(dt, t, gui, layout_settings)

		local x, y = HUDHelper:element_position(nil, self._interaction_container, layout_settings)

		self._interaction_container:update_position(dt, t, layout_settings, x, y, layout_settings.z)
		self._interaction_container:render(dt, t, gui, layout_settings)
	end

	if render and not self._render then
		self._counting_down_loop = TimpaniWorld.trigger_event(World.timpani_world(self._world), "hud_counting_down_loop")
	elseif not render and self._render then
		self:_stop_looping_sounds()
	end

	self._render = render
end

function HUDInteraction:_stop_looping_sounds()
	if self._counting_down_loop then
		TimpaniWorld.stop(World.timpani_world(self._world), self._counting_down_loop)

		self._counting_down_loop = nil
	end
end

function HUDInteraction:on_deactivated()
	self:_stop_looping_sounds()
end

function HUDInteraction:set_enabled(enabled)
	HUDInteraction.super.set_enabled(self, enabled)

	if not enabled then
		self:_stop_looping_sounds()
	end
end

function HUDInteraction:destroy()
	World.destroy_gui(self._world, self._gui)

	if self._counting_down_loop then
		TimpaniWorld.stop(World.timpani_world(self._world), self._counting_down_loop)

		self._counting_down_loop = nil
	end
end
