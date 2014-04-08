local StatLogic = LibStub("LibStatLogic-1.2")
local InspectLess = LibStub("LibInspectLess-1.0")

local OFFSET_X, OFFSET_Y = 0, 1;

local slots = {
    [1] = "Head",
    [2] = "Neck",
    [3] = "Shoulder",
    [4] = "Shirt",
    [5] = "Chest",
    [6] = "Waist",
    [7] = "Legs",
    [8] = "Feet",
    [9] = "Wrist",
    [10] = "Hands",
    [11] = "Finger0",
    [12] = "Finger1",
    [13] = "Trinket0",
    [14] = "Trinket1",
    [15] = "Back",
    [16] = "MainHand",
    [17] = "SecondaryHand",
    [18] = "Ranged",
    [19] = "Tabard",
}

local function SetOrHookScript(frame, scriptName, func)
    if( frame:GetScript(scriptName) ) then
        frame:HookScript(scriptName, func);
    else
        frame:SetScript(scriptName, func);
    end
end

function RatingSummary_OnLoad(self)
    self:RegisterEvent("VARIABLES_LOADED");
    self:RegisterEvent("ADDON_LOADED");
    self:RegisterEvent("UNIT_INVENTORY_CHANGED");

    InspectLess:RegisterCallback("InspectLess_InspectItemReady", RatingSummary_InspectItemReady)
    InspectLess:RegisterCallback("InspectLess_InspectReady", RatingSummary_InspectReady)
    SetOrHookScript(GearManagerDialogPopup, "OnShow", RatingSummary_InspectFrame_OnHide)
    if CoreDependCall then
        CoreDependCall("Blizzard_TradeSkillUI", function()
            SetOrHookScript(TradeSkillFrame, "OnShow", RatingSummary_InspectFrame_OnHide)
        end)
    end
end

function RatingSummary_SetupHook()
    hooksecurefunc("InspectPaperDollFrame_OnShow", RatingSummary_InspectFrame_SetGuild);
    SetOrHookScript(InspectFrame, "OnShow", RatingSummary_InspectFrame_SetGuild);
    SetOrHookScript(InspectFrame, "OnHide", RatingSummary_InspectFrame_OnHide);
    hooksecurefunc("InspectFrame_UnitChanged", RatingSummary_InspectFrame_UnitChanged);
end

function RatingSummary_UpdateAnchor(doll, insp)
    if not doll then doll = PaperDollFrame:IsVisible() elseif doll<0 then doll = nil end
    if not insp then insp = InspectFrame and InspectFrame:IsVisible() elseif insp<0 then insp = nil end

    local at, ax, ay = nil, 0, 0
    if InspectEquip_InfoWindow and InspectEquip_InfoWindow:IsVisible() then
        at = InspectEquip_InfoWindow; ax=1; ay=-1
    elseif(doll) then
        at = PaperDollFrame; ax=OFFSET_X; ay=OFFSET_Y
    elseif(insp) then
        at = InspectFrame; ax=OFFSET_X; ay=OFFSET_Y
    end

    local af = nil;
    if RatingSummaryTargetFrame:IsVisible() then
        RatingSummarySelfFrame:ClearAllPoints()
        RatingSummarySelfFrame:SetPoint("TOPLEFT", RatingSummaryTargetFrame, "TOPRIGHT", 0, 0)
        af = RatingSummaryTargetFrame
    elseif RatingSummarySelfFrame:IsVisible() then
        af = RatingSummarySelfFrame
    end

    if(at and af) then
        af:ClearAllPoints();
        af:SetPoint("TOPLEFT", at, "TOPRIGHT", ax, ay)
    end

end

function RatingSummary_OnEvent(self, event, ...)
    local arg1, arg2, arg3 = ...;

    if event == "VARIABLES_LOADED" then
        if RATING_SUMMARY_ANNOUNCE then DEFAULT_CHAT_FRAME:AddMessage(RATING_SUMMARY_ANNOUNCE) end
        RatingSummarySelfFrame:SetScale(0.90)
        RatingSummaryTargetFrame:SetScale(0.90)

        SetOrHookScript(PaperDollFrame, "OnShow", RatingSummary_PaperDollFrame_OnShow);
        SetOrHookScript(PaperDollFrame, "OnHide", RatingSummary_PaperDollFrame_OnHide);
    end

    if event == "ADDON_LOADED" and arg1=="Blizzard_InspectUI" then
        RatingSummary_SetupHook();
    end

    if  event == "UNIT_INVENTORY_CHANGED" then
        if ((arg1 == "player") and RatingSummarySelfFrame:IsVisible()) then
            RatingSummary_HideFrame(RatingSummarySelfFrame);
            if (RatingSummaryTargetFrame:IsVisible()) then
                RatingSummary_ShowFrame(RatingSummarySelfFrame,RatingSummaryTargetFrame,UnitName("player"),0,0);
            else
                RatingSummary_ShowFrame(RatingSummarySelfFrame,PaperDollFrame,UnitName("player"),OFFSET_X,OFFSET_Y);
            end
        elseif ( InspectFrame and InspectFrame:IsVisible() and arg1 == InspectFrame.unit and RatingSummaryTargetFrame:IsVisible()) then
            RatingSummary_HideFrame(RatingSummaryTargetFrame);
            RatingSummary_ShowFrame(RatingSummaryTargetFrame,InspectFrame,UnitName(InspectFrame.unit),OFFSET_X,OFFSET_Y);
            RatingSummary_ShowFrame(RatingSummarySelfFrame,RatingSummaryTargetFrame,UnitName("player"),0,0);
        end
    end
end

function RatingSummary_PaperDollFrame_OnShow()
    if not InspectFrame or not InspectFrame:IsVisible() then
        RatingSummary_ShowFrame(RatingSummarySelfFrame,PaperDollFrame,UnitName("player"),OFFSET_X,OFFSET_Y);
    end
    RatingSummary_UpdateAnchor(1)
end

function RatingSummary_PaperDollFrame_OnHide()
    if not InspectFrame or not InspectFrame:IsVisible() then
        RatingSummary_HideFrame(RatingSummarySelfFrame);
    end
    RatingSummary_UpdateAnchor(-1)
end

function RatingSummary_InspectFrame_SetGuild(self)
    if not self.unit then return end
    if InspectLess:IsDone() and InspectLess:GetGUID()==UnitGUID(self.unit) then
        RatingSummary_InspectItemReady("InspectLess_InspectItemReady", self.unit, InspectLess:GetGUID(), InspectLess:IsDone());
    end
    local guild, level, levelid = GetGuildInfo(self.unit)
    if(guild) then
        InspectTitleText:Show();
        InspectTitleText:SetText("<"..guild.."> "..level);
    else
        InspectTitleText:SetText("");
    end
end

function RatingSummary_InspectItemReady(event, unit, guid, ready)
    if(not InspectFrame or not InspectFrame:IsVisible()) then return end;
    RatingSummary_ShowFrame(RatingSummaryTargetFrame,InspectFrame,UnitName(InspectFrame.unit),OFFSET_X,OFFSET_Y,ready);
    RatingSummary_ShowFrame(RatingSummarySelfFrame,RatingSummaryTargetFrame,UnitName("player"),0,0);
    RatingSummary_UpdateAnchor(nil, 1, nil)
end

function RatingSummary_InspectReady(event, unit, guid, done)
    if done then
        local frame = RatingSummaryTargetFrame;

        if frame:IsVisible() and not frame.talented then
            local tiptext = getglobal(frame:GetName().."Text"):GetText();

            --主天赋显示在装备等级后
            local talent = GetInspectSpecialization(unit);
            talent = talent and talent>0 and select(2, GetSpecializationInfoByID(talent))
            if talent then tiptext = tiptext:gsub("([^\n]*"..RATING_SUMMARY_ITEM_LEVEL_SHORT.."：".."[^\n]*)", "%1 ("..select(2, GetSpecializationInfo(talent, true))..")") end

            tiptext = tiptext.."\n\n"..RatingSummary_GetTalentString(true)
            frame.talented = true;
            RatingSummary_SetFrameText(frame, nil, tiptext, InspectFrame.unit);
        end
    end
end
function RatingSummary_InspectFrame_OnHide()
    RatingSummary_HideFrame(RatingSummaryTargetFrame);
    RatingSummary_HideFrame(RatingSummarySelfFrame);
    RatingSummary_UpdateAnchor(nil, -1, nil)
end

function RatingSummary_InspectFrame_UnitChanged()
    if ( InspectFrame and InspectFrame:IsVisible() and RatingSummaryTargetFrame:IsVisible()) then
        RatingSummary_HideFrame(RatingSummaryTargetFrame);
        RatingSummary_ShowFrame(RatingSummaryTargetFrame,InspectFrame,UnitName(InspectFrame.unit),OFFSET_X,OFFSET_Y);
        RatingSummary_ShowFrame(RatingSummarySelfFrame,RatingSummaryTargetFrame,UnitName("player"),0,0);
    end
end

function RatingSummary_GetTalentString(isInspecting)
    local active, inact

    if(isInspecting)then
        local unit = InspectFrame.unit
        if(unit)then
            active = GetInspectSpecialization(unit)
            if(active and active>0) then active = select(2, GetSpecializationInfoByID(active)) end
        end
    else
        active = GetActiveSpecGroup()
        inact = active and (3-active)
        active = GetSpecialization(false, false, active);
        inact = GetSpecialization(false, false, inact);
        active = active and select(2, GetSpecializationInfo(active))
        inact = inact and select(2, GetSpecializationInfo(inact))
    end

    if(active or inact)then
        local talentString = SPECIALIZATION..": ";
        talentString=talentString..NORMAL_FONT_COLOR_CODE..(active or EMPTY)..FONT_COLOR_CODE_CLOSE
        if(inact)then
            talentString=talentString.." / "..GRAY_FONT_COLOR_CODE..inact..FONT_COLOR_CODE_CLOSE
        end
        return talentString
    else
        return ""
    end
end

function RatingSummary_SetFrameText(frame, tiptitle, tiptext, unit)
    --[[
    if not frame.mask and WW and CoreUIEnableTooltip then
        frame.mask = WW:Frame(nil, frame):un();--:CreateTexture():SetTexture(1,1,1,0.5):ALL():up():un();
        CoreUIEnableTooltip(frame.mask);
        CoreUIMakeMovable(frame.mask, frame);
        frame.mask:SetScript("OnEnter", function(self)
            if not self.engClass or not self.primary then return end
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR", -100, -30);
            local info = GetMasteryInfo(GameTooltip, self.engClass, self.primary);
            if not info then return end
            GameTooltip:ClearLines();
            GameTooltip:AddLine("精通："..GetClassName(self.engClass));
            GameTooltip:AddLine("本功能由网易有爱独家提供", 0, 0.82, 0);
            for j=1, #info do
                GameTooltip:AddLine(info[j].name, 1, 1, 1);
                if info[j].require then
                    GameTooltip:AddLine(info[j].require, 1,.125,.125);
                end
                local detail = info[j].detail:gsub("[0-9%.]*%%", format("%.0f+%.2f*%.2f=|cff00d100%.2f", info[j].base, info[j].per, frame.mastery, frame.mastery*info[j].per+info[j].base).."%%|r");
                GameTooltip:AddLine(detail, 1, 0.82, 0, 1);
                GameTooltip:AddLine(info[j].calc, 1, 0.82, 0, 1);
            end
            GameTooltip:Show();
        end)
    end
    ]]

    local text = getglobal(frame:GetName().."Text");
    local title = getglobal(frame:GetName().."Title");

    if(tiptitle) then title:SetText(tiptitle); end

    text:SetText(tiptext);
    local height = text:GetStringHeight();
    local width = text:GetStringWidth();
    if(width < title:GetStringWidth()) then
        width = title:GetStringWidth();
    end
    frame:SetHeight(height+30);
    frame:SetWidth(width+10);

    if GetMasteryInfo and frame.mask then
        frame.mask:Hide();
        if frame.mastery and frame.mastery > 0 and (unit=="player" or frame.talented) then
            local _, engClass = UnitClass(unit);
            local primary = GetSpecialization(unit~="player");
            if not primary then return end
            frame.mask.engClass = engClass;
            frame.mask.primary = primary;

            local lines = 0;
            tiptext:gsub("\n"..NORMAL_FONT_COLOR_CODE..StatLogic:GetStatNameFromID("MASTERY_RATING")..":"..".*", ""):gsub("\n", function(v) lines = lines+1 end);
            local _, fontHeight = text:GetFont();
            frame.mask:SetPoint("TOPLEFT", text, "TOPLEFT", 0, -(fontHeight*1.03)*(lines+1));
            frame.mask:SetSize(width, fontHeight+2);
            frame.mask:Show();
        end
    end

end

local get_unit_gem_info = U1GetUnitGemInfo
local get_unit_enchant_info = U1GetUnitEnchantInfo

function RatingSummary_ShowFrame(frame,target,tiptitle,anchorx,anchory,ready)
    local unit = "player";
    if(RatingSummaryTargetFrame == frame) then
        if(InspectFrame.unit) then
            unit = InspectFrame.unit;
        else
            return;
        end
    end
    local inspecting = unit~="player"
    local sum = RatingSummary_Sum(inspecting);
    local _, uc = UnitClass(unit)
    local _, ur = UnitRace(unit)
    local ul = UnitLevel(unit)

    --DevTools_Dump(sum);
    local tiptext = "";

    --gearscore
    if U1GetInventoryLevel then
        local avgLevel, color, resilience, totalLevel, count, slotCount, itemLinks = U1GetInventoryLevel(unit)
        if(avgLevel and avgLevel>0) then
            tiptext=tiptext.."\n"..NORMAL_FONT_COLOR_CODE..RATING_SUMMARY_ITEM_LEVEL_SHORT.."："..FONT_COLOR_CODE_CLOSE.."|cff"..color..avgLevel..FONT_COLOR_CODE_CLOSE
            if not inspecting or ready then
                local talent = GetSpecialization(inspecting);
                if talent then tiptext=tiptext.." ("..select(2, GetSpecializationInfo(talent, inspecting))..")" end
            end
            if GearScoreL then
                local score, gs_color = GearScoreL:GetPlayerInfo(unit)
                tiptext=tiptext.."\n"..NORMAL_FONT_COLOR_CODE.." GS ".."："..FONT_COLOR_CODE_CLOSE.."|cff"..color..score..FONT_COLOR_CODE_CLOSE
            elseif avgLevel-91.45 > 0 then
                tiptext=tiptext.."\n"..NORMAL_FONT_COLOR_CODE.."GS(估算)".."："..FONT_COLOR_CODE_CLOSE.."|cff"..color..((avgLevel-91.45)*36)..FONT_COLOR_CODE_CLOSE
            end
        end
    end

    frame.mastery = 0; --warbaby add mastery tip;

    local cat, v;
    for _, cat in pairs(RatingSummary_CLASS_STAT[uc]) do
        local catStr = "";
        for _, stat in pairs(RatingSummary_STAT[cat]) do
            --ChatFrame1:AddMessage(stat);
            local func = RatingSummary_Calc[stat]
            local s1,s2,s3,s4;
            if not func then
                s1 = sum[stat] or 0
            else
                s1,s2,s3,s4 = func(sum, stat, sum[stat] or 0, uc, ul)
                if(stat=="MASTERY_RATING") then
                    frame.mastery = s1;
                end
            end

            local ff = RatingSummary_FORMAT[stat] or GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
            if(type(s1)~="number") then
                ChatFrame1:AddMessage(stat..":"..tostring(s1))
            elseif(s1 and s1>0) then
                local _, sname = StatLogic:GetStatNameFromID(stat);
                if stat=="TOTAL_AVOID" then
                    sname = RATING_SUMMARY_TOTAL_AVOID
                elseif not sname then
                    sname = stat;
                else
                    sname = string.gsub(sname, "%(%%%)", "");
                    sname = string.gsub(sname, "%%", "%%%%");
                end
                sname = NORMAL_FONT_COLOR_CODE..sname..":"..FONT_COLOR_CODE_CLOSE;

                ff = sname..ff;
                catStr = catStr.."\n"..format(ff, s1, s2, s3, s4)
                --ChatFrame1:AddMessage(format(ff, s1, s2, s3, s4))
            end

        end
        if catStr ~="" then
            if tiptext ~= "" then tiptext = tiptext.."\n"; end
            tiptext = tiptext.."\n"..HIGHLIGHT_FONT_COLOR_CODE..(WB_STATS_CAT[cat] or cat)..":"..FONT_COLOR_CODE_CLOSE;
            tiptext = tiptext..catStr;
        end
    end

    --item levels
    if tiptext ~= "" then tiptext = tiptext.."\n"; end
    tiptext = tiptext.."\n"..HIGHLIGHT_FONT_COLOR_CODE..RATING_SUMMARY_ITEM_LEVEL_TITLE..":"..FONT_COLOR_CODE_CLOSE;
    for v = 7, 2, -1 do
        if(sum["ITEMCOUNT"..v]) then
            local _,_,_,colorCode = GetItemQualityColor(v)
            tiptext = tiptext.."\n"..format("|c"..colorCode.."%s "..RATING_SUMMARY_ITEM_LEVEL_FORMAT.."|r", RATING_SUMMARY_ITEM_QUANLITY_NAME[v], sum["ITEMCOUNT"..v], sum["ITEMLEVEL"..v]/sum["ITEMCOUNT"..v])
        end
    end

    local gem_info, waist_extra_slot = get_unit_gem_info(unit)
    tiptext = tiptext ..'\n\n宝石: '.. gem_info

    local total_enchant, has_enchant, missing_enchant = get_unit_enchant_info(unit, waist_extra_slot)
    tiptext = tiptext .. ('\n附魔: '..(total_enchant==has_enchant and "%d" or "|cffff0000%d|r")..'/%d |cffff0000%s|r'):format(has_enchant, total_enchant, missing_enchant)

    --talent
    if not inspecting then
        tiptext = tiptext.."\n\n"..RatingSummary_GetTalentString(false);
    elseif ready then
        tiptext = tiptext.."\n\n"..RatingSummary_GetTalentString(true);
    else
        frame.talented=false;
    end

    RatingSummary_SetFrameText(frame, tiptitle, tiptext, unit);

    --[[
        if(StatCompareSelfFrame and ( target == PaperDollFrame or target == InspectFrame )) then
            frame:SetPoint("TOPLEFT", StatCompareSelfFrame, "TOPRIGHT", anchorx + 30, anchory + 30);
        elseif(IsAddOnLoaded("oSkin") or IsAddOnLoaded("Skinner")) then
            if(UnitName("player") == tiptitle and (target:GetName() == "InspectFrame" or target:GetName() == "PaperDollFrame")) then
                frame:SetPoint("TOPLEFT", target:GetName(), "TOPRIGHT", anchorx + 30, anchory + 12);
            else
                frame:SetPoint("TOPLEFT", target:GetName(), "TOPRIGHT", anchorx, anchory);
            end
        else
            frame:SetPoint("TOPLEFT", target:GetName(), "TOPRIGHT", anchorx, anchory);
        end
    ]]
    frame:Show();
end

function RatingSummary_HideFrame(frame)
    frame:Hide();
end

function RatingSummary_Sum(inspecting, tipUnit)
    local slotID;
    --[[ 0 = ammo 1 = head 2 = neck 3 = shoulder 4 = shirt 5 = chest 6 = belt 7 = legs 8 = feet 9 = wrist 10 = gloves 11 = finger 1 12 = finger 2 13 = trinket 1 14 = trinket 2 15 = back 16 = main hand 17 = off hand 18 = ranged 19 = tabard ]]--

    local unit = "player";
    if(inspecting) then unit=InspectFrame.unit end
    if(tipUnit) then unit=tipUnit end
    local _, uc = UnitClass(unit)
    local _, ur = UnitRace(unit)
    local ul = UnitLevel(unit)


    local sum = {};

    for i=1, 18 ,1 do
        if i~=4 then
            local link = GetInventoryItemLink(unit, i);
            --if inspecting then ChatFrame1:AddMessage(slots[i].." "..(link or "nil")); end
            if (link) then
                local _, _, quality, iLevel = GetItemInfo(link);

                --[[# 2 - Uncommon # 3 - Rare # 4 - Epic # 5 - Legendary # 7 Account]]
                if(quality >=2 and quality <=7) then
                    sum["ITEMCOUNT"..quality] = (sum["ITEMCOUNT"..quality] or 0) + 1;
                    sum["ITEMLEVEL"..quality] = (sum["ITEMLEVEL"..quality] or 0) + iLevel;
                end

                local itemStat = StatLogic:GetSum(link);

                for k,v in pairs(itemStat) do
                    if(k~="itemType" and k~="link") then --if(type(v)=="number") then
                        if(not sum[k]) then sum[k] = 0 end
                        sum[k] = sum[k] + v;
                    end
                end
            end
        end
    end

    return sum;
end

WB_STATS_CAT = {
    BASE = PLAYERSTAT_BASE_STATS,
    MELEE = PLAYERSTAT_MELEE_COMBAT,
    RANGED = PLAYERSTAT_RANGED_COMBAT,
    TANK = PLAYERSTAT_DEFENSES,
    SPELL = PLAYERSTAT_SPELL_COMBAT,
    OTHER = RATING_SUMMARY_OTHER,
}

RatingSummary_STAT = {
    BASE = { "ARMOR", "STR", "AGI", "STA", "INT", "SPI", "MASTERY_RATING", },
    MELEE = { "AP", "FERAL_AP", "MELEE_HIT", "MELEE_CRIT", "MELEE_HASTE", "EXPERTISE_RATING",  },
    RANGED = { "RANGED_AP", "RANGED_HIT", "RANGED_CRIT", "RANGED_HASTE", },
    TANK = { "DEFENSE", "DODGE", "PARRY", "BLOCK", "BLOCK_VALUE", "TOTAL_AVOID" },
    SPELL = { "SPELL_DMG", "SPELL_HIT", "SPELL_CRIT", "SPELL_HASTE", "SPELLPEN", "MANA_REG",  },
    OTHER = { "RESILIENCE_RATING", "ARMOR_PENETRATION", "ARCANE_RES", "FIRE_RES", "NATURE_RES", "FROST_RES", "SHADOW_RES" }
}

RatingSummary_CLASS_STAT = {
    HUNTER = { "BASE", "MELEE", "RANGED", "OTHER" },
    ROGUE = { "BASE", "MELEE", "OTHER" },
    WARRIOR = { "BASE", "MELEE", "TANK", "OTHER" },
    DEATHKNIGHT = { "BASE", "MELEE", "TANK", "OTHER" },
    DRUID = { "BASE", "MELEE", "TANK", "SPELL", "OTHER" },
    PALADIN = { "BASE", "MELEE", "TANK", "SPELL", "OTHER" },
    SHAMAN = { "BASE", "MELEE", "SPELL", "OTHER" },
    WARLOCK = { "BASE", "SPELL", "OTHER" },
    PRIEST = { "BASE", "SPELL", "OTHER" },
    MAGE = { "BASE", "SPELL", "OTHER" },
    MONK = { "BASE", "MELEE", "TANK", "SPELL", "OTHER" },
}

local ratingToEffect = function(sum, stat, val, class, level) val = sum[stat.."_RATING"] or 0; val=StatLogic:GetEffectFromRating( val, stat.."_RATING", level ) return val, sum[stat.."_RATING"] or 0 end

local SL = StatLogic;
RatingSummary_Calc = {
    STR = nil,
    AGI = function(sum, stat, val, class, level) return val, SL:GetCritFromAgi(val, class, level) end,
    STA = nil,
    INT = function(sum, stat, val, class, level) return val, SL:GetSpellCritFromInt(val, class, level) end,
    SPI = function(sum, stat, val, class, level) return val, SL:GetNormalManaRegenFromSpi(val) end,

    MASTERY_RATING = function(sum, stat, val, class, level) local e = SL:GetEffectFromRating( val, stat, level ); return e,val end,

    AP = function(sum, stat, val, class, level) return val + SL:GetAPFromAgi(sum["AGI"] or 0, class) + SL:GetAPFromStr(sum["STR"] or 0, class), val end,
    FERAL_AP = nil,
    MELEE_HIT = ratingToEffect,
    MELEE_CRIT = function(sum, stat, val, class, level) val=sum[stat.."_RATING"] or 0 local e = SL:GetEffectFromRating( val, stat.."_RATING", level ) return --[[e,]] e + SL:GetCritFromAgi(sum["AGI"] or 0, class, level), val end,
    MELEE_HASTE = ratingToEffect,
    EXPERTISE_RATING = function(sum, stat, val, class, level) local e = SL:GetEffectFromRating( val, stat, level ); return e,val  end,
    ARMOR_PENETRATION = ratingToEffect,

    RANGED_AP = function(sum, stat, val, class, level) return val + (sum["AP"] or 0) + SL:GetRAPFromAgi(sum["AGI"] or 0, class),val end,
    RANGED_HIT = ratingToEffect,
    RANGED_CRIT = function(sum, stat, val, class, level) val=sum[stat.."_RATING"] or 0 local e = SL:GetEffectFromRating((sum["MELEE_CRIT_RATING"] or 0), "MELEE_CRIT_RATING", level) + SL:GetEffectFromRating( val, stat.."_RATING", level ) return --[[e,]] e + SL:GetCritFromAgi(sum["AGI"] or 0, class, level), val end,
    RANGED_HASTE = ratingToEffect,

    ARMOR = function(sum, stat, val, class, level) return (sum["ARMOR"] or 0), (sum["ARMOR_BONUS"] or 0) end,
    DEFENSE = function(sum, stat, val, class, level)
        local e = SL:GetEffectFromRating( sum[stat.."_RATING"] or 0, stat.."_RATING", level );
        if(e>0) then return e+level*5,e*0.04 else return 0 end
    end,
    DODGE = ratingToEffect,
    PARRY = ratingToEffect,
    BLOCK = ratingToEffect,
    BLOCK_VALUE = nil,
    TOTAL_AVOID = function(sum, stat, val, class, level)
        local dr = SL:GetEffectFromRating( sum["DEFENSE_RATING"] or 0, "DEFENSE_RATING", level ) * 0.04
        local parry = SL:GetEffectFromRating( sum["PARRY_RATING"] or 0, "PARRY_RATING", level ) + dr
        local dodge = SL:GetEffectFromRating( sum["DODGE_RATING"] or 0, "DODGE_RATING", level ) + dr
        local block = SL:GetEffectFromRating( sum["BLOCK_RATING"] or 0, "BLOCK_RATING", level ) + dr
        --local missing = 5 - 0.6 + dr
        local hasParry = (class=="WARRIOR" or class=="PALADIN" or class=="SHAMAN" or class=="ROGUE" or class=="HUNTER" or class=="DEATHKNIGHT")
        local hasBlock = (class=="WARRIOR" or class=="PALADIN" or class=="SHAMAN")
        if(not hasParry and not hasBlock) then return 0 end
        return (hasParry and parry or 0) + dodge, (hasBlock and block or 0);
    end,
    RESILIENCE_RATING = function(sum, stat, val, class, level) local e = SL:GetEffectFromRating( val, stat, level ); return e,val end,

    SPELL_DMG = nil,
    HEAL = nil,
    SPELL_HIT = ratingToEffect,
    SPELL_CRIT = function(sum, stat, val, class, level) val=sum[stat.."_RATING"] or 0 local e = SL:GetEffectFromRating( val, stat.."_RATING", level ) return --[[e,]] e + SL:GetSpellCritFromInt(sum["INT"] or 0, class, level), val end,
    SPELL_HASTE = ratingToEffect,
    SPELLPEN = nil,
    MANA_REG = nil
}

local FI = "%d";
local FP = "%.2f%%";
local FL = "%.1f";
local FR = GREEN_FONT_COLOR_CODE..FP..FONT_COLOR_CODE_CLOSE.."("..FI..")";
local CFI = GREEN_FONT_COLOR_CODE..FI..FONT_COLOR_CODE_CLOSE
local BFI = GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE
local FCRI = GREEN_FONT_COLOR_CODE..FP..FONT_COLOR_CODE_CLOSE.."("..FI..")";

RatingSummary_FORMAT = {
    STR = BFI,
    AGI = BFI.."("..NORMAL_FONT_COLOR_CODE..RATING_SUMMARY_MELEE_CRIT..FONT_COLOR_CODE_CLOSE.."%.2f%%"..")",
    STA = BFI,
    INT = BFI.."("..NORMAL_FONT_COLOR_CODE..RATING_SUMMARY_SPELL_CRIT..FONT_COLOR_CODE_CLOSE.."%.2f%%"..")",
    SPI = BFI.."("..NORMAL_FONT_COLOR_CODE..RATING_SUMMARY_MANA_REGEN..FONT_COLOR_CODE_CLOSE..FI..")",

    MASTERY_RATING = GREEN_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE.."("..FI..")",

    AP = CFI.."("..FI..")",
    FERAL_AP = CFI,
    MELEE_HIT = FR,
    MELEE_CRIT = FCRI,
    MELEE_HASTE = FR,
    EXPERTISE_RATING = FR,
    ARMOR_PENETRATION = FR,

    RANGED_AP = CFI.."("..FI..")",
    RANGED_HIT = FR,
    RANGED_CRIT = FCRI,
    RANGED_HASTE = FR,

    ARMOR = CFI,
    DEFENSE = ""..CFI.."("..FP..")",
    DODGE = FR,
    PARRY = FR,
    BLOCK = FR,
    BLOCK_VALUE = CFI,
    TOTAL_AVOID = GREEN_FONT_COLOR_CODE..FP..FONT_COLOR_CODE_CLOSE.."(".."%.1f%%"..")",
    RESILIENCE_RATING = FR,

    SPELL_DMG = CFI,
    HEAL = CFI,
    SPELL_HIT = FR,
    SPELL_CRIT = FCRI,
    SPELL_HASTE = FR,
    SPELLPEN = CFI,
    MANA_REG = CFI.."/MP5",
}
