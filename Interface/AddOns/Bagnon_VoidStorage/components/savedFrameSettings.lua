--[[
	SavedFrameSettings.lua
		behold the second monkeypatching
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local SavedFrameSettings = Bagnon.SavedFrameSettings

function SavedFrameSettings:GetDefaultVaultSettings()
	local defaults = SavedFrameSettings.vaultDefaults or {
		--frame
		frameColor = {0.1254901960784314, 0.1254901960784314, 0.1254901960784314, 1},
		frameBorderColor = {1, 0, 0.98, 1},
		scale = 1,
		opacity = 1,
		point = 'LEFT',
		x = 40,
		y = 0,
		frameLayer = 'HIGH',

		--itemFrame
		itemFrameColumns = 10,
		itemFrameSpacing = 2,

		--optional components
		hasMoneyFrame = true,
		hasDBOFrame = true,
		hasSearchToggle = true,
		hasOptionsToggle = true,

		--dbo display object
		dataBrokerObject = 'BagnonLauncher',
	}

	SavedFrameSettings.vaultDefaults = defaults
	return defaults
end