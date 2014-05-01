
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

GUI:GetClass('ControlButton'):RegisterStyle('Left', {
    NormalTexture    = [[Interface\AddOns\WowSocial_UI\Media\LeftButton-Up]],
    PushedTexture    = [[Interface\AddOns\WowSocial_UI\Media\LeftButton-Down]],
    -- DisableTexture   = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Disabled]],
    HighlightTexture = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
})
GUI:GetClass('ControlButton'):RegisterStyle('Right', {
    NormalTexture    = [[Interface\AddOns\WowSocial_UI\Media\RightButton-Up]],
    PushedTexture    = [[Interface\AddOns\WowSocial_UI\Media\RightButton-Down]],
    -- DisableTexture   = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Disabled]],
    HighlightTexture = [[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]],
})

local Frame = CreateFrame('Frame', nil, UIParent)
Frame:Hide()

local ChatPanel = CloudUI:NewModule(CreateFrame('Frame', nil, Frame), 'ChatPanel', 'AceEvent-3.0', 'AceHook-3.0', 'AceTimer-3.0')

local function OnDragStart()
    Frame:StartMoving()
end

local function OnDragStop()
    Frame:StopMovingOrSizing()
end

function ChatPanel:OnInitialize()
    self.chatOpened = {}
    self.hasRightPanel = true
    self.rightPanelShown = true

    self:InitControl()
    self:InitLeftPanel()
    self:InitRightPanel()

    self:RegisterMessage('NECLOUD_UNREAD_CHANGED', 'Refresh')
    self:RegisterMessage('CHAT_MSG_GROUP', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_JOIN', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_USER_LIST', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_MANAGER', 'Refresh')
    self:RegisterMessage('NECLOUD_EVENT_CACHE_UPDATE', 'Refresh')
    self:RegisterMessage('NECLOUD_EVENTLIST_UPDATE', 'Refresh')
    self:RegisterMessage('NECLOUD_USER_INFO', 'Refresh')
    self:RegisterMessage('NECLOUD_USER_STATUS', 'Refresh')

    self:RegisterMessage('NECLOUD_GROUP_KICK', 'NECLOUD_GROUP_LEAVE')
    self:RegisterMessage('NECLOUD_GROUP_LEAVE')
    self:RegisterMessage('NECLOUD_GROUP_DISBAND')

    self:RegisterMessage('NECLOUD_GROUP_INFO')

    self:RawHook('ChatEdit_InsertLink', true)
    self:RawHook('ChatEdit_GetActiveWindow', true)
end

function ChatPanel:ChatEdit_GetActiveWindow()
    if self.InputBox:HasFocus() then
        return self.InputBox
    end
    return self.hooks.ChatEdit_GetActiveWindow()
end

function ChatPanel:ChatEdit_InsertLink(text)
    if self.InputBox:HasFocus() then
        self.InputBox:Insert(text)
        return true
    end
    return self.hooks.ChatEdit_InsertLink(text)
end

function ChatPanel:NECLOUD_GROUP_INFO()
    if not self:IsShown() then
        return
    end
    self:SetAnnouncement(GetChatGroupInfo(self:GetChatTarget()).Announcement)
end

function ChatPanel:NECLOUD_GROUP_DISBAND(event, name, gid)
    self:CloseChat('GROUP', gid)
    self:Refresh()
end

function ChatPanel:NECLOUD_GROUP_LEAVE(event, name, gid, target)
    if not target then
        self:CloseChat('GROUP', gid)
    end
    self:Refresh()
end

function ChatPanel:FindOpened(chatType, target)
    for i, v in ipairs(self.chatOpened) do
        if chatType == v.chatType and target == v.target then
            return i
        end
    end
end

function ChatPanel:SetArguments(chatType, target)
    local index = self:FindOpened(chatType, target)
    if not index then
        tinsert(self.chatOpened, 1, { chatType = chatType, target = target })
        index = 1
    elseif index > self.ChatTab:GetShownCount() then
        tinsert(self.chatOpened, 1, (tremove(self.chatOpened, index)))
        index = 1
    end
    self.ChatTab:SetSelected(index)
end

function ChatPanel:CloseChat(chatType, target)
    local index = self:FindOpened(chatType, target)
    if index then
        self.ChatTab:CloseTab(index)
    end
end

function ChatPanel:SetChat(chatType, target)
    self.chatType = chatType
    self.target = target

    self.hasRightPanel = chatType == 'GROUP' and not IsChatGroupPublic(target)

    self:UpdateRightPanel()
    self:SetMessageList(GetChatLog(chatType, target))
    
    if self.hasRightPanel then
        self:SetAnnouncement(GetChatGroupInfo(target).Announcement)
        self:SetEventList(GetChatGroupEventList(target))
        self:SetMemberList(GetChatUserList(chatType, target))
    end
end

function ChatPanel:SetMessageList(list)
    self.MessageFrame:SetItemList(list)
    self.MessageFrame:ScrollToBottom()
end

function ChatPanel:SetMemberList(list)
    self.MemberList:SetItemList(list)
    self.MemberList:ScrollToTop()
end

function ChatPanel:SetEventList(list)
    self.EventList:SetItemList(list)
    self.EventList:ScrollToTop()
end

function ChatPanel:SetAnnouncement(text)
    self.AnnBox:SetText(text)
end

function ChatPanel:GetChatType()
    return self.chatType
end

function ChatPanel:GetChatTarget()
    return self.target
end

function ChatPanel:GetChat()
    return self.chatType, self.target
end

function ChatPanel:Refresh()
    self.ChatTab:Refresh()
    self.MemberList:Refresh()
    self.EventList:Refresh()
    self.MessageFrame:Refresh()
end

---- To Frame

function ChatPanel:Show()
    return Frame:Show()
end

function ChatPanel:Hide()
    return Frame:Hide()
end

function ChatPanel:SetShown(flag)
    return Frame:SetShown(flag)
end

function ChatPanel:IsShown()
    return Frame:IsShown()
end

function ChatPanel:IsVisible()
    return Frame:IsVisible()
end

---- Panel

function ChatPanel:InitRightPanel()
    local RightPanel = CreateFrame('Frame', nil, self)
    RightPanel:SetPoint('TOPRIGHT', -8, -38)
    RightPanel:SetPoint('BOTTOMRIGHT', -8, 7)
    RightPanel:SetWidth(160)
    RightPanel:Hide()
    RightPanel:SetScript('OnShow', function(frame)
        self.LeftPanel:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMLEFT')
    end)
    RightPanel:SetScript('OnHide', function()
        self.LeftPanel:SetPoint('BOTTOMRIGHT', -8, 7)
    end)
    
    local bg = RightPanel:CreateTexture(nil, 'BACKGROUND')
    bg:SetAllPoints(true)
    bg:SetTexture([[Interface\AddOns\WowSocial_UI\Media\ChatPanelBg.tga]])

    local label = RightPanel:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    label:SetPoint('TOPLEFT', 2, -2)
    label:SetText(L['群公告'])

    local ManageButton = CreateFrame('Button', nil, RightPanel)
    ManageButton:SetSize(16, 16)
    ManageButton:SetNormalTexture([[INTERFACE\Scenarios\ScenarioIcon-Interact]])
    ManageButton:SetHighlightTexture([[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]], 'ADD')
    ManageButton:SetPushedTexture([[INTERFACE\Scenarios\ScenarioIcon-Interact]])
    ManageButton:GetPushedTexture():ClearAllPoints()
    ManageButton:GetPushedTexture():SetPoint('CENTER', 1, -1)
    ManageButton:SetPoint('TOPRIGHT', -2, -2)
    ManageButton:SetScript('OnClick', function()
        CloudUI:ShowModule('ManagePanel', self:GetChatTarget())
    end)

    local AnnBox = GUI:GetClass('EditBox'):New(RightPanel)
    AnnBox:SetPoint('TOPLEFT', label, 'BOTTOMLEFT', 2, -2)
    AnnBox:SetPoint('RIGHT', -2, 0)
    AnnBox:SetHeight(80)
    AnnBox:SetReadOnly(true)
    AnnBox:SetPrompt(L['暂无公告'])

    local TabFrame = GUI:GetClass('TabView'):New(RightPanel)
    TabFrame:SetPoint('LEFT')
    TabFrame:SetPoint('RIGHT')
    TabFrame:SetPoint('TOP', AnnBox, 'BOTTOM')
    TabFrame:SetHeight(30)

    local MemberList = GUI:GetClass('ListView'):New(RightPanel)
    MemberList:SetPoint('TOPLEFT', TabFrame, 'BOTTOMLEFT', 2, -8)
    MemberList:SetPoint('BOTTOMRIGHT', -2, 2)
    MemberList:SetItemClass(CloudUI:GetClass('MemberButton'))
    MemberList:SetItemHeight(20)
    MemberList:SetItemSpacing(1)
    MemberList:Hide()
    MemberList:SetCallback('OnItemFormatted', function(frame, button, data)
        button:SetText(GetUserName(data.text))
        button:GetFontString():SetTextColor(GetUserNameColor(data.text, true))
        button:SetIcon(GetUserIcon(data.text))
        button:SetOfficeIcon(GetOfficeIcon(data.office))
        button:SetOnline(IsUserOnline(data.text))
    end)
    MemberList:SetCallback('OnItemMenu', function(frame, button, data)
        CloudUI:ToggleMemberMenu(button, self:GetChatTarget(), data.text)
    end)

    local EventList = GUI:GetClass('ListView'):New(RightPanel)
    EventList:SetPoint('TOPLEFT', TabFrame, 'BOTTOMLEFT', 2, -8)
    EventList:SetPoint('BOTTOMRIGHT', -2, 2)
    EventList:SetItemClass(CloudUI:GetClass('EventButton'))
    EventList:SetItemHeight(32)
    EventList:SetItemSpacing(1)
    EventList:Hide()
    EventList:SetCallback('OnItemFormatted', function(frame, button, data)
        button:SetData(data)
    end)
    EventList:SetCallback('OnItemClick', function(frame, button, data)
        OpenCalendarEvent(data.year, data.month, data.day, data.index)
    end)
    EventList:SetCallback('OnRefresh', function(frame)
        self.EventEmptyButton:SetShown(frame:GetItemCount() == 0)
    end)

    local EventEmptyButton = CreateFrame('Button', nil, EventList)
    EventEmptyButton:SetAllPoints(EventList)
    EventEmptyButton:Hide()
    EventEmptyButton:SetNormalFontObject('GameFontNormalSmall')
    EventEmptyButton:SetHighlightFontObject('GameFontHighlightSmall')
    EventEmptyButton:SetText(L['暂无群活动\n点击创建'])
    EventEmptyButton:SetScript('OnClick', function()
        ToggleCalendar()
    end)

    TabFrame:SetItemClass(GUI:GetClass('InTabButton'))
    TabFrame:SetItemList{
        {
            text = L['群成员'],
            Frame = MemberList,
        },
        {
            text = L['群活动'],
            Frame = EventList,
        },
    }
    TabFrame:EnableMenu(false)
    TabFrame:SetCallback('OnItemFormatted', function(frame, button, data)
        button:SetText(data.text)
    end)
    TabFrame:SetCallback('OnSelectChanged', function(frame, index)
        for i, v in ipairs(frame:GetItemList()) do
            v.Frame:SetShown(i == index)
        end
    end)

    local border = TabFrame:CreateTexture(nil, 'BACKGROUND')
    border:SetTexture([[Interface\DialogFrame\UI-DialogBox-Divider]])
    border:SetTexCoord(0, 0.75390625, 0, 0.5)
    border:SetHeight(16)
    border:SetPoint('BOTTOMLEFT', 0, -10)
    border:SetPoint('BOTTOMRIGHT', 0, -10)

    self.EventEmptyButton = EventEmptyButton
    self.RightPanel = RightPanel
    self.ManageButton = ManageButton
    self.AnnBox = AnnBox
    self.EventList = EventList
    self.MemberList = MemberList
end

function ChatPanel:InitLeftPanel()
    local LeftPanel = CreateFrame('Frame', nil, self)
    LeftPanel:SetPoint('TOPLEFT', 8, -38)
    LeftPanel:SetPoint('BOTTOMRIGHT', -8, 7)

    local bgMsg = CreateFrame('Frame', nil, LeftPanel)
    bgMsg:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 2, right = 2, top = 0, bottom = 0 },
        tileSize = 8, edgeSize = 12, tile = true
    }
    bgMsg:SetBackdropBorderColor(1, 1, 1, 0.8)
    bgMsg:SetBackdropColor(0, 0, 0, 0.8)
    bgMsg:SetPoint('TOPLEFT')
    bgMsg:SetPoint('BOTTOMRIGHT', 0, 40)

    local lineLeft = LeftPanel:CreateTexture(nil, 'OVERLAY')
    lineLeft:SetSize(32, 16)
    lineLeft:SetTexture([[Interface\DialogFrame\UI-DialogBox-Divider]])
    lineLeft:SetTexCoord(0, 0.125, 0, 0.5)
    lineLeft:SetPoint('LEFT', bgMsg, 'BOTTOMLEFT', -2, -1)

    local lineRight = LeftPanel:CreateTexture(nil, 'OVERLAY')
    lineRight:SetTexture([[Interface\DialogFrame\UI-DialogBox-Divider]])
    lineRight:SetTexCoord(0.62890625, 0.75390625, 0, 0.5)
    lineRight:SetSize(32, 16)
    lineRight:SetPoint('RIGHT', bgMsg, 'BOTTOMRIGHT', 0, -1)

    local lineMid = LeftPanel:CreateTexture(nil, 'OVERLAY')
    lineMid:SetTexture([[Interface\DialogFrame\UI-DialogBox-Divider]])
    lineMid:SetTexCoord(0.125, 0.62890625, 0, 0.5)
    lineMid:SetPoint('TOPLEFT', lineLeft, 'TOPRIGHT')
    lineMid:SetPoint('BOTTOMRIGHT', lineRight, 'BOTTOMLEFT')

    local MessageFrame = GUI:GetClass('ListView'):New(bgMsg)
    MessageFrame:SetPoint('TOPLEFT', 5, -5)
    MessageFrame:SetPoint('BOTTOMRIGHT', -5, 5)
    MessageFrame:SetItemClass(CloudUI:GetClass('MessageButton'))
    MessageFrame:SetItemHeight(54)
    MessageFrame:SetItemSpacing(2)
    MessageFrame:SetReverse(true)
    MessageFrame:EnableHoldTop(nil)
    MessageFrame:SetCallback('OnItemFormatted', function(_, button, data)
        local name, msg, stamp, status = UnpackChatLog(data)
        button:SetReverse(IsSelf(name))
        button:SetNameText(format('%s (%s)', GetUserColoredName(name), stamp))
        button:SetMsgText(FormatMessage(msg))
        button:SetIcon(GetUserIcon(name))
    end)
    MessageFrame:SetCallback('OnItemDoubleClick', function(_, button, data)
        local _, msg = UnpackChatLog(data)
        if strfind(msg, '%s*[^%s]+') then
            local inputBox = self.InputBox
            inputBox:SetFocus(false)
            inputBox:SetText(msg)
            inputBox:HighlightText()
        end
    end)
    MessageFrame:SetCallback('OnRefresh', function(frame)
        local unread = GetChatUnread(self:GetChat())
        if frame:AtBottom() then
            SetChatInRead(self:GetChat())
        else
            SetChatInRead()
        end
    end)
    MessageFrame:SetCallback('OnItemMenu', function(frame, button, data)
        local name, msg, stamp, status = UnpackChatLog(data)
        CloudUI:ToggleMemberMenu(button, self:GetChatTarget(), name, msg, stamp)
    end)
    MessageFrame:SetScript('OnHide', function()
        SetChatInRead()
    end)

    local bgInput = CreateFrame('Frame', nil, LeftPanel)
    bgInput:SetBackdrop{
        bgFile = [[INTERFACE\FriendsFrame\UI-Toast-Background]],
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 2, right = 2, top = 0, bottom = 0 },
        tileSize = 8, edgeSize = 12, tile=true
    }
    bgInput:SetBackdropBorderColor(1, 1, 1, 0.8)
    bgInput:SetPoint('BOTTOMLEFT')
    bgInput:SetPoint('TOPRIGHT', LeftPanel, 'BOTTOMRIGHT', 0, 38)

    local EmoteButton = CreateFrame('button', nil, bgInput)
    EmoteButton:SetPoint('LEFT', 5, 0)
    EmoteButton:SetSize(24, 24)
    EmoteButton:SetNormalTexture([[Interface\AddOns\WowSocial_UI\Media\Icon\text_nor_icon]])
    EmoteButton:SetPushedTexture([[Interface\AddOns\WowSocial_UI\Media\Icon\text_push_icon]])
    EmoteButton:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], 'ADD')
    EmoteButton:SetScript('OnClick', function(button)
        CloudUI.EmotePanel:Open(button, self.InputBox)
    end)

    local SendMsgButton = CreateFrame('button', nil, bgInput)
    SendMsgButton:SetPoint('RIGHT', -5, 0)
    SendMsgButton:SetSize(48, 24)
    SendMsgButton:SetNormalTexture([[Interface\AddOns\WowSocial_UI\Media\Icon\sendMsg_normal]])
    SendMsgButton:SetPushedTexture([[Interface\AddOns\WowSocial_UI\Media\Icon\sendMsg_push]])
    SendMsgButton:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], 'ADD')
    SendMsgButton:SetScript('OnClick', function()
        self:Send()
    end)

    local InputBox = CreateFrame('EditBox', nil, bgInput)
    InputBox:SetMaxBytes(255)
    InputBox:SetHistoryLines(16)
    InputBox:SetAltArrowKeyMode(false)
    InputBox:SetPoint('LEFT', EmoteButton, 'RIGHT', 2, 0)
    InputBox:SetPoint('RIGHT', SendMsgButton, 'LEFT', -2, 0)
    InputBox:SetPoint('TOP', bgInput, 'TOP', 0, 0)
    InputBox:SetPoint('BOTTOM', bgInput, 'BOTTOM', 0, 0)
    InputBox:SetAutoFocus(nil)
    InputBox:SetFontObject('ChatFontNormal')
    InputBox:SetTextInsets(8, 8, 8, 8)

    InputBox:SetScript('OnEscapePressed', function(self)
        self:SetText('')
        self:ClearFocus()
    end)
    InputBox:SetScript('OnEnterPressed', function()
        self:Send()
    end)

    if IsTrialAccount() then
        InputBox:SetText(L['|cffff0000试玩账号无法发送消息。|r'])
        InputBox:Disable()
        SendMsgButton:Disable()
        EmoteButton:Disable()
    end

    self.MessageFrame = MessageFrame
    self.InputBox = InputBox
    self.LeftPanel = LeftPanel
    self.bgMsg = bgMsg

    WorldFrame:HookScript('OnMouseDown', function()
        InputBox:ClearFocus()
    end)
end

function ChatPanel:Lock()
    self.locked = true
    self:ScheduleTimer('Unlock', 0.5)
end

function ChatPanel:Unlock()
    self.locked = false
end

function ChatPanel:IsLocked()
    return self.locked
end

function ChatPanel:Send()
    if self:IsLocked() then
        return
    end
    local msg = self.InputBox:GetText()
    if not msg:find('%S') then
        return
    end
    self.InputBox:AddHistoryLine(msg)
    self.InputBox:SetText('')
    SendChatMessage(msg, self:GetChat())
    self:Lock()
end

function ChatPanel:InitControl()
    Frame:SetPoint('CENTER')
    Frame:SetSize(544, 354)
    Frame:SetMinResize(350, 220)
    Frame:SetFrameStrata('MEDIUM')
    Frame:SetClampedToScreen(true)
    Frame:SetMovable(true)
    Frame:SetToplevel(true)

    GUI:RegisterUIPanel(Frame)

    self:RegisterForDrag('LeftButton')
    self:EnableMouse(true)
    self:SetAllPoints(Frame)
    self:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
        edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
        insets = { left = 8, right = 8, top = 8, bottom = 8 },
        tileSize = 24, edgeSize = 24, tile = true,
    }

    self:SetScript('OnDragStart', OnDragStart)
    self:SetScript('OnDragStop', OnDragStop)

    local ChatTab = GUI:GetClass('TabView'):New(self)
    ChatTab:SetHeight(30)
    ChatTab:SetPoint('TOPLEFT', 16, -8)
    ChatTab:SetPoint('TOPRIGHT', -50, -8)
    ChatTab:SetItemClass(CloudUI:GetClass('ChatTabButton'))
    ChatTab:SetItemList(self.chatOpened)
    ChatTab:SetCallback('OnItemFormatted', function(frame, button, data)
        button:SetText(GetChatName(data.chatType, data.target))
        button:SetUnread(GetChatUnread(data.chatType, data.target))
    end)
    ChatTab:SetCallback('OnSelectChanged', function(frame, index, data)
        self:SetChat(data.chatType, data.target)
    end)
    ChatTab:SetCallback('OnItemClosed', function(frame)
        if frame:GetItemCount() == 0 then
            self:Hide()
        end
    end)
    ChatTab:SetCallback('OnItemDragStart', function(frame)
        OnDragStart()
        frame.moving = true
    end)
    ChatTab:SetCallback('OnItemDragStop', function(frame)
        OnDragStop()
        frame.moving = nil
    end)
    ChatTab:SetCallback('OnRefresh', function(frame)
        local found = 0
        for i = frame:GetShownCount() + 1, frame:GetItemCount() do
            local data = frame:GetItem(i)
            if GetChatUnread(data.chatType, data.target) > 0 then
                found = 1
                break
            end
        end
        frame:GetMoreButton():SetUnread(found)
    end)
    local Refresh = ChatTab.Refresh
    function ChatTab:Refresh()
        if not self.moving then
            Refresh(self)
        end
    end

    local CloseButton = GUI:GetClass('ControlButton'):New(self, 'Close')
    CloseButton:SetPoint('TOPRIGHT', -10, -10)
    CloseButton:SetScript('OnClick', HideParentPanel)

    local MiniButton = GUI:GetClass('ControlButton'):New(self, 'Left')
    MiniButton:SetPoint('RIGHT', CloseButton, 'LEFT')
    MiniButton:SetScript('OnClick', function(_, button)
        if button == 'LeftButton' then
            self:ToggleRightPanel()
        else
        end
    end)

    local AutoAlphaButton = GUI:GetClass('CheckBox'):New(self)
    AutoAlphaButton:SetPoint('RIGHT', MiniButton, 'LEFT')
    AutoAlphaButton:SetSize(26, 26)
    AutoAlphaButton:SetScript('OnClick', function(AutoAlphaButton, button)
        if button == 'LeftButton' then
            self:SetAutoAlpha(AutoAlphaButton:GetChecked())
        end
    end)

    local ResizeButton = GUI:GetClass('ResizeButton'):New(Frame)
    ResizeButton:SetPoint('BOTTOMRIGHT', -5, 5)
    ResizeButton:SetFrameLevel(self:GetFrameLevel() + 5)

    self.MiniButton = MiniButton
    self.ChatTab = ChatTab

    -- WowSocialUI_OnShow_In(Frame)

    -- local close = CloseButton:GetScript('OnClick')
    -- CloseButton:SetScript('OnClick', function(self)
    --     WowSocialUI_OnShow_Out(self, close)
    -- end)
end

function ChatPanel:ToggleRightPanel()
    self.rightPanelShown = not self.rightPanelShown
    self:UpdateRightPanel()
    self:UpdateWidth()
    self:UpdateMiniButton()
end

function ChatPanel:UpdateRightPanel()
    if not self.hasRightPanel or not self.rightPanelShown then
        self.RightPanel:Hide()
    else
        self.RightPanel:Show()
    end
end

function ChatPanel:UpdateWidth()
    if self.rightPanelShown then
        -- Frame:SetWidth(self:GetWidth() + 160)
        -- Frame:SetMinResize(460, 235)
        Frame:SetMinResize(350, 220)
    else
        -- Frame:SetWidth(self:GetWidth() - 160)
        Frame:SetMinResize(200, 200)
    end
end

function ChatPanel:UpdateMiniButton()
    if self.rightPanelShown then
        self.MiniButton:SetStyle('Left')
    else
        self.MiniButton:SetStyle('Right')
    end
    if self.autoAlpha then
        self.MessageFrame:SetFrameLevel(self.bgMsg:GetFrameLevel() + 10)
    end
end

function ChatPanel:SetAutoAlpha(set)
    self.autoAlpha = set
    if set then
        self.MessageFrame:SetParent(UIParent)
        self.MessageFrame:SetFrameLevel(self.bgMsg:GetFrameLevel() + 10)
        self:SetAlpha(0.2)
        self:SetScript('OnHide', function()
            self.MessageFrame:SetParent(self.bgMsg)
        end)
        self:SetScript('OnShow', function()
            self:SetAutoAlpha(self.autoAlpha)
        end)
    else
        self.MessageFrame:SetParent(self.bgMsg)
        self:SetAlpha(1)
        self:SetScript('OnHide', nil)
        self:SetScript('OnShow', nil)
    end
end
