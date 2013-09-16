------------------------------------------------------------
-- Item.lua
--
-- Abin
-- 2012/1/26
------------------------------------------------------------

local GetItemCount = GetItemCount
local GetItemCooldown = GetItemCooldown

local _, addon = ...
local L = addon.L
local templates = addon.templates

local function Button_OnBagUpdate(self)
	local count = GetItemCount(self.itemID or 0, false, self.asCharges) or 0
	self.itemCount = count
	local r, g, b = addon:GetGradientColor(count, self.threshold)
	self.icon:SetText(count, r, g, b)

	if count > 0 then
		local start, duration, enable = GetItemCooldown(self.itemID)
		if start and start > 0 and duration > 0 and enable > 0 then
			self.icon.cooldown:SetCooldown(start, duration)
			self.icon.cooldown:Show()
			self.itemCooldownExpires = start + duration
		else
			self.icon.cooldown:Hide()
			self.itemCooldownExpires = 0
		end
	else
		self.itemCooldownExpires = 0
	end

	self:UpdateTimer()
end

local function Button_SetItem(self, itemID, threshold, asCharges)
	self.itemCount = 0
	self.itemCooldownExpires = 0
	self.itemID = itemID
	self.threshold = threshold or 1
	self.asCharges = asCharges
	Button_OnBagUpdate(self)
end

templates.RegisterTemplate("ITEM", function(button)
	button.icon:UnregisterAllEvents()
	button.icon:SetScript("OnEvent", nil)
	button.icon2:UnregisterAllEvents()
	button.icon2:SetScript("OnEvent", nil)
	button.SetItem = Button_SetItem
	button:HookMethod("OnBagUpdate", Button_OnBagUpdate)
end)