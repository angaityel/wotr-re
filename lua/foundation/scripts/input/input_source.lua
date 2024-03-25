-- chunkname: @foundation/scripts/input/input_source.lua

InputSource = class(InputSource)

function InputSource:init(slot, mapping_template)
	self.slot = slot
	self.mapping_template = mapping_template
	self.updating_filters = {}
	self.states = {}
	self.state_keys = {}
end

function InputSource:apply_mapping(controllers, mapping, global_mapping)
	self.controllers = controllers
	self.mapping_table = mapping
	self.global_mapping = global_mapping

	if self.global_mapping then
		for mapping_type, mapping_table in pairs(mapping) do
			if type(mapping_table) == "table" then
				for key, input_desc in pairs(mapping_table) do
					if input_desc.func == "filter" and input_desc.filter and input_desc.filter.update then
						self.updating_filters[#self.updating_filters + 1] = input_desc.filter
					end

					if input_desc.set_state then
						self:register_state_key(key, false)
					end
				end
			end
		end
	else
		for key, input_desc in pairs(mapping) do
			if input_desc.func == "filter" and input_desc.filter and input_desc.filter.update then
				self.updating_filters[#self.updating_filters + 1] = input_desc.filter
			end

			if input_desc.set_state then
				self:register_state_key(key, false)
			end
		end
	end
end

function InputSource:clear()
	self.controllers = nil
	self.mapping_table = nil
	self.updating_filters = {}
	self.states = {}
end

function InputSource:has(name)
	fassert(self.mapping_table, "Trying to access unmapped input source.")

	if self.global_mapping then
		local active_mapping = Managers.input:active_mapping(self.slot)

		return self.mapping_table[active_mapping][name] and true
	else
		return self.mapping_table[name] and true
	end
end

function InputSource:set_state(name, value)
	self.states[name] = value
end

function InputSource:register_state_key(key, value)
	self.state_keys[key] = value
end

function InputSource:get(name)
	fassert(self.mapping_table, "Trying to access unmapped input source.")

	if self.global_mapping then
		local active_mapping = Managers.input:active_mapping(self.slot)
		local input_desc = self.mapping_table[active_mapping] and self.mapping_table[active_mapping][name]

		if input_desc then
			local controller = self.controllers[input_desc.controller_type]

			fassert(controller, "No controller of type %q", input_desc.controller_type)
			fassert(input_desc.func, "No input_desc.func")

			if input_desc.state and not self.states[input_desc.state] then
				return input_desc.func == "button" and 0 or false
			elseif input_desc.state_blocked and self.states[input_desc.state_blocked] then
				return input_desc.func == "button" and 0 or false
			end

			if input_desc.func == "filter" then
				return input_desc.filter:evaluate(self)
			else
				local result = controller[input_desc.func] and input_desc.index and controller[input_desc.func](input_desc.index)

				if input_desc.set_state then
					if type(result) == "boolean" then
						self.states[input_desc.set_state] = result
					else
						self.states[input_desc.set_state] = result > 0
					end
				end

				return result
			end
		end
	else
		local input_desc = self.mapping_table[name]

		fassert(input_desc, "No input description for %q", name)

		local controller = self.controllers[input_desc.controller_type]

		fassert(controller, "No controller of type %q", input_desc.controller_type)
		fassert(input_desc.func, "No input_desc.func")

		if input_desc.state and not self.states[input_desc.state] then
			return input_desc.func == "button" and 0 or false
		elseif input_desc.state_blocked and self.states[input_desc.state_blocked] then
			return input_desc.func == "button" and 0 or false
		end

		if input_desc.func == "filter" then
			return input_desc.filter:evaluate(self)
		else
			local result = controller[input_desc.func](input_desc.index)

			if input_desc.set_state then
				if type(result) == "boolean" then
					self.states[input_desc.set_state] = result
				else
					self.states[input_desc.set_state] = result > 0
				end
			end

			return result
		end
	end
end

function InputSource:update_filters(dt)
	for i = 1, #self.updating_filters do
		local input_filter = self.updating_filters[i]

		input_filter:update(self, dt)
	end
end

function InputSource:update_states(dt)
	for name, _ in pairs(self.state_keys) do
		self:get(name)
	end
end
