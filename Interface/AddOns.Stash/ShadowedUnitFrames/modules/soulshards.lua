local Souls = setmetatable({}, {__index = ShadowUF.ComboPoints})
ShadowUF:RegisterModule(Souls, "soulShards", ShadowUF.L["Soul Shards"], nil, "WARLOCK", SPEC_WARLOCK_AFFLICTION)
local soulsConfig = {max = 4, key = "soulShards", colorKey = "SOULSHARDS", powerType = SPELL_POWER_SOUL_SHARDS, eventType = "SOUL_SHARDS", icon = "Interface\\AddOns\\ShadowedUnitFrames\\media\\textures\\shard"}

function Souls:OnEnable(frame)
	frame.soulShards = frame.soulShards or CreateFrame("Frame", nil, frame)
	frame.soulShards.config = soulsConfig
	frame.comboPointType = soulsConfig.key

	frame:RegisterUnitEvent("UNIT_POWER_FREQUENT", self, "Update")
	frame:RegisterUnitEvent("UNIT_MAXPOWER", self, "UpdateBarBlocks")
	frame:RegisterUnitEvent("UNIT_DISPLAYPOWER", self, "Update")

	frame:RegisterUpdateFunc(self, "Update")
	frame:RegisterUpdateFunc(self, "UpdateBarBlocks")
end

function Souls:OnLayoutApplied(frame, config)
	ShadowUF.ComboPoints:OnLayoutApplied(frame, config)
	self:UpdateBarBlocks(frame)
end

function Souls:GetPoints(unit)
	return UnitPower("player", soulsConfig.powerType)
end