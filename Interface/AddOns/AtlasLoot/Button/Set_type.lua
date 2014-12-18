local AtlasLoot = _G.AtlasLoot
local Set = AtlasLoot.Button:AddType("Set", "set")
local AL = AtlasLoot.Locales
local ClickHandler = AtlasLoot.ClickHandler
local Sets
local SVF

local db

-- lua
local tonumber = tonumber
local assert = assert
local next, wipe, tab_remove = next, wipe, table.remove
local format, split = string.format, string.split

-- AL
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

local SetClickHandler = nil

function Set.OnSet(button, second)
	if not SetClickHandler then
		db = AtlasLoot.db.Button.Set
		SetClickHandler = ClickHandler:Add(
		"Set",
		{
			OpenSet = { "LeftButton", "None" },
			ChatLink = { "LeftButton", "Shift" },
			types = {
				OpenSet = true,
				ChatLink = true,
			},
		},
		db.ClickHandler,
		{
			{ "OpenSet", 	"OpenSet", 	"OpenSet desc" },
			{ "ChatLink", 	AL["Chat Link"], 	AL["Add item into chat"] },
		})
		SVF = AtlasLoot.GUI.SetViewFrame
		Sets = AtlasLoot.Data.Sets
	end
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.SetName = button.__atlaslootinfo.secType[2][1]
		button.secButton.SubSetName = button.__atlaslootinfo.secType[2][2]
		button.secButton.SetDiff = button.__atlaslootinfo.secType[2][3]
		button.secButton.SetAddonName = button.__atlaslootinfo.secType[2][4]
		local set = Sets:GetSet(button.secButton.SetName, button.secButton.SetAddonName or AtlasLoot.db.GUI.selected[1])
		button.secButton.VisualName, button.secButton.VisualDesc, button.secButton.VisualIcon = set:GetInfo(button.secButton.SubSetName, set:GetNextPrevDifficulty(button.secButton.SubSetName, button.secButton.SetDiff))

		Set.Refresh(button.secButton)
	else
		button.SetName = button.__atlaslootinfo.type[2][1]
		button.SubSetName = button.__atlaslootinfo.type[2][2]
		button.SetDiff = button.__atlaslootinfo.type[2][3]
		button.SetAddonName = button.__atlaslootinfo.type[2][4]
		local set = Sets:GetSet(button.SetName, button.SetAddonName or AtlasLoot.db.GUI.selected[1])
		button.VisualName, button.VisualDesc, button.VisualIcon = set:GetInfo(button.SubSetName, set:GetNextPrevDifficulty(button.SubSetName, button.SetDiff))
		
		Set.Refresh(button)
	end
end

function Set.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = SetClickHandler:Get(mouseButton)
	if mouseButton == "ChatLink" then
		--local itemInfo, itemLink = GetItemInfo(button.ItemString or button.ItemID)
		--itemLink = itemLink or button.ItemString
		--AtlasLoot.Button:AddChatLink(itemLink or "item:"..button.ItemID)
	elseif mouseButton == "OpenSet" then
		SVF:SetAtlasLootItemSet(button.SetName, button.SetAddonName or AtlasLoot.db.GUI.selected[1], button.SubSetName, button.SetDiff)
	end
end

function Set.OnEnter(button, owner)
	local tooltip = GetAlTooltip() 
	tooltip:ClearLines()
	
	
	
	tooltip:Show()
end

function Set.OnLeave(button)
	GetAlTooltip():Hide()
end

function Set.OnClear(button)
	button.SetName = nil
	button.SubSetName = nil
	button.SetDiff = nil
	button.SetAddonName = nil
	button.VisualName, button.VisualDesc, button.VisualIcon = nil, nil, nil
	
	button.secButton.SetName = nil
	button.secButton.SubSetName = nil
	button.secButton.SetDiff = nil
	button.secButton.SetAddonName = nil
	button.secButton.VisualName, button.secButton.VisualDesc, button.secButton.VisualIcon = nil, nil, nil
end

function Set.Refresh(button)
	if button.type == "secButton" then
		button:SetNormalTexture(button.VisualIcon)
	else	
		button.icon:SetTexture(button.VisualIcon)
		button.name:SetText(button.VisualName)
		button.extra:SetText(button.VisualDesc)
	end

	return true
end

function Set.GetStringContent(str)
	return {
		split(":", str)
	}
end