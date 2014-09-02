local mod	= DBM:NewMod(819, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
--BH ADD
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndDB		= mod:NewSound(nil, "SoundDB", false)
local sndWSP	= mod:NewSound(nil, "SoundWSP", true)
local sndOrb	= mod:NewSound(nil, "SoundOrb", mod:IsTank())
local LibRange = LibStub("LibRangeCheck-2.0")
--BH ADD END

mod:SetRevision(("$Revision: 9769 $"):sub(12, -3))
mod:SetCreatureID(68476)
mod:SetQuestID(32745)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	--BH ADD
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED",
	--BH ADD END
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

--[[
TODO: See if this has some target scanning. On heroic these can one shot non tanks
"<431.7 15:32:55> [CLEU] SPELL_CAST_SUCCESS#false#0xF1310E38000020EE#Amani'shi Beast Shaman#2632#128##Unknown#-2147483648#-2147483648#136487#Lightning Nova Totem#1", -- [67956]
"<431.7 15:32:55> [CLEU] SPELL_SUMMON#false#0xF1310E38000020EE#Amani'shi Beast Shaman#2632#128#0xF1310E5F00002779#Lightning Nova Totem#2600#0#136487#Lightning Nova Totem#1", -- [67957]
--]]
local warnCharge				= mod:NewTargetAnnounce(136769, 4)
local warnPuncture				= mod:NewStackAnnounce(136767, 2, nil, mod:IsTank() or mod:IsHealer())
local warnDoubleSwipe			= mod:NewSpellAnnounce(136741, 3)
local warnAdds					= mod:NewAnnounce("warnAdds", 2, 43712)--Some random troll icon
local warnDino					= mod:NewSpellAnnounce("ej7086", 3, 137237)
local warnMending				= mod:NewSpellAnnounce(136797, 4)
local warnOrbofControl			= mod:NewAnnounce("warnOrbofControl", 4, "INTERFACE\\ICONS\\INV_MISC_ORB_01.BLP")
local warnCrackedShell			= mod:NewStackAnnounce(137240, 2)
local warnVenomBolt				= mod:NewSpellAnnounce(136587, 3, nil, false)
local warnChainLightning		= mod:NewSpellAnnounce(136480, 3, nil, false)
local warnFireball				= mod:NewSpellAnnounce(136465, 3, nil, false)
local warnBestialCry			= mod:NewStackAnnounce(136817, 3)
local warnRampage				= mod:NewTargetAnnounce(136821, 4, nil, mod:IsTank() or mod:IsHealer())
local warnDireCall				= mod:NewCountAnnounce(137458, 3)
local warnDireFixate			= mod:NewTargetAnnounce(140946, 4)

local specWarnCharge			= mod:NewSpecialWarningYou(136769)--Maybe add a near warning later. person does have 3.4 seconds to react though and just move out of group.
local yellCharge				= mod:NewYell(136769)
local specWarnDoubleSwipe		= mod:NewSpecialWarningSpell(136741, nil, nil, nil, 2)
local specWarnPuncture			= mod:NewSpecialWarningStack(136767, mod:IsTank(), 9)--9 seems like a good number, we'll start with that. Timing wise the swap typically comes when switching gates though.
local specWarnPunctureOther		= mod:NewSpecialWarningTarget(136767, mod:IsTank())
local specWarnSandTrap			= mod:NewSpecialWarningMove(136723)
local specWarnSandTrapYou		= mod:NewSpecialWarningYou(136723)
local specWarnSandTrapNear		= mod:NewSpecialWarningClose(136723)
local yellSandTrap				= mod:NewYell(136723)
local specWarnDino				= mod:NewSpecialWarningSwitch("ej7086", not mod:IsHealer())
-- BH MODIFY
local specWarnMending			= mod:NewSpecialWarningInterrupt(136797)--High priority interrupt. All dps needs warning because boss heals 1% per second it's not interrupted.
local specWarnOrbofControl		= mod:NewSpecialWarning("specWarnOrbofControl")--Usually an assigned role for 1-2 people. Do not want someone assigned to interrupts for example hear this and think it's interrupt time. This should be turned on by orb person
local specWarnVenomBolt			= mod:NewSpecialWarningInterrupt(136587)--Can be on for all since it only triggers off target/focus
local specWarnChainLightning	= mod:NewSpecialWarningInterrupt(136480)--Can be on for all since it only triggers off target/focus
local specWarnFireball			= mod:NewSpecialWarningInterrupt(136465)--Can be on for all since it only triggers off target/focus
local specWarnLivingPoison		= mod:NewSpecialWarningMove(136646)
local specWarnFrozenBolt		= mod:NewSpecialWarningMove(136573)--Debuff used by Frozen Orbs
local specWarnLightningNova		= mod:NewSpecialWarningMove(136490)--Mainly for LFR or normal. On heroic you're going to die.
local specWarnHex				= mod:NewSpecialWarningYou(136512)
local specWarnHexOther			= mod:NewSpecialWarningTarget(136512)
local specWarnJalak				= mod:NewSpecialWarningSwitch("ej7087", mod:IsTank())--To pick him up (and maybe dps to switch, depending on strat)
local specWarnRampage			= mod:NewSpecialWarningTarget(136821, mod:IsTank() or mod:IsHealer())--Dog is pissed master died, need more heals and cooldowns. Maybe warn dps too? his double swipes and charges will be 100% worse too.
local specWarnDireCall			= mod:NewSpecialWarningCount(137458, nil, nil, nil, 2)--Heroic
local specWarnDireFixate		= mod:NewSpecialWarningRun(140946)--Heroic
--BH ADD
local specWarnSunDebuff			= mod:NewSpecialWarningSpell(136719, mod:IsHealer())
local specWarnWitchDebuff		= mod:NewSpecialWarningSpell(136512, mod:IsHealer())
local specWarnLightTT			= mod:NewSpecialWarningSpell(136487)
local specWarnJSA			= mod:NewSpecialWarning("SpecWarnJSA")
local timerHeadache			= mod:NewBuffActiveTimer(10, 137294)
--BH ADD END
local timerDoor					= mod:NewTimer(113.5, "timerDoor", 2457)--They seem to be timed off last door start, not last door end. They MAY come earlier if you kill off all first doors adds though not sure yet. If they do, we'll just start new timer anyways
local timerAdds					= mod:NewTimer(18.91, "timerAdds", 43712)
local timerDinoCD				= mod:NewNextTimer(56.75, "ej7086", nil, nil, nil, 137237)--It's between 55 and 60 seconds, I will need a more thorough log to verify by yelling when they spawn
local timerCharge				= mod:NewCastTimer(3.4, 136769)
local timerChargeCD				= mod:NewCDTimer(50, 136769)--50-60 second depending on i he's casting other stuff or stunned
local timerDoubleSwipeCD		= mod:NewCDTimer(17, 136741)--17 second cd unless delayed by a charge triggered double swipe, then it's extended by failsafe code
local timerPuncture				= mod:NewTargetTimer(90, 136767, nil, mod:IsTank() or mod:IsHealer())
local timerPunctureCD			= mod:NewCDTimer(11, 136767, nil, mod:IsTank() or mod:IsHealer())
local timerJalakCD				= mod:NewNextTimer(10, "ej7087", nil, nil, nil, 2457)--Maybe it's time for a better worded spawn timer than "Next mobname". Maybe NewSpawnTimer with "mobname activates" or something.
local timerBestialCryCD			= mod:NewNextCountTimer(10, 136817)
local timerDireCallCD			= mod:NewCDCountTimer(62, 137458)--Heroic (every 62-70 seconds)

local berserkTimer				= mod:NewBerserkTimer(720)

-- BH DELETE local soundDireFixate			= mod:NewSound(140946)

local nhcount = 1
local qscount = 0
local pxcount = 0
local closedoor = 0
local Direname	= EJ_GetSectionInfo(7866)
mod:AddBoolOption("ccsoon", false, "sound")
mod:AddBoolOption("ddyls", true, "sound")
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetIconOnCharge")
for i = 1, 4 do
	mod:AddBoolOption("dr"..i, false, "sound")
end
mod:AddDropdownOption("optQS", {"noQS", "QS1", "QS2", "QS3", "allQS"}, "noQS", "sound")
mod:AddEditBoxOption("dispsetHex", 150, "", "sound")
local function MyJS()
	if (mod.Options.dr1 and pxcount == 0) or (mod.Options.dr2 and pxcount == 1) or (mod.Options.dr3 and pxcount == 2) or (mod.Options.dr4 and pxcount == 3) then
		return true
	end
	return false
end
local function checksprange()
	if UnitExists("focus") then
		if UnitName("focus") == Direname then
			local min, max = LibRange:getRange("focus")
			if min and max then
				if min <= 8 then
					if mod:AntiSpam(1, 6) then
						DBM.Flash:Shake(1, 0, 0)
						sndWSP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\stilldanger.mp3") --危險
					end
				elseif min <= 15 then
					if mod:AntiSpam(4, 5) then
						DBM.Flash:Shake(1, 0, 0)
						sndWSP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\killspirit.mp3") --靈魂快打
					end
--				elseif min >= 60 then
--					if mod:AntiSpam(4, 5) then
--						sndWSP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\safenow.mp3")
--					end
				end
			end	
		end
	end
	mod:Schedule(0.2, checksprange)
end

local doorNumber = 0
local direNumber = 0
local shamandead = 0
local jalakEngaged = false
local Farraki	= EJ_GetSectionInfo(7098)
local Gurubashi	= EJ_GetSectionInfo(7100)
local Drakkari	= EJ_GetSectionInfo(7103)
local Amani		= EJ_GetSectionInfo(7106)

function mod:OnCombatStart(delay)
	doorNumber = 0
	direNumber = 0
	shamandead = 0
	--BH ADD
	closedoor = 0
	qscount = 0
	pxcount = 0
	nhcount = 1
	--BH ADD END
	jalakEngaged = false
	timerPunctureCD:Start(10-delay)
	self:Schedule(9, function()
		if self:IsTanking("player", "boss1") or mod.Options.ccsoon then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\watchimpale.mp3")
		end
	end)
	timerDoubleSwipeCD:Start(16-delay)--16-17 second variation
	timerDoor:Start(16.5-delay)
	timerChargeCD:Start(31-delay)--31-35sec variation
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerDireCallCD:Start(-delay, 1)
		--BH ADD
		if mod:IsHealer() then
			if select(2, UnitClass("player")) == "PRIEST" then
				sndWOP:Schedule(42, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_esnh.mp3")
			end
			sndWOP:Schedule(57, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_wmhn.mp3")
		end
		if mod.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(137458))
			DBM.InfoFrame:Show(1, "other", nhcount, "Next")
		end
		--BH ADD END
	end
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to prevent detecting first heads on pull before variables reset from first engage fire. We'll catch them on delayed engages fired couple seconds later
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--[[
Back to backs, as expected
"<244.6 15:11:23> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [17383]
"<262.7 15:11:42> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [19036]
Delayed by Charge version
"<59.8 15:08:19> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [4747]
"<70.7 15:08:30> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136769#Charge#1", -- [5273]
"<74.8 15:08:34> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136770#Double Swipe#1", -- [5452]
"<86.4 15:08:45> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#2632#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [6003]
--]]

function mod:SPELL_CAST_START(args)
	if args.spellId == 136741 then--Regular double swipe
		warnDoubleSwipe:Show()
		specWarnDoubleSwipe:Show()
		sndDB:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_scsj.mp3") --雙重掃擊
		--The only flaw is charge is sometimes delayed by unexpected events like using an orb, we may fail to start timer once in a while when it DOES come before a charge.
		if timerChargeCD:GetTime() < 32 then--Check if charge is less than 18 seconds away, if it is, double swipe is going tobe delayed by quite a bit and we'll trigger timer after charge
			timerDoubleSwipeCD:Start()
		end
	elseif args.spellId == 136770 then--Double swipe that follows a charge (136769)
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_scsj.mp3")
		warnDoubleSwipe:Show()
		specWarnDoubleSwipe:Show()
		timerDoubleSwipeCD:Start(11.5)--Hard coded failsafe. 136741 version is always 11.5 seconds after 136770 version
	elseif args.spellId == 137458 then
		direNumber = direNumber + 1
		warnDireCall:Show(direNumber)
		specWarnDireCall:Show(direNumber)
		timerDireCallCD:Start(nil, direNumber+1)--CD still reset when he breaks a door?
		if mod:IsHealer() then
			if select(2, UnitClass("player")) == "PRIEST" then
				sndWOP:Schedule(42, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_esnh.mp3")
			end
			sndWOP:Schedule(57, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_wmhn.mp3")
		end
		nhcount = nhcount + 1		
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3") --準備AE
		if nhcount == 3 then nhcount = 0 end
	elseif args:IsSpellID(136587) then
		warnVenomBolt:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnVenomBolt:Show(args.sourceName)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")--快打斷
		end
	elseif args:IsSpellID(136480) then
		warnChainLightning:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnChainLightning:Show(args.sourceName)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")--快打斷
		end
	elseif args:IsSpellID(136465) then
		warnFireball:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnFireball:Show(args.sourceName)
		end
	end
end

--BH ADD
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 136487 then
		specWarnLightTT:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_sdtt.mp3")--閃電圖騰
	elseif args.spellId == 136512 then		
		qscount = qscount + 1
		if ((mod.Options.optQS == "QS1") and (qscount % 3 == 1)) or ((mod.Options.optQS == "QS2") and (qscount % 3 == 2)) or ((mod.Options.optQS == "QS3") and (qscount % 3 == 0)) or (mod.Options.optQS == "allQS") then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3") --快驅散
			specWarnWitchDebuff:Show()
		end
	elseif args.spellId == 136719 then
		qscount = qscount + 1
		if ((mod.Options.optQS == "QS1") and (qscount % 3 == 1)) or ((mod.Options.optQS == "QS2") and (qscount % 3 == 2)) or ((mod.Options.optQS == "QS3") and (qscount % 3 == 0)) or (mod.Options.optQS == "allQS") then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3") --快驅散
			specWarnSunDebuff:Show()
		end
	elseif args.spellId == 136564 then
		if self:AntiSpam(2, 7) then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_bqxx.mp3") --冰球小心
		end
	end
end
--BH ADD END

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 136767 then
		warnPuncture:Show(args.destName, args.amount or 1)
		timerPuncture:Start(args.destName)
		timerPunctureCD:Start()
		--BH ADD
		self:Schedule(9, function()
			if self:IsTanking("player", "boss1") or mod.Options.ccsoon then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\watchimpale.mp3")
			end
		end)
		--BH ADD END
		if args:IsPlayer() then
			if (args.amount or 1) >= 9 then
				specWarnPuncture:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 9 and not UnitDebuff("player", GetSpellInfo(136767)) and not UnitIsDeadOrGhost("player") then--Other tank has at least one stack and you have none
				specWarnPunctureOther:Show(args.destName)--So nudge you to taunt it off other tank already.
				if mod:IsTank() then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\changemt.mp3") --換坦嘲諷
				end
			end
		end
	--"<317.2 15:12:36> [CLEU] SPELL_AURA_APPLIED_DOSE#false#0xF1310B7C0000383C#Horridon#68168#0#0xF1310B7C0000383C#Horridon#68168#0#137240#Cracked Shell#1#BUFF#4", -- [21950]
	--"<327.0 15:12:46> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Horridon#0xF1310B7C0000383C#elite#261178058#1#1#War-God Jalak <--War-God Jalak jumps down
	--He jumps down 10 seconds after 4th door is smashed, or when Horridon reaches 30%
	--BH ADD
	elseif args.spellId == 137240 and (args.amount or 1) == 4 and not jalakEngaged then
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")
	--BH ADD END
	elseif args.spellId == 136817 then
		warnBestialCry:Show(args.destName, args.amount or 1)
		timerBestialCryCD:Start(10, (args.amount or 1)+1)
		--BH ADD
		pxcount = pxcount + 1
		if MyJS() then
			specWarnJSA:Schedule(6)
			sndWOP:Schedule(6, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
		else
			sndWOP:Schedule(6, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3") --準備AE
		end
		sndWOP:Schedule(7.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(8.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(9.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		--BH ADD END		
	elseif args.spellId == 136821 then
		warnRampage:Show(args.destName)
		specWarnRampage:Show(args.destName)
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_hldn.mp3")--哈里登暴怒
	elseif args.spellId == 136797 then
		warnMending:Show()
		--BH MODIFY
		if mod.Options.ddyls then
			specWarnMending:Show(args.sourceName)
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")--快打斷
		end
		--BH MODIFY END
	elseif args.spellId == 137237 then
		warnOrbofControl:Show()
		specWarnOrbofControl:Show()
		sndOrb:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_ksbz.mp3") --控獸寶珠
	elseif args.spellId == 137240 then
		warnCrackedShell:Show(args.destName, args.amount or 1)
--[[	elseif args.spellId == 136587 then
		warnVenomBolt:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnVenomBolt:Show(args.sourceName)
		end
	elseif args.spellId == 136480 then
		warnChainLightning:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnChainLightning:Show(args.sourceName)
		end
	elseif args.spellId == 136465 then
		warnFireball:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnFireball:Show(args.sourceName)
		end]] -- BH DELETE
	elseif args.spellId == 140946 then
		warnDireFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnDireFixate:Show()
--BH DELETE		soundDireFixate:Play()
			-- BH ADD
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_lhsd.mp3")
			sndWOP:Schedule(1,"Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_lhsd.mp3")
			checksprange()
			-- BH ADD END
		end
	elseif args.spellId == 136512 then
		if args:IsPlayer() then
			specWarnHex:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\stopattack.mp3") -- 停止攻擊
		elseif args.destName == mod.Options.dispsetHex then
			specWarnHexOther:Show(args.destName)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\helpdispel.mp3") -- 幫忙驅散
		end
	-- BH ADD
	elseif args.spellId == 137294 then
		closedoor = closedoor + 1
		timerHeadache:Start(10)
		sndWOP:Schedule(5.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Schedule(6.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(7.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(8.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(9.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		if closedoor == 1 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_smgb.mp3")--沙門關閉
		elseif closedoor == 2 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_dmgb.mp3")--毒門關閉
		elseif closedoor == 3 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_bmgb.mp3")--冰門關閉
		end
	elseif args.spellId ==  136670 then
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\dshigh.mp3")--致死過高
			end
		end
	-- BH ADD END
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 136767 then
		timerPuncture:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 136723 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnSandTrap:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	elseif spellId == 136646 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnLivingPoison:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	elseif spellId == 136573 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnFrozenBolt:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	elseif spellId == 136490 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnLightningNova:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE


--"<372.2 21:39:53> [RAID_BOSS_EMOTE] RAID_BOSS_EMOTE#Amani forces pour from the Amani Tribal Door!#War-God Jalak#0#false", -- [77469]
--"<515.3 21:42:16> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Horridon#0xF1310B7C0000467C#elite#522686397#1#1#War-God Jalak
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if UnitExists("boss2") and tonumber(UnitGUID("boss2"):sub(6, 10), 16) == 69374 and not jalakEngaged then--Jalak is jumping down
		jalakEngaged = true--Set this so we know not to concern with 4th door anymore (plus so we don't fire extra warnings when we wipe and ENGAGE fires more)
		timerJalakCD:Cancel()
		specWarnJalak:Show()
		timerBestialCryCD:Start(5, 1)
		-- BH ADD
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_zscz.mp3") --戰神參戰
		if MyJS() then
			specWarnJSA:Schedule(2)
			sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
		else
			sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3") --準備AE
		end
		sndWOP:Schedule(2.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(3.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(4.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		-- BH ADD END
		self:UnregisterShortTermEvents()--TODO, maybe add unit health checks to warn dog is close to 40% if we aren't done with doors yet. If it's added, we can unregister health here as well
	end
end

local function addsDelay(addsType)
	timerAdds:Start(18.9, addsType)
	warnAdds:Schedule(18.9, addsType)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find(L.chargeTarget) then
		if self:LatencyCheck() then
			self:SendSync("ChargeTo", target)
		end
	elseif msg:find(L.newForces) then
		if self:LatencyCheck() then
			self:SendSync("Door")
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69374 then
		timerBestialCryCD:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	elseif cid == 69176 then--shaman
		shamandead = shamandead + 1
		if shamandead == 3 then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if uId ~="target" and uId ~="focus" then return end
	if spellId == 136725 then
		if self:LatencyCheck() then
			self:SendSync("Sand", UnitName(uId.."target"))
		end
	elseif spellId == 136644 then
		if self:LatencyCheck() then
			self:SendSync("Duye")
		end
	end
end

function mod:OnSync(msg, target)
	if msg == "ChargeTo" and target then
		local target = DBM:GetUnitFullName(target)
		warnCharge:Show(target)
		timerCharge:Start()
		timerChargeCD:Start()
		if target == UnitName("player") then
			specWarnCharge:Show()
			yellCharge:Yell()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_nbcf.mp3")
			sndWOP:Schedule(0.5,"Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_nbcf.mp3")
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_cfkd.mp3") --衝鋒快躲
		end
		if UnitExists(target) and self.Options.SetIconOnCharge then
			self:SetIcon(target, 1, 5)--star
		end
	elseif msg == "Door" and self:AntiSpam(60, 4) then--prevent bad doorNumber increase if very late sync received.
	--Doors spawn every 131.5 seconds
	--Halfway through it (literlaly exact center) Dinomancers spawn at 56.75
	--Then, before the dinomancer, lesser adds spawn twice splitting that timer into 3rds
	--So it goes, door, 18.91 seconds later, 1 add jumps down. 18.91 seconds later, next 2 drop down. 18.91 seconds later, dinomancer drops down, then 56.75 seconds later, next door starts.
		doorNumber = doorNumber + 1
		timerDinoCD:Start()
		warnDino:Schedule(56.75)
		specWarnDino:Schedule(56.75)
		if mod:IsDps() then
			sndWOP:Schedule(56.75, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_ylsd.mp3") --禦龍師快打
		else
			sndWOP:Schedule(56.75, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_ylsc.mp3") --禦龍師出現
		end
		if doorNumber == 1 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_smkq.mp3") --沙門開啟
			timerAdds:Start(18.9, Farraki)
			warnAdds:Schedule(18.9, Farraki)
			self:Schedule(18.9, addsDelay, Farraki)
		elseif doorNumber == 2 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_dmkq.mp3") --毒门開啟
			timerAdds:Start(18.9, Gurubashi)
			warnAdds:Schedule(18.9, Gurubashi)
			self:Schedule(18.9, addsDelay, Gurubashi)
		elseif doorNumber == 3 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_bmkq.mp3") --冰门開啟
			timerAdds:Start(18.91, Drakkari)
			warnAdds:Schedule(18.9, Drakkari)
			self:Schedule(18.9, addsDelay, Drakkari)
		elseif doorNumber == 4 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xmkq.mp3") --熊門開啟
			timerAdds:Start(18.9, Amani)
			warnAdds:Schedule(18.9, Amani)
			self:Schedule(18.9, addsDelay, Amani)
			if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
				DBM.RangeCheck:Show(5)
			end
		end
		if doorNumber < 4 then
			timerDoor:Start()
		else
			if not jalakEngaged then
				timerJalakCD:Start(143)
			end
		end
	elseif msg == "Sand" and target then
		local target = DBM:GetUnitFullName(target)
		if target == UnitName("player") then
			specWarnSandTrapYou:Show()
			yellSandTrap:Yell()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
		end
	elseif msg == "Duye" then
		if self:AntiSpam(2, 10) then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_zyfs.mp3") --注意分身
		end
	end
end
