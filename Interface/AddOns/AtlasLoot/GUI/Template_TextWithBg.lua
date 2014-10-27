local AtlasLoot = _G.AtlasLoot
local GUI = AtlasLoot.GUI

-- lua
local type = type
local pairs = pairs

-- WoW
local CreateFrame = CreateFrame

-- AtlasLoot
local getFrame = GUI.GetFrameByType
local delFrame = GUI.FreeFrameByType


local TEMPLATE_NAME = "GUI-TextFrame"
local BACKDROP_DATA = {bgFile = "Interface/Tooltips/UI-Tooltip-Background"}

local function OnEnter(self, owner)
	local tooltip = AtlasLoot.Tooltip:GetTooltip() 
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() * 0.5), 24)
	end
	tooltip:AddLine(self.tt1, nil, nil, nil, true)
	if self.tt2 then
		tooltip:AddLine(self.tt2, nil, nil, nil, true)
	end
	tooltip:Show()
end

local function OnLeave(self)
	AtlasLoot.Tooltip:GetTooltip():Hide()
end

local templateFunctions = {
	["Clear"] = function(self)
		delFrame(TEMPLATE_NAME, self)
		self:Hide()
	end,
	["SetText"] = function(self, txt)
		self.text:SetText(txt)
	end,
	["SetToolTip"] = function(self, line1, line2)
		if line1 then
			self:SetScript("OnEnter", OnEnter)
			self:SetScript("OnLeave", OnLeave)
			self.tt1 = line1
			self.tt2 = line2
		else
			self:SetScript("OnEnter", nil)
			self:SetScript("OnLeave", nil)
			self.tt1 = nil
			self.tt2 = nil
		end
	end,
	["SetFontObject"] = function(self, font)
		self.text:SetFontObject(font or "GameFontNormal")
	end,
}


function GUI.CreateTextWithBg(parent, width, height, bgColor, textColor)
	local frame = getFrame(TEMPLATE_NAME)
	if not frame then
		frame = CreateFrame("Frame")
		--frame:SetParent(SVF.frame.containerFrame)
		frame:SetSize(1, 1)
		frame:SetBackdrop(BACKDROP_DATA)
		frame:SetBackdropColor(0,1,0,1)
	
		frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		frame.text:SetAllPoints(frame)
		frame.text:SetJustifyH("CENTER")
		
		for k,v in pairs(templateFunctions) do
			frame[k] = v
		end
	end
	frame:SetSize(width or 10, height or 10)
	if bgColor then
		frame:SetBackdropColor(bgColor.r or 1,bgColor.g or 1,bgColor.b or 1,bgColor.a or 1)
	else
		frame:SetBackdropColor(1,1,1,1)
	end
	if textColor then
		frame.text:SetTextColor(textColor.r or 0,textColor.g or 0,textColor.b or 0,textColor.a or 1)
	else
		frame.text:SetTextColor(0,0,0,1)
	end
	frame:ClearAllPoints()
	frame:SetParent(parent)
	return frame
end