local mod	= DBM:NewMod(851, "DBM-SiegeOfOrgrimmarV2", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndPX		= mod:SoundMM("SoundPX", mod:IsManaUser())

local LibRange = LibStub("LibRangeCheck-2.0")

mod:SetRevision(("$Revision: 11360 $"):sub(12, -3))
mod:SetCreatureID(71529)
mod:SetEncounterID(1599)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Stage 1: A Cry in the Darkness
local warnFearsomeRoar				= mod:NewStackAnnounce(143766, 2, nil, mod:IsTank())--143426
local warnAcceleration				= mod:NewStackAnnounce(143411, 3)--Staghelm 2.0
local warnTailLash					= mod:NewSpellAnnounce(143428, 3, nil, false)--Hey, someone will want this out there.
--Stage 2: Frenzy for Blood!
local warnBloodFrenzy				= mod:NewStackAnnounce(143442, 3)
local warnFixate					= mod:NewTargetAnnounce(143445, 4)
local warnEnrage					= mod:NewTargetAnnounce(145974, 3, nil, mod:IsTank() or mod:CanRemoveEnrage())
local warnKey						= mod:NewTargetAnnounce(146589, 2)
--Infusion of Acid
local warnAcidPustules				= mod:NewSpellAnnounce(143971, 2)
local warnAcidBreath				= mod:NewStackAnnounce(143780, 2, nil, mod:IsTank())
local warnCorrosiveBlood			= mod:NewTargetAnnounce(143791, 2, nil, false)--Spammy, CD was reduced to 2 seconds
--Infusion of Frost
local warnFrostPustules				= mod:NewSpellAnnounce(143968, 3)
local warnFrostBreath				= mod:NewStackAnnounce(143773, 2, nil, mod:IsTank())
local warnFrozenSolid				= mod:NewTargetAnnounce(143777, 4)--This only thing worth announcing. the stacks of Icy Blood cast SUPER often and not useful
--Infusion of Fire
local warnFirePustules				= mod:NewSpellAnnounce(143970, 2)
local warnScorchingBreath			= mod:NewStackAnnounce(143767, 2, nil, mod:IsTank())
local warnBurningBlood				= mod:NewTargetAnnounce(143783, 3, nil, false, nil, nil, nil, nil, 2)

--Stage 1: A Cry in the Darkness
local specWarnFearsomeRoar			= mod:NewSpecialWarningStack(143766, mod:IsTank(), 2)
local specWarnFearsomeRoarOther		= mod:NewSpecialWarningTarget(143766, mod:IsTank())
local specWarnDeafeningScreech		= mod:NewSpecialWarningSpell(143343, nil, nil, nil, 2)
--Stage 2: Frenzy for Blood!
local specWarnBloodFrenzy			= mod:NewSpecialWarningSpell(143440, nil, nil, nil, 2)
local specWarnFixate				= mod:NewSpecialWarningRun(143445, nil, nil, nil, 3)
local yellFixate					= mod:NewYell(143445)
local specWarnEnrage				= mod:NewSpecialWarningTarget(145974, mod:IsTank() or mod:CanRemoveEnrage())
--Infusion of Acid
local specWarnAcidBreath			= mod:NewSpecialWarningStack(143780, mod:IsTank(), 2)
local specWarnAcidBreathOther		= mod:NewSpecialWarningTarget(143780, mod:IsTank())
local specWarnCorrosiveBlood		= mod:NewSpecialWarningDispel(143791)
--Infusion of Frost
local specWarnFrostBreath			= mod:NewSpecialWarningStack(143773, mod:IsTank(), 3)
local specWarnFrostBreathOther		= mod:NewSpecialWarningTarget(143773, mod:IsTank())
local specWarnIcyBlood				= mod:NewSpecialWarningStack(143800, nil, 3)
local specWarnFrozenSolid			= mod:NewSpecialWarningTarget(143777, mod:IsDps())
--Infusion of Fire
local specWarnScorchingBreath		= mod:NewSpecialWarningStack(143767, mod:IsTank(), 3)
local specWarnScorchingBreathOther	= mod:NewSpecialWarningTarget(143767, mod:IsTank())
local specWarnBurningBlood			= mod:NewSpecialWarningYou(143783)
local specWarnBurningBloodMove		= mod:NewSpecialWarningMove(143784)
local yellBurningBlood				= mod:NewYell(143783, nil, false)

local specWarnDevotion				= mod:NewSpecialWarning("specWarnDevotion") --BH ADD

--Stage 1: A Cry in the Darkness
local timerFearsomeRoar			= mod:NewTargetTimer(30, 143766, nil, mod:IsTank() or mod:IsHealer())
local timerFearsomeRoarCD		= mod:NewCDTimer(11, 143766, nil, mod:IsTank())
local timerDeafeningScreechCD	= mod:NewNextCountTimer(13, 143343)-- (143345 base power regen, 4 every half second)
local timerTailLashCD			= mod:NewCDTimer(10, 143428, nil, false)
--Stage 2: Frenzy for Blood!
local timerBloodFrenzyCD		= mod:NewNextTimer(5, 143442)
local timerFixate				= mod:NewTargetTimer(12, 143445)
--Infusion of Acid
local timerAcidBreath			= mod:NewTargetTimer(30, 143780, nil, mod:IsTank() or mod:IsHealer())
local timerAcidBreathCD			= mod:NewCDTimer(11, 143780, nil, mod:IsTank())--Often 12, but sometimes 11
local timerCorrosiveBloodCD		= mod:NewCDTimer(3.5, 143791, nil, false)--Cast often, so off by default
--Infusion of Frost
local timerFrostBreath			= mod:NewTargetTimer(30, 143773, nil, mod:IsTank() or mod:IsHealer())
local timerFrostBreathCD		= mod:NewCDTimer(9.5, 143773, nil, mod:IsTank())
--Infusion of Fire
local timerScorchingBreath		= mod:NewTargetTimer(30, 143767, nil, mod:IsTank() or mod:IsHealer())
local timerScorchingBreathCD	= mod:NewCDTimer(11, 143767, nil, mod:IsTank())--Often 12, but sometimes 11
local timerBurningBloodCD		= mod:NewCDTimer(3.5, 143783, nil, false)--cast often, but someone might want to show it

local timerDevotion				= mod:NewBuffActiveTimer(6, 31821)

local berserkTimer				= mod:NewBerserkTimer(600)

--local soundBloodFrenzy			= mod:NewSound(144067)
--local soundFixate				= mod:NewSound(143445)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("FixateIcon", true)

local screechCount = 0
local UnitGUID = UnitGUID
local bloodTargets = {}

local phase = 1
local dispnum = 0

--this boss works similar to staghelm
local screechTimers = {
	[0] = 13.2,
	[1] = 13.2,
	[2] = 10.8,
	[3] = 7.2,
	[4] = 4.8,
	[5] = 3.6,
	[6] = 2.4,
	[7] = 2.4,
	[8] = 2.4,
	[9] = 2.4,
	[10]= 2.4,
	[11]= 2.4,
	[12]= 2.4,
	[13]= 2.4,
	[14]= 2.4,
	[15]= 2.4,
	[16]= 2.4,
	[17]= 2.4,
	[18]= 2.4,
	[19]= 2.4,
	[20]= 2.4,
	[21]= 2.4,
	[22]= 2.4,--TODO< see if 1.2 can occur earlier. my log show that blizz buffing energy regen rate somehow caused the 2.4 string to last longer
	[23]= 1.2,--Anything 23 and beyond is 1.2 with rare 2.4 fluke sometimes
}

local function clearBloodTargets()
	table.wipe(bloodTargets)
end

mod:AddBoolOption("LTRange", true, "sound")
mod:AddBoolOption("dr", true, "sound")
for i = 1, 30 do
	mod:AddBoolOption("dr"..i, false, "sound")
end

mod:AddDropdownOption("optDD", {"DD1", "DD2", "DD3", "nodd"}, "nodd", "sound")

local function MyJS()
	if mod.Options["dr"..screechCount] then
		return true
	end
	return false
end

--[[local function checkbossrange()
	if UnitExists("boss1") then
		local minrange, maxrange = LibRange:getRange("boss1")
		if minrange and maxrange then
			if minrange < 40 then
				DBM:ShowLTSpecialWarning(minrange.." - "..maxrange, 0, 1, 0)
			else
				DBM:ShowLTSpecialWarning(minrange.." - "..maxrange, 1, 0, 0)
			end
		end	
	end
	if phase == 2 then
		mod:Schedule(0.2, checkbossrange)
	else
		DBM:HideLTSpecialWarning()
	end
end]]

function mod:OnCombatStart(delay)
	screechCount = 0
	phase = 1
	dispnum = 0
	table.wipe(bloodTargets)
	timerFearsomeRoarCD:Start(-delay)
	if self:IsLFR() then
		timerDeafeningScreechCD:Start(19-delay, 1)
		sndPX:Schedule(16-delay, DBM.SoundMMPath.."\\aesoon.ogg")	
		sndPX:Schedule(17-delay, DBM.SoundMMPath.."\\countthree.ogg")
		sndPX:Schedule(18-delay, DBM.SoundMMPath.."\\counttwo.ogg")
		sndPX:Schedule(19-delay, DBM.SoundMMPath.."\\countone.ogg")
	else
		timerDeafeningScreechCD:Start(-delay, 1)
		sndPX:Schedule(10-delay, DBM.SoundMMPath.."\\aesoon.ogg")	
		sndPX:Schedule(11-delay, DBM.SoundMMPath.."\\countthree.ogg")
		sndPX:Schedule(12-delay, DBM.SoundMMPath.."\\counttwo.ogg")
		sndPX:Schedule(13-delay, DBM.SoundMMPath.."\\countone.ogg")
	end
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame and not self:IsLFR() then
--		if self:IsDifficulty("normal10", "heroic10") then
--			DBM.RangeCheck:Show(10, nil, nil, 4)
--		else
		DBM.RangeCheck:Show(10, nil, nil, 14)
--		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.LTRange then
--		DBM:HideLTSpecialWarning()
--	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143343 then--Assumed, 2 second channel but "Instant" cast flagged, this generally means SPELL_AURA_APPLIED
		if screechCount < 8 then--Don't spam special warning once cd is lower than 4.8 seconds.
			specWarnDeafeningScreech:Show()
		end
		timerDeafeningScreechCD:Cancel()
		sndPX:Cancel(DBM.SoundMMPath.."\\aesoon.ogg")
		sndPX:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndPX:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndPX:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		if self:IsLFR() then
			timerDeafeningScreechCD:Start(18, screechCount+1)
			sndPX:Schedule(15, DBM.SoundMMPath.."\\aesoon.ogg")	
			sndPX:Schedule(16, DBM.SoundMMPath.."\\countthree.ogg")
			sndPX:Schedule(17, DBM.SoundMMPath.."\\counttwo.ogg")
			sndPX:Schedule(18, DBM.SoundMMPath.."\\countone.ogg")
		else
			timerDeafeningScreechCD:Start(screechTimers[screechCount] or 1.2, screechCount+1)
			if screechTimers[screechCount] and screechTimers[screechCount] > 2.2 then
				if screechTimers[screechCount] > 3.2 then
					sndPX:Schedule(screechTimers[screechCount+1] - 3.2, DBM.SoundMMPath.."\\aesoon.ogg")
				end
				sndPX:Schedule(screechTimers[screechCount+1] - 2.2, DBM.SoundMMPath.."\\countthree.ogg")
				sndPX:Schedule(screechTimers[screechCount+1] - 1.2, DBM.SoundMMPath.."\\counttwo.ogg")
				sndPX:Schedule(screechTimers[screechCount+1] - 0.2, DBM.SoundMMPath.."\\countone.ogg")
			end
		end
	elseif args.spellId == 143428 then
		warnTailLash:Show()
		timerTailLashCD:Start()
	elseif args.spellId == 31821 then --BH ADD
		specWarnDevotion:Show(args.sourceName)
		timerDevotion:Start()
		if mod:IsManaUser() then
			sndWOP:Play(DBM.SoundMMPath.."\\ex_so_qcgh.ogg") --虔誠光環
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143411 then
		screechCount = args.amount or 1
		warnAcceleration:Show(args.destName, screechCount)
--		if self.Options.LTRange then
--			DBM:ShowLTSpecialWarning(GetSpellInfo(143343)..":"..screechCount, 0, 1, 0)
--		end
		if MyJS() then
			sndWOP:Play(DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
			sndWOP:Schedule(0.7, DBM.SoundMMPath.."\\defensive.ogg")
		end
	elseif args.spellId == 143766 then
		timerFearsomeRoarCD:Start()
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			local amount = args.amount or 1
			warnFearsomeRoar:Show(args.destName, amount)
			timerFearsomeRoar:Start(args.destName)
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnFearsomeRoar:Show(args.amount)
				else
					specWarnFearsomeRoarOther:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 143780 then
		timerAcidBreathCD:Start()
		local amount = args.amount or 1
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			warnAcidBreath:Show(args.destName, amount)
			timerAcidBreath:Start(args.destName)
			timerAcidBreathCD:Start()
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnAcidBreath:Show(args.amount)
				else
					specWarnAcidBreathOther:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 143773 then
		timerFrostBreathCD:Start()
		local amount = args.amount or 1
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			warnFrostBreath:Show(args.destName, amount)
			timerFrostBreath:Start(args.destName)
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnFrostBreath:Show(args.amount)
				else
					specWarnFrostBreathOther:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 143767 then
		timerScorchingBreathCD:Start()
		local amount = args.amount or 1
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			warnScorchingBreath:Show(args.destName, amount)
			timerScorchingBreath:Start(args.destName)
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnScorchingBreath:Show(args.amount)
				else
					specWarnScorchingBreathOther:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 143440 then
		timerBloodFrenzyCD:Start()
	elseif args.spellId == 143442 then
		local amount = args.amount or 1
		timerBloodFrenzyCD:Start()
		if amount % 2 == 0 then
			warnBloodFrenzy:Show(args.destName, amount)
		end
	elseif args.spellId == 143445 then
		warnFixate:Show(args.destName)
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			yellFixate:Yell()
--DELETE		soundFixate:Play()
			sndWOP:Play(DBM.SoundMMPath.."\\justrun.ogg") --快跑
		end
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 8)
		end
		sndPX:Cancel(DBM.SoundMMPath.."\\aesoon.ogg")
		sndPX:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndPX:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndPX:Cancel(DBM.SoundMMPath.."\\countone.ogg")
	elseif args.spellId == 143791 then
		warnCorrosiveBlood:CombinedShow(0.5, args.destName)
		timerCorrosiveBloodCD:DelayedStart(0.5)
		if self:AntiSpam(2, 3) then
			dispnum = dispnum + 1
			if ((mod.Options.optDD == "DD1") and (dispnum == 1)) or ((mod.Options.optDD == "DD2") and (dispnum == 2)) or ((mod.Options.optDD == "DD3") and (dispnum == 3)) then
				specWarnCorrosiveBlood:Show(">>"..dispnum.."<<")
				sndWOP:Play(DBM.SoundMMPath.."\\dispelnow.ogg") --快驅散
			end
			if dispnum == 3 then dispnum = 0 end
		end
	elseif args.spellId == 143800 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 3 then
			specWarnIcyBlood:Show(amount)
			if amount == 4 then
				sndWOP:Play(DBM.SoundMMPath.."\\ex_so_zybd.ogg") --注意冰凍
			end
		end
	elseif args.spellId == 143777 then
		warnFrozenSolid:CombinedShow(1, args.destName)--On 25 man, many targets get frozen and often at/near the same time. try to batch em up a bit
		if self:AntiSpam(3, 1) then
			specWarnFrozenSolid:Show(args.destName)
			if mod:IsDps() then
				sndWOP:Play(DBM.SoundMMPath.."\\ex_so_bmkd.ogg") -- 冰墓快打
			end
		end
	elseif args.spellId == 145974 then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
		local source = args.sourceName
		if (source == UnitName("target") or source == UnitName("focus")) and mod:IsTank() then
			sndWOP:Play(DBM.SoundMMPath.."\\enrage.ogg") -- 激怒
		elseif mod:CanRemoveEnrage() then
			sndWOP:Play(DBM.SoundMMPath.."\\trannow.ogg") -- 注意寧神
		end
	elseif args.spellId == 146589 then
		warnKey:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143766 then
		timerFearsomeRoar:Cancel(args.destName)
	elseif args.spellId == 143780 then
		timerAcidBreath:Cancel(args.destName)
	elseif args.spellId == 143773 then
		timerFrostBreath:Cancel(args.destName)
	elseif args.spellId == 143767 then
		timerScorchingBreath:Cancel(args.destName)
	elseif args.spellId == 143440 then
		timerBloodFrenzyCD:Cancel()
		screechCount = 0
		if self:IsLFR() then
			timerDeafeningScreechCD:Start(19, 1)
			sndPX:Schedule(16, DBM.SoundMMPath.."\\aesoon.ogg")
			sndPX:Schedule(17, DBM.SoundMMPath.."\\countthree.ogg")
			sndPX:Schedule(18, DBM.SoundMMPath.."\\counttwo.ogg")
			sndPX:Schedule(19, DBM.SoundMMPath.."\\countone.ogg")
		else
			timerDeafeningScreechCD:Start(nil, 1)
			sndPX:Schedule(10, DBM.SoundMMPath.."\\aesoon.ogg")
			sndPX:Schedule(11, DBM.SoundMMPath.."\\countthree.ogg")
			sndPX:Schedule(12, DBM.SoundMMPath.."\\counttwo.ogg")
			sndPX:Schedule(13, DBM.SoundMMPath.."\\countone.ogg")
		end
		if self.Options.RangeFrame and not self:IsLFR() then
			--if self:IsDifficulty("normal10", "heroic10") then
			--	DBM.RangeCheck:Show(10, nil, nil, 4)
			--else
			DBM.RangeCheck:Show(10, nil, nil, 14)
			--end
		end
	elseif args.spellId == 143445 then
		timerFixate:Cancel(args.destName)
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			sndWOP:Play(DBM.SoundMMPath.."\\safenow.ogg") --安全
		end
	end
end

--High performance detection of burningBlood targets
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 143783 and not bloodTargets[destGUID] then--The actual target of the fire, has no cast event, just initial damage using THIS ID
		bloodTargets[destGUID] = true
		warnBurningBlood:CombinedShow(0.5, destName)
		timerBurningBloodCD:DelayedStart(0.5)
		self:Unschedule(clearBloodTargets)
		self:Schedule(3, clearBloodTargets)
		if destGUID == UnitGUID("player") then
			specWarnBurningBlood:Show()
			yellBurningBlood:Yell()
			sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg") --快躲開
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 143784 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 2) then--Different from abobe ID, this is ID that fires for standing in fire on ground (even if you weren't target the fire spawned under)
		specWarnBurningBloodMove:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg") --快躲開
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	--"<80.5 19:14:22> [UNIT_SPELLCAST_SUCCEEDED] Thok the Bloodthirsty [[boss1:Blood Frenzy::0:144067]]", -- [6548]
	--"<80.7 19:14:22> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#%s detects a cluster of injured enemies and goes into a  |cFFFF0404|Hspell:143440|h[Blood Frenzy]|h|r!#Thok the Bloodthirsty
	--"<84.2 19:14:26> [CLEU] SPELL_AURA_APPLIED#false#0xF151176900000D94#Thok the Bloodthirsty#68168#0#0xF151176900000D94#Thok the Bloodthirsty#68168#0#143440#Blood Frenzy#1#BUFF", -- [6851]
	if spellId == 144067 then--Faster than combatlog ^^
		--Unlike bloods, breaths do cancel in frenzy phase
		timerFearsomeRoarCD:Cancel()
		timerAcidBreathCD:Cancel()
		timerFrostBreathCD:Cancel()
		timerScorchingBreathCD:Cancel()
		timerDeafeningScreechCD:Cancel()
		timerTailLashCD:Cancel()
		specWarnBloodFrenzy:Show()
--DELETE	soundBloodFrenzy:Play()
		sndWOP:Play(DBM.SoundMMPath.."\\ptwo.ogg") --2階段準備
		if self.Options.RangeFrame and not self:IsLFR() then
			DBM.RangeCheck:Hide()
		end
		phase = 2
		if self.Options.LTRange then
			checkbossrange()
		end
	--He retains/casts "blood" abilities through Blood frenzy, and only stops them when he changes to different Pustles
	--This is why we cancel Blood cds above
	elseif spellId == 143971 then
		timerBurningBloodCD:Cancel()
		warnAcidPustules:Show()
		timerCorrosiveBloodCD:Start(6)
		timerAcidBreathCD:Start()
		sndWOP:Play(DBM.SoundMMPath.."\\ex_so_dyqh.ogg") --毒液恐龍
		phase = 1
	elseif spellId == 143968 then
		timerBurningBloodCD:Cancel()
		timerCorrosiveBloodCD:Cancel()
		warnFrostPustules:Show()
		timerFrostBreathCD:Start(6)
		sndWOP:Play(DBM.SoundMMPath.."\\ex_so_bsqh.ogg") --冰霜恐龍
		phase = 1
	elseif spellId == 143970 then
		timerCorrosiveBloodCD:Cancel()
		warnFirePustules:Show()
		timerBurningBloodCD:Start(8)
		timerScorchingBreathCD:Start()
		sndWOP:Play(DBM.SoundMMPath.."\\ex_so_lyqh.ogg") --烈焰恐龍
		phase = 1
	end
end
