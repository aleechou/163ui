local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local toc=select(4,GetBuildInfo())
local me, ns = ...
local pp=print
if (LibDebug) then LibDebug() end
local L=LibStub("AceLocale-3.0"):GetLocale(me,true)
local C=LibStub("AlarCrayon-3.0"):GetColorTable()
local addon=LibStub("AlarLoader-3.0")(__FILE__,me,ns):CreateAddon(me,true) --#Addon
local print=ns.print or print
local debug=ns.debug or print
local dump=ns.dump or print
--[===[@debug@
ns.debugEnable('on')
local function tcopy(obj, seen)
	if type(obj) ~= 'table' then return obj end
	if seen and seen[obj] then return seen[obj] end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do res[tcopy(k, s)] = tcopy(v, s) end
	return res
end
--@end-debug@]===]
-----------------------------------------------------------------
-- Recycling function from ACE3
----newcount, delcount,createdcount,cached = 0,0,0
local new, del, copy
do
	local pool = setmetatable({},{__mode="k"})
	function new()
		--newcount = newcount + 1
		local t = next(pool)
		if t then
			pool[t] = nil
			return t
		else
			--createdcount = createdcount + 1
			return {}
		end
	end
	function copy(t)
		local c = new()
		for k, v in pairs(t) do
			c[k] = v
		end
		return c
	end
	function del(t)
		--delcount = delcount + 1
		wipe(t)
		pool[t] = true
	end
--	function cached()
--		local n = 0
--		for k in pairs(pool) do
--			n = n + 1
--		end
--		return n
--	end
end
local function capitalize(s)
	s=tostring(s)
	return strupper(s:sub(1,1))..strlower(s:sub(2))
end
local masterplan
local followers
local successes={}
local requested={}
local availableFollowers=0
local GMF
local GMFFollowers
local GMFMissions
local GMFTab1
local GMFTab2
local GMFMissionsTab1
local GMFMissionsTab2
local GARRISON_FOLLOWER_WORKING=GARRISON_FOLLOWER_WORKING -- "Working
local GARRISON_FOLLOWER_ON_MISSION=GARRISON_FOLLOWER_ON_MISSION -- "On Mission"
local GARRISON_FOLLOWER_INACTIVE=GARRISON_FOLLOWER_INACTIVE --"Inactive"
local GARRISON_FOLLOWER_EXHAUSTED=GARRISON_FOLLOWER_EXHAUSTED -- "Recovering (1 Day)"
local GARRISON_BUILDING_SELECT_FOLLOWER_TITLE=GARRISON_BUILDING_SELECT_FOLLOWER_TITLE -- "Select a Follower";
local GARRISON_BUILDING_SELECT_FOLLOWER_TOOLTIP=GARRISON_BUILDING_SELECT_FOLLOWER_TOOLTIP -- "Click here to assign a Follower";
local GARRISON_FOLLOWER_CAN_COUNTER=GARRISON_FOLLOWER_CAN_COUNTER -- "This follower can counter:"
local GARRISON_MISSION_SUCCESS=GARRISON_MISSION_SUCCESS -- "Success"
local GARRISON_MISSION_TOOLTIP_NUM_REQUIRED_FOLLOWERS=GARRISON_MISSION_TOOLTIP_NUM_REQUIRED_FOLLOWERS -- "%d Follower mission";
local UNKNOWN_CHANCE=GARRISON_MISSION_PERCENT_CHANCE:gsub('%%d%%%%',UNKNOWN)
local GARRISON_MISSION_PERCENT_CHANCE=GARRISON_MISSION_PERCENT_CHANCE .. " (预估)"
local BUTTON_INFO=GARRISON_MISSION_TOOLTIP_NUM_REQUIRED_FOLLOWERS.. " " .. GARRISON_MISSION_PERCENT_CHANCE
local GARRISON_FOLLOWERS=GARRISON_FOLLOWERS -- "Followers"
local GARRISON_PARTY_NOT_FULL_TOOLTIP=GARRISON_PARTY_NOT_FULL_TOOLTIP -- "You do not have enough followers on this mission."
local AVAILABLE=AVAILABLE -- "Available"
local PARTY=PARTY -- "Party"
local ENVIRONMENT_SUBHEADER=ENVIRONMENT_SUBHEADER -- "Environment"
local SPELL_TARGET_TYPE4_DESC=capitalize(SPELL_TARGET_TYPE4_DESC) -- party member
local SPELL_TARGET_TYPE1_DESC=capitalize(SPELL_TARGET_TYPE1_DESC) -- any
local ANYONE='('..SPELL_TARGET_TYPE1_DESC..')'
local IGNORE_UNAIVALABLE_FOLLOWERS=IGNORE.. ' ' .. UNAVAILABLE .. ' ' .. GARRISON_FOLLOWERS
local IGNORE_UNAIVALABLE_FOLLOWERS_DETAIL=IGNORE.. ' ' .. GARRISON_FOLLOWER_INACTIVE .. ',' .. GARRISON_FOLLOWER_ON_MISSION ..',' .. GARRISON_FOLLOWER_WORKING.. ','.. GARRISON_FOLLOWER_EXHAUSTED .. ' ' .. GARRISON_FOLLOWERS
IGNORE_UNAIVALABLE_FOLLOWERS=capitalize(IGNORE_UNAIVALABLE_FOLLOWERS)
IGNORE_UNAIVALABLE_FOLLOWERS_DETAIL=capitalize(IGNORE_UNAIVALABLE_FOLLOWERS_DETAIL)
local GameTooltip=GameTooltip
local GetItemQualityColor=GetItemQualityColor
local timers={}
function addon:AddLine(icon,name,status,quality,...)
	local r2,g2,b2=C.Red()
	local q=ITEM_QUALITY_COLORS[quality or 1] or {}
	if (status==AVAILABLE) then
		r2,g2,b2=C.Green()
	elseif (status==GARRISON_FOLLOWER_WORKING) then
		r2,g2,b2=C.Orange()
	end
	--GameTooltip:AddDoubleLine(name, status or AVAILABLE,r,g,b,r2,g2,b2)
	--GameTooltip:AddTexture(icon)
	GameTooltip:AddDoubleLine(icon and "|T" .. tostring(icon) .. ":0|t  " .. name or name, status,q.r,q.g,q.b,r2,g2,b2)
end
function addon:GetDifficultyColor(perc)
	local difficulty='trivial'
	if(perc >90) then
		difficulty='standard'
	elseif (perc >74) then
		difficulty='difficult'
	elseif(perc>49) then
		difficulty='verydifficult'
	elseif(perc >20) then
		difficulty='impossible'
	end
	return QuestDifficultyColors[difficulty]
end
function addon:RestoreTooltip()
	local self = GMF.MissionTab.MissionList;
	local scrollFrame = self.listScroll;
	local buttons = scrollFrame.buttons;
	for i =1,#buttons do
		buttons[i]:SetScript("OnEnter",GarrisonMissionButton_OnEnter)
	end
end
-- This is a ugly hack while I rewrite this code for 2.0
function addon:TooltipAdder(missionID,skipTT)
--[===[@debug@
	if (not skipTT) then GameTooltip:AddLine("ID:" .. tostring(missionID)) end
--@end-debug@]===]
	self:GetRunningMissionData()
	local perc=select(4,C_Garrison.GetPartyMissionInfo(missionID))
	local q=self:GetDifficultyColor(perc)
	if (not skipTT) then GameTooltip:AddDoubleLine(GARRISON_MISSION_SUCCESS,format(GARRISON_MISSION_PERCENT_CHANCE,perc),nil,nil,nil,q.r,q.g,q.b) end
	local buffed=new()
	local traited=new()
	local buffs=new()
	local traits=new()
	local fellas=new()
	availableFollowers=0
	for id,d in pairs(C_Garrison.GetBuffedFollowersForMission(missionID)) do
		buffed[id]=d
	end
	for id,d in pairs(C_Garrison.GetFollowersTraitsForMission(missionID)) do
		for x,y in pairs(d) do
--[===[@debug@
			self.db.global.traits[y.traitID]=y.icon
--@end-debug@]===]
			if (y.traitID~=236) then --Ignore hearthstone traits
				traited[id]=d
				break
			end
		end
	end
	local followerList=GarrisonMissionFrameFollowers.followersList

	for j=1,#followerList do
		local index=followerList[j]
		local follower=followers[index]
		follower.rank=follower.level < 100 and follower.level or follower.iLevel
		if (not follower.isCollected) then break end
		if (not follower.status) then
			availableFollowers=availableFollowers+1
		end
		if (follower.status and self:GetBoolean('IGM')) then
		else
			local id=follower.followerID
			local b=buffed[id]
			local t=traited[id]
			local followerBias = C_Garrison.GetFollowerBiasForMission(missionID,id);
			follower.bias=followerBias
			local formato=C("%3d","White")
			if (followerBias==-1) then
				formato=C("%3d","Red")
			elseif (followerBias < 0) then
				formato=C("%3d","Orange")
			end
			formato=formato.." %s"
--[===[@debug@
			formato=formato .. " 0x+(0*8)  " .. id:sub(11)
--@end-debug@]===]
			if (b) then
				if (not buffs[id]) then
					buffs[id]={rank=follower.rank,simple=follower.name,name=format(formato,follower.rank,follower.name),quality=follower.quality,status=(follower.status or AVAILABLE)}
				end
				for _,ability in pairs(b) do
					buffs[id].name=buffs[id].name .. " |T" .. tostring(ability.icon) .. ":0|t"
					if (not follower.status) then
						local aname=ability.name
						if (not fellas[aname]) then
							fellas[aname]={}
						end
						fellas[aname]={id=follower.followerID,rank=follower.rank,level=follower.level,iLevel=follower.iLevel,name=follower.name}
					end
				end
			end
			if (t) then
				if (not traits[id]) then
					traits[id]={rank=follower.rank,simple=follower.name,name=format(formato,follower.rank,follower.name),quality=follower.quality,status=follower.status or AVAILABLE}
				end
				for _,ability in pairs(t) do
					traits[id].name=traits[id].name .. " |T" .. tostring(ability.icon) .. ":0|t"
				end
			end
		end
	end
	local added=new()
	local maxfollowers=C_Garrison.GetMissionMaxFollowers(missionID)
	requested[missionID]=maxfollowers
	local partyshown=false
	local perc=0
	if (next(traits) or next(buffs) ) then
		if (not skipTT) then GameTooltip:AddLine(GARRISON_FOLLOWER_CAN_COUNTER) end
		for id,v in pairs(buffs) do
			local status=(v.status == GARRISON_FOLLOWER_ON_MISSION and (timers[id] or GARRISON_FOLLOWER_ON_MISSION)) or v.status
			if (not skipTT) then self:AddLine(nil,v.name,status,v.quality) end
		end
		for id,v in pairs(traits) do
			local status=(v.status == GARRISON_FOLLOWER_ON_MISSION and (timers[id] or GARRISON_FOLLOWER_ON_MISSION)) or v.status
			if (not skipTT) then self:AddLine(nil,v.name,status,v.quality) end
		end
		if (not skipTT) then GameTooltip:AddLine(PARTY,C.White()) end
		partyshown=true
		local enemies = select(8,C_Garrison.GetMissionInfo(missionID))
		--local missionInfo=C_Garrison.GetBasicMissionInfo(missionID)
--[===[@debug@
		--DevTools_Dump(fellas)
--@end-debug@]===]
		for _,enemy in pairs(enemies) do
			for i,mechanic in pairs(enemy.mechanics) do
--[===[@debug@
				self.db.global.abilities[i .. '.' .. mechanic.name]=mechanic.description
--@end-debug@]===]
				local menace=mechanic.name
				local res
				if (fellas[menace]) then
					local followerID=fellas[menace].id
					res=fellas[menace].name
					local rc,code=pcall(C_Garrison.AddFollowerToMission,missionID,followerID)
					if (rc and code) then
						tinsert(added,followerID)
					end
				end
				if (not skipTT) then
					if (res) then
						GameTooltip:AddDoubleLine(menace,res,0,1,0)
					else
						GameTooltip:AddDoubleLine(menace,' ',1,0,0)
					end
				end
			end
		end
		perc=select(4,C_Garrison.GetPartyMissionInfo(missionID))
		if (perc < 100 and  #added < maxfollowers and next(traits))  then
			for id,v in pairs(traits) do
				local rc,code=pcall(C_Garrison.AddFollowerToMission,missionID,id)
				if (rc and code) then
					tinsert(added,id)
					if (not skipTT) then GameTooltip:AddDoubleLine(ENVIRONMENT_SUBHEADER,v.simple,v.quality) end
					break
				end
			end
			perc=select(4,C_Garrison.GetPartyMissionInfo(missionID))
		end
	end
	-- And then fill the roster
	local partysize=#added
	if (partysize < maxfollowers )  then
		for j=1,#followerList do
			local index=followerList[j]
			local follower=followers[index]
			if (not follower.isCollected) then
				break
			end
			if (follower.status and self:GetBoolean('IGM')) then
			else
				local rc,code=pcall(C_Garrison.AddFollowerToMission,missionID,follower.followerID)
				if (rc and code) then
					if (not partyshown) then
						if (not skipTT) then GameTooltip:AddLine(PARTY,1) end
						partyshown=true
					end
					tinsert(added,follower.followerID)
					if (not skipTT) then
						GameTooltip:AddDoubleLine(SPELL_TARGET_TYPE4_DESC,follower.name,C.Orange.r,C.Orange.g,C.Orange.b)--SPELL_TARGET_TYPE1_DESC)
					end
					if (#added >= maxfollowers) then break end
				else
--[===[@debug@
					print("Failed adding",follower.name,follower.followerID,rc,code)
--@end-debug@]===]
				end
			end
		end
		perc=select(4,C_Garrison.GetPartyMissionInfo(missionID))
	end
	local q=self:GetDifficultyColor(perc)
	if (not partyshown) then
		if (not skipTT) then GameTooltip:AddDoubleLine(PARTY,ANYONE,C.White.r,C.White.g,C.White.b) end
	end
	if (not skipTT) then GameTooltip:AddDoubleLine(GARRISON_MISSION_SUCCESS,format(GARRISON_MISSION_PERCENT_CHANCE,perc),nil,nil,nil,q.r,q.g,q.b) end
	local b=GameTooltip:GetOwner()
	successes[missionID]=perc
	if (availableFollowers < maxfollowers) then
		if (not skipTT) then GameTooltip:AddLine(GARRISON_PARTY_NOT_FULL_TOOLTIP,C:Red()) end
	else
	end
	--if (not skipTT) then self:AddPerc(GameTooltip:GetOwner()) end
	for _,id in pairs(added) do
		local rc,code=pcall(C_Garrison.RemoveFollowerFromMission,missionID,id)
--[===[@debug@
		if (not rc) then print("Add",rc,code) end
--@end-debug@]===]
	end
	-- Add a signature
	--local r,g,b=C:Silver()
	--GameTooltip:AddDoubleLine("GarrisonCommander",self.version,r,g,b,r,g,b)
	del(added)
--[===[@debug@
	--DevTools_Dump(fellas)
--@end-debug@]===]
	del(buffed)
	del(traited)
	del(buffs)
	del(traits)
	del(fellas)
end
function addon:FillFollowersList()
	if (GarrisonFollowerList_UpdateFollowers) then
		GarrisonFollowerList_UpdateFollowers(GarrisonMissionFrame.FollowerList)
	end
end
function addon:CacheFollowers()
	followers=C_Garrison.GetFollowers()
end
function addon:GetRunningMissionData()
--[===[@debug@
	print("Mission timer refresh")
--@end-debug@]===]
	local list=GarrisonMissionFrame.MissionTab.MissionList
	C_Garrison.GetInProgressMissions(list.inProgressMissions);
	--C_Garrison.GetAvailableMissions(list.availableMissions);
	if (#list.inProgressMissions > 0) then
		for i,mission in pairs(list.inProgressMissions) do
			for _,id in pairs(mission.followers) do
				timers[id]=mission.timeLeft
			end
		end
	end
end
function addon:ADDON_LOADED(event,addon)
	if (addon=="Blizzard_GarrisonUI") then
		self:UnregisterEvent("ADDON_LOADED")
		self:Init()
	end
end

function addon:ApplyMOVEPANEL(value)
	if (not GMF) then return end
	if (value) then
		GMF:SetMovable(true)
		GMF:RegisterForDrag("LeftButton")
		GMF:SetScript("OnDragStart",function(frame) frame:StartMoving() end)
		GMF:SetScript("OnDragStop",function(frame) frame:StopMovingOrSizing() end)
	else
		GMF:SetScript("OnDragStart",nil)
		GMF:SetScript("OnDragStop",nil)
		GMF:ClearAllPoints()
		GMF:SetPoint("CENTER",UIParent)
		GMF:SetMovable(false)
	end
end
function addon:OnInitialized()
--[===[@debug@
	LoadAddOn("Blizzard_DebugTools")
--@end-debug@]===]
	self.OptionsTable.args.on=nil
	self.OptionsTable.args.off=nil
	self.OptionsTable.args.standby=nil
	self:RegisterEvent("ADDON_LOADED")
	self:AddToggle("MOVEPANEL",true,L["使要塞任务窗口可移动"]).width="full"
	self:AddToggle("IGM",false,IGNORE_UNAIVALABLE_FOLLOWERS,IGNORE_UNAIVALABLE_FOLLOWERS_DETAIL).width="full"
	self:loadHelp()
	self.DbDefaults.global["*"]={}
	self.db:RegisterDefaults(self.DbDefaults)
	return true
end

function addon:ScriptTrace(hook,frame,...)
--[===[@debug@
	print("Triggered " .. C(hook,"red").." script on",C(frame,"Azure"),...)
--@end-debug@]===]
end
function addon:AddPerc(b,...)
	if (b and b.info and b.info.missionID and b.info.missionID ) then
		if (GMF.MissionTab.MissionList.showInProgress) then
			if (b.ProgressHidden) then
				return
			else
				b.ProgressHidden=true
				if (b.Success) then
					b.Success:Hide()
				end
				if (b.NotEnough) then
					b.NotEnough:Hide()
				end
				return
			end

		end
		if (b:GetName()=="GarrisonMissionFrameMissionsListScrollFrameButton1") then
			self:SetUp()
		end
		local missionID=b.info.missionID
		local Perc=successes[missionID] or -2
		if (not b.Success) then
			b.Success=b:CreateFontString()
			if (masterplan) then
				b.Success:SetFontObject("GameFontNormal")
			else
				b.Success:SetFontObject("GameFontNormalLarge2")
			end
			b.Success:SetPoint("BOTTOMLEFT",b.Title,"TOPLEFT",0,3)
		end
		if (not b.NotEnough) then
			b.NotEnough=b:CreateFontString()
			if (masterplan) then
				b.NotEnough:SetFontObject("GameFontNormal")
				b.NotEnough:SetPoint("TOPLEFT",b.Title,"BOTTOMLEFT",150,-3)
			else
				b.NotEnough:SetFontObject("GameFontNormalSmall2")
				b.NotEnough:SetPoint("TOPLEFT",b.Title,"BOTTOMLEFT",0,-3)
			end
			b.NotEnough:SetText("(".. GARRISON_PARTY_NOT_FULL_TOOLTIP .. ")")
			b.NotEnough:SetTextColor(C:Red())
		end
		if (Perc <0 and not b:IsMouseOver()) then
			self:TooltipAdder(missionID,true)
			Perc=successes[missionID] or -2
		end
		if (Perc>=0) then
			if (masterplan) then
				b.Success:SetFormattedText(GARRISON_MISSION_PERCENT_CHANCE,successes[missionID])
			else
				b.Success:SetFormattedText(BUTTON_INFO,C_Garrison.GetMissionMaxFollowers(missionID),successes[missionID])
			end
			local q=self:GetDifficultyColor(successes[missionID])
			b.Success:SetTextColor(q.r,q.g,q.b)
		else
			b.Success:SetText(UNKNOWN_CHANCE)
			b.Success:SetTextColor(1,1,1)
		end
		b.Success:Show()
		if (not requested[missionID]) then
			requested[missionID]=C_Garrison.GetMissionMaxFollowers(missionID)
		end
		if (requested[missionID]>availableFollowers) then
			b.NotEnough:Show()
		else
			b.NotEnough:Hide()
		end
		b.ProgressHidden=false
	end
end
function addon:CleanUp()
	collectgarbage("step",10)
end
function addon:SetUp(full)
	if (GMF.MissionTab.MissionList.showInProgress) then return end
	local start=GetTime()
--[===[@debug@
	print("Addon setup",full and "full" or "simple")
--@end-debug@]===]
	self:CacheFollowers()
	local list=GarrisonMissionFrame.MissionTab.MissionList
	C_Garrison.GetAvailableMissions(list.availableMissions)
	if (full) then
		local buttons=GarrisonMissionFrame.MissionTab.MissionList.listScroll.buttons
		for i=1,#buttons do
			local b=buttons[i]
			if (b and b.info and b.info.missionID and b.info.missionID ) then
				self:TooltipAdder(b.info.missionID,true)
			end
		end
	end
--[===[@debug@
	print("Done in",format("%.3f",GetTime()-start))
--@end-debug@]===]
end
function addon:DummyHookScript(frame,hook,method)
--[===[@debug@
	print("DummyHook:",frame,hook)
--@end-debug@]===]
	if (_G[frame]) then
		self:HookScript(_G[frame],hook,function(...) self:ScriptTrace(frame,hook,...) end)
--[===[@debug@
	else
		print(C("Attempted hook for non exixtent:","red"),frame,hook)
--@end-debug@]===]
	end
end
function addon:Init()
	GMF=GarrisonMissionFrame
	GMFFollowers=GarrisonMissionFrameFollowers
	GMFMissions=GarrisonMissionFrameMissions
	GMFTab1=GarrisonMissionFrameTab1
	GMFTab2=GarrisonMissionFrameTab2
	GMFMissionsTab1=GarrisonMissionFrameMissionsTab1
	GMFMissionsTab2=GarrisonMissionFrameMissionsTab2
	if (not GMF or not GMFFollowers or not GMFMissions or not GMFTab1 or not GMFTab2 or not GMFMissionsTab1 or not GMFMissionsTab2) then
		print("Lagging badly, retrying in 2 seconds")
		self:ScheduleTimer("Init",2)
		return
	end
	self:FillFollowersList()
	self:CacheFollowers()
	self:SecureHook("GarrisonMissionButton_AddThreatsToTooltip",function(id) self:TooltipAdder(id) end)
	self:SecureHook("GarrisonMissionButton_SetRewards","AddPerc")
	--self:SecureHook("GarrisonFollowerList_UpdateFollowers","CacheFollowers")
	local _,_,_,loadable,reason=GetAddOnInfo("MasterPlan")
	if (loadable or reason=="DEMAND_LOADED") then
		masterplan=true
		self:SecureHook("GarrisonMissionList_Update","RestoreTooltip")
	end
	--self:HookScript(GMFMissions,"OnShow","SetUp")
	self:HookScript(GMF,"OnHide","CleanUp")
	--self:HookScript(GMF.MissionTab.MissionPage.CloseButton,"OnClick","SetUp")
	--self:HookScript(GMF.MissionComplete,"OnHide","SetUp")
	--self:HookScript(GMFFollowers,"OnHide","SetUp")
	self:ApplyMOVEPANEL(self:GetBoolean("MOVEPANEL"))
--[===[@debug@
	self:RegisterEvent("GARRISON_MISSION_BONUS_ROLL_LOOT","SetDirty")
	self:RegisterEvent("GARRISON_MISSION_FINISHED","SetDirty")
	self:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE","SetDirty")
	self:RegisterEvent("GARRISON_MISSION_BONUS_ROLL_COMPLETE","SetDirty")
	self:RegisterEvent("GARRISON_MISSION_LIST_UPDATE","SetDirty")
	self:RegisterEvent("GARRISON_MISSION_STARTED","SetDirty")
	self:DummyHookScript("GarrisonMissionFrameTab1","OnCLick")
	self:DummyHookScript("GarrisonMissionFrameTab2","OnCLick")
	self:DummyHookScript("GarrisonMissionFrameTab3","OnCLick")
	self:DummyHookScript("GarrisonMissionFrameMissionsTab1","OnCLick")
	self:DummyHookScript("GarrisonMissionFrameMIssionsTab2","OnCLick")
	self:DummyHookScript("GarrisonMissionFrameMissionsTab3","OnCLick")
--@end-debug@]===]
end
function addon:SetDirty(...)
--[===[@debug@
	print("Fired",...)
--@end-debug@]===]
end

