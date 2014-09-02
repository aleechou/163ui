local mod	= DBM:NewMod("PlagueworksTrash", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 45 $"):sub(12, -3))
mod:SetModelID(30483)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"SPELL_CAST_START",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnZombies			= mod:NewSpellAnnounce(71159, 2)
local warnMortalWound		= mod:NewStackAnnounce(71127, 2, nil, mod:IsTank() or mod:IsHealer())
local warnDecimateSoon		= mod:NewSoonAnnounce(71123, 3)

local specWarnDecimate		= mod:NewSpecialWarningSpell(71123)
local specWarnMortalWound	= mod:NewSpecialWarningStack(71127, mod:IsTank() or mod:IsHealer(), 5)
local specWarnTrap			= mod:NewSpecialWarning("SpecWarnTrap")
local specWarnBlightBomb	= mod:NewSpecialWarningSpell(71088)

local timerZombies			= mod:NewNextTimer(20, 71159)
local timerMortalWound		= mod:NewTargetTimer(15, 71127)
local timerDecimate			= mod:NewNextTimer(33, 71123)
local timerBlightBomb		= mod:NewCastTimer(5, 71088)

local sndWOP				= mod:NewSound(nil, "SoundWOP", true)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 71127 then
		local amount = args.amount or 1
		warnMortalWound:Show(args.destName, amount)
		timerMortalWound:Start(args.destName)
		if args:IsPlayer() and amount >= 5 then
			specWarnMortalWound:Show(amount)
			if amount == 7 or amount == 9 then	
				if mod:IsTank() or mod:IsHealer() then		
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\changemt.mp3")
				end
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_SUMMON(args)
	if args.spellId == 71159 and self:AntiSpam(5) then
		warnZombies:Show()
		timerZombies:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 71123 then
		specWarnDecimate:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\killall.mp3")
		warnDecimateSoon:Cancel()	-- in case the first 1 is inaccurate, you wont have an invalid soon warning
		warnDecimateSoon:Schedule(28)
		timerDecimate:Start()
	elseif args.spellId == 71088 then
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
	if (msg == L.FleshreaperTrap1 or msg == L.FleshreaperTrap2 or msg == L.FleshreaperTrap3) and self:LatencyCheck() then
		self:SendSync("FleshTrap")
	end
end

function mod:OnSync(msg, arg)
	if msg == "FleshTrap" then
		specWarnTrap:Show()
	end
end
