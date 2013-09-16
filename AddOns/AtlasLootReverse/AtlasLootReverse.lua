

-- local TT = {}
-- function TT:RegisterTooltip(tip)
--     table.insert(TT, tip);
-- end
-- function TT:AddCallback(func)
--     for _, v in ipairs(TT) do
--         if not v.__u1hooked then
--             CoreRawHook(v, "OnTooltipSetItem", function(self, ...) if self.__u1hookenable then func(self, ...) end end, true)
--         end
--         v.__u1hookenable = 1
--     end
-- end
-- function TT:RemoveCallback(func)
--     for _, v in ipairs(TT) do
--         v.__u1hookenable = nil
--     end
-- end
-- function TT:AddLine(tip, ...) tip:AddLine(...) end

--[[
AtlasLootReverse
Written by pceric
http://www.wowinterface.com/downloads/info9179-Know-It-All.html
]]
local AtlasLootReverse = LibStub("AceAddon-3.0"):NewAddon("AtlasLootReverse") -- , "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("AtlasLootReverse", true)
_G.AtlasLootReverse = AtlasLootReverse

AtlasLootReverse.title = L["AtlasLootReverse"]
AtlasLootReverse.version = GetAddOnMetadata("AtlasLootReverse", "Version")

local db
local tmp

-- Default settings
local defaults = {
    profile = {
        dbversion = "",
        alversion = "",
        whoTable = {},
        sources = {},
    }
}

-- searches a table for string s
local function tfind(t, s)
    local last
    for k, v in pairs(t) do
        if type(v) == "table" then
            tfind(v, s)
        else
            if v == s then
                tmp = last
            end
            last = v
        end
    end 
end

----------------------
--On start
function AtlasLootReverse:OnInitialize()
    -- AtlasLootReverseDBx = AtlasLootReverseDBx or {}
    -- AtlasLootReverseDBx.sources = AtlasLootReverseDBx.sources or {}
    -- AtlasLootReverseDBx.whoTable = AtlasLootReverseDBx.whoTable or {}

    db = AtlasLootReverseDBx or {}
    db.sources = db.sources or {}
    db.whoTable = db.whoTable or {}

    AtlasLootReverseDBx = db

    self.enabled = false

    local OnTooltipSetItem = function(...)
        if(AtlasLootReverse.enabled) then
            return AtlasLootReverse:OnTooltipSetItem(...)
        end
    end

    for _, tip in next, { 'GameTooltip', 'ItemRefTooltip',
        'ShoppingTooltip1', 'ShoppingTooltip2', 'ShoppingTooltip3',
        'AtlasLootTooltipTEMP' } do
        local f = _G[tip]
        if(f) then
            CoreRawHook(f, 'OnTooltipSetItem', OnTooltipSetItem, true)
        end
    end
end

----------------------
--Disabled
function AtlasLootReverse:OnDisable()
    self.enabled = false
end

----------------------
--Loaded
function AtlasLootReverse:OnEnable()
    self.enabled = true
    -- if(DEBUG_MODE) then
    --     return self:RebuildDatabase()
    -- end
end

function AtlasLootReverse:OnTooltipSetItem(tooltip, item)
    item = item or select(2, tooltip:GetItem());
    if type(item)=="string" then
        local _, itemId = strsplit(":", item)
        --TT:AddLine(self, itemId, nil, nil, nil, db.embedded)
        local from = db.whoTable[tonumber(itemId)]
        if from then
            for id in string.gmatch(from, "[^,]+") do
                local v = db.sources[tonumber(id)]
                if not string.find(v, 'Tier ') and not string.find(v, 'Tabards') and not string.find(v, 'PvP ') then
                    v = string.format(L["Drops from %s"], v)
                end
                tooltip:AddLine(v, .7, .7, 1)
            end
        end
    end
end

function AtlasLootReverse:RebuildDatabase()
    -- AtlasLootReverseDB = nil
    -- Sanity check for v6 of ALE
    -- assert(ATLASLOOT_VERSION_NUM, "Your AtlasLoot is either too old or broken!")
    if(not DEBUG_MODE) then return end
    if U1DBG then
        U1DBG.AtlasLootReverseDB = nil
        U1DBG.AtlasLootReverseDBx = nil
    end

    -- 没有安装 AtlasLoot
    if(not select(2, GetAddOnInfo'AtlasLoot')) then return end

    local atlas_version = GetAddOnMetadata('AtlasLoot', 'Version')
    local alreverse_version = GetAddOnMetadata('AtlasLootReverse', 'Version')
    -- if(db.alversion == atlas_version) and
    --     (db.dbversion == alreverse_version) then return end

    db.alversion = atlas_version
    db.dbversion = alreverse_version
    U1DBG.AtlasLootReverseDBx = db

    do
        local loader = 'AtlasLoot_Loader'
        local name, title, notes, enabled = GetAddOnInfo(loader)

        if(title) then
            if not enabled then
                EnableAddOn(loader)
            end

            if(not IsAddOnLoaded(loader)) and U1LoadAddOn then
                U1LoadAddOn(loader)
            end
        end
    end

    local zone
    local excludes = {
        [29434] = true,  -- BoJ
        [40752] = true,  -- EoH
        [40753] = true,  -- EoV
        [43102] = true,  -- Frozen Orb
        [45624] = true,  -- EoC
        [47241] = true,  -- EoT
        [49426] = true,  -- EoF
        [44990] = true,  -- CS
        [45038] = true,  -- Frag
        [46017] = true,  -- Hammer
        [47242] = true,  -- Trophy
        [49908] = true,  -- Primordial Saronite
        [50274] = true,  -- Shadowfrost Shard
        [52025] = true,  -- VMoS
        [52026] = true,  -- PMoS
        [52027] = true,  -- CMoS
    }
    local tiers = {
        ["PVP70SET"] = string.format(L["PvP %s Set"], "70"),
        ["PVP80SET"] = string.format(L["PvP %s Set"], "80"),
        ["PVP85SET"] = string.format(L["PvP %s Set"], "85"),
        ["T456SET"] = string.format(L["Tier %s"], "4/5/6"),
        ["T7T8SET"] = string.format(L["Tier %s"], "7/8"),
        ["T9SET"] = string.format(L["Tier %s"], "9"),
        ["T10SET"] = string.format(L["Tier %s"], "10"),
        ["T1112SET"] = string.format(L["Tier %s"], "11"),
    }

    local sourceMap = {}
    wipe(db.whoTable) -- Wipe the table
    wipe(db.sources)

    -- Force AtlasLoot to load all modules
    --AtlasLoot:LoadModule("all") -- (broken in 6.03)
    for _, module in pairs(AtlasLoot.Modules) do
        LoadAddOn(module[2])
    end

    local _AL_loc = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot")
    local _AL_tier_type = {"Normal", "Heroic", "10 Man", "25 Man", "RaidFinder"} --标记套装类型的
    for k, v in ipairs(_AL_tier_type) do _AL_tier_type[k] = v=="RaidFinder" and "随机团队" or _AL_loc[v] end

    for _,itable in pairs(AtlasLoot_Data) do
        for k,v in pairs(itable) do
            if string.find(k, "Normal") or string.find(k, "Heroic") or string.find(k, "25Man") or string.find(k, "RaidFinder") then  -- Doing a find because some are _A and some _H
                for _, page in pairs(v) do
                    local type0
                    local bossName = itable.info.name
                    for _,v2 in pairs(page) do
                        --warbaby add, 获取AtlasLoot的弱分类方式, 标志是v2[2] = 0
                        --{ 1, 0, "spell_nature_healingtouch", "=q6=#t11s1_1#", "=q5="..AL["Tier 11"]};
                        --{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
                        --{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#t8s5_2#", "=q5="..AL["Tier 8"].." ("..AL["10 Man"]..")"};
                        --{ 16, 0, "Spell_Nature_Lightning", "=q6=#t9s7_3a#", "=q5="..AL["Tier 9"]};
                        if type(v2)=='table' and v2[2]==0 then
                            local _,_,_type = v2[4]:find("(#.*#)")
                            if _type then
                                local _,_,_tier = _type:find("#t(%d+)s[0-9_]+#")
                                if _tier then
                                    type0 = string.format(L["Tier %s"], _tier)
                                    for _, tierType in ipairs(_AL_tier_type) do
                                        if v2[5]:find(tierType) then
                                            type0 = type0.." "..tierType
                                        end
                                    end
                                end
                            else
                                bossName = select(3, v2[4]:find("=.*=(.*)")) or bossName;
                            end

                        elseif type(v2) == "table" and type(v2[2]) == "number" and v2[2] > 0 and not excludes[v2[2]] and bossName ~= "Keys" then --and not db.whoTable[v2[2]]
                            --warbaby增加not db.whoTable[v2[2]]条件是只保留第一个，主要是因为套装会在前面获取
                            -- Sanity check for boss name
                            if not bossName then bossName = "?" end
                            if bossName=="trash" then bossName="小怪" end
                            -- Find zone name
                            if itable.info.instance and AtlasLoot_LootTableRegister.Instances[itable.info.instance] then
                                -- Some bizzare voodoo in ALE v6.02.00
                                if type(AtlasLoot_LootTableRegister.Instances[itable.info.instance]) == "string" then
                                    zone = AtlasLoot_LootTableRegister.Instances[AtlasLoot_LootTableRegister.Instances[itable.info.instance]].Info[1]
                                else
                                    zone = AtlasLoot_LootTableRegister.Instances[itable.info.instance].Info[1]
                                end
                            else
                                zone = ""
                            end
                            -- Check if non-normal zone
                            if k == "Heroic" then
                                zone = strtrim(string.format(L["Heroic %s"], zone))
                            elseif k == "25Man" then
                                zone = strtrim(string.format(L["25 Man %s"], zone))
                            elseif k == "25ManHeroic" then
                                zone = strtrim(string.format(L["25 Man Heroic %s"], zone))
                            end
                            if zone ~= "" then
                                zone = " (" .. zone .. ")"
                            end
                            -- Check to see if it drops from multiple people
                            local source = bossName .. zone
                            -- Check to see if this is a set piece
                            if type0 then
                                source = source .. " " .. type0
                            elseif itable.info.menu and tiers[itable.info.menu] then
                                source = source .. " " .. tiers[itable.info.menu]
                            end
                            if not sourceMap[source] then
                                table.insert(db.sources, source);
                                sourceMap[source] = #db.sources;
                            end
                            --if(v2[2]==60275) then grint(source) end --测试托巴掉的手套
                            source = sourceMap[source]
                            --db.whoTable[v2[2]] = source
                            local old = db.whoTable[v2[2]]
                            if old then
                                local ot = type(old)
                                if (ot=="number" and old~=source) or (ot=="string" and not old:find("[,]?"..source.."[,]?")) then
                                    db.whoTable[v2[2]] = old..","..source
                                end
                            else
                                db.whoTable[v2[2]] = source
                            end
                        end
                    end
                end
            end
        end
    end
    --for _, v in pairs(db.whoTable) do v = v:sub(1, #v-1) end

    sourceMap = nil
    collectgarbage("collect")
    print(AtlasLootReverse.title .. " 数据库已重建.")
end
