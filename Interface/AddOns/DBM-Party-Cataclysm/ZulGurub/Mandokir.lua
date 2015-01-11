local mod	= DBM:NewMod(176, "DBM-Party-Cataclysm", 11, 76)
local L		= mod:GetLocalizedStrings()
local Ohgan	= EJ_GetSectionInfo(2615)

mod:SetRevision(("$Revision: 121 $"):sub(12, -3))
mod:SetCreatureID(52151)
mod:SetZone()
mod:SetUsedIcons(8)

mod:SetBossHealthInfo(
	52151, L.name,
	52157, Ohgan
)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_HEAL",
	"UNIT_DIED"
)
mod.onlyHeroic = true

local warnDecapitate		= mod:NewTargetAnnounce(96684, 2)
local warnBloodletting		= mod:NewTargetAnnounce(96776, 3)
local warnSlam				= mod:NewSpellAnnounce(96740, 4)
local warnOhgan				= mod:NewSpellAnnounce(96724, 4)
local warnFrenzy			= mod:NewSpellAnnounce(96800, 3)
local warnRevive 			= mod:NewAnnounce("WarnRevive", 2, 96484, false)

local timerSummonOhgan		= mod:NewNextTimer(20, 96717)--Engage only
local timerResOhgan			= mod:NewCDTimer(40, 96724)--rez cd
local timerDecapitate		= mod:NewNextTimer(35, 96684)
local timerBloodletting		= mod:NewTargetTimer(10, 96776)
local timerBloodlettingCD	= mod:NewCDTimer(25, 96776)
local timerSlam				= mod:NewCastTimer(2, 96740)
local timerOhgan			= mod:NewCastTimer(2.5, 96724)

local specWarnSlam			= mod:NewSpecialWarningSpell(96740)
local specWarnOhgan			= mod:NewSpecialWarning("SpecWarnOhgan")

mod:AddBoolOption("SetIconOnOhgan", false)

local reviveCounter = 8
local ohganGUID = nil
local ohganDiedOnce = false

mod:RegisterOnUpdateHandler(function(self)
	if self.Options.SetIconOnOhgan and ohganGUID then
		for uId in DBM:GetGroupMembers() do
			local unitID = uId .. "target"
			local guid = UnitGUID(unitID)
			if guid == ohganGUID then
				SetRaidTarget(unitID, 8)
				ohganGUID = nil
			end
		end
	end
end, 1)

function mod:OnCombatStart(delay)
	reviveCounter = 8
	ohganGUID = nil
	ohganDiedOnce = false
	timerSummonOhgan:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 96776 then
		warnBloodletting:Show(args.destName)
		timerBloodletting:Start(args.destName)
		timerBloodlettingCD:Start()
	elseif args.spellId == 96800 then
		warnFrenzy:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 96484 then
		reviveCounter = reviveCounter - 1
		warnRevive:Show(reviveCounter)
	elseif args.spellId == 96740 then
		warnSlam:Show()
		specWarnSlam:Show()
		timerSlam:Start()
	elseif args.spellId == 96724 then
		warnOhgan:Show()
		timerOhgan:Start()
		timerResOhgan:Start()--We start Cd here cause this is how it works. if it comes off CD while he's alive, then if he dies, he is rezed instantly
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 96684 then
		warnDecapitate:Show(args.destName)
		timerDecapitate:Start()
	end
end

function mod:SPELL_HEAL(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 96724 then
		specWarnOhgan:Show()
		ohganGUID = destGUID
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.sourceGUID)
	if cid == 52156 then
		reviveCounter = reviveCounter - 1
		warnRevive:Show(reviveCounter)
	elseif cid == 52157 and not ohganDiedOnce then
		ohganDiedOnce = true
		timerResOhgan:Start(20)--First time he dies, res isn't on CD yet, but he won't use it for 20 seconds.
	end
end
