--[[
	item.lua
		A void storage item slot button
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local ItemSlot = Bagnon:NewClass('VaultSlot', 'Button', Bagnon.ItemSlot)
ItemSlot.nextID = 0
ItemSlot.unused = {}


--[[ Constructor ]]--

function ItemSlot:Create()
	local item = Bagnon.ItemSlot.Create(self)
	item:SetScript('OnReceiveDrag', self.OnDrag)
	item:SetScript('OnDragStart', self.OnDrag)
	item:SetScript('OnClick', self.OnClick)
	item:RegisterForDrag('LeftButton')
	item:RegisterForClicks('anyUp')
	return item
end

function ItemSlot:SetFrame(parent, bag, slot)
	self:SetParent(parent)
	self:SetID(slot)
	self.bag = bag
end

function ItemSlot:ConstructNewItemSlot(id)
	return CreateFrame('Button', 'BagnonVaultItemSlot' .. id, nil, 'ContainerFrameItemButtonTemplate')
end

function ItemSlot:CanReuseBlizzardBagSlots()
	return nil
end


--[[ Click Events ]]--

function ItemSlot:OnClick (button)	
	if IsModifiedClick() then
		local link = self:GetItem()
		if link then
			HandleModifiedItemClick(link)
		end
	elseif self.bag == 'vault' then
		local isRight = button == 'RightButton'
		local type, _, link = GetCursorInfo()
		local cursor = self.Cursor
		
		if not isRight and cursor and type == 'item' and link == cursor:GetItem() then
			cursor:GetScript('PreClick')(cursor, 'RightButton') -- simulates a click on the button, less code to maintain
			cursor:GetScript('OnClick')(cursor, 'RightButton')
		
		elseif isRight and self:IsLocked() and self.withdrawSlot then
			ClickVoidTransferWithdrawalSlot(self.withdrawSlot, true)

		else
			for i = 1,9 do
				if not GetVoidTransferWithdrawalInfo(i) then
					self.withdrawSlot = i
					break
				end
			end
			
			ClickVoidStorageSlot(self:GetID(), isRight)
		end
	end
end

function ItemSlot:OnDrag()
	self:OnClick('LeftButton')
end


--[[ Tooltip ]]--

function ItemSlot:ShowTooltip()
	if self.bag == 'vault' then
		GameTooltip:SetVoidItem(self:GetID())
	elseif self.bag then
		GameTooltip:SetVoidDepositItem(self:GetID())
	else
		GameTooltip:SetVoidWithdrawalItem(self:GetID())
	end

	if IsModifiedClick('DRESSUP') then
		ShowInspectCursor()
	end
end


--[[ Fake Methods ]]--

function ItemSlot:UpdateSlotColor() end
function ItemSlot:UpdateCooldown() end


--[[ Proprieties ]]--

function ItemSlot:IsCached()
	-- delicious hack: behave as cached (disable interaction) while vault has not been purchased
	return not CanUseVoidStorage() or select(6, Bagnon.ItemSlot.GetInfo(self))
end

function ItemSlot:IsQuestItem()
	return false
end

function ItemSlot:IsNew()
	return false
end

function ItemSlot:GetInfo()
	local id, icon, locked = self:RetrieveInfo()
	local link, quality
	
	if id then
		link, quality = select(2, GetItemInfo(id))
	end
	
	return icon, 1, locked, quality, nil, nil, link
end

function ItemSlot:RetrieveInfo()
	if self.bag == 'vault' then
		return Bagnon.ItemSlot.GetInfo(self)
	else
		local get = self.bag and GetVoidTransferDepositInfo or GetVoidTransferWithdrawalInfo
		local count = self:GetID()
		
		for i = 1,9 do
			if get(i) then
				count = count - 1
				if count == 0 then
					return get(i)
				end
			end
		end
	end
end

function ItemSlot:GetBag()
	return 'vault'
end