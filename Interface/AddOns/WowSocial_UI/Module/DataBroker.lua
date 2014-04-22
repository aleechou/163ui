
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local DataBroker = CloudUI:NewModule('DataBroker', 'AceEvent-3.0')

function DataBroker:OnInitialize()
    local Object = LibStub('LibDataBroker-1.1'):NewDataObject('WowSocial_UI', {
        type = 'data source',
        text = L['正在登陆...'],
        icon = ADDON_LOGO,
        OnClick = function()
            self:Toggle()
        end,
        OnEnter = function(anchor)
            if #GetUnreadList() == 0 and #GetJoinList() == 0 then
                GameTooltip:SetOwner(anchor, 'ANCHOR_LEFT')
                GameTooltip:SetText(ADDON_NAME)
                GameTooltip:Show()
            else
                local frame = CloudUI:GetModule('MessageBox')
                frame:SetOwner(anchor)
                frame:ClearAllPoints()
                frame:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT')
                frame:Show()
            end
        end,
    })

    LibStub('LibDBIcon-1.0'):Register('WowSocial_UI', Object, CloudUI.db.profile.minimap)

    local Minimap = LibStub('LibDBIcon-1.0'):GetMinimapButton('WowSocial_UI')
    Minimap:SetParent(UIParent)

    local Loading = CreateFrame('Frame', nil, Minimap, 'NetEaseLoadingTemplate')
    Loading:SetSize(48, 48)
    Loading:SetPoint('CENTER')
    Loading:Show()

    local Flash = CreateFrame('Frame', nil, Minimap, 'WowSocialCallOutTemplate')
    Flash:SetSize(48, 48)
    Flash:SetPoint('CENTER')
    Flash:SetBackdrop(nil)
    Flash.BG:ClearAllPoints()
    Flash.BG:SetPoint('CENTER')
    Flash.BG:SetSize(36, 36)
    Flash.BG:SetTexture([[INTERFACE\Calendar\EventNotificationGlow]])
    Flash.BG:Show()
    Flash:Hide()

    local Slient = Minimap:CreateTexture(nil, 'OVERLAY', nil, 7)
    Slient:SetSize(16, 16)
    Slient:SetPoint('BOTTOMLEFT', 2, 2)
    Slient:SetTexture([[INTERFACE\FriendsFrame\StatusIcon-DnD]])
    Slient:Hide()

    self.notReady = true

    self.Slient = Slient
    self.Minimap = Minimap
    self.Loading = Loading
    self.Flash = Flash
    self.Object = Object

    self:RegisterMessage('NECLOUD_NEWVERSION')
    self:RegisterMessage('NECLOUD_SERVER_OFFLINE')
    self:RegisterMessage('NECLOUD_READY')
    self:RegisterMessage('NECLOUD_UNREAD_CHANGED', 'Refresh')
    self:RegisterMessage('NECLOUD_JOINLIST_CHANGED', 'Refresh')
    self:RegisterMessage('NECLOUD_CONFIG_SLIENTMODE', 'Refresh')
end

function DataBroker:NECLOUD_NEWVERSION(event, version, url, isCompat)
    if not isCompat then
        self.Loading:Hide()
        self.Object.text = L['发现新版本']

        self.notCompat = not isCompat
        self.url = url

        self:ShowNewVersion(url)
    end
end

function DataBroker:NECLOUD_SERVER_OFFLINE()
    self.notReady = true
    self.Object.text = L['正在登陆...']
    self.Loading:Show()
end

function DataBroker:NECLOUD_READY()
    self.notReady = nil
    self.Object.text = L['友团聊天']
    self.Loading:Hide()
    self:Refresh()
end

function DataBroker:IsReady()
    return not self.notReady
end

function DataBroker:Refresh()
    if CloudUI:IsSlientMode() then
        self.Flash:Hide()
        self.Slient:Show()
        self.Object.icon = ADDON_LOGO
        self.Object.text = L['友团聊天']
    else
        local unread = #GetUnreadList()
        local join = #GetJoinList()

        self.Slient:Hide()
        self.Flash:SetShown(unread > 0 or join > 0)

        if unread > 0 then
            local data = GetUnreadList()[1]
            self.Object.icon = GetChatIcon(data.chatType, data.target)
            self.Object.text = L['友团聊天'] .. ' ' .. (unread + join)
        else
            self.Object.icon = ADDON_LOGO
            self.Object.text = L['友团聊天']
        end
    end
end

function DataBroker:Toggle()
    if self.notCompat then
        self:ShowNewVersion(self.url)
        return
    end
    if not self:IsReady() then
        return
    end
    if UnitFactionGroup('player') == 'Neutral' then
        LibStub('NetEaseGUI-1.0'):CallWarningDialog(L['中立阵营不能使用友团聊天'])
        return
    end
    local list = GetUnreadList()
    if #list > 0 then
        CloudUI:ShowModule('ChatPanel', list[1].chatType, list[1].target)
        return
    end
    CloudUI:ToggleModule('MainPanel')
    CloudUI:HideModule('MessageBox')
end

function DataBroker:ShowNewVersion(url)
    local dialog = StaticPopup_Show('WOWSOCIAL_NEWVERSION')
    dialog.editBox:SetText(url)
    dialog.editBox:HighlightText()
    dialog.editBox:SetCursorPosition(0)
end

StaticPopupDialogs['WOWSOCIAL_NEWVERSION'] = {
    text = L['发现友团聊天新版本，您当前的版本不兼容，请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用'],
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
