------------------------------------------------------------
-- Core.lua
--
-- Displays direction arrows on out-ranged group members.
-- Thanks TomTom for the beautiful model file "Arrow.blp".
--
-- Abin
-- 2013/7/10
------------------------------------------------------------

local GetPlayerMapPosition = GetPlayerMapPosition
local atan = atan
local abs = abs
local floor = floor
local UnitIsPlayer = UnitIsPlayer
local UnitIsUnit = UnitIsUnit
local PI = math.pi

local L = CompactRaid:GetLocale("Direction")
local module = CompactRaid:CreateModule("Direction", L["title"], "1.0", L["desc"], "account")
if not module then return end

-- Parent frame of all arrow textures, I want all arrows stay opaque event if the unit frames become translucent due to range-out
local arrowPanel = CreateFrame("Frame", "CompactRaidDirectionArrowPanel", CompactRaid:GetMainFrame())
module.arrowPanel = arrowPanel
arrowPanel:SetFrameLevel(100)

function module:OnEnable()
	self:ShowVisuals(1)
end

function module:GetDefaultDB(key)
	if key == "account" then
		return { scale = 75, xoffset = 0, yoffset = 0, targetonly = 1 }
	end
end

function module:OnRestoreDefaults()
	self:EnumVisuals("SetScale", 1)
	self:EnumVisuals("ClearAllPoints")
	self:EnumVisuals("SetPoint", "CENTER", 0, 0)
end

------------------------------------------------------------
-- Calculate direction(0-359, in degrees) of the given unit
------------------------------------------------------------
--      0
--      |
-- 90---+---270
--      |
--     180
------------------------------------------------------------
local function CalcDirection(unit)
	local unitX, unitY = GetPlayerMapPosition(unit)
	if unitX == 0 and unitY == 0 then
		return
	end

	local playerX, playerY = GetPlayerMapPosition("player")

	local angle
	if unitX == playerX then
		angle = unitY > playerY and 0 or 180
	elseif unitY == playerY then
		angle = unitX > playerX and 270 or 90
	else
		angle = atan(-(unitY - playerY) / (unitX - playerX))
		if unitX > playerX then
			angle = angle + 270
		else
			angle = angle + 90
		end
	end

	local facing = GetPlayerFacing() * 180 / PI
	return (angle - facing) % 360
end

------------------------------------------------------------
-- Calculate texcoord using which we display the arrow
------------------------------------------------------------
local function CalcTexCoord(direction)
	local cell = floor(direction / 360 * 108 + 0.5)
	local column = cell % 9
	local row = floor(cell / 9)
	return column * 56 / 512, (column + 1) * 56 / 512, row * 42 / 512, (row + 1) * 42 / 512
end

------------------------------------------------------------
-- Calculate rgb values of the arrow color, green for 0, red
-- for 180, gradients in-between
------------------------------------------------------------
local function CalcGradientColor(direction)
	local diff = direction
	if diff > 180 then
		diff = 180 - diff + 180
	end

	local perc = diff / 180

	local r, g = 1, 0
	if perc >= 0.5 then
		r, g = 1, (1.0 - perc) * 2
	else
		r, g = perc * 2, 1
	end

	return r, g, 0
end

------------------------------------------------------------
-- Paint the arrow is applicable
------------------------------------------------------------
local function Visual_UpdateArrow(self)
	local direction
	local unit = self.unit
	if unit and not self.inRange and not self.offline and (not module.db.targetonly or UnitIsUnit(unit, "target")) then
		direction = CalcDirection(unit)
	end

	local arrow = self.arrow
	if direction then
		arrow:SetTexCoord(CalcTexCoord(direction))
		arrow:SetVertexColor(CalcGradientColor(direction))
		arrow:Show()
	else
		arrow:Hide()
	end
end

local function Visual_OnHide(self)
	self.unit = nil
	self.arrow:Hide()
end

local function Visual_OnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed > 0.1 then
		self.elapsed = 0
		Visual_UpdateArrow(self)
	end
end

------------------------------------------------------------
-- Do not set visual frame as parent of the arrow texture, it would
-- be hard to see when the unit frame goes translucent.
------------------------------------------------------------
function module:OnCreateVisual(visual, unitFrame, dynamic)
	visual:SetSize(70 / 2.5, 53 / 2.5)
	visual:SetScale(self.db.scale / 100)
	visual:SetPoint("CENTER", self.db.xoffset, self.db.yoffset)
	visual:SetScript("OnHide", Visual_OnHide)
	visual:SetScript("OnUpdate", Visual_OnUpdate)

	local arrow = arrowPanel:CreateTexture(nil, "ARTWORK")
	visual.arrow = arrow
	arrow:Hide()
	arrow:SetAllPoints(visual)
	arrow:SetTexture("Interface\\AddOns\\CompactRaid\\Modules\\Direction\\Arrow.blp")

	if self:IsEnabled() then
		visual:Show()
	end
end

------------------------------------------------------------
-- Only display arrows for group members, not the player itself, not pets.
------------------------------------------------------------
function module:OnUnitChange(frame, displayedUnit, unit, inVehicle, class)
	local visual = self:GetVisual(frame)
	if unit and unit ~= "player" and UnitIsPlayer(unit) then
		visual.unit = unit
	else
		visual.unit = nil
		visual.arrow:Hide()
	end
end

------------------------------------------------------------
-- Only display arrows for group members who are out of range.
------------------------------------------------------------
function module:OnRangeChange(frame, inRange)
	local visual = self:GetVisual(frame)
	visual.inRange = inRange
end

------------------------------------------------------------
-- Only display arrows for group members who are online.
------------------------------------------------------------
function module:OnUnitFlagChange(frame, flag)
	local visual = self:GetVisual(frame)
	visual.offline = flag == "offline"
end