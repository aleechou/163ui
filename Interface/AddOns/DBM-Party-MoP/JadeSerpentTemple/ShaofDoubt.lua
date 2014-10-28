local mod	= DBM:NewMod(335, "DBM-Party-MoP", 1, 313)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 9469 $"):sub(12, -3))
mod:SetCreatureID(56439)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)


local warnWitherWill			= mod:NewSpellAnnounce(106736, 3)
local warnTouchofNothingness	= mod:NewTargetAnnounce(106113, 4)
local warnBoundsOfReality		= mod:NewSpellAnnounce(117665, 3)

local specWarnTouchOfNothingness= mod:NewSpecialWarningDispel(106113, mod:IsHealer())
local specWarnShadowsOfDoubt	= mod:NewSpecialWarningMove(110099)--Actually used by his trash, but in a speed run, you tend to pull it all together

local timerWitherWillCD			= mod:NewCDTimer(6, 106736)--6-10 second variations.
local timerTouchofNothingnessCD	= mod:NewCDTimer(15.5, 106113)--15.5~20 second variations.
local timerTouchofNothingness	= mod:NewTargetTimer(30, 106113)
local timerBoundsOfRealityCD	= mod:NewCDTimer(60, 117665)
local timerBoundsOfReality		= mod:NewBuffFadesTimer(30, 117665)

function mod:OnCombatStart(delay)
	timerWitherWillCD:Start(-delay)
	timerTouchofNothingnessCD:Start(13-delay)
	timerBoundsOfRealityCD:Start(22-delay)
	sndWOP:Schedule(18.5, DBM.SoundMMPath.."\\countfour.ogg")
	sndWOP:Schedule(19.5, DBM.SoundMMPath.."\\countthree.ogg")
	sndWOP:Schedule(20.5, DBM.SoundMMPath.."\\counttwo.ogg")
	sndWOP:Schedule(21.5, DBM.SoundMMPath.."\\countone.ogg")
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 106736 then
		warnWitherWill:Show()
		timerWitherWillCD:Start()
	elseif args.spellId == 106113 then--Start Cd here in case it's resisted
		timerTouchofNothingnessCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 117665 then
		warnBoundsOfReality:Show()
		timerWitherWillCD:Cancel()
		timerTouchofNothingnessCD:Cancel()
		timerBoundsOfReality:Start()
		timerBoundsOfRealityCD:Start()
		sndWOP:Schedule(56, DBM.SoundMMPath.."\\countfour.ogg")
		sndWOP:Schedule(57, DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Schedule(58, DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Schedule(59, DBM.SoundMMPath.."\\countone.ogg")
		sndWOP:Play(DBM.SoundMMPath.."\\phasechange.ogg")--階段轉換
	elseif args.spellId == 106113 then
		warnTouchofNothingness:Show(args.destName)
		specWarnTouchOfNothingness:Show(args.destName)
		timerTouchofNothingness:Start(args.destName)
		if mod:IsHealer() then
			sndWOP:Play(DBM.SoundMMPath.."\\dispelnow.ogg")--快驅散
		end
	elseif args.spellId == 110099 and args:IsPlayer() then
		specWarnShadowsOfDoubt:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 117665 then
		timerBoundsOfReality:Cancel()
	elseif args.spellId == 106113 then
		timerTouchofNothingness:Cancel(args.destName)
	end
end
