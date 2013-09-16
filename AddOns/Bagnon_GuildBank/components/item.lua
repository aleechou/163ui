--[[
	item.lua
		A guild item slot button
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local ItemSlot = Bagnon:NewClass('GuildItemSlot', 'Button', Bagnon.ItemSlot)
ItemSlot.GUILDBANK_ITEM_LOCK_CHANGED = ItemSlot.UpdateLocked
ItemSlot.nextID = 0


--[[ Constructor ]]--

function ItemSlot:SetFrame(parent, tab, slot)
  self:SetSlot(tab, slot)
  self:SetParent(parent)
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
	if HandleModifiedItemClick(self:GetItem()) then
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
	PickupGuildBankItem(self:GetSlot())
end

function ItemSlot:OnReceiveDrag(button)
	PickupGuildBankItem(self:GetSlot())
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
	local pet = {GameTooltip:SetGuildBankItem(self:GetSlot())}
	if pet[1] and pet[1] > 0 then
		BattlePetToolTip_Show(unpack(pet))
	end

	GameTooltip:Show()
end

function ItemSlot:SplitStack(split)
	local tab, slot = self:GetSlot()
	SplitGuildBankItem(tab, slot, split)
end

function ItemSlot:UpdateCooldown()
end


--[[ Accessors ]]--

function ItemSlot:SetSlot(tab, slot)
	self.tab = tab
	self:SetID(slot)
	self:Update()
end

function ItemSlot:GetSlot()
	return self.tab, self:GetID()
end

function ItemSlot:GetInfo()
	local slot, tab = self:GetSlot()
	local link = GetGuildBankItemLink(slot, tab)
	local icon, count, locked = GetGuildBankItemInfo(slot, tab)
	local quality = link and select(3, GetItemInfo(link))

	return icon, count, locked, quality, nil, nil, link
end

function ItemSlot:IsQuestItem()
	return false
end

function ItemSlot:IsCached()
	return false
end