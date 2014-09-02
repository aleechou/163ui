local mod	= DBM:NewMod("BrawlRank6", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9886 $"):sub(12, -3))
mod:SetModelID(39166)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

local warnFallenKin				= mod:NewStackAnnounce(134789, 3)
local warnShadowStrikes			= mod:NewSpellAnnounce(126209, 3)
local warnChainLightning		= mod:NewSpellAnnounce(39945, 3)
local warnToughLuck				= mod:NewStackAnnounce(134624, 1)
local warnShieldWaller			= mod:NewSpellAnnounce(134650, 2)

local specWarnShadowStrikes		= mod:NewSpecialWarningDispel(126209, mod:IsMagicDispeller())
local specWarnChainLightning	= mod:NewSpecialWarningInterrupt(39945)

local timerFallenKin			= mod:NewBuffActiveTimer(2, 134789)
local timerShadowStrikes		= mod:NewBuffActiveTimer(15, 126209)
local timerChainLightningCD		= mod:NewCDTimer(17, 39945)--I observed a 17-22 sec variation. A commenter on wowhead claims 14 sec cd but i have no logs to verify this yet
local timerShieldWaller			= mod:NewBuffActiveTimer(10, 134650)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 39945 then
		warnChainLightning:Show()
		timerChainLightningCD:Start()
		if brawlersMod:PlayerFighting() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")
			specWarnChainLightning:Show(args.sourceName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 134650 then
		warnShieldWaller:Show()
		timerShieldWaller:Start()
	elseif args.spellId == 108043 then
		warnToughLuck:Show(args.destName, args.amount or 1)
	elseif args.spellId == 134789 then
		warnFallenKin:Cancel()
		warnFallenKin:Schedule(0.5, args.destName, args.amount or 1)
		timerFallenKin:Start()
	elseif args.spellId == 126209 then
		warnShadowStrikes:Show()
		timerShadowStrikes:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShadowStrikes:Show(args.destName)
			if mod:IsMagicDispeller() then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 134650 then
		timerShieldWaller:Cancel()
	elseif args.spellId == 126209 then
		timerShadowStrikes:Cancel()
	end
end
