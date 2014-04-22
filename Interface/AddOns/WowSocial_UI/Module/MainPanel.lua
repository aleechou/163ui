
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local MainPanel = CloudUI:NewModule(GUI:GetClass('Panel'):New(UIParent), 'MainPanel', 'AceEvent-3.0')

function MainPanel:OnInitialize()
    self.chatTypes = {}
    self:EnableTabFrame(nil)
    self:InitControl()
    self:SetText(L['友团聊天'])

    self:RegisterChatType('RECOMMEND',
        [[INTERFACE\ICONS\Achievement_Arena_5v5_7]],
        GetRecommendGroupList(),
        L['推荐群组'],
        L['这是官方推荐的群组']
    )

    self:RegisterChatType('GROUP',
        [[INTERFACE\ICONS\Achievement_BG_DefendXtowers_AV]],
        GetChatGroupList(),
        L['我的群组'],
        L['这是我加入的群组']
    )

    self:RegisterChatType('RECENT',
        [[INTERFACE\ICONS\INV_Letter_18]],
        GetRecentList(),
        L['最近联系人'],
        L['这里是我最近联系的群组']
    )

    self:RegisterMessage('NECLOUD_READY', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_INFO', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_CREATE_SUCCESS', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_DISBAND', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_KICK', 'Refresh')
    self:RegisterMessage('NECLOUD_GROUP_LEAVE', 'Refresh')
    self:RegisterMessage('NECLOUD_UNREAD_CHANGED', 'Refresh')
    self:RegisterMessage('NECLOUD_RECENT_CHANGED', 'Refresh')
    self:RegisterMessage('NECLOUD_ANNOUNCEMENT_UPDATE', 'RefreshAnn')

    self:RegisterEvent('FRIENDLIST_UPDATE', 'Refresh')
end

function MainPanel:InitControl()
    self:Hide()
    self:HidePortrait()
    self:SetTopHeight(100)
    self:SetParent(UIParent)
    self:SetSize(220, 480)
    self:SetMinResize(220, 300)
    self:SetPoint('RIGHT', -82, 0)
    self:SetFrameStrata('MEDIUM')
    self:SetToplevel(true)
    self:SetClampedToScreen(true)
    self:SetMovable(true)
    self:EnableMouse(true)
    self:RegisterForDrag('LeftButton')
    self:SetScript('OnDragStart', self.StartMoving)
    self:SetScript('OnDragStop', self.StopMovingOrSizing)

    GUI:RegisterUIPanel(self)

    local OptionButton = CreateFrame('Button', nil, self)
    OptionButton:SetSize(16, 16)
    OptionButton:SetNormalTexture([[INTERFACE\Scenarios\ScenarioIcon-Interact]])
    OptionButton:SetHighlightTexture([[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]], 'ADD')
    OptionButton:SetPushedTexture([[INTERFACE\Scenarios\ScenarioIcon-Interact]])
    OptionButton:GetPushedTexture():ClearAllPoints()
    OptionButton:GetPushedTexture():SetPoint('CENTER', 1, -1)
    OptionButton:SetPoint('BOTTOMRIGHT', self.Inset, 'TOPRIGHT', -5, 7)
    OptionButton:SetScript('OnClick', function(button)
        CloudUI:ToggleMainMenu(button)
    end)

    local SearchBox = GUI:GetClass('SearchBox'):New(self)
    SearchBox:SetPoint('BOTTOMLEFT', self.Inset, 'TOPLEFT', 7, 0)
    SearchBox:SetPoint('RIGHT', OptionButton, 'LEFT', -3, 0)
    SearchBox:SetHeight(30)
    SearchBox:SetMaxLetters(10)
    SearchBox:SetScript('OnTextChanged', function(editbox)
        self.UnitList:SetFilterText(editbox:GetText())
    end)

    local AnnText = CreateFrame('Button', nil, self, 'InsetFrameTemplate')
    AnnText:SetPoint('TOPLEFT', 4, -25)
    AnnText:SetPoint('RIGHT', -6, 0)
    AnnText:SetPoint('BOTTOM', SearchBox, 'TOP')
    AnnText:SetHeight(50)
    AnnText:SetHighlightTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar-Blue]], 'ADD')

    local Icon = AnnText:CreateTexture(nil, 'OVERLAY')
    Icon:SetTexture([[Interface\AddOns\WowSocial_UI\Media\Flag]])
    Icon:SetPoint('TOPLEFT', 8, 0)
    Icon:SetSize(32, 64)

    local Text = AnnText:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmallLeft')
    Text:SetPoint('TOPLEFT', Icon, 'TOPRIGHT', 5, -10)

    AnnText:SetFontString(Text)
    AnnText:SetScript('OnEnter', function(button)
        CloudUI:OpenTooltip(button, GetAnnInfo(1), L['点击查看详情'])
    end)
    AnnText:SetScript('OnLeave', function()
        GameTooltip:Hide()
    end)
    AnnText:SetScript('OnClick', function()
        CloudUI:ShowModule('AnnPanel')
    end)
    AnnText:SetScript('OnSizeChanged', function(button, width)
        Text:SetWidth(width - 50)
    end)
    
    local UnitList = GUI:GetClass('ListView'):New(self.Inset)
    UnitList:SetPoint('TOPLEFT', 5, -5)
    UnitList:SetPoint('BOTTOMRIGHT', -5, 5)
    UnitList:SetItemClass(CloudUI:GetClass('UnitButton'))
    UnitList:SetItemHeight(36)
    UnitList:SetItemSpacing(2)
    UnitList:SetCallback('OnItemFormatted', function(self, button, data)
        button:SetUnread(GetChatUnread(data.chatType, data.target))
        button:SetText(GetChatName(data.chatType, data.target))
        button:SetIcon(GetChatIcon(data.chatType, data.target))
    end)
    UnitList:SetCallback('OnItemDoubleClick', function(self, button, data)
        if data.chatType == 'GROUP' then
            if not UserIsChatGroupMember(data.target, PLAYER_NAME) then
                if IsChatGroupPublic(data.target) then
                    JoinChatGroup(data.target)
                else
                    GUI:CallMessageDialog(
                        L['你没有加入群组%s，是否申请加入？']:format(data.text),
                        function(result)
                            if not result then
                                return
                            end
                            JoinChatGroup(data.target)
                        end)
                    return
                end
            end
        end
        CloudUI:ShowModule('ChatPanel', data.chatType, data.target)
    end)
    UnitList:SetCallback('OnItemMenu', function(self, button, data)
        CloudUI:ToggleUnitMenu(button, data.chatType, data.target)
    end)
    UnitList:SetCallback('OnItemEnter', function(_, button, data)
        CloudUI:OpenChatTooltip(button, data.chatType, data.target)
    end)
    UnitList:SetCallback('OnItemLeave', function()
        GameTooltip:Hide()
    end)
    UnitList:RegisterFilter(function(data, text)
        local name = data.text or GetChatName(data.chatType, data.target)
        return (name:lower():find(text:lower()))
    end)

    local ChatTypeFrame = GUI:GetClass('TabView'):New(self)
    ChatTypeFrame:SetPoint('TOPRIGHT', self, 'TOPLEFT', -1, -80)
    ChatTypeFrame:SetPoint('BOTTOMRIGHT', self, 'BOTTOMLEFT', -1, 20)
    ChatTypeFrame:SetWidth(32)
    ChatTypeFrame:SetItemClass(CloudUI:GetClass('SpecTabButton'))
    ChatTypeFrame:SetItemList(self.chatTypes)
    ChatTypeFrame:SetItemSpacing(25)
    ChatTypeFrame:SetItemHeight(32)
    ChatTypeFrame:SetOrientation('VERTICAL', 'RIGHT')
    ChatTypeFrame:EnableMenu(nil)
    ChatTypeFrame:SetCallback('OnItemFormatted', function(_, button, data)
        if type(data.icon) == 'string' then
            button:SetIcon(data.icon)
        elseif type(data.icon) == 'table' and not data.icon:GetScript('OnUpdate') then
            data.icon:SetParent(button)
            data.icon:SetPoint('CENTER')
            data.icon:Show()
            EyeTemplate_StartAnimating(data.icon)
        end
        button:SetReverse(true)
    end)
    ChatTypeFrame:SetCallback('OnSelectChanged', function(_, index, data)
        self.SearchBox:Clear()
        self.UnitList:SetItemList(data.itemList)
        self.UnitList:Refresh()
    end)
    ChatTypeFrame:SetCallback('OnItemEnter', function(_, button, data)
        CloudUI:OpenTooltip(button, data.text, data.note)
    end)
    ChatTypeFrame:SetCallback('OnItemLeave', function()
        GameTooltip:Hide()
    end)

    local CreateButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    CreateButton:SetSize(100, 22)
    CreateButton:SetPoint('BOTTOMRIGHT', -4, 4)
    CreateButton:SetText(L['创建群组'])
    CreateButton:SetScript('OnClick', function()
        GUI:CallInputDialog(L['请输入群组名称：'], function(result, name)
            if not result or name == '' then
                return
            end
            CreateChatGroup(name)
        end, nil, nil, 49)
    end)

    local AddButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    AddButton:SetSize(100, 22)
    AddButton:SetPoint('BOTTOMLEFT', 4, 4)
    AddButton:SetText(L['查找群组'])
    AddButton:SetScript('OnClick', function()
        CloudUI:ShowModule('SearchPanel')
    end)
    
    local ResizeButton = GUI:GetClass('ResizeButton'):New(self)
    ResizeButton:SetPoint('BOTTOMRIGHT', 0, 0)
    ResizeButton:SetFrameLevel(self:GetFrameLevel() + 5)

    local function MakeButton(texture, ...)
        local button = CreateFrame('Button', nil, self)
        button:SetSize(16, 16)
        button:SetNormalTexture(texture)
        button:SetHighlightTexture([[INTERFACE\Challenges\challenges-metalglow]], 'ADD')
        button:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
        GUI:SetTooltip(button, 'ANCHOR_RIGHT', ...)
        return button
    end
    
    local Feedback = MakeButton([[INTERFACE\FriendsFrame\InformationIcon]], L['意见建议'])
    local RaidBuilder = MakeButton([[INTERFACE\CHATFRAME\UI-ChatConversationIcon]], L['友团组团'])

    Feedback:SetPoint('TOPRIGHT', -30, -3)
    RaidBuilder:SetPoint('RIGHT', Feedback, 'LEFT', -1, 0)

    Feedback:SetScript('OnClick', function()
        CloudUI.Feedback:Open('WowSocial_UI', GetAddOnMetadata('WowSocial', 'Version'))
    end)
    RaidBuilder:SetScript('OnClick', function()
        local RaidBuilder = LibStub('AceAddon-3.0'):GetAddon('RaidBuilder')
        if RaidBuilder then
            RaidBuilder:ToggleModule('MainPanel')
        end
    end)

    self.AnnText = AnnText
    self.UnitList = UnitList
    self.SearchBox = SearchBox
    self.ChatTypeFrame = ChatTypeFrame

    WowSocialUI_OnShow_In(self)

    local close = self.CloseButton:GetScript('OnClick')
    self.CloseButton:SetScript('OnClick', function(self)
        WowSocialUI_OnShow_Out(self, close)
    end)
end

function MainPanel:RegisterChatType(chatType, icon, itemList, text, note)
    tinsert(self.chatTypes, {
        chatType = chatType,
        icon = icon,
        itemList = itemList,
        text = text,
        note = note,
    })
    self.ChatTypeFrame:Refresh()
end

function MainPanel:Refresh()
    self.UnitList:Refresh()
end

function MainPanel:RefreshAnn()
    self:SetAnn(GetAnnInfo(1))
end

function MainPanel:SetAnn(title, text)
    if title and text then
        self.AnnText.data = {text = title, note = text}
        self.AnnText:SetText(title or '')
        self.AnnText:Show()
    else
        self.AnnText:Hide()
    end
end
