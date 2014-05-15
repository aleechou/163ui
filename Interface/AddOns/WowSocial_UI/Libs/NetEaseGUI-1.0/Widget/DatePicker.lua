
local WIDGET, VERSION = 'DatePicker', 2

local GUI = LibStub('NetEaseGUI-1.0')
local DatePicker = GUI:NewClass(WIDGET, GUI:GetClass('Dropdown'), VERSION)
if not DatePicker then
    return
end

local L = GetLocale() == 'zhCN' and 
{
    ['WeekTitle'] = {'日', '一', '二', '三', '四', '五', '六'},
    ['DateTitle'] = '%d年%d月',
    ['DayFmt'] = '%d年%d月%d日',
} or 
{
    ['WeekTitle'] = {'Sun', 'Mon', 'Tue', 'Web', 'Thr', 'Fri', 'Sat'},
    ['DateTitle'] = '%d-%d',
    ['DayFmt'] = '%d-%d-%d',
}

local DateMenu = CreateFrame('Frame', nil, UIParent)
GUI:Embed(DateMenu, 'Menu', 'Owner')

local function GetDays(year, month)
    local bigMonth = '(1)(3)(5)(7)(8)(10)(12)'
    local currMonth = format('(%s)', month)
    local week = date('*t', time{year = year, month = month, day = 1})['wday']
    if month == 2 then
        if (year % 4 ==0 and year % 100 ~= 0) or year % 400 == 0 then
            return 29, week
        else
            return 28, week
        end
    elseif strfind(bigMonth, currMonth) ~= nil then
        return 31, week
    else
        return 30, week
    end
end

local function _IsSameDay(d1, d2)
    return d1.year == d2.year and d1.month == d2.month and d1.day == d2.day or nil
end

function DateMenu:GetCalendar(year, month)
    local days, startday = GetDays(year, month)
    local startday = startday <= 1 and startday + 7 or startday
    local prevyear = month == 1 and year - 1 or year
    local prevmonth = month == 1 and 12 or month - 1
    local nextyear = month == 12 and year + 1 or year
    local nextmonth = month == 12 and 1 or month + 1
    local prevdays = GetDays(prevyear, prevmonth)
    local today = date('*t')
    today.hour = nil
    today.min = nil
    today.sec = nil
    local result = {}

    for i = 1, 42 do
        if i < startday then
            result[i] = {day = prevdays - startday + i + 1, month = prevmonth, year = prevyear, notCurr = -1, oldDay = true}
        elseif i < days + startday then
            result[i] = {day = i - startday + 1, month = month, year = year}
        else
            result[i] = {day = i - days - startday + 1, month = nextmonth, year = nextyear, notCurr = 1}
        end
        result[i].isChecked = _IsSameDay(result[i], self)
        result[i].isToday = _IsSameDay(result[i], today)
        result[i].oldDay = time(result[i]) - time(today) < 0
    end

    return result
end

function DateMenu:Load()
    self:SetFrameStrata('DIALOG')
    self:EnableMouse(true)
    self:SetSize(200, 200)
    self:SetBackdrop{
            bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
            edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
            insets = { left = 8, right = 8, top = 8, bottom = 8 },
            tileSize = 24, edgeSize = 24, tile = true,
        }

    local Title = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
    Title:SetPoint('TOP', 0, -18)
    Title:SetWidth(100)

    local PrevButton = CreateFrame('Button', nil, self)
    PrevButton:SetPoint('TOPLEFT', 10, -10)
    PrevButton:SetSize(32, 32)
    PrevButton:SetNormalTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]])
    PrevButton:SetPushedTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Down]])
    PrevButton:SetDisabledTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Disabled]])
    PrevButton:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], 'ADD')
    PrevButton:SetScript('OnClick', function()
        self:SetMonthOffset(self.monthOffset - 1)
    end)

    local NextButton = CreateFrame('Button', nil, self)
    NextButton:SetPoint('TOPRIGHT', -10, -10)
    NextButton:SetSize(32, 32)
    NextButton:SetNormalTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]])
    NextButton:SetPushedTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Down]])
    NextButton:SetDisabledTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Disabled]])
    NextButton:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], 'ADD')
    NextButton:SetScript('OnClick', function()
        self:SetMonthOffset(self.monthOffset + 1)
    end)

    local WeekTitle = {}
    for i = 1, 7 do
        local wt = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        wt:SetWidth(20)
        wt:SetText(L.WeekTitle[i])
        if i == 1 then
            wt:SetPoint('TOPLEFT', 15, -45)
        else
            wt:SetPoint('TOPLEFT', WeekTitle[i-1], 'TOPRIGHT', 5, 0)
        end
        WeekTitle[i] = wt
    end

    local DayButtons = GUI:GetClass('GridView'):New(self)
    DayButtons:SetPoint('TOPLEFT', WeekTitle[1], 'BOTTOMLEFT', 0, -2)
    DayButtons:SetPoint('TOPRIGHT', WeekTitle[7], 'BOTTOMRIGHT', 0, -2)
    DayButtons:SetSize(1, 1)
    DayButtons:SetAutoSize(true)
    DayButtons:SetItemHeight(16)
    DayButtons:SetItemWidth(20)
    DayButtons:SetColumnCount(7)
    DayButtons:SetRowCount(6)
    DayButtons:SetItemSpacing(5)
    DayButtons:SetCallback('OnItemFormatted', function(DayButtons, button, data)
        button:SetText(data.day)
        button:SetNormalFontObject(data.isToday and 'GameFontGreenSmall' or
                                   data.notCurr and 'GameFontDisableSmall' or
                                   'GameFontHighlightSmall')
        button:SetChecked(data.isChecked)
        button:SetEnabled(not data.oldDay)
    end)
    DayButtons:SetCallback('OnItemClick', function(DayButtons, button, data)
        self:Hide()
        local owner = self:GetOwner()
        if owner then
            owner:SetValue(data.year, data.month, data.day)
        end
    end)
    DayButtons:SetCallback('OnItemCreated', function(_, button)
        button:SetHighlightFontObject('GameFontNormalSmall')
        button:SetCheckedTexture([[INTERFACE\FriendsFrame\UI-FriendsFrame-HighlightBar]])
    end)

    self.Title = Title
    self.DayButtons = DayButtons

    self.monthOffset = 0
end

function DateMenu:Refresh()
    local year, month = self:GetMonth()
    local today = date('*t')

    self.Title:SetText(L.DateTitle:format(year, month))
    self.Title:SetFontObject(year == today.year and today.month == month and 'GameFontGreenSmall' or 'GameFontNormalSmall')
    self.DayButtons:SetItemList(self:GetCalendar(year, month))
    self.DayButtons:Refresh()
end

function DateMenu:SetMonthOffset(offset)
    self.monthOffset = offset
    self:Refresh()
end

function DateMenu:GetMonth()
    local year = self.year + floor((self.month + self.monthOffset - 1) / 12)
    local month = (self.month + self.monthOffset - 1) % 12 + 1

    return year, month
end

function DateMenu:SetDate(year, month, day)
    self.year = year
    self.month = month
    self.day = day
    self:Refresh()
end

function DateMenu:Open(year, month, day)
    self:SetShown(not self:IsShown())
    self:SetDate(year, month, day)
    self:SetMonthOffset(0)
end

function DatePicker:Constructor()
    local d = date('*t')
    self:SetValue(d.year, d.month, d.day)
end

function DatePicker:ToggleMenu()
    if DateMenu.Load then
        DateMenu:Load()
        DateMenu.Load = nil
    end

    if DateMenu:IsShown() then
        DateMenu:Hide()
    else
        DateMenu:SetOwner(self)
        DateMenu:ClearAllPoints()
        DateMenu:SetPoint('TOPLEFT', self, 'BOTTOMLEFT')
        DateMenu:Open(self:GetValue())
    end
end

function DatePicker:SetValue(year, month, day)
    if type(year) ~= 'number' then
        error(([[bad argument #1 to 'SetValue' (number expected, got %s)]]):format(type(year)), 2)
    end
    if type(month) ~= 'number' then
        error(([[bad argument #2 to 'SetValue' (number expected, got %s)]]):format(type(month)), 2)
    end
    if type(day) ~= 'number' then
        error(([[bad argument #3 to 'SetValue' (number expected, got %s)]]):format(type(day)), 2)
    end
    if self.year ~= year or self.month ~= month or self.day ~= day then
        self.year = year
        self.month = month
        self.day = day

        self:SetText(L.DayFmt:format(year, month, day))
        self:Fire('OnDateChanged', year, month, day)
    end
end

function DatePicker:GetValue()
    return self.year, self.month, self.day
end
