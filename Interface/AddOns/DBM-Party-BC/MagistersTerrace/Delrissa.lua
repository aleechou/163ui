local mod = DBM:NewMod(532, "DBM-Party-BC", 16, 249)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))

mod:SetCreatureID(24560, 24557, 24558, 24554, 24561, 24559, 24555, 24553, 24556)--24560 is main boss.
mod:RegisterCombat("combat")--UNIT_HEALTH combat should work now
mod:RegisterKill("yell", L.DelrissaEnd)--Leave as a backup since it's already localized but UNIT_DIED should catch it now for main bossID

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"UNIT_DIED"
)

local warnFlashHeal		= mod:NewSpellAnnounce(17843, 3)
local warnLHW           = mod:NewSpellAnnounce(46181, 3)
local warnWindFury		= mod:NewSpellAnnounce(27621, 2, nil, false)
local warnBlizzard		= mod:NewSpellAnnounce(46195, 2)
local warnRenew         = mod:NewSpellAnnounce(46192, 3)
local warnSoC           = mod:NewTargetAnnounce(44141, 2)
local warnPolymorph     = mod:NewTargetAnnounce(13323, 4)
local warnPWShield      = mod:NewTargetAnnounce(44175, 2, nil, false)

local specWarnFlashHeal	= mod:NewSpecialWarningInterrupt(17843, false)
local specWarnLHW		= mod:NewSpecialWarningInterrupt(46181, false)
local specWarnPWS		= mod:NewSpecialWarningDispel(44175, false)

function mod:SPELL_CAST_START(args)
	if args.spellId == 17843 and self:IsInCombat() then                                -- Delrissa's Flash Heal
		warnFlashHeal:Show()
		specWarnFlashHeal:Show(args.sourceName)
	elseif args:IsSpellID(44256, 46181) then                                           -- Apoko's LHW
		warnLHW:Show()
		specWarnLHW:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 27621 and self:IsInCombat() then                                -- Apoko's Windfury Totem
		warnWindFury:Show()
	elseif args:IsSpellID(44178, 46195) then                                           -- Yazzai's Blizzard
		warnBlizzard:Show()
	elseif args:IsSpellID(44174, 46192) and not args:IsDestTypePlayer() then           -- Delrissa's Renew
		warnRenew:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 13323 and self:IsInCombat() then                                -- Yazzai's Polymorph
		warnPolymorph:Show(args.destName)
	elseif args.spellId == 44141 then                                                  -- Ellrys SoC
		warnSoC:Show(args.destName)
	elseif args:IsSpellID(44175, 44291, 46193) and not args:IsDestTypePlayer() then    -- Delrissa's PWShield
		warnPWShield:Show(args.destName)
		specWarnPWS:Show(args.destName)
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 24560 then
		DBM:EndCombat(self)
	end
end
