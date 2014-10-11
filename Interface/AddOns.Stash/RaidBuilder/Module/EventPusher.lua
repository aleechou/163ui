
BuildEnv(...)

local EventPusher = RaidBuilder:NewModule(
    CreateFrame('Button', nil, UIParent),
    'EventPusher',
    'AceEvent-3.0', 'AceTimer-3.0')

function EventPusher:OnInitialize()
    self:SetBackdrop{
        bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        edgeSize = 16, tileSize = 16, tile = true,
        insets = {left = 4, right = 4, top = 4, bottom = 4},
    }
    self:SetBackdropColor(0, 0, 0, 0.3)
    self:SetBackdropBorderColor(1, 0.82, 0)
    self:SetSize(300, 26)

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    Text:SetPoint('LEFT', 5, 0)
    Text:SetPoint('RIGHT', -5, 0)
    Text:SetText('fshdifhsl;fhslhfslhfkjshfksjh')

    self:SetFontString(Text)

    local Group = self:CreateAnimationGroup()
    Group:SetLooping('NONE')
    Group:SetScript('OnFinished', function()
        self:OnFinished()
    end)

    local Alpha = Group:CreateAnimation('Alpha')
    Alpha:SetDuration(2)

    self:Hide()
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnClick', self.OnClick)

    self.Alpha = Alpha
    self.Group = Group

    self:RegisterMessage('RAIDBUILDER_SETTING_CHANGED')
end

function EventPusher:OnShow()
    self:SetPoint('TOP', RaidBuilder:GetModule('DataBroker').BrokerPanel, 'BOTTOM')
end

function EventPusher:OnClick()
    RaidBuilder:ToggleModule('MainPanel')
    MainPanel:SelectPanel(BrowsePanel)
    BrowsePanel:QuickToggle(self.event:GetEventCode(), self.event)
    Logic:Statistics(4, self.event:GetEventCode())
end

function EventPusher:OnFinished()
    if self:GetAlpha() == 0 then
        self:SetAlpha(1)
        self:ScheduleTimer('FadeOut', 8)
    else
        self:Hide()
    end
end

function EventPusher:OnTimer()
    self:PushEvent()
    self:ScheduleTimer('OnTimer', 60)
end

function EventPusher:RAIDBUILDER_SETTING_CHANGED(_, key, value)
    if not (key == 'eventPusher' or key == 'panel') then
        return
    end

    local settings = Profile:GetCharacterDB().profile.settings

    if settings.panel and settings.eventPusher then
        self:ScheduleTimer('OnTimer', 60)
    else
        self:Hide()
        self:CancelAllTimers()
    end
end

function EventPusher:PushEvent()
    if UnitInGroup('player') then
        return
    end

    local cache = {}
    for _, event in EventCache:IterateEvents() do
        if event:IsUsable() and event:IsRoleUsable() and not event:IsMemberFull() then
            tinsert(cache, {
                event = event,
                count = event:GetRoleCurrentAll() - event:GetRoleTotalAll(),
            })
        end
    end
    if #cache == 0 then
        return
    end

    sort(cache, function(a, b)
        return a.count > b.count
    end)

    local event = cache[1].event

    self:SetText(format([[点击加入：|cffffd100%s|r %s]],
        event:GetEventName(),
        event:GetSummary()))

    self.event = event
    self:FadeIn()
end

function EventPusher:FadeIn()
    self:SetAlpha(0)
    self.Alpha:SetChange(1)
    self.Group:Play()
    self:Show()
end

function EventPusher:FadeOut()
    self:SetAlpha(1)
    self.Alpha:SetChange(-1)
    self.Group:Play()
end
