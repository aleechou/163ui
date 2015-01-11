local mod	= DBM:NewMod("Kazzak", "DBM-Outlands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 164 $"):sub(12, -3))
mod:SetCreatureID(18728)
mod:SetModelID(17887)
mod:SetUsedIcons(7, 8)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningFrenzy		= mod:NewSpellAnnounce(32964, 4)
local warningMark		= mod:NewTargetAnnounce(32960, 4)
local warningTwisted	= mod:NewTargetAnnounce(21063, 4)

local specWarnMark		= mod:NewSpecialWarningYou(32960)
local specWarnTwisted	= mod:NewSpecialWarningDispel(21063, false)

local timerFrenzy		= mod:NewBuffActiveTimer(10, 32964)
local timerFrenzyCD		= mod:NewCDTimer(60, 32964)
--local timerTwistedCD	= mod:NewCDTimer(30, 21063)--Unknown, but would be nice to have
local timerMark			= mod:NewTargetTimer(10, 32960)

mod:AddBoolOption("SetIconOnMark", true)

function mod:OnCombatStart(delay)
	timerFrenzyCD:Start(-delay)
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 32960 then
		warningMark:Show(args.destName)
		timerMark:Start(args.destName)
		if args:IsPlayer() then
			specWarnMark:Show()
		end
		if self.Options.SetIconOnMark then
			self:SetIcon(args.destName, 8)
		end
	elseif args.spellId == 32964 then
		warningFrenzy:Show()
		timerFrenzy:Show()
		timerFrenzyCD:Start()
	elseif args.spellId == 21063 then
		warningTwisted:Show(args.destName)
		specWarnTwisted:Show(args.destName)
--		timerTwistedCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 32960 then
		timerMark:Cancel(args.destName)
		if self.Options.SetIconOnMark then
			self:SetIcon(args.destName, 0)
		end
	end
end
