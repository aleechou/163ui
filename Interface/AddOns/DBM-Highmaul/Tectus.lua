local mod	= DBM:NewMod(1195, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 11644 $"):sub(12, -3))
mod:SetCreatureID(78948, 99999)--78948 Tectus, 80557 Mote of Tectus, 80551 Shard of Tectus
mod:SetEncounterID(1722)--Hopefully win will work fine off this because otherwise tracking shard deaths is crappy
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5)

mod:RegisterCombat("combat")
mod:SetMinSyncTime(4)--Rise Mountain can occur pretty often.

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162475 162968 162894 163312",
	"SPELL_AURA_APPLIED 162346 162674",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_DIED"
)

--TODO, find better icons for adds, these are filler icons for spells they use.
--TODO, figure out what's wrong with DBM-Core stripping most of EJ spellname in specWarnEarthwarper (it's saying "Night - Switch" instead of "Night-Twisted Earthshaper - Switch")
--Tectus
--local warnEarthenPillar				= mod:NewSpellAnnounce(162518, 3)--No way to detect unless it hits a player :\
local warnTectonicUpheaval			= mod:NewSpellAnnounce(162475, 3)
local warnCrystallineBarrage		= mod:NewTargetAnnounce(162346, 3)
local warnEarthwarper				= mod:NewSpellAnnounce("ej10061", 3, 162894)
local warnBerserker					= mod:NewSpellAnnounce("ej10062", 3, 163312)
--Night-Twisted NPCs
local warnEarthenFlechettes			= mod:NewSpellAnnounce(162968, 3, nil, mod:IsMelee())
local warnGiftOfEarth				= mod:NewCountAnnounce(162894, 4, nil, mod:IsMelee())
local warnRavingAssault				= mod:NewSpellAnnounce(163312, 3)--Target scanning? Emote?

local specWarnEarthwarper			= mod:NewSpecialWarningSwitch("ej10061")
local specWarnTectonicUpheaval		= mod:NewSpecialWarningSpell(162475, nil, nil, nil, 2)
local specWarnEarthenPillar			= mod:NewSpecialWarningSpell(162518, nil, nil, nil, 3)
local specWarnCrystallineBarrage	= mod:NewSpecialWarningYou(162894)
--Night-Twisted NPCs
local specWarnEarthenFlechettes		= mod:NewSpecialWarningSpell(162968, mod:IsMelee())--Change to "move" warning if it's avoidable
local specWarnGiftOfEarth			= mod:NewSpecialWarningCount(162894, mod:IsTank())

local timerEarthwarperCD			= mod:NewNextTimer(41, "ej10061", nil, nil, nil, 162894)--Both of these get delayed by upheavel
local timerBerserkerCD				= mod:NewNextTimer(41, "ej10062", nil, nil, nil, 163312)--Both of these get delayed by upheavel
local timerGiftOfEarthCD			= mod:NewCDTimer(10.5, 162894, nil, mod:IsMelee())--10.5 but obviously delayed if stuns were used.
local timerEarthenFlechettesCD		= mod:NewCDTimer(14, 162968, nil, mod:IsMelee())--14 but obviously delayed if stuns were used. Also tends to be recast immediately if stun interrupted

local countdownEarthwarper			= mod:NewCountdown(41, "ej10061", mod:IsMelee())

mod:AddSetIconOption("SetIconOnEarthwarper", "ej10061", true, true)
mod:AddSetIconOption("SetIconOnMote", "ej10083", false, true)--This more or less assumes the 4 at a time strat. if you unleash 8 it will fail. Although any guild unleashing 8 is probably doing it wrong (minus LFR)

local Earthwarper = EJ_GetSectionInfo(10061)
local Berserker = EJ_GetSectionInfo(10062)
mod.vb.EarthwarperAlive = 0
local earthDuders = {}

function mod:OnCombatStart(delay)
	table.wipe(earthDuders)
	self.vb.EarthwarperAlive = 0
	timerEarthwarperCD:Start(11-delay)
	countdownEarthwarper:Start(11-delay)
	timerBerserkerCD:Start(21-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162475 and self:AntiSpam(5, 1) then--Antispam for later fight.
		warnTectonicUpheaval:Show()
		specWarnTectonicUpheaval:Show()
	elseif spellId == 162968 then
		warnEarthenFlechettes:Show()
		specWarnEarthenFlechettes:Show()
		timerEarthenFlechettesCD:Start(args.sourceGUID)
	elseif spellId == 162894 then
		local GUID = args.sourceGUID
		--Support for counts for each earth guy up.
		if not earthDuders[GUID] then
			earthDuders[GUID] = 0
		end
		earthDuders[GUID] = earthDuders[GUID] + 1
		warnGiftOfEarth:Show(earthDuders[GUID])
		specWarnGiftOfEarth:Show(earthDuders[GUID])
		timerGiftOfEarthCD:Start(GUID)
	elseif spellId == 163312 then
		warnRavingAssault:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 162346 then
		warnCrystallineBarrage:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnCrystallineBarrage:Show()
		end
	elseif spellId == 162674 and self.Options.SetIconOnMote and not self:IsLFR() then--Don't mark kill/pickup marks in LFR, it'll be an aoe fest.
		self:ScanForMobs(args.destGUID, 0, 8, 4, 0.05, 15)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80599 then
		local GUID = args.destGUID
		self.vb.EarthwarperAlive = self.vb.EarthwarperAlive - 1
		timerGiftOfEarthCD:Cancel(GUID)--Only issue is that this won't cancel the FIRST timer which lacks a GUID, if you manage to kill it before first cast
		timerEarthenFlechettesCD:Cancel(GUID)
		earthDuders[GUID] = nil
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 140562 then--Break Player Targetting (cast when tectus splits)
		timerEarthwarperCD:Cancel()
		countdownEarthwarper:Cancel()
		timerBerserkerCD:Cancel()
	end
end

--"<11.7 15:07:19> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#MASTER! I COME FOR YOU!#Night-Twisted Earthwarper#####0#0##0#480#nil#0#false#false", -- [1951]
--"<21.3 15:07:28> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Graaagh! KAHL...  AHK... RAAHHHH!#Night-Twisted Berserker#####0#0##0#482#nil#0#false#false", -- [4086]
function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if npc == Earthwarper then
		self.vb.EarthwarperAlive = self.vb.EarthwarperAlive + 1
		warnEarthwarper:Show()
		specWarnEarthwarper:Show()
		timerGiftOfEarthCD:Start(10)
		timerEarthenFlechettesCD:Start(15)
		timerEarthwarperCD:Start()
		countdownEarthwarper:Start()
		if self.Options.SetIconOnEarthwarper and self.vb.EarthwarperAlive < 9 then--Support for marking up to 8 mobs (you're group is terrible)
			self:ScanForMobs(80599, 2, 9-self.vb.EarthwarperAlive, 1, 0.1, 15, "SetIconOnEarthwarper")
		end
	elseif npc == Berserker then
		warnBerserker:Show()
		timerBerserkerCD:Start()
	elseif msg == L.pillarSpawn or msg:find(L.pillarSpawn) then
		self:SendSync("TectusPillar")
	end
end

function mod:OnSync(msg)
	if msg == "TectusPillar" and self:IsInCombat() then
		specWarnEarthenPillar:Show()
	end
end
