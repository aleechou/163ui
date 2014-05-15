
local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local UnitButton = CloudUI:NewClass('UnitButton', GUI:GetClass('ItemButton'))

function UnitButton:Constructor(parent)
    local IconBorder = self:CreateTexture(nil, 'OVERLAY')
    IconBorder:SetPoint('LEFT')
    IconBorder:SetTexture([[Interface\TalentFrame\spec-filagree]])
    IconBorder:SetTexCoord(0.00390625, 0.27734375, 0.48437500, 0.75781250)

    local Icon = self:CreateTexture(nil, 'ARTWORK')
    Icon:SetPoint('CENTER', IconBorder, 'CENTER')

    local UnreadIcon = self:CreateTexture(nil, 'ARTWORK')
    UnreadIcon:SetSize(32, 32)
    UnreadIcon:SetPoint('RIGHT', 0, -4)
    UnreadIcon:SetTexture([[INTERFACE\FriendsFrame\UI-Toast-BroadcastIcon]])

    local UnreadText = self:CreateFontString(nil, 'OVERLAY')
    UnreadText:SetFontObject('NumberFontNormal')
    UnreadText:SetPoint('CENTER', UnreadIcon, 'CENTER', 0, 4)

    local Text = self:CreateFontString(nil, 'ARTWORK')
    Text:SetPoint('LEFT', IconBorder, 'RIGHT', 5, 0)
    Text:SetPoint('RIGHT', UnreadIcon, 'LEFT', -5, 0)

    self.Text = Text
    self.Icon = Icon
    self.UnreadText = UnreadText
    self.UnreadIcon = UnreadIcon
    self.IconBorder = IconBorder

    self:SetFontString(Text)
    self:SetNormalFontObject('GameFontHighlightSmallLeft')
    self:SetHighlightFontObject('GameFontNormalSmallLeft')
    self:SetDisabledFontObject('GameFontDisableSmallLeft')

    self:SetCheckedTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar]])

    self:SetHighlightTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar-Blue]], 'ADD')

    self:SetBackdrop{bgFile = [[INTERFACE\BUTTONS\WHITE8X8]]}
    self:SetBackdropColor(0.2, 0.2, 0.2, 0.5)

    self:SetScript('OnSizeChanged', self.OnSizeChanged)
end

function UnitButton:OnSizeChanged(width, height)
    self.IconBorder:SetSize(height, height)
    self.Icon:SetSize(height * 56 / 70, height * 56 / 70)
end

function UnitButton:SetIcon(texture, left, right, top, bottom)
    if texture == 'player' or texture == 'target' or texture == 'focus' then
        SetPortraitTexture(self.Icon, texture)
    elseif left then
        self.Icon:SetTexture(texture)
        self.Icon:SetTexCoord(left, right, top, bottom)
    else
        SetPortraitToTexture(self.Icon, texture)
        self.Icon:SetTexCoord(0, 1, 0, 1)
    end
end

function UnitButton:SetUnread(number)
    if not number or number == 0 then
        self.UnreadIcon:Hide()
        self.UnreadText:Hide()
    else
        self.UnreadIcon:Show()
        self.UnreadText:Show()
        self.UnreadText:SetText(number)
    end
end
