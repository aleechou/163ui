local mod	= DBM:NewMod(170, "DBM-BlackwingDescent", nil, 73)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(41570)
mod:SetZone()
mod:SetModelSound("Sound\\Creature\\Nefarian\\VO_BD_Nefarian_MagmawIntro01.wav", nil)
--Long: I found this fascinating specimen in the lava underneath this very room. Magmaw should provide an adequate challenge for your pathetic little band.
--Short: There isn't one

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"UNIT_HEALTH boss1",
	"UNIT_DIED"
)

local warnLavaSpew			= mod:NewSpellAnnounce(77689, 3, nil, mod:IsHealer())
local warnPillarFlame		= mod:NewSpellAnnounce(78006, 3)
local warnMoltenTantrum		= mod:NewSpellAnnounce(78403, 4)
local warnInferno			= mod:NewSpellAnnounce(92154, 4)
local warnMangle			= mod:NewTargetAnnounce(89773, 3)
local warnArmageddon		= mod:NewSpellAnnounce(92177, 4)
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)--heroic
local warnPhase2			= mod:NewPhaseAnnounce(2, 4)--heroic

local specWarnPillar		= mod:NewSpecialWarningSpell(78006)
local specWarnIgnition		= mod:NewSpecialWarningMove(92128)
local specWarnInfernoSoon   = mod:NewSpecialWarning("SpecWarnInferno")
local specWarnInfection		= mod:NewSpecialWarningYou(94679)
local specWarnArmageddon	= mod:NewSpecialWarningSpell(92177, not mod:IsHealer(), nil, nil, true)

local timerLavaSpew			= mod:NewCDTimer(22, 77689, nil, mod:IsHealer())
local timerPillarFlame		= mod:NewCDTimer(32.5, 78006)--This timer is a CD timer. 30-40 seconds. Use your judgement.
local timerMangle			= mod:NewTargetTimer(30, 89773)
local timerExposed			= mod:NewBuffActiveTimer(30, 79011)
local timerMangleCD			= mod:NewCDTimer(95, 89773)
local timerInferno			= mod:NewNextTimer(35, 92154)
local timerArmageddon		= mod:NewCastTimer(8, 92177)

local berserkTimer			= mod:NewBerserkTimer(600)

local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:AddBoolOption("RangeFrame")

local geddonConstruct = 0
local prewarnedPhase2 = false

function mod:OnCombatStart(delay)
	geddonConstruct = 0
	prewarnedPhase2 = false
	timerPillarFlame:Start(30-delay)
	timerMangleCD:Start(90-delay)
	timerLavaSpew:Start(19-delay)
	if mod:IsHealer() then
		sndWOP:Schedule(17-delay, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")	
	end
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerInferno:Start(30-delay)
		specWarnInfernoSoon:Schedule(26-delay)
		sndWOP:Schedule(27-delay, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ghostsoon.mp3")
		sndWOP:Schedule(28-delay, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(29-delay, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(30-delay, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	end
	DBM.BossHealth:Clear()
	DBM.BossHealth:AddBoss(41570, 42347, L.name)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78006) then--More than one spellid?
		warnPillarFlame:Show()
		specWarnPillar:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\pillar.mp3")
		timerPillarFlame:Start()
	elseif args:IsSpellID(78403) then
		warnMoltenTantrum:Show()
	elseif args:IsSpellID(89773, 91912, 94616, 94617) then
		warnMangle:Show(args.destName)
		timerMangle:Start(args.destName)
		timerMangleCD:Start()
	elseif args:IsSpellID(94679, 78097, 78941, 91913, 94678) and args:IsPlayer() then
		specWarnInfection:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runout.mp3")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(89773, 91912, 94616, 94617) then
		timerMangle:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(77690, 91931, 91932, 91919) and self:AntiSpam(10, 1) then
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
		warnLavaSpew:Show()
		timerLavaSpew:Start()
		if mod:IsHealer() then
			sndWOP:Schedule(23, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
		end
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\lavaspew.mp3")
	elseif args:IsSpellID(92177) then
		warnArmageddon:Show()
		specWarnArmageddon:Show()
		if not mod:IsHealer() then
			timerArmageddon:Start()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\killghost.mp3")
		end
		geddonConstruct = args.sourceGUID--Cache last mob to cast armageddon
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(92154, 92190, 92191, 92192) then
		warnInferno:Show()
		specWarnInfernoSoon:Schedule(31)
		sndWOP:Schedule(32, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ghostsoon.mp3")
		sndWOP:Schedule(33, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(34, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(35, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		timerInferno:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 92128 or spellId == 92196 or spellId == 92197 or spellId == 92198) and destGUID == UnitGUID("player") and self:AntiSpam(4, 2) then
		specWarnIgnition:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

-- heroic phase 2
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		timerInferno:Cancel()
		specWarnInfernoSoon:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ghostsoon.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		warnPhase2:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Slump or msg:find(L.Slump) then
--		timerPillarFlame:Start(15)--Resets to 15. If you don't get his head down by then he gives you new adds to mess with. (theory, don't have a lot of logs with chain screwups yet)
		timerPillarFlame:Cancel()
	elseif msg == L.HeadExposed or msg:find(L.HeadExposed) then
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
		timerExposed:Start()
		timerPillarFlame:Start(40)
		timerLavaSpew:Start(35)
		if mod:IsHealer() then
			sndWOP:Schedule(32, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")	
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 41570 and self:IsDifficulty("heroic10", "heroic25") then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 29 and h < 34 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end

function mod:UNIT_DIED(args)
	if args.destGUID == geddonConstruct then--Check GUID of units dying if they match last armageddon casting construct. Better than CID alone so we don't cancel it if a diff one dies, but probably not perfect if two cast it at once heh.
		timerArmageddon:Cancel()
	end
end