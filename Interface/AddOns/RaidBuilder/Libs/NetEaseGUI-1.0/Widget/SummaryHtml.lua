
local WIDGET, VERSION = 'SummaryHtml', 3

local GUI = LibStub('NetEaseGUI-1.0')
local SummaryHtml = GUI:NewClass(WIDGET, 'SimpleHTML', VERSION)
if not SummaryHtml then
    return
end

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
    self:SetScript('OnHyperlinkEnter', self.OnHyperlinkEnter)
    self:SetScript('OnHyperlinkLeave', GameTooltip_Hide)
end

function SummaryHtml:OnHyperlinkClick(link)
    local linkType, data = link:match('^([^:]+):(.+)$')
    if linkType == 'url' then
        GUI:CallUrlDialog(data)
    elseif linkType == 'help' then
        self:OpenHelper(data)
    elseif linkType == 'urlIndex' then
        -- LoadURLIndex(data)
        StaticPopup_Show("CONFIRM_LAUNCH_URL", nil, nil, {index = data})
    end
end

function SummaryHtml:OnHyperlinkEnter(link)
    local linkType, data = link:match('^([^:]+):(.+)$')
    if linkType == 'url' then
        GameTooltip:SetOwner(self, 'ANCHOR_CURSOR')
        GameTooltip:SetText(data, nil, nil, nil, true)
        GameTooltip:Show()
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
