
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')
local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local SearchGroupButton = CloudUI:NewClass('SearchGroupButton', GUI:GetClass('ItemButton'))

function SearchGroupButton:Constructor(parent)
    local IconBorder = self:CreateTexture(nil, 'OVERLAY')
    IconBorder:SetPoint('LEFT')
    IconBorder:SetTexture([[Interface\TalentFrame\spec-filagree]])
    IconBorder:SetTexCoord(0.00390625, 0.27734375, 0.48437500, 0.75781250)

    local Icon = self:CreateTexture(nil, 'ARTWORK')
    Icon:SetPoint('CENTER', IconBorder, 'CENTER')

    local UserCount = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
    UserCount:SetTextColor(1, 1, 0.45)
    UserCount:SetPoint('RIGHT', -8, 0)

    local FansCount = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
    FansCount:SetPoint('RIGHT', UserCount, 'LEFT', -5, 0)
    FansCount:SetTextColor(1, 1, 0.45)

    local Text = self:CreateFontString(nil, 'ARTWORK')
    Text:SetPoint('LEFT', IconBorder, 'RIGHT', 5, 0)
    Text:SetPoint('RIGHT', FansCount, 'LEFT', -5, 0)

    self.FansCount = FansCount
    self.UserCount = UserCount
    self.Text = Text
    self.Icon = Icon
    self.IconBorder = IconBorder

    self:SetFontString(Text)
    self:SetNormalFontObject('GameFontHighlightSmallLeft')
    self:SetHighlightFontObject('GameFontNormalSmallLeft')
    self:SetDisabledFontObject('GameFontDisableSmallLeft')

    self:SetCheckedTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar]])
    self:GetCheckedTexture():SetAlpha(0.4)

    self:SetHighlightTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar-Blue]], 'ADD')

    self:SetBackdrop{bgFile = [[INTERFACE\BUTTONS\WHITE8X8]]}
    self:SetBackdropColor(0.2, 0.2, 0.2, 0.5)

    self:SetScript('OnSizeChanged', self.OnSizeChanged)
end

function SearchGroupButton:OnSizeChanged(width, height)
    self.IconBorder:SetSize(height, height)
    self.Icon:SetSize(height * 56 / 70, height * 56 / 70)
end

function SearchGroupButton:SetIcon(texture)
    SetPortraitToTexture(self.Icon, texture)
end

function SearchGroupButton:SetUserCount(count)
    self.UserCount:SetText(L['%d名成员']:format(count or 0))
end

function SearchGroupButton:SetFansCount(count)
    self.FansCount:SetText(L['%d个粉丝']:format(count or 0))
end
