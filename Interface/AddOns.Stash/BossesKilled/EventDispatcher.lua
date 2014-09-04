--[[
	Basic event dispatching, and registering aliases

New methods:
	addon:RegisterEvent(event)
	addon:UnregisterEvent(event)
	addon:UnregisterAllEvents()
Hooks:
	addon:EVENT_NAME(...) - Called by the OnEvent handler for "EVENT_NAME" event
]]

local addonName, addon = ...

if not addon.RegisterEvent and not addon.UnregisterEvent and not addon.UnregisterAllEvents then
	local f = CreateFrame("frame")
	f:SetScript("OnEvent", function(self, event, ...) addon[event](addon, ...) end)

	function addon:RegisterEvent(event)
		f:RegisterEvent(event)
	end
	function addon:UnregisterEvent(event)
		f:UnregisterEvent(event)
	end
	function addon:UnregisterAllEvents()
		f:UnregisterAllEvents()
	end
end