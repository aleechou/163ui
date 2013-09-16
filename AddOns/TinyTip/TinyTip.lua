local _
--[[
-- Author:	Thrae of Maelstrom (aka "Matthew Carras")
-- Modifier:	Hughman
-- Version:	2009.02.10
-- Note:		Base on TinyTip ver1.2x (not ACE)
--]]

------------------------------ 参数设置 --------------------------------
-- 修改后的数值必须与默认值的数据类型一致
-- 对于大多数参数，true为启用，false 为禁用（请不要使用nil）

local TTCfg = {
    Anchor					= {value = 3,		desc = "锚点：0-默认；1-人物跟随，其他默认；2-人物上方，其他默认；3-人物跟随，其他右上；4-人物上方，其他右上；5-全部屏幕上方；6-全部跟随。注意用OffsetX和OffsetY调整相对位置"},
        OffsetX					= {value = 30,		desc = "横向偏移量：向右为正，向左为负。跟随鼠标建议设置为30"},
        OffsetY					= {value = -30,		desc = "纵向偏移量：向上为正，向下为负。跟随鼠标建议设置为-30"},
        Scale						= {value = 1.0,		desc = "缩放：默认－1.0，取值>0"},
        Fade						= {value = false,	desc = "渐隐"},
        HideInCombat		= {value = false,		desc = "战斗中隐藏"},
        Power					= {value = true,	desc = "显示法力、怒气、能量等状态条"},
        StatusBarText		= {value = 3,		desc = "相应数字之和显示相应信息：0-禁用，1-当前，2-最大，4-百分比"},
        StatusBarHeight		= {value = 8,		desc = "设置状态条高度，默认8"},
        ItemInfo				= {value = 125,		desc = "相应数字之和显示相应信息：0-禁用，1-类别，2-编号，4-等级，8-堆栈，16-价格，32-图标，64-物品质量颜色显示边框"},
        --NoShiftCompare		= {value = true,		desc = "不按Shift直接对比装备"},
        --HoverLink				= {value = true,	desc = "鼠标划过聊天窗口的链接立即显示提示"},
        ClassColorBorder	= {value = false,		desc = "职业颜色显示边框"},
        AltDKColor				= {value = true,	desc = "修改DK职业颜色"},
        ColorFriends			= {value = true,	desc = "好友和工会成员背景颜色"},
        ClassColorName		= {value = true,		desc = "职业颜色显示名字"},
        PVPRank				= {value = true,	desc = "显示军衔及各种称号"},
        Race						= {value = true,	desc = "显示玩家种族"},
        Faction					= {value = true,	desc = "显示NPC声望等级"},
        Talent					= {value = true,	desc = "显示天赋"},
        Status					= {value = true,	desc = "显示状态：AFK、DND、脱机、假死"},
        Speed					= {value = false,	desc = "显示速度"},
        Buff						= {value = 3, 		desc = "相应数字之和显示相应信息：0-禁用，1-Buff，2-Debuff"},
        Guild						= {value = true,	desc = "显示公会"},
        GuildRank				= {value = false,		desc = "显示公会级别"},
        MyGuild					= {value = "",		desc = "各分公会公共词汇。提取公共词汇可以让各分会成员醒目提示。"},
        Realm					= {value = true,	desc = "显示服务器"},
        Target					= {value = 13,		desc = "相应数字之和显示相应信息：0-禁用，1-目标，2-目标的目标，4-关注的小队成员，8-关注的团队成员数"},
}

------------------------------ 预设颜色 --------------------------------
-- r,g,b分别为红绿蓝的RGB值/255所得

local TTColor = {
    Corpse					= {r=0.54, g=0.54, b=0.54},	-- 尸体颜色（灰色）
    MyGuild				= {r=1, g=0, b=1},			-- 本工会名颜色（粉红）
    MyGuildBG				= {r=0.4, g=0, b=0.83},		-- 本工会背景颜色（紫色）
    FriendBG				= {r=0.4, g=0.2, b=1},		-- 好友背景颜色（红紫色）
    Hostile					= {r=1, g=0, b=0},			-- 敌对玩家名字颜色（红色）
    HostileCharmed			= {r=1, g=0.4, b=1},			-- 敌对玩家（控制我）名字颜色（粉红）
    FriendlyPVP				= {r=0, g=1, b=0},			-- 友好玩家（PVP）名字颜色（绿色）
    Friendly					= {r=0, g=0.67, b=1},		-- 友好玩家（PVE）名字颜色（蓝色）
    HostileBG				= {r=0.5, g=0, b=0},			-- 敌对玩家背景颜色（暗红）
    FriendlyBG				= {r=0, g=0, b=0.5},			-- 友好玩家背景颜色（暗蓝）
    FriendlyPVPBG			= {r=0, g=0.2, b=0},			-- 友好PVP玩家背景颜色（暗绿）
    NPCBG					= {r=0, g=0, b=0},			-- NPC背景颜色（黑色）
    DK						= {r=0.8, g=1, b=0},			-- DK职业颜色（黄绿）
    Race					= "DDEEAA",				-- 种族、生物类型颜色（草绿色）
    Default					= "FFCC00",					-- 游戏默认颜色（金黄）
    Classification			= {
        ["elite"]				= "FFCC00",					-- 精英
        ["worldboss"]		= "FF0000",					-- 首领
        ["rare"]				= "FF66FF",					-- 稀有
        ["rareelite"]			= "FFAAFF",					-- 稀有精英
    },
    Faction					= {
        [5]					= "33CC33",					-- 友好（绿色）
        [6]					= "33CCCC",				-- 尊敬（湖蓝）
        [7]					= "FF6633",					-- 崇敬（橙色）
        [8]					= "DD33DD",				-- 崇拜（紫色）
    },
}

------------------------------ 本地化 ----------------------------------
local TTA;
local TTLoc = {
    ["tapped"]			= "Tapped",
    ["rare"]				= "Rare",
    ["rareelite"]			= "Rare Elite",
    ["you"]				= ">>YOU<<",
    ["targetedby"]		= "member(s) targetting it",
    ["far"]				= "Too far to inspect talent",
    ["nodata"]			= "No Data",
    ["itemtype"]			= "ItemType",
    ["itemid"]			= "ItemID",
    ["itemlevel"]			= "ItemLevel",
    ["itemstack"]		= "StackCount",
}
local TALENTS = {"Talent", "Talent"};
if GetLocale() == "zhCN" then
    TTLoc = {
        ["tapped"]			= "已被选取",
        ["rare"]				= "稀有",
        ["rareelite"]			= "稀有精英",
        ["you"]				= ">>你<<",
        ["targetedby"]		= "人关注",
        ["far"]				= "无法获取",
        ["nodata"]			= "没有数据",
        ["itemtype"]			= "物品类别",
        ["itemid"]			= "物品编号",
        ["itemlevel"]			= "物品等级",
        ["itemstack"]		= "堆叠数量",
    }
    TALENTS = {"天赋", "备用"};
    TTA = {	["默认"] = 0,	["跟随(1)"] = 1,	["跟随(2)"] = 3,	["跟随(3)"] = 6,	["上方(1)"] = 2,	["上方(2)"] = 4,	["上方(3)"] = 5}
elseif GetLocale() == "zhTW" then
    TTLoc = {
        ["tapped"]			= "已被選取",
        ["rare"]				= "稀有",
        ["rareelite"]			= "稀有精英",
        ["you"]				= ">>你<<",
        ["targetedby"]		= "人關注",
        ["far"]				= "無法獲取",
        ["nodata"]			= "沒有數據",
        ["itemtype"]			= "物品類別",
        ["itemid"]			= "物品編號",
        ["itemlevel"]			= "物品等級",
        ["itemstack"]		= "堆疊數量",
    }
    TALENTS = {"天賦", "備用"};
    TTA = {	["默認"] = 0,	["跟隨(1)"] = 1,		["跟隨(2)"] = 3,	["跟隨(3)"] = 6,	["上方(1)"] = 2,	["上方(2)"] = 4,	["上方(3)"] = 5}
end

TTLoc["elite"] = ELITE
TTLoc["worldboss"] = BOSS

------------------------------ 自定义结束 ----------------------------------

function TinytipUpdateAnchor(arg)
    if (TTA[arg]) then
        TTVar.Anchor = TTA[arg];
    end
end

TTVar = {}
local _G = getfenv(0)
local tmp,tmp2,tmp3
local unit, class, reaction, name

local TT = GameTooltip
local TTStatusBar = {}
TTStatusBar[1] = GameTooltipStatusBar
local barTexture = "Interface\\TargetingFrame\\UI-TargetingFrame-BarFill"

CURRENTLY_EQUIPPED = "|cFFFF8000----"..CURRENTLY_EQUIPPED.."----|r"

-- 简化逻辑与判断
local function BAnd(arg1, arg2)
    if not arg1 or not arg2 then return false end
    if bit.band(arg1, arg2) == arg1 then
        return true
    else
        return false
    end
end

-- 转换颜色格式
local function ParseColor(color, hex)
    if hex then
        return format("%2x%2x%2x",color.r*255,color.g*255,color.b*255)
    else
        return color.r, color.g, color.b, 1
    end
end

-- 职业颜色
local function UnitColor(unit)
    local _, class=UnitClass(unit)
    if class and RAID_CLASS_COLORS[class] then
        return ParseColor(RAID_CLASS_COLORS[class], true)
    else
        return "ffffff"
    end
end

-- 死亡或已被选取
local function DeadOrTapped(unit)
    if UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
        return 1
    elseif (UnitHealth(unit) <= 0 and not UnitIsPlayer(unit))
            or (UnitIsPlayer(unit) and UnitIsDeadOrGhost(unit)) then
        return 2
    else
        return 0
    end
end

-- 获取阵营、声望
local function UnitFaction(unit)
    reaction = UnitReaction(unit, "player")
    if not reaction then return 0 end

    if reaction < 5 then
        tmp = ParseColor(FACTION_BAR_COLORS[reaction], true)
    else
        tmp = TTColor.Faction[reaction]
    end
    if DeadOrTapped(unit) > 0 then
        tmp = ParseColor(TTColor.Corpse, true)
    end
    tmp2 = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
    return format("|cFF%s%s|r", tmp, tmp2)
end

--格式化天赋
local function UnitTalent(names, nums, colors)
    local name, point
    if nums[1] >= nums[2] then
        if nums[1] >= nums[3] then
            tmp = 1
            if nums[2] >= nums[3] then tmp2 = 2 tmp3 = 3 else tmp2 = 3	tmp3 = 2 end
        else
            tmp = 3 tmp2 = 1 tmp3 = 2
        end
    else
        if nums[2] >= nums[3] then
            tmp = 2
            if nums[1] >= nums[3] then tmp2 = 1 tmp3 = 3 else tmp2 = 3 tmp3 = 1 end
        else
            tmp = 3 tmp2 = 2 tmp3 = 1
        end
    end
    if nums[tmp]*3/4 <= nums[tmp2] then
        if nums[tmp]*3/4 <= nums[tmp3] then
            name = colors[tmp]:format(names[tmp]).."/"..colors[tmp2]:format(names[tmp2]).."/"..colors[tmp3]:format(names[tmp3])
        else
            name = colors[tmp]:format(names[tmp]).."/"..colors[tmp2]:format(names[tmp2])
        end
    else
        name = colors[tmp]:format(names[tmp])
    end
    point = (" (%s/%s/%s)"):format(colors[1]:format(nums[1]), colors[2]:format(nums[2]), colors[3]:format(nums[3]))
    return name..point
end

--天赋着色
local function TalentColor(point)
    tmp = MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()] - 9 --最大天赋点数
    tmp = point / tmp
    if tmp > 0.5 then
        tmp2 = 0.1 + (1 - tmp) * 2 * 0.9
        tmp3 = 0.9
    else
        tmp2 = 1.0
        tmp3 = 0.9 - (0.5 - tmp)* 2 * 0.9
    end

    return "|cFF".. ParseColor({r=tmp3, g=tmp2, b=0}, true) .."%s|r" -- GGRRBB
end

-- 设置人物信息
local L, L1, L2, IsPlayer
local function SetUnit(self, ...)
    name, unit = self:GetUnit()
    if not unit or not name then return end

    local i, cDeadOrTapped, levelLine, llText -- 行数、尸体颜色、等级行、等级行内容
    L = self:GetName() .. "TextLeft"
    L1 = _G[L .. "1"]
    L2 = _G[L .. "2"]
    IsPlayer = UnitIsPlayer(unit)
    reaction = UnitReaction(unit, "player")

    if DeadOrTapped(unit) >0 then cDeadOrTapped = ParseColor(TTColor.Corpse, true) end

    for i = 2, self:NumLines() do
        tmp = _G[L .. i]
        tmp2 = tmp:GetText()
        if tmp2 then
            if not levelLine and strfind(tmp2, LEVEL, 1, true) then	-- 找到等级行
                llText = tmp
                levelLine = i
                talentLine = i + 1
            end
            if levelLine and strfind(tmp2, PVP_ENABLED, 1, true) then	-- 移除PVP行
                tmp:SetText(nil)
                talentLine = i + 1
                break
            end
        else
            self:Hide()
        end
    end

    -- 职业颜色显示名字
    if TTVar.ClassColorName and IsPlayer then
        tmp = format( "|cFF%s%s|r", UnitColor(unit), name )
    else
        tmp = name
    end

    -- 头衔
    if TTVar.PVPRank and IsPlayer then
        tmp2 = UnitPVPName(unit)
        tmp3 = nil
        if tmp2 and tmp2 ~= name then
            i = strfind(tmp2, name)
            if i and i > 1 then
                tmp3 = strsub(tmp2, 1, i - 1 )
            elseif i == 1 then
                _, tmp3 = tmp2:match("(.+)，(.+)") --strsub(tmp2, strlen(name)+1)
            end
        end
        tmp3 = tmp3 and (", " .. tmp3) or ""
        L1:SetText( tmp .. tmp3)
    else
        L1:SetText( tmp )
    end

    -- 状态
    tmp = " |cFFFFFFFF"
    if TTVar.Status and IsPlayer then
        if UnitIsAFK(unit) then
            self:AppendText(tmp .. CHAT_FLAG_AFK)
        elseif UnitIsDND(unit) then
            self:AppendText(tmp .. CHAT_FLAG_DND)
        elseif not UnitIsConnected(unit) then
            self:AppendText(tmp .. "<" .. PLAYER_OFFLINE .. ">" )
        end
        if UnitIsFeignDeath(unit) then
            self:AppendText(tmp .. "<" .. GetSpellInfo(5384) .. ">" )
        end
    end

    --速度
    if TTVar.Speed then
        tmp2 = GetUnitSpeed(unit)
        if tmp2 and tmp2 > 0 then
            self:AppendText (tmp .. "<" .. format("%.0f%%", (tmp2 / 7 * 100)) ..">")
        end
    end

    -- 阵营
    if cDeadOrTapped then
        L1:SetTextColor(ParseColor(TTColor.Corpse))
        if levelLine and levelLine == 3 then
            L2:SetTextColor(ParseColor(TTColor.Corpse))
        end
    elseif IsPlayer or UnitPlayerControlled(unit) then
        if reaction and reaction<4 then -- 敌对
            self:SetBackdropColor(ParseColor(TTColor.HostileBG))
            L1:SetTextColor(ParseColor(TTColor.Hostile))
            if not UnitCanAttack("player", unit) and UnitCanAttack(unit, "player") then -- 被控制
                L1:SetTextColor(ParseColor(TTColor.HostileCharmed))
            end
        else -- 友好
            if UnitIsPVP(unit) then -- 友好（PvP）
                L1:SetTextColor(ParseColor(TTColor.FriendlyPVP))
                self:SetBackdropColor(ParseColor(TTColor.FriendlyPVPBG))
            else -- 友好（PvE）
                L1:SetTextColor(ParseColor(TTColor.Friendly))
                self:SetBackdropColor(ParseColor(TTColor.FriendlyBG))
            end
        end
    else -- npc
        self:SetBackdropColor(ParseColor(TTColor.NPCBG))
        if reaction then
            L1:SetTextColor(ParseColor(FACTION_BAR_COLORS[reaction]))
        end
    end

    -- 第二行（信息行）上色
    if not cDeadOrTapped and levelLine and levelLine == 3 then
        L2:SetTextColor( L1:GetTextColor() )
    end

    if levelLine then
        -- 等级
        tmp = UnitLevel(unit)
        tmp2 = ParseColor(GetQuestDifficultyColor(tmp), true)
        if reaction and reaction > 4 and tmp >= UnitLevel("player") +5 then
            tmp2 = "800000"
        end
        llText:SetText( format( "|cFF%s%s %s|r",
            cDeadOrTapped or tmp2 or TTColor.Default,
            LEVEL, tmp ~= -1 and tmp or "??") )

        -- 生物分级：精英、稀有、首领等
        tmp = UnitClassification(unit)
        if tmp and tmp ~= "normal" then
            llText:SetText(format("%s |cFF%s%s|r",
                llText:GetText() or "",
                cDeadOrTapped or TTColor.Classification[tmp] or TTColor.Default,
                TTLoc[tmp] or "" ) )
        end

        -- 职业、种族、生物类型、声望
        if IsPlayer then
            llText:SetText( format("%s |cFF%s%s|r |cFF%s%s|r",
                llText:GetText() or "",
                cDeadOrTapped or TTColor.Race,
                TTVar.Race and UnitRace(unit) or "",
                cDeadOrTapped or UnitColor(unit),
                UnitClass(unit) or UNKNOWN ) )
        elseif UnitPlayerControlled(unit) then
            llText:SetText( format("%s |cFF%s%s|r",
                llText:GetText() or "",
                cDeadOrTapped or TTColor.Race,
                UnitCreatureFamily(unit) or UNKNOWN ) )
        else
            llText:SetText( format("%s |cFF%s%s %s|r",
                llText:GetText() or "",
                cDeadOrTapped or TTColor.Race,
                UnitCreatureType(unit) or "" ,
                TTVar.Faction and UnitFaction(unit) or "" ) )
        end
    end

    -- 添加：尸体或已被选取
    if cDeadOrTapped and llText then
        llText:SetText( format( "%s |cFF%s(%s)|r",
            llText:GetText(),
            cDeadOrTapped,
            ( DeadOrTapped(unit) == 1 and TTLoc["tapped"] ) or CORPSE ) )
    end

    -- 好友背景
    if TTVar.ColorFriends and IsPlayer and UnitIsFriend(unit, "player") then
        for i = 1, GetNumFriends() do
            tmp,tmp2 = GetFriendInfo(i)
            if tmp and tmp2 ~= 0 and name and tmp == name then
                self:SetBackdropColor(ParseColor(TTColor.FriendBG))
                break
            end
        end
    end

    -- 工会和服务器名
    _, tmp = UnitName(unit)
    tmp2, tmp3 = GetGuildInfo(unit)
    if IsPlayer then
        if TTVar.Realm and tmp ~= nil and tmp ~= "" then tmp = " @ ".."<"..tmp..">" else tmp = "" end
        if tmp2 then
            if TTVar.Guild then
                if TTVar.GuildRank and tmp3 then tmp3 = "·"..tmp3 else tmp3 = "" end
                L2:SetText("<"..tmp2..tmp3..">"..tmp)
                if IsInGuild() and not cDeadOrTapped
                        and (tmp2 == GetGuildInfo("player") or (TTVar.MyGuild ~="" and strfind(tmp2,TTVar.MyGuild))) then
                    L2:SetTextColor(ParseColor(TTColor.MyGuild))
                    self:SetBackdropColor(ParseColor(TTColor.MyGuildBG))
                else
                    L2:SetTextColor(L1:GetTextColor())
                end
            else
                L2:SetText(tmp)
            end
        else
            if tmp ~= nil and tmp ~= "" then
                llText = L2:GetText()
                L2:SetText(tmp)
                L2:SetTextColor(L1:GetTextColor())
                self:AddLine(llText)
            end
        end
    end

    -- 目标
    tmp = unit .. "target"
    if BAnd(1, TTVar.Target) and UnitExists(tmp) then
        tmp2 = UnitName(tmp) or ""
        if UnitIsUnit(tmp, "player") then
            self:AddLine( format("%s: |cFFFF0000%s|r", TARGET, TTLoc["you"]) )
        elseif UnitIsPlayer(tmp) then
            self:AddLine( format("%s: |cFF%s%s|r", TARGET, UnitColor(tmp), tmp2 ) )
        else
            tmp3 = FACTION_BAR_COLORS[UnitReaction(tmp, "player")]
            self:AddLine( format("%s: |cFF%s%s|r", TARGET, tmp3 and ParseColor(tmp3, true) or TTColor.Default, tmp2 ) )
        end
    end

    -- 关注的小队成员
    if BAnd(4, TTVar.Target) and UnitInParty("player") then
        tmp = GetNumSubgroupMembers()
        tmp2 = nil
        for i = 1, tmp do
            tmp3 = "party" .. i
            if UnitIsUnit(tmp3 .. "target",unit) and not UnitIsUnit(tmp3, "player") then
                tmp2 = format("%s\n|cFF%s%s|r", tmp2 or "", UnitColor(tmp3), UnitName(tmp3) or UNKNOWN)
            end
        end
        if tmp2 then
            self:AddLine( format("%s:%s", GROUP, tmp2) )
        end
    end

    -- 关注的团队成员数
    if BAnd(8, TTVar.Target) and UnitInRaid("player") then
        -- tmp = GetNumRaidMembers()
        tmp = GetNumGroupMembers()
        tmp2 = 0
        for i = 1,tmp,1 do
            if UnitIsUnit("raid" .. i .. "target",unit) then
                tmp2 = tmp2 + 1
            end
        end
        if tmp2 > 0 then
            self:AddLine( format("%s: (|cFFFFFFFF%s|r) %s", RAID, tostring(tmp2), TTLoc["targetedby"]) )
        end
    end

    self:Show()
end

-- 创建状态条
local function CreateStatusBar(bar, i)
    if i > 1 then
        bar[i] = CreateFrame("StatusBar",nil, bar[i-1])
        bar[i]:SetStatusBarTexture(barTexture)
        bar[i]:SetHeight(bar[i-1]:GetHeight())
        bar[i]:SetPoint("TOPLEFT", bar[i-1], "BOTTOMLEFT", 0, -2)
        bar[i]:SetPoint("TOPRIGHT", bar[i-1], "BOTTOMRIGHT", 0, -2)
        bar[i]:SetFrameStrata("TOOLTIP")
        bar[i]:Hide();
    end

    bar[i].BG = CreateFrame("StatusBar", nil, bar[i])
    bar[i].BG:SetStatusBarTexture(barTexture)
    bar[i].BG:SetAlpha(0.2)
    bar[i].BG:SetAllPoints()
    bar[i].BG:SetFrameStrata("DIALOG")

    bar[i].Text = bar[i]:CreateFontString(nil, "OVERLAY")
    bar[i].Text:SetFont(GameFontNormalSmall:GetFont(), 11, "OUTLINE")
    bar[i].Text:SetPoint("CENTER", bar[i], "CENTER")
end

-- 设置状态条文本
local function SetStatusBarText(self, val, max)
    if not max or max == 0 then return end

    local percent = format("%.1f%%", (val / max * 100))
    tmp, tmp2 = 10000, "W"
    if val and val > tmp then val = format("%.1f %s", (val/tmp), tmp2 ) end
    if max and max > tmp then max = format("%.1f %s", (max/tmp), tmp2 ) end

    tmp = ""
    if BAnd(1, TTVar.StatusBarText) then
        tmp = val
    end
    if BAnd(2, TTVar.StatusBarText) then
        tmp = tmp .. " / " .. max
    end
    if BAnd(4, TTVar.StatusBarText) and percent ~= "100.0%" and percent ~= "0.0%" then
        tmp = tmp .. " (" .. percent .. ")"
    end
    self:SetText(tmp)
end

-- 设置血条
local function SetHealth(self, unit)
    if not unit then return end
    self:SetHeight(TTVar.StatusBarHeight)

    class = select(2, UnitClass(unit))
    if class and TTVar.ClassColorBorder then
        self:GetParent():SetBackdropBorderColor(ParseColor(RAID_CLASS_COLORS[class]))
        self:SetStatusBarColor(ParseColor(RAID_CLASS_COLORS[class]))
    end

    tmp = UnitHealth(unit)
    tmp2 = UnitHealthMax(unit)
    SetStatusBarText(self.Text, tmp, tmp2)

    if TTVar.ClassColorBorder and class then
        self.Text:SetTextColor(0, 1, 0)
    else
        self.Text:SetTextColor(1, 1, 1)
    end

    self.BG:SetStatusBarColor( self:GetStatusBarColor() )
    self.BG:Show()
end

-- 设置法力条
local function SetPower(self, unit)
    self:SetHeight(TTStatusBar[1]:GetHeight())
    tmp = UnitPowerType(unit)
    if tmp then
        tmp2 = UnitPower(unit)
        tmp3 = UnitPowerMax(unit)
        if tmp3 == 0 then
            self:Hide()
            return
        end

        self:SetStatusBarColor(ParseColor(PowerBarColor[tmp]))
        self:SetMinMaxValues(0, tmp3)
        self:SetValue(tmp2)
        self:Show()

        self.BG:SetStatusBarColor(self:GetStatusBarColor())
        self.BG:Hide()

        SetStatusBarText(self.Text, tmp2, tmp3)
    end
end

-- 设置Buff或Debuff
local function SetBuff(unit, GetBuff)
    tmp = 1
    tmp3 = ""
    while (GetBuff(unit, tmp)) do
        tmp2 = select(3, GetBuff(unit, tmp))
        tmp3 = tmp3 .. "|T" .. tmp2 .. ":18:18:1:-5|t"
        tmp = tmp + 1
    end
    TT:AddLine(tmp3)
end

-- 设置物品价格
local ItemPrice
local function SetItemPrice(self, itemID)
    GameTooltip_ClearMoney(self)
    if LibStub then
        ItemPrice = LibStub("ItemPrice-1.1", true)
    else
        return
    end
    local money = ItemPrice and ItemPrice:GetPriceById(tonumber(itemID))
    if money then
        if money == 0  then self:AddLine(ITEM_UNSELLABLE) end
        SetTooltipMoney(self, money)
    else
        self:AddLine(TTLoc["nodata"])
    end
end

-- 设置物品信息
local itemLink, itemID, itemRarity, itemLevel, itemType, itemSubType, itemStackCount, itemTexture
local function SetItem(self, ...)
    itemLink = select(2, self:GetItem())
    if not itemLink then return end

    local tmp = _G[self:GetName() .. "TextLeft1"];
    if strfind(tostring(tmp:GetText()), "|T") then return end --消除配方提示SetItem执行两遍的问题

    itemRarity, itemLevel, _, itemType, itemSubType, itemStackCount, _, itemTexture = select(3, GetItemInfo(itemLink))
    itemID = itemLink:match("item:(%d+)")

    if BAnd(16, TTVar.ItemInfo) and not (self==TT and MerchantFrame:IsShown()) then	--价格
        --	SetItemPrice(self, itemID)
    end
    if BAnd(32, TTVar.ItemInfo) and itemTexture then --图标
        itemTexture = "|T" .. itemTexture .. ":20|t "
        tmp:SetText(itemTexture .. tmp:GetText());
    end
    if BAnd(64, TTVar.ItemInfo) and itemRarity then --物品质量颜色显示边框
        self:SetBackdropBorderColor( GetItemQualityColor(itemRarity) )
    end
    self:Show();
end

local function HoverTip()
    for i = 1, NUM_CHAT_WINDOWS do
        tmp = _G["ChatFrame"..i]
        tmp:SetScript("OnHyperlinkEnter", function(self, link, ...)
            tmp2 = link:match("^([^:]+)")
            tmp3 = "item:enchant:spell:quest:unit:talent:achievement:glyph"
            if not strfind(tmp3, tmp2) then return end
            TT:SetOwner(self, "ANCHOR_TOPLEFT")
            TT:SetHyperlink(link)
            TT:Show()
        end)
        tmp:SetScript("OnHyperlinkLeave", function(...)
            TT:Hide()
        end)
    end
end


--锚点，修改自zTip
local function SetDefaultAnchor(tooltip,owner)
    if TTVar.Anchor == 0 then
        return
    end

    if owner == UIParent then
        if UnitExists("mouseover") then --人物
            tooltip:SetOwner(owner, "ANCHOR_NONE")
            if TTVar.Anchor == 2 or TTVar.Anchor == 4 or  TTVar.Anchor == 5 then -- 在上方
                tooltip:ClearAllPoints();
                tooltip:SetPoint("TOP",UIParent,"TOP", TTVar.OffsetX, TTVar.OffsetY)
            end
        else --熔炉、信箱等
            tooltip:SetOwner(owner, "ANCHOR_CURSOR")
        end
    else -- 按钮等非人物提示
        -- 修复一键驱散显示重复问题
        if (owner and owner:GetName() and strfind(owner:GetName(), "^DcrMicroUnit")) then
            return;
        end
        if TTVar.Anchor == 3 or TTVar.Anchor == 4 then
            tooltip:SetOwner(owner,"ANCHOR_RIGHT")
        elseif TTVar.Anchor == 5 then
            tooltip:SetOwner(owner, "ANCHOR_NONE")
            tooltip:ClearAllPoints();
            tooltip:SetPoint("TOP",UIParent,"TOP", TTVar.OffsetX, TTVar.OffsetY)
        elseif TTVar.Anchor == 6 then
            --tooltip:SetOwner(owner, "ANCHOR_NONE")
        else -- 默认位置（屏幕右下）
            return
        end
    end
end

function TT_GameTooltipOverridePoint(self)
    self = self or GameTooltip;
    if self._cycleFlag then return end

    if(self:IsOwned(UIParent) and (TTVar.Anchor == 1 or TTVar.Anchor == 3)) --on world object
            or (not self:IsOwned(Minimap) and TTVar.Anchor == 6) then --all follow

        local x, y = GetCursorPosition()
        local x0, y0 = x, y
        local scale = UIParent:GetScale()
        if (scale and scale ~= 0) then
            x = (x + TTVar.OffsetX) / scale / TTVar.Scale
            y = (y + TTVar.OffsetY) / scale / TTVar.Scale - self:GetHeight()
        end

        --处理遮挡的情况
        if TTVar.OffsetY < 0 and y < 0 and 0 - y + self:GetHeight() - TTVar.OffsetY > y0 then
            y = (y0 - TTVar.OffsetY) / scale / TTVar.Scale
        end

        self:ClearAllPoints()
        self._cycleFlag = 1
        self:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT", x, y)
        self._cycleFlag = nil
    end
end

local function OnShow(self)
    if TTVar.Scale then self:SetScale(TTVar.Scale) end

    unit = select(2, self:GetUnit())
    if unit then
        SetHealth(TTStatusBar[1], unit)
        if TTVar.Power then SetPower(TTStatusBar[2], unit) end
        if BAnd(1, TTVar.Buff) then SetBuff(unit, UnitBuff) end
        if BAnd(2, TTVar.Buff) then SetBuff(unit, UnitDebuff) end
    else
        TTStatusBar[1].Text:SetText("");
        --TTStatusBar[1]:Hide()
        TTStatusBar[2]:Hide()
    end

    --RunOnNextFrame(TT_GameTooltipOverridePoint) --必须下一帧才生效! --在Show里有了
end

local lastUpdate = 0
local x,y,scale
local function OnUpdate(self, elapsed)
    GameTooltip_OnUpdate(self, elapsed)
    if TT.updateTooltip == TOOLTIP_UPDATE_TIME then TT_GameTooltipOverridePoint(TT) end
    
    lastUpdate = lastUpdate - elapsed
    if lastUpdate < 0 then
        if TT.updateTooltip ~= TOOLTIP_UPDATE_TIME then TT_GameTooltipOverridePoint(TT) end

        name, unit = TT:GetUnit()
        if name and TT:IsOwned(UIParent) and not UnitExists("mouseover") then
            if not TTVar.Fade then
                TT:Hide()
            end
        end

        if unit then
            SetHealth(TTStatusBar[1], unit)
            if TTVar.Power then SetPower(TTStatusBar[2], unit) end
        end

        if TTVar.HideInCombat and InCombatLockdown() and TT:IsShown() and TT:IsOwned(UIParent) then
            TT:Hide()
        end

        lastUpdate = 0.02
    end
end

local function SlashCMD(msg)
    if msg == "" then
        DEFAULT_CHAT_FRAME:AddMessage("TinyTip by |c00abd473Hughman|r： |cFFFFFF00/tinytip(tth) cmd[=value]|r（取值為true/false的省略方括號內容）", 0, 1, 0)
        local a = {}
        for k in pairs(TTCfg) do tinsert(a, k) end
        table.sort(a)
        for _, k in pairs(a) do
            DEFAULT_CHAT_FRAME:AddMessage("    |cFFFFFF00" .. k .. "|r=|cFF00FF00" .. tostring(TTVar[k]) .. "|r |cFF808080(" .. TTCfg[k].desc .. ")")
        end
    elseif msg == "reset" then
        TTVar = {}
        for k in pairs(TTCfg) do
            TTVar[k] = TTCfg[k].value
        end
        DEFAULT_CHAT_FRAME:AddMessage("TinyTip: Reset", 0, 1, 0)
    elseif msg == "clear" then
        DEFAULT_CHAT_FRAME:AddMessage("TinyTip: Clear Talent", 0, 1, 0)
    else
        if strfind(msg, "=") then
            tmp, tmp2 = msg:match("(.+)=(.+)")
        else
            tmp = msg
            tmp2 = nil
        end

        tmp3 = type(TTVar[tmp])
        if tmp3 == "number" and tmp2 then
            tmp2 = tonumber(tmp2)
            if tmp2 then TTVar[tmp] = tmp2 end
        elseif tmp3 == "boolean" then
            if TTVar[tmp] then
                TTVar[tmp] = false
            else
                TTVar[tmp] = true
            end
        elseif tmp3 == "string" and tmp2 then
            TTVar[tmp] = tmp2
        elseif not TTCfg[tmp] then
            TTVar[tmp] = nil
        end
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00TinyTip: " .. tmp .. "=|r|cFFFFFF00" .. tostring(TTVar[tmp]))
    end
end

local function OnLoad()
    for k in pairs(TTCfg) do
        if type(TTVar[k]) ~= type(TTCfg[k].value) then TTVar[k] = TTCfg[k].value end
    end

    --if TTVar.AltDKColor then RAID_CLASS_COLORS["DEATHKNIGHT"] = TTColor.DK end

    CreateStatusBar(TTStatusBar, 1)
    CreateStatusBar(TTStatusBar, 2)

    CoreRawHook(TT, "OnTooltipSetUnit", SetUnit, 1)
    CoreRawHook(TT, "OnTooltipSetItem", SetItem, 1)
    CoreRawHook(ItemRefTooltip, "OnTooltipSetItem", SetItem, 1)
    CoreRawHook(ShoppingTooltip1, "SetHyperlinkCompareItem", SetItem)
    CoreRawHook(ShoppingTooltip2, "SetHyperlinkCompareItem", SetItem)
        
    TT:SetScript("OnUpdate", OnUpdate)
    TT:SetScript("OnShow", OnShow)

    --只要是插件在OnUpdate里调用GameTooltip:XXX方法，就可能会导致问题
    hooksecurefunc(TT, "Show", TT_GameTooltipOverridePoint) --必须有这个，很多都是Set以后show的 --TimeManagerClockButton_UpdateTooltip
    hooksecurefunc(TT, "SetUnitAura", TT_GameTooltipOverridePoint) --BuffFrame:260
    hooksecurefunc(TT, "SetUnitDebuff", TT_GameTooltipOverridePoint) --TargetFrame
    hooksecurefunc(TT, "SetUnitBuff", TT_GameTooltipOverridePoint) --TargetFrame
    hooksecurefunc(TT, "SetItemByID", TT_GameTooltipOverridePoint) --Blizzard_EncounterJournal
    hooksecurefunc(TT, "SetText", TT_GameTooltipOverridePoint) --MiniMapBattlefieldFrame_OnUpdate
    hooksecurefunc(TT, "SetTotem", TT_GameTooltipOverridePoint) --TotemButton_OnUpdate
    hooksecurefunc(TT, "SetAuctionItem", TT_GameTooltipOverridePoint) --AuctionFrameItem_OnEnter
    hooksecurefunc(TT, "SetAuctionSellItem", TT_GameTooltipOverridePoint) --Blizzard_AuctionUI.xml[(1451: 22) |GameTooltip:|SetAuctionSellItem|();]
    hooksecurefunc(TT, "SetLootRollItem", TT_GameTooltipOverridePoint) --Blizzard_AuctionUI.xml[(1451: 22) |GameTooltip:|SetAuctionSellItem|();]
    hooksecurefunc(TT, "SetMissingLootItem", TT_GameTooltipOverridePoint) --Blizzard_AuctionUI.xml[(1451: 22) |GameTooltip:|SetAuctionSellItem|();]
    hooksecurefunc(TT, "SetSendMailItem", TT_GameTooltipOverridePoint) --MailFrame.xml:332

    --hooksecurefunc(TT, "SetOwner", TT_GameTooltipOverridePoint); --OnShow或者OnUpdate会处理涵盖了
    hooksecurefunc(TT, "SetPoint", TT_GameTooltipOverridePoint);
    hooksecurefunc(TT, "FadeOut", function() if not TTVar.Fade then TT:Hide() end end)

    hooksecurefunc("GameTooltip_SetDefaultAnchor", SetDefaultAnchor)

    --TTStatusBar[1]:HookScript("OnValueChanged", SetHealth)
    --SetCVar("showNewbieTips", "0");
    --SHOW_NEWBIE_TIPS = "0";
    --if TTVar.HoverLink then HoverTip() end

    -- 添加3D效果的皮肤
    local skin = GameTooltip:CreateTexture(nil, "BORDER");
    skin:SetTexture("Interface\\ChatFrame\\ChatFrameBackground");
    skin:SetPoint("TOPLEFT", GameTooltip, "TOPLEFT", 6, -6);
    skin:SetPoint("BOTTOMRIGHT", GameTooltip, "TOPRIGHT", -6, -27);
    skin:SetBlendMode("ADD");
    skin:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .2, .2, .2, 1);

    SLASH_TinyTip1 = "/tinytip"
    SLASH_TinyTip2 = "/tth"
    SlashCmdList["TinyTip"] = SlashCMD
end

local tabs, points, colors = {}, {}, {}
local function OnEvent(self, event, ...)
    if event == "VARIABLES_LOADED" then
        OnLoad()
        TT:UnregisterEvent("VARIABLES_LOADED")
    end
end

TT:SetScript("OnEvent", OnEvent)
TT:RegisterEvent("VARIABLES_LOADED")

CoreDependCall("AtlasLoot", function()
    if AtlasLootTooltipTEMP then
        AtlasLootTooltipTEMP.shoppingTooltips = AtlasLootTooltipTEMP.shoppingTooltips  or { ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3 };
        AtlasLootTooltipTEMP:HookScript("OnTooltipSetItem", function(self, ...)
            if ( IsModifiedClick("COMPAREITEMS") or (GetCVarBool("alwaysCompareItems") and not self:IsEquippedItem()) ) then
                GameTooltip_ShowCompareItem(self, 1);
            end
        end)
    end
end)


--[[
	Tipachu
		Adds item icons to tooltips
--]]


--*****************************************************************
-- spell icons
--*****************************************************************
local DEFAULT_ICON_SIZE = 20

local function AddIcon(self, icon)
	if BAnd(32, TTVar.ItemInfo) and icon then
		local title = _G[self:GetName() .. 'TextLeft1']
		if title and not title:GetText():find('|T' .. icon) then --make sure the icon does not display twice on recipies, which fire OnTooltipSetItem twice
			title:SetFormattedText('|T%s:%d|t %s', icon, DEFAULT_ICON_SIZE, title:GetText())
		end
	end
end

local function hookSpell(tip)
	tip:HookScript('OnTooltipSetSpell', function(self, ...)
        if self:GetSpell() then
		    local name, rank, icon = GetSpellInfo(self:GetSpell())
		    AddIcon(self, icon)
        end
	end)
    hooksecurefunc(tip, "AddSpellByID", function(self, ...)
        AddIcon(self, select(3, GetSpellInfo(...)))
    end)
end
hookSpell(_G['GameTooltip'])
hookSpell(_G['ItemRefTooltip'])

local name, private = ... _G[name] = private
CfgTinyTipHookSetHyperlinkCompareItem = function(shoppingtip)
    local old = shoppingtip.SetHyperlinkCompareItem
    shoppingtip.SetHyperlinkCompareItem = function(self, link, level, shift, main, ...)
        if private.hideCompare then main = nil end
        return old(self, link, level, shift, main, ...)
    end
end
CfgTinyTipHookSetHyperlinkCompareItem(ShoppingTooltip1)
CfgTinyTipHookSetHyperlinkCompareItem(ShoppingTooltip2)
CfgTinyTipHookSetHyperlinkCompareItem(ShoppingTooltip3)
CfgTinyTipHookSetHyperlinkCompareItem(ItemRefShoppingTooltip1)
CfgTinyTipHookSetHyperlinkCompareItem(ItemRefShoppingTooltip2)
CfgTinyTipHookSetHyperlinkCompareItem(ItemRefShoppingTooltip3)

--临时处理
ItemRefShoppingTooltip2:SetClampRectInsets(500,-500,0,0)
ShoppingTooltip2:SetClampRectInsets(500,-500,0,0)
