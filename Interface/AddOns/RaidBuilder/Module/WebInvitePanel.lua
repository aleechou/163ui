
BuildEnv(...)

local WebInvitePanel = RaidBuilder:NewModule(GUI:GetClass('TitlePanel'):New(UIParent), 'WebInvitePanel', 'AceTimer-3.0', 'AceEvent-3.0')

local BROAD_HEADER = {
    {
        key = 'B-Tag',
        text = L['战网昵称'],
        width = 130,
        style = 'LEFT',
        showHandler = function(data)
            return data.btag
        end,
    },
    {
        key = 'Character',
        text = L['角色名'],
        width = 130,
        style = 'LEFT',
        showHandler = function(data)
            return data.name
        end,
    },
    {
        key = 'Realm',
        text = L['服务器'],
        width = 100,
        style = 'LEFT',
        showHandler = function(data)
            return data.realm
        end,
    },
    {
        key = 'Status',
        text = L['邀请状态'],
        width = 100,
        style = 'LEFT',
        showHandler = function(data)
            local status = Invite:GetMemberStatus(GetFullName(data.name, data.realm), data.btag)
            data.status = status
            if status == INVITE_STATUS_JOINED then
                return INVITE_STATUS_NAMES[status], 0, 1, 0
            else
                return INVITE_STATUS_NAMES[status]
            end
        end,
    },
}

function WebInvitePanel:OnInitialize()
    self:Hide()
    self:SetSize(500, 500)
    self:SetPoint('CENTER')
    self:SetText(L['快捷邀请'])
    self:SetFrameStrata('DIALOG')

    local bottomBackground = self:CreateTexture(nil, 'ARTWORK')
    bottomBackground:SetTexture([[Interface\Buttons\UI-Button-Borders]])
    bottomBackground:SetTexCoord(0, 1.0, 0.59375, 1.0)
    bottomBackground:SetSize(256, 26)
    bottomBackground:SetPoint('BOTTOMLEFT', 11, 9)
    bottomBackground:SetPoint('BOTTOMRIGHT', -11, 9)

    local SummaryHtml = GUI:GetClass('SummaryHtml'):New(self)
    SummaryHtml:SetSize(460, 60)
    SummaryHtml:SetPoint('TOP', 0, -30)
    SummaryHtml:SetText(L.WebInviteSummaryHtml)

    local WebCode = GUI:GetClass('EditBox'):New(self)
    WebCode:SetPoint('TOPLEFT', SummaryHtml, 'BOTTOMLEFT', 0, -20)
    WebCode:SetPoint('TOPRIGHT', SummaryHtml, 'BOTTOMRIGHT', 0, -20)
    WebCode:SetHeight(60)
    WebCode:SetPrompt(L['请将网页上复制的组队代码粘贴在此'])
    WebCode:SetMaxLetters(nil)
    WebCode:SetCallback('OnTextChanged', function(_, text)
        self:OnCodeChanged(text)
    end)
    WebCode:SetScript('OnShow', function(WebCode)
        WebCode:SetText(WebSupport:GetWebCode())
    end)

    local MemberList = GUI:GetClass('DataGridView'):New(self)
    MemberList:SetPoint('TOPLEFT', WebCode, 'BOTTOMLEFT', 0, -50)
    MemberList:SetPoint('BOTTOMRIGHT', -10, 110)
    MemberList:SetItemHeight(30)
    MemberList:SetItemSpacing(3)
    MemberList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    MemberList:InitHeader(BROAD_HEADER)
    MemberList:SetHeaderPoint('BOTTOMLEFT', MemberList, 'TOPLEFT', 0, 0)
    MemberList:SetSortHandler(function(data)
        return data.status == INVITE_STATUS_JOINED and -1 or data.status or 0
    end)

    local EventSummary = GUI:GetClass('SummaryHtml'):New(self)
    EventSummary:SetSize(460, 30)
    EventSummary:SetPoint('BOTTOM', MemberList, 'TOP', 0, 10)

    local InGameButton = GUI:GetClass('CheckBox'):New(self)
    InGameButton:SetSize(20, 20)
    InGameButton:SetPoint('BOTTOMLEFT', 20, 40)
    InGameButton:SetText(L['跳转到创建活动页面创建游戏内团队'])
    InGameButton:SetChecked(true)

    local Total = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    Total:SetPoint('BOTTOMRIGHT', -20, 15)

    local StartButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    StartButton:SetPoint('BOTTOM', 0, 12)
    StartButton:SetSize(120, 22)
    StartButton:SetText(L['开始邀请'])
    -- StartButton:Disable()
    StartButton:SetScript('OnClick', function()
        self:StartInvite()
    end)

    self.MemberList = MemberList
    self.StartButton = StartButton
    self.InGameButton = InGameButton
    self.Total = Total
    self.EventSummary = EventSummary
    self.WebCode = WebCode

    self:RegisterMessage('RAIDBUILDER_INVITE_STATUS_UPDATE', 'Refresh')
    self:RegisterMessage('RAIDBUILDER_WEBSUPPORT_UPDATE', 'Refresh')
end

function WebInvitePanel:EnableButton(isEnable, text)
    local StartButton = self.StartButton
    
    StartButton:SetEnabled(isEnable and not self.disableTimer)
    StartButton:SetText(text)
end

function WebInvitePanel:OnCodeChanged(text)
    local ok, text, list, eventCode, eventId, eventSource, eventTime = WebSupport:SetInviteCode(text)

    self:SetEventInfo(eventCode, eventId, eventSource, eventTime)
    self:EnableButton(ok, text)
end

function WebInvitePanel:GetList()
    return self.MemberList:GetItemList()
end

function WebInvitePanel:GetEventId()
    return self.eventId
end

function WebInvitePanel:GetEventCode()
    return self.eventCode
end

function WebInvitePanel:SetEventInfo(eventCode, eventId, eventSource, eventTime)
    self.eventCode = eventCode
    self.eventId = eventId
    self.eventSource = eventSource
    self.eventTime = eventTime

    self.InGameButton:SetChecked(eventId)
    self.InGameButton:SetEnabled(eventId)

    if not eventId then
        self.EventSummary:SetText('')
    else
        self.EventSummary:SetText(L.WebInviteEventSummary:format(
            EVENT_NAMES[eventCode],
            date('%Y-%m-%d %H:%M', eventTime),
            GetWebEventUrl(eventId, eventSource)
        ))
    end
end

function WebInvitePanel:Refresh()
    local list = WebSupport:GetInviteList() or {}
    self.Total:SetText(format(L['共 %d 人'], #list))
    self.MemberList:SetItemList(list)
    self.MemberList:Refresh()
end

function WebInvitePanel:StartInvite()
    local list = self:GetList()
    local ingame = self.InGameButton:GetChecked()

    if not list or #list == 0 then
        return System:Error(L['组队代码有误，请重试！'])
    end

    local eventCode = self:GetEventCode()
    if ingame and EVENT_NAMES[eventCode] ~= UNKNOWN then
        local CreatePanel = RaidBuilder:GetModule('CreatePanel')
        MainPanel:SelectPanel(CreatePanel)
        CreatePanel:QuickToggle(self:GetEventCode(), 1)
    end

    self:Invite()
end

function WebInvitePanel:Invite()
    for i, v in ipairs(self:GetList()) do
        if v.status ~= INVITE_STATUS_JOINED then
            Invite:InviteMember(GetFullName(v.name, v.realm), v.btag, true)
        end
    end
end
