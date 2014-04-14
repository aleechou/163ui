local AuraPoints = setmetatable({
	isComboPoints = true,
	spells = {
		["MAGE"] = {max = 6, name = GetSpellInfo(36032)},
		["ROGUE"] = {max = 5, name = GetSpellInfo(115189)}
	}
}, {__index = ShadowUF.ComboPoints})

local trackSpell = AuraPoints.spells[select(2, UnitClass("player"))]
if( not trackSpell ) then return end

ShadowUF:RegisterModule(AuraPoints, "auraPoints", ShadowUF.L["Aura Combo Points"])
local auraConfig = {max = trackSpell.max, key = "auraPoints", colorKey = "AURAPOINTS", icon = "Interface\\AddOns\\ShadowedUnitFrames\\media\\textures\\combo"}

function AuraPoints:OnEnable(frame)
	frame.auraPoints = frame.auraPoints or CreateFrame("Frame", nil, frame)
	frame.auraPoints.config = auraConfig
	frame.comboPointType = auraConfig.key

	frame:RegisterUnitEvent("UNIT_AURA", self, "Update")
	frame:RegisterUpdateFunc(self, "Update")
end

function AuraPoints:GetPoints(unit)
	return select(4, UnitAura("player", trackSpell.name)) or 0
end