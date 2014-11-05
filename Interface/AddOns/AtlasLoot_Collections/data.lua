local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname)

local AL = AtlasLoot.Locales

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], nil, nil, 17)
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"])
local HEROIC_PRE_DIFF = data:AddDifficulty(AL["Heroic"], "heroicWithPreset", {
	Item = {
		item1bonus = "HeroicRaid",
		item2bonus = "HeroicRaidWarforged",
		autoCompleteItem2 = true,
	},
}, 15)
local MYTHIC_PRE_DIFF = data:AddDifficulty(AL["Mythic"], "myhticWithPreset", {
	Item = {
		item1bonus = "MythicRaid",
		item2bonus = "MythicRaidWarforged",
		autoCompleteItem2 = true,
	},
}, 16)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local RAID_ITTYPE = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local COLLECTION_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTION_COLOR)

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

data["TIER17SETS"] = {
	name = string.format(AL["Tier %d Sets"], 17),
	ContentType = COLLECTION_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			[NORMAL_DIFF] = {
				{ 1, 115539 },	-- Ogreskull Boneplate Greathelm
				{ 2, 115536 },	-- Ogreskull Boneplate Pauldrons
				{ 3, 115537 },	-- Ogreskull Boneplate Breastplate
				{ 4, 115538 },	-- Ogreskull Boneplate Gauntlets
				{ 5, 115535 },	-- Ogreskull Boneplate Greaves
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			[NORMAL_DIFF] = {
				{ 1, 115542 },	-- Living Wood Headpiece
				{ 2, 115544 },	-- Living Wood Spaulders
				{ 3, 115540 },	-- Living Wood Raiment
				{ 4, 115541 },	-- Living Wood Grips
				{ 5, 115543 },	-- Living Wood Legguards
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			[NORMAL_DIFF] = {
				{ 1, 115545 },	-- Rylakstalker's Headguard
				{ 2, 115547 },	-- Rylakstalker's Spaulders
				{ 3, 115548 },	-- Rylakstalker's Tunic
				{ 4, 115549 },	-- Rylakstalker's Gloves
				{ 5, 115546 },	-- Rylakstalker's Legguards
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			[NORMAL_DIFF] = {
				{ 1, 115553 },	-- Arcanoshatter Hood
				{ 2, 115551 },	-- Arcanoshatter Mantle
				{ 3, 115550 },	-- Arcanoshatter Robes
				{ 4, 115552 },	-- Arcanoshatter Gloves
				{ 5, 115554 },	-- Arcanoshatter Leggings
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"],
			[NORMAL_DIFF] = {
				{ 1, 115556 },	-- Helm of the Somber Gaze
				{ 2, 115559 },	-- Mantle of the Somber Gaze
				{ 3, 115558 },	-- Vest of the Somber Gaze
				{ 4, 115555 },	-- Handwraps of the Somber Gaze
				{ 5, 115557 },	-- Legwraps of the Somber Gaze
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			[NORMAL_DIFF] = {
				{ 1, 115568 },	-- Helmet of Guiding Light
				{ 2, 115565 },	-- Pauldrons of Guiding Light
				{ 3, 115566 },	-- Battleplate of Guiding Light
				{ 4, 115567 },	-- Gauntlets of Guiding Light
				{ 5, 115569 },	-- Legplates of Guiding Light
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			[NORMAL_DIFF] = {
				{ 1, 115563 },	-- Soul Priest's Hood
				{ 2, 115561 },	-- Soul Priest's Shoulderguards
				{ 3, 115560 },	-- Soul Priest's Raiment
				{ 4, 115562 },	-- Soul Priest's Gloves
				{ 5, 115564 },	-- Soul Priest's Leggings
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			[NORMAL_DIFF] = {
				{ 1, 115572 },	-- Poisoner's Helmet
				{ 2, 115574 },	-- Poisoner's Spaulders
				{ 3, 115570 },	-- Poisoner's Tunic
				{ 4, 115571 },	-- Poisoner's Gloves
				{ 5, 115573 },	-- Poisoner's Legguards
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			[NORMAL_DIFF] = {
				{ 1, 115579 },	-- Windspeaker's Faceguard
				{ 2, 115576 },	-- Windspeaker's Mantle
				{ 3, 115577 },	-- Windspeaker's Tunic
				{ 4, 115578 },	-- Windspeaker's Handwraps
				{ 5, 115575 },	-- Windspeaker's Legwraps
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			[NORMAL_DIFF] = {
				{ 1, 115586 },	-- Shadow Council's Hood
				{ 2, 115589 },	-- Shadow Council's Mantle
				{ 3, 115588 },	-- Shadow Council's Robes
				{ 4, 115585 },	-- Shadow Council's Gloves
				{ 5, 115587 },	-- Shadow Council's Leggings
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			[NORMAL_DIFF] = {
				{ 1, 115584 },	-- Blackhand's Faceguard
				{ 2, 115581 },	-- Blackhand's Shoulderguards
				{ 3, 115582 },	-- Blackhand's Chestguard
				{ 4, 115583 },	-- Blackhand's Handguards
				{ 5, 115580 },	-- Blackhand's Legguards
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{
			name = AL["Raid Finder"].." "..AL["Sets"],
			[RF_DIFF] = {
				{ 1, 120373 },	-- Ebonflame Hood
				{ 2, 120376 },	-- Ebonflame Spaulders
				{ 3, 120375 },	-- Ebonflame Robes
				{ 4, 120374 },	-- Ebonflame Grips
				{ 5, 120377 },	-- Ebonflame Leggings
				{ 6, 120378 },	-- Ebonflame Sandals
				{ 8, 120382 },	-- Sootfur Cap
				{ 9, 120381 },	-- Sootfur Shoulderguards
				{ 10, 120380 },	-- Sootfur Harness
				{ 11, 120384 },	-- Sootfur Gauntlets
				{ 12, 120379 },	-- Sootfur Legwraps
				{ 13, 120383 },	-- Sootfur Stompers
				{ 16, 120390 },	-- Ashlink Coif
				{ 17, 120388 },	-- Ashlink Pauldrons
				{ 18, 120389 },	-- Ashlink Hauberk
				{ 19, 120386 },	-- Ashlink Gloves
				{ 20, 120385 },	-- Ashlink Legguards
				{ 21, 120387 },	-- Ashlink Treads
				{ 23, 120396 },	-- Blacksteel Casque
				{ 24, 120395 },	-- Blacksteel Shoulderplates
				{ 25, 120393 },	-- Blacksteel Chestplate
				{ 26, 120392 },	-- Blacksteel Gauntlets
				{ 27, 120391 },	-- Blacksteel Legplates
				{ 28, 120394 },	-- Blacksteel Greatboots
			},
		},
	},
}