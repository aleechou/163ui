local mod	= DBM:NewMod(656, "DBM-Party-MoP", 8, 311)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9886 $"):sub(12, -3))
mod:SetCreatureID(59150)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_AURA_REMOVED"
)

local warnPyroblast				= mod:NewSpellAnnounce(113690, 2, nil, false)
local warnQuickenedMind			= mod:NewSpellAnnounce(113682, 3)--This is Magic dispelable, you can't interrupt anything if you don't dispel this.
local warnFireballVolley		= mod:NewSpellAnnounce(113691, 3)
local warnBookBurner			= mod:NewSpellAnnounce(113364, 3)
local warnDragonsBreath			= mod:NewSpellAnnounce(113641, 4)--This is showing Magic dispelable in EJ, is it?

local specWarnFireballVolley	= mod:NewSpecialWarningInterrupt(113691, true)
local specWarnPyroblast			= mod:NewSpecialWarningInterrupt(113690, false)
local specWarnQuickenedMind		= mod:NewSpecialWarningDispel(113682, mod:IsMagicDispeller())
--local specWarnDragonsBreathDispel		= mod:NewSpecialWarningDispel(113641, mod:IsMagicDispeller())
local specWarnDragonsBreath		= mod:NewSpecialWarningSpell(113641, nil, nil, nil, true)
local specWarnBook				= mod:NewSpecialWarningMove(113620)

local timerPyroblastCD			= mod:NewCDTimer(6, 113690, nil, false)
--local timerQuickenedMindCD	= mod:NewCDTimer(30, 113682)--Needs more data. I see both 30 sec and 1 min cds, so I just need larger sample size.
--local timerFireballVolleyCD		= mod:NewCDTimer(30, 113691)--Seems very random, maybe affected by school lockout so kicking pyroblast prevents this?
local timerBookBurnerCD			= mod:NewCDTimer(15.5, 113364)
local timerDragonsBreath		= mod:NewBuffActiveTimer(10, 113641)
local timerDragonsBreathCD		= mod:NewNextTimer(50, 113641)

local quickcast = false

function mod:OnCombatStart(delay)
	timerPyroblastCD:Start(5-delay)
--	timerQuickenedMindCD:Start(9-delay)
--	timerFireballVolleyCD:Start(15.5-delay)
	timerBookBurnerCD:Start(20.5-delay)
	timerDragonsBreathCD:Start(30-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 113690 then
		warnPyroblast:Show()
		specWarnPyroblast:Show(args.sourceName)
		if (not quickcast) then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")--打斷施法
		end
		timerPyroblastCD:Start()
	elseif args.spellId == 113691 then
		warnFireballVolley:Show()
		specWarnFireballVolley:Show(args.sourceName)
		if (not quickcast) then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")--打斷施法
		end
--		timerFireballVolleyCD:Start()
	elseif args.spellId == 113364 then
		warnBookBurner:Show()
		timerBookBurnerCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 113626 then--Teleport, cast before dragons breath. Provides an earlier warning by almost 1 sec.
		timerPyroblastCD:Cancel()--Will just cast it instantly when dragon breath ends, Cd is irrelevant at this point.
		warnDragonsBreath:Show()
		specWarnDragonsBreath:Show()
		timerDragonsBreathCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 113682 and not args:IsDestTypePlayer() then
		specWarnQuickenedMind:Show(args.destName)
		if mod:IsMagicDispeller() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")--快驅散
		end
		quickcast = true
--		timerQuickenedMindCD:Start()
	elseif args.spellId == 113641 then--Actual dragons breath buff, don't want to give a dispel warning too early
--		specWarnDragonsBreath:Show(args.destName)
		timerDragonsBreath:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 113641 then
		timerDragonsBreath:Cancel()
	elseif args:IsSpellID(113682) then
		quickcast = false
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 113620 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnBook:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE