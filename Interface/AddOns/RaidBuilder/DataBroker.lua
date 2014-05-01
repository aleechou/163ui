
BuildEnv(...)

local addonName = ...

local DataBroker = RaidBuilder:NewModule('DataBroker', 'AceEvent-3.0')

function DataBroker:OnInitialize()
    self.db = RaidBuilder:GetDB()

    local BrokerObject = LibStub('LibDataBroker-1.1'):NewDataObject('RaidBuilder', {
        type = 'data source',
        text = ADDON_NAME,
        icon = [[INTERFACE\ICONS\INV_Misc_GroupNeedMore]],

        OnEnter = function(anchor)
            GameTooltip:SetOwner(anchor, 'ANCHOR_LEFT')
            GameTooltip:SetText(ADDON_NAME)
            GameTooltip:Show()
        end,

        OnClick = function()
            self:Toggle()
        end
    })

    LibStub('LibDBIcon-1.0'):Register('RaidBuilder', BrokerObject, self.db.profile.minimap)

    local Minimap = LibStub('LibDBIcon-1.0'):GetMinimapButton('RaidBuilder')

    local Flash = CreateFrame('Frame', nil, Minimap)
    Flash:Hide()
    Flash:SetPoint('CENTER')
    Flash:SetSize(48, 48)
    Flash.bg = Flash:CreateTexture(nil, 'OVERLAY')
    Flash.bg:SetBlendMode('ADD')
    Flash.bg:SetPoint('CENTER')
    Flash.bg:SetSize(36, 36)
    Flash.bg:SetTexture([[INTERFACE\Calendar\EventNotificationGlow]])
    Flash.Anmi = Flash:CreateAnimationGroup()
    Flash.Anmi:SetLooping('BOUNCE')
    Flash.Alpha = Flash.Anmi:CreateAnimation('Alpha')
    Flash.Alpha:SetDuration(0.75)
    Flash.Alpha:SetChange(-0.7)
    Flash:SetScript('OnShow', function(self) self.Anmi:Play() end)
    Flash:SetScript('OnHide', function(self) self.Anmi:Stop() end)

    Minimap:SetParent(UIParent)

    self.Flash = Flash
    self.Minimap = Minimap
    self.BrokerObject = BrokerObject

    self:RegisterMessage('RAIDBUILDER_MEMBER_LIST_UPDATE', 'Refresh')
    self:RegisterMessage('RAIDBUILDER_NEW_VERSION')
end

function DataBroker:Toggle()
    if self.notCompat then
        self:ShowNewVersion(self.url)
    else
        RaidBuilder:ToggleModule('MainPanel')
    end
end

function DataBroker:Refresh()
    local count = MemberCache:GetMemberCount()
    if count > 0 then
        self.Flash:SetShown(MemberCache:GetMemberCount() > 0)
        self.BrokerObject.text = L['申请列表：'] .. count
    else
        self.Flash:SetShown(MemberCache:GetMemberCount() > 0)
        self.BrokerObject.text = ''
    end
end

function DataBroker:RAIDBUILDER_NEW_VERSION(_, version, url, isCompat)
    if not isCompat then
        self.BrokerObject.text = L['发现新版本']

        self.notCompat = not isCompat
        self.url = url

        self:ShowNewVersion(url)
    end
    System:Logf(L['发现新版本: %s，请及时下载更新\n%s'], version, url)
end

function DataBroker:ShowNewVersion(url)
    local dialog = StaticPopup_Show('RAIDBUILDER_NEWVERSION')
    dialog.editBox:SetText(url)
    dialog.editBox:HighlightText()
    dialog.editBox:SetCursorPosition(0)
end

StaticPopupDialogs['RAIDBUILDER_NEWVERSION'] = {
    text = L['发现友团组团新版本，您当前的版本不兼容，请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用'],
    button1 = OKAY,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hasEditBox = true,
    showAlert = 1,
    hideOnEscape = 1,
    maxLetters = 2000,
    maxBytes = 2000,
}
