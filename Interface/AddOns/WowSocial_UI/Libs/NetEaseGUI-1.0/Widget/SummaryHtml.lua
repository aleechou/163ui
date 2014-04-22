
local WIDGET, VERSION = 'SummaryHtml', 1

local GUI = LibStub('NetEaseGUI-1.0')
local SummaryHtml = GUI:NewClass(WIDGET, 'SimpleHTML', VERSION)
if not SummaryHtml then
    return
end

local L = GetLocale() == 'zhCN' and {
    CopyUrl = '请按<|cff00ff00Ctrl+C|r>复制网址到浏览器打开',
    Search = '请搜索“|cff00ff00%s|r”'
} or {
    CopyUrl = 'Please press <|cff00ff00Ctrl+C|r> to copy url',
    Search = 'Please search "|cff00ff00%s|r"'
}

function SummaryHtml:Constructor(parent)
    if not parent then
        return
    end
    self:SetParent(parent)
    self:SetFontObject('GameFontHighlightLeft')
    self:SetFontObject('h1', 'GameFontNormalLeft')
    self:SetFontObject('h2', 'GameFontNormalLargeLeft')
    self:SetFontObject('h3', 'QuestFont_Super_Huge')

    self:SetHyperlinksEnabled(true)
    self:SetScript('OnHyperlinkClick', self.OnHyperlinkClick)
end

function SummaryHtml:OnHyperlinkClick(link)
    local linkType, data = link:match('^([^:]+):(.+)$')
    if linkType == 'url' then
        local dialog = StaticPopup_Show('NETEASE_COPY_URL')
        if dialog then
            dialog.editBox:SetText(data)
            dialog.editBox:HighlightText()
            dialog.editBox:SetCursorPosition(0)
            dialog.editBox:SetFocus()
        end
    elseif linkType == 'help' then
        self:OpenHelper(data)
    elseif linkType == 'urlIndex' then
        LoadURLIndex(data)
    end
end

local HelperTip
function SummaryHtml:OpenHelper(id)
    HideUIPanel(HelpFrame)

    StaticPopup_Hide('HELP_TICKET')
    StaticPopup_Hide('HELP_TICKET_ABANDON_CONFIRM')
    StaticPopup_Hide('GM_RESPONSE_NEED_MORE_HELP')
    StaticPopup_Hide('GM_RESPONSE_RESOLVE_CONFIRM')
    StaticPopup_Hide('GM_RESPONSE_MUST_RESOLVE_RESPONSE')
    HelpFrame_ShowFrame()

    if not HelperTip then
        local Frame = CreateFrame('Frame', nil, HelpFrame, 'GlowBoxTemplate')
        Frame:SetSize(160, 50)
        Frame:SetPoint('BOTTOMRIGHT', HelpFrame, 'TOPRIGHT', -80, -20)
        Frame:Hide()

        local Arrow = CreateFrame('Frame', nil, Frame, 'GlowBoxArrowTemplate')
        Arrow:SetPoint('TOP', Frame, 'BOTTOM')

        local Text = Frame:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
        Text:SetPoint('TOPLEFT', 10, -10)
        Text:SetPoint('BOTTOMRIGHT', -10, -10)
        Text:SetJustifyV('TOP')

        LibStub('AceTimer-3.0'):Embed(Frame)

        Frame:SetScript('OnHide', function(self)
            self:CancelAllTimers()
            self:Hide()
        end)
        Frame:SetScript('OnShow', function(self)
            self:ScheduleTimer('Hide', 10)
        end)

        Frame.Text = Text
        HelperTip = Frame
    end

    HelperTip.Text:SetText(L.Search:format(id))
    HelperTip:Show()
end

StaticPopupDialogs['NETEASE_COPY_URL'] = {
    text = L.CopyUrl,
    whileDead = 1,
    hideOnEscape = 1,
    button1 = OKAY,
    hasEditBox = true,
    maxBytes = 2000,
    maxLetters = 2000,
}
