﻿local mod	= DBM:NewMod(691, "DBM-Pandaria", nil, 322)	-- 322 = Pandaria/Outdoor I assume
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11120 $"):sub(12, -3))
mod:SetCreatureID(60491)
mod:SetReCombatTime(20)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetMinSyncRevision(10466)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_AURA player"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnUnleashedWrath		= mod:NewSpellAnnounce(119488, 3)--Big aoe damage aura when at 100 rage
local warnGrowingAnger			= mod:NewTargetAnnounce(119622, 4)--Mind control trigger
local warnAggressiveBehavior	= mod:NewTargetAnnounce(119626, 4)--Actual mind control targets

local specWarnUnleashedWrath	= mod:NewSpecialWarningSpell(119488, nil, nil, nil, 2)--Defaults to tank and healers cause tank probalby want to Cd through this and healers have to heal it, dps just do what they always do and kill stuff.
local specWarnGrowingAnger		= mod:NewSpecialWarningYou(119622)
local specWarnBitterThoughts	= mod:NewSpecialWarningMove(119610)

local timerGrowingAngerCD		= mod:NewCDTimer(32, 119622)--Min 32.6~ Max 67.8
local timerUnleashedWrathCD		= mod:NewCDTimer(53, 119488)--Based on rage, but timing is consistent enough to use a CD bar, might require some perfecting later, similar to xariona's special, if rage doesn't reset after wipes, etc.
local timerUnleashedWrath		= mod:NewBuffActiveTimer(24, 119488, nil, mod:IsTank() or mod:IsHealer())

mod:AddBoolOption("RangeFrame", true)--For Mind control spreading.
mod:AddBoolOption("SetIconOnMC", true)

local yellTriggered = false

local warnpreMCTargets = {}
local warnMCTargets = {}
local mcTargetIcons = {}
local mcIcon = 8
local bitterThought = GetSpellInfo(119601)
local playerMCed = false

mod:AddBoolOption("HudMAP", true, "sound")
local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local MCMarkers = {}

local function debuffFilter(uId)
	return UnitDebuff(uId, GetSpellInfo(119622))
end

local function removeIcon(target)
	for i,j in ipairs(mcTargetIcons) do
		if j == target then
			table.remove(mcTargetIcons, i)
			mod:SetIcon(target, 0)
		end
	end
end

do
	local function sortByGroup(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetMCIcons()
		table.sort(mcTargetIcons, sortByGroup)
		for i, v in ipairs(mcTargetIcons) do
			self:SetIcon(v, mcIcon)
			mcIcon = mcIcon - 1
		end
	end
end

function mod:updateRangeFrame()
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", GetSpellInfo(119622)) then
		DBM.RangeCheck:Show(5, nil)--Show everyone.
	else
		DBM.RangeCheck:Show(5, debuffFilter)--Show only people who have debuff.
	end
end

local function showpreMC()
	mod:updateRangeFrame()
	warnGrowingAnger:Show(table.concat(warnpreMCTargets, "<, >"))
	table.wipe(warnpreMCTargets)
	mcIcon = 8
end

local function showMC()
	warnAggressiveBehavior:Show(table.concat(warnMCTargets, "<, >"))
	table.wipe(warnMCTargets)
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	playerMCed = false
	table.wipe(warnpreMCTargets)
	table.wipe(warnMCTargets)
	table.wipe(MCMarkers)
	mcIcon = 8
	if yellTriggered then
		timerUnleashedWrathCD:Start(-delay)
		timerGrowingAngerCD:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	playerMCed = false
	table.wipe(warnpreMCTargets)
	table.wipe(warnMCTargets)
	yellTriggered = false
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 119488 then
		warnUnleashedWrath:Show()
		specWarnUnleashedWrath:Show()
		sndWOP:Schedule(2, "aesoon") --AE
		timerUnleashedWrath:Start()
	elseif args.spellId == 119622 then
		timerGrowingAngerCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 119622 then
		warnpreMCTargets[#warnpreMCTargets + 1] = args.destName
		if self.Options.SetIconOnMC then--Set icons on first debuff to get an earlier spread out.
			local targetUnitID = DBM:GetRaidUnitId(args.destName)
			--Added to fix a bug with duplicate entries of same person in icon table more than once
			local foundDuplicate = false
			for i = #mcTargetIcons, 1, -1 do
				if mcTargetIcons[i].targetUnitID then--make sure they aren't in table before inserting into table again. (not sure why this happens in LFR but it does, probably someone really high ping that cranked latency check way up)
					foundDuplicate = true
				end
			end
			if not foundDuplicate then
				table.insert(mcTargetIcons, targetUnitID)
			end
			self:UnscheduleMethod("SetMCIcons")
			if self:LatencyCheck() then
				self:ScheduleMethod(1.2, "SetMCIcons")
			end
		end
		if args:IsPlayer() then
			specWarnGrowingAnger:Show()
			sndWOP:Play("findmc") --心控
			sndWOP:Schedule(1.5, "runout")
			sndWOP:Schedule(3.5, "countthree")
			sndWOP:Schedule(4.5, "counttwo")
			sndWOP:Schedule(5.5, "countone")
		end
		self:Unschedule(showpreMC)
		if #warnpreMCTargets >= 3 then
			showpreMC()
		else
			self:Schedule(1.2, showpreMC)
		end
		if self.Options.HudMAP then
			MCMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 5, nil, 0, 1, 0, 1):Appear():RegisterForAlerts():Rotate(360, 6))
		end
	elseif args.spellId == 119626 then
		--Maybe add in function to update icons here in case of a spread that results in more then the original 3 getting the final MC debuff.
		warnMCTargets[#warnMCTargets + 1] = args.destName
		self:Unschedule(showMC)
		self:Schedule(2.5, showMC)--These can be vastly spread out, not even need to use 3, depends on what more data says. As well as spread failures.
		if MCMarkers[args.destName] then
			MCMarkers[args.destName] = free(MCMarkers[args.destName])
		end
		if args:IsPlayer() then
			playerMCed = true
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 119626 and self.Options.SetIconOnMC then--Remove them after the MCs break.
		removeIcon(DBM:GetRaidUnitId(args.destName))
		if args:IsPlayer() then
			playerMCed = false
		end
	elseif args.spellId == 119488 then
		timerUnleashedWrathCD:Start()
	end
end

function mod:UNIT_AURA(uId)
	if UnitDebuff("player", bitterThought) and self:AntiSpam(2) and not playerMCed then
		specWarnBitterThoughts:Show()
		sndWOP:Play("runaway")--快躲開
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 60491 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 60491 then--Whole zone gets yell, so lets not engage combat off yell unless he is our target (or the target of our target for healers)
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	end
end