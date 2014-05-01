
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local AboutPanel = CloudUI:NewModule(GUI:GetClass('TitlePanel'):New(UIParent), 'AboutPanel', 'AceEvent-3.0') 

function AboutPanel:OnInitialize()
    self:Hide()
    self:SetFrameStrata('DIALOG')
    self:SetSize(400, 260)
    self:SetPoint('CENTER')
    self:SetText(L['关于'])

    local Name = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    Name:SetPoint('TOPLEFT', 50, -50)
    Name:SetText(ADDON_NAME)

    local VersionLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    VersionLabel:SetPoint('TOPLEFT', 50, -100)
    VersionLabel:SetText(L['当前版本：'])

    local Version = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    Version:SetPoint('TOPLEFT', 200, -100)
    Version:SetText(GetAddOnMetadata('WowSocial', 'Version'))

    local LatestLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    LatestLabel:SetPoint('TOPLEFT', 50, -130)
    LatestLabel:SetText(L['当前已经是最新版本'])

    local Beta = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightLeft')
    Beta:SetPoint('TOPLEFT', 50, -190)
    Beta:SetPoint('TOPRIGHT', -50, -190)
    Beta:SetText(L['本插件目前仍处于测试阶段，期间可能出现部分不稳定情况，请及时更新最新版本。'])
    Beta:SetHeight(100)
    Beta:SetJustifyV('TOP')

    self:RegisterMessage('NECLOUD_NEWVERSION', function(event, version, url)
        local NewVersionLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
        NewVersionLabel:SetPoint('TOPLEFT', 50, -130)
        NewVersionLabel:SetText(L['最新版本：'])

        local UrlLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
        UrlLabel:SetPoint('TOPLEFT', 50, -160)
        UrlLabel:SetText(L['下载链接：'])

        local NewVersion = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
        NewVersion:SetPoint('TOPLEFT', 200, -130)
        NewVersion:SetText(version)

        local Url = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
        Url:SetPoint('TOPLEFT', 200, -160)
        Url:SetText(url)

        LatestLabel:Hide()

        self:UnregisterMessage('NECLOUD_NEWVERSION')
    end)
end
