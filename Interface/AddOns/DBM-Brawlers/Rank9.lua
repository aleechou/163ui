local mod	= DBM:NewMod("BrawlRank9", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 10689 $"):sub(12, -3))
mod:SetModelID(47854)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

--Boss Key
--http://mysticalos.com/images/MoP/new_brawlers/rank9.jpeg
local warnSpitAcid				= mod:NewSpellAnnounce(141013, 4)
local warnHammerFist			= mod:NewCastAnnounce(141104, 4)
local warnBulwark				= mod:NewAddsLeftAnnounce(138901, 2)
local warnCharge				= mod:NewCastAnnounce(138845, 1)
local warnCompleteHeal			= mod:NewCastAnnounce(142621, 4)
local warnDivineCircle			= mod:NewSpellAnnounce(142585, 3)

local specWarnSpitAcid			= mod:NewSpecialWarningSpell(141013)
local specWarnHammerFist		= mod:NewSpecialWarningRun(141104, nil, nil, nil, 3)
local specWarnCharge			= mod:NewSpecialWarningSpell(138845)
local specWarnCompleteHeal		= mod:NewSpecialWarningInterrupt(142621, nil, nil, nil, 3)--Not interrupting even once is a complete wipe
local specWarnDivineCircle		= mod:NewSpecialWarningMove(142585)

local timerSpitAcidCD			= mod:NewNextTimer(20, 141013)
local timerDivineCircleCD		= mod:NewCDTimer(35, 142585)--Insufficent data to say if accurate with certainty

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 142621 then
		warnCompleteHeal:Show()
		if brawlersMod:PlayerFighting() then
			specWarnCompleteHeal:Show(args.sourceName)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")
		end
	elseif args.spellId == 141104 then
		warnHammerFist:Show()
		if brawlersMod:PlayerFighting() then
			specWarnHammerFist:Show()
		end
	elseif args.spellId == 138845 then
		warnCharge:Show()
		if brawlersMod:PlayerFighting() then
			specWarnCharge:Show()
		end
	elseif args.spellId == 142583 then
		warnDivineCircle:Show()
		timerDivineCircleCD:Start()
		if args:IsPlayer() then
			specWarnDivineCircle:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 141013 then
		warnSpitAcid:Show()
		timerSpitAcidCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnSpitAcid:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 138901 then
		warnBulwark:Show(args.amount or 0)
	end
end
mod.SPELL_AURA_REMOVED = mod.SPELL_AURA_APPLIED_DOSE
