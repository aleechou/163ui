local mod	= DBM:NewMod("ForgemasterGarfrost", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4498 $"):sub(12, -3))
mod:SetCreatureID(36494)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"CHAT_MSG_RAID_BOSS_WHISPER"
)

local warnForgeWeapon			= mod:NewSpellAnnounce(70335, 2)
local warnDeepFreeze			= mod:NewTargetAnnounce(70384, 2)
local warnSaroniteRock			= mod:NewAnnounce("warnSaroniteRock", 3, 70851)
local specWarnSaroniteRock		= mod:NewSpecialWarning("specWarnSaroniteRock")
local specWarnSaroniteRockNear	= mod:NewSpecialWarning("specWarnSaroniteRockNear")
local specWarnPermafrost		= mod:NewSpecialWarning("specWarnPermafrost")
local timerDeepFreeze			= mod:NewTargetTimer(14, 70381)

mod:AddBoolOption("SetIconOnSaroniteRockTarget", true)
mod:AddBoolOption("AchievementCheck", false, "announce")

local warnedfailed = false

function mod:OnCombatStart(delay)
	warnedfailed = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70381, 72930) then						-- Deep Freeze
		warnDeepFreeze:Show(args.destName)
		timerDeepFreeze:Start(args.destName)
	elseif args:IsSpellID(68785, 70335) then					-- Forge Frostborn Mace
		warnForgeWeapon:Show()
	end
end

local spam = 0
function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(68786, 70336) then
		if args.amount >= 9 and GetTime() - spam > 5 and args:IsPlayer() then --11 stacks is what's needed for achievement, 9 to give you time to clear/dispel
			specWarnPermafrost:Show(args.spellName, args.amount)
			spam = GetTime()
		end
		if self.Options.AchievementCheck and not warnedfailed then
			if (args.amount or 1) == 9 or (args.amount or 1) == 10 then
				SendChatMessage(L.AchievementWarning:format(args.destName, (args.amount or 1)), "PARTY")
			elseif (args.amount or 1) > 11 then
				SendChatMessage(L.AchievementFailed:format(args.destName, (args.amount or 1)), "PARTY")
				warnedfailed = true
			end
		end
	end
end

function mod:SPELL_CREATE(args)
	if args:IsSpellID(68789, 70851) then						-- Saronite Rock
		warnSaroniteRock:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	local target = msg and msg:match(L.SaroniteRockThrow)
	if target then
		self:SendSync("SaroniteRock", target)
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg) 
	if msg == L.SaroniteRockThrow or msg:match(L.SaroniteRockThrow) then 
		self:SendSync("SaroniteRock", UnitName("player"))
	end 
end 

function mod:OnSync(msg, target)
	if msg == "SaroniteRock" then
		warnSaroniteRock:Show(target)
		if target == UnitName("player") then
			specWarnSaroniteRock:Show()
		elseif target then
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnSaroniteRockNear:Show()
				end
			end
		end
		if self.Options.SetIconOnSaroniteRockTarget then
			self:SetIcon(target, 8, 5)
		end
	end
end