-- chunkname: @scripts/unit_extensions/objectives/flag_capture_point_offline.lua

FlagCapturePointOffline = class(FlagCapturePointOffline, FlagCapturePointServer)

local DROPPED_FLAG_LIFETIME = 5
local CAPTURE_POINT_FLAG_HEALTH = 1

FlagCapturePointOffline.SERVER_ONLY = false
FlagCapturePointOffline.OFFLINE_ONLY = true

function FlagCapturePointOffline:event_round_started(params)
	return
end
