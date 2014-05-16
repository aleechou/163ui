-- $Id: LootButtons.lua 4232 2013-08-12 08:52:37Z dynaletik $
local _
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot")
local GREY = "|cff999999"
local RED = "|cffff0000"
local WHITE = "|cffFFFFFF"
local GREEN = "|cff1eff00"
local PURPLE = "|cff9F3FFF"
local BLUE = "|cff0070dd"
local ORANGE = "|cffFF8400"
local DEFAULT = "|cffFFd200"
local ParseTooltip_Enabled = false

local AtlasLootItemButton = {}

local function GetItemIcon(...) 
	return _G.GetItemIcon(...) or "Interface\\Icons\\INV_Misc_QuestionMark"
end

local function canUpgradeItem(itemId)
	if not itemId or type(itemId) ~= "number" then return end
	local itemName, itemLink, itemRarity, itemLevel = GetItemInfo(itemId)
	if itemLevel and itemLevel >= 458 and itemRarity and itemRarity >= 3 then
		if itemRarity == 3 then 	-- Rare
			return 451, { 452 }
		elseif itemRarity == 4 then	-- Epic
			return 445, { 446, 447 }
		end
	end
	return nil
end

local function createItemLink(itemId, cutomLvl, upgradeLvl)
	if not itemId or type(itemId) ~= "number" then return end
	local itemLink
	cutomLvl = cutomLvl or 0
	upgradeLvl = upgradeLvl or 0
	local upgradeStart, upgradeTab = canUpgradeItem(itemId)
	if upgradeStart then
		upgradeLvl = upgradeTab[upgradeLvl] or upgradeStart
		itemLink = "item:"..itemId..":0:0:0:0:0:0:0:"..cutomLvl..":0:"..upgradeLvl
	else
		itemLink = "item:"..itemId..":0:0:0:0:0:0:0:"..cutomLvl
	end
	return itemLink
end

local function bonusLootOnEnter(self)
	if self.Id then
		local name, desc = AtlasLoot:BonusLoot_GetSpecInfo(self.Id)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(name)
		GameTooltip:AddLine(WHITE..desc, nil, nil, nil, true)
		GameTooltip:Show()
	end
end

local TEMP_TABLE = {}
local CURRENCY_PRICE = {
	-- http://www.wowhead.com/currencies
	["CHEFAWARD"] = 402,		-- Chef's Award
	["CHAMPSEAL"] = 241,		-- Champion's Seal
	["CONQUEST"] = 390,		-- Conquest Points
	["DALARANJW"] = 61,		-- Dalaran Jewelcrafter's Token
	["DARKMOON"] = 515,		-- Darkmoon Prize Ticket
	["ELDERCHARM"] = 697,		-- Elder Charm of Good Fortune
	["EPICUREAN"] = 81,		-- Epicurean's Award (CookingDaily)
	["HONOR"] = 392,		-- Honor Points
	["ILLLJW"] = 361,		-- Illustrious Jewelcrafter's Token -- why duplicate?
	["CATAJW"] = 361,		-- Illustrious Jewelcrafter's Token -- why duplicate?
	["IRONPAW"] = 402,		-- Ironpaw Token (CookingDaily)
	["JUSTICE"] = 395,		-- Justice Points
	["TOLBARAD"] = 391,		-- Tol Barad Commendation
	["VALOR"] = 396,		-- Valor Points
	["WORLDTREE"] = 416,		-- Mark of the World Tree
	["TIMELESSCOIN"] = 777,		-- Timeless Coin
	["BLOODYCOIN"] = 789,		-- Bloody Coin

	-- Custom currencys
	["BREWFEST"] = { itemID = 37829 },			-- Brewfest
	["CHAMPWRIT"] = { itemID = 46114 },			-- Champion's Writ
	["HALLOWSEND"] = { itemID = 33226 },			-- Hallow's End
	["LUNARFESTIVAL"] = { itemID = 21100 },			-- Lunar Festival
	["MIDSUMMER"] = { itemID = 23247 },			-- Midsummer Fire Festival
	["NOBLEGARDEN"] = { itemID = 44791 },			-- Noblegarden
	["SPIRITSHARD"] = { itemID = 28558 },			-- World PvP - Terokkar Forest: Bone Wastes
	["VALENTINEDAY"] = { itemID = 49927 },			-- Love is in the Air
	["RELICULDUAR"] = { itemID = 42780 },			-- Relic of Ulduar (TransformationNonconsumedItems, ExplorersLeagueWarsongOffensive)
	["SPIRITOFHARMONY"] = { itemID = 76061 },		-- Spirit of Harmony (SmithingMoPVendor, LeatherworkingMoPVendor, TailoringMoPVendor, SpiritOfHarmony)
	["DOMINATIONCOMMISSION"] = { itemID = 91877 },		-- Domination Point Commission
	["LIONSLANDINGCOMMISSION"] = { itemID = 91838 },	-- Lion's Landing Commission
	["HISTORICALPARCHMENTS"] = { itemID = 95491 },		-- Tattered Historical Parchments
	--["KORKRONLUMBER"] = { itemID = 97530 },		-- Kor'kron Lumber
	--["KORKRONMEAT"] = { itemID = 97545 },			-- Kor'kron Meat
	--["KORKRONOIL"] = { itemID = 97544 },			-- Kor'kron Oil
	--["KORKRONSTONE"] = { itemID = 97543 },		-- Kor'kron Stone
	
	-- functions
	["ITEM"] = function(text, newText) 					-- USAGE: #ITEM:ID:AMOUNT#		EXAMPLE: #ITEM:1234:4#
		if string.find(text, "#ITEM:%d+:%d+#") then
			local _,_,itemID,price = string.find(text, "#ITEM:(%d+):(%d+)#")
			newText = gsub(newText, "#ITEM:%d+:%d+#", "")
			
			if not TEMP_TABLE["ITEM"] then TEMP_TABLE["ITEM"] = {} end
			TEMP_TABLE["ITEM"][itemID] = function(get, info)
				if get == "tooltip" then
					local count = GetItemCount(itemID)
					local countAll = GetItemCount(itemID, true)
					local color = ""
					local name, _, itemQuality = GetItemInfo(itemID)
					if countAll and tonumber(price) and countAll >= tonumber(price) then
						color = color..GREEN
					else
						color = color..RED
					end
					--info:SetHyperlink("item:"..TEMP_TABLE["TMP"]..":0:0:0")
					if name then
						itemQuality = select(4, GetItemQualityColor(itemQuality))
						name = "|c"..itemQuality..string.gsub(name, 1, 4)
						local icon = TEMP_TABLE["ITEM"][itemID]("icon")
						icon = icon and "|T"..icon..":16|t " or ""
						name = icon..name
					else
						name = _G["UNKNOWN"]
					end
					info:AddLine(name)
					if countAll == count then
						info:AddLine(color..count.." / "..price)
					else
						info:AddLine(color..string.format(AL["%d / %d ( Bank: %d )"], countAll, price, countAll - count))
					end
				elseif get == "click" then
					_, get = GetItemInfo(itemID)
					return price.." x "..get
				elseif get == "icon" then
					return GetItemIcon(itemID)
				end
			end
			
			return price, {"ITEM", itemID}, newText
		end
		return nil, nil, newText
	end,
}

function AtlasLoot:WipeItemInfoTempTable()
	wipe(TEMP_TABLE)
end

-- AtlasLoot:CreateItemButton
do
	local mt = {__index = AtlasLootItemButton}
	-- Creat a AtlasLoot ItemButton with:
	-- frames:		Icon, Name, ExtraText, Unsafe
	-- functions: 	SetButtonType, GetItemEquipInfo, Clear, Refresh, SetItem, SetSpell, SetLink
	-- for usage of the functions check the AtlasLootItemButton table
	-- @param parent The parent frame where the ItemButton is created
	-- @param point Sets the itemButton Position. This use frame:SetPoint(...)
	-- @param name The name of the ButtonFrame
	-- @return The itemButton
	-- @usage itemButton = AtlasLoot:CreateItemButton("AtlasLootItemsFrame", {"TOPLEFT", Frame, "TOPLEFT", 25, -35}, "AtlasLootItem_1")
	function AtlasLoot:CreateItemButton(parent, point, name)
		parent = parent or UIParent
		if not point or type(point) ~= "table" then point = {"TOPLEFT", parent, "TOPLEFT", 0, 0} end
		if not name or name == "" then
			--error("AtlasLoot:CreateItemButton: Enter a name.", 2)
			return
		end

		-- Set the metaTable
		local itemButton = setmetatable(
			{
				Frame = {},
				item = false,
				spell = false,
				tableLink = false,
				type = "ItemIcon",
			},
			mt
		)

		-- ########################
		-- Create the itemFrame ---
		-- ########################

		-- MainFrame <frame>
		itemButton.Frame = CreateFrame("Button", name, parent)
		itemButton.Frame:SetWidth(236)
		itemButton.Frame:SetHeight(28)
		itemButton.Frame:SetPoint(unpack(point));
		itemButton.Frame:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
		itemButton.Frame:RegisterForClicks("LeftButtonDown", "RightButtonDown")	
		itemButton.SetPoint = itemButton.Frame.SetPoint

		-- Icon <texture>
		itemButton.Frame.Icon = itemButton.Frame:CreateTexture(name.."_Icon", "ARTWORK")
		itemButton.Frame.Icon:SetPoint("TOPLEFT", itemButton.Frame, "TOPLEFT", 1, -1)
		itemButton.Frame.Icon:SetHeight(25)
		itemButton.Frame.Icon:SetWidth(25)

		-- Menu icon <texture>
		itemButton.Frame.MenuIcon = itemButton.Frame:CreateTexture(name.."_MenuIcon", "ARTWORK")
		itemButton.Frame.MenuIcon:SetPoint("TOPLEFT", itemButton.Frame, "TOPLEFT", 3, -3)
		itemButton.Frame.MenuIcon:SetHeight(20)
		itemButton.Frame.MenuIcon:SetWidth(20)

		-- Menu IconBorder <texture>
		itemButton.Frame.MenuIconBorder = itemButton.Frame:CreateTexture(nil, "OVERLAY")
		itemButton.Frame.MenuIconBorder:SetPoint("TOPLEFT", itemButton.Frame.MenuIcon, "TOPLEFT", -5, 5)
		itemButton.Frame.MenuIconBorder:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
		itemButton.Frame.MenuIconBorder:SetHeight(52)
		itemButton.Frame.MenuIconBorder:SetWidth(52)

		-- Query Icon <texture>
		itemButton.Frame.QueryIcon = itemButton.Frame:CreateTexture(name.."_QueryIcon", "OVERLAY")
		itemButton.Frame.QueryIcon:SetPoint("TOPLEFT", itemButton.Frame.Icon, "TOPLEFT", 0, 0)
		itemButton.Frame.QueryIcon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\arrow")
		itemButton.Frame.QueryIcon:SetHeight(25)
		itemButton.Frame.QueryIcon:SetWidth(25)
		itemButton.Frame.QueryIcon:Hide()

		-- ItemName <FontString>
		itemButton.Frame.Name = itemButton.Frame:CreateFontString(name.."_Name", "ARTWORK", "GameFontNormal")
		itemButton.Frame.Name:SetPoint("TOPLEFT", itemButton.Frame.Icon, "TOPRIGHT", 3, 0)
		itemButton.Frame.Name:SetJustifyH("LEFT")
		itemButton.Frame.Name:SetText("")
		itemButton.Frame.Name:SetWidth(205)
		itemButton.Frame.Name:SetHeight(12)

		-- ExtraText <FontString>
		itemButton.Frame.Extra = itemButton.Frame:CreateFontString(name.."_Extra", "ARTWORK", "GameFontNormalSmall")
		itemButton.Frame.Extra:SetPoint("TOPLEFT", itemButton.Frame.Name, "BOTTOMLEFT", 0, -1)
		itemButton.Frame.Extra:SetJustifyH("LEFT")
		itemButton.Frame.Extra:SetText("")
		itemButton.Frame.Extra:SetWidth(205)
		itemButton.Frame.Extra:SetHeight(10)

		-- Extra text for Quests/Achievements
		itemButton.Frame.QA = CreateFrame("Button", name.."_QA", itemButton.Frame)
		itemButton.Frame.QA:SetWidth(205)
		itemButton.Frame.QA:SetHeight(14)
		itemButton.Frame.QA:SetPoint("TOPLEFT", itemButton.Frame.Name, "BOTTOMLEFT", 0, -1)
		itemButton.Frame.QA:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
		itemButton.Frame.QA:RegisterForClicks("LeftButtonDown", "RightButtonDown")

		itemButton.Frame.QA.ExtraIcon = itemButton.Frame.QA:CreateTexture(name.."_QAExtraIcon", "OVERLAY")
		itemButton.Frame.QA.ExtraIcon:SetPoint("TOPLEFT", itemButton.Frame.QA, "TOPLEFT", 0, -1)
		itemButton.Frame.QA.ExtraIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		itemButton.Frame.QA.ExtraIcon:SetHeight(10)
		itemButton.Frame.QA.ExtraIcon:SetWidth(10)

		--- text
		itemButton.Frame.QA.ExtraText = itemButton.Frame.QA:CreateFontString(name.."_QAExtraText", "ARTWORK", "GameFontNormalSmall")
		itemButton.Frame.QA.ExtraText:SetPoint("TOPLEFT", itemButton.Frame.QA, "TOPLEFT", 13, -1)
		itemButton.Frame.QA.ExtraText:SetJustifyH("LEFT")
		itemButton.Frame.QA.ExtraText:SetText("TEST")
		itemButton.Frame.QA.ExtraText:SetWidth(192)
		itemButton.Frame.QA.ExtraText:SetHeight(10)

		itemButton.Frame.QA:SetScript("OnEnter", AtlasLoot.QAItemOnEnter)
		itemButton.Frame.QA:SetScript("OnLeave", AtlasLoot.QAItemOnLeave)
		itemButton.Frame.QA:SetScript("OnClick", AtlasLoot.QAItemOnClick)

		-- Unsafe <texture>
		itemButton.Frame.Unsafe = itemButton.Frame:CreateTexture(name.."_Unsafe", "BACKGROUND")
		itemButton.Frame.Unsafe:SetPoint("TOPLEFT", itemButton.Frame, "TOPLEFT")
		itemButton.Frame.Unsafe:SetHeight(27)
		itemButton.Frame.Unsafe:SetWidth(27)
		itemButton.Frame.Unsafe:SetTexture(1,0,0,1)
		itemButton.Frame.Unsafe:Hide()

		-- Item amount
		itemButton.Frame.IconAmount = itemButton.Frame:CreateFontString(name.."_IconAmount", "ARTWORK", "AtlasLoot_ItemAmountFont")
		itemButton.Frame.IconAmount:SetPoint("BOTTOMLEFT", itemButton.Frame.Icon, "BOTTOMLEFT",0,1)
		itemButton.Frame.IconAmount:SetJustifyH("RIGHT")
		itemButton.Frame.IconAmount:SetHeight(15)
		itemButton.Frame.IconAmount:SetWidth(25)
		itemButton.Frame.IconAmount:SetText()
		
		-- Bonus roll
		itemButton.Frame.BonusRoll = {}
		local numSpecs = 4 --GetNumSpecializations() or 4
		for i=1,4 do
			if i > numSpecs then break end
			itemButton.Frame.BonusRoll[i] = CreateFrame("Button", name.."_BonusRoll_Spec"..i, itemButton.Frame, "AtlasLoot_SpecButton")
			if i==1 then
				itemButton.Frame.BonusRoll[i]:SetPoint("TOPLEFT", itemButton.Frame.Icon, "TOPLEFT", 0, 0)
			elseif i==2 then
				itemButton.Frame.BonusRoll[i]:SetPoint("TOPLEFT", itemButton.Frame.Icon, "TOPLEFT", 12.5, 0)
			elseif i==3 then
				itemButton.Frame.BonusRoll[i]:SetPoint("TOPLEFT", itemButton.Frame.Icon, "TOPLEFT", 0, -12.5)
			elseif i==4 then
				itemButton.Frame.BonusRoll[i]:SetPoint("TOPLEFT", itemButton.Frame.Icon, "TOPLEFT", 12.5, -12.5)
			end
			itemButton.Frame.BonusRoll[i]:SetHeight(12.5)
			itemButton.Frame.BonusRoll[i]:SetWidth(12.5)
			itemButton.Frame.BonusRoll[i]:SetScript("OnEnter", bonusLootOnEnter)
			itemButton.Frame.BonusRoll[i]:SetScript("OnLeave", function() GameTooltip:Hide() end)
			--SetPortraitToTexture(itemButton.Frame.BonusRoll[i].specIcon, "Interface\\Icons\\INV_Misc_QuestionMark")

		end

		-- itemButton Scripts
		itemButton.Frame:SetScript("OnEnter", AtlasLoot.ItemOnEnter)
		itemButton.Frame:SetScript("OnLeave", AtlasLoot.ItemOnLeave)
		itemButton.Frame:SetScript("OnClick", AtlasLoot.ItemOnClick)
		itemButton.Frame:SetScript("OnShow", function() itemButton.Frame:SetFrameLevel( (itemButton.Frame:GetParent()):GetFrameLevel() + 1 ) end)
		itemButton.Frame:SetScript("OnEvent", AtlasLoot.ItemOnEvent)
		itemButton.Frame.par = itemButton
		-- Hide the button
		itemButton.Frame:Hide()

		return itemButton
	end

	-- AtlasLoot:CreateCompareFrameItemButton(nil, nil, "TestIt")
	--{ 2, 58155, "", "=q3=Cowl of Pleasant Gloom", "=ds=#s1#, #a1#", "#JUSTICE:2200#" },
	--button:SetItem(58155, "=q3=Cowl of Pleasant Gloom", "=ds=#s1#, #a1#", nil, nil, nil)
	-- /run button=AtlasLoot:CreateCompareFrameItemButton(nil, nil, "TestIt")button:SetItem(58155, "=q3=Cowl of Pleasant Gloom", "=ds=#s1#, #a1#", nil, "#JUSTICE:2200#", nil)
	function AtlasLoot:CreateCompareFrameItemButton(parent, point, name, statsList)
		parent = parent or UIParent
		if not point or type(point) ~= "table" then point = {"CENTER", parent, "CENTER"} end--point = {"TOPLEFT", parent, "TOPLEFT", 0, 0} end
		if not name or name == "" then
			--error("AtlasLoot:CreateItemButton: Enter a name.", 2)
			return
		end

		-- Set the metaTable
		local itemButton = setmetatable(
			{
				Frame = {},
				item = false,
				spell = false,
				tableLink = false,
				type = "CompareFrameItemButton",
				statsList = statsList,
				Stats = {},
				name = name,
			},
			mt
		)

		local sortMaxLength = 625
		local sortCurLenght = 0


		-- ########################
		-- Create the itemFrame ---
		-- ########################

		-- MainFrame <frame>
		itemButton.Frame = CreateFrame("Button", name, parent)
		itemButton.Frame:SetWidth(sortMaxLength)
		itemButton.Frame:SetHeight(37)
		itemButton.Frame:SetPoint(unpack(point));
		itemButton.Frame:RegisterForClicks("LeftButtonDown", "RightButtonDown")
		itemButton.Frame.SetAlpha = function() end	-- No Alpha change allowed here ;)
		itemButton.SetPoint = itemButton.Frame.SetPoint
		itemButton.Frame.par = itemButton

		-- Menu icon <texture>
		itemButton.Frame.MenuIcon = itemButton.Frame:CreateTexture(name.."_MenuIcon", "ARTWORK")
		itemButton.Frame.MenuIcon:SetPoint("TOPLEFT", itemButton.Frame, "TOPLEFT", 3, -3)
		itemButton.Frame.MenuIcon:SetHeight(32)
		itemButton.Frame.MenuIcon:SetWidth(32)
		itemButton.Frame.MenuIcon:Hide()

		-- Menu IconBorder <texture>
		itemButton.Frame.MenuIconBorder = itemButton.Frame:CreateTexture(nil, "OVERLAY")
		itemButton.Frame.MenuIconBorder:SetPoint("TOPLEFT", itemButton.Frame.MenuIcon, "TOPLEFT", -5, 5)
		itemButton.Frame.MenuIconBorder:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
		itemButton.Frame.MenuIconBorder:SetHeight(64)
		itemButton.Frame.MenuIconBorder:SetWidth(64)
		itemButton.Frame.MenuIconBorder:Hide()

		-- Query Icon <texture>
		itemButton.Frame.QueryIcon = itemButton.Frame:CreateTexture(name.."_QueryIcon", "OVERLAY")
		itemButton.Frame.QueryIcon:SetPoint("TOPLEFT", itemButton.Frame.Icon, "TOPLEFT", 0, 0)
		itemButton.Frame.QueryIcon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\arrow")
		itemButton.Frame.QueryIcon:SetHeight(25)
		itemButton.Frame.QueryIcon:SetWidth(25)
		itemButton.Frame.QueryIcon:Hide()

		-- ItemName <FontString>
		itemButton.Frame.Name = itemButton.Frame:CreateFontString(name.."_Name", "BACKGROUND", "GameFontNormal")
		itemButton.Frame.Name:SetPoint("TOPLEFT", itemButton.Frame, "TOPLEFT", 35, 0)
		itemButton.Frame.Name:SetJustifyH("LEFT")
		itemButton.Frame.Name:SetText("NAME")
		itemButton.Frame.Name:SetWidth(177)
		itemButton.Frame.Name:SetHeight(15)
		sortMaxLength = (sortMaxLength - 169) - 43

		-- ExtraText <FontString>
		itemButton.Frame.Extra = itemButton.Frame:CreateFontString(name.."_Extra", "BACKGROUND", "GameFontNormalSmall")
		itemButton.Frame.Extra:SetPoint("TOPLEFT", itemButton.Frame.Name, "BOTTOMLEFT", 0, -1)
		itemButton.Frame.Extra:SetJustifyH("LEFT")
		itemButton.Frame.Extra:SetText("EXTRA")
		itemButton.Frame.Extra:SetWidth(177)
		itemButton.Frame.Extra:SetHeight(10)

		-- Extra text for Quests/Achievements
		itemButton.Frame.QA = CreateFrame("Button", name.."_QA", itemButton.Frame)
		itemButton.Frame.QA:SetWidth(177)
		itemButton.Frame.QA:SetHeight(14)
		itemButton.Frame.QA:SetPoint("TOPLEFT", itemButton.Frame.Name, "BOTTOMLEFT", 0, -1)
		itemButton.Frame.QA:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
		itemButton.Frame.QA:RegisterForClicks("LeftButtonDown", "RightButtonDown")

		itemButton.Frame.QA.ExtraIcon = itemButton.Frame.QA:CreateTexture(name.."_QAExtraIcon", "OVERLAY")
		itemButton.Frame.QA.ExtraIcon:SetPoint("TOPLEFT", itemButton.Frame.QA, "TOPLEFT", 0, -1)
		itemButton.Frame.QA.ExtraIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		itemButton.Frame.QA.ExtraIcon:SetHeight(10)
		itemButton.Frame.QA.ExtraIcon:SetWidth(10)

		--- text
		itemButton.Frame.QA.ExtraText = itemButton.Frame.QA:CreateFontString(name.."_QAExtraText", "ARTWORK", "GameFontNormalSmall")
		itemButton.Frame.QA.ExtraText:SetPoint("TOPLEFT", itemButton.Frame.QA, "TOPLEFT", 13, -1)
		itemButton.Frame.QA.ExtraText:SetJustifyH("LEFT")
		itemButton.Frame.QA.ExtraText:SetText("TEST")
		itemButton.Frame.QA.ExtraText:SetWidth(164)
		itemButton.Frame.QA.ExtraText:SetHeight(10)

		-- Item amount
		itemButton.Frame.IconAmount = itemButton.Frame:CreateFontString(name.."_IconAmount", "ARTWORK", "AtlasLoot_ItemAmountFont")
		itemButton.Frame.IconAmount:SetPoint("BOTTOMLEFT", itemButton.Frame.Icon, "BOTTOMLEFT",0,1)
		itemButton.Frame.IconAmount:SetJustifyH("RIGHT")
		itemButton.Frame.IconAmount:SetHeight(15)
		itemButton.Frame.IconAmount:SetWidth(25)
		itemButton.Frame.IconAmount:SetText()

		itemButton.Frame.QA:SetScript("OnEnter", AtlasLoot.QAItemOnEnter)
		itemButton.Frame.QA:SetScript("OnLeave", AtlasLoot.QAItemOnLeave)
		itemButton.Frame.QA:SetScript("OnClick", AtlasLoot.QAItemOnClick)

		-- ############
		-- LAYER
		local left = itemButton.Frame:CreateTexture(nil, "BACKGROUND")
		left:SetPoint("LEFT", itemButton.Frame, "LEFT", 34, 2)
		left:SetWidth(10)
		left:SetHeight(32)
		left:SetTexture("Interface\\AuctionFrame\\UI-AuctionItemNameFrame")
		left:SetTexCoord(0, 0.078125, 0, 1.0)

		local right = itemButton.Frame:CreateTexture(nil, "BACKGROUND")
		right:SetPoint("RIGHT", itemButton.Frame, "RIGHT", 0, 2)
		right:SetWidth(10)
		right:SetHeight(32)
		right:SetTexture("Interface\\AuctionFrame\\UI-AuctionItemNameFrame")
		right:SetTexCoord(0.75, 0.828125, 0, 1.0)

		local center = itemButton.Frame:CreateTexture(nil, "BACKGROUND")
		center:SetPoint("LEFT", left, "RIGHT", 0, 0)
		center:SetPoint("RIGHT", right, "LEFT", 0, 0)
		center:SetWidth(10)
		center:SetHeight(32)
		center:SetTexture("Interface\\AuctionFrame\\UI-AuctionItemNameFrame")
		center:SetTexCoord(0.078125, 0.75, 0, 1.0)

		-- #########
		-- ITEM ICON
		local itemButtonButton = CreateFrame("BUTTON", "_ItemButtonButton", itemButton.Frame)
		itemButtonButton:SetWidth(32)
		itemButtonButton:SetHeight(32)
		itemButtonButton:SetPoint("TOPLEFT", itemButton.Frame, "TOPLEFT", 0, 0)
		itemButtonButton.par = itemButton
		itemButtonButton.GetName = function()
			return name
		end

		itemButton.Frame.Icon = itemButton.Frame:CreateTexture(nil, "BORDER")
		itemButton.Frame.Icon:SetPoint("TOPLEFT", itemButtonButton, "TOPLEFT", 0, 0)
		itemButton.Frame.Icon:SetWidth(32)
		itemButton.Frame.Icon:SetHeight(32)
		itemButton.Frame.Icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

		--itemButton.Frame.Icon:SetScript("OnEnter", itemButtonOnEnter)
		--itemButton.Frame.Icon:SetScript("OnLeave", itemButtonOnLeave)
		--itemButton.Frame.Icon:SetScript("OnClick", itemButtonOnClick)

		local normalTextureFrame = itemButton.Frame:CreateTexture(nil, "BORDER")
		normalTextureFrame:SetPoint("CENTER", itemButtonButton, "CENTER", 0, 0)
		normalTextureFrame:SetWidth(60)
		normalTextureFrame:SetHeight(60)
		normalTextureFrame:SetTexture("Interface\\Buttons\\UI-Quickslot2")

		itemButtonButton:SetNormalTexture(normalTextureFrame)
		itemButtonButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
		itemButtonButton:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
		-- ITEM ICON
		-- #########


		local highlightTextureMainFrame = itemButton.Frame:CreateTexture(name.."_Highlight", "BORDER")
		highlightTextureMainFrame:SetPoint("TOPLEFT", itemButton.Frame, "TOPLEFT", 33, 0)
		highlightTextureMainFrame:SetWidth(597-33)
		highlightTextureMainFrame:SetHeight(32)
		highlightTextureMainFrame:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
		highlightTextureMainFrame:SetTexCoord(0, 1.0, 0, 0.578125)
		highlightTextureMainFrame:Hide()

		itemButton.Frame:SetHighlightTexture(highlightTextureMainFrame, "ADD")
		-- LAYER
		-- ############

		-- ############
		-- STATS
		itemButton.Frame.Stats = {}

		if statsList then
			sortCurLenght = sortMaxLength / #statsList
			for k,v in ipairs(statsList) do
				itemButton.Frame.Stats[k] = itemButton.Frame:CreateFontString(name.."_Stats"..k, "BACKGROUND", "GameFontHighlightSmall")
				if k == 1 then
					itemButton.Frame.Stats[k]:SetPoint("TOPLEFT", itemButton.Frame.Name, "TOPRIGHT", 0, 0)
				else
					itemButton.Frame.Stats[k]:SetPoint("LEFT", itemButton.Frame.Stats[k-1], "RIGHT", 0, 0)
				end
				itemButton.Frame.Stats[k]:SetWidth(sortCurLenght)
				itemButton.Frame.Stats[k]:SetHeight(32)
				itemButton.Frame.Stats[k]:SetText(0)

				itemButton.Stats["ITEM_MOD_"..v.."_SHORT"] = itemButton.Frame.Stats[k]
			end
		end
		-- STATS
		-- ############

		-- Unsafe <texture>
		itemButton.Frame.Unsafe = itemButton.Frame:CreateTexture(name.."_Unsafe", "BACKGROUND")
		itemButton.Frame.Unsafe:SetPoint("TOPLEFT", itemButton.Frame, "TOPLEFT", -1, -1)
		itemButton.Frame.Unsafe:SetHeight(34)
		itemButton.Frame.Unsafe:SetWidth(27)
		itemButton.Frame.Unsafe:SetTexture(1,0,0,1)
		itemButton.Frame.Unsafe:Hide()

		-- itemButton Scripts
		itemButtonButton:SetScript("OnEnter", AtlasLoot.ItemOnEnter)
		itemButtonButton:SetScript("OnLeave", AtlasLoot.ItemOnLeave)
		itemButton.Frame:SetScript("OnClick", AtlasLoot.ItemOnClick)
		itemButtonButton:SetScript("OnClick", AtlasLoot.ItemOnClick)
		itemButton.Frame:SetScript("OnShow", function() itemButton.Frame:SetFrameLevel( (itemButton.Frame:GetParent()):GetFrameLevel() + 1 ) end)
		itemButton.Frame:SetScript("OnEvent", AtlasLoot.ItemOnEvent)
		itemButton.Frame.par = itemButton
		itemButton.itemButtonButton = itemButtonButton
		-- Hide the button
		--itemButton.Frame:Hide()

		itemButton.Frame.oriSetWidth = itemButton.Frame.SetWidth
		local cur = 0
		function itemButton.Frame:SetWidth(width)
			-- true = refresh
			if width == true then
				width = cur
				cur = 0
			end
			if width == cur then
				-- Do nothing
			elseif width == 597 then
				itemButton.Frame.Name:SetWidth( 177 - 25 )
				itemButton.Frame.Extra:SetWidth( 177 - 25 )
				itemButton.Frame.QA:SetWidth( 177 - 25 )
				itemButton.Frame.QA.ExtraText:SetWidth( 164 - 25 )
				local fixVaule = 409 / #self.par.statsList
				for i=1,#self.Stats do
					self.Stats[i]:SetWidth(fixVaule)
				end
				cur = width
				itemButton.Frame:oriSetWidth(width)
			elseif width == 625 then
				itemButton.Frame.Name:SetWidth( 177 )
				itemButton.Frame.Extra:SetWidth( 177 )
				itemButton.Frame.QA:SetWidth( 177 )
				itemButton.Frame.QA.ExtraText:SetWidth( 164 )
				local fixVaule = 413 / #self.par.statsList
				for i=1,#self.Stats do
					self.Stats[i]:SetWidth(fixVaule)
				end
				cur = width
				itemButton.Frame:oriSetWidth(width)
			end
		end

		return itemButton
	end


end

--- Sets the type of the button
-- AtlasLoot needs this, too check what things the button can do :o
-- @param item Button contains a item
-- @param spell Button contains a spell
-- @param tableLink TableLink to another loottable
-- @usage AtlasLootItemButton:SetButtonType(true, true, nil)
function AtlasLootItemButton:SetButtonType(item, spell, tableLink)
	if item then
		self.item = true
	elseif item == "" then
		self.item = self.item
	else
		self.item = false
	end
	if spell then
		self.spell = true
	elseif spell == "" then
		self.spell = self.spell
	else
		self.spell = false
	end
	if tableLink then
		self.tableLink = tableLink
	elseif tableLink == "" then
		self.tableLink = self.tableLink
	else
		self.tableLink = nil
	end
end

-- Set functions
do
	local dummyIcon = "Interface\\Icons\\INV_Misc_QuestionMark"
	local questIcon = "Interface\\MINIMAP\\TRACKING\\TrivialQuests"
	local achievementIcon = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-TinyShield"

	local function GetExtraPriceLink(text)
		local price, isPrice = nil, nil
		local tab = nil
		local newPrice = text
		if text then
			for k,v in pairs(CURRENCY_PRICE) do
				if type(v) == "function" then
					price, isPrice, newPrice = v(text, newPrice)
					if price and isPrice then
						if not tab then tab = {} end
						table.insert(tab, {tonumber(price), isPrice})
					end
				else
					if string.find(text, "#"..k..":%d+#") then
						_,_,price = string.find(text, "#"..k..":(%d+)#")
						newPrice = gsub(newPrice, "#"..k..":%d+#", "")
						if type(v) == "number" then
							isPrice = v
						elseif v["itemID"] then
							isPrice = k
						end
						if not tab then tab = {} end
						table.insert(tab, {tonumber(price), isPrice})
						--break
					end
				end
			end
		end
		if tab and #tab <= 0 then tab = nil end
		return tab, newPrice
	end 

	local function GetExtraTextLink(text)
		local tempText, isQuest, isAchievement, isItem = nil, nil, nil, nil
		if text and string.find(text, "#QUESTID:%d+#") then
			_,_,isQuest = string.find(text, "#QUESTID:(%d+)#")
			tempText = AtlasLoot:GetQuestName(isQuest)
			tempText = "|cffFFFFFF"..tempText
			tempText = gsub(text, "#QUESTID:%d+#", tempText)
		elseif text and string.find(text, "#ACHIEVEMENTID:%d+#") then
			_,_,isAchievement = string.find(text, "#ACHIEVEMENTID:(%d+)#")
			if GetAchievementLink(isAchievement) then
				tempText = select(2,GetAchievementInfo(isAchievement))
			else
				tempText = "ID:"..isAchievement.." not found"
			end
			tempText = "|cff1eff00"..tempText
			tempText = gsub(text, "#ACHIEVEMENTID:%d+#", tempText)
		elseif text and string.find(text, "#ITEMID:%d+#") then
			_,_,isItem = string.find(text, "#ITEMID:(%d+)#")
			local itemQuality
			tempText, _, itemQuality = GetItemInfo(isItem)
			if tempText then
				local _, _, _, itemQuality = GetItemQualityColor(itemQuality)
				tempText = "|c"..itemQuality..tempText
			else
				tempText = "|cffFFFFFF".._G["UNKNOWN"]
			end
			tempText = gsub(text, "#ITEMID:%d+#", tempText)
		end
		
		return tempText, isQuest, isAchievement, isItem
	end

	-- Create and returns the editet extra Text
	local function GetItemExtraText(itemID, extraText, price, itemName)
		local tempText, isQuest, isAchievement, isItem = GetExtraTextLink(extraText)
		local priceTab, newPrice = GetExtraPriceLink(price)
		local extraTextNew = extraText
		if itemName and ( not extraText or extraText == "" or extraText == "=ds=" ) then
			extraText = AtlasLoot:GetItemEquipInfo(itemID)
		end
		if not tempText and extraText and price and price ~= "" then
			-- lengh < 70  = standart
			-- this adds the ItemPrice to the Extratext if its not to long
			if AtlasLoot.db.profile.ShowPriceAndDesc and price ~= "=ds=" and price ~= "" then
				if extraText == "=ds=" or extraText == "" then
					if itemName then
						extraText = AtlasLoot:GetItemEquipInfo(itemID)
					elseif priceTab then
						--extraText = tempPrice or price
						for k,v in ipairs(priceTab) do
							extraText = extraText..tostring(v[1] or v[2])
						end
					end
				end
				local dummyText = ""
				if priceTab then
					for k,v in ipairs(priceTab) do
						dummyText = dummyText..tostring(v[1] or v[2])
					end
				end
				if dummyText and string.trim(dummyText) ~= "" then
					if extraText and extraText:trim() ~= "" and extraText:trim() ~= "=ds=" then
						dummyText = dummyText.." / "..AtlasLoot:FixText(extraText)
					end
				else
					dummyText = AtlasLoot:FixText(extraText)
				end
				local lengh = string.len(dummyText)
				if lengh < 50 then
					tempText = dummyText
				end
			end
			if not tempText or tempText == "" then
				if extraText == "=ds=" or extraText == "" then
					if itemName then
						extraText = AtlasLoot:GetItemEquipInfo(itemID)
					elseif priceTab then
						for k,v in ipairs(priceTab) do
							extraText = extraText..", "..tostring(v[2] or price)
						end
					end
				end
				if price == "=ds=" or price == "" then
					price = extraText
				end

				if AtlasLoot.db.profile.ShowLootTablePrice then
					if priceTab then
						--tempPrice, isPrice = GetExtraPriceLink(price)
						local extraText2 = ""
						local icon
						for k,v in ipairs(priceTab) do
							if k == 1 then
								extraText2 = extraText2..v[1]
							else
								if type(v[2]) == "number" then
									icon = select(3, GetCurrencyInfo(v[2]))
								elseif type(v[2]) == "table" and TEMP_TABLE[v[2][1]] then
									icon = TEMP_TABLE[v[2][1]][v[2][2]]("icon")
								elseif CURRENCY_PRICE[v[2]].itemID then
									icon = GetItemIcon(CURRENCY_PRICE[v[2]].itemID)
								end
								extraText2 = extraText2.." / |T"..icon..":15:15|t"..v[1]
							end	
						end
						if newPrice and newPrice:trim() ~= "" then
							tempText = extraText2.." / "..newPrice
						else
							tempText = extraText2
						end
					else
						tempText, isQuest, isAchievement, isItem = GetExtraTextLink(price)
						if not tempText then
							tempText = price
						end
					end
				else
					tempText = extraText
					priceTab = nil
				end
			end
			if not tempText or tempText == "" then
				tempText = extraText
			end
		elseif not tempText and price and price ~= "" then
			--if tempPrice then
			--	price, isQuest, isAchievement = GetExtraTextLink(extraText)
			--end
			--tempText = price
		elseif not tempText and extraText then
			tempText = extraText
		elseif not tempText and not extraText and itemName then
			tempText = AtlasLoot:GetItemEquipInfo(itemID)
		else
			--tempText = extraText
		end

		tempText = AtlasLoot:FixText(tempText)

		return tempText or "", isQuest, isAchievement, isItem, priceTab
	end

	local function Setup_ItemExtraText(self, itemID, extraText, itemPrice, itemNameNew)
		local tempText, isQuest, isAchievement, isItem, priceTab = GetItemExtraText(itemID, extraText, itemPrice, itemNameNew)

		if isQuest then
			self.Frame.Extra:Hide()
			self.Frame.QA:Show()
			self.Frame.QA.achievementID = nil
			self.Frame.QA.questID = isQuest
			self.Frame.QA.itemID = nil
			self.Frame.QA.price = nil
			self.Frame.QA.ExtraIcon:SetTexture(questIcon)
			self.Frame.QA.ExtraIcon:SetWidth(10)
			self.Frame.QA.ExtraIcon:SetHeight(10)
			self.Frame.QA.ExtraText:SetPoint("TOPLEFT", self.Frame.QA, "TOPLEFT", 10, -1)
			self.Frame.QA.ExtraText:SetText(tempText)
		elseif isAchievement then
			self.Frame.Extra:Hide()
			self.Frame.QA:Show()
			self.Frame.QA.achievementID = isAchievement
			self.Frame.QA.questID = nil
			self.Frame.QA.itemID = nil
			self.Frame.QA.price = nil
			self.Frame.QA.ExtraIcon:SetTexture(achievementIcon)
			self.Frame.QA.ExtraIcon:SetWidth(20)
			self.Frame.QA.ExtraIcon:SetHeight(20)
			self.Frame.QA.ExtraText:SetPoint("TOPLEFT", self.Frame.QA, "TOPLEFT", 12, -1)
			self.Frame.QA.ExtraText:SetText(tempText)
		elseif isItem then
			self.Frame.Extra:Hide()
			self.Frame.QA:Show()
			self.Frame.QA.achievementID = nil
			self.Frame.QA.questID = nil
			self.Frame.QA.itemID = isItem
			self.Frame.QA.price = nil
			self.Frame.QA.ExtraIcon:SetTexture(GetItemIcon(isItem))
			self.Frame.QA.ExtraIcon:SetWidth(12)
			self.Frame.QA.ExtraIcon:SetHeight(12)
			self.Frame.QA.ExtraText:SetPoint("TOPLEFT", self.Frame.QA, "TOPLEFT", 12, -2)
			self.Frame.QA.ExtraText:SetText(tempText)
		elseif priceTab then
			local icon
			--if type(isPrice[2]) == "number" then
			--	icon = select(3, GetCurrencyInfo(isPrice[2]))
			--else
			--	icon = GetItemIcon(CURRENCY_PRICE[isPrice[2]].itemID)
			--end
			if type(priceTab[1][2]) == "number" then
				icon = select(3, GetCurrencyInfo(priceTab[1][2]))
			elseif type(priceTab[1][2]) == "table" and TEMP_TABLE[priceTab[1][2][1]] then
				icon = TEMP_TABLE[priceTab[1][2][1]][priceTab[1][2][2]]("icon")
			else
				icon = GetItemIcon(CURRENCY_PRICE[priceTab[1][2]].itemID)
			end

			self.Frame.Extra:Hide()
			self.Frame.QA:Show()
			self.Frame.QA.achievementID = nil
			self.Frame.QA.questID = nil
			self.Frame.QA.itemID = nil
			self.Frame.QA.price = priceTab
			self.Frame.QA.ExtraIcon:SetTexture(icon)
			self.Frame.QA.ExtraIcon:SetWidth(12)
			self.Frame.QA.ExtraIcon:SetHeight(12)
			self.Frame.QA.ExtraText:SetPoint("TOPLEFT", self.Frame.QA, "TOPLEFT", 12, -2)
			self.Frame.QA.ExtraText:SetText(tempText)
		else
			self.Frame.QA.achievementID = nil
			self.Frame.QA.questID = nil
			self.Frame.QA.itemID = nil
			self.Frame.QA.price = nil
			self.Frame.QA:Hide()
			self.Frame.Extra:SetText(tempText)
			self.Frame.Extra:Show()
		end
		if self.Frame.QA:IsShown() and AtlasLoot.db.profile.EnableMouseOverDesc then
			self.Frame.QA:EnableMouse(true)
		else
			self.Frame.QA:EnableMouse(false)
		end
	end
	
	--- Sets a item to the button
	-- @param itemID The item ID
	-- @param itemName The item name, self is only used if the item name is not in the cache. Set to nil and not in cache it will use UNKNOWN
	-- @param extraText The small text under the item name. Set to nil and it will use slotInfo of the item if available
	-- @param itemTexture Sets a texture for the item icon. Set to nil and it will use the icon from the item ID
	-- @param itemPrice The item price (Arena, PVP, ...). Set self will hide the extra text if its to long
	-- @param itemDroprate The droprate of the item. Only a number value automatic adds "%"
	-- @param tooltipAdd adds a extra text too the tooltip
	-- @param tfItemID Thunderforged itemID
	-- @usage AtlasLootItemButton:SetItem(45038, "=q5=Fragment of Val'anyr", "=ds=#m3#", nil, nil, "40%")
	-- 
	function AtlasLootItemButton:SetItem(itemID, itemName, extraText, itemTexture, itemPrice, itemDroprate, tooltipAdd, tfItemID)
		self:Clear()
		if not itemID or type(itemID) ~= "number" then
			self:SetDummy(itemName, extraText, itemTexture)
			--error("AtlasLootItemButton:SetItem: Enter a itemID <number>", 2)
			return
		end
		if not self.info then
			self.info = { nil, itemID, itemName, extraText, itemTexture, itemPrice, itemDroprate, tooltipAdd, tfItemID }
		end
		if tfItemID and AtlasLoot.db.profile.ShowThunderforged then
			itemID = tfItemID
		end

		self:SetButtonType(true, false, nil)
		self:SetUpgradeLvl(AtlasLoot.db.profile.CurrentUpgradeLvl)
		self.Frame:Show()
		local tempText = ""
		local itemNameNew, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTextureNew = GetItemInfo(itemID)
		itemTextureNew = GetItemIcon(itemID)
		if not itemTextureNew then
			itemTextureNew = "Interface\\Icons\\INV_Misc_QuestionMark"
		end
		-- ########################
		-- itemName
		-- ########################
		if itemNameNew then
			_, _, _, itemQuality = GetItemQualityColor(itemQuality)
			tempText = itemQuality..string.gsub(itemNameNew, 1, 4)
			--if select(4, GetBuildInfo()) == 40200 then
				tempText = "|c"..tempText
			--end
		elseif itemName then
			tempText = AtlasLoot:FixText(itemName)
		else
			tempText = _G["UNKNOWN"]
		end
		local wishlist = ""
		if self.itemType and self.itemType[1] == "wishlist" then

		else
			wishlist = AtlasLoot:GetItemOnWishlistIconString(itemID)
			wishlist = wishlist or ""
		end

		self.Frame.Name:SetText(wishlist..tempText)
		tempText = ""

		-- ########################
		-- itemStats
		-- ########################
		if itemLink and self.type == "CompareFrameItemButton" and self.statsList then
			--self.Frame.Stats[1]:SetText(itemLevel)
			local stats = GetItemStats(itemLink)
			for k,v in ipairs(self.statsList) do
				if self.Stats["ITEM_MOD_"..v.."_SHORT"] then
					if v == "ITEMLVL" then
						self.Stats["ITEM_MOD_"..v.."_SHORT"]:SetText(itemLevel)
					elseif stats and stats["ITEM_MOD_"..v.."_SHORT"] then
						self.Stats["ITEM_MOD_"..v.."_SHORT"]:SetText(stats["ITEM_MOD_"..v.."_SHORT"])
					else
						self.Stats["ITEM_MOD_"..v.."_SHORT"]:SetText(0)
					end
				end
			end
		end
		--"CompareFrameItemButton"

		-- ########################
		-- extraText and itemPrice
		-- ########################
		Setup_ItemExtraText(self, itemID, extraText, itemPrice, itemNameNew)

		-- ########################
		-- itemTexture
		-- ########################
		if itemTexture == "?" then
			self:SetIcon("Interface\\Icons\\INV_Misc_QuestionMark")
		elseif itemTexture and type(itemTexture) == "string" and itemTexture ~= "" then
			self:SetIcon(itemTexture)
		else
			self:SetIcon(itemTextureNew)
		end

		-- ########################
		-- itemDroprate
		-- ########################
		if itemDroprate then
			if type(itemDroprate) == "number" then
				self.droprate = itemDroprate.."%"
			else
				self.droprate = itemDroprate
			end
		end
		
		-- ########################
		-- Thunderforged
		-- ########################
		self:RefreshThunderforge(tfItemID)		
		
		-- ########################
		-- BonusRoll
		-- ########################
		self:CheckBonusRoll(AtlasLoot.db.profile.BonusRollEnabled)
		
		-- ########################
		-- Unsafe
		-- ########################
		if not GetItemInfo(itemID) and itemID and itemID ~= 0 then
			self.Frame.Unsafe:Show()
		end
	end

	--- Sets a spell to the button
	-- @param spellID The spell ID
	-- @param itemID The item ID from the crafted spell
	-- @param spellName The spell name, self is only used if the spell name is not in the cache. Set to nil and not in cache it will use UNKNOWN
	-- @param extraText The small text under the spell name.
	-- @param itemTexture Sets a texture for the spell icon. Set to nil and it will use the icon from the spell ID
	-- @param itemPrice The item price (Arena, PVP, ...). Set self will hide the extraText if its to long
	-- @usage AtlasLootItemButton:SetSpell(60403, 44323, "=q3=Indestructible Alchemist Stone", "=ds="..AL["Trainer"], nil, nil)
	-- @param tooltipAdd adds a extra text too the tooltip
	function AtlasLootItemButton:SetSpell(spellID, itemID, spellName, extraText, spellTexture, itemPrice, tooltipAdd)
		self:Clear()
		if not spellID or type(spellID) ~= "number" then
			self:SetDummy(spellName, extraText, spellTexture)
			--error("AtlasLootItemButton:SetSpell: Enter a spellID <number>", 2)
			return
		end
		if not self.info then
			self.info = { spellID, itemID, spellName, extraText, spellTexture, itemPrice, nil, tooltipAdd }
		end
		self.Frame:Show()
		local tempText = ""
		local spellNameNew, _, spellTextureNew = GetSpellInfo(spellID)
		if itemID then
			spellTextureNew = GetItemIcon(itemID)
		end
		self:SetButtonType(false, true, nil)
		-- ########################
		-- spellName
		-- ########################
		if spellNameNew then
			tempText = AtlasLoot:FixText(string.sub(spellName, 1, 4)..spellNameNew)
		elseif spellName then
			tempText = AtlasLoot:FixText(spellName)
		else
			tempText = _G["UNKNOWN"]
		end
		--self.Frame.Name:SetText(tempText)
		local wishlist = ""
		if self.itemType and self.itemType[1] == "wishlist" then

		else
			wishlist = AtlasLoot:GetItemOnWishlistIconString(spellID)
			wishlist = wishlist or ""
		end
		self.Frame.Name:SetText(wishlist..tempText)
		tempText = ""

		-- ########################
		-- itemStats
		-- ########################
		if itemID and type(itemID) == "number" and itemID ~= 0 then
			local _, itemLink, _, itemLevel = GetItemInfo(itemID)
			if itemLink and self.type == "CompareFrameItemButton" and self.statsList then
				--self.Frame.Stats[1]:SetText(itemLevel)
				local stats = GetItemStats(itemLink)
				for k,v in ipairs(self.statsList) do
					if self.Stats["ITEM_MOD_"..v.."_SHORT"] then
						if v == "ITEMLVL" then
							self.Stats["ITEM_MOD_"..v.."_SHORT"]:SetText(itemLevel)
						elseif stats and stats["ITEM_MOD_"..v.."_SHORT"] then
							self.Stats["ITEM_MOD_"..v.."_SHORT"]:SetText(stats["ITEM_MOD_"..v.."_SHORT"])
						else
							self.Stats["ITEM_MOD_"..v.."_SHORT"]:SetText(0)
						end
					end
				end
			elseif self.type == "CompareFrameItemButton" then
				for k,v in ipairs(self.statsList) do
					if self.Stats["ITEM_MOD_"..v.."_SHORT"] then
						self.Stats["ITEM_MOD_"..v.."_SHORT"]:SetText(0)
					end
				end
			end
		end

		-- ########################
		-- extraText and itemPrice
		-- ########################
		Setup_ItemExtraText(self, itemID, extraText, itemPrice, spellNameNew)

		-- ########################
		-- itemTexture
		-- ########################
		if spellTexture == "?" then
			self:SetIcon("Interface\\Icons\\INV_Misc_QuestionMark")
		elseif spellTexture and type(spellTexture) == "string" and spellTexture ~= "" then
			self:SetIcon(spellTexture or dummyIcon)
		else
			self:SetIcon(spellTextureNew or dummyIcon)
		end

		-- ########################
		-- Unsafe
		-- ########################
		if not spellNameNew then
			self.Frame.Unsafe:Show()
		end
	end

	--- Sets a clickable MenuButton
	-- @param linkTab The AtlasLoot table name that open on click
	-- @param tabName The name of the table. Set to nil an it use the tableName
	-- @param tabExtraText The small text under the table name.
	-- @param iconTexture path to icon texture
	-- @param tooltipAdd adds a extra text too the tooltip
	function AtlasLootItemButton:SetMenu(linkTab, tabName, tabExtraText, iconTexture, tableLinkFunc, tooltipAdd)
		self:Clear()
		self.tableLinkFunc = tableLinkFunc
		self:SetLink(linkTab)
		if not self.tableLink then
			self:SetDummy(tabName, tabExtraText, iconTexture)
			--error("AtlasLootItemButton:SetMenu: Enter a available AtlasLoot table <string> ", 2)
			return
		end
		if not self.info then
			self.info = { nil, nil, tabName, tabExtraText, iconTexture, nil, nil, tooltipAdd }
		end
		self:SetButtonType(false, false, linkTab)
		self.Frame:Show()
		local tempText = ""
		-- ########################
		-- tabName
		-- ########################
		if tabName then
			tempText = AtlasLoot:FixText(tabName)
		else
			if AtlasLoot_Data[linkTab].info.name then
				tempText = AtlasLoot_Data[linkTab].info.name
			end
		end
		self.Frame.Name:SetText(tempText)
		tempText = ""

		-- ########################
		-- tabExtraText
		-- ########################
		Setup_ItemExtraText(self, nil, tabExtraText, nil, nil)

		-- ########################
		-- itemTexture
		-- ########################
		if iconTexture == "?" then
			self:SetIcon("Interface\\Icons\\INV_Misc_QuestionMark")
		elseif iconTexture and type(iconTexture) == "string" and iconTexture ~= "" then
			self:SetIcon(iconTexture)
		else
			self:SetIcon("Interface\\Icons\\INV_Misc_QuestionMark")
		end

		-- ########################
		-- Unsafe
		-- ########################
		self.Frame.Unsafe:Hide()
	end

	--- Sets a dummy button
	-- self button only have text and a icon
	-- @param name The name
	-- @param extraText The small text under the name.
	-- @param iconTexture path to icon texture
	function AtlasLootItemButton:SetDummy(name, extraText, iconTexture)
		self:Clear()
		self.Frame:Show()

		local tempText = ""
		-- ########################
		-- name
		-- ########################
		tempText = AtlasLoot:FixText(name or "")

		self.Frame.Name:SetText(tempText)
		tempText = ""

		-- ########################
		-- extraText
		-- ########################
		Setup_ItemExtraText(self, nil, extraText, nil, nil)

		-- ########################
		-- itemTexture
		-- ########################
		if iconTexture == "?" then
			self:SetIcon("Interface\\Icons\\INV_Misc_QuestionMark")
		elseif iconTexture and type(iconTexture) == "string" and iconTexture ~= "" then
			self:SetIcon(iconTexture)
		else
			self:SetIcon(nil)
		end

		-- ########################
		-- Unsafe
		-- ########################
		self.Frame.Unsafe:Hide()
	end
end

-- Update item stats font colors
function AtlasLootItemButton:UpdateStatsColor()
	--AtlasLoot.db.profile.CompareFrame.statsColor[v]
	for k,v in ipairs(self.statsList) do
		if self.Stats["ITEM_MOD_"..v.."_SHORT"] then
			self.Stats["ITEM_MOD_"..v.."_SHORT"]:SetTextColor(AtlasLoot.db.profile.CompareFrame.statsColor[v].r, AtlasLoot.db.profile.CompareFrame.statsColor[v].g, AtlasLoot.db.profile.CompareFrame.statsColor[v].b)
		end
	end
end

-- Update the stats table
function AtlasLootItemButton:UpdateStatsList(statsList, refresh)
	if not statsList or self.type ~= "CompareFrameItemButton" then return end
	-- Reset all links
	wipe(self.Stats)

	local wasShown = self.Frame:IsShown()

	self.statsList = statsList

	for k,v in ipairs(self.Frame.Stats) do
		v:Hide()
	end

	for k,v in ipairs(self.statsList) do
		if self.Frame.Stats[k] then
			self.Frame.Stats[k]:Show()
		else
			self.Frame.Stats[k] = self.Frame:CreateFontString(self.name.."_Stats"..k, "BACKGROUND", "GameFontHighlightSmall")
			if k == 1 then
				self.Frame.Stats[k]:SetPoint("TOPLEFT", self.Frame.Name, "TOPRIGHT", 0, 0)
			else
				self.Frame.Stats[k]:SetPoint("LEFT", self.Frame.Stats[k-1], "RIGHT", 0, 0)
			end
			self.Frame.Stats[k]:SetWidth(100)
			self.Frame.Stats[k]:SetHeight(32)
			self.Frame.Stats[k]:SetText(0)
		end
		self.Stats["ITEM_MOD_"..v.."_SHORT"] = self.Frame.Stats[k]
	end
	self.Frame:SetWidth(true)
	if wasShown and refresh then
		self:Refresh()
	end
	self:UpdateStatsColor()
end	

--- Sets a link to the button
-- Sets a link to another loottable from AtlasLoot
-- @param lootTable Name of the AtlasLoot loottable
-- @usage AtlasLootItemButton:SetLink(lootTable)
function AtlasLootItemButton:SetLink(lootTable)
	if not lootTable or type(lootTable) ~= "string" then return end
	local dataID = AtlasLoot:FormatDataID(lootTable)
	if AtlasLoot_Data[dataID] or self.tableLinkFunc then
		self:SetButtonType("", "", lootTable)
		self:SetMenuButton(true)
	end
end

--- Shows or Hide the MenuButton
-- @param show true/false 
-- @usage AtlasLootItemButton:SetMenuButton(show)
function AtlasLootItemButton:SetMenuButton(show)
	if not show then
		self.Frame.Icon:Show()
		self.Frame.Icon:SetTexture(self.Frame.MenuIcon:GetTexture())

		self.Frame.MenuIcon:SetTexture(nil)
		self.Frame.MenuIcon:Hide()
		self.Frame.MenuIconBorder:Hide()
	else
		self.Frame.MenuIcon:Show()
		self.Frame.MenuIconBorder:Show()
		self.Frame.MenuIcon:SetTexture(self.Frame.Icon:GetTexture())

		self.Frame.Icon:Hide()
		self.Frame.Icon:SetTexture(nil)
	end
end

--- Sets a button Icon
-- @param icon the path to the icon
-- @usage AtlasLootItemButton:SetIcon(icon)
function AtlasLootItemButton:SetIcon(icon)
	if self.Frame.Icon:IsShown() then
		self.Frame.Icon:SetTexture(icon)
	elseif self.Frame.MenuIcon:IsShown() then
		self.Frame.MenuIcon:SetTexture(icon)
	end
end

--- Sets the level of an Heirloom item
-- @param lvl the level
function AtlasLootItemButton:SetHeirloomLvl(lvl)
	self.cutomLvl = tonumber(lvl)
end

--- Set the amount of an item
function AtlasLootItemButton:SetAmount(amount)
	self.Frame.IconAmount:SetText(amount)
	self.amount = amount
end

function AtlasLootItemButton:CheckBonusRoll(enabled)
	if self.type ~= "ItemIcon" then return end
	if not AtlasLoot.CanShowBonusRoll then 
		enabled = false
	end
	for k,v in ipairs(self.Frame.BonusRoll) do
		v:Hide()
	end
	if enabled then
		if self.info then 
			self.Specs = AtlasLoot:BonusLoot_CheckItemId(self.info[2]) 
			if AtlasLoot.db.profile.ShowBonusRollInfoInTT then
				self.SpecsTT = AtlasLoot:BonusLoot_GetItemIdInfo(self.info[2]) 
			end
		else
			self.Specs = nil
			self.SpecsTT = nil
		end
		if self.Specs then
			if not AtlasLoot.ThunderforgeAviable then
				self.Frame:SetAlpha(1)
			end
			for k,v in ipairs(self.Specs) do
				if not self.Frame.BonusRoll[k] then break end
				self.Frame.BonusRoll[k]:Show()
				self.Frame.BonusRoll[k].Id = v[1]
				--SetPortraitToTexture(self.Frame.BonusRoll[k].specIcon, v)
				self.Frame.BonusRoll[k].specIcon:SetTexture(v[2])
			end
		elseif self.Specs == false then
			self.Frame:SetAlpha(0.33)
		elseif self.Specs == nil and not AtlasLoot.ThunderforgeAviable then
			self.Frame:SetAlpha(1)
		end
	elseif not AtlasLoot.ThunderforgeAviable then
		self.Frame:SetAlpha(1)
	end
end

function AtlasLootItemButton:RefreshThunderforge(id)
	if AtlasLoot.ThunderforgeAviable and id and AtlasLoot.db.profile.ShowThunderforged then
		self.Frame:SetAlpha(1)
	elseif AtlasLoot.ThunderforgeAviable and not id and AtlasLoot.db.profile.ShowThunderforged then
		self.Frame:SetAlpha(0.33)
	else
		self.Frame:SetAlpha(1)
	end
end

--- Querys the server
-- Querys the server for the setn item
-- @usage AtlasLootItemButton:Query()
function AtlasLootItemButton:Query()
	if self.info and self.info[2] and not self.info[1] then
		AtlasLootTooltip:SetHyperlink("item:"..self.info[2]..":0:0:0:0:0:0:0")
		self:Refresh()
	end
end


--- Clears the button
-- Clears and hides the itemButton
-- @usage AtlasLootItemButton:Clear()
function AtlasLootItemButton:Clear()
	self.Frame.Unsafe:Hide()
	self.Frame.QueryIcon:Hide()
	self:SetButtonType(nil, nil, nil)
	self:SetMenuButton(false)
	self:SetIcon(nil)
	self:SetAmount(nil)
	self:SetUpgradeLvl(nil)
	self:CheckBonusRoll(false)
	self.Frame.Name:SetText("")
	self.Frame.Extra:SetText("")
	self.info = nil
	self.cutomLvl = nil
	--self.itemType = nil					-- vlt später was überlegen..
	self.tableLinkFunc = nil
	self.SpecsTT = nil
	self.Frame:Hide()
end

--- Refresh the button
-- Refreshs the button
-- @usage AtlasLootItemButton:Refresh()
function AtlasLootItemButton:Refresh()
	local tabLinkSave = self.tableLink
	local amountSave = self.amount
	local upgradeLvlSave = self.upgradeLvl
	if self.item == true and self.spell == false and self.info then
		self:SetItem(self.info[2], self.info[3], self.info[4], self.info[5], self.info[6], self.info[7], self.info[8], self.info[9])
		self:SetLink(tabLinkSave)
		self:SetAmount(amountSave)
		self:SetUpgradeLvl(self.upgradeLvl)
	elseif self.item == true and self.spell == false and self.info then
		self:SetSpell(self.info[1], self.info[2], self.info[3], self.info[4], self.info[5], self.info[6])
		self:SetLink(tabLinkSave)
		self:SetAmount(amountSave)
		self:SetUpgradeLvl(self.upgradeLvl)
	elseif self.item == false and self.spell == false and self.info then
		self:SetMenu(tabLinkSave, self.info[3], self.info[4], self.info[5])
	end
end

--- Returns a Chatlink
-- Returns a item or SpellLink
-- @return The link of the spell/item or the name
-- @return The name of the spell/item 
-- @usage local link, name = AtlasLootItemButton:GetChatLink()
function AtlasLootItemButton:GetChatLink()
	if self.info and self.info[1] then
		return AtlasLoot:GetEnchantLink(self.info[1]), ""
	elseif self.info and self.info[2] then
		local itemID = (AtlasLoot.db.profile.ShowThunderforged and self.info[9]) and self.info[9] or self.info[2]
		local itemInfo, itemLink = GetItemInfo(itemID)
		local color = strsub(self.Frame.Name:GetText(), 1, 10)
		local name = strsub(self.Frame.Name:GetText(), 11)
		if self.upgradeLvl then
			local itemString = createItemLink(itemID, self.cutomLvl, self.upgradeLvl)
			itemString = itemString or "item:"..itemID
			return color.."|H"..itemString.."|h["..itemInfo.."]|h|r", name
		end
		if itemInfo then
			return itemLink, name
		else
			return name, name
		end
	end
end

--- DressUp the item
-- @usage AtlasLootItemButton:DressUp()
function AtlasLootItemButton:DressUp()
	if self.info and self.info[2] then
		local _,itemLink = GetItemInfo(self.info[2])
		if itemLink then
			DressUpItemLink(itemLink)
		end
	end
end

function AtlasLootItemButton:SetItemType(itemType)
	self.itemType = itemType
end

function AtlasLootItemButton:SetUpgradeLvl(lvl)
	lvl = lvl or 0
	if self.info and self.info[2] and self.info[2] ~= 0 then
		local upgradeStart, upgradeTab = canUpgradeItem(self.info[2])
		if upgradeStart then
			if lvl > #upgradeTab then lvl = #upgradeTab end
			--[[self.upgradeLvl = {
				curLvl = upgradeTab[lvl],
				startLvl = upgradeStart,
				upgradeTab = upgradeTab
			}]]--
			self.upgradeLvl = lvl
		else
			self.upgradeLvl = nil
		end
	else
		self.upgradeLvl = nil
	end
end
--- Adds a item button function
-- @param func the function
-- @param name the name of the function ( AtlasLootItemButton:<NAME>() )
-- @usage AtlasLoot:AddItemButtonTemplateFunc(func, name)
function AtlasLoot:AddItemButtonTemplateFunc(func, name)
	if not func or not name or type(func) ~= "function" then return end
	if not AtlasLootItemButton[name] then
		AtlasLootItemButton[name] = func
	end
end

-------------------------------------------
-- Quests/Achievements Script functions ---
-------------------------------------------

function AtlasLoot:QAItemOnEnter()
	if not AtlasLootTooltip then AtlasLoot:SetupTooltip() end
	AtlasLootTooltip:ClearLines();
	for i=1, 30, 1 do
		if (_G["AtlasLootTooltipTextRight"..i] ~= nil) then
			_G["AtlasLootTooltipTextRight"..i]:SetText("");
		end
	end

	local questID = self.questID
	local achievementID = self.achievementID
	local itemID = self.itemID
	--local price = self.price

	if questID then
		AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24);
		AtlasLootTooltip:SetHyperlink("quest:"..questID)
		AtlasLootTooltip:Show();
	elseif achievementID and GetAchievementLink(achievementID) then
		AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24);
		AtlasLootTooltip:SetHyperlink(GetAchievementLink(achievementID))
		AtlasLootTooltip:Show();
	elseif itemID then
		AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24);
		AtlasLootTooltip:SetHyperlink("item:"..itemID..":0:0:0");
		AtlasLootTooltip:Show();
	elseif self.price then
		AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24);
		for k,price in ipairs(self.price) do
			if type(price[2]) == "number" then
				local name, currentAmount, icon = GetCurrencyInfo(price[2])
				icon = icon and "|T"..icon..":16|t " or ""
		
				AtlasLootTooltip:AddLine(icon..name);
				if currentAmount and tonumber(price[1]) and currentAmount >= tonumber(price[1]) then
					AtlasLootTooltip:AddLine(GREEN..currentAmount.." / "..price[1]);
				else
				AtlasLootTooltip:AddLine(RED..currentAmount.." / "..price[1]);
				end
			elseif type(price[2]) == "table" and TEMP_TABLE[price[2][1]] then
				TEMP_TABLE[price[2][1]][price[2][2]]("tooltip", AtlasLootTooltip)
			elseif CURRENCY_PRICE[price[2]] then
				local count = GetItemCount(CURRENCY_PRICE[price[2]].itemID)
				local countAll = GetItemCount(CURRENCY_PRICE[price[2]].itemID, true)
				local color = ""
				local name, _, itemQuality = GetItemInfo(CURRENCY_PRICE[price[2]].itemID)
				if countAll and tonumber(price[1]) and countAll >= tonumber(price[1]) then
					color = color..GREEN
				else
					color = color..RED
				end
				
				--AtlasLootTooltip:SetHyperlink("item:"..TEMP_TABLE["TMP"]..":0:0:0")
				if name then
					itemQuality = select(4, GetItemQualityColor(itemQuality))
					name = "|c"..itemQuality..string.gsub(name, 1, 4)
					local icon =  GetItemIcon(CURRENCY_PRICE[price[2]].itemID)
					icon = icon and "|T"..icon..":16|t " or ""
					name = icon..name
				else
					name = _G["UNKNOWN"]
				end
				AtlasLootTooltip:AddLine(name)
				
				if countAll == count then
					AtlasLootTooltip:AddLine(color..count.." / "..price[1])
				else
					AtlasLootTooltip:AddLine(color..string.format(AL["%d / %d ( Bank: %d )"], countAll, price[1], countAll - count))
				end
			end
		end
		AtlasLootTooltip:Show();
	end
end

function AtlasLoot:QAItemOnLeave()
	AtlasLootTooltip:Hide()
	GameTooltip:Hide()
	ShoppingTooltip2:Hide()
	ShoppingTooltip1:Hide()
end

function AtlasLoot:QAItemOnClick(arg1)
	if IsShiftKeyDown() then
		local link = ""
		local linkTmp = ""
		if self.questID then
			link = "|cffffff00|Hquest:"..self.questID.."|h["..AtlasLoot:GetQuestName(self.questID).."]|h|r"
			--/script DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hquest:2969:47\124h[Freedom for All Creatures]\124h\124r");
			--http://www.wowpedia.org/QuestLink
		elseif self.achievementID then
			link = GetAchievementLink(self.achievementID)
		elseif self.itemID then
			_, link = GetItemInfo(self.itemID)
		elseif self.price then
			for k,v in ipairs(self.price) do
				if CURRENCY_PRICE[v[2]] then
					_, linkTmp = GetItemInfo(CURRENCY_PRICE[v[2]].itemID)
					linkTmp = v[1].." x "..linkTmp
				elseif type(v[2]) == "table" and TEMP_TABLE[v[2][1]] then
					linkTmp = TEMP_TABLE[v[2][1]][v[2][2]]("click", linkTmp)
				elseif type(v[2]) == "number" then
					linkTmp = GetCurrencyInfo(v[2])
					--SendChatMessage("\124cff00aa00\124Hcurrency:396\124h[Valor Points]\124h\124r")
					linkTmp = string.format("|cff00aa00|Hcurrency:%d|h[%s]|h|r", v[2], linkTmp)
					linkTmp = v[1].." x "..linkTmp
				end
				if k == 1 then
					link = link..linkTmp
				else
					link = link..", "..linkTmp
				end
				linkTmp = ""
			end
		end
		if link then
			--if ChatFrameEditBox and ChatFrameEditBox:IsVisible() then
			--	ChatFrameEditBox:Insert(link)
			--else
				ChatEdit_InsertLink(link)
			--end
		end
	end
end

----------------------------------
-- itemButton Script functions ---
----------------------------------

-- Tooltip
do
	local curEnter 

	-- http://www.wowwiki.com/Events/M#MODIFIER_STATE_CHANGED
	function onEvent(self, event, arg1, arg2)
		if curEnter then
			-- arg2: 1 for pressed, 0 (not nil!) for released 
			if arg2 == 1 then
				if arg1 == "LSHIFT" or arg1 == "RSHIFT" then
					AtlasLoot:ItemShowCompareItem()
				end
			else
				if arg1 == "LSHIFT" or arg1 == "RSHIFT" then
					ShoppingTooltip2:Hide()
					ShoppingTooltip1:Hide()
				end
			end
		end
	end

	local modifierStateFrame = CreateFrame("FRAME")
		modifierStateFrame:RegisterEvent("MODIFIER_STATE_CHANGED")
		modifierStateFrame:SetScript("OnEvent", onEvent)

	function AtlasLoot:SetupTooltip()
		if AtlasLootTooltip then AtlasLootTooltip:Hide() end
		if self.db.profile.UseGameTooltip then
			AtlasLootTooltip = GameTooltip
		else
			AtlasLootTooltip = AtlasLootTooltipTEMP
		end
	end

	-- Called when a loot item is moused over
	function AtlasLoot:ItemOnEnter()
		if not AtlasLootTooltip then AtlasLoot:SetupTooltip() end
		curEnter = true
		AtlasLootTooltip:ClearLines();
		for i=1, 30, 1 do
			if (_G["AtlasLootTooltipTextRight"..i] ~= nil) then
				_G["AtlasLootTooltipTextRight"..i]:SetText("");
			end
		end

		--self.info = { nil, itemID, itemName, extraText, itemTexture, itemPrice, itemDroprate }
		if not self.par.info then return end
		local spellID = self.par.info[1]
		local itemID = (AtlasLoot.db.profile.ShowThunderforged and self.par.info[9]) and self.par.info[9] or self.par.info[2]
		local droprate = self.par.info[7]
		local tooltipAdd = self.par.info[8]

		if itemID and not spellID then
			if(itemID ~= nil) then
				if(GetItemInfo(itemID) ~= nil) then
					if _G[self:GetName().."_Unsafe"]:IsShown() then
						self.par:Refresh()
						return
					end
					--_G[self:GetName().."_Unsafe"]:Hide();
					AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24);
					if self.par.cutomLvl then
						AtlasLootTooltip:SetHyperlink(createItemLink(itemID, self.par.cutomLvl, self.par.upgradeLvl));
						--AtlasLootTooltip:AddLine()
					else
						AtlasLootTooltip:SetHyperlink(createItemLink(itemID, self.par.cutomLvl, self.par.upgradeLvl));
						if select(3, GetItemInfo(self.par.info[2])) == 7 then
							AtlasLootTooltip:AddLine(ORANGE..AL["Shift + Right Click to select character level"])
						end
					end

					if ( AtlasLoot.db.profile.ItemIDs ) then
						AtlasLootTooltip:AddLine(BLUE..AL["ItemID:"].." "..itemID, nil, nil, nil, 1);
					end
					if( droprate ~= nil) and AtlasLoot.db.profile.DropRate then
						AtlasLootTooltip:AddLine(AL["Drop Rate: "]..droprate, 1, 1, 0);
					end
					if( DKP ~= nil and DKP ~= "" ) then
						AtlasLootTooltip:AddLine(RED..DKP.." "..AL["DKP"], 1, 1, 0);
					end
					if( priority ~= nil and priority ~= "" ) then
						AtlasLootTooltip:AddLine(GREEN..AL["Priority:"].." "..priority, 1, 1, 0);
					end
					if AtlasLoot.db.profile.ShowBonusRollInfoInTT and self.par.Specs and self.par.SpecsTT then
						if not self.par.SpecsTT then
							self.par:CheckBonusRoll(AtlasLoot.db.profile.BonusRollEnabled)
						end
						--AtlasLootTooltip:AddDoubleLine(AL["BonusRoll:"], table.concat(self.par.SpecsTT,","))
						AtlasLootTooltip:AddLine(AL["BonusRoll:"].." "..table.concat(self.par.SpecsTT, " "))
						
					end

					AtlasLoot:AddTextToTooltip(AtlasLootTooltip, self.par.info)
					if( tooltipAdd ~= nil and tooltipAdd ~= "" ) then
						AtlasLootTooltip:AddLine(" ", 1, 1, 0);
						AtlasLootTooltip:AddLine(tooltipAdd, 1, 1, 0);
					end

					AtlasLootTooltip:Show();
					if((AtlasLoot.db.profile.EquipCompare and ((not EquipCompare_RegisterTooltip) or (not EquipCompare_Enabled)))) or IsShiftKeyDown() then
						AtlasLoot:ItemShowCompareItem(); --- CALL MISSING METHOD TO SHOW 2 TOOLTIPS (Item Compare)
					end
				else
					AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24);
					AtlasLootTooltip:ClearLines();

					AtlasLootTooltip:AddLine(RED..AL["Item Unavailable"], nil, nil, nil, 1);
					AtlasLootTooltip:AddLine(string.format(AL["|cff0070ddItemID: %d |r\nThis item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world.\n\nYou can right-click to attempt to query the server.  You may be disconnected."],itemID), nil, nil, nil, 1)
					AtlasLootTooltip:Show();

				end
			end
		elseif spellID then
			AtlasLootTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24)
			AtlasLootTooltip:ClearLines()
			if AtlasLoot:GetEnchantLink(spellID) then
				AtlasLootTooltip:SetHyperlink(AtlasLoot:GetEnchantLink(spellID))
			end
			AtlasLootTooltip:Show()
			if(spellID and ((AtlasLoot.db.profile.EquipCompare and ((not EquipCompare_RegisterTooltip) or (not EquipCompare_Enabled))) or IsShiftKeyDown())) then
				AtlasLoot:ItemShowCompareItem() --- CALL MISSING METHOD TO SHOW 2 TOOLTIPS (Item Compare)
			end
		end
	end

	-- Called when the mouse cursor leaves a loot item
	function AtlasLoot:ItemOnLeave()
		curEnter = nil
		AtlasLootTooltip:Hide()
		GameTooltip:Hide()
		ShoppingTooltip2:Hide()
		ShoppingTooltip1:Hide()
	end

	-- Missing GameToolTip method
	-- Enables item comparing. I've ripped self method directly from GameTooltip.lua and modified to work with AtlasLootTooltip /siena
	function AtlasLoot:ItemShowCompareItem()
		local shift = 1;
		local item,link = nil,nil
		if self.spellitemID and self.spellitemID ~= "" and self.spellitemID ~= 0 then
			item = AtlasLootTooltip:GetSpell()
			_,link = GetItemInfo(self.par.info[2])
		else
			item,link = AtlasLootTooltip:GetItem();
		end

		if ( not link ) then
			return
		end

		ShoppingTooltip1:SetOwner(AtlasLootTooltip, "ANCHOR_NONE");
		ShoppingTooltip2:SetOwner(AtlasLootTooltip, "ANCHOR_NONE");
		ShoppingTooltip3:SetOwner(AtlasLootTooltip, "ANCHOR_NONE");

		local item1 = nil;
		local item2 = nil;
		local item3 = nil;
		local side = "left";
		if ( ShoppingTooltip1:SetHyperlinkCompareItem(link, 1, 1, AtlasLootTooltip) ) then
			item1 = true;
		end
		if ( ShoppingTooltip2:SetHyperlinkCompareItem(link, 2, 1, AtlasLootTooltip) ) then
			item2 = true;
		end
		if ( ShoppingTooltip3:SetHyperlinkCompareItem(link, 3, 1, AtlasLootTooltip) ) then
			item3 = true;
		end
		if not item1 and not item2 and not item3 then 
			return 
		end

		if item3 then
			if not item1 then
				item1, item3 = true, nil;
				ShoppingTooltip1:SetHyperlinkCompareItem(link, 3, 1, AtlasLootTooltip);
			elseif not item2 then
				item2, item3 = true, nil;
				ShoppingTooltip2:SetHyperlinkCompareItem(link, 3, 1, AtlasLootTooltip);
			end
		end
		if item2 and not item1 then
			item1, item2 = true, nil;
			ShoppingTooltip1:SetHyperlinkCompareItem(link, 2, 1, AtlasLootTooltip);
		end

		local left, right, anchor1, anchor2 = AtlasLootTooltip:GetLeft(), AtlasLootTooltip:GetRight(), "TOPLEFT", "TOPRIGHT";
		if not left or not right then return end
		if (GetScreenWidth() - right) < left then anchor1, anchor2 = anchor2, anchor1 end

		if item1 then
			ShoppingTooltip1:ClearAllPoints();
			ShoppingTooltip1:SetPoint(anchor1, AtlasLootTooltip, anchor2, 0, -10);
			ShoppingTooltip1:Show();

			if item2 then
				ShoppingTooltip2:ClearAllPoints();
				ShoppingTooltip2:SetPoint(anchor1, ShoppingTooltip1, anchor2);
				ShoppingTooltip2:Show();
			end

			if item3 then
				ShoppingTooltip3:ClearAllPoints();
				ShoppingTooltip3:SetPoint(anchor1, ShoppingTooltip2, anchor2);
				ShoppingTooltip3:Show();
			end
		end
		
	end
	
end

-- Called when a loot item is clicked on
function AtlasLoot:ItemOnClick(arg1)
	local itemRarity
	if self.par.info and self.par.info[2] then
		itemRarity = (AtlasLoot.db.profile.ShowThunderforged and self.par.info[9]) and self.par.info[9] or self.par.info[2]
		itemRarity = select(3, GetItemInfo(itemRarity))
	end
	if self.par.tableLink and arg1 == "LeftButton" and not IsAltKeyDown() then
		if self.par.tableLinkFunc then
			AtlasLoot:ShowLootPage(self.par.tableLinkFunc(self, self.par.tableLink))
		else
			AtlasLoot:ShowLootPage(self.par.tableLink)
		end
	elseif arg1 == "RightButton" and not IsShiftKeyDown() and not IsAltKeyDown() then
		self.par:Query()
	elseif IsShiftKeyDown() then
		if arg1 == "LeftButton" then
			local link, name = self.par:GetChatLink()
			if ChatFrameEditBox and ChatFrameEditBox:IsVisible() then
				ChatFrameEditBox:Insert(link)
			else
				ChatEdit_InsertLink(link)
			end
		elseif arg1 == "RightButton" and itemRarity and itemRarity == 7 and self.par.info then
			AtlasLoot:ShowHeriloomConfigWindow(self.par.info)
		end
	elseif IsControlKeyDown() then
		self.par:DressUp()
	end
end

-- HeriloomConfigWindow
do
	local AceGUI = LibStub("AceGUI-3.0")

	local curItemLvl = UnitLevel("player")

	local function onValueChanged(self, event, value)
		curItemLvl = value
		AtlasLoot.HeriloomConfigWindow.frame.itemButton:SetHeirloomLvl(value)
	end

	function AtlasLoot:ShowHeriloomConfigWindow(info)
		if self.HeriloomConfigWindow then
			curItemLvl = UnitLevel("player")
			AtlasLoot.HeriloomConfigWindow.frame.itemButton:SetHeirloomLvl(curItemLvl)
			self.HeriloomConfigWindow.frame:Show()
			self.HeriloomConfigWindow.frame.itemButton:SetItem(info[2], info[3], info[4], info[5], info[6], info[7])

			self.HeriloomConfigWindow.frame.Slider:SetValue(curItemLvl)
			self.HeriloomConfigWindow.frame.Slider:SetSliderValues(1, self:GetHeirloomMaxLvl(info[2]), 1) 
			--OnValueChanged
		else
			self.HeriloomConfigWindow = {}
			self.HeriloomConfigWindow.frame = CreateFrame("Frame","AtlasLoot_HeriloomConfigWindow",UIParent)
			local frame = self.HeriloomConfigWindow.frame
			frame:SetWidth(262)
			frame:SetHeight(120)
			frame:SetPoint("CENTER",UIParent,"CENTER",0,0)
			frame:EnableMouse()
			frame:SetMovable(true)
			frame:SetResizable(true)
			frame:SetFrameStrata("FULLSCREEN_DIALOG")
			--frame:SetScript("OnMouseDown", frameOnMouseDown)

			--frame:SetScript("OnHide",frameOnClose)
			--frame:SetMinResize(240,240)
			frame:SetToplevel(true)

			frame.textures = {}
			frame.textures.titlebg = frame:CreateTexture(nil, "BACKGROUND")
			frame.textures.titlebg:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Title-Background]])
			frame.textures.titlebg:SetPoint("TOPLEFT", 9, -6)
			frame.textures.titlebg:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -28, -24)

			frame.textures.dialogbg = frame:CreateTexture(nil, "BACKGROUND")
			--frame.textures.dialogbg:SetTexture([[Interface\Tooltips\UI-Tooltip-Background]])
			frame.textures.dialogbg:SetTexture(0, 0, 0, 1)
			frame.textures.dialogbg:SetPoint("TOPLEFT", 8, -24)
			frame.textures.dialogbg:SetPoint("BOTTOMRIGHT", -6, 8)
			--frame.textures.dialogbg:SetVertexColor(0, 0, 0, .75)

			frame.textures.topleft = frame:CreateTexture(nil, "BORDER")
			frame.textures.topleft:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
			frame.textures.topleft:SetWidth(64)
			frame.textures.topleft:SetHeight(64)
			frame.textures.topleft:SetPoint("TOPLEFT")
			frame.textures.topleft:SetTexCoord(0.501953125, 0.625, 0, 1)

			frame.textures.topright = frame:CreateTexture(nil, "BORDER")
			frame.textures.topright:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
			frame.textures.topright:SetWidth(64)
			frame.textures.topright:SetHeight(64)
			frame.textures.topright:SetPoint("TOPRIGHT")
			frame.textures.topright:SetTexCoord(0.625, 0.75, 0, 1)

			frame.textures.top = frame:CreateTexture(nil, "BORDER")
			frame.textures.top:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
			frame.textures.top:SetHeight(64)
			frame.textures.top:SetPoint("TOPLEFT", frame.textures.topleft, "TOPRIGHT")
			frame.textures.top:SetPoint("TOPRIGHT", frame.textures.topright, "TOPLEFT")
			frame.textures.top:SetTexCoord(0.25, 0.369140625, 0, 1)

			frame.textures.bottomleft = frame:CreateTexture(nil, "BORDER")
			frame.textures.bottomleft:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
			frame.textures.bottomleft:SetWidth(64)
			frame.textures.bottomleft:SetHeight(64)
			frame.textures.bottomleft:SetPoint("BOTTOMLEFT")
			frame.textures.bottomleft:SetTexCoord(0.751953125, 0.875, 0, 1)

			frame.textures.bottomright = frame:CreateTexture(nil, "BORDER")
			frame.textures.bottomright:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
			frame.textures.bottomright:SetWidth(64)
			frame.textures.bottomright:SetHeight(64)
			frame.textures.bottomright:SetPoint("BOTTOMRIGHT")
			frame.textures.bottomright:SetTexCoord(0.875, 1, 0, 1)

			frame.textures.bottom = frame:CreateTexture(nil, "BORDER")
			frame.textures.bottom:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
			frame.textures.bottom:SetHeight(64)
			frame.textures.bottom:SetPoint("BOTTOMLEFT", frame.textures.bottomleft, "BOTTOMRIGHT")
			frame.textures.bottom:SetPoint("BOTTOMRIGHT", frame.textures.bottomright, "BOTTOMLEFT")
			frame.textures.bottom:SetTexCoord(0.376953125, 0.498046875, 0, 1)

			frame.textures.left = frame:CreateTexture(nil, "BORDER")
			frame.textures.left:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
			frame.textures.left:SetWidth(64)
			frame.textures.left:SetPoint("TOPLEFT", frame.textures.topleft, "BOTTOMLEFT")
			frame.textures.left:SetPoint("BOTTOMLEFT", frame.textures.bottomleft, "TOPLEFT")
			frame.textures.left:SetTexCoord(0.001953125, 0.125, 0, 1)

			frame.textures.right = frame:CreateTexture(nil, "BORDER")
			frame.textures.right:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
			frame.textures.right:SetWidth(64)
			frame.textures.right:SetPoint("TOPRIGHT", frame.textures.topright, "BOTTOMRIGHT")
			frame.textures.right:SetPoint("BOTTOMRIGHT", frame.textures.bottomright, "TOPRIGHT")
			frame.textures.right:SetTexCoord(0.1171875, 0.2421875, 0, 1)

			frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
			frame.close:SetPoint("TOPRIGHT", 2, 1)

			frame.titletext = frame:CreateFontString(nil, "ARTWORK")
			frame.titletext:SetFontObject(GameFontNormal)
			frame.titletext:SetPoint("TOPLEFT", 12, -8)
			frame.titletext:SetPoint("TOPRIGHT", -32, -8)
			frame.titletext:SetText(AL["Heirloom preview"])

			self.HeriloomConfigWindow.content = CreateFrame("Frame",nil,frame)
			self.HeriloomConfigWindow.content:SetPoint("TOPLEFT",frame,"TOPLEFT",12,-32)
			self.HeriloomConfigWindow.content:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-12,13)

			frame.itemButton = AtlasLoot:CreateItemButton(frame, {"TOPLEFT", frame, "TOPLEFT", 13, -30}, "AtlasLootItem_HeirloomFrame")
			--frame.itemButton:SetItem(45038, "=q5=Fragment of Val'anyr", "=ds=#m3#", nil, nil, "40%")

			AceGUI:RegisterAsContainer(self.HeriloomConfigWindow)

			frame.Slider = AceGUI:Create("Slider")
			self.HeriloomConfigWindow:AddChild(frame.Slider)
			frame.Slider:SetWidth(236)
			frame.Slider:SetPoint("TOPLEFT", frame.itemButton.Frame, "BOTTOMLEFT")
			frame.Slider:SetCallback("OnValueChanged", onValueChanged)
			frame.Slider:SetLabel(AL["Change level:"])

			
			self:ShowHeriloomConfigWindow(info)
		end
	end

end
