-- chunkname: @scripts/utils/util.lua

function cprint(...)
	print(...)
	CommandWindow.print(...)
end

function cprintf(f, ...)
	local s = sprintf(f, ...)

	print(s)
	CommandWindow.print(s)
end

function string.split(str, sep)
	local fields = {}
	local pattern = string.format("([^%s]+)", sep or " ")

	str:gsub(pattern, function(part)
		fields[#fields + 1] = part
	end)

	return fields
end
