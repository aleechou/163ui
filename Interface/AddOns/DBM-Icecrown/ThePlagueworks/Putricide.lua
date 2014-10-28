local mod	= DBM:NewMod("Putricide", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 58 $"):sub(12, -3))
mod:SetCreatureID(36678)
mod:SetModelID(30881)
mod:SetUsedIcons(5, 6, 7, 8)
--mod:SetMinSyncRevision(3860)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH boss1"
)

local warnSlimePuddle				= mod:NewSpellAnnounce(70341, 2)
local warnUnstableExperimentSoon	= mod:NewSoonAnnounce(70351, 3)
local warnUnstableExperiment		= mod:NewSpellAnnounce(70351, 4)
local warnVolatileOozeAdhesive		= mod:NewTargetAnnounce(70447, 3)
local warnGaseousBloat				= mod:NewTargetAnnounce(70672, 3)
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnTearGas					= mod:NewSpellAnnounce(71617, 2)		-- Phase transition normal
local warnVolatileExperiment		= mod:NewSpellAnnounce(72840, 4)		-- Phase transition heroic
local warnMalleableGoo				= mod:NewSpellAnnounce(72295, 2)		-- Phase 2 ability
local warnChokingGasBombSoon		= mod:NewPreWarnAnnounce(71255, 5, 3, nil, mod:IsMelee())
local warnChokingGasBomb			= mod:NewSpellAnnounce(71255, 3, nil, mod:IsMelee())		-- Phase 2 ability
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)
local warnMutatedPlague				= mod:NewStackAnnounce(72451, 3, nil, mod:IsTank() or mod:IsHealer()) -- Phase 3 ability
local warnUnboundPlague				= mod:NewTargetAnnounce(70911, 3)		-- Heroic Ability

local specWarnVolatileOozeAdhesive	= mod:NewSpecialWarningYou(70447)
local specWarnGaseousBloat			= mod:NewSpecialWarningYou(70672)
local specWarnVolatileOozeOther		= mod:NewSpecialWarningTarget(70447, false)
local specWarnGaseousBloatOther		= mod:NewSpecialWarningTarget(70672, false)
local specWarnMalleableGoo			= mod:NewSpecialWarningYou(72295)
local yellMalleableGoo				= mod:NewYell(72295)
local specWarnMalleableGooNear		= mod:NewSpecialWarningClose(72295)
local specWarnChokingGasBomb		= mod:NewSpecialWarningMove(71255, mod:IsTank())
local specWarnMalleableGooCast		= mod:NewSpecialWarningSpell(72295, nil, nil, nil, 2)
local specWarnOozeVariable			= mod:NewSpecialWarningYou(70352)		-- Heroic Ability
local specWarnGasVariable			= mod:NewSpecialWarningYou(70353)		-- Heroic Ability
local specWarnUnboundPlague			= mod:NewSpecialWarningYou(70911)		-- Heroic Ability
local yellUnboundPlague				= mod:NewYell(70911)

local timerGaseousBloat				= mod:NewTargetTimer(20, 70672)			-- Duration of debuff
local timerSlimePuddleCD			= mod:NewCDTimer(35, 70341)				-- Approx
local timerUnstableExperimentCD		= mod:NewNextTimer(38, 70351)			-- Used every 38 seconds exactly except after phase changes
local timerChokingGasBombCD			= mod:NewNextTimer(35.5, 71255)
local timerMalleableGooCD			= mod:NewCDTimer(25, 72295)
local timerTearGas					= mod:NewBuffActiveTimer(16, 71615)
local timerPotions					= mod:NewBuffActiveTimer(30, 73122)
local timerMutatedPlagueCD			= mod:NewCDTimer(10, 72451)				-- 10 to 11
local timerUnboundPlagueCD			= mod:NewNextTimer(60, 70911)
local timerUnboundPlague			= mod:NewBuffActiveTimer(12, 70911)		-- Heroic Ability: we can't keep the debuff 60 seconds, so we have to switch at 12-15 seconds. Otherwise the debuff does to much damage!

-- buffs from "Drink Me"
local timerMutatedSlash				= mod:NewTargetTimer(20, 70542)
local timerRegurgitatedOoze			= mod:NewTargetTimer(20, 70539)

local berserkTimer					= mod:NewBerserkTimer(600)

local soundGaseousBloat 			= mod:NewSound(70672)


mod:AddBoolOption("OozeAdhesiveIcon")
mod:AddBoolOption("GaseousBloatIcon")
mod:AddBoolOption("MalleableGooIcon")
mod:AddBoolOption("UnboundPlagueIcon")					-- icon on the player with active buff
mod:AddBoolOption("GooArrow")

local warned_preP2 = false
local warned_preP3 = false
local phase = 0
local glime = true
local lastGoo = 0

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerSlimePuddleCD:Start(10-delay)
	timerUnstableExperimentCD:Start(30-delay)
	warnUnstableExperimentSoon:Schedule(25-delay)
	warned_preP2 = false
	warned_preP3 = false
	glime = true
	phase = 1
	lastGoo = 0
	if self:IsDifficulty("heroic10", "heroic25") then
		timerUnboundPlagueCD:Start(10-delay)
	end
end

function mod:MalleableGooTarget(targetname, uId)
	if not targetname then return end
		if self.Options.MalleableGooIcon then
			self:SetIcon(targetname, 6, 10)
		end
	if targetname == UnitName("player") then
		specWarnMalleableGoo:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg")
		yellMalleableGoo:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnMalleableGooNear:Show(targetname)
				sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg")
				if self.Options.GooArrow then
					DBM.Arrow:ShowRunAway(x, y, 10, 5)
				end
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 70351 then
		warnUnstableExperimentSoon:Cancel()
		warnUnstableExperiment:Show()
		timerUnstableExperimentCD:Start()
		warnUnstableExperimentSoon:Schedule(33)
		if glime then
			sndWOP:Schedule(3, DBM.SoundMMPath.."\\gslime.ogg")
			sndWOP:Schedule(7, DBM.SoundMMPath.."\\killslime.ogg")
			glime = false
		else
			sndWOP:Schedule(3, DBM.SoundMMPath.."\\rslime.ogg")
			sndWOP:Schedule(7, DBM.SoundMMPath.."\\killslime.ogg")
			glime = true
		end
	elseif args:IsSpellID(71617) then				--Tear Gas, normal phase change trigger
		warnTearGas:Show()
		warnUnstableExperimentSoon:Cancel()
		warnChokingGasBombSoon:Cancel()
		if mod:IsMelee() then
			sndWOP:Cancel(DBM.SoundMMPath.."\\bombsoon.ogg")
		end
		timerUnstableExperimentCD:Cancel()
		timerMalleableGooCD:Cancel()
		timerSlimePuddleCD:Cancel()
		timerChokingGasBombCD:Cancel()
		timerUnboundPlagueCD:Cancel()
	elseif args.spellId == 72842 then		--Volatile Experiment (heroic phase change begin)
		warnVolatileExperiment:Show()
		warnUnstableExperimentSoon:Cancel()
		warnChokingGasBombSoon:Cancel()
		if mod:IsMelee() then
			sndWOP:Cancel(DBM.SoundMMPath.."\\bombsoon.ogg")
		end
		timerUnstableExperimentCD:Cancel()
		timerMalleableGooCD:Cancel()
		timerSlimePuddleCD:Cancel()
		timerChokingGasBombCD:Cancel()
		timerUnboundPlagueCD:Cancel()
	elseif args.spellId == 72851 then		--Create Concoction (Heroic phase change end)
		if self:IsDifficulty("heroic10", "heroic25") then
			self:ScheduleMethod(40, "NextPhase")	--May need slight tweaking +- a second or two
			timerPotions:Start()
		end
	elseif args.spellId == 73121 then		--Guzzle Potions (Heroic phase change end)
		if self:IsDifficulty("heroic10") then
			self:ScheduleMethod(40, "NextPhase")	--May need slight tweaking +- a second or two
			timerPotions:Start()
		elseif self:IsDifficulty("heroic25") then
			self:ScheduleMethod(30, "NextPhase")
			timerPotions:Start(20)
		end
	end
end

function mod:NextPhase()
	phase = phase + 1
	if phase == 2 then
		warnUnstableExperimentSoon:Schedule(15)
		timerUnstableExperimentCD:Start(20)
		timerSlimePuddleCD:Start(10)
		timerMalleableGooCD:Start(5)
		timerChokingGasBombCD:Start(15)
		warnChokingGasBombSoon:Schedule(10)
		if mod:IsMelee() then
			sndWOP:Schedule(12, DBM.SoundMMPath.."\\bombsoon.ogg")
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerUnboundPlagueCD:Start(50)
		end
	elseif phase == 3 then
		timerSlimePuddleCD:Start(15)
		timerMalleableGooCD:Start(9)
		timerChokingGasBombCD:Start(12)
		warnChokingGasBombSoon:Schedule(7)
		if mod:IsMelee() then
			sndWOP:Schedule(9, DBM.SoundMMPath.."\\bombsoon.ogg")
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerUnboundPlagueCD:Start(50)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 70341 and self:AntiSpam(5, 1) then
		warnSlimePuddle:Show()
		if phase == 3 then
			timerSlimePuddleCD:Start(20)--In phase 3 it's faster
		else
			timerSlimePuddleCD:Start()
		end
	elseif args.spellId == 71255 then
		warnChokingGasBomb:Show()
		specWarnChokingGasBomb:Show()
		timerChokingGasBombCD:Start()
		warnChokingGasBombSoon:Schedule(30.5)
		sndWOP:Play(DBM.SoundMMPath.."\\gasbomb.ogg")
		if mod:IsMelee() then
			sndWOP:Schedule(32, DBM.SoundMMPath.."\\bombsoon.ogg")
		end
	elseif args.spellId == 70911 then
		timerUnboundPlagueCD:Start()
	elseif args.spellId == 72295 then
		warnMalleableGoo:Show()
		specWarnMalleableGooCast:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\greenball.ogg")
		if self:IsDifficulty("heroic10", "heroic25") then
			timerMalleableGooCD:Start(20)
		else
			timerMalleableGooCD:Start()
		end
		self:BossTargetScanner(36678, "MalleableGooTarget", 0.05, 6)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 70447 then--Green Slime
		warnVolatileOozeAdhesive:Show(args.destName)
		specWarnVolatileOozeOther:Show(args.destName)
		if args:IsPlayer() then
			specWarnVolatileOozeAdhesive:Show()
		end
		if self.Options.OozeAdhesiveIcon then
			self:SetIcon(args.destName, 8, 8)
		end
	elseif args.spellId == 70672 then	--Red Slime
		warnGaseousBloat:Show(args.destName)
		specWarnGaseousBloatOther:Show(args.destName)
		timerGaseousBloat:Start(args.destName)
		if args:IsPlayer() then
			specWarnGaseousBloat:Show()
			soundGaseousBloat:Play()
		end
		if self.Options.GaseousBloatIcon then
			self:SetIcon(args.destName, 7, 20)
		end
	elseif args:IsSpellID(71615, 71618) then	--71615 used in 10 and 25 normal, 71618?
		timerTearGas:Start()
	elseif args.spellId == 72451 then	-- Mutated Plague
		warnMutatedPlague:Show(args.spellName, args.destName, args.amount or 1)
		timerMutatedPlagueCD:Start()
	elseif args.spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	elseif args.spellId == 70539 then
		timerRegurgitatedOoze:Show(args.destName)
	elseif args.spellId == 70352 then	--Ooze Variable
		if args:IsPlayer() then
			specWarnOozeVariable:Show()
			sndWOP:Play(DBM.SoundMMPath.."\\gslime.ogg")
		end
	elseif args.spellId == 70353 then	-- Gas Variable
		if args:IsPlayer() then
			specWarnGasVariable:Show()
			sndWOP:Play(DBM.SoundMMPath.."\\rslime.ogg")
		end
	elseif args.spellId == 70911 then	 -- Unbound Plague
		warnUnboundPlague:Show(args.destName)
		if self.Options.UnboundPlagueIcon then
			self:SetIcon(args.destName, 5, 20)
		end
		if args:IsPlayer() then
			specWarnUnboundPlague:Show()
			timerUnboundPlague:Start()
			yellUnboundPlague:Yell()
			sndWOP:Schedule(30, DBM.SoundMMPath.."\\transplague.ogg")
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 72451 then	-- Mutated Plague
		warnMutatedPlague:Show(args.spellName, args.destName, args.amount or 1)
		timerMutatedPlagueCD:Start()
	elseif args.spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REFRESH(args)
	if args.spellId == 70539 then
		timerRegurgitatedOoze:Show(args.destName)
	elseif args.spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 70447 then
		if self.Options.OozeAdhesiveIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 70672 then
		timerGaseousBloat:Cancel(args.destName)
		if self.Options.GaseousBloatIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 70911 then 						-- Unbound Plague
		timerUnboundPlague:Stop(args.destName)
		if self.Options.UnboundPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			sndWOP:Cancel(DBM.SoundMMPath.."\\transplague.ogg")
		end
	elseif args.spellId == 71615 and self:AntiSpam(5, 2) then 	-- Tear Gas Removal
		self:NextPhase()
	elseif args.spellId == 70539 then
		timerRegurgitatedOoze:Cancel(args.destName)
	elseif args.spellId == 70542 then
		timerMutatedSlash:Cancel(args.destName)
	end
end

--values subject to tuning depending on dps and his health pool
function mod:UNIT_HEALTH(uId)
	if phase == 1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.83 then
		warned_preP2 = true
		warnPhase2Soon:Show()	
		sndWOP:Play(DBM.SoundMMPath.."\\ptwo.ogg")
	elseif phase == 2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		warned_preP3 = true
		warnPhase3Soon:Show()	
		sndWOP:Play(DBM.SoundMMPath.."\\pthree.ogg")
	end
end
