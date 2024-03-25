-- chunkname: @foundation/scripts/util/patches.lua

local meta = {
	__newindex = function(t, k, v)
		if rawget(t, k) == nil then
			local info = debug.getinfo(2, "S")

			if k ~= "to_console_line" and info and info.what ~= "main" and info.what ~= "C" then
				ferror("Cannot assign undeclared global %q", k)
			end
		end

		rawset(t, k, v)
	end,
	__index = function(t, k)
		local info = debug.getinfo(2, "S")

		if k ~= "to_console_line" and info and info.what ~= "main" and info.what ~= "C" then
			ferror("Cannot access undeclared global %q", k)
		end
	end
}

setmetatable(_G, meta)
