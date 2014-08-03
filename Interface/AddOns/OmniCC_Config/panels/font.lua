--[[
	font.lua: the OmniCC font styles panel
--]]

local FontOptions = CreateFrame('Frame', 'OmniCCOptions_Font')
local Timer = OmniCC.Timer
local L = OMNICC_LOCALS
local BUTTON_SPACING = 24

--[[ Events ]]--

function FontOptions:AddWidgets()
	--add font selector
	local fontSelector = self:CreateFontSelector(L.Font)
	fontSelector:SetPoint('TOPLEFT', self, 'TOPLEFT', 12, -20)
	fontSelector:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -16, 240)

	--add color picker
	local colorPicker = self:CreateColorPickerFrame(L.ColorAndScale)
	colorPicker:SetPoint('TOPLEFT', fontSelector, 'BOTTOMLEFT', 0, -16)
	colorPicker:SetPoint('TOPRIGHT', fontSelector, 'BOTTOMRIGHT', 0, -16)
	colorPicker:SetHeight(BUTTON_SPACING*6 - 4)

	--add font outline picker
	local outlinePicker = self:CreateFontOutlinePicker()
	outlinePicker:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 16, 10)
	outlinePicker:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -16, 10)

	--add font size slider
	local fontSize = self:CreateFontSizeSlider()
	fontSize:SetPoint('BOTTOMLEFT', outlinePicker, 'TOPLEFT', 0, 20)
	fontSize:SetPoint('BOTTOMRIGHT', outlinePicker, 'TOPRIGHT', 0, 20)
end


--[[ Font Selector ]]--

function FontOptions:CreateFontSelector(name)
	local f = OmniCCOptions.FontSelector:New(name, self, 552, 232)

	f.SetSavedValue = function(self, value)
		OmniCCOptions:GetGroupSets().fontFace = value
		Timer:ForAll('UpdateText', true)
	end

	f.GetSavedValue = function(self)
		return OmniCCOptions:GetGroupSets().fontFace
	end

	return f
end


--[[ Color Picker ]]--

function FontOptions:CreateColorPickerFrame(name)
	local f = OmniCCOptions.Group:New(name, self)

	local soon = self:CreateStylePicker('soon', f)
	soon:SetPoint('TOPLEFT', 8, -(BUTTON_SPACING + 4))
	soon:SetPoint('TOPRIGHT', f, 'TOP', -4, -(BUTTON_SPACING + 4))

	local seconds = self:CreateStylePicker('seconds', f)
	seconds:SetPoint('TOPLEFT', f, 'TOP', 4,  -(BUTTON_SPACING + 4))
	seconds:SetPoint('TOPRIGHT', -8, -(BUTTON_SPACING + 4))

	local minutes = self:CreateStylePicker('minutes', f)
	minutes:SetPoint('TOPLEFT', soon, 'BOTTOMLEFT', 0, -BUTTON_SPACING)
	minutes:SetPoint('TOPRIGHT', soon, 'BOTTOMRIGHT', 0, -BUTTON_SPACING)

	local hours = self:CreateStylePicker('hours', f)
	hours:SetPoint('TOPLEFT', seconds, 'BOTTOMLEFT', 0, -BUTTON_SPACING)
	hours:SetPoint('TOPRIGHT', seconds, 'BOTTOMRIGHT', 0, -BUTTON_SPACING)

	local charging = self:CreateStylePicker('charging', f)
	charging:SetPoint('TOPLEFT', minutes, 'BOTTOMLEFT', 0, -BUTTON_SPACING)
	charging:SetPoint('TOPRIGHT', minutes, 'BOTTOMRIGHT', 0, -BUTTON_SPACING)

	return f
end


--[[ Sliders ]]--

function FontOptions:NewSlider(name, low, high, step)
	local s = OmniCCOptions.Slider:New(name, self, low, high, step)
	return s
end

function FontOptions:CreateFontSizeSlider()
	local s = self:NewSlider(L.FontSize, 2, 48, 1)

	s.SetSavedValue = function(self, value)
		OmniCCOptions:GetGroupSets().fontSize = value
		Timer:ForAll('UpdateText', true)
	end

	s.GetSavedValue = function(self)
		return OmniCCOptions:GetGroupSets().fontSize
	end

	s.tooltip = L.FontSizeTip

	return s
end

do
	local fontOutlines = {'NONE', 'OUTLINE', 'THICKOUTLINE', 'OUTLINEMONOCHROME'}
	local function toIndex(fontOutline)
		for i, outline in pairs(fontOutlines) do
			if outline == fontOutline then
				return i
			end
		end
	end

	local function toOutline(index)
		return fontOutlines[index]
	end

	function FontOptions:CreateFontOutlinePicker()
		local s = self:NewSlider(L.FontOutline, 1, #fontOutlines, 1)

		s.SetSavedValue = function(self, value)
			OmniCCOptions:GetGroupSets().fontOutline = toOutline(value)
			Timer:ForAll('UpdateText', true)
		end

		s.GetSavedValue = function(self)
			return toIndex(OmniCCOptions:GetGroupSets().fontOutline) or 1
		end

		s.GetFormattedText = function(self, value)
			return L['Outline_' .. toOutline(value or 1)]
		end

		s.tooltip = L.FontOutlineTip

		return s
	end
end


--[[ color picker ]]--


function FontOptions:CreateStylePicker(timePeriod, parent)
	local slider = OmniCCOptions.Slider:New(L['Color_' .. timePeriod], parent, 0.5, 2, 0.05)

	 _G[slider:GetName() .. 'Text']:Hide()

	slider.SetSavedValue = function(self, value)
		OmniCCOptions:GetGroupSets().styles[timePeriod].scale = value
		Timer:ForAll('UpdateText', true)
	end

	slider.GetSavedValue = function(self)
		return OmniCCOptions:GetGroupSets().styles[timePeriod].scale
	end

	slider.GetFormattedText = function(self, value)
		return floor(value * 100 + 0.5) .. '%'
	end

	--color picker
	local picker = OmniCCOptions.ColorSelector:New(L['Color_' .. timePeriod], slider, true)
	picker:SetPoint('BOTTOMLEFT', slider, 'TOPLEFT')

	picker.OnSetColor = function(self, r, g, b, a)
		local style = OmniCCOptions:GetGroupSets().styles[timePeriod]
		style.r, style.g, style.b, style.a = r, g, b, a
		Timer:ForAll('UpdateText', true)
	end

	picker.GetColor = function(self)
		local style = OmniCCOptions:GetGroupSets().styles[timePeriod]
		return style.r, style.g, style.b, style.a
	end

	picker.text:ClearAllPoints()
	picker.text:SetPoint('BOTTOMLEFT', picker, 'BOTTOMRIGHT', 4, 0)

	return slider
end


--[[ Load the thing ]]--

FontOptions:AddWidgets()
OmniCCOptions:AddTab('font', L.FontSettings, FontOptions)