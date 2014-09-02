
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local AvatarPopout = CreateFrame('Frame', nil, UIParent)
CloudUI.AvatarPopout = AvatarPopout

local AvatarButton = CloudUI:NewClass('AvatarButton', GUI:GetClass('ItemButton'))

function AvatarButton:Constructor()
    self:SetSize(48, 48)

    self.icon = self:CreateTexture(nil, 'BACKGROUND')
    self.icon:SetAllPoints(self)

    self:SetHighlightTexture([[INTERFACE\BUTTONS\ButtonHilight-Square]])
    self:SetCheckedTexture([[INTERFACE\BUTTONS\CheckButtonHilight]])
end

function AvatarButton:SetIcon(texture)
    self.icon:SetTexture(texture)
end

function AvatarButton:GetAutoWidth()
    return 30
end

function AvatarPopout:Load()
    self:Hide()
    self:SetFrameStrata('DIALOG')
    self:SetSize(290, 320)
    self:SetPoint('CENTER')
    self:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
        edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
        insets = { left = 8, right = 8, top = 8, bottom = 8 },
        tileSize = 24, edgeSize = 24, tile = true,
    }

    local Header = self:CreateTexture(nil, 'ARTWORK')
    Header:SetPoint('TOP', 0 ,12)
    Header:SetSize(250, 64)
    Header:SetTexture([[INTERFACE\DialogFrame\UI-DialogBox-Header]])

    local Title = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    Title:SetPoint('TOP')
    Title:SetText(L['头像选择器'])

    local IconList = GUI:GetClass('GridView'):New(self)

    IconList:SetPoint('TOPLEFT', 10, -30)
    IconList:SetSize(1, 1)

    IconList:SetItemClass(AvatarButton)
    IconList:SetItemList(AvatarList)
    IconList:SetItemWidth(48)
    IconList:SetItemHeight(48)
    IconList:SetColumnCount(5)
    IconList:SetRowCount(5)
    IconList:SetItemSpacing(3)
    IconList:SetAutoSize(true)
    IconList:SetSelectMode('RADIO')
    IconList:SetCallback('OnItemFormatted', function(self, button, data)
        button:SetIcon([[Interface\Icons\]] .. data)
    end)
    IconList:SetScrollStep(20)

    IconList:Refresh()

    local CancelButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    CancelButton:SetSize(80, 22)
    CancelButton:SetPoint('BOTTOMRIGHT', -10, 10)
    CancelButton:SetText(CANCEL)
    CancelButton:SetScript('OnClick', function()
        self:Hide()
    end)

    local OkayButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    OkayButton:SetSize(80, 22)
    OkayButton:SetPoint('RIGHT', CancelButton, 'LEFT', 0, 0)
    OkayButton:SetText(OKAY)
    OkayButton:SetScript('OnClick', function()
        self:Hide()
        local index = self.IconList:GetSelected()
        if not index or index == 0 then
            return
        end
        self.callback(index, [[Interface\Icons\]] .. self.IconList:GetItem(index))
    end)

    self.IconList = IconList

    self:SetScript('OnUpdate', function(self)
        if not self.owner:IsVisible() then
            self:Hide()
        end
    end)
    self:SetScript('OnHide', function(self)
        self.owner = nil
    end)
end

function AvatarPopout:Open(owner, value, callback)
    self.owner = owner
    self.IconList:SetSelected(value)
    self.callback = callback
    self:Show()
end

AvatarPopout:Load()
