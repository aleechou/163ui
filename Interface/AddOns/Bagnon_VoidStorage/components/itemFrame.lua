--[[
	itemFrame.lua
		A void storage item frame. Three kinds:
			nil -> deposited items
			DEPOSIT -> items to deposit
			WITHDRAW -> items to withdraw
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
			
			if self.kind then
				self:RegisterEvent('VOID_STORAGE_DEPOSIT_UPDATE')
			else
				self:RegisterEvent('VOID_STORAGE_CONTENTS_UPDATE')
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
	if not self.kind then
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
	
	for slot = num + 1, #self.slots do
		self:FreeItemSlot(slot)
	end

	self:RequestLayout()
end

function ItemFrame:AddItemSlot(slot)
	self.slots[slot] = Bagnon.VaultSlot:New()
	self.slots[slot]:Set(self, self.kind or 'vault', slot)
end

function ItemFrame:FreeItemSlot(slot)
	self.slots[slot]:Free()
	self.slots[slot] = nil
end

function ItemFrame:UpdateItemSlot(slot)
	self.slots[slot]:Update()
end

function ItemFrame:GetItemSlot(slot)
	return self.slots[slot]
end

function ItemFrame:GetNumSlots()
	if self.kind == DEPOSIT then
		return GetNumVoidTransferDeposit()
	elseif self.kind == WITHDRAW then
		return GetNumVoidTransferWithdrawal()
	else
		return 80 * 2
	end
end


--[[ Proprieties ]]--

function ItemFrame:HasRowLayout()
	return self.kind
end