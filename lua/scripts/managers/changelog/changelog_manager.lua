-- chunkname: @scripts/managers/changelog/changelog_manager.lua

require("scripts/managers/changelog/changelog_token")

ChangelogManager = class(ChangelogManager)

local TIMEOUT = 10

function ChangelogManager:init()
	self._loader = UrlLoader()
	self._url = "http://0.0.0.0/head/feeds/wotr-patchnotes/content"
end

function ChangelogManager:get_changelog(callback)
	local job = UrlLoader.load_text(self._loader, self._url)
	local changelog_token = ChangelogToken:new(self._loader, job)
	local timeout_time = Managers.time:time("main") + TIMEOUT

	Managers.token:register_token(changelog_token, callback, timeout_time)
end

function ChangelogManager:update()
	UrlLoader.update(self._loader)
end

function ChangelogManager:destroy()
	UrlLoader.destroy(self._loader)
end
