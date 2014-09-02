
BuildEnv(...)

local RecommendPanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'RecommendPanel', 'AceEvent-3.0')

function RecommendPanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    MainPanel:RegisterPanel(L['本周悬赏'], self, 8, 170, 155)
    MainPanel:DisablePanel(self)

    local Icon = self:CreateTexture(nil, 'OVERLAY')
    Icon:SetTexture([[Interface\ARCHEOLOGY\Arch-Race-Mogu]])
    Icon:SetPoint('TOPLEFT', self:GetOwner(), 60, -30)
    Icon:SetSize(36, 36)
    Icon:SetTexCoord(0, 0.578125, 0, 0.6796875)

    local TitleTip = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalHuge')
    TitleTip:SetPoint('LEFT', Icon, 'RIGHT')
    TitleTip:SetText(L['本周悬赏'])

    local TopTex = CreateFrame('Frame', nil, self, 'InsetFrameTemplate')
    TopTex:SetPoint('TOPLEFT', Icon, 'BOTTOMLEFT', -55, 0)
    TopTex:SetPoint('TOPRIGHT', self:GetOwner(), -10, 0)
    TopTex:SetHeight(90)

    local TopModel = CreateFrame('PlayerModel', nil, TopTex)
    TopModel:SetPoint('LEFT', 0, 0)
    TopModel:SetFacing(math.pi/4)
    TopModel:SetScript('OnSizeChanged', function(self)
        self:SetDisplayInfo(41399)
    end)
    TopModel:SetSize(300, 300)

    local Title = TopTex:CreateFontString(nil, 'OVERLAY', 'GameFontNormalHuge')
    Title:SetPoint('LEFT', TopModel, 'RIGHT')
    Title:SetPoint('RIGHT')

    local function MakeButton(text, callback)
        local button = CreateFrame('Button', nil, self)
        button:SetSize(174, 54)
        button:SetNormalTexture([[INTERFACE\HELPFRAME\HelpButtons]])
        button:SetPushedTexture([[INTERFACE\HELPFRAME\HelpButtons]])
        button:SetHighlightTexture([[INTERFACE\HELPFRAME\HelpButtons]], 'ADD')

        button:GetNormalTexture():SetTexCoord(0.00390625, 0.68359375, 0.44140625, 0.65234375)
        button:GetPushedTexture():SetTexCoord(0.00390625, 0.68359375, 0.22265625, 0.43359375)
        button:GetHighlightTexture():SetTexCoord(0.00390625, 0.68359375, 0.00390625, 0.21484375)

        button:SetNormalFontObject('GameFontNormalMed2')

        button:SetText(text)
        button:SetScript('OnClick', callback)

        return button
    end

    local CreateButton = BigButton:New(self)
    CreateButton:SetPoint('CENTER')
    CreateButton:SetText(L['开团'])
    CreateButton:SetScript('OnClick', function()
        local CreatePanel = RaidBuilder:GetModule('CreatePanel')
        MainPanel:SelectPanel(CreatePanel)
        CreatePanel:QuickToggle(self.eventCode, self.eventMode)
    end)

    local FindButton = BigButton:New(self)
    FindButton:SetPoint('RIGHT', CreateButton, 'LEFT', -50, 0)
    FindButton:SetText(L['找团'])
    FindButton:SetScript('OnClick', function()
        local BrowsePanel = RaidBuilder:GetModule('BrowsePanel')
        MainPanel:SelectPanel(BrowsePanel)
        BrowsePanel:QuickToggle(self.eventCode)
    end)

    local GotoButton = BigButton:New(self)
    GotoButton:SetPoint('LEFT', CreateButton, 'RIGHT', 50, 0)
    GotoButton:SetText(L['详情'])
    GotoButton:SetScript('OnClick', function()
        GUI:CallUrlDialog([[http://z.wowchina.com/official]])
    end)

    local SummaryBox = CreateFrame('Frame', nil, self, 'InsetFrameTemplate')
    SummaryBox:SetPoint('BOTTOMLEFT', self:GetOwner(), 5, 7)
    SummaryBox:SetPoint('BOTTOMRIGHT', self:GetOwner(), -10, 7)
    SummaryBox:SetHeight(130)

    local SummaryHtml = GUI:GetClass('SummaryHtml'):New(SummaryBox)
    SummaryHtml:SetPoint('CENTER')
    SummaryHtml:SetText(L.RecommendSummary)

    SummaryBox:SetScript('OnSizeChanged', function(_, width, height)
        SummaryHtml:SetSize(width - 20, height - 20)
    end)
    SummaryBox:GetScript('OnSizeChanged')(SummaryBox, SummaryBox:GetSize())

    self.Title = Title
    self.EventList = EventList

    self.eventCode = EVENT_TYPE_RECOMMEND
    self.eventMode = 7

    self:RegisterMessage('RAIDBUILDER_RECOMMENDDATA_CHANGED')

    self:SetScript('OnShow', function()
        RemoteDataCache:ReadCurrentRecommend()
    end)
end

function RecommendPanel:RAIDBUILDER_RECOMMENDDATA_CHANGED()
    local title = L['本周悬赏']
    if RemoteDataCache:IsCurrentRecommendNew() then
        title = '|cffff0000New|r ' .. title
    end

    MainPanel:EnablePanel(self)
    MainPanel:SetPanelText(self, title)

    self.Title:SetText(L['悬赏：'] .. RemoteDataCache:GetCurrentRecommend())
end
