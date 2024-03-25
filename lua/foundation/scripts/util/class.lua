-- chunkname: @foundation/scripts/util/class.lua

function class(class_table, ...)
	local super = ...

	if select("#", ...) >= 1 and super == nil then
		ferror("Trying to inherit from nil")
	end

	if not class_table then
		class_table = {
			super = super
		}
		class_table.__index = class_table

		function class_table:new(...)
			local object = {}

			setmetatable(object, class_table)

			if object.init then
				object:init(...)
			end

			return object
		end
	end

	if super then
		for k, v in pairs(super) do
			if k ~= "__index" and k ~= "new" and k ~= "super" then
				class_table[k] = v
			end
		end
	end

	return class_table
end
