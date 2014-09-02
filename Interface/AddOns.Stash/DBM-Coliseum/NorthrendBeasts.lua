local mod	= DBM:NewMod("NorthrendBeasts", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 73 $"):sub(12, -3))
mod:SetCreatureID(34797)
mod:SetModelID(21601)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.CombatStart)

mod:RegisterEvents(
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

local warnImpaleOn			= mod:NewTargetAnnounce(66331, 2, nil, mod:IsTank() or mod:IsHealer())
local warnFireBomb			= mod:NewSpellAnnounce(66317, 3, nil, false)
local warnBreath			= mod:NewSpellAnnounce(66689, 2)
local warnRage				= mod:NewSpellAnnounce(66759, 3)
local warnSlimePool			= mod:NewSpellAnnounce(66883, 2, nil, mod:IsMelee())
local warnToxin				= mod:NewTargetAnnounce(66823, 3)
local warnBile				= mod:NewTargetAnnounce(66869, 3)
local WarningSnobold		= mod:NewAnnounce("WarningSnobold", 4)
local warnEnrageWorm		= mod:NewSpellAnnounce(68335, 3)
local warnCharge			= mod:NewTargetAnnounce(52311, 4)

local specWarnImpale3		= mod:NewSpecialWarning("SpecialWarningImpale3")
local specWarnAnger3		= mod:NewSpecialWarning("SpecialWarningAnger3", mod:IsTank() or mod:IsHealer())
local specWarnFireBomb		= mod:NewSpecialWarningMove(66317)
local specWarnSlimePool		= mod:NewSpecialWarningMove(66883)
local specWarnToxin			= mod:NewSpecialWarningMove(66823)
local specWarnBile			= mod:NewSpecialWarningYou(66869)
local specWarnSilence		= mod:NewSpecialWarning("SpecialWarningSilence")
local specWarnCharge		= mod:NewSpecialWarning("SpecialWarningCharge")
local specWarnChargeNear	= mod:NewSpecialWarning("SpecialWarningChargeNear")
local specWarnTranq			= mod:NewSpecialWarning("SpecialWarningTranq", mod:CanRemoveEnrage())

local enrageTimer			= mod:NewBerserkTimer(223)
local timerCombatStart		= mod:NewTimer(23, "TimerCombatStart", 2457)
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
mod:AddBoolOption("SetIconOnChargeTarget", true)
mod:AddBoolOption("SetIconOnBileTarget", true)
mod:AddBoolOption("ClearIconsOnIceHowl", true)
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("IcehowlArrow")

local bileTargets			= {}
local toxinTargets			= {}
local burnIcon				= 8
local phases				= {}
local DreadscaleActive		= true  	-- Is dreadscale moving?
local DreadscaleDead	= false
local AcidmawDead	= false

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
	specWarnSilence:Schedule(37-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerNextBoss:Start(175 - delay)
		timerNextBoss:Schedule(170)
	end
	timerNextStomp:Start(38-delay)
	timerRisingAnger:Start(48-delay)
	timerCombatStart:Start(-delay)
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
	if args.spellId == 66331 then		-- Impale
		timerNextImpale:Start()
		warnImpaleOn:Show(args.destName)
	elseif args.spellId == 66759 then	-- Frothing Rage
		warnRage:Show()
		specWarnTranq:Show()
	elseif args.spellId == 66823 then	-- Paralytic Toxin
		self:UnscheduleMethod("warnToxin")
		toxinTargets[#toxinTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnToxin:Show()
		end
		self:ScheduleMethod(0.2, "warnToxin")
	elseif args.spellId == 66869 then		-- Burning Bile
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
	elseif args.spellId == 66636 then						-- Rising Anger
		WarningSnobold:Show()
		timerRisingAnger:Show()
	elseif args.spellId == 68335 then
		warnEnrageWorm:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 66331 then		-- Impale
		timerNextImpale:Start()
		warnImpaleOn:Show(args.destName)
		if (args.amount >= 3 and not self:IsDifficulty("heroic10", "heroic25") ) or ( args.amount >= 2 and self:IsDifficulty("heroic10", "heroic25") ) then 
			if args:IsPlayer() then
				specWarnImpale3:Show(args.amount)
			end
		end
	elseif args.spellId == 66636 then						-- Rising Anger
		WarningSnobold:Show()
		if args.amount <= 3 then
			timerRisingAnger:Show()
		elseif args.amount >= 3 then
			specWarnAnger3:Show(args.amount)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 66689 then			-- Arctic Breath
		timerBreath:Start()
		warnBreath:Show()
	elseif args.spellId == 66313 then							-- FireBomb (Impaler)
		warnFireBomb:Show()
	elseif args.spellId == 66330 then		-- Staggering Stomp
		timerNextStomp:Start()
		specWarnSilence:Schedule(19)							-- prewarn ~1,5 sec before next
	elseif args.spellId == 66794 then		-- Sweep stationary worm
		timerSweepCD:Start()
	elseif args.spellId == 66821 then							-- Molten spew
		timerMoltenSpewCD:Start()
	elseif args.spellId == 66818 then							-- Acidic Spew
		timerAcidicSpewCD:Start()
	elseif args.spellId == 66901 then		-- Paralytic Spray
		timerParalyticSprayCD:Start()
	elseif args.spellId == 66902 then		-- Burning Spray
		timerBurningSprayCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 66883 then			-- Slime Pool Cloud Spawn
		warnSlimePool:Show()
		timerSlimePoolCD:Show()
	elseif args.spellId == 66824 then		-- Paralytic Bite
		timerParalyticBiteCD:Start()
	elseif args.spellId == 66879 then		-- Burning Bite
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
		local target = DBM:GetFullNameByShortName(target)
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
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				if inRange then
					specWarnChargeNear:Show()
					if self.Options.IcehowlArrow then
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
	if msg == L.Phase2 or msg:find(L.Phase2) then
		self:ScheduleMethod(17, "WormsEmerge")
		timerCombatStart:Show(15)
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
			DBM.BossHealth:RemoveBoss(cid) -- remove Gormok from the health frame
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
	end
end
