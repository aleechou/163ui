
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')

local SearchPanel = CloudUI:NewModule(GUI:GetClass('Panel'):New(UIParent), 'SearchPanel', 'AceEvent-3.0')
local StartPanel = GUI:GetClass('InfoPanel'):New(UIParent)
local BrowsePanel = GUI:GetClass('InfoPanel'):New(UIParent)

------------------------------
-----               StartPanel
------------------------------

function StartPanel:Load()
    local NameBox = self:CreateSearchBox(L['群组名称（或关注号）'])
    NameBox:SetPoint('TOPLEFT')
    NameBox:SetPoint('TOPRIGHT')

    local InterestBox = self:CreateMultiBox(L['游戏兴趣'], InterestList)
    InterestBox:SetPoint('TOPLEFT', NameBox, 'BOTTOMLEFT', 0, -5)
    InterestBox:SetPoint('TOPRIGHT', NameBox, 'BOTTOMRIGHT', 0, -5)

    local OnlineTimeBox = self:CreateMultiBox(L['活动时间'], OnlineTimeList)
    OnlineTimeBox:SetPoint('TOPLEFT', InterestBox, 'BOTTOMLEFT', 0, -5)
    OnlineTimeBox:SetPoint('TOPRIGHT', InterestBox, 'BOTTOMRIGHT', 0, -5)

    local SearchButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    SearchButton:SetSize(100, 22)
    SearchButton:SetPoint('BOTTOMRIGHT', self:GetOwner(), 'BOTTOMRIGHT', -4, 4)
    SearchButton:SetText(L['查找'])
    SearchButton:SetScript('OnClick', function()
        self:GetOwner().TabFrame:SetSelected(2)
    end)

    local JoinButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    JoinButton:SetSize(100, 22)
    JoinButton:SetPoint('BOTTOMRIGHT', self:GetOwner(), 'BOTTOMRIGHT', -4, 4)
    JoinButton:SetText(L['申请加入'])
    JoinButton:SetScript('OnClick', function()
        JoinChatGroup(self.Name:GetText())
    end)
    
    self.SearchButton = SearchButton
    self.JoinButton = JoinButton
    self.Interest = InterestBox:GetObject()
    self.OnlineTime = OnlineTimeBox:GetObject()
    self.Name = NameBox:GetObject()
    
    self.interest = 0
    self.onlineTime = 0

    self.Interest:SetCallback('OnValueChanged', function(frame, value)
        self.interest = value
        self:Refresh()
    end)
    self.OnlineTime:SetCallback('OnValueChanged', function(frame, value)
        self.onlineTime = value
        self:Refresh()
    end)
    self.Name:SetScript('OnTextChanged', function()
        self:Refresh()
    end)
end

function StartPanel:Update()
    local text = self.Name:GetText()
    local useName = text and text ~= '' and text ~= SEARCH
    local hasArgs = self.interest > 0 and self.onlineTime > 0

    if useName then
        self.SearchButton:Hide()
        self.JoinButton:Show()
        self.Interest:Disable()
        self.OnlineTime:Disable()
    else
        self.SearchButton:Show()
        self.JoinButton:Hide()
        self.Interest:Enable()
        self.OnlineTime:Enable()
    end
    
    self.SearchButton:SetEnabled(hasArgs)
    self:GetOwner():SetTabEnabled(2, not useName and hasArgs)
    SetChatGroupSearch(self.interest, self.onlineTime)
end

------------------------------
-----              BrowsePanel
------------------------------

function BrowsePanel:Load()
    local ListFrame = GUI:GetClass('ListView'):New(self)

    ListFrame:SetPoint('TOPLEFT', -3, 3)
    ListFrame:SetPoint('BOTTOMRIGHT', 3, -3)
    ListFrame:SetItemHeight(36)
    ListFrame:SetItemSpacing(2)
    ListFrame:EnableHoldBottom(nil)
    ListFrame:SetSelectMode('RADIO')
    ListFrame:SetItemList(GetChatGroupSearchList())
    ListFrame:SetItemClass(CloudUI:GetClass('SearchGroupButton'))
    ListFrame:SetCallback('OnItemFormatted', function(frame, button, data)
        button:SetText(data.text)
        button:SetIcon([[Interface\Icons\]] .. AvatarList[data.avatar])
        button:SetUserCount(data.userCount)
        button:SetFansCount(data.fansCount)
    end)
    ListFrame:SetCallback('OnRefresh', function(frame)
        if frame:AtBottom() and not frame:AtTop() then
            if RequestChatGroupSearch() then
                self.Loading:Show()
            end
        end
        self.NoResult:SetShown(frame:GetItemCount() == 0)
    end)
    ListFrame:SetCallback('OnItemEnter', function(frame, button, data)
        CloudUI:OpenSearchGroupTooltip(button, data)
    end)
    ListFrame:SetCallback('OnItemLeave', function(frame, button, data)
        GameTooltip:Hide()
    end)
    ListFrame:SetCallback('OnItemClick', function()
        self.JoinButton:Enable()
    end)

    local JoinButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    JoinButton:SetSize(100, 22)
    JoinButton:SetPoint('BOTTOMRIGHT', self:GetOwner(), 'BOTTOMRIGHT', -4, 4)
    JoinButton:SetText(L['申请加入'])
    JoinButton:SetScript('OnClick', function()
        JoinChatGroup(ListFrame:GetItem(ListFrame:GetSelected()).text)
    end)

    local NoResult = ListFrame:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    NoResult:SetAllPoints(ListFrame)
    NoResult:SetText(L['没有找到符合条件的群组。'])
    NoResult:Hide()

    self.NoResult = NoResult
    self.JoinButton = JoinButton
    self.ListFrame = ListFrame
    self.Loading = self:CreateLoading()

    self:SetScript('OnShow', self.OnShow)
end

function BrowsePanel:OnShow()
    if RequestChatGroupSearch() then
        self.Loading:Show()
        self.NoResult:Hide()
        self.ListFrame:SetSelected(nil)
        self.ListFrame:ScrollToTop()
        self.ListFrame:Hide()
    end
    self.JoinButton:SetEnabled(self.ListFrame:GetSelected())
end

function BrowsePanel:Update()
    self.Loading:Hide()
    self.ListFrame:Refresh()
    self.ListFrame:Show()
    self.JoinButton:SetEnabled(self.ListFrame:GetSelected())
end

------------------------------
-----              SearchPanel
------------------------------

function SearchPanel:OnInitialize()
    self:EnableUIPanel(true)
    self:EnableTabFrame(true)

    self:SetText(L['群组查找器'])
    self:SetIcon([[INTERFACE\ICONS\Trade_Archaeology_TheInnkeepersDaughter]])

    self:RegisterPanel(L['查找'], StartPanel)
    self:RegisterPanel(L['结果'], BrowsePanel)

    self:RegisterMessage('NECLOUD_SEARCH_UPDATE', 'Refresh')

    WowSocialUI_OnShow_In(self)

    local close = self.CloseButton:GetScript('OnClick')
    self.CloseButton:SetScript('OnClick', function(self)
        WowSocialUI_OnShow_Out(self, close)
    end)

end
