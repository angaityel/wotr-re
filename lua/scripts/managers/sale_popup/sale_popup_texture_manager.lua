-- chunkname: @scripts/managers/sale_popup/sale_popup_texture_manager.lua

require("scripts/managers/sale_popup/sale_popup_texture_token")

SalePopupTextureManager = SalePopupTextureManager or class()

local TIMEOUT = 30

function SalePopupTextureManager:init()
	self._loader = UrlLoader()
	self._url = nil
end

function SalePopupTextureManager:get_texture(url, callback)
	local job = UrlLoader.load_texture(self._loader, url, "sale_popup", 1024, 1024)
	local sale_token = SalePopupTextureToken:new(self._loader, job)
	local timeout_time = Managers.time:time("main") + TIMEOUT

	Managers.token:register_token(sale_token, callback, timeout_time)
end

function SalePopupTextureManager:update()
	UrlLoader.update(self._loader)
end

function SalePopupTextureManager:destroy()
	UrlLoader.destroy(self._loader)
end
