-- chunkname: @scripts/managers/input/input_manager.lua

require("scripts/managers/input/script_input_source")

function InputManager:map_robot_slot(slot, mapping_template, default_mapping)
	self:map_slot(slot, mapping_template, default_mapping)

	self._script_input_source = ScriptInputSource:new(slot, mapping_template)

	self:update_input_source(self._script_input_source)

	return self._script_input_source
end

function InputManager:start_script_input(input_table, loop)
	self._script_input_source:start(input_table, loop)
end

function InputManager:update(dt, t)
	if self._script_input_source then
		self._script_input_source:update(dt, t)
	end
end
