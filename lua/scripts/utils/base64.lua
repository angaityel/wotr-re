-- chunkname: @scripts/utils/base64.lua

local function lsh(value, shift)
	return math.mod(value * 2^shift, 256)
end

local function rsh(value, shift)
	return math.mod(math.floor(value / 2^shift), 256)
end

local function bit(x, b)
	return math.mod(x, 2^b) - math.mod(x, 2^(b - 1)) > 0
end

local function lor(x, y)
	local result = 0

	for p = 1, 8 do
		result = result + ((bit(x, p) or bit(y, p)) == true and 2^(p - 1) or 0)
	end

	return result
end

local base64chars = {
	[0] = "A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"-",
	"_"
}

function base64_encode(data)
	local bytes = {}
	local result = ""

	for spos = 0, string.len(data) - 1, 3 do
		for byte = 1, 3 do
			bytes[byte] = string.byte(string.sub(data, spos + byte)) or 0
		end

		result = string.format("%s%s%s%s%s", result, base64chars[rsh(bytes[1], 2)], base64chars[lor(lsh(math.mod(bytes[1], 4), 4), rsh(bytes[2], 4))] or "=", string.len(data) - spos > 1 and base64chars[lor(lsh(math.mod(bytes[2], 16), 2), rsh(bytes[3], 6))] or "=", string.len(data) - spos > 2 and base64chars[math.mod(bytes[3], 64)] or "=")
	end

	return result
end

local base64bytes = {
	p = 41,
	G = 6,
	f = 31,
	["2"] = 54,
	q = 42,
	["3"] = 55,
	o = 40,
	O = 14,
	P = 15,
	i = 34,
	U = 20,
	n = 39,
	Q = 16,
	["1"] = 53,
	m = 38,
	u = 46,
	["0"] = 52,
	l = 37,
	a = 26,
	["7"] = 59,
	j = 35,
	M = 12,
	k = 36,
	L = 11,
	J = 9,
	["-"] = 62,
	K = 10,
	h = 33,
	F = 5,
	I = 8,
	g = 32,
	H = 7,
	e = 30,
	d = 29,
	b = 27,
	E = 4,
	c = 28,
	D = 3,
	B = 1,
	C = 2,
	A = 0,
	_ = 63,
	z = 51,
	Z = 25,
	v = 47,
	y = 50,
	x = 49,
	V = 21,
	Y = 24,
	w = 48,
	X = 23,
	["6"] = 58,
	["9"] = 61,
	W = 22,
	["8"] = 60,
	t = 45,
	r = 43,
	N = 13,
	s = 44,
	T = 19,
	R = 17,
	["5"] = 57,
	S = 18,
	["4"] = 56
}

function base64_decode(data)
	local chars = {}
	local result = ""

	for dpos = 0, string.len(data) - 1, 4 do
		for char = 1, 4 do
			chars[char] = base64bytes[string.sub(data, dpos + char, dpos + char) or "="]
		end

		result = string.format("%s%s%s%s", result, string.char(lor(lsh(chars[1], 2), rsh(chars[2], 4))), chars[3] ~= nil and string.char(lor(lsh(chars[2], 4), rsh(chars[3], 2))) or "", chars[4] ~= nil and string.char(lor(math.mod(lsh(chars[3], 6), 192), chars[4])) or "")
	end

	return result
end
