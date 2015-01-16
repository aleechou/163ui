local addonname = ...
local _G = _G

_G.AtlasLoot = {
	__addonrevision = tonumber("4322") or 0
}

local AddonNameVersion = string.format("%s-%d", addonname, _G.AtlasLoot.__addonrevision)
local MainMT = {
	__tostring = function(self)
		return AddonNameVersion
	end,
}
setmetatable(_G.AtlasLoot, MainMT)

-- DB
AtlasLootDB = {}
AtlasLootCharDB = {}

-- Translations
_G.AtlasLoot.Locale = {}

-- Init functions
_G.AtlasLoot.Init = {}

-- Data table
_G.AtlasLoot.Data = {} 

-- Image path
_G.AtlasLoot.IMAGE_PATH = "Interface\\AddOns\\"..addonname.."\\Images\\"

