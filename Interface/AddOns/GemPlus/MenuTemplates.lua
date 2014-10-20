------------------------------------------------------------
-- Menus.lua
--
-- Abin
-- 2013/6/18
------------------------------------------------------------

local CreateFrame = CreateFrame
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
local UIDropDownMenu_Initialize = UIDropDownMenu_Initialize
local CloseDropDownMenus = CloseDropDownMenus
local GetTradeSkillLine = GetTradeSkillLine
local UIFrameFade = UIFrameFade
local UIFrameFadeOut = UIFrameFadeOut

local _G = _G
local GameTooltip = GameTooltip
local CLOSE = CLOSE

local TRADESKILL_NAME = GetSpellInfo(25229) -- Get localized tradeskill name
local JEWEL_FILTER_NAME = "AuctionFilterButton8" -- As of 50300, 8 is the class index for jewels

local addonName, addon = ...

local function Menu_OnClick(self, prefix, menu)
	CloseDropDownMenus()

	if menu.OnCommand then
		menu:OnCommand(menu.editbox, prefix)
	else
		menu.editbox:SetText(prefix)
	end

	menu.editbox:ClearFocus()
end

local function Menu_DropdownInit(self, level, value)
	if not self.editbox then
		return
	end

	if not value then
		UIDropDownMenu_AddButton({ text = addonName, notCheckable = 1, isTitle = 1 })
	end

	local cache = self.cache
	addon:GetDataList(cache, value)

	local i
	for i = 1, #cache do
		local data = { notCheckable = 1 }
		if value then
			data.text, data.arg1, data.icon = addon:GetDataInfo(cache[i])
			data.func = Menu_OnClick
			data.arg2 = self
		else
			local key = cache[i]
			data.text = addon:GetDataInfo(key)
			data.menuList = key
			data.keepShownOnClick = 1
			data.hasArrow = 1
		end

		if data.text then
			data.text = data.text.."    "
		end

		UIDropDownMenu_AddButton(data, level)
	end

	if not value then
		UIDropDownMenu_AddButton({ text = CLOSE, notCheckable = 1 })
	end
end

local function Button_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:ClearLines()
	GameTooltip:AddLine(addonName)
	GameTooltip:Show()
end

local function Button_OnLeave(self)
	GameTooltip:Hide()
end

local function Button_ShineFadeOut(self)
	self.shining = nil
	UIFrameFadeOut(self.shine, 1)
end

local function Button_OnShow(self)
	self.shine:SetAlpha(0)
	self.shining = 1
	UIFrameFade(self.shine, { mode = "IN", timeToFade = 1, finishedFunc = Button_ShineFadeOut, finishedArg1 = self })
end

local function Menu_OnEvent(self, event)
	if self.runOnce then
		self:UnregisterEvent(event) -- Only run this event script once
	end

	if not self.editbox then
		local editbox = _G[self.editName]
		if not editbox then
			return
		end

		self.editbox = editbox
		self:SetParent(editbox)
		self.relativeTo = editbox

		local button = self.button
		button.editbox = editbox
		button:SetPoint("LEFT", editbox, "LEFT", -4, 0)

		if self.indent then
			editbox:SetTextInsets(18, 0, 0, 0)
		end
	end

	self:Hide()
	if not self.tradeskill or GetTradeSkillLine() == TRADESKILL_NAME then
		self:Show()
	end
end

local function CreateMenu(editName, tradeskill, runOnce, indent)
	local menu = CreateFrame("Frame", editName..addonName.."DropDownMenu", UIParent, "UIDropDownMenuTemplate")
	menu:Hide()
	menu.editName = editName
	menu.tradeskill = tradeskill
	menu.runOnce = runOnce
	menu.indent = indent
	menu.cache = {}
	menu.point = "TOPLEFT"
	menu.relativePoint = "BOTTOMLEFT"
	menu.xOffset = -10
	menu.yOffset = 0

	UIDropDownMenu_Initialize(menu, Menu_DropdownInit, "MENU")

	local button = _G[menu:GetName().."Button"]
	menu.button = button
	button:SetSize(18, 18)
	button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
	button:GetPushedTexture():SetAllPoints(button)
	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
	button:GetHighlightTexture():SetAllPoints(button)

	local icon = button:CreateTexture(nil, "ARTWORK")
	button.icon = icon
	icon:SetAllPoints(button)
	icon:SetTexture("Interface\\Icons\\Inv_Misc_Gem_01")

	local shine = CreateFrame("Frame", nil, button)
	button.shine = shine
	shine:SetAllPoints(button)
	shine:Hide()

	local texture = shine:CreateTexture(nil, "OVERLAY")
	texture:SetTexture("Interface\\ComboFrame\\ComboPoint")
	texture:SetBlendMode("ADD")
	texture:SetTexCoord(0.5625, 1, 0, 1)
	texture:SetSize(32, 50)
	texture:SetPoint("CENTER", 0, 2)

	button:SetScript("OnEnter", Button_OnEnter)
	button:SetScript("OnLeave", Button_OnLeave)
	button:SetScript("OnShow", Button_OnShow)

	menu:RegisterEvent(tradeskill and "TRADE_SKILL_SHOW" or "AUCTION_HOUSE_SHOW")
	menu:SetScript("OnEvent", Menu_OnEvent)

	return menu
end

function addon:AddSupport(editbox, tradeSkill, OnCommand)
	if type(editbox) ~= "string" then
		return
	end

	local menu = CreateMenu(editbox, tradeSkill, nil, 1)

	if type(OnCommand) == "function" then
		menu.OnCommand = OnCommand
	end
end

-- Create menu for build-in auction frame
local menu = CreateMenu("BrowseName", nil, 1, 1)

function menu:OnCommand(editbox, prefix)
	local canSearch = BrowseSearchButton:IsEnabled()

	if canSearch then
		if BrowseResetButton:IsEnabled() then
			BrowseResetButton:Click()
		end

		_G[JEWEL_FILTER_NAME]:Click()
	end

	editbox:SetText(prefix)

	if canSearch then
		BrowseSearchButton:Click()
	end
end

-- Create menu for build-in TradeSkill frame
addon:AddSupport("TradeSkillFrameSearchBox", 1)