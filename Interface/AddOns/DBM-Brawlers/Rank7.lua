local mod	= DBM:NewMod("BrawlRank7", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
mod:SetRevision(("$Revision: 10922 $"):sub(12, -3))
mod:SetModelID(46798)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 133212 125212 133465 133017",
	"SPELL_AURA_APPLIED 133015 133018"
)

local warnRockets				= mod:NewCastAnnounce(133212, 4)
local warnShadowbolt			= mod:NewSpellAnnounce(125212, 3)
local warnGhost					= mod:NewSpellAnnounce(133465, 4)
local warnMines					= mod:NewCountAnnounce(133018, 3)
local warnMinesSpawning			= mod:NewSpellAnnounce(133015, 4)

local specWarnShadowbolt		= mod:NewSpecialWarningSpell(125212, false)--Let you choose which one is important to warn for
local specWarnGhost				= mod:NewSpecialWarningSpell(133465, false)
local specWarnMinesSpawning		= mod:NewSpecialWarningSpell(133015)

local timerRockets				= mod:NewBuffActiveTimer(9, 133212)
local timerShadowboltCD			= mod:NewCDTimer(12, 125212)
local timerGhostCD				= mod:NewNextTimer(13, 133465)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")
local remainingMines = 8

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133212 then
		warnRockets:Show()
		timerRockets:Schedule(4)
	elseif args.spellId == 125212 then
		warnShadowbolt:Show()
		timerShadowboltCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShadowbolt:Show()
		end
	elseif args.spellId == 133465 then
		warnGhost:Show()
		timerGhostCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnGhost:Show()
		end
	elseif args.spellId == 133017 then
		remainingMines = remainingMines - 1
		warnMines:Show(remainingMines)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 133015 then
--		remainingMines = 8
		warnMinesSpawning:Show()
		if brawlersMod:PlayerFighting() then
			specWarnMinesSpawning:Show()
		end
	elseif args.spellId == 133018 then
		remainingMines = 8
	end
end
