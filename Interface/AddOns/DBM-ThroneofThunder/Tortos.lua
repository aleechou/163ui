local mod	= DBM:NewMod(825, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndXG		= mod:SoundMM("SoundXG")
local sndAE		= mod:SoundMM("SoundAE")

mod:SetRevision(("$Revision: 11193 $"):sub(12, -3))
mod:SetCreatureID(67977)
mod:SetEncounterID(1565)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_POWER",
	"UNIT_AURA boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnBite						= mod:NewSpellAnnounce(135251, 3, nil, mod:IsTank())
local warnRockfall					= mod:NewSpellAnnounce(134476, 2)
local warnCallofTortos				= mod:NewSpellAnnounce(136294, 3)
local warnQuakeStomp				= mod:NewCountAnnounce(134920, 3)
local warnKickShell					= mod:NewAnnounce("warnKickShell", 2, 134031)
local warnStoneBreath				= mod:NewCastAnnounce(133939, 4)
local warnSummonBats				= mod:NewSpellAnnounce("ej7140", 3, 136685)
local warnShellConcussion			= mod:NewTargetAnnounce(136431, 1)

local specWarnCallofTortos			= mod:NewSpecialWarningSpell(136294)
local specWarnQuakeStomp			= mod:NewSpecialWarningCount(134920, nil, nil, nil, 2)
local specWarnRockfall				= mod:NewSpecialWarningSpell(134476, false, nil, nil, 2)
local specWarnStoneBreath			= mod:NewSpecialWarningInterrupt(133939, not mod:IsTank())
local specWarnCrystalShell			= mod:NewSpecialWarning("specWarnCrystalShell", false)
local specWarnSummonBats			= mod:NewSpecialWarningSwitch("ej7140", mod:IsTank())--Dps can turn it on too, but not on by default for dps cause quite frankly dps should NOT switch right away, tank needs to get aggro first and where they spawn is semi random.

local timerBiteCD					= mod:NewCDTimer(8, 135251, nil, mod:IsTank())
local timerRockfallCD				= mod:NewCDTimer(10, 134476)
local timerCallTortosCD				= mod:NewNextTimer(60.5, 136294)
local timerStompCD					= mod:NewNextCountTimer(49, 134920)
local timerBreathCD					= mod:NewCDTimer(46, 133939)--TODO, adjust timer when Growing Anger is cast, so we can use a Next bar more accurately
local timerSummonBatsCD				= mod:NewCDTimer(45, "ej7140", nil, nil, nil, 136685)--45-47. This doesn't always sync up to furious stone breath. Longer fight goes on more out of sync they get. So both bars needed I suppose
local timerStompActive				= mod:NewBuffActiveTimer(10.8, 134920)--Duration of the rapid caveins
local timerShellConcussion			= mod:NewBuffFadesTimer(20, 136431)

local berserkTimer					= mod:NewBerserkTimer(780)

mod:AddBoolOption("InfoFrame")
mod:AddBoolOption("SetIconOnTurtles", false)
mod:AddBoolOption("ClearIconOnTurtles", false)--Different option, because you may want auto marking but not auto clearing. or you may want auto clearning when they "die" but not auto marking when they spawn
mod:AddBoolOption("warnsj", true, "sound")

local shelldName = GetSpellInfo(137633)
local shellConcussion = GetSpellInfo(136431)
local stompActive = false
local stompCount = 0

local stomptime = 0

for i = 1, 4 do
	mod:AddBoolOption("dr"..i, false, "sound")
end

local function MyJS()
	if (mod.Options.dr1 and stompCount % 4 == 1) or (mod.Options.dr2 and stompCount % 4 == 2) or (mod.Options.dr3 and stompCount % 4 == 3) or (mod.Options.dr4 and stompCount % 4 == 0) then
		return true
	end
	return false
end

function mod:checkmydebuff()
    if not UnitDebuff("player", GetSpellInfo(137633)) then
		self:UnscheduleMethod("checkmydebuff")
		self:ScheduleMethod(7, "checkmydebuff")
		if not UnitIsDeadOrGhost("player") then
			if GetTime() - stomptime > 10 then
				specWarnCrystalShell:Show(shelldName)
				DBM.Flash:Shake(1, 1, 0)
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sjsl.ogg")--水晶碎裂
			end
		end
	end
end

local firstRockfall = false--First rockfall after a stomp
local shellsRemaining = 0
local lastConcussion = 0
local kickedShells = {}
local addsActivated = 0
local alternateSet = false
local adds = {}
local AddIcon = 6
local iconsSet = 3
local highestVersion = 0
local hasHighestVersion = false
local Warned = false

local function clearStomp()
	stompActive = false
	firstRockfall = false--First rockfall after a stomp
	if mod:AntiSpam(9, 1) then--prevent double warn.
		warnRockfall:Show()
		specWarnRockfall:Show()
		timerRockfallCD:Start()--Resume normal CDs, first should be 5 seconds after stomp spammed ones
	end
end

function mod:OnCombatStart(delay)
	stompActive = false
	stompCount = 0
	firstRockfall = false--First rockfall after a stomp
	shellsRemaining = 0
	lastConcussion = 0
	addsActivated = 0
	highestVersion = 0
	AddIcon = 6
	iconsSet = 3
	alternateSet = false
	Warned = false
	table.wipe(adds)
	table.wipe(kickedShells)
	timerRockfallCD:Start(15-delay)
	timerCallTortosCD:Start(21-delay)
	timerStompCD:Start(29-delay, 1)
	sndWOP:Schedule(24, DBM.SoundMMPath.."\\stompsoon.ogg")--準備踐踏
	timerBreathCD:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		if mod.Options.warnsj then
			mod:checkmydebuff()
		else
			specWarnCrystalShell:Show(shelldName)
			DBM.Flash:Shake(1, 1, 0)
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sjsl.ogg")--水晶碎裂
		end
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(L.WrongDebuff:format(shelldName))
			DBM.InfoFrame:Show(5, "playergooddebuff", 137633)
		end
		berserkTimer:Start(600-delay)
	else
		berserkTimer:Start(-delay)
	end
	if DBM:GetRaidRank() > 0 and self.Options.SetIconOnTurtles and not DBM.Options.DontSetIcons then--You can set marks and you have icons turned on
		self:SendSync("IconCheck", UnitGUID("player"), tostring(DBM.Revision))
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 133939 then
		warnStoneBreath:Show()
		if not self:IsDifficulty("lfr25") then
			specWarnStoneBreath:Show(args.sourceName)
		end
		timerBreathCD:Start()
		DBM.Flash:Shake(1, 0, 0)
		sndAE:Cancel(DBM.SoundMMPath.."\\aesoon.ogg")
		sndAE:Cancel(DBM.SoundMMPath.."\\countfive.ogg")
		sndAE:Cancel(DBM.SoundMMPath.."\\countfour.ogg")	
		sndAE:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndAE:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndAE:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		sndAE:Play(DBM.SoundMMPath.."\\kickcast.ogg")--快打斷
	elseif args.spellId == 136294 then
		warnCallofTortos:Show()
		specWarnCallofTortos:Show()
		if self:AntiSpam(59, 3) then -- On below 10%, he casts Call of Tortos always. This cast ignores cooldown, so filter below 10% cast.
			timerCallTortosCD:Start()
		end
		sndXG:Play(DBM.SoundMMPath.."\\ex_tt_xwg.ogg")--小烏龜出現
	elseif args.spellId == 135251 then
		if UnitName("boss1target") == UnitName("player") then
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_xxsy.ogg")--小心撕咬
		end
		warnBite:Show()
		timerBiteCD:Start()
	elseif args.spellId == 134920 then
		stompActive = true
		stompCount = stompCount + 1
		warnQuakeStomp:Show(stompCount)
		specWarnQuakeStomp:Show(stompCount)
		timerStompActive:Start()
		timerRockfallCD:Start(7.4)--When the spam of rockfalls start
		timerStompCD:Start(nil, stompCount+1)
		sndWOP:Schedule(45, DBM.SoundMMPath.."\\stompsoon.ogg")--準備踐踏
		if MyJS() then
			sndWOP:Play(DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
		else
			sndWOP:Play(DBM.SoundMMPath.."\\stompstart.ogg")--踐踏開始
		end
		stomptime = GetTime()
	end
end

local function resetaddstate()
	iconsSet = 0
	table.wipe(adds)
	if addsActivated >= 1 then--1 or more add is up from last set
		if alternateSet then--We check whether we started with skull last time or moon
			AddIcon = 3--Start with moon if we used skull last time
			alternateSet = false
		else
			AddIcon = 6--Start with skull if we used moon last time
			alternateSet = true
		end
	else--No turtles are up at all
		AddIcon = 6--Always start with skull
		alternateSet = true--And reset alternate status so we use moon next time (unless all are dead again, then re always reset to skull)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 133971 then--Shell Block (turtles dying and becoming kickable)
		shellsRemaining = shellsRemaining + 1
		addsActivated = addsActivated - 1
		if DBM:GetRaidRank() > 0 and self.Options.ClearIconOnTurtles then
			for uId in DBM:GetGroupMembers() do
				local unitid = uId.."target"
				local guid = UnitGUID(unitid)
				if args.destGUID == guid then
					SetRaidTarget(unitid, 0)
				end
			end
		end
	elseif args.spellId == 133974 and self.Options.SetIconOnTurtles then--Spinning Shell
		if self:AntiSpam(5, 6) then
			resetaddstate()
		end
		adds[args.destGUID] = AddIcon
		AddIcon = AddIcon + 1
		addsActivated = addsActivated + 1
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 137633 and args:IsPlayer() then
		if mod.Options.warnsj then
			mod:checkmydebuff()
		else
			specWarnCrystalShell:Show(shelldName)
			DBM.Flash:Shake(1, 1, 0)
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sjsl.ogg")--水晶碎裂
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 134476 then
		if stompActive then--10 second cd normally, but cd is disabled when stomp active
			if not firstRockfall then--Announce first one only and ignore the next ones spammed for about 9-10 seconds
				firstRockfall = true
				warnRockfall:Show()
				specWarnRockfall:Show()--To warn of massive incoming for the 9 back to back rockfalls that are incoming
				self:Schedule(10, clearStomp)
				if self:IsDifficulty("heroic10", "heroic25") then
					if mod.Options.warnsj then
						self:ScheduleMethod(12, "checkmydebuff")
					end
				end
			end
		else
			if self:AntiSpam(9, 1) then--sometimes clearstomp doesn't work? i can't find reason cause all logs match this system exactly.
				warnRockfall:Show()
				specWarnRockfall:Show()
				timerRockfallCD:Start()
			end
		end
	elseif args.spellId == 134031 and not kickedShells[args.destGUID] then--Kick Shell
		kickedShells[args.destGUID] = true
		shellsRemaining = shellsRemaining - 1
		warnKickShell:Show(args.spellName, args.sourceName, shellsRemaining)
	end
end

--Does not show in combat log, so UNIT_AURA must be used instead
function mod:UNIT_AURA(uId)
	local _, _, _, _, _, duration, expires = UnitDebuff(uId, shellConcussion)
	if expires and lastConcussion ~= expires then
		lastConcussion = expires
		timerShellConcussion:Start()
		if self:AntiSpam(3, 2) then
			warnShellConcussion:Show(L.name)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 136685 then --Don't filter main tank, bat tank often taunts boss just before bats for vengeance, otherwise we lose threat to dps. Then main tank taunts back after bats spawn and we go get them, fully vengeanced (if you try to pick up bats without vengeance you will not hold aggro for shit)
		warnSummonBats:Show()
		specWarnSummonBats:Show()
		timerSummonBatsCD:Start()
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_bfcx.ogg")--蝙蝠出現
	end
end

local function FindFastestHighestVersion()
	mod:SendSync("FastestPerson", UnitGUID("player"))
end

function mod:UNIT_POWER(uId)
	if (self:GetUnitCreatureId(uId) == 67977) and UnitPower(uId) > 85 and not Warned then
		Warned = true
		mod:SendSync("aesoon")
	elseif (self:GetUnitCreatureId(uId) == 67977) and UnitPower(uId) < 20 and Warned then
		Warned = false
	end
end

function mod:OnSync(msg, guid, ver)
	if msg == "IconCheck" and guid and ver then
		if tonumber(ver) > highestVersion then
			highestVersion = tonumber(ver)--Keep bumping highest version to highest we recieve from the icon setters
			if guid == UnitGUID("player") then--Check if that highest version was from ourself
				hasHighestVersion = true
				self:Unschedule(FindFastestHighestVersion)
				self:Schedule(5, FindFastestHighestVersion)
			else--Not from self, it means someone with a higher version than us probably sent it
				self:Unschedule(FindFastestHighestVersion)
				hasHighestVersion = false
			end
		end
	elseif msg == "FastestPerson" and guid and self:AntiSpam(10, 4) then--Whoever sends this sync first wins all. They have highest version and fastest computer
		self:Unschedule(FindFastestHighestVersion)
		if guid == UnitGUID("player") then
			hasHighestVersion = true
		else
			hasHighestVersion = false
		end
	elseif msg == "aesoon" then
		if mod:AntiSpam(15, 10) then
			sndAE:Schedule(0.5, DBM.SoundMMPath.."\\aesoon.ogg") --準備AE
			sndAE:Schedule(1, DBM.SoundMMPath.."\\countfour.ogg")	
			sndAE:Schedule(2, DBM.SoundMMPath.."\\countthree.ogg")
			sndAE:Schedule(3, DBM.SoundMMPath.."\\counttwo.ogg")
			sndAE:Schedule(4, DBM.SoundMMPath.."\\countone.ogg")
		end
	end
end