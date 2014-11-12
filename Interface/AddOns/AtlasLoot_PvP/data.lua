local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

-- change sortorder for factions
local ALLIANCE_DIFF, HORDE_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PVP_CONTENT = data:AddContentType(AL["PvP"], ATLASLOOT_PVP_COLOR)

data["WODS1SETS"] = {
	name = string.format(AL["Warlords Season %d"], 1).." "..AL["Class Sets"],
	ContentType = NORMAL_ITTYPE,
	items = {
		{
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			[ALLIANCE_DIFF] = {
				{ 1, 115631, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Helm
				{ 2, 115633, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Shoulders
				{ 3, 115629, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Chestpiece
				{ 4, 115630, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Gauntlets
				{ 5, 115632, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Legguards
				{ 7, 115839, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Helm (r2000)
				{ 8, 115841, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Shoulders (r2000)
				{ 9, 115837, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Chestpiece (r2000)
				{ 10, 115838, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Gauntlets (r2000)
				{ 11, 115906, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Girdle (r2000)
				{ 12, 115840, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Legguards (r2000)
				{ 13, 115909, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Warboots (r2000)
				{ 16, 115051, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dreadplate Helm
				{ 17, 115053, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Dreadplate Shoulders
				{ 18, 115049, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dreadplate Chestpiece
				{ 19, 115050, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Dreadplate Gauntlets
				{ 20, 115052, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dreadplate Legguards
				{ 22, 115199 },	-- Primal Aspirant's Dreadplate Helm
				{ 23, 115201 },	-- Primal Aspirant's Dreadplate Shoulders
				{ 24, 115197 },	-- Primal Aspirant's Dreadplate Chestpiece
				{ 25, 115198 },	-- Primal Aspirant's Dreadplate Gauntlets
				{ 26, 115200 },	-- Primal Aspirant's Dreadplate Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111104, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Helm
				{ 2, 111106, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Shoulders
				{ 3, 111102, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Chestpiece
				{ 4, 111103, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Gauntlets
				{ 5, 111105, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Legguards
				{ 16, 119841, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dreadplate Helm
				{ 17, 119843, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Dreadplate Shoulders
				{ 18, 119839, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dreadplate Chestpiece
				{ 19, 119840, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Dreadplate Gauntlets
				{ 20, 119842, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dreadplate Legguards
				{ 22, 119976 },	-- Primal Aspirant's Dreadplate Helm
				{ 23, 119978 },	-- Primal Aspirant's Dreadplate Shoulders
				{ 24, 119974 },	-- Primal Aspirant's Dreadplate Chestpiece
				{ 25, 119975 },	-- Primal Aspirant's Dreadplate Gauntlets
				{ 26, 119977 },	-- Primal Aspirant's Dreadplate Legguards
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			[ALLIANCE_DIFF] = {
				{ 1, 115635, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Helm
				{ 2, 115638, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Spaulders
				{ 3, 115637, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Robes
				{ 4, 115634, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Gloves
				{ 5, 115636, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Legguards
				{ 7, 115843, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Helm (r2000)
				{ 8, 115846, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Spaulders (r2000)
				{ 9, 115845, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Robes (r2000)
				{ 10, 115842, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Gloves (r2000)
				{ 11, 115971, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Belt (r2000)
				{ 12, 115844, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Legguards (r2000)
				{ 13, 115970, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Footguards (r2000)
				{ 16, 115055, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dragonhide Helm
				{ 17, 115058, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Dragonhide Spaulders
				{ 18, 115057, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dragonhide Robes
				{ 19, 115054, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Dragonhide Gloves
				{ 20, 115056, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dragonhide Legguards
				{ 22, 115203 },	-- Primal Aspirant's Dragonhide Helm
				{ 23, 115206 },	-- Primal Aspirant's Dragonhide Spaulders
				{ 24, 115205 },	-- Primal Aspirant's Dragonhide Robes
				{ 25, 115202 },	-- Primal Aspirant's Dragonhide Gloves
				{ 26, 115204 },	-- Primal Aspirant's Dragonhide Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111108, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Helm
				{ 2, 111111, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Spaulders
				{ 3, 111110, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Robes
				{ 4, 111107, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Gloves
				{ 5, 111109, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Legguards
				{ 16, 119845, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dragonhide Helm
				{ 17, 119848, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Dragonhide Spaulders
				{ 18, 119847, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dragonhide Robes
				{ 19, 119844, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Dragonhide Gloves
				{ 20, 119846, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Dragonhide Legguards
				{ 22, 119980 },	-- Primal Aspirant's Dragonhide Helm
				{ 23, 119983 },	-- Primal Aspirant's Dragonhide Spaulders
				{ 24, 119982 },	-- Primal Aspirant's Dragonhide Robes
				{ 25, 119979 },	-- Primal Aspirant's Dragonhide Gloves
				{ 26, 119981 },	-- Primal Aspirant's Dragonhide Legguards
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			[ALLIANCE_DIFF] = {
				{ 1, 115641, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Helm
				{ 2, 115643, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Spaulders
				{ 3, 115639, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Armor
				{ 4, 115640, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Gauntlets
				{ 5, 115642, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Leggings
				{ 7, 115872, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Helm (r2000)
				{ 8, 115874, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Spaulders (r2000)
				{ 9, 115870, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Armor (r2000)
				{ 10, 115871, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Gauntlets (r2000)
				{ 11, 115866, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Links (r2000)
				{ 12, 115873, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Leggings (r2000)
				{ 13, 115868, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Sabatons (r2000)
				{ 16, 115061, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Chain Helm
				{ 17, 115063, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Chain Spaulders
				{ 18, 115059, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Chain Armor
				{ 19, 115060, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Chain Gauntlets
				{ 20, 115062, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Chain Leggings
				{ 22, 115209 },	-- Primal Aspirant's Chain Helm
				{ 23, 115211 },	-- Primal Aspirant's Chain Spaulders
				{ 24, 115207 },	-- Primal Aspirant's Chain Armor
				{ 25, 115208 },	-- Primal Aspirant's Chain Gauntlets
				{ 26, 115210 },	-- Primal Aspirant's Chain Leggings
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111114, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Helm
				{ 2, 111116, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Spaulders
				{ 3, 111112, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Armor
				{ 4, 111113, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Gauntlets
				{ 5, 111115, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Leggings
				{ 16, 119851, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Chain Helm
				{ 17, 119853, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Chain Spaulders
				{ 18, 119849, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Chain Armor
				{ 19, 119850, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Chain Gauntlets
				{ 20, 119852, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Chain Leggings
				{ 22, 119986 },	-- Primal Aspirant's Chain Helm
				{ 23, 119988 },	-- Primal Aspirant's Chain Spaulders
				{ 24, 119984 },	-- Primal Aspirant's Chain Armor
				{ 25, 119985 },	-- Primal Aspirant's Chain Gauntlets
				{ 26, 119987 },	-- Primal Aspirant's Chain Leggings
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			[ALLIANCE_DIFF] = {
				{ 1, 115678, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Cowl
				{ 2, 115681, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Amice
				{ 3, 115680, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Robe
				{ 4, 115677, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Handguards
				{ 5, 115679, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Trousers
				{ 7, 115876, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Cowl (r2000)
				{ 8, 115879, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Amice (r2000)
				{ 9, 115878, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Robe (r2000)
				{ 10, 115875, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Handguards (r2000)
				{ 11, 115824, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Cord (r2000)
				{ 12, 115877, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Trousers (r2000)
				{ 13, 115827, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Treads (r2000)
				{ 16, 115091, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Silk Cowl
				{ 17, 115094, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Silk Amice
				{ 18, 115093, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Silk Robe
				{ 19, 115090, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Silk Handguards
				{ 20, 115092, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Silk Trousers
				{ 22, 115221 },	-- Primal Aspirant's Silk Cowl
				{ 23, 115224 },	-- Primal Aspirant's Silk Amice
				{ 24, 115223 },	-- Primal Aspirant's Silk Robe
				{ 25, 115220 },	-- Primal Aspirant's Silk Handguards
				{ 26, 115222 },	-- Primal Aspirant's Silk Trousers
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111151, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Cowl
				{ 2, 111154, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Amice
				{ 3, 111153, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Robe
				{ 4, 111150, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Handguards
				{ 5, 111152, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Trousers
				{ 16, 119874, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Silk Cowl
				{ 17, 119877, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Silk Amice
				{ 18, 119876, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Silk Robe
				{ 19, 119873, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Silk Handguards
				{ 20, 119875, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Silk Trousers
				{ 22, 119998 },	-- Primal Aspirant's Silk Cowl
				{ 23, 120001 },	-- Primal Aspirant's Silk Amice
				{ 24, 120000 },	-- Primal Aspirant's Silk Robe
				{ 25, 119997 },	-- Primal Aspirant's Silk Handguards
				{ 26, 119999 },	-- Primal Aspirant's Silk Trousers
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"],
			[ALLIANCE_DIFF] = {
				{ 1, 115692, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Helm
				{ 2, 115694, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Spaulders
				{ 3, 115695, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Tunic
				{ 4, 115691, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Gloves
				{ 5, 115693, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Legguards
				{ 7, 115883, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Helm (r2000)
				{ 8, 115885, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Spaulders (r2000)
				{ 9, 115886, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Tunic (r2000)
				{ 10, 115882, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Gloves (r2000)
				{ 11, 115880, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Waistband (r2000)
				{ 12, 115884, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Legguards (r2000)
				{ 13, 115881, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Boots (r2000)
				{ 16, 115102, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ironskin Helm
				{ 17, 115104, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ironskin Spaulders
				{ 18, 115105, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ironskin Tunic
				{ 19, 115101, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ironskin Gloves
				{ 20, 115103, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ironskin Legguards
				{ 22, 115229 },	-- Primal Aspirant's Ironskin Helm
				{ 23, 115231 },	-- Primal Aspirant's Ironskin Spaulders
				{ 24, 115232 },	-- Primal Aspirant's Ironskin Tunic
				{ 25, 115228 },	-- Primal Aspirant's Ironskin Gloves
				{ 26, 115230 },	-- Primal Aspirant's Ironskin Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111165, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Helm
				{ 2, 111167, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Spaulders
				{ 3, 111168, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Tunic
				{ 4, 111164, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Gloves
				{ 5, 111166, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Legguards
				{ 16, 119885, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ironskin Helm
				{ 17, 119887, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ironskin Spaulders
				{ 18, 119888, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ironskin Tunic
				{ 19, 119884, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ironskin Gloves
				{ 20, 119886, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ironskin Legguards
				{ 22, 120006 },	-- Primal Aspirant's Ironskin Helm
				{ 23, 120008 },	-- Primal Aspirant's Ironskin Spaulders
				{ 24, 120009 },	-- Primal Aspirant's Ironskin Tunic
				{ 25, 120005 },	-- Primal Aspirant's Ironskin Gloves
				{ 26, 120007 },	-- Primal Aspirant's Ironskin Legguards
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			[ALLIANCE_DIFF] = {
				{ 1, 115698, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Helm
				{ 2, 115700, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Shoulders
				{ 3, 115696, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Chestpiece
				{ 4, 115697, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Gauntlets
				{ 5, 115699, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Legguards
				{ 7, 115894, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Helm (r2000)
				{ 8, 115896, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Shoulders (r2000)
				{ 9, 115892, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Chestpiece (r2000)
				{ 10, 115893, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Gauntlets (r2000)
				{ 11, 115897, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Clasp (r2000)
				{ 12, 115895, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Legguards (r2000)
				{ 13, 115900, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Greaves (r2000)
				{ 16, 115108, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Scaled Helm
				{ 17, 115110, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Scaled Shoulders
				{ 18, 115106, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Scaled Chestpiece
				{ 19, 115107, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Scaled Gauntlets
				{ 20, 115109, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Scaled Legguards
				{ 22, 115235 },	-- Primal Aspirant's Scaled Helm
				{ 23, 115237 },	-- Primal Aspirant's Scaled Shoulders
				{ 24, 115233 },	-- Primal Aspirant's Scaled Chestpiece
				{ 25, 115234 },	-- Primal Aspirant's Scaled Gauntlets
				{ 26, 115236 },	-- Primal Aspirant's Scaled Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111171, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Helm
				{ 2, 111173, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Shoulders
				{ 3, 111169, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Chestpiece
				{ 4, 111170, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Gauntlets
				{ 5, 111172, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Legguards
				{ 16, 119891, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Scaled Helm
				{ 17, 119893, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Scaled Shoulders
				{ 18, 119889, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Scaled Chestpiece
				{ 19, 119890, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Scaled Gauntlets
				{ 20, 119892, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Scaled Legguards
				{ 22, 120012 },	-- Primal Aspirant's Scaled Helm
				{ 23, 120014 },	-- Primal Aspirant's Scaled Shoulders
				{ 24, 120010 },	-- Primal Aspirant's Scaled Chestpiece
				{ 25, 120011 },	-- Primal Aspirant's Scaled Gauntlets
				{ 26, 120013 },	-- Primal Aspirant's Scaled Legguards
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			[ALLIANCE_DIFF] = {
				{ 1, 115711, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Hood
				{ 2, 115714, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Mantle
				{ 3, 115713, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Robe
				{ 4, 115710, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Gloves
				{ 5, 115712, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Leggings
				{ 7, 115917, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Hood (r2000)
				{ 8, 115920, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Mantle (r2000)
				{ 9, 115919, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Robe (r2000)
				{ 10, 115916, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Gloves (r2000)
				{ 11, 115969, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Cord (r2000)
				{ 12, 115918, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Leggings (r2000)
				{ 13, 115968, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Treads (r2000)
				{ 16, 115118, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Satin Hood
				{ 17, 115121, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Satin Mantle
				{ 18, 115120, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Satin Robe
				{ 19, 115117, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Satin Gloves
				{ 20, 115119, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Satin Leggings
				{ 22, 115242 },	-- Primal Aspirant's Satin Hood
				{ 23, 115245 },	-- Primal Aspirant's Satin Mantle
				{ 24, 115244 },	-- Primal Aspirant's Satin Robe
				{ 25, 115241 },	-- Primal Aspirant's Satin Gloves
				{ 26, 115243 },	-- Primal Aspirant's Satin Leggings
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111184, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Hood
				{ 2, 111187, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Mantle
				{ 3, 111186, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Robe
				{ 4, 111183, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Gloves
				{ 5, 111185, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Leggings
				{ 16, 119901, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Satin Hood
				{ 17, 119904, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Satin Mantle
				{ 18, 119903, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Satin Robe
				{ 19, 119900, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Satin Gloves
				{ 20, 119902, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Satin Leggings
				{ 22, 120019 },	-- Primal Aspirant's Satin Hood
				{ 23, 120022 },	-- Primal Aspirant's Satin Mantle
				{ 24, 120021 },	-- Primal Aspirant's Satin Robe
				{ 25, 120018 },	-- Primal Aspirant's Satin Gloves
				{ 26, 120020 },	-- Primal Aspirant's Satin Leggings
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			[ALLIANCE_DIFF] = {
				{ 1, 115717, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Helm
				{ 2, 115719, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Spaulders
				{ 3, 115715, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Tunic
				{ 4, 115716, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Gloves
				{ 5, 115718, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Legguards
				{ 7, 115925, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Helm (r2000)
				{ 8, 115927, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Spaulders (r2000)
				{ 9, 115923, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Tunic (r2000)
				{ 10, 115924, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Gloves (r2000)
				{ 11, 115921, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Waistband (r2000)
				{ 12, 115926, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Legguards (r2000)
				{ 13, 115922, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Boots (r2000)
				{ 16, 115124, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leather Helm
				{ 17, 115126, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Leather Spaulders
				{ 18, 115122, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leather Tunic
				{ 19, 115123, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Leather Gloves
				{ 20, 115125, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leather Legguards
				{ 22, 115248 },	-- Primal Aspirant's Leather Helm
				{ 23, 115250 },	-- Primal Aspirant's Leather Spaulders
				{ 24, 115246 },	-- Primal Aspirant's Leather Tunic
				{ 25, 115247 },	-- Primal Aspirant's Leather Gloves
				{ 26, 115249 },	-- Primal Aspirant's Leather Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111190, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Helm
				{ 2, 111192, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Spaulders
				{ 3, 111188, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Tunic
				{ 4, 111189, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Gloves
				{ 5, 111191, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Legguards
				{ 16, 119907, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leather Helm
				{ 17, 119909, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Leather Spaulders
				{ 18, 119905, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leather Tunic
				{ 19, 119906, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Leather Gloves
				{ 20, 119908, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leather Legguards
				{ 22, 120025 },	-- Primal Aspirant's Leather Helm
				{ 23, 120027 },	-- Primal Aspirant's Leather Spaulders
				{ 24, 120023 },	-- Primal Aspirant's Leather Tunic
				{ 25, 120024 },	-- Primal Aspirant's Leather Gloves
				{ 26, 120026 },	-- Primal Aspirant's Leather Legguards
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			[ALLIANCE_DIFF] = {
				{ 1, 115722, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Helm
				{ 2, 115724, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Spaulders
				{ 3, 115720, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Armor
				{ 4, 115721, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Gauntlets
				{ 5, 115723, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Leggings
				{ 7, 115933, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Helm (r2000)
				{ 8, 115935, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Spaulders (r2000)
				{ 9, 115931, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Armor (r2000)
				{ 10, 115932, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Gauntlets (r2000)
				{ 11, 115928, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Waistguard (r2000)
				{ 12, 115934, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Leggings (r2000)
				{ 13, 115929, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Footguards (r2000)
				{ 16, 115129, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ringmail Helm
				{ 17, 115131, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ringmail Spaulders
				{ 18, 115127, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ringmail Armor
				{ 19, 115128, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ringmail Gauntlets
				{ 20, 115130, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ringmail Leggings
				{ 22, 115253 },	-- Primal Aspirant's Ringmail Helm
				{ 23, 115255 },	-- Primal Aspirant's Ringmail Spaulders
				{ 24, 115251 },	-- Primal Aspirant's Ringmail Armor
				{ 25, 115252 },	-- Primal Aspirant's Ringmail Gauntlets
				{ 26, 115254 },	-- Primal Aspirant's Ringmail Leggings
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111195, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Helm
				{ 2, 111197, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Spaulders
				{ 3, 111193, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Armor
				{ 4, 111194, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Gauntlets
				{ 5, 111196, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Leggings
				{ 16, 119912, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ringmail Helm
				{ 17, 119915, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ringmail Spaulders
				{ 18, 119910, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ringmail Armor
				{ 19, 119911, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ringmail Gauntlets
				{ 20, 119913, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Ringmail Leggings
				{ 22, 120030 },	-- Primal Aspirant's Ringmail Helm
				{ 23, 120032 },	-- Primal Aspirant's Ringmail Spaulders
				{ 24, 120028 },	-- Primal Aspirant's Ringmail Armor
				{ 25, 120029 },	-- Primal Aspirant's Ringmail Gauntlets
				{ 26, 120031 },	-- Primal Aspirant's Ringmail Leggings
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			[ALLIANCE_DIFF] = {
				{ 1, 115762, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Cowl
				{ 2, 115765, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Amice
				{ 3, 115764, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Raiment
				{ 4, 115761, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Handguards
				{ 5, 115763, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Trousers
				{ 7, 115957, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Cowl (r2000)
				{ 8, 115960, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Amice (r2000)
				{ 9, 115959, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Raiment (r2000)
				{ 10, 115956, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Handguards (r2000)
				{ 11, 115825, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Cord (r2000)
				{ 12, 115958, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Trousers (r2000)
				{ 13, 115828, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Treads (r2000)
				{ 16, 115162, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Felweave Cowl
				{ 17, 115165, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Felweave Amice
				{ 18, 115164, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Felweave Raiment
				{ 19, 115161, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Felweave Handguards
				{ 20, 115163, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Felweave Trousers
				{ 22, 115259 },	-- Primal Aspirant's Felweave Cowl
				{ 23, 115262 },	-- Primal Aspirant's Felweave Amice
				{ 24, 115261 },	-- Primal Aspirant's Felweave Raiment
				{ 25, 115258 },	-- Primal Aspirant's Felweave Handguards
				{ 26, 115260 },	-- Primal Aspirant's Felweave Trousers
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111235, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Cowl
				{ 2, 111238, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Amice
				{ 3, 111237, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Raiment
				{ 4, 111234, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Handguards
				{ 5, 111236, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Trousers
				{ 16, 119939, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Felweave Cowl
				{ 17, 119942, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Felweave Amice
				{ 18, 119941, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Felweave Raiment
				{ 19, 119938, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Felweave Handguards
				{ 20, 119940, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Felweave Trousers
				{ 22, 120036 },	-- Primal Aspirant's Felweave Cowl
				{ 23, 120039 },	-- Primal Aspirant's Felweave Amice
				{ 24, 120038 },	-- Primal Aspirant's Felweave Raiment
				{ 25, 120035 },	-- Primal Aspirant's Felweave Handguards
				{ 26, 120037 },	-- Primal Aspirant's Felweave Trousers
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			[ALLIANCE_DIFF] = {
				{ 1, 115768, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Helm
				{ 2, 115770, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Shoulders
				{ 3, 115766, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestpiece
				{ 4, 115767, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Gauntlets
				{ 5, 115769, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Legguards
				{ 7, 115963, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Helm (r2000)
				{ 8, 115965, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Shoulders (r2000)
				{ 9, 115961, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestpiece (r2000)
				{ 10, 115962, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Gauntlets (r2000)
				{ 11, 115907, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Girdle (r2000)
				{ 12, 115964, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Legguards (r2000)
				{ 13, 115908, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Warboots (r2000)
				{ 16, 115168, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Helm
				{ 17, 115170, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Plate Shoulders
				{ 18, 115166, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Chestpiece
				{ 19, 115167, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Plate Gauntlets
				{ 20, 115169, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Legguards
				{ 22, 115265 },	-- Primal Aspirant's Plate Helm
				{ 23, 115267 },	-- Primal Aspirant's Plate Shoulders
				{ 24, 115263 },	-- Primal Aspirant's Plate Chestpiece
				{ 25, 115264 },	-- Primal Aspirant's Plate Gauntlets
				{ 26, 115266 },	-- Primal Aspirant's Plate Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 111241, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Helm
				{ 2, 111243, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Shoulders
				{ 3, 111239, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestpiece
				{ 4, 111240, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Gauntlets
				{ 5, 111242, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Legguards
				{ 16, 119945, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Helm
				{ 17, 119947, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Plate Shoulders
				{ 18, 119943, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Chestpiece
				{ 19, 119944, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Plate Gauntlets
				{ 20, 119946, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Legguards
				{ 22, 120042 },	-- Primal Aspirant's Plate Helm
				{ 23, 120044 },	-- Primal Aspirant's Plate Shoulders
				{ 24, 120040 },	-- Primal Aspirant's Plate Chestpiece
				{ 25, 120041 },	-- Primal Aspirant's Plate Gauntlets
				{ 26, 120043 },	-- Primal Aspirant's Plate Legguards
			},
		},
	},
}

data["WODS1NONSETGEAR"] = {
	name = string.format(AL["Warlords Season %d"], 1).." "..AL["Non-Set Gear"],
	ContentType = NORMAL_ITTYPE,
	items = {
		{
			name = ALIL["Cloth"],
			[ALLIANCE_DIFF] = {
				{ 1, 115611, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Hood of Prowess
				{ 2, 115614, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Amice of Prowess
				{ 3, 115613, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Robes of Prowess
				{ 4, 115610, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gloves of Prowess
				{ 5, 115612, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings of Prowess
				{ 7, 115627, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cuffs of Cruelty
				{ 8, 115626, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cuffs of Prowess
				{ 10, 115620, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cord of Cruelty
				{ 11, 115621, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cord of Prowess
				{ 13, 115623, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Treads of Cruelty
				{ 14, 115624, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Treads of Prowess
				{ 16, 115616, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Cowl of Cruelty
				{ 17, 115619, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Mantle of Cruelty
				{ 18, 115618, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Raiment of Cruelty
				{ 19, 115628, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cuffs of Victory
				{ 20, 115615, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Handguards of Cruelty
				{ 21, 115622, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cord of Victory
				{ 22, 115617, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Trousers of Cruelty
				{ 23, 115625, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Treads of Victory
				{ 101, 115039, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Hood of Prowess
				{ 102, 115042, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Amice of Prowess
				{ 103, 115041, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Robes of Prowess
				{ 104, 115038, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Gloves of Prowess
				{ 105, 115040, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leggings of Prowess
				{ 107, 115048, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cuffs of Cruelty
				{ 108, 115047, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cuffs of Prowess
				{ 110, 115043, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Cord of Cruelty
				{ 111, 115044, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Cord of Prowess
				{ 113, 115045, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Treads of Cruelty
				{ 114, 115046, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Treads of Prowess
				{ 116, 115196 },	-- Primal Aspirant's Cuffs of Prowess
				{ 117, 115194 },	-- Primal Aspirant's Cord of Cruelty
				{ 118, 115195 },	-- Primal Aspirant's Treads of Cruelty
			},
			[HORDE_DIFF] = {
				{ 1, 111084, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Hood of Prowess
				{ 2, 111087, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Amice of Prowess
				{ 3, 111086, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Robes of Prowess
				{ 4, 111083, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gloves of Prowess
				{ 5, 111085, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings of Prowess
				{ 7, 111100, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cuffs of Cruelty
				{ 8, 111099, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cuffs of Prowess
				{ 10, 111093, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cord of Cruelty
				{ 11, 111094, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cord of Prowess
				{ 13, 111096, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Treads of Cruelty
				{ 14, 111097, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Treads of Prowess
				{ 16, 111089, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Cowl of Cruelty
				{ 17, 111092, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Mantle of Cruelty
				{ 18, 111091, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Raiment of Cruelty
				{ 19, 111101, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cuffs of Victory
				{ 20, 111088, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Handguards of Cruelty
				{ 21, 111095, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cord of Victory
				{ 22, 111090, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Trousers of Cruelty
				{ 23, 111098, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Treads of Victory
				{ 101, 119829, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Hood of Prowess
				{ 102, 119832, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Amice of Prowess
				{ 103, 119831, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Robes of Prowess
				{ 104, 119828, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Gloves of Prowess
				{ 105, 119830, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leggings of Prowess
				{ 107, 119838, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cuffs of Cruelty
				{ 108, 119837, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cuffs of Prowess
				{ 110, 119833, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Cord of Cruelty
				{ 111, 119834, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Cord of Prowess
				{ 113, 119835, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Treads of Cruelty
				{ 114, 119836, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Treads of Prowess
				{ 116, 119973 },	-- Primal Aspirant's Cuffs of Prowess
				{ 117, 119971 },	-- Primal Aspirant's Cord of Cruelty
				{ 118, 119972 },	-- Primal Aspirant's Treads of Cruelty
			},
		},
		{
			name = ALIL["Leather"],
			[ALLIANCE_DIFF] = {
				{ 1, 115775, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Helm
				{ 2, 115777, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Spaulders
				{ 3, 115773, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Tunic
				{ 4, 115774, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gloves
				{ 5, 115776, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Legguards
				{ 7, 115674, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Bindings of Cruelty
				{ 8, 115675, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Bindings of Prowess
				{ 10, 115669, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Belt of Cruelty
				{ 11, 115668, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Belt of Prowess
				{ 13, 115671, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Boots of Cruelty
				{ 14, 115672, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Boots of Prowess
				{ 16, 115785, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Headcover
				{ 17, 115787, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pauldrons
				{ 18, 115783, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chestguard
				{ 19, 115676, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Bindings of Victory
				{ 20, 115784, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Grips
				{ 21, 115670, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Belt of Victory
				{ 22, 115786, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 23, 115673, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Boots of Victory
				{ 101, 115175, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Helm
				{ 102, 115177, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Spaulders
				{ 103, 115173, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Tunic
				{ 104, 115174, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Gloves
				{ 105, 115176, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Legguards
				{ 107, 115088, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Bindings of Cruelty
				{ 108, 115089, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Bindings of Prowess
				{ 110, 115085, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Belt of Cruelty
				{ 111, 115084, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Belt of Prowess
				{ 113, 115086, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Boots of Cruelty
				{ 114, 115087, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Boots of Prowess
				{ 116, 115219 },	-- Primal Aspirant's Bindings of Cruelty
				{ 117, 115217 },	-- Primal Aspirant's Belt of Prowess
				{ 118, 115218 },	-- Primal Aspirant's Boots of Cruelty
			},
			[HORDE_DIFF] = {
				{ 1, 111275, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Helm
				{ 2, 111277, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Spaulders
				{ 3, 111273, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Tunic
				{ 4, 111274, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gloves
				{ 5, 111276, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Legguards
				{ 7, 111147, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Bindings of Cruelty
				{ 8, 111148, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Bindings of Prowess
				{ 10, 111142, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Belt of Cruelty
				{ 11, 111141, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Belt of Prowess
				{ 13, 111144, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Boots of Cruelty
				{ 14, 111145, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Boots of Prowess
				{ 16, 111285, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Headcover
				{ 17, 111287, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pauldrons
				{ 18, 111283, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chestguard
				{ 19, 111149, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Bindings of Victory
				{ 20, 111284, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Grips
				{ 21, 111143, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Belt of Victory
				{ 22, 111286, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 23, 111146, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Boots of Victory
				{ 101, 119952, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Helm
				{ 102, 119954, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Spaulders
				{ 103, 119950, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Tunic
				{ 104, 119951, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Gloves
				{ 105, 119953, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Legguards
				{ 107, 119871, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Bindings of Cruelty
				{ 108, 119872, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Bindings of Prowess
				{ 110, 119868, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Belt of Cruelty
				{ 111, 119867, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Belt of Prowess
				{ 113, 119869, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Boots of Cruelty
				{ 114, 119870, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Boots of Prowess
				{ 116, 119996 },	-- Primal Aspirant's Bindings of Cruelty
				{ 117, 119994 },	-- Primal Aspirant's Belt of Prowess
				{ 118, 119995 },	-- Primal Aspirant's Boots of Cruelty
			},
		},
		{
			name = ALIL["Mail"],
			[ALLIANCE_DIFF] = {
				{ 1, 115780, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Helm
				{ 2, 115782, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Spaulders
				{ 3, 115778, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Armor
				{ 4, 115779, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gauntlets
				{ 5, 115781, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 7, 115689, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armbands of Cruelty
				{ 8, 115688, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armbands of Prowess
				{ 10, 115682, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Waistguard of Cruelty
				{ 11, 115683, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Waistguard of Prowess
				{ 13, 115685, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Footguards of Cruelty
				{ 14, 115686, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Footguards of Prowess
				{ 16, 115790, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Coif
				{ 17, 115792, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pauldrons
				{ 18, 115788, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chestguard
				{ 19, 115690, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armbands of Victory
				{ 20, 115789, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gloves
				{ 21, 115684, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Waistguard of Victory
				{ 22, 115791, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 23, 115687, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Footguards of Victory
				{ 101, 115180, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Helm
				{ 102, 115182, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Spaulders
				{ 103, 115178, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Armor
				{ 104, 115179, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Gauntlets
				{ 105, 115181, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leggings
				{ 107, 115100, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Armbands of Cruelty
				{ 108, 115099, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Armbands of Prowess
				{ 110, 115095, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Waistguard of Cruelty
				{ 111, 115096, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Waistguard of Prowess
				{ 113, 115097, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Footguards of Cruelty
				{ 114, 115098, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Footguards of Prowess
				{ 116, 115227 },	-- Primal Aspirant's Armbands of Prowess
				{ 117, 115225 },	-- Primal Aspirant's Waistguard of Cruelty
				{ 118, 115226 },	-- Primal Aspirant's Footguards of Cruelty
			},
			[HORDE_DIFF] = {
				{ 1, 111280, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Helm
				{ 2, 111282, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Spaulders
				{ 3, 111278, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Armor
				{ 4, 111279, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gauntlets
				{ 5, 111281, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 7, 111162, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armbands of Cruelty
				{ 8, 111161, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armbands of Prowess
				{ 10, 111155, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Waistguard of Cruelty
				{ 11, 111156, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Waistguard of Prowess
				{ 13, 111158, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Footguards of Cruelty
				{ 14, 111159, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Footguards of Prowess
				{ 16, 111290, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Coif
				{ 17, 111292, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pauldrons
				{ 18, 111288, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chestguard
				{ 19, 111163, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armbands of Victory
				{ 20, 111289, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gloves
				{ 21, 111157, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Waistguard of Victory
				{ 22, 111291, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 23, 111160, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Footguards of Victory
				{ 101, 119957, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Helm
				{ 102, 119959, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Spaulders
				{ 103, 119955, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Armor
				{ 104, 119956, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Gauntlets
				{ 105, 119958, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Leggings
				{ 107, 119883, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Armbands of Cruelty
				{ 108, 119882, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Armbands of Prowess
				{ 110, 119878, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Waistguard of Cruelty
				{ 111, 119879, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Waistguard of Prowess
				{ 113, 119880, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Footguards of Cruelty
				{ 114, 119881, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Footguards of Prowess
				{ 116, 120004 },	-- Primal Aspirant's Armbands of Prowess
				{ 117, 120002 },	-- Primal Aspirant's Waistguard of Cruelty
				{ 118, 120003 },	-- Primal Aspirant's Footguards of Cruelty
			},
		},
		{
			name = ALIL["Plate"],
			[ALLIANCE_DIFF] = {
				{ 1, 115738, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Helm
				{ 2, 115740, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Shoulders
				{ 3, 115736, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestpiece
				{ 4, 115737, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Gauntlets
				{ 5, 115739, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Legguards
				{ 7, 115707, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armplates of Cruelty
				{ 8, 115708, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armplates of Prowess
				{ 10, 115701, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Girdle of Cruelty
				{ 11, 115702, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Girdle of Prowess
				{ 13, 115704, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Warboots of Cruelty
				{ 14, 115705, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Warboots of Prowess
				{ 16, 115743, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Visor
				{ 17, 115745, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Pauldrons
				{ 18, 115741, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestguard
				{ 19, 115709, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armplates of Victory
				{ 20, 115742, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Grips
				{ 21, 115703, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Girdle of Victory
				{ 22, 115744, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Leggings
				{ 23, 115706, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Warboots of Victory
				{ 101, 115143, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Helm
				{ 102, 115145, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Plate Shoulders
				{ 103, 115141, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Chestpiece
				{ 104, 115142, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Plate Gauntlets
				{ 105, 115144, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Legguards
				{ 107, 115115, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Armplates of Cruelty
				{ 108, 115116, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Armplates of Prowess
				{ 110, 115111, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Girdle of Cruelty
				{ 111, 115112, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Girdle of Prowess
				{ 113, 115113, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Warboots of Cruelty
				{ 114, 115114, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Warboots of Prowess
				{ 116, 115240 },	-- Primal Aspirant's Armplates of Cruelty
				{ 117, 115238 },	-- Primal Aspirant's Girdle of Cruelty
				{ 118, 115239 },	-- Primal Aspirant's Warboots of Cruelty
			},
			[HORDE_DIFF] = {
				{ 1, 111211, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Helm
				{ 2, 111213, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Shoulders
				{ 3, 111209, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestpiece
				{ 4, 111210, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Gauntlets
				{ 5, 111212, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Legguards
				{ 7, 111180, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armplates of Cruelty
				{ 8, 111181, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armplates of Prowess
				{ 10, 111174, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Girdle of Cruelty
				{ 11, 111175, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Girdle of Prowess
				{ 13, 111177, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Warboots of Cruelty
				{ 14, 111178, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Warboots of Prowess
				{ 16, 111216, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Visor
				{ 17, 111218, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Pauldrons
				{ 18, 111214, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestguard
				{ 19, 111182, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armplates of Victory
				{ 20, 111215, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Grips
				{ 21, 111176, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Girdle of Victory
				{ 22, 111217, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Leggings
				{ 23, 111179, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Warboots of Victory
				{ 101, 119920, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Helm
				{ 102, 119922, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Plate Shoulders
				{ 103, 119918, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Chestpiece
				{ 104, 119919, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Plate Gauntlets
				{ 105, 119921, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Plate Legguards
				{ 107, 119898, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Armplates of Cruelty
				{ 108, 119899, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Armplates of Prowess
				{ 110, 119894, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Girdle of Cruelty
				{ 111, 119895, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Girdle of Prowess
				{ 113, 119896, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Warboots of Cruelty
				{ 114, 119897, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Warboots of Prowess
				{ 116, 120017 },	-- Primal Aspirant's Armplates of Cruelty
				{ 117, 120015 },	-- Primal Aspirant's Girdle of Cruelty
				{ 118, 120016 },	-- Primal Aspirant's Warboots of Cruelty
			},
		},
		{
			name = AL["Amulets"],
			[ALLIANCE_DIFF] = {
				{ 1, 115734, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Choker of Cruelty
				{ 2, 120108, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Choker of Endurance
				{ 3, 115735, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Choker of Prowess
				{ 5, 115606, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Necklace of Cruelty
				{ 6, 115607, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Necklace of Prowess
				{ 8, 115658, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Pendant of Contemplation
				{ 9, 115655, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Pendant of Cruelty
				{ 10, 115657, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Pendant of Meditation
				{ 11, 115656, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Pendant of Prowess
				{ 16, 115139, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Choker of Cruelty
				{ 17, 115140, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Choker of Prowess
				{ 18, 115034, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Necklace of Cruelty
				{ 19, 115035, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Necklace of Prowess
				{ 20, 115074, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Pendant of Contemplation
				{ 21, 115071, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Pendant of Cruelty
				{ 22, 115073, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Pendant of Meditation
				{ 23, 115072, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Pendant of Prowess
				{ 25, 115256 },	-- Primal Aspirant's Choker of Cruelty
				{ 26, 115191 },	-- Primal Aspirant's Necklace of Cruelty
				{ 27, 115212 },	-- Primal Aspirant's Pendant of Cruelty
			},
			[HORDE_DIFF] = {
				{ 1, 111207, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Choker of Cruelty
				{ 2, 120107, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Choker of Endurance
				{ 3, 111208, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Choker of Prowess
				{ 5, 111079, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Necklace of Cruelty
				{ 6, 111080, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Necklace of Prowess
				{ 8, 111131, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Pendant of Contemplation
				{ 9, 111128, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Pendant of Cruelty
				{ 10, 111130, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Pendant of Meditation
				{ 11, 111129, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Pendant of Prowess
				{ 16, 119916, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Choker of Cruelty
				{ 17, 119917, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Choker of Prowess
				{ 18, 119824, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Necklace of Cruelty
				{ 19, 119825, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Necklace of Prowess
				{ 20, 119857, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Pendant of Contemplation
				{ 21, 119854, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Pendant of Cruelty
				{ 22, 119856, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Pendant of Meditation
				{ 23, 119855, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Pendant of Prowess
				{ 25, 120033 },	-- Primal Aspirant's Choker of Cruelty
				{ 26, 119968 },	-- Primal Aspirant's Necklace of Cruelty
				{ 27, 119989 },	-- Primal Aspirant's Pendant of Cruelty
			},
		},
		{
			name = AL["Cloaks"],
			[ALLIANCE_DIFF] = {
				{ 1, 115604, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cape of Cruelty
				{ 2, 115605, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cape of Prowess
				{ 4, 115732, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cloak of Cruelty
				{ 5, 120100, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cloak of Endurance
				{ 6, 115733, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cloak of Prowess
				{ 8, 115654, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Drape of Contemplation
				{ 9, 115651, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Drape of Cruelty
				{ 10, 115653, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Drape of Meditation
				{ 11, 115652, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Drape of Prowess
				{ 16, 115183, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cape of Cruelty
				{ 17, 115184, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cape of Prowess
				{ 18, 115189, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cloak of Cruelty
				{ 19, 115190, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cloak of Prowess
				{ 20, 115188, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Drape of Contemplation
				{ 21, 115185, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Drape of Cruelty
				{ 22, 115187, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Drape of Meditation
				{ 23, 115186, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Drape of Prowess
				{ 25, 115268 },	-- Primal Aspirant's Cape of Cruelty
				{ 26, 115271 },	-- Primal Aspirant's Cloak of Cruelty
				{ 27, 115269 },	-- Primal Aspirant's Drape of Cruelty
				{ 28, 115270 },	-- Primal Aspirant's Drape of Meditation
			},
			[HORDE_DIFF] = {
				{ 1, 111077, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cape of Cruelty
				{ 2, 111078, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cape of Prowess
				{ 4, 111205, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cloak of Cruelty
				{ 5, 120099, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cloak of Endurance
				{ 6, 111206, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cloak of Prowess
				{ 8, 111127, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Drape of Contemplation
				{ 9, 111124, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Drape of Cruelty
				{ 10, 111126, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Drape of Meditation
				{ 11, 111125, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Drape of Prowess
				{ 16, 119960, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cape of Cruelty
				{ 17, 119961, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cape of Prowess
				{ 18, 119966, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cloak of Cruelty
				{ 19, 119967, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Cloak of Prowess
				{ 20, 119965, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Drape of Contemplation
				{ 21, 119962, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Drape of Cruelty
				{ 22, 119964, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Drape of Meditation
				{ 23, 119963, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Drape of Prowess
				{ 25, 120045 },	-- Primal Aspirant's Cape of Cruelty
				{ 26, 120048 },	-- Primal Aspirant's Cloak of Cruelty
				{ 27, 120046 },	-- Primal Aspirant's Drape of Cruelty
				{ 28, 120047 },	-- Primal Aspirant's Drape of Meditation
			},
		},
		{
			name = AL["Rings"],
			[ALLIANCE_DIFF] = {
				{ 1, 115665, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Contemplation
				{ 2, 115661, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Cruelty
				{ 3, 115664, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Meditation
				{ 4, 115662, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Prowess
				{ 5, 115663, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Victory
				{ 7, 115608, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Ring of Cruelty
				{ 8, 115609, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Ring of Prowess
				{ 9, 115771, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Ring of Prowess
				{ 11, 115747, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Signet of Accuracy
				{ 12, 115772, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Signet of Accuracy
				{ 13, 115746, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Signet of Cruelty
				{ 14, 120104, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Signet of Endurance
				{ 16, 115081, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Contemplation
				{ 17, 115077, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Cruelty
				{ 18, 115080, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Meditation
				{ 19, 115078, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Prowess
				{ 20, 115079, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Victory
				{ 21, 115036, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Ring of Cruelty
				{ 22, 115037, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Ring of Prowess
				{ 23, 115171, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Ring of Prowess
				{ 24, 115147, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Signet of Accuracy
				{ 25, 115172, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Signet of Accuracy
				{ 26, 115146, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Signet of Cruelty
				{ 101, 115216 },	-- Primal Aspirant's Band of Contemplation
				{ 102, 115213 },	-- Primal Aspirant's Band of Cruelty
				{ 103, 115215 },	-- Primal Aspirant's Band of Meditation
				{ 104, 115214 },	-- Primal Aspirant's Band of Prowess
				{ 105, 115192 },	-- Primal Aspirant's Ring of Cruelty
				{ 106, 115193 },	-- Primal Aspirant's Ring of Prowess
				{ 107, 115257 },	-- Primal Aspirant's Signet of Cruelty
			},
			[HORDE_DIFF] = {
				{ 1, 111138, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Contemplation
				{ 2, 111134, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Cruelty
				{ 3, 111137, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Meditation
				{ 4, 111135, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Prowess
				{ 5, 111136, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Band of Victory
				{ 7, 111081, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Ring of Cruelty
				{ 8, 111082, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Ring of Prowess
				{ 9, 111271, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Ring of Prowess
				{ 11, 111220, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Signet of Accuracy
				{ 12, 111272, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Signet of Accuracy
				{ 13, 111219, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Signet of Cruelty
				{ 14, 120103, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Signet of Endurance
				{ 16, 119864, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Contemplation
				{ 17, 119860, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Cruelty
				{ 18, 119863, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Meditation
				{ 19, 119861, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Prowess
				{ 20, 119862, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Band of Victory
				{ 21, 119826, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Ring of Cruelty
				{ 22, 119827, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Ring of Prowess
				{ 23, 119948, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Ring of Prowess
				{ 24, 119924, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Signet of Accuracy
				{ 25, 119949, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Signet of Accuracy
				{ 26, 119923, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Signet of Cruelty
				{ 101, 119993 },	-- Primal Aspirant's Band of Contemplation
				{ 102, 119990 },	-- Primal Aspirant's Band of Cruelty
				{ 103, 119992 },	-- Primal Aspirant's Band of Meditation
				{ 104, 119991 },	-- Primal Aspirant's Band of Prowess
				{ 105, 119969 },	-- Primal Aspirant's Ring of Cruelty
				{ 106, 119970 },	-- Primal Aspirant's Ring of Prowess
				{ 107, 120034 },	-- Primal Aspirant's Signet of Cruelty
			},
		},
		{
			name = AL["Trinkets"],
			[ALLIANCE_DIFF] = {
				{ 1, 115496, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Adaptation
				{ 2, 115749, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Conquest
				{ 3, 115754, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Dominance
				{ 4, 115759, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Victory
				{ 5, 115751, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Emblem of Cruelty
				{ 6, 115753, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Emblem of Meditation
				{ 7, 115752, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Emblem of Tenacity
				{ 8, 115750, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Insignia of Conquest
				{ 9, 115755, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Insignia of Dominance
				{ 10, 115760, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Insignia of Victory
				{ 11, 115756, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Medallion of Cruelty
				{ 12, 115758, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Medallion of Meditation
				{ 13, 115757, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Medallion of Tenacity
				{ 16, 115521, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Adaptation
				{ 17, 115149, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Conquest
				{ 18, 115154, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Dominance
				{ 19, 115159, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Victory
				{ 20, 115151, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Emblem of Cruelty
				{ 21, 115153, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Emblem of Meditation
				{ 22, 115152, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Emblem of Tenacity
				{ 23, 115150, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Insignia of Conquest
				{ 24, 115155, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Insignia of Dominance
				{ 25, 115160, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Insignia of Victory
				{ 26, 115156, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Medallion of Cruelty
				{ 27, 115158, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Medallion of Meditation
				{ 28, 115157, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Medallion of Tenacity
			},
			[HORDE_DIFF] = {
				{ 1, 115495, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Adaptation
				{ 2, 111222, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Conquest
				{ 3, 111222, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Dominance
				{ 4, 111232, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Victory
				{ 5, 111224, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Emblem of Cruelty
				{ 6, 111226, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Emblem of Meditation
				{ 7, 111225, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Emblem of Tenacity
				{ 8, 111223, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Insignia of Conquest
				{ 9, 111228, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Insignia of Dominance
				{ 10, 111233, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Insignia of Victory
				{ 11, 111229, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Medallion of Cruelty
				{ 12, 111231, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Medallion of Meditation
				{ 13, 111230, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Medallion of Tenacity
				{ 16, 120049, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Adaptation
				{ 17, 119926, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Conquest
				{ 18, 119931, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Dominance
				{ 19, 119936, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Victory
				{ 20, 119928, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Emblem of Cruelty
				{ 21, 119930, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Emblem of Meditation
				{ 22, 119929, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Emblem of Tenacity
				{ 23, 119927, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Insignia of Conquest
				{ 24, 119932, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Insignia of Dominance
				{ 25, 119937, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Insignia of Victory
				{ 26, 119933, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Medallion of Cruelty
				{ 27, 119935, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Medallion of Meditation
				{ 28, 119934, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Medallion of Tenacity
			},
		},
		{
			name = AL["Miscellaneous"],
			[ALLIANCE_DIFF] = {
				{ 1, 115979, [PRICE_EXTRA_ITTYPE] = "conquest:1000" },	-- Primal Gladiator's Greatcloak (r2600)
				{ 3, 115972, [PRICE_EXTRA_ITTYPE] = "conquest:1000" },	-- Primal Gladiator's Tabard (r2600)
				{ 16, 115976, [PRICE_EXTRA_ITTYPE] = "112160:1:conquest:500" },	-- Enchant Weapon - Glory of the Blackrock (r2400)
				{ 17, 115978, [PRICE_EXTRA_ITTYPE] = "112165:1:conquest:500" },	-- Enchant Weapon - Glory of the Frostwolf (r2400)
				{ 18, 115975, [PRICE_EXTRA_ITTYPE] = "112115:1:conquest:500" },	-- Enchant Weapon - Glory of the Shadowmoon (r2400)
				{ 19, 115973, [PRICE_EXTRA_ITTYPE] = "110682:1:conquest:500" },	-- Enchant Weapon - Glory of the Thunderlord (r2400)
				{ 20, 115977, [PRICE_EXTRA_ITTYPE] = "112164:1:conquest:500" },	-- Enchant Weapon - Glory of the Warsong (r2400)
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
	},
}

data["WODS1WEAPONS"] = {
	name = string.format(AL["Warlords Season %d"], 1).." "..AL["Weapons"],
	ContentType = NORMAL_ITTYPE,
	items = {
		{
			name = string.format(AL["ilvl %d"], 660).." "..AL["Elite"],
			[ALLIANCE_DIFF] = {
				{ 1, 115949, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Render (r2000)
				{ 2, 115948, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ripper (r2000)
				{ 4, 115832, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Spellblade (r2000)
				{ 5, 115947, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Shanker (r2000)
				{ 7, 115950, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Mageblade (r2000)
				{ 8, 115822, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Quickblade (r2000)
				{ 9, 115954, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Slicer (r2000)
				{ 11, 115820, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cleaver (r2000)
				{ 12, 115952, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Hacker (r2000)
				{ 16, 115953, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Bonecracker (r2000)
				{ 17, 115863, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Gavel (r2000)
				{ 18, 115821, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pummeler (r2000)
				{ 20, 115819, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Greatsword (r2000)
				{ 21, 115817, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Decapitator (r2000)
				{ 22, 115818, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Bonegrinder (r2000)
				{ 24, 115910, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Pike (r2000)
				{ 26, 115833, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Battle Staff (r2000)
				{ 27, 115865, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Energy Staff (r2000)
				{ 28, 115854, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Staff (r2000)
				{ 101, 115831, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Barrier (r2000)
				{ 102, 115864, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Redoubt (r2000)
				{ 103, 115955, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Shield Wall (r2000)
				{ 105, 115836, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Heavy Crossbow (r2000)
				{ 106, 115823, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Longbow (r2000)
				{ 107, 115862, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Rifle (r2000)
				{ 116, 115951, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Baton of Light (r2000)
				{ 117, 115835, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Touch of Defeat (r2000)
				{ 119, 115834, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Reprieve (r2000)
				{ 120, 115830, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Endgame (r2000)
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
			},
		},
		{
			name = string.format(AL["ilvl %d"], 660).." (690)",
			[ALLIANCE_DIFF] = {
				{ 1, 115726, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Render
				{ 2, 115596, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ripper
				{ 4, 115644, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Spellblade
				{ 5, 115595, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Shanker
				{ 7, 115646, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Mageblade
				{ 8, 115598, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Quickblade
				{ 9, 115728, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Slicer
				{ 11, 115594, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cleaver
				{ 12, 115725, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Hacker
				{ 16, 115727, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Bonecracker
				{ 17, 115645, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Gavel
				{ 18, 115597, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pummeler
				{ 20, 115731, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Greatsword
				{ 21, 115729, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Decapitator
				{ 22, 115730, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Bonegrinder
				{ 24, 115602, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Pike
				{ 26, 115649, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Battle Staff
				{ 27, 115650, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Energy Staff
				{ 28, 115603, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Staff
				{ 101, 115667, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Barrier
				{ 102, 115666, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Redoubt
				{ 103, 115748, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Shield Wall
				{ 105, 115600, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Heavy Crossbow
				{ 106, 115599, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Longbow
				{ 107, 115601, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Rifle
				{ 116, 115647, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Baton of Light
				{ 117, 115648, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Touch of Defeat
				{ 119, 115660, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Reprieve
				{ 120, 115659, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Endgame
			},
			[HORDE_DIFF] = {
				{ 1, 111199, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Render
				{ 2, 111069, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ripper
				{ 4, 111117, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Spellblade
				{ 5, 111068, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Shanker
				{ 7, 111119, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Mageblade
				{ 8, 111071, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Quickblade
				{ 9, 111201, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Slicer
				{ 11, 111067, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cleaver
				{ 12, 111198, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Hacker
				{ 16, 111200, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Bonecracker
				{ 17, 111118, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Gavel
				{ 18, 111070, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pummeler
				{ 20, 111204, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Greatsword
				{ 21, 111202, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Decapitator
				{ 22, 111203, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Bonegrinder
				{ 24, 111075, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Pike
				{ 26, 111122, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Battle Staff
				{ 27, 111123, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Energy Staff
				{ 28, 111076, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Staff
				{ 101, 111140, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Barrier
				{ 102, 111139, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Redoubt
				{ 103, 111221, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Shield Wall
				{ 105, 111073, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Heavy Crossbow
				{ 106, 111072, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Longbow
				{ 107, 111074, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Rifle
				{ 116, 111120, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Baton of Light
				{ 117, 111121, [PRICE_EXTRA_ITTYPE] = "conquest:3500" },	-- Primal Gladiator's Touch of Defeat
				{ 119, 111133, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Reprieve
				{ 120, 111132, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Endgame
			},
		},
		{
			name = string.format(AL["ilvl %d"], 620).." (675)",
			[ALLIANCE_DIFF] = {
				{ 1, 120071, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Render
				{ 2, 120055, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ripper
				{ 4, 120063, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Spellblade
				{ 5, 120054, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Shanker
				{ 7, 120065, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Mageblade
				{ 8, 120057, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Quickblade
				{ 9, 120073, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Slicer
				{ 11, 120053, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Cleaver
				{ 12, 120070, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Hacker
				{ 16, 120072, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Bonecracker
				{ 17, 120064, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Gavel
				{ 18, 120056, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Pummeler
				{ 20, 120076, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Greatsword
				{ 21, 120074, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Decapitator
				{ 22, 120075, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Bonegrinder
				{ 24, 120061, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Pike
				{ 26, 120068, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Battle Staff
				{ 27, 120069, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Energy Staff
				{ 28, 120062, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Staff
				{ 101, 115083, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Barrier
				{ 102, 115082, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Redoubt
				{ 103, 115148, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Shield Wall
				{ 105, 120059, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Heavy Crossbow
				{ 106, 120058, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Longbow
				{ 107, 120060, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Rifle
				{ 116, 120066, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Baton of Light
				{ 117, 120067, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Touch of Defeat
				{ 119, 115076, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Reprieve
				{ 120, 115075, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Endgame
			},
			[HORDE_DIFF] = {
				{ 1, 115133, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Render
				{ 2, 115026, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Ripper
				{ 4, 115064, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Spellblade
				{ 5, 115025, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Shanker
				{ 7, 115066, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Mageblade
				{ 8, 115028, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Quickblade
				{ 9, 115135, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Slicer
				{ 11, 115024, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Cleaver
				{ 12, 115132, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Hacker
				{ 16, 115134, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Bonecracker
				{ 17, 115065, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Primal Combatant's Gavel
				{ 18, 115027, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Pummeler
				{ 20, 115138, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Greatsword
				{ 21, 115136, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Decapitator
				{ 22, 115137, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Bonegrinder
				{ 24, 115032, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Pike
				{ 26, 115069, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Battle Staff
				{ 27, 115070, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Energy Staff
				{ 28, 115033, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Staff
				{ 101, 119866, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Barrier
				{ 102, 119865, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Redoubt
				{ 103, 119925, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Shield Wall
				{ 105, 115030, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Heavy Crossbow
				{ 106, 115029, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Longbow
				{ 107, 115031, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Rifle
				{ 116, 115067, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Baton of Light
				{ 117, 115068, [PRICE_EXTRA_ITTYPE] = "honor:3500" },	-- Primal Combatant's Touch of Defeat
				{ 119, 119859, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Reprieve
				{ 120, 119858, [PRICE_EXTRA_ITTYPE] = "honor:1250" },	-- Primal Combatant's Endgame
			},
		},
	},
}

-- Mists of Pandaria Season 15

data["MOPS15SETS"] = {
	name = string.format(AL["Season %d"], 15).." "..AL["Class Sets"].." ("..AL["Mists of Pandaria"]..")",
	ContentType = NORMAL_ITTYPE,
	items = {
		{
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			[ALLIANCE_DIFF] = {
				{ 1, 102713, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dreadplate Helm
				{ 2, 102652, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Dreadplate Shoulders
				{ 3, 102676, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dreadplate Chestpiece
				{ 4, 102650, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Dreadplate Gauntlets
				{ 5, 102651, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dreadplate Legguards
				{ 16, 103181, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Helm
				{ 17, 103183, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dreadplate Shoulders
				{ 18, 103179, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Chestpiece
				{ 19, 103180, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dreadplate Gauntlets
				{ 20, 103182, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 103378, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Helm
				{ 2, 103380, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dreadplate Shoulders
				{ 3, 103376, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Chestpiece
				{ 4, 103377, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dreadplate Gauntlets
				{ 5, 103379, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Legguards
				{ 16, 102910, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Helm
				{ 17, 102849, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dreadplate Shoulders
				{ 18, 102873, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Chestpiece
				{ 19, 102847, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dreadplate Gauntlets
				{ 20, 102848, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dreadplate Legguards
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			[ALLIANCE_DIFF] = {
				-- Moonkin, 550 > 522
				{ 1, 102634, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Wyrmhide Helm
				{ 2, 102700, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Wyrmhide Spaulders
				{ 3, 102614, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Wyrmhide Robes
				{ 4, 102696, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Wyrmhide Gloves
				{ 5, 102767, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Wyrmhide Legguards
				{ 16, 103202, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Wyrmhide Helm
				{ 17, 103205, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Wyrmhide Spaulders
				{ 18, 103204, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Wyrmhide Robes
				{ 19, 103201, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Wyrmhide Gloves
				{ 20, 103203, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Wyrmhide Legguards
				-- Cat/Bear, 550 > 522
				{ 7, 102653, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dragonhide Helm
				{ 8, 102741, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Dragonhide Spaulders
				{ 9, 102740, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dragonhide Robes
				{ 10, 102739, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Dragonhide Gloves
				{ 11, 102654, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dragonhide Legguards
				{ 22, 103185, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dragonhide Helm
				{ 23, 103188, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dragonhide Spaulders
				{ 24, 103187, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dragonhide Robes
				{ 25, 103184, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dragonhide Gloves
				{ 26, 103186, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dragonhide Legguards
				-- Heal, 550 > 522
				{ 101, 102776, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Kodohide Helm
				{ 102, 102658, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Kodohide Spaulders
				{ 103, 102721, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Kodohide Robes
				{ 104, 102657, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Kodohide Gloves
				{ 105, 102761, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Kodohide Legguards
				{ 116, 103193, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Kodohide Helm
				{ 117, 103196, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Kodohide Spaulders
				{ 118, 103195, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Kodohide Robes
				{ 119, 103192, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Kodohide Gloves
				{ 120, 103194, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Kodohide Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				-- Moonkin, 550 > 522
				{ 1, 103399, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Wyrmhide Helm
				{ 2, 103402, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Wyrmhide Spaulders
				{ 3, 103401, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Wyrmhide Robes
				{ 4, 103398, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Wyrmhide Gloves
				{ 5, 103400, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Wyrmhide Legguards
				{ 16, 102831, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Wyrmhide Helm
				{ 17, 102897, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Wyrmhide Spaulders
				{ 18, 102811, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Wyrmhide Robes
				{ 19, 102893, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Wyrmhide Gloves
				{ 20, 102964, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Wyrmhide Legguards
				-- Cat/Bear, 550 > 522
				{ 7, 103382, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dragonhide Helm
				{ 8, 103385, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Dragonhide Spaulders
				{ 9, 103384, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dragonhide Robes
				{ 10, 103381, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Dragonhide Gloves
				{ 11, 103383, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Dragonhide Legguards
				{ 22, 102850, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dragonhide Helm
				{ 23, 102938, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dragonhide Spaulders
				{ 24, 102937, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dragonhide Robes
				{ 25, 102936, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Dragonhide Gloves
				{ 26, 102851, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Dragonhide Legguards
				-- Heal, 550 > 522
				{ 101, 103390, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Kodohide Helm
				{ 102, 103393, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Kodohide Spaulders
				{ 103, 103392, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Kodohide Robes
				{ 104, 103389, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Kodohide Gloves
				{ 105, 103391, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Kodohide Legguards
				{ 116, 102973, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Kodohide Helm
				{ 117, 102855, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Kodohide Spaulders
				{ 118, 102918, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Kodohide Robes
				{ 119, 102854, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Kodohide Gloves
				{ 120, 102958, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Kodohide Legguards
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			[ALLIANCE_DIFF] = {
				{ 1, 102690, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Chain Helm
				{ 2, 102734, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Chain Spaulders
				{ 3, 102689, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Chain Armor
				{ 4, 102737, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Chain Gauntlets
				{ 5, 102670, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Chain Leggings
				{ 16, 103221, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Chain Helm
				{ 17, 103223, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Chain Spaulders
				{ 18, 103219, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Chain Armor
				{ 19, 103220, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Chain Gauntlets
				{ 20, 103222, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Chain Leggings
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 103418, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Chain Helm
				{ 2, 103420, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Chain Spaulders
				{ 3, 103416, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Chain Armor
				{ 4, 103417, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Chain Gauntlets
				{ 5, 103419, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Chain Leggings
				{ 16, 102887, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Chain Helm
				{ 17, 102931, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Chain Spaulders
				{ 18, 102886, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Chain Armor
				{ 19, 102934, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Chain Gauntlets
				{ 20, 102867, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Chain Leggings
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			[ALLIANCE_DIFF] = {
				{ 1, 102667, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Silk Cowl
				{ 2, 102673, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Silk Amice
				{ 3, 102715, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Silk Robe
				{ 4, 102735, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Silk Handguards
				{ 5, 102648, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Silk Trousers
				{ 16, 103225, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Silk Cowl
				{ 17, 103228, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Silk Amice
				{ 18, 103227, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Silk Robe
				{ 19, 103224, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Silk Handguards
				{ 20, 103226, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Silk Trousers
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 103422, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Silk Cowl
				{ 2, 103425, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Silk Amice
				{ 3, 103424, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Silk Robe
				{ 4, 103421, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Silk Handguards
				{ 5, 103423, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Silk Trousers
				{ 16, 102864, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Silk Cowl
				{ 17, 102870, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Silk Amice
				{ 18, 102912, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Silk Robe
				{ 19, 102932, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Silk Handguards
				{ 20, 102845, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Silk Trousers
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"],
			[ALLIANCE_DIFF] = {
				-- Windwalker, 550 > 522
				{ 1, 102712, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ironskin Helm
				{ 2, 102626, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Ironskin Spaulders
				{ 3, 102720, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ironskin Tunic
				{ 4, 102675, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Ironskin Gloves
				{ 5, 102656, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ironskin Legguards
				{ 16, 103233, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ironskin Helm
				{ 17, 103235, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Ironskin Spaulders
				{ 18, 103236, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ironskin Tunic
				{ 19, 103232, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Ironskin Gloves
				{ 20, 103234, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ironskin Legguards
				-- Mistweaver, 550 > 522
				{ 7, 102628, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Copperskin Helm
				{ 8, 102777, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Copperskin Spaulders
				{ 9, 102763, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Copperskin Tunic
				{ 10, 102627, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Copperskin Gloves
				{ 11, 102762, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Copperskin Legguards
				{ 22, 103238, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Copperskin Helm
				{ 23, 103240, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Copperskin Spaulders
				{ 24, 103241, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Copperskin Tunic
				{ 25, 103237, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Copperskin Gloves
				{ 26, 103239, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Copperskin Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				-- Windwalker, 550 > 522
				{ 1, 103430, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ironskin Helm
				{ 2, 103432, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Ironskin Spaulders
				{ 3, 103433, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ironskin Tunic
				{ 4, 103429, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Ironskin Gloves
				{ 5, 103431, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ironskin Legguards
				{ 16, 102909, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ironskin Helm
				{ 17, 102823, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Ironskin Spaulders
				{ 18, 102917, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ironskin Tunic
				{ 19, 102872, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Ironskin Gloves
				{ 20, 102853, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ironskin Legguards
				-- Mistweaver, 550 > 522
				{ 7, 103435, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Copperskin Helm
				{ 8, 103437, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Copperskin Spaulders
				{ 9, 103438, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Copperskin Tunic
				{ 10, 103434, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Copperskin Gloves
				{ 11, 103436, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Copperskin Legguards
				{ 22, 102825, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Copperskin Helm
				{ 23, 102974, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Copperskin Spaulders
				{ 24, 102960, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Copperskin Tunic
				{ 25, 102824, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Copperskin Gloves
				{ 26, 102959, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Copperskin Legguards
			},
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			[ALLIANCE_DIFF] = {
				-- Retribution, 550 > 522
				{ 1, 102779, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Scaled Helm
				{ 2, 102744, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Scaled Spaulders
				{ 3, 102747, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Scaled Chestguard
				{ 4, 102630, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Scaled Gloves
				{ 5, 102780, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Scaled Legguards
				{ 16, 103244, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Scaled Helm
				{ 17, 103246, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Scaled Spaulders
				{ 18, 103242, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Scaled Chestguard
				{ 19, 103243, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Scaled Gloves
				{ 20, 103245, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Scaled Legguards
				-- Holy, 550 > 522
				{ 7, 102635, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ornamented Helm
				{ 8, 102697, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Ornamented Spaulders
				{ 9, 102632, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ornamented Chestguard
				{ 10, 102722, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Ornamented Gloves
				{ 11, 102768, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ornamented Legguards
				{ 22, 103255, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ornamented Helm
				{ 23, 103257, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Ornamented Spaulders
				{ 24, 103253, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ornamented Chestguard
				{ 25, 103254, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Ornamented Gloves
				{ 26, 103256, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ornamented Legguards
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				-- Retribution, 550 > 522
				{ 1, 103441, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Scaled Helm
				{ 2, 103443, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Scaled Spaulders
				{ 3, 103439, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Scaled Chestguard
				{ 4, 103440, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Scaled Gloves
				{ 5, 103442, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Scaled Legguards
				{ 16, 102976, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Scaled Helm
				{ 17, 102941, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Scaled Spaulders
				{ 18, 102944, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Scaled Chestguard
				{ 19, 102827, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Scaled Gloves
				{ 20, 102977, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Scaled Legguards
				-- Holy, 550 > 522
				{ 7, 103452, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ornamented Helm
				{ 8, 103454, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Ornamented Spaulders
				{ 9, 103450, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ornamented Chestguard
				{ 10, 103451, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Prideful Gladiator's Ornamented Gloves
				{ 11, 103453, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Prideful Gladiator's Ornamented Legguards
				{ 22, 102832, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ornamented Helm
				{ 23, 102894, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Ornamented Spaulders
				{ 24, 102829, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ornamented Chestguard
				{ 25, 102919, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Grievous Gladiator's Ornamented Gloves
				{ 26, 102965, [PRICE_EXTRA_ITTYPE] = "honor:2250" },	-- Grievous Gladiator's Ornamented Legguards
			},
		},
	},
}