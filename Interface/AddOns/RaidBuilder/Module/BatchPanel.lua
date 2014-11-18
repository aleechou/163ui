
BuildEnv(...)

BatchPanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, BrowseParent), 'BatchPanel', 'AceEvent-3.0')

function BatchPanel:OnInitialize()
    GUI:Embed(self, 'Tab', 'Refresh')

    self:Hide()
    self:SetAllPoints(true)

    local function CheckInput()
        self:UpdateControl()
    end

    local BrowseButton = Button:New(self)
    BrowseButton:SetPoint('TOPRIGHT', MainPanel, 'TOPRIGHT', -94, -30)
    BrowseButton:SetText(L['返回列表'])
    BrowseButton:SetIcon([[Interface\ICONS\Achievement_Boss_CThun]])
    BrowseButton:SetTooltip(L['返回列表'])
    BrowseButton:SetScript('OnClick', function()
        BrowseParent:OpenBrowsePanel()
    end)

    local Label = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalHuge')
    Label:SetPoint('TOP', 0, -10)
    Label:SetText(L['快速申请'])

    local FilterLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    FilterLabel:SetPoint('TOPLEFT', 150, -60)
    FilterLabel:SetText(L['活动类型'])

    local Filter = GUI:GetClass('Dropdown'):New(self)
    Filter:SetPoint('LEFT', FilterLabel, 'RIGHT', 10, 0)
    Filter:SetSize(170, 26)
    Filter:SetMenuTable(EVENT_CREATE_MENUTABLE)
    Filter:SetDefaultText(L['请选择活动类型'])
    Filter:SetCallback('OnSelectChanged', function(_, data)
        self.Mode:SetMenuTable(GetEventModeMenuTable(data.value, true))
        self.Mode:SetValue(nil)
        self:UpdatePvPInput()
        self:UpdateControl()
    end)

    local ModeLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    ModeLabel:SetPoint('LEFT', Filter, 'RIGHT', 10, 0)
    ModeLabel:SetText(L['活动形式'])

    local Mode = GUI:GetClass('Dropdown'):New(self)
    Mode:SetPoint('LEFT', ModeLabel, 'RIGHT', 10, 0)
    Mode:SetSize(150, 26)
    Mode:SetMenuTable(EVENT_MODE_MENUTABLE)
    Mode:SetDefaultText(L['全部'])
    Mode:SetCallback('OnSelectChanged', CheckInput)

    local RoleLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    RoleLabel:SetPoint('TOPLEFT', FilterLabel, 'BOTTOMLEFT', 0, -20)
    RoleLabel:SetText(L['职责选择'])

    local RoleList = GUI:GetClass('GridView'):New(self)
    RoleList:SetPoint('TOP', 0, -130)
    RoleList:SetSize(1, 1)
    RoleList:SetItemClass(RaidBuilder:GetClass('RoleCheckBox'))
    RoleList:SetAutoSize(true)
    RoleList:SetRowCount(1)
    RoleList:SetColumnCount(4)
    RoleList:SetItemWidth(50)
    RoleList:SetItemHeight(58)
    RoleList:SetItemSpacing(80)
    RoleList:SetSelectMode('RADIO')
    RoleList:SetItemList(RAID_ROLE_LIST)
    RoleList:SetCallback('OnItemFormatted', function(_, button, role)
        button:SetStyle(role)
        button:SetEnabled(PlayerIsRoleValid(role))
    end)
    RoleList:SetCallback('OnSelectChanged', CheckInput)
    RoleList:SetCallback('OnItemEnter', function(frame, button, role)
        GameTooltip:SetOwner(button, 'ANCHOR_TOP')
        GameTooltip:SetText(select(2, GetRoleInfo(role)), nil, nil, nil, nil, true)
        if not PlayerIsRoleValid(role) then
            GameTooltip:AddLine(L['你的等级、物品等级或职业不符合要求，不能选择该职责。'], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true)
        end
        GameTooltip:Show()
    end)
    RoleList:SetCallback('OnItemLeave', function()
        GameTooltip:Hide()
    end)

    local MinLevelLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    MinLevelLabel:SetPoint('TOPLEFT', RoleLabel, 'BOTTOMLEFT', -50, -110)
    MinLevelLabel:SetText(L['角色等级'])

    local MinLevel = GUI:GetClass('InputBox'):New(self)
    MinLevel:SetPoint('LEFT', MinLevelLabel, 70, 0)
    MinLevel:SetSize(200, 15)
    MinLevel:SetNumeric(true)
    MinLevel:SetPrompt(L['最低角色等级要求'])
    MinLevel:SetCallback('OnTextChanged', CheckInput)
    GUI:SetTooltip(MinLevel, 'ANCHOR_TOP', L['只申请高于填写等级你能够加入的活动'])

    local PVPRatingLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    PVPRatingLabel:SetPoint('LEFT', MinLevelLabel, 310, 0)
    PVPRatingLabel:SetText(L['PVP 等级'])

    local PVPRating = GUI:GetClass('InputBox'):New(self)
    PVPRating:SetPoint('LEFT', PVPRatingLabel, 70, 0)
    PVPRating:SetSize(200, 15)
    PVPRating:SetNumeric(true)
    PVPRating:SetPrompt(L['最低PVP等级要求'])
    PVPRating:SetCallback('OnTextChanged', CheckInput)
    GUI:SetTooltip(PVPRating, 'ANCHOR_TOP', L['只申请高于填写PVP等级你能够加入的活动'])

    local ItemLevelLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    ItemLevelLabel:SetPoint('TOPLEFT', MinLevelLabel, 'BOTTOMLEFT', 0, -20)
    ItemLevelLabel:SetText(L['装备等级'])

    local ItemLevel = GUI:GetClass('InputBox'):New(self)
    ItemLevel:SetPoint('LEFT', ItemLevelLabel, 70, 0)
    ItemLevel:SetSize(200, 15)
    ItemLevel:SetNumeric(true)
    ItemLevel:SetPrompt(L['最低装备等级要求'])
    ItemLevel:SetCallback('OnTextChanged', CheckInput)
    GUI:SetTooltip(ItemLevel, 'ANCHOR_TOP', L['只申请高于填写装备等级你能够加入的活动'])

    local SearchLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    SearchLabel:SetPoint('LEFT', ItemLevelLabel, 310, 0)
    SearchLabel:SetText(L['说明匹配'])

    local SearchInput = GUI:GetClass('InputBox'):New(self)
    SearchInput:SetPoint('LEFT', SearchLabel, 70, 0)
    SearchInput:SetSize(150, 15)
    SearchInput:SetPrompt(L['设置匹配关键字'])
    SearchInput:SetCallback('OnTextChanged', CheckInput)
    GUI:SetTooltip(SearchInput, 'ANCHOR_TOP', L['指定加入活动说明内包含关键字的活动'])

    local NoMatch = GUI:GetClass('CheckBox'):New(self)
    NoMatch:SetPoint('LEFT', SearchInput, 'RIGHT', 3, 0)
    NoMatch:SetSize(20, 20)
    NoMatch:SetText(L['排除'])
    GUI:SetTooltip(NoMatch, 'ANCHOR_TOP', L['勾选此项则排除活动说明内包含关键字的活动'])

    local ScanButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    ScanButton:SetPoint('BOTTOM', MainPanel, 'BOTTOM', 0, 4)
    ScanButton:SetSize(120, 22)
    ScanButton:SetText(L['开始搜索'])
    ScanButton:SetScript('OnClick', function()
        self:ClearInputBoxFocus()
        self:Scan()
    end)

    local ErrorText = self:CreateFontString(nil, 'OVERLAY', 'GameFontRed')
    ErrorText:SetPoint('BOTTOM', ScanButton, 'TOP', 0, 10)

    local Blocker = CreateFrame('Frame', nil, self)
    Blocker:SetAllPoints(true)
    Blocker:SetFrameLevel(50)
    Blocker:EnableMouse(true)
    Blocker:EnableMouseWheel(true)
    Blocker:SetScript('OnMouseWheel', nop)

    local bg = Blocker:CreateTexture(nil, 'OVERLAY')
    bg:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
    bg:SetAllPoints(Blocker)

    local Text = Blocker:CreateFontString(nil, 'OVERLAY', 'QuestFont_Super_Huge')
    Text:SetPoint('CENTER')

    Blocker.Background = bg
    Blocker.Text = Text

    self.Filter = Filter
    self.Mode = Mode
    self.MinLevel = MinLevel
    self.PVPRating = PVPRating
    self.ItemLevel = ItemLevel
    self.SearchInput = SearchInput
    self.ErrorText = ErrorText
    self.NoMatch = NoMatch
    self.ScanButton = ScanButton
    self.RoleList = RoleList
    self.PVPRatingLabel = PVPRatingLabel
    self.Blocker = Blocker
    self.BrowseButton = BrowseButton

    self:RegisterInputBox(MinLevel)
    self:RegisterInputBox(PVPRating)
    self:RegisterInputBox(ItemLevel)
    self:RegisterInputBox(SearchInput)

    self:SetScript('OnShow', self.OnShow)

    self:RegisterEvent('GROUP_ROSTER_UPDATE', 'Refresh')
    self:RegisterMessage('RAIDBUILDER_CURRENT_EVENT_UPDATE', 'Refresh')
    self:RegisterMessage('RAIDBUILDER_BATCHAPPLY_STATUS_UPDATE', 'Refresh')
end

function BatchPanel:OnShow()
    self:UpdateInput()
    self:Refresh()
end

function BatchPanel:UpdateInput()
    if not BatchApply:IsWorking() then
        self.Filter:SetValue(nil)
        self.Mode:SetValue(nil)
        self.RoleList:SetSelected(nil)
        self.MinLevel:SetText('')
        self.ItemLevel:SetText('')
        self.PVPRating:SetText('')
        self.SearchInput:SetText('')
        self.NoMatch:SetChecked(false)
    else
        local profile = Profile:GetBatchApplyProfile()
        self.Filter:SetValue(profile.eventCode)
        self.Mode:SetValue(profile.eventMode)
        self.RoleList:SetSelectedItem(profile.role)
        self.MinLevel:SetText(profile.minLevel ~= 0 and profile.minLevel or '')
        self.ItemLevel:SetText(profile.itemLevel ~= 0 and profile.itemLevel or '')
        self.PVPRating:SetText(profile.pvpRating ~= 0 and profile.pvpRating or '')
        self.SearchInput:SetText(profile.search or '')
        self.NoMatch:SetChecked(profile.noMatch)
    end
end

function BatchPanel:UpdateControl()
    local isBatchWorking = BatchApply:IsWorking()
    local isBlock = EventCache:GetCurrentEvent() or UnitInGroup('player')
    local inputError = self:CheckError()

    self.ScanButton:SetText(isBatchWorking and L['停止搜索'] or L['开始搜索'])
    self.ScanButton:SetEnabled(not isBlock and not inputError)

    self.BrowseButton:SetEnabled(not isBatchWorking)

    if inputError then
        self.ErrorText:Show()
        self.ErrorText:SetText(inputError)
    else
        self.ErrorText:Hide()
    end
end

function BatchPanel:UpdateBlocker()
    if EventCache:GetCurrentEvent() then
        self:SetBlocker(L['你正在组织活动，不能快速申请'])
    elseif UnitInGroup('player') then
        self:SetBlocker(L['你正在队伍中，不能快速申请'])
    else
        self:SetBlocker(BatchApply:IsWorking())
    end
end

function BatchPanel:Update()
    self:UpdateBlocker()
    self:UpdateControl()
end

function BatchPanel:SetBlocker(text)
    if not text then
        self.Blocker:Hide()
    elseif text == true then
        self.Blocker.Text:Hide()
        self.Blocker.Background:Hide()
        self.Blocker:Show()
    else
        self.Blocker.Text:SetText(text)
        self.Blocker.Text:Show()
        self.Blocker.Background:Show()
        self.Blocker:Show()
    end
end

function BatchPanel:UpdatePvPInput()
    local eventCode = self.Filter:GetValue()
    if eventCode and eventCode ~= 0 and IsHasPVPRating(eventCode) then
        self.PVPRating:Enable()
        self.PVPRatingLabel:SetFontObject('GameFontHighlightSmall')
        self.PVPRating:SetPrompt(L['最低PVP等级要求'])
    else 
        self.PVPRating:Disable()
        self.PVPRating:SetText('')
        self.PVPRatingLabel:SetFontObject('GameFontDisableSmall')
        self.PVPRating:SetPrompt(L['这个活动不需要PVP等级'])
    end
end

function BatchPanel:CheckError()
    local eventCode = self.Filter:GetValue()
    if not eventCode or eventCode == 0 then
        return L['请选择活动类型']
    end

    local role = self.RoleList:GetSelectedItem()
    if not role then
        return L['你选择你要担任的职责']
    end

    local minLevel = self.MinLevel:GetNumber()
    if minLevel > UnitLevel('player') then
        return L['角色等级不能高于你当前的等级']
    end

    local pvpRating = self.PVPRating:GetNumber()
    if pvpRating > GetPlayerPVPRating(eventCode) then
        return L['PVP等级不能高于你当前的PVP等级']
    end

    local itemLevel = self.ItemLevel:GetNumber()
    if itemLevel > GetPlayerItemLevel() then
        return L['装备等级不能高于你当前的装备等级']
    end
end

function BatchPanel:Scan()
    if BatchApply:IsWorking() then
        BatchApply:Stop()
    else
        local eventCode = self.Filter:GetValue()
        local eventMode = self.Mode:GetValue()
        local role = self.RoleList:GetSelectedItem()
        local minLevel = self.MinLevel:GetNumber()
        local pvpRating = self.PVPRating:GetNumber()
        local itemLevel = self.ItemLevel:GetNumber()
        local search = self.SearchInput:GetText()
        local noMatch = self.NoMatch:GetChecked() and true or nil

        BatchApply:Start(eventCode, eventMode, role, minLevel, itemLevel, pvpRating, search, noMatch)
    end
end
