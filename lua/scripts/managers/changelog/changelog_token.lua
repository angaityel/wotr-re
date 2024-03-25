-- chunkname: @scripts/managers/changelog/changelog_token.lua

ChangelogToken = class(ChangelogToken)

function ChangelogToken:init(loader, job)
	self._loader = loader
	self._job = job
	self._name = "ChangelogToken"
end

function ChangelogToken:name()
	return self._name
end

function ChangelogToken:info()
	local info = {}

	if self:done() and UrlLoader.success(self._loader, self._job) then
		info.body = UrlLoader.text(self._loader, self._job)
	else
		info.body = ""
		info.error = "Failed loading changelog"
	end

	return info
end

function ChangelogToken:update()
	return
end

function ChangelogToken:done()
	return UrlLoader.done(self._loader, self._job)
end

function ChangelogToken:close()
	UrlLoader.unload(self._loader, self._job)
end
