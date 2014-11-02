local mod	= DBM:NewMod("Deathwhisper", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 142 $"):sub(12, -3))
mod:SetCreatureID(36855)
mod:SetEncounterID(1100)
mod:SetModelID(30893)
mod:SetUsedIcons(4, 5, 6, 7, 8)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_INTERRUPT",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_TARGET_UNFILTERED"
)

local canPurge = select(2, UnitClass("player")) == "MAGE"
			or select(2, UnitClass("player")) == "SHAMAN"
			or select(2, UnitClass("player")) == "PRIEST"

local warnAddsSoon					= mod:NewAnnounce("WarnAddsSoon", 2)
local warnDominateMind				= mod:NewTargetAnnounce(71289, 3)
local warnSummonSpirit				= mod:NewSpellAnnounce(71426, 2)
local warnReanimating				= mod:NewAnnounce("WarnReanimating", 3)
local warnDarkTransformation		= mod:NewSpellAnnounce(70900, 4)
local warnDarkEmpowerment			= mod:NewSpellAnnounce(70901, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 1)
local warnFrostbolt					= mod:NewCastAnnounce("OptionVersion2", 71420, 2, nil, nil, false)
local warnTouchInsignificance		= mod:NewStackAnnounce(71204, 2, nil, mod:IsTank() or mod:IsHealer())
local warnDarkMartyrdom				= mod:NewSpellAnnounce(71236, 4)

local specWarnCurseTorpor			= mod:NewSpecialWarningYou(71237)
local specWarnDeathDecay			= mod:NewSpecialWarningMove(71001)
local specWarnTouchInsignificance	= mod:NewSpecialWarningStack(71204, nil, 3)
local specWarnVampricMight			= mod:NewSpecialWarningDispel(70674, canPurge)
local specWarnDarkMartyrdom			= mod:NewSpecialWarningMove(71236, mod:IsMelee())
local specWarnFrostbolt				= mod:NewSpecialWarningInterrupt(71420, false)

local timerAdds						= mod:NewTimer(60, "TimerAdds", 61131)
local timerDominateMind				= mod:NewBuffActiveTimer(12, 71289)
local timerDominateMindCD			= mod:NewCDTimer(40, 71289)
local timerSummonSpiritCD			= mod:NewCDTimer(10, 71426, nil, false)
local timerFrostboltCast			= mod:NewCastTimer(4, 71420)
local timerTouchInsignificance		= mod:NewTargetTimer(30, 71204, nil, mod:IsTank() or mod:IsHealer())

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnDominateMind", false)
mod:AddBoolOption("SetIconOnDeformedFanatic", false)
mod:AddBoolOption("SetIconOnEmpoweredAdherent", false)
mod:AddBoolOption("ShieldHealthFrame", true)

local dominateMindTargets = {}
local dominateMindIcon = 6
local deformedFanatic
local empoweredAdherent
local lastPower = 100

local function showDominateMindWarning()
	warnDominateMind:Show(table.concat(dominateMindTargets, "<, >"))
	timerDominateMind:Start()
	timerDominateMindCD:Start()
	table.wipe(dominateMindTargets)
	dominateMindIcon = 6
end

local function getPower()
	return lastPower
end

function mod:addsTimer()
	timerAdds:Cancel()
	warnAddsSoon:Cancel()
	if self:IsDifficulty("heroic10") or self:IsDifficulty("heroic25") then
		warnAddsSoon:Schedule(40)	-- 5 secs prewarning
		self:ScheduleMethod(45, "addsTimer")
		timerAdds:Start(45)
	else
		warnAddsSoon:Schedule(55)	-- 5 secs prewarning
		self:ScheduleMethod(60, "addsTimer")
		timerAdds:Start()
	end
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for uId in DBM:GetGroupMembers() do
			if UnitGUID(uId.."target") == deformedFanatic and self.Options.SetIconOnDeformedFanatic then
				deformedFanatic = nil
				SetRaidTarget(uId.."target", 8)
			elseif UnitGUID(uId.."target") == empoweredAdherent and self.Options.SetIconOnEmpoweredAdherent then
				empoweredAdherent = nil
				SetRaidTarget(uId.."target", 7)
			end
			if not (deformedFanatic or empoweredAdherent) then
				break
			end
		end
	end
end

function mod:OnCombatStart(delay)
	if DBM.BossHealth:IsShown() and self.Options.ShieldHealthFrame then
		local name = GetSpellInfo(70842)
		DBM.BossHealth:AddBoss(getPower, name)
	end
	berserkTimer:Start(-delay)
	timerAdds:Start(7)
	warnAddsSoon:Schedule(4)			-- 3sec pre-warning on start
	self:ScheduleMethod(7, "addsTimer")
	if not self:IsDifficulty("normal10") then
		timerDominateMindCD:Start(30)		-- Sometimes 1 fails at the start, then the next will be applied 70 secs after start ?? :S
	end
	table.wipe(dominateMindTargets)
	dominateMindIcon = 6
	deformedFanatic = nil
	empoweredAdherent = nil
	lastPower = 100
	self:RegisterShortTermEvents(
		"UNIT_POWER_FREQUENT target focus mouseover"
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 71289 then
		dominateMindTargets[#dominateMindTargets + 1] = args.destName
		if self.Options.SetIconOnDominateMind then
			self:SetIcon(args.destName, dominateMindIcon, 12)
			dominateMindIcon = dominateMindIcon - 1
		end
		self:Unschedule(showDominateMindWarning)
		if self:IsDifficulty("heroic10", "normal25") or (self:IsDifficulty("heroic25") and #dominateMindTargets >= 3) then
			showDominateMindWarning()
		else
			self:Schedule(0.9, showDominateMindWarning)
		end
	elseif args.spellId == 71001 then
		if args:IsPlayer() then
			specWarnDeathDecay:Show()
		end
	elseif args.spellId == 71237 and args:IsPlayer() then
		specWarnCurseTorpor:Show()
	elseif args.spellId == 70674 and not args:IsDestTypePlayer() and (UnitName("target") == L.Fanatic1 or UnitName("target") == L.Fanatic2 or UnitName("target") == L.Fanatic3) then
		specWarnVampricMight:Show(args.destName)
	elseif args.spellId == 71204 then
		warnTouchInsignificance:Show(args.destName, args.amount or 1)
		timerTouchInsignificance:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 3 and self:IsDifficulty("normal10", "normal25") then
			specWarnTouchInsignificance:Show(args.amount)
		elseif args:IsPlayer() and (args.amount or 1) >= 5 and self:IsDifficulty("heroic10", "heroic25") then
			specWarnTouchInsignificance:Show(args.amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 70842 then
		warnPhase2:Show()
		self:UnregisterShortTermEvents()
		if DBM.BossHealth:IsShown() and self.Options.ShieldHealthFrame then	
			DBM.BossHealth:RemoveBoss(getPower)
		end
		if self:IsDifficulty("normal10", "normal25") then
			timerAdds:Cancel()
			warnAddsSoon:Cancel()
			self:UnscheduleMethod("addsTimer")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 71420 then
		warnFrostbolt:Show()
		specWarnFrostbolt:Show(args.sourceName)
		timerFrostboltCast:Start()
	elseif args.spellId == 70900 then
		warnDarkTransformation:Show()
		if self.Options.SetIconOnDeformedFanatic then
			deformedFanatic = args.sourceGUID
			self:TrySetTarget()
		end
	elseif args.spellId == 70901 then
		warnDarkEmpowerment:Show()
		if self.Options.SetIconOnEmpoweredAdherent then
			empoweredAdherent = args.sourceGUID
			self:TrySetTarget()
		end
	elseif args.spellId == 71236 then
		warnDarkMartyrdom:Show()
		specWarnDarkMartyrdom:Show()
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 71420 then
		timerFrostboltCast:Cancel()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 71426 and self:AntiSpam(5, 1) then -- Summon Vengeful Shade
		warnSummonSpirit:Show()
		timerSummonSpiritCD:Start()
	end
end

function mod:UNIT_TARGET_UNFILTERED()
	if empoweredAdherent or deformedFanatic then
		self:TrySetTarget()
	end
end

function mod:UNIT_POWER_FREQUENT(uId)
	if self:GetUnitCreatureId(uId) == 36855 then
		lastPower = math.floor(UnitPower(uId)/UnitPowerMax(uId) * 100)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellReanimatedFanatic or msg:find(L.YellReanimatedFanatic) then
		warnReanimating:Show()
	end
end
