------------------------------------------------------------
-- Menu.lua
--
-- Abin
-- 2011-8-22
------------------------------------------------------------

local _, addon = ...
local L = addon.L
local EMPANEL = PaperDollEquipmentManagerPane
local curSetName, curSetIcon

local function OnMenuResaveSet()
	addon:ResaveSet(curSetName)
end

local function OnMenuDeleteSet()
	addon:DeleteSet(curSetName)
end

local function OnMenuRenameSet()
	addon:RenameSet(curSetName)
end

local function OnMenuDepositSet()
	addon:BankSet(curSetName, 1)
end

local function OnMenuWithdrawSet()
	addon:BankSet(curSetName)
end

local function OnMenuBindSetToTalent1()
	addon:BindSetToTalent(curSetName, 1)
end

local function OnMenuBindSetToTalent2()
	addon:BindSetToTalent(curSetName, 2)
end

local function OnMenuShowHelm()
	addon:ToggleShowHelm(curSetName)
end

local function OnMenuShowCloak()
	addon:ToggleShowCloak(curSetName)
end

function addon:SetMenuSet(name)
	if type(name) ~= "string" then
		name = nil
	end

	local icon = GetEquipmentSetInfoByName(name)
	if not icon then
		name = nil
	end

	if name then
		if not strfind(icon, "\\") then
			icon = "Interface\\Icons\\"..icon
		end
	else
		CloseDropDownMenus()
	end

	curSetName, curSetIcon = name, icon
	return name, icon
end

function addon:GetMenuSet()
	return curSetName, curSetIcon
end

-- The drop down frame for set buttons
local frame = CreateFrame("Button", "GearManagerExDropDownMenu", EMPANEL, "UIDropDownMenuTemplate")
local lastOwner
function addon:ToggleMenu(parent, point, relativeTo, relativePoint, xOffset, yOffset)
	if not curSetName then
		CloseDropDownMenus()
		return
	end

	frame:SetParent(parent or UIParent)
	frame.point = point
	frame.relativeTo = relativeTo
	frame.relativePoint = relativePoint
	frame.xOffset = type(xOffset) == "number" and yOffset or 0
	frame.yOffset = type(yOffset) == "number" and yOffset or 0

	if lastOwner ~= relativeTo then
		lastOwner = relativeTo
		CloseDropDownMenus()
	end

	ToggleDropDownMenu(nil, nil, frame)
	return 1
end

local function BuildMenu()
	UIDropDownMenu_AddButton({ text = curSetName, isTitle = 1, icon = curSetIcon, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["save set"], func = OnMenuResaveSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["delete set"], func = OnMenuDeleteSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["rename set"], disabled = not addon.activeSet or addon.activeSet ~= curSetName, func = OnMenuRenameSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["put into bank"], disabled = not addon.bankOpened, func = OnMenuDepositSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = L["take from bank"], disabled = not addon.bankOpened, func = OnMenuWithdrawSet, notCheckable = 1 })
	UIDropDownMenu_AddButton({ text = SHOW_CLOAK, checked = addon.db.showCloaks[curSetName] == 1, func = OnMenuShowCloak, isNotRadio = true })
	UIDropDownMenu_AddButton({ text = SHOW_HELM, checked = addon.db.showHelms[curSetName] == 1, func = OnMenuShowHelm, isNotRadio = true })
	if GetNumSpecGroups() > 1 then
		UIDropDownMenu_AddButton({ text = L["bind to"]..TALENT_SPEC_PRIMARY, checked = addon.db.talentBind[1] == curSetName, func = OnMenuBindSetToTalent1, isNotRadio = true })
		UIDropDownMenu_AddButton({ text = L["bind to"]..TALENT_SPEC_SECONDARY, checked = addon.db.talentBind[2] == curSetName, func = OnMenuBindSetToTalent2, isNotRadio = true })
	end
	UIDropDownMenu_AddButton({ text = CLOSE, notCheckable = 1 })
end

function addon:BuildMenu()
	BuildMenu()
end

function addon:BuildDewdropMenu(dewdrop)
	if type(dewdrop) ~= "table" or type(dewdrop.AddLine) ~= "function" then
		return
	end
	dewdrop:AddLine("text", curSetName, "isTitle", 1, "icon", curSetIcon)
	dewdrop:AddLine("text", L["save set"], "disabled", addon.activeSet and addon.activeSet ~= curSetName, "func", OnMenuResaveSet)
	dewdrop:AddLine("text", L["delete set"], "func", OnMenuDeleteSet)
	dewdrop:AddLine("text", L["rename set"], "disabled", not addon.activeSet or addon.activeSet ~= curSetName, "func", OnMenuRenameSet)
	dewdrop:AddLine("text", L["put into bank"], "disabled", not addon.bankOpened, "func", OnMenuDepositSet)
	dewdrop:AddLine("text", L["take from bank"], "disabled", not addon.bankOpened, "func", OnMenuWithdrawSet)
	dewdrop:AddLine("text", SHOW_CLOAK, "checked", addon.db.showCloaks[curSetName] == 1, "func", OnMenuShowCloak)
	dewdrop:AddLine("text", SHOW_HELM, "checked", addon.db.showHelms[curSetName] == 1, "func", OnMenuShowHelm)
	if GetNumSpecGroups() > 1 then
		dewdrop:AddLine("text", L["bind to"]..TALENT_SPEC_PRIMARY, "checked", addon.db.talentBind[1] == curSetName, "func", OnMenuBindSetToTalent1)
		dewdrop:AddLine("text", L["bind to"]..TALENT_SPEC_SECONDARY, "checked", addon.db.talentBind[2] == curSetName, "func", OnMenuBindSetToTalent2)
	end
	dewdrop:AddLine("text", CLOSE)
end

UIDropDownMenu_Initialize(frame, BuildMenu, "MENU")

-- Hook "OnMouseDown" for every button to show the drop down menu
local function GearSetButton_OnMouseDown(self, button)
	if button == "RightButton" and type(self.name) == "string" and self.name ~= "" then
		addon:SetMenuSet(self.name)
		addon:ToggleMenu(EMPANEL, "TOPLEFT", self, "BOTTOMLEFT", -4, -4)
	end
	GameTooltip:Hide()
end

local managerPaneShown
EMPANEL:HookScript("OnShow", function(self)
	if managerPaneShown then
		return
	end
	managerPaneShown = 1
	local i
	for i = 1, NUM_GEARSET_ICONS_SHOWN do
		local button = _G[EMPANEL:GetName().."Button"..i]
		if button then
			button:HookScript("OnMouseDown", GearSetButton_OnMouseDown)
		end
	end
end)