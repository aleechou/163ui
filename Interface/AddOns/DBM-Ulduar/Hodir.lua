local mod	= DBM:NewMod("Hodir", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 178 $"):sub(12, -3))
mod:SetCreatureID(32845,32926)
mod:SetEncounterID(1135)
mod:SetModelID(28743)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat_yell", L.Pull)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warnStormCloud		= mod:NewTargetAnnounce(65123)
local warnFlashFreeze		= mod:NewSpecialWarningSpell(61968)

local specWarnStormCloud	= mod:NewSpecialWarningYou(65123)
local specWarnBitingCold	= mod:NewSpecialWarningMove(62188, false)

local enrageTimer			= mod:NewBerserkTimer(475)
local timerFlashFreeze		= mod:NewCastTimer(9, 61968)
local timerFrozenBlows		= mod:NewBuffActiveTimer(20, 63512)
local timerFlashFrCD		= mod:NewCDTimer(50, 61968)
local timerAchieve			= mod:NewAchievementTimer(179, 3182, "TimerSpeedKill")

local yellStormCloud		= mod:NewYell(65133)

mod:AddBoolOption("SetIconOnStormCloud")

local stormCloudIcon = 8

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	timerFlashFrCD:Start(-delay)
	stormCloudIcon = 8
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 61968 then
		timerFlashFreeze:Start()
		warnFlashFreeze:Show()
		timerFlashFrCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62478, 63512) then
		timerFrozenBlows:Start()
	elseif args:IsSpellID(65123, 65133) then
		warnStormCloud:Show(args.destName)
		if args:IsPlayer() then
			specWarnStormCloud:Show()
			yellStormCloud:Yell()
		end
		if self.Options.SetIconOnStormCloud then
			self:SetIcon(args.destName, stormCloudIcon)
			if stormCloudIcon == 8 then	-- There is a chance 2 ppl will have the buff on 25 player, so we are alternating between 2 icons
				stormCloudIcon = 7
			else
				stormCloudIcon = 8
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(65123, 65133) then
		if self.Options.SetIconOnStormCloud then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 62038 or spellId == 62188) and destGUID == UnitGUID("player") and self:AntiSpam(4) then
		specWarnBitingCold:Show()
	end
end
