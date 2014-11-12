local mod	= DBM:NewMod(1162, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()
local Yike	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11640 $"):sub(12, -3))
mod:SetCreatureID(77692)
mod:SetEncounterID(1713)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 157060 157054 156704 157592 158217",
	"SPELL_CAST_SUCCESS 158130 170469",
	"SPELL_AURA_APPLIED 156766 161923 173917",
	"SPELL_AURA_APPLIED_DOSE 156766"
)

--TODO, see if normal/heroic is still have 111sec timer on grasping Earth since mythic was about 123
--TODO, see how second trembling earth CD works and if current code even works for other timers. Mythic pulls were very short :\
local warnGraspingEarth				= mod:NewSpellAnnounce(157060, 3)
local warnThunderingBlows			= mod:NewSpellAnnounce(157054, 4)
local warnRipplingSmash				= mod:NewSpellAnnounce(157592, 3)
local warnCrushingEarth				= mod:NewTargetAnnounce(161923, 3, nil, false)--Players who failed to move. Off by default since announcing failures is not something DBM generally does by default. Can't announce pre cast unfortunately. No detection
local warnStoneGeyser				= mod:NewSpellAnnounce(158130, 2)
local warnSlam						= mod:NewCastAnnounce(156704, 4, nil, nil, mod:IsMelee())
local warnWarpedArmor				= mod:NewStackAnnounce(156766, 2, nil, mod:IsTank())
local warnTremblingEarth			= mod:NewSpellAnnounce(173917, 3)--Mythic
local warnCalloftheMountain			= mod:NewCastAnnounce(158217, 4, 5)--Mythic

local specWarnGraspingEarth			= mod:NewSpecialWarningSpell(157060)
local specWarnThunderingBlows		= mod:NewSpecialWarningSpell(157054, nil, nil, nil, 3)
local specWarnRipplingSmash			= mod:NewSpecialWarningSpell(157592, nil, nil, nil, 2)
local specWarnSlam					= mod:NewSpecialWarningSpell(156704, mod:IsTank())
local specWarnWarpedArmor			= mod:NewSpecialWarningStack(156766, nil, 3)--stack bugged right now, requires tanks going to 5 stacks before they can clear. Blizz will likely fix this because 5 too much
local specWarnWarpedArmorOther		= mod:NewSpecialWarningTaunt(156766)
local specWarnTremblingEarth		= mod:NewSpecialWarningSpell(173917, nil, nil, nil, 2)
local specWarnCalloftheMountain		= mod:NewSpecialWarningCount(158217, nil, nil, nil, 3)

local timerGraspingEarthCD			= mod:NewCDTimer(111, 157060)
local timerThunderingBlowsCD		= mod:NewNextTimer(12, 157054)
local timerRipplingSmashCD			= mod:NewCDTimer(22, 157592)--If it comes off CD early enough into ThunderingBlows/Grasping Earth, he skips a cast. Else, he'll cast it very soon after.
--local timerStoneGeyserCD			= mod:NewNextTimer(30, 158130)
local timerSlamCD					= mod:NewCDTimer(28, 156704, nil, mod:IsTank())
local timerWarpedArmorCD			= mod:NewCDTimer(14, 156766, nil, mod:IsTank())
local timerTremblingEarthCD			= mod:NewNextTimer(30, 173917)
local timerTremblingEarth			= mod:NewBuffActiveTimer(25, 173917)
local timerCalloftheMountain		= mod:NewCastTimer(5, 158217)

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownThunderingBlows		= mod:NewCountdown(60, 157054)
local countdownTremblingEarth		= mod:NewCountdownFades("Alt25", 173917)

mod.vb.mountainCast = 0

function mod:OnCombatStart(delay)
	self.vb.mountainCast = 0
	timerWarpedArmorCD:Start(15-delay)
	timerRipplingSmashCD:Start(20-delay)
	timerSlamCD:Start(25-delay)--More data needed
	timerGraspingEarthCD:Start(53-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 157060 then
		warnGraspingEarth:Show()
		specWarnGraspingEarth:Show()
		timerThunderingBlowsCD:Start()
		countdownThunderingBlows:Start()
		timerSlamCD:Cancel()--Can't cast slam during this
		timerRipplingSmashCD:Cancel()--Or rippling
		timerWarpedArmorCD:Cancel()
		if self:IsMythic() then
			timerTremblingEarthCD:Start()
			timerGraspingEarthCD:Start(123)--TODO, see if normal is still 111 after last
		else
			timerGraspingEarthCD:Start()
		end
	elseif spellId == 157054 then
		warnThunderingBlows:Show()
		specWarnThunderingBlows:Show()
		--Starting timers for slam and rippling seem useless, 10-30 sec variation for first ones.
		--after that they get back into their consistency
	elseif spellId == 157592 then
		warnRipplingSmash:Show()
		specWarnRipplingSmash:Show()
		timerRipplingSmashCD:Start()
	elseif spellId == 156704 then
		warnSlam:Show()
		specWarnSlam:Show()
		timerSlamCD:Start()
	elseif spellId == 158217 then--Probably not in combat log, it's scripted. Probably needs a UNIT_SPELLCAST event
		self.vb.mountainCast = self.vb.mountainCast + 1
		warnCalloftheMountain:Show()
		specWarnCalloftheMountain:Show(self.vb.mountainCast)
		timerCalloftheMountain:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158130 or spellId == 170469 then--Are both used? eliminate one that isn't if not
		warnStoneGeyser:Show()
		--Does it need a special warning?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156766 then
		local amount = args.amount or 1
		warnWarpedArmor:Show(args.destName, amount)
		timerWarpedArmorCD:Start()
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnWarpedArmor:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(156766)) and not UnitIsDeadOrGhost("player") then
					specWarnWarpedArmorOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 161923 then
		warnCrushingEarth:CombinedShow(0.5, args.destName)
	elseif spellId == 173917 then
		warnTremblingEarth:Show()
		specWarnTremblingEarth:Show()
		timerTremblingEarth:Start()
		countdownTremblingEarth:Start()
		timerSlamCD:Cancel()--Can't cast slam during this
		timerRipplingSmashCD:Cancel()--Or rippling
		timerWarpedArmorCD:Cancel()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
