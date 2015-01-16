local api, _, T = {}, ...
if T.Mark ~= 23 then return end
local EV, L = T.Evie, {}
setmetatable(L, {__call=function(self,k) if T.L then L = T.L return L(k) end return k end})

local f, data = CreateFrame("Frame"), {}
f:SetScript("OnUpdate", function(self) wipe(data) self:Hide() end)
hooksecurefunc(C_Garrison, "StartMission", function() wipe(data) end)

local unfreeStatusOrder = {[GARRISON_FOLLOWER_WORKING]=2, [GARRISON_FOLLOWER_INACTIVE]=1}

local parseTime = {} do
	local captures = {} do
		local function proc(fm, f, s)
			local t, pat = nil, fm:gsub("%%d", "\0"):gsub("[()%[%].%-+*?%%]", "%%%0")
			for chunk, inner in pat:gmatch("(|4(.-);)") do
				local it = {[0]=chunk:gsub("[()%[%].%-+*%%]", "%%%0")}
				for var in inner:gmatch("[^:]+") do
					it[#it+1] = var
				end
				t = t or {}
				t[#t+1] = it
			end
			if t then
				local nv = {}
				for i=1,#t do nv[i] = 1 end
				while 1 do
					local pat = pat
					for i=1,#nv do
						pat = pat:gsub(t[i][0], t[i][nv[i]])
					end
					captures[#captures+1], captures[#captures+2], captures[#captures+3] = "^" .. pat:gsub("%z", "(%%d+)") .. "$", f, s
					for i=#nv, 0, -1 do
						if i == 0 then return end
						nv[i] = nv[i] % #t[i] + 1
						if nv[i] > 1 then break end
					end
				end
			else
				captures[#captures+1], captures[#captures+2], captures[#captures+3] = "^" .. pat:gsub("%z", "(%%d+)") .. "$", f, s
			end
		end
		proc(GARRISON_DURATION_DAYS, 86400, 0)
		proc(GARRISON_DURATION_DAYS_HOURS, 86400, 3600)
		proc(GARRISON_DURATION_HOURS, 3600, 0)
		proc(GARRISON_DURATION_HOURS_MINUTES, 3600, 60)
		proc(GARRISON_DURATION_MINUTES, 60, 0)
		proc(GARRISON_DURATION_SECONDS, 1, 0)
	end
	setmetatable(parseTime, {__index=function(self, k)
		if k == nil then return 0 end
		local ret = math.huge
		for i=1,#captures, 3 do
			local a, b = k:match(captures[i])
			if a then
				ret = tonumber(a) * captures[i+1] + (b and tonumber(b) * captures[i+2] or 0)
				break
			end
		end
		self[k] = ret
		return ret
	end})
end
function api.GetSecondsFromTimeString(time)
	local t = parseTime[time]
	return t and t > 59 and (t + 60) or t
end
function api.GetTimeStringFromSeconds(sec)
	if sec < 60 then
		return GARRISON_DURATION_SECONDS:format(sec < 0 and 0 or sec)
	elseif sec < 3600 then
		return GARRISON_DURATION_MINUTES:format(sec/60)
	elseif sec < 84600 then
		return (sec % 3600 < 60 and GARRISON_DURATION_HOURS or GARRISON_DURATION_HOURS_MINUTES):format(sec/3600, (sec/60) % 60)
	else
		return (sec % 86400 < 3600 and GARRISON_DURATION_DAYS or GARRISON_DURATION_DAYS_HOURS):format(sec/84600, (sec/3600) % 24)
	end
end

local dropFollowers, missionDuration = {}, {} do -- Start/Available capture
	local complete, it = {}, 1
	function api.GetAvailableMissions()
		local t = C_Garrison.GetAvailableMissions()
		local i, n, nit, dropCost = 1, #t, it % 2 + 1, 0
		while i <= n do
			local mid = t[i].missionID
			if complete[mid] then
				t[i], complete[mid], n, dropCost, t[n] = i < n and t[n] or nil, nit, n - 1, dropCost + (t[i].cost or 0)
			else
				i = i + 1
			end
		end
		it = nit
		for k,v in pairs(complete) do
			if v ~= nit then
				complete[k] = nil
			end
		end
		for k,v in pairs(dropFollowers) do
			if not complete[v] then
				dropFollowers[k] = nil
			end
		end
		return t, dropCost
	end
	function api.StartMission(id)
		local t, mi, f1, f2, f3 = (C_Garrison.GetAvailableMissions())
		for i=1,#t do
			if t[i].missionID == id then
				mi = t[i]
				break
			end
		end
		if not mi then return error("Mission is not available") end
		for j=1,#mi.followers do
			local fid = mi.followers[j]
			dropFollowers[fid], f1, f2, f3 = id, fid, f1, f2
		end
		local nf = (f1 and 1 or 0) + (f2 and 1 or 0) + (f3 and 1 or 0)
		if nf ~= mi.numFollowers then return error(tostring(mi.numFollowers) .. " followers expected; " .. nf .. " assigned") end
		complete[id], missionDuration[id] = it, select(2,C_Garrison.GetPartyMissionInfo(id))
		C_Garrison.StartMission(id)
		EV.RaiseEvent("MP_MISSION_START", id, f1, f2, f3)
		return f1, f2, f3
	end
	EV.RegisterEvent("GARRISON_MISSION_NPC_CLOSED", function()
		wipe(complete)
		wipe(dropFollowers)
		wipe(missionDuration)
	end)
end

local function AddCounterMechanic(fit, fabid)
	if fabid and fabid > 0 then
		if C_Garrison.GetFollowerAbilityIsTrait(fabid) then
			fit.traits[fabid] = fabid
		else
			local mid, _, tex = C_Garrison.GetFollowerAbilityCounterMechanicInfo(fabid)
			if tex then
				fit.counters[fabid] = mid
			end
		end
	end
end
local function followerIDcmp(a, b)
	return a.followerID < b.followerID
end
local function SetFollowerInfo(t)
	local ft = {}
	for i=1,#t do
		local v = t[i]
		if v.isCollected then
			local fid, fit = v.followerID, v
			v.counters, v.traits, v.isCombat = {}, {}, v.isCollected and not unfreeStatusOrder[v.status] or false
			for i=1,2 do
				AddCounterMechanic(fit, C_Garrison.GetFollowerAbilityAtIndex(fid, i))
				AddCounterMechanic(fit, C_Garrison.GetFollowerTraitAtIndex(fid, i))
			end
			AddCounterMechanic(fit, C_Garrison.GetFollowerTraitAtIndex(fid, 3))
			ft[fid], v.affinity = fit, T.Affinities[v.garrFollowerID or v.followerID]
		end
	end
	for k, v in pairs(C_Garrison.GetInProgressMissions()) do
		for i=1,#v.followers do
			local f = ft[v.followers[i]]
			f.mission, f.missionTimeLeft, f.missionTimeSeconds = v.missionID, v.timeLeft, parseTime[v.timeLeft]
		end
	end
	for k,v in pairs(dropFollowers) do
		local f = ft[k]
		if not f.missionTimeLeft then
			f.status, f.mission, f.missionTimeLeft, f.missionTimeSeconds = GARRISON_FOLLOWER_ON_MISSION, v, "?", missionDuration[v]
		end
	end
	data.followers = ft
	f:Show()
end
function api.GetFollowerInfo(refresh)
	if not data.followers or refresh then
		SetFollowerInfo(C_Garrison.GetFollowers())
	end
	return data.followers
end
function api.GetFollowerIdentity()
	local f = C_Garrison.GetFollowers()
	local last = #f
	for i=last, 1, -1 do
		if not f[i].isCollected then
			f[i], last, f[last] = last ~= i and f[last] or nil, last - 1
		end
	end
	table.sort(f, followerIDcmp)
	local ignore, tentativeState, s1, s2 = T.config.ignore, T.tentativeState, "", ""
	for i=1,#f do
		local v = f[i]
		if v.status ~= GARRISON_FOLLOWER_INACTIVE then
			local k, q = v.followerID, ""
			q = "#" .. k .. "-" .. v.level .. "-" .. v.iLevel
			for j=1,4 do
				q = q .. "#" .. (C_Garrison.GetFollowerAbilityAtIndex(k, i) or 0) .. "#" .. (C_Garrison.GetFollowerTraitAtIndex(k, i) or 0)
			end
			s1, s2 = s1 .. q, s2 .. "#" .. (dropFollowers[k] and GARRISON_FOLLOWER_ON_MISSION or v.status ~= GARRISON_FOLLOWER_IN_PARTY and v.status or ".") .. "#" .. (tentativeState[k] or "-") .. (ignore[k] and "i" or "-")
		end
	end
	SetFollowerInfo(f)
	return s1, s1 .. s2
end
function api.PushFollowerPartyStatus(fid)
	if data.followers and data.followers[fid] then
		data.followers[fid].status = GARRISON_FOLLOWER_IN_PARTY
	end
end
function api.GetCounterInfo()
	if not data.counters then
		local ci = {}
		for fid, info in pairs(api.GetFollowerInfo()) do
			for v,k in pairs(info.counters) do
				local t = ci[k] or {}
				ci[k], t[#t+1] = t, fid
			end
		end
		data.counters = ci
		f:Show()
	end
	return data.counters
end
function api.GetFollowerTraits()
	if not data.traits then
		local ci = {}
		for fid, info in pairs(api.GetFollowerInfo()) do
			for k in pairs(info.traits) do
				local t = ci[k] or {}
				ci[k], t[#t+1] = t, fid
			end
			local k = info.affinity
			if k and k > 0 then
				local t = ci[-k] or {}
				ci[-k], t[#t+1] = t, fid
			end
		end
		data.traits = ci
		f:Show()
	end
	return data.traits
end
do -- api.GetMechanicInfo(mid/tex), api.GetMechanicDescription(mid)
	local counter, desc = {}, {}
	local function populate()
		for _, fid in pairs({6, 118, 127, 131, 138, 140, 144}) do
			for _, a in pairs(C_Garrison.GetFollowerAbilities(fid)) do
				for k,t in pairs(a.counters) do
					counter[k], counter[t.icon:lower():gsub("%.blp$","")], desc[k] = a.id, a.id, t.description
				end
			end
		end
	end
	function api.GetMechanicInfo(mid)
		if populate then
			populate = populate()
		end
		if counter[mid] then
			return C_Garrison.GetFollowerAbilityCounterMechanicInfo(counter[mid])
		end
	end
	function api.GetMechanicDescription(tid)
		if populate then
			populate = populate()
		end
		return desc[tid]
	end
end
function api.GetMissionThreats(missionID)
	local ret, rn, en = {}, 1, select(8,C_Garrison.GetMissionInfo(missionID))
	for i=1,#en do
		for id in pairs(en[i].mechanics) do
			ret[rn], rn = id, rn + 1
		end
	end
	return ret
end
do -- sortByFollowerLevels
	local lvl
	local function cmp(a,b)
		local af, bf, ac, bc = lvl[a], lvl[b], a, b
		if (not af) ~= (not bf) then
			return not not af
		elseif af and bf then
			ac, bc = unfreeStatusOrder[af.status] or 3, unfreeStatusOrder[bf.status] or 3
			if ac == bc and (not T.config.ignore[af.followerID]) ~= (not T.config.ignore[bf.followerID]) then
				return not T.config.ignore[af.followerID]
			end
			if ac == bc then
				ac, bc = af.level or 0, bf.level or 0
				if ac == bc and ac == 100 then
					ac, bc = af.iLevel or 0, bf.iLevel or 0
				end
			end
			if ac == bc then
				ac, bc = C_Garrison.GetFollowerQuality(a), C_Garrison.GetFollowerQuality(b)
			end
		end
		if ac == bc then ac, bc = a, b end
		return ac > bc
	end
	function api.sortByFollowerLevels(counters, finfo)
		lvl = finfo
		table.sort(counters, cmp)
		return counters
	end
end
function api.GetFMLevel(fmInfo)
	return fmInfo and (fmInfo.iLevel > 600 and fmInfo.iLevel or fmInfo.level) or 0
end
function api.GetLevelEfficiency(fLevel, mLevel)
	if (mLevel or 0) <= fLevel then
		return 1
	elseif mLevel - fLevel <= (mLevel > 100 and 14 or 2) then
		return 0.5
	end
	return 0.1
end
function api.GetFollowerLevelDescription(fid, mlvl, fi)
	local fi, q = fi or api.GetFollowerInfo()[fid], C_Garrison.GetFollowerQuality(fid)
	local tooLow = api.GetLevelEfficiency(api.GetFMLevel(fi), mlvl) < 0.5
	local lc, away = ITEM_QUALITY_COLORS[tooLow and 0 or q].hex, fi.missionTimeLeft
	if fi.status == GARRISON_FOLLOWER_INACTIVE then
		away = RED_FONT_COLOR_CODE .. " (" .. GARRISON_FOLLOWER_INACTIVE .. ")"
	elseif fi.status == GARRISON_FOLLOWER_WORKING then
		away = YELLOW_FONT_COLOR_CODE .. " (" .. GARRISON_FOLLOWER_WORKING .. ")"
	elseif away then
		away = "|cffa0a0a0 (" .. away .. ")"
	elseif T.config.ignore[fid] then
		away = RED_FONT_COLOR_CODE .. " (" .. L"Ignored" .. ")"
	else
		away = ""
	end
	if fi.level == 100 and fi.quality == 4 and tooLow then
		away = ITEM_QUALITY_COLORS[4].hex .. L"*" .. (away ~= "" and "|r " .. away or "|r")
	end
	return ("%s[%d]|r %s%s|r%s"):format(lc, fi.level < 100 and fi.level or fi.iLevel, HIGHLIGHT_FONT_COLOR_CODE, fi.name, away)
end
function api.GetNumIdleCombatFollowers(followers)
	local ret = 0
	for k,v in pairs(followers or api.GetFollowerInfo()) do
		if v.isCollected and (v.status == nil or v.status == GARRISON_FOLLOWER_IN_PARTY) then
			ret = ret + 1
		end
	end
	return ret
end

do -- CompleteMissions/AbortCompleteMissions
	local curStack, curRewards, curFollowers, curCallback
	local curSalvage, curPlayerXP = {[114120]=0, [114119]=0, [114116]=0}, {}
	local curState, curIndex, completionStep, lastAction, delayIndex, delayMID
	local function checkSalvage(addRewards)
		for k,v in pairs(curSalvage) do
			local nv = GetItemCount(k) or 0
			if addRewards and nv > v then
				local ik = "item:" .. k
				curRewards[ik] = curRewards[ik] or {itemID=k, quantity=0}
				curRewards[ik].quantity = curRewards[ik].quantity + nv - v
			end
			curSalvage[k] = nv
		end
		local nxp, nlvl = UnitXP("player"), UnitLevel("player")
		if addRewards and curPlayerXP[1] and (curPlayerXP[1] < nxp or curPlayerXP[3] < nlvl) then
			curRewards.xp = curRewards.xp or {playerXP=0}
			curRewards.xp.playerXP = curRewards.xp.playerXP + (curPlayerXP[3] < nlvl and curPlayerXP[2] or 0) + nxp - curPlayerXP[1]
		end
		curPlayerXP[1], curPlayerXP[2], curPlayerXP[3] = nxp, UnitXPMax("player"), nlvl
	end
	local delayOpen, delayRoll do
		local function delay(state, f, d)
			local function delay(minDelay)
				if curState == state and curIndex == delayIndex and curStack[delayIndex].missionID == delayMID then
					local time = GetTime()
					if not minDelay and (not lastAction or (time-lastAction >= d)) then
						lastAction = GetTime()
						f(curStack[curIndex].missionID)
						C_Timer.After(d, delay)
					else
						C_Timer.After(math.max(0.1, d + lastAction - time, minDelay or 0), delay)
					end
				end
			end
			return delay
		end
		delayOpen = delay("COMPLETE", C_Garrison.MarkMissionComplete, 0.4)
		delayRoll = delay("BONUS", C_Garrison.MissionBonusRoll, 0.4)
	end
	local function delayStep()
		completionStep("GARRISON_MISSION_NPC_OPENED")
	end
	local function delayDone()
		if curState == "ABORT" or curState == "DONE" then
			checkSalvage(true)
			securecall(curCallback, curState, curStack, curRewards, curFollowers)
			curState, curStack, curRewards, curFollowers, curIndex, curCallback, delayMID, delayIndex = nil
		end
	end
	function completionStep(ev, ...)
		if not curState then return end
		local mi = curStack[curIndex]
		while mi and (mi.succeeded or mi.failed) do
			mi, curIndex = curStack[curIndex+1], curIndex + 1
		end
		if (ev == "GARRISON_MISSION_NPC_CLOSED" and mi) or not mi then
			curState = mi and "ABORT" or "DONE"
			C_Timer.After(0.5, delayDone)
		elseif curState == "NEXT" and ev == "GARRISON_MISSION_NPC_OPENED" then
			if mi.state == -1 then
				curState, delayIndex, delayMID = "COMPLETE", curIndex, mi.missionID
				delayOpen(... ~= "IMMEDIATE" and 0.2)
			else
				mi.materialMultiplier = select(8, C_Garrison.GetPartyMissionInfo(mi.missionID))
				curState, delayIndex, delayMID = "BONUS", curIndex, mi.missionID
				delayRoll(... ~= "IMMEDIATE" and 0.2)
			end
		elseif curState == "COMPLETE" and ev == "GARRISON_MISSION_COMPLETE_RESPONSE" then
			local mid, cc, ok = ...
			if mid ~= mi.missionID and not cc then return end
			if securecall(assert, mid == mi.missionID, "Unexpected mission completion") then
				if ok then
					mi.state, curState = 0, "BONUS"
					if not mi.materialMultiplier then
						mi.materialMultiplier = select(8, C_Garrison.GetPartyMissionInfo(mi.missionID))
					end
				else
					mi.failed, curState, curIndex = cc and true or nil, "NEXT", curIndex + 1
				end
				securecall(curCallback, "STEP", curStack, curRewards, curFollowers, ok and "COMPLETE" or "FAIL", mi.missionID)
				if ok then
					delayIndex, delayMID = curIndex, mi.missionID
					delayRoll(0.2)
				else
					C_Timer.After(0.45, delayStep)
				end
			end
		elseif curState == "BONUS" and ev == "GARRISON_MISSION_BONUS_ROLL_COMPLETE" then
			local mid, _ok = ...
			if securecall(assert, mid == mi.missionID, "Unexpected bonus roll completion") then
				mi.succeeded, curState, curIndex = true, "NEXT", curIndex + 1
				if mi.rewards then
					for k,r in pairs(mi.rewards) do
						if r.currencyID and r.quantity then
							local ik, q = "cur:" .. r.currencyID, r.quantity
							if r.currencyID == GARRISON_CURRENCY then
								q = floor(q*(mi.materialMultiplier or 1))
							end
							curRewards[ik] = curRewards[ik] or {quantity=0, currencyID=r.currencyID}
							curRewards[ik].quantity = curRewards[ik].quantity + q
						elseif r.itemID and r.quantity then
							local ik = "item:" .. r.itemID
							curRewards[ik] = curRewards[ik] or {itemID=r.itemID, quantity=0}
							curRewards[ik].quantity = curRewards[ik].quantity + r.quantity
						end
					end
				end
				securecall(curCallback, "STEP", curStack, curRewards, curFollowers, "LOOT", mi.missionID)
			end
		end
	end
	EV.RegisterEvent("GARRISON_FOLLOWER_XP_CHANGED", function(ev, fid, xpAward, oldXP, olvl, oqual)
		if curState then
			curFollowers[fid] = curFollowers[fid] or {olvl=olvl, oqual=oqual, xpAward=0, oxp=oldXP}
			curFollowers[fid].xpAward = curFollowers[fid].xpAward + xpAward
		end
	end)
	EV.RegisterEvent("GARRISON_MISSION_NPC_OPENED", completionStep)
	EV.RegisterEvent("GARRISON_MISSION_NPC_CLOSED", completionStep)
	EV.RegisterEvent("GARRISON_MISSION_BONUS_ROLL_COMPLETE", completionStep)
	EV.RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE", completionStep)
	function api.CompleteMissions(stack, callback)
		curStack, curCallback, curRewards, curFollowers = stack, callback, {}, {}
		curState, curIndex = "NEXT", 1, checkSalvage(false)
		completionStep("GARRISON_MISSION_NPC_OPENED", "IMMEDIATE")
	end
	function api.AbortCompleteMissions()
		completionStep("GARRISON_MISSION_NPC_CLOSED")
	end
	function api.GetCompletionState()
		return curState, curIndex, curStack, curRewards, curFollowers
	end
end

do -- GetMissionSeen
	local lt, dt, ct, time do
		local t = {}
		function time()
			t.month, t.day, t.year = select(2, CalendarGetDate())
			t.hour, t.min = GetGameTime()
			return _G.time(t)
		end
	end
	local expire = {} do
		for n, r in ("000210611621id2e56516c16o17i0:0ga6b:0o2103rz4rz5r86136716e26q37ji9549eja23ai1al3aqg:102zd3h86vm82mak0ap0:1y9a39y3:20050100190:9b8pfb7a"):gmatch("(%w%w)(%w+)") do
			local n = tonumber(n, 36)
			for s, l in r:gmatch("(%w%w)(%w)") do
				local s = tonumber(s, 36)
				for i=s, s+tonumber(l, 36) do
					expire[i] = n
				end
			end
		end
	end
	local isPendingObserve
	local function ObserveMissions()
		isPendingObserve = nil
		if not dt then return end
		local avail, seen, now = C_Garrison.GetAvailableMissions(), {}, time()
		if #avail > 0 then
			for i=1,#avail do
				local mid = avail[i].missionID
				if lt and dt[mid] and (expire[mid] or 0) > 0 and (now - dt[mid]) > expire[mid]*3600 then
					dt[-mid], dt[mid], seen[mid] = max((dt[-mid] or -math.huge)+expire[mid]*3600, now-expire[mid]*3600, lt or -math.huge), now, 1
				else
					dt[mid], dt[-mid], seen[mid] = dt[mid] or now, dt[-mid] or lt or now, 1
				end
			end
			for k in pairs(dt) do
				if type(k) == "number" and not seen[k] and not seen[-k] then
					dt[k], dt[-k] = nil, nil
				end
			end
			dt.__time, lt = now
		end
	end
	function api.GetMissionSeen(mid)
		local now, ex, lastComplete = time(), expire[mid], ct and ct[mid]
		local early, late = dt and dt[-mid] or now, dt and dt[mid] or now
		if early == 0 then early = min(late, now - ex * 3600) end
		return difftime(now, early), difftime(now, late), expire[mid], lastComplete and difftime(now, lastComplete)
	end
	function T._SetMissionSeenTable(t, t2)
		if type(t) == "table" then
			dt, lt = {}, type(t) == "table" and type(t.__time) == "number" and t.__time or 0
			for k,v in pairs(t) do
				dt[k] = v
			end
		end
		if type(t2) == "table" then
			ct = {}
			for k,v in pairs(t2) do
				if type(k) == "number" and type(v) == "number" then
					ct[k] =v
				end
			end
		end
	end
	function T._GetMissionSeenTable()
		return dt, ct
	end
	T._ObserveMissions = ObserveMissions
	EV.RegisterEvent("GARRISON_MISSION_STARTED", function(ev, id)
		if dt then
			dt[id] = nil
		end
	end)
	EV.RegisterEvent("GARRISON_MISSION_LIST_UPDATE", function()
		if not isPendingObserve then
			C_Timer.After(1, ObserveMissions)
			isPendingObserve = true
		end
	end)
	EV.RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE", function(_, id)
		if id and ct then
			ct[id] = time()
		end
	end)
end

do -- PrepareAllMissionGroups/GetMissionGroups {sc xp gr ti p1 p2 p3 xp pb}
	local msf, msi, msd, mmi, finfo = {}, {}, {}
	local suppressFollowerEvents, releaseFollowerEvents do
		local level, frames, followers = 0
		local function failsafe()
			if level > 0 then
				level = 1
				releaseFollowerEvents()
			end
		end
		function suppressFollowerEvents()
			if level == 0 then
				frames, followers = {GetFramesRegisteredForEvent("GARRISON_FOLLOWER_LIST_UPDATE")}, {}
				for i=1,#frames do
					frames[i]:UnregisterEvent("GARRISON_FOLLOWER_LIST_UPDATE")
				end
				local mmi = C_Garrison.GetAvailableMissions()
				for i=1,#mmi do
					for k,v in pairs(mmi[i].followers) do
						C_Garrison.RemoveFollowerFromMission(mmi[i].missionID, v)
						followers[v] = mmi[i].missionID
					end
				end
				C_Timer.After(0, failsafe)
			end
			level = level + 1
		end
		function releaseFollowerEvents()
			assert(level > 0, "release not matched to suppress")
			level = level - 1
			if level == 0 then
				local mmi = C_Garrison.GetAvailableMissions()
				for i=1,#mmi do
					for k,v in pairs(mmi[i].followers) do
						C_Garrison.RemoveFollowerFromMission(mmi[i].missionID, v)
					end
				end
				for f, m in pairs(followers) do
					C_Garrison.AddFollowerToMission(m, f)
				end
				for i=1,#frames do
					frames[i]:RegisterEvent("GARRISON_FOLLOWER_LIST_UPDATE")
				end
				frames, followers = nil, nil
			end
		end
	end
	local function cmp_level(a, b)
		local a, b = finfo[a], finfo[b]
		return (a.level + a.iLevel) > (b.level + b.iLevel)
	end
	function api.PrepareAllMissionGroups()
		mmi = C_Garrison.GetAvailableMissions(mmi)
		suppressFollowerEvents()
		securecall(function()
			for i=1,#mmi do
				api.GetMissionGroups(mmi[i].missionID, i > 1)
			end
		end)
		releaseFollowerEvents()
		mmi = nil
	end
	function api.GetMissionGroups(mid, trustValid)
		if not trustValid or not msi[1] then
			finfo = api.GetFollowerInfo()
			local valid, fn = true, 1
			for k,v in pairs(finfo) do
				if v.isCollected and v.status ~= GARRISON_FOLLOWER_INACTIVE then
					local key = v.level .. "#" .. v.iLevel
					for i=1,4 do
						key = key .. "#" .. (C_Garrison.GetFollowerAbilityAtIndex(k, i) or 0) .. "#" .. (C_Garrison.GetFollowerTraitAtIndex(k, i) or 0)
					end
					msi[fn], fn, msf[k], valid = k, fn+1, key, valid and msf[k] == key
				end
			end
			for i=fn,#msi do
				valid, msi[i] = false
			end
			table.sort(msi, cmp_level)
			for k,v in pairs(msf) do
				if not (finfo[k] and finfo[k].isCollected and finfo[k].status ~= GARRISON_FOLLOWER_INACTIVE) then
					valid, msf[k] = false
				end
			end
			if not valid then wipe(msd) end
			finfo = nil
		end
		if not msd[mid] then
			local mmi, mi = mmi or C_Garrison.GetAvailableMissions()
			for i=1,#mmi do
				if mmi[i].missionID == mid then
					mi = mmi[i]
					break
				end
			end
			if not mi then return false end
			if mi.numFollowers > #msi then msd[mid] = {} return {} end
			local garrisonResources, chestXP, _, baseXP = 0, 0, C_Garrison.GetMissionInfo(mid)
			for k,r in pairs(mi.rewards) do
				if r.currencyID == GARRISON_CURRENCY then
					garrisonResources = garrisonResources + r.quantity
				elseif r.followerXP then
					chestXP = chestXP + r.followerXP
				end
			end
			
			suppressFollowerEvents()
			
			local fn, t, fm, m, mn = #msi, {}, {}, {}, 1
			fm[1] = fn
			for i=2,mi.numFollowers do
				fm[1], fm[2], fm[3] = fm[1] - 1, fm[1], fm[2]
			end
			t[1], t[2], t[3] = fm[1], fm[2], fm[3]

			local i1, i2, i3 = 1, mi.numFollowers > 1 and 2 or -1, mi.numFollowers > 2 and 3 or -1
			local af, rf, nf = C_Garrison.AddFollowerToMission, C_Garrison.RemoveFollowerFromMission, mi.numFollowers
			repeat
				for i=nf,1,-1 do
					rf(mid, msi[t[i]])
					t[i] = t[i] % fm[i] + 1
					if t[i] > 1 or i == 1 then
						if not af(mid, msi[t[i]]) then error("Failed to add follower " .. i .. ":" .. tostring(t[i]) .. ":" .. tostring(msi[t[i]])) end
						for j=i+1, nf do
							t[j]=t[j-1]+1
							if not af(mid, msi[t[j]]) then error("Failed to add follower " .. j .. ":" .. tostring(t[j]) .. ":" .. tostring(msi[t[j]])) end
						end
						break
					end
				end
				local _totalTimeString, totalTimeSeconds, _isMissionTimeImproved, successChance, partyBuffs, _isEnvMechanicCountered, xpBonus, materialMultiplier = C_Garrison.GetPartyMissionInfo(mid)
				m[mn], mn = {successChance, baseXP+xpBonus, garrisonResources*materialMultiplier, totalTimeSeconds, msi[t[i1]], msi[t[i2]], msi[t[i3]], chestXP, next(partyBuffs) and partyBuffs}, mn + 1
			until t[1] == fm[1] and t[2] == fm[2] and t[3] == fm[3]
			
			for i=1,nf do
				C_Garrison.RemoveFollowerFromMission(mid, msi[t[i]])
			end
			
			msd[mid] = m
			releaseFollowerEvents()
		end
		return msd[mid]
	end
	EV.RegisterEvent("MP_MISSION_START", function()
		for k,v in pairs(msd) do
			for i=1,#v do
				v[i].earliestDeparture = nil
			end
		end
	end)
end
function api.GetFilteredMissionGroups(minfo, filter, cmp, limit)
	local mg = api.GetMissionGroups(minfo.missionID)
	local best, finfo, sorted, now = {}, api.GetFollowerInfo(), false, time()
	for i=1,mg and #mg or 0 do
		local this = mg[i]
		if filter ~= nil and not filter(this, finfo, minfo) then
		elseif not limit or best[limit] == nil then
			best[#best+1] = this
			if limit and best[limit] then
				table.sort(best, function(a,b) return cmp(a, b, finfo, minfo) end)
				sorted = true
			end
		elseif cmp(this, best[limit], finfo, minfo) then
			best[limit] = this
			for i=limit-1, 1, -1 do
				if cmp(best[i], best[i+1], finfo, minfo) then
					break
				end
				best[i+1], best[i] = best[i], best[i+1]
			end
		end
	end
	if not sorted then
		table.sort(best, function(a,b) return cmp(a, b, finfo, minfo, now) end)
	end
	return best
end
do -- GetBackfillMissionGroups(minfo, filter, cmp, f1, f2, f3, f4)
	local filter, f1, f2, f3, f4
	local function backfillFilter(res, finfo, minfo)
		if filter(res, finfo, minfo) then
			local g1, g2, g3 = res[5], res[6], res[7]
			local nm = f4 and (f4 == g1 or f4 == g2 or f4 == g3) and 1 or 0
			if f4 and nm == 0 then return end
			nm = nm + (f1 and (f1 == g1 or f1 == g2 or f1 == g3) and 1 or 0)
			        + (f2 and (f2 == g1 or f2 == g2 or f2 == g3) and 1 or 0)
			        + (f3 and (f3 == g1 or f3 == g2 or f3 == g3) and 1 or 0)
			return nm == ((f1 and 1 or 0) + (f2 and 1 or 0) + (f3 and 1 or 0))
		end
	end
	function api.GetBackfillMissionGroups(mi, afilter, cmp, limit, af1, af2, af3, af4)
		filter, f1, f2, f3, f4 = afilter, af1, af2, af3, af4
		return api.GetFilteredMissionGroups(mi, (af1 or af2 or af3) and backfillFilter or afilter, cmp or api.GetMissionDefaultGroupRank(mi), limit)
	end
end
do -- api.GetBuffsXPMultiplier(buffs)
	local xpBuffs = {[80]=0.30, [236]=0.35}
	function api.GetBuffsXPMultiplier(buffs)
		local mul = 1
		for i=1,#buffs do
			mul = mul + (xpBuffs[buffs[i]] or 0)
		end
		return mul
	end
end
function api.GetFollowerXPGain(fi, mlvl, base, bonus)
	if fi.quality == 4 and fi.level == 100 then
		base, bonus = 0, 0
	elseif base > 0 or bonus > 0 then
		fi = fi.traits and fi or api.GetFollowerInfo()[fi.followerID] or fi
		local tmul = fi.traits and fi.traits[29] and 1.50 or 1
		local emul = api.GetLevelEfficiency(fi.iLevel > 600 and fi.iLevel or fi.level, mlvl)
		if base > 0 then
			base = base * tmul * emul
			if fi.xp + base > fi.levelXP and fi.level < 100 then
				emul = api.GetLevelEfficiency(fi.level + 1, mlvl)
			end
		end
		bonus = bonus * tmul * emul
	end
	return base, bonus
end
local risk = {} do
	setmetatable(risk, {__index=function(self, c)
		local rew, ret = T.config.riskReward
		if c == 100 then
			ret = 1
		elseif rew == 1 then
			ret = c/100
		elseif rew < 1 then
			ret = c * rew
		else
			ret = c + (1-c) * (rew-1)
		end
		self[c] = ret
		return ret
	end})
	EV.RegisterEvent("MP_SETTINGS_CHANGED", function(_, s)
		if s == nil or s == "riskReward" then
			wipe(risk)
		end
	end)
end
local computeEquivXP, computeEarliestDeparture do
	local max, min, inf = math.max, math.min, math.huge
	function computeEquivXP(g, finfo, minfo, force)
		if not g.equivXP or force then
			local mlvl, bonus = api.GetFMLevel(minfo), g[8]
			bonus = bonus * (bonus > 0 and g[9] and api.GetBuffsXPMultiplier(g[9]) or 1)
			
			local expected, balanced, risk, ecap = 0, 0, risk[g[1]], (T.config.xpCapGrace or 2000)
			
			for i=1, minfo.numFollowers do
				local fi = finfo[g[4+i]]
				local base, bonus = api.GetFollowerXPGain(fi, mlvl, g[2], bonus)
				if base > 0 or bonus > 0 then
					if (fi.level == 99 and fi.quality == 4) or (fi.level == 100 and fi.quality == 3) then
						local cap = fi.levelXP - fi.xp
						balanced = balanced + base + risk*max(0, min(bonus, cap + ecap - base))
						expected = expected + max(0, min(base, cap)) + g[1]/100 * max(0, min(bonus, cap - base))
					else
						balanced, expected = balanced + base + risk * bonus, expected + base + g[1]/100 * bonus
					end
				end
			end
			if type(minfo.rewards) == "table" then
				for k,v in pairs(minfo.rewards) do
					if v.currencyID == 0 then
						balanced = balanced + g[1]/100 * v.quantity/10000 * (T.config.xpPerGold or 0)
					end
				end
			end
			g.equivXP, g.expectedXP = floor(balanced), floor(expected)
		end
		return g.equivXP
	end
	function computeEarliestDeparture(g, finfo, minfo, force, now)
		local ret = g.earliestDeparture
		if ret == nil or force then
			ret = false
			for i=5, 4+minfo.numFollowers do
				local f = finfo[g[i]]
				local drop = dropFollowers[f.followerID]
				if f.status == GARRISON_FOLLOWER_ON_MISSION or drop then
					local t = f.missionTimeSeconds or (drop and missionDuration[drop]) or inf
					if not ret or t > ret then
						ret = t
					end
				end
			end
			ret = ret and ((now or time()) + (ret == inf and 359999 or ret))
			g.earliestDeparture = ret
		end
		if ret and now and ret < now then
			ret = now
		end
		return ret or now or time(), ret
	end
end
api.GroupRank, api.GroupFilter = {}, {} do
	local function computeDingScore(g, finfo)
		if not g.dingScore then
			local a, b, c = 1200, 1200, 1200
			for i=5,7 do
				local fi = finfo[g[i]]
				if fi and fi.xp and fi.levelXP and fi.levelXP > 0 then
					a, b, c = floor((fi.levelXP-fi.xp)/100), a, b
				end
			end
			b, c = b > c and c or b, b > c and b or c
			a, b = a > b and b or a, a > b and a or b
			b, c = b > c and c or b, b > c and b or c
			g.dingScore = -(a * 10000 + b * 100 + c)
		end
		return g.dingScore
	end
	local function success(a, b, finfo, minfo, now)
		local ac, bc, ad, bd, ah, bh = a[1], b[1]
		if ac == bc then
			ac, bc = a[3] * risk[a[1]], b[3] * risk[b[1]]
		end
		if ac == bc then
			ad, ah = computeEarliestDeparture(a, finfo, minfo, false, now)
			bd, bh = computeEarliestDeparture(b, finfo, minfo, false, now)
			ac, bc = -(ad + a[4]), -(bd + b[4])
		end
		if ac == bc then
			ac, bc = computeEquivXP(a, finfo, minfo), computeEquivXP(b, finfo, minfo)
		end
		if ac == bc then
			ac, bc = computeDingScore(a, finfo), computeDingScore(b, finfo)
		end
		if (ac == bc) and (not ah) ~= (not bh) then
			ac, bc = bh and 1 or 0, 0
		end
		return ac > bc
	end
	local function res(a, b, finfo, minfo, now)
		if a[3] > 0 or b[3] > 0 then
			local ac, bc = risk[a[1]] * a[3], risk[b[1]] * b[3]
			if ac ~= bc then
				return ac > bc
			end
		end
		return success(a,b, finfo, minfo, now)
	end
	local function xp(a, b, finfo, minfo, now)
		local ac, bc = computeEquivXP(a, finfo, minfo), computeEquivXP(b, finfo, minfo)
		if ac == bc and ac > 0 then
			ac, bc = -a[4], -b[4]
		end
		if ac == bc then
			return success(a,b, finfo, minfo, now)
		end
		return ac > bc
	end
	function api.GroupRank.threats2(a, b, ...)
		local ac, bc = a[1], b[1]
		if ac == bc then
			ac, bc = a[3]*a[1], b[3]*b[1]
		end
		if ac == bc then
			return xp(a, b, ...)
		end
		return ac > bc
	end
	api.GroupRank.threats, api.GroupRank.resources, api.GroupRank.xp = success, res, xp
end
function api.GetMissionDefaultGroupRank(mi)
	local rew = api.HasSignificantRewards(mi)
	local key = rew == false and "xp" or rew == "resource" and "resources" or "threats"
	return api.GroupRank[key], key
end
function api.GroupFilter.IDLE(res, finfo, minfo)
	local mid = minfo.missionID
	for i=5,4+minfo.numFollowers do
		local fi = finfo[res[i]]
		if not (fi and (fi.status == nil or fi.status == GARRISON_FOLLOWER_IN_PARTY) and not T.config.ignore[fi.followerID] and not dropFollowers[fi.followerID] and (MasterPlan:GetFollowerTentativeMission(fi.followerID) or mid) == mid) then
			return false
		end
	end
	return true
end
function api.GroupFilter.COMBAT(res, finfo, minfo)
	for i=5,4+minfo.numFollowers do
		local fi = finfo[res[i]]
		if not (fi and (fi.status == nil or fi.status == GARRISON_FOLLOWER_IN_PARTY or fi.status == GARRISON_FOLLOWER_ON_MISSION) and not T.config.ignore[fi.followerID]) then
			return false
		end
	end
	return true
end
function api.GroupFilter.ACTIVE(res, finfo, minfo)
	for i=5,4+minfo.numFollowers do
		local fi = finfo[res[i]]
		if not (fi and fi.status ~= GARRISON_FOLLOWER_INACTIVE and not T.config.ignore[fi.followerID]) then
			return false
		end
	end
	return true
end
function api.AnnotateMissionParty(party, finfo, minfo, force)
	finfo = finfo or api.GetFollowerInfo()
	computeEquivXP(party, finfo, minfo)
	computeEarliestDeparture(party, finfo, minfo, force)
end
function api.HasSignificantRewards(mi)
	if mi.rewards then
		local allGR, allXP = true, true
		for _, r in pairs(mi.rewards) do
			if not (r.followerXP or (r.currencyID == 0 and r.quantity < T.config.goldRewardThreshold)) then
				allXP = false
			end
			if r.currencyID ~= GARRISON_CURRENCY then
				allGR = false
			end
		end
		if allGR and not allXP then
			return "resource"
		else
			return not allXP
		end
	end
	return false
end
do -- api.GetSuggestedGroups(mi, onlyBackfill, f1, f2, f3)
	local function SetGroup(self, group)
		local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
		GarrisonMissionPage_ClearParty()
		for i=1,mi.numFollowers do
			GarrisonMissionPage_AddFollower(group[4+i])
		end
	end
	local function SecondsToTime(sec)
		local m, s, out = (sec % 3600) / 60, sec % 60
		if sec >= 3600 then out = HOUR_ONELETTER_ABBR:format(sec/3600) end
		if m > 0 then out = (out and out .. " " or "") .. MINUTE_ONELETTER_ABBR:format(m) end
		if s > 0 then out = (out and out .. " " or "") .. SECOND_ONELETTER_ABBR:format(s) end
		return out or ""
	end
	local function addToMenu(mm, groups, mi, finfo, base)
		local ml, primary = api.GetFMLevel(mi), mi._primaryGoal or select(2, api.GetMissionDefaultGroupRank(mi))
		mi._primaryGoal = primary
		
		for i=1,#groups do
			local gi, tg = groups[i]
			for i=1,mi.numFollowers do
				tg = (i > 1 and tg .. "|n" or "") .. api.GetFollowerLevelDescription(gi[4+i], ml, finfo[gi[4+i]])
			end
			api.AnnotateMissionParty(gi, finfo, mi)
			local sc, xp, res, text = gi[1] .. "%"
			if gi.expectedXP and gi.expectedXP > 0 then
				local exp = BreakUpLargeNumbers(floor(gi.expectedXP))
				xp = (L"%s XP"):format(exp)
				tg = tg .. "|n" .. (L"+%s experience expected"):format(exp)
			end
			if gi[1] and gi[1] > 0 and gi[3] and gi[3] > 0 then
				res = floor(gi[1]*gi[3]/100) .. " |TInterface\\Garrison\\GarrisonCurrencyIcons:20:20:0:-2:128:128:12:52:12:52|t"
			end
			if (primary == "xp" and xp) or (primary == "resources" and res) then
				text = (primary == "xp" and xp or res) .. "; " .. sc .. (primary == "resources" and xp and "; " .. xp or "")
			else
				text = sc .. (xp and "; " .. xp or "")
			end
			text = text .. "; " .. SecondsToTime(gi[4])
			
			mm[#mm+1] = { text = text, notCheckable=true, tooltipText=tg, tooltipTitle=NORMAL_FONT_COLOR_CODE .. (L"Group %d"):format((base or 0) + i), tooltipOnButton=true, func=SetGroup, arg1=gi, arg2=mi}
		end
	end
	local function extend(g, mi, rt, f1, f2, f3)
		local best = 0
		if type(g) ~= "table" then g = {} end
		for i=1,g and #g or 0 do
			if g[i][1] and g[i][1] > best then
				best = g[i][1]
			end
		end
		if best < 100 then
			local bg = api.GetBackfillMissionGroups(mi, api.GroupFilter.IDLE, api.GroupRank[rt == "xp" and "threats2" or "threats"], 1, f1, f2, f3)
			if bg and bg[1] and bg[1][1] > best then
				g[#g + 1] = bg[1]
			end
		end
		return g
	end
	function api.GetSuggestedGroups(mi, onlyBackfill, f1, f2, f3)
		local mm, finfo, sg = {}, api.GetFollowerInfo()
		local rank, rt = api.GetMissionDefaultGroupRank(mi)
		if not onlyBackfill then
			sg = api.GetFilteredMissionGroups(mi, api.GroupFilter.IDLE, rank, 3)
			sg = extend(sg, mi, rt)
		elseif (f1 and 1 or 0) + (f2 and 1 or 0) + (f3 and 1 or 0) == mi.numFollowers then
			sg = api.GetBackfillMissionGroups(mi, api.GroupFilter.IDLE, rank, 1, f1, f2, f3)
		end
		if sg and #sg > 0 then
			mm[1] = {text=L"Suggested groups", isTitle=true, notCheckable=true}
			addToMenu(mm, sg, mi, finfo)
		end
		local fc = (f1 and 1 or 0) + (f2 and 1 or 0) + (f3 and 1 or 0)
		if fc < mi.numFollowers and fc > 0 then
			local g3 = api.GetBackfillMissionGroups(mi, api.GroupFilter.IDLE, rank, 3, f1, f2, f3)
			g3 = extend(g3, mi, rt, f1, f2, f3)
			if #g3 > 0 then
				mm[#mm+1] = {text = L"Complete party", isTitle=true, notCheckable=true}
				addToMenu(mm, g3, mi, finfo, sg and #sg or 0)
			end
		end
		return mm
	end
end

do -- api.GetUpgradeItems(ilevel, isArmor)
	local upgrades = {
		WEAPON={114128, 655, 114129, 652, 114131, 649, 114616, 615, 114081, 630, 114622, 645},
		ARMOR={114745, 655, 114808, 652, 114822, 649, 114807, 615, 114806, 630, 114746, 645}
	}
	local function walk(ilvl, t, pos)
		for i=pos,#t,2 do
			if t[i+1] > ilvl and GetItemCount(t[i]) > 0 then
				return t[i], walk(ilvl, t, i + 2)
			end
		end
	end
	function api.GetUpgradeItems(ilevel, isWeapon)
		return walk(ilevel, isWeapon and upgrades.WEAPON or upgrades.ARMOR, 1)
	end
end
function api.ExtendFollowerTooltipMissionRewardXP(mi, fi)
	local tip = GarrisonFollowerTooltip
	if mi and fi and tip:IsShown() and tip.XPBarBackground:IsShown() then
		local bmul, base, extraXP, bonus, _ = mi.groupXPBuff, mi.baseXP, mi.extraXP, 0
		if bmul == nil or extraXP == nil then
			local _, _, _, _, pb, _, exp = C_Garrison.GetPartyMissionInfo(mi.missionID)
			bmul, extraXP = api.GetBuffsXPMultiplier(pb), exp
		end
		if base == nil then
			_, base = C_Garrison.GetMissionInfo(mi.missionID)
		end
		if base and extraXP and bmul and fi.levelXP then
			for k,v in pairs(mi.rewards) do
				if v.followerXP then bonus = bonus + v.followerXP end
			end
			local base, bonus = api.GetFollowerXPGain(fi, api.GetFMLevel(mi), extraXP + base, bonus * bmul)
			
			local toLevel, wmul = fi.levelXP - fi.xp, tip.XPBarBackground:GetWidth()/fi.levelXP
			tip.XPBarBackground:SetTexture(0.25, 0.25, 0.25)
			if tip.XPBar:IsShown() then
				tip.XPRewardBase:SetPoint("TOPLEFT", tip.XPBar, "TOPRIGHT")
				tip.XPRewardBase:SetPoint("BOTTOMLEFT", tip.XPBar, "BOTTOMRIGHT")
			else
				tip.XPRewardBase:SetPoint("TOPLEFT", tip.XPBarBackground, "TOPLEFT")
				tip.XPRewardBase:SetPoint("BOTTOMLEFT", tip.XPBarBackground, "BOTTOMLEFT")
			end
			tip.XPRewardBase:SetWidth(math.max(0.01, math.min(toLevel, base)*wmul))
			tip.XPRewardBonus:SetWidth(math.max(0.01, math.min(toLevel-base, bonus)*wmul))
			tip.XPRewardBonus:SetShown(bonus > 0 and toLevel > base)
			tip.XPRewardBase:SetShown(base > 0)
			if base > 0 then
				local xpt = "|cff99ff00" .. BreakUpLargeNumbers(floor(base)) .. "|r"
				if bonus > 0 then xpt = xpt .. "+|cff00bfff" .. BreakUpLargeNumbers(floor(bonus)) .. "|r" end
				tip.XP:SetText(tip.XP:GetText() .. "|n" .. (L"Reward: %s XP"):format(xpt))
			end
		else
			tip.XPRewardBonus:Hide()
			tip.XPRewardBase:Hide()
		end
	end
end

function api.UpdateGroupEstimates(missions, useInactive)
	local ft, nf, f = {}, 0, C_Garrison.GetFollowers()
	for i=1,#f do
		local fi = f[i]
		if fi.isCollected and (useInactive or fi.status ~= GARRISON_FOLLOWER_INACTIVE) and not T.config.ignore[fi.followerID] then
			local cn, tn, fid, af = 1, 1, fi.followerID, T.Affinities[fi.garrFollowerID] or 0
			fi.counters, fi.traits, fi.affinity, nf = {}, {}, af, nf + 1
			if (af or 0) > 0 then
				fi.traits[tn], tn = -af, tn + 1
			end
			for i=1,3 do
				local a = C_Garrison.GetFollowerAbilityAtIndex(fid, i)
				a = a and a > 0 and C_Garrison.GetFollowerAbilityCounterMechanicInfo(a)
				if a then
					fi.counters[cn], cn = a, cn + 1
				end
				a = C_Garrison.GetFollowerTraitAtIndex(fid, i)
				if a and a > 0 then
					fi.traits[tn], tn, fi.saffinity = a, tn + 1, a == af or fi.saffinity or nil
				end
			end
			ft[nf], fi.active, fi.working = fi, fi.status ~= GARRISON_FOLLOWER_INACTIVE and 1 or 0, fi.status == GARRISON_FOLLOWER_WORKING and 1 or 0
		end
	end
	f = ft
	
	local ms, best = {}, {}
	for i=1,#missions do
		local sz = missions[i][3]
		local t = ms[sz] or {}
		t[#t+1], ms[sz], best[missions[i][1]] = missions[i], t, {-1}
	end

	local counters, traits, m2, m3 = {}, {[221]=0, [79]=0, [77]=0, [76]=0, [244]=0, [201]=0, [202]=0, [232]=0}, ms[2], ms[3]
	local n2, n3, s1, s2, ec = #m2, #m3, 17592186044416, 68719476736, T.EnvironmentCounters
	for a=1,nf do
		local fa = f[a]
		for i=1,2 do
			local s, t = fa[i == 1 and "counters" or "traits"], i == 1 and counters or traits
			for i=1,#s do
				local v = s[i]
				t[v] = (t[v] or 0) + 1
			end
		end
		local na, nw = fa.active, fa.working
					
		for b=a+1,nf do
			local fb = f[b]
			local na, nw = na + fb.active, nw + fb.working
			
			local mi, mic, c = m2, n2
			repeat
				local fc = f[c or b]
				local ns, na, nw = traits[79], na + (c and fc.active or 0), nw + (c and fc.working or 0)
				for i=1,2 do
					local s, t = fc[i == 1 and "counters" or "traits"], i == 1 and counters or traits
					for i=1,#s do
						local v = s[i]
						t[v] = (t[v] or 0) + 1
					end
				end
				
				for i=1, mic do
					local mi, l, lc = mi[i]
					local etc, cap = ec[mi[6]], (#mi-6)*6
					local nc, d = (etc ~= 0 and traits[etc] or 0) > 0 and (etc == 42 and 1 or 2) or (etc == 4 and traits[244] > 0 and 2) or 0, mi[4]*2^-traits[221]
					for i=7,#mi do
						local c = mi[i]
						local need = (l == c and 1 or 0)
						local cs = (counters[c] or 0) > need and 6 or 0
						nc, l, lc = nc + cs + (c == 6 and cs == 0 and traits[232] > (need - (need == 1 and lc > 0 and 1 or 0)) and 3 or 0), c, cs
					end
					nc = nc + traits[(d >= 25200) and 76 or 77]*2 + traits[201]*2 + traits[202]*4
					if nc < cap then
						local ra, rb, rc = fa.affinity or 0, fb.affinity, c and fc.affinity
						local sa, sb, sc = fa.saffinity, fb.saffinity, fc.saffinity
						if ra == rc or rb == rc then rc, sc = nil end
						if ra == rb or not rb then rb, sb, rc, sc = rc, sc end
						repeat
							local nt, nf = traits[ra] or 0, traits[-ra] or 0
							if nt == 0 or ra == 0 or nf == 0 then
							elseif nf > 1 then
								nc = nc + nt*3
							else
								nc = nc + (nt - (sa and 1 or 0))*3
							end
							ra, rb, sa, sb, rc = rb, rc, sb, sc
						until nc >= cap or not ra
					end
					nc = nc > cap and cap or nc
					
					local best, sc = best[mi[1]], nc * s1
					if best[1] - sc < s1 then
						local mlvl, la, lb, lc = mi[2], fa.iLevel + fb.level*3, fb.iLevel + fb.level*3, fc.iLevel + fc.level*3
						mlvl = mlvl > 100 and (mlvl + 300) or (600 + mlvl * 3)
						local gap = (mlvl > la and (mlvl - la) or 0) + (mlvl > lb and (mlvl - lb) or 0) + (c and mlvl > lc and (mlvl - lc) or 0)
						sc = sc + s2 * ((mi[5] > 0 and ns * 16 or 0) + na) + (32768-gap)*16 + traits[221]*4 + (3-nw)
						if best[1] < sc then
							best[1], best[2], best[3], best[4] = sc, a, b, c
						end
					end
				end
				
				for i=1,c and 2 or 0 do
					local s, t = fc[i == 1 and "counters" or "traits"], i == 1 and counters or traits
					for i=1,#s do
						local v = s[i]
						t[v] = t[v] - 1
					end
				end
				
				c, mi, mic = (c or b) + 1, m3, n3
			until c > nf

			for i=1,2 do
				local s, t = fb[i == 1 and "counters" or "traits"], i == 1 and counters or traits
				for i=1,#s do
					local v = s[i]
					t[v] = t[v] - 1
				end
			end
		end
		
		for i=1,2 do
			local s, t = fa[i == 1 and "counters" or "traits"], i == 1 and counters or traits
			for i=1,#s do
				local v = s[i]
				t[v] = t[v] - 1
			end
		end
	end
	
	for i=1,#missions do
		local best = best[missions[i][1]]
		if best and best[1] > 0 then
			wipe(counters) wipe(traits)
			local bt, mi, l = {}, missions[i]
			for i=1, mi[3] do
				local fi = f[best[1+i]]
				bt[i] = fi.followerID
				for i=1,2 do
					local s, t = fi[i == 1 and "counters" or "traits"], i == 1 and counters or traits
					for i=1,#s do
						local v = s[i]
						t[v] = (t[v] or 0) + 1
					end
				end
			end
			bt[4], bt[5] = traits[79] or 0, (floor(best[1]/s1) + mi[3]*2)/((#mi-6)*6 + mi[3]*2)
			for i=7,#mi do
				local c = mi[i]
				local v, d = counters[c] or 0, l == c and 2 or 1
				bt[i], l = v > d and 2 or v == d, c
			end
			missions[i].best = bt
		else
			missions[i].best = nil
		end
	end
end

T.Garrison = api