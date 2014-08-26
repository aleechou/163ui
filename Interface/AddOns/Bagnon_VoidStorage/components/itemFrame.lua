--[[
	itemFrame.lua
		A void storage item frame. Three kinds:
			"vault" -> deposited items
			true -> items to deposit
			false -> items to withdraw
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local ItemFrame = Bagnon:NewClass('VaultItemFrame', 'Button', Bagnon.ItemFrame)


--[[ Events ]]--

function ItemFrame:UpdateEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllItemEvents()
	self:UnregisterAllMessages()
	
	if self:IsVisible() then
		if not self:IsCached() then
			self:RegisterEvent('VOID_STORAGE_UPDATE')
			self:RegisterEvent('VOID_TRANSFER_DONE')
			
			if self.kind == 'vault' then
				self:RegisterEvent('VOID_STORAGE_CONTENTS_UPDATE')
			else
				self:RegisterEvent('VOID_STORAGE_DEPOSIT_UPDATE')
			end
		else
			self:RegisterEvent('GET_ITEM_INFO_RECEIVED')
		end
	
		self:RegisterMessage('SLOT_ORDER_UPDATE')
		self:RegisterMessage('PLAYER_UPDATE')
		self:RegisterGlobalItemEvents()
	end
end

function ItemFrame:OnEvent()
	self:ReloadAllItemSlots()
end

function ItemFrame:OnSizeChanged()
	if self.kind == 'vault' then
		self:SendMessage('ITEM_FRAME_SIZE_CHANGE', self:GetFrameID())
	end
end


--[[ Slots ]]--

function ItemFrame:ReloadAllItemSlots()
	local num = self:GetNumSlots()
	if num > 0 then
		self.title:Show()
	else
		self.title:Hide()
	end
	
	for slot = 1, num do
		if self:GetItemSlot(slot) then
			self:UpdateItemSlot(slot)
		else
			self:AddItemSlot(slot)
		end
	end
	
	for slot = num + 1, #self.itemSlots do
		self:FreeItemSlot(slot)
	end

	self:RequestLayout()
end

function ItemFrame:AddItemSlot(slot)
	self.itemSlots[slot] = Bagnon.VaultSlot:New(self.kind, slot, self:GetFrameID(), self)
end

function ItemFrame:FreeItemSlot(slot)
	self.itemSlots[slot]:Free()
	self.itemSlots[slot] = nil
end

function ItemFrame:UpdateItemSlot(slot)
	self.itemSlots[slot]:Update()
end

function ItemFrame:GetItemSlot(slot)
	return self.itemSlots[slot]
end

function ItemFrame:GetNumSlots()
	if self.kind == 'vault' then
		return 80
	elseif self.kind then
		return GetNumVoidTransferDeposit()
	else
		return GetNumVoidTransferWithdrawal()
	end
end


--[[ Proprieties ]]--

function ItemFrame:HasRowLayout()
	return self.kind ~= 'vault'
end