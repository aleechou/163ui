local mod	= DBM:NewMod("BrawlRank6", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 11898 $"):sub(12, -3))
mod:SetModelID(39166)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 141104 124860 124935",
	"SPELL_AURA_APPLIED 134789",
	"SPELL_AURA_APPLIED_DOSE 134789"
)

local warnFallenKin				= mod:NewStackAnnounce(134789, 3)--Yikkan Izu
local warnHammerFist			= mod:NewCastAnnounce(141104, 4)--Doctor FIST
local warnRainDance				= mod:NewSpellAnnounce(124860, 4)--Proboskus
local warnTorrent				= mod:NewSpellAnnounce(124935, 4)--Proboskus

local specWarnHammerFist		= mod:NewSpecialWarningRun(141104, nil, nil, nil, 3)--Doctor FIST
local specWarnRainDance			= mod:NewSpecialWarningSpell(124860, nil, nil, nil, true)--Proboskus
local specWarnTorrent			= mod:NewSpecialWarningInterrupt(124935)--Proboskus

local timerFallenKin			= mod:NewBuffActiveTimer(2, 134789)--Yikkan Izu
local timerRainDanceCD			= mod:NewCDTimer(18, 124860)--Proboskus
local timerTorrentCD			= mod:NewCDTimer(18, 124935)--Proboskus

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 141104 then
		warnHammerFist:Show()
		if brawlersMod:PlayerFighting() then
			specWarnHammerFist:Show()
		end
	elseif args.spellId == 124860 then
		warnRainDance:Show()
		timerRainDanceCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnRainDance:Show()
		end
	elseif args.spellId == 124935 then
		warnTorrent:Show()
		timerTorrentCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnTorrent:Show(args.sourceName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 134789 then
		warnFallenKin:Cancel()
		warnFallenKin:Schedule(0.5, args.destName, args.amount or 1)
		timerFallenKin:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED