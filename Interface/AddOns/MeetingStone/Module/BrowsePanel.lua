
BuildEnv(...)

BrowsePanel = Addon:NewModule(CreateFrame('Frame'), 'BrowsePanel', 'AceEvent-3.0', 'AceTimer-3.0', 'NetEaseGUI-DropMenu-1.0')

function BrowsePanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Refresh')
    MainPanel:RegisterPanel(L['查找活动'], self, 5, 90)

    self.activityHash = {}
    self.activityList = {}

    local ActivityList = GUI:GetClass('DataGridView'):New(self) do
        ActivityList:SetAllPoints(self)
        ActivityList:SetItemHeight(32)
        ActivityList:SetItemSpacing(1)
        ActivityList:SetItemClass(Addon:GetClass('BrowseItem'))
        ActivityList:SetSelectMode('RADIO')
        ActivityList:SetScrollStep(9)
        ActivityList:SetItemList(self.activityList)
        ActivityList:SetSortHandler(function(activity)
            return activity:BaseSortHandler()
        end)
        ActivityList:RegisterFilter(function(activity, ...)
            return activity:Match(...)
        end)
        ActivityList:InitHeader{
            {
                key = '@',
                text = '@',
                style = 'ICON:20:20',
                width = 30,
                iconHandler = function(activity)
                    if activity:IsUnusable() then
                        return
                    elseif activity:IsSelf() then
                        return [[Interface\AddOns\MeetingStone\Media\Icons]], 0.25, 0.375, 0, 1
                    elseif activity:IsInActivity() then
                        return [[Interface\AddOns\MeetingStone\Media\Icons]], 0.375, 0.5, 0, 1
                    elseif activity:IsApplication() then
                        return [[Interface\AddOns\MeetingStone\Media\Icons]], 0.5, 0.625, 0, 1
                    elseif activity:IsAnyFriend() then
                        return [[Interface\AddOns\MeetingStone\Media\Icons]], 0, 0.125, 0, 1
                    end
                end,
                sortHandler = ActivityList:GetSortHandler(),
            },
            {
                key = 'ActivityName',
                text = L['活动类型'],
                style = 'LEFT',
                width = 170,
                showHandler = function(activity)
                    if activity:IsUnusable() then
                        return activity:GetName(), GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
                    elseif activity:IsAnyFriend() then
                        return activity:GetName(), BATTLENET_FONT_COLOR.r, BATTLENET_FONT_COLOR.g, BATTLENET_FONT_COLOR.b
                    else
                        return activity:GetName(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b
                    end
                end,
                sortHandler = function(activity)
                    return activity:GetActivityID()
                end,
                formatHandler = function(grid, activity)
                    if activity:IsDelisted() or activity:IsApplication() then
                        grid:GetParent():SetSelectable(false)

                        if activity == ActivityList:GetSelectedItem() then
                            ActivityList:SetSelected(nil)
                        end
                    else
                        grid:GetParent():SetSelectable(true)
                    end
                end
            },
            {
                key = 'ActivityLoot',
                text = L['拾取'],
                style = 'LEFT',
                width = 50,
                showHandler = function(activity)
                    if activity:IsUnusable() then
                        return activity:GetLootText(), GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
                    else
                        return activity:GetLootText()
                    end
                end,
                sortHandler = function(activity)
                    return activity:GetLoot()
                end
            },
            {
                key = 'ActivityMode',
                text = L['形式'],
                style = 'LEFT',
                width = 50,
                showHandler = function(activity)
                    if activity:IsUnusable() then
                        return activity:GetModeText(), GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
                    else
                        return activity:GetModeText()
                    end
                end,
                sortHandler = function(activity)
                    return activity:GetMode()
                end,
            },
            {
                key = 'MemberRole',
                text = L['成员'],
                width = 125,
                class = Addon:GetClass('MemberDisplay'),
                formatHandler = function(grid, activity)
                    grid:SetActivity(activity)
                end,
            },
            {
                key = 'Level',
                text = L['等级'],
                width = 60,
                textHandler = function(activity)
                    local minLevel = activity:GetMinLevel()
                    local maxLevel = activity:GetMaxLevel()
                    local isMax = maxLevel >= MAX_PLAYER_LEVEL
                    local isMin = minLevel <= 1

                    if isMax and isMin then
                        return NONE, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
                    else
                        local text = minLevel == maxLevel and minLevel or isMax and '≥' .. minLevel or minLevel .. '-' .. maxLevel
                        local color = activity:IsUnusable() and GRAY_FONT_COLOR or activity:IsLevelValid() and GREEN_FONT_COLOR or RED_FONT_COLOR
                        return text, color.r, color.g, color.b
                    end
                end
            },
            {
                key = 'ItemLeave',
                text = L['要求'],
                width = 60,
                textHandler = function(activity)
                    if activity:IsArenaActivity() then
                        local pvpRating = activity:GetPvPRating()
                        if pvpRating == 0 then
                            return NONE, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
                        else
                            local color = activity:IsUnusable() and GRAY_FONT_COLOR or activity:IsPvPRatingValid() and GREEN_FONT_COLOR or RED_FONT_COLOR
                            return pvpRating, color.r, color.g, color.b
                        end
                    else
                        local itemLevel = activity:GetItemLevel()
                        if itemLevel == 0 then
                            return NONE, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
                        else
                            local color = activity:IsUnusable() and GRAY_FONT_COLOR or activity:IsItemLevelValid() and GREEN_FONT_COLOR or RED_FONT_COLOR
                            return itemLevel, color.r, color.g, color.b
                        end
                    end
                end
            },
            {
                key = 'Leader',
                text = L['团长'],
                style = 'LEFT',
                width = 100,
                showHandler = function(activity)
                    if activity:IsUnusable() then
                        return activity:GetLeaderShort(), GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
                    else
                        return activity:GetLeaderShortText(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b
                    end
                end,
            },
            {
                key = 'Title',
                text = L['说明'],
                width = 170,
                class = Addon:GetClass('SummaryGrid'),
                formatHandler = function(grid, activity)
                    grid:SetActivity(activity)
                end
                -- showHandler = function(activity)
                --     return activity:GetTitle()
                -- end,
            }
        }
        ActivityList:SetHeaderPoint('BOTTOMLEFT', ActivityList, 'TOPLEFT', -2, 2)

        ActivityList:SetCallback('OnItemDecline', function(_, _, activity)
            C_LFGList.CancelApplication(activity:GetID())
        end)
        ActivityList:SetCallback('OnSelectChanged', function(_, _, activity)
            self:UpdateSignUpButton(activity)
        end)
        ActivityList:SetCallback('OnRefresh', function(ActivityList)
            local shownCount = ActivityList:GetShownCount()
            if shownCount > 0 then
                self.NoResultBlocker:SetPoint('TOP', ActivityList:GetButton(shownCount), 'BOTTOM')
            else
                self.NoResultBlocker:SetPoint('TOP')
            end
            self.ActivityTotals:SetFormattedText(L['活动总数：%d/%d'], ActivityList:GetItemCount(), #self.activityList)
        end)
        ActivityList:SetCallback('OnItemEnter', function(_, _, activity)
            MainPanel:OpenActivityTooltip(activity)
        end)
        ActivityList:SetCallback('OnItemLeave', function()
            MainPanel:CloseTooltip()
        end)
        ActivityList:SetCallback('OnItemMenu', function(_, itemButton, activity)
            self:ToggleActivityMenu(itemButton, activity)
        end)
    end

    local SearchingBlocker = CreateFrame('Frame', nil, self) do
        SearchingBlocker:Hide()
        SearchingBlocker:SetAllPoints(self)
        SearchingBlocker:SetScript('OnShow', function()
            ActivityList:GetScrollChild():Hide()
        end)
        SearchingBlocker:SetScript('OnHide', function(SearchingBlocker)
            ActivityList:GetScrollChild():Show()
            SearchingBlocker:Hide()
        end)

        local Spinner = CreateFrame('Frame', nil, SearchingBlocker, 'LoadingSpinnerTemplate') do
            Spinner:SetPoint('CENTER')
            Spinner.Anim:Play()
        end

        local Label = SearchingBlocker:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge') do
            Label:SetPoint('BOTTOM', Spinner, 'TOP')
            Label:SetText(SEARCHING)
        end
    end

    local NoResultBlocker = CreateFrame('Frame', nil, self) do
        NoResultBlocker:SetPoint('BOTTOMLEFT')
        NoResultBlocker:SetPoint('BOTTOMRIGHT')
        NoResultBlocker:SetPoint('TOP')
        NoResultBlocker:Hide()

        local Label = NoResultBlocker:CreateFontString(nil, 'ARTWORK', 'GameFontDisable') do
            Label:SetPoint('CENTER', 0, 20)
        end

        local Button = CreateFrame('Button', nil, NoResultBlocker, 'UIPanelButtonTemplate') do
            Button:SetPoint('CENTER', 0, -20)
            Button:SetSize(120, 22)
            Button:SetText(L['创建活动'])
            Button:SetScript('OnClick', function()
                ToggleCreatePanel(self.searchValue)
            end)
        end

        NoResultBlocker.Label = Label
        NoResultBlocker.Button = Button
    end

    local SignUpButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate') do
        SignUpButton:SetSize(120, 22)
        SignUpButton:SetPoint('BOTTOM', MainPanel, 'BOTTOM', 0, 4)
        SignUpButton:SetText(L['申请加入'])
        SignUpButton:Disable()
        SignUpButton:SetMotionScriptsWhileDisabled(true)
        SignUpButton:SetScript('OnClick', function()
            self:SignUp(self.ActivityList:GetSelectedItem())
        end)
        SignUpButton:SetScript('OnShow', function()
            self:UpdateSignUpButton(self.ActivityList:GetSelectedItem())
        end)
        SignUpButton.SetTooltip = function(self, ...)
            GUI:SetTooltip(self, 'ANCHOR_TOP', ...)
        end
    end

    local ActivityLabel = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight') do
        ActivityLabel:SetPoint('TOPLEFT', MainPanel, 'TOPLEFT', 60, -45)
        ActivityLabel:SetText(L['活动类型'])
    end

    local ActivityDropdown = GUI:GetClass('Dropdown'):New(self) do
        ActivityDropdown:SetPoint('LEFT', ActivityLabel, 'RIGHT', 10, 0)
        ActivityDropdown:SetSize(170, 26)
        ActivityDropdown:SetMaxItem(20)
        ActivityDropdown:SetDefaultText(L['请选择活动类型'])
        ActivityDropdown:SetCallback('OnSelectChanged', function(_, data, ...)
            self:Search(data.categoryId, data.fullName, data.filters, data.baseFilter, data.value)
        end)
    end

    local function RefreshFilter()
        self.ActivityList:SetFilterText(self.SearchInput:GetMatchText(), self.LootDropdown:GetValue())
    end

    local LootLabel = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight') do
        LootLabel:SetPoint('LEFT', ActivityDropdown, 'RIGHT', 10, 0)
        LootLabel:SetText(L['拾取方式'])
    end

    local LootDropdown = GUI:GetClass('Dropdown'):New(self) do
        LootDropdown:SetPoint('LEFT', LootLabel, 'RIGHT', 10, 0)
        LootDropdown:SetSize(150, 26)
        LootDropdown:SetText(L['全部'])
        LootDropdown:SetDefaultText(L['全部'])
        LootDropdown:SetMenuTable(ACTIVITY_LOOT_MENUTABLE_WITHALL)
        LootDropdown:SetCallback('OnSelectChanged', RefreshFilter)
    end

    local SearchInput = GUI:GetClass('SearchBox'):New(self) do
        SearchInput:SetSize(170, 15)
        SearchInput:SetPoint('LEFT', LootDropdown, 'RIGHT', 10, 0)
        SearchInput:SetCallback('OnTextChanged', RefreshFilter)
    end

    local RefreshButton = Addon:GetClass('RefreshButton'):New(self) do
        RefreshButton:SetPoint('TOPRIGHT', MainPanel, 'TOPRIGHT', -20, -35)
        RefreshButton:SetTooltip(LFG_LIST_SEARCH_AGAIN)
        RefreshButton:SetScript('OnClick', function()
            self:Search()
        end)
        RefreshButton:HookScript('OnEnable', function(RefreshButton)
            RefreshButton:SetScript('OnUpdate', nil)
            RefreshButton:SetText(REFRESH)
        end)
        RefreshButton:HookScript('OnDisable', function(RefreshButton)
            RefreshButton:SetScript('OnUpdate', RefreshButton.OnUpdate)
        end)
        RefreshButton.OnUpdate = function(RefreshButton, elasped)
            RefreshButton:SetText(format(D_SECONDS, ceil(self:TimeLeft(self.disableRefreshTimer))))
        end
    end

    local ActivityTotals = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightRight') do
        ActivityTotals:SetPoint('BOTTOMRIGHT', MainPanel, -7, 7)
        ActivityTotals:SetFormattedText(L['活动总数：%d/%d'], 0, 0)
    end

    local IconSummary = CreateFrame('Button', nil, self) do
        IconSummary:SetSize(50, 20)
        IconSummary:SetPoint('BOTTOMLEFT', MainPanel, 10, 5)

        local icon = IconSummary:CreateTexture(nil, 'OVERLAY') do
            icon:SetSize(20, 20)
            icon:SetPoint('LEFT')
            icon:SetTexture([[Interface\AddOns\MeetingStone\Media\Icons]])
            icon:SetTexCoord(0, 32/256, 0, 1)
        end

        local label = IconSummary:CreateFontString(nil, 'OVERLAY') do
            label:SetPoint('LEFT', icon, 'RIGHT', 2, 0)
        end

        IconSummary:SetFontString(label)
        IconSummary:SetNormalFontObject('GameFontHighlightSmall')
        IconSummary:SetHighlightFontObject('GameFontNormalSmall')
        IconSummary:SetText(L['图示'])
        IconSummary:SetScript('OnEnter', function(button)
            GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')
            GameTooltip:SetText(L['图示'])
            GameTooltip:AddLine(format([[|TInterface\AddOns\MeetingStone\Media\Icons:20:20:0:0:256:32:64:96:0:32|t %s]], L['我的活动']), 1, 1, 1)
            GameTooltip:AddLine(format([[|TInterface\AddOns\MeetingStone\Media\Icons:20:20:0:0:256:32:96:128:0:32|t %s]], L['已加入活动']), 1, 1, 1)
            GameTooltip:AddLine(format([[|TInterface\AddOns\MeetingStone\Media\Icons:20:20:0:0:256:32:128:160:0:32|t %s]], L['申请中活动']), 1, 1, 1)
            GameTooltip:AddLine(format([[|TInterface\AddOns\MeetingStone\Media\Icons:20:20:0:0:256:32:0:32:0:32|t %s]], L['好友或公会成员参与的活动']), 1, 1, 1)
            GameTooltip:Show()
        end)
        IconSummary:SetScript('OnLeave', GameTooltip_Hide)
    end

    local HelpPlate = {
        FramePos = { x = -10,          y = 75 },
        FrameSize = { width = 830, height = 425 },
        {
            ButtonPos = { x = 280,   y = -5 },
            HighLightBox = { x = 60, y = -5, width = 650, height = 45 },
            ToolTipDir = 'DOWN',
            ToolTipText = L.BrowseHelpFilter,
        },
        {
            ButtonPos = { x = 715, y = -5 },
            HighLightBox = { x = 715, y = -5, width = 110, height = 45 },
            ToolTipDir = 'DOWN',
            ToolTipText = L.BrowseHelpRefresh,
        },
        {
            ButtonPos = { x = 370,  y = -190 },
            HighLightBox = { x = 5, y = -55, width = 820, height = 338 },
            ToolTipDir = 'RIGHT',
            ToolTipText = L.BrowseHelpList,
        },
        {
            ButtonPos = { x = 180,  y = -389 },
            HighLightBox = { x = 5, y = -397, width = 220, height = 28 },
            ToolTipDir = 'UP',
            ToolTipText = L.BrowseHelpMisc,
        },
        {
            ButtonPos = { x = 300,  y = -389 },
            HighLightBox = { x = 300, y = -397, width = 200, height = 28 },
            ToolTipDir = 'UP',
            ToolTipText = L.BrowseHelpApply,
        },
        {
            ButtonPos = { x = 550,  y = -389 },
            HighLightBox = { x = 550, y = -397, width = 275, height = 28 },
            ToolTipDir = 'UP',
            ToolTipText = L.BrowseHelpStatus,
        },
    }

    MainPanel:AddHelpButton(self, HelpPlate)

    self.ActivityList = ActivityList
    self.ActivityDropdown = ActivityDropdown
    self.SignUpButton = SignUpButton
    self.SearchingBlocker = SearchingBlocker
    self.NoResultBlocker = NoResultBlocker
    self.SearchInput = SearchInput
    self.LootDropdown = LootDropdown
    self.ActivityTotals = ActivityTotals
    self.RefreshButton = RefreshButton

    self:RegisterEvent('LFG_LIST_AVAILABILITY_UPDATE')
    self:RegisterEvent('LFG_LIST_SEARCH_RESULTS_RECEIVED')
    self:RegisterEvent('LFG_LIST_SEARCH_FAILED', 'LFG_LIST_SEARCH_RESULTS_RECEIVED')

    self:RegisterEvent('LFG_LIST_SEARCH_RESULT_UPDATED')
    self:RegisterEvent('LFG_LIST_APPLICATION_STATUS_UPDATED', 'LFG_LIST_SEARCH_RESULT_UPDATED')
    self:RegisterMessage('LFG_LIST_SEARCH_RESULT_REMOVED')

    LFGListApplicationDialog.SignUpButton:SetScript('OnClick', function(self)
        local dialog = self:GetParent()
        PlaySound('igMainMenuOptionCheckBoxOn')
        local id = dialog.resultID
        local comment = format('%s%s', dialog.Description.EditBox:GetText(), dialog.playerData or '')
        local tank = dialog.TankButton:IsShown() and dialog.TankButton.CheckButton:GetChecked()
        local healer = dialog.HealerButton:IsShown() and dialog.HealerButton.CheckButton:GetChecked()
        local damager = dialog.DamagerButton:IsShown() and dialog.DamagerButton.CheckButton:GetChecked()

        C_LFGList.ApplyToGroup(id, comment, tank, healer, damager)
        Logic:SEJ(dialog.activityData, dialog.Description.EditBox:GetText(), tank, healer, damager)
        StaticPopupSpecial_Hide(dialog)
    end)
end

function BrowsePanel:LFG_LIST_AVAILABILITY_UPDATE()
    self.ActivityDropdown:SetMenuTable(GetActivitesMenuTable())
    self.ActivityDropdown:SetValue(Profile:GetLastSearchValue())
    self:Refresh()
end

function BrowsePanel:LFG_LIST_SEARCH_RESULT_UPDATED(_, id)
    self:UpdateActivity(id)
    self.ActivityList:Refresh()
end

function BrowsePanel:LFG_LIST_SEARCH_RESULT_REMOVED(_, id)
    self:RemoveActivity(id)
    self.ActivityList:Refresh()
end

function BrowsePanel:RemoveActivity(id)
    tDeleteItem(self.activityList, self.activityHash[id])
    self.activityHash[id] = nil
end

function BrowsePanel:UpdateActivity(id)
    if not self.activityHash[id] then
        self:CacheActivity(id)
    else
        self.activityHash[id]:Update(true)
    end
end

function BrowsePanel:CacheActivity(id)
    local _id, activityId, title = C_LFGList.GetSearchResultInfo(id)
    if not _id then
        return
    elseif not activityId then
        return
    elseif title:match('单刷') or title == '勿扰' then
        return
    end

    local activity = Activity:New(id)

    tinsert(self.activityList, activity)
    self.activityHash[id] = activity

    self:SendMessage('MEETINGSTONE_ACTIVITIES_COUNT_UPDATED', #self.activityList)
end

function BrowsePanel:LFG_LIST_SEARCH_RESULTS_RECEIVED(event)
    self.SearchingBlocker:Hide()

    wipe(self.activityList)
    wipe(self.activityHash)

    local applications = C_LFGList.GetApplications()

    for _, id in ipairs(applications) do
        self:CacheActivity(id)
    end

    local resultCount, resultList = C_LFGList.GetSearchResults()
    for _, id in ipairs(resultList) do
        self:CacheActivity(id)
    end

    local isFailed = event == 'LFG_LIST_SEARCH_FAILED'
    self.NoResultBlocker:SetShown(resultCount == 0)
    self.NoResultBlocker.Label:SetText(isFailed and LFG_LIST_SEARCH_FAILED or LFG_LIST_NO_RESULTS_FOUND)
    self.NoResultBlocker.Button:SetShown(not isFailed)
    self.ActivityList:Refresh()
end

function BrowsePanel:CheckSignUpStatus(activity)
    local numApplications, numActiveApplications = C_LFGList.GetNumApplications()
    local messageApply = LFGListUtil_GetActiveQueueMessage(true)
    local availTank, availHealer, availDPS = C_LFGList.GetAvailableRoles()
    if messageApply then
        return false, messageApply
    elseif not LFGListUtil_IsAppEmpowered() then
        return false, LFG_LIST_APP_UNEMPOWERED
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME) and C_LFGList.IsCurrentlyApplying() then
        return false, LFG_LIST_APP_CURRENTLY_APPLYING
    elseif numActiveApplications >= MAX_LFG_LIST_APPLICATIONS then
        return false, string.format(LFG_LIST_HIT_MAX_APPLICATIONS, MAX_LFG_LIST_APPLICATIONS)
    elseif GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) > MAX_PARTY_MEMBERS + 1 then
        return false, LFG_LIST_MAX_MEMBERS
    elseif not (availTank or availHealer or availDPS) then
        return false, LFG_LIST_MUST_CHOOSE_SPEC
    elseif GroupHasOfflineMember(LE_PARTY_CATEGORY_HOME) then
        return false, LFG_LIST_OFFLINE_MEMBER
    elseif activity then
        return true, nil
    else
        return false, LFG_LIST_SELECT_A_SEARCH_RESULT
    end
end

function BrowsePanel:UpdateSignUpButton(activity)
    local usable, reason = self:CheckSignUpStatus(activity)

    self.SignUpButton:SetEnabled(usable)
    self.SignUpButton:SetTooltip(reason)
end

function BrowsePanel:SignUp(activity)
    if activity then
        local data, length = CodeDescriptionData(activity)
        LFGListApplicationDialog.playerData = data
        LFGListApplicationDialog.activityData = activity
        LFGListApplicationDialog.Description.EditBox:SetMaxLetters(60 - length)
        LFGListApplicationDialog_Show(LFGListApplicationDialog, activity:GetID())
    end
end

function BrowsePanel:Search(categoryId, fullName, filters, baseFilter, searchValue)
    if categoryId then
        self.categoryId = categoryId
        self.fullName = fullName
        self.filters= filters
        self.baseFilter = baseFilter
        self.searchValue = searchValue
    end
    if not self.categoryId or not self:IsVisible() then
        return
    end
    if self.searchValue == Profile:GetLastSearchValue() and not self.RefreshButton:IsEnabled() then
        return
    end

    Profile:SetLastSearchValue(self.searchValue)
    C_LFGList.Search(self.categoryId, self.fullName or '', self.filters, self.baseFilter)
    self.SearchingBlocker:Show()
    self.NoResultBlocker:Hide()
    self.RefreshButton:Disable()
    self:CancelTimer(self.disableRefreshTimer)
    self.disableRefreshTimer = self:ScheduleTimer('OnRefreshTimer', 3)
end

function BrowsePanel:OnRefreshTimer()
    self.RefreshButton:Enable()
end

function BrowsePanel:ToggleActivityMenu(anchor, activity)
    local usable, reason = self:CheckSignUpStatus(activity)

    self:ToggleMenu(anchor, {
        {
            text = activity:GetName(),
            isTitle = true,
            notCheckable = true,
        },
        {
            text = L['申请加入'],
            func = function() self:SignUp(activity) end,
            disabled = not usable or activity:IsDelisted() or activity:IsApplication(),
            tooltipTitle = not (activity:IsDelisted() or activity:IsApplication()) and L['申请加入'],
            tooltipText = reason,
            tooltipWhileDisabled = true,
            tooltipOnButton = true,
        },
        {
            text = WHISPER_LEADER,
            func = function() ChatFrame_SendTell(activity:GetLeader()) end,
            disabled = not activity:GetLeader() or not activity:IsApplication(),
            tooltipTitle = not activity:IsApplication() and WHISPER,
            tooltipText = not activity:IsApplication() and LFG_LIST_MUST_SIGN_UP_TO_WHISPER,
            tooltipOnButton = true,
            tooltipWhileDisabled = true,
        },
        {
            text = LFG_LIST_REPORT_GROUP_FOR,
            hasArrow = true,
            menuTable = {
                {
                    text = L['不当的说明'],
                    func = function() C_LFGList.ReportSearchResult(activity:GetID(), activity:IsMeetingStone() and 'lfglistcomment' or 'lfglistname') end,
                },
                {
                    text = LFG_LIST_BAD_DESCRIPTION,
                    func = function() C_LFGList.ReportSearchResult(activity:GetID(), 'lfglistcomment') end,
                    disabled = activity:IsMeetingStone() or not activity:GetComment(),
                },
                {
                    text = LFG_LIST_BAD_VOICE_CHAT_COMMENT,
                    func = function() C_LFGList.ReportSearchResult(activity:GetID(), 'lfglistvoicechat') end,
                    disabled = not activity:GetVoiceChat(),
                },
                {
                    text = LFG_LIST_BAD_LEADER_NAME,
                    func = function() C_LFGList.ReportSearchResult(activity:GetID(), 'badplayername') end,
                    disabled = not activity:GetLeader()
                },
            },
        },
        {
            text = CANCEL,
        },
    }, 'cursor')
end

BrowsePanel.Update = BrowsePanel.Search
