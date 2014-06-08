local mod	= DBM:NewMod("Sindragosa", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 86 $"):sub(12, -3))
mod:SetCreatureID(36853)
mod:SetModelID(30362)
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH boss1",
	"CHAT_MSG_MONSTER_YELL"
)

local warnAirphase				= mod:NewAnnounce("WarnAirphase", 2, 43810)
local warnGroundphaseSoon		= mod:NewAnnounce("WarnGroundphaseSoon", 2, 43810)
local warnPhase2soon			= mod:NewPrePhaseAnnounce(2)
local warnPhase2				= mod:NewPhaseAnnounce(2, 2)
local warnInstability			= mod:NewCountAnnounce(69766, 2, nil, false)
local warnChilledtotheBone		= mod:NewCountAnnounce(70106, 2, nil, false)
local warnMysticBuffet			= mod:NewCountAnnounce(70128, 2, nil, false)
local warnFrostBeacon			= mod:NewTargetAnnounce(70126, 4)
local warnBlisteringCold		= mod:NewSpellAnnounce(70123, 3)
local warnFrostBreath			= mod:NewSpellAnnounce(69649, 2, nil, mod:IsTank() or mod:IsHealer())
local warnUnchainedMagic		= mod:NewTargetAnnounce(69762, 2, nil, not mod:IsMelee())

local specWarnUnchainedMagic	= mod:NewSpecialWarningYou(69762)
local specWarnFrostBeacon		= mod:NewSpecialWarningYou(70126)
local specWarnInstability		= mod:NewSpecialWarningStack(69766, nil, 4)
local specWarnChilledtotheBone	= mod:NewSpecialWarningStack(70106, nil, 4)
local specWarnMysticBuffet		= mod:NewSpecialWarningStack(70128, false, 5)
local specWarnBlisteringCold	= mod:NewSpecialWarningRun(70123)

local timerNextAirphase			= mod:NewTimer(110, "TimerNextAirphase", 43810)
local timerNextGroundphase		= mod:NewTimer(45, "TimerNextGroundphase", 43810)
local timerNextFrostBreath		= mod:NewNextTimer(22, 69649, nil, mod:IsTank() or mod:IsHealer())
local timerNextBlisteringCold	= mod:NewCDTimer(67, 70123)
local timerNextBeacon			= mod:NewNextTimer(16, 70126)
local timerBlisteringCold		= mod:NewCastTimer(6, 70123)
local timerUnchainedMagic		= mod:NewCDTimer(30, 69762)
local timerInstability			= mod:NewBuffActiveTimer(5, 69766)
local timerChilledtotheBone		= mod:NewBuffActiveTimer(8, 70106)
local timerMysticBuffet			= mod:NewBuffActiveTimer(10, 70128)
local timerNextMysticBuffet		= mod:NewNextTimer(6, 70128)
local timerMysticAchieve		= mod:NewAchievementTimer(30, 4620, "AchievementMystic")

local sndWOP				= mod:NewSound(nil, "SoundWOP", true)

local berserkTimer				= mod:NewBerserkTimer(600)

--local soundBlisteringCold	= mod:NewSound(70123)
--local soundFrostBeacon		= mod:NewSound(70126)

mod:AddBoolOption("SetIconOnFrostBeacon", true)
mod:AddBoolOption("SetIconOnUnchainedMagic", true)
mod:AddBoolOption("ClearIconsOnAirphase", true)
mod:AddBoolOption("AnnounceFrostBeaconIcons", false)
mod:AddBoolOption("AchievementCheck", false, "announce")
mod:AddBoolOption("RangeFrame")

local beaconTargets		= {}
local beaconIconTargets	= {}
local unchainedTargets	= {}
local warned_P2 = false
local warnedfailed = false
local phase = 0
local unchainedIcons = 7
local playerUnchained = false
local playerBeaconed = false
local activeBeacons	= false

local function ClearBeaconTargets()
	table.wipe(beaconIconTargets)
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetBeaconIcons()
		table.sort(beaconIconTargets, sort_by_group)
		local beaconIcons = 8
		for i, v in ipairs(beaconIconTargets) do
			if self.Options.AnnounceFrostBeaconIcons and DBM:GetRaidRank() > 0 then
				SendChatMessage(L.BeaconIconSet:format(beaconIcons, DBM:GetUnitFullName(v)), "RAID")
			end
			self:SetIcon(v, beaconIcons)
			beaconIcons = beaconIcons - 1
		end
		self:Schedule(8, ClearBeaconTargets)
	end
end

local beaconDebuffFilter
do
	beaconDebuffFilter = function(uId)
		return UnitDebuff(uId, (GetSpellInfo(70126)))
	end
end

local function warnBeaconTargets()
	if mod.Options.RangeFrame then
		if not playerBeaconed then
			DBM.RangeCheck:Show(10, beaconDebuffFilter)
		else
			DBM.RangeCheck:Show(10)
		end
	end
	warnFrostBeacon:Show(table.concat(beaconTargets, "<, >"))
	table.wipe(beaconTargets)
	playerBeaconed = false
end

local unchainedDebuffFilter
do
	unchainedDebuffFilter = function(uId)
		return UnitDebuff(uId, (GetSpellInfo(69762)))
	end
end

local function warnUnchainedTargets()
	if mod.Options.RangeFrame then
		if not playerUnchained then
			DBM.RangeCheck:Show(20, unchainedDebuffFilter)
		else
			DBM.RangeCheck:Show(20)
		end
	end
	warnUnchainedMagic:Show(table.concat(unchainedTargets, "<, >"))
	if phase >= 2 then
		timerUnchainedMagic:Start(80)
	else
		timerUnchainedMagic:Start()
	end
	table.wipe(unchainedTargets)
	unchainedIcons = 7
	playerUnchained = false
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerNextAirphase:Start(50-delay)
	timerNextBlisteringCold:Start(33-delay)
	sndWOP:Schedule(29, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\gripsoon.mp3")
	warned_P2 = false
	warnedfailed = false
	table.wipe(beaconTargets)
	table.wipe(beaconIconTargets)
	table.wipe(unchainedTargets)
	unchainedIcons = 7
	playerUnchained = false
	playerBeaconed = false
	phase = 1
	activeBeacons = false
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69649, 71056, 71057, 71058) or args:IsSpellID(73061, 73062, 73063, 73064) then--Frost Breath
		warnFrostBreath:Show()
		timerNextFrostBreath:Start()
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 70126 then
		beaconTargets[#beaconTargets + 1] = args.destName
		if args:IsPlayer() then
			playerBeaconed = true
			specWarnFrostBeacon:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\markgo.mp3")
			sndWOP:Schedule(4, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(6, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
		if phase == 1 and self.Options.SetIconOnFrostBeacon then
			table.insert(beaconIconTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetBeaconIcons")
			if (self:IsDifficulty("normal25") and #beaconIconTargets >= 5) or (self:IsDifficulty("heroic25") and #beaconIconTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #beaconIconTargets >= 2) then
				self:SetBeaconIcons()--Sort and fire as early as possible once we have all targets.
			else
				if self:LatencyCheck() then--Icon sorting is still sensitive and should not be done by laggy members that don't have all targets.
					self:ScheduleMethod(0.3, "SetBeaconIcons")
				end
			end
		end
		if phase == 2 then--Phase 2 there is only one icon/beacon, don't use sorting method if we don't have to.
			timerNextBeacon:Start()
			if self.Options.SetIconOnFrostBeacon then
				self:SetIcon(args.destName, 8)
				if self.Options.AnnounceFrostBeaconIcons then
					SendChatMessage(L.BeaconIconSet:format(8, args.destName), "RAID")
				end
			end
		end
		self:Unschedule(warnBeaconTargets)
		if phase == 2 or (self:IsDifficulty("normal25") and #beaconTargets >= 5) or (self:IsDifficulty("heroic25") and #beaconTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #beaconIconTargets >= 2) then
			warnBeaconTargets()
		else
			self:Schedule(0.3, warnBeaconTargets)
		end
	elseif args.spellId == 69762 then
		unchainedTargets[#unchainedTargets + 1] = args.destName
		if args:IsPlayer() then
			playerUnchained = true
			specWarnUnchainedMagic:Show()
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runout.mp3")
			end		
		end
		if self.Options.SetIconOnUnchainedMagic then
			self:SetIcon(args.destName, unchainedIcons)
			unchainedIcons = unchainedIcons - 1
		end
		self:Unschedule(warnUnchainedTargets)
		if #unchainedTargets >= 6 then
			warnUnchainedTargets()
		else
			self:Schedule(0.3, warnUnchainedTargets)
		end
	elseif args.spellId == 70106 then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			warnChilledtotheBone:Show(args.amount or 1)
			timerChilledtotheBone:Start()
			if (args.amount or 1) >= 4 then
				specWarnChilledtotheBone:Show(args.amount)
				if args.amount == 4 or args.amount == 6 or args.amount == 8 or args.amount == 10 then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\stopatk.mp3")
				end
			end
		end
	elseif args.spellId == 69766 then	--Instability (casters)
		if args:IsPlayer() then
			warnInstability:Show(args.amount or 1)
			timerInstability:Start()
			if (args.amount or 1) >= 4 then
				specWarnInstability:Show(args.amount)
				if args.amount == 4 or args.amount == 6 or args.amount == 8 or args.amount == 10 then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\stopatk.mp3")
				end
			end
		end
	elseif args:IsSpellID(70127, 72528, 72529, 72530) then	--Mystic Buffet (phase 3 - everyone)
		if args:IsPlayer() then
			warnMysticBuffet:Show(args.amount or 1)
			timerMysticBuffet:Start()
			timerNextMysticBuffet:Start()
			if (args.amount or 1) >= 5 then
				specWarnMysticBuffet:Show(args.amount)
				if args.amount == 5 or args.amount == 7 or args.amount == 9 or args.amount == 11 or args.amount == 13 then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\debuffstack.mp3")
				end
			end
			if (args.amount or 1) < 2 then
				timerMysticAchieve:Start()
			end
		end
		if args:IsDestTypePlayer() then
			if self.Options.AchievementCheck and DBM:GetRaidRank() > 0 and not warnedfailed and self:AntiSpam(3) then
				if (args.amount or 1) == 5 then
					SendChatMessage(L.AchievementWarning:format(args.destName), "RAID")
				elseif (args.amount or 1) > 5 then
					warnedfailed = true
					SendChatMessage(L.AchievementFailed:format(args.destName, (args.amount or 1)), "RAID_WARNING")
				end
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 70117 then--Icy Grip Cast, not blistering cold, but adds an extra 1sec to the warning
		warnBlisteringCold:Show()
		specWarnBlisteringCold:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\boomrun.mp3")
		timerBlisteringCold:Start()
		timerNextBlisteringCold:Start()
		sndWOP:Schedule(63, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\gripsoon.mp3")
	end
end	

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69762 then
		if self.Options.SetIconOnUnchainedMagic and not activeBeacons then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 70157 then
		if self.Options.SetIconOnFrostBeacon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 70126 then
		activeBeacons = false
	elseif args.spellId == 70106 then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			timerChilledtotheBone:Cancel()
		end
	elseif args.spellId == 69766 then	--Instability (casters)
		if args:IsPlayer() then
			timerInstability:Cancel()
		end
	elseif args:IsSpellID(70127, 72528, 72529, 72530) then
		if args:IsPlayer() then
			timerMysticAchieve:Cancel()
			timerMysticBuffet:Cancel()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_P2 and self:GetUnitCreatureId(uId) == 36853 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		warned_P2 = true
		warnPhase2soon:Show()	
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellAirphase or msg:find(L.YellAirphase)) or (msg == L.YellAirphaseDem or msg:find(L.YellAirphaseDem)) then
		if self.Options.ClearIconsOnAirphase then
			self:ClearIcons()
		end
		warnAirphase:Show()
		timerNextFrostBreath:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\gripsoon.mp3")
		timerUnchainedMagic:Start(55)
		timerNextBlisteringCold:Start(80)--Not exact anywhere from 80-110seconds after airphase begin
		sndWOP:Schedule(76, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\gripsoon.mp3")
		timerNextAirphase:Start()
		timerNextGroundphase:Start()
		warnGroundphaseSoon:Schedule(40)
		activeBeacons = true
	elseif (msg == L.YellPhase2 or msg:find(L.YellPhase2)) or (msg == L.YellPhase2Dem or msg:find(L.YellPhase2Dem)) then
		phase = phase + 1
		warnPhase2:Show()
		timerNextBeacon:Start(7)
		timerNextAirphase:Cancel()
		timerNextGroundphase:Cancel()
		warnGroundphaseSoon:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\gripsoon.mp3")
		timerNextBlisteringCold:Start(35)
		sndWOP:Schedule(31, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\gripsoon.mp3")
	end
end
