--[[
	General.lua
		General Bagnon settings
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local L = LibStub('AceLocale-3.0'):GetLocale('Bagnon-Config')

--a hack panel, this is designed to force open to the general options panel when clicked
local BagnonOptions = Bagnon.OptionsPanel:New('Bagnon', nil, 'Bagnon')
BagnonOptions:SetScript('OnShow', function(self)
	InterfaceOptionsFrame_OpenToCategory(Bagnon.GeneralOptions)
	self:Hide()
end)

local GeneralOptions = Bagnon.OptionsPanel:New('BagnonOptions_General', 'Bagnon', L.GeneralSettings, L.GeneralSettingsTitle)
Bagnon.GeneralOptions = GeneralOptions

local SPACING = 6


--[[
	Startup
--]]

function GeneralOptions:Load()
	self:AddWidgets()
	self:UpdateMessages()
end

--[[
	Frame Events
--]]

function GeneralOptions:OnShow()
	self:UpdateMessages()
end

function GeneralOptions:OnHide()
	self:UpdateMessages()
end


--[[
	Messages
--]]

function GeneralOptions:UpdateMessages()
	if not self:IsVisible() then
		self:UnregisterAllMessages()
		return
	end

	self:RegisterMessage('SHOW_EMPTY_ITEM_SLOT_TEXTURE_UPDATE')
	self:RegisterMessage('LOCK_FRAME_POSITIONS_UPDATE')
	self:RegisterMessage('ENABLE_FRAME_UPDATE')
	self:RegisterMessage('BLIZZARD_BAG_PASSTHROUGH_UPDATE')
end

function GeneralOptions:SHOW_EMPTY_ITEM_SLOT_TEXTURE_UPDATE(msg, enable)
	self:GetEmptyItemSlotTextureCheckbox():UpdateChecked()
end

function GeneralOptions:LOCK_FRAME_POSITIONS_UPDATE(msg, enable)
	self:GetLockFramePositionsCheckbox():UpdateChecked()
end

function GeneralOptions:ENABLE_FRAME_UPDATE(msg, frameID, enable)
	self:GetEnableFrameCheckbox(frameID):UpdateChecked()
end

function GeneralOptions:BLIZZARD_BAG_PASSTHROUGH_UPDATE(msg, enable)
	self:GetBlizzardBagPassThroughCheckbox():UpdateChecked()
end



--[[
	Widgets
--]]

function GeneralOptions:AddWidgets()
	local enableInventory = self:CreateEnableFrameCheckbox('inventory')
	enableInventory:SetPoint('TOPLEFT', self, 'TOPLEFT', 14, -72)
	
	local enableBank = self:CreateEnableFrameCheckbox('bank')
	enableBank:SetPoint('TOPLEFT', enableInventory, 'BOTTOMLEFT', 0, -SPACING)
	
	local lockFramePositions = self:CreateLockFramePositionsCheckbox()
	lockFramePositions:SetPoint('TOPLEFT', enableBank, 'BOTTOMLEFT', 0, -SPACING)
	
	local showEmptyItemSlotTextures = self:CreateEmptyItemSlotTextureCheckbox()
	showEmptyItemSlotTextures:SetPoint('TOPLEFT', lockFramePositions, 'BOTTOMLEFT', 0, -SPACING)
	
	local allowDisableBags = self:CreateDisableBagsCheckbox()
	allowDisableBags:SetPoint('TOPLEFT', showEmptyItemSlotTextures, 'BOTTOMLEFT', 0, -SPACING)
	
	local enableBlizzardBagPassThrough = self:CreateBlizzardBagPassThroughCheckbox()
	enableBlizzardBagPassThrough:SetPoint('TOPLEFT', allowDisableBags, 'BOTTOMLEFT', 0, -SPACING)
	
	local enableFlashFind = self:CreateFlashFindCheckbox()
	enableFlashFind:SetPoint('TOPLEFT', enableBlizzardBagPassThrough, 'BOTTOMLEFT', 0, -SPACING)
	
	local enableFading = self:CreateFadingCheckbox()
	enableFading:SetPoint('TOPLEFT', enableFlashFind, 'BOTTOMLEFT', 0, -SPACING)

  local enableTipItemCount = self:CreateTipCountCheckbox()
  enableTipItemCount:SetPoint('TOPLEFT', enableFading, 'BOTTOMLEFT', 0, -SPACING)
end

function GeneralOptions:UpdateWidgets()
	if not self:IsVisible() then
		return
	end

	self:GetEnableFrameCheckbox('inventory'):UpdateChecked()
	self:GetEnableFrameCheckbox('bank'):UpdateChecked()

	self:GetEmptyItemSlotTextureCheckbox():UpdateChecked()
	self:GetHighlightItemsByQualityCheckbox():UpdateChecked()
	self:GetHighlightQuestItemsCheckbox():UpdateChecked()
	self:GetColorItemSlotsCheckbox():UpdateChecked()
	self:GetDisableBagsCheckbox():UpdateChecked()
	self:GetBlizzardBagPassThroughCheckbox():UpdateChecked()
	self:GetFlashFindCheckbox():UpdateChecked()
	self:GetFadingCheckbox():UpdateChecked()
	self:GetTipCountCheckbox():UpdateChecked()
end


--[[ Checkboxes ]]--

function GeneralOptions:CreateEnableFrameCheckbox(frameID)
	local button = Bagnon.OptionsCheckButton:New(L['EnableFrame_' .. frameID], self)
	button.frameID = frameID

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetEnableFrame(self.frameID, enable)
		GeneralOptions:DisplayRequiresRestartPopup()
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:WillFrameBeEnabled(self.frameID)
	end

	self['enableFrame_' .. frameID .. '_Checkbox'] = button
	return button
end

function GeneralOptions:GetEnableFrameCheckbox(frameID)
	return self['enableFrame_' .. frameID .. '_Checkbox']
end

function GeneralOptions:DisplayRequiresRestartPopup()
	self:CreateRequiresRestartDialog()
	StaticPopup_Show('BAGNON_CONFIRM_REQUIRES_RESTART')
end

function GeneralOptions:CreateRequiresRestartDialog()
	if not StaticPopupDialogs['BAGNON_CONFIRM_REQUIRES_RESTART'] then
		StaticPopupDialogs['BAGNON_CONFIRM_REQUIRES_RESTART'] = {
			text = L.SettingRequiresRestart,
			button1 = OKAY,
			timeout = 0, exclusive = 1, hideOnEscape = 1,
			preferredIndex = STATICPOPUP_NUMDIALOGS
		}
	end
end

--show empty item slot textures
function GeneralOptions:CreateEmptyItemSlotTextureCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.ShowEmptyItemSlotBackground, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetShowEmptyItemSlotTexture(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:ShowingEmptyItemSlotTextures()
	end

	self.showEmptyItemsTextureCheckbox = button
	return button
end

function GeneralOptions:GetEmptyItemSlotTextureCheckbox()
	return self.showEmptyItemsTextureCheckbox
end


--lock frame positions
function GeneralOptions:CreateLockFramePositionsCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.LockFramePositions, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetLockFramePositions(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:AreFramePositionsLocked()
	end

	self.lockFramePositionsCheckbox = button
	return button
end

function GeneralOptions:GetLockFramePositionsCheckbox()
	return self.lockFramePositionsCheckbox
end

-- bag disabling
function GeneralOptions:CreateDisableBagsCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.AllowDisableBags, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:AllowDisableBags(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:CanDisableBags()
	end

	self.disableBagsCheckbox = button
	return button
end

function GeneralOptions:GetDisableBagsCheckbox()
	return self.disableBagsCheckbox
end


--blizzard bag passthrough
function GeneralOptions:CreateBlizzardBagPassThroughCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableBlizzardBagPassThrough, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetEnableBlizzardBagPassThrough(enable)
		GeneralOptions:DisplayRequiresRestartPopup()
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:WillBlizzardBagPassThroughBeEnabled()
	end

	self.blizzardBagPassThroughCheckbox = button
	return button
end

function GeneralOptions:GetBlizzardBagPassThroughCheckbox()
	return self.blizzardBagPassThroughCheckbox
end 

--flash find
function GeneralOptions:CreateFlashFindCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableFlashFind, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetEnableFlashFind(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:IsFlashFindEnabled()
	end

	self.flashFindCheckbox = button
	return button
end

function GeneralOptions:GetFlashFindCheckbox()
	return self.flashFindCheckbox
end

--fading
function GeneralOptions:CreateFadingCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableFading, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetFading(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:IsFadingEnabled()
	end

	self.fadingCheckbox = button
	return button
end

function GeneralOptions:GetFadingCheckbox()
	return self.fadingCheckbox
end

--tip count
function GeneralOptions:CreateTipCountCheckbox()
	local button = Bagnon.OptionsCheckButton:New(L.EnableTipCount, self)

	button.OnEnableSetting = function(self, enable)
		Bagnon.Settings:SetEnableTipCount(enable)
	end

	button.IsSettingEnabled = function(self)
		return Bagnon.Settings:IsTipCountEnabled()
	end

	self.tipCountCheckbox = button
	return button
end

function GeneralOptions:GetTipCountCheckbox()
	return self.tipCountCheckbox
end


--[[ Load the thing ]]--

GeneralOptions:Load()