local Gladius = _G.Gladius
if not Gladius then
	DEFAULT_CHAT_FRAME:AddMessage(format("Module %s requires Gladius", "Auras"))
end
local L = Gladius.L
local LSM

-- global functions
local _G = _G
local ceil = math.ceil
local pairs = pairs
local rawget = rawget
local setmetatable = setmetatable
local strfind = string.find

local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local GetSpellInfo = GetSpellInfo
local GetSpellTexture = GetSpellTexture
local UnitAura = UnitAura

local Auras = Gladius:NewModule("Auras", false, true, {
	aurasBuffsAttachTo = "CastBar",
	aurasBuffsAnchor = "TOPLEFT",
	aurasBuffsRelativePoint = "BOTTOMLEFT",
	aurasBuffs = false,
	aurasBuffsGrow = "DOWNRIGHT",
	aurasBuffsSpacingX = 0,
	aurasBuffsSpacingY = 0,
	aurasBuffsPerColumn = 10,
	aurasBuffsMax = 10,
	aurasBuffsHeight = 16,
	aurasBuffsWidth = 16,
	aurasBuffsOffsetX = 0,
	aurasBuffsOffsetY = 0,
	aurasBuffsGloss = false,
	aurasBuffsGlossColor = {r = 1, g = 1, b = 1, a = 0.4},
	aurasBuffsTrackerCooldown = true,
	aurasBuffsTrackerCooldownReverse = true,
	aurasBuffsHideTimer = true,
	aurasDebuffsAttachTo = "ClassIcon",
	aurasDebuffsAnchor = "BOTTOMLEFT",
	aurasDebuffsRelativePoint = "TOPLEFT",
	aurasDebuffs = false,
	aurasDebuffsGrow = "UPRIGHT",
	aurasDebuffsSpacingX = 0,
	aurasDebuffsSpacingY = 0,
	aurasDebuffsPerColumn = 10,
	aurasDebuffsMax = 10,
	aurasDebuffsHeight = 16,
	aurasDebuffsWidth = 16,
	aurasDebuffsOffsetX = 0,
	aurasDebuffsOffsetY = 0,
	aurasDebuffsGloss = false,
	aurasDebuffsGlossColor = {r = 1, g = 1, b = 1, a = 0.4},
	aurasDebuffsTrackerCooldown = true,
	aurasDebuffsTrackerCooldownReverse = true,
	aurasDebuffsHideTimer = true,
	aurasFrameAuras = nil,
},
{
	"Bottom Single Row"
})

function Auras:OnEnable()
	self:RegisterEvent("UNIT_AURA")
	LSM = Gladius.LSM
	self.buffFrame = self.buffFrame or { }
	self.debuffFrame = self.debuffFrame or { }
	-- set auras
	Gladius.db.aurasFrameAuras = Gladius.db.aurasFrameAuras or self:GetAuraList()
end

function Auras:OnDisable()
	self:UnregisterAllEvents()
	for unit in pairs(self.buffFrame) do
		self.buffFrame[unit]:Hide()
		for i = 1, 40 do
			self.buffFrame[unit][i]:Hide()
			self.buffFrame[unit][i].tooltip:Hide()
		end
	end
	for unit in pairs(self.debuffFrame) do
		self.debuffFrame[unit]:Hide()
		for i = 1, 40 do
			self.debuffFrame[unit][i]:Hide()
			self.debuffFrame[unit][i].tooltip:Hide()
		end
	end
end

--[[function Auras:SetTemplate(template)
	if template == 1 then
		Gladius.db.aurasBuffsGrow = "DOWNRIGHT"
		Gladius.db.aurasBuffsAttachTo = "CastBar"
		Gladius.db.aurasBuffsRelativePoint = "BOTTOMLEFT"
		Gladius.db.aurasBuffsAnchor = "TOPLEFT"
		Gladius.db.aurasBuffsSpacingX = 1
		Gladius.db.aurasBuffsHeight = 17
		Gladius.db.aurasBuffsMax = Gladius.db.modules.Trinket and 8 or 6
		Gladius.db.aurasBuffsOffsetY = - 1
		Gladius.db.aurasDebuffsGrow = "DOWNLEFT"
		Gladius.db.aurasDebuffsAttachTo = "Trinket"
		Gladius.db.aurasDebuffsRelativePoint = "BOTTOMRIGHT"
		Gladius.db.aurasDebuffsAnchor = "TOPRIGHT"
		Gladius.db.aurasDebuffsSpacingX = 1
		Gladius.db.aurasDebuffsHeight = 17
		Gladius.db.aurasDebuffsMax = Gladius.db.modules.Trinket and 8 or 6
		Gladius.db.aurasDebuffsOffsetY = - 1
	end
end]]

function Auras:GetAttachTo()
	return Gladius.db.aurasAttachTo
end

function Auras:GetFrame(unit)
	return self.buffFrame[unit]
end

function Auras:GetIndicatorHeight()
	local height = 0
	if Gladius.db.aurasBuffs then
		height = height + Gladius.db.aurasBuffsHeight * ceil(Gladius.db.aurasBuffsMax / Gladius.db.aurasBuffsPerColumn)
	end
	if Gladius.db.aurasDebuffs then
		height = height + Gladius.db.aurasDebuffsHeight * ceil(Gladius.db.aurasDebuffsMax / Gladius.db.aurasDebuffsPerColumn)
	end
	return height
end

function Auras:UNIT_AURA(event, unit)
	if unit == nil then
		return
	end
	if not strfind(unit, "arena") or strfind(unit, "pet") then
		return
	end
	-- buff frame
	for i = 1, Gladius.db.aurasBuffsMax do
		local name, rank, icon, count, dispelType, duration, expires, caster, isStealable = UnitAura(unit, i, "HELPFUL")
		if not self.buffFrame[unit] or not self.buffFrame[unit][i] then
			break
		end
		if name then
			self.buffFrame[unit][i].texture:SetTexture(icon)
			Gladius:Call(Gladius.modules.Timer, "SetTimer", self.buffFrame[unit][i], duration)
			self.buffFrame[unit][i]:Show()
			--self.buffFrame[unit][i].tooltip:Show()
		else
			self.buffFrame[unit][i]:Hide()
			--self.buffFrame[unit][i].tooltip:Hide()
		end
	end
	-- debuff frame
	for i = 1, Gladius.db.aurasDebuffsMax do
		local name, rank, icon, count, dispelType, duration, expires, caster, isStealable = UnitAura(unit, i, "HARMFUL")
		if not self.debuffFrame[unit] or not self.debuffFrame[unit][i] then
			break
		end
		if name then
			self.debuffFrame[unit][i].texture:SetTexture(icon)
			Gladius:Call(Gladius.modules.Timer, "SetTimer", self.debuffFrame[unit][i], duration)
			self.debuffFrame[unit][i]:Show()
			--self.debuffFrame[unit][i].tooltip:Show()
		else
			self.debuffFrame[unit][i]:Hide()
			--self.debuffFrame[unit][i].tooltip:Hide()
		end
	end
end

local function updateTooltip(f, unit, index, filter)
	if GameTooltip:IsOwned(f) then
		GameTooltip:SetUnitAura(unit, index, filter)
	end
end

function Auras:UpdateColors(unit)
	if Gladius.db.aurasBuffs then
		for i = 1, Gladius.db.aurasBuffsMax do
			self.buffFrame[unit][i].normalTexture:SetVertexColor(Gladius.db.aurasBuffsGlossColor.r, Gladius.db.aurasBuffsGlossColor.g, Gladius.db.aurasBuffsGlossColor.b, Gladius.db.aurasBuffsGloss and Gladius.db.aurasBuffsGlossColor.a or 0)
		end
	end
	if Gladius.db.aurasDebuffs then
		for i = 1, Gladius.db.aurasDebuffsMax do
			self.debuffFrame[unit][i].normalTexture:SetVertexColor(Gladius.db.aurasDebuffsGlossColor.r, Gladius.db.aurasDebuffsGlossColor.g, Gladius.db.aurasDebuffsGlossColor.b, Gladius.db.aurasDebuffsGloss and Gladius.db.aurasDebuffsGlossColor.a or 0)
		end
	end
end

function Auras:CreateFrame(unit)
	local button = Gladius.buttons[unit]
	if not button then
		return
	end
	-- create buff frame
	if not self.buffFrame[unit] and Gladius.db.aurasBuffs then
		self.buffFrame[unit] = CreateFrame("Frame", "Gladius"..self.name.."BuffFrame"..unit, button)
		self.buffFrame[unit]:EnableMouse(false)
		for i = 1, 40 do
			self.buffFrame[unit][i] = CreateFrame("CheckButton", "Gladius"..self.name.."BuffFrameIcon"..i..unit, button, "ActionButtonTemplate")
			self.buffFrame[unit][i].tooltip = CreateFrame("Frame", nil, self.buffFrame[unit][i])
			self.buffFrame[unit][i].tooltip:SetAllPoints(self.buffFrame[unit][i])
			self.buffFrame[unit][i].tooltip:SetScript("OnEnter", function(f)
				GameTooltip:SetOwner(self.buffFrame[unit][i], "ANCHOR_RIGHT")
				if Gladius.test then
					GameTooltip:SetSpellByID(21562)
				else
					GameTooltip:SetUnitAura(unit, i, "HELPFUL")
					f:SetScript("OnUpdate", function(f)
						updateTooltip(f, unit, i, "HELPFUL")
					end)
				end
			end)
			self.buffFrame[unit][i].tooltip:SetScript("OnLeave", function(f)
				f:SetScript("OnUpdate", nil)
				GameTooltip:Hide()
			end)
			self.buffFrame[unit][i]:EnableMouse(false)
			self.buffFrame[unit][i]:SetNormalTexture("Interface\\AddOns\\Gladius\\Images\\Gloss")
			self.buffFrame[unit][i].texture = _G[self.buffFrame[unit][i]:GetName().."Icon"]
			self.buffFrame[unit][i].normalTexture = _G[self.buffFrame[unit][i]:GetName().."NormalTexture"]
			self.buffFrame[unit][i].cooldown = _G[self.buffFrame[unit][i]:GetName().."Cooldown"]
			self.buffFrame[unit][i].cooldown:SetReverse(Gladius.db.aurasBuffsTrackerCooldownReverse)
			Gladius:Call(Gladius.modules.Timer, "RegisterTimer", self.buffFrame[unit][i], Gladius.db.aurasBuffsTrackerCooldown, Gladius.db.aurasBuffsHideTimer)
		end
	end
	-- create debuff frame
	if not self.debuffFrame[unit] and Gladius.db.aurasDebuffs then
		self.debuffFrame[unit] = CreateFrame("Frame", "Gladius"..self.name.."DebuffFrame"..unit, button)
		self.debuffFrame[unit]:EnableMouse(false)
		for i = 1, 40 do
			self.debuffFrame[unit][i] = CreateFrame("CheckButton", "Gladius"..self.name.."DebuffFrameIcon"..i..unit, button, "ActionButtonTemplate")
			self.debuffFrame[unit][i].tooltip = CreateFrame("Frame", nil, self.debuffFrame[unit][i])
			self.debuffFrame[unit][i].tooltip:SetAllPoints(self.debuffFrame[unit][i])
			self.debuffFrame[unit][i].tooltip:SetScript("OnEnter", function(f)
				GameTooltip:SetOwner(self.debuffFrame[unit][i], "ANCHOR_RIGHT")
				if Gladius.test then
					GameTooltip:SetSpellByID(589)
				else
					GameTooltip:SetUnitAura(unit, i, "HARMFUL")
					f:SetScript("OnUpdate", function(f)
						updateTooltip(f, unit, i, "HARMFUL")
					end)
				end
			end)
			self.debuffFrame[unit][i].tooltip:SetScript("OnLeave", function(f)
				f:SetScript("OnUpdate", nil)
				GameTooltip:Hide()
			end)
			self.debuffFrame[unit][i]:EnableMouse(false)
			self.debuffFrame[unit][i]:SetNormalTexture("Interface\\AddOns\\Gladius\\Images\\Gloss")
			self.debuffFrame[unit][i].texture = _G[self.debuffFrame[unit][i]:GetName().."Icon"]
			self.debuffFrame[unit][i].normalTexture = _G[self.debuffFrame[unit][i]:GetName().."NormalTexture"]
			self.debuffFrame[unit][i].cooldown = _G[self.debuffFrame[unit][i]:GetName().."Cooldown"]
			self.debuffFrame[unit][i].cooldown:SetReverse(Gladius.db.aurasDebuffsTrackerCooldownReverse)
			Gladius:Call(Gladius.modules.Timer, "RegisterTimer", self.debuffFrame[unit][i], Gladius.db.aurasDebuffsTrackerCooldown, Gladius.db.aurasDebuffsHideTimer)
		end
	end
	if not Gladius.test then
		self:UNIT_AURA(nil, unit)
	end
end

function Auras:Update(unit)
	Gladius.db.aurasFrameAuras = Gladius.db.aurasFrameAuras or self:GetAuraList()
	-- create frame
	if not self.buffFrame[unit] or not self.debuffFrame[unit] then
		self:CreateFrame(unit)
	end
	-- update buff frame 
	if Gladius.db.aurasBuffs then
		self.buffFrame[unit]:ClearAllPoints()
		-- anchor point 
		local parent = Gladius:GetParent(unit, Gladius.db.aurasBuffsAttachTo)
		self.buffFrame[unit]:SetPoint(Gladius.db.aurasBuffsAnchor, parent, Gladius.db.aurasBuffsRelativePoint, Gladius.db.aurasBuffsOffsetX, Gladius.db.aurasBuffsOffsetY)
		-- size
		self.buffFrame[unit]:SetWidth(Gladius.db.aurasBuffsWidth * Gladius.db.aurasBuffsPerColumn + Gladius.db.aurasBuffsSpacingX * Gladius.db.aurasBuffsPerColumn)
		self.buffFrame[unit]:SetHeight(Gladius.db.aurasBuffsHeight * ceil(Gladius.db.aurasBuffsMax / Gladius.db.aurasBuffsPerColumn) + (Gladius.db.aurasBuffsSpacingY * (ceil(Gladius.db.aurasBuffsMax / Gladius.db.aurasBuffsPerColumn) + 1)))
		-- icon points
		local anchor, parent, relativePoint, offsetX, offsetY
		local start, startAnchor = 1, self.buffFrame[unit]
		-- grow anchor
		local grow1, grow2, grow3, startRelPoint
		if Gladius.db.aurasBuffsGrow == "DOWNRIGHT" then
			grow1, grow2, grow3, startRelPoint = "TOPLEFT", "BOTTOMLEFT", "TOPRIGHT", "TOPLEFT"
		elseif Gladius.db.aurasBuffsGrow == "DOWNLEFT" then
			grow1, grow2, grow3, startRelPoint = "TOPRIGHT", "BOTTOMRIGHT", "TOPLEFT", "TOPRIGHT"
		elseif Gladius.db.aurasBuffsGrow == "UPRIGHT" then
			grow1, grow2, grow3, startRelPoint = "BOTTOMLEFT", "TOPLEFT", "BOTTOMRIGHT", "BOTTOMLEFT"
		elseif Gladius.db.aurasBuffsGrow == "UPLEFT" then
			grow1, grow2, grow3, startRelPoint = "BOTTOMRIGHT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT"
		end
		for i = 1, Gladius.db.aurasBuffsMax do
			self.buffFrame[unit][i]:ClearAllPoints()
			if Gladius.db.aurasBuffsMax >= i then
				if start == 1 then
					anchor, parent, relativePoint, offsetX, offsetY = grow1, startAnchor, startRelPoint, 0, strfind(Gladius.db.aurasBuffsGrow, "DOWN") and - Gladius.db.aurasBuffsSpacingY or Gladius.db.aurasBuffsSpacingY
				else
					anchor, parent, relativePoint, offsetX, offsetY = grow1, self.buffFrame[unit][i - 1], grow3, strfind(Gladius.db.aurasBuffsGrow, "LEFT") and - Gladius.db.aurasBuffsSpacingX or Gladius.db.aurasBuffsSpacingX, 0
					if start == Gladius.db.aurasBuffsPerColumn then
						start = 0
						startAnchor = self.buffFrame[unit][i - Gladius.db.aurasBuffsPerColumn + 1]
						startRelPoint = grow2
					end
				end
				start = start + 1
			end
			self.buffFrame[unit][i]:SetPoint(anchor, parent, relativePoint, offsetX, offsetY)
			self.buffFrame[unit][i]:SetWidth(Gladius.db.aurasBuffsWidth)
			self.buffFrame[unit][i]:SetHeight(Gladius.db.aurasBuffsHeight)
			-- style action button
			self.buffFrame[unit][i].normalTexture:SetHeight(self.buffFrame[unit][i]:GetHeight() + self.buffFrame[unit][i]:GetHeight() * 0.4)
			self.buffFrame[unit][i].normalTexture:SetWidth(self.buffFrame[unit][i]:GetWidth() + self.buffFrame[unit][i]:GetWidth() * 0.4)
			self.buffFrame[unit][i].normalTexture:ClearAllPoints()
			self.buffFrame[unit][i].normalTexture:SetPoint("CENTER", 0, 0)
			self.buffFrame[unit][i]:SetNormalTexture("Interface\\AddOns\\Gladius\\Images\\Gloss")
			self.buffFrame[unit][i].texture:ClearAllPoints()
			self.buffFrame[unit][i].texture:SetPoint("TOPLEFT", self.buffFrame[unit][i], "TOPLEFT")
			self.buffFrame[unit][i].texture:SetPoint("BOTTOMRIGHT", self.buffFrame[unit][i], "BOTTOMRIGHT")
			self.buffFrame[unit][i].normalTexture:SetVertexColor(Gladius.db.aurasBuffsGlossColor.r, Gladius.db.aurasBuffsGlossColor.g, Gladius.db.aurasBuffsGlossColor.b, Gladius.db.aurasBuffsGloss and Gladius.db.aurasBuffsGlossColor.a or 0)
		end
		-- hide
		self.buffFrame[unit]:Hide()
	end
	-- update debuff frame
	if Gladius.db.aurasDebuffs then
		self.debuffFrame[unit]:ClearAllPoints()
		-- anchor point 
		local parent = Gladius:GetParent(unit, Gladius.db.aurasDebuffsAttachTo)
		self.debuffFrame[unit]:SetPoint(Gladius.db.aurasDebuffsAnchor, parent, Gladius.db.aurasDebuffsRelativePoint, Gladius.db.aurasDebuffsOffsetX, Gladius.db.aurasDebuffsOffsetY)
		-- size
		self.debuffFrame[unit]:SetWidth(Gladius.db.aurasDebuffsWidth * Gladius.db.aurasDebuffsPerColumn + Gladius.db.aurasDebuffsSpacingX * Gladius.db.aurasDebuffsPerColumn)
		self.debuffFrame[unit]:SetHeight(Gladius.db.aurasDebuffsHeight * ceil(Gladius.db.aurasDebuffsMax / Gladius.db.aurasDebuffsPerColumn) + (Gladius.db.aurasDebuffsSpacingY * (ceil(Gladius.db.aurasDebuffsMax / Gladius.db.aurasDebuffsPerColumn) + 1)))
		-- icon points
		local anchor, parent, relativePoint, offsetX, offsetY
		local start, startAnchor = 1, self.debuffFrame[unit]
		-- grow anchor
		local grow1, grow2, grow3, startRelPoint
		if Gladius.db.aurasDebuffsGrow == "DOWNRIGHT" then
			grow1, grow2, grow3, startRelPoint = "TOPLEFT", "BOTTOMLEFT", "TOPRIGHT", "TOPLEFT"
		elseif Gladius.db.aurasDebuffsGrow == "DOWNLEFT" then
			grow1, grow2, grow3, startRelPoint = "TOPRIGHT", "BOTTOMRIGHT", "TOPLEFT", "TOPRIGHT"
		elseif Gladius.db.aurasDebuffsGrow == "UPRIGHT" then
			grow1, grow2, grow3, startRelPoint = "BOTTOMLEFT", "TOPLEFT", "BOTTOMRIGHT", "BOTTOMLEFT"
		elseif Gladius.db.aurasDebuffsGrow == "UPLEFT" then
			grow1, grow2, grow3, startRelPoint = "BOTTOMRIGHT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT"
		end	
		for i = 1, Gladius.db.aurasDebuffsMax do
			self.debuffFrame[unit][i]:ClearAllPoints()
			if Gladius.db.aurasDebuffsMax >= i then
				if start == 1 then
					anchor, parent, relativePoint, offsetX, offsetY = grow1, startAnchor, startRelPoint, 0, strfind(Gladius.db.aurasDebuffsGrow, "DOWN") and - Gladius.db.aurasDebuffsSpacingY or Gladius.db.aurasDebuffsSpacingY
				else
					anchor, parent, relativePoint, offsetX, offsetY = grow1, self.debuffFrame[unit][i - 1], grow3, strfind(Gladius.db.aurasDebuffsGrow, "LEFT") and - Gladius.db.aurasDebuffsSpacingX or Gladius.db.aurasDebuffsSpacingX, 0
					if start == Gladius.db.aurasDebuffsPerColumn then
						start = 0
						startAnchor = self.debuffFrame[unit][i - Gladius.db.aurasDebuffsPerColumn + 1]
						startRelPoint = grow2
					end
				end
				start = start + 1
			end
			self.debuffFrame[unit][i]:SetPoint(anchor, parent, relativePoint, offsetX, offsetY)
			self.debuffFrame[unit][i]:SetWidth(Gladius.db.aurasDebuffsWidth)
			self.debuffFrame[unit][i]:SetHeight(Gladius.db.aurasDebuffsHeight)
			-- style action button
			self.debuffFrame[unit][i].normalTexture:SetHeight(self.debuffFrame[unit][i]:GetHeight() + self.debuffFrame[unit][i]:GetHeight() * 0.4)
			self.debuffFrame[unit][i].normalTexture:SetWidth(self.debuffFrame[unit][i]:GetWidth() + self.debuffFrame[unit][i]:GetWidth() * 0.4)
			self.debuffFrame[unit][i].normalTexture:ClearAllPoints()
			self.debuffFrame[unit][i].normalTexture:SetPoint("CENTER", 0, 0)
			self.debuffFrame[unit][i]:SetNormalTexture("Interface\\AddOns\\Gladius\\Images\\Gloss")
			self.debuffFrame[unit][i].texture:ClearAllPoints()
			self.debuffFrame[unit][i].texture:SetPoint("TOPLEFT", self.debuffFrame[unit][i], "TOPLEFT")
			self.debuffFrame[unit][i].texture:SetPoint("BOTTOMRIGHT", self.debuffFrame[unit][i], "BOTTOMRIGHT")
			self.debuffFrame[unit][i].normalTexture:SetVertexColor(Gladius.db.aurasDebuffsGlossColor.r, Gladius.db.aurasDebuffsGlossColor.g, Gladius.db.aurasDebuffsGlossColor.b, Gladius.db.aurasDebuffsGloss and Gladius.db.aurasDebuffsGlossColor.a or 0)
		end
		-- hide
		self.debuffFrame[unit]:Hide()
	end
	-- event
	if not Gladius.db.aurasDebuffs and not Gladius.db.aurasBuffs then
		self:UnregisterAllEvents()
	else
		self:RegisterEvent("UNIT_AURA")
	end
end

function Auras:Show(unit)
	-- show/hide buff frame
	if Gladius.db.aurasBuffs then
		if self.buffFrame[unit] then
			self.buffFrame[unit]:Show()
			for i = 1, Gladius.db.aurasBuffsMax do
				self.buffFrame[unit][i]:Show()
			end
			for i = Gladius.db.aurasBuffsMax + 1, 40 do
				self.buffFrame[unit][i]:Hide()
			end
		end
	else
		if self.buffFrame[unit] then
			self.buffFrame[unit]:Hide()
			for i = 1, 40 do
				self.buffFrame[unit][i]:Hide()
			end
		end
	end
	-- show/hide debuff frame
	if Gladius.db.aurasDebuffs then
		if self.debuffFrame[unit] then
			self.debuffFrame[unit]:Show()
			for i = 1, Gladius.db.aurasDebuffsMax do
				self.debuffFrame[unit][i]:Show()
			end
			for i = Gladius.db.aurasDebuffsMax + 1, 40 do
				self.debuffFrame[unit][i]:Hide()
			end
		end
	else
		if self.debuffFrame[unit] then
			self.debuffFrame[unit]:Hide()
			for i = 1, 40 do
				self.debuffFrame[unit][i]:Hide()
			end
		end
	end
end

function Auras:Reset(unit)
	if self.buffFrame[unit] then
		-- hide buff frame
		self.buffFrame[unit]:Hide()
		for i = 1, 40 do
			self.buffFrame[unit][i].texture:SetTexture("")
			self.buffFrame[unit][i]:Hide()
		end
	end
	if self.debuffFrame[unit] then
		-- hide debuff frame
		self.debuffFrame[unit]:Hide()
		for i = 1, 40 do
			self.debuffFrame[unit][i].texture:SetTexture("")
			self.debuffFrame[unit][i]:Hide()
		end
	end
end

function Auras:Test(unit)
	-- test buff frame
	local testBuff = GetSpellTexture(21562)
	if self.buffFrame[unit] then
		for i = 1, Gladius.db.aurasBuffsMax do
			self.buffFrame[unit][i].texture:SetTexture(testBuff)
			self.buffFrame[unit][i].cooldown:SetReverse(Gladius.db.aurasBuffsTrackerCooldownReverse)
			Gladius:Call(Gladius.modules.Timer, "RegisterTimer", self.buffFrame[unit][i], Gladius.db.aurasBuffsTrackerCooldown, Gladius.db.aurasBuffsHideTimer)
			Gladius:Call(Gladius.modules.Timer, "SetTimer", self.buffFrame[unit][i], 10)
		end
	end
	-- test debuff frame
	local testDebuff = GetSpellTexture(589)
	if self.debuffFrame[unit] then
		for i = 1, Gladius.db.aurasDebuffsMax do
			self.debuffFrame[unit][i].texture:SetTexture(testDebuff)
			self.debuffFrame[unit][i].cooldown:SetReverse(Gladius.db.aurasDebuffsTrackerCooldownReverse)
			Gladius:Call(Gladius.modules.Timer, "RegisterTimer", self.debuffFrame[unit][i], Gladius.db.aurasDebuffsTrackerCooldown, Gladius.db.aurasDebuffsHideTimer)
			Gladius:Call(Gladius.modules.Timer, "SetTimer", self.debuffFrame[unit][i], 10)
		end
	end
end

function Auras:GetOptions()
	Gladius.db.aurasFrameAuras = Gladius.db.aurasFrameAuras or self:GetAuraList()
	local options = {
		buffs = {
			type = "group",
			name = L["Buffs"],
			childGroups = "tab",
			order = 1,
			args = {
				general = {
					type = "group",
					name = L["General"],
					order = 1,
					args = {
						widget = {
							type = "group",
							name = L["Widget"],
							desc = L["Widget settings"],
							inline = true,
							order = 1,
							args = {
								aurasBuffs = {
									type = "toggle",
									name = L["Auras Buffs"],
									desc = L["Toggle aura buffs"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 5,
								},
								aurasBuffsGrow = {
									type = "select",
									name = L["Auras Column Grow"],
									desc = L["Grow direction of the auras"],
									values = function()
										return {
											["UPLEFT"] = L["Up Left"],
											["UPRIGHT"] = L["Up Right"],
											["DOWNLEFT"] = L["Down Left"],
											["DOWNRIGHT"] = L["Down Right"],
										}
									end,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 10,
								},
								sep = {
									type = "description",
									name = "",
									width = "full",
									order = 13,
								},
								aurasBuffsPerColumn = {
									type = "range",
									name = L["Aura Icons Per Column"],
									desc = L["Number of aura icons per column"],
									min = 1,
									max = 50,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 15,
								},
								aurasBuffsMax = {
									type = "range",
									name = L["Aura Icons Max"],
									desc = L["Number of max buffs"],
									min = 1,
									max = 40,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 20,
								},
								sep2 = {
									type = "description",
									name = "",
									width = "full",
									order = 23,
								},
								aurasBuffsGloss = {
									type = "toggle",
									name = L["Auras Gloss"],
									desc = L["Toggle gloss on the auras icon"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 25,
								},
								aurasBuffsGlossColor = {
									type = "color",
									name = L["Auras Gloss Color"],
									desc = L["Color of the auras icon gloss"],
									get = function(info)
										return Gladius:GetColorOption(info)
									end,
									set = function(info, r, g, b, a)
										return Gladius:SetColorOption(info, r, g, b, a)
									end,
									hasAlpha = true,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 30,
								},
								sep3 = {
									type = "description",
									name = "",
									width = "full",
									order = 32,
								},
								aurasBuffsTrackerCooldown = {
									type = "toggle",
									name = L["Buffs Cooldown Spiral"],
									desc = L["Display the cooldown spiral for buffs"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 35,
								},
								aurasBuffsTrackerCooldownReverse = {
									type = "toggle",
									name = L["Buffs Cooldown Reverse"],
									desc = L["Invert the dark/bright part of the cooldown spiral"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 40,
								},
								aurasBuffsHideTimer = {
									type = "toggle",
									name = L["Hide Buff Timers"],
									desc = L["Hides the default timer on the buff frames."],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 45,
								},
							},
						},
						size = {
							type = "group",
							name = L["Size"],
							desc = L["Size settings"],
							inline = true,
							order = 2,
							args = {
								aurasBuffsWidth = {
									type = "range",
									name = L["Aura Icon Width"],
									desc = L["Width of the aura icons"],
									min = 10,
									max = 100,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 5,
								},
								aurasBuffsHeight = {
									type = "range",
									name = L["Aura Icon Height"],
									desc = L["Height of the aura icon"],
									min = 10,
									max = 100,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 10,
								},
								sep = {
									type = "description",
									name = "",
									width = "full",
									order = 13,
								},
								aurasBuffsSpacingY = {
									type = "range",
									name = L["Auras Spacing Vertical"],
									desc = L["Vertical spacing of the auras"],
									min = 0,
									max = 30,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 15,
								},
								aurasBuffsSpacingX = {
									type = "range",
									name = L["Auras Spacing Horizontal"],
									desc = L["Horizontal spacing of the auras"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									min = 0,
									max = 30,
									step = 1,
									order = 20,
								},
							},
						},
						position = {
							type = "group",
							name = L["Position"],
							desc = L["Position settings"],
							inline = true,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 3,
							args = {
								aurasBuffsAttachTo = {
									type = "select",
									name = L["Auras Attach To"],
									desc = L["Attach auras to the given frame"],
									values = function()
										return Gladius:GetModules(self.name)
									end,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									width = "double",
									order = 5,
								},
								sep = {
									type = "description",
									name = "",
									width = "full",
									order = 7,
								},
								aurasBuffsAnchor = {
									type = "select",
									name = L["Auras Anchor"],
									desc = L["Anchor of the auras"],
									values = function()
										return Gladius:GetPositions()
									end,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 10,
								},
								aurasBuffsRelativePoint = {
									type = "select",
									name = L["Auras Relative Point"],
									desc = L["Relative point of the auras"],
									values = function()
										return Gladius:GetPositions()
									end,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 15,
								},
								sep2 = {
									type = "description",
									name = "",
									width = "full",
									order = 17,
								},
								aurasBuffsOffsetX = {
									type = "range",
									name = L["Auras Offset X"],
									desc = L["X offset of the auras"],
									min = - 100,
									max = 100,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 20,
								},
								aurasBuffsOffsetY = {
									type = "range",
									name = L["Auras Offset Y"],
									desc = L["Y offset of the auras"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									min = - 50,
									max = 50,
									step = 1,
									order = 25,
								},
							},
						},
					},
				},
				--[[filter = {
					type = "group",
					name = L["Filter"],
					childGroups = "tree",
					hidden = function()
						return not Gladius.db.advancedOptions
					end,
					order = 2,
					args = {
						whitelist = {
							type = "group",
							name = L["Whitelist"],
							order = 1,
							args = {
							},
						},
						blacklist = {
							type = "group",
							name = L["Blacklist"],
							order = 2,
							args = {
							},
						},
						filterFunction = {
							type = "group",
							name = L["Filter Function"],
							order = 3,
							args = {
							},
						},
					},
				},]]
			},
		},
		debuffs = {
			type = "group",
			name = L["Debuffs"],
			childGroups = "tab",
			order = 2,
			args = {
				general = {
					type = "group",
					name = L["General"],
					order = 1,
					args = {
						widget = {
							type = "group",
							name = L["Widget"],
							desc = L["Widget settings"],
							inline = true,
							order = 1,
							args = {
								aurasDebuffs = {
									type = "toggle",
									name = L["Auras Debuffs"],
									desc = L["Toggle aura debuffs"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 5,
								},
								aurasDebuffsGrow = {
									type = "select",
									name = L["Auras Column Grow"],
									desc = L["Grow direction of the auras"],
									values = function()
										return {
											["UPLEFT"] = L["Up Left"],
											["UPRIGHT"] = L["Up Right"],
											["DOWNLEFT"] = L["Down Left"],
											["DOWNRIGHT"] = L["Down Right"],
										}
									end,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 10,
								},
								sep = {
									type = "description",
									name = "",
									width = "full",
									order = 13,
								},
								aurasDebuffsPerColumn = {
									type = "range",
									name = L["Aura Icons Per Column"],
									desc = L["Number of aura icons per column"],
									min = 1,
									max = 50,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 15,
								},
								aurasDebuffsMax = {
									type = "range",
									name = L["Aura Icons Max"],
									desc = L["Number of max Debuffs"],
									min = 1,
									max = 40,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 20,
								},
								sep2 = {
									type = "description",
									name = "",
									width = "full",
									order = 23,
								},
								aurasDebuffsGloss = {
									type = "toggle",
									name = L["Auras Gloss"],
									desc = L["Toggle gloss on the auras icon"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 25,
								},
								aurasDebuffsGlossColor = {
									type = "color",
									name = L["Auras Gloss Color"],
									desc = L["Color of the auras icon gloss"],
									get = function(info)
										return Gladius:GetColorOption(info)
									end,
									set = function(info, r, g, b, a)
										return Gladius:SetColorOption(info, r, g, b, a)
									end,
									hasAlpha = true,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 30,
								},
								sep3 = {
									type = "description",
									name = "",
									width = "full",
									order = 32,
								},
								aurasDebuffsTrackerCooldown = {
									type = "toggle",
									name = L["Debuffs Cooldown Spiral"],
									desc = L["Display the cooldown spiral for debuffs"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 35,
								},
								aurasDebuffsTrackerCooldownReverse = {
									type = "toggle",
									name = L["Debuffs Cooldown Reverse"],
									desc = L["Invert the dark/bright part of the cooldown spiral"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 40,
								},
								aurasDebuffsHideTimer = {
									type = "toggle",
									name = L["Hide Debuff Timers"],
									desc = L["Hides the default timer on the debuff frames."],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									hidden = function()
										return not Gladius.db.advancedOptions
									end,
									order = 45,
								},
							},
						},
						size = {
							type = "group",
							name = L["Size"],
							desc = L["Size settings"],
							inline = true,
							order = 2,
							args = {
								aurasDebuffsWidth = {
									type = "range",
									name = L["Aura Icon Width"],
									desc = L["Width of the aura icons"],
									min = 10,
									max = 100,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 5,
								},
								aurasDebuffsHeight = {
									type = "range",
									name = L["Aura Icon Height"],
									desc = L["Height of the aura icon"],
									min = 10,
									max = 100,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 10,
								},
								sep = {
									type = "description",
									name = "",
									width = "full",
									order = 13,
								},
								aurasDebuffsSpacingY = {
									type = "range",
									name = L["Auras Spacing Vertical"],
									desc = L["Vertical spacing of the auras"],
									min = 0,
									max = 30,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 15,
								},
								aurasDebuffsSpacingX = {
									type = "range",
									name = L["Auras Spacing Horizontal"],
									desc = L["Horizontal spacing of the auras"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									min = 0,
									max = 30,
									step = 1,
									order = 20,
								},
							},
						},
						position = {
							type = "group",
							name = L["Position"],
							desc = L["Position settings"],
							inline = true,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 3,
							args = {
								aurasDebuffsAttachTo = {
									type = "select",
									name = L["Auras Attach To"],
									desc = L["Attach auras to the given frame"],
									values = function()
										return Gladius:GetModules(self.name)
									end,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									width = "double",
									order = 5,
								},
								sep = {
									type = "description",
									name = "",
									width = "full",
									order = 7,
								},
								aurasDebuffsAnchor = {
									type = "select",
									name = L["Auras Anchor"],
									desc = L["Anchor of the auras"],
									values = function()
										return Gladius:GetPositions()
									end,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 10,
								},
								aurasDebuffsRelativePoint = {
									type = "select",
									name = L["Auras Relative Point"],
									desc = L["Relative point of the auras"],
									values = function()
										return Gladius:GetPositions()
									end,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 15,
								},
								sep2 = {
									type = "description",
									name = "",
									width = "full",
									order = 17,
								},
								aurasDebuffsOffsetX = {
									type = "range",
									name = L["Auras Offset X"],
									desc = L["X offset of the auras"],
									min = -100,
									max = 100,
									step = 1,
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									order = 20,
								},
								aurasDebuffsOffsetY = {
									type = "range",
									name = L["Auras Offset Y"],
									desc = L["Y offset of the auras"],
									disabled = function()
										return not Gladius.dbi.profile.modules[self.name]
									end,
									min = -50,
									max = 50,
									step = 1,
									order = 25,
								},
							},
						},
					},
				},
				--[[filter = {
					type = "group",
					name = L["Filter"],
					childGroups = "tree",
					hidden = function()
						return not Gladius.db.advancedOptions
					end,
					order = 2,
					args = {
						whitelist = {
							type = "group",
							name = L["Whitelist"],
							order = 1,
							args = {
							},
						},
						blacklist = {
							type = "group",
							name = L["Blacklist"],
							order = 2,
							args = {
							},
						},
						filterFunction = {
							type = "group",
							name = L["Filter Function"],
							order = 3,
							args = {
							},
						},
					},
				},]]
			},
		},
		auraList = {
			type = "group",
			name = L["Auras"],
			childGroups = "tree",
			order = 3,
			args = {
				newAura = {
					type = "group",
					name = L["New Aura"],
					desc = L["New Aura"],
					inline = true,
					order = 1,
					args = {
						name = {
							type = "input",
							name = L["Name"],
							desc = L["Name of the aura"],
							get = function()
								return Auras.newAuraName or ""
							end,
							set = function(info, value)
								Auras.newAuraName = value
							end,
							order = 1,
						},
						priority = {
							type = "range",
							name = L["Priority"],
							desc = L["Select what priority the aura should have - higher equals more priority"],
							get = function()
								return Auras.newAuraPriority or ""
							end,
							set = function(info, value)
								Auras.newAuraPriority = value
							end,
							min = 0,
							max = 20,
							step = 1,
							order = 2,
						},
						add = {
							type = "execute",
							name = L["Add new Aura"],
							func = function(info)
								Gladius.dbi.profile.aurasFrameAuras[Auras.newAuraName] = Auras.newAuraPriority
								Gladius.options.args[self.name].args.auraList.args[Auras.newAuraName] = Auras:SetupAura(Auras.newAuraName, Auras.newAuraPriority)
							end,
							order = 3,
						},
					},
				},
			},
		},
	}
	-- set auras
	if not Gladius.db.aurasFrameAuras then
		Gladius.db.aurasFrameAuras = self:GetAuraList()
	end
	for aura, priority in pairs(Gladius.db.aurasFrameAuras) do
		options.auraList.args[aura] = self:SetupAura(aura, priority)
	end
	return options
end

local function setAura(info, value)
	if info[#(info)] == "name" then
		-- create new aura
		Gladius.options.args["ClassIcon"].args.auraList.args[value] = ClassIcon:SetupAura(value, Gladius.dbi.profile.aurasFrameAuras[info[#(info) - 1]])
		Gladius.dbi.profile.aurasFrameAuras[value] = Gladius.dbi.profile.aurasFrameAuras[info[#(info) - 1]]
		-- delete old aura
		Gladius.dbi.profile.aurasFrameAuras[info[#(info) - 1]] = nil 
		Gladius.options.args["ClassIcon"].args.auraList.args = { }
		for aura, priority in pairs(Gladius.dbi.profile.aurasFrameAuras) do
			Gladius.options.args["ClassIcon"].args.auraList.args[aura] = ClassIcon:SetupAura(aura, priority)
		end
	else
		Gladius.dbi.profile.aurasFrameAuras[info[#(info) - 1]] = value
	end
end

local function getAura(info)
	if info[#(info)] == "name" then
		return info[#(info) - 1]
	else
		return Gladius.dbi.profile.aurasFrameAuras[info[#(info) - 1]]
	end
end

function Auras:SetupAura(aura, priority)
	return {
		type = "group",
		name = aura,
		desc = aura,
		get = getAura,
		set = setAura,
		args = {
			name = {
				type = "input",
				name = L["Name"],
				desc = L["Name of the aura"],
				order = 1,
			},
			priority = {
				type = "range",
				name = L["Priority"],
				desc = L["Select what priority the aura should have - higher equals more priority"],
				min = 0,
				max = 20,
				step = 1,
				order = 2,
			},
			delete = {
				type = "execute",
				name = L["Delete"],
				func = function(info)
					Gladius.dbi.profile.aurasFrameAuras[info[#(info) - 1]] = nil
					local newAura = Gladius.options.args["Auras"].args.auraList.args.newAura
					Gladius.options.args["Auras"].args.auraList.args = {
						newAura = newAura,
					}
					for aura, priority in pairs(Gladius.dbi.profile.aurasFrameAuras) do
						Gladius.options.args["Auras"].args.auraList.args[aura] = self:SetupAura(aura, priority)
					end
				end,
				order = 3,
			},
		},
	}
end

function Auras:GetAuraList()
	local auraTable = setmetatable({
		-- Higher Number is More Priority
		-- Priority List by P0rkz
		-- Mobility Auras (0)
		[GetSpellInfo(108843)]	= 0,	-- Blazing Speed
		[GetSpellInfo(65081)]	= 0,	-- Body and Soul
		[GetSpellInfo(108212)]	= 0,	-- Burst of Speed
		[GetSpellInfo(68992)]	= 0,	-- Darkflight
		[GetSpellInfo(1850)]	= 0,	-- Dash
		[GetSpellInfo(137452)]	= 0,	-- Displacer Beast
		[GetSpellInfo(114239)]	= 0,	-- Phantasm
		[GetSpellInfo(118922)]	= 0,	-- Posthaste
		[GetSpellInfo(85499)]	= 0,	-- Speed of Light
		[GetSpellInfo(2983)]	= 0,	-- Sprint
		[GetSpellInfo(06898)]	= 0,	-- Stampeding Roar
		[GetSpellInfo(116841)]	= 0, 	-- Tiger's Lust
		-- Movement Reduction Auras (1)
		[GetSpellInfo(5116)]	= 1,	-- Concussive Shot
		[GetSpellInfo(120)]		= 1,	-- Cone of Cold
		[GetSpellInfo(13809)]	= 1,	-- Frost Trap
		-- Purgable Buffs (2)
		[GetSpellInfo(16188)]	= 2,	-- Ancestral Swiftness
		[GetSpellInfo(31842)]	= 2,	-- Divine Favor
		[GetSpellInfo(6346)]	= 2,	-- Fear Ward
		[GetSpellInfo(112965)]	= 2,	-- Fingers of Frost
		[GetSpellInfo(1044)]	= 2,	-- Hand of Freedom
		[GetSpellInfo(1022)]	= 2,	-- Hand of Protection
		[GetSpellInfo(114039)]	= 2,	-- Hand of Purity
		[GetSpellInfo(6940)]	= 2,	-- Hand of Sacrifice
		[GetSpellInfo(11426)]	= 2,	-- Ice Barrier
		[GetSpellInfo(53271)]	= 2,	-- Master's Call
		[GetSpellInfo(132158)]	= 2,	-- Nature's Swiftness
		[GetSpellInfo(69369)]	= 2,	-- Predatory Swiftness
		[GetSpellInfo(12043)]	= 2,	-- Presence of Mind
		[GetSpellInfo(48108)]	= 2,	-- Pyroblast!
		-- Defensive - Damage Redution Auras (3)
		[GetSpellInfo(108978)]	= 3,	-- Alter Time
		[GetSpellInfo(108271)]	= 3,	-- Astral Shift
		[GetSpellInfo(22812)]	= 3,	-- Barkskin
		[GetSpellInfo(18499)]	= 3,	-- Berserker Rage
		[GetSpellInfo(111397)]	= 3,	-- Blood Horror
		[GetSpellInfo(74001)]	= 3,	-- Combat Readiness
		[GetSpellInfo(31224)]	= 3,	-- Cloak of Shadows
		[GetSpellInfo(108359)]	= 3,	-- Dark Regeneration
		[GetSpellInfo(118038)]	= 3,	-- Die by the Sword
		[GetSpellInfo(498)]		= 3,	-- Divine Protection
		[GetSpellInfo(5277)]	= 3,	-- Evasion
		[GetSpellInfo(47788)]	= 3,	-- Guardian Spirit
		[GetSpellInfo(48792)]	= 3,	-- Icebound Fortitude
		[GetSpellInfo(1463)]	= 3,	-- Incanter's Ward
		[GetSpellInfo(116267)]	= 3,	-- Incanter's Absorption
		[GetSpellInfo(66)]		= 3,	-- Invisibility
		[GetSpellInfo(102342)]	= 3,	-- Ironbark
		[GetSpellInfo(12975)]	= 3,	-- Last Stand
		[GetSpellInfo(49039)]	= 3,	-- Lichborne
		[GetSpellInfo(116849)]	= 3,	-- Life Cocoon
		[GetSpellInfo(114028)]	= 3,	-- Mass Spell Reflection
		[GetSpellInfo(30884)]	= 3,	-- Nature's Guardian
		[GetSpellInfo(124974)]	= 3,	-- Nature's Vigil
		[GetSpellInfo(137562)]	= 3,	-- Nimble Brew
		[GetSpellInfo(33206)]	= 3,	-- Pain Suppression
		[GetSpellInfo(53480)]	= 3,	-- Roar of Sacrifice
		[GetSpellInfo(30823)]	= 3,	-- Shamanistic Rage
		[GetSpellInfo(871)]		= 3,	-- Shield Wall
		[GetSpellInfo(112833)]	= 3,	-- Spectral Guise
		[GetSpellInfo(23920)]	= 3,	-- Spell Reflection
		-- Offensive - Melee Auras (4)
		[GetSpellInfo(13750)]	= 4,	-- Adrenaline Rush
		[GetSpellInfo(107574)]	= 4,	-- Avatar
		[GetSpellInfo(106952)]	= 4,	-- Berserk
		[GetSpellInfo(12292)]	= 4,	-- Bloodbath
		[GetSpellInfo(51271)]	= 4,	-- Pillar of Frost
		[GetSpellInfo(1719)]	= 4,	-- Recklessness
		[GetSpellInfo(51713)]	= 4,	-- Shadow Dance
		-- Roots (5)
		[GetSpellInfo(91807)]	= 5,	-- Shambling Rush (Ghoul)
		[GetSpellInfo(96294)]	= 5,	-- Chains of Ice (Chilblains)
		[GetSpellInfo(61685)]	= 5,	-- Charge (Various)
		[GetSpellInfo(116706)]	= 5,	-- Disable
		[GetSpellInfo(87194)]	= 5,	-- Mind Blast (Glyphed)
		[GetSpellInfo(114404)]	= 5,	-- Void Tendrils
		[GetSpellInfo(64695)]	= 5,	-- Earthgrab
		[GetSpellInfo(64803)]	= 5,	-- Entrapment
		[GetSpellInfo(63685)]	= 5,	-- Freeze (Frozen Power)
		[GetSpellInfo(111340)]	= 5,	-- Ice Ward
		[GetSpellInfo(107566)]	= 5,	-- Staggering Shout
		[GetSpellInfo(339)]		= 5,	-- Entangling Roots
		[GetSpellInfo(113770)]	= 5,	-- Entangling Roots (Force of Nature)
		[GetSpellInfo(33395)]	= 5,	-- Freeze (Water Elemental)
		[GetSpellInfo(122)]		= 5,	-- Frost Nova
		[GetSpellInfo(102051)]	= 5,	-- Frostjaw
		[GetSpellInfo(102359)]	= 5,	-- Mass Entanglement
		[GetSpellInfo(136634)]	= 5,	-- Narrow Escape
		[GetSpellInfo(105771)]	= 5,	-- Warbringer
		-- Offensive - Ranged / Spell Auras (6)
		[GetSpellInfo(12042)]	= 6,	-- Arcane Power
		[GetSpellInfo(114049)]	= 6,	-- Ascendance
		[GetSpellInfo(31884)]	= 6,	-- Avenging Wrath
		[GetSpellInfo(113858)]	= 6,	-- Dark Soul: Instability
		[GetSpellInfo(113861)]	= 6,	-- Dark Soul: Knowledge
		[GetSpellInfo(113860)]	= 6,	-- Dark Soul: Misery
		[GetSpellInfo(16166)]	= 6,	-- Elemental Mastery
		[GetSpellInfo(12472)]	= 6,	-- Icy Veins
		[GetSpellInfo(33891)]	= 6,	-- Incarnation: Tree of Life
		[GetSpellInfo(102560)]	= 6,	-- Incarnation: Chosen of Elune
		[GetSpellInfo(102543)]	= 6,	-- Incarnation: King of the Jungle
		[GetSpellInfo(102558)]	= 6,	-- Incarnation: Son of Ursoc
		[GetSpellInfo(10060)]	= 6,	-- Power Infusion
		[GetSpellInfo(3045)]	= 6,	-- Rapid Fire
		[GetSpellInfo(48505)]	= 6,	-- Starfall
		-- Silence and Spell Immunities Auras (7)
		[GetSpellInfo(31821)]	= 7,	-- Devotion Aura
		[GetSpellInfo(115723)]	= 7,	-- Glyph of Ice Block
		[GetSpellInfo(8178)]	= 7,	-- Grounding Totem Effect
		[GetSpellInfo(131558)]	= 7,	-- Spiritwalker's Aegis
		[GetSpellInfo(104773)]	= 7,	-- Unending Resolve
		[GetSpellInfo(124488)]	= 7,	-- Zen Focus
		[GetSpellInfo(159630)]  = 7,    -- Shadow Magic
		-- Silence Auras (8)
		[GetSpellInfo(1330)]	= 8,	-- Garrote (Silence)
		[GetSpellInfo(15487)]	= 8,	-- Silence
		[GetSpellInfo(47476)]	= 8,	-- Strangulate
		[GetSpellInfo(31935)]	= 8,	-- Avenger's Shield
		[GetSpellInfo(137460)]	= 8,	-- Ring of Peace
		[GetSpellInfo(28730)]	= 8,	-- Arcane Torrent (Mana version)
		[GetSpellInfo(80483)]	= 8,	-- Arcane Torrent (Focus version)
		[GetSpellInfo(25046)]	= 8,	-- Arcane Torrent (Energy version)
		[GetSpellInfo(50613)]	= 8,	-- Arcane Torrent (Runic Power version)
		[GetSpellInfo(69179)]	= 8,	-- Arcane Torrent (Rage version)
		-- Disorients & Stuns Auras (9)
		[GetSpellInfo(108194)]	= 9,	-- Asphyxiate
		[GetSpellInfo(91800)]	= 9,	-- Gnaw (Ghoul)
		[GetSpellInfo(91797)]	= 9,	-- Monstrous Blow (Dark Transformation Ghoul)
		[GetSpellInfo(89766)]	= 9,	-- Axe Toss (Felguard)
		[GetSpellInfo(117526)]	= 9,	-- Binding Shot
		[GetSpellInfo(24394)]	= 9,	-- Intimidation
		[GetSpellInfo(105421)]	= 9,	-- Blinding Light
		[GetSpellInfo(7922)]	= 9,	-- Charge Stun
		[GetSpellInfo(119392)]	= 9,	-- Charging Ox Wave
		[GetSpellInfo(1833)]	= 9,	-- Cheap Shot
		[GetSpellInfo(118895)]	= 9,	-- Dragon Roar
		[GetSpellInfo(77505)]	= 9,	-- Earthquake
		[GetSpellInfo(120086)]	= 9,	-- Fist of Fury
		[GetSpellInfo(44572)]	= 9,	-- Deep Freeze
		[GetSpellInfo(99)]		= 9,	-- Disorienting Roar
		[GetSpellInfo(31661)]	= 9,	-- Dragon's Breath
		[GetSpellInfo(123393)]	= 9,	-- Breath of Fire (Glyphed)
		[GetSpellInfo(105593)]	= 9,	-- Fist of Justice
		[GetSpellInfo(47481)]	= 9,	-- Gnaw
		[GetSpellInfo(1776)]	= 9,	-- Gouge
		[GetSpellInfo(853)]		= 9,	-- Hammer of Justice
		[GetSpellInfo(119072)]	= 9,	-- Holy Wrath
		[GetSpellInfo(88625)]	= 9,	-- Holy Word: Chastise
		[GetSpellInfo(19577)]	= 9,	-- Intimidation
		[GetSpellInfo(408)]		= 9,	-- Kidney Shot
		[GetSpellInfo(119381)]	= 9,	-- Leg Sweep
		[GetSpellInfo(22570)]	= 9,	-- Maim
		[GetSpellInfo(5211)]	= 9,	-- Mighty Bash
		[GetSpellInfo(113801)]	= 9,	-- Bash (Treants)
		[GetSpellInfo(118345)]	= 9,	-- Pulverize (Primal Earth Elemental)
		[GetSpellInfo(115001)]	= 9,	-- Remorseless Winter
		[GetSpellInfo(30283)]	= 9,	-- Shadowfury
		[GetSpellInfo(22703)]	= 9,	-- Summon Infernal
		[GetSpellInfo(46968)]	= 9,	-- Shockwave
		[GetSpellInfo(118905)]	= 9,	-- Static Charge (Capacitor Totem Stun)
		[GetSpellInfo(132169)]	= 9,	-- Storm Bolt
		[GetSpellInfo(20549)]	= 9,	-- War Stomp
		[GetSpellInfo(16979)]	= 9,	-- Wild Charge
		-- Crowd Controls Auras (10)
		[GetSpellInfo(710)]		= 10,	-- Banish
		[GetSpellInfo(2094)]	= 10,	-- Blind
		[GetSpellInfo(137143)]	= 10,	-- Blood Horror
		[GetSpellInfo(33786)]	= 10,	-- Cyclone
		[GetSpellInfo(605)]		= 10,	-- Dominate Mind
		[GetSpellInfo(118699)]	= 10,	-- Fear
		[GetSpellInfo(3355)]	= 10,	-- Freezing Trap
		[GetSpellInfo(51514)]	= 10,	-- Hex
		[GetSpellInfo(5484)]	= 10,	-- Howl of Terror
		[GetSpellInfo(5246)]	= 10,	-- Intimidating Shout
		[GetSpellInfo(115268)]	= 10,	-- Mesmerize (Shivarra)
		[GetSpellInfo(6789)]	= 10,	-- Mortal Coil
		[GetSpellInfo(115078)]	= 10,	-- Paralysis
		[GetSpellInfo(118)]		= 10,	-- Polymorph
		[GetSpellInfo(8122)]	= 10,	-- Psychic Scream
		[GetSpellInfo(64044)]	= 10,	-- Psychic Horror
		[GetSpellInfo(20066)]	= 10,	-- Repentance
		[GetSpellInfo(82691)]	= 10,	-- Ring of Frost
		[GetSpellInfo(6770)]	= 10,	-- Sap
		[GetSpellInfo(107079)]	= 10,	-- Quaking Palm
		[GetSpellInfo(6358)]	= 10,	-- Seduction (Succubus)
		[GetSpellInfo(9484)]	= 10,	-- Shackle Undead
		[GetSpellInfo(10326)]	= 10,	-- Turn Evil
		[GetSpellInfo(19386)]	= 10,	-- Wyvern Sting
		-- Immunity Auras (11)
		[GetSpellInfo(48707)]	= 11,	-- Anti-Magic Shell
		[GetSpellInfo(46924)]	= 11,	-- Bladestorm
		[GetSpellInfo(110913)]	= 11,	-- Dark Bargain
		[GetSpellInfo(19263)]	= 11,	-- Deterrence
		[GetSpellInfo(47585)]	= 11,	-- Dispersion
		[GetSpellInfo(642)]		= 11,	-- Divine Shield
		[GetSpellInfo(45438)]	= 11,	-- Ice Block
		-- Drink (12)
		[GetSpellInfo(118358)]	= 12,	-- Drink
	},
	{
	__index = function(t, index)
		if (index ~= nil) then
			return rawget(t, index)
		else
			return nil
		end
	end
	})
	return auraTable
end