--[[
	item.lua
		A guild item slot button
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local ItemSlot = Bagnon:NewClass('GuildItemSlot', 'Button', Bagnon.ItemSlot)
ItemSlot.GUILDBANK_ITEM_LOCK_CHANGED = ItemSlot.UpdateLocked
ItemSlot.GUILD_BANK_TAB_CHANGE = ItemSlot.Update
ItemSlot.nextID = 0


--[[ Constructor ]]--

function ItemSlot:SetFrame(parent, tab, slot)
  self:SetID(slot)
  self:SetParent(parent)
  self:Update()
end

function ItemSlot:Create()
	local item = Bagnon.ItemSlot.Create(self)
	item:SetScript('OnReceiveDrag', self.OnReceiveDrag)
	item:SetScript('OnDragStart', self.OnDragStart)
	item:SetScript('OnClick', self.OnClick)
	item:RegisterForDrag('LeftButton')
	item:RegisterForClicks('anyUp')
	return item
end

function ItemSlot:ConstructNewItemSlot(id)
	return CreateFrame('Button', 'BagnonGuildItemSlot' .. id, nil, 'ContainerFrameItemButtonTemplate')
end

function ItemSlot:CanReuseBlizzardBagSlots()
  return nil
end


--[[ Events ]]--

function ItemSlot:OnClick(button)
	if HandleModifiedItemClick(self:GetItem()) or self:IsCached() then
		return
	end

	if IsModifiedClick('SPLITSTACK') then
		if not self:IsLocked() then
			self.SplitStack = ItemSlot.SplitStack -- have no idea why is necessary
			OpenStackSplitFrame(select(2, self:GetInfo()), self, 'BOTTOMLEFT', 'TOPLEFT')
		end
		return
	end

	local type, money = GetCursorInfo()
	if type == 'money' then
		DepositGuildBankMoney(money)
		ClearCursor()
	elseif type == 'guildbankmoney' then
		DropCursorMoney()
		ClearCursor()
	elseif button == 'RightButton' then
		AutoStoreGuildBankItem(self:GetSlot())
	else
		PickupGuildBankItem(self:GetSlot())
	end
end

function ItemSlot:OnDragStart(button)
	if not self:IsCached() then
		PickupGuildBankItem(self:GetSlot())
	end
end

function ItemSlot:OnReceiveDrag(button)
	if not self:IsCached() then
		PickupGuildBankItem(self:GetSlot())
	end
end

function ItemSlot:OnShow()
 	self:RegisterEvent('GUILDBANK_ITEM_LOCK_CHANGED')
	self:Update()
end

function ItemSlot:OnEnter()
	if self:GetItem() then
 		self:AnchorTooltip()
		self:UpdateTooltip()
	end
end


--[[ Updaters ]]--

function ItemSlot:UpdateTooltip()
	if self:IsCached() then
		local dummySlot = self:GetDummyItemSlot()
		dummySlot:SetParent(self)
		dummySlot:SetAllPoints(self)
		dummySlot:Show()
	else
		local pet = {GameTooltip:SetGuildBankItem(self:GetSlot())}
		if pet[1] and pet[1] > 0 then
			BattlePetToolTip_Show(unpack(pet))
		end

		GameTooltip:Show()
	end
end

function ItemSlot:SplitStack(split)
	local tab, slot = self:GetSlot()
	SplitGuildBankItem(tab, slot, split)
end

function ItemSlot:UpdateCooldown() end


--[[ Accessors ]]--

function ItemSlot:GetInfo()
	return LibStub('LibItemCache-1.1'):GetItemInfo(self:GetPlayer(), 'guild' .. tostring(self:GetBag()), self:GetID())
end

function ItemSlot:GetSlot()
	return self:GetBag(), self:GetID()
end

function ItemSlot:GetBag()
	return GetCurrentGuildBankTab()
end

function ItemSlot:IsQuestItem() end
function ItemSlot:IsNew() end