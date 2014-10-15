-- local QuickHealth = LibStub("LibQuickHealth-2.0")
local GridFrame = Grid:GetModule('GridFrame')
local GridRoster = Grid:GetModule('GridRoster')
local GridStatusHeals = Grid:GetModule("GridStatus"):GetModule("GridStatusHeals", true)
local GridStatusHealth = Grid:GetModule("GridStatus"):GetModule("GridStatusHealth", true)

local L = setmetatable((GetLocale() == 'zhCN' or GetLocale() == 'zhTW') and {
    ['Quick health']  = '快速血条变化',
    ['Quick health options'] = '快速血条变化选项',
    ['Update interval'] = '更新频率',
    ['How much time between each update'] = '更新血量变化的间隔时间',
} or {}, { __index = function(t, i)
    t[i] = i
    return i
end})

local GridQuickHealth = Grid:NewModule'GridQuickHealth'
if(DEBUG_MODE) then
    _G.GridQuickHealth = GridQuickHealth
end

local UPDATE_INTERVAL = .1

GridQuickHealth.defaultDB = {
    update_interval = .1,
}

GridQuickHealth.options = {
    type = "group",
    name = L["Quick health"],
    desc = L["Quick health options"],
    order = 1500,
    args = {
        update_interval = {
            type = 'range', min = 0.05, max = 1, step = 0.05,
            name = L['Update interval'],
            desc = L['How much time between each update'],
            get = function()
                return GridQuickHealth.db.profile.update_interval
            end,
            set = function(_, v)
                GridQuickHealth.db.profile.update_interval = v
                UPDATE_INTERVAL = v
            end,
        }
    }
}

function GridQuickHealth:OnInitialize()
    if not self.db then
        self.db = Grid.db:RegisterNamespace('quick_health', { profile = self.defaultDB or { } })
    end

    UPDATE_INTERVAL = self.db.profile.update_interval
    -- self:RegisterStatus("quick_health", L["Quick health"], self.options, true)
    GridFrame.options.args.quick_health = self.options
end

function GridQuickHealth:OnEnable()
end
function GridQuickHealth:OnDisable()
end

local eventFrame = CreateFrame("Frame")
GridQuickHealth.eventFrame = eventFrame

local wipe = wipe
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax

-- local GetNumRaidMembers = GetNumRaidMembers
-- local function UnitHealthUpdated(event, unitID, newHealth)
--     --print("|cff00ff00"..GetTime().."|r", newHealth, unitID, UnitHealth(unitID), event)
-- 	if GetNumGroupMembers()>0 and unitID:sub(1,4) ~= "raid" then return end
-- 	if GridStatusHealth then GridStatusHealth:UpdateUnit(nil, unitID) end
-- 	if GridStatusHeals then GridStatusHeals:UpdateUnit(nil, unitID) end
-- end

--[[
local f = CreateFrame("Frame")
local func = function(self, event)
    local color = "|cffffffff"
    if event=="UNIT_HEALTH_FREQUENT" then color = "|cffffff00" end
    if event=="UNIT_HEALTH" then color = "|cffff0000" end
    print(color..GetTime().."|r", UnitHealth("party1"), event)
end
f:RegisterEvent("UNIT_HEALTH_FREQUENT")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", func)
--]]

local maxt, mint = {}, {}

local function OnFinished()
    -- print('OnFinished', UPDATE_INTERVAL)
    for guid, unitid in GridRoster:IterateRoster() do
        local max, min = UnitHealthMax(unitid), UnitHealth(unitid)
        if(max ~= maxt[unitid] or min ~= mint[unitid]) then
            maxt[unitid] = max
            mint[unitid] = min

            GridStatusHealth:Grid_UnitJoined('QuickHealth', grid, unitid)
            GridStatusHeals:UpdateUnit('QuickHealth', grid, unitid)
        end
    end
end

local wipeAll = function()
    wipe(maxt)
    wipe(mint)
end

function eventFrame:GROUP_ROSTER_UPDATE()
    return wipeAll()
end

function eventFrame:PLAYER_ENTERING_WORLD()
    return wipeAll()
end

function eventFrame:PLAYER_LOGIN()
	-- QuickHealth.RegisterCallback("GridQuickHealth", "UnitHealthUpdated", UnitHealthUpdated)

    self:RegisterEvent'PLAYER_ENTERING_WORLD'
    self:RegisterEvent'GROUP_ROSTER_UPDATE'

	if(GridStatusHealth) then
		GridStatusHealth:UnregisterEvent("UNIT_HEALTH")
		GridStatusHealth:UnregisterEvent("UNIT_MAXHEALTH")
	end

	if(GridStatusHeals) then
		GridStatusHeals:UnregisterEvent("UNIT_HEALTH")
		GridStatusHeals:UnregisterEvent("UNIT_MAXHEALTH")
	end



    eventFrame:Hide()

    local total = 1
    eventFrame:SetScript('OnUpdate', function(_, elapsed)
        total = total - elapsed
        if(total <= 0) then
            total = UPDATE_INTERVAL
            return OnFinished()
        end
    end)

    eventFrame:Show()

    -- local aniGroup = eventFrame:CreateAnimationGroup()
    -- local ani = aniGroup:CreateAnimation('Animation')

    -- eventFrame.aniGroup = aniGroup
    -- eventFrame.ani = ani

    -- aniGroup:SetLooping'REPEAT'
    -- aniGroup:SetScript('OnFinished', OnFinished)

    -- ani:SetOrder(1)
    -- ani:SetDuration(.2)
    -- aniGroup:Play()
end

eventFrame:SetScript("OnEvent", function(self, event)
    return self[event](self, event)
end)
eventFrame:RegisterEvent"PLAYER_LOGIN"

