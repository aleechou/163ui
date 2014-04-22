
BuildEnv(...)

CLASS_MENUTABLE = {}
do
    for i = 1, GetNumClasses() do
        local name, tag, id = GetClassInfo(i)

        tinsert(CLASS_MENUTABLE, {
            text = ('|c%s%s|r'):format(RAID_CLASS_COLORS[tag].colorStr, name),
            value = id,
        })
    end
end

local EVENT_MODE_MENU_DATA = [[
团队副本
    Roll
    金团
    成就
    幻化
    开荒
地下城
    刷勇气
    刷正义
    成就
    自强
    挑战
场景战役
    刷勇气
    成就
PvP
    刷荣誉
    刷征服
    冲分
    混分
主题活动
    其他
其他
    其他
]]

local EVENT_TYPE_MENU_DATA = [[
团队副本#80#40#
    @熊猫人之谜#90#25#
        决战奥格瑞玛-10人#90#10#2,3,5,0
        决战奥格瑞玛-25人#90#25#3,6,16,0
        决战奥格瑞玛-弹性#90#25#2,3,5,0
        雷电王座#90#25#2,6,17,0
        永春台#90#25#2,6,17,0
        恐惧之心#90#25#2,6,17,0
        魔古山宝库#90#25#2,6,17,0
    @大地的裂变#85#25#
        巨龙之魂#85#25#2,6,17,0
        火焰之地#85#25#2,6,17,0
        风神王座#85#25#2,6,17,0
        黑翼血环#85#25#2,6,17,0
        暮光堡垒#85#25#2,6,17,0
        巴拉丁监狱#85#25#2,6,17,0
    @巫妖王之怒#80#25#
        冰冠堡垒#80#25#2,6,17,0
        红玉圣殿#80#25#2,6,17,0
        十字军的试炼#80#25#2,6,17,0
        奥杜尔#80#25#2,6,17,0
        黑曜石圣殿#80#25#2,6,17,0
        永恒之眼#80#25#2,6,17,0
        阿尔卡冯的宝库#80#25#2,6,17,0
!地下城#10#5#1,1,3,0
!场景战役#90#3#0,0,3,0
PvP#45#10#
    2v2#70#2#0,1,1,0
    3v3#70#3#0,1,2,0
    5v5#70#5#0,2,3,0
    评级战场#90#10#1,3,6,0
    随机战场#45#5#0,2,3,0
*主题活动#1#40#
其他#1#40#0,0,0,40
]]

-- 战场#10#40#
-- 随机战场#45#5#0,2,3,0
-- 战歌峡谷#10#10#1,3,6,0
-- 双子峰#85#10#1,3,6,0
-- 吉尔尼斯之战#85#15#0,5,10,0
-- 寇魔古寺#90#10#1,3,6,0
-- 碎银矿脉#90#10#1,3,6,0
-- 阿拉希盆地#10#15#0,5,10,0
-- 风暴之眼#35#15#0,5,10,0
-- 远古海滩#65#10#1,3,6,0
-- 深风峡谷#90#10#1,3,6,0
-- 奥特兰克山谷#45#40#5,10,25,0
-- 征服之岛#75#40#5,10,25,0

local function menuDisable(data)
    return UnitLevel('player') < GetEventMinLevel(data.value)
end

local function MakeEventMenuTable(isCreateor)
    local stack = {
        push = function(self, value)
            tinsert(self, value)
        end,
        pop = function(self)
            return tremove(self, #self)
        end,
        gettop = function(self)
            return self[#self]
        end
    }
    local menuTable = {}
    local prevDepth = 0
    local disabled = isCreateor and menuDisable or nil

    stack:push(menuTable)

    if not isCreateor then
        tinsert(menuTable, {
            text = L['全部'],
            value = 0,
        })
    end

    for str in EVENT_TYPE_MENU_DATA:gmatch('[^\r\n]+') do
        local space, control, name, minLevel, maxMember, roleNum = str:match('^( *)([@!*]?)([^ @!*]*)#(%d+)#(%d+)#(.*)%s*$')

        local depth = #space / 4
        local name = L[name]
        local eventCode = EVENT_TYPES[name]

        local info = {}
        info.text = name
        info.notClickable = control == '@' or nil
        info.value = eventCode
        info.disabled = control == '*' or disabled

        if eventCode then
            SetEventMinLevel(eventCode, minLevel)
            SetEventMaxMember(eventCode, maxMember)
            SetEventDefaultMemberRole(eventCode, roleNum)
            SetEventAllowCrossRealm(eventCode, control ~= '!')
        end
        
        if depth == prevDepth then
            tinsert(stack:gettop(), info)
        elseif depth > prevDepth then
            if depth - prevDepth > 1 then
                error('stack depth above 1', 2)
            end
            local tbl = stack:gettop()
            tbl = tbl[#tbl]
            tbl.hasArrow = true
            tbl.menuTable = {}
            tbl.notClickable = tbl.notClickable or isCreateor or nil

            tinsert(tbl.menuTable, info)
            stack:push(tbl.menuTable)
        elseif depth < prevDepth then
            for i = 1, prevDepth - depth do
                stack:pop()
            end
            tinsert(stack:gettop(), info)
        end
        prevDepth = depth
    end
    return menuTable
end

EVENT_FILTER_MENUTABLE = MakeEventMenuTable()
EVENT_CREATE_MENUTABLE = MakeEventMenuTable(true)

function InsertMenuTable(key, name, eventCode, control, minLevel, maxMember, roleNum, isWipe)
    SetEventMinLevel(eventCode, minLevel)
    SetEventMaxMember(eventCode, maxMember)
    SetEventDefaultMemberRole(eventCode, roleNum)
    SetEventAllowCrossRealm(eventCode, control ~= '!')

    for i, v in ipairs(EVENT_FILTER_MENUTABLE) do
        if v.text == key then
            local target = EVENT_FILTER_MENUTABLE[i]
            target.hasArrow = true
            target.disabled = nil
            target.menuTable = target.menuTable or {}
            if isWipe then
                wipe(target.menuTable)
            end
            tinsert(target.menuTable, {
                text = name, 
                value = eventCode,
                notClickable = control == '@' or nil,
            })
            break
        end
    end

    for i, v in ipairs(EVENT_CREATE_MENUTABLE) do
        if v.text == key then
            local target = EVENT_CREATE_MENUTABLE[i]
            target.hasArrow = true
            target.disabled = menuDisable
            target.notClickable = true
            target.menuTable = target.menuTable or {}
            if isWipe then
                wipe(target.menuTable)
            end
            tinsert(target.menuTable, {
                text = name, 
                value = eventCode,
                notClickable = control == '@' or nil,
                disabled = menuDisable or nil
            })
            break
        end
    end
end

do
    local currentMenu
    for str in EVENT_MODE_MENU_DATA:gmatch('[^\r\n]+') do
        local space, name = str:match('^(%s*)(%S+)%s*$')
        if space == '' then
            local eventCode = EVENT_TYPES[name]
            if eventCode then
                EVENT_MODE_MENUTABLE[eventCode] = EVENT_MODE_MENUTABLE[eventCode] or {}
                currentMenu = EVENT_MODE_MENUTABLE[eventCode]
            end
        elseif currentMenu then
            tinsert(currentMenu, {
                value = EVENT_MODE_TYPES[L[name]],
                text = L[name]
            })
        end
    end
end
