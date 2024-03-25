-- chunkname: @scripts/settings/gear_require.lua

require("scripts/settings/gear")

local gear_hashes = {}

local function hash_gear_name(gear_name)
	local hash = Application.make_hash(gear_name)

	hash = string.gsub(hash, "[a-zA-Z]", "")
	hash = tonumber(hash) % 2147483648

	return hash
end

for gear_name, gear in pairs(Gear) do
	if gear.sweep_collision then
		for attack_name, attack in pairs(gear.attacks) do
			local sweep = attack.sweep

			fassert(sweep, "[Gear] Missing sweep definition for attack \"%s\" in gear \"%s\".", attack_name, gear_name)
			fassert(type(sweep.inner_node) == "string", "[Gear] Missing inner_node in sweep for attack \"%s\" in gear \"%s\".", attack_name, gear_name)
			fassert(type(sweep.outer_node) == "string", "[Gear] Missing outer_node in sweep for attack \"%s\" in gear \"%s\".", attack_name, gear_name)
			fassert(type(sweep.width) == "number", "[Gear] Missing width in sweep for attack \"%s\" in gear \"%s\".", attack_name, gear_name)
			fassert(type(sweep.thickness) == "number", "[Gear] Missing thickness in sweep for attack \"%s\" in gear \"%s\".", attack_name, gear_name)
		end
	end

	gear.husk_unit = gear.unit .. "_husk"
	gear.hash = hash_gear_name(gear_name)

	fassert(gear_hashes[gear.hash] == nil, "Hash collision between gear %q and %q", gear_name, gear_hashes[gear.hash])

	gear_hashes[gear.hash] = gear_name

	local attacks = gear.attacks
	local push = attacks.push

	if push then
		push.parry_direction = "down"
	end

	local left = attacks.left

	if left then
		left.parry_direction = "left"
	end

	local right = attacks.right

	if right then
		right.parry_direction = "right"
	end

	local up = attacks.up

	if up then
		up.parry_direction = "up"
	end

	local down = attacks.down

	if down then
		down.parry_direction = "down"
	end

	local shield_bash = attacks.shield_bash

	if shield_bash then
		shield_bash.parry_direction = "down"
	end

	local left_switched = attacks.left_switched

	if left_switched then
		left_switched.parry_direction = "left"
	end

	local right_switched = attacks.right_switched

	if right_switched then
		right_switched.parry_direction = "right"
	end

	local up_switched = attacks.up_switched

	if up_switched then
		up_switched.parry_direction = "up"
	end

	local down_switched = attacks.down_switched

	if down_switched then
		down_switched.parry_direction = "down"
	end
end
