
BuildEnv(...)

local function _GetSpellPower()
    local pow = 0
    for i = 1,7 do
        pow = max(pow, GetSpellBonusDamage(i))
    end
    return pow
end

local function _GetSpellCritChance()
    local minCrit = GetSpellCritChance(2)
    for i = 1, 7 do
        minCrit = min(minCrit, GetSpellCritChance(i))
    end
    return minCrit
end

local function round(x, decimal)
    local s = 10 ^ (decimal or 0)
    return floor(x * s + 0.5) / s
end

function GetPlayerStats(role)
    local statType = 'NONE'
    local specs = {
        GetSpecialization() or 0,
        GetActiveSpecGroup() or 0,
        1, 2, 3, GetNumSpecializations() == 4 and 4 or nil,
    }

    for i, v in ipairs(specs) do
        local id, _, _, _, _, specRole = GetSpecializationInfo(v)
        if role == specRole then
            statType = SPEC_STATS[id]
            break
        end
    end

    local stats = {}
    if statType == 'TANK' then
        stats[ STAT_HIT     ] = round(GetCombatRatingBonus(CR_HIT_MELEE), 2)
        stats[ STAT_MASTERY ] = round(GetMasteryEffect(), 2)
        stats[ STAT_EXP     ] = round(GetExpertise(), 2)
        stats[ STAT_ARMOR   ] = round(UnitArmor('player'), 2)
        stats[ STAT_DODGE   ] = round(GetDodgeChance(), 2)
        stats[ STAT_PARRY   ] = round(GetParryChance(), 2)
        stats[ STAT_BLOCK   ] = round(GetBlockChance(), 2)
    elseif statType == 'CASTER' then
        stats[ STAT_HIT     ] = round(GetCombatRatingBonus(CR_HIT_SPELL), 2)
        stats[ STAT_MASTERY ] = round(GetMasteryEffect(), 2)
        stats[ STAT_SPELL   ] = round(_GetSpellPower(), 2)
        stats[ STAT_CRIT    ] = round(_GetSpellCritChance(), 2)
        stats[ STAT_HASTE   ] = round(UnitSpellHaste('player'), 2)
    elseif statType == 'RDPS' then
        stats[ STAT_HIT     ] = round(GetCombatRatingBonus(CR_HIT_RANGED), 2)
        stats[ STAT_MASTERY ] = round(GetMasteryEffect(), 2)
        stats[ STAT_EXP     ] = round(select(3, GetExpertise()), 2)
        stats[ STAT_ATTACK  ] = round(UnitRangedAttackPower('player'), 2)
        stats[ STAT_CRIT    ] = round(GetRangedCritChance(), 2)
        stats[ STAT_HASTE   ] = round(GetRangedHaste(), 2)
    elseif statType == 'MDPS' then
        stats[ STAT_HIT     ] = round(GetCombatRatingBonus(CR_HIT_MELEE), 2)
        stats[ STAT_MASTERY ] = round(GetMasteryEffect(), 2)
        stats[ STAT_EXP     ] = round(GetExpertise(), 2)
        stats[ STAT_ATTACK  ] = round(UnitAttackPower('player'), 2)
        stats[ STAT_CRIT    ] = round(GetCritChance(), 2)
        stats[ STAT_HASTE   ] = round(GetMeleeHaste(), 2)
    else
        -- stats[ STAT_MONEY   ] = floor(GetMoney() / 10000)
        stats = nil
    end
    return stats
end

local _RAID_CATEGORIES = { 15164, 15096, 14823 }
local _REAL_EVENTNAME = {
    [0x00011194] = '玛里苟斯',
    [0x000111fb] = '冬拥湖',
    [0x0001118d] = '龙神之厅',
}

local _RAID_DATA = setmetatable({}, {__index = function(o, eventCode)
    local data = { bossNames = {}, modes = {} }
    local name = _REAL_EVENTNAME[eventCode] or strsplit('-', EVENT_NAMES[eventCode])

    local id, fullName, bossName, modeName, mode, index
    local bossIndexCache = {}

    for _, category in ipairs(_RAID_CATEGORIES) do
        for i = 1, GetCategoryNumAchievements(category) do
            id, fullName = GetAchievementInfo(category, i)

            if fullName:match(name) then
                bossName, modeName = fullName:match('^([^ ]+) ?\-? ?(.*（.*）)$')
                if bossName then
                    if not bossIndexCache[bossName] then
                        tinsert(data.bossNames, bossName)

                        bossIndexCache[bossName] = #data.bossNames
                    end
                    local mode = modeName:match('普通') and 1 or
                                 modeName:match('英雄') and 2 or
                                 modeName:match('随机') and 3 or
                                 modeName:match('弹性') and 4 or
                                 modeName:match('大十字军') and 2 or 1

                    local index = bossIndexCache[bossName]
                    data[mode] = data[mode] or {}
                    data[mode][index] = data[mode][index] or {}

                    tinsert(data[mode][index], id)
                end
            end
        end
    end

    -- TOC的最后BOSS
    if eventCode == 0x00011272 then
        tinsert(data.bossNames, '完成十字军的试炼')

        data[1][5] = { 4044, 4046 }
        data[2][5] = { 4045, 4047 }
    end

    for k in pairs(data) do
        if type(k) == 'number' then
            tinsert(data.modes, k)
        end
    end
    sort(data.modes)

    o[eventCode] = data
    return data
end})

local function _IsCompleted(list)
    for _, id in ipairs(list) do
        if tonumber((GetStatistic(id))) then
            return true
        end
    end
end

function GetPlayerRaidProgression(eventCode)
    if bit.band(eventCode, TYPE_MATCH) ~= EVENT_TYPE_RAID then
        return
    end
    local data = _RAID_DATA[eventCode]
    if not data then
        return
    end

    local result = {}
    for _, mode in ipairs(data.modes) do
        local value = 0
        for i, v in ipairs(data[mode]) do
            if _IsCompleted(v) then
                value = bit.bor(value, bit.lshift(1, i-1))
            end
        end
        result[mode] = value
    end
    return result
end

function GetRaidBossNames(eventCode)
    return _RAID_DATA[eventCode].bossNames
end

function GetPlayerPVPRating(eventCode)
    if bit.band(eventCode, TYPE_MATCH) ~= EVENT_TYPE_ARENA then
        return 0
    end
    local index = bit.band(eventCode, NAME_MATCH)
    index = index > 4 and 4 or index
    return (GetPersonalRatedInfo(index)) or 0
end

function GetGroupUnitList()
    if IsInRaid() then
        return _RAID_UNITS
    else
        return _PARTY_UNITS
    end
end

function PlayerIsGroupLeader()
    return UnitIsGroupLeader('player') or not IsInGroup(LE_PARTY_CATEGORY_HOME)
end

local roleCache = { NONE = true }
function PlayerIsRoleValid(role)
    roleCache.TANK,
    roleCache.HEALER,
    roleCache.DAMAGER = UnitGetAvailableRoles('player')

    return roleCache[role]
end

function tonumberall(...)
    local cache = {}
    for i = 1, select('#', ...) do
        cache[i] = tonumber((select(i, ...))) or 0
    end
    return unpack(cache)
end

function PackMemberRole(...)
    return ('%d/%d,%d/%d,%d/%d,%d/%d'):format(...)
end

function UnpackMemberRole(data)
    if not data or type(data) ~= 'string' then
        return 0, 0, 0, 0, 0, 0, 0, 0
    end
    return tonumberall(data:match('^(%d+)/(%d+),(%d+)/(%d+),(%d+)/(%d+),(%d+)/(%d+)$'))
end

function GetRoleIconSmall(role)
    if role == 'NONE' then
        return [[Interface\AddOns\RaidBuilder\Media\RoleNone]], {0, 19/32, 1/128, 20/32}
    else
        return [[Interface\LFGFrame\UI-LFG-ICON-PORTRAITROLES]], {GetTexCoordsForRoleSmallCircle(role)}
    end
end

function GetRoleIconLarge(role)
    local data = ROLE_DATA[role]
    if not data then
        return
    end
    return data.texture, data.coords
end

function GetRoleInfo(role)
    local data = ROLE_DATA[role]
    if not data then
        return
    end
    return data.text, data.note
end

local _RAID_MODE_TEXTS = {
    [1] = L['普通'],
    [2] = L['英雄'],
    [3] = L['随机'],
    [4] = L['弹性'],
}

local _RAID_MODE_ORDER = {
    3, 4, 1, 2
}

function FormatProgressionTitle(progession)
    if type(progession) ~= 'table' then
        return
    end
    local sb = {}
    for _, i in ipairs(_RAID_MODE_ORDER) do
        if progession[i] then
            tinsert(sb, _RAID_MODE_TEXTS[i])
        end
    end
    if #sb == 0 then
        return
    end
    return  table.concat(sb, '/')
end

local function FormatProgressionTex(value, bossIndex)
    local killed = bit.band(value, bit.lshift(1, bossIndex-1)) > 0
    
    return killed and [[|TINTERFACE\FriendsFrame\StatusIcon-Online:16|t]] or [[|TINTERFACE\FriendsFrame\StatusIcon-Offline:16|t]]
end

function FormatProgressionText(progession, bossIndex)
    local sb = {}
    for _, i in ipairs(_RAID_MODE_ORDER) do
        if progession[i] then
            tinsert(sb, FormatProgressionTex(progession[i], bossIndex))
        end
    end
    return table.concat(sb)
end

function GroupDisband()
    for i = GetNumGroupMembers() - 1, 1, -1 do
        UninviteUnit('raid'..i)
    end
end

local CURRENT_REALM = GetRealmName():gsub('%s+', '')
function GetFullName(name, realm)
    if not name then
        return
    end

    realm = realm and realm:gsub('%s+', '')
    realm = realm ~= '' and realm or nil

    local found = name:find('%-')
    if found and realm then
        error('error name', 2)
    end

    if found then
        return name
    else
        return ('%s-%s'):format(name, realm or CURRENT_REALM)
    end
end

local _UnitName = _G.UnitName
function UnitName(unit)
    local name, realm = _UnitName(unit)
    if name and realm and realm ~= '' then
        return name .. '-' .. realm
    else
        return name
    end
end

function UnitFullName(unit)
    return GetFullName(UnitName(unit))
end

function GetGameDateTime(isReset)
    local weekday, month, day, year = CalendarGetDate()
    local hour, minute

    if isReset then
        hour, minute = '03', '00'
    else
        hour, minute = GetGameTime()
    end

    return format('%s/%s/%s %s:%s', month, day, year, hour, minute)
end

function GetEventMinLevel(eventCode)
    return EVENT_MINLEVELS[eventCode] or 1
end

function SetEventMinLevel(eventCode, minLevel)
    EVENT_MINLEVELS[eventCode] = tonumber(minLevel)
end

function GetEventMaxMember(eventCode)
    return EVENT_MAXMEMBERS[eventCode] or 40
end

function SetEventMaxMember(eventCode, maxMember)
    EVENT_MAXMEMBERS[eventCode] = tonumber(maxMember)
end

function GetEventDefaultMemberRole(eventCode)
    local roles = EVENT_DEFAULT_MEMBERROLES[eventCode]
    if roles then
        return unpack(roles)
    else
        return 0, 0, 0, 0
    end
end

function SetEventDefaultMemberRole(eventCode, memberRole)
    EVENT_DEFAULT_MEMBERROLES[eventCode] = {tonumberall(strsplit(',', memberRole or '0,0,0,0'))}
end

function GetEventAllowCrossRealm(eventCode)
    return EVENT_ALLOW_CROSSREALMS[eventCode]
end

function SetEventAllowCrossRealm(eventCode, flag)
    EVENT_ALLOW_CROSSREALMS[eventCode] = flag or nil
end

function FormatBattleTag(battleTag)
    if battleTag then
        local tag, rand = battleTag:match('^(.+)#(%d+)$')
        if tag then
            return ('|cff57AADD%s|r|cff416380#%s|r'):format(tag, rand)
        end
    end
    return UNKNOWN
end

function GetEventModeMenuTable(eventCode)
    return EVENT_MODE_MENUTABLE[bit.band(eventCode, TYPE_MATCH)]
end

function GetUnitLogoIndex(name, btag)
    local fullName = GetFullName(name)

    local servercache = RemoteDataCache:GetLogoIndex(fullName, btag)
    if servercache then
        return servercache
    end

    local localdata = UNIT_LOGO_LIST[btag] or UNIT_LOGO_LIST[fullName]
    if localdata then
        return localdata
    end

    local leaderboard = RemoteDataCache:GetLeaderBoardIndex(fullName)
    if leaderboard then
        return leaderboard
    end
    
    return UNIT_LOGO_NONE
end

function GetUnitLogoTexture(name, btag)
    local index = GetUnitLogoIndex(name, btag)
    return UNIT_LOGO_TEXTURE[index]
end

function GetWebEventUrl(eventId, eventSource)
    if eventSource == 1 then
        return ([[http://127.0.0.1/%d]]):format(eventId)
    end
end

function UnitInGroup(unit)
    return UnitInRaid(unit) or UnitInParty(unit)
end
