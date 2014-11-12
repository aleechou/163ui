local mod	= DBM:NewMod("Rotface", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 58 $"):sub(12, -3))
mod:SetCreatureID(36627)
mod:SetModelID(31005)
mod:SetUsedIcons(7, 8)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSlimeSpray			= mod:NewSpellAnnounce(69508, 2)
local warnMutatedInfection		= mod:NewTargetAnnounce(69674, 4)
local warnRadiatingOoze			= mod:NewSpellAnnounce(69760, 3)
local warnOozeSpawn				= mod:NewAnnounce("WarnOozeSpawn", 1)
local warnStickyOoze			= mod:NewSpellAnnounce(69774, 1)
local warnUnstableOoze			= mod:NewStackAnnounce(69558, 2)
local warnVileGas				= mod:NewTargetAnnounce(72272, 3)

local specWarnMutatedInfection	= mod:NewSpecialWarningYou(69674)
local specWarnStickyOoze		= mod:NewSpecialWarningMove(69774)
local specWarnOozeExplosion		= mod:NewSpecialWarningRun(69839)
local specWarnSlimeSpray		= mod:NewSpecialWarningSpell(69508, false)--For people that need a bigger warning to move
local specWarnRadiatingOoze		= mod:NewSpecialWarningSpell(69760, not mod:IsTank())
local specWarnLittleOoze		= mod:NewSpecialWarning("SpecWarnLittleOoze", false)
local specWarnVileGas			= mod:NewSpecialWarningYou(72272)

local timerStickyOoze			= mod:NewNextTimer(16, 69774, nil, mod:IsTank())
local timerWallSlime			= mod:NewNextTimer(20, 69789)
local timerSlimeSpray			= mod:NewNextTimer(21, 69508)
local timerMutatedInfection		= mod:NewTargetTimer(12, 69674)
local timerOozeExplosion		= mod:NewCastTimer(4, 69839)
local timerVileGasCD			= mod:NewNextTimer(30, 72272)



mod:AddBoolOption("RangeFrame", mod:IsRanged())
mod:AddBoolOption("InfectionIcon", true)
mod:AddBoolOption("TankArrow", true)

local RFVileGasTargets	= {}
local spamOoze = 0
local InfectionIcon = 8

local function warnRFVileGasTargets()
	warnVileGas:Show(table.concat(RFVileGasTargets, "<, >"))
	table.wipe(RFVileGasTargets)
	timerVileGasCD:Start()
end

function mod:OnCombatStart(delay)
	timerWallSlime:Start(25-delay)
	self:ScheduleMethod(25-delay, "WallSlime")
	InfectionIcon = 8
	spamOoze = 0
	if self:IsDifficulty("heroic10", "heroic25") then
		timerVileGasCD:Start(22-delay)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.TankArrow then
		DBM.Arrow:Hide()
	end
end

function mod:WallSlime()
	if self:IsInCombat() then
		timerWallSlime:Start()
		self:UnscheduleMethod("WallSlime")
		self:ScheduleMethod(20, "WallSlime")
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 69508 then
		timerSlimeSpray:Start()
		warnSlimeSpray:Show()
		specWarnSlimeSpray:Show()
		sndWOP:Play("gasrain")
	elseif args.spellId == 69774 then
		timerStickyOoze:Start()
		warnStickyOoze:Show()
	elseif args.spellId == 69839 then --Unstable Ooze Explosion (Big Ooze)
		if GetTime() - spamOoze < 4 then --This will prevent spam but breaks if there are 2 oozes. GUID work is required
			specWarnOozeExplosion:Cancel()
			sndWOP:Cancel("countthree")
			sndWOP:Cancel("counttwo")
			sndWOP:Cancel("countone")
		end
		if GetTime() - spamOoze < 4 or GetTime() - spamOoze > 5 then --Attempt to ignore a cast that may fire as an ooze is already exploding.
			timerOozeExplosion:Start()
			specWarnOozeExplosion:Schedule(4)
			sndWOP:Play("boom")
			sndWOP:Schedule(1.5, "countthree")
			sndWOP:Schedule(2.5, "counttwo")
			sndWOP:Schedule(3.5, "countone")
		end
		spamOoze = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args.spellId == 71208 then
		specWarnStickyOoze:Show()
	elseif args.spellId == 69760 then
		warnRadiatingOoze:Show()
	elseif args.spellId == 69558 then
		warnUnstableOoze:Show(args.destName, args.amount or 1)
	elseif args.spellId == 69674 then
		warnMutatedInfection:Show(args.destName)
		timerMutatedInfection:Start(args.destName)
		if args:IsPlayer() then
			specWarnMutatedInfection:Show()
			sndWOP:Play("infect")
		end
		if self.Options.InfectionIcon then
			self:SetIcon(args.destName, InfectionIcon, 12)
			if InfectionIcon == 8 then	-- After ~3mins there is a chance 2 ppl will have the debuff, so we are alternating between 2 icons
				InfectionIcon = 7
			else
				InfectionIcon = 8
			end
		end
	elseif args.spellId == 72272 and args:IsDestTypePlayer() then	-- Vile Gas(Heroic Rotface only, 25 man spellid the same as 10?)
		RFVileGasTargets[#RFVileGasTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnVileGas:Show()
		end
		self:Unschedule(warnRFVileGasTargets)
		self:Schedule(2.5, warnRFVileGasTargets) -- Yes it does take this long to travel to all 3 targets sometimes, qq.
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 72272 then
		timerVileGasCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69674 then
		timerMutatedInfection:Cancel(args.destName)
		warnOozeSpawn:Show()
		if self.Options.InfectionIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, _, destGUID, _, _, _, spellId)
	if spellId == 69761 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnRadiatingOoze:Show()
		sndWOP:Play("runaway")
	elseif spellId ~= 50288 and self:GetCIDFromGUID(destGUID) == 36899 and bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and self:IsInCombat() then--Any spell damage except for starfall
		if sourceGUID ~= UnitGUID("player") then
			if self.Options.TankArrow then
				DBM.Arrow:ShowRunTo(sourceName, 0, 0)
			end
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(sourceGUID, sourceName, sourceFlags, _, destGUID)
	if self:GetCIDFromGUID(sourceGUID) == 36897 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then --Little ooze hitting you
		specWarnLittleOoze:Show()
	elseif self:GetCIDFromGUID(destGUID) == 36899 and bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and self:IsInCombat() then
		if sourceGUID ~= UnitGUID("player") then
			if self.Options.TankArrow then
				DBM.Arrow:ShowRunTo(sourceName, 0, 0)
			end
		end
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellSlimePipes1 or msg:find(L.YellSlimePipes1)) or (msg == L.YellSlimePipes2 or msg:find(L.YellSlimePipes2)) then
		self:WallSlime()
	end
end
