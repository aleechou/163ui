-- Author      : s1172
-- Create Date : 2013/2/28 15:58:16

local Other_Script = CreateFrame('frame', 'Other_Script')

local L = NAOtherApi.Localization
local SetupWay = 'YA'
local cname = 'WOWCLOUD1'
local _prefix = 'NBATRACE'

local btnMinimap = CreateFrame('button', nil, MinimapBackdrop)
btnMinimap:SetSize(32, 32)
btnMinimap:SetPoint('TOPLEFT', 18, -18)
btnMinimap:SetHitRectInsets(4, 4, 2, 6)
btnMinimap:SetNormalTexture('Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Tutorial\\DisableAddonNormal')
btnMinimap:SetPushedTexture('Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Tutorial\\DisableAddonHighlight')
btnMinimap:SetHighlightTexture('Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Tutorial\\DisableAddonHighlight', 'ADD')
btnMinimap:SetScript('OnEnter', function()
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
	GameTooltip:SetText(TutorialApi:Localize('DisableAddonTip'))
	GameTooltip:AddLine(TutorialApi:Localize('DisableAddonTip1'))
	GameTooltip:AddLine(TutorialApi:Localize('DisableAddonTip2'))
	GameTooltip:Show()
end)
btnMinimap:SetScript('OnClick', function()
	if not StaticPopup1:IsShown() or StaticPopup1.which ~= 'DisableNewbieAssistant' then
		StaticPopup_Show('DisableNewbieAssistant')
	end
end)

NAApi:RegEvent(NAOtherApi, 'PLAYER_LOGIN', function()
	if NAApi:GetLvl('player') > 20 then
		NAOtherApi:DisableAddon()
		btnMinimap:Hide()
	else
		local guid = UnitGUID('player')
		NAApi:SetAddonDB('guid', guid)
	end
end, true)

function Other_Script:CHAT_MSG_ADDON(event, prefix, msg, channel, sender)
    if prefix == _prefix and msg == 'SetupWayOK' then
		NAApi:SetAddonDB('SetupWaySend', true)
	end
end

function Other_Script:SendAddonInfo()
	if NAApi:GetAddonDB('SetupWaySend') or GetTime() > self.CheckTime then
		return NAApi:SetAddonDB('SetupWaySend', true)
	end

	if not self.Name then
	    local realm = GetAutoCompleteRealms() and GetAutoCompleteRealms()[1] or GetRealmName()
	    self.Name = cname .. '-' .. realm
	end

    local SetupWay = {
		SetupWay == 'NA' and 11 or 10,					-- IsNewbieAddon
		SetupWay == 'BF' and 21 or 20,			-- IsBigFoot
		SetupWay == 'DW' and 31 or 30,			-- IsDuowan
		SetupWay == 'GC' and 41 or 40,					-- IsGreenClient
		IsTrialAccount() and 81 or 80,					-- IsTrialAccount
		NAApi:GetAddonDB('DisableAddon') and 91 or 90,	-- IsAddOnEnable
		SetupWay == 'YA' and 101 or 100,
	}

	local _sw = table.concat(SetupWay, '')
	_sw = NAApi:URLEncode(_sw)

	local guid = NAApi:GetAddonDB('guid')

	if not guid then 
		guid = UnitGUID('player')
		NAApi:SetAddonDB('guid', guid)
	end

    SendAddonMessage(_prefix, guid .. ',' .. _sw, 'WHISPER', self.Name)
	NAApi:Sleep(60, function() self:SendAddonInfo() end)
end

function Other_Script:VARIABLES_LOADED()
	if not NAApi:GetAddonDB('SetupWaySend') and NAApi:GetLvl('player') <= 20 then
		NAApi:Sleep(60, function() self:SendAddonInfo() end)
		self:RegisterEvent('CHAT_MSG_ADDON')
    	RegisterAddonMessagePrefix(_prefix)
		self.CheckTime = GetTime() + 300
	end
end

Other_Script:SetScript('OnEvent', function(self, event, ...)
	if self[event] and type(self[event]) == 'function' then
		self[event](self, event, ...)
	end
end)

Other_Script:RegisterEvent('VARIABLES_LOADED')
