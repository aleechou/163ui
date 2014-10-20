--[[
Copyright (c) 2009-2014, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.
]]

local Mapster = LibStub("AceAddon-3.0"):GetAddon("Mapster")
local L = LibStub("AceLocale-3.0"):GetLocale("Mapster")

local MODNAME = "Coords"
local Coords = Mapster:NewModule(MODNAME)

local GetCursorPosition = GetCursorPosition
local GetPlayerMapPosition = GetPlayerMapPosition
local WorldMapDetailFrame = WorldMapDetailFrame
local display, cursortext, playertext
local texttemplate, text = "%%s: %%.%df, %%.%df"

local MouseXY, OnUpdate

local db
local defaults = { 
	profile = {
		accuracy = 1,
		fontSize = 11,
		mini = {
			fontSize = 14,
		},
	}
}

local miniList = { fontSize = true }

local db_
local db = setmetatable({}, {
	__index = function(t, k)
		if Mapster.miniMap and miniList[k] then
			return db_.mini[k]
		else
			return db_[k]
		end
	end,
	__newindex = function(t, k, v)
		if Mapster.miniMap and miniList[k] then
			db_.mini[k] = v
		else
			db_[k] = v
		end
	end
})

local optGetter, optSetter
do
	local mod = Coords
	function optGetter(info)
		local key = info[#info]
		if key:sub(0,5) == "mini_" then
			return Coords.db.profile.mini[key:sub(6)]
		else
			return Coords.db.profile[key]
		end
	end

	function optSetter(info, value)
		local key = info[#info]
		if key:sub(0,5) == "mini_" then
			Coords.db.profile.mini[key:sub(6)] = value
		else
			Coords.db.profile[key] = value
		end
		mod:Refresh()
	end
end

local options
local function getOptions()
	if not options then
		options = {
			type = "group",
			name = L["Coordinates"],
			arg = MODNAME,
			get = optGetter,
			set = optSetter,
			args = {
				intro = {
					order = 1,
					type = "description",
					name = L["The Coordinates module adds a display of your current location, and the coordinates of your mouse cursor to the World Map frame."],
				},
				enabled = {
					order = 2,
					type = "toggle",
					name = L["Enable Coordinates"],
					get = function() return Mapster:GetModuleEnabled(MODNAME) end,
					set = function(info, value) Mapster:SetModuleEnabled(MODNAME, value) end,
				},
				accuracydesc = {
					order = 3,
					type = "description",
					name = "\n" .. L["You can control the accuracy of the coordinates, e.g. if you need very exact coordinates you can set this to 2."],
				},
				accuracy = {
					order = 4,
					type = "range",
					name = L["Accuracy"],
					min = 0, max = 2, step = 1,
				},
				fontSize = {
					order = 5,
					type = "range",
					name = L["Font Size"],
					desc = L["Font Size on the normal map."],
					min = 6, max = 18, step = 1,
				},
				mini_fontSize = {
					order = 6,
					type = "range",
					name = L["(Mini) Font Size"],
					desc = L["Font Size on the minimized map."],
					min = 6, max = 18, step = 1,
				}
			},
		}
	end

	return options
end

function Coords:OnInitialize()
	self.db = Mapster.db:RegisterNamespace(MODNAME, defaults)
	db_ = self.db.profile

	self:SetEnabledState(Mapster:GetModuleEnabled(MODNAME))
	Mapster:RegisterModuleOptions(MODNAME, getOptions, L["Coordinates"])
end

function Coords:OnEnable()
	if not display then
		display = CreateFrame("Frame", "Mapster_CoordsFrame", WorldMapFrame)
		display:SetFrameLevel(WorldMapFrame.UIElementsFrame:GetFrameLevel() + 20)

		cursortext = display:CreateFontString(nil, "OVERLAY")
		playertext = display:CreateFontString(nil, "OVERLAY")

		self:UpdateMapSize(Mapster.miniMap)

		cursortext:SetTextColor(1, 1, 1)
		playertext:SetTextColor(1, 1, 1)

		cursortext:SetPoint("TOPLEFT", WorldMapFrame.UIElementsFrame, "BOTTOM", 30, -5)
		playertext:SetPoint("TOPRIGHT", WorldMapFrame.UIElementsFrame, "BOTTOM", -30, -5)

		tinsert(Mapster.elementsToHide, display)
	end

	display:SetScript("OnUpdate", OnUpdate)
	if Mapster.bordersVisible then
		display:Show()
	else
		display:Hide()
	end

	self:Refresh()
end

function Coords:OnDisable()
	display:SetScript("OnUpdate", nil)
	display:Hide()
end

function Coords:Refresh()
	db_ = self.db.profile
	if not self:IsEnabled() then return end

	local acc = tonumber(db.accuracy) or 1
	text = texttemplate:format(acc, acc)
	self:UpdateMapSize(Mapster.miniMap)
end

function Coords:UpdateMapSize(mini)
	if not cursortext or not playertext then return end
	cursortext:SetFont(GameFontNormal:GetFont(), db.fontSize, "OUTLINE")
	playertext:SetFont(GameFontNormal:GetFont(), db.fontSize, "OUTLINE")
end

function MouseXY()
	local left, top = WorldMapDetailFrame:GetLeft(), WorldMapDetailFrame:GetTop()
	local width, height = WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight()
	local scale = WorldMapDetailFrame:GetEffectiveScale()

	local x, y = GetCursorPosition()
	local cx = (x/scale - left) / width
	local cy = (top - y/scale) / height

	if cx < 0 or cx > 1 or cy < 0 or cy > 1 then
		return
	end

	return cx, cy
end

local cursor, player = L["Cursor"], L["Player"]
function OnUpdate()
	local cx, cy = MouseXY()
	local px, py = GetPlayerMapPosition("player")

	if cx then
		cursortext:SetFormattedText(text, cursor, 100 * cx, 100 * cy)
	else
		cursortext:SetText("")
	end

	if px == 0 then
		playertext:SetText("")
	else
		playertext:SetFormattedText(text, player, 100 * px, 100 * py)
	end
end
