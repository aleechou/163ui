--[[
	SavedFrameSettings.lua
		behold the monkeypatching
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local SavedFrameSettings = Bagnon.SavedFrameSettings

function SavedFrameSettings:GetDefaultGuildBankSettings()
	if not self.guildDefaults then
		local bags = {}
		for i = 1, MAX_GUILDBANK_TABS do
			tinsert(bags, i)
		end

	 	self.guildDefaults = {
			availableBags = bags,

			--frame
			frameColor = {0, 0, 0, 0.5},
			frameBorderColor = {0, 1, 0, 1},
			scale = 1,
			opacity = 1,
			point = 'CENTER',
			x = 0,
			y = 0,
			frameLayer = 'HIGH',

			--itemFrame
			itemFrameColumns = 14,
			itemFrameSpacing = 2,

			--optional components
			hasMoneyFrame = true,
			hasBagFrame = true,
			hasDBOFrame = true,
			hasSearchToggle = true,
			hasOptionsToggle = true,
			dataBrokerObject = 'BagnonLauncher',
		}
	end
	
	return self.guildDefaults
end