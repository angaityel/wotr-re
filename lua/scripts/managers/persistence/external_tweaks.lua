-- chunkname: @scripts/managers/persistence/external_tweaks.lua

ExternalTweaks = class(ExternalTweaks)

function ExternalTweaks:init(backend_address)
	cprintf("ExternalTweaks:init")

	local is_test_backend = backend_address:find("fttest") ~= nil

	if is_test_backend then
		self._tweak_profile_id = 3863
	else
		self._tweak_profile_id = 186409
	end
end

function ExternalTweaks:refresh()
	cprintf("Fetching server tweaks...")
	Managers.backend:get_profile_attributes(self._tweak_profile_id, callback(self, "cb_tweaks_fetched"))
end

function ExternalTweaks:cb_tweaks_fetched(response)
	if response.error == nil then
		if response.attributes then
			local tweaks = response.attributes.tweaks

			if tweaks then
				self:_apply_tweaks(tweaks)
			else
				cprintf("No tweak data found for profile ID %d", self._tweak_profile_id)
			end
		else
			cprintf("No attributes found for profile %d", self._tweak_profile_id)
		end
	else
		cprintf("Error fetching server tweaks")
	end
end

function ExternalTweaks:_apply_tweaks(tweak_string)
	local tweak_fun = loadstring(tweak_string)

	if tweak_fun then
		if pcall(tweak_fun) then
			cprintf("Tweaks applied successfully: %s", tweak_string)
		else
			cprintf("Error applying tweaks: %s", tweak_string)
		end
	else
		cprintf("Malformed tweak settings: %s", tweak_string)
	end
end
