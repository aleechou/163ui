
BuildEnv(...)

MainPanel = RaidBuilder:NewModule(GUI:GetClass('Panel'):New(UIParent), 'MainPanel', 'AceEvent-3.0', 'AceBucket-3.0')

local addonName = ...

function MainPanel:OnInitialize()
    self:SetSize(832, 447)
    self:SetText(L['魔兽友团'] .. ' Beta')
    self:SetIcon([[INTERFACE\ICONS\INV_Misc_GroupNeedMore]])
    self:EnableUIPanel(true)
    self:SetTabStyle('BOTTOM')
    self:SetTopHeight(80)
    self:RegisterForDrag('LeftButton')
    self:SetMovable(true)
    self:SetScript('OnDragStart', self.StartMoving)
    self:SetScript('OnDragStop', self.StopMovingOrSizing)

    if IsAddOnLoaded('WowSocial_UI') then
        self:CreateTitleButton{
            title = L['意见建议'],
            texture = 'Interface\\AddOns\\RaidBuilder\\Media\\RaidbuilderIcons',
            coords = {0, 32/256, 0, 1},
            callback = function()
                local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
                if CloudUI then
                    CloudUI.Feedback:Open(addonName, GetAddOnMetadata(addonName, 'Version'))
                end
            end
        }

        local AnnButton = self:CreateTitleButton{
            title = L['公告'],
            texture = 'Interface\\AddOns\\RaidBuilder\\Media\\RaidbuilderIcons',
            coords = {96/256, 128/256, 0, 1},
            callback = function()
                local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
                if CloudUI then
                    CloudUI:ToggleModule('AnnPanel')
                end
            end
        }

        self:CreateTitleButton{
            title = L['友团聊天'],
            texture = [[Interface\AddOns\RaidBuilder\Media\DataBroker]],
            coords = {0.75, 1, 0, 1},
            callback = function()
                local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
                if CloudUI then
                    CloudUI:GetModule('DataBroker'):Toggle()
                end
            end
        }

        self:RegisterMessage('NECLOUD_ANNOUNCEMENT_UPDATE', function(_, hasUnread)
            if hasUnread then
                AnnButton:PlayAnimation()
            else
                AnnButton:StopAnimation()
            end
        end)
    end

    self:CreateTitleButton{
        title = L['分享插件'],
        texture = 'Interface\\AddOns\\RaidBuilder\\Media\\RaidbuilderIcons',
        coords = {64/256, 96/256, 0, 1},
        callback = function()
            RaidBuilder:ShowModule('SharePanel',
                L['分享插件'],
                L.ADDON_SHARE_CONTENT,
                true)
        end
    }

    -- self:CreateTitleButton{
    --     title = L['每日签到'],
    --     texture = 'Interface\\AddOns\\RaidBuilder\\Media\\RaidbuilderIcons',
    --     coords = {224/256, 1, 0, 1},
    --     callback = function()
    --         MainPanel:SelectPanel(OptionPanel)
    --     end
    -- }

    self:RegisterBucketEvent({'PLAYER_LOGIN', 'BN_CONNECTED', 'BN_DISCONNECTED'}, 1, 'UpdateBlocker')
    self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'Refresh')
    self:HookScript('OnShow', self.OnShow)
    self:HookScript('OnHide', self.OnHide)

    self.GameTooltip = CreateFrame('GameTooltip', 'RaidBuilderTooltip', UIParent, 'GameTooltipTemplate')
end

function MainPanel:OnShow()
    self:UpdateBlocker()
    self:Refresh()
    self:SelectPanel(MainPanel:GetCurrentPanel())
end

function MainPanel:OnHide()
    self.currentPanel = self:GetSelectedPanel()
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
    Blocker:SetToplevel(true)
    Blocker:EnableMouse(true)
    Blocker:EnableMouseWheel(true)
    Blocker:SetScript('OnMouseWheel', function() end)
    Blocker:SetFrameLevel(99)

    local bg = Blocker:CreateTexture(nil, 'BACKGROUND')
    bg:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background]])
    bg:SetAllPoints(Blocker)

    local SummaryBox = CreateFrame('Frame', nil, Blocker)
    SummaryBox:SetSize(400, 330)
    SummaryBox:SetPoint('CENTER')
    SummaryBox:SetBackdrop{
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
        tileSize = 16, edgeSize = 16, tile=true
    }
    SummaryBox:SetBackdropBorderColor(1, 1, 1, 1)

    local Html = GUI:GetClass('SummaryHtml'):New(SummaryBox)
    Html:SetSize(360, 380)
    Html:SetPoint('TOP', 0, -20)

    local Icon = Html:CreateTexture(nil, 'OVERLAY')
    Icon:SetPoint('TOPRIGHT')
    Icon:SetSize(64, 64)

    self.Blocker = Blocker
    Blocker.Html = Html
    Blocker.Icon = Icon
    return Blocker
end

function MainPanel:SetBlocker(blockType)
    if blockType == 'MISSBNET' then
        local Blocker = self.Blocker or self.InitBlocker()
        Blocker.Html:SetText(L.MissBattleTagSummary)
        Blocker.Icon:SetTexture([[INTERFACE\FriendsFrame\PlusManz-BattleNet]])
        Blocker.Icon:SetDesaturated(true)
        Blocker:Show()
    elseif blockType == 'NEUTRAL' then
        local Blocker = self.Blocker or self.InitBlocker()
        Blocker.Html:SetText(L.NeutralDisabled)
        Blocker.Icon:SetTexture([[INTERFACE\Timer\Panda-Logo]])
        Blocker.Icon:SetDesaturated(false)
        Blocker:Show()
    elseif self.Blocker then
        self.Blocker:Hide()
    end
end

function MainPanel:UpdateBlocker()
    local Blocker = self.Blocker or self:InitBlocker()
    if UnitFactionGroup('player') == 'Neutral' then
        return self:SetBlocker('NEUTRAL')
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
    { text = L['易信关注度：'],method = 'GetLeaderFans', },
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
            local value = event[v.method](event, unpack(v))
            if value then
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
end

local MEMBER_INFO_TOOLTIP_ORDER = {
    { text = L['战网昵称：'],  method = 'GetBattleTagText', },
    { text = L['职业：'],      method = 'GetClassText', },
    { text = L['等级：'],      method = 'GetLevel', },
    { text = L['装等：'],      method = 'GetItemLevel', },
    { text = L['PVP：'],       method = 'GetPVPRating', },
    { text = L['易信关注度：'],method = 'GetFans', },
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
