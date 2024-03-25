-- chunkname: @foundation/scripts/util/script_viewport.lua

ScriptViewport = ScriptViewport or {}

function ScriptViewport.active(viewport)
	return Viewport.get_data(viewport, "active")
end

function ScriptViewport.camera(viewport)
	return Viewport.get_data(viewport, "camera")
end
