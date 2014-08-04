--[[
	Frame.lua
		General Bagnon settings
--]]

local L = _G['TULLARANGE_CONFIG_LOCALS']
local ColorOptions = tullaRangeConfig.OptionsPanel:New('tullaRangeOptions_Colors', 'tullaRange', L.ColorSettings, L.ColorSettingsTitle); ColorOptions:Hide()
tullaRangeConfig.ColorOptions = ColorOptions

local SPACING = 4
local COLOR_TYPES = {'oor', 'oom'}

--[[
	Startup
--]]

function ColorOptions:Load()
	self:SetScript('OnShow', self.OnShow)
	self:AddWidgets()
end


--[[
	Frame Events
--]]

function ColorOptions:OnShow()
	self:UpdateWidgets()
end


--[[
	Components
--]]

function ColorOptions:AddWidgets()
	local lastSelector = nil
	for i, type in self:GetColorTypes() do
		local selector = self:CreateColorSelector(type)
		if i == 1 then
			selector:SetPoint('TOPLEFT', 16, -72)
		else
			selector:SetPoint('TOPLEFT', lastSelector, 'BOTTOMLEFT', 0, -(SPACING + 6))
		end
		lastSelector = selector
	end
end

function ColorOptions:UpdateWidgets()
	if not self:IsVisible() then
		return
	end

	if self.sliders then
		for i, s in pairs(self.sliders) do
			s:UpdateValue()
		end
	end

	for i, type in self:GetColorTypes() do
		local selector = self:GetColorSelector(type)
		selector:UpdateColor()
	end
end

function ColorOptions:GetColorTypes()
	return pairs(COLOR_TYPES)
end


--[[ Color Pickers ]]--

--frame color
function ColorOptions:CreateColorSelector(type)
	local selector = tullaRangeConfig.OptionsColorSelector:New(L['Color_' .. type], self, false)

	selector.OnSetColor = function(self, r, g, b)
		tullaRange:SetColor(type, r, g, b)
	end

	selector.GetColor = function(self)
		return tullaRange:GetColor(type)
	end

	local colorSelectors = self.colorSelectors or {}
	colorSelectors[type] = selector
	self.colorSelectors = colorSelectors

	return selector
end

function ColorOptions:GetColorSelector(type)
	return self.colorSelectors and self.colorSelectors[type]
end


--[[ Sliders ]]--

function ColorOptions:NewSlider(name, low, high, step)
	local s = tullaRangeConfig.OptionsSlider:New(name, self, low, high, step)
	s:SetHeight(s:GetHeight() + 2)

	self.sliders = self.sliders or {}
	table.insert(self.sliders, s)
	return s
end

--[[ Load the thing ]]--

ColorOptions:Load()