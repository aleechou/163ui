﻿local mod	= DBM:NewMod(864, "DBM-SiegeOfOrgrimmarV2", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11360 $"):sub(12, -3))
mod:SetCreatureID(71466)
mod:SetEncounterID(1600)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnDemolisherCanon		= mod:NewSpellAnnounce(144154, 1, nil, false, nil, nil, nil, nil, 2)--This spell uses in both mode.
--Assault Mode
local warnBorerDrill			= mod:NewSpellAnnounce(144218, 4)
local warnLaserBurn				= mod:NewTargetAnnounce(144459, 2, nil, false, nil, nil, nil, nil, 2)
local warnMortarCannon			= mod:NewSpellAnnounce(144316, 3, nil, false, nil, nil, nil, nil, 2)--Could not get target scanning working.
local warnCrawlerMine			= mod:NewSpellAnnounce(144673, 3)
local warnIgniteArmor			= mod:NewStackAnnounce(144467, 2, nil, mod:IsTank())--Seems redundant to count debuffs and warn for breath, so just do debuffs
local warnRicochet				= mod:NewSpellAnnounce(144356, 3)
--Siege Mode
local warnSeismicActivity		= mod:NewSpellAnnounce(144483, 2)--A mere activation of phase
local warnExplosiveTar			= mod:NewSpellAnnounce(144492, 3)
local warnShockPulse			= mod:NewCountAnnounce(144485, 4)
local warnCutterLaser			= mod:NewTargetAnnounce(146325, 4)--Not holding my breath this shows in combat log.
local warnMortarBarrage			= mod:NewSpellAnnounce(144555, 4)--Heroic

--Assault Mode
local specWarnIgniteArmor		= mod:NewSpecialWarningStack(144467, mod:IsTank(), 3)
local specWarnIgniteArmorOther	= mod:NewSpecialWarningTarget(144467, mod:IsTank())
local specWarnBorerDrill		= mod:NewSpecialWarningSpell(144218, false, nil, nil, 2)
local specWarnBorerDrillMove	= mod:NewSpecialWarningMove(144218)
--Siege Mode
local specWarnSeismicActivity	= mod:NewSpecialWarningSpell(144483, nil, nil, nil, 2)
local specWarnShockPulse		= mod:NewSpecialWarningCount(144485, nil, nil, nil, 2)
local specWarnCutterLaser		= mod:NewSpecialWarningRun(146325)
local specWarnExplosiveTar		= mod:NewSpecialWarningMove(144498)
local yellCutterLaser			= mod:NewYell(146325)
local specWarnMortarBarrage		= mod:NewSpecialWarningSpell(144555, nil, nil, nil, 2)

local timerDemolisherCanonCD	= mod:NewCDTimer(8.5, 144154, nil, false, nil, nil, nil, nil, nil, nil, 2)--Spammy. off by default
--Assault Mode
local timerAssaultModeCD		= mod:NewNextTimer(62, 141395, nil, "timerAssaultModeCD")--141395 is correct timer text but it's wrong spellid, custom option text for real timer description
local timerIgniteArmor			= mod:NewTargetTimer(30, 144467, nil, mod:IsTank() or mod:IsHealer())
local timerIgniteArmorCD		= mod:NewCDTimer(10, 144467, nil, mod:IsTank())
local timerLaserBurnCD			= mod:NewCDTimer(11.5, 144459, nil, false, nil, nil, nil, nil, nil, nil, 2)--Also off by default(bar spam)
local timerBorerDrillCD			= mod:NewCDTimer(17, 144218)
local timerCrawlerMineCD		= mod:NewCDTimer(30, 144673)
local timerRicochetCD			= mod:NewCDTimer(15, 144356)
--Siege Mode
local timerSiegeModeCD			= mod:NewNextTimer(114, 84974, nil, nil, "timerSiegeModeCD")--Wish spell name was a litlte shorter but still better than localizing
local timerCuttingLaser			= mod:NewTargetTimer(10, 146325)--Spell tooltip says 15 but combat log showed 10
local timerShockPulseCD			= mod:NewNextCountTimer(16.5, 144485)
local timerExplosiveTarCD		= mod:NewNextTimer(30, 144492)
local timerMortarBarrageCD		= mod:NewNextTimer(30, 144555)

--local soundCuttingLaser			= mod:NewSound(146325)

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 144154, mod:IsRanged())

local siegeMode = false
local shockCount = 0
local firstTar = false
local firstMortar = false

mod:AddBoolOption("dr", true, "sound")
for i = 1, 5 do
	mod:AddBoolOption("dr"..i, false, "sound")
end
local function MyJS()
	if (mod.Options.dr1 and shockCount == 1) or (mod.Options.dr2 and shockCount == 2) or (mod.Options.dr3 and shockCount == 3) or (mod.Options.dr4 and shockCount == 4) or (mod.Options.dr5 and shockCount == 5) then
		return true
	end
	return false
end

function mod:OnCombatStart(delay)
	siegeMode = false
	shockCount = 0
	timerIgniteArmorCD:Start(9-delay)
	timerLaserBurnCD:Start(-delay)
	timerBorerDrillCD:Start(-delay)
	timerCrawlerMineCD:Start(-delay)
	timerSiegeModeCD:Start(120.5-delay)--First one longer than rest
	if self:IsMythic() then
		berserkTimer:Start(450-delay)
		timerRicochetCD:Start(-delay)
	else
		berserkTimer:Start(-delay)
	end
	sndWOP:Schedule(117, "ex_so_qgzb") --強攻階段準備
	sndWOP:Schedule(118, "countthree")
	sndWOP:Schedule(119, "counttwo")
	sndWOP:Schedule(120, "countone")
	if self.Options.RangeFrame and not self:IsLFR() then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144483 then--Siege mode transition
		siegeMode = true
		shockCount = 0
		firstTar = false
		firstMortar = false
		timerLaserBurnCD:Cancel()
		timerCrawlerMineCD:Cancel()
		timerBorerDrillCD:Cancel()
		timerRicochetCD:Cancel()
		warnSeismicActivity:Show()
		specWarnSeismicActivity:Show()
		timerExplosiveTarCD:Start(7)
		timerShockPulseCD:Start(nil, 1)
		if self:IsMythic() then
			timerMortarBarrageCD:Start(20)
		end
		sndWOP:Cancel("ex_so_qgzb")
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
		sndWOP:Play("phasechange") --階段轉換		
		timerAssaultModeCD:Start()
		sndWOP:Schedule(60, "ex_so_tjzb") --突擊階段準備
		sndWOP:Schedule(61, "countthree")
		sndWOP:Schedule(62, "counttwo")
		sndWOP:Schedule(63, "countone")
	elseif args.spellId == 144485 then
		shockCount = shockCount + 1
		warnShockPulse:Show(shockCount)
		specWarnShockPulse:Show(shockCount)
		if shockCount < 3 then
			timerShockPulseCD:Start(nil, shockCount+1)
		end
		sndWOP:Play("ex_so_zbjt") --準備擊飞		
		if MyJS() then
			sndWOP:Schedule(1, "defensive") --注意減傷
		else
			sndWOP:Schedule(1, "countthree")
		end		
		sndWOP:Schedule(2, "counttwo")
		sndWOP:Schedule(3, "countone")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 146325 then
		self:SendSync("LaserTarget", args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144467 then
		timerIgniteArmorCD:Start()
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then
			local amount = args.amount or 1
			warnIgniteArmor:Show(args.destName, amount)
			timerIgniteArmor:Start(args.destName)
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnIgniteArmor:Show(amount)
					sndWOP:Play("sunderhigh") --破甲過高
				else
					specWarnIgniteArmorOther:Show(args.destName)
					if mod:IsTank() then
						sndWOP:Play("changemt") --換坦嘲諷
					end
				end
			end
		end
	elseif args.spellId == 146325 then
		self:SendSync("LaserTarget", args.destGUID)
	elseif args.spellId == 144459 then
		warnLaserBurn:CombinedShow(0.5, args.destName)
		timerLaserBurnCD:DelayedStart(0.5)
	elseif args.spellId == 144498 and args:IsPlayer() then
		specWarnExplosiveTar:Show()
		sndWOP:Play("runaway")--快躲開
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144467 then
		timerIgniteArmor:Cancel(args.destName)
	elseif args.spellId == 146325 then
		self:SendSync("LaserTargetRemoved", args.destGUID)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 144218 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnBorerDrillMove:Show()
		sndWOP:Play("runaway")--快躲開
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:RAID_BOSS_WHISPER(msg)--It was actually CHAT_MSG_RAID_BOSS_EMOTE during test, but that was a bug, it'll probably be whisper next time
	if msg:find("spell:144918") then
		self:SendSync("LaserTarget", UnitGUID("player"))
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 145407 then
		warnMortarCannon:Show()
	elseif spellId == 144296 then--absolutely do NOT add 144218 to this. 144218 is an every 0.4 second periodic trigger that fires after 144296
		warnBorerDrill:Show()
		specWarnBorerDrill:Show()
		sndWOP:Play("ex_so_dckd")--地刺快躲
		timerBorerDrillCD:Start()
	elseif spellId == 144673 then
		warnCrawlerMine:Show()
		if not siegeMode then--These spawn during siege mode but random as all hell, there is no timer in this phase for these
			timerCrawlerMineCD:Start()
		end
		sndWOP:Play("ex_so_dlcx")--地雷出現
	elseif spellId == 144198 then
		warnDemolisherCanon:Show()
		timerDemolisherCanonCD:Start()
	elseif spellId == 144492 then
		warnExplosiveTar:Show()
		if not firstTar then
			firstTar = true
			timerExplosiveTarCD:Start()
		end
	elseif spellId == 146359 then--Regeneration (Assault Mode power regen activation)
		--2 seconds slower than emote, but it's not pressing enough to matter so it's better localisation wise to do it this way
		timerMortarBarrageCD:Cancel()
		if siegeMode == true then--don't start timer on pull regenerate, pull regenerate is 5 seconds longer than rest of them
			timerSiegeModeCD:Start()
			sndWOP:Cancel("ex_so_tjzb")
			sndWOP:Cancel("countthree")
			sndWOP:Cancel("counttwo")
			sndWOP:Cancel("countone")
			sndWOP:Play("phasechange") --階段轉換
			sndWOP:Schedule(112, "ex_so_qgzb") --強攻階段準備
			sndWOP:Schedule(113, "countthree")
			sndWOP:Schedule(114, "counttwo")
			sndWOP:Schedule(115, "countone")
			siegeMode = false
		end
		--[[if self:IsMythic() then
			timerRicochetCD:Start(22)
		end--]]--TODO, verify consistency, as 22 seems odd and could have just been a delayed cast.
	elseif spellId == 144555 then
		warnMortarBarrage:Show()
		specWarnMortarBarrage:Show()
		if not firstMortar then
			firstMortar = true
			timerMortarBarrageCD:Start()
		end
	elseif spellId == 144356 then
		warnRicochet:Show()
		timerRicochetCD:Start()
	end
end

function mod:OnSync(msg, guid)
	--Syncing used do to combat log range issues if raid is too spread out
	--It's easy to be out of range of combat log event
	--We also scan success and applied since we may be in range of one and not the other
	--We just watch both combat events and emote for good measure, so we grab SOMETHING and sync it
	if msg == "LaserTarget" and guid then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		warnCutterLaser:Show(targetName)
		timerIgniteArmor:Start(targetName)
		if targetName == UnitName("player") then
			specWarnCutterLaser:Show()
			yellCutterLaser:Yell()
--			soundCuttingLaser:Play()
			sndWOP:Play("laserrun") --快跑 激光點你
		end
	elseif msg == "LaserTargetRemoved" and guid then
		timerCuttingLaser:Cancel(DBM:GetFullPlayerNameByGUID(guid))
	end
end
