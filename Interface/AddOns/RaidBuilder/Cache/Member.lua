
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
    -- 'Fans',
    'Message',
    'RaidInfo',
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
    return GetColoredName(self:GetName(), self:GetClass())
end

function Member:GetClassText()
    return GetColoredClass(self:GetClass())
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

-- function Member:GetMessage()
--     local msgId = self:GetMsgId()

--     return msgId and QUICK_MSG_NAMES[msgId] or self:GetComment()
-- end

function Member:BaseSortHandler()
    if not self.baseSortValue then
        self.baseSortValue = format('%7s%12s%04d',
            self:GetRole(),
            self:GetClass(),
            9999 - self:GetItemLevel()
        )
    end
    return self.baseSortValue
end
