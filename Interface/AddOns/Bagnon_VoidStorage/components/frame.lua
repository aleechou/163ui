--[[
	frame.lua
		A specialized version of the bagnon frame for void storages
--]]

local Frame = Bagnon:NewClass('VoidstorageFrame', 'Frame', Bagnon.Frame)
Frame.Title = LibStub('AceLocale-3.0'):GetLocale('Bagnon-VoidStorage').Title
Frame.OpenSound = 'UI_EtherealWindow_Open'
Frame.CloseSound = 'UI_EtherealWindow_Close'
Frame.ItemFrame = Bagnon.VaultItemFrame
Frame.MoneyFrame = Bagnon.TransferButton


--[[ Events ]]--

function Frame:OnShow()
	Bagnon.Frame.OnShow(self)
	
	self:RegisterMessage('SHOW_TRANSFER_FRAME')
	self:RegisterMessage('SHOW_ITEM_FRAME')
	self:SHOW_ITEM_FRAME()
end

function Frame:OnHide()
	Bagnon.Frame.OnHide(self)

	StaticPopup_Hide('BAGNON_CANNOT_PURCHASE_VAULT')
	StaticPopup_Hide('BAGNON_COMFIRM_TRANSFER')
	StaticPopup_Hide('BAGNON_VAULT_PURCHASE')
	StaticPopup_Hide('VOID_DEPOSIT_CONFIRM')
	CloseVoidStorageFrame()

	self:SendMessage('VOID_STORAGE_CLOSED')
end


--[[ Messages ]]--

function Frame:SHOW_TRANSFER_FRAME()
	self:FadeFrames()
	self:FadeInFrame(self:GetTransferFrame())
	
	local dialog = StaticPopup_Show('BAGNON_COMFIRM_TRANSFER')
	dialog.data = self
end

function Frame:SHOW_ITEM_FRAME()
	self:FadeFrames()
	self:FadeInFrame(self:GetItemFrame())
end

function Frame:FadeFrames()
	self:FadeOutFrame(self.transferFrame)
	self:FadeOutFrame(self.itemFrame)
end


--[[ Transfer Frame ]]--

function Frame:GetTransferFrame()
	return self.transferFrame or self:CreateTransferFrame()
end

function Frame:CreateTransferFrame()
	local item = self:GetItemFrame()
	local frame = Bagnon.TransferFrame:New(self:GetFrameID(), self)
	frame:SetAllPoints(item)
	
	self.transferFrame = frame
	return frame
end


--[[ Other Components ]]--

function Frame:PlaceBrokerDisplayFrame()
	if self:HasBrokerDisplay() then
		local frame = self:GetBrokerDisplay() or self:CreateBrokerDisplay()
		frame:ClearAllPoints()
		frame:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 16, 20)
		frame:SetPoint('RIGHT', self:GetMoneyFrame(), 'LEFT', -8, 10)
		frame:Show()
		
		return frame:GetWidth(), 24
	end

	local frame = self:GetBrokerDisplay()
	if frame then
		frame:Hide()
	end
	return 0, 0
end

function Frame:GetSpecialButtons() end
function Frame:HasMoneyFrame()
	return true
end