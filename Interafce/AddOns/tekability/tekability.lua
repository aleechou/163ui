local L = {
    ["Head"] = INVTYPE_HEAD,
    ["Shoulder"] = INVTYPE_SHOULDER,
    ["Waist"] = INVTYPE_WAIST,
    ["Legs"] = INVTYPE_LEGS,
    ["Feet"] = INVTYPE_FEET,
    ["Wrist"] = INVTYPE_WRIST,
    ["Hands"] = INVTYPE_HAND,
    ["MainHand"] = INVTYPE_WEAPONMAINHAND,
    ["SecondaryHand"] = INVTYPE_WEAPONOFFHAND,
    ['Chest'] = INVTYPE_CHEST,
}                      

local SLOTIDS, FONTSIZE, SLOTS = {}, 12, {
    "Head", "Shoulder", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands",
    "MainHand", "SecondaryHand",
}
for _,slot in pairs(SLOTS) do
    SLOTIDS[slot] = GetInventorySlotInfo(slot .. "Slot")
end
local frame = CreateFrame("Frame", 'tekability', CharacterFrame)
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:NewDataObject("tekability", {
    type = "data source",
    icon = "Interface\\Minimap\\Tracking\\Repair",
    text = "100%",
    configname = '耐久', -- XXX ChocolateBar
})


do
    local tip = CreateFrame('GameTooltip', 'tekability_tooltip', nil, 'GameTooltipTemplate')
    tip:SetOwner(UIParent, 'ANCHOR_NONE')
    frame.tooltip = tip

    local moneyFrame = CreateFrame("Frame", "tekability_MoneyFrame", CharacterModelFrame, "SmallMoneyFrameTemplate") 
    MoneyFrame_SetType(moneyFrame, "STATIC");	
    moneyFrame:SetPoint("BOTTOMLEFT", PaperDollFrame, "TOPLEFT", 60, -365);
    frame.moneyFrame = moneyFrame

    local text = moneyFrame:CreateFontString(nil ,"ARTWORK", "GameFontNormal");	
    text:SetPoint("BOTTOMLEFT", moneyFrame, "TOPLEFT", -2, 2);	
    text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
    frame.repairText = text

    frame.repairCost = 0

    frame.SLOTIDS = SLOTIDS
end

local function RYGColorGradient(perc)
    local relperc = perc*2 % 1
    if perc <= 0 then       return           1,       0, 0
    elseif perc < 0.5 then  return           1, relperc, 0
    elseif perc == 0.5 then return           1,       1, 0
    elseif perc < 1.0 then  return 1 - relperc,       1, 0
    else                    return           0,       1, 0 end
end


local fontstrings = setmetatable({}, {
    __index = function(t,i)
        local gslot = _G["Character"..i.."Slot"]
        assert(gslot, "Character"..i.."Slot does not exist")

        local fstr = gslot:CreateFontString(nil, "OVERLAY")
        local font, _, flags = NumberFontNormal:GetFont()
        fstr:SetFont(font, FONTSIZE, flags)
        fstr:SetPoint("CENTER", gslot, "BOTTOM", 0, 8)
        t[i] = fstr
        return fstr
    end,
})
frame.fontstrings = fontstrings


function frame:OnEvent(event, arg1)
    if event == "ADDON_LOADED" and arg1:lower() ~= "tekability" then
        for i,fstr in pairs(fontstrings) do
            -- Re-apply the font, so that we catch any changes to NumberFontNormal by
            -- addons like ClearFont
            local font, _, flags = NumberFontNormal:GetFont()
            fstr:SetFont(font, FONTSIZE, flags)
        end
        return
    end

    self.repairCost = 0
    local min = 1
    for slot,id in pairs(SLOTIDS) do
        local v1, v2 = GetInventoryItemDurability(id)
        if v1 and v2 and v2 ~= 0 then
            min = math.min(v1/v2, min)
            local str = fontstrings[slot]
            str:SetTextColor(RYGColorGradient(v1/v2))
            str:SetText(string.format("%d%%", v1/v2*100))
        else
            local str = rawget(fontstrings, slot)
            if str then str:SetText(nil) end
        end

        local hasItem, _, cost = self.tooltip:SetInventoryItem('player', id)
        if(hasItem and cost) then
            self.repairCost = self.repairCost + cost
        end
    end

    if(self.repairCost == 0) then
        self.repairText:SetText'无需修理'
    else
        self.repairText:SetText(REPAIR_COST)
    end
    MoneyFrame_Update(self.moneyFrame:GetName(), self.repairCost)

    local format = "|cff%02x%02x%02x%d%%"
    local r,g,b = RYGColorGradient(min)
    dataobj.text = string.format(format, r*255, g*255, b*255, min*100)
end


frame:SetScript("OnEvent", frame.OnEvent)
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("UPDATE_INVENTORY_DURABILITY")


------------------------
--      Tooltip!      --
------------------------

local function GetTipAnchor(frame)
    local x,y = frame:GetCenter()
    if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
    local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or
    (x < UIParent:GetWidth()/3) and "LEFT" or ""
    local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
    return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end


function dataobj.OnLeave() GameTooltip:Hide() end


function dataobj.OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    GameTooltip:SetPoint(GetTipAnchor(self))
    GameTooltip:ClearLines()

    GameTooltip:AddLine("耐久度")

    for slot,id in pairs(SLOTIDS) do
        local v1, v2 = GetInventoryItemDurability(id)

        if v1 and v2 and v2 ~= 0 then
			local val = string.format("%d%%", v1/v2*100)
            GameTooltip:AddDoubleLine(L[slot] or slot, val, 1, 1, 1, RYGColorGradient(v1/v2))
        end
    end

    if(frame.repairCost == 0) then
        GameTooltip:AddLine' '
        GameTooltip:AddDoubleLine(REPAIR_COST, NONE)
    else
        SetTooltipMoney(GameTooltip, frame.repairCost, nil, REPAIR_COST)
    end

    GameTooltip:Show()
end
