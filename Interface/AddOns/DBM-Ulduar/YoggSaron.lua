local mod	= DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 73 $"):sub(12, -3))
mod:SetCreatureID(33288)
mod:SetModelID(28817)
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_REMOVED_DOSE",
	"UNIT_HEALTH target focus mouseover"
)

mod:SetUsedIcons(6, 7, 8)

local warnMadness 					= mod:NewCastAnnounce(64059, 2)
local warnFervorCast 				= mod:NewCastAnnounce(63138, 3)
local warnSqueeze					= mod:NewTargetAnnounce(64125, 3)
local warnFervor					= mod:NewTargetAnnounce(63138, 4)
local warnDeafeningRoarSoon			= mod:NewPreWarnAnnounce(64189, 5, 3)
local warnGuardianSpawned 			= mod:NewAnnounce("WarningGuardianSpawned", 3, 62979)
local warnCrusherTentacleSpawned	= mod:NewAnnounce("WarningCrusherTentacleSpawned", 2, 93708)
local warnP2 						= mod:NewPhaseAnnounce(2, 2)
local warnP3 						= mod:NewPhaseAnnounce(3, 2)
local warnSanity 					= mod:NewAnnounce("WarningSanity", 3, 63050)
local warnBrainLink 				= mod:NewTargetAnnounce(63802, 3)
local warnBrainPortalSoon			= mod:NewAnnounce("WarnBrainPortalSoon", 2)
local warnEmpowerSoon				= mod:NewSoonAnnounce(64486, 4)

local specWarnGuardianLow 			= mod:NewSpecialWarning("SpecWarnGuardianLow", false)
local specWarnBrainLink 			= mod:NewSpecialWarningYou(63802)
local specWarnSanity 				= mod:NewSpecialWarning("SpecWarnSanity")
local specWarnMadnessOutNow			= mod:NewSpecialWarning("SpecWarnMadnessOutNow")
local specWarnBrainPortalSoon		= mod:NewSpecialWarning("specWarnBrainPortalSoon", false)
local specWarnDeafeningRoar			= mod:NewSpecialWarningSpell(64189)
local specWarnFervor				= mod:NewSpecialWarningYou(63138)
local specWarnFervorCast			= mod:NewSpecialWarning("SpecWarnFervorCast", mod:IsMelee())
local specWarnMaladyNear			= mod:NewSpecialWarning("SpecWarnMaladyNear", true)

mod:AddBoolOption("WarningSqueeze", true, "announce")

local enrageTimer					= mod:NewBerserkTimer(900)
local timerFervor					= mod:NewTargetTimer(15, 63138)
local brainportal					= mod:NewTimer(20, "NextPortal")
local timerLunaricGaze				= mod:NewCastTimer(4, 64163)
local timerNextLunaricGaze			= mod:NewCDTimer(8.5, 64163)
local timerEmpower					= mod:NewCDTimer(46, 64465)
local timerEmpowerDuration			= mod:NewBuffActiveTimer(10, 64465)
local timerMadness 					= mod:NewCastTimer(60, 64059)
local timerCastDeafeningRoar		= mod:NewCastTimer(2.3, 64189)
local timerNextDeafeningRoar		= mod:NewNextTimer(30, 64189)
local timerAchieve					= mod:NewAchievementTimer(420, 3012, "TimerSpeedKill")



mod:AddBoolOption("ShowSaraHealth")
mod:AddBoolOption("SetIconOnFearTarget")
mod:AddBoolOption("SetIconOnFervorTarget")
mod:AddBoolOption("SetIconOnBrainLinkTarget")
mod:AddBoolOption("MaladyArrow")

local phase							= 1
local targetWarningsShown			= {}
local brainLinkTargets = {}
local brainLinkIcon = 7
local Guardians = 0

function mod:OnCombatStart(delay)
	Guardians = 0
	phase = 1
	enrageTimer:Start()
	timerAchieve:Start()
	if self.Options.ShowSaraHealth and not DBM.BossHealth:IsShown() then
		DBM.BossHealth:Show(L.name)
	end
	if self.Options.ShowSaraHealth then
		DBM.BossHealth:AddBoss(33134, L.Sara)
	end
	table.wipe(targetWarningsShown)
	table.wipe(brainLinkTargets)
end

function mod:FervorTarget()
	local targetname = self:GetBossTarget(33134)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFervorCast:Show()
	end
end

function mod:warnBrainLink()
	warnBrainLink:Show(table.concat(brainLinkTargets, "<, >"))
	table.wipe(brainLinkTargets)
	brainLinkIcon = 7
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64059 then	-- Induce Madness
		timerMadness:Start()
		warnMadness:Show()
		brainportal:Schedule(60)
		warnBrainPortalSoon:Schedule(78)
		specWarnBrainPortalSoon:Schedule(78)
		sndWOP:Schedule(78, "indoorsoon")
		specWarnMadnessOutNow:Schedule(55)
		sndWOP:Schedule(55, "outdoornow")
	elseif args.spellId == 64189 then		--Deafening Roar
		timerNextDeafeningRoar:Start()
		warnDeafeningRoarSoon:Schedule(55)
		sndWOP:Schedule(55, "silencesoon")
		timerCastDeafeningRoar:Start()
		specWarnDeafeningRoar:Show()
	elseif args.spellId == 63138 then		--Sara's Fervor
		self:ScheduleMethod(0.2, "FervorTarget")
		warnFervorCast:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 64144 and self:GetUnitCreatureId(args.sourceGUID) == 33966 then 
		warnCrusherTentacleSpawned:Show()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 62979 then
		Guardians = Guardians + 1
		warnGuardianSpawned:Show(Guardians)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63802 then		-- Brain Link
		self:UnscheduleMethod("warnBrainLink")
		brainLinkTargets[#brainLinkTargets + 1] = args.destName
		if self.Options.SetIconOnBrainLinkTarget then
			self:SetIcon(args.destName, brainLinkIcon, 30)
			brainLinkIcon = brainLinkIcon - 1
		end
		if args:IsPlayer() then
			specWarnBrainLink:Show()
			sndWOP:Play("followline")
		end
		self:ScheduleMethod(0.2, "warnBrainLink")
	elseif args:IsSpellID(63830, 63881) then   -- Malady of the Mind (Death Coil) 
		if self.Options.SetIconOnFearTarget then
			self:SetIcon(args.destName, 8, 30) 
		end
		local uId = DBM:GetRaidUnitId(args.destName) 
		if uId then 
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then 
				specWarnMaladyNear:Show(args.destName)
				sndWOP:Play("runaway")
				sndWOP:Schedule(1, "countthree")
				sndWOP:Schedule(2, "counttwo")
				sndWOP:Schedule(3, "countone")
				if self.Options.MaladyArrow then
					DBM.Arrow:ShowRunAway(x, y, 12, 5)
				end
			end 
		end 
	elseif args:IsSpellID(64126, 64125) then	-- Squeeze
		warnSqueeze:Show(args.destName)
		sndWOP:Play("killmhand")
		if args:IsPlayer() and self.Options.WarningSqueeze then	
			SendChatMessage(L.WarningYellSqueeze, "SAY")
		end	
	elseif args.spellId == 63138 then	-- Sara's Fervor
		warnFervor:Show(args.destName)
		timerFervor:Start(args.destName)
		if self.Options.SetIconOnFervorTarget then
			self:SetIcon(args.destName, 7, 15)
		end
		if args:IsPlayer() then 
			specWarnFervor:Show()
			sndWOP:Play("fever")
		end
	elseif args.spellId == 63894 then	-- Shadowy Barrier of Yogg-Saron (this is happens when p2 starts)
		phase = 2
		brainportal:Start(60)
		warnBrainPortalSoon:Schedule(57)
		specWarnBrainPortalSoon:Schedule(57)
		sndWOP:Schedule(57, "indoorsoon")
		warnP2:Show()
		if self.Options.ShowSaraHealth then
			DBM.BossHealth:RemoveBoss(33134)
		end
		if not (self.Options.HealthFrame or DBM.Options.AlwaysShowHealthFrame) then
			DBM.BossHealth:Hide()
		end
	elseif args:IsSpellID(64167, 64163) then	-- Lunatic Gaze (reduces sanity)
		timerLunaricGaze:Start()
	elseif args.spellId == 64465 then
		timerEmpower:Start()
		timerEmpowerDuration:Start()
		sndWOP:Play("marknow")
		sndWOP:Schedule(7, "countthree")
		sndWOP:Schedule(8, "counttwo")
		sndWOP:Schedule(9, "countone")
		warnEmpowerSoon:Schedule(40)
		sndWOP:Schedule(40, "marksoon")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 63894 then		-- Shadowy Barrier removed from Yogg-Saron (start p3)
		self:SendSync("Phase3")			-- Sync this because you don't get it in your combat log if you are in brain room.
	elseif args:IsSpellID(64167, 64163) then	-- Lunatic Gaze
		timerNextLunaricGaze:Start()
		sndWOP:Schedule(8, "turnaround")
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	if args.spellId == 63050 and args.destGUID == UnitGUID("player") then
		if args.amount == 50 then
			warnSanity:Show(args.amount)
		elseif args.amount == 25 or args.amount == 15 or args.amount == 5 then
			warnSanity:Show(args.amount)
			specWarnSanity:Show(args.amount)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if phase == 1 and uId == "target" and self:GetUnitCreatureId(uId) == 33136 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.3 and not targetWarningsShown[UnitGUID(uId)] then
		targetWarningsShown[UnitGUID(uId)] = true
		specWarnGuardianLow:Show()
	end
end

function mod:OnSync(msg)
	if msg == "Phase3" then
		brainportal:Cancel()
		warnBrainPortalSoon:Cancel()
		timerEmpower:Start()
		warnP3:Show()
		warnEmpowerSoon:Schedule(40)
		sndWOP:Schedule(40, "marksoon")
		sndWOP:Cancel("indoorsoon")
		timerNextDeafeningRoar:Start(30)
		warnDeafeningRoarSoon:Schedule(25)
		sndWOP:Schedule(25, "silencesoon")
	end
end
