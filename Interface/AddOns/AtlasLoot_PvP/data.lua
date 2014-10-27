local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
local HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)

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
				{ 7, 115839, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Helm
				{ 8, 115841, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Shoulders
				{ 9, 115837, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Chestpiece
				{ 10, 115838, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Gauntlets
				{ 11, 115906, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Girdle
				{ 12, 115840, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dreadplate Legguards
				{ 13, 115909, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dreadplate Warboots
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
				{ 7, 115843, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Helm
				{ 8, 115846, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Spaulders
				{ 9, 115845, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Robes
				{ 10, 115842, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Gloves
				{ 11, 115971, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Belt
				{ 12, 115844, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Dragonhide Legguards
				{ 13, 115970, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Dragonhide Footguards
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
				{ 7, 115872, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Helm
				{ 8, 115874, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Spaulders
				{ 9, 115870, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Armor
				{ 10, 115871, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Gauntlets
				{ 11, 115866, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Links
				{ 12, 115873, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chain Leggings
				{ 13, 115868, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Chain Sabatons
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
				{ 7, 115876, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Cowl
				{ 8, 115879, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Amice
				{ 9, 115878, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Robe
				{ 10, 115875, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Handguards
				{ 11, 115824, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Cord
				{ 12, 115877, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Silk Trousers
				{ 13, 115827, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Silk Treads
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
				{ 7, 115883, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Helm
				{ 8, 115885, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Spaulders
				{ 9, 115886, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Tunic
				{ 10, 115882, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Gloves
				{ 11, 115880, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Waistband
				{ 12, 115884, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ironskin Legguards
				{ 13, 115881, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ironskin Boots
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
				{ 7, 115894, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Helm
				{ 8, 115896, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Shoulders
				{ 9, 115892, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Chestpiece
				{ 10, 115893, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Gauntlets
				{ 11, 115897, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Clasp
				{ 12, 115895, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Scaled Legguards
				{ 13, 115900, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Scaled Greaves
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
				{ 7, 115917, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Hood
				{ 8, 115920, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Mantle
				{ 9, 115919, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Robe
				{ 10, 115916, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Gloves
				{ 11, 115969, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Cord
				{ 12, 115918, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Satin Leggings
				{ 13, 115968, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Satin Treads
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
				{ 7, 115925, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Helm
				{ 8, 115927, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Spaulders
				{ 9, 115923, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Tunic
				{ 10, 115924, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Gloves
				{ 11, 115921, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Waistband
				{ 12, 115926, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leather Legguards
				{ 13, 115922, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Leather Boots
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
				{ 7, 115933, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Helm
				{ 8, 115935, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Spaulders
				{ 9, 115931, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Armor
				{ 10, 115932, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Gauntlets
				{ 11, 115928, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Waistguard
				{ 12, 115934, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Ringmail Leggings
				{ 13, 115929, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Ringmail Footguards
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
				{ 7, 115957, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Cowl
				{ 8, 115960, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Amice
				{ 9, 115959, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Raiment
				{ 10, 115956, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Handguards
				{ 11, 115825, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Cord
				{ 12, 115958, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Felweave Trousers
				{ 13, 115828, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Felweave Treads
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
				{ 7, 115963, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Helm
				{ 8, 115965, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Shoulders
				{ 9, 115961, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestpiece
				{ 10, 115962, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Gauntlets
				{ 11, 115907, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Girdle
				{ 12, 115964, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Legguards
				{ 13, 115908, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Warboots
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

data["WODS1NONSETARMOR"] = {
	name = string.format(AL["Warlords Season %d"], 1).." "..AL["Non-Set Armor"],
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
			},
		},
	},
}