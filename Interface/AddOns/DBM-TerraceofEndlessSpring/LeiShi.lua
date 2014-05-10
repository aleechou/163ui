﻿local mod	= DBM:NewMod(729, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 10185 $"):sub(12, -3))
mod:SetCreatureID(62983)--62995 Animated Protector

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)--Kill detection is aweful. No death, no special cast. yell is like 40 seconds AFTER victory. terrible.
mod:SetUsedIcons(8, 7, 6, 5, 4, 3) -- on 25 heroic 6 guards spawn.

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_TARGETICONS",
	"UNIT_HEALTH boss1",--UNIT_HEALTH_FREQUENT maybe not needed. It's too high cpu usage.
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnProtect						= mod:NewSpellAnnounce(123250, 2)
local warnHide							= mod:NewCountAnnounce(123244, 3)
local warnHideProgress					= mod:NewAnnounce("warnHideProgress", 1, 123244)--Probably not perm, but less spammy debug solution
local warnHideOver						= mod:NewAnnounce("warnHideOver", 2, 123244)--Because we can. with creativeness, the boss returning is detectable a full 1-2 seconds before even visible. A good signal to stop aoe and get ready to return norm DPS
local warnGetAway						= mod:NewCountAnnounce(123461, 3)
local warnSpray							= mod:NewStackAnnounce(123121, 3, nil, mod:IsTank() or mod:IsHealer())

local specWarnAnimatedProtector			= mod:NewSpecialWarningSwitch("ej6224", not mod:IsHealer())
local specWarnHide						= mod:NewSpecialWarningSpell(123244, nil, nil, nil, 2)
local specWarnGetAway					= mod:NewSpecialWarningSpell(123461, nil, nil, nil, 2)
local specWarnSpray						= mod:NewSpecialWarningStack(123121, mod:IsTank(), 6)
local specWarnSprayNT					= mod:NewSpecialWarningMove(123121)
local specWarnSprayOther				= mod:NewSpecialWarningTarget(123121, mod:IsTank())
local specWarnJSA						= mod:NewSpecialWarning("SpecWarnJSA")

local timerSpecialCD					= mod:NewTimer(50, "timerSpecialCD", 123250)--Variable, 49.5-55 seconds
local timerSpray						= mod:NewTargetTimer(10, 123121, nil, mod:IsTank() or mod:IsHealer())
local timerGetAway						= mod:NewBuffActiveTimer(30, 123461)
local timerScaryFogCD					= mod:NewNextTimer(10, 123705)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("HudMAP", false, "sound")
mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("GWHealthFrame", true)
mod:AddBoolOption("SetIconOnGuardfix", false)

local getAwayHP = 0 -- because max health is different between Asian and US 25-man encounter. Calculate manually.
local specialsCast = 0
local hideActive = false
local lastProtect = 0
local specialRemaining = 0
local guards = {}
local guardActivated = 0
local lostHealth = 0
local prevlostHealth = 0
local hideDebug = 0
local damageDebug = 0
local timeDebug = 0
local hideTime = 0

local Crushcount = 0

local iconsSet = {[1] = false, [2] = false, [3] = false, [4] = false, [5] = false, [6] = false, [7] = false, [8] = false}

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end

local MWMarkers = {}

local function resetguardstate()
	table.wipe(guards)
	iconsSet = {[1] = false, [2] = false, [3] = false, [4] = false, [5] = false, [6] = false, [7] = false, [8] = false}
end

for i = 1, 5 do
	mod:AddBoolOption("unseenjs"..i, false, "sound")
end

local function MyJS()
	if (mod.Options.unseenjs1 and Crushcount == 1) or (mod.Options.unseenjs2 and Crushcount == 2) or (mod.Options.unseenjs3 and Crushcount == 3) or (mod.Options.unseenjs4 and Crushcount == 4) or (mod.Options.unseenjs5 and Crushcount == 5) then
		return true
	end
	return false
end


local function getAvailableIcons()
	for i = 8, 1, -1 do
		if not iconsSet[i] then
			return i
		end
	end
	return 8
end

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss1's highest threat target
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitExists("boss1target") and UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	return false
end

local bossTank
do
	bossTank = function(uId)
		return mod:IsTanking(uId, "boss1")
	end
end

local showDamagedHealthBar, hideDamagedHealthBar
do
	local frame = CreateFrame("Frame") -- using a separate frame avoids the overhead of the DBM event handlers which are not meant to be used with frequently occuring events like all damage events...
	local damagedMob
	local hpRemaining = 0
	local maxhp = 0
	local function getDamagedHP()
		return math.max(1, math.floor(hpRemaining / maxhp * 100))
	end
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, _, _, _, _, _, destGUID, _, _, _, ...)
		if damagedMob == destGUID then
			local damage
			if subEvent == "SWING_DAMAGE" then 
				damage = select( 1, ... ) 
			elseif subEvent == "RANGE_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_PERIODIC_DAMAGE" then 
				damage = select( 4, ... )
			end
			if damage then
				hpRemaining = hpRemaining - damage
			end
		end
	end)
	
	function showDamagedHealthBar(self, mob, spellName, health)
		damagedMob = mob
		hpRemaining = health
		maxhp = health
		DBM.BossHealth:RemoveBoss(getDamagedHP)
		DBM.BossHealth:AddBoss(getDamagedHP, spellName)
	end
	
	function hideDamagedHealthBar()
		DBM.BossHealth:RemoveBoss(getDamagedHP)
	end
end

function mod:ScaryFogRepeat()
	timerScaryFogCD:Cancel()
	self:UnscheduleMethod("ScaryFogRepeat")
	local interval = 10 * (1/(1+lostHealth))--Seems that Scray Fog interval reduced by her casting speed. / EJ lies? seems on heroic, her casting speed increases by 1% per 1% health lost. (lfr: 0.8, normal: 0.9, heroic: 1.0?)
	timerScaryFogCD:Start(interval)
	self:ScheduleMethod(interval, "ScaryFogRepeat")
end

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3, bossTank)
	end
	hideDebug = 0
	damageDebug = 0
	timeDebug = 0
	hideTime = 0
	resetguardstate()
	getAwayHP = 0
	specialsCast = 0
	Crushcount = 0
	hideActive = false
	lastProtect = 0
	specialRemaining = 0
	lostHealth = 0
	prevlostHealth = 0
	timerSpecialCD:Start(30.5-delay, 1)--Variable, 30.5-37 (or aborted if 80% protect happens first)
	if self:IsDifficulty("heroic10", "heroic25") then
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(123712))
			DBM.InfoFrame:Show(1, "bossdebuffstacks", 123712)
		end
		berserkTimer:Start(420-delay)
	else
		berserkTimer:Start(-delay)
	end	
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123250) then
		local elapsed, total = timerSpecialCD:GetTime(specialsCast+1)
		specialRemaining = total - elapsed
		lastProtect = GetTime()	
		warnProtect:Show()
		specWarnAnimatedProtector:Show()
		self:Schedule(0.2, function()
			timerSpecialCD:Cancel()
		end)
		if mod:IsDps() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bwzkd.mp3") --保衛者快打
		else
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bwzcx.mp3") --保衛者出現
		end
	elseif args:IsSpellID(123505) and self.Options.SetIconOnGuardfix then
		if guardActivated == 0 then
			resetguardstate()
		end
		guardActivated = guardActivated + 1
		if not guards[args.sourceGUID] then
			guards[args.destGUID] = true
		end
	elseif args:IsSpellID(123461) then
		specialsCast = specialsCast + 1
		warnGetAway:Show(specialsCast)
		specWarnGetAway:Show()
		timerSpecialCD:Start(nil, specialsCast+1)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerGetAway:Start(45)
		else
			timerGetAway:Start()
		end
		if self.Options.GWHealthFrame then
			local getAwayHealth = math.floor(UnitHealthMax("boss1") * 0.04)
			showDamagedHealthBar(self, args.sourceGUID, args.spellName, getAwayHealth)
		end
		if mod:IsHealer() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\healall.mp3") --注意群療
		else
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_slkd.mp3") --首領快打
		end
		Crushcount = Crushcount + 1
		if MyJS() then
			specWarnJSA:Schedule(1)
			sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
		end
	elseif args:IsSpellID(123121) then
		if not mod:IsTank() and args:IsPlayer() and (not hideActive) and self:AntiSpam(2, 1) then
			specWarnSprayNT:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲开
		end
		if (args.amount or 1) % 3 == 0 and args:IsDestTypePlayer() then
			warnSpray:Show(args.destName, args.amount)
			if args.amount >= 6 and args:IsPlayer() then
				specWarnSpray:Show(args.amount)
			else
				if args.amount >= 6 and not UnitDebuff("player", GetSpellInfo(123121)) and not UnitIsDeadOrGhost("player") then
					specWarnSprayOther:Show(args.destName)
					if mod:IsTank() and (not hideActive) then
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\changemt.mp3") --換坦嘲諷
					end
				end
			end
		end
		if not hideActive and self:UnitIsTank(args.destName) then--filter out all the splash sprays that go out during hide.
			timerSpray:Start(args.destName)
		end
	elseif args:IsSpellID(123705) then
		if self:AntiSpam(2, 2) then
			self:ScaryFogRepeat()		
		end
		if self.Options.HudMAP then
			if (args.amount or 1) < 5 then return end
			if not MWMarkers[args.destName] then
				MWMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 5, nil, 1, 1, 1, 0.5):RegisterForAlerts())
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123250) then
		if self.Options.SetIconOnGuardfix then
			guardActivated = 0
		end
		if timerSpecialCD:GetTime(specialsCast+1) == 0 then -- failsafe. (i.e : 79.8% hide -> protect... bar remains)
			local protectElapsed = GetTime() - lastProtect
			local specialCD = specialRemaining - protectElapsed
			if specialCD < 5 then 
				timerSpecialCD:Start(5, specialsCast+1)
			else
				timerSpecialCD:Start(specialCD, specialsCast+1)
			end
		end
	elseif args:IsSpellID(123121) then
		timerSpray:Cancel(args.destName)
	elseif args:IsSpellID(123461) then
		timerGetAway:Cancel()
		if self.Options.GWHealthFrame then
			hideDamagedHealthBar()
		end
	elseif args:IsSpellID(123705) then
		if MWMarkers[args.destName] then
			MWMarkers[args.destName] = free(MWMarkers[args.destName])
		end
	end
end

mod:RegisterOnUpdateHandler(function(self)
	if self.Options.SetIconOnGuardfix and guardActivated > 0 and DBM:GetRaidRank() > 0 then
		for i = 1, DBM:GetNumGroupMembers() do
			local uId = "raid"..i.."target"
			local guid = UnitGUID(uId)
			if guards[guid] then
				local existingIcons = GetRaidTargetIndex(uId)
				if not existingIcons then
					local icon = getAvailableIcons()
					SetRaidTarget(uId, icon)
					iconsSet[icon] = true
					self:SendSync("iconSet", icon)
				elseif existingIcons then
					iconsSet[existingIcons] = true
				end
				guards[guid] = nil
			end
		end
		local guid2 = UnitGUID("mouseover")
		if guards[guid2] then
			local existingIcons = GetRaidTargetIndex("mouseover")
			if not existingIcons then
				local icon = getAvailableIcons()
				SetRaidTarget("mouseover", icon)
				iconsSet[icon] = true
				self:SendSync("iconSet", icon)
			elseif existingIcons then
				iconsSet[existingIcons] = true
			end
			guards[guid2] = nil
		end
	end
end, 0.05)

function mod:OnSync(msg, icon)
	if msg == "iconSet" and icon then
		iconsSet[icon] = true
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(123244) then
		hideDebug = 0
		damageDebug = 0
		hideTime = GetTime()
		specialsCast = specialsCast + 1
		hideActive = true
		timerScaryFogCD:Cancel()
		self:UnscheduleMethod("ScaryFogRepeat")
		warnHide:Show(specialsCast)
		specWarnHide:Show()
		timerSpecialCD:Start(nil, specialsCast+1)
		self:SetWipeTime(60)--If she hides at 1.6% or below, she will be killed during hide. In this situration, yell fires very slowly. This hack can prevent recording as wipe.
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_yszb.mp3") --隱身準備
		sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\scattersoon.mp3")--注意分散
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT",--We register on hide, because it also fires just before hide, every time and don't want to trigger "hide over" at same time as hide.
			"SPELL_DAMAGE",
			"SPELL_PERIODIC_DAMAGE",
			"RANGE_DAMAGE"
		)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(3)--Show everyone during hide
		end
	elseif args:IsSpellID(123705) then
		self:ScaryFogRepeat()
	end
end

function mod:CHAT_MSG_TARGETICONS(msg)
	--TARGET_ICON_SET = "|Hplayer:%s|h[%s]|h sets |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t on %s.";
	local icon = tonumber(string.sub(string.match(msg, "RaidTargetingIcon_%d"), -1))
	if icon then
		iconsSet[icon] = true
	end
end

function mod:UNIT_HEALTH(uId)
	local currentHealth = 1 - (UnitHealth(uId) / UnitHealthMax(uId))
	if currentHealth and currentHealth < 1 and currentHealth > prevlostHealth then -- Failsafe.
		lostHealth = currentHealth
		prevlostHealth = currentHealth
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 127524 then
		DBM:EndCombat(self)
	end	
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId, _, _, spellDamage)
	local cid = self:GetCIDFromGUID(destGUID)
	if cid == 63099 then--Custom CID lei shi only uses while hiding
		if type(spellDamage) == "number" then--Fix a rare error when spellDamage is a string? In 200 debug prints it only happened once but better safe than sorry
			damageDebug = damageDebug + spellDamage--To see if it's amount of damage
		end
		hideDebug = hideDebug + 1--To see if it's number of hits
		timeDebug = GetTime() - hideTime
	end
end
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE
--NOTE: It breaks early if protect phase is triggered (ie boss hits 80 60 40 or 20 during hide)
--Results (may need to do LFR results with RANGE_DAMAGE flag)
---LFR1 (that didn't break early from protect)
----Spell Hit Lei Shi: 74
----Total Damage: 1174176

--Fires twice when boss returns, once BEFORE visible (and before we can detect unitID, so it flags unknown), then once a 2nd time after visible
--"<233.9> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#nil#nil#Unknown#0xF130F6070000006C#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#Real Args:", -- [14168]
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	hideActive = false
	self:SetWipeTime(3)
	self:UnregisterShortTermEvents()--Once boss appears, unregister event, so we ignore the next two that will happen, which will be 2nd time after reappear, and right before next Hide.
	warnHideOver:Show(GetSpellInfo(123244))
	warnHideProgress:Cancel()
	warnHideProgress:Show(hideDebug, damageDebug, tostring(format("%.1f", timeDebug)))--Show right away instead of waiting out the schedule
	sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_ysjs.mp3") --隱身結束
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3, bossTank)--Go back to showing only tanks
	end
end

function mod:UNIT_DIED(args)
	if MWMarkers[args.destName] then
		MWMarkers[args.destName] = free(MWMarkers[args.destName])
	end
end