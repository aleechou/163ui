--[[
	parent.lua
    The parent options panel
--]]


local ADDON, Addon = ...
Addon.frame = 'inventory'

local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')
local Main = Addon.Panel:New('CombuctorOptions', 'Combuctor', L.OptionsSubtitle)
local panels = {}


--[[ Frame Selector ]]--

local drop = Main:NewDropdown(L.Panel)
function drop:Initialize()
  self:AddItem(L.Inventory, 'inventory')
  self:AddItem(L.Bank, 'bank')
end

function drop:AddItem(text, value)
  UIDropDownMenu_AddButton({
    text = text,
    func = self.Click,
    checked = value == Addon.frame,
    value = value,
  })
end

function drop:Click()
  Addon.frame = self.value
  UIDropDownMenu_SetSelectedValue(drop, self.value)
  drop:GetParent():OnFrameChanged(self.value)
end

UIDropDownMenu_SetWidth(drop, 110)
UIDropDownMenu_Initialize(drop, drop.Initialize)
UIDropDownMenu_SetSelectedValue(drop, Addon.frame)


--[[ Create Panels ]]--

function Addon:NewPanel(name)
	local panel = Addon.Panel:New('CombuctorOptions' .. name, 'Combuctor', L.OptionsSubtitle, nil, 'Combuctor', L[name])
	tinsert(panels, panel)
	return panel
end


--[[ Display Panels ]]--

hooksecurefunc('InterfaceOptionsList_DisplayPanel', function(target)
	if target == Main then
		InterfaceOptionsFrame_OpenToCategory(panels[1])
  		Main:Hide()
	else
		for i, panel in ipairs(panels) do
			if panel == target then
				drop:SetParent(panel)
				drop:SetPoint('TOPLEFT', 6, -72)

				panel:OnFrameChanged()
				break
			end
		end
	end
end)