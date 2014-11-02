local AtlasLoot = _G.AtlasLoot
local Faction = AtlasLoot.Button:AddType("Faction", "f")
--local AL = AtlasLoot.Locales
local ClickHandler = AtlasLoot.ClickHandler

-- lua
local tonumber = tonumber
local str_match, str_format = string.match, string.format

-- WoW
local UnitSex = UnitSex
local GetFactionInfoByID = GetFactionInfoByID

--[[
	-- rep info ("f1435rep3" = Unfriendly rep @ Shado-Pan Assault)
	1. Hated
	2. Hostile
	3. Unfriendly
	4. Neutral
	5. Friendly
	6. Honored
	7. Revered
	8. Exalted
]]

local FactionClickHandler
local PlayerSex

local TT_YES = "|cff00ff00"..YES
local TT_NO = "|cffff0000"..NO
local TT_YES_REV = "|cffff0000"..YES
local TT_NO_REV = "|cff00ff00"..NO

local FACTION_REP_COLORS
local FACTION_IMAGES = {
	[0] = "Interface\\Icons\\Achievement_Reputation_08",			-- dummy
	-- Classic
	
	-- BC
	
	-- WotLK
	
	-- Cata
	
	-- MoP
	[1435] = "Interface\\Icons\\achievement_faction_shadopan",		--Shado-Pan Assault
}

local function GetLocRepStanding(id)
	return PlayerSex==3 and _G["FACTION_STANDING_LABEL"..(id or 4).."_FEMALE"] or _G["FACTION_STANDING_LABEL"..(id or 4)]
end

local function RGBToHex(t)
	local r,g,b = t.r*255,t.g*255,t.b*255
	r = r <= 255 and r >= 0 and r or 0
	g = g <= 255 and g >= 0 and g or 0
	b = b <= 255 and b >= 0 and b or 0
	return str_format("%02x%02x%02x", r, g, b)
end

function Faction.OnSet(button, second)
	if not FactionClickHandler then
		FactionClickHandler = ClickHandler:Add(
		"Faction",
		{
			--ChatLink = { "LeftButton", "Shift" },
			types = {
				--ChatLink = true,
			},
		},
		AtlasLoot.db.profile.Button.Faction.ClickHandler, 
		{
			--{ "ChatLink", 	AL["Chat Link"], 	AL["Add item into chat"] },
		})

		PlayerSex = UnitSex("player")

		FACTION_REP_COLORS = {}
		for i = 1, #FACTION_BAR_COLORS do
			FACTION_REP_COLORS[i] = RGBToHex(FACTION_BAR_COLORS[i])
		end
		RGBToHex = nil
	end
	if not button then return end
	
	if second and button.__atlaslootinfo.secType then
		if type(button.__atlaslootinfo.secType[2]) == "table" then
			button.secButton.FactionID = button.__atlaslootinfo.secType[2][1]
			button.secButton.RepID = button.__atlaslootinfo.secType[2][2]
		else
			button.secButton.FactionID = button.__atlaslootinfo.secType[2]
		end
		Faction.Refresh(button.secButton)
	else
		if type(button.__atlaslootinfo.type[2]) == "table" then
			button.FactionID = button.__atlaslootinfo.type[2][1]
			button.RepID = button.__atlaslootinfo.type[2][2]
		else
			button.FactionID = button.__atlaslootinfo.type[2]
		end
		Faction.Refresh(button)
	end
end

function Faction.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = FactionClickHandler:Get(mouseButton)
	--if mouseButton == "ChatLink" then
		
	--end
end

function Faction.OnEnter(button, owner)
	if not button.FactionID then return end
	--[[
	local tooltip = AtlasLoot.Tooltip:GetTooltip() 
	tooltip:ClearLines()
	if owner and type(owner) == "table" then
		tooltip:SetOwner(unpack(owner))
	else
		tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 24)
	end
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar = GetFactionInfoByID(button.FactionID)
	tooltip:AddLine(name)
	tooltip:AddLine(description, 1, 1, 1, 1)
	tooltip:AddLine(" ")
	tooltip:AddLine(UnitName("player")..":")
	tooltip:AddDoubleLine(COMBAT_FACTION_CHANGE, string.format("|cFF%s%s ( %d / %d )", FACTION_REP_COLORS[standingID], GetLocRepStanding(standingID), barValue-barMin, barMax-barMin) )
	if canToggleAtWar then
		tooltip:AddDoubleLine(AT_WAR, atWarWith and TT_YES_REV or TT_NO_REV)
	end
	tooltip:Show()
	]]--
	Faction.ShowToolTipFrame(button)
end

function Faction.OnLeave(button)
	if Faction.tooltipFrame then 
		Faction.tooltipFrame:Hide() 	
	end
end

function Faction.OnClear(button)
	button.FactionID = nil
	button.secButton.FactionID = nil
	button.RepID = nil
	button.secButton.RepID = nil
	
	button.icon:SetDesaturated(false)
	button.secButton.icon:SetDesaturated(false)
end

function Faction.GetStringContent(str)
	if tonumber(str) then
		return tonumber(str)
	else
		return {
			tonumber(str_match(str, "(%d+)")),
			tonumber(str_match(str, "rep(%d+)")),	-- required rep (1-8)
		}
	end
end

function Faction.Refresh(button)
	if not button.FactionID then return end
	
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfoByID(button.FactionID)

	if button.type == "secButton" then
		button:SetNormalTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
	else	
		name = name or "Faction "..button.FactionID
		-- ##################
		-- icon
		-- ##################
		button.icon:SetTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
		
		-- ##################
		-- name
		-- ##################
		if button.RepID and standingID and button.RepID>standingID then
			button.icon:SetDesaturated(true)
			button.name:SetText("|cffff0000"..name)
		else
			button.name:SetText(name)
		end
		
		
		-- ##################
		-- description
		-- ##################
		button.extra:SetText("|cFF"..FACTION_REP_COLORS[button.RepID or standingID]..GetLocRepStanding(button.RepID or standingID))
	end

	return true
end

function Faction.ShowToolTipFrame(button)

	if not Faction.tooltipFrame then 
		local WIDTH = 200
		local name = "AtlasLoot-FactionToolTip"
		local frame = CreateFrame("Frame", name)
		frame:SetClampedToScreen(true)
		frame:SetWidth(WIDTH)
		frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
							edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
							tile = true, tileSize = 16, edgeSize = 16, 
							insets = { left = 4, right = 4, top = 4, bottom = 4 }})
		frame:SetBackdropColor(0,0,0,1)
		
		frame.icon = frame:CreateTexture(name.."-icon", frame)
		frame.icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
		frame.icon:SetHeight(15)
		frame.icon:SetWidth(15)
		frame.icon:SetTexture(FACTION_IMAGES[0])
		
		frame.name = frame:CreateFontString(name.."-name", "ARTWORK", "GameFontNormal")
		frame.name:SetPoint("TOPLEFT", frame.icon, "TOPRIGHT", 3, 0)
		frame.name:SetJustifyH("LEFT")
		frame.name:SetWidth(WIDTH-25)
		frame.name:SetHeight(15)
		--frame.name:SetTextColor(1, 1, 1, 1)
		
		frame.standing = CreateFrame("FRAME", name.."-standing", frame)
		frame.standing:SetWidth(WIDTH-10)
		frame.standing:SetHeight(20)
		frame.standing:SetPoint("TOPLEFT", frame.icon, "BOTTOMLEFT", 0, -1)
		frame.standing:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
							edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
							tile = true, tileSize = 16, edgeSize = 12, 
							insets = { left = 3, right = 3, top = 3, bottom = 3 }})
		frame.standing:SetBackdropColor(0, 0, 0, 1)
		
		frame.standing.bar = CreateFrame("StatusBar", name.."-standingBar", frame.standing)
		frame.standing.bar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
		frame.standing.bar:SetPoint("TOPLEFT", 3, -3)
		frame.standing.bar:SetPoint("BOTTOMRIGHT", -4, 3)
		frame.standing.bar:GetStatusBarTexture():SetHorizTile(false)
		frame.standing.bar:GetStatusBarTexture():SetVertTile(false)
		
		frame.standing.text = frame.standing.bar:CreateFontString(name.."-standingText", "ARTWORK", "GameFontNormalSmall")
		frame.standing.text:SetPoint("TOPLEFT", 3, -3)
		frame.standing.text:SetPoint("BOTTOMRIGHT", -4, 3)
		frame.standing.text:SetJustifyH("CENTER")
		frame.standing.text:SetJustifyV("CENTER")
		frame.standing.text:SetTextColor(1, 1, 1, 1)
		
		frame.desc = frame:CreateFontString(name.."-desc", "ARTWORK", "GameFontNormalSmall")
		frame.desc:SetPoint("TOPLEFT", frame.standing, "BOTTOMLEFT", 0, -1)
		frame.desc:SetJustifyH("LEFT")
		frame.desc:SetJustifyV("TOP")
		frame.desc:SetWidth(WIDTH-10)
		frame.desc:SetTextColor(1, 1, 1, 1)
		
		Faction.tooltipFrame = frame
	end
	local frame = Faction.tooltipFrame
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar = GetFactionInfoByID(button.FactionID)
	standingID = standingID or 1
	barMin, barMax, barValue = barMin or 0, barMax or 1, barValue or 0
	frame:ClearAllPoints()
	frame:SetParent(button:GetParent():GetParent())
	frame:SetFrameStrata("TOOLTIP")
	frame:SetPoint("BOTTOMLEFT", button, "TOPRIGHT")
	
	frame.icon:SetTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
	frame.name:SetText(name or "Faction "..button.FactionID)
	frame.desc:SetText(description)
	
	
	frame.standing.bar:SetMinMaxValues(barMin, barMax)
	frame.standing.bar:SetValue(barValue)
	frame.standing.bar:SetStatusBarColor(FACTION_BAR_COLORS[standingID].r, FACTION_BAR_COLORS[standingID].g, FACTION_BAR_COLORS[standingID].b)
	frame.standing.text:SetText(str_format("%s ( %d / %d )",GetLocRepStanding(standingID), barValue-barMin, barMax-barMin))
	
	frame:SetHeight(20+21+frame.desc:GetHeight()+5)
	frame:Show()
end

