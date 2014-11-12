local mod	= DBM:NewMod(325, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(55312)
mod:SetModelSound("sound\\CREATURE\\Yorsahj\\VO_DS_YORSAHJ_INTRO_01.OGG", "sound\\CREATURE\\Yorsahj\\VO_DS_YORSAHJ_SPELL_02")
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_DIED"
)

local warnOozes			= mod:NewTargetAnnounce("ej3978", 4)
local warnOozesHit		= mod:NewAnnounce("warnOozesHit", 3, 16372)
local warnVoidBolt		= mod:NewStackAnnounce(104849, 3, nil, mod:IsTank() or mod:IsHealer())
local warnManaVoid		= mod:NewSpellAnnounce(105530, 3)
local warnDeepCorruption	= mod:NewSpellAnnounce(105171, 4)

local specWarnOozes		= mod:NewSpecialWarningSpell("ej3978")
local specWarnVoidBolt	= mod:NewSpecialWarningStack(104849, mod:IsTank() or mod:IsHealer(), 2)
local specWarnManaVoid	= mod:NewSpecialWarningSpell(105530, mod:IsDps() or mod:IsManaUser())
local specWarnPurple		= mod:NewSpecialWarningSpell(104896, mod:IsTank() or mod:IsHealer())

local timerOozesCD		= mod:NewNextTimer(90, "ej3978")
local timerOozesReach		= mod:NewTimer(34.5, "timerOozesReach", 16372)
local timerAcidCD		= mod:NewCDTimer(8, 105573, nil, mod:IsHealer())
local timerSearingCD	= mod:NewNextTimer(6, 105033, nil, false)
local timerVoidBoltCD	= mod:NewCDTimer(6, 104849, nil, mod:IsTank())
local timerVoidBolt			= mod:NewTargetTimer(12, 104849, nil, mod:IsTank() or mod:IsHealer())--Nerfed yet again, its now 12. Good thing dbm timers were already right since i dbm pulls duration from aura heh.
local timerManaVoid			= mod:NewBuffFadesTimer(4, 105530, nil, mod:IsManaUser())
local timerDeepCorruption	= mod:NewBuffFadesTimer(25, 105171, nil, mod:IsTank() or mod:IsHealer())

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("oozesArrow")
mod:AddDropdownOption("ColorPGDB", {"KPurple", "KGreen", "KBlack", "KBlue"}, "KBlack", "misc")
mod:AddDropdownOption("ColorGRBD", {"KGreen", "KBlue", "KBlack"}, "KGreen", "misc")
mod:AddDropdownOption("ColorGYDR", {"KGreen", "KYellow", "KBlack"}, "KGreen", "misc")
mod:AddDropdownOption("ColorBPGY", {"KBlue", "KPurple", "KGreen", "KYellow"}, "KYellow", "misc")
mod:AddDropdownOption("ColorBDPY", {"KBlue", "KBlack", "KPurple", "KYellow"}, "KYellow", "misc")
mod:AddDropdownOption("ColorPRYD", {"KPurple", "KYellow", "KBlack"}, "KYellow", "misc")

local oozesHitTable = {}
local expectedOozes = 0
local yellowActive = false
local bossName = EJ_GetEncounterInfo(325)

local oozeColorsHeroic = {
	[105420] = { L.Purple, L.Green, L.Black, L.Blue },
	[105435] = { L.Green, L.Red, L.Blue, L.Black },
	[105436] = { L.Green, L.Yellow, L.Black, L.Red },
	[105437] = { L.Blue, L.Purple, L.Green, L.Yellow },
	[105439] = { L.Blue, L.Black, L.Purple, L.Yellow },
	[105440] = { L.Purple, L.Red, L.Yellow, L.Black },
}

local oozeColors = {
	[105420] = { L.Purple, L.Green, L.Blue },
	[105435] = { L.Green, L.Red, L.Black },
	[105436] = { L.Green, L.Yellow, L.Red },
	[105437] = { L.Purple, L.Blue, L.Yellow },
	[105439] = { L.Blue, L.Black, L.Yellow },
	[105440] = { L.Purple, L.Red, L.Black },
}

local oozePos = {
  ["BLUE"] = 	{ 71, 34 },
  ["PURPLE"] = 	{ 57, 13 },
  ["RED"] = 	{ 37, 12 },
  ["GREEN"] = 	{ 22, 34 },
  ["YELLOW"] = 	{ 37, 85 },
  ["BLACK"] = 	{ 71, 65 },
}

function mod:OnCombatStart(delay)
	table.wipe(oozesHitTable)
	timerVoidBoltCD:Start(-delay)
	timerOozesCD:Start(22-delay)
	berserkTimer:Start(-delay)
	yellowActive = false
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Hide()
	end
	if self.Options.oozesArrow then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104849) then
		timerVoidBoltCD:Start()
	elseif args:IsSpellID(105530) then
		warnManaVoid:Show()
		specWarnManaVoid:Show()
		sndWOP:Schedule(5, "killvoid")
		timerManaVoid:Start()
	elseif args:IsSpellID(105573) and self:IsInCombat() then
		if yellowActive then
			timerAcidCD:Start(3.5)
		else
			timerAcidCD:Start()
		end
	elseif args:IsSpellID(105033) and args:GetSrcCreatureID() == 55312 then
		if yellowActive then
			timerSearingCD:Start(3.5)
		else
			timerSearingCD:Start()
		end
	elseif args:IsSpellID(105171) then
		timerDeepCorruption:Start()
		warnDeepCorruption:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104849) then
		warnVoidBolt:Show(args.destName, args.amount or 1)
		local _, _, _, _, _, duration, expires = UnitDebuff(args.destName, args.spellName)
		timerVoidBolt:Start(duration, args.destName)
		if (args.amount or 1) >= 3 then
			specWarnVoidBolt:Show(args.amount)
		end
	elseif args:IsSpellID(104901) and args:GetDestCreatureID() == 55312 then--Yellow
		table.insert(oozesHitTable, L.Yellow)
		if #oozesHitTable == expectedOozes then
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
		yellowActive = true
		if self.Options.oozesArrow then
			DBM.Arrow:Hide()
		end
	elseif args:IsSpellID(104896) and args:GetDestCreatureID() == 55312 then--Purple
		table.insert(oozesHitTable, L.Purple)
		if #oozesHitTable == expectedOozes then
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
		specWarnPurple:Show()--We warn here to make sure everyone is topped off and things like healing rain are not on ground.
		if self.Options.oozesArrow then
			DBM.Arrow:Hide()
		end
	elseif args:IsSpellID(105027) and args:GetDestCreatureID() == 55312 then--Blue
		table.insert(oozesHitTable, L.Blue)
		if #oozesHitTable == expectedOozes then
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
		if self.Options.oozesArrow then
			DBM.Arrow:Hide()
		end
	elseif args:IsSpellID(104897) and args:GetDestCreatureID() == 55312 then--Red
		table.insert(oozesHitTable, L.Red)
		if #oozesHitTable == expectedOozes then
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
		if self.Options.oozesArrow then
			DBM.Arrow:Hide()
		end
	elseif args:IsSpellID(104894) and args:GetDestCreatureID() == 55312 then--Black
		table.insert(oozesHitTable, L.Black)
		if #oozesHitTable == expectedOozes then
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
		if self.Options.oozesArrow then
			DBM.Arrow:Hide()
		end
	elseif args:IsSpellID(104898) and args:GetDestCreatureID() == 55312 then--Green
		table.insert(oozesHitTable, L.Green)
		if #oozesHitTable == expectedOozes then
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
		if not self:IsDifficulty("lfr25") then
			sndWOP:Play("spread")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
		if self.Options.oozesArrow then
			DBM.Arrow:Hide()
		end
	end
end				
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104849) then
		timerVoidBolt:Cancel(args.destName)
	elseif args:IsSpellID(104901) and args:GetDestCreatureID() == 55312 then--Yellow Removed
		yellowActive = false
	elseif args:IsSpellID(104897) and args:GetDestCreatureID() == 55312 then--Red Removed
		timerSearingCD:Cancel()
	elseif args:IsSpellID(104898) and args:GetDestCreatureID() == 55312 then--Green Removed
		timerAcidCD:Cancel()
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Hide()
		end
	end
end		

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 55862 or cid == 55866 or cid == 55865 or cid == 55867 or cid == 55864 or cid == 55863 then
		expectedOozes = expectedOozes - 1
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if oozeColors[spellId] and self:AntiSpam() then
		table.wipe(oozesHitTable)
		specWarnOozes:Show()
		timerVoidBoltCD:Start(42)
		timerOozesReach:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			warnOozes:Show(table.concat(oozeColorsHeroic[spellId], ", "))
			if spellId == 105420 then
				if self.Options.ColorPGDB == "KPurple" then
					sndWOP:Play("killpurple")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["PURPLE"][1]/100,oozePos["PURPLE"][2]/100,nil,20)
					end
				elseif self.Options.ColorPGDB == "KGreen" then
					sndWOP:Play("killgreen")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["GREEN"][1]/100,oozePos["GREEN"][2]/100,nil,20)
					end
				elseif self.Options.ColorPGDB == "KBlack" then
					sndWOP:Play("killblack")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLACK"][1]/100,oozePos["BLACK"][2]/100,nil,20)
					end
				elseif self.Options.ColorPGDB == "KBlue" then
					sndWOP:Play("killblue")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLUE"][1]/100,oozePos["BLUE"][2]/100,nil,20)
					end
				end
			elseif spellId == 105435 then
				if self.Options.ColorGRBD == "KGreen" then
					sndWOP:Play("killgreen")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["GREEN"][1]/100,oozePos["GREEN"][2]/100,nil,20)
					end
				elseif self.Options.ColorGRBD == "KBlack" then
					sndWOP:Play("killblack")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLACK"][1]/100,oozePos["BLACK"][2]/100,nil,20)
					end
				elseif self.Options.ColorGRBD == "KBlue" then
					sndWOP:Play("killblue")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLUE"][1]/100,oozePos["BLUE"][2]/100,nil,20)
					end
				end
			elseif spellId == 105436 then
				if self.Options.ColorGYDR == "KYellow" then
					sndWOP:Play("killyellow")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["YELLOW"][1]/100,oozePos["YELLOW"][2]/100,nil,20)
					end
				elseif self.Options.ColorGYDR == "KGreen" then
					sndWOP:Play("killgreen")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["GREEN"][1]/100,oozePos["GREEN"][2]/100,nil,20)
					end
				elseif self.Options.ColorGYDR == "KBlack" then
					sndWOP:Play("killblack")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLACK"][1]/100,oozePos["BLACK"][2]/100,nil,20)
					end
				end
			elseif spellId == 105437 then
				if self.Options.ColorBPGY == "KPurple" then
					sndWOP:Play("killpurple")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["PURPLE"][1]/100,oozePos["PURPLE"][2]/100,nil,20)
					end
				elseif self.Options.ColorBPGY == "KGreen" then
					sndWOP:Play("killgreen")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["GREEN"][1]/100,oozePos["GREEN"][2]/100,nil,20)
					end
				elseif self.Options.ColorBPGY == "KYellow" then
					sndWOP:Play("killyellow")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["YELLOW"][1]/100,oozePos["YELLOW"][2]/100,nil,20)
					end
				elseif self.Options.ColorBPGY == "KBlue" then
					sndWOP:Play("killblue")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLUE"][1]/100,oozePos["BLUE"][2]/100,nil,20)
					end
				end
			elseif spellId == 105439 then
				if self.Options.ColorBDPY == "KPurple" then
					sndWOP:Play("killpurple")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["PURPLE"][1]/100,oozePos["PURPLE"][2]/100,nil,20)
					end
				elseif self.Options.ColorBDPY == "KBlack" then
					sndWOP:Play("killblack")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLACK"][1]/100,oozePos["BLACK"][2]/100,nil,20)
					end
				elseif self.Options.ColorBDPY == "KYellow" then
					sndWOP:Play("killyellow")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["YELLOW"][1]/100,oozePos["YELLOW"][2]/100,nil,20)
					end
				elseif self.Options.ColorBDPY == "KBlue" then
					sndWOP:Play("killblue")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLUE"][1]/100,oozePos["BLUE"][2]/100,nil,20)
					end
				end
			elseif spellId == 105440 then
				if self.Options.ColorPRYD == "KPurple" then
					sndWOP:Play("killpurple")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["PURPLE"][1]/100,oozePos["PURPLE"][2]/100,nil,20)
					end
				elseif self.Options.ColorPRYD == "KBlack" then
					sndWOP:Play("killblack")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["BLACK"][1]/100,oozePos["BLACK"][2]/100,nil,20)
					end
				elseif self.Options.ColorPRYD == "KYellow" then
					sndWOP:Play("killyellow")
					if self.Options.oozesArrow then
						DBM.Arrow:ShowRunTo(oozePos["YELLOW"][1]/100,oozePos["YELLOW"][2]/100,nil,20)
					end
				end
			end
			timerOozesCD:Start(75)
			expectedOozes = 4
		else
			warnOozes:Show(table.concat(oozeColors[spellId], ", "))
			if spellId == 105420 or spellId == 105437 or spellId == 105440 then
				sndWOP:Play("killpurple")
				if self.Options.oozesArrow then
					DBM.Arrow:ShowRunTo(oozePos["PURPLE"][1]/100,oozePos["PURPLE"][2]/100,nil,20)
				end
			elseif spellId == 105435 or spellId == 105436 then
				sndWOP:Play("killgreen")
				if self.Options.oozesArrow then
					DBM.Arrow:ShowRunTo(oozePos["GREEN"][1]/100,oozePos["GREEN"][2]/100,nil,20)
				end
			elseif spellId == 105439 then
				sndWOP:Play("killyellow")
				if self.Options.oozesArrow then
					DBM.Arrow:ShowRunTo(oozePos["YELLOW"][1]/100,oozePos["YELLOW"][2]/100,nil,20)
				end
			end
			timerOozesCD:Start()
			expectedOozes = 3
		end
	end
end
