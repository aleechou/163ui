
BuildEnv(...)

BatchApply = RaidBuilder:NewModule('BatchApply', 'AceEvent-3.0', 'AceTimer-3.0', 'AceHook-3.0')

function BatchApply:OnInitialize()
    self.profile = Profile:GetBatchApplyProfile()

    self.scanCache = setmetatable({}, {__mode = 'v'})

    self:RegisterMessage('RAIDBUILDER_APPLY_FAILED', 'OnApplyFailed')
    self:RegisterMessage('RAIDBUILDER_APPLY_TIMEOUT', 'OnApplyFailed')
    self:RegisterMessage('RAIDBUILDER_EVENT_LOADED')

    self:RegisterEvent('GROUP_JOINED', 'Stop')
end

function BatchApply:RAIDBUILDER_EVENT_LOADED()
    if not self:IsWorking() then
        return
    end
    if time() - self.profile.stamp > 900 then
        return self:Stop()
    end
    self:Run()
end

function BatchApply:RAIDBUILDER_INVITE_REQUEST(_, sender)
    self.inviteRequestTarget = sender
    self:Pause()
end

function BatchApply:RAIDBUILDER_INVITE_RESET()
    if self.inviteRequestTarget then
        self:OnApplyFailed(nil, self.inviteRequestTarget)
        self.inviteRequestTarget = nil
    end
    self:Restore()
end

function BatchApply:OnApplyFailed(_, sender)
    self.profile.refuseList[sender] = time()
end

function BatchApply:IsWorking()
    return self.profile.isWorking
end

function BatchApply:Start(eventCode, eventMode, role, minLevel, itemLevel, pvpRating, search, noMatch)
    self.profile.isWorking = true
    self.profile.eventCode = eventCode
    self.profile.eventMode = eventMode or 0
    self.profile.role = role
    self.profile.minLevel = minLevel or 0
    self.profile.itemLevel = itemLevel or 0
    self.profile.pvpRating = pvpRating or 0
    self.profile.search = (search and search ~= '') and search:lower() or nil
    self.profile.noMatch = noMatch or nil

    self:Run()
end

function BatchApply:Run()
    wipe(self.scanCache)

    self:RegisterMessage('RAIDBUILDER_INVITE_REQUEST')
    self:RegisterMessage('RAIDBUILDER_INVITE_RESET')
    self:ScheduleRepeatingTimer('Scan', 10)
    self:SendMessage('RAIDBUILDER_BATCHAPPLY_STATUS_UPDATE')
    System:Log(L['已开始自动申请活动。'])
end

function BatchApply:Scan()
    self.profile.stamp = time()

    if self.profile.isPaused then
        return
    end

    if not AppliedCache:IsCanApply() then
        return
    end

    local event = self:PickupEvent()
    if event then
        Logic:JoinEvent(event, self.profile.role, nil, nil, true)
    end
end

function BatchApply:PickupEvent()
    if #self.scanCache == 0 then
        self:ScanEvents()
    end

    while true do
        local event = tremove(self.scanCache, 1)
        if not event then
            return
        end
        if EventCache:GetEvent(event:GetLeader()) then
            return event
        end
    end
end

function BatchApply:ScanEvents()
    for _, event in EventCache:IterateEvents() do
        if self:MatchEvent(event) then
            tinsert(self.scanCache, event)
        end
    end

    sort(self.scanCache, function(a, b)
        return a:GetRemain() < b:GetRemain()
    end)
end

function BatchApply:MatchEvent(event)
    if not event then
        return
    end
    if event:GetHasPassword() then
        return
    end
    if event:GetEventCode() ~= self.profile.eventCode then
        return
    end
    if self.profile.eventMode ~= 0 and event:GetEventMode() ~= self.profile.eventMode then
        return
    end
    if event:GetMinLevel() < self.profile.minLevel then
        return
    end
    if event:GetItemLevel() < self.profile.itemLevel then
        return
    end
    if event:GetPVPRating() < self.profile.pvpRating then
        return
    end
    if self.profile.search then
        local found = safematch(event:GetSummary():lower(), self.profile.search)
        if self.profile.noMatch then
            if found then
                return
            end
        else
            if not found then
                return
            end
        end
    end
    if not event:IsUsable() then
        return
    end
    if event:IsRoleFull(self.profile.role) then
        return
    end
    if event:IsApplied() or self.inviteRequestTarget == event:GetLeader() then
        return
    end
    if self:IsRefused(event:GetLeader()) then
        return
    end
    return true
end

function BatchApply:Stop()
    if not self:IsWorking() then
        return
    end
    self.profile.isWorking = nil

    self.inviteRequestTarget = nil
    self:UnregisterMessage('RAIDBUILDER_INVITE_REQUEST')
    self:UnregisterMessage('RAIDBUILDER_INVITE_RESET')
    self:CancelAllTimers()
    self:SendMessage('RAIDBUILDER_BATCHAPPLY_STATUS_UPDATE')
    System:Log(L['已停止自动申请活动。'])
end

function BatchApply:IsRefused(leader)
    local stamp = self.profile.refuseList[leader]
    if not stamp then
        return
    elseif time() - stamp > 600 then
        self.profile.refuseList[leader] = nil
        return
    else
        return true
    end
end

function BatchApply:Pause()
    self.profile.isPaused = true
end

function BatchApply:Restore()
    self.profile.isPaused = nil
end
