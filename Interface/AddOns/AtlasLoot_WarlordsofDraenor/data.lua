local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 6)

local AL = AtlasLoot.Locales

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], "LFRWithPreset", {
	Item = {
		item1bonus = nil,
		item2bonus = "RaidWarforged",
		autoCompleteItem2 = true,
	},
}, 17)
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", nil, 1)
local NORMAL_RAID_DIFF = data:AddDifficulty(AL["Normal"], "NormalRaidWithPreset", {
	Item = {
		item1bonus = nil,
		item2bonus = "RaidWarforged",
		autoCompleteItem2 = true,
	},
}, 14)
local NORMAL_AUCH_DIFF = data:AddDifficulty(AL["Normal"], "AuchWithPreset", {
	Item = {
		item1bonus = "Auch",
		item2bonus = "Auch",
	},
})
local NORMAL_BSM_DIFF = data:AddDifficulty(AL["Normal"], "BSMWithPreset", {
	Item = {
		item1bonus = "BSM",
		item2bonus = "BSM",
	},
})
local NORMAL_ID_DIFF = data:AddDifficulty(AL["Normal"], "IDWithPreset", {
	Item = {
		item1bonus = "ID",
		item2bonus = "ID",
	},
})
local NORMAL_SKYREACH_DIFF = data:AddDifficulty(AL["Normal"], "SkyreachWithPreset", {
	Item = {
		item1bonus = "Skyreach",
		item2bonus = "Skyreach",
	},
})
local NORMAL_DUNGEON_DIFF = data:AddDifficulty(AL["Normal"], "DungeonWithPreset", {
	Item = {
		item1bonus = "Dungeon",
		item2bonus = "Dungeon",
	},
})
local HEROIC_DIFF = data:AddDifficulty(AL["Heroic"], "h", nil, 2)
local HEROIC_DUNGEON_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicDungeonWithPreset", {
	Item = {
		item1bonus = "HCDungeon",
		item2bonus = "HCDungeonWarforged",
		autoCompleteItem2 = true,
	},
})
local HEROIC_PRE_DIFF = data:AddDifficulty(AL["Heroic"], "HeroicWithPreset", {
	Item = {
		item1bonus = "HeroicRaid",
		item2bonus = "HeroicRaidWarforged",
		autoCompleteItem2 = true,
	},
}, 15)
local MYTHIC_DIFF = data:AddDifficulty(AL["Mythic"], "m", nil, 16)
local MYTHIC_PRE_DIFF = data:AddDifficulty(AL["Mythic"], "MyhticWithPreset", {
	Item = {
		item1bonus = "MythicRaid",
		item2bonus = "MythicRaidWarforged",
		autoCompleteItem2 = true,
	},
}, 16)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local RAID_ITTYPE = data:AddItemTableType("Item", "Item") -- Normal, Thunder-/Warforged...
local AC_ITTYPE = data:AddItemTableType("Achievement")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID_COLOR)

-- Shared loot tables
local WOD_DUNGEON_HERO_AC_TABLE = {	--[Draenor Dungeon Hero]
	name = select(2, GetAchievementInfo(9391)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 9391 },
		{ 2, 9046 },			{ 17, 9047 },
		{ 3, 9049 },			{ 18, 8844 },
		{ 4, 9053 },			{ 19, 9052 },
		{ 5, 9054 },			{ 20, 9055 },
	},
}

local WOD_GLORY_OF_THE_HERO_AC_TABLE = {	--[Glory of the Draenor Hero]
	name = select(2, GetAchievementInfo(9396)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 9396, "mount171632" },
		{ 2, 9391 },			{ 17, 8993 },
		{ 3, 9005 },			{ 18, 9008 },
		{ 4, 9083 },			{ 19, 9081 },
		{ 5, 9082 },			{ 20, 9023 },
		{ 6, 9033 },			{ 21, 9034 },
		{ 7, 9035 },			{ 22, 9036 },
		{ 8, 9024 },			{ 23, 9007 },
		{ 9, 9017 },			{ 24, 9223 },
		{ 10, 9018 },			{ 25, 9025 },
		{ 11, 9026 },			{ 26, 9045 },
		{ 12, 9058 },			{ 27, 9056 },
		{ 13, 9057 },
	},
}

local WOD_RAID1_AC_TABLE = {	-- [Glory of the Draenor Raider]
name = select(2, GetAchievementInfo(8985)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 8985, "mount171436" },
		{ 2, 8948 },			{ 17, 8947 },
		{ 3, 8974 },			{ 18, 8975 },
		{ 4, 8958 },			{ 19, 8976 },
		{ 5, 8977 },			{ 20, 8978 },
		{ 6, 8979 },			{ 21, 8980 },
		{ 7, 8981 },			{ 22, 8929 },
		{ 8, 8982 },			{ 23, 8930 },
		{ 9, 8983 },			{ 24, 8984 },
		{ 10, 8952 },
	},
}

data["Auchindoun"] = {
	EncounterJournalID = 547,
	MapID = 984,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--AuchKaathar
			EncounterJournalID = 1185,
			[NORMAL_AUCH_DIFF] = {
				{ 1, 109824 },	-- Cord of Arcane Mystery
				{ 2, 109826 },	-- Cord of Swirling Light
				{ 3, 109828 },	-- Felflame Belt
				{ 4, 109825 },	-- Frost-Touched Cord
				{ 5, 109827 },	-- Lightbinder Girdle
				{ 6, 109829 },	-- Belt of Burning Focus
				{ 7, 109842 },	-- Blackwater Belt
				{ 8, 109830 },	-- Bloodfeather Girdle
				{ 9, 109831 },	-- Crystalbinder Belt
				{ 10, 109832 },	-- Leafmender Girdle
				{ 11, 109836 },	-- Lavalink Girdle
				{ 12, 109843 },	-- Morningscale Waistguard
				{ 13, 109835 },	-- Rockhide Links
				{ 14, 109834 },	-- Sharpeye Belt
				{ 15, 109833 },	-- Streamslither Belt
				{ 16, 109839 },	-- Goldsteel Belt
				{ 17, 109840 },	-- Gutcrusher Greatbelt
				{ 18, 109837 },	-- Incarnadine Girdle
				{ 19, 109841 },	-- Rivet-Sealed Waistplate
				{ 20, 109838 },	-- Verdant Plate Belt
				{ 101, 109779 },	-- Ancient Draenic Loop
				{ 102, 109768 },	-- Band of Growing Leaves
				{ 103, 109773 },	-- Band of Iron Scale
				{ 104, 109783 },	-- Band of the Stalwart Stanchion
				{ 105, 109775 },	-- Bladebinder Ring
				{ 106, 109771 },	-- Bloodied Ring of Mytosis
				{ 107, 109761 },	-- Bloodthorn Band
				{ 108, 109760 },	-- Ced's Chiming Circle
				{ 109, 109766 },	-- Darkflame Loop
				{ 110, 109763 },	-- Diamondglow Circle
				{ 111, 109782 },	-- Disease-Binder Seal
				{ 112, 109765 },	-- Golem's Gleaming Eye
				{ 113, 109772 },	-- Knucklebone of Lo'Dronar
				{ 114, 109764 },	-- Mark of Ice
				{ 115, 109767 },	-- Ring of Purified Light
				{ 116, 109774 },	-- Ring of Ripped Flesh
				{ 117, 109759 },	-- Ro-Ger's Brown Diamond Seal
				{ 118, 109776 },	-- Seal of Resilient Fortitude
				{ 119, 109781 },	-- Seal of Vindication
				{ 120, 109770 },	-- Signet of Crashing Waves
				{ 121, 109762 },	-- Signet of Radiant Leaves
				{ 122, 109780 },	-- Signet of Shifting Magics
				{ 123, 109778 },	-- Signet of the Glorious Protector
				{ 124, 109769 },	-- Slicebinder Loop
				{ 125, 109777 },	-- Unsullied Signet
				{ 127, 110045 },	-- Kamui's Crystalline Staff of Wizardry
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_AUCH_DIFF,
			},
		},
		{	--AuchNyami
			EncounterJournalID = 1186,
			[NORMAL_AUCH_DIFF] = {
				{ 1, 109903 },	-- Felflame Robes
				{ 2, 109900 },	-- Frost-Touched Robes
				{ 3, 109902 },	-- Lightbinder Robes
				{ 4, 109899 },	-- Robes of Arcane Mystery
				{ 5, 109901 },	-- Robes of Swirling Light
				{ 6, 109898 },	-- Blackwater Wrap
				{ 7, 109885 },	-- Bloodfeather Chestwrap
				{ 8, 109884 },	-- Chestguard of Burning Focus
				{ 9, 109886 },	-- Crystalbinder Chestguard
				{ 10, 109897 },	-- Leafmender Robes
				{ 11, 109890 },	-- Lavalink Ringmail
				{ 12, 109891 },	-- Morningscale Chestguard
				{ 13, 109889 },	-- Rockhide Ringmail
				{ 14, 109888 },	-- Sharpeye Chestguard
				{ 15, 109887 },	-- Streamslither Chestguard
				{ 16, 109894 },	-- Goldsteel Chestguard
				{ 17, 109895 },	-- Gutcrusher Chestplate
				{ 18, 109892 },	-- Incarnadine Breastplate
				{ 19, 109896 },	-- Rivet-Sealed Breastplate
				{ 20, 109893 },	-- Verdant Plate Chest
				{ 101, 109957 },	-- Alc's Pendant of Fiery Dreams
				{ 102, 109962 },	-- Bloodmist Pendant
				{ 103, 109959 },	-- Chain of Soothing Light
				{ 104, 109969 },	-- Choker of Weeping Viscera
				{ 105, 109955 },	-- Demonbinder Cabochon
				{ 106, 109951 },	-- Fireblade Collar
				{ 107, 109965 },	-- Fistbreak Choker
				{ 108, 109968 },	-- Flesh Beetle Brooch
				{ 109, 109963 },	-- Goreclasp Choker
				{ 110, 109958 },	-- Healing Leaf Necklace
				{ 111, 109954 },	-- Magister's Chain
				{ 112, 109956 },	-- Necklace of Endless Shadow
				{ 113, 109964 },	-- Necklace of Furious Zeal
				{ 114, 109967 },	-- Necklace of Holy Deflection
				{ 115, 109961 },	-- Pendant of Purifying Mists
				{ 116, 109966 },	-- Reinforced Bloodsteel Gorget
				{ 117, 109952 },	-- Skulltooth Chain
				{ 118, 109950 },	-- Stormshot Choker
				{ 119, 109960 },	-- Wavesurge Choker
				{ 120, 109953 },	-- Windseal Necklace
				{ 122, 110046 },	-- Hammer of the Soulbinder
				{ 123, 110047 },	-- Soulcutter Mageblade
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_AUCH_DIFF,
				{ 125, "ac9023" },
			},
		},
		{	--AuchAzzakel
			EncounterJournalID = 1216,
			[NORMAL_AUCH_DIFF] = {
				{ 1, 109864 },	-- Bracers of Arcane Mystery
				{ 2, 109866 },	-- Bracers of Swirling Light
				{ 3, 109881 },	-- Felflame Bracers
				{ 4, 109865 },	-- Frost-Touched Wristwraps
				{ 5, 109867 },	-- Lightbinder Wristwraps
				{ 6, 109861 },	-- Felflame Grips
				{ 7, 109845 },	-- Frost-Touched Gloves
				{ 8, 109844 },	-- Gloves of Arcane Mystery
				{ 9, 109846 },	-- Gloves of Swirling Light
				{ 10, 109847 },	-- Lightbinder Gloves
				{ 11, 109882 },	-- Blackwater Wristguards
				{ 12, 109869 },	-- Bloodfeather Bracers
				{ 13, 109868 },	-- Bracers of Burning Focus
				{ 14, 109870 },	-- Crystalbinder Wristguards
				{ 15, 109871 },	-- Leafmender Wraps
				{ 16, 109862 },	-- Blackwater Grips
				{ 17, 109849 },	-- Bloodfeather Grips
				{ 18, 109850 },	-- Crystalbinder Gloves
				{ 19, 109848 },	-- Gauntlets of Burning Focus
				{ 20, 109851 },	-- Leafmender Grips
				{ 21, 109875 },	-- Lavalink Bracers
				{ 22, 109883 },	-- Morningscale Bracers
				{ 23, 109874 },	-- Rockhide Wristguards
				{ 24, 109873 },	-- Sharpeye Bracers
				{ 25, 109872 },	-- Streamslither Bracers
				{ 26, 109855 },	-- Lavalink Grips
				{ 27, 109863 },	-- Morningscale Gauntlet
				{ 28, 109854 },	-- Rockhide Gloves
				{ 29, 109853 },	-- Sharpeye Gauntlets
				{ 30, 109852 },	-- Streamslither Gauntlets
				{ 101, 109878 },	-- Goldsteel Bindings
				{ 102, 109879 },	-- Gutcrusher Bracers
				{ 103, 109876 },	-- Incarnadine Bracers
				{ 104, 109880 },	-- Rivet-Sealed Bracers
				{ 105, 109877 },	-- Verdant Plate Wristguards
				{ 106, 109858 },	-- Goldsteel Gloves
				{ 107, 109859 },	-- Gutcrusher Gauntlets
				{ 108, 109856 },	-- Incarnadine Gauntlets
				{ 109, 109860 },	-- Rivet-Sealed Crushers
				{ 110, 109857 },	-- Verdant Plate Grips
				{ 116, 109995 },	-- Blood Seal of Azzakel
				{ 118, 110048 },	-- Azzakel's Boltslinger
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_AUCH_DIFF,
				{ 120, "ac9551" },
			},
		},
		{	--AuchTerongor
			EncounterJournalID = 1225,
			[NORMAL_AUCH_DIFF] = {
				{ 1, 109912 },	-- Bloody-Blade Drape
				{ 2, 109911 },	-- Cape of Annealing Flesh
				{ 3, 109908 },	-- Cloak of Arcane Mysteries
				{ 4, 109904 },	-- Cloak of Cascading Blades
				{ 5, 109910 },	-- Cloak of Mending Magics
				{ 6, 109929 },	-- Cloak of Steeled Nerves
				{ 7, 109906 },	-- Cloak of Violent Harmony
				{ 8, 109905 },	-- Deadshot Greatcloak
				{ 9, 109914 },	-- Drape of Dripping Runnels
				{ 10, 109926 },	-- Drape of Frozen Dreams
				{ 11, 109909 },	-- Drape of Iron Sutures
				{ 12, 109916 },	-- Drape of Swirling Deflection
				{ 13, 109907 },	-- Felbone Drape
				{ 14, 109925 },	-- Forgeflame Greatcloak
				{ 15, 109913 },	-- Headscythe Greatcloak
				{ 16, 109927 },	-- Mistwoven Windcloak
				{ 17, 109915 },	-- Rigid Scale Cloak
				{ 18, 109928 },	-- Skullcracker Cloak
				{ 19, 109918 },	-- Soot-Scarred Longcloak
				{ 20, 109917 },	-- Three-Clefthoof Cape
				{ 21, 109808 },	-- Felflame Legwraps
				{ 22, 109805 },	-- Frost-Touched Legwraps
				{ 23, 109806 },	-- Leggings of Swirling Light
				{ 24, 109807 },	-- Lightbinder Leggings
				{ 25, 109804 },	-- Trousers of Arcane Mystery
				{ 26, 109797 },	-- Felflame Sandals
				{ 27, 109785 },	-- Frost-Touched Boots
				{ 28, 109796 },	-- Lightbinder Treads
				{ 29, 109784 },	-- Sandals of Arcane Mystery
				{ 30, 109786 },	-- Sandals of Swirling Light
				{ 101, 109823 },	-- Blackwater Leggings
				{ 102, 109810 },	-- Bloodfeather Leggings
				{ 103, 109811 },	-- Crystalbinder Legwraps
				{ 104, 109812 },	-- Leafmender Legwraps
				{ 105, 109809 },	-- Legguards of Burning Focus
				{ 106, 109799 },	-- Blackwater Boots
				{ 107, 109788 },	-- Bloodfeather Treads
				{ 108, 109787 },	-- Boots of Burning Focus
				{ 109, 109789 },	-- Crystalbinder Sandals
				{ 110, 109798 },	-- Leafmender Sandals
				{ 111, 109816 },	-- Lavalink Kilt
				{ 112, 109817 },	-- Morningscale Leggings
				{ 113, 109815 },	-- Rockhide Leggings
				{ 114, 109814 },	-- Sharpeye Legguards
				{ 115, 109813 },	-- Streamslither Legguards
				{ 116, 109800 },	-- Lavalink Stompers
				{ 117, 109801 },	-- Morningscale Treads
				{ 118, 109792 },	-- Rockhide Treads
				{ 119, 109791 },	-- Sharpeye Greaves
				{ 120, 109790 },	-- Streamslither Boots
				{ 121, 109820 },	-- Goldsteel Legplates
				{ 122, 109821 },	-- Gutcrusher Legplates
				{ 123, 109818 },	-- Incarnadine Legplates
				{ 124, 109822 },	-- Rivet-Sealed Legplates
				{ 125, 109819 },	-- Verdant Plate Legguards
				{ 126, 109795 },	-- Goldsteel Sabatons
				{ 127, 109802 },	-- Gutcrusher Stompers
				{ 128, 109793 },	-- Incarnadine Greaves
				{ 129, 109803 },	-- Rivet-Sealed Treads
				{ 130, 109794 },	-- Verdant Plate Treads
				{ 201, 110005 },	-- Crystalline Blood Drop
				{ 202, 110010 },	-- Mote of Corruption
				{ 203, 110049 },	-- Bloodblade of Teron'Gor
				{ 204, 110050 },	-- Dagger of the Sanguine Emeralds
				{ 216, "ac9039" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_AUCH_DIFF,
				{ 206, "114240:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Corrupted Blood of Teron'gor
				{ 217, "ac9049" },
				{ 218, "ac9552" },
			},
		},
		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
		WOD_DUNGEON_HERO_AC_TABLE,
		WOD_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["BloodmaulSlagMines"] = {
	EncounterJournalID = 385,
	MapID = 964,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--BSMMagmolatus
			EncounterJournalID = 893,
			[NORMAL_BSM_DIFF] = {
				{ 1, 109903 },	-- Felflame Robes
				{ 2, 109900 },	-- Frost-Touched Robes
				{ 3, 109902 },	-- Lightbinder Robes
				{ 4, 109899 },	-- Robes of Arcane Mystery
				{ 5, 109901 },	-- Robes of Swirling Light
				{ 6, 109861 },	-- Felflame Grips
				{ 7, 109845 },	-- Frost-Touched Gloves
				{ 8, 109844 },	-- Gloves of Arcane Mystery
				{ 9, 109846 },	-- Gloves of Swirling Light
				{ 10, 109847 },	-- Lightbinder Gloves
				{ 11, 109898 },	-- Blackwater Wrap
				{ 12, 109885 },	-- Bloodfeather Chestwrap
				{ 13, 109884 },	-- Chestguard of Burning Focus
				{ 14, 109886 },	-- Crystalbinder Chestguard
				{ 15, 109897 },	-- Leafmender Robes
				{ 16, 109862 },	-- Blackwater Grips
				{ 17, 109849 },	-- Bloodfeather Grips
				{ 18, 109850 },	-- Crystalbinder Gloves
				{ 19, 109848 },	-- Gauntlets of Burning Focus
				{ 20, 109851 },	-- Leafmender Grips
				{ 21, 109890 },	-- Lavalink Ringmail
				{ 22, 109891 },	-- Morningscale Chestguard
				{ 23, 109889 },	-- Rockhide Ringmail
				{ 24, 109888 },	-- Sharpeye Chestguard
				{ 25, 109887 },	-- Streamslither Chestguard
				{ 26, 109855 },	-- Lavalink Grips
				{ 27, 109863 },	-- Morningscale Gauntlet
				{ 28, 109854 },	-- Rockhide Gloves
				{ 29, 109853 },	-- Sharpeye Gauntlets
				{ 30, 109852 },	-- Streamslither Gauntlets
				{ 101, 109894 },	-- Goldsteel Chestguard
				{ 102, 109895 },	-- Gutcrusher Chestplate
				{ 103, 109892 },	-- Incarnadine Breastplate
				{ 104, 109896 },	-- Rivet-Sealed Breastplate
				{ 105, 109893 },	-- Verdant Plate Chest
				{ 106, 109858 },	-- Goldsteel Gloves
				{ 107, 109859 },	-- Gutcrusher Gauntlets
				{ 108, 109856 },	-- Incarnadine Gauntlets
				{ 109, 109860 },	-- Rivet-Sealed Crushers
				{ 110, 109857 },	-- Verdant Plate Grips
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_BSM_DIFF,
				{ 116, "ac8993" },
			},
		},
		{	--BSMCrushto
			EncounterJournalID = 888,
			[NORMAL_BSM_DIFF] = {
				{ 1, 109864 },	-- Bracers of Arcane Mystery
				{ 2, 109866 },	-- Bracers of Swirling Light
				{ 3, 109881 },	-- Felflame Bracers
				{ 4, 109865 },	-- Frost-Touched Wristwraps
				{ 5, 109867 },	-- Lightbinder Wristwraps
				{ 6, 109808 },	-- Felflame Legwraps
				{ 7, 109805 },	-- Frost-Touched Legwraps
				{ 8, 109806 },	-- Leggings of Swirling Light
				{ 9, 109807 },	-- Lightbinder Leggings
				{ 10, 109804 },	-- Trousers of Arcane Mystery
				{ 11, 109882 },	-- Blackwater Wristguards
				{ 12, 109869 },	-- Bloodfeather Bracers
				{ 13, 109868 },	-- Bracers of Burning Focus
				{ 14, 109870 },	-- Crystalbinder Wristguards
				{ 15, 109871 },	-- Leafmender Wraps
				{ 16, 109823 },	-- Blackwater Leggings
				{ 17, 109810 },	-- Bloodfeather Leggings
				{ 18, 109811 },	-- Crystalbinder Legwraps
				{ 19, 109812 },	-- Leafmender Legwraps
				{ 20, 109809 },	-- Legguards of Burning Focus
				{ 21, 109875 },	-- Lavalink Bracers
				{ 22, 109883 },	-- Morningscale Bracers
				{ 23, 109874 },	-- Rockhide Wristguards
				{ 24, 109873 },	-- Sharpeye Bracers
				{ 25, 109872 },	-- Streamslither Bracers
				{ 26, 109816 },	-- Lavalink Kilt
				{ 27, 109817 },	-- Morningscale Leggings
				{ 28, 109815 },	-- Rockhide Leggings
				{ 29, 109814 },	-- Sharpeye Legguards
				{ 30, 109813 },	-- Streamslither Legguards
				{ 101, 109878 },	-- Goldsteel Bindings
				{ 102, 109879 },	-- Gutcrusher Bracers
				{ 103, 109876 },	-- Incarnadine Bracers
				{ 104, 109880 },	-- Rivet-Sealed Bracers
				{ 105, 109877 },	-- Verdant Plate Wristguards
				{ 106, 109820 },	-- Goldsteel Legplates
				{ 107, 109821 },	-- Gutcrusher Legplates
				{ 108, 109818 },	-- Incarnadine Legplates
				{ 109, 109822 },	-- Rivet-Sealed Legplates
				{ 110, 109819 },	-- Verdant Plate Legguards
				{ 116, 110000 },	-- Crushto's Runic Alarm
				{ 118, 110040 },	-- Crushto's Neck Separator
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_BSM_DIFF,
			},
		},
		{	--BSMRoltall
			EncounterJournalID = 887,
			[NORMAL_BSM_DIFF] = {
				{ 1, 109912 },	-- Bloody-Blade Drape
				{ 2, 109911 },	-- Cape of Annealing Flesh
				{ 3, 109908 },	-- Cloak of Arcane Mysteries
				{ 4, 109904 },	-- Cloak of Cascading Blades
				{ 5, 109910 },	-- Cloak of Mending Magics
				{ 6, 109929 },	-- Cloak of Steeled Nerves
				{ 7, 109906 },	-- Cloak of Violent Harmony
				{ 8, 109905 },	-- Deadshot Greatcloak
				{ 9, 109914 },	-- Drape of Dripping Runnels
				{ 10, 109926 },	-- Drape of Frozen Dreams
				{ 11, 109909 },	-- Drape of Iron Sutures
				{ 12, 109916 },	-- Drape of Swirling Deflection
				{ 13, 109907 },	-- Felbone Drape
				{ 14, 109925 },	-- Forgeflame Greatcloak
				{ 15, 109913 },	-- Headscythe Greatcloak
				{ 16, 109927 },	-- Mistwoven Windcloak
				{ 17, 109915 },	-- Rigid Scale Cloak
				{ 18, 109928 },	-- Skullcracker Cloak
				{ 19, 109918 },	-- Soot-Scarred Longcloak
				{ 20, 109917 },	-- Three-Clefthoof Cape
				{ 21, 109797 },	-- Felflame Sandals
				{ 22, 109785 },	-- Frost-Touched Boots
				{ 23, 109796 },	-- Lightbinder Treads
				{ 24, 109784 },	-- Sandals of Arcane Mystery
				{ 25, 109786 },	-- Sandals of Swirling Light
				{ 26, 109799 },	-- Blackwater Boots
				{ 27, 109788 },	-- Bloodfeather Treads
				{ 28, 109787 },	-- Boots of Burning Focus
				{ 29, 109789 },	-- Crystalbinder Sandals
				{ 30, 109798 },	-- Leafmender Sandals
				{ 101, 109800 },	-- Lavalink Stompers
				{ 102, 109801 },	-- Morningscale Treads
				{ 103, 109792 },	-- Rockhide Treads
				{ 104, 109791 },	-- Sharpeye Greaves
				{ 105, 109790 },	-- Streamslither Boots
				{ 106, 109795 },	-- Goldsteel Sabatons
				{ 107, 109802 },	-- Gutcrusher Stompers
				{ 108, 109793 },	-- Incarnadine Greaves
				{ 109, 109803 },	-- Rivet-Sealed Treads
				{ 110, 109794 },	-- Verdant Plate Treads
				{ 116, 110015 },	-- Toria's Unseeing Eye
				{ 118, 110041 },	-- Roltall's Brutal Crescent
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_BSM_DIFF,
			},
		},
		{	--BSMGugrokk
			EncounterJournalID = 889,
			[NORMAL_BSM_DIFF] = {
				{ 1, 109974 },	-- Felflame Hood
				{ 2, 109971 },	-- Frost-Touched Hood
				{ 3, 109970 },	-- Hood of Arcane Mystery
				{ 4, 109972 },	-- Hood of Swirling Light
				{ 5, 109973 },	-- Lightbinder Cover
				{ 6, 109948 },	-- Felflame Spaulders
				{ 7, 109931 },	-- Frost-Touched Shoulderpads
				{ 8, 109933 },	-- Lightbinder Shoulderpads
				{ 9, 109930 },	-- Mantle of Arcane Mystery
				{ 10, 109932 },	-- Mantle of Swirling Light
				{ 11, 109979 },	-- Blackwater Helm
				{ 12, 109976 },	-- Bloodfeather Cowl
				{ 13, 109977 },	-- Crystalbinder Helm
				{ 14, 109975 },	-- Hood of Burning Focus
				{ 15, 109978 },	-- Leafmender Hood
				{ 16, 109938 },	-- Blackwater Spaulders
				{ 17, 109935 },	-- Bloodfeather Spaulders
				{ 18, 109936 },	-- Crystalbinder Shoulderpads
				{ 19, 109937 },	-- Leafmender Mantle
				{ 20, 109934 },	-- Spaulders of Burning Focus
				{ 21, 109983 },	-- Lavalink Helm
				{ 22, 109984 },	-- Morningscale Cowl
				{ 23, 109982 },	-- Rockhide Casque
				{ 24, 109981 },	-- Sharpeye Gleam
				{ 25, 109980 },	-- Streamslither Helm
				{ 26, 109942 },	-- Lavalink Spaulders
				{ 27, 109949 },	-- Morningscale Spaulders
				{ 28, 109941 },	-- Rockhide Shoulderguards
				{ 29, 109940 },	-- Sharpeye Shoulderguards
				{ 30, 109939 },	-- Streamslither Spaulders
				{ 101, 109987 },	-- Goldsteel Greathelm
				{ 102, 109988 },	-- Gutcrusher Coronet
				{ 103, 109985 },	-- Incarnadine Greathelm
				{ 104, 109989 },	-- Rivet-Sealed Casque
				{ 105, 109986 },	-- Verdant Plate Crown
				{ 106, 109945 },	-- Goldsteel Shouldercaps
				{ 107, 109946 },	-- Gutcrusher Shoulderplates
				{ 108, 109943 },	-- Incarnadine Shoulderguard
				{ 109, 109947 },	-- Rivet-Sealed Shoulderplates
				{ 110, 109944 },	-- Verdant Plate Spaulders
				{ 116, 109779 },	-- Ancient Draenic Loop
				{ 117, 109768 },	-- Band of Growing Leaves
				{ 118, 109773 },	-- Band of Iron Scale
				{ 119, 109783 },	-- Band of the Stalwart Stanchion
				{ 120, 109775 },	-- Bladebinder Ring
				{ 121, 109771 },	-- Bloodied Ring of Mytosis
				{ 122, 109761 },	-- Bloodthorn Band
				{ 123, 109760 },	-- Ced's Chiming Circle
				{ 124, 109766 },	-- Darkflame Loop
				{ 125, 109763 },	-- Diamondglow Circle
				{ 126, 109782 },	-- Disease-Binder Seal
				{ 127, 109765 },	-- Golem's Gleaming Eye
				{ 128, 109772 },	-- Knucklebone of Lo'Dronar
				{ 129, 109764 },	-- Mark of Ice
				{ 130, 109767 },	-- Ring of Purified Light
				{ 201, 109774 },	-- Ring of Ripped Flesh
				{ 202, 109759 },	-- Ro-Ger's Brown Diamond Seal
				{ 203, 109776 },	-- Seal of Resilient Fortitude
				{ 204, 109781 },	-- Seal of Vindication
				{ 205, 109770 },	-- Signet of Crashing Waves
				{ 206, 109762 },	-- Signet of Radiant Leaves
				{ 207, 109780 },	-- Signet of Shifting Magics
				{ 208, 109778 },	-- Signet of the Glorious Protector
				{ 209, 109769 },	-- Slicebinder Loop
				{ 210, 109777 },	-- Unsullied Signet
				{ 216, 110042 },	-- Gug'rokk's Smasher
				{ 217, 110044 },	-- Ogre Dinner Plate
				{ 218, 110043 },	-- Gug'rokk's Grandmother
				{ 220, "ac9037" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_BSM_DIFF,
				{ 212, "113682:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Core of Flame
				{ 221, "ac9046" },
				{ 222, "ac9005" },
				{ 223, "ac9008" },
			},
		},
		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
		WOD_DUNGEON_HERO_AC_TABLE,
		WOD_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["GrimrailDepot"] = {
	EncounterJournalID = 536,
	MapID = 993,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--GDRocketsparkBorka
			EncounterJournalID = 1138,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109824 },	-- Cord of Arcane Mystery
				{ 2, 109826 },	-- Cord of Swirling Light
				{ 3, 109828 },	-- Felflame Belt
				{ 4, 109825 },	-- Frost-Touched Cord
				{ 5, 109827 },	-- Lightbinder Girdle
				{ 6, 109829 },	-- Belt of Burning Focus
				{ 7, 109842 },	-- Blackwater Belt
				{ 8, 109830 },	-- Bloodfeather Girdle
				{ 9, 109831 },	-- Crystalbinder Belt
				{ 10, 109832 },	-- Leafmender Girdle
				{ 11, 109836 },	-- Lavalink Girdle
				{ 12, 109843 },	-- Morningscale Waistguard
				{ 13, 109835 },	-- Rockhide Links
				{ 14, 109834 },	-- Sharpeye Belt
				{ 15, 109833 },	-- Streamslither Belt
				{ 16, 109839 },	-- Goldsteel Belt
				{ 17, 109840 },	-- Gutcrusher Greatbelt
				{ 18, 109837 },	-- Incarnadine Girdle
				{ 19, 109841 },	-- Rivet-Sealed Waistplate
				{ 20, 109838 },	-- Verdant Plate Belt
				{ 101, 109779 },	-- Ancient Draenic Loop
				{ 102, 109768 },	-- Band of Growing Leaves
				{ 103, 109773 },	-- Band of Iron Scale
				{ 104, 109783 },	-- Band of the Stalwart Stanchion
				{ 105, 109775 },	-- Bladebinder Ring
				{ 106, 109771 },	-- Bloodied Ring of Mytosis
				{ 107, 109761 },	-- Bloodthorn Band
				{ 108, 109760 },	-- Ced's Chiming Circle
				{ 109, 109766 },	-- Darkflame Loop
				{ 110, 109763 },	-- Diamondglow Circle
				{ 111, 109782 },	-- Disease-Binder Seal
				{ 112, 109765 },	-- Golem's Gleaming Eye
				{ 113, 109772 },	-- Knucklebone of Lo'Dronar
				{ 114, 109764 },	-- Mark of Ice
				{ 115, 109767 },	-- Ring of Purified Light
				{ 116, 109774 },	-- Ring of Ripped Flesh
				{ 117, 109759 },	-- Ro-Ger's Brown Diamond Seal
				{ 118, 109776 },	-- Seal of Resilient Fortitude
				{ 119, 109781 },	-- Seal of Vindication
				{ 120, 109770 },	-- Signet of Crashing Waves
				{ 121, 109762 },	-- Signet of Radiant Leaves
				{ 122, 109780 },	-- Signet of Shifting Magics
				{ 123, 109778 },	-- Signet of the Glorious Protector
				{ 124, 109769 },	-- Slicebinder Loop
				{ 125, 109777 },	-- Unsullied Signet
				{ 127, 110051 },	-- Overseer's Final Word
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 129, "ac9024" },
			},
		},
		{	--GDThundertower
			EncounterJournalID = 1163,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109903 },	-- Felflame Robes
				{ 2, 109900 },	-- Frost-Touched Robes
				{ 3, 109902 },	-- Lightbinder Robes
				{ 4, 109899 },	-- Robes of Arcane Mystery
				{ 5, 109901 },	-- Robes of Swirling Light
				{ 6, 109898 },	-- Blackwater Wrap
				{ 7, 109885 },	-- Bloodfeather Chestwrap
				{ 8, 109884 },	-- Chestguard of Burning Focus
				{ 9, 109886 },	-- Crystalbinder Chestguard
				{ 10, 109897 },	-- Leafmender Robes
				{ 11, 109890 },	-- Lavalink Ringmail
				{ 12, 109891 },	-- Morningscale Chestguard
				{ 13, 109889 },	-- Rockhide Ringmail
				{ 14, 109888 },	-- Sharpeye Chestguard
				{ 15, 109887 },	-- Streamslither Chestguard
				{ 16, 109894 },	-- Goldsteel Chestguard
				{ 17, 109895 },	-- Gutcrusher Chestplate
				{ 18, 109892 },	-- Incarnadine Breastplate
				{ 19, 109896 },	-- Rivet-Sealed Breastplate
				{ 20, 109893 },	-- Verdant Plate Chest
				{ 101, 109957 },	-- Alc's Pendant of Fiery Dreams
				{ 102, 109962 },	-- Bloodmist Pendant
				{ 103, 109959 },	-- Chain of Soothing Light
				{ 104, 109969 },	-- Choker of Weeping Viscera
				{ 105, 109955 },	-- Demonbinder Cabochon
				{ 106, 109951 },	-- Fireblade Collar
				{ 107, 109965 },	-- Fistbreak Choker
				{ 108, 109968 },	-- Flesh Beetle Brooch
				{ 109, 109963 },	-- Goreclasp Choker
				{ 110, 109958 },	-- Healing Leaf Necklace
				{ 111, 109954 },	-- Magister's Chain
				{ 112, 109956 },	-- Necklace of Endless Shadow
				{ 113, 109964 },	-- Necklace of Furious Zeal
				{ 114, 109967 },	-- Necklace of Holy Deflection
				{ 115, 109961 },	-- Pendant of Purifying Mists
				{ 116, 109966 },	-- Reinforced Bloodsteel Gorget
				{ 117, 109952 },	-- Skulltooth Chain
				{ 118, 109950 },	-- Stormshot Choker
				{ 119, 109960 },	-- Wavesurge Choker
				{ 120, 109953 },	-- Windseal Necklace
				{ 122, 109996 },	-- Thundertower's Targeting Reticle
				{ 124, 110052 },	-- Scepter of Brutality
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 126, "ac9007" },
			},
		},
		{	--GDTovra
			EncounterJournalID = 1133,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109864 },	-- Bracers of Arcane Mystery
				{ 2, 109866 },	-- Bracers of Swirling Light
				{ 3, 109881 },	-- Felflame Bracers
				{ 4, 109865 },	-- Frost-Touched Wristwraps
				{ 5, 109867 },	-- Lightbinder Wristwraps
				{ 6, 109861 },	-- Felflame Grips
				{ 7, 109845 },	-- Frost-Touched Gloves
				{ 8, 109844 },	-- Gloves of Arcane Mystery
				{ 9, 109846 },	-- Gloves of Swirling Light
				{ 10, 109847 },	-- Lightbinder Gloves
				{ 11, 109808 },	-- Felflame Legwraps
				{ 12, 109805 },	-- Frost-Touched Legwraps
				{ 13, 109806 },	-- Leggings of Swirling Light
				{ 14, 109807 },	-- Lightbinder Leggings
				{ 15, 109804 },	-- Trousers of Arcane Mystery
				{ 16, 109882 },	-- Blackwater Wristguards
				{ 17, 109869 },	-- Bloodfeather Bracers
				{ 18, 109868 },	-- Bracers of Burning Focus
				{ 19, 109870 },	-- Crystalbinder Wristguards
				{ 20, 109871 },	-- Leafmender Wraps
				{ 21, 109862 },	-- Blackwater Grips
				{ 22, 109849 },	-- Bloodfeather Grips
				{ 23, 109850 },	-- Crystalbinder Gloves
				{ 24, 109848 },	-- Gauntlets of Burning Focus
				{ 25, 109851 },	-- Leafmender Grips
				{ 26, 109823 },	-- Blackwater Leggings
				{ 27, 109810 },	-- Bloodfeather Leggings
				{ 28, 109811 },	-- Crystalbinder Legwraps
				{ 29, 109812 },	-- Leafmender Legwraps
				{ 30, 109809 },	-- Legguards of Burning Focus
				{ 101, 109875 },	-- Lavalink Bracers
				{ 102, 109883 },	-- Morningscale Bracers
				{ 103, 109874 },	-- Rockhide Wristguards
				{ 104, 109873 },	-- Sharpeye Bracers
				{ 105, 109872 },	-- Streamslither Bracers
				{ 106, 109855 },	-- Lavalink Grips
				{ 107, 109863 },	-- Morningscale Gauntlet
				{ 108, 109854 },	-- Rockhide Gloves
				{ 109, 109853 },	-- Sharpeye Gauntlets
				{ 110, 109852 },	-- Streamslither Gauntlets
				{ 111, 109816 },	-- Lavalink Kilt
				{ 112, 109817 },	-- Morningscale Leggings
				{ 113, 109815 },	-- Rockhide Leggings
				{ 114, 109814 },	-- Sharpeye Legguards
				{ 115, 109813 },	-- Streamslither Legguards
				{ 116, 109878 },	-- Goldsteel Bindings
				{ 117, 109879 },	-- Gutcrusher Bracers
				{ 118, 109876 },	-- Incarnadine Bracers
				{ 119, 109880 },	-- Rivet-Sealed Bracers
				{ 120, 109877 },	-- Verdant Plate Wristguards
				{ 121, 109858 },	-- Goldsteel Gloves
				{ 122, 109859 },	-- Gutcrusher Gauntlets
				{ 123, 109856 },	-- Incarnadine Gauntlets
				{ 124, 109860 },	-- Rivet-Sealed Crushers
				{ 125, 109857 },	-- Verdant Plate Grips
				{ 126, 109820 },	-- Goldsteel Legplates
				{ 127, 109821 },	-- Gutcrusher Legplates
				{ 128, 109818 },	-- Incarnadine Legplates
				{ 129, 109822 },	-- Rivet-Sealed Legplates
				{ 130, 109819 },	-- Verdant Plate Legguards
				{ 201, 110001 },	-- Tovra's Lightning Repository
				{ 203, 110054 },	-- Thunderlord Flamestaff
				{ 204, 110053 },	-- Arrowbreaker Greatshield
				{ 216, "ac9043" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 206, "114107:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Core of Iron
				{ 217, "ac9052" },
			},
		},
		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
		WOD_DUNGEON_HERO_AC_TABLE,
		WOD_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["IronDocks"] = {
	EncounterJournalID = 558,
	MapID = 987,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--IDNokgar
			EncounterJournalID = 1235,
			[NORMAL_ID_DIFF] = {
				{ 1, 109903 },	-- Felflame Robes
				{ 2, 109900 },	-- Frost-Touched Robes
				{ 3, 109902 },	-- Lightbinder Robes
				{ 4, 109899 },	-- Robes of Arcane Mystery
				{ 5, 109901 },	-- Robes of Swirling Light
				{ 6, 109898 },	-- Blackwater Wrap
				{ 7, 109885 },	-- Bloodfeather Chestwrap
				{ 8, 109884 },	-- Chestguard of Burning Focus
				{ 9, 109886 },	-- Crystalbinder Chestguard
				{ 10, 109897 },	-- Leafmender Robes
				{ 11, 109890 },	-- Lavalink Ringmail
				{ 12, 109891 },	-- Morningscale Chestguard
				{ 13, 109889 },	-- Rockhide Ringmail
				{ 14, 109888 },	-- Sharpeye Chestguard
				{ 15, 109887 },	-- Streamslither Chestguard
				{ 16, 109894 },	-- Goldsteel Chestguard
				{ 17, 109895 },	-- Gutcrusher Chestplate
				{ 18, 109892 },	-- Incarnadine Breastplate
				{ 19, 109896 },	-- Rivet-Sealed Breastplate
				{ 20, 109893 },	-- Verdant Plate Chest
				{ 101, 109779 },	-- Ancient Draenic Loop
				{ 102, 109768 },	-- Band of Growing Leaves
				{ 103, 109773 },	-- Band of Iron Scale
				{ 104, 109783 },	-- Band of the Stalwart Stanchion
				{ 105, 109775 },	-- Bladebinder Ring
				{ 106, 109771 },	-- Bloodied Ring of Mytosis
				{ 107, 109761 },	-- Bloodthorn Band
				{ 108, 109760 },	-- Ced's Chiming Circle
				{ 109, 109766 },	-- Darkflame Loop
				{ 110, 109763 },	-- Diamondglow Circle
				{ 111, 109782 },	-- Disease-Binder Seal
				{ 112, 109765 },	-- Golem's Gleaming Eye
				{ 113, 109772 },	-- Knucklebone of Lo'Dronar
				{ 114, 109764 },	-- Mark of Ice
				{ 115, 109767 },	-- Ring of Purified Light
				{ 116, 109774 },	-- Ring of Ripped Flesh
				{ 117, 109759 },	-- Ro-Ger's Brown Diamond Seal
				{ 118, 109776 },	-- Seal of Resilient Fortitude
				{ 119, 109781 },	-- Seal of Vindication
				{ 120, 109770 },	-- Signet of Crashing Waves
				{ 121, 109762 },	-- Signet of Radiant Leaves
				{ 122, 109780 },	-- Signet of Shifting Magics
				{ 123, 109778 },	-- Signet of the Glorious Protector
				{ 124, 109769 },	-- Slicebinder Loop
				{ 125, 109777 },	-- Unsullied Signet
				{ 126, 110002 },	-- Fleshrender's Meathook
				{ 128, 110055 },	-- Gutwrench Goreaxe
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_ID_DIFF,
				{ 130, "ac9083" },
			},
		},
		{	--IDEnforcers
			EncounterJournalID = 1236,
			[NORMAL_ID_DIFF] = {
				{ 1, 109974 },	-- Felflame Hood
				{ 2, 109971 },	-- Frost-Touched Hood
				{ 3, 109970 },	-- Hood of Arcane Mystery
				{ 4, 109972 },	-- Hood of Swirling Light
				{ 5, 109973 },	-- Lightbinder Cover
				{ 6, 109979 },	-- Blackwater Helm
				{ 7, 109976 },	-- Bloodfeather Cowl
				{ 8, 109977 },	-- Crystalbinder Helm
				{ 9, 109975 },	-- Hood of Burning Focus
				{ 10, 109978 },	-- Leafmender Hood
				{ 11, 109983 },	-- Lavalink Helm
				{ 12, 109984 },	-- Morningscale Cowl
				{ 13, 109982 },	-- Rockhide Casque
				{ 14, 109981 },	-- Sharpeye Gleam
				{ 15, 109980 },	-- Streamslither Helm
				{ 16, 109987 },	-- Goldsteel Greathelm
				{ 17, 109988 },	-- Gutcrusher Coronet
				{ 18, 109985 },	-- Incarnadine Greathelm
				{ 19, 109989 },	-- Rivet-Sealed Casque
				{ 20, 109986 },	-- Verdant Plate Crown
				{ 101, 109957 },	-- Alc's Pendant of Fiery Dreams
				{ 102, 109962 },	-- Bloodmist Pendant
				{ 103, 109959 },	-- Chain of Soothing Light
				{ 104, 109969 },	-- Choker of Weeping Viscera
				{ 105, 109955 },	-- Demonbinder Cabochon
				{ 106, 109951 },	-- Fireblade Collar
				{ 107, 109965 },	-- Fistbreak Choker
				{ 108, 109968 },	-- Flesh Beetle Brooch
				{ 109, 109963 },	-- Goreclasp Choker
				{ 110, 109958 },	-- Healing Leaf Necklace
				{ 111, 109954 },	-- Magister's Chain
				{ 112, 109956 },	-- Necklace of Endless Shadow
				{ 113, 109964 },	-- Necklace of Furious Zeal
				{ 114, 109967 },	-- Necklace of Holy Deflection
				{ 115, 109961 },	-- Pendant of Purifying Mists
				{ 116, 109966 },	-- Reinforced Bloodsteel Gorget
				{ 117, 109952 },	-- Skulltooth Chain
				{ 118, 109950 },	-- Stormshot Choker
				{ 119, 109960 },	-- Wavesurge Choker
				{ 120, 109953 },	-- Windseal Necklace
				{ 122, 110017 },	-- Enforcer's Stun Grenade
				{ 124, 110056 },	-- Black Iron Sniper Rifle
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_ID_DIFF,
			},
		},
		{	--IDOshir
			EncounterJournalID = 1237,
			[NORMAL_ID_DIFF] = {
				{ 1, 109864 },	-- Bracers of Arcane Mystery
				{ 2, 109866 },	-- Bracers of Swirling Light
				{ 3, 109881 },	-- Felflame Bracers
				{ 4, 109865 },	-- Frost-Touched Wristwraps
				{ 5, 109867 },	-- Lightbinder Wristwraps
				{ 6, 109824 },	-- Cord of Arcane Mystery
				{ 7, 109826 },	-- Cord of Swirling Light
				{ 8, 109828 },	-- Felflame Belt
				{ 9, 109825 },	-- Frost-Touched Cord
				{ 10, 109827 },	-- Lightbinder Girdle
				{ 11, 109882 },	-- Blackwater Wristguards
				{ 12, 109869 },	-- Bloodfeather Bracers
				{ 13, 109868 },	-- Bracers of Burning Focus
				{ 14, 109870 },	-- Crystalbinder Wristguards
				{ 15, 109871 },	-- Leafmender Wraps
				{ 16, 109829 },	-- Belt of Burning Focus
				{ 17, 109842 },	-- Blackwater Belt
				{ 18, 109830 },	-- Bloodfeather Girdle
				{ 19, 109831 },	-- Crystalbinder Belt
				{ 20, 109832 },	-- Leafmender Girdle
				{ 21, 109875 },	-- Lavalink Bracers
				{ 22, 109883 },	-- Morningscale Bracers
				{ 23, 109874 },	-- Rockhide Wristguards
				{ 24, 109873 },	-- Sharpeye Bracers
				{ 25, 109872 },	-- Streamslither Bracers
				{ 26, 109836 },	-- Lavalink Girdle
				{ 27, 109843 },	-- Morningscale Waistguard
				{ 28, 109835 },	-- Rockhide Links
				{ 29, 109834 },	-- Sharpeye Belt
				{ 30, 109833 },	-- Streamslither Belt
				{ 101, 109878 },	-- Goldsteel Bindings
				{ 102, 109879 },	-- Gutcrusher Bracers
				{ 103, 109876 },	-- Incarnadine Bracers
				{ 104, 109880 },	-- Rivet-Sealed Bracers
				{ 105, 109877 },	-- Verdant Plate Wristguards
				{ 106, 109839 },	-- Goldsteel Belt
				{ 107, 109840 },	-- Gutcrusher Greatbelt
				{ 108, 109837 },	-- Incarnadine Girdle
				{ 109, 109841 },	-- Rivet-Sealed Waistplate
				{ 110, 109838 },	-- Verdant Plate Belt
				{ 116, 109997 },	-- Kihra's Adrenaline Injector
				{ 118, 110057 },	-- Mindbreaker Scepter

			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_ID_DIFF,
			},
		},
		{	--IDSkulloc
			EncounterJournalID = 1238,
			[NORMAL_ID_DIFF] = {
				{ 1, 109948 },	-- Felflame Spaulders
				{ 2, 109931 },	-- Frost-Touched Shoulderpads
				{ 3, 109933 },	-- Lightbinder Shoulderpads
				{ 4, 109930 },	-- Mantle of Arcane Mystery
				{ 5, 109932 },	-- Mantle of Swirling Light
				{ 6, 109861 },	-- Felflame Grips
				{ 7, 109845 },	-- Frost-Touched Gloves
				{ 8, 109844 },	-- Gloves of Arcane Mystery
				{ 9, 109846 },	-- Gloves of Swirling Light
				{ 10, 109847 },	-- Lightbinder Gloves
				{ 11, 109808 },	-- Felflame Legwraps
				{ 12, 109805 },	-- Frost-Touched Legwraps
				{ 13, 109806 },	-- Leggings of Swirling Light
				{ 14, 109807 },	-- Lightbinder Leggings
				{ 15, 109804 },	-- Trousers of Arcane Mystery
				{ 16, 109938 },	-- Blackwater Spaulders
				{ 17, 109935 },	-- Bloodfeather Spaulders
				{ 18, 109936 },	-- Crystalbinder Shoulderpads
				{ 19, 109937 },	-- Leafmender Mantle
				{ 20, 109934 },	-- Spaulders of Burning Focus
				{ 21, 109862 },	-- Blackwater Grips
				{ 22, 109849 },	-- Bloodfeather Grips
				{ 23, 109850 },	-- Crystalbinder Gloves
				{ 24, 109848 },	-- Gauntlets of Burning Focus
				{ 25, 109851 },	-- Leafmender Grips
				{ 26, 109823 },	-- Blackwater Leggings
				{ 27, 109810 },	-- Bloodfeather Leggings
				{ 28, 109811 },	-- Crystalbinder Legwraps
				{ 29, 109812 },	-- Leafmender Legwraps
				{ 30, 109809 },	-- Legguards of Burning Focus
				{ 101, 109942 },	-- Lavalink Spaulders
				{ 102, 109949 },	-- Morningscale Spaulders
				{ 103, 109941 },	-- Rockhide Shoulderguards
				{ 104, 109940 },	-- Sharpeye Shoulderguards
				{ 105, 109939 },	-- Streamslither Spaulders
				{ 106, 109855 },	-- Lavalink Grips
				{ 107, 109863 },	-- Morningscale Gauntlet
				{ 108, 109854 },	-- Rockhide Gloves
				{ 109, 109853 },	-- Sharpeye Gauntlets
				{ 110, 109852 },	-- Streamslither Gauntlets
				{ 111, 109816 },	-- Lavalink Kilt
				{ 112, 109817 },	-- Morningscale Leggings
				{ 113, 109815 },	-- Rockhide Leggings
				{ 114, 109814 },	-- Sharpeye Legguards
				{ 115, 109813 },	-- Streamslither Legguards
				{ 116, 109945 },	-- Goldsteel Shouldercaps
				{ 117, 109946 },	-- Gutcrusher Shoulderplates
				{ 118, 109943 },	-- Incarnadine Shoulderguard
				{ 119, 109947 },	-- Rivet-Sealed Shoulderplates
				{ 120, 109944 },	-- Verdant Plate Spaulders
				{ 121, 109858 },	-- Goldsteel Gloves
				{ 122, 109859 },	-- Gutcrusher Gauntlets
				{ 123, 109856 },	-- Incarnadine Gauntlets
				{ 124, 109860 },	-- Rivet-Sealed Crushers
				{ 125, 109857 },	-- Verdant Plate Grips
				{ 126, 109820 },	-- Goldsteel Legplates
				{ 127, 109821 },	-- Gutcrusher Legplates
				{ 128, 109818 },	-- Incarnadine Legplates
				{ 129, 109822 },	-- Rivet-Sealed Legplates
				{ 130, 109819 },	-- Verdant Plate Legguards
				{ 201, 110058 },	-- Bloodied Hand of Woe
				{ 202, 110059 },	-- Chasmwrench Docking Hook
				{ 203, 110060 },	-- Painbringer's Crystal
				{ 216, "ac9038" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_ID_DIFF,
				{ 217, "ac9047" },
				{ 218, "ac9082" },
			},
		},
		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
		WOD_DUNGEON_HERO_AC_TABLE,
		WOD_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["ShadowmoonBurialGrounds"] = {
	EncounterJournalID = 537,
	MapID = 969,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--SBGBloodfury
			EncounterJournalID = 1139,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109912 },	-- Bloody-Blade Drape
				{ 2, 109911 },	-- Cape of Annealing Flesh
				{ 3, 109908 },	-- Cloak of Arcane Mysteries
				{ 4, 109904 },	-- Cloak of Cascading Blades
				{ 5, 109910 },	-- Cloak of Mending Magics
				{ 6, 109929 },	-- Cloak of Steeled Nerves
				{ 7, 109906 },	-- Cloak of Violent Harmony
				{ 8, 109905 },	-- Deadshot Greatcloak
				{ 9, 109914 },	-- Drape of Dripping Runnels
				{ 10, 109926 },	-- Drape of Frozen Dreams
				{ 11, 109909 },	-- Drape of Iron Sutures
				{ 12, 109916 },	-- Drape of Swirling Deflection
				{ 13, 109907 },	-- Felbone Drape
				{ 14, 109925 },	-- Forgeflame Greatcloak
				{ 15, 109913 },	-- Headscythe Greatcloak
				{ 16, 109927 },	-- Mistwoven Windcloak
				{ 17, 109915 },	-- Rigid Scale Cloak
				{ 18, 109928 },	-- Skullcracker Cloak
				{ 19, 109918 },	-- Soot-Scarred Longcloak
				{ 20, 109917 },	-- Three-Clefthoof Cape
				{ 101, 109957 },	-- Alc's Pendant of Fiery Dreams
				{ 102, 109962 },	-- Bloodmist Pendant
				{ 103, 109959 },	-- Chain of Soothing Light
				{ 104, 109969 },	-- Choker of Weeping Viscera
				{ 105, 109955 },	-- Demonbinder Cabochon
				{ 106, 109951 },	-- Fireblade Collar
				{ 107, 109965 },	-- Fistbreak Choker
				{ 108, 109968 },	-- Flesh Beetle Brooch
				{ 109, 109963 },	-- Goreclasp Choker
				{ 110, 109958 },	-- Healing Leaf Necklace
				{ 111, 109954 },	-- Magister's Chain
				{ 112, 109956 },	-- Necklace of Endless Shadow
				{ 113, 109964 },	-- Necklace of Furious Zeal
				{ 114, 109967 },	-- Necklace of Holy Deflection
				{ 115, 109961 },	-- Pendant of Purifying Mists
				{ 116, 109966 },	-- Reinforced Bloodsteel Gorget
				{ 117, 109952 },	-- Skulltooth Chain
				{ 118, 109950 },	-- Stormshot Choker
				{ 119, 109960 },	-- Wavesurge Choker
				{ 120, 109953 },	-- Windseal Necklace
				{ 122, 110035 },	-- Sadana's Grisly Visage
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 124, "ac9018" },
			},
		},
		{	--SBGNhallish
			EncounterJournalID = 1168,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109903 },	-- Felflame Robes
				{ 2, 109900 },	-- Frost-Touched Robes
				{ 3, 109902 },	-- Lightbinder Robes
				{ 4, 109899 },	-- Robes of Arcane Mystery
				{ 5, 109901 },	-- Robes of Swirling Light
				{ 6, 109864 },	-- Bracers of Arcane Mystery
				{ 7, 109866 },	-- Bracers of Swirling Light
				{ 8, 109881 },	-- Felflame Bracers
				{ 9, 109865 },	-- Frost-Touched Wristwraps
				{ 10, 109867 },	-- Lightbinder Wristwraps
				{ 11, 109898 },	-- Blackwater Wrap
				{ 12, 109885 },	-- Bloodfeather Chestwrap
				{ 13, 109884 },	-- Chestguard of Burning Focus
				{ 14, 109886 },	-- Crystalbinder Chestguard
				{ 15, 109897 },	-- Leafmender Robes
				{ 16, 109882 },	-- Blackwater Wristguards
				{ 17, 109869 },	-- Bloodfeather Bracers
				{ 18, 109868 },	-- Bracers of Burning Focus
				{ 19, 109870 },	-- Crystalbinder Wristguards
				{ 20, 109871 },	-- Leafmender Wraps
				{ 21, 109890 },	-- Lavalink Ringmail
				{ 22, 109891 },	-- Morningscale Chestguard
				{ 23, 109889 },	-- Rockhide Ringmail
				{ 24, 109888 },	-- Sharpeye Chestguard
				{ 25, 109887 },	-- Streamslither Chestguard
				{ 26, 109875 },	-- Lavalink Bracers
				{ 27, 109883 },	-- Morningscale Bracers
				{ 28, 109874 },	-- Rockhide Wristguards
				{ 29, 109873 },	-- Sharpeye Bracers
				{ 30, 109872 },	-- Streamslither Bracers
				{ 101, 109894 },	-- Goldsteel Chestguard
				{ 102, 109895 },	-- Gutcrusher Chestplate
				{ 103, 109892 },	-- Incarnadine Breastplate
				{ 104, 109896 },	-- Rivet-Sealed Breastplate
				{ 105, 109893 },	-- Verdant Plate Chest
				{ 106, 109878 },	-- Goldsteel Bindings
				{ 107, 109879 },	-- Gutcrusher Bracers
				{ 108, 109876 },	-- Incarnadine Bracers
				{ 109, 109880 },	-- Rivet-Sealed Bracers
				{ 110, 109877 },	-- Verdant Plate Wristguards
				{ 116, 110007 },	-- Voidmender's Shadowgem
				{ 118, 110036 },	-- Nhallish's Bloody Polearm
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{	--SBGBonemaw
			EncounterJournalID = 1140,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109861 },	-- Felflame Grips
				{ 2, 109845 },	-- Frost-Touched Gloves
				{ 3, 109844 },	-- Gloves of Arcane Mystery
				{ 4, 109846 },	-- Gloves of Swirling Light
				{ 5, 109847 },	-- Lightbinder Gloves
				{ 6, 109824 },	-- Cord of Arcane Mystery
				{ 7, 109826 },	-- Cord of Swirling Light
				{ 8, 109828 },	-- Felflame Belt
				{ 9, 109825 },	-- Frost-Touched Cord
				{ 10, 109827 },	-- Lightbinder Girdle
				{ 11, 109862 },	-- Blackwater Grips
				{ 12, 109849 },	-- Bloodfeather Grips
				{ 13, 109850 },	-- Crystalbinder Gloves
				{ 14, 109848 },	-- Gauntlets of Burning Focus
				{ 15, 109851 },	-- Leafmender Grips
				{ 16, 109829 },	-- Belt of Burning Focus
				{ 17, 109842 },	-- Blackwater Belt
				{ 18, 109830 },	-- Bloodfeather Girdle
				{ 19, 109831 },	-- Crystalbinder Belt
				{ 20, 109832 },	-- Leafmender Girdle
				{ 21, 109855 },	-- Lavalink Grips
				{ 22, 109863 },	-- Morningscale Gauntlet
				{ 23, 109854 },	-- Rockhide Gloves
				{ 24, 109853 },	-- Sharpeye Gauntlets
				{ 25, 109852 },	-- Streamslither Gauntlets
				{ 26, 109836 },	-- Lavalink Girdle
				{ 27, 109843 },	-- Morningscale Waistguard
				{ 28, 109835 },	-- Rockhide Links
				{ 29, 109834 },	-- Sharpeye Belt
				{ 30, 109833 },	-- Streamslither Belt
				{ 101, 109858 },	-- Goldsteel Gloves
				{ 102, 109859 },	-- Gutcrusher Gauntlets
				{ 103, 109856 },	-- Incarnadine Gauntlets
				{ 104, 109860 },	-- Rivet-Sealed Crushers
				{ 105, 109857 },	-- Verdant Plate Grips
				{ 106, 109839 },	-- Goldsteel Belt
				{ 107, 109840 },	-- Gutcrusher Greatbelt
				{ 108, 109837 },	-- Incarnadine Girdle
				{ 109, 109841 },	-- Rivet-Sealed Waistplate
				{ 110, 109838 },	-- Verdant Plate Belt
				{ 116, 110012 },	-- Bonemaw's Big Toe
				{ 118, 110037 },	-- Bonetooth Longbow
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 120, "ac9025" },
			},
		},
		{	--SBGNerzhul
			EncounterJournalID = 1160,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109974 },	-- Felflame Hood
				{ 2, 109971 },	-- Frost-Touched Hood
				{ 3, 109970 },	-- Hood of Arcane Mystery
				{ 4, 109972 },	-- Hood of Swirling Light
				{ 5, 109973 },	-- Lightbinder Cover
				{ 6, 109797 },	-- Felflame Sandals
				{ 7, 109785 },	-- Frost-Touched Boots
				{ 8, 109796 },	-- Lightbinder Treads
				{ 9, 109784 },	-- Sandals of Arcane Mystery
				{ 10, 109786 },	-- Sandals of Swirling Light
				{ 11, 109979 },	-- Blackwater Helm
				{ 12, 109976 },	-- Bloodfeather Cowl
				{ 13, 109977 },	-- Crystalbinder Helm
				{ 14, 109975 },	-- Hood of Burning Focus
				{ 15, 109978 },	-- Leafmender Hood
				{ 16, 109799 },	-- Blackwater Boots
				{ 17, 109788 },	-- Bloodfeather Treads
				{ 18, 109787 },	-- Boots of Burning Focus
				{ 19, 109789 },	-- Crystalbinder Sandals
				{ 20, 109798 },	-- Leafmender Sandals
				{ 21, 109983 },	-- Lavalink Helm
				{ 22, 109984 },	-- Morningscale Cowl
				{ 23, 109982 },	-- Rockhide Casque
				{ 24, 109981 },	-- Sharpeye Gleam
				{ 25, 109980 },	-- Streamslither Helm
				{ 26, 109800 },	-- Lavalink Stompers
				{ 27, 109801 },	-- Morningscale Treads
				{ 28, 109792 },	-- Rockhide Treads
				{ 29, 109791 },	-- Sharpeye Greaves
				{ 30, 109790 },	-- Streamslither Boots
				{ 101, 109987 },	-- Goldsteel Greathelm
				{ 102, 109988 },	-- Gutcrusher Coronet
				{ 103, 109985 },	-- Incarnadine Greathelm
				{ 104, 109989 },	-- Rivet-Sealed Casque
				{ 105, 109986 },	-- Verdant Plate Crown
				{ 106, 109795 },	-- Goldsteel Sabatons
				{ 107, 109802 },	-- Gutcrusher Stompers
				{ 108, 109793 },	-- Incarnadine Greaves
				{ 109, 109803 },	-- Rivet-Sealed Treads
				{ 110, 109794 },	-- Verdant Plate Treads
				{ 116, 109779 },	-- Ancient Draenic Loop
				{ 117, 109768 },	-- Band of Growing Leaves
				{ 118, 109773 },	-- Band of Iron Scale
				{ 119, 109783 },	-- Band of the Stalwart Stanchion
				{ 120, 109775 },	-- Bladebinder Ring
				{ 121, 109771 },	-- Bloodied Ring of Mytosis
				{ 122, 109761 },	-- Bloodthorn Band
				{ 123, 109760 },	-- Ced's Chiming Circle
				{ 124, 109766 },	-- Darkflame Loop
				{ 125, 109763 },	-- Diamondglow Circle
				{ 126, 109782 },	-- Disease-Binder Seal
				{ 127, 109765 },	-- Golem's Gleaming Eye
				{ 128, 109772 },	-- Knucklebone of Lo'Dronar
				{ 129, 109764 },	-- Mark of Ice
				{ 130, 109767 },	-- Ring of Purified Light
				{ 201, 109774 },	-- Ring of Ripped Flesh
				{ 202, 109759 },	-- Ro-Ger's Brown Diamond Seal
				{ 203, 109776 },	-- Seal of Resilient Fortitude
				{ 204, 109781 },	-- Seal of Vindication
				{ 205, 109770 },	-- Signet of Crashing Waves
				{ 206, 109762 },	-- Signet of Radiant Leaves
				{ 207, 109780 },	-- Signet of Shifting Magics
				{ 208, 109778 },	-- Signet of the Glorious Protector
				{ 209, 109769 },	-- Slicebinder Loop
				{ 210, 109777 },	-- Unsullied Signet
				{ 216, 110038 },	-- Ner'zhul's Ritual Blade
				{ 217, 110039 },	-- Portal-Ripper's Staff
				{ 219, "ac9041" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 220, "ac9054" },
				{ 221, "ac9026" },
			},
		},
		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
		WOD_DUNGEON_HERO_AC_TABLE,
		WOD_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["Skyreach"] = {
	EncounterJournalID = 476,
	MapID = 989,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--SkyreachRanjit
			EncounterJournalID = 965,
			[NORMAL_SKYREACH_DIFF] = {
				{ 1, 109974 },	-- Felflame Hood
				{ 2, 109971 },	-- Frost-Touched Hood
				{ 3, 109970 },	-- Hood of Arcane Mystery
				{ 4, 109972 },	-- Hood of Swirling Light
				{ 5, 109973 },	-- Lightbinder Cover
				{ 6, 109824 },	-- Cord of Arcane Mystery
				{ 7, 109826 },	-- Cord of Swirling Light
				{ 8, 109828 },	-- Felflame Belt
				{ 9, 109825 },	-- Frost-Touched Cord
				{ 10, 109827 },	-- Lightbinder Girdle
				{ 11, 109979 },	-- Blackwater Helm
				{ 12, 109976 },	-- Bloodfeather Cowl
				{ 13, 109977 },	-- Crystalbinder Helm
				{ 14, 109975 },	-- Hood of Burning Focus
				{ 15, 109978 },	-- Leafmender Hood
				{ 16, 109829 },	-- Belt of Burning Focus
				{ 17, 109842 },	-- Blackwater Belt
				{ 18, 109830 },	-- Bloodfeather Girdle
				{ 19, 109831 },	-- Crystalbinder Belt
				{ 20, 109832 },	-- Leafmender Girdle
				{ 21, 109983 },	-- Lavalink Helm
				{ 22, 109984 },	-- Morningscale Cowl
				{ 23, 109982 },	-- Rockhide Casque
				{ 24, 109981 },	-- Sharpeye Gleam
				{ 25, 109980 },	-- Streamslither Helm
				{ 26, 109836 },	-- Lavalink Girdle
				{ 27, 109843 },	-- Morningscale Waistguard
				{ 28, 109835 },	-- Rockhide Links
				{ 29, 109834 },	-- Sharpeye Belt
				{ 30, 109833 },	-- Streamslither Belt
				{ 101, 109987 },	-- Goldsteel Greathelm
				{ 102, 109988 },	-- Gutcrusher Coronet
				{ 103, 109985 },	-- Incarnadine Greathelm
				{ 104, 109989 },	-- Rivet-Sealed Casque
				{ 105, 109986 },	-- Verdant Plate Crown
				{ 106, 109839 },	-- Goldsteel Belt
				{ 107, 109840 },	-- Gutcrusher Greatbelt
				{ 108, 109837 },	-- Incarnadine Girdle
				{ 109, 109841 },	-- Rivet-Sealed Waistplate
				{ 110, 109838 },	-- Verdant Plate Belt
				{ 116, 110030 },	-- Chakram-Breaker Greatsword
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_SKYREACH_DIFF,
				{ 118, "ac9033" },
			},
		},
		{	--SkyreachAraknath
			EncounterJournalID = 966,
			[NORMAL_SKYREACH_DIFF] = {
				{ 1, 109797 },	-- Felflame Sandals
				{ 2, 109785 },	-- Frost-Touched Boots
				{ 3, 109796 },	-- Lightbinder Treads
				{ 4, 109784 },	-- Sandals of Arcane Mystery
				{ 5, 109786 },	-- Sandals of Swirling Light
				{ 6, 109799 },	-- Blackwater Boots
				{ 7, 109788 },	-- Bloodfeather Treads
				{ 8, 109787 },	-- Boots of Burning Focus
				{ 9, 109789 },	-- Crystalbinder Sandals
				{ 10, 109798 },	-- Leafmender Sandals
				{ 11, 109800 },	-- Lavalink Stompers
				{ 12, 109801 },	-- Morningscale Treads
				{ 13, 109792 },	-- Rockhide Treads
				{ 14, 109791 },	-- Sharpeye Greaves
				{ 15, 109790 },	-- Streamslither Boots
				{ 16, 109795 },	-- Goldsteel Sabatons
				{ 17, 109802 },	-- Gutcrusher Stompers
				{ 18, 109793 },	-- Incarnadine Greaves
				{ 19, 109803 },	-- Rivet-Sealed Treads
				{ 20, 109794 },	-- Verdant Plate Treads
				{ 101, 109957 },	-- Alc's Pendant of Fiery Dreams
				{ 102, 109962 },	-- Bloodmist Pendant
				{ 103, 109959 },	-- Chain of Soothing Light
				{ 104, 109969 },	-- Choker of Weeping Viscera
				{ 105, 109955 },	-- Demonbinder Cabochon
				{ 106, 109951 },	-- Fireblade Collar
				{ 107, 109965 },	-- Fistbreak Choker
				{ 108, 109968 },	-- Flesh Beetle Brooch
				{ 109, 109963 },	-- Goreclasp Choker
				{ 110, 109958 },	-- Healing Leaf Necklace
				{ 111, 109954 },	-- Magister's Chain
				{ 112, 109956 },	-- Necklace of Endless Shadow
				{ 113, 109964 },	-- Necklace of Furious Zeal
				{ 114, 109967 },	-- Necklace of Holy Deflection
				{ 115, 109961 },	-- Pendant of Purifying Mists
				{ 116, 109966 },	-- Reinforced Bloodsteel Gorget
				{ 117, 109952 },	-- Skulltooth Chain
				{ 118, 109950 },	-- Stormshot Choker
				{ 119, 109960 },	-- Wavesurge Choker
				{ 120, 109953 },	-- Windseal Necklace
				{ 122, 110016 },	-- Solar Containment Unit
				{ 124, 110031 },	-- Spire of the Furious Construct
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_SKYREACH_DIFF,
			},
		},
		{	--SkyreachRukhran
			EncounterJournalID = 967,
			[NORMAL_SKYREACH_DIFF] = {
				{ 1, 109864 },	-- Bracers of Arcane Mystery
				{ 2, 109866 },	-- Bracers of Swirling Light
				{ 3, 109881 },	-- Felflame Bracers
				{ 4, 109865 },	-- Frost-Touched Wristwraps
				{ 5, 109867 },	-- Lightbinder Wristwraps
				{ 6, 109861 },	-- Felflame Grips
				{ 7, 109845 },	-- Frost-Touched Gloves
				{ 8, 109844 },	-- Gloves of Arcane Mystery
				{ 9, 109846 },	-- Gloves of Swirling Light
				{ 10, 109847 },	-- Lightbinder Gloves
				{ 11, 109882 },	-- Blackwater Wristguards
				{ 12, 109869 },	-- Bloodfeather Bracers
				{ 13, 109868 },	-- Bracers of Burning Focus
				{ 14, 109870 },	-- Crystalbinder Wristguards
				{ 15, 109871 },	-- Leafmender Wraps
				{ 16, 109862 },	-- Blackwater Grips
				{ 17, 109849 },	-- Bloodfeather Grips
				{ 18, 109850 },	-- Crystalbinder Gloves
				{ 19, 109848 },	-- Gauntlets of Burning Focus
				{ 20, 109851 },	-- Leafmender Grips
				{ 21, 109875 },	-- Lavalink Bracers
				{ 22, 109883 },	-- Morningscale Bracers
				{ 23, 109874 },	-- Rockhide Wristguards
				{ 24, 109873 },	-- Sharpeye Bracers
				{ 25, 109872 },	-- Streamslither Bracers
				{ 26, 109855 },	-- Lavalink Grips
				{ 27, 109863 },	-- Morningscale Gauntlet
				{ 28, 109854 },	-- Rockhide Gloves
				{ 29, 109853 },	-- Sharpeye Gauntlets
				{ 30, 109852 },	-- Streamslither Gauntlets
				{ 101, 109878 },	-- Goldsteel Bindings
				{ 102, 109879 },	-- Gutcrusher Bracers
				{ 103, 109876 },	-- Incarnadine Bracers
				{ 104, 109880 },	-- Rivet-Sealed Bracers
				{ 105, 109877 },	-- Verdant Plate Wristguards
				{ 106, 109858 },	-- Goldsteel Gloves
				{ 107, 109859 },	-- Gutcrusher Gauntlets
				{ 108, 109856 },	-- Incarnadine Gauntlets
				{ 109, 109860 },	-- Rivet-Sealed Crushers
				{ 110, 109857 },	-- Verdant Plate Grips
				{ 116, 110006 },	-- Rukhran's Quill
				{ 118, 110032 },	-- Beakbreaker Scimitar
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_SKYREACH_DIFF,
				{ 120, "ac9035" },
			},
		},
		{	--SkyreachViryx
			EncounterJournalID = 968,
			[NORMAL_SKYREACH_DIFF] = {
				{ 1, 109948 },	-- Felflame Spaulders
				{ 2, 109931 },	-- Frost-Touched Shoulderpads
				{ 3, 109933 },	-- Lightbinder Shoulderpads
				{ 4, 109930 },	-- Mantle of Arcane Mystery
				{ 5, 109932 },	-- Mantle of Swirling Light
				{ 6, 109808 },	-- Felflame Legwraps
				{ 7, 109805 },	-- Frost-Touched Legwraps
				{ 8, 109806 },	-- Leggings of Swirling Light
				{ 9, 109807 },	-- Lightbinder Leggings
				{ 10, 109804 },	-- Trousers of Arcane Mystery
				{ 11, 109938 },	-- Blackwater Spaulders
				{ 12, 109935 },	-- Bloodfeather Spaulders
				{ 13, 109936 },	-- Crystalbinder Shoulderpads
				{ 14, 109937 },	-- Leafmender Mantle
				{ 15, 109934 },	-- Spaulders of Burning Focus
				{ 16, 109823 },	-- Blackwater Leggings
				{ 17, 109810 },	-- Bloodfeather Leggings
				{ 18, 109811 },	-- Crystalbinder Legwraps
				{ 19, 109812 },	-- Leafmender Legwraps
				{ 20, 109809 },	-- Legguards of Burning Focus
				{ 21, 109942 },	-- Lavalink Spaulders
				{ 22, 109949 },	-- Morningscale Spaulders
				{ 23, 109941 },	-- Rockhide Shoulderguards
				{ 24, 109940 },	-- Sharpeye Shoulderguards
				{ 25, 109939 },	-- Streamslither Spaulders
				{ 26, 109816 },	-- Lavalink Kilt
				{ 27, 109817 },	-- Morningscale Leggings
				{ 28, 109815 },	-- Rockhide Leggings
				{ 29, 109814 },	-- Sharpeye Legguards
				{ 30, 109813 },	-- Streamslither Legguards
				{ 101, 109945 },	-- Goldsteel Shouldercaps
				{ 102, 109946 },	-- Gutcrusher Shoulderplates
				{ 103, 109943 },	-- Incarnadine Shoulderguard
				{ 104, 109947 },	-- Rivet-Sealed Shoulderplates
				{ 105, 109944 },	-- Verdant Plate Spaulders
				{ 106, 109820 },	-- Goldsteel Legplates
				{ 107, 109821 },	-- Gutcrusher Legplates
				{ 108, 109818 },	-- Incarnadine Legplates
				{ 109, 109822 },	-- Rivet-Sealed Legplates
				{ 110, 109819 },	-- Verdant Plate Legguards
				{ 116, 109779 },	-- Ancient Draenic Loop
				{ 117, 109768 },	-- Band of Growing Leaves
				{ 118, 109773 },	-- Band of Iron Scale
				{ 119, 109783 },	-- Band of the Stalwart Stanchion
				{ 120, 109775 },	-- Bladebinder Ring
				{ 121, 109771 },	-- Bloodied Ring of Mytosis
				{ 122, 109761 },	-- Bloodthorn Band
				{ 123, 109760 },	-- Ced's Chiming Circle
				{ 124, 109766 },	-- Darkflame Loop
				{ 125, 109763 },	-- Diamondglow Circle
				{ 126, 109782 },	-- Disease-Binder Seal
				{ 127, 109765 },	-- Golem's Gleaming Eye
				{ 128, 109772 },	-- Knucklebone of Lo'Dronar
				{ 129, 109764 },	-- Mark of Ice
				{ 130, 109767 },	-- Ring of Purified Light
				{ 201, 109774 },	-- Ring of Ripped Flesh
				{ 202, 109759 },	-- Ro-Ger's Brown Diamond Seal
				{ 203, 109776 },	-- Seal of Resilient Fortitude
				{ 204, 109781 },	-- Seal of Vindication
				{ 205, 109770 },	-- Signet of Crashing Waves
				{ 206, 109762 },	-- Signet of Radiant Leaves
				{ 207, 109780 },	-- Signet of Shifting Magics
				{ 208, 109778 },	-- Signet of the Glorious Protector
				{ 209, 109769 },	-- Slicebinder Loop
				{ 210, 109777 },	-- Unsullied Signet
				{ 216, 110011 },	-- Fires of the Sun
				{ 218, 110033 },	-- Arcanic of the High Sage
				{ 219, 110034 },	-- Viryx's Indomitable Bulwark
				{ 221, "114780:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pure Solium Band
				{ 223, "ac8843" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_SKYREACH_DIFF,
				{ 224, "ac8844" },
				{ 225, "ac9036" },
			},
		},
		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
		WOD_DUNGEON_HERO_AC_TABLE,
		WOD_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["TheEverbloom"] = {
	EncounterJournalID = 556,
	MapID = 1008,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--EverbloomWitherbark
			EncounterJournalID = 1214,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109912 },	-- Bloody-Blade Drape
				{ 2, 109911 },	-- Cape of Annealing Flesh
				{ 3, 109908 },	-- Cloak of Arcane Mysteries
				{ 4, 109904 },	-- Cloak of Cascading Blades
				{ 5, 109910 },	-- Cloak of Mending Magics
				{ 6, 109929 },	-- Cloak of Steeled Nerves
				{ 7, 109906 },	-- Cloak of Violent Harmony
				{ 8, 109905 },	-- Deadshot Greatcloak
				{ 9, 109914 },	-- Drape of Dripping Runnels
				{ 10, 109926 },	-- Drape of Frozen Dreams
				{ 11, 109909 },	-- Drape of Iron Sutures
				{ 12, 109916 },	-- Drape of Swirling Deflection
				{ 13, 109907 },	-- Felbone Drape
				{ 14, 109925 },	-- Forgeflame Greatcloak
				{ 15, 109913 },	-- Headscythe Greatcloak
				{ 16, 109927 },	-- Mistwoven Windcloak
				{ 17, 109915 },	-- Rigid Scale Cloak
				{ 18, 109928 },	-- Skullcracker Cloak
				{ 19, 109918 },	-- Soot-Scarred Longcloak
				{ 20, 109917 },	-- Three-Clefthoof Cape
				{ 21, 109861 },	-- Felflame Grips
				{ 22, 109845 },	-- Frost-Touched Gloves
				{ 23, 109844 },	-- Gloves of Arcane Mystery
				{ 24, 109846 },	-- Gloves of Swirling Light
				{ 25, 109847 },	-- Lightbinder Gloves
				{ 26, 109862 },	-- Blackwater Grips
				{ 27, 109849 },	-- Bloodfeather Grips
				{ 28, 109850 },	-- Crystalbinder Gloves
				{ 29, 109848 },	-- Gauntlets of Burning Focus
				{ 30, 109851 },	-- Leafmender Grips
				{ 101, 109855 },	-- Lavalink Grips
				{ 102, 109863 },	-- Morningscale Gauntlet
				{ 103, 109854 },	-- Rockhide Gloves
				{ 104, 109853 },	-- Sharpeye Gauntlets
				{ 105, 109852 },	-- Streamslither Gauntlets
				{ 106, 109858 },	-- Goldsteel Gloves
				{ 107, 109859 },	-- Gutcrusher Gauntlets
				{ 108, 109856 },	-- Incarnadine Gauntlets
				{ 109, 109860 },	-- Rivet-Sealed Crushers
				{ 110, 109857 },	-- Verdant Plate Grips
				{ 116, 109999 },	-- Witherbark's Branch
				{ 118, 119175 },	-- Leafhide Penetrator
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 120, "ac9017" },
			},
		},
		{	--EverbloomProtectors
			EncounterJournalID = 1207,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109824 },	-- Cord of Arcane Mystery
				{ 2, 109826 },	-- Cord of Swirling Light
				{ 3, 109828 },	-- Felflame Belt
				{ 4, 109825 },	-- Frost-Touched Cord
				{ 5, 109827 },	-- Lightbinder Girdle
				{ 6, 109808 },	-- Felflame Legwraps
				{ 7, 109805 },	-- Frost-Touched Legwraps
				{ 8, 109806 },	-- Leggings of Swirling Light
				{ 9, 109807 },	-- Lightbinder Leggings
				{ 10, 109804 },	-- Trousers of Arcane Mystery
				{ 11, 109829 },	-- Belt of Burning Focus
				{ 12, 109842 },	-- Blackwater Belt
				{ 13, 109830 },	-- Bloodfeather Girdle
				{ 14, 109831 },	-- Crystalbinder Belt
				{ 15, 109832 },	-- Leafmender Girdle
				{ 16, 109823 },	-- Blackwater Leggings
				{ 17, 109810 },	-- Bloodfeather Leggings
				{ 18, 109811 },	-- Crystalbinder Legwraps
				{ 19, 109812 },	-- Leafmender Legwraps
				{ 20, 109809 },	-- Legguards of Burning Focus
				{ 21, 109836 },	-- Lavalink Girdle
				{ 22, 109843 },	-- Morningscale Waistguard
				{ 23, 109835 },	-- Rockhide Links
				{ 24, 109834 },	-- Sharpeye Belt
				{ 25, 109833 },	-- Streamslither Belt
				{ 26, 109816 },	-- Lavalink Kilt
				{ 27, 109817 },	-- Morningscale Leggings
				{ 28, 109815 },	-- Rockhide Leggings
				{ 29, 109814 },	-- Sharpeye Legguards
				{ 30, 109813 },	-- Streamslither Legguards
				{ 101, 109839 },	-- Goldsteel Belt
				{ 102, 109840 },	-- Gutcrusher Greatbelt
				{ 103, 109837 },	-- Incarnadine Girdle
				{ 104, 109841 },	-- Rivet-Sealed Waistplate
				{ 105, 109838 },	-- Verdant Plate Belt
				{ 106, 109820 },	-- Goldsteel Legplates
				{ 107, 109821 },	-- Gutcrusher Legplates
				{ 108, 109818 },	-- Incarnadine Legplates
				{ 109, 109822 },	-- Rivet-Sealed Legplates
				{ 110, 109819 },	-- Verdant Plate Legguards
				{ 116, 110009 },	-- Leaf of the Ancient Protectors
				{ 118, 119176 },	-- Interloper's Mossy Skull
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{	--EverbloomSol
			EncounterJournalID = 1208,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109974 },	-- Felflame Hood
				{ 2, 109971 },	-- Frost-Touched Hood
				{ 3, 109970 },	-- Hood of Arcane Mystery
				{ 4, 109972 },	-- Hood of Swirling Light
				{ 5, 109973 },	-- Lightbinder Cover
				{ 6, 109864 },	-- Bracers of Arcane Mystery
				{ 7, 109866 },	-- Bracers of Swirling Light
				{ 8, 109881 },	-- Felflame Bracers
				{ 9, 109865 },	-- Frost-Touched Wristwraps
				{ 10, 109867 },	-- Lightbinder Wristwraps
				{ 11, 109979 },	-- Blackwater Helm
				{ 12, 109976 },	-- Bloodfeather Cowl
				{ 13, 109977 },	-- Crystalbinder Helm
				{ 14, 109975 },	-- Hood of Burning Focus
				{ 15, 109978 },	-- Leafmender Hood
				{ 16, 109882 },	-- Blackwater Wristguards
				{ 17, 109869 },	-- Bloodfeather Bracers
				{ 18, 109868 },	-- Bracers of Burning Focus
				{ 19, 109870 },	-- Crystalbinder Wristguards
				{ 20, 109871 },	-- Leafmender Wraps
				{ 21, 109983 },	-- Lavalink Helm
				{ 22, 109984 },	-- Morningscale Cowl
				{ 23, 109982 },	-- Rockhide Casque
				{ 24, 109981 },	-- Sharpeye Gleam
				{ 25, 109980 },	-- Streamslither Helm
				{ 26, 109875 },	-- Lavalink Bracers
				{ 27, 109883 },	-- Morningscale Bracers
				{ 28, 109874 },	-- Rockhide Wristguards
				{ 29, 109873 },	-- Sharpeye Bracers
				{ 30, 109872 },	-- Streamslither Bracers
				{ 101, 109987 },	-- Goldsteel Greathelm
				{ 102, 109988 },	-- Gutcrusher Coronet
				{ 103, 109985 },	-- Incarnadine Greathelm
				{ 104, 109989 },	-- Rivet-Sealed Casque
				{ 105, 109986 },	-- Verdant Plate Crown
				{ 106, 109878 },	-- Goldsteel Bindings
				{ 107, 109879 },	-- Gutcrusher Bracers
				{ 108, 109876 },	-- Incarnadine Bracers
				{ 109, 109880 },	-- Rivet-Sealed Bracers
				{ 110, 109877 },	-- Verdant Plate Wristguards
				{ 116, 110014 },	-- Spores of Alacrity
				{ 118, 119174 },	-- Sol's Magestaff
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 120, "ac9493" },
			},
		},
		{	--EverbloomXeritac
			EncounterJournalID = 1209,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109903 },	-- Felflame Robes
				{ 2, 109900 },	-- Frost-Touched Robes
				{ 3, 109902 },	-- Lightbinder Robes
				{ 4, 109899 },	-- Robes of Arcane Mystery
				{ 5, 109901 },	-- Robes of Swirling Light
				{ 6, 109797 },	-- Felflame Sandals
				{ 7, 109785 },	-- Frost-Touched Boots
				{ 8, 109796 },	-- Lightbinder Treads
				{ 9, 109784 },	-- Sandals of Arcane Mystery
				{ 10, 109786 },	-- Sandals of Swirling Light
				{ 11, 109898 },	-- Blackwater Wrap
				{ 12, 109885 },	-- Bloodfeather Chestwrap
				{ 13, 109884 },	-- Chestguard of Burning Focus
				{ 14, 109886 },	-- Crystalbinder Chestguard
				{ 15, 109897 },	-- Leafmender Robes
				{ 16, 109799 },	-- Blackwater Boots
				{ 17, 109788 },	-- Bloodfeather Treads
				{ 18, 109787 },	-- Boots of Burning Focus
				{ 19, 109789 },	-- Crystalbinder Sandals
				{ 20, 109798 },	-- Leafmender Sandals
				{ 21, 109890 },	-- Lavalink Ringmail
				{ 22, 109891 },	-- Morningscale Chestguard
				{ 23, 109889 },	-- Rockhide Ringmail
				{ 24, 109888 },	-- Sharpeye Chestguard
				{ 25, 109887 },	-- Streamslither Chestguard
				{ 26, 109800 },	-- Lavalink Stompers
				{ 27, 109801 },	-- Morningscale Treads
				{ 28, 109792 },	-- Rockhide Treads
				{ 29, 109791 },	-- Sharpeye Greaves
				{ 30, 109790 },	-- Streamslither Boots
				{ 101, 109894 },	-- Goldsteel Chestguard
				{ 102, 109895 },	-- Gutcrusher Chestplate
				{ 103, 109892 },	-- Incarnadine Breastplate
				{ 104, 109896 },	-- Rivet-Sealed Breastplate
				{ 105, 109893 },	-- Verdant Plate Chest
				{ 106, 109795 },	-- Goldsteel Sabatons
				{ 107, 109802 },	-- Gutcrusher Stompers
				{ 108, 109793 },	-- Incarnadine Greaves
				{ 109, 109803 },	-- Rivet-Sealed Treads
				{ 110, 109794 },	-- Verdant Plate Treads
				{ 116, 110019 },	-- Xeri'tac's Unhatched Egg Sac
				{ 118, 119173 },	-- Dessicated Husk Shield
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{	--EverbloomYalnu
			EncounterJournalID = 1210,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109948 },	-- Felflame Spaulders
				{ 2, 109931 },	-- Frost-Touched Shoulderpads
				{ 3, 109933 },	-- Lightbinder Shoulderpads
				{ 4, 109930 },	-- Mantle of Arcane Mystery
				{ 5, 109932 },	-- Mantle of Swirling Light
				{ 6, 109938 },	-- Blackwater Spaulders
				{ 7, 109935 },	-- Bloodfeather Spaulders
				{ 8, 109936 },	-- Crystalbinder Shoulderpads
				{ 9, 109937 },	-- Leafmender Mantle
				{ 10, 109934 },	-- Spaulders of Burning Focus
				{ 11, 109942 },	-- Lavalink Spaulders
				{ 12, 109949 },	-- Morningscale Spaulders
				{ 13, 109941 },	-- Rockhide Shoulderguards
				{ 14, 109940 },	-- Sharpeye Shoulderguards
				{ 15, 109939 },	-- Streamslither Spaulders
				{ 16, 109945 },	-- Goldsteel Shouldercaps
				{ 17, 109946 },	-- Gutcrusher Shoulderplates
				{ 18, 109943 },	-- Incarnadine Shoulderguard
				{ 19, 109947 },	-- Rivet-Sealed Shoulderplates
				{ 20, 109944 },	-- Verdant Plate Spaulders
				{ 101, 109957 },	-- Alc's Pendant of Fiery Dreams
				{ 102, 109962 },	-- Bloodmist Pendant
				{ 103, 109959 },	-- Chain of Soothing Light
				{ 104, 109969 },	-- Choker of Weeping Viscera
				{ 105, 109955 },	-- Demonbinder Cabochon
				{ 106, 109951 },	-- Fireblade Collar
				{ 107, 109965 },	-- Fistbreak Choker
				{ 108, 109968 },	-- Flesh Beetle Brooch
				{ 109, 109963 },	-- Goreclasp Choker
				{ 110, 109958 },	-- Healing Leaf Necklace
				{ 111, 109954 },	-- Magister's Chain
				{ 112, 109956 },	-- Necklace of Endless Shadow
				{ 113, 109964 },	-- Necklace of Furious Zeal
				{ 114, 109967 },	-- Necklace of Holy Deflection
				{ 115, 109961 },	-- Pendant of Purifying Mists
				{ 116, 109966 },	-- Reinforced Bloodsteel Gorget
				{ 117, 109952 },	-- Skulltooth Chain
				{ 118, 109950 },	-- Stormshot Choker
				{ 119, 109960 },	-- Wavesurge Choker
				{ 120, 109953 },	-- Windseal Necklace
				{ 121, 109779 },	-- Ancient Draenic Loop
				{ 122, 109768 },	-- Band of Growing Leaves
				{ 123, 109773 },	-- Band of Iron Scale
				{ 124, 109783 },	-- Band of the Stalwart Stanchion
				{ 125, 109775 },	-- Bladebinder Ring
				{ 126, 109771 },	-- Bloodied Ring of Mytosis
				{ 127, 109761 },	-- Bloodthorn Band
				{ 128, 109760 },	-- Ced's Chiming Circle
				{ 129, 109766 },	-- Darkflame Loop
				{ 130, 109763 },	-- Diamondglow Circle
				{ 201, 109782 },	-- Disease-Binder Seal
				{ 202, 109765 },	-- Golem's Gleaming Eye
				{ 203, 109772 },	-- Knucklebone of Lo'Dronar
				{ 204, 109764 },	-- Mark of Ice
				{ 205, 109767 },	-- Ring of Purified Light
				{ 206, 109774 },	-- Ring of Ripped Flesh
				{ 207, 109759 },	-- Ro-Ger's Brown Diamond Seal
				{ 208, 109776 },	-- Seal of Resilient Fortitude
				{ 209, 109781 },	-- Seal of Vindication
				{ 210, 109770 },	-- Signet of Crashing Waves
				{ 211, 109762 },	-- Signet of Radiant Leaves
				{ 212, 109780 },	-- Signet of Shifting Magics
				{ 213, 109778 },	-- Signet of the Glorious Protector
				{ 214, 109769 },	-- Slicebinder Loop
				{ 215, 109777 },	-- Unsullied Signet
				{ 216, 110004 },	-- Coagulated Genesaur Blood
				{ 218, 119181 },	-- Hoof of Yalnu
				{ 220, "ac9044" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 220, "114138:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Core of Life
				{ 222, "ac9044" },
				{ 223, "ac9053" },
				{ 224, "ac9223" },
			},
		},
		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
		WOD_DUNGEON_HERO_AC_TABLE,
		WOD_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["UpperBlackrockSpire"] = {
	EncounterJournalID = 559,
	MapID = 995,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--UBRSGorashan
			EncounterJournalID = 1226,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109912 },	-- Bloody-Blade Drape
				{ 2, 109911 },	-- Cape of Annealing Flesh
				{ 3, 109908 },	-- Cloak of Arcane Mysteries
				{ 4, 109904 },	-- Cloak of Cascading Blades
				{ 5, 109910 },	-- Cloak of Mending Magics
				{ 6, 109929 },	-- Cloak of Steeled Nerves
				{ 7, 109906 },	-- Cloak of Violent Harmony
				{ 8, 109905 },	-- Deadshot Greatcloak
				{ 9, 109914 },	-- Drape of Dripping Runnels
				{ 10, 109926 },	-- Drape of Frozen Dreams
				{ 11, 109909 },	-- Drape of Iron Sutures
				{ 12, 109916 },	-- Drape of Swirling Deflection
				{ 13, 109907 },	-- Felbone Drape
				{ 14, 109925 },	-- Forgeflame Greatcloak
				{ 15, 109913 },	-- Headscythe Greatcloak
				{ 16, 109927 },	-- Mistwoven Windcloak
				{ 17, 109915 },	-- Rigid Scale Cloak
				{ 18, 109928 },	-- Skullcracker Cloak
				{ 19, 109918 },	-- Soot-Scarred Longcloak
				{ 20, 109917 },	-- Three-Clefthoof Cape
				{ 21, 109797 },	-- Felflame Sandals
				{ 22, 109785 },	-- Frost-Touched Boots
				{ 23, 109796 },	-- Lightbinder Treads
				{ 24, 109784 },	-- Sandals of Arcane Mystery
				{ 25, 109786 },	-- Sandals of Swirling Light
				{ 26, 109799 },	-- Blackwater Boots
				{ 27, 109788 },	-- Bloodfeather Treads
				{ 28, 109787 },	-- Boots of Burning Focus
				{ 29, 109789 },	-- Crystalbinder Sandals
				{ 30, 109798 },	-- Leafmender Sandals
				{ 101, 109800 },	-- Lavalink Stompers
				{ 102, 109801 },	-- Morningscale Treads
				{ 103, 109792 },	-- Rockhide Treads
				{ 104, 109791 },	-- Sharpeye Greaves
				{ 105, 109790 },	-- Streamslither Boots
				{ 106, 109795 },	-- Goldsteel Sabatons
				{ 107, 109802 },	-- Gutcrusher Stompers
				{ 108, 109793 },	-- Incarnadine Greaves
				{ 109, 109803 },	-- Rivet-Sealed Treads
				{ 110, 109794 },	-- Verdant Plate Treads
				{ 116, 109998 },	-- Gor'ashan's Lodestone Spike
				{ 118, 118719 },	-- Petrified Willow
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 120, "ac9045" },
			},
		},
		{	--UBRSKyrak
			EncounterJournalID = 1227,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109948 },	-- Felflame Spaulders
				{ 2, 109931 },	-- Frost-Touched Shoulderpads
				{ 3, 109933 },	-- Lightbinder Shoulderpads
				{ 4, 109930 },	-- Mantle of Arcane Mystery
				{ 5, 109932 },	-- Mantle of Swirling Light
				{ 6, 109938 },	-- Blackwater Spaulders
				{ 7, 109935 },	-- Bloodfeather Spaulders
				{ 8, 109936 },	-- Crystalbinder Shoulderpads
				{ 9, 109937 },	-- Leafmender Mantle
				{ 10, 109934 },	-- Spaulders of Burning Focus
				{ 11, 109942 },	-- Lavalink Spaulders
				{ 12, 109949 },	-- Morningscale Spaulders
				{ 13, 109941 },	-- Rockhide Shoulderguards
				{ 14, 109940 },	-- Sharpeye Shoulderguards
				{ 15, 109939 },	-- Streamslither Spaulders
				{ 16, 109945 },	-- Goldsteel Shouldercaps
				{ 17, 109946 },	-- Gutcrusher Shoulderplates
				{ 18, 109943 },	-- Incarnadine Shoulderguard
				{ 19, 109947 },	-- Rivet-Sealed Shoulderplates
				{ 20, 109944 },	-- Verdant Plate Spaulders
				{ 101, 109779 },	-- Ancient Draenic Loop
				{ 102, 109768 },	-- Band of Growing Leaves
				{ 103, 109773 },	-- Band of Iron Scale
				{ 104, 109783 },	-- Band of the Stalwart Stanchion
				{ 105, 109775 },	-- Bladebinder Ring
				{ 106, 109771 },	-- Bloodied Ring of Mytosis
				{ 107, 109761 },	-- Bloodthorn Band
				{ 108, 109760 },	-- Ced's Chiming Circle
				{ 109, 109766 },	-- Darkflame Loop
				{ 110, 109763 },	-- Diamondglow Circle
				{ 111, 109782 },	-- Disease-Binder Seal
				{ 112, 109765 },	-- Golem's Gleaming Eye
				{ 113, 109772 },	-- Knucklebone of Lo'Dronar
				{ 114, 109764 },	-- Mark of Ice
				{ 115, 109767 },	-- Ring of Purified Light
				{ 116, 109774 },	-- Ring of Ripped Flesh
				{ 117, 109759 },	-- Ro-Ger's Brown Diamond Seal
				{ 118, 109776 },	-- Seal of Resilient Fortitude
				{ 119, 109781 },	-- Seal of Vindication
				{ 120, 109770 },	-- Signet of Crashing Waves
				{ 121, 109762 },	-- Signet of Radiant Leaves
				{ 122, 109780 },	-- Signet of Shifting Magics
				{ 123, 109778 },	-- Signet of the Glorious Protector
				{ 124, 109769 },	-- Slicebinder Loop
				{ 125, 109777 },	-- Unsullied Signet
				{ 127, 110018 },	-- Kyrak's Vileblood Serum
				{ 129, 118724 },	-- Finkle's Flenser
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 130, "ac9058" },
			},
		},
		{	--UBRSTharbek
			EncounterJournalID = 1228,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109903 },	-- Felflame Robes
				{ 2, 109900 },	-- Frost-Touched Robes
				{ 3, 109902 },	-- Lightbinder Robes
				{ 4, 109899 },	-- Robes of Arcane Mystery
				{ 5, 109901 },	-- Robes of Swirling Light
				{ 6, 109861 },	-- Felflame Grips
				{ 7, 109845 },	-- Frost-Touched Gloves
				{ 8, 109844 },	-- Gloves of Arcane Mystery
				{ 9, 109846 },	-- Gloves of Swirling Light
				{ 10, 109847 },	-- Lightbinder Gloves
				{ 11, 109898 },	-- Blackwater Wrap
				{ 12, 109885 },	-- Bloodfeather Chestwrap
				{ 13, 109884 },	-- Chestguard of Burning Focus
				{ 14, 109886 },	-- Crystalbinder Chestguard
				{ 15, 109897 },	-- Leafmender Robes
				{ 16, 109862 },	-- Blackwater Grips
				{ 17, 109849 },	-- Bloodfeather Grips
				{ 18, 109850 },	-- Crystalbinder Gloves
				{ 19, 109848 },	-- Gauntlets of Burning Focus
				{ 20, 109851 },	-- Leafmender Grips
				{ 21, 109890 },	-- Lavalink Ringmail
				{ 22, 109891 },	-- Morningscale Chestguard
				{ 23, 109889 },	-- Rockhide Ringmail
				{ 24, 109888 },	-- Sharpeye Chestguard
				{ 25, 109887 },	-- Streamslither Chestguard
				{ 26, 109855 },	-- Lavalink Grips
				{ 27, 109863 },	-- Morningscale Gauntlet
				{ 28, 109854 },	-- Rockhide Gloves
				{ 29, 109853 },	-- Sharpeye Gauntlets
				{ 30, 109852 },	-- Streamslither Gauntlets
				{ 101, 109894 },	-- Goldsteel Chestguard
				{ 102, 109895 },	-- Gutcrusher Chestplate
				{ 103, 109892 },	-- Incarnadine Breastplate
				{ 104, 109896 },	-- Rivet-Sealed Breastplate
				{ 105, 109893 },	-- Verdant Plate Chest
				{ 106, 109858 },	-- Goldsteel Gloves
				{ 107, 109859 },	-- Gutcrusher Gauntlets
				{ 108, 109856 },	-- Incarnadine Gauntlets
				{ 109, 109860 },	-- Rivet-Sealed Crushers
				{ 110, 109857 },	-- Verdant Plate Grips
				{ 116, 110008 },	-- Tharbek's Lucky Pebble
				{ 118, 118726 },	-- Tharbek's Brutal Posessor
				{ 119, 118725 },	-- Tharbek's Unholy Charge
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
			},
		},
		{	--UBRSRagewing
			EncounterJournalID = 1229,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109808 },	-- Felflame Legwraps
				{ 2, 109805 },	-- Frost-Touched Legwraps
				{ 3, 109806 },	-- Leggings of Swirling Light
				{ 4, 109807 },	-- Lightbinder Leggings
				{ 5, 109804 },	-- Trousers of Arcane Mystery
				{ 6, 109823 },	-- Blackwater Leggings
				{ 7, 109810 },	-- Bloodfeather Leggings
				{ 8, 109811 },	-- Crystalbinder Legwraps
				{ 9, 109812 },	-- Leafmender Legwraps
				{ 10, 109809 },	-- Legguards of Burning Focus
				{ 11, 109816 },	-- Lavalink Kilt
				{ 12, 109817 },	-- Morningscale Leggings
				{ 13, 109815 },	-- Rockhide Leggings
				{ 14, 109814 },	-- Sharpeye Legguards
				{ 15, 109813 },	-- Streamslither Legguards
				{ 16, 109820 },	-- Goldsteel Legplates
				{ 17, 109821 },	-- Gutcrusher Legplates
				{ 18, 109818 },	-- Incarnadine Legplates
				{ 19, 109822 },	-- Rivet-Sealed Legplates
				{ 20, 109819 },	-- Verdant Plate Legguards
				{ 101, 109957 },	-- Alc's Pendant of Fiery Dreams
				{ 102, 109962 },	-- Bloodmist Pendant
				{ 103, 109959 },	-- Chain of Soothing Light
				{ 104, 109969 },	-- Choker of Weeping Viscera
				{ 105, 109955 },	-- Demonbinder Cabochon
				{ 106, 109951 },	-- Fireblade Collar
				{ 107, 109965 },	-- Fistbreak Choker
				{ 108, 109968 },	-- Flesh Beetle Brooch
				{ 109, 109963 },	-- Goreclasp Choker
				{ 110, 109958 },	-- Healing Leaf Necklace
				{ 111, 109954 },	-- Magister's Chain
				{ 112, 109956 },	-- Necklace of Endless Shadow
				{ 113, 109964 },	-- Necklace of Furious Zeal
				{ 114, 109967 },	-- Necklace of Holy Deflection
				{ 115, 109961 },	-- Pendant of Purifying Mists
				{ 116, 109966 },	-- Reinforced Bloodsteel Gorget
				{ 117, 109952 },	-- Skulltooth Chain
				{ 118, 109950 },	-- Stormshot Choker
				{ 119, 109960 },	-- Wavesurge Choker
				{ 120, 109953 },	-- Windseal Necklace
				{ 122, 110003 },	-- Ragewing's Firefang
				{ 124, 118737 },	-- Blackhand Doomcutter
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 126, "ac9056" },
			},
		},
		{	--UBRSZaela
			EncounterJournalID = 1234,
			[NORMAL_DUNGEON_DIFF] = {
				{ 1, 109974 },	-- Felflame Hood
				{ 2, 109971 },	-- Frost-Touched Hood
				{ 3, 109970 },	-- Hood of Arcane Mystery
				{ 4, 109972 },	-- Hood of Swirling Light
				{ 5, 109973 },	-- Lightbinder Cover
				{ 6, 109864 },	-- Bracers of Arcane Mystery
				{ 7, 109866 },	-- Bracers of Swirling Light
				{ 8, 109881 },	-- Felflame Bracers
				{ 9, 109865 },	-- Frost-Touched Wristwraps
				{ 10, 109867 },	-- Lightbinder Wristwraps
				{ 11, 109824 },	-- Cord of Arcane Mystery
				{ 12, 109826 },	-- Cord of Swirling Light
				{ 13, 109828 },	-- Felflame Belt
				{ 14, 109825 },	-- Frost-Touched Cord
				{ 15, 109827 },	-- Lightbinder Girdle
				{ 16, 109979 },	-- Blackwater Helm
				{ 17, 109976 },	-- Bloodfeather Cowl
				{ 18, 109977 },	-- Crystalbinder Helm
				{ 19, 109975 },	-- Hood of Burning Focus
				{ 20, 109978 },	-- Leafmender Hood
				{ 21, 109882 },	-- Blackwater Wristguards
				{ 22, 109869 },	-- Bloodfeather Bracers
				{ 23, 109868 },	-- Bracers of Burning Focus
				{ 24, 109870 },	-- Crystalbinder Wristguards
				{ 25, 109871 },	-- Leafmender Wraps
				{ 26, 109829 },	-- Belt of Burning Focus
				{ 27, 109842 },	-- Blackwater Belt
				{ 28, 109830 },	-- Bloodfeather Girdle
				{ 29, 109831 },	-- Crystalbinder Belt
				{ 30, 109832 },	-- Leafmender Girdle
				{ 101, 109983 },	-- Lavalink Helm
				{ 102, 109984 },	-- Morningscale Cowl
				{ 103, 109982 },	-- Rockhide Casque
				{ 104, 109981 },	-- Sharpeye Gleam
				{ 105, 109980 },	-- Streamslither Helm
				{ 106, 109875 },	-- Lavalink Bracers
				{ 107, 109883 },	-- Morningscale Bracers
				{ 108, 109874 },	-- Rockhide Wristguards
				{ 109, 109873 },	-- Sharpeye Bracers
				{ 110, 109872 },	-- Streamslither Bracers
				{ 111, 109836 },	-- Lavalink Girdle
				{ 112, 109843 },	-- Morningscale Waistguard
				{ 113, 109835 },	-- Rockhide Links
				{ 114, 109834 },	-- Sharpeye Belt
				{ 115, 109833 },	-- Streamslither Belt
				{ 116, 109987 },	-- Goldsteel Greathelm
				{ 117, 109988 },	-- Gutcrusher Coronet
				{ 118, 109985 },	-- Incarnadine Greathelm
				{ 119, 109989 },	-- Rivet-Sealed Casque
				{ 120, 109986 },	-- Verdant Plate Crown
				{ 121, 109878 },	-- Goldsteel Bindings
				{ 122, 109879 },	-- Gutcrusher Bracers
				{ 123, 109876 },	-- Incarnadine Bracers
				{ 124, 109880 },	-- Rivet-Sealed Bracers
				{ 125, 109877 },	-- Verdant Plate Wristguards
				{ 126, 109839 },	-- Goldsteel Belt
				{ 127, 109840 },	-- Gutcrusher Greatbelt
				{ 128, 109837 },	-- Incarnadine Girdle
				{ 129, 109841 },	-- Rivet-Sealed Waistplate
				{ 130, 109838 },	-- Verdant Plate Belt
				{ 201, 110013 },	-- Emberscale Talisman
				{ 203, 118740 },	-- Bleakblade of Shahram
				{ 204, 118738 },	-- Felshanker
				{ 205, 118739 },	-- Draconian Doomshield
				{ 216, "ac9042" },
			},
			[HEROIC_DUNGEON_DIFF] = {
				GetItemsFromDiff = NORMAL_DUNGEON_DIFF,
				{ 217, "ac9055" },
				{ 218, "ac9057" },
			},
		},
		{	--Challenge Mode Gear
			name = AL["Challenge Mode Gear"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CMGEAR:1",
		},
		WOD_DUNGEON_HERO_AC_TABLE,
		WOD_GLORY_OF_THE_HERO_AC_TABLE,
	}
}

data["BlackrockFoundry"] = {
	EncounterJournalID = 457,
	MapID = 988,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{	--BFGruul
			EncounterJournalID = 1161,
			[RF_DIFF] = {
				{ 1, 116307 },	-- Cloak of Unfulfilled Potential
				{ 2, 116009 },	-- Rockfall Girdle
				{ 3, 116018 },	-- Cave Smasher Leggings
				{ 4, 116229 },	-- Gaze of the Gronn Killer
				{ 5, 116216 },	-- Grips of Shackled Power
				{ 6, 116045 },	-- Spelunker's Chestguard
				{ 7, 116039 },	-- Delver's Belt
				{ 8, 116242 },	-- Gruul's Smallest Shackles
				{ 16, 116299 },	-- Eye of the Gronn
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113873 },	-- Gronn-Stitched Greatcloak
				{ 2, 120078 },	-- Runescribed Gronncloak
				{ 3, 113868 },	-- Flare-Eyed Hood
				{ 4, 113864 },	-- Cavedweller's Climbers
				{ 5, 113870 },	-- Vest of Forceful Fury
				{ 6, 113863 },	-- Gronn-Skin Crown
				{ 7, 113867 },	-- Spaulders of Reflected Stone
				{ 8, 113871 },	-- Bracers of Martial Perfection
				{ 16, 113865 },	-- Darklight Necklace
				{ 17, 113872 },	-- Gruul's Lip Ring
				{ 18, 113866 },	-- Phosphorescent Seal
				{ 19, 118114 },	-- Meaty Dragonspine Trophy
				{ 21, 113869 },	-- Inferno-Flame Staff
				{ 22, 113862 },	-- Taner's Terrible Spine
				{ 24, "ac8978" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, "ac8966" },
			},
		},
		{	--BFOregorger
			EncounterJournalID = 1202,
			[RF_DIFF] = {
				{ 1, 116308 },	-- Greatcloak of Insatiable Hunger
				{ 2, 116007 },	-- Bracers of Unending Consumption
				{ 3, 116021 },	-- Chasmwalker Sandals
				{ 4, 116215 },	-- Barrage Blaster Belt
				{ 5, 116046 },	-- Bracers of Satiation
				{ 6, 116033 },	-- Roilgut Gauntlets
				{ 7, 116257 },	-- Acid-Munched Greathelm
				{ 8, 116240 },	-- Waistplate of Caustic Spittle
				{ 16, 116310 },	-- Slag-Coated Cabochon
				{ 18, 116381 },	-- Oregorger's Blackrock Shanker
				{ 19, 116380 },	-- Oregorger's Venomous Canine
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113878 },	-- Barrage Dodger Cloak
				{ 2, 113883 },	-- Ravenous Greatcloak
				{ 3, 113876 },	-- Toothbreaker Grips
				{ 4, 113880 },	-- Acidic Jaws
				{ 5, 113875 },	-- Corrosion-Proof Legguards
				{ 6, 113884 },	-- Unstable Slag Shoulderplates
				{ 7, 113881 },	-- Chestplate of Rolling Fury
				{ 16, 113882 },	-- Glutton's Kerchief
				{ 17, 113877 },	-- Unexploded Explosive Shard
				{ 18, 119194 },	-- Goren Soul Repository
				{ 20, 119448 },	-- Head-Lopper Skullscythe
				{ 21, 113874 },	-- Oregorger's Acid-Etched Gutripper
				{ 22, 113879 },	-- Caged Living Ooze
				{ 24, "ac8979" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, "ac8967" },
			},
		},
		{	--BFDarmac
			EncounterJournalID = 1122,
			[RF_DIFF] = {
				{ 1, 116306 },	-- Dreaded Wing
				{ 2, 116016 },	-- Robes of Brutal Tantrums
				{ 3, 116019 },	-- Treads of the Flaming Maw
				{ 4, 116223 },	-- Legguards of the Unstoppable Charge
				{ 5, 116213 },	-- Black Iron Spurs
				{ 6, 116038 },	-- Beastmaster's Iron Bracers
				{ 7, 116048 },	-- Rylakk-Rider's Legguards
				{ 8, 116255 },	-- Heartsmasher Chestplate
				{ 9, 116262 },	-- Waistplate of Soothed Beasts
				{ 16, 116302 },	-- Thunderlord Trainer's Insignia
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113945 },	-- Flame Infusion Drape
				{ 2, 113941 },	-- Seeking Ember Girdle
				{ 3, 113942 },	-- Inferno Breath Sandals
				{ 4, 113951 },	-- Unrendable Wolfhide Robes
				{ 5, 113949 },	-- Cannonball Loader's Grips
				{ 6, 113943 },	-- Bracers of the Wolf's Cunning
				{ 7, 113944 },	-- Legguards of the Stampede
				{ 8, 113950 },	-- Ironcrusher's Collar
				{ 16, 113952 },	-- Choker of Bestial Force
				{ 17, 113947 },	-- Epicenter Loop
				{ 18, 113940 },	-- Seal of the Savage Howl
				{ 19, 113948 },	-- Darmac's Unstable Talisman
				{ 20, 119192 },	-- Ironspike Chew Toy
				{ 22, 113939 },	-- Tal'rak, Bloody Skull of the Thunderlords
				{ 23, 113946 },	-- Heart of the Clefthoof
				{ 25, "ac8981" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 26, "ac8956" },
			},
		},
		{	--BFKagraz
			EncounterJournalID = 1123,
			[RF_DIFF] = {
				{ 1, 116011 },	-- Fixated Treads
				{ 2, 116226 },	-- Scorched Gauntlet Liners
				{ 3, 116264 },	-- Cinderhide Belt
				{ 4, 116047 },	-- Bloodsteel Warbelt
				{ 5, 116040 },	-- Magma-Mauled Leggings
				{ 6, 116245 },	-- Maw of Charring Breath
				{ 7, 116253 },	-- Lava-Crushing Grips
				{ 16, 116313 },	-- Choker of Oozing Wounds
				{ 17, 116316 },	-- Captured Flickerspark
				{ 19, 116385 },	-- Magma Monsoon Mace
				{ 20, 116384 },	-- Steelbringer's Polished Shield
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113916 },	-- Charbreath Firecloak
				{ 2, 113914 },	-- Leggings of the Molten Torrent
				{ 3, 113924 },	-- Flamebender's Shoulderguards
				{ 4, 113915 },	-- Grips of Rekindling
				{ 5, 113919 },	-- Treads of Rekindled Flames
				{ 6, 113925 },	-- Flamefury Gauntlets
				{ 7, 113921 },	-- Firestorm Legplates
				{ 9, 120077 },	-- Choker of Bloody Flame
				{ 10, 113923 },	-- Fiery Links of Courage
				{ 11, 113917 },	-- Cinderwolf Signet
				{ 12, 113922 },	-- Seal of Unquenchable Flame
				{ 13, 119193 },	-- Horn of Screaming Spirits
				{ 16, 119305, false },	-- Chest of the Iron Conqueror
				{ 17, 119318, false },	-- Chest of the Iron Protector
				{ 18, 119315, false },	-- Chest of the Iron Vanquisher
				{ 20, 113920 },	-- Dagger of Blazing Radiance
				{ 21, 113918 },	-- Molten Edge Eviscerator
				{ 22, 113913 },	-- Ka'graz's Burning Blade
				{ 24, "ac8929" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, "ac8932" },
			},
		},
		{	--BFHansgarFranzok
			EncounterJournalID = 1155,
			[RF_DIFF] = {
				{ 1, 116305 },	-- Scorchburn Cloak
				{ 2, 116012 },	-- Fresh-Face Hood
				{ 3, 116227 },	-- Blood-Binder Chestguard
				{ 4, 116217 },	-- Brawler Brother's Bracers
				{ 5, 116034 },	-- Drop Kickers
				{ 6, 116256 },	-- Elbow Drop Spaulders
				{ 7, 116238 },	-- Heel Protectors
				{ 16, 116311 },	-- Choker of Infinite Durability
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113903 },	-- Giant Pumpers
				{ 2, 113898 },	-- Eye-Catching Gilded Robe
				{ 3, 113907 },	-- Girdle of Unconquered Glory
				{ 4, 113899 },	-- Neckbreaker Shoulderguards
				{ 5, 113902 },	-- Chestguard of Unending Roars
				{ 6, 113910 },	-- Hardened Greathelm
				{ 7, 113906 },	-- Gauntlets of Dramatic Blows
				{ 16, 113900 },	-- Vertebrae Protector
				{ 17, 113908 },	-- Razoredge Blade Ring
				{ 18, 113901 },	-- Six-Eyed Band
				{ 19, 113905 },	-- Tablet of Turnbuckle Teamwork
				{ 21, 113904 },	-- Franzok's Headsmasher
				{ 22, 113897 },	-- Hans'gar's Forgehammer
				{ 24, "ac8980" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, "ac8968" },
			},
		},
		{	--BFOperatorThogar
			EncounterJournalID = 1147,
			[RF_DIFF] = {
				{ 1, 116304 },	-- Deadshot Longcloak
				{ 2, 116013 },	-- Spaulders of Soothing Flame
				{ 3, 116014 },	-- Grips of Cauterization
				{ 4, 116265 },	-- Sniper's Ammo Belt
				{ 5, 116049 },	-- Raider's Spikeholder Belt
				{ 6, 116252 },	-- Waistplate of Obliteration
				{ 7, 116239 },	-- Gunnery Sergeant's Legplates
				{ 16, 116301 },	-- Lava Shock Seal
				{ 18, 116388 },	-- Crack-Shot Longrifle
				{ 19, 116389 },	-- Thogar's Imperialistic Spire
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113958 },	-- Woundsear Robes
				{ 2, 113956 },	-- Bracers of Enkindled Power
				{ 3, 113962 },	-- Squire's Electroplated Bracers
				{ 4, 113964 },	-- Conductor's Multi-Pocket Girdle
				{ 5, 113955 },	-- Grenadier's Belt
				{ 6, 113954 },	-- Railwalker's Ratcheted Boots
				{ 7, 113961 },	-- Iron Bellow Sabatons
				{ 9, 113959 },	-- Thogar's Serrated Chain
				{ 10, 113957 },	-- Firemender's Smoldering Signet
				{ 11, 113963 },	-- Siege Bomber's Band
				{ 16, 119309, false },	-- Shoulders of the Iron Conqueror
				{ 17, 119322, false },	-- Shoulders of the Iron Protector
				{ 18, 119314, false },	-- Shoulders of the Iron Vanquisher
				{ 20, 113953 },	-- Thogar's Control Rod
				{ 21, 113960 },	-- Engine-Stoker's Lantern
				{ 23, "ac8982" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 24, "ac8969" },
			},
		},
		{	--BFBlastFurnace
			EncounterJournalID = 1154,
			[RF_DIFF] = {
				{ 1, 116004 },	-- Pyroclastic Hood
				{ 2, 116015 },	-- Bracers of Searing Heat
				{ 3, 116228 },	-- Spaulders of Tempered Fury
				{ 4, 116214 },	-- Raging Pyroclasm Leggings
				{ 5, 116037 },	-- Chest of Heaving Bellows
				{ 6, 116041 },	-- Grips of the Ruptured Furnace
				{ 7, 116241 },	-- Gauntlets of Electrocution
				{ 16, 116303 },	-- Firecaller's Scorched Seal
				{ 17, 116315 },	-- Heart of the Fury [Needs Name Change]
				{ 19, 116382 },	-- Spire of Pyroclastic Flame
				{ 20, 116379 },	-- Flickering Lantern Wisp
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113887 },	-- Bracers of Spattered Steel
				{ 2, 113895 },	-- Furnace Tender's Treads
				{ 3, 113891 },	-- Blast-Proof Cowl
				{ 4, 113888 },	-- Slagstomper Treads
				{ 5, 113894 },	-- Lava-Dipped Greathelm
				{ 6, 113896 },	-- Fleshmelter Bracers
				{ 8, 113892 },	-- Engineer's Grounded Gorget
				{ 9, 113890 },	-- Feldspar's Control Choker
				{ 10, 113893 },	-- Blast Furnace Door
				{ 11, 113889 },	-- Elementalist's Shielding Talisman
				{ 16, 119307, false },	-- Leggings of the Iron Conqueror
				{ 17, 119320, false },	-- Leggings of the Iron Protector
				{ 18, 119313, false },	-- Leggings of the Iron Vanquisher
				{ 20, 113886 },	-- Crescent of Living Magma
				{ 21, 113885 },	-- Mouth of The Fury
				{ 23, "ac8930" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 24, "ac8970" },
			},
		},
		{	--BFKromog
			EncounterJournalID = 1162,
			[RF_DIFF] = {
				{ 1, 116008 },	-- Robes of Living Earth
				{ 2, 116006 },	-- Thundersmash Gloves
				{ 3, 116218 },	-- Chestguard of Allegorical Shadows
				{ 4, 116222 },	-- Slam Jammers
				{ 5, 116035 },	-- Rockbreaker Warcap
				{ 6, 116044 },	-- Erupting Mantle
				{ 7, 116243 },	-- Chestplate of Runed Earth
				{ 8, 116254 },	-- Reverberating Bracers
				{ 16, 116300 },	-- Ring of Shattered Faults
				{ 17, 116318 },	-- Stoneheart Idol
				{ 19, 116387 },	-- Axe of the Stone Geyser
				{ 20, 116386 },	-- Earthbound Shield
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113929 },	-- Cloak of Delving Secrets
				{ 2, 113937 },	-- Runefrenzy Greatcloak
				{ 3, 113928 },	-- Earthripple Shoulderpads
				{ 4, 113933 },	-- Stonewarper Wraps
				{ 5, 113935 },	-- Bracers of Shattered Stalactites
				{ 6, 113930 },	-- Earthgrasp Girdle
				{ 7, 113936 },	-- Sabatons of Fractal Earth
				{ 9, 113932 },	-- Talisman of the Fomor
				{ 10, 113938 },	-- Stonefist Band
				{ 11, 113931 },	-- Beating Heart of the Mountain
				{ 16, 119308, false },	-- Helm of the Iron Conqueror
				{ 17, 119321, false },	-- Helm of the Iron Protector
				{ 18, 119312, false },	-- Helm of the Iron Vanquisher
				{ 20, 113934 },	-- Fang of the Earth
				{ 21, 113927 },	-- Kromog's Brutal Fist
				{ 22, 113926 },	-- Kromog's Protecting Palm
				{ 24, "ac8983" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, "ac8971" },
			},
		},
		{	--BFIronMaidens
			EncounterJournalID = 1203,
			[RF_DIFF] = {
				{ 1, 116017 },	-- Deckhand's Cord
				{ 2, 116010 },	-- Incendiary Leggings
				{ 3, 116220 },	-- Grapeshot Hood
				{ 4, 116225 },	-- Gauntlets of Flickering Blades
				{ 5, 116050 },	-- Bombardeer's Targeting Helm
				{ 6, 116051 },	-- Rogg's Earthen Legguards
				{ 7, 116263 },	-- Vortex Plate Helm
				{ 8, 116250 },	-- Impaler's Greatboots
				{ 16, 116312 },	-- Sorka's Ear Collection
				{ 17, 116314 },	-- Blackheart Enforcer's Medallion
				{ 19, 116390 },	-- Battle Medic's Wand
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113972 },	-- Cloak of Sanguine Terror
				{ 2, 113971 },	-- Drape of the Dark Hunt
				{ 3, 113967 },	-- Deckhand's Rope Belt
				{ 4, 113970 },	-- Turret Mechanic's Legwraps
				{ 5, 113978 },	-- Sorka's Nightshade Cowl
				{ 6, 113974 },	-- Treads of the Dark Hunt
				{ 7, 113968 },	-- Bloodwhirl Bracers
				{ 8, 113977 },	-- Bloodsoaked Heart Protector
				{ 9, 113976 },	-- Uktar's Belt of Chiming Rings
				{ 11, 113975 },	-- Uk'urogg's Corrupted Seal
				{ 12, 113969 },	-- Vial of Convulsive Shadows
				{ 16, 119306, false },	-- Gauntlets of the Iron Conqueror
				{ 17, 119319, false },	-- Gauntlets of the Iron Protector
				{ 18, 119311, false },	-- Gauntlets of the Iron Vanquisher
				{ 20, 113966 },	-- Gar'an's Brutal Spearlauncher
				{ 21, 113973 },	-- Koloch Na, the Blood Feast
				{ 22, 113965 },	-- Sorka's Chainfist
				{ 24, "ac8984" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, "ac8972" },
			},
		},
		{	--BFBlackhand
			EncounterJournalID = 959,
			[RF_DIFF] = {
				{ 1, 116005 },	-- Forgestoker's Shoulderpads
				{ 2, 116022 },	-- Flamestoker Wraps
				{ 3, 116219 },	-- Spaulders of Erupting Iron
				{ 4, 116224 },	-- Bomb-Carrier's Harness
				{ 5, 116036 },	-- Deathmark Shoulderguards
				{ 6, 116042 },	-- Ram-Carrier's Treads
				{ 7, 116244 },	-- Spaulders of the Iron Crucible
				{ 8, 116251 },	-- Ironshatter Legplates
				{ 16, 116309 },	-- Spiked Foundry Collar
				{ 17, 116317 },	-- Storage House Key
				{ 19, 116391 },	-- Blackhand Forgehammer
				{ 20, 116393 },	-- Dagger of the Shattered Crucible
				{ 22, "ac8992" },
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113981 },	-- Slagbomber's Hood
				{ 2, 113989 },	-- Shattering Smash Leggings
				{ 3, 113982 },	-- Chestguard of the Siegemaker
				{ 4, 113990 },	-- Overdriven Spaulders
				{ 6, 113986 },	-- Auto-Repairing Autoclave
				{ 7, 113987 },	-- Battering Talisman
				{ 8, 113984 },	-- Blackiron Micro Crucible
				{ 9, 113983 },	-- Forgemaster's Insignia
				{ 10, 113985 },	-- Humming Blackiron Trigger
				{ 16, 119310, false },	-- Essence of the Iron Conqueror
				{ 17, 119323, false },	-- Essence of the Iron Protector
				{ 18, 119316, false },	-- Essence of the Iron Vanquisher
				{ 20, 113988 },	-- Blackhand Doomstaff
				{ 21, 113980 },	-- Iron Soldier's Saber
				{ 22, 113979 },	-- The Black Hand
				{ 24, "ac8952" },
				{ 25, "ac8992" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 12, "116660:0", "mount" },	-- Ironhoof Destroyer
				{ 26, "ac8973" },
			},
		},
		{	--BFTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_RAID_DIFF] = {
				{ 1, 119332 },	-- Bracers of Darkened Skies
				{ 2, 119342 },	-- Furnace Stoker's Footwraps
				{ 3, 119333 },	-- Bracers of Shattered Limbs
				{ 4, 119340 },	-- Iron-Flecked Sandals
				{ 5, 119334 },	-- Bracers of Callous Disregard
				{ 6, 119339 },	-- Treads of the Veteran Smith
				{ 7, 119331 },	-- Bracers of Visceral Force
				{ 8, 119341 },	-- Doomslag Greatboots
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		{	--Tier 17 Sets
			name = format(AL["Tier %d Sets"], 17),
			ExtraList = true,
			[RF_DIFF] = "AtlasLoot_Collections:TIERSETS:1:rf",
			[NORMAL_RAID_DIFF] = "AtlasLoot_Collections:TIERSETS:1:n",
			[HEROIC_PRE_DIFF] = "AtlasLoot_Collections:TIERSETS:1:h",
			[MYTHIC_PRE_DIFF] = "AtlasLoot_Collections:TIERSETS:1:m",
		},
		WOD_RAID1_AC_TABLE,
	},
}

data["Draenor"] = {
	EncounterJournalID = 557,
	MapID = 949,
	ContentType = RAID_CONTENT,
	items = {
		{	--DrovtheRuiner
			EncounterJournalID = 1291,
			[NORMAL_RAID_DIFF] = {
				{ 1, 115425 },	-- Quadripedal Grips
				{ 2, 115429 },	-- Belt of Singing Hooves
				{ 3, 115426 },	-- Grips of Natural Fury
				{ 4, 115430 },	-- Cord of Ruination
				{ 5, 115427 },	-- Chainhoof Grips
				{ 6, 115431 },	-- Chain of Natural Fury
				{ 7, 115428 },	-- Gauntlets of Impenetrability
				{ 8, 115432 },	-- Waistplate of Bladed Force
				{ 16, 120086 },	-- Bone Charm Chain
				{ 17, 120084 },	-- Braided Magnaron Plait
				{ 18, 120087 },	-- Drov's Durable Gorget
				{ 19, 120083 },	-- Earthcaller's Charm
				{ 20, 120085 },	-- Loop of Beaded Mane
				{ 22, "ac9423" },
			},
		},
		{	--Rukhmar
			EncounterJournalID = 1262,
			[NORMAL_RAID_DIFF] = {
				{ 1, 115433 },	-- Solarflame Legwraps
				{ 2, 120111 },	-- Featherflame Sandals
				{ 3, 115434 },	-- Down-Lined Leggings
				{ 4, 120112 },	-- Phoenix-Rider Boots
				{ 5, 115435 },	-- Leggings of Flowing Feathers
				{ 6, 120113 },	-- Talongrip Spurs
				{ 7, 115436 },	-- Phoenixfire Legplates
				{ 8, 120114 },	-- Wing-Forged Greatboots
				{ 16, 115440 },	-- Burning Beak Band
				{ 17, 115441 },	-- Callie's Charred Seal
				{ 18, 115437 },	-- Fire Eye Ring
				{ 19, 115439 },	-- Firemender Seal
				{ 20, 115438 },	-- Signet of Burning Truths
				{ 22, 116771, "mount" },	-- Solar Spirehawk
				{ 24, "ac9425" },
			},
		},
		{	--TarlnatheAgeless
			EncounterJournalID = 1211,
			[NORMAL_RAID_DIFF] = {
				{ 1, 120091 },	-- Robes of the Ageless
				{ 2, 115425 },	-- Quadripedal Grips
				{ 3, 115429 },	-- Belt of Singing Hooves
				{ 4, 120088 },	-- Witherleaf Chestguard
				{ 5, 115426 },	-- Grips of Natural Fury
				{ 6, 115430 },	-- Cord of Ruination
				{ 7, 120089 },	-- Chestguard of Rejuvenation
				{ 8, 115427 },	-- Chainhoof Grips
				{ 9, 115431 },	-- Chain of Natural Fury
				{ 10, 120090 },	-- Falling Leaf Breastplate
				{ 11, 115428 },	-- Gauntlets of Impenetrability
				{ 12, 115432 },	-- Waistplate of Bladed Force
				{ 16, "ac9423" },
			},
		},
	}
}

data["Highmaul"] = {
	EncounterJournalID = 477,
	MapID = 994,
	ContentType = RAID_CONTENT,
	TableType = RAID_ITTYPE,
	items = {
		{	--HighmaulBladefist
			EncounterJournalID = 1128,
			[RF_DIFF] = {
				{ 1, 116298 },	-- Flamescarred Drape
				{ 2, 116003 },	-- Spectator's Sandals of Carnage
				{ 3, 116205 },	-- Firewalker's Treads
				{ 4, 116030 },	-- Bracer of Amputation
				{ 5, 116236 },	-- Iron Bomb Spaulders
				{ 16, 116282 },	-- Grunt's Rusty Ring
				{ 17, 116289 },	-- Bloodmaw's Tooth
				{ 19, 116360 },	-- Blade Dancer's Claws
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113605 },	-- Fireproof Greatcloak
				{ 2, 113596 },	-- Vilebreath Mask
				{ 3, 113601 },	-- Chestguard of the Roaring Crowd
				{ 4, 113602 },	-- Throat-Ripper Gauntlets
				{ 5, 113593 },	-- Grips of Vicious Mauling
				{ 6, 113595 },	-- Treads of Sand and Blood
				{ 7, 113600 },	-- Casque of the Iron Bomber
				{ 16, 113598 },	-- Champion's Medallion
				{ 17, 113599 },	-- Grunt's Solid Signet
				{ 18, 113604 },	-- Kargath's Last Link
				{ 20, 113591 },	-- The Bladefist
				{ 21, 113592 },	-- Bileslinger's Censer
				{ 23, "ac8948" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 24, "ac8949" },
			},
		},
		{	--HighmaulButcher
			EncounterJournalID = 971,
			[RF_DIFF] = {
				{ 1, 116297 },	-- Fleshhook Cloak
				{ 2, 115998 },	-- Sterilized Handwraps
				{ 3, 116209 },	-- Spine-Ripper Bracers
				{ 4, 116026 },	-- Bonebreaker Boots
				{ 5, 116230 },	-- Ogre-Eater Treads
				{ 16, 116281 },	-- Bloodstone Seal
				{ 17, 116290 },	-- Emblem of Gushing Wounds
				{ 19, 116361 },	-- Butcher's Cruel Chopper
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113637 },	-- Cloak of Frenzied Rage
				{ 2, 113609 },	-- Slaughterhouse Spaulders
				{ 3, 113610 },	-- Meatmonger's Gory Grips
				{ 4, 113634 },	-- Bracers of Spare Skin
				{ 5, 113636 },	-- Belt of Bloody Guts
				{ 6, 113608 },	-- Hood of Dispassionate Execution
				{ 7, 113632 },	-- Gauntlets of the Heavy Hand
				{ 8, 113633 },	-- Entrail Squishers
				{ 16, 113611 },	-- Flenser's Hookring
				{ 17, 113638 },	-- Gutwrench Ring
				{ 18, 113612 },	-- Scales of Doom
				{ 20, 113606 },	-- Butcher's Bloody Cleaver
				{ 21, 113607 },	-- Butcher's Terrible Tenderizer
				{ 23, "ac8947" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 24, "ac8960" },
			},
		},
		{	--HighmaulTectus
			EncounterJournalID = 1195,
			[RF_DIFF] = {
				{ 1, 116000 },	-- Mountainslide Robes
				{ 2, 116210 },	-- Chestwrap of Violent Upheaval
				{ 3, 116032 },	-- Legguards of Ravenous Assault
				{ 4, 116237 },	-- Crown of the Crags
				{ 16, 116285 },	-- Cratermaker Choker
				{ 17, 116279 },	-- Frostcap Band
				{ 18, 116292 },	-- Mote of the Mountain
				{ 20, 116362 },	-- Shard of Crystalline Fury
				{ 21, 116363 },	-- Shield of Violent Upheaval
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113642 },	-- Crystal-Woven Bracers
				{ 2, 113649 },	-- Mountainwalker's Boots
				{ 3, 113641 },	-- Living Mountain Shoulderguards
				{ 4, 113648 },	-- Legplates of Fractured Crystal
				{ 6, 113647 },	-- Flechette-Riddled Chain
				{ 7, 113644 },	-- Earthfury Band
				{ 8, 113643 },	-- Eye of Tectus
				{ 9, 113646 },	-- Ring of Infinite Accretion
				{ 10, 113651 },	-- Signet of Crystalline Barrage
				{ 11, 113650 },	-- Pillar of the Earth
				{ 12, 113645 },	-- Tectus' Beating Heart
				{ 16, 113640 },	-- Earthwarped Bladestaff
				{ 17, 113639 },	-- Spire of Tectus
				{ 19, "ac8974" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 20, "ac8961" },
			},
		},
		{	--HighmaulBrackenspore
			EncounterJournalID = 1196,
			[RF_DIFF] = {
				{ 1, 116294 },	-- Rotmelter Mosscloak
				{ 2, 115999 },	-- Rotmonger Bracers
				{ 3, 116208 },	-- Carnage Breath Gauntlets
				{ 4, 116028 },	-- Shoulderguards of Perpetually Exploding Fungus
				{ 5, 116233 },	-- Grips of Burning Infusion
				{ 16, 116288 },	-- Tide-Caller's Gorget
				{ 17, 116291 },	-- Immaculate Living Mushroom
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113657 },	-- Cloak of Creeping Necrosis
				{ 2, 113655 },	-- Robes of Necrotic Whispers
				{ 3, 113656 },	-- Girdle of the Infected Mind
				{ 4, 113661 },	-- Deep Walker Paulders
				{ 5, 113664 },	-- Sandals of Mycoid Musing
				{ 6, 113654 },	-- Moss-Woven Mailshirt
				{ 7, 113659 },	-- Fleshchewer Greatbelt
				{ 8, 113660 },	-- Mosscrusher Sabatons
				{ 16, 113662 },	-- Collar of Wailing Mouths
				{ 17, 113658 },	-- Bottle of Infesting Spores
				{ 18, 113663 },	-- Petrified Flesh-Eating Spore
				{ 20, 113652 },	-- Crystalline Branch of the Brackenspore
				{ 21, 113653 },	-- Maw of Souls
				{ 23, "ac8975" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 24, "ac8962" },
			},
		},
		{	--HighmaulTwinOgron
			EncounterJournalID = 1148,
			[RF_DIFF] = {
				{ 1, 115997 },	-- Twin-Gaze Spaulders
				{ 2, 116211 },	-- Shoulderguards of the Shepherd
				{ 3, 116025 },	-- Pulverizing Grips
				{ 4, 116234 },	-- Bracers of Cursed Cries
				{ 16, 116286 },	-- Fire-Blind Necklace
				{ 17, 116283 },	-- Ring of Enfeebling Accusations
				{ 19, 116364 },	-- Dagger of Enfeeblement
				{ 20, 116365 },	-- Captured Arcane Fragment
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113830 },	-- Cloak of Ruminant Deception
				{ 2, 113828 },	-- Sea-Cursed Leggings
				{ 3, 113832 },	-- Treacherous Palms
				{ 4, 113826 },	-- Bracers of the Crying Chorus
				{ 5, 113827 },	-- Belt of Imminent Lies
				{ 6, 113831 },	-- Chestplate of Arcane Volatility
				{ 16, 113833 },	-- Odyssian Choker
				{ 17, 113829 },	-- Golden-Tongued Seal
				{ 18, 113834 },	-- Pol's Blinded Eye
				{ 19, 113835 },	-- Shards of Nothing
				{ 21, 113667 },	-- Phemos' Double Slasher
				{ 22, 113666 },	-- Absalom's Bloody Bulwark
				{ 24, "ac8958" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 25, "ac8963" },
			},
		},
		{	--HighmaulKoragh
			EncounterJournalID = 1153,
			[RF_DIFF] = {
				{ 1, 116295 },	-- Cloak of Overflowing Energies
				{ 2, 115996 },	-- Fel-Flame Coronet
				{ 3, 116212 },	-- Alloy-Inlaid Cap
				{ 4, 116029 },	-- Crackle-Proof Chestguard
				{ 5, 116231 },	-- Legplates of Arcanic Absorbtion
				{ 16, 116284 },	-- Necklace of Volatile Anomalies
				{ 17, 116293 },	-- Idol of Suppression
				{ 19, 116367 },	-- Shield-Shatter Longbow
				{ 20, 116368 },	-- Polearm of Expulsion
				{ 21, 116366 },	-- Magic-Breaker Greatsword
				{ 23, 115288, false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Felbreaker's Tome
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113847 },	-- Cloak of Searing Shadows
				{ 2, 113840 },	-- Destablized Sandals
				{ 3, 113845 },	-- Rune-Enscribed Hood
				{ 4, 113839 },	-- Leggings of Broken Magic
				{ 5, 113844 },	-- Bracers of Mirrored Flame
				{ 7, 113841 },	-- Ko'ragh's Family Locket
				{ 8, 113846 },	-- Seal of Unbound Frost
				{ 9, 113843 },	-- Spell-Sink Signet
				{ 10, 113842 },	-- Emblem of Caustic Healing
				{ 16, 113838 },	-- Gar'tash, Hammer of the Breakers
				{ 17, 113836 },	-- Ko'ragh's Boot Knife
				{ 18, 113837 },	-- Rod of Fel Nullification
				{ 20, "115288:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Felbreaker's Tome
				{ 22, "ac8976" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 23, "ac8964" },
			},
		},
		{	--HighmaulMargok
			EncounterJournalID = 1197,
			[RF_DIFF] = {
				{ 1, 116296 },	-- Greatcloak of Impactful Pulses
				{ 2, 116002 },	-- High Arcanist Leggings
				{ 3, 116206 },	-- Warmage's Legwraps
				{ 4, 116027 },	-- Gorian Royal Crown
				{ 5, 116235 },	-- Chestplate of Destructive Resonance
				{ 16, 116287 },	-- Chain of the Unbroken Lineage
				{ 17, 116280 },	-- Seal of Arcane Wrath
				{ 19, 116372 },	-- Imperator's Warstaff
				{ 20, 116373 },	-- Mirrorshield of Arcane Fortification
				{ 22, 115289, false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sigil of the Sorcerer King
				{ 24, "ac8988" },
			},
			[NORMAL_RAID_DIFF] = {
				{ 1, 113852 },	-- Force Nova Cloak
				{ 2, 113850 },	-- Robes of the Arcane Ultimatum
				{ 3, 113856 },	-- Nether Blast Leggings
				{ 4, 113849 },	-- Face Kickers
				{ 5, 113855 },	-- Uncrushable Shoulderplates
				{ 7, "115289:0", false, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sigil of the Sorcerer King
				{ 16, 113858 },	-- Choker of Violent Displacement
				{ 17, 113851 },	-- Reaver's Nose Ring
				{ 18, 113860 },	-- Shockwave Signet
				{ 19, 113853 },	-- Captive Micro-Aberration
				{ 20, 113861 },	-- Evergaze Arcane Eidolon
				{ 21, 113854 },	-- Mark of Rapid Replication
				{ 22, 113859 },	-- Quiescent Runestone
				{ 24, 113848 },	-- Gor'gah, High Blade of the Gorians
				{ 25, 113857 },	-- Staff of the Grand Imperator
				{ 27, "ac8988" },
				{ 28, "ac8977" },
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = {
				GetItemsFromDiff = NORMAL_RAID_DIFF,
				{ 29, "ac8965" },
			},
		},
		{	--HighmaulTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_RAID_DIFF] = {
				{ 1, 119343 },	-- Eye-Blinder Greatcloak
				{ 2, 119347 },	-- Gill's Glorious Windcloak
				{ 3, 119346 },	-- Kyu-Sy's Tarflame Doomcloak
				{ 4, 119344 },	-- Magic-Breaker Cape
				{ 5, 119345 },	-- Milenah's Intricate Cloak
				{ 16, 119336 },	-- Cord of Winsome Sorrows
				{ 17, 119335 },	-- Eyeripper Girdle
				{ 18, 119338 },	-- Belt of Inebriated Sorrows
				{ 19, 119337 },	-- Ripswallow Plate Belt
			},
			[HEROIC_PRE_DIFF] = NORMAL_RAID_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_RAID_DIFF,
		},
		WOD_RAID1_AC_TABLE,
	},
}