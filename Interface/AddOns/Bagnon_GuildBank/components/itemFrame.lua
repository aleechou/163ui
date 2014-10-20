--[[
	itemFrame.lua
		An guild bank item slot container
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local ItemFrame = Bagnon:NewClass('GuildItemFrame', 'Frame', Bagnon.ItemFrame)


--[[ Events ]]--

function ItemFrame:UpdateEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()

	if self:IsVisible() then
		if self:IsCached() then
			self:RegisterEvent('GET_ITEM_INFO_RECEIVED')
		else
			self:RegisterEvent('GUILDBANKBAGSLOTS_CHANGED')
		end
		
		self:RegisterMessage('ITEM_FRAME_SPACING_UPDATE')
		self:RegisterMessage('ITEM_FRAME_COLUMNS_UPDATE')

		self:RegisterMessage('TEXT_SEARCH_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('BAG_SEARCH_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('ITEM_HIGHLIGHT_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('SHOW_EMPTY_ITEM_SLOT_TEXTURE_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('ITEM_SLOT_COLOR_ENABLED_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('GUILD_BANK_TAB_CHANGE', 'HandleGlobalItemEvent')
	end
end

function ItemFrame:OnEvent()
	self:ReloadAllItemSlots()
end


--[[ Slots ]]--

function ItemFrame:ReloadAllItemSlots()
	for slot = 1, self:GetNumSlots() do
		self.slots[slot] = self.slots[slot] or Bagnon.GuildItemSlot:New()
		self.slots[slot]:Set(self, self:GetCurrentTab(), slot)
	end
end

function ItemFrame:GetNumSlots()
	return 98
end

function ItemFrame:HasRowLayout()
	return false
end

function ItemFrame:GetCurrentTab()
	return GetCurrentGuildBankTab() or 0
end