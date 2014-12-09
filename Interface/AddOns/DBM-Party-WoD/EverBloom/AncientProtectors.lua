local mod	= DBM:NewMod(1207, "DBM-Party-WoD", 5, 556)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11894 $"):sub(12, -3))
mod:SetCreatureID(83894, 83892, 83893)--Dulhu 83894, Gola 83892, Telu
mod:SetEncounterID(1757)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 168082 168041 168105 168383 175997",
	"SPELL_AURA_APPLIED 168105 168041 168520",
	"SPELL_AURA_REMOVED 168520",
	"SPELL_PERIODIC_DAMAGE 167977",
	"SPELL_PERIODIC_MISSED 167977",
	"UNIT_DIED"
)

--Timers are too difficult to do, rapidTides messes up any chance of ever having decent timers.
local warnRevitalizingWaters		= mod:NewSpellAnnounce(168082, 4)
local warnBriarskin					= mod:NewTargetAnnounce("OptionVersion2", 168041, 3, nil, mod:IsMagicDispeller())
local warnRapidTides				= mod:NewTargetAnnounce(168105, 4)
local warnSlash						= mod:NewSpellAnnounce("OptionVersion2", 168383, 3, nil, mod:IsMelee())
local warnNoxious					= mod:NewSpellAnnounce("OptionVersion2", 175997, 3)
local warnShapersFortitude			= mod:NewTargetAnnounce(168520, 3)

local specWarnRevitalizingWaters	= mod:NewSpecialWarningInterrupt(168082, not mod:IsHealer())
local specWarnBriarskin				= mod:NewSpecialWarningInterrupt(168041, false)--if you have more than one interruptor, great. but off by default because we can't assume you can interrupt every bosses abilities. and heal takes priority
local specWarnBriarskinDispel		= mod:NewSpecialWarningDispel(168041, false)--Not as important as rapid Tides and to assume you have at least two dispellers is big assumption
local specWarnRapidTidesDispel		= mod:NewSpecialWarningDispel(168105, mod:IsMagicDispeller(), nil, nil, 3)
local specWarnSlash					= mod:NewSpecialWarningSpell(168383, mod:IsMelee(), nil, nil, 2)--Because it's 8 yard cone in random direction.
local specWarnNoxious				= mod:NewSpecialWarningRun("OptionVersion2", 175997)
local specWarnBramble				= mod:NewSpecialWarningMove(167977)

local timerShapersFortitude			= mod:NewTargetTimer("OptionVersion2", 15, 168520, nil, false)
local timerNoxiousCD				= mod:NewCDTimer(16, 175997, nil, mod:IsMelee())

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 168082 then
		warnRevitalizingWaters:Show()
		specWarnRevitalizingWaters:Show(args.sourceName)
		if mod:IsTank() then
			sndWOP:Play("kickcast")
		else
			sndWOP:Play("helpkick")
		end
	elseif spellId == 168041 then
		specWarnBriarskin:Show(args.sourceName)
	elseif spellId == 168383 then
		warnSlash:Show()
		specWarnSlash:Show()
	elseif spellId == 175997 then
		warnNoxious:Show()
		specWarnNoxious:Show()
		timerNoxiousCD:Start()
		if mod:IsMelee() then
			sndWOP:Play("watchstep")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 168105 then
		warnRapidTides:Show(args.destName)
		specWarnRapidTidesDispel:Show(args.destName)
		if mod:IsMagicDispeller() then
			sndWOP:Play("dispelboss")
		end
	elseif spellId == 168041 then
		warnBriarskin:Show(args.destName)
		specWarnBriarskinDispel:Show(args.destName)
	elseif spellId == 168520 then
		warnShapersFortitude:Show(args.destName)
		timerShapersFortitude:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 168520 then
		timerShapersFortitude:Cancel(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 167977 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBramble:Show()
		sndWOP:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 83894 then
		timerNoxiousCD:Cancel()
	end
end
