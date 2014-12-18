local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname)

local AL = AtlasLoot.Locales

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], nil, nil, 17)
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], nil, nil, 14)
local HEROIC_DIFF = data:AddDifficulty(AL["Heroic"], nil, nil, 15)
local MYTHIC_DIFF = data:AddDifficulty(AL["Mythic"], nil, nil, 16)

local HORDE_DIFF, ALLIANCE_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local RAID_ITTYPE = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...
local SET_ITTYPE = data:AddItemTableType("Set", "Item") -- Normal, Thunder-/Warforged...
local I_A_ITTYPE  = data:AddItemTableType("Item", "Achievement")

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")

local COLLECTION_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTION_COLOR)
local OLD_COLLECTION_CONTENT = data:AddContentType("OLD UNTRANS", ATLASLOOT_COLLECTION_COLOR)

data["APEXISCRYSTALGEAR"] = {
	name = AL["Apexis Crystal"].." "..AL["Vendors"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{
			name = string.format(AL["ilvl %d"], 655).." "..AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 116972, [PRICE_EXTRA_ITTYPE] = "115394:1:apexis:14500" },	-- Flawless Crystal Reinforced Doomcloak
				{ 2, 116970, [PRICE_EXTRA_ITTYPE] = "115392:1:apexis:14500" },	-- Flawless Crystalclasp Stormcloak
				{ 3, 116969, [PRICE_EXTRA_ITTYPE] = "115391:1:apexis:14500" },	-- Flawless Crystal-Edged Bladecloak
				{ 4, 116971, [PRICE_EXTRA_ITTYPE] = "115393:1:apexis:14500" },	-- Flawless Refractory Heartcloak
				{ 5, 116951, [PRICE_EXTRA_ITTYPE] = "115395:1:apexis:14500" },	-- Flawless Shard-Covered Dreadcloak
				{ 6, 115396, [PRICE_EXTRA_ITTYPE] = "116957:1:apexis:20000" },	-- Flawless Windcrystal Hood
				{ 7, 115400, [PRICE_EXTRA_ITTYPE] = "116961:1:apexis:14500" },	-- Flawless Windcrystal Bracers
				{ 8, 116947, [PRICE_EXTRA_ITTYPE] = "115387:1:apexis:17000" },	-- Flawless Windcrystal Wraps
				{ 9, 116939, [PRICE_EXTRA_ITTYPE] = "116935:1:apexis:17000" },	-- Flawless Windcrystal Cord
				{ 10, 116931, [PRICE_EXTRA_ITTYPE] = "116927:1:apexis:20000" },	-- Flawless Windcrystal Leggings
				{ 11, 115397, [PRICE_EXTRA_ITTYPE] = "116958:1:apexis:20000" },	-- Flawless Crystalhide Cowl
				{ 12, 115401, [PRICE_EXTRA_ITTYPE] = "116962:1:apexis:14500" },	-- Flawless Crystalhide Bracers
				{ 13, 116948, [PRICE_EXTRA_ITTYPE] = "115388:1:apexis:17000" },	-- Flawless Crystalhide Grips
				{ 14, 116940, [PRICE_EXTRA_ITTYPE] = "116936:1:apexis:17000" },	-- Flawless Crystalhide Belt
				{ 15, 116932, [PRICE_EXTRA_ITTYPE] = "116928:1:apexis:20000" },	-- Flawless Crystalhide Legguards
				{ 16, 115398, [PRICE_EXTRA_ITTYPE] = "116959:1:apexis:20000" },	-- Flawless Crystal-Leaf Helm
				{ 17, 115402, [PRICE_EXTRA_ITTYPE] = "116963:1:apexis:14500" },	-- Flawless Crystal-Leaf Bracers
				{ 18, 116949, [PRICE_EXTRA_ITTYPE] = "115389:1:apexis:17000" },	-- Flawless Crystal-Leaf Gloves
				{ 19, 116941, [PRICE_EXTRA_ITTYPE] = "116937:1:apexis:17000" },	-- Flawless Crystal-Leaf Chain
				{ 20, 116933, [PRICE_EXTRA_ITTYPE] = "116929:1:apexis:20000" },	-- Flawless Crystal-Leaf Legguards
				{ 21, 115399, [PRICE_EXTRA_ITTYPE] = "116960:1:apexis:20000" },	-- Flawless Crystal-Plated Greathelm
				{ 22, 115403, [PRICE_EXTRA_ITTYPE] = "116964:1:apexis:14500" },	-- Flawless Crystal-Plated Bracers
				{ 23, 116950, [PRICE_EXTRA_ITTYPE] = "115390:1:apexis:17000" },	-- Flawless Crystal-Plated Gauntlets
				{ 24, 116942, [PRICE_EXTRA_ITTYPE] = "116938:1:apexis:17000" },	-- Flawless Crystal-Plated Greatbelt
				{ 25, 116934, [PRICE_EXTRA_ITTYPE] = "116930:1:apexis:20000" },	-- Flawless Crystal-Plated Legplates
			},
		},
		{
			name = string.format(AL["ilvl %d"], 645).." "..AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 115394, [PRICE_EXTRA_ITTYPE] = "116976:1:apexis:9000" },	-- Exceptional Crystal Reinforced Doomcloak
				{ 2, 115392, [PRICE_EXTRA_ITTYPE] = "116974:1:apexis:9000" },	-- Exceptional Crystalclasp Stormcloak
				{ 3, 115391, [PRICE_EXTRA_ITTYPE] = "116973:1:apexis:9000" },	-- Exceptional Crystal-Edged Bladecloak
				{ 4, 115393, [PRICE_EXTRA_ITTYPE] = "116975:1:apexis:9000" },	-- Exceptional Refractory Heartcloak
				{ 5, 115395, [PRICE_EXTRA_ITTYPE] = "116952:1:apexis:9000" },	-- Exceptional Shard-Covered Dreadcloak
				{ 6, 116957, [PRICE_EXTRA_ITTYPE] = "116953:1:apexis:11500" },	-- Exceptional Windcrystal Hood
				{ 7, 116961, [PRICE_EXTRA_ITTYPE] = "116965:1:apexis:9000" },	-- Exceptional Windcrystal Bracers
				{ 8, 115387, [PRICE_EXTRA_ITTYPE] = "116943:1:apexis:10500" },	-- Exceptional Windcrystal Wraps
				{ 9, 116935, [PRICE_EXTRA_ITTYPE] = "115378:1:apexis:10500" },	-- Exceptional Windcrystal Cord
				{ 10, 116927, [PRICE_EXTRA_ITTYPE] = "115374:1:apexis:11500" },	-- Exceptional Windcrystal Leggings
				{ 11, 116958, [PRICE_EXTRA_ITTYPE] = "116954:1:apexis:11500" },	-- Exceptional Crystalhide Cowl
				{ 12, 116962, [PRICE_EXTRA_ITTYPE] = "116966:1:apexis:9000" },	-- Exceptional Crystalhide Bracers
				{ 13, 115388, [PRICE_EXTRA_ITTYPE] = "116944:1:apexis:10500" },	-- Exceptional Crystalhide Grips
				{ 14, 116936, [PRICE_EXTRA_ITTYPE] = "115379:1:apexis:10500" },	-- Exceptional Crystalhide Belt
				{ 15, 116928, [PRICE_EXTRA_ITTYPE] = "115375:1:apexis:11500" },	-- Exceptional Crystalhide Legguards
				{ 16, 116959, [PRICE_EXTRA_ITTYPE] = "116955:1:apexis:11500" },	-- Exceptional Crystal-Leaf Helm
				{ 17, 116963, [PRICE_EXTRA_ITTYPE] = "116967:1:apexis:9000" },	-- Exceptional Crystal-Leaf Bracers
				{ 18, 115389, [PRICE_EXTRA_ITTYPE] = "116945:1:apexis:10500" },	-- Exceptional Crystal-Leaf Gloves
				{ 19, 116937, [PRICE_EXTRA_ITTYPE] = "115380:1:apexis:10500" },	-- Exceptional Crystal-Leaf Chain
				{ 20, 116929, [PRICE_EXTRA_ITTYPE] = "115376:1:apexis:11500" },	-- Exceptional Crystal-Leaf Legguards
				{ 21, 116960, [PRICE_EXTRA_ITTYPE] = "116956:1:apexis:11500" },	-- Exceptional Crystal-Plated Greathelm
				{ 22, 116964, [PRICE_EXTRA_ITTYPE] = "116968:1:apexis:9000" },	-- Exceptional Crystal-Plated Bracers
				{ 23, 115390, [PRICE_EXTRA_ITTYPE] = "116946:1:apexis:10500" },	-- Exceptional Crystal-Plated Gauntlets
				{ 24, 116938, [PRICE_EXTRA_ITTYPE] = "115381:1:apexis:10500" },	-- Exceptional Crystal-Plated Greatbelt
				{ 25, 116930, [PRICE_EXTRA_ITTYPE] = "115377:1:apexis:11500" },	-- Exceptional Crystal-Plated Legplates
			},
		},
		{
			name = string.format(AL["ilvl %d"], 630).." "..AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 116976, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Crystal Reinforced Doomcloak
				{ 2, 116974, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Crystalclasp Stormcloak
				{ 3, 116973, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Crystal-Edged Bladecloak
				{ 4, 116975, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Refractory Heartcloak
				{ 5, 116952, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Shard-Covered Dreadcloa
				{ 6, 116953, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },	-- Windcrystal Hood
				{ 7, 116965, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Windcrystal Bracers
				{ 8, 116943, [PRICE_EXTRA_ITTYPE] = "apexis:4000" },	-- Windcrystal Wraps
				{ 9, 115378, [PRICE_EXTRA_ITTYPE] = "apexis:4000" },	-- Windcrystal Cord
				{ 10, 115374, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },	-- Windcrystal Leggings
				{ 11, 116954, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },	-- Crystalhide Cowl
				{ 12, 116966, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Crystalhide Bracers
				{ 13, 116944, [PRICE_EXTRA_ITTYPE] = "apexis:4000" },	-- Crystalhide Grips
				{ 14, 115379, [PRICE_EXTRA_ITTYPE] = "apexis:4000" },	-- Crystalhide Belt
				{ 15, 115375, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },	-- Crystalhide Legguards
				{ 16, 116955, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },	-- Crystal-Leaf Helm
				{ 17, 116967, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Crystal-Leaf Bracers
				{ 18, 116945, [PRICE_EXTRA_ITTYPE] = "apexis:4000" },	-- Crystal-Leaf Gloves
				{ 19, 115380, [PRICE_EXTRA_ITTYPE] = "apexis:4000" },	-- Crystal-Leaf Chain
				{ 20, 115376, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },	-- Crystal-Leaf Legguards
				{ 21, 116956, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },	-- Crystal-Plated Greathelm
				{ 22, 116968, [PRICE_EXTRA_ITTYPE] = "apexis:3000" },	-- Crystal-Plated Bracers
				{ 23, 116946, [PRICE_EXTRA_ITTYPE] = "apexis:4000" },	-- Crystal-Plated Gauntlets
				{ 24, 115381, [PRICE_EXTRA_ITTYPE] = "apexis:4000" },	-- Crystal-Plated Greatbelt
				{ 25, 115377, [PRICE_EXTRA_ITTYPE] = "apexis:5000" },	-- Crystal-Plated Legplates
			},
		},
		{
			name = AL["Miscellaneous"],
			[NORMAL_DIFF] = {
				{ 1, 116785, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Swift Frostwolf
				{ 2, 116665, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Armored Irontusk
				{ 3, 116775, "mount", [PRICE_EXTRA_ITTYPE] = "money:40000000:apexis:5000" },	-- Breezestrider Stallion
				{ 4, 116672, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Domesticated Razorback
				{ 5, 116664, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Dusty Rockhide
				{ 6, 116782, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Ironside Warwolf
				{ 7, 116768, "mount", [PRICE_EXTRA_ITTYPE] = "money:500000000:apexis:5000" },	-- Mosshide Riverwallow
				{ 8, 116776, "mount", [PRICE_EXTRA_ITTYPE] = "money:40000000:apexis:5000" },	-- Pale Thorngrazer
				{ 9, 116772, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Shadowmane Charger
				{ 11, 118673, [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:1000" },	-- Golden Visage of the Laughing Skull
				{ 12, 118672, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },	-- Bloody Visage of the Laughing Skul
				{ 13, 118671, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },	-- Frozen Visage of the Laughing Skull
				{ 14, 118674, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },	-- Visage of the Laughing Skull
				{ 16, 119146, "pet1458", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Bone Wasp
				{ 17, 119149, "pet1430", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Captured Forest Sproutling
				{ 18, 119142, "pet1450", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Draenei Micro Defender
				{ 19, 119141, "pet1542", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Frostwolf Pup
				{ 20, 119148, "pet1571", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Indentured Albino River Calf
				{ 21, 119143, "pet1574", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Son of Sethe
				{ 23, 118666, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Arakkoa Elixir
				{ 24, 118665, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Exarch Elixir
				{ 25, 118664, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Frostwolf Elixir
				{ 26, 118668, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Laughing Skull Elixir
				{ 27, 118669, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Sha'tari Elixir
				{ 28, 118667, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Steamwheedle Elixir
			},
		},
	},
}

data["TIERSETS"] = {
	name = AL["Tier Sets"],
	ContentType = COLLECTION_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{	-- Tier 17 Sets
			name = format(AL["Tier %d Sets"], 17),
			[RF_DIFF] = {
				{ 1, "Tier17:rfcloth:rf" },
				{ 3, "Tier17:rfleather:rf" },
				{ 16, "Tier17:rfmail:rf" },
				{ 18, "Tier17:rfplate:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1, "Tier17:dk:n" },
				{ 3, "Tier17:druid:n" },
				{ 5, "Tier17:hunter:n" },
				{ 7, "Tier17:mage:n" },
				{ 9, "Tier17:monk:n" },
				{ 11, "Tier17:paladin:n" },
				{ 16, "Tier17:priest:n" },
				{ 18, "Tier17:rogue:n" },
				{ 20, "Tier17:shaman:n" },
				{ 22, "Tier17:warlock:n" },
				{ 24, "Tier17:warrior:n" },
			},
			[HEROIC_DIFF] = {
				{ 1, "Tier17:dk:hB1" },
				{ 3, "Tier17:druid:hB1" },
				{ 5, "Tier17:hunter:hB1" },
				{ 7, "Tier17:mage:hB1" },
				{ 9, "Tier17:monk:hB1" },
				{ 11, "Tier17:paladin:hB1" },
				{ 16, "Tier17:priest:hB1" },
				{ 18, "Tier17:rogue:hB1" },
				{ 20, "Tier17:shaman:hB1" },
				{ 22, "Tier17:warlock:hB1" },
				{ 24, "Tier17:warrior:hB1" },
			},
			[MYTHIC_DIFF] = {
				{ 1, "Tier17:dk:mB1" },
				{ 3, "Tier17:druid:mB1" },
				{ 5, "Tier17:hunter:mB1" },
				{ 7, "Tier17:mage:mB1" },
				{ 9, "Tier17:monk:mB1" },
				{ 11, "Tier17:paladin:mB1" },
				{ 16, "Tier17:priest:mB1" },
				{ 18, "Tier17:rogue:mB1" },
				{ 20, "Tier17:shaman:mB1" },
				{ 22, "Tier17:warlock:mB1" },
				{ 24, "Tier17:warrior:mB1" },
			},
		},
		{	-- Tier 16 Sets
			name = format(AL["Tier %d Sets"], 16),
			[RF_DIFF] = {
				{ 1, "Tier16:hunter:rf" },
				{ 2, "Tier16:mage:rf" },
				{ 3, "Tier16:rogue:rf" },
				{ 4, "Tier16:warlock:rf" },
				{ 6, "Tier16:deathknightblood:rf" },
				{ 7, "Tier16:deathknightdps:rf" },
				{ 9, "Tier16:druidbalance:rf" },
				{ 10, "Tier16:druidferal:rf" },
				{ 11, "Tier16:druidguardian:rf" },
				{ 12, "Tier16:druidrestoration:rf" },
				{ 14, "Tier16:priestheal:rf" },
				{ 15, "Tier16:priestshadow:rf" },
				{ 16, "Tier16:monkbrewmaster:rf" },
				{ 17, "Tier16:monkmistweaver:rf" },
				{ 18, "Tier16:monkwindwalker:rf" },
				{ 20, "Tier16:paladinholy:rf" },
				{ 21, "Tier16:paladinprotection:rf" },
				{ 22, "Tier16:paladinretribution:rf" },
				{ 24, "Tier16:shamanelemental:rf" },
				{ 25, "Tier16:shamanenhancement:rf" },
				{ 26, "Tier16:shamanrestoration:rf" },
				{ 28, "Tier16:warriordps:rf" },
				{ 29, "Tier16:warriorprotection:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1, "Tier16:hunter:n" },
				{ 2, "Tier16:mage:n" },
				{ 3, "Tier16:rogue:n" },
				{ 4, "Tier16:warlock:n" },
				{ 6, "Tier16:deathknightblood:n" },
				{ 7, "Tier16:deathknightdps:n" },
				{ 9, "Tier16:druidbalance:n" },
				{ 10, "Tier16:druidferal:n" },
				{ 11, "Tier16:druidguardian:n" },
				{ 12, "Tier16:druidrestoration:n" },
				{ 14, "Tier16:priestheal:n" },
				{ 15, "Tier16:priestshadow:n" },
				{ 16, "Tier16:monkbrewmaster:n" },
				{ 17, "Tier16:monkmistweaver:n" },
				{ 18, "Tier16:monkwindwalker:n" },
				{ 20, "Tier16:paladinholy:n" },
				{ 21, "Tier16:paladinprotection:n" },
				{ 22, "Tier16:paladinretribution:n" },
				{ 24, "Tier16:shamanelemental:n" },
				{ 25, "Tier16:shamanenhancement:n" },
				{ 26, "Tier16:shamanrestoration:n" },
				{ 28, "Tier16:warriordps:n" },
				{ 29, "Tier16:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1, "Tier16:hunter:h" },
				{ 2, "Tier16:mage:h" },
				{ 3, "Tier16:rogue:h" },
				{ 4, "Tier16:warlock:h" },
				{ 6, "Tier16:deathknightblood:h" },
				{ 7, "Tier16:deathknightdps:h" },
				{ 9, "Tier16:druidbalance:h" },
				{ 10, "Tier16:druidferal:h" },
				{ 11, "Tier16:druidguardian:h" },
				{ 12, "Tier16:druidrestoration:h" },
				{ 14, "Tier16:priestheal:h" },
				{ 15, "Tier16:priestshadow:h" },
				{ 16, "Tier16:monkbrewmaster:h" },
				{ 17, "Tier16:monkmistweaver:h" },
				{ 18, "Tier16:monkwindwalker:h" },
				{ 20, "Tier16:paladinholy:h" },
				{ 21, "Tier16:paladinprotection:h" },
				{ 22, "Tier16:paladinretribution:h" },
				{ 24, "Tier16:shamanelemental:h" },
				{ 25, "Tier16:shamanenhancement:h" },
				{ 26, "Tier16:shamanrestoration:h" },
				{ 28, "Tier16:warriordps:h" },
				{ 29, "Tier16:warriorprotection:h" },
			},
			[MYTHIC_DIFF] = {
				{ 1, "Tier16:hunter:m" },
				{ 2, "Tier16:mage:m" },
				{ 3, "Tier16:rogue:m" },
				{ 4, "Tier16:warlock:m" },
				{ 6, "Tier16:deathknightblood:m" },
				{ 7, "Tier16:deathknightdps:m" },
				{ 9, "Tier16:druidbalance:m" },
				{ 10, "Tier16:druidferal:m" },
				{ 11, "Tier16:druidguardian:m" },
				{ 12, "Tier16:druidrestoration:m" },
				{ 14, "Tier16:priestheal:m" },
				{ 15, "Tier16:priestshadow:m" },
				{ 16, "Tier16:monkbrewmaster:m" },
				{ 17, "Tier16:monkmistweaver:m" },
				{ 18, "Tier16:monkwindwalker:m" },
				{ 20, "Tier16:paladinholy:m" },
				{ 21, "Tier16:paladinprotection:m" },
				{ 22, "Tier16:paladinretribution:m" },
				{ 24, "Tier16:shamanelemental:m" },
				{ 25, "Tier16:shamanenhancement:m" },
				{ 26, "Tier16:shamanrestoration:m" },
				{ 28, "Tier16:warriordps:m" },
				{ 29, "Tier16:warriorprotection:m" },
			},
		},
		{	-- Tier 15 Sets
			name = format(AL["Tier %d Sets"], 15),
			[RF_DIFF] = {
				{ 1, "Tier15:hunter:rf" },
				{ 2, "Tier15:mage:rf" },
				{ 3, "Tier15:rogue:rf" },
				{ 4, "Tier15:warlock:rf" },
				{ 6, "Tier15:deathknightblood:rf" },
				{ 7, "Tier15:deathknightdps:rf" },
				{ 9, "Tier15:druidbalance:rf" },
				{ 10, "Tier15:druidferal:rf" },
				{ 11, "Tier15:druidguardian:rf" },
				{ 12, "Tier15:druidrestoration:rf" },
				{ 14, "Tier15:priestheal:rf" },
				{ 15, "Tier15:priestshadow:rf" },
				{ 16, "Tier15:monkbrewmaster:rf" },
				{ 17, "Tier15:monkmistweaver:rf" },
				{ 18, "Tier15:monkwindwalker:rf" },
				{ 20, "Tier15:paladinholy:rf" },
				{ 21, "Tier15:paladinprotection:rf" },
				{ 22, "Tier15:paladinretribution:rf" },
				{ 24, "Tier15:shamanelemental:rf" },
				{ 25, "Tier15:shamanenhancement:rf" },
				{ 26, "Tier15:shamanrestoration:rf" },
				{ 28, "Tier15:warriordps:rf" },
				{ 29, "Tier15:warriorprotection:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1, "Tier15:hunter:n" },
				{ 2, "Tier15:mage:n" },
				{ 3, "Tier15:rogue:n" },
				{ 4, "Tier15:warlock:n" },
				{ 6, "Tier15:deathknightblood:n" },
				{ 7, "Tier15:deathknightdps:n" },
				{ 9, "Tier15:druidbalance:n" },
				{ 10, "Tier15:druidferal:n" },
				{ 11, "Tier15:druidguardian:n" },
				{ 12, "Tier15:druidrestoration:n" },
				{ 14, "Tier15:priestheal:n" },
				{ 15, "Tier15:priestshadow:n" },
				{ 16, "Tier15:monkbrewmaster:n" },
				{ 17, "Tier15:monkmistweaver:n" },
				{ 18, "Tier15:monkwindwalker:n" },
				{ 20, "Tier15:paladinholy:n" },
				{ 21, "Tier15:paladinprotection:n" },
				{ 22, "Tier15:paladinretribution:n" },
				{ 24, "Tier15:shamanelemental:n" },
				{ 25, "Tier15:shamanenhancement:n" },
				{ 26, "Tier15:shamanrestoration:n" },
				{ 28, "Tier15:warriordps:n" },
				{ 29, "Tier15:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1, "Tier15:hunter:h" },
				{ 2, "Tier15:mage:h" },
				{ 3, "Tier15:rogue:h" },
				{ 4, "Tier15:warlock:h" },
				{ 6, "Tier15:deathknightblood:h" },
				{ 7, "Tier15:deathknightdps:h" },
				{ 9, "Tier15:druidbalance:h" },
				{ 10, "Tier15:druidferal:h" },
				{ 11, "Tier15:druidguardian:h" },
				{ 12, "Tier15:druidrestoration:h" },
				{ 14, "Tier15:priestheal:h" },
				{ 15, "Tier15:priestshadow:h" },
				{ 16, "Tier15:monkbrewmaster:h" },
				{ 17, "Tier15:monkmistweaver:h" },
				{ 18, "Tier15:monkwindwalker:h" },
				{ 20, "Tier15:paladinholy:h" },
				{ 21, "Tier15:paladinprotection:h" },
				{ 22, "Tier15:paladinretribution:h" },
				{ 24, "Tier15:shamanelemental:h" },
				{ 25, "Tier15:shamanenhancement:h" },
				{ 26, "Tier15:shamanrestoration:h" },
				{ 28, "Tier15:warriordps:h" },
				{ 29, "Tier15:warriorprotection:h" },
			},
		},
		{	-- Tier 14 Sets
			name = format(AL["Tier %d Sets"], 14),
			[RF_DIFF] = {
				{ 1, "Tier14:hunter:rf" },
				{ 2, "Tier14:mage:rf" },
				{ 3, "Tier14:rogue:rf" },
				{ 4, "Tier14:warlock:rf" },
				{ 6, "Tier14:deathknightblood:rf" },
				{ 7, "Tier14:deathknightdps:rf" },
				{ 9, "Tier14:druidbalance:rf" },
				{ 10, "Tier14:druidferal:rf" },
				{ 11, "Tier14:druidguardian:rf" },
				{ 12, "Tier14:druidrestoration:rf" },
				{ 14, "Tier14:priestheal:rf" },
				{ 15, "Tier14:priestshadow:rf" },
				{ 16, "Tier14:monkbrewmaster:rf" },
				{ 17, "Tier14:monkmistweaver:rf" },
				{ 18, "Tier14:monkwindwalker:rf" },
				{ 20, "Tier14:paladinholy:rf" },
				{ 21, "Tier14:paladinprotection:rf" },
				{ 22, "Tier14:paladinretribution:rf" },
				{ 24, "Tier14:shamanelemental:rf" },
				{ 25, "Tier14:shamanenhancement:rf" },
				{ 26, "Tier14:shamanrestoration:rf" },
				{ 28, "Tier14:warriordps:rf" },
				{ 29, "Tier14:warriorprotection:rf" },
			},
			[NORMAL_DIFF] = {
				{ 1, "Tier14:hunter:n" },
				{ 2, "Tier14:mage:n" },
				{ 3, "Tier14:rogue:n" },
				{ 4, "Tier14:warlock:n" },
				{ 6, "Tier14:deathknightblood:n" },
				{ 7, "Tier14:deathknightdps:n" },
				{ 9, "Tier14:druidbalance:n" },
				{ 10, "Tier14:druidferal:n" },
				{ 11, "Tier14:druidguardian:n" },
				{ 12, "Tier14:druidrestoration:n" },
				{ 14, "Tier14:priestheal:n" },
				{ 15, "Tier14:priestshadow:n" },
				{ 16, "Tier14:monkbrewmaster:n" },
				{ 17, "Tier14:monkmistweaver:n" },
				{ 18, "Tier14:monkwindwalker:n" },
				{ 20, "Tier14:paladinholy:n" },
				{ 21, "Tier14:paladinprotection:n" },
				{ 22, "Tier14:paladinretribution:n" },
				{ 24, "Tier14:shamanelemental:n" },
				{ 25, "Tier14:shamanenhancement:n" },
				{ 26, "Tier14:shamanrestoration:n" },
				{ 28, "Tier14:warriordps:n" },
				{ 29, "Tier14:warriorprotection:n" },
			},
			[HEROIC_DIFF] = {
				{ 1, "Tier14:hunter:h" },
				{ 2, "Tier14:mage:h" },
				{ 3, "Tier14:rogue:h" },
				{ 4, "Tier14:warlock:h" },
				{ 6, "Tier14:deathknightblood:h" },
				{ 7, "Tier14:deathknightdps:h" },
				{ 9, "Tier14:druidbalance:h" },
				{ 10, "Tier14:druidferal:h" },
				{ 11, "Tier14:druidguardian:h" },
				{ 12, "Tier14:druidrestoration:h" },
				{ 14, "Tier14:priestheal:h" },
				{ 15, "Tier14:priestshadow:h" },
				{ 16, "Tier14:monkbrewmaster:h" },
				{ 17, "Tier14:monkmistweaver:h" },
				{ 18, "Tier14:monkwindwalker:h" },
				{ 20, "Tier14:paladinholy:h" },
				{ 21, "Tier14:paladinprotection:h" },
				{ 22, "Tier14:paladinretribution:h" },
				{ 24, "Tier14:shamanelemental:h" },
				{ 25, "Tier14:shamanenhancement:h" },
				{ 26, "Tier14:shamanrestoration:h" },
				{ 28, "Tier14:warriordps:h" },
				{ 29, "Tier14:warriorprotection:h" },
			},
		},
	},
}

data["TABARDS"] = {
	name = AL["Tabards"],
	ContentType = OLD_COLLECTION_CONTENT,
	TableType = I_A_ITTYPE,
	items = {
		{
			name = AL["Factions"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 45579, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Darnassus Tabard
				{ 2, 45577, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Ironforge Tabard
				{ 3, 45578, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Gnomeregan Tabard
				{ 4, 45574, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Stormwind Tabard
				{ 16, 45580, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Exodar Tabard
				{ 17, 64882, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Gilneas Tabard
				{ 18, 83079, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Tushui Tabard
			},
			[HORDE_DIFF] = { --ALLIANCE_DIFF
				{ 1, 45582, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Darkspear Tabard
				{ 2, 45581, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Orgrimmar Tabard
				{ 3, 45584, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Thunder Bluff Tabard
				{ 4, 45583, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Undercity Tabard
				{ 16, 45585, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Silvermoon City Tabard
				{ 17, 64884, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Bilgewater Cartel Tabard
				{ 18, 83080, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Huojin Tabard
			},
		},
		{
			name = AL["Guild"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 5976, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Guild Tabard	-- NEUTRAL
				{ 3, 69209, [PRICE_EXTRA_ITTYPE] = "money:1250000" }, -- Illustrious Guild Tabard -- NEUTRAL
				{ 18, 69210, [PRICE_EXTRA_ITTYPE] = "money:2500000" }, -- Guild Tabard	-- NEUTRAL
			},
			[HORDE_DIFF] = ALLIANCE_DIFF
		},
		{
			name = AL["Warlords of Draenor"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 119136, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Arakkoa Outcasts Tabard	-- NEUTRAL
				{ 2, 119137, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Steamwheedle "Preservation" Society Tabard	-- NEUTRAL
				{ 16, 119135, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Council of Exarchs Tabard
				{ 17, 119140, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Sha'tari Defense Tabard
				{ 18, 115517, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Wrynn's Vanguard Tabard
			},
			[HORDE_DIFF] = { --ALLIANCE_DIFF
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 119133, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Frostwolf Tabard
				{ 17, 119138, [PRICE_EXTRA_ITTYPE] = "money:1000000" }, -- Laughing Skull Orcs Tabard
				{ 18, 115518, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Vol'jin's Spear Tabard
			},
		},
		{
			name = AL["Mists of Pandaria"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 89401, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Anglers Tabard	-- NEUTRAL
				{ 2, 89799, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- August Celestials Tabard	-- NEUTRAL
				{ 3, 89797, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Golden Lotus Tabard	-- NEUTRAL
				{ 4, 89798, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Klaxxi Tabard	-- NEUTRAL
				{ 5, 89795, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Lorewalkers Tabard	-- NEUTRAL
				{ 6, 89796, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Order of the Cloud Serpent Tabard	-- NEUTRAL
				{ 7, 89800, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Shado-Pan Tabard	-- NEUTRAL
				{ 8, 97131, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Shado-Pan Assault Tabard	-- NEUTRAL
				{ 9, 89784, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Tillers Tabard	-- NEUTRAL
				{ 16, 95591, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Kirin Tor Offensive Tabard
			},
			[HORDE_DIFF] = { --ALLIANCE_DIFF
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 95592, [PRICE_EXTRA_ITTYPE] = "money:100000" }, -- Sunreaver Onslaught Tabard
			},
		},
		{
			name = AL["Cataclysm"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 65904, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of Ramkahen	-- NEUTRAL
				{ 2, 65905, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Earthen Ring	-- NEUTRAL
				{ 3, 65906, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Guardians of Hyjal	-- NEUTRAL
				{ 4, 65907, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of Therazane	-- NEUTRAL
				{ 16, 63379, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" }, -- Baradin's Wardens Tabard
				{ 17, 65908, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Wildhammer Clan
			},
			[HORDE_DIFF] = { --ALLIANCE_DIFF
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 63378, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" }, -- Hellscream's Reach Tabard
				{ 17, 65909, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Dragonmaw Clan
			},
		},
		{
			name = AL["Wrath of the Lich King"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 43155, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Ebon Blade	-- NEUTRAL
				{ 2, 43157, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Kirin Tor	-- NEUTRAL
				{ 3, 43156, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Wyrmrest Accord	-- NEUTRAL
			},
			[HORDE_DIFF] = ALLIANCE_DIFF,
		},
		{
			name = AL["Burning Crusade"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 31779, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Aldor Tabard	-- NEUTRAL
				{ 2, 31780, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Scryers Tabard	-- NEUTRAL
				{ 4, 31804, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Cenarion Expedition Tabard	-- NEUTRAL
				{ 5, 31776, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Consortium Tabard	-- NEUTRAL
				{ 6, 31777, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Keepers of Time Tabard	-- NEUTRAL
				{ 7, 31778, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Lower City Tabard	-- NEUTRAL
				{ 8, 32828, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Ogri'la Tabard	-- NEUTRAL
				{ 9, 31781, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Sha'tar Tabard	-- NEUTRAL
				{ 10, 32445, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Skyguard Tabard	-- NEUTRAL
				{ 11, 31775, [PRICE_EXTRA_ITTYPE] = "24245:10" }, -- Sporeggar Tabard	-- NEUTRAL
				{ 12, 35221, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Shattered Sun	-- NEUTRAL
				{ 16, 23999, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Honor Hold Tabard
				{ 17, 31774, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Honor Hold Tabard
			},
			[HORDE_DIFF] = { --ALLIANCE_DIFF
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 24004, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Thrallmar Tabard
				{ 17, 31773, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Mag'har Tabard
			},
		},
		{
			name = AL["Classic"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 43154, [PRICE_EXTRA_ITTYPE] = "money:10000" }, -- Tabard of the Argent Crusade	-- NEUTRAL
			},
			[HORDE_DIFF] = ALLIANCE_DIFF
		},
		{
			name = AL["Achievement & Quest Rewards"],
			CoinTexture = "Achievement",
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 43300, 7520 }, -- Loremaster's Colors	-- NEUTRAL
				{ 2, 43349, 876 }, -- Tabard of Brute Force	-- NEUTRAL
				{ 3, 40643, 1021 }, -- Tabard of the Achiever	-- NEUTRAL
				{ 4, 43348, 45 }, -- Tabard of the Explorer	-- NEUTRAL
				{ 6, 49052, 3857 }, -- Tabard of Conquest
				{ 16, 24344, [QUEST_EXTRA_ITTYPE] = 9762 }, -- Tabard of the Hand
				{ 18, 35280, [QUEST_EXTRA_ITTYPE] = 11972 }, -- Tabard of Summer Flames
				{ 19, 35279, [QUEST_EXTRA_ITTYPE] = 11972 }, -- Tabard of Summer Skies
				{ 21, 31405, [QUEST_EXTRA_ITTYPE] = 10781 }, -- Purple Trophy Tabard of the Illidari
				{ 22, 31404, [QUEST_EXTRA_ITTYPE] = 10781 }, -- Green Trophy Tabard of the Illidari
				{ 24, 86468, [QUEST_EXTRA_ITTYPE] = 31820 }, -- Apron	-- NEUTRAL
			},
			[HORDE_DIFF] = { --ALLIANCE_DIFF
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 6, 49054, 3957 }, -- Tabard of Conquest
				{ 16, 25549, [QUEST_EXTRA_ITTYPE] = 28473 }, -- Blood Knight Tabard
			},
		},
		{
			name = AL["Argent Tournament"],
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 46874, [PRICE_EXTRA_ITTYPE] = "champseal:50" }, -- Argent Crusader's Tabard	-- NEUTRAL
				{ 3, 45579, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Darnassus Tabard
				{ 4, 45577, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Ironforge Tabard
				{ 5, 45578, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Gnomeregan Tabard
				{ 6, 45574, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Stormwind Tabard
				{ 16, 46817, [PRICE_EXTRA_ITTYPE] = "champseal:50" }, -- Silver Covenant Tabard
				{ 18, 45580, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Exodar Tabard
				{ 19, 64882, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Gilneas Tabard
				{ 20, 83079, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Tushui Tabard
			},
			[HORDE_DIFF] = { --ALLIANCE_DIFF
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 16, 46818, [PRICE_EXTRA_ITTYPE] = "champseal:50" }, -- Sunreaver Tabard
				{ 3, 45582, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Darkspear Tabard
				{ 4, 45581, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Orgrimmar Tabard
				{ 5, 45584, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Thunder Bluff Tabard
				{ 6, 45583, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Undercity Tabard
				{ 18, 45585, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Silvermoon City Tabard
				{ 19, 64884, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Bilgewater Cartel Tabard
				{ 20, 83080, [PRICE_EXTRA_ITTYPE] = "money:1000" }, -- Huojin Tabard
			},
		},
		{
			name = AL["PvP"],
			[ALLIANCE_DIFF] = { --HORDE_DIFF
				{ 1, 115972, [PRICE_EXTRA_ITTYPE] = "conquest:1000" }, -- Primal Gladiator's Tabard
				{ 3, 15196, [PRICE_EXTRA_ITTYPE] = "honor:50" }, -- Private's Tabard
				{ 4, 15198, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Knight's Colors
				{ 18, 19506, [PRICE_EXTRA_ITTYPE] = "honor:2059" }, -- Silverwing Battle Tabard
				{ 19, 19032, [PRICE_EXTRA_ITTYPE] = "honor:2679" }, -- Stormpike Battle Tabard
				
			},
			[HORDE_DIFF] = { --ALLIANCE_DIFF
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 3, 15197, [PRICE_EXTRA_ITTYPE] = "honor:50" }, -- Scout's Tabard
				{ 4, 15199, [PRICE_EXTRA_ITTYPE] = "honor:100" }, -- Stone Guard's Herald
				{ 18, 19505, [PRICE_EXTRA_ITTYPE] = "honor:2059" }, -- Warsong Battle Tabard
				{ 19, 19031, [PRICE_EXTRA_ITTYPE] = "honor:2679" }, -- Frostwolf Battle Tabard
			},
		},
		{
			name = AL["Unobtainable Tabards"],
			[NORMAL_DIFF] = {
				{ 1, 19160 }, -- Contest Winner's Tabard
				{ 3, 36941, 1636 }, -- Competitor's Tabard
				{ 4, 89196, 7467 }, -- Theramore Tabard
				{ 5, 22999, 2116 }, -- Tabard of the Argent Dawn
				{ 6, 28788, 2079 }, -- Tabard of the Protector
				{ 8, "ICON_achievement_featsofstrength_gladiator_10", nil, AL["Arena Reward"], nil },
				{ 9, 45983 }, -- Furious Gladiator's Tabard
				{ 10, 49086, }, -- Relentless Gladiator's Tabard
				{ 11, 51534 }, -- Wrathful Gladiator's Tabard
				{ 12, 98162 }, -- Tyrannical Gladiator's Tabard
				{ 13, 101697 }, -- Grievous Gladiator's Tabard
				{ 16, "INV_Box_01", nil, AL["Card Game Tabards"], nil },
				{ 17, 38312 }, -- Tabard of Brilliance
				{ 18, 23705 }, -- Tabard of Flame
				{ 19, 23709 }, -- Tabard of Frost
				{ 20, 38313 }, -- Tabard of Fury
				{ 21, 38309 }, -- Tabard of Nature
				{ 22, 38310 }, -- Tabard of the Arcane
				{ 23, 38314 }, -- Tabard of the Defender
				{ 24, 38311 }, -- Tabard of the Void
			},
		},
	},
}