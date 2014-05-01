
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
        self:DeserializeCode(text)
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
    InGameButton:SetText(L['同时创建游戏内团队'])
    InGameButton:SetChecked(true)

    local Total = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    Total:SetPoint('BOTTOMRIGHT', -20, 15)

    local StartButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    StartButton:SetPoint('BOTTOM', 0, 12)
    StartButton:SetSize(120, 22)
    StartButton:SetText(L['开始邀请'])
    StartButton:Disable()
    StartButton:SetScript('OnClick', function()
        self:StartInvite()
    end)

    self.MemberList = MemberList
    self.StartButton = StartButton
    self.InGameButton = InGameButton
    self.Total = Total
    self.EventSummary = EventSummary
    self.WebCode = WebCode
    self.db = RaidBuilder:GetDB().profile.webInvite

    self:RegisterMessage('RAIDBUILDER_INVITE_STATUS_UPDATE', 'Refresh')

    if self:GetWebCode() and time() - self:GetWebCode().record < 3600 then
        self.WebCode:SetText(self:GetWebCode().code)
    else
        self.db.webCode = nil
    end
end

function WebInvitePanel:OnShow()
    local webCode = self:GetWebCode()
    if webCode and webCode ~= self.cache then
        self.WebCode:SetText(webCode)
    end
end

function WebInvitePanel:EnableButton(isEnable, text, clear)
    local StartButton = self.StartButton
    
    StartButton:SetEnabled(isEnable and not self.disableTimer)
    StartButton:SetText(text)
    if clear and self:GetList() then
        wipe(self:GetList())
        self:Refresh()
    end
end

function WebInvitePanel:GetCount()
    return self:GetList() and #self:GetList() or 0
end

function WebInvitePanel:DeserializeCode(text)
    if text == '' then
        self:EnableButton(false, L['开始邀请'], true)
        return
    end

    if text == self.cache and self:GetCount() > 0 then
        self:EnableButton(true, L['开始邀请'])
        return
    end

    self.cache = text

    local crc, base64 = text:match('^%s*([^%s]+)%s+([^%s]+)%s*$')

    if not (crc or base64) then
        self:EnableButton(false, L['组队码错误'], true)
        return
    end

    local data = LibStub('LibBase64-1.0'):DeCode(base64)

    if tonumber(crc, 16) ~= crc32(data) then
        self:EnableButton(false, L['组队码验证失败'], true)
        return
    end

    local lines = {('\r\n'):split(data)}

    if #lines < 2 then
        self:EnableButton(false, L['名单信息错误'], true)
        return
    end

    local eventid, eventcode = (','):split(lines[1])

    local list = {}
    local newbie = {}

    for i = 2, #lines do
        local info = {(','):split(lines[i])}
        if #info >= 3 then
            local data = {
                btag    = info[1],
                name    = info[2],
                realm   = info[3],
            }

            if info[4] then
                tinsert(newbie, data)
            end

            tinsert(list, data)
        end
    end

    self:SetEventId(tonumber(eventid))
    self:SetEventCode(tonumber(eventcode))
    self:SetNewbie(newbie)
    self:EnableButton(true, L['开始邀请'])
    self:SetList(list)
    self:SetWebCode(text)
end

function WebInvitePanel:SetWebCode(text)
    self.db.webCode = {code = text, record = time()}
end

function WebInvitePanel:GetWebCode()
    return self.db.webCode
end

function WebInvitePanel:SetNewbie(newbie)
    self.newbie = newbie
end

function WebInvitePanel:GetNewbie()
    return self.newbie
end

function WebInvitePanel:GetList()
    return self.MemberList:GetItemList()
end

function WebInvitePanel:SetEventId(id)
    self.db.eventID = id
end

function WebInvitePanel:GetEventId()
    return self.db.eventID
end

function WebInvitePanel:SetEventCode(code)
    self.db.eventCode = code

    local name = EVENT_NAMES[code]
    local text = name ~= UNKNOWN and format(L.WebInviteEventSummary, name, self:GetEventId()) or nil
    self.EventSummary:SetText(text)
    self.InGameButton:SetChecked(text)
    self.InGameButton:SetEnabled(text)
end

function WebInvitePanel:GetEventCode()
    return self.db.eventCode
end

function WebInvitePanel:SetList(list)
    self.MemberList:SetItemList(list)
    self:Refresh()
end

function WebInvitePanel:Refresh()
    local num = self:GetList() and #self:GetList() or 0
    self.Total:SetText(format(L['共 %d 人'], num))
    self.MemberList:Refresh()
end

function WebInvitePanel:StartInvite()
    local list = self:GetList()
    local ingame = self.InGameButton:GetChecked()

    if not list or #list == 0 then
        return System:Error(L['组队代码有误，请重试！'])
    end

    if ingame and EVENT_NAMES[self:GetEventCode()] ~= UNKNOWN then
        local CreatePanel = RaidBuilder:GetModule('CreatePanel')
        MainPanel:SelectPanel(CreatePanel)
        CreatePanel:QuickToggle(self.code, 1)
    end

    self:Invite()
end

function WebInvitePanel:OnDisableTimer()
    self.disableTimer = nil
    self:EnableButton(true, L['开始邀请'])
end

function WebInvitePanel:Invite()
    self:EnableButton(false, L['正在邀请'])
    self.disableTimer = self:ScheduleTimer('OnDisableTimer', 60)

    for i, v in ipairs(self:GetList()) do
        if v.status ~= INVITE_STATUS_JOINED then
            Invite:InviteMember(GetFullName(v.name, v.realm), v.btag, true)
        end
    end

    self.MemberList:Refresh()
end
