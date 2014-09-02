local mod	= DBM:NewMod("Jaraxxus", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 73 $"):sub(12, -3))
mod:SetCreatureID(34780)
mod:SetModelID(29615)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_HEAL",
	"SPELL_PERIODIC_HEAL",
	"CHAT_MSG_MONSTER_YELL"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
	    		 or select(2, UnitClass("player")) == "PRIEST"
	    		 or select(2, UnitClass("player")) == "SHAMAN"

local isMagicDispeller = select(2, UnitClass("player")) == "PALADIN"
	    		 or select(2, UnitClass("player")) == "PRIEST"

local warnFelFireball			= mod:NewCastAnnounce(66532, 2)
local warnPortalSoon			= mod:NewSoonAnnounce(66269, 3)
local warnVolcanoSoon			= mod:NewSoonAnnounce(66258, 3)
local warnFlame					= mod:NewTargetAnnounce(66197, 4)
local warnFlesh					= mod:NewTargetAnnounce(66237, 4, nil, mod:IsHealer())
local warnNetherPower			= mod:NewAnnounce("WarnNetherPower", 4, 67009)

local specWarnFlame				= mod:NewSpecialWarningRun(66877)
local specWarnFlesh				= mod:NewSpecialWarningYou(66237)
local specWarnKiss				= mod:NewSpecialWarningYou(66334, false)
local specWarnNetherPower		= mod:NewSpecialWarning("SpecWarnNetherPower", isDispeller)
local specWarnFelInferno		= mod:NewSpecialWarningMove(66496)
local SpecWarnFelFireball		= mod:NewSpecialWarning("SpecWarnFelFireball", false)
local SpecWarnFelFireballDispel	= mod:NewSpecialWarningDispel(66532, isMagicDispeller)

local timerCombatStart			= mod:NewTimer(84, "TimerCombatStart", 2457)--rollplay for first pull
local enrageTimer				= mod:NewBerserkTimer(600)
local timerFlame 				= mod:NewTargetTimer(8, 66197)--There are 8 debuff Ids. Since we detect first to warn, use an 8sec timer to cover duration of trigger spell and damage debuff.
local timerFlameCD				= mod:NewCDTimer(30, 66197)
local timerNetherPowerCD		= mod:NewCDTimer(42, 67009)
local timerFlesh				= mod:NewTargetTimer(12, 66237)
local timerFleshCD				= mod:NewCDTimer(23, 66237) 
local timerPortalCD				= mod:NewCDTimer(120, 66269)
local timerVolcanoCD			= mod:NewCDTimer(120, 66258)

local soundLegionFlame			= mod:NewSound(66197)

mod:AddBoolOption("LegionFlameWhisper", false, "announce")
mod:AddBoolOption("LegionFlameIcon", true)
mod:AddBoolOption("IncinerateFleshIcon", true)

mod:AddBoolOption("IncinerateShieldFrame", true, "misc")

function mod:OnCombatStart(delay)
	if self.Options.IncinerateShieldFrame and DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(34780, L.name)
	end
	timerPortalCD:Start(20-delay)
	warnPortalSoon:Schedule(15-delay)
	timerVolcanoCD:Start(80-delay)
	warnVolcanoSoon:Schedule(75-delay)
	timerFleshCD:Start(14-delay)
	timerFlameCD:Start(20-delay)
	enrageTimer:Start(-delay)
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 66877 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then		-- Legion Flame
		specWarnFlame:Show()
	elseif spellId == 66496 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then	-- Fel Inferno
		specWarnFelInferno:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

local setIncinerateTarget, clearIncinerateTarget
do
	local incinerateTarget
	local healed = 0
	local maxAbsorb = 0
	local function getShieldHP()
		return math.max(1, math.floor(healed / maxAbsorb * 100))
	end
	
	function mod:SPELL_HEAL(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overheal, absorbed)
		if destGUID == incinerateTarget then
			healed = healed + (absorbed or 0)
		end
	end	
	mod.SPELL_PERIODIC_HEAL = mod.SPELL_HEAL
	
	function setIncinerateTarget(mod, target, name)
		incinerateTarget = target
		healed = 0
		maxAbsorb = mod:IsDifficulty("heroic25") and 85000 or
					mod:IsDifficulty("heroic10") and 40000 or
					mod:IsDifficulty("normal25") and 60000 or
					mod:IsDifficulty("normal10") and 30000 or 0
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, L.IncinerateTarget:format(name))
	end
	
	function clearIncinerateTarget(self, name)
		DBM.BossHealth:RemoveBoss(getShieldHP)
		if self.Options.IncinerateFleshIcon then
			self:RemoveIcon(name)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 66237 then			-- Incinerate Flesh
		warnFlesh:Show(args.destName)
		timerFlesh:Start(args.destName)
		timerFleshCD:Start()
		if self.Options.IncinerateFleshIcon then
			self:SetIcon(args.destName, 8, 15)
		end
		if args:IsPlayer() then
			specWarnFlesh:Show()
		end
		if DBM.BossHealth:IsShown() and self.Options.IncinerateShieldFrame then
			setIncinerateTarget(self, args.destGUID, args.destName)
			self:Schedule(15, clearIncinerateTarget, self, args.destName)
		end
	elseif args.spellId == 66197 then		-- Legion Flame ids 66199 (second debuff) do the actual damage. First 2 seconds are trigger debuff only.
		local targetname = args.destName
		timerFlame:Start(args.destName)
		timerFlameCD:Start()		
		if args:IsPlayer() then
			specWarnFlame:Show()
			soundLegionFlame:Play()
		end		
		if self.Options.LegionFlameIcon then
			self:SetIcon(args.destName, 7, 8)
		end
		if DBM:GetRaidRank() > 0 and self.Options.LegionFlameWhisper then
			self:SendWhisper(L.WhisperFlame, targetname)
		end
	elseif args.spellId == 66334 and args:IsPlayer() then
		specWarnKiss:Show()

	elseif args.spellId == 66532 then		-- Fel Fireball (announce if tank gets debuff for dispel)
		warnFelFireball:Show()
		SpecWarnFelFireballDispel:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 66237 then			-- Incinerate Flesh
		timerFlesh:Stop()
		self:Unschedule(clearIncinerateTarget)
		if DBM.BossHealth:IsShown() and self.Options.IncinerateShieldFrame then
			clearIncinerateTarget(self, args.destName)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 66532 and self:GetUnitCreatureId("target") == 34780 then	-- Fel Fireball (track cast for interrupt, only when targeted)
		SpecWarnFelFireball:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 67009 then								-- Nether Power
		warnNetherPower:Show()
		timerNetherPowerCD:Start()
		specWarnNetherPower:Show()

	elseif args.spellId == 66258 then		-- Infernal Volcano
		timerVolcanoCD:Start()
		warnVolcanoSoon:Schedule(110)

	elseif args.spellId == 66269 then		-- Nether Portal
		timerPortalCD:Start()
		warnPortalSoon:Schedule(110)
	
	elseif args.spellId == 66197 then		-- Legion Flame
		warnFlame:Show(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.FirstPull or msg:find(L.FirstPull) then
		timerCombatStart:Start()
	end
end
