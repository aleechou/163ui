--测试: /run ChatFrame1:AddMessage("\124Hdeathann:10:45:33 Warbaby 挂了。(环境伤害:溺水/$$$cffff0000460$$$r)\124h\124cff7fff7f[发送]\124r\124h")
local function GetBossHealth()
    for i=-1,10 do
        local unit
        if i==-1 then unit="target"
        elseif i==0 then unit="focus"
        else unit = "raid"..i.."target"
        end
        if UnitLevel(unit)==-1 and (UnitHealth(unit) or 0) > 1 then
            return format("%.1f", UnitHealth(unit)*100/UnitHealthMax(unit)).."%", UnitName(unit)
        end
    end
    return nil, nil
end
-- Death announcer by wingus <reported>

local DEATH_ANNOUNCE_REVISION = 'r21';

DEATH_ANNOUNCE_OFF = true --如果为假,则/da切换只是临时的, 每次进战斗就会重新启用. 这是为了已经确定灭团时不再发送烦人的信息

local DEATH_ANNOUNCE_initial = {
    ["ENABLED"] = 0,
};

local DEATH_ANNOUNCE_loaded = false;
local DEATH_ANNOUNCE_Debug = false;
local DEATH_ANNOUNCE_pref = "|cff7fff7f阵亡通知:|r ";
local DEATH_ANNOUNCE_OVK = {};

function DEATH_ANNOUNCE_OnLoad(self)
    self:RegisterEvent("VARIABLES_LOADED");
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("PLAYER_REGEN_DISABLED");
end

function DEATH_ANNOUNCE_Init()
    local originSetHyperlink_Origin = ItemRefTooltip.SetHyperlink;
    ItemRefTooltip.SetHyperlink = function(self,link)
        if(strsub(link, 1, 8)=="deathann") then
            HideUIPanel(self);
            return;
        end
        return originSetHyperlink_Origin(self,link);
    end
    hooksecurefunc("SetItemRef", function(link, text, button)
        if ( strsub(link, 1, 8) == "deathann" ) then
            local msg = strsub(link,10)
            if msg then
                DEATH_ANNOUNCE_Print(msg:gsub("%$%$%$", "\124"), "RAID")
            end
        end
    end);

    SLASH_DAInfo1 = "/da";
    SlashCmdList["DAInfo"] = DEATH_ANNOUNCE_Opts;

    if ( DEATH_ANNOUNCE == nil ) then
        DEATH_ANNOUNCE = DEATH_ANNOUNCE_initial;
    end

    if( DEFAULT_CHAT_FRAME ) then

        local DEATH_ANNOUNCE_status = "|c000fff00"..DEATH_ANNOUNCE_LOCALE_ENABLE.."|r.";
        if not DEATH_ANNOUNCE_IsEnabled() then
            DEATH_ANNOUNCE_status = "|cfff00000"..DEATH_ANNOUNCE_LOCALE_DISABLE.."|r.";
        end

        if not DEATH_ANNOUNCE_OFF then
            DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref .. "|c000fff00目前设置为'自动开启发送', 如需关闭请使用/da off命令" , "DEFAULT");
        else
            DEATH_ANNOUNCE_Opts("dis")
        end

        --DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref ..DEATH_ANNOUNCE_REVISION .. " 加載成功, /da 切換通告模式.", "DEFAULT");
        --DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref .. DEATH_ANNOUNCE_status, "DEFAULT");
    end
end

--如果运行 /da off 则
function DEATH_ANNOUNCE_Opts(msg)
    local show = true
    if not msg or msg =="" then
        if DEATH_ANNOUNCE_IsEnabled() then msg = "dis" else msg = "ena" end
    elseif strlower(msg) == "off" then
        msg = "dis"
        show = false
        DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." |cfff00000".."不自动开启发送".."|r.","DEFAULT");
        DEATH_ANNOUNCE_OFF = true
    elseif strlower(msg) == "on" then
        msg = "ena"
        show = false
        DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." |c000fff00".."自动开启发送".."|r.","DEFAULT");
        DEATH_ANNOUNCE_OFF = false
    end

    if ( string.find(msg,"ena") ) then
        if DEATH_ANNOUNCE_IsEnabled() then return end
        DEATH_ANNOUNCE_Set("ENABLED", 1);
        if show then DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." |c000fff00"..DEATH_ANNOUNCE_LOCALE_ENABLE.."|r.","DEFAULT"); end
    elseif ( string.find(msg,"dis") ) then
        if not DEATH_ANNOUNCE_IsEnabled() then return end
        DEATH_ANNOUNCE_Set("ENABLED", 0);
        if show then DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." |cfff00000"..DEATH_ANNOUNCE_LOCALE_DISABLE.."|r.","DEFAULT"); end
    elseif ( string.find(msg,"cur") ) then
        if DEATH_ANNOUNCE_OFF then
            DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." |cfff00000".."不自动开启发送".."|r.","DEFAULT");
        else
            DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." |cfff00000".."自动开启发送".."|r.","DEFAULT");
        end
        if DEATH_ANNOUNCE_IsEnabled() then
            DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." |c000fff00"..DEATH_ANNOUNCE_LOCALE_ENABLE.."|r.","DEFAULT");
        else
            DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." |cfff00000"..DEATH_ANNOUNCE_LOCALE_DISABLE.."|r.","DEFAULT");
        end
    else
        DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.."|cff7fff7f 命令:|r /da - 切换发送通告/不发送通告.|r", "DEFAUT")
        DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.."|cff7fff7f 命令:|r /da on, /da off - 每次进战斗时是否自动开启发送.|r", "DEFAUT")
        DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.."|cff7fff7f 命令:|r /da cur - 显示当前状态", "DEFAUT")
    end

end

local function UnitInRaidOrParty(id)
    return UnitInRaid(id) or UnitInParty(id)
end

function DEATH_ANNOUNCE_OnEvent(self, event, timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, arg9, arg10, arg11, arg12, arg13, arg14)
    if (event == "PLAYER_REGEN_DISABLED") then
        if not DEATH_ANNOUNCE_OFF then
            DEATH_ANNOUNCE_Opts("ena")
        end
        return
    end

    if (event == "VARIABLES_LOADED") then
        if (DEATH_ANNOUNCE_loaded == false) then
            DEATH_ANNOUNCE_loaded = true;
            DEATH_ANNOUNCE_Init();
        end
        return;
    end

    if ( event == "COMBAT_LOG_EVENT_UNFILTERED" ) then
        if ( true ) then --and DEATH_ANNOUNCE_IsSelfInRaid() ) then
            if ( subevent == "UNIT_DIED" ) then
                if ( UnitInRaidOrParty(destName) and ( not UnitIsFeignDeath(destName)) ) then
                    if ( not DEATH_ANNOUNCE_OVK[destName] ) then
                        DEATH_ANNOUNCE_OVK[destName] = "";
                    end
                    if (UnitExists("target") and UnitCanAttack("target", "player")) then
                        local h,n = GetBossHealth()
                        DEATH_ANNOUNCE_OVK[destName] = DEATH_ANNOUNCE_OVK[destName]..(h and "@"..h or "")
                    end
                    DEATH_ANNOUNCE_Print(destName ..DEATH_ANNOUNCE_LOCALE_DIE .. DEATH_ANNOUNCE_OVK[destName], DEATH_ANNOUNCE_IsEnabled() and "RAID" or "DEFAULT", true);
                    DEATH_ANNOUNCE_OVK[destName] = "";
                end
            end

            -- taunts
            if ( subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_MISSED" ) then
                if ( UnitInRaidOrParty(sourceName) ) then
                    if ( arg9 == 355 or arg9 == 694 or arg9 == 1161 or arg9 == 6795 or arg9 == 5209 or arg9 == 49560 or arg9 == 56222 or arg9 == 62124 ) then
                        if ( subevent == "SPELL_AURA_APPLIED" ) then
                            --DEATH_ANNOUNCE_Print(arg4.." 嘲讽了: "..arg7, "DEFAULT");
                        else
                            DEATH_ANNOUNCE_Print(sourceName .." 嘲讽抵抗: ".. destName, DEATH_ANNOUNCE_IsEnabled() and "RAID" or "DEFAULT", true);
                        end
                    end
                end
            end

            if ( subevent == "SPELL_DAMAGE" or subevent == "SPELL_PERIODIC_DAMAGE" or subevent == "RANGE_DAMAGE" or subevent == "DAMAGE_SPLIT" or subevent == "DAMAGE_SHIELD" ) then
                if ( UnitInRaidOrParty(destName) ) then
                    if ( arg13 > 0 ) then
                        local sp = GetSpellLink(arg9);
                        DEATH_ANNOUNCE_OVK[destName] = "("..(sourceName and sourceName ..":" or "")..sp.."/|cffff0000"..arg12.."|r)";
                    end
                end
            elseif ( subevent == "SWING_DAMAGE" ) then
                if ( UnitInRaidOrParty(destName) ) then
                    if ( arg10 > 0 ) then
                        DEATH_ANNOUNCE_OVK[destName] = "("..(sourceName and sourceName ..":" or "").."近战平砍/|cffff0000"..arg9.."|r)";
                    end
                end
            elseif ( subevent == "SPELL_INSTAKILL" ) then
                if ( UnitInRaidOrParty(destName) ) then
                    DEATH_ANNOUNCE_OVK[destName] = "("..(sourceName and sourceName ..":" or "").."|cffff0000"..arg10.."|r)";
                end
            elseif ( subevent == "ENVIRONMENTAL_DAMAGE"  ) then
                if ( UnitInRaidOrParty(destName) ) then
                    if ( arg10 > 0 ) then
                        DEATH_ANNOUNCE_OVK[destName] = "(环境伤害:"..(arg9=="FALLING" and "摔落" or (arg9=="DROWNING" and "溺水" or arg9)).."/|cffff0000"..arg10.."|r)";
                    end
                end
            end
        end
    end
end

--启用则发送到RAID频道,否则显示在自己屏幕
function DEATH_ANNOUNCE_IsEnabled()
    if ( DEATH_ANNOUNCE["ENABLED"] == 0 ) then return false; else return true; end
end

function DEATH_ANNOUNCE_IsSelfInRaid()
    local TargetInRaid = UnitInRaid("player");
    return TargetInRaid;
end

local advised
function DEATH_ANNOUNCE_Print(msg, channel, link)
    channel = channel or "DEFAULT"
    if (msg) then
        if (not IsInGroup()) then
            if channel == "RAID" then channel = "SAY" else channel = "DEFAULT" end
            --channel = "DEFAULT"
        end

        if (channel == "DEFAULT") then
            if link then msg = msg.." |Hdeathann:"..date("%X").." "..msg:gsub("\124", "$$$").."|h|cff7fff7f[发送]|r|h" end
            DEFAULT_CHAT_FRAME:AddMessage(msg, .6, .6, .6);
        else
            if(channel=="RAID") then
                if(U1UseInstanceChat()) then
                    channel = 'INSTANCE_CHAT'
                elseif not IsInRaid() then
                    channel="PARTY"
                end
            end
            local mmm = msg:gsub("\124cffff0000(.-)\124r", "%1");
            SendChatMessage(advised and mmm or ("【网 易有爱 阵亡通知】"..mmm), channel);
            advised = true
        end
        if(ChatFrame2) then
            if link then msg = msg.." |Hdeathann:"..date("%X").." "..msg:gsub("\124", "$$$").."|h|cff7fff7f[发送]|r|h" end
            ChatFrame2:AddMessage(msg, .6, .6, .6);
        end
    end
end


function DEATH_ANNOUNCE_PrintDeb (msg)
    if (msg) then DEATH_ANNOUNCE_Print(DEATH_ANNOUNCE_pref.." (DEBUG):"..msg, "DEFAULT");end
end

function DEATH_ANNOUNCE_Set(option, val)
    if ( option == nil or val == nil or DEATH_ANNOUNCE == nil) then DEATH_ANNOUNCE_PrintDeb("(DEATH_ANNOUNCE_Set): DEATH_ANNOUNCE or option or val is NULL!")return; end
    if ( DEATH_ANNOUNCE_Debug ) then DEATH_ANNOUNCE_PrintDeb("set "..option.." to "..val); end

    DEATH_ANNOUNCE[option] = val;
    return;
end
