
BuildEnv(...)

Calendar = Cloud:NewModule('Calendar', 'AceEvent-3.0', 'AceHook-3.0', 'AceBucket-3.0')

function CalendarEventSetChatGroup(value, noChange)
    Calendar.eventChatGroupId = value
    if not noChange and CalendarCreateEventTitleEdit and CalendarCreateEventTitleEdit:IsVisible() then
        CalendarCreateEventTitleEdit_OnTextChanged(CalendarCreateEventTitleEdit)
    end
end

function CalendarEventGetChatGroup()
    return Calendar.eventChatGroupId
end

function OpenCalendarEvent(year, month, day, index)
    if not IsAddOnLoaded('Blizzard_Calendar') then
        LoadAddOn('Blizzard_Calendar')
    end

    ShowUIPanel(CalendarFrame)
    CalendarSetAbsMonth(month, year)
    CalendarOpenEvent(0, day, index)
end

function Calendar:OnInitialize()
    self:RegisterEvent('ADDON_LOADED')
    self:RegisterEvent('CALENDAR_OPEN_EVENT')
    self:RegisterEvent('CALENDAR_NEW_EVENT')

    self:RegisterBucketEvent('CALENDAR_UPDATE_EVENT_LIST', 1)

    self:RegisterMessage('NECLOUD_READY', 'ResetCalendar')

    self:RawHook('CalendarGetDayEvent', true)
    self:RawHook('CalendarGetEventInfo', true)
    self:RawHook('CalendarEventSetTitle', true)

    self:SecureHook('CalendarNewEvent', 'ClearGid')
    self:SecureHook('CalendarCloseEvent', 'ClearGid')
end

function Calendar:CacheEventTypeData(eventType, ...)
    self.eventTypeCache[eventType] = {}

    local count = select('#', ...) / 4
    for i = 1, count do
        local title, texture, _, difficultyName = select((i-1)*4+1, ...)
        
        self.eventTypeCache[eventType][i] = difficultyName == '' and title or title .. ' ' .. difficultyName
    end
end

function Calendar:GetEventTypeText(eventType, index)
    return self.eventTypeCache[eventType] and
            self.eventTypeCache[eventType][index] or
            self.eventTypeList[eventType] or ''
end

function Calendar:ADDON_LOADED(event, addon)
    if addon == 'Blizzard_Calendar' then
        self:UnregisterEvent('ADDON_LOADED')
        self.ADDON_LOADED = nil

        CalendarCreateEventTitleEdit:SetMaxLetters(CalendarCreateEventTitleEdit:GetMaxLetters() - 9)
        self:HookScript(CalendarFrame, 'OnHide', 'ResetCalendar')

        self.eventTypeList = {CalendarEventGetTypes()}
        self.eventTypeCache = {}

        self:CacheEventTypeData(1, CalendarEventGetTextures(1))
        self:CacheEventTypeData(2, CalendarEventGetTextures(2))
        self:CacheEventTypeData(6, CalendarEventGetTextures(6))
    end
end

function Calendar:GetCustomEventInfo()
    local gid = CalendarEventGetChatGroup()
    if not gid then
        return
    end
    
    local title, description, creator, eventType,
            _, _, textureIndex, weekday,
            month, day, year, hour, minute = CalendarGetEventInfo()

    local time = ('%02d/%02d/%02d %02d:%02d'):format(year, month, day, hour, minute)

    return title, description, gid, self:GetEventTypeText(eventType, textureIndex), time
end

function Calendar:CALENDAR_NEW_EVENT()
    local title, description, gid, eventType, time = self:GetCustomEventInfo()
    if not title then
        return
    end

    Logic:SendServer('COMM_CALENDAR_EVENT',
        title,
        description,
        gid,
        eventType,
        time)
end

-- return the day in after two week
local function GetDayByIndex(index)
    local presentWeekday, presentMonth, presentDay, presentYear = CalendarGetDate()
    local month, year, numDays, firstWeekday = CalendarGetMonth()
    if presentDay + index > numDays then
        local nextMonth, nextYear, nextNumDays, nextWeekDay = CalendarGetMonth(1)
        return 1, presentDay + index - numDays, nextMonth, nextYear, nextWeekDay
    else
        return 0, presentDay + index, month, year, firstWeekday
    end
end

function Calendar:CALENDAR_UPDATE_EVENT_LIST()
    if CalendarFrame and CalendarFrame:IsShown() then
        return
    end

    OpenCalendar()

    for gid, group in ChatGroupCache:IterateGroups() do
        wipe(group:GetEventList())
    end

    for i = 0, 15 do
        local monthOffset, day, month, year = GetDayByIndex(i)
        local numEvents = CalendarGetNumDayEvents(monthOffset, day)

        for index = 1, numEvents do
            local title, hour, minute,
                calendarType, sequenceType, eventType,
                texture, modStatus, inviteStatus, invitedBy,
                difficulty, inviteType,
                sequenceIndex, numSequenceDays, difficultyName, gid = CalendarGetDayEvent(monthOffset, day, index)
            
            if calendarType == 'PLAYER' and gid then
                local group = ChatGroupCache:GetChatGroup(gid)
                if group then
                    local eventList = group:GetEventList()

                    tinsert(eventList, {
                        text = title,
                        index = index,
                        year = year,
                        month = month,
                        day = day,
                        hour = hour,
                        minute = minute,

                        calendarType = calendarType,
                        sequenceType = sequenceType,
                        eventType = eventType,
                        texture = texture,
                        modStatus = modStatus,
                        inviteStatus = inviteStatus,
                        invitedBy = invitedBy,
                        difficulty = difficulty,
                        inviteType = inviteType,
                    })
                end
            end
        end
    end

    self:SendMessage('NECLOUD_EVENTLIST_UPDATE')
end

function Calendar:CALENDAR_OPEN_EVENT()
    local gid = select(26, _G.CalendarGetEventInfo())
    CalendarEventSetChatGroup(gid, true)
end

function Calendar:ResetCalendar()
    local _, month, _, year = CalendarGetDate()
    CalendarSetAbsMonth(month, year)
end

function Calendar:CalendarGetDayEvent(monthOffset, day, eventIndex)
    local title, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15 =
        self.hooks.CalendarGetDayEvent(monthOffset, day, eventIndex)

    local name, gid = title:match('^(.+)#(%x+)$')
    
    if name then
        title = name
        gid = tonumber(gid, 16)
    end
    return title, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, gid
end

function Calendar:CalendarGetEventInfo()
    local title, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13,
        arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25 =
        self.hooks.CalendarGetEventInfo()

    local name, gid = title:match('^(.+)#(%x+)$')
    if name then
        title = name
        gid = tonumber(gid, 16)
    end
    return title, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13,
            arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, gid
end

function Calendar:CalendarEventSetTitle(title)
    if not title or title == '' then
        title = ''
    elseif self.eventChatGroupId then
        title = ('%s#%x'):format(title, self.eventChatGroupId)
    end
    return self.hooks.CalendarEventSetTitle(title)
end

function Calendar:ClearGid()
    CalendarEventSetChatGroup()
end

function Calendar:SendEventNotify()
    local title, description, gid, eventType, time = self:GetCustomEventInfo()
    if not title then
        return
    end

    Logic:SendServer('COMM_GROUP_NOTIFY',
        title,
        gid,
        eventType,
        time)
end
