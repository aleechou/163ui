local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"])
local ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
local HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")

local FACTION_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)

data["WODFACTIONS"] = {
	name = AL["Warlords of Draenor"],
	ContentType = FACTION_CONTENT,
	items = {
		{	--ArakkoaOutcasts
			FactionID = 1515,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1515rep5" },
				{ 2, 118666, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Arakkoa Elixir
				{ 4, "f1515rep6" },
				{ 5, 118682, [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Saberon Protector
				{ 7, "f1515rep7" },
				{ 8, 119143, "pet1574", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Son of Sethe
				{ 9, 118698, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Wings of the Outcasts
				{ 16, "f1515rep8" },
				{ 17, 116772, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Shadowmane Charger
				{ 18, 119136, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Arakkoa Outcasts Tabard
				{ 19, 117389, [PRICE_EXTRA_ITTYPE] = "87399:1" },	-- Draenor Archaeologist's Lodestone
				{ 20, 117390, [PRICE_EXTRA_ITTYPE] = "87399:1" },	-- Draenor Archaeologist's Map
			},
		},
		{	--CouncilofExarchs
			FactionID = 1731,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1731rep5" },
				{ 2, 118665, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Exarch Elixir
				{ 4, "f1731rep6" },
				{ 5, 115472, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Permanent Time Bubble
				{ 6, 118680, [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Tranquility of the Exarchs
				{ 8, "f1731rep7" },
				{ 9, 118663, [PRICE_EXTRA_ITTYPE] = "money:25000000" },	-- Relic of Karabor
				{ 10, 119142, "pet1450", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Draenei Micro Defender
				{ 11, 119162, [PRICE_EXTRA_ITTYPE] = "money:50000000" },	-- Contract: Cleric Maluuf
				{ 16, "f1731rep8" },
				{ 17, 116664, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Dusty Rockhide
				{ 18, 119135, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Council of Exarchs Tabard
			},
		},
		{	--FrostwolfOrcs
			FactionID = 1445,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1445rep5" },
				{ 2, 118664, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Frostwolf Elixir
				{ 4, "f1445rep6" },
				{ 5, 118677, [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Howl of the Frostwolf
				{ 6, 115468, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Permanent Frost Essence
				{ 8, "f1445rep7" },
				{ 9, 118662, [PRICE_EXTRA_ITTYPE] = "money:25000000" },	-- Bladespire Relic
				{ 10, 119141, "pet1542", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Frostwolf Pup
				{ 11, 119161, [PRICE_EXTRA_ITTYPE] = "money:50000000" },	-- Contract: Karg Bloodfury
				{ 16, "f1445rep8" },
				{ 17, 116785, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Swift Frostwolf
				{ 18, 119133, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Frostwolf Tabard
			},
		},
		{	--LaughingSkullOrcs
			FactionID = 1708,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1708rep5" },
				{ 2, 118668, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Laughing Skull Elixir
				{ 3, 119159, [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Happy Fun Skull
				{ 5, "f1708rep6" },
				{ 6, 118684, [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Maniacal Grimace
				{ 7, 119160, [PRICE_EXTRA_ITTYPE] = "money:12500000" },	-- Tickle Totem
				{ 9, "f1708rep7" },
				{ 10, 119146, "pet1458", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Bone Wasp
				{ 11, 118672, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },	-- Bloody Visage of the Laughing Skul
				{ 12, 118671, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },	-- Frozen Visage of the Laughing Skull
				{ 13, 118674, [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:1000" },	-- Visage of the Laughing Skull
				{ 14, 119166, [PRICE_EXTRA_ITTYPE] = "money:50000000" },	-- Contract: Cacklebone
				{ 16, "f1708rep8" },
				{ 17, 118673, [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:1000" },	-- Golden Visage of the Laughing Skull
				{ 18, 116782, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Ironside Warwolf
				{ 19, 119138, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Laughing Skull Orcs Tabard
			},
		},
		{	--ShatariDefense
			FactionID = 1710,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1710rep5" },
				{ 2, 118669, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Sha'tari Elixir
				{ 4, "f1710rep6" },
				{ 5, 118685, [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Sha'tari Protector
				{ 6, 119182, [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Soul Evacuation Crystal
				{ 8, "f1710rep8" },
				{ 9, 116665, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Armored Irontusk
				{ 10, 119140, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Sha'tari Defense Tabard
				{ 16, "f1710rep7" },
				{ 17, 119421 },	-- Sha'tari Defender's Medallion
				{ 18, 119428, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Greathelm of the Sha'tari Defense
				{ 19, 119427, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Shoulderguards of the Sha'tari Defense
				{ 20, 119422, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Breastplate of the Sha'tari Defense
				{ 21, 119429, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Bracers of the Sha'tari Defense
				{ 22, 119426, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Gauntlets of the Sha'tari Defense
				{ 23, 119425, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Belt of the Sha'tari Defense
				{ 24, 119424, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Legplates of the Sha'tari Defense
				{ 25, 119423, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Boots of the Sha'tari Defense
				{ 26, 119167, [PRICE_EXTRA_ITTYPE] = "money:50000000" },	-- Contract: Vindicator Heluun
			},
		},
		{	--SteamwheedlePreservationSociety
			FactionID = 1711,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1711rep5" },
				{ 2, 118667, [PRICE_EXTRA_ITTYPE] = "money:50000:apexis:1" },	-- Steamwheedle Elixir
				{ 4, "f1711rep6" },
				{ 5, 118683, [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Portable Goon Squad
				{ 6, 110426, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Goblin Hot Potato
				{ 8, "f1711rep7" },
				{ 9, 119149, "pet1430", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Captured Forest Sproutling
				{ 10, 119148, "pet1571", [PRICE_EXTRA_ITTYPE] = "money:10000000:apexis:2000" },	-- Indentured Albino River Calf
				{ 11, 119165, [PRICE_EXTRA_ITTYPE] = "money:50000000" },	-- Contract: Professor Felblast
				{ 16, "f1711rep8" },
				{ 17, 116672, "mount", [PRICE_EXTRA_ITTYPE] = "money:50000000:apexis:5000" },	-- Domesticated Razorback
				{ 18, 119137, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Steamwheedle "Preservation" Society Tabard
			},
		},
		{	--VoljinsSpear
			FactionID = 1681,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1681rep5" },
				{ 2, 115500, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Disposable Pocket Flying Machine
				{ 3, 115514, [PRICE_EXTRA_ITTYPE] = "artifactfragment:50" },	-- Vol'jin's Spear Battle Standard
				{ 4, 120049, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Adaptation
				{ 6, "f1681rep6" },
				{ 7, 116397, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Swift Riding Crop
				{ 8, 116398, [PRICE_EXTRA_ITTYPE] = "artifactfragment:20" },	-- Flimsy X-Ray Goggles
				{ 10, "f1681rep8" },
				{ 11, 116775, "mount", [PRICE_EXTRA_ITTYPE] = "money:40000000:apexis:5000" },	-- Breezestrider Stallion
				{ 12, 115518, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Vol'jin's Spear Tabard
				{ 16, "f1681rep7" },
				{ 17, 115505, [PRICE_EXTRA_ITTYPE] = "artifactfragment:500" },	-- LeBlanc's Recorder
				{ 18, 111089, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Cowl of Cruelty
				{ 19, 111092, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Mantle of Cruelty
				{ 20, 111091, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Raiment of Cruelty
				{ 21, 111101, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cuffs of Victory
				{ 22, 111088, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Handguards of Cruelty
				{ 23, 111095, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cord of Victory
				{ 24, 111090, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Trousers of Cruelty
				{ 25, 111098, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Treads of Victory
				{ 26, 111285, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Headcover
				{ 27, 111287, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pauldrons
				{ 28, 111283, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chestguard
				{ 29, 111149, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Bindings of Victory
				{ 30, 111284, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Grips
				{ 101, "f1681rep7" },
				{ 102, 111143, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Belt of Victory
				{ 103, 111286, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 104, 111146, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Boots of Victory
				{ 105, 111290, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Coif
				{ 106, 111292, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pauldrons
				{ 107, 111288, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chestguard
				{ 108, 111163, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armbands of Victory
				{ 109, 111289, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gloves
				{ 110, 111157, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Waistguard of Victory
				{ 111, 111291, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 112, 111160, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Footguards of Victory
				{ 113, 111216, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Visor
				{ 114, 111218, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Pauldrons
				{ 115, 111214, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestguard
				{ 116, "f1681rep7" },
				{ 117, 111182, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armplates of Victory
				{ 118, 111215, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Grips
				{ 119, 111176, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Girdle of Victory
				{ 120, 111217, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Leggings
				{ 121, 111179, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Warboots of Victory
				{ 123, 115495, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Adaptation
			},
		},
		{	--WrynnsVanguard
			FactionID = 1682,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1682rep5" },
				{ 2, 114126, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Disposable Pocket Flying Machine
				{ 3, 115513, [PRICE_EXTRA_ITTYPE] = "artifactfragment:50" },	-- Wrynn's Vanguard Battle Standard
				{ 4, 115521, [PRICE_EXTRA_ITTYPE] = "honor:1750" },	-- Primal Combatant's Badge of Adaptation
				{ 6, "f1682rep6" },
				{ 7, 115522, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Swift Riding Crop
				{ 8, 115532, [PRICE_EXTRA_ITTYPE] = "artifactfragment:20" },	-- Flimsy X-Ray Goggles
				{ 10, "f1682rep8" },
				{ 11, 116776, "mount", [PRICE_EXTRA_ITTYPE] = "money:40000000:apexis:5000" },	-- Pale Thorngrazer
				{ 12, 115517, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Wrynn's Vanguard Tabard
				{ 16, "f1682rep7" },
				{ 17, 116396, [PRICE_EXTRA_ITTYPE] = "artifactfragment:500" },	-- LeBlanc's Recorder
				{ 18, 115616, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Cowl of Cruelty
				{ 19, 115619, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Mantle of Cruelty
				{ 20, 115618, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Raiment of Cruelty
				{ 21, 115628, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Cuffs of Victory
				{ 22, 115615, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Handguards of Cruelty
				{ 23, 115622, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Cord of Victory
				{ 24, 115617, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Trousers of Cruelty
				{ 25, 115625, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Treads of Victory
				{ 26, 115785, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Headcover
				{ 27, 115787, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pauldrons
				{ 28, 115783, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chestguard
				{ 29, 115676, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Bindings of Victory
				{ 30, 115784, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Grips
				{ 101, "f1682rep7" },
				{ 102, 115670, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Belt of Victory
				{ 103, 115786, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 104, 115673, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Boots of Victory
				{ 105, 115790, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Coif
				{ 106, 115792, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Pauldrons
				{ 107, 115788, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Chestguard
				{ 108, 115690, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armbands of Victory
				{ 109, 115789, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Gloves
				{ 110, 115684, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Waistguard of Victory
				{ 111, 115791, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Leggings
				{ 112, 115687, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Footguards of Victory
				{ 113, 115743, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Visor
				{ 114, 115745, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Pauldrons
				{ 115, 115741, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Chestguard
				{ 116, "f1682rep7" },
				{ 117, 115709, [PRICE_EXTRA_ITTYPE] = "conquest:1250" },	-- Primal Gladiator's Armplates of Victory
				{ 118, 115742, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Plate Grips
				{ 119, 115703, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Girdle of Victory
				{ 120, 115744, [PRICE_EXTRA_ITTYPE] = "conquest:2250" },	-- Primal Gladiator's Plate Leggings
				{ 121, 115706, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Warboots of Victory
				{ 123, 115496, [PRICE_EXTRA_ITTYPE] = "conquest:1750" },	-- Primal Gladiator's Badge of Adaptation
			},
		},
	},
}

data["MOPFACTIONS"] = {
	name = AL["Mists of Pandaria"],
	ContentType = FACTION_CONTENT,
	items = {
		{	--DominanceOffensive
			FactionID = 1375,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1375rep7" },
				{ 2, 93232, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Dominance Offensive
				{ 16, "f1375rep8" },
				{ 17, 93169, "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" },	-- Grand Armored Wyvern
			},
		},
		{	--EmperorShaohao
			FactionID = 1492,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1492rep5" },
				{ 2, 103683, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },	-- Mask of Anger
				{ 3, 103681, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },	-- Mask of Doubt
				{ 4, 103679, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },	-- Mask of Fear
				{ 5, 103680, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },	-- Mask of Hatred
				{ 6, 103682, [PRICE_EXTRA_ITTYPE] = "timelesscoin:100" },	-- Mask of Violence
				{ 8, "f1492rep6" },
				{ 9, 103678, [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },	-- Time-Lost Artifact
				{ 10, 103684, [PRICE_EXTRA_ITTYPE] = "timelesscoin:500" },	-- Scroll of Challenge
				{ 16, "f1492rep7" },
				{ 17, 103685, [PRICE_EXTRA_ITTYPE] = "timelesscoin:1000" },	-- Celestial Defender's Medallion
				{ 18, 104295, "pet1346", [PRICE_EXTRA_ITTYPE] = "timelesscoin:7500" },	-- Harmonious Porcupette
				{ 20, "f1492rep8" },
				{ 21, 87774, "mount", [PRICE_EXTRA_ITTYPE] = "timelesscoin:100000" },	-- Reins of the Heavenly Golden Cloud Serpent
			},
		},
		{	--GoldenLotus
			FactionID = 1269,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1269rep6" },
				{ 2, 90615, [QUEST_EXTRA_ITTYPE] = 30639 },	-- Burning Mark of the Golden Lotus
				{ 3, 90614, [QUEST_EXTRA_ITTYPE] = 30639 },	-- Delicate Mark of the Golden Lotus
				{ 4, 90618, [QUEST_EXTRA_ITTYPE] = 30639 },	-- Durable Mark of the Golden Lotus
				{ 5, 90617, [QUEST_EXTRA_ITTYPE] = 30639 },	-- Ferocious Mark of the Golden Lotus
				{ 6, 90616, [QUEST_EXTRA_ITTYPE] = 30639 },	-- Mending Mark of the Golden Lotus
				{ 7, 86235, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Pattern: Angerhide Leg Armor (p7 575)
				{ 8, 86276, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Pattern: Ironscale Leg Armor (p7 575)
				{ 9, 86295, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Pattern: Shadowleather Leg Armor (p7 575)
				{ 10, 86237, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Chestguard of Earthen Harmony (p7 600)
				{ 11, 86273, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Gloves of Earthen Harmony (p7 600)
				{ 12, 86274, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Greyshadow Chestguard (p7 600)
				{ 13, 86275, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Greyshadow Gloves (p7 600)
				{ 14, 86278, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Lifekeeper's Robe (p7 600)
				{ 15, 86277, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Lifekeeper's Gloves (p7 600)
				{ 17, 86309, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Wildblood Vest (p7 600)
				{ 18, 86308, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Wildblood Gloves (p7 600)
				{ 20, 86376, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Pattern: Greater Cerulean Spellthread (p8 575)
				{ 21, 86375, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Pattern: Greater Pearlescent Spellthread (p8 575)
				{ 22, 86370, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Robes of Creation (p8 600)
				{ 23, 86371, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Gloves of Creation (p8 600)
				{ 24, 86368, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Spelltwister's Grand Robe (p8 600)
				{ 25, 86369, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Pattern: Spelltwister's Gloves (p8 600)
				{ 101, "f1269rep7" },
				{ 102, 90607, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Burning Robes of the Golden Lotus
				{ 103, 90609, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Mending Robes of the Golden Lotus
				{ 104, 90597, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Delicate Chestguard of the Golden Lotus
				{ 105, 90599, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Warming Chestguard of the Golden Lotus
				{ 106, 90598, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Crackling Chain of the Golden Lotus
				{ 107, 90602, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Deadeye Chain of the Golden Lotus
				{ 108, 90601, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Bonded Plate of the Golden Lotus
				{ 109, 90603, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Durable Plate of the Golden Lotus
				{ 110, 90600, [QUEST_EXTRA_ITTYPE] = 30642 },	-- Ferocious Plate of the Golden Lotus
				{ 111, 93215, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Golden Lotus
				{ 116, "f1269rep8" },
				{ 117, 90596, [QUEST_EXTRA_ITTYPE] = 30646 },	-- Burning Necklace of the Golden Lotus
				{ 118, 90593, [QUEST_EXTRA_ITTYPE] = 30646 },	-- Delicate Necklace of the Golden Lotus
				{ 119, 90594, [QUEST_EXTRA_ITTYPE] = 30646 },	-- Durable Necklace of the Golden Lotus
				{ 120, 90592, [QUEST_EXTRA_ITTYPE] = 30646 },	-- Ferocious Necklace of the Golden Lotus
				{ 121, 90595, [QUEST_EXTRA_ITTYPE] = 30646 },	-- Mending Necklace of the Golden Lotus
				{ 122, 87781, "mount", [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Reins of the Azure Riding Crane
				{ 123, 87782, "mount", [PRICE_EXTRA_ITTYPE] = "money:25000000" },	-- Reins of the Golden Riding Crane
				{ 124, 87783, "mount", [PRICE_EXTRA_ITTYPE] = "money:15000000" },	-- Reins of the Regal Riding Crane
				{ 125, 89797, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Golden Lotus Tabard
			},
		},
		{	--HuojinPandaren
			FactionID = 1352,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1352rep4" },
				{ 2, 83080, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Huojin Tabard
				{ 4, "f1352rep7" },
				{ 5, 92070, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Huojin Satchel
				{ 16, "f1352rep8" },
				{ 17, 87802, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Black Dragon Turtle
				{ 18, 87803, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Blue Dragon Turtle
				{ 19, 87804, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Brown Dragon Turtle
				{ 20, 87801, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Green Dragon Turtle
				{ 21, 87805, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Purple Dragon Turtle
				{ 22, 82811, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Red Dragon Turtle
				{ 23, 87795, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Black Dragon Turtle
				{ 24, 87796, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Blue Dragon Turtle
				{ 25, 87797, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Brown Dragon Turtle
				{ 26, 82765, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Green Dragon Turtle
				{ 27, 87799, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Purple Dragon Turtle
				{ 28, 87800, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Red Dragon Turtle
			},
		},
		{	--KirinTorOffensive
			FactionID = 1387,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1387rep5" },
				{ 2, 80433, [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Blood Spirit
				{ 3, 95489, [PRICE_EXTRA_ITTYPE] = "95491:1" },	-- Kirin Tor Offensive Insignia
				{ 4, 95490, [PRICE_EXTRA_ITTYPE] = "95491:10" },	-- Greater Kirin Tor Offensive Insignia
				{ 5, 95567, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Kirin Tor Beacon
				{ 6, 95054, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- Potion of Light Steps
				{ 8, "f1387rep7" },
				{ 9, 95545, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Kirin Tor Offensive
				{ 10, 95052, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- Arcane Propellant
				{ 11, 95055, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- Frost Rune Trap
				{ 16, "f1387rep6" },
				{ 17, 95532, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Belt of Loa Charms
				{ 18, 95527, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Pain-Binder Girdle
				{ 19, 95526, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Shan'ze Scholar's Girdle
				{ 20, 95530, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Cinch of the Dead Forest's Vigil
				{ 21, 95528, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Skumblade-Tooth Girdle
				{ 22, 95531, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Rotting Bog Cinch
				{ 23, 95534, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Skumblade Ritualist Links
				{ 24, 95529, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Girdle of Shan'ze Glory
				{ 25, 95533, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Thunder Caressed Waistguard
				{ 26, 95053, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- A Common Rock
				{ 27, 95093, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- Sleep Dust
				{ 101, "f1387rep8" },
				{ 102, 95564, "mount", [PRICE_EXTRA_ITTYPE] = "money:24000000" },	-- Reins of the Golden Primal Direhorn
				{ 103, 95589, [QUEST_EXTRA_ITTYPE] = 32599 },	-- Glorious Standard of the Kirin Tor Offensive
				{ 104, 95591, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Kirin Tor Offensive Tabard
				{ 105, 95056, [PRICE_EXTRA_ITTYPE] = "eldercharm:3" },	-- Polymorphic Key
				{ 106, 98558, [PRICE_EXTRA_ITTYPE] = "eldercharm:3" },	-- Empty Supply Crate
				{ 107, 98560, [PRICE_EXTRA_ITTYPE] = "eldercharm:15" },	-- Arcane Trove
			},
		},
		{	--OperationShieldwall
			FactionID = 1376,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1376rep7" },
				{ 2, 93231, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of Operation: Shieldwall
				{ 16, "f1376rep8" },
				{ 17, 93168, "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" },	-- Grand Armored Gryphon
			},
		},
		{	--OrderoftheCloudSerpent
			FactionID = 1271,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1271rep6" },
				{ 2, 83845, [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Design: Jade Panther (p12 600)
				{ 3, 83830, [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Design: Sunstone Panther (p12 600)
				{ 5, "f1271rep7" },
				{ 6, 83931, [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Design: Ruby Panther (p12 600)
				{ 7, 83932, [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Design: Sapphire Panther (p12 600)
				{ 8, 89222, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Cloud Ring
				{ 9, 89225, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Finish Line
				{ 10, 89227, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Floating Finish Line
				{ 11, 89224, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Floating Racing Flag
				{ 12, 89223, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Racing Flag
				{ 13, 93229, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Order of the Cloud Serpent
				{ 16, "f1271rep8" },
				{ 17, 85430, "mount", [PRICE_EXTRA_ITTYPE] = "money:24000000" },	-- Reins of the Azure Cloud Serpent
				{ 18, 85429, "mount", [PRICE_EXTRA_ITTYPE] = "money:24000000" },	-- Reins of the Golden Cloud Serpent
				{ 19, 79802, "mount", [PRICE_EXTRA_ITTYPE] = "money:24000000" },	-- Reins of the Jade Cloud Serpent
				{ 20, 89796, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Order of the Cloud Serpent Tabard
				{ 21, 83877, [PRICE_EXTRA_ITTYPE] = "money:1600000" },	-- Design: Jeweled Onyx Panther (p12 600)
			},
		},
		{	--ShadoPan
			FactionID = 1270,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1270rep6" },
				{ 2, 89302, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Stack of Bamboo
				{ 3, 89303, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Stack of Stone Blocks
				{ 4, 89301, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Stack of Wooden Boards
				{ 6, "f1270rep7" },
				{ 7, 84584, [PRICE_EXTRA_ITTYPE] = "money:400000" },	-- Formula: Enchant Weapon - Dancing Steel (p4 600)
				{ 8, 84583, [PRICE_EXTRA_ITTYPE] = "money:400000" },	-- Formula: Enchant Weapon - Jade Spirit (p4 600)
				{ 9, 84580, [PRICE_EXTRA_ITTYPE] = "money:400000" },	-- Formula: Enchant Weapon - River's Song (p4 600)
				{ 10, 93220, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Shado-Pan
				{ 16, "f1270rep8" },
				{ 17, 89307, "mount", [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Reins of the Blue Shado-Pan Riding Tiger
				{ 18, 89305, "mount", [PRICE_EXTRA_ITTYPE] = "money:12000000" },	-- Reins of the Green Shado-Pan Riding Tiger
				{ 19, 89306, "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" },	-- Reins of the Red Shado-Pan Riding Tiger
				{ 20, 87768, "mount", [QUEST_EXTRA_ITTYPE] = 31277 },	-- Reins of the Onyx Cloud Serpent
				{ 21, 89801 },	-- Replica Shado-Pan Helmet
				{ 22, 90844 },	-- Replica Shado-Pan Helmet
				{ 23, 90845 },	-- Replica Shado-Pan Helmet
				{ 24, 90846 },	-- Replica Shado-Pan Helmet
				{ 25, 89800, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Shado-Pan Tabard
			},
		},
		{	--ShadoPanAssault
			FactionID = 1435,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1435rep4" },
				{ 2, 95146 },	-- Destroyer's Battletags
				{ 3, 95143 },	-- Flanker's Battletags
				{ 4, 95145 },	-- Mender's Battletags
				{ 5, 95142 },	-- Striker's Battletags
				{ 6, 95144 },	-- Vanguard's Battletags
				{ 8, "f1435rep5" },
				{ 9, 95118 },	-- Dreamweaver Drape
				{ 10, 95116 },	-- Longshot Forestcloak
				{ 11, 95115 },	-- Many-Layered Scalecloak
				{ 12, 95117 },	-- Shadowspike Cloak
				{ 13, 95114 },	-- Spikeshard Greatcloak
				{ 16, "f1435rep5" },
				{ 17, 95081 },	-- Fire Support Robes
				{ 18, 95082 },	-- Robes of Misty Bindings
				{ 19, 95078 },	-- Raiment of Silent Stars
				{ 20, 95077 },	-- Roofstalker Shadowwrap
				{ 21, 95079 },	-- Carapace of Segmented Scale
				{ 22, 95080 },	-- Skinsealer Tunic
				{ 23, 95076 },	-- Breastplate of Brutal Strikes
				{ 24, 95075 },	-- Gianttooth Chestplate
				{ 25, 95074 },	-- Hauberk of Gleaming Fire
				{ 101, "f1435rep5" },
				{ 102, 95135 },	-- Bracers of Shielding Thought
				{ 103, 95136 },	-- Troll-Burner Bracers
				{ 104, 95134 },	-- Hearthfire Armwraps
				{ 105, 95133 },	-- Willow-Weave Armbands
				{ 106, 95131 },	-- Powderburn Bracers
				{ 107, 95132 },	-- Spiritcaller Cuffs
				{ 108, 95129 },	-- Axebinder Wristguards
				{ 109, 95128 },	-- Bonecrusher Bracers
				{ 110, 95130 },	-- Softscar Armplates
				{ 117, 95106 },	-- Flameweaver Handwraps
				{ 118, 95105 },	-- Ghostbinder Grips
				{ 119, 95108 },	-- Daggerfinger Clutches
				{ 120, 95107 },	-- Gloves of Enduring Renewal
				{ 121, 95109 },	-- Gauntlets of the Longbow
				{ 122, 95112 },	-- Totemshaper Gloves
				{ 123, 95111 },	-- Bloodstained Skullsqueezers
				{ 124, 95110 },	-- Stoneward Handguards
				{ 125, 95113 },	-- Touch of Soothing Mists
				{ 201, "f1435rep5" },
				{ 202, 95090 },	-- Firestrike Cord
				{ 203, 95091 },	-- Girdle of Glowing Light
				{ 204, 95088 },	-- Darkfang Belt
				{ 205, 95089 },	-- Martiean's Splitleaf Girdle
				{ 206, 95087 },	-- Cracklebite Links
				{ 207, 95086 },	-- Nightflight Chain
				{ 208, 95084 },	-- Reinforced Spiritplate Girdle
				{ 209, 95083 },	-- Swordhook Slingbelt
				{ 210, 95085 },	-- Waistplate of Channeled Mending
				{ 217, 95123 },	-- Charfire Leggings
				{ 218, 95122 },	-- Wisp-Weave Pantaloons
				{ 219, 95125 },	-- Legguards of Hidden Knives
				{ 220, 95124 },	-- Trousers of Waning Shadow
				{ 221, 95127 },	-- Homeguard Leggings
				{ 222, 95126 },	-- Kilt of Rising Thunder
				{ 223, 95120 },	-- Legguards of Renewal
				{ 224, 95119 },	-- Thunderbreaker Legplates
				{ 225, 95121 },	-- Vaultbreaker Greaves
				{ 301, "f1435rep5" },
				{ 302, 95140 },	-- Band of the Shado-Pan Assault
				{ 303, 95141 },	-- Loop of the Shado-Pan Assault
				{ 304, 95139 },	-- Ring of the Shado-Pan Assault
				{ 305, 95137 },	-- Seal of the Shado-Pan Assault
				{ 306, 95138 },	-- Signet of the Shado-Pan Assault
				{ 307, 94508 },	-- Brutal Talisman of the Shado-Pan Assault
				{ 308, 94509 },	-- Soothing Talisman of the Shado-Pan Assault
				{ 309, 94507 },	-- Steadfast Talisman of the Shado-Pan Assault
				{ 310, 94511 },	-- Vicious Talisman of the Shado-Pan Assault
				{ 311, 94510 },	-- Volatile Talisman of the Shado-Pan Assault
				{ 316, "f1435rep8" },
				{ 317, 95102, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Frost-Kissed Shoulderwraps
				{ 318, 95101, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Halo-Graced Mantle
				{ 319, 95096, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Shoulders of Demonic Dreams
				{ 320, 95097, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Heartroot Shoulderguards
				{ 321, 95100, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Wallwalker Spaulders
				{ 322, 95099, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Lightning Strike Mantle
				{ 323, 95095, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Targetblinder Spaulders
				{ 324, 95104, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Shoulderguards of Potentiation
				{ 325, 95098, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Sightblinder Shoulderguards
				{ 326, 95103, [PRICE_EXTRA_ITTYPE] = "money:8000000" },	-- Sparksmasher Pauldrons
				{ 327, 97131, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Shado-Pan Assault Tabard
			},
		},
		{	--SunreaverOnslaught
			FactionID = 1388,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1388rep5" },
				{ 2, 80433, [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Blood Spirit
				{ 3, 95487, [PRICE_EXTRA_ITTYPE] = "95491:1" },	-- Sunreaver Onslaught Insignia
				{ 4, 95488, [PRICE_EXTRA_ITTYPE] = "95491:10" },	-- Greater Sunreaver Onslaught Insignia
				{ 5, 97157, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- Potion of Light Steps
				{ 6, 95568, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Sunreaver Beacon
				{ 8, "f1388rep7" },
				{ 9, 95548, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Sunreaver Onslaught
				{ 10, 97159, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- Arcane Propellant
				{ 11, 97156, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- Frost Rune Trap
				{ 16, "f1388rep6" },
				{ 17, 95523, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Belt of Loa Charms
				{ 18, 95518, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Pain-Binder Girdle
				{ 19, 95517, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Shan'ze Scholar's Girdle
				{ 20, 95521, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Cinch of the Dead Forest's Vigil
				{ 21, 95519, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Skumblade-Tooth Girdle
				{ 22, 95522, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Rotting Bog Cinch
				{ 23, 95525, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Skumblade Ritualist Links
				{ 24, 95520, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Girdle of Shan'ze Glory
				{ 25, 95524, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Thunder Caressed Waistguard
				{ 26, 97158, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- A Common Rock
				{ 27, 97154, [PRICE_EXTRA_ITTYPE] = "eldercharm:1" },	-- Sleep Dust
				{ 101, "f1388rep8" },
				{ 102, 95565, "mount", [PRICE_EXTRA_ITTYPE] = "money:24000000" },	-- Reins of the Crimson Primal Direhorn
				{ 103, 95590, [QUEST_EXTRA_ITTYPE] = 32589 },	-- Glorious Standard of the Sunreaver Onslaught
				{ 104, 95592, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Sunreaver Onslaught Tabard
				{ 105, 97155, [PRICE_EXTRA_ITTYPE] = "eldercharm:3" },	-- Polymorphic Key
				{ 106, 98559, [PRICE_EXTRA_ITTYPE] = "eldercharm:3" },	-- Empty Supply Crate
				{ 107, 98562, [PRICE_EXTRA_ITTYPE] = "eldercharm:15" },	-- Sunreaver Bounty
			},
		},
		{	--TheAnglers
			FactionID = 1302,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1302rep5" },
				{ 2, 85505, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Recipe: Krasarang Fritters (p3 525)
				{ 3, 85502, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Recipe: Viseclaw Soup (p3 525)
				{ 5, "f1302rep6" },
				{ 6, 85447, "pet652", [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Tiny Goldfish
				{ 7, 84660, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Pandaren Fishing Pole
				{ 9, "f1302rep7" },
				{ 10, 85500, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Anglers Fishing Raft (p24 525)
				{ 11, 107950, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Bipsi's Bobbing Berg (p24 525, Class: Mage)
				{ 12, 84661, [PRICE_EXTRA_ITTYPE] = "money:5000000" },	-- Dragon Fishing Pole
				{ 13, 88535, [PRICE_EXTRA_ITTYPE] = "money:15000000" },	-- Sharpened Tuskarr Spear
				{ 14, 93225, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Anglers
				{ 16, "f1302rep8" },
				{ 17, 81354, "mount", [PRICE_EXTRA_ITTYPE] = "money:40000000" },	-- Reins of the Azure Water Strider
				{ 18, 89401, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Anglers Tabard
				{ 20, "INV_Box_01", nil, ALIL["Nat Pagle"], AL["Good Friend"] },
				{ 21, 88563, [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Nat's Fishing Journal
				{ 23, "INV_Box_01", nil, ALIL["Nat Pagle"], AL["Best Friend"] },
				{ 24, 88710, [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Nat's Hat
				{ 25, 86596 },	-- Nat's Fishing Chair
			},
		},
		{	--TheAugustCelestials
			FactionID = 1341,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1341rep6" },
				{ 2, 89124, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Celestial Offering
				{ 4, "f1341rep7" },
				{ 5, 84561, [PRICE_EXTRA_ITTYPE] = "money:400000" },	-- Formula: Enchant Bracer - Exceptional Strength (p4 600)
				{ 6, 84557, [PRICE_EXTRA_ITTYPE] = "money:400000" },	-- Formula: Enchant Bracer - Greater Agility (p4 600)
				{ 7, 84559, [PRICE_EXTRA_ITTYPE] = "money:400000" },	-- Formula: Enchant Bracer - Super Intellect (p4 600)
				{ 8, 93224, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the August Celestials
				{ 16, "f1341rep8" },
				{ 17, 89304, "mount", [PRICE_EXTRA_ITTYPE] = "money:80000000" },	-- Reins of the Thundering August Cloud Serpent
				{ 18, 89799, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- August Celestials Tabard
				{ 19, 86377, [PRICE_EXTRA_ITTYPE] = "money:400000" },	-- Pattern: Royal Satchel (p8 600)
			},
		},
		{	--TheKlaxxi
			FactionID = 1337,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1337rep6" },
				{ 2, 90531, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Ghost Iron Shield Spike (p2 540)
				{ 3, 90532, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Living Steel Weapon Chain (p2 540)
				{ 4, 84197, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Masterwork Forgewire Axe (p2 575)
				{ 5, 84198, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Masterwork Ghost Shard (p2 575)
				{ 6, 84200, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Masterwork Ghost-Forged Blade (p2 575)
				{ 7, 84217, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Masterwork Phantasmal Hammer (p2 575)
				{ 8, 84218, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Masterwork Spiritblade Decimator (p2 575)
				{ 9, 83791, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Breastplate of Ancient Steel (p2 600)
				{ 10, 83792, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Gauntlets of Ancient Steel (p2 600)
				{ 11, 83787, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Ghost Reaver's Breastplate (p2 600)
				{ 12, 83788, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Ghost Reaver's Gauntlets (p2 600)
				{ 13, 84196, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Living Steel Belt Buckle (p2 600)
				{ 14, 83789, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Living Steel Breastplate (p2 600)
				{ 15, 83790, [PRICE_EXTRA_ITTYPE] = "72093:20" },	-- Plans: Living Steel Gauntlets (p2 600)
				{ 17, 89230, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Restorative Amber
				{ 19, "f1337rep7" },
				{ 20, 92522, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Klaxxi
				{ 101, "f1337rep8" },
				{ 102, 90862, [QUEST_EXTRA_ITTYPE] = 31612 },	-- Seal of the Bloodseeker
				{ 103, 90859, [QUEST_EXTRA_ITTYPE] = 31612 },	-- Seal of the Lucid
				{ 104, 90858, [QUEST_EXTRA_ITTYPE] = 31612 },	-- Seal of the Prime
				{ 105, 90860, [QUEST_EXTRA_ITTYPE] = 31612 },	-- Seal of the Unscathed
				{ 106, 90861, [QUEST_EXTRA_ITTYPE] = 31612 },	-- Seal of the Windreaver
				{ 107, 85262, "mount", [PRICE_EXTRA_ITTYPE] = "money:80000000" },	-- Reins of the Amber Scorpion
				{ 108, 89798, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Klaxxi Tabard
				{ 117, 89393 },	-- Amber Slicer of Klaxxi-vess
				{ 118, 89392 },	-- Amber Spine of Klaxxi-vess
				{ 119, 89396 },	-- Amber Espada of Klaxxi-vess
				{ 120, 89397 },	-- Amber Saber of Klaxxi-vess
				{ 121, 89398 },	-- Amber Flammard of Klaxxi-vess
				{ 122, 89400 },	-- Amber Sledge of Klaxxi-vess
				{ 123, 89394 },	-- Amber Spear of Klaxxi-vess
				{ 124, 89395 },	-- Amber Scythe of Klaxxi-vess
				{ 125, 89399 },	-- Amber Sprayer of Klaxxi-vess
			},
		},
		{	--TheLorewalkers
			FactionID = 1345,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1345rep7" },
				{ 2, 93230, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Lorewalkers
				{ 16, "f1345rep8" },
				{ 17, 89363, "mount", [PRICE_EXTRA_ITTYPE] = "money:4800000" },	-- Disc of the Red Flying Cloud
				{ 18, 89795, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Lorewalkers Tabard
				{ 19, 87548, [PRICE_EXTRA_ITTYPE] = "87399:1" },	-- Lorewalker's Lodestone
				{ 20, 87549, [PRICE_EXTRA_ITTYPE] = "87399:1" },	-- Lorewalker's Map
				{ 21, 104198, [PRICE_EXTRA_ITTYPE] = "87399:2" },	-- Mantid Artifact Hunter's Kit
			},
		},
		{	--TheTillers
			FactionID = 1272,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1272rep5" },
				{ 2, 79102, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Green Cabbage Seeds
				{ 3, 89328, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Jade Squash Seeds
				{ 4, 80590, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Juicycrunch Carrot Seeds
				{ 5, 80592, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Mogu Pumpkin Seeds
				{ 6, 80594, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Pink Turnip Seeds
				{ 7, 80593, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Red Blossom Leek Seeds
				{ 8, 80591, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Scallion Seeds
				{ 9, 89329, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Striped Melon Seeds
				{ 10, 80595, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- White Turnip Seeds
				{ 11, 89326, [PRICE_EXTRA_ITTYPE] = "money:1500" },	-- Witchberry Seeds
				{ 13, "f1272rep6" },
				{ 14, 85267, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Autumn Blossom Sapling
				{ 15, 89812, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- "Jinyu Princess" Irrigation System
				{ 16, "f1272rep7" },
				{ 17, 89869, [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Pandaren Scarecrow
				{ 18, 85268, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Spring Blossom Sapling
				{ 19, 85216, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Enigma Seed
				{ 20, 85217, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Magebulb Seed
				{ 21, 89202, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Raptorleaf Seed
				{ 22, 85215, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Snakeroot Seed
				{ 23, 89233, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Songbell Seed
				{ 24, 89197, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Windshear Cactus Seed
				{ 25, 89813, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- "Thunder King" Pest Repellers
				{ 26, 93226, [PRICE_EXTRA_ITTYPE] = "money:450000" },	-- Grand Commendation of the Tillers
				{ 101, "f1272rep8" },
				{ 102, 89391, "mount", [PRICE_EXTRA_ITTYPE] = "money:12000000" },	-- Reins of the Black Riding Goat
				{ 103, 89362, "mount", [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Reins of the Brown Riding Goat
				{ 104, 89390, "mount", [PRICE_EXTRA_ITTYPE] = "money:26000000" },	-- Reins of the White Riding Goat
				{ 105, 90175, [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Gin-Ji Knife Set
				{ 106, 80914, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Mourning Glory
				{ 107, 89784, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Tillers Tabard
				{ 108, 74657, [PRICE_EXTRA_ITTYPE] = "money:8000" },	-- Recipe: Spicy Salmon (p3 500)
				{ 109, 74658, [PRICE_EXTRA_ITTYPE] = "money:8000" },	-- Recipe: Spicy Vegetable Chips (p3 500)
				{ 110, 85269, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Winter Blossom Sapling
				{ 111, 95449, [PRICE_EXTRA_ITTYPE] = "money:300000" },	-- Bag of Enigma Seeds
				{ 112, 95451, [PRICE_EXTRA_ITTYPE] = "money:300000" },	-- Bag of Magebulb Seeds
				{ 113, 95457, [PRICE_EXTRA_ITTYPE] = "money:300000" },	-- Bag of Raptorleaf Seeds
				{ 114, 95447, [PRICE_EXTRA_ITTYPE] = "money:300000" },	-- Bag of Snakeroot Seeds
				{ 115, 95445, [PRICE_EXTRA_ITTYPE] = "money:300000" },	-- Bag of Songbell Seeds
				{ 117, 95454, [PRICE_EXTRA_ITTYPE] = "money:300000" },	-- Bag of Windshear Cactus Seeds
				{ 118, 80809, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Green Cabbage Seeds
				{ 119, 89848, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Jade Squash Seeds
				{ 120, 84782, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Juicycrunch Carrot Seeds
				{ 121, 85153, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Mogu Pumpkin Seeds
				{ 122, 85162, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Pink Turnip Seeds
				{ 123, 85158, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Red Blossom Leek Seeds
				{ 124, 84783, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Scallion Seeds
				{ 125, 89849, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Striped Melon Seeds
				{ 126, 85163, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of White Turnip Seeds
				{ 127, 89847, [PRICE_EXTRA_ITTYPE] = "money:45000" },	-- Bag of Witchberry Seeds
				{ 128, 91806, [PRICE_EXTRA_ITTYPE] = "money:30000" },	-- Unstable Portal Shard
				{ 129, 89814, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- "Earth-Slasher" Master Plow
				{ 201, "INV_Box_01", nil, ALIL["Old Hillpaw"], AL["Best Friend"] },
				{ 202, 90893 },	-- Straw Hat
				{ 203, 90894 },	-- Straw Hat
				{ 204, 90895 },	-- Straw Hat
				{ 205, 90896 },	-- Straw Hat
				{ 207, "INV_Box_01", nil, ALIL["Sho"], AL["Best Friend"] },
				{ 208, 85222, "pet1042" },	-- Red Cricket
			},
		},
		{	--TushuiPandaren
			FactionID = 1353,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1353rep4" },
				{ 2, 83079, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Tushui Tabard
				{ 4, "f1353rep7" },
				{ 5, 92071, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Tushui Satchel
				{ 16, "f1353rep8" },
				{ 17, 87802, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Black Dragon Turtle
				{ 18, 87803, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Blue Dragon Turtle
				{ 19, 87804, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Brown Dragon Turtle
				{ 20, 87801, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Green Dragon Turtle
				{ 21, 87805, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Purple Dragon Turtle
				{ 22, 82811, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Great Red Dragon Turtle
				{ 23, 87795, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Black Dragon Turtle
				{ 24, 87796, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Blue Dragon Turtle
				{ 25, 87797, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Brown Dragon Turtle
				{ 26, 82765, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Green Dragon Turtle
				{ 27, 87799, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Purple Dragon Turtle
				{ 28, 87800, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Red Dragon Turtle
			},
		},
	},
}

data["CATAFACTIONS"] = {
	name = AL["Cataclysm"],
	ContentType = FACTION_CONTENT,
	items = {
		{	--AvengersHyjal
			FactionID = 1204,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1204rep5" },
				{ 2, 70930, [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Durable Flamewrath Greatcloak
				{ 3, 71229, [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Flowing Flamewrath Cape
				{ 4, 71228, [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Nimble Flamewrath Cloak
				{ 5, 71230, [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Rippling Flamewrath Drape
				{ 6, 71227, [PRICE_EXTRA_ITTYPE] = "money:2500000" },	-- Spiked Flamewrath Cloak
				{ 16, "f1204rep6" },
				{ 17, 71258, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Embereye Belt
				{ 18, 71249, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Firescar Sash
				{ 19, 71131, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Flamebinding Girdle
				{ 20, 71255, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Firearrow Belt
				{ 21, 71254, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Firemend Cinch
				{ 22, 71250, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Cinch of the Flaming Ember
				{ 23, 70933, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Girdle of the Indomitable Flame
				{ 24, 71253, [PRICE_EXTRA_ITTYPE] = "money:3000000" },	-- Belt of the Seven Seals
				{ 101, "f1204rep7" },
				{ 102, 69001, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Ancient Petrified Seed
				{ 103, 69002, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Essence of the Eternal Flame
				{ 104, 69000, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Fiery Quintessence
				{ 105, 68998, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Rune of Zeth
				{ 106, 68996, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Stay of Execution
				{ 116, "f1204rep8" },
				{ 117, 70934, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Adamantine Signet of the Avengers
				{ 118, 71217, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Infernal Signet of the Avengers
				{ 119, 71215, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Obsidian Signet of the Avengers
				{ 120, 71237, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Quicksilver Signet of the Avengers
				{ 121, 71216, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Viridian Signet of the Avengers
			},
		},
		{	--BaradinsWardens
			FactionID = 1177,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1177rep4" },
				{ 2, 68774, [PRICE_EXTRA_ITTYPE] = "tolbarad:80" },	-- Greater Inscription of Vicious Agility
				{ 3, 68772, [PRICE_EXTRA_ITTYPE] = "tolbarad:80" },	-- Greater Inscription of Vicious Intellect
				{ 4, 68773, [PRICE_EXTRA_ITTYPE] = "tolbarad:80" },	-- Greater Inscription of Vicious Strength
				{ 6, "f1177rep5" },
				{ 7, 63517, [PRICE_EXTRA_ITTYPE] = "tolbarad:10" },	-- Baradin's Wardens Commendation
				{ 8, 63391, [PRICE_EXTRA_ITTYPE] = "tolbarad:5" },	-- Baradin's Wardens Bandage
				{ 9, 63144, [PRICE_EXTRA_ITTYPE] = "tolbarad:2" },	-- Baradin's Wardens Healing Potion
				{ 10, 63145, [PRICE_EXTRA_ITTYPE] = "tolbarad:2" },	-- Baradin's Wardens Mana Potion
				{ 16, "f1177rep6" },
				{ 17, 63379, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" },	-- Baradin's Wardens Tabard
				{ 18, 65175, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" },	-- Baradin Footman's Tags
				{ 19, 63355, "pet271", [PRICE_EXTRA_ITTYPE] = "tolbarad:50" },	-- Rustberg Gull
				{ 20, 63141, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" },	-- Tol Barad Searchlight
				{ 101, "f1177rep7" },
				{ 102, 62475, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Dagger of Restless Nights
				{ 103, 62473, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Blade of the Fearless
				{ 104, 62476, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Ravening Slicer
				{ 105, 68739, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Darkheart Hacker
				{ 106, 62478, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Shimmering Morningstar
				{ 107, 62474, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Spear of Trailing Shadows
				{ 108, 62477, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Insidious Staff
				{ 109, 62479, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Sky Piercer
				{ 110, 63377, [PRICE_EXTRA_ITTYPE] = "tolbarad:50" },	-- Baradin's Wardens Battle Standard
				{ 116, "f1177rep8" },
				{ 117, 62469, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Impatience of Youth
				{ 118, 62472, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Mandala of Stirring Patterns
				{ 119, 62471, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Mirror of Broken Images
				{ 120, 62470, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Stump of Time
				{ 121, 62468, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Unsolvable Riddle
				{ 122, 64998, "mount", [PRICE_EXTRA_ITTYPE] = "tolbarad:165" },	-- Reins of the Spectral Steed
				{ 123, 63039, "mount", [PRICE_EXTRA_ITTYPE] = "tolbarad:200" },	-- Reins of the Drake of the West Wind
				{ 124, 90897, "pet278", [PRICE_EXTRA_ITTYPE] = "tolbarad:200" },	-- Fox Kit
			},
		},
		{	--BilgewaterCartel
			FactionID = 1133,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1133rep4" },
				{ 2, 64884, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Bilgewater Cartel Tabard
				{ 4, "f1133rep7" },
				{ 5, 67525, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Bilgewater Satchel
				{ 7, "f1133rep8" },
				{ 8, 64906 },	-- Bilgewater Cape
				{ 9, 64907 },	-- Bilgewater Mantle
				{ 10, 64905 },	-- Bilgewater Shroud
				{ 16, 62462, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Goblin Turbo-Trike Key
				{ 17, 62461, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Goblin Trike Key
			},
		},
		{	--DragonmawClan
			FactionID = 1172,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1172rep5" },
				{ 2, 65909, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Dragonmaw Clan
				{ 4, "f1172rep6" },
				{ 5, 62406 },	-- Bone Fever Gloves
				{ 6, 62404 },	-- Spaulders of the Endless Plains
				{ 7, 62405 },	-- Leggings of the Impenitent
				{ 8, 62407 },	-- Helm of the Brown Lands
				{ 10, "f1172rep7" },
				{ 11, 62409 },	-- Snarling Helm
				{ 12, 62410 },	-- Grinning Fang Helm
				{ 13, 62408 },	-- Gauntlets of Rattling Bones
				{ 14, 62415 },	-- Band of Lamentation
				{ 16, "f1172rep8" },
				{ 17, 62417 },	-- Liar's Handwraps
				{ 18, 62420 },	-- Withered Dream Belt
				{ 19, 62418 },	-- Boots of Sullen Rock
				{ 20, 62416 },	-- Yellow Smoke Pendant
			},
		},
		{	--Gilneas
			FactionID = 1134,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1134rep4" },
				{ 2, 64882, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Gilneas Tabard
				{ 4, "f1134rep7" },
				{ 5, 67532, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Gilnean Satchel
				{ 7, "f1134rep8" },
				{ 8, 64893 },	-- Cape of Gilneas
				{ 9, 64892 },	-- Mantle of Gilneas
				{ 10, 64894 },	-- Shroud of Gilneas
				{ 16, 73839, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Mountain Horse
				{ 17, 73838, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Mountain Horse
			},
		},
		{	--GuardiansofHyjal
			FactionID = 1158,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1158rep5" },
				{ 2, 65906, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Guardians of Hyjal
				{ 4, "f1158rep6" },
				{ 5, 62377 },	-- Cloak of the Dryads
				{ 6, 62374 },	-- Sly Fox Jerkin
				{ 7, 62376 },	-- Mountain's Mouth
				{ 8, 62375 },	-- Galrond's Band
				{ 10, "f1158rep7" },
				{ 11, 62381 },	-- Aessina-Blessed Gloves
				{ 12, 62380 },	-- Wilderness Legguards
				{ 13, 62382 },	-- Waywatcher's Boots
				{ 14, 62378 },	-- Acorn of the Daughter Tree
				{ 16, "f1158rep8" },
				{ 17, 62383 },	-- Wrap of the Great Turtle
				{ 18, 62386 },	-- Cord of the Raven Queen
				{ 19, 62385 },	-- Treads of Malorne
				{ 20, 62384 },	-- Belt of the Ferocious Wolf
			},
		},
		{	--HellscreamsReach
			FactionID = 1178,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1178rep4" },
				{ 2, 68774, [PRICE_EXTRA_ITTYPE] = "tolbarad:80" },	-- Greater Inscription of Vicious Agility
				{ 3, 68772, [PRICE_EXTRA_ITTYPE] = "tolbarad:80" },	-- Greater Inscription of Vicious Intellect
				{ 4, 68773, [PRICE_EXTRA_ITTYPE] = "tolbarad:80" },	-- Greater Inscription of Vicious Strength
				{ 6, "f1178rep5" },
				{ 7, 63518, [PRICE_EXTRA_ITTYPE] = "tolbarad:10" },	-- Hellscream's Reach Commendation
				{ 8, 64995, [PRICE_EXTRA_ITTYPE] = "tolbarad:5" },	-- Hellscream's Reach Bandage
				{ 9, 64994, [PRICE_EXTRA_ITTYPE] = "tolbarad:2" },	-- Hellscream's Reach Healing Potion
				{ 10, 64993, [PRICE_EXTRA_ITTYPE] = "tolbarad:2" },	-- Hellscream's Reach Mana Potion
				{ 16, "f1178rep6" },
				{ 17, 63378, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" },	-- Hellscream's Reach Tabard
				{ 18, 65176, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" },	-- Baradin Grunt's Talisman
				{ 19, 64996, "pet271", [PRICE_EXTRA_ITTYPE] = "tolbarad:50" },	-- Rustberg Gull
				{ 20, 64997, [PRICE_EXTRA_ITTYPE] = "tolbarad:40" },	-- Tol Barad Searchlight
				{ 101, "f1178rep7" },
				{ 102, 62456, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Dagger of Restless Nights
				{ 103, 62454, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Blade of the Fearless
				{ 104, 62457, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Ravening Slicer
				{ 105, 68740, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Darkheart Hacker
				{ 106, 62459, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Shimmering Morningstar
				{ 107, 62455, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Spear of Trailing Shadows
				{ 108, 62458, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Insidious Staff
				{ 109, 62460, [PRICE_EXTRA_ITTYPE] = "tolbarad:85" },	-- Sky Piercer
				{ 110, 63376, [PRICE_EXTRA_ITTYPE] = "tolbarad:50" },	-- Hellscream's Reach Battle Standard
				{ 116, "f1178rep8" },
				{ 117, 62464, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Impatience of Youth
				{ 118, 62467, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Mandala of Stirring Patterns
				{ 119, 62466, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Mirror of Broken Images
				{ 120, 62465, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Stump of Time
				{ 121, 62463, [PRICE_EXTRA_ITTYPE] = "tolbarad:125" },	-- Unsolvable Riddle
				{ 122, 64999, "mount", [PRICE_EXTRA_ITTYPE] = "tolbarad:165" },	-- Reins of the Spectral Wolf
				{ 123, 65356, "mount", [PRICE_EXTRA_ITTYPE] = "tolbarad:200" },	-- Reins of the Drake of the West Wind
				{ 124, 90898, "pet278", [PRICE_EXTRA_ITTYPE] = "tolbarad:200" },	-- Fox Kit
			},
		},
		{	--Ramkahen
			FactionID = 1173,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1173rep5" },
				{ 2, 65904, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of Ramkahen
				{ 4, "f1173rep6" },
				{ 5, 62437 },	-- Shroud of the Dead
				{ 6, 62439 },	-- Belt of the Stargazer
				{ 7, 62438 },	-- Drystone Greaves
				{ 8, 62436 },	-- Ammunae's Blessing
				{ 10, "f1173rep7" },
				{ 11, 62441 },	-- Robes of Orsis
				{ 12, 62446 },	-- Quicksand Belt
				{ 13, 62445 },	-- Sash of Prophecy
				{ 14, 62440 },	-- Red Rock Band
				{ 16, "f1173rep8" },
				{ 17, 62450 },	-- Desert Walker Sandals
				{ 18, 62449 },	-- Sandguard Bracers
				{ 19, 62448 },	-- Sun King's Girdle
				{ 20, 62447 },	-- Gift of Nadun
				{ 21, 63044, "mount", [PRICE_EXTRA_ITTYPE] = "money:800000" },	-- Reins of the Brown Riding Camel
				{ 22, 63045, "mount", [PRICE_EXTRA_ITTYPE] = "money:800000" },	-- Reins of the Tan Riding Camel
			},
		},
		{	--TheEarthenRing
			FactionID = 1135,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1135rep5" },
				{ 2, 65905, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Earthen Ring
				{ 4, "f1135rep6" },
				{ 5, 62356 },	-- Helm of Temperance
				{ 6, 62353 },	-- Mantle of Moss
				{ 7, 62355 },	-- Stone-Wrapped Greaves
				{ 8, 62354 },	-- Pendant of Elemental Balance
				{ 10, "f1135rep7" },
				{ 11, 62357 },	-- Cloak of Ancient Wisdom
				{ 12, 62361 },	-- Softwind Cape
				{ 13, 62358 },	-- Leggings of Clutching Roots
				{ 14, 62359 },	-- Peacemaker's Breastplate
				{ 16, "f1135rep8" },
				{ 17, 62364 },	-- Flamebloom Gloves
				{ 18, 62363 },	-- Earthmender's Boots
				{ 19, 62365 },	-- World Keeper's Gauntlets
				{ 20, 62362 },	-- Signet of the Elder Council
			},
		},
		{	--Therazane
			FactionID = 1171,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1171rep5" },
				{ 2, 65907, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of Therazane
				{ 4, "f1171rep6" },
				{ 5, 62342, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Lesser Inscription of Charged Lodestone
				{ 6, 62344, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Lesser Inscription of Jagged Stone
				{ 7, 62347, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Lesser Inscription of Shattered Crystal
				{ 8, 62321, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Lesser Inscription of Unbreakable Quartz
				{ 10, "f1171rep7" },
				{ 11, 62352 },	-- Diamant's Ring of Temperance
				{ 12, 62351 },	-- Felsen's Ring of Resolve
				{ 13, 62350 },	-- Gorsik's Band of Shattering
				{ 14, 62348 },	-- Terrath's Signet of Balance
				{ 16, "f1171rep8" },
				{ 17, 62343, [PRICE_EXTRA_ITTYPE] = "money:600000" },	-- Greater Inscription of Charged Lodestone
				{ 18, 62345, [PRICE_EXTRA_ITTYPE] = "money:600000" },	-- Greater Inscription of Jagged Stone
				{ 19, 62346, [PRICE_EXTRA_ITTYPE] = "money:600000" },	-- Greater Inscription of Shattered Crystal
				{ 20, 62333, [PRICE_EXTRA_ITTYPE] = "money:600000" },	-- Greater Inscription of Unbreakable Quartz
			},
		},
		{	--WildhammerClan
			FactionID = 1174,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1174rep5" },
				{ 2, 65908, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Wildhammer Clan
				{ 4, "f1174rep6" },
				{ 5, 62424 },	-- Gloves of Aetherial Rumors
				{ 6, 62426 },	-- Mantle of Wild Feathers
				{ 7, 62425 },	-- Swiftflight Leggings
				{ 8, 62423 },	-- Helm of the Skyborne
				{ 10, "f1174rep7" },
				{ 11, 62429 },	-- Windhome Helm
				{ 12, 62428 },	-- Crown of Wings
				{ 13, 62430 },	-- Gryphon Talon Gauntlets
				{ 14, 62427 },	-- Band of Singing Grass
				{ 16, "f1174rep8" },
				{ 17, 62433 },	-- Stormbolt Gloves
				{ 18, 62431 },	-- Belt of the Untamed
				{ 19, 62432 },	-- Gryphon Rider's Boots
				{ 20, 62434 },	-- Lightning Flash Pendant
			},
		},
	},
}

data["WOTLKFACTIONS"] = {
	name = AL["Wrath of the Lich King"],
	ContentType = FACTION_CONTENT,
	items = {
		{	--AllianceVanguard
			FactionID = 1037,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1037rep7" },
				{ 2, 38459 },	-- Orb of the Eastern Kingdoms
				{ 3, 38465 },	-- Vanguard Soldier's Dagger
				{ 4, 38455 },	-- Hammer of the Alliance Vanguard
				{ 5, 38463 },	-- Lordaeron's Resolve
				{ 6, 38453 },	-- Shield of the Lion-Hearted
				{ 7, 38457 },	-- Sawed-Off Hand Cannon
				{ 8, 38464 },	-- Gnomish Magician's Quill
				{ 16, "f1037rep8" },
				{ 17, 44503, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Schematic: Mekgineer's Chopper (p5 450)
				{ 18, 44937, [PRICE_EXTRA_ITTYPE] = "money:150000" },	-- Plans: Titanium Plating (p2 450)
			},
		},
		{	--ArgentCrusade
			FactionID = 1106,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1106rep5" },
				{ 2, 43154, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Argent Crusade
				{ 4, "f1106rep6" },
				{ 5, 44216 },	-- Cloak of Holy Extermination
				{ 6, 44240 },	-- Special Issue Legplates
				{ 7, 44239 },	-- Standard Issue Legguards
				{ 16, "f1106rep7" },
				{ 17, 44248 },	-- Battle Mender's Helm
				{ 18, 44247 },	-- Fang-Deflecting Faceguard
				{ 19, 44244 },	-- Argent Skeleton Crusher
				{ 20, 44245 },	-- Zombie Sweeper Shotgun
				{ 21, 44214 },	-- Purifying Torch
				{ 22, 41726, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Design: Guardian's Twilight Opal (p12 390)
				{ 24, "f1106rep8" },
				{ 25, 44297 },	-- Boots of the Neverending Path
				{ 26, 44295 },	-- Polished Regimental Hauberk
				{ 27, 44296 },	-- Helm of Purified Thoughts
				{ 28, 44283 },	-- Signet of Hopeful Light
				{ 29, 42187, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Brilliant Spellthread (p8 430)
			},
		},
		{	--FrenzyheartTribe
			FactionID = 1104,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1104rep5" },
				{ 2, 41561, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Design: Reckless Huge Citrine (p12 350)
				{ 3, 44064, [PRICE_EXTRA_ITTYPE] = "money:3200" },	-- Nepeta Leaf
				{ 4, 44072, [PRICE_EXTRA_ITTYPE] = "money:16000" },	-- Roasted Mystery Beast
				{ 6, "f1104rep7" },
				{ 7, 44116 },	-- Muddied Crimson Gloves
				{ 8, 44117 },	-- Azure Strappy Pants
				{ 9, 44122 },	-- Scavenged Feathery Leggings
				{ 10, 44120 },	-- Giant-Sized Gauntlets
				{ 11, 44121 },	-- Sparkly Shiny Gloves
				{ 12, 44123 },	-- Discarded Titanium Legplates
				{ 13, 41723, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Design: Jagged Forest Emerald (p12 350)
				{ 14, 44717, [PRICE_EXTRA_ITTYPE] = "money:30000" },	-- Disgusting Jar
				{ 16, "f1104rep8" },
				{ 17, 44073 },	-- Frenzyheart Insignia of Fury
				{ 19, 44718 },	-- Ripe Disgusting Jar
				{ 20, 44719 },	-- Frenzyheart Brew
				{ 21, 39671 },	-- Resurgent Healing Potion
				{ 22, 40067 },	-- Icy Mana Potion
				{ 23, 40087 },	-- Powerful Rejuvenation Potion
				{ 24, 44716 },	-- Mysterious Fermented Liquid
			},
		},
		{	--HordeExpedition
			FactionID = 1052,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1052rep7" },
				{ 2, 38458 },	-- Darkspear Orb
				{ 3, 38461 },	-- Warsong Shanker
				{ 4, 38454 },	-- Warsong Punisher
				{ 5, 38452 },	-- Bulwark of the Warchief
				{ 6, 38462 },	-- Warsong Stormshield
				{ 7, 38456 },	-- Sin'dorei Recurve Bow
				{ 8, 38460 },	-- Charged Wand of the Cleft
				{ 16, "f1052rep8" },
				{ 17, 44502, [PRICE_EXTRA_ITTYPE] = "money:4000000" },	-- Schematic: Mechano-Hog (p5 450)
				{ 18, 44938, [PRICE_EXTRA_ITTYPE] = "money:150000" },	-- Plans: Titanium Plating (p2 450)
			},
		},
		{	--KirinTor
			FactionID = 1090,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1090rep5" },
				{ 2, 43157, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Kirin Tor
				{ 4, "f1090rep6" },
				{ 5, 44167 },	-- Shroud of Dedicated Research
				{ 6, 44170 },	-- Helm of the Majestic Stag
				{ 7, 44171 },	-- Spaulders of Grounded Lightning
				{ 8, 44166 },	-- Lightblade Rivener
				{ 10, "f1090rep7" },
				{ 11, 44179 },	-- Mind-Expanding Leggings
				{ 12, 44176 },	-- Girdle of the Warrior Magi
				{ 13, 44173 },	-- Flameheart Spell Scalpel
				{ 14, 44174 },	-- Stave of Shrouded Mysteries
				{ 16, "f1090rep8" },
				{ 17, 44180 },	-- Robes of Crackling Flame
				{ 18, 44181 },	-- Ghostflicker Waistband
				{ 19, 44182 },	-- Boots of Twinkling Stars
				{ 20, 44183 },	-- Fireproven Gauntlets
				{ 21, 41718, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Design: Brilliant Scarlet Ruby (p12 390)
				{ 22, 42188, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Sapphire Spellthread (p8 430)
			},
		},
		{	--KnightsoftheEbonBlade
			FactionID = 1098,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1098rep5" },
				{ 2, 41562, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Design: Deadly Huge Citrine (p12 350)
				{ 3, 43155, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Ebon Blade
				{ 5, "f1098rep7" },
				{ 6, 44256 },	-- Sterile Flesh-Handling Gloves
				{ 7, 44258 },	-- Wound-Binder's Wristguards
				{ 8, 44257 },	-- Spaulders of the Black Arrow
				{ 9, 44250 },	-- Reaper of Dark Souls
				{ 10, 44249 },	-- Runeblade of Demonstrable Power
				{ 11, 41721, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Design: Deadly Monarch Topaz (p12 390)
				{ 12, 42183, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Abyssal Bag (p8 435)
				{ 16, "f1098rep6" },
				{ 17, 44242 },	-- Dark Soldier Cape
				{ 18, 44243 },	-- Toxin-Tempered Sabatons
				{ 19, 44241 },	-- Unholy Persuader
				{ 21, "f1098rep8" },
				{ 22, 44302 },	-- Belt of Dark Mending
				{ 23, 44303 },	-- Darkheart Chestguard
				{ 24, 44305 },	-- Kilt of Dark Mercy
				{ 25, 44306 },	-- Death-Inured Sabatons
				{ 26, 41725, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Design: Timeless Twilight Opal (p12 390)
			},
		},
		{	--TheAshenVerdict
			FactionID = 1156,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, 50375, [QUEST_EXTRA_ITTYPE] = 24815 },	-- Ashen Band of Courage
				{ 2, 50388, [QUEST_EXTRA_ITTYPE] = 24827 },	-- Ashen Band of Greater Courage
				{ 3, 50403, [QUEST_EXTRA_ITTYPE] = 24834 },	-- Ashen Band of Unmatched Courage
				{ 4, 50404, [QUEST_EXTRA_ITTYPE] = 24835 },	-- Ashen Band of Endless Courage
				{ 6, 50377, [QUEST_EXTRA_ITTYPE] = 24815 },	-- Ashen Band of Destruction
				{ 7, 50384, [QUEST_EXTRA_ITTYPE] = 24828 },	-- Ashen Band of Greater Destruction
				{ 8, 50397, [QUEST_EXTRA_ITTYPE] = 24823 },	-- Ashen Band of Unmatched Destruction
				{ 9, 50398, [QUEST_EXTRA_ITTYPE] = 24829 },	-- Ashen Band of Endless Destruction
				{ 11, 52569, [QUEST_EXTRA_ITTYPE] = 24815 },	-- Ashen Band of Might
				{ 12, 52570, [QUEST_EXTRA_ITTYPE] = 25239 },	-- Ashen Band of Greater Might
				{ 13, 52571, [QUEST_EXTRA_ITTYPE] = 25240 },	-- Ashen Band of Unmatched Might
				{ 14, 52572, [QUEST_EXTRA_ITTYPE] = 25242 },	-- Ashen Band of Endless Might
				{ 16, 50376, [QUEST_EXTRA_ITTYPE] = 24815 },	-- Ashen Band of Vengeance
				{ 17, 50387, [QUEST_EXTRA_ITTYPE] = 24826 },	-- Ashen Band of Greater Vengeance
				{ 18, 50401, [QUEST_EXTRA_ITTYPE] = 24832 },	-- Ashen Band of Unmatched Vengeance
				{ 19, 50402, [QUEST_EXTRA_ITTYPE] = 24833 },	-- Ashen Band of Endless Vengeance
				{ 21, 50378, [QUEST_EXTRA_ITTYPE] = 24815 },	-- Ashen Band of Wisdom
				{ 22, 50386, [QUEST_EXTRA_ITTYPE] = 24825 },	-- Ashen Band of Greater Wisdom
				{ 23, 50399, [QUEST_EXTRA_ITTYPE] = 24830 },	-- Ashen Band of Unmatched Wisdom
				{ 24, 50400, [QUEST_EXTRA_ITTYPE] = 24831 },	-- Ashen Band of Endless Wisdom
				{ 101, "f1156rep6" },
				{ 102, 49974, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Plans: Boots of Kingly Upheaval (p2 450)
				{ 103, 49972, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Plans: Hellfrozen Bonegrinders (p2 450)
				{ 104, 49970, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Plans: Protectors of Life (p2 450)
				{ 105, 49958, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Blessed Cenarion Boots (p7 450)
				{ 106, 49963, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Earthsoul Boots (p7 450)
				{ 107, 49961, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Footpads of Impending Death (p7 450)
				{ 108, 49966, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Rock-Steady Treads (p7 450)
				{ 109, 49954, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Deathfrost Boots (p8 450)
				{ 110, 49956, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Sandals of Consecration (p8 450)
				{ 116, "f1156rep7" },
				{ 117, 49971, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Plans: Legplates of Painful Death (p2 450)
				{ 118, 49973, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Plans: Pillars of Might (p2 450)
				{ 119, 49969, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Plans: Puresteel Legplates (p2 450)
				{ 120, 49959, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Bladeborn Leggings (p7 450)
				{ 121, 49965, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Draconic Bonesplinter Legguards (p7 450)
				{ 122, 49957, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Legwraps of Unleashed Nature (p7 450)
				{ 123, 49962, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Lightning-Infused Leggings (p7 450)
				{ 124, 49953, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Leggings of Woven Death (p8 450)
				{ 125, 49955, [PRICE_EXTRA_ITTYPE] = "49908:1" },	-- Pattern: Lightweave Leggings (p8 450)
			},
		},
		{	--TheKaluak
			FactionID = 1073,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1073rep5" },
				{ 2, 41568, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Design: Purified Shadow Crystal (p12 350)
				{ 3, 44049, [PRICE_EXTRA_ITTYPE] = "money:16000" },	-- Freshly-Speared Emperor Salmon
				{ 5, "f1073rep6" },
				{ 6, 44061 },	-- Pigment-Stained Robes
				{ 7, 44062 },	-- Turtle-Minders Robe
				{ 8, 44054 },	-- Whale-Skin Breastplate
				{ 9, 44055 },	-- Whale-Skin Vest
				{ 10, 44059 },	-- Cuttlefish Scale Breastplate
				{ 11, 44060 },	-- Cuttlefish Tooth Ringmail
				{ 12, 44057 },	-- Ivory-Reinforced Chestguard
				{ 13, 44058 },	-- Whalebone Carapace
				{ 14, 41574, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Design: Defender's Shadow Crystal (p12 350)
				{ 16, "f1073rep7" },
				{ 17, 44051 },	-- Traditional Flensing Knife
				{ 18, 44052 },	-- Totemic Purification Rod
				{ 19, 44053 },	-- Whale-Stick Harpoon
				{ 20, 44509, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Trapper's Traveling Pack (p7 415)
				{ 21, 45774, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Emerald Bag (p8 435)
				{ 23, "f1073rep8" },
				{ 24, 44050 },	-- Mastercraft Kalu'ak Fishing Pole
				{ 25, 44723, "pet198", [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Nurtured Penguin Egg
			},
		},
		{	--TheOracles
			FactionID = 1105,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1105rep5" },
				{ 2, 41567, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Design: Nimble Dark Jade (p12 350)
				{ 3, 44065, [PRICE_EXTRA_ITTYPE] = "money:3200" },	-- Oracle Secret Solution
				{ 5, "f1105rep7" },
				{ 6, 44104 },	-- Fishy Cinch
				{ 7, 44106 },	-- Glitterscale Wrap
				{ 8, 44110 },	-- Sharkjaw Cap
				{ 9, 44109 },	-- Toothslice Helm
				{ 10, 44112 },	-- Glimmershell Shoulder Protectors
				{ 11, 44111 },	-- Gold Star Spaulders
				{ 12, 44108 },	-- Shinygem Rod
				{ 13, 41724, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Design: Misty Forest Emerald (p12 350)
				{ 14, 39878, [PRICE_EXTRA_ITTYPE] = "money:30000" },	-- Mysterious Egg
				{ 16, "f1105rep6" },
				{ 17, 44071, [PRICE_EXTRA_ITTYPE] = "money:16000" },	-- Slow-Roasted Eel
				{ 19, "f1105rep8" },
				{ 20, 44074 },	-- Oracle Talisman of Ablution
				{ 22, 39883 },	-- Cracked Egg
				{ 23, 44707, "mount" },	-- Reins of the Green Proto-Drake
				{ 24, 39898, "pet197" },	-- Cobra Hatchling
				{ 25, 44721, "pet196" },	-- Proto-Drake Whelp
				{ 26, 39896, "pet194" },	-- Tickbird Hatchling
				{ 27, 39899, "pet195" },	-- White Tickbird Hatchling
				{ 28, 44722 },	-- Aged Yolk
			},
		},
		{	--TheSilverCovenant
			FactionID = 1094,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f1094rep8" },
				{ 2, 46813, "mount", [PRICE_EXTRA_ITTYPE] = "champseal:150" },	-- Silver Covenant Hippogryph
				{ 3, 46815, "mount", [PRICE_EXTRA_ITTYPE] = "champseal:100" },	-- Quel'dorei Steed
				{ 4, 46820, "pet229", [PRICE_EXTRA_ITTYPE] = "champseal:40" },	-- Shimmering Wyrmling
				{ 5, 46817, [PRICE_EXTRA_ITTYPE] = "champseal:50" },	-- Silver Covenant Tabard
			},
		},
		{	--TheSonsofHodir
			FactionID = 1119,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1119rep6" },
				{ 2, 44190 },	-- Spaulders of Frozen Knives
				{ 3, 44189 },	-- Sash of the Wizened Wyrm
				{ 4, 44510, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Mammoth Mining Bag (p7 415)
				{ 5, 44131, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Lesser Inscription of the Axe
				{ 6, 44130, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Lesser Inscription of the Crag
				{ 7, 44132, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Lesser Inscription of the Pinnacle
				{ 8, 44129, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Lesser Inscription of the Storm
				{ 10, "f1119rep7" },
				{ 11, [ATLASLOOT_IT_ALLIANCE] = 43958, [ATLASLOOT_IT_HORDE] = 44080, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000000" },	-- Reins of the Ice Mammoth
				{ 12, 44194 },	-- Giant-Friend Kilt
				{ 13, 44195 },	-- Spaulders of the Giant Lords
				{ 14, 44193 },	-- Broken Stalactite
				{ 15, 44192 },	-- Stalactite Chopper
				{ 16, "f1119rep8" },
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 43961, [ATLASLOOT_IT_HORDE] = 44086, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000000" },	-- Reins of the Grand Ice Mammoth
				{ 18, 44133, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Greater Inscription of the Axe
				{ 19, 44134, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Greater Inscription of the Crag
				{ 20, 44136, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Greater Inscription of the Pinnacle
				{ 21, 44135, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Greater Inscription of the Storm
				{ 22, 41720, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Design: Smooth Autumn's Glow (p12 390)
				{ 23, 42184, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Glacial Bag (p8 445)
			},
		},
		{	--TheSunreavers
			FactionID = 1124,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f1124rep8" },
				{ 2, 46814, "mount", [PRICE_EXTRA_ITTYPE] = "champseal:150" },	-- Sunreaver Dragonhawk
				{ 3, 46816, "mount", [PRICE_EXTRA_ITTYPE] = "champseal:100" },	-- Sunreaver Hawkstrider
				{ 4, 46821, "pet229", [PRICE_EXTRA_ITTYPE] = "champseal:40" },	-- Shimmering Wyrmling
				{ 5, 46818, [PRICE_EXTRA_ITTYPE] = "champseal:50" },	-- Sunreaver Tabard
			},
		},
		{	--TheWyrmrestAccord
			FactionID = 1091,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1091rep5" },
				{ 2, 43156, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Wyrmrest Accord
				{ 4, "f1091rep6" },
				{ 5, 44188 },	-- Cloak of Peaceful Resolutions
				{ 6, 44196 },	-- Sash of the Wizened Wyrm
				{ 7, 44197 },	-- Bracers of Accorded Courtesy
				{ 8, 44187 },	-- Fang of Truth
				{ 10, "f1091rep7" },
				{ 11, 44200 },	-- Ancestral Sinew Wristguards
				{ 12, 44198 },	-- Breastplate of the Solemn Council
				{ 13, 44201 },	-- Sabatons of Draconic Vigor
				{ 14, 44199 },	-- Gavel of the Brewing Storm
				{ 15, 42185, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Mysterious Bag (p8 440)
				{ 16, "f1091rep8" },
				{ 17, 44202 },	-- Sandals of Crimson Fury
				{ 18, 44203 },	-- Dragonfriend Bracers
				{ 19, 44204 },	-- Grips of Fierce Pronouncements
				{ 20, 44205 },	-- Legplates of Bloody Reprisal
				{ 21, 43955, "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" },	-- Reins of the Red Drake
				{ 22, 41722, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Design: Stalwart Monarch Topaz (p12 390)
			},
		},
	},
}

data["BCFACTIONS"] = {
	name = AL["Burning Crusade"],
	ContentType = FACTION_CONTENT,
	items = {
		{	--AshtongueDeathsworn
			FactionID = 1012,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1012rep5" },
				{ 2, 32444, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Shadesteel Girdle (p2 375)
				{ 3, 32442, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Shadesteel Bracers (p2 375)
				{ 4, 32436, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Redeemed Soul Cinch (p7 375)
				{ 5, 32435, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Redeemed Soul Legguards (p7 375)
				{ 6, 32430, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Bracers of Shackled Souls (p7 375)
				{ 7, 32429, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Boots of Shackled Souls (p7 375)
				{ 8, 32440, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Soulguard Girdle (p8 375)
				{ 9, 32438, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Soulguard Bracers (p8 375)
				{ 16, "f1012rep6" },
				{ 17, 32443, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Shadesteel Greaves (p2 375)
				{ 18, 32441, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Shadesteel Sabots (p2 375)
				{ 19, 32433, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Redeemed Soul Mocassins (p7 375)
				{ 20, 32434, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Redeemed Soul Wristguards (p7 375)
				{ 21, 32431, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Greaves of Shackled Souls (p7 375)
				{ 22, 32432, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Waistguard of Shackled Souls (p7 375)
				{ 23, 32447, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Night's End (p8 375)
				{ 24, 32439, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Soulguard Leggings (p8 375)
				{ 25, 32437, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Soulguard Slippers (p8 375)
				{ 101, "f1012rep8" },
				{ 102, 32486 },	-- Ashtongue Talisman of Equilibrium
				{ 103, 32487 },	-- Ashtongue Talisman of Swiftness
				{ 104, 32488 },	-- Ashtongue Talisman of Insight
				{ 105, 32489 },	-- Ashtongue Talisman of Zeal
				{ 106, 32490 },	-- Ashtongue Talisman of Acumen
				{ 107, 32492 },	-- Ashtongue Talisman of Lethality
				{ 108, 32491 },	-- Ashtongue Talisman of Vision
				{ 109, 32493 },	-- Ashtongue Talisman of Shadows
				{ 110, 32485 },	-- Ashtongue Talisman of Valor
			},
		},
		{	--CenarionExpedition
			FactionID = 942,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f942rep5" },
				{ 2, 25737, [PRICE_EXTRA_ITTYPE] = "money:140000" },	-- Pattern: Heavy Clefthoof Boots (p7 355)
				{ 3, 23814, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Schematic: Green Smoke Flare (p5 335)
				{ 4, 24429, [PRICE_EXTRA_ITTYPE] = "money:8000" },	-- Expedition Flare
				{ 16, "f942rep6" },
				{ 17, 25838 },	-- Warden's Hauberk
				{ 18, 25836 },	-- Preserver's Cudgel
				{ 19, 25835 },	-- Explorer's Walking Stick
				{ 20, 25735, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Heavy Clefthoof Vest (p7 360)
				{ 21, 25736, [PRICE_EXTRA_ITTYPE] = "money:140000" },	-- Pattern: Heavy Clefthoof Leggings (p7 355)
				{ 22, 25869, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Transmute Earthstorm Diamond (p1 350)
				{ 23, 32070, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Recipe: Earthen Elixir (p1 320)
				{ 24, 23618, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Adamantite Sharpening Stone (p2 350)
				{ 25, 28632, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Adamantite Weightstone (p2 350)
				{ 26, 25526, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Greater Rune of Warding (p2 350)
				{ 27, 29720, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Clefthide Leg Armor (p7 335)
				{ 101, "f942rep7" },
				{ 102, 31392, [PRICE_EXTRA_ITTYPE] = "money:240000" },	-- Plans: Wildguard Helm (p2 375)
				{ 103, 31391, [PRICE_EXTRA_ITTYPE] = "money:240000" },	-- Plans: Wildguard Leggings (p2 375)
				{ 104, 29174 },	-- Watcher's Cowl
				{ 105, 29173 },	-- Strength of the Untamed
				{ 106, 24183, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Nightseye Panther (p12 370)
				{ 107, 22918, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Transmute Primal Water to Air (p1 350)
				{ 108, 28271, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Formula: Enchant Gloves - Spell Strike (p4 360)
				{ 116, "f942rep8" },
				{ 117, 29170 },	-- Windcaller's Orb
				{ 118, 29172 },	-- Ashyen's Gift
				{ 119, 29171 },	-- Earthwarden
				{ 120, 33999, "mount", [PRICE_EXTRA_ITTYPE] = "money:20000000" },	-- Cenarion War Hippogryph
				{ 121, 31390, [PRICE_EXTRA_ITTYPE] = "money:240000" },	-- Plans: Wildguard Breastplate (p2 375)
				{ 122, 31402, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: The Natural Ward (p12 375)
				{ 123, 33149, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Cloak - Stealth (p4 300)
				{ 124, 31356, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Recipe: Flask of Distilled Wisdom (p1 300)
				{ 125, 22922, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Recipe: Major Nature Protection Potion (p1 360)
				{ 126, 29721, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Nethercleft Leg Armor (p7 365)
				{ 127, 31804, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Cenarion Expedition Tabard
			},
		},
		{	--Exodar
			FactionID = 930,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f930rep4" },
				{ 2, 45580, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Exodar Tabard
				{ 4, "f930rep7" },
				{ 5, 67527, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Exodar Satchel
				{ 7, "f930rep8" },
				{ 8, 64890 },	-- Cape of Exodar
				{ 9, 64889 },	-- Mantle of Exodar
				{ 10, 64891 },	-- Shroud of Exodar
				{ 16, 29745, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Great Blue Elekk
				{ 17, 29746, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Great Green Elekk
				{ 18, 29747, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Great Purple Elekk
				{ 19, 28481, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Brown Elekk
				{ 20, 29744, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Gray Elekk
				{ 21, 29743, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Purple Elekk
			},
		},
		{	--HonorHold
			FactionID = 946,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f946rep5" },
				{ 2, 29213, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Felstalker Belt (p7 350)
				{ 3, 23142, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Regal Deep Peridot (p12 315)
				{ 4, 22531, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Formula: Enchant Bracer - Superior Healing (p4 325)
				{ 5, 24007, [PRICE_EXTRA_ITTYPE] = "money:2000" },	-- Footman's Waterskin
				{ 6, 24008, [PRICE_EXTRA_ITTYPE] = "money:4500" },	-- Dried Mushroom Rations
				{ 8, "f946rep6" },
				{ 9, 25826 },	-- Sage's Band
				{ 10, 25825 },	-- Footman's Longsword
				{ 11, 29214, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Felstalker Bracers (p7 360)
				{ 12, 29215, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Felstalker Breastplate (p7 360)
				{ 13, 25870, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Transmute Skyfire Diamond (p1 350)
				{ 14, 22905, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Recipe: Elixir of Major Agility (p1 330)
				{ 15, 29719, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Cobrahide Leg Armor (p7 335)
				{ 16, "f946rep7" },
				{ 17, 29169 },	-- Ring of Convalescence
				{ 18, 29166 },	-- Hellforged Halberd
				{ 19, 24180, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Dawnstone Crab (p12 370)
				{ 20, 22547, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Formula: Enchant Chest - Exceptional Stats (p4 345)
				{ 23, "f946rep8" },
				{ 24, 29153 },	-- Blade of the Archmage
				{ 25, 29156 },	-- Honor's Call
				{ 26, 29151 },	-- Veteran's Musket
				{ 27, 33150, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Cloak - Subtlety (p4 300)
				{ 28, 23619, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Felsteel Shield Spike (p2 360)
				{ 29, 29722, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Nethercobra Leg Armor (p7 365)
				{ 30, 23999, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Honor Hold Tabard
			},
		},
		{	--KeepersofTime
			FactionID = 989,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f989rep6" },
				{ 2, 28272, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Formula: Enchant Gloves - Major Spellpower (p4 360)
				{ 3, 22536, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Ring - Minor Intellect (p4 360)
				{ 4, 25910, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Enigmatic Skyfire Diamond (p12 365)
				{ 5, 33160, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Facet of Eternity (p12 360)
				{ 6, 29713, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Drums of Panic (p7 370)
				{ 8, "f989rep7" },
				{ 9, 29184 },	-- Timewarden's Leggings
				{ 10, 29185 },	-- Continuum Blade
				{ 11, 24181, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Living Ruby Serpent (p12 370)
				{ 12, 24174, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Pendant of Frozen Flame (p12 360)
				{ 13, 33158, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Stone of Blades (p12 360)
				{ 16, "f989rep8" },
				{ 17, 29183 },	-- Bindings of the Timewalker
				{ 18, 29181 },	-- Timelapse Shard
				{ 19, 29182 },	-- Riftmaker
				{ 20, 33152, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Gloves - Superior Agility (p4 300)
				{ 21, 31355, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Recipe: Flask of Supreme Power (p1 300)
				{ 22, 31777, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Keepers of Time Tabard
			},
		},
		{	--Kurenai
			FactionID = 978,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f978rep5" },
				{ 2, 29217, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Netherfury Belt (p7 340)
				{ 4, "f978rep6" },
				{ 5, 29219, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Netherfury Leggings (p7 340)
				{ 6, 34175, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Drums of Restoration (p7 350)
				{ 7, 34173, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Drums of Speed (p7 345)
				{ 8, 30444, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Reinforced Mining Bag (p7 325)
				{ 10, "f978rep7" },
				{ 11, 29148 },	-- Blackened Leather Spaulders
				{ 12, 29142 },	-- Kurenai Kilt
				{ 13, 29146 },	-- Band of Elemental Spirits
				{ 14, 29218, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Netherfury Boots (p7 350)
				{ 15, 30443, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Transmute Primal Fire to Earth (p1 350)
				{ 16, "f978rep8" },
				{ 17, 29227, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Reins of the Cobalt War Talbuk
				{ 18, 29229, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Reins of the Silver War Talbuk
				{ 19, 29230, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Reins of the Tan War Talbuk
				{ 20, 29231, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Reins of the White War Talbuk
				{ 21, 31830, "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" },	-- Reins of the Cobalt Riding Talbuk
				{ 22, 31832, "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" },	-- Reins of the Silver Riding Talbuk
				{ 23, 31834, "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" },	-- Reins of the Tan Riding Talbuk
				{ 24, 31836, "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" },	-- Reins of the White Riding Talbuk
				{ 25, 29140 },	-- Cloak of the Ancient Spirits
				{ 26, 29136 },	-- Far Seer's Helm
				{ 27, 29138 },	-- Arechron's Gift
				{ 28, 31774, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Kurenai Tabard
			},
		},
		{	--LowerCity
			FactionID = 1011,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1011rep5" },
				{ 2, 23138, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Potent Flame Spessarite (p12 325)
				{ 4, "f1011rep7" },
				{ 5, 30836 },	-- Leggings of the Skettis Exile
				{ 6, 30835 },	-- Salvager's Hauberk
				{ 7, 30841 },	-- Lower City Prayerbook
				{ 8, 24179, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Felsteel Boar (p12 370)
				{ 9, 24175, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Pendant of Thawing (p12 360)
				{ 10, 22910, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Elixir of Major Shadow Power (p1 350)
				{ 11, 33157, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Falling Star (p12 360)
				{ 16, "f1011rep6" },
				{ 17, 22538, [PRICE_EXTRA_ITTYPE] = "money:200000" },	-- Formula: Enchant Ring - Stats (p4 375)
				{ 18, 30833, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Cloak of Arcane Evasion (p8 350)
				{ 20, "f1011rep8" },
				{ 21, 30834 },	-- Shapeshifter's Signet
				{ 22, 30832 },	-- Gavel of Unearthed Secrets
				{ 23, 30830 },	-- Trident of the Outcast Tribe
				{ 24, 33148, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Cloak - Dodge (p4 300)
				{ 25, 31778, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Lower City Tabard
			},
		},
		{	--Netherwing
			FactionID = 1015,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1015rep5" },
				{ 2, 32694, [QUEST_EXTRA_ITTYPE] = 11053 },	-- Overseer's Badge
				{ 4, "f1015rep6" },
				{ 5, 32695, [QUEST_EXTRA_ITTYPE] = 11084 },	-- Captain's Badge
				{ 6, 32863, [QUEST_EXTRA_ITTYPE] = 11071 },	-- Skybreaker Whip
				{ 8, "f1015rep7" },
				{ 9, 32864, [QUEST_EXTRA_ITTYPE] = 11092 },	-- Commander's Badge
				{ 16, "f1015rep8" },
				{ 17, 32858, "mount", [QUEST_EXTRA_ITTYPE] = 11112 },	-- Reins of the Azure Netherwing Drake
				{ 18, 32859, "mount", [QUEST_EXTRA_ITTYPE] = 11109 },	-- Reins of the Cobalt Netherwing Drake
				{ 19, 32857, "mount", [QUEST_EXTRA_ITTYPE] = 11111 },	-- Reins of the Onyx Netherwing Drake
				{ 20, 32860, "mount", [QUEST_EXTRA_ITTYPE] = 11110 },	-- Reins of the Purple Netherwing Drake
				{ 21, 32861, "mount", [QUEST_EXTRA_ITTYPE] = 11114 },	-- Reins of the Veridian Netherwing Drake
				{ 22, 32862, "mount", [QUEST_EXTRA_ITTYPE] = 11113 },	-- Reins of the Violet Netherwing Drake
			},
		},
		{	--Ogrila
			FactionID = 1038,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1038rep5" },
				{ 2, 32910, [QUEST_EXTRA_ITTYPE] = 11091 },	-- Red Ogre Brew Special
				{ 3, 32909, [QUEST_EXTRA_ITTYPE] = 11091 },	-- Blue Ogre Brew Special
				{ 5, "f1038rep6" },
				{ 6, 32784, [PRICE_EXTRA_ITTYPE] = "32569:2" },	-- Red Ogre Brew
				{ 7, 32783, [PRICE_EXTRA_ITTYPE] = "32569:3" },	-- Blue Ogre Brew
				{ 16, "f1038rep7" },
				{ 17, 32653, [PRICE_EXTRA_ITTYPE] = "32572:1:32569:50" },	-- Apexis Cloak
				{ 18, 32654, [PRICE_EXTRA_ITTYPE] = "32572:1:32569:50" },	-- Crystalforged Trinket
				{ 19, 32652, [PRICE_EXTRA_ITTYPE] = "32572:1:32569:50" },	-- Ogri'la Aegis
				{ 20, 32650, [PRICE_EXTRA_ITTYPE] = "32572:1:32569:50" },	-- Cerulean Crystal Rod
				{ 22, "f1038rep8" },
				{ 23, 32647, [PRICE_EXTRA_ITTYPE] = "32572:4:32569:100" },	-- Shard-bound Bracers
				{ 24, 32648, [PRICE_EXTRA_ITTYPE] = "32572:4:32569:100" },	-- Vortex Walking Boots
				{ 25, 32651, [PRICE_EXTRA_ITTYPE] = "32572:4:32569:100" },	-- Crystal Orb of Enlightenment
				{ 26, 32645, [PRICE_EXTRA_ITTYPE] = "32572:4:32569:100" },	-- Crystalline Crossbow
				{ 27, 32828, [PRICE_EXTRA_ITTYPE] = "32569:10" },	-- Ogri'la Tabard
			},
		},
		{	--ShatariSkyguard
			FactionID = 1031,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1031rep5" },
				{ 2, 32722, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Enriched Terocone Juice
				{ 4, "f1031rep6" },
				{ 5, 32721, [PRICE_EXTRA_ITTYPE] = "money:4500" },	-- Skyguard Rations
				{ 7, "f1031rep7" },
				{ 8, 32539 },	-- Skyguard's Drape
				{ 9, 32538 },	-- Skywitch's Drape
				{ 16, "f1031rep8" },
				{ 17, 32770 },	-- Skyguard Silver Cross
				{ 18, 32771 },	-- Airman's Ribbon of Gallantry
				{ 19, 32319, "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Blue Riding Nether Ray
				{ 20, 32314, "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Green Riding Nether Ray
				{ 21, 32317, "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Red Riding Nether Ray
				{ 22, 32316, "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Purple Riding Nether Ray
				{ 23, 32318, "mount", [PRICE_EXTRA_ITTYPE] = "money:2000000" },	-- Silver Riding Nether Ray
				{ 24, 38628, "pet186", [PRICE_EXTRA_ITTYPE] = "money:400000" },	-- Nether Ray Fry
				{ 25, 32445, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Skyguard Tabard
			},
		},
		{	--ShatteredSunOffensive
			FactionID = 1077,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f1077rep5" },
				{ 2, 35244, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Bold Crimson Spinel (p12 375)
				{ 3, 35255, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Brilliant Crimson Spinel (p12 375)
				{ 4, 35246, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Delicate Crimson Spinel (p12 375)
				{ 5, 35260, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Smooth Lionseye (p12 375)
				{ 6, 35263, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Solid Empyrean Sapphire (p12 375)
				{ 7, 35264, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Sparkling Empyrean Sapphire (p12 375)
				{ 8, 35261, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Subtle Lionseye (p12 375)
				{ 9, 34780 },	-- Naaru Ration
				{ 16, "f1077rep6" },
				{ 17, 35266, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Glinting Shadowsong Amethyst (p12 375)
				{ 18, 35253, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Jagged Seaspray Emerald (p12 375)
				{ 19, 35269, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Potent Pyrestone (p12 375)
				{ 20, 35251, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Purified Shadowsong Amethyst (p12 375)
				{ 21, 35254, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Radiant Seaspray Emerald (p12 375)
				{ 22, 35239, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Timeless Shadowsong Amethyst (p12 375)
				{ 23, 34872, [PRICE_EXTRA_ITTYPE] = "money:150000" },	-- Formula: Void Shatter (p4 375)
				{ 24, 35500, [PRICE_EXTRA_ITTYPE] = "money:150000" },	-- Formula: Enchant Chest - Dodge (p4 360)
				{ 101, "f1077rep7" },
				{ 102, 35769, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Forceful Seaspray Emerald (p12 375)
				{ 103, 35768, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Quick Lionseye (p12 375)
				{ 104, 35767, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Reckless Pyrestone (p12 375)
				{ 105, 35766, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Steady Seaspray Emerald (p12 375)
				{ 106, 34665 },	-- Bombardier's Blade
				{ 107, 34667 },	-- Archmage's Guile
				{ 108, 34672 },	-- Inuuro's Blade
				{ 109, 34666 },	-- The Sunbreaker
				{ 110, 34671 },	-- K'iru's Presage
				{ 111, 34670 },	-- Seeker's Gavel
				{ 112, 34673 },	-- Legionfoe
				{ 113, 34674 },	-- Truestrike Crossbow
				{ 117, 35697, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Design: Figurine - Crimson Serpent (p12 375)
				{ 118, 35695, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Design: Figurine - Empyrean Tortoise (p12 375)
				{ 119, 35696, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Design: Figurine - Khorium Boar (p12 375)
				{ 120, 35699, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Design: Figurine - Seaspray Albatross (p12 375)
				{ 121, 35698, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Design: Figurine - Shadowsong Panther (p12 375)
				{ 122, 35271, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Deadly Pyrestone (p12 375)
				{ 123, 35252, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Regal Seaspray Emerald (p12 375)
				{ 124, 35259, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Rigid Empyrean Sapphire (p12 375)
				{ 125, 35505, [PRICE_EXTRA_ITTYPE] = "money:150000" },	-- Design: Ember Skyfire Diamond (p12 370)
				{ 126, 35502, [PRICE_EXTRA_ITTYPE] = "money:150000" },	-- Design: Eternal Earthstorm Diamond (p12 370)
				{ 127, 35708, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Regal Talasite (p12 350)
				{ 201, "f1077rep8" },
				{ 202, 34678 },	-- Shattered Sun Pendant of Acumen
				{ 203, 34679 },	-- Shattered Sun Pendant of Might
				{ 204, 34680 },	-- Shattered Sun Pendant of Resolve
				{ 205, 34677 },	-- Shattered Sun Pendant of Restoration
				{ 206, 34676 },	-- Dawnforged Defender
				{ 207, 34675 },	-- Sunward Crest
				{ 208, 35325, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Forceful Talasite (p12 350)
				{ 209, 35322, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Quick Dawnstone (p12 350)
				{ 210, 35323, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Reckless Noble Topaz (p12 350)
				{ 211, 35221, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tabard of the Shattered Sun
				{ 217, 35247, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Flashing Crimson Spinel (p12 375)
				{ 218, 35267, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Inscribed Pyrestone (p12 375)
				{ 219, 35258, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Mystic Lionseye (p12 375)
				{ 220, 35242, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Shifting Shadowsong Amethyst (p12 375)
				{ 221, 35243, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Sovereign Shadowsong Amethyst (p12 375)
				{ 222, 35265, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Stormy Empyrean Sapphire (p12 375)
				{ 223, 35270, [PRICE_EXTRA_ITTYPE] = "money:500000" },	-- Design: Veiled Shadowsong Amethyst (p12 375)
				{ 224, 35755, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Recipe: Assassin's Alchemist Stone (p1 375)
				{ 225, 35752, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Recipe: Guardian's Alchemist Stone (p1 375)
				{ 226, 35754, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Recipe: Redeemer's Alchemist Stone (p1 375)
				{ 227, 35753, [PRICE_EXTRA_ITTYPE] = "money:250000" },	-- Recipe: Sorcerer's Alchemist Stone (p1 375)
			},
		},
		{	--SilvermoonCity
			FactionID = 911,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f911rep4" },
				{ 2, 45585, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Silvermoon City Tabard
				{ 4, "f911rep7" },
				{ 5, 67535, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Silvermoon Satchel
				{ 7, "f911rep8" },
				{ 8, 64915 },	-- Cape of Silvermoon
				{ 9, 64916 },	-- Mantle of Silvermoon
				{ 10, 64914 },	-- Shroud of Silvermoon
				{ 16, 29223, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Green Hawkstrider
				{ 17, 28936, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Pink Hawkstrider
				{ 18, 29224, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Purple Hawkstrider
				{ 19, 29221, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Black Hawkstrider
				{ 20, 29220, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Blue Hawkstrider
				{ 21, 29222, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Purple Hawkstrider
				{ 22, 28927, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Red Hawkstrider
			},
		},
		{	--Sporeggar
			FactionID = 970,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f970rep5" },
				{ 2, 30156, [PRICE_EXTRA_ITTYPE] = "24245:1" },	-- Recipe: Clam Bar (p3 300)
				{ 3, 24539, [PRICE_EXTRA_ITTYPE] = "24245:1" },	-- Marsh Lichen
				{ 4, 25548, [PRICE_EXTRA_ITTYPE] = "24245:2" },	-- Tallstalk Mushroom
				{ 6, "f970rep6" },
				{ 7, 25827, [PRICE_EXTRA_ITTYPE] = "24245:25" },	-- Muck-Covered Drape
				{ 8, 25828, [PRICE_EXTRA_ITTYPE] = "24245:15" },	-- Petrified Lichen Guard
				{ 9, 25550, [PRICE_EXTRA_ITTYPE] = "24245:1" },	-- Redcap Toadstool
				{ 16, "f970rep7" },
				{ 17, 29150, [PRICE_EXTRA_ITTYPE] = "24245:45" },	-- Hardened Stone Shard
				{ 18, 29149, [PRICE_EXTRA_ITTYPE] = "24245:20" },	-- Sporeling's Firestick
				{ 19, 22916, [PRICE_EXTRA_ITTYPE] = "24245:25" },	-- Recipe: Transmute Primal Earth to Water (p1 350)
				{ 20, 38229, [PRICE_EXTRA_ITTYPE] = "24245:25" },	-- Pattern: Mycah's Botanical Bag (p8 375)
				{ 22, "f970rep8" },
				{ 23, 34478, "pet167", [PRICE_EXTRA_ITTYPE] = "24245:30" },	-- Tiny Sporebat
				{ 24, 22906, [PRICE_EXTRA_ITTYPE] = "24245:30" },	-- Recipe: Shrouding Potion (p1 335)
				{ 25, 31775, [PRICE_EXTRA_ITTYPE] = "24245:10" },	-- Sporeggar Tabard
			},
		},
		{	--TheAldor
			FactionID = 932,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f932rep5" },
				{ 2, 23149, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Design: Smooth Golden Draenite (p12 305)
				{ 3, 23601, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Flamebane Bracers (p2 350)
				{ 4, 30842, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Flameheart Bracers (p8 350)
				{ 16, "f932rep6" },
				{ 17, 29129 },	-- Anchorite's Robes
				{ 18, 28881, [PRICE_EXTRA_ITTYPE] = "29735:2" },	-- Inscription of Discipline
				{ 19, 28878, [PRICE_EXTRA_ITTYPE] = "29735:2" },	-- Inscription of Faith
				{ 20, 28885, [PRICE_EXTRA_ITTYPE] = "29735:2" },	-- Inscription of Vengeance
				{ 21, 28882, [PRICE_EXTRA_ITTYPE] = "29735:2" },	-- Inscription of Warding
				{ 22, 23145, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Design: Purified Shadow Draenite (p12 305)
				{ 23, 23603, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Flamebane Gloves (p2 360)
				{ 24, 29704, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Blastguard Belt (p7 350)
				{ 25, 29693, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Flamescale Belt (p7 350)
				{ 26, 30843, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Flameheart Gloves (p8 360)
				{ 27, 24293, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Silver Spellthread (p8 335)
				{ 101, "f932rep7" },
				{ 102, 29127 },	-- Vindicator's Hauberk
				{ 103, 29128 },	-- Lightwarden's Band
				{ 104, 29130 },	-- Auchenai Staff
				{ 105, 24177, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Pendant of Shadow's End (p12 360)
				{ 106, 23604, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Flamebane Breastplate (p2 365)
				{ 107, 29703, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Blastguard Boots (p7 350)
				{ 108, 29691, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Flamescale Boots (p7 350)
				{ 109, 25721, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Vindicator's Armor Kit (p7 325)
				{ 116, "f932rep8" },
				{ 117, 29123 },	-- Medallion of the Lightbearer
				{ 118, 29124 },	-- Vindicator's Brand
				{ 119, 28886, [PRICE_EXTRA_ITTYPE] = "29735:8" },	-- Greater Inscription of Discipline
				{ 120, 28887, [PRICE_EXTRA_ITTYPE] = "29735:8" },	-- Greater Inscription of Faith
				{ 121, 28888, [PRICE_EXTRA_ITTYPE] = "29735:8" },	-- Greater Inscription of Vengeance
				{ 122, 28889, [PRICE_EXTRA_ITTYPE] = "29735:8" },	-- Greater Inscription of Warding
				{ 123, 23602, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Flamebane Helm (p2 355)
				{ 124, 29702, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Blastguard Pants (p7 350)
				{ 125, 29689, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Flamescale Leggings (p7 350)
				{ 126, 24295, [PRICE_EXTRA_ITTYPE] = "money:360000" },	-- Pattern: Golden Spellthread (p8 375)
				{ 127, 30844, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Pattern: Flameheart Vest (p8 370)
				{ 128, 31779, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Aldor Tabard
			},
		},
		{	--TheConsortium
			FactionID = 933,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f933rep5" },
				{ 2, 25732, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Fel Leather Gloves (p7 340)
				{ 3, 28274, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Formula: Enchant Cloak - PvP Power (p4 325)
				{ 4, 23146, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Shifting Shadow Draenite (p12 315)
				{ 5, 23136, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Design: Reckless Flame Spessarite (p12 305)
				{ 16, "f933rep6" },
				{ 17, 29457 },	-- Nethershard
				{ 18, 29456 },	-- Gift of the Ethereal
				{ 19, 25733, [PRICE_EXTRA_ITTYPE] = "money:140000" },	-- Pattern: Fel Leather Boots (p7 350)
				{ 20, 23134, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Delicate Blood Garnet (p12 305)
				{ 21, 23155, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Sparkling Azure Moonstone (p12 325)
				{ 22, 23150, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Subtle Golden Draenite (p12# (315)
				{ 23, 22552, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Formula: Enchant Weapon - Major Striking (p4 340)
				{ 24, 25908, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Swift Skyfire Diamond (p12 365)
				{ 25, 25902, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Powerful Earthstorm Diamond (p12 365)
				{ 26, 24314, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Bag of Jewels (p8 340)
				{ 101, "f933rep7" },
				{ 102, 29117 },	-- Stormspire Vest
				{ 103, 29116 },	-- Nomad's Leggings
				{ 104, 29115 },	-- Consortium Blaster
				{ 105, 24178, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Pendant of the Null Rune (p12 360)
				{ 106, 25734, [PRICE_EXTRA_ITTYPE] = "money:140000" },	-- Pattern: Fel Leather Leggings (p7 350)
				{ 107, 22535, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Ring - Striking (p4 360)
				{ 108, 23874, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Schematic: Elemental Seaforium Charge (p5 350)
				{ 109, 25903, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Bracing Earthstorm Diamond (p12 365)
				{ 110, 33156, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Crimson Sun (p12 360)
				{ 111, 33305, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Don Julio's Heart (p12 360)
				{ 116, "f933rep8" },
				{ 117, 29122 },	-- Nether Runner's Cowl
				{ 118, 29119 },	-- Haramad's Bargain
				{ 119, 29121 },	-- Guile of Khoraazi
				{ 120, 33622, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Relentless Earthstorm Diamond (p12 365)
				{ 121, 31776, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Consortium Tabard
			},
		},
		{	--TheMaghar
			FactionID = 941,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f941rep5" },
				{ 2, 25741, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Netherfury Belt (p7 340)
				{ 4, "f941rep6" },
				{ 5, 25742, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Netherfury Leggings (p7 340)
				{ 6, 34174, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Drums of Restoration (p7 350)
				{ 7, 34172, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Drums of Speed (p7 345)
				{ 8, 29664, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Reinforced Mining Bag (p7 325)
				{ 10, "f941rep7" },
				{ 11, 29147 },	-- Talbuk Hide Spaulders
				{ 12, 29141 },	-- Tempest Leggings
				{ 13, 29145 },	-- Band of Ancestral Spirits
				{ 14, 25743, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Netherfury Boots (p7 350)
				{ 15, 22917, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Transmute Primal Fire to Earth (p1 350)
				{ 16, "f941rep8" },
				{ 17, 29102, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Reins of the Cobalt War Talbuk
				{ 18, 29104, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Reins of the Silver War Talbuk
				{ 19, 29105, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Reins of the Tan War Talbuk
				{ 20, 29103, "mount", [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Reins of the White War Talbuk
				{ 21, 31829, "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" },	-- Reins of the Cobalt Riding Talbuk
				{ 22, 31831, "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" },	-- Reins of the Silver Riding Talbuk
				{ 23, 31833, "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" },	-- Reins of the Tan Riding Talbuk
				{ 24, 31835, "mount", [PRICE_EXTRA_ITTYPE] = "money:700000" },	-- Reins of the White Riding Talbuk
				{ 25, 29139 },	-- Ceremonial Cover
				{ 26, 29135 },	-- Earthcaller's Headdress
				{ 27, 29137 },	-- Hellscream's Will
				{ 28, 31773, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Mag'har Tabard
			},
		},
		{	--TheScaleoftheSands
			FactionID = 990,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, 29298, [QUEST_EXTRA_ITTYPE] = 10462 },	-- Band of Eternity
				{ 2, 29299, [QUEST_EXTRA_ITTYPE] = 10466 },	-- Band of Eternity
				{ 3, 29300, [QUEST_EXTRA_ITTYPE] = 10470 },	-- Band of Eternity
				{ 4, 29301, [QUEST_EXTRA_ITTYPE] = 10474 },	-- Band of the Eternal Champion
				{ 6, 29294, [QUEST_EXTRA_ITTYPE] = 10460 },	-- Band of Eternity
				{ 7, 29295, [QUEST_EXTRA_ITTYPE] = 10467 },	-- Band of Eternity
				{ 8, 29296, [QUEST_EXTRA_ITTYPE] = 10471 },	-- Band of Eternity
				{ 9, 29297, [QUEST_EXTRA_ITTYPE] = 10475 },	-- Band of the Eternal Defender
				{ 16, 29302, [QUEST_EXTRA_ITTYPE] = 10463 },	-- Band of Eternity
				{ 17, 29303, [QUEST_EXTRA_ITTYPE] = 10464 },	-- Band of Eternity
				{ 18, 29304, [QUEST_EXTRA_ITTYPE] = 10468 },	-- Band of Eternity
				{ 19, 29305, [QUEST_EXTRA_ITTYPE] = 10472 },	-- Band of the Eternal Sage
				{ 21, 29307, [QUEST_EXTRA_ITTYPE] = 10461 },	-- Band of Eternity
				{ 22, 29306, [QUEST_EXTRA_ITTYPE] = 10465 },	-- Band of Eternity
				{ 23, 29308, [QUEST_EXTRA_ITTYPE] = 10469 },	-- Band of Eternity
				{ 24, 29309, [QUEST_EXTRA_ITTYPE] = 10473 },	-- Band of the Eternal Restorer
				{ 101, "f990rep5" },
				{ 102, 32274, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Bold Crimson Spinel (p12 375)
				{ 103, 32282, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Brilliant Crimson Spinel (p12 375)
				{ 104, 32277, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Delicate Crimson Spinel (p12 375)
				{ 105, 32286, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Solid Empyrean Sapphire (p12 375)
				{ 106, 32287, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Sparkling Empyrean Sapphire (p12 375)
				{ 107, 32291, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Smooth Lionseye (p12 375)
				{ 108, 32284, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Subtle Lionseye (p12 375)
				{ 110, "f990rep7" },
				{ 111, 32292, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Rigid Empyrean Sapphire (p12 375)
				{ 112, 32308, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Deadly Pyrestone (p12 375)
				{ 113, 32309, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Regal Seaspray Emerald (p12 375)
				{ 116, "f990rep6" },
				{ 117, 35763, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Quick Lionseye (p12 375)
				{ 118, 32304, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Potent Pyrestone (p12 375)
				{ 119, 35762, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Reckless Pyrestone (p12 375)
				{ 120, 32306, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Glinting Shadowsong Amethyst (p12 375)
				{ 121, 32311, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Purified Shadowsong Amethyst (p12 375)
				{ 122, 32301, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Timeless Shadowsong Amethyst (p12 375)
				{ 123, 35765, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Forceful Seaspray Emerald (p12 375)
				{ 124, 32312, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Jagged Seaspray Emerald (p12 375)
				{ 125, 32310, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Radiant Seaspray Emerald (p12 375)
				{ 126, 35764, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Steady Seaspray Emerald (p12 375)
			},
		},
		{	--TheScryers
			FactionID = 934,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f934rep5" },
				{ 2, 23133, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Brilliant Blood Garnet (p12 300)
				{ 3, 23597, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Enchanted Adamantite Belt (p2 355)
				{ 16, "f934rep6" },
				{ 17, 28907, [PRICE_EXTRA_ITTYPE] = "29736:2" },	-- Inscription of the Blade
				{ 18, 28908, [PRICE_EXTRA_ITTYPE] = "29736:2" },	-- Inscription of the Knight
				{ 19, 28904, [PRICE_EXTRA_ITTYPE] = "29736:2" },	-- Inscription of the Oracle
				{ 20, 28903, [PRICE_EXTRA_ITTYPE] = "29736:2" },	-- Inscription of the Orb
				{ 21, 23598, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Enchanted Adamantite Boots (p2 355)
				{ 22, 29701, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Enchanted Clefthoof Boots (p7 350)
				{ 23, 29682, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Enchanted Felscale Gloves (p7 350)
				{ 24, 24292, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Mystic Spellthread (p8 335)
				{ 101, "f934rep7" },
				{ 102, 29131 },	-- Retainer's Leggings
				{ 103, 29134 },	-- Gauntlets of the Chosen
				{ 104, 29132 },	-- Scryer's Bloodgem
				{ 105, 29133 },	-- Seer's Cane
				{ 106, 24176, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Pendant of Withering (p12 360)
				{ 107, 22908, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Recipe: Elixir of Major Firepower (p1 345)
				{ 108, 23599, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Enchanted Adamantite Breastplate (p2 360)
				{ 109, 29700, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Enchanted Clefthoof Gloves (p7 350)
				{ 110, 29684, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Enchanted Felscale Boots (p7 350)
				{ 111, 25722, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Magister's Armor Kit (p7 325)
				{ 116, "f934rep8" },
				{ 117, 29126 },	-- Seer's Signet
				{ 118, 29125 },	-- Retainer's Blade
				{ 119, 28910, [PRICE_EXTRA_ITTYPE] = "29736:8" },	-- Greater Inscription of the Blade
				{ 120, 28911, [PRICE_EXTRA_ITTYPE] = "29736:8" },	-- Greater Inscription of the Knight
				{ 121, 28912, [PRICE_EXTRA_ITTYPE] = "29736:8" },	-- Greater Inscription of the Oracle
				{ 122, 28909, [PRICE_EXTRA_ITTYPE] = "29736:8" },	-- Greater Inscription of the Orb
				{ 123, 23600, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Enchanted Adamantite Leggings (p2 365)
				{ 124, 29698, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Enchanted Clefthoof Leggings (p7 350)
				{ 125, 29677, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Enchanted Felscale Leggings (p7 350)
				{ 126, 24294, [PRICE_EXTRA_ITTYPE] = "money:360000" },	-- Pattern: Runic Spellthread (p8 375)
				{ 127, 31780, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Scryers Tabard
			},
		},
		{	--TheShatar
			FactionID = 935,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f935rep5" },
				{ 2, 25904, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Insightful Earthstorm Diamond (p12 365)
				{ 4, "f935rep7" },
				{ 5, 29180 },	-- Blessed Scale Girdle
				{ 6, 29179 },	-- Xi'ri's Gift
				{ 7, 24182, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Talasite Owl (p12 370)
				{ 8, 22915, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Transmute Primal Air to Fire (p1 350)
				{ 9, 28281, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Formula: Enchant Weapon - Major Healing (p4 350)
				{ 10, 13517, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Alchemist Stone (p1 350)
				{ 11, 33159, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Blood of Amber (p12 360)
				{ 16, "f935rep6" },
				{ 17, 30826, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Ring of Arcane Shielding (p12 360)
				{ 18, 28273, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Formula: Enchant Gloves - Major Healing (p4 350)
				{ 19, 33155, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Kailee's Rose (p12 360)
				{ 20, 29717, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Drums of Battle (p7 365)
				{ 22, "f935rep8" },
				{ 23, 29177 },	-- A'dal's Command
				{ 24, 29175 },	-- Gavel of Pure Light
				{ 25, 29176 },	-- Crest of the Sha'tar
				{ 26, 33153, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Gloves - Threat (p4 300)
				{ 27, 31354, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Recipe: Flask of the Titans (p1 300)
				{ 28, 31781, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Sha'tar Tabard
			},
		},
		{	--TheVioletEye
			FactionID = 967,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, 29280, [QUEST_EXTRA_ITTYPE] = 10731 },	-- Violet Signet
				{ 2, 29281, [QUEST_EXTRA_ITTYPE] = 10735 },	-- Violet Signet
				{ 3, 29282, [QUEST_EXTRA_ITTYPE] = 10740 },	-- Violet Signet
				{ 4, 29283, [QUEST_EXTRA_ITTYPE] = 10727 },	-- Violet Signet of the Master Assassin
				{ 6, 29284, [QUEST_EXTRA_ITTYPE] = 10729 },	-- Violet Signet
				{ 7, 29285, [QUEST_EXTRA_ITTYPE] = 10733 },	-- Violet Signet
				{ 8, 29286, [QUEST_EXTRA_ITTYPE] = 10738 },	-- Violet Signet
				{ 9, 29287, [QUEST_EXTRA_ITTYPE] = 10725 },	-- Violet Signet of the Archmage
				{ 16, 29288, [QUEST_EXTRA_ITTYPE] = 10730 },	-- Violet Signet
				{ 17, 29289, [QUEST_EXTRA_ITTYPE] = 10734 },	-- Violet Signet
				{ 18, 29291, [QUEST_EXTRA_ITTYPE] = 10739 },	-- Violet Signet
				{ 19, 29290, [QUEST_EXTRA_ITTYPE] = 10726 },	-- Violet Signet of the Grand Restorer
				{ 21, 29276, [QUEST_EXTRA_ITTYPE] = 10732 },	-- Violet Signet
				{ 22, 29277, [QUEST_EXTRA_ITTYPE] = 10736 },	-- Violet Signet
				{ 23, 29278, [QUEST_EXTRA_ITTYPE] = 10741 },	-- Violet Signet
				{ 24, 29279, [QUEST_EXTRA_ITTYPE] = 10728 },	-- Violet Signet of the Great Protector
				{ 101, "f967rep6" },
				{ 102, 31113, [QUEST_EXTRA_ITTYPE] = 9860 },	-- Violet Badge
				{ 103, 31395, [PRICE_EXTRA_ITTYPE] = "money:240000" },	-- Plans: Iceguard Helm (p2 375)
				{ 104, 31393, [PRICE_EXTRA_ITTYPE] = "money:240000" },	-- Plans: Iceguard Breastplate (p2 375)
				{ 105, 31401, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: The Frozen Eye (p12 375)
				{ 106, 29187, [PRICE_EXTRA_ITTYPE] = "money:300000" },	-- Inscription of Endurance
				{ 116, "f967rep7" },
				{ 117, 31394, [PRICE_EXTRA_ITTYPE] = "money:240000" },	-- Plans: Iceguard Leggings (p2 375)
				{ 118, 33205, [PRICE_EXTRA_ITTYPE] = "money:240000" },	-- Pattern: Shadowprowler's Chestguard (p7 365)
				{ 120, "f967rep8" },
				{ 121, 33124, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Cloak of Darkness (p7 360)
				{ 122, 33165, [PRICE_EXTRA_ITTYPE] = "money:30000" },	-- Formula: Enchant Weapon - Greater Agility (p4 350)
			},
		},
		{	--Thrallmar
			FactionID = 947,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f947rep5" },
				{ 2, 25738, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Felstalker Belt (p7 350)
				{ 3, 31359, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Design: Regal Deep Peridot (p12 315)
				{ 4, 24000, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Formula: Enchant Bracer - Superior Healing (p4 325)
				{ 5, 24006 },	-- Grunt's Waterskin
				{ 6, 24009 },	-- Dried Fruit Rations
				{ 8, "f947rep6" },
				{ 9, 25824 },	-- Farseer's Band
				{ 10, 25823 },	-- Grunt's Waraxe
				{ 11, 25739, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Felstalker Bracers (p7 360)
				{ 12, 25740, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Felstalker Breastplate (p7 360)
				{ 13, 29232, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Recipe: Transmute Skyfire Diamond (p1 350)
				{ 14, 24001, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Recipe: Elixir of Major Agility (p1 330)
				{ 15, 31361, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Cobrahide Leg Armor (p7 330)
				{ 16, "f947rep7" },
				{ 17, 29168 },	-- Ancestral Band
				{ 18, 29167 },	-- Blackened Spear
				{ 19, 31358, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Design: Dawnstone Crab (p12 370)
				{ 20, 24003, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Formula: Enchant Chest - Exceptional Stats (p4 345)
				{ 23, "f947rep8" },
				{ 24, 29155 },	-- Stormcaller
				{ 25, 29165 },	-- Warbringer
				{ 26, 29152 },	-- Marksman's Bow
				{ 27, 33151, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Cloak - Subtlety (p4 300)
				{ 28, 24002, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Felsteel Shield Spike (p2 360)
				{ 29, 31362, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Pattern: Nethercobra Leg Armor (p7 365)
				{ 30, 24004, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Thrallmar Tabard
			},
		},
		{	--Tranquillien
			FactionID = 922,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f922rep5" },
				{ 2, 22991 },	-- Apprentice Boots
				{ 3, 22992 },	-- Bogwalker Boots
				{ 4, 22993 },	-- Volunteer's Greaves
				{ 5, 28164 },	-- Tranquillien Flamberge
				{ 7, "f922rep6" },
				{ 8, 28155 },	-- Apothecary's Waistband
				{ 9, 28158 },	-- Batskin Belt
				{ 10, 28162 },	-- Tranquillien Defender's Girdle
				{ 16, "f922rep7" },
				{ 17, 22986 },	-- Apothecary's Robe
				{ 18, 22987 },	-- Deathstalker's Vest
				{ 19, 22985 },	-- Suncrown Hauberk
				{ 21, "f922rep8" },
				{ 22, 22990 },	-- Tranquillien Champion's Cloak
			},
		},
	},
}

data["CLASSICFACTIONS"] = {
	name = AL["Classic"],
	ContentType = FACTION_CONTENT,
	items = {
		{	--ArgentDawn
			FactionID = 529,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f529rep5" },
				{ 2, 13724, [PRICE_EXTRA_ITTYPE] = "money:6000" },	-- Enriched Manna Biscuit
				{ 4, "f529rep6" },
				{ 5, 13482, [PRICE_EXTRA_ITTYPE] = "money:15000" },	-- Recipe: Transmute Air to Fire (p1 275)
				{ 6, 19203, [PRICE_EXTRA_ITTYPE] = "money:22000" },	-- Plans: Girdle of the Dawn (p2 290)
				{ 7, 19446, [PRICE_EXTRA_ITTYPE] = "money:30000" },	-- Formula: Enchant Bracer - Mana Regeneration (p4 290)
				{ 8, 19442, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Powerful Anti-Venom (p6 300)
				{ 9, 19328, [PRICE_EXTRA_ITTYPE] = "money:22000" },	-- Pattern: Dawn Treaders (p7 290)
				{ 10, 19216, [PRICE_EXTRA_ITTYPE] = "money:22000" },	-- Pattern: Argent Boots (p8 290)
				{ 16, "f529rep7" },
				{ 17, 18171, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Arcane Mantle of the Dawn
				{ 18, 18169, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Flame Mantle of the Dawn
				{ 19, 18170, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Frost Mantle of the Dawn
				{ 20, 18172, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Nature Mantle of the Dawn
				{ 21, 18173, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Shadow Mantle of the Dawn
				{ 22, 19205, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Plans: Gloves of the Dawn (p2 300)
				{ 23, 19447, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Formula: Enchant Bracer - Healing Power (p4 300)
				{ 24, 19329, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Golden Mantle of the Dawn (p7 300)
				{ 25, 19217, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Argent Shoulders (p8 300)
				{ 26, 13810, [PRICE_EXTRA_ITTYPE] = "money:6000" },	-- Blessed Sunfruit
				{ 27, 13813, [PRICE_EXTRA_ITTYPE] = "money:6000" },	-- Blessed Sunfruit Juice
			},
		},
		{	--BloodsailBuccaneers
			FactionID = 87,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f87rep4" },
				{ 2, 22742, [QUEST_EXTRA_ITTYPE] = 9272 },	-- Bloodsail Shirt
				{ 3, 22743, [QUEST_EXTRA_ITTYPE] = 9272 },	-- Bloodsail Sash
				{ 4, 22745, [QUEST_EXTRA_ITTYPE] = 9272 },	-- Bloodsail Pants
				{ 5, 22744, [QUEST_EXTRA_ITTYPE] = 9272 },	-- Bloodsail Boots
				{ 16, "f87rep5" },
				{ 17, 12185, [QUEST_EXTRA_ITTYPE] = 4621 },	-- Bloodsail Admiral's Hat
			},
		},
		{	--BroodofNozdormu
			FactionID = 910,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, 21201, [QUEST_EXTRA_ITTYPE] = 8752 },	-- Signet Ring of the Bronze Dragonflight
				{ 2, 21202, [QUEST_EXTRA_ITTYPE] = 8753 },	-- Signet Ring of the Bronze Dragonflight
				{ 3, 21203, [QUEST_EXTRA_ITTYPE] = 8754 },	-- Signet Ring of the Bronze Dragonflight
				{ 4, 21204, [QUEST_EXTRA_ITTYPE] = 8755 },	-- Signet Ring of the Bronze Dragonflight
				{ 5, 21205, [QUEST_EXTRA_ITTYPE] = 8756 },	-- Signet Ring of the Bronze Dragonflight
				{ 7, 21206, [QUEST_EXTRA_ITTYPE] = 8757 },	-- Signet Ring of the Bronze Dragonflight
				{ 8, 21207, [QUEST_EXTRA_ITTYPE] = 8758 },	-- Signet Ring of the Bronze Dragonflight
				{ 9, 21208, [QUEST_EXTRA_ITTYPE] = 8759 },	-- Signet Ring of the Bronze Dragonflight
				{ 10, 21209, [QUEST_EXTRA_ITTYPE] = 8760 },	-- Signet Ring of the Bronze Dragonflight
				{ 11, 21210, [QUEST_EXTRA_ITTYPE] = 8761 },	-- Signet Ring of the Bronze Dragonflight
				{ 16, 21196, [QUEST_EXTRA_ITTYPE] = 8747 },	-- Signet Ring of the Bronze Dragonflight
				{ 17, 21197, [QUEST_EXTRA_ITTYPE] = 8748 },	-- Signet Ring of the Bronze Dragonflight
				{ 18, 21198, [QUEST_EXTRA_ITTYPE] = 8749 },	-- Signet Ring of the Bronze Dragonflight
				{ 19, 21199, [QUEST_EXTRA_ITTYPE] = 8750 },	-- Signet Ring of the Bronze Dragonflight
				{ 20, 21200, [QUEST_EXTRA_ITTYPE] = 8751 },	-- Signet Ring of the Bronze Dragonflight
			},
		},
		{	--CenarionCircle
			FactionID = 609,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f609rep5" },
				{ 2, 22209, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Plans: Heavy Obsidian Belt (p2 300)
				{ 3, 22768, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Plans: Ironvine Belt (p2 300)
				{ 4, 22769, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Bramblewood Belt (p7 300)
				{ 5, 20509, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Sandstalker Bracers (p7 300)
				{ 6, 20506, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Spitfire Bracers (p7 300)
				{ 7, 22772, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Sylvan Shoulders (p8 300)
				{ 8, 22310, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Pattern: Cenarion Herb Bag (p8 275)
				{ 16, "f609rep6" },
				{ 17, 22767, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Plans: Ironvine Gloves (p2 300)
				{ 18, 22214, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Plans: Light Obsidian Belt (p2 300)
				{ 19, 22770, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Bramblewood Boots (p7 300)
				{ 20, 20510, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Sandstalker Gauntlets (p7 300)
				{ 21, 20507, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Spitfire Gauntlets (p7 300)
				{ 22, 22773, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Sylvan Crown (p8 300)
				{ 101, "f609rep7" },
				{ 102, 22766, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Plans: Ironvine Breastplate (p2 300)
				{ 103, 22219, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Plans: Jagged Obsidian Shield (p2 300)
				{ 104, 22771, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Bramblewood Helm (p7 300)
				{ 105, 20511, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Sandstalker Breastplate (p7 300)
				{ 106, 20508, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Spitfire Breastplate (p7 300)
				{ 107, 22683, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Pattern: Gaea's Embrace (p8 300)
				{ 108, 22312, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Satchel of Cenarius (p8 300)
				{ 109, 22774, [PRICE_EXTRA_ITTYPE] = "money:50000" },	-- Pattern: Sylvan Vest (p8 300)
				{ 116, "f609rep8" },
				{ 117, 22221, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Obsidian Mail Tunic (p2 300)
				{ 118, 20382, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Dreamscale Breastplate (p7 300)
			},
		},
		{	--Darnassus
			FactionID = 69,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f69rep4" },
				{ 2, 45579, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Darnassus Tabard
				{ 4, "f69rep7" },
				{ 5, 67526, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Darnassian Satchel
				{ 7, "f69rep8" },
				{ 8, 64887 },	-- Cape of Darnassus
				{ 9, 64888 },	-- Mantle of Darnassus
				{ 10, 64886 },	-- Shroud of Darnassus
				{ 16, 18766, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Swift Frostsaber
				{ 17, 18767, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Swift Mistsaber
				{ 18, 18902, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Reins of the Swift Stormsaber
				{ 19, 8632, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Spotted Frostsaber
				{ 20, 47100, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Striped Dawnsaber
				{ 21, 8631, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Striped Frostsaber
				{ 22, 8629, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Reins of the Striped Nightsaber
			},
		},
		{	--DarkspearTrolls
			FactionID = 530,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f530rep4" },
				{ 2, 45582, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Darkspear Tabard
				{ 4, "f530rep7" },
				{ 5, 67536, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Darkspear Satchel
				{ 7, "f530rep8" },
				{ 8, 64912 },	-- Darkspear Cape
				{ 9, 64911 },	-- Darkspear Mantle
				{ 10, 64913 },	-- Darkspear Shroud
				{ 16, 18788, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Blue Raptor
				{ 17, 18789, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Olive Raptor
				{ 18, 18790, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Orange Raptor
				{ 19, 8588, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Whistle of the Emerald Raptor
				{ 20, 8591, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Whistle of the Turquoise Raptor
				{ 21, 8592, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Whistle of the Violet Raptor
			},
		},
		{	--Gnomeregan
			FactionID = 54,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f54rep4" },
				{ 2, 45578, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Gnomeregan Tabard
				{ 4, "f54rep7" },
				{ 5, 67530, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Gnomeregan Satchel
				{ 7, "f54rep8" },
				{ 8, 64896 },	-- Cape of Gnomeregan
				{ 9, 64895 },	-- Mantle of Gnomeregan
				{ 10, 64897 },	-- Shroud of Gnomeregan
				{ 16, 18772, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Green Mechanostrider
				{ 17, 18773, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift White Mechanostrider
				{ 18, 18774, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Yellow Mechanostrider
				{ 19, 8595, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Blue Mechanostrider
				{ 20, 13321, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Green Mechanostrider
				{ 21, 8563, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Red Mechanostrider
				{ 22, 13322, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Unpainted Mechanostrider
			},
		},
		{	--Ironforge
			FactionID = 47,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f47rep4" },
				{ 2, 45577, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Ironforge Tabard
				{ 4, "f47rep7" },
				{ 5, 67528, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Ironforge Satchel
				{ 7, "f47rep8" },
				{ 8, 64899 },	-- Cape of Ironforge
				{ 9, 64900 },	-- Mantle of Ironforge
				{ 10, 64898 },	-- Shroud of Ironforge
				{ 16, 18786, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Brown Ram
				{ 17, 18787, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Gray Ram
				{ 18, 18785, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift White Ram
				{ 19, 5872, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Brown Ram
				{ 20, 5864, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Gray Ram
				{ 21, 5873, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- White Ram
			},
		},
		{	--Orgrimmar
			FactionID = 76,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f76rep4" },
				{ 2, 45581, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Orgrimmar Tabard
				{ 4, "f76rep7" },
				{ 5, 67533, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Orgrimmar Satchel
				{ 7, "f76rep8" },
				{ 8, 64909 },	-- Cape of Orgrimmar
				{ 9, 64910 },	-- Mantle of Orgrimmar
				{ 10, 64908 },	-- Shroud of Orgrimmar
				{ 16, 18796, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Horn of the Swift Brown Wolf
				{ 17, 18798, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Horn of the Swift Gray Wolf
				{ 18, 18797, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Horn of the Swift Timber Wolf
				{ 19, 46099, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Horn of the Black Wolf
				{ 20, 5668, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Horn of the Brown Wolf
				{ 21, 5665, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Horn of the Dire Wolf
				{ 22, 1132, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Horn of the Timber Wolf
			},
		},
		{	--Stormwind
			FactionID = 72,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, "f72rep4" },
				{ 2, 45574, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Stormwind Tabard
				{ 4, "f72rep7" },
				{ 5, 67531, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Stormwind Satchel
				{ 7, "f72rep8" },
				{ 8, 64902 },	-- Cape of Stormwind
				{ 9, 64901 },	-- Mantle of Stormwind
				{ 10, 64898 },	-- Shroud of Stormwind
				{ 16, 18777, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Brown Steed
				{ 17, 18776, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift Palomino
				{ 18, 18778, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Swift White Steed
				{ 19, 2411, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Black Stallion Bridle
				{ 20, 5656, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Brown Horse Bridle
				{ 21, 5655, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Chestnut Mare Bridle
				{ 22, 2414, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Pinto Bridle
			},
		},
		{	--ThoriumBrotherhood
			FactionID = 59,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f59rep5" },
				{ 2, 17051, [PRICE_EXTRA_ITTYPE] = "money:70000" },	-- Plans: Dark Iron Bracers (p2 295)
				{ 3, 20761, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Recipe: Transmute Elemental Fire (p1 300)
				{ 4, 19444, [PRICE_EXTRA_ITTYPE] = "money:30000" },	-- Formula: Enchant Weapon - Strength (p4 290)
				{ 5, 17023, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Molten Helm (p7 300)
				{ 6, 17022, [PRICE_EXTRA_ITTYPE] = "money:150000" },	-- Pattern: Corehound Boots (p7 295)
				{ 7, 17018, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Pattern: Flarecore Gloves (p8 300)
				{ 16, "f59rep6" },
				{ 17, 17060, [PRICE_EXTRA_ITTYPE] = "money:220000" },	-- Plans: Dark Iron Destroyer (p2 300)
				{ 18, 17059, [PRICE_EXTRA_ITTYPE] = "money:220000" },	-- Plans: Dark Iron Reaver (p2 300)
				{ 19, 17049, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Plans: Fiery Chain Girdle (p2 295)
				{ 20, 19206, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Plans: Dark Iron Helm (p2 300)
				{ 21, 19448, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Formula: Enchant Weapon - Mighty Spirit (p4 300)
				{ 22, 17025, [PRICE_EXTRA_ITTYPE] = "money:160000" },	-- Pattern: Black Dragonscale Boots (p7 300)
				{ 23, 19330, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Lava Belt (p7 300)
				{ 24, 17017, [PRICE_EXTRA_ITTYPE] = "money:180000" },	-- Pattern: Flarecore Mantle (p8 300)
				{ 25, 19219, [PRICE_EXTRA_ITTYPE] = "money:60000" },	-- Pattern: Flarecore Robe (p8 300)
				{ 101, "f59rep7" },
				{ 102, 18592, [QUEST_EXTRA_ITTYPE] = 7604 },	-- Plans: Sulfuron Hammer (p2 300)
				{ 103, 17052, [PRICE_EXTRA_ITTYPE] = "money:180000" },	-- Plans: Dark Iron Leggings (p2 300)
				{ 104, 17053, [PRICE_EXTRA_ITTYPE] = "money:200000" },	-- Plans: Fiery Chain Shoulders (p2 300)
				{ 105, 19209, [PRICE_EXTRA_ITTYPE] = "money:70000" },	-- Plans: Blackfury (p2 300)
				{ 106, 19208, [PRICE_EXTRA_ITTYPE] = "money:70000" },	-- Plans: Black Amnesty (p2 300)
				{ 107, 19207, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Dark Iron Gauntlets (p2 300)
				{ 108, 19449, [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Formula: Enchant Weapon - Mighty Intellect (p4 300)
				{ 109, 19331, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Pattern: Chromatic Gauntlets (p7 300)
				{ 110, 19332, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Pattern: Corehound Belt (p7 300)
				{ 111, 19333, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Pattern: Molten Belt (p7 300)
				{ 112, 19220, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Pattern: Flarecore Leggings (p8 300)
				{ 116, "f59rep8" },
				{ 117, 19211, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Plans: Blackguard (p2 300)
				{ 118, 20040, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Plans: Dark Iron Boots (p2 300)
				{ 119, 19210, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Plans: Ebon Hand (p2 300)
				{ 120, 19212, [PRICE_EXTRA_ITTYPE] = "money:120000" },	-- Plans: Nightfall (p2 300)
			},
		},
		{	--ThunderBluff
			FactionID = 81,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f81rep4" },
				{ 2, 45584, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Thunder Bluff Tabard
				{ 4, "f81rep7" },
				{ 5, 67534, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Thunder Bluff Satchel
				{ 7, "f81rep8" },
				{ 8, 64918 },	-- Cape of Thunder Bluff
				{ 9, 64917 },	-- Mantle of Thunder Bluff
				{ 10, 64919 },	-- Shroud of Thunder Bluff
				{ 16, 18794, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Great Brown Kodo
				{ 17, 18795, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Great Gray Kodo
				{ 18, 18793, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Great White Kodo
				{ 19, 15290, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Brown Kodo
				{ 20, 15277, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Gray Kodo
				{ 21, 46100, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- White Kodo
			},
		},
		{	--TimbermawHold
			FactionID = 576,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f576rep5" },
				{ 2, 13484, [PRICE_EXTRA_ITTYPE] = "money:15000" },	-- Recipe: Transmute Earth to Water (p1 275)
				{ 3, 22392, [PRICE_EXTRA_ITTYPE] = "money:25000" },	-- Formula: Enchant 2H Weapon - Agility (p4 295)
				{ 4, 20254, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Pattern: Warbear Woolies (p7 285)
				{ 5, 20253, [PRICE_EXTRA_ITTYPE] = "money:16000" },	-- Pattern: Warbear Harness (p7 275)
				{ 7, "f576rep6" },
				{ 8, 16768 },	-- Furbolg Medicine Pouch
				{ 9, 16769 },	-- Furbolg Medicine Totem
				{ 10, 19202, [PRICE_EXTRA_ITTYPE] = "money:22000" },	-- Plans: Heavy Timbermaw Belt (p2 290)
				{ 11, 19445, [PRICE_EXTRA_ITTYPE] = "money:30000" },	-- Formula: Enchant Weapon - Agility (p4 290)
				{ 12, 19326, [PRICE_EXTRA_ITTYPE] = "money:22000" },	-- Pattern: Might of the Timbermaw (p7 290)
				{ 13, 19215, [PRICE_EXTRA_ITTYPE] = "money:22000" },	-- Pattern: Wisdom of the Timbermaw (p8 290)
				{ 16, "f576rep7" },
				{ 17, 19204, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Plans: Heavy Timbermaw Boots (p2 300)
				{ 18, 19327, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Timbermaw Brawlers (p7 300)
				{ 19, 19218, [PRICE_EXTRA_ITTYPE] = "money:40000" },	-- Pattern: Mantle of the Timbermaw (p8 300)
				{ 21, "f576rep8" },
				{ 22, 21326, [QUEST_EXTRA_ITTYPE] = 8481 },	-- Defender of the Timbermaw
				{ 23, 66888, [PRICE_EXTRA_ITTYPE] = "money:750000" },	-- Stave of Fur and Claw
			},
		},
		{	--Undercity
			FactionID = 68,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = {
				{ 1, "f68rep4" },
				{ 2, 45583, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Undercity Tabard
				{ 4, "f68rep7" },
				{ 5, 67529, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Undercity Satchel
				{ 7, "f68rep8" },
				{ 8, 64921 },	-- Cape of Undercity
				{ 9, 64922 },	-- Mantle of Undercity
				{ 10, 64920 },	-- Shroud of Undercity
				{ 16, 13334, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Green Skeletal Warhorse
				{ 17, 47101, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Ochre Skeletal Warhorse
				{ 18, 18791, "mount", [PRICE_EXTRA_ITTYPE] = "money:100000" },	-- Purple Skeletal Warhorse
				{ 19, 46308, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Black Skeletal Horse
				{ 20, 13332, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Blue Skeletal Horse
				{ 21, 13333, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Brown Skeletal Horse
				{ 22, 13331, "mount", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Red Skeletal Horse
			},
		},
	},
}