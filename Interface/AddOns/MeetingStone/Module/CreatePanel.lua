
BuildEnv(...)

CreatePanel = Addon:NewModule(CreateFrame('Frame', nil, ManagerPanel), 'CreatePanel', 'AceEvent-3.0')

local MAX_SUMMARY_LETTERS = 250
local MIN_PLAYER_LEVEL = 10

local DEFAULT_LOOT_LIST = {
    [4] = 4,
    [7] = 4,
    [8] = 4,
    [9] = 4,
    [10] = 4,
    ['6-0-17-5'] = 4,
    ['6-0-17-0'] = 4,
}

function CreatePanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    self:SetPoint('TOPLEFT')
    self:SetPoint('BOTTOMLEFT')
    self:SetWidth(219)

    local line = GUI:GetClass('VerticalLine'):New(self) do
        line:SetPoint('TOPLEFT', self, 'TOPRIGHT', -3, 5)
        line:SetPoint('BOTTOMLEFT', self, 'BOTTOMRIGHT', -3, -5)
    end
    -- view board
    local ViewBoardWidget = CreateFrame('Frame', nil, self) do
        ViewBoardWidget:SetAllPoints(true)
    end

    --- frames
    local InfoWidget = CreateFrame('Frame', nil, ViewBoardWidget) do
        InfoWidget:SetPoint('TOPLEFT')
        InfoWidget:SetSize(219, 100)

        local bg = InfoWidget:CreateTexture(nil, 'BACKGROUND', nil, 1)
        bg:SetPoint('TOPLEFT', -2, 2)
        bg:SetPoint('BOTTOMRIGHT', 2, 2)

        local icon = InfoWidget:CreateTexture(nil, 'ARTWORK')
        icon:SetTexture([[INTERFACE\GROUPFRAME\UI-GROUP-MAINTANKICON]])
        icon:SetPoint('TOPLEFT', 10, -8)
        icon:SetSize(16, 16)

        local title = InfoWidget:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLargeLeft')
        title:SetPoint('LEFT', icon, 'RIGHT', 3, 0)
        title:SetPoint('TOPRIGHT', -10, 0)
        title:SetHeight(40)

        local mode = InfoWidget:CreateTexture(nil, 'ARTWORK')
        mode:SetTexture([[INTERFACE\GROUPFRAME\UI-GROUP-MAINASSISTICON]])
        mode:SetPoint('BOTTOMLEFT', 10, 10)
        mode:SetSize(16, 16)
        local modeText = InfoWidget:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightLeft')
        modeText:SetPoint('LEFT', mode, 'RIGHT', 3, 0)
        modeText:SetWidth(60)

        local loot = InfoWidget:CreateTexture(nil, 'ARTWORK')
        loot:SetTexture([[INTERFACE\GROUPFRAME\UI-Group-MasterLooter]])
        loot:SetPoint('LEFT', modeText, 'RIGHT', 10, 0)
        loot:SetSize(16, 16)
        local lootText = InfoWidget:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightLeft')
        lootText:SetPoint('LEFT', loot, 'RIGHT', 3, 0)
        lootText:SetWidth(100)

        InfoWidget.Title = title
        InfoWidget.Mode = modeText
        InfoWidget.Loot = lootText
        InfoWidget.Background = bg
    end

    local MemberWidget = GUI:GetClass('TitleWidget'):New(ViewBoardWidget) do
        MemberWidget:SetPoint('TOPLEFT', InfoWidget, 'BOTTOMLEFT', 2, -3)
        MemberWidget:SetPoint('TOPRIGHT', InfoWidget, 'BOTTOMRIGHT', -2, -3)
        MemberWidget:SetHeight(70)

        local icon = MemberWidget:CreateTexture(nil, 'ARTWORK')
        icon:SetTexture([[INTERFACE\CHATFRAME\UI-ChatConversationIcon]])
        icon:SetPoint('TOPLEFT', 10, -5)
        icon:SetSize(16, 16)
        local text = MemberWidget:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLargeLeft')
        text:SetPoint('LEFT', icon, 'RIGHT', 3, 0)
        text:SetText(L['队伍配置'])

        local member = CreateFrame('Frame', nil, MemberWidget, 'LFGListGroupDataDisplayTemplate')
        member:SetPoint('TOPLEFT', icon, 'BOTTOMLEFT', 10, -10)
        member:SetSize(150, 20)

        MemberWidget.Member = member
        MemberWidget.Member.SetMember = function(self, activity)
            local activityID = activity:GetActivityID()
            if activityID then
                local data = GetGroupMemberCounts()
                data.DAMAGER = data.DAMAGER + data.NOROLE
                LFGListGroupDataDisplay_Update(self, activityID, data)
                return true
            end
        end
    end

    local MiscWidget = GUI:GetClass('TitleWidget'):New(ViewBoardWidget) do
        MiscWidget:SetPoint('TOPLEFT', MemberWidget, 'BOTTOMLEFT', 0, -3)
        MiscWidget:SetPoint('BOTTOMRIGHT', -2, 0)
        MiscWidget:SetHeight(150)

        local icon = MiscWidget:CreateTexture(nil, 'ARTWORK')
        icon:SetTexture([[INTERFACE\CHATFRAME\UI-ChatWhisperIcon]])
        icon:SetPoint('TOPLEFT', 10, -5)
        icon:SetSize(16, 16)
        local text = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLargeLeft')
        text:SetPoint('LEFT', icon, 'RIGHT', 3, 0)
        text:SetText(L['队伍需求'])

        local pvpRatingLabel = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLeft')
        pvpRatingLabel:SetPoint('BOTTOMLEFT', 20, 20)
        pvpRatingLabel:SetText(L['PvP 等级：'])
        local pvpRatingText = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightLeft')
        pvpRatingText:SetPoint('LEFT', pvpRatingLabel, 'RIGHT', 3, 0)

        local lvlLabel = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLeft')
        lvlLabel:SetPoint('BOTTOMLEFT', pvpRatingLabel, 'TOPLEFT', 0, 10)
        lvlLabel:SetText(L['角色等级：'])
        local lvlText = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightLeft')
        lvlText:SetPoint('LEFT', lvlLabel, 'RIGHT', 3, 0)

        local voiceLabel = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLeft')
        voiceLabel:SetPoint('BOTTOMLEFT', lvlLabel, 'TOPLEFT', 0, 10)
        voiceLabel:SetText(L['语音聊天：'])
        local voiceText = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightLeft')
        voiceText:SetPoint('LEFT', voiceLabel, 'RIGHT', 3, 0)

        local itemLevelLabel = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLeft')
        itemLevelLabel:SetPoint('BOTTOMLEFT', voiceLabel, 'TOPLEFT', 0, 10)
        itemLevelLabel:SetText(L['最低装等：'])
        local itemLevelText = MiscWidget:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightLeft')
        itemLevelText:SetPoint('LEFT', itemLevelLabel, 'RIGHT', 3, 0)
        itemLevelText:SetText('665')

        MiscWidget.Voice = voiceText
        MiscWidget.ItemLevel = itemLevelText
        MiscWidget.Level = lvlText
        MiscWidget.PvPRating = pvpRatingText
    end

    -- widgets
    local CreateWidget = CreateFrame('Frame', nil, self) do
        CreateWidget:SetAllPoints(true)
        CreateWidget:Hide()
    end

    --- options
    local ActivityOptions = GUI:GetClass('TitleWidget'):New(CreateWidget) do
        ActivityOptions:SetPoint('TOPLEFT')
        ActivityOptions:SetSize(219, 125)
        ActivityOptions:SetText(L['请选择活动属性'])
    end

    local ActivityType = GUI:GetClass('Dropdown'):New(ActivityOptions) do
        ActivityType:SetPoint('TOP', 0, -30)
        ActivityType:SetSize(170, 26)
        ActivityType:SetDefaultText(L['请选择活动类型'])
        ActivityType:SetMaxItem(20)
        ActivityType:SetCallback('OnSelectChanged', function(_, item)
            self.ActivityMode:SetMenuTable(ACTIVITY_MODE_MENUTABLES[item.categoryId])
            self.ActivityMode:SetValue(nil)
            self.ActivityLoot:SetValue(DEFAULT_LOOT_LIST[item.categoryId] or DEFAULT_LOOT_LIST[item.value])
            self:CheckOptions()
        end)
    end

    local ActivityMode = GUI:GetClass('Dropdown'):New(ActivityOptions) do
        ActivityMode:SetPoint('TOP', ActivityType, 'BOTTOM', 0, -5)
        ActivityMode:SetSize(170, 26)
        ActivityMode:SetMenuTable(ACTIVITY_MODE_MENUTABLE)
        ActivityMode:SetDefaultText(L['请选择活动形式'])
        ActivityMode:SetCallback('OnSelectChanged', function()
            self:CheckOptions()
        end)
    end

    local ActivityLoot = GUI:GetClass('Dropdown'):New(ActivityOptions) do
        ActivityLoot:SetPoint('TOP', ActivityMode, 'BOTTOM', 0, -5)
        ActivityLoot:SetSize(170, 26)
        ActivityLoot:SetMenuTable(ACTIVITY_LOOT_MENUTABLE)
        ActivityLoot:SetDefaultText(L['请选择分配方式'])
        ActivityLoot:SetCallback('OnSelectChanged', function()
            self:CheckOptions()
        end)
    end

    --- voice and item level
    local VoiceItemLevelWidget = GUI:GetClass('TitleWidget'):New(CreateWidget) do
        VoiceItemLevelWidget:SetPoint('TOPLEFT', ActivityOptions, 'BOTTOMLEFT', 0, -3)
        VoiceItemLevelWidget:SetPoint('TOPRIGHT', ActivityOptions, 'BOTTOMRIGHT', 0, -3)
        VoiceItemLevelWidget:SetSize(225, 110)
    end

    local ItemLevel = GUI:GetClass('InputBox'):New(VoiceItemLevelWidget) do
        ItemLevel:SetPoint('TOP', VoiceItemLevelWidget, 30, -5)
        ItemLevel:SetSize(108, 23)
        ItemLevel:SetNumeric(true)
        ItemLevel:SetLabel(L['最低装等'])
        ItemLevel:SetCallback('OnTextChanged', function(ItemLevel, userInput)
            if userInput then
                local value = tonumber(ItemLevel:GetText()) or 0
                local playerItemLevel = GetPlayerItemLevel()
                if value > playerItemLevel then
                    ItemLevel:SetText(playerItemLevel)
                end
                self:SetEditing(true)
            end
        end)
        self:RegisterInputBox(ItemLevel)
    end

    local VoiceBox = GUI:GetClass('InputBox'):New(VoiceItemLevelWidget) do
        VoiceBox:SetPoint('TOP', ItemLevel, 'BOTTOM', 0, -3)
        VoiceBox:SetSize(108, 23)
        VoiceBox:SetMaxLetters(31)
        VoiceBox:SetLabel(L['语音聊天'])
        VoiceBox:SetCallback('OnTextChanged', function(_, userInput)
            if userInput then
                self:SetEditing(true)
            end
        end)
        self:RegisterInputBox(VoiceBox)
    end

    local MinLevel = GUI:GetClass('InputBox'):New(VoiceItemLevelWidget) do
        MinLevel:SetPoint('TOPLEFT', VoiceBox, 'BOTTOMLEFT', 0, -3)
        MinLevel:SetSize(48, 23)
        MinLevel:SetMaxLetters(3)
        MinLevel:SetLabel(L['角色等级'])
        MinLevel:SetNumeric(true)
        MinLevel:SetCallback('OnTextChanged', function(_, userInput)
            if userInput then
                if MinLevel:GetNumber() > MAX_PLAYER_LEVEL then
                    MinLevel:SetNumber(MAX_PLAYER_LEVEL)
                end
                self:SetEditing(true)
                self:UpdateSummaryMaxLetters()
            end
        end)
        self:RegisterInputBox(MinLevel)
    end

    local MaxLevel = GUI:GetClass('InputBox'):New(VoiceItemLevelWidget) do
        MaxLevel:SetPoint('TOPRIGHT', VoiceBox, 'BOTTOMRIGHT', 0, -3)
        MaxLevel:SetSize(48, 23)
        MaxLevel:SetMaxLetters(3)
        MaxLevel:SetLabel('-', nil, 1)
        MaxLevel:SetNumeric(true)
        MaxLevel:SetCallback('OnTextChanged', function(_, userInput)
            if userInput then
                if MaxLevel:GetNumber() > MAX_PLAYER_LEVEL then
                    MaxLevel:SetNumber(MAX_PLAYER_LEVEL)
                end
                self:SetEditing(true)
                self:UpdateSummaryMaxLetters()
            end
        end)
        self:RegisterInputBox(MaxLevel)
    end

    local PvPRating = GUI:GetClass('InputBox'):New(VoiceItemLevelWidget) do
        PvPRating:SetPoint('TOPLEFT', MinLevel, 'BOTTOMLEFT', 0, -3)
        PvPRating:SetSize(108, 23)
        PvPRating:SetLabel(L['PVP 等级'])
        PvPRating:SetMaxLetters(4)
        PvPRating:SetNumeric(true)
        PvPRating:SetCallback('OnTextChanged', function(_, userInput)
            if userInput then
                self:SetEditing(true)
                self:UpdateSummaryMaxLetters()
            end
        end)
        self:RegisterInputBox(PvPRating)
    end

    --- summary
    local SummaryWidget = GUI:GetClass('TitleWidget'):New(CreateWidget) do
        SummaryWidget:SetPoint('TOPRIGHT', VoiceItemLevelWidget, 'BOTTOMRIGHT', 0, -3)
        SummaryWidget:SetPoint('TOPLEFT', VoiceItemLevelWidget, 'BOTTOMLEFT', 0, -3)
        SummaryWidget:SetPoint('BOTTOM')
        SummaryWidget:SetText(L['活动说明'])
    end

    local SummaryBox = GUI:GetClass('EditBox'):New(SummaryWidget) do
        SummaryBox:SetPrompt(L['请在这里输入活动说明'])
        SummaryWidget:SetObject(SummaryBox)
        SummaryBox:SetCallback('OnTextChanged', function(_, userInput)
            if userInput then
                self:SetEditing(true)
            end
        end)
        self:RegisterInputBox(SummaryBox:GetEditBox())
    end

    -- buttons
    local CreateButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate') do
        CreateButton:SetPoint('BOTTOM', ManagerPanel:GetOwner(), 'BOTTOM', -60, 4)
        CreateButton:SetSize(120, 22)
        CreateButton:SetText(L['创建活动'])
        CreateButton:Disable()
        CreateButton:SetScript('OnClick', function(CreateButton)
            self:CreateActivity()
        end)
    end

    local DisbandButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate') do
        DisbandButton:SetPoint('BOTTOM', ManagerPanel:GetOwner(), 'BOTTOM', 60, 4)
        DisbandButton:SetSize(120, 22)
        DisbandButton:SetText(L['解散活动'])
        DisbandButton:Disable()
        DisbandButton:SetScript('OnClick', function()
            self:DisbandActivity()
        end)
    end

    local CreateHelpPlate do
        CreateHelpPlate = {
            FramePos = { x = -10,          y = 55 },
            FrameSize = { width = 830, height = 415 },
            {
                ButtonPos = { x = 755, y = 10 },
                HighLightBox = { x = 735, y = 5, width = 95, height = 35 },
                ToolTipDir = 'DOWN',
                ToolTipText = L.CreateHelpRefresh,
            },
            {
                ButtonPos = { x = 400,  y = -170 },
                HighLightBox = { x = 230, y = -35, width = 600, height = 350 },
                ToolTipDir = 'RIGHT',
                ToolTipText = L.CreateHelpList,
            },
            {
                ButtonPos = { x = 90,  y = -80 },
                HighLightBox = { x = 5, y = -35, width = 220, height = 150 },
                ToolTipDir = 'UP',
                ToolTipText = L.CreateHelpOptions,
            },
            {
                ButtonPos = { x = 90,  y = -220 },
                HighLightBox = { x = 5, y = -190, width = 220, height = 195 },
                ToolTipDir = 'UP',
                ToolTipText = L.CreateHelpSummary,
            },
            {
                ButtonPos = { x = 370,  y = -380 },
                HighLightBox = { x = 280, y = -390, width = 270, height = 28 },
                ToolTipDir = 'UP',
                ToolTipText = L.CreateHelpButtons,
            },
        }
        MainPanel:AddHelpButton(CreateWidget, CreateHelpPlate)
    end

    local ViewHelpPlate do
        ViewHelpPlate = {
            FramePos = { x = -10,          y = 55 },
            FrameSize = { width = 830, height = 415 },
            {
                ButtonPos = { x = 755, y = 10 },
                HighLightBox = { x = 735, y = 5, width = 95, height = 35 },
                ToolTipDir = 'DOWN',
                ToolTipText = L.CreateHelpRefresh,
            },
            {
                ButtonPos = { x = 400,  y = -170 },
                HighLightBox = { x = 230, y = -35, width = 600, height = 350 },
                ToolTipDir = 'RIGHT',
                ToolTipText = L.CreateHelpList,
            },
            {
                ButtonPos = { x = 90,  y = -80 },
                HighLightBox = { x = 5, y = -35, width = 220, height = 120 },
                ToolTipDir = 'UP',
                ToolTipText = L.ViewboardHelpOptions,
            },
            {
                ButtonPos = { x = 90,  y = -220 },
                HighLightBox = { x = 5, y = -160, width = 220, height = 225 },
                ToolTipDir = 'UP',
                ToolTipText = L.ViewboardHelpSummary,
            },
            {
                ButtonPos = { x = 370,  y = -380 },
                HighLightBox = { x = 280, y = -390, width = 270, height = 28 },
                ToolTipDir = 'UP',
                ToolTipText = L.CreateHelpButtons,
            },
        }
        MainPanel:AddHelpButton(ViewBoardWidget, ViewHelpPlate)
    end

    self.VoiceBox = VoiceBox
    self.ItemLevel = ItemLevel
    self.SummaryBox = SummaryBox:GetEditBox()
    self.CreateButton = CreateButton
    self.DisbandButton = DisbandButton
    self.ActivityType = ActivityType
    self.ActivityMode = ActivityMode
    self.ActivityLoot = ActivityLoot
    self.MinLevel = MinLevel
    self.MaxLevel = MaxLevel
    self.PvPRating = PvPRating

    self.ViewBoardWidget = ViewBoardWidget
    self.InfoWidget = InfoWidget
    self.MemberWidget = MemberWidget
    self.MiscWidget = MiscWidget
    self.CreateWidget = CreateWidget

    self:RegisterEvent('LFG_LIST_ACTIVE_ENTRY_UPDATE', 'ActivityUpdated')
    self:RegisterEvent('LFG_LIST_ENTRY_CREATION_FAILED', 'ActivityUpdated', false, true)
    self:RegisterEvent('LFG_LIST_AVAILABILITY_UPDATE', 'UpdateMenu')

    self:RegisterMessage('MEETINGSTONE_PERMISSION_UPDATE', function(_, canCreate)
        self:SetWidgetEnabled(canCreate)
    end)

    self:SetScript('OnShow', self.OnShow)
end

function CreatePanel:ShowViewboard(enable)
    local activity = self:IsActivityCreated()

    if enable and activity then
        self.ViewBoardWidget:Show()
        self.CreateWidget:Hide()

        local activityType = self.ActivityType:GetItem()
        local activityMode = self.ActivityMode:GetItem()
        local activityLoot = self.ActivityLoot:GetItem()

        self.InfoWidget.Title:SetText(activityType and activityType.text or UNKNOWN)
        self.InfoWidget.Mode:SetText(activityMode and activityMode.text or UNKNOWN)
        self.InfoWidget.Loot:SetText(activityLoot and activityLoot.text or UNKNOWN)

        self.MemberWidget.Member:SetShown(self.MemberWidget.Member:SetMember(activity))

        self.MiscWidget.Voice:SetText(activity:GetActivityVoice())
        self.MiscWidget.ItemLevel:SetText(activity:GetActivityItemLevel())
        self.MiscWidget.Level:SetFormattedText(activity:GetMinLevel() ~= activity:GetMaxLevel() and '%s~%s' or '%s', activity:GetMinLevel(), activity:GetMaxLevel())
        self.MiscWidget.PvPRating:SetText(activity:GetPvPRating())

        local fullName, shortName, categoryID, groupID, iLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activity:GetActivityID())
        --Set the background
        local atlasName = nil
        if separateRecommended and bit.band(filters, LE_LFG_LIST_FILTER_RECOMMENDED) ~= 0 then
            atlasName = 'groupfinder-background-'..(LFG_LIST_CATEGORY_TEXTURES[categoryID] or 'raids')..'-'..LFG_LIST_PER_EXPANSION_TEXTURES[LFGListUtil_GetCurrentExpansion()]
        elseif separateRecommended and bit.band(filters, LE_LFG_LIST_FILTER_NOT_RECOMMENDED) ~= 0 then
            atlasName = 'groupfinder-background-'..(LFG_LIST_CATEGORY_TEXTURES[categoryID] or 'raids')..'-'..LFG_LIST_PER_EXPANSION_TEXTURES[math.max(0,LFGListUtil_GetCurrentExpansion() - 1)]
        else
            atlasName = 'groupfinder-background-'..(LFG_LIST_CATEGORY_TEXTURES[categoryID] or 'questing')
        end

        local suffix = ''
        if bit.band(filters, LE_LFG_LIST_FILTER_PVE) ~= 0 then
            suffix = '-pve'
        elseif bit.band(filters, LE_LFG_LIST_FILTER_PVP) ~= 0 then
            suffix = '-pvp'
        end

        --Try with the suffix and then without it
        if not self.InfoWidget.Background:SetAtlas(atlasName..suffix, true) then
            self.InfoWidget.Background:SetAtlas(atlasName, true)
        end

    else
        self.ViewBoardWidget:Hide()
        self.CreateWidget:Show()
    end
end

function CreatePanel:CreateActivity()
    self:ClearInputBoxFocus()
    self:SetEditing(false)

    local activityType = self.ActivityType:GetItem()
    local activityMode = self.ActivityMode:GetItem()
    local activityLoot = self.ActivityLoot:GetItem()

    local minLevel = self.MinLevel:GetNumber()
    local maxLevel = self.MaxLevel:GetNumber()
    local pvpRating = self.PvPRating:GetNumber()

    local activity = CurrentActivity:New({
        ActivityID = activityType.activityId,
        ActivityType = activityType.customId or 0,
        ActivityTypeText = activityType.text,

        ActivityMode = activityMode.value,
        ActivityModeText = activityMode.text,

        ActivityLoot = activityLoot.value,
        ActivityLootText = activityLoot.text,

        ActivityVoice = self.VoiceBox:GetText(),
        ActivityItemLevel = self.ItemLevel:GetNumber(),
        ActivitySummary = self.SummaryBox:GetText(),

        MinLevel = minLevel > 0 and minLevel or nil,
        MaxLevel = maxLevel > 0 and maxLevel or nil,
        PvPRating = pvpRating > 0 and pvpRating or nil,
    })

    local handler = self:IsActivityCreated() and C_LFGList.UpdateListing or C_LFGList.CreateListing

    if handler(activity:GetCreateArguments()) then
        self.CreateButton:Disable()
        Profile:SaveActivityProfile(activity)
        self:SendMessage('MEETINGSTONE_CREATING_ACTIVITY', true)
        if handler == C_LFGList.CreateListing then
            Logic:SEI(activity)
        end
    else
        self:ActivityUpdated(nil, nil, true)
    end
end

function CreatePanel:SetEditing(enable)
    self.editMode = enable
end

function CreatePanel:IsEditing()
    return self.editMode
end

function CreatePanel:DisbandActivity()
    if not IsGroupLeader() then
        return
    end

    self:SetEditing(false)
    C_LFGList.RemoveListing()
    self:SetWidgetEnabled(true)
end

function CreatePanel:ClearAllContent()
    self.VoiceBox:SetText('')
    self.ItemLevel:SetNumber(0)
    self.SummaryBox:SetText('')
    self.MinLevel:SetNumber(10)
    self.MaxLevel:SetNumber(100)
    self.PvPRating:SetNumber(0)
    self.ActivityType:SetValue(nil)
    self.ActivityMode:SetValue(nil)
    self.ActivityLoot:SetValue(nil)
end

function CreatePanel:OnShow()
    self:ActivityUpdated()
end

function CreatePanel:UpdateMenu()
    self.ActivityType:SetMenuTable(GetActivitesMenuTable(true))
    self:ActivityUpdated()
end

function CreatePanel:CheckOptions()
    local enable = self.ActivityType:GetValue() and self.ActivityMode:GetValue() and self.ActivityLoot:GetValue()

    self.VoiceBox:SetEnabled(enable)
    self.ItemLevel:SetEnabled(enable)
    self.SummaryBox:SetEnabled(enable)
    self.CreateButton:SetEnabled(enable)
    self.MinLevel:SetEnabled(enable)
    self.MaxLevel:SetEnabled(enable)
    self.PvPRating:SetEnabled(enable)

    local activityType = self.ActivityType:GetItem()
    local enablePvPRating = enable and IsHasPVPRating(activityType.activityId)
    self.PvPRating:SetEnabled(enablePvPRating)

    if enable and not self:IsEditing() and not self:IsActivityCreated() then
        local activity, voice = Profile:GetActivityProfile(activityType.text)
        local iLvl, summary, minLvl, maxLvl, pvpRating = 0, '', 10, 100, 0

        if activity then
            activity = CurrentActivity:New(activity)
            iLvl = activity:GetActivityItemLevel()
            summary = activity:GetActivitySummary()
            minLvl = activity:GetMinLevel()
            maxLvl = activity:GetMaxLevel()
            pvpRating = activity:GetPvPRating()
        else
            local fullName, shortName, categoryID, groupID, iLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityType.activityId)
            iLvl = min(iLevel, GetPlayerItemLevel())
            minLvl = minLevel == 0 and MIN_PLAYER_LEVEL or minLevel
            maxLvl = MAX_PLAYER_LEVEL
        end

        self.VoiceBox:SetText(voice)
        self.ItemLevel:SetText(iLvl)
        self.SummaryBox:SetText(summary)
        self.MinLevel:SetText(minLvl)
        self.MaxLevel:SetText(maxLvl)
        self.PvPRating:SetText(pvpRating)
        self:UpdateSummaryMaxLetters()
    end
end

function CreatePanel:SetWidgetEnabled(canCreate)
    if not canCreate then
        self:SetEditing(false)
    end

    self.ActivityType:SetEnabled(canCreate)
    self.ActivityMode:SetEnabled(canCreate)
    self.ActivityLoot:SetEnabled(canCreate)

    local activity = self:IsActivityCreated()

    self.VoiceBox:SetEnabled(canCreate and activity)
    self.ItemLevel:SetEnabled(canCreate and activity)
    self.SummaryBox:SetEnabled(canCreate and activity)
    self.MinLevel:SetEnabled(canCreate and activity)
    self.MaxLevel:SetEnabled(canCreate and activity)
    self.PvPRating:SetEnabled(canCreate and activity)

    if activity then
        self:ActivityUpdated()
    end
end

function CreatePanel:IsActivityCreated()
    return self.Activity
end

function CreatePanel:ActivityUpdated(_, createNew, createFailed)
    local activity = self:GetCurrentActivity()
    local isLeader = IsGroupLeader()

    self.CreateButton:SetEnabled(isLeader)

    if activity then

        local byAddon = activity:GetIsMeetingStone()

        self.ActivityType:SetValue(GetActivityCode(activity:GetActivityID(), activity:GetActivityType()))
        self.ActivityMode:SetValue(byAddon and activity:GetActivityMode() or L['未指定'])
        self.ActivityLoot:SetValue(byAddon and activity:GetActivityLoot() or L['未指定'])

        self.ActivityType:Disable()
        self.ActivityMode:Disable()
        self.ActivityLoot:Disable()

        self.VoiceBox:SetText(activity:GetActivityVoice())
        self.ItemLevel:SetText(activity:GetActivityItemLevel())
        self.SummaryBox:SetText(activity:GetActivitySummary())
        self.MinLevel:SetText(activity:GetMinLevel())
        self.MaxLevel:SetText(activity:GetMaxLevel())
        self.PvPRating:SetText(activity:GetPvPRating())

        self.VoiceBox:SetEnabled(isLeader)
        self.ItemLevel:SetEnabled(isLeader)
        self.SummaryBox:SetEnabled(isLeader)
        self.MinLevel:SetEnabled(isLeader)
        self.MaxLevel:SetEnabled(isLeader)
        self.PvPRating:SetEnabled(isLeader and IsHasPVPRating(activity:GetActivityID()))

        self.CreateButton:SetText('更新活动')
        self.DisbandButton:SetEnabled(isLeader)
        self.CreateButton:SetEnabled(isLeader)
        self:ShowViewboard(not isLeader)
    else
        if not self:IsEditing() then
            self:ClearAllContent()
        end
        self:SetWidgetEnabled(isLeader)
        self.CreateButton:SetText('创建活动')
        self.CreateButton:Disable()
        self.DisbandButton:Disable()
        self:ShowViewboard(false)
    end

    if createFailed then
        System:Error(L['活动创建失败，请重试。'])
    end
end

function CreatePanel:GetCurrentActivity()
    local active, activityID, ilvl, title, comment, voiceChat = C_LFGList.GetActiveEntryInfo()

    if active then
        self.Activity = CurrentActivity:New(activityID, ilvl, title, comment, voiceChat)
        return self.Activity
    else
        self.Activity = nil
    end
end

function CreatePanel:SelectActivity(value)
    if not self:IsEditing() then
        self.ActivityType:SetValue(value)
    end
end

function CreatePanel:UpdateSummaryMaxLetters()
    local activityType = self.ActivityType:GetItem()
    local activityMode = self.ActivityMode:GetItem()
    local activityLoot = self.ActivityLoot:GetItem()

    local minLevel = self.MinLevel:GetNumber()
    local maxLevel = self.MaxLevel:GetNumber()
    local pvpRating = self.PvPRating:GetNumber()

    local activity = CurrentActivity:New({
        ActivityType = activityType.customId or 0,
        ActivityTypeText = activityType.text,

        ActivityMode = activityMode.value,
        ActivityLoot = activityLoot.value,

        MinLevel = minLevel > 0 and minLevel or nil,
        MaxLevel = maxLevel > 0 and maxLevel or nil,
        PvPRating = pvpRating > 0 and pvpRating or nil,
    })

    local len = select(2, CodeCommentData(activity))

    self.SummaryBox:SetMaxLetters(MAX_SUMMARY_LETTERS - len)
end
