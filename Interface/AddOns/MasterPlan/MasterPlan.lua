local api, addonName, T = {}, ...
if T.Mark ~= 23 then
	local m = "You must restart World of Warcraft after installing this update."
	if type(T.L) == "table" and type(T.L[m]) == "string" then m = T.L[m] end
	return print("|cffffffff[Master Plan]: |cffff8000" .. m)
end

local defaults = {
	availableMissionSort="xp",
	sortFollowers=true,
	batchMissions=true,
	dropLessSalvage=true,
	riskReward=1,
	xpPerGold=0,
	xpCapGrace=2000,
	goldRewardThreshold=2000000,
	ignore={},
	complete={},
}

local conf = setmetatable({}, {__index=defaults})
T.Evie.RegisterEvent("ADDON_LOADED", function(ev, addon)
	if addon == addonName then
		local pc, seen
		if type(MasterPlanPC) == "table" then
			pc, MasterPlanPC = MasterPlanPC
		else
			pc = {}
		end
		
		seen, pc.seen = type(pc.seen) == "table" and pc.seen or {}
		for k,v in pairs(pc) do
			local tv = type(v)
			if k ~= "ignore" and k ~= "seen" and k ~= "complete" and tv == type(defaults[k]) then
				conf[k] = v
			elseif k == "ignore" and tv == "table" then
				for k,v in pairs(v) do
					conf.ignore[k] = v
				end
			end
		end
		T._SetMissionSeenTable(seen, pc.complete)
		conf.version = GetAddOnMetadata(addonName, "Version")
		T.Evie.RaiseEvent("MP_SETTINGS_CHANGED")
		
		return "remove"
	end
end)
T.Evie.RegisterEvent("PLAYER_LOGOUT", function()
	local seen, complete = securecall(T._GetMissionSeenTable)
	MasterPlanPC, conf.ignore, conf.seen, conf.complete = conf, next(conf.ignore) and conf.ignore, seen or conf.seen, complete or conf.complete
	T._ObserveMissions()
end)

setmetatable(api, {__index={GarrisonAPI=T.Garrison}})
T.config = conf

do -- Localizer stub
	local LL, L = type(T.L) == "table" and T.L or {}, newproxy(true)
	getmetatable(L).__call = function(self, k)
		return LL[k] or k
	end
	T.L = L
end

function api:GetSortFollowers()
	return conf.sortFollowers
end
function api:SetSortFollowers(sort)
	assert(type(sort) == "boolean", 'Syntax: MasterPlan:SetSortFollowers(sort)')
	conf.sortFollowers = sort
	T.Evie.RaiseEvent("MP_SETTINGS_CHANGED", "sortFollowers")
end

function api:SetMissionOrder(order)
	assert(type(order) == "string", 'Syntax: MasterPlan:SetMissionOrder("order")')
	conf.availableMissionSort = order
	T.Evie.RaiseEvent("MP_SETTINGS_CHANGED", "availableMissionSort")
end
function api:GetMissionOrder()
	return conf.availableMissionSort
end

function api:SetBatchMissionCompletion(batch)
	assert(type(batch) == "boolean", 'Syntax: MasterPlan:SetBatchMissionCompletion(batch)')
	conf.batchMissions = batch
	T.Evie.RaiseEvent("MP_SETTINGS_CHANGED", "batchMissions")
end
function api:GetBatchMissionCompletion()
	return conf.batchMissions
end

local parties, tentativeState = {}, {}
T.tentativeState = tentativeState
local function dissolve(mid)
	local p = parties[mid]
	if p then
		local f1, f2, f3 = p[1], p[2], p[3]
		parties[mid], tentativeState[f1 or 0], tentativeState[f2 or 0], tentativeState[f3 or 0] = nil
		return f1, f2, f3
	end
end
function api:GetMissionParty(mid)
	return dissolve(mid)
end
function api:SaveMissionParty(mid, f1, f2, f3)
	dissolve(mid)
	dissolve(tentativeState[f1])
	dissolve(tentativeState[f2])
	dissolve(tentativeState[f3])
	parties[mid] = (f1 or f2 or f3) and {f1, f2, f3} or nil
	tentativeState[f1 or 0], tentativeState[f2 or 0], tentativeState[f3 or 0] = mid, mid, mid
end
function api:HasTentativeParty(mid)
	local p = parties[mid]
	return p ~= nil and ((p[1] and 1 or 0) + (p[2] and 1 or 0) + (p[3] and 1 or 0)) or 0
end
function api:GetFollowerTentativeMission(fid)
	return tentativeState[fid]
end
function api:DissolveMissionByFollower(fid)
	dissolve(tentativeState[fid])
end
function api:DissolveAllMissions()
	wipe(parties)
	wipe(tentativeState)
end

function api:IsFollowerIgnored(fid)
	return not not conf.ignore[fid]
end
function api:SetFollowerIgnored(fid, ignore)
	assert(type(fid) == "string", 'Syntax: MasterPlan:SetFollowerIgnored("followerID", ignore)')
	conf.ignore[fid] = ignore and 1 or nil
end

MasterPlan = api