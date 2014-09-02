
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local MessageBox = CloudUI:NewModule(CreateFrame('Frame', nil, UIParent), 'MessageBox', 'AceEvent-3.0')

GUI:Embed(MessageBox, 'Refresh', 'Menu', 'Owner')

function MessageBox:OnInitialize()
    self:SetPoint('CENTER')
    self:SetSize(100, 100)
    self:SetFrameStrata('DIALOG')

    self:SetBackdrop{
        bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        edgeSize = 16, tileSize = 16, tile = true,
        insets = {left = 4, right = 4, top = 4, bottom = 4},
    }
    self:SetBackdropColor(0, 0, 0, 0.8)
    self:SetBackdropBorderColor(1, 1, 1, 0.8)
    self:SetClampedToScreen(true)

    local UnreadList = GUI:GetClass('GridView'):New(self)
    UnreadList:SetPadding(0, 0, 16, 0)
    UnreadList:SetSize(100, 100)
    UnreadList:SetPoint('TOPLEFT', 10, -10)
    UnreadList:SetItemClass(CloudUI:GetClass('MessageBoxItem'))
    UnreadList:SetItemHeight(16)
    UnreadList:SetAutoSize(true)
    UnreadList:SetRowCount(10)
    UnreadList:SetItemList(GetUnreadList())
    UnreadList:SetCallback('OnItemFormatted', function(frame, button, data)
        button:SetText(GetChatName(data.chatType, data.target))
        button:SetCount(GetChatUnread(data.chatType, data.target))
    end)
    UnreadList:SetCallback('OnRefresh', function()
        self:UpdateSize()
    end)
    UnreadList:SetScript('OnShow', function()
        self.JoinList:SetPoint('TOPLEFT', self.UnreadList, 'BOTTOMLEFT', 0, -10)
    end)
    UnreadList:SetScript('OnHide', function()
        self.JoinList:SetPoint('TOPLEFT', 10, -10)
    end)
    UnreadList:SetCallback('OnItemClick', function(_, _, data)
        CloudUI:ShowModule('ChatPanel', data.chatType, data.target)
    end)

    local label = UnreadList:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
    label:SetPoint('TOPLEFT')
    label:SetText(L['未读消息'])

    local JoinList = GUI:GetClass('GridView'):New(self)
    JoinList:SetPadding(0, 0, 16, 0)
    JoinList:SetSize(100, 100)
    JoinList:SetPoint('TOPLEFT', UnreadList, 'BOTTOMLEFT', 0, -10)
    JoinList:SetItemClass(CloudUI:GetClass('MessageBoxItem'))
    JoinList:SetItemHeight(16)
    JoinList:SetAutoSize(true)
    JoinList:SetRowCount(10)
    JoinList:SetItemList(GetJoinList())
    JoinList:SetCallback('OnItemFormatted', function(frame, button, data)
        button:SetText(GetChatGroupName(data.target))
        button:SetCount(data.count)
    end)
    JoinList:SetCallback('OnRefresh', function()
        self:UpdateSize()
    end)
    JoinList:SetCallback('OnItemClick', function(_, _, data)
        CloudUI:ShowModule('ManagePanel', data.target, 2)
        DeleteJoinList(data.target)
    end)

    local label = JoinList:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
    label:SetPoint('TOPLEFT')
    label:SetText(L['入群申请'])

    self.JoinLabel = JoinLabel
    self.JoinList = JoinList
    self.UnreadLabel = UnreadLabel
    self.UnreadList = UnreadList

    self:SetScript('OnShow', self.Refresh)

    self:RegisterMessage('NECLOUD_UNREAD_CHANGED', 'Refresh')
    self:RegisterMessage('NECLOUD_JOINLIST_CHANGED', 'Refresh')
end

function MessageBox:Update()
    local unreadCount = #GetUnreadList()
    local joinCount = #GetJoinList()

    if unreadCount > 0 then
        self.UnreadList:Show()
        self.UnreadList:Refresh()
    else
        self.UnreadList:Hide()
    end
    if joinCount > 0 then
        self.JoinList:Show()
        self.JoinList:Refresh()
    else
        self.JoinList:Hide()
    end
    if unreadCount == 0 and joinCount == 0 then
        self:Hide()
    end
end

function MessageBox:UpdateSize()
    local joinShown = self.JoinList:IsShown()
    local unreadShown = self.UnreadList:IsShown()

    local joinWidth = joinShown and self.JoinList:GetWidth() or 0
    local unreadWidth = unreadShown and self.UnreadList:GetWidth() or 0

    local width = max(joinWidth, unreadWidth, 100)
    local height = (#GetUnreadList() + #GetJoinList()) * 16 + 10 +
        (unreadShown and 26 or 0) +
        (joinShown and 26 or 0)

    self.JoinList:SetWidth(width)
    self.UnreadList:SetWidth(width)

    self:SetSize(width + 20, height)
end
