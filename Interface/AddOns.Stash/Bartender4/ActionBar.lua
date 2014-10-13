--[[
	Copyright (c) 2009-2012, Hendrik "Nevcairiel" Leppkes < h.leppkes at gmail dot com >
	All rights reserved.
]]
local _, Bartender4 = ...
local StateBar = Bartender4.StateBar.prototype
local ActionBar = setmetatable({}, {__index = StateBar})
Bartender4.ActionBar = ActionBar

local LAB10 = LibStub("LibActionButton-1.0")

local tonumber, format, min = tonumber, format, min

-- GLOBALS: UIParent, VehicleExit

--[[===================================================================================
	ActionBar Prototype
===================================================================================]]--

local initialPosition
do
	-- Sets the Bar to its initial Position in the Center of the Screen
	function initialPosition(bar)
		bar:ClearSetPoint("CENTER", 0, -250 + (bar.id-1) * 38)
		bar:SavePosition()
	end
end

-- Apply the specified config to the bar and refresh all settings
function ActionBar:ApplyConfig(config)
	StateBar.ApplyConfig(self, config)

	if not self.config.position.x then initialPosition(self) end

	self:UpdateButtons()
	self:UpdateButtonConfig()
end

function ActionBar:UpdateButtonConfig()
	StateBar.UpdateButtonConfig(self)
	if not self.buttonConfig then self.buttonConfig = { colors = { range = {}, mana = {} }, hideElements = {} } end
	self.buttonConfig.outOfRangeColoring = Bartender4.db.profile.outofrange
	self.buttonConfig.tooltip = Bartender4.db.profile.tooltip
	self.buttonConfig.colors.range[1], self.buttonConfig.colors.range[2], self.buttonConfig.colors.range[3] = Bartender4.db.profile.colors.range.r, Bartender4.db.profile.colors.range.g, Bartender4.db.profile.colors.range.b
	self.buttonConfig.colors.mana[1], self.buttonConfig.colors.mana[2], self.buttonConfig.colors.mana[3] = Bartender4.db.profile.colors.mana.r, Bartender4.db.profile.colors.mana.g, Bartender4.db.profile.colors.mana.b

	self.buttonConfig.hideElements.macro = self.config.hidemacrotext and true or false
	self.buttonConfig.hideElements.hotkey = self.config.hidehotkey and true or false
	self.buttonConfig.hideElements.equipped = self.config.hideequipped and true or false

	self.buttonConfig.showGrid = self.config.showgrid
	self.buttonConfig.clickOnDown = Bartender4.db.profile.onkeydown
	self.buttonConfig.flyoutDirection = self.config.flyoutDirection

	if tonumber(self.id) == 1 then
		for i, button in self:GetAll() do
			self.buttonConfig.keyBoundTarget = format("ACTIONBUTTON%d", i)
			button:UpdateConfig(self.buttonConfig)
		end
	else
		self:ForAll("UpdateConfig", self.buttonConfig)
	end

	self:ForAll("SetAttribute", "autoassist", self.config.autoassist)
	-- self casting
	self:ForAll("SetAttribute", "checkselfcast", Bartender4.db.profile.selfcastmodifier and true or nil)
	self:ForAll("SetAttribute", "checkfocuscast", Bartender4.db.profile.focuscastmodifier and true or nil)
	self:ForAll("SetAttribute", "*unit2", Bartender4.db.profile.selfcastrightclick and "player" or nil)
	-- button lock
	self:ForAll("SetAttribute", "buttonlock", Bartender4.db.profile.buttonlock)
	-- update state
	self:ForAll("UpdateState")
end

local UpdateAutoAssist = [[
	local state, type, action = ...
	self:SetAttribute("assisttype", nil)
	self:SetAttribute("unit", nil)
	if self:GetAttribute("autoassist") then
		if type == "action" then
			type, action = GetActionInfo(action)
		end
		if type == "spell" and action > 0 then
			local id, subtype = FindSpellBookSlotBySpellID(action), "spell"
			if id and id > 0 then
				if IsHelpfulSpell(id, subtype) then
					self:SetAttribute("assisttype", 1)
					self:SetAttribute("unit", self:GetAttribute("assist_help"))
				elseif IsHarmfulSpell(id, subtype) then
					self:SetAttribute("assisttype", 2)
					self:SetAttribute("unit", self:GetAttribute("assist_harm"))
				end
			end
		end
	end
]]

local customExitButton = {
	func = function(button)
		VehicleExit()
	end,
	texture = "Interface\\Icons\\Spell_Shadow_SacrificialShield",
	tooltip = LEAVE_VEHICLE,
}

-- Update the number of buttons in our bar, creating new ones if necessary
function ActionBar:UpdateButtons(numbuttons)
	if numbuttons then
		self.config.buttons = min(numbuttons, 12)
	else
		numbuttons = min(self.config.buttons, 12)
	end

	local buttons = self.buttons or {}

	local updateBindings = (numbuttons > #buttons)
	-- create more buttons if needed
	for i = (#buttons+1), numbuttons do
		local absid = (self.id - 1) * 12 + i
		buttons[i] = LAB10:CreateButton(absid, format("BT4Button%d", absid), self, nil)
		for k = 1,14 do
			buttons[i]:SetState(k, "action", (k - 1) * 12 + i)
		end
		buttons[i]:SetState(0, "action", absid)

		if self.MasqueGroup then
			buttons[i]:AddToMasque(self.MasqueGroup)
		elseif self.LBFGroup then
			buttons[i]:AddToButtonFacade(self.LBFGroup)
		end

		buttons[i]:SetAttribute("OnStateChanged", UpdateAutoAssist)

		buttons[i]:SetAttribute("_childupdate-assist-help", [[
			self:SetAttribute("assist_help", message)
			if self:GetAttribute("assisttype") == 1 then
				self:SetAttribute("unit", message)
			end
		]])

		buttons[i]:SetAttribute("_childupdate-assist-harm", [[
			self:SetAttribute("assist_harm", message)
			if self:GetAttribute("assisttype") == 2 then
				self:SetAttribute("unit", message)
			end
		]])

		if i == 12 then
			buttons[i]:SetState(11, "custom", customExitButton)
			buttons[i]:SetState(12, "custom", customExitButton)
		end
	end

	-- show active buttons
	for i = 1, numbuttons do
		buttons[i]:SetParent(self)
		buttons[i]:Show()
		buttons[i]:SetAttribute("statehidden", nil)
		buttons[i]:UpdateAction()
	end

	-- hide inactive buttons
	for i = (numbuttons + 1), #buttons do
		buttons[i]:Hide()
		buttons[i]:SetParent(UIParent)
		buttons[i]:SetAttribute("statehidden", true)
	end

	self.numbuttons = numbuttons
	self.buttons = buttons

	self:UpdateButtonLayout()
	self:SetGrid()
	if updateBindings and self.id == "1" then
		self.module:ReassignBindings()
	end

	-- need to re-set clickthrough after creating new buttons
	self:SetClickThrough()
	self:UpdateSelfCast() -- update selfcast and states
end

function ActionBar:SkinChanged(...)
	StateBar.SkinChanged(self, ...)
	self:ForAll("UpdateAction")
end


--[[===================================================================================
	ActionBar Config Interface
===================================================================================]]--


-- get the current number of buttons
function ActionBar:GetButtons()
	return self.config.buttons
end

-- set the number of buttons and refresh layout
ActionBar.SetButtons = ActionBar.UpdateButtons

function ActionBar:GetEnabled()
	return true
end

function ActionBar:SetEnabled(state)
	if not state then
		self.module:DisableBar(self.id)
	end
end

function ActionBar:GetGrid()
	return self.config.showgrid
end

function ActionBar:SetGrid(state)
	if state ~= nil then
		self.config.showgrid = state
	end
	self:UpdateButtonConfig()
end

function ActionBar:GetFlyoutDirection()
	return self.config.flyoutDirection
end

function ActionBar:SetFlyoutDirection(state)
	if state ~= nil then
		self.config.flyoutDirection = state
	end
	self:UpdateButtonConfig()
end
