local mod	= DBM:NewMod(827, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
-- BH ADD
local sndWOP	= mod:SoundMM("SoundWOP")
local sndIon	= mod:SoundMM("SoundWOPIonM")
local sndIonCD	= mod:SoundMM("SoundWOPIonM")

mod:SetRevision(("$Revision: 11365 $"):sub(12, -3))
mod:SetCreatureID(69465)
mod:SetEncounterID(1577)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	-- BH ADD
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER"
)

local warnFocusedLightning			= mod:NewTargetAnnounce(137399, 4)
local warnStaticBurst				= mod:NewTargetAnnounce(137162, 3, nil, mod:IsTank() or mod:IsHealer())
local warnThrow						= mod:NewTargetAnnounce(137175, 2)
local warnStorm						= mod:NewSpellAnnounce(137313, 3)
local warnIonization				= mod:NewSpellAnnounce(138732, 4)

local specWarnFocusedLightning		= mod:NewSpecialWarningRun(137422)
local yellFocusedLightning			= mod:NewYell(137422)
local specWarnStaticBurst			= mod:NewSpecialWarningYou(137162, mod:IsTank())
local specWarnStaticBurstOther		= mod:NewSpecialWarningTarget(137162, mod:IsTank())
local specWarnThrow					= mod:NewSpecialWarningYou(137175, mod:IsTank())
local specWarnThrowOther			= mod:NewSpecialWarningTarget(137175, mod:IsTank())
local specWarnStorm					= mod:NewSpecialWarningSpell(137313, nil, nil, nil, 2)
local specWarnElectrifiedWaters		= mod:NewSpecialWarningMove(138006)
local specWarnIonization			= mod:NewSpecialWarningSpell(138732, not mod:IsTank(), nil, nil, 2)

local timerFocusedLightningCD		= mod:NewCDTimer(10, 137399)--10-18 second variation, tends to lean toward 11-12 except when delayed by other casts such as throw or storm. Pull one also seems to variate highly
local timerStaticBurstCD			= mod:NewCDTimer(19, 137162, mod:IsTank())
local timerThrowCD					= mod:NewCDTimer(26, 137175)--90-93 variable (26-30 seconds after storm. verified in well over 50 logs)
local timerStorm					= mod:NewBuffActiveTimer(17, 137313)--2 second cast, 15 second duration
local timerStormCD					= mod:NewCDTimer(60.5, 137313)--90-93 variable (60.5~67 seconds after throw)
local timerIonization				= mod:NewBuffFadesTimer(24, 138732)
local timerIonizationCD				= mod:NewNextTimer(61.5, 138732)
-- BH ADD
local specWarnLightningCrack			= mod:NewSpecialWarningMove(137485)
local specWarnJSA				= mod:NewSpecialWarning("SpecWarnJSA")
local stormcount = 0
-- BH ADD END

-- BH DELETE local soundFocusedLightning			= mod:NewSound(137422)

local berserkTimer					= mod:NewBerserkTimer(540)

-- BH DELETE local countdownIonization			= mod:NewCountdown(61.5, 138732)

mod:AddBoolOption("RangeFrame")
local scanFailed = false
-- BH ADD
local focusme = false
local inoizame = false
mod:AddBoolOption("SoundWOPIonM", false, "sound")
for i = 1, 4 do
	mod:AddBoolOption("dr"..i, false, "sound")
end
local function MyJS1()
	if (mod.Options.dr1 and stormcount %2 == 1) or (mod.Options.dr3 and stormcount %2 == 0) then
		return true
	end
	return false
end
local function MyJS2()
	if (mod.Options.dr2 and stormcount %2 == 1) or (mod.Options.dr4 and stormcount %2 == 0) then
		return true
	end
	return false
end
-- BH ADD END

function mod:FocusedLightningTarget(targetname, uId)
	if not targetname then return end
	if self:IsTanking(uId, "boss1") then--Focused Lightning never target tanks, so if target is tank, that means scanning failed.
		scanFailed = true
	else
		warnFocusedLightning:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	scanFailed = false
	timerFocusedLightningCD:Start(8-delay)
	timerStaticBurstCD:Start(13-delay)
	timerThrowCD:Start(30-delay)
	-- BH ADD
	focusme = false
	inoizame = false
	stormcount = 0
	if self:IsDifficulty("heroic10", "heroic25") then
		timerIonizationCD:Start(60-delay)
--BH DELETE	countdownIonization:Start(60-delay)
		berserkTimer:Start(360-delay)
		sndIonCD:Schedule(56, DBM.SoundMMPath.."\\ex_tt_dlzb.ogg")
		sndIonCD:Schedule(57, DBM.SoundMMPath.."\\countfour.ogg")
		sndIonCD:Schedule(58, DBM.SoundMMPath.."\\countthree.ogg")
		sndIonCD:Schedule(59, DBM.SoundMMPath.."\\counttwo.ogg")
		sndIonCD:Schedule(60, DBM.SoundMMPath.."\\countone.ogg")
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 137399 then
		self:BossTargetScanner(69465, "FocusedLightningTarget", 0.025, 12)
		timerFocusedLightningCD:Start()
	elseif args.spellId == 137313 then
		warnStorm:Show()
--BH DELETE	specWarnStorm:Show()
		timerStorm:Start()
		timerStaticBurstCD:Start(20.5)
		timerThrowCD:Start()
		--BH ADD
		sndWOP:Cancel(DBM.SoundMMPath.."\\ex_tt_sdfbzb.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\countfour.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		stormcount = stormcount + 1
		if stormcount == 1 then
			sndWOP:Schedule(1, DBM.SoundMMPath.."\\countone.ogg")
		elseif stormcount == 2 then
			sndWOP:Schedule(1, DBM.SoundMMPath.."\\counttwo.ogg")
		elseif stormcount == 3 then
			sndWOP:Schedule(1, DBM.SoundMMPath.."\\countthree.ogg")
		elseif stormcount == 4 then
			sndWOP:Schedule(1, DBM.SoundMMPath.."\\countfour.ogg")
		end
		if MyJS1() then
			specWarnJSA:Show()
			sndWOP:Play(DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
		else
			specWarnStorm:Show()
			sndWOP:Play(DBM.SoundMMPath.."\\lightstorm.ogg") --閃電風暴
		end
		if MyJS2() then
			specWarnJSA:Schedule(5)
			sndWOP:Schedule(5, DBM.SoundMMPath.."\\defensive.ogg")
		end		
		sndWOP:Schedule(15, DBM.SoundMMPath.."\\ex_tt_fbjs.ogg") --風暴結束
		--BH ADD END		
		if self:IsDifficulty("heroic10", "heroic25") then
			timerIonizationCD:Start()
--BH DELETE		countdownIonization:Start()
			sndIonCD:Schedule(56, DBM.SoundMMPath.."\\ex_tt_dlzb.ogg")
			sndIonCD:Schedule(57, DBM.SoundMMPath.."\\countfour.ogg")
			sndIonCD:Schedule(58, DBM.SoundMMPath.."\\countthree.ogg")
			sndIonCD:Schedule(59, DBM.SoundMMPath.."\\counttwo.ogg")
			sndIonCD:Schedule(60, DBM.SoundMMPath.."\\countone.ogg")
		end
	elseif args.spellId == 138732 then
		warnIonization:Show()
		specWarnIonization:Show()
		if timerStaticBurstCD:GetTime() == 0 or timerStaticBurstCD:GetTime() > 10 then--Static Burst will be delayed
			timerStaticBurstCD:Start(12)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 137162 then
		timerStaticBurstCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 137162 then
		warnStaticBurst:Show(args.destName)
		if args:IsPlayer() then
			specWarnStaticBurst:Show()
		else
			specWarnStaticBurstOther:Show(args.destName)
		end
		if mod:IsTank() then
			sndWOP:Play(DBM.SoundMMPath.."\\changemt.ogg") --換坦嘲諷
		end
	elseif args.spellId == 137422 and scanFailed then--Use cleu target if scanning is failed (slower than target scanning)
		scanFailed = false
		self:FocusedLightningTarget(args.destName)
	elseif args.spellId == 138732 and args:IsPlayer() then
		timerIonization:Start()
		--BH MODIFY
		if self.Options.RangeFrame then
			if self:IsDifficulty("heroic25") then
				DBM.RangeCheck:Show(4)
			else
				DBM.RangeCheck:Show(8)
			end
		end
		inoizame = true
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_dlzh.ogg") --電離子化
		if self.Options.SoundWOPIonM then
			self:Schedule(7, function() DBM.Flash:Shake(1, 0, 0) end)
			self:Schedule(7.5, function() DBM.Flash:Shake(0, 0, 1) end)
			self:Schedule(8, function() DBM.Flash:Shake(1, 0, 0) end)
			sndIon:Schedule(7, DBM.SoundMMPath.."\\runout.ogg")
			sndIon:Schedule(8, DBM.SoundMMPath.."\\runout.ogg")
		else			
			self:Schedule(16, function()
				if UnitDebuff("player", GetSpellInfo(138732)) then
					DBM.Flash:Shake(1, 0, 0)
					self:Schedule(0.5, function() DBM.Flash:Shake(0, 0, 1) end)
					self:Schedule(1, function() DBM.Flash:Shake(1, 0, 0) end)
				end
			 end)
			sndIon:Schedule(16, DBM.SoundMMPath.."\\runout.ogg")	--離開人群
			sndIon:Schedule(17, DBM.SoundMMPath.."\\runout.ogg")
			sndIon:Schedule(18.5, DBM.SoundMMPath.."\\countsix.ogg")
			sndIon:Schedule(19.5, DBM.SoundMMPath.."\\countfive.ogg")
			sndIon:Schedule(20.5, DBM.SoundMMPath.."\\countfour.ogg")
			sndIon:Schedule(21.5, DBM.SoundMMPath.."\\countthree.ogg")
			sndIon:Schedule(22.5, DBM.SoundMMPath.."\\counttwo.ogg")
			sndIon:Schedule(23.5, DBM.SoundMMPath.."\\countone.ogg")
		end
		--BH MODIFY END
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 138732 and args:IsPlayer() then
		--BH MODIFY
		timerIonization:Cancel()
		inoizame = false
		if self.Options.RangeFrame then
			if focusme then
				DBM.RangeCheck:Show(8)
			else
				DBM.RangeCheck:Hide()
			end
		end
		sndIon:Cancel(DBM.SoundMMPath.."\\runout.ogg")
		sndIon:Cancel(DBM.SoundMMPath.."\\countseven.ogg")
		sndIon:Cancel(DBM.SoundMMPath.."\\countsix.ogg")
		sndIon:Cancel(DBM.SoundMMPath.."\\countfive.ogg")
		sndIon:Cancel(DBM.SoundMMPath.."\\countfour.ogg")
		sndIon:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndIon:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndIon:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		sndIon:Play(DBM.SoundMMPath.."\\safenow.ogg")
	elseif args.spellId == 137422 and args:IsPlayer() then
		focusme = false
		if self.Options.RangeFrame then
			if inoizame then
				if self:IsDifficulty("heroic25") then
					DBM.RangeCheck:Show(4)
				else
					DBM.RangeCheck:Show(8)
				end
			else
				DBM.RangeCheck:Hide()
			end
		end
		--BH MODIFY END
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg") --快躲開
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--BH ADD
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 137485 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnLightningCrack:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg") --快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--BH ADD END

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetUnitFullName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_lttz.ogg") --雷霆投擲
		sndWOP:Schedule(55, DBM.SoundMMPath.."\\ex_tt_sdfbzb.ogg") -- 閃電風暴準備
		sndWOP:Schedule(56.5, DBM.SoundMMPath.."\\countfour.ogg")
		sndWOP:Schedule(57.5, DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Schedule(58.5, DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Schedule(59.5, DBM.SoundMMPath.."\\countone.ogg")
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end

--"<294.8 20:14:02> [RAID_BOSS_WHISPER] RAID_BOSS_WHISPER#|TInterface\\Icons\\ability_vehicle_electrocharge:20|t%s's |cFFFF0000|Hspell:137422|h[Focused Lightning]|h|r fixates on you. Run!#Jin'rokh the Breaker#0#false", -- [12425]
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:137422") then--In case target scanning fails, personal warnings still always go off. Target scanning is just so everyone else in raid knows who it's on (since only target sees this emote)
		specWarnFocusedLightning:Show()
		yellFocusedLightning:Yell()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		focusme = true
		DBM.Flash:Shake(1, 0, 0)
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sddn.ogg") --閃電點你
	end
end