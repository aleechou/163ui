
BuildEnv(...)

local AceSerializer = LibStub('AceSerializer-3.0')

function GetClassColorText(className, text)
    local color = RAID_CLASS_COLORS[className]
    return format('|c%s%s|r', color.colorStr, text)
end

function IsGroupLeader()
    return  not IsInGroup(LE_PARTY_CATEGORY_HOME) or UnitIsGroupLeader('player', LE_PARTY_CATEGORY_HOME)
end

function IsActivityManager()
    return UnitIsGroupLeader('player', LE_PARTY_CATEGORY_HOME) or (IsInRaid(LE_PARTY_CATEGORY_HOME) and UnitIsGroupAssistant('player', LE_PARTY_CATEGORY_HOME))
end

local function MakeCustomActivityMenuTable(activityId, baseFilter, isCreator)
    local customData = ACTIVITY_CUSTOM_DATA[activityId]
    if not customData then
        return
    end

    local fullName, _, categoryId, groupId, _, filters = C_LFGList.GetActivityInfo(activityId)
    local menuTable = {}
    if isCreator then
        local data = {}
        data.text = fullName
        data.fullName = fullName
        data.value = GetActivityCode(activityId, nil, categoryId, groupId)
        data.categoryId = categoryId
        data.groupId = groupId
        data.activityId = activityId
        data.filters = filters
        data.baseFilter = baseFilter

        tinsert(menuTable, data)
    end

    for _, id in ipairs(customData) do
        local data = {}
        data.text = ACTIVITY_CUSTOM_NAMES[id]
        data.fullName = format('"\001^1^N%d^', id)
        data.categoryId = categoryId
        data.groupId = groupId
        data.activityId = activityId
        data.filters = filters
        data.baseFilter = baseFilter
        data.customId = id
        data.value = GetActivityCode(activityId, id, categoryId, groupId)

        tinsert(menuTable, data)
    end
    return menuTable
end

local function MakeActivityMenuTable(activityId, baseFilter, isCreator)
    local fullName, _, categoryId, _, _, filters = C_LFGList.GetActivityInfo(activityId)

    local data = {}
    data.text = fullName
    data.fullName = fullName
    data.categoryId = categoryId
    data.groupId = groupId
    data.activityId = activityId
    data.filters = filters
    data.baseFilter = baseFilter
    data.value = GetActivityCode(activityId, nil, categoryId, groupId)

    local menuTable = MakeCustomActivityMenuTable(activityId, baseFilter, isCreator)
    if menuTable then
        data.menuTable = menuTable
        data.hasArrow = true
        data.notClickable = isCreator
    end
    return data
end

local function MakeGroupMenuTable(categoryId, groupId, baseFilter, isCreator)
    local data = {}
    data.text = C_LFGList.GetActivityGroupInfo(groupId)
    data.fullName = data.text
    data.categoryId = categoryId
    data.groupId = groupId
    data.baseFilter = baseFilter
    data.notClickable = categoryId == 1 or isCreator
    data.value = not data.notClickable and GetActivityCode(nil, nil, categoryId, groupId)

    local menuTable = {}

    for _, activityId in ipairs(C_LFGList.GetAvailableActivities(categoryId, groupId)) do
        tinsert(menuTable, MakeActivityMenuTable(activityId, baseFilter, isCreator))
    end

    if #menuTable > 0 then
        data.menuTable = menuTable
        data.hasArrow = true
    end
    return data
end

local function MakeVersionMenuTable(categoryId, versionId, baseFilter, isCreator)
    local data = {}
    data.text = _G['EXPANSION_NAME'..versionId]
    data.notClickable = true

    local menuTable = {}

    for _, groupId in ipairs(C_LFGList.GetAvailableActivityGroups(categoryId)) do
        if CATEGORY[versionId].groups[groupId] then
            tinsert(menuTable, MakeGroupMenuTable(categoryId, groupId, baseFilter, isCreator))
        end
    end

    for _, activityId in ipairs(C_LFGList.GetAvailableActivities(categoryId)) do
        if CATEGORY[versionId].activities[activityId] and select(4, C_LFGList.GetActivityInfo(activityId)) == 0 then
            tinsert(menuTable, MakeActivityMenuTable(activityId, baseFilter, isCreator))
        end
    end

    if #menuTable > 0 then
        data.menuTable = menuTable
        data.hasArrow = true
    else
        return
    end
    return data
end

local function MakeCategoryMenuTable(categoryId, baseFilter, isCreator)
    local name, _, autoChoose = C_LFGList.GetCategoryInfo(categoryId)
    local data = {}
    data.text = name
    data.categoryId = categoryId
    data.baseFilter = baseFilter
    data.notClickable = isCreator
    data.value = not data.notClickable and GetActivityCode(nil, nil, categoryId)

    local menuTable = {}

    if categoryId == 2 or categoryId == 3 then
        for i = #MAX_PLAYER_LEVEL_TABLE, 0, -1 do
            local versionMenu = MakeVersionMenuTable(categoryId, i, baseFilter, isCreator)
            if versionMenu then
                tinsert(menuTable, versionMenu)
            end
        end
    elseif autoChoose and categoryId ~= 6 then
        return MakeActivityMenuTable(C_LFGList.GetAvailableActivities(categoryId)[1], baseFilter, isCreator)
    else
        for _, groupId in ipairs(C_LFGList.GetAvailableActivityGroups(categoryId)) do
            tinsert(menuTable, MakeGroupMenuTable(categoryId, groupId, baseFilter, isCreator))
        end
        for _, activityId in ipairs(C_LFGList.GetAvailableActivities(categoryId)) do
            if select(4, C_LFGList.GetActivityInfo(activityId)) == 0 then
                tinsert(menuTable, MakeActivityMenuTable(activityId, baseFilter, isCreator))
            end
        end
    end

    if #menuTable > 0 then
        data.menuTable = menuTable
        data.hasArrow = true
    end
    return data
end

local function MakeMenuTable(list, baseFilter, isCreator)
    list = list or {}

    for _, categoryId in ipairs(C_LFGList.GetAvailableCategories(baseFilter)) do
        if categoryId ~= 6 or baseFilter ~= LE_LFG_LIST_FILTER_PVE then
            tinsert(list, MakeCategoryMenuTable(categoryId, baseFilter, isCreator))
        end
    end

    return list
end

function GetActivitesMenuTable(isCreator)
    local list = {}
    MakeMenuTable(list, LE_LFG_LIST_FILTER_PVE, isCreator)
    MakeMenuTable(list, LE_LFG_LIST_FILTER_PVP, isCreator)
    return list
end

function ToggleCreatePanel(activityID)
    MainPanel:SelectPanel(ManagerPanel)
    if not CreatePanel:IsActivityCreated() then
        CreatePanel:SelectActivity(activityID)
    end
end

function GetPlayerClass()
    return (select(3, UnitClass('player')))
end

function GetPlayerItemLevel()
    return floor(GetAverageItemLevel())
end

function DecodeCommetData(comment)
    if not comment or comment == '' then
        return nil
    end
    local summary, data = comment:match('^(.*)"\001(.+)$')
    if data then
        return summary, AceSerializer:Deserialize(data)
    else
        return comment
    end
end

function CodeCommentData(activity)
    local activityID = activity:GetActivityID()
    local data = format('"\001%s', AceSerializer:Serialize(
        activity:GetActivityType(),
        ADDON_VERSION_SHORT,
        activity:GetActivityMode(),
        activity:GetActivityLoot(),
        GetPlayerClass(),
        GetPlayerItemLevel(),
        GetPlayerRaidProgression(activityID),
        GetPlayerPVPRating(activityID),
        activity:GetMinLevel(),
        activity:GetMaxLevel(),
        activity:GetPvPRating()))

    return data, strlenutf8(data)
end

function CodeDescriptionData(activity)
    if not activity:IsMeetingStone() then
        return nil, 0
    else
        local activityId = activity:GetActivityID()
        local data = format('"\001%s', AceSerializer:Serialize(GetPlayerRaidProgression(activityId), GetPlayerPVPRating(activityId)))
        return data, strlenutf8(data)
    end
end

function DecodeDescriptionData(description)
    if not description or description == '' then
        return
    end
    local summary, data = description:match('^(.*)"\001(.+)$')
    if data then
        return summary, AceSerializer:Deserialize(data)
    else
        return description
    end
end

function GetClassColoredText(class, text)
    if not class or not text then
        return text
    end
    local color = RAID_CLASS_COLORS[class]
    if color then
        return format('|c%s%s|r', color.colorStr, text)
    end
    return text
end

function GetActivityCode(activityId, customId, categoryId, groupId)
    if activityId and (not categoryId or not groupId) then
        categoryId, groupId = select(3, C_LFGList.GetActivityInfo(activityId))
    end
    return format('%d-%d-%d-%d', categoryId or 0, groupId or 0, activityId or 0, customId or 0)
end

function GetRaidBossNames(eventCode)
    return _RAID_DATA[eventCode].bossNames
end

local PVP_INDEXS = {
    [6] = 1,
    [7] = 1,
    [8] = 1,
    [19] = 2,
}

function IsHasPVPRating(activityID)
    return PVP_INDEXS[activityID]
end

function GetPlayerPVPRating(activityID)
    local ratingType = PVP_INDEXS[activityID]
    if not ratingType then
        return
    end

    if ratingType == 2 then
        return (GetPersonalRatedInfo(4))
    else
        return max((GetPersonalRatedInfo(1)), (GetPersonalRatedInfo(2)), (GetPersonalRatedInfo(3)))
    end
end

function GetPlayerBattleTag()
    return (select(2, BNGetInfo()))
end

function GetPlayerRaidProgression(activityID)
    local list = RAID_PROGRESSION_LIST[activityID]

    if not list then
        return
    end

    local result = 0
    for i, v in ipairs(list) do
        if tonumber((GetStatistic(v.id))) then
            result = bit.bor(result, bit.lshift(1, i - 1))
        end
    end

    return result
end

function GetProgressionTex(value, bossIndex)
    local killed = bit.band(value, bit.lshift(1, bossIndex-1)) > 0

    return killed and [[|TINTERFACE\FriendsFrame\StatusIcon-Online:16|t]] or [[|TINTERFACE\FriendsFrame\StatusIcon-Offline:16|t]]
end

function GetActivityName(id)
    return ACTIVITY_CUSTOM_NAMES[id] or ACTIVITY_NAME_CACHE[id]
end
