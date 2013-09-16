
if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, addon = ...
local L = addon.L


local lbButtons = {}
local spelllsts = {}
local totemIds = {
    79, -- 大地
    80, -- 火
    81, -- 空气
    82, -- 水
}

-- local CATEGORY = GetSpellInfo(120217)

local update = function()
    for _, fid in next, totemIds do
        local name, desc, numSlots, isKnown = GetFlyoutInfo(fid)
        if(not spelllsts[fid]) then
            spelllsts[fid] = {}
        end
        local lst = spelllsts[fid]

        wipe(lst)

        if(isKnown) then
            for slot = 1, numSlots do
                local spellID, overrideSpellID, isKnown, spellName, slotSpecID = GetFlyoutSlotInfo(fid, slot)
                if(isKnown) then
                    addon:BuildSpellList(lst, spellID)
                end
            end
        end

        local button = lbButtons[name]
        if(not button) then
            button = addon:CreateActionButton("Shaman"..name, name, nil, 300, "TOTEM")
            lbButtons[name] = button
        end
        button:SetScrollable(lst, 'spell1')
        button:InvokeMethod'OnTalentSwitch'

        local isShown = button:IsShown()
        if(isKnown and not isShown) then
            button:SetAttribute('missspell', nil)
            button:Show()
        elseif(isShown and not isKnown) then
            button:SetAttribute('missspell', name)
            button:Hide()
        end
    end
end


addon:__163_OnSpellChanged(update)

