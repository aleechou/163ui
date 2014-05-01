
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):GetLocale('WowSocial_UI')

local ChatEmoteCache = {}
local AnnEmoteCache = {}
for i, v in ipairs(EmoteData) do
    ChatEmoteCache[v.Name] = (' |T%s:14|t '):format(v.Icon)
    AnnEmoteCache[v.Name] = ('|T%s:14:14:0:-8|t'):format(v.Icon)
end

function FormatMessage(msg)
    return msg:gsub('{([^{}%s]+)}', ChatEmoteCache)
end

function FormatAnnMessage(msg)
    return msg:gsub('%f[%S](%a[%w+.-]+://%S+)', '|Hurl:%1|h|cff00ffff[%1]|r|h'):gsub('\n', '<br />'):gsub('{([^{}%s]+)}', AnnEmoteCache)
end

local SEX_MAPS = {
    [2] = 'MALE',
    [3] = 'FEMALE',
}

function GetChatName(chatType, target)
    if chatType == 'GROUP' then
        return GetChatGroupName(target)
    elseif chatType == 'WHISPER' then
        return GetUserColoredName(target)
    end
end

function GetChatUserList(chatType, target)
    if chatType == 'GROUP' then
        return GetChatGroupUserList(target)
    end
end

function SendMessage(chatType, target, msg)
    if chatType == 'GROUP' then
        return SendChatGroupMessage(target, msg)
    end
end

function UnpackChatLog(data)
    local stamp, msg, name, guid, status = strsplit('\n', data)
    stamp = tonumber(stamp, 16)
    return name, msg, date('%m-%d %H:%M', stamp), status
end

function GetUserColoredName(name)
    local name, realm, fullname, isSameRealm = GetUserNameInfo(name)
    name = isSameRealm and name or fullname

    local info = GetUserInfo(name)
    if not info or not info.Class then
        return ('|cffffd100%s|r'):format(name)
    end
    local color = RAID_CLASS_COLORS[info.Class]
    if not color then
        return ('|cffffd100%s|r'):format(name)
    end
    return ('|c%s%s|r'):format(color.colorStr, name)
end

function GetUserName(name)
    local name, realm, fullname, isSameRealm = GetUserNameInfo(name)
    return isSameRealm and name or fullname
end

function GetUserNameColor(name, withOnline)
    local info = GetUserInfo(name)
    local class = info and info.Class
    local isOnline = IsUserOnline(name)

    if withOnline and not isOnline then
        return 0.5, 0.5, 0.5
    else
        local color = class and RAID_CLASS_COLORS[class]
        if not color then
            return 1, 0.82, 0
        else
            return color.r, color.g, color.b
        end
    end
end

function GetUserIcon(name, round)
    local info = GetUserInfo(name)
    if info then
        if info.Avatar and (info.Avatar >= 1 and info.Avatar <= AVATAR_LIST_COUNT) then
            return [[Interface\Icons\]] .. AvatarList[info.Avatar]
        else
            local target = round and (GetShortName(PLAYER_NAME) == name and 'player' or table.concat({UnitName('target')}, '-') == name and 'target' or UnitInParty(IsSameRealm(name) and GetShortName(name) or name) and (IsSameRealm(name) and {GetShortName(name)} or {name}))
            if target then
                return target
            elseif info.Race and info.Sex then
                local coords = RACE_ICON_TCOORDS[info.Race:upper() .. '_' .. SEX_MAPS[info.Sex]]
                if coords then
                    return round and
                        [[INTERFACE\GLUES\CHARACTERCREATE\UI-CHARACTERCREATE-RACESROUND]] or
                        [[INTERFACE\GLUES\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], unpack(coords)
                end
            end
        end
    end
    return [[INTERFACE\ICONS\INV_Misc_QuestionMark]]
end

function GetOfficeIcon(office)
    if office == 0 then
        return
    elseif office == 1 then
        return [[INTERFACE\GROUPFRAME\UI-GROUP-ASSISTANTICON]]
    elseif office == 2 then
        return [[INTERFACE\GROUPFRAME\UI-Group-LeaderIcon]]
    end
end

local NETEASE_GROUP_ICONS = {
    Alliance = [[INTERFACE\ICONS\Achievement_PVP_A_A]],
    Horde = [[INTERFACE\ICONS\Achievement_PVP_H_H]],
    Neutral = 3,
}

function GetIconPath(id)
    return [[Interface\Icons\]] .. AvatarList[id]
end

function GetChatIcon(chatType, target)
    if chatType == 'GROUP' then
        if IsChatGroupPublic(target) then
            -- return [[INTERFACE\ICONS\Mail_GMIcon]]
            -- return NETEASE_GROUP_ICONS[UnitFactionGroup('player')]
            return [[INTERFACE\ICONS\Achievement_ChallengeMode_Gold]]
        else
            return [[Interface\Icons\]] .. AvatarList[GetChatGroupIcon(target)]
        end
    elseif chatType == 'WHISPER' then
        return GetUserIcon(target, true)
    end
end

function KickUnitFromChatGroup(gid, target)
    KickChatGroup(gid, target)
end

function GetCityInfo(code)
    if code == 0 then
        return L['保密']
    end

    if type(code) ~= 'number' then
        error(([[bad argument #1 to 'GetCityName' (number expected, got %s)]]):format(type(code)), 2)
    end

    local province = floor(code / 100)

    return CityData[0][province] .. ' - ' .. (CityData[province] and CityData[province][code] or '')
end

function GetClassName(class)
    local name = ClassData[class]
    if name then
        return ('|c%s%s|r'):format(RAID_CLASS_COLORS[class].colorStr, name)
    end
    return UNKNOWN
end

function GetRaceName(race)
    local name = RaceData[race]
    if name then
        return ('|cff00ff00%s|r'):format(name)
    end
    return UNKNOWN
end

local band = bit.band
local lshift = bit.lshift
local tconcat = table.concat

local _InterestCache = setmetatable({}, {__index = function(o, k)
    local cache = {}
    for i, v in ipairs(InterestList) do
        if band(k, lshift(1, i-1)) > 0 then
            tinsert(cache, InterestList[i])
        end
    end
    cache.Text = tconcat(cache, ' ')
    o[k] = cache
    return cache
end})

local _OnlineTimeCache = setmetatable({}, {__index = function(o, k)
    local cache = {}
    for i, v in ipairs(OnlineTimeList) do
        if band(k, lshift(1, i-1)) > 0 then
            tinsert(cache, OnlineTimeList[i])
        end
    end
    cache.Text = tconcat(cache, ' ')
    o[k] = cache
    return cache
end})

function GetInterestTable(value)
    return _InterestCache[value]
end

function GetOnlineTimeTable(value)
    return _OnlineTimeCache[value]
end

function GetInterestText(value)
    return _InterestCache[value].Text
end

function GetOnlineTimeText(value)
    return _OnlineTimeCache[value].Text
end

local CACHEIN = {}
function WowSocialUI_OnShow_In(object)
    if not CACHEIN[object] then
        local f = CreateFrame('Frame')
        f:SetParent(object)

        local ag = object:CreateAnimationGroup()
        ag:SetLooping('NONE')

        local startPoint = ag:CreateAnimation('Translation')
        startPoint:SetOrder(1)
        startPoint:SetDuration(0)

        local alpha = ag:CreateAnimation('Alpha')
        alpha:SetOrder(2)
        alpha:SetChange(1)
        alpha:SetDuration(0.3)

        local stopPoint = ag:CreateAnimation('Translation')
        stopPoint:SetOrder(2)
        stopPoint:SetDuration(0.3)
        stopPoint:SetSmoothing('OUT')

        local function OnShow(self)

            if self:GetScript('OnUpdate') then
                return
            end

            object:SetAlpha(0)

            local t = GetTime() + 0.04

            self:SetScript('OnUpdate', function(self)
                if ag:IsPlaying() then
                    ag:Stop()
                end
                if GetTime() > t then
                    self:SetScript('OnUpdate', nil)

                    local offset = 10
                    local _, _, worldWidth, worldHeight = UIParent:GetRect()
                    local x, y, objectWidth, objectHeight = object:GetRect()

                    local x1 = (x + objectWidth/2) / worldWidth
                    local y1 = (y + objectHeight) / worldHeight
                    local side = x1 < 0.4 and 'LEFT' or x1 > 0.70 and 'RIGHT'
                    if not side then
                        side = y1 < 0.20 and 'BOTTOM' or 'TOP'
                    end

                    if side == 'TOP' then
                        startPoint:SetOffset(0, offset)
                        stopPoint:SetOffset(0, - offset)
                    elseif side == 'LEFT' then
                        startPoint:SetOffset(- offset, 0)
                        stopPoint:SetOffset(offset, 0)
                    elseif side == 'RIGHT' then
                        startPoint:SetOffset(offset, 0)
                        stopPoint:SetOffset(- offset, 0)
                    elseif side == 'BOTTOM' then
                        startPoint:SetOffset(0, - offset)
                        stopPoint:SetOffset(0, offset)
                    end

                    ag:Play()
                end
            end)

        end

        ag:SetScript('OnPlay', function()
            object:SetAlpha(0)
        end)

        ag:SetScript('OnFinished', function()
            object:SetAlpha(1)
        end)

        f:SetScript('OnShow', OnShow)

        f:SetScript('OnHide', function(self)
            if ag:IsPlaying() then
                ag:Stop()
            end
        end)

        CACHEIN[object] = ag
    end
end

local CACHEOUT = {}
function WowSocialUI_OnShow_Out(object, handler)
    if not CACHEOUT[object] then
        local parent = handler and object:GetParent() or object
        local ag = parent:CreateAnimationGroup()
        ag:SetLooping('NONE')

        local alpha = ag:CreateAnimation('Alpha')
        alpha:SetChange(-1)
        alpha:SetDuration(0.3)

        ag:SetScript('OnFinished', function()
            if handler then
                handler(object)
            else
                parent:Hide()
            end
        end)

        CACHEOUT[object] = ag
    end

    CACHEOUT[object]:Play()
end
_G.WowSocialUI_OnShow_In=WowSocialUI_OnShow_In
_G.WowSocialUI_OnShow_Out=WowSocialUI_OnShow_Out