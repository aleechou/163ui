--[[

	Copyright (c) 2009 - 2012 Adrian L Lange <adrianlund@gmail.com>
	All rights reserved.

	You're allowed to use this addon, free of monetary charge,
	but you are not allowed to modify, alter, or redistribute
	this addon without express, written permission of the author.

--]]

local Broker_Equipment = CreateFrame('Frame')
Broker_Equipment:RegisterEvent('PLAYER_LOGIN')
Broker_Equipment:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
Broker_Equipment:Hide()

local LDB, pending

local function UpdateDisplay()
	if(InCombatLockdown() and pending) then
		LDB.text = '|cffffff00' .. pending
		LDB.icon = 'Interface\\Icons\\' .. GetEquipmentSetInfoByName(pending)
	else
		for index = 1, GetNumEquipmentSets() do
			local name, icon, _, equipped = GetEquipmentSetInfo(index)
			if(equipped) then
				LDB.text = name
				LDB.icon = icon
				return
			end
		end

		LDB.text = UNKNOWN
		LDB.icon = [=[Interface\Icons\INV_Misc_QuestionMark]=]
	end
end

local function ClickDropdown(self, name)
	if(IsShiftKeyDown() and not pending) then
		local dialog = StaticPopup_Show('CONFIRM_SAVE_EQUIPMENT_SET', name)
		dialog.data = name
	elseif(IsControlKeyDown() and not pending) then
		local dialog = StaticPopup_Show('CONFIRM_DELETE_EQUIPMENT_SET', name)
		dialog.data = name
	else
		if(InCombatLockdown()) then
			Broker_Equipment:RegisterEvent('PLAYER_REGEN_ENABLED')
			pending = name

			UpdateDisplay()
		else
			EquipmentManager_EquipSet(name)
		end
	end
end

local function OnTooltipShow(self)
	self:SetEquipmentSet(LDB.text)
end

local function OnClick(self, button)
	if(GameTooltip:GetOwner() == self) then
		GameTooltip:Hide()
	end

	if(button ~= 'RightButton' and GetNumEquipmentSets() > 0) then
		ToggleDropDownMenu(1, nil, Broker_Equipment, self, 0, 0)
	else
		if(not PaperDollFrame:IsVisible()) then
			ToggleCharacter('PaperDollFrame')
		end

		if(not CharacterFrame.Expanded) then
			SetCVar('characterFrameCollapsed', '0')
			CharacterFrame_Expand()
		end

		if(not _G[PAPERDOLL_SIDEBARS[3].frame]:IsShown()) then
			Broker_Equipment:Show()
		end
	end
end

local info = {}
local function CreateDropdown()
	for index = 1, GetNumEquipmentSets() do
		local name, icon, _, equipped, _, _, _, missing  = GetEquipmentSetInfo(index)
		info.func = ClickDropdown
		info.icon = icon
		info.arg1 = name
		info.checked = equipped

		if(pending == name) then
			info.text = string.format('|cffffff00%s|r', name)
		elseif(missing > 0) then
			info.text = string.format('|cffff0000%s|r', name)
		else
			info.text = name
		end

		UIDropDownMenu_AddButton(info)
	end
end

function Broker_Equipment:PLAYER_LOGIN()
	LDB = LibStub('LibDataBroker-1.1'):NewDataObject('Broker_Equipment', {
		type = 'data source',
		OnTooltipShow = OnTooltipShow,
		OnClick = OnClick,
	})

	self:RegisterEvent('UNIT_INVENTORY_CHANGED')
	self:RegisterEvent('EQUIPMENT_SETS_CHANGED')
	self.EQUIPMENT_SETS_CHANGED = UpdateDisplay

	self.initialize = CreateDropdown
	self.displayMode = 'MENU'

	UpdateDisplay()
end

function Broker_Equipment:UNIT_INVENTORY_CHANGED(unit)
	if(unit == 'player') then
		UpdateDisplay()
	end
end

function Broker_Equipment:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent('PLAYER_REGEN_ENABLED')

	ClickDropdown(nil, pending)
	pending = nil
end

Broker_Equipment:SetScript('OnUpdate', function(self)
	PaperDollFrame_SetSidebar(nil, 3)
	self:Hide()
end)
