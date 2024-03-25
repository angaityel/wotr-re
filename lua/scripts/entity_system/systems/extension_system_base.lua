-- chunkname: @scripts/entity_system/systems/extension_system_base.lua

ExtensionSystemBase = class(ExtensionSystemBase)

function ExtensionSystemBase:init(context, system_name)
	local em = context.entity_manager

	em:register_system(self, system_name)

	self.entity_manager = em
	self._extensions = {}
	self._prioritized_extensions = self._prioritized_extensions or {}
end

function ExtensionSystemBase:get_entities()
	local entities = {}

	for extension_name, _ in pairs(self._extensions) do
		entities[extension_name] = entities[extension_name] or {}
		entities[extension_name] = self.entity_manager:get_entities(extension_name)
	end

	return entities
end

function ExtensionSystemBase:on_add_extension(world, unit, extension_name, extension_class, ...)
	if script_data.extension_debug then
		print(string.format("%s:on_add_component(unit, %s)", self.NAME, extension_name))
	end

	ScriptUnit.add_extension(world, unit, extension_name, ...)

	if not table.contains(self._prioritized_extensions, extension_name) then
		self._extensions[extension_name] = (self._extensions[extension_name] or 0) + 1
	end
end

function ExtensionSystemBase:on_remove_extension(unit, extension_name)
	fassert(ScriptUnit.has_extension(unit, self.NAME), "Trying to remove non-existing extension %q from unit %s", extension_name, unit)
	ScriptUnit.remove_extension(unit, self.NAME)

	if not table.contains(self._prioritized_extensions, extension_name) then
		self._extensions[extension_name] = self._extensions[extension_name] - 1

		if self._extensions[extension_name] <= 0 then
			self._extensions[extension_name] = nil
		end
	end
end

function ExtensionSystemBase:update(context, t)
	local dt = context.dt

	for _, extension_name in ipairs(self._prioritized_extensions) do
		self:update_extension(extension_name, dt, context, t)
	end

	for extension_name, _ in pairs(self._extensions) do
		self:update_extension(extension_name, dt, context, t)
	end
end

function ExtensionSystemBase:post_update(context, t)
	local dt = context.dt

	for _, extension_name in ipairs(self._prioritized_extensions) do
		self:post_update_extension(extension_name, dt, context, t)
	end

	for extension_name, _ in pairs(self._extensions) do
		self:post_update_extension(extension_name, dt, context, t)
	end
end

function ExtensionSystemBase:update_extension(extension_name, dt, context, t)
	local entities = self.entity_manager:get_entities(extension_name)

	for unit, _ in pairs(entities) do
		local input = ScriptUnit.extension_input(unit, self.NAME)
		local internal = ScriptUnit.extension(unit, self.NAME)

		assert(internal, extension_name)
		internal:update(unit, input, dt, context, t)
	end
end

function ExtensionSystemBase:post_update_extension(extension_name, dt, context, t)
	local entities = self.entity_manager:get_entities(extension_name)

	for unit, _ in pairs(entities) do
		local input = ScriptUnit.extension_input(unit, self.NAME)
		local internal = ScriptUnit.extension(unit, self.NAME)

		assert(internal, extension_name)

		if internal.post_update then
			internal:post_update(unit, input, dt, context, t)
		end
	end
end

function ExtensionSystemBase:hot_join_synch(sender, player)
	for _, extension_name in pairs(self._prioritized_extensions) do
		self:_hot_join_synch_extension(extension_name, sender, player)
	end

	for extension_name, _ in pairs(self._extensions) do
		self:_hot_join_synch_extension(extension_name, sender, player)
	end
end

function ExtensionSystemBase:_hot_join_synch_extension(extension_name, sender, player)
	local entities = self.entity_manager:get_entities(extension_name)

	for unit, _ in pairs(entities) do
		local input = ScriptUnit.extension_input(unit, self.NAME)
		local internal = ScriptUnit.extension(unit, self.NAME)

		if internal.hot_join_synch then
			internal:hot_join_synch(sender, player)
		end
	end
end

function ExtensionSystemBase:destroy()
	return
end
