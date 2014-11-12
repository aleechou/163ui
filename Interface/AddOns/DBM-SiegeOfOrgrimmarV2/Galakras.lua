﻿local mod	= DBM:NewMod(868, "DBM-SiegeOfOrgrimmarV2", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndZQ		= mod:SoundMM("SoundZQ")
local sndTT		= mod:SoundMM("SoundTT")

mod:SetRevision(("$Revision: 11389 $"):sub(12, -3))
mod:SetCreatureID(72311, 72560, 72249, 73910, 72302, 72561, 73909)--Boss needs to engage off friendly NCPS, not the boss. I include the boss too so we don't detect a win off losing varian. :)
mod:SetEncounterID(1622)
mod:SetMinSyncRevision(10768)
mod:SetHotfixNoticeRev(10768)
mod:SetReCombatTime(180, 15)--fix combat re-starts after killed. Same issue as tsulong. Fires TONS of IEEU for like 1-2 minutes after fight ends.
mod:SetMainBossID(72249)
mod:SetZone()
mod:SetUsedIcons(8, 7, 2)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UPDATE_WORLD_STATES",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--Stage 2: Bring Her Down!
----TODO, don't want this mod to register events in entire zone so it can warn for prelude trash.
----I'll put duplicate events in trash mod instead since trash mod will be disabled during encounters
local warnWarBanner					= mod:NewSpellAnnounce(147328, 3)
local warnFracture					= mod:NewTargetAnnounce(146899, 3)
local warnChainHeal					= mod:NewCastAnnounce(146757, 4)
local warnDemolisher				= mod:NewSpellAnnounce("ej8562", 3, 116040)
local warnHealingTideTotem			= mod:NewSpellAnnounce(146753, 4)
----Master Cannoneer Dragryn (Tower)
local warnMuzzleSpray				= mod:NewSpellAnnounce(147824, 3)--147824 spams combat log, 147825 is actual cast but does not show in combat log only UNIT event
----Lieutenant General Krugruk (Tower)
local warnArcingSmash				= mod:NewSpellAnnounce(147688, 3)
----High Enforcer Thranok (Road)
local warnCrushersCall				= mod:NewSpellAnnounce(146769, 4)
local warnShatteringCleave			= mod:NewSpellAnnounce(146849, 3, nil, mod:IsTank())
local warnCurseVenom				= mod:NewSpellAnnounce(147711, 3)

--Phase 3: Galakras,The Last of His Progeny
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnFlamesofGalakrondTarget	= mod:NewTargetAnnounce(147068, 4)
local warnFlamesofGalakrond			= mod:NewStackAnnounce(147029, 2, nil, mod:IsTank())

--Stage 2: Bring Her Down!
local specWarnWarBanner				= mod:NewSpecialWarningSwitch(147328, not mod:IsHealer())
local specWarnFractureYou			= mod:NewSpecialWarningYou(146899)
local yellFracture					= mod:NewYell(146899)
local specWarnFracture				= mod:NewSpecialWarningTarget(146899, mod:IsHealer())
local specWarnChainheal				= mod:NewSpecialWarningInterrupt(146757)
local specWarnFlameArrow			= mod:NewSpecialWarningMove(146764)
local specWarnShadowAttack			= mod:NewSpecialWarningMove(146872)
local specWarnHealingTideTotem		= mod:NewSpecialWarningSwitch(146753, not mod:IsHealer())
----Master Cannoneer Dragryn (Tower)
local specWarnMuzzleSpray			= mod:NewSpecialWarningSpell(147824, nil, nil, nil, 2)
----Lieutenant General Krugruk (Tower)
local specWarnArcingSmash			= mod:NewSpecialWarningSpell(147688, nil, nil, nil, 2)
----High Enforcer Thranok (Road)
local specWarnCrushersCall			= mod:NewSpecialWarningSpell(146769, false, nil, nil, 2)--optional pre warning for the grip soon. although melee/tank probably don't really care and ranged are 50/50
local specWarnSkullCracker			= mod:NewSpecialWarningRun(146848, nil, nil, nil, 3)--TODO, only warn the ranged who were gripped in by crushers call, instead of all of them
----Korgra the Snake (Road)
local specWarnPoisonCloud			= mod:NewSpecialWarningMove(147705)
local specWarnCurseVenom			= mod:NewSpecialWarningSpell(147711)
--Phase 3: Galakras,The Last of His Progeny
local specWarnFlamesofGalakrond		= mod:NewSpecialWarningCount(147029, false, nil, nil, 2)--Cast often, so lets make this optional since it's spammy
local specWarnFlamesofGalakrondYou	= mod:NewSpecialWarningYou(147068)
local yellFlamesofGalakrond			= mod:NewYell(147068)
local specWarnFlamesofGalakrondTank	= mod:NewSpecialWarningStack(147029, nil, 6)
local specWarnFlamesofGalakrondOther= mod:NewSpecialWarningTarget(147029, mod:IsTank())

--Stage 2: Bring Her Down!
local timerAddsCD					= mod:NewNextCountTimer(55, "ej8553", nil, nil, nil, 2457)
local timerTowerCD					= mod:NewTimer(99, "timerTowerCD", 88852)
local timerDemolisherCD				= mod:NewNextTimer(20, "ej8562", nil, nil, nil, 116040)--EJ is just not complete yet, shouldn't need localizing
local timerProtoCD					= mod:NewNextTimer(55, "ej8587", nil, nil, nil, 59961)
----High Enforcer Thranok (Road)
local timerShatteringCleaveCD		= mod:NewCDTimer(7.5, 146849, nil, mod:IsTank())
local timerCrushersCallCD			= mod:NewNextTimer(30, 146769)

--Phase 3: Galakras,The Last of His Progeny
local timerFlamesofGalakrondCD		= mod:NewCDCountTimer(6, 147068)
local timerFlamesofGalakrond		= mod:NewTargetTimer(15, 147029, nil, mod:IsTank())

mod:AddBoolOption("FixateIcon", 147068)
mod:AddSetIconOption("SetIconOnAdds", "ej8556", false, true)

local addsCount = 0
local firstTower = false
local flamesCount = 0

mod:AddEditBoxOption("flamecount", 50, "", "sound", 
function()
	if mod.Options.flamecount == "" then return end
	local checknum = tonumber(mod.Options.flamecount)	
	if type(checknum) == "number" then
		DBM:AddMsg("["..L.nameset.."]".."|cFF00FF00"..mod.localization.options["flamecount"]..DBM_CORE_SETTO..checknum.."|r")
	else
		DBM:AddMsg("["..L.nameset.."]"..DBM_CORE_WRONGSET.."\""..mod.Options.flamecount.."\"")
		DBM:AddMsg("["..L.nameset.."]"..DBM_CORE_WRONGSET.."\""..mod.Options.flamecount.."\"")
		DBM:AddMsg("["..L.nameset.."]"..DBM_CORE_WRONGSET.."\""..mod.Options.flamecount.."\"")
	end
end)

local function MyJS()
	local flamenum = mod.Options.flamecount
	flamenum = tonumber(flamenum)
	if flamenum == flamesCount then
		return true
	end
	return false
end

function mod:OnCombatStart(delay)
	addsCount = 1
	firstTower = false
	flamesCount = 0
	timerAddsCD:Start(60-delay, 2) --BH FIX
	if not self:IsMythic() then
		timerTowerCD:Start(116.5-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 147688 and UnitPower("player", ALTERNATE_POWER_INDEX) > 0 then--Tower Spell
		warnArcingSmash:Show()
		specWarnArcingSmash:Show()
		if self:AntiSpam(10, 4) then
			sndWOP:Play("carefly")--小心击飞
		end
	elseif args.spellId == 146757 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		local source = args.sourceName
		warnChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainheal:Show(source)
			sndWOP:Play("kickcast") --快打斷
		end
	elseif args.spellId == 146848 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		specWarnSkullCracker:Show()
		sndWOP:Play("ex_so_sfzd")--旋風斬
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 147824 and UnitPower("player", ALTERNATE_POWER_INDEX) > 0 and self:AntiSpam(3, 2) then--Tower Spell
		warnMuzzleSpray:Show()
		specWarnMuzzleSpray:Show()
	elseif args.spellId == 146769 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		warnCrushersCall:Show()
		specWarnCrushersCall:Show()
		timerCrushersCallCD:Start()
	elseif args.spellId == 146849 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		warnShatteringCleave:Show()
		timerShatteringCleaveCD:Start()
	elseif args.spellId == 146753 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		warnHealingTideTotem:Show()
		specWarnHealingTideTotem:Show()
		sndTT:Play("ex_so_ttkd") --圖騰快打
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 147068 then
		flamesCount = flamesCount + 1
		warnFlamesofGalakrondTarget:Show(args.destName)
		timerFlamesofGalakrondCD:Cancel(flamesCount)
		timerFlamesofGalakrondCD:Start(nil, flamesCount+1)
		if args:IsPlayer() then
			specWarnFlamesofGalakrondYou:Show()
			yellFlamesofGalakrond:Yell()
			sndWOP:Play("justrun") --快跑
		else
			specWarnFlamesofGalakrond:Show(flamesCount)
		end
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 8)
		end
		if MyJS() then
			sndWOP:Schedule(3, "defensive") --注意減傷
		end
	elseif args.spellId == 147328 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		warnWarBanner:Show()
		sndZQ:Play("ex_so_zqkd")--战旗快打
		specWarnWarBanner:Show()
	elseif args.spellId == 146899 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		warnFracture:Show(args.destName)
		if args:IsPlayer() then
			specWarnFractureYou:Show()
			yellFracture:Yell()
			sndWOP:Play("chargemove")--冲锋快躲
		else
			specWarnFracture:Show(args.destName)
			sndWOP:Play("ex_so_sgcf")--碎骨冲锋
		end
	elseif args.spellId == 147705 then
		if args:IsPlayer() and self:AntiSpam(2, 1) then
			specWarnPoisonCloud:Show()
			sndWOP:Play("runaway") --快躲開
		end
	elseif args.spellId == 147711 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		warnCurseVenom:Show()
		specWarnCurseVenom:Show()
		sndWOP:Play("ex_so_dskd")--毒蛇快打
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 147029 then--Tank debuff version
		local uId = DBM:GetRaidUnitId(args.destName)
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID then
				if self:IsTanking(uId, bossUnitID) then
					local amount = args.amount or 1
					warnFlamesofGalakrond:Show(args.destName, amount)
					timerFlamesofGalakrond:Start(args.destName)
					if amount >= 3 then
						if args:IsPlayer() then
							specWarnFlamesofGalakrondTank:Show(amount)
						else
							specWarnFlamesofGalakrondOther:Show(args.destName)
						end
					end
				end
				break--break loop if find right boss
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 147068 then
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 147029 then--Tank debuff version
		timerFlamesofGalakrond:Cancel(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 147705 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnPoisonCloud:Show()
		sndWOP:Play("runaway") --快躲開
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 146764 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
	--	specWarnFlameArrow:Show()
	elseif spellId == 146872 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnShadowAttack:Show()
		sndWOP:Play("runaway") --快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 72249 then--Main Boss ID
		DBM:EndCombat(self)
	elseif cid == 72355 then--High Enforcer Thranok
		timerShatteringCleaveCD:Cancel()
		timerCrushersCallCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
		timerAddsCD:Cancel()
		timerProtoCD:Cancel()
		warnPhase2:Show()
		sndWOP:Play("ptwo") -- 2階段
		timerFlamesofGalakrondCD:Start(18.6, 1)--TODO, verify consistency since this timing may depend on where drake lands and time it takes to get picked up.
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.newForces2 or msg == L.newForces3 or msg == L.newForces4 then
		self:SendSync("AddsFix")
	end
end

function mod:UPDATE_WORLD_STATES()
	local text = select(4, GetWorldStateUIInfo(4))
	local percent = tonumber(string.match(text or "", "%d+"))
	if percent == 1 and not firstTower and not self:IsMythic() then
		firstTower = true
		timerTowerCD:Start()
	end
end

--"<167.7 21:23:40> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#Warlord Zaela orders a |cFFFF0404|hKor'kron Demolisher|h|r to assault the tower!
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then--They fixed epiccenter bug (figured they would). Color code should be usuable though. It's only emote on encounter that uses it.
		warnDemolisher:Show()
		sndWOP:Play("ex_so_tscd") --投石车快打
	elseif msg:find(L.tower) then
		sndWOP:Play("ex_so_ptkf") --炮塔攻破
		timerDemolisherCD:Start()
	end
end

function mod:OnSync(msg)
	if msg == "AddsFix" and self:AntiSpam(10, 4) then
		addsCount = addsCount + 1
		if addsCount == 1 then
			timerAddsCD:Cancel()
			timerAddsCD:Start(48, addsCount + 1)
		elseif addsCount == 3 or addsCount == 7 or addsCount == 11 then--Verified. Every 4th wave gets a proto. IE waves 4, 8, 12
			timerProtoCD:Start()
			timerAddsCD:Cancel()
			timerAddsCD:Start(110, addsCount + 1)
		else
			timerAddsCD:Cancel()
			timerAddsCD:Start(55, addsCount + 1)
		end
	end
end
