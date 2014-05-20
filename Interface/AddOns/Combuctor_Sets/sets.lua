--[[
	Sets.lua
		Basic set types for combuctor

		setRule(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
--]]

local CombuctorSet = Combuctor:GetModule('Sets')
local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')


--the all category (player, bagType filters)
CombuctorSet:RegisterSubSet(L.All, L.All)
CombuctorSet:RegisterSubSet(L.Normal, L.All, nil, function(player, bagType)
	return bagType and bagType == 0
end)
-- CombuctorSet:RegisterSubSet(L.Trade, L.All, nil, function(player, bagType)
	-- return bagType and bit.band(bagType, Combuctor.TRADE_TYPE) > 0
-- end)


--equipment filters (armor, weapon, trinket)
local function isEquipment(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return (type == L.Armor or type == L.Weapon)
end
CombuctorSet:Register(L.Equipment, 'Interface/Icons/INV_Chest_Chain_04', isEquipment)
CombuctorSet:RegisterSubSet(L.All, L.Equipment)

local function isArmor(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Armor and equipLoc ~= 'INVTYPE_TRINKET'
end
CombuctorSet:RegisterSubSet(L.Armor, L.Equipment, nil, isArmor)

local function isWeapon(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Weapon
end
CombuctorSet:RegisterSubSet(L.Weapon, L.Equipment, nil, isWeapon)

local function isTrinket(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return equipLoc == 'INVTYPE_TRINKET'
end
CombuctorSet:RegisterSubSet(L.Trinket, L.Equipment, nil, isTrinket)


--usable items
local function isUsable(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	if type == L.Consumable then
		return true
	elseif type == L.TradeGood then
		if subType == L.Devices or subType == L.Explosives then
			return true
		end
	end
end
CombuctorSet:Register(L.Usable, 'Interface/Icons/INV_Potion_93', isUsable)
CombuctorSet:RegisterSubSet(L.All, L.Usable)

local function isConsumable(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Consumable
end
CombuctorSet:RegisterSubSet(L.Consumable, L.Usable, nil, isConsumable)

local function isDevice(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.TradeGood
end
CombuctorSet:RegisterSubSet(L.Devices, L.Usable, nil, isDevice)


--quest items
local function isQuestItem(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Quest
end
CombuctorSet:Register(L.Quest, 'Interface/QuestFrame/UI-QuestLog-BookIcon', isQuestItem)
CombuctorSet:RegisterSubSet(L.All, L.Quest)


--trade goods + gems
local function isTradeGood(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	if type == L.TradeGood then
		return not(subType == L.Devices or subType == L.Explosives)
	end
	return type == L.Recipe or type == L.Gem
end
CombuctorSet:Register(L.TradeGood, 'Interface/Icons/INV_Fabric_Silk_02', isTradeGood)
CombuctorSet:RegisterSubSet(L.All, L.TradeGood)

local function isTradeGood(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.TradeGood
end
CombuctorSet:RegisterSubSet(L.TradeGood, L.TradeGood, nil, isTradeGood)

local function isGem(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Gem
end
CombuctorSet:RegisterSubSet(L.Gem, L.TradeGood, nil, isGem)

local function isRecipe(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Recipe
end
CombuctorSet:RegisterSubSet(L.Recipe, L.TradeGood, nil, isRecipe)

--misc
local function isMiscItem(player, bagType, name, link, quality, level, ilvl, type, subType, stackCount, equipLoc)
	return type == L.Misc and (link:match('%d+') ~= '6265')
end
CombuctorSet:Register(L.Misc, 'Interface/Icons/INV_Misc_Rune_01', isMiscItem)
CombuctorSet:RegisterSubSet(L.All, L.Misc)