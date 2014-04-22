--[[
    Calendar.lua
    Calendar Assistant
    ver        1.0.0
    author    s1172
    edit    2013-10-25 11:15:23
    change    
]]--

BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local CalendarPanel = CloudUI:NewModule(
    GUI:GetClass('TitlePanel'):New(UIParent), 'CalendarPanel',
    'AceEvent-3.0', 'AceHook-3.0')

local function IsTodayOrLaterButton(dayButton)
    local day = dayButton.day
    local monthOffset = dayButton.monthOffset
    local month, year = CalendarGetMonth(monthOffset)

    local presentWeekday, presentMonth, presentDay, presentYear = CalendarGetDate()
    local todayOrLater = false
    if year > presentYear then
        todayOrLater = true
    elseif year == presentYear then
        if month > presentMonth then
            todayOrLater = true
        elseif month == presentMonth then
            todayOrLater = day >= presentDay
        end
    end
    return todayOrLater
end

function CalendarPanel:OnInitialize()
    self:RegisterEvent('ADDON_LOADED', function(event, addon)
        if addon == 'Blizzard_Calendar' then
            self:UnregisterEvent('ADDON_LOADED')
            self:OnLoad()
            self:InitCreateEventFrame()
            self:InitCalendarFrame()
        end
    end)
end

function CalendarPanel:InitCalendarFrame()
    local CreateButton = CreateFrame('Button', nil, CalendarFrame, 'UIPanelButtonTemplate')
    CreateButton:SetSize(70, 22)
    CreateButton:SetText(CALENDAR_CREATE_EVENT)
    CreateButton:SetScript('OnClick', function(self)
        CalendarNewEvent()
        CalendarCreateEventFrame.mode = 'create'
        CalendarCreateEventFrame.dayButton = CalendarFrame.selectedDayButton
        CalendarFrame_ShowEventFrame(CalendarCreateEventFrame)
    end)

    self.CreateButton = CreateButton

    self:SecureHook('CalendarFrame_SetSelectedDay', 'UpdateCreateButton')
end

function CalendarPanel:InitCreateEventFrame()
    local GroupButton = CreateFrame('Button', nil, self:GetParent(), 'UIPanelButtonTemplate')
    GroupButton:SetPoint('BOTTOM', 17, 12)
    GroupButton:SetSize(110, 22)
    GroupButton:SetText(L['群邀请'])
    GroupButton:SetScript('OnClick', function()
        self:Show()
    end)

    local YixinButton = CreateFrame('Button', nil, self:GetParent(), 'CalendarClassButtonTemplate')
    YixinButton:SetPoint('BOTTOMLEFT', self:GetParent(), 'BOTTOMRIGHT', -2, 12)
    YixinButton:Enable()
    YixinButton:SetNormalTexture([[Interface\AddOns\WowSocial_UI\Media\YiXin]])
    YixinButton:SetScript('OnClick', function()
        CloudUI:ShowModule('YixinConfirm', self:GetConfirmError())
    end)
    YixinButton:SetScript('OnEnter', function(button)
        local gid = CalendarEventGetChatGroup()
        local info = gid and GetChatGroupInfo(gid)
        GameTooltip_SetDefaultAnchor(GameTooltip, button)
        GameTooltip:SetText(L['推送通知'])
        if info then
            GameTooltip:AddLine(L['群组：%s  关注号：%s']:format(info.Name , info.YiXin), 1, 1, 1)
        end
        GameTooltip:AddLine(L['每个群每周有五次发送活动通知的机会'], 1, 1, 1)
        GameTooltip:Show()
    end)
    YixinButton:SetScript('OnLeave', function()
        GameTooltip:Hide()
    end)
    local Shine = GUI:GetClass('ShineWidget'):New(YixinButton)
    Shine:SetAllPoints(YixinButton)
    Shine:Start()

    self.GroupButton = GroupButton
    self.YixinButton = YixinButton

    self:SecureHook('CalendarCreateEventFrame_Update', 'UpdateCreateEventFrame')
    self:SecureHook(CalendarCreateEventFrame, 'update', 'UpdateCreateEventFrame')
end

local function _IsCalendarEventPassed()
    local month, day, year, hour, minute = select(9, CalendarGetEventInfo())

    return time() > time{
        year = year,
        month = month,
        day = day,
        hour = hour,
        minute = minute,
    }
end

function CalendarPanel:GetConfirmError()
    local passed = _IsCalendarEventPassed()
    local gid = CalendarEventGetChatGroup()
    local isMember = gid and UserIsChatGroupMember(gid, PLAYER_NAME)
    local isOwner = gid and UserIsChatGroupOwner(gid, PLAYER_NAME)

    if not gid or not isMember then
        return false, L['这不是一个群活动']
    elseif not isOwner then
        return false, L['你不是该群的群主']
    elseif passed then
        return false, L['这个活动已经过期']
    elseif CalendarCreateEventFrame.mode == 'create' then
        return false, L['你还没有创建完成这个活动']
    end
    return true
end

function CalendarPanel:UpdateCreateEventFrame()
    self.GroupButton:SetShown(#GetChatGroupList() > 0)
end

function CalendarPanel:UpdateCreateButton(button)
    if IsTodayOrLaterButton(button) then
        self.CreateButton:Show()
        self.CreateButton:ClearAllPoints()
        self.CreateButton:SetPoint('TOP', button)
        self.CreateButton:SetFrameLevel(button:GetFrameLevel() + 6)
    else
        self.CreateButton:Hide()
    end
end

function CalendarPanel:OnLoad()
    self:SetText(L['群邀请'])
    self:Hide()
    self:SetParent(CalendarCreateEventFrame)
    self:SetFrameLevel(self:GetParent():GetFrameLevel() + 10)
    self:SetSize(320, 400)
    self:SetPoint('BOTTOMRIGHT', self:GetParent(), 'BOTTOMLEFT', 15, 0)
    self:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
        edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
        tileSize = 32, edgeSize = 32, tile = true,
    }

    local bottomBackground = self:CreateTexture(nil, 'ARTWORK')
    bottomBackground:SetTexture([[Interface\Buttons\UI-Button-Borders]])
    bottomBackground:SetTexCoord(0, 1.0, 0.59375, 1.0)
    bottomBackground:SetSize(256, 26)
    bottomBackground:SetPoint('BOTTOMLEFT', 11, 9)
    bottomBackground:SetPoint('BOTTOMRIGHT', -11, 9)

    -- menus

    local label = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    label:SetPoint('TOPLEFT', 20, -30)
    label:SetText(L['请选择群：'])

    local GroupSelector = GUI:GetClass('Dropdown'):New(self)
    GroupSelector:SetMenuTable(GetChatGroupList())
    GroupSelector:SetPoint('TOPLEFT', label, 'BOTTOMLEFT', 0, -5)
    GroupSelector:SetPoint('RIGHT', -20, 0)
    GroupSelector:SetHeight(25)
    GroupSelector:SetCallback('OnSelectChanged', function(_, data)
        self:SetChatGroup(data.target)
    end)

    local label = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    label:SetPoint('TOPLEFT', GroupSelector, 'BOTTOMLEFT', 0, -10)
    label:SetText(L['请选择成员：'])

    local MemberList = GUI:GetClass('GridView'):New(self)
    MemberList:SetPoint('TOPLEFT', label, 'BOTTOMLEFT', 0, -5)
    MemberList:SetPoint('BOTTOMRIGHT', -20, 45)
    MemberList:SetItemClass(CloudUI:GetClass('MemberButton'))
    MemberList:SetItemHeight(26)
    MemberList:SetItemSpacing(1)
    MemberList:SetAutoSize(true)
    MemberList:SetRowCount(9)
    MemberList:SetSelectMode('MULTI')
    MemberList:SetPadding(5)
    MemberList:SetColumnCount(1)
    MemberList:SetBackdrop{
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
        tileSize = 8, edgeSize = 8, tile = true,
    }
    MemberList:SetCallback('OnItemCreated', function(MemberList, button)
        button:SetBackdrop{bgFile = [[INTERFACE\BUTTONS\WHITE8X8]]}
        button:SetBackdropColor(0.2, 0.2, 0.2, 0.5)
    end)
    MemberList:SetCallback('OnItemFormatted', function(MemberList, button, data)
        button:SetText(GetUserName(data.text))
        button:GetFontString():SetTextColor(GetUserNameColor(data.text, true))
        button:SetIcon(GetUserIcon(data.text))
        button:SetOfficeIcon(GetOfficeIcon(data.office))
        button:SetOnline(IsUserOnline(data.text))
    end)

    -- control buttons

    local SelectAllButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    SelectAllButton:SetPoint('BOTTOM', -73, 12)
    SelectAllButton:SetSize(72, 22)
    SelectAllButton:SetText(L['全选'])
    SelectAllButton:SetScript('OnClick', function()
        MemberList:SelectAll(true)
    end)

    local UnSelectAllButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    UnSelectAllButton:SetPoint('LEFT', SelectAllButton, 'RIGHT', 2, 0)
    UnSelectAllButton:SetSize(72, 22)
    UnSelectAllButton:SetText(L['取消'])
    UnSelectAllButton:SetScript('OnClick', function()
        MemberList:SelectAll()
    end)

    local InviteButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    InviteButton:SetPoint('LEFT', UnSelectAllButton, 'RIGHT', 2, 0)
    InviteButton:SetSize(72, 22)
    InviteButton:SetText(L['邀请'])
    InviteButton:SetScript('OnClick', function()
        local list = self:GetSelectedList()
        if #list > 0 then
            GroupSelector:Disable()
            self:Pending(list)
            CalendarEventSetChatGroup(self:GetChatGroup())
        end
    end)

    -- blocker`s frame

    local BlockerFrame = CreateFrame('Frame', nil, self)
    BlockerFrame:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
        tileSize = 32, tile = true
    }
    BlockerFrame:EnableMouse(true)
    BlockerFrame:EnableMouseWheel(true)
    BlockerFrame:SetAllPoints(true)
    BlockerFrame:SetToplevel(true)
    BlockerFrame:SetScript('OnMouseWheel', function() end)
    BlockerFrame:Hide()

    local label = BlockerFrame:CreateFontString(nil, 'ARTWORK', 'QuestFont_Super_Huge')
    label:SetPoint('CENTER', 0, 10)
    label:SetText(L['邀请中，请稍候 '])

    local StatusBar = CreateFrame('StatusBar', nil, BlockerFrame)
    StatusBar:SetSize(248, 12)
    StatusBar:SetPoint('TOP', label, 'BOTTOM', 0, -10)

    local border = StatusBar:CreateTexture(nil, 'OVERLAY')
    border:SetTexture([[INTERFACE\PaperDollInfoFrame\UI-Character-Skills-BarBorder]])
    border:SetPoint('CENTER')

    StatusBar:SetStatusBarTexture([[INTERFACE\PaperDollInfoFrame\UI-Character-Skills-Bar]])
    StatusBar:SetStatusBarColor(0, 1, 0)

    local text = StatusBar:CreateFontString(nil, 'OVERLAY', 'TextStatusBarText')
    text:SetPoint('CENTER', 0, 2)

    StatusBar:SetScript('OnValueChanged', function(bar, value)
        local maxValue = select(2, bar:GetMinMaxValues())
        text:SetText(('%d / %d'):format(value, maxValue))
    end)

    self:SetScript('OnShow', function(self)
        CalendarFrame_PushModal(self)

        local gid = CalendarEventGetChatGroup()
        GroupSelector:SetEnabled(not gid)
        self:SetChatGroup(gid)
    end)

    self:SetScript('OnHide', function(self)
        self:Hide()
        self:SetScript('OnUpdate', nil)
        self.BlockerFrame:Hide()
        CalendarFrame_PopModal(self)
        GroupSelector:SetItem({})
        MemberList:SelectAll()
        MemberList:SetItemList({})

        self.gid = nil
    end)

    self.GroupSelector = GroupSelector
    self.MemberList = MemberList
    self.BlockerFrame = BlockerFrame
    self.StatusBar = StatusBar
end

function CalendarPanel:SetChatGroup(gid)
    if gid then
        if UserIsChatGroupMember(gid, PLAYER_NAME) then
            self.MemberList:SetItemList(GetChatGroupUserList(gid))
            self.MemberList:ScrollToTop()
            self.GroupSelector:SetText(GetChatGroupName(gid))
        else
            self.GroupSelector:SetText(L['你已退出这个群组'])
        end
    end
    self.gid = gid
end

function CalendarPanel:GetChatGroup()
    return self.gid
end

function CalendarPanel:GetSelectedList()
    local result = {}
    local selectedList = self.MemberList:GetSelected()
    local itemList = self.MemberList:GetItemList()

    for i in pairs(selectedList) do
        local info = itemList[i]
        if info then
            local name, realm, fullname, isSameRealm = GetUserNameInfo(info.text)
            tinsert(result, isSameRealm and name or fullname)
        end
    end
    return result
end

function CalendarPanel:SetBlocked(state)
    if state then
        self.BlockerFrame:Show()
    else
        self.BlockerFrame:Hide()
    end
end

function CalendarPanel:Pending(data)
    self.StatusBar:SetMinMaxValues(0, #data)
    self.StatusBar:SetValue(0)

    local index = 1
    local invited = self:GetInvitedList()
    self:SetScript('OnUpdate', function(self, elapsed)
        if CalendarCanSendInvite() then
            if data[index] then
                if not invited[data[index]] then
                    self:SetBlocked(true)
                    CalendarEventInvite(data[index])
                end
                self.StatusBar:SetValue(index)
                index = index + 1
            else
                self:SetScript('OnUpdate', nil)
                self:SetBlocked(false)
                CalendarCreateEventCreateButton_Update()
                self:PendingFinished()
            end
        end
    end)
end

function CalendarPanel:GetInvitedList()
    local numInvites, namesReady = CalendarEventGetNumInvites()
    local list = {}
    for i = 1, numInvites do
        local name = CalendarEventGetInvite(i)
        list[name] = true
    end
    return list
end

function CalendarPanel:PendingFinished()
    self:Hide()
end
