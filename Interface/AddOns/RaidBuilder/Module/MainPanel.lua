
BuildEnv(...)

MainPanel = RaidBuilder:NewModule(GUI:GetClass('Panel'):New(UIParent), 'MainPanel', 'AceEvent-3.0', 'AceBucket-3.0')

function MainPanel:OnInitialize()
    GUI:Embed(self, 'Refresh')

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

    self:CreateTitleButton{
        title = L['意见建议'],
        texture = [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]],
        coords = {0, 32/256, 0, 0.5},
        callback = function()
            GUI:CallFeedbackDialog(ADDON_NAME, function(result, text)
                Logic:SendServer('SFEEDBACK', ADDON_NAME, ADDON_VERSION, text)
            end)
        end
    }

    self:CreateTitleButton{
        title = L['公告'],
        texture = [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]],
        coords = {96/256, 128/256, 0, 0.5},
        callback = function()
            RaidBuilder:ToggleModule('AnnPanel')
        end
    }

    -- if IsAddOnLoaded('WowSocial_UI') then
    --     self:CreateTitleButton{
    --         title = L['集合石聊天'],
    --         texture = [[Interface\AddOns\WowSocial_UI\Media\Icon]],
    --         -- coords = {0.75, 1, 0, 1},
    --         callback = function()
    --             local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
    --             if CloudUI then
    --                 CloudUI:GetModule('DataBroker'):Toggle()
    --             end
    --         end
    --     }
    -- end

    self:CreateTitleButton{
        title = L['分享插件'],
        texture = [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]],
        coords = {64/256, 96/256, 0, 0.5},
        callback = function()
            RaidBuilder:ShowModule('SharePanel',
                L['分享插件'],
                L.ADDON_SHARE_CONTENT,
                true)
        end
    }

    self:CreateTitleButton{
        title = L['如何关注好团长?'],
        texture = [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]],
        coords = {32/256, 64/256, 0, 0.5},
        callback = function()
            RaidBuilder:ShowModule('YiXinSummary')
        end
    }

    self:CreateTitleButton{
        title = L['插件简介'],
        texture = [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]],
        coords = {224/256, 1, 0.5, 1},
        callback = function()
            self:ToggleChangeLog()
        end
    }

    -- self:CreateTitleButton{
    --     title = L['每日签到'],
    --     texture = 'Interface\\AddOns\\RaidBuilder\\Media\\RaidbuilderIcons',
    --     coords = {224/256, 1, 0, 0.5},
    --     callback = function()
    --         MainPanel:SelectPanel(OptionPanel)
    --     end
    -- }

    self:RegisterBucketEvent({'BN_CONNECTED', 'BN_DISCONNECTED'}, 1, 'UpdateUnusableFrame')
    self:RegisterMessage('RAIDBUILDER_CURRENT_EVENT_UPDATE', 'UpdateWaitPanelTab')
    self:HookScript('OnShow', self.OnShow)
    self:HookScript('OnHide', self.OnHide)

    self.helpButtons = {}
    self.blockers = {}

    self:InitTooltip()
    -- self:InitPortrait()
end

function MainPanel:OnShow()
    RequestRatedInfo()
    self:UpdateUnusableFrame()
    self:UpdateChangeLog()
    self:UpdateAnnFrame()
    self:UpdateWaitPanelTab()
    self:SelectPanel(MainPanel:GetCurrentPanel())
end

function MainPanel:Update()
    self:UpdateBlockerLevel()
end

function MainPanel:OnHide()
    Profile:SetDefaultPanel(self:GetSelectedTab())
    self.GameTooltip:Hide()
end

function MainPanel:GetCurrentPanel()
    return MemberCache:GetMemberCount() > 0 and WaitPanel or self:GetPanelByIndex(Profile:GetDefalutPanel()) or MallPanel
end

function MainPanel:UpdateWaitPanelTab()
    self:SetPanelEnabled(WaitPanel, EventCache:GetCurrentEvent())
end

----

function MainPanel:InitPortrait()
    local Portrait = CreateFrame('Button', nil, self)
    Portrait:SetPoint('TOPLEFT', self, 'TOPLEFT', -15, 15)
    Portrait:SetSize(70, 70)

    local Highlight = Portrait:CreateTexture(nil, 'HIGHLIGHT')
    Highlight:SetPoint('TOPLEFT')
    Highlight:SetSize(78, 78)
    Highlight:SetTexture([[Interface\Minimap\UI-Minimap-ZoomButton-Highlight]])
    Highlight:SetBlendMode('ADD')

    self.Portrait = Portrait
end

function MainPanel:CreateBlocker(order, blockTabs)
    local Blocker = CreateFrame('Frame', nil, self)

    Blocker:SetPoint('BOTTOMLEFT', 5, blockTabs and -30 or 5)
    Blocker:SetPoint('TOPRIGHT', -5, -25)
    Blocker:EnableMouse(true)
    Blocker:EnableMouseWheel(true)
    Blocker:SetScript('OnMouseWheel', nop)
    Blocker:Hide()

    local bg = Blocker:CreateTexture(nil, 'BACKGROUND')
    bg:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
    if blockTabs then
        bg:SetPoint('TOPLEFT')
        bg:SetPoint('BOTTOMRIGHT', 0, 35)
    else
        bg:SetAllPoints(true)
    end

    Blocker:SetScript('OnHide', function()
        self:Refresh()
    end)

    Blocker.order = order

    tinsert(self.blockers, Blocker)
    sort(self.blockers, function(a, b)
        return a.order > b.order
    end)

    return Blocker
end

function MainPanel:UpdateBlockerLevel()
    local prevBlocker
    for i, blocker in ipairs(self.blockers) do
        if blocker:IsShown() then
            if prevBlocker then
                blocker:SetFrameLevel(prevBlocker:GetFrameLevel() + 10)
            else
                blocker:SetFrameLevel(100)
            end
            prevBlocker = blocker
        end
    end
    if prevBlocker then
        self:HideHelpButtons()
        -- self.Portrait:SetFrameLevel(blocker:GetFrameLevel() + 10)
        self.portrait:SetParent(prevBlocker)
        self.portraitFrame:SetParent(prevBlocker)
    else
        self:ShowHelpButtons()
        self.portrait:SetParent(self)
        self.portraitFrame:SetParent(self)
    end
end

---- UnusableFrame

function MainPanel:CreateUnusableFrame()
    local UnusableFrame = self:CreateBlocker(3, true)

    local SummaryBox = CreateFrame('Frame', nil, UnusableFrame)
    SummaryBox:SetPoint('CENTER', 0, 20)
    SummaryBox:SetBackdrop{
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
        tileSize = 16, edgeSize = 16, tile=true
    }
    SummaryBox:SetBackdropBorderColor(1, 1, 1, 1)

    local Html = GUI:GetClass('SummaryHtml'):New(SummaryBox)
    Html:SetPoint('TOP', 0, -20)

    local Icon = Html:CreateTexture(nil, 'OVERLAY')
    Icon:SetPoint('TOPRIGHT')
    Icon:SetSize(64, 64)

    SummaryBox:SetScript('OnSizeChanged', function(_, width, height)
        Html:SetSize(width - 40, height)
    end)

    self.UnusableFrame = UnusableFrame
    UnusableFrame.Html = Html
    UnusableFrame.Icon = Icon
    UnusableFrame.SummaryBox = SummaryBox
    return UnusableFrame
end

function MainPanel:SetUnusableFrame(blockType, ...)
    if blockType == 'MISSBNET' then
        local UnusableFrame = self.UnusableFrame or self:CreateUnusableFrame()
        UnusableFrame.SummaryBox:SetSize(550, 350)
        UnusableFrame.Html:SetText(L.MissBattleTagSummary)
        UnusableFrame.Icon:SetTexture([[INTERFACE\FriendsFrame\PlusManz-BattleNet]])
        UnusableFrame.Icon:SetDesaturated(true)
        UnusableFrame:Show()
    elseif blockType == 'NEUTRAL' then
        local UnusableFrame = self.UnusableFrame or self:CreateUnusableFrame()
        UnusableFrame.SummaryBox:SetSize(400, 270)
        UnusableFrame.Html:SetText(L.NeutralDisabled)
        UnusableFrame.Icon:SetTexture([[INTERFACE\Timer\Panda-Logo]])
        UnusableFrame.Icon:SetDesaturated(false)
        UnusableFrame:Show()
    elseif blockType == 'TRIALACCOUNT' then
        local UnusableFrame = self.UnusableFrame or self:CreateUnusableFrame()
        UnusableFrame.SummaryBox:SetSize(400, 300)
        UnusableFrame.Html:SetText(L.TrialAccountSummary)
        UnusableFrame.Icon:SetTexture([[INTERFACE\FriendsFrame\PlusManz-BattleNet]])
        UnusableFrame.Icon:SetDesaturated(true)
        UnusableFrame:Show()
    elseif self.UnusableFrame then
        self.UnusableFrame:Hide()
    end
    self:Refresh()
end

function MainPanel:UpdateUnusableFrame()
    if UnitFactionGroup('player') == 'Neutral' then
        return self:SetUnusableFrame('NEUTRAL')
    end
    if IsTrialAccount() then
        return self:SetUnusableFrame('TRIALACCOUNT')
    end
    if not BNConnected() then
        return self:SetUnusableFrame('MISSBNET')
    end
    local battleTag = GetPlayerBattleTag()
    if not battleTag or battleTag == '' then
        return self:SetUnusableFrame('MISSBNET')
    end
    self:SetUnusableFrame(nil)
end

---- ChangeLogFrame

function MainPanel:CreateChangeLog()
    local ChangeLogFrame = self:CreateBlocker(2)

    local Title = ChangeLogFrame:CreateFontString(nil, 'OVERLAY', 'QuestFont_Super_Huge')
    Title:SetPoint('TOPLEFT', 50, -50)
    Title:SetText(L['集合石'])
    Title:SetFont(Title:GetFont(), 32)

    local EnterButton = CreateFrame('Button', nil, ChangeLogFrame, 'UIPanelButtonTemplate')
    EnterButton:SetPoint('BOTTOMLEFT', 50, 30)
    EnterButton:SetSize(120, 36)
    EnterButton:SetText(L['开始体验'])
    EnterButton:SetScript('OnClick', function()
        Profile:SaveVersion()
        self:ToggleChangeLog()
    end)

    local HelpButton = CreateFrame('Button', nil, ChangeLogFrame, 'UIPanelButtonTemplate')
    HelpButton:SetPoint('BOTTOMLEFT', EnterButton, 'TOPLEFT', 0, 10)
    HelpButton:SetSize(120, 36)
    HelpButton:SetText(L['新手指引'])
    HelpButton:SetScript('OnClick', function()
        Profile:SaveVersion()
        self:ToggleChangeLog()
        self:SelectPanel(BrowseParent)
        BrowsePanel:QuickToggle(0)
        self:ShowHelpPlate(BrowsePanel)
        Logic:Statistics(2)
    end)

    local ChangeLogButton = CreateFrame('Button', nil, ChangeLogFrame, 'UIPanelButtonTemplate')
    ChangeLogButton:SetPoint('BOTTOMLEFT', HelpButton, 'TOPLEFT', 0, 10)
    ChangeLogButton:SetSize(120, 36)
    ChangeLogButton:SetText(L['更新日志'])
    ChangeLogButton:SetScript('OnClick', function()
        self.ChangeLogFrame.SummaryHtml:SetText(ADDON_CHANGELOG)
    end)

    local SummaryButton = CreateFrame('Button', nil, ChangeLogFrame, 'UIPanelButtonTemplate')
    SummaryButton:SetPoint('BOTTOMLEFT', ChangeLogButton, 'TOPLEFT', 0, 10)
    SummaryButton:SetSize(120, 36)
    SummaryButton:SetText(L['插件简介'])
    SummaryButton:SetScript('OnClick', function()
        self.ChangeLogFrame.SummaryHtml:SetText(ADDON_SUMMARY)
    end)

    local Frame = GUI:GetClass('ScrollFrame'):New(ChangeLogFrame)
    Frame:SetPoint('TOPLEFT', 360, -20)
    Frame:SetPoint('BOTTOMRIGHT', -20, 20)

    local SummaryHtml = GUI:GetClass('SummaryHtml'):New(Frame)
    SummaryHtml:SetSpacing('h2', 20)
    SummaryHtml:SetSpacing('h1', 10)
    Frame:SetScrollChild(SummaryHtml)
    SummaryHtml:SetText(ADDON_SUMMARY)

    ChangeLogFrame:Hide()
    ChangeLogFrame:SetScript('OnShow', function()
        HelpButton:SetEnabled(not BatchApply:IsWorking())
    end)

    ChangeLogFrame.SummaryHtml = SummaryHtml
    self.ChangeLogFrame = ChangeLogFrame

    return ChangeLogFrame
end

function MainPanel:ToggleChangeLog(force)
    local Frame = self.ChangeLogFrame or self:CreateChangeLog()

    Frame:SetShown(force or not Frame:IsShown())
    self:Refresh()
end

function MainPanel:UpdateChangeLog()
    if Profile:IsNewVersion() then
        self:ToggleChangeLog(true)
    end
end

---- AnnFrame

function MainPanel:CreateAnnFrame()
    local AnnFrame = self:CreateBlocker(1)

    local Label = AnnFrame:CreateFontString(nil, 'OVERLAY', 'QuestFont_Super_Huge')
    Label:SetFont(Label:GetFont(), 32)
    Label:SetPoint('TOP', 0, -35)
    Label:SetText(L['公告'])

    local Line = AnnFrame:CreateTexture(nil, 'OVERLAY')
    Line:SetTexture([[INTERFACE\QUESTFRAME\UI-QuestTitleHighlight]])
    Line:SetSize(200, 1)
    Line:SetPoint('TOP', Label, 'BOTTOM', 0, -20)

    local Title = AnnFrame:CreateFontString(nil, 'OVERLAY', 'QuestFont_Super_Huge')
    Title:SetPoint('TOPLEFT', 100, -130)
    Title:SetTextColor(0, 1, 0)

    local Button = CreateFrame('Button', nil, AnnFrame, 'UIPanelButtonTemplate')
    Button:SetSize(120, 36)
    Button:SetPoint('BOTTOM', 0, 30)
    Button:SetText(L['我知道了'])
    Button:SetScript('OnClick', function()
        AnnFrame:Hide()
        Profile:SetAnnRead(1)
    end)

    local Content = AnnFrame:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLargeLeftTop')
    Content:SetTextColor(1, 1, 1)
    Content:SetPoint('TOPLEFT', Title, 'BOTTOMLEFT', 0, -20)
    Content:SetPoint('BOTTOM', Button, 'TOP', 0, 20)
    Content:SetPoint('RIGHT', -100, 0)

    self.AnnFrame = AnnFrame
    AnnFrame.Title = Title
    AnnFrame.Content = Content

    return AnnFrame
end

function MainPanel:UpdateAnnFrame()
    local annData = Profile:GetCurrentAnnData()
    if annData and annData.unread then
        local AnnFrame = self.AnnFrame or self:CreateAnnFrame()
        AnnFrame.Title:SetText(annData.title)
        AnnFrame.Content:SetText(annData.content)
        AnnFrame:Show()
    elseif self.AnnFrame then
        self.AnnFrame:Hide()
    end
    self:Refresh()
end

---- Help

local function HelpOnClick(self)
    if self.helpPlate and not HelpPlate_IsShowing(self.helpPlate) then
        HelpPlate_Show(self.helpPlate, self:GetParent(), self, true)
    else
        HelpPlate_Hide(true)
    end
end

local function HelpOnHide()
    HelpPlate_Hide()
end

function MainPanel:AddHelpButton(parent, helpPlate)
    local HelpButton = CreateFrame('Button', nil, parent, 'MainHelpPlateButton')
    HelpButton:SetPoint('TOPLEFT', self, 39, 20)
    HelpButton.helpPlate = helpPlate
    HelpButton:SetScript('OnClick', HelpOnClick)
    HelpButton:SetScript('OnHide', HelpOnHide)

    self.helpButtons[parent] = HelpButton
end

function MainPanel:HideHelpButtons()
    for _, button in pairs(self.helpButtons) do
        button:Hide()
    end
    HelpPlate_Hide()
end

function MainPanel:ShowHelpButtons()
    for _, button in pairs(self.helpButtons) do
        button:Show()
    end
end

function MainPanel:ShowHelpPlate(parent)
    local HelpButton = self.helpButtons[parent]
    if HelpButton then
        if not HelpPlate_IsShowing(HelpButton.helpPlate) then
            HelpPlate_Show(HelpButton.helpPlate, parent, HelpButton, true)
        end
    end
end

---- Tooltip

function MainPanel:InitTooltip()
    local GameTooltip = CreateFrame('GameTooltip', 'RaidBuilderTooltip', UIParent, 'GameTooltipTemplate')

    local SourceTexture = GameTooltip:CreateTexture(nil, 'ARTWORK')
    SourceTexture:SetSize(64, 64)
    SourceTexture:SetPoint('CENTER', GameTooltip, 'TOPRIGHT')

    GameTooltip.SourceTexture = SourceTexture

    GameTooltip:SetScript('OnHide', function(self)
        self.SourceTexture:Hide()
    end)

    self.GameTooltip = GameTooltip
end

local EVENT_INFO_TOOLTIP_ORDER = {
    { text = L['战网昵称：'],  method = 'GetLeaderBTag' },
    { text = L['团长：'],      method = 'GetLeaderText' },
    { text = L['职业：'],      method = 'GetLeaderClassText' },
    { text = L['等级：'],      method = 'GetLeaderLevel' },
    { text = L['装等：'],      method = 'GetLeaderItemLevel' },
    { text = L['PVP：'],       method = 'GetLeaderPVPRating' },
    { text = '',               method = 'GetLeaderLogoTooltip' },
    { text = ' ', },
    { text = L['形式：'],      method = 'GetEventModeText' },
    { text = L['说明：'],      method = 'GetSummary' },
    { text = L['版本：'],      method = 'GetVersion' }
}

function MainPanel:OpenEventTooltip(event)
    if not event then
        return
    end

    local GameTooltip = self.GameTooltip
    
    GameTooltip:SetOwner(self, 'ANCHOR_NONE')
    GameTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 1, -10)
    GameTooltip:SetText(event:GetEventName())

    for i, v in ipairs(EVENT_INFO_TOOLTIP_ORDER) do
        if not v.method or not event[v.method] then
            GameTooltip:AddLine(v.text, 1, 1, 1, true)
        else
            local value, r, g, b = event[v.method](event)
            if value then
                if v.method == 'GetSummary' and #value > 25 and not value:find('[^%w]+') then
                    value = value:gsub('(%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w)','%1\n')
                end
                if v.method == 'GetVersion' then
                    value = GetFullVersion(value)
                end
                GameTooltip:AddLine(v.text .. value, 1, 1, 1, true)
            end
        end
    end

    local progessionTitle = FormatProgressionTitle(event:GetLeaderProgression())
    if progessionTitle then
        GameTooltip:AddLine(' ')
        GameTooltip:AddDoubleLine(L['团长副本经验'], progessionTitle)

        for i, v in ipairs(GetRaidBossNames(event:GetEventCode())) do
            v = format(FormatInstanceColor(event:GetLeaderRaidInfo(), i), v)
            GameTooltip:AddDoubleLine(v, FormatProgressionText(event:GetLeaderProgression(), i), 1, 1, 1)
        end
    end

    GameTooltip:Show()

    local icon = SOURCE_ICONS[event:GetSource()] or [[Interface\AddOns\RaidBuilder\Media\Mark\0]]
    if icon then
        GameTooltip.SourceTexture:Show()
        GameTooltip.SourceTexture:SetTexture(icon)
    else
        GameTooltip.SourceTexture:Hide()
    end
end

local MEMBER_INFO_TOOLTIP_ORDER = {
    { text = L['战网昵称：'],  method = 'GetBattleTagText', },
    { text = L['职业：'],      method = 'GetClassText', },
    { text = L['等级：'],      method = 'GetLevel', },
    { text = L['装等：'],      method = 'GetItemLevel', },
    { text = L['PVP：'],       method = 'GetPVPRating', },
    { text = L['留言：'],  method = 'GetMessage', },
}

function MainPanel:OpenWaitTooltip(member)
    if not member then
        return
    end

    local GameTooltip = self.GameTooltip
    
    GameTooltip:SetOwner(self, 'ANCHOR_NONE')
    GameTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 1, -10)

    GameTooltip:SetText(member:GetNameText())

    for i, v in ipairs(MEMBER_INFO_TOOLTIP_ORDER) do
        if not v.method or not member[v.method] then
            GameTooltip:AddLine(v.text, 1, 1, 1, true)
        else
            local value = member[v.method](member, unpack(v))
            if value then
                if v.method == 'GetMessage' and #value > 25 and not value:find('[^%w]+') then
                    value = value:gsub('(%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w)','%1\n')
                end
                GameTooltip:AddLine(v.text .. value, 1, 1, 1, true)
            end
        end
    end
    
    if type(member:GetStats()) == 'table' then
        GameTooltip:AddLine(' ')
        for i, v in ipairs(STAT_LIST) do
            if member:GetStatInfo(v) then
                GameTooltip:AddLine(STAT_NAMES[v] .. member:GetStatInfo(v), 1, 1, 1)
            end
        end
    end
    local eventCode = GroupCache:GetCurrentEventCode()
    if eventCode and type(member:GetProgression()) == 'table' then
        local progessionTitle = FormatProgressionTitle(member:GetProgression())
        if progessionTitle then
            GameTooltip:AddLine(' ')
            GameTooltip:AddDoubleLine(L['副本经验'], progessionTitle)

            for i, v in ipairs(GetRaidBossNames(eventCode)) do
                v = format(FormatInstanceColor(member:GetRaidInfo(), i), v)
                GameTooltip:AddDoubleLine(v, FormatProgressionText(member:GetProgression(), i), 1, 1, 1)
            end
        end
    end

    GameTooltip:Show()
end

function MainPanel:CloseTooltip()
    self.GameTooltip:Hide()
end
