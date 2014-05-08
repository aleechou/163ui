--[[
	Frame.lua
		General Bagnon settings
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local L = LibStub('AceLocale-3.0'):GetLocale('Bagnon-Config')
local DisplayOptions = Bagnon.OptionsPanel:New('BagnonOptions_Display', 'Bagnon', L.DisplaySettings, L.DisplaySettingsTitle)
DisplayOptions:Hide()

Bagnon.DisplayOptions = DisplayOptions

local SPACING = 4


--[[ Events ]]--

function DisplayOptions:OnStartup()
	local displayEvents = {'bank', 'ah', 'trade', 'gems', 'craft', 'guildbank', 'player', 'vendor', 'combat', 'vehicle'}
	for i, event in ipairs(displayEvents) do
		self:AddDisplayEventCheckbox(event)
	end

	self:SetFrameID('inventory')
end

function DisplayOptions:OnActivate()
	for i, button in self:GetDisplayEventCheckboxes() do
		button:UpdateChecked()
	end

	self:RegisterMessage('FRAME_DISPLAY_EVENT_UPDATE')
end

function DisplayOptions:FRAME_DISPLAY_EVENT_UPDATE(msg, frameID, event, enable)
	self:GetDisplayEventCheckbox(event):UpdateChecked()
end


--[[ Check Boxes ]]--

--bag frame
function DisplayOptions:AddDisplayEventCheckbox(event)
	local button = Bagnon.OptionsCheckButton:New(L['EnableAutoDisplay_' .. event], self)
	button.event = event

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetShowFrameAtEvent(self:GetParent():GetFrameID(), self.event, enable)
	end

	button.IsSettingEnabled = function(self, enable)
		return Bagnon.Settings:IsFrameShownAtEvent(self:GetParent():GetFrameID(), self.event)
	end

	if self.displayEventCheckboxes then
		button:SetPoint('TOPLEFT', self.displayEventCheckboxes[#self.displayEventCheckboxes], 'BOTTOMLEFT', 0, -SPACING)
	else
		self.displayEventCheckboxes = {}
		button:SetPoint('TOPLEFT', self, 'TOPLEFT', 14, -72)
	end

	table.insert(self.displayEventCheckboxes, button)
	return button
end

function DisplayOptions:GetDisplayEventCheckbox(event)
	for i, button in self:GetDisplayEventCheckboxes() do
		if button.event == event then
			return button
		end
	end
	return false
end

function DisplayOptions:GetDisplayEventCheckboxes()
	return ipairs(self.displayEventCheckboxes)
end

--[[ Load the thing ]]--

DisplayOptions:Startup()