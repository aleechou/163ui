local _ = ...
local itemStats = {
    [1] = ITEM_MOD_SPIRIT_SHORT,
    [2] = ITEM_MOD_DODGE_RATING_SHORT,
    [3] = ITEM_MOD_PARRY_RATING_SHORT,
    [4] = ITEM_MOD_HIT_RATING_SHORT,
    [5] = ITEM_MOD_CRIT_RATING_SHORT,
    [6] = ITEM_MOD_HASTE_RATING_SHORT,
    [7] = ITEM_MOD_EXPERTISE_RATING_SHORT,
    [8] = ITEM_MOD_MASTERY_RATING_SHORT,
}

local REFORGE_TABLE_BASE = 112

local function GetReforgeID (item)
    local id = tonumber (item:match ("item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+:%d+:(%d+)"))
    return (id ~= 0 and (id - REFORGE_TABLE_BASE) or nil)
end

local reforgeTable = {
    {1, 2}, {1, 3}, {1, 4}, {1, 5}, {1, 6}, {1, 7}, {1, 8},
    {2, 1}, {2, 3}, {2, 4}, {2, 5}, {2, 6}, {2, 7}, {2, 8},
    {3, 1}, {3, 2}, {3, 4}, {3, 5}, {3, 6}, {3, 7}, {3, 8},
    {4, 1}, {4, 2}, {4, 3}, {4, 5}, {4, 6}, {4, 7}, {4, 8},
    {5, 1}, {5, 2}, {5, 3}, {5, 4}, {5, 6}, {5, 7}, {5, 8},
    {6, 1}, {6, 2}, {6, 3}, {6, 4}, {6, 5}, {6, 7}, {6, 8},
    {7, 1}, {7, 2}, {7, 3}, {7, 4}, {7, 5}, {7, 6}, {7, 8},
    {8, 1}, {8, 2}, {8, 3}, {8, 4}, {8, 5}, {8, 6}, {8, 7},
}

local function OnTooltipSetItem (tip)
    if not U1GetCfgValue(_, "TooltipReforgeStat") then return end
    local _, item = tip:GetItem ()
    if item and GetItemInfo (item) then
        local reforge = GetReforgeID (item)
        if reforge then
            local regions = {tip:GetRegions ()}
            for _, region in pairs (regions) do
                if region:GetObjectType () == "FontString" then
                    if region:GetText () == REFORGED then
                        local src = itemStats[reforgeTable[reforge][1]]
                        local dst = itemStats[reforgeTable[reforge][2]]
                        region:SetText (string.format ("%s (%s → %s)", REFORGED, src, dst))
                        region:SetTextColor(1,.5,0)
                    end
                end
            end
        end
    end
end

local function SetUpHooks ()
    CoreRawHook(GameTooltip, "OnTooltipSetItem", OnTooltipSetItem, 1);
    CoreRawHook(ItemRefTooltip, "OnTooltipSetItem", OnTooltipSetItem, 1);
    --CoreRawHook(ShoppingTooltip1, "SetHyperlinkCompareItem", OnTooltipSetItem)
    --CoreRawHook(ShoppingTooltip2, "SetHyperlinkCompareItem", OnTooltipSetItem)
    --CoreRawHook(ShoppingTooltip3, "SetHyperlinkCompareItem", OnTooltipSetItem)
    --CoreRawHook(ItemRefShoppingTooltip1, "SetHyperlinkCompareItem", OnTooltipSetItem)
    --CoreRawHook(ItemRefShoppingTooltip2, "SetHyperlinkCompareItem", OnTooltipSetItem)
    --CoreRawHook(ItemRefShoppingTooltip3, "SetHyperlinkCompareItem", OnTooltipSetItem)
end

SetUpHooks();