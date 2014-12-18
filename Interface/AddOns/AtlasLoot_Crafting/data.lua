local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local WOD_DIFF = data:AddDifficulty(AL["Warlords of Draenor"])
local MOP_DIFF = data:AddDifficulty(AL["Mists of Pandaria"])
local CATA_DIFF = data:AddDifficulty(AL["Cataclysm"])
local WOTLK_DIFF = data:AddDifficulty(AL["Wrath of the Lich King"])
local BC_DIFF = data:AddDifficulty(AL["Burning Crusade"])
local CLASSIC_DIFF = data:AddDifficulty(AL["Classic"])
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"])

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local CRAFTING_ITTYPE = data:AddItemTableType("Item", "Profession")
local CRAFTING2_ITTYPE = data:AddItemTableType("Profession", "Item")

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local CRAFTING_CONTENT = data:AddContentType(AL["Crafting"], ATLASLOOT_CRAFTING_COLOR)

data["Alchemy"] = {
	name = GetSpellInfo(2259),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--AlchemyElixirsPotions
			name = AL["Elixirs"].." & "..AL["Potions"],
			[WOD_DIFF] = {
				{ 1, 109222, 156582 },	-- Draenic Mana Potion (Learnt by item 109558)
				{ 2, 116268, 175865 },	-- Draenic Invisibility Potion (Learnt by item 109558)
				{ 3, 116276, 175867 },	-- Draenic Living Action Potion (Learnt by item 109558)
				{ 4, 109226, 156584, [PRICE_EXTRA_ITTYPE] = "118700:1" },	-- Draenic Rejuvenation Potion (Sold, Ashran)
				{ 5, 116266, 175853 },	-- Draenic Swiftness Potion (Learnt by item 109558)
				{ 6, 116271, 175866 },	-- Draenic Water Breathing Elixir (Learnt by item 109558)
				{ 7, 118711, 175869 },	-- Draenic Water Walking Elixir (Learnt by item 109558)
				{ 8, 118704, 175868 },	-- Pure Rage Potion (Learnt by item 109558)
				{ 9, 112090, 162403, [PRICE_EXTRA_ITTYPE] = "118700:1" },	-- Transmorphic Tincture (Sold, Ashran)
				{ 16, 109217, 156577, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Draenic Agility Potion (Sold, Ashran)
				{ 17, 109220, 156580, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Draenic Armor Potion (Sold, Ashran)
				{ 18, 109221, 156581, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Draenic Channeled Mana Potion (Sold, Ashran)
				{ 19, 109218, 156578, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Draenic Intellect Potion (Sold, Ashran)
				{ 20, 109219, 156579, [PRICE_EXTRA_ITTYPE] = "money:90000" },	-- Draenic Strength Potion (Sold, Ashran)
			},
		},
		{	--AlchemyFlask
			name = AL["Flasks"],
			[WOD_DIFF] = {
				{ 1, 109153, 156569, [PRICE_EXTRA_ITTYPE] = "118700:5" },	-- Greater Draenic Agility Flask (Sold, Ashran)
				{ 2, 109155, 156571, [PRICE_EXTRA_ITTYPE] = "118700:5" },	-- Greater Draenic Intellect Flask (Sold, Ashran)
				{ 3, 109160, 156576, [PRICE_EXTRA_ITTYPE] = "118700:5" },	-- Greater Draenic Stamina Flask (Sold, Ashran)
				{ 4, 109156, 156572, [PRICE_EXTRA_ITTYPE] = "118700:5" },	-- Greater Draenic Strength Flask (Sold, Ashran)
				{ 6, 109145, 156561, [PRICE_EXTRA_ITTYPE] = "118700:1" },	-- Draenic Agility Flask (Sold, Ashran)
				{ 7, 109147, 156563, [PRICE_EXTRA_ITTYPE] = "118700:1" },	-- Draenic Intellect Flask (Sold, Ashran)
				{ 8, 109152, 156568, [PRICE_EXTRA_ITTYPE] = "118700:1" },	-- Draenic Stamina Flask (Sold, Ashran)
				{ 9, 109148, 156564, [PRICE_EXTRA_ITTYPE] = "118700:1" },	-- Draenic Strength Flask (Sold, Ashran)
			},
		},
		{	--AlchemyMisc
			name = AL["Miscellaneous"],
			[WOD_DIFF] = {
				{ 1, 109262, 156560, [PRICE_EXTRA_ITTYPE] = "118700:1" },	-- Draenic Philosopher's Stone (Sold, Ashran)
				{ 3, 108996, 156587 },	-- Alchemical Catalyst (Learnt by item 109558)
				{ 5, 109123, 156585 },	-- Crescent Oil (Learnt by item 109558)
				{ 7, 118700, 175880 },	-- Secrets of Draenor Alchemy (Learnt by item 109558)
			},
		},
	}
}

data["Blackshmithing"] = {
	name = GetSpellInfo(2018),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--SmithingArmor
			name = AL["Armor"],
			[WOD_DIFF] = {
				{ 1, "114230:Stage3", 171709 },	-- Truesteel Helm (Stage 3)
				{ 2, "114231:Stage3", 171709 },	-- Truesteel Pauldrons (Stage 3)
				{ 3, "114232:Stage3", 171709 },	-- Truesteel Breastplate (Stage 3)
				{ 4, "114236:Stage3", 171709 },	-- Truesteel Armguards (Stage 3)
				{ 5, "114237:Stage3", 171709 },	-- Truesteel Gauntlets (Stage 3)
				{ 6, "114233:Stage3", 171709 },	-- Truesteel Waistguard (Stage 3)
				{ 7, "114234:Stage3", 171709 },	-- Truesteel Greaves (Stage 3)
				{ 8, "114235:Stage3", 171709 },	-- Truesteel Boots (Stage 3)
				{ 9, "114230:Stage2", 171708 },	-- Truesteel Helm (Stage 2)
				{ 10, "114231:Stage2", 171708 },	-- Truesteel Pauldrons (Stage 2)
				{ 11, "114232:Stage2", 171708 },	-- Truesteel Breastplate (Stage 2)
				{ 12, "114236:Stage2", 171708 },	-- Truesteel Armguards (Stage 2)
				{ 13, "114237:Stage2", 171708 },	-- Truesteel Gauntlets (Stage 2)
				{ 14, "114233:Stage2", 171708 },	-- Truesteel Waistguard (Stage 2)
				{ 15, "114234:Stage2", 171708 },	-- Truesteel Greaves (Stage 2)
				{ 16, "114235:Stage2", 171708 },	-- Truesteel Boots (Stage 2)
				{ 17, "114230:Stage1", 171701, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Helm (Stage 1) (Sold, Ashran)
				{ 18, "114231:Stage1", 171700, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Pauldrons (Stage 1) (Sold, Ashran)
				{ 19, "114232:Stage1", 171704, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Breastplate (Stage 1) (Sold, Ashran)
				{ 20, "114236:Stage1", 171705, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Armguards (Stage 1) (Sold, Ashran)
				{ 21, "114237:Stage1", 171703, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Gauntlets (Stage 1) (Sold, Ashran)
				{ 22, "114233:Stage1", 171707, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Waistguard (Stage 1) (Sold, Ashran)
				{ 23, "114234:Stage1", 171702, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Greaves (Stage 1) (Sold, Ashran)
				{ 24, "114235:Stage1", 171706, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Boots (Stage 1) (Sold, Ashran)
				{ 25, 116426, 171691 },	-- Smoldering Helm (Learnt by item 115356)
				{ 26, 116427, 171692 },	-- Smoldering Breastplate (Learnt by item 115356)
				{ 27, 116425, 171693 },	-- Smoldering Greaves (Learnt by item 115356)
			},
		},
		{	--SmithingWeaponsShields
			name = AL["Weapons"].." & "..AL["Shields"],
			[WOD_DIFF] = {
				{ 1, "120259:Stage3W", 171711 },	-- Steelforged Axe (Stage 3)
				{ 2, "116644:Stage3W", 171711 },	-- Steelforged Dagger (Stage 3)
				{ 3, "116646:Stage3W", 171711 },	-- Steelforged Hammer (Stage 3)
				{ 4, "116454:Stage3W", 171711 },	-- Steelforged Saber (Stage 3)
				{ 5, "116453:Stage3W", 171711 },	-- Steelforged Greataxe (Stage 3)
				{ 6, "120261:Stage3W", 171711 },	-- Steelforged Aegis (Stage 3)
				{ 7, "116647:Stage3W", 171711 },	-- Steelforged Shield (Stage 3)
				{ 8, "120259:Stage2W", 171710 },	-- Steelforged Axe (Stage 2)
				{ 9, "116644:Stage2W", 171710 },	-- Steelforged Dagger (Stage 2)
				{ 10, "116646:Stage2W", 171710 },	-- Steelforged Hammer (Stage 2)
				{ 11, "116454:Stage2W", 171710 },	-- Steelforged Saber (Stage 2)
				{ 12, "116453:Stage2W", 171710 },	-- Steelforged Greataxe (Stage 2)
				{ 13, "120261:Stage2W", 171710 },	-- Steelforged Aegis (Stage 2)
				{ 14, "116647:Stage2W", 171710 },	-- Steelforged Shield (Stage 2)
				{ 15, "120259:Stage1", 178243, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Steelforged Axe (Stage 1) (Sold, Ashran)
				{ 16, "116644:Stage1", 171696, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Steelforged Dagger (Stage 1) (Sold, Ashran)
				{ 17, "116646:Stage1", 171697, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Steelforged Hammer (Stage 1) (Sold, Ashran)
				{ 18, "116454:Stage1", 171695, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Steelforged Saber (Stage 1) (Sold, Ashran)
				{ 19, "116453:Stage1", 171694, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Steelforged Greataxe (Stage 1) (Sold, Ashran)
				{ 20, "120261:Stage1", 178245, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Steelforged Aegis (Stage 1) (Sold, Ashran)
				{ 21, "116647:Stage1", 171698, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Steelforged Shield (Stage 1) (Sold, Ashran)
			},
		},
		{	--SmithingMisc
			name = AL["Miscellaneous"],
			[WOD_DIFF] = {
				{ 1, 119328, 177169, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Soul of the Forge (Sold, Ashran)
				{ 3, 108257, 171690 },	-- Truesteel Ingot (Learnt by item 115356)
				{ 5, 118720, 176090 },	-- Secrets of Draenor Blacksmithing (Learnt by item 115356)
				{ 16, 116652, 171710, [PRICE_EXTRA_ITTYPE] = "118720:5" },	-- Steelforged Essence (Sold, Ashran)
				{ 17, 116653, 171711, [PRICE_EXTRA_ITTYPE] = "118720:5" },	-- Greater Steelforged Essence (Sold, Ashran)
				{ 19, 116649, 171708, [PRICE_EXTRA_ITTYPE] = "118720:5" },	-- Truesteel Essence (Sold, Ashran)
				{ 20, 116650, 171709, [PRICE_EXTRA_ITTYPE] = "118720:5" },	-- Greater Truesteel Essence (Sold, Ashran)
				{ 22, 116654, 171699, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Grinder (Sold, Ashran)
				{ 24, 116428, 173355, [PRICE_EXTRA_ITTYPE] = "118720:1" },	-- Truesteel Reshaper (Sold, Ashran)
			},
		},
	}
}

data["Enchanting"] = {
	name = GetSpellInfo(7411),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--EnchantingBoots
			name = AL["Boots"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Agility", nil },
				{ 2, "prof104409" },	-- Enchant Boots - Blurred Speed
				{ 3, "prof74213" },	-- Enchant Boots - Major Agility
				{ 4, "prof74252" },	-- Enchant Boots - Assassin's Step
				{ 5, "prof44589" },	-- Enchant Boots - Superior Agility
				{ 6, "prof27951" },	-- Enchant Boots - Dexterity
				{ 7, "prof20023" },	-- Enchant Boots - Greater Agility
				{ 8, "prof34007" },	-- Enchant Boots - Cat's Swiftness
				{ 9, "prof13935" },	-- Enchant Boots - Agility
				{ 10, "prof13637" },	-- Enchant Boots - Lesser Agility
				{ 11, "prof7867" },	-- Enchant Boots - Minor Agility
				{ 13, "INV_Box_01", nil, "Attack Power", nil },
				{ 14, "prof60763" },	-- Enchant Boots - Greater Assault
				{ 15, "prof60606" },	-- Enchant Boots - Assault
				{ 16, "INV_Box_01", nil, "Stamina", nil },
				{ 17, "prof74189" },	-- Enchant Boots - Earthen Vitality
				{ 18, "prof44528" },	-- Enchant Boots - Greater Fortitude
				{ 19, "prof47901" },	-- Enchant Boots - Tuskarr's Vitality
				{ 20, "prof27950" },	-- Enchant Boots - Fortitude
				{ 21, "prof34008" },	-- Enchant Boots - Boar's Speed
				{ 22, "prof20020" },	-- Enchant Boots - Greater Stamina
				{ 23, "prof13836" },	-- Enchant Boots - Stamina
				{ 24, "prof13644" },	-- Enchant Boots - Lesser Stamina
				{ 25, "prof7863" },	-- Enchant Boots - Minor Stamina
				{ 27, "INV_Box_01", nil, "Spirit", nil },
				{ 28, "prof44508" },	-- Enchant Boots - Greater Spirit
				{ 29, "prof20024" },	-- Enchant Boots - Spirit
				{ 30, "prof13687" },	-- Enchant Boots - Lesser Spirit
				{ 101, "INV_Box_01", nil, "Ratings", nil },
				{ 102, "prof104414" },	-- Enchant Boots - Pandaren's Step
				{ 103, "prof104407" },	-- Enchant Boots - Greater Haste
				{ 104, "prof104408" },	-- Enchant Boots - Greater Precision
				{ 105, "prof74253" },	-- Enchant Boots - Lavawalker
				{ 106, "prof74238" },	-- Enchant Boots - Mastery
				{ 107, "prof74236" },	-- Enchant Boots - Precision
				{ 108, "prof74199" },	-- Enchant Boots - Haste
				{ 109, "prof60623" },	-- Enchant Boots - Icewalker
				{ 110, "prof27954" },	-- Enchant Boots - Surefooted
				{ 111, "prof63746" },	-- Enchant Boots - Lesser Accuracy
				{ 113, "INV_Box_01", nil, "Other", nil },
				{ 114, "prof44584" },	-- Enchant Boots - Greater Vitality
				{ 115, "prof27948" },	-- Enchant Boots - Vitality
				{ 116, "INV_Box_01", nil, "Speed", nil },
				{ 117, "prof104414" },	-- Enchant Boots - Pandaren's Step
				{ 118, "prof104409" },	-- Enchant Boots - Blurred Speed
				{ 119, "prof74252" },	-- Enchant Boots - Assassin's Step
				{ 120, "prof74253" },	-- Enchant Boots - Lavawalker
				{ 121, "prof34008" },	-- Enchant Boots - Boar's Speed
				{ 122, "prof34007" },	-- Enchant Boots - Cat's Swiftness
				{ 123, "prof74189" },	-- Enchant Boots - Earthen Vitality
				{ 124, "prof47901" },	-- Enchant Boots - Tuskarr's Vitality
				{ 125, "prof13890" },	-- Enchant Boots - Minor Speed
			},
			[MOP_DIFF] = {
				{ 1, "INV_Box_01", nil, "Agility / Run Speed", nil },
				{ 2, 74717, 104409 },	-- Enchant Boots - Blurred Speed
			},
		},
		{	--EnchantingBracer
			name = AL["Bracers"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Strength", nil },
				{ 2, "prof104390" },	-- Enchant Bracer - Exceptional Strength
				{ 3, "prof96261" },	-- Enchant Bracers - Major Strength
				{ 4, "prof27899" },	-- Enchant Bracers - Brawn
				{ 5, "prof20010" },	-- Enchant Bracers - Superior Strength
				{ 6, "prof13939" },	-- Enchant Bracers - Greater Strength
				{ 7, "prof13661" },	-- Enchant Bracers - Strength
				{ 8, "prof13536" },	-- Enchant Bracers - Lesser Strength
				{ 9, "prof7782" },	-- Enchant Bracers - Minor Strength
				{ 11, "INV_Box_01", nil, "Agility", nil },
				{ 12, "prof104391" },	-- Enchant Bracer - Greater Agility
				{ 13, "prof96264" },	-- Enchant Bracers - Agility
				{ 14, "prof7779" },	-- Enchant Bracers - Minor Agility
				{ 16, "INV_Box_01", nil, "Intellect", nil },
				{ 17, "prof104389" },	-- Enchant Bracer - Super Intellect
				{ 18, "prof96262" },	-- Enchant Bracers - Mighty Intellect
				{ 19, "prof44555" },	-- Enchant Bracers - Exceptional Intellect
				{ 20, "prof34001" },	-- Enchant Bracers - Major Intellect
				{ 21, "prof20008" },	-- Enchant Bracers - Greater Intellect
				{ 22, "prof13822" },	-- Enchant Bracers - Intellect
				{ 23, "prof13622" },	-- Enchant Bracers - Lesser Intellect
				{ 25, "INV_Box_01", nil, "Dodge Rating", nil },
				{ 26, "prof104385" },	-- Enchant Bracer - Major Dodge
				{ 27, "prof74229" },	-- Enchant Bracer - Superior Dodge
				{ 28, "prof13931" },	-- Enchant Bracers - Dodge
				{ 29, "prof13646" },	-- Enchant Bracers - Lesser Dodge
				{ 30, "prof7428" },	-- Enchant Bracers - Minor Dodge
				{ 101, "INV_Box_01", nil, "Stamina", nil },
				{ 102, "prof62256" },	-- Enchant Bracers - Major Stamina
				{ 103, "prof27914" },	-- Enchant Bracers - Fortitude
				{ 104, "prof20011" },	-- Enchant Bracers - Superior Stamina
				{ 105, "prof13945" },	-- Enchant Bracers - Greater Stamina
				{ 106, "prof13648" },	-- Enchant Bracers - Stamina
				{ 107, "prof13501" },	-- Enchant Bracers - Lesser Stamina
				{ 108, "prof7457" },	-- Enchant Bracers - Minor Stamina
				{ 109, "prof7418" },	-- Enchant Bracers - Minor Health
				{ 111, "INV_Box_01", nil, "Attack Power", nil },
				{ 112, "prof44575" },	-- Enchant Bracers - Greater Assault
				{ 113, "prof60616" },	-- Enchant Bracers - Striking
				{ 114, "prof34002" },	-- Enchant Bracers - Assault
				{ 116, "INV_Box_01", nil, "Spirit", nil },
				{ 117, "prof74237" },	-- Enchant Bracer - Exceptional Spirit
				{ 118, "prof44593" },	-- Enchant Bracers - Major Spirit
				{ 119, "prof20009" },	-- Enchant Bracers - Superior Spirit
				{ 120, "prof13846" },	-- Enchant Bracers - Greater Spirit
				{ 121, "prof13642" },	-- Enchant Bracers - Spirit
				{ 122, "prof7859" },	-- Enchant Bracers - Lesser Spirit
				{ 123, "prof7766" },	-- Enchant Bracers - Minor Spirit
				{ 125, "INV_Box_01", nil, "Spell Power", nil },
				{ 126, "prof60767" },	-- Enchant Bracers - Superior Spellpower
				{ 127, "prof44635" },	-- Enchant Bracers - Greater Spellpower
				{ 128, "prof27917" },	-- Enchant Bracers - Spellpower
				{ 129, "prof27911" },	-- Enchant Bracers - Superior Healing
				{ 130, "prof23802" },	-- Enchant Bracers - Healing Power
				{ 201, "INV_Box_01", nil, "Crit Rating", nil },
				{ 202, "prof74248" },	-- Enchant Bracer - Greater Critical Strike
				{ 203, "prof74201" },	-- Enchant Bracer - Critical Strike
				{ 205, "INV_Box_01", nil, "Haste Rating", nil },
				{ 206, "prof74256" },	-- Enchant Bracer - Greater Speed
				{ 207, "prof74193" },	-- Enchant Bracer - Speed
				{ 209, "INV_Box_01", nil, "Mana / Second", nil },
				{ 210, "prof27913" },	-- Enchant Bracers - Restore Mana Prime
				{ 211, "prof23801" },	-- Enchant Bracers - Mana Regeneration
				{ 216, "INV_Box_01", nil, "Stats", nil },
				{ 217, "prof44616" },	-- Enchant Bracers - Greater Stats
				{ 218, "prof27905" },	-- Enchant Bracers - Stats
				{ 220, "INV_Box_01", nil, "Other", nil },
				{ 221, "prof104338" },	-- Enchant Bracer - Mastery
				{ 222, "prof74239" },	-- Enchant Bracers - Greater Expertise
				{ 223, "prof74232" },	-- Enchant Bracer - Precision
				{ 224, "prof44598" },	-- Enchant Bracers - Expertise
				{ 225, "prof27906" },	-- Enchant Bracers - Greater Dodge
			},
		},
		{	--EnchantingChest
			name = AL["Chest"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Stats", nil },
				{ 2, "prof104395" },	-- Enchant Chest - Glorious Stats
				{ 3, "prof74250" },	-- Enchant Chest - Peerless Stats
				{ 4, "prof74191" },	-- Enchant Chest - Mighty Stats
				{ 5, "prof60692" },	-- Enchant Chest - Powerful Stats
				{ 6, "prof44623" },	-- Enchant Chest - Super Stats
				{ 7, "prof27960" },	-- Enchant Chest - Exceptional Stats
				{ 8, "prof20025" },	-- Enchant Chest - Greater Stats
				{ 9, "prof13941" },	-- Enchant Chest - Stats
				{ 10, "prof13700" },	-- Enchant Chest - Lesser Stats
				{ 11, "prof13626" },	-- Enchant Chest - Minor Stats
				{ 13, "INV_Box_01", nil, "Mana / Second", nil },
				{ 14, "prof44509" },	-- Enchant Chest - Greater Mana Restoration
				{ 15, "prof33991" },	-- Enchant Chest - Restore Mana Prime
				{ 16, "INV_Box_01", nil, "Health", nil },
				{ 17, "prof104397" },	-- Enchant Chest - Superior Stamina
				{ 18, "prof74251" },	-- Enchant Chest - Greater Stamina
				{ 19, "prof74200" },	-- Enchant Chest - Stamina
				{ 20, "prof47900" },	-- Enchant Chest - Super Health
				{ 21, "prof44492" },	-- Enchant Chest - Mighty Health
				{ 22, "prof27957" },	-- Enchant Chest - Exceptional Health
				{ 23, "prof20026" },	-- Enchant Chest - Major Health
				{ 24, "prof13858" },	-- Enchant Chest - Superior Health
				{ 25, "prof13640" },	-- Enchant Chest - Greater Health
				{ 26, "prof7857" },	-- Enchant Chest - Health
				{ 27, "prof7748" },	-- Enchant Chest - Lesser Health
				{ 28, "prof7420" },	-- Enchant Chest - Minor Health
				{ 101, "INV_Box_01", nil, "Resilience", nil },
				{ 102, "prof104392" },	-- Enchant Chest - Super Resilience
				{ 103, "prof74214" },	-- Enchant Chest - Mighty Resilience
				{ 104, "prof44588" },	-- Enchant Chest - Exceptional Resilience
				{ 105, "prof33992" },	-- Enchant Chest - Major Resilience
				{ 107, "INV_Box_01", nil, "Mana", nil },
				{ 108, "prof27958" },	-- Enchant Chest - Exceptional Mana
				{ 109, "prof20028" },	-- Enchant Chest - Major Mana
				{ 110, "prof13917" },	-- Enchant Chest - Superior Mana
				{ 111, "prof13663" },	-- Enchant Chest - Greater Mana
				{ 112, "prof13607" },	-- Enchant Chest - Mana
				{ 113, "prof7776" },	-- Enchant Chest - Lesser Mana
				{ 114, "prof7443" },	-- Enchant Chest - Minor Mana
				{ 116, "INV_Box_01", nil, "Spirit", nil },
				{ 117, "prof104393" },	-- Enchant Chest - Mighty Spirit
				{ 118, "prof74231" },	-- Enchant Chest - Exceptional Spirit
				{ 119, "prof33990" },	-- Enchant Chest - Major Spirit
				{ 121, "INV_Box_01", nil, "Dodge Rating", nil },
				{ 122, "prof47766" },	-- Enchant Chest - Greater Dodge
				{ 123, "prof46594" },	-- Enchant Chest - Dodge
				{ 125, "INV_Box_01", nil, "Damage Absorption", nil },
				{ 126, "prof13538" },	-- Enchant Chest - Lesser Absorption
				{ 127, "prof7426" },	-- Enchant Chest - Minor Absorption
			},
		},
		{	--EnchantingCloak
			name = AL["Cloak"],
			[WOD_DIFF] = {
				{ 1, 110652, 158884, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Gift of Critical Strike (Sold, Ashran)
				{ 2, 110653, 158885, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Gift of Haste (Sold, Ashran)
				{ 3, 110654, 158886, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Gift of Mastery (Sold, Ashran)
				{ 4, 110655, 158887, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Gift of Multistrike (Sold, Ashran)
				{ 5, 110656, 158889, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Gift of Versatility (Sold, Ashran)
				{ 16, 110631, 158877, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Breath of Critical Strike (Sold, Ashran)
				{ 17, 110632, 158878, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Breath of Haste (Sold, Ashran)
				{ 18, 110633, 158879, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Breath of Mastery (Sold, Ashran)
				{ 19, 110634, 158880, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Breath of Multistrike (Sold, Ashran)
				{ 20, 110635, 158881, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Cloak - Breath of Versatility (Sold, Ashran)
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Agility", nil },
				{ 2, "prof60663" },	-- Enchant Cloak - Major Agility
				{ 3, "prof44500" },	-- Enchant Cloak - Superior Agility
				{ 4, "prof34004" },	-- Enchant Cloak - Greater Agility
				{ 5, "prof13882" },	-- Enchant Cloak - Lesser Agility
				{ 6, "prof13419" },	-- Enchant Cloak - Minor Agility
				{ 8, "INV_Box_01", nil, "Crit Rating", nil },
				{ 9, "prof104404" },	-- Enchant Cloak - Superior Critical Strike
				{ 10, "prof74247" },	-- Enchant Cloak - Greater Critical Strike
				{ 11, "prof74230" },	-- Enchant Cloak - Critical Strike
				{ 16, "INV_Box_01", nil, "Armor & Stamina", nil },
				{ 17, "prof104401" },	-- Enchant Cloak - Greater Protection
				{ 18, "prof74234" },	-- Enchant Cloak - Protection
				{ 19, "prof47672" },	-- Enchant Cloak - Mighty Armor
				{ 20, "prof27961" },	-- Enchant Cloak - Major Armor
				{ 21, "prof20015" },	-- Enchant Cloak - Superior Defense
				{ 22, "prof13746" },	-- Enchant Cloak - Greater Defense
				{ 23, "prof13635" },	-- Enchant Cloak - Defense
				{ 24, "prof13421" },	-- Enchant Cloak - Lesser Protection
				{ 25, "prof7771" },	-- Enchant Cloak - Minor Protection
				{ 27, "INV_Box_01", nil, "Intellect", nil },
				{ 28, "prof104403" },	-- Enchant Cloak - Superior Intellect
				{ 29, "prof74240" },	-- Enchant Cloak - Greater Intellect
				{ 30, "prof74202" },	-- Enchant Cloak - Intellect
				{ 101, "INV_Box_01", nil, "Dodge Rating", nil },
				{ 102, "prof44591" },	-- Enchant Cloak - Superior Dodge
				{ 103, "prof47051" },	-- Enchant Cloak - Greater Dodge
				{ 104, "prof25086" },	-- Enchant Cloak - Dodge
				{ 105, "prof25083" },	-- Enchant Cloak - Stealth
				{ 116, "INV_Box_01", nil, "Other", nil },
				{ 117, "prof104398" },	-- Enchant Cloak - Accuracy
				{ 118, "prof44631" },	-- Enchant Cloak - Shadow Armor
				{ 119, "prof47899" },	-- Enchant Cloak - Wisdom
				{ 120, "prof74192" },	-- Enchant Cloak - Lesser Power
				{ 121, "prof47898" },	-- Enchant Cloak - Greater Speed
				{ 122, "prof44582" },	-- Enchant Cloak - Minor Power
				{ 123, "prof60609" },	-- Enchant Cloak - Speed
				{ 124, "prof34003" },	-- Enchant Cloak - Spell Penetration
				{ 125, "prof25084" },	-- Enchant Cloak - Subtlety
			},
		},
		{	--EnchantingGloves
			name = AL["Gloves"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Agility", nil },
				{ 2, "prof44529" },	-- Enchant Gloves - Major Agility
				{ 3, "prof25080" },	-- Enchant Gloves - Superior Agility
				{ 4, "prof20012" },	-- Enchant Gloves - Greater Agility
				{ 5, "prof13815" },	-- Enchant Gloves - Agility
				{ 7, "INV_Box_01", nil, "Attack Power", nil },
				{ 8, "prof60668" },	-- Enchant Gloves - Crusher
				{ 9, "prof44513" },	-- Enchant Gloves - Greater Assault
				{ 10, "prof33996" },	-- Enchant Gloves - Assault
				{ 12, "INV_Box_01", nil, "Haste Rating", nil },
				{ 13, "prof104416" },	-- Enchant Gloves - Greater Haste
				{ 14, "prof74198" },	-- Enchant Gloves - Haste
				{ 15, "prof13948" },	-- Enchant Gloves - Minor Haste
				{ 16, "INV_Box_01", nil, "Strength", nil },
				{ 17, "prof104419" },	-- Enchant Gloves - Super Strength
				{ 18, "prof74254" },	-- Enchant Gloves - Mighty Strength
				{ 19, "prof74212" },	-- Enchant Gloves - Exceptional Strength
				{ 20, "prof33995" },	-- Enchant Gloves - Major Strength
				{ 21, "prof20013" },	-- Enchant Gloves - Greater Strength
				{ 22, "prof13887" },	-- Enchant Gloves - Strength
				{ 24, "INV_Box_01", nil, "Mastery Rating", nil },
				{ 25, "prof104420" },	-- Enchant Gloves - Superior Mastery
				{ 26, "prof74255" },	-- Enchant Gloves - Greater Mastery
				{ 27, "prof74132" },	-- Enchant Gloves - Mastery
				{ 101, "INV_Box_01", nil, "Expertise Rating", nil },
				{ 102, "prof104417" },	-- Enchant Gloves - Superior Expertise
				{ 103, "prof74220" },	-- Enchant Gloves - Greater Expertise
				{ 104, "prof44484" },	-- Enchant Gloves - Expertise
				{ 106, "INV_Box_01", nil, "Spell Power", nil },
				{ 107, "prof44592" },	-- Enchant Gloves - Exceptional Spellpower
				{ 108, "prof33997" },	-- Enchant Gloves - Major Spellpower
				{ 109, "prof33999" },	-- Enchant Gloves - Major Healing
				{ 110, "prof25078" },	-- Enchant Gloves - Fire Power
				{ 111, "prof25074" },	-- Enchant Gloves - Frost Power
				{ 112, "prof25079" },	-- Enchant Gloves - Healing Power
				{ 113, "prof25073" },	-- Enchant Gloves - Shadow Power
				{ 116, "INV_Box_01", nil, "Hit Rating", nil },
				{ 117, "prof44488" },	-- Enchant Gloves - Precision
				{ 118, "prof33994" },	-- Enchant Gloves - Precise Strikes
				{ 120, "INV_Box_01", nil, "Professions", nil },
				{ 121, "prof44506" },	-- Enchant Gloves - Gatherer
				{ 122, "prof71692" },	-- Enchant Gloves - Angler
				{ 123, "prof13868" },	-- Enchant Gloves - Advanced Herbalism
				{ 124, "prof13841" },	-- Enchant Gloves - Advanced Mining
				{ 125, "prof13698" },	-- Enchant Gloves - Skinning
				{ 126, "prof13620" },	-- Enchant Gloves - Fishing
				{ 127, "prof13617" },	-- Enchant Gloves - Herbalism
				{ 128, "prof13612" },	-- Enchant Gloves - Mining
				{ 201, "INV_Box_01", nil, "Other", nil },
				{ 202, "prof44625" },	-- Enchant Gloves - Armsman
				{ 203, "prof33993" },	-- Enchant Gloves - Blasting
				{ 204, "prof25072" },	-- Enchant Gloves - Threat
				{ 205, "prof13947" },	-- Enchant Gloves - Riding Skill
			},
		},
		{	--EnchantingNeck
			name = AL["Neck"],
			[WOD_DIFF] = {
				{ 1, 110645, 158899, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Gift of Critical Strike (Sold, Ashran)
				{ 2, 110646, 158900, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Gift of Haste (Sold, Ashran)
				{ 3, 110647, 158901, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Gift of Mastery (Sold, Ashran)
				{ 4, 110648, 158902, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Gift of Multistrike (Sold, Ashran)
				{ 5, 110649, 158903, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Gift of Versatility (Sold, Ashran)
				{ 16, 110624, 158892, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Breath of Critical Strike (Sold, Ashran)
				{ 17, 110625, 158893, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Breath of Haste (Sold, Ashran)
				{ 18, 110626, 158894, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Breath of Mastery (Sold, Ashran)
				{ 19, 110627, 158895, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Breath of Multistrike (Sold, Ashran)
				{ 20, 110628, 158896, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Neck - Breath of Versatility (Sold, Ashran)
			},
		},
		{	--EnchantingRing
			name = AL["Ring"],
			[WOD_DIFF] = {
				{ 1, 110638, 158914, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Ring - Gift of Critical Strike (Sold, Ashran)
				{ 2, 110639, 158915, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Ring - Gift of Haste (Sold, Ashran)
				{ 3, 110640, 158916, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Ring - Gift of Mastery (Sold, Ashran)
				{ 4, 110641, 158917, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Ring - Gift of Multistrike (Sold, Ashran)
				{ 5, 110642, 158918, [PRICE_EXTRA_ITTYPE] = "119293:1" },	-- Enchant Ring - Gift of Versatility (Sold, Ashran)
				{ 16, 110617, 158907 },	-- Enchant Ring - Breath of Critical Strike (Learnt by item 111922)
				{ 17, 110618, 158908 },	-- Enchant Ring - Breath of Haste (Learnt by item 111922)
				{ 18, 110619, 158909 },	-- Enchant Ring - Breath of Mastery (Learnt by item 111922)
				{ 19, 110620, 158910 },	-- Enchant Ring - Breath of Multistrike (Learnt by item 111922)
				{ 20, 110621, 158911 },	-- Enchant Ring - Breath of Versatility (Learnt by item 111922)
			},
		},
		{	--EnchantingShieldOffHand
			name = AL["Shields"].." & "..AL["Off-Hands"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Other", nil },
				{ 2, "prof130758" },	-- Enchant Shield - Greater Parry
				{ 3, "prof74226" },	-- Enchant Shield - Mastery
				{ 4, "prof74207" },	-- Enchant Shield - Protection
				{ 5, "prof44489" },	-- Enchant Shield - Dodge
				{ 6, "prof60653" },	-- Enchant Shield - Greater Intellect
				{ 7, "prof27946" },	-- Enchant Shield - Parry
				{ 8, "prof44383" },	-- Enchant Shield - Resilience
				{ 9, "prof27945" },	-- Enchant Shield - Intellect
				{ 10, "prof27944" },	-- Enchant Shield - Lesser Dodge
				{ 11, "prof20016" },	-- Enchant Shield - Vitality
				{ 12, "prof13689" },	-- Enchant Shield - Lesser Parry
				{ 13, "prof13464" },	-- Enchant Shield - Lesser Protection
				{ 16, "INV_Box_01", nil, "Intellect", nil },
				{ 17, "prof104445" },	-- Enchant Off-Hand - Major Intellect
				{ 18, "prof74235" },	-- Enchant Off-Hand - Superior Intellect
				{ 20, "INV_Box_01", nil, "Stamina", nil },
				{ 21, "prof34009" },	-- Enchant Shield - Major Stamina
				{ 22, "prof20017" },	-- Enchant Shield - Greater Stamina
				{ 23, "prof13817" },	-- Enchant Shield - Stamina
				{ 24, "prof13631" },	-- Enchant Shield - Lesser Stamina
				{ 25, "prof13378" },	-- Enchant Shield - Minor Stamina
				{ 27, "INV_Box_01", nil, "Spirit", nil },
				{ 28, "prof13905" },	-- Enchant Shield - Greater Spirit
				{ 29, "prof13659" },	-- Enchant Shield - Spirit
				{ 30, "prof13485" },	-- Enchant Shield - Lesser Spirit
			},
		},
		{	--EnchantingWeapon
			name = AL["Weapons"],
			[WOD_DIFF] = {
				{ 1, 112160, 159674, [PRICE_EXTRA_ITTYPE] = "119293:5" },	-- Enchant Weapon - Mark of Blackrock (Sold, Ashran)
				{ 2, 118015, 173323, [PRICE_EXTRA_ITTYPE] = "119293:5" },	-- Enchant Weapon - Mark of Bleeding Hollow (Sold, Ashran)
				{ 3, 112115, 159673, [PRICE_EXTRA_ITTYPE] = "119293:5" },	-- Enchant Weapon - Mark of Shadowmoon (Sold, Ashran)
				{ 4, 112165, 159672, [PRICE_EXTRA_ITTYPE] = "119293:5" },	-- Enchant Weapon - Mark of the Frostwolf (Sold, Ashran)
				{ 5, 112093, 159236 },	-- Enchant Weapon - Mark of the Shattered Hand (Learnt by item 111922)
				{ 6, 110682, 159235, [PRICE_EXTRA_ITTYPE] = "119293:5" },	-- Enchant Weapon - Mark of the Thunderlord (Sold, Ashran)
				{ 7, 112164, 159671, [PRICE_EXTRA_ITTYPE] = "119293:5" },	-- Enchant Weapon - Mark of Warsong (Sold, Ashran)
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Proc", nil },
				{ 2, "prof104434" },	-- Enchant Weapon - Dancing Steel
				{ 3, "prof104427" },	-- Enchant Weapon - Jade Spirit
				{ 4, "prof104442" },	-- Enchant Weapon - River's Song
				{ 5, "prof104440" },	-- Enchant Weapon - Colossus
				{ 6, "prof104425" },	-- Enchant Weapon - Windsong
				{ 7, "prof104430" },	-- Enchant Weapon - Elemental Force
				{ 8, "prof74244" },	-- Enchant Weapon - Windwalk
				{ 9, "prof74223" },	-- Enchant Weapon - Hurricane
				{ 10, "prof74197" },	-- Enchant Weapon - Avalanche
				{ 11, "prof74195" },	-- Enchant Weapon - Mending
				{ 12, "prof64441" },	-- Enchant Weapon - Blade Ward
				{ 13, "prof64579" },	-- Enchant Weapon - Blood Draining
				{ 14, "prof59625" },	-- Enchant Weapon - Black Magic
				{ 15, "prof44576" },	-- Enchant Weapon - Lifeward
				{ 16, "prof44524" },	-- Enchant Weapon - Icebreaker
				{ 17, "prof42974" },	-- Enchant Weapon - Executioner
				{ 18, "prof28004" },	-- Enchant Weapon - Battlemaster
				{ 19, "prof28003" },	-- Enchant Weapon - Spellsurge
				{ 20, "prof46578" },	-- Enchant Weapon - Deathfrost
				{ 21, "prof20034" },	-- Enchant Weapon - Crusader
				{ 22, "prof20032" },	-- Enchant Weapon - Lifestealing
				{ 23, "prof20033" },	-- Enchant Weapon - Unholy Weapon
				{ 24, "prof20029" },	-- Enchant Weapon - Icy Chill
				{ 25, "prof13898" },	-- Enchant Weapon - Fiery Weapon
				{ 27, "INV_Box_01", nil, "Intellect", nil },
				{ 28, "prof74242" },	-- Enchant Weapon - Power Torrent
				{ 29, "prof27968" },	-- Enchant Weapon - Major Intellect
				{ 30, "prof23804" },	-- Enchant Weapon - Mighty Intellect
				{ 101, "INV_Box_01", nil, "Damage", nil },
				{ 102, "prof74211" },	-- Enchant Weapon - Elemental Slayer
				{ 103, "prof44621" },	-- Enchant Weapon - Giant Slayer
				{ 104, "prof27967" },	-- Enchant Weapon - Major Striking
				{ 105, "prof20031" },	-- Enchant Weapon - Superior Striking
				{ 106, "prof13943" },	-- Enchant Weapon - Greater Striking
				{ 107, "prof13915" },	-- Enchant Weapon - Demonslaying
				{ 108, "prof13693" },	-- Enchant Weapon - Striking
				{ 109, "prof13653" },	-- Enchant Weapon - Lesser Beastslayer
				{ 110, "prof13655" },	-- Enchant Weapon - Lesser Elemental Slayer
				{ 111, "prof13503" },	-- Enchant Weapon - Lesser Striking
				{ 112, "prof7786" },	-- Enchant Weapon - Minor Beastslayer
				{ 113, "prof7788" },	-- Enchant Weapon - Minor Striking
				{ 116, "INV_Box_01", nil, "Strength", nil },
				{ 117, "prof27972" },	-- Enchant Weapon - Potency
				{ 118, "prof23799" },	-- Enchant Weapon - Strength
				{ 120, "INV_Box_01", nil, "Attack Power", nil },
				{ 121, "prof74246" },	-- Enchant Weapon - Landslide
				{ 122, "prof59621" },	-- Enchant Weapon - Berserking
				{ 123, "prof60707" },	-- Enchant Weapon - Superior Potency
				{ 124, "prof60621" },	-- Enchant Weapon - Greater Potency
				{ 126, "INV_Box_01", nil, "Spirit", nil },
				{ 127, "prof74225" },	-- Enchant Weapon - Heartsong
				{ 128, "prof44510" },	-- Enchant Weapon - Exceptional Spirit
				{ 129, "prof23803" },	-- Enchant Weapon - Mighty Spirit
				{ 201, "INV_Box_01", nil, "Spell Power", nil },
				{ 202, "prof60714" },	-- Enchant Weapon - Mighty Spellpower
				{ 203, "prof44629" },	-- Enchant Weapon - Exceptional Spellpower
				{ 204, "prof27982" },	-- Enchant Weapon - Soulfrost
				{ 205, "prof27981" },	-- Enchant Weapon - Sunfire
				{ 206, "prof34010" },	-- Enchant Weapon - Major Healing
				{ 207, "prof27975" },	-- Enchant Weapon - Major Spellpower
				{ 208, "prof22750" },	-- Enchant Weapon - Healing Power
				{ 209, "prof22749" },	-- Enchant Weapon - Spellpower
				{ 210, "prof21931" },	-- Enchant Weapon - Winter's Might
				{ 216, "INV_Box_01", nil, "Agility", nil },
				{ 217, "prof44633" },	-- Enchant Weapon - Exceptional Agility
				{ 218, "prof27984" },	-- Enchant Weapon - Mongoose
				{ 219, "prof42620" },	-- Enchant Weapon - Greater Agility
				{ 220, "prof23800" },	-- Enchant Weapon - Agility
				{ 222, "INV_Box_01", nil, "Other", nil },
				{ 223, "prof59619" },	-- Enchant Weapon - Accuracy
			},
		},
		{	--Enchanting2HWeapon
			name = AL["2H Weapons"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Agility", nil },
				{ 2, "prof95471" },	-- Enchant 2H Weapon - Mighty Agility
				{ 3, "prof27977" },	-- Enchant 2H Weapon - Major Agility
				{ 4, "prof27837" },	-- Enchant 2H Weapon - Agility
				{ 6, "INV_Box_01", nil, "Attack Power", nil },
				{ 7, "prof60691" },	-- Enchant 2H Weapon - Massacre
				{ 8, "prof44630" },	-- Enchant 2H Weapon - Greater Savagery
				{ 9, "prof27971" },	-- Enchant 2H Weapon - Savagery
				{ 11, "INV_Box_01", nil, "Intellect", nil },
				{ 12, "prof20036" },	-- Enchant 2H Weapon - Major Intellect
				{ 13, "prof7793" },	-- Enchant 2H Weapon - Lesser Intellect
				{ 16, "INV_Box_01", nil, "Damage", nil },
				{ 17, "prof20030" },	-- Enchant 2H Weapon - Superior Impact
				{ 18, "prof13937" },	-- Enchant 2H Weapon - Greater Impact
				{ 19, "prof13695" },	-- Enchant 2H Weapon - Impact
				{ 20, "prof13529" },	-- Enchant 2H Weapon - Lesser Impact
				{ 21, "prof7745" },	-- Enchant 2H Weapon - Minor Impact
				{ 23, "INV_Box_01", nil, "Spirit", nil },
				{ 24, "prof20035" },	-- Enchant 2H Weapon - Major Spirit
				{ 25, "prof13380" },	-- Enchant 2H Weapon - Lesser Spirit
				{ 27, "INV_Box_01", nil, "Other", nil },
				{ 28, "prof44595" },	-- Enchant 2H Weapon - Scourgebane
				{ 29, "prof62948" },	-- Enchant Staff - Greater Spellpower
				{ 30, "prof62959" },	-- Enchant Staff - Spellpower
			},
		},
		{	--EnchantingIllusions
			name = AL["Illusions"],
			[WOD_DIFF] = {
				{ 1, 118161, 173716 },	-- Enchanter's Illusion - Agility
				{ 2, 118162, 173717 },	-- Enchanter's Illusion - Battlemaster
				{ 3, 118163, 173718 },	-- Enchanter's Illusion - Berserking
				{ 4, 118526, 174979 },	-- Enchanter's Illusion - Blood Draining
				{ 5, 118164, 173719 },	-- Enchanter's Illusion - Butterflies
				{ 6, 118165, 173720 },	-- Enchanter's Illusion - Crusader
				{ 7, 118166, 173721 },	-- Enchanter's Illusion - Elemental Force
				{ 8, 118167, 173722 },	-- Enchanter's Illusion - Executioner
				{ 9, 118168, 173723 },	-- Enchanter's Illusion - Fiery Weapon
				{ 10, 118169, 173724 },	-- Enchanter's Illusion - Hidden
				{ 11, 118548, 175070 },	-- Enchanter's Illusion - Jade Spirit
				{ 12, 118170, 173725 },	-- Enchanter's Illusion - Landslide
				{ 13, 118171, 173726 },	-- Enchanter's Illusion - Lifestealing
				{ 14, 118556, 175085 },	-- Enchanter's Illusion - Mending
				{ 15, 118172, 173727 },	-- Enchanter's Illusion - Mongoose
				{ 16, 118174, 173729 },	-- Enchanter's Illusion - Power Torrent
				{ 17, 118557, 175086 },	-- Enchanter's Illusion - River's Song
				{ 18, 118175, 173730 },	-- Enchanter's Illusion - Spellsurge
				{ 19, 118176, 173731 },	-- Enchanter's Illusion - Striking
				{ 20, 118177, 173732 },	-- Enchanter's Illusion - Unholy
				{ 22, 118173, 173728 },	-- Enchanter's Illusion - Poisoned
				{ 24, 118552, 175076 },	-- Enchanter's Illusion - Earthliving
				{ 25, 118550, 175072 },	-- Enchanter's Illusion - Flametongue
				{ 26, 118549, 175071 },	-- Enchanter's Illusion - Frostbrand
				{ 27, 118553, 175078 },	-- Enchanter's Illusion - Rockbiter
				{ 28, 118551, 175074 },	-- Enchanter's Illusion - Windfury
			},
		},
		{	--EnchantingMisc
			name = AL["Miscellaneous"],
			[WOD_DIFF] = {
				{ 1, 112321, 162948 },	-- Enchanted Dust (Learnt by item 111922)
				{ 3, 113588, 169092 },	-- Temporal Crystal (Learnt by item 111922)
				{ 4, 115504, 170443 },	-- Fractured Temporal Crystal
				{ 5, 111245, 169091 },	-- Luminous Shard (Learnt by item 111922)
				{ 6, 115502, 170440 },	-- Small Luminous Shard
				{ 8, 119293, 177043 },	-- Secrets of Draenor Enchanting (Learnt by item 111922)
			},
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, "Companions", nil },
				{ 2, 67275, "prof93843" },	-- Magic Lamp
				{ 3, 67274, "prof93841" },	-- Enchanted Lantern
				{ 5, "INV_Box_01", nil, "Other", nil },
				{ 6, 74248, "prof116499" },	-- Sha Crystal
				{ 7, 74247, "prof118239" },	-- Sha Shatter
				{ 8, 74250, "prof118238" },	-- Ethereal Shatter
				{ 9, 74247, "prof116498" },	-- Ethereal Shard
				{ 10, 74249, "prof118237" },	-- Mysterious Diffusion
				{ 11, 74250, "prof116497" },	-- Mysterious Essence
				{ 12, 52721, "prof104698" },	-- Maelstrom Shatter
				{ 13, 89738, "prof69412" },	-- Abyssal Shatter
				{ 14, 22449, "prof45765" },	-- Void Shatter
				{ 15, 22459, "prof28028" },	-- Void Sphere
				{ 16, 22449, "prof28022" },	-- Large Prismatic Shard
				{ 17, 22448, "prof42615" },	-- Small Prismatic Shard
				{ 18, 22460, "prof28027" },	-- Prismatic Sphere
				{ 19, 22448, "prof42613" },	-- Nexus Transformation
				{ 20, 11811, "prof15596" },	-- Smoking Heart of the Mountain
				{ 21, 12810, "prof17181" },	-- Enchanted Leather
				{ 22, 12655, "prof17180" },	-- Enchanted Thorium
				{ 23, 6218, "prof7421" },	-- Runed Copper Rod
				{ 101, "INV_Box_01", nil, "Oil", nil },
				{ 102, 22522, "prof28019" },	-- Superior Wizard Oil
				{ 103, 22521, "prof28016" },	-- Superior Mana Oil
				{ 104, 20750, "prof25128" },	-- Wizard Oil
				{ 105, 20747, "prof25127" },	-- Lesser Mana Oil
				{ 106, 20746, "prof25126" },	-- Lesser Wizard Oil
				{ 107, 20745, "prof25125" },	-- Minor Mana Oil
				{ 108, 20744, "prof25124" },	-- Minor Wizard Oil
				{ 116, "INV_Box_01", nil, "Wand", nil },
				{ 117, 11290, "prof14810" },	-- Greater Mystic Wand
				{ 118, 11289, "prof14809" },	-- Lesser Mystic Wand
				{ 119, 11288, "prof14807" },	-- Greater Magic Wand
				{ 120, 11287, "prof14293" },	-- Lesser Magic Wand
			},
		},
	}
}

data["Engineering"] = {
	name = GetSpellInfo(4036),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--EngineeringArmorWeapons
			name = AL["Armor"].." & "..AL["Weapons"],
			[WOD_DIFF] = {
				{ 1, "109172:Stage3", 169077 },	-- Plasma Mechshades (Stage 3)
				{ 2, "109172:Stage2", 169076 },	-- Plasma Mechshades (Stage 2)
				{ 3, "109172:Stage1", 162197, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Plasma Mechshades (Stage 1) (Sold, Ashran)
				{ 5, "109171:Stage3", 169077 },	-- Night-Vision Mechshades (Stage 3)
				{ 6, "109171:Stage2", 169076 },	-- Night-Vision Mechshades (Stage 2)
				{ 7, "109171:Stage1", 162196, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Night-Vision Mechshades (Stage 1) (Sold, Ashran)
				{ 9, "109168:Stage3W", 177364 },	-- Shrediron's Shredder (Stage 3)
				{ 10, "109168:Stage2W", 177363 },	-- Shrediron's Shredder (Stage 2)
				{ 11, "109168:Stage1", 162199, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Shrediron's Shredder (Stage 1) (Sold, Ashran)
				{ 16, "109173:Stage3", 169077 },	-- Cybergenetic Mechshades (Stage 3)
				{ 17, "109173:Stage2", 169076 },	-- Cybergenetic Mechshades (Stage 2)
				{ 18, "109173:Stage1", 162195, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Cybergenetic Mechshades (Stage 1) (Sold, Ashran)
				{ 20, "109174:Stage3", 169077 },	-- Razorguard Mechshades (Stage 3)
				{ 21, "109174:Stage2", 169076 },	-- Razorguard Mechshades (Stage 2)
				{ 22, "109174:Stage1", 162198, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Razorguard Mechshades (Stage 1) (Sold, Ashran)
			},
		},
		{	--EngineeringMountsPets
			name = AL["Mounts"].." & "..AL["Pets"],
			[WOD_DIFF] = {
				{ 1, 112057, 162210, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Lifelike Mechanical Frostboar (Sold, Ashran)
				{ 2, 111402, 162209, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Mechanical Axebeak (Sold, Ashran)
				{ 3, 118741, 176732, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Mechanical Scorpid (Sold, Ashran)
			},
		},
		{	--EngineeringReagents
			name = AL["Reagents"],
			[WOD_DIFF] = {
				{ 1, 111366, 169080 },	-- Gearspring Parts (Learnt by item 111921)
				{ 3, 119299, 177054 },	-- Secrets of Draenor Engineering (Learnt by item 111921)
			},
		},
		{	--EngineeringScopes
			name = AL["Scopes"],
			[WOD_DIFF] = {
				{ 1, 118008, 173289, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Hemet's Heartseeker (Sold, Ashran)
				{ 2, 109122, 162203, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Megawatt Filament (Sold, Ashran)
				{ 3, 109120, 162202, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Oglethorpe's Missile Splitter (Sold, Ashran)
			},
		},
		{	--EngineeringTinker
			name = AL["Tinker"],
			[WOD_DIFF] = {
				{ 1, 109076, 162204 },	-- Goblin Glider Kit (Learnt by item 111921)
				{ 2, 118007, 173308 },	-- Mecha-Blast Rocket (Learnt by item 111921)
				{ 3, 118006, 173309 },	-- Shieldtronic Shield (Learnt by item 111921)
				{ 4, 109184, 162207 },	-- Stealthman 54 (Learnt by item 111921)
			},
		},
		{	--EngineeringMisc
			name = AL["Miscellaneous"],
			[WOD_DIFF] = {
				{ 1, 111821, 162218, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Blingtron 5000 (Sold, Ashran)
				{ 2, 109167, 162205, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Findle's Loot-a-Rang (Sold, Ashran)
				{ 3, 108745, 162214, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Personal Hologram (Sold, Ashran)
				{ 4, 111820, 162217, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Swapblaster (Sold, Ashran)
				{ 5, 114943, 169140 },	-- Ultimate Gnomish Army Knife (Learnt by item 111921)
				{ 6, 109183, 162206, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- World Shrinker (Sold, Ashran)
				{ 7, 112059, 162216, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Wormhole Centrifuge (Sold, Ashran)
				{ 8, 109253, 162208 },	-- Ultimate Gnomish Army Knife (Learnt by item 111921)
				{ 16, 114050, 169076, [PRICE_EXTRA_ITTYPE] = "119299:5" },	-- Linkgrease Locksprocket (Sold, Ashran)
				{ 17, 114055, 169077, [PRICE_EXTRA_ITTYPE] = "119299:5" },	-- Morden's Magnificent Contraption (Sold, Ashran)
				{ 19, 119822, 177363, [PRICE_EXTRA_ITTYPE] = "119299:5" },	-- True Iron Trigger (Sold, Ashran)
				{ 20, 119823, 177364, [PRICE_EXTRA_ITTYPE] = "119299:5" },	-- Blackrock Rifling (Sold, Ashran)
				{ 22, 114056, 169078, [PRICE_EXTRA_ITTYPE] = "119299:1" },	-- Didi's Delicate Assembly (Sold, Ashran)
			},
		},
	}
}

data["Inscription"] = {
	name = GetSpellInfo(45357),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--InscriptionDeathKnight
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			[WOD_DIFF] = {
				{ 1, 110800, 162805 },	-- Glyph of Absorb Magic (Research item 113992)
				{ 2, 110803, 162808 },	-- Glyph of Empowerment (Research item 113992)
				{ 3, 110801, 162806 },	-- Glyph of Ice Reaper (Research item 113992)
				{ 4, 110802, 162807 },	-- Glyph of Icy Runes (Research item 113992)
				{ 5, 110805, 162810 },	-- Glyph of Raise Ally (Research item 113992)
				{ 6, 110806, 162811 },	-- Glyph of Rune Tap (Research item 113992)
				{ 7, 110807, 162812 },	-- Glyph of Runic Power (Research item 113992)
			},
		},
		{	--InscriptionDruid
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			[WOD_DIFF] = {
				{ 1, 110808, 162813 },	-- Glyph of Astral Communion (Research item 113992)
				{ 2, 110813, 162818 },	-- Glyph of Celestial Alignment (Research item 113992)
				{ 3, 110810, 162815 },	-- Glyph of Enchanted Bark (Research item 113992)
				{ 4, 110809, 162814 },	-- Glyph of Imbued Bark (Research item 113992)
				{ 5, 110815, 162820 },	-- Glyph of Maim (Research item 113992)
				{ 6, 110817, 162822 },	-- Glyph of Moonwarding (Research item 113992)
				{ 7, 110814, 162819 },	-- Glyph of Nature's Cure (Research item 113992)
				{ 8, 110812, 162817 },	-- Glyph of Ninth Life (Research item 113992)
				{ 9, 110816, 162821 },	-- Glyph of Savagery (Research item 113992)
				{ 10, 120300, 178448 },	-- Glyph of the Shapemender (Research item 113992)
				{ 12, 118573, 175186 },	-- Glyph of the Flapping Owl (Research item 113992)
				{ 13, 110818, 162823 },	-- Glyph of Travel (Research item 113992)
			},
		},
		{	--InscriptionHunter
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			[WOD_DIFF] = {
				{ 1, 110821, 162826 },	-- Glyph of Quick Revival (Research item 113992)
				{ 2, 110822, 162827 },	-- Glyph of Snake Trap (Research item 113992)
				{ 4, 110819, 162824 },	-- Glyph of Play Dead (Research item 113992)
			},
		},
		{	--InscriptionMage
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			[WOD_DIFF] = {
				{ 1, 110824, 162829 },	-- Glyph of Dragon's Breath (Research item 113992)
				{ 2, 110825, 162830 },	-- Glyph of Regenerative Ice (Research item 113992)
			},
		},
		{	--InscriptionMonk
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["MONK"],
			[WOD_DIFF] = {
				{ 1, 110826, 162831 },	-- Glyph of Expel Harm (Research item 113992)
				{ 2, 110827, 162832 },	-- Glyph of Floating Butterfly (Research item 113992)
				{ 3, 110828, 162833 },	-- Glyph of Flying Serpent (Research item 113992)
				{ 4, 110832, 162837 },	-- Glyph of Freedom Roll (Research item 113992)
				{ 5, 110829, 162834 },	-- Glyph of Keg Smash (Research item 113992)
				{ 6, 110830, 162835 },	-- Glyph of Renewed Tea (Research item 113992)
				{ 7, 110833, 162838 },	-- Glyph of Soothing Mist (Research item 113992)
				{ 8, 110831, 162836 },	-- Glyph of Victory Roll (Research item 113992)
				{ 9, 110834, 162839 },	-- Glyph of Zen Focus (Research item 113992)
			},
		},
		{	--InscriptionPaladin
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			[WOD_DIFF] = {
				{ 1, 110835, 162840 },	-- Glyph of Ardent Defender (Research item 113992)
				{ 2, 110836, 162841 },	-- Glyph of Consecrator (Research item 113992)
				{ 3, 110837, 162842 },	-- Glyph of Divine Wrath (Research item 113992)
				{ 4, 110839, 162844 },	-- Glyph of Hand of Freedom (Research item 113992)
				{ 5, 110840, 162845 },	-- Glyph of Judgment (Research item 113992)
				{ 6, 110838, 162843 },	-- Glyph of Liberator (Research item 113992)
			},
		},
		{	--InscriptionPriest
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			[WOD_DIFF] = {
				{ 1, 110842, 162847 },	-- Glyph of Delayed Coalescence (Research item 113992)
				{ 2, 110841, 162846 },	-- Glyph of Free Action (Research item 113992)
				{ 3, 110843, 162848 },	-- Glyph of Guardian Spirit (Research item 113992)
				{ 4, 110846, 162851 },	-- Glyph of Inquisitor (Research item 113992)
				{ 5, 110845, 162850 },	-- Glyph of Miraculous Dispelling (Research item 113992)
				{ 6, 110844, 162849 },	-- Glyph of Restored Faith (Research item 113992)
				{ 7, 110849, 162854 },	-- Glyph of Shadow Magic (Research item 113992)
				{ 8, 110847, 162852 },	-- Glyph of Silence (Research item 113992)
				{ 9, 110848, 162853 },	-- Glyph of Spirit of Redemption (Research item 113992)
			},
		},
		{	--InscriptionRogue
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			[WOD_DIFF] = {
				{ 1, 110853, 162858 },	-- Glyph of Disappearance (Research item 113992)
				{ 2, 110851, 162856 },	-- Glyph of Elusiveness (Research item 113992)
				{ 3, 110850, 162855 },	-- Glyph of Energy (Research item 113992)
				{ 4, 110852, 162857 },	-- Glyph of Energy Flows (Research item 113992)
			},
		},
		{	--InscriptionShaman
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			[WOD_DIFF] = {
				{ 1, 110854, 162859 },	-- Glyph of Ephemeral Spirits (Research item 113992)
				{ 2, 110856, 162861 },	-- Glyph of Grounding (Research item 113992)
				{ 3, 110857, 162862 },	-- Glyph of Lava Spread (Research item 113992)
				{ 4, 110858, 162863 },	-- Glyph of Reactive Shielding (Research item 113992)
				{ 5, 110859, 162864 },	-- Glyph of Shamanistic Resolve (Research item 113992)
				{ 6, 110860, 162865 },	-- Glyph of Shocks (Research item 113992)
				{ 7, 110862, 162867 },	-- Glyph of Spiritwalker's Aegis (Research item 113992)
				{ 8, 110861, 162866 },	-- Glyph of Spiritwalker's Focus (Research item 113992)
				{ 10, 110855, 162860 },	-- Glyph of Ghostly Speed (Research item 113992)
			},
		},
		{	--InscriptionWarlock
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			[WOD_DIFF] = {
				{ 1, 110864, 162869 },	-- Glyph of Dark Soul (Research item 113992)
				{ 2, 110866, 162871 },	-- Glyph of Life Pact (Research item 113992)
				{ 3, 110868, 162873 },	-- Glyph of Shadowflame (Research item 113992)
				{ 4, 110869, 162874 },	-- Glyph of Soul Swap (Research item 113992)
				{ 5, 110871, 162876 },	-- Glyph of Strengthened Resolve (Research item 113992)
				{ 7, 110867, 162872 },	-- Glyph of Metamorphosis (Research item 113992)
			},
		},
		{	--InscriptionWarrior
			name = AL["Glyphs"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			[WOD_DIFF] = {
				{ 1, 110872, 162877 },	-- Glyph of Cleave (Research item 113992)
				{ 2, 110873, 162878 },	-- Glyph of Drawn Sword (Research item 113992)
				{ 3, 110879, 162884 },	-- Glyph of Flawless Defense (Research item 113992)
				{ 4, 110874, 162879 },	-- Glyph of Heroic Leap (Research item 113992)
				{ 5, 110875, 162880 },	-- Glyph of Mocking Banner (Research item 113992)
				{ 6, 110876, 162881 },	-- Glyph of Raging Blow (Research item 113992)
				{ 7, 110877, 162882 },	-- Glyph of Rallying Cry (Research item 113992)
				{ 8, 110878, 162883 },	-- Glyph of Shattering Throw (Research item 113992)
			},
		},
		{	--InscriptionReagents
			name = AL["Reagents"],
			[WOD_DIFF] = {
				{ 1, 112377, 169081 },	-- War Paints (Learnt by item 111923)
				{ 3, 113992, 167950 },	-- Research: Warbinder's Ink (Learnt by item 111923)
				{ 4, 113111, 178497 },	-- Warbinder's Ink (Learnt by item 111923)
				{ 6, 119297, 177045 },	-- Secrets of Draenor Inscription (Learnt by item 111923)
			},
		},
		{	--InscriptionOffHand
			name = AL["Off-Hands"],
			[WOD_DIFF] = {
				{ 1, "113270:Stage3W", 166367 },	-- Shadowtome (Stage 3)
				{ 2, "113270:Stage2W", 166366 },	-- Shadowtome (Stage 2)
				{ 3, "113270:Stage1", 166363, [PRICE_EXTRA_ITTYPE] = "119297:1" },	-- Shadowtome (Stage 1) (Sold, Ashran)
			},
		},
		{	--InscriptionStaves
			name = AL["Staves"],
			[WOD_DIFF] = {
				{ 1, "113134:Stage3W", 166367 },	-- Crystalfire Spellstaff (Stage 3)
				{ 2, "113134:Stage2W", 166366 },	-- Crystalfire Spellstaff (Stage 2)
				{ 3, "113134:Stage1", 166356, [PRICE_EXTRA_ITTYPE] = "119297:1" },	-- Crystalfire Spellstaff (Stage 1) (Sold, Ashran)
				{ 5, "111526:Stage3W", 166367 },	-- Etched-Blade Warstaff (Stage 3)
				{ 6, "111526:Stage2W", 166366 },	-- Etched-Blade Warstaff (Stage 2)
				{ 7, "111526:Stage1", 166359, [PRICE_EXTRA_ITTYPE] = "119297:1" },	-- Etched-Blade Warstaff (Stage 1) (Sold, Ashran)
				{ 9, "113131:Stage3W", 166367 },	-- Warmaster's Firestick (Stage 3)
				{ 10, "113131:Stage2W", 166366 },	-- Warmaster's Firestick (Stage 2)
				{ 11, "113131:Stage1", 165804, [PRICE_EXTRA_ITTYPE] = "119297:1" },	-- Warmaster's Firestick (Stage 1) (Sold, Ashran)
			},
		},
		{	--InscriptionTrinkets
			name = AL["Trinkets"],
			[WOD_DIFF] = {
				{ 1, 112270, 163294, [PRICE_EXTRA_ITTYPE] = "119297:5" },	-- Darkmoon Card of Draenor (Sold, Ashran)
				{ 3, 112303 },	-- Iron Deck
				{ 4, "112319:Stage3", 178249 },	-- Knight's Badge (Stage 3)
				{ 5, "112319:Stage2", 178248 },	-- Knight's Badge (Stage 2)
				{ 6, "112319:Stage1" },	-- Knight's Badge (Stage 1)
				{ 8, 112304 },	-- Moon Deck
				{ 9, "112320:Stage3", 178249 },	-- Sandman's Pouch (Stage 3)
				{ 10, "112320:Stage2", 178248 },	-- Sandman's Pouch (Stage 2)
				{ 11, "112320:Stage1" },	-- Sandman's Pouch (Stage 1)
				{ 18, 112305 },	-- Visions Deck
				{ 19, "112317:Stage3", 178249 },	-- Winged Hourglass (Stage 3)
				{ 20, "112317:Stage2", 178248 },	-- Winged Hourglass (Stage 2)
				{ 21, "112317:Stage1" },	-- Winged Hourglass (Stage 1)
				{ 23, 112306 },	-- War Deck
				{ 24, "112318:Stage3", 178249 },	-- Skull of War (Stage 3)
				{ 25, "112318:Stage2", 178248 },	-- Skull of War (Stage 2)
				{ 26, "112318:Stage1" },	-- Skull of War (Stage 1)
				{ 101, 118603, 175392 },	-- Savage Tarot (Learnt by item 111923)
				{ 102, 118602, 175390 },	-- Laughing Tarot (Learnt by item 111923)
				{ 103, 118601, 175389 },	-- Ocean Tarot (Learnt by item 111923)
			},
		},
		{	--InscriptionMisc
			name = AL["Miscellaneous"],
			[WOD_DIFF] = {
				{ 1, 113355, 166669 },	-- Card of Omens (Learnt by item 111923)
				{ 16, 113144, 166366, [PRICE_EXTRA_ITTYPE] = "119297:5" },	-- Mystical Crystal (Sold, Ashran)
				{ 17, 113183, 166367, [PRICE_EXTRA_ITTYPE] = "119297:5" },	-- Glorious Crystal (Sold, Ashran)
				{ 19, 120263, 178248, [PRICE_EXTRA_ITTYPE] = "119297:5" },	-- Inferno Tarot (Sold, Ashran)
				{ 20, 120264, 178249, [PRICE_EXTRA_ITTYPE] = "119297:5" },	-- Molten Tarot (Sold, Ashran)
				{ 22, 113289, 166432, [PRICE_EXTRA_ITTYPE] = "119297:1" },	-- Volatile Crystal (Sold, Ashran)
			},
		},
	}
}

data["Jewelcrafting"] = {
	name = GetSpellInfo(25229),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--JewelRed
			name = AL["Red Gems"],
			[MOP_DIFF] = {
				{ 1, 76696, 107705 }, --=q3=Bold Primordial Ruby : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131686
				{ 2, 76694, 107706 }, --=q3=Brilliant Primordial Ruby : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131686
				{ 3, 76692, 107707 }, --=q3=Delicate Primordial Ruby : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131686
				{ 4, 76695, 107708 }, --=q3=Flashing Primordial Ruby : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131686
				{ 5, 76693, 107709 }, --=q3=Precise Primordial Ruby : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131686
				{ 16, 76564, 107622 }, --=q2=Bold Pandarian Garnet : =ds=#sr# 570 : =ds=AtlasLoot["Trainer"]
				{ 17, 76562, 107623 }, --=q2=Brilliant Pandarian Garnet : =ds=#sr# 560 : =ds=AtlasLoot["Trainer"]
				{ 18, 76563, 107625 }, --=q2=Flashing Pandarian Garnet : =ds=#sr# 550 : =ds=AtlasLoot["Trainer"]
				{ 19, 76561, 107626 }, --=q2=Precise Pandarian Garnet : =ds=#sr# 540 : =ds=AtlasLoot["Trainer"]
				{ 20, 76560, 107622 }, --=q2=Delicate Pandarian Garnet : =ds=#sr# 530 : =ds=AtlasLoot["Trainer"]
			},
			[CATA_DIFF] = {
				{ 1, 71883, 101799 }, --=q4=Bold Queen's Garnet : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 2, 71881, 101797 }, --=q4=Brilliant Queen's Garnet : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 3, 71879, 101795 }, --=q4=Delicate Queen's Garnet : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 4, 71882, 101798 }, --=q4=Flashing Queen's Garnet : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 5, 71880, 101796 }, --=q4=Precise Queen's Garnet : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 7, 52206, 73335 }, --=q3=Bold Inferno Ruby : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 8, 52207, 73338 }, --=q3=Brilliant Inferno Ruby : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 9, 52212, 73336 }, --=q3=Delicate Inferno Ruby : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 10, 52216, 73337 }, --=q3=Flashing Inferno Ruby : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 11, 52230, 73339 }, --=q3=Precise Inferno Ruby : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 16, 52081, 73222 }, --=q2=Bold Carnelian : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 17, 52084, 73225 }, --=q2=Brilliant Carnelian : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 18, 52082, 73223 }, --=q2=Delicate Carnelian : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 19, 52083, 73224 }, --=q2=Flashing Carnelian : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 20, 52085, 73226 }, --=q2=Precise Carnelian : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
			},
			[WOTLK_DIFF] = {
				{ 1, 40111, 66447 }, --=q4=Bold Cardinal Ruby : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 2, 40113, 66446 }, --=q4=Brilliant Cardinal Ruby : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 3, 40112, 66448 }, --=q4=Delicate Cardinal Ruby : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 4, 40116, 66453 }, --=q4=Flashing Cardinal Ruby : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 5, 40118, 66450 }, --=q4=Precise Cardinal Ruby : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 7, 39996, 53830 }, --=q3=Bold Scarlet Ruby : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 8, 39998, 53946 }, --=q3=Brilliant Scarlet Ruby : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Kirin Tor"] - AtlasLoot["Exalted"]
				{ 9, 39997, 53945 }, --=q3=Delicate Scarlet Ruby : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 10, 40001, 53949 }, --=q3=Flashing Scarlet Ruby : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 11, 40003, 53951 }, --=q3=Precise Scarlet Ruby : =ds=#sr# 390 : =ds=Herald Volazj584 (AtlasLoot["Heroic"])
				{ 16, 39900, 53831 }, --=q2=Bold Bloodstone : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 17, 39912, 53852 }, --=q2=Brilliant Bloodstone : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 18, 39905, 53832 }, --=q2=Delicate Bloodstone : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 19, 39908, 53844 }, --=q2=Flashing Bloodstone : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 20, 39910, 54017 }, --=q2=Precise Bloodstone : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
			},
			[BC_DIFF] = {
				{ 1, 32193, 39705 }, --=q4=Bold Crimson Spinel : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Friendly"]
				{ 2, 32196, 39711 }, --=q4=Brilliant Crimson Spinel : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Friendly"]
				{ 3, 32194, 39706 }, --=q4=Delicate Crimson Spinel : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Friendly"]
				{ 4, 32199, 39714 }, --=q4=Flashing Crimson Spinel : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 6, 33131, 42589 }, --=q4=Crimson Sun : =ds=#sr# 360 : =ds=AtlasLoot_IngameLocales["The Consortium"] - AtlasLoot["Revered"]
				{ 7, 33133, 42558 }, --=q4=Don Julio's Heart : =ds=#sr# 360 : =ds=AtlasLoot_IngameLocales["The Consortium"] - AtlasLoot["Revered"]
				{ 8, 33134, 42588 }, --=q4=Kailee's Rose : =ds=#sr# 360 : =ds=AtlasLoot_IngameLocales["The Sha'tar"] - AtlasLoot["Honored"]
				{ 16, 24027, 31084 }, --=q3=Bold Living Ruby : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 17, 24030, 31088 }, --=q3=Brilliant Living Ruby : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 18, 24028, 31085 }, --=q3=Delicate Living Ruby : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 19, 24036, 31091 }, --=q3=Flashing Living Ruby : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 21, 23095, 28905 }, --=q2=Bold Blood Garnet : =ds=#sr# 305 : =ds=AtlasLoot["Trainer"]
				{ 22, 23094, 28903 }, --=q2=Brilliant Blood Garnet : =ds=#sr# 305 : =ds=AtlasLoot_IngameLocales["The Scryers"] - AtlasLoot["Friendly"]
				{ 23, 28595, 34590 }, --=q2=Delicate Blood Garnet : =ds=#sr# 305 : =ds=AtlasLoot["Trainer"]
			},
		},
		{	--JewelBlue
			name = AL["Blue Gems"],
			[MOP_DIFF] = {
				{ 1, 76636, 106947 }, --=q3=Rigid River's Heart : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131593
				{ 2, 76639, 106950 }, --=q3=Solid River's Heart : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131593
				{ 3, 76638, 106949 }, --=q3=Sparkling River's Heart : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131593
				{ 4, 76637, 106948 }, --=q3=Stormy River's Heart : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131593
				{ 16, 76504, 107621 }, --=q2=Stormy Lapis Lazuli : =ds=#sr# 555 : =ds=AtlasLoot["Trainer"]
				{ 17, 76505, 107620 }, --=q2=Sparkling Lapis Lazuli : =ds=#sr# 545 : =ds=AtlasLoot["Trainer"]
				{ 18, 76506, 107619 }, --=q2=Solid Lapis Lazuli : =ds=#sr# 535 : =ds=AtlasLoot["Trainer"]
				{ 19, 76502, 107617 }, --=q2=Rigid Lapis Lazuli : =ds=#sr# 525 : =ds=AtlasLoot["Trainer"]
			},
			[CATA_DIFF] = {
				{ 1, 71817, 101735 }, --=q4=Rigid Deepholm Iolite : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 2, 71820, 101742 }, --=q4=Solid Deepholm Iolite : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 3, 71819, 101741 }, --=q4=Sparkling Deepholm Iolite : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 4, 71818, 101740 }, --=q4=Stormy Deepholm Iolite : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 6, 52235, 73344 }, --=q3=Rigid Ocean Sapphire : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 7, 52242, 73340 }, --=q3=Solid Ocean Sapphire : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 8, 52244, 73341 }, --=q3=Sparkling Ocean Sapphire : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 9, 52246, 73343 }, --=q3=Stormy Ocean Sapphire : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 16, 52089, 73230 }, --=q2=Rigid Zephyrite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 17, 52086, 73227 }, --=q2=Solid Zephyrite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 18, 52087, 73228 }, --=q2=Sparkling Zephyrite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 19, 52088, 73229 }, --=q2=Stormy Zephyrite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
			},
			[WOTLK_DIFF] = {
				{ 1, 40125, 66501 }, --=q4=Rigid Majestic Zircon : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 2, 40119, 66497 }, --=q4=Solid Majestic Zircon : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 3, 40120, 66498 }, --=q4=Sparkling Majestic Zircon : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 4, 40122, 66499 }, --=q4=Stormy Majestic Zircon : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 6, 40014, 53958 }, --=q3=Rigid Sky Sapphire : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 7, 40008, 53952 }, --=q3=Solid Sky Sapphire : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 8, 40010, 53954 }, --=q3=Sparkling Sky Sapphire : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 9, 40011, 53955 }, --=q3=Stormy Sky Sapphire : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 16, 39915, 53854 }, --=q2=Rigid Chalcedony : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 17, 39919, 53934 }, --=q2=Solid Chalcedony : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 18, 39927, 53941 }, --=q2=Sparkling Chalcedony : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 19, 39932, 53943 }, --=q2=Stormy Chalcedony : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
			},
			[BC_DIFF] = {
				{ 1, 32206, 39721 }, --=q4=Rigid Empyrean Sapphire : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 2, 32200, 39715 }, --=q4=Solid Empyrean Sapphire : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Friendly"]
				{ 3, 32201, 39716 }, --=q4=Sparkling Empyrean Sapphire : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Friendly"]
				{ 4, 32203, 39718 }, --=q4=Stormy Empyrean Sapphire : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 5, 33135, 42590 }, --=q4=Falling Star : =ds=#sr# 360 : =ds=AtlasLoot_IngameLocales["Lower City"] - AtlasLoot["Revered"]
				{ 7, 24051, 31098 }, --=q3=Rigid Star of Elune : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 8, 24033, 31092 }, --=q3=Solid Star of Elune : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 9, 24035, 31149 }, --=q3=Sparkling Star of Elune : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 10, 24039, 31095 }, --=q3=Stormy Star of Elune : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 16, 23116, 28948 }, --=q2=Rigid Azure Moonstone : =ds=#sr# 325 : =ds=AtlasLoot["Trainer"]
				{ 17, 23120, 28955 }, --=q2=Stormy Azure Moonstone : =ds=#sr# 315 : =ds=AtlasLoot["World Drop"]
				{ 18, 23118, 28950 }, --=q2=Solid Azure Moonstone : =ds=#sr# 305 : =ds=AtlasLoot["Trainer"]
				{ 19, 23119, 28953 }, --=q2=Sparkling Azure Moonstone : =ds=#sr# 300 : =ds=AtlasLoot["Trainer"]
			},
		},
		{	--JewelYellow
			name = AL["Yellow Gems"],
			[MOP_DIFF] = {
				{ 1, 76700, 107710 }, --=q3=Fractured Sun's Radiance : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131695
				{ 2, 76701, 107711 }, --=q3=Mystic Sun's Radiance : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131695
				{ 3, 76699, 107712 }, --=q3=Quick Sun's Radiance : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131695
				{ 4, 76697, 107713 }, --=q3=Smooth Sun's Radiance : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131695
				{ 5, 76698, 107714 }, --=q3=Subtle Sun's Radiance : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131695
				{ 16, 76566, 107644 }, --=q2=Subtle Sunstone : =ds=#sr# 575 : =ds=AtlasLoot["Trainer"]
				{ 17, 76565, 107643 }, --=q2=Smooth Sunstone : =ds=#sr# 565 : =ds=AtlasLoot["Trainer"]
				{ 18, 76567, 107642 }, --=q2=Quick Sunstone : =ds=#sr# 555 : =ds=AtlasLoot["Trainer"]
				{ 19, 76569, 107641 }, --=q2=Mystic Sunstone : =ds=#sr# 545 : =ds=AtlasLoot["Trainer"]
				{ 20, 76568, 107640 }, --=q2=Fractured Sunstone : =ds=#sr# 535 : =ds=AtlasLoot["Trainer"]
			},
			[CATA_DIFF] = {
				{ 1, 71877, 101803 }, --=q4=Fractured Lightstone : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 2, 71878, 101804 }, --=q4=Mystic Lightstone : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 3, 71876, 101802 }, --=q4=Quick Lightstone : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 4, 71874, 101800 }, --=q4=Smooth Lightstone : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 5, 71875, 101801 }, --=q4=Subtle Lightstone : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 7, 52219, 73349 }, --=q3=Fractured Amberjewel : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 8, 52226, 73347 }, --=q3=Mystic Amberjewel : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 9, 52232, 73348 }, --=q3=Quick Amberjewel : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 10, 52241, 73346 }, --=q3=Smooth Amberjewel : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 11, 52247, 73345 }, --=q3=Subtle Amberjewel : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 16, 52094, 73239 }, --=q2=Fractured Alicite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 17, 52093, 73234 }, --=q2=Quick Alicite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 18, 52091, 73232 }, --=q2=Smooth Alicite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 19, 52090, 73231 }, --=q2=Subtle Alicite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
			},
			[WOTLK_DIFF] = {
				{ 1, 40127, 66505 }, --=q4=Mystic King's Amber : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 2, 40128, 66506 }, --=q4=Quick King's Amber : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 3, 40124, 66502 }, --=q4=Smooth King's Amber : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 4, 40115, 66452 }, --=q4=Subtle King's Amber : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 6, 40016, 53960 }, --=q3=Mystic Autumn's Glow : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 7, 40017, 53961 }, --=q3=Quick Autumn's Glow : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 8, 40013, 53957 }, --=q3=Smooth Autumn's Glow : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["The Sons of Hodir"] - AtlasLoot["Exalted"]
				{ 9, 40000, 53948 }, --=q3=Subtle Autumn's Glow : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 16, 39917, 53857 }, --=q2=Mystic Sun Crystal : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 17, 39918, 53856 }, --=q2=Quick Sun Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 18, 39909, 53845 }, --=q2=Smooth Sun Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 19, 39907, 53843 }, --=q2=Subtle Sun Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
			},
			[BC_DIFF] = {
				{ 1, 32209, 39724 }, --=q4=Mystic Lionseye : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 2, 35761, 47056 }, --=q4=Quick Lionseye : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 3, 32205, 39720 }, --=q4=Smooth Lionseye : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Friendly"]
				{ 4, 32198, 39713 }, --=q4=Subtle Lionseye : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Friendly"]
				{ 6, 33140, 42592 }, --=q4=Blood of Amber : =ds=#sr# 360 : =ds=AtlasLoot_IngameLocales["The Sha'tar"] - AtlasLoot["Revered"]
				{ 7, 33144, 42593 }, --=q4=Facet of Eternity : =ds=#sr# 360 : =ds=AtlasLoot_IngameLocales["Keepers of Time"] - AtlasLoot["Honored"]
				{ 8, 33143, 42591 }, --=q4=Stone of Blades : =ds=#sr# 360 : =ds=AtlasLoot_IngameLocales["Keepers of Time"] - AtlasLoot["Revered"]
				{ 16, 24053, 31101 }, --=q3=Mystic Dawnstone : =ds=#sr# 350 : =ds=AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Nagrand"]
				{ 17, 35315, 46403 }, --=q3=Quick Dawnstone : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 18, 24048, 31097 }, --=q3=Smooth Dawnstone : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 19, 24032, 31090 }, --=q3=Subtle Dawnstone : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 21, 23114, 28944 }, --=q2=Smooth Golden Draenite : =ds=#sr# 325 : =ds=AtlasLoot_IngameLocales["The Aldor"] - AtlasLoot["Friendly"]
				{ 22, 23115, 28947 }, --=q2=Subtle Golden Draenite : =ds=#sr# 315 : =ds=AtlasLoot_IngameLocales["The Consortium"] - AtlasLoot["Honored"]
			},
		},
		{	--JewelOrange
			name = AL["Orange Gems"],
			[MOP_DIFF] = {
				{ 1, 76670, 107715 }, --=q3=Adept Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 2, 76672, 107716 }, --=q3=Artful Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 3, 76665, 107717 }, --=q3=Champion's Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 4, 76659, 107718 }, --=q3=Crafty Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 5, 76658, 107719 }, --=q3=Deadly Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 6, 76666, 107720 }, --=q3=Deft Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 7, 76669, 107721 }, --=q3=Fierce Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 8, 76673, 107722 }, --=q3=Fine Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 9, 76661, 107723 }, --=q3=Inscribed Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 10, 76671, 107724 }, --=q3=Keen Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 11, 76675, 107725 }, --=q3=Lucent Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 16, 76662, 107726 }, --=q3=Polished Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 17, 76660, 107727 }, --=q3=Potent Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 18, 76668, 107728 }, --=q3=Reckless Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 19, 76663, 107729 }, --=q3=Resolute Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 20, 76679, 107730 }, --=q3=Resplendent Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 21, 76674, 107731 }, --=q3=Skillful Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 22, 76678, 107732 }, --=q3=Splendid Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 23, 76664, 107733 }, --=q3=Stalwart Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 24, 76676, 107734 }, --=q3=Tenuous Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 25, 76667, 107735 }, --=q3=Wicked Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 26, 76677, 107736 }, --=q3=Willful Vermilion Onyx : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131690
				{ 101, 76531, 107659 }, --=q2=Resolute Tiger Opal : =ds=#sr# 575 : =ds=AtlasLoot["Trainer"]
				{ 102, 76547, 107660 }, --=q2=Resplendent Tiger Opal : =ds=#sr# 575 : =ds=AtlasLoot["Trainer"]
				{ 103, 76546, 107662 }, --=q2=Splendid Tiger Opal : =ds=#sr# 570 : =ds=AtlasLoot["Trainer"]
				{ 104, 76535, 107666 }, --=q2=Wicked Tiger Opal : =ds=#sr# 570 : =ds=AtlasLoot["Trainer"]
				{ 105, 76527, 107648 }, --=q2=Crafty Tiger Opal : =ds=#sr# 565 : =ds=AtlasLoot["Trainer"]
				{ 106, 76532, 107663 }, --=q2=Stalwart Tiger Opal : =ds=#sr# 565 : =ds=AtlasLoot["Trainer"]
				{ 107, 76528, 107657 }, --=q2=Potent Tiger Opal : =ds=#sr# 560 : =ds=AtlasLoot["Trainer"]
				{ 108, 76542, 107661 }, --=q2=Skillful Tiger Opal : =ds=#sr# 560 : =ds=AtlasLoot["Trainer"]
				{ 109, 76537, 107651 }, --=q2=Fierce Tiger Opal : =ds=#sr# 555 : =ds=AtlasLoot["Trainer"]
				{ 110, 76529, 107653 }, --=q2=Inscribed Tiger Opal : =ds=#sr# 555 : =ds=AtlasLoot["Trainer"]
				{ 111, 76538, 107645 }, --=q2=Adept Tiger Opal : =ds=#sr# 550 : =ds=AtlasLoot["Trainer"]
				{ 116, 76544, 107665 }, --=q2=Tenuous Tiger Opal : =ds=#sr# 550 : =ds=AtlasLoot["Trainer"]
				{ 117, 76533, 107647 }, --=q2=Champion's Tiger Opal : =ds=#sr# 545 : =ds=AtlasLoot["Trainer"]
				{ 118, 76530, 107656 }, --=q2=Polished Tiger Opal : =ds=#sr# 545 : =ds=AtlasLoot["Trainer"]
				{ 119, 76543, 107655 }, --=q2=Lucent Tiger Opal : =ds=#sr# 540 : =ds=AtlasLoot["Trainer"]
				{ 120, 76536, 107658 }, --=q2=Reckless Tiger Opal : =ds=#sr# 540 : =ds=AtlasLoot["Trainer"]
				{ 121, 76541, 107652 }, --=q2=Fine Tiger Opal : =ds=#sr# 535 : =ds=AtlasLoot["Trainer"]
				{ 122, 76545, 107667 }, --=q2=Willful Tiger Opal : =ds=#sr# 535 : =ds=AtlasLoot["Trainer"]
				{ 123, 76534, 107650 }, --=q2=Deft Tiger Opal : =ds=#sr# 530 : =ds=AtlasLoot["Trainer"]
				{ 124, 76539, 107654 }, --=q2=Keen Tiger Opal : =ds=#sr# 530 : =ds=AtlasLoot["Trainer"]
				{ 125, 76540, 107646 }, --=q2=Artful Tiger Opal : =ds=#sr# 525 : =ds=AtlasLoot["Trainer"]
				{ 126, 76526, 107649 }, --=q2=Deadly Tiger Opal : =ds=#sr# 525 : =ds=AtlasLoot["Trainer"]
			},
			[CATA_DIFF] = {
				{ 1, 71852, 101773 }, --=q4=Adept Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 2, 71854, 101775 }, --=q4=Artful Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 3, 71847, 101768 }, --=q4=Champion's Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 4, 71841, 101762 }, --=q4=Crafty Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 5, 71840, 101761 }, --=q4=Deadly Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 6, 71848, 101769 }, --=q4=Deft Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 7, 71851, 101772 }, --=q4=Fierce Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 8, 71855, 101776 }, --=q4=Fine Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 9, 71843, 101764 }, --=q4=Inscribed Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 10, 71853, 101774 }, --=q4=Keen Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 11, 71857, 101778 }, --=q4=Lucent Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 16, 71844, 101765 }, --=q4=Polished Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 17, 71842, 101763 }, --=q4=Potent Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 18, 71850, 101771 }, --=q4=Reckless Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 19, 71845, 101766 }, --=q4=Resolute Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 20, 71861, 101782 }, --=q4=Resplendent Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 21, 71856, 101777 }, --=q4=Skillful Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 22, 71860, 101781 }, --=q4=Splendid Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 23, 71846, 101767 }, --=q4=Stalwart Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 24, 71858, 101779 }, --=q4=Tenuous Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 25, 71849, 101770 }, --=q4=Wicked Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 26, 71859, 101780 }, --=q4=Willful Lava Coral : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 101, 52204, 73371 }, --=q3=Adept Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 102, 52205, 73373 }, --=q3=Artful Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 103, 52209, 73365 }, --=q3=Deadly Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 104, 52211, 73368 }, --=q3=Deft Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 105, 52214, 73367 }, --=q3=Fierce Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 106, 52215, 73372 }, --=q3=Fine Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 107, 52222, 73364 }, --=q3=Inscribed Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 108, 52224, 73374 }, --=q3=Keen Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 110, 52115, 73268 }, --=q2=Adept Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 111, 52117, 73270 }, --=q2=Artful Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 112, 52109, 73262 }, --=q2=Deadly Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 113, 52112, 73265 }, --=q2=Deft Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 114, 52111, 73264 }, --=q2=Fierce Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 115, 52116, 73269 }, --=q2=Fine Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 116, 68357, 95755 }, --=q3=Lucent Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 117, 52229, 73361 }, --=q3=Polished Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 118, 52239, 73366 }, --=q3=Potent Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 119, 52208, 73369 }, --=q3=Reckless Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 120, 52249, 73362 }, --=q3=Resolute Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 121, 68358, 95756 }, --=q3=Resplendent Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 122, 52240, 73370 }, --=q3=Skillful Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 123, 68356, 95754 }, --=q3=Willful Ember Topaz : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 125, 52108, 73260 }, --=q2=Inscribed Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 126, 52118, 73271 }, --=q2=Keen Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 127, 52106, 73258 }, --=q2=Polished Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 128, 52110, 73263 }, --=q2=Potent Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 129, 52113, 73266 }, --=q2=Reckless Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 130, 52114, 73267 }, --=q2=Skillful Hessonite : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
			},
			[WOTLK_DIFF] = {
				{ 1, 40144, 66579 }, --=q4=Champion's Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 2, 40147, 66568 }, --=q4=Deadly Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 3, 40150, 66584 }, --=q4=Deft Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 4, 40146, 66583 }, --=q4=Fierce Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 5, 40142, 66567 }, --=q4=Inscribed Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 6, 40149, 66585 }, --=q4=Lucent Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 7, 40152, 66569 }, --=q4=Potent Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 8, 40155, 66574 }, --=q4=Reckless Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 9, 40163, 66586 }, --=q4=Resolute Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 10, 40145, 66582 }, --=q4=Resplendent Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 11, 40160, 66581 }, --=q4=Stalwart Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 12, 40154, 66571 }, --=q4=Willful Ametrine : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 16, 40039, 53977 }, --=q3=Champion's Monarch Topaz : =ds=#sr# 390 : =ds=AtlasLoot["World Drop"]
				{ 17, 40043, 53979 }, --=q3=Deadly Monarch Topaz : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Knights of the Ebon Blade"] - AtlasLoot["Revered"]
				{ 18, 40055, 53991 }, --=q3=Deft Monarch Topaz : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 19, 40041, 54019 }, --=q3=Fierce Monarch Topaz : =ds=#sr# 390 : =ds=Ingvar the Plunderer640 (AtlasLoot["Heroic"])
				{ 20, 40037, 53975 }, --=q3=Inscribed Monarch Topaz : =ds=#sr# 390 : =ds=AtlasLoot["World Drop"]
				{ 21, 40045, 53981 }, --=q3=Lucent Monarch Topaz : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 22, 40048, 53984 }, --=q3=Potent Monarch Topaz : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 23, 40051, 53987 }, --=q3=Reckless Monarch Topaz : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 24, 40059, 54023 }, --=q3=Resolute Monarch Topaz : =ds=#sr# 390 : =ds=AtlasLoot["World Drop"]
				{ 25, 40040, 53978 }, --=q3=Resplendent Monarch Topaz : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 26, 40057, 53993 }, --=q3=Stalwart Monarch Topaz : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["The Wyrmrest Accord"] - AtlasLoot["Exalted"]
				{ 27, 40050, 53986 }, --=q3=Willful Monarch Topaz : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 101, 39949, 53874 }, --=q2=Champion's Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 102, 39952, 53877 }, --=q2=Deadly Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["Knights of the Ebon Blade"] - AtlasLoot["Friendly"]
				{ 103, 39955, 53880 }, --=q2=Deft Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 104, 39951, 53876 }, --=q2=Fierce Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 105, 39947, 53872 }, --=q2=Inscribed Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 106, 39954, 53879 }, --=q2=Lucent Huge Citrine : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 107, 39956, 53882 }, --=q2=Potent Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 108, 39959, 53885 }, --=q2=Reckless Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["Frenzyheart Tribe"] - AtlasLoot["Friendly"]
				{ 109, 39967, 53893 }, --=q2=Resolute Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 110, 39950, 53875 }, --=q2=Resplendent Huge Citrine : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 111, 39965, 53891 }, --=q2=Stalwart Huge Citrine : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 112, 39958, 53884 }, --=q2=Willful Huge Citrine : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
			},
			[BC_DIFF] = {
				{ 1, 32222, 39738 }, --=q4=Deadly Pyrestone : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 2, 32217, 39733 }, --=q4=Inscribed Pyrestone : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 3, 32218, 39734 }, --=q4=Potent Pyrestone : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Honored"]
				{ 4, 35760, 47055 }, --=q4=Reckless Pyrestone : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Honored"]
				{ 6, 31868, 39471 }, --=q3=Deadly Noble Topaz : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 7, 24058, 31106 }, --=q3=Inscribed Noble Topaz : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 8, 24059, 31107 }, --=q3=Potent Noble Topaz : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 9, 24060, 31108 }, --=q3=Reckless Noble Topaz : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 16, 31869, 39467 }, --=q2=Deadly Flame Spessarite : =ds=#sr# 325 : =ds=AtlasLoot["Drop"]: AtlasLoot_IngameLocales["Blade's Edge Mountains"]
				{ 17, 23101, 28915 }, --=q2=Potent Flame Spessarite : =ds=#sr# 325 : =ds=AtlasLoot_IngameLocales["Lower City"] - AtlasLoot["Friendly"]
				{ 18, 23099, 28912 }, --=q2=Reckless Flame Spessarite : =ds=#sr# 305 : =ds=AtlasLoot_IngameLocales["The Consortium"] - AtlasLoot["Friendly"]
				{ 19, 23098, 28910 }, --=q2=Inscribed Flame Spessarite : =ds=#sr# 300 : =ds=AtlasLoot["Trainer"]
			},
		},
		{	--JewelGreen
			name = AL["Green Gems"],
			[MOP_DIFF] = {
				{ 1, 76646, 106960 }, --=q3=Balanced Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 2, 76644, 106957 }, --=q3=Effulgent Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 3, 76651, 107737 }, --=q3=Energized Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 4, 76654, 107738 }, --=q3=Forceful Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 5, 76652, 107739 }, --=q3=Jagged Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 6, 76642, 106955 }, --=q3=Lightning Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 7, 76640, 106953 }, --=q3=Misty Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 8, 76655, 107740 }, --=q3=Nimble Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 9, 76641, 106954 }, --=q3=Piercing Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 16, 76656, 107742 }, --=q3=Puissant Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 17, 76649, 107743 }, --=q3=Radiant Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 18, 76653, 107744 }, --=q3=Regal Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 19, 76643, 106956 }, --=q3=Sensei's Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 20, 76650, 107745 }, --=q3=Shattered Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 21, 76657, 107746 }, --=q3=Steady Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 22, 76648, 106962 }, --=q3=Turbid Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 23, 76647, 106961 }, --=q3=Vivid Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 24, 76645, 106958 }, --=q3=Zen Wild Jade : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131688
				{ 101, 76517, 107609 }, --=q2=Radiant Alexandrite : =ds=#sr# 575 : =ds=AtlasLoot["Trainer"]
				{ 102, 76524, 107608 }, --=q2=Puissant Alexandrite : =ds=#sr# 570 : =ds=AtlasLoot["Trainer"]
				{ 103, 76522, 107601 }, --=q2=Forceful Alexandrite : =ds=#sr# 565 : =ds=AtlasLoot["Trainer"]
				{ 104, 76519, 107607 }, --=q2=Energized Alexandrite : =ds=#sr# 560 : =ds=AtlasLoot["Trainer"]
				{ 105, 76508, 107607 }, --=q2=Piercing Alexandrite : =ds=#sr# 555 : =ds=AtlasLoot["Trainer"]
				{ 106, 76525, 107613 }, --=q2=Steady Alexandrite : =ds=#sr# 555 : =ds=AtlasLoot["Trainer"]
				{ 107, 76513, 107598 }, --=q2=Balanced Alexandrite : =ds=#sr# 550 : =ds=AtlasLoot["Trainer"]
				{ 108, 76511, 107599 }, --=q2=Effulgent Alexandrite : =ds=#sr# 550 : =ds=AtlasLoot["Trainer"]
				{ 109, 76510, 107611 }, --=q2=Sensei's Alexandrite : =ds=#sr# 545 : =ds=AtlasLoot["Trainer"]
				{ 116, 76515, 107614 }, --=q2=Turbid Alexandrite : =ds=#sr# 545 : =ds=AtlasLoot["Trainer"]
				{ 117, 76507, 107605 }, --=q2=Misty Alexandrite : =ds=#sr# 540 : =ds=AtlasLoot["Trainer"]
				{ 118, 76518, 107612 }, --=q2=Shattered Alexandrite : =ds=#sr# 540 : =ds=AtlasLoot["Trainer"]
				{ 119, 76521, 107610 }, --=q2=Regal Alexandrite : =ds=#sr# 535 : =ds=AtlasLoot["Trainer"]
				{ 120, 76512, 107616 }, --=q2=Zen Alexandrite : =ds=#sr# 535 : =ds=AtlasLoot["Trainer"]
				{ 121, 76520, 107602 }, --=q2=Jagged Alexandrite : =ds=#sr# 530 : =ds=AtlasLoot["Trainer"]
				{ 122, 76523, 107606 }, --=q2=Nimble Alexandrite : =ds=#sr# 530 : =ds=AtlasLoot["Trainer"]
				{ 123, 76509, 107604 }, --=q2=Lightning Alexandrite : =ds=#sr# 525 : =ds=AtlasLoot["Trainer"]
				{ 124, 76514, 107615 }, --=q2=Vivid Alexandrite : =ds=#sr# 525 : =ds=AtlasLoot["Trainer"]
			},
			[CATA_DIFF] = {
				{ 1, 71828, 101749 }, --=q4=Balanced Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 2, 71833, 101754 }, --=q4=Energized Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 3, 71836, 101757 }, --=q4=Forceful Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 4, 71826, 101747 }, --=q4=Infused Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 5, 71834, 101755 }, --=q4=Jagged Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 6, 71824, 101745 }, --=q4=Lightning Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 7, 71822, 101743 }, --=q4=Misty Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 8, 71837, 101758 }, --=q4=Nimble Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 9, 71823, 101744 }, --=q4=Piercing Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 16, 71838, 101759 }, --=q4=Puissant Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 17, 71831, 101752 }, --=q4=Radiant Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 18, 71835, 101756 }, --=q4=Regal Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 19, 71825, 101746 }, --=q4=Sensei's Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 20, 71832, 101753 }, --=q4=Shattered Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 21, 71839, 101760 }, --=q4=Steady Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 22, 71830, 101751 }, --=q4=Turbid Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 23, 71829, 101750 }, --=q4=Vivid Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 24, 71827, 101748 }, --=q4=Zen Elven Peridot : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 101, 52218, 73380 }, --=q3=Forceful Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 102, 52223, 73377 }, --=q3=Jagged Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 103, 52225, 73381 }, --=q3=Lightning Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 104, 52227, 73376 }, --=q3=Nimble Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 105, 52228, 73378 }, --=q3=Piercing Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 106, 52231, 73382 }, --=q3=Puissant Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 107, 52233, 73375 }, --=q3=Regal Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 108, 52237, 73384 }, --=q3=Sensei's Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 109, 52245, 73379 }, --=q3=Steady Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 110, 68741, 96226 }, --=q3=Vivid Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 111, 52250, 73383 }, --=q3=Zen Dream Emerald : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 116, 52124, 73277 }, --=q2=Forceful Jasper : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 117, 52121, 73274 }, --=q2=Jagged Jasper : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 118, 52125, 73278 }, --=q2=Lightning Jasper : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 119, 52120, 73273 }, --=q2=Nimble Jasper : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 120, 52122, 73275 }, --=q2=Piercing Jasper : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 121, 52126, 73279 }, --=q2=Puissant Jasper : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 122, 52119, 73272 }, --=q2=Regal Jasper : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 123, 52128, 73281 }, --=q2=Sensei's Jasper : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 124, 52123, 73276 }, --=q2=Steady Jasper : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 125, 52127, 73280 }, --=q2=Zen Jasper : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
			},
			[WOTLK_DIFF] = {
				{ 1, 40179, 66442 }, --=q4=Energized Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 2, 40169, 66434 }, --=q4=Forceful Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 3, 40165, 66431 }, --=q4=Jagged Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 4, 40177, 66439 }, --=q4=Lightning Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 5, 40171, 66435 }, --=q4=Misty Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 6, 40166, 66429 }, --=q4=Nimble Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 7, 40180, 66441 }, --=q4=Radiant Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 8, 40167, 66338 }, --=q4=Regal Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 9, 40182, 66443 }, --=q4=Shattered Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 10, 40168, 66428 }, --=q4=Steady Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 11, 40173, 66445 }, --=q4=Turbid Eye of Zul : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 16, 40105, 54011 }, --=q3=Energized Forest Emerald : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 17, 40091, 54001 }, --=q3=Forceful Forest Emerald : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 18, 40086, 53996 }, --=q3=Jagged Forest Emerald : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Frenzyheart Tribe"] - AtlasLoot["Revered"]
				{ 19, 40100, 54009 }, --=q3=Lightning Forest Emerald : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 20, 40095, 54003 }, --=q3=Misty Forest Emerald : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["The Oracles"] - AtlasLoot["Revered"]
				{ 21, 40088, 53997 }, --=q3=Nimble Forest Emerald : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 22, 40098, 54012 }, --=q3=Radiant Forest Emerald : =ds=#sr# 390 : =ds=AtlasLoot["Drop"]: AtlasLoot_IngameLocales["The Storm Peaks"]
				{ 23, 40089, 53998 }, --=q3=Regal Forest Emerald : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 24, 40106, 54014 }, --=q3=Shattered Forest Emerald : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 25, 40090, 54000 }, --=q3=Steady Forest Emerald : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 26, 40102, 54005 }, --=q3=Turbid Forest Emerald : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 101, 39983, 53925 }, --=q2=Energized Dark Jade : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 102, 39978, 53920 }, --=q2=Forceful Dark Jade : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 103, 39933, 53870 }, --=q2=Jagged Dark Jade : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 104, 39981, 53923 }, --=q2=Lightning Dark Jade : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 105, 39980, 53922 }, --=q2=Misty Dark Jade : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 106, 39975, 53917 }, --=q2=Nimble Dark Jade : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["The Oracles"] - AtlasLoot["Friendly"]
				{ 107, 39991, 53932 }, --=q2=Radiant Dark Jade : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 108, 39976, 53918 }, --=q2=Regal Dark Jade : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 109, 39992, 53933 }, --=q2=Shattered Dark Jade : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 110, 39977, 53919 }, --=q2=Steady Dark Jade : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 111, 39982, 53924 }, --=q2=Turbid Dark Jade : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
			},
			[BC_DIFF] = {
				{ 1, 35759, 47053 }, --=q4=Forceful Seaspray Emerald : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 2, 32226, 39742 }, --=q4=Jagged Seaspray Emerald : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Honored"]
				{ 3, 32224, 39740 }, --=q4=Radiant Seaspray Emerald : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Honored"]
				{ 4, 32223, 39739 }, --=q4=Regal Seaspray Emerald : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 5, 35758, 47054 }, --=q4=Steady Seaspray Emerald : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 7, 35318, 46405 }, --=q3=Forceful Talasite : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 8, 24067, 31113 }, --=q3=Jagged Talasite : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 9, 24066, 31111 }, --=q3=Radiant Talasite : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 10, 35707, 46803 }, --=q3=Regal Talasite : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 11, 33782, 43493 }, --=q3=Steady Talasite : =ds=#sr# 350 : =ds=#sr# AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Nagrand"]
				{ 16, 23105, 28918 }, --=q2=Regal Deep Peridot : =ds=#sr# 315 : =ds=AtlasLoot_IngameLocales["Honor Hold"] - AtlasLoot["Friendly"]
				--{ 16, 23105, 28918 }, --=q2=Regal Deep Peridot : =ds=#sr# 315 : =ds=AtlasLoot_IngameLocales["Thrallmar"] - AtlasLoot["Friendly"] Horde version
				{ 17, 23104, 28917 }, --=q2=Jagged Deep Peridot : =ds=#sr# 305 : =ds=AtlasLoot["Trainer"]
				{ 18, 23103, 28916 }, --=q2=Radiant Deep Peridot : =ds=#sr# 300 : =ds=AtlasLoot["Trainer"]
			},
		},
		{	--JewelPurple
			name = AL["Purple Gems"],
			[MOP_DIFF] = {
				{ 1, 89680, 130657 }, --=q3=Assassin's Imperial Amethyst : =ds=#sr# 600 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 2, 89674, 130658 }, --=q3=Tense Imperial Amethyst : =ds=#sr# 600 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 3, 76681, 107693 }, --=q3=Accurate Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 4, 76690, 107694 }, --=q3=Defender's Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 5, 76684, 107695 }, --=q3=Etched Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 6, 76680, 107696 }, --=q3=Glinting Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 7, 76688, 107697 }, --=q3=Guardian's Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 8, 76685, 107698 }, --=q3=Mysterious Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 9, 76686, 107699 }, --=q3=Purified Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 10, 76683, 107700 }, --=q3=Retaliating Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 11, 76687, 107701 }, --=q3=Shifting Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 12, 76691, 107702 }, --=q3=Sovereign Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 13, 76689, 107703 }, --=q3=Timeless Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 14, 76682, 107704 }, --=q3=Veiled Imperial Amethyst : =ds=#sr# 550 : =ds=AtlasLoot["Discovery"]: spell131691
				{ 16, 76551, 107635 }, --=q2=Retaliating Roguestone : =ds=#sr# 575 : =ds=AtlasLoot["Trainer"]
				{ 17, 89675, 130655 }, --=q2=Tense Roguestone : =ds=#sr# 570 : =ds=AtlasLoot["Trainer"]
				{ 18, 76554, 107634 }, --=q2=Purified Roguestone : =ds=#sr# 565 : =ds=AtlasLoot["Trainer"]
				{ 19, 76557, 107638 }, --=q2=Timeless Roguestone : =ds=#sr# 560 : =ds=AtlasLoot["Trainer"]
				{ 20, 76558, 107628 }, --=q2=Defender's Roguestone : =ds=#sr# 555 : =ds=AtlasLoot["Trainer"]
				{ 21, 76549, 107627 }, --=q2=Accurate Roguestone : =ds=#sr# 550 : =ds=AtlasLoot["Trainer"]
				{ 22, 76556, 107632 }, --=q2=Guardian's Roguestone : =ds=#sr# 545 : =ds=AtlasLoot["Trainer"]
				{ 23, 76548, 107631 }, --=q2=Glinting Roguestone : =ds=#sr# 540 : =ds=AtlasLoot["Trainer"]
				{ 24, 76555, 107636 }, --=q2=Shifting Roguestone : =ds=#sr# 535 : =ds=AtlasLoot["Trainer"]
				{ 25, 76559, 107637 }, --=q2=Sovereign Roguestone : =ds=#sr# 535 : =ds=AtlasLoot["Trainer"]
				{ 26, 89678, 130656 }, --=q2=Assassin's Roguestone : =ds=#sr# 530 : =ds=AtlasLoot["Trainer"]
				{ 27, 76550, 107639 }, --=q2=Veiled Roguestone : =ds=#sr# 530 : =ds=AtlasLoot["Trainer"]
				{ 28, 76552, 107630 }, --=q2=Etched Roguestone : =ds=#sr# 525 : =ds=AtlasLoot["Trainer"]
				{ 29, 76553, 107633 }, --=q2=Mysterious Roguestone : =ds=#sr# 525 : =ds=AtlasLoot["Trainer"]
			},
			[CATA_DIFF] = {
				{ 1, 71863, 101784 }, --=q4=Accurate Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 2, 71872, 101793 }, --=q4=Defender's Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 3, 71866, 101787 }, --=q4=Etched Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 4, 71862, 101783 }, --=q4=Glinting Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 5, 71870, 101791 }, --=q4=Guardian's Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 6, 71867, 101788 }, --=q4=Mysterious Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 7, 71868, 101789 }, --=q4=Purified Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 8, 71865, 101786 }, --=q4=Retaliating Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 9, 71869, 101790 }, --=q4=Shifting Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 10, 71873, 101794 }, --=q4=Sovereign Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 11, 71871, 101792 }, --=q4=Timeless Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 12, 71864, 101785 }, --=q4=Veiled Shadow Spinel : =ds=#sr# 525 : #CATAJW:5#AtlasLoot["Vendor"]
				{ 16, 52203, 73360 }, --=q3=Accurate Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 17, 52210, 73352 }, --=q3=Defender's Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 18, 52213, 73356 }, --=q3=Etched Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 19, 52220, 73357 }, --=q3=Glinting Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 20, 52221, 73354 }, --=q3=Guardian's Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 21, 52236, 73355 }, --=q3=Purified Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 22, 52234, 73358 }, --=q3=Retaliating Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 23, 52238, 73351 }, --=q3=Shifting Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 24, 52243, 73350 }, --=q3=Souvereign Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 25, 52248, 73353 }, --=q3=Timeless Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 26, 52217, 73359 }, --=q3=Veiled Demonseye : =ds=#sr# 465 : #CATAJW:3#AtlasLoot["Vendor"]
				{ 101, 52105, 73250 }, --=q2=Accurate Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 102, 52097, 73242 }, --=q2=Defender's Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 103, 52101, 73246 }, --=q2=Etched Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 104, 52102, 73247 }, --=q2=Glinting Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 105, 52099, 73244 }, --=q2=Guardian's Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 106, 52100, 73245 }, --=q2=Purified Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 107, 52103, 73248 }, --=q2=Retaliating Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["World Drop"]
				{ 108, 52096, 73241 }, --=q2=Shifting Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 109, 52095, 73240 }, --=q2=Souvereign Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 110, 52098, 73243 }, --=q2=Timeless Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
				{ 111, 52104, 73249 }, --=q2=Veiled Nightstone : =ds=#sr# 425 : =ds=AtlasLoot["Trainer"]
			},
			[WOTLK_DIFF] = {
				{ 1, 40162, 66576 }, --=q4=Accurate Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 2, 40139, 66560 }, --=q4=Defender's Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 3, 40143, 66572 }, --=q4=Etched Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 4, 40157, 66573 }, --=q4=Glinting Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 5, 40141, 66561 }, --=q4=Guardian's Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 6, 40135, 66562 }, --=q4=Mysterious Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 7, 40133, 66556 }, --=q4=Purified Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 8, 40130, 66557 }, --=q4=Shifting Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 9, 40129, 66554 }, --=q4=Sovereign Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 10, 40164, 66432 }, --=q4=Timeless Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 11, 40153, 66570 }, --=q4=Veiled Dreadstone : =ds=#sr# 450 : #DALARANJW:4#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 16, 40058, 53994 }, --=q3=Accurate Twilight Opal : =ds=#sr# 390 : =ds=AtlasLoot["Drop"]: AtlasLoot_IngameLocales["The Storm Peaks"]
				{ 17, 40032, 53972 }, --=q3=Defender's Twilight Opal : =ds=#sr# 390 : =ds=AtlasLoot["Drop"]: AtlasLoot_IngameLocales["The Storm Peaks"]
				{ 18, 40038, 53976 }, --=q3=Etched Twilight Opal : =ds=#sr# 390 : =ds=AtlasLoot["World Drop"]
				{ 19, 40044, 53980 }, --=q3=Glinting Twilight Opal : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 20, 40034, 53974 }, --=q3=Guardian's Twilight Opal : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Argent Crusade"] - AtlasLoot["Revered"]
				{ 21, 40028, 53968 }, --=q3=Mysterious Twilight Opal : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 22, 40026, 53966 }, --=q3=Purified Twilight Opal : =ds=#sr# 390 : =ds=AtlasLoot["World Drop"]
				{ 23, 40023, 53963 }, --=q3=Shifting Twilight Opal : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 24, 40022, 53962 }, --=q3=Sovereign Twilight Opal : =ds=#sr# 390 : =ds=AtlasLoot["World Drop"]
				{ 25, 40025, 53965 }, --=q3=Timeless Twilight Opal : =ds=#sr# 390 : =ds=AtlasLoot_IngameLocales["Knights of the Ebon Blade"] - AtlasLoot["Exalted"]
				{ 26, 40049, 53985 }, --=q3=Veiled Twilight Opal : =ds=#sr# 390 : #DALARANJW:3#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 101, 39966, 53892 }, --=q2=Accurate Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 102, 39939, 53869 }, --=q2=Defender's Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["The Kalu'ak"] - AtlasLoot["Honored"]
				{ 103, 39948, 53873 }, --=q2=Etched Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 104, 39942, 53861 }, --=q2=Glinting Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 105, 39940, 53871 }, --=q2=Guardian's Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 106, 39945, 53865 }, --=q2=Mysterious Shadow Crystal : =ds=#sr# 350 : #DALARANJW:1#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 107, 39979, 53921 }, --=q2=Purified Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot_IngameLocales["The Kalu'ak"] - AtlasLoot["Friendly"]
				{ 108, 39935, 53860 }, --=q2=Shifting Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 109, 39934, 53859 }, --=q2=Sovereign Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 110, 39968, 53894 }, --=q2=Timeless Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 111, 39957, 53883 }, --=q2=Veiled Shadow Crystal : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
			},
			[BC_DIFF] = {
				{ 1, 32220, 39736 }, --=q4=Glinting Shadowsong Amethyst : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Honored"]
				{ 2, 32225, 39741 }, --=q4=Purified Shadowsong Amethyst : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Honored"]
				{ 3, 32212, 39728 }, --=q4=Shifting Shadowsong Amethyst : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 4, 32211, 39727 }, --=q4=Sovereign Shadowsong Amethyst : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 5, 32215, 39731 }, --=q4=Timeless Shadowsong Amethyst : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Honored"]
				{ 6, 32221, 39737 }, --=q4=Veiled Shadowsong Amethyst : =ds=#sr# 375 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Exalted"]
				{ 8, 24061, 31109 }, --=q3=Glinting Nightseye : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 9, 24065, 31112 }, --=q3=Purified Nightseye : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 10, 24055, 31103 }, --=q3=Shifting Nightseye : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 11, 24054, 31102 }, --=q3=Sovereign Nightseye : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 12, 24056, 31104 }, --=q3=Timeless Nightseye : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 13, 31867, 39470 }, --=q3=Veiled Nightseye : =ds=#sr# 350 : =ds=AtlasLoot["World Drop"]
				{ 14, 32836, 41429 }, --=q3=Purified Shadow Pearl : =ds=#sr# 350 : =ds=AtlasLoot["Trainer"]
				{ 16, 32833, 41420 }, --=q2=Purified Jaggal Pearl : =ds=#sr# 325 : =ds=AtlasLoot["Trainer"]
				{ 17, 23110, 28933 }, --=q2=Shifting Shadow Draenite : =ds=#sr# 325 : =ds=AtlasLoot["Vendor"]
				{ 18, 23111, 28936 }, --=q2=Sovereign Shadow Draenite : =ds=#sr# 325 : =ds=AtlasLoot["Trainer"]
				{ 19, 31866, 39466 }, --=q2=Veiled Shadow Draenite : =ds=#sr# 325 : =ds=AtlasLoot["Drop"]: AtlasLoot_IngameLocales["Blade's Edge Mountains"]
				{ 20, 23100, 28914 }, --=q2=Glinting Shadow Draenite : =ds=#sr# 315 : =ds=AtlasLoot["Trainer"]
				{ 21, 23109, 28927 }, --=q2=Purified Shadow Draenite : =ds=#sr# 305 : =ds=AtlasLoot_IngameLocales["The Aldor"] / AtlasLoot_IngameLocales["The Scryers"] - AtlasLoot["Honored"]
				{ 22, 23108, 28925 }, --=q2=Timeless Shadow Draenite : =ds=#sr# 300 : =ds=AtlasLoot["Trainer"]
			},
		},
		{	--JewelMeta
			name = AL["Meta Gems"],
			[MOP_DIFF] = {
				{1, 76884, 107753 }, --=q3=Agile Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{2, 76895, 107754 }, --=q3=Austere Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{3, 76885, 107756 }, --=q3=Burning Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{4, 76890, 107757 }, --=q3=Destructive Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{5, 76897, 107758 }, --=q3=Effulgent Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{6, 76879, 107759 }, --=q3=Ember Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{7, 76892, 107760 }, --=q3=Enigmatic Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{16, 76896, 107762 }, --=q3=Eternal Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{17, 76887, 107763 }, --=q3=Fleet Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{18, 76894, 107764 }, --=q3=Forlorn Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{19, 76893, 107765 }, --=q3=Impassive Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{20, 76891, 107766 }, --=q3=Powerful Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{21, 76886, 107767 }, --=q3=Reverberating Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
				{22, 76888, 107768 }, --=q3=Revitalizing Primal Diamond : =ds=#sr# 575 : =ds=AtlasLoot["World Drop"]
			},
			[CATA_DIFF] = {
				{ 1, 68778, 96255 }, --=q3=Agile Shadowspirit Diamond : =ds=#sr# 490 : =ds=AtlasLoot["World Drop"]
				{ 2, 52294, 73468 }, --=q3=Austere Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 3, 52292, 73466 }, --=q3=Bracing Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 4, 68780, 96257 }, --=q3=Burning Shadowspirit Diamond : =ds=#sr# 490 : =ds=AtlasLoot["World Drop"]
				{ 5, 52291, 73465 }, --=q3=Chaotic Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 6, 52298, 73472 }, --=q3=Destructive Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 7, 52295, 73469 }, --=q3=Efullgent Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 8, 52296, 73470 }, --=q3=Ember Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 16, 52300, 73474 }, --=q3=Enigmatic Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 17, 52293, 73467 }, --=q3=Eternal Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 18, 52289, 73464 }, --=q3=Fleet Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 19, 52302, 73476 }, --=q3=Forlorn Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 20, 52301, 73475 }, --=q3=Impassive Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 21, 52299, 73473 }, --=q3=Powerful Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
				{ 22, 68779, 96256 }, --=q3=Reverberating Shadowspirit Diamond : =ds=#sr# 490 : =ds=AtlasLoot["World Drop"]
				{ 23, 52297, 73471 }, --=q3=Revitalizing Shadowspirit Diamond : =ds=#sr# 490 : #CATAJW:4#AtlasLoot["Vendor"]
			},
			[WOTLK_DIFF] = {
				{ 1, 41380, 55401 }, --=q3=Austere Earthsiege Diamond : =ds=#sr# 420 : =ds=King Ymiron644
				{ 2, 41389, 55405 }, --=q3=Beaming Earthsiege Diamond : =ds=#sr# 420 : =ds=AtlasLoot["World Drop"]
				{ 3, 41395, 55397 }, --=q3=Bracing Earthsiege Diamond : =ds=#sr# 420 : =ds=Ley-Guardian Eregos625
				{ 4, 41396, 55398 }, --=q3=Eternal Earthsiege Diamond : =ds=#sr# 420 : =ds=Loken600
				{ 5, 41401, 55396 }, --=q3=Insightful Earthsiege Diamond : =ds=#sr# 420 : #DALARANJW:5#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 6, 41385, 55404 }, --=q3=Invigorating Earthsiege Diamond : =ds=#sr# 420 : #DALARANJW:5#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 7, 41381, 55402 }, --=q3=Persistant Earthsiege Diamond : =ds=#sr# 420 : =ds=AtlasLoot["Trainer"]
				{ 8, 41397, 55399 }, --=q3=Powerful Earthsiege Diamond : =ds=#sr# 420 : =ds=AtlasLoot["Trainer"]
				{ 9, 41398, 55400 }, --=q3=Relentless Earthsiege Diamond : =ds=#sr# 420 : #DALARANJW:5#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 10, 41382, 55403 }, --=q3=Trenchant Earthsiege Diamond : =ds=#sr# 420 : #DALARANJW:5#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 16, 41285, 55389 }, --=q3=Chaotic Skyflare Diamond : =ds=#sr# 420 : #DALARANJW:5#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 17, 41307, 55390 }, --=q3=Destructive Skyflare Diamond : =ds=#sr# 420 : =ds=AtlasLoot["World Drop"]
				{ 18, 41333, 55392 }, --=q3=Ember Skyflare Diamond : =ds=#sr# 420 : #DALARANJW:5#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 19, 41335, 55393 }, --=q3=Enigmatic Skyflare Diamond : =ds=#sr# 420 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 20, 41378, 55387 }, --=q3=Forlorn Skyflare Diamond : =ds=#sr# 420 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 21, 41379, 55388 }, --=q3=Impassive Skyflare Diamond : =ds=#sr# 420 : =ds=AtlasLoot_IngameLocales["Wintergrasp"]
				{ 22, 41376, 55407 }, --=q3=Revitalizing Skyflare Diamond : =ds=#sr# 420 : #DALARANJW:5#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 23, 41377, 55384 }, --=q3=Shielded Skyflare Diamond : =ds=#sr# 420 : #DALARANJW:5#AtlasLoot["Vendor"]: AtlasLoot_IngameLocales["Dalaran"]
				{ 24, 41339, 55394 }, --=q3=Swift Skyflare Diamond : =ds=#sr# 420 : =ds=AtlasLoot["Trainer"]
				{ 25, 41400, 55395 }, --=q3=Thundering Skyflare Diamond : =ds=#sr# 420 : =ds=AtlasLoot["World Drop"]
				{ 26, 41375, 55386 }, --=q3=Tireless Skyflare Diamond : =ds=#sr# 420 : =ds=AtlasLoot["Trainer"]
			},
			[BC_DIFF] = {
				{ 1, 35501, 46597 }, --=q3=Eternal Earthstorm Diamond : =ds=#sr# 370 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 2, 25897, 32867 }, --=q3=Bracing Earthstorm Diamond : =ds=#sr# 365 : =ds=AtlasLoot_IngameLocales["The Consortium"] - AtlasLoot["Revered"]
				{ 3, 25899, 32869 }, --=q3=Brutal Earthstorm Diamond : =ds=#sr# 365 : =ds=AtlasLoot["World Drop"]
				{ 4, 25901, 32870 }, --=q3=Insightful Earthstorm Diamond : =ds=#sr# 365 : =ds=AtlasLoot_IngameLocales["The Sha'tar"] - AtlasLoot["Friendly"]
				{ 5, 25896, 32866 }, --=q3=Powerful Earthstorm Diamond : =ds=#sr# 365 : =ds=AtlasLoot_IngameLocales["The Consortium"] - AtlasLoot["Honored"]
				{ 6, 32409, 39961 }, --=q3=Relentless Earthstorm Diamond : =ds=#sr# 365 : =ds=AtlasLoot_IngameLocales["The Consortium"] - AtlasLoot["Exalted"]
				{ 7, 25898, 32868 }, --=q3=Tenacious Earthstorm Diamond : =ds=#sr# 365 : =ds=AtlasLoot["World Drop"]
				{ 16, 35503, 46601 }, --=q3=Ember Skyfire Diamond : =ds=#sr# 370 : =ds=AtlasLoot_IngameLocales["Shattered Sun Offensive"] - AtlasLoot["Revered"]
				{ 17, 34220, 44794 }, --=q3=Chaotic Skyfire Diamond : =ds=#sr# 365 : =ds=AtlasLoot["Drop"]: AtlasLoot_IngameLocales["Shadowmoon Valley"]
				{ 18, 25890, 32871 }, --=q3=Destructive Skyfire Diamond : =ds=#sr# 365 : =ds=AtlasLoot["World Drop"]
				{ 19, 25895, 32874 }, --=q3=Enigmatic Skyfire Diamond : =ds=#sr# 365 : =ds=AtlasLoot_IngameLocales["Keepers of Time"] - AtlasLoot["Honored"]
				{ 20, 25893, 32872 }, --=q3=Mystical Skyfire Diamond : =ds=#sr# 365 : =ds=AtlasLoot["World Drop"]
				{ 21, 25894, 32873 }, --=q3=Swift Skyfire Diamond : =ds=#sr# 365 : =ds=AtlasLoot_IngameLocales["The Consortium"] - AtlasLoot["Honored"]
				{ 22, 32410, 39963 }, --=q3=Thundering Skyfire Diamond : =ds=#sr# 365 : =ds=AtlasLoot["World Drop"]
			},
		},
		{	--JewelPrismatic
			name = AL["Prismatic Gems"],
			[WOD_DIFF] = {
				{ 1, 115809, 170725, [PRICE_EXTRA_ITTYPE] = "118723:5" },	-- Greater Critical Strike Taladite (Sold, Ashran)
				{ 2, 115811, 170726, [PRICE_EXTRA_ITTYPE] = "118723:5" },	-- Greater Haste Taladite (Sold, Ashran)
				{ 3, 115812, 170727, [PRICE_EXTRA_ITTYPE] = "118723:5" },	-- Greater Mastery Taladite (Sold, Ashran)
				{ 4, 115813, 170728, [PRICE_EXTRA_ITTYPE] = "118723:5" },	-- Greater Multistrike Taladite (Sold, Ashran)
				{ 5, 115815, 170730, [PRICE_EXTRA_ITTYPE] = "118723:5" },	-- Greater Stamina Taladite (Sold, Ashran)
				{ 6, 115814, 170729, [PRICE_EXTRA_ITTYPE] = "118723:5" },	-- Greater Versatility Taladite (Sold, Ashran)
				{ 16, 115803, 170719, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Critical Strike Taladite (Sold, Ashran)
				{ 17, 115804, 170720, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Haste Taladite (Sold, Ashran)
				{ 18, 115805, 170721, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Mastery Taladite (Sold, Ashran)
				{ 19, 115806, 170722, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Multistrike Taladite (Sold, Ashran)
				{ 20, 115808, 170724, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Stamina Taladite (Sold, Ashran)
				{ 21, 115807, 170723, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Versatility Taladite (Sold, Ashran)
			},
		},
		{	--JewelNecks
			name = AL["Necklaces"],
			[WOD_DIFF] = {
				{ 1, "115799:Stage3", 170703 },	-- Glowing Taladite Pendant (Stage 3)
				{ 2, "115799:Stage2", 170702 },	-- Glowing Taladite Pendant (Stage 2)
				{ 3, "115799:Stage1", 170716, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Glowing Taladite Pendant (Stage 1) (Sold, Ashran)
				{ 5, "115800:Stage3", 170703 },	-- Shifting Taladite Pendant (Stage 3)
				{ 6, "115800:Stage2", 170702 },	-- Shifting Taladite Pendant (Stage 2)
				{ 7, "115800:Stage1", 170717, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Shifting Taladite Pendant (Stage 1) (Sold, Ashran)
				{ 9, "115801:Stage3", 170703 },	-- Whispering Taladite Pendant (Stage 3)
				{ 10, "115801:Stage2", 170702 },	-- Whispering Taladite Pendant (Stage 2)
				{ 11, "115801:Stage1", 170718, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Whispering Taladite Pendant (Stage 1) (Sold, Ashran)
				{ 16, 115990, 170707 },	-- Glowing Iron Choker (Learnt by item 115359)
				{ 17, 115991, 170708 },	-- Shifting Iron Choker (Learnt by item 115359)
				{ 18, 115992, 170709 },	-- Whispering Iron Choker (Learnt by item 115359)
			},
		},
		{	--JewelRings
			name = AL["Rings"],
			[WOD_DIFF] = {
				{ 1, "115794:Stage3", 170703 },	-- Glowing Taladite Ring (Stage 3)
				{ 2, "115794:Stage2", 170702 },	-- Glowing Taladite Ring (Stage 2)
				{ 3, "115794:Stage1", 170713, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Glowing Taladite Ring (Stage 1) (Sold, Ashran)
				{ 5, "115796:Stage3", 170703 },	-- Shifting Taladite Ring (Stage 3)
				{ 6, "115796:Stage2", 170702 },	-- Shifting Taladite Ring (Stage 2)
				{ 7, "115796:Stage1", 170714, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Shifting Taladite Ring (Stage 1) (Sold, Ashran)
				{ 9, "115798:Stage3", 170703 },	-- Whispering Taladite Ring (Stage 3)
				{ 10, "115798:Stage2", 170702 },	-- Whispering Taladite Ring (Stage 2)
				{ 11, "115798:Stage1", 170715, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Whispering Taladite Ring (Stage 1) (Sold, Ashran)
				{ 16, 115993, 170710 },	-- Glowing Blackrock Band (Learnt by item 115359)
				{ 17, 115994, 170711 },	-- Shifting Blackrock Band (Learnt by item 115359)
				{ 18, 115995, 170712 },	-- Whispering Blackrock Band (Learnt by item 115359)
				{ 19, 115987, 170704 },	-- Glowing Iron Band (Learnt by item 115359)
				{ 20, 115988, 170705 },	-- Shifting Iron Band (Learnt by item 115359)
				{ 21, 115989, 170706 },	-- Whispering Iron Band (Learnt by item 115359)
			},
		},
		{	--JewelMisc
			name = AL["Miscellaneous"],
			[WOD_DIFF] = {
				{ 1, 115524, 170700 },	-- Taladite Crystal (Learnt by item 115359)
				{ 3, 112498, 170732, [PRICE_EXTRA_ITTYPE] = "118723:3" },	-- Prismatic Focusing Lens (Sold, Ashran)
				{ 4, 112384, 170731, [PRICE_EXTRA_ITTYPE] = "118723:3" },	-- Reflecting Prism (Sold, Ashran)
				{ 6, 118723, 176087 },	-- Secrets of Draenor Jewelcrafting (Learnt by item 115359)
				{ 16, 115527, 170702, [PRICE_EXTRA_ITTYPE] = "118723:5" },	-- Taladite Amplifier (Sold, Ashran)
				{ 17, 115529, 170703, [PRICE_EXTRA_ITTYPE] = "118723:5" },	-- Greater Taladite Amplifier (Sold, Ashran)
				{ 19, 115526, 170701, [PRICE_EXTRA_ITTYPE] = "118723:1" },	-- Taladite Recrystalizer (Sold, Ashran)
			},
		},
	}
}

data["Leatherworking"] = {
	name = GetSpellInfo(2108),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--LeatherLeatherArmor
			name = ALIL["Leather"].." "..AL["Armor"],
			[WOD_DIFF] = {
				{ 1, "116177:Stage3", 171287 },	-- Supple Helm (Stage 3)
				{ 2, "116176:Stage3", 171287 },	-- Supple Shoulderguards (Stage 3)
				{ 3, "116180:Stage3", 171287 },	-- Supple Vest (Stage 3)
				{ 4, "116181:Stage3", 171287 },	-- Supple Bracers (Stage 3)
				{ 5, "116179:Stage3", 171287 },	-- Supple Gloves (Stage 3)
				{ 6, "116183:Stage3", 171287 },	-- Supple Waistguard (Stage 3)
				{ 7, "116178:Stage3", 171287 },	-- Supple Leggings (Stage 3)
				{ 8, "116182:Stage3", 171287 },	-- Supple Boots (Stage 3)
				{ 9, "116177:Stage2", 171286 },	-- Supple Helm (Stage 2)
				{ 10, "116176:Stage2", 171286 },	-- Supple Shoulderguards (Stage 2)
				{ 11, "116180:Stage2", 171286 },	-- Supple Vest (Stage 2)
				{ 12, "116181:Stage2", 171286 },	-- Supple Bracers (Stage 2)
				{ 13, "116179:Stage2", 171286 },	-- Supple Gloves (Stage 2)
				{ 14, "116183:Stage2", 171286 },	-- Supple Waistguard (Stage 2)
				{ 15, "116178:Stage2", 171286 },	-- Supple Leggings (Stage 2)
				{ 16, "116182:Stage2", 171286 },	-- Supple Boots (Stage 2)
				{ 17, "116177:Stage1", 171271, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Supple Helm (Stage 1) (Sold, Ashran)
				{ 18, "116176:Stage1", 171270, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Supple Shoulderguards (Stage 1) (Sold, Ashran)
				{ 19, "116180:Stage1", 171274, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Supple Vest (Stage 1) (Sold, Ashran)
				{ 20, "116181:Stage1", 171275, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Supple Bracers (Stage 1) (Sold, Ashran)
				{ 21, "116179:Stage1", 171273, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Supple Gloves (Stage 1) (Sold, Ashran)
				{ 22, "116183:Stage1", 171277, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Supple Waistguard (Stage 1) (Sold, Ashran)
				{ 23, "116178:Stage1", 171272, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Supple Leggings (Stage 1) (Sold, Ashran)
				{ 24, "116182:Stage1", 171276, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Supple Boots (Stage 1) (Sold, Ashran)
				{ 25, 116164, 171260 },	-- Journeying Helm (Learnt by item 115358)
				{ 26, 116165, 171261 },	-- Journeying Robes (Learnt by item 115358)
				{ 27, 116166, 171262 },	-- Journeying Slacks (Learnt by item 115358)
			},
		},
		{	--LeatherMailArmor
			name = ALIL["Mail"].." "..AL["Armor"],
			[WOD_DIFF] = {
				{ 1, "116188:Stage3", 171287 },	-- Wayfaring Helm (Stage 3)
				{ 2, "116187:Stage3", 171287 },	-- Wayfaring Shoulderguards (Stage 3)
				{ 3, "116191:Stage3", 171287 },	-- Wayfaring Tunic (Stage 3)
				{ 4, "116192:Stage3", 171287 },	-- Wayfaring Bracers (Stage 3)
				{ 5, "116190:Stage3", 171287 },	-- Wayfaring Gloves (Stage 3)
				{ 6, "116194:Stage3", 171287 },	-- Wayfaring Belt (Stage 3)
				{ 7, "116189:Stage3", 171287 },	-- Wayfaring Leggings (Stage 3)
				{ 8, "116193:Stage3", 171287 },	-- Wayfaring Boots (Stage 3)
				{ 9, "116188:Stage2", 171286 },	-- Wayfaring Helm (Stage 2)
				{ 10, "116187:Stage2", 171286 },	-- Wayfaring Shoulderguards (Stage 2)
				{ 11, "116191:Stage2", 171286 },	-- Wayfaring Tunic (Stage 2)
				{ 12, "116192:Stage2", 171286 },	-- Wayfaring Bracers (Stage 2)
				{ 13, "116190:Stage2", 171286 },	-- Wayfaring Gloves (Stage 2)
				{ 14, "116194:Stage2", 171286 },	-- Wayfaring Belt (Stage 2)
				{ 15, "116189:Stage2", 171286 },	-- Wayfaring Leggings (Stage 2)
				{ 16, "116193:Stage2", 171286 },	-- Wayfaring Boots (Stage 2)
				{ 17, "116188:Stage1", 171279, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Wayfaring Helm (Stage 1) (Sold, Ashran)
				{ 18, "116187:Stage1", 171278, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Wayfaring Shoulderguards (Stage 1) (Sold)
				{ 19, "116191:Stage1", 171282, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Wayfaring Tunic (Stage 1) (Sold, Ashran)
				{ 20, "116192:Stage1", 171283, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Wayfaring Bracers (Stage 1) (Sold, Ashran)
				{ 21, "116190:Stage1", 171281, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Wayfaring Gloves (Stage 1) (Sold, Ashran)
				{ 22, "116194:Stage1", 171285, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Wayfaring Belt (Stage 1) (Sold, Ashran)
				{ 23, "116189:Stage1", 171280, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Wayfaring Leggings (Stage 1) (Sold, Ashran)
				{ 24, "116193:Stage1", 171284, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Wayfaring Boots (Stage 1) (Sold, Ashran)
				{ 25, 116167, 171263 },	-- Traveling Helm (Learnt by item 115358)
				{ 26, 116168, 171264 },	-- Traveling Tunic (Learnt by item 115358)
				{ 27, 116169, 171265 },	-- Traveling Leggings (Learnt by item 115358)
			},
		},
		{	--LeatherCloaks
			name = AL["Cloaks"],
			[WOD_DIFF] = {
				{ 1, "116175:Stage3", 171287 },	-- Brilliant Burnished Cloak (Stage 3)
				{ 2, "116175:Stage2", 171286 },	-- Brilliant Burnished Cloak (Stage 2)
				{ 3, "116175:Stage1", 171269, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Brilliant Burnished Cloak (Stage 1) (Sold, Ashran)
				{ 5, "116174:Stage3", 171287 },	-- Nimble Burnished Cloak (Stage 3)
				{ 6, "116174:Stage2", 171286 },	-- Nimble Burnished Cloak (Stage 2)
				{ 7, "116174:Stage1", 171268, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Nimble Burnished Cloak (Stage 1) (Sold, Ashran)
				{ 9, "116171:Stage3", 171287 },	-- Powerful Burnished Cloak (Stage 3)
				{ 10, "116171:Stage2", 171286 },	-- Powerful Burnished Cloak (Stage 2)
				{ 11, "116171:Stage1", 171267, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Powerful Burnished Cloak (Stage 1) (Sold, Ashran)
			},
		},
		{	--LeatherDrumsBagsMisc
			name = AL["Miscellaneous"],
			[WOD_DIFF] = {
				{ 1, 108883, 171291, [PRICE_EXTRA_ITTYPE] = "118721:5" },	-- Riding Harness (Sold, Ashran)
				{ 3, 116261, 171290, [PRICE_EXTRA_ITTYPE] = "118721:5" },	-- Burnished Inscription Bag (Sold, Ashran)
				{ 4, 116259, 171288, [PRICE_EXTRA_ITTYPE] = "118721:5" },	-- Burnished Leather Bag (Sold, Ashran)
				{ 5, 116260, 171289, [PRICE_EXTRA_ITTYPE] = "118721:5" },	-- Burnished Mining Bag (Sold, Ashran)
				{ 7, 120257, 178208, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Drums of Fury (Sold, Ashran)
				{ 9, 110611, 171391 },	-- Burnished Leather (Learnt by item 115358)
				{ 11, 118721, 176089 },	-- Secrets of Draenor Leatherworking (Learnt by item 115358)
				{ 16, 116203, 171286, [PRICE_EXTRA_ITTYPE] = "118721:5" },	-- Burnished Essence (Sold, Ashran)
				{ 17, 116204, 171287, [PRICE_EXTRA_ITTYPE] = "118721:5" },	-- Greater Burnished Essence (Sold, Ashran)
				{ 19, 116170, 171266, [PRICE_EXTRA_ITTYPE] = "118721:1" },	-- Leather Refurbishing Kit (Sold, Ashran)
			},
		},
	}
}

data["Mining"] = {
	name = GetSpellInfo(2575),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--Mining
			name = GetSpellInfo(2575),
			[NORMAL_DIFF] = {
				{ 1, 72095, 102167 },	-- Trillium Bar
				{ 2, 72096, 102165 },	-- Smelt Ghost Iron
				{ 3, 51950, 74529 },	-- Smelt Pyrium
				{ 4, 53039, 74537 },	-- Smelt Hardened Elementium
				{ 5, 52186, 74530 },	-- Smelt Elementium
				{ 6, 54849, 84038 },	-- Smelt Obsidium
				{ 7, 37663, 55208 },	-- Smelt Titansteel
				{ 8, 41163, 55211 },	-- Smelt Titanium
				{ 9, 36913, 49258 },	-- Smelt Saronite
				{ 10, 36916, 49252 },	-- Smelt Cobalt
				{ 11, 35128, 46353 },	-- Smelt Hardened Khorium
				{ 12, 23573, 29686 },	-- Smelt Hardened Adamantite
				{ 13, 23449, 29361 },	-- Smelt Khorium
				{ 14, 23448, 29360 },	-- Smelt Felsteel
				{ 15, 23447, 29359 },	-- Smelt Eternium
				{ 16, 23446, 29358 },	-- Smelt Adamantite
				{ 17, 23445, 29356 },	-- Smelt Fel Iron
				{ 18, 22574, 35751 },	-- Fire Sunder
				{ 19, 22573, 35750 },	-- Earth Shatter
				{ 20, 17771, 22967 },	-- Smelt Enchanted Elementium
				{ 21, 12655, 70524 },	-- Enchanted Thorium
				{ 22, 11371 , 14891 },	-- Smelt Dark Iron
				{ 23, 12359, 16153 },	-- Smelt Thorium
				{ 24, 6037, 10098 },	-- Smelt Truesilver
				{ 25, 3860, 10097 },	-- Smelt Mithril
				{ 26, 3859, 3569 },	-- Smelt Steel
				{ 27, 3577, 3308 },	-- Smelt Gold
				{ 28, 3575, 3307 },	-- Smelt Iron
				{ 29, 2842, 2658 },	-- Smelt Silver
				{ 30, 2841, 2659 },	-- Smelt Bronze
				{ 101, 3576, 3304 },	-- Smelt Tin
				{ 102, 2840, 2657 },	-- Smelt Copper
			},
		},
	}
}

data["Tailoring"] = {
	name = GetSpellInfo(3908),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--TailoringArmor
			name = AL["Armor"],
			[WOD_DIFF] = {
				{ 1, "114810:Stage3", 168856 },	-- Hexweave Cowl (Stage 3)
				{ 2, "114809:Stage3", 168856 },	-- Hexweave Mantle (Stage 3)
				{ 3, "114813:Stage3", 168856 },	-- Hexweave Robe (Stage 3)
				{ 4, "114814:Stage3", 168856 },	-- Hexweave Bracers (Stage 3)
				{ 5, "114812:Stage3", 168856 },	-- Hexweave Gloves (Stage 3)
				{ 6, "114816:Stage3", 168856 },	-- Hexweave Belt (Stage 3)
				{ 7, "114811:Stage3", 168856 },	-- Hexweave Leggings (Stage 3)
				{ 8, "114815:Stage3", 168856 },	-- Hexweave Slippers (Stage 3)
				{ 9, "114810:Stage2", 168855 },	-- Hexweave Cowl (Stage 2)
				{ 10, "114809:Stage2", 168855 },	-- Hexweave Mantle (Stage 2)
				{ 11, "114813:Stage2", 168855 },	-- Hexweave Robe (Stage 2)
				{ 12, "114814:Stage2", 168855 },	-- Hexweave Bracers (Stage 2)
				{ 13, "114812:Stage2", 168855 },	-- Hexweave Gloves (Stage 2)
				{ 14, "114816:Stage2", 168855 },	-- Hexweave Belt (Stage 2)
				{ 15, "114811:Stage2", 168855 },	-- Hexweave Leggings (Stage 2)
				{ 16, "114815:Stage2", 168855 },	-- Hexweave Slippers (Stage 2)
				{ 17, "114810:Stage1", 168838, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Cowl (Stage 1) (Sold, Ashran)
				{ 18, "114809:Stage1", 168837, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Mantle (Stage 1) (Sold, Ashran)
				{ 19, "114813:Stage1", 168841, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Robe (Stage 1) (Sold, Ashran)
				{ 20, "114814:Stage1", 168842, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Bracers (Stage 1) (Sold, Ashran)
				{ 21, "114812:Stage1", 168840, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Gloves (Stage 1) (Sold, Ashran)
				{ 22, "114816:Stage1", 168844, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Belt (Stage 1) (Sold, Ashran)
				{ 23, "114811:Stage1", 168839, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Leggings (Stage 1) (Sold, Ashran)
				{ 24, "114815:Stage1", 168843, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Slippers (Stage 1) (Sold, Ashran)
				{ 101, "114819:Stage3", 168856 },	-- Brilliant Hexweave Cloak (Stage 3)
				{ 102, "114819:Stage2", 168855 },	-- Brilliant Hexweave Cloak (Stage 2)
				{ 103, "114819:Stage1", 168847, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Brilliant Hexweave Cloak (Stage 1) (Sold, Ashran)
				{ 105, "114818:Stage3", 168856 },	-- Nimble Hexweave Cloak (Stage 3)
				{ 106, "114818:Stage2", 168855 },	-- Nimble Hexweave Cloak (Stage 2)
				{ 107, "114818:Stage1", 168846, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Nimble Hexweave Cloak (Stage 1) (Sold, Ashran)
				{ 109, "114817:Stage3", 168856 },	-- Powerful Hexweave Cloak (Stage 3)
				{ 110, "114817:Stage2", 168855 },	-- Powerful Hexweave Cloak (Stage 2)
				{ 111, "114817:Stage1", 168845, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Powerful Hexweave Cloak (Stage 1) (Sold, Ashran)
				{ 116, 114828, 168852 },	-- Sumptuous Cowl (Learnt by item 115357)
				{ 117, 114829, 168853 },	-- Sumptuous Robes (Learnt by item 115357)
				{ 118, 114831, 168854 },	-- Sumptuous Leggings (Learnt by item 115357)
			},
		},
		{	--TailoringBags
			name = AL["Bags"],
			[WOD_DIFF] = {
				{ 1, 114821, 168848, [PRICE_EXTRA_ITTYPE] = "118722:5" },	-- Hexweave Bag (Sold, Ashran)
			},
		},
		{	--TailoringMisc
			name = AL["Miscellaneous"],
			[WOD_DIFF] = {
				{ 1, 115363, 168850, [PRICE_EXTRA_ITTYPE] = "118722:5" },	-- Creeping Carpet (Sold, Ashran)
				{ 2, 113216, 168849, [PRICE_EXTRA_ITTYPE] = "118722:5" },	-- Elekk Plushie (Sold, Ashran)
				{ 4, 111556, 168835 },	-- Hexweave Cloth (Learnt by item 115357)
				{ 6, 118722, 176058 },	-- Secrets of Draenor Tailoring (Learnt by item 115357)
				{ 16, 114837, 168855, [PRICE_EXTRA_ITTYPE] = "118722:5" },	-- Hexweave Essence (Sold, Ashran)
				{ 17, 114838, 168856, [PRICE_EXTRA_ITTYPE] = "118722:5" },	-- Greater Hexweave Essence (Sold, Ashran)
				{ 19, 114836, 168836, [PRICE_EXTRA_ITTYPE] = "118722:1" },	-- Hexweave Embroidery (Sold, Ashran)
			},
		},
	}
}

data["Archaeology"] = {
	name = GetSpellInfo(78670),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--ArchaeologyArakkoa
			name = AL["Arakkoa"],
			[WOD_DIFF] = {
				{ 1, 117382, 168331 },	-- Beakbreaker of Terokk
				{ 3, 117354, 172460 },	-- Ancient Nest Guardian
				{ 5, 114204, 168328 },	-- Apexis Crystal
				{ 6, 114205, 168329 },	-- Apexis Hieroglyph
				{ 7, 114206, 168330 },	-- Apexis Scroll
				{ 8, 114198, 168322 },	-- Burial Urn
				{ 9, 114199, 168323 },	-- Decree Scrolls
				{ 10, 114197, 168321 },	-- Dreamcatcher
				{ 11, 114203, 168327 },	-- Outcast Dreamcatcher
				{ 12, 114200, 168324 },	-- Solar Orb
				{ 13, 114201, 168325 },	-- Sundial
				{ 14, 114202, 168326 },	-- Talonpriest Mask
			},
		},
		{	--ArchaeologyDraenorClans
			name = AL["Draenor Clans"],
			[WOD_DIFF] = {
				{ 1, 116985, 172459 },	-- Headdress of the First Shaman
				{ 3, 117380, 172466 },	-- Ancient Frostwolf Fang
				{ 5, 114171, 168305 },	-- Ancestral Talisman
				{ 6, 114163, 168301 },	-- Barbed Fishing Hook
				{ 7, 114157, 168298 },	-- Blackrock Razor
				{ 8, 114167, 168303 },	-- Ceremonial Tattoo Needles
				{ 9, 114169, 168304 },	-- Cracked Ivory Idol
				{ 10, 114177, 168308 },	-- Doomsday Prophecy
				{ 11, 114155, 168297 },	-- Elemental Bellows
				{ 12, 114141, 168290 },	-- Fang-Scarred Frostwolf Axe
				{ 13, 114173, 168306 },	-- Flask of Blazegrease
				{ 14, 114143, 168291 },	-- Frostwolf Ancestry Scrimshaw
				{ 15, 114175, 168307 },	-- Gronn-Tooth Necklace
				{ 16, 114161, 168300 },	-- Hooked Dagger
				{ 17, 114153, 168296 },	-- Metalworker's Hammer
				{ 18, 114149, 168294 },	-- Screaming Bullroarer
				{ 19, 114147, 168293 },	-- Warsinger's Drums
				{ 20, 114151, 168295 },	-- Warsong Ceremonial Pike
				{ 21, 114159, 168299 },	-- Weighted Chopping Axe
				{ 22, 114145, 168292 },	-- Wolfskin Snowshoes
			},
		},
		{	--ArchaeologyOgre
			name = AL["Ogre"],
			[WOD_DIFF] = {
				{ 1, 117385, 168319 },	-- Sorcerer-King Toe Ring
				{ 3, 117384, 168320 },	-- Warmaul of the Warmaul Chieftain
				{ 5, 114191, 168315 },	-- Eye of Har'gunn the Blind
				{ 6, 114189, 168313 },	-- Gladiator's Shield
				{ 7, 114194, 168318 },	-- Imperial Decree Stele
				{ 8, 114190, 168314 },	-- Mortar and Pestle
				{ 9, 114185, 168311 },	-- Ogre Figurine
				{ 10, 114187, 168312 },	-- Pictogram Carving
				{ 11, 114193, 168317 },	-- Rylak Riding Harness
				{ 12, 114192, 168316 },	-- Stone Dentures
				{ 13, 114183, 168310 },	-- Stone Manacles
				{ 14, 114181, 168309 },	-- Stonemaul Succession Stone
			},
		},
	}
}

data["Cooking"] = {
	name = GetSpellInfo(2550),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--CookingAttributes
			name = AL["Attributes"],
			[WOD_DIFF] = {
				{ 1, 111447, 160984 },	-- Talador Surf and Turf (Learnt by tasting or cooking)
				{ 2, 111431, 160958 },	-- Hearty Elekk Steak (Learnt by tasting or cooking)
				{ 3, 111439, 160973 },	-- Steamed Scorpion (Learnt by tasting or cooking)
			},
		},
		{	--CookingRatings
			name = AL["Ratings"],
			[WOD_DIFF] = {
				{ 1, 111449, 160986 },	-- Blackrock Barbecue (Learnt by tasting or cooking)
				{ 2, 111433, 160962 },	-- Blackrock Ham (Learnt by tasting or cooking)
				{ 3, 111441, 160978 },	-- Grilled Gulper (Learnt by tasting or cooking)
				{ 5, 111450, 160987 },	-- Frosty Stew (Learnt by tasting or cooking)
				{ 6, 111434, 160966 },	-- Pan-Seared Talbuk (Learnt by tasting or cooking)
				{ 7, 111442, 160979 },	-- Sturgeon Stew (Learnt by tasting or cooking)
				{ 9, 111452, 160989 },	-- Sleeper Surprise (Learnt by tasting or cooking)
				{ 10, 111436, 160968 },	-- Braised Riverbeast (Learnt by tasting or cooking)
				{ 11, 111444, 160981 },	-- Fat Sleeper Cakes (Learnt by tasting or cooking)
				{ 16, 111453, 160999 },	-- Calamari Crepes (Learnt by tasting or cooking)
				{ 17, 111445, 160982 },	-- Fiery Calamari (Learnt by tasting or cooking)
				{ 18, 111437, 160969 },	-- Rylak Crepes (Learnt by tasting or cooking)
				{ 20, 111454, 161000 },	-- Gorgrond Chowder (Learnt by tasting or cooking)
				{ 21, 111438, 160971 },	-- Clefthoof Sausages (Learnt by tasting or cooking)
				{ 22, 111446, 160983 },	-- Skulker Chowder (Learnt by tasting or cooking)
			},
		},
		{	--CookingBanquetFeast
			name = AL["Banquets/Feasts"],
			[WOD_DIFF] = {
				{ 1, 111457, 173978 },	-- Feast of Blood (Learnt by tasting or cooking)
				{ 2, 111458, 173979 },	-- Feast of the Waters (Learnt by tasting or cooking)
			},
		},
		{	--CookingStandard
			name = AL["Food without Buffs"],
			[WOD_DIFF] = {
				{ 1, 111456, 161002 },	-- Grilled Saberfish (Learnt by item 111387)
				{ 2, 111455, 161001 },	-- Saberfish Broth (Learnt by item 111387)
			},
		},
	}
}

data["FirstAid"] = {
	name = GetSpellInfo(3273),
	ContentType = CRAFTING_CONTENT,
	TableType = CRAFTING_ITTYPE,
	items = {
		{	--FirstAid
			name = GetSpellInfo(3273),
			[WOD_DIFF] = {
				{ 1, 111603, 172539 },	-- Antiseptic Bandage (Learnt by item 111364)
				{ 2, 116979, 172541 },	-- Blackwater Anti-Venom (Learnt by item 111364)
				{ 3, 116981, 172542 },	-- Fire Ammonite Oil (Learnt by item 111364)
				{ 4, 109223, 172540 },	-- Healing Tonic (Learnt by item 111364)
			},
		},
	}
}