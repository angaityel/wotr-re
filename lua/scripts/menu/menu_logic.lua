-- chunkname: @scripts/menu/menu_logic.lua

MenuLogic = class(MenuLogic)

function MenuLogic:init(compiled_menu_def, menu_shortcuts, world, on_enter_page_callback)
	self._root_page = compiled_menu_def
	self._current_page = compiled_menu_def
	self._menu_shortcuts = menu_shortcuts
	self._world = world
	self._on_enter_page_callback = on_enter_page_callback

	self._current_page:set_menu_logic(self)

	self._update_function = self._update_normal

	Managers.state.event:register(self, "disable_menu_input", "event_disable_menu_input")
end

function MenuLogic:update(dt, t, input)
	if not script_data.menu_update_disabled then
		self._update_function(self, dt, t, input)
	end
end

function MenuLogic:_update_normal(dt, t, input)
	if self._change_page_on_update then
		for i, page in ipairs(self._change_page_on_update) do
			self:_change_page(page)
			self._current_page:set_menu_logic(self)
		end

		self._change_page_on_update = nil
	end

	if not self._input_disabled then
		self._current_page:set_input(input)
	end

	self._current_page:update(dt, t)
	self._current_page:render(dt, t)
end

function MenuLogic:event_disable_menu_input()
	self._input_disabled = true
end

function MenuLogic:_update_transition(dt, t, input)
	self._transition_data.timer = self._transition_data.timer - dt

	if self._transition_data.timer <= 0 then
		self:change_page(self._transition_data.new_page, nil)

		self._transition_data = nil
		self._update_function = self._update_normal
	end

	self._current_page:update(dt, t)
	self._current_page:render(dt, t)
end

function MenuLogic:change_page(new_page, delay)
	if delay then
		self._transition_data = {
			timer = delay,
			new_page = new_page
		}
		self._update_function = self._update_transition
	elseif not self._change_page_on_update then
		if getmetatable(new_page) then
			self._change_page_on_update = {
				new_page
			}
		else
			self._change_page_on_update = new_page
		end
	else
		Application.warning("[MenuLogic:change_page] Tried to set self._change_page_on_update multiple times in the same frame!")
	end
end

function MenuLogic:_change_page(new_page)
	local on_cancel = new_page == self._current_page:parent_page()

	self._current_page:on_exit(on_cancel)

	self._current_page = new_page

	self._current_page:on_enter(on_cancel)
	self._on_enter_page_callback(self._current_page)
end

function MenuLogic:menu_activated()
	self._root_page:menu_activated()
	self._current_page:on_enter()
	self._on_enter_page_callback(self._current_page)
end

function MenuLogic:menu_deactivated()
	self._root_page:menu_deactivated()
	self._current_page:on_exit()
end

function MenuLogic:goto(id)
	local page = self._current_page
	local pages = {}

	while page:parent_page() do
		pages[#pages + 1] = page:parent_page()
		page = page:parent_page()
	end

	local shortcut = self._menu_shortcuts[id]

	for _, item_index in ipairs(shortcut) do
		local item = page:items()[item_index]

		pages[#pages + 1] = item:page()
		page = item:page()
	end

	self:change_page(pages)
end

function MenuLogic:current_page()
	return self._current_page
end

function MenuLogic:current_page_is_root()
	return self._current_page:parent_page() == nil
end

function MenuLogic:current_page_type()
	return self._current_page.config.type
end

function MenuLogic:current_parent_page_type()
	return self._current_page.config.parent_page and self._current_page.config.parent_page.config.type
end

function MenuLogic:cancel_to(page_id)
	local page = self._current_page
	local pages = {}

	while page:parent_page() and page.config.id ~= page_id do
		pages[#pages + 1] = page:parent_page()
		page = page:parent_page()
	end

	self:change_page(pages)
end

function MenuLogic:cancel_to_parent(ignore_sound)
	if self._current_page:parent_page() then
		if not ignore_sound then
			local timpani_world = World.timpani_world(self._world)

			TimpaniWorld.trigger_event(timpani_world, self._current_page.config.sounds.page.back)
		end

		self:change_page(self._current_page:parent_page())
	end
end

function MenuLogic:destroy()
	self._root_page:destroy()
end
