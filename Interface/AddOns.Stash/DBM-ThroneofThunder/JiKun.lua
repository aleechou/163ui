local mod	= DBM:NewMod(828, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
-- BH ADD
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndWOPWS	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9790 $"):sub(12, -3))
mod:SetCreatureID(69712)
mod:SetQuestID(32749)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnCaws				= mod:NewSpellAnnounce(138923, 2)
local warnQuills			= mod:NewCountAnnounce(134380, 4)
local warnFlock				= mod:NewAnnounce("warnFlock", 3, 15746)--Some random egg icon
local warnLayEgg			= mod:NewSpellAnnounce(134367, 3)
local warnTalonRake			= mod:NewStackAnnounce(134366, 3, nil, mod:IsTank() or mod:IsHealer())
local warnDowndraft			= mod:NewSpellAnnounce(134370, 3)
local warnFeedYoung			= mod:NewSpellAnnounce(137528, 3)--No Cd because it variable based on triggering from eggs, it's cast when one of young call out and this varies too much

local specWarnQuills		= mod:NewSpecialWarningSpell(134380, nil, nil, nil, 2)
-- BH MODIFY
local specWarnFlock			= mod:NewSpecialWarning("specWarnFlock")--For those assigned in egg/bird killing group to enable on their own (and tank on heroic)
local specWarnTalonRake		= mod:NewSpecialWarningStack(134366, mod:IsTank(), 2)--Might change to 2 if blizz fixes timing issues with it
local specWarnTalonRakeOther= mod:NewSpecialWarningTarget(134366, mod:IsTank())
local specWarnDowndraft		= mod:NewSpecialWarningSpell(134370, nil, nil, nil, 2)
local specWarnFeedYoung		= mod:NewSpecialWarningSpell(137528)
local specWarnBigBird		= mod:NewSpecialWarningSwitch("ej7827", mod:IsTank())
local specWarnFly			= mod:NewSpecialWarningYou(134339)

local timerCawsCD			= mod:NewCDTimer(15, 138923)--Variable beyond usefulness. anywhere from 18 second cd and 50.
local timerQuills			= mod:NewBuffActiveTimer(10, 134380)
local timerQuillsCD			= mod:NewCDCountTimer(62.5, 134380)--variable because he has two other channeled abilities with different cds, so this is cast every 62.5-67 seconds usually after channel of some other spell ends
local timerFlockCD	 		= mod:NewTimer(30, "timerFlockCD", 15746)
local timerFeedYoungCD	 	= mod:NewCDTimer(30, 137528)--30-40 seconds (always 30 unless delayed by other channeled spells)
local timerTalonRakeCD		= mod:NewCDTimer(20, 134366, mod:IsTank() or mod:IsHealer())--20-30 second variation
local timerTalonRake		= mod:NewTargetTimer(60, 134366, mod:IsTank() or mod:IsHealer())
local timerDowndraft		= mod:NewBuffActiveTimer(10, 134370)
local timerDowndraftCD		= mod:NewCDTimer(97, 134370)
local timerFlight			= mod:NewBuffFadesTimer(10, 133755)
local timerPrimalNutriment	= mod:NewBuffFadesTimer(30, 140741)

mod:AddBoolOption("RangeFrame", mod:IsRanged())

local flockC = 0
local lastFlock = 0
local quillsCount = 0
local FeedCount = 0
local trippleNest = false
local flockName = EJ_GetSectionInfo(7348)

local flockCount = 0
local myGroup = nil
local wstime = 0
mod:AddBoolOption("HudMAP", mod:IsRanged(), "sound")
mod:AddBoolOption("HudMAPMe", false, "sound")
for i = 1, 36 do
	mod:AddBoolOption("add"..i, false, "sound")
end
for i = 1, 7 do
	mod:AddBoolOption("dr"..i, false, "sound")
end

local function MyJS()
	if (mod.Options.dr1 and quillsCount == 1) or (mod.Options.dr2 and quillsCount == 2) or (mod.Options.dr3 and quillsCount == 3) or (mod.Options.dr4 and quillsCount == 4) or (mod.Options.dr5 and quillsCount == 5) or (mod.Options.dr6 and quillsCount == 6) or (mod.Options.dr7 and quillsCount == 7) then
		return true
	end
	return false
end


local function MyAddDown(flockwave)
	if (flockwave == 2 and mod.Options.add2) or (flockwave == 3 and mod.Options.add3) or (flockwave == 4 and mod.Options.add5) or (flockwave == 5 and mod.Options.add7) or (flockwave == 7 and mod.Options.add10) or (flockwave == 8 and mod.Options.add12) or (flockwave == 9 and mod.Options.add14) or (flockwave == 10 and mod.Options.add16) or (flockwave == 11 and mod.Options.add18) or (flockwave == 12 and mod.Options.add20) or (flockwave == 13 and mod.Options.add22) or (flockwave == 14 and mod.Options.add24) or (flockwave == 15 and mod.Options.add26) or (flockwave == 16 and mod.Options.add28) or (flockwave == 17 and mod.Options.add30) or (flockwave == 18 and mod.Options.add32) or (flockwave == 19 and mod.Options.add34) or (flockwave == 20 and mod.Options.add36) then
		return true
	end
	return false
end
local function MyAddUp(flockwave)
	if (flockwave == 4 and mod.Options.add4) or (flockwave == 5 and mod.Options.add6) or (flockwave == 6 and mod.Options.add8) or (flockwave == 7 and mod.Options.add9) or (flockwave == 8 and mod.Options.add11) or (flockwave == 9 and mod.Options.add13) or (flockwave == 10 and mod.Options.add15) or (flockwave == 11 and mod.Options.add17) or (flockwave == 12 and mod.Options.add19) or (flockwave == 13 and mod.Options.add21) or (flockwave == 14 and mod.Options.add23) or (flockwave == 15 and mod.Options.add25) or (flockwave == 16 and mod.Options.add27) or (flockwave == 17 and mod.Options.add29) or (flockwave == 18 and mod.Options.add31) or (flockwave == 19 and mod.Options.add33) or (flockwave == 20 and mod.Options.add35) then
		return true
	end
	return false
end
local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local FireMarkers = {}

function mod:OnCombatStart(delay)
	flockC = 0
	quillsCount = 0
	FeedCount = 0
	trippleNest = false
	-- BH ADD
	flockCount = 0
	wstime = 0
	-- BH ADD END
	if self:IsDifficulty("normal10", "heroic10", "lfr25") then
		timerQuillsCD:Start(60-delay, 1)
	else
		timerQuillsCD:Start(42.5-delay, 1)
	end
	timerDowndraftCD:Start(91-delay)
	timerCawsCD:Start(15-delay)
	sndWOP:Schedule(85, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xjzb.mp3")
	sndWOP:Schedule(87, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
	sndWOP:Schedule(88, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
	sndWOP:Schedule(89, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
	sndWOP:Schedule(90, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 134366 then
		local amount = args.amount or 1
		warnTalonRake:Show(args.destName, amount)
		timerTalonRake:Start(args.destName)
		timerTalonRakeCD:Start()
		if args:IsPlayer() then
			if amount >= 2 then
				specWarnTalonRake:Show(amount)
			end
		else
			if amount >= 1 and not UnitDebuff("player", GetSpellInfo(134366)) and not UnitIsDeadOrGhost("player") then
				specWarnTalonRakeOther:Show(args.destName)
				if mod:IsTank() then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\changemt.mp3") --換坦嘲諷
				end
			end
		end
	elseif args.spellId == 137528 then
		warnFeedYoung:Show()
		specWarnFeedYoung:Show()
		FeedCount = FeedCount + 1
		wstime = GetTime()
		sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_zbws.mp3")
		sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		sndWOPWS:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_wsyc.mp3") --餵食	
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			timerFeedYoungCD:Start(40)
			sndWOPWS:Schedule(36, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_zbws.mp3")
			sndWOPWS:Schedule(37.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOPWS:Schedule(38.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOPWS:Schedule(39.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		else
			timerFeedYoungCD:Start()
			sndWOPWS:Schedule(25, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_zbws.mp3")
			sndWOPWS:Schedule(27.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOPWS:Schedule(28.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOPWS:Schedule(29.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	elseif args.spellId == 133755 and args:IsPlayer() then
		timerFlight:Start()
	elseif args.spellId == 140741 and args:IsPlayer() then
		timerPrimalNutriment:Start()
	elseif args.spellId == 134339 and args:IsPlayer() then
		specWarnFly:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 134366 then
		timerTalonRake:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138923 then
		if mod.Options.HudMAP then
			for i = 1, DBM:GetNumGroupMembers() do
				if UnitName("raid"..i) ~= UnitName("player") then
					local _, class = UnitClass("raid"..i)
					if (class == "DRUID" and UnitPowerMax("raid"..i) > 200000) or class == "HUNTER" or class == "PRIEST" or class == "MAGE" or class == "WARLOCK" or (class == "SHAMAN" and UnitPowerMax("raid"..i) > 200000) or (class == "PALADIN" and UnitPowerMax("raid"..i) > 200000) then
						FireMarkers[UnitName("raid"..i)] = register(DBMHudMap:PlaceStaticMarkerOnPartyMember("highlight", UnitName("raid"..i), 10, 3, 1, 1 ,1 ,0.8):Appear():RegisterForAlerts())
					end
				end
			end
		end
		if mod.Options.HudMAPMe then
			if mod:IsRanged() then
				FireMarkers[UnitName("player")] = register(DBMHudMap:PlaceStaticMarkerOnPartyMember("highlight", UnitName("player"), 10, 3, 1, 1 ,1 ,0.8):Appear():RegisterForAlerts())
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 134380 then
		quillsCount = quillsCount + 1
		warnQuills:Show(quillsCount)
		specWarnQuills:Show()
		timerQuills:Start()
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			timerQuillsCD:Start(81, quillsCount+1)--81 sec normal, sometimes 91s?
		else
			timerQuillsCD:Start(nil, quillsCount+1)
		end
		if MyJS() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
		else
			if mod:IsHealer() then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\healall.mp3") --注意群療
			else
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
			end
		end		
	elseif args.spellId == 134370 then
		warnDowndraft:Show()
		specWarnDowndraft:Show()
		timerDowndraft:Start()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xjzb.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			if GetTime() - wstime > 35 then
				sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			end
		else
			if GetTime() - wstime > 25 then
				sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOPWS:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			end
		end
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xjql.mp3") --下降氣流		
		if self:IsDifficulty("heroic10", "heroic25") then
			timerDowndraftCD:Start(93)
			sndWOP:Schedule(87, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xjzb.mp3") --下降氣流準備
			sndWOP:Schedule(88, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(89, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(90, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(91, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(92, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		else
			timerDowndraftCD:Start()--Todo, confirm they didn't just change normal to 90 as well. in my normal logs this had a 110 second cd on normal
			sndWOP:Schedule(90, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xjzb.mp3")
			sndWOP:Schedule(91, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(92, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
			sndWOP:Schedule(93, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(94, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(95, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	elseif args.spellId == 134380 and self:AntiSpam(2, 1) then--Maybe adjust anti spam a bit or find a different way to go about this. It is important information though.
		warnLayEgg:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:138923") then--Caws (does not show in combat log, like a lot of stuff this tier) Fortunately easy to detect this way without localizing
		warnCaws:Show()
		timerCawsCD:Start(18)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg:find(L.eggsHatchL) or msg:find(L.eggsHatchU) then
		if self:AntiSpam(5, 2) then
			flockCount = flockCount + 1
			if MyAddDown(flockCount+1) then
				if self:IsDifficulty("normal10", "heroic10", "lfr25") then
					self:Schedule(34, function()
						DBM.Flash:Shake(1, 0, 0)
					end)
					specWarnFlock:Schedule(34, L.Lower, flockName, flockCount+1)
					sndWOP:Schedule(34, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xfxg.mp3")
					sndWOP:Schedule(40, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_ddfh.mp3")
				else
					self:Schedule(24, function()
						DBM.Flash:Shake(1, 0, 0)
					end)
					specWarnFlock:Schedule(24, L.Lower, flockName, flockCount+1)
					sndWOP:Schedule(24, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xfxg.mp3")
					sndWOP:Schedule(30, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_ddfh.mp3")
				end
			end
			if MyAddUp(flockCount+1) then
				if self:IsDifficulty("normal10", "heroic10", "lfr25") then
					self:Schedule(34, function()
						DBM.Flash:Shake(1, 0, 0)
					end)
					specWarnFlock:Schedule(34, L.Upper, flockName, flockCount+1)
					sndWOP:Schedule(34, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_sfxg.mp3")
					sndWOP:Schedule(40, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_ddfh.mp3")
				else
					self:Schedule(24, function()
						DBM.Flash:Shake(1, 0, 0)
					end)
					specWarnFlock:Schedule(24, L.Upper, flockName, flockCount+1)
					sndWOP:Schedule(24, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_sfxg.mp3")
					sndWOP:Schedule(30, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_ddfh.mp3")
				end
			end
		end
		flockC = flockC + 1
		local messageText = msg:find(L.eggsHatchL) and L.Lower or L.Upper
		local flockText = tostring(flockC)
		if GetTime() - lastFlock < 5 then--On 25 man, you get two at same time sometimes, we detect that here and revise message
			messageText = L.UpperAndLower
			flockText = tostring(flockC - 1)..", "..tostring(flockC)
			if trippleNest then--If this is true it means we had a 2nd nest message already and this is a 3rd nest message
				flockText = tostring(flockC - 2)..", "..tostring(flockC - 1)..", "..tostring(flockC)
				if flockC == 24 or flockC == 29 then
					messageText = L.TrippleU
				else
					messageText = L.TrippleD
				end
			end
			trippleNest = true--This will be set to true on 2nd nest message
		else
			trippleNest = false--We reset variable cause it's obviously a first nest message
		end
		warnFlock:Cancel()
--BH DELETE	specWarnFlock:Cancel()
		timerFlockCD:Cancel()--So we don't get two timers on the double nests on 25 man
		warnFlock:Schedule(0.5, messageText, flockName, flockText)
--BH DELETE	specWarnFlock:Schedule(0.5, messageText, flockName, flockText)
		--10N/10H/LFR: L, L, L, U, U, U (Repeating)
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			if flockC == 1 or flockC == 2 or flockC == 6 or flockC == 7 or flockC == 8 or flockC == 12 or flockC == 13 or flockC == 14 or flockC == 18 or flockC == 19 or flockC == 20 or flockC == 24 or flockC == 25 or flockC == 26 or flockC == 30 or flockC == 31 or flockC == 32 then--Lower is next
				timerFlockCD:Show(40, flockCount+1, L.Lower)
			elseif flockC == 3 or flockC == 4 or flockC == 5 or flockC == 9 or flockC == 10 or flockC == 11 or flockC == 15 or flockC == 16 or flockC == 17 or flockC == 21 or flockC == 22 or flockC == 23 or flockC == 27 or flockC == 28 or flockC == 29 or flockC == 33 or flockC == 34 or flockC == 35 then--Upper is next
				timerFlockCD:Show(40, flockCount+1, L.Upper)
			else--Logic Failsafe, if we don't know what next one is we just say unknown and at least start a timer
				timerFlockCD:Show(40, flockCount+1, DBM_CORE_UNKNOWN)
			end
		--25N: Lower (1), Lower (2), Lower (3), Lower (4), Lower & Upper (5+6), Upper (7), Upper (8), Lower & Upper (9+10), Lower & Upper (11+12), Lower (13), Lower (14), Lower & Upper (15+16), Upper (17), Lower & Upper (18+19), Lower & Upper (20+21), Lower & Upper (22+23), Lower (24), Lower & Upper (25+26), Lower & Upper (27+28)
		elseif self:IsDifficulty("normal25") then
			if flockC == 1 or flockC == 2 or flockC == 3 or flockC == 12 or flockC == 13 or flockC == 23 then--Lower is next
				timerFlockCD:Show(30, flockCount+1, L.Lower)
			elseif flockC == 6 or flockC == 7 or flockC == 16 then--Upper is next
				timerFlockCD:Show(30, flockCount+1, L.Upper)
			elseif flockC == 4 or flockC == 8 or flockC == 10 or flockC == 14 or flockC == 17 or flockC == 19 or flockC == 21 or flockC == 24 or flockC == 26 then--Both are next
				timerFlockCD:Show(30, flockCount+1, L.UpperAndLower)
			else--Logic Failsafe, if we don't know what next one is we just say unknown and at least start a timer
				timerFlockCD:Show(30, flockCount+1, DBM_CORE_UNKNOWN)
			end
		--25H: Lower (1), Lower (2), Lower (3), Lower & Upper (4, 5), Lower & Upper (6, 7), Upper (8), Upper & Lower (9, 10), Upper & Lower (11, 12), Lower (13), Upper & Lower (14, 15), Upper & Lower (16, 17), Upper & Lower (18, 19), Upper & Lower (20, 21), Upper & Lower & Upper (22, 23, 24), Upper & Lower (25, 26), Lower & Upper & Lower (27, 28, 29), Upper & Lower & Upper (30, 31, 32), Lower & Upper (33, 34), Lower & Upper & Lower (35, 36, 37)
		elseif self:IsDifficulty("heroic25") then
			if flockC == 1 or flockC == 2 or flockC == 12 then--Lower is next
				timerFlockCD:Show(30, flockCount+1, L.Lower)
			elseif flockC == 7 then--Upper is next
				timerFlockCD:Show(30, flockCount+1, L.Upper)
			elseif flockC == 3 or flockC == 5 or flockC == 8 or flockC == 10 or flockC == 13 or flockC == 15 or flockC == 17 or flockC == 19 or flockC == 24 or flockC == 32 then--Both are next
				timerFlockCD:Show(30, flockCount+1, L.UpperAndLower)
			elseif flockC == 21 or flockC == 29 then--Tripple is next (2 upper 1 lower)
				timerFlockCD:Show(30, flockCount+1, L.TrippleU)
			elseif flockC == 26 or flockC == 34 then--Tripple is next (2 lower 1 upper)
				timerFlockCD:Show(30, flockCount+1, L.TrippleD)
			else--Logic Failsafe, if we don't know what next one is we just say unknown and at least start a timer
				timerFlockCD:Show(30, flockCount+1, DBM_CORE_UNKNOWN)
			end
		else--Shouldn't be an else, but just failsafe code
			timerFlockCD:Show(30, flockCount+1, DBM_CORE_UNKNOWN)
		end
		lastFlock = GetTime()
		if self:IsDifficulty("heroic10") and (flockC == 2 or flockC == 4 or flockC == 8 or flockC == 12 or flockC == 14) or self:IsDifficulty("heroic25") and (flockC == 2 or flockC == 6 or flockC == 12 or flockC == 16 or flockC == 23) then--TODO, nest 12/16 are upper, all others on 25H are lower.
			specWarnBigBird:Show()
		end
	end
end