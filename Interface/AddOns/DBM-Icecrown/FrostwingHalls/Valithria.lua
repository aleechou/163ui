local mod	= DBM:NewMod("Valithria", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4502 $"):sub(12, -3))
mod:SetCreatureID(36789)
mod:SetUsedIcons(8)
mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_TARGET"
)

local warnCorrosion		= mod:NewAnnounce("WarnCorrosion", 2, 70751, false)
local warnGutSpray		= mod:NewTargetAnnounce(71283, 3, nil, mod:IsTank() or mod:IsHealer())
local warnManaVoid		= mod:NewSpellAnnounce(71741, 2, nil, mod:IsManaUser())
local warnSupression	= mod:NewSpellAnnounce(70588, 3)
local warnPortalSoon	= mod:NewSoonAnnounce(72483, 2, nil)
local warnPortal		= mod:NewSpellAnnounce(72483, 3, nil)
local warnPortalOpen	= mod:NewAnnounce("WarnPortalOpen", 4, 72483)

local specWarnLayWaste	= mod:NewSpecialWarningSpell(71730)
local specWarnManaVoid	= mod:NewSpecialWarningMove(71741)

local timerLayWaste		= mod:NewBuffActiveTimer(12, 69325)
local timerNextPortal	= mod:NewCDTimer(46.5, 72483, nil)
local timerPortalsOpen	= mod:NewTimer(10, "TimerPortalsOpen", 72483)
local timerHealerBuff	= mod:NewBuffActiveTimer(40, 70873)
local timerGutSpray		= mod:NewTargetTimer(12, 71283, nil, mod:IsTank() or mod:IsHealer())
local timerCorrosion	= mod:NewTargetTimer(6, 70751, nil, false)
local timerBlazingSkeleton	= mod:NewTimer(50, "TimerBlazingSkeleton", 17204)
local timerAbom				= mod:NewTimer(50, "TimerAbom", 43392)--Experimental

local sndWOP				= mod:NewSound(nil, "SoundWOP", true)

local berserkTimer		= mod:NewBerserkTimer(420)

mod:AddBoolOption("SetIconOnBlazingSkeleton", true)

local GutSprayTargets = {}
local spamSupression = 0
local BlazingSkeletonTimer = 60
local AbomSpawn = 0
local AbomTimer = 60
local blazingSkeleton = nil

local function warnGutSprayTargets()
	warnGutSpray:Show(table.concat(GutSprayTargets, "<, >"))
	table.wipe(GutSprayTargets)
end

function mod:StartBlazingSkeletonTimer()
	sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\bonesoon.mp3")
	timerBlazingSkeleton:Start(BlazingSkeletonTimer)
	self:ScheduleMethod(BlazingSkeletonTimer, "StartBlazingSkeletonTimer")
	sndWOP:Schedule(BlazingSkeletonTimer-4, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\bonesoon.mp3")
	if BlazingSkeletonTimer >= 10 then--Keep it from dropping below 5
		BlazingSkeletonTimer = BlazingSkeletonTimer - 5
	end
end

--23, 60, 55, 55, 55, 50, 45, 40, 35, etc (at least on normal, on heroic it might be only 2 55s, need more testing)
function mod:StartAbomTimer()
	AbomSpawn = AbomSpawn + 1
	if AbomSpawn == 1 then
		timerAbom:Start(AbomTimer)--Timer is 60 seconds after first early abom, it's set to 60 on combat start.
		self:ScheduleMethod(AbomTimer, "StartAbomTimer")
		AbomTimer = AbomTimer - 5--Right after first abom timer starts, change it from 60 to 55.
	elseif AbomSpawn == 2 or AbomSpawn == 3 then
		timerAbom:Start(AbomTimer)--Start first and second 55 second timer
		self:ScheduleMethod(AbomTimer, "StartAbomTimer")
	elseif AbomSpawn >= 4 then--after 4th abom, the timer starts subtracting again.
		timerAbom:Start(AbomTimer)--Start third 55 second timer before subtracking from it again.
		self:ScheduleMethod(AbomTimer, "StartAbomTimer")
		if AbomTimer >= 10 then--Keep it from dropping below 5
			AbomTimer = AbomTimer - 5--Rest of timers after 3rd 55 second timer will be 5 less than previous until they come every 5 seconds.
		end
	end
end

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		berserkTimer:Start(-delay)
	end
	timerNextPortal:Start()
	warnPortalSoon:Schedule(41)
	self:ScheduleMethod(46.5, "Portals")--This will never be perfect, since it's never same. 45-48sec variations
	BlazingSkeletonTimer = 60
	AbomTimer = 60
	AbomSpawn = 0
	self:ScheduleMethod(50-delay, "StartBlazingSkeletonTimer")
	self:ScheduleMethod(23-delay, "StartAbomTimer")--First abom is 23-25 seconds after combat start, cause of variation, it may cause slightly off timer rest of fight
	timerBlazingSkeleton:Start(-delay)
	timerAbom:Start(23-delay)
	sndWOP:Schedule(46-delay, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\bonesoon.mp3")
	table.wipe(GutSprayTargets)
	blazingSkeleton = nil
end

function mod:Portals()
	warnPortal:Show()
	sndWOP:Schedule(10, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\indoorsoon.mp3")
	warnPortalOpen:Cancel()
	timerPortalsOpen:Cancel()
	warnPortalSoon:Cancel()
	warnPortalOpen:Schedule(15)
	timerPortalsOpen:Schedule(15)
	warnPortalSoon:Schedule(41)
	timerNextPortal:Start()
	self:UnscheduleMethod("Portals")
	self:ScheduleMethod(46.5, "Portals")--This will never be perfect, since it's never same. 45-48sec variations
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for i = 1, GetNumGroupMembers() do
			if UnitGUID("raid"..i.."target") == blazingSkeleton then
				blazingSkeleton = nil
				SetRaidTarget("raid"..i.."target", 8)
			end
			if not blazingSkeleton then
				break
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70754, 71748, 72023, 72024) then--Fireball (its the first spell Blazing SKeleton's cast upon spawning)
		if self.Options.SetIconOnBlazingSkeleton then
			blazingSkeleton = args.sourceGUID
			self:TrySetTarget()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(71741) then--Mana Void
		warnManaVoid:Show()
	elseif args:IsSpellID(70588) and GetTime() - spamSupression > 5 then--Supression
		warnSupression:Show(args.destName)
		spamSupression = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) and args:IsDestTypePlayer() then--Gut Spray
		GutSprayTargets[#GutSprayTargets + 1] = args.destName
		timerGutSpray:Start(args.destName)
		self:Unschedule(warnGutSprayTargets)
		self:Schedule(0.3, warnGutSprayTargets)
	elseif args:IsSpellID(70751, 71738, 72022, 72023) and args:IsDestTypePlayer() then--Corrosion
		warnCorrosion:Show(args.spellName, args.destName, args.amount or 1)
		timerCorrosion:Start(args.destName)
	elseif args:IsSpellID(69325, 71730) then--Lay Waste
		specWarnLayWaste:Show()
		timerLayWaste:Start()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\firebone.mp3")
	elseif args:IsSpellID(70873, 71941) then	--Emerald Vigor/Twisted Nightmares (portal healers)
		if args:IsPlayer() then
			timerHealerBuff:Start()
			sndWOP:Schedule(37, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(38, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(39, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) then--Gut Spray
		timerGutSpray:Cancel(args.destName)
	elseif args:IsSpellID(69325, 71730) then--Lay Waste
		timerLayWaste:Cancel()
	end
end

do 
	local lastVoid = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(71086, 71743, 72029, 72030) and args:IsPlayer() and time() - lastVoid > 2 then		-- Mana Void
			specWarnManaVoid:Show()
			if mod:IsManaUser() then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			end
			lastVoid = time()
		end
	end

	function mod:SPELL_MISSED(args)
		if args:IsSpellID(71086, 71743, 72029, 72030) and args:IsPlayer() and time() - lastVoid > 2 then		-- Mana Void
			specWarnManaVoid:Show()
			if mod:IsManaUser() then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			end
			lastVoid = time()
		end
	end
end

function mod:UNIT_TARGET()
	if blazingSkeleton then
		self:TrySetTarget()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellPortals or msg:find(L.YellPortals)) and mod:LatencyCheck() then
		self:SendSync("NightmarePortal")
	end
end

function mod:OnSync(msg, arg)
	if msg == "NightmarePortal" and self:IsInCombat() then
		self:Portals()
	end
end
