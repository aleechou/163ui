local mod	= DBM:NewMod("XT002", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4523 $"):sub(12, -3))
mod:SetCreatureID(33293)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE"
)

local warnLightBomb					= mod:NewTargetAnnounce(65121, 3)
local warnGravityBomb				= mod:NewTargetAnnounce(64234, 3)

local specWarnLightBomb				= mod:NewSpecialWarningYou(65121)
local specWarnGravityBomb			= mod:NewSpecialWarningYou(64234)
local specWarnConsumption			= mod:NewSpecialWarningMove(64206)--Hard mode void zone dropped by Gravity Bomb

local enrageTimer					= mod:NewBerserkTimer(600)
local timerTympanicTantrumCast		= mod:NewCastTimer(62776)
local timerTympanicTantrum			= mod:NewBuffActiveTimer(8, 62776)
local timerTympanicTantrumCD		= mod:NewCDTimer(60, 62776)
local timerHeart					= mod:NewCastTimer(30, 63849)
local timerLightBomb				= mod:NewTargetTimer(9, 65121)
local timerGravityBomb				= mod:NewTargetTimer(9, 64234)
local timerAchieve					= mod:NewAchievementTimer(205, 2937, "TimerSpeedKill")

local sndWOP				= mod:NewSound(nil, "SoundWOP", true)

mod:AddBoolOption("SetIconOnLightBombTarget", true)
mod:AddBoolOption("SetIconOnGravityBombTarget", true)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	if mod:IsDifficulty("normal10") then
		timerTympanicTantrumCD:Start(35-delay)
	else
		timerTympanicTantrumCD:Start(50-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62776) then					-- Tympanic Tantrum (aoe damge + daze)
		timerTympanicTantrumCast:Start()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\healall.mp3")
		timerTympanicTantrumCD:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62775) and args.auraType == "DEBUFF" then	-- Tympanic Tantrum
		timerTympanicTantrumCD:Start()
		timerTympanicTantrum:Start()

	elseif args:IsSpellID(63018, 65121) then 	-- Light Bomb
		if args:IsPlayer() then
			specWarnLightBomb:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runout.mp3")
		end
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 7, 9)
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	elseif args:IsSpellID(63024, 64234) then		-- Gravity Bomb
		if args:IsPlayer() then
			specWarnGravityBomb:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runout.mp3")
		end
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 8, 9)
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)
	elseif args:IsSpellID(63849) then
		timerHeart:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63018, 65121) then 	-- Light Bomb
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(63024, 64234) then		-- Gravity Bomb
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end

do 
	local lastConsumption = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(64208, 64206) and args:IsPlayer() and time() - lastConsumption > 2 then		-- Hard mode void zone
			specWarnConsumption:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			lastConsumption = time()
		end
	end
end