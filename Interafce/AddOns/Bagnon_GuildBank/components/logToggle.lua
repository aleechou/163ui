--[[
	logToggle.lua
		A guild log toggle widget (by João Cardoso)
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local L = LibStub('AceLocale-3.0'):GetLocale('Bagnon-GuildBank')
local LogToggle = Bagnon:NewClass('LogToggle', 'CheckButton')

local SIZE = 20
local NORMAL_TEXTURE_SIZE = 64 * (SIZE/36)
local MESSAGES = {
	'SHOW_LOG_FRAME',
	'SHOW_LOG_FRAME',
	'SHOW_EDIT_FRAME'
}

local ICONS = {
	[[Interface\Icons\INV_Crate_03]],
	[[Interface\Icons\INV_Misc_Coin_01]],
	[[Interface\Icons\INV_Letter_20]] --- TEMP
}


--[[ Constructor ]]--

function LogToggle:New(parent, type)
	local b = self:Bind(CreateFrame('CheckButton', nil, parent))
	b:SetWidth(SIZE)
	b:SetHeight(SIZE)
	b:RegisterForClicks('anyUp')

	local nt = b:CreateTexture()
	nt:SetTexture([[Interface\Buttons\UI-Quickslot2]])
	nt:SetWidth(NORMAL_TEXTURE_SIZE)
	nt:SetHeight(NORMAL_TEXTURE_SIZE)
	nt:SetPoint('CENTER', 0, -1)
	b:SetNormalTexture(nt)

	local pt = b:CreateTexture()
	pt:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
	pt:SetAllPoints(b)
	b:SetPushedTexture(pt)

	local ht = b:CreateTexture()
	ht:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	ht:SetAllPoints(b)
	b:SetHighlightTexture(ht)

	local ct = b:CreateTexture()
	ct:SetTexture([[Interface\Buttons\CheckButtonHilight]])
	ct:SetAllPoints(b)
	ct:SetBlendMode('ADD')
	b:SetCheckedTexture(ct)

	local icon = b:CreateTexture()
	icon:SetTexture(ICONS[type])
	icon:SetAllPoints(b)

	b:RegisterMessage('LOG_TOGGLE_CHANGED', 'Uncheck')
	b:RegisterMessage('GUILD_BANK_CLOSED', 'Uncheck')
	b:SetScript('OnClick', b.OnClick)
	b:SetScript('OnEnter', b.OnEnter)
	b:SetScript('OnLeave', b.OnLeave)
	b.type = type
	
	return b
end


--[[ Frame Events ]]--

function LogToggle:OnClick()
	if self:GetChecked() then
		self:SendMessage('LOG_TOGGLE_CHANGED')
		self:SendMessage(MESSAGES[self.type], self.type)
		self:SetChecked(true)
	else
		self:SendMessage('SHOW_ITEM_FRAME')
	end
end

function LogToggle:OnEnter()
	if self:GetRight() > (GetScreenWidth() / 2) then
		GameTooltip:SetOwner(self, 'ANCHOR_LEFT')
	else
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
	end
	
	GameTooltip:SetText(L['Log' .. self.type])
end

function LogToggle:OnLeave()
	GameTooltip:Hide()
end

function LogToggle:Uncheck()
	self:SetChecked(false)
end

LogToggle.numTypes = #MESSAGES