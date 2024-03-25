-- chunkname: @foundation/scripts/util/table.lua

function table.is_empty(t)
	return next(t) == nil
end

function table.size(t)
	local elements = 0

	for _ in pairs(t) do
		elements = elements + 1
	end

	return elements
end

function table.clone(t)
	local clone = {}

	for key, value in pairs(t) do
		if type(value) == "table" then
			clone[key] = table.clone(value)
		else
			clone[key] = value
		end
	end

	return clone
end

function table.clone_instance(t)
	local clone = table.clone(t)

	setmetatable(clone, getmetatable(t))

	return clone
end

function table.merge(dest, source)
	for key, value in pairs(source) do
		dest[key] = value
	end
end

function table.append(dest, source)
	for i = 1, #source do
		dest[#dest + 1] = source[i]
	end
end

function table.contains(t, element)
	for _, value in pairs(t) do
		if value == element then
			return true
		end
	end

	return false
end

function table.find(t, element)
	for key, value in pairs(t) do
		if value == element then
			return key
		end
	end

	return false
end

function table.reverse(t)
	local size = #t

	for i = 1, math.floor(size / 2) do
		t[i], t[size - i + 1] = t[size - i + 1], t[i]
	end
end

function table.clear(t)
	for key, _ in pairs(t) do
		t[key] = nil
	end
end

local function table_dump(key, value, depth, max_depth, print_func)
	if max_depth < depth then
		return
	end

	local prefix = string.rep("  ", depth) .. (key == nil and "" or "[" .. tostring(key) .. "]")

	if type(value) == "table" then
		prefix = prefix .. (key == nil and "" or " = ")

		print_func(prefix .. "table")

		if max_depth then
			for key, value in pairs(value) do
				table_dump(key, value, depth + 1, max_depth, print_func)
			end
		end

		local meta = getmetatable(value)

		if meta then
			print(prefix .. "metatable")

			if max_depth then
				for key, value in pairs(meta) do
					if key ~= "__index" and key ~= "super" then
						table_dump(key, value, depth + 1, max_depth, print_func)
					end
				end
			end
		end
	elseif type(value) == "function" or type(value) == "thread" or type(value) == "userdata" or value == nil then
		print_func(prefix .. " = " .. tostring(value))
	else
		print_func(prefix .. " = " .. tostring(value) .. " (" .. type(value) .. ")")
	end
end

function table.dump(t, tag, max_depth, print_func)
	print_func = print_func or printf

	if tag then
		print_func("<%s>", tag)
	end

	for key, value in pairs(t) do
		table_dump(key, value, 0, max_depth or 0, print_func)
	end

	if tag then
		print_func("</%s>", tag)
	end
end

function table.shuffle(source)
	for ii = #source, 2, -1 do
		local swap = Math.random(ii)

		source[swap], source[ii] = source[ii], source[swap]
	end
end

function table.max(t)
	local max_key, max_value = next(t)

	for key, value in pairs(t) do
		if max_value < value then
			max_key, max_value = key, value
		end
	end

	return max_key, max_value
end

function table.for_each(t, f)
	for key, value in pairs(t) do
		t[key] = f(value)
	end
end

function _add_tabs(str, tabs)
	for i = 1, tabs do
		str = str .. "\t"
	end

	return str
end

function table.tostring(t, tabs)
	tabs = tabs or 0

	local str = "{\n"

	for key, value in ipairs(t) do
		str = _add_tabs(str, tabs + 1)

		local value_type = type(value)

		if value_type == "table" then
			str = str .. table.tostring(value, tabs + 1) .. ",\n"
		elseif value_type == "string" then
			str = str .. "\"" .. value .. "\",\n"
		else
			str = str .. tostring(value) .. ",\n"
		end
	end

	for key, value in pairs(t) do
		if type(key) ~= "number" then
			str = _add_tabs(str, tabs + 1)

			local value_type = type(value)

			if value_type == "table" then
				str = str .. key .. "=" .. table.tostring(value, tabs + 1) .. ",\n"
			elseif value_type == "string" then
				str = str .. key .. "=" .. "\"" .. value .. "\",\n"
			else
				str = str .. key .. "=" .. tostring(value) .. ",\n"
			end
		end
	end

	return _add_tabs(str, tabs) .. "}"
end

function table.set(list)
	local set = {}

	for _, l in ipairs(list) do
		set[l] = true
	end

	return set
end
