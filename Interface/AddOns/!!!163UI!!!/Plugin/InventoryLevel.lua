--WLK 绿 187 蓝 200 紫 200 - 284
--CTM 绿 272-333 蓝 308-359 紫 353-
local slotWeight = {
    ["INVTYPE_RELIC"] = 0.3164,
    ["INVTYPE_TRINKET"] = 0.5625,
    ["INVTYPE_2HWEAPON"] = 2.000,
    ["INVTYPE_WEAPONMAINHAND"] = 1.0000,
    ["INVTYPE_WEAPONOFFHAND"] = 1.0000,
    ["INVTYPE_RANGED"] = 2, --0.3164,
    ["INVTYPE_THROWN"] = 0, --0.3164,
    ["INVTYPE_RANGEDRIGHT"] = 2, --0.3164,
    ["INVTYPE_SHIELD"] = 1.0000,
    ["INVTYPE_WEAPON"] = 1.0000,
    ["INVTYPE_HOLDABLE"] = 1.0000,
    ["INVTYPE_HEAD"] = 1.0000,
    ["INVTYPE_NECK"] = 0.5625,
    ["INVTYPE_SHOULDER"] = 0.7500,
    ["INVTYPE_CHEST"] = 1.0000,
    ["INVTYPE_ROBE"] = 1.0000,
    ["INVTYPE_WAIST"] = 0.7500,
    ["INVTYPE_LEGS"] = 1.0000,
    ["INVTYPE_FEET"] = 0.75,
    ["INVTYPE_WRIST"] = 0.5625,
    ["INVTYPE_HAND"] = 0.7500,
    ["INVTYPE_FINGER"] = 0.5625,
    ["INVTYPE_CLOAK"] = 0.5625,
}


-- copy from ReforgeLite
local ilevel_spTable = {
  [458] = 4914,
  [463] = 5152,
  [466] = 5293,
  [470] = 5496,
  [471] = 5550,
  [474] = 5704,
  [476] = 5812,
  [478] = 5920,
  [480] = 6032,
  [483] = 6206,
  [484] = 6261,
  [487] = 6441,
  [489] = 6564,
  [490] = 6628,
  [491] = 6685,
  [493] = 6812,
  [494] = 6879,
  [496] = 7007,
  [497] = 7071,
  [498] = 7140,
  [500] = 7272,
  [501] = 7337,
  [502] = 7408,
  [503] = 7478,
  [504] = 7548,
  [505] = 7619,
  [506] = 7688,
  [507] = 7761,
  [508] = 7836,
  [509] = 7907,
  [510] = 7980,
  [511] = 8054,
  [512] = 8132,
  [513] = 8206,
  [514] = 8286,
  [515] = 8364,
  [516] = 8441,
  [517] = 8518,
  [518] = 8603,
  [519] = 8680,
  [520] = 8761,
  [521] = 8841,
  [524] = 9093,
  [525] = 9179,
  [528] = 9439,
  [532] = 9797,
}

local ilevel_upTable = {
  [1]   =  8, -- 1/1
  [373] =  4, -- 1/2
  [374] =  8, -- 2/2
  [375] =  4, -- 1/3
  [376] =  4, -- 2/3
  [377] =  4, -- 3/3
  [379] =  4, -- 1/2
  [380] =  4, -- 2/2
  [445] =  0, -- 0/2
  [446] =  4, -- 1/2
  [447] =  8, -- 2/2
  [451] =  0, -- 0/1
  [452] =  8, -- 1/1
  [453] =  0, -- 0/2
  [454] =  4, -- 1/2
  [455] =  8, -- 2/2
  [456] =  0, -- 0/1
  [457] =  8, -- 1/1
  [458] =  0, -- 0/4
  [459] =  4, -- 1/4
  [460] =  8, -- 2/4
  [461] = 12, -- 3/4
  [462] = 16, -- 4/4
  [465] =  0, -- 0/2
  [466] =  4, -- 1/2
  [467] =  8, -- 2/2
  [468] =  0, -- 0/4
  [469] =  4, -- 1/4
  [470] =  8, -- 2/4
  [471] = 12, -- 3/4
  [472] = 16, -- 4/4
  [476] =  0, -- 0/2
  [477] =  4, -- 1/2
  [478] =  8, -- 2/2
  [479] =  0, -- 0/1
  [480] =  8, -- 1/1
  [491] =  0, -- 0/2
  [492] =  4, -- 1/2
  [493] =  8, -- 2/2
  [494] =  0, -- 0/4
  [495] =  4, -- 1/4
  [496] =  8, -- 2/4
  [497] = 12, -- 3/4
  [498] = 16, -- 4/4
  [501] =  0, -- 0/4
  [502] =  4, -- 1/4
  [503] =  8, -- 2/4
  [504] = 12, -- 3/4
  [505] = 16, -- 4/4
  [506] = 20, -- 5/6
  [507] = 24, -- 6/6
}

local TYPE_WAND = "Wand"
local TYPE_WANDS = "Wands"
if(GetLocale()=="zhCN" or GetLocale()=="zhTW")then TYPE_WAND="魔杖" TYPE_WANDS="魔杖" end
--处理魔杖的问题

local function GetItemLevelUpID(link)
    local upid = tonumber(link:match ("item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+:%d+:%d+:(%d+)"))
    return upid
end

local function GetRealInventoryType(link)
    local _, _, _, ilevel, _, _, typeName, _, invType = GetItemInfo(link)
    if invType=="INVTYPE_RANGEDRIGHT" and (typeName==TYPE_WAND or typeName==TYPE_WANDS) then
        invType = "INVTYPE_WEAPON"
    end

    local upid = GetItemLevelUpID(link)
    local uplvl = upid and ilevel_upTable[upid] or 0

    return ilevel+uplvl,invType
end

local function GetItemScore(link, blizzard)
    if not (link) then return end
    local ilevel,invType = GetRealInventoryType(link)
    return ilevel, invType, blizzard and 1 or slotWeight[invType];
end

function U1GetInventoryLevelColor(avgLevel)
    --300: 0, 255, 0      333: 0, 255, 255       346: 0, 0, 255        359: 255, 0, 255        400: 255, 0, 0
    if not avgLevel or avgLevel<=0 then return .5, .5, .5 end
    if avgLevel < 300 then
        return 0, 1, 0
    elseif avgLevel <= 333 then
        return 0, 1, (avgLevel - 300) / (333 - 300) / 2 + .5
    elseif avgLevel <= 346 then
        return 0, (346 - avgLevel) / (346 - 333) / 2 + .5, 1
    elseif avgLevel <= 364 then
        return (avgLevel - 346) / (364 - 346), (364 - avgLevel) / (364 - 346) / 2, 1
    elseif avgLevel <= 400 then
        return 1, 0, (400 - avgLevel) / (400 - 364) / 2 + .5
    else
        return 1, 0, 0
    end
end

local itemLinks = {}
local ItemStats = {}

---获取unit的物品等级信息
--注意如果物品信息不全或者不是玩家则返回nil, 此外如果数据有问题则返回0对应的数据
--@param blizzard 暴雪算法 所有装备权重相同 主手为双手且副手为空时计16件物品，否则17件
--@return avgLevel, color, resilience, totalLevel, count, slotCount, itemLinks
--说明：slotCount是身上应装备的格子数，16或17，count是身上已装备的格子数，如果这两个不相等，则表示装备不全
function U1GetInventoryLevel(unit, blizzard)
    if not UnitIsPlayer(unit) then return end

    if(blizzard==nil) then blizzard = select(4,GetBuildInfo())>40200 end

    table.wipe(itemLinks) --缓存一下
    for i = 1, 17 do
        if i ~= 4 and GetInventoryItemTexture(unit, i) then
            itemLinks[i] = GetInventoryItemLink(unit, i)
            if not itemLinks[i] then return end
        end
    end

    local _, class = UnitClass(unit);

    local invType16 = itemLinks[16] and select(2, GetRealInventoryType(itemLinks[16]))
    --是否是泰坦之握，只要是双持且主手为双手武器就算。如果主手为空副手拿个双手武器，就算它是拿在主手，不影响结果
    local warriorTitan = not blizzard and (class=="WARRIOR") and itemLinks[16] and itemLinks[17] and (invType16 == "INVTYPE_2HWEAPON")

    local count, totalScore, totalLevel, totalMod = 0, 0, 0, 0
    for i = 1, 17 do
        local link = itemLinks[i]
        if (link) then
            local ilevel, invType, mod = GetItemScore(link, blizzard);
            if mod then
                if not blizzard then
                    if warriorTitan and (i == 16 or i == 17) then
                        mod = mod * 0.5
                    end
                    totalScore = totalScore + ilevel * mod
                    totalMod = totalMod + mod
                end
                count = count + 1
                totalLevel = totalLevel + ilevel
            end
        end
    end

    local avgLevel, avgLevelEquiped
    local slotCount = not itemLinks[17] and (not itemLinks[16] or invType16=="INVTYPE_2HWEAPON" or invType16=='INVTYPE_RANGED' or invType16=='INVTYPE_RANGEDRIGHT') and 15 or 16
    if blizzard then
        avgLevel = totalLevel / slotCount;
    else
        avgLevel = totalMod > 0 and totalScore / totalMod or 0;
    end

    local r, g, b = U1GetInventoryLevelColor(avgLevel)
    local color = string.format("%02x%02x%02x", r * 255, g * 255, b * 255)

    avgLevel = avgLevel > 0 and tonumber(string.format("%.1f", avgLevel)) or 0

    local resilience = 0
    local pvppower = 0
    for i = 1, 19 do
        local link = itemLinks[i]
        if (link) then
            wipe(ItemStats)
            local ItemStats = GetItemStats(link, ItemStats)
            local _, _, _, origlvl = GetItemInfo(link)
            origlvl = origlvl or 0
            local upid = GetItemLevelUpID(link)
            local uplvl = origlvl + (ilevel_upTable[upid] or 0)
            local upmod = uplvl and ilevel_spTable[uplvl]

            local resi = ItemStats.ITEM_MOD_RESILIENCE_RATING_SHORT or 0
            local power = ItemStats.ITEM_MOD_PVP_POWER_SHORT or 0
            if (resi and uplvl ~= origlvl) then
                local origmod = origlvl and ilevel_spTable[origlvl]
                if(upmod and origmod) then
                    resi = resi * upmod / origmod + .5
                    power = power * upmod / origmod + .5
                end
            end
            resilience = resilience + resi
            pvppower = pvppower + power
        end
    end

    resilience = resilience > 0 and tonumber(string.format("%.2f", resilience)) or 0
    pvppower = pvppower > 0 and tonumber(string.format("%.2f", pvppower)) or 0

    return avgLevel, color, resilience, totalLevel, count, slotCount, itemLinks, pvppower
end




do
    local enchantables = {
        BackSlot = "披",
        ChestSlot = "胸",
        FeetSlot = "脚",
        HandsSlot = "手",
        LegsSlot = "腿",
        MainHandSlot = "武",
        WristSlot = "腕",
        --HeadSlot = "头",
        ShoulderSlot = "肩",
        WristSlot = "腕",
        WaistSlot = "腰",
        SecondaryHandSlot = "副",
    }

    function U1GetUnitEnchantInfo(unit, waist_extra_slot)
        -- local isplayer = unit == 'player'
        local total, hasenchant = 0, 0
        local missing = ""

        for slot, shortname in next, enchantables do
            local link = GetInventoryItemLink(unit, GetInventorySlotInfo(slot))
            if(link) then
                local enchantid = link:match'item:%d+:(%d+):'
                enchantid = enchantid and tonumber(enchantid)

                total = total + 1

                if(enchantid > 0) then
                    hasenchant = hasenchant + 1
                else
                    if(slot == 'WaistSlot' and waist_extra_slot) then
                        hasenchant = hasenchant + 1
                    elseif #missing<12 then
                        missing = missing..shortname
                    end
                end
            end
        end

        return total, hasenchant, missing
    end
end


local slots = {
    "Head",
    "Neck",
    "Shoulder",
    "Shirt",
    "Chest",
    "Waist",
    "Legs",
    "Feet",
    "Wrist",
    "Hands",
    "Finger0",
    "Finger1",
    "Trinket0",
    "Trinket1",
    "Back",
    "MainHand",
    "SecondaryHand",
    -- "Ranged",
    "Tabard",
}

do
    local fmt = string.format
    local gem_slots = {
        EMPTY_SOCKET = true,
        EMPTY_SOCKET_BLUE = true,
        EMPTY_SOCKET_COGWHEEL = true,
        EMPTY_SOCKET_HYDRAULIC = true,
        EMPTY_SOCKET_META = true,
        EMPTY_SOCKET_NO_COLOR = true,
        EMPTY_SOCKET_PRISMATIC = true,
        EMPTY_SOCKET_RED = true,
        EMPTY_SOCKET_YELLOW = true,
    }

    local _item_stat_tbl = {}
    local get_item_stats = function(item)
        wipe(_item_stat_tbl)
        return GetItemStats(item, _item_stat_tbl)
    end

    function U1GetUnitGemInfo(unit)
        local gem_s = 0
        local slot_s = 0
        local top_s, sec_s, oth_s = 0, 0, 0
        local waist_extra_slot = false

        for _, slot in next, slots do
            local link = GetInventoryItemLink(unit, GetInventorySlotInfo(slot..'Slot'))
            if(link) then
                local i_slot, i_gem = 0, 0

                for k, v in next, get_item_stats(link) do
                    if(gem_slots[k]) then
                        i_slot = i_slot + v
                    end
                end
                slot_s = slot_s + i_slot
                --print(link:gsub("\124", "/"), i_slot, GetItemGem(link, 1), GetItemGem(link, 2), GetItemGem(link, 3))

                for i = 1, 3 do
                    local gemname, gemlink = GetItemGem(link, i)
                    if(gemlink) then
                        local name, link, quality, iLevel, reqLevel, itype, subType = GetItemInfo(gemlink)
                        gem_s = gem_s + 1
                        if(iLevel == MAX_PLAYER_LEVEL) then
                            if(quality >= 4) then
                                top_s = top_s + 1
                            else
                                sec_s = sec_s + 1
                            end
                        else
                            oth_s = oth_s + 1
                        end
                        i_gem = i_gem + 1
                    end
                end

                if(slot == 'Waist' and i_gem > i_slot) then
                    waist_extra_slot = true
                end
            end
        end

        slot_s = math.max(slot_s, gem_s)
        local fc = NORMAL_FONT_COLOR_CODE
        local res = fmt('%d/%d  (|cffa335ee%d|r/|cff0070dd%d|r/%d)',
            gem_s, slot_s, top_s, sec_s, oth_s)

        return res, waist_extra_slot
    end
end
