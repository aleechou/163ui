local mod	= DBM:NewMod("Deathwhisper", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4411 $"):sub(12, -3))
mod:SetCreatureID(36855)
mod:SetUsedIcons(4, 5, 6, 7, 8)
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_INTERRUPT",
	"SPELL_SUMMON",
	"SWING_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_TARGET"
)

local canPurge = select(2, UnitClass("player")) == "MAGE"
			or select(2, UnitClass("player")) == "SHAMAN"
			or select(2, UnitClass("player")) == "PRIEST"

local warnAddsSoon					= mod:NewAnnounce("WarnAddsSoon", 2)
local warnDominateMind				= mod:NewTargetAnnounce(71289, 3)
local warnDeathDecay				= mod:NewSpellAnnounce(72108, 2)
local warnSummonSpirit				= mod:NewSpellAnnounce(71426, 2)
local warnReanimating				= mod:NewAnnounce("WarnReanimating", 3)
local warnDarkTransformation		= mod:NewSpellAnnounce(70900, 4)
local warnDarkEmpowerment			= mod:NewSpellAnnounce(70901, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 1)
local warnFrostbolt					= mod:NewCastAnnounce(72007, 2)
local warnTouchInsignificance		= mod:NewAnnounce("WarnTouchInsignificance", 2, 71204, mod:IsTank() or mod:IsHealer())
local warnDarkMartyrdom				= mod:NewSpellAnnounce(72499, 4)

local specWarnCurseTorpor			= mod:NewSpecialWarningYou(71237)
local specWarnDeathDecay			= mod:NewSpecialWarningMove(72108)
local specWarnTouchInsignificance	= mod:NewSpecialWarningStack(71204, nil, 3)
local specWarnVampricMight			= mod:NewSpecialWarningDispel(70674, canPurge)
local specWarnDarkMartyrdom			= mod:NewSpecialWarningMove(72499, mod:IsMelee())
-- local specWarnFrostbolt				= mod:NewSpecialWarningInterupt(72007, false)		bf@178.com
local specWarnVengefulShade			= mod:NewSpecialWarning("SpecWarnVengefulShade", not mod:IsTank())

local timerAdds						= mod:NewTimer(60, "TimerAdds", 61131)
local timerDominateMind				= mod:NewBuffActiveTimer(12, 71289)
local timerDominateMindCD			= mod:NewCDTimer(40, 71289)
local timerSummonSpiritCD			= mod:NewCDTimer(10, 71426, nil, false)
local timerFrostboltCast			= mod:NewCastTimer(4, 72007)
local timerTouchInsignificance		= mod:NewTargetTimer(30, 71204, nil, mod:IsTank() or mod:IsHealer())

local sndWOP				= mod:NewSound(nil, "SoundWOP", true)

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnDominateMind", true)
mod:AddBoolOption("SetIconOnDeformedFanatic", true)
mod:AddBoolOption("SetIconOnEmpoweredAdherent", true)
mod:AddBoolOption("ShieldHealthFrame", true, "misc")
mod:RemoveOption("HealthFrame")


local lastDD	= 0
local dominateMindTargets	= {}
local dominateMindIcon 	= 6
local deformedFanatic
local empoweredAdherent

function mod:OnCombatStart(delay)
	if self.Options.ShieldHealthFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(36855, L.name)
		self:ScheduleMethod(0.5, "CreateShildHPFrame")
	end
	berserkTimer:Start(-delay)
	timerAdds:Start(7)
	warnAddsSoon:Schedule(4)			-- 3sec pre-warning on start
	sndWOP:Schedule(2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
	self:ScheduleMethod(7, "addsTimer")
	if not mod:IsDifficulty("normal10") then
		timerDominateMindCD:Start(30)		-- Sometimes 1 fails at the start, then the next will be applied 70 secs after start ?? :S
	end
	table.wipe(dominateMindTargets)
	dominateMindIcon = 6
	deformedFanatic = nil
	empoweredAdherent = nil
end

function mod:OnCombatEnd()
	DBM.BossHealth:Clear()
end

do	-- add the additional Shield Bar
	local last = 100
	local function getShieldPercent()
		local guid = UnitGUID("focus")
		if mod:GetCIDFromGUID(guid) == 36855 then
			last = math.floor(UnitMana("focus")/UnitManaMax("focus") * 100)
			return last
		end
		for i = 0, GetNumGroupMembers(), 1 do
			local unitId = ((i == 0) and "target") or "raid"..i.."target"
			local guid = UnitGUID(unitId)
			if mod:GetCIDFromGUID(guid) == 36855 then
				last = math.floor(UnitMana(unitId)/UnitManaMax(unitId) * 100)
				return last
			end
		end
		return last
	end
	function mod:CreateShildHPFrame()
		DBM.BossHealth:AddBoss(getShieldPercent, L.ShieldPercent)
	end
end

function mod:addsTimer()
	timerAdds:Cancel()
	warnAddsSoon:Cancel()
	sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		warnAddsSoon:Schedule(40)	-- 5 secs prewarning
		self:ScheduleMethod(45, "addsTimer")
		timerAdds:Start(45)
		sndWOP:Schedule(40, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
	else
		warnAddsSoon:Schedule(55)	-- 5 secs prewarning
		self:ScheduleMethod(60, "addsTimer")
		timerAdds:Start()
		sndWOP:Schedule(55, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
	end
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for i = 1, GetNumGroupMembers() do
			if UnitGUID("raid"..i.."target") == deformedFanatic then
				deformedFanatic = nil
				SetRaidTarget("raid"..i.."target", 8)
			elseif UnitGUID("raid"..i.."target") == empoweredAdherent then
				empoweredAdherent = nil
				SetRaidTarget("raid"..i.."target", 7)
			end
			if not (deformedFanatic or empoweredAdherent) then
				break
			end
		end
	end
end

do
	local function showDominateMindWarning()
		warnDominateMind:Show(table.concat(dominateMindTargets, "<, >"))
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\findmc.mp3")
		timerDominateMind:Start()
		timerDominateMindCD:Start()
		table.wipe(dominateMindTargets)
		dominateMindIcon = 6
	end

	function mod:SPELL_AURA_APPLIED(args)
		if args:IsSpellID(71289) then
			dominateMindTargets[#dominateMindTargets + 1] = args.destName
			if self.Options.SetIconOnDominateMind then
				self:SetIcon(args.destName, dominateMindIcon, 12)
				dominateMindIcon = dominateMindIcon - 1
			end
			self:Unschedule(showDominateMindWarning)
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("normal25") or (mod:IsDifficulty("heroic25") and #dominateMindTargets >= 3) then
				showDominateMindWarning()
			else
				self:Schedule(0.9, showDominateMindWarning)
			end
		elseif args:IsSpellID(71001, 72108, 72109, 72110) then
			if args:IsPlayer() then
				specWarnDeathDecay:Show()
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			end
			if (GetTime() - lastDD > 5) then
				warnDeathDecay:Show()
				lastDD = GetTime()
			end
		elseif args:IsSpellID(71237) and args:IsPlayer() then
			specWarnCurseTorpor:Show()
		elseif args:IsSpellID(70674) and not args:IsDestTypePlayer() and (UnitName("target") == L.Fanatic1 or UnitName("target") == L.Fanatic2 or UnitName("target") == L.Fanatic3) then
			specWarnVampricMight:Show(args.destName)
		elseif args:IsSpellID(71204) then
			warnTouchInsignificance:Show(args.spellName, args.destName, args.amount or 1)
			timerTouchInsignificance:Start(args.destName)
			if mod:IsTank() or mod:IsHealer() then
				if (args.amount or 1) >= 3 and (mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25")) then
					specWarnTouchInsignificance:Show(args.amount)
					if args.amount == 3 or args.amount == 5 then
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\changemt.mp3")
					end
				elseif (args.amount or 1) >= 5 and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) then
					specWarnTouchInsignificance:Show(args.amount)
				end
			end
		end
	end
	mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70842) then
		warnPhase2:Show()
		if mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25") then
			timerAdds:Cancel()
			warnAddsSoon:Cancel()
			sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
			self:UnscheduleMethod("addsTimer")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(71420, 72007, 72501, 72502) then
		warnFrostbolt:Show()
		timerFrostboltCast:Start()
	elseif args:IsSpellID(70900) then
		warnDarkTransformation:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\transmob.mp3")
		if self.Options.SetIconOnDeformedFanatic then
			deformedFanatic = args.sourceGUID
			self:TrySetTarget()
		end
	elseif args:IsSpellID(70901) then
		warnDarkEmpowerment:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\powermob.mp3")
		if self.Options.SetIconOnEmpoweredAdherent then
			empoweredAdherent = args.sourceGUID
			self:TrySetTarget()
		end
	elseif args:IsSpellID(72499, 72500, 72497, 72496) then
		warnDarkMartyrdom:Show()
		specWarnDarkMartyrdom:Show()
		if mod:IsMelee() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\boomrun.mp3")
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 71420 or args.extraSpellId == 72007 or args.extraSpellId == 72501 or args.extraSpellId == 72502) then
		timerFrostboltCast:Cancel()
	end
end

local lastSpirit = 0
function mod:SPELL_SUMMON(args)
	if args:IsSpellID(71426) then -- Summon Vengeful Shade
		if time() - lastSpirit > 5 then
			warnSummonSpirit:Show()
			timerSummonSpiritCD:Start()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\spirits.mp3")
			lastSpirit = time()
		end
	end
end

function mod:SWING_DAMAGE(args)
	if args:IsPlayer() and args:GetSrcCreatureID() == 38222 then
		specWarnVengefulShade:Show()
	end
end

function mod:UNIT_TARGET()
	if empoweredAdherent or deformedFanatic then
		self:TrySetTarget()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellReanimatedFanatic or msg:find(L.YellReanimatedFanatic) then
		warnReanimating:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobrevive.mp3")
	end
end
