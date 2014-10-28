local mod	= DBM:NewMod(318, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(53879)
mod:SetModelSound("sound\\CREATURE\\Deathwing\\VO_DS_DEATHWING_BACKEVENT_01.OGG", "sound\\CREATURE\\Deathwing\\VO_DS_DEATHWING_BACKSLAY_01.OGG")
mod:SetZone()
mod:SetUsedIcons(6, 5, 4, 3, 2, 1)

mod:RegisterCombat("yell", L.Pull)--INSTANCE_ENCOUNTER_ENGAGE_UNIT comes 30 seconds after encounter starts, because of this, the mod can miss the first round of ability casts such as first grip targets. have to use yell

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_HEAL",
	"SPELL_PERIODIC_HEAL",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_HEALTH"
)

local warnAbsorbedBlood		= mod:NewStackAnnounce(105248, 2)
local warnGrip				= mod:NewTargetAnnounce(105490, 4)
local warnNuclearBlast		= mod:NewCastAnnounce(105845, 4)
local warnSealArmor			= mod:NewCastAnnounce(105847, 4)
local warnAmalgamation		= mod:NewSpellAnnounce("ej4054", 3, 106005)--Amalgamation spawning, give temp icon.
local warnCorruptionDeath   = mod:NewTargetAnnounce(106199, 3)
local warnCorruptionEarth   = mod:NewTargetAnnounce(106200, 3)

local specWarnTendril		= mod:NewSpecialWarning("SpecWarnTendril")
local specWarnGrip			= mod:NewSpecialWarningSpell(105490, mod:IsDps())
local specWarnNuclearBlast	= mod:NewSpecialWarningRun(105845)
local specWarnSealArmor		= mod:NewSpecialWarningSpell(105847, mod:IsDps())
local specWarnAmalgamation	= mod:NewSpecialWarningSpell("ej4054", false)
local specWarnAmalgamationLowHP	= mod:NewSpecialWarning("SpecWarnAmaLowHP")

local timerSealArmor		= mod:NewCastTimer(23, 105847)
local timerBarrelRoll		= mod:NewCastTimer(6, "ej4050")
local timerGripCD			= mod:NewNextTimer(32, 105490)
local timerDeathCD			= mod:NewCDTimer(8.5, 106199)--8.5-10sec variation.

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("InfoFrame", true)
mod:AddBoolOption("SetIconOnGrip", true)
mod:AddBoolOption("SetIconOnDeath", true)
mod:AddBoolOption("SetIconOnEarth", true)
mod:AddBoolOption("ShowShieldInfo", mod:IsHealer())

local gripTargets = {}
local gripIcon = 6
local corruptionActive = {}
local residueNum = 0
local residueDebug = false
local diedOozeGUIDS = {}
local warnedAmalgamation = false
local BloodAbsorbed = 0

local function checkTendrils()
	if not UnitDebuff("player", GetSpellInfo(105563)) and not UnitIsDeadOrGhost("player") then
		specWarnTendril:Show()
	end
end

local function showGripWarning()
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	specWarnGrip:Show()
	sndWOP:Play(DBM.SoundMMPath.."\\someonecaught.ogg")
	table.wipe(gripTargets)
end

local function warningResidue()
	if mod.Options.InfoFrame and residueNum >= 0 then
		DBM.InfoFrame:SetHeader(L.BloodCount)
		DBM.InfoFrame:Show(1, "texts", residueNum, nil, nil, L.BloodCount)
	end
end

local function checkOozeResurrect(GUID)
	-- set min resurrect time to 5 sec. (guessed)
	if diedOozeGUIDS[GUID] and GetTime() - diedOozeGUIDS[GUID] > 5 then
		residueNum = residueNum - 1
		diedOozeGUIDS[GUID] = nil
		mod:Unschedule(warningResidue)
		mod:Schedule(1.25, warningResidue)
		if residueDebug then print("revived", residueNum) end
	end
end

local clearPlasmaTarget, setPlasmaTarget, clearPlasmaVariables
do
	local plasmaTargets = {}
	local healed = {}

	function mod:SPELL_HEAL(_, _, _, _, destGUID, _, _, _, _, _, _, _, _, absorbed)
		if plasmaTargets[destGUID] then
			healed[destGUID] = healed[destGUID] + (absorbed or 0)
			DBM.BossHealth:Update()
		end
	end
	mod.SPELL_PERIODIC_HEAL = mod.SPELL_HEAL

	local function updatePlasmaTargets()
		local maxAbsorb =	mod:IsDifficulty("heroic25") and 420000 or
							mod:IsDifficulty("heroic10") and 280000 or
							mod:IsDifficulty("normal25") and 300000 or
							mod:IsDifficulty("normal10") and 200000 or 1
		DBM.BossHealth:Clear()
		if not DBM.BossHealth:IsShown() then
			DBM.BossHealth:Show(L.name)
		end
		for i,v in pairs(plasmaTargets) do
			DBM.BossHealth:AddBoss(function() return math.max(1, math.floor((healed[i] or 0) / maxAbsorb * 100))	end, L.PlasmaTarget:format(v))
		end
	end
	
	function setPlasmaTarget(guid, name)
		plasmaTargets[guid] = name
		healed[guid] = 0
		updatePlasmaTargets()
	end

	function clearPlasmaTarget(guid, name)
		plasmaTargets[guid] = nil
		healed[guid] = nil
		updatePlasmaTargets()
	end
	
	function clearPlasmaVariables()
		table.wipe(plasmaTargets)
		table.wipe(healed)
		updatePlasmaTargets()
	end
end



function mod:OnCombatStart(delay)
	if self:IsDifficulty("lfr25") then
		warnSealArmor = mod:NewCastAnnounce(105847, 4, 34.5)
	else
		warnSealArmor = mod:NewCastAnnounce(105847, 4)
	end
	table.wipe(gripTargets)
	table.wipe(corruptionActive)
	table.wipe(diedOozeGUIDS)
	if self.Options.ShowShieldInfo then
		clearPlasmaVariables()
	end
	gripIcon = 6
	residueNum = 0
	warnedAmalgamation = false
	BloodAbsorbed = 0
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(105845) then
		warnNuclearBlast:Show()
		specWarnNuclearBlast:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\boomrun.ogg")
		warnedAmalgamation = false
	elseif args:IsSpellID(105847, 105848) then
		warnSealArmor:Show()
		specWarnSealArmor:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\killmuscle.ogg")
		if self:IsDifficulty("lfr25") then
			timerSealArmor:Start(34.5)
		else
			timerSealArmor:Start()
		end
	elseif args:IsSpellID(109379) then
		if not corruptionActive[args.sourceGUID] then
			corruptionActive[args.sourceGUID] = 0
			if self:IsDifficulty("normal25", "heroic25") then
				timerGripCD:Start(16, args.sourceGUID)
			else
				timerGripCD:Start(nil, args.sourceGUID)
			end
		end
		corruptionActive[args.sourceGUID] = corruptionActive[args.sourceGUID] + 1
		if corruptionActive[args.sourceGUID] == 2 and self:IsDifficulty("normal25", "heroic25") then
			timerGripCD:Update(8, 16, args.sourceGUID)
			sndWOP:Schedule(5, "Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\3.ogg")
			sndWOP:Schedule(6, "Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\2.ogg")
			sndWOP:Schedule(7, "Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\1.ogg")
		elseif corruptionActive[args.sourceGUID] == 4 and self:IsDifficulty("normal10", "heroic10") then
			timerGripCD:Update(24, 32, args.sourceGUID)
			sndWOP:Schedule(5, "Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\3.ogg")
			sndWOP:Schedule(6, "Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\2.ogg")
			sndWOP:Schedule(7, "Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\1.ogg")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(106199) and self:IsHealer() then
		sndWOP:Play(DBM.SoundMMPath.."\\dispelnow.ogg")
	elseif args:IsSpellID(105219) then
		residueNum = residueNum + 1
		diedOozeGUIDS[args.sourceGUID] = GetTime()
		self:Unschedule(warningResidue)
		self:Schedule(1.25, warningResidue)
		if residueDebug then print("created", residueNum) end
	elseif args:IsSpellID(105248) and diedOozeGUIDS[args.sourceGUID] then
		residueNum = residueNum - 1
		diedOozeGUIDS[args.sourceGUID] = nil
		self:Unschedule(warningResidue)
		self:Schedule(1.25, warningResidue)
		if residueDebug then print("absorbed", residueNum) end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, destGUID)
	checkOozeResurrect(sourceGUID)
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(sourceGUID, _, _, _, destGUID)
	checkOozeResurrect(sourceGUID)
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105248) then
		warnAbsorbedBlood:Show(args.destName, 1)
		BloodAbsorbed = 1
	elseif args:IsSpellID(105490) then
		gripTargets[#gripTargets + 1] = args.destName
		timerGripCD:Cancel(args.sourceGUID)
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\3.ogg")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\2.ogg")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\1.ogg")
		if corruptionActive[args.sourceGUID] then
			corruptionActive[args.sourceGUID] = nil
		end
		if self.Options.SetIconOnGrip then
			if gripIcon == 0 then
				gripIcon = 6
			end
			self:SetIcon(args.destName, gripIcon)
			gripIcon = gripIcon - 1
		end
		self:Unschedule(showGripWarning)
		self:Schedule(0.3, showGripWarning)
	elseif args:IsSpellID(105479) then
		if self.Options.ShowShieldInfo then
			setPlasmaTarget(args.destGUID, args.destName)
		end
	elseif args:IsSpellID(106199) then
		warnCorruptionDeath:Show(args.destName)
		if self.Options.SetIconOnDeath then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(106200) then
		warnCorruptionEarth:Show(args.destName)
		if self.Options.SetIconOnEarth then
			self:SetIcon(args.destName, 7)
		end
	end
end		

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(105248) then
		if args.amount == 9 then
			warnAbsorbedBlood:Show(args.destName, args.amount)
			warnedAmalgamation = true
			sndWOP:Play(DBM.SoundMMPath.."\\killmixone.ogg")
		else
			warnAbsorbedBlood:Show(args.destName, args.amount)
		end
		BloodAbsorbed = args.amount
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(105490) then
		if self.Options.SetIconOnGrip then
			self:SetIcon(args.destName, 0)
		end
		if self:IsDps() then
			sndWOP:Play(DBM.SoundMMPath.."\\safenow.ogg")
		end
	elseif args:IsSpellID(105479) then
		if self.Options.ShowShieldInfo then
			clearPlasmaTarget(args.destGUID, args.destName)
		end
	elseif args:IsSpellID(106199) then
		if self.Options.SetIconOnDeath then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(106200) then
		if self.Options.SetIconOnEarth then
			self:SetIcon(args.destName, 0)
		end
	end
end	

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.DRoll or msg:find(L.DRoll) or msg == L.DRollR or msg:find(L.DRollR) then
		self:Unschedule(checkTendrils)
		checkTendrils()
		self:Schedule(3, checkTendrils)
		timerBarrelRoll:Start()
		sndWOP:Schedule(4, DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Schedule(5, DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Schedule(6, DBM.SoundMMPath.."\\countone.ogg")
		if msg == L.DRoll or msg:find(L.DRoll) then
			sndWOP:Play(DBM.SoundMMPath.."\\leftside.ogg")
		elseif msg == L.DRollR or msg:find(L.DRollR) then
			sndWOP:Play(DBM.SoundMMPath.."\\rightside.ogg")
		end
	elseif msg == L.DLevels or msg:find(L.DLevels) then
		sndWOP:Play(DBM.SoundMMPath.."\\balancenow.ogg")
		self:Unschedule(checkTendrils)
		timerBarrelRoll:Cancel()
		sndWOP:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\countone.ogg")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53891 or cid == 56162 or cid == 56161 then
		timerGripCD:Cancel(args.sourceGUID)
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\3.ogg")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\2.ogg")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\sounds\\Corsica_S\\1.ogg")
		warnAmalgamation:Schedule(4.5)--4.5-5 seconds after corruption dies.
		specWarnAmalgamation:Schedule(4.5)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerDeathCD:Start(args.destGUID)
		end
	elseif cid == 56341 or cid == 56575 then
		timerSealArmor:Cancel()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 53890 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h < 15 and not warnedAmalgamation and BloodAbsorbed < 9 then
			warnedAmalgamation = true
			local bleft = 9 - BloodAbsorbed
			specWarnAmalgamationLowHP:Show(bleft)
			if not self:IsHealer() then
				sndWOP:Play(DBM.SoundMMPath.."\\stopatk.ogg")
			end
		end
	end
end