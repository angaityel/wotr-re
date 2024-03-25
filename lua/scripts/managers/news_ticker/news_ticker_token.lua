-- chunkname: @scripts/managers/news_ticker/news_ticker_token.lua

NewsTickerToken = NewsTickerToken or class()

function NewsTickerToken:init(loader, job)
	self._loader = loader
	self._job = job
	self._name = "NewsTickerToken"
end

function NewsTickerToken:name()
	return self._name
end

function NewsTickerToken:info()
	local info = {}

	if self:done() and UrlLoader.success(self._loader, self._job) then
		info.body = UrlLoader.text(self._loader, self._job)
	else
		info.body = ""
		info.error = "Failed loading news ticker"
	end

	return info
end

function NewsTickerToken:update()
	return
end

function NewsTickerToken:done()
	return UrlLoader.done(self._loader, self._job)
end

function NewsTickerToken:close()
	UrlLoader.unload(self._loader, self._job)
end
