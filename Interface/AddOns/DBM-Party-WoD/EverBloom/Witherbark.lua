local mod	= DBM:NewMod(1214, "DBM-Party-WoD", 5, 556)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11483 $"):sub(12, -3))
mod:SetCreatureID(81522)
mod:SetEncounterID(1746)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 164357",
	"SPELL_CAST_SUCCESS 164275",
	"SPELL_PERIODIC_DAMAGE 169495 164294",
	"SPELL_PERIODIC_MISSED 169495 164294",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnParchedGrasp			= mod:NewSpellAnnounce(164357, 3, nil, mod:IsTank())
local warnBrittleBark			= mod:NewSpellAnnounce(164275, 2)
local warnUncheckedGrowth		= mod:NewSpellAnnounce("ej10098", 3, 164294)

local specWarnLivingLeaves		= mod:NewSpecialWarningMove(169495)
local specWarnUncheckedGrowth	= mod:NewSpecialWarningMove(164294)
local specWarnUncheckedGrowthAdd= mod:NewSpecialWarningSwitch("ej10098", mod:IsTank())
local specWarnParchedGrasp		= mod:NewSpecialWarningSpell(164357, mod:IsTank())
local specWarnBrittleBark		= mod:NewSpecialWarningEnd(164275, false)--Added for sake of adding. Not important enough to be a default though.

local timerParchedGrasp			= mod:NewCDTimer(12, 164357)


function mod:OnCombatStart(delay)
	timerParchedGrasp:Start(7-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 164357 then
		warnParchedGrasp:Show()
		specWarnParchedGrasp:Show()
		timerParchedGrasp:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 164275 then
		warnBrittleBark:Show()
		timerParchedGrasp:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 169495 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		sndWOP:Play("runaway")
		specWarnLivingLeaves:Show()
	elseif spellId == 164294 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		sndWOP:Play("runaway")
		specWarnUncheckedGrowth:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164718 then--Cancel Brittle Bark
		specWarnBrittleBark:Show()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)--Message doesn't matter, it occurs only for one thing during this fight
	if mod:IsTank() then
		sndWOP:Play("changetarget")
	end
	warnUncheckedGrowth:Show()
	specWarnUncheckedGrowthAdd:Show()
end

