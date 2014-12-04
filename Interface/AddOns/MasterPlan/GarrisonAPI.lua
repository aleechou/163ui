local api, _, T = {}, ...
local EV, L = T.Evie, T.L

local f, data, mechanics = CreateFrame("Frame"), {}, {}
f:SetScript("OnUpdate", function() wipe(data) f:Hide() end)
hooksecurefunc(C_Garrison, "StartMission", function() wipe(data) end)

local unfreeStatusOrder = {[GARRISON_FOLLOWER_WORKING]=2, [GARRISON_FOLLOWER_INACTIVE]=1}

local parseTime = {} do
	local captures = {} do
		local function proc(fm, f, s)
			local t, pat = nil, fm:gsub("%%d", "\0"):gsub("[()%[%].%-+*%%]", "%%%0")
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

local function populateMechanics()
	local q = C_Garrison.GetFollowerAbilityCounterMechanicInfo
	for _, aid in pairs({11, 100, 168, 148, 160, 101, 105, 157, 122}) do
		local mid, _, tex = q(aid)
		mechanics[mid], mechanics[tex:lower():gsub("%.blp$","")] = aid, aid
	end
end
local function AddCounterMechanic(fit, fabid)
	if fabid and fabid > 0 then
		if C_Garrison.GetFollowerAbilityIsTrait(fabid) then
			fit.traits[fabid] = fabid
		end
		local mid, _, tex = C_Garrison.GetFollowerAbilityCounterMechanicInfo(fabid)
		if tex then
			fit.counters[mid], mechanics[mid], mechanics[tex:lower():gsub("%.blp$","")] = fabid, fabid, fabid
		end
	end
end
function api.GetFollowerInfo(refresh)
	if not data.followers or refresh then
		local ft = {}
		local t = C_Garrison.GetFollowers()
		for i=1,#t do
			local v = t[i]
			if v.isCollected then
				local fid, fit = v.followerID, v
				v.counters, v.traits, v.isCombat = {}, {}, v.isCollected and not unfreeStatusOrder[v.status] or false
				if v.status == nil and MasterPlan and MasterPlan:GetFollowerTentativeMission(v.followerID) then
					v.status = L"In Tentative Party"
				end
				for i=1,4 do
					AddCounterMechanic(fit, C_Garrison.GetFollowerAbilityAtIndex(fid, i))
					AddCounterMechanic(fit, C_Garrison.GetFollowerTraitAtIndex(fid, i))
				end
				ft[fid] = fit
			end
		end
		for k, v in pairs(C_Garrison.GetInProgressMissions()) do
			for i=1,#v.followers do
				local f = ft[v.followers[i]]
				f.mission, f.missionTimeLeft, f.missionTimeSeconds = v.missionID, v.timeLeft, parseTime[v.timeLeft]
			end
		end
		data.followers = ft
		f:Show()
	end
	return data.followers
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
			for k,v in pairs(info.counters) do
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
		end
		data.traits = ci
		f:Show()
	end
	return data.traits
end
function api.GetMechanicInfo(mid)
	if populateMechanics then
		populateMechanics = populateMechanics()
	end
	if not mechanics[mid] then api.GetFollowerInfo() end
	if mechanics[mid] then
		return C_Garrison.GetFollowerAbilityCounterMechanicInfo(mechanics[mid])
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
			if ac == bc then
				ac, bc = af.level or 0, bf.level or 0
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
	return 0
end
function api.GetFollowerLevelDescription(fid, mlvl, finfo)
	local finfo, q = finfo or api.GetFollowerInfo()[fid], C_Garrison.GetFollowerQuality(fid)
	local tooLow = api.GetLevelEfficiency(api.GetFMLevel(finfo), mlvl) == 0
	local lc, away = ITEM_QUALITY_COLORS[tooLow and 0 or q].hex, finfo.missionTimeLeft
	if finfo.status == GARRISON_FOLLOWER_INACTIVE then
		away = RED_FONT_COLOR_CODE .. " (" .. GARRISON_FOLLOWER_INACTIVE .. ")"
	elseif finfo.status == GARRISON_FOLLOWER_WORKING then
		away = YELLOW_FONT_COLOR_CODE .. " (" .. GARRISON_FOLLOWER_WORKING .. ")"
	else
		away = away and ("|cffa0a0a0 (" .. away .. ")") or ""
	end
	return ("%s[%d]|r %s%s|r%s"):format(lc, finfo.level < 100 and finfo.level or finfo.iLevel, HIGHLIGHT_FONT_COLOR_CODE, finfo.name, away)
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
	local curStack, curRewards, curFollowers, curCallback, curLog
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
						lastAction, curLog[#curLog+1] = GetTime(), {GetTime(), "DELAY", state}
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
			curState, curStack, curRewards, curFollowers, curIndex, curCallback, delayMID, delayIndex, curLog = nil
		end
	end
	function completionStep(ev, ...)
		if not curState then return end
		local mi = curStack[curIndex]
		while mi and (mi.succeeded or mi.failed) do
			mi, curIndex = curStack[curIndex+1], curIndex + 1
		end
		curLog[#curLog+1] = {GetTime(), curState, curIndex, ev, ...}
		if (ev == "GARRISON_MISSION_NPC_CLOSED" and mi) or not mi then
			curState, MasterPlanLog, curLog[#curLog+1] = mi and "ABORT" or "DONE", MasterPlanLog or {}, {GetTime(), mi and "ABORT" or "DONE", curRewards, curFollowers}
			table.insert(MasterPlanLog, curLog)
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
				securecall(curCallback, "STEP", curStack, curRewards, curFollowers)
				if ok then
					delayIndex, delayMID = curIndex, mi.missionID
					delayRoll(0.2)
				else
					C_Timer.After(0.25, delayStep)
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
				securecall(curCallback, "STEP", curStack, curRewards, curFollowers)
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
		curStack, curCallback, curRewards, curFollowers, curLog = stack, callback, {}, {}, {}
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
	local dt, time do
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
		for i=1,#avail do
			local mi = avail[i]
			dt[mi.missionID], seen[mi.missionID] = dt[mi.missionID] or now, 1
		end
		if #avail > 0 then
			for k in pairs(dt) do
				if not seen[k] then
					dt[k] = nil
				end
			end
		end
	end
	function api.GetMissionSeen(mid)
		local now = time()
		return difftime(now, dt and dt[mid] or now), expire[mid]
	end
	function T._SetMissionSeenTable(t)
		dt = t
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
end

do -- PrepareAllMissionGroups/GetMissionGroups {sc xp gr ti p1 p2 p3 xp pb}
	local msf, msi, msd, mmi = {}, {}, {}
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
		if not trustValid then
			local finfo, valid, fn = api.GetFollowerInfo(), true, 1
			for k,v in pairs(finfo) do
				if v.isCollected and v.status ~= GARRISON_FOLLOWER_INACTIVE then
					local key = v.level .. "#" .. v.iLevel .. "#" .. (v.status or ".")
					for i=1,4 do
						key = key .. "#" .. (C_Garrison.GetFollowerAbilityAtIndex(k, i) or 0) .. "#" .. (C_Garrison.GetFollowerTraitAtIndex(k, i) or 0)
					end
					msi[fn], fn, msf[k], valid = k, fn+1, key, valid and msf[k] == key
				end
			end
			for i=fn,#msi do
				valid, msi[i] = false
			end
			for k,v in pairs(msf) do
				if not (finfo[k] and finfo[k].isCollected and finfo[k].status ~= GARRISON_FOLLOWER_INACTIVE) then
					valid, msf[k] = false
				end
			end
			if not valid then wipe(msd) end
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
				m[mn], mn = {successChance, baseXP+xpBonus, garrisonResources*materialMultiplier*successChance/100, totalTimeSeconds, msi[t[i1]], msi[t[i2]], msi[t[i3]], chestXP, next(partyBuffs) and partyBuffs}, mn + 1
			until t[1] == fm[1] and t[2] == fm[2] and t[3] == fm[3]
			
			for i=1,nf do
				C_Garrison.RemoveFollowerFromMission(mid, msi[t[i]])
			end
			
			msd[mid] = m
			releaseFollowerEvents()
		end
		return msd[mid]
	end
end
function api.GetFilteredMissionGroups(minfo, filter, cmp, limit)
	local mg = api.GetMissionGroups(minfo.missionID)
	local best, finfo, sorted = {}, api.GetFollowerInfo(), false
	for i=1,#mg do
		if filter == nil or filter(mg[i], finfo, minfo) then
			local this = mg[i]
			if not limit or best[limit] == nil then
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
	end
	if not sorted then
		table.sort(best, function(a,b) return cmp(a, b, finfo, minfo) end)
	end
	return best
end
api.GroupRank, api.GroupFilter = {}, {}
function api.GetBuffsXPMultiplier(buffs)
	local mul = 1
	for i=1,#buffs do
		local v = buffs[i]
		if v == 80 or v == 236 then
			mul = mul + 0.35
		end
	end
	return mul
end
function api.GetFollowerXPMultiplier(fi, mlvl)
	local ef = api.GetLevelEfficiency(api.GetFMLevel(fi), mlvl)
	if fi.quality == 4 and fi.level == 100 then
		return 0
	elseif fi.followerID and not fi.traits then
		fi = api.GetFollowerInfo()[fi.followerID]
	end
	return (ef == 0 and 0.1 or ef) * (fi.traits[29] and 1.50 or 1)
end
local computeTotalXP do
	function computeTotalXP(g, finfo, minfo, force)
		if not g.totalXP or force then
			local mlvl, bonus = api.GetFMLevel(minfo), g[8]
			local mxp = g[2] + g[1]/100 * bonus * (bonus > 0 and g[9] and api.GetBuffsXPMultiplier(g[9]) or 1)
			
			local xp = 0
			for i=1, minfo.numFollowers do
				xp = xp + api.GetFollowerXPMultiplier(finfo[g[4+i]], mlvl) * mxp
			end
			g.totalXP = xp
		end
		return g.totalXP
	end
end
local function computeEarliestDeparture(g, finfo, minfo, force)
	local ret = g.earliestDeparture
	if not ret or force then
		ret = 0
		for i=5, 4+minfo.numFollowers do
			local f = finfo[g[i]]
			if f.status == GARRISON_FOLLOWER_ON_MISSION then
				local t = f.missionTimeSeconds or math.huge
				if t > ret then
					ret = t
				end
			end
		end
		g.earliestDeparture = ret or math.huge
	end
	return ret or math.huge
end
api.GroupRank = {} do
	local function success(a, b, finfo, minfo)
		local ac, bc = a[1], b[1]
		if ac == bc then
			ac, bc = -computeEarliestDeparture(a, finfo, minfo), -computeEarliestDeparture(a, finfo, minfo)
		end
		if ac == bc then
			ac, bc = computeTotalXP(a, finfo, minfo), computeTotalXP(b, finfo, minfo)
		end
		if ac == bc  then
			ac, bc = a[4], b[4]
		end
		if ac == bc then
			ac, bc = a[3], b[3]
		end
		return ac >= bc
	end
	local function res(a, b, finfo, minfo)
		if a[3] ~= b[3] then return a[3] > b[3] end
		return success(a,b, finfo, minfo)
	end
	local function xp(a, b, finfo, minfo)
		local ac, bc = computeTotalXP(a, finfo, minfo), computeTotalXP(b, finfo, minfo)
		if ac == bc then
			return success(a,b, finfo, minfo)
		end
		return ac > bc
	end
	api.GroupRank.threats, api.GroupRank.resources, api.GroupRank.xp = success, res, xp
end
function api.GroupFilter.IDLE(res, finfo, minfo)
	for i=5,4+minfo.numFollowers do
		local fi = finfo[res[i]]
		if not (fi and (fi.status == nil or fi.status == GARRISON_FOLLOWER_IN_PARTY)) then
			return false
		end
	end
	return true
end
function api.GroupFilter.COMBAT(res, finfo, minfo)
	for i=5,4+minfo.numFollowers do
		local fi = finfo[res[i]]
		if not (fi and (fi.status == nil or fi.status == GARRISON_FOLLOWER_IN_PARTY or fi.status == GARRISON_FOLLOWER_ON_MISSION)) then
			return false
		end
	end
	return true
end
function api.GroupFilter.ACTIVE(res, finfo, minfo)
	for i=5,4+minfo.numFollowers do
		local fi = finfo[res[i]]
		if not (fi and fi.status ~= GARRISON_FOLLOWER_INACTIVE) then
			return false
		end
	end
	return true
end
function api.AnnotateMissionParty(party, finfo, minfo, force)
	finfo = finfo or api.GetFollowerInfo()
	computeTotalXP(party, finfo, minfo)
	computeEarliestDeparture(party, finfo, minfo, force)
end
function api.HasSignificantRewards(mi)
	if mi.rewards then
		local allGR, allXP = true, true
		for _, r in pairs(mi.rewards) do
			if not (r.followerXP or (r.currencyID == 0 and r.quantity < 1000000)) then
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

do -- GetUpgradeItems(ilevel, isArmor)
	local upgrades = {
		WEAPON={114128, 650, 114129, 650, 114131, 650, 114616, 615, 114081, 630, 114622, 645},
		ARMOR={114745, 650, 114808, 650, 114822, 650, 114807, 615, 114806, 630, 114746, 645}
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

T.Garrison = api