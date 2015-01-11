local mod	= DBM:NewMod(609, "DBM-Party-WotLK", 15, 278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 178 $"):sub(12, -3))
mod:SetCreatureID(36476)
mod:SetEncounterID(835, 836)
mod:SetUsedIcons(8)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

local warnPursuitCast			= mod:NewCastAnnounce(68987, 3)
local warnPoisonNova			= mod:NewCastAnnounce(68989, 3)
local warnPursuit				= mod:NewTargetAnnounce(68987, 4)--TODO, just switch to UNIT_AURA, syncing not reliable especially with older zones.

local specWarnToxic				= mod:NewSpecialWarningMove(69024)
local specWarnMines				= mod:NewSpecialWarningSpell(69015, nil, nil, nil, 2)
local specWarnPursuit			= mod:NewSpecialWarningRun(68987, nil, nil, nil, 4)
local specWarnPoisonNova		= mod:NewSpecialWarningRun("OptionVersion2", 68989, mod:IsMelee(), nil, nil, 4)

local timerPursuitCast			= mod:NewCastTimer(5, 68987)
local timerPursuitConfusion		= mod:NewBuffActiveTimer(12, 69029)
local timerPoisonNova			= mod:NewCastTimer(5, 68989)

mod:AddBoolOption("SetIconOnPursuitTarget", true)

function mod:SPELL_CAST_START(args)
	if args.spellId == 68987 then							-- Pursuit
		warnPursuitCast:Show()
		timerPursuitCast:Start()
	elseif args.spellId == 68989 then				-- Poison Nova
		warnPoisonNova:Show()
		timerPoisonNova:Start()
		specWarnPoisonNova:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69029 then							-- Pursuit Confusion
		timerPursuitConfusion:Show(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 69024 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnToxic:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Barrage or msg:find(L.IckPursuit) then
		specWarnMines:Show()
	end
end

function mod:RAID_BOSS_WHISPER(msg) 
	if msg == L.IckPursuit or msg:find(L.IckPursuit) then 
		specWarnPursuit:Show() 
		self:SendSync("Pursuit", UnitGUID("player"))
	end 
end 

function mod:OnSync(msg, guid) 
	local target
	if guid then
		target = DBM:GetFullPlayerNameByGUID(guid)
	end
	if msg == "Pursuit" and guid then 
		if target then
			warnPursuit:Show(target)
			if self.Options.SetIconOnPursuitTarget then 
				self:SetIcon(target, 8, 12) 
			end
		end
	end 
end 
