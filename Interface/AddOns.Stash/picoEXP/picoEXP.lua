

------------------------------
--      Are you local?      --
------------------------------

local myname, ns = ...
local start, cur, max, starttime, startlevel
local L = setmetatable(GetLocale() == 'zhCN' and {
	["EXP:"] = '经验: ',
	["Rest:"] = '双倍经验:',
	["TNL:"] = '升级还需经验:',
	["%.2f hours played this session"] = "本次登录持续了 %.2f 小时",
	["%d EXP gained this session"] = "本次登录共获得 %d 点经验",
	["%.2f levels gained this session"] = "本次登录共提升 %.2f 级",
} or {}, {__index = function(t, i)
    t[i] = i
    return  i
end})

-------------------------------------------
--      Namespace and all that shit      --
-------------------------------------------

local f = CreateFrame("frame")
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
local dataobj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("picoEXP", {type = "data source", text = "99%", icon = "Interface\\AddOns\\picoEXP\\icon"})


----------------------
--      Enable      --
----------------------


function f:PLAYER_LOGIN()
    if(UnitLevel'player' == MAX_PLAYER_LEVEL) then
        self:EnableReputation()
    else
        self:EnableExp()
    end

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end


function f:EnableReputation()
    self:RegisterEvent'CHAT_MSG_COMBAT_FACTION_CHANGE'
    self:RegisterEvent'UPDATE_FACTION'

    return self:UPDATE_FACTION()
end

function f:EnableExp()
    start, max, starttime = UnitXP("player"), UnitXPMax("player"), GetTime()

    cur = start
    startlevel = UnitLevel("player") + start/max

    self:RegisterEvent("PLAYER_XP_UPDATE")
    self:RegisterEvent("PLAYER_LEVEL_UP")

    return self:PLAYER_XP_UPDATE()
end

function f:DisableExp()
    cur = nil
    self:UnregisterEvent'PLAYER_LEVEL_UP'
    self:UnregisterEvent'PLAYER_XP_UPDATE'
end

------------------------------
--      Event Handlers      --
------------------------------

function f:PLAYER_XP_UPDATE()
	cur = UnitXP("player")
	max = UnitXPMax("player")
	dataobj.text = L['EXP:'].. string.format("%d%%", cur/max*100)
end


function f:PLAYER_LEVEL_UP()
	start = start - max

    if(UnitLevel'player' == MAX_PLAYER_LEVEL) then
        self:DisableExp()
        self:EnableReputation()
    end
end

local function get_watching_faction()
    for i = 1, GetNumFactions() do
        local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(i)
        if(isWatched) then
            return name, standingID, barMax-barMin, barValue-barMin
        end
    end
end

function f:CHAT_MSG_COMBAT_FACTION_CHANGE()
    local name, standingID, full, now = get_watching_faction()
    if(not name) then
        dataobj.text = '没有正在追踪声望'
    else
        local perc = now/full*100
        local lbl = _G['FACTION_STANDING_LABEL'..standingID]
        dataobj.text = string.format('%s: %.1f%% (%s)', name, perc, lbl)
    end
end

f.UPDATE_FACTION = f.CHAT_MSG_COMBAT_FACTION_CHANGE

------------------------
--      Tooltip!      --
------------------------

local function GetTipAnchor(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end


function dataobj.OnLeave() GameTooltip:Hide() end
function dataobj.OnEnter(self)
    if(not cur) then return end
 	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(GetTipAnchor(self))
	GameTooltip:ClearLines()

	GameTooltip:AddLine("picoEXP")

	GameTooltip:AddDoubleLine(L["EXP:"], cur.."/"..max, nil,nil,nil, 1,1,1)
	GameTooltip:AddDoubleLine(L["Rest:"], string.format("%d%%", (GetXPExhaustion() or 0)/max*100), nil,nil,nil, 1,1,1)
	GameTooltip:AddDoubleLine(L["TNL:"], max-cur, nil,nil,nil, 1,1,1)
	GameTooltip:AddLine(string.format(L["%.2f hours played this session"], (GetTime()-starttime)/3600), 1,1,1)
	GameTooltip:AddLine(string.format(L["%d EXP gained this session"], cur - start), 1,1,1)
	GameTooltip:AddLine(string.format(L["%.2f levels gained this session"], UnitLevel("player") + cur/max - startlevel), 1,1,1)

	GameTooltip:Show()
end

if IsLoggedIn() then f:PLAYER_LOGIN() else f:RegisterEvent("PLAYER_LOGIN") end
