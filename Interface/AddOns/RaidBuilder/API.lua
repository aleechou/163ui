
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

local _REAL_EVENTNAME = {
    [0x1DFEF00] = '玛里苟斯',
    [0x1DFFF00] = '冬拥湖',
    [0x1DFDF00] = '龙神之厅',
    [0x1B7B601] = '决战奥格瑞玛',
    [0x1B7B602] = '决战奥格瑞玛',
    [0x1B7B604] = '决战奥格瑞玛',
    [0x1B7B608] = '决战奥格瑞玛',
}

local _RAID_WVER_CATEGORIES = {
    [0xB00000] = 15164,
    [0xC00000] = 15096,
    [0xD00000] = 14823,
}

local _RAID_DATA = setmetatable({}, {__index = function(o, eventCode)
    local data = { bossNames = {}, modes = {} }

    local wver = bit.band(eventCode, EVENT_MATCH_WVER)
    local category = _RAID_WVER_CATEGORIES[wver]

    if category then
        local name = _REAL_EVENTNAME[eventCode] or strsplit('-', EVENT_NAMES[eventCode] or '')
        local id, fullName, bossName, modeName, mode, index
        local bossIndexCache = {}

        for i = 1, GetCategoryNumAchievements(category) do
            id, fullName = GetAchievementInfo(category, i)

            if fullName:match(name) then
                bossName, modeName = fullName:match('^([^ ]+) ?\-? ?(.*（.*）)$')
                if bossName then
                    bossName = bossName:gsub('^杀死', '')
                                       :gsub('^击败', '')
                                       :gsub('^消灭', '')
                                       :gsub('^解救', '')
                                       :gsub('^战胜', '')
                                       :gsub('之死$', '')

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

        -- TOC的最后BOSS
        if eventCode == 0x1DFBF00 then
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
    end

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
    if bit.band(eventCode, EVENT_MATCH_TYPE) ~= EVENT_TYPE_RAID then
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

local PVP_INDEXS = {
    [0x4001001] = 1,
    [0x4001002] = 2,
    [0x4001003] = 3,
    [0x4008001] = 4,
}

function IsHasPVPRating(eventCode)
    return PVP_INDEXS[eventCode]
end

function GetPlayerPVPRating(eventCode)
    local index = PVP_INDEXS[eventCode]
    if not index then
        return 0
    end
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

function GetPlayerRoles()
    roleCache.TANK,
    roleCache.HEALER,
    roleCache.DAMAGER = UnitGetAvailableRoles('player')

    return roleCache
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
    return table.concat(sb, '/')
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

-- function SetEventMinLevel(eventCode, minLevel)
--     EVENT_MINLEVELS[eventCode] = tonumber(minLevel)
-- end

function GetEventMaxMember(eventCode)
    return EVENT_MAXMEMBERS[eventCode] or 40
end

-- function SetEventMaxMember(eventCode, maxMember)
--     EVENT_MAXMEMBERS[eventCode] = tonumber(maxMember)
-- end

function GetEventDefaultMemberRole(eventCode)
    local roles = EVENT_DEFAULT_MEMBERROLES[eventCode]
    if roles then
        return unpack(roles)
    else
        return 0, 0, 0, 0
    end
end

-- function SetEventDefaultMemberRole(eventCode, memberRole)
--     EVENT_DEFAULT_MEMBERROLES[eventCode] = {tonumberall(strsplit(',', memberRole or '0,0,0,0'))}
-- end

function GetEventAllowCrossRealm(eventCode)
    -- return EVENT_ALLOW_CROSSREALMS[eventCode]
    return true
end

-- function SetEventAllowCrossRealm(eventCode, flag)
--     -- EVENT_ALLOW_CROSSREALMS[eventCode] = flag or nil
-- end

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
    return EVENT_MODE_MENUTABLE[bit.band(eventCode, EVENT_MATCH_TYPE)]
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

function GetUnitLogoName(name, btag)
    local index = GetUnitLogoIndex(name, btag)
    return UNIT_LOGO_NAMES[index] or nil
end

function GetUnitLogoTexture(name, btag)
    local index = GetUnitLogoIndex(name, btag)
    return UNIT_LOGO_TEXTURE[index]
end

function GetWebEventUrl(eventId, eventSource)
    if eventSource == 1 then
        return ([[http://z.wowchina.com/activity/detail/%d]]):format(eventId)
    end
end

function UnitInGroup(unit)
    return UnitInRaid(unit) or UnitInParty(unit)
end

function _format(str, ...)
    for i = 1, select('#', ...) do
        str = str:gsub(format('{%d}', i), (select(i, ...)))
    end
    return str
end

function strpadright(str, width, char)
    if char and #char > 1 then
        error('char error', 2)
    end
    return str .. strrep(char or ' ', width - #str)
end

-- function strpadleft(str, width, char)
--     if char and #char > 1 then
--         error('char error', 2)
--     end
--     return strrep(char or ' ', width - #str) .. str
-- end

if IsAddOnLoaded('WowSocial') then
    local function _GetWowSocialEnv()
        BuildEnv('WowSocial')
        return _ENV
    end

    local WowSocialEnv = _GetWowSocialEnv()

    local ExportFuncs = {
        'InviteChatGroup',
        'GetOwnChatGroupList',
        'GetJoinedChatGroupList',
        'SendChatGroupMessage',
    }

    for i, v in ipairs(ExportFuncs) do
        _ENV[v] = WowSocialEnv[v]
    end
end


local function riter(t, i)
    i = i - 1
    if i > 0 then
        return i, t[i]
    end
end

function ripairs(t)
    assert(type(t) == 'table')

    return riter, t, #t + 1
end

function GetEventCodeInfo(eventCode)
    local cate = bit.band(0x0F000000, eventCode)
    local sub  = bit.band(0x00F00000, eventCode)
    local id   = bit.band(0x000FF000, eventCode)
    local diff = bit.band(0x00000F00, eventCode)
    local area = bit.band(0x000000FF, eventCode)

    return cate, sub, id, diff, area
end

local CHAT_FLAG_RAIDBUILDER = '|TInterface\\AddOns\\Raidbuilder\\Media\\Icon:16:16:0:0:32:32:0:32:0:32|t'
function MakeChatEvent(event, ...)
    for i, v in ipairs(CHAT_FRAMES) do
        local frame = _G[v]
        if frame and frame:IsEventRegistered(event) then
            local script = frame:GetScript('OnEvent')
            if script then
                -- script(frame, event, ...)
                MakeMessage(frame, event, ...)
            end
        end
    end
end

function MakeMessage(frame, event, text, target)
    local chatType = strsub(event, 10)
    local info = ChatTypeInfo[chatType]
    local chatGroup = Chat_GetChatCategory(chatType)
    local playerLink = format('|Hplayer:%s:0:%s:%s|h ', target, chatGroup, target)
    local body = format(_G['CHAT_' .. chatType .. '_GET'] .. text, CHAT_FLAG_RAIDBUILDER .. playerLink .. '[' .. target .. ']|h')

    if CHAT_TIMESTAMP_FORMAT then
        body = format('%s%s', BetterDate(CHAT_TIMESTAMP_FORMAT, time()), body)
    end

    local accessID = ChatHistory_GetAccessID(chatGroup, target)
    local typeID = ChatHistory_GetAccessID(chatType, chatTarget, nil)

    frame:AddMessage(body, info.r, info.g, info.b, info.id, false, accessID, typeID)
end

local orig_SendChatMessage = SendChatMessage
local lastSendTime = time()
function _G.SendChatMessage(text, chatType, language, channel)
    local realChannel = type(channel) == 'string' and channel:gsub('@', '-')
    if realChannel and chatType == 'WHISPER' and channel:find('@') and not Invite:IsSameRealm(realChannel) then
        if time() - lastSendTime > 1 then
            Logic:SendSocket(realChannel, 'WHISPER', text)
            MakeChatEvent('CHAT_MSG_WHISPER_INFORM', text, channel, '', '', nil, 'RAIDBUILDER', 0, 0, nil, nil, 0, nil)
            lastSendTime = time()
        else
            SendSystemMessage(L['请勿频繁密语'])
        end
    else
        orig_SendChatMessage(text, chatType, language, channel)
    end
end
