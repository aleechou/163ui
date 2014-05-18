local mod	= DBM:NewMod("Ick", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4342 $"):sub(12, -3))
mod:SetCreatureID(36476)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"SPELL_PERIODIC_DAMAGE"
)

local warnPursuitCast			= mod:NewCastAnnounce(68987, 3)
local warnPoisonNova			= mod:NewCastAnnounce(68989, 3)
local warnPursuit				= mod:NewAnnounce("warnPursuit", 4, 68987)

local specWarnToxic				= mod:NewSpecialWarningMove(70436)
local specWarnMines				= mod:NewSpecialWarningRun(69015)
local specWarnPursuit			= mod:NewSpecialWarning("specWarnPursuit")
local specWarnPoisonNova		= mod:NewSpecialWarningRun(68989, mod:IsMelee())

local timerPursuitCast			= mod:NewCastTimer(5, 68987)
local timerPursuitConfusion		= mod:NewBuffActiveTimer(12, 69029)
local timerPoisonNova			= mod:NewCastTimer(5, 68989)

local soundPoisonNova	= mod:NewSound(68989, nil, mod:IsMelee())
local soundPursuit		= mod:NewSound(68987)
mod:AddBoolOption("SetIconOnPursuitTarget", true)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68987) then							-- Pursuit
		warnPursuitCast:Show()
		timerPursuitCast:Start()
	elseif args:IsSpellID(68989, 70434) then				-- Poison Nova
		warnPoisonNova:Show()
		timerPoisonNova:Start()
		specWarnPoisonNova:Show()
		soundPoisonNova:Play()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69029, 70850) then							-- Pursuit Confusion
		timerPursuitConfusion:Show(args.destName)
	end
end

do 
	local lasttoxic = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69024, 70436) and args:IsPlayer() and time() - lasttoxic > 2 then
			specWarnToxic:Show()
			lasttoxic = time()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Barrage then
		specWarnMines:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg) 
	if msg == L.IckPursuit or msg:match(L.IckPursuit) then 
		self:SendSync("Pursuit", UnitName("player"))
	end 
end 

function mod:OnSync(msg, target) 
	if msg == "Pursuit" then 
		warnPursuit:Show(target)
		if target == UnitName("player") then 
			specWarnPursuit:Show() 
			soundPursuit:Play()
		end 
		if self.Options.SetIconOnPursuitTarget then 
			self:SetIcon(target, 8, 12) 
		end
	end 
end 