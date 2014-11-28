local mod	= DBM:NewMod(1209, "DBM-Party-WoD", 5, 556)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11483 $"):sub(12, -3))
mod:SetCreatureID(84550)
mod:SetEncounterID(1752)--TODO: VERIFY, "Boss 4" isn't descriptive enough
mod:SetZone()

mod:RegisterCombat("combat_emote", L.Pull)--IEEU doesn't work, so emote is required. EDIT, emote doesn't work either wtf?

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 169248 169233 169382",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_TARGETABLE_CHANGED"
)

--TODO, figure out why the hell emote pull doesn't work. Text is correct.
local warnToxicSpiderling			= mod:NewAddsLeftAnnounce("ej10492", 2)
--local warnVenomCrazedPaleOne		= mod:NewSpellAnnounce("ej10502", 3)--I can't find a way to detect these, at least not without flat out scanning all DAMAGE events but that's too much work.
local warnInhale					= mod:NewSpellAnnounce(169233, 3)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnConsume					= mod:NewSpellAnnounce(169248, 4)
local warnGaseousVolley				= mod:NewSpellAnnounce(169248, 3)

--local specWarnVenomCrazedPaleOne	= mod:NewSpecialWarningSwitch("ej10502", not mod:IsHealer())
local specWarnConsume				= mod:NewSpecialWarningSpell(169248)
local specWarnGaseousVolley			= mod:NewSpecialWarningSpell(169382, nil, nil, nil, 2)

mod.vb.spiderlingCount = 8
mod.vb.phase2 = false

function mod:OnCombatStart(delay)
	self.vb.spiderlingCount = 8
	self.vb.phase2 = false
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 169233 then
		warnInhale:Show()
	elseif spellId == 169248 then
		warnConsume:Show()
		specWarnConsume:Show()
	elseif spellId == 169382 then
		warnGaseousVolley:Show()
		specWarnGaseousVolley:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 84552 then
		self.vb.spiderlingCount = self.vb.spiderlingCount - 1
		if self.vb.spiderlingCount > 0 then--Don't need to warn 0, phase 2 kind of covers that 1.4 seconds later.
			warnToxicSpiderling:Show(self.vb.spiderlingCount)
		end
	end
end

--"<104.1 20:55:19> [CLEU] UNIT_DIED#true##nil#-2147483648#-2147483648#Creature:0:3313:1279:28971:84552:0000617CBD#Toxic Spiderling#2632#0#0", -- [3454]
--"<105.5 20:55:21> [UNIT_TARGETABLE_CHANGED] Fake Args:#true#true#Xeri'tac#Creature:0:3313:1279:28971:84550:0000617C15#elite#2617950#false#false#nil#nil#normal#0#false#false#nil#nil#normal#0#false#fals
--"<106.4 20:55:21> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#Xeri'tac descends from her web!#Xeri'tac###Kaltio##0#0##0#90#nil#0#false#false", -- [3569]
function mod:UNIT_TARGETABLE_CHANGED()
	if not self.vb.phase2 then
		self.vb.phase2 = true
		warnPhase2:Show()
	end
end
