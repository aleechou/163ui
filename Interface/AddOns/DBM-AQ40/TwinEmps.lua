local mod	= DBM:NewMod("TwinEmpsAQ", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 502 $"):sub(12, -3))
mod:SetCreatureID(15276, 15275)
mod:SetModelID(15778)
mod:RegisterCombat("combat")
mod:SetBossHealthInfo(
	15276, L.Veklor,
	15275, L.Veknil
)
mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnTeleport			= mod:NewSpellAnnounce(800, 3)
local warnExplodeBug		= mod:NewSpellAnnounce(804, 2, nil, false)
local warnMutateBug			= mod:NewSpellAnnounce(802, 2, nil, false)

local timerTeleport			= mod:NewNextTimer(30, 800)
local timerExplodeBugCD		= mod:NewCDTimer(8, 804, nil, false)
local timerMutateBugCD		= mod:NewCDTimer(11, 802, nil, false)

local berserkTimer	=	mod:NewBerserkTimer(900)

function mod:OnCombatStart(delay)
	berserkTimer:Start()
	timerTeleport:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(799, 800) and self:AntiSpam() then
		warnTeleport:Show()
		timerTeleport:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 802 then
		warnMutateBug:Show()
		timerMutateBugCD:Start()
	elseif args.spellId == 804 then
		warnExplodeBug:Show()
		timerExplodeBugCD:Start()
	end
end
