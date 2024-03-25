-- chunkname: @foundation/scripts/managers/package/package_manager.lua

PackageManager = PackageManager or {}

function PackageManager:init()
	self._packages = {}
	self._asynch_packages = {}
end

function PackageManager:load(package_name, callback)
	assert(self._packages[package_name] == nil, "Package '" .. tostring(package_name) .. "' is already loaded")
	assert(self._asynch_packages[package_name] == nil, "Package '" .. tostring(package_name) .. "' is already being loaded")

	local resource_handle = Application.resource_package(package_name)

	ResourcePackage.load(resource_handle)

	if callback then
		self._asynch_packages[package_name] = {
			handle = resource_handle,
			callback = callback
		}
	else
		Profiler.start(string.format("PackageManager:load(%q)", package_name))
		ResourcePackage.flush(resource_handle)

		self._packages[package_name] = resource_handle

		Profiler.stop()
	end
end

function PackageManager:load_multiple(package_list, callback)
	if callback then
		local config = table.clone(package_list)

		for key, package_name in pairs(package_list) do
			local function cb()
				config[key] = nil

				if table.is_empty(config) then
					callback()
				end
			end

			self:load(package_name, cb)
		end
	else
		for _, package_name in pairs(package_list) do
			self:load(package_name)
		end
	end
end

function PackageManager:unload(package_name)
	local resource_handle

	if self._asynch_packages[package_name] then
		resource_handle = self._asynch_packages[package_name].handle
		self._asynch_packages[package_name] = nil
	else
		resource_handle = self._packages[package_name]
		self._packages[package_name] = nil
	end

	assert(resource_handle, "Package '" .. tostring(package_name) .. "' is not loaded")
	ResourcePackage.unload(resource_handle)
	Application.release_resource_package(resource_handle)
end

function PackageManager:destroy()
	for package_name, _ in pairs(self._packages) do
		self:unload(package_name)
	end
end

function PackageManager:has_loaded(package)
	return self._packages[package] ~= nil
end

function PackageManager:update()
	for package_name, package in pairs(self._asynch_packages) do
		local resource_handle = package.handle

		if ResourcePackage.has_loaded(resource_handle) then
			ResourcePackage.flush(resource_handle)

			self._packages[package_name] = resource_handle
			self._asynch_packages[package_name] = nil

			package.callback()

			break
		end
	end
end
