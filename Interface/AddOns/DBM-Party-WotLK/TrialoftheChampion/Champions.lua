local mod	= DBM:NewMod("GrandChampions", "DBM-Party-WotLK", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4466 $"):sub(12, -3))
mod:SetCreatureID(34657, 34701, 34702, 34703, 34705, 35569, 35570, 35571, 35572, 35617)
mod:SetMinSyncRevision(4248)

mod:RegisterCombat("combat")
mod:SetDetectCombatInVehicle(false)

mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
				 or select(2, UnitClass("player")) == "PRIEST"
				 or select(2, UnitClass("player")) == "SHAMAN"

local warnHealingWave		= mod:NewSpellAnnounce(68318, 2)
local warnHaste				= mod:NewTargetAnnounce(66045, 2)
local warnPolymorph			= mod:NewTargetAnnounce(66043, 1)
local warnHexOfMending		= mod:NewTargetAnnounce(67534, 1)
local specWarnPoison		= mod:NewSpecialWarningMove(68316)
local specWarnHaste			= mod:NewSpecialWarningDispel(66045, isDispeller)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68318, 67528) then								-- Healing Wave
		warnHealingWave:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(66045) and not args:IsDestTypePlayer() then		-- Haste
		warnHaste:Show(args.destName)
		specWarnHaste:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66043, 68311) then								-- Polymorph on <x>
		warnPolymorph:Show(args.destName)
	elseif args:IsSpellID(67534) then									-- Hex of Mending on <x>
		warnHexOfMending:Show(args.destName)
	elseif args:IsSpellID(67594, 68316) and args:IsPlayer() then		-- Standing in Poison Bottle.
		specWarnPoison:Show()
	end
end

