-- $Id: Search.lua 4201 2013-05-05 16:05:37Z lag123 $
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot")

local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

local openName = nil

-- Shows the DropDown
local function showDropDown(self)
	ToggleDropDownMenu(1, nil, self.DropDownMenu, self:GetName(), 0, 0)
end

local function dropDownOnClick(self, arg1)
	if not arg1 then return end
	AtlasLoot.db.profile.SearchModule[arg1] = not AtlasLoot.db.profile.SearchModule[arg1]
end

-- AtlasLoot:QuickLooks_DropDownInit(level)
-- Initialize the dropdown menu
local dropDownInfo = {}
local function dropDownInit(self, level)
	if not level then return end
	wipe(dropDownInfo)
	if level == 1 then
		for k,v in ipairs(AtlasLoot.Modules) do
			if v[5] and v[5] ~= "" then
				dropDownInfo.text 		 = v[5]
				dropDownInfo.arg1 		 = v[1]
				dropDownInfo.func 		 = dropDownOnClick
				dropDownInfo.checked 	 = AtlasLoot.db.profile.SearchModule[v[1]]
				UIDropDownMenu_AddButton(dropDownInfo, level)
			end
		end
		dropDownInfo.text         = "|cffff0000"..CLOSE
		dropDownInfo.func         = function() CloseDropDownMenus() end
		dropDownInfo.checked      = nil
		dropDownInfo.notCheckable = 1
		UIDropDownMenu_AddButton(dropDownInfo, level)
	end

end

function AtlasLoot:CreateSearchModuleDropDown(parent, point, name)
	if not name then return end
	
	local frame = CreateFrame("Button", name, parent)
	frame:SetWidth(23)
	frame:SetHeight(23)
	frame:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	frame:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	frame:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
	frame:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	frame:SetPoint(unpack(point))
	frame:SetScript("OnClick", showDropDown)
	frame:SetScript("OnShow", function(self)
		self:Enable()
	end)
	
	frame.DropDownMenu = CreateFrame("Frame", name.."_DropDownMenu")
	frame.DropDownMenu.name = name
	frame.DropDownMenu.displayMode = "MENU"
	frame.DropDownMenu.initialize = dropDownInit
	
	return frame
end