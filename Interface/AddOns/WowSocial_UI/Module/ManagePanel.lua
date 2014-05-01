
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local ManagePanel = CloudUI:NewModule(GUI:GetClass('Panel'):New(UIParent), 'ManagePanel', 'AceEvent-3.0')
local JoinPanel = GUI:GetClass('InfoPanel'):New(UIParent)
local OptionPanel = GUI:GetClass('InfoPanel'):New(UIParent)

local VALITYPE_MENUTABLE = {
    {
        text = L['需要验证'],
        value = 0,
    },
    {
        text = L['全部允许'],
        value = 1,
    },
    {
        text = L['全部拒绝'],
        value = -1,
    },
}

local function GetValiTypeText(value)
    for i, v in ipairs(VALITYPE_MENUTABLE) do
        if v.value == value then
            return v.text
        end
    end
end

------------------------------
-----                JoinPanel
------------------------------

function JoinPanel:Load()
    local ListFrame = GUI:GetClass('ListView'):New(self)
    ListFrame:SetAllPoints(self)
    ListFrame:SetPadding(10)
    ListFrame:SetItemHeight(32)
    ListFrame:SetItemClass(CloudUI:GetClass('JoinButton'))
    ListFrame:SetCallback('OnItemFormatted', function(self, button, data)
        button:SetText(data)
    end)
    ListFrame:SetCallback('OnItemAccept', function(self, button, data)
        JoinChatGroupAccept(self:GetParent():GetOwner():GetGid(), data)
        RequestChatGroupJoinList(self:GetParent():GetOwner():GetGid())
    end)
    ListFrame:SetCallback('OnItemCancel', function(self, button, data)
        JoinChatGroupCancel(self:GetParent():GetOwner():GetGid(), data)
        RequestChatGroupJoinList(self:GetParent():GetOwner():GetGid())
    end)
    ListFrame:SetCallback('OnRefresh', function()
        DeleteJoinList(self:GetOwner():GetGid())
    end)
    
    self.Loading = self:CreateLoading()
    
    self.ListFrame = ListFrame
    self:EnableRefreshOnShow(false)
    self:SetScript('OnShow', self.OnShow)
end

function JoinPanel:OnShow()
    self.Loading:Show()

    local gid = self:GetOwner():GetGid()

    RequestChatGroupJoinList(gid)

    self.ListFrame:SetItemList(GetChatGroupJoinList(gid))
    self.ListFrame:Refresh()
end

function JoinPanel:Update()
    self.Loading:Hide()
    self.ListFrame:Refresh()
end

------------------------------
-----              OptionPanel
------------------------------

function OptionPanel:Load()
    local YiXinBox = self:CreateLabel(L['关注号'])
    local AnnouncementBox = self:CreateEditBox(L['群组公告'], L['点击这里输入群组公告'])
    local SummaryBox = self:CreateEditBox(L['群组说明'], L['点击这里输入群组说明'])
    local InterestBox = self:CreateMultiBox(L['游戏兴趣'], InterestList)
    local OnlineTimeBox = self:CreateMultiBox(L['活动时间'], OnlineTimeList)
    local ValiTypeBox = self:CreateDropdown(L['入群申请方式'], VALITYPE_MENUTABLE)

    local HelpButton = CreateFrame('Button', nil, YiXinBox)
    HelpButton:SetSize(32, 32)
    HelpButton:SetPoint('BOTTOMRIGHT')
    HelpButton:SetNormalTexture([[INTERFACE\Calendar\EventNotification]])
    HelpButton:SetPushedTexture([[INTERFACE\Calendar\EventNotification]])
    HelpButton:GetPushedTexture():ClearAllPoints()
    HelpButton:GetPushedTexture():SetPoint('CENTER', 1, -1)
    HelpButton:GetPushedTexture():SetSize(32, 32)
    HelpButton:SetHighlightTexture([[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]], 'ADD')
    HelpButton:GetHighlightTexture():ClearAllPoints()
    HelpButton:GetHighlightTexture():SetPoint('CENTER', -5, 2)
    HelpButton:SetScript('OnClick', function()
        CloudUI:ShowModule('YixinSummary')
    end)

    SummaryBox:GetObject():SetTabPressed(function()AnnouncementBox:GetObject():SetFocus(true)end)
    AnnouncementBox:GetObject():SetTabPressed(function()SummaryBox:GetObject():SetFocus(true)end)

    local DisbandButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    DisbandButton:SetSize(100, 22)
    DisbandButton:SetPoint('BOTTOMLEFT', self:GetOwner(), 'BOTTOMLEFT', 4, 4)
    DisbandButton:SetText(L['解散群组'])
    DisbandButton:SetScript('OnClick', function()
        GUI:CallMessageDialog(
            L['你确定要解散群组%s吗？']:format(GetChatGroupName(self:GetOwner():GetGid())),
            function(result)
                if result then
                    DisbandChatGroup(self:GetOwner():GetGid())
                end
            end)
    end)

    local InviteButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    InviteButton:SetSize(100, 22)
    InviteButton:SetPoint('BOTTOM', self:GetOwner(), 0, 4)
    InviteButton:SetText(L['邀请好友'])
    InviteButton:SetScript('OnClick', function()
        GUI:CallInputDialog(
            L['请输入想要邀请入群的玩家名字\n或者在聊天窗口中\n按住Shift点击该玩家的名字：'],
            function(result, text)
                if text == '' then
                    self:SendMessage('NECLOUD_MSG', L['角色名错误，请重试。'])
                elseif result then
                    InviteChatGroup(self:GetOwner():GetGid(), text)
                end
            end,
            nil,
            not UnitIsUnit('player', 'target') and UnitIsFriend('player', 'target') and UnitName('target')
        )
    end)

    local SaveButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    SaveButton:SetSize(100, 22)
    SaveButton:SetPoint('BOTTOMRIGHT', self:GetOwner(), 'BOTTOMRIGHT', -4, 4)
    SaveButton:SetText(L['保存'])
    SaveButton:SetScript('OnClick', function()
        SetChatGroupInfo(self:GetOwner():GetGid(), {
            Interest = self.Interest:GetValue(),
            OnlineTime = self.OnlineTime:GetValue(),
            Summary = self.Summary:GetText(),
            Announcement = self.Announcement:GetText(),
            Avatar = self.Avatar,
            ValiType = self.ValiType:GetValue(),
        })
        HideUIPanel(self:GetOwner())
    end)

    local AvatarButton = CreateFrame('Button', nil, self)
    AvatarButton:SetPoint('TOPLEFT', self:GetOwner(), 'TOPLEFT', -15, 15)
    AvatarButton:SetSize(78, 78)
    AvatarButton:SetHighlightTexture([[Interface\Minimap\UI-Minimap-ZoomButton-Highlight]], 'ADD')
    AvatarButton:SetScript('OnClick', function(button)
        CloudUI.AvatarPopout:Open(
            button,
            self.Avatar,
            function(avatar, icon)
                self:GetOwner():SetIcon(icon)
                self.Avatar = avatar
            end
        )
    end)

    self.AvatarButton = AvatarButton
    self.SaveButton = SaveButton
    self.DisbandButton = DisbandButton
    self.Interest = InterestBox:GetObject()
    self.OnlineTime = OnlineTimeBox:GetObject()
    self.Summary = SummaryBox:GetObject()
    self.Announcement = AnnouncementBox:GetObject()
    self.ValiType = ValiTypeBox:GetObject()
    self.YiXin = YiXinBox:GetObject()

    self:SetScript('OnShow', self.Refresh)
end

function OptionPanel:Update()
    local gid = self:GetOwner():GetGid()
    local info = GetChatGroupInfo(gid)
    
    self.Interest:SetValue(info.Interest)
    self.OnlineTime:SetValue(info.OnlineTime)
    self.Summary:SetText(info.Summary)
    self.Announcement:SetText(info.Announcement)
    self.ValiType:SetText(GetValiTypeText(info.ValiType))
    self.ValiType:SetValue(info.ValiType)
    self.Avatar = info.Avatar
    self.YiXin:SetText(('%s    |cffffff73%s|r'):format(info.YiXin, L['%d个粉丝']:format(info.Fans)))

    local isOwner = UserIsChatGroupOwner(gid, PLAYER_NAME)
    local isManager = isOwner or UserIsChatGroupManager(gid, PLAYER_NAME)

    self:GetOwner():SetTabEnabled(2, isManager)
    self.DisbandButton:SetShown(isOwner)
    self.SaveButton:SetShown(isManager)
    self.Interest:SetEnabled(isManager)
    self.OnlineTime:SetEnabled(isManager)
    self.AvatarButton:SetEnabled(isManager)
    self.Summary:SetReadOnly(not isManager)
    self.Announcement:SetReadOnly(not isManager)
    self.ValiType:SetEnabled(isManager)
end

------------------------------
-----              ManagePanel
------------------------------


function ManagePanel:OnInitialize()
    self:EnableUIPanel(true)

    self:RegisterPanel(L['基本信息'], OptionPanel)
    self:RegisterPanel(L['入群申请'], JoinPanel)

    self:RegisterMessage('NECLOUD_GROUP_JOIN_LIST', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_JOIN_CANCEL', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_INFO', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_DISBAND')

    WowSocialUI_OnShow_In(self)

    local close = self.CloseButton:GetScript('OnClick')
    self.CloseButton:SetScript('OnClick', function(self)
        WowSocialUI_OnShow_Out(self, close)
    end)
end

function ManagePanel:GetGid()
    return self.gid
end

function ManagePanel:SetArguments(gid, tabIndex)
    self.gid = gid

    self:SetText(GetChatName('GROUP', gid))
    self:SetIcon(GetChatIcon('GROUP', gid))

    self:SelectTab(tabIndex or 1)
end

function ManagePanel:NECLOUD_GROUP_DISBAND(event, name, gid)
    if gid == self:GetGid() then
        HideUIPanel(self)
    end
end
