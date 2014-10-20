--[[
	Frame.lua
		General Bagnon settings
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local L = LibStub('AceLocale-3.0'):GetLocale('Bagnon-Config')
local FrameOptions = Bagnon.OptionsPanel:New('BagnonOptions_Frame', 'Bagnon', L.FrameSettings, L.FrameSettingsTitle)
FrameOptions:Hide()

Bagnon.FrameOptions = FrameOptions

local CHECK_BUTTON_SPACING = 4


--[[ Events ]]--

function FrameOptions:OnStartup()
	self:SetFrameID('inventory')
	local frameSelector = self:CreateFrameSelector()
	frameSelector:SetPoint('TOPLEFT', self, 'TOPLEFT', -4, -64)


	-- Checkboxes
	local toggleBagFrame = self:CreateToggleBagFrameCheckbox()
	toggleBagFrame:SetPoint('TOPLEFT', frameSelector, 'BOTTOMLEFT', 16, -4)

	local toggleMoneyFrame = self:CreateToggleMoneyFrameCheckbox()
	toggleMoneyFrame:SetPoint('TOPLEFT', toggleBagFrame, 'BOTTOMLEFT', 0, -CHECK_BUTTON_SPACING)

	local toggleDBOFrame = self:CreateToggleDBOFrameCheckbox()
	toggleDBOFrame:SetPoint('TOPLEFT', toggleMoneyFrame, 'BOTTOMLEFT', 0, -CHECK_BUTTON_SPACING)

	local toggleSortButton = self:CreateToggleSortButtonCheckbox()
	toggleSortButton:SetPoint('TOPLEFT', toggleDBOFrame, 'BOTTOMLEFT', 0, -CHECK_BUTTON_SPACING)

	local toggleSearchFrame = self:CreateToggleSearchFrameCheckbox()
	toggleSearchFrame:SetPoint('TOPLEFT', toggleSortButton, 'BOTTOMLEFT', 0, -CHECK_BUTTON_SPACING)
	
	local toggleOptionsFrame = self:CreateToggleOptionsCheckbox()
	toggleOptionsFrame:SetPoint('TOPLEFT', toggleSearchFrame, 'BOTTOMLEFT', 0, -CHECK_BUTTON_SPACING)

	local reverseSlotOrdering = self:CreateReverseSlotOrderCheckbox()
	reverseSlotOrdering:SetPoint('TOPLEFT', toggleOptionsFrame, 'BOTTOMLEFT', 0, -CHECK_BUTTON_SPACING)
	
	local bagBreak = self:CreateBagBreakCheckbox()
	bagBreak:SetPoint('TOPLEFT', reverseSlotOrdering, 'BOTTOMLEFT', 0, -CHECK_BUTTON_SPACING)


	-- Color Selectors
	local frameColor = self:CreateColorSelector()
	frameColor:SetPoint('TOPLEFT', frameSelector, 'BOTTOMRIGHT', -28, -6)

	local frameBorderColor = self:CreateBorderColorSelector()
	frameBorderColor:SetPoint('TOPLEFT', frameColor, 'BOTTOMLEFT', 0, -8)


	-- Sliders
	local opacity = self:CreateOpacitySlider()
	opacity:SetWidth(180)
	opacity:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -16, 10)

	local scale = self:CreateScaleSlider()
	scale:SetPoint('BOTTOMLEFT', opacity, 'TOPLEFT', 0, 20)
	scale:SetPoint('BOTTOMRIGHT', opacity, 'TOPRIGHT', 0, 20)

	local spacing = self:CreateSpacingSlider()
	spacing:SetPoint('BOTTOMLEFT', scale, 'TOPLEFT', 0, 20)
	spacing:SetPoint('BOTTOMRIGHT', scale, 'TOPRIGHT', 0, 20)

	local cols = self:CreateColumnsSlider()
	cols:SetPoint('BOTTOMLEFT', spacing, 'TOPLEFT', 0, 20)
	cols:SetPoint('BOTTOMRIGHT', spacing, 'TOPRIGHT', 0, 20)

	local layer = self:CreateLayerSlider()
	layer:SetPoint('BOTTOMLEFT', cols, 'TOPLEFT', 0, 20)
	layer:SetPoint('BOTTOMRIGHT', cols, 'TOPRIGHT', 0, 20)
end

function FrameOptions:OnActivate()
	local settings = self:GetSettings()
	local frameID = self:GetFrameID()
	local isSingleBag = frameID == 'guildbank' or frameID == 'voidstorage'

	self:GetColorSelector():SetColor(settings:GetColor())
	self:GetBorderColorSelector():SetColor(settings:GetBorderColor())

	self:GetColumnsSlider():UpdateValue()
	self:GetSpacingSlider():UpdateValue()

	self:GetScaleSlider():UpdateValue()
	self:GetOpacitySlider():UpdateValue()
	self:GetLayerSlider():UpdateValue()

	self:GetToggleBagFrameCheckbox():UpdateChecked()
	self:GetToggleBagFrameCheckbox():SetDisabled(isSingleBag)

	self:GetToggleSortButtonCheckbox():UpdateChecked()
	self:GetToggleSortButtonCheckbox():SetDisabled(isSingleBag)

	self:GetToggleMoneyFrameCheckbox():UpdateChecked()
	self:GetToggleSortButtonCheckbox():SetDisabled(frameID == 'voidstorage')

	self:GetToggleDBOFrameCheckbox():UpdateChecked()
	self:GetToggleSearchFrameCheckbox():UpdateChecked()
	self:GetToggleOptionsCheckbox():UpdateChecked()
	
	self:GetReverseSlotOrderCheckbox():UpdateChecked()
	self:GetReverseSlotOrderCheckbox():SetDisabled(isSingleBag)
	
	self:GetBagBreakCheckbox():UpdateChecked()
	self:GetBagBreakCheckbox():SetDisabled(isSingleBag)

	self:RegisterMessage('FRAME_LAYER_UPDATE')
	self:RegisterMessage('FRAME_SCALE_UPDATE')
	self:RegisterMessage('FRAME_OPACITY_UPDATE')
	self:RegisterMessage('FRAME_COLOR_UPDATE')
	self:RegisterMessage('FRAME_BORDER_COLOR_UPDATE')
	self:RegisterMessage('ITEM_FRAME_SPACING_UPDATE')
	self:RegisterMessage('ITEM_FRAME_COLUMNS_UPDATE')

	self:RegisterMessage('BAG_FRAME_ENABLE_UPDATE')
	self:RegisterMessage('MONEY_FRAME_ENABLE_UPDATE')
	self:RegisterMessage('DATABROKER_FRAME_ENABLE_UPDATE')
	self:RegisterMessage('SEARCH_TOGGLE_ENABLE_UPDATE')
	self:RegisterMessage('SLOT_ORDER_UPDATE')
	self:RegisterMessage('OPTIONS_TOGGLE_ENABLE_UPDATE')
end


--[[ Messages ]]--

function FrameOptions:FRAME_LAYER_UPDATE(msg, frameID, layer)
	if self:GetFrameID() == frameID then
		self:GetLayerSlider():UpdateValue()
	end
end

function FrameOptions:FRAME_SCALE_UPDATE(msg, frameID, scale)
	if self:GetFrameID() == frameID then
		self:GetScaleSlider():UpdateValue()
	end
end

function FrameOptions:FRAME_OPACITY_UPDATE(msg, frameID, opacity)
	if self:GetFrameID() == frameID then
		self:GetOpacitySlider():UpdateValue()
	end
end

function FrameOptions:FRAME_COLOR_UPDATE(msg, frameID, r, g, b, a)
	if self:GetFrameID() == frameID then
		self:GetColorSelector():SetColor(r, g, b, a)
	end
end

function FrameOptions:FRAME_BORDER_COLOR_UPDATE(msg, frameID, r, g, b, a)
	if self:GetFrameID() == frameID then
		self:GetBorderColorSelector():SetColor(r, g, b, a)
	end
end

function FrameOptions:ITEM_FRAME_SPACING_UPDATE(msg, frameID, spacing)
	if self:GetFrameID() == frameID then
		self:GetSpacingSlider():UpdateValue()
	end
end

function FrameOptions:ITEM_FRAME_COLUMNS_UPDATE(msg, frameID, columns)
	if self:GetFrameID() == frameID then
		self:GetColumnsSlider():UpdateValue()
	end
end

function FrameOptions:BAG_FRAME_ENABLE_UPDATE(msg, frameID, enable)
	if self:GetFrameID() == frameID then
		self:GetToggleBagFrameCheckbox():UpdateChecked()
	end
end

function FrameOptions:MONEY_FRAME_ENABLE_UPDATE(msg, frameID, enable)
	if self:GetFrameID() == frameID then
		self:GetToggleMoneyFrameCheckbox():UpdateChecked()
	end
end

function FrameOptions:DATABROKER_FRAME_ENABLE_UPDATE(msg, frameID, enable)
	if self:GetFrameID() == frameID then
		self:GetToggleDBOFrameCheckbox():UpdateChecked()
	end
end

function FrameOptions:SORT_ENABLE_UPDATE(msg, frameID, enable)
	if self:GetFrameID() == frameID then
		self:GetToggleSortButtonCheckbox():UpdateChecked()
	end
end

function FrameOptions:SEARCH_TOGGLE_ENABLE_UPDATE(msg, frameID, enable)
	if self:GetFrameID() == frameID then
		self:GetToggleSearchFrameCheckbox():UpdateChecked()
	end
end

function FrameOptions:SLOT_ORDER_UPDATE(msg, frameID, enable)
	if self:GetFrameID() == frameID then
		self:GetReverseSlotOrderCheckbox():UpdateChecked()
	end
end

function FrameOptions:ITEM_FRAME_BAG_BREAK_UPDATE(msg, frameID, enable)
	if self:GetFrameID() == frameID then
		self:GetBagBreakCheckbox():UpdateChecked()
	end
end

function FrameOptions:OPTIONS_TOGGLE_ENABLE_UPDATE(msg, frameID, enable)
	if self:GetFrameID() == frameID then
		self:GetToggleOptionsCheckbox():UpdateChecked()
	end
end


--[[ Dropdowns ]]--

--frame selector
function FrameOptions:CreateFrameSelector()
	local dropdown = Bagnon.OptionsDropdown:New(L.Frame, self, 200)
	dropdown.titleText:Hide()

	dropdown.Initialize = function(self)
		self:AddItem(INVENTORY_TOOLTIP, 'inventory')
		self:AddItem(BANK, 'bank')
		
		if GetAddOnEnableState(UnitName('player'), 'Bagnon_GuildBank') >= 2 then
			self:AddItem(GUILD_BANK, 'guildbank')
		end
		
		if GetAddOnEnableState(UnitName('player'), 'Bagnon_VoidStorage') >= 2 then
			self:AddItem(VOID_STORAGE, 'voidstorage')
		end
	end

	dropdown.SetSavedValue = function(self, value)
		self:GetParent():SetFrameID(value)
	end

	dropdown.GetSavedValue = function(self)
		return self:GetParent():GetFrameID()
	end

	self.frameSelector = dropdown
	return dropdown
end

function FrameOptions:GetFrameSelector()
	return self.frameSelector
end


--[[ Color Pickers ]]--

--frame color
function FrameOptions:CreateColorSelector()
	local selector = Bagnon.OptionsColorSelector:New(L.FrameColor, self, true)

	selector.OnSetColor = function(self, r, g, b, a)
		self:GetParent():GetSettings():SetColor(r, g, b, a)
	end

	selector.GetColor = function(self)
		return self:GetParent():GetSettings():GetColor()
	end

	self.colorSelector = selector
	return selector
end

function FrameOptions:GetColorSelector()
	return self.colorSelector
end

--background color
function FrameOptions:CreateBorderColorSelector()
	local selector = Bagnon.OptionsColorSelector:New(L.FrameBorderColor, self, true)

	selector.OnSetColor = function(self, r, g, b, a)
		self:GetParent():GetSettings():SetBorderColor(r, g, b, a)
	end

	selector.GetColor = function(self)
		return self:GetParent():GetSettings():GetBorderColor()
	end

	self.borderColorSelector = selector
	return selector
end

function FrameOptions:GetBorderColorSelector()
	return self.borderColorSelector
end


--[[ Sliders ]]--

--columns
function FrameOptions:CreateColumnsSlider()
	local slider = Bagnon.OptionsSlider:New(L.Columns, self, 4, 36, 1)

	slider.SetSavedValue = function(self, value)
		self:GetParent():GetSettings():SetItemFrameColumns(value)
	end

	slider.GetSavedValue = function(self)
		return self:GetParent():GetSettings():GetItemFrameColumns()
	end

	self.columnsSlider = slider
	return slider
end

function FrameOptions:GetColumnsSlider()
	return self.columnsSlider
end

--spacing
function FrameOptions:CreateSpacingSlider()
	local slider = Bagnon.OptionsSlider:New(L.Spacing, self, -16, 36, 2)

	slider.SetSavedValue = function(self, value)
		self:GetParent():GetSettings():SetItemFrameSpacing(value)
	end

	slider.GetSavedValue = function(self)
		return self:GetParent():GetSettings():GetItemFrameSpacing()
	end

	self.spacingSlider = slider
	return slider
end

function FrameOptions:GetSpacingSlider()
	return self.spacingSlider
end

--scale
function FrameOptions:CreateScaleSlider()
	local slider = Bagnon.OptionsSlider:New(L.Scale, self, 50, 200, 5)

	slider.SetSavedValue = function(self, value)
		self:GetParent():GetSettings():SetScale(value / 100)
	end

	slider.GetSavedValue = function(self)
		return self:GetParent():GetSettings():GetScale() * 100
	end

	slider.GetFormattedText = function(self, value)
		return value .. '%'
	end

	self.scaleSlider = slider
	return slider
end

function FrameOptions:GetScaleSlider()
	return self.scaleSlider
end

--opacity
function FrameOptions:CreateOpacitySlider()
	local slider = Bagnon.OptionsSlider:New(L.Opacity, self, 10, 100, 1)

	slider.SetSavedValue = function(self, value)
		self:GetParent():GetSettings():SetOpacity(value / 100)
	end

	slider.GetSavedValue = function(self)
		return self:GetParent():GetSettings():GetOpacity() * 100
	end

	slider.GetFormattedText = function(self, value)
		return value .. '%'
	end

	self.opacitySlider = slider
	return slider
end

function FrameOptions:GetOpacitySlider()
	return self.opacitySlider
end

--layer
function FrameOptions:CreateLayerSlider()
	local layers = self:GetSettings():GetAvailableLayers()
	local slider = Bagnon.OptionsSlider:New(L.FrameLayer, self, 1, #layers, 1)

	slider.SetSavedValue = function(self, value)
		self:GetParent():GetSettings():SetLayer(layers[floor(value)])
	end

	slider.GetSavedValue = function(self)
		local layer = self:GetParent():GetSettings():GetLayer()
		for k, v in pairs(layers) do
			if v == layer then
				return k
			end
		end
		return 1
	end

	slider.GetFormattedText = function(self, value)
		return layers[value]
	end

	self.layerSlider = slider
	return slider
end

function FrameOptions:GetLayerSlider()
	return self.layerSlider
end



--[[ Check Boxes ]]--

--bag frame
function FrameOptions:CreateToggleBagFrameCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableBagFrame, self)

	button.OnEnableSetting = function(self, enable)
		self:GetParent():GetSettings():SetHasBagFrame(enable)
	end

	button.IsSettingEnabled = function(self, enable)
		return self:GetParent():GetSettings():HasBagFrame()
	end

	self.toggleBagFrameCheckbox = button
	return button
end

function FrameOptions:GetToggleBagFrameCheckbox()
	return self.toggleBagFrameCheckbox
end


--money frame
function FrameOptions:CreateToggleMoneyFrameCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableMoneyFrame, self)

	button.OnEnableSetting = function(self, enable)
		self:GetParent():GetSettings():SetHasMoneyFrame(enable)
	end

	button.IsSettingEnabled = function(self, enable)
		return self:GetParent():GetSettings():HasMoneyFrame()
	end

	self.toggleMoneyFrameCheckbox = button
	return button
end

function FrameOptions:GetToggleMoneyFrameCheckbox()
	return self.toggleMoneyFrameCheckbox
end


--databroker frame
function FrameOptions:CreateToggleDBOFrameCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableDBOFrame, self)

	button.OnEnableSetting = function(self, enable)
		self:GetParent():GetSettings():SetHasDBOFrame(enable)
	end

	button.IsSettingEnabled = function(self, enable)
		return self:GetParent():GetSettings():HasDBOFrame()
	end

	self.toggleDBOFrameCheckbox = button
	return button
end

function FrameOptions:GetToggleDBOFrameCheckbox()
	return self.toggleDBOFrameCheckbox
end


-- sort button
function FrameOptions:CreateToggleSortButtonCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableSortButton, self)

	button.OnEnableSetting = function(self, enable)
		self:GetParent():GetSettings():EnableSortButton(enable)
	end

	button.IsSettingEnabled = function(self, enable)
		return self:GetParent():GetSettings():HasSortButton()
	end

	self.toggleSortButtonCheckbox = button
	return button
end

function FrameOptions:GetToggleSortButtonCheckbox()
	return self.toggleSortButtonCheckbox
end


--search frame toggle
function FrameOptions:CreateToggleSearchFrameCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableSearchToggle, self)

	button.OnEnableSetting = function(self, enable)
		self:GetParent():GetSettings():SetHasSearchToggle(enable)
	end

	button.IsSettingEnabled = function(self, enable)
		return self:GetParent():GetSettings():HasSearchToggle()
	end

	self.toggleSearchFrameCheckbox = button
	return button
end

function FrameOptions:GetToggleSearchFrameCheckbox()
	return self.toggleSearchFrameCheckbox
end


--options frame toggle
function FrameOptions:CreateToggleOptionsCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableOptionsToggle, self)

	button.OnEnableSetting = function(self, enable)
		self:GetParent():GetSettings():SetHasOptionsToggle(enable)
	end

	button.IsSettingEnabled = function(self, enable)
		return self:GetParent():GetSettings():HasOptionsToggle()
	end

	self.toggleOptionsCheckbox = button
	return button
end

function FrameOptions:GetToggleOptionsCheckbox()
	return self.toggleOptionsCheckbox
end


--reverse slot ordering
function FrameOptions:CreateReverseSlotOrderCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.ReverseSlotOrdering, self)

	button.OnEnableSetting = function(self, enable)
		self:GetParent():GetSettings():SetReverseSlotOrder(enable)
	end

	button.IsSettingEnabled = function(self)
		return self:GetParent():GetSettings():IsSlotOrderReversed()
	end

	self.reverseSlotOrderCheckbox = button
	return button
end

function FrameOptions:GetReverseSlotOrderCheckbox()
	return self.reverseSlotOrderCheckbox
end

--bag break layout
function FrameOptions:CreateBagBreakCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableBagBreak, self)

	button.OnEnableSetting = function(self, enable)
		self:GetParent():GetSettings():SetBagBreak(enable)
	end

	button.IsSettingEnabled = function(self)
		return self:GetParent():GetSettings():IsBagBreakEnabled()
	end

	self.bagBreakCheckbox = button
	return button
end

function FrameOptions:GetBagBreakCheckbox()
	return self.bagBreakCheckbox
end


--[[ Load the thing ]]--

FrameOptions:Startup()