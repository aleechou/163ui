local mod	= DBM:NewMod(333, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(56173)
mod:SetModelSound("sound\\CREATURE\\Deathwing\\VO_DS_DEATHWING_MAELSTROMEVENT_01.OGG", "sound\\CREATURE\\Deathwing\\VO_DS_DEATHWING_MAELSTROMSPELL_04")
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("yell", L.Pull)
mod:SetMinCombatTime(20)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 target"--Target needed for bolt died detection
)

local warnMutated				= mod:NewSpellAnnounce("ej4112", 3, 61618)
local warnImpale				= mod:NewTargetAnnounce(106400, 3, nil, mod:IsTank() or mod:IsHealer())
local warnElementiumBolt		= mod:NewSpellAnnounce(105651, 4)
local warnTentacle				= mod:NewSpellAnnounce(105551, 3)
local warnHemorrhage			= mod:NewSpellAnnounce(105863, 3)
local warnCataclysm				= mod:NewCastAnnounce(106523, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2, 3)
local warnFragments				= mod:NewSpellAnnounce("ej4115", 4, 106708)
local warnTerror				= mod:NewSpellAnnounce("ej4117", 4, 106765)
local warnShrapnel				= mod:NewTargetAnnounce(106794, 3)
local warnParasite				= mod:NewTargetAnnounce(108649, 4)
local warnCongealingBloodSoon	= mod:NewSoonAnnounce("ej4350", 4, 109089)--15%, 10%, 5% on heroic. spellid is 109089.

local specWarnMutated			= mod:NewSpecialWarningSwitch("ej4112", true)
local specWarnImpale			= mod:NewSpecialWarningYou(106400)
local specWarnImpaleOther		= mod:NewSpecialWarningTarget(106400, mod:IsTank() or mod:IsHealer())
local specWarnElementiumBolt	= mod:NewSpecialWarningSpell(105651, nil, nil, nil, true)
local specWarnTentacle			= mod:NewSpecialWarningSwitch("ej4103", true)
local specWarnHemorrhage		= mod:NewSpecialWarningSpell(105863, mod:IsDps())
local specWarnFragments			= mod:NewSpecialWarningSpell("ej4115", true)
local specWarnTerror			= mod:NewSpecialWarningSpell("ej4117", true)
local specWarnShrapnel			= mod:NewSpecialWarningYou(106794)
local yellShrapnel				= mod:NewYell(106794)
local specWarnParasite			= mod:NewSpecialWarningYou(108649)
local specWarnUnstableCorruption			= mod:NewSpecialWarningSpell(108813)
local yellParasite				= mod:NewYell(108649)
local specWarnCongealingBlood	= mod:NewSpecialWarningSwitch("ej4350", true)

local timerImpale				= mod:NewTargetTimer(49.5, 106400, nil, false)
local timerImpaleCD				= mod:NewCDTimer(35, 106400, nil, mod:IsTank() or mod:IsHealer())
local timerElementiumCast		= mod:NewCastTimer(7.5, 105651)
local timerElementiumBlast		= mod:NewCastTimer(8, 105723)
local timerElementiumBoltCD		= mod:NewNextTimer(55.5, 105651)
local timerHemorrhageCD			= mod:NewCDTimer(100.5, 105863)
local timerCataclysm			= mod:NewCastTimer(60, 106523)
local timerCataclysmCD			= mod:NewCDTimer(130.5, 106523)
local timerFragmentsCD			= mod:NewNextTimer(90, "ej4115", nil, nil, nil, 106708)
local timerTerrorCD				= mod:NewNextTimer(90, "ej4117", nil, nil, nil, 106765)
local timerMutantCD		= mod:NewTimer(11, "TimerMutant", 61618)
local timerShrapnel				= mod:NewBuffFadesTimer(6, 106794)
local timerCrushCD	 = mod:NewNextTimer(7, 106382)
local timerParasite				= mod:NewTargetTimer(10, 108649)
local timerParasiteCD			= mod:NewCDTimer(60, 108649)
local timerUnstableCorruption	= mod:NewCastTimer(10, 108813)

local berserkTimer				= mod:NewBerserkTimer(900)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("SetIconOnParasite", true)
mod:AddBoolOption("SetIconOnCrush", true)

local firstAspect = true
local engageCount = 0
--local playerGUID = 0
local shrapnelTargets = {}
local warnedCount = 0
--local hemorrhage = GetSpellInfo(105863)
--local fragment = GetSpellInfo(106775)
--local blisterling  = GetSpellInfo(105551)
local parasiteinvortex = false
local parasitecount = 0
local crushicon = 1
local nameone = nil
local nametwo = nil

local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, GetSpellInfo(108649))
	end
end

function mod:updateRangeFrame()
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", GetSpellInfo(108649)) then
		DBM.RangeCheck:Show(10, nil)
	else
		DBM.RangeCheck:Show(10, debuffFilter)
	end
end

local function warnShrapnelTargets()
	warnShrapnel:Show(table.concat(shrapnelTargets, "<, >"))
	table.wipe(shrapnelTargets)
end

function mod:OnCombatStart(delay)
	firstAspect = true
	engageCount = 0
--	playerGUID = 0
	warnedCount = 0
	parasitecount = 0
	parasiteinvortex = false
	crushicon = 1
	nameone = nil
	nametwo = nil
	table.wipe(shrapnelTargets)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if nameone ~= nil and self.Options.SetIconOnCrush then
		self:SetIcon(nameone, 0)
	end
	if nametwo ~= nil and self.Options.SetIconOnCrush then
		self:SetIcon(nametwo, 0)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107018) then
		parasitecount = 0
		if firstAspect then
			firstAspect = false
			timerImpaleCD:Start(22)
			timerElementiumBoltCD:Start(40.5)
			if self:IsDifficulty("heroic10", "heroic25") then
				timerHemorrhageCD:Start(55.5)
				timerParasiteCD:Start(11)
			else
				timerHemorrhageCD:Start(85.5)
			end
			timerCataclysmCD:Start(115.5)
			warnMutated:Schedule(11)
			specWarnMutated:Schedule(11)
			timerMutantCD:Start(11)
			sndWOP:Schedule(11, "mutant")
		else
			timerImpaleCD:Start(27.5)
			timerElementiumBoltCD:Start()
			if self:IsDifficulty("heroic10", "heroic25") then
				timerHemorrhageCD:Start(70.5)
				timerParasiteCD:Start(22)
			else
				timerHemorrhageCD:Start()
			end
			timerCataclysmCD:Start()
			warnMutated:Schedule(17)
			specWarnMutated:Schedule(17)
			timerMutantCD:Start(17)
			sndWOP:Schedule(17, "mutant")
		end	
	elseif args:IsSpellID(106523) then
		warnCataclysm:Show()
		timerCataclysm:Start()
	elseif args:IsSpellID(108813) then
		if parasiteinvortex then
			timerUnstableCorruption:Start(15)
			if UnitBuff("player", GetSpellInfo(106457)) and not UnitIsDeadOrGhost("player") and not self:IsTank() then--Check for Ysera's Presence
				sndWOP:Schedule(12, "clickshield")
			end
			sndWOP:Schedule(13, "countthree")
			sndWOP:Schedule(14, "counttwo")
			sndWOP:Schedule(15, "countone")
		else
			timerUnstableCorruption:Start()
			if UnitBuff("player", GetSpellInfo(106457)) and not UnitIsDeadOrGhost("player") and not self:IsTank() then--Check for Ysera's Presence
				sndWOP:Schedule(7, "clickshield")
			end
			sndWOP:Schedule(8, "countthree")
			sndWOP:Schedule(9, "counttwo")
			sndWOP:Schedule(10, "countone")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(105651) then
		warnElementiumBolt:Show()
		if not UnitBuff("player", GetSpellInfo(106027)) and not UnitIsDeadOrGhost("player") then--Check for Nozdormu's Presence
			specWarnElementiumBolt:Show()
			sndWOP:Play("boltappear")
			timerElementiumBlast:Start()
			sndWOP:Schedule(4, "boomrun")
			sndWOP:Schedule(5.5, "countthree")
			sndWOP:Schedule(6.5, "counttwo")
			sndWOP:Schedule(7.5, "countone")
		else
			timerElementiumCast:Start()	
			timerElementiumBlast:Start(18)
			specWarnElementiumBolt:Schedule(5.5)
			sndWOP:Schedule(5.5, "boltappear")
			sndWOP:Schedule(15.5, "countthree")
			sndWOP:Schedule(16.5, "counttwo")
			sndWOP:Schedule(17.5, "countone")
		end
	elseif args:IsSpellID(110063) then
		self:SendSync("MadnessDown")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(106548) then--Arm/Wing Transition
		timerElementiumBoltCD:Cancel()
		timerHemorrhageCD:Cancel()--Does this one cancel in event you super overgear this and stomp his ass this fast?
		timerCataclysm:Cancel()
		timerCataclysmCD:Cancel()
	elseif args:IsSpellID(106834) then--Phase 2
		warnPhase2:Show()
		timerFragmentsCD:Start(10.5)
		timerTerrorCD:Start(35.5)
		if self:IsDifficulty("heroic10", "heroic25") then--Only register on heroic, we don't need on normal.
			self:RegisterShortTermEvents(
				"UNIT_HEALTH_FREQUENT"
			)
		end
	elseif args:IsSpellID(106400) then
		warnImpale:Show(args.destName)
		timerImpale:Start(args.destName)
		timerImpaleCD:Start()
--		sndWOP:Schedule(29, "awaymutant")
		if args:IsPlayer() then
			specWarnImpale:Show()
			if not UnitBuff("player", GetSpellInfo(106457)) and not UnitIsDeadOrGhost("player") then--Check for Ysera's Presence
				sndWOP:Play("watchimpale")
			else
				sndWOP:Play("clickshield")
			end
		else
			specWarnImpaleOther:Show(args.destName)
			if self:IsTank() then
				sndWOP:Play("changemt")				
			else
				sndWOP:Play("watchimpale")
			end
		end
	elseif args:IsSpellID(106794) then
		shrapnelTargets[#shrapnelTargets + 1] = args.destName
		self:Unschedule(warnShrapnelTargets)
		if args:IsPlayer() then
			specWarnShrapnel:Show()
			yellShrapnel:Yell()
			timerShrapnel:Start()
			sndWOP:Schedule(1.5, "clickshield")
			sndWOP:Schedule(3, "countthree")
			sndWOP:Schedule(4, "counttwo")
			sndWOP:Schedule(5, "countone")
		end
		if (self:IsDifficulty("normal10", "heroic10") and #shrapnelTargets >= 3) or (self:IsDifficulty("normal25", "heroic25", "lfr25") and #shrapnelTargets >= 8) then
			warnShrapnelTargets()
		else
			self:Schedule(0.3, warnShrapnelTargets)
		end
	elseif args:IsSpellID(108649) then
		parasitecount = parasitecount + 1
		warnParasite:Show(args.destName)
		timerParasite:Start(args.destName)
		if parasitecount < 2 then
			timerParasiteCD:Start()
		end
		self:updateRangeFrame()
		if args:IsPlayer() then
			specWarnParasite:Show()
			sndWOP:Play("runout")
			yellParasite:Yell()
		elseif self:IsHealer() then
			sndWOP:Play("healparasite")
		end
--		playerGUID = args.destGUID
		if self.Options.SetIconOnParasite then
			self:SetIcon(args.destName, 8)
		end
	end
end	

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(106444) then
		timerImpale:Cancel(args.destName)
	elseif args:IsSpellID(106794) and args:IsPlayer() then
		timerShrapnel:Cancel()
	elseif args:IsSpellID(108649) then
		if self.Options.SetIconOnParasite then
			self:SetIcon(args.destName, 0)
		end
		specWarnUnstableCorruption:Show()
		sndWOP:Play("killparasite")
		if UnitDebuff(args.destName, GetSpellInfo(108646)) then
			parasiteinvortex = true
		else
			parasiteinvortex = false
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(109091) and self:AntiSpam(10, 1) then
		specWarnCongealingBlood:Show()
		sndWOP:Play("aeblood")
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, destName, _, _, spellId)
	if spellId == 106385 and self:AntiSpam(3) and self:IsDifficulty("heroic10", "normal10") and self.Options.SetIconOnCrush then
		local oldIcon = self:GetIcon(destName) or 0
		if oldIcon ~= 1 and oldIcon ~= 2 then
			self:SetIcon(destName, crushicon)
			if crushicon == 1 then
				crushicon = 2
				nameone = destName
			else
				crushicon = 1
				nametwo = destName
			end
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56471 then
		timerImpaleCD:Cancel()
--		sndWOP:Cancel("awaymutant")
		timerImpale:Cancel()
	elseif cid == 57479 then
		timerUnstableCorruption:Cancel()
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 110663 and self:AntiSpam(2, 3) then--Elementium Meteor Transform (apparently this doesn't fire UNIT_DIED anymore, need to use this alternate method)
		self:SendSync("BoltDied")--Send sync because Elementium bolts do not have a bossN arg, which means event only fires if it's current target/focus.
	elseif spellId == 105853 and self:AntiSpam(2, 2) then
		warnHemorrhage:Show()
		specWarnHemorrhage:Show()
		sndWOP:Play("aeblood")
	elseif spellId == 105551 and self:AntiSpam(2, 2) then--Spawn Blistering Tentacles
		if nameone ~= nil and self.Options.SetIconOnCrush then
			self:SetIcon(nameone, 0)
		end
		if nametwo ~= nil and self.Options.SetIconOnCrush then
			self:SetIcon(nametwo, 0)
		end
		crushicon = 1
		if not UnitBuff("player", GetSpellInfo(106028)) then--Check for Alexstrasza's Presence
			warnTentacle:Show()
			specWarnTentacle:Show()
			sndWOP:Play("blisterling")
		end
	elseif spellId == 106775 and self:AntiSpam(2, 2) then--Summon Impaling Tentacle (Fragments summon)
		warnFragments:Show()
		specWarnFragments:Show()
		timerFragmentsCD:Start()
	elseif spellId == 106765 and self:AntiSpam(2, 2) then--Summon Elementium Terror (Big angry add)
		warnTerror:Show()
		specWarnTerror:Show()
		timerTerrorCD:Start()
	elseif spellId == 106382 then
		timerCrushCD:Start()
	end
end

function mod:OnSync(msg)
	if msg == "BoltDied" then
		timerElementiumBlast:Cancel()
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
	elseif msg == "MadnessDown" and self:IsInCombat() then
		DBM:EndCombat(self)
	end
end

function mod:UNIT_HEALTH_FREQUENT(uId)
	if uId == "boss1" then
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if hp > 16 and hp < 17.5 and warnedCount == 0 then
			warnedCount = 1
			warnCongealingBloodSoon:Show()
		elseif hp > 11 and hp < 12.5 and warnedCount == 1 then
			warnedCount = 2
			warnCongealingBloodSoon:Show()
		elseif hp > 6 and hp < 7.5 and warnedCount == 2 then
			warnedCount = 3
			warnCongealingBloodSoon:Show()
			self:UnregisterShortTermEvents()
		end
	end
end