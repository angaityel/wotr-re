-- chunkname: @core/editor_slave/level_editor/boot.lua

function level_editor_require(...)
	for _, s in ipairs({
		...
	}) do
		require("core/editor_slave/level_editor/" .. s)
	end
end

function boot()
	if Window then
		Window.set_cursor("")
		Window.set_clip_cursor(false)
	end

	Application.set_autoload_enabled(true)
	level_editor_require("tuple", "func", "op", "nilable", "array", "dict", "set", "util", "validation", "math", "lighting", "picking", "scene_element_ref", "align", "object_utils", "physics_simulation", "level_editor", "editor_camera", "grid_plane", "selection", "box_selection", "scatter_manager", "tool", "select_tool", "place_tool", "move_tool", "rotate_tool", "scale_tool", "box_size_tool", "snap_together_tool", "object", "notes", "unit", "level_reference", "group", "marker_tool", "box_objects", "box_tool", "navmesh_tool", "particle_effect", "spline", "move_gizmo", "rotate_gizmo", "scale_gizmo", "scatter_tool", "landscape_tool", "volume_tool", "unit_preview", "static_pvs_tool", "cubemap_generator", "sound")
end

function init()
	boot()
	LevelEditor:init()
end

function shutdown()
	LevelEditor:shutdown()
end

function update(dt)
	LevelEditor:update(dt)
end

function render()
	LevelEditor:render(dt)
end
