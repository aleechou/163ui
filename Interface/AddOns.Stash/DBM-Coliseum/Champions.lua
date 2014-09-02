local mod	= DBM:NewMod("Champions", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 34 $"):sub(12, -3))
mod:SetCreatureID(34458, 34451, 34459, 34448, 34449, 34445, 34456, 34447, 34441, 34454, 34444, 34455, 34450, 34453, 34461, 34460, 34469, 34467, 34468, 34471, 34465, 34466, 34473, 34472, 34470, 34463, 34474, 34475)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.YellKill)


mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_AURA_APPLIED",
	"UNIT_DIED"
)


if UnitFactionGroup("player") == "Alliance" then
	mod:RegisterKill("yell", L.AllianceVictory)
	mod:SetBossHealthInfo(
	-- Horde
		34458, L.Gorgrim,
		34451, L.Birana,
		34459, L.Erin,
		34448, L.Rujkah,
		34449, L.Ginselle,
		34445, L.Liandra,
		34456, L.Malithas,
		34447, L.Caiphus,
		34441, L.Vivienne,
		34454, L.Mazdinah,
		34444, L.Thrakgar,
		34455, L.Broln,
		34450, L.Harkzog,
		34453, L.Narrhok
	)
else
	mod:RegisterKill("yell", L.HordeVictory)
	mod:SetBossHealthInfo(
	-- Alliance
		34461, L.Tyrius,
		34460, L.Kavina,
		34469, L.Melador,
		34467, L.Alyssia,
		34468, L.Noozle,
		34471, L.Baelnor,
		34465, L.Velanaa,
		34466, L.Anthar,
		34473, L.Brienna,
		34472, L.Irieth,
		34470, L.Saamul,
		34463, L.Shaabad,
		34474, L.Serissa,
		34475, L.Shocuul
	)
end

local isDispeller = select(2, UnitClass("player")) == "WARRIOR"
				or select(2, UnitClass("player")) == "PRIEST"
				or select(2, UnitClass("player")) == "SHAMAN"

local warnHellfire			= mod:NewSpellAnnounce(65816, 4)
local preWarnBladestorm 	= mod:NewSoonAnnounce(65947, 3)
local warnBladestorm		= mod:NewSpellAnnounce(65947, 4)
local warnHeroism			= mod:NewSpellAnnounce(65983, 3)
local warnBloodlust			= mod:NewSpellAnnounce(65980, 3)
local warnHandofFreedom		= mod:NewTargetAnnounce(66115, 2)
local warnHandofProt		= mod:NewTargetAnnounce(66009, 3)
local warnDivineShield		= mod:NewSpellAnnounce(66010, 3)
local warnIceBlock			= mod:NewSpellAnnounce(65802, 3)
local warnShadowstep		= mod:NewSpellAnnounce(66178, 2)
local warnDeathgrip			= mod:NewTargetAnnounce(66017, 2)
local warnCyclone			= mod:NewTargetAnnounce(65859, 1, nil, false)
local warnSheep				= mod:NewTargetAnnounce(65801, 1, nil, false)

local timerBladestorm		= mod:NewBuffActiveTimer(8, 65947)
local timerShadowstepCD		= mod:NewCDTimer(30, 66178)
local timerDeathgripCD		= mod:NewCDTimer(35, 66017)
local timerBladestormCD		= mod:NewCDTimer(90, 65947)

local specWarnHellfire		= mod:NewSpecialWarningMove(65816)
local specWarnHandofProt	= mod:NewSpecialWarningDispel(66009, isDispeller)
local specWarnDivineShield	= mod:NewSpecialWarningDispel(66010, isDispeller) 
local specWarnIceBlock		= mod:NewSpecialWarningDispel(65802, isDispeller)

local soundBladestorm		= mod:NewSound(65947, nil, mod:IsMelee())

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(65816, 68145, 68146, 68147) then		-- Warlock Hellfire
		warnHellfire:Show()
	elseif args.spellId == 65947 then						-- Warrior Bladestorm
		warnBladestorm:Show()
		timerBladestorm:Start()
		timerBladestormCD:Start()
		preWarnBladestorm:Schedule(85)                      -- Pre-Warn will only announce for 2nd and later bladestorm.
		soundBladestorm:Play()
	elseif args.spellId == 65983 then						-- Shamen Heroism
		warnHeroism:Show()
	elseif args.spellId == 65980 then						-- Shamen Blood lust
		warnBloodlust:Show()
	elseif args:IsSpellID(68758, 68757, 68756, 66115) and not args:IsDestTypePlayer() then	-- Paladin Hand of Freedom on <mobname>
		warnHandofFreedom:Show(args.destName)
	elseif args.spellId == 66009 then						-- Paladin Hand of Protection on <mobname>
		warnHandofProt:Show(args.destName)
		specWarnHandofProt:Show(args.destName)
	elseif args:IsSpellID(66178, 68759, 68760, 68761) then	-- Rogue Shadowstep
		warnShadowstep:Show()
        if self:IsDifficulty("heroic25") then                -- 3 out of 4 difficulties have 30 second cooldown, but on 25 heroic, it's 20sec
			timerShadowstepCD:Start(20)
		else
			timerShadowstepCD:Start()
		end
	elseif args:IsSpellID(66017, 68753, 68754, 68755) and args:IsDestTypePlayer() then	-- DeathKnight DeathGrip
		warnDeathgrip:Show(args.destName)
		if self:IsDifficulty("heroic25") then                -- 3 out of 4 difficulties have 35 second cooldown, but on 25 heroic, it's 20sec
			timerDeathgripCD:Start(20)
		else
			timerDeathgripCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 66010 then                                      -- Divine Shield on <mobname>
		warnDivineShield:Show(args.destName)
		specWarnDivineShield:Show(args.destName)
	elseif args.spellId == 65802 then                                  -- Iceblock on <mobname>
		warnIceBlock:Show(args.destName)
		specWarnIceBlock:Show(args.destName)
	elseif args.spellId == 65859 and args:IsDestTypePlayer() then      -- Cyclone on <playername>
		warnCyclone:Show(args.destName)
	elseif args.spellId == 65801 and args:IsDestTypePlayer() then      -- Sheep on <playername>
		warnSheep:Show(args.destName)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
	if (spellId == 65817 or spellId == 68142 or spellId == 68143 or spellId == 68144) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnHellfire:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34472 or cid == 34454 then
		timerShadowstepCD:Cancel()
	elseif cid == 34458 or cid == 34461 then
		timerDeathgripCD:Cancel()
	elseif cid == 34475 or cid == 34453 then
		timerBladestormCD:Cancel()
		preWarnBladestorm:Cancel()
	end
end