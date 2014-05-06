------------------------------------------------------------
-- GroupUnique.lua
--
-- Abin
-- 2012/1/26
------------------------------------------------------------

local UnitIsUnit = UnitIsUnit
local NONE = "|cff808080"..NONE.."|r"

local _, addon = ...
local L = addon.L
local templates = addon.templates

local function Button_OnTooltipText(self, tooltip)
	tooltip:AddLine(L["affected target"]..(addon:GetColoredUnitName(self.affectedUnit) or NONE), 1, 1, 1, 1)
end

local function Button_OnUpdateTimer(self, spell)
	self.affectedUnit = nil
	local allowSelf = self.allowSelf
	local key, count = addon:IsGrouped()
	if key then
		local i
		for i = 1, count do
			local unit = key..i
			if allowSelf or not UnitIsUnit(unit, "player") then
				local expires = addon:GetUnitBuffTimer(unit, spell, 1)
				if expires then
					self.affectedUnit = unit
					return 1, expires
				end
			end
		end
	elseif allowSelf then
		local expires = addon:GetUnitBuffTimer("player", spell, 1)
		if expires then
			self.affectedUnit = "player"
			return 1, expires
		end
	end
end

local function Button_AllowSelf(self)
	self.allowSelf = 1
end

templates.RegisterTemplate("GROUP_UNIQUE", function(button)
	button.OnUpdateTimer = Button_OnUpdateTimer
	button.OnTooltipText = Button_OnTooltipText
	button.AllowSelf = Button_AllowSelf
end, "GROUP")