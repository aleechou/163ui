
BuildEnv(...)

MainPanel = Addon:NewModule(GUI:GetClass('Panel'):New(UIParent), 'MainPanel', 'AceEvent-3.0', 'AceBucket-3.0')

function MainPanel:OnInitialize()
    GUI:Embed(self, 'Refresh', 'Help', 'Blocker')

    self:SetSize(832, 447)
    self:SetText(L['集合石'] .. ' Beta ' .. ADDON_VERSION)
    self:SetIcon(ADDON_LOGO)
    self:EnableUIPanel(true)
    self:SetTabStyle('BOTTOM')
    self:SetTopHeight(80)
    self:RegisterForDrag('LeftButton')
    self:SetMovable(true)
    self:SetScript('OnDragStart', self.StartMoving)
    self:SetScript('OnDragStop', self.StopMovingOrSizing)
    self:SetClampedToScreen(true)

    self:HookScript('OnShow', function()
        C_LFGList.RequestAvailableActivities()
        self:UpdateBlockers()
    end)

    local AnnBlocker = self:NewBlocker('AnnBlocker', 1) do
        AnnBlocker:SetCallback('OnCheck', function()
            return DataCache:GetObject('AnnData'):IsNew()
        end)
        AnnBlocker:SetCallback('OnInit', function(AnnBlocker)
            local Label = AnnBlocker:CreateFontString(nil, 'OVERLAY', 'QuestFont_Super_Huge') do
                Label:SetFont(STANDARD_TEXT_FONT, 32, 'OUTLINE')
                Label:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
                Label:SetPoint('TOP', 0, -35)
                Label:SetText(L['公告'])
            end

            local Line = AnnBlocker:CreateTexture(nil, 'OVERLAY') do
                Line:SetTexture([[INTERFACE\QUESTFRAME\UI-QuestTitleHighlight]])
                Line:SetSize(200, 1)
                Line:SetPoint('TOP', Label, 'BOTTOM', 0, -20)
            end

            local Title = AnnBlocker:CreateFontString(nil, 'OVERLAY', 'QuestFont_Super_Huge') do
                Title:SetPoint('TOPLEFT', 100, -130)
                Title:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
            end

            local Button = CreateFrame('Button', nil, AnnBlocker, 'UIPanelButtonTemplate') do
                Button:SetSize(120, 36)
                Button:SetPoint('BOTTOM', 0, 30)
                Button:SetText(L['我知道了'])
                Button:SetScript('OnClick', function()
                    DataCache:GetObject('AnnData'):SetIsNew(false)
                    AnnBlocker:Hide()
                end)
            end

            local Content = AnnBlocker:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLargeLeftTop') do
                Content:SetTextColor(1, 1, 1)
                Content:SetPoint('TOPLEFT', Title, 'BOTTOMLEFT', 0, -20)
                Content:SetPoint('BOTTOM', Button, 'TOP', 0, 20)
                Content:SetPoint('RIGHT', -100, 0)
            end

            AnnBlocker.Title = Title
            AnnBlocker.Content = Content
        end)
        AnnBlocker:SetCallback('OnFormat', function(AnnBlocker)
            local annData = DataCache:GetObject('AnnData'):GetData()
            if not annData then
                AnnBlocker.Title:SetText(L['暂无公告'])
                AnnBlocker.Content:SetText('')
            else
                AnnBlocker.Title:SetText(annData.title)
                AnnBlocker.Content:SetText(annData.content)
            end
        end)
        AnnBlocker:SetCallback('OnCheck', function(AnnBlocker)
            return DataCache:GetObject('AnnData'):IsNew()
        end)
    end

    local HelpBlocker = self:NewBlocker('HelpBlocker', 2) do
        HelpBlocker:SetCallback('OnCheck', function()
            return Profile:IsNewVersion()
        end)
        HelpBlocker:SetCallback('OnInit', function(HelpBlocker)
            local Icon = HelpBlocker:CreateTexture(nil, 'ARTWORK') do
                Icon:SetPoint('TOPLEFT', 50, -50)
                Icon:SetSize(64, 64)
                Icon:SetTexture([[Interface\AddOns\MeetingStone\Media\Mark\0]])
            end

            local Label = HelpBlocker:CreateFontString(nil, 'ARTWORK') do
                Label:SetFont(STANDARD_TEXT_FONT, 32, 'OUTLINE')
                Label:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
                Label:SetPoint('LEFT', Icon, 'RIGHT', 0, 0)
                Label:SetText(L['集合石'])
            end

            local Content = HelpBlocker:CreateFontString(nil, 'ARTWORK', 'GameFontDisableLarge') do
                Content:SetPoint('TOPLEFT', Icon, 'BOTTOMLEFT', 10, -20)
                Content:SetJustifyH('LEFT')
                Content:SetJustifyV('TOP')
                Content:SetText('版本：' .. ADDON_VERSION)
            end

            local Frame = GUI:GetClass('ScrollFrame'):New(HelpBlocker) do
                Frame:SetPoint('TOPLEFT', 360, -20)
                Frame:SetPoint('BOTTOMRIGHT', -20, 20)
            end

            local SummaryHtml = GUI:GetClass('SummaryHtml'):New(Frame) do
                SummaryHtml:SetSpacing('h2', 20)
                SummaryHtml:SetSpacing('h1', 10)
                SummaryHtml:SetText(ADDON_SUMMARY)
                Frame:SetScrollChild(SummaryHtml)
            end

            local EnterButton = CreateFrame('Button', nil, HelpBlocker, 'UIPanelButtonTemplate') do
                EnterButton:SetPoint('BOTTOMLEFT', 50, 30)
                EnterButton:SetSize(120, 26)
                EnterButton:SetText(L['开始体验'])
                EnterButton:SetScript('OnClick', function()
                    Profile:SaveVersion()
                    HelpBlocker:Hide()
                end)
            end

            local HelpButton = CreateFrame('Button', nil, HelpBlocker, 'UIPanelButtonTemplate') do
                HelpButton:SetPoint('BOTTOMLEFT', EnterButton, 'TOPLEFT', 0, 10)
                HelpButton:SetSize(120, 26)
                HelpButton:SetText(L['新手指引'])
                HelpButton:SetScript('OnClick', function()
                    Profile:SaveVersion()
                    HelpBlocker:Hide()
                    self:SelectPanel(BrowsePanel)
                    self:ShowHelpPlate(BrowsePanel)
                end)
            end

            local ChangeLogButton = CreateFrame('Button', nil, HelpBlocker, 'UIPanelButtonTemplate') do
                ChangeLogButton:SetPoint('BOTTOMLEFT', HelpButton, 'TOPLEFT', 0, 10)
                ChangeLogButton:SetSize(120, 26)
                ChangeLogButton:SetText(L['更新日志'])
                ChangeLogButton:SetScript('OnClick', function()
                    SummaryHtml:SetText(ADDON_CHANGELOG)
                end)
            end

            local SummaryButton = CreateFrame('Button', nil, HelpBlocker, 'UIPanelButtonTemplate') do
                SummaryButton:SetPoint('BOTTOMLEFT', ChangeLogButton, 'TOPLEFT', 0, 10)
                SummaryButton:SetSize(120, 26)
                SummaryButton:SetText(L['插件简介'])
                SummaryButton:SetScript('OnClick', function()
                    SummaryHtml:SetText(ADDON_SUMMARY)
                end)
            end
        end)
    end

    if ADDON_REGIONSUPPORT then
        self:CreateTitleButton{
            title = L['意见建议'],
            texture = [[Interface\AddOns\MeetingStone\Media\RaidbuilderIcons]],
            coords = {0, 32/256, 0, 0.5},
            callback = function()
                GUI:CallFeedbackDialog(ADDON_NAME, function(result, text)
                    Logic:SendServer('SFEEDBACK', ADDON_NAME, ADDON_VERSION, text)
                end)
            end
        }

        self:CreateTitleButton{
            title = L['公告'],
            texture = [[Interface\AddOns\MeetingStone\Media\RaidbuilderIcons]],
            coords = {96/256, 128/256, 0, 0.5},
            callback = function()
                self:ToggleBlocker('AnnBlocker')
            end
        }
    end

    self:CreateTitleButton{
        title = L['插件简介'],
        texture = [[Interface\AddOns\MeetingStone\Media\RaidbuilderIcons]],
        coords = {224/256, 1, 0.5, 1},
        callback = function()
            self:ToggleBlocker('HelpBlocker')
        end
    }

    self.GameTooltip = CreateFrame('GameTooltip', 'MeetingStoneTooltip', self, 'GameTooltipTemplate')
end

function MainPanel:OpenActivityTooltip(activity)
    local GameTooltip = self.GameTooltip
    GameTooltip:SetOwner(self, 'ANCHOR_NONE')
    GameTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 1, -10)
    GameTooltip:SetText(activity:GetName(), 1, 1, 1)
    GameTooltip:AddLine(activity:GetSummary(), GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, true)

    if activity:GetComment() then
        GameTooltip:AddLine(activity:GetComment(), GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, true)
    end

    GameTooltip:AddLine(' ')

    if activity:GetLeader() then
        GameTooltip:AddLine(format(LFG_LIST_TOOLTIP_LEADER, activity:GetLeaderText()))
    end
    if activity:GetLeaderItemLevel() then
        GameTooltip:AddLine(format(L['队长物品等级：|cffffffff%s|r'], activity:GetLeaderItemLevel()))
    end
    if activity:GetLeaderPvPRating() then
        GameTooltip:AddLine(format(L['队长PvP 等级：|cffffffff%s|r'], activity:GetLeaderPvPRating()))
    end
    if activity:GetItemLevel() > 0 then
        GameTooltip:AddLine(format(LFG_LIST_TOOLTIP_ILVL, activity:GetItemLevel()))
    end
    if activity:GetVoiceChat() then
        GameTooltip:AddLine(format(L['语音聊天：|cffffffff%s|r'], activity:GetVoiceChat()))
    end
    if activity:GetAge() > 0 then
        GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_AGE, SecondsToTime(activity:GetAge(), false, false, 1, false)))
    end

    if activity:GetDisplayType() == LE_LFG_LIST_DISPLAY_TYPE_CLASS_ENUMERATE then
        GameTooltip:AddLine(' ')
        GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_MEMBERS_SIMPLE, activity:GetNumMembers()))
        for i = 1, activity:GetNumMembers() do
            local role, class, classLocalized = C_LFGList.GetSearchResultMemberInfo(activity:GetID(), i)
            local classColor = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR
            GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_CLASS_ROLE, classLocalized, _G[role]), classColor.r, classColor.g, classColor.b)
        end
    else
        local memberCounts = C_LFGList.GetSearchResultMemberCounts(activity:GetID())
        GameTooltip:AddLine(' ')
        GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_MEMBERS, activity:GetNumMembers(), memberCounts.TANK, memberCounts.HEALER, memberCounts.DAMAGER))
    end

    if activity:IsAnyFriend() then
        GameTooltip:AddLine(' ')
        GameTooltip:AddLine(LFG_LIST_TOOLTIP_FRIENDS_IN_GROUP)
        GameTooltip:AddLine(LFGListSearchEntryUtil_GetFriendList(activity:GetID()), 1, 1, 1, true)
    end

    local progressions = RAID_PROGRESSION_LIST[activity:GetActivityID()]
    local progressionValue = activity:GetLeaderProcession()
    local completedEncounters = C_LFGList.GetSearchResultEncounterInfo(activity:GetID())
    if progressions and progressionValue then
        GameTooltip:AddLine(' ')
        GameTooltip:AddDoubleLine(L['副本进度/经验：'], activity:GetName())
        for i, v in ipairs(progressions) do
            local color = completedEncounters and tContains(completedEncounters, v.name) and RED_FONT_COLOR or GREEN_FONT_COLOR
            GameTooltip:AddDoubleLine(v.name, GetProgressionTex(progressionValue, i), color.r, color.g, color.b)
        end
    elseif completedEncounters and #completedEncounters > 0 then
        GameTooltip:AddLine(' ')
        GameTooltip:AddLine(LFG_LIST_BOSSES_DEFEATED)
        for i = 1, #completedEncounters do
            GameTooltip:AddLine(completedEncounters[i], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
        end
    end

    if activity:IsDelisted() then
        GameTooltip:AddLine(' ')
        GameTooltip:AddLine(LFG_LIST_ENTRY_DELISTED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true)
    end

    -- GameTooltip:AddLine(activity:BaseSortHandler())

    GameTooltip:Show()
end

local function AppendGameTooltipStatistic(label, value, title, lastTitle)
    if title ~= lastTitle then
        GameTooltip:AddLine(' ')
        GameTooltip:AddDoubleLine(title)
    end

    GameTooltip:AddLine(string.format(label, value))
end

function MainPanel:OpenApplicantTooltip(applicant)
    local name = applicant:GetName()
    local class = applicant:GetClass()
    local level = applicant:GetLevel()
    local localizedClass = applicant:GetLocalizedClass()
    local itemLevel = applicant:GetItemLevel()
    local comment = applicant:GetMsg()

    GameTooltip:SetOwner(self, 'ANCHOR_NONE')
    GameTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 0, 0)

    if name then
        local classTextColor = RAID_CLASS_COLORS[class]
        GameTooltip:SetText(name, classTextColor.r, classTextColor.g, classTextColor.b)
        GameTooltip:AddLine(string.format(UNIT_TYPE_LEVEL_TEMPLATE, level, localizedClass), 1, 1, 1)
    else
        GameTooltip:SetText(' ')
    end
    GameTooltip:AddLine(string.format(LFG_LIST_ITEM_LEVEL_CURRENT, itemLevel), 1, 1, 1)
    if comment and comment ~= '' then
        GameTooltip:AddLine(' ')
        GameTooltip:AddLine(format('%s: %s', L['描述'], comment), 1, 1, 1, true)
    end

    -- Add statistics
    local stats = applicant:GetStats()
    local lastTitle

    -- Tank proving ground
    if stats[23690] and stats[23690] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_TANK_GOLD, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    elseif stats[23687] and stats[23687] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_TANK_SILVER, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    elseif stats[23684] and stats[23684] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_TANK_BRONZE, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    end

    -- Healer proving ground
    if stats[23691] and stats[23691] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_HEALER_GOLD, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    elseif stats[23688] and stats[23688] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_HEALER_SILVER, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    elseif stats[23685] and stats[23685] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_HEALER_BRONZE, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    end

    -- Damage proving ground
    if stats[23689] and stats[23689] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_DAMAGER_GOLD, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    elseif stats[23686] and stats[23686] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_DAMAGER_SILVER, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    elseif stats[23683] and stats[23683] > 0 then
        AppendGameTooltipStatistic(LFG_LIST_PROVING_DAMAGER_BRONZE, nil, LFG_LIST_PROVING_GROUND_TITLE, lastTitle)
        lastTitle = LFG_LIST_PROVING_GROUND_TITLE
    end

    -- Add Progression
    local activityID = applicant:GetActivityID()
    local progressions = RAID_PROGRESSION_LIST[activityID]
    local progressionValue = applicant:GetProgression()
    if progressions and progressionValue then
        GameTooltip:AddLine(' ')
        GameTooltip:AddDoubleLine(L['副本经验：'], GetActivityName(activityID))
        for i, v in ipairs(progressions) do
            GameTooltip:AddDoubleLine(v.name, GetProgressionTex(progressionValue, i), 1, 1, 1)
        end
    end

    GameTooltip:Show()
end

function MainPanel:CloseTooltip()
    self.GameTooltip:Hide()
end
