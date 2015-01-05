
BuildEnv(...)

CurrentActivity = Addon:NewClass('CurrentActivity')

function CurrentActivity:Constructor(...)
    local data = ...
    if type(data) == 'table' then
        self:FromAddon(...)
    elseif data then
        self:FromSystem(...)
    end
end

local attrs = {
    'ActivityID',
    'ActivityItemLevel',
    'ActivityComment',
    'ActivityTitle',
    'ActivityVoice',

    'ActivityType',
    'ActivityTypeText',

    'ActivityMode',
    'ActivityModeText',

    'ActivityLoot',
    'ActivityLootText',

    'ActivitySummary',

    'MinLevel',
    'MaxLevel',
    'PvPRating',

    'LeaderClass',
    'LeaderItemLevel',
    'LeaderProgression',

    'AddonVersion',
    'IsMeetingStone',
}

for i, v in ipairs(attrs) do
    CurrentActivity['Set' .. v] = function(self, value)
        self[v] = value
    end
    CurrentActivity['Get' .. v] = function(self)
        return self[v]
    end
end

function CurrentActivity:FromAddon(data)
    for k, v in pairs(data) do
        local func = self['Set' .. k]
        if type(func) == 'function' then
            func(self, v)
        end
    end
end

function CurrentActivity:FromSystem(activityID, ilvl, title, comment, voiceChat)
    local summary, isMeetingStone, activityType, shortVersion, 
        activityMode, activityLoot, leaderClass, leaderItemLevel, 
        leaderProgression, _, minLevel, maxLevel, pvpRating = DecodeCommetData(comment)

    self:SetActivityID(activityID)
    self:SetActivityItemLevel(ilvl)
    self:SetActivityVoice(voiceChat)
    self:SetActivityComment(comment)
    self:SetActivityTitle(title)

    if isMeetingStone then
        self:SetActivityType(activityType)
        self:SetActivityMode(activityMode)
        self:SetActivityLoot(activityLoot)
        self:SetActivitySummary(summary)

        self:SetLeaderClass(leaderClass)
        self:SetLeaderItemLevel(leaderItemLevel)
        self:SetLeaderProgression(leaderProgression)

        self:SetMinLevel(minLevel or 0)
        self:SetMaxLevel(maxLevel or 100)
        self:SetPvPRating(pvpRating or 0)

        self:SetAddonVersion(shortVersion)
        self:SetIsMeetingStone(true)
    else
        self:SetActivitySummary(title)
        self:SetMinLevel('')
        self:SetMaxLevel('')
    end

end

function CurrentActivity:GetSummaryText()
    return format('%s-%s-%s-%s', L['集合石'], self:GetActivityLootText(), self:GetActivityModeText(), self:GetActivityTypeText())
end

function CurrentActivity:GetCreateArguments()
    return self:GetActivityID(), self:GetSummaryText(), self:GetActivityItemLevel(), self:GetActivityVoice(), format('%s%s', self:GetActivitySummary(), (CodeCommentData(self)))
end
