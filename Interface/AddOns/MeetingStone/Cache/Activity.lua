
BuildEnv(...)

Activity = Addon:NewClass('Activity')

local AceSerializer = LibStub('AceSerializer-3.0')
local AceEvent = LibStub('AceEvent-3.0')

function Activity:Constructor(id)
    self:SetID(id)
    self:Update()
end


local attrs = {
    'ID',
    'ActivityID',
    'CustomID',
    'VoiceChat',
    'ItemLevel',
    'Age',
    'IsDelisted',

    'Summary',
    'Comment',
    'MinLevel',
    'MaxLevel',
    'PvPRating',

    'Mode',
    'Loot',
    'Version',
    'IsMeetingStone',
    'Leader',
    'LeaderShort',
    'LeaderClass',
    'LeaderItemLevel',
    'LeaderProcession',
    'LeaderPvPRating',
    'NumMembers',
    'Name',
    'IsApplication',
    'IsApplicationFinished',
    'IsAnyFriend',

    'ApplicationStatus',
    'PendingStatus',
    'ApplicationDuration',
    'ApplicationExpiration',
    'DisplayType',
}

for i, v in ipairs(attrs) do
    local key = '_' .. v
    Activity['Set' .. v] = function(self, value)
        self[key] = value
    end

    Activity[v:match('^Is') and v or 'Get' .. v] = function(self)
        return self[key]
    end
end

function Activity:Update(flag)
    local id, activityId, title, comment, voiceChat, iLvl, age,
        numBNetFriends, numCharFriends, numGuildMates, isDelisted, leader, numMembers = C_LFGList.GetSearchResultInfo(self:GetID())

    if not activityId then
        AceEvent:SendMessage('LFG_LIST_SEARCH_RESULT_REMOVED', self:GetID())
        return
    end

    local name, shortName, category, group, iLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityId)
    local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(id)

    local summary, isMeetingStone, customId, version, mode, loot,
            class, itemLevel, procession, leaderPvPRating, minLevel, maxLevel, pvpRating = DecodeCommetData(comment)

    if isMeetingStone then
        self:SetVersion(version)
        self:SetMode(mode)
        self:SetLoot(loot)
        self:SetLeaderClass(class)
        self:SetLeaderItemLevel(itemLevel)
        self:SetLeaderProcession(procession)
        self:SetLeaderPvPRating(leaderPvPRating)
        self:SetSummary(summary)
        self:SetComment(nil)
        self:SetCustomID(customId)
        self:SetName(customId ~= 0 and ACTIVITY_CUSTOM_NAMES[customId] or name)
        self:SetMinLevel(minLevel or 1)
        self:SetMaxLevel(maxLevel or MAX_PLAYER_LEVEL)
        self:SetPvPRating(pvpRating or 0)
    else
        self:SetVersion(nil)
        self:SetMode(0xFF)
        self:SetLoot(0xFF)
        self:SetLeaderClass(nil)
        self:SetLeaderItemLevel(nil)
        self:SetLeaderProcession(nil)
        self:SetSummary(title)
        self:SetComment(summary)
        self:SetCustomID(0)
        self:SetName(name)
        self:SetMinLevel(1)
        self:SetMaxLevel(MAX_PLAYER_LEVEL)
        self:SetPvPRating(0)
    end

    if leader then
        self:SetLeaderShort(leader:match('^(.+)%-') or leader)
    end

    self:SetActivityID(activityId)
    self:SetIsMeetingStone(isMeetingStone)
    self:SetVoiceChat(voiceChat ~= '' and voiceChat or nil)
    self:SetItemLevel(iLvl)
    self:SetAge(age)
    self:SetIsDelisted(isDelisted)
    self:SetLeader(leader)
    self:SetNumMembers(numMembers)
    self:SetIsAnyFriend(numBNetFriends > 0 or numCharFriends > 0 or numGuildMates > 0)

    self:SetDisplayType(displayType)

    self:SetIsApplication(appStatus ~= 'none' or pendingStatus)
    self:SetIsApplicationFinished(LFGListUtil_IsStatusInactive(appStatus) or LFGListUtil_IsStatusInactive(pendingStatus))

    self:SetApplicationStatus(appStatus)
    self:SetPendingStatus(pendingStatus)
    self:SetApplicationDuration(appDuration)
    self:SetApplicationExpiration(GetTime() + appDuration)

    self:UpdateSortValue()
end

function Activity:BaseSortHandler()
    if not self._baseSortValue then
        self:UpdateSortValue()
    end
    return self._baseSortValue
end

function Activity:GetStatusSortValue()
    if not self._statusSortValue then
        self:UpdateSortValue()
    end
    return self._statusSortValue
end

function Activity:UpdateSortValue()
    self._statusSortValue = self:IsApplication() and (
                            self:IsApplicationFinished() and 1 or 0) or
                            self:IsDelisted() and 9 or
                            self:IsAnyFriend() and 2 or
                            self:IsSelf() and 3 or
                            self:IsInActivity() and 4 or 7

    self._baseSortValue = format('%d%08x%02x%02x%08x',
        self._statusSortValue,
        ACTIVITY_ORDER[self:GetActivityID()] or 0,
        self:GetMode(),
        self:GetLoot(),
        self:GetID()
    )
end

function Activity:GetModeText()
    return ACTIVITY_MODE_NAMES[self:GetMode()]
end

function Activity:GetLootText()
    return ACTIVITY_LOOT_NAMES[self:GetLoot()]
end

function Activity:GetLeaderText()
    return GetClassColoredText(self:GetLeaderClass(), self:GetLeader())
end

function Activity:GetLeaderShortText()
    return GetClassColoredText(self:GetLeaderClass(), self:GetLeaderShort())
end

function Activity:IsInActivity()
    return self:GetLeader() and IsInGroup(LE_PARTY_CATEGORY_HOME) and (UnitInRaid(self:GetLeader()) or UnitInParty(self:GetLeader()))
end

function Activity:IsSelf()
    return self:GetLeader() and UnitIsUnit(self:GetLeader(), 'player')
end

function Activity:Match(search, loot)
    if loot and loot ~= 0 then
        if self:GetLoot() ~= loot then
            return false
        end
    end
    if search then
        if self:GetSummary() and self:GetSummary():lower():match(search) then
            return true
        end
        if self:GetComment() and self:GetComment():lower():match(search) then
            return true
        end
        if self:GetLeader() and self:GetLeader():lower():match(search) then
            return true
        end
        return false
    end
    return true
end

function Activity:IsLevelValid()
    local level = UnitLevel('player')
    return level >= self:GetMinLevel() and level <= self:GetMaxLevel()
end

function Activity:IsArenaActivity()
    return IsHasPVPRating(self:GetActivityID())
end

function Activity:IsPvPRatingValid()
    local pvpRating = GetPlayerPVPRating(self:GetActivityID())
    return pvpRating >= self:GetPvPRating()
end

function Activity:IsItemLevelValid()
    local equipLevel = GetPlayerItemLevel()
    return equipLevel >= self:GetItemLevel()
end

function Activity:IsUnusable()
    return self:IsDelisted() or self:IsApplicationFinished()
end
