local mod	= DBM:NewMod(859, "DBM-Pandaria", nil, 322, 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3 $"):sub(12, -3))
mod:SetCreatureID(71954)
mod:SetReCombatTime(20)
mod:SetZone()

mod:RegisterCombat("combat_yell", L.Pull)
mod:RegisterKill("yell", L.Victory, L.VictoryDem)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144610 144611 144608",
	"SPELL_AURA_APPLIED 144606",
	"SPELL_AURA_APPLIED_DOSE 144606",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local warnHeadbutt				= mod:NewSpellAnnounce(144610, 3, nil, mod:IsTank())
local warnOxenFortitude			= mod:NewStackAnnounce(144606, 2, nil, false)--144607 player version, but better to just track boss and announce stacks
local warnMassiveQuake			= mod:NewSpellAnnounce(144611, 3)
local warnCharge				= mod:NewSpellAnnounce(144609, 4)

local specWarnHeadbutt			= mod:NewSpecialWarningSpell(144610, mod:IsTank())
local specWarnMassiveQuake		= mod:NewSpecialWarningSpell(144611, nil, nil, nil, 2)
local specWarnCharge			= mod:NewSpecialWarningRun(144609, mod:IsMelee())--66 and 33%. Maybe add pre warns

local timerHeadbuttCD			= mod:NewCDTimer(47, 144610, nil, mod:IsTank())
local timerMassiveQuake			= mod:NewBuffActiveTimer(13, 144611)
local timerMassiveQuakeCD		= mod:NewCDTimer(48, 144611)

mod:AddReadyCheckOption(33117, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerHeadbuttCD:Start(16-delay)
		timerMassiveQuakeCD:Start(45-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144610 then
		warnHeadbutt:Show()
		specWarnHeadbutt:Show()
		timerHeadbuttCD:Start()
	elseif spellId == 144611 then
		warnMassiveQuake:Show()
		specWarnMassiveQuake:Show()
		timerMassiveQuake:Start()
		timerMassiveQuakeCD:Start()
	elseif spellId == 144608 then
		warnCharge:Show()
		specWarnCharge:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 144606 then
		warnOxenFortitude:Show(args.destName, args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 148318 or spellId == 148317 or spellId == 149304 and self:AntiSpam(3, 2) then--use all 3 because i'm not sure which ones fire on repeat kills
		self:SendSync("Victory")
	end
end

function mod:OnSync(msg)
	if msg == "Victory" and self:IsInCombat() then
		DBM:EndCombat(self)
	end
end
