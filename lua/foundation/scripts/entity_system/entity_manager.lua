-- chunkname: @foundation/scripts/entity_system/entity_manager.lua

EntityManager = class(EntityManager)

function EntityManager:init()
	self:_reset()
end

function EntityManager:_reset()
	self._units = {}
	self._delete_units = {}
	self._extensions = {}
	self._systems = {}
	self._system_order = {}
	self._extension_to_system_map = {}
end

function EntityManager:register_system(system, system_name)
	self._systems[system_name] = system
	system.NAME = system_name
	self._system_order[#self._system_order + 1] = system_name
end

function EntityManager:system(system_name)
	return self._systems[system_name]
end

function EntityManager:system_by_extension(extension_name)
	local system_name = self._extension_to_system_map[extension_name]

	return system_name and self._systems[system_name] or nil
end

function EntityManager:register_units(world, unit_list)
	for _, unit in ipairs(unit_list) do
		self:register_unit(world, unit)
	end
end

function EntityManager:register_unit(world, unit, ...)
	local extensions = ScriptUnit.extension_definitions(unit)

	for _, extension_name in ipairs(extensions) do
		local extension_class = rawget(_G, extension_name)

		fassert(extension_class, "No extension found with name %q while registering unit %s", extension_name, unit)

		local extension_system_name = extension_class.SYSTEM

		fassert(extension_class.SYSTEM, "System name not set for extension %q", extension_name)

		if (not extension_class.SERVER_ONLY or Managers.lobby.server) and (not extension_class.CLIENT_ONLY or Managers.lobby.lobby and not Managers.lobby.server) and (not extension_class.OFFLINE_ONLY or not Managers.lobby.lobby) and (not extension_class.OFFLINE_AND_SERVER_ONLY or not Managers.lobby.lobby or Managers.lobby.server) then
			self:_add_extension(world, unit, extension_name, extension_class, extension_system_name, ...)
		end
	end

	Unit.flow_event(unit, "unit_registered")
end

function EntityManager:unregister_unit(unit)
	local extensions = ScriptUnit.extension_definitions(unit)
	local extension_table = self._units[unit]

	for index = #extensions, 1, -1 do
		local extension_name = extensions[index]

		if extension_table[extension_name] then
			self:_remove_extension(unit, extension_name)
		end

		extension_table[extension_name] = nil
	end

	self._units[unit] = nil
end

function EntityManager:is_unit_registered(unit)
	return self._units[unit] and true or false
end

function EntityManager:remove_unit(unit)
	print("WARNING! Managers.state.entity:remove_unit( unit ) is depcrecated, use Managers.state.entity:unregister_unit( unit ) instead!")
	print(Script.callstack())
	self:unregister_unit(unit)
end

function EntityManager:get_entities(extension_name)
	local entity_list = self._extensions[extension_name] or {}

	return entity_list
end

function EntityManager:_add_extension(world, u, extension_name, extension_class, extension_system_name, ...)
	self._extensions[extension_name] = self._extensions[extension_name] or {}
	self._units[u] = self._units[u] or {}
	self._extensions[extension_name][u] = true
	self._units[u][extension_name] = true

	fassert(not self._extension_to_system_map[extension_name] or self._extension_to_system_map[extension_name] == extension_system_name, "[EntityManager:_add_extension()] Trying to add extension %q to %q when it already exists in %q ", extension_name, extension_system_name, self._extension_to_system_map[extension_name])

	self._extension_to_system_map[extension_name] = extension_system_name

	local system = self._systems[extension_system_name]

	fassert(system ~= nil, "[EntityManager:_add_extension()] Adding extension %q no system is registered.", extension_name)
	system:on_add_extension(world, u, extension_name, extension_class, ...)
end

function EntityManager:_remove_extension(u, extension_name)
	local system = self:system_by_extension(extension_name)

	if system and system.on_remove_extension then
		system:on_remove_extension(u, extension_name)
	end

	self._extensions[extension_name][u] = nil
end

function EntityManager:freeze_extension(unit, system_name)
	local system = self._systems[system_name]

	system:on_freeze_extension(unit)
	fassert(system, "[EntityManager:freeze_extension] No system named %q in unit %q", system_name, unit)
end

function EntityManager:unfreeze_extension(unit, system_name)
	local system = self._systems[system_name]

	fassert(system, "[EntityManager:freeze_extension] No system named %q in unit %q", system_name, unit)
	system:on_unfreeze_extension(unit)
end

function EntityManager:destroy()
	for unit, extensions in pairs(self._units) do
		self:unregister_unit(unit)
	end
end
