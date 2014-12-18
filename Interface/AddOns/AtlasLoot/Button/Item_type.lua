local AtlasLoot = _G.AtlasLoot
local Item = AtlasLoot.Button:AddType("Item", "i")
local Query = {}
Item.Query = Query
local AL = AtlasLoot.Locales
local ClickHandler = AtlasLoot.ClickHandler

local db

-- lua
local tonumber = tonumber
local assert = assert
local next, wipe, tab_remove = next, wipe, table.remove
local format, split = string.format, string.split

-- WoW
local GetItemInfo = GetItemInfo

-- AL
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip
local GetItemDescInfo = AtlasLoot.ItemInfo.GetDescription
local GetItemStringWithBonus = AtlasLoot.ItemString.AddBonus

local ITEM_COLORS = {}


local ItemClickHandler = nil
local itemIsOnEnter = nil

function Item.OnSet(button, second)
	if not ItemClickHandler then
		db = AtlasLoot.db.Button.Item
		ItemClickHandler = ClickHandler:Add(
		"Item",
		{
			ChatLink = { "LeftButton", "Shift" },
			DressUp = { "LeftButton", "Ctrl" },
			types = {
				ChatLink = true,
				DressUp = true,
			},
		},
		db.ClickHandler, 
		{
			{ "ChatLink", 	AL["Chat Link"], 	AL["Add item into chat"] },
			{ "DressUp", 	AL["Dress up"], 	AL["Shows the item in the Dressing room"] },
		})
		-- create item colors
		for i=0,7 do 
			local _, _, _, itemQuality = GetItemQualityColor(i)
			ITEM_COLORS[i] = itemQuality
		end
	end
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		if type(button.__atlaslootinfo.secType[2]) == "table" then
			button.secButton.ItemID = button.__atlaslootinfo.secType[2].itemID or tonumber(tab_remove(button.__atlaslootinfo.secType[2], 1))
			button.secButton.ItemString = button.__atlaslootinfo.secType[2].itemString or GetItemStringWithBonus(button.secButton.ItemID, button.__atlaslootinfo.secType[2])
		else
			button.secButton.ItemID = button.__atlaslootinfo.secType[2]
			if button.__atlaslootinfo.preSet and button.__atlaslootinfo.preSet.Item and button.__atlaslootinfo.preSet.Item.item2bonus then
				button.secButton.ItemString = GetItemStringWithBonus(button.ItemID, button.__atlaslootinfo.preSet.Item.item2bonus)
			end
		end
		button.secButton.Droprate = button.__atlaslootinfo.Droprate
		
		Item.Refresh(button.secButton)
	else
		if type(button.__atlaslootinfo.type[2]) == "table" then
			button.ItemID = button.__atlaslootinfo.type[2].itemID or tonumber(tab_remove(button.__atlaslootinfo.type[2], 1))
			button.ItemString = button.__atlaslootinfo.type[2].itemString or GetItemStringWithBonus(button.ItemID, button.__atlaslootinfo.type[2])
		else
			button.ItemID = button.__atlaslootinfo.type[2]
			if button.__atlaslootinfo.preSet and button.__atlaslootinfo.preSet.Item and button.__atlaslootinfo.preSet.Item.item1bonus then
				button.ItemString = GetItemStringWithBonus(button.ItemID, button.__atlaslootinfo.preSet.Item.item1bonus)
			end
		end
		button.Droprate = button.__atlaslootinfo.Droprate
		Item.Refresh(button)
	end
end

function Item.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = ItemClickHandler:Get(mouseButton)
	if mouseButton == "ChatLink" then
		local itemInfo, itemLink = GetItemInfo(button.ItemString or button.ItemID)
		itemLink = itemLink or button.ItemString
		AtlasLoot.Button:AddChatLink(itemLink or "item:"..button.ItemID)
	elseif mouseButton == "DressUp" then
		local itemInfo, itemLink = GetItemInfo(button.ItemString or button.ItemID)
		itemLink = itemLink or button.ItemString
		if itemLink then
			DressUpItemLink(itemLink)
		end
	end
end

function Item.OnEnter(button, owner)
	local tooltip = GetAlTooltip() 
	tooltip:ClearLines()
	itemIsOnEnter = tooltip
	if owner and type(owner) == "table" then
		tooltip:SetOwner(owner[1], owner[2], owner[3], owner[4])
	else
		tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 24)
	end
	if button.ItemString then
		tooltip:SetHyperlink(button.ItemString)
	else
		tooltip:SetItemByID(button.ItemID)
	end
	if button.Droprate and db.showDropRate then
		tooltip:AddDoubleLine(AL["Droprate:"], button.Droprate.."%")
	end
	tooltip:Show()
	if IsShiftKeyDown() or db.alwaysShowCompareTT then
		GameTooltip_ShowCompareItem(tooltip)
	end
end

function Item.OnLeave(button)
	GetAlTooltip():Hide()
	itemIsOnEnter = nil
	ShoppingTooltip1:Hide()
	ShoppingTooltip2:Hide()
	--ShoppingTooltip3:Hide()
end

function Item.OnClear(button)
	Query:Remove(button)
	Query:Remove(button.secButton)
	button.ItemID = nil
	button.Droprate = nil
	button.ItemString = nil
	button.secButton.ItemID = nil
	button.secButton.Droprate = nil
	button.secButton.ItemString = nil
	if button.overlay then
		button.overlay:SetDesaturated(false)
		button.overlay:Hide()
	end
	button.secButton.overlay:Hide()
end

function Item.Refresh(button)
	if not button.ItemID then return end
	local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(button.ItemString or button.ItemID)
	if not itemName then
		Query:Add(button)
		return false
	end
	
	local borderTexCoord = LOOT_BORDER_QUALITY_COORDS[itemQuality]
	if borderTexCoord then
		button.overlay:Show()
		button.overlay:SetTexture("Interface\\LootFrame\\LootToast")
		button.overlay:SetTexCoord(borderTexCoord[1], borderTexCoord[2], borderTexCoord[3], borderTexCoord[4])
	else
		borderTexCoord = LOOT_BORDER_QUALITY_COORDS[2]
		button.overlay:Show()
		button.overlay:SetTexture("Interface\\LootFrame\\LootToast")
		button.overlay:SetTexCoord(borderTexCoord[1], borderTexCoord[2], borderTexCoord[3], borderTexCoord[4])
		button.overlay:SetDesaturated(true)
	end

	if button.type == "secButton" then
		button:SetNormalTexture(itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
	else	
		-- ##################
		-- icon
		-- ##################
		button.icon:SetTexture(itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
		
		-- ##################
		-- name
		-- ##################
		button.name:SetText("|c"..ITEM_COLORS[itemQuality or 0]..itemName)
		
		-- ##################
		-- description
		-- ##################
		button.extra:SetText(GetItemDescInfo(itemEquipLoc, itemType, itemSubType))
	end
	if db.showCompletedHook then
		itemCount = GetItemCount(button.ItemString, true)
		if itemCount and itemCount > 0 then
			button.completed:Show()
		end
	end

	return true
end

function Item.GetStringContent(str)
	if tonumber(str) then
		return tonumber(str)
	else
		return {
			split(":", str)
		}
	end
end
--################################
-- Item querys
--################################
local button_list = {}

Query.EventFrame = CreateFrame("FRAME")

local function EventFrame_OnEvent(frame, event, arg1, arg2)
	if event == "GET_ITEM_INFO_RECEIVED" then
		if arg1 and button_list[arg1] then
			for i = 1, #button_list[arg1] do
				Item.Refresh(button_list[arg1][i])
			end
			button_list[arg1] = nil
		end
	
		if not next(button_list) then
			frame:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
		end
	elseif event == "MODIFIER_STATE_CHANGED" then
		if itemIsOnEnter then
			-- arg2: 1 for pressed, 0 (not nil!) for released 
			if arg2 == 1 then
				if arg1 == "LSHIFT" or arg1 == "RSHIFT" then
					GameTooltip_ShowCompareItem(itemIsOnEnter)
				end
			else
				if arg1 == "LSHIFT" or arg1 == "RSHIFT" then
					ShoppingTooltip1:Hide()
					ShoppingTooltip2:Hide()
					--ShoppingTooltip3:Hide()
				end
			end
		end
	end
end
Query.EventFrame:SetScript("OnEvent", EventFrame_OnEvent)
Query.EventFrame:RegisterEvent("MODIFIER_STATE_CHANGED")

function Query:Add(button)
	assert(button, "Button not found.")
	Query.EventFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
	if not button_list[button.ItemID] then
		button_list[button.ItemID] = { button }
	else
		button_list[button.ItemID][#button_list[button.ItemID]+1] = button
	end
end

function Query:Remove(button)
	if not button then return end
	if button_list[button] then
		button_list[button] = nil
		if not next(button_list) then
			Query.EventFrame:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
		end
	end
end

function Query:Wipe()
	wipe(button_list)
	Query.EventFrame:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
end