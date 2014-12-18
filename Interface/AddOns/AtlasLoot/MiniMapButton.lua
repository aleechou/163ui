local AtlasLoot = _G.AtlasLoot
local MiniMapButton = {}
AtlasLoot.MiniMapButton = MiniMapButton
local SlashCommands = AtlasLoot.SlashCommands
local AL = AtlasLoot.Locales
local db

-- lua
local type = type
local abs, sqrt = math.abs, math.sqrt

-- WoW
local GetCursorPosition = GetCursorPosition

-- AL
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

function MiniMapButton.Init()
	db = AtlasLoot.db.MiniMapButton
	
	MiniMapButton.Show()
	
	SlashCommands:Add("mmb", MiniMapButton.Toggle, "/al mmb - Toggle MiniMapButton")
	SlashCommands:AddResetFunction(MiniMapButton.ResetFrames, "frames", "mmb")
	
end
AtlasLoot:AddInitFunc(MiniMapButton.Init)

function MiniMapButton.ResetFrames()
	if MiniMapButton.frame then
		db.point = { "CENTER", -65.35, -38.8 }
		MiniMapButton.frame:SetPoint(db.point[1], db.point[2], db.point[3])
	else
		db.point = false
	end
end

function MiniMapButton.Toggle()
	if not MiniMapButton.frame then MiniMapButton.Show() end
	db.shown = not db.shown
	if db.shown then
		MiniMapButton.Show()
	else
		if MiniMapButton.frame then
			MiniMapButton.frame:Hide()
		end
	end
end

function MiniMapButton.Options_Toggle()
	if not MiniMapButton.frame then MiniMapButton.Show() end
	if db.shown then
		MiniMapButton.Show()
	else
		if MiniMapButton.frame then
			MiniMapButton.frame:Hide()
		end
	end
end

function MiniMapButton:Hide()
	if self.frame then
		self.frame:Hide()
	end
end

local function OnButtonMove(self)
	if self.isMoving then
		local centerX, centerY = Minimap:GetCenter()
		local x, y = GetCursorPosition()
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
		centerX, centerY = abs(x), abs(y)
		centerX, centerY = (centerX / sqrt(centerX^2 + centerY^2)) * 80, (centerY / sqrt(centerX^2 + centerY^2)) * 80
		centerX = x < 0 and -centerX or centerX
		centerY = y < 0 and -centerY or centerY
		self:ClearAllPoints()
		self:SetPoint("CENTER", centerX, centerY)
	end
end

local function OnMouseDown(self)
	self.icon:SetPoint("TOPLEFT", 8, -7)
end

local function OnMouseUp(self)
	self.icon:SetPoint("TOPLEFT", 7, -6)
end

local function OnClick(self, button)
	if button == "RightButton" then return end
	if self then
		OnMouseUp(self)
	end
	if IsShiftKeyDown() then
		SlashCommands:Run("options")
	else
		SlashCommands:Run("")
	end
end

local function OnDragStart(self)
	self:LockHighlight()
	self:SetScript("OnUpdate", OnButtonMove)
	self.isMoving = true
	GameTooltip:Hide()
	OnMouseDown(self)
end

local function OnDragStop(self)
	self:SetScript("OnUpdate", nil)
	self:UnlockHighlight()
	self.isMoving = nil
	OnMouseUp(self)
	local a,b,c,d,e = self:GetPoint()
	db.point = { a, nil, c, d, e }
end

local function OnEnter(self)
	local tooltip = GetAlTooltip()
	tooltip:ClearLines()
	GameTooltip_SetDefaultAnchor(tooltip, self)
	tooltip:AddLine("|cff00FF00"..AL["AtlasLoot"].."|r")
	tooltip:AddLine(AL["|cffFF0000Click: |cffFFFFFFOpen AtlasLoot\n|cffFF0000Shift+Click: |cffFFFFFFOpen AtlasLoot-Options "])
	tooltip:Show()
end

local function OnLeave(self)
	GetAlTooltip():Hide()
end

function MiniMapButton.Show()
	if db.shown then
		if not MiniMapButton.frame then
			local frame = CreateFrame("Button", "AtlasLoot_MiniMapButton", Minimap)
			frame:SetSize(31, 31)
			frame:SetFrameStrata("MEDIUM")
			frame:SetFrameLevel(8)
			if db.point == false then
				db.point = { "CENTER", -65.35, -38.8 }
				frame:SetPoint(db.point[1], db.point[2], db.point[3])
				local a,b,c,d,e = frame:GetPoint()
				db.point = { a, nil, c, d, e }
			else
				frame:SetPoint(db.point[1], Minimap, db.point[3], db.point[4], db.point[5])
			end
			
			frame:SetMovable(true)
			frame:RegisterForDrag("LeftButton")
			frame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
			frame:SetScript("OnEnter", OnEnter)
			frame:SetScript("OnLeave", OnLeave)
			frame:SetScript("OnMouseDown", OnMouseDown)
			frame:SetScript("OnMouseUp", OnMouseUp)
			frame:SetScript("OnClick", OnClick)
			frame:SetScript("OnDragStart", OnDragStart)
			frame:SetScript("OnDragStop", OnDragStop)
			
			
			frame.overlay = frame:CreateTexture(nil, "OVERLAY")
			frame.overlay:SetSize(53, 53)
			frame.overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
			frame.overlay:SetPoint("TOPLEFT")
			
			frame.background = frame:CreateTexture(nil, "BACKGROUND")
			frame.background:SetSize(20, 20)
			frame.background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
			frame.background:SetPoint("TOPLEFT", 7, -5)
			
			frame.icon = frame:CreateTexture(nil, "ARTWORK")
			frame.icon:SetSize(20, 20)
			frame.icon:SetTexture("Interface\\Icons\\INV_Box_01")
			frame.icon:SetPoint("TOPLEFT", 7, -6)
				
			MiniMapButton.frame = frame
		end
		
		MiniMapButton.frame:Show()
	end
end

-- LDB
if not LibStub:GetLibrary("LibDataBroker-1.1", true) then return end

--Make an LDB object
local MiniMapLDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("AtlasLoot", {
    type = "launcher",
	text = AL["AtlasLoot"],
    icon = "Interface\\Icons\\INV_Box_01",
	OnTooltipShow = function(tooltip)
		tooltip:AddLine("|cff00FF00"..AL["AtlasLoot"].."|r");
		tooltip:AddLine(AL["|cffFF0000Click: |cffFFFFFFOpen AtlasLoot\n|cffFF0000Shift+Click: |cffFFFFFFOpen AtlasLoot-Options "]);
	end
})

function MiniMapLDB:OnClick(button,down)
	OnClick(nil, button)
end