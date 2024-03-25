-- chunkname: @scripts/managers/sale_popup/sale_popup_token.lua

SalePopupToken = SalePopupToken or class()

function SalePopupToken:init(loader, job)
	self._loader = loader
	self._job = job
	self._name = "SalePopupToken"
end

function SalePopupToken:name()
	return self._name
end

function SalePopupToken:info()
	local info = {}

	if self:done() and UrlLoader.success(self._loader, self._job) then
		info.body = UrlLoader.text(self._loader, self._job)
	else
		info.body = ""
		info.error = "Failed loading sale popup"
	end

	return info
end

function SalePopupToken:update()
	return
end

function SalePopupToken:done()
	return UrlLoader.done(self._loader, self._job)
end

function SalePopupToken:close()
	UrlLoader.unload(self._loader, self._job)
end
