
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local DataBroker = CloudUI:NewModule('DataBroker', 'AceEvent-3.0')

function DataBroker:OnInitialize()
    local Object = LibStub('LibDataBroker-1.1'):NewDataObject('WowSocial_UI', {
        type = 'data source',
        text = L['正在登陆...'],
        loading = true,
        icon = ADDON_LOGO,
        OnClick = function()
            self:Toggle()
        end,
        OnEnter = function(owner)
            local anchor = owner:GetBottom() < GetScreenHeight() / 2 and 'ANCHOR_TOP' or 'ANCHOR_BOTTOM'
            if #GetUnreadList() == 0 and #GetJoinList() == 0 then
                GameTooltip:SetOwner(owner, anchor)
                GameTooltip:SetText(ADDON_NAME)
                GameTooltip:Show()
            else
                local frame = CloudUI:GetModule('MessageBox')
                frame:SetOwner(owner)
                frame:ClearAllPoints()
                if anchor == 'ANCHOR_BOTTOM' then
                    frame:SetPoint('TOP', owner, 'BOTTOM')
                else
                    frame:SetPoint('BOTTOM', owner, 'TOP')
                end
                frame:Show()
            end
        end,
    })

    LibStub('LibDBIcon-1.0'):Register('WowSocial_UI', Object, CloudUI.db.profile.minimap)

    local Minimap = LibStub('LibDBIcon-1.0'):GetMinimapButton('WowSocial_UI')
    Minimap:SetParent(UIParent)

    LibStub('NetEaseMinimap-1.0'):Register('WowSocial_UI')
    LibStub('NetEaseMinimap-1.0'):RegisterKeyData('WowSocial_UI', 'slient', {
        MakeMinimap = function(button)
            local Slient = button:CreateTexture(nil, 'OVERLAY', nil, 7)
            Slient:SetSize(16, 16)
            Slient:SetPoint('BOTTOMLEFT', 2, 2)
            Slient:SetTexture([[INTERFACE\FriendsFrame\StatusIcon-DnD]])
            return Slient
        end,
        Set = function(widget, value)
            widget:SetShown(value)
        end
    })


    self.notReady = true
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
        self.Object.text = L['发现新版本']
        self.Object.loading = nil

        self.notCompat = not isCompat
        self.url = url

        self:ShowNewVersion(url)
    end
end

function DataBroker:NECLOUD_SERVER_OFFLINE()
    self.notReady = true
    self.Object.text = L['正在登陆...']
    self.Object.loading = true
end

function DataBroker:NECLOUD_READY()
    self.notReady = nil
    self.Object.text = ADDON_NAME
    self.Object.loading = nil
    self:Refresh()
end

function DataBroker:IsReady()
    return not self.notReady
end

function DataBroker:Refresh()
    if CloudUI:IsSlientMode() then
        self.Object.icon = ADDON_LOGO
        self.Object.text = ADDON_NAME
        self.Object.flash = nil
        self.Object.slient = true
    else
        local unread = #GetUnreadList()
        local join = #GetJoinList()

        self.Object.slient = nil
        self.Object.flash = unread > 0 or join > 0 or nil

        if unread > 0 then
            local data = GetUnreadList()[1]
            self.Object.icon = GetChatIcon(data.chatType, data.target)
            self.Object.text = ADDON_NAME .. ' ' .. (unread + join)
        else
            self.Object.icon = ADDON_LOGO
            self.Object.text = ADDON_NAME
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
        LibStub('NetEaseGUI-1.0'):CallWarningDialog(L['中立阵营不能使用集合石聊天'])
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
    LibStub('NetEaseGUI-1.0'):CallUrlDialog(url, L['发现集合石聊天新版本，您当前的版本不兼容，请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用'], 1)
end
