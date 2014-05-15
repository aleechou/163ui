
local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local MemberButton = CloudUI:NewClass('MemberButton', GUI:GetClass('ItemButton'))

function MemberButton:Constructor()
    local Icon = self:CreateTexture(nil, 'ARTWORK')
    Icon:SetPoint('LEFT')

    local OfficeIcon = self:CreateTexture(nil, 'ARTWORK')
    OfficeIcon:SetPoint('RIGHT')
    OfficeIcon:SetSize(16, 16)

    local Text = self:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('LEFT', Icon, 'RIGHT', 1, 0)
    Text:SetPoint('RIGHT', OfficeIcon, 'LEFT')

    self.Text = Text
    self.Icon = Icon
    self.OfficeIcon = OfficeIcon

    self:SetFontString(Text)
    self:SetNormalFontObject('GameFontHighlightSmallLeft')
    self:SetHighlightFontObject('GameFontNormalSmallLeft')
    self:SetDisabledFontObject('GameFontDisableSmallLeft')
    self:SetCheckedTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar]])
    self:GetCheckedTexture():SetAlpha(0.4)

    self:SetHighlightTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar-Blue]], 'ADD')

    self:SetScript('OnSizeChanged', self.OnSizeChanged)
end

function MemberButton:OnSizeChanged(width, height)
    self.Icon:SetSize(height, height)
end

function MemberButton:SetIcon(texture, left, right, top, bottom)
    self.Icon:SetTexture(texture)
    if left then
        self.Icon:SetTexCoord(left, right, top, bottom)
    else
        self.Icon:SetTexCoord(0, 1, 0, 1)
    end
end

function MemberButton:SetOfficeIcon(texture)
    if not texture then
        self.OfficeIcon:Hide()
    else
        self.OfficeIcon:Show()
        self.OfficeIcon:SetTexture(texture) 
    end
end

function MemberButton:SetOnline(flag)
    self.Icon:SetDesaturated(not flag)
end
