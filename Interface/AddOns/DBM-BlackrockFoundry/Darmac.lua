local mod	= DBM:NewMod(1122, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()
local Yike	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11716 $"):sub(12, -3))
mod:SetCreatureID(76865)--No need to add beasts to this. It's always main boss that's engaged first and dies last.
mod:SetEncounterID(1694)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155198",
	"SPELL_CAST_SUCCESS 155247 155399 154975",
	"SPELL_AURA_APPLIED 154960 155458 155459 155460 154981 155030 155236 155462",
	"SPELL_AURA_APPLIED_DOSE 155030 155236",
	"SPELL_AURA_REMOVED 154960",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_TARGETABLE_CHANGED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--Because boss numbering tends to get out of wack with things constantly joining/leaving fight. I've only seen boss1 and boss2 but for good measure.
)

--TODO, get mythic beast casts and timers
--TODO, verify timers with new start method I did to ensure it works for both mythic and non mythic
--TODO, figure out why setsortedicon is not working for more than 1 person.
--TODO, See if gaining new abilities actually resets cd on old abilities on mythic, or if I need to only start timers for the newly gained abilities
--Boss basic attacks
local warnPinDown					= mod:NewSpellAnnounce(155365, 3)
local warnPinDownTargets			= mod:NewTargetAnnounce(154960, 3)
local warnCallthePack				= mod:NewSpellAnnounce(154975, 3)
--Boss gained abilities (beast deaths grant boss new abilities)
local warnWolf						= mod:NewTargetAnnounce(155458, 3)--Grants Rend and Tear
local warnRendandTear				= mod:NewSpellAnnounce(155385, 3)--Target scanning doesn't seem to work, target is nil. Will check targettarget or something fancy just in case
local warnRylak						= mod:NewTargetAnnounce(155459, 3)--Grants Superheated Shrapnel
local warnSuperheatedShrapnel		= mod:NewSpellAnnounce(155499, 3, nil, mod:IsHealer())
local warnElekk						= mod:NewTargetAnnounce(155460, 3)--Grants Tantrum
local warnTantrum					= mod:NewCountAnnounce(162275, 3)
local warnClefthoof					= mod:NewTargetAnnounce(155462, 3)--Grants Epicenter
local warnEpicenter					= mod:NewSpellAnnounce(162277, 3)--Mythic
--Beast abilities (living beasts)
local warnSavageHowl				= mod:NewSpellAnnounce(155198, 3, nil, mod:IsHealer() or mod:IsTank() or mod:CanRemoveEnrage())
local warnConflag					= mod:NewTargetAnnounce(155399, 3, nil, mod:IsHealer())
local warnSearingFangs				= mod:NewStackAnnounce(155030, 2, nil, mod:IsTank())
local warnCrushArmor				= mod:NewStackAnnounce(155236, 2, nil, mod:IsTank())
local warnStampede					= mod:NewSpellAnnounce(155247, 3)
local warnInfernoBreath				= mod:NewSpellAnnounce(154989, 3)

--Boss basic attacks
local specWarnCallthePack			= mod:NewSpecialWarningSwitch(154975, not mod:IsHealer())
local specWarnPinDown				= mod:NewSpecialWarningSpell(154960, mod:IsRanged(), nil, nil, 2)
local yellPinDown					= mod:NewYell(154960)
--Boss gained abilities (beast deaths grant boss new abilities)
local specWarnRendandTear			= mod:NewSpecialWarningMove(155385, mod:IsMelee())--Always returns to melee
local specWarnSuperheatedShrapnel	= mod:NewSpecialWarningSpell(155499, nil, nil, nil, 2)--Still iffy on it
local specWarnTantrum				= mod:NewSpecialWarningCount(162275, nil, nil, nil, 2)
local specWarnEpicenter				= mod:NewSpecialWarningSpell(162277, nil, nil, nil, 2)
--Beast abilities (living)
local specWarnSavageHowl			= mod:NewSpecialWarningDispel(155198, mod:IsHealer() or mod:IsTank() or mod:CanRemoveEnrage())
local specWarnSearingFangs			= mod:NewSpecialWarningStack(155030, nil, 12)--Stack count assumed, may be 2
local specWarnSearingFangsOther		= mod:NewSpecialWarningTaunt(155030)--No evidence of this existing ANYWHERE in any logs. removed? Bugged?
local specWarnCrushArmor			= mod:NewSpecialWarningStack(155236, nil, 3)--6-9 second cd, 15 second duration, 3 is smallest safe swap, sometimes 2 when favorable RNG
local specWarnCrushArmorOther		= mod:NewSpecialWarningTaunt(155236)
local specWarnInfernoBreath			= mod:NewSpecialWarningSpell(154989, nil, nil, nil, 2)

--Boss basic attacks
local timerPinDownCD				= mod:NewCDTimer(20.5, 155365)--Every 20 seconds unless delayed by other things. CD timer used for this reason
local timerCallthePackCD			= mod:NewCDTimer(25.5, 154975)--Every 25-42 now
--Boss gained abilities (beast deaths grant boss new abilities)
local timerRendandTearCD			= mod:NewCDTimer(12, 155385)
local timerSuperheatedShrapnelCD	= mod:NewCDTimer(15, 155499)--15-30sec variation observed.
local timerTantrumCD				= mod:NewCDCountTimer(30, 162275)--30-35
--local timerEpicenterCD			= mod:NewCDTimer(25, 162277)
--Beast abilities (living)
local timerSavageHowlCD				= mod:NewCDTimer(25, 155198)
local timerConflagCD				= mod:NewCDTimer(20, 155399)
local timerStampedeCD				= mod:NewCDTimer(20, 155247)--20-30 as usual
local timerInfernoBreathCD			= mod:NewCDTimer(20, 154989)

mod:AddRangeFrameOption("8/7/3", nil, not mod:IsMelee())
mod:AddSetIconOption("SetIconOnSpear", 154960)--Not often I make icon options on by default but this one is universally important. YOu always break players out of spear, in any strat.

mod.vb.RylakAbilities = false
mod.vb.WolfAbilities = false
mod.vb.ElekkAbilities = false
mod.vb.FaultlineAbilites= false
mod.vb.mounted = false
mod.vb.tantrumCount = 0
local activeBossGUIDS = {}

local function updateBeasts(cid, status, beastName)
	if DBM.BossHealth:IsShown() then
		if status == 3 then--Add Boss, keep Beast
			DBM.BossHealth:AddBoss(76865, L.name)
		elseif status == 2 then--Just Remove Beast
			DBM.BossHealth:AddBoss(cid, beastName)
		elseif status == 1 then--Add beast, remove boss
			DBM.BossHealth:RemoveBoss(76865)
			DBM.BossHealth:AddBoss(cid, beastName)
		else--Status 0, remove beast add boss
			DBM.BossHealth:RemoveBoss(cid)
			DBM.BossHealth:AddBoss(76865, L.name)
		end
	end
end

local function updateBeastTimers(all, spellId)
	--TODO, if on mythic, and boss is already grounded and timers for other abiltiies already started
	--See if all of them reset or if we need to just add timers for the newly gained ability only
	if mod.vb.WolfAbilities and (all or mod:IsMythic() and spellId == 155458) then--Cruelfang
		timerRendandTearCD:Start(6)--Small sample size. Just keep subtracking if shorter times are observed.
	end
	if mod.vb.RylakAbilities and (all or mod:IsMythic() and spellId == 155459) then--Dreadwing
		timerSuperheatedShrapnelCD:Start(9)--Small sample size. Just keep subtracking if shorter times are observed.
	end
	if mod.vb.ElekkAbilities and (all or mod:IsMythic() and spellId == 155460) then--Ironcrusher
		timerTantrumCD:Start(16, mod.vb.tantrumCount+1)--Small sample size. Just keep subtracking if shorter times are observed.
	end
	if mod.vb.FaultlineAbilites and (all or mod:IsMythic() and spellId == 155462) then--Faultline
		--Mythic Stuff
	end
end

function mod:OnCombatStart(delay)
	self.vb.RylakAbilities = false
	self.vb.WolfAbilities = false
	self.vb.ElekkAbilities = false
	self.vb.FaultlineAbilites = false
	self.vb.mounted = false
	self.vb.tantrumCount = 0
	table.wipe(activeBossGUIDS)
	timerCallthePackCD:Start(9.5-delay)--Time for cast finish, not cast start, because only cast finish is sure thing. cast start can be interrupted
	timerPinDownCD:Start(11-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155198 then
		warnSavageHowl:Show()
		specWarnSavageHowl:Schedule(1.5, args.sourceName)
		timerSavageHowlCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155247 then
		warnStampede:Show()
		timerStampedeCD:Start()
	elseif spellId == 155399 then
		timerConflagCD:Start()
	elseif spellId == 154975 then--Moved to success because spell cast start is interrupted, a lot, and no sense in announcing it if he didn't finish it. if he self interrupts it can be delayed as much as 15 seconds.
		warnCallthePack:Show()
		specWarnCallthePack:Show()
		timerCallthePackCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 154960 then
		warnPinDownTargets:CombinedShow(0.5, args.destName)
		if self.Options.SetIconOnSpear then
			self:SetSortedIcon(1, args.destName, 8, nil, true)--Bugged, still doesn't set more than 1 icon on all targets. Not sure why. It's like reverseIcon isn't working?
		end
		if args:IsPlayer() then
			yellPinDown:Yell()
		end
	elseif spellId == 154981 then
		warnConflag:CombinedShow(0.5, args.destName)
	elseif spellId == 155030 then
		local amount = args.amount or 1
		if amount % 3 == 0 and amount >= 12 then--Stack assumed, may need revising
			warnSearingFangs:Show(args.destName, amount)
			if amount >= 12 then
				if args:IsPlayer() then
					specWarnSearingFangs:Show(amount)
				else
					if not UnitDebuff("player", GetSpellInfo(155030)) and not UnitIsDeadOrGhost("player") then
						specWarnSearingFangsOther:Show(args.destName)
					end
				end
			end
		end
	elseif spellId == 155236 then
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
		if amount >= 3 and args:IsPlayer() then
			specWarnCrushArmor:Show(amount)
		elseif amount >= 2 and not args:IsPlayer() then--Swap at 2 WHEN POSSIBLE but 50/50 you have to go to 3.
			if not UnitDebuff("player", GetSpellInfo(155236)) and not UnitIsDeadOrGhost("player") then
				specWarnCrushArmorOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(155458, 155459, 155460, 155462) then
		if not self:IsMythic() then--Not mythic, boss gaining ability means he just dismounted, start/update all timers.
			updateBeastTimers(true)
		else--On mythic, boss already on ground already casting other things, so only update timers for new ability he just gained.
			updateBeastTimers(false, spellId)
		end
		if spellId == 155458 then--Wolf Aura
			warnWolf:Show(args.destName)
		elseif spellId == 155459 then--Rylak Aura
			warnRylak:Show(args.destName)
		elseif spellId == 155460 then--Elekk Aura
			warnElekk:Show(args.destName)
		elseif spellId == 155462 then--Mythic Beast
			warnClefthoof:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
local spellId = args.spellId
	if spellId == 154960 and self.Options.SetIconOnSpear then
		self:SetIcon(args.destName, 0)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and not activeBossGUIDS[unitGUID] then
			activeBossGUIDS[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 76884 or cid == 76874 or cid == 76945 or cid == 76946 then
				self.vb.mounted = true
				updateBeasts(cid, 1, UnitName(unitID))
				if cid == 76884 then--Cruelfang
					self.vb.WolfAbilities = true
					timerRendandTearCD:Start(5)
					timerSavageHowlCD:Start(15)
					if self.Options.RangeFrame and not self.vb.RylakAbilities then
						DBM.RangeCheck:Show(7)--Upgrade range frame to 7 now that he has rend and tear. TODO: If this attack doesn't target melee
					end
					--Cancel timers for abilities he can't use from other dead beasts
					timerSuperheatedShrapnelCD:Cancel()
					timerTantrumCD:Cancel()
				elseif cid == 76874 then--Dreadwing
					self.vb.RylakAbilities = true
					timerInfernoBreathCD:Start(6)
					timerConflagCD:Start(12)
					if self.Options.RangeFrame then
						DBM.RangeCheck:Show(8)--Update range frame to 8 for Scrapnal. TODO, again, see if melee affected by this or not
					end
					--Cancel timers for abilities he can't use from other dead beasts
					timerRendandTearCD:Cancel()
					timerTantrumCD:Cancel()
				elseif cid == 76945 then--Ironcrusher
					self.vb.ElekkAbilities = true
					timerStampedeCD:Start(15)
					timerTantrumCD:Start(30, self.vb.tantrumCount+1)
					--Cancel timers for abilities he can't use from other dead beasts
					timerRendandTearCD:Cancel()
					timerSuperheatedShrapnelCD:Cancel()
				elseif cid == 76946 then--Faultline
					self.vb.FaultlineAbilites = true
					--Cancel timers for abilities he can't use from other dead beasts
					timerRendandTearCD:Cancel()
					timerSuperheatedShrapnelCD:Cancel()
					timerTantrumCD:Cancel()
				end
			end
		end
	end
end

function mod:UNIT_TARGETABLE_CHANGED()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		local cid = self:GetCIDFromGUID(unitGUID)
		if cid == 76865 and self.vb.mounted then--Boss dismounting living beast on mythic
			self.vb.mounted = false
			updateBeasts(cid, 3)
			updateBeastTimers(true)
		end
	end
end	


function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76884 or cid == 76874 or cid == 76945 or cid == 76946 then--Beasts
		timerSavageHowlCD:Cancel()
		timerConflagCD:Cancel()
		timerStampedeCD:Cancel()
		timerInfernoBreathCD:Cancel()
		if self:IsMythic() then
			updateBeasts(cid, 2)
		else
			updateBeasts(cid, 0)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:154989") then
		warnInfernoBreath:Show()
		specWarnInfernoBreath:Show()
		timerInfernoBreathCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 155221 then--IronCrusher Tantrum
		self.vb.tantrumCount = self.vb.tantrumCount + 1
		warnTantrum:Show(self.vb.tantrumCount)
		specWarnTantrum:Show(self.vb.tantrumCount)
		if self.vb.tantrumCount == 3 then
			self.vb.tantrumCount = 0
		end
		timerTantrumCD:Start(nil, self.vb.tantrumCount+1)
	elseif spellId == 155520 then--Beastlord Darmac Tantrum
		self.vb.tantrumCount = self.vb.tantrumCount + 1
		warnTantrum:Show(self.vb.tantrumCount)
		specWarnTantrum:Show(self.vb.tantrumCount)
		if self.vb.tantrumCount == 3 then
			self.vb.tantrumCount = 0
		end
		timerTantrumCD:Start(37, self.vb.tantrumCount+1)--Initial data supports this having a much longer CD on boss which is why two IDs are split
	elseif spellId == 162277 then--Assume that like his other abilities, isn't in combat log.
		warnEpicenter:Show()
		specWarnEpicenter:Show()
	elseif spellId == 155497 then--Superheated Shrapnel
		warnSuperheatedShrapnel:Show()
		specWarnSuperheatedShrapnel:Show()
	elseif spellId == 155385 or spellId == 155515 then--Both versions of spell(boss and beast), they seem to have same cooldown so combining is fine
		warnRendandTear:Show()
		specWarnRendandTear:Show()
		timerRendandTearCD:Start()
	elseif spellId == 155365 then--Cast
		warnPinDown:Show()
		specWarnPinDown:Show()
		timerPinDownCD:Start()
	end
end
