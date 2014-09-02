
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local UserPanel = CloudUI:NewModule(GUI:GetClass('Panel'):New(UIParent), 'UserPanel', 'AceEvent-3.0')
local InfoPanel = GUI:GetClass('InfoPanel'):New(UIParent)

function InfoPanel:Load()
    local SummaryBox = self:CreateEditBox(L['签名'], L['点击这里输入个人签名'])
    local CityBox = self:CreateDropdown(L['城市'], CityMenuTable)
    local InterestBox = self:CreateMultiBox(L['游戏兴趣'], InterestList)
    local OnlineTimeBox = self:CreateMultiBox(L['活动时间'], OnlineTimeList)

    SummaryBox:SetHeight(105)
    
    local SaveButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    SaveButton:SetSize(100, 22)
    SaveButton:SetPoint('BOTTOMRIGHT', self:GetOwner(), 'BOTTOMRIGHT', -4, 4)
    SaveButton:SetText(L['保存'])
    SaveButton:SetScript('OnClick', function()
        SetPlayerInfo{
            Interest = self.Interest:GetValue(),
            OnlineTime = self.OnlineTime:GetValue(),
            Summary = self.Summary:GetText(),
            City = self.City:GetValue(),
            Avatar = self.Avatar,
        }
        HideUIPanel(self:GetOwner())
    end)

    local AvatarButton = CreateFrame('Button', nil, self)
    AvatarButton:SetPoint('TOPLEFT', self:GetOwner(), 'TOPLEFT', -15, 15)
    AvatarButton:SetSize(78, 78)
    AvatarButton:SetHighlightTexture([[Interface\Minimap\UI-Minimap-ZoomButton-Highlight]], 'ADD')
    AvatarButton:SetScript('OnClick', function(button)
        CloudUI.AvatarPopout:Open(
            button,
            self.Avatar,
            function(avatar, icon)
                self:GetOwner():SetIcon(icon)
                self.Avatar = avatar
            end
        )
    end)

    local NormalInfo = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
    NormalInfo:SetPoint('BOTTOM', self, 'TOP', 0, 20)

    self.AvatarButton = AvatarButton
    self.SaveButton = SaveButton
    self.NormalInfo = NormalInfo
    self.Loading = self:CreateLoading()
    self.City = CityBox:GetObject()
    self.Summary = SummaryBox:GetObject()
    self.Interest = InterestBox:GetObject()
    self.OnlineTime = OnlineTimeBox:GetObject()
    
    self:EnableRefreshOnShow(false)
    self:SetScript('OnShow', self.OnShow)
end

function InfoPanel:GetUserName()
    return self:GetOwner():GetUserName() or UnitName('player')
end

function InfoPanel:IsSelf()
    return not self:GetOwner():GetUserName()
end

function InfoPanel:OnShow()
    self.Loading:Show()
    if self:IsSelf() then
        self.Summary:SetReadOnly(nil)
        self.Interest:Enable()
        self.OnlineTime:Enable()
        self.City:Enable()
        self.SaveButton:Show()
        self.AvatarButton:Show()
    else
        self.Summary:SetReadOnly(true)
        self.Interest:Disable()
        self.OnlineTime:Disable()
        self.City:Disable()
        self.SaveButton:Hide()
        self.AvatarButton:Hide()
    end
    RequestUserInfo(self:GetUserName())
end

function InfoPanel:Update()
    self.Loading:Hide()

    local info = GetUserInfo(self:GetUserName())
    if not info then
        return
    end

    self.Summary:SetText(info.Summary)
    self.OnlineTime:SetValue(info.OnlineTime)
    self.Interest:SetValue(info.Interest)
    self.City:SetValue(info.City or 0)
    self.City:SetText(GetCityInfo(info.City or 0))
    self.NormalInfo:SetText(self:GetNormalInfo(info.Level, info.Class, info.Race))
    self:GetOwner():SetIcon(GetUserIcon(self:GetUserName(), true))
    self.Avatar = info.Avatar
end

function InfoPanel:GetNormalInfo(level, class, race)
    level = (not level or level < 1) and -1 or level
    race = GetRaceName(race)
    class = GetClassName(class)

    local color = GetQuestDifficultyColor(level)

    level = ('|cff%02x%02x%02x%s|r'):format(color.r * 0xff, color.g * 0xff, color.b * 0xff, level < 1 and '??' or level)

    return ('%s %s %s'):format(level, race, class)
end

function UserPanel:OnInitialize()
    self:EnableUIPanel(true)
    self:EnableTabFrame(nil)

    self:RegisterMessage('NECLOUD_USER_INFO', 'Refresh')

    self:RegisterPanel(L['个人设置'], InfoPanel)

    WowSocialUI_OnShow_In(self)

    local close = self.CloseButton:GetScript('OnClick')
    self.CloseButton:SetScript('OnClick', function(self)
        WowSocialUI_OnShow_Out(self, close)
    end)
end

function UserPanel:SetArguments(name)
    self.name = name
    self:SetIcon([[INTERFACE\CHARACTERFRAME\TempPortrait]])
    self:SetText(name or L['个人设置'])
end

function UserPanel:GetUserName()
    return self.name
end
