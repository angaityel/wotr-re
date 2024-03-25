-- chunkname: @foundation/scripts/input/input_manager.lua

require("foundation/scripts/input/input_filters")
require("foundation/scripts/input/input_source")

InputManager = class(InputManager)
InputManager.INVALID_SLOT_ID = -1
InputManager.default_slot_mapping = InputManager.default_slot_mapping or {}

function InputManager:init()
	self._is_ps3 = Application.platform() == "ps3"

	self:_reset_mappings()
end

function InputManager:_reset_mappings()
	self._source_map = {}
	self._mapped_input_sources = {}
	self._slot_mapping = {}
	self._active_input_mapping = {}
end

function InputManager:map_controller(controller, slot)
	if self._source_map[controller] then
		self:unmap_controller(controller)
	end

	self._source_map[controller] = slot
	InputManager.default_slot_mapping[slot] = InputManager.default_slot_mapping[slot] or self:get_controller_settings_type(controller)

	self:update_slot(slot)
end

function InputManager:update_slot(slot)
	for _, input_source in ipairs(self._mapped_input_sources) do
		if input_source.slot == slot then
			self:update_input_source(input_source)
		end
	end
end

function InputManager:get_slot_controller_types(slot)
	local descriptions = {}

	for controller, slot_id in pairs(self._source_map) do
		if slot_id == slot then
			table.insert(descriptions, self:get_controller_type(controller))
		end
	end

	return descriptions
end

function InputManager:get_slot_controllers(slot)
	local controllers = {}

	for controller, slot_id in pairs(self._source_map) do
		if slot_id == slot then
			controllers[#controllers + 1] = controller
		end
	end

	return controllers
end

function InputManager:set_slot_mapping(slot, mapping_name)
	self._slot_mapping[slot] = mapping_name
end

function InputManager:get_keymapping_type(slot)
	return self._slot_mapping[slot]
end

function InputManager:unmap_controller(controller)
	local slot = self._source_map[controller]

	self._source_map[controller] = nil

	if slot then
		self:update_slot(slot)
	end
end

function InputManager:map_slot(slot, mapping_template, default_mapping)
	self:set_slot_mapping(slot, default_mapping)

	local input_source = InputSource:new(slot, mapping_template)

	self:update_input_source(input_source)
	table.insert(self._mapped_input_sources, input_source)

	return input_source
end

function InputManager:unmap_input_source(input_source)
	for ii, source in pairs(self._mapped_input_sources) do
		if source == input_source then
			table.remove(self._mapped_input_sources, ii)
			input_source:clear()

			return
		end
	end

	ferror("Trying to unmap nonexistant input source")
end

function InputManager:update_input_source(input_source)
	local slot = input_source.slot
	local input_type = self:get_keymapping_type(slot)
	local local_mapping, global_mapping

	if input_type then
		local_mapping = input_source.mapping_template[input_type]
	else
		global_mapping = input_source.mapping_template
	end

	if not local_mapping and not global_mapping then
		input_source:clear()

		return
	end

	local cloned = table.clone(local_mapping or global_mapping)
	local controllers = {}

	for controller, slot_id in pairs(self._source_map) do
		if slot_id == slot then
			if global_mapping then
				local settings_type = self:get_controller_settings_type(controller)

				self:_update_indices(controller, cloned[settings_type])
			else
				self:_update_indices(controller, cloned)
			end

			controllers[self:get_controller_type(controller)] = controller
		end
	end

	input_source:apply_mapping(controllers, cloned, global_mapping ~= nil)
end

function InputManager:get_input_keyname(slot, output)
	for _, mapping in pairs(self._mapped_input_sources) do
		for binding_name, mapping_info in pairs(mapping.mapping_table) do
			if binding_name == output then
				return mapping_info.key
			end
		end
	end

	return ""
end

function InputManager:get_controller_type(controller)
	if controller == Mouse then
		return "mouse"
	elseif controller == Keyboard then
		return "keyboard"
	elseif controller == Pad1 or controller == Pad2 or controller == Pad3 or controller == Pad4 then
		return "pad"
	end

	ferror("error")

	return "unknown"
end

function InputManager:get_controller_settings_type(controller)
	if controller == Mouse or controller == Keyboard then
		return "keyboard_mouse"
	elseif controller == Pad1 or controller == Pad2 or controller == Pad3 or controller == Pad4 or controller == Pad5 or controller == Pad6 or controller == Pad7 then
		if Application.platform() == "ps3" then
			return "padps3"
		else
			return "pad360"
		end
	end
end

function InputManager:get_controller(controller)
	local lut = {
		mouse = Mouse,
		keyboard = Keyboard,
		pad = Pad1,
		pad1 = Pad1,
		pad2 = Pad2,
		pad3 = Pad3,
		pad4 = Pad4
	}

	fassert(lut[controller], "Major fail")

	return lut[controller]
end

function InputManager:_update_indices(controller, mapping)
	local controller_type = self:get_controller_type(controller)

	for key, value in pairs(mapping) do
		if not value.controller_type or value.controller_type == controller_type then
			if value.func == "button" or value.func == "pressed" or value.func == "released" then
				value.index = controller.button_index(value.key)

				fassert(value.index, "There is no key named \"%s\" in %s", value.key, controller_type)

				value.controller = controller
			elseif value.func == "axis" then
				if controller.axis_index(value.key) then
					value.index = controller.axis_index(value.key)
					value.controller = controller
				end
			elseif value.func == "filter" then
				value.filter = InputFilterClasses[value.type]:new(value.input, controller)
			end
		end
	end
end

function InputManager:_update_filters(dt)
	for _, source in ipairs(self._mapped_input_sources) do
		source:update_filters(dt)
	end
end

function InputManager:update(dt)
	self:_update_states(dt)
	self:_update_current_global_input()
	self:_update_filters(dt)
end

function InputManager:_update_states(dt)
	for _, source in ipairs(self._mapped_input_sources) do
		source:update_states(dt)
	end
end

function InputManager:_update_current_global_input()
	for slot_id, _ in pairs(InputManager.default_slot_mapping) do
		local controllers = self:get_slot_controllers(slot_id)

		for _, controller in pairs(controllers) do
			local active_mapping = Managers.input:get_controller_settings_type(controller)

			if controller.any_pressed() and active_mapping ~= self:active_mapping(slot_id) then
				self._active_input_mapping[slot_id] = active_mapping
				InputManager.default_slot_mapping[slot_id] = active_mapping

				break
			end
		end

		self._active_input_mapping[slot_id] = InputManager.default_slot_mapping[slot_id]
	end
end

function InputManager:active_mapping(slot_id)
	return self._active_input_mapping[slot_id] or InputManager.default_slot_mapping[slot_id]
end

function InputManager:pad_active(slot_id)
	return self._active_input_mapping[slot_id] and self._active_input_mapping[slot_id] == (Application.platform() == "win32" and "pad360" or "padps3")
end
