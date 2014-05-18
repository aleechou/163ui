local mod	= DBM:NewMod(171, "DBM-BlackwingDescent", nil, 73)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7782 $"):sub(12, -3))
mod:SetCreatureID(41442)
mod:SetModelID(34547)
mod:SetZone()
mod:SetUsedIcons(8)
mod:SetModelSound("Sound\\Creature\\Nefarian\\VO_BD_Nefarian_AtramedesIntro.wav", "Sound\\Creature\\Atramedes\\VO_BD_Atramedes_Event03.wav")
--Long: Atramedes, are you going deaf as well as blind? Hurry up and kill them all.
--Short: Death waits in the darkness!

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_AURA"
)

local warnSonarPulse		= mod:NewSpellAnnounce(77672, 3)
local warnSonicBreath		= mod:NewSpellAnnounce(78075, 3)
local warnTracking			= mod:NewTargetAnnounce(78092, 4)
local warnAirphase			= mod:NewSpellAnnounce("ej3081", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnGroundphase		= mod:NewSpellAnnounce("ej3061", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnShieldsLeft		= mod:NewAddsLeftAnnounce("ej3073", 2, 77611)
local warnAddSoon			= mod:NewSoonAnnounce("ej3082", 3, 92685)
local warnPhaseShift		= mod:NewSpellAnnounce(92681, 3)
local warnObnoxious			= mod:NewCastAnnounce(92677, 4, nil, false)
local warnSearingFlameSoon	= mod:NewSoonAnnounce(77840, 3, nil, false)

local specWarnSearingFlame	= mod:NewSpecialWarningSpell(77840, nil, nil, nil, true)
local specWarnSonarPulse	= mod:NewSpecialWarningSpell(77672, false, nil, nil, true)
local specWarnTracking		= mod:NewSpecialWarningYou(78092)
local specWarnPestered		= mod:NewSpecialWarningYou(92685)
local specWarnObnoxiousFiend		= mod:NewSpecialWarning("SpecWarnFiend")
local yellPestered			= mod:NewYell("ej3082")
local specWarnObnoxious		= mod:NewSpecialWarningInterrupt(92677, mod:IsMelee())
local specWarnAddTargetable	= mod:NewSpecialWarningSwitch("ej3082", mod:IsRanged())

local timerSonarPulseCD		= mod:NewCDTimer(10, 77672)
local timerSonicBreath		= mod:NewCDTimer(41, 78075)
local timerSearingFlame		= mod:NewCDTimer(45, 77840)
local timerAirphase			= mod:NewNextTimer(85, "ej3081", nil, nil, nil, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")--These both need more work
local timerGroundphase		= mod:NewNextTimer(31.5, "ej3061", nil, nil, nil, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")--I just never remember to log and /yell at right times since they lack most accurate triggers.
local timerObnoxiousFiend			= mod:NewTimer(16, "TimerFiend")
local timerModulation		= mod:NewCDTimer(15, 77612)

local berserkTimer			= mod:NewBerserkTimer(600)

local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
--local soundTracking			= mod:NewSound(78092)

mod:AddBoolOption("TrackingIcon")
mod:AddBoolOption("InfoFrame")

local shieldsLeft = 10
local pestered = GetSpellInfo(92685)
local pesteredWarned = false
local SoundLevel = EJ_GetSectionInfo(3072)

local function groundphase()
	timerAirphase:Start()
	timerModulation:Start()
	timerSonicBreath:Start(25)
	sndWOP:Schedule(22, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\sonicsoon.mp3")
	timerSearingFlame:Start()
	sndWOP:Schedule(42, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dangsoon.mp3")
	warnSearingFlameSoon:Schedule(40)
end

function mod:OnCombatStart(delay)
	timerSonarPulseCD:Start(-delay)
	timerSonicBreath:Start(25-delay)
	sndWOP:Schedule(21-delay, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\sonicsoon.mp3")
	timerModulation:Start(-delay)
	warnSearingFlameSoon:Schedule(40-delay)
	timerSearingFlame:Start(-delay)
	sndWOP:Schedule(42-delay, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dangsoon.mp3")
	timerAirphase:Start(90-delay)
	shieldsLeft = 10
	pesteredWarned = false
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(SoundLevel)
		DBM.InfoFrame:Show(5, "playerpower", 10, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78092) then
		warnTracking:Show(args.destName)
		if args:IsPlayer() then
			specWarnTracking:Show()
--			soundTracking:Play()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\justrun.mp3")
		end
		if self.Options.TrackingIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(92681) then
		specWarnObnoxiousFiend:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\fiend.mp3")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(78092) then
		if self.Options.TrackingIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(92681) then--Phase shift removed, add targetable/killable.
		specWarnAddTargetable:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(92677, 92702) then
		warnObnoxious:Show()
		if self:IsMelee() and (self:GetUnitCreatureId("target") == 49740 or self:GetUnitCreatureId("focus") == 49740) or not self:IsMelee() then
			specWarnObnoxious:Show(args.sourceName)--Only warn for melee targeting him or exclicidly put him on focus, else warn regardless if he's your target/focus or not if you aren't a melee
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(78075) then
		timerSonicBreath:Start()
		sndWOP:Schedule(39, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\sonicsoon.mp3")
		warnSonicBreath:Show()
		if mod:IsDifficulty("heroic10", "heroic25") then
			timerObnoxiousFiend:Start()
		end
	elseif args:IsSpellID(77840) then
		specWarnSearingFlame:Show()
	elseif args:IsSpellID(92681) then--Add is phase shifting which means a new one is spawning, or an old one is changing target cause their first target died.
		warnPhaseShift:Show()
		pesteredWarned = false--Might need more work on this.
	elseif args:IsSpellID(77672, 92411, 92412, 92413) then--Sonar Pulse (the discs)
		warnSonarPulse:Show()
		specWarnSonarPulse:Show()
		timerSonarPulseCD:Start()
	elseif args:IsSpellID(77612, 92451, 92452, 92453) then
		timerModulation:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:IsInCombat() and args:IsNPC() and self:GetCIDFromGUID(args.destGUID) ~= 49740 then
		shieldsLeft = shieldsLeft - 1
		warnShieldsLeft:Show(shieldsLeft)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Airphase or msg:find(L.Airphase)  then
		warnAirphase:Show()
		timerSonicBreath:Cancel()
		timerModulation:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\sonicsoon.mp3")
		timerSonarPulseCD:Cancel()
		timerGroundphase:Start()
		self:Schedule(31.5, groundphase)
	elseif msg == L.NefAdd or msg:find(L.NefAdd)  then
		warnAddSoon:Show()--Unfortunately it seems quite random when he does this so i cannot add a CD bar for it. i see variations as large as 20 seconds in between to a minute in between.
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" or pesteredWarned then return end
	if UnitDebuff("player", pestered) then
		pesteredWarned = true--This aura is a periodic trigger, so we don't want to spam warn for it.
		specWarnPestered:Show()
		yellPestered:Yell()
	end
end