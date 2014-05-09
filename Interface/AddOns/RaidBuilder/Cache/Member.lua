
BuildEnv(...)

Member = RaidBuilder:NewClass('Member')

function Member:Constructor(proxy)
    self.proxy = proxy or {}
end

function Member:GetProxy()
    return self.proxy
end

function Member:SetProxy(proxy)
    self.proxy = proxy
end

local attr = {
    'Name',
    'BattleTag',
    'Class',
    'Level',
    'ItemLevel',
    'PVPRating',
    'Role',
    'Stats',
    'Progression',
    'ApplyTime',
    'Fans',
}

for i, v in ipairs(attr) do
    Member['Set' .. v] = function(self, value)
        self.proxy[v] = value
    end

    Member['Get' .. v] = function(self)
        return self.proxy[v]
    end
end

function Member:GetNameText()
    local color = RAID_CLASS_COLORS[self:GetClass()]
    if color then
        return ('|c%s%s|r'):format(color.colorStr, self:GetName())
    else
        return self:GetName()
    end
end

function Member:GetClassText()
    local color = RAID_CLASS_COLORS[self:GetClass()]
    if color then
        return ('|c%s%s|r'):format(color.colorStr, CLASS_NAMES[self:GetClass()])
    else
        return self:GetClass()
    end
end

function Member:GetStatInfo(key)
    return self:GetStats() and self:GetStats()[key]
end

function Member:GetBattleTagText()
    return FormatBattleTag(self:GetBattleTag())
end

function Member:GetMemberLogoTexture()
    return GetUnitLogoTexture(self:GetName(), self:GetBattleTag())
end

function Member:GetMemberLogoIndex()
    return GetUnitLogoIndex(self:GetName(), self:GetBattleTag())
end
