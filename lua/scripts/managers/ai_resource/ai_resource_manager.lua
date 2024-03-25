-- chunkname: @scripts/managers/ai_resource/ai_resource_manager.lua

AIResourceManager = class(AIResourceManager)

local JOBS_PER_FRAME = 1

function AIResourceManager:init()
	self._jobs = {}
	self._job_index = 1
	self._blackboard = {
		targets = {}
	}
end

function AIResourceManager:update(dt, t)
	local current_job_index = self._job_index
	local job_count = #self._jobs

	if job_count > 0 then
		for i = 1, JOBS_PER_FRAME do
			self._jobs[current_job_index % job_count + 1]()

			self._job_index = (current_job_index + 1) % job_count

			if self._job_index == current_job_index then
				break
			end
		end
	end

	table.clear(self._jobs)
	table.clear(self._blackboard.targets)
end

function AIResourceManager:add_job(func)
	self._jobs[#self._jobs + 1] = func
end

function AIResourceManager:blackboard(key)
	return key and self._blackboard[key] or self._blackboard
end
