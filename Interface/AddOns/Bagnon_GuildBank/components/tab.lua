--[[
	tab.lua
		A tab button object
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local TabFrame = Bagnon:NewClass('GuildTabFrame', 'Frame', Bagnon.BagFrame)
local Tab = Bagnon:NewClass('GuildTab', 'CheckButton', Bagnon.Bag)

Tab.SetSearch = function() end
Tab.ClearSearch = Tab.SetSearch
TabFrame.Button = Bagnon.Tab


--[[ Main ]]--

function Tab:New(...)
	local tab = Bagnon.Bag.New(self, ...)
	tab:SetScript('OnReceiveDrag', nil)
	tab:SetScript('OnDragStart', nil)

	return tab
end

function Tab:OnClick()
	local tab = self:GetID()
	local _,_ viewable = self:GetInfo()
	
	if viewable then
		SetCurrentGuildBankTab(tab)
		QueryGuildBankTab(tab)
	
		self:SendMessage('GUILD_BANK_TAB_CHANGE')
	else
		self:SetChecked(false)
	end
end

function Tab:GetSlot()
	return 'guild' .. tostring(self:GetID())
end


--[[ Update ]]--

function Tab:Update()
	local name, icon, viewable, _,_, remainingWithdrawals = self:GetInfo()
	SetItemButtonTexture(self, icon or [[Interface\PaperDoll\UI-PaperDoll-Slot-Bag]])
	
	if viewable then
		SetItemButtonTextureVertexColor(self, 1, 1, 1)
	else
		SetItemButtonTextureVertexColor(self, 1, 0.1, 0.1)
	end
	
	_G[self:GetName() .. 'IconTexture']:SetDesaturated(not viewable)
	self:UpdateChecked()
	self:UpdateCount(remainingWithdrawals)
end

function Tab:UpdateChecked()
	self:SetChecked(self:GetID() == GetCurrentGuildBankTab())
end

function Tab:UpdateCount(count)
	if self:GetChecked() or self:IsCached() then
		self:SetCount(count or select(6, self:GetInfo()))
	end
end

function Tab:UpdateTooltip()
	local name, icon, _, canDeposit, numWithdrawals = self:GetInfo()
	if name then
		GameTooltip:SetText(name)

		local access
		if not canDeposit and numWithdrawals == 0 then
			access = RED_FONT_COLOR_CODE .. "(" .. GUILDBANK_TAB_LOCKED .. ")" .. FONT_COLOR_CODE_CLOSE;
		elseif not canDeposit then
			access = RED_FONT_COLOR_CODE .."(" .. GUILDBANK_TAB_WITHDRAW_ONLY .. ")" .. FONT_COLOR_CODE_CLOSE;
		elseif numWithdrawals == 0 then
			access = RED_FONT_COLOR_CODE .."(" .. GUILDBANK_TAB_DEPOSIT_ONLY .. ")" .. FONT_COLOR_CODE_CLOSE;
		else
			access = GREEN_FONT_COLOR_CODE .. "(" .. GUILDBANK_TAB_FULL_ACCESS .. ")" .. FONT_COLOR_CODE_CLOSE;
		end

		GameTooltip:AddLine(access)
	else
		GameTooltip:SetText('Unavailable')
	end

	GameTooltip:Show()
end


--[[ Events ]]--

function Tab:UpdateEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()

	if self:IsVisible() then
		self:RegisterMessage('GUILD_BANK_TAB_CHANGE')
		self:RegisterEvent('GUILDBANK_UPDATE_TABS')
		self:RegisterEvent('GUILDBANKBAGSLOTS_CHANGED')
	end
end

function Tab:GUILDBANKBAGSLOTS_CHANGED()
	self:UpdateCount()
end

Tab.GUILDBANK_UPDATE_TABS = Tab.Update
Tab.GUILD_BANK_TAB_CHANGE = Tab.UpdateChecked