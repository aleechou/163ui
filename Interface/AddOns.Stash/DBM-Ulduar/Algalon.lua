local mod	= DBM:NewMod("Algalon", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 47 $"):sub(12, -3))
mod:SetCreatureID(32871)
mod:SetModelID(28641)
mod:SetModelSound("Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_Aggro01.wav", "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_Slay02.wav")
mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(20)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH target focus mouseover"
)

local announceBigBang			= mod:NewSpellAnnounce(64584, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnPhase2Soon			= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnFirstPull				= mod:NewAnnounce("FirstPullNotice", 2, nil, nil, false)
local announcePreBigBang		= mod:NewPreWarnAnnounce(64584, 10, 3)
local announceBlackHole			= mod:NewSpellAnnounce(65108, 2)
local announceCosmicSmash		= mod:NewSpellAnnounce(64596, 4)
local announcePhasePunch		= mod:NewAnnounce("WarningPhasePunch", 4, 65108, mod:IsHealer() or mod:IsTank())

local specwarnStarLow			= mod:NewSpecialWarning("warnStarLow", mod:IsHealer() or mod:IsTank())
local specWarnPhasePunch		= mod:NewSpecialWarningStack(64412, nil, 4)
local specWarnBigBang			= mod:NewSpecialWarningSpell(64584)
local specWarnCosmicSmash		= mod:NewSpecialWarningSpell(64596)

local timerCombatStart		    = mod:NewTimer(7, "TimerCombatStart", 2457)
local enrageTimer				= mod:NewBerserkTimer(360)
local timerNextBigBang			= mod:NewNextTimer(90.5, 64584)
local timerBigBangCast			= mod:NewCastTimer(8, 64584)
local timerNextCollapsingStar	= mod:NewTimer(15, "NextCollapsingStar", 50288)
local timerCDCosmicSmash		= mod:NewCDTimer(25, 64596)
local timerCastCosmicSmash		= mod:NewCastTimer(4.5, 64596)
local timerPhasePunch			= mod:NewBuffActiveTimer(45, 64412)
local timerNextPhasePunch		= mod:NewNextTimer(16, 64412)

local sentLowHP = {}
local warnedLowHP = {}
local warned_preP2 = false
local warned_star = false

local sndWOP				= mod:NewSound(nil, "SoundWOP", true)

function mod:OnCombatStart(delay)
	warned_preP2 = false
	warned_star = false
	enrageTimer:Start(368-delay)--All timers +8 for combat start RP
	timerNextBigBang:Start(98-delay)
	announcePreBigBang:Schedule(88-delay)
	timerCDCosmicSmash:Start(33-delay)
	timerNextCollapsingStar:Start(23-delay)
	timerCombatStart:Start(-delay)
	table.wipe(sentLowHP)
	table.wipe(warnedLowHP)
	sndWOP:Schedule(88, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\indoorsoon.mp3")
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64584, 64443) then 	-- Big Bang
		timerBigBangCast:Start()
		timerNextBigBang:Start()
		announceBigBang:Show()
		announcePreBigBang:Schedule(80)
		sndWOP:Schedule(80, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\indoorsoon.mp3")
		specWarnBigBang:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\indoornow.mp3")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(65108, 64122) then 	-- Black Hole Explosion
		announceBlackHole:Show()
		warned_star = false
	elseif args:IsSpellID(64598, 62301) then	-- Cosmic Smash
		timerCastCosmicSmash:Start()
		timerCDCosmicSmash:Start()
		announceCosmicSmash:Show()
		specWarnCosmicSmash:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\meteorrun.mp3")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64412 then
		timerNextPhasePunch:Start()
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 4 then
			specWarnPhasePunch:Show(args.amount)
		end
		timerPhasePunch:Start(args.destName)
		announcePhasePunch:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Emote_CollapsingStar or msg:find(L.Emote_CollapsingStar) then
		timerNextCollapsingStar:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.FirstPull or msg:find(L.FirstPull) then--Additional pull yell on first pull 11 seconds before actual combat, all timers +11, auto correct timers.
		enrageTimer:Start(371)
		timerNextBigBang:Start(101)
		announcePreBigBang:Schedule(91)
		timerCDCosmicSmash:Start(36)
		timerNextCollapsingStar:Start(26)
		timerCombatStart:Start(11)
		warnFirstPull:Show()
	elseif msg == L.Phase2 or msg:find(L.Phase2) then
		timerNextCollapsingStar:Cancel()
		warnPhase2:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	local cid = self:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	if cid == 32871 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 and not warned_preP2 then
		warned_preP2 = true
		warnPhase2Soon:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")
	elseif cid == 32955 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and not sentLowHP[guid] then
		sentLowHP[guid] = true
		self:SendSync("lowhealth", guid)
	end
end

function mod:OnSync(msg, guid)
	if msg == "lowhealth" and guid and not warnedLowHP[guid] then
		warnedLowHP[guid] = true
		specwarnStarLow:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\stardie.mp3")
	end
end
