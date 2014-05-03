--网易有爱 warbaby 2012.9.11
local spells = {
    PALADIN = { SPELL_POWER_HOLY_POWER },
    DEATHKNIGHT = { SPELL_POWER_RUNIC_POWER },
    WARLOCK = { [1]=SPELL_POWER_SOUL_SHARDS, [2]=SPELL_POWER_DEMONIC_FURY, [3]=SPELL_POWER_BURNING_EMBERS, },
    PRIEST = { [3]=SPELL_POWER_SHADOW_ORBS },
    MONK = { SPELL_POWER_LIGHT_FORCE or SPELL_POWER_CHI },
}

function EventAlert_SpellPower_CreateFrames()
    if EA_SpecFlag.HolyPower == nil then EA_SpecFlag.HolyPower = true end;
    if EA_SpecFlag.RunicPower == nil then EA_SpecFlag.RunicPower = true end;
    if EA_SpecFlag.SoulShards == nil then EA_SpecFlag.SoulShards = true end;
    if EA_SpecFlag.Eclipse == nil then EA_SpecFlag.Eclipse = true end;
    if EA_SpecFlag.ComboPoint == nil then EA_SpecFlag.ComboPoint = true end;
    if EA_SpecFlag.Lifebloom == nil then EA_SpecFlag.Lifebloom = true end;
    if EA_SpecFlag.ShadowOrb == nil then EA_SpecFlag.ShadowOrb = true end;
    if EA_SpecFlag.DemonicFury == nil then EA_SpecFlag.DemonicFury = true end;
    if EA_SpecFlag.BurningEmbers == nil then EA_SpecFlag.BurningEmbers = true end;
    if EA_SpecFlag.Chi == nil then EA_SpecFlag.Chi = true end;

    if (EA_playerClass == EA_CLASS_PALADIN) then
        CreateFrames_CreateSpecialFrame(10090, 1);  -- Paladin Holy Power
    elseif (EA_playerClass == EA_CLASS_DK) then
        CreateFrames_CreateSpecialFrame(10060, 1);  -- Death Knight Runic
    elseif (EA_playerClass == EA_CLASS_DRUID) then
        CreateFrames_CreateSpecialFrame(10000, 1);  -- Druid/Rogue Combo Point
        CreateFrames_CreateSpecialFrame(10081, 1);  -- Durid Eclipse
        CreateFrames_CreateSpecialFrame(10082, 1);  -- Durid Eclipse Orange
        CreateFrames_CreateSpecialFrame(33763, 1);  -- Durid Lifebloom
    elseif (EA_playerClass == EA_CLASS_ROGUE) then
        CreateFrames_CreateSpecialFrame(10000, 1);  -- Druid/Rogue Combo Point
    elseif (EA_playerClass == EA_CLASS_WARLOCK) then
        CreateFrames_CreateSpecialFrame(10070, 1);  -- Warlock Soul Shards
        CreateFrames_CreateSpecialFrame(10140, 1);  -- Warlock
        CreateFrames_CreateSpecialFrame(10150, 1);  -- Warlock
    elseif (EA_playerClass == EA_CLASS_PRIEST) then
        CreateFrames_CreateSpecialFrame(10130, 1);  -- Priest Shadow Orb
    elseif (EA_playerClass == EA_CLASS_MONK) then
        CreateFrames_CreateSpecialFrame(10120, 1);
    end
end

function CreateFrames_CreateSpecialFrame(index, typeIndex)
    -- local eaf = CreateFrame("FRAME", "EAFrame_"..index, EA_Main_Frame);
    local sFramePrefix = "EAFrameSpec_";

    local eaf = _G[sFramePrefix..index];
    if (eaf == nil) then
        eaf = CreateFrame("FRAME", sFramePrefix..index, EA_Main_Frame, "CooldownFrameTemplate");
        eaf.spellName = eaf:CreateFontString(sFramePrefix..index.."_Name","OVERLAY");
        eaf.spellTimer = eaf:CreateFontString(sFramePrefix..index.."_Timer","OVERLAY");
        eaf.spellStack = eaf:CreateFontString(sFramePrefix..index.."_Stack","OVERLAY");
    end
    -- eaf.noCooldownCount = true;

    if (EA_Config.AllowESC == true) then
        tinsert(UISpecialFrames,sFramePrefix..index);
    end

    -- eaf:SetFrameStrata("DIALOG");
    eaf:ClearAllPoints();
    eaf:SetFrameStrata("HIGH");
    -- eaf:SetFrameStrata("LOW");
    eaf.spellName:SetFontObject(ChatFontNormal);
    eaf.spellName:SetPoint("BOTTOM", 0, -15);

    eaf.spellTimer:SetFontObject(ChatFontNormal);
    eaf.spellTimer:SetPoint("TOP", 0, 15);

    eaf.spellStack:SetFontObject(ChatFontNormal);
    eaf.spellStack:SetPoint("BOTTOMRIGHT", 0, 15);

    -- if typeIndex == 1 then
    eaf:SetWidth(EA_Config.IconSize);
    eaf:SetHeight(EA_Config.IconSize);

    if index == 10000 then
        -- Druid/Rogue Combo Point
        eaf:SetBackdrop({bgFile = "Interface/Icons/Ability_Whirlwind"});
    elseif index == 10060 then
        -- Death Knight Runic
        eaf:SetBackdrop({bgFile = "Interface/Icons/Spell_Arcane_Rune"});
    elseif index == 10070 then
        -- Warlock Soul Shards
        eaf:SetBackdrop({bgFile = "Interface/Icons/Inv_Misc_Gem_Amethyst_02"});
    elseif index == 10081 then
        -- Durid Eclipse
        eaf:SetBackdrop({bgFile = "Interface/Icons/Ability_Druid_Eclipse"});
    elseif index == 10082 then
        -- Durid Eclipse Orange
        eaf:SetBackdrop({bgFile = "Interface/Icons/Ability_Druid_Eclipseorange"});
    elseif index == 10090 then
        -- Paladin Holy Power
        eaf:SetBackdrop({bgFile = "Interface/Icons/Spell_Holy_Powerwordbarrier"});
    elseif index == 33763 then
        -- Druid Lifebloom
        eaf:SetBackdrop({bgFile = "Interface/Icons/INV_Misc_Herb_Felblossom"});
    elseif index == 10130 then
        -- Priest Shadow Orb
        eaf:SetBackdrop({bgFile = "INTERFACE/ICONS/spell_priest_shadoworbs"});
    elseif index == 10140 then
        -- warlock burning embers
        eaf:SetBackdrop({bgFile = "INTERFACE/ICONS/inv_elemental_mote_fire01"});
    elseif index == 10150 then
        -- warlock demonic fury
        eaf:SetBackdrop({bgFile = "INTERFACE/ICONS/ability_warlock_eradication"});
    elseif index == 10120 then
        -- monk chi
        eaf:SetBackdrop({bgFile = "INTERFACE/ICONS/inv_misc_flawlesspearl"});
    end
    -- end
end

function EventAlert_SpellPower_UpdateAllPower()
    if (EA_playerClass == EA_CLASS_DK and EA_SpecFlag.RunicPower) then
        EventAlert_UpdateSinglePower(SPELL_POWER_RUNIC_POWER);
    end
    if (EA_playerClass == EA_CLASS_WARLOCK) then
        if ( EA_SpecFlag.SoulShards) then
            EventAlert_UpdateSinglePower(SPELL_POWER_SOUL_SHARDS);
        end
        if ( EA_SpecFlag.DemonicFury) then
            EventAlert_UpdateSinglePower(SPELL_POWER_DEMONIC_FURY)
        end
        if ( EA_SpecFlag.BurningEmbers) then
            EventAlert_UpdateSinglePower(SPELL_POWER_BURNING_EMBERS)
        end
    end
    if (EA_playerClass == EA_CLASS_PALADIN and EA_SpecFlag.HolyPower) then
        EventAlert_UpdateSinglePower(SPELL_POWER_HOLY_POWER);
    end
    if (EA_playerClass == EA_CLASS_PRIEST and EA_SpecFlag.ShadowOrb) then
        EventAlert_UpdateSinglePower(SPELL_POWER_SHADOW_ORBS);
    end
    if (EA_playerClass == EA_CLASS_MONK and EA_SpecFlag.Chi) then
        EventAlert_UpdateSinglePower(SPELL_POWER_LIGHT_FORCE or SPELL_POWER_CHI)
    end
    if (EA_playerClass == EA_CLASS_DRUID and EA_SpecFlag.Eclipse) then
        EventAlert_UpdateEclipse();
    end
end

function EventAlert_SpellPower_UpdatePower(arg2)
    if ((arg2 == "RUNIC_POWER") and (EA_playerClass == EA_CLASS_DK) and EA_SpecFlag.RunicPower) then
        EventAlert_UpdateSinglePower(SPELL_POWER_RUNIC_POWER);
    end
    if ((arg2 == "SOUL_SHARDS") and (EA_playerClass == EA_CLASS_WARLOCK) and EA_SpecFlag.SoulShards) then
        EventAlert_UpdateSinglePower(SPELL_POWER_SOUL_SHARDS);
    end
    if ((arg2 == "HOLY_POWER") and (EA_playerClass == EA_CLASS_PALADIN) and EA_SpecFlag.HolyPower) then
        EventAlert_UpdateSinglePower(SPELL_POWER_HOLY_POWER);
    end
    if ((arg2 == "SHADOW_ORBS") and (EA_playerClass == EA_CLASS_PRIEST) and EA_SpecFlag.ShadowOrb) then
        EventAlert_UpdateSinglePower(SPELL_POWER_SHADOW_ORBS);
    end
    if (arg2 == 'BURNING_EMBERS' and EA_playerClass == EA_CLASS_WARLOCK and EA_SpecFlag.BurningEmbers) then
        EventAlert_UpdateSinglePower(SPELL_POWER_BURNING_EMBERS)
    end
    if ( arg2 == 'DEMONIC_FURY' and EA_playerClass == EA_CLASS_WARLOCK and EA_SpecFlag.DemonicFury) then
        EventAlert_UpdateSinglePower(SPELL_POWER_DEMONIC_FURY)
    end
    if ((arg2 == "ECLIPSE") and (EA_playerClass == EA_CLASS_DRUID) and EA_SpecFlag.Eclipse) then
        EventAlert_UpdateEclipse();
    end
    if ( (arg2 == 'LIGHT_FORCE' or arg2 == 'DARK_FORCE') and EA_playerClass == EA_CLASS_MONK and EA_SpecFlag.Chi) then
        EventAlert_UpdateSinglePower(SPELL_POWER_LIGHT_FORCE or SPELL_POWER_CHI)
    end
end

do
    local _funcs = {}
    local function _get_update_closure(i)
        local f = _funcs[i]
        if(not f) then
            f = function()
                return EventAlert_UpdateSinglePower(i)
            end
            _funcs[i] = f
        end

        return f
    end

    -- Speciall Frame: UpdateSinglePower(holy power, runic power, soul shards), for watching the power of player
    function EventAlert_UpdateSinglePower(iPowerType)
        local iUnitPower = 0
        if(EA_playerClass == EA_CLASS_WARLOCK)then
            local spec = GetSpecialization();
            if(spec==SPEC_WARLOCK_AFFLICTION and iPowerType==SPELL_POWER_SOUL_SHARDS)then
                iUnitPower = UnitPower("player", iPowerType);
            elseif(spec==SPEC_WARLOCK_DESTRUCTION and iPowerType==SPELL_POWER_BURNING_EMBERS)then
                iUnitPower = UnitPower("player", iPowerType, true);
            elseif(spec==SPEC_WARLOCK_DEMONOLOGY and iPowerType==SPELL_POWER_DEMONIC_FURY)then
                iUnitPower = UnitPower("player", iPowerType);
            end
        else
            iUnitPower = UnitPower("player", iPowerType);
        end
        local iPowerName = "";
        local iFrameIndex = 10000 + iPowerType * 10;
        if (iPowerType == SPELL_POWER_RUNIC_POWER) then iPowerName = EA_XSPECINFO_RUNICPOWER end;
        if (iPowerType == SPELL_POWER_SOUL_SHARDS) then iPowerName = EA_XSPECINFO_SOULSHARDS end;
        if (iPowerType == SPELL_POWER_HOLY_POWER) then iPowerName = EA_XSPECINFO_HOLYPOWER end;
        if (iPowerType == SPELL_POWER_SHADOW_ORBS) then iPowerName = GetSpellInfo(95740) end;
        if (iPowerType == SPELL_POWER_BURNING_EMBERS) then iPowerName = GetSpellInfo(63933) end
        if (iPowerType == SPELL_POWER_DEMONIC_FURY) then iPowerName = GetSpellInfo(109145) end
        if (iPowerType == SPELL_POWER_LIGHT_FORCE or iPowerType == SPELL_POWER_DARK_FORCE or iPowerType == SPELL_POWER_CHI) then iPowerName = LIGHT_FORCE end
        if (EA_Config.ShowFrame == true) then
            EA_Main_Frame:ClearAllPoints();
            EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
            local prevFrame = "EA_Main_Frame";
            local xOffset = 100 + EA_Position.xOffset;
            local yOffset = 0 + EA_Position.yOffset;
            local SfontName, SfontSize = "", 0;
            local eaf = _G["EAFrameSpec_"..iFrameIndex];

            if (eaf) then
                if (iUnitPower > 0) then
                    EA_SpecFrame_Self = eaf -- true;
                    EA_SpecFrame_Self.updateFunc = _get_update_closure(iPowerType)
                    eaf:ClearAllPoints();
                    eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);

                    if (EA_Config.ShowName == true) then
                        eaf.spellName:SetText(iPowerName);
                        SfontName, SfontSize = eaf.spellName:GetFont();
                        eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
                    else
                        eaf.spellName:SetText("");
                    end

                    eaf.spellTimer:ClearAllPoints();
                    if (EA_Config.ChangeTimer == true) then
                        eaf.spellTimer:SetPoint("CENTER", 0, 0);
                    else
                        eaf.spellTimer:SetPoint("TOP", 0, 20);
                    end
                    eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
                    eaf.spellTimer:SetText(iUnitPower);
                    eaf:Show();
                    if (iPowerType == SPELL_POWER_HOLY_POWER or iPowerType == SPELL_POWER_SHADOW_ORBS) then
                        if (iUnitPower >=3) then
                            ActionButton_ShowOverlayGlow(eaf)
                        else
                            ActionButton_HideOverlayGlow(eaf);
                        end
                    end
                else
                    ActionButton_HideOverlayGlow(eaf);
                    EA_SpecFrame_Self = false;
                    eaf:Hide();
                end
                EventAlert_PositionFrames();
            end
        end
    end
end

function EventAlert_SpellPower_ClearText()
    if (EA_playerClass == EA_CLASS_PALADIN) then
        if (EA_SpecFlag.HolyPower) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10090, "", false);  -- Paladin Holy Power
        end
    elseif (EA_playerClass == EA_CLASS_DK) then
        if (EA_SpecFlag.RunicPower) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10060, "", false);  -- Death Knight Runic
        end
    elseif (EA_playerClass == EA_CLASS_DRUID) then
        if (EA_SpecFlag.ComboPoint) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10000, "", false);  -- Druid/Rogue Combo Point
        end
        if (EA_SpecFlag.Eclipse) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10081, "", false);  -- Durid Eclipse
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10082, "", false);  -- Durid Eclipse Orange
        end
        if (EA_SpecFlag.Lifebloom) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_33763, "", false);  -- Druid Lifebloom
        end
    elseif (EA_playerClass == EA_CLASS_ROGUE) then
        if (EA_SpecFlag.ComboPoint) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10000, "", false);  -- Druid/Rogue Combo Point
        end
    elseif (EA_playerClass == EA_CLASS_WARLOCK) then
        if (EA_SpecFlag.SoulShards) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10070, "", false);  -- Warlock Soul Shards
        end
        if (EA_SpecFlag.BurningEmbers) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10140, "", false); -- Burning Embers
        end
        if (EA_SpecFlag.DemonicFury ) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10140, "", false) -- Demonic Fury
        end
    elseif (EA_playerClass == EA_CLASS_PRIEST) then
        if (EA_SpecFlag.ShadowOrb) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10130, "", false);  -- Priest Shadow Orb
        end
    elseif(EA_playerClass == EA_CLASS_MONK) then
        if(EA_SpecFlag.Chi) then
            EventAlert_Icon_Options_Frame_SetAlertFrameText(EAFrameSpec_10120, "", false); -- Monk Chi
        end
    end
end