local mod	= DBM:NewMod("BrawlRank4", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9770 $"):sub(12, -3))
mod:SetModelID(28115)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"UNIT_TARGET",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local warnCharging				= mod:NewSpellAnnounce(133253, 3)
local warnEarthSeed				= mod:NewSpellAnnounce(134743, 3)
local warnSolarBeam				= mod:NewSpellAnnounce(129888, 3)

local timerChargingCD			= mod:NewCDTimer(20, 133253)--20-24 sec variation.
local timerEarthSeedCD			= mod:NewCDTimer(15.5, 134743)
local timerSolarBeamCD			= mod:NewCDTimer(18.5, 129888)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("SetIconOnDominika", true)

local brawlersMod = DBM:GetModByName("Brawlers")
local DominikaGUID = 0

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 134743 then
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
		warnEarthSeed:Show()
		timerEarthSeedCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 129888 and self:AntiSpam() then
		warnSolarBeam:Show()
		timerSolarBeamCD:Start()
		if mod:IsManaUser() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
		end
	elseif args.spellId == 133129 then
		DominikaGUID = args.destGUID
	end
end

function mod:UNIT_TARGET()
	if self.Options.SetIconOnDominika and not DBM.Options.DontSetIcons and UnitGUID("target") == DominikaGUID then
		SetRaidTarget("target", 8)
	end
end

--It is however the ONLY event you can detect this spell using.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if spellId == 133253 and self:AntiSpam() then
		warnCharging:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
		timerChargingCD:Start()
	end
end