local mod	= DBM:NewMod("BrawlRank4", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 11898 $"):sub(12, -3))
mod:SetModelID(28115)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 141013",
	"SPELL_AURA_APPLIED 133129",
	"PLAYER_TARGET_CHANGED"
)

local warnSpitAcid				= mod:NewSpellAnnounce(141013, 4)--Nibbleh

local specWarnSpitAcid			= mod:NewSpecialWarningSpell(141013)--Nibbleh

local timerSpitAcidCD			= mod:NewNextTimer(20, 141013)--Nibbleh

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("SetIconOnDominika", true)--Dominika the Illusionist 

local brawlersMod = DBM:GetModByName("Brawlers")
local DominikaGUID = 0

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

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133129 then
		DominikaGUID = args.destGUID
	end
end

function mod:PLAYER_TARGET_CHANGED()
	if self.Options.SetIconOnDominika and not DBM.Options.DontSetIcons and UnitGUID("target") == DominikaGUID then
		SetRaidTarget("target", 8)
	end
end
