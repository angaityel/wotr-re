-- chunkname: @scripts/managers/sale_popup/sale_popup_texture_token.lua

SalePopupTextureToken = SalePopupTextureToken or class()

function SalePopupTextureToken:init(loader, job)
	self._loader = loader
	self._job = job
	self._name = "SalePopupTextureToken"
end

function SalePopupTextureToken:name()
	return self._name
end

function SalePopupTextureToken:info()
	if UrlLoader.success(self._loader, self._job) then
		return UrlLoader.texture(self._loader, self._job)
	else
		return "Failed loading sale popup texture"
	end
end

function SalePopupTextureToken:update()
	return
end

function SalePopupTextureToken:done()
	return UrlLoader.done(self._loader, self._job)
end

function SalePopupTextureToken:close()
	UrlLoader.unload(self._loader, self._job)
end
