local mod	= DBM:NewMod("NorthrendBeasts", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 163 $"):sub(12, -3))
mod:SetCreatureID(34796, 35144, 34799, 34797)
--mod:SetEncounterID(1088)
mod:SetMinSyncRevision(104)
mod:SetModelID(21601)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnImpaleOn			= mod:NewStackAnnounce(66331, 2, nil, mod:IsTank() or mod:IsHealer())
local warnFireBomb			= mod:NewSpellAnnounce(66317, 3, nil, false)
local warnBreath			= mod:NewSpellAnnounce(66689, 2)
local warnRage				= mod:NewSpellAnnounce(66759, 3)
local warnSlimePool			= mod:NewSpellAnnounce(66883, 2, nil, mod:IsMelee())
local warnToxin				= mod:NewTargetAnnounce(66823, 3)
local warnBile				= mod:NewTargetAnnounce(66869, 3)
local WarningSnobold		= mod:NewAnnounce("WarningSnobold", 4)
local warnEnrageWorm		= mod:NewSpellAnnounce(68335, 3)
local warnCharge			= mod:NewTargetAnnounce(52311, 4)

local specWarnImpale3		= mod:NewSpecialWarningStack(66331, nil, 3)
local specWarnAnger3		= mod:NewSpecialWarningStack(66636, mod:IsTank() or mod:IsHealer(), 3)
local specWarnFireBomb		= mod:NewSpecialWarningMove(66317)
local specWarnSlimePool		= mod:NewSpecialWarningMove(66883)
local specWarnToxin			= mod:NewSpecialWarningYou(66823)
local specWarnBile			= mod:NewSpecialWarningYou(66869)
local specWarnSilence		= mod:NewSpecialWarningCast(66330)
local specWarnCharge		= mod:NewSpecialWarningRun(52311)
local specWarnChargeNear	= mod:NewSpecialWarningClose(52311)
local specWarnTranq			= mod:NewSpecialWarningDispel(66759, mod:CanRemoveEnrage())

local enrageTimer			= mod:NewBerserkTimer(223)
local timerCombatStart		= mod:NewCombatTimer(21.5)
local timerNextBoss			= mod:NewTimer(190, "TimerNextBoss", 2457)
local timerSubmerge			= mod:NewTimer(45, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp") 
local timerEmerge			= mod:NewTimer(10, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local timerBreath			= mod:NewCastTimer(5, 66689)
local timerNextStomp		= mod:NewNextTimer(20, 66330)
local timerNextImpale		= mod:NewNextTimer(10, 66331, nil, mod:IsTank() or mod:IsHealer())
local timerRisingAnger      = mod:NewNextTimer(20.5, 66636)
local timerStaggeredDaze	= mod:NewBuffActiveTimer(15, 66758)
local timerNextCrash		= mod:NewCDTimer(55, 66683)
local timerSweepCD			= mod:NewCDTimer(17, 66794, nil, mod:IsMelee())
local timerSlimePoolCD		= mod:NewCDTimer(12, 66883, nil, mod:IsMelee())
local timerAcidicSpewCD		= mod:NewCDTimer(21, 66819)
local timerMoltenSpewCD		= mod:NewCDTimer(21, 66820)
local timerParalyticSprayCD	= mod:NewCDTimer(21, 66901)
local timerBurningSprayCD	= mod:NewCDTimer(21, 66902)
local timerParalyticBiteCD	= mod:NewCDTimer(25, 66824, nil, mod:IsTank())
local timerBurningBiteCD	= mod:NewCDTimer(15, 66879, nil, mod:IsTank())

mod:AddBoolOption("PingCharge")
mod:AddSetIconOption("SetIconOnChargeTarget", 52311)
mod:AddSetIconOption("SetIconOnBileTarget", 66869, false)
mod:AddBoolOption("ClearIconsOnIceHowl", false)
mod:AddRangeFrameOption("10")

mod:AddBoolOption("IcehowlArrow")

local bileTargets = {}
local toxinTargets = {}
local burnIcon = 8
local phases = {}
local DreadscaleActive = true
local DreadscaleDead = false
local AcidmawDead = false

local function updateHealthFrame(phase)
	if phases[phase] then
		return
	end
	phases[phase] = true
	if DBM.BossHealth:IsShown() then
		if phase == 1 then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(34796, L.Gormok)
		elseif phase == 2 then
			DBM.BossHealth:AddBoss(35144, L.Acidmaw)
			DBM.BossHealth:AddBoss(34799, L.Dreadscale)
		elseif phase == 3 then
			DBM.BossHealth:AddBoss(34797, L.Icehowl)
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(bileTargets)
	table.wipe(toxinTargets)
	table.wipe(phases)
	burnIcon = 8
	DreadscaleActive = true
	DreadscaleDead = false
	AcidmawDead = false
	specWarnSilence:Schedule(14-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerNextBoss:Start(152 - delay)
		timerNextBoss:Schedule(147)
	end
	timerNextStomp:Start(15-delay)
	timerRisingAnger:Start(25-delay)
	updateHealthFrame(1)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:warnToxin()
	warnToxin:Show(table.concat(toxinTargets, "<, >"))
	table.wipe(toxinTargets)
end

function mod:warnBile()
	warnBile:Show(table.concat(bileTargets, "<, >"))
	table.wipe(bileTargets)
	burnIcon = 8
end

function mod:WormsEmerge()
	timerSubmerge:Show()
	if not AcidmawDead then
		if DreadscaleActive then
			timerSweepCD:Start(16)
			timerParalyticSprayCD:Start(9)
		else
			timerSlimePoolCD:Start(14)
			timerParalyticBiteCD:Start(5)
			timerAcidicSpewCD:Start(10)
		end
	end
	if not DreadscaleDead then
		if DreadscaleActive then
			timerSlimePoolCD:Start(14)
			timerMoltenSpewCD:Start(10)
			timerBurningBiteCD:Start(5)
		else
			timerSweepCD:Start(16)
			timerBurningSprayCD:Start(17)
		end
	end	
	self:ScheduleMethod(45, "WormsSubmerge")
end

function mod:WormsSubmerge()
	timerEmerge:Show()
	timerSweepCD:Cancel()
	timerSlimePoolCD:Cancel()
	timerMoltenSpewCD:Cancel()
	timerParalyticSprayCD:Cancel()
	timerBurningBiteCD:Cancel()
	timerAcidicSpewCD:Cancel()
	timerBurningSprayCD:Cancel()
	timerParalyticBiteCD:Cancel()
	DreadscaleActive = not DreadscaleActive
	self:ScheduleMethod(10, "WormsEmerge")
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 66331 then
		timerNextImpale:Start()
		warnImpaleOn:Show(args.destName, 1)
	elseif args.spellId == 66759 then
		warnRage:Show()
		specWarnTranq:Show()
	elseif args.spellId == 66823 then
		self:UnscheduleMethod("warnToxin")
		toxinTargets[#toxinTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnToxin:Show()
		end
		self:ScheduleMethod(0.2, "warnToxin")
	elseif args.spellId == 66869 then
		self:UnscheduleMethod("warnBile")
		bileTargets[#bileTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnBile:Show()
		end
		if self.Options.SetIconOnBileTarget and burnIcon > 0 then
			self:SetIcon(args.destName, burnIcon, 15)
			burnIcon = burnIcon - 1
		end
		self:ScheduleMethod(0.2, "warnBile")
	elseif args.spellId == 66758 then
		timerStaggeredDaze:Start()
	elseif args.spellId == 66636 then
		WarningSnobold:Show(args.destName)
		timerRisingAnger:Show()
	elseif args.spellId == 68335 then
		warnEnrageWorm:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 66331 then
		local amount = args.amount or 1
		timerNextImpale:Start()
		warnImpaleOn:Show(args.destName, amount)
		if (amount >= 3) or (amount >= 2 and self:IsDifficulty("heroic10", "heroic25")) then 
			if args:IsPlayer() then
				specWarnImpale3:Show(amount)
			end
		end
	elseif args.spellId == 66636 then
		local amount = args.amount or 1
		WarningSnobold:Show()
		if amount <= 3 then
			timerRisingAnger:Show()
		elseif amount >= 3 then
			specWarnAnger3:Show(amount)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 66689 then
		timerBreath:Start()
		warnBreath:Show()
	elseif args.spellId == 66313 then
		warnFireBomb:Show()
	elseif args.spellId == 66330 then
		timerNextStomp:Start()
		specWarnSilence:Schedule(19)
	elseif args.spellId == 66794 then
		timerSweepCD:Start()
	elseif args.spellId == 66821 then
		timerMoltenSpewCD:Start()
	elseif args.spellId == 66818 then
		timerAcidicSpewCD:Start()
	elseif args.spellId == 66901 then
		timerParalyticSprayCD:Start()
	elseif args.spellId == 66902 then
		timerBurningSprayCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 66883 then
		warnSlimePool:Show()
		timerSlimePoolCD:Show()
	elseif args.spellId == 66824 then
		timerParalyticBiteCD:Start()
	elseif args.spellId == 66879 then
		timerBurningBiteCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 66317 or spellId == 66320) and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then	-- Fire Bomb (66317 is impact damage, not avoidable but leaving in because it still means earliest possible warning to move. Other 4 are tick damage from standing in it)
		specWarnFireBomb:Show()
	elseif (spellId == 66881) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then							-- Slime Pool
		specWarnSlimePool:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.Charge) or msg:find(L.Charge) then
		local target = DBM:GetUnitFullName(target)
		warnCharge:Show(target)
		timerNextCrash:Start()
		if self.Options.ClearIconsOnIceHowl then
			self:ClearIcons()
		end
		if target == UnitName("player") then
			specWarnCharge:Show()
			if self.Options.PingCharge then
				Minimap:PingLocation()
			end
		else
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnChargeNear:Show()
					if self.Options.IcehowlArrow then
						local x, y = UnitPosition(uId)
						DBM.Arrow:ShowRunAway(x, y, 12, 5)
					end
				end
			end
		end
		if self.Options.SetIconOnChargeTarget then
			self:SetIcon(target, 8, 5)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.CombatStart or msg:find(L.CombatStart) then
		timerCombatStart:Start()
	elseif msg == L.Phase2 or msg:find(L.Phase2) then
		self:ScheduleMethod(17, "WormsEmerge")
		timerCombatStart:Start(15)
		updateHealthFrame(2)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		updateHealthFrame(3)
		if self:IsDifficulty("heroic10", "heroic25") then
			enrageTimer:Start()
		end
		self:UnscheduleMethod("WormsSubmerge")
		timerNextCrash:Start(45)
		timerNextBoss:Cancel()
		timerSubmerge:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34796 then
		specWarnSilence:Cancel()
		timerNextStomp:Stop()
		timerNextImpale:Stop()
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:RemoveBoss(cid)
		end
	elseif cid == 35144 then
		AcidmawDead = true
		timerParalyticSprayCD:Cancel()
		timerParalyticBiteCD:Cancel()
		timerAcidicSpewCD:Cancel()
		if DreadscaleActive then
			timerSweepCD:Cancel()
		else
			timerSlimePoolCD:Cancel()
		end
		if DreadscaleDead then
			timerNextBoss:Cancel()
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:RemoveBoss(35144)
				DBM.BossHealth:RemoveBoss(34799)
			end
		end
	elseif cid == 34799 then
		DreadscaleDead = true
		timerBurningSprayCD:Cancel()
		timerBurningBiteCD:Cancel()
		timerMoltenSpewCD:Cancel()
		if DreadscaleActive then
			timerSlimePoolCD:Cancel()
		else
			timerSweepCD:Cancel()
		end
		if AcidmawDead then
			timerNextBoss:Cancel()
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:RemoveBoss(35144)
				DBM.BossHealth:RemoveBoss(34799)
			end
		end
	elseif cid == 34797 then
		DBM:EndCombat(self)
	end
end
