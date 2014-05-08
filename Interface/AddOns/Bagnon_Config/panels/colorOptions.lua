--[[
	Frame.lua
		General Bagnon settings
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local L = LibStub('AceLocale-3.0'):GetLocale('Bagnon-Config')
local ColorOptions = Bagnon.OptionsPanel:New('BagnonOptions_Colors', 'Bagnon', L.ColorSettings, L.ColorSettingsTitle)
ColorOptions:Hide()

Bagnon.ColorOptions = ColorOptions

local SPACING = 4
local SLOT_COLOR_TYPES = {}

for bit, name in pairs(BAGNON_BAG_TYPES) do
	tinsert(SLOT_COLOR_TYPES, name)
end

sort(SLOT_COLOR_TYPES)
tinsert(SLOT_COLOR_TYPES, 1, 'normal')


--[[ Events ]]--

function ColorOptions:OnStartup()
	local colorItemSlots = self:CreateColorItemSlotsCheckbox()
	colorItemSlots:SetPoint('TOPLEFT', self, 'TOPLEFT', 14, -72)

	local highlightItemsByQuality = self:CreateHighlightItemsByQualityCheckbox()
	highlightItemsByQuality:SetPoint('TOPLEFT', colorItemSlots, 'BOTTOMLEFT', 0, -SPACING)

    local highlightUnusableItems = self:CreateHighlightUnusableItemsCheckbox()
	highlightUnusableItems:SetPoint('TOPLEFT', highlightItemsByQuality, 'BOTTOMLEFT', 0, -SPACING)

	local highlightSetItems = self:CreateHighlightSetItemsCheckbox()
	highlightSetItems:SetPoint('TOPLEFT', highlightUnusableItems, 'BOTTOMLEFT', 0, -SPACING)

	local highightQuestItems = self:CreateHighlightQuestItemsCheckbox()
	highightQuestItems:SetPoint('TOPLEFT', highlightSetItems, 'BOTTOMLEFT', 0, -SPACING)
	
	local opacity = self:CreateHighlightOpacitySlider()
	opacity:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 16, 10)
	opacity:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -16, 10)
	
	local lastCheckbox = highightQuestItems
	local lastSelector = nil
	for i, type in self:GetColorTypes() do
		local selector = self:CreateItemSlotColorSelector(type)
		if i == 1 then
			selector:SetPoint('TOPLEFT', lastCheckbox, 'BOTTOMLEFT', 4, -(SPACING + 4))
		else
			selector:SetPoint('TOPLEFT', lastSelector, 'BOTTOMLEFT', 0, -(SPACING + 6))
		end
		lastSelector = selector
	end
end

function ColorOptions:OnActivate()
	self.highlightItemsByQualityCheckbox:UpdateChecked()
	self.highlightUnusableItemsCheckbox:UpdateChecked()
	self.highlightQuestItemsCheckbox:UpdateChecked()
	self.highlightSetItemsCheckbox:UpdateChecked()
	self.highlightOpacitySlider:UpdateValue()
	
	for i, type in self:GetColorTypes() do
		local selector = self:GetItemSlotColorSelector(type)
		selector:UpdateColor()
	end
	
	self:RegisterMessage('ITEM_HIGHLIGHT_UPDATE')
	self:RegisterMessage('ITEM_SLOT_COLOR_ENABLED_UPDATE')
	self:RegisterMessage('ITEM_SLOT_COLOR_UPDATE')
	self:RegisterMessage('ITEM_HIGHLIGHT_UPDATE')
end

function ColorOptions:GetColorTypes()
	return pairs(SLOT_COLOR_TYPES)
end


--[[ Messages ]]--

function ColorOptions:ITEM_HIGHLIGHT_UPDATE()
	self.highlightItemsByQualityCheckbox:UpdateChecked()
	self.highlightUnusableItemsCheckbox:UpdateChecked()
	self.highlightQuestItemsCheckbox:UpdateChecked()
	self.highlightSetItemsCheckbox:UpdateChecked()
	self.highlightOpacitySlider:UpdateValue()
end

function ColorOptions:ITEM_SLOT_COLOR_ENABLED_UPDATE()
	self.colorItemSlotsCheckbox:UpdateChecked()
end

function ColorOptions:ITEM_SLOT_COLOR_UPDATE(msg, type, r, g, b)
	self:GetItemSlotColorSelector(type):SetColor(r, g, b, a)
end


--[[ Check Boxes ]]--

function ColorOptions:CreateHighlightItemsByQualityCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.HighlightItemsByQuality, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetHighlightItemsByQuality(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:HighlightItemsByQuality()
	end

	self.highlightItemsByQualityCheckbox = button
	return button
end

function ColorOptions:CreateHighlightUnusableItemsCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.HighlightUnusableItems, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetHighlightUnusableItems(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:HighlightUnusableItems()
	end

	self.highlightUnusableItemsCheckbox = button
	return button
end

function ColorOptions:CreateHighlightSetItemsCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.HighlightSetItems, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetHighlightSetItems(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:HighlightSetItems()
	end

	self.highlightSetItemsCheckbox = button
	return button
end

function ColorOptions:CreateHighlightQuestItemsCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.HighlightQuestItems, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetHighlightQuestItems(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:HighlightQuestItems()
	end

	self.highlightQuestItemsCheckbox = button
	return button
end

--color item slots
function ColorOptions:CreateColorItemSlotsCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.ColorItemSlotsByBagType, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetColorBagSlots(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:ColoringBagSlots()
	end

	self.colorItemSlotsCheckbox = button
	return button
end


--[[ Sliders ]]--

function ColorOptions:CreateHighlightOpacitySlider()
	local slider = Bagnon.OptionsSlider:New(L.ItemHighlightOpacity, self, 10, 100, 1)

	slider.SetSavedValue = function(self, value)
		Bagnon.Settings:SetHighlightOpacity(value / 100)
	end

	slider.GetSavedValue = function(self)
		return Bagnon.Settings:GetHighlightOpacity() * 100
	end

	slider.GetFormattedText = function(self, value)
		return value .. '%'
	end

	self.highlightOpacitySlider = slider
	return slider
end

--[[ Color Pickers ]]--

--frame color
function ColorOptions:CreateItemSlotColorSelector(type)
	local selector = Bagnon.OptionsColorSelector:New(L['ItemSlotColor_' .. type], self, false)
	selector.itemSlotType = type

	selector.OnSetColor = function(self, r, g, b)
		Bagnon.Settings:SetItemSlotColor(self.itemSlotType, r, g, b)
	end

	selector.GetColor = function(self)
		return Bagnon.Settings:GetItemSlotColor(self.itemSlotType)
	end

	local colorSelectors = self.colorSelectors or {}
	colorSelectors[type] = selector
	self.colorSelectors = colorSelectors

	return selector
end

function ColorOptions:GetItemSlotColorSelector(type)
	return self.colorSelectors and self.colorSelectors[type]
end


--[[ Load the thing ]]--

ColorOptions:Startup()