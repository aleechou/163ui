
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local AnnPanel = CloudUI:NewModule(GUI:GetClass('Panel'):New(UIParent), 'AnnPanel') 

local AnnItem = CloudUI:NewClass('AnnItem', GUI:GetClass('ItemButton'))

function AnnItem:Constructor(parent)
    local Icon = self:CreateTexture(nil, 'ARTWORK')
    Icon:SetSize(36, 36)
    Icon:SetPoint('LEFT')
    Icon:SetTexture([[INTERFACE\HELPFRAME\ReportLagIcon-Mail]])
    Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

    local Text = self:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('LEFT', Icon, 'RIGHT', 5, 0)
    Text:SetPoint('RIGHT')

    self:SetFontString(Text)
    self:SetNormalFontObject('GameFontNormalSmallLeft')
    self:SetHighlightFontObject('GameFontHighlightSmallLeft')
    
    self:SetCheckedTexture([[INTERFACE\QUESTFRAME\UI-QuestTitleHighlight]])
end

function AnnPanel:OnInitialize()
    self:Hide()
    self:EnableUIPanel(true)
    self:SetBottomHeight(8)
    self:SetSize(538, 424)
    self:SetText(L['公告'])
    self:SetIcon([[INTERFACE\ICONS\INV_Inscription_RunescrollOfFortitude_Red]])

    local AnnList = GUI:GetClass('ListView'):New(self.Inset)
    AnnList:SetPoint('TOPLEFT', 10, -20)
    AnnList:SetPoint('BOTTOMLEFT', 10, 20)
    AnnList:SetWidth(200)
    AnnList:SetItemList(GetAnnList())
    AnnList:SetItemClass(CloudUI:GetClass('AnnItem'))
    AnnList:SetItemHeight(36)
    AnnList:SetItemSpacing(5)
    AnnList:SetSelectMode('RADIO')
    AnnList:SetCallback('OnItemFormatted', function(frame, button, data)
        button:SetText(data.title)
    end)
    AnnList:SetCallback('OnSelectChanged', function(frame, index, data)
        if data then
            self:SetAnn(data.title, data.content)
            SetAnnRead(index)
        end
    end)
    AnnList:SetScript('OnShow', function(frame)
        frame:SetSelected(1)
    end)

    local Line = self.Inset:CreateTexture(nil, 'OVERLAY')
    Line:SetTexture([[Interface\FrameGeneral\!UI-Frame]])
    Line:SetTexCoord(0.359375, 0.609375, 0, 1)
    Line:SetPoint('LEFT', AnnList, 'RIGHT', 10, 0)
    Line:SetPoint('TOP', 0, -2)
    Line:SetPoint('BOTTOM', 0, 2)
    Line:SetWidth(16)

    local Frame = GUI:GetClass('ScrollFrame'):New(self.Inset)
    Frame:SetPoint('TOPRIGHT', -10, -20)
    Frame:SetPoint('BOTTOMLEFT', AnnList, 'BOTTOMRIGHT', 30, 0)

    local AnnContent = GUI:GetClass('SummaryHtml'):New(Frame)
    AnnContent:SetSpacing('p', 5)
    Frame:SetScrollChild(AnnContent)

    WowSocialUI_OnShow_In(self)

    local close = self.CloseButton:GetScript('OnClick')
    self.CloseButton:SetScript('OnClick', function(self)
        WowSocialUI_OnShow_Out(self, close)
    end)

    self.AnnContent = AnnContent
end

function AnnPanel:SetAnn(title, content)
    self.AnnContent:SetText(format('<html><body><h3>%s</h3><p><br />%s</p></body></html>', title, FormatAnnMessage(content)))
end
