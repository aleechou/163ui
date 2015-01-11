local mod	= DBM:NewMod("Ossirian", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 535 $"):sub(12, -3))
mod:SetCreatureID(15339)
mod:SetModelID(15432)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnSupreme		= mod:NewSpellAnnounce(25176, 4)
local warnCyclone		= mod:NewTargetAnnounce(25189, 4)
local warnVulnerable	= mod:NewAnnounce("WarnVulnerable", 3, "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")

local timerCyclone		= mod:NewTargetTimer(10, 25189)
local timerVulnerable	= mod:NewTimer(45, "TimerVulnerable", "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 25176 then
		warnSupreme:Show()
	elseif args.spellId == 25189 then
		warnCyclone:Show(args.destName)
		timerCyclone:Start(args.destName)
	elseif args:IsSpellID(25177, 25178, 25180, 25181, 25183) then
		warnVulnerable:Show(args.spellName)
		timerVulnerable:Show(args.spellName)
	end	
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 25189 then
		timerCyclone:Cancel(args.destName)
	end	
end
