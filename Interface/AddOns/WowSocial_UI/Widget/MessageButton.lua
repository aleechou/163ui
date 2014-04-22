
local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local MessageButton = CloudUI:NewClass('MessageButton', GUI:GetClass('ItemButton'))

local function Bubble_OnSizeChanged(self, width)
    self:GetParent().Text:SetWidth(width - 20)
    self:GetParent().Message:SetWidth(width - 20)
end

local LINK_TYPES = {
    item = true,
    enchant = true,
    spell = true,
    quest = true,
    unit = true,
    talent = true,
    achievement = true,
    glyph = true,
    instancelock = true,
    battlepet = true,
}

local function OnHyperlinkEnter(self,link,text,button)
    local linktype = link:match("^([^:]+)")
    if not LINK_TYPES[linktype] then
        return
    end

    GameTooltip_SetDefaultAnchor(GameTooltip, self)
    if linktype == 'battlepet' then
        local _, specie, level, quality, health, power, speed = strsplit(':', link)
        local name = link:match('%[(.-)%]')
        
        BattlePetToolTip_Show(
            tonumber(specie), level, tonumber(quality), health, power, speed, name)
    else
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end
end

local function UpdateTooltip()
    local self = GameTooltip
    if not self.comparing and IsModifiedClick('COMPAREITEMS') then
        GameTooltip_ShowCompareItem(self);
        self.comparing = true;
    elseif self.comparing and not IsModifiedClick('COMPAREITEMS') then
        for _, frame in pairs(self.shoppingTooltips) do
            frame:Hide();
        end
        self.comparing = false;
    end
end

local function OnHyperlinkLeave(self)
    GameTooltip:Hide()
    BattlePetTooltip:Hide()
end

local function OnHyperlinkClick(self,link,text,button)
    SetItemRef(link, text, button, self)
end

function MessageButton:Constructor()
    self:SetHeight(40)

    local UserButton = CreateFrame('Button', nil, self)
    UserButton:SetSize(30, 30)

    local Icon = UserButton:CreateTexture(nil, 'OVERLAY')
    Icon:SetAllPoints(UserButton)
    Icon:SetTexture([[INTERFACE\ICONS\Ability_Hunter_Assassinate2]])

    local Bubble = CreateFrame('Frame', nil, self)
    Bubble:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
        tileSize = 16, edgeSize = 16, tile=true
        }
    Bubble:SetBackdropBorderColor(1, 0.82, 0, 1)
    Bubble:SetBackdropColor(0, 0, 0, 0.8)

    local Name = Bubble:CreateFontString(nil, 'OVERLAY', 'ChatFontNormal')
    Name:SetPoint('TOPLEFT', 10, -10)
    Name:SetPoint('TOPRIGHT', -10, -10)
    Name:SetJustifyH('RIGHT')

    local Text = Bubble:CreateFontString(nil, 'OVERLAY', 'ChatFontNormal')
    Text:SetPoint('BOTTOMLEFT', 10, 10)
    Text:SetWordWrap(true)
    Text:SetNonSpaceWrap(true)
    Text:SetJustifyH('LEFT')
    Text:Hide()

    local Message = CreateFrame('SimpleHTML', nil, Bubble)--, 'NetEaseMessageFrameTemplate')
    Message:SetFontObject('ChatFontNormal')
    Message:SetScript('OnHyperlinkClick', OnHyperlinkClick)
    Message:SetScript('OnHyperlinkEnter', OnHyperlinkEnter)
    Message:SetScript('OnHyperlinkLeave', OnHyperlinkLeave)
    Message:SetPoint('TOPLEFT', Text, 'TOPLEFT')
    Message.UpdateTooltip = UpdateTooltip

    Bubble:SetScript('OnSizeChanged', Bubble_OnSizeChanged)

    self.Message = Message
    self.Name = Name
    self.Text = Text
    self.Icon = Icon
    self.Bubble = Bubble
    self.UserButton = UserButton

    self:SetReverse(true)
end

function MessageButton:SetReverse(reverse)
    self.UserButton:ClearAllPoints()
    self.Bubble:ClearAllPoints()

    self.Bubble:SetPoint('TOP')
    self.Bubble:SetPoint('BOTTOM')

    if reverse then
        self.UserButton:SetPoint('TOPRIGHT')
        self.Bubble:SetPoint('RIGHT', self.UserButton, 'LEFT', -10, 0)
        self.Bubble:SetPoint('LEFT')
    else
        self.UserButton:SetPoint('TOPLEFT')
        self.Bubble:SetPoint('LEFT', self.UserButton, 'RIGHT', 10, 0)
        self.Bubble:SetPoint('RIGHT')
    end
end

function MessageButton:SetMsgText(text)
    self.Text:SetText(text)
    self:SetHeight(self.Text:GetHeight() + 40)

    self.Message:SetText(text .. '|cffffffff|r')
    self.Message:SetHeight(self.Text:GetHeight())
end

function MessageButton:SetNameText(text)
    self.Name:SetText(text)
end

function MessageButton:SetIcon(texture, left, right, top, bottom)
    self.Icon:SetTexture(texture)
    if left then
        self.Icon:SetTexCoord(left, right, top, bottom)
    else
        self.Icon:SetTexCoord(0, 1, 0, 1)
    end
end
