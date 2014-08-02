
BuildEnv(...)

MainPanel = RaidBuilder:NewModule(GUI:GetClass('Panel'):New(UIParent), 'MainPanel', 'AceEvent-3.0', 'AceBucket-3.0')

local addonName = ...

function MainPanel:OnInitialize()
    self:SetSize(832, 447)
    self:SetText(L['集合石'] .. ' Beta')
    self:SetIcon([[Interface\AddOns\RaidBuilder\Media\WebEvent]])
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
            GUI:CallFeedbackDialog(addonName, function(result, text)
                Logic:SendServer('SFEEDBACK', addonName, GetAddOnMetadata(addonName, 'Version'), text)
            end)
        end
    }

    local AnnButton = self:CreateTitleButton{
        title = L['公告'],
        texture = [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]],
        coords = {96/256, 128/256, 0, 0.5},
        callback = function()
            RaidBuilder:ToggleModule('AnnPanel')
        end
    }

    self:RegisterMessage('RAIDBUILDER_ANNOUNCEMENT_UPDATE', function(_, hasUnread)
        if hasUnread then
            AnnButton:PlayAnimation()
        else
            AnnButton:StopAnimation()
        end
    end)

    if IsAddOnLoaded('WowSocial_UI') then
        self:CreateTitleButton{
            title = L['集合石聊天'],
            texture = [[Interface\AddOns\WowSocial_UI\Media\Icon]],
            -- coords = {0.75, 1, 0, 1},
            callback = function()
                local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
                if CloudUI then
                    CloudUI:GetModule('DataBroker'):Toggle()
                end
            end
        }
    end

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

    self:RegisterBucketEvent({'BN_CONNECTED', 'BN_DISCONNECTED'}, 1, 'UpdateBlocker')
    self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'Refresh')
    self:HookScript('OnShow', self.OnShow)
    self:HookScript('OnHide', self.OnHide)

    local GameTooltip = CreateFrame('GameTooltip', 'RaidBuilderTooltip', UIParent, 'GameTooltipTemplate')

    local SourceTexture = GameTooltip:CreateTexture(nil, 'ARTWORK')
    SourceTexture:SetSize(64, 64)
    SourceTexture:SetPoint('CENTER', GameTooltip, 'TOPRIGHT')

    GameTooltip.SourceTexture = SourceTexture

    GameTooltip:SetScript('OnHide', function(self)
        self.SourceTexture:Hide()
    end)

    self.GameTooltip = GameTooltip

    self.helpButtons = {}
end

function MainPanel:OnEnable()
    self:UpdateBlocker()
end

function MainPanel:OnShow()
    RequestRatedInfo()
    self:UpdateBlocker()
    self:Refresh()
    self:SelectPanel(MainPanel:GetCurrentPanel())

    if Profile:IsNewVersion() then
        self:ToggleChangeLog(true)
    end
end

function MainPanel:OnHide()
    self.currentPanel = self:GetSelectedPanel()
    self.GameTooltip:Hide()
end

function MainPanel:GetCurrentPanel()
    return MemberCache:GetMemberCount() > 0 and WaitPanel or self.currentPanel or BrowsePanel
end

function MainPanel:Refresh()
    self:SetPanelEnabled(WaitPanel, EventCache:GetCurrentEvent())
end

function MainPanel:InitBlocker()
    local Blocker = CreateFrame('Frame', nil, self)
    Blocker:SetPoint('BOTTOMLEFT', 0, -30)
    Blocker:SetPoint('TOPRIGHT', 0, -20)
    -- Blocker:SetToplevel(true)
    Blocker:EnableMouse(true)
    Blocker:EnableMouseWheel(true)
    Blocker:SetScript('OnMouseWheel', function() end)
    Blocker:SetFrameLevel(99)

    local bg = Blocker:CreateTexture(nil, 'BACKGROUND')
    bg:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
    bg:SetAllPoints(Blocker)

    local SummaryBox = CreateFrame('Frame', nil, Blocker)
    SummaryBox:SetPoint('CENTER')
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

    self.Blocker = Blocker
    Blocker.Html = Html
    Blocker.Icon = Icon
    Blocker.SummaryBox = SummaryBox
    return Blocker
end

function MainPanel:SetBlocker(blockType)
    if blockType == 'MISSBNET' then
        local Blocker = self.Blocker or self:InitBlocker()
        Blocker.SummaryBox:SetSize(550, 350)
        Blocker.Html:SetText(L.MissBattleTagSummary)
        Blocker.Icon:SetTexture([[INTERFACE\FriendsFrame\PlusManz-BattleNet]])
        Blocker.Icon:SetDesaturated(true)
        Blocker:Show()
    elseif blockType == 'NEUTRAL' then
        local Blocker = self.Blocker or self:InitBlocker()
        Blocker.SummaryBox:SetSize(400, 270)
        Blocker.Html:SetText(L.NeutralDisabled)
        Blocker.Icon:SetTexture([[INTERFACE\Timer\Panda-Logo]])
        Blocker.Icon:SetDesaturated(false)
        Blocker:Show()
    elseif blockType == 'TRIALACCOUNT' then
        local Blocker = self.Blocker or self:InitBlocker()
        Blocker.SummaryBox:SetSize(400, 300)
        Blocker.Html:SetText(L.TrialAccountSummary)
        Blocker.Icon:SetTexture([[INTERFACE\FriendsFrame\PlusManz-BattleNet]])
        Blocker.Icon:SetDesaturated(true)
        Blocker:Show()
    elseif self.Blocker then
        self.Blocker:Hide()
    end
end

function MainPanel:UpdateBlocker()
    if not self:IsShown() then
        return
    end
    if UnitFactionGroup('player') == 'Neutral' then
        return self:SetBlocker('NEUTRAL')
    end
    if IsTrialAccount() then
        return self:SetBlocker('TRIALACCOUNT')
    end
    if not BNConnected() then
        return self:SetBlocker('MISSBNET')
    end
    local battleTag = select(2, BNGetInfo())
    if not battleTag or battleTag == '' then
        return self:SetBlocker('MISSBNET')
    end
    self:SetBlocker(nil)
end

local EVENT_INFO_TOOLTIP_ORDER = {
    { text = L['战网昵称：'],  method = 'GetLeaderBTag', },
    { text = L['团长：'],      method = 'GetLeaderText', true },
    { text = L['职业：'],      method = 'GetLeaderClassText', },
    { text = L['等级：'],      method = 'GetLeaderLevel', },
    { text = L['装等：'],      method = 'GetLeaderItemLevel', },
    { text = L['PVP：'],       method = 'GetLeaderPVPRating', },
    { text = L['团长粉丝：'],  method = 'GetLeaderFans', },
    { text = '',               method = 'GetLeaderLogoTooltip'},
    { text = ' ', },
    { text = L['形式：'],      method = 'GetEventModeText', },
    { text = L['说明：'],      method = 'GetSummary', },
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
            local value, r, g, b = event[v.method](event, unpack(v))
            if value then
                if v.method == 'GetSummary' and #value > 25 and not value:find('[^%w]+') then
                    value = value:gsub('(%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w)','%1\n')
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
            GameTooltip:AddDoubleLine(v, FormatProgressionText(event:GetLeaderProgression(), i), 1, 1, 1)
        end
    end

    GameTooltip:Show()

    local icon = SOURCE_ICONS[event:GetSource()]
    if event:GetSource() then
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
    { text = L['团长粉丝：'],  method = 'GetFans', },
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
                GameTooltip:AddDoubleLine(v, FormatProgressionText(member:GetProgression(), i), 1, 1, 1)
            end
        end
    end

    GameTooltip:Show()
end

function MainPanel:CloseTooltip()
    self.GameTooltip:Hide()
end

function MainPanel:CreateChangeLog()
    local ChangeLogFrame = CreateFrame('Frame', nil, self)
    ChangeLogFrame:SetPoint('BOTTOMLEFT', 5, 5)
    ChangeLogFrame:SetPoint('TOPRIGHT', -5, -25)
    -- ChangeLogFrame:SetToplevel(true)
    ChangeLogFrame:EnableMouse(true)
    ChangeLogFrame:EnableMouseWheel(true)
    ChangeLogFrame:SetScript('OnMouseWheel', function() end)
    ChangeLogFrame:SetFrameLevel(89)
    ChangeLogFrame:Hide()
    ChangeLogFrame:SetBackdrop{
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
        tileSize = 16, edgeSize = 16, tile=true
    }
    ChangeLogFrame:SetBackdropBorderColor(1, 0.82, 0)
    ChangeLogFrame:SetScript('OnShow', function()
        Profile:SaveVersion()
        self:HideHelpButtons()
    end)
    ChangeLogFrame:SetScript('OnHide', function()
        self:ShowHelpButtons()
    end)

    local Title = ChangeLogFrame:CreateFontString(nil, 'OVERLAY', 'QuestFont_Super_Huge')
    Title:SetPoint('TOPLEFT', 50, -50)
    Title:SetText(L['集合石'])
    Title:SetFont(Title:GetFont(), 32)

    local EnterButton = CreateFrame('Button', nil, ChangeLogFrame, 'UIPanelButtonTemplate')
    EnterButton:SetPoint('BOTTOMLEFT', 50, 30)
    EnterButton:SetSize(120, 36)
    EnterButton:SetText(L['开始体验'])
    EnterButton:SetScript('OnClick', function()
        self:ToggleChangeLog()
    end)

    local HelpButton = CreateFrame('Button', nil, ChangeLogFrame, 'UIPanelButtonTemplate')
    HelpButton:SetPoint('BOTTOMLEFT', EnterButton, 'TOPLEFT', 0, 10)
    HelpButton:SetSize(120, 36)
    HelpButton:SetText(L['新手指引'])
    HelpButton:SetScript('OnClick', function()
        self:ToggleChangeLog()
        self:SelectPanel(BrowsePanel)
        BrowsePanel:QuickToggle()
        BrowsePanel:ToggleHelpPlate()
    end)

    local portraitFrame = ChangeLogFrame:CreateTexture(nil, 'OVERLAY', 'UI-Frame-Portrait')
    portraitFrame:SetAllPoints(self.portraitFrame)
    local portrait = ChangeLogFrame:CreateTexture(nil, 'OVERLAY', nil, -1)
    portrait:SetAllPoints(self.portrait)
    SetPortraitToTexture(portrait, [[Interface\AddOns\RaidBuilder\Media\WebEvent]])

    local Frame = GUI:GetClass('ScrollFrame'):New(ChangeLogFrame)
    Frame:SetPoint('TOPLEFT', 400, -20)
    Frame:SetPoint('BOTTOMRIGHT', -20, 20)

    local ChangeLog = GUI:GetClass('SummaryHtml'):New(Frame)
    -- ChangeLog:SetSpacing('p', 5)
    ChangeLog:SetSpacing('h2', 20)
    Frame:SetScrollChild(ChangeLog)
    ChangeLog:SetText(ADDON_CHANGE_LOG)

    self.ChangeLogFrame = ChangeLogFrame

    return ChangeLogFrame
end

function MainPanel:ToggleChangeLog(force)
    local Frame = self.ChangeLogFrame or self:CreateChangeLog()

    Frame:SetShown(force or not Frame:IsShown())
end

function MainPanel:AddHelpButton(button)
    tinsert(self.helpButtons, button)
end

function MainPanel:HideHelpButtons()
    for _, button in ipairs(self.helpButtons) do
        button:Hide()
    end
    HelpPlate_Hide()
end

function MainPanel:ShowHelpButtons()
    for _, button in ipairs(self.helpButtons) do
        button:Show()
    end
end
