
BuildEnv(...)

local RolePanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, UIParent), 'RolePanel')

function RolePanel:OnInitialize()
    self:Hide()
    self:EnableMouse(true)
    self:SetSize(320, 240)
    self:SetFrameStrata('DIALOG')
    self:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
        edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
        insets = { left = 8, right = 8, top = 8, bottom = 8 },
        tileSize = 24, edgeSize = 24, tile = true,
    }

    local RoleList = GUI:GetClass('GridView'):New(self)
    RoleList:SetPoint('TOP', 0, -80)
    RoleList:SetSize(1, 1)
    RoleList:SetItemClass(RaidBuilder:GetClass('RoleCheckBox'))
    RoleList:SetAutoSize(true)
    RoleList:SetRowCount(1)
    RoleList:SetColumnCount(4)
    RoleList:SetItemWidth(50)
    RoleList:SetItemHeight(58)
    RoleList:SetItemSpacing(20)
    RoleList:SetSelectMode('RADIO')
    RoleList:SetItemList(RAID_ROLE_LIST)
    RoleList:SetCallback('OnItemFormatted', function(_, button, role)
        button:SetStyle(role)
        button:SetEnabled(self:IsRoleValid(role) and not self:IsRoleFull(role))
    end)
    RoleList:SetCallback('OnSelectChanged', function(_, index)
        self:UpdateAcceptButton()
    end)
    RoleList:SetCallback('OnItemEnter', function(frame, button, role)
        GameTooltip_SetDefaultAnchor(GameTooltip, button)
        GameTooltip:SetText(select(2, GetRoleInfo(role)), nil, nil, nil, nil, true)
        if not self:IsRoleValid(role) then
            GameTooltip:AddLine(L['你的等级、物品等级或职业不符合要求，不能选择该职责。'], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true)
        elseif self:IsRoleFull(role) then
            GameTooltip:AddLine(L['该职责已满，不能选择该职责。'], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true)
        end
        GameTooltip:Show()
    end)
    RoleList:SetCallback('OnItemLeave', function()
        GameTooltip:Hide()
    end)

    local Label = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
    Label:SetPoint('BOTTOM', RoleList, 'TOP', 0, 15)
    Label:SetText(L['请选择你的职责：'])

    local HelpButton = CreateFrame('Button', nil, self)
    HelpButton:SetPoint('BOTTOM', Label, 'TOP', 0, 10)
    HelpButton:SetPoint('LEFT')
    HelpButton:SetPoint('RIGHT')
    HelpButton:SetHeight(30)

    local Text = HelpButton:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('CENTER', -15, 0)

    local Icon = HelpButton:CreateTexture(nil, 'ARTWORK')
    Icon:SetTexture([[INTERFACE\Calendar\EventNotification]])
    Icon:SetSize(30, 30)
    Icon:SetPoint('LEFT', Text, 'RIGHT')

    HelpButton:SetFontString(Text)
    HelpButton:SetNormalFontObject('GameFontGreenSmall')
    HelpButton:SetHighlightFontObject('GameFontNormalSmall')
    HelpButton:SetText(L['想以后继续参加这个团长的活动吗'])
    HelpButton:SetScript('OnClick', function(button)
        local name, realm = strsplit('-', GetFullName(self.event:GetLeader()))
        RaidBuilder:ShowModule('YiXinSummary', name, realm)
        HideParentPanel(button)
    end)

    local Password = GUI:GetClass('InputBox'):New(self)
    Password:SetPoint('TOP', RoleList, 'BOTTOM', 0, -5)
    Password:SetSize(200, 26)
    Password:SetPrompt(L['请输入密码'])
    Password:SetMaxLetters(6)
    Password:SetScript('OnTextChanged', function()
        self:UpdateAcceptButton()
    end)

    local AcceptButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    AcceptButton:SetSize(120, 22)
    AcceptButton:SetPoint('BOTTOMRIGHT', self, 'BOTTOM', -5, 20)
    AcceptButton:SetText(OKAY)
    AcceptButton:SetScript('OnClick', function()
        self:Hide()
        self:AcceptOnClick()
        self.event = nil
    end)

    local CancelButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    CancelButton:SetSize(120, 22)
    CancelButton:SetPoint('BOTTOMLEFT', self, 'BOTTOM', 5, 20)
    CancelButton:SetText(CANCEL)
    CancelButton:SetScript('OnClick', function()
        self:Hide()
        self.event = nil
    end)

    local QuickMsg = GUI:GetClass('Dropdown'):New(self)
    QuickMsg:SetPoint('BOTTOM', 0, 45)
    QuickMsg:SetSize(205, 26)
    QuickMsg:SetMenuTable(QUICK_MSG_MENUTABLE)
    QuickMsg:SetDefaultText(L['你想对团长说什么？'])

    self.QuickMsg = QuickMsg
    self.AcceptButton = AcceptButton
    self.RoleList = RoleList
    self.Password = Password
    self.HelpButton = HelpButton

    self:SetScript('OnHide', StaticPopupSpecial_Hide)
end

function RolePanel:IsRoleValid(role)
    return self.event:IsRoleValid(role)
end

function RolePanel:IsRoleFull(role)
    return self.event:IsRoleFull(role)
end

local _ROLE_INDEXS = {
    TANK = 1,
    HEALER = 2,
    DAMAGER = 3,
    NONE = 4,
}

function RolePanel:GetCurrentRole()
    if self.event and not self.event:IsLevelValid() then
        return
    end
    local spec = GetSpecialization()
    if not spec then
        return
    end
    local role = select(6, GetSpecializationInfo(spec))
    if not role then
        return
    end
    if self:IsRoleValid(role) and not self:IsRoleFull(role) then
        return _ROLE_INDEXS[role]
    end

    if not self:IsRoleFull('NONE') then
        return _ROLE_INDEXS.NONE
    end
end

function RolePanel:SetArguments(callback, event)
    self.callback = callback
    self.event = event

    local hasPassword = event and event:GetHasPassword() or nil
    local isSelf = event and (event:IsSelf() or not event:GetLeader()) or nil
    local QuickMsg = event and EVENT_QUICK_MSG_MENUTABLE[event:GetEventMode()] or nil

    local height = 160
    if hasPassword then
        height = height + 30
    end
    if not isSelf then
        height = height + 30
        if QuickMsg then
            height = height + 26
        end
    end

    if isSelf then
        self.QuickMsg:Hide()
        self.HelpButton:Hide()
        self.RoleList:SetPoint('TOP', 0, -50)
    else
        if QuickMsg then
            self.QuickMsg:Show()
            self.QuickMsg:SetValue(nil)
        else
            self.QuickMsg:Hide()
        end
        self.HelpButton:Show()
        self.RoleList:SetPoint('TOP', 0, -80)

        GUI:SetTooltip(self.HelpButton, 'ANCHOR_BOTTOM',
            L['在|cff00ffff易信|r中关注Ta仅需两步：'],
            ' ',
            L['1.下载易信并关注公众号“|cffffd100魔兽世界|r”'],
            (L['2.向“|cffffd100魔兽世界|r”发送“|cffffd100关注%s@%s|r”即可']):format(strsplit('-', GetFullName(event:GetLeader()))),
            ' ',
            L['点击查看详细步骤'])
    end

    self.Password:SetShown(hasPassword)
    self.Password:SetText('')
    self:SetHeight(height)

    self.RoleList:SetSelected(self:GetCurrentRole())
    self.RoleList:Refresh()

    StaticPopupSpecial_Show(self)
end

function RolePanel:AcceptOnClick()
    local index = self.RoleList:GetSelected()
    if not index then
        return
    end
    local role = self.RoleList:GetItem(index)
    if not role then
        return
    end
    local password = self.Password:IsShown() and self.Password:GetNumber()
    local msgId = self.QuickMsg:IsShown() and self.QuickMsg:GetValue()

    self.callback(role, password, msgId)
end

function RolePanel:UpdateAcceptButton()
    self.AcceptButton:SetEnabled(self.RoleList:GetSelected() and
        (not self.Password:IsShown() or self.Password:GetText() ~= ''))
end
