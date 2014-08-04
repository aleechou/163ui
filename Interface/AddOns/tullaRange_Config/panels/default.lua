local DEFAULT_PANEL = 'ColorOptions'

--a hack panel, this is designed to force open to the general options panel when clicked
local tullaRangeOptions = tullaRangeConfig.OptionsPanel:New('tullaRange', nil, 'tullaRange'); tullaRangeOptions:Hide()

tullaRangeOptions:SetScript('OnShow', function(self)
	local panel = tullaRangeConfig[DEFAULT_PANEL]
	
	InterfaceOptionsFrame_OpenToCategory(panel)
end)
