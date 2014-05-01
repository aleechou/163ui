
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
            texture = [[INTERFACE\FriendsFrame\InformationIcon]],
            callback = function()
                local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
                if CloudUI then
                    CloudUI.Feedback:Open(addonName, GetAddOnMetadata(addonName, 'Version'))
                end
            end
        }

        local AnnButton = self:CreateTitleButton{
            title = L['公告'],
            texture = [[INTERFACE\GossipFrame\DailyQuestIcon]],
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
        texture = [[INTERFACE\BUTTONS\UI-GuildButton-MOTD-Up]],
        coords = {0.05, 0.95, 0.05, 0.95},
        callback = function()
            RaidBuilder:ShowModule('SharePanel',
                L['分享插件'],
                L.ADDON_SHARE_CONTENT,
                true)
        end
    }

    self:RegisterBucketEvent({'PLAYER_LOGIN', 'BN_CONNECTED', 'BN_DISCONNECTED'}, 1, 'UpdateBlocker')
    self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'Refresh')
    self:HookScript('OnShow', self.OnShow)
    self:HookScript('OnHide', self.OnHide)
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
