local mod	= DBM:NewMod(849, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndBD		= mod:NewSound(nil, "SoundBD", mod:IsHealer())

mod:SetRevision(("$Revision: 10402 $"):sub(12, -3))
mod:SetCreatureID(71479, 71475, 71480)--He-Softfoot, Rook Stonetoe, Sun Tenderheart
mod:SetZone()
mod:SetUsedIcons(7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

local Softfoot = EJ_GetSectionInfo(7889)
local Stonetoe = EJ_GetSectionInfo(7885)
local Tenderheart = EJ_GetSectionInfo(7904)

mod:SetBossHealthInfo(
	71479, Softfoot,
	71475, Stonetoe,
	71480, Tenderheart
)

--All
local warnBondGoldenLotus			= mod:NewCastAnnounce(143497, 4)
--Rook Stonetoe
local warnVengefulStrikes			= mod:NewSpellAnnounce(144396, 3, nil, mod:IsTank())
local warnCorruptedBrew				= mod:NewTargetAnnounce(143019, 2)--I do believe target scanning WILL work here, i just need more time to mess with it next round of testing
local warnClash						= mod:NewSpellAnnounce(143027, 3)--No target scanning, no emote, no warning of any kind that gave me a target :\
----Rook Stonetoe's Desperate Measures (66% and 33%)
local warnMiserySorrowGloom			= mod:NewSpellAnnounce(143955, 2)--Activation
local warnCorruptionShock			= mod:NewSpellAnnounce(143958, 3)--Embodied Gloom (spammy if you do it wrong, but very important everyone sees. SOMEONE needs to interrupt it if it keeps going off)
local warnDefiledGround				= mod:NewSpellAnnounce(143961, 3, nil, mod:IsTank())--Embodied Misery
local warnInfernoStrike				= mod:NewTargetAnnounce(143962, 3)
--He Softfoot
local warnGouge						= mod:NewCastAnnounce(143330, 4, nil, nil, mod:IsTank())--The cast, so you can react and turn back to it and avoid stun.
local warnGougeStun					= mod:NewTargetAnnounce(143301, 4, nil, mod:IsTank())--Failed, stunned. the success ID is 143331 (knockback)
local warnGarrote					= mod:NewTargetAnnounce(143198, 3, nil, mod:IsHealer())
----He Softfoot's Desperate Measures
local warnMarkOfAnguish				= mod:NewSpellAnnounce(143812, 2)--Activation
local warnMarked					= mod:NewTargetAnnounce(143840, 3)--Embodied Anguish			
--Sun Tenderheart
local warnShaShear					= mod:NewCastAnnounce(143423, 3, 5, nil, false)
local warnBane						= mod:NewCastAnnounce(143446, 4, nil, nil, mod:IsHealer())
local warnCalamity					= mod:NewSpellAnnounce(143491, 4)
----Sun Tenderheart's Desperate Measures
local warnDarkMeditation			= mod:NewSpellAnnounce(143546, 2)--Activation

--Rook Stonetoe
local specWarnVengefulStrikes		= mod:NewSpecialWarningSpell(144396, mod:IsTank())
local specWarnClash					= mod:NewSpecialWarningYou(143027)
local specWarnCorruptedBrew			= mod:NewSpecialWarningYou(143019)
local yellCorruptedBrew				= mod:NewYell(143019)
local specWarnCorruptedBrewNear		= mod:NewSpecialWarningClose(143019)
local specWarnClashMove				= mod:NewSpecialWarningMove(143010)
----Rook Stonetoe's Desperate Measures
local specWarnMiserySorrowGloom		= mod:NewSpecialWarningSpell(143955)
local specWarnCorruptionShock		= mod:NewSpecialWarningInterrupt(143958, mod:IsMelee())
local specWarnDefiledGround			= mod:NewSpecialWarningMove(143959)
local specWarnInfernoStrike			= mod:NewSpecialWarningYou(143962)
local yellInfernoStrike				= mod:NewYell(143962)
--He Softfoot
local specWarnGouge					= mod:NewSpecialWarningMove(143330, mod:IsTank(), nil, nil, 3)--Maybe localize it as a "turn away" warning.
local specWarnGougeStunOther		= mod:NewSpecialWarningTarget(143301, mod:IsTank())--Tank is stunned, other tank must taunt or he'll start killing people
local specWarnNoxiousPoison			= mod:NewSpecialWarningMove(144367)
----He Softfoot's Desperate measures
local specWarnMarkOfAnquish			= mod:NewSpecialWarningSpell(143812)
local specWarnMarked				= mod:NewSpecialWarningYou(143840)
local yellMarked					= mod:NewYell(143840, nil, false)
local specWarnOC					= mod:NewSpecialWarningStack(144176, nil, 5)
--Sun Tenderheart
local specWarnShaShear				= mod:NewSpecialWarningInterrupt(143423)
local specWarnShaShearYou			= mod:NewSpecialWarningYou(143423)
local yellShaShear					= mod:NewYell(143423)
local specWarnBane					= mod:NewSpecialWarningSpell(143446, mod:IsHealer())
local specWarnBaneDisp				= mod:NewSpecialWarningDispel(143446, mod:IsHealer())
local specWarnCalamity				= mod:NewSpecialWarningSpell(143491, nil, nil, nil, 2)
----Sun Tenderheart's Desperate Measures
local specWarnDarkMeditation		= mod:NewSpecialWarningSpell(143546)

--Rook Stonetoe
local timerVengefulStrikesCD		= mod:NewCDTimer(21, 144396, nil, mod:IsTank())
local timerCorruptedBrewCD			= mod:NewCDTimer(11, 143019)--11-27
local timerClashCD					= mod:NewCDTimer(49, 143027)--49 second next timer IF none of bosses enter a special between casts, otherwise always delayed by specials (and usually cast within 5 seconds after special ends)
----Rook Stonetoe's Desperate Measures
local timerDefiledGroundCD			= mod:NewCDTimer(10.5, 143961, nil, mod:IsTank())
local timerInfernoStrikeCD			= mod:NewNextTimer(9.5, 143962)
--He Softfoot
local timerGougeCD					= mod:NewCDTimer(30, 143330, nil, mod:IsTank())--30-41
local timerGarroteCD				= mod:NewCDTimer(30, 143198, nil, mod:IsHealer())--30-46 (heroic 20-26)
--Sun Tenderheart
local timerBaneCD					= mod:NewCDTimer(17, 143446, nil, mod:IsHealer())--17-25 (heroic 13-20)
local timerCalamityCD				= mod:NewCDTimer(40, 143491)--40-50 (when two can be cast in a row) Also affected by boss specials

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnStrike")
mod:AddBoolOption("RangeFrame", false)

local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local strikeDebuff = GetSpellInfo(143962)--Cast spellid, Unconfirmed if debuff has same id or even name. Need to verify

local kicknum = 0

----Grid----
local GridStatus
if Grid then
	GridStatus = GridStatus or Grid:GetModule("GridStatus")
end
local canrecount = true
local DebuffGuid = {}
--------Grid End----
mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("BaneGridCount", false, "sound")

local calacount = 0
for i = 1, 4 do
	mod:AddBoolOption("dr"..i, false, "sound")
end
mod:AddDropdownOption("optOC", {"imm", "five", "ten", "fift", "twty", "none"}, "imm", "sound")

mod:AddDropdownOption("optDD", {"alldd", "DD1", "DD2", "DD3", "nodd"}, "alldd", "sound")

local function MyJS()
	if (mod.Options.dr1 and calacount == 1) or (mod.Options.dr2 and calacount == 2) or (mod.Options.dr3 and calacount == 3) or (mod.Options.dr4 and calacount == 4) then
		return true
	end
	return false
end

function mod:BrewTarget(targetname, uId)
	if not targetname then return end
	warnCorruptedBrew:Show(targetname)
	if targetname == UnitName("player") then
		specWarnCorruptedBrew:Show()
		yellCorruptedBrew:Yell()
		if not self:IsDifficulty("normal25", "heroic25") then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
		end
	else
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 6 then
				specWarnCorruptedBrewNear:Show(targetname)
				if not self:IsDifficulty("normal25", "heroic25") then					
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
				end
			end
		end
	end
end

function mod:InfernoStrikeTarget(targetname, uId)
	if not targetname then return end
	warnInfernoStrike:Show(targetname)
	if self.Options.SetIconOnStrike then
		self:SetIcon(targetname, 7, 5)
	end
	if targetname == UnitName("player") then
--		specWarnInfernoStrike:Show()
--		yellInfernoStrike:Yell()
--		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runin.mp3") --快回人群
	end
end

function mod:OnCombatStart(delay)
	timerVengefulStrikesCD:Start(7-delay)
	timerGarroteCD:Start(15-delay)
	timerBaneCD:Start(15-delay)
	timerCorruptedBrewCD:Start(18-delay)
	timerGougeCD:Start(23-delay)
	timerCalamityCD:Start(31-delay)
	timerClashCD:Start(45-delay)
	if self:IsDifficulty("lfr25") then--Might also be flex as well
		berserkTimer:Start(900-delay)--15min confirmed
	else
		berserkTimer:Start(-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
	calacount = 0
	kicknum = 0
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(EJ_GetSectionInfo(8017))
		DBM.InfoFrame:Show(3, "FPHealth")
	end
	if GridStatus then
		GridStatusBaneDbmCount:UpdateAllUnitAuras()
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if GridStatus then
		GridStatusBaneDbmCount:UpdateAllUnitAuras()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143958 then
		local source = args.sourceName
		warnCorruptionShock:Show()
		kicknum = kicknum + 1
		if ((mod.Options.optDD == "DD1") and (kicknum == 1)) or ((mod.Options.optDD == "DD2") and (kicknum == 2)) or ((mod.Options.optDD == "DD3") and (kicknum == 3)) or ((mod.Options.optDD == "alldd") and (source == UnitName("target") or source == UnitName("focus"))) then
			specWarnCorruptionShock:Show(source)
			sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3")
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3") --快打斷
		end
		if ((mod.Options.optDD == "DD1") and (kicknum == 3)) or ((mod.Options.optDD == "DD2") and (kicknum == 1))  or ((mod.Options.optDD == "DD3") and (kicknum == 2)) then
			sndWOP:Schedule(3, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3") --打斷準備
		end
		if kicknum == 3 then kicknum = 0 end
	elseif args.spellId == 143330 then
		warnGouge:Show()
		timerGougeCD:Start()
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnGouge:Show()--So show tank warning
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\turnaway.mp3") --快轉身
			end
		end
	elseif args.spellId == 143446 then
		warnBane:Show()
		specWarnBane:Show()
		sndBD:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_ays.mp3") --暗言術準備
		if self:IsDifficulty("heroic10", "heroic25") then
			timerBaneCD:Start(13)--TODO, verify normal to see if it was changed too
		else
			timerBaneCD:Start()
		end
		canrecount = true
	elseif args.spellId == 143491 then
		calacount = calacount + 1
		warnCalamity:Show()
		specWarnCalamity:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_zxzb.mp3") --災禍準備
		if MyJS() then
			sndWOP:Schedule(1.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
		end
		sndWOP:Schedule(2.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(3.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(4.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		timerCalamityCD:Start()
		if calacount == 4 then calacount = 0 end
	elseif args.spellId == 143961 then
		warnDefiledGround:Show()
		timerDefiledGroundCD:Start()
	elseif args.spellId == 143962 then
		timerInfernoStrikeCD:Start()
		self:BossTargetScanner(71481, "InfernoStrikeTarget", 0.5, 1)--Must be single scan with correct timing. mob changes target a lot and can grab many bad targets if timing not perfect.
	elseif args.spellId == 143497 then
		warnBondGoldenLotus:Show()
	elseif args.spellId == 144396 then
		warnVengefulStrikes:Show()
		if mod:IsHealer() and self:AntiSpam(2, 3) then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_fcdj.mp3") --復仇打擊
		end
		timerVengefulStrikesCD:Start()
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnVengefulStrikes:Show()--So show tank warning
				if self:AntiSpam(2, 3) then
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_fcdj.mp3")--復仇打擊
				end
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143027 then
		warnClash:Show()
		timerClashCD:Start()
		if args:IsPlayer() then
			specWarnClash:Show()
		end
	elseif args.spellId == 143423 then
		local source = args.sourceName
		if source == UnitName("target") or source == UnitName("focus") then--Only warn if your target or focus, period, because if you aren't actually dpsing her, you just stay out of melee range and ignore this
--			warnShaShear:Show()
--			specWarnShaShear:Show(source)
		end
	elseif args.spellId == 143446 then
		specWarnBaneDisp:Show()
		sndBD:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
		self:Schedule(2, function() canrecount = false end)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143959 and args:IsPlayer() and self:AntiSpam(1.5, 2) then
		specWarnDefiledGround:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	elseif args.spellId == 143301 then--Stun debuff spellid
		warnGougeStun:Show(args.destName)
		if not args:IsPlayer() then
			specWarnGougeStunOther:Show(args.destName)
			if mod:IsTank() then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\tauntboss.mp3") --嘲諷BOSS
			end
		end
	elseif args.spellId == 143198 then
		warnGarrote:Show(args.destName)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerGarroteCD:Start(20)--TODO, see if it's cast more often on heroic only, or if normal was also changed to 20
		else
			timerGarroteCD:Start()
		end
	elseif args.spellId == 143840 then
		warnMarked:Show(args.destName)
		if args:IsPlayer() then
			specWarnMarked:Show(args.destName)
			yellMarked:Yell()
			if self.Options.optOC == "imm" then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_cdyj.mp3")--傳遞印記
			end
		end
	--Special phases
	elseif args.spellId == 143546 then--Dark Meditation
		warnDarkMeditation:Show()
		specWarnDarkMeditation:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_amqh.mp3")--暗牧強化
		timerBaneCD:Cancel()
		timerCalamityCD:Cancel()
	elseif args.spellId == 143955 then--Misery, Sorrow, and Gloom
		warnMiserySorrowGloom:Show()
		specWarnMiserySorrowGloom:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_wsqh.mp3")--武僧強化
		timerVengefulStrikesCD:Cancel()
		timerClashCD:Cancel()
		timerCorruptedBrewCD:Cancel()
		timerInfernoStrikeCD:Start(8)
		timerDefiledGroundCD:Start(10)
		kicknum = 0
		if mod.Options.optDD == "DD1" then
			sndWOP:Schedule(2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3") --打斷準備
		end
	elseif args.spellId == 143812 then--Mark of Anguish
		warnMarkOfAnguish:Show()
		specWarnMarkOfAnquish:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_dzqh.mp3")--盜賊強化
		timerGougeCD:Cancel()
		timerGarroteCD:Cancel()
		timerCalamityCD:Cancel()--Can't be cast during THIS special
	elseif args.spellId == 143434 then
		if not GridStatus or not mod.Options.BaneGridCount then return end
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 71480 then
			DebuffGuid[args.destGUID] = true
			GridStatusBaneDbmCount:UpdateAllUnitAuras()
		end
	elseif args.spellId == 143423 then
		warnShaShear:Show(args.destName)
		if args:IsPlayer() then
			specWarnShaShearYou:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runout.mp3")--離開人群
		end
	elseif args.spellId == 144176 then
		local OCn = self.Options.optOC == "imm" and 2 or self.Options.optOC == "five" and 5 or self.Options.optOC == "ten" and 10 or self.Options.optOC == "fift" and 15 or self.Options.optOC == "twty" and 20 or self.Options.optOC == "none" and 0
		if args:IsPlayer() and UnitDebuff("player", GetSpellInfo(143840)) then
			if (args.amount or 1) >= OCn then
				specWarnOC:Show(args.amount)
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_cdyj.mp3") --傳遞印記
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	--Special phases
	if args.spellId == 143546 then--Dark Meditation
		timerBaneCD:Start(10)
		timerCalamityCD:Start(23)--Now back to not cast right away again.
	elseif args.spellId == 143955 then--Misery, Sorrow, and Gloom
		timerDefiledGroundCD:Cancel()
		timerInfernoStrikeCD:Cancel()
		timerCorruptedBrewCD:Start(12)
		timerVengefulStrikesCD:Start(18)
		timerClashCD:Start(46)
	elseif args.spellId == 143812 then--Mark of Anguish
		timerGarroteCD:Start(12)--TODO, verify consistency in all difficulties
		timerGougeCD:Start(23)--Seems to be either be exactly 23 or exactly 35. Not sure what causes it to switch.
	elseif args.spellId == 143434 then
		if not GridStatus or not mod.Options.BaneGridCount then return end
		if DebuffGuid[args.destGUID] then
			DebuffGuid[args.destGUID] = nil
			canrecount = false
			GridStatusBaneDbmCount:UpdateAllUnitAuras()
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 144357 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 3) then
		specWarnDefiledGround:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	elseif spellId == 144367 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 4) then
		specWarnNoxiousPoison:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	elseif spellId == 143009 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnClashMove:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 143019 then--Does not show in combat log on normal
		self:BossTargetScanner(71475, "BrewTarget", 0.025)
		timerCorruptedBrewCD:Start()
		if self:IsDifficulty("normal25", "heroic25") then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\watchstep.mp3") --注意腳下
		end
	end
end

------------------------

if not GridStatus then return end

local fixduration = 0
local flashicon
local elapsed = 0
local flashcount = {}
local icon_prefix = "Interface\\AddOns\\DBM-Core\\textures\\count\\"
local indicators = {}
local counter = 0

GridStatusBaneDbmCount = GridStatus:NewModule("GridStatusBaneDbmCount")

GridStatusBaneDbmCount.defaultDB = {
	dbm_grid_banecountmod = {
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1, ignore = true },
		setflash = {[1] = false, [2] = false, [3] = false, [4] = false, [5] = false },
		priority = 99,
		range = false,
		raidframecount = false,
	}
}

function GridStatusBaneDbmCount:OnInitialize()
	local GridStatusBaneDbmCountName = L.DBM_GridBaneCount
	self.super.OnInitialize(self)	
	local option = {}	
	option["raidframecount"] = {
		type = "toggle",
		name = L.BaneRaidFrameCount,
		order = 10,
		get = function()
			return GridStatusBaneDbmCount.db.profile.dbm_grid_banecountmod.raidframecount
		end,
		set = function()
			GridStatusBaneDbmCount.db.profile.dbm_grid_banecountmod.raidframecount = not GridStatusBaneDbmCount.db.profile.dbm_grid_banecountmod.raidframecount
		end
	}
	local i
	for i = 1, 5 do
		option["setflash" .. i] = {
			type = "toggle",
			name = L.optBaneGridCount .. i,
			order = 10 + i,
			get = function()
				return GridStatusBaneDbmCount.db.profile.dbm_grid_banecountmod.setflash[i]
			end,
			set = function()
				GridStatusBaneDbmCount.db.profile.dbm_grid_banecountmod.setflash[i] = not GridStatusBaneDbmCount.db.profile.dbm_grid_banecountmod.setflash[i]
			end
		}
	end
	self:RegisterStatus("dbm_grid_banecountmod", GridStatusBaneDbmCountName, option, true)
end

local function FlashIcon(self, elapsed)
	local settings = GridStatusBaneDbmCount.db.profile.dbm_grid_banecountmod
	for i, params in pairs(flashcount) do
		local cd_start = params.start
		local cd_duration = params.duration
		if flashicon == params.queue then
			flashicon = params.queue.."b"
		else
			flashicon = params.queue
		end
		GridStatusBaneDbmCount.core:SendStatusLost(i, "dbm_grid_banecountmod")
		GridStatusBaneDbmCount.core:SendStatusGained(i, "dbm_grid_banecountmod",
			settings.priority,
			(settings.range and 40),
			{r = settings.color.r, g = settings.color.g, b = settings.color.b, a = settings.color.a, ignore = true},
			tostring(params.queue),
			nil,
			nil,
			icon_prefix..flashicon..".tga",
			cd_start,
			cd_duration
		)
	end
end

function GridStatusBaneDbmCount:OnStatusEnable(status)
	if status == "dbm_grid_banecountmod" then
		self.CountFrame = CreateFrame("Frame")
		self.CountFrame:SetScript("OnUpdate", function(self, e)
			elapsed = elapsed + e
			if elapsed >= 0.5 then
				FlashIcon(self, elapsed)
				elapsed = 0
			end
		end)
		self.CountFrame:Show()
	end
end

function GridStatusBaneDbmCount:OnStatusDisable(status)
	if status == "dbm_grid_banecountmod" then
		self.CountFrame:Hide()
		self.core:SendStatusLostAllUnits("dbm_grid_banecountmod")
	end
end

local function sortByGroupAsc(a,b)
	if a.gp == b.gp then
		if GridStatusBaneDbmCount.db.profile.dbm_grid_banecountmod.raidframecount then
			return a.ui < b.ui
		else
			return a.n < b.n
		end
	else
		return a.gp < b.gp
	end
end

local function hasDebuff(unitid)
	local i = 1
	while true do
		local name, _, _, _, _, duration, expirationTime = UnitDebuff(unitid, i)
		if not name then
			break
		end
		local debuffname = GetSpellInfo(143434)
		if name == debuffname then
			return duration, expirationTime
		end
		i = i + 1
	end
	return nil
end

function GridStatusBaneDbmCount:UpdateAllUnitAuras()
	local settings = self.db.profile.dbm_grid_banecountmod	
	local countsort = 0
	local k = 0
	local tbl = {}
	if canrecount then
		counter = 0
		table.wipe(indicators)
	end
	table.wipe(flashcount)
	
	for unitid in DBM:GetGroupMembers() do
		local guid = UnitGUID(unitid)
		local name, subgroup
		local index = UnitInRaid(unitid)
		if UnitInRaid(unitid) then
			name, _, subgroup = GetRaidRosterInfo(index)
		end		
		if subgroup then
			table.insert(tbl, {ui = index, g = guid, n = name, gp = subgroup})
			countsort = countsort + 1
		end
	end

	table.sort(tbl, sortByGroupAsc)
  	for k = 1, countsort do
		if DebuffGuid[tbl[k].g] then			
			if not indicators[tbl[k].g] and canrecount then
				counter = counter + 1
				indicators[tbl[k].g] = counter
			end			
		end
	end
	
	for unitid in DBM:GetGroupMembers() do
		local guid = UnitGUID(unitid)
		local count = indicators[guid]
		local duration, expiration = hasDebuff(unitid)
		if count and duration then
			local cd_start = expiration - duration
			local cd_duration
			if fixduration then
				cd_duration = fixduration
			else
				cd_duration = duration
			end		
			self.core:SendStatusGained(guid, "dbm_grid_banecountmod",
				settings.priority,
				(settings.range and 40),
				{r = settings.color.r, g = settings.color.g, b = settings.color.b, a = settings.color.a, ignore = true},
				tostring(count),
				nil,
				nil,
				icon_prefix..count..".tga",
				cd_start,
				cd_duration
			)
			if settings.setflash[count] then
				flashcount[guid] = {start = cd_start, duration = cd_duration, queue = count}
			end
		else
			self.core:SendStatusLost(guid, "dbm_grid_banecountmod")
		end
	end 
end