local mod	= DBM:NewMod(311, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(55265)
mod:SetModelSound("sound\\CREATURE\\MORCHOK\\VO_DS_MORCHOK_EVENT_04.OGG", "sound\\CREATURE\\MORCHOK\\VO_DS_MORCHOK_ORB_01")
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warnCrushArmor	= mod:NewStackAnnounce(103687, 3, nil, mod:IsTank() or mod:IsHealer())
local warnCrystal		= mod:NewSpellAnnounce(103639, 3)
local warnStomp			= mod:NewSpellAnnounce(103414, 3)
local warnVortex		= mod:NewSpellAnnounce(103821, 3)
local warnBlood			= mod:NewSpellAnnounce(103851, 4)
local warnFurious		= mod:NewSpellAnnounce(103846, 3)
local warnKohcrom		= mod:NewSpellAnnounce(109017, 4)
local KohcromWarning	= mod:NewAnnounce("KohcromWarning", 2, 55342)

local specwarnCrushArmor	= mod:NewSpecialWarningStack(103687, mod:IsTank(), 3)
local specwarnVortex		= mod:NewSpecialWarningSpell(103821, nil, nil, nil, true)
local specwarnBlood			= mod:NewSpecialWarningMove(103785)
local specwarnCrystal		= mod:NewSpecialWarningSpell(103639)

local timerCrushArmor	= mod:NewTargetTimer(20, 103687, nil, false)
local timerCrystal		= mod:NewCDTimer(13, 103640)
local timerCrystalKohcrom		= mod:NewTimer(13, "KohcromCrystal", 103640)
local timerStomp 		= mod:NewCDTimer(13, 103414)
local timerStompKohcrom 		= mod:NewTimer(13, "KohcromStomp", 103414)
local timerVortexNext	= mod:NewNextTimer(75, 103821)
local timerBlood		= mod:NewBuffActiveTimer(17, 103851)

local berserkTimer		= mod:NewBerserkTimer(420)

mod:AddBoolOption("RangeFrame", false)--For achievement
mod:AddBoolOption("OnlyMorchok", true)
mod:AddBoolOption("OnlyKohcrom", false)

local crystalCount = 0
local bloodphase = false
local safeSpam = false

function mod:OnCombatStart(delay)
	safeSpam = false
	bloodphase = false
	crystalCount = 1
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(-delay)
		timerVortexNext:Start(58-delay)
	else
		timerVortexNext:Start(55-delay)
	end
	timerStomp:Start(-delay)
	sndWOP:Schedule(10, "stompsoon")
	timerCrystal:Start(19-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(103687) then
		warnCrushArmor:Show(args.destName, args.amount or 1)
		timerCrushArmor:Start(args.destName)
		if (args.amount or 1) > 3 then
			specwarnCrushArmor:Show(args.amount or 1)
		end
	elseif args:IsSpellID(103846) and self:AntiSpam(3, 1) then
		warnFurious:Show()
	elseif args:IsSpellID(103541) and args:IsPlayer() and not safeSpam then
		sndWOP:Play("safenow")
		safeSpam = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(103851) then
		bloodphase = false
		if args:GetSrcCreatureID() == 55265 then
			if self.Options.OnlyMorchok then
				timerStomp:Start(19)
				sndWOP:Schedule(16, "stompsoon")
				timerCrystal:Start(26)
			end
			timerVortexNext:Start()
			if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
				DBM.RangeCheck:Hide()
			end
		else
			if self.Options.OnlyKohcrom then
				timerStompKohcrom:Start(25)
				sndWOP:Schedule(22, "stompsoon")
				timerCrystalKohcrom:Start(44)
			end
		end
	elseif args:IsSpellID(103687) then
		if self:IsTank() or self:IsHealer() then
			if not bloodphase then
				sndWOP:Play("changemt")
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(103414) then
		if args:GetSrcCreatureID() == 55265 then
			if self.Options.OnlyMorchok then
				warnStomp:Show()
				sndWOP:Play("stompstart")
				if crystalCount < 3 then
					timerStomp:Start()
					sndWOP:Schedule(10, "stompsoon")
				end
			end
		else
			if self.Options.OnlyKohcrom then
				KohcromWarning:Show(args.sourceName, args.spellName)
				sndWOP:Play("stompstart")
				if crystalCount < 3 then				
					timerStompKohcrom:Start()
					sndWOP:Schedule(10, "stompsoon")
				end
			end
		end
	elseif args:IsSpellID(103851) then
		if args:GetSrcCreatureID() == 55265 then
			warnBlood:Show()
			timerBlood:Start()
			sndWOP:Play("justrun")
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(103639) then
		if args:GetSrcCreatureID() == 55265 then
			crystalCount = crystalCount + 1
			if self.Options.OnlyMorchok then
				warnCrystal:Show()
				specwarnCrystal:Show()
				sndWOP:Play("crystalappear")
				safeSpam = false
				sndWOP:Schedule(9, "countthree")
				sndWOP:Schedule(10, "counttwo")
				sndWOP:Schedule(11, "countone")
				if crystalCount < 3 then
					timerCrystal:Start()
				end
			end
		else
			if self.Options.OnlyKohcrom then		
				KohcromWarning:Show(args.sourceName, args.spellName)
				specwarnCrystal:Show()
				sndWOP:Play("crystalappear")
				safeSpam = false
				sndWOP:Schedule(9, "countthree")
				sndWOP:Schedule(10, "counttwo")
				sndWOP:Schedule(11, "countone")
				if crystalCount < 3 then
					timerCrystalKohcrom:Start()
				end				
			end
		end
	elseif args:IsSpellID(109017) then
		warnKohcrom:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(103821) and self:AntiSpam(3, 1) then
		bloodphase = true
		crystalCount = 0
		warnVortex:Show()
		specwarnVortex:Show()
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Show(5)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 103785 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specwarnBlood:Show()
		sndWOP:Play("runaway")
	end
end
