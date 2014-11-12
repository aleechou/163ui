local mod	= DBM:NewMod(677, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndADD1A	= mod:SoundMM("SoundADD1A")
local sndADD1	= mod:SoundMM("SoundADD1")
local sndADD2A	= mod:SoundMM("SoundADD2A")
local sndADD2	= mod:SoundMM("SoundADD2")
local sndADD3A	= mod:SoundMM("SoundADD3A")
local sndADD3	= mod:SoundMM("SoundADD3")

mod:SetRevision(("$Revision: 9709 $"):sub(12, -3))
mod:SetCreatureID(60399, 60400)--60396 (Rage), 60397 (Strength), 60398 (Courage), 60480 (Titan Spark), 60399 (Qin-xi), 60400 (Jan-xi)
mod:SetZone()
--mod:SetMinSyncRevision(7708)

mod:RegisterCombat("emote", L.Pull)
mod:SetMinCombatTime(25)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 target focus",--For this boss we want target/focus and boss1-2
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_POWER"
)

mod:RegisterEvents(
	"RAID_BOSS_EMOTE"
)

--Rage
local warnRageActivated			= mod:NewCountAnnounce("ej5678", 3, 116525)
local warnFocusedAssault		= mod:NewTargetAnnounce(116525, 2, nil, false)--Completely and totally spammy, this option is just here for those that want this info despite the spam.
--Strength
local warnStrengthActivated		= mod:NewCountAnnounce("ej5677", 3, 116550)
local warnEnergizingSmash		= mod:NewSpellAnnounce(116550, 3, nil, mod:IsMelee())--Also might be spammy
--Courage
local warnCourageActivated		= mod:NewCountAnnounce("ej5676", 3, 116778)
local warnFocusedDefense		= mod:NewTargetAnnounce(116778, 4)
--Sparks (Heroic Only)
--local warnFocusedEnergy			= mod:NewTargetAnnounce(116829, 4)
--Jan-xi and Qin-xi
local warnBossesActivatedSoon	= mod:NewPreWarnAnnounce("ej5726", 10, 3, 116815)
local warnBossesActivated		= mod:NewSpellAnnounce("ej5726", 3, 116815)
local warnArcLeft				= mod:NewCountAnnounce(116968, 4, 89570, mod:IsMelee())--This is a pre warn, gives you time to move
local warnArcRight				= mod:NewCountAnnounce(116971, 4, 87219, mod:IsMelee())--This is a pre warn, gives you time to move
local warnArcCenter				= mod:NewCountAnnounce(116972, 4, 74922, mod:IsMelee())--This is a pre warn, gives you time to move
local warnStomp					= mod:NewCountAnnounce(116969, 4, nil, mod:IsMelee())--This is NOT a pre warn, only fires when stomp ends cast. :(
local warnTitanGas				= mod:NewCountAnnounce(116779, 4)

--Rage
local specWarnFocusedAssault	= mod:NewSpecialWarningYou(116525, false)
--Strength
local specWarnStrengthActivated	= mod:NewSpecialWarningSpell("ej5677", mod:IsTank())--These still need to be tanked. so give tanks special warning when these spawn, and dps can enable it too depending on dps strat.
--Courage
local specWarnCourageActivated	= mod:NewSpecialWarningSwitch("ej5676", mod:IsDps())--These really need to die asap. If they reach the tank, you will have a dead tank on hands very soon after.
local specWarnFocusedDefense	= mod:NewSpecialWarningYou(116778)
--Sparks (Heroic Only)
local specWarnFocusedEnergy		= mod:NewSpecialWarningYou(116829)
--Jan-xi and Qin-xi
local specWarnBossesActivated	= mod:NewSpecialWarningSwitch("ej5726", mod:IsTank())
local specWarnCombo				= mod:NewSpecialWarningSpell("ej5672", mod:IsMelee())
local specWarnTitanGas			= mod:NewSpecialWarningSpell(116779, nil, nil, nil, true)

local specWarnFocused			= mod:NewSpecialWarningMove(116525)

--Rage
local timerRageActivates		= mod:NewNextCountTimer(30, "ej5678", nil, nil, nil, 116525)
--Strength
local timerStrengthActivates	= mod:NewNextCountTimer(50, "ej5677", nil, nil, nil, 116550)--It's actually 50-55 variation but 50 is good enough.
--Courage
local timerCourageActivates		= mod:NewNextCountTimer(100, "ej5676", nil, nil, nil, 116778)
--Jan-xi and Qin-xi
local timerBossesActivates		= mod:NewNextTimer(107, "ej5726", nil, nil, nil, 116815)--Might be a little funny sounding "Next Jan-xi and Qin-xi" May just localize it later.
local timerTitanGas				= mod:NewBuffActiveTimer(30, 116779)
local timerTitanGasCD			= mod:NewNextCountTimer(150, 116779)

local berserkTimer				= mod:NewBerserkTimer(780)
local dao = 0

for i = 1, 5 do
	mod:AddBoolOption("ragebomb"..i, false, "sound")
end
local specWarnBomb				= mod:NewSpecialWarning("specWarnBomb")
local specWarnKZ				= mod:NewSpecialWarning("specWarnKZ")

mod:AddBoolOption("InfoFrame", false)
mod:AddBoolOption("ArrowOnCombo", mod:IsTank())--Very accurate for tank, everyone else not so much (tanks always in front, and boss always faces tank, so if he spins around on you, you expect it, melee on other hand have backwards arrows if you spun him around.
mod:AddDropdownOption("optKZ", {"kza", "kzb", "kzc", "nokz"}, "nokz", "sound")
mod:AddDropdownOption("optBY", {"tarfoc", "Janxi", "Qinxi", "none"}, "tarfoc", "sound")

local comboWarned = false
local sparkCount = 0
local comboCount = 0
local titanGasCast = 0
local courageCount = 0
local strengthCount = 0
local rageCount = 1
local focusedAssault = GetSpellInfo(116525)
local Isstomp = 0
local ragetime = 0

local rageTimers = {
	[1] = 15,
	[2] = 33,
	[3] = 33,
	[4] = 33,
	[5] = 33,
	[6] = 33,
	[7] = 83,
	[8] = 33,
	[9] = 33,
	[10]= 83,
	[11]= 33,
	[12]= 33,
	[13]= 83,
--Rest are all 33
}

local function MyBomb()
	if (mod.Options.ragebomb1 and rageCount == 3) or (mod.Options.ragebomb2 and rageCount == 6) or (mod.Options.ragebomb3 and rageCount == 9) or (mod.Options.ragebomb4 and rageCount == 12) or (mod.Options.ragebomb5 and rageCount == 15) then
		return true
	end
	return false
end

local function MyKZ()
	if (mod.Options.optKZ == "kza" and rageCount % 3 == 1) or (mod.Options.optKZ == "kzb" and rageCount % 3 == 2) or (mod.Options.optKZ == "kzc" and rageCount % 3 == 0) then
		return true
	end
	return false
end

function mod:OnCombatStart(delay)
	comboWarned = false
	sparkCount = 0
	comboCount = 0
	titanGasCast = 0
	rageCount = 1
	Isstomp = 0
	strengthCount = 0
	courageCount = 0
	if self:IsDifficulty("heroic10", "heroic25") then--Heroic trigger is shorter, everything comes about 6 seconds earlier
		timerStrengthActivates:Start(35-delay, 1)
		timerCourageActivates:Start(69-delay, 1)
		timerBossesActivates:Start(101-delay)
	else
		timerStrengthActivates:Start(42-delay, 1)
		timerCourageActivates:Start(75-delay, 1)
		timerBossesActivates:Start(-delay)
	end
	timerRageActivates:Start(15, rageCount)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(focusedAssault)
		DBM.InfoFrame:Show(10, "playerbaddebuff", 116525)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.ArrowOnCombo then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(116525) then
		warnFocusedAssault:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedAssault:Show()
		end
	elseif args:IsSpellID(116778) then
		warnFocusedDefense:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedDefense:Show()
			if not mod:IsTank() then
				sndWOP:Play("justrun") --快跑
			end
		end
	elseif args:IsSpellID(116829) then
--		warnFocusedEnergy:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedEnergy:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(116778) then
		if args:IsPlayer() then
			sndWOP:Play("safenow") --安全
		end
	end
end

local function addsDelay(add)
	if add == "Courage" then
		courageCount = courageCount + 1
		warnCourageActivated:Show(courageCount)
		specWarnCourageActivated:Show()
		--Titan gases delay spawns by 50 seconds, even on heroic (even though there is no actual gas phase, the timing stays same on heroic)
		if courageCount >= 2 then
			timerCourageActivates:Start(150, courageCount+1)
		else
			timerCourageActivates:Start(100, courageCount+1)
		end
	elseif add == "Strength" then
		strengthCount = strengthCount + 1
		warnStrengthActivated:Show(strengthCount)
		specWarnStrengthActivated:Show()
		--Titan gases delay spawns by 50 seconds, even on heroic (even though there is no actual gas phase, the timing stays same on heroic)
		if strengthCount == 4 or strengthCount == 6 or strengthCount == 8 then--The add counts where the delays are
			timerStrengthActivates:Start(100, strengthCount+1)
		else
			timerStrengthActivates:Start(50, strengthCount+1)
		end
	elseif add == "Rage" then
		warnRageActivated:Show(rageCount)
		rageCount = rageCount + 1
		ragetime = rageTimers[rageCount] or 33
		--Titan gas delay has funny interaction with these and causes 30 or 60 second delays. Pretty much have to use a table.
		timerRageActivates:Start(ragetime, rageCount)
		mod:Schedule(ragetime, addsDelay, "Rage")--Because he doesn't always yell, schedule next one here as a failsafe
		if mod:IsDifficulty("heroic10", "heroic25") then
			if MyBomb() then
				specWarnBomb:Schedule(ragetime + 1, rageCount)
				sndWOP:Schedule(ragetime + 1, "ex_mop_bpzb") --爆破準備
			end
			if MyKZ() then
				specWarnKZ:Schedule(ragetime - 5, rageCount)
				sndWOP:Schedule(ragetime - 5, "ex_mop_kzzb")
			end
		end
		sndADD1A:Schedule(ragetime - 6, "ex_mop_qjbzb") --輕甲
		sndADD1:Schedule(ragetime - 1, "ex_mop_qjbcx")	
	elseif add == "Boss" then
		warnBossesActivated:Show()
		specWarnBossesActivated:Show(10)
		if not mod:IsDifficulty("heroic10", "heroic25") then
			timerTitanGasCD:Start(113, 1)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Rage or msg:find(L.Rage) then--Apparently boss only yells sometimes, so this isn't completely reliable
		self:Unschedule(addsDelay, "Rage")--Unschedule any failsafes that triggered and resync to yell
		self:Schedule(14, addsDelay, "Rage")
		if rageCount == 1 then
			sndADD1A:Schedule(5, "ex_mop_qjbzb") --輕甲
			sndADD1:Schedule(10, "ex_mop_qjbcx")
			if mod:IsDifficulty("heroic10", "heroic25") and MyKZ() then
				specWarnKZ:Schedule(6, rageCount)
				sndWOP:Schedule(6, "ex_mop_kzzb") --控制準備
			end
			timerRageActivates:Start(14, rageCount)
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Strength or msg:find(L.Strength) then
		self:Unschedule(addsDelay, "Strength")
		self:Schedule(7, addsDelay, "Strength")
		sndADD3A:Play("ex_mop_zjbzb") --重甲
		sndADD3:Schedule(8, "ex_mop_zjbcx")
	elseif msg == L.Courage or msg:find(L.Courage) then
		self:Unschedule(addsDelay, "Courage")
		self:Schedule(8, addsDelay, "Courage")
		sndADD2A:Play("ex_mop_dbzb") --盾兵
		sndADD2:Schedule(8, "ex_mop_dbkd")
	elseif msg == L.Boss or msg:find(L.Boss) then
		warnBossesActivatedSoon:Show()
		self:Schedule(10, addsDelay, "Boss")
		sndWOP:Schedule(8, "ex_mop_szcz") --雙子
	elseif msg:find("spell:116779") then
		if self:IsDifficulty("heroic10", "heroic25") then--On heroic the boss activates this perminantly on pull and it's always present
			if not self:IsInCombat() then
				DBM:StartCombat(self, 0)
			end
		else--Normal/LFR
			titanGasCast = titanGasCast + 1
			warnTitanGas:Show(titanGasCast)
			specWarnTitanGas:Show()
			sndWOP:Play("ex_mop_ttqt") --泰坦氣體
			if titanGasCast < 4 then -- after Titan Gas casted 4 times, Titan Gas lasts permanently. (soft enrage)
				timerTitanGas:Start()
				timerTitanGasCD:Start(150, titanGasCast+1)
			end
		end
	end
end

function chooseboss(BuId)
	if mod.Options.optBY == "tarfoc" and (BuId ~= "target") and (BuId ~= "focus") then
		return false
	elseif mod.Options.optBY == "Janxi" and (UnitName(BuId) ~= UnitName("boss2")) then
		return false
	elseif mod.Options.optBY == "Qinxi" and (UnitName(BuId) ~= UnitName("boss1")) then
		return false
	elseif mod.Options.optBY == "none" then
		return false
	else
		return true
	end
end

function checkisstomp()
	if mod:IsDps() then
		sndWOP:Schedule(1, "counttwo")
		sndWOP:Schedule(2, "countone")
	end
	mod:Schedule(2, function() Isstomp = 0 end)
	mod:Schedule(4, function() 
		if Isstomp ~= 1 and comboCount ~= 0 then
			sndWOP:Play("ex_mop_jt") --踐踏
		end
	end)
end

function countsoundcombo()
	if comboCount == 10 then
		sndWOP:Schedule(1, "countten")
	elseif comboCount == 9 then
		sndWOP:Schedule(1, "countnine")
	elseif comboCount == 8 then
		sndWOP:Schedule(1, "counteight")
	elseif comboCount == 7 then
		sndWOP:Schedule(1, "countseven")
	elseif comboCount == 6 then
		sndWOP:Schedule(1, "countsix")
	elseif comboCount == 5 then
		sndWOP:Schedule(1, "countfive")
	elseif comboCount == 4 then
		sndWOP:Schedule(1, "countfour")
	elseif comboCount == 3 then
		sndWOP:Schedule(1, "countthree")
	elseif comboCount == 2 then
		sndWOP:Schedule(1, "counttwo")
	elseif comboCount == 1 then
		sndWOP:Schedule(1, "countone")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 116556 and uId == "target" then
		warnEnergizingSmash:Show()
	end
	if (not chooseboss(uId)) then return end
	if spellId == 116968 and self:AntiSpam(2, 1) then--Arc Left
		if self.Options.ArrowOnCombo then
			if self:IsTank() then--Assume tank is in front of the boss
				DBM.Arrow:ShowStatic(90, 3)
			else--Assume anyone else is behind the boss
				DBM.Arrow:ShowStatic(270, 3)
			end
		end
		Isstomp = 1
		comboCount = comboCount + 1
		checkisstomp()
		warnArcLeft:Show(comboCount)
		sndWOP:Play("ex_mop_left") --左側
		if mod:IsHealer() then
			countsoundcombo()
		end
	elseif spellId == 116971 and self:AntiSpam(2, 2) then--Arc Right
		if self.Options.ArrowOnCombo then
			if self:IsTank() then--Assume tank is in front of the boss
				DBM.Arrow:ShowStatic(270, 3)
			else--Assume anyone else is behind the boss
				DBM.Arrow:ShowStatic(90, 3)
			end
		end
		Isstomp = 1
		comboCount = comboCount + 1
		checkisstomp()
		warnArcRight:Show(comboCount)
		sndWOP:Play("ex_mop_right") --右側
		if mod:IsHealer() then
			countsoundcombo()
		end
	elseif spellId == 116972 and self:AntiSpam(2, 3) then--Arc Center
		if self.Options.ArrowOnCombo then
			if self:IsTank() then--Assume tank is in front of the boss
				DBM.Arrow:ShowStatic(0, 3)
			end
		end
		Isstomp = 1
		comboCount = comboCount + 1
		checkisstomp()
		warnArcCenter:Show(comboCount)
		sndWOP:Play("ex_mop_center") --前方
--		specWarnArcCenter:Show()
		if mod:IsHealer() then
			countsoundcombo()
		end
	elseif (spellId == 116969 or spellId == 132425) and self:AntiSpam(2, 4) then--Stomp
		comboCount = comboCount + 1
		warnStomp:Show(comboCount)
	end
end

function mod:UNIT_POWER(uId)
	if (not chooseboss(uId)) then return end
	if (self:GetUnitCreatureId(uId) == 60399 or self:GetUnitCreatureId(uId) == 60400) and UnitPower(uId) == 18 and not comboWarned then
		comboWarned = true
		specWarnCombo:Show()		
		sndWOP:Play("ex_mop_zbbyz") --準備半月斬
		dao = 0
	elseif (self:GetUnitCreatureId(uId) == 60399 or self:GetUnitCreatureId(uId) == 60400) and UnitPower(uId) == 1 then
		comboWarned = false
		comboCount = 0
--		timerComboCD:Start()
	end
end

function mod:SWING_DAMAGE(sourceGUID, _, _, _, destGUID)
	local cid = self:GetCIDFromGUID(sourceGUID)
	if cid == 60396 and destGUID == UnitGUID("player") and self:AntiSpam(3, 5) then
		specWarnFocused:Show()
		sndWOP:Play("runaway") --快躲開
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

--[[achi only 
function mod:SPELL_DAMAGE(_, sourceNAME, _, _, destGUID, _, _, _, spellId)
	if spellId == 116809 then
		dao = dao+1
		SendChatMessage(dao..":"..sourceNAME, "SAY")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE]]