local mod	= DBM:NewMod("PlagueworksTrash", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4408 $"):sub(12, -3))

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"SPELL_CAST_START",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnZombies		= mod:NewSpellAnnounce(71159, 2)
local warnMortalWound	= mod:NewAnnounce("WarnMortalWound", 2, 71127, false)
local warnDecimateSoon	= mod:NewSoonAnnounce(71123, 3)

local specWarnDecimate		= mod:NewSpecialWarningSpell(71123)
local specWarnMortalWound	= mod:NewSpecialWarningStack(71127, nil, 5)
local specWarnTrap			= mod:NewSpecialWarning("SpecWarnTrap")
local specWarnBlightBomb	= mod:NewSpecialWarningSpell(71088)

local timerZombies		= mod:NewNextTimer(20, 71159)
local timerMortalWound	= mod:NewTargetTimer(15, 71127)
local timerDecimate		= mod:NewNextTimer(33, 71123)
local timerBlightBomb	= mod:NewCastTimer(5, 71088)

local sndWOP				= mod:NewSound(nil, "SoundWOP", true)

mod:RemoveOption("HealthFrame")

local spamZombies = 0

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71127) then
		warnMortalWound:Show(args.spellName, args.destName, args.amount or 1)
		timerMortalWound:Start(args.destName)
--		if args:IsPlayer() and (args.amount or 1) >= 5 then
		if (args.amount or 1) >= 5 then
			specWarnMortalWound:Show(args.amount)
			if args.amount == 7 or args.amount == 9 then	
				if mod:IsTank() or mod:IsHealer() then		
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\changemt.mp3")
				end
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(71159) and GetTime() - spamZombies > 5 then
		warnZombies:Show()
		timerZombies:Start()
		spamZombies = GetTime()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(71123) then
		specWarnDecimate:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\killall.mp3")
		warnDecimateSoon:Cancel()	-- in case the first 1 is inaccurate, you wont have an invalid soon warning
		warnDecimateSoon:Schedule(28)
		timerDecimate:Start()
	elseif args:IsSpellID(71088) then
		specWarnBlightBomb:Show()
		timerBlightBomb:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 37025 then
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	elseif cid == 37217 then
		timerZombies:Cancel()
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.FleshreaperTrap1 or msg == L.FleshreaperTrap2 or msg == L.FleshreaperTrap3) and mod:LatencyCheck() then
		self:SendSync("FleshTrap")
	end
end

function mod:OnSync(msg, arg)
	if msg == "FleshTrap" then
		specWarnTrap:Show()
	end
end