-- chunkname: @foundation/scripts/managers/player/player.lua

Player = class(Player)

function Player:init(player_index, input_slot, input_source, viewport_name, viewport_world_name)
	self.index = player_index
	self.input_slot = input_slot
	self.input_source = input_source
	self.viewport_name = viewport_name
	self.viewport_world_name = viewport_world_name
	self.owned_units = {}
	self.camera_follow_unit = nil
end

function Player:destroy()
	return
end

function Player:set_camera_follow_unit(unit)
	self.camera_follow_unit = unit
end
