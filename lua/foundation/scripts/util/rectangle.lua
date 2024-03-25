-- chunkname: @foundation/scripts/util/rectangle.lua

Rectangle = class(Rectangle)

function Rectangle:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
end

function Rectangle:split_horizontal()
	local half_height = self.height * 0.5
	local upper_rect = Rectangle:new(self.x, self.y, self.width, half_height)
	local lower_rect = Rectangle:new(self.x, self.y + half_height, self.width, half_height)

	return upper_rect, lower_rect
end

function Rectangle:split_vertical()
	local half_width = self.width * 0.5
	local left_rect = Rectangle:new(self.x, self.y, half_width, self.height)
	local right_rect = Rectangle:new(self.x + half_width, self.y, half_width, self.height)

	return left_rect, right_rect
end
