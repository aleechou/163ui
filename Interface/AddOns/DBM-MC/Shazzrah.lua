local mod	= DBM:NewMod("Shazzrah", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 549 $"):sub(12, -3))
mod:SetCreatureID(12264)
--mod:SetEncounterID(667)
mod:SetModelID(13032)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 19714",
	"SPELL_AURA_REMOVED 19714",
	"SPELL_CAST_SUCCESS 19713 19715 23138"
)

local warnCurse			= mod:NewSpellAnnounce(19713)
local warnGrounding		= mod:NewTargetAnnounce(19714, 2, nil, mod:IsMagicDispeller())
local warnCntrSpell		= mod:NewSpellAnnounce(19715)
local warnGate			= mod:NewSpellAnnounce(23138)

local specWarnGrounding	= mod:NewSpecialWarningDispel(19714, mod:IsMagicDispeller())
local specWarnGate		= mod:NewSpecialWarningSpell(23138, mod:IsTank())--aggro wipe, needs fresh taunt

local timerCurseCD		= mod:NewCDTimer(20, 19713)
local timerGrounding	= mod:NewBuffActiveTimer(30, 19714, nil, false)
local timerGateCD		= mod:NewNextTimer(50, 23138)

function mod:OnCombatStart(delay)
	--Bad pull, transcriptor started late, times may be off 1-2 seconds
	timerCurseCD:Start(10-delay)
	timerGateCD:Start(30-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 19714 and self:IsInCombat() and not args:IsDestTypePlayer() then
		warnGrounding:Show(args.destName)
		specWarnGrounding:Show(args.destName)
		timerGrounding:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 19714 then
		timerGrounding:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 19713 and self:IsInCombat() then
		warnCurse:Show()
		timerCurseCD:Start()
	elseif args.spellId == 19715 and self:IsInCombat() then
		warnCntrSpell:Show()
	elseif args.spellId == 23138 then
		warnGate:Show()
		specWarnGate:Show()
		timerGateCD:Start()
	end
end