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
		self:RegisterEvent('GUILDBANKBAGSLOTS_CHANGED')
		
		self:RegisterMessage('ITEM_FRAME_SPACING_UPDATE')
		self:RegisterMessage('ITEM_FRAME_COLUMNS_UPDATE')

		self:RegisterMessage('TEXT_SEARCH_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('BAG_SEARCH_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('ITEM_HIGHLIGHT_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('SHOW_EMPTY_ITEM_SLOT_TEXTURE_UPDATE', 'HandleGlobalItemEvent')
		self:RegisterMessage('ITEM_SLOT_COLOR_ENABLED_UPDATE', 'HandleGlobalItemEvent')
	end
end

function ItemFrame:OnEvent()
	self:ReloadAllItemSlots()
end


--[[ Slot Management ]]--

--remove all unused item slots from the frame
--add all missing slots to the frame
--update all existing slots on the frame
--currently, all tabs have the same number of slots. So there is no need to request layouts

function ItemFrame:ReloadAllItemSlots()
	local currentTab = self:GetCurrentTab()
	for slot = 1, self:GetNumSlots() do
		local itemSlot = self:GetItemSlot(slot)
		if itemSlot then
			itemSlot:SetSlot(currentTab, slot)
		else
			self:AddItemSlot(slot)
		end
	end
end

--if an item is not assigned to the given slotIndex, then add an item
function ItemFrame:AddItemSlot(slot)
	if not self:GetItemSlot(slot) then
		local itemSlot = self:NewItemSlot(slot)
		self.itemSlots[slot] = itemSlot
	end
end

function ItemFrame:NewItemSlot(slot)
	return Bagnon.GuildItemSlot:New(self:GetCurrentTab(), slot, self:GetFrameID(), self)
end

--returns the item slot assigned to the given slotIndex
function ItemFrame:GetItemSlot(slot)
	return self.itemSlots[slot]
end


--[[ Properties ]]--

function ItemFrame:GetNumSlots()
	return 98
end

function ItemFrame:HasRowLayout()
	return false
end

function ItemFrame:GetCurrentTab()
	return GetCurrentGuildBankTab() or 0
end