local mod	= DBM:NewMod("Sapphiron", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(15989)
mod:SetEncounterID(1119)
mod:SetModelID(16033)
mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"RAID_BOSS_EMOTE",
	"SPELL_CAST_SUCCESS"
)

local warnDrainLifeNow	= mod:NewSpellAnnounce(28542, 2)
local warnDrainLifeSoon	= mod:NewSoonAnnounce(28542, 1)
local warnAirPhaseSoon	= mod:NewAnnounce("WarningAirPhaseSoon", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnAirPhaseNow	= mod:NewAnnounce("WarningAirPhaseNow", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnLanded		= mod:NewAnnounce("WarningLanded", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

local warnDeepBreath	= mod:NewSpecialWarning("WarningDeepBreath")

mod:AddBoolOption("WarningIceblock", true, "announce")

local timerDrainLife	= mod:NewCDTimer(22, 28542)
local timerAirPhase		= mod:NewTimer(66, "TimerAir", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerLanding		= mod:NewTimer(28.5, "TimerLanding", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerIceBlast		= mod:NewTimer(9.3, "TimerIceBlast", 15876)

local berserkTimer		= mod:NewBerserkTimer(900)

local noTargetTime = 0
local isFlying = false

function mod:OnCombatStart(delay)
	noTargetTime = 0
	isFlying = false
	warnAirPhaseSoon:Schedule(38.5 - delay)
	timerAirPhase:Start(48.5 - delay)
	berserkTimer:Start(-delay)
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28522 and args:IsPlayer() and self.Options.WarningIceblock then
		SendChatMessage(L.WarningYellIceblock, "YELL")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(28542, 55665) then -- Life Drain
		warnDrainLifeNow:Show()
		warnDrainLifeSoon:Schedule(18.5)
		timerDrainLife:Start()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteBreath or msg:find(L.EmoteBreath) then
		self:SendSync("DeepBreath")
	end
end

function mod:OnSync(event)
	if event == "DeepBreath" then
		timerIceBlast:Show()
		timerLanding:Update(14)
		self:ScheduleMethod(14.5, "Landing")
		warnDeepBreath:Show()
	end
end

function mod:Landing()
	warnAirPhaseSoon:Schedule(56)
	warnLanded:Show()
	timerAirPhase:Start()
end

local function resetIsFlying()
	isFlying = false
end

mod:RegisterOnUpdateHandler(function(self, elapsed)
	if not self:IsInCombat() then return end
		local foundBoss, target
		for uId in DBM:GetGroupMembers() do
			local unitID = uId.."target"
			if self:GetUnitCreatureId(unitID) == 15989 and UnitAffectingCombat(unitID) then
				target = DBM:GetUnitFullName(unitID.."target")
				foundBoss = true
				break
			end
		end
		if foundBoss and not target then
			noTargetTime = noTargetTime + elapsed
		elseif foundBoss then
			noTargetTime = 0
		end
		if noTargetTime > 0.5 and not isFlying then
			noTargetTime = 0
			isFlying = true
			self:Schedule(60, resetIsFlying)
			timerDrainLife:Cancel()
			timerAirPhase:Cancel()
			warnAirPhaseNow:Show()
			timerLanding:Start()
		end
end, 0.2)
