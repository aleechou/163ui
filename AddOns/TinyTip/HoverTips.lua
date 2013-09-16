

local r, g, b = 1, 136/255, 0	-- color

TIP_SHOW_SYSTEM_ID = 1;
TIP_ADD_ITEM_INFO = 1;
local function addItemInfo(self, link)
    if not TIP_ADD_ITEM_INFO then return end
    local id = tonumber(link:match("item:(%d+):"))
    
    if id then
        local _, _, _, level, _, itype, subtype, stack = GetItemInfo(id)
        if level then
            local typetext = itype and subtype and string.format('%s - %s', itype, subtype) or nil

            if stack > 1 then
                self:AddLine(string.format(ITEM_LEVEL, level), 1, 1, 1)
            end
            
            if TIP_SHOW_SYSTEM_ID then
                self:AddDoubleLine(typetext..(stack~=1 and "("..stack..")" or ""), "ID:"..id, r, g, b, r, g, b)
            else
                if stack ~= 1 then
                    self:AddDoubleLine(typetext, '一组:'..stack, r, g, b, r, g, b)
                else
                    self:AddLine(typetext, r, g, b)
                end
            end
            self:Show()
        end
    end
end

local function hooktip(tip)
    local clear = tip:GetScript("OnTooltipCleared")
    tip:SetScript("OnTooltipCleared", function(self, ...)
        if clear then clear(self, ...) end
        tip._lastItemLink = nil
    end)

    local set = tip:GetScript('OnTooltipSetItem')

    tip:SetScript('OnTooltipSetItem', function(self, ...)
        if set then
            set(self, ...)
        end
        
        local link = select(2, self:GetItem())
        if link and link ~= self._lastItemLink then
            self._lastItemLink = link
            addItemInfo(self, link)
        end
    end)

    local set2 = tip.SetAction;
    if(set2) then
        hooksecurefunc(tip, "SetAction", function(self, actionId)
            if not TIP_SHOW_SYSTEM_ID or IsAddOnLoaded("XXXEventAlertMod") then return end
            local type, id, bookType = GetActionInfo(actionId);
            if(type=="spell" and id and id > 0) then
                self:AddLine("法术ID: "..id, r, g, b)
                self:Show()
            end
        end)
    end

    local set2 = tip.SetSpellByID;
    if(set2) then
        hooksecurefunc(tip, "SetSpellByID", function(self, id)
            if not TIP_SHOW_SYSTEM_ID or IsAddOnLoaded("XXXEventAlertMod") then return end
            self:AddLine("法术ID: "..id, r, g, b)
            self:Show()
        end)
    end

    set2 = tip.SetSpellBookItem;
    if(set2) then
        hooksecurefunc(tip, "SetSpellBookItem", function(self, slot, type)
            if not TIP_SHOW_SYSTEM_ID or IsAddOnLoaded("XXXEventAlertMod") then return end
            local _, id = GetSpellBookItemInfo(slot, type);
            if id then
                self:AddLine("法术ID: "..id, r, g, b)
                self:Show()
            end
        end)
    end

    set2 = tip.SetUnitAura;
    if(set2) then
        hooksecurefunc(tip, "SetUnitAura", function(self, unit, index, filter)
            if not TIP_SHOW_SYSTEM_ID or IsAddOnLoaded("XXXEventAlertMod") then return end
            local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, index, filter);
            if spellId then
                self:AddLine("法术ID: "..spellId, r, g, b)
                self:Show()
            end
        end)
    end

    set2 = tip.SetUnitBuff;
    if(set2) then
        hooksecurefunc(tip, "SetUnitBuff", function(self, unit, index)
            if not TIP_SHOW_SYSTEM_ID or IsAddOnLoaded("XXXEventAlertMod") then return end
            local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitBuff(unit, index);
            if spellId then
                self:AddLine("法术ID: "..spellId, r, g, b)
                self:Show()
            end
        end)
    end

    set2 = tip.SetUnitDebuff;
    if(set2) then
        hooksecurefunc(tip, "SetUnitDebuff", function(self, unit, index)
            if not TIP_SHOW_SYSTEM_ID or IsAddOnLoaded("XXXEventAlertMod") then return end
            local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(unit, index);
            if spellId then
                self:AddLine("法术ID: "..spellId, r, g, b)
                self:Show()
            end
        end)
    end

    set2 = tip.SetHyperlink;
    if(set2) then
        hooksecurefunc(tip, "SetHyperlink", function(self, link)
            if not TIP_SHOW_SYSTEM_ID or IsAddOnLoaded("XXXEventAlertMod") then return end
            local _, _, type, id = link:find("\124H([a-z]-):([0-9]+)")
            if id and (type=="spell" or type=="talent") then
                self:AddLine("ID: "..id, r, g, b)
                self:Show()
            end
        end)
    end

end

hooktip(GameTooltip)
hooktip(ItemRefTooltip)
hooktip(ShoppingTooltip1)
hooktip(ShoppingTooltip2)
CoreDependCall("AtlasLoot", function() if(AtlasLootTooltipTEMP) then hooktip(AtlasLootTooltipTEMP) end end)

local orig1, orig2 = {}, {}
local GameTooltip = GameTooltip

local linktypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true, instancelock = true}

local TooltipUpdate --分开写，因为里面要用
TooltipUpdate = function(self)
    --判断是否鼠标仍在超链接上
    local focusOnLink = GetMouseFocus() focusOnLink = focusOnLink and focusOnLink.GetObjectType and focusOnLink:GetObjectType()=="HyperLinkButton"
    if not focusOnLink then
        --和OnHyperlinkLeave一样，但是不能直接调用
        GameTooltip._tooltipLink = nil
        local frame = GameTooltip:GetOwner()
        if frame and frame.UpdateTooltip == TooltipUpdate then frame.UpdateTooltip = nil end
        GameTooltip.comparing = false
        GameTooltip:Hide()
    else
        local shouldShow = IsModifiedClick("COMPAREITEMS") or (GetCVarBool("alwaysCompareItems") and not GameTooltip:IsEquippedItem())
        if ( not GameTooltip.comparing and shouldShow and GameTooltip:GetOwner() ) then
            GameTooltip:SetOwner(GameTooltip:GetOwner(), "ANCHOR_TOPLEFT")
            GameTooltip:SetHyperlink(GameTooltip._tooltipLink);
            GameTooltip:Show();
            GameTooltip.comparing = true;
        elseif ( GameTooltip.comparing and not shouldShow ) then
            for _, frame in pairs(GameTooltip.shoppingTooltips) do
                frame:Hide();
            end
            GameTooltip.comparing = false;
        end
    end
end

local function OnHyperlinkEnter(frame, link, ...)
    local linktype = link:match("^([^:]+)")
    if linktype and linktypes[linktype] then
        GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
        GameTooltip._tooltipLink = link
        frame.UpdateTooltip = TooltipUpdate
        TooltipUpdate(GameTooltip)
    elseif linktype == 'battlepet' then
        local _, speciesID, level, breedQuality, maxHealth, power, speed, id = strsplit(":", link)
        speciesID = speciesID and tonumber(speciesID)
        if(speciesID and speciesID > 0) then
            BattlePetToolTip_Show(speciesID, tonumber(level), tonumber(breedQuality), tonumber(maxHealth), tonumber(power), tonumber(speed), tonumber(id))
            -- BattlePetTooltip:ClearAllPoints()
            BattlePetTooltip:SetOwner(frame, 'ANCHOR_TOPLEFT')
        end
    end
    if orig1[frame] then return orig1[frame](frame, link, ...) end
end

local function OnHyperlinkLeave(frame, ...)
    if frame.UpdateTooltip then frame.UpdateTooltip(frame) end
    GameTooltip._tooltipLink = nil
    frame.UpdateTooltip = nil
    GameTooltip.comparing = false
    GameTooltip:Hide()
    BattlePetTooltip:Hide()
    if orig2[frame] then return orig2[frame](frame, ...) end
end


local _G = getfenv(0)
for i=1, NUM_CHAT_WINDOWS do
    local frame = _G["ChatFrame"..i]
    orig1[frame] = frame:GetScript("OnHyperlinkEnter")
    frame:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)

    orig2[frame] = frame:GetScript("OnHyperlinkLeave")
    frame:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)
end
