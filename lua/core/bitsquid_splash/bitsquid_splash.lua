-- chunkname: @core/bitsquid_splash/bitsquid_splash.lua

local ascii_art_lines = {
	"223........ ... 223... ........... ........... ........... ... ........622",
	"222........ ... 222... ........... ........... ........... ... ........222",
	"222........ ... 222... ........... ........... ........... ... ........222",
	"222622223.. 223 222622 ..6222222.. ..6222223.. 223.....223 223 ..622223222",
	"222222222.. 222 222222 ..2222224.. ..2222222.. 222.....222 222 ..222222222",
	"22222222223 222 222222 62222224... 62222222223 222.....222 222 62222222222",
	"222....5222 222 222... 222........ 2224...5222 222.....222 222 2224....222",
	"222.....222 222 222... 2222222223. 222.....222 222.....222 222 222.....222",
	"222.....222 222 222... 52222222223 222.....222 222.....222 222 222.....222",
	"222.....222 222 222... .5222222222 222.....222 222.....222 222 222.....222",
	"2223...6222 222 2223.. ........222 2223....222 2223....222 222 2223...6222",
	"52222222224 222 522222 ..622222224 52222222222 52222222222 222 52222222224",
	"..2222222.. 222 ..2222 .62222222.. ..222222222 ..222222222 222 ..2222222..",
	"..5222224.. 224 ..5222 .22222224.. ..522224222 ..522222224 224 ..5222224..",
	"........... ... ...... ........... ........222 ........... ... ...........",
	"........... ... ...... ........... ........222 ........... ... ...........",
	"........... ... ...... ........... ........522 ........... ... ..........."
}
local texts = {
	"The creative engine.",
	"The flexible engine.",
	"The lightweight engine.",
	"The scalable engine."
}
local resources = {
	font = "core/bitsquid_splash/georgia_partial",
	gui_material = "core/bitsquid_splash/gui",
	camera_unit = "core/units/camera"
}
local colors = {
	black = function()
		return Color(0, 0, 0)
	end,
	white = function()
		return Color(255, 255, 255)
	end,
	burgundy = function()
		return Color(108, 18, 52)
	end,
	teal = function()
		return Color(100, 193, 200)
	end
}

local function partial(func, ...)
	local partial_args = {
		...
	}

	return function(...)
		return func(unpack(partial_args), ...)
	end
end

local function compose(f, g)
	return function(...)
		return g(f(...))
	end
end

local function split(str)
	local words = {}

	string.gsub(str, "([^%s]+)", partial(table.insert, words))

	return words
end

local function map(transform, tbl)
	local result = {}

	for k, v in pairs(tbl) do
		result[k] = transform(v)
	end

	return result
end

local function zip(...)
	local result = {}

	for _, array in ipairs({
		...
	}) do
		for i, element in ipairs(array) do
			result[i] = result[i] or {}

			table.insert(result[i], element)
		end
	end

	return result
end

local function fold(accumulate, init, array)
	local result = init

	for _, element in ipairs(array) do
		result = accumulate(result, element)
	end

	return result
end

local function smoothstep(a, b, t)
	local c = math.max(0, math.min(t, 1))

	return a + c * c * (3 - 2 * c) * (b - a)
end

local function interpolate_color(a, b, t)
	local aa, ar, ag, ab = Quaternion.to_elements(a)
	local ba, br, bg, bb = Quaternion.to_elements(b)
	local da, dr, dg, db = ba - aa, br - ar, bg - ag, bb - ab
	local ra, rr, rg, rb = aa + da * t, ar + dr * t, ag + dg * t, ab + db * t
	local result = Quaternion.from_elements(ra, rr, rg, rb)

	return result
end

local function logo_tiles()
	local tl = {
		-0.5,
		0.5
	}
	local bl = {
		-0.5,
		-0.5
	}
	local br = {
		0.5,
		-0.5
	}
	local tr = {
		0.5,
		0.5
	}
	local p1 = {}
	local p2 = {
		tl,
		bl,
		br,
		br,
		tr,
		tl
	}
	local p3 = {
		tl,
		br,
		bl
	}
	local p4 = {
		tl,
		bl,
		tr
	}
	local p5 = {
		tl,
		br,
		tr
	}
	local p6 = {
		br,
		bl,
		tr
	}

	return {
		p1,
		p2,
		p3,
		p4,
		p5,
		p6
	}
end

local function logo_tiles_high_quality()
	local cp = {
		0,
		0
	}
	local tl = {
		-0.5,
		0.5
	}
	local bl = {
		-0.5,
		-0.5
	}
	local br = {
		0.5,
		-0.5
	}
	local tr = {
		0.5,
		0.5
	}
	local p1 = {}
	local p2 = {
		tl,
		bl,
		cp,
		bl,
		br,
		cp,
		br,
		tr,
		cp,
		tr,
		tl,
		cp
	}
	local p3 = {
		tl,
		bl,
		cp,
		bl,
		br,
		cp
	}
	local p4 = {
		tl,
		bl,
		cp,
		tr,
		tl,
		cp
	}
	local p5 = {
		tr,
		tl,
		cp,
		br,
		tr,
		cp
	}
	local p6 = {
		bl,
		br,
		cp,
		br,
		tr,
		cp
	}

	return {
		p1,
		p2,
		p3,
		p4,
		p5,
		p6
	}
end

local function logo_tile_index(char)
	return char == "." and 1 or tonumber(char)
end

local function logo_tile_indices(letter_row)
	local row_tile_indices = {}
	local append_tile_index = compose(logo_tile_index, partial(table.insert, row_tile_indices))

	string.gsub(letter_row, "(.)", append_tile_index)

	return row_tile_indices
end

local function logo_letters()
	local lines = map(split, ascii_art_lines)
	local letters = zip(unpack(lines))
	local tile_indices = map(partial(map, logo_tile_indices), letters)

	return tile_indices
end

local function create_logo_triangles(height, high_quality)
	local tiles = high_quality and logo_tiles_high_quality() or logo_tiles()
	local letters = logo_letters()
	local tile_size = height / #letters[1]
	local letter_spacing = 0.5 * tile_size

	local function letter_width(letter)
		return #letter[1] * tile_size
	end

	local function sum_letter_width(result, letter)
		return result + letter_width(letter) + letter_spacing
	end

	local width = fold(sum_letter_width, -letter_spacing, letters)
	local letter_x_offset = -width / 2 + 0.5 * tile_size
	local letter_y_offset = height / 2 + 0.5 * tile_size
	local flat_point_triplets = {}

	for _, letter in ipairs(letters) do
		for row_index = 1, #letter do
			local row = letter[row_index]

			for col_index = 1, #row do
				local tile_index = row[col_index]
				local tile = tiles[tile_index]

				for _, point in ipairs(tile) do
					local x = point[1] * tile_size + (col_index - 1) * tile_size + letter_x_offset
					local z = point[2] * tile_size - (row_index - 1) * tile_size + letter_y_offset

					table.insert(flat_point_triplets, Vector3Box(x, 0, z))
				end
			end
		end

		letter_x_offset = letter_x_offset + letter_width(letter) + letter_spacing
	end

	return flat_point_triplets
end

local function create_camera(world)
	local camera_unit = World.spawn_unit(world, resources.camera_unit)
	local camera = Unit.camera(camera_unit, "camera")

	Camera.set_local_position(camera, camera_unit, Vector3(0, -1, 0))
	Camera.set_near_range(camera, 0.01)
	Camera.set_far_range(camera, 10)

	return camera_unit, camera
end

local function screen_length_at_position(camera, position, vector)
	local a = Camera.world_to_screen(camera, position)
	local b = Camera.world_to_screen(camera, position + vector)
	local screen_length = Vector3.distance(a, b)

	return screen_length
end

local function screen_to_world_size_factor(camera, position)
	local camera_right_vector = Matrix4x4.x(Camera.world_pose(camera))
	local size_factor = screen_length_at_position(camera, position, camera_right_vector)

	return size_factor
end

local function pick_random_text()
	return texts[Math.random(#texts)]
end

local function draw_background(world_gui, camera, color)
	local origin = Vector3(0, 0, 0)
	local size = Vector2(10, 10)
	local pose_at_origin = Camera.local_pose(camera)

	Matrix4x4.set_translation(pose_at_origin, origin)
	Gui.bitmap_3d(world_gui, "depth_test_disabled", pose_at_origin, origin - size / 2, 0, size, color)
end

local function draw_text(world_gui, camera, logo_height, text, foreground_color, background_color, time)
	assert(Gui.has_all_glyphs(world_gui, text, resources.font))

	local t = smoothstep(0, 1, (time - 0.8) / 0.4) - smoothstep(0, 1, (time - 3.5) / 0.5)

	if t == 0 then
		return
	end

	local pose = Matrix4x4.identity()
	local font_size = logo_height / 3
	local min, max = Gui.text_extents(world_gui, text, resources.font, font_size)
	local extents = Vector2(max.x - min.x, max.y - min.y)
	local offset = Vector3(-extents.x / 2, -logo_height / 2 - extents.y / 2, 0)
	local color = interpolate_color(background_color, foreground_color, t)

	Gui.text_3d(world_gui, text, resources.font, font_size, "georgia_partial", pose, offset, 10, color)
end

local function draw_logo(world_gui, camera, logo_triangles, foreground_color, background_color, time)
	local t = smoothstep(0, 1, time / 1.2)
	local u = smoothstep(0, 1, (time - 3.5) / 0.5)
	local offset = Vector3(0, 0, 0.05 * t)
	local color = interpolate_color(background_color, foreground_color, t - u)

	for i = 1, #logo_triangles, 3 do
		local p1 = logo_triangles[i]:unbox()
		local p2 = logo_triangles[i + 1]:unbox()
		local p3 = logo_triangles[i + 2]:unbox()

		Gui.triangle(world_gui, p1 + offset, p2 + offset, p3 + offset, 20, color)
	end
end

local function animate_camera(camera, camera_unit, time)
	local init_rotation = Quaternion.look(Vector3.normalize(Vector3(1, 0, 0)), Vector3.normalize(Vector3(0, -0.6, 1)))
	local dest_rotation = Quaternion.identity()
	local rotation = Quaternion.lerp(init_rotation, dest_rotation, smoothstep(0, 1, time / 1.2))
	local forward = Quaternion.forward(rotation)
	local pose = Matrix4x4.from_quaternion_position(rotation, forward * smoothstep(-0.01, -1, time / 1.2))

	Camera.set_local_pose(camera, camera_unit, pose)
end

local function animate_gui(world_gui, time)
	local y_scale = smoothstep(1, 0, time / 1.1)
	local pose = Matrix4x4.identity()

	Matrix4x4.set_scale(pose, Vector3(1, y_scale, 1))
	Gui.move(world_gui, pose)
end

local function randomize_y_coords(logo_triangles)
	local seed, height = Math.next_random(123456)

	for i = 1, #logo_triangles, 3 do
		seed, height = Math.next_random(seed)

		local y_coord = height

		logo_triangles[i].y = y_coord
		logo_triangles[i + 1].y = y_coord
		logo_triangles[i + 2].y = y_coord
	end

	return logo_triangles
end

BitsquidSplash = BitsquidSplash or {}
BitsquidSplash.Colors = colors

function BitsquidSplash.create(viewport_template_name, shading_environment_name, high_quality, foreground_color, background_color)
	if high_quality == nil then
		high_quality = true
	end

	foreground_color = foreground_color or colors.white()
	background_color = background_color or colors.black()

	local world = Application.new_world(Application.DISABLE_SOUND, Application.DISABLE_PHYSICS)
	local viewport = Application.create_viewport(world, viewport_template_name)
	local shading_environment = World.create_shading_environment(world, shading_environment_name)
	local camera_unit, camera = create_camera(world)
	local world_gui = World.create_world_gui(world, Matrix4x4.identity(), 1, 1, "immediate", "material", resources.gui_material)
	local size_factor = screen_to_world_size_factor(camera, Vector3(0, 1, 0))
	local logo_height = 234 / size_factor
	local splash = {
		time = 0,
		world = world,
		viewport = viewport,
		shading_environment = shading_environment,
		camera_unit = camera_unit,
		camera = camera,
		world_gui = world_gui,
		logo_height = logo_height,
		logo_triangles = randomize_y_coords(create_logo_triangles(logo_height, high_quality)),
		text = pick_random_text(),
		foreground_color = QuaternionBox(foreground_color),
		background_color = QuaternionBox(background_color)
	}

	return splash
end

function BitsquidSplash.destroy(splash)
	Application.destroy_viewport(splash.world, splash.viewport)
	Application.release_world(splash.world)
end

function BitsquidSplash.update(splash, delta_time)
	animate_camera(splash.camera, splash.camera_unit, splash.time)
	animate_gui(splash.world_gui, splash.time)
	World.update_animations(splash.world, delta_time)

	local foreground_color = splash.foreground_color:unbox()
	local background_color = splash.background_color:unbox()

	draw_background(splash.world_gui, splash.camera, background_color)
	draw_logo(splash.world_gui, splash.camera, splash.logo_triangles, foreground_color, background_color, splash.time)
	draw_text(splash.world_gui, splash.camera, splash.logo_height, splash.text, foreground_color, background_color, splash.time)
	World.update_scene(splash.world, delta_time)

	splash.time = splash.time + delta_time

	local is_done = splash.time > 4

	return is_done
end

function BitsquidSplash.render(splash)
	ShadingEnvironment.blend(splash.shading_environment, {
		"default",
		1
	})
	ShadingEnvironment.apply(splash.shading_environment)
	Application.render_world(splash.world, splash.camera, splash.viewport, splash.shading_environment)
end
