local mod	= DBM:NewMod(332, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7599 $"):sub(12, -3))
mod:SetCreatureID(56598)
mod:SetMainBossID(56427)
mod:SetModelID(39399)
mod:SetModelSound("sound\\CREATURE\\WarmasterBlackhorn\\VO_DS_BLACKHORN_INTRO_01.OGG", "sound\\CREATURE\\WarmasterBlackhorn\\VO_DS_BLACKHORN_SLAY_01.OGG")
mod:SetZone()
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")
mod:SetMinCombatTime(20)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_EMOTE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnDrakesLeft				= mod:NewAddsLeftAnnounce("ej4192", 2, 61248)
local warnHarpoon					= mod:NewTargetAnnounce(108038, 2)
local warnReloading					= mod:NewCastAnnounce(108039, 2)
local warnTwilightOnslaught			= mod:NewCountAnnounce(107588, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 3)
local warnRoar						= mod:NewSpellAnnounce(108044, 2)
local warnTwilightFlames			= mod:NewSpellAnnounce(108051, 3)
local warnTwilightBreath			= mod:NewSpellAnnounce(110212, 3)
local warnShockwave					= mod:NewTargetAnnounce(108046, 4)
local warnSunder					= mod:NewStackAnnounce(108043, 3, nil, mod:IsTank() or mod:IsHealer())
local warnConsumingShroud			= mod:NewTargetAnnounce(110214, 3)

local specWarnHarpoon				= mod:NewSpecialWarningTarget(108038, false)
local specWarnTwilightOnslaught		= mod:NewSpecialWarningSpell(107588, nil, nil, nil, true)
local specWarnSapper				= mod:NewSpecialWarningSwitch("ej4200", mod:IsDps())
local specWarnDeckFireCast			= mod:NewSpecialWarningSpell(110095, false, nil, nil, true)
local specWarnDeckFire				= mod:NewSpecialWarningMove(110095)
local specWarnElites				= mod:NewSpecialWarning("SpecWarnElites", mod:IsTank())
local specWarnShockwave				= mod:NewSpecialWarningMove(108046)
local specWarnShockwaveOther		= mod:NewSpecialWarningTarget(108046, false)
local specWarnTwilightFlames		= mod:NewSpecialWarningMove(108076)
local yellShockwave					= mod:NewYell(108046)
local specWarnSunder				= mod:NewSpecialWarningStack(108043, mod:IsTank() or mod:IsHealer(), 3)
local specWarnTwilightBreath   = mod:NewSpecialWarningSpell(110212)

local timerCombatStart				= mod:NewTimer(20.5, "TimerCombatStart", 2457)
local timerAdd						= mod:NewTimer(61, "TimerAdd", 107752)
local timerHarpoonCD				= mod:NewCDTimer(6.5, 108038, nil, mod:IsDps())
local timerHarpoonActive			= mod:NewBuffActiveTimer(20, 108038, nil, mod:IsDps())
local timerReloadingCast			= mod:NewCastTimer(10, 108039, nil, mod:IsDps())
local timerTwilightOnslaught		= mod:NewCastTimer(7, 107588)
local timerTwilightOnslaughtCD		= mod:NewNextCountTimer(35, 107588)
local timerSapperCD					= mod:NewNextTimer(40, "ej4200", nil, nil, nil, 107752)
local timerRoarCD					= mod:NewCDTimer(18.5, 108044)--18.5~24 variables
local timerTwilightFlamesCD			= mod:NewNextTimer(8, 108051)
local timerShockwaveCD				= mod:NewCDTimer(23, 108046)
local timerSunder					= mod:NewTargetTimer(30, 108043, nil, false)
local timerBladeRushCD				= mod:NewCDTimer(15.5, 107595)
local timerBroadsideCD				= mod:NewNextTimer(90, 110153)
local timerConsumingShroud					= mod:NewCDTimer(30, 110214)
local timerTwilightBreath					= mod:NewCDTimer(20, 110212)

local berserkTimer					= mod:NewBerserkTimer(240)

local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:AddBoolOption("SetIconOnConsumingShroud", true)
mod:AddBoolOption("SetIconOnShockwave", true)
mod:AddBoolOption("holditslaught1", false)
mod:AddBoolOption("holditslaught2", false)
mod:AddBoolOption("holditslaught3", false)
mod:AddBoolOption("holditslaught4", false)
mod:AddBoolOption("holditslaught5", false)
mod:AddBoolOption("SetTextures", false)

local phase2Started = false
local addsCount = 0
local drakesCount = 6
local twilightOnslaughtCount = 0
local CVAR = false

local function Phase2Delay()
	mod:UnscheduleMethod("AddsRepeat")
	timerSapperCD:Cancel()
	timerRoarCD:Start(10)
	sndWOP:Schedule(8, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\roarsoon.mp3")
	timerTwilightFlamesCD:Start(12)
	timerShockwaveCD:Start(13)
	sndWOP:Schedule(10, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\wavesoon.mp3")
	if mod:IsDifficulty("heroic10", "heroic25") then
		timerConsumingShroud:Start(45)
	end
	if not mod:IsDifficulty("lfr25") then
		berserkTimer:Start()
	end
	if mod.Options.SetTextures and not GetCVarBool("projectedTextures") and CVAR then
		SetCVar("projectedTextures", 1)
	end
end

function mod:ShockwaveTarget()
	local targetname = self:GetBossTarget(56427)
	if not targetname then return end
	warnShockwave:Show(targetname)
	if self.Options.SetIconOnShockwave then
		self:SetIcon(targetname, 8, 3)
	end	
	if targetname == UnitName("player") then
		specWarnShockwave:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
		yellShockwave:Yell()
	else
		specWarnShockwaveOther:Show(targetname)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\watchwave.mp3")
	end
end

function mod:AddsRepeat()
	if addsCount < 2 then
		addsCount = addsCount + 1
		timerAdd:Start()
		self:ScheduleMethod(61, "AddsRepeat")
	end
	specWarnElites:Show()
	if addsCount == 1 then
		timerHarpoonCD:Start(18)
	else
		timerHarpoonCD:Start()
	end
end

function mod:OnCombatStart(delay)
	phase2Started = false
	addsCount = 0
	drakesCount = 6
	twilightOnslaughtCount = 0
	CVAR = false
	timerCombatStart:Start(-delay)
	timerAdd:Start(22.8-delay)
	self:ScheduleMethod(22.8-delay, "AddsRepeat")
	if not self:IsDifficulty("lfr25") then
		timerSapperCD:Start(69-delay)
	end
	timerTwilightOnslaughtCD:Start(48-delay, 1)
	sndWOP:Schedule(44-delay, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\purplecirclesoon.mp3")
	if self:IsDifficulty("heroic10", "heroic25") then
		timerBroadsideCD:Start(57-delay)
	end
	if DBM.BossHealth:IsShown() then
		local shipname = EJ_GetSectionInfo(4202)
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(56598, shipname)
	end
	if self.Options.SetTextures and GetCVarBool("projectedTextures") then
		CVAR = true
		SetCVar("projectedTextures", 0)
	end
end

function mod:OnCombatEnd()
	if self.Options.SetTextures and not GetCVarBool("projectedTextures") and CVAR then
		SetCVar("projectedTextures", 1)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107588) then
		twilightOnslaughtCount = twilightOnslaughtCount + 1
		warnTwilightOnslaught:Show(twilightOnslaughtCount)
		specWarnTwilightOnslaught:Show()
		timerTwilightOnslaught:Start()
		if twilightOnslaughtCount == 1 and self.Options.holditslaught1 then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\holdit.mp3")
		elseif twilightOnslaughtCount == 2 and self.Options.holditslaught2 then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\holdit.mp3")
		elseif twilightOnslaughtCount == 3 and self.Options.holditslaught3 then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\holdit.mp3")
		elseif twilightOnslaughtCount == 4 and self.Options.holditslaught4 then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\holdit.mp3")
		elseif twilightOnslaughtCount == 5 and self.Options.holditslaught5 then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\holdit.mp3")
		else
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\stackpurple.mp3")
		end
		timerTwilightOnslaughtCD:Start(35, twilightOnslaughtCount+1)
		sndWOP:Schedule(31, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\purplecirclesoon.mp3")
	elseif args:IsSpellID(108046) then
		self:ScheduleMethod(0.2, "ShockwaveTarget")
		timerShockwaveCD:Start()
		sndWOP:Schedule(20, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\wavesoon.mp3")
	elseif args:IsSpellID(110212, 110213) then
		warnTwilightBreath:Show()
		specWarnTwilightBreath:Show()
		timerTwilightBreath:Start()
	elseif args:IsSpellID(108039) then
		warnReloading:Show()
		timerReloadingCast:Start(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(108044, 109228, 109229, 109230) then
		warnRoar:Show()
		timerRoarCD:Start()
		sndWOP:Schedule(17, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\roarsoon.mp3")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(108043) then
		warnSunder:Show(args.destName, args.amount or 1)
		timerSunder:Start(args.destName)
		if (args.amount or 0) >= 3 then
			specWarnSunder:Show(args.amount)
		end
	elseif args:IsSpellID(108038) then
		if self:AntiSpam(5, 1) then -- Use time check for harpooning warning. It can be avoid bad casts also.
			warnHarpoon:Show(args.destName)
			specWarnHarpoon:Show(args.destName)
		end
		-- Timer not use time check. 2 harpoons cast same time even not bugged.
		if self:IsDifficulty("heroic10", "heroic25") then
			timerHarpoonActive:Start(nil, args.destGUID)
		elseif self:IsDifficulty("normal10", "normal25") then
			timerHarpoonActive:Start(25, args.destGUID)
		end
	elseif args:IsSpellID(108040) and not phase2Started then
		timerTwilightOnslaughtCD:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\purplecirclesoon.mp3")
		timerBroadsideCD:Cancel()
		self:Schedule(10, Phase2Delay)
		phase2Started = true
		warnPhase2:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")
		timerCombatStart:Start(8)
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(56427, L.name)
		end
	elseif args:IsSpellID(110214, 110598) then
		warnConsumingShroud:Show(args.destName)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\shroud.mp3")
		timerConsumingShroud:Start()
		if self.Options.SetIconOnConsumingShroud then
			self:SetIcon(args.destName, 7)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(108043) then
		if self:IsTank() or self:IsHealer() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\changemt.mp3")
		end
	elseif args:IsSpellID(110214) then
		if self.Options.SetIconOnConsumingShroud then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(108051, 109216, 109217, 109218) then
		warnTwilightFlames:Show()
		timerTwilightFlamesCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 108076 or spellId == 109222 or spellId == 109223 or spellId == 109224) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnTwilightFlames:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	elseif spellId == 110095 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnDeckFire:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.SapperEmote or msg:find(L.SapperEmote) then
		specWarnSapper:Show()
		if not phase2Started then
			timerSapperCD:Start()
		end
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\goblinappear.mp3")
	elseif msg == L.DeckFire or msg:find(L.DeckFire) then
		specWarnDeckFireCast:Show()
	elseif msg == L.Broadside or msg:find(L.Broadside) then
		timerBroadsideCD:Start()
	elseif msg == L.GorionaRetreat or msg:find(L.GorionaRetreat) then
		self:Schedule(1.5, function()
		timerTwilightFlamesCD:Cancel()
		timerTwilightBreath:Cancel()
		timerConsumingShroud:Cancel()
		end)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.GorionaRetreat or msg:find(L.GorionaRetreat) then
		self:Schedule(1.5, function()
		timerTwilightFlamesCD:Cancel()
		timerTwilightBreath:Cancel()
		timerConsumingShroud:Cancel()
		end)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56427 then
		DBM:EndCombat(self)
	elseif cid == 56848 or cid == 56854 then
		timerBladeRushCD:Cancel(args.sourceGUID)
	elseif cid == 56855 or cid == 56587 then
		drakesCount = drakesCount - 1
		warnDrakesLeft:Show(drakesCount)
		timerReloadingCast:Cancel(args.sourceGUID)
		timerHarpoonActive:Cancel(args.sourceGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 107594 then
		self:SendSync("BladeRush", UnitGUID(uId))
	end
end

function mod:OnSync(msg, sourceGUID)
	if msg == "BladeRush" then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerBladeRushCD:Start(sourceGUID)
		else
			timerBladeRushCD:Start(20, sourceGUID)
		end
	end
end

