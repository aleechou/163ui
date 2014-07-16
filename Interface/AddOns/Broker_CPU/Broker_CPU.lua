--[[
    Broker_CPU, display CPU/Memory usage, Framerate, Latency for World of Warcraft
    Copyright (C) 2010 Arnaud Dovi (ad@heapoverflow.com)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

--[[
$Rev:: 38                    $:  Revision of last commit
$Author:: arnaud             $:  Author of last commit
$Date:: 2012-09-02 22:37:24 #$:  Date of last commit
$WoW:: 5.0.5.16030           $:  Client of the last tests
]]

-------------------------------------------------------------------------
-----------------Simple Code Profiling inside WoW------------------------
---------debug garbage memory and cpu usage in any piece of code---------
-------------------------------------------------------------------------
-- local totalgarb = 0
-- local ttotalcpu = 0
-- local function profileMem(start, MEMstart) -- anywhere up in the code
    -- if start then
        -- collectgarbage("collect") -- force the client to collect all garbage memory
        -- UpdateAddOnMemoryUsage() -- update the memory usage for all addons
        -- return GetAddOnMemoryUsage("Broker_CPU") -- get the memory usage for the addon "Broker_CPU"
    -- else
        -- UpdateAddOnMemoryUsage() -- update the memory usage for all addons
        -- return GetAddOnMemoryUsage("Broker_CPU") - MEMstart -- get the garbage memory for the addon "Broker_CPU"
    -- end
-- end
-- local function profileCpu(start, CPUstart) -- anywhere up in the code
    -- if start then
        -- UpdateAddOnCPUUsage() -- update the memory usage for all addons
        -- return GetAddOnCPUUsage("Broker_CPU") -- get the memory usage for the addon "Broker_CPU"
    -- else
        -- UpdateAddOnCPUUsage() -- update the memory usage for all addons
        -- return GetAddOnCPUUsage("Broker_CPU") - CPUstart -- get the new cpu usage usage for the addon "Broker_CPU"
    -- end
-- end

--local MEMstart = profileMem(true) -- copy paste BEFORE the code you want to profile for garbage memory production or cpu usage
--local t1end = profileMem(false, MEMstart) -- copy paste AFTER the code you want to profile for garbage memory production or cpu usage
--print("MEM-PROF:"..(t1end > 0 and t1end or 0)) -- copy paste AFTER the code you want to profile for garbage memory production or cpu usage, the returned number is the amount of the garbage between start and end

-- local CPUstart = profileCpu(true) -- copy paste BEFORE the code you want to profile for garbage memory production or cpu usage
-- local t1end = profileCpu(false, CPUstart) -- copy paste AFTER the code you want to profile for garbage memory production or cpu usage
-- print("CPU-PROF:"..(t1end > 0 and t1end or 0)) -- copy paste AFTER the code you want to profile for garbage memory production or cpu usage, the returned number is the amount of the garbage between start and end
------------------------------------------------------------------------------
------------------------------------------------------------------------------

if not LibStub then  end
local ldb, QTip, minimap, event, first, uidropdown, slashes, paused, qtdelay
local lastotalcpu, lastotalmem, lastlat, lastup, lastdl, scriptProfile, db
local totalcpu, totaldiff, totalmem, totalmemdiff, activeId = 0, 0, 0, 0, 0
local larg1, larg2, larg3, larg4, larg5, larg6
local numTotalAddOns, numActiveAddOns

local modsort, moddata, stringbin    = {}, {}, {}
local icon                           = "Interface\\AddOns\\Broker_CPU\\tt_icon"
local arrowa                         = { bgFile = "Interface\\AddOns\\Broker_CPU\\tt_arrowa" }
local arrowb                         = { bgFile = "Interface\\AddOns\\Broker_CPU\\tt_arrowb" }
local arrowc                         = { bgFile = "Interface\\AddOns\\Broker_CPU\\tt_arrowc" }
local MINOR_VERSION                  = tonumber(("$Revision: 38 $"):match("%d+"))
local frFR                           = GetLocale() == "frFR"
local fps_                           = frFR and "ips"  or "fps"
local kb                             = frFR and "Ko"   or "KB"
local kbs                            = frFR and "Ko/s" or "KB/s"
local mbs                            = frFR and "Mo/s" or "MB/s"
local mb                             = frFR and "Mo"   or "MB"
local newAddOn, firstLoad, hookWarn  = false, true, false
local isUpdateNotified               = false
local MAXD                           = 3 -- max decimals


local _
local _G             = _G
local collectgarbage = collectgarbage
local math_modf      = math.modf
local pairs          = pairs
local print          = print
local table_sort     = table.sort
local tonumber       = tonumber
local type           = type

local CreateFrame    = CreateFrame
local GetAddOnInfo   = GetAddOnInfo
local GetFramerate   = GetFramerate
local GetNetStats    = GetNetStats
local GetNumAddOns   = GetNumAddOns
local IsAddOnLoaded  = IsAddOnLoaded

local GetAddOnCPUUsage       = GetAddOnCPUUsage
local GetAddOnMemoryUsage    = GetAddOnMemoryUsage
local UpdateAddOnCPUUsage    = UpdateAddOnCPUUsage
local UpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage

-- in most case ResetCPUUsage() is not used in performance addons, and certainly not in a quest mod
-- if you get a warning about this in-game, this is most likely you are running Carbonite, it is known to do dirty hidden things with performance APIs
brokercpu_orig_ResetCPUUsage     = ResetCPUUsage

local L = {
    COLOR_ACE3    = "|cff33ff99",
    COLOR_ADDON   = "|cff00ffff",
    COLOR_CPU     = "|cff0095dd",
    COLOR_GOLD    = "|cfffed100",
    COLOR_GREEN   = "|cff33ff33",
    COLOR_GREY    = "|cff808080",
    COLOR_HINT1   = "|cffeda55f",
    COLOR_MEM     = "|cff0095dd",
    COLOR_RED     = "|cffff0000",
    COLOR_STOP    = "|r",
    COLOR_SUFF    = "|cfffed100",
    EXPANDED      = "The tooltip goes out of screen, autoresizing to show 5 AddOns.",
    LINE_STOP     = "\n",
    NOT_DBICO     = "(requires LibDBIcon-1.0)",
    NOT_QTIP      = "(requires LibQTip-1.0)",
    N_BLI         = "Total & Blizzard",
    N_CPU         = "CPU Profiling",
    N_DAT_SHOW    = "Show/Hide in %s",
    N_DEC         = "Decimals",
    N_DEC_CPU     = "Processor decimals",
    N_DEC_CPU2    = "Processor difference decimals",
    N_DEC_DL      = "Download decimals",
    N_DEC_FPS     = "Framerate decimals",
    N_DEC_LAT     = "Latency decimals",
    N_DEC_MEM     = "Memory decimals",
    N_DEC_MEM2    = "Memory difference decimals",
    N_DEC_UP      = "Upload decimals",
    N_DET         = "Detach",
    N_DL          = "Download",
    N_FPS         = "Framerate",
    N_GAR         = "Garbage",
    N_RESCPU      = "Reset cpu usage",
    N_HELP        = "Help",
    N_HID         = "Hide",
    N_ICO         = "Icons",
    N_LAT         = "Latency",
    N_LIB         = "Libraries",
    N_L_ICO       = "LibDBIcon",
    N_L_QTIP      = "LibQTip",
    N_MAP         = "Minimap",
    N_MEM         = "Memory",
    N_MOD         = "AddOns",
    N_SC          = "Scale",
    N_THR         = "Thresholds",
    N_THR_LDB     = "Broker",
    N_THR_TIP     = "Tooltip",
    N_TITLE       = "BrokerCPU",
    N_TOT         = "Total",
    N_UP          = "Upload",
    N_thr         = "threshold",
    Q_NAME        = "BrokerCPUQTip",
    SHOW_HELP     = "show command lines",
    SLASH_SEP     = " - ",
    TIPHINT1      = "%sFor cpu usage, the mod requires%scpu profiling enabled.%s",
    TIPHINT2      = "%sRemember to switch the profiling off%swhen you don't need it.%s",
    TIPHINT3      = "%sFor memory usage, just enable the%soption.%s",
    TIPHINT4      = "%sCtrl-Alt-LClick%s %sto enable/disable CPU%sprofiling.%s",
    TIPHINT5      = "%sType%s %s/brokercpu%s %sfor more usages.%s",
    TOGGLE_CPU    = "Toggle the client CPU profiling.",
    TOGGLE_DET    = "Toggle detached tooltip.",
    TOGGLE_DL     = "Toggle incoming bandwidth collection in %s.",
    TOGGLE_D_CPU  = "Change the number of decimals shown for cpu usage. (or type /cpu Dcpu <0-"..MAXD..">)",
    TOGGLE_D_CPU2 = "Change the number of decimals shown for cpu difference. (or type /cpu Dcpudiff <0-"..MAXD..">)",
    TOGGLE_D_DL   = "Change the number of decimals shown for incoming bandwith. (or type /cpu Ddl <0-"..MAXD..">)",
    TOGGLE_D_FPS  = "Change the number of decimals shown for framerate. (or type /cpu Dfps <0-"..MAXD..">)",
    TOGGLE_D_LAT  = "Change the number of decimals shown for latency. (or type /cpu Dlat <0-"..MAXD..">)",
    TOGGLE_D_MEM  = "Change the number of decimals shown for mem usage. (or type /cpu Dmem <0-"..MAXD..">)",
    TOGGLE_D_MEM2 = "Change the number of decimals shown for mem difference. (or type /cpu Dmemdiff <0-"..MAXD..">)",
    TOGGLE_D_UP   = "Change the number of decimals shown for outgoing bandwith. (or type /cpu Dup <0-"..MAXD..">)",
    TOGGLE_FPS    = "Toggle framerate collection in %s.",
    TOGGLE_GAR    = "Force the client to collect the garbage memory",
    TOGGLE_RESCPU = "Force the client to reset the cpu usage",
    TOGGLE_HID    = "Hide a detached QTip. (or Shift+Click the Broker icon)",
    TOGGLE_ICO    = "Toggle the arrow icons.",
    TOGGLE_KLL    = "Set a maximum number of AddOns to show. (or type /cpu kill <number>)",
    TOGGLE_LAT    = "Toggle latency collection in %s.",
    TOGGLE_LDB    = "Threshold (in seconds) of the broker text update. (or type /cpu Tldb <number>)",
    TOGGLE_L_ICO  = "Toggle the use of LibDBIcon.",
    TOGGLE_L_QTIP = "Toggle between the use of LibQTip or GameTooltip.",
    TOGGLE_MAP    = "Toggle minimap icon.",
    TOGGLE_MEM    = "Toggle memory collection in %s.",
    TOGGLE_RST    = "Reset the AddOn to default settings.",
    TOGGLE_SC     = "Change the qtip scale. (or type /cpu scale <number>)",
    TOGGLE_TIP    = "Threshold (in seconds) of the tooltip update. (or type /cpu Ttip <number>)",
    TOGGLE_UP     = "Toggle outgoing bandwidth collection in %s.",
}
do
    if GetLocale() == 'zhCN' then
        L["N_MEM"] = "内存"
        L["N_MAP"] = "小地图"
        L["N_ICO"] = "图标"
        L["N_MOD"] = "插件"
        L["N_THR"] = "阀值"
        L["N_thr"] = "阀值"
        L["N_THR_LDB"] = "文字"
        L["N_THR_TIP"] = "鼠标提示文字"
        L["N_CPU"] = "CPU详情"
        L["N_DET"] = "分离提示"
        L["N_FPS"] = "FPS"
        L["N_LAT"] = "延迟"
        L["N_UP"] = "上传"
        L["N_DL"] = "下载"
        L["N_GAR"] = "内存回收"
        L["N_SC"] = "缩放"
        L["N_HID"] = "隐藏"
        L["N_TOT"] = "总计"
        L["N_BLI"] = "总计(包括暴雪插件)"
        L["N_LIB"] = "库"

        L["N_DAT_TIP"] = "鼠标提示"
        L["N_DAT_LDB"] = "LDB显示"

        L["TOGGLE_CPU"] = "开关CPU占用详情显示."
        L["TOGGLE_MEM"] = "开关 %s 中显示内存数据."
        L["TOGGLE_FPS"] = "开关 %s 中显示FPS数据."
        L["TOGGLE_LAT"] = "开关 %s 中显示延迟数据."
        L["TOGGLE_MAP"] = "开关小地图图标."
        L["TOGGLE_ICO"] = "开关箭头图标."
        L["TOGGLE_KLL"] = "设置最多显示的插件数量."
        L["TOGGLE_LDB"] = "LDB文字更新时间间隔 (秒)."
        L["TOGGLE_TIP"] = "鼠标提示更新时间间隔 (秒)."
        L["TOGGLE_DET"] = "分离提示."
        L["TOGGLE_RST"] = "重置本插件设置."
        L["TOGGLE_HID"] = "关闭分离的QTip提示. (或者Shift点击LDB图标)"
        L["TOGGLE_GAR"] = "强制内存回收"
        L["TOGGLE_L_QTIP"] = "切换使用LibQTip库或游戏鼠标提示."
        L["TOGGLE_L_ICO"] = "切换使用LibDBIcon."
        L["TOGGLE_L_DEW"] = "切换使用DewdropLib."
        L["TOGGLE_SC"] = "QTip缩放."
        L["NOT_QTIP"] = "(需要 LibQTip-1.0)"
        L["NOT_DBICO"] = "(需要 LibDBIcon-1.0)"
        L["NOT_DEW"] = "(需要 DewdropLib)"
        L["TIPHINT1"] = "%sCPU占用详情显示需要启用%sCPU详情.%s"
        L["TIPHINT2"] = "%s请关闭内存情况显示%s在你不需要的时候.%s"
        L["TIPHINT3"] = "%s查看内存情况, 请启用 %s 选项.%s"
        L["TIPHINT4"] = "%sCtrl+Alt+左键点击%s %s开启/关闭 CPU%详情.%s"
        L["TIPHINT5"] = "%s输入%s %s/brokercpu%s %s查询更多信息.%s"
        L["EXPANDED"] = "鼠标提示跑到屏幕外面去了, 自动缩放至只显示5个插件."
    elseif GetLocale() == 'zhTW' then
        L["N_MEM"] = "內存"
        L["N_MAP"] = "小地圖"
        L["N_ICO"] = "圖標"
        L["N_MOD"] = "插件"
        L["N_THR"] = "閥值"
        L["N_thr"] = "閥值"
        L["N_THR_LDB"] = "文字"
        L["N_THR_TIP"] = "鼠標提示文字"
        L["N_CPU"] = "CPU詳情"
        L["N_DET"] = "分離提示"
        L["N_FPS"] = "FPS"
        L["N_LAT"] = "延遲"
        L["N_UP"] = "上傳"
        L["N_DL"] = "下載"
        L["N_GAR"] = "內存回收"
        L["N_SC"] = "縮放"
        L["N_HID"] = "隱藏"
        L["N_TOT"] = "總計"
        L["N_BLI"] = "總計(包括暴雪插件)"
        L["N_LIB"] = "庫"

        L["N_DAT_TIP"] = "鼠標提示"
        L["N_DAT_LDB"] = "LDB顯示"

        L["TOGGLE_CPU"] = "開關CPU占用詳情顯示."
        L["TOGGLE_MEM"] = "開關 %s 中顯示內存數據."
        L["TOGGLE_FPS"] = "開關 %s 中顯示FPS數據."
        L["TOGGLE_LAT"] = "開關 %s 中顯示延遲數據."
        L["TOGGLE_MAP"] = "開關小地圖圖標."
        L["TOGGLE_ICO"] = "開關箭頭圖標."
        L["TOGGLE_KLL"] = "設置最多顯示的插件數量."
        L["TOGGLE_LDB"] = "LDB文字更新時間間隔 (秒)."
        L["TOGGLE_TIP"] = "鼠標提示更新時間間隔 (秒)."
        L["TOGGLE_DET"] = "分離提示."
        L["TOGGLE_RST"] = "重置本插件設置."
        L["TOGGLE_HID"] = "關閉分離的QTip提示. (或者Shift點擊LDB圖標)"
        L["TOGGLE_GAR"] = "強制內存回收"
        L["TOGGLE_L_QTIP"] = "切換使用LibQTip庫或游戲鼠標提示."
        L["TOGGLE_L_ICO"] = "切換使用LibDBIcon."
        L["TOGGLE_L_DEW"] = "切換使用DewdropLib."
        L["TOGGLE_SC"] = "QTip縮放."
        L["NOT_QTIP"] = "(需要 LibQTip-1.0)"
        L["NOT_DBICO"] = "(需要 LibDBIcon-1.0)"
        L["NOT_DEW"] = "(需要 DewdropLib)"
        L["TIPHINT1"] = "%sCPU占用詳情顯示需要啟用%sCPU詳情.%s"
        L["TIPHINT2"] = "%s請關閉內存情況顯示%s在你不需要的時候.%s"
        L["TIPHINT3"] = "%s查看內存情況, 請啟用 %s 選項.%s"
        L["TIPHINT4"] = "%sCtrl+Alt+左鍵點擊%s %s開啟/關閉 CPU%詳情.%s"
        L["TIPHINT5"] = "%s輸入%s %s/brokercpu%s %s查詢更多信息.%s"
        L["EXPANDED"] = "鼠標提示跑到屏幕外面去了, 自動縮放至只顯示5個插件."
    end
end

local function D(...)
    print(...)
end

-- it forces the mod to not produce garbage in loops with stable strings (ie addon names, ranks, ...)
-- but don't do it with unique strings (ie cpu, mem...) or it will produce garbage, unique strings are born to be garbage anyway
-- it saves from producing a notable amount of garbage memory to each loops with stable concatened strings
-- this could have a negative impact if you don't understand and use it wrongly
local function stringRecycler(...)
    stringbin[...] = ...
    return stringbin[...]
end

local function issueWarning(c)
    hookWarn = true
    D(("%s%s%s: |cff808080!WARNING! an addon has tried to use the API %s which is an API normally reserved to performance addons and in most cases these last won't have to use it.\nTo prevent further issues, BrokerCPU now hooks this critical function to ensure it is not used."):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, c))
    return 0
end

local function newResetCPUUsage()
    return not hookWarn and issueWarning("ResetCPUUsage") or "Forbidden by BrokerCPU"
end

-- Tekkub's colorGradient() as seen in picoFPS
local function colorGradient(perc, r1, g1, b1, r2, g2, b2, r3, g3, b3)
    if perc >= 1 then return r3, g3, b3 elseif perc <= 0 then return r1, g1, b1 end
    local segment, relperc = math_modf(perc*2)
    if segment == 1 then r1, g1, b1, r2, g2, b2 = r2, g2, b2, r3, g3, b3 end
    return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

local function onSort(x, y)
    if x and x.cpu and (QTip or not db.memory) then return x.cpu > y.cpu
    elseif x and x.mem then return x.mem > y.mem end
end

-- I forgot to include that check in first Release
-- sorry for messing up your tips ;D
local function isOwnTip(GameTipOrQTip)
    if GameTipOrQTip and GameTipOrQTip:IsVisible() then
        if QTip and QTip:IsAcquired(L.Q_NAME) then return true end
        local sig = _G.GameTooltipTextRight1:GetText() or ""
        if sig:find(L.N_TITLE) then return true end
    end
    return false
end

local function doItForAllorActiveMods(i, all, isTip, light)
    if light == true then
        if not all and moddata[i] or (all and IsAddOnLoaded(i)) then
            moddata[i]        = moddata[i] or {}
            moddata[i].name   = not newAddOn and moddata[i].name or GetAddOnInfo(i)
            moddata[i].oldcpu = scriptProfile and GetAddOnCPUUsage(i) or false
            moddata[i].oldmem = db.memory and GetAddOnMemoryUsage(i) or false
        end
        return
    end
    if not all and moddata[i] or (all and IsAddOnLoaded(i)) then
        local cpuused, cpudiff, memused, memdiff
        activeId          = activeId + 1
        moddata[i]        = moddata[i] or {}
        moddata[i].name   = not newAddOn and moddata[i].name or GetAddOnInfo(i)
        --if (QTip and scriptProfile) or not (QTip or db.memory) then
        if scriptProfile then
            cpuused  = GetAddOnCPUUsage(i)
            totalcpu = totalcpu + cpuused
        end
        if db.memory or db.memory_ldb then
            memused  = GetAddOnMemoryUsage(i)
            totalmem = totalmem + memused
        end
        if isTip then
            if db.memory then
                memdiff           = memused - (moddata[i].oldmem or memused)
                totalmemdiff      = totalmemdiff + memdiff
                moddata[i].oldmem = (db.tooltipthreshold <= 2) and memused or moddata[i].oldmem
            end
            --if (QTip and scriptProfile) or not (QTip or db.memory) then
            if scriptProfile then
                cpudiff           = cpuused - (moddata[i].oldcpu or cpuused)
                totaldiff         = totaldiff + cpudiff
                moddata[i].oldcpu = (db.tooltipthreshold <= 2) and cpuused or moddata[i].oldcpu
            end
            modsort[activeId]         = modsort[activeId] or {}
            modsort[activeId].add     = moddata[i].name
            modsort[activeId].cpu     = cpuused or false
            modsort[activeId].mem     = memused or false
            modsort[activeId].cpudiff = cpudiff or false
            modsort[activeId].memdiff = memdiff or false
        end
    end
end

local function onCollect(c)
    local isTip = c == true
    if isTip and QTip then
        -- if the tooltip threshold is default or low lighten the collect
        -- this gives the same results for less cpu work.
        if db.tooltipthreshold > 2 then
            if not newAddOn then
                for id, data in pairs(moddata) do
                    doItForAllorActiveMods(id, false, isTip, true)
                end
            else
                for i = 1, numTotalAddOns do
                    doItForAllorActiveMods(i, true, isTip, true)
                end
            end
        end
    end
    totalcpu, totaldiff, totalmem, totalmemdiff, activeId = 0, 0, 0, 0, 0
    if scriptProfile then UpdateAddOnCPUUsage() end
    if db.memory or db.memory_ldb then UpdateAddOnMemoryUsage() end
    if not newAddOn then
        for id, data in pairs(moddata) do
            doItForAllorActiveMods(id, false, isTip, nil)
        end
    else
        for i = 1, numTotalAddOns do
            doItForAllorActiveMods(i, true, isTip, nil)
        end
    end
    if activeId and activeId ~= (numActiveAddOns or 0) then first = true end
    numActiveAddOns  = activeId
    newAddOn         = false
    lastotalcpu      = totalcpu
    lastotalmem      = totalmem
    return lastotalcpu or 0, totaldiff or 0, lastotalmem or 0, totalmemdiff or 0
end

local function OnLeave(self)
    local self = self
    local GameTip = ldb.onupdate or nil
    if GameTip then
        if GameTip:GetScript("OnUpdate") then GameTip:SetScript("OnUpdate", nil) end
        ldb.onupdate = nil
    end
    if self and self.tooltip then
        if self.tooltip:GetScript("OnUpdate") then self.tooltip:SetScript("OnUpdate", nil) end
        if QTip then QTip:Release(self.tooltip) end
        self.tooltip = nil
        ldb.display = nil
    end
    if not ldb.OnLeave and not (scriptProfile and db.memory) then ldb.OnLeave = OnLeave end
    return
end


local function onDetachTooltip(tip)
    if not db.detach then
        tip:SmartAnchorTo(ldb.display)
        if not ldb.OnLeave then ldb.OnLeave = OnLeave end
        if tip:GetScript("OnMouseDown") then tip:SetScript("OnMouseDown", nil) end
        if tip:GetScript("OnMouseUp") then tip:SetScript("OnMouseUp", nil) end
    else
        if not db.detacheddata then
            db.detacheddata = {}
            db.detacheddata.pt = "CENTER"
            db.detacheddata.rpt = "CENTER"
            db.detacheddata.x, db.detacheddata.y = 0, 0
        end
        tip:ClearAllPoints()
        tip:SetFrameStrata("FULLSCREEN")
        tip:EnableMouse(true)
        tip:SetResizable(true)
        tip:SetFrameLevel(1)
        tip:SetMovable(true)
        tip:SetClampedToScreen(true)
        if not ( tip:GetScript("OnMouseDown") and tip:GetScript("OnMouseUp") ) then
            tip:SetScript("OnMouseDown", function() paused = true tip:StartMoving() end)
            tip:SetScript("OnMouseUp", function()
                tip:StopMovingOrSizing() --noinspection GlobalCreationOutsideO
                db.detacheddata.pt, _, db.detacheddata.rpt, db.detacheddata.x, db.detacheddata.y = tip:GetPoint() paused = false end)
        end
        ldb.OnLeave = nil
    end
    return
end

local function recycleQTip(qtip, col)
    local cols = #qtip.columns
    local num  = col - cols
    if num > 0 then
        for i = 1, num do
            qtip:AddColumn("LEFT")
        end
    else
        for i = 1 + ( cols + num ), cols do
            qtip.columns[i]:ClearAllPoints()
            qtip.columns[i]:Hide()
            qtip.columns[i] = nil
        end
    end
end

local function doesQTipShouldResize(qtip)
    local size  = #qtip.columns
    if scriptProfile and db.memory then
        if db.icons then
            if qtip.columns and size ~= 8 then return recycleQTip(qtip, 8) end
        else
            if qtip.columns and size ~= 6 then return recycleQTip(qtip, 6) end
        end
    elseif scriptProfile or db.memory then
        if db.icons then
            if qtip.columns and size ~= 6 then return recycleQTip(qtip, 6) end
        else
            if qtip.columns and size ~= 5 then return recycleQTip(qtip, 5) end
        end
    end
end

local function DoesTheTipExpandsTooMuch(qtip)
    local parenth = (_G.UIParent:GetHeight()) or 1
    local tiph = (qtip:GetHeight() * db.scale) or 0
    if tiph > parenth then
        D(("%s%s%s: %s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, L.EXPANDED))
        db.cpukill = 5
        first = true
        return true
    end
    return false
end

local function nSetCell(self, line, col, str, ...) -- used to lower the jobs sent to QTip, huge gain, it reduces its cpu usage / 20 for a slight more on BrokerCPU (x 0.01)
    if self.lines[line].cells[col] and self.lines[line].cells[col].fontString:GetText() == str then return end
    self:SetCell(line, col, str, ...)
end

local noicongarbage = function(self) self:SetBackdrop(nil) self:SetScript("OnHide", nil) end

local function onUpdateQTip(tip, elapsed)
    qtdelay = qtdelay + elapsed
    if not paused and ( qtdelay > tonumber(db.tooltipthreshold) ) or first then
        qtdelay = 0
        if not ( scriptProfile or db.memory ) or not isOwnTip(tip) then OnLeave(tip) return end
        local totcpu, totdiff, totmem, totmemdiff = onCollect(true)
        local kill = tonumber(db.cpukill) or 0
        table_sort(modsort, onSort)
        if first then
            -- To reduce QTip's CPU usages, anything executed in this if chain happens only once,
            -- they are stable and not variable datas so re-creating them to each loops increases
            -- a lot QTip cpu usages for nothing helpful.
            if tip.lines[1] then tip:Clear() end
            doesQTipShouldResize(tip) -- column recycling
            onDetachTooltip(tip)
            local tt
            for k in pairs(modsort) do
                tt = tip:AddLine(" ")
                if tt == kill then break end
            end
            tip:AddLine(" ")
            tt = tip:AddLine()
            tip:SetCell(tt, 1, stringRecycler(L.COLOR_GOLD..L.N_TOT..L.COLOR_STOP), nil, nil, 2)
            if db.memory then
                tt = tip:AddLine()
                tip:SetCell(tt, 1, stringRecycler(L.COLOR_GOLD..L.N_BLI..L.COLOR_STOP), nil, nil, 2)
            end
            if db.framerate or db.latency or db.upload or db.download then
                tip:AddLine(" ")
                if db.framerate then
                    tt = tip:AddLine()
                    tip:SetCell(tt, 1, stringRecycler(L.COLOR_GOLD..L.N_FPS..L.COLOR_STOP), nil, nil, 3)
                end
                if db.latency then
                    tt = tip:AddLine()
                    tip:SetCell(tt, 1, stringRecycler(L.COLOR_GOLD..L.N_LAT..L.COLOR_STOP), nil, nil, 3)
                end
                if db.upload then
                    tt = tip:AddLine()
                    tip:SetCell(tt, 1, stringRecycler(L.COLOR_GOLD..L.N_UP..L.COLOR_STOP), nil, nil, 3)
                end
                if db.download then
                    tt = tip:AddLine()
                    tip:SetCell(tt, 1, stringRecycler(L.COLOR_GOLD..L.N_DL..L.COLOR_STOP), nil, nil, 3)
                end
            end
        end
        -- auto-resizing to a decent number of addons for noobs like yess ;p
        if DoesTheTipExpandsTooMuch(tip) then return end
        first = false
        if db.scale and db.scale ~= tip:GetScale() then tip:SetScale(db.scale) end
        local tt = 0
        local col = 4
        for k, v in pairs(modsort) do
            tt = tt + 1
            if (v.cpudiff == 0 or (not v.cpudiff and v.memdiff == 0)) and v.add ~= "Broker_CPU" then
                nSetCell(tip, tt, 1, stringRecycler(L.COLOR_ADDON..tt..L.COLOR_STOP), nil, "LEFT", nil, nil, nil, nil, nil, 20)
                nSetCell(tip, tt, 2, stringRecycler(L.COLOR_ADDON..v.add..L.COLOR_STOP))
            elseif v.add ~= "Broker_CPU" then
                local r, g, b = colorGradient(((v.cpudiff and v.cpudiff or v.memdiff) * (1/10)) * (1/10), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                nSetCell(tip, tt, 1, ("|cff%02x%02x%02x%s"):format(r*255, g*255, b*255, tt), nil, "LEFT", nil, nil, nil, nil, nil, 20)
                nSetCell(tip, tt, 2, ("|cff%02x%02x%02x%s"):format(r*255, g*255, b*255, v.add))
            else
                nSetCell(tip, tt, 1, stringRecycler("|cff808080"..tt..L.COLOR_STOP), nil, "LEFT", nil, nil, nil, nil, nil, 20)
                nSetCell(tip, tt, 2, stringRecycler("|cff808080"..v.add..L.COLOR_STOP))
            end
            if scriptProfile then
                local r, g, b = colorGradient((v.cpudiff * (1/10)) * (1/10), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                if v.cpudiff == 0 then
                    nSetCell(tip, tt, 3, (db.dec_cpu > 0 and "%s%."..db.dec_cpu.."f%s" or "%s%d%s"):format(L.COLOR_CPU, not (v.cpu > 1000) and v.cpu or v.cpu * (1/1000) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.cpu > 1000 and "s" or "ms")..L.COLOR_STOP)), nil, "RIGHT", nil, nil, nil, nil, nil, 110)
                    nSetCell(tip, tt, 4, (db.dec_cpudiff > 0 and "%s%."..db.dec_cpudiff.."f%s" or "%s%d%s"):format(L.COLOR_CPU, v.cpudiff * (1/10), stringRecycler(" "..L.COLOR_SUFF.."%"..L.COLOR_STOP)), nil, "RIGHT", nil, nil, nil, nil, nil, db.dec_cpudiff == 2 and 70 or db.dec_cpudiff == 0 and 50 or db.dec_cpudiff == 1 and 60 or 80)
                else
                    nSetCell(tip, tt, 3, (db.dec_cpu > 0 and "|cff%02x%02x%02x%."..db.dec_cpu.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, not (v.cpu > 1000) and v.cpu or v.cpu * (1/1000) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.cpu > 1000 and "s" or "ms")..L.COLOR_STOP)), nil, "RIGHT", nil, nil, nil, nil, nil, 110)
                    nSetCell(tip, tt, 4, (db.dec_cpudiff > 0 and "|cff%02x%02x%02x%."..db.dec_cpudiff.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, v.cpudiff * (1/10), stringRecycler(" "..L.COLOR_SUFF.."%"..L.COLOR_STOP)), nil, "RIGHT", nil, nil, nil, nil, nil, db.dec_cpudiff == 2 and 70 or db.dec_cpudiff == 0 and 50 or db.dec_cpudiff == 1 and 60 or 80)
                end
                if db.icons then
                    nSetCell(tip, tt, 5, "", nil, nil, nil, nil, nil, nil, 16, 16)
                    tip.lines[tt].cells[5]:SetBackdrop((v.cpudiff == 0) and arrowc or (v.cpudiff > 0) and arrowa or (v.cpudiff < 0) and arrowb) -- bracket enclosure here was creating garbage, corrected
                    if not tip.lines[tt].cells[5]:GetScript("OnHide") then
                        tip.lines[tt].cells[5]:SetScript("OnHide", noicongarbage) -- function enclosure here was creating garbage, corrected
                    end
                    col = 6
                else
                    col = 5
                end
            end
            if db.memory then
                local r, g, b = colorGradient((v.memdiff * (1/10)) * (1/10), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                if v.memdiff == 0 then
                    nSetCell(tip, tt, col,   (db.dec_mem > 0 and "%s%."..db.dec_mem.."f%s" or "%s%d%s"):format(L.COLOR_MEM, v.mem < 1024 and v.mem or v.mem * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.mem < 1024 and kb or mb)..L.COLOR_STOP)), nil, "RIGHT", nil, nil, nil, nil, nil, 110)
                    nSetCell(tip, tt, col+1, (db.dec_memdiff > 0 and "%s%."..db.dec_memdiff.."f%s" or "%s%d%s"):format(L.COLOR_MEM, v.memdiff * (1/10), stringRecycler(" "..L.COLOR_SUFF.."%"..L.COLOR_STOP)), nil, "RIGHT", nil, nil, nil, nil, nil, db.dec_memdiff == 2 and 70 or db.dec_memdiff == 0 and 50 or db.dec_memdiff == 1 and 60 or 80)
                else
                    nSetCell(tip, tt, col,   (db.dec_mem > 0 and "|cff%02x%02x%02x%."..db.dec_mem.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, v.mem < 1024 and v.mem or v.mem * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.mem < 1024 and kb or mb)..L.COLOR_STOP)), nil, "RIGHT", nil, nil, nil, nil, nil, 110)
                    nSetCell(tip, tt, col+1, (db.dec_memdiff > 0 and "|cff%02x%02x%02x%."..db.dec_memdiff.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, v.memdiff * (1/10), stringRecycler(" "..L.COLOR_SUFF.."%"..L.COLOR_STOP)), nil, "RIGHT", nil, nil, nil, nil, nil, db.dec_memdiff == 2 and 70 or db.dec_memdiff == 0 and 50 or db.dec_memdiff == 1 and 60 or 80)
                end
                if db.icons then
                    nSetCell(tip, tt, col+2, "", nil, nil, nil, nil, nil, nil, 16, 16)
                    tip.lines[tt].cells[col+2]:SetBackdrop((v.memdiff == 0) and arrowc or (v.memdiff > 0) and arrowa or (v.memdiff < 0) and arrowb)
                    if not tip.lines[tt].cells[col+2]:GetScript("OnHide") then
                        tip.lines[tt].cells[col+2]:SetScript("OnHide", noicongarbage)
                    end
                end
            end
            if tt == kill then break end
        end
        tt = tt + 2
        if scriptProfile then
            local r, g, b = colorGradient((totdiff * (1/10)) * (1/20), 0, 1, 0, 1, 1, 0, 1, 0, 0)
            nSetCell(tip, tt, 3, (db.dec_cpu > 0 and "%s%."..db.dec_cpu.."f%s" or "%s%d%s"):format(L.COLOR_GOLD, not (totcpu > 1000) and totcpu or totcpu * (1/1000) or 0, stringRecycler(" "..L.COLOR_SUFF..(totcpu > 1000 and "s" or "ms")..L.COLOR_STOP)), nil, "RIGHT")
            nSetCell(tip, tt, 4, (db.dec_cpudiff > 0 and "|cff%02x%02x%02x%."..db.dec_cpudiff.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, totdiff * (1/10), stringRecycler(" "..L.COLOR_SUFF.."%"..L.COLOR_STOP)), nil, "RIGHT")
        end
        if db.memory then
            local totbli = collectgarbage("count")
            local r, g, b = colorGradient(totmem * (1/(120*1024)), 0, 1, 0, 1, 1, 0, 1, 0, 0)
            local r2, g2, b2 = colorGradient(totbli * (1/(140*1024)), 0, 1, 0, 1, 1, 0, 1, 0, 0)
            local r3, g3, b3 = colorGradient((totmemdiff * (1/10)) * (1/20), 0, 1, 0, 1, 1, 0, 1, 0, 0)
            nSetCell(tip, tt, col, (db.dec_mem > 0 and "|cff%02x%02x%02x%."..db.dec_mem.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, totmem < 1024 and totmem or totmem * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(totmem < 1024 and kb or mb)..L.COLOR_STOP)), nil, "RIGHT")
            nSetCell(tip, tt, col+1, (db.dec_memdiff > 0 and "|cff%02x%02x%02x%."..db.dec_memdiff.."f%s" or "|cff%02x%02x%02x%d%s"):format(r3*255, g3*255, b3*255, totmemdiff * (1/10), stringRecycler(" "..L.COLOR_SUFF.."%"..L.COLOR_STOP)), nil, "RIGHT")
            tt = tt + 1
            nSetCell(tip, tt, col, (db.dec_mem > 0 and "|cff%02x%02x%02x%."..db.dec_mem.."f%s" or "|cff%02x%02x%02x%d%s"):format(r2*255, g2*255, b2*255, totbli < 1024 and totbli or totbli * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(totbli < 1024 and kb or mb)..L.COLOR_STOP)), nil, "RIGHT")
        end
        if db.framerate or db.latency or db.upload or db.download then
            tt = tt + 1
            if db.framerate then
                local framerate = GetFramerate() or 0
                tt = tt + 1
                local r, g, b = colorGradient(framerate * (1/70), 1, 0, 0, 1, 1, 0, 0, 1, 0)
                nSetCell(tip, tt, db.memory and col + 1 or 4, (db.dec_fps > 0 and "|cff%02x%02x%02x%."..db.dec_fps.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, framerate, stringRecycler(" "..L.COLOR_SUFF..fps_..L.COLOR_STOP)), nil, "RIGHT")
            end
            if db.latency or db.upload or db.download then
                local dl, up, _, latency = GetNetStats()
                if db.latency then
                    tt            = tt + 1
                    lastlat       = type(latency) == "number" and latency or lastlat
                    local r, g, b = colorGradient(lastlat * (1/800), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                    nSetCell(tip, tt, db.memory and col + 1 or 4, (db.dec_lat > 0 and "|cff%02x%02x%02x%."..db.dec_lat.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, lastlat or 0, stringRecycler(" "..L.COLOR_SUFF.."ms"..L.COLOR_STOP)), nil, "RIGHT")
                end
                if db.upload then
                    tt            = tt + 1
                    lastup        = type(up) == "number" and up or lastup
                    local r, g, b = colorGradient(lastup * (1/5), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                    nSetCell(tip, tt, db.memory and col + 1 or 4, (db.dec_up > 0 and "|cff%02x%02x%02x%."..db.dec_up.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, lastup or 0, stringRecycler(" "..L.COLOR_SUFF..(lastup < 1024 and kbs or mbs)..L.COLOR_STOP)), nil, "RIGHT")
                end
                if db.download then
                    tt            = tt + 1
                    lastdl        = type(dl) == "number" and dl or lastdl
                    local r, g, b = colorGradient(lastdl * (1/20), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                    nSetCell(tip, tt, db.memory and col + 1 or 4, (db.dec_dl > 0 and "|cff%02x%02x%02x%."..db.dec_dl.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, lastdl or 0, stringRecycler(" "..L.COLOR_SUFF..(lastdl < 1024 and kbs or mbs)..L.COLOR_STOP)), nil, "RIGHT")
                end
            end
        end
        if db.detach then
            tip:ClearAllPoints()
            tip:SetPoint(db.detacheddata.pt, nil, db.detacheddata.rpt, db.detacheddata.x, db.detacheddata.y)
        end
    end
end

local function OnQTipShow(self)
    if ( self and self.tooltip ) or not QTip then return end -- secure check
    if not scriptProfile and not db.memory then
        local tip = QTip:Acquire(L.Q_NAME, 1)
        self.tooltip = tip
        local tt = tip:AddLine()
        tip:Show()
        tip:SetScale(1)
        tip:SetCell(tt, 1, L.TIPHINT1:format(L.COLOR_GOLD, L.LINE_STOP, L.COLOR_STOP))
        tt = tip:AddLine()
        tip:SetCell(tt, 1, L.TIPHINT2:format(L.COLOR_GOLD, L.LINE_STOP, L.COLOR_STOP))
        tt = tip:AddLine()
        tip:SetCell(tt, 1, L.TIPHINT3:format(L.COLOR_GOLD, L.LINE_STOP, L.COLOR_STOP))
        tip:AddLine(" ")
        tt = tip:AddLine()
        tip:SetCell(tt, 1, L.TIPHINT4:format(L.COLOR_HINT1, L.COLOR_STOP, L.COLOR_GREEN, L.LINE_STOP, L.COLOR_STOP))
        tt = tip:AddLine()
        tip:SetCell(tt, 1, L.TIPHINT5:format(L.COLOR_GREEN, L.COLOR_STOP, L.COLOR_HINT1, L.COLOR_STOP, L.COLOR_GREEN, L.COLOR_STOP))
        return tip:SmartAnchorTo(self)
    end
    -- Acquiring 4 columns the minimum required and then adding/deleting columns upon demands to avoid
    -- creating fantom cells and increasing QTip jobs
    local tip = QTip:Acquire(L.Q_NAME, 4)
    ldb.display = self
    self.tooltip = tip
    qtdelay = 0
    first = true
    tip:Show()
    tip:SetScript("OnUpdate", onUpdateQTip)
end

local function onLDBTextUpdate(reset)
    if reset == true then ldb.text = ""; return; end
    local totcpu, totmem = 0, 0
    if scriptProfile or db.memory_ldb then
        if not ((isOwnTip(ldb.display and ldb.display.tooltip) or isOwnTip(_G.GameTooltip)) and (scriptProfile or db.memory)) then
            totcpu, _, totmem = onCollect(false) -- lighten collect, don't set to true!
        else
            totcpu = lastotalcpu or 0
            totmem = lastotalmem or 0
        end
    end
    local fps, r, g, b
    larg1 = scriptProfile and (db.dec_cpu_ldb > 0 and "%s%."..db.dec_cpu_ldb.."f%s" or "%s%d%s"):format(L.COLOR_GOLD, not (totcpu > 1000) and totcpu or totcpu * (1/1000) or 0, stringRecycler(L.COLOR_SUFF..(totcpu > 1000 and "s" or "ms")..L.COLOR_STOP.." ")) or ""
    if db.memory_ldb then
        r, g, b = colorGradient(totmem * (1/(120*1024)), 0, 1, 0, 1, 1, 0, 1, 0, 0)
    end
    larg2 = db.memory_ldb and (db.dec_mem_ldb > 0 and "|cff%02x%02x%02x%."..db.dec_mem_ldb.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, totmem < 1024 and totmem or totmem * (1/1024) or 0, stringRecycler(L.COLOR_SUFF..(totmem < 1024 and kb or mb)..L.COLOR_STOP.." ")) or ""
    if db.framerate_ldb then
        fps = GetFramerate() or 0
        r, g, b = colorGradient(fps * (1/70), 1, 0, 0, 1, 1, 0, 0, 1, 0)
    end
    larg3 = db.framerate_ldb and (db.dec_fps_ldb > 0 and "|cff%02x%02x%02x%."..db.dec_fps_ldb.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, fps, stringRecycler(L.COLOR_SUFF..fps_..L.COLOR_STOP.." ")) or ""
    local dl, up, lat
    if db.latency_ldb or db.upload_ldb or db.download_ldb then
        dl, up, _, lat = GetNetStats()
    end
    if db.latency_ldb then
        lastlat = type(lat) == "number" and lat or lastlat
        r, g, b = colorGradient(lastlat * (1/800), 0, 1, 0, 1, 1, 0, 1, 0, 0)
    end
    larg4 = db.latency_ldb and (db.dec_lat_ldb > 0 and "|cff%02x%02x%02x%."..db.dec_lat_ldb.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, lastlat or 0, stringRecycler(L.COLOR_SUFF.."ms"..L.COLOR_STOP.." ")) or ""
    if db.upload_ldb then
        lastup  = type(up) == "number" and up or lastup
        r, g, b = colorGradient(lastup * (1/5), 0, 1, 0, 1, 1, 0, 1, 0, 0)
    end
    larg5 = db.upload_ldb and (db.dec_up_ldb > 0 and "|cff%02x%02x%02x%."..db.dec_up_ldb.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, lastup or 0, stringRecycler(L.COLOR_SUFF..(lastup < 1024 and kbs or mbs)..L.COLOR_STOP.." ")) or ""
    if db.download_ldb then
        lastdl  = type(dl) == "number" and dl or lastdl
        r, g, b = colorGradient(lastdl * (1/20), 0, 1, 0, 1, 1, 0, 1, 0, 0)
    end
    larg6 = db.download_ldb and (db.dec_dl_ldb > 0 and "|cff%02x%02x%02x%."..db.dec_dl_ldb.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, lastdl or 0, stringRecycler(L.COLOR_SUFF..(lastdl < 1024 and kbs or mbs)..L.COLOR_STOP)) or ""
    ldb.text = larg1..larg2..larg3..larg4..larg5..larg6
end

local function onGameTooltipShow(GameTip)
    if ldb.onupdate or not GameTip then return end -- secure check
    if not scriptProfile and not db.memory then
        GameTip:AddLine(L.TIPHINT1:format("", " ", ""), nil, nil, nil, 1)
        GameTip:AddLine(L.TIPHINT2:format("", " ", ""), nil, nil, nil, 1)
        GameTip:AddLine(L.TIPHINT3:format("", " ", ""), nil, nil, nil, 1)
        GameTip:AddLine(" ")
        GameTip:AddLine(L.TIPHINT4:format(L.COLOR_HINT1, L.COLOR_STOP, "", " ", ""), 0.2, 1, 0.2, 1)
        GameTip:AddLine(L.TIPHINT5:format("", "", L.COLOR_HINT1, L.COLOR_STOP, "", ""), 0.2, 1, 0.2, 1)
        GameTip:Show()
        return
    end
    GameTip:AddLine(" ")
    local delay = 0
    first       = true
    ldb.onupdate = CreateFrame("Frame")
    ldb.onupdate:SetScript("OnUpdate", function(_, elapsed)
        delay = delay + elapsed
        if ( delay > tonumber(db.tooltipthreshold) ) or first then
            delay = 0
            if not ( scriptProfile or db.memory ) or not ( isOwnTip(GameTip) or first ) then OnLeave() return end -- secure check
            first = false
            GameTip:ClearLines()
            GameTip:AddDoubleLine(" ", L.N_TITLE) -- secure check
            GameTip:AddDoubleLine(" ", db.memory and stringRecycler("["..L.N_MEM.."]") or "[CPU]")
            GameTip:AddLine(" ")
            local totcpu, _, totmem = onCollect(true)
            table_sort(modsort, onSort)
            for k, v in pairs(modsort) do
                if db.memory then
                    local r, g, b = colorGradient((v.memdiff * (1/10)) * (1/10), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                    if v.memdiff == 0 then
                        if v.add ~= "Broker_CPU" then
                            GameTip:AddDoubleLine(stringRecycler(k..". "..v.add), (db.dec_mem > 0 and "%s%."..db.dec_mem.."f%s" or "%s%d%s"):format(L.COLOR_MEM, v.mem < 1024 and v.mem or v.mem * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.mem < 1024 and kb or mb)..L.COLOR_STOP)), 0, 1, 1)
                        else
                            GameTip:AddDoubleLine(stringRecycler("|cff808080"..k..". "..v.add), (db.dec_mem > 0 and "%s%."..db.dec_mem.."f%s" or "%s%d%s"):format(L.COLOR_MEM, v.mem < 1024 and v.mem or v.mem * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.mem < 1024 and kb or mb)..L.COLOR_STOP)))
                        end
                    else
                        if v.add ~= "Broker_CPU" then
                            GameTip:AddDoubleLine(stringRecycler(k..". "..v.add), (db.dec_mem > 0 and "%."..db.dec_mem.."f%s" or "%d%s"):format(v.mem < 1024 and v.mem or v.mem * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.mem < 1024 and kb or mb)..L.COLOR_STOP)), r, g, b, r, g, b)
                        else
                            GameTip:AddDoubleLine(stringRecycler("|cff808080"..k..". "..v.add), (db.dec_mem > 0 and "%."..db.dec_mem.."f%s" or "%d%s"):format(v.mem < 1024 and v.mem or v.mem * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.mem < 1024 and kb or mb)..L.COLOR_STOP)), nil, nil, nil, r, g, b)
                        end
                    end
                elseif scriptProfile then
                    local r, g, b = colorGradient((v.cpudiff * (1/10)) * (1/10), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                    if v.cpudiff == 0 then
                        if v.add ~= "Broker_CPU" then
                            GameTip:AddDoubleLine(stringRecycler(k..". "..v.add), (db.dec_cpu > 0 and "%s%."..db.dec_cpu.."f%s" or "%s%d%s"):format(L.COLOR_CPU, not (v.cpu > 1000) and v.cpu or v.cpu * (1/1000) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.cpu > 1000 and "s" or "ms")..L.COLOR_STOP)), 0, 1, 1)
                        else
                            GameTip:AddDoubleLine(stringRecycler("|cff808080"..k..". "..v.add), (db.dec_cpu > 0 and "%s%."..db.dec_cpu.."f%s" or "%s%d%s"):format(L.COLOR_CPU, not (v.cpu > 1000) and v.cpu or v.cpu * (1/1000) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.cpu > 1000 and "s" or "ms")..L.COLOR_STOP)))
                        end
                    else
                        if v.add ~= "Broker_CPU" then
                            GameTip:AddDoubleLine(stringRecycler(k..". "..v.add), (db.dec_cpu > 0 and "%."..db.dec_cpu.."f%s" or "%d%s"):format(not (v.cpu > 1000) and v.cpu or v.cpu * (1/1000) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.cpu > 1000 and "s" or "ms")..L.COLOR_STOP)), r, g, b, r, g, b)
                        else
                            GameTip:AddDoubleLine(stringRecycler("|cff808080"..k..". "..v.add), (db.dec_cpu > 0 and "%."..db.dec_cpu.."f%s" or "%d%s"):format(not (v.cpu > 1000) and v.cpu or v.cpu * (1/1000) or 0, stringRecycler(" "..L.COLOR_SUFF..(v.cpu > 1000 and "s" or "ms")..L.COLOR_STOP)), nil, nil, nil, r, g, b)
                        end
                    end
                end
                if k == db.cpukill then break end
            end
            if db.memory then
                local r, g, b  = colorGradient(totmem * (1/(120*1024)), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                GameTip:AddLine(" ")
                GameTip:AddDoubleLine(stringRecycler(L.COLOR_GOLD..L.N_TOT..L.COLOR_STOP), (db.dec_mem > 0 and "|cff%02x%02x%02x%."..db.dec_mem.."f%s" or "|cff%02x%02x%02x%d%s"):format(r*255, g*255, b*255, totmem < 1024 and totmem or totmem * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(totmem < 1024 and kb or mb)..L.COLOR_STOP)), 1, 1, 1, 1, 1, 1)
            elseif scriptProfile then
                GameTip:AddLine(" ")
                GameTip:AddDoubleLine(stringRecycler(L.COLOR_GOLD..L.N_TOT..L.COLOR_STOP), (db.dec_cpu > 0 and "%s%."..db.dec_cpu.."f%s" or "%s%d%s"):format(L.COLOR_GOLD, not (totcpu > 1000) and totcpu or totcpu * (1/1000) or 0, stringRecycler(" "..L.COLOR_SUFF..(totcpu > 1000 and "s" or "ms")..L.COLOR_STOP)), 1, 1, 1, 1, 1, 1)
            end
            if db.memory then
                local totbli      = collectgarbage("count")
                local r, g, b     = colorGradient(totbli * (1/(70*1024)), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                GameTip:AddDoubleLine(stringRecycler(L.COLOR_GOLD..L.N_BLI..L.COLOR_STOP), (db.dec_mem > 0 and "%."..db.dec_mem.."f%s" or "%d%s"):format(totbli < 1024 and totbli or totbli * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(totbli < 1024 and kb or mb)..L.COLOR_STOP)), nil, nil, nil, r, g, b)
            end
            if db.framerate or db.latency or db.upload or db.download then
                GameTip:AddLine(" ")
                if db.framerate then
                    local fps     = GetFramerate() or 0
                    local r, g, b = colorGradient(fps * (1/70), 1, 0, 0, 1, 1, 0, 0, 1, 0)
                    GameTip:AddDoubleLine(stringRecycler(L.COLOR_GOLD..L.N_FPS..L.COLOR_STOP), (db.dec_fps > 0 and "%."..db.dec_fps.."f%s" or "%d%s"):format(fps, stringRecycler(" "..L.COLOR_SUFF..fps_..L.COLOR_STOP)), nil, nil, nil, r, g, b)
                end
                if db.latency or db.upload or db.download then
                    local dl, up, _, latency = GetNetStats()
                    if db.latency then
                        lastlat       = type(latency) == "number" and latency or lastlat
                        local r, g, b = colorGradient(lastlat * (1/800), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                        GameTip:AddDoubleLine(stringRecycler(L.COLOR_GOLD..L.N_LAT..L.COLOR_STOP), (db.dec_lat > 0 and "%."..db.dec_lat.."f%s" or "%d%s"):format(lastlat or 0, stringRecycler(" "..L.COLOR_SUFF.."ms"..L.COLOR_STOP)), nil, nil, nil, r, g, b)
                    end
                    if db.upload then
                        lastup        = type(up) == "number" and up or lastup
                        local r, g, b = colorGradient(lastup * (1/5), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                        GameTip:AddDoubleLine(stringRecycler(L.COLOR_GOLD..L.N_UP..L.COLOR_STOP), (db.dec_up > 0 and "%."..db.dec_up.."f%s" or "%d%s"):format(lastup or 0, stringRecycler(" "..L.COLOR_SUFF..(lastup < 1024 and kbs or mbs)..L.COLOR_STOP)), nil, nil, nil, r, g, b)
                    end
                    if db.download then
                        lastdl        = type(dl) == "number" and dl or lastdl
                        local r, g, b = colorGradient(lastdl * (1/20), 0, 1, 0, 1, 1, 0, 1, 0, 0)
                        GameTip:AddDoubleLine(stringRecycler(L.COLOR_GOLD..L.N_DL..L.COLOR_STOP), (db.dec_dl > 0 and "%."..db.dec_dl.."f%s" or "%d%s"):format(lastdl or 0, stringRecycler(" "..L.COLOR_SUFF..(lastdl < 1024 and kbs or mbs)..L.COLOR_STOP)), nil, nil, nil, r, g, b)
                    end
                end
            end
            GameTip:Show()
        end
    end)
end

local function onToggleLDBText()
    if ldb.onupdate_b then ldb.onupdate_b:SetScript("OnUpdate", nil) end
    ldb.onupdate_b = CreateFrame("Frame")
    if scriptProfile or db.memory_ldb or db.latency_ldb or db.framerate_ldb then
        local first, delay = true, 0
        ldb.onupdate_b:SetScript("OnUpdate", function(_, elapsed)
            delay = delay + elapsed
            if delay > tonumber(db.ldbtextthreshold) or ( delay > 3 and first ) then
                delay, first = 0, false
                onLDBTextUpdate(nil)
            end
        end)
    else
        if ldb.onupdate_b:GetScript("OnUpdate") then ldb.onupdate_b:SetScript("OnUpdate", nil) end
        ldb.onupdate_b = nil
        onLDBTextUpdate(true)
    end
end

local statusindex
local function onCheckStatus(c)
    statusindex = statusindex or {
        cpukill           = "[%s%d%s]",
        dec_cpu           = "[%s%d%s]",
        dec_cpu_ldb       = "[%s%d%s]",
        dec_cpudiff       = "[%s%d%s]",
        dec_dl            = "[%s%d%s]",
        dec_dl_ldb        = "[%s%d%s]",
        dec_fps           = "[%s%d%s]",
        dec_fps_ldb       = "[%s%d%s]",
        dec_lat           = "[%s%d%s]",
        dec_lat_ldb       = "[%s%d%s]",
        dec_mem           = "[%s%d%s]",
        dec_mem_ldb       = "[%s%d%s]",
        dec_memdiff       = "[%s%d%s]",
        dec_up            = "[%s%d%s]",
        dec_up_ldb        = "[%s%d%s]",
        ldbtextthreshold  = "[%s%d%s]",
        scale             = "[%s%.2f%s]",
        tooltipthreshold  = "[%s%.1f%s]",
    }
    return (statusindex[c] and statusindex[c] or (db[c] and "[%sON%s]" or "[%sOFF%s]")):format(statusindex[c] and L.COLOR_GREEN or (db[c] and L.COLOR_GREEN or L.COLOR_RED), statusindex[c] and db[c] or L.COLOR_STOP, L.COLOR_STOP)
end

local function onToggleMemory(c)
    local isInit = c == true
    if not isInit then
        first     = true
        db.memory = not db.memory
    else
        db.memory_ldb = not db.memory_ldb
    end
    onToggleLDBText()
    D(("%s%s%s: %s %s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, not isInit and onCheckStatus("memory") or onCheckStatus("memory_ldb"), ("%s %s"):format(L.N_MEM, not isInit and L.N_THR_TIP or L.N_THR_LDB)))
end

local function onToggleMinimap(c)
    local isInit = c == true
    if not isInit then db.minimap = not db.minimap end
    if db.minimap then
        minimap = LibStub("LibDBIcon-1.0", true) or nil
        if minimap then
            db.minimapdata            = db.minimapdata or {}
            db.minimapdata.minimapPos = db.minimapdata.minimapPos or random(0, 360)
            if not minimap:IsRegistered(L.N_TITLE) then minimap:Register(L.N_TITLE, ldb, db.minimapdata) end
            minimap:Show(L.N_TITLE)
        else return not isInit and D(("%s%s%s: %s%s %s%s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, L.COLOR_GREY, L.N_L_ICO, L.NOT_DBICO, L.COLOR_STOP)) or nil end
    else
        if minimap and minimap:IsRegistered(L.N_TITLE) then minimap:Hide(L.N_TITLE) end
        minimap = nil
    end
    return not isInit and D(("%s%s%s: %s %s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, onCheckStatus("minimap"), L.N_L_ICO)) or nil
end

local function onToggleQTip(c)
    local isInit = c == true
    if not isInit then
        db.qtip = not db.qtip
        first = true
    end
    if db.qtip then
        QTip = LibStub("LibQTip-1.0", true) or nil
        if QTip then
            local GameTip = _G.GameTooltip
            if GameTip and GameTip:IsVisible() then
                if isOwnTip(GameTip) then GameTip:Hide(); OnLeave(); end
            end
            ldb.OnEnter = OnQTipShow
            ldb.OnTooltipShow = nil
        else
            ldb.OnEnter = nil
            ldb.OnTooltipShow = onGameTooltipShow
            return not isInit and D(("%s%s%s: %s%s %s%s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, L.COLOR_GREY, L.N_L_QTIP, L.NOT_QTIP, L.COLOR_STOP)) or nil
        end
    else
        if ldb and ldb.display then OnLeave(ldb.display) end
        QTip = nil
        ldb.OnEnter = nil
        ldb.OnTooltipShow = onGameTooltipShow
    end
    return not isInit and D(("%s%s%s: %s %s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, onCheckStatus("qtip"), L.N_L_QTIP)) or nil
end

local function onSetMaxAddOns(c)
    first      = true
    db.cpukill = c
    D(("%s%s%s: %s %s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, onCheckStatus("cpukill"), L.N_MOD))
end

local function onSetScale(c)
    db.scale = c
    D(("%s%s%s: %s %s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, onCheckStatus("scale"), L.N_SC))
end

local function onToggleIcons()
    first             = true
    db.icons          = not db.icons
    local missingQtip = db.icons and not QTip
    D(("%s%s%s: %s %s %s%s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, missingQtip and L.COLOR_GREY or onCheckStatus("icons"), L.N_ICO, missingQtip and L.NOT_QTIP or "", missingQtip and L.COLOR_STOP or ""))
end

local decimalindex
local function onSetDecimals(c, d)
    first          = true
    decimalindex   = decimalindex or {
        [1]  = { "dec_cpu",     L.N_DEC_CPU },
        [2]  = { "dec_cpudiff", L.N_DEC_CPU2 },
        [3]  = { "dec_mem",     L.N_DEC_MEM },
        [4]  = { "dec_memdiff", L.N_DEC_MEM2 },
        [5]  = { "dec_fps",     L.N_DEC_FPS },
        [6]  = { "dec_lat",     L.N_DEC_LAT },
        [7]  = { "dec_up",      L.N_DEC_UP },
        [8]  = { "dec_dl",      L.N_DEC_DL },
        [9]  = { "dec_cpu_ldb", L.N_DEC_CPU },
        [10] = { "dec_mem_ldb", L.N_DEC_MEM },
        [11] = { "dec_fps_ldb", L.N_DEC_FPS },
        [12] = { "dec_lat_ldb", L.N_DEC_LAT },
        [13] = { "dec_up_ldb",  L.N_DEC_UP },
        [14] = { "dec_dl_ldb",  L.N_DEC_DL },
    }
    db[decimalindex[c][1]] = d
    D(("%s%s%s: %s %s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, onCheckStatus(decimalindex[c][1]), decimalindex[c][2]))
end

local function onToggleNetwork(c, d)
    local isLDB  = c == true
    local isUP   = d == true
    first        = true
    if isUP then
        if isLDB then
            db.upload_ldb = not db.upload_ldb
        else
            db.upload     = not db.upload
        end
    else
        if isLDB then
            db.download_ldb = not db.download_ldb
        else
            db.download     = not db.download
        end
    end
    onToggleLDBText()
    D(("%s%s%s: %s %s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, isUP and (isLDB and onCheckStatus("upload_ldb") or onCheckStatus("upload")) or isLDB and onCheckStatus("download_ldb") or onCheckStatus("download"), ("%s %s"):format(isUP and L.N_UP or L.N_DL, isLDB and L.N_THR_LDB or L.N_THR_TIP)))
end

local function onCollectGarbage()
    local current = collectgarbage("count")
    collectgarbage("collect")
    UpdateAddOnMemoryUsage()
    local garbage = current - collectgarbage("count")
    local r, g, b = colorGradient(garbage * (1/(2*1024)), 0, 1, 0, 1, 1, 0, 1, 0, 0)
    D((db.dec_mem > 0 and "%s%s%s: %s collected (|cff%02x%02x%02x%."..db.dec_mem.."f%s)" or "%s%s%s: %s collected (|cff%02x%02x%02x%d%s)"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, L.N_GAR, r*255, g*255, b*255, garbage < 1024 and garbage or garbage * (1/1024) or 0, stringRecycler(" "..L.COLOR_SUFF..(garbage < 1024 and kb or mb)..L.COLOR_STOP)))
end

local function initSlashes()
    return {
        Dcpu     = { 01, "dec_cpu",          function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(1, c);  return true; end, L.TOGGLE_D_CPU },
        Dcpu2    = { 02, "dec_cpu_ldb",      function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(9, c);  return true; end, L.TOGGLE_D_CPU },
        Dcpudiff = { 03, "dec_cpudiff",      function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(2, c);  return true; end, L.TOGGLE_D_CPU2 },
        Ddl      = { 04, "dec_dl",           function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(8, c);  return true; end, L.TOGGLE_D_DL },
        Ddl2     = { 05, "dec_dl_ldb",       function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(14, c); return true; end, L.TOGGLE_D_DL },
        Dfps     = { 06, "dec_fps",          function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(5, c);  return true; end, L.TOGGLE_D_FPS },
        Dfps2    = { 07, "dec_fps_ldb",      function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(11, c); return true; end, L.TOGGLE_D_FPS },
        Dlat     = { 08, "dec_lat",          function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(6, c);  return true; end, L.TOGGLE_D_LAT },
        Dlat2    = { 09, "dec_lat_ldb",      function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(12, c); return true; end, L.TOGGLE_D_LAT },
        Dmem     = { 10, "dec_mem",          function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(3, c);  return true; end, L.TOGGLE_D_MEM },
        Dmem2    = { 11, "dec_mem_ldb",      function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(10, c); return true; end, L.TOGGLE_D_MEM },
        Dmemdiff = { 12, "dec_memdiff",      function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(4, c);  return true; end, L.TOGGLE_D_MEM2 },
        Dup      = { 13, "dec_up",           function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(7, c);  return true; end, L.TOGGLE_D_UP },
        Dup2     = { 14, "dec_up_ldb",       function(c) if type(c) ~= "number" or (c < 0 or c > MAXD) then return false; end; onSetDecimals(13, c); return true; end, L.TOGGLE_D_UP },
        Tldb     = { 15, "ldbtextthreshold", function(c) if type(c) ~= "number" then return false end; db.ldbtextthreshold = c; return true; end,                      L.TOGGLE_LDB },
        Ttip     = { 16, "tooltipthreshold", function(c) if type(c) ~= "number" then return false end; db.tooltipthreshold = c; return true; end,                      L.TOGGLE_TIP },
        dl       = { 18, "download",         function() onToggleNetwork(nil, nil); return true; end,                                                                   L.TOGGLE_DL, L.N_THR_TIP, true },
        dl2      = { 19, "download_ldb",     function() onToggleNetwork(true, nil); return true; end,                                                                  L.TOGGLE_DL, L.N_THR_LDB, true },
        fps      = { 20, "framerate",        function() first = true; db.framerate = not db.framerate; return true; end,                                               L.TOGGLE_FPS, L.N_THR_TIP, true },
        fps2     = { 21, "framerate_ldb",    function() db.framerate_ldb = not db.framerate_ldb; onToggleLDBText(); return true; end,                                  L.TOGGLE_FPS, L.N_THR_LDB, true },
        garb     = { 22, nil,                function() onCollectGarbage(); return true; end,                                                                          L.TOGGLE_GAR },
        hide     = { 23, nil,                function() if db.detach and ( ldb and ldb.display ) then OnLeave(ldb.display) end; return true; end,                      L.TOGGLE_HID },
        ico      = { 24, "icons",            function() onToggleIcons(); return true; end,                                                                             L.TOGGLE_ICO, L.NOT_QTIP },
        kill     = { 25, "cpukill",          function(c) if type(c) ~= "number" then return false end; onSetMaxAddOns(c); return true; end,                            L.TOGGLE_KLL },
        lat      = { 26, "latency",          function() first = true; db.latency = not db.latency; return true; end,                                                   L.TOGGLE_LAT, L.N_THR_TIP, true },
        lat2     = { 27, "latency_ldb",      function() db.latency_ldb = not db.latency_ldb; onToggleLDBText(); return true; end,                                      L.TOGGLE_LAT, L.N_THR_LDB, true },
        mem      = { 28, "memory",           function() onToggleMemory(nil); return true; end,                                                                         L.TOGGLE_MEM, L.N_THR_TIP, true },
        mem2     = { 29, "memory_ldb",       function() onToggleMemory(true); return true; end,                                                                        L.TOGGLE_MEM, L.N_THR_LDB, true },
        mini     = { 30, "minimap",          function() onToggleMinimap(); return true; end,                                                                           L.TOGGLE_L_ICO, L.NOT_DBICO },
        prof     = { 31, scriptProfile,      function() if scriptProfile then SetCVar("scriptProfile", 0) else SetCVar("scriptProfile", 1) end; ReloadUI(); end,       L.TOGGLE_CPU },
        qtip     = { 32, "qtip",             function() onToggleQTip(nil); return true; end,                                                                           L.TOGGLE_L_QTIP },
        reset    = { 33, nil,                function() BROKERCPUDB = nil; SetCVar("scriptProfile", 0); ReloadUI(); return true; end,                                  L.TOGGLE_RST },
        scale    = { 34, "scale",            function(c) if type(c) ~= "number" then return false end; onSetScale(c); return true; end,                                L.TOGGLE_SC, L.NOT_QTIP },
        up       = { 35, "upload",           function() onToggleNetwork(nil, true); return true; end,                                                                  L.TOGGLE_UP, L.N_THR_TIP, true },
        up2      = { 36, "upload_ldb",       function() onToggleNetwork(true, true); return true; end,                                                                 L.TOGGLE_UP, L.N_THR_LDB, true },
        rescpu   = { 37, nil,                function() brokercpu_orig_ResetCPUUsage(); return true; end,                                                              L.TOGGLE_RESCPU },
        detach   = { 17, "detach",           function()
                db.detach = not db.detach
                first = true
                if db.detach and not QTip then
                    D(("%s%s%s: %s%s %s%s"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP, L.COLOR_GREY, L.N_DET, L.NOT_QTIP, L.COLOR_STOP))
                end
                return true
            end, L.TOGGLE_DET, L.NOT_QTIP }
    }
end

local slashsort = {}
local function onSlash(c)
    slashes              = slashes or initSlashes()
    local key, _, option = c:match("^(%a+%d?)(%s?(.*))")
    local reply          = slashes[key] and slashes[key][3](tonumber(option)) or nil
    if not reply then -- print usage
        D(("%s%s%s:"):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP))
        for option, data in pairs(slashes) do
            slashsort[data[1]] = option
        end
        table_sort(slashsort)
        for _, key in pairs(slashsort) do
            local data   = slashes[key]
            D(type(data[2]) == "string" and onCheckStatus(data[2]) or "", ("%s%s/cpu %s%s%s|cffa0a0a0%s %s"):format(data[2] and L.SLASH_SEP or "", L.COLOR_GOLD, key, L.COLOR_STOP, L.SLASH_SEP, data[6] and data[4]:format(data[5]) or data[4], (data[5] and not data[6]) and data[5] or ""))
        end
    end
end

local function onClick(self, button)
    if button == "LeftButton" then
        if IsControlKeyDown() and IsAltKeyDown() then
            if scriptProfile then SetCVar("scriptProfile", 0)
            else SetCVar("scriptProfile", 1) end
            return ReloadUI()
        elseif IsShiftKeyDown() then
            if db.detach and ( ldb and ldb.display ) then
                OnLeave(ldb.display)
            end
            return
        else
            return onCollectGarbage()
        end
    end
    if button == "RightButton" then
        slashes    = slashes or initSlashes()
        uidropdown = uidropdown or {
            -- Header
            { text = ("%s r|cff7fff7f%s|r by |cff69ccf0Merax|r"):format(L.N_TITLE, MINOR_VERSION), justifyH = "CENTER", isTitle = true, notCheckable = true, keepShownOnClick = true },
            { text = L.COLOR_GOLD.."@ La Croisade Écarlate FR", justifyH = "CENTER", isTitle = true, notCheckable = true, keepShownOnClick = true },
            -- Separator
            { text = L.COLOR_GOLD.."--------------------|r", justifyH = "CENTER", notCheckable = true, notClickable = true, isTitle = true, keepShownOnClick = true },
            -- Cpukill
            { text = L.N_MOD, hasArrow = true, tooltipTitle = L.N_MOD, tooltipText = L.TOGGLE_KLL, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                menuList = {
                    { text = "10", notCheckable = true, keepShownOnClick = true, func = function() slashes.kill[3](10) end },
                    { text = "30", notCheckable = true, keepShownOnClick = true, func = function() slashes.kill[3](30) end },
                    { text = "50", notCheckable = true, keepShownOnClick = true, func = function() slashes.kill[3](50) end }
                }
            },
            -- Decimals
            { text = L.N_DEC, hasArrow = true, notCheckable = true, keepShownOnClick = true,
                menuList = {
                    { text = L.N_THR_TIP, hasArrow = true, notCheckable = true, keepShownOnClick = true,
                        menuList = {
                            { text = L.N_DEC_CPU, hasArrow = true, tooltipTitle = L.N_DEC_CPU, tooltipText = L.TOGGLE_D_CPU, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpu[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpu[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpu[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpu[3](3) end }
                                }
                            },
                            { text = L.N_DEC_CPU2, hasArrow = true, tooltipTitle = L.N_DEC_CPU2, tooltipText = L.TOGGLE_D_CPU2, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpudiff[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpudiff[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpudiff[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpudiff[3](3) end }
                                }
                            },
                            { text = L.N_DEC_MEM, hasArrow = true, tooltipTitle = L.N_DEC_MEM, tooltipText = L.TOGGLE_D_MEM, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmem[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmem[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmem[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmem[3](3) end }
                                }
                            },
                            { text = L.N_DEC_MEM2, hasArrow = true, tooltipTitle = L.N_DEC_MEM2, tooltipText = L.TOGGLE_D_MEM2, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmemdiff[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmemdiff[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmemdiff[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmemdiff[3](3) end }
                                }
                            },
                            { text = L.N_FPS, hasArrow = true, tooltipTitle = L.N_FPS, tooltipText = L.TOGGLE_D_FPS, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dfps[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dfps[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dfps[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dfps[3](3) end }
                                }
                            },
                            { text = L.N_LAT, hasArrow = true, tooltipTitle = L.N_LAT, tooltipText = L.TOGGLE_D_LAT, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dlat[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dlat[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dlat[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dlat[3](3) end }
                                }
                            },
                            { text = L.N_UP, hasArrow = true, tooltipTitle = L.N_UP, tooltipText = L.TOGGLE_D_UP, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dup[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dup[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dup[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dup[3](3) end }
                                }
                            },
                            { text = L.N_DL, hasArrow = true, tooltipTitle = L.N_DL, tooltipText = L.TOGGLE_D_DL, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ddl[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ddl[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ddl[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ddl[3](3) end }
                                }
                            }
                        }
                    },
                    { text = L.N_THR_LDB, hasArrow = true, notCheckable = true, keepShownOnClick = true,
                        menuList = {
                            { text = L.N_DEC_CPU, hasArrow = true, tooltipTitle = L.N_DEC_CPU, tooltipText = L.TOGGLE_D_CPU, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpu2[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpu2[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpu2[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dcpu2[3](3) end }
                                }
                            },
                            { text = L.N_DEC_MEM, hasArrow = true, tooltipTitle = L.N_DEC_MEM, tooltipText = L.TOGGLE_D_MEM, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmem2[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmem2[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmem2[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dmem2[3](3) end }
                                }
                            },
                            { text = L.N_FPS, hasArrow = true, tooltipTitle = L.N_FPS, tooltipText = L.TOGGLE_D_FPS, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dfps2[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dfps2[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dfps2[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dfps2[3](3) end }
                                }
                            },
                            { text = L.N_LAT, hasArrow = true, tooltipTitle = L.N_LAT, tooltipText = L.TOGGLE_D_LAT, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dlat2[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dlat2[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dlat2[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dlat2[3](3) end }
                                }
                            },
                            { text = L.N_UP, hasArrow = true, tooltipTitle = L.N_UP, tooltipText = L.TOGGLE_D_UP, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dup2[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dup2[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dup2[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Dup2[3](3) end }
                                }
                            },
                            { text = L.N_DL, hasArrow = true, tooltipTitle = L.N_DL, tooltipText = L.TOGGLE_D_DL, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                                menuList = {
                                    { text = "0", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ddl2[3](0) end },
                                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ddl2[3](1) end },
                                    { text = "2", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ddl2[3](2) end },
                                    { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ddl2[3](3) end }
                                }
                            }
                        }
                    }
                }
            },
            -- Libraries
            { text = L.N_LIB, hasArrow = true, notCheckable = true, keepShownOnClick = true,
                menuList = {
                    { text = L.N_L_QTIP, tooltipTitle = L.N_L_QTIP, tooltipText = L.TOGGLE_L_QTIP, notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.qtip[3], checked = function() return db.qtip end },
                    { text = L.N_L_ICO, tooltipTitle = L.N_L_ICO, tooltipText = ("%s %s"):format(L.TOGGLE_L_ICO, L.NOT_DBICO), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.mini[3], checked = function() return db.minimap end }
                }
            },
            -- Broker
            { text = L.N_DAT_SHOW:format(L.N_THR_LDB), hasArrow = true, notCheckable = true, keepShownOnClick = true,
                menuList = {
                    { text = L.N_MEM, tooltipTitle = L.N_MEM, tooltipText = L.TOGGLE_MEM:format(L.N_THR_LDB), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.mem2[3], checked = function() return db.memory_ldb end },
                    { text = L.N_FPS, tooltipTitle = L.N_FPS, tooltipText = L.TOGGLE_FPS:format(L.N_THR_LDB), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.fps2[3], checked = function() return db.framerate_ldb end },
                    { text = L.N_LAT, tooltipTitle = L.N_LAT, tooltipText = L.TOGGLE_LAT:format(L.N_THR_LDB), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.lat2[3], checked = function() return db.latency_ldb end },
                    { text = L.N_UP, tooltipTitle = L.N_UP, tooltipText = L.TOGGLE_UP:format(L.N_THR_LDB), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.up2[3], checked = function() return db.upload_ldb end },
                    { text = L.N_DL, tooltipTitle = L.N_DL, tooltipText = L.TOGGLE_DL:format(L.N_THR_LDB), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.dl2[3], checked = function() return db.download_ldb end }
                }
            },
            -- Tooltips
            { text = L.N_DAT_SHOW:format(L.N_THR_TIP), hasArrow = true, notCheckable = true, keepShownOnClick = true,
                menuList = {
                    { text = L.N_MEM, tooltipTitle = L.N_MEM, tooltipText = L.TOGGLE_MEM:format(L.N_THR_TIP), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.mem[3], checked = function() return db.memory end },
                    { text = L.N_FPS, tooltipTitle = L.N_FPS, tooltipText = L.TOGGLE_FPS:format(L.N_THR_TIP), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.fps[3], checked = function() return db.framerate end },
                    { text = L.N_LAT, tooltipTitle = L.N_LAT, tooltipText = L.TOGGLE_LAT:format(L.N_THR_TIP), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.lat[3], checked = function() return db.latency end },
                    { text = L.N_UP, tooltipTitle = L.N_UP, tooltipText = L.TOGGLE_UP:format(L.N_THR_TIP), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.up[3], checked = function() return db.upload end },
                    { text = L.N_DL, tooltipTitle = L.N_DL, tooltipText = L.TOGGLE_DL:format(L.N_THR_TIP), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
                      func = slashes.dl[3], checked = function() return db.download end }
                }
            },
            -- Scale
            { text = L.N_SC, hasArrow = true, tooltipTitle = L.N_SC, tooltipText = ("%s %s"):format(L.TOGGLE_SC, L.NOT_QTIP), notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                menuList = {
                    { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.scale[3](1) end },
                    { text = "0.9", notCheckable = true, keepShownOnClick = true, func = function() slashes.scale[3](0.9) end },
                    { text = "0.8", notCheckable = true, keepShownOnClick = true, func = function() slashes.scale[3](0.8) end }
                }
            },
            -- Thresholds
            { text = L.N_THR, hasArrow = true, notCheckable = true, keepShownOnClick = true,
                menuList = {
                    { text = L.N_THR_LDB, hasArrow = true, tooltipTitle = L.N_THR_LDB, tooltipText = L.TOGGLE_LDB, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                        menuList = {
                            { text = "10", notCheckable = true, keepShownOnClick = true, func = function() slashes.Tldb[3](10) end },
                            { text = "5", notCheckable = true, keepShownOnClick = true, func = function() slashes.Tldb[3](5) end },
                            { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Tldb[3](3) end }
                        }
                    },
                    { text = L.N_THR_TIP, hasArrow = true, tooltipTitle = L.N_THR_TIP, tooltipText = L.TOGGLE_TIP, notCheckable = true, keepShownOnClick = true, tooltipOnButton = 1,
                        menuList = {
                            { text = "1", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ttip[3](1) end },
                            { text = "3", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ttip[3](3) end },
                            { text = "5", notCheckable = true, keepShownOnClick = true, func = function() slashes.Ttip[3](5) end }
                        }
                    }
                }
            },
            -- Separator
            { text = L.COLOR_GOLD.."--------------------|r", justifyH = "CENTER", notCheckable = true, notClickable = true, keepShownOnClick = true },
            -- Garbage
            { text = L.N_GAR, tooltipTitle = L.N_GAR, tooltipText = L.TOGGLE_GAR, notCheckable = true, func = slashes.garb[3], keepShownOnClick = true }, tooltipOnButton = 1,
            -- Reset cpu
            { text = L.N_RESCPU, tooltipTitle = L.N_RESCPU, tooltipText = L.TOGGLE_RESCPU, notCheckable = true, func = slashes.rescpu[3], keepShownOnClick = true }, tooltipOnButton = 1,
            -- Hide
            { text = L.N_HID, tooltipTitle = L.N_HID, tooltipText = ("%s %s"):format(L.TOGGLE_HID, L.NOT_QTIP), notCheckable = true, keepShownOnClick = true, func = slashes.hide[3] }, tooltipOnButton = 1,
            -- Help
            { text = L.N_HELP, tooltipTitle = L.N_HELP, tooltipText = L.SHOW_HELP, notCheckable = true, func = function() onSlash("") end, keepShownOnClick = true }, tooltipOnButton = 1,
            -- Cancel
            { text = "Cancel", tooltipTitle = "Cancel", tooltipText = "Cancel the dropdown menu", notCheckable = true, keepShownOnClick = false }, tooltipOnButton = 1,
            -- Icons
            { text = L.N_ICO, tooltipTitle = L.N_ICO, tooltipText = ("%s %s"):format(L.TOGGLE_ICO, L.NOT_QTIP), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
              func = slashes.ico[3], checked = function() return db.icons end },
            -- Detach
            { text = L.N_DET, tooltipTitle = L.N_DET, tooltipText = ("%s %s"):format(L.TOGGLE_DET, L.NOT_QTIP), notCheckable = nil, isNotRadio = true, keepShownOnClick = true, tooltipOnButton = 1,
              func = slashes.detach[3], checked = function() return db.detach end },
            -- Profiling
            { text = L.N_CPU, tooltipTitle = L.N_CPU, tooltipText = L.TOGGLE_CPU, keepShownOnClick = true, notCheckable = nil, isNotRadio = true, tooltipOnButton = 1,
              func = slashes.prof[3], checked = function() return scriptProfile end }
        }
        EasyMenu(uidropdown, BrokerCPUDropDown and BrokerCPUDropDown or CreateFrame("Frame", "BrokerCPUDropDown", UIParent, "UIDropDownMenuTemplate"), "cursor", 0 , 0, "MENU")
    end
end

local function updateNotify()
    if not isUpdateNotified and type(BROKERCPUDB.isUpdate) == "number" and IsResting() then
        if BROKERCPUDB.isUpdate > MINOR_VERSION then
            print(("|cffffff00BrokerCPU : a newer build is available (r%d)"):format(BROKERCPUDB.isUpdate))
            UIErrorsFrame:AddMessage(("|cffffff00BrokerCPU : a newer build is available (r%d)"):format(BROKERCPUDB.isUpdate))
            isUpdateNotified = true
        end
        BROKERCPUDB.isUpdate = false
    end
end

--noinspection LuaOverlyLongMethod
local function OnEvent(_, ev, addon, v)
    if ev == "PLAYER_ENTERING_WORLD" or ev == "PLAYER_UPDATE_RESTING" then
        if IsInGuild()                  then SendAddonMessage("BrokerCPUREV", MINOR_VERSION, "GUILD") end
        if UnitInBattleground("player") then SendAddonMessage("BrokerCPUREV", MINOR_VERSION, "INSTANCE_CHAT") end
        if UnitInRaid("player")         then SendAddonMessage("BrokerCPUREV", MINOR_VERSION, "RAID") end
        if UnitInParty("player")        then SendAddonMessage("BrokerCPUREV", MINOR_VERSION, "PARTY") end
        if not isUpdateNotified then updateNotify() end
        return
    end
    if ev == "CHAT_MSG_ADDON" and addon == "BrokerCPUREV" and not isUpdateNotified then
        if tonumber(v) > MINOR_VERSION then
            BROKERCPUDB.isUpdate = type(BROKERCPUDB.isUpdate) ~= "number" and tonumber(v) or (tonumber(v) < BROKERCPUDB.isUpdate and BROKERCPUDB.isUpdate or tonumber(v))
            updateNotify()
        end
        return
    end
    if ev == "ADDON_LOADED" and not firstLoad then
        -- if this switch to true, the for loops used to retrieve datas will parse ALL addons, otherwise they will now only scan active addons, it has better performances than calling IsAddOnLoaded each loops
        newAddOn = true
    end
    if addon ~= "Broker_CPU" then return end
    if not firstLoad then return end
    firstLoad = false
    RegisterAddonMessagePrefix("BrokerCPUREV")
    numTotalAddOns = GetNumAddOns()
    --collectgarbage("stop") -- used internally for code profiling
    ResetCPUUsage          = newResetCPUUsage
    scriptProfile          = GetCVar("scriptProfile") == "1"
    if scriptProfile then D(("%s%s%s: |cff808080!REMINDER! your client has cpu profiling enabled. This is a feature provided by Blizzard to addon authors or geeks. It is known to degrade performances and you must turn it off while playing normally."):format(L.COLOR_ACE3, L.N_TITLE, L.COLOR_STOP)) end
    SLASH_BROKERCPU1       = "/broker_cpu"
    SLASH_BROKERCPU2       = "/brokercpu"
    SLASH_BROKERCPU3       = "/cpu"
    SlashCmdList.BROKERCPU = onSlash
    ldb = LibStub("LibDataBroker-1.1"):NewDataObject(L.N_TITLE, {
        type    = "data source",
        text    = "",
        icon    = icon,
        OnClick = onClick,
        OnLeave = OnLeave,
    })
    --noinspection GlobalCreationOutsideO
    BROKERCPUDB = BROKERCPUDB or {}
    db          = BROKERCPUDB
    if type(db.detach)           ~= "boolean" then db.detach           = false end -- default options
    if type(db.download)         ~= "boolean" then db.download         = true end
    if type(db.download_ldb)     ~= "boolean" then db.download_ldb     = false end
    if type(db.framerate)        ~= "boolean" then db.framerate        = true end
    if type(db.framerate_ldb)    ~= "boolean" then db.framerate_ldb    = true end
    if type(db.icons)            ~= "boolean" then db.icons            = false end
    if type(db.latency)          ~= "boolean" then db.latency          = true end
    if type(db.latency_ldb)      ~= "boolean" then db.latency_ldb      = true end
    if type(db.memory)           ~= "boolean" then db.memory           = true end
    if type(db.memory_ldb)       ~= "boolean" then db.memory_ldb       = true end
    if type(db.minimap)          ~= "boolean" then db.minimap          = false end -- true end -- XXX 163
    if type(db.qtip)             ~= "boolean" then db.qtip             = true end
    if type(db.upload)           ~= "boolean" then db.upload           = true end
    if type(db.upload_ldb)       ~= "boolean" then db.upload_ldb       = false end
    if type(db.cpukill)          ~= "number"  then db.cpukill          = 20 end
    if type(db.dec_cpu)          ~= "number"  then db.dec_cpu          = 1 end
    if type(db.dec_cpu_ldb)      ~= "number"  then db.dec_cpu_ldb      = 0 end
    if type(db.dec_cpudiff)      ~= "number"  then db.dec_cpudiff      = 2 end
    if type(db.dec_dl)           ~= "number"  then db.dec_dl           = 1 end
    if type(db.dec_dl_ldb)       ~= "number"  then db.dec_dl_ldb       = 0 end
    if type(db.dec_fps)          ~= "number"  then db.dec_fps          = 1 end
    if type(db.dec_fps_ldb)      ~= "number"  then db.dec_fps_ldb      = 0 end
    if type(db.dec_lat)          ~= "number"  then db.dec_lat          = 1 end
    if type(db.dec_lat_ldb)      ~= "number"  then db.dec_lat_ldb      = 0 end
    if type(db.dec_mem)          ~= "number"  then db.dec_mem          = 1 end
    if type(db.dec_mem_ldb)      ~= "number"  then db.dec_mem_ldb      = 0 end
    if type(db.dec_memdiff)      ~= "number"  then db.dec_memdiff      = 2 end
    if type(db.dec_up)           ~= "number"  then db.dec_up           = 1 end
    if type(db.dec_up_ldb)       ~= "number"  then db.dec_up_ldb       = 0 end
    if type(db.ldbtextthreshold) ~= "number"  then db.ldbtextthreshold = 10 end
    if type(db.scale)            ~= "number"  then db.scale            = 1 end
    if type(db.tooltipthreshold) ~= "number"  then db.tooltipthreshold = 1 end
    if type(db.isUpdate)         ~= "number"  and type(db.isUpdate) ~= "boolean" then db.isUpdate = false end
    onToggleLDBText()
    onToggleQTip(true)
    onToggleMinimap(true)
end

event = CreateFrame("Frame")
event:SetScript("OnEvent", OnEvent)
event:RegisterEvent("ADDON_LOADED")
event:RegisterEvent("PLAYER_ENTERING_WORLD")
event:RegisterEvent("CHAT_MSG_ADDON")
event:RegisterEvent("PLAYER_UPDATE_RESTING")
