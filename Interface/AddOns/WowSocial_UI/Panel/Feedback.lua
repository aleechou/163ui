--[[
    Feedback.lua
    Feedback panel
    ver     1.0.0
    author  Jai
    email   814683@qq.com
    edit    2013-10-25 11:15:23
    change    
]]--

BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local Feedback = GUI:GetClass('TitlePanel'):New(UIParent)
CloudUI.Feedback = Feedback

function Feedback:OnLoad()
	self:Hide()
	self:SetSize(500, 500)
	self:SetPoint('CENTER')
    self:SetText(L['意见建议'])
    self:SetFrameStrata('DIALOG')

    local bottomBackground = self:CreateTexture(nil, 'ARTWORK')
    bottomBackground:SetTexture([[Interface\Buttons\UI-Button-Borders]])
    bottomBackground:SetTexCoord(0, 1.0, 0.59375, 1.0)
    bottomBackground:SetSize(256, 26)
    bottomBackground:SetPoint('BOTTOMLEFT', 11, 9)
    bottomBackground:SetPoint('BOTTOMRIGHT', -11, 9)

    local SummaryHtml = GUI:GetClass('SummaryHtml'):New(self)
    SummaryHtml:SetSize(460, 120)
    SummaryHtml:SetPoint('TOP', 0, -30)
    
    local text = GUI:GetClass('EditBox'):New(self)
    text:SetPoint('TOPLEFT', SummaryHtml, 'BOTTOMLEFT', 0, -20)
    text:SetPoint('BOTTOMRIGHT', -20, 85)
    text:SetPrompt(L['请在这里输入反馈内容'])

    local Label = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    Label:SetPoint('BOTTOMLEFT', 20, 45)
    Label:SetText(L['如有更多意见，可以发送电邮：wow_social@163.com'])

    local sendButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    sendButton:SetPoint('BOTTOMRIGHT', -20, 12)
    sendButton:SetSize(72, 22)
    sendButton:SetText(L['发送'])
    sendButton:SetScript('OnClick', function()
        self:Send(strtrim(text:GetText()))
    end)

    local finishText = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    finishText:SetWidth(160)
    finishText:SetText(L['提交完成，感谢反馈！'])
    finishText:SetPoint('BOTTOMLEFT', 0, 15)
    finishText:SetAlpha(0)

    local finishTextAnimationGroup = finishText:CreateAnimationGroup()
    finishTextAnimationGroup:SetLooping('NONE')

    local ShowPath = finishTextAnimationGroup:CreateAnimation('Path')
    ShowPath:SetCurve('SMOOTH')
    ShowPath:SetDuration(0.5)
    local ShowPathStart = ShowPath:CreateControlPoint()
    ShowPathStart:SetOffset(130, 0)
    local ShowAlpha = finishTextAnimationGroup:CreateAnimation('Alpha')
    ShowAlpha:SetChange(1)
    ShowAlpha:SetDuration(0.5)

    local HidePath = finishTextAnimationGroup:CreateAnimation('Path')
    HidePath:SetCurve('SMOOTH')
    HidePath:SetDuration(0.5)
    HidePath:SetStartDelay(2.5)
    local HidePathStart = HidePath:CreateControlPoint()
    HidePathStart:SetOffset(200, 0)
    local HideAlpha = finishTextAnimationGroup:CreateAnimation('Alpha')
    HideAlpha:SetChange(-1)
    HideAlpha:SetDuration(0.5)
    HideAlpha:SetStartDelay(2.5)

    finishTextAnimationGroup:SetScript('OnFinished', function()
    	WowSocialUI_OnShow_Out(self)
    end)

    WowSocialUI_OnShow_In(self)

    self:SetScript('OnHide', function(self)
        if finishTextAnimationGroup:IsPlaying() then
            finishTextAnimationGroup:Stop()
            finishText:SetAlpha(0)
        end
    end)

    self.FinishAnimation = finishTextAnimationGroup
    self.Text = text
    self.SummaryHtml = SummaryHtml
    self.SendButton = sendButton
end

function Feedback:Send(msg)
    if msg == '' then 
        return
    end
    self.Text:SetFocus(false)
    self.Text:SetReadOnly(true)
    self.SendButton:Disable()
	SendFeedBack(self.addonName, self.version, msg)
	self.FinishAnimation:Play()
end

function Feedback:Open(addonName, version)
    self.SummaryHtml:SetText(format(L.FeedbackSummary, GetAddOnMetadata(addonName, 'Title'), version))
	self.addonName = addonName
	self.version = version
    self:Show()
    self.SendButton:Enable()
    self.Text:SetText()
    self.Text:SetReadOnly(false)
    self.Text:SetFocus(true)
end

Feedback:OnLoad()
