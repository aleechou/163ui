local api, bgapi, addonName, T = {}, {}, ...

local defaults, mdata, mcdata = {
	availableMissionSort="threats",
	sortFollowers=true,
	batchMissions=true,
	dropLessSalvage=true,
	riskReward=1,
	announceLoss=false,
	ignore={},
	version="0.13",
}
local conf = setmetatable({}, {__index=defaults})
T.Evie.RegisterEvent("ADDON_LOADED", function(ev, addon)
	if addon == addonName then
		if type(MasterPlanConfig) == "table" then
			for k,v in pairs(MasterPlanConfig) do
				if type(v) == type(defaults[k]) then
					conf[k] = v
				end
			end
		end
		conf.version = defaults.version
		T.Evie.RaiseEvent("MP_SETTINGS_CHANGED")
		
		mdata = type(MasterPlanData) == "table" and MasterPlanData or {}
		local n, r = UnitFullName("player")
		local ckey = (r or "?") .. "#" .. n
		mcdata = type(mdata[ckey]) == "table" and mdata[ckey] or {}
		if type(mcdata.__ignore) == "table" then
			for k,v in pairs(mcdata.__ignore) do
				conf.ignore[k] = v
			end
			mcdata.__ignore = nil
		end
		T._SetMissionSeenTable(mcdata)
		
		return "remove"
	end
end)
T.Evie.RegisterEvent("PLAYER_LOGOUT", function()
	MasterPlanConfig, MasterPlanData, mcdata.__ignore = conf, mdata, next(conf.ignore) and conf.ignore
	T._ObserveMissions()
end)

setmetatable(api, {__index=bgapi})
bgapi.GarrisonAPI, T.config = T.Garrison, conf

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
	if GarrisonMissionFrameMissions and GarrisonMissionFrameMissions:IsShown() then
		GarrisonMissionList_UpdateMissions()
	end
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