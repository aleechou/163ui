-- $Id: crafting.lua 4271 2013-09-17 15:48:14Z Dynaletik $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleItemSet = AtlasLoot_GetLocaleLibBabble("LibBabble-ItemSet-3.0")
local moduleName = "AtlasLootCrafting"

--GetSpellInfo fix for live realms ;)
local function GetSpellInfo(id)
	return _G["GetSpellInfo"](id) or "nil"
end
-- Using alchemy skill to get localized rank
local JOURNEYMAN = select(2, GetSpellInfo(3101));
local EXPERT = select(2, GetSpellInfo(3464));
local ARTISAN = select(2, GetSpellInfo(11611));
local MASTER = select(2, GetSpellInfo(28596));

local ALCHEMY, APPRENTICE = GetSpellInfo(2259);
local ARCHAEOLOGY = GetSpellInfo(78670)
local BLACKSMITHING = GetSpellInfo(2018);
local ARMORSMITH = GetSpellInfo(9788);
local WEAPONSMITH = GetSpellInfo(9787);
local AXESMITH = GetSpellInfo(17041);
local HAMMERSMITH = GetSpellInfo(17040);
local SWORDSMITH = GetSpellInfo(17039);
local COOKING = GetSpellInfo(2550);
local ENCHANTING = GetSpellInfo(7411);
local ENGINEERING = GetSpellInfo(4036);
local GNOMISH = GetSpellInfo(20220);
local GOBLIN = GetSpellInfo(20221);
local FIRSTAID = GetSpellInfo(3273);
local FISHING = GetSpellInfo(63275);
local INSCRIPTION = GetSpellInfo(45357);
local JEWELCRAFTING = GetSpellInfo(25229);
local LEATHERWORKING = GetSpellInfo(2108);
local DRAGONSCALE = GetSpellInfo(10656);
local ELEMENTAL = GetSpellInfo(10658);
local TRIBAL = GetSpellInfo(10660);
local MINING = GetSpellInfo(2575);
local TAILORING = GetSpellInfo(3908);
local MOONCLOTH = GetSpellInfo(26798);
local SHADOWEAVE = GetSpellInfo(26801);
local SPELLFIRE = GetSpellInfo(26797);

-- Index
--- Tradeskill List
---- Alchemy
----- Battle Elixirs
----- Guardian Elixirs
----- Other Elixirs
----- Potions
----- Flasks
----- Transmutes
----- Cauldrons
----- Oils
----- Miscellaneous
---- Archaeology
----- Armor and Weapons
----- Miscellaneous
----- Dwarf
----- Night Elf
----- Fossil
----- Troll
----- Orc
----- Draenei
----- Vrykul
----- Nerubian
----- Tol'vir
----- Pandaren
----- Mogu
---- Blacksmithing
----- Armor
------ Classic
------ Burning Crusade
------ Wrath of the Lich King
------ Cataclysm
------ Mists of Pandaria
----- Weapons
------ Classic
------ Burning Crusade
------ Wrath of the Lich King
------ Cataclysm
------ Mists of Pandaria
----- Armor Enhancements
----- Weapon Enhancements
----- Miscellaneous
----- Armorsmith
----- Weaponsmith
----- Axesmith
----- Hammersmith
----- Swordsmith
----- Cataclysm Vendor Sold Plans
----- Mists of Pandaria Vendor Sold Plans
---- Cooking
----- Attributes
----- Ratings
----- Standard Buffs
----- Special
----- Banquets/Feasts
----- Spell/Attack Power
----- Other Buffs
----- Food without Buffs
---- Enchanting
----- Boots
----- Bracers
----- Chest
----- Cloaks
----- Gloves
----- Rings
----- Shields & Off Hands
----- 2 Hand Weapons
----- 1 Hand Weapons
----- Miscellaneous
----- Cataclysm Vendor Sold Formulas
---- Engineering
----- Cloth Armor
----- Leather Armor
----- Mail Armor
----- Plate Armor
----- Trinkets
----- ?
----- Explosives
----- Scopes
----- Tinker
----- Miscellaneous
----- Reagents
----- Weapons
----- Gnomish
----- Goblin
----- Cogwheel
----- Pets & Mounts
----- Fireworks
---- First Aid
---- Fishing
---- Inscription
----- Darkmoon Faire Cards
----- Scrolls
----- Shoulder Enchant
----- Reagents
----- Off Hand Items
----- Staves
----- Miscellaneous
----- Death Knight Glyphs
----- Druid Glyphs
----- Hunter Glyphs
----- Mage Glyphs
----- Monk Glyphs
----- Paladin Glyphs
----- Priest Glyphs
----- Rogue Glyphs
----- Shaman Glyphs
----- Warlock Glyphs
----- Warrior Glyphs
---- Jewelcrafting
----- Red Gem
----- Blue Gem
----- Yellow Gem
----- Green Gem
----- Orange Gem
----- Purple Gem
----- Meta Gem
----- Prismatic Gem
----- Dragon's Eye
----- Chimera's Eye
----- Serpent's Eye
----- Pets & Mounts
----- Necks
----- Rings
----- Trinkets
----- Miscellaneous
---- Leatherworking
----- Leather Armor
------ Classic
------ Burning Crusade
------ Wrath of the Lich King
------ Cataclysm
------ Mists of Pandaria
----- Mail Armor
------ Classic
------ Burning Crusade
------ Wrath of the Lich King
------ Cataclysm
------ Mists of Pandaria
----- Cloaks
----- Item Enhancements
----- Drums / Bags / Miscellaneous
----- Leather
----- Dragonscale
----- Elemental
----- Tribal
----- Cataclysm Vendor Sold Patterns
----- Mists of Pandaria Vendor Sold Patterns
---- Mining
---- Tailoring
----- Armor
------ Classic
------ Burning Crusade
------ Wrath of the Lich King
------ Cataclysm
------ Mists of Pandaria
----- Bags
----- Item Enhancements
----- Miscellaneous
----- Cloth
----- Shirts
----- Mooncloth
----- Shadoweave
----- Spellfire
----- Cataclysm Vendor Sold Patterns
----- Mists of Pandaria Vendor Sold Patterns
--- Profession Sets
---- Blacksmithing Mail Sets
---- Blacksmithing Plate Sets
---- Leatherworking Leather Sets
---- Leatherworking Mail Sets
---- Tailoring Sets
--- Other
---- Crafted Epic Weapons
--- Daily Profession Rewards
---- Cooking Daily
---- Fishing Daily
---- Jewelcrafting Daily

	-----------------------
	--- Tradeskill List ---
	-----------------------

		---------------
		--- Alchemy ---
		---------------

	AtlasLoot_Data["AlchemyBattleElixir"] = {
		["Normal"] = {
			{
				{ 1, "s114764", "76079", "=q1=Elixir of Peace", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 2, "s114762", "76080", "=q1=Elixir of Perfection", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 3, "s114759", "76078", "=q1=Elixir of the Rapids", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 4, "s114756", "76077", "=q1=Elixir of Weaponry", "=ds=#sr# 525", "=ds="..AL["Discovery"]};
				{ 5, "s114754", "76076", "=q1=Mad Hozen Elixir", "=ds=#sr# 525", "=ds="..AL["Discovery"]};
				{ 6, "s114758", "76083", "=q1=Monk's Elixir", "=ds=#sr# 525", "=ds="..AL["Discovery"]};
				{ 8, "s80497", "58148", "=q1=Elixir of the Master", "=ds=#sr# 495", "=ds="..AL["Trainer"]};
				{ 9, "s80493", "58144", "=q1=Elixir of Mighty Speed", "=ds=#sr# 490", "=ds="..AL["Trainer"]};
				{ 10, "s80491", "58094", "=q1=Elixir of Impossible Accuracy", "=ds=#sr# 480", "=ds="..AL["Trainer"]};
				{ 11, "s80484", "58092", "=q1=Elixir of the Cobra", "=ds=#sr# 465", "=ds="..AL["Trainer"]};
				{ 12, "s80480", "58089", "=q1=Elixir of the Naga", "=ds=#sr# 455", "=ds="..AL["Trainer"]};
				{ 14, "s80477", "58084", "=q1=Ghost Elixir", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 15, "s60355", "44327", "=q1=Elixir of Deadly Strikes", "=ds=#sr# 400", "=ds="..GetSpellInfo(60893)};
				{ 16, "s60357", "44329", "=q1=Elixir of Expertise", "=ds=#sr# 400", "=ds="..GetSpellInfo(60893)};
				{ 17, "s60366", "44331", "=q1=Elixir of Lightning Speed", "=ds=#sr# 400", "=ds="..GetSpellInfo(60893)};
				{ 18, "s60354", "44325", "=q1=Elixir of Accuracy", "=ds=#sr# 400", "=ds="..GetSpellInfo(60893)};
				{ 19, "s63732", "45621", "=q1=Elixir of Minor Accuracy", "=ds=#sr# 135", "=ds="..AL["Trainer"]};
				{ 21, "s53848", "40076", "=q1=Guru's Elixir", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 22, "s33741", "28104", "=q1=Elixir of Mastery", "=ds=#sr# 315", "=ds="..AL["Trainer"]};
				{ 23, "s60365", "44330", "=q1=Elixir of Armor Piercing", "=ds=#sr# 400", "=ds="..GetSpellInfo(60893)};
				{ 24, "s53840", "39666", "=q1=Elixir of Mighty Agility", "=ds=#sr# 395", "=ds="..AL["Trainer"]};
				{
					{ 25, "s28553", "22831", "=q1=Elixir of Major Agility", "=ds=#sr# 330", "=ds="..ALIL["Thrallmar"].." - "..AL["Honored"] };
					{ 25, "s28553", "22831", "=q1=Elixir of Major Agility", "=ds=#sr# 330", "=ds="..ALIL["Honor Hold"].." - "..AL["Honored"] };
				};
				{ 26, "s17571", "13452", "=q1=Elixir of the Mongoose", "=ds=#sr# 280", "=ds="..ALIL["Felwood"]};
				{ 27, "s11467", "9187", "=q1=Elixir of Greater Agility", "=ds=#sr# 240", "=ds="..AL["Trainer"]};
				{ 28, "s11449", "8949", "=q1=Elixir of Agility", "=ds=#sr# 185", "=ds="..AL["Trainer"]};
				{ 29, "s2333", "3390", "=q1=Elixir of Lesser Agility", "=ds=#sr# 140", "=ds="..AL["World Drop"]};
				{ 30, "s3230", "2457", "=q1=Elixir of Minor Agility", "=ds=#sr# 50", "=ds="..AL["World Drop"]};
			};
			{

				{ 1, "s54218", "40073", "=q1=Elixir of Mighty Strength", "=ds=#sr# 385", "=ds="..AL["Trainer"]};
				{ 2, "s28544", "22824", "=q1=Elixir of Major Strength", "=ds=#sr# 305", "=ds="..AL["Trainer"]};
				{ 3, "s11472", "9206", "=q1=Elixir of Giants", "=ds=#sr# 245", "=ds="..AL["World Drop"]};
				{ 4, "s17557", "13453", "=q1=Elixir of Brute Force", "=ds=#sr# 275", "=ds="..AL["Trainer"]};
				{ 5, "s8240", "6662", "=q1=Elixir of Giant Growth", "=ds=#sr# 90", "=ds="..ALIL["Northern Barrens"].." / "..ALIL["Southern Barrens"]};
				{ 6, "s3188", "3391", "=q1=Elixir of Ogre's Strength", "=ds=#sr# 150", "=ds="..AL["World Drop"]};
				{ 7, "s2329", "2454", "=q1=Elixir of Lion's Strength", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 9, "s53841", "40068", "=q1=Wrath Elixir", "=ds=#sr# 355", "=ds="..AL["Trainer"]};
				{ 10, "s38960", "31679", "=q1=Fel Strength Elixir", "=ds=#sr# 335", "=ds="..ALIL["Shadowmoon Valley"]};
				{ 11, "s33738", "28102", "=q1=Onslaught Elixir", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 12, "s11477", "9224", "=q1=Elixir of Demonslaying", "=ds=#sr# 250", "=ds="..AL["Vendor"]};
				{ 16, "s53842", "40070", "=q1=Spellpower Elixir", "=ds=#sr# 365", "=ds="..AL["Trainer"]};
				{ 17, "s28558", "22835", "=q1=Elixir of Major Shadow Power", "=ds=#sr# 350", "=ds="..ALIL["Lower City"].." - "..AL["Revered"]};
				{ 18, "s28556", "22833", "=q1=Elixir of Major Firepower", "=ds=#sr# 345", "=ds="..ALIL["The Scryers"].." - "..AL["Revered"]};
				{ 19, "s28549", "22827", "=q1=Elixir of Major Frost Power", "=ds=#sr# 320", "=ds="..AL["Vendor"]..": "..ALIL["Zangarmarsh"]};
				{ 20, "s28545", "22825", "=q1=Elixir of Healing Power", "=ds=#sr# 310", "=ds="..AL["Trainer"]};
				{ 21, "s33740", "28103", "=q1=Adept's Elixir", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 22, "s17573", "13454", "=q1=Greater Arcane Elixir", "=ds=#sr# 285", "=ds="..AL["Trainer"]};
				{ 23, "s26277", "21546", "=q1=Elixir of Greater Firepower", "=ds=#sr# 290", "=ds="..ALIL["Searing Gorge"]};
				{
					{ 24, "s11476", "9264", "=q1=Elixir of Shadow Power", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Undercity"] };
					{ 24, "s11476", "9264", "=q1=Elixir of Shadow Power", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Stormwind City"] };
				};
				{ 25, "s11461", "9155", "=q1=Arcane Elixir", "=ds=#sr# 285", "=ds="..AL["Trainer"]};
				{ 26, "s21923", "17708", "=q1=Elixir of Frost Power", "=ds=#sr# 190", "=ds="..AL["Feast of Winter Veil"]};
				{ 27, "s7845", "6373", "=q1=Elixir of Firepower", "=ds=#sr# 140", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ALCHEMY..": "..AL["Battle Elixirs"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

	AtlasLoot_Data["AlchemyGuardianElixir"] = {
		["Normal"] = {
			{
				{ 1, "s114763", "76081", "=q1=Elixir of Mirrors", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 2, "s114755", "76075", "=q1=Mantid Elixir", "=ds=#sr# 525", "=ds="..AL["Discovery"]};
				{ 4, "s80492", "58143", "=q1=Prismatic Elixir", "=ds=#sr# 480", "=ds="..AL["Trainer"]};
				{ 5, "s80488", "58093", "=q1=Elixir of Deep Earth", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 7, "s60356", "44328", "=q1=Elixir of Mighty Defense", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 8, "s56519", "40109", "=q1=Elixir of Mighty Mageblood", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 9, "s54220", "40097", "=q1=Elixir of Protection", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 10, "s62410", "8827", "=q1=Elixir of Water Walking", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 11, "s60367", "44332", "=q1=Elixir of Mighty Thoughts", "=ds=#sr# 395", "=ds="..AL["Trainer"]};
				{ 12, "s53898", "40078", "=q1=Elixir of Mighty Fortitude", "=ds=#sr# 390", "=ds="..AL["Trainer"]};
				{ 13, "s53847", "40072", "=q1=Elixir of Spirit", "=ds=#sr# 385", "=ds="..AL["Trainer"]};
				{ 14, "s28578", "22848", "=q1=Elixir of Empowerment", "=ds=#sr# 365", "=ds="..AL["World Drop"]};
				{ 15, "s28570", "22840", "=q1=Elixir of Major Mageblood", "=ds=#sr# 355", "=ds="..AL["World Drop"]};
				{ 16, "s28557", "22834", "=q1=Elixir of Major Defense", "=ds=#sr# 345", "=ds="..AL["Vendor"]};
				{ 17, "s39639", "32068", "=q1=Elixir of Ironskin", "=ds=#sr# 330", "=ds="..AL["Vendor"]..": "..ALIL["Nagrand"]};
				{ 18, "s39637", "32063", "=q1=Earthen Elixir", "=ds=#sr# 320", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Honored"]};
				{ 19, "s39638", "32067", "=q1=Elixir of Draenic Wisdom", "=ds=#sr# 320", "=ds="..AL["Trainer"]};
				{ 20, "s39636", "32062", "=q1=Elixir of Major Fortitude", "=ds=#sr# 310", "=ds="..AL["Trainer"]};
				{ 21, "s24368", "20004", "=q1=Mighty Troll's Blood Elixir", "=ds=#sr# 290", "=ds="..AL["No Longer Available"]};
				{ 22, "s24365", "20007", "=q1=Mageblood Elixir", "=ds=#sr# 275", "=ds="..AL["No Longer Available"]};
				{
					{ 23, "s17554", "13445", "=q1=Elixir of Superior Defense", "=ds=#sr# 265", "=ds="..AL["Vendor"]..": "..ALIL["Orgrimmar"] };
					{ 23, "s17554", "13445", "=q1=Elixir of Superior Defense", "=ds=#sr# 265", "=ds="..AL["Vendor"]..": "..ALIL["Ironforge"] };
				};
				{ 24, "s17555", "13447", "=q1=Elixir of the Sages", "=ds=#sr# 270", "=ds="..AL["Trainer"]};
				{ 25, "s11466", "9088", "=q1=Gift of Arthas", "=ds=#sr# 240", "=ds="..ALIL["Western Plaguelands"]};
				{ 26, "s11465", "9179", "=q1=Elixir of Greater Intellect", "=ds=#sr# 235", "=ds="..AL["Trainer"]};
				{ 27, "s11450", "8951", "=q1=Elixir of Greater Defense", "=ds=#sr# 195", "=ds="..AL["Trainer"]};
				{ 28, "s3451", "3826", "=q1=Major Troll's Blood Elixir", "=ds=#sr# 180", "=ds="..AL["World Drop"]};
				{ 29, "s3450", "3825", "=q1=Elixir of Fortitude", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 30, "s3177", "3389", "=q1=Elixir of Defense", "=ds=#sr# 130", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s3176", "3388", "=q1=Strong Troll's Blood Potion", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 2, "s3171", "3383", "=q1=Elixir of Wisdom", "=ds=#sr# 90", "=ds="..AL["Trainer"]};
				{ 3, "s2334", "2458", "=q1=Elixir of Minor Fortitude", "=ds=#sr# 50", "=ds="..AL["Trainer"]};
				{ 4, "s3170", "3382", "=q1=Weak Troll's Blood Elixir", "=ds=#sr# 15", "=ds="..AL["Trainer"]};
				{ 5, "s7183", "5997", "=q1=Elixir of Minor Defense", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 6, "s12609", "10592", "=q1=Catseye Elixir", "=ds=#sr# 200", "=ds="..AL["Trainer"]};	
			};
		};
		info = {
			name = ALCHEMY..": "..AL["Guardian Elixirs"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

	AtlasLoot_Data["AlchemyOtherElixir"] = {
		["Normal"] = {
			{
				{ 1, "s28552", "22830", "=q1=Elixir of the Searching Eye", "=ds=#sr# 325", "=ds="..AL["World Drop"]};
				{ 2, "s28543", "22823", "=q1=Elixir of Camouflage", "=ds=#sr# 305", "=ds="..AL["Vendor"]};
				{ 3, "s11478", "9233", "=q1=Elixir of Detect Demon", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 4, "s11468", "9197", "=q1=Elixir of Dream Vision", "=ds=#sr# 240", "=ds="..AL["World Drop"]};
				{ 5, "s11460", "9154", "=q1=Elixir of Detect Undead", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 6, "s22808", "18294", "=q1=Elixir of Greater Water Breathing", "=ds=#sr# 215", "=ds="..AL["Trainer"]};
				{ 7, "s3453", "3828", "=q1=Elixir of Detect Lesser Invisibility", "=ds=#sr# 195", "=ds="..AL["World Drop"]};
				{ 8, "s7179", "5996", "=q1=Elixir of Water Breathing", "=ds=#sr# 90", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ALCHEMY..": "..AL["Other Elixirs"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

	AtlasLoot_Data["AlchemyPotion"] = {
		["Normal"] = {
			{
				{ 1, "s114775", "76098", "=q1=Master Mana Potion", "=ds=#sr# 575", "=ds="..AL["Discovery"], amount = 2};
				{ 2, "s114751", "76094", "=q1=Alchemist's Rejuvenation", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 3, "s114752", "76097", "=q1=Master Healing Potion", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 5, "s80498", "57191", "=q1=Mythical Healing Potion", "=ds=#sr# 495", "=ds="..AL["Trainer"]};
				{ 6, "s80494", "57192", "=q1=Mythical Mana Potion", "=ds=#sr# 485", "=ds="..AL["Trainer"]};
				{ 7, "s80490", "57193", "=q1=Mighty Rejuvenation Potion", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 8, "s80487", "57099", "=q1=Mysterious Potion", "=ds=#sr# 470", "=ds="..AL["Trainer"]};
				{ 9, "s80482", "57194", "=q1=Potion of Concentration", "=ds=#sr# 465", "=ds="..AL["Trainer"]};
				{ 10, "s93935", "67415", "=q1=Draught of War", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 12, "s114760", "76095", "=q1=Potion of Mogu Power", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 13, "s114765", "76089", "=q1=Virmen's Bite", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 14, "s114757", "76093", "=q1=Potion of the Jade Serpent", "=ds=#sr# 525", "=ds="..AL["Discovery"]};
				{ 15, "s114753", "76090", "=q1=Potion of the Mountains", "=ds=#sr# 525", "=ds="..AL["Discovery"]};
				{ 16, "s114782", "76092", "=q1=Potion of Focus", "=ds=#sr# 600", "=ds="..AL["Discovery"]};
				{ 17, "s114779", "76091", "=q1=Potion of Luck", "=ds=#sr# 600", "=ds="..AL["Discovery"]};
				{ 18, "s114774", "76096", "=q1=Darkwater Potion", "=ds=#sr# 575", "=ds="..AL["Discovery"]};
				{ 20, "s80496", "58146", "=q1=Golemblood Potion", "=ds=#sr# 490", "=ds="..AL["Trainer"]};
				{ 21, "s80495", "58145", "=q1=Potion of the Tol'vir", "=ds=#sr# 485", "=ds="..AL["Trainer"]};
				{ 22, "s80481", "58091", "=q1=Volcanic Potion", "=ds=#sr# 460", "=ds="..AL["Trainer"]};
				{ 23, "s80478", "58090", "=q1=Earthen Potion", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 24, "s80725", "58487", "=q1=Potion of Deepholm", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 25, "s80726", "58488", "=q1=Potion of Treasure Finding", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 26, "s80269", "58489", "=q1=Potion of Illusion", "=ds=#sr# 460", "=ds="..AL["Trainer"], amount = "1-2"};
				{ 27, "s54221", "40211", "=q1=Potion of Speed", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 28, "s54222", "40212", "=q1=Potion of Wild Magic", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
			};
			{
				{ 1, "s53904", "40087", "=q1=Powerful Rejuvenation Potion", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 2, "s58868", "43570", "=q1=Endless Mana Potion", "=ds=#sr# 410", "=ds="..AL["Trainer"]};
				{ 3, "s53837", "33448", "=q1=Runic Mana Potion", "=ds=#sr# 410", "=ds="..AL["Trainer"]};
				{ 4, "s58871", "43569", "=q1=Endless Healing Potion", "=ds=#sr# 410", "=ds="..AL["Trainer"]};
				{ 5, "s53836", "33447", "=q1=Runic Healing Potion", "=ds=#sr# 405", "=ds="..AL["Trainer"]};
				{ 6, "s53936", "40213", "=q1=Mighty Arcane Protection Potion", "=ds=#sr# 400", "=ds="..ALIL["Icecrown"]};
				{ 7, "s53939", "40214", "=q1=Mighty Fire Protection Potion", "=ds=#sr# 400", "=ds="..AL["Drop"]};
				{ 8, "s53937", "40215", "=q1=Mighty Frost Protection Potion", "=ds=#sr# 400", "=ds="..AL["Drop"]};
				{ 9, "s53942", "40216", "=q1=Mighty Nature Protection Potion", "=ds=#sr# 400", "=ds="..AL["Drop"]};
				{ 10, "s53938", "40217", "=q1=Mighty Shadow Protection Potion", "=ds=#sr# 400", "=ds="..ALIL["Icecrown"]};
				{ 11, "s53905", "40093", "=q1=Indestructible Potion", "=ds=#sr# 395", "=ds="..AL["Trainer"]};
				{ 12, "s53900", "40081", "=q1=Potion of Nightmares", "=ds=#sr# 380", "=ds="..AL["Trainer"]};
				{ 13, "s53895", "40077", "=q1=Crazy Alchemist's Potion", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 14, "s53839", "40067", "=q1=Icy Mana Potion", "=ds=#sr# 360", "=ds="..AL["Trainer"]};
				{ 15, "s53838", "39671", "=q1=Resurgent Healing Potion", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 16, "s28586", "22850", "=q1=Super Rejuvenation Potion", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 17, "s38961", "31677", "=q1=Fel Mana Potion", "=ds=#sr# 360", "=ds="..ALIL["Shadowmoon Valley"]};
				{ 18, "s28579", "22849", "=q1=Ironshield Potion", "=ds=#sr# 365", "=ds="..AtlasLoot:EJ_GetBossName("Captain Skarloc", 539)..": "..ALIL["Old Hillsbrad Foothills"]};
				{ 19, "s28575", "22845", "=q1=Major Arcane Protection Potion", "=ds=#sr# 360", "=ds="..ALIL["Nagrand"], amount = 5};
				{ 20, "s28571", "22841", "=q1=Major Fire Protection Potion", "=ds=#sr# 360", "=ds="..ALIL["The Mechanar"], amount = 5};
				{ 21, "s28572", "22842", "=q1=Major Frost Protection Potion", "=ds=#sr# 360", "=ds="..AtlasLoot:EJ_GetBossName("Nexus-Prince Shaffar", 537)..": "..ALIL["Mana-Tombs"], amount = 5};
				{ 22, "s28577", "22847", "=q1=Major Holy Protection Potion", "=ds=#sr# 360", "=ds="..ALIL["Blade's Edge Mountains"], amount = 5};
				{ 23, "s28573", "22844", "=q1=Major Nature Protection Potion", "=ds=#sr# 360", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Exalted"], amount = 5};
				{ 24, "s28576", "22846", "=q1=Major Shadow Protection Potion", "=ds=#sr# 360", "=ds="..ALIL["Shadowmoon Valley"], amount = 5};
				{ 25, "s28565", "22839", "=q1=Destruction Potion", "=ds=#sr# 350", "=ds="..AL["World Drop"]};
				{ 26, "s28564", "22838", "=q1=Haste Potion", "=ds=#sr# 350", "=ds="..AL["World Drop"]};
				{ 27, "s28563", "22837", "=q1=Heroic Potion", "=ds=#sr# 350", "=ds="..AL["World Drop"]};
				{ 28, "s28562", "22836", "=q1=Major Dreamless Sleep Potion", "=ds=#sr# 350", "=ds="..AL["Vendor"]};
				{ 29, "s38962", "31676", "=q1=Fel Regeneration Potion", "=ds=#sr# 345", "=ds="..ALIL["Shadowmoon Valley"]};
				{ 30, "s28555", "22832", "=q1=Super Mana Potion", "=ds=#sr# 340", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, "s28554", "22871", "=q1=Shrouding Potion", "=ds=#sr# 335", "=ds="..ALIL["Sporeggar"].." - "..AL["Exalted"]};
				{ 2, "s45061", "34440", "=q1=Mad Alchemist's Potion", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 3, "s28551", "22829", "=q1=Super Healing Potion", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 4, "s28550", "22828", "=q1=Insane Strength Potion", "=ds=#sr# 320", "=ds="..AL["World Drop"]};
				{ 5, "s28546", "22826", "=q1=Sneaking Potion", "=ds=#sr# 315", "=ds="..AL["Vendor"]};
				{ 6, "s33733", "28101", "=q1=Unstable Mana Potion", "=ds=#sr# 310", "=ds="..AL["Trainer"]};
				{ 8, "s22732", "18253", "=q1=Major Rejuvenation Potion", "=ds=#sr# 300", "=ds="..ALIL["Molten Core"]};
				{ 9, "s33732", "28100", "=q1=Volatile Healing Potion", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 10, "s17580", "13444", "=q1=Major Mana Potion", "=ds=#sr# 295", "=ds="..AL["Vendor"]..": "..ALIL["Western Plaguelands"]};
				{ 11, "s17577", "13461", "=q1=Greater Arcane Protection Potion", "=ds=#sr# 290", "=ds="..ALIL["Winterspring"]};
				{ 12, "s17574", "13457", "=q1=Greater Fire Protection Potion", "=ds=#sr# 290", "=ds="..ALIL["Blackrock Spire"]};
				{ 13, "s17575", "13456", "=q1=Greater Frost Protection Potion", "=ds=#sr# 290", "=ds="..ALIL["Winterspring"]};
				{ 14, "s17576", "13458", "=q1=Greater Nature Protection Potion", "=ds=#sr# 290", "=ds="..ALIL["Western Plaguelands"]};
				{ 15, "s17578", "13459", "=q1=Greater Shadow Protection Potion", "=ds=#sr# 290", "=ds="..ALIL["Eastern Plaguelands"]};
				{ 16, "s24367", "20008", "=q1=Living Action Potion", "=ds=#sr# 285", "=ds="..AL["No Longer Available"]};
				{ 17, "s17572", "13462", "=q1=Purification Potion", "=ds=#sr# 285", "=ds="..AL["World Drop"]};
				{ 18, "s17570", "13455", "=q1=Greater Stoneshield Potion", "=ds=#sr# 280", "=ds="..AL["World Drop"]};
				{ 19, "s24366", "20002", "=q1=Greater Dreamless Sleep Potion", "=ds=#sr# 275", "=ds="..AL["No Longer Available"]};
				{ 20, "s17556", "13446", "=q1=Major Healing Potion", "=ds=#sr# 275", "=ds="..AL["Trainer"]};
				{ 21, "s17553", "13443", "=q1=Superior Mana Potion", "=ds=#sr# 260", "=ds="..AL["Trainer"]};
				{ 22, "s17552", "13442", "=q1=Mighty Rage Potion", "=ds=#sr# 255", "=ds="..AL["Trainer"]};
				{ 23, "s3175", "3387", "=q1=Limited Invulnerability Potion", "=ds=#sr# 250", "=ds="..AL["World Drop"]};
				{ 24, "s11464", "9172", "=q1=Invisibility Potion", "=ds=#sr# 235", "=ds="..AL["World Drop"]};
				{ 25, "s15833", "12190", "=q1=Dreamless Sleep Potion", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 26, "s11458", "9144", "=q1=Wildvine Potion", "=ds=#sr# 225", "=ds="..ALIL["The Hinterlands"].."/"..ALIL["Stranglethorn Vale"]};
				{ 27, "s4942", "4623", "=q1=Lesser Stoneshield Potion", "=ds=#sr# 215", "=ds="..BabbleInventory["Quest"]..": "..ALIL["Badlands"]};
				{ 28, "s11457", "3928", "=q1=Superior Healing Potion", "=ds=#sr# 215", "=ds="..AL["Trainer"]};
				{ 29, "s11452", "9030", "=q1=Restorative Potion", "=ds=#sr# 210", "=ds="..BabbleInventory["Quest"]..": "..ALIL["Badlands"]};
				{ 30, "s11448", "6149", "=q1=Greater Mana Potion", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s7258", "6050", "=q1=Frost Protection Potion", "=ds=#sr# 190", "=ds="..AL["Vendor"]};
				{ 2, "s7259", "6052", "=q1=Nature Protection Potion", "=ds=#sr# 190", "=ds="..AL["Vendor"]};
				{ 3, "s6618", "5633", "=q1=Great Rage Potion", "=ds=#sr# 175", "=ds="..AL["Vendor"]};
				{ 4, "s3448", "3823", "=q1=Lesser Invisibility Potion", "=ds=#sr# 165", "=ds="..AL["Trainer"]};
				{ 5, "s7257", "6049", "=q1=Fire Protection Potion", "=ds=#sr# 165", "=ds="..AL["Vendor"]};
				{ 6, "s3452", "3827", "=q1=Mana Potion", "=ds=#sr# 160", "=ds="..AL["Trainer"]};
				{ 7, "s7181", "1710", "=q1=Greater Healing Potion", "=ds=#sr# 155", "=ds="..AL["Trainer"]};
				{ 8, "s6624", "5634", "=q1=Free Action Potion", "=ds=#sr# 150", "=ds="..AL["Vendor"]};
				{ 9, "s7256", "6048", "=q1=Shadow Protection Potion", "=ds=#sr# 135", "=ds="..AL["Vendor"]};
				{ 10, "s3173", "3385", "=q1=Lesser Mana Potion", "=ds=#sr# 120", "=ds="..AL["Trainer"]};
				{ 11, "s3174", "3386", "=q1=Potion of Curing", "=ds=#sr# 120", "=ds="..AL["World Drop"]};
				{ 12, "s3447", "929", "=q1=Healing Potion", "=ds=#sr# 110", "=ds="..AL["Trainer"]};
				{ 13, "s7255", "6051", "=q1=Holy Protection Potion", "=ds=#sr# 100", "=ds="..AL["Vendor"]};
				{ 14, "s7841", "6372", "=q1=Swim Speed Potion", "=ds=#sr# 100", "=ds="..AL["Trainer"]};
				{ 15, "s4508", "4596", "=q1=Discolored Healing Potion", "=ds=#sr# 90", "=ds="..AL["No Longer Available"]};
				{ 16, "s2332", "2456", "=q1=Minor Rejuvenation Potion", "=ds=#sr# 90", "=ds="..AL["Trainer"]};
				{ 17, "s6617", "5631", "=q1=Rage Potion", "=ds=#sr# 60", "=ds="..AL["Vendor"]};
				{ 18, "s2335", "2459", "=q1=Swiftness Potion", "=ds=#sr# 60", "=ds="..AL["World Drop"]};
				{ 19, "s2337", "858", "=q1=Lesser Healing Potion", "=ds=#sr# 55", "=ds="..AL["Trainer"]};
				{ 20, "s2331", "2455", "=q1=Minor Mana Potion", "=ds=#sr# 25", "=ds="..AL["Trainer"]};
				{ 21, "s2330", "118", "=q1=Minor Healing Potion", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ALCHEMY..": "..AL["Potions"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

	AtlasLoot_Data["AlchemyFlask"] = {
		["Normal"] = {
			{
				{ 1, "s114772", "76086", "=q1=Flask of Falling Leaves", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 2, "s114769", "76084", "=q1=Flask of Spring Blossoms", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 3, "s114770", "76087", "=q1=Flask of the Earth", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 4, "s114771", "76085", "=q1=Flask of the Warm Sun", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 5, "s114773", "76088", "=q1=Flask of Winter's Bite", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 7, "s80721", "58087", "=q1=Flask of the Winds", "=ds=#sr# 510", "=ds="..AL["Trainer"]};
				{ 8, "s80723", "58088", "=q1=Flask of Titanic Strength", "=ds=#sr# 510", "=ds="..AL["Trainer"]};
				{ 9, "s80720", "58086", "=q1=Flask of the Draconic Mind", "=ds=#sr# 505", "=ds="..AL["Trainer"]};
				{ 10, "s94162", "67438", "=q1=Flask of Flowing Water", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 11, "s80719", "58085", "=q1=Flask of Steelskin", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 16, "s53903", "46377", "=q1=Flask of Endless Rage", "=ds=#sr# 435", "=ds="..AL["Trainer"], amount = 2};
				{ 17, "s54213", "46378", "=q1=Flask of Pure Mojo", "=ds=#sr# 435", "=ds="..AL["Trainer"], amount = 2};
				{ 18, "s53902", "46379", "=q1=Flask of Stoneblood", "=ds=#sr# 435", "=ds="..AL["Trainer"], amount = 2};
				{ 19, "s53901", "46376", "=q1=Flask of the Frost Wyrm", "=ds=#sr# 435", "=ds="..AL["Trainer"], amount = 2};
				{ 20, "s53899", "40079", "=q1=Lesser Flask of Toughness", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 22, "s114786", "75525", "=q3=Alchemist's Flask", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 23, "s28590", "22861", "=q1=Flask of Blinding Light", "=ds=#sr# 300", "=ds="..AL["Discovery"], amount = 2};
				{ 24, "s28587", "22851", "=q1=Flask of Fortification", "=ds=#sr# 300", "=ds="..AL["Discovery"], amount = 2};
				{ 25, "s28588", "22853", "=q1=Flask of Mighty Restoration", "=ds=#sr# 300", "=ds="..AL["Discovery"], amount = 2};
				{ 26, "s28591", "22866", "=q1=Flask of Pure Death", "=ds=#sr# 300", "=ds="..AL["Discovery"], amount = 2};
				{ 27, "s28589", "22854", "=q1=Flask of Relentless Assault", "=ds=#sr# 300", "=ds="..AL["Discovery"], amount = 2};
				{ 28, "s17636", "13511", "=q1=Flask of Distilled Wisdom", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Exalted"], amount = 2};
				{ 29, "s17637", "13512", "=q1=Flask of Supreme Power", "=ds=#sr# 300", "=ds="..ALIL["Keepers of Time"].." - "..AL["Exalted"], amount = 2};
				{ 30, "s17635", "13510", "=q1=Flask of the Titans", "=ds=#sr# 300", "=ds="..ALIL["The Sha'tar"].." - "..AL["Exalted"], amount = 2};
			};
		};
		info = {
			name = ALCHEMY..": "..AL["Flasks"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

	AtlasLoot_Data["AlchemyTransmute"] = {
		["Normal"] = {
			{
				{ 1, "s114781", "76132", "=q3=Transmute: Primal Diamond", "=ds=#sr# 600", "=ds="..AL["Discovery"]};
				{ 2, "s114784", "76131", "=q3=Transmute: Primordial Ruby", "=ds=#sr# 600", "=ds="..AL["Discovery"]};
				{ 3, "s114777", "76141", "=q3=Transmute: Imperial Amethyst", "=ds=#sr# 575", "=ds="..AL["Discovery"]};
				{ 4, "s114778", "76142", "=q3=Transmute: Sun's Radiance", "=ds=#sr# 575", "=ds="..AL["Discovery"]};
				{ 5, "s114776", "76140", "=q3=Transmute: Vermilion Onyx", "=ds=#sr# 575", "=ds="..AL["Discovery"]};
				{ 6, "s114766", "76138", "=q3=Transmute: River's Heart", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 7, "s114767", "76139", "=q3=Transmute: Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]};
				{ 9, "s80245", "52190", "=q3=Transmute: Inferno Ruby", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 10, "s80237", "52303", "=q3=Transmute: Shadowspirit Diamond", "=ds=#sr# 525", "=ds="..AL["Trainer"], amount = 2};
				{ 11, "s80247", "52195", "=q3=Transmute: Amberjewel", "=ds=#sr# 520", "=ds="..AL["Trainer"]};
				{ 12, "s80248", "52194", "=q3=Transmute: Demonseye", "=ds=#sr# 515", "=ds="..AL["Trainer"]};
				{ 13, "s80246", "52191", "=q3=Transmute: Ocean Sapphire", "=ds=#sr# 515", "=ds="..AL["Trainer"]};
				{ 14, "s80250", "52193", "=q3=Transmute: Ember Topaz", "=ds=#sr# 510", "=ds="..AL["Trainer"]};
				{ 15, "s80251", "52192", "=q3=Transmute: Dream Emerald", "=ds=#sr# 505", "=ds="..AL["Trainer"]};
				{ 16, "s130326", "72104", "=q2=Riddle of Steel", "=ds=#sr# 600", "=ds="..AL["Discovery"]};
				{ 17, "s114780", "72104", "=q2=Transmute: Living Steel", "=ds=#sr# 600", "=ds="..AL["Discovery"]};
				{ 18, "s114783", "72095", "=q2=Transmute: Trillium Bar", "=ds=#sr# 600", "=ds="..AL["Discovery"]};
				{ 20, "s80243", "58480", "=q2=Transmute: Truegold", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 21, "s80244", "51950", "=q2=Transmute: Pyrium Bar", "=ds=#sr# 520", "=ds="..AL["Trainer"]};
				{ 22, "s78866", "54464", "=q1=Transmute: Living Elements", "=ds=#sr# 485", "=ds="..AL["Trainer"], amount = "14-16"};
			};
			{
				{ 1, "s66658", "36931", "=q4=Transmute: Ametrine", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 2, "s66662", "36928", "=q4=Transmute: Dreadstone", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 3, "s66664", "36934", "=q4=Transmute: Eye of Zul", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 4, "s66660", "36922", "=q4=Transmute: King's Amber", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 5, "s66663", "36925", "=q4=Transmute: Majestic Zircon", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 6, "s66659", "36919", "=q4=Transmute: Cardinal Ruby", "=ds=#sr# 440", "=ds="..AL["Quest Reward"]};
				{ 8, "s57425", "41266", "=q3=Transmute: Skyflare Diamond", "=ds=#sr# 430", "=ds="..AL["Trainer"]};
				{ 9, "s57427", "41334", "=q3=Transmute: Earthsiege Diamond", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 12, "s60350", "41163", "=q2=Transmute: Titanium", "=ds=#sr# 395", "=ds="..AL["Trainer"]};
				{ 16, "s53777", "35624", "=q2=Transmute: Eternal Air to Earth", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 17, "s53776", "35622", "=q2=Transmute: Eternal Air to Water", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 18, "s53781", "35623", "=q2=Transmute: Eternal Earth to Air", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 19, "s53782", "35627", "=q2=Transmute: Eternal Earth to Shadow", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 20, "s53775", "35625", "=q2=Transmute: Eternal Fire to Life", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 21, "s53774", "35622", "=q2=Transmute: Eternal Fire to Water", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 22, "s53773", "36860", "=q2=Transmute: Eternal Life to Fire", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 23, "s53771", "35627", "=q2=Transmute: Eternal Life to Shadow", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 24, "s53779", "35624", "=q2=Transmute: Eternal Shadow to Earth", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 25, "s53780", "35625", "=q2=Transmute: Eternal Shadow to Life", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 26, "s53783", "35623", "=q2=Transmute: Eternal Water to Air", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
				{ 27, "s53784", "36860", "=q2=Transmute: Eternal Water to Fire", "=ds=#sr# 400", "=ds="..AL["Discovery"]};
			};
			{
				{ 1, "s29688", "23571", "=q3=Transmute: Primal Might", "=ds=#sr# 350", "=ds="..AL["Vendor"]};
				{ 2, "s32765", "25867", "=q3=Transmute: Earthstorm Diamond", "=ds=#sr# 350", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Honored"]};
				{
					{ 3, "s32766", "25868", "=q3=Transmute: Skyfire Diamond", "=ds=#sr# 350", "=ds="..ALIL["Thrallmar"].." - "..AL["Honored"] };
					{ 3, "s32766", "25868", "=q3=Transmute: Skyfire Diamond", "=ds=#sr# 350", "=ds="..ALIL["Honor Hold"].." - "..AL["Honored"] };
				};
				{ 5, "s28585", "21886", "=q2=Transmute: Primal Earth to Life", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 6, "s28583", "22457", "=q2=Transmute: Primal Fire to Mana", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 7, "s28584", "22452", "=q2=Transmute: Primal Life to Earth", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 8, "s28582", "21884", "=q2=Transmute: Primal Mana to Fire", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 9, "s28580", "21885", "=q2=Transmute: Primal Shadow to Water", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 10, "s28581", "22456", "=q2=Transmute: Primal Water to Shadow", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 11, "s28566", "21884", "=q2=Transmute: Primal Air to Fire", "=ds=#sr# 350", "=ds="..ALIL["The Sha'tar"].." - "..AL["Revered"]};
				{ 12, "s28567", "21885", "=q2=Transmute: Primal Earth to Water", "=ds=#sr# 350", "=ds="..ALIL["Sporeggar"].." - "..AL["Revered"]};
				{
					{ 13, "s28568", "22452", "=q2=Transmute: Primal Fire to Earth", "=ds=#sr# 350", "=ds="..ALIL["The Mag'har"].." - "..AL["Revered"] };
					{ 13, "s28568", "22452", "=q2=Transmute: Primal Fire to Earth", "=ds=#sr# 350", "=ds="..ALIL["Kurenai"].." - "..AL["Revered"] };
				};
				{ 14, "s28569", "22451", "=q2=Transmute: Primal Water to Air", "=ds=#sr# 350", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Revered"]};
				{ 16, "s17187", "12360", "=q2=Transmute: Arcanite", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 17, "s11479", "3577", "=q2=Transmute: Iron to Gold", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 18, "s11480", "6037", "=q2=Transmute: Mithril to Truesilver", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 20, "s25146", "7068", "=q1=Transmute: Elemental Fire", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Blackrock Depths"], amount = 3};
				{ 21, "s17559", "7078", "=q2=Transmute: Air to Fire", "=ds=#sr# 275", "=ds="..ALIL["Argent Dawn"].." - "..AL["Honored"]};
				{ 22, "s17566", "12803", "=q2=Transmute: Earth to Life", "=ds=#sr# 275", "=ds="..AL["World Drop"]};
				{ 23, "s17561", "7080", "=q2=Transmute: Earth to Water", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Felwood"]};
				{ 24, "s17560", "7076", "=q2=Transmute: Fire to Earth", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Blackrock Depths"]};
				{ 25, "s17565", "7076", "=q2=Transmute: Life to Earth", "=ds=#sr# 275", "=ds="..AL["World Drop"]};
				{ 26, "s17563", "7080", "=q2=Transmute: Undeath to Water", "=ds=#sr# 275", "=ds="..AL["World Drop"]};
				{ 27, "s17562", "7082", "=q2=Transmute: Water to Air", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Western Plaguelands"]};
				{ 28, "s17564", "12808", "=q2=Transmute: Water to Undeath", "=ds=#sr# 275", "=ds="..AL["World Drop"]};
			};
		};
		info = {
			name = ALCHEMY..": "..AL["Transmutes"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

	AtlasLoot_Data["AlchemyCauldron"] = {
		["Normal"] = {
			{
				{ 1, "s92688", "65460", "=q1=Big Cauldron of Battle", "=ds=#sr# 525", "=ds="..ALIL["Guild"].." - "..AL["Friendly"]};
				{ 2, "s92643", "62288", "=q1=Cauldron of Battle", "=ds=#sr# 525", "=ds="..ALIL["Guild"].." - "..AL["Friendly"]};
				{ 16, "s41458", "32839", "=q1=Cauldron of Major Arcane Protection Potion", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 17, "s41500", "32849", "=q1=Cauldron of Major Fire Protection Potion", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 18, "s41501", "32850", "=q1=Cauldron of Major Frost Protection Potion", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 19, "s41502", "32851", "=q1=Cauldron of Major Nature Protection Potion", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
				{ 20, "s41503", "32852", "=q1=Cauldron of Major Shadow Protection Potion", "=ds=#sr# 300", "=ds="..AL["Discovery"]};
			};
		};
		info = {
			name = ALCHEMY..": "..AL["Cauldron"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

	AtlasLoot_Data["AlchemyOil"] = {
		["Normal"] = {
			{
				{ 1, "s114761", "87872", "=q1=Desecrated Oil", "=ds=#sr# 550", "=ds="..AL["Discovery"], amount = 2};
				{ 2, "s80486", "56850", "=q1=Deepstone Oil", "=ds=#sr# 470", "=ds="..AL["Trainer"], amount = "1-2"};
				{ 3, "s62409", "44958", "=q1=Ethereal Oil", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 4, "s53812", "40195", "=q1=Pygmy Oil", "=ds=#sr# 375", "=ds="..AL["Trainer"], amount = "1-2"};
				{ 5, "s17551", "13423", "=q1=Stonescale Oil", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 6, "s11451", "8956", "=q1=Oil of Immolation", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 16, "s3454", "3829", "=q1=Frost Oil", "=ds=#sr# 200", "=ds="..AL["Vendor"]..": "..ALIL["Hillsbrad Foothills"]};
				{ 17, "s3449", "3824", "=q1=Shadow Oil", "=ds=#sr# 165", "=ds="..AL["Vendor"]};
				{ 18, "s7837", "6371", "=q1=Fire Oil", "=ds=#sr# 130", "=ds="..AL["Trainer"]};
				{ 19, "s7836", "6370", "=q1=Blackmouth Oil", "=ds=#sr# 80", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ALCHEMY..": "..AL["Oil"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

	AtlasLoot_Data["AlchemyMisc"] = {
		["Normal"] = {
			{
				{ 1, "s136197", "75274", "=q3=Zen Alchemist Stone", "=ds=#sr# 515", "=ds="..AL["Trainer"]};
				{ 3, "s80508", "58483", "=q4=Lifebound Alchemist Stone", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 4, "s96252", "68775", "=q4=Volatile Alchemist Stone", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 5, "s96253", "68776", "=q4=Quicksilver Alchemist Stone", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 6, "s96254", "68777", "=q4=Vibrant Alchemist Stone", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 8, "s60403", "44323", "=q3=Indestructible Alchemist Stone", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 9, "s60396", "44322", "=q3=Mercurial Alchemist Stone", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 10, "s60405", "44324", "=q3=Mighty Alchemist Stone", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 16, "s47050", "35751", "=q4=Assassin's Alchemist Stone", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"]};
				{ 17, "s47046", "35748", "=q4=Guardian's Alchemist Stone", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"]};
				{ 18, "s47049", "35750", "=q4=Redeemer's Alchemist Stone", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"]};
				{ 19, "s47048", "35749", "=q4=Sorcerer's Alchemist Stone", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"]};
				{ 20, "s17632", "13503", "=q4=Alchemist's Stone", "=ds=#sr# 350", "=ds="..ALIL["The Sha'tar"].." - "..AL["Revered"]};
				{ 22, "s38070", "31080", "=q2=Mercurial Stone", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 23, "s11459", "9149", "=q2=Philosopher's Stone", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 24, "s11456", "9061", "=q1=Goblin Rocket Fuel", "=ds=#sr# 210", "=ds="..AL["Crafted"]..": "..GetSpellInfo(4036)};
				{ 25, "s11473", "9210", "=q1=Ghost Dye", "=ds=#sr# 245", "=ds="..AL["Vendor"]..": "..ALIL["Feralas"]};
				{ 26, "s24266", "19931", "=q3=Gurubashi Mojo Madness", "=ds=#sr# 300", "=ds="..AL["No Longer Available"], amount = 3};
			};
		};
		info = {
			name = ALCHEMY..": "..BabbleInventory["Miscellaneous"],
			module = moduleName, menu = "ALCHEMYMENU",
		};
	};

		-------------------
		--- Archaeology ---
		-------------------

	AtlasLoot_Data["ArchaeologyArmorAndWeapons"] = {
		["Normal"] = {
			{
				{ 2, "s92163", "64885", "=q4=Scimitar of the Sirocco", "=ds="..AL["Tol'vir"], "=ds=#h1#, #w10#"};
				{ 3, "s90608", "64377", "=q4=Zin'rokh, Destroyer of Worlds", "=ds="..AL["Troll"], "=ds=#h2#, #w10#"};
				{ 4, "s90997", "64460", "=q4=Nifflevar Bearded Axe", "=ds="..AL["Vrykul"], "=ds=#h1#, #w1#"};
				{ 5, "s92139", "64880", "=q4=Staff of Ammunae", "=ds="..AL["Tol'vir"], "=ds=#w9#"};
				{ 6, "s91227", "64489", "=q4=Staff of Sorcerer-Thane Thaurissan", "=ds="..AL["Dwarf"], "=ds=#w9#"};
				{ 7, "s98533", "69764", "=q4=Extinct Turtle Shell", "=ds="..AL["Fossil"], "=ds=#w8#"};
				{ 8, "s113981", "89685", "=q3=Spear of Xuen", "=ds="..AL["Pandaren"], "=ds=#w7#"};
				{ 9, "s139786", "95391", "=q3=Mantid Sky Reaver", "=ds="..AL["Mantid"], "=ds=#h1#, #w10#"};
				{ 10, "s139787", "95392", "=q3=Sonic Pulse Generator", "=ds="..AL["Mantid"], "=ds=#w5#"};
				{ 17, "s90616", "64643", "=q4=Queen Azshara's Dressing Gown", "=ds="..AL["Night Elf"], "=ds=#s5#, #a1#"};
				{ 18, "s90843", "64644", "=q4=Headdress of the First Shaman", "=ds="..AL["Orc"], "=ds=#s1#, #a3#"};
				{ 19, "s92168", "64904", "=q4=Ring of the Boy Emperor", "=ds="..AL["Tol'vir"], "=ds=#s13#"};
				{ 20, "s91757", "64645", "=q4=Tyrande's Favorite Doll", "=ds="..AL["Night Elf"], "=ds=#s14#"};
				{ 21, "s113992", "89611", "=q3=Quilen Statuette", "=ds="..AL["Mogu"], "=ds=#s14#"};
				{ 22, "s113980", "89684", "=q3=Umbrella of Chi-Ji", "=ds="..AL["Pandaren"], "=ds=#s15#"};
			};
		};
		info = {
			name = ARCHAEOLOGY,
			switchText = {AL["Culture"], AL["Slot"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyMisc"] = {
		["Normal"] = {
			{
				{ 2, 67538, "", "=q4=Recipe: Vial of the Sands", "=ds="..AL["Tol'vir"], "=ds=#p1# (525)"};
				{ 3, "s91214", "64481", "=q4=Blessing of the Old God", "=ds="..AL["Fossil"]};
				{ 4, "s91761", "64646", "=q4=Bones of Transformation", "=ds="..AL["Night Elf"]};
				{ 5, "s92145", "64881", "=q4=Pendant of the Scarab Storm", "=ds="..AL["Tol'vir"]};
				{ 6, "s91215", "64482", "=q4=Puzzle Box of Yogg-Saron", "=ds="..AL["Fossil"]};
				{ 7, "s91773", "64651", "=q4=Wisp Amulet", "=ds="..AL["Night Elf"]};
				{ 17, "s98560", "69776", "=q3=Ancient Amber", "=ds="..AL["Fossil"], "=ds="};
				{ 18, "s90983", "64456", "=q3=Arrival of the Naaru", "=ds="..AL["Draenei"]};
				{ 19, "s90553", "64373", "=q3=Chalice of the Mountain Kings", "=ds="..AL["Dwarf"]};
				{ 20, "s90493", "64361", "=q3=Druid and Priest Statue Set", "=ds="..AL["Night Elf"]};
				{ 21, "s98556", "69777", "=q3=Haunted War Drum", "=ds="..AL["Troll"]};
				{ 22, "s90464", "64358", "=q3=Highborne Soul Mirror", "=ds="..AL["Night Elf"]};
				{ 23, "s90614", "64383", "=q3=Kaldorei Wind Chimes", "=ds="..AL["Night Elf"]};
				{ 24, "s91226", "64488", "=q3=The Innkeeper's Daughter", "=ds="..AL["Dwarf"]};
				{ 25, "s90984", "64457", "=q3=The Last Relic of Argus", "=ds="..AL["Draenei"]};
				{ 26, "s98569", "69775", "=q3=Vrykul Drinking Horn", "=ds="..AL["Vrykul"]};
			};
		};
		info = {
			name = ARCHAEOLOGY,
			switchText = {AL["Culture"], AL["Slot"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyDraenei"] = {
		["Normal"] = {
			{
				{ 2, "s90983", "64456", "=q3=Arrival of the Naaru", "=ds=#sr# 300" };
				{ 4, "s90853", "64440", "=q0=Anklet with Golden Bells", "=ds=#sr# 300"};
				{ 5, "s90968", "64453", "=q0=Baroque Sword Scabbard", "=ds=#sr# 300"};
				{ 6, "s90860", "64442", "=q0=Carved Harp of Exotic Wood", "=ds=#sr# 300"};
				{ 7, "s90975", "64455", "=q0=Dignified Portrait", "=ds=#sr# 300"};
				{ 17, "s90984", "64457", "=q3=The Last Relic of Argus", "=ds=#sr# 300" };
				{ 19, "s90974", "64454", "=q0=Fine Crystal Candelabra", "=ds=#sr# 300"};
				{ 20, "s90987", "64458", "=q0=Plated Elekk Goad", "=ds=#sr# 300"};
				{ 21, "s90864", "64444", "=q0=Scepter of the Nathrezim", "=ds=#sr# 300", "#ACHIEVEMENTID:4858#"};
				{ 22, "s90861", "64443", "=q0=Strange Silver Paperweight", "=ds=#sr# 300"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Draenei"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyDwarf"] = {
		["Normal"] = {
			{
				{ 1, "s91227", "64489", "=q4=Staff of Sorcerer-Thane Thaurissan", "=ds=#sr# 75", "=ds=#w9#"};
				{ 3, "s90521", "64372", "=q3=Clockwork Gnome", "=ds=#sr# 75", "=ds=#e13#"};
				{ 4, "s90553", "64373", "=q3=Chalice of the Mountain Kings", "=ds=#sr# 75"};
				{ 5, "s91226", "64488", "=q3=The Innkeeper's Daughter", "=ds=#sr# 75"};
				{ 7, "s88910", "63113", "=q0=Belt Buckle with Anvilmar Crest", "=ds=#sr# 1"};
				{ 8, "s90411", "64339", "=q0=Bodacious Door Knocker", "=ds=#sr# 1"};
				{ 9, "s86866", "63112", "=q0=Bone Gaming Dice", "=ds=#sr# 1"};
				{ 10, "s90412", "64340", "=q0=Boot Heel with Scrollwork", "=ds=#sr# 1"};
				{ 11, "s86864", "63409", "=q0=Ceramic Funeral Urn", "=ds=#sr# 1"};
				{ 12, "s90504", "64362", "=q0=Dented Shield of Horuz Killcrow", "=ds=#sr# 1", "#ACHIEVEMENTID:5193#"};
				{ 13, "s93440", "66054", "=q0=Dwarven Baby Socks", "=ds=#sr# 1"};
				{ 14, "s90413", "64342", "=q0=Golden Chamber Pot", "=ds=#sr# 1"};
				{ 15, "s90419", "64344", "=q0=Ironstar's Petrified Shield", "=ds=#sr# 1", "#ACHIEVEMENTID:4859#"};
				{ 16, "s90518", "64368", "=q0=Mithril Chain of Angerforge", "=ds=#sr# 1", "#ACHIEVEMENTID:4859#"};
				{ 17, "s89717", "63414", "=q0=Moltenfist's Jeweled Goblet", "=ds=#sr# 1", "#ACHIEVEMENTID:4859#"};
				{ 18, "s90410", "64337", "=q0=Notched Sword of Tunadil the Redeemer", "=ds=#sr# 1", "#ACHIEVEMENTID:5193#"};
				{ 19, "s86857", "63408", "=q0=Pewter Drinking Cup", "=ds=#sr# 1"};
				{ 20, "s91793", "64659", "=q0=Pipe of Franclorn Forgewright", "=ds=#sr# 1"};
				{ 21, "s91225", "64487", "=q0=Scepter of Bronzebeard", "=ds=#sr# 1", "#ACHIEVEMENTID:4858#"};
				{ 22, "s90509", "64367", "=q0=Scepter of Charlga Razorflank", "=ds=#sr# 1", "#ACHIEVEMENTID:4858#"};
				{ 23, "s90506", "64366", "=q0=Scorched Staff of Shadow Priest Anund", "=ds=#sr# 1", "#ACHIEVEMENTID:5193#"};
				{ 24, "s91219", "64483", "=q0=Silver Kris of Korl", "=ds=#sr# 1", "#ACHIEVEMENTID:5193#"};
				{ 25, "s88181", "63411", "=q0=Silver Neck Torc", "=ds=#sr# 1"};
				{ 26, "s90519", "64371", "=q0=Skull Staff of Shadowforge", "=ds=#sr# 1", "#ACHIEVEMENTID:4859#"};
				{ 27, "s91223", "64485", "=q0=Spiked Gauntlets of Anvilrage", "=ds=#sr# 1", "#ACHIEVEMENTID:4859#"};
				{ 28, "s88180", "63410", "=q0=Stone Gryphon", "=ds=#sr# 1"};
				{ 29, "s91221", "64484", "=q0=Warmaul of Burningeye", "=ds=#sr# 1", "#ACHIEVEMENTID:4859#"};
				{ 30, "s90415", "64343", "=q0=Winged Helm of Corehammer", "=ds=#sr# 1", "#ACHIEVEMENTID:4859#"};
			};
			{
				{ 1, "s88909", "63111", "=q0=Wooden Whistle", "=ds=#sr# 1"};
				{ 2, "s91224", "64486", "=q0=Word of Empress Zoe", "=ds=#sr# 1"};
				{ 3, "s86865", "63110", "=q0=Worn Hunting Knife", "=ds=#sr# 1"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Dwarf"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyFossil"] = {
		["Normal"] = {
			{
				{ 2, "s98533", "69764", "=q4=Extinct Turtle Shell", "=ds=#sr# 75", "=ds=#w8#"};
				{ 3, "s90619", "60954", "=q4=Fossilized Raptor", "=ds=#sr# 75", "=ds=#e26#"};
				{ 6, "s90452", "64355", "=q0=Ancient Shark Jaws", "=ds=#sr# 1"};
				{ 7, "s88930", "63121", "=q0=Beautiful Preserved Fern", "=ds=#sr# 1"};
				{ 8, "s88929", "63109", "=q0=Black Trilobite", "=ds=#sr# 1"};
				{ 9, "s90432", "64349", "=q0=Devilsaur Tooth", "=ds=#sr# 1"};
				{ 10, "s90617", "64385", "=q0=Feathered Raptor Arm", "=ds=#sr# 1"};
				{ 11, "s91132", "64473", "=q0=Imprint of a Kraken Tentacle", "=ds=#sr# 1"};
				{ 17, "s98582", "69821", "=q3=Pterrordax Hatchling", "=ds=#sr# 75", "=ds=#e13#"};
				{ 18, "s98560", "69776", "=q3=Ancient Amber", "=ds=#sr# 75", "=ds="};
				{ 19, "s89693", "60955", "=q3=Fossilized Hatchling", "=ds=#sr# 75", "=ds=#e13#"};
				{ 21, "s90433", "64350", "=q0=Insect in Amber", "=ds=#sr# 1"};
				{ 22, "s91089", "64468", "=q0=Proto-Drake Skeleton", "=ds=#sr# 1"};
				{ 23, "s93442", "66056", "=q0=Shard of Petrified Wood", "=ds=#sr# 1"};
				{ 24, "s93443", "66057", "=q0=Strange Velvet Worm", "=ds=#sr# 1"};
				{ 25, "s89895", "63527", "=q0=Twisted Ammonite Shell", "=ds=#sr# 1"};
				{ 26, "s90618", "64387", "=q0=Vicious Ancient Fish", "=ds=#sr# 1"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Fossil"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyMantid"] = {
		["Normal"] = {
			{
				{ 2, "s139786", "95391", "=q3=Mantid Sky Reaver", "=ds=#sr# 600", "=ds=#h1#, #w10#"};
				{ 4, "s139779", "", "=q1=Ancient Sap Feeder", "=ds=#sr# 600", "#ACHIEVEMENTID:8219#"};
				{ 5, "s139776", "", "=q1=Banner of the Mantid Empire", "=ds=#sr# 600", "#ACHIEVEMENTID:8219#"};
				{ 6, "s139781", "", "=q1=Inert Sound Beacon", "=ds=#sr# 600", "#ACHIEVEMENTID:8219#"};
				{ 7, "s139785", "", "=q1=Kypari Sap Container", "=ds=#sr# 600", "#ACHIEVEMENTID:8219#"};
				{ 17, "s139787", "95392", "=q3=Sonic Pulse Generator", "=ds=#sr# 600", "=ds=#w5#"};
				{ 19, "s139783", "", "=q1=Mantid Lamp", "=ds=#sr# 600", "#ACHIEVEMENTID:8219#"};
				{ 20, "s139784", "", "=q1=Pollen Collector", "=ds=#sr# 600", "#ACHIEVEMENTID:8219#"};
				{ 21, "s139782", "", "=q1=Remains of a Paragon", "=ds=#sr# 600", "#ACHIEVEMENTID:8219#"};
				{ 22, "s139780", "", "=q1=The Praying Mantid", "=ds=#sr# 600", "#ACHIEVEMENTID:8219#"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Mantid"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyMogu"] = {
		["Normal"] = {
			{
				{ 2, "s113993", "89614", "=q3=Anatomical Dummy", "=ds=#sr# 525", "#ACHIEVEMENTID:7334#"};
				{ 4, "s113983", "", "=q1=Cracked Mogu Runestone", "=ds=#sr# 525", "#ACHIEVEMENTID:7335#"};
				{ 5, "s113987", "", "=q1=Edicts of the Thunder King", "=ds=#sr# 525", "#ACHIEVEMENTID:7337#"};
				{ 6, "s113988", "", "=q1=Iron Amulet", "=ds=#sr# 525", "#ACHIEVEMENTID:7335#"};
				{ 7, "s113982", "", "=q1=Manacles of Rebellion", "=ds=#sr# 525", "#ACHIEVEMENTID:7334#"};
				{ 8, "s113990", "", "=q1=Mogu Coin", "=ds=#sr# 525", "#ACHIEVEMENTID:7335#"};
				{ 17, "s113992", "89611", "=q3=Quilen Statuette", "=ds=#sr# 525", "#ACHIEVEMENTID:7336#"};
				{ 19, "s113985", "", "=q1=Petrified Bone Whip", "=ds=#sr# 525", "#ACHIEVEMENTID:7334#"};
				{ 20, "s113984", "", "=q1=Terracotta Arm", "=ds=#sr# 525", "#ACHIEVEMENTID:7336#"};
				{ 21, "s113986", "", "=q1=Thunder King Insignia", "=ds=#sr# 525", "#ACHIEVEMENTID:7335#"};
				{ 22, "s113989", "", "=q1=Warlord's Branding Iron", "=ds=#sr# 525", "#ACHIEVEMENTID:7334#"};
				{ 23, "s113991", "", "=q1=Worn Monument Ledger", "=ds=#sr# 525", "#ACHIEVEMENTID:7337#"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Mogu"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyNerubian"] = {
		["Normal"] = {
			{
				{ 2, "s91214", "64481", "=q4=Blessing of the Old God", "=ds=#sr# 350"};
				{ 4, "s91209", "64479", "=q0=Ewer of Jormungar Blood", "=ds=#sr# 350"};
				{ 5, "s91191", "64477", "=q0=Gruesome Heart Box", "=ds=#sr# 350"};
				{ 6, "s91188", "64476", "=q0=Infested Ruby Ring", "=ds=#sr# 350"};
				{ 7, "s91170", "64475", "=q0=Scepter of Nezar'Azret", "=ds=#sr# 350", "#ACHIEVEMENTID:4858#"};
				{ 17, "s91215", "64482", "=q4=Puzzle Box of Yogg-Saron", "=ds=#sr# 350"};
				{ 19, "s91197", "64478", "=q0=Six-Clawed Cornice", "=ds=#sr# 350"};
				{ 20, "s91133", "64474", "=q0=Spidery Sundial", "=ds=#sr# 350"};
				{ 21, "s91211", "64480", "=q0=Vizier's Scrawled Streamer", "=ds=#sr# 350"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Nerubian"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyNightElf"] = {
		["Normal"] = {
			{
				{ 1, "s91757", "64645", "=q4=Tyrande's Favorite Doll", "=ds=#sr# 75", "=ds=#s14#"};
				{ 2, "s91761", "64646", "=q4=Bones of Transformation", "=ds=#sr# 75", "=ds="};
				{ 3, "s91773", "64651", "=q4=Wisp Amulet", "=ds=#sr# 75"};
				{ 4, "s90616", "64643", "=q4=Queen Azshara's Dressing Gown", "=ds=#sr# 75", "=ds=#s5#, #a1#"};
				{ 6, "s91762", "64647", "=q0=Carcanet of the Hundred Magi", "=ds=#sr# 1"};
				{ 7, "s90610", "64379", "=q0=Chest of Tiny Glass Animals", "=ds=#sr# 1", "#ACHIEVEMENTID:5191#"};
				{ 8, "s89696", "63407", "=q0=Cloak Clasp with Antlers", "=ds=#sr# 1", "#ACHIEVEMENTID:5191#"};
				{ 9, "s89893", "63525", "=q0=Coin from Eldre'Thalas", "=ds=#sr# 1"};
				{ 10, "s90611", "64381", "=q0=Cracked Crystal Vial", "=ds=#sr# 1", "#ACHIEVEMENTID:5191#"};
				{ 11, "s90458", "64357", "=q0=Delicate Music Box", "=ds=#sr# 1", "#ACHIEVEMENTID:5191#"};
				{ 12, "s89896", "63528", "=q0=Green Dragon Ring", "=ds=#sr# 1"};
				{ 13, "s90453", "64356", "=q0=Hairpin of Silver and Malachite", "=ds=#sr# 1", "#ACHIEVEMENTID:5191#"};
				{ 14, "s89009", "63129", "=q0=Highborne Pyxis", "=ds=#sr# 1"};
				{ 16, "s90493", "64361", "=q3=Druid and Priest Statue Set", "=ds=#sr# 75"};
				{ 17, "s90464", "64358", "=q3=Highborne Soul Mirror", "=ds=#sr# 75"};
				{ 18, "s90614", "64383", "=q3=Kaldorei Wind Chimes", "=ds=#sr# 75"};
				{ 21, "s89012", "63130", "=q0=Inlaid Ivory Comb", "=ds=#sr# 1"};
				{ 22, "s90451", "64354", "=q0=Kaldorei Amphora", "=ds=#sr# 1"};
				{ 23, "s93441", "66055", "=q0=Necklace with Elune Pendant", "=ds=#sr# 1"};
				{ 24, "s89014", "63131", "=q0=Scandalous Silk Nightgown", "=ds=#sr# 1"};
				{ 25, "s90612", "64382", "=q0=Scepter of Xavius", "=ds=#sr# 1", "#ACHIEVEMENTID:4858#"};
				{ 26, "s89894", "63526", "=q0=Shattered Glaive", "=ds=#sr# 1"};
				{ 27, "s91766", "64648", "=q0=Silver Scroll Case", "=ds=#sr# 1", "#ACHIEVEMENTID:5191#"};
				{ 28, "s90609", "64378", "=q0=String of Small Pink Pearls", "=ds=#sr# 1"};
				{ 29, "s91769", "64650", "=q0=Umbra Crescent", "=ds=#sr# 1"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Night Elf"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyOrc"] = {
		["Normal"] = {
			{
				{ 2, "s90843", "64644", "=q4=Headdress of the First Shaman", "=ds=#sr# 300", "=ds=#s1#, #a3#"};
				{ 4, "s90831", "64436", "=q0=Fiendish Whip", "=ds=#sr# 300"};
				{ 5, "s90734", "64421", "=q0=Fierce Wolf Figurine", "=ds=#sr# 300"};
				{ 6, "s90728", "64418", "=q0=Gray Candle Stub", "=ds=#sr# 300", "#ACHIEVEMENTID:5192#"};
				{ 7, "s90720", "64417", "=q0=Maul of Stone Guard Mur'og", "=ds=#sr# 300", "#ACHIEVEMENTID:5192#"};
				{ 8, "s90730", "64419", "=q0=Rusted Steak Knife", "=ds=#sr# 300", "#ACHIEVEMENTID:5192#" };
				{ 19, "s90732", "64420", "=q0=Scepter of Nekros Skullcrusher", "=ds=#sr# 300", "#ACHIEVEMENTID:4858#"};
				{ 20, "s90833", "64438", "=q0=Skull Drinking Cup", "=ds=#sr# 300"};
				{ 21, "s90832", "64437", "=q0=Tile of Glazed Clay", "=ds=#sr# 300"};
				{ 22, "s90622", "64389", "=q0=Tiny Bronze Scorpion", "=ds=#sr# 300", "#ACHIEVEMENTID:5192#"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Orc"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyPandaren"] = {
		["Normal"] = {
			{
				{ 2, "s113981", "89685", "=q3=Spear of Xuen", "#ACHIEVEMENTID:7333#"};
				{ 4, "s113977", "", "=q1=Apothecary Tins", "=ds=#sr# 525", "#ACHIEVEMENTID:7332#"};
				{ 5, "s113975", "", "=q1=Carved Bronze Mirror", "=ds=#sr# 525", "#ACHIEVEMENTID:7332#"};
				{ 6, "s113974", "", "=q1=Empty Keg of Brewfather Xin Wo Yin", "=ds=#sr# 525", "#ACHIEVEMENTID:7331#"};
				{ 7, "s113976", "", "=q1=Gold-Inlaid Porcelain Funerary Figurine", "=ds=#sr# 525", "#ACHIEVEMENTID:7332#"};
				{ 8, "s113971", "", "=q1=Pandaren Game Board", "=ds=#sr# 525", "#ACHIEVEMENTID:7359#"};
				{ 17, "s113980", "89684", "=q3=Umbrella of Chi-Ji", "#ACHIEVEMENTID:7333#"};
				{ 19, "s113968", "", "=q1=Pandaren Tea Set", "=ds=#sr# 525", "#ACHIEVEMENTID:7358#"};
				{ 20, "s113978", "", "=q1=Pearl of Yu'lon", "=ds=#sr# 525", "#ACHIEVEMENTID:7333#"};
				{ 21, "s113979", "", "=q1=Standard of Niuzao", "=ds=#sr# 525", "#ACHIEVEMENTID:7333#"};
				{ 22, "s113972", "", "=q1=Twin Stein Set of Brewfather Quan Tou Kuo", "=ds=#sr# 525", "#ACHIEVEMENTID:7331#"};
				{ 23, "s113973", "", "=q1=Walking Cane of Brewfather Ren Yun", "=ds=#sr# 525", "#ACHIEVEMENTID:7331#"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Pandaren"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyTolvir"] = {
		["Normal"] = {
			{
				{ 1, 67538, "", "=q4=Recipe: Vial of the Sands", "=ds=#sr# 450", "=ds=#p1# (525)"};
				{ 2, "s92168", "64904", "=q4=Ring of the Boy Emperor", "=ds=#sr# 450", "=ds=#s13#"};
				{ 3, "s92163", "64885", "=q4=Scimitar of the Sirocco", "=ds=#sr# 450", "=ds=#h1#, #w10#"};
				{ 4, "s92139", "64880", "=q4=Staff of Ammunae", "=ds=#sr# 450", "=ds=#w9#"};
				{ 6, "s91790", "64657", "=q1=Canopic Jar", "=ds=#sr# 450", "#ACHIEVEMENTID:5301#"};
				{ 7, "s91775", "64652", "=q0=Castle of Sand", "=ds=#sr# 450"};
				{ 8, "s91779", "64653", "=q0=Cat Statue with Emerald Eyes", "=ds=#sr# 450", "#ACHIEVEMENTID:5301#"};
				{ 9, "s91785", "64656", "=q0=Engraved Scimitar Hilt", "=ds=#sr# 450", "#ACHIEVEMENTID:5301#"};
				{ 16, "s92137", "60847", "=q4=Crawling Claw", "=ds=#sr# 450", "=ds=#e13#"};
				{ 17, "s92148", "64883", "=q4=Scepter of Azj'Aqir", "=ds=#sr# 450", "=ds=#e12#"};
				{ 18, "s92145", "64881", "=q4=Pendant of the Scarab Storm", "=ds=#sr# 450", "=ds="};
				{ 21, "s91792", "64658", "=q0=Sketch of a Desert Palace", "=ds=#sr# 450", "#ACHIEVEMENTID:5301#"};
				{ 22, "s91780", "64654", "=q0=Soapstone Scarab Necklace", "=ds=#sr# 450", "#ACHIEVEMENTID:5301#"};
				{ 23, "s91782", "64655", "=q0=Tiny Oasis Mosaic", "=ds=#sr# 450", "#ACHIEVEMENTID:5301#"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Tol'vir"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyTroll"] = {
		["Normal"] = {
			{
				{ 2, "s90608", "64377", "=q4=Zin'rokh, Destroyer of Worlds", "=ds=#sr# 75", "=ds=#h2#, #w10#"};
				{ 5, "s90429", "64348", "=q0=Atal'ai Scepter", "=ds=#sr# 1", "#ACHIEVEMENTID:4858#"};
				{ 6, "s90421", "64346", "=q0=Bracelet of Jade and Coins", "=ds=#sr# 1"};
				{ 7, "s89891", "63524", "=q0=Cinnabar Bijou", "=ds=#sr# 1"};
				{ 8, "s90581", "64375", "=q0=Drakkari Sacrificial Knife", "=ds=#sr# 1"};
				{ 9, "s89890", "63523", "=q0=Eerie Smolderthorn Idol", "=ds=#sr# 1"};
				{ 10, "s89711", "63413", "=q0=Feathered Gold Earring", "=ds=#sr# 1"};
				{ 11, "s88907", "63120", "=q0=Fetish of Hir'eek", "=ds=#sr# 1"};
				{ 17, "s98588", "69824", "=q3=Voodoo Figurine", "=ds=#sr# 75", "=ds=#e13#"};
				{ 18, "s98556", "69777", "=q3=Haunted War Drum", "=ds=#sr# 75"};
				{ 20, "s93444", "66058", "=q0=Fine Bloodscalp Dinnerware", "=ds=#sr# 1"};
				{ 21, "s90423", "64347", "=q0=Gahz'rilla Figurine", "=ds=#sr# 1"};
				{ 22, "s89701", "63412", "=q0=Jade Asp with Ruby Eyes", "=ds=#sr# 1"};
				{ 23, "s88908", "63118", "=q0=Lizard Foot Charm", "=ds=#sr# 1"};
				{ 24, "s90420", "64345", "=q0=Skull-Shaped Planter", "=ds=#sr# 1"};
				{ 25, "s90558", "64374", "=q0=Tooth with Gold Filling", "=ds=#sr# 1"};
				{ 26, "s88262", "63115", "=q0=Zandalari Voodoo Doll", "=ds=#sr# 1"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Troll"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

	AtlasLoot_Data["ArchaeologyVrykul"] = {
		["Normal"] = {
			{
				{ 2, "s90997", "64460", "=q4=Nifflevar Bearded Axe", "=ds=#sr# 350", "=ds=#h1#, #w1#" };
				{ 4, "s91014", "64464", "=q0=Fanged Cloak Pin", "=ds=#sr# 350"};
				{ 5, "s91012", "64462", "=q0=Flint Striker", "=ds=#sr# 350"};
				{ 6, "s90988", "64459", "=q0=Intricate Treasure Chest Key", "=ds=#sr# 350"};
				{ 17, "s98569", "69775", "=q3=Vrykul Drinking Horn", "=ds=#sr# 350" };
				{ 19, "s91008", "64461", "=q0=Scramseax", "=ds=#sr# 350"};
				{ 20, "s91084", "64467", "=q0=Thorned Necklace", "=ds=#sr# 350"};
			};
		};
		info = {
			name = ARCHAEOLOGY..": "..AL["Vrykul"],
			switchText = {AL["Skill"], AL["Description"]},
			module = moduleName, menu = "ARCHAEOLOGYMENU"
		};
	};

		---------------------
		--- Blacksmithing ---
		---------------------

	AtlasLoot_Data["SmithingArmorOld"] = {
		["Normal"] = {
			{
				{ 1, "s27589", "22194", "=q4=Black Grasp of the Destroyer", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Ruins of Ahn'Qiraj"]};
				{ 2, "s24399", "20039", "=q4=Dark Iron Boots", "=ds=#sr# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Exalted"]};
				{ 3, "s23637", "19164", "=q4=Dark Iron Gauntlets", "=ds=#sr# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Revered"]};
				{ 4, "s23636", "19148", "=q4=Dark Iron Helm", "=ds=#sr# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Honored"]};
				{ 5, "s20876", "17013", "=q4=Dark Iron Leggings", "=ds=#sr# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Revered"]};
				{ 6, "s20873", "16988", "=q4=Fiery Chain Shoulders", "=ds=#sr# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Revered"]};
				{ 7, "s16746", "12641", "=q4=Invulnerable Mail", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
				{ 8, "s27586", "22198", "=q4=Jagged Obsidian Shield", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Revered"]};
				{ 9, "s16729", "12640", "=q4=Lionheart Helm", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
				{ 10, "s27590", "22191", "=q4=Obsidian Mail Tunic", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Ruins of Ahn'Qiraj"]};
				{ 11, "s16741", "12639", "=q4=Stronghold Gauntlets", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
				{ 12, "s27587", "22196", "=q4=Thick Obsidian Breastplate", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Temple of Ahn'Qiraj"]};
				{ 13, "s27829", "22385", "=q4=Titanic Leggings", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
				{ 14, "s20874", "17014", "=q4=Dark Iron Bracers", "=ds=#sr# 295", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Friendly"]};
				{ 15, "s20872", "16989", "=q4=Fiery Chain Girdle", "=ds=#sr# 295", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Honored"]};
				{ 16, "s24914", "20550", "=q3=Darkrune Breastplate", "=ds=#sr# 300", "=ds=#QUESTID:8324#"};
				{ 17, "s24912", "20549", "=q3=Darkrune Gauntlets", "=ds=#sr# 300", "=ds=#QUESTID:8324#"};
				{ 18, "s24913", "20551", "=q3=Darkrune Helm", "=ds=#sr# 300", "=ds=#QUESTID:8324#"};
				{ 19, "s16745", "12618", "=q3=Enchanted Thorium Breastplate", "=ds=#sr# 300", "=ds=#QUESTID:7649#"};
				{ 20, "s16742", "12620", "=q3=Enchanted Thorium Helm", "=ds=#sr# 300", "=ds=#QUESTID:7651#"};
				{ 21, "s16744", "12619", "=q3=Enchanted Thorium Leggings", "=ds=#sr# 300", "=ds=#QUESTID:7650#"};
				{ 22, "s23633", "19057", "=q3=Gloves of the Dawn", "=ds=#sr# 300", "=ds="..ALIL["Argent Dawn"].." - "..AL["Revered"]};
				{ 23, "s27585", "22197", "=q3=Heavy Obsidian Belt", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Friendly"]};
				{ 24, "s23629", "19048", "=q3=Heavy Timbermaw Boots", "=ds=#sr# 300", "=ds="..ALIL["Timbermaw Hold"].." - "..AL["Revered"]};
				{ 25, "s16728", "12636", "=q3=Helm of the Great Chief", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
				{ 26, "s28463", "22764", "=q3=Ironvine Belt", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Friendly"]};
				{ 27, "s28461", "22762", "=q3=Ironvine Breastplate", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Revered"]};
				{ 28, "s28462", "22763", "=q3=Ironvine Gloves", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Honored"]};
				{ 29, "s27588", "22195", "=q3=Light Obsidian Belt", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Honored"]};
				{ 30, "s16724", "12633", "=q3=Whitesoul Helm", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
			};
			{
				{ 1, "s16663", "12422", "=q2=Imperial Plate Chest", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 2, "s16730", "12429", "=q2=Imperial Plate Leggings", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 3, "s16725", "12420", "=q2=Radiant Leggings", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
				{ 4, "s16731", "12613", "=q2=Runic Breastplate", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Dustwallow Marsh"]};
				{ 5, "s16732", "12614", "=q2=Runic Plate Leggings", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Western Plaguelands"]};
				{ 6, "s16726", "12612", "=q2=Runic Plate Helm", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Dustwallow Marsh"]};
				{ 7, "s16664", "12610", "=q2=Runic Plate Shoulders", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Dustwallow Marsh"]};
				{ 8, "s16662", "12414", "=q2=Thorium Leggings", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 9, "s16657", "12426", "=q2=Imperial Plate Boots", "=ds=#sr# 295", "=ds="..AL["Trainer"]};
				{ 10, "s16658", "12427", "=q2=Imperial Plate Helm", "=ds=#sr# 295", "=ds="..AL["Trainer"]};
				{ 11, "s16659", "12417", "=q2=Radiant Circlet", "=ds=#sr# 295", "=ds="..AL["World Drop"]};
				{ 12, "s16661", "12632", "=q3=Storm Gauntlets", "=ds=#sr# 295", "=ds="..AL["World Drop"]};
				{ 13, "s16660", "12625", "=q3=Dawnbringer Shoulders", "=ds=#sr# 290", "=ds="..AL["World Drop"]};
				{ 14, "s23632", "19051", "=q3=Girdle of the Dawn", "=ds=#sr# 290", "=ds="..ALIL["Argent Dawn"].." - "..AL["Honored"]};
				{ 15, "s23628", "19043", "=q3=Heavy Timbermaw Belt", "=ds=#sr# 290", "=ds="..ALIL["Timbermaw Hold"].." - "..AL["Honored"]};
				{ 16, "s16656", "12419", "=q2=Radiant Boots", "=ds=#sr# 290", "=ds="..AL["World Drop"]};
				{ 17, "s15296", "11604", "=q3=Dark Iron Plate", "=ds=#sr# 285", "=ds="..AL["Drop"]..": "..ALIL["Blackrock Depths"]};
				{ 18, "s16654", "12418", "=q2=Radiant Gloves", "=ds=#sr# 285", "=ds="..AL["World Drop"]};
				{ 19, "s16652", "12409", "=q2=Thorium Boots", "=ds=#sr# 280", "=ds="..AL["Trainer"]};
				{ 20, "s16653", "12410", "=q2=Thorium Helm", "=ds=#sr# 280", "=ds="..AL["Trainer"]};
				{ 21, "s15295", "11605", "=q3=Dark Iron Shoulders", "=ds=#sr# 280", "=ds="..AL["Drop"]..": "..ALIL["Blackrock Depths"]};
				{ 22, "s15293", "11606", "=q3=Dark Iron Mail", "=ds=#sr# 270", "=ds="..AL["Drop"]..": "..ALIL["Blackrock Depths"]};
				{ 23, "s16649", "12425", "=q2=Imperial Plate Bracers", "=ds=#sr# 270", "=ds="..AL["Trainer"]};
				{ 24, "s16648", "12415", "=q2=Radiant Breastplate", "=ds=#sr# 270", "=ds="..AL["World Drop"]};
				{ 25, "s16647", "12424", "=q2=Imperial Plate Belt", "=ds=#sr# 265", "=ds="..AL["Trainer"]};
				{ 26, "s16646", "12428", "=q2=Imperial Plate Shoulders", "=ds=#sr# 265", "=ds="..AL["Trainer"]};
				{ 27, "s16645", "12416", "=q2=Radiant Belt", "=ds=#sr# 260", "=ds="..AL["World Drop"]};
				{ 28, "s16644", "12408", "=q2=Thorium Bracers", "=ds=#sr# 255", "=ds="..AL["Trainer"]};
				{ 29, "s16642", "12405", "=q2=Thorium Armor", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 30, "s16643", "12406", "=q2=Thorium Belt", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s9970", "7934", "=q2=Heavy Mithril Helm", "=ds=#sr# 245", "=ds="..AL["World Drop"]};
				{ 2, "s9966", "7932", "=q2=Mithril Scale Shoulders", "=ds=#sr# 235", "=ds="..AL["World Drop"]};
				{ 3, "s9968", "7933", "=q2=Heavy Mithril Boots", "=ds=#sr# 235", "=ds="..AL["Trainer"]};
				{ 4, "s9959", "7930", "=q2=Heavy Mithril Breastplate", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 5, "s9961", "7931", "=q2=Mithril Coif", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 6, "s9935", "7922", "=q3=Steel Plate Helm", "=ds=#sr# 215", "=ds="..AL["Trainer"]};
				{
					{ 7, "s9937", "7924", "=q2=Mithril Scale Bracers", "=ds=#sr# 215", "=ds="..AL["Vendor"]..": "..ALIL["Swamp of Sorrows"]};
					{ 7, "s9937", "7924", "=q2=Mithril Scale Bracers", "=ds=#sr# 215", "=ds="..AL["Vendor"]..": "..ALIL["The Hinterlands"]};
				};
				{ 8, "s9931", "7920", "=q2=Mithril Scale Pants", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 9, "s9933", "7921", "=q2=Heavy Mithril Pants", "=ds=#sr# 210", "=ds="..AL["World Drop"]};
				{ 10, "s9928", "7919", "=q2=Heavy Mithril Gauntlet", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 11, "s9926", "7918", "=q2=Heavy Mithril Shoulder", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 12, "s9916", "7963", "=q2=Steel Breastplate", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 13, "s3515", "3847", "=q2=Golden Scale Boots", "=ds=#sr# 200", "=ds="..AL["World Drop"]};
				{ 14, "s3511", "3845", "=q2=Golden Scale Cuirass", "=ds=#sr# 195", "=ds="..AL["World Drop"]};
				{ 15, "s3503", "3837", "=q2=Golden Scale Coif", "=ds=#sr# 190", "=ds="..AL["Vendor"]..": "..ALIL["Gadgetzan"]};
				{ 16, "s3513", "3846", "=q2=Polished Steel Boots", "=ds=#sr# 185", "=ds="..AL["World Drop"]};
				{ 17, "s7223", "6040", "=q2=Golden Scale Bracers", "=ds=#sr# 185", "=ds="..AL["Trainer"]};
				{ 18, "s9820", "7917", "=q2=Barbaric Iron Gloves", "=ds=#sr# 185", "=ds=#QUESTID:2755#"};
				{ 19, "s9818", "7916", "=q2=Barbaric Iron Boots", "=ds=#sr# 180", "=ds=#QUESTID:2753#"};
				{ 20, "s3508", "3844", "=q3=Green Iron Hauberk", "=ds=#sr# 180", "=ds="..AL["Trainer"]};
				{ 21, "s9814", "7915", "=q2=Barbaric Iron Helm", "=ds=#sr# 175", "=ds=#QUESTID:2754#"};
				{ 22, "s3505", "3841", "=q2=Golden Scale Shoulders", "=ds=#sr# 175", "=ds="..AL["World Drop"]};
				{ 23, "s3507", "3843", "=q2=Golden Scale Leggings", "=ds=#sr# 170", "=ds="..AL["World Drop"]};
				{ 24, "s3502", "3836", "=q2=Green Iron Helm", "=ds=#sr# 170", "=ds="..AL["Trainer"]};
				{ 25, "s9813", "7914", "=q2=Barbaric Iron Breastplate", "=ds=#sr# 160", "=ds=#QUESTID:2751#"};
				{ 26, "s9811", "7913", "=q2=Barbaric Iron Shoulders", "=ds=#sr# 160", "=ds=#QUESTID:2752#"};
				{ 27, "s3504", "3840", "=q2=Green Iron Shoulders", "=ds=#sr# 160", "=ds="..AL["World Drop"]};
				{ 28, "s3501", "3835", "=q2=Green Iron Bracers", "=ds=#sr# 165", "=ds="..AL["Trainer"]};
				{ 29, "s3506", "3842", "=q2=Green Iron Leggings", "=ds=#sr# 155", "=ds="..AL["Trainer"]};
				{ 30, "s12259", "10423", "=q2=Silvered Bronze Leggings", "=ds=#sr# 155", "=ds="..AL["World Drop"]};
			};
			{
				{ 1, "s3336", "3485", "=q2=Green Iron Gauntlets", "=ds=#sr# 150", "=ds="..AL["World Drop"]};
				{ 2, "s3334", "3484", "=q2=Green Iron Boots", "=ds=#sr# 145", "=ds="..AL["World Drop"]};
				{ 3, "s2675", "2870", "=q3=Shining Silver Breastplate", "=ds=#sr# 145", "=ds="..AL["Trainer"]};
				{ 4, "s3333", "3483", "=q2=Silvered Bronze Gauntlets", "=ds=#sr# 135", "=ds="..AL["Trainer"]};
				{ 5, "s3331", "3482", "=q2=Silvered Bronze Boots", "=ds=#sr# 130", "=ds="..AL["Trainer"]};
				{ 6, "s2673", "2869", "=q2=Silvered Bronze Breastplate", "=ds=#sr# 130", "=ds="..AL["World Drop"]};
				{ 7, "s3330", "3481", "=q2=Silvered Bronze Shoulders", "=ds=#sr# 125", "=ds="..AL["World Drop"]};
				{ 8, "s2672", "2868", "=q2=Patterned Bronze Bracers", "=ds=#sr# 120", "=ds="..AL["Trainer"]};
				{ 9, "s3328", "3480", "=q2=Rough Bronze Shoulders", "=ds=#sr# 110", "=ds="..AL["Trainer"]};
				{ 10, "s2670", "2866", "=q2=Rough Bronze Cuirass", "=ds=#sr# 105", "=ds="..AL["Trainer"]};
				{ 11, "s2668", "2865", "=q2=Rough Bronze Leggings", "=ds=#sr# 105", "=ds="..AL["Trainer"]};
				{ 12, "s8367", "6731", "=q2=Ironforge Breastplate", "=ds=#sr# 100", "=ds=#QUESTID:1618#"};
				{ 13, "s7817", "6350", "=q2=Rough Bronze Boots", "=ds=#sr# 95", "=ds="..AL["Trainer"]};
				{ 14, "s2664", "2854", "=q2=Runed Copper Bracers", "=ds=#sr# 90", "=ds="..AL["Trainer"]};
				{ 15, "s2667", "2864", "=q2=Runed Copper Breastplate", "=ds=#sr# 80", "=ds="..AL["World Drop"]};
				{ 16, "s2666", "2857", "=q2=Runed Copper Belt", "=ds=#sr# 70", "=ds="..AL["Trainer"]};
				{ 17, "s3325", "3474", "=q2=Gemmed Copper Gauntlets", "=ds=#sr# 60", "=ds="..AL["World Drop"]};
				{ 18, "s3324", "3473", "=q2=Runed Copper Pants", "=ds=#sr# 45", "=ds="..AL["Trainer"]};
				{ 19, "s3323", "3472", "=q2=Runed Copper Gauntlets", "=ds=#sr# 40", "=ds="..AL["Trainer"]};
				{ 20, "s3321", "3471", "=q2=Copper Chain Vest", "=ds=#sr# 35", "=ds="..AL["World Drop"]};
				{ 21, "s2661", "2851", "=q1=Copper Chain Belt", "=ds=#sr# 35", "=ds="..AL["Trainer"]};
				{ 22, "s3319", "3469", "=q1=Copper Chain Boots", "=ds=#sr# 20", "=ds="..AL["Trainer"]};
				{ 23, "s2663", "2853", "=q1=Copper Bracers", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 24, "s2662", "2852", "=q1=Copper Chain Pants", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 25, "s12260", "10421", "=q1=Rough Copper Vest", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Armor"].." - "..AL["Classic WoW"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingArmorBC"] = {
		["Normal"] = {
			{
				{ 1, "s36389", "30034", "=q4=Belt of the Guardian", "=ds=#sr# 375"};
				{ 2, "s36391", "30033", "=q4=Boots of the Protector", "=ds=#sr# 375"};
				{ 3, "s34534", "28484", "=q4=Bulwark of Kings", "=ds=#sr# 375"};
				{ 4, "s36257", "28485", "=q4=Bulwark of the Ancient Kings", "=ds=#sr# 375"};
				{ 5, "s41134", "32571", "=q4=Dawnsteel Bracers", "=ds=#sr# 375"};
				{ 6, "s41135", "32573", "=q4=Dawnsteel Shoulders", "=ds=#sr# 375"};
				{ 7, "s36256", "23565", "=q4=Embrace of the Twisting Nether", "=ds=#sr# 375"};
				{ 8, "s38477", "31369", "=q4=Iceguard Breastplate", "=ds=#sr# 375"};
				{ 9, "s38479", "31371", "=q4=Iceguard Helm", "=ds=#sr# 375"};
				{ 10, "s38478", "31370", "=q4=Iceguard Leggings", "=ds=#sr# 375"};
				{ 11, "s36390", "30032", "=q4=Red Belt of Battle", "=ds=#sr# 375"};
				{ 12, "s36392", "30031", "=q4=Red Havoc Boots", "=ds=#sr# 375"};
				{ 13, "s40034", "32403", "=q4=Shadesteel Bracers", "=ds=#sr# 375"};
				{ 14, "s40036", "32401", "=q4=Shadesteel Girdle", "=ds=#sr# 375"};
				{ 15, "s40035", "32404", "=q4=Shadesteel Greaves", "=ds=#sr# 375"};
				{ 16, "s40033", "32402", "=q4=Shadesteel Sabots", "=ds=#sr# 375"};
				{ 17, "s41132", "32568", "=q4=Swiftsteel Bracers", "=ds=#sr# 375"};
				{ 18, "s41133", "32570", "=q4=Swiftsteel Shoulders", "=ds=#sr# 375"};
				{ 19, "s34530", "23564", "=q4=Twisting Nether Chain Shirt", "=ds=#sr# 375"};
				{ 20, "s38473", "31364", "=q4=Wildguard Breastplate", "=ds=#sr# 375"};
				{ 21, "s38476", "31368", "=q4=Wildguard Helm", "=ds=#sr# 375"};
				{ 22, "s38475", "31367", "=q4=Wildguard Leggings", "=ds=#sr# 375"};
				{ 23, "s29669", "23537", "=q4=Black Felsteel Bracers", "=ds=#sr# 365"};
				{ 24, "s29672", "23539", "=q4=Blessed Bracers", "=ds=#sr# 365"};
				{ 25, "s29671", "23538", "=q4=Bracers of the Green Fortress", "=ds=#sr# 365"};
				{ 26, "s29658", "23531", "=q4=Felfury Gauntlets", "=ds=#sr# 365"};
				{ 27, "s29622", "23532", "=q4=Gauntlets of the Iron Tower", "=ds=#sr# 365"};
				{ 28, "s46141", "34378", "=q4=Hard Khorium Battlefists", "=ds=#sr# 365"};
				{ 29, "s46144", "34377", "=q4=Hard Khorium Battleplate", "=ds=#sr# 365"};
				{ 30, "s29664", "23535", "=q4=Helm of the Stalwart Defender", "=ds=#sr# 365"};
			};
			{
				{ 1, "s29668", "23536", "=q4=Oathkeeper's Helm", "=ds=#sr# 365"};
				{ 2, "s29662", "23533", "=q4=Steelgrip Gauntlets", "=ds=#sr# 365"};
				{ 3, "s29663", "23534", "=q4=Storm Helm", "=ds=#sr# 365"};
				{ 4, "s46142", "34379", "=q4=Sunblessed Breastplate", "=ds=#sr# 365"};
				{ 5, "s46140", "34380", "=q4=Sunblessed Gauntlets", "=ds=#sr# 365"};
				{ 6, "s34533", "28483", "=q4=Breastplate of Kings", "=ds=#sr# 350"};
				{ 7, "s34529", "23563", "=q4=Nether Chain Shirt", "=ds=#sr# 350"};
				{ 8, "s29649", "23527", "=q3=Earthpeace Breastplate", "=ds=#sr# 370"};
				{ 9, "s29645", "23522", "=q3=Ragesteel Breastplate", "=ds=#sr# 370"};
				{ 10, "s29648", "23526", "=q3=Swiftsteel Gloves", "=ds=#sr# 370"};
				{ 11, "s29613", "23512", "=q3=Enchanted Adamantite Leggings", "=ds=#sr# 365"};
				{ 12, "s29621", "23519", "=q3=Felsteel Helm", "=ds=#sr# 365"};
				{ 13, "s29617", "23513", "=q3=Flamebane Breastplate", "=ds=#sr# 365"};
				{ 14, "s29630", "23525", "=q3=Khorium Boots", "=ds=#sr# 365"};
				{ 15, "s29642", "23520", "=q3=Ragesteel Gloves", "=ds=#sr# 365"};
				{ 16, "s29643", "23521", "=q3=Ragesteel Helm", "=ds=#sr# 365"};
				{ 17, "s42662", "33173", "=q3=Ragesteel Shoulders", "=ds=#sr# 365"};
				{ 18, "s29610", "23509", "=q3=Enchanted Adamantite Breastplate", "=ds=#sr# 360"};
				{ 19, "s29619", "23517", "=q3=Felsteel Gloves", "=ds=#sr# 360"};
				{ 20, "s29620", "23518", "=q3=Felsteel Leggings", "=ds=#sr# 360"};
				{ 21, "s29616", "23514", "=q3=Flamebane Gloves", "=ds=#sr# 360"};
				{ 22, "s29628", "23524", "=q3=Khorium Belt", "=ds=#sr# 360"};
				{ 23, "s29629", "23523", "=q3=Khorium Pants", "=ds=#sr# 360"};
				{ 24, "s29608", "23510", "=q3=Enchanted Adamantite Belt", "=ds=#sr# 355"};
				{ 25, "s29611", "23511", "=q3=Enchanted Adamantite Boots", "=ds=#sr# 355"};
				{ 26, "s29615", "23516", "=q3=Flamebane Helm", "=ds=#sr# 355"};
				{ 27, "s29614", "23515", "=q3=Flamebane Bracers", "=ds=#sr# 350"};
				{ 28, "s29606", "23507", "=q3=Adamantite Breastplate", "=ds=#sr# 340"};
				{ 29, "s29603", "23506", "=q3=Adamantite Plate Bracers", "=ds=#sr# 335"};
				{ 30, "s29605", "23508", "=q3=Adamantite Plate Gloves", "=ds=#sr# 335"};
			};
			{
				{ 1, "s36129", "30074", "=q3=Heavy Earthforged Breastplate", "=ds=#sr# 330"};
				{ 2, "s36130", "30076", "=q3=Stormforged Hauberk", "=ds=#sr# 330"};
				{ 3, "s29550", "23489", "=q2=Fel Iron Breastplate", "=ds=#sr# 325"};
				{ 4, "s29556", "23490", "=q2=Fel Iron Chain Tunic", "=ds=#sr# 320"};
				{ 5, "s29548", "23487", "=q2=Fel Iron Plate Boots", "=ds=#sr# 315"};
				{ 6, "s29549", "23488", "=q2=Fel Iron Plate Pants", "=ds=#sr# 315"};
				{ 7, "s29553", "23494", "=q2=Fel Iron Chain Bracers", "=ds=#sr# 315"};
				{ 8, "s29552", "23491", "=q2=Fel Iron Chain Gloves", "=ds=#sr# 310"};
				{ 9, "s29547", "23484", "=q2=Fel Iron Plate Belt", "=ds=#sr# 305"};
				{ 10, "s29551", "23493", "=q2=Fel Iron Chain Coif", "=ds=#sr# 300"};
				{ 11, "s29545", "23482", "=q2=Fel Iron Plate Gloves", "=ds=#sr# 300"};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Armor"].." - "..AL["Burning Crusade"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingArmorWrath"] = {
		["Normal"] = {
			{
				{ 1, "s70568", "49907", "=q4=Boots of Kingly Upheaval", "=ds="..AL["Vendor"]..""};
				{ 2, "s70566", "49906", "=q4=Hellfrozen Bonegrinders", "=ds="..AL["Vendor"]..""};
				{ 3, "s70565", "49903", "=q4=Legplates of Painful Death", "=ds="..AL["Vendor"]..""};
				{ 4, "s70567", "49904", "=q4=Pillars of Might", "=ds="..AL["Vendor"]..""};
				{ 5, "s70563", "49905", "=q4=Protectors of Life", "=ds="..AL["Vendor"]..""};
				{ 6, "s70562", "49902", "=q4=Puresteel Legplates", "=ds="..AL["Vendor"]..""};
				{
					{ 7, "s67130", "47592", "=q4=Breastplate of the White Knight", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
					{ 7, "s67091", "47591", "=q4=Breastplate of the White Knight", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				};
				{
					{ 8, "s67131", "47571", "=q4=Saronite Swordbreakers", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
					{ 8, "s67092", "47570", "=q4=Saronite Swordbreakers", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				};
				{
					{ 9, "s67135", "47575", "=q4=Sunforged Bracers", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
					{ 9, "s67096", "47574", "=q4=Sunforged Bracers", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				};
				{
					{ 10, "s67134", "47594", "=q4=Sunforged Breastplate", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
					{ 10, "s67095", "47593", "=q4=Sunforged Breastplate", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				};
				{
					{ 11, "s67132", "47590", "=q4=Titanium Razorplate", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
					{ 11, "s67093", "47589", "=q4=Titanium Razorplate", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				};
				{
					{ 12, "s67133", "47573", "=q4=Titanium Spikeguards", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
					{ 12, "s67094", "47572", "=q4=Titanium Spikeguards", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				};
				{ 13, "s63188", "45559", "=q4=Battlelord's Plate Boots", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 14, "s63187", "45550", "=q4=Belt of the Titans", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 15, "s63191", "45551", "=q4=Indestructible Plate Girdle", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 16, "s63189", "45552", "=q4=Plate Girdle of Righteousness", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 17, "s63192", "45560", "=q4=Spiked Deathdealers", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 18, "s63190", "45561", "=q4=Treads of Destiny", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 19, "s55374", "41388", "=q4=Brilliant Titansteel Helm", "=ds="..AL["Trainer"] };
				{ 20, "s55377", "41394", "=q4=Brilliant Titansteel Treads", "=ds="..AL["Trainer"] };
				{ 21, "s55372", "41386", "=q4=Spiked Titansteel Helm", "=ds="..AL["Trainer"] };
				{ 22, "s55375", "41391", "=q4=Spiked Titansteel Treads", "=ds="..AL["Trainer"] };
				{ 23, "s55373", "41387", "=q4=Tempered Titansteel Helm", "=ds="..AL["Trainer"] };
				{ 24, "s55376", "41392", "=q4=Tempered Titansteel Treads", "=ds="..AL["Trainer"] };
				{ 25, "s56400", "42508", "=q4=Titansteel Shield Wall", "=ds="..AL["Trainer"] };
				{ 26, "s61008", "43586", "=q4=Icebane Chestguard", "=ds="..AL["Trainer"] };
				{ 27, "s61009", "43587", "=q4=Icebane Girdle", "=ds="..AL["Trainer"] };
				{ 28, "s61010", "43588", "=q4=Icebane Treads", "=ds="..AL["Trainer"] };
				{ 29, "s55303", "41345", "=q3=Daunting Legplates", "=ds="..AL["Trainer"] };
				{ 30, "s55302", "41344", "=q3=Helm of Command", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s56555", "42725", "=q3=Ornate Saronite Hauberk", "=ds="..AL["Trainer"] };
				{ 2, "s56554", "42726", "=q3=Ornate Saronite Legplates", "=ds="..AL["Trainer"] };
				{ 3, "s56556", "42728", "=q3=Ornate Saronite Skullshield", "=ds="..AL["Trainer"] };
				{ 4, "s55304", "41346", "=q3=Righteous Greaves", "=ds="..AL["Trainer"] };
				{ 5, "s55311", "41353", "=q3=Savage Saronite Hauberk", "=ds="..AL["Trainer"] };
				{ 6, "s55310", "41347", "=q3=Savage Saronite Legplates", "=ds="..AL["Trainer"] };
				{ 7, "s55312", "41350", "=q3=Savage Saronite Skullshield", "=ds="..AL["Trainer"] };
				{ 8, "s55301", "41357", "=q3=Daunting Handguards", "=ds="..AL["Trainer"] };
				{ 9, "s56553", "42724", "=q3=Ornate Saronite Gauntlets", "=ds="..AL["Trainer"] };
				{ 10, "s56550", "42727", "=q3=Ornate Saronite Pauldrons", "=ds="..AL["Trainer"] };
				{ 11, "s56551", "42729", "=q3=Ornate Saronite Waistguard", "=ds="..AL["Trainer"] };
				{ 12, "s56552", "42730", "=q3=Ornate Saronite Walkers", "=ds="..AL["Trainer"] };
				{ 13, "s55300", "41356", "=q3=Righteous Gauntlets", "=ds="..AL["Trainer"] };
				{ 14, "s55309", "41349", "=q3=Savage Saronite Gauntlets", "=ds="..AL["Trainer"] };
				{ 15, "s55306", "41351", "=q3=Savage Saronite Pauldrons", "=ds="..AL["Trainer"] };
				{ 16, "s55307", "41352", "=q3=Savage Saronite Waistguard", "=ds="..AL["Trainer"] };
				{ 17, "s55308", "41348", "=q3=Savage Saronite Walkers", "=ds="..AL["Trainer"] };
				{ 18, "s56549", "42723", "=q3=Ornate Saronite Bracers", "=ds="..AL["Trainer"] };
				{ 19, "s55305", "41354", "=q3=Savage Saronite Bracers", "=ds="..AL["Trainer"] };
				{ 20, "s55298", "41355", "=q3=Vengeance Bindings", "=ds="..AL["Trainer"] };
				{ 21, "s55058", "41129", "=q3=Brilliant Saronite Breastplate", "=ds="..AL["Trainer"] };
				{ 22, "s59441", "43870", "=q3=Brilliant Saronite Helm", "=ds="..AL["Trainer"] };
				{ 23, "s55186", "41189", "=q3=Chestplate of Conquest", "=ds="..AL["Trainer"] };
				{ 24, "s55187", "41190", "=q3=Legplates of Conquest", "=ds="..AL["Trainer"] };
				{ 25, "s55015", "41114", "=q3=Tempered Saronite Gauntlets", "=ds="..AL["Trainer"] };
				{ 26, "s55014", "41113", "=q3=Saronite Bulwark", "=ds="..AL["Trainer"] };
				{ 27, "s55017", "41116", "=q3=Tempered Saronite Bracers", "=ds="..AL["Trainer"] };
				{ 28, "s55057", "41128", "=q3=Brilliant Saronite Boots", "=ds="..AL["Trainer"] };
				{ 29, "s59440", "43865", "=q3=Brilliant Saronite Pauldrons", "=ds="..AL["Trainer"] };
				{ 30, "s54555", "40673", "=q3=Tempered Saronite Helm", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s54556", "40675", "=q3=Tempered Saronite Shoulders", "=ds="..AL["Trainer"] };
				{ 2, "s59438", "43864", "=q3=Brilliant Saronite Bracers", "=ds="..AL["Trainer"] };
				{ 3, "s55056", "41127", "=q3=Brilliant Saronite Gauntlets", "=ds="..AL["Trainer"] };
				{ 4, "s54552", "40671", "=q3=Tempered Saronite Boots", "=ds="..AL["Trainer"] };
				{ 5, "s54553", "40672", "=q3=Tempered Saronite Breastplate", "=ds="..AL["Trainer"] };
				{ 6, "s59436", "43860", "=q3=Brilliant Saronite Belt", "=ds="..AL["Trainer"] };
				{ 7, "s55055", "41126", "=q3=Brilliant Saronite Legplates", "=ds="..AL["Trainer"] };
				{ 8, "s54551", "40669", "=q3=Tempered Saronite Belt", "=ds="..AL["Trainer"] };
				{ 9, "s54554", "40674", "=q3=Tempered Saronite Legplates", "=ds="..AL["Trainer"] };
				{ 10, "s54557", "40670", "=q3=Saronite Defender", "=ds="..AL["Trainer"] };
				{ 11, "s55013", "41117", "=q3=Saronite Protector", "=ds="..AL["Trainer"] };
				{ 12, "s54949", "40955", "=q2=Horned Cobalt Helm", "=ds="..AL["Trainer"] };
				{ 13, "s54948", "40954", "=q2=Spiked Cobalt Bracers", "=ds="..AL["Trainer"] };
				{ 14, "s54946", "40953", "=q2=Spiked Cobalt Belt", "=ds="..AL["Trainer"] };
				{ 15, "s54947", "40943", "=q2=Spiked Cobalt Legplates", "=ds="..AL["Trainer"] };
				{ 16, "s54945", "40952", "=q2=Spiked Cobalt Gauntlets", "=ds="..AL["Trainer"] };
				{ 17, "s54941", "40950", "=q2=Spiked Cobalt Shoulders", "=ds="..AL["Trainer"] };
				{ 18, "s54918", "40949", "=q2=Spiked Cobalt Boots", "=ds="..AL["Trainer"] };
				{ 19, "s54944", "40951", "=q2=Spiked Cobalt Chestpiece", "=ds="..AL["Trainer"] };
				{ 20, "s54978", "40956", "=q2=Reinforced Cobalt Shoulders", "=ds="..AL["Drop"]..": "..ALIL["Dragonblight"] };
				{ 21, "s54979", "40957", "=q2=Reinforced Cobalt Helm", "=ds="..AL["Drop"]..": "..ALIL["Grizzly Hills"] };
				{ 22, "s54980", "40958", "=q2=Reinforced Cobalt Legplates", "=ds="..AL["Drop"]..": "..ALIL["Zul'Drak"] };
				{ 23, "s54981", "40959", "=q2=Reinforced Cobalt Chestpiece", "=ds="..AL["Drop"]..": "..ALIL["Sholazar Basin"] };
				{ 24, "s54917", "40942", "=q2=Spiked Cobalt Helm", "=ds="..AL["Trainer"] };
				{ 25, "s52570", "39085", "=q2=Cobalt Chestpiece", "=ds="..AL["Trainer"] };
				{ 26, "s52571", "39084", "=q2=Cobalt Helm", "=ds="..AL["Trainer"] };
				{ 27, "s52567", "39086", "=q2=Cobalt Legplates", "=ds="..AL["Trainer"] };
				{ 28, "s55835", "41975", "=q2=Cobalt Gauntlets", "=ds="..AL["Trainer"] };
				{ 29, "s55834", "41974", "=q2=Cobalt Bracers", "=ds="..AL["Trainer"] };
				{ 30, "s52572", "39083", "=q2=Cobalt Shoulders", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s54550", "40668", "=q2=Cobalt Triangle Shield", "=ds="..AL["Trainer"] };
				{ 2, "s52568", "39087", "=q2=Cobalt Belt", "=ds="..AL["Trainer"] };
				{ 3, "s52569", "39088", "=q2=Cobalt Boots", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Armor"].." - "..AL["Wrath of the Lich King"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingArmorCata"] = {
		["Normal"] = {
			{
				{ 1, "s101931", "71992", "=q4=Bracers of Destructive Strength", "=ds=#s8#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 2, "s101932", "71993", "=q4=Titanguard Wristplates", "=ds=#s8#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 3, "s101929", "71991", "=q4=Soul Redeemer Bracers", "=ds=#s8#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 4, "s101925", "71983", "=q4=Unstoppable Destroyer's Legplates", "=ds=#s11#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 5, "s101928", "71984", "=q4=Foundations of Courage", "=ds=#s11#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 6, "s101924", "71982", "=q4=Pyrium Legplates of Purified Evil", "=ds=#s11#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 7, "s99439", "69936", "=q4=Fists of Fury", "=ds=#s9#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 8, "s99440", "69937", "=q4=Eternal Elementium Handguards", "=ds=#s9#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 9, "s99441", "69938", "=q4=Holy Flame Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 10, "s99452", "69946", "=q4=Warboots of Mighty Lords", "=ds=#s12#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 11, "s99453", "69947", "=q4=Mirrored Boots", "=ds=#s12#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 12, "s99454", "69948", "=q4=Emberforged Elementium Boots", "=ds=#s12#, #a4# / =q1=#sk# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 13, "s76464", "75135", "=q3=Vicious Pyrium Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 525", "=ds="..AL["Vendor"]};
				{ 14, "s76463", "75126", "=q3=Vicious Pyrium Helm", "=ds=#s1#, #a4# / =q1=#sk# 525", "=ds="..AL["Vendor"]};
				{ 15, "s76462", "75136", "=q3=Vicious Pyrium Legguards", "=ds=#s11#, #a4# / =q1=#sk# 525", "=ds="..AL["Vendor"]};
				{ 16, "s76472", "75128", "=q3=Vicious Ornate Pyrium Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 525", "=ds="..AL["Vendor"]};
				{ 17, "s76471", "75129", "=q3=Vicious Ornate Pyrium Helm", "=ds=#s1#, #a4# / =q1=#sk# 525", "=ds="..AL["Vendor"]};
				{ 18, "s76470", "75133", "=q3=Vicious Ornate Pyrium Legguards", "=ds=#s11#, #a4# / =q1=#sk# 525", "=ds="..AL["Vendor"]};
				{ 19, "s76461", "75119", "=q3=Vicious Pyrium Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 520", "=ds="..AL["Vendor"]};
				{ 20, "s76469", "75134", "=q3=Vicious Ornate Pyrium Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 520", "=ds="..AL["Vendor"]};
				{ 21, "s76445", "55060", "=q4=Elementium Deathplate", "=ds=#s5#, #a4# / =q1=#sk# 515", "=ds="..AL["Vendor"]};
				{ 22, "s76443", "55058", "=q4=Hardened Elementium Hauberk", "=ds=#s5#, #a4# / =q1=#sk# 515", "=ds="..AL["Vendor"]};
				{ 23, "s76447", "55062", "=q4=Light Elementium Chestguard", "=ds=#s5#, #a4# / =q1=#sk# 515", "=ds="..AL["Vendor"]};
				{ 24, "s76459", "75120", "=q3=Vicious Pyrium Boots", "=ds=#s12#, #a4# / =q1=#sk# 515", "=ds="..AL["Vendor"]};
				{ 25, "s76468", "75132", "=q3=Vicious Ornate Pyrium Boots", "=ds=#s12#, #a4# / =q1=#sk# 515", "=ds="..AL["Vendor"]};
				{ 26, "s76446", "55061", "=q4=Elementium Girdle of Pain", "=ds=#s10#, #a4# / =q1=#sk# 510", "=ds="..AL["Vendor"]};
				{ 27, "s76444", "55059", "=q4=Hardened Elementium Girdle", "=ds=#s10#, #a4# / =q1=#sk# 500", "=ds="..AL["Vendor"]};
				{ 28, "s76448", "55063", "=q4=Light Elementium Belt", "=ds=#s10#, #a4# / =q1=#sk# 510", "=ds="..AL["Vendor"]};
				{ 29, "s76458", "75123", "=q3=Vicious Pyrium Belt", "=ds=#s10#, #a4# / =q1=#sk# 510", "=ds="..AL["Vendor"]};
				{ 30, "s76467", "75118", "=q3=Vicious Ornate Pyrium Belt", "=ds=#s10#, #a4# / =q1=#sk# 510", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, "s76457", "75122", "=q3=Vicious Pyrium Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 505", "=ds="..AL["Vendor"]};
				{ 2, "s76466", "75121", "=q3=Vicious Ornate Pyrium Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 505", "=ds="..AL["Vendor"]};
				{ 3, "s76456", "75124", "=q3=Vicious Pyrium Bracers", "=ds=#s8#, #a4# / =q1=#sk# 500", "=ds="..AL["Vendor"]};
				{ 4, "s76465", "75125", "=q3=Vicious Ornate Pyrium Bracers", "=ds=#s8#, #a4# / =q1=#sk# 500", "=ds="..AL["Vendor"]};
				{ 5, "s76270", "55032", "=q3=Redsteel Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 500", "=ds="..AL["Trainer"] };
				{ 6, "s76261", "55024", "=q2=Hardened Obsidium Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 500", "=ds="..AL["Trainer"]};
				{ 7, "s76289", "55040", "=q2=Stormforged Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 500", "=ds="..AL["Trainer"]};
				{ 8, "s76269", "55031", "=q2=Redsteel Helm", "=ds=#s1#, #a4# / =q1=#sk# 500", "=ds="..AL["Trainer"]};
				{ 9, "s76260", "55023", "=q3=Hardened Obsidium Helm", "=ds=#s1#, #a4# / =q1=#sk# 490", "=ds="..AL["Trainer"]};
				{ 10, "s76288", "55039", "=q3=Stormforged Helm", "=ds=#s1#, #a4# / =q1=#sk# 490", "=ds="..AL["Trainer"]};
				{ 11, "s76259", "55022", "=q2=Hardened Obsidium Legguards", "=ds=#s11#, #a4# / =q1=#sk# 490", "=ds="..AL["Trainer"]};
				{ 12, "s76267", "55030", "=q2=Redsteel Legguards", "=ds=#s11#, #a4# / =q1=#sk# 490", "=ds="..AL["Trainer"]};
				{ 13, "s76287", "55038", "=q3=Stormforged Legguards", "=ds=#s11#, #a4# / =q1=#sk# 480", "=ds="..AL["Trainer"]};
				{ 14, "s76258", "54876", "=q3=Hardened Obsidium Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 480", "=ds="..AL["Trainer"]};
				{ 15, "s76266", "55029", "=q3=Redsteel Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 480", "=ds="..AL["Trainer"]};
				{ 16, "s76286", "55037", "=q3=Stormforged Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 480", "=ds="..AL["Trainer"]};
				{ 17, "s76182", "54854", "=q2=Hardened Obsidium Boots", "=ds=#s12#, #a4# / =q1=#sk# 470", "=ds="..AL["Trainer"]};
				{ 18, "s76265", "55028", "=q2=Redsteel Boots", "=ds=#s12#, #a4# / =q1=#sk# 470", "=ds="..AL["Trainer"]};
				{ 19, "s76285", "55036", "=q2=Stormforged Boots", "=ds=#s12#, #a4# / =q1=#sk# 470", "=ds="..AL["Trainer"]};
				{ 20, "s76181", "54853", "=q2=Hardened Obsidium Belt", "=ds=#s10#, #a4# / =q1=#sk# 460", "=ds="..AL["Trainer"]};
				{ 21, "s76264", "55027", "=q2=Redsteel Belt", "=ds=#s10#, #a4# / =q1=#sk# 460", "=ds="..AL["Trainer"]};
				{ 22, "s76283", "55035", "=q2=Stormforged Belt", "=ds=#s10#, #a4# / =q1=#sk# 460", "=ds="..AL["Trainer"]};
				{ 23, "s76180", "54852", "=q2=Hardened Obsidium Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 450", "=ds="..AL["Trainer"]};
				{ 24, "s76263", "55026", "=q2=Redsteel Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 450", "=ds="..AL["Trainer"]};
				{ 25, "s76281", "55034", "=q3=Stormforged Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 450", "=ds="..AL["Trainer"]};
				{ 26, "s76179", "54850", "=q2=Hardened Obsidium Bracers", "=ds=#s8#, #a4# / =q1=#sk# 440", "=ds="..AL["Trainer"]};
				{ 27, "s76262", "55025", "=q2=Redsteel Bracers", "=ds=#s8#, #a4# / =q1=#sk# 440", "=ds="..AL["Trainer"]};
				{ 28, "s76280", "55033", "=q2=Stormforged Bracers", "=ds=#s8#, #a4# / =q1=#sk# 440", "=ds="..AL["Trainer"]};
				{ 29, "s76291", "55041", "=q2=Hardened Obsidium Shield", "=ds=#w8# / =q1=#sk# 425", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Armor"].." - "..AL["Cataclysm"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingArmorMoP"] = {
		["Normal"] = {
			{
				{ 1, "s142968", "98616", "=q4=Avenger's Trillium Waistplate", "=ds=#s10#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 2, "s142963", "98611", "=q4=Blessed Trillium Belt", "=ds=#s10#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 3, "s142967", "98615", "=q4=Protector's Trillium Waistguard", "=ds=#s10#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 4, "s142959", "98607", "=q4=Avenger's Trillium Legplates", "=ds=#s11#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 5, "s142954", "98602", "=q4=Blessed Trillium Greaves", "=ds=#s11#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 6, "s142958", "98606", "=q4=Protector's Trillium Legguards", "=ds=#s11#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 7, "s126854", "87403", "=q4=Chestplate of Limitless Faith", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 8, "s126852", "87402", "=q4=Ornate Battleplate of the Master", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 9, "s126850", "87405", "=q4=Unyielding Bloodplate", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 10, "s126853", "87407", "=q4=Bloodforged Warfists", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 11, "s126851", "87406", "=q4=Gauntlets of Battle Command", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 12, "s126855", "87404", "=q4=Gauntlets of Unbound Devotion", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 13, "s122653", "82979", "=q4=Breastplate of Ancient Steel", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 14, "s122649", "82975", "=q4=Ghost Reaver's Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 15, "s122651", "82977", "=q4=Living Steel Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 16, "s122654", "82980", "=q4=Gauntlets of Ancient Steel", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 17, "s122650", "82976", "=q4=Ghost Reaver's Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 18, "s122652", "82978", "=q4=Living Steel Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 19, "s143165", "98786", "=q3=Crafted Malevolent Gladiator's Dreadplate Helm", "=ds=#s1#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 20, "s143167", "98788", "=q3=Crafted Malevolent Gladiator's Dreadplate Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 21, "s143163", "98784", "=q3=Crafted Malevolent Gladiator's Dreadplate Chestpiece", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 22, "s143164", "98785", "=q3=Crafted Malevolent Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 23, "s143166", "98787", "=q3=Crafted Malevolent Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 24, "s143181", "98856", "=q3=Crafted Malevolent Gladiator's Ornamented Headcover", "=ds=#s1#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 25, "s143183", "98858", "=q3=Crafted Malevolent Gladiator's Ornamented Spaulders", "=ds=#s3#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 26, "s143179", "98854", "=q3=Crafted Malevolent Gladiator's Ornamented Chestguard", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 27, "s143180", "98855", "=q3=Crafted Malevolent Gladiator's Ornamented Gloves", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 28, "s143182", "98857", "=q3=Crafted Malevolent Gladiator's Ornamented Legplates", "=ds=#s11#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 29, "s143170", "98845", "=q3=Crafted Malevolent Gladiator's Scaled Helm", "=ds=#s1#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 30, "s143172", "98847", "=q3=Crafted Malevolent Gladiator's Scaled Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
			};
			{
				{ 1, "s143168", "98843", "=q3=Crafted Malevolent Gladiator's Scaled Chestpiece", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 2, "s143169", "98844", "=q3=Crafted Malevolent Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 3, "s143171", "98846", "=q3=Crafted Malevolent Gladiator's Scaled Legguards", "=ds=#s11#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 4, "s143192", "98928", "=q3=Crafted Malevolent Gladiator's Plate Helm", "=ds=#s1#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 5, "s143194", "98930", "=q3=Crafted Malevolent Gladiator's Plate Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 6, "s143190", "98926", "=q3=Crafted Malevolent Gladiator's Plate Chestpiece", "=ds=#s5#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 7, "s143191", "98927", "=q3=Crafted Malevolent Gladiator's Plate Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 8, "s143193", "98929", "=q3=Crafted Malevolent Gladiator's Plate Legguards", "=ds=#s11#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 9, "s143189", "98864", "=q3=Crafted Malevolent Gladiator's Armplates of Alacrity", "=ds=#s8#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 10, "s143188", "98863", "=q3=Crafted Malevolent Gladiator's Armplates of Proficiency", "=ds=#s8#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 11, "s143178", "98853", "=q3=Crafted Malevolent Gladiator's Bracers of Meditation", "=ds=#s8#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 12, "s143177", "98852", "=q3=Crafted Malevolent Gladiator's Bracers of Prowess", "=ds=#s8#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 13, "s143173", "98848", "=q3=Crafted Malevolent Gladiator's Clasp of Cruelty", "=ds=#s10#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 14, "s143174", "98849", "=q3=Crafted Malevolent Gladiator's Clasp of Meditation", "=ds=#s10#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 15, "s143184", "98859", "=q3=Crafted Malevolent Gladiator's Girdle of Accuracy", "=ds=#s10#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 16, "s143185", "98860", "=q3=Crafted Malevolent Gladiator's Girdle of Prowess", "=ds=#s10#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 17, "s143175", "98850", "=q3=Crafted Malevolent Gladiator's Greaves of Alacrity", "=ds=#s12#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 18, "s143176", "98851", "=q3=Crafted Malevolent Gladiator's Greaves of Meditation", "=ds=#s12#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 19, "s143187", "98862", "=q3=Crafted Malevolent Gladiator's Warboots of Alacrity", "=ds=#s12#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 20, "s143186", "98861", "=q3=Crafted Malevolent Gladiator's Warboots of Cruelty", "=ds=#s12#, #a4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 21, "s122616", "82943", "=q3=Contender's Revenant Helm", "=ds=#s1#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 22, "s122617", "82944", "=q3=Contender's Revenant Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 23, "s122618", "82945", "=q3=Contender's Revenant Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 24, "s122621", "82948", "=q3=Contender's Revenant Bracers", "=ds=#s8#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 25, "s122619", "82946", "=q3=Contender's Revenant Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 26, "s122623", "82950", "=q3=Contender's Revenant Belt", "=ds=#s10#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 27, "s122620", "82947", "=q3=Contender's Revenant Legplates", "=ds=#s11#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 28, "s122622", "82949", "=q3=Contender's Revenant Boots", "=ds=#s12#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 29, "s122624", "82951", "=q3=Contender's Spirit Helm", "=ds=#s1#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 30, "s122625", "82952", "=q3=Contender's Spirit Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, "s122626", "82953", "=q3=Contender's Spirit Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 2, "s122629", "82956", "=q3=Contender's Spirit Bracers", "=ds=#s8#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 3, "s122627", "82954", "=q3=Contender's Spirit Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 4, "s122631", "82958", "=q3=Contender's Spirit Belt", "=ds=#s10#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 5, "s122628", "82955", "=q3=Contender's Spirit Legplates", "=ds=#s11#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 6, "s122630", "82957", "=q3=Contender's Spirit Boots", "=ds=#s12#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 7, "s122592", "82919", "=q3=Masterwork Spiritguard Helm", "=ds=#s1#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 8, "s122593", "82920", "=q3=Masterwork Spiritguard Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 9, "s122594", "82921", "=q3=Masterwork Spiritguard Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 10, "s122597", "82924", "=q3=Masterwork Spiritguard Bracers", "=ds=#s8#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 11, "s122595", "82922", "=q3=Masterwork Spiritguard Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 12, "s122599", "82926", "=q3=Masterwork Spiritguard Belt", "=ds=#s10#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 13, "s122596", "82923", "=q3=Masterwork Spiritguard Legplates", "=ds=#s11#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 14, "s122598", "82925", "=q3=Masterwork Spiritguard Boots", "=ds=#s12#, #a4# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 15, "s122576", "82903", "=q2=Ghost-Forged Helm", "=ds=#s1#, #a4# / =q1=#sk# 550", "=ds="..AL["Trainer"]};
				{ 16, "s122578", "82905", "=q2=Ghost-Forged Breastplate", "=ds=#s5#, #a4# / =q1=#sk# 550", "=ds="..AL["Trainer"]};
				{ 17, "s122577", "82904", "=q2=Ghost-Forged Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 540", "=ds="..AL["Trainer"]};
				{ 18, "s122580", "82907", "=q2=Ghost-Forged Legplates", "=ds=#s11#, #a4# / =q1=#sk# 530", "=ds="..AL["Trainer"]};
				{ 19, "s122582", "82909", "=q2=Ghost-Forged Boots", "=ds=#s12#, #a4# / =q1=#sk# 530", "=ds="..AL["Trainer"]};
				{ 20, "s122579", "82906", "=q2=Ghost-Forged Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 525", "=ds="..AL["Trainer"]};
				{ 21, "s122583", "82910", "=q2=Ghost-Forged Belt", "=ds=#s10#, #a4# / =q1=#sk# 525", "=ds="..AL["Trainer"]};
				{ 22, "s137769", "94266", "=q4=Haunted Steel Greathelm", "=ds=#s1#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 23, "s137767", "94264", "=q4=Haunted Steel Headcover", "=ds=#s1#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 24, "s137771", "94268", "=q4=Haunted Steel Headguard", "=ds=#s1#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 25, "s137766", "94263", "=q4=Haunted Steel Greaves", "=ds=#s12#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 26, "s137768", "94265", "=q4=Haunted Steel Treads", "=ds=#s12#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 27, "s137770", "94267", "=q4=Haunted Steel Warboots", "=ds=#s12#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 28, "s140844", "93455", "=q3=Crafted Dreadful Gladiator's Dreadplate Helm", "=ds=#s1#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 29, "s140842", "93457", "=q3=Crafted Dreadful Gladiator's Dreadplate Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 30, "s140846", "93453", "=q3=Crafted Dreadful Gladiator's Dreadplate Chestpiece", "=ds=#s5#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
			};
			{
				{ 1, "s140845", "93454", "=q3=Crafted Dreadful Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 2, "s140843", "93456", "=q3=Crafted Dreadful Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 3, "s137784", "93540", "=q3=Crafted Dreadful Gladiator's Ornamented Headcover", "=ds=#s1#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 4, "s137786", "93542", "=q3=Crafted Dreadful Gladiator's Ornamented Spaulders", "=ds=#s3#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 5, "s137782", "93538", "=q3=Crafted Dreadful Gladiator's Ornamented Chestguard", "=ds=#s5#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 6, "s137783", "93539", "=q3=Crafted Dreadful Gladiator's Ornamented Gloves", "=ds=#s9#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 7, "s137785", "93541", "=q3=Crafted Dreadful Gladiator's Ornamented Legplates", "=ds=#s11#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 8, "s137773", "93529", "=q3=Crafted Dreadful Gladiator's Scaled Helm", "=ds=#s1#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 9, "s137775", "93531", "=q3=Crafted Dreadful Gladiator's Scaled Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 10, "s140841", "93527", "=q3=Crafted Dreadful Gladiator's Scaled Chestpiece", "=ds=#s5#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 11, "s137772", "93528", "=q3=Crafted Dreadful Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 12, "s137774", "93530", "=q3=Crafted Dreadful Gladiator's Scaled Legguards", "=ds=#s11#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 13, "s137795", "93622", "=q3=Crafted Dreadful Gladiator's Plate Helm", "=ds=#s1#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 14, "s137797", "93624", "=q3=Crafted Dreadful Gladiator's Plate Shoulders", "=ds=#s3#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 15, "s137793", "93620", "=q3=Crafted Dreadful Gladiator's Plate Chestpiece", "=ds=#s5#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 16, "s137794", "93621", "=q3=Crafted Dreadful Gladiator's Plate Gauntlets", "=ds=#s9#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 17, "s137796", "93623", "=q3=Crafted Dreadful Gladiator's Plate Legguards", "=ds=#s11#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 18, "s137792", "93548", "=q3=Crafted Dreadful Gladiator's Armplates of Alacrity", "=ds=#s8#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 19, "s137791", "93547", "=q3=Crafted Dreadful Gladiator's Armplates of Proficiency", "=ds=#s8#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 20, "s137781", "93537", "=q3=Crafted Dreadful Gladiator's Bracers of Meditation", "=ds=#s8#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 21, "s137780", "93536", "=q3=Crafted Dreadful Gladiator's Bracers of Prowess", "=ds=#s8#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 22, "s137776", "93532", "=q3=Crafted Dreadful Gladiator's Clasp of Cruelty", "=ds=#s10#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 23, "s137777", "93533", "=q3=Crafted Dreadful Gladiator's Clasp of Meditation", "=ds=#s10#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 24, "s137787", "93543", "=q3=Crafted Dreadful Gladiator's Girdle of Accuracy", "=ds=#s10#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 25, "s137788", "93544", "=q3=Crafted Dreadful Gladiator's Girdle of Prowess", "=ds=#s10#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 26, "s137778", "93534", "=q3=Crafted Dreadful Gladiator's Greaves of Alacrity", "=ds=#s12#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 27, "s137779", "93535", "=q3=Crafted Dreadful Gladiator's Greaves of Meditation", "=ds=#s12#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 28, "s137790", "93546", "=q3=Crafted Dreadful Gladiator's Warboots of Alacrity", "=ds=#s12#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 29, "s137789", "93545", "=q3=Crafted Dreadful Gladiator's Warboots of Cruelty", "=ds=#s12#, #a4# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138646)};
				{ 30, "s122581", "82908", "=q2=Ghost-Forged Bracers", "=ds=#s8#, #a4# / =q1=#sk# 500", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Armor"].." - "..AL["Mists of Pandaria"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingWeaponOld"] = {
		["Normal"] = {
			{
				{ 1, "s23638", "19166", "=q4=Black Amnesty", "=ds=#h1#, #w4# / #sk# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Revered"]};
				{ 2, "s23639", "19167", "=q4=Blackfury", "=ds=#w7# / #sk# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Revered"]};
				{ 3, "s23652", "19168", "=q4=Blackguard", "=ds=#h1#, #w10# / #sk# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Exalted"]};
				{ 4, "s23650", "19170", "=q4=Ebon Hand", "=ds=#h1#, #w6# / #sk# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Exalted"]};
				{ 5, "s23653", "19169", "=q4=Nightfall", "=ds=#h2#, #w1# / #sk# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Exalted"]};
				{ 6, "s27830", "22384", "=q4=Persuader", "=ds=#h1#, #w6# / #sk# 300", "=ds="..AL["World Drop"]};
				{ 7, "s27832", "22383", "=q4=Sageblade", "=ds=#h1#, #w10# / #sk# 300", "=ds="..AL["World Drop"]};
				{ 8, "s21161", "17193", "=q4=Sulfuron Hammer", "=ds=#h2#, #w6# / #sk# 300", "=ds=#QUESTID:7604#"};
				{ 9, "s16991", "12798", "=q3=Annihilator", "=ds=#h1#, #w1# / #sk# 300", "=ds="..AL["Drop"]..": "..ALIL["Lower Blackrock Spire"]};
				{ 10, "s16990", "12790", "=q3=Arcanite Champion", "=ds=#h2#, #w10# / #sk# 300", "=ds="..AL["Drop"]..": "..ALIL["Upper Blackrock Spire"]};
				{ 11, "s16994", "12784", "=q3=Arcanite Reaper", "=ds=#h2#, #w1# / #sk# 300", "=ds="..AL["Drop"]..": "..ALIL["Lower Blackrock Spire"]};
				{ 12, "s20897", "17016", "=q3=Dark Iron Destroyer", "=ds=#h1#, #w1# / #sk# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Honored"]};
				{ 13, "s20890", "17015", "=q3=Dark Iron Reaver", "=ds=#h1#, #w10# / #sk# 300", "=ds="..ALIL["Thorium Brotherhood"].." - "..AL["Honored"]};
				{ 14, "s16992", "12797", "=q3=Frostguard", "=ds=#h1#, #w10# / #sk# 300", "=ds="..AL["Drop"]..": "..ALIL["Western Plaguelands"]};
				{ 15, "s16988", "12796", "=q3=Hammer of the Titans", "=ds=#h2#, #w6# / #sk# 300", "=ds="..AL["Drop"]..": "..ALIL["Stratholme"]};
				{ 16, "s16995", "12783", "=q3=Heartseeker", "=ds=#h1#, #w4# / #sk# 300", "=ds="..AL["Drop"]..": "..ALIL["Stratholme"]};
				{ 17, "s16993", "12794", "=q3=Masterwork Stormhammer", "=ds=#h1#, #w6# / #sk# 300", "=ds="..AL["Drop"]..": "..ALIL["Upper Blackrock Spire"]};
				{ 18, "s16985", "12782", "=q3=Corruption", "=ds=#h2#, #w10# / #sk# 290", "=ds="..AL["Drop"]..": "..ALIL["Stratholme"]};
				{ 19, "s16983", "12781", "=q3=Serenity", "=ds=#h1#, #w6# / #sk# 285", "=ds="..AL["Drop"]..": "..ALIL["Stratholme"]};
				{ 20, "s16971", "12775", "=q2=Huge Thorium Battleaxe", "=ds=#h2#, #w1# / #sk# 280", "=ds="..AL["Trainer"]};
				{ 21, "s15294", "11607", "=q3=Dark Iron Sunderer", "=ds=#h2#, #w1# / #sk# 275", "=ds="..AL["Drop"]..": "..ALIL["Blackrock Depths"]};
				{ 22, "s16969", "12773", "=q2=Ornate Thorium Handaxe", "=ds=#h1#, #w1# / #sk# 275", "=ds="..AL["Trainer"]};
				{ 23, "s10007", "7961", "=q3=Phantom Blade", "=ds=#h1#, #w10# / #sk# 270"};
				{ 24, "s15292", "11608", "=q3=Dark Iron Pulverizer", "=ds=#h2#, #w6# / #sk# 265", "=ds="..AL["Drop"]..": "..ALIL["Blackrock Depths"]};
				{ 25, "s10013", "7947", "=q2=Ebon Shiv", "=ds=#h1#, #w4# / #sk# 255", "=ds="..AL["Vendor"]..": "..ALIL["Western Plaguelands"]};
				{ 26, "s10009", "7946", "=q2=Runed Mithril Hammer", "=ds=#h1#, #w6# / #sk# 245", "=ds="..AL["World Drop"]};
				{ 27, "s10005", "7944", "=q2=Dazzling Mithril Rapier", "=ds=#h1#, #w10# / #sk# 240", "=ds="..AL["World Drop"]};
				{ 28, "s10001", "7945", "=q2=Big Black Mace", "=ds=#h1#, #w6# / #sk# 230", "=ds="..AL["Trainer"]};
				{ 29, "s9997", "7943", "=q2=Wicked Mithril Blade", "=ds=#h1#, #w10# / #sk# 225", "=ds="..AL["World Drop"]};
				{ 30, "s9995", "7942", "=q2=Blue Glittering Axe", "=ds=#h1#, #w1# / #sk# 220", "=ds="..AL["World Drop"]};
			};
			{
				{ 1, "s9993", "7941", "=q2=Heavy Mithril Axe", "=ds=#h1#, #w1# / #sk# 210", "=ds="..AL["Trainer"]};
				{ 2, "s3497", "3854", "=q2=Frost Tiger Blade", "=ds=#h2#, #w10# / #sk# 200", "=ds="..AL["World Drop"]};
				{ 3, "s3500", "3856", "=q2=Shadow Crescent Axe", "=ds=#h2#, #w1# / #sk# 200", "=ds="..AL["World Drop"]};
				{ 4, "s21913", "17704", "=q2=Edge of Winter", "=ds=#h1#, #w1# / #sk# 190", "=ds="..AL["Feast of Winter Veil"]};
				{ 5, "s15973", "12260", "=q2=Searing Golden Blade", "=ds=#h1#, #w4# / #sk# 190", "=ds="..AL["World Drop"]};
				{ 6, "s3498", "3855", "=q2=Massive Iron Axe", "=ds=#h2#, #w1# / #sk# 185", "=ds="..AL["Vendor"]..": "..ALIL["Northern Stranglethorn"]};
				{ 7, "s15972", "12259", "=q2=Glinting Steel Dagger", "=ds=#h1#, #w4# / #sk# 180", "=ds="..AL["Trainer"]};
				{ 8, "s3496", "3853", "=q2=Moonsteel Broadsword", "=ds=#h2#, #w10# / #sk# 180", "=ds="..AL["Vendor"]..": "..ALIL["Booty Bay"]};
				{ 9, "s3493", "3850", "=q2=Jade Serpentblade", "=ds=#h1#, #w10# / #sk# 175", "=ds="..AL["World Drop"]};
				{ 10, "s3495", "3852", "=q2=Golden Iron Destroyer", "=ds=#h2#, #w6# / #sk# 170", "=ds="..AL["World Drop"]};
				{ 11, "s3492", "3849", "=q2=Hardened Iron Shortsword", "=ds=#h1#, #w10# / #sk# 160", "=ds="..AL["Vendor"]};
				{ 12, "s3494", "3851", "=q2=Solid Iron Maul", "=ds=#h2#, #w6# / #sk# 155", "=ds="..AL["Vendor"]};
				{ 13, "s3297", "3492", "=q2=Mighty Iron Hammer", "=ds=#h1#, #w6# / #sk# 145", "=ds="..AL["World Drop"]};
				{ 14, "s6518", "5541", "=q2=Iridescent Hammer", "=ds=#h1#, #w6# / #sk# 140", "=ds="..AL["World Drop"]};
				{ 15, "s9987", "7958", "=q2=Bronze Battle Axe", "=ds=#h2#, #w1# / #sk# 135", "=ds="..AL["Trainer"]};
				{ 16, "s9986", "7957", "=q2=Bronze Greatsword", "=ds=#h2#, #w10 / #sk# 130", "=ds="..AL["Trainer"]};
				{ 17, "s3296", "3491", "=q2=Heavy Bronze Mace", "=ds=#h1#, #w6# / #sk# 130", "=ds="..AL["Trainer"]};
				{ 18, "s9985", "7956", "=q2=Bronze Warhammer", "=ds=#h2#, #w6# / #sk# 125", "=ds="..AL["Trainer"]};
				{ 19, "s3295", "3490", "=q2=Deadly Bronze Poniard", "=ds=#h1#, #w4# / #sk# 125", "=ds="..AL["World Drop"]};
				{ 20, "s2742", "2850", "=q2=Bronze Shortsword", "=ds=#h1#, #w10# / #sk# 120", "=ds="..AL["Trainer"]};
				{ 21, "s2741", "2849", "=q2=Bronze Axe", "=ds=#h1#, #w1# / #sk# 115", "=ds="..AL["Trainer"]};
				{ 22, "s2740", "2848", "=q2=Bronze Mace", "=ds=#h1#, #w6# / #sk# 110", "=ds="..AL["Trainer"]};
				{ 23, "s6517", "5540", "=q2=Pearl-Handled Dagger", "=ds=#h1#, #w4# / #sk# 110", "=ds="..AL["Trainer"]};
				{ 24, "s3491", "3848", "=q2=Big Bronze Knife", "=ds=#h1#, #w4# / #sk# 105", "=ds="..AL["Trainer"]};
				{ 25, "s3292", "3487", "=q2=Heavy Copper Broadsword", "=ds=#h2#, #w10# / #sk# 95", "=ds="..AL["Trainer"]};
				{ 26, "s3294", "3489", "=q2=Thick War Axe", "=ds=#h1#, #w1# / #sk# 70", "=ds="..AL["Trainer"]};
				{ 27, "s7408", "6214", "=q2=Heavy Copper Maul", "=ds=#h2#, #w6# / #sk# 65", "=ds="..AL["Trainer"]};
				{ 28, "s3293", "3488", "=q2=Copper Battle Axe", "=ds=#h2#, #w1# / #sk# 35", "=ds="..AL["Trainer"]};
				{ 29, "s43549", "33791", "=q2=Heavy Copper Longsword", "=ds=#h1#, #w10# / #sk# 35", "=ds=#QUESTID:1578#"};
				{ 30, "s9983", "7955", "=q1=Copper Claymore", "=ds=#h2#, #w10# / #sk# 30", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s8880", "7166", "=q1=Copper Dagger", "=ds=#h1#, #w4# / #sk# 30", "=ds="..AL["Trainer"]};
				{ 2, "s2739", "2847", "=q1=Copper Shortsword", "=ds=#h3#, #w10# / #sk# 25", "=ds="..AL["Trainer"]};
				{ 3, "s2738", "2845", "=q1=Copper Axe", "=ds=#h3#, #w1# / #sk# 20", "=ds="..AL["Trainer"]};
				{ 4, "s2737", "2844", "=q1=Copper Mace", "=ds=#h3#, #w6# / #sk# 15", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Weapon"].." - "..AL["Classic WoW"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingWeaponBC"] = {
		["Normal"] = {
			{
				{ 1, "s34542", "28432", "=q4=Black Planar Edge", "=ds=#sr# 375"};
				{ 2, "s36258", "28427", "=q4=Blazefury", "=ds=#sr# 375"};
				{ 3, "s34537", "28426", "=q4=Blazeguard", "=ds=#sr# 375"};
				{ 4, "s36261", "28436", "=q4=Bloodmoon", "=ds=#sr# 375"};
				{ 5, "s34548", "28441", "=q4=Deep Thunder", "=ds=#sr# 375"};
				{ 6, "s34546", "28438", "=q4=Dragonmaw", "=ds=#sr# 375"};
				{ 7, "s36262", "28439", "=q4=Dragonstrike", "=ds=#sr# 375"};
				{ 8, "s34540", "28429", "=q4=Lionheart Champion", "=ds=#sr# 375"};
				{ 9, "s36259", "28430", "=q4=Lionheart Executioner", "=ds=#sr# 375"};
				{ 10, "s34544", "28435", "=q4=Mooncleaver", "=ds=#sr# 375"};
				{ 11, "s36263", "28442", "=q4=Stormherald", "=ds=#sr# 375"};
				{ 12, "s36260", "28433", "=q4=Wicked Edge of the Planes", "=ds=#sr# 375"};
				{ 13, "s29699", "23555", "=q4=Dirge", "=ds=#sr# 365"};
				{ 14, "s29698", "23554", "=q4=Eternium Runed Blade", "=ds=#sr# 365"};
				{ 15, "s29694", "23542", "=q4=Fel Edged Battleaxe", "=ds=#sr# 365"};
				{ 16, "s29697", "23546", "=q4=Fel Hardened Maul", "=ds=#sr# 365"};
				{ 17, "s29692", "23540", "=q4=Felsteel Longblade", "=ds=#sr# 365"};
				{ 18, "s29695", "23543", "=q4=Felsteel Reaper", "=ds=#sr# 365"};
				{ 19, "s43846", "32854", "=q4=Hammer of Righteous Might", "=ds=#sr# 365"};
				{ 20, "s29700", "23556", "=q4=Hand of Eternity", "=ds=#sr# 365"};
				{ 21, "s29693", "23541", "=q4=Khorium Champion", "=ds=#sr# 365"};
				{ 22, "s29696", "23544", "=q4=Runic Hammer", "=ds=#sr# 365"};
				{ 23, "s34545", "28437", "=q4=Drakefist Hammer", "=ds=#sr# 350"};
				{ 24, "s34535", "28425", "=q4=Fireguard", "=ds=#sr# 350"};
				{ 25, "s34538", "28428", "=q4=Lionheart Blade", "=ds=#sr# 350"};
				{ 26, "s34543", "28434", "=q4=Lunar Crescent", "=ds=#sr# 350"};
				{ 27, "s34541", "28431", "=q4=The Planar Edge", "=ds=#sr# 350"};
				{ 28, "s34547", "28440", "=q4=Thunder", "=ds=#sr# 350"};
				{ 29, "s36137", "30093", "=q3=Great Earthforged Hammer", "=ds=#sr# 330"};
				{ 30, "s36136", "30089", "=q3=Lavaforged Warhammer", "=ds=#sr# 330"};
			};
			{
				{ 1, "s36135", "30088", "=q3=Skyforged Great Axe", "=ds=#sr# 330"};
				{ 2, "s36133", "30086", "=q3=Stoneforged Claymore", "=ds=#sr# 330"};
				{ 3, "s36134", "30087", "=q3=Stormforged Axe", "=ds=#sr# 330"};
				{ 4, "s36131", "30077", "=q3=Windforged Rapier", "=ds=#sr# 330"};
				{ 5, "s29571", "23505", "=q2=Adamantite Rapier", "=ds=#sr# 335"};
				{ 6, "s29568", "23503", "=q2=Adamantite Cleaver", "=ds=#sr# 330"};
				{ 7, "s29569", "23504", "=q2=Adamantite Dagger", "=ds=#sr# 330"};
				{ 8, "s29566", "23502", "=q2=Adamantite Maul", "=ds=#sr# 325"};
				{ 9, "s29565", "23499", "=q2=Fel Iron Greatsword", "=ds=#sr# 320"};
				{ 10, "s29558", "23498", "=q2=Fel Iron Hammer", "=ds=#sr# 315"};
				{ 11, "s29557", "23497", "=q2=Fel Iron Hatchet", "=ds=#sr# 310"};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Weapon"].." - "..AL["Burning Crusade"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingWeaponWrath"] = {
		["Normal"] = {
			{
				{ 1, "s63182", "45085", "=q4=Titansteel Spellblade", "=ds="..AL["Trainer"] };
				{ 2, "s55370", "41383", "=q4=Titansteel Bonecrusher", "=ds="..AL["Trainer"] };
				{ 3, "s55369", "41257", "=q4=Titansteel Destroyer", "=ds="..AL["Trainer"] };
				{ 4, "s55371", "41384", "=q4=Titansteel Guardian", "=ds="..AL["Trainer"] };
				{ 5, "s56234", "42435", "=q4=Titansteel Shanker", "=ds="..AL["Trainer"] };
				{ 6, "s55183", "41186", "=q3=Corroded Saronite Edge", "=ds="..AL["Trainer"] };
				{ 7, "s55184", "41187", "=q3=Corroded Saronite Woundbringer", "=ds="..AL["Trainer"] };
				{ 8, "s55185", "41188", "=q3=Saronite Mindcrusher", "=ds="..AL["Trainer"] };
				{ 9, "s56280", "42443", "=q3=Cudgel of Saronite Justice", "=ds="..AL["Trainer"] };
				{ 10, "s55182", "41185", "=q3=Furious Saronite Beatstick", "=ds="..AL["Trainer"] };
				{ 11, "s59442", "43871", "=q3=Saronite Spellblade", "=ds="..AL["Trainer"] };
				{ 12, "s55206", "41245", "=q3=Deadly Saronite Dirk", "=ds="..AL["Trainer"] };
				{ 13, "s55181", "41184", "=q3=Saronite Shiv", "=ds="..AL["Trainer"] };
				{ 14, "s55179", "41183", "=q3=Saronite Ambusher", "=ds="..AL["Trainer"] };
				{ 15, "s55177", "41182", "=q3=Savage Cobalt Slicer", "=ds="..AL["Trainer"] };
				{ 16, "s55174", "41181", "=q3=Honed Cobalt Cleaver", "=ds="..AL["Trainer"] };
				{ 17, "s55204", "41243", "=q2=Notched Cobalt War Axe", "=ds="..AL["Trainer"] };
				{ 18, "s55201", "41240", "=q2=Cobalt Tenderizer", "=ds="..AL["Trainer"] };
				{ 19, "s55200", "41239", "=q2=Sturdy Cobalt Quickblade", "=ds="..AL["Trainer"] };
				{ 20, "s55203", "41242", "=q2=Forged Cobalt Claymore", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Weapon"].." - "..AL["Wrath of the Lich King"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};
	
	AtlasLoot_Data["SmithingWeaponCata"] = {
		["Normal"] = {
			{
				{ 1, "s99652", "70155", "=q4=Brainsplinter", "=ds=#h1#, #w4# / =q1=#sk# 525", "=ds="..ALIL["Molten Front"]};
				{ 2, "s99655", "70158", "=q4=Elementium-Edged Scalper", "=ds=#h1#, #w1# / =q1=#sk# 525", "=ds="..ALIL["Molten Front"]};
				{ 3, "s99654", "70157", "=q4=Lightforged Elementium Hammer", "=ds=#h1#, #w6# / =q1=#sk# 525", "=ds="..ALIL["Molten Front"]};
				{ 4, "s99658", "70164", "=q4=Masterwork Elementium Deathblade", "=ds=#h2#, #w10# / =q1=#sk# 525", "=ds="..ALIL["Molten Front"]};
				{ 5, "s99653", "70156", "=q4=Masterwork Elementium Spellblade", "=ds=#h1#, #w4# / =q1=#sk# 525", "=ds="..ALIL["Molten Front"]};
				{ 6, "s99656", "70162", "=q4=Pyrium Spellward", "=ds=#h1#, #w10# / =q1=#sk# 525", "=ds="..ALIL["Molten Front"]};
				{ 7, "s99657", "70163", "=q4=Unbreakable Guardian", "=ds=#h1#, #w10# / =q1=#sk# 525", "=ds="..ALIL["Molten Front"]};
				{ 8, "s99660", "70165", "=q4=Witch-Hunter's Harvester", "=ds=#h2#, #w7# / =q1=#sk# 525", "=ds="..ALIL["Molten Front"]};
				{ 9, "s76454", "55069", "=q4=Elementium Earthguard", "=ds=#w8# / =q1=#sk# 520", "=ds="..AL["Vendor"]};
				{ 10, "s76455", "55070", "=q4=Elementium Stormshield", "=ds=#w8# / =q1=#sk# 520", "=ds="..AL["Vendor"]};
				{ 11, "s76451", "55066", "=q3=Elementium Poleaxe", "=ds=#w7# / =q1=#sk# 520", "=ds="..AL["Vendor"]};
				{ 12, "s76453", "55068", "=q3=Elementium Shank", "=ds=#h1#, #w4# / =q1=#sk# 520", "=ds="..AL["Vendor"]};
				{ 13, "s76449", "55064", "=q3=Elementium Spellblade", "=ds=#h1#, #w4# / =q1=#sk# 520", "=ds="..AL["Vendor"]};
				{ 14, "s94732", "67605", "=q3=Forged Elementium Mindcrusher", "=ds=#h2#, #w6# / =q1=#sk# 520", "=ds="..AL["Vendor"]};
				{ 15, "s94718", "67602", "=q3=Elementium Gutslicer", "=ds=#h1#, #w1# / =q1=#sk# 515", "=ds="..AL["Vendor"]};
				{ 16, "s76452", "55067", "=q3=Elementium Bonesplitter", "=ds=#h1#, #w1# / =q1=#sk# 515", "=ds="..AL["Vendor"]};
				{ 17, "s76450", "55065", "=q3=Elementium Hammer", "=ds=#h1#, #w6# / =q1=#sk# 515", "=ds="..AL["Vendor"]};
				{ 18, "s76433", "55043", "=q3=Decapitator's Razor", "=ds=#h1#, #w1# / =q1=#sk# 460", "=ds="..AL["Trainer"]};
				{ 19, "s76434", "55044", "=q3=Cold-Forged Shank", "=ds=#h1#, #w4# / =q1=#sk# 470","=ds="..AL["Trainer"]};
				{ 20, "s76474", "55246", "=q3=Obsidium Bladespear", "=ds=#w7# / =q1=#sk# 470","=ds="..AL["Trainer"]};
				{ 21, "s76435", "55045", "=q3=Fire-Etched Dagger", "=ds=#h1#, #w4# / =q1=#sk# 480","=ds="..AL["Trainer"]};
				{ 22, "s76436", "55046", "=q3=Lifeforce Hammer", "=ds=#h1#, #w6#   =q1=#sk# 480","=ds="..AL["Trainer"]};
				{ 23, "s76437", "55052", "=q3=Obsidium Executioner", "=ds=#h2#, #w10# / =q1=#sk# 480","=ds="..AL["Trainer"]};
				{ 24, "s76293", "55042", "=q2=Stormforged Shield", "=ds=#w8# / =q1=#sk# 470","=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Weapon"].." - "..AL["Cataclysm"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingWeaponMoP"] = {
		["Normal"] = {
			{
				{ 1, "s143195", "98776", "=q3=Crafted Malevolent Gladiator's Barrier", "=ds=#w8# / =ds=#sr# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 2, "s143196", "98810", "=q3=Crafted Malevolent Gladiator's Redoubt", "=ds=#w8# / =ds=#sr# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 3, "s143197", "98920", "=q3=Crafted Malevolent Gladiator's Shield Wall", "=ds=#w8# / =ds=#sr# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143255)};
				{ 4, "s122644", "82970", "=q3=Masterwork Forgewire Axe", "=ds=#h1#, #w1# / =ds=#sr# 575", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 5, "s122648", "82974", "=q3=Masterwork Ghost Shard", "=ds=#h1#, #w4# / =ds=#sr# 575", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 6, "s122645", "82971", "=q3=Masterwork Ghost-Forged Blade", "=ds=#h1#, #w10# / =ds=#sr# 575", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 7, "s122646", "82972", "=q3=Masterwork Phantasmal Hammer", "=ds=#h1#, #w6# / =ds=#sr# 575", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 8, "s122647", "82973", "=q3=Masterwork Spiritblade Decimator", "=ds=#h2#, #w1# / =ds=#sr# 575", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 9, "s122642", "82968", "=q3=Masterwork Lightsteel Shield", "=ds=#w8# / =ds=#sr# 575", "=ds="..AL["Vendor"]};
				{ 10, "s122643", "82969", "=q3=Masterwork Spiritguard Shield", "=ds=#w8# / =ds=#sr# 575", "=ds="..AL["Vendor"]};
				{ 11, "s122641", "82967", "=q3=Ghost Shard", "=ds=#h1#, #w4# / =ds=#sr# 565", "=ds="..AL["Trainer"]};
				{ 12, "s122640", "82966", "=q3=Spiritblade Decimator", "=ds=#h2#, #w1# / =ds=#sr# 565", "=ds="..AL["Trainer"]};
				{ 13, "s122639", "82965", "=q3=Phantasmal Hammer", "=ds=#h1#, #w6# / =ds=#sr# 560", "=ds="..AL["Trainer"]};
				{ 14, "s122637", "82963", "=q3=Forgewire Axe", "=ds=#h1#, #w1# / =ds=#sr# 545", "=ds="..AL["Trainer"]};
				{ 15, "s122638", "82964", "=q3=Ghost-Forged Blade", "=ds=#h1#, #w10# / =ds=#sr# 545", "=ds="..AL["Trainer"]};
				{ 16, "s122636", "82962", "=q2=Spiritguard Shield", "=ds=#w8# / =ds=#sr# 545", "=ds="..AL["Trainer"]};
				{ 17, "s122635", "82961", "=q2=Lightsteel Shield", "=ds=#w8# / =ds=#sr# 540", "=ds="..AL["Trainer"]};
				{ 18, "s138892", "94591", "=q4=Blazefury, Reborn", "=ds=#h1#, #w10# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138890)};
				{ 19, "s138881", "94580", "=q4=Bloodmoon, Reborn", "=ds=#h2#, #w1# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138879)};
				{ 20, "s138886", "94585", "=q4=Dragonstrike, Reborn", "=ds=#h1#, #w6# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138885)};
				{ 21, "s138893", "94592", "=q4=Lionheart Executioner, Reborn", "=ds=#h2#, #w10# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138891)};
				{ 22, "s138887", "94586", "=q4=Stormherald, Reborn", "=ds=#h2#, #w6# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138884)};
				{ 23, "s138880", "94579", "=q4=Wicked Edge of the Planes, Reborn", "=ds=#h1#, #w1# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138878)};
				{ 24, "s138878", "94577", "=q4=Black Planar Edge, Reborn", "=ds=#h1#, #w1# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138876)};
				{ 25, "s138890", "94589", "=q4=Blazeguard, Reborn", "=ds=#h1#, #w10# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138888)};
				{ 26, "s138884", "94583", "=q4=Deep Thunder, Reborn", "=ds=#h2#, #w6# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138883)};
				{ 27, "s138885", "94584", "=q4=Dragonmaw, Reborn", "=ds=#h1#, #w6# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138882)};
				{ 28, "s138891", "94590", "=q4=Lionheart Champion, Reborn", "=ds=#h2#, #w10# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138889)};
				{ 29, "s138879", "94578", "=q4=Mooncleaver, Reborn", "=ds=#h2#, #w1# / =ds=#sr# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(138877)};
				{ 30, "s138882", "94581", "=q3=Drakefist Hammer, Reborn", "=ds=#h1#, #w6# / =ds=#sr# 500", "=ds=#QUESTID:32621#"};
			};
			{
				{ 1, "s138888", "94587", "=q3=Fireguard, Reborn", "=ds=#h1#, #w10# / =ds=#sr# 500", "=ds=#QUESTID:32621#"};
				{ 2, "s138889", "94588", "=q3=Lionheart Blade, Reborn", "=ds=#h2#, #w10# / =ds=#sr# 500", "=ds=#QUESTID:32621#"};
				{ 3, "s138877", "94576", "=q3=Lunar Crescent, Reborn", "=ds=#h2#, #w1# / =ds=#sr# 500", "=ds=#QUESTID:32621#"};
				{ 4, "s138876", "94575", "=q3=The Planar Edge, Reborn", "=ds=#h1#, #w1# / =ds=#sr# 500", "=ds=#QUESTID:32621#"};
				{ 5, "s138883", "94582", "=q3=Thunder, Reborn", "=ds=#h2#, #w6# / =ds=#sr# 500", "=ds=#QUESTID:32621#"};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Weapon"].." - "..AL["Mists of Pandaria"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingArmorEnhancement"] = {
		["Normal"] = {
			{
				{ 1, "s122632", "90046", "=q3=Living Steel Belt Buckle", "=ds=#sr# 600", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 2, "s76439", "55054", "=q3=Ebonsteel Belt Buckle", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 3, "s55656", "41611", "=q3=Eternal Belt Buckle", "=ds=#sr# 415", "=ds="..AL["Trainer"]};
				{ 4, "s55628", "item_socketedbracer", "=ds=Socket Bracer", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 5, "s55641", "INV_GAUNTLETS_61", "=ds=Socket Gloves", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 7, "s32285", "25521", "=q1=Greater Rune of Warding", "=ds=#sr# 350", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Honored"]};
				{ 8, "s32284", "23559", "=q1=Lesser Rune of Warding", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 10, "s9964", "7969", "=q2=Mithril Spurs", "=ds=#sr# 235", "=ds="..AL["World Drop"]};
				{ 16, "s131928", "86599", "=q1=Ghost Iron Shield Spike", "=ds=#sr# 540", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 17, "s76440", "55056", "=q3=Pyrium Shield Spike", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 18, "s76441", "55055", "=q2=Elementium Shield Spike", "=ds=#sr# 490", "=ds="..AL["Trainer"]};
				{ 19, "s56357", "42500", "=q2=Titanium Shield Spike", "=ds=#sr# 420", "=ds="..AL["Trainer"]};
				{
					{ 20, "s29657", "23530", "=q2=Felsteel Shield Spike", "=ds=#sr# 360", "=ds="..ALIL["Thrallmar"].." - "..AL["Exalted"]};
					{ 20, "s29657", "23530", "=q2=Felsteel Shield Spike", "=ds=#sr# 360", "=ds="..ALIL["Honor Hold"].." - "..AL["Exalted"]};
				};
				{ 21, "s16651", "12645", "=q2=Thorium Shield Spike", "=ds=#sr# 275", "=ds="..AL["World Drop"]};
				{ 22, "s9939", "7967", "=q2=Mithril Shield Spike", "=ds=#sr# 215", "=ds="..AL["World Drop"]};
				{ 23, "s7221", "6042", "=q1=Iron Shield Spike", "=ds=#sr# 150", "=ds="..AL["World Drop"]};
				{
					{ 25, "s62202", "44936", "=q3=Titanium Plating", "=ds=#sr# 450", "=ds="..ALIL["Horde Expedition"].." - "..AL["Exalted"]};
					{ 25, "s62202", "44936", "=q3=Titanium Plating", "=ds=#sr# 450", "=ds="..ALIL["Alliance Vanguard"].." - "..AL["Exalted"]};
				};
				{ 26, "s29729", "23576", "=q1=Greater Ward of Shielding", "=ds=#sr# 375", "=ds="..AL["Drop"]..": "..ALIL["Netherstorm"]};
				{
					{ 27, "s29728", "23575", "=q1=Lesser Ward of Shielding", "=ds=#sr# 340", "=ds="..AL["Vendor"]..": "..ALIL["Hellfire Peninsula"].." / "..ALIL["Kelp'thar Forest"]};
					{ 27, "s29728", "23575", "=q1=Lesser Ward of Shielding", "=ds=#sr# 340", "=ds="..AL["Vendor"]..": "..ALIL["Shadowmoon Valley"].." / "..ALIL["Kelp'thar Forest"]};
				};
			};
		};
		info = {
			name = BLACKSMITHING..": "..AL["Armor Enhancements"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingWeaponEnhancement"] = {
		["Normal"] = {
			{
				{ 1, "s131929", "86597", "=q2=Living Steel Weapon Chain", "=ds=#sr# 540", "=ds="..ALIL["The Klaxxi"].." - "..AL["Honored"]};
				{ 2, "s76442", "55057", "=q2=Pyrium Weapon Chain", "=ds=#sr# 500", "=ds="..AL["Vendor"]};
				{ 3, "s55839", "41976", "=q2=Titanium Weapon Chain", "=ds=#sr# 420", "=ds="..AL["Trainer"]};
				{ 4, "s42688", "33185", "=q2=Adamantite Weapon Chain", "=ds=#sr# 335", "=ds="..AL["Drop"]..": "..ALIL["Magisters' Terrace"].." / "..AL["World Drop"]};
				{ 5, "s7224", "6041", "=q1=Steel Weapon Chain", "=ds=#sr# 190", "=ds="..AL["World Drop"]};
				{ 7, "s22757", "18262", "=q2=Elemental Sharpening Stone", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Molten Core"]};
				{ 8, "s29656", "23529", "=q2=Adamantite Sharpening Stone", "=ds=#sr# 350", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Honored"]};
				{ 9, "s29654", "23528", "=q1=Fel Sharpening Stone", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 10, "s16641", "12404", "=q1=Dense Sharpening Stone", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 11, "s9918", "7964", "=q1=Solid Sharpening Stone", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 12, "s2674", "2871", "=q1=Heavy Sharpening Stone", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 13, "s2665", "2863", "=q1=Coarse Sharpening Stone", "=ds=#sr# 65", "=ds="..AL["Trainer"]};
				{ 14, "s2660", "2862", "=q1=Rough Sharpening Stone", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 16, "s34608", "28421", "=q2=Adamantite Weightstone", "=ds=#sr# 350", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Honored"]};
				{ 17, "s34607", "28420", "=q1=Fel Weightstone", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 18, "s16640", "12643", "=q1=Dense Weightstone", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 19, "s9921", "7965", "=q1=Solid Weightstone", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 20, "s3117", "3241", "=q1=Heavy Weightstone", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 21, "s3116", "3240", "=q1=Coarse Weightstone", "=ds=#sr# 65", "=ds="..AL["Trainer"]};
				{ 22, "s3115", "3239", "=q1=Rough Weightstone", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 24, "s7222", "6043", "=q1=Iron Counterweight", "=ds=#sr# 165", "=ds="..AL["World Drop"]};
			};
		};
		info = {
			name = BLACKSMITHING..": "..AL["Weapon Enhancements"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingTrainingProjects"] = {
		["Normal"] = {
			{
				{ 1, "s140168", "95486", "=q0=Training Project: Ghost Iron Statue", "=ds=#sr# 486", "=ds="..AL["Trainer"]};
				{ 2, "s140167", "95485", "=q0=Training Project: Ghost Iron Pans", "=ds=#sr# 456", "=ds="..AL["Trainer"]};
				{ 3, "s140166", "95484", "=q0=Training Project: Ghost Iron Frames", "=ds=#sr# 421", "=ds="..AL["Trainer"]};
				{ 4, "s140165", "95483", "=q0=Training Project: Ghost Iron Picks", "=ds=#sr# 376", "=ds="..AL["Trainer"]};
				{ 5, "s139764", "95370", "=q0=Training Project: Ghost Iron Crate", "=ds=#sr# 347", "=ds="..AL["Trainer"]};
				{ 6, "s139763", "95369", "=q0=Training Project: Ghost Iron Bells", "=ds=#sr# 326", "=ds="..AL["Trainer"]};
				{ 7, "s139762", "95368", "=q0=Training Project: Ghost Iron Bowls", "=ds=#sr# 299", "=ds="..AL["Trainer"]};
				{ 8, "s139761", "95367", "=q0=Training Project: Ghost Iron Cups", "=ds=#sr# 289", "=ds="..AL["Trainer"]};
				{ 9, "s139760", "95366", "=q0=Training Project: Ghost Iron Pot", "=ds=#sr# 256", "=ds="..AL["Trainer"]};
				{ 10, "s139759", "95365", "=q0=Training Project: Ghost Iron Wire", "=ds=#sr# 248", "=ds="..AL["Trainer"]};
				{ 11, "s139757", "95364", "=q0=Training Project: Ghost Iron Saw", "=ds=#sr# 231", "=ds="..AL["Trainer"]};
				{ 12, "s139756", "95363", "=q0=Training Project: Ghost Iron Barrel", "=ds=#sr# 206", "=ds="..AL["Trainer"]};
				{ 13, "s139755", "95362", "=q0=Training Project: Ghost Iron Needles", "=ds=#sr# 199", "=ds="..AL["Trainer"]};
				{ 14, "s139754", "95361", "=q0=Training Project: Ghost Iron Spade", "=ds=#sr# 186", "=ds="..AL["Trainer"]};
				{ 15, "s139753", "95359", "=q0=Training Project: Decorative Spoons", "=ds=#sr# 151", "=ds="..AL["Trainer"]};
				{ 16, "s139751", "95358", "=q0=Training Project: Ghost Iron Spatulas", "=ds=#sr# 136", "=ds="..AL["Trainer"]};
				{ 17, "s139750", "95357", "=q0=Training Project: Ghost Iron Hook", "=ds=#sr# 121", "=ds="..AL["Trainer"]};
				{ 18, "s139749", "95356", "=q0=Training Project: Ghost Iron Poker", "=ds=#sr# 86", "=ds="..AL["Trainer"]};
				{ 19, "s139748", "95355", "=q0=Training Project: Ghost Iron Ladle", "=ds=#sr# 71", "=ds="..AL["Trainer"]};
				{ 20, "s139747", "95354", "=q0=Training Project: Ghost Iron Wok", "=ds=#sr# 59", "=ds="..AL["Trainer"]};
				{ 21, "s139746", "95353", "=q0=Training Project: Simple Eating Utensils", "=ds=#sr# 21", "=ds="..AL["Trainer"]};
				{ 22, "s139745", "95351", "=q0=Training Project: Ghost Iron Pins", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = BLACKSMITHING..": "..AL["Training Projects"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingMisc"] = {
		["Normal"] = {
			{
				{ 1, "s146921", "98717", "=q3=Accelerated Balanced Trillium Ingot", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 2, "s143255", "98717", "=q3=Balanced Trillium Ingot", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 3, "s126869", "80431", "=q1=Folded Ghost Iron", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 4, "s138646", "94111", "=q3=Lightning Steel Ingot", "=ds=#sr# 500", "=ds=#QUESTID:32621#"};
				{ 5, "s76178", "65365", "=q1=Folded Obsidium", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 6, "s11454", "9060", "=q1=Inlaid Mithril Cylinder", "=ds=#sr# 200", "=ds="..AL["Crafted"]..": "..GetSpellInfo(4036).." (205)"};
				{ 16, "s8768", "7071", "=q1=Iron Buckle", "=ds=#sr# 150", "=ds="..AL["Trainer"], amount = 2};
				{ 17, "s122633", "82960", "=q1=Ghostly Skeleton Key", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 18, "s76438", "55053", "=q1=Obsidium Skeleton Key", "=ds=#sr# 475", "=ds="..AL["Trainer"], amount = 2};
				{ 19, "s59406", "43853", "=q2=Titanium Skeleton Key", "=ds=#sr# 430", "=ds="..AL["Trainer"], amount = 20};
				{ 20, "s59405", "43854", "=q2=Cobalt Skeleton Key", "=ds=#sr# 350", "=ds="..AL["Trainer"], amount = 10};
				{ 21, "s19669", "15872", "=q2=Arcanite Skeleton Key", "=ds=#sr# 275", "=ds="..AL["Trainer"], amount = 2};
				{ 22, "s19668", "15871", "=q2=Truesilver Skeleton Key", "=ds=#sr# 200", "=ds="..AL["Trainer"], amount = 2};
				{ 23, "s19667", "15870", "=q2=Golden Skeleton Key", "=ds=#sr# 150", "=ds="..AL["Trainer"], amount = 2};
				{ 24, "s19666", "15869", "=q2=Silver Skeleton Key", "=ds=#sr# 100", "=ds="..AL["Trainer"], amount = 2};
				{ 26, "s16639", "12644", "=q1=Dense Grinding Stone", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 27, "s9920", "7966", "=q1=Solid Grinding Stone", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 28, "s3337", "3486", "=q1=Heavy Grinding Stone", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 29, "s3326", "3478", "=q1=Coarse Grinding Stone", "=ds=#sr# 75", "=ds="..AL["Trainer"]};
				{ 30, "s3320", "3470", "=q1=Rough Grinding Stone", "=ds=#sr# 25", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Miscellaneous"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["Armorsmith"] = {
		["Normal"] = {
			{
				{ 1, "s55187", "41190", "=q3=Legplates of Conquest", "=ds=#sr# 415"};
				{ 2, "s55186", "41189", "=q3=Chestplate of Conquest", "=ds=#sr# 415"};
				{ 3, "s34530", "23564", "=q4=Twisting Nether Chain Shirt", "=ds=#sr# 375"};
				{ 4, "s36256", "23565", "=q4=Embrace of the Twisting Nether", "=ds=#sr# 375"};
				{ 5, "s36257", "28485", "=q4=Bulwark of the Ancient Kings", "=ds=#sr# 375"};
				{ 6, "s34534", "28484", "=q4=Bulwark of Kings", "=ds=#sr# 375"};
				{ 7, "s34529", "23563", "=q4=Nether Chain Shirt", "=ds=#sr# 350"};
				{ 8, "s34533", "28483", "=q4=Breastplate of Kings", "=ds=#sr# 350"};
				{ 9, "s36130", "30076", "=q3=Stormforged Hauberk", "=ds=#sr# 330"};
				{ 10, "s36129", "30074", "=q3=Heavy Earthforged Breastplate", "=ds=#sr# 330"};
				{ 11, "s36124", "30070", "=q3=Windforged Leggings", "=ds=#sr# 260"};
				{ 12, "s36122", "30069", "=q3=Earthforged Leggings", "=ds=#sr# 260"};
			};
		};
		info = {
			name = ARMORSMITH,
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["Weaponsmith"] = {
		["Normal"] = {
			{
				{ 1, "s55185", "41188", "=q3=Saronite Mindcrusher", "=ds=#sr# 415"};
				{ 2, "s55184", "41187", "=q3=Corroded Saronite Woundbringer", "=ds=#sr# 415"};
				{ 3, "s55183", "41186", "=q3=Corroded Saronite Edge", "=ds=#sr# 415"};
				{ 4, "s36126", "30072", "=q3=Light Skyforged Axe", "=ds=#sr# 260"};
				{ 5, "s36128", "30073", "=q3=Light Emberforged Hammer", "=ds=#sr# 260"};
				{ 6, "s36125", "30071", "=q3=Light Earthforged Blade", "=ds=#sr# 260"};
			};
		};
		info = {
			name = WEAPONSMITH,
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["Axesmith"] = {
		["Normal"] = {
			{
				{ 1, "s36260", "28433", "=q4=Wicked Edge of the Planes", "=ds=#sr# 375"};
				{ 2, "s34544", "28435", "=q4=Mooncleaver", "=ds=#sr# 375"};
				{ 3, "s36261", "28436", "=q4=Bloodmoon", "=ds=#sr# 375"};
				{ 4, "s34542", "28432", "=q4=Black Planar Edge", "=ds=#sr# 375"};
				{ 5, "s34541", "28431", "=q4=The Planar Edge", "=ds=#sr# 350"};
				{ 6, "s34543", "28434", "=q4=Lunar Crescent", "=ds=#sr# 350"};
				{ 7, "s36134", "30087", "=q3=Stormforged Axe", "=ds=#sr# 330"};
				{ 8, "s36135", "30088", "=q3=Skyforged Great Axe", "=ds=#sr# 330"};
			};
		};
		info = {
			name = AXESMITH,
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["Hammersmith"] = {
		["Normal"] = {
			{
				{ 1, "s36263", "28442", "=q4=Stormherald", "=ds=#sr# 375"};
				{ 2, "s36262", "28439", "=q4=Dragonstrike", "=ds=#sr# 375"};
				{ 3, "s34546", "28438", "=q4=Dragonmaw", "=ds=#sr# 375"};
				{ 4, "s34548", "28441", "=q4=Deep Thunder", "=ds=#sr# 375"};
				{ 5, "s34547", "28440", "=q4=Thunder", "=ds=#sr# 350"};
				{ 6, "s34545", "28437", "=q4=Drakefist Hammer", "=ds=#sr# 350"};
				{ 7, "s36136", "30089", "=q3=Lavaforged Warhammer", "=ds=#sr# 330"};
				{ 8, "s36137", "30093", "=q3=Great Earthforged Hammer", "=ds=#sr# 330"};
			};
		};
		info = {
			name = HAMMERSMITH,
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["Swordsmith"] = {
		["Normal"] = {
			{
				{ 1, "s36259", "28430", "=q4=Lionheart Executioner", "=ds=#sr# 375"};
				{ 2, "s34540", "28429", "=q4=Lionheart Champion", "=ds=#sr# 375"};
				{ 3, "s34537", "28426", "=q4=Blazeguard", "=ds=#sr# 375"};
				{ 4, "s36258", "28427", "=q4=Blazefury", "=ds=#sr# 375"};
				{ 5, "s34538", "28428", "=q4=Lionheart Blade", "=ds=#sr# 350"};
				{ 6, "s34535", "28425", "=q4=Fireguard", "=ds=#sr# 350"};
				{ 7, "s36131", "30077", "=q3=Windforged Rapier", "=ds=#sr# 330"};
				{ 8, "s36133", "30086", "=q3=Stoneforged Claymore", "=ds=#sr# 330"};
			};
		};
		info = {
			name = SWORDSMITH,
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingCataVendor"] = {
		["Normal"] = {
			{
				{ 1, 66106, "", "=q1=Plans: Elementium Deathplate", "=ds=#p2# (515)", "2 #hardenedelementiumbar#" };
				{ 2, 66107, "", "=q1=Plans: Elementium Girdle of Pain", "=ds=#p2# (510)", "20 #elementiumbar#" };
				{ 4, 66104, "", "=q1=Plans: Hardened Elementium Hauberk", "=ds=#p2# (515)", "2 #hardenedelementiumbar#" };
				{ 5, 66105, "", "=q1=Plans: Hardened Elementium Girdle", "=ds=#p2# (510)", "20 #elementiumbar#" };
				{ 7, 66108, "", "=q1=Plans: Light Elementium Chestguard", "=ds=#p2# (515)", "2 #hardenedelementiumbar#" };
				{ 8, 66109, "", "=q1=Plans: Light Elementium Belt", "=ds=#p2# (510)", "20 #elementiumbar#" };
				{ 10, 66100, "", "=q1=Plans: Ebonsteel Belt Buckle", "=ds=#p2# (525)", "5 #pyriumbar#" };
				{ 11, 66101, "", "=q1=Plans: Pyrium Shield Spike", "=ds=#p2# (525)", "5 #pyriumbar#" };
				{ 12, 66103, "", "=q1=Plans: Pyrium Weapon Chain", "=ds=#p2# (500)", "20 #elementiumbar#" };
				{ 16, 67603, "", "=q1=Plans: Elementium Gutslicer", "=ds=#p2# (515)", "2 #hardenedelementiumbar#" };
				{ 17, 66113, "", "=q1=Plans: Elementium Bonesplitter", "=ds=#p2# (515)", "2 #hardenedelementiumbar#" };
				{ 18, 66111, "", "=q1=Plans: Elementium Hammer", "=ds=#p2# (515)", "2 #hardenedelementiumbar#" };
				{ 19, 66112, "", "=q1=Plans: Elementium Poleaxe", "=ds=#p2# (520)", "2 #hardenedelementiumbar#" };
				{ 20, 66114, "", "=q1=Plans: Elementium Shank", "=ds=#p2# (520)", "2 #hardenedelementiumbar#" };
				{ 21, 66110, "", "=q1=Plans: Elementium Spellblade", "=ds=#p2# (520)", "2 #hardenedelementiumbar#" };
				{ 22, 67606, "", "=q1=Plans: Forged Elementium Mindcrusher", "=ds=#p2# (520)", "5 #pyriumbar#" };
				{ 24, 66115, "", "=q1=Plans: Elementium Earthguard", "=ds=#p2# (520)", "2 #hardenedelementiumbar#" };
				{ 25, 66116, "", "=q1=Plans: Elementium Stormshield", "=ds=#p2# (520)", "2 #hardenedelementiumbar#" };
			};
			{
				{ 1, 66123, "", "=q1=Plans: Vicious Pyrium Helm", "=ds=#p2# (525)", "5 #pyriumbar#" };
				{ 2, 66121, "", "=q1=Plans: Vicious Pyrium Shoulders", "=ds=#p2# (520)", "2 #hardenedelementiumbar#" };
				{ 3, 66124, "", "=q1=Plans: Vicious Pyrium Breastplate", "=ds=#p2# (525)", "5 #pyriumbar#" };
				{ 4, 66117, "", "=q1=Plans: Vicious Pyrium Bracers", "=ds=#p2# (500)", "20 #elementiumbar#" };
				{ 5, 66118, "", "=q1=Plans: Vicious Pyrium Gauntlets", "=ds=#p2# (505)", "20 #elementiumbar#" };
				{ 6, 66119, "", "=q1=Plans: Vicious Pyrium Belt", "=ds=#p2# (510)", "20 #elementiumbar#" };
				{ 7, 66122, "", "=q1=Plans: Vicious Pyrium Legguards", "=ds=#p2# (525)", "5 #pyriumbar#" };
				{ 8, 66120, "", "=q1=Plans: Vicious Pyrium Boots", "=ds=#p2# (515)", "2 #hardenedelementiumbar#" };
				{ 16, 66131, "", "=q1=Plans: Vicious Ornate Pyrium Helm", "=ds=#p2# (525)", "5 #pyriumbar#" };
				{ 17, 66129, "", "=q1=Plans: Vicious Ornate Pyrium Shoulders", "=ds=#p2# (520)", "2 #hardenedelementiumbar#" };
				{ 18, 66132, "", "=q1=Plans: Vicious Ornate Pyrium Breastplate", "=ds=#p2# (525)", "5 #pyriumbar#" };
				{ 19, 66125, "", "=q1=Plans: Vicious Ornate Pyrium Bracers", "=ds=#p2# (500)", "20 #elementiumbar#" };
				{ 20, 66126, "", "=q1=Plans: Vicious Ornate Pyrium Gauntlets", "=ds=#p2# (505)", "20 #elementiumbar#" };
				{ 21, 66127, "", "=q1=Plans: Vicious Ornate Pyrium Belt", "=ds=#p2# (510)", "20 #elementiumbar#" };
				{ 22, 66130, "", "=q1=Plans: Vicious Ornate Pyrium Legguards", "=ds=#p2# (525)", "5 #pyriumbar#" };
				{ 23, 66128, "", "=q1=Plans: Vicious Ornate Pyrium Boots", "=ds=#p2# (515)", "2 #hardenedelementiumbar#" };
			};
		};
		info = {
			name = BLACKSMITHING..": "..AL["Cataclysm Vendor Sold Plans"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingMoPVendor"] = {
		["Normal"] = {
			{
				{ 1, 84163, "", "=q1=Plans: Contender's Revenant Helm", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 2, 84165, "", "=q1=Plans: Contender's Revenant Shoulders", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 3, 84161, "", "=q1=Plans: Contender's Revenant Breastplate", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 4, 84160, "", "=q1=Plans: Contender's Revenant Bracers", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 5, 84162, "", "=q1=Plans: Contender's Revenant Gauntlets", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 6, 84158, "", "=q1=Plans: Contender's Revenant Belt", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 7, 84164, "", "=q1=Plans: Contender's Revenant Legplates", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 8, 84159, "", "=q1=Plans: Contender's Revenant Boots", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 16, 84171, "", "=q1=Plans: Contender's Spirit Helm", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 17, 84173, "", "=q1=Plans: Contender's Spirit Shoulders", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 18, 84169, "", "=q1=Plans: Contender's Spirit Breastplate", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 19, 84168, "", "=q1=Plans: Contender's Spirit Bracers", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 20, 84170, "", "=q1=Plans: Contender's Spirit Gauntlets", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 21, 84166, "", "=q1=Plans: Contender's Spirit Belt", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 22, 84172, "", "=q1=Plans: Contender's Spirit Legplates", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 23, 84167, "", "=q1=Plans: Contender's Spirit Boots", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
			};
			{
				{ 1, 84224, "", "=q1=Plans: Masterwork Spiritguard Helm", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 2, 84227, "", "=q1=Plans: Masterwork Spiritguard Shoulders", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 3, 84222, "", "=q1=Plans: Masterwork Spiritguard Breastplate", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 4, 84221, "", "=q1=Plans: Masterwork Spiritguard Bracers", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 5, 84223, "", "=q1=Plans: Masterwork Spiritguard Gauntlets", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 6, 84219, "", "=q1=Plans: Masterwork Spiritguard Belt", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 7, 84225, "", "=q1=Plans: Masterwork Spiritguard Legplates", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 8, 84220, "", "=q1=Plans: Masterwork Spiritguard Boots", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 16, 84208, "", "=q1=Plans: Masterwork Lighsteel Shield", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
				{ 17, 84226, "", "=q1=Plans: Masterwork Spiritguard Shield", "=ds=#p2# (575)", "#SPIRITOFHARMONY:1#" };
			};
		};
		info = {
			name = BLACKSMITHING..": "..AL["Mists of Pandaria Vendor Sold Plans"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingArmorRemoved"] = {
		["Normal"] = {
			{
				{ 1, "s28244", "22671", "=q4=Icebane Bracers", "=ds=#sr# 300"};
				{ 2, "s28242", "22669", "=q4=Icebane Breastplate", "=ds=#sr# 300"};
				{ 3, "s28243", "22670", "=q4=Icebane Gauntlets", "=ds=#sr# 300"};
				{ 4, "s24136", "19690", "=q3=Bloodsoul Breastplate", "=ds=#sr# 300"};
				{ 5, "s24138", "19692", "=q3=Bloodsoul Gauntlets", "=ds=#sr# 300"};
				{ 6, "s24137", "19691", "=q3=Bloodsoul Shoulders", "=ds=#sr# 300"};
				{ 7, "s24139", "19693", "=q3=Darksoul Breastplate", "=ds=#sr# 300"};
				{ 8, "s24140", "19694", "=q3=Darksoul Leggings", "=ds=#sr# 300"};
				{ 9, "s24141", "19695", "=q3=Darksoul Shoulders", "=ds=#sr# 300"};
				{ 10, "s16665", "12611", "=q2=Runic Plate Boots", "=ds=#sr# 300"};
				{ 11, "s16655", "12631", "=q3=Fiery Plate Gauntlets", "=ds=#sr# 290"};
				{ 12, "s16667", "12628", "=q3=Demon Forged Breastplate", "=ds=#sr# 285"};
				{ 13, "s36122", "30069", "=q3=Earthforged Leggings", "=ds=#sr# 260"};
				{ 14, "s36124", "30070", "=q3=Windforged Leggings", "=ds=#sr# 260"};
				{ 15, "s9974", "7939", "=q3=Truesilver Breastplate", "=ds=#sr# 245"};
				{ 16, "s9979", "7936", "=q2=Ornate Mithril Boots", "=ds=#sr# 245"};
				{ 17, "s9980", "7937", "=q2=Ornate Mithril Helm", "=ds=#sr# 245"};
				{ 18, "s9972", "7935", "=q2=Ornate Mithril Breastplate", "=ds=#sr# 240"};
				{ 19, "s9954", "7938", "=q3=Truesilver Gauntlets", "=ds=#sr# 225"};
				{ 20, "s9952", "7928", "=q2=Ornate Mithril Shoulder", "=ds=#sr# 225"};
				{ 21, "s9950", "7927", "=q2=Ornate Mithril Gloves", "=ds=#sr# 220"};
				{ 22, "s9945", "7926", "=q2=Ornate Mithril Pants", "=ds=#sr# 220"};
				{ 23, "s9957", "7929", "=q2=Orcish War Leggings", "=ds=#sr# 230"};
				{ 24, "s11643", "9366", "=q2=Golden Scale Gauntlets", "=ds=#sr# 205"};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Armor"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};

	AtlasLoot_Data["SmithingWeaponRemoved"] = {
		["Normal"] = {
			{
				{ 1, "s16978", "12777", "=q3=Blazing Rapier", "=ds=#h1#, #w10#"};
				{ 2, "s10011", "7959", "=q3=Blight", "=ds=#w7#"};
				{ 3, "s16970", "12774", "=q3=Dawn's Edge", "=ds=#h1#, #w1#"};
				{ 4, "s16973", "12776", "=q3=Enchanted Battlehammer", "=ds=#h2#, #w6#"};
				{ 5, "s36125", "30071", "=q3=Light Earthforged Blade", "=ds=#h1#, #w10#"};
				{ 6, "s36128", "30073", "=q3=Light Emberforged Hammer", "=ds=#h1#, #w6#"};
				{ 7, "s36126", "30072", "=q3=Light Skyforged Axe", "=ds=#h1#, #w1#"};
				{ 8, "s10003", "7954", "=q3=The Shatterer", "=ds=#h1#, #w6#"};
				{ 9, "s10015", "7960", "=q3=Truesilver Champion", "=ds=#h2#, #w10#"};
				{ 10, "s16984", "12792", "=q2=Volcanic Hammer", "=ds=#h1#, #w6#"};
			};
		};
		info = {
			name = BLACKSMITHING..": "..BabbleInventory["Weapon"],
			module = moduleName, menu = "SMITHINGMENU", instance = "Blacksmithing",
		};
	};
		---------------
		--- Cooking ---
		---------------

	AtlasLoot_Data["CookingAttributes"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Agility"]};
				{ 2, "s104303", "74648", "=q1=Sea Mist Rice Noodles", "=ds=#sr# 600", "=ds="..ALIL["Way of the Wok"], amount = 5};
				{ 3, "s145305", "101746", "=q1=Seasoned Pomfruit Slices", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Vale of Eternal Blossoms"]};
				{ 4, "s104302", "74647", "=q1=Valley Stir Fry", "=ds=#sr# 550", "=ds="..ALIL["Way of the Wok"]};
				{ 5, "s104301", "74643", "=q1=Sauteed Carrots", "=ds=#sr# 525", "=ds="..ALIL["Way of the Wok"]};
				{ 6, "s88042", "62669", "=q1=Skewered Eel", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 7, "s88046", "62658", "=q1=Tender Baked Turtle", "=ds=#sr# 475", "=ds="..AL["Cooking Daily"]};
				{ 8, "s57441", "42999", "=q1=Blackened Dragonfin", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 9, "s33288", "27659", "=q1=Warp Burger", "=ds=#sr# 325", "=ds="..AL["Vendor"]..": "..ALIL["Terokkar Forest"]};
				{ 10, "s33293", "27664", "=q1=Grilled Mudfish", "=ds=#sr# 320", "=ds="..AL["Vendor"]..": "..ALIL["Nagrand"]};
				{ 11, "s18240", "13928", "=q1=Grilled Squid", "=ds=#sr# 240", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Intellect"]};
				{ 17, "s104306", "74650", "=q1=Mogu Fish Stew", "=ds=#sr# 600", "=ds="..ALIL["Way of the Pot"], amount = 5};
				{ 18, "s145307", "101748", "=q1=Spiced Blossom Soup", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Vale of Eternal Blossoms"]};
				{ 19, "s104305", "74649", "=q1=Braised Turtle", "=ds=#sr# 550", "=ds="..ALIL["Way of the Pot"]};
				{ 20, "s104304", "74644", "=q1=Swirling Mist Soup", "=ds=#sr# 525", "=ds="..ALIL["Way of the Pot"]};
				{ 21, "s88039", "62671", "=q1=Severed Sagefish Head", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 22, "s88033", "62660", "=q1=Pickled Guppy", "=ds=#sr# 475", "=ds="..AL["Cooking Daily"]};
				{ 23, "s22761", "18254", "=q1=Runn Tum Tuber Surprise", "=ds=#sr# 275", "=ds="..AL["Drop"]};
				{ 25, 0, "INV_Box_01", "=q6="..AL["Spirit"]};
				{ 26, "s145309", "101747", "=q1=Farmer's Delight", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Vale of Eternal Blossoms"]};
				{ 27, "s104309", "74653", "=q1=Steamed Crab Surprise", "=ds=#sr# 600", "=ds="..ALIL["Way of the Steamer"], amount = 5};
				{ 28, "s104308", "74652", "=q1=Fire Spirit Salmon", "=ds=#sr# 550", "=ds="..ALIL["Way of the Steamer"]};
				{ 29, "s104307", "74651", "=q1=Shrimp Dumplings", "=ds=#sr# 525", "=ds="..ALIL["Way of the Steamer"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Stamina"]};
				{ 2, "s104312", "74656", "=q1=Chun Tian Spring Rolls", "=ds=#sr# 600", "=ds="..ALIL["Way of the Oven"], amount = 5};
				{ 3, "s145310", "101749", "=q1=Stuffed Lushrooms", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Vale of Eternal Blossoms"]};
				{ 4, "s104311", "74655", "=q1=Twin Fish Platter", "=ds=#sr# 550", "=ds="..ALIL["Way of the Oven"]};
				{ 5, "s104310", "74654", "=q1=Wildfowl Roast", "=ds=#sr# 525", "=ds="..ALIL["Way of the Oven"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Strength"]};
				{ 17, "s104300", "74646", "=q1=Black Pepper Ribs and Shrimp", "=ds=#sr# 600", "=ds="..ALIL["Way of the Grill"], amount = 5};
				{ 18, "s145311", "101750", "=q1=Fluffy Silkfeather Omelet", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Vale of Eternal Blossoms"]};
				{ 19, "s104299", "74645", "=q1=Eternal Blossom Fish", "=ds=#sr# 550", "=ds="..ALIL["Way of the Grill"]};
				{ 20, "s104298", "74642", "=q1=Charbroiled Tiger Steak", "=ds=#sr# 525", "=ds="..ALIL["Way of the Grill"]};
				{ 21, "s88005", "62670", "=q1=Bear-Basted Crocolisk", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 22, "s88021", "62659", "=q1=Hearty Seafood Soup", "=ds=#sr# 475", "=ds="..AL["Cooking Daily"]};
				{ 23, "s57442", "43000", "=q1=Dragonfin Filet", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 24, "s33287", "27658", "=q1=Roasted Clefthoof", "=ds=#sr# 325", "=ds="..AL["Vendor"]..": "..ALIL["Nagrand"]};
				{ 25, "s24801", "20452", "=q1=Smoked Desert Dumplings", "=ds=#sr# 285", "=ds="..BabbleInventory["Quest"]};
			};
		};
		info = {
			name = COOKING..": "..AL["Attributes"],
			module = moduleName, menu = "COOKINGMENU"
		};
	};

	AtlasLoot_Data["CookingRatings"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Crit Rating"], ""};
				{ 2, "s88003", "62661", "=q1=Baked Rockfish", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 3, "s88028", "62561", "=q1=Lightly Fried Lurker", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 4, "s124231", "81410", "=q1=Green Curry Fish", "=ds=#sr# 420", "=ds="..AL["Trainer"], amount = "2-3"};
				{ 5, "s57436", "42995", "=q1=Hearty Rhino", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 6, "s45557", "34756", "=q1=Spiced Worm Burger", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 7, "s45571", "34768", "=q1=Spicy Blue Nettlefish", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 8, "s45565", "34764", "=q1=Poached Nettlefish", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 9, "s45551", "34750", "=q1=Worm Delight", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 10, "s43707", "33825", "=q1=Skullfish Soup", "=ds=#sr# 325", "=ds="..AL["Drop"]..""};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Dodge Rating"], ""};
				{ 17, "s88031", "62667", "=q1=Mushroom Sauce Mudfish", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 18, "s88030", "62657", "=q1=Lurker Lunch", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 19, "s124233", "81412", "=q1=Blanched Needle Mushrooms", "=ds=#sr# 330", "=ds="..AL["Trainer"]};
				{ 20, "s124227", "81404", "=q1=Dried Needle Mushrooms", "=ds=#sr# 90", "=ds="..AL["Trainer"]};
				{ 22, 0, "INV_Box_01", "=q6="..AL["Expertise Rating"], ""};
				{ 23, "s125123", "86074", "=q1=Spicy Vegetable Chips", "=ds=#sr# 500", "=ds="..ALIL["The Tillers"].." - "..AL["Exalted"], amount = 5};
				{ 24, "s125122", "86069", "=q1=Rice Pudding", "=ds=#sr# 520", "=ds="..AL["Trainer"]};
				{ 25, "s88014", "62664", "=q1=Crocolisk Au Gratin", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 26, "s88024", "62654", "=q1=Lavascale Fillet", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 27, "s57434", "42994", "=q1=Rhinolicious Wormsteak", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 28, "s124229", "81408", "=q1=Red Bean Bun", "=ds=#sr# 360", "=ds="..AL["Trainer"]};
				{ 29, "s124223", "81400", "=q1=Pounded Rice Cake", "=ds=#sr# 120", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Haste Rating"], ""};
				{ 2, "s88004", "62665", "=q1=Basilisk Liverdog", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 3, "s124230", "81409", "=q1=Tangy Yogurt", "=ds=#sr# 480", "=ds="..AL["Trainer"]};
				{ 4, "s88012", "62655", "=q1=Broiled Mountain Trout", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 5, "s45570", "34769", "=q1=Imperial Manta Steak", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 6, "s45558", "34757", "=q1=Very Burnt Worg", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 7, "s45569", "42942", "=q1=Baked Manta Ray", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 8, "s45552", "34751", "=q1=Roasted Worg", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{
					{ 9, "s66034", "44839", "=q1=Candied Sweet Potato", "=ds=#sr# 220", "=ds="..AL["Vendor"]};
					{ 9, "s62051", "44839", "=q1=Candied Sweet Potato", "=ds=#sr# 220", "=ds="..AL["Vendor"]};
				};
				{ 10, "s124224", "81401", "=q1=Yak Cheese Curds", "=ds=#sr# 150", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Hit Rating"], ""};
				{ 17, "s125120", "86073", "=q1=Spicy Salmon", "=ds=#sr# 500", "=ds="..ALIL["The Tillers"].." - "..AL["Exalted"], amount = 5};
				{ 18, "s125121", "86070", "=q1=Wildfowl Ginseng Soup", "=ds=#sr# 510", "=ds="..AL["Trainer"]};
				{ 19, "s88020", "62662", "=q1=Grilled Dragon", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 20, "s88037", "62652", "=q1=Seasoned Crab", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 21, "s57437", "42996", "=q1=Snapper Extreme", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 22, "s62350", "44953", "=q1=Worg Tartare", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 23, "s124234", "81413", "=q1=Skewered Peanut Chicken", "=ds=#sr# 390", "=ds="..AL["Trainer"]};
				{ 24, "s43765", "33872", "=q1=Spicy Hot Talbuk", "=ds=#sr# 325", "=ds="..AL["Drop"]};
				{ 25, "s124228", "81405", "=q1=Boiled Silkworm Pupa", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 26, "s66038", "44837", "=q1=Spice Bread Stuffing", "=ds=#sr# 1", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Mastery Rating"], ""};
				{ 2, "s145308", "101745", "=q1=Mango Ice", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Vale of Eternal Blossoms"]};
				{ 3, "s88025", "62663", "=q1=Lavascale Minestrone", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 4, "s125080", "81414", "=q1=Pearl Milk Tea", "=ds=#sr# 495", "=ds="..AL["Trainer"]};
				{ 5, "s88035", "62653", "=q1=Salted Eye", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 6, "s125078", "81406", "=q1=Roasted Barley Tea", "=ds=#sr# 240", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Parry Rating"], ""};
				{ 17, "s88034", "62668", "=q1=Blackbelly Sushi", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 18, "s124232", "81411", "=q1=Peach Pie", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 19, "s124226", "81403", "=q1=Dried Peaches", "=ds=#sr# 180", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = COOKING..": "..AL["Ratings"],
			module = moduleName, menu = "COOKINGMENU"
		};
	};

	AtlasLoot_Data["CookingBuff"] = {
		["Normal"] = {
			{
				{ 1, "s88016", "62666", "=q1=Delicious Sagefish Tail", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 2, "s88047", "62656", "=q1=Whitecrest Gumbo", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 3, "s57439", "42998", "=q1=Cuttlesteak", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 4, "s57433", "42993", "=q1=Spicy Fried Herring", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 5, "s45559", "34758", "=q1=Mighty Rhino Dogs", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 6, "s42302", "33052", "=q1=Fisherman's Feast", "=ds=#sr# 350", "=ds="..AL["Trainer"], amount = 6};
				{ 7, "s45566", "34765", "=q1=Pickled Fangtooth", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 8, "s45553", "34752", "=q1=Rhino Dogs", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 9, "s33296", "27667", "=q1=Spicy Crawdad", "=ds=#sr# 350", "=ds="..AL["Vendor"]..": "..ALIL["Terokkar Forest"]};
				{ 10, "s38867", "31672", "=q1=Mok'Nathal Shortribs", "=ds=#sr# 335", "=ds="..AL["Vendor"]..": "..ALIL["Blade's Edge Mountains"]};
				{ 11, "s45022", "34411", "=q1=Hot Apple Cider", "=ds=#sr# 325", "=ds="..AL["Vendor"], amount = 2};
				{ 12, "s33289", "27660", "=q1=Talbuk Steak", "=ds=#sr# 325", "=ds="..AL["Vendor"]..": "..ALIL["Nagrand"]};
				{ 13, "s43761", "33867", "=q1=Broiled Bloodfin", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 14, "s33279", "27651", "=q1=Buzzard Bites", "=ds=#sr# 300", "=ds="..BabbleInventory["Quest"]};
				{ 15, "s36210", "30155", "=q1=Clam Bar", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Zangarmarsh"]};
				{ 16, "s25659", "21023", "=q1=Dirge's Kickin' Chimaerok Chops", "=ds=#sr# 300", "=ds="..BabbleInventory["Quest"], amount = 5};
				{ 17, "s33291", "27662", "=q1=Feltail Delight", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Zangarmarsh"]};
				{ 18, "s18246", "13934", "=q1=Mightfish Steak", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Feralas"]};
				{ 19, "s18242", "13929", "=q1=Hot Smoked Bass", "=ds=#sr# 240", "=ds="..AL["Vendor"]..": "..ALIL["Stranglethorn Vale"]};
				{ 20, "s18239", "13927", "=q1=Cooked Glossy Mightfish", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Stranglethorn Vale"]};
				{ 21, "s15933", "12218", "=q1=Monster Omelet", "=ds=#sr# 225", "=ds="..AL["Vendor"]};
				{ 22, "s15915", "12216", "=q1=Spiced Chili Crab", "=ds=#sr# 225", "=ds="..AL["Vendor"]};
				{ 23, "s22480", "18045", "=q1=Tender Wolf Steak", "=ds=#sr# 225", "=ds="..AL["Vendor"]};
				{ 24, "s15910", "12215", "=q1=Heavy Kodo Stew", "=ds=#sr# 200", "=ds="..AL["Vendor"]..": "..ALIL["Desolace"], amount = 2};
				{ 25, "s21175", "17222", "=q1=Spider Sausage", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 26, "s4094", "4457", "=q1=Barbecued Buzzard Wing", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 27, "s15863", "12213", "=q1=Carrion Surprise", "=ds=#sr# 175", "=ds="..AL["Vendor"]};
				{ 28, "s7213", "6038", "=q1=Giant Clam Scorcho", "=ds=#sr# 175", "=ds="..AL["Vendor"]..": "..ALIL["Stranglethorn Vale"]};
				{ 29, "s15856", "13851", "=q1=Hot Wolf Ribs", "=ds=#sr# 175", "=ds="..AL["Vendor"]};
				{ 30, "s15861", "12212", "=q1=Jungle Stew", "=ds=#sr# 175", "=ds="..AL["Vendor"], amount = 2};
			};
			{
				{ 1, "s15865", "12214", "=q1=Mystery Stew", "=ds=#sr# 175", "=ds="..AL["Vendor"]};
				{ 2, "s15855", "12210", "=q1=Roast Raptor", "=ds=#sr# 175", "=ds="..AL["Vendor"]};
				{ 3, "s3400", "3729", "=q1=Soothing Turtle Bisque", "=ds=#sr# 175", "=ds="..BabbleInventory["Quest"]};
				{ 4, "s24418", "20074", "=q1=Heavy Crocolisk Stew", "=ds=#sr# 150", "=ds="..AL["Vendor"]..": "..ALIL["Dustwallow Marsh"]};
				{ 5, "s3399", "3728", "=q1=Tasty Lion Steak", "=ds=#sr# 150", "=ds="..BabbleInventory["Quest"]};
				{ 6, "s3376", "3665", "=q1=Curiously Tasty Omelet", "=ds=#sr# 130", "=ds="..AL["Vendor"]};
				{ 7, "s6500", "5527", "=q1=Goblin Deviled Clams", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 8, "s15853", "12209", "=q1=Lean Wolf Steak", "=ds=#sr# 125", "=ds="..AL["Vendor"]..": "..ALIL["Desolace"]};
				{ 9, "s3373", "3664", "=q1=Crocolisk Gumbo", "=ds=#sr# 120", "=ds="..AL["Vendor"]};
				{ 10, "s3397", "3726", "=q1=Big Bear Steak", "=ds=#sr# 110", "=ds="..AL["Vendor"]..": "..ALIL["Desolace"]};
				{ 11, "s3377", "3666", "=q1=Gooey Spider Cake", "=ds=#sr# 110", "=ds="..BabbleInventory["Quest"]};
				{ 12, "s6419", "5480", "=q1=Lean Venison", "=ds=#sr# 110", "=ds="..AL["Vendor"]..": "..ALIL["Desolace"], amount = 2};
				{ 13, "s6418", "5479", "=q1=Crispy Lizard Tail", "=ds=#sr# 100", "=ds="..AL["Vendor"]..": "..ALIL["Northern Barrens"], amount = 2};
				{ 14, "s2547", "1082", "=q1=Redridge Goulash", "=ds=#sr# 100", "=ds="..AL["Vendor"]..": "..ALIL["Stormwind City"]};
				{ 15, "s2549", "1017", "=q1=Seasoned Wolf Kabob", "=ds=#sr# 100", "=ds="..BabbleInventory["Quest"], amount = 3};
				{ 16, "s3372", "3663", "=q1=Murloc Fin Soup", "=ds=#sr# 90", "=ds="..AL["Vendor"]..": "..ALIL["Stormwind City"]};
				{ 17, "s3370", "3662", "=q1=Crocolisk Steak", "=ds=#sr# 80", "=ds="..AL["Vendor"]..": "..ALIL["Stormwind City"]};
				{ 18, "s2546", "2687", "=q1=Dry Pork Ribs", "=ds=#sr# 80", "=ds="..AL["Trainer"]};
				{ 19, "s2544", "2683", "=q1=Crab Cake", "=ds=#sr# 75", "=ds="..AL["Trainer"]};
				{ 20, "s3371", "3220", "=q1=Blood Sausage", "=ds=#sr# 60", "=ds="..AL["Vendor"]..": "..ALIL["Stormwind City"], amount = 2};
				{ 21, "s28267", "22645", "=q1=Crunchy Spider Surprise", "=ds=#sr# 60", "=ds="..AL["Vendor"]};
				{ 22, "s33278", "27636", "=q1=Bat Bites", "=ds=#sr# 50", "=ds="..AL["Vendor"]};
				{ 23, "s6499", "5525", "=q1=Boiled Clams", "=ds=#sr# 50", "=ds="..AL["Trainer"]};
				{ 24, "s2541", "2684", "=q1=Coyote Steak", "=ds=#sr# 50", "=ds="..AL["Trainer"]};
				{ 25, "s6415", "5476", "=q1=Fillet of Frenzy", "=ds=#sr# 50", "=ds="..AL["Vendor"], amount = 2};
				{ 26, "s2542", "724", "=q1=Goretusk Liver Pie", "=ds=#sr# 50", "=ds="..AL["Vendor"]..": "..ALIL["Stormwind City"]};
				{ 27, "s6416", "5477", "=q1=Strider Stew", "=ds=#sr# 50", "=ds="..AL["Vendor"]..": "..ALIL["Northern Barrens"], amount = 2};
				{ 28, "s21144", "17198", "=q1=Egg Nog", "=ds=#sr# 35", "=ds="..AL["Vendor"]};
				{ 29, "s6414", "5474", "=q1=Roasted Kodo Meat", "=ds=#sr# 35", "=ds="..AL["Vendor"]..": "..ALIL["Mulgore"], amount = 2};
				{ 30, "s2795", "2888", "=q1=Beer Basted Boar Ribs", "=ds=#sr# 10", "=ds="..AL["Vendor"]..": "..ALIL["Stormwind City"]};
			};
			{
				{ 1, "s6412", "5472", "=q1=Kaldorei Spider Kabob", "=ds=#sr# 10", "=ds="..BabbleInventory["Quest"]};
				{ 2, "s2539", "2680", "=q1=Spiced Wolf Meat", "=ds=#sr# 10", "=ds="..AL["Trainer"]};
				{ 3, "s15935", "12224", "=q1=Crispy Bat Wing", "=ds=#sr# 1", "=ds="..AL["Vendor"]};
				{ 4, "s21143", "17197", "=q1=Gingerbread Cookie", "=ds=#sr# 1", "=ds="..AL["Vendor"]};
				{ 5, "s8604", "6888", "=q1=Herb Baked Egg", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 6, "s33276", "27635", "=q1=Lynx Steak", "=ds=#sr# 1", "=ds="..AL["Vendor"]};
				{ 7, "s33277", "24105", "=q1=Roasted Moongraze Tenderloin", "=ds=#sr# 1", "=ds="..BabbleInventory["Quest"]};
				{
					{ 9, "s66036", "44836", "=q1=Pumpkin Pie", "=ds=#sr# 100", "=ds="..AL["Vendor"]};
					{ 9, "s62044", "44836", "=q1=Pumpkin Pie", "=ds=#sr# 100", "=ds="..AL["Vendor"]};
				};
				{ 10, "s65454", "46691", "=q1=Bread of the Dead", "=ds=#sr# 1", "=ds="..AL["Vendor"]};
			};
		};
		info = {
			name = COOKING..": "..AL["Standard Buffs"],
			module = moduleName, menu = "COOKINGMENU"
		};
	};

	AtlasLoot_Data["CookingSpecial"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Alcohol"]};
				{ 2, "s88015", "62790", "=q1=Darkbrew Lager", "=ds=#sr# 415", "=ds="..AL["Trainer"], amount = 4};
				{ 3, "s88022", "62674", "=q1=Highland Spirits", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 5, 0, "INV_Box_01", "=q6="..AL["Emotions"]};
				{ 6, "s58523", "43491", "=q1=Bad Clams", "=ds=#sr# 350", "=ds="..AL["Drop"], amount = 5};
				{ 7, "s58525", "43492", "=q1=Haunted Herring", "=ds=#sr# 350", "=ds="..AL["Drop"], amount = 5};
				{ 8, "s58521", "43488", "=q1=Last Week's Mammoth", "=ds=#sr# 350", "=ds="..AL["Drop"], amount = 5};
				{ 9, "s58512", "43490", "=q1=Tasty Cupcake", "=ds=#sr# 350", "=ds="..AL["Drop"], amount = 5};
				{ 10, "s43779", "33924", "=q1=Delicious Chocolate Cake", "=ds=#sr# 1", "=ds="..AL["Cooking Daily"]};
				{ 16, 0, "INV_Box_01", "=q6=#p24#"};
				{ 17, "s88017", "62673", "=q1=Feathered Lure", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 18, "s45695", "34832", "=q1=Captain Rumsey's Lager", "=ds=#sr# 100", "=ds="..AL["Drop"], amount = 5};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Tracking"]};
				{ 21, "s57438", "42997", "=q1=Blackened Worg Steak", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 22, "s57443", "43001", "=q1=Tracker Snacks", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Other"]};
				{ 2, "s126655", "86432", "=q1=Banana Infused Rum", "=ds=#sr# 600", "=ds="..ALIL["Way of the Brew"]..": "..ALIL["Krasarang Wilds"]};
				{ 3, "s126654", "87264", "=q1=Four Senses Brew", "=ds=#sr# 600", "=ds="..ALIL["Way of the Brew"]..": "..ALIL["Kun-Lai Summit"]};
				{ 4, "s124054", "75038", "=q1=Mad Brewer's Breakfast", "=ds=#sr# 600", "=ds="..ALIL["Way of the Brew"], amount = 5};
				{ 5, "s124053", "75037", "=q1=Jade Witch Brew", "=ds=#sr# 550", "=ds="..ALIL["Way of the Brew"]};
				{ 6, "s88013", "62680", "=q1=Chocolate Cookie", "=ds=#sr# 505", "=ds="..AL["Cooking Daily"]};
				{ 7, "s57435", "43004", "=q1=Critter Bites", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"], amount = 4};
				{ 8, "s43758", "33866", "=q1=Stormchops", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 9, "s15906", "12217", "=q1=Dragonbreath Chili", "=ds=#sr# 200", "=ds="..AL["Vendor"]};
				{ 10, "s8238", "6657", "=q1=Savory Deviate Delight", "=ds=#sr# 85", "=ds="..AL["Drop"]};
				{ 11, "s9513", "7676", "=q1=Thistle Tea", "=ds=#sr# 60", "=ds="..AL["Vendor"]..": "..ALIL["Hillsbrad Foothills"]};
				{ 12, "s6413", "5473", "=q1=Scorpid Surprise", "=ds=#sr# 20", "=ds="..AL["Vendor"]..": "..ALIL["Durotar"]};
			};
		};
		info = {
			name = COOKING..": "..AL["Special"],
			module = moduleName, menu = "COOKINGMENU"
		};
	};

	AtlasLoot_Data["CookingBanquetFeast"] = {
		["Normal"] = {
			{
				{ 1, "s145062", "101662", "=q1=Pandaren Treasure Noodle Cart Kit", "=ds=#sr# 600", "=ds=#QUESTID:33027#", amount = 5};
				{ 2, "s145061", "101661", "=q1=Deluxe Noodle Cart Kit", "=ds=#sr# 600", "=ds=#QUESTID:33024#", amount = 5};
				{ 3, "s145038", "101630", "=q1=Noodle Cart Kit", "=ds=#sr# 600", "=ds=#QUESTID:33022#", amount = 5};
				{ 4, "s105190", "74919", "=q1=Pandaren Banquet", "=ds=#sr# 600", "=ds=#QUESTID:31521#", amount = 5};
				{ 5, "s105194", "75016", "=q1=Great Pandaren Banquet", "=ds=#sr# 600", "=ds=#QUESTID:31521#", amount = 5};
				{ 6, "s125602", "87246", "=q1=Banquet of the Brew", "=ds=#sr# 575", "=ds="..ALIL["Way of the Brew"], amount = 5};
				{ 7, "s125603", "87248", "=q1=Great Banquet of the Brew", "=ds=#sr# 575", "=ds="..ALIL["Way of the Brew"], amount = 5};
				{ 8, "s125141", "87226", "=q1=Banquet of the Grill", "=ds=#sr# 575", "=ds="..ALIL["Way of the Grill"], amount = 5};
				{ 9, "s125142", "87228", "=q1=Great Banquet of the Grill", "=ds=#sr# 575", "=ds="..ALIL["Way of the Grill"], amount = 5};
				{ 10, "s125600", "87242", "=q1=Banquet of the Oven", "=ds=#sr# 575", "=ds="..ALIL["Way of the Oven"], amount = 5};
				{ 11, "s125601", "87244", "=q1=Great Banquet of the Oven", "=ds=#sr# 575", "=ds="..ALIL["Way of the Oven"], amount = 5};
				{ 12, "s125596", "87234", "=q1=Banquet of the Pot", "=ds=#sr# 575", "=ds="..ALIL["Way of the Pot"], amount = 5};
				{ 13, "s125597", "87236", "=q1=Great Banquet of the Pot", "=ds=#sr# 575", "=ds="..ALIL["Way of the Pot"], amount = 5};
				{ 14, "s125598", "87238", "=q1=Banquet of the Steamer", "=ds=#sr# 575", "=ds="..ALIL["Way of the Steamer"], amount = 5};
				{ 15, "s125599", "87240", "=q1=Great Banquet of the Steamer", "=ds=#sr# 575", "=ds="..ALIL["Way of the Steamer"], amount = 5};
				{ 16, "s125594", "87230", "=q1=Banquet of the Wok", "=ds=#sr# 575", "=ds="..ALIL["Way of the Wok"], amount = 5};
				{ 17, "s125595", "87232", "=q1=Great Banquet of the Wok", "=ds=#sr# 575", "=ds="..ALIL["Way of the Wok"], amount = 5};
				{ 19, "s88036", "62290", "=q1=Seafood Magnifique Feast", "=ds=#sr# 525", "#ACHIEVEMENTID:5036#"};
				{ 20, "s88011", "62289", "=q1=Broiled Dragon Feast", "=ds=#sr# 500", "#ACHIEVEMENTID:5467#"};
				{ 21, "s57423", "43015", "=q1=Fish Feast", "=ds=#sr# 450", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 22, "s58527", "43478", "=q1=Gigantic Feast", "=ds=#sr# 425", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 23, "s58528", "43480", "=q1=Small Feast", "=ds=#sr# 425", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 24, "s45554", "34753", "=q1=Great Feast", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = COOKING..": "..AL["Banquets/Feasts"],
			module = moduleName, menu = "COOKINGMENU"
		};
	};

	AtlasLoot_Data["CookingAPSP"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Spell Power"], ""};
				{ 2, "s57423", "43015", "=q1=Fish Feast", "=ds=#sr# 450", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 3, "s45568", "34767", "=q1=Firecracker Salmon", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 4, "s45556", "34755", "=q1=Tender Shoveltusk Steak", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 5, "s58065", "43268", "=q1=Dalaran Clam Chowder", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 6, "s45554", "34753", "=q1=Great Feast", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 7, "s45550", "34749", "=q1=Shoveltusk Steak", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 8, "s45564", "34763", "=q1=Smoked Salmon", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 9, "s33286", "27657", "=q1=Blackened Basilisk", "=ds=#sr# 315", "=ds="..AL["Vendor"]..": "..ALIL["Terokkar Forest"]};
				{ 10, "s38868", "31673", "=q1=Crunchy Serpent", "=ds=#sr# 335", "=ds="..AL["Vendor"]..": "..ALIL["Blade's Edge Mountains"]};
				{ 11, "s33295", "27666", "=q1=Golden Fish Sticks", "=ds=#sr# 325", "=ds="..AL["Vendor"]..": "..ALIL["Terokkar Forest"]};
				{ 12, "s33294", "27665", "=q1=Poached Bluefish", "=ds=#sr# 320", "=ds="..AL["Vendor"]..": "..ALIL["Nagrand"]};
				{ 13, "s46688", "35565", "=q1=Juicy Bear Burger", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Felwood"]};
				{ 14, "s64054", "33004", "=q1=Clamlette Magnifique", "=ds=#sr# 250", "=ds="..BabbleInventory["Quest"]..""};
				{
					{ 15, "s66035", "44840", "=q1=Cranberry Chutney", "=ds=#sr# 160", "=ds="..AL["Vendor"]};
					{ 15, "s62049", "44840", "=q1=Cranberry Chutney", "=ds=#sr# 160", "=ds="..AL["Vendor"]};
				};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Attack Power"], ""};
				{ 17, "s57423", "43015", "=q1=Fish Feast", "=ds=#sr# 450", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 18, "s45555", "34754", "=q1=Mega Mammoth Meal", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 19, "s45567", "34766", "=q1=Poached Northern Sculpin", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 20, "s58065", "43268", "=q1=Dalaran Clam Chowder", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 21, "s45554", "34753", "=q1=Great Feast", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 22, "s45563", "34762", "=q1=Grilled Sculpin", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 23, "s45549", "34748", "=q1=Mammoth Meal", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 24, "s33284", "27655", "=q1=Ravager Dog", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Hellfire Peninsula"]};
				{ 25, "s46684", "35563", "=q1=Charred Bear Kabobs", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Felwood"]};
				{ 26, "s64054", "33004", "=q1=Clamlette Magnifique", "=ds=#sr# 250", "=ds="..BabbleInventory["Quest"]..""};
				{
					{ 27, "s66037", "44838", "=q1=Slow-Roasted Turkey", "=ds=#sr# 280", "=ds="..AL["Vendor"]};
					{ 27, "s62045", "44838", "=q1=Slow-Roasted Turkey", "=ds=#sr# 280", "=ds="..AL["Vendor"]};
				};	
			};
		};
		info = {
			name = COOKING..": "..AL["Spell/Attack Power"],
			module = moduleName, menu = "COOKINGMENU"
		};
	};

	AtlasLoot_Data["CookingOtherBuffs"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..BabbleInventory["Pet"]};
				{ 2, "s57440", "43005", "=q1=Spiced Mammoth Treats", "=ds=#sr# 400", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 3, "s43772", "33874", "=q1=Kibler's Bits", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 5, 0, "INV_Box_01", "=q6="..AL["Health / Second"]};
				{ 6, "s18244", "13932", "=q1=Poached Sunscale Salmon", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Mana / Second"]};
				{ 17, "s33292", "27663", "=q1=Blackened Sporefish", "=ds=#sr# 310", "=ds="..AL["Vendor"]..": "..ALIL["Zangarmarsh"]};
				{ 18, "s18243", "13931", "=q1=Nightfin Soup", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 19, "s25954", "21217", "=q1=Sagefish Delight", "=ds=#sr# 175", "=ds="..AL["Vendor"]};
				{ 20, "s25704", "21072", "=q1=Smoked Sagefish", "=ds=#sr# 80", "=ds="..AL["Vendor"]};
			};
		};
		info = {
			name = COOKING..": "..AL["Other Buffs"],
			module = moduleName, menu = "COOKINGMENU"
		};
	};

	AtlasLoot_Data["CookingStandard"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Health"]};
				{ 2, "s124032", "85504", "=q1=Krasarang Fritters", "=ds=#sr# 525", "=ds="..ALIL["The Anglers"].." - "..AL["Friendly"]};
				{ 3, "s88018", "62677", "=q1=Fish Fry", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 4, "s88006", "62676", "=q1=Blackened Surprise", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 5, "s57421", "34747", "=q1=Northern Stew", "=ds=#sr# 350", "=ds="..BabbleInventory["Quest"]};
				{ 6, "s42296", "33048", "=q1=Stewed Trout", "=ds=#sr# 320", "=ds="..AL["Trainer"]};
				{ 7, "s104297", "74641", "=q1=Fish Cake", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 8, "s33290", "27661", "=q1=Blackened Trout", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Zangarmarsh"]};
				{ 9, "s18247", "13935", "=q1=Baked Salmon", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Feralas"]};
				{ 10, "s18245", "13933", "=q1=Lobster Stew", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Feralas"]};
				{ 11, "s18241", "13930", "=q1=Filet of Redgill", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Stranglethorn Vale"]};
				{ 12, "s18238", "6887", "=q1=Spotted Yellowtail", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 13, "s20626", "16766", "=q1=Undermine Clam Chowder", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"], amount = 2};
				{ 14, "s20916", "8364", "=q1=Mithril Head Trout", "=ds=#sr# 175", "=ds="..AL["Vendor"]};
				{ 15, "s7828", "4594", "=q1=Rockscale Cod", "=ds=#sr# 175", "=ds="..AL["Vendor"]};
				{ 17, "s2548", "2685", "=q1=Succulent Pork Ribs", "=ds=#sr# 110", "=ds="..AL["Drop"]};
				{ 18, "s7755", "4593", "=q1=Bristle Whisker Catfish", "=ds=#sr# 100", "=ds="..AL["Vendor"]};
				{ 19, "s6501", "5526", "=q1=Clam Chowder", "=ds=#sr# 90", "=ds="..AL["Vendor"]};
				{ 20, "s6417", "5478", "=q1=Dig Rat Stew", "=ds=#sr# 90", "=ds="..AL["Vendor"]};
				{ 21, "s2543", "733", "=q1=Westfall Stew", "=ds=#sr# 90", "=ds="..AL["Drop"], amount = 2};
				{ 22, "s7754", "6316", "=q1=Loch Frenzy Delight", "=ds=#sr# 50", "=ds="..AL["Vendor"]};	
				{ 23, "s7753", "4592", "=q1=Longjaw Mud Snapper", "=ds=#sr# 50", "=ds="..AL["Vendor"]};
				{ 24, "s7827", "5095", "=q1=Rainbow Fin Albacore", "=ds=#sr# 50", "=ds="..AL["Vendor"]};
				{ 25, "s93741", "67230", "=q1=Venison Jerky", "=ds=#sr# 40", "=ds="..AL["Trainer"]};
				{ 26, "s8607", "6890", "=q1=Smoked Bear Meat", "=ds=#sr# 40", "=ds="..AL["Vendor"]};
				{ 27, "s125117", "86057", "=q1=Sliced Peaches", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 28, "s7751", "6290", "=q1=Brilliant Smallfish", "=ds=#sr# 1", "=ds="..AL["Vendor"]};
				{ 29, "s2538", "2679", "=q1=Charred Wolf Meat", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 30, "s2540", "2681", "=q1=Roasted Boar Meat", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s7752", "787", "=q1=Slitherskin Mackerel", "=ds=#sr# 1", "=ds="..AL["Vendor"]};
				{ 16, "s37836", "30816", "=q1=Spice Bread", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 3, 0, "INV_Box_01", "=q6="..AL["Health and Mana"]};
				{ 4, "s124052", "75026", "=q1=Ginseng Tea", "=ds=#sr# 525", "=ds="..ALIL["Way of the Brew"]};
				{ 5, "s96133", "68687", "=q1=Scalding Murglesnout", "=ds=#sr# 500", "=ds="..AL["Cooking Daily"]};
				{ 6, "s64358", "45932", "=q1=Black Jelly", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 7, "s45561", "34760", "=q1=Grilled Bonescale", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 8, "s42305", "33053", "=q1=Hot Buttered Trout", "=ds=#sr# 350", "=ds="..AL["Trainer"], amount = 2};
				{ 9, "s45562", "34761", "=q1=Sauteed Goby", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 10, "s45560", "34759", "=q1=Smoked Rockfin", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 11, "s2545", "2682", "=q1=Cooked Crab Claw", "=ds=#sr# 85", "=ds="..AL["World Drop"]};
				{ 12, "s125067", "86026", "=q1=Perfectly Cooked Instant Noodles", "=ds=#sr# 30", "=ds="..AL["Trainer"]};
				{ 18, 0, "INV_Box_01", "=q6="..AL["Mana"]};
				{ 19, "s124029", "85501", "=q1=Viseclaw Soup", "=ds=#sr# 525", "=ds="..ALIL["The Anglers"].." - "..AL["Friendly"]};
				{ 20, "s88044", "62672", "=q1=South Island Ice Tea", "=ds=#sr# 525", "=ds="..AL["Cooking Daily"], amount = 5};
				{ 21, "s88045", "62675", "=q1=Starfire Espresso", "=ds=#sr# 450", "=ds="..AL["Cooking Daily"]};
				{ 22, "s53056", "39520", "=q1=Kungaloosh", "=ds=#sr# 350", "=ds=#QUESTID:13571#", amount = 5};
				{ 23, "s104237", "74636", "=q1=Golden Carp Consomme", "=ds=#sr# 270", "=ds="..AL["Trainer"]};
				{ 24, "s13028", "10841", "=q1=Goldthorn Tea", "=ds=#sr# 175", "=ds="..ALIL["Razorfen Downs"], amount = 4};
			};
		};
		info = {
			name = COOKING..": "..AL["Food without Buffs"],
			module = moduleName, menu = "COOKINGMENU"
		};
	};

		------------------
		--- Enchanting ---
		------------------

	AtlasLoot_Data["EnchantingBoots"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Agility"], ""};
				{ 2, "s104409", "inv_misc_note_01", "=ds=Enchant Boots - Blurred Speed", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 3, "s74213", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Major Agility", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 4, "s74252", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Assassin's Step", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 5, "s44589", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Superior Agility", "=ds=#sr# 410", "=ds="..AL["Trainer"]};
				{ 6, "s27951", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Dexterity", "=ds=#sr# 340", "=ds="..ALIL["Auchenai Crypts"]};
				{ 7, "s20023", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Greater Agility", "=ds=#sr# 295", "=ds="..AL["Trainer"]};
				{ 8, "s34007", "inv_enchant_formulasuperior_01", "=ds=Enchant Boots - Cat's Swiftness", "=ds=#sr# 360", "=ds="..AL["World Drop"]};
				{ 9, "s13935", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Agility", "=ds=#sr# 235", "=ds="..AL["Trainer"]};
				{ 10, "s13637", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Lesser Agility", "=ds=#sr# 160", "=ds="..AL["Trainer"]};
				{ 11, "s7867", "inv_misc_note_01", "=ds=Enchant Boots - Minor Agility", "=ds=#sr# 125", "=ds="..AL["Vendor"]};
				{ 13, 0, "INV_Box_01", "=q6="..AL["Attack Power"], ""};
				{ 14, "s60763", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Greater Assault", "=ds=#sr# 440", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 15, "s60606", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Assault", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Stamina"], ""};
				{ 17, "s74189", "spell_holy_greaterheal", "=ds=Enchant Boots - Earthen Vitality", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 18, "s44528", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Greater Fortitude", "=ds=#sr# 385", "=ds="..AL["Trainer"]};
				{ 19, "s47901", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Tuskarr's Vitality", "=ds=#sr# 440", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 20, "s27950", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Fortitude", "=ds=#sr# 320", "=ds="..ALIL["Mana-Tombs"]};
				{ 21, "s34008", "inv_enchant_formulasuperior_01", "=ds=Enchant Boots - Boar's Speed", "=ds=#sr# 360", "=ds="..AL["World Drop"]};
				{ 22, "s20020", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Greater Stamina", "=ds=#sr# 260", "=ds="..AL["World Drop"]};
				{ 23, "s13836", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Stamina", "=ds=#sr# 215", "=ds="..AL["Trainer"]};
				{ 24, "s13644", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Lesser Stamina", "=ds=#sr# 170", "=ds="..AL["Trainer"]};
				{ 25, "s7863", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Minor Stamina", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 27, 0, "INV_Box_01", "=q6="..AL["Spirit"], ""};
				{ 28, "s44508", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Greater Spirit", "=ds=#sr# 410", "=ds="..AL["Trainer"]};
				{ 29, "s20024", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Spirit", "=ds=#sr# 275", "=ds="..AL["World Drop"]};
				{ 30, "s13687", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Lesser Spirit", "=ds=#sr# 190", "=ds="..AL["World Drop"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Ratings"], ""};
				{ 2, "s104414", "inv_misc_note_01", "=ds=Enchant Boots - Pandaren's Step", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 3, "s104407", "inv_misc_note_01", "=ds=Enchant Boots - Greater Haste", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 4, "s104408", "inv_misc_note_01", "=ds=Enchant Boots - Greater Precision", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 5, "s74253", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Lavawalker", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 6, "s74238", "spell_holy_greaterheal", "=ds=Enchant Boots - Mastery", "=ds=#sr# 510", "=ds="..AL["Trainer"]};
				{ 7, "s74236", "spell_holy_greaterheal", "=ds=Enchant Boots - Precision", "=ds=#sr# 505", "=ds="..AL["Trainer"]};
				{ 8, "s74199", "spell_holy_greaterheal", "=ds=Enchant Boots - Haste", "=ds=#sr# 455", "=ds="..AL["Trainer"]};
				{ 9, "s60623", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Icewalker", "=ds=#sr# 385", "=ds="..AL["Trainer"]};
				{ 10, "s27954", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Surefooted", "=ds=#sr# 370", "=ds="..ALIL["Karazhan"]};
				{ 11, "s63746", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Lesser Accuracy", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 13, 0, "INV_Box_01", "=q6="..AL["Other"], ""};
				{ 14, "s44584", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Greater Vitality", "=ds=#sr# 405", "=ds="..AL["Trainer"]};
				{ 15, "s27948", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Vitality", "=ds=#sr# 305", "=ds="..AL["World Drop"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Speed"], ""};
				{ 17, "s104414", "inv_misc_note_01", "=ds=Enchant Boots - Pandaren's Step", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 18, "s104409", "inv_misc_note_01", "=ds=Enchant Boots - Blurred Speed", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 19, "s74252", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Assassin's Step", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 20, "s74253", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Lavawalker", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 21, "s34008", "inv_enchant_formulasuperior_01", "=ds=Enchant Boots - Boar's Speed", "=ds=#sr# 360", "=ds="..AL["World Drop"]};
				{ 22, "s34007", "inv_enchant_formulasuperior_01", "=ds=Enchant Boots - Cat's Swiftness", "=ds=#sr# 360", "=ds="..AL["World Drop"]};
				{ 23, "s74189", "spell_holy_greaterheal", "=ds=Enchant Boots - Earthen Vitality", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 24, "s47901", "inv_enchant_formulagood_01", "=ds=Enchant Boots - Tuskarr's Vitality", "=ds=#sr# 440", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 25, "s13890", "Spell_Holy_GreaterHeal", "=ds=Enchant Boots - Minor Speed", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant Boots"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingBracer"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Strength"], ""};
				{ 2, "s104390", "inv_enchant_formulasuperior_01", "=ds=Enchant Bracer - Exceptional Strength", "=ds=#sr# 600", "=ds="..ALIL["The August Celestials"].." - "..AL["Revered"]};
				{ 3, "s96261", "inv_enchant_formulasuperior_01", "=ds=Enchant Bracers - Major Strength", "=ds=#sr# 515", "=ds="..AL["World Drop"]};
				{ 4, "s27899", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Brawn", "=ds=#sr# 305", "=ds="..AL["Trainer"]};
				{ 5, "s20010", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Superior Strength", "=ds=#sr# 295", "=ds="..ALIL["Deadwind Pass"]};
				{ 6, "s13939", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Greater Strength", "=ds=#sr# 240", "=ds="..AL["Trainer"]};
				{ 7, "s13661", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Strength", "=ds=#sr# 180", "=ds="..AL["Trainer"]};
				{ 8, "s13536", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Lesser Strength", "=ds=#sr# 140", "=ds="..AL["Vendor"]};
				{ 9, "s7782", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Minor Strength", "=ds=#sr# 80", "=ds="..AL["World Drop"]};
				{ 11, 0, "INV_Box_01", "=q6="..AL["Agility"], ""};
				{ 12, "s104391", "inv_enchant_formulasuperior_01", "=ds=Enchant Bracer - Greater Agility", "=ds=#sr# 600", "=ds="..ALIL["The August Celestials"].." - "..AL["Revered"]};
				{ 13, "s96264", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Agility", "=ds=#sr# 515", "=ds="..AL["World Drop"]};
				{ 14, "s7779", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Minor Agility", "=ds=#sr# 80", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Intellect"], ""};
				{ 17, "s104389", "inv_enchant_formulasuperior_01", "=ds=Enchant Bracer - Super Intellect", "=ds=#sr# 600", "=ds="..ALIL["The August Celestials"].." - "..AL["Revered"]};
				{ 18, "s96262", "inv_enchant_formulasuperior_01", "=ds=Enchant Bracers - Mighty Intellect", "=ds=#sr# 515", "=ds="..AL["World Drop"]};
				{ 19, "s44555", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Exceptional Intellect", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 20, "s34001", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Major Intellect", "=ds=#sr# 305", "=ds="..AL["Trainer"]};
				{ 21, "s20008", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Greater Intellect", "=ds=#sr# 255", "=ds="..AL["Trainer"]};
				{ 22, "s13822", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Intellect", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 23, "s13622", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Lesser Intellect", "=ds=#sr# 150", "=ds="..AL["Trainer"]};
				{ 25, 0, "INV_Box_01", "=q6="..AL["Dodge Rating"], ""};
				{ 26, "s104385", "inv_misc_note_01", "=ds=Enchant Bracer - Major Dodge", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 27, "s74229", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracer - Superior Dodge", "=ds=#sr# 490", "=ds="..AL["Trainer"]};
				{ 28, "s13931", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Dodge", "=ds=#sr# 235", "=ds="..AL["Vendor"]};
				{ 29, "s13646", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Lesser Dodge", "=ds=#sr# 170", "=ds="..AL["Vendor"]};
				{ 30, "s7428", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Minor Dodge", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Stamina"], ""};
				{ 2, "s62256", "inv_enchant_formulasuperior_01", "=ds=Enchant Bracers - Major Stamina", "=ds=#sr# 450", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 3, "s27914", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Fortitude", "=ds=#sr# 350", "=ds="..ALIL["The Steamvault"]};
				{ 4, "s20011", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Superior Stamina", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
				{ 5, "s13945", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Greater Stamina", "=ds=#sr# 245", "=ds="..AL["World Drop"]};
				{ 6, "s13648", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Stamina", "=ds=#sr# 170", "=ds="..AL["Trainer"]};
				{ 7, "s13501", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Lesser Stamina", "=ds=#sr# 130", "=ds="..AL["Trainer"]};
				{ 8, "s7457", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Minor Stamina", "=ds=#sr# 50", "=ds="..AL["Trainer"]};
				{ 9, "s7418", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Minor Health", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 11, 0, "INV_Box_01", "=q6="..AL["Attack Power"], ""};
				{ 12, "s44575", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Greater Assault", "=ds=#sr# 430", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 13, "s60616", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Striking", "=ds=#sr# 360", "=ds="..AL["Trainer"]};
				{ 14, "s34002", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Assault", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Spirit"], ""};
				{ 17, "s74237", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracer - Exceptional Spirit", "=ds=#sr# 505", "=ds="..AL["Trainer"]};
				{ 18, "s44593", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Major Spirit", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 19, "s20009", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Superior Spirit", "=ds=#sr# 270", "=ds="..AL["World Drop"]};
				{ 20, "s13846", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Greater Spirit", "=ds=#sr# 220", "=ds="..AL["World Drop"]};
				{ 21, "s13642", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Spirit", "=ds=#sr# 165", "=ds="..AL["Trainer"]};
				{ 22, "s7859", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Lesser Spirit", "=ds=#sr# 120", "=ds="..AL["World Drop"]};
				{ 23, "s7766", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Minor Spirit", "=ds=#sr# 60", "=ds="..AL["World Drop"]};
				{ 25, 0, "INV_Box_01", "=q6="..AL["Spell Power"], ""};
				{ 26, "s60767", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Superior Spellpower", "=ds=#sr# 440", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 27, "s44635", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Greater Spellpower", "=ds=#sr# 395", "=ds="..AL["Trainer"]};
				{ 28, "s27917", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Spellpower", "=ds=#sr# 360", "=ds="..AL["Drop"]};
				{
					{ 29, "s27911", "inv_misc_note_01", "=ds=Enchant Bracers - Superior Healing", "=ds=#sr# 325", "=ds="..ALIL["Thrallmar"].." - "..AL["Friendly"]};
					{ 29, "s27911", "inv_misc_note_01", "=ds=Enchant Bracers - Superior Healing", "=ds=#sr# 325", "=ds="..ALIL["Honor Hold"].." - "..AL["Friendly"]};
				};
				{ 30, "s23802", "inv_misc_note_01", "=ds=Enchant Bracers - Healing Power", "=ds=#sr# 300", "=ds="..ALIL["Argent Dawn"].." - "..AL["Revered"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Crit Rating"], ""};
				{ 2, "s74248", "inv_enchant_formulagood_01", "=ds=Enchant Bracer - Greater Critical Strike", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 3, "s74201", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracer - Critical Strike", "=ds=#sr# 460", "=ds="..AL["Trainer"]};
				{ 5, 0, "INV_Box_01", "=q6="..AL["Haste Rating"], ""};
				{ 6, "s74256", "inv_enchant_formulagood_01", "=ds=Enchant Bracer - Greater Speed", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 7, "s74193", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracer - Speed", "=ds=#sr# 435", "=ds="..AL["Trainer"]};
				{ 9, 0, "INV_Box_01", "=q6="..AL["Mana / Second"], ""};
				{ 10, "s27913", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Restore Mana Prime", "=ds=#sr# 335", "=ds="..AL["World Drop"]};
				{ 11, "s23801", "inv_misc_note_01", "=ds=Enchant Bracers - Mana Regeneration", "=ds=#sr# 290", "=ds="..ALIL["Argent Dawn"].." - "..AL["Honored"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Stats"], ""};
				{ 17, "s44616", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Greater Stats", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 18, "s27905", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Stats", "=ds=#sr# 315", "=ds="..AL["Trainer"]};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Other"], ""};
				{ 21, "s104338", "inv_misc_note_01", "=ds=Enchant Bracer - Mastery", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 22, "s74239", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracers - Greater Expertise", "=ds=#sr# 510", "=ds="..AL["Trainer"]};
				{ 23, "s74232", "Spell_Holy_GreaterHeal", "=ds=Enchant Bracer - Precision", "=ds=#sr# 495", "=ds="..AL["Trainer"]};
				{ 24, "s44598", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Expertise", "=ds=#sr# 420", "=ds="..AL["Trainer"]};
				{ 25, "s27906", "inv_enchant_formulagood_01", "=ds=Enchant Bracers - Greater Dodge", "=ds=#sr# 320", "=ds="..ALIL["Netherstorm"]};
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant Bracer"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingChest"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Stats"], ""};
				{ 2, "s104395", "inv_misc_note_01", "=ds=Enchant Chest - Glorious Stats", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 3, "s74250", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Peerless Stats", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 4, "s74191", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Mighty Stats", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 5, "s60692", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Powerful Stats", "=ds=#sr# 440", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 6, "s44623", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Super Stats", "=ds=#sr# 370", "=ds="..AL["Trainer"]};
				{ 7, "s27960", "inv_misc_note_01", "=ds=Enchant Chest - Exceptional Stats", "=ds=#sr# 345", "=ds="..AL["Vendor"]};
				{ 8, "s20025", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Greater Stats", "=ds=#sr# 300", "=ds="..AL["World Drop"]};
				{ 9, "s13941", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Stats", "=ds=#sr# 245", "=ds="..AL["Trainer"]};
				{ 10, "s13700", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Lesser Stats", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 11, "s13626", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Minor Stats", "=ds=#sr# 150", "=ds="..AL["Trainer"]};
				{ 13, 0, "INV_Box_01", "=q6="..AL["Mana / Second"], ""};
				{ 14, "s44509", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Greater Mana Restoration", "=ds=#sr# 420", "=ds="..AL["Trainer"]};
				{ 15, "s33991", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Restore Mana Prime", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Health"], ""};
				{ 17, "s104397", "inv_misc_note_01", "=ds=Enchant Chest - Superior Stamina", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 18, "s74251", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Greater Stamina", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 19, "s74200", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Stamina", "=ds=#sr# 460", "=ds="..AL["Trainer"]};
				{ 20, "s47900", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Super Health", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 21, "s44492", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Mighty Health", "=ds=#sr# 395", "=ds="..AL["Trainer"]};
				{ 22, "s27957", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Exceptional Health", "=ds=#sr# 315", "=ds="..AL["Trainer"]};
				{ 23, "s20026", "inv_misc_note_01", "=ds=Enchant Chest - Major Health", "=ds=#sr# 275", "=ds="..AL["Vendor"]};
				{ 24, "s13858", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Superior Health", "=ds=#sr# 220", "=ds="..AL["Trainer"]};
				{ 25, "s13640", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Greater Health", "=ds=#sr# 160", "=ds="..AL["Trainer"]};
				{ 26, "s7857", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Health", "=ds=#sr# 120", "=ds="..AL["Trainer"]};
				{ 27, "s7748", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Lesser Health", "=ds=#sr# 60", "=ds="..AL["Trainer"]};
				{ 28, "s7420", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Minor Health", "=ds=#sr# 15", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Resilience"], ""};
				{ 2, "s104392", "inv_misc_note_01", "=ds=Enchant Chest - Super Resilience", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 3, "s74214", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Mighty Resilience", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 4, "s44588", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Exceptional Resilience", "=ds=#sr# 410", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 5, "s33992", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Major Resilience", "=ds=#sr# 345", "=ds="..AL["World Drop"]};
				{ 7, 0, "INV_Box_01", "=q6="..AL["Mana"], ""};
				{ 8, "s27958", "inv_misc_note_01", "=ds=Enchant Chest - Exceptional Mana", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 9, "s20028", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Major Mana", "=ds=#sr# 290", "=ds="..AL["Trainer"]};
				{ 10, "s13917", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Superior Mana", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 11, "s13663", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Greater Mana", "=ds=#sr# 185", "=ds="..AL["Trainer"]};
				{ 12, "s13607", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Mana", "=ds=#sr# 145", "=ds="..AL["Trainer"]};
				{ 13, "s7776", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Lesser Mana", "=ds=#sr# 80", "=ds="..AL["Vendor"]};
				{ 14, "s7443", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Minor Mana", "=ds=#sr# 20", "=ds="..AL["World Drop"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Spirit"], ""};
				{ 17, "s104393", "inv_misc_note_01", "=ds=Enchant Chest - Mighty Spirit", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 18, "s74231", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Exceptional Spirit", "=ds=#sr# 495", "=ds="..AL["Trainer"]};
				{ 19, "s33990", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Major Spirit", "=ds=#sr# 320", "=ds="..AL["Trainer"]};
				{ 21, 0, "INV_Box_01", "=q6="..AL["Dodge Rating"], ""};
				{ 22, "s47766", "inv_enchant_formulagood_01", "=ds=Enchant Chest - Greater Dodge", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 23, "s46594", "inv_misc_note_01", "=ds=Enchant Chest - Dodge", "=ds=#sr# 360", "=ds="..AL["Vendor"]};
				{ 25, 0, "INV_Box_01", "=q6="..AL["Damage Absorption"], ""};
				{ 26, "s13538", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Lesser Absorption", "=ds=#sr# 140", "=ds="..AL["Trainer"]};
				{ 27, "s7426", "Spell_Holy_GreaterHeal", "=ds=Enchant Chest - Minor Absorption", "=ds=#sr# 40", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant Chest"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingCloak"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Agility"], ""};
				{ 2, "s60663", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Major Agility", "=ds=#sr# 420", "=ds="..AL["Trainer"]};
				{ 3, "s44500", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Superior Agility", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 4, "s34004", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Greater Agility", "=ds=#sr# 310", "=ds="..AL["Trainer"]};
				{ 5, "s13882", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Lesser Agility", "=ds=#sr# 225", "=ds="..ALIL["Tanaris"]};
				{ 6, "s13419", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Minor Agility", "=ds=#sr# 110", "=ds="..AL["Vendor"]};
				{ 8, 0, "INV_Box_01", "=q6="..AL["Crit Rating"], ""};
				{ 9, "s104404", "inv_misc_note_01", "=ds=Enchant Cloak - Superior Critical Strike", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 10, "s74247", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Greater Critical Strike", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 11, "s74230", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Critical Strike", "=ds=#sr# 490", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleInventory["Armor"].." & "..AL["Stamina"], ""};
				{ 17, "s104401", "inv_misc_note_01", "=ds=Enchant Cloak - Greater Protection", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 18, "s74234", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Protection", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 19, "s47672", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Mighty Armor", "=ds=#sr# 430", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 20, "s27961", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Major Armor", "=ds=#sr# 310", "=ds="..AL["Trainer"]};
				{ 21, "s20015", "inv_misc_note_01", "=ds=Enchant Cloak - Superior Defense", "=ds=#sr# 285", "=ds="..AL["Vendor"]};
				{ 22, "s13746", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Greater Defense", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 23, "s13635", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Defense", "=ds=#sr# 155", "=ds="..AL["Trainer"]};
				{ 24, "s13421", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Lesser Protection", "=ds=#sr# 115", "=ds="..AL["Trainer"]};
				{ 25, "s7771", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Minor Protection", "=ds=#sr# 70", "=ds="..AL["Trainer"]};
				{ 27, 0, "INV_Box_01", "=q6="..AL["Intellect"], ""};
				{ 28, "s104403", "inv_misc_note_01", "=ds=Enchant Cloak - Superior Intellect", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 29, "s74240", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Greater Intellect", "=ds=#sr# 510", "=ds="..AL["Trainer"]};
				{ 30, "s74202", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Intellect", "=ds=#sr# 465", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Dodge Rating"], ""};
				{ 2, "s44591", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Superior Dodge", "=ds=#sr# 435", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 3, "s47051", "inv_enchant_formulasuperior_01", "=ds=Enchant Cloak - Greater Dodge", "=ds=#sr# 375", "=ds="..ALIL["Magisters' Terrace"]};
				{ 4, "s25086", "inv_enchant_formulasuperior_01", "=ds=Enchant Cloak - Dodge", "=ds=#sr# 300", "=ds="..AL["Vendor"]};
				{ 5, "s25083", "inv_enchant_formulasuperior_01", "=ds=Enchant Cloak - Stealth", "=ds=#sr# 300", "=ds="..AL["Vendor"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Other"], ""};
				{ 17, "s104398", "inv_misc_note_01", "=ds=Enchant Cloak - Accuracy", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 18, "s44631", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Shadow Armor", "=ds=#sr# 440", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 19, "s47899", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Wisdom", "=ds=#sr# 440", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 20, "s74192", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Lesser Power", "=ds=#sr# 435", "=ds="..AL["Trainer"]};
				{ 21, "s47898", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Greater Speed", "=ds=#sr# 430", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 22, "s44582", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Minor Power", "=ds=#sr# 395", "=ds="..AL["Trainer"]};
				{ 23, "s60609", "Spell_Holy_GreaterHeal", "=ds=Enchant Cloak - Speed", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 24, "s34003", "inv_enchant_formulagood_01", "=ds=Enchant Cloak - Spell Penetration", "=ds=#sr# 325", "=ds="..AL["Vendor"]};
				{
					{ 25, "s25084", "inv_enchant_formulasuperior_01", "=ds=Enchant Cloak - Subtlety", "=ds=#sr# 300", "=ds="..ALIL["Thrallmar"].." - "..AL["Exalted"]};
					{ 25, "s25084", "inv_enchant_formulasuperior_01", "=ds=Enchant Cloak - Subtlety", "=ds=#sr# 300", "=ds="..ALIL["Honor Hold"].." - "..AL["Exalted"]};
				};
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant Cloak"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingGloves"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Agility"], ""};
				{ 2, "s44529", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Major Agility", "=ds="..AL["Trainer"]};
				{ 3, "s25080", "inv_enchant_formulasuperior_01", "=ds=Enchant Gloves - Superior Agility", "=ds=#sr# 300", "=ds="..ALIL["Keepers of Time"].." - "..AL["Exalted"]};
				{ 4, "s20012", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Greater Agility", "=ds=#sr# 270", "=ds="..AL["Trainer"]};
				{ 5, "s13815", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Agility", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 7, 0, "INV_Box_01", "=q6="..AL["Attack Power"], ""};
				{ 8, "s60668", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Crusher", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 9, "s44513", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Greater Assault", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 10, "s33996", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Assault", "=ds=#sr# 310", "=ds="..AL["Trainer"]};
				{ 12, 0, "INV_Box_01", "=q6="..AL["Haste Rating"], ""};
				{ 13, "s104416", "inv_misc_note_01", "=ds=Enchant Gloves - Greater Haste", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 14, "s74198", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Haste", "=ds=#sr# 455", "=ds="..AL["Trainer"]};
				{ 15, "s13948", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Minor Haste", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Strength"], ""};
				{ 17, "s104419", "inv_misc_note_01", "=ds=Enchant Gloves - Super Strength", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 18, "s74254", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Mighty Strength", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 19, "s74212", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Exceptional Strength", "=ds=#sr# 470", "=ds="..AL["Trainer"]};
				{ 20, "s33995", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Major Strength", "=ds=#sr# 340", "=ds="..AL["Trainer"]};
				{ 21, "s20013", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Greater Strength", "=ds=#sr# 295", "=ds="..AL["Trainer"]};
				{ 22, "s13887", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Strength", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 24, 0, "INV_Box_01", "=q6="..AL["Mastery Rating"], ""};
				{ 25, "s104420", "inv_misc_note_01", "=ds=Enchant Gloves - Superior Mastery", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 26, "s74255", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Greater Mastery", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 27, "s74132", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Mastery", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Expertise Rating"], ""};
				{ 2, "s104417", "inv_misc_note_01", "=ds=Enchant Gloves - Superior Expertise", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 3, "s74220", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Greater Expertise", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 4, "s44484", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Expertise", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 6, 0, "INV_Box_01", "=q6="..AL["Spell Power"], ""};
				{ 7, "s44592", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Exceptional Spellpower", "=ds=#sr# 360", "=ds="..AL["Trainer"] };
				{ 8, "s33997", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Major Spellpower", "=ds=#sr# 360", "=ds="..AL["Vendor"]};
				{ 9, "s33999", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Major Healing", "=ds=#sr# 350", "=ds="..AL["Vendor"]};
				{ 10, "s25078", "inv_enchant_formulasuperior_01", "=ds=Enchant Gloves - Fire Power", "=ds=#sr# 300", "=ds="..ALIL["Temple of Ahn'Qiraj"]};
				{ 11, "s25074", "inv_enchant_formulasuperior_01", "=ds=Enchant Gloves - Frost Power", "=ds=#sr# 300", "=ds="..ALIL["Temple of Ahn'Qiraj"]};
				{ 12, "s25079", "inv_enchant_formulasuperior_01", "=ds=Enchant Gloves - Healing Power", "=ds=#sr# 300", "=ds="..ALIL["Temple of Ahn'Qiraj"]};
				{ 13, "s25073", "inv_enchant_formulasuperior_01", "=ds=Enchant Gloves - Shadow Power", "=ds=#sr# 300", "=ds="..ALIL["Temple of Ahn'Qiraj"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Hit Rating"], ""};
				{ 17, "s44488", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Precision", "=ds=#sr# 410", "=ds="..AL["Trainer"] };
				{ 18, "s33994", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Precise Strikes", "=ds=#sr# 360", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Revered"]};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Professions"], ""};
				{ 21, "s44506", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Gatherer", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 22, "s71692", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Angler", "=ds=#sr# 375", "=ds="..AL["Drop"]};
				{ 23, "s13868", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Advanced Herbalism", "=ds=#sr# 225", "=ds="..AL["Drop"]};
				{ 24, "s13841", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Advanced Mining", "=ds=#sr# 215", "=ds="..AL["Drop"]};
				{ 25, "s13698", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Skinning", "=ds=#sr# 200", "=ds="..AL["Drop"]};
				{ 26, "s13620", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Fishing", "=ds=#sr# 145", "=ds="..AL["Drop"]};
				{ 27, "s13617", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Herbalism", "=ds=#sr# 145", "=ds="..AL["Drop"]};
				{ 28, "s13612", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Mining", "=ds=#sr# 145", "=ds="..AL["Drop"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Other"], ""};
				{ 2, "s44625", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Armsman", "=ds=#sr# 435", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s33993", "Spell_Holy_GreaterHeal", "=ds=Enchant Gloves - Blasting", "=ds=#sr# 305", "=ds="..AL["Trainer"]};
				{ 4, "s25072", "inv_enchant_formulasuperior_01", "=ds=Enchant Gloves - Threat", "=ds=#sr# 300", "=ds="..ALIL["The Sha'tar"].." - "..AL["Exalted"]};
				{ 5, "s13947", "inv_enchant_formulagood_01", "=ds=Enchant Gloves - Riding Skill", "=ds=#sr# 250", "=ds="..AL["World Drop"]};
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant Gloves"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingRing"] = {
		["Normal"] = {
			{
				{ 1, "s103461", "inv_misc_note_01", "=ds=Enchant Ring - Greater Agility", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 2, "s103462", "inv_misc_note_01", "=ds=Enchant Ring - Greater Intellect", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 3, "s103463", "inv_misc_note_01", "=ds=Enchant Ring - Greater Stamina", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 4, "s103465", "inv_misc_note_01", "=ds=Enchant Ring - Greater Strength", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 6, "s74216", "Spell_Holy_GreaterHeal", "=ds=Enchant Ring - Agility", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 7, "s74218", "Spell_Holy_GreaterHeal", "=ds=Enchant Ring - Stamina", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 8, "s74217", "Spell_Holy_GreaterHeal", "=ds=Enchant Ring - Intellect", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 9, "s74215", "Spell_Holy_GreaterHeal", "=ds=Enchant Ring - Strength", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 10, "s44645", "Spell_Holy_GreaterHeal", "=ds=Enchant Ring - Assault", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 11, "s44636", "Spell_Holy_GreaterHeal", "=ds=Enchant Ring - Lesser Intellect", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 12, "s59636", "Spell_Holy_GreaterHeal", "=ds=Enchant Ring - Lesser Stamina", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 16, "s27927", "inv_misc_note_01", "=ds=Enchant Ring - Stats", "=ds=#sr# 375", "=ds="..AL["Vendor"]};
				{ 17, "s27924", "inv_misc_note_01", "=ds=Enchant Ring - Minor Intellect", "=ds=#sr# 360", "=ds="..AL["Vendor"]};
				{ 18, "s27920", "inv_misc_note_01", "=ds=Enchant Ring - Striking", "=ds=#sr# 360", "=ds="..AL["Vendor"]};
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant Ring"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingShieldOffHand"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Other"], ""};
				{ 2, "s130758", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Greater Parry", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 3, "s74226", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Mastery", "=ds=#sr# 485", "=ds="..AL["Trainer"]};
				{ 4, "s74207", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Protection", "=ds=#sr# 465", "=ds="..AL["Trainer"]};
				{ 5, "s44489", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Dodge", "=ds=#sr# 420", "=ds="..AL["Trainer"]};
				{ 6, "s60653", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Greater Intellect", "=ds=#sr# 395", "=ds="..AL["Trainer"]};
				{ 7, "s27946", "inv_enchant_formulagood_01", "=ds=Enchant Shield - Parry", "=ds=#sr# 340", "=ds="..AL["World Drop"]};
				{ 8, "s44383", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Resilience", "=ds=#sr# 330", "=ds="..AL["Trainer"]};
				{ 9, "s27945", "inv_misc_note_01", "=ds=Enchant Shield - Intellect", "=ds=#sr# 325", "=ds="..AL["Vendor"]};
				{ 10, "s27944", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Lesser Dodge", "=ds=#sr# 310", "=ds="..AL["Trainer"]};
				{ 11, "s20016", "inv_enchant_formulagood_01", "=ds=Enchant Shield - Vitality", "=ds=#sr# 280", "=ds="..AL["Trainer"]};
				{ 12, "s13689", "inv_enchant_formulagood_01", "=ds=Enchant Shield - Lesser Parry", "=ds=#sr# 195", "=ds="..AL["World Drop"]};
				{ 13, "s13464", "inv_enchant_formulagood_01", "=ds=Enchant Shield - Lesser Protection", "=ds=#sr# 115", "=ds="..AL["World Drop"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Intellect"], ""};
				{ 17, "s104445", "inv_misc_note_01", "=ds=Enchant Off-Hand - Major Intellect", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 18, "s74235", "Spell_Holy_GreaterHeal", "=ds=Enchant Off-Hand - Superior Intellect", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Stamina"], ""};
				{ 21, "s34009", "inv_misc_note_01", "=ds=Enchant Shield - Major Stamina", "=ds=#sr# 325", "=ds="..AL["Vendor"]};
				{ 22, "s20017", "inv_misc_note_01", "=ds=Enchant Shield - Greater Stamina", "=ds=#sr# 265", "=ds="..AL["Vendor"]};
				{ 23, "s13817", "inv_enchant_formulagood_01", "=ds=Enchant Shield - Stamina", "=ds=#sr# 210", "=ds="..AL["World Drop"]};
				{ 24, "s13631", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Lesser Stamina", "=ds=#sr# 155", "=ds="..AL["Trainer"]};
				{ 25, "s13378", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Minor Stamina", "=ds=#sr# 105", "=ds="..AL["Trainer"]};
				{ 27, 0, "INV_Box_01", "=q6="..AL["Spirit"], ""};
				{ 28, "s13905", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Greater Spirit", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 29, "s13659", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Spirit", "=ds=#sr# 180", "=ds="..AL["Trainer"]};
				{ 30, "s13485", "Spell_Holy_GreaterHeal", "=ds=Enchant Shield - Lesser Spirit", "=ds=#sr# 130", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant Shield & Off-Hand"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingWeapon"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Proc"], ""};
				{ 2, "s104434", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Dancing Steel", "=ds=#sr# 600", "=ds="..ALIL["Shado-Pan"].." - "..AL["Revered"]};
				{ 3, "s104427", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Jade Spirit", "=ds=#sr# 600", "=ds="..ALIL["Shado-Pan"].." - "..AL["Revered"]};
				{ 4, "s104442", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - River's Song", "=ds=#sr# 600", "=ds="..ALIL["Shado-Pan"].." - "..AL["Revered"]};
				{ 5, "s104440", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Colossus", "=ds=#sr# 575", "=ds="..AL["Trainer"]};
				{ 6, "s104425", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Windsong", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 7, "s104430", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Elemental Force", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 8, "s74244", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Windwalk", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 9, "s74223", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Hurricane", "=ds=#sr# 480", "=ds="..AL["Trainer"]};
				{ 10, "s74197", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Avalanche", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 11, "s74195", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Mending", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 12, "s64441", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Blade Ward", "=ds=#sr# 450"};
				{ 13, "s64579", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Blood Draining", "=ds=#sr# 450"};
				{ 14, "s59625", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Black Magic", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 15, "s44576", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Lifeward", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s44524", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Icebreaker", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 17, "s42974", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Executioner", "=ds=#sr# 375"};
				{ 18, "s28004", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Battlemaster", "=ds=#sr# 360"};
				{ 19, "s28003", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Spellsurge", "=ds=#sr# 360"};
				{ 20, "s46578", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Deathfrost", "=ds=#sr# 350"};
				{ 21, "s20034", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Crusader", "=ds=#sr# 300"};
				{ 22, "s20032", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Lifestealing", "=ds=#sr# 300"};
				{ 23, "s20033", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Unholy Weapon", "=ds=#sr# 295"};
				{ 24, "s20029", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Icy Chill", "=ds=#sr# 285"};
				{ 25, "s13898", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Fiery Weapon", "=ds=#sr# 265"};
				{ 27, 0, "INV_Box_01", "=q6="..AL["Intellect"], ""};
				{ 28, "s74242", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Power Torrent", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 29, "s27968", "inv_enchant_formulagood_01", "=ds=Enchant Weapon - Major Intellect", "=ds=#sr# 340", "=ds="..AL["Drop"]};
				{ 30, "s23804", "inv_misc_note_01", "=ds=Enchant Weapon - Mighty Intellect", "=ds=#sr# 300", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Damage"], ""};
				{ 2, "s74211", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Elemental Slayer", "=ds=#sr# 470", "=ds="..AL["Trainer"]};
				{ 3, "s44621", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Giant Slayer", "=ds=#sr# 430", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 4, "s27967", "inv_misc_note_01", "=ds=Enchant Weapon - Major Striking", "=ds=#sr# 340", "=ds="..ALIL["The Consortium"].." - "..AL["Honored"]};
				{ 5, "s20031", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Superior Striking", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 6, "s13943", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Greater Striking", "=ds=#sr# 245", "=ds="..AL["Trainer"]};
				{ 7, "s13915", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Demonslaying", "=ds=#sr# 230", "=ds="..AL["Drop"]};
				{ 8, "s13693", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Striking", "=ds=#sr# 195", "=ds="..AL["Trainer"]};
				{ 9, "s13653", "inv_enchant_formulagood_01", "=ds=Enchant Weapon - Lesser Beastslayer", "=ds=#sr# 175", "=ds="..AL["Drop"]};
				{ 10, "s13655", "inv_enchant_formulagood_01", "=ds=Enchant Weapon - Lesser Elemental Slayer", "=ds=#sr# 175", "=ds="..AL["Drop"]};
				{ 11, "s13503", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Lesser Striking", "=ds=#sr# 140", "=ds="..AL["Trainer"]};
				{ 12, "s7786", "inv_enchant_formulagood_01", "=ds=Enchant Weapon - Minor Beastslayer", "=ds=#sr# 90", "=ds="..AL["Drop"]};
				{ 13, "s7788", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Minor Striking", "=ds=#sr# 90", "=ds="..AL["Trainer"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Strength"], ""};
				{ 17, "s27972", "inv_enchant_formulagood_01", "=ds=Enchant Weapon - Potency", "=ds=#sr# 350", "=ds="..AL["Drop"]};
				{ 18, "s23799", "inv_misc_note_01", "=ds=Enchant Weapon - Strength", "=ds=#sr# 290", "=ds="..AL["Vendor"]};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Attack Power"], ""};
				{ 21, "s74246", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Landslide", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 22, "s59621", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Berserking", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 23, "s60707", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Superior Potency", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 24, "s60621", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Greater Potency", "=ds="..AL["Trainer"] };
				{ 26, 0, "INV_Box_01", "=q6="..AL["Spirit"], ""};
				{ 27, "s74225", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Heartsong", "=ds=#sr# 485", "=ds="..AL["Trainer"]};
				{ 28, "s44510", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Exceptional Spirit", "=ds="..AL["Trainer"] };
				{ 29, "s23803", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Mighty Spirit", "=ds=#sr# 300"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Spell Power"], ""};
				{ 2, "s60714", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Mighty Spellpower", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s44629", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Exceptional Spellpower", "=ds=#sr# 395", "=ds="..AL["Trainer"] };
				{ 4, "s27982", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Soulfrost", "=ds=#sr# 375"};
				{ 5, "s27981", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Sunfire", "=ds=#sr# 375"};
				{ 6, "s34010", "inv_enchant_formulagood_01", "=ds=Enchant Weapon - Major Healing", "=ds=#sr# 350"};
				{ 7, "s27975", "inv_enchant_formulagood_01", "=ds=Enchant Weapon - Major Spellpower", "=ds=#sr# 350"};
				{ 8, "s22750", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Healing Power", "=ds=#sr# 300"};
				{ 9, "s22749", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Spellpower", "=ds=#sr# 300"};
				{ 10, "s21931", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Winter's Might", "=ds=#sr# 190"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Agility"], ""};
				{ 17, "s44633", "inv_enchant_formulagood_01", "=ds=Enchant Weapon - Exceptional Agility", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 18, "s27984", "inv_enchant_formulasuperior_01", "=ds=Enchant Weapon - Mongoose", "=ds=#sr# 375", "=ds="..AL["Drop"]};
				{ 19, "s42620", "inv_misc_note_01", "=ds=Enchant Weapon - Greater Agility", "=ds=#sr# 350", "=ds="..ALIL["The Violet Eye"].." - "..AL["Exalted"]};
				{ 20, "s23800", "inv_misc_note_01", "=ds=Enchant Weapon - Agility", "=ds=#sr# 290", "=ds="..ALIL["Timbermaw Hold"].." - "..AL["Honored"]};
				{ 22, 0, "INV_Box_01", "=q6="..AL["Other"], ""};
				{ 23, "s59619", "Spell_Holy_GreaterHeal", "=ds=Enchant Weapon - Accuracy", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant Weapon"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["Enchanting2HWeapon"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Agility"], ""};
				{ 2, "s95471", "Spell_Holy_GreaterHeal", "=ds=Enchant 2H Weapon - Mighty Agility", "=ds=#sr# 470", "=ds="..AL["Trainer"]};
				{ 3, "s27977", "inv_enchant_formulagood_01", "=ds=Enchant 2H Weapon - Major Agility", "=ds=#sr# 360", "=ds="..ALIL["The Arcatraz"]};
				{ 4, "s27837", "inv_misc_note_01", "=ds=Enchant 2H Weapon - Agility", "=ds=#sr# 290", "=ds="..AL["Vendor"]};
				{ 6, 0, "INV_Box_01", "=q6="..AL["Attack Power"], ""};
				{ 7, "s60691", "Spell_Holy_GreaterHeal", "=ds=Enchant 2H Weapon - Massacre", "=ds=#sr# 430", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 8, "s44630", "inv_enchant_formulagood_01", "=ds=Enchant 2H Weapon - Greater Savagery", "=ds=#sr# 410", "=ds="..AL["Trainer"]};
				{ 9, "s27971", "inv_enchant_formulagood_01", "=ds=Enchant 2H Weapon - Savagery", "=ds=#sr# 350", "=ds="..ALIL["The Shattered Halls"]};
				{ 11, 0, "INV_Box_01", "=q6="..AL["Intellect"], ""};
				{ 12, "s20036", "inv_enchant_formulagood_01", "=ds=Enchant 2H Weapon - Major Intellect", "=ds=#sr# 300", "=ds="..ALIL["Stratholme"]};
				{ 13, "s7793", "inv_misc_note_01", "=ds=Enchant 2H Weapon - Lesser Intellect", "=ds=#sr# 100", "=ds="..AL["Vendor"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Damage"], ""};
				{ 17, "s20030", "inv_enchant_formulagood_01", "=ds=Enchant 2H Weapon - Superior Impact", "=ds=#sr# 295", "=ds="..AL["Trainer"]};
				{ 18, "s13937", "Spell_Holy_GreaterHeal", "=ds=Enchant 2H Weapon - Greater Impact", "=ds=#sr# 240", "=ds="..AL["Trainer"]};
				{ 19, "s13695", "Spell_Holy_GreaterHeal", "=ds=Enchant 2H Weapon - Impact", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 20, "s13529", "Spell_Holy_GreaterHeal", "=ds=Enchant 2H Weapon - Lesser Impact", "=ds=#sr# 145", "=ds="..AL["Trainer"]};
				{ 21, "s7745", "Spell_Holy_GreaterHeal", "=ds=Enchant 2H Weapon - Minor Impact", "=ds=#sr# 100", "=ds="..AL["Trainer"]};
				{ 23, 0, "INV_Box_01", "=q6="..AL["Spirit"], ""};
				{ 24, "s20035", "inv_enchant_formulagood_01", "=ds=Enchant 2H Weapon - Major Spirit", "=ds=#sr# 300", "=ds="..ALIL["Scholomance"]};
				{ 25, "s13380", "inv_enchant_formulagood_01", "=ds=Enchant 2H Weapon - Lesser Spirit", "=ds=#sr# 110", "=ds="..AL["World Drop"]};
				{ 27, 0, "INV_Box_01", "=q6="..AL["Other"], ""};
				{ 28, "s44595", "Spell_Holy_GreaterHeal", "=ds=Enchant 2H Weapon - Scourgebane", "=ds=#sr# 430", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 29, "s62948", "Spell_Holy_GreaterHeal", "=ds=Enchant Staff - Greater Spellpower", "=ds="};
				{ 30, "s62959", "Spell_Holy_GreaterHeal", "=ds=Enchant Staff - Spellpower", "=ds="};
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Enchant 2H Weapon"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingMisc"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..BabbleInventory["Companions"], ""};
				{ 2, "s93843", "67275", "=q3=Magic Lamp", "=ds=#sr# 525", "=ds="..AL["Vendor"]..", "..FACTION_ALLIANCE};
				{ 3, "s93841", "67274", "=q3=Enchanted Lantern", "=ds=#sr# 525", "=ds="..AL["Vendor"]..", "..FACTION_HORDE};
				{ 5, 0, "INV_Box_01", "=q6="..AL["Other"], ""};
				{ 6, "s116499", "74248", "=q4=Sha Crystal", "=ds=#sr# 600", "=ds="..AL["Trainer"]};
				{ 7, "s118239", "74247", "=q3=Sha Shatter", "=ds=#sr# 600", "=ds="..AL["Trainer"], amount = 2};
				{ 8, "s118238", "74250", "=q2=Ethereal Shatter", "=ds=#sr# 585", "=ds="..AL["Trainer"], amount = 3};
				{ 9, "s116498", "74247", "=q3=Ethereal Shard", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 10, "s118237", "74249", "=q1=Mysterious Diffusion", "=ds=#sr# 535", "=ds="..AL["Trainer"], amount = 3};
				{ 11, "s116497", "74250", "=q2=Mysterious Essence", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 12, "s104698", "52721", "=q3=Maelstrom Shatter", "=ds=#sr# 525", "=ds=", amount = 2};
				{ 13, "s69412", "49640", "=q2=Abyssal Shatter", "=ds=#sr# 445", "=ds="..AL["Trainer"]};
				{ 14, "s45765", "22449", "=q3=Void Shatter", "=ds=#sr# 360", "=ds="..AL["Vendor"]..": "..ALIL["Isle of Quel'Danas"], amount = 2};
				{ 15, "s28028", "22459", "=q4=Void Sphere", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 16, "s28022", "22449", "=q3=Large Prismatic Shard", "=ds=#sr# 335", "=ds="..AL["Vendor"]..": "..ALIL["Shattrath City"]};
				{ 17, "s42615", "22448", "=q3=Small Prismatic Shard", "=ds=#sr# 335", "=ds="..AL["Trainer"], amount = 3};
				{ 18, "s28027", "22460", "=q3=Prismatic Sphere", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 19, "s42613", "22448", "=q3=Nexus Transformation", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 20, "s15596", "11811", "=q3=Smoking Heart of the Mountain", "=ds=#sr# 265", "=ds="..AL["Drop"]..": "..AtlasLoot:EJ_GetBossName("Lord Roccor", 370)};
				{ 21, "s17181", "12810", "=q1=Enchanted Leather", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 22, "s17180", "12655", "=q1=Enchanted Thorium", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 23, "s7421", "6218", "=q1=Runed Copper Rod", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Oil"], ""};
				{ 2, "s28019", "22522", "=q1=Superior Wizard Oil", "=ds=#sr# 340", "=ds="..AL["Vendor"]..": "..ALIL["Shattrath City"]};
				{ 3, "s28016", "22521", "=q1=Superior Mana Oil", "=ds=#sr# 310", "=ds="..AL["Vendor"]..": "..ALIL["Shattrath City"]};
				{ 4, "s25128", "20750", "=q1=Wizard Oil", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Silithus"]};
				{ 5, "s25127", "20747", "=q1=Lesser Mana Oil", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Silithus"]};
				{ 6, "s25126", "20746", "=q1=Lesser Wizard Oil", "=ds=#sr# 200", "=ds="..AL["Vendor"]};
				{ 7, "s25125", "20745", "=q1=Minor Mana Oil", "=ds=#sr# 150", "=ds="..AL["Vendor"]};
				{ 8, "s25124", "20744", "=q1=Minor Wizard Oil", "=ds=#sr# 45", "=ds="..AL["Vendor"]};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleInventory["Wand"], ""};
				{ 17, "s14810", "11290", "=q2=Greater Mystic Wand", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 18, "s14809", "11289", "=q2=Lesser Mystic Wand", "=ds=#sr# 155", "=ds="..AL["Trainer"]};
				{ 19, "s14807", "11288", "=q2=Greater Magic Wand", "=ds=#sr# 70", "=ds="..AL["Trainer"]};
				{ 20, "s14293", "11287", "=q2=Lesser Magic Wand", "=ds=#sr# 10", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ENCHANTING..": "..BabbleInventory["Miscellaneous"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

	AtlasLoot_Data["EnchantingCataVendor"] = {
		["Normal"] = {
			{
				{ 1, 64411, "", "=q2=Formula: Enchant Boots - Assassin's Step", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 2, 64412, "", "=q2=Formula: Enchant Boots - Lavawalker", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 3, 52738, "", "=q2=Formula: Enchant Bracer - Greater Critical Strike", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 4, 64413, "", "=q2=Formula: Enchant Bracer - Greater Speed", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 5, 52740, "", "=q2=Formula: Enchant Chest - Greater Stamina", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 6, 52739, "", "=q2=Formula: Enchant Chest - Peerless Stats", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 7, 52737, "", "=q2=Formula: Enchant Cloak - Greater Critical Strike", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 8, 64414, "", "=q2=Formula: Enchant Gloves - Greater Mastery", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 9, 64415, "", "=q2=Formula: Enchant Gloves - Mighty Strength", "=ds=#p4# (525)", "5 #heavenlyshard#" };
				{ 10, 52736, "", "=q3=Formula: Enchant Weapon - Landslide", "=ds=#p4# (525)", "5 #maelstromcrystal#" };
				{ 11, 52733, "", "=q3=Formula: Enchant Weapon - Power Torrent", "=ds=#p4# (525)", "5 #maelstromcrystal#" };
				{ 12, 52735, "", "=q3=Formula: Enchant Weapon - Windwalk", "=ds=#p4# (525)", "5 #maelstromcrystal#" };
				{ 13, 67312, "", "=q3=Formula: Magic Lamp", "=ds=#p4# (525)", "20 #hypnoticdust#, =ds="..FACTION_ALLIANCE };
				{ 14, 67308, "", "=q3=Formula: Enchanted Lantern", "=ds=#p4# (525)", "20 #hypnoticdust#, =ds="..FACTION_HORDE };
			};
		};
		info = {
			name = ENCHANTING..": "..AL["Cataclysm Vendor Sold Formulas"],
			module = moduleName, menu = "ENCHANTINGMENU", instance = "Enchanting",
		};
	};

		-------------------
		--- Engineering ---
		-------------------

	AtlasLoot_Data["EngineeringArmorCloth"] = {
		["Normal"] = {
			{
				{ 1, "s127117", "77533", "=q4=Lightweight Retinal Armor", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 2, "s81725", "59449", "=q4=Lightweight Bio-Optic Killshades", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 3, "s56484", "42553", "=q4=Visage Liquification Goggles", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 4, "s46111", "34847", "=q4=Annihilator Holo-Gogs", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 5, "s30565", "23838", "=q4=Foreman's Enchanted Helmet", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 6, "s30574", "23828", "=q4=Gnomish Power Goggles", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 7, "s46108", "35181", "=q4=Powerheal 9000 Lens", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 8, "s41320", "32494", "=q4=Destruction Holo-Gogs", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 9, "s41321", "32495", "=q4=Powerheal 4000 Lens", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Cloth"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringArmorLeather"] = {
		["Normal"] = {
			{
				{ 1, "s127118", "77534", "=q4=Agile Retinal Armor", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 2, "s127119", "77535", "=q4=Camouflage Retinal Armor", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 3, "s81722", "59455", "=q4=Agile Bio-Optic Killshades", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 4, "s81724", "59453", "=q4=Camouflauge Bio-Optic Killshades", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 5, "s56486", "42554", "=q4=Greensight Gogs", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 6, "s56481", "42550", "=q4=Weakness Spectralizers", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 7, "s30575", "23829", "=q4=Gnomish Battle Goggles", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 8, "s46109", "35182", "=q4=Hyper-Magnified Moon Specs", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 9, "s46116", "34353", "=q4=Quad Deathblow X44 Goggles", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 10, "s46106", "35183", "=q4=Wonderheal XT68 Shades", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 11, "s41317", "32478", "=q4=Deathblow X11 Goggles", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 12, "s41319", "32480", "=q4=Magnified Moon Specs", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 13, "s41318", "32479", "=q4=Wonderheal XT40 Shades", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Leather"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringArmorMail"] = {
		["Normal"] = {
			{
				{ 1, "s127120", "77536", "=q4=Deadly Retinal Armor", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 2, "s127121", "77537", "=q4=Energized Retinal Armor", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 3, "s81716", "59456", "=q4=Deadly Bio-Optic Killshades", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 4, "s81720", "59458", "=q4=Energized Bio-Optic Killshades", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 5, "s56487", "42555", "=q4=Electroflux Sight Enhancers", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 6, "s56574", "42551", "=q4=Truesight Ice Blinders", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 7, "s30566", "23839", "=q4=Foreman's Reinforced Helmet", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 8, "s46112", "34355", "=q4=Lightning Etched Specs", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 9, "s46110", "35184", "=q4=Primal-Attuned Goggles", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 10, "s46113", "34356", "=q4=Surestrike Goggles v3.0", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 11, "s41315", "32476", "=q4=Gadgetstorm Goggles", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 12, "s41316", "32475", "=q4=Living Replicator Specs", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 13, "s41314", "32474", "=q4=Surestrike Goggles v2.0", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Mail"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringArmorPlate"] = {
		["Normal"] = {
			{
				{ 1, "s127123", "77539", "=q4=Reinforced Retinal Armor", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 2, "s127122", "77538", "=q4=Specialized Retinal Armor", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 3, "s81714", "59359", "=q4=Reinforced Bio-Optic Killshades", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 4, "s81715", "59448", "=q4=Specialized Bio-Optic Killshades", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 5, "s56480", "42549", "=q4=Armored Titanium Goggles", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 6, "s56483", "42552", "=q4=Charged Titanium Specs", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 7, "s62271", "44949", "=q4=Unbreakable Healing Amplifiers", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 8, "s46115", "34357", "=q4=Hard Khorium Goggles", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 9, "s46107", "35185", "=q4=Justicebringer 3000 Specs", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 10, "s46114", "34354", "=q4=Mayhem Projection Goggles", "=ds=#sr# 375", "=ds="..ALIL["Sunwell Plateau"] };
				{ 11, "s40274", "32461", "=q4=Furious Gizmatic Goggles", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 12, "s41312", "32473", "=q4=Tankatronic Goggles", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Plate"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringArmorTrinket"] = {
		["Normal"] = {
			{
				{ 1, "s127134", "77530", "=q3=Ghost Iron Dragonling", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 2, "s95705", "40727", "=q3=Gnomish Gravity Well", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 3, "s84418", "60403", "=q3=Elementium Dragonling", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 4, "s56469", "41121", "=q3=Gnomish Lightning Generator", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 5, "s56467", "40865", "=q3=Noise Machine", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 6, "s56466", "40767", "=q3=Sonic Booster", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 7, "s30563", "23836", "=q3=Goblin Rocket Launcher", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 8, "s30569", "23835", "=q3=Gnomish Poultryizer", "=ds=#sr# 340", "=ds="..AL["Trainer"] };
				{ 9, "s19830", "16022", "=q3=Arcanite Dragonling", "=ds=#sr# 300", "=ds="..AL["Vendor"] };
				{ 10, "s23082", "18639", "=q3=Ultra-Flash Shadow Reflector", "=ds=#sr# 300", "=ds="..ALIL["Stratholme"] };
				{ 11, "s23081", "18638", "=q3=Hyper-Radiant Flame Reflector", "=ds=#sr# 290", "=ds="..ALIL["Blackrock Spire"] };
				{ 12, "s23079", "18637", "=q2=Major Recombobulator", "=ds=#sr# 275", "=ds="..ALIL["Dire Maul"] };
				{ 13, "s63750", "45631", "=q3=High-powered Flashlight", "=ds=#sr# 270", "=ds="..AL["Vendor"] };
				{ 14, "s23077", "18634", "=q3=Gyrofreeze Ice Reflector", "=ds=#sr# 260", "=ds="..AL["Vendor"] };
				{ 15, "s12624", "10576", "=q2=Mithril Mechanical Dragonling", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 16, "s12759", "10645", "=q1=Gnomish Death Ray", "=ds=#sr# 240", "=ds="..AL["Trainer"] };
				{ 17, "s12908", "10727", "=q1=Goblin Dragon Gun", "=ds=#sr# 240", "=ds="..AL["Trainer"] };
				{ 18, "s12906", "10725", "=q1=Gnomish Battle Chicken", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
				{ 19, "s12755", "10587", "=q1=Goblin Bomb Dispenser", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
				{ 20, "s12899", "10716", "=q2=Gnomish Shrink Ray", "=ds=#sr# 205", "=ds="..AL["Trainer"] };
				{ 21, "s12716", "10577", "=q2=Goblin Mortar", "=ds=#sr# 205", "=ds="..AL["Trainer"] };
				{ 22, "s3971", "4397", "=q2=Gnomish Cloaking Device", "=ds=#sr# 200", "=ds="..AL["Vendor"] };
				{ 23, "s3969", "4396", "=q2=Mechanical Dragonling", "=ds=#sr# 200", "=ds="..AL["Vendor"] };
				{ 24, "s3952", "4381", "=q2=Minor Recombobulator", "=ds=#sr# 140", "=ds="..AL["Vendor"] };
				{ 25, "s9269", "7506", "=q2=Gnomish Universal Remote", "=ds=#sr# 125", "=ds="..ALIL["Gnomeregan"] };
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Trinket"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringArmor"] = {
		["Normal"] = {
			{
				{ 1, "", "81143", "=q3=Advanced Deepdive Helmet", "=ds=#sr# ?", "=ds="..AL["Trainer"]};
				{ 2, "s127130", "87213", "=q2=Mist-Piercing Goggles", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 3, "s56473", "40895", "=q3=Gnomish X-Ray Specs", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 4, "s61483", "44742", "=q3=Mechanized Snow Goggles", "=ds=#sr# 420", "=ds="..AL["Trainer"]};
				{ 5, "s30325", "23763", "=q3=Hyper-Vision Goggles", "=ds=#sr# 360", "=ds="..AL["Drop"]};
				{ 6, "s30556", "23824", "=q3=Rocket Boots Xtreme", "=ds=#sr# 355", "=ds="..ALIL["The Steamvault"]};
				{ 7, "s46697", "35581", "=q3=Rocket Boots Xtreme Lite", "=ds=#sr# 355", "=ds="..ALIL["The Mechanar"]};
				{ 8, "s30570", "23825", "=q3=Nigh-Invulnerability Belt", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 9, "s30318", "23762", "=q3=Ultra-Spectropic Detection Goggles", "=ds=#sr# 350", "=ds="..AL["Vendor"]};
				{ 10, "s30316", "23758", "=q3=Cogspinner Goggles", "=ds=#sr# 340", "=ds="..AL["Vendor"]};
				{ 11, "s30317", "23761", "=q3=Power Amplification Goggles", "=ds=#sr# 340", "=ds="..AL["World Drop"]};
				{ 12, "s22797", "18168", "=q4=Force Reactive Disk", "=ds=#sr# 300", "=ds="..ALIL["Molten Core"]};
				{ 13, "s24356", "19999", "=q3=Bloodvine Goggles", "=ds=#sr# 300", "=ds="..AL["No Longer Available"]};
				{ 14, "s24357", "19998", "=q3=Bloodvine Lens", "=ds=#sr# 300", "=ds="..AL["No Longer Available"]};
				{ 15, "s19825", "16008", "=q2=Master Engineer's Goggles", "=ds=#sr# 290", "=ds="..AL["Trainer"]};
				{ 16, "s19819", "16009", "=q2=Voice Amplification Modulator", "=ds=#sr# 290", "=ds="..ALIL["Stratholme"]};
				{ 17, "s19794", "15999", "=q2=Spellpower Goggles Xtreme Plus", "=ds=#sr# 270", "=ds="..AL["Trainer"]};
				{ 18, "s12622", "10504", "=q3=Green Lens", "=ds=#sr# 245", "=ds="..AL["Trainer"]};
				{ 19, "s12758", "10588", "=q2=Goblin Rocket Helmet", "=ds=#sr# 245", "=ds="..AL["Trainer"]};
				{ 20, "s12907", "10726", "=q2=Gnomish Mind Control Cap", "=ds=#sr# 235", "=ds="..AL["Trainer"]};
				{ 21, "s12617", "10506", "=q2=Deepdive Helmet", "=ds=#sr# 230", "=ds=???"}; --recipe removed with Cata
				{ 22, "s12618", "10503", "=q2=Rose Colored Goggles", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 23, "s12905", "10724", "=q2=Gnomish Rocket Boots", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 24, "s8895", "7189", "=q2=Goblin Rocket Boots", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 25, "s12616", "10518", "=q2=Parachute Cloak", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 26, "s12615", "10502", "=q2=Spellpower Goggles Xtreme", "=ds=#sr# 225"};
				{ 27, "s12607", "10501", "=q2=Catseye Ultra Goggles", "=ds=#sr# 220", "=ds="..AL["World Drop"]};
				{ 28, "s12903", "10721", "=q2=Gnomish Harm Prevention Belt", "=ds=#sr# 215", "=ds="..AL["Trainer"]};
				{ 29, "s12897", "10545", "=q2=Gnomish Goggles", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 30, "s12594", "10500", "=q2=Fire Goggles", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s12718", "10543", "=q2=Goblin Construction Helmet", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 2, "s12717", "10542", "=q2=Goblin Mining Helmet", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 3, "s3966", "4393", "=q2=Craftsman's Monocle", "=ds=#sr# 185", "=ds="..AL["World Drop"]};
				{ 4, "s12587", "10499", "=q2=Bright-Eye Goggles", "=ds=#sr# 175", "=ds="..AL["World Drop"]};
				{ 5, "s3956", "4385", "=q2=Green Tinted Goggles", "=ds=#sr# 150", "=ds="..AL["Trainer"]};
				{ 6, "s3940", "4373", "=q2=Shadow Goggles", "=ds=#sr# 120", "=ds="..AL["World Drop"]};
				{ 7, "s3934", "4368", "=q2=Flying Tiger Goggles", "=ds=#sr# 100", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Armor"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringExplosives"] = {
		["Normal"] = {
			{
				{ 1, "s127128", "86607", "=q1=Goblin Flame Thrower, Mark II", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 2, "s127127", "77589", "=q1=G91 Landshark", "=ds=#sr# 525", "=ds="..AL["Trainer"], amount = 3 };
				{ 3, "s127124", "77532", "=q1=Locksmith's Powderkeg", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 4, "s95707", "63396", "=q1=Big Daddy", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 5, "s84409", "60853", "=q1=Volatile Seaforium Blastpack", "=ds=#sr# 455", "=ds="..AL["Trainer"] };
				{ 6, "s56514", "42641", "=q1=Global Thermal Sapper Charge", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 7, "s56468", "44951", "=q1=Box of Bombs", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 8, "s56463", "40536", "=q1=Explosive Decoy", "=ds=#sr# 375", "=ds="..AL["Trainer"], amount = 5 };
				{ 9, "s56460", "40771", "=q1=Cobalt Frag Bomb", "=ds=#sr# 350", "=ds="..AL["Trainer"], amount = 3 };
				{ 10, "s30547", "23819", "=q1=Elemental Seaforium Charge", "=ds=#sr# 350", "=ds="..ALIL["The Consortium"].." - "..AL["Revered"], amount = 2 };
				{ 11, "s30560", "23827", "=q1=Super Sapper Charge", "=ds=#sr# 340", "=ds="..AL["Trainer"], amount = 2 };
				{ 12, "s39973", "32413", "=q1=Frost Grenade", "=ds=#sr# 335", "=ds="..AL["Trainer"], amount = 5 };
				{ 13, "s30311", "23737", "=q1=Adamantite Grenade", "=ds=#sr# 325", "=ds="..AL["Trainer"], amount = 3 };
				{ 14, "s30558", "23826", "=q1=The Bigger One", "=ds=#sr# 325", "=ds="..AL["Trainer"], amount = 3 };
				{ 15, "s19831", "16040", "=q1=Arcane Bomb", "=ds=#sr# 300", "=ds="..AL["World Drop"], amount = 3 };
				{ 16, "s30310", "23736", "=q1=Fel Iron Bomb", "=ds=#sr# 300", "=ds="..AL["Trainer"], amount = 4 };
				{ 17, "s19799", "16005", "=q1=Dark Iron Bomb", "=ds=#sr# 285", "=ds="..ALIL["Blackrock Depths"], amount = 3 };
				{ 18, "s23080", "18594", "=q1=Powerful Seaforium Charge", "=ds=#sr# 275", "=ds="..AL["Vendor"] };
				{ 19, "s19790", "15993", "=q1=Thorium Grenade", "=ds=#sr# 260", "=ds="..AL["Trainer"], amount = 3 };
				{ 20, "s23070", "18641", "=q1=Dense Dynamite", "=ds=#sr# 250", "=ds="..AL["Trainer"], amount = 2 };
				{ 21, "s12619", "10562", "=q1=Hi-Explosive Bomb", "=ds=#sr# 235", "=ds="..AL["Trainer"], amount = 4 };
				{ 22, "s12754", "10586", "=q1=The Big One", "=ds=#sr# 235", "=ds="..AL["Trainer"], amount = 2 };
				{ 23, "s12603", "10514", "=q1=Mithril Frag Bomb", "=ds=#sr# 215", "=ds="..AL["Trainer"], amount = 3 };
				{ 24, "s12760", "10646", "=q1=Goblin Sapper Charge", "=ds=#sr# 205", "=ds="..AL["Trainer"] };
				{ 25, "s13240", "10577", "=q2=The Mortar: Reloaded", "=ds=#sr# 205", "=ds="..AL["Trainer"] };
				{ 26, "s23069", "18588", "=q1=Ez-Thro Dynamite II", "=ds=#sr# 200", "=ds="..AL["Vendor"] };
				{ 27, "s3972", "4398", "=q1=Large Seaforium Charge", "=ds=#sr# 200", "=ds="..AL["World Drop"] };
				{ 28, "s3968", "4395", "=q1=Goblin Land Mine", "=ds=#sr# 195", "=ds="..AL["World Drop"] };
				{ 29, "s3967", "4394", "=q1=Big Iron Bomb", "=ds=#sr# 190", "=ds="..AL["Trainer"], amount = 2 };
				{ 30, "s8243", "4852", "=q1=Flash Bomb", "=ds=#sr# 185", "=ds="..ALIL["Gnomeregan"] };
			};
			{
				{ 1, "s3962", "4390", "=q1=Iron Grenade", "=ds=#sr# 175", "=ds="..AL["Trainer"], amount = "2-4" };
				{ 2, "s12586", "10507", "=q1=Solid Dynamite", "=ds=#sr# 175", "=ds="..AL["Trainer"], amount = 2 };
				{ 3, "s3960", "4403", "=q1=Portable Bronze Mortar", "=ds=#sr# 165", "=ds="..AL["World Drop"] };
				{ 4, "s3955", "4384", "=q1=Explosive Sheep", "=ds=#sr# 150", "=ds="..AL["Trainer"]};
				{ 5, "s3950", "4380", "=q1=Big Bronze Bomb", "=ds=#sr# 140", "=ds="..AL["Trainer"], amount = "2-4" };
				{ 6, "s3946", "4378", "=q1=Heavy Dynamite", "=ds=#sr# 125", "=ds="..AL["Trainer"], amount = "1-5" };
				{ 7, "s3941", "4374", "=q1=Small Bronze Bomb", "=ds=#sr# 120", "=ds="..AL["Trainer"], amount = "1-3" };
				{ 8, "s3937", "4370", "=q1=Large Copper Bomb", "=ds=#sr# 105", "=ds="..AL["Trainer"], amount = "2-4" };
				{ 9, "s8339", "6714", "=q1=Ez-Thro Dynamite", "=ds=#sr# 100", "=ds="..AL["World Drop"], amount = "1-3" };
				{ 10, "s3933", "4367", "=q1=Small Seaforium Charge", "=ds=#sr# 100", "=ds="..AL["World Drop"] };
				{ 11, "s3931", "4365", "=q1=Coarse Dynamite", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 12, "s3923", "4360", "=q1=Rough Copper Bomb", "=ds=#sr# 30", "=ds="..AL["Trainer"] };
				{ 13, "s3919", "4358", "=q1=Rough Dynamite", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Explosives"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringScope"] = {
		["Normal"] = {
			{
				{ 1, "s127115", "77529", "=q3=Lord Blastington's Scope of Doom", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 2, "s127116", "77531", "=q3=Mirror Scope", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 4, "s100587", "70139", "=q3=Flintlocke's Woodchucker", "=ds=#sr# 515", "=ds="..ALIL["Molten Front"]};
				{ 5, "s84428", "59594", "=q3=Gnomish X-Ray Scope", "=ds=#sr# 515", "=ds="..AL["Trainer"] };
				{ 6, "s84410", "59596", "=q3=Safety Catch Removal Kit", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 7, "s84408", "59595", "=q3=R19 Threatfinder", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 9, "s56478", "41167", "=q3=Heartseeker Scope", "=ds=#sr# 430", "=ds="..AL["Trainer"] };
				{ 10, "s56470", "41146", "=q3=Sun Scope", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 11, "s61471", "44739", "=q1=Diamond-Cut Refractor Scope", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
				{ 16, "s30334", "23766", "=q3=Stabilized Eternium Scope", "=ds=#sr# 375", "=ds="..ALIL["Karazhan"] };
				{ 17, "s30332", "23765", "=q3=Khorium Scope", "=ds=#sr# 360", "=ds="..ALIL["Netherstorm"] };
				{ 18, "s30329", "23764", "=q2=Adamantite Scope", "=ds=#sr# 335", "=ds="..AL["Vendor"] };
				{ 20, "s22793", "18283", "=q3=Biznicks 247x128 Accurascope", "=ds=#sr# 300", "=ds="..ALIL["Molten Core"] };
				{ 21, "s12620", "10548", "=q1=Sniper Scope", "=ds=#sr# 240", "=ds="..AL["World Drop"] };
				{ 22, "s12597", "10546", "=q1=Deadly Scope", "=ds=#sr# 210", "=ds="..AL["Vendor"] };
				{ 23, "s3979", "4407", "=q2=Accurate Scope", "=ds=#sr# 180", "=ds="..AL["Vendor"] };
				{ 24, "s3978", "4406", "=q1=Standard Scope", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 25, "s3977", "4405", "=q1=Crude Scope", "=ds=#sr# 60", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = ENGINEERING..": "..AL["Scope"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringTinker"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#s4#", "" };
				{ 2, "s126392", "Trade_Engineering", "=ds=Goblin Glider", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 3, "s55002", "Trade_Engineering", "=ds=Flexweave Underlay", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
				{ 5, 0, "INV_Box_01", "=q6=#s10#", "" };
				{ 6, "s109099", "Trade_Engineering", "=ds=Watergliding Jets", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 7, "s84424", "Trade_Engineering", "=ds=Invisibility Field", "=ds=#sr# 450+", "=ds="..AL["Discovery"] };
				{ 8, "s84425", "Trade_Engineering", "=ds=Cardboard Assassin", "=ds=#sr# 450+", "=ds="..AL["Discovery"] };
				{ 9, "s84427", "Trade_Engineering", "=ds=Grounded Plasma Shield", "=ds=#sr# 450+", "=ds="..AL["Discovery"] };
				{ 10, "s55016", "Trade_Engineering", "=ds=Nitro Boosts", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 11, "s67839", "Trade_Engineering", "=ds=Mind Amplification Dish", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
				{ 12, "s54736", "Trade_Engineering", "=ds=Personal Electromagnetic Pulse Generator", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
				{ 13, "s54793", "Trade_Engineering", "=ds=Frag Belt", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
				{ 16, 0, "INV_Box_01", "=q6=#s9#", "" };
				{ 17, "s109077", "Trade_Engineering", "=ds=Incendiary Fireworks Launcher", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 18, "s108789", "Trade_Engineering", "=ds=Phase Fingers", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 19, "s126731", "Trade_Engineering", "=ds=Synapse Springs", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 20, "s82177", "Trade_Engineering", "=ds=Quickflip Deflection Plates", "=ds=#sr# 450+", "=ds="..AL["Discovery"] };
				{ 21, "s82200", "Trade_Engineering", "=ds=Spinal Healing Injector", "=ds=#sr# 450+", "=ds="..AL["Discovery"] };
				{ 22, "s82175", "Trade_Engineering", "=ds=Synapse Springs", "=ds=#sr# 450+", "=ds="..AL["Discovery"] };
				{ 23, "s82180", "Trade_Engineering", "=ds=Tazik Shocker", "=ds=#sr# 450+", "=ds="..AL["Discovery"] };
				{ 24, "s82186", "Trade_Engineering", "=ds=Z50 Mana Gulper", "=ds=#sr# 450+", "=ds="..AL["Discovery"] };
				{ 25, "s54998", "Trade_Engineering", "=ds=Hand-Mounted Pyro Rocket", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 26, "s54999", "Trade_Engineering", "=ds=Hyperspeed Accelerators", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 27, "s63770", "Trade_Engineering", "=ds=Reticulated Armor Webbing", "=ds=#sr# 400", "=ds="..AL["Trainer"] };

			};
		};
		info = {
			name = ENGINEERING..": "..AL["Tinker"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringMisc"] = {
		["Normal"] = {
			{
				{ 1, "s127129", "87214", "=q4=Blingtron 4000", "=ds=#sr# 600", "=ds="..AL["Trainer"]};
				{ 2, "s139197", "92747", "=q3=Advanced Refrigeration Unit", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 3, "s127132", "87215", "=q3=Wormhole Generator: Pandaria", "=ds=#sr# 570", "=ds="..AL["Trainer"]};
				{ 4, "s127131", "87216", "=q1=Thermal Anvil", "=ds=#sr# 550", "=ds="..AL["Trainer"]};
				{ 5, "s84430", "68049", "=q1=Heat-Treated Spinning Lure", "=ds=#sr# 510", "=ds="..AL["Trainer"], amount = 2};
				{ 6, "s84429", "60858", "=q3=Goblin Barbecue", "=ds=#sr# 505", "=ds="..AL["Trainer"]};
				{ 7, "s84421", "60854", "=q3=Loot-a-Rang", "=ds=#sr# 490", "=ds="..AL["Trainer"]};
				{ 8, "s84416", "60217", "=q3=Elementium Toolbox", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 9, "s84415", "60218", "=q3=Lure Master Tackle Box", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 10, "s84411", "60223", "=q3=High-Powered Bolt Gun", "=ds=#sr# 465", "=ds="..AL["Trainer"]};
				{ 11, "s68067", "49040", "=q4=Jeeves", "=ds=#sr# 450", "=ds="..AL["Drop"]};
				{ 12, "s95703", "67494", "=q3=Electrostatic Condenser", "=ds=#sr# 440", "=ds="..AL["Trainer"]};
				{ 13, "s56462", "40772", "=q1=Gnomish Army Knife", "=ds=#sr# 435", "=ds="..AL["Trainer"]};
				{ 14, "s56472", "40768", "=q3=MOLL-E", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 15, "s56477", "42546", "=q1=Mana Injector Kit", "=ds=#sr# 415", "=ds="..AL["Trainer"], amount = 8};
				{ 16, "s55252", "40769", "=q1=Scrapbot Construction Kit", "=ds=#sr# 415", "=ds=#QUESTID:12889#", amount = 5};
				{ 17, "s67920", "48933", "=q3=Wormhole Generator: Northrend", "=ds=#sr# 415", "=ds="..AL["Trainer"]};
				{ 18, "s56476", "37567", "=q1=Healing Injector Kit", "=ds=#sr# 410", "=ds="..AL["Trainer"], amount = 8};
				{ 19, "s30349", "23775", "=q3=Titanium Toolbox", "=ds=#sr# 405", "=ds="..AL["Drop"]};
				{ 20, "s67326", "47828", "=q1=Goblin Beam Welder", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 21, "s56461", "40893", "=q1=Bladed Pickaxe", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 22, "s56459", "40892", "=q1=Hammer Pick", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 23, "s44391", "34113", "=q1=Field Repair Bot 110G", "=ds=#sr# 360", "=ds="..AL["Drop"], amount = 5};
				{ 24, "s36954", "30542", "=q2=Dimensional Ripper - Area 52", "=ds=#sr# 350"};
				{ 25, "s36955", "30544", "=q2=Ultrasafe Transporter - Toshley's Station", "=ds=#sr# 350"};
				{ 26, "s30552", "33093", "=q1=Mana Potion Injector", "=ds=#sr# 345", "=ds="..AL["Drop"], amount = 20};
				{ 27, "s30551", "33092", "=q1=Healing Potion Injector", "=ds=#sr# 330", "=ds="..AL["Drop"], amount = 20};
				{ 28, "s30337", "23767", "=q2=Crashin' Thrashin' Robot", "=ds=#sr# 325", "=ds="..AL["Drop"]};
				{ 29, "s30348", "23774", "=q2=Fel Iron Toolbox", "=ds=#sr# 325", "=ds="..AL["Vendor"]};
				{ 30, "s30568", "23841", "=q1=Gnomish Flame Turret", "=ds=#sr# 325", "=ds="..AL["Trainer"], amount = 3};
			};
			{
				{ 1, "s30548", "23821", "=q1=Zapthrottle Mote Extractor", "=ds=#sr# 305", "=ds="..BabbleInventory["Quest"]};
				{ 2, "s22704", "18232", "=q1=Field Repair Bot 74A", "=ds=#sr# 300", "=ds="..ALIL["Blackrock Depths"]};
				{ 3, "s19814", "16023", "=q1=Masterwork Target Dummy", "=ds=#sr# 275", "=ds="..AL["Vendor"]};
				{ 4, "s28327", "22728", "=q1=Steam Tonk Controller", "=ds=#sr# 275", "=ds="..ALIL["Darkmoon Faire"]};
				{ 5, "s23096", "18645", "=q2=Gnomish Alarm-O-Bot", "=ds=#sr# 265", "=ds="..ALIL["Blackrock Depths"], amount = 2};
				{ 6, "s23078", "18587", "=q1=Goblin Jumper Cables XL", "=ds=#sr# 265", "=ds="..ALIL["Blackrock Depths"]};
				{ 7, "s23129", "18660", "=q2=World Enlarger", "=ds=#sr# 260", "=ds="..AL["Drop"]};
				{ 8, "s19567", "15846", "=q1=Salt Shaker", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 9, "s12902", "10720", "=q1=Gnomish Net-o-Matic Projector", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 10, "s12715", "10644", "=q1=Recipe: Goblin Rocket Fuel", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 11, "s12895", "10713", "=q1=Plans: Inlaid Mithril Cylinder", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 12, "s15255", "11590", "=q1=Mechanical Repair Kit", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 13, "s21940", "17716", "=q1=Snowmaster 9000", "=ds=#sr# 190", "=ds="..AL["Feast of Winter Veil"]};
				{ 14, "s3965", "4392", "=q1=Advanced Target Dummy", "=ds=#sr# 185", "=ds="..AL["Trainer"]};
				{ 15, "s3963", "4391", "=q1=Compact Harvest Reaper Kit", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 16, "s9273", "7148", "=q1=Goblin Jumper Cables", "=ds=#sr# 165", "=ds="..AL["Vendor"]};
				{ 17, "s3959", "4388", "=q1=Discombobulator Ray", "=ds=#sr# 160", "=ds="..ALIL["Gnomeregan"]};
				{ 18, "s3957", "4386", "=q1=Ice Deflector", "=ds=#sr# 155", "=ds=???"}; --schematic removed with Cata
				{ 19, "s9271", "6533", "=q1=Aquadynamic Fish Attractor", "=ds=#sr# 150", "=ds="..AL["Trainer"], amount = 3};
				{ 20, "s6458", "5507", "=q1=Ornate Spyglass", "=ds=#sr# 135", "=ds="..AL["Trainer"]};
				{ 21, "s3944", "4376", "=q1=Flame Deflector", "=ds=#sr# 125", "=ds="..ALIL["Gnomeregan"]};
				{ 22, "s8334", "6712", "=q1=Practice Lock", "=ds=#sr# 100", "=ds="..AL["Trainer"]};
				{ 23, "s3932", "4366", "=q1=Target Dummy", "=ds=#sr# 85", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Miscellaneous"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringReagents"] = {
		["Normal"] = {
			{
				{ 1, "s139176", "94113", "=q3=Jard's Peculiar Energy Source", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 2, "s131563", "90146", "=q1=Tinker's Kit", "=ds=#sr# 550", "=ds="..AL["Trainer"], amount = 2};
				{ 3, "s127113", "77467", "=q1=Ghost Iron Bolts", "=ds=#sr# 500", "=ds="..AL["Trainer"], amount = 2};
				{ 4, "s127114", "77468", "=q1=High-Explosive Gunpowder", "=ds=#sr# 500", "=ds="..AL["Trainer"], amount = 2};
				{ 5, "s94748", "67749", "=q1=Electrified Ether", "=ds=#sr# 445", "=ds="..AL["Trainer"], amount = "2-3"};
				{ 6, "s84403", "60224", "=q1=Handful of Obsidium Bolts", "=ds=#sr# 425", "=ds="..AL["Trainer"], amount = "2-4"};
				{ 7, "s56471", "39683", "=q1=Froststeel Tube", "=ds=#sr# 390", "=ds="..AL["Trainer"]};
				{ 8, "s56464", "39682", "=q1=Overcharged Capacitor", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 9, "s56349", "39681", "=q1=Handful of Cobalt Bolts", "=ds=#sr# 350", "=ds="..AL["Trainer"], amount = "1-3"};
				{ 10, "s53281", "39690", "=q1=Volatile Blasting Trigger", "=ds=#sr# 350", "=ds="..AL["Trainer"], amount = 2};
				{ 11, "s30309", "23787", "=q1=Felsteel Stabilizer", "=ds=#sr# 340", "=ds="..AL["Trainer"]};
				{ 12, "s30307", "23785", "=q1=Hardened Adamantite Tube", "=ds=#sr# 340", "=ds="..AL["Trainer"]};
				{ 13, "s30308", "23786", "=q1=Khorium Power Core", "=ds=#sr# 340", "=ds="..AL["Trainer"]};
				{ 14, "s39971", "32423", "=q1=Icy Blasting Primers", "=ds=#sr# 335", "=ds="..AL["Trainer"], amount = 10};
				{ 15, "s30306", "23784", "=q1=Adamantite Frame", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 16, "s30305", "23783", "=q1=Handful of Fel Iron Bolts", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 17, "s30303", "23781", "=q1=Elemental Blasting Powder", "=ds=#sr# 300", "=ds="..AL["Trainer"], amount = 4};
				{ 18, "s30304", "23782", "=q1=Fel Iron Casing", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
				{ 19, "s19815", "16006", "=q1=Delicate Arcanite Converter", "=ds=#sr# 285", "=ds="..AL["Vendor"]};
				{ 20, "s19795", "16000", "=q1=Thorium Tube", "=ds=#sr# 275", "=ds="..AL["Trainer"]};
				{ 21, "s39895", "7191", "=q1=Fused Wiring", "=ds=#sr# 275", "=ds="..AL["Vendor"], amount = 5};
				{ 22, "s19791", "15994", "=q1=Thorium Widget", "=ds=#sr# 260", "=ds="..AL["Trainer"]};
				{ 23, "s23071", "18631", "=q1=Truesilver Transformer", "=ds=#sr# 260", "=ds="..AL["Trainer"]};
				{ 24, "s19788", "15992", "=q1=Dense Blasting Powder", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 25, "s12599", "10561", "=q1=Mithril Casing", "=ds=#sr# 215", "=ds="..AL["Trainer"]};
				{ 26, "s12591", "10560", "=q1=Unstable Trigger", "=ds=#sr# 200", "=ds="..AL["Trainer"]};
				{ 27, "s12589", "10559", "=q1=Mithril Tube", "=ds=#sr# 195", "=ds="..AL["Trainer"]};
				{ 28, "s12590", "10498", "=q1=Gyromatic Micro-Adjustor", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 29, "s12585", "10505", "=q1=Solid Blasting Powder", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 30, "s3961", "4389", "=q1=Gyrochronatom", "=ds=#sr# 170", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s3958", "4387", "=q1=Iron Strut", "=ds=#sr# 160", "=ds="..AL["Trainer"]};
				{ 2, "s12584", "10558", "=q1=Gold Power Core", "=ds=#sr# 150", "=ds="..AL["Trainer"], amount = 3};
				{ 3, "s3953", "4382", "=q1=Bronze Framework", "=ds=#sr# 145", "=ds="..AL["Trainer"]};
				{ 4, "s3942", "4375", "=q1=Whirring Bronze Gizmo", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 5, "s3945", "4377", "=q1=Heavy Blasting Powder", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 6, "s3938", "4371", "=q1=Bronze Tube", "=ds=#sr# 105", "=ds="..AL["Trainer"] };
				{ 7, "s3973", "4404", "=q1=Silver Contact", "=ds=#sr# 90", "=ds="..AL["Trainer"] };
				{ 8, "s3929", "4364", "=q1=Coarse Blasting Powder", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 9, "s3924", "4361", "=q1=Copper Tube", "=ds=#sr# 50", "=ds="..AL["Trainer"] };
				{ 10, "s3922", "4359", "=q1=Handful of Copper Bolts", "=ds=#sr# 30", "=ds="..AL["Trainer"] };
				{ 11, "s3918", "4357", "=q1=Rough Blasting Powder", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = ENGINEERING..": "..AL["Reagents"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringWeapon"] = {
		["Normal"] = {
			{
				{ 1, "s127137", "77528", "=q3=Long-Range Trillium Sniper", "=ds=#sr# 565", "=ds="..AL["Trainer"]};
				{ 2, "s127136", "77527", "=q3=Big Game Hunter", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 3, "s100687", "71077", "=q4=Extreme-Impact Hole Puncher", "=ds=#sr# 525", "=ds="..ALIL["Molten Front"]};
				{ 4, "s84431", "59364", "=q3=Overpowered Chicken Splitter", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 5, "s84432", "59367", "=q3=Kickback 5000", "=ds=#sr# 525", "=ds="..AL["Trainer"]};
				{ 6, "s84417", "59599", "=q3=Volatile Thunderstick", "=ds=#sr# 495", "=ds="..AL["Trainer"]};
				{ 7, "s84420", "59598", "=q3=Finely-Tuned Throat Needler", "=ds=#sr# 490", "=ds="..AL["Trainer"]};
				{ 8, "s56479", "41168", "=q4=Armor Plated Combat Shotgun", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 9, "s60874", "44504", "=q4=Nesingwary 4000", "=ds=#sr# 450", "=ds="..AL["Trainer"]};
				{ 10, "s54353", "39688", "=q3=Mark \"S\" Boomstick", "=ds=#sr# 400", "=ds="..AL["Trainer"]};
				{ 11, "s41307", "32756", "=q4=Gyro-Balanced Khorium Destroyer", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 12, "s30315", "23748", "=q3=Ornate Khorium Rifle", "=ds=#sr# 375", "=ds="..AL["World Drop"]};
				{ 13, "s30314", "23747", "=q3=Felsteel Boomstick", "=ds=#sr# 360", "=ds="..AL["Drop"]};
				{ 14, "s30313", "23746", "=q2=Adamantite Rifle", "=ds=#sr# 350", "=ds="..AL["Vendor"]};
				{ 15, "s30312", "23742", "=q2=Fel Iron Musket", "=ds=#sr# 320", "=ds="..AL["Trainer"]};
				{ 16, "s22795", "18282", "=q4=Core Marksman Rifle", "=ds=#sr# 300", "=ds="..ALIL["Molten Core"]};
				{ 17, "s19833", "16007", "=q3=Flawless Arcanite Rifle", "=ds=#sr# 300", "=ds="..ALIL["Eastern Plaguelands"]};
				{ 18, "s19796", "16004", "=q3=Dark Iron Rifle", "=ds=#sr# 275", "=ds="..ALIL["Blackrock Depths"]};
				{ 19, "s19792", "15995", "=q2=Thorium Rifle", "=ds=#sr# 260", "=ds="..AL["Trainer"]};
				{ 20, "s12614", "10510", "=q2=Mithril Heavy-Bore Rifle", "=ds=#sr# 220", "=ds="..AL["World Drop"]};
				{ 21, "s12595", "10508", "=q2=Mithril Blunderbuss", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 22, "s3954", "4383", "=q2=Moonsight Rifle", "=ds=#sr# 145", "=ds="..AL["World Drop"]};
				{ 23, "s3949", "4379", "=q2=Silver-Plated Shotgun", "=ds=#sr# 130", "=ds="..AL["Trainer"]};
				{ 24, "s3939", "4372", "=q2=Lovingly Crafted Boomstick", "=ds=#sr# 120", "=ds="..ALIL["Thousand Needles"]};
				{ 25, "s3936", "4369", "=q2=Deadly Blunderbuss", "=ds=#sr# 105", "=ds="..AL["Trainer"]};
				{ 26, "s3925", "4362", "=q2=Rough Boomstick", "=ds=#sr# 50", "=ds="..AL["Trainer"]};
				{ 27, "s7430", "6219", "=q1=Arclight Spanner", "=ds=#sr# 50", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Weapon"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["Gnomish"] = {
		["Normal"] = {
			{
				{ 1, "s127139", "87251", "=q3=Geosynchronous World Spinner", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 2, "s95705", "40727", "=q3=Gnomish Gravity Well", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 3, "s84413", "60216", "=q3=De-Weaponized Mechanical Companion", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 4, "s56473", "40895", "=q3=Gnomish X-Ray Specs", "=ds=#sr# 425", "=ds="..AL["Trainer"]};
				{ 5, "s30575", "23829", "=q4=Gnomish Battle Goggles", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 6, "s30574", "23828", "=q4=Gnomish Power Goggles", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 7, "s30570", "23825", "=q3=Nigh-Invulnerability Belt", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 8, "s36955", "30544", "=q2=Ultrasafe Transporter - Toshley's Station", "=ds=#sr# 350"};
				{ 9, "s30569", "23835", "=q3=Gnomish Poultryizer", "=ds=#sr# 340", "=ds="..AL["Trainer"]};
				{ 10, "s30568", "23841", "=q1=Gnomish Flame Turret", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 11, "s23096", "18645", "=q2=Gnomish Alarm-O-Bot", "=ds=#sr# 265", "=ds="..ALIL["Blackrock Depths"]};
				{ 12, "s23489", "18986", "=q2=Ultrasafe Transporter - Gadgetzan", "=ds=#sr# 260"};
				{ 13, "s23129", "18660", "=q2=World Enlarger", "=ds=#sr# 260", "=ds="..ALIL["Blackrock Depths"]};
				{ 14, "s12759", "10645", "=q1=Gnomish Death Ray", "=ds=#sr# 240", "=ds="..AL["Trainer"]};
				{ 15, "s12907", "10726", "=q2=Gnomish Mind Control Cap", "=ds=#sr# 235", "=ds="..AL["Trainer"]};
				{ 16, "s12906", "10725", "=q1=Gnomish Battle Chicken", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 17, "s12905", "10724", "=q2=Gnomish Rocket Boots", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 18, "s12903", "10721", "=q2=Gnomish Harm Prevention Belt", "=ds=#sr# 215", "=ds="..AL["Trainer"]};
				{ 19, "s12897", "10545", "=q2=Gnomish Goggles", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 20, "s12902", "10720", "=q1=Gnomish Net-o-Matic Projector", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 21, "s12899", "10716", "=q1=Gnomish Shrink Ray", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 22, "s12895", "10713", "=q1=Inlaid Mithril Cylinder Plans", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = GNOMISH,
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["Goblin"] = {
		["Normal"] = {
			{
				{ 1, "s127138", "87250", "=q3=Depleted-Kyparium Rocket", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 2, "s95707", "63396", "=q1=Big Daddy", "=ds=#sr# 500", "=ds="..AL["Trainer"], amount = 3 };
				{ 3, "s84412", "59597", "=q3=Personal World Destroyer", "=ds=#sr# 475", "=ds="..AL["Trainer"]};
				{ 4, "s56514", "42641", "=q1=Global Thermal Sapper Charge", "=ds=#sr# 425", "=ds="..AL["Trainer"], amount = 5};
				{ 5, "s30565", "23838", "=q4=Foreman's Enchanted Helmet", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 6, "s30566", "23839", "=q4=Foreman's Reinforced Helmet", "=ds=#sr# 375", "=ds="..AL["Trainer"]};
				{ 7, "s30563", "23836", "=q3=Goblin Rocket Launcher", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 8, "s36954", "30542", "=q2=Dimensional Ripper - Area 52", "=ds=#sr# 350"};
				{ 9, "s30560", "23827", "=q1=Super Sapper Charge", "=ds=#sr# 340", "=ds="..AL["Trainer"]};
				{ 10, "s30558", "23826", "=q1=The Bigger One", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 11, "s23078", "18587", "=q1=Goblin Jumper Cables XL", "=ds=#sr# 265", "=ds="..ALIL["Blackrock Depths"]};
				{ 12, "s23486", "18984", "=q2=Dimensional Ripper - Everlook", "=ds=#sr# 260"};
				{ 13, "s12758", "10588", "=q2=Goblin Rocket Helmet", "=ds=#sr# 245", "=ds="..AL["Trainer"]};
				{ 14, "s12908", "10727", "=q1=Goblin Dragon Gun", "=ds=#sr# 240", "=ds="..AL["Trainer"]};
				{ 15, "s12754", "10586", "=q1=The Big One", "=ds=#sr# 235", "=ds="..AL["Trainer"]};
				{ 16, "s12755", "10587", "=q1=Goblin Bomb Dispenser", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 17, "s8895", "7189", "=q2=Goblin Rocket Boots", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 18, "s12718", "10543", "=q2=Goblin Construction Helmet", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 19, "s12717", "10542", "=q2=Goblin Mining Helmet", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 20, "s12716", "10577", "=q2=Goblin Mortar", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 21, "s12715", "10644", "=q1=Recipe: Goblin Rocket Fuel", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 22, "s12760", "10646", "=q1=Goblin Sapper Charge", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 23, "s13240", "10577", "=q1=The Mortar: Reloaded", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = GOBLIN,
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringGem"] = {
		["Normal"] = {
			{
				{ 2, "s131211", "77544", "=q3=Flashing Tinker's Gear", "=ds=#sr# 535", "=ds="..AL["Trainer"]};
				{ 3, "s131212", "77547", "=q3=Fractured Tinker's Gear", "=ds=#sr# 535", "=ds="..AL["Trainer"]};
				{ 4, "s131213", "77543", "=q3=Precise Tinker's Gear", "=ds=#sr# 535", "=ds="..AL["Trainer"]};
				{ 5, "s131214", "77542", "=q3=Quick Tinker's Gear", "=ds=#sr# 535", "=ds="..AL["Trainer"]};
				{ 6, "s131215", "77545", "=q3=Rigid Tinker's Gear", "=ds=#sr# 535", "=ds="..AL["Trainer"]};
				{ 7, "s131216", "77541", "=q3=Smooth Tinker's Gear", "=ds=#sr# 535", "=ds="..AL["Trainer"]};
				{ 8, "s131217", "77546", "=q3=Sparkling Tinker's Gear", "=ds=#sr# 535", "=ds="..AL["Trainer"]};
				{ 9, "s131218", "77540", "=q3=Subtle Tinker's Gear", "=ds=#sr# 535", "=ds="..AL["Trainer"]};
				{ 17, "", "59480", "=q3=Fractured Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 18, "", "59491", "=q3=Flashing Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 19, "", "68660", "=q3=Mystic Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 20, "", "59489", "=q3=Precise Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 21, "", "59479", "=q3=Quick Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 22, "", "59493", "=q3=Rigid Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 23, "", "59496", "=q3=Sparkling Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 24, "", "59478", "=q3=Smooth Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 25, "", "59477", "=q3=Subtle Cogwheel", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Cogwheel"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringPetMount"] = {
		["Normal"] = {
			{
				{ 1, "s139196", "94903", "=q3=Pierre", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 2, "s143714", "100905", "=q3=Rascal-Bot", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 3, "s127135", "87526", "=q3=Mechanical Pandaren Dragonling", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 4, "s84413", "60216", "=q3=De-Weaponized Mechanical Companion", "=ds=#sr# 475", "=ds="..AL["Trainer"].. ", #p17#" };
				{ 5, "s84412", "59597", "=q3=Personal World Destroyer", "=ds=#sr# 475", "=ds="..AL["Trainer"].. ", #p18#"};
				{ 6, "s19793", "15996", "=q1=Lifelike Mechanical Toad", "=ds=#sr# 265", "=ds="..AL["World Drop"] };
				{ 7, "s26011", "21277", "=q1=Tranquil Mechanical Yeti", "=ds=#sr# 250", "=ds="..AL["Quest Reward"] };
				{ 8, "s15633", "11826", "=q1=Lil' Smoky", "=ds=#sr# 205", "=ds="..ALIL["Gnomeregan"] };
				{ 9, "s15628", "11825", "=q1=Pet Bombling", "=ds=#sr# 205", "=ds="..ALIL["Gnomeregan"] };
				{ 10, "s3928", "4401", "=q1=Mechanical Squirrel Box", "=ds=#sr# 75", "=ds="..AL["World Drop"] };
				{ 16, "s139192", "95416", "=q4=Sky Golem", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 17, "s127139", "87251", "=q3=Geosynchronous World Spinner", "=ds=#sr# 600", "=ds="..AL["Trainer"].. ", #p17#" };
				{ 18, "s127138", "87250", "=q3=Depleted-Kyparium Rocket", "=ds=#sr# 600", "=ds="..AL["Trainer"].. ", #p18#"};
				{ 19, "s60866", "41508", "=q4=Mechano-Hog", "=ds=#sr# 450", "=ds="..ALIL["Horde Expedition"].." - "..AL["Exalted"] };
				{ 20, "s60867", "44413", "=q4=Mekgineer's Chopper", "=ds=#sr# 450", "=ds="..ALIL["Alliance Vanguard"].." - "..AL["Exalted"] };
				{ 21, "s44157", "34061", "=q4=Turbo-Charged Flying Machine Control", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 22, "s44155", "34060", "=q3=Flying Machine Control", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = ENGINEERING..": "..BabbleInventory["Pet"].." & "..BabbleInventory["Mount"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

	AtlasLoot_Data["EngineeringFirework"] = {
		["Normal"] = {
			{
				{ 1, "s131353", "89991", "=q1=Pandaria Firework", "=ds=#sr# 500", "=ds="..AL["Trainer"]};
				{ 2, "s131256", "89893", "=q1=Autumn Flower Firework", "=ds=#sr# 500", "#ITEMID:89991#", amount = 5};
				{ 3, "s128260", "88493", "=q1=Celestial Firework", "=ds=#sr# 500", "#ITEMID:89991#", amount = 5};
				{ 4, "s128261", "88491", "=q1=Grand Celebration Firework", "=ds=#sr# 500", "#ITEMID:89991#", amount = 5};
				{ 5, "s131258", "89888", "=q1=Jade Blossom Firework", "=ds=#sr# 500", "#ITEMID:89991#", amount = 5};
				{ 6, "s128262", "87764", "=q1=Serpent's Heart Firework", "=ds=#sr# 500", "#ITEMID:89991#", amount = 5};
				{ 8, "s30344", "23771", "=q1=Green Smoke Flare", "=ds=#sr# 335", "=ds="..AL["Vendor"], amount = 3};
				{ 9, "s32814", "25886", "=q1=Purple Smoke Flare", "=ds=#sr# 335", "=ds="..AL["World Drop"], amount = 3};
				{ 10, "s30341", "23768", "=q1=White Smoke Flare", "=ds=#sr# 335", "=ds="..AL["Vendor"], amount = 3};
				{ 11, "s26443", "21570", "=q1=Cluster Launcher", "=ds=#sr# 275", "=ds="..AL["Lunar Festival"], amount = 2};
				{ 12, "s26426", "21714", "=q1=Large Blue Rocket Cluster", "=ds=#sr# 275", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 13, "s26427", "21716", "=q1=Large Green Rocket Cluster", "=ds=#sr# 275", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 14, "s26428", "21718", "=q1=Large Red Rocket Cluster", "=ds=#sr# 275", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 15, "s23507", "19026", "=q1=Snake Burst Firework", "=ds=#sr# 250", "=ds="..AL["Vendor"], amount = 4};
				{ 16, "s26442", "21569", "=q1=Firework Launcher", "=ds=#sr# 225", "=ds="..AL["Lunar Festival"]};
				{ 17, "s26423", "21571", "=q1=Blue Rocket Cluster", "=ds=#sr# 225", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 18, "s26424", "21574", "=q1=Green Rocket Cluster", "=ds=#sr# 225", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 19, "s26425", "21576", "=q1=Red Rocket Cluster", "=ds=#sr# 225", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 21, "s26420", "21589", "=q1=Large Blue Rocket", "=ds=#sr# 175", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 22, "s26421", "21590", "=q1=Large Green Rocket", "=ds=#sr# 175", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 23, "s26422", "21592", "=q1=Large Red Rocket", "=ds=#sr# 175", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 25, "s23067", "9312", "=q1=Blue Firework", "=ds=#sr# 150", "=ds="..AL["Vendor"], amount = 3};
				{ 26, "s23068", "9313", "=q1=Green Firework", "=ds=#sr# 150", "=ds="..AL["Vendor"], amount = 3};
				{ 27, "s23066", "9318", "=q1=Red Firework", "=ds=#sr# 150", "=ds="..AL["Vendor"], amount = 3};
				{ 28, "s26416", "21558", "=q1=Small Blue Rocket", "=ds=#sr# 125", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 29, "s26417", "21559", "=q1=Small Green Rocket", "=ds=#sr# 125", "=ds="..AL["Lunar Festival"], amount = 3};
				{ 30, "s26418", "21557", "=q1=Small Red Rocket", "=ds=#sr# 125", "=ds="..AL["Lunar Festival"], amount = 3};
			};
		};
		info = {
			name = ENGINEERING..": "..AL["Fireworks"],
			module = moduleName, menu = "ENGINEERINGMENU", instance = "Engineering",
		};
	};

		-----------------
		--- First Aid ---
		-----------------

	AtlasLoot_Data["FirstAid"] = {
		["Normal"] = {
			{
				{ 1, "s102699", "72986", "=q1=Heavy Windwool Bandage", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 2, "s102698", "72986", "=q1=Heavy Windwool Bandage", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 3, "s102697", "72985", "=q1=Windwool Bandage", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 4, "s74558", "53051", "=q1=Dense Embersilk Bandage", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 5, "s88893", "53051", "=q1=Dense Embersilk Bandage", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 6, "s74557", "53050", "=q1=Heavy Embersilk Bandage", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 7, "s74556", "53049", "=q1=Embersilk Bandage", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 8, "s45546", "34722", "=q1=Heavy Frostweave Bandage", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 9, "s45545", "34721", "=q1=Frostweave Bandage", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 10, "s27033", "21991", "=q1=Heavy Netherweave Bandage", "=ds=#sr# 330", "=ds="..AL["Trainer"] };
				{ 11, "s27032", "21990", "=q1=Netherweave Bandage", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 12, "s23787", "19440", "=q1=Powerful Anti-Venom", "=ds=#sr# 300", "=ds="..AL["Vendor"] };
				{ 13, "s18630", "14530", "=q1=Heavy Runecloth Bandage", "=ds=#sr# 290", "=ds="..AL["Trainer"] };
				{ 14, "s18629", "14529", "=q1=Runecloth Bandage", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
				{ 15, "s10841", "8545", "=q1=Heavy Mageweave Bandage", "=ds=#sr# 240", "=ds="..AL["Trainer"] };
				{ 16, "s10840", "8544", "=q1=Mageweave Bandage", "=ds=#sr# 210", "=ds="..AL["Trainer"] };
				{ 17, "s7929", "6451", "=q1=Heavy Silk Bandage", "=ds=#sr# 180", "=ds="..AL["Trainer"] };
				{ 18, "s7928", "6450", "=q1=Silk Bandage", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 19, "s7935", "6453", "=q1=Strong Anti-Venom", "=ds=#sr# 130", "=ds="..AL["Drop"], amount = 3 };
				{ 20, "s3278", "3531", "=q1=Heavy Wool Bandage", "=ds=#sr# 115", "=ds="..AL["Trainer"] };
				{ 21, "s3277", "3530", "=q1=Wool Bandage", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 22, "s7934", "6452", "=q1=Anti-Venom", "=ds=#sr# 80", "=ds="..AL["Trainer"], amount = 3 };
				{ 23, "s3276", "2581", "=q1=Heavy Linen Bandage", "=ds=#sr# 40", "=ds="..AL["Trainer"] };
				{ 24, "s3275", "1251", "=q1=Linen Bandage", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = FIRSTAID,
			module = moduleName, menu = "CRAFTINGMENU"
		};
	};

		---------------
		--- Fishing ---
		---------------

	AtlasLoot_Data["FishingPoles"] = {
		["Normal"] = {
			{
				{ 1, "", "19970", "=q3=Arcanite Fishing Pole", "=ds=#sr# 300", "=ds="..AL["Stranglethorn Fishing Extravaganza"].." #m4#: #QUESTID:8193#"};
				{ 2, "", "44050", "=q4=Mastercraft Kalu'ak Fishing Pole", "=ds=#sr# 300", "=ds="..ALIL["The Kalu'ak"].." - "..AL["Exalted"]};
				{ 3, "", "45991", "=q3=Bone Fishing Pole", "=ds=#sr# 300", "=ds="..AL["Fishing Daily Reward"]};
				{ 4, "", "84661", "=q3=Dragon Fishing Pole", "=ds=#sr# 525", "=ds="..ALIL["The Anglers"].." - "..AL["Revered"]};
				{ 5, "", "45992", "=q3=Jeweled Fishing Pole", "=ds=#sr# 300", "=ds="..AL["Fishing Daily Reward"]};
				{ 6, "", "45858", "=q3=Nat's Lucky Fishing Pole", "=ds=#sr# 225", "=ds=#m4#: #QUESTID:6607#"};
				{
					{ 7, "", "19022", "=q2=Nat Pagle's Extreme Angler FC-5000", "=ds=#sr# 100", "=ds=#m4#: #QUESTID:26211#"};
					{ 7, "", "19022", "=q2=Nat Pagle's Extreme Angler FC-5000", "=ds=#sr# 100", "=ds=#m4#: #QUESTID:26485#"};
				};					
				{ 8, "", "25978", "=q1=Seth's Graphite Fishing Pole", "=ds=#sr# 200", "=ds=#m4#: #QUESTID:10037#"};
				{ 9, "", "6367", "=q1=Big Iron Fishing Pole", "=ds=#sr# 100", "=ds="..AL["Drop"]..": "..AL["Shellfish Trap"]};
				{ 10, "", "6366", "=q1=Darkwood Fishing Pole", "=ds=#sr# 50", "=ds="..GetSpellInfo(63275)};
				{ 11, "", "84660", "=q2=Pandaren Fishing Pole", "=ds=#sr# 0", "=ds="..ALIL["The Anglers"].." - "..AL["Honored"]};
				{ 12, "", "6365", "=q1=Strong Fishing Pole", "=ds=#sr# 10", "=ds="..AL["Vendor"]};
				{ 13, "", "46337", "=q1=Staats' Fishing Pole", "=ds=#sr# 1", "=ds=#m4#: #QUESTID:13537#, =ec1=#m7#"};
				{ 14, "", "6256", "=q1=Fishing Pole", "=ds=#sr# 0", "=ds="..AL["Vendor"]};
			};
		};
		info = {
			name = BabbleInventory["Fishing Poles"],
			module = moduleName, menu = "FISHINGMENU"
		};
	};

	AtlasLoot_Data["FishingLuresLines"] = {
		["Normal"] = {
			{
				{ 2, "s84430", "68049", "=q1=Heat-Treated Spinning Lure", "=ds=#sr# 250", "=ds="..AL["Crafted"]..": "..GetSpellInfo(4036).." 510"};
				{ 3, "", "46006", "=q1=Glow Worm", "=ds=#sr# 100", "=ds="..AL["Fishing Daily Reward"]};
				{ 4, "s88017", "62673", "=q1=Feathered Lure", "=ds=#sr# 100", "=ds="..AL["Crafted"]..": "..GetSpellInfo(2550).." 450"};
				{ 5, "s9271", "6533", "=q1=Aquadynamic Fish Attractor", "=ds=#sr# 100", "=ds="..AL["Crafted"]..": "..GetSpellInfo(4036).." 150 / "..AL["Vendor"]};
				{ 6, "", "34861", "=q1=Sharpened Fish Hook", "=ds=#sr# 100", "=ds="..AL["Fishing Daily Reward"]};
				{ 7, "", "6532", "=q1=Bright Baubles", "=ds=#sr# 100", "=ds="..AL["Vendor"].." / "..AL["World Drop"]};
				{ 8, "", "7307", "=q1=Flesh Eating Worm", "=ds=#sr# 100", "=ds="..AL["Drop"]..": "..AL["Rotted One"]};
				{ 9, "", "6811", "=q1=Aquadynamic Fish Lens", "=ds=#sr# 50", "=ds="..AL["Drop"]..": "..ALIL["Stendel's Bane"]};
				{ 10, "", "6530", "=q1=Nightcrawlers", "=ds=#sr# 50", "=ds="..AL["Vendor"].." / "..AL["World Drop"]};
				{ 11, "", "6529", "=q1=Shiny Bauble", "=ds=#sr# 0", "=ds="..AL["Vendor"]};
				{ 12, "", "67404", "=q1=Glass Fishing Bobber", "=ds=#sr# 0", "=ds="..AL["Fishing Daily Reward"]};
				{ 17, "", "19971", "=q1=High Test Eternium Fishing Line", "=ds=#sr# 150", "=ds="..AL["Stranglethorn Fishing Extravaganza"].." #m4#: #QUESTID:8224#"};
				{ 18, "", "34836", "=q2=Spun Truesilver Fishing Line", "=ds=#sr# 300", "=ds="..AL["Fishing Daily Reward"]};
				{ 19, "", "68796", "=q1=Reinforced Fishing Line", "=ds=#sr# 0", "=ds="..AL["Drop"]..": "..ALIL["Stendel's Bane"]};
			};
		};
		info = {
			name = BabbleInventory["Fishing Lure"].." / "..AL["Fishing Lines"],
			module = moduleName, menu = "FISHINGMENU"
		};
	};

	AtlasLoot_Data["FishingGear"] = {
		["Normal"] = {
			{
				{ 1, "", "88710", "=q4=Nat's Hat", "=ds=#s1#", "=ds="..ALIL["Nat Pagle"].." - "..AL["Exalted"]};
				{ 2, "", "33820", "=q3=Weather-Beaten Fishing Hat", "=ds=#s1#, #a1#", "=ds="..AL["Fishing Daily Reward"]};
				{ 3, "", "19972", "=q2=Lucky Fishing Hat", "=ds=#s1#, #a1#", "=ds="..AL["Stranglethorn Fishing Extravaganza"].." #m4#: #QUESTID:8221#"};
				{ 5, "", "50287", "=q3=Boots of the Bay", "=ds=#s12#", "=ds="..AL["Kalu'ak Fishing Derby"].." #m4#: #QUESTID:24803#" };
				{ 6, "", "19969", "=q2=Nat Pagle's Extreme Anglin' Boots", "=ds=#s12#, #a1#", "=ds="..AL["Stranglethorn Fishing Extravaganza"].." #m4#: #QUESTID:8225#"};
				{ 8, "", "88535", "=q3=Sharpened Tuskarr Spear", "=ds=#h3#", "=ds="..ALIL["The Anglers"].." - "..AL["Revered"]};
				{ 16, "", "85500", "=q3=Anglers Fishing Raft", "=ds=#m20#", "=ds="..ALIL["The Anglers"].." - "..AL["Revered"]};
				{ 18, "", "85973", "=q3=Ancient Pandaren Fishing Charm", "=ds=#m20#", "=ds="..AL["Drop"]..": Ghostly Pandaren Fisherman" };
				{ 20, "", "33223", "=q3=Fishing Chair", "=ds=#m20#", "=ds="..AL["Card Game Item"]..": "..AL["Gone Fishin'"]};
				{ 21, "", "70161", "=q3=Mushroom Chair", "=ds=#m20#", "=ds="..AL["Vendor"]..": "..ALIL["Molten Front"]};
				{ 22, "", "86596", "=q3=Nat's Fishing Chair", "=ds=#m20#", "=ds="..ALIL["Nat Pagle"].." - "..AL["Best Friend"]};
				{ 24, "", "60218", "=q3=Lure Master Tackle Box", "=ds=#e1#", "=ds="..AL["Crafted"]..": "..GetSpellInfo(4036).." 475"};
				{ 26, "", "34109", "=q1=Weather-Beaten Journal", "=ds=", "=ds="..AL["Fished From"]..": "..AL["Fishing Pools"].." / "..AL["Fishing Daily Reward"]};
			};
		};
		info = {
			name = AL["Fishing Gear"],
			module = moduleName, menu = "FISHINGMENU"
		};
	};

	AtlasLoot_Data["FishingFishWeapons"] = {
		["Normal"] = {
			{
				{ 1, "", "68050", "=q3=Shatterscale Mightfish", "=ds=#h1#, #w6#", "=ds="..AL["Fished From"].." "};
				{ 2, "", "19808", "=q2=Rockhide Strongfish", "=ds=#h1#, #w6#", "=ds="..AL["Fished From"]..": "};
				{ 4, "", "6292", "=q1=10 Pound Mud Snapper", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 5, "", "6294", "=q1=12 Pound Mud Snapper", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 6, "", "6295", "=q1=15 Pound Mud Snapper", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 8, "", "13901", "=q1=15 Pound Salmon", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 9, "", "13902", "=q1=18 Pound Salmon", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 10, "", "13903", "=q1=22 Pound Salmon", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 11, "", "13904", "=q1=25 Pound Salmon", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 12, "", "13905", "=q1=29 Pound Salmon", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 13, "", "13906", "=q1=32 Pound Salmon", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 16, "", "44703", "=q2=Dark Herring", "=ds=#h1#, #w4#", "=ds="..AL["Fished From"]..": "};
				{ 17, "", "6360", "=q2=Steelscale Crushfish", "=ds=#h1#, #w6#", "=ds="..AL["Fished From"]..": "};
				{ 19, "", "6309", "=q1=17 Pound Catfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 20, "", "6310", "=q1=19 Pound Catfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 21, "", "6311", "=q1=22 Pound Catfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 22, "", "6363", "=q1=26 Pound Catfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 23, "", "6364", "=q1=32 Pound Catfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 25, "", "13885", "=q1=34 Pound Redgill", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 26, "", "13886", "=q1=37 Pound Redgill", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 27, "", "13882", "=q1=42 Pound Redgill", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 28, "", "13883", "=q1=45 Pound Redgill", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 29, "", "13884", "=q1=49 Pound Redgill", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 30, "", "13887", "=q1=52 Pound Redgill", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
			};
			{
				{ 1, "", "13914", "=q1=70 Pound Mightfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 2, "", "13915", "=q1=85 Pound Mightfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 3, "", "13916", "=q1=92 Pound Mightfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 4, "", "13917", "=q1=103 Pound Mightfish", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 16, "", "27516", "=q1=Enormous Barbed Gill Trout", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
				{ 17, "", "27515", "=q1=Huge Spotted Feltail", "=ds=#s15#", "=ds="..AL["Fished From"]..": "};
			};
		};
		info = {
			name = AL["Fish Weapons"],
			module = moduleName, menu = "FISHINGMENU"
		};
	};

		-------------------
		--- Inscription ---
		-------------------

	AtlasLoot_Data["Inscription_Scrolls"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Darkmoon Faire Card"], "" };
				{ 2, "s111830", "79318", "=q3=Darkmoon Card of Mists", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 3, "s86615", "61987", "=q3=Darkmoon Card of the Destruction", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 4, "s59504", "44318", "=q3=Darkmoon Card of the North", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 5, "s59503", "44317", "=q3=Greater Darkmoon Card", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 6, "s59502", "44316", "=q3=Darkmoon Card", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 17, "s86609", "60838", "=q1=Mysterious Fortune Card", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 18, "s59491", "44163", "=q1=Shadowy Tarot", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 19, "s59487", "44161", "=q1=Arcane Tarot", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 20, "s48247", "37168", "=q1=Mysterious Tarot", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 21, "s59480", "44142", "=q1=Strange Tarot", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
				{ 8, "s112996", "79731", "=q3=Scroll of Wisdom", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 23, "s89373", "63308", "=q1=Scroll of Protection IX", "=ds=#sr# 450", "=ds="..AL["Trainer"], amount = 5 };
				{ 10, 0, "INV_Box_01", "=q6="..AL["Recall"].." "..AL["Scrolls"], "" };
				{ 11, "s60337", "44315", "=q1=Scroll of Recall III", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 12, "s60336", "44314", "=q1=Scroll of Recall II", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 13, "s48248", "37118", "=q1=Scroll of Recall", "=ds=#sr# 35", "=ds="..AL["Trainer"] };
				{ 25, 0, "INV_Box_01", "=q6="..AL["Runescrolls"], "" };
				{ 26, "s112045", "79257", "=q1=Runescroll of Fortitude III", "=ds=#sr# 580", "=ds="..AL["Trainer"], amount = 5 };
				{ 27, "s85785", "62251", "=q1=Runescroll of Fortitude II", "=ds=#sr# 500", "=ds="..AL["Trainer"], amount = 5 };
				{ 28, "s69385", "49632", "=q1=Runescroll of Fortitude", "=ds=#sr# 440", "=ds="..AL["Trainer"], amount = 5 };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Agility"].." "..AL["Scrolls"], "" };
				{ 2, "s89370", "63303", "=q1=Scroll of Agility IX", "=ds=#sr# 470", "=ds="..AL["Trainer"], amount = 5 };
				{ 3, "s58483", "43464", "=q1=Scroll of Agility VIII", "=ds=#sr# 420", "=ds="..AL["Trainer"], amount = 2 };
				{ 4, "s58482", "43463", "=q1=Scroll of Agility VII", "=ds=#sr# 370", "=ds="..AL["Trainer"], amount = 2 };
				{ 5, "s58481", "33457", "=q1=Scroll of Agility VI", "=ds=#sr# 310", "=ds="..AL["Trainer"], amount = 2 };
				{ 6, "s58480", "27498", "=q1=Scroll of Agility V", "=ds=#sr# 270", "=ds="..AL["Trainer"], amount = 2 };
				{ 17, "s58478", "10309", "=q1=Scroll of Agility IV", "=ds=#sr# 225", "=ds="..AL["Trainer"], amount = 2 };
				{ 18, "s58476", "4425", "=q1=Scroll of Agility III", "=ds=#sr# 175", "=ds="..AL["Trainer"], amount = 5 };
				{ 19, "s58473", "1477", "=q1=Scroll of Agility II", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
				{ 20, "s58472", "3012", "=q1=Scroll of Agility", "=ds=#sr# 15", "=ds="..AL["Trainer"] };
				{ 8, 0, "INV_Box_01", "=q6="..AL["Intellect"].." "..AL["Scrolls"], "" };
				{ 9, "s89368", "63305", "=q1=Scroll of Intellect IX", "=ds=#sr# 445", "=ds="..AL["Trainer"], amount = 5 };
				{ 10, "s50604", "37092", "=q1=Scroll of Intellect VIII", "=ds=#sr# 410", "=ds="..AL["Trainer"], amount = 2 };
				{ 11, "s50603", "37091", "=q1=Scroll of Intellect VII", "=ds=#sr# 360", "=ds="..AL["Trainer"], amount = 2 };
				{ 12, "s50602", "33458", "=q1=Scroll of Intellect VI", "=ds=#sr# 310", "=ds="..AL["Trainer"], amount = 2 };
				{ 13, "s50601", "27499", "=q1=Scroll of Intellect V", "=ds=#sr# 260", "=ds="..AL["Trainer"], amount = 2 };
				{ 24, "s50600", "10308", "=q1=Scroll of Intellect IV", "=ds=#sr# 215", "=ds="..AL["Trainer"], amount = 2 };
				{ 25, "s50599", "4419", "=q1=Scroll of Intellect III", "=ds=#sr# 165", "=ds="..AL["Trainer"], amount = 5 };
				{ 26, "s50598", "2290", "=q1=Scroll of Intellect II", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 27, "s48114", "955", "=q1=Scroll of Intellect", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Spirit"].." "..AL["Scrolls"], "" };
				{ 2, "s89371", "63307", "=q1=Scroll of Spirit IX", "=ds=#sr# 455", "=ds="..AL["Trainer"], amount = 5 };
				{ 3, "s50611", "37098", "=q1=Scroll of Spirit VIII", "=ds=#sr# 405", "=ds="..AL["Trainer"], amount = 2 };
				{ 4, "s50610", "37097", "=q1=Scroll of Spirit VII", "=ds=#sr# 355", "=ds="..AL["Trainer"], amount = 2 };
				{ 5, "s50609", "33460", "=q1=Scroll of Spirit VI", "=ds=#sr# 295", "=ds="..AL["Trainer"], amount = 2 };
				{ 6, "s50608", "27501", "=q1=Scroll of Spirit V", "=ds=#sr# 255", "=ds="..AL["Trainer"], amount = 2 };
				{ 17, "s50607", "10306", "=q1=Scroll of Spirit IV", "=ds=#sr# 210", "=ds="..AL["Trainer"], amount = 2 };
				{ 18, "s50606", "4424", "=q1=Scroll of Spirit III", "=ds=#sr# 160", "=ds="..AL["Trainer"], amount = 2 };
				{ 19, "s50605", "1712", "=q1=Scroll of Spirit II", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 20, "s48116", "1181", "=q1=Scroll of Spirit", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
				{ 8, 0, "INV_Box_01", "=q6="..AL["Stamina"].." "..AL["Scrolls"], "" };
				{ 9, "s89372", "63306", "=q1=Scroll of Stamina IX", "=ds=#sr# 460", "=ds="..AL["Trainer"], amount = 5 };
				{ 10, "s50620", "37094", "=q1=Scroll of Stamina VIII", "=ds=#sr# 400", "=ds="..AL["Trainer"], amount = 2 };
				{ 11, "s50619", "37093", "=q1=Scroll of Stamina VII", "=ds=#sr# 350", "=ds="..AL["Trainer"], amount = 2 };
				{ 12, "s50618", "33461", "=q1=Scroll of Stamina VI", "=ds=#sr# 290", "=ds="..AL["Trainer"], amount = 2 };
				{ 13, "s50617", "27502", "=q1=Scroll of Stamina V", "=ds=#sr# 250", "=ds="..AL["Trainer"], amount = 2 };
				{ 24, "s50616", "10307", "=q1=Scroll of Stamina IV", "=ds=#sr# 205", "=ds="..AL["Trainer"], amount = 2 };
				{ 25, "s50614", "4422", "=q1=Scroll of Stamina III", "=ds=#sr# 155", "=ds="..AL["Trainer"], amount = 2 };
				{ 26, "s50612", "1711", "=q1=Scroll of Stamina II", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 27, "s45382", "1180", "=q1=Scroll of Stamina", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Strength"].." "..AL["Scrolls"], "" };
				{ 2, "s89369", "63304", "=q1=Scroll of Strength IX", "=ds=#sr# 465", "=ds="..AL["Trainer"], amount = 5 };
				{ 3, "s58491", "43466", "=q1=Scroll of Strength VIII", "=ds=#sr# 415", "=ds="..AL["Trainer"], amount = 2 };
				{ 4, "s58490", "43465", "=q1=Scroll of Strength VII", "=ds=#sr# 365", "=ds="..AL["Trainer"], amount = 2 };
				{ 5, "s58489", "33462", "=q1=Scroll of Strength VI", "=ds=#sr# 305", "=ds="..AL["Trainer"], amount = 2 };
				{ 6, "s58488", "27503", "=q1=Scroll of Strength V", "=ds=#sr# 265", "=ds="..AL["Trainer"], amount = 2 };
				{ 17, "s58487", "10310", "=q1=Scroll of Strength IV", "=ds=#sr# 220", "=ds="..AL["Trainer"], amount = 2 };
				{ 18, "s58486", "4426", "=q1=Scroll of Strength III", "=ds=#sr# 170", "=ds="..AL["Trainer"], amount = 5 };
				{ 19, "s58485", "2289", "=q1=Scroll of Strength II", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 20, "s58484", "954", "=q1=Scroll of Strength", "=ds=#sr# 15", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = INSCRIPTION..": "..AL["Darkmoon Faire Card"].."/"..AL["Scrolls"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Enchants"] = {
		["Normal"] = {
			{
				{ 1, "s127023", "87582", "=q4=Secret Crane Wing Inscription", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 2, "s127024", "87581", "=q4=Secret Ox Horn Inscription", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 3, "s127021", "87584", "=q4=Secret Tiger Claw Inscription", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 4, "s127020", "87585", "=q4=Secret Tiger Fang Inscription", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 6, "s126995", "87559", "=q4=Greater Crane Wing Inscription", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 7, "s126994", "87560", "=q4=Greater Ox Horn Inscription", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 8, "s126996", "83007", "=q4=Greater Tiger Claw Inscription", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 9, "s126997", "83006", "=q4=Greater Tiger Fang Inscription", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 11, "s127018", "87578", "=q3=Crane Wing Inscription", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 12, "s127019", "87577", "=q3=Ox Horn Inscription", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 13, "s127017", "87579", "=q3=Tiger Claw Inscription", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 14, "s127016", "87580", "=q3=Tiger Fang Inscription", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 16, "s86403", "INV_Misc_MastersInscription", "=ds=Felfire Inscription", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 17, "s86402", "INV_Misc_MastersInscription", "=ds=Inscription of the Earthen Prince", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 18, "s86401", "INV_Misc_MastersInscription", "=ds=Lionsmane Inscription", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 19, "s86375", "INV_Misc_MastersInscription", "=ds=Swiftsteel Inscription", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 21, "s61117", "INV_Misc_MastersInscription", "=ds=Master's Inscription of the Axe", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 22, "s61118", "INV_Misc_MastersInscription", "=ds=Master's Inscription of the Crag", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 23, "s61119", "INV_Misc_MastersInscription", "=ds=Master's Inscription of the Pinnacle", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 24, "s61120", "INV_Misc_MastersInscription", "=ds=Master's Inscription of the Storm", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = INSCRIPTION..": "..AL["Shoulder Enchants"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Reagents"] = {
		["Normal"] = {
			{
				{ 1, "s111646", "79255", "=q2=Starlight Ink", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 2, "s111645", "79254", "=q1=Ink of Dreams", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 3, "s86005", "61981", "=q2=Inferno Ink", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 4, "s86004", "61978", "=q1=Blackfallow Ink", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 5, "s57716", "43127", "=q2=Snowfall Ink", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 6, "s57715", "43126", "=q1=Ink of the Sea", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 7, "s57714", "43125", "=q2=Darkflame Ink", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 8, "s57713", "43124", "=q1=Ethereal Ink", "=ds=#sr# 290", "=ds="..AL["Trainer"] };
				{ 9, "s57712", "43123", "=q2=Ink of the Sky", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 10, "s57711", "43122", "=q1=Shimmering Ink", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 16, "s57710", "43121", "=q2=Fiery Ink", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 17, "s57709", "43120", "=q1=Celestial Ink", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 18, "s57708", "43119", "=q2=Royal Ink", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 19, "s57707", "43118", "=q1=Jadefire Ink", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 20, "s57706", "43117", "=q2=Dawnstar Ink", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 21, "s57704", "43116", "=q1=Lion's Ink", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 22, "s57703", "43115", "=q2=Hunter's Ink", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
				{ 23, "s53462", "39774", "=q1=Midnight Ink", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 24, "s52843", "39469", "=q1=Moonglow Ink", "=ds=#sr# 35", "=ds="..AL["Trainer"] };
				{ 25, "s52738", "37101", "=q1=Ivory Ink", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = INSCRIPTION..": "..AL["Reagents"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_OffHand"] = {
		["Normal"] = {
			{
				{ 1, "s111909", "79334", "=q4=Inscribed Jade Fan", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 2, "s111910", "79335", "=q4=Inscribed Red Fan", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 3, "s111908", "79333", "=q3=Inscribed Fan", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 4, "s86643", "62236", "=q3=Battle Tome", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 5, "s86642", "62235", "=q3=Divine Companion", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 6, "s86641", "62234", "=q3=Dungeoneering Guide", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 7, "s86616", "62231", "=q3=Book of Blood", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 8, "s86640", "62233", "=q3=Lord Rottington's Pressed Wisp Book", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 9, "s59498", "44210", "=q4=Faces of Doom", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 10, "s59497", "38322", "=q4=Iron-bound Tome", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 11, "s64051", "45854", "=q3=Rituals of the New Moon", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 12, "s64053", "45849", "=q3=Twilight Tome", "=ds=#sr# 350", "=ds="..AL["Trainer"]};
				{ 13, "s59496", "43667", "=q3=Book of Clever Tricks", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 14, "s59495", "43666", "=q3=Hellfire Tome", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 15, "s59494", "43664", "=q3=Manual of Clouds", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 16, "s59493", "43663", "=q3=Stormbound Tome", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 17, "s59490", "43661", "=q3=Book of Stars", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 18, "s59489", "43660", "=q3=Fire Eater's Guide", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 19, "s59486", "43657", "=q3=Royal Guide of Escape Routes", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 20, "s59484", "43656", "=q3=Tome of Kings", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 21, "s59478", "43655", "=q3=Book of Survival", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 22, "s59475", "43654", "=q3=Tome of the Dawn", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 23, "s58565", "43515", "=q3=Mystic Tome", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = INSCRIPTION..": "..AL["Off-Hand Items"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Staves"] = {
		["Normal"] = {
			{
				{ 1, "s111918", "79340", "=q4=Inscribed Crane Staff", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 2, "s111919", "79341", "=q4=Inscribed Serpent Staff", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 3, "s111921", "79343", "=q4=Inscribed Tiger Staff", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 4, "s111920", "79342", "=q3=Ghost Iron Staff", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 5, "s111917", "79339", "=q3=Rain Poppy Staff", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 16, "s86652", "87562", "=q3=Rosethorn Staff", "=ds=#sr# 515", "=ds="..AL["Trainer"] };
				{ 17, "s86653", "87561", "=q3=Silver Inlaid Staff", "=ds=#sr# 515", "=ds="..AL["Trainer"] };
				{ 18, "s86649", "87566", "=q3=Runed Staff", "=ds=#sr# 505", "=ds="..AL["Trainer"] };
				{ 19, "s86648", "87565", "=q3=Key to the Planes", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Staves"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Misc"] = {
		["Normal"] = {
			{
				{ 1, "s146638", "102483", "=q3=Crafted Malevolent Gladiator's Medallion of Tenacity", "=ds=#s14# / =q1=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 2, "s127009", "89368", "=q1=Chi-ji Kite", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 3, "s126988", "87647", "=q1=Origami Crane", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 4, "s126989", "87648", "=q1=Origami Frog", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 5, "s127007", "89367", "=q1=Yu'lon Kite", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 6, "s112883", "79249", "=q1=Tome of the Clear Mind", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 7, "s86654", "63276", "=q1=Forged Documents", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 8, "s86646", "63246", "=q1=Origami Beetle", "=ds=#sr# 500", "=ds="..AL["World Drop"] };
				{ 9, "s86645", "62238", "=q1=Origami Rock", "=ds=#sr# 490", "=ds="..AL["World Drop"] };
				{ 10, "s86644", "62239", "=q1=Origami Slime", "=ds=#sr# 480", "=ds="..AL["World Drop"] };
				{ 11, "s92027", "63388", "=q1=Dust of Disappearance", "=ds=#sr# 475", "=ds="..AL["Trainer"], amount = 3 };
				{ 12, "s59387", "43850", "=q1=Certificate of Ownership", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 13, "s92026", "64670", "=q1=Vanishing Powder", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 14, "s52739", "38682", "=q1=Enchanting Vellum", "=ds=#sr# 35", "=ds="..AL["Trainer"], amount = 2 };
				{ 16, "s127378", "87811", "=q1=Commissioned Painting", "=ds=#sr# 600", "=ds=#QUESTID:31539#" };
				{ 17, "s127391", "87814", "=q1=Engraved Jade Disk", "=ds=#sr# 600", "=ds=#QUESTID:31541#" };
				{ 18, "s127475", "87817", "=q1=Incarnadine Ink", "=ds=#sr# 600", "=ds=#QUESTID:31542#" };
				{ 19, "s127481", "87831", "=q1=Inscribed Monument", "=ds=#sr# 600", "=ds=#QUESTID:31544#" };
				{ 20, "s128922", "88806", "=q1=Portrait of Madam Goya", "=ds=#sr# 600", "=ds=#QUESTID:31543#" };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Miscellaneous"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_DeathKnight"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s148258", "104049", "=q1=Glyph of Festering Blood", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 3, "s148256", "104047", "=q1=Glyph of Loud Horn", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Ordon Candlekeeper"]..", =ds="..ALIL["Timeless Isle"] };
				{ 4, "s148257", "104048", "=q1=Glyph of Regenerative Magic", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Damp Shambler"].."/"..ALIL["Rock Moss"]..", =ds="..ALIL["Timeless Isle"] };
				{ 5, "s148255", "104046", "=q1=Glyph of Swift Death", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 6, "s64297", "45799", "=q1=Glyph of Dancing Rune Weapon", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s64298", "45800", "=q1=Glyph of Dark Simulacrum", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 8, "s57207", "43533", "=q1=Glyph of Anti-Magic Shell", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 9, "s57211", "43537", "=q1=Glyph of Chains of Ice", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 10, "s57214", "43542", "=q1=Glyph of Death and Decay", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s57220", "43547", "=q1=Glyph of Enduring Infection", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 12, "s57208", "43534", "=q1=Glyph of Unholy Frenzy", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 13, "s57225", "43552", "=q1=Glyph of Strangulate", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 17, "s57222", "43549", "=q1=Glyph of Mind Freeze", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 18, "s57227", "43554", "=q1=Glyph of Vampiric Blood", "=ds=#sr# 345", "=ds="..AL["Trainer"] };
				{ 19, "s59339", "43826", "=q1=Glyph of Outbreak", "=ds=#sr# 320", "=ds="..AL["Trainer"] };
				{ 20, "s59338", "43825", "=q1=Glyph of Unholy Command", "=ds=#sr# 310", "=ds="..AL["Trainer"] };
				{ 21, "s57226", "43553", "=q1=Glyph of Pillar of Frost", "=ds=#sr# 305", "=ds="..AL["Trainer"] };
				{ 22, "s57221", "43548", "=q1=Glyph of Pestilence", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 23, "s57213", "43541", "=q1=Glyph of Death Grip", "=ds=#sr# 285", "=ds="..AL["Trainer"] };
				{ 24, "s57219", "43546", "=q1=Glyph of Icy Touch", "=ds=#sr# 280", "=ds="..AL["Trainer"] };
				{ 25, "s96284", "68793", "=q1=Glyph of Dark Succor", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 26, "s64266", "45804", "=q1=Glyph of Death Coil", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 27, "s57216", "43543", "=q1=Glyph of Shifting Presences", "=ds=#sr# 270", "=ds="..AL["Trainer"] };
				{ 28, "s57210", "43536", "=q1=Glyph of Icebound Fortitude", "=ds=#sr# 265", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 2, "s148267", "104101", "=q1=Glyph of the Long Winter", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 3, "s148266", "104099", "=q1=Glyph of the Skeleton", "=ds="..AL["Drop"]..": =q2="..ALIL["Rattleskew"]..", =ds="..ALIL["Timeless Isle"] };
				{ 4, "s64300", "45806", "=q1=Glyph of Tranquil Grip", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 5, "s57223", "43550", "=q1=Glyph of Army of the Dead", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 6, "s59340", "43827", "=q1=Glyph of Corpse Explosion", "=ds=#sr# 340", "=ds="..AL["Trainer"] };
				{ 7, "s57224", "43551", "=q1=Glyph of Foul Menagerie", "=ds=#sr# 330", "=ds="..AL["Trainer"] };
				{ 17, "s57228", "43673", "=q1=Glyph of Death Gate", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 18, "s57215", "43539", "=q1=Glyph of Death's Embrace", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 19, "s57217", "43544", "=q1=Glyph of Horn of Winter", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 20, "s57229", "43671", "=q1=Glyph of Path of Frost", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 21, "s57230", "43672", "=q1=Glyph of Resilient Grip", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 22, "s57209", "43535", "=q1=Glyph of the Geist", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Druid"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s64313", "45603", "=q1=Glyph of Might of Ursoc", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 3, "s64307", "45604", "=q1=Glyph of Stampeding Roar", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 4, "s64270", "45602", "=q1=Glyph of Wild Growth", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 5, "s64256", "45623", "=q1=Glyph of Barkskin", "=ds=#sr# 425", "=ds="..GetSpellInfo(61177) };
				{ 6, "s64268", "45601", "=q1=Glyph of Survival Instincts", "=ds=#sr# 425", "=ds="..GetSpellInfo(61177) };
				{ 7, "s56949", "40915", "=q1=Glyph of Efflorescence", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 8, "s56946", "40920", "=q1=Glyph of Hurricane", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 9, "s56947", "40908", "=q1=Glyph of Innervate", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 10, "s56944", "40899", "=q1=Glyph of Omens", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s56954", "40912", "=q1=Glyph of Regrowth", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 12, "s56958", "40921", "=q1=Glyph of Skull Bash", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 13, "s56960", "40906", "=q1=Glyph of Stampede", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 14, "s62162", "44928", "=q1=Glyph of the Master Shapeshifter", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 15, "s56943", "40896", "=q1=Glyph of Frenzied Regeneration", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 17, "s94402", "67484", "=q1=Glyph of Fae Silence", "=ds=#sr# 330", "=ds="..AL["Trainer"] };
				{ 18, "s56952", "40903", "=q1=Glyph of Pounce", "=ds=#sr# 310", "=ds="..AL["Trainer"] };
				{ 19, "s56957", "40901", "=q1=Glyph of Shred", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
				{ 20, "s64258", "45622", "=q1=Glyph of Cyclone", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 21, "s56959", "40916", "=q1=Glyph of Guided Stars", "=ds=#sr# 220", "=ds="..AL["Trainer"] };
				{ 22, "s56956", "40902", "=q1=Glyph of Prowl", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 23, "s56953", "40909", "=q1=Glyph of Rebirth", "=ds=#sr# 170", "=ds="..AL["Trainer"] };
				{ 24, "s56951", "40923", "=q1=Glyph of Savagery", "=ds=#sr# 130", "=ds="..AL["Trainer"] };
				{ 25, "s94401", "67487", "=q1=Glyph of Cat Form", "=ds=#sr# 120", "=ds="..AL["Trainer"] };
				{ 26, "s94403", "67485", "=q1=Glyph of Faerie Fire", "=ds=#sr# 120", "=ds="..AL["Trainer"] };
				{ 27, "s56945", "40914", "=q1=Glyph of Healing Touch", "=ds=#sr# 115", "=ds="..AL["Trainer"] };
				{ 28, "s48121", "40924", "=q1=Glyph of Entangling Roots", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 29, "s67600", "48720", "=q1=Glyph of Ferocious Bite", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 30, "s56961", "40897", "=q1=Glyph of Maul", "=ds=#sr# 90", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s56963", "40922", "=q1=Glyph of Nature's Grasp", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
				{ 3, "s56955", "40913", "=q1=Glyph of Rejuvenation", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 17, "s59315", "43674", "=q1=Glyph of Dash", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 18, "s58288", "43331", "=q1=Glyph of Blooming", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 5, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 6, "s131152", "89868", "=q1=Glyph of the Cheetah", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 7, "s148269", "104103", "=q1=Glyph of One with Nature", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Ashleaf Sprite"]..", =ds="..ALIL["Timeless Isle"] };
				{ 8, "s148268", "104102", "=q1=Glyph of the Sprouting Mushroom", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 9, "s56950", "40900", "=q1=Glyph of the Stag", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 10, "s95215", "68039", "=q1=Glyph of the Treant", "=ds=#sr# 155", "=ds="..GetSpellInfo(61288) };
				{ 11, "s56948", "40919", "=q1=Glyph of the Orca", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 21, "s94404", "67486", "=q1=Glyph of the Predator", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 22, "s58286", "43316", "=q1=Glyph of Aquatic Form", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 23, "s58296", "43335", "=q1=Glyph of Charm Woodland Creature", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 24, "s58289", "43332", "=q1=Glyph of Grace", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 25, "s56965", "44922", "=q1=Glyph of Stars", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 26, "s58287", "43334", "=q1=Glyph of the Chameleon", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s124443", "85684", "=q1=Glyph of Black Ice", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 3, "s148489", "104276", "=q1=Glyph of Enduring Deceit", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 4, "s148487", "104270", "=q1=Glyph of the Lean Pack", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Crag Stalker"].."/"..ALIL["Primal Stalker"]..", =ds="..ALIL["Timeless Isle"] };
				{ 5, "s64271", "45625", "=q1=Glyph of Chimera Shot", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 6, "s64253", "45733", "=q1=Glyph of Master's Call", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s64246", "45735", "=q1=Glyph of Mirrored Blades", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 8, "s64249", "45734", "=q1=Glyph of Scatter Shot", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 9, "s64273", "45731", "=q1=Glyph of Tranquilizing Shot", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 10, "s57011", "42914", "=q1=Glyph of Aimed Shot", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s56998", "42901", "=q1=Glyph of Distracting Shot", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 12, "s56999", "42902", "=q1=Glyph of Endless Wrath", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 13, "s56996", "42899", "=q1=Glyph of Liberation", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 14, "s57012", "42915", "=q1=Glyph of Mend Pet", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 17, "s57010", "42913", "=q1=Glyph of Snake Trap", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 18, "s57014", "42917", "=q1=Glyph of Solace", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 19, "s57006", "42909", "=q1=Glyph of Animal Bond", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 20, "s57003", "42909", "=q1=Glyph of Ice Trap", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 21, "s57008", "42911", "=q1=Glyph of Pathfinding", "=ds=#sr# 315", "=ds="..AL["Trainer"] };
				{ 22, "s57002", "42905", "=q1=Glyph of Freezing Trap", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
				{ 23, "s57001", "42904", "=q1=Glyph of Disengage", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 24, "s57000", "42903", "=q1=Glyph of Deterrence", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 25, "s57007", "42910", "=q1=Glyph of No Escape", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 26, "s57005", "42908", "=q1=Glyph of Explosive Trap", "=ds=#sr# 130", "=ds="..AL["Trainer"] };
				{ 27, "s56997", "42900", "=q1=Glyph of Mending", "=ds=#sr# 115", "=ds="..AL["Trainer"] };
				{ 28, "s56995", "42898", "=q1=Glyph of Camouflage", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 29, "s57004", "42907", "=q1=Glyph of Misdirection", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 2, "s126701", "87278", "=q1=Glyph of Direction", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 3, "s126704", "87279", "=q1=Glyph of Marking", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 4, "s124442", "85683", "=q1=Glyph of Aspect of the Beast", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 5, "s126801", "87393", "=q1=Glyph of Fetch", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 6, "s64304", "45732", "=q1=Glyph of Aspect of the Cheetah", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s56994", "42897", "=q1=Glyph of Aspects", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 17, "s57009", "42912", "=q1=Glyph of Tame Beast", "=ds=#sr# 90", "=ds="..AL["Trainer"] };
				{ 18, "s58297", "43355", "=q1=Glyph of Aspect of the Pack", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 19, "s58302", "43351", "=q1=Glyph of Fireworks", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 20, "s58301", "43350", "=q1=Glyph of Lesser Proportion", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 21, "s58299", "43338", "=q1=Glyph of Revive Pet", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 22, "s58298", "43356", "=q1=Glyph of Stampede", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s98398", "69773", "=q1=Glyph of Armors", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 3, "s64257", "45740", "=q1=Glyph of Deep Freeze", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 4, "s64275", "45737", "=q1=Glyph of Slow", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 5, "s64274", "45736", "=q1=Glyph of Water Elemental", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 6, "s56987", "42752", "=q1=Glyph of Polymorph", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 7, "s94000", "63539", "=q1=Glyph of Inferno Blast", "=ds=#sr# 390", "=ds="..GetSpellInfo(61177) };
				{ 8, "s56975", "42739", "=q1=Glyph of Combustion", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 9, "s61677", "44684", "=q1=Glyph of Frostfire Bolt", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 10, "s56988", "42753", "=q1=Glyph of Icy Veins", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s56983", "42748", "=q1=Glyph of Rapid Displacement", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 12, "s56989", "42754", "=q1=Glyph of Spellsteal", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 17, "s56980", "42745", "=q1=Glyph of Splitting Ice", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 18, "s56972", "42736", "=q1=Glyph of Arcane Explosion", "=ds=#sr# 335", "=ds="..AL["Trainer"] };
				{ 19, "s56984", "42749", "=q1=Glyph of Mana Gem", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 20, "s56991", "44955", "=q1=Glyph of Arcane Power", "=ds=#sr# 315", "=ds="..AL["Trainer"] };
				{ 21, "s71101", "50045", "=q1=Glyph of Counterspell", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 22, "s56979", "42744", "=q1=Glyph of Ice Block", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 23, "s56981", "42746", "=q1=Glyph of Cone of Cold", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 24, "s56974", "42738", "=q1=Glyph of Evocation", "=ds=#sr# 155", "=ds="..AL["Trainer"] };
				{ 25, "s56973", "42737", "=q1=Glyph of Blink", "=ds=#sr# 130", "=ds="..AL["Trainer"] };
				{ 26, "s56976", "42741", "=q1=Glyph of Frost Nova", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 27, "s56990", "44920", "=q1=Glyph of Remove Curse", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 2, "s148272", "104106", "=q1=Glyph of Condensation", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Zesqua"]..", =ds="..ALIL["Timeless Isle"] };
				{ 3, "s148271", "104105", "=q1=Glyph of Evaporation", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Jademist Dancer"]..", =ds="..ALIL["Timeless Isle"] };
				{ 4, "s148270", "104104", "=q1=Glyph of the Unbound Elemental", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 5, "s64276", "45738", "=q1=Glyph of Illusion", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 6, "s64314", "45739", "=q1=Glyph of Mirror Image", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s56986", "42751", "=q1=Glyph of Crittermorph", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 8, "s95710", "63416", "=q1=Glyph of Rapid Teleportation", "=ds=#sr# 155", "=ds="..GetSpellInfo(61288) };
				{ 9, "s56971", "42735", "=q1=Glyph of Loose Mana", "=ds=#sr# 115", "=ds="..AL["Trainer"] };
				{ 17, "s56978", "42743", "=q1=Glyph of Momentum", "=ds=#sr# 90", "=ds="..AL["Trainer"] };
				{ 18, "s58308", "43364", "=q1=Glyph of Arcane Language", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 19, "s58306", "43359", "=q1=Glyph of Conjure Familiar", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 20, "s58309", "43362", "=q1=Glyph of the Bear Cub", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 21, "s58307", "43360", "=q1=Glyph of the Monkey", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 22, "s58310", "43361", "=q1=Glyph of the Penguin", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 23, "s58303", "43339", "=q1=Glyph of the Porcupine", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Monk"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s124444", "85685", "=q1=Glyph of Breath of Fire", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 3, "s124446", "85687", "=q1=Glyph of Clash", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 4, "s124447", "85689", "=q1=Glyph of Enduring Healing Sphere", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 5, "s124449", "85691", "=q1=Glyph of Guard", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 6, "s124450", "85692", "=q1=Glyph of Mana Tea", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 7, "s124448", "82345", "=q1=Glyph of Rapid Rolling", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 8, "s124457", "84652", "=q1=Glyph of Transcendence", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 9, "s124456", "85700", "=q1=Glyph of Touch of Death", "=ds=#sr# 470", "=ds="..AL["Trainer"] };
				{ 10, "s124455", "85699", "=q1=Glyph of Surging Mist", "=ds=#sr# 465", "=ds="..AL["Trainer"] };
				{ 11, "s124445", "87892", "=q1=Glyph of Fists of Fury", "=ds=#sr# 460", "=ds="..AL["Trainer"] };
				{ 12, "s124453", "85697", "=q1=Glyph of Spinning Crane Kick", "=ds=#sr# 445", "=ds="..AL["Trainer"] };
				{ 13, "s124452", "85696", "=q1=Glyph of Renewing Mists", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 17, "s124463", "87896", "=q1=Glyph of Fortuitous Spheres", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
				{ 18, "s112458", "87901", "=q1=Glyph of Targeted Expulsion", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
				{ 19, "s124451", "85695", "=q1=Glyph of Zen Meditation", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
				{ 20, "s112444", "87900", "=q1=Glyph of Touch of Karma", "=ds=#sr# 370", "=ds="..AL["Trainer"] };
				{ 21, "s112454", "87899", "=q1=Glyph of Detox", "=ds=#sr# 365", "=ds="..AL["Trainer"] };
				{ 22, "s112452", "87898", "=q1=Glyph of Sparring", "=ds=#sr# 360", "=ds="..AL["Trainer"] };
				{ 23, "s112440", "87897", "=q1=Glyph of Paralysis", "=ds=#sr# 355", "=ds="..AL["Trainer"] };
				{ 24, "s112442", "87895", "=q1=Glyph of Life Cocoon", "=ds=#sr# 320", "=ds="..AL["Trainer"] };
				{ 25, "s112450", "87894", "=q1=Glyph of Leer of the Ox", "=ds=#sr# 295", "=ds="..AL["Trainer"] };
				{ 26, "s112457", "87893", "=q1=Glyph of Fortifying Brew", "=ds=#sr# 255", "=ds="..AL["Trainer"] };
				{ 27, "s112437", "87880", "=q1=Glyph of Nimble Brew", "=ds=#sr# 220", "=ds="..AL["Trainer"] };
				{ 28, "s112451", "87891", "=q1=Glyph of Afterlife", "=ds=#sr# 155", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 2, "s132167", "90715", "=q1=Glyph of Blackout Kick", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 3, "s112464", "87883", "=q1=Glyph of Honor", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 4, "s112465", "87884", "=q1=Glyph of Jab", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 5, "s112466", "87885", "=q1=Glyph of Rising Tiger Kick", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 6, "s124454", "85698", "=q1=Glyph of Spinning Fire Blossom", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 7, "s112468", "87887", "=q1=Glyph of Spirit Roll", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 17, "s112461", "87889", "=q1=Glyph of Water Roll", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 18, "s112460", "87890", "=q1=Glyph of Zen Flight", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 19, "s112463", "87882", "=q1=Glyph of Flying Serpent Kick", "=ds=#sr# 495", "=ds="..AL["Trainer"] };
				{ 20, "s112469", "87888", "=q1=Glyph of Fighting Pose", "=ds=#sr# 490", "=ds="..AL["Trainer"] };
				{ 21, "s112462", "87881", "=q1=Glyph of Crackling Tiger Lightning", "=ds=#sr# 485", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["MONK"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Paladin"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s122030", "83107", "=q1=Glyph of Mass Exorcism", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 3, "s119481", "81956", "=q1=Glyph of the Battle Healer", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 4, "s148259", "104050", "=q1=Glyph of Divine Shield", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 5, "s148260", "104051", "=q1=Glyph of Hand of Sacrifice", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 6, "s64277", "45741", "=q1=Glyph of Beacon of Light", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s64305", "45745", "=q1=Glyph of Divine Plea", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 8, "s64279", "45743", "=q1=Glyph of Divine Storm", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 9, "s64278", "45742", "=q1=Glyph of Hammer of the Righteous", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 10, "s64254", "45746", "=q1=Glyph of Holy Shock", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 11, "s64251", "45747", "=q1=Glyph of Inquisition", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 12, "s64308", "45744", "=q1=Glyph of the Alabaster Shield", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 13, "s95825", "66918", "=q1=Glyph of Protector of the Innocent", "=ds=#sr# 390", "=ds="..GetSpellInfo(61177) };
				{ 14, "s57034", "41110", "=q1=Glyph of Blessed Life", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 15, "s59560", "43868", "=q1=Glyph of Dazing Shield", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 17, "s59559", "43867", "=q1=Glyph of Denounce", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 18, "s57019", "41101", "=q1=Glyph of Focused Shield", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 19, "s59561", "43869", "=q1=Glyph of Immediate Truth", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 20, "s57035", "41109", "=q1=Glyph of Light of Dawn", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 21, "s57028", "41097", "=q1=Glyph of Templar's Verdict", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 22, "s57021", "41107", "=q1=Glyph of the Harsh Word", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 23, "s57036", "41102", "=q1=Glyph of Turn Evil", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 24, "s57033", "41094", "=q1=Glyph of Devotion Aura", "=ds=#sr# 335", "=ds="..AL["Trainer"] };
				{ 25, "s57026", "41105", "=q1=Glyph of Word of Glory", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 26, "s57025", "41103", "=q1=Glyph of Blinding Light", "=ds=#sr# 265", "=ds="..AL["Trainer"] };
				{ 27, "s57024", "41098", "=q1=Glyph of Avenging Wrath", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
				{ 28, "s57023", "41099", "=q1=Glyph of Consecration", "=ds=#sr# 205", "=ds="..AL["Trainer"] };
				{ 29, "s57020", "41104", "=q1=Glyph of Final Wrath", "=ds=#sr# 180", "=ds="..AL["Trainer"] };
				{ 30, "s57031", "41108", "=q1=Glyph of Divinity", "=ds=#sr# 135", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s57030", "41092", "=q1=Glyph of Double Jeopardy", "=ds=#sr# 120", "=ds="..AL["Trainer"] };
				{ 3, "s57029", "41106", "=q1=Glyph of Illumination", "=ds=#sr# 105", "=ds="..AL["Trainer"] };
				{ 4, "s57027", "41095", "=q1=Glyph of Holy Wrath", "=ds=#sr# 90", "=ds="..AL["Trainer"] };
				{ 17, "s57022", "41096", "=q1=Glyph of Divine Protection", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 18, "s58313", "43367", "=q1=Glyph of Flash of Light", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 6, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 7, "s112266", "80586", "=q1=Glyph of Bladed Judgment", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 8, "s57037", "80581", "=q1=Glyph of Focused Wrath", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 9, "s112265", "80585", "=q1=Glyph of Righteous Retreat", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 10, "s112264", "80584", "=q1=Glyph of the Falling Avenger", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 11, "s148274", "104108", "=q1=Glyph of Pillar of Light", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Foreboding Flame"].."/"..ALIL["Spirit of Jadefire"]..", =ds="..ALIL["Timeless Isle"] };
				{ 12, "s148273", "104107", "=q1=Glyph of the Exorcist", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 22, "s57032", "41100", "=q1=Glyph of the Luminous Charger", "=ds=#sr# 155", "=ds="..GetSpellInfo(61288) };
				{ 23, "s58311", "43365", "=q1=Glyph of Contemplation", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 24, "s58316", "43369", "=q1=Glyph of Fire From the Heavens", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 25, "s58315", "43368", "=q1=Glyph of Seal of Blood", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 26, "s58314", "43340", "=q1=Glyph of the Mounted King", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 27, "s58312", "43366", "=q1=Glyph of Winged Vengeance", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Priest"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s124461", "79514", "=q1=Glyph of Shadow Word: Death", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 3, "s124460", "79515", "=q1=Glyph of Vampiric Embrace", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 4, "s124459", "79513", "=q1=Glyph of Mind Flay", "=ds=#sr# 455", "=ds="..AL["Trainer"] };
				{ 5, "s64280", "45753", "=q1=Glyph of Dispersion", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 6, "s64309", "45757", "=q1=Glyph of Focused Mending", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s64281", "45755", "=q1=Glyph of Leap of Faith", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 8, "s64283", "45758", "=q1=Glyph of Mind Spike", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 9, "s64282", "45756", "=q1=Glyph of Penance", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 10, "s57181", "42396", "=q1=Glyph of Circle of Healing", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s57189", "42403", "=q1=Glyph of Lightwell", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 12, "s57190", "42404", "=q1=Glyph of Mass Dispel", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 13, "s57199", "42414", "=q1=Glyph of Mind Blast", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 14, "s57202", "42417", "=q1=Glyph of Prayer of Mending", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 15, "s57191", "42405", "=q1=Glyph of Psychic Horror", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 17, "s57195", "42409", "=q1=Glyph of Spirit of Redemption", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 18, "s57193", "42407", "=q1=Glyph of Weakened Soul", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 19, "s57198", "42412", "=q1=Glyph of Scourge Imprisonment", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 20, "s57192", "42406", "=q1=Glyph of Holy Fire", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 21, "s57187", "42401", "=q1=Glyph of Holy Nova", "=ds=#sr# 315", "=ds="..AL["Trainer"] };
				{ 22, "s57185", "42399", "=q1=Glyph of Fear Ward", "=ds=#sr# 270", "=ds="..AL["Trainer"] };
				{ 23, "s64259", "45760", "=q1=Glyph of Binding Heal", "=ds=#sr# 255", "=ds="..AL["Trainer"] };
				{ 24, "s127625", "87902", "=q1=Glyph of Lightspring", "=ds=#sr# 255", "=ds="..AL["Trainer"] };
				{ 25, "s57183", "42397", "=q1=Glyph of Purify", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
				{ 26, "s57201", "42416", "=q1=Glyph of Smite", "=ds=#sr# 210", "=ds="..AL["Trainer"] };
				{ 27, "s57200", "42415", "=q1=Glyph of Dispel Magic", "=ds=#sr# 180", "=ds="..AL["Trainer"] };
				{ 28, "s57197", "42411", "=q1=Glyph of Renew", "=ds=#sr# 160", "=ds="..AL["Trainer"] };
				{ 29, "s57188", "42402", "=q1=Glyph of Inner Fire", "=ds=#sr# 135", "=ds="..AL["Trainer"] };
				{ 30, "s57186", "42400", "=q1=Glyph of Inner Sanctum", "=ds=#sr# 120", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s57184", "42398", "=q1=Glyph of Fade", "=ds=#sr# 105", "=ds="..AL["Trainer"] };
				{ 3, "s57196", "42410", "=q1=Glyph of Psychic Scream", "=ds=#sr# 95", "=ds="..AL["Trainer"] };
				{ 4, "s57194", "42408", "=q1=Glyph of Power Word: Shield", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 17, "s58319", "43370", "=q1=Glyph of Levitate", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 18, "s58321", "43372", "=q1=Glyph of Reflective Shield", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 6, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 7, "s126153", "86541", "=q1=Glyph of Confession", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 8, "s126687", "87276", "=q1=Glyph of Holy Resurrection", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 9, "s126800", "87392", "=q1=Glyph of Shadowy Friends", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 10, "s124466", "79538", "=q1=Glyph of the Heavens", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 11, "s126696", "87277", "=q1=Glyph of the Val'kyr", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 12, "s148275", "104109", "=q1=Glyph of Angels", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 13, "s148278", "104122", "=q1=Glyph of Inspired Hymns", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Windfeather Nestkeeper"]..", =ds="..ALIL["Timeless Isle"] };
				{ 22, "s148277", "104121", "=q1=Glyph of Shifted Appearances", "=ds=#sr# 500", "=ds="..AL["Vendor"]..": "..ALIL["Timeless Isle"] };
				{ 23, "s148276", "104120", "=q1=Glyph of the Sha", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 24, "s107907", "77101", "=q1=Glyph of Shadow", "=ds=#sr# 105", "=ds="..GetSpellInfo(61288) };
				{ 25, "s58322", "43374", "=q1=Glyph of Dark Archangel", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 26, "s58320", "43373", "=q1=Glyph of Shackle Undead", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 27, "s58318", "43371", "=q1=Glyph of Borrowed Time", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 28, "s58317", "43342", "=q1=Glyph of Shadow Ravens", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s64303", "45769", "=q1=Glyph of Cloak of Shadows", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 3, "s64315", "45766", "=q1=Glyph of Deadly Momentum", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 4, "s64286", "45764", "=q1=Glyph of Stealth", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 5, "s94711", "63420", "=q1=Glyph of Vanish", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 6, "s64284", "45761", "=q1=Glyph of Vendetta", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s57115", "42957", "=q1=Glyph of Blade Flurry", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 8, "s57128", "42969", "=q1=Glyph of Cheap Shot", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 9, "s57130", "42971", "=q1=Glyph of Kick", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 10, "s57117", "42959", "=q1=Glyph of Recuperate", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s57112", "42954", "=q1=Glyph of Shadow Walk", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 12, "s57116", "42958", "=q1=Glyph of Sharp Knives", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 13, "s57127", "42968", "=q1=Glyph of Smoke Bomb", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 17, "s57113", "42955", "=q1=Glyph of Ambush", "=ds=#sr# 340", "=ds="..AL["Trainer"] };
				{ 18, "s57122", "42963", "=q1=Glyph of Feint", "=ds=#sr# 305", "=ds="..AL["Trainer"] };
				{ 19, "s57133", "42974", "=q1=Glyph of Sprint", "=ds=#sr# 285", "=ds="..AL["Trainer"] };
				{ 20, "s57132", "42973", "=q1=Glyph of Shiv", "=ds=#sr# 235", "=ds="..AL["Trainer"] };
				{ 21, "s57131", "42972", "=q1=Glyph of Redirect", "=ds=#sr# 210", "=ds="..AL["Trainer"] };
				{ 22, "s57129", "42970", "=q1=Glyph of Hemorrhaging Veins", "=ds=#sr# 185", "=ds="..AL["Trainer"] };
				{ 23, "s92579", "64493", "=q1=Glyph of Blind", "=ds=#sr# 180", "=ds="..AL["Trainer"] };
				{ 24, "s57125", "42966", "=q1=Glyph of Gouge", "=ds=#sr# 160", "=ds="..AL["Trainer"] };
				{ 25, "s57123", "42964", "=q1=Glyph of Garrote", "=ds=#sr# 135", "=ds="..AL["Trainer"] };
				{ 26, "s57121", "42962", "=q1=Glyph of Expose Armor", "=ds=#sr# 120", "=ds="..AL["Trainer"] };
				{ 27, "s57120", "42961", "=q1=Glyph of Recovery", "=ds=#sr# 105", "=ds="..AL["Trainer"] };
				{ 28, "s57119", "42960", "=q1=Glyph of Evasion", "=ds=#sr# 95", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 2, "s148279", "104123", "=q1=Glyph of Headhunting", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Burning Berserker"]..", =ds="..ALIL["Timeless Isle"] };
				{ 3, "s148280", "104124", "=q1=Glyph of Improved Distraction", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 4, "s64285", "45762", "=q1=Glyph of Killing Spree", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 5, "s64310", "45767", "=q1=Glyph of Tricks of the Trade", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 6, "s57124", "42965", "=q1=Glyph of Detection", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 7, "s57126", "42967", "=q1=Glyph of Hemorrhage", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 8, "s64260", "45768", "=q1=Glyph of Disguise", "=ds=#sr# 255", "=ds="..AL["Trainer"] };
				{ 17, "s57114", "42956", "=q1=Glyph of Decoy", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 18, "s58323", "43379", "=q1=Glyph of Blurred Speed", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 19, "s58324", "43376", "=q1=Glyph of Distract", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 20, "s58325", "43377", "=q1=Glyph of Pick Lock", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 21, "s58326", "43343", "=q1=Glyph of Pick Pocket", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 22, "s58328", "43380", "=q1=Glyph of Poisons", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 23, "s58327", "43378", "=q1=Glyph of Safe Fall", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Shaman"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s148262", "104053", "=q1=Glyph of Eternal Earth", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 3, "s148261", "104052", "=q1=Glyph of Purging", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 4, "s64288", "45771", "=q1=Glyph of Feral Spirit", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 5, "s64316", "45777", "=q1=Glyph of Hex", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 6, "s101057", "71155", "=q1=Glyph of Lightning Shield", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s64289", "45772", "=q1=Glyph of Riptide", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 8, "s64287", "45770", "=q1=Glyph of Thunder", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 9, "s64247", "45778", "=q1=Glyph of Totemic Vigor", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 10, "s57235", "41526", "=q1=Glyph of Capacitor Totem", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s57233", "41518", "=q1=Glyph of Chain Lightning", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 12, "s57250", "41552", "=q1=Glyph of Chaining", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 13, "s57237", "41529", "=q1=Glyph of Fire Elemental Totem", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 14, "s57247", "41538", "=q1=Glyph of Grounding Totem", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 15, "s57243", "41534", "=q1=Glyph of Healing Wave", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 17, "s57234", "41524", "=q1=Glyph of Spirit Walk", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 18, "s57232", "41517", "=q1=Glyph of Unstable Earth", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 19, "s57248", "41539", "=q1=Glyph of Spiritwalker's Grace", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 20, "s57252", "41542", "=q1=Glyph of Cleansing Waters", "=ds=#sr# 330", "=ds="..AL["Trainer"] };
				{ 21, "s57236", "41527", "=q1=Glyph of Purge", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 22, "s57251", "41541", "=q1=Glyph of Water Shield", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 23, "s64262", "45776", "=q1=Glyph of Shamanistic Rage", "=ds=#sr# 255", "=ds="..AL["Trainer"] };
				{ 24, "s57244", "41535", "=q1=Glyph of Totemic Recall", "=ds=#sr# 235", "=ds="..AL["Trainer"] };
				{ 25, "s57242", "41533", "=q1=Glyph of Healing Stream Totem", "=ds=#sr# 215", "=ds="..AL["Trainer"] };
				{ 26, "s57241", "41547", "=q1=Glyph of Frost Shock", "=ds=#sr# 185", "=ds="..AL["Trainer"] };
				{ 27, "s57245", "41536", "=q1=Glyph of Telluric Currents", "=ds=#sr# 140", "=ds="..AL["Trainer"] };
				{ 28, "s57240", "41532", "=q1=Glyph of Wind Shear", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 29, "s57238", "41530", "=q1=Glyph of Fire Nova", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 30, "s57239", "41531", "=q1=Glyph of Flame Shock", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s59326", "43725", "=q1=Glyph of Ghost Wolf", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 17, "s58331", "43344", "=q1=Glyph of Healing Storm", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 4, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 5, "s148287", "104133", "=q1=Glyph of Astral Fixation", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 6, "s148286", "104131", "=q1=Glyph of Elemental Familiars", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 7, "s148284", "104129", "=q1=Glyph of Flaming Serpent", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 8, "s148282", "104127", "=q1=Glyph of Lingering Ancestors", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Timeless Isle"] };
				{ 9, "s148288", "104134", "=q1=Glyph of Rain of Frogs", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Bufo"].."/"..ALIL["Gulp Frog"]..", =ds="..ALIL["Timeless Isle"] };
				{ 10, "s148281", "104126", "=q1=Glyph of Spirit Raptors", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 11, "s148283", "104128", "=q1=Glyph of Spirit Wolf", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 12, "s148285", "104130", "=q1=Glyph of the Compy", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 20, "s64261", "45775", "=q1=Glyph of Deluge", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 21, "s57249", "41540", "=q1=Glyph of Lava Lash", "=ds=#sr# 165", "=ds="..AL["Trainer"] };
				{ 22, "s57246", "41537", "=q1=Glyph of the Lakestrider", "=ds=#sr# 95", "=ds="..AL["Trainer"] };
				{ 23, "s58329", "43381", "=q1=Glyph of Astral Recall", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 24, "s58330", "43385", "=q1=Glyph of Far Sight", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 25, "s58332", "43386", "=q1=Glyph of the Spectral Wolf", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 26, "s57253", "44923", "=q1=Glyph of Thunderstorm", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 27, "s58333", "43388", "=q1=Glyph of Totemic Encirclement", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s64318", "45780", "=q1=Glyph of Demon Hunting", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 3, "s64317", "45782", "=q1=Glyph of Demonic Circle", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 4, "s64291", "45779", "=q1=Glyph of Drain Life", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 5, "s64294", "45781", "=q1=Glyph of Ember Tap", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 6, "s64248", "45785", "=q1=Glyph of Life Tap", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s64311", "45783", "=q1=Glyph of Unending Resolve", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 8, "s57258", "42454", "=q1=Glyph of Conflagrate", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 9, "s57268", "42464", "=q1=Glyph of Curse of the Elements", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 10, "s57264", "42460", "=q1=Glyph of Demon Training", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s57276", "42472", "=q1=Glyph of Unstable Affliction", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 17, "s71102", "50077", "=q1=Glyph of Eternal Resolve", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 18, "s57274", "42470", "=q1=Glyph of Soulstone", "=ds=#sr# 240", "=ds="..AL["Trainer"] };
				{ 19, "s57270", "42466", "=q1=Glyph of Havoc", "=ds=#sr# 215", "=ds="..AL["Trainer"] };
				{ 20, "s57269", "42465", "=q1=Glyph of Imp Swarm", "=ds=#sr# 140", "=ds="..AL["Trainer"] };
				{ 21, "s57262", "42458", "=q1=Glyph of Fear", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 22, "s57266", "42462", "=q1=Glyph of Healthstone", "=ds=#sr# 95", "=ds="..AL["Trainer"] };
				{ 23, "s57259", "42455", "=q1=Glyph of Siphon Life", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
				{ 24, "s58338", "43392", "=q1=Glyph of Curse of Exhaustion", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 25, "s58337", "43390", "=q1=Glyph of Soul Consumption", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 2, "s135561", "93202", "=q1=Glyph of Gateway Attunement", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 3, "s64250", "45789", "=q1=Glyph of Crimson Banish", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 4, "s57263", "42459", "=q1=Glyph of Felguard", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 5, "s57261", "42457", "=q1=Glyph of Nightmares", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 6, "s57267", "42463", "=q1=Glyph of Subtlety", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 7, "s57260", "42456", "=q1=Glyph of Verdant Spheres", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 8, "s57257", "42453", "=q1=Glyph of Hand of Gul'dan", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 9, "s57275", "42471", "=q1=Glyph of Carrion Swarm", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 17, "s57277", "42473", "=q1=Glyph of Falling Meteor", "=ds=#sr# 190", "=ds="..AL["Trainer"] };
				{ 18, "s57271", "42467", "=q1=Glyph of Shadow Bolt", "=ds=#sr# 165", "=ds="..AL["Trainer"] };
				{ 19, "s57265", "42461", "=q1=Glyph of Health Funnel", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 20, "s58339", "43393", "=q1=Glyph of Enslave Demon", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 21, "s58340", "43391", "=q1=Glyph of Eye of Kilrogg", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 22, "s58341", "43394", "=q1=Glyph of Soulwell", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 23, "s58336", "43389", "=q1=Glyph of Unending Breath", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

	AtlasLoot_Data["Inscription_Warrior"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s122015", "83096", "=q1=Glyph of Incite", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 3, "s148264", "104055", "=q1=Glyph of Impaling Throws", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Eternal Kilnmaster"]..", =ds="..ALIL["Timeless Isle"] };
				{ 4, "s148265", "104056", "=q1=Glyph of the Executor", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 5, "s89815", "63481", "=q1=Glyph of Colossus Smash", "=ds=#sr# 465", "=ds="..AL["Trainer"] };
				{ 6, "s64296", "45792", "=q1=Glyph of Death From Above", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 7, "s64252", "45797", "=q1=Glyph of Shield Wall", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 8, "s64302", "45795", "=q1=Glyph of Spell Reflection", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 9, "s64295", "45790", "=q1=Glyph of Whirlwind", "=ds=#sr# 430", "=ds="..GetSpellInfo(61177) };
				{ 10, "s57159", "43419", "=q1=Glyph of Blitz", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 11, "s57155", "43415", "=q1=Glyph of Heavy Repercussions", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 12, "s57160", "43421", "=q1=Glyph of Mortal Strike", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 13, "s57164", "43430", "=q1=Glyph of Resonating Power", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 14, "s57152", "43425", "=q1=Glyph of Shield Slam", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 15, "s57170", "43431", "=q1=Glyph of Victory Rush", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 17, "s64255", "45793", "=q1=Glyph of Victorious Throw", "=ds=#sr# 355", "=ds="..GetSpellInfo(61177) };
				{ 18, "s57172", "43432", "=q1=Glyph of Raging Wind", "=ds=#sr# 345", "=ds="..AL["Trainer"] };
				{ 19, "s57168", "43428", "=q1=Glyph of Sweeping Strikes", "=ds=#sr# 320", "=ds="..AL["Trainer"] };
				{ 20, "s57156", "43416", "=q1=Glyph of Bloodthirst", "=ds=#sr# 285", "=ds="..AL["Trainer"] };
				{ 21, "s94406", "67482", "=q1=Glyph of Bull Rush", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 22, "s57154", "43414", "=q1=Glyph of Hindering Strikes", "=ds=#sr# 240", "=ds="..AL["Trainer"] };
				{ 23, "s57165", "43424", "=q1=Glyph of Hold the Line", "=ds=#sr# 190", "=ds="..AL["Trainer"] };
				{ 24, "s57161", "43422", "=q1=Glyph of Die by the Sword", "=ds=#sr# 170", "=ds="..AL["Trainer"] };
				{ 25, "s94405", "67483", "=q1=Glyph of Recklessness", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 26, "s57167", "43427", "=q1=Glyph of Hoarse Voice", "=ds=#sr# 140", "=ds="..AL["Trainer"] };
				{ 27, "s57157", "43417", "=q1=Glyph of Rude Interruption", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 28, "s57163", "43423", "=q1=Glyph of Hamstring", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 29, "s57158", "43418", "=q1=Glyph of Gag Order", "=ds=#sr# 95", "=ds="..AL["Trainer"] };
				{ 30, "s57162", "43413", "=q1=Glyph of Enraged Speed", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Major Glyph"], "" };
				{ 2, "s58344", "43397", "=q1=Glyph of Long Charge", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 17, "s58346", "43399", "=q1=Glyph of Unending Rage", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 4, 0, "INV_Box_01", "=q6="..AL["Minor Glyph"], "" };
				{ 5, "s112430", "80588", "=q1=Glyph of Burning Anger", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 6, "s112429", "80587", "=q1=Glyph of Crow Feast", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 7, "s123781", "85221", "=q1=Glyph of the Blazing Trail", "=ds=#sr# 595", "=ds="..GetSpellInfo(112996) };
				{ 8, "s148289", "104135", "=q1=Glyph of the Raging Whirlwind", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 9, "s148290", "104136", "=q1=Glyph of the Subtle Defender", "=ds=#sr# 500", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"] };
				{ 10, "s148291", "104137", "=q1=Glyph of the Watchful Eye", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Ordon Oathguard"]..", =ds="..ALIL["Timeless Isle"] };
				{ 11, "s148292", "104138", "=q1=Glyph of the Weaponmaster", "=ds=#sr# 500", "=ds="..AL["Drop"]..": =q2="..ALIL["Jakur of Ordon"]..", =ds="..ALIL["Timeless Isle"] };
				{ 20, "s57153", "43412", "=q1=Glyph of Bloody Healing", "=ds=#sr# 385", "=ds="..GetSpellInfo(61177) };
				{ 21, "s64312", "45794", "=q1=Glyph of Intimidating Shout", "=ds=#sr# 355", "=ds="..GetSpellInfo(61288) };
				{ 22, "s58343", "43396", "=q1=Glyph of Bloodcurdling Shout", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 23, "s58345", "43398", "=q1=Glyph of Gushing Wound", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 24, "s58347", "43400", "=q1=Glyph of Mighty Victory", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 25, "s58342", "43395", "=q1=Glyph of Mystic Shout", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
				{ 26, "s68166", "49084", "=q1=Glyph of Thunder Strike", "=ds=#sr# 75", "=ds="..GetSpellInfo(61288) };
			};
		};
		info = {
			name = INSCRIPTION..": "..BabbleInventory["Glyph"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			module = moduleName, menu = "INSCRIPTIONMENU"
		};
	};

		---------------------
		--- Jewelcrafting ---
		---------------------

	AtlasLoot_Data["JewelRed"] ={
		["Normal"] = {
			{
				{ 1, "s107705", "76696", "=q3=Bold Primordial Ruby", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131686) };
				{ 2, "s107706", "76694", "=q3=Brilliant Primordial Ruby", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131686) };
				{ 3, "s107707", "76692", "=q3=Delicate Primordial Ruby", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131686) };
				{ 4, "s107708", "76695", "=q3=Flashing Primordial Ruby", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131686) };
				{ 5, "s107709", "76693", "=q3=Precise Primordial Ruby", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131686) };
				{ 7, "s107622", "76564", "=q2=Bold Pandarian Garnet", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 8, "s107623", "76562", "=q2=Brilliant Pandarian Garnet", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 9, "s107625", "76563", "=q2=Flashing Pandarian Garnet", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 10, "s107626", "76561", "=q2=Precise Pandarian Garnet", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 11, "s107622", "76560", "=q2=Delicate Pandarian Garnet", "=ds=#sr# 530", "=ds="..AL["Trainer"] };
				{ 16, "s101799", "71883", "=q4=Bold Queen's Garnet", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 17, "s101797", "71881", "=q4=Brilliant Queen's Garnet", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 18, "s101795", "71879", "=q4=Delicate Queen's Garnet", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 19, "s101798", "71882", "=q4=Flashing Queen's Garnet", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 20, "s101796", "71880", "=q4=Precise Queen's Garnet", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 21, "s73335", "52206", "=q3=Bold Inferno Ruby", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 22, "s73338", "52207", "=q3=Brilliant Inferno Ruby", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 23, "s73336", "52212", "=q3=Delicate Inferno Ruby", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 24, "s73337", "52216", "=q3=Flashing Inferno Ruby", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 25, "s73339", "52230", "=q3=Precise Inferno Ruby", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 26, "s73222", "52081", "=q2=Bold Carnelian", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 27, "s73225", "52084", "=q2=Brilliant Carnelian", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 28, "s73223", "52082", "=q2=Delicate Carnelian", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 29, "s73224", "52083", "=q2=Flashing Carnelian", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 30, "s73226", "52085", "=q2=Precise Carnelian", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s66447", "40111", "=q4=Bold Cardinal Ruby", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 2, "s66446", "40113", "=q4=Brilliant Cardinal Ruby", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s66448", "40112", "=q4=Delicate Cardinal Ruby", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 4, "s66453", "40116", "=q4=Flashing Cardinal Ruby", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 5, "s66450", "40118", "=q4=Precise Cardinal Ruby", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 6, "s53830", "39996", "=q3=Bold Scarlet Ruby", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 7, "s53946", "39998", "=q3=Brilliant Scarlet Ruby", "=ds=#sr# 390", "=ds="..ALIL["Kirin Tor"].." - "..AL["Exalted"] };
				{ 8, "s53945", "39997", "=q3=Delicate Scarlet Ruby", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 9, "s53949", "40001", "=q3=Flashing Scarlet Ruby", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 10, "s53951", "40003", "=q3=Precise Scarlet Ruby", "=ds=#sr# 390", "=ds="..AtlasLoot:EJ_GetBossName("Herald Volazj", 584).." ("..AL["Heroic"]..")" };
				{ 11, "s53831", "39900", "=q2=Bold Bloodstone", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 12, "s53852", "39912", "=q2=Brilliant Bloodstone", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 13, "s53832", "39905", "=q2=Delicate Bloodstone", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 14, "s53844", "39908", "=q2=Flashing Bloodstone", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 15, "s54017", "39910", "=q2=Precise Bloodstone", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 16, "s39705", "32193", "=q4=Bold Crimson Spinel", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Friendly"] };
				{ 17, "s39711", "32196", "=q4=Brilliant Crimson Spinel", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Friendly"] };
				{ 18, "s39706", "32194", "=q4=Delicate Crimson Spinel", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Friendly"] };
				{ 19, "s39714", "32199", "=q4=Flashing Crimson Spinel", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 20, "s42589", "33131", "=q4=Crimson Sun", "=ds=#sr# 360", "=ds="..ALIL["The Consortium"].." - "..AL["Revered"] };
				{ 21, "s42558", "33133", "=q4=Don Julio's Heart", "=ds=#sr# 360", "=ds="..ALIL["The Consortium"].." - "..AL["Revered"] };
				{ 22, "s42588", "33134", "=q4=Kailee's Rose", "=ds=#sr# 360", "=ds="..ALIL["The Sha'tar"].." - "..AL["Honored"] };
				{ 23, "s31084", "24027", "=q3=Bold Living Ruby", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 24, "s31088", "24030", "=q3=Brilliant Living Ruby", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 25, "s31085", "24028", "=q3=Delicate Living Ruby", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 26, "s31091", "24036", "=q3=Flashing Living Ruby", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 27, "s28905", "23095", "=q2=Bold Blood Garnet", "=ds=#sr# 305", "=ds="..AL["Trainer"] };
				{ 28, "s28903", "23094", "=q2=Brilliant Blood Garnet", "=ds=#sr# 305", "=ds="..ALIL["The Scryers"].." - "..AL["Friendly"] };
				{ 29, "s34590", "28595", "=q2=Delicate Blood Garnet", "=ds=#sr# 305", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Red"].." "..BabbleInventory["Gem"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelBlue"] = {
		["Normal"] = {
			{
				{ 1, "s106947", "76636", "=q3=Rigid River's Heart", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131593) };
				{ 2, "s106950", "76639", "=q3=Solid River's Heart", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131593) };
				{ 3, "s106949", "76638", "=q3=Sparkling River's Heart", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131593) };
				{ 4, "s106948", "76637", "=q3=Stormy River's Heart", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131593) };
				{ 6, "s107621", "76504", "=q2=Stormy Lapis Lazuli", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 7, "s107620", "76505", "=q2=Sparkling Lapis Lazuli", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 8, "s107619", "76506", "=q2=Solid Lapis Lazuli", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 9, "s107617", "76502", "=q2=Rigid Lapis Lazuli", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 16, "s101735", "71817", "=q4=Rigid Deepholm Iolite", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 17, "s101742", "71820", "=q4=Solid Deepholm Iolite", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 18, "s101741", "71819", "=q4=Sparkling Deepholm Iolite", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 19, "s101740", "71818", "=q4=Stormy Deepholm Iolite", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 21, "s73344", "52235", "=q3=Rigid Ocean Sapphire", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 22, "s73340", "52242", "=q3=Solid Ocean Sapphire", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 23, "s73341", "52244", "=q3=Sparkling Ocean Sapphire", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 24, "s73343", "52246", "=q3=Stormy Ocean Sapphire", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 26, "s73230", "52089", "=q2=Rigid Zephyrite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 27, "s73227", "52086", "=q2=Solid Zephyrite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 28, "s73228", "52087", "=q2=Sparkling Zephyrite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 29, "s73229", "52088", "=q2=Stormy Zephyrite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
			};
			{
				{ 1, "s66501", "40125", "=q4=Rigid Majestic Zircon", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 2, "s66497", "40119", "=q4=Solid Majestic Zircon", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s66498", "40120", "=q4=Sparkling Majestic Zircon", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 4, "s66499", "40122", "=q4=Stormy Majestic Zircon", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 6, "s53958", "40014", "=q3=Rigid Sky Sapphire", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 7, "s53952", "40008", "=q3=Solid Sky Sapphire", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 8, "s53954", "40010", "=q3=Sparkling Sky Sapphire", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 9, "s53955", "40011", "=q3=Stormy Sky Sapphire", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
				{ 11, "s53854", "39915", "=q2=Rigid Chalcedony", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 12, "s53934", "39919", "=q2=Solid Chalcedony", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 13, "s53941", "39927", "=q2=Sparkling Chalcedony", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 14, "s53943", "39932", "=q2=Stormy Chalcedony", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s39721", "32206", "=q4=Rigid Empyrean Sapphire", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 17, "s39715", "32200", "=q4=Solid Empyrean Sapphire", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Friendly"] };
				{ 18, "s39716", "32201", "=q4=Sparkling Empyrean Sapphire", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Friendly"] };
				{ 19, "s39718", "32203", "=q4=Stormy Empyrean Sapphire", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 20, "s42590", "33135", "=q4=Falling Star", "=ds=#sr# 360", "=ds="..ALIL["Lower City"].." - "..AL["Revered"] };
				{ 22, "s31098", "24051", "=q3=Rigid Star of Elune", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 23, "s31092", "24033", "=q3=Solid Star of Elune", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 24, "s31149", "24035", "=q3=Sparkling Star of Elune", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 25, "s31095", "24039", "=q3=Stormy Star of Elune", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 27, "s28948", "23116", "=q2=Rigid Azure Moonstone", "=ds=#sr# 325", "=ds="..AL["Trainer"]};
				{ 28, "s28955", "23120", "=q2=Stormy Azure Moonstone", "=ds=#sr# 315", "=ds="..AL["World Drop"]};
				{ 29, "s28950", "23118", "=q2=Solid Azure Moonstone", "=ds=#sr# 305", "=ds="..AL["Trainer"]};
				{ 30, "s28953", "23119", "=q2=Sparkling Azure Moonstone", "=ds=#sr# 300", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Blue"].." "..BabbleInventory["Gem"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelYellow"] = {
		["Normal"] = {
			{
				{ 1, "s107710", "76700", "=q3=Fractured Sun's Radiance", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131695) };
				{ 2, "s107711", "76701", "=q3=Mystic Sun's Radiance", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131695) };
				{ 3, "s107712", "76699", "=q3=Quick Sun's Radiance", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131695) };
				{ 4, "s107713", "76697", "=q3=Smooth Sun's Radiance", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131695) };
				{ 5, "s107714", "76698", "=q3=Subtle Sun's Radiance", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131695) };
				{ 7, "s107644", "76566", "=q2=Subtle Sunstone", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 8, "s107643", "76565", "=q2=Smooth Sunstone", "=ds=#sr# 565", "=ds="..AL["Trainer"] };
				{ 9, "s107642", "76567", "=q2=Quick Sunstone", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 10, "s107641", "76569", "=q2=Mystic Sunstone", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 11, "s107640", "76568", "=q2=Fractured Sunstone", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 16, "s101803", "71877", "=q4=Fractured Lightstone", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 17, "s101804", "71878", "=q4=Mystic Lightstone", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 18, "s101802", "71876", "=q4=Quick Lightstone", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 19, "s101800", "71874", "=q4=Smooth Lightstone", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 20, "s101801", "71875", "=q4=Subtle Lightstone", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 21, "s73349", "52219", "=q3=Fractured Amberjewel", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 22, "s73347", "52226", "=q3=Mystic Amberjewel", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 23, "s73348", "52232", "=q3=Quick Amberjewel", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 24, "s73346", "52241", "=q3=Smooth Amberjewel", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 25, "s73345", "52247", "=q3=Subtle Amberjewel", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 26, "s73239", "52094", "=q2=Fractured Alicite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 27, "s73234", "52093", "=q2=Quick Alicite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 28, "s73232", "52091", "=q2=Smooth Alicite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 29, "s73231", "52090", "=q2=Subtle Alicite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
			};
			{
				{ 1, "s66505", "40127", "=q4=Mystic King's Amber", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 2, "s66506", "40128", "=q4=Quick King's Amber", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s66502", "40124", "=q4=Smooth King's Amber", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 4, "s66452", "40115", "=q4=Subtle King's Amber", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 6, "s53960", "40016", "=q3=Mystic Autumn's Glow", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
				{ 7, "s53961", "40017", "=q3=Quick Autumn's Glow", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 8, "s53957", "40013", "=q3=Smooth Autumn's Glow", "=ds=#sr# 390", "=ds="..ALIL["The Sons of Hodir"].." - "..AL["Exalted"] };
				{ 9, "s53948", "40000", "=q3=Subtle Autumn's Glow", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 11, "s53857", "39917", "=q2=Mystic Sun Crystal", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 12, "s53856", "39918", "=q2=Quick Sun Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 13, "s53845", "39909", "=q2=Smooth Sun Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 14, "s53843", "39907", "=q2=Subtle Sun Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 16, "s39724", "32209", "=q4=Mystic Lionseye", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 17, "s47056", "35761", "=q4=Quick Lionseye", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 18, "s39720", "32205", "=q4=Smooth Lionseye", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Friendly"] };
				{ 19, "s39713", "32198", "=q4=Subtle Lionseye", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Friendly"] };
				{ 20, "s42592", "33140", "=q4=Blood of Amber", "=ds=#sr# 360", "=ds="..ALIL["The Sha'tar"].." - "..AL["Revered"] };
				{ 21, "s42593", "33144", "=q4=Facet of Eternity", "=ds=#sr# 360", "=ds="..ALIL["Keepers of Time"].." - "..AL["Honored"] };
				{ 22, "s42591", "33143", "=q4=Stone of Blades", "=ds=#sr# 360", "=ds="..ALIL["Keepers of Time"].." - "..AL["Revered"] };
				{ 24, "s31101", "24053", "=q3=Mystic Dawnstone", "=ds=#sr# 350", "=ds="..AL["Vendor"]..": "..ALIL["Nagrand"] };
				{ 25, "s46403", "35315", "=q3=Quick Dawnstone", "=ds=#sr# 350", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 26, "s31097", "24048", "=q3=Smooth Dawnstone", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 27, "s31090", "24032", "=q3=Subtle Dawnstone", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 29, "s28944", "23114", "=q2=Smooth Golden Draenite", "=ds=#sr# 325", "=ds="..ALIL["The Aldor"].." - "..AL["Friendly"] };
				{ 30, "s28947", "23115", "=q2=Subtle Golden Draenite", "=ds=#sr# 315", "=ds="..ALIL["The Consortium"].." - "..AL["Honored"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Yellow"].." "..BabbleInventory["Gem"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelGreen"] = {
		["Normal"] = {
			{
				{ 1, "s106960", "76646", "=q3=Balanced Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 2, "s106957", "76644", "=q3=Effulgent Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 3, "s107737", "76651", "=q3=Energized Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 4, "s107738", "76654", "=q3=Forceful Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 5, "s107739", "76652", "=q3=Jagged Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 6, "s106955", "76642", "=q3=Lightning Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 7, "s106953", "76640", "=q3=Misty Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 8, "s107740", "76655", "=q3=Nimble Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 9, "s106954", "76641", "=q3=Piercing Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 16, "s107742", "76656", "=q3=Puissant Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 17, "s107743", "76649", "=q3=Radiant Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 18, "s107744", "76653", "=q3=Regal Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 19, "s106956", "76643", "=q3=Sensei's Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 20, "s107745", "76650", "=q3=Shattered Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 21, "s107746", "76657", "=q3=Steady Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 22, "s106962", "76648", "=q3=Turbid Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 23, "s106961", "76647", "=q3=Vivid Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
				{ 24, "s106958", "76645", "=q3=Zen Wild Jade", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131688) };
			};
			{
				{ 1, "s107609", "76517", "=q2=Radiant Alexandrite", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 2, "s107608", "76524", "=q2=Puissant Alexandrite", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 3, "s107601", "76522", "=q2=Forceful Alexandrite", "=ds=#sr# 565", "=ds="..AL["Trainer"] };
				{ 4, "s107607", "76519", "=q2=Energized Alexandrite", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 5, "s107607", "76508", "=q2=Piercing Alexandrite", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 6, "s107613", "76525", "=q2=Steady Alexandrite", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 7, "s107598", "76513", "=q2=Balanced Alexandrite", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 8, "s107599", "76511", "=q2=Effulgent Alexandrite", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 9, "s107611", "76510", "=q2=Sensei's Alexandrite", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 16, "s107614", "76515", "=q2=Turbid Alexandrite", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 17, "s107605", "76507", "=q2=Misty Alexandrite", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 18, "s107612", "76518", "=q2=Shattered Alexandrite", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 19, "s107610", "76521", "=q2=Regal Alexandrite", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 20, "s107616", "76512", "=q2=Zen Alexandrite", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 21, "s107602", "76520", "=q2=Jagged Alexandrite", "=ds=#sr# 530", "=ds="..AL["Trainer"] };
				{ 22, "s107606", "76523", "=q2=Nimble Alexandrite", "=ds=#sr# 530", "=ds="..AL["Trainer"] };
				{ 23, "s107604", "76509", "=q2=Lightning Alexandrite", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 24, "s107615", "76514", "=q2=Vivid Alexandrite", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s101749", "71828", "=q4=Balanced Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 2, "s101754", "71833", "=q4=Energized Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 3, "s101757", "71836", "=q4=Forceful Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 4, "s101747", "71826", "=q4=Infused Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 5, "s101755", "71834", "=q4=Jagged Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 6, "s101745", "71824", "=q4=Lightning Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 7, "s101743", "71822", "=q4=Misty Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 8, "s101758", "71837", "=q4=Nimble Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 9, "s101744", "71823", "=q4=Piercing Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 16, "s101759", "71838", "=q4=Puissant Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 17, "s101752", "71831", "=q4=Radiant Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 18, "s101756", "71835", "=q4=Regal Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 19, "s101746", "71825", "=q4=Sensei's Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 20, "s101753", "71832", "=q4=Shattered Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 21, "s101760", "71839", "=q4=Steady Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 22, "s101751", "71830", "=q4=Turbid Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 23, "s101750", "71829", "=q4=Vivid Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 24, "s101748", "71827", "=q4=Zen Elven Peridot", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
			};
			{
				{ 1, "s73380", "52218", "=q3=Forceful Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 2, "s73377", "52223", "=q3=Jagged Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 3, "s73381", "52225", "=q3=Lightning Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 4, "s73376", "52227", "=q3=Nimble Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 5, "s73378", "52228", "=q3=Piercing Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 6, "s73382", "52231", "=q3=Puissant Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 8, "s73277", "52124", "=q2=Forceful Jasper", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 9, "s73274", "52121", "=q2=Jagged Jasper", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 10, "s73278", "52125", "=q2=Lightning Jasper", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 11, "s73273", "52120", "=q2=Nimble Jasper", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 12, "s73275", "52122", "=q2=Piercing Jasper", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 16, "s73375", "52233", "=q3=Regal Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 17, "s73384", "52237", "=q3=Sensei's Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 18, "s73379", "52245", "=q3=Steady Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 19, "s96226", "68741", "=q3=Vivid Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 20, "s73383", "52250", "=q3=Zen Dream Emerald", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 23, "s73279", "52126", "=q2=Puissant Jasper", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 24, "s73272", "52119", "=q2=Regal Jasper", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 25, "s73281", "52128", "=q2=Sensei's Jasper", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 26, "s73276", "52123", "=q2=Steady Jasper", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 27, "s73280", "52127", "=q2=Zen Jasper", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
			};
			{
				{ 1, "s66442", "40179", "=q4=Energized Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 2, "s66434", "40169", "=q4=Forceful Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s66431", "40165", "=q4=Jagged Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 4, "s66439", "40177", "=q4=Lightning Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 5, "s66435", "40171", "=q4=Misty Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 6, "s66429", "40166", "=q4=Nimble Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 7, "s66441", "40180", "=q4=Radiant Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 8, "s66338", "40167", "=q4=Regal Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 9, "s66443", "40182", "=q4=Shattered Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 10, "s66428", "40168", "=q4=Steady Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 11, "s66445", "40173", "=q4=Turbid Eye of Zul", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s54011", "40105", "=q3=Energized Forest Emerald", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 17, "s54001", "40091", "=q3=Forceful Forest Emerald", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 18, "s53996", "40086", "=q3=Jagged Forest Emerald", "=ds=#sr# 390", "=ds="..ALIL["Frenzyheart Tribe"].." - "..AL["Revered"] };
				{ 19, "s54009", "40100", "=q3=Lightning Forest Emerald", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 20, "s54003", "40095", "=q3=Misty Forest Emerald", "=ds=#sr# 390", "=ds="..ALIL["The Oracles"].." - "..AL["Revered"] };
				{ 21, "s53997", "40088", "=q3=Nimble Forest Emerald", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 22, "s54012", "40098", "=q3=Radiant Forest Emerald", "=ds=#sr# 390", "=ds="..AL["Drop"]..": "..ALIL["The Storm Peaks"] };
				{ 23, "s53998", "40089", "=q3=Regal Forest Emerald", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 24, "s54014", "40106", "=q3=Shattered Forest Emerald", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
				{ 25, "s54000", "40090", "=q3=Steady Forest Emerald", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
				{ 26, "s54005", "40102", "=q3=Turbid Forest Emerald", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
			};
			{
				{ 1, "s53925", "39983", "=q2=Energized Dark Jade", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 2, "s53920", "39978", "=q2=Forceful Dark Jade", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 3, "s53870", "39933", "=q2=Jagged Dark Jade", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 4, "s53923", "39981", "=q2=Lightning Dark Jade", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 5, "s53922", "39980", "=q2=Misty Dark Jade", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 6, "s53917", "39975", "=q2=Nimble Dark Jade", "=ds=#sr# 350", "=ds="..ALIL["The Oracles"].." - "..AL["Friendly"] };
				{ 7, "s53932", "39991", "=q2=Radiant Dark Jade", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 8, "s53918", "39976", "=q2=Regal Dark Jade", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 9, "s53933", "39992", "=q2=Shattered Dark Jade", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 10, "s53919", "39977", "=q2=Steady Dark Jade", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 11, "s53924", "39982", "=q2=Turbid Dark Jade", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s47053", "35759", "=q4=Forceful Seaspray Emerald", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 17, "s39742", "32226", "=q4=Jagged Seaspray Emerald", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Honored"] };
				{ 18, "s39740", "32224", "=q4=Radiant Seaspray Emerald", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Honored"] };
				{ 19, "s39739", "32223", "=q4=Regal Seaspray Emerald", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 20, "s47054", "35758", "=q4=Steady Seaspray Emerald", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 22, "s46405", "35318", "=q3=Forceful Talasite", "=ds=#sr# 350", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 23, "s31113", "24067", "=q3=Jagged Talasite", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 24, "s31111", "24066", "=q3=Radiant Talasite", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 25, "s46803", "35707", "=q3=Regal Talasite", "=ds=#sr# 350", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 26, "s43493", "33782", "=q3=Steady Talasite", "=ds=#sr# 350", "=ds=#sr# "..AL["Vendor"]..": "..ALIL["Nagrand"] };
				{
					{ 28, "s28918", "23105", "=q2=Regal Deep Peridot", "=ds=#sr# 315", "=ds="..ALIL["Thrallmar"].." - "..AL["Friendly"] };
					{ 28, "s28918", "23105", "=q2=Regal Deep Peridot", "=ds=#sr# 315", "=ds="..ALIL["Honor Hold"].." - "..AL["Friendly"] };
				};
				{ 29, "s28917", "23104", "=q2=Jagged Deep Peridot", "=ds=#sr# 305", "=ds="..AL["Trainer"] };
				{ 30, "s28916", "23103", "=q2=Radiant Deep Peridot", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Green"].." "..BabbleInventory["Gem"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelOrange"] = {
		["Normal"] = {
			{
				{ 1, "s107715", "76670", "=q3=Adept Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 2, "s107716", "76672", "=q3=Artful Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 3, "s107717", "76665", "=q3=Champion's Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 4, "s107718", "76659", "=q3=Crafty Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 5, "s107719", "76658", "=q3=Deadly Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 6, "s107720", "76666", "=q3=Deft Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 7, "s107721", "76669", "=q3=Fierce Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 8, "s107722", "76673", "=q3=Fine Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 9, "s107723", "76661", "=q3=Inscribed Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 10, "s107724", "76671", "=q3=Keen Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 11, "s107725", "76675", "=q3=Lucent Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 16, "s107726", "76662", "=q3=Polished Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 17, "s107727", "76660", "=q3=Potent Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 18, "s107728", "76668", "=q3=Reckless Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 19, "s107729", "76663", "=q3=Resolute Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 20, "s107730", "76679", "=q3=Resplendent Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 21, "s107731", "76674", "=q3=Skillful Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 22, "s107732", "76678", "=q3=Splendid Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 23, "s107733", "76664", "=q3=Stalwart Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 24, "s107734", "76676", "=q3=Tenuous Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 25, "s107735", "76667", "=q3=Wicked Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
				{ 26, "s107736", "76677", "=q3=Willful Vermilion Onyx", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131690) };
			};
			{
				{ 1, "s107659", "76531", "=q2=Resolute Tiger Opal", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 2, "s107660", "76547", "=q2=Resplendent Tiger Opal", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 3, "s107662", "76546", "=q2=Splendid Tiger Opal", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 4, "s107666", "76535", "=q2=Wicked Tiger Opal", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 5, "s107648", "76527", "=q2=Crafty Tiger Opal", "=ds=#sr# 565", "=ds="..AL["Trainer"] };
				{ 6, "s107663", "76532", "=q2=Stalwart Tiger Opal", "=ds=#sr# 565", "=ds="..AL["Trainer"] };
				{ 7, "s107657", "76528", "=q2=Potent Tiger Opal", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 8, "s107661", "76542", "=q2=Skillful Tiger Opal", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 9, "s107651", "76537", "=q2=Fierce Tiger Opal", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 10, "s107653", "76529", "=q2=Inscribed Tiger Opal", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 11, "s107645", "76538", "=q2=Adept Tiger Opal", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 16, "s107665", "76544", "=q2=Tenuous Tiger Opal", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 17, "s107647", "76533", "=q2=Champion's Tiger Opal", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 18, "s107656", "76530", "=q2=Polished Tiger Opal", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 19, "s107655", "76543", "=q2=Lucent Tiger Opal", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 20, "s107658", "76536", "=q2=Reckless Tiger Opal", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 21, "s107652", "76541", "=q2=Fine Tiger Opal", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 22, "s107667", "76545", "=q2=Willful Tiger Opal", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 23, "s107650", "76534", "=q2=Deft Tiger Opal", "=ds=#sr# 530", "=ds="..AL["Trainer"] };
				{ 24, "s107654", "76539", "=q2=Keen Tiger Opal", "=ds=#sr# 530", "=ds="..AL["Trainer"] };
				{ 25, "s107646", "76540", "=q2=Artful Tiger Opal", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 26, "s107649", "76526", "=q2=Deadly Tiger Opal", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s101773", "71852", "=q4=Adept Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 2, "s101775", "71854", "=q4=Artful Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 3, "s101768", "71847", "=q4=Champion's Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 4, "s101762", "71841", "=q4=Crafty Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 5, "s101761", "71840", "=q4=Deadly Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 6, "s101769", "71848", "=q4=Deft Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 7, "s101772", "71851", "=q4=Fierce Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 8, "s101776", "71855", "=q4=Fine Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 9, "s101764", "71843", "=q4=Inscribed Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 10, "s101774", "71853", "=q4=Keen Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 11, "s101778", "71857", "=q4=Lucent Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 16, "s101765", "71844", "=q4=Polished Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 17, "s101763", "71842", "=q4=Potent Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 18, "s101771", "71850", "=q4=Reckless Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 19, "s101766", "71845", "=q4=Resolute Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 20, "s101782", "71861", "=q4=Resplendent Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 21, "s101777", "71856", "=q4=Skillful Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 22, "s101781", "71860", "=q4=Splendid Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 23, "s101767", "71846", "=q4=Stalwart Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 24, "s101779", "71858", "=q4=Tenuous Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 25, "s101770", "71849", "=q4=Wicked Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 26, "s101780", "71859", "=q4=Willful Lava Coral", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
			};
			{
				{ 1, "s73371", "52204", "=q3=Adept Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 2, "s73373", "52205", "=q3=Artful Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 3, "s73365", "52209", "=q3=Deadly Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 4, "s73368", "52211", "=q3=Deft Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 5, "s73367", "52214", "=q3=Fierce Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 6, "s73372", "52215", "=q3=Fine Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 7, "s73364", "52222", "=q3=Inscribed Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 8, "s73374", "52224", "=q3=Keen Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 10, "s73268", "52115", "=q2=Adept Hessonite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 11, "s73270", "52117", "=q2=Artful Hessonite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 12, "s73262", "52109", "=q2=Deadly Hessonite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 13, "s73265", "52112", "=q2=Deft Hessonite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 14, "s73264", "52111", "=q2=Fierce Hessonite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 15, "s73269", "52116", "=q2=Fine Hessonite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 16, "s95755", "68357", "=q3=Lucent Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 17, "s73361", "52229", "=q3=Polished Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 18, "s73366", "52239", "=q3=Potent Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 19, "s73369", "52208", "=q3=Reckless Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 20, "s73362", "52249", "=q3=Resolute Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 21, "s95756", "68358", "=q3=Resplendent Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 22, "s73370", "52240", "=q3=Skillful Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 23, "s95754", "68356", "=q3=Willful Ember Topaz", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 25, "s73260", "52108", "=q2=Inscribed Hessonite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 26, "s73271", "52118", "=q2=Keen Hessonite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 27, "s73258", "52106", "=q2=Polished Hessonite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 28, "s73263", "52110", "=q2=Potent Hessonite", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 29, "s73266", "52113", "=q2=Reckless Hessonite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 30, "s73267", "52114", "=q2=Skillful Hessonite", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s66579", "40144", "=q4=Champion's Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 2, "s66568", "40147", "=q4=Deadly Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s66584", "40150", "=q4=Deft Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 4, "s66583", "40146", "=q4=Fierce Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 5, "s66567", "40142", "=q4=Inscribed Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 6, "s66585", "40149", "=q4=Lucent Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 7, "s66569", "40152", "=q4=Potent Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 8, "s66574", "40155", "=q4=Reckless Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 9, "s66586", "40163", "=q4=Resolute Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 10, "s66582", "40145", "=q4=Resplendent Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 11, "s66581", "40160", "=q4=Stalwart Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 12, "s66571", "40154", "=q4=Willful Ametrine", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s53977", "40039", "=q3=Champion's Monarch Topaz", "=ds=#sr# 390", "=ds="..AL["World Drop"]..""};
				{ 17, "s53979", "40043", "=q3=Deadly Monarch Topaz", "=ds=#sr# 390", "=ds="..ALIL["Knights of the Ebon Blade"].." - "..AL["Revered"] };
				{ 18, "s53991", "40055", "=q3=Deft Monarch Topaz", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 19, "s54019", "40041", "=q3=Fierce Monarch Topaz", "=ds=#sr# 390", "=ds="..AtlasLoot:EJ_GetBossName("Ingvar the Plunderer", 640).." ("..AL["Heroic"]..")" };
				{ 20, "s53975", "40037", "=q3=Inscribed Monarch Topaz", "=ds=#sr# 390", "=ds="..AL["World Drop"]..""};
				{ 21, "s53981", "40045", "=q3=Lucent Monarch Topaz", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
				{ 22, "s53984", "40048", "=q3=Potent Monarch Topaz", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 23, "s53987", "40051", "=q3=Reckless Monarch Topaz", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 24, "s54023", "40059", "=q3=Resolute Monarch Topaz", "=ds=#sr# 390", "=ds="..AL["World Drop"]..""};
				{ 25, "s53978", "40040", "=q3=Resplendent Monarch Topaz", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
				{ 26, "s53993", "40057", "=q3=Stalwart Monarch Topaz", "=ds=#sr# 390", "=ds="..ALIL["The Wyrmrest Accord"].." - "..AL["Exalted"] };
				{ 27, "s53986", "40050", "=q3=Willful Monarch Topaz", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
			};
			{
				{ 1, "s53874", "39949", "=q2=Champion's Huge Citrine", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 2, "s53877", "39952", "=q2=Deadly Huge Citrine", "=ds=#sr# 350", "=ds="..ALIL["Knights of the Ebon Blade"].." - "..AL["Friendly"] };
				{ 3, "s53880", "39955", "=q2=Deft Huge Citrine", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 4, "s53876", "39951", "=q2=Fierce Huge Citrine", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 5, "s53872", "39947", "=q2=Inscribed Huge Citrine", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 6, "s53879", "39954", "=q2=Lucent Huge Citrine", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 7, "s53882", "39956", "=q2=Potent Huge Citrine", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 8, "s53885", "39959", "=q2=Reckless Huge Citrine", "=ds=#sr# 350", "=ds="..ALIL["Frenzyheart Tribe"].." - "..AL["Friendly"] };
				{ 9, "s53893", "39967", "=q2=Resolute Huge Citrine", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 10, "s53875", "39950", "=q2=Resplendent Huge Citrine", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 11, "s53891", "39965", "=q2=Stalwart Huge Citrine", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 12, "s53884", "39958", "=q2=Willful Huge Citrine", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s39738", "32222", "=q4=Deadly Pyrestone", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 17, "s39733", "32217", "=q4=Inscribed Pyrestone", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 18, "s39734", "32218", "=q4=Potent Pyrestone", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Honored"] };
				{ 19, "s47055", "35760", "=q4=Reckless Pyrestone", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Honored"] };
				{ 21, "s39471", "31868", "=q3=Deadly Noble Topaz", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 22, "s31106", "24058", "=q3=Inscribed Noble Topaz", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 23, "s31107", "24059", "=q3=Potent Noble Topaz", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 24, "s31108", "24060", "=q3=Reckless Noble Topaz", "=ds=#sr# 350", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 26, "s39467", "31869", "=q2=Deadly Flame Spessarite", "=ds=#sr# 325", "=ds="..AL["Drop"]..": "..ALIL["Blade's Edge Mountains"] };
				{ 27, "s28915", "23101", "=q2=Potent Flame Spessarite", "=ds=#sr# 325", "=ds="..ALIL["Lower City"].." - "..AL["Friendly"] };
				{ 28, "s28912", "23099", "=q2=Reckless Flame Spessarite", "=ds=#sr# 305", "=ds="..ALIL["The Consortium"].." - "..AL["Friendly"] };
				{ 29, "s28910", "23098", "=q2=Inscribed Flame Spessarite", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Orange"].." "..BabbleInventory["Gem"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelPurple"] = {
		["Normal"] = {
			{
				{ 1, "s130657", "89680", "=q3=Assassin's Imperial Amethyst", "=ds=#sr# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 2, "s130658", "89674", "=q3=Tense Imperial Amethyst", "=ds=#sr# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 3, "s107693", "76681", "=q3=Accurate Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 4, "s107694", "76690", "=q3=Defender's Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 5, "s107695", "76684", "=q3=Etched Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 6, "s107696", "76680", "=q3=Glinting Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 7, "s107697", "76688", "=q3=Guardian's Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 9, "s107635", "76551", "=q2=Retaliating Roguestone", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 10, "s130655", "89675", "=q2=Tense Roguestone", "=ds=#sr# 570", "=ds="..AL["Trainer"] };
				{ 11, "s107634", "76554", "=q2=Purified Roguestone", "=ds=#sr# 565", "=ds="..AL["Trainer"] };
				{ 12, "s107638", "76557", "=q2=Timeless Roguestone", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 13, "s107628", "76558", "=q2=Defender's Roguestone", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 14, "s107627", "76549", "=q2=Accurate Roguestone", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 15, "s107632", "76556", "=q2=Guardian's Roguestone", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 16, "s107698", "76685", "=q3=Mysterious Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 17, "s107699", "76686", "=q3=Purified Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 18, "s107700", "76683", "=q3=Retaliating Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 19, "s107701", "76687", "=q3=Shifting Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 20, "s107702", "76691", "=q3=Sovereign Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 21, "s107703", "76689", "=q3=Timeless Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 22, "s107704", "76682", "=q3=Veiled Imperial Amethyst", "=ds=#sr# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(131691) };
				{ 24, "s107631", "76548", "=q2=Glinting Roguestone", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 25, "s107636", "76555", "=q2=Shifting Roguestone", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 26, "s107637", "76559", "=q2=Sovereign Roguestone", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 27, "s130656", "89678", "=q2=Assassin's Roguestone", "=ds=#sr# 530", "=ds="..AL["Trainer"] };
				{ 28, "s107639", "76550", "=q2=Veiled Roguestone", "=ds=#sr# 530", "=ds="..AL["Trainer"] };
				{ 29, "s107630", "76552", "=q2=Etched Roguestone", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 30, "s107633", "76553", "=q2=Mysterious Roguestone", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s101784", "71863", "=q4=Accurate Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 2, "s101793", "71872", "=q4=Defender's Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 3, "s101787", "71866", "=q4=Etched Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 4, "s101783", "71862", "=q4=Glinting Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 5, "s101791", "71870", "=q4=Guardian's Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 6, "s101788", "71867", "=q4=Mysterious Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 8, "s73360", "52203", "=q3=Accurate Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 9, "s73352", "52210", "=q3=Defender's Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 10, "s73356", "52213", "=q3=Etched Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 11, "s73357", "52220", "=q3=Glinting Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 12, "s73354", "52221", "=q3=Guardian's Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 13, "s73355", "52236", "=q3=Purified Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 16, "s101789", "71868", "=q4=Purified Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 17, "s101786", "71865", "=q4=Retaliating Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 18, "s101790", "71869", "=q4=Shifting Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 19, "s101794", "71873", "=q4=Sovereign Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 20, "s101792", "71871", "=q4=Timeless Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 21, "s101785", "71864", "=q4=Veiled Shadow Spinel", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 23, "s73358", "52234", "=q3=Retaliating Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 24, "s73351", "52238", "=q3=Shifting Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 25, "s73350", "52243", "=q3=Souvereign Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 26, "s73353", "52248", "=q3=Timeless Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
				{ 27, "s73359", "52217", "=q3=Veiled Demonseye", "=ds=#sr# 465", "#CATAJW:3#"..AL["Vendor"] };
			};
			{
				{ 1, "s73250", "52105", "=q2=Accurate Nightstone", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 2, "s73242", "52097", "=q2=Defender's Nightstone", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 3, "s73246", "52101", "=q2=Etched Nightstone", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 4, "s73247", "52102", "=q2=Glinting Nightstone", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 5, "s73244", "52099", "=q2=Guardian's Nightstone", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 6, "s73245", "52100", "=q2=Purified Nightstone", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 7, "s73248", "52103", "=q2=Retaliating Nightstone", "=ds=#sr# 425", "=ds="..AL["World Drop"] };
				{ 8, "s73241", "52096", "=q2=Shifting Nightstone", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 9, "s73240", "52095", "=q2=Souvereign Nightstone", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 10, "s73243", "52098", "=q2=Timeless Nightstone", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 11, "s73249", "52104", "=q2=Veiled Nightstone", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 16, "s66576", "40162", "=q4=Accurate Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 17, "s66560", "40139", "=q4=Defender's Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 18, "s66572", "40143", "=q4=Etched Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 19, "s66573", "40157", "=q4=Glinting Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 20, "s66561", "40141", "=q4=Guardian's Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 21, "s66562", "40135", "=q4=Mysterious Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 22, "s66556", "40133", "=q4=Purified Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 23, "s66557", "40130", "=q4=Shifting Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 24, "s66554", "40129", "=q4=Sovereign Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 25, "s66432", "40164", "=q4=Timeless Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 26, "s66570", "40153", "=q4=Veiled Dreadstone", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
			};
			{
				{ 1, "s53994", "40058", "=q3=Accurate Twilight Opal", "=ds=#sr# 390", "=ds="..AL["Drop"]..": "..ALIL["The Storm Peaks"] };
				{ 2, "s53972", "40032", "=q3=Defender's Twilight Opal", "=ds=#sr# 390", "=ds="..AL["Drop"]..": "..ALIL["The Storm Peaks"] };
				{ 3, "s53976", "40038", "=q3=Etched Twilight Opal", "=ds=#sr# 390", "=ds="..AL["World Drop"] };
				{ 4, "s53980", "40044", "=q3=Glinting Twilight Opal", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 5, "s53974", "40034", "=q3=Guardian's Twilight Opal", "=ds=#sr# 390", "=ds="..ALIL["Argent Crusade"].." - "..AL["Revered"] };
				{ 6, "s53968", "40028", "=q3=Mysterious Twilight Opal", "=ds=#sr# 390", "=ds="..ALIL["Wintergrasp"] };
				{ 7, "s53966", "40026", "=q3=Purified Twilight Opal", "=ds=#sr# 390", "=ds="..AL["World Drop"] };
				{ 8, "s53963", "40023", "=q3=Shifting Twilight Opal", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 9, "s53962", "40022", "=q3=Sovereign Twilight Opal", "=ds=#sr# 390", "=ds="..AL["World Drop"] };
				{ 10, "s53965", "40025", "=q3=Timeless Twilight Opal", "=ds=#sr# 390", "=ds="..ALIL["Knights of the Ebon Blade"].." - "..AL["Exalted"] };
				{ 11, "s53985", "40049", "=q3=Veiled Twilight Opal", "=ds=#sr# 390", "#DALARANJW:3#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s53892", "39966", "=q2=Accurate Shadow Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 17, "s53869", "39939", "=q2=Defender's Shadow Crystal", "=ds=#sr# 350", "=ds="..ALIL["The Kalu'ak"].." - "..AL["Honored"] };
				{ 18, "s53873", "39948", "=q2=Etched Shadow Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 19, "s53861", "39942", "=q2=Glinting Shadow Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 20, "s53871", "39940", "=q2=Guardian's Shadow Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 21, "s53865", "39945", "=q2=Mysterious Shadow Crystal", "=ds=#sr# 350", "#DALARANJW:1#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 22, "s53921", "39979", "=q2=Purified Shadow Crystal", "=ds=#sr# 350", "=ds="..ALIL["The Kalu'ak"].." - "..AL["Friendly"] };
				{ 23, "s53860", "39935", "=q2=Shifting Shadow Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 24, "s53859", "39934", "=q2=Sovereign Shadow Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 25, "s53894", "39968", "=q2=Timeless Shadow Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 26, "s53883", "39957", "=q2=Veiled Shadow Crystal", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s39736", "32220", "=q4=Glinting Shadowsong Amethyst", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Honored"] };
				{ 2, "s39741", "32225", "=q4=Purified Shadowsong Amethyst", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Honored"] };
				{ 3, "s39728", "32212", "=q4=Shifting Shadowsong Amethyst", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 4, "s39727", "32211", "=q4=Sovereign Shadowsong Amethyst", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 5, "s39731", "32215", "=q4=Timeless Shadowsong Amethyst", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Honored"] };
				{ 6, "s39737", "32221", "=q4=Veiled Shadowsong Amethyst", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Exalted"] };
				{ 8, "s31109", "24061", "=q3=Glinting Nightseye", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 9, "s31112", "24065", "=q3=Purified Nightseye", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 10, "s31103", "24055", "=q3=Shifting Nightseye", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 11, "s31102", "24054", "=q3=Sovereign Nightseye", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 12, "s31104", "24056", "=q3=Timeless Nightseye", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 13, "s39470", "31867", "=q3=Veiled Nightseye", "=ds=#sr# 350", "=ds="..AL["World Drop"] };
				{ 16, "s41429", "32836", "=q3=Purified Shadow Pearl", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 17, "s41420", "32833", "=q2=Purified Jaggal Pearl", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 19, "s28933", "23110", "=q2=Shifting Shadow Draenite", "=ds=#sr# 325", "=ds="..AL["Vendor"] };
				{ 20, "s28936", "23111", "=q2=Sovereign Shadow Draenite", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 21, "s39466", "31866", "=q2=Veiled Shadow Draenite", "=ds=#sr# 325", "=ds="..AL["Drop"]..": "..ALIL["Blade's Edge Mountains"] };
				{ 22, "s28914", "23100", "=q2=Glinting Shadow Draenite", "=ds=#sr# 315", "=ds="..AL["Trainer"] };
				{ 23, "s28927", "23109", "=q2=Purified Shadow Draenite", "=ds=#sr# 305", "=ds="..ALIL["The Aldor"].." / "..ALIL["The Scryers"].." - "..AL["Honored"] };
				{ 24, "s28925", "23108", "=q2=Timeless Shadow Draenite", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Purple"].." "..BabbleInventory["Gem"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelMeta"] = {
		["Normal"] = {
			{
				{ 1, "s107753", "76884", "=q3=Agile Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 2, "s107754", "76895", "=q3=Austere Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 3, "s107756", "76885", "=q3=Burning Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 4, "s107757", "76890", "=q3=Destructive Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 5, "s107758", "76897", "=q3=Effulgent Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 6, "s107759", "76879", "=q3=Ember Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 7, "s107760", "76892", "=q3=Enigmatic Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 16, "s107762", "76896", "=q3=Eternal Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 17, "s107763", "76887", "=q3=Fleet Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 18, "s107764", "76894", "=q3=Forlorn Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 19, "s107765", "76893", "=q3=Impassive Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 20, "s107766", "76891", "=q3=Powerful Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 21, "s107767", "76886", "=q3=Reverberating Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
				{ 22, "s107768", "76888", "=q3=Revitalizing Primal Diamond", "=ds=#sr# 575", "=ds="..AL["World Drop"] };
			};
			{
				{ 1, "s96255", "68778", "=q3=Agile Shadowspirit Diamond", "=ds=#sr# 490", "=ds="..AL["World Drop"] };
				{ 2, "s73468", "52294", "=q3=Austere Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 3, "s73466", "52292", "=q3=Bracing Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 4, "s96257", "68780", "=q3=Burning Shadowspirit Diamond", "=ds=#sr# 490", "=ds="..AL["World Drop"] };
				{ 5, "s73465", "52291", "=q3=Chaotic Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 6, "s73472", "52298", "=q3=Destructive Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 7, "s73469", "52295", "=q3=Efullgent Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 8, "s73470", "52296", "=q3=Ember Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 10, "s55401", "41380", "=q3=Austere Earthsiege Diamond", "=ds=#sr# 420", "=ds="..AtlasLoot:EJ_GetBossName("King Ymiron", 644) };
				{ 11, "s55405", "41389", "=q3=Beaming Earthsiege Diamond", "=ds=#sr# 420", "=ds="..AL["World Drop"]..""};
				{ 12, "s55397", "41395", "=q3=Bracing Earthsiege Diamond", "=ds=#sr# 420", "=ds="..AtlasLoot:EJ_GetBossName("Ley-Guardian Eregos", 625) };
				{ 13, "s55398", "41396", "=q3=Eternal Earthsiege Diamond", "=ds=#sr# 420", "=ds="..AtlasLoot:EJ_GetBossName("Loken", 600) };
				{ 14, "s55396", "41401", "=q3=Insightful Earthsiege Diamond", "=ds=#sr# 420", "#DALARANJW:5#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s73474", "52300", "=q3=Enigmatic Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 17, "s73467", "52293", "=q3=Eternal Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 18, "s73464", "52289", "=q3=Fleet Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 19, "s73476", "52302", "=q3=Forlorn Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 20, "s73475", "52301", "=q3=Impassive Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 21, "s73473", "52299", "=q3=Powerful Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 22, "s96256", "68779", "=q3=Reverberating Shadowspirit Diamond", "=ds=#sr# 490", "=ds="..AL["World Drop"] };
				{ 23, "s73471", "52297", "=q3=Revitalizing Shadowspirit Diamond", "=ds=#sr# 490", "#CATAJW:4#"..AL["Vendor"] };
				{ 25, "s55404", "41385", "=q3=Invigorating Earthsiege Diamond", "=ds=#sr# 420", "#DALARANJW:5#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 26, "s55402", "41381", "=q3=Persistant Earthsiege Diamond", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 27, "s55399", "41397", "=q3=Powerful Earthsiege Diamond", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 28, "s55400", "41398", "=q3=Relentless Earthsiege Diamond", "=ds=#sr# 420", "#DALARANJW:5#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 29, "s55403", "41382", "=q3=Trenchant Earthsiege Diamond", "=ds=#sr# 420", "#DALARANJW:5#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
			};
			{
				{ 1, "s55389", "41285", "=q3=Chaotic Skyflare Diamond", "=ds=#sr# 420", "#DALARANJW:5#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 2, "s55390", "41307", "=q3=Destructive Skyflare Diamond", "=ds=#sr# 420", "=ds="..AL["World Drop"]..""};
				{ 3, "s55392", "41333", "=q3=Ember Skyflare Diamond", "=ds=#sr# 420", "#DALARANJW:5#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 4, "s55393", "41335", "=q3=Enigmatic Skyflare Diamond", "=ds=#sr# 420", "=ds="..ALIL["Wintergrasp"] };
				{ 5, "s55387", "41378", "=q3=Forlorn Skyflare Diamond", "=ds=#sr# 420", "=ds="..ALIL["Wintergrasp"] };
				{ 6, "s55388", "41379", "=q3=Impassive Skyflare Diamond", "=ds=#sr# 420", "=ds="..ALIL["Wintergrasp"] };
				{ 8, "s46597", "35501", "=q3=Eternal Earthstorm Diamond", "=ds=#sr# 370", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 9, "s32867", "25897", "=q3=Bracing Earthstorm Diamond", "=ds=#sr# 365", "=ds="..ALIL["The Consortium"].." - "..AL["Revered"] };
				{ 10, "s32869", "25899", "=q3=Brutal Earthstorm Diamond", "=ds=#sr# 365", "=ds="..AL["World Drop"] };
				{ 11, "s32870", "25901", "=q3=Insightful Earthstorm Diamond", "=ds=#sr# 365", "=ds="..ALIL["The Sha'tar"].." - "..AL["Friendly"] };
				{ 12, "s32866", "25896", "=q3=Powerful Earthstorm Diamond", "=ds=#sr# 365", "=ds="..ALIL["The Consortium"].." - "..AL["Honored"] };
				{ 13, "s39961", "32409", "=q3=Relentless Earthstorm Diamond", "=ds=#sr# 365", "=ds="..ALIL["The Consortium"].." - "..AL["Exalted"] };
				{ 14, "s32868", "25898", "=q3=Tenacious Earthstorm Diamond", "=ds=#sr# 365", "=ds="..AL["World Drop"] };
				{ 16, "s55407", "41376", "=q3=Revitalizing Skyflare Diamond", "=ds=#sr# 420", "#DALARANJW:5#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 17, "s55384", "41377", "=q3=Shielded Skyflare Diamond", "=ds=#sr# 420", "#DALARANJW:5#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 18, "s55394", "41339", "=q3=Swift Skyflare Diamond", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 19, "s55395", "41400", "=q3=Thundering Skyflare Diamond", "=ds=#sr# 420", "=ds="..AL["World Drop"] };
				{ 20, "s55386", "41375", "=q3=Tireless Skyflare Diamond", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 23, "s46601", "35503", "=q3=Ember Skyfire Diamond", "=ds=#sr# 370", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 24, "s44794", "34220", "=q3=Chaotic Skyfire Diamond", "=ds=#sr# 365", "=ds="..AL["Drop"]..": "..ALIL["Shadowmoon Valley"] };
				{ 25, "s32871", "25890", "=q3=Destructive Skyfire Diamond", "=ds=#sr# 365", "=ds="..AL["World Drop"] };
				{ 26, "s32874", "25895", "=q3=Enigmatic Skyfire Diamond", "=ds=#sr# 365", "=ds="..ALIL["Keepers of Time"].." - "..AL["Honored"] };
				{ 27, "s32872", "25893", "=q3=Mystical Skyfire Diamond", "=ds=#sr# 365", "=ds="..AL["World Drop"] };
				{ 28, "s32873", "25894", "=q3=Swift Skyfire Diamond", "=ds=#sr# 365", "=ds="..ALIL["The Consortium"].." - "..AL["Honored"] };
				{ 29, "s39963", "32410", "=q3=Thundering Skyfire Diamond", "=ds=#sr# 365", "=ds="..AL["World Drop"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Meta"].." "..BabbleInventory["Gem"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelPrismatic"] = {
		["Normal"] = {
			{
				{ 2, "s68253", "49110", "=q4=Nightmare Tear", "=ds=#sr# 450", "#DALARANJW:4#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s28028", "22459", "=q4=Void Sphere", "=ds="..GetSpellInfo(7411) };
				{ 4, "s56531", "42702", "=q3=Enchanted Tear", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
				{ 17, "s28027", "22460", "=q3=Prismatic Sphere", "=ds="..GetSpellInfo(7411) };
				{ 18, "s56530", "42701", "=q2=Enchanted Pearl", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 19, "s62941", "42701", "=q2=Prismatic Black Diamond", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Prismatic"].." "..BabbleInventory["Gem"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelDragonsEye"] = {
		["Normal"] = {
			{
				{ 1, "s56049", "42142", "=q4=Bold Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 2, "s56074", "42148", "=q4=Brilliant Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 3, "s56052", "42143", "=q4=Delicate Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 4, "s56056", "42152", "=q4=Flashing Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 5, "s56081", "42154", "=q4=Precise Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 7, "s56079", "42158", "=q4=Mystic Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 8, "s56083", "42150", "=q4=Quick Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 9, "s56085", "42149", "=q4=Smooth Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 10, "s56055", "42151", "=q4=Subtle Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s56084", "42156", "=q4=Rigid Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 17, "s56086", "36767", "=q4=Solid Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 18, "s56087", "42145", "=q4=Sparkling Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 19, "s56088", "42155", "=q4=Stormy Dragon's Eye", "=ds=#sr# 370", "#DALARANJW:2#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 21, 42225, "", "=q3=Dragon's Eye", "=ds=#e8#", "#DALARANJW:1#"..AL["Vendor"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..AL["Dragon's Eye"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelChimerasEye"] = {
		["Normal"] = {
			{
				{ 1, "s73396", "52255", "=q4=Bold Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 2, "s73399", "52257", "=q4=Brilliant Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 3, "s73397", "52258", "=q4=Delicate Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 4, "s73398", "52259", "=q4=Flashing Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 5, "s73400", "52260", "=q4=Precise Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 7, "s73409", "52269", "=q4=Fractured Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 8, "s73407", "52267", "=q4=Mystic Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 9, "s73408", "52268", "=q4=Quick Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 10, "s73406", "52266", "=q4=Smooth Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 11, "s73405", "52265", "=q4=Subtle Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 16, "s73404", "52264", "=q4=Rigid Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 17, "s73401", "52261", "=q4=Solid Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 18, "s73402", "52262", "=q4=Sparkling Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 19, "s73403", "52263", "=q4=Stormy Chimera's Eye", "=ds=#sr# 500", "#CATAJW:2#"..AL["Vendor"] };
				{ 21, 52196, "", "=q3=Chimera's Eye", "=ds=#e8#", "#CATAJW:1#"..AL["Vendor"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..AL["Chimera's Eye"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelSerpentsEye"] = {
		["Normal"] = {
			{
				{ 1, "s122675", "83141", "=q4=Bold Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 2, "s122676", "83150", "=q4=Brilliant Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 3, "s122674", "83151", "=q4=Delicate Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 4, "s122685", "83152", "=q4=Flashing Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 5, "s122683", "83147", "=q4=Precise Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 7, "s122684", "83143", "=q4=Fractured Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 8, "s122682", "83142", "=q4=Quick Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 9, "s122680", "83146", "=q4=Smooth Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 10, "s122679", "83145", "=q4=Subtle Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 12, 76734, "", "=q3=Serpent's Eye", "=ds=#e8#", "#SPIRITOFHARMONY:1#"..AL["Vendor"] };
				{ 16, "s122681", "83144", "=q4=Rigid Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 17, "s122678", "83148", "=q4=Solid Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 18, "s122677", "83149", "=q4=Sparkling Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 20, "s136274", "93409", "=q4=Assassin's Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 21, "s136270", "93405", "=q4=Lucent Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 22, "s136275", "93410", "=q4=Mysterious Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 23, "s136269", "93404", "=q4=Resplendent Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 24, "s136273", "93408", "=q4=Tense Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 25, "s136272", "93406", "=q4=Willful Serpent's Eye", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..AL["Serpent's Eye"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelMountPet"] = {
		["Normal"] = {
			{
				{ 1, "s120045", "82453", "=q4=Jeweled Onyx Panther", "=ds=#sr# 600", "=ds="..ALIL["Order of the Cloud Serpent"].." - "..AL["Exalted"] };
				{ 2, "s121844", "83088", "=q3=Jade Panther", "=ds=#sr# 600", "=ds="..ALIL["Order of the Cloud Serpent"].." - "..AL["Honored"] };
				{ 3, "s121841", "83087", "=q3=Ruby Panther", "=ds=#sr# 600", "=ds="..ALIL["Order of the Cloud Serpent"].." - "..AL["Revered"] };
				{ 4, "s121842", "83090", "=q3=Sapphire Panther", "=ds=#sr# 600", "=ds="..ALIL["Order of the Cloud Serpent"].." - "..AL["Revered"] };
				{ 5, "s121843", "83089", "=q3=Sunstone Panther", "=ds=#sr# 600", "=ds="..ALIL["Order of the Cloud Serpent"].." - "..AL["Honored"] };
				{ 16, "s131897", "82774", "=q3=Jade Owl", "=ds=#sr# 600", "=ds="..ALIL["Treasures of the Vale"] };
				{ 17, "s131898", "82775", "=q3=Sapphire Cub", "=ds=#sr# 600", "=ds="..ALIL["Treasures of the Vale"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Mount"].." & "..BabbleInventory["Pet"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelNeck"] = {
		["Normal"] = {
			{
				{ 1, "s122670", "83803", "=q3=Golembreaker Amulet", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 2, "s122669", "83802", "=q3=Reflection of the Sea", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 3, "s122672", "83805", "=q3=Skymage Circle", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 4, "s122673", "83806", "=q3=Tiger Opal Pendant", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 5, "s122671", "83804", "=q3=Widow Chain", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 6, "s73521", "52350", "=q3=Brazen Elementium Medallion", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 7, "s73506", "52323", "=q3=Elementium Guardian", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 8, "s73504", "52321", "=q3=Entwined Elementium Choker", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 9, "s73505", "52322", "=q3=Eye of Many Deaths", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 10, "s99543", "75075", "=q3=Vicious Amberjewel Pendant", "=ds=#sr# 520", "=ds="..AL["Trainer"] };
				{ 11, "s99544", "75078", "=q3=Vicious Ruby Choker", "=ds=#sr# 520", "=ds="..AL["Trainer"] };
				{ 12, "s99542", "75074", "=q3=Vicious Sapphire Necklace", "=ds=#sr# 520", "=ds="..AL["Trainer"] };
				{ 13, "s122662", "83794", "=q2=Shadowfire Necklace", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 14, "s73497", "52309", "=q2=Nightstone Choker", "=ds=#sr# 460", "=ds="..AL["Trainer"] };
				{ 15, "s56500", "42646", "=q4=Titanium Earthguard Chain", "=ds=#sr# 440", "#DALARANJW:6#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 16, "s56499", "42645", "=q4=Titanium Impact Choker", "=ds=#sr# 440", "#DALARANJW:6#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 17, "s56501", "42647", "=q4=Titanium Spellshock Necklace", "=ds=#sr# 440", "#DALARANJW:6#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 18, "s73496", "52307", "=q2=Alicite Pendant", "=ds=#sr# 435", "=ds="..AL["Trainer"] };
				{ 19, "s64725", "45812", "=q3=Emerald Choker", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 20, "s64726", "45813", "=q3=Sky Sapphire Amulet", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 21, "s56196", "42339", "=q3=Blood Sun Necklace", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
				{ 22, "s56195", "42338", "=q3=Jade Dagger Pendant", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
				{ 23, "s46126", "34360", "=q4=Amulet of Flowing Life", "=ds=#sr# 365", "=ds="..AL["Drop"]..": "..ALIL["Sunwell Plateau"] };
				{ 24, "s46127", "34358", "=q4=Hard Khorium Choker", "=ds=#sr# 365", "=ds="..AL["Drop"]..": "..ALIL["Sunwell Plateau"] };
				{ 25, "s46125", "34359", "=q4=Pendant of Sunfire", "=ds=#sr# 365", "=ds="..AL["Drop"]..": "..ALIL["Sunwell Plateau"] };
				{ 26, "s31076", "24121", "=q3=Chain of the Twilight Owl", "=ds=#sr# 365", "=ds="..AL["World Drop"] };
				{ 27, "s31072", "24117", "=q3=Embrace of the Dawn", "=ds=#sr# 365", "=ds="..AL["World Drop"] };
				{ 28, "s31070", "24114", "=q3=Braided Eternium Chain", "=ds=#sr# 360", "=ds="..AL["World Drop"] };
				{ 29, "s31071", "24116", "=q3=Eye of the Night", "=ds=#sr# 360", "=ds="..AL["World Drop"] };
				{ 30, "s31062", "24092", "=q3=Pendant of Frozen Flame", "=ds=#sr# 360", "=ds="..ALIL["Keepers of Time"].." - "..AL["Revered"] };
			};
			{
				{ 1, "s31065", "24097", "=q3=Pendant of Shadow's End", "=ds=#sr# 360", "=ds="..ALIL["The Aldor"].." - "..AL["Revered"] };
				{ 2, "s31063", "24093", "=q3=Pendant of Thawing", "=ds=#sr# 360", "=ds="..ALIL["Lower City"].." - "..AL["Revered"] };
				{ 3, "s31066", "24098", "=q3=Pendant of the Null Rune", "=ds=#sr# 360", "=ds="..ALIL["The Consortium"].." - "..AL["Revered"] };
				{ 4, "s31064", "24095", "=q3=Pendant of Withering", "=ds=#sr# 360", "=ds="..ALIL["The Scryers"].." - "..AL["Revered"] };
				{ 5, "s31068", "24110", "=q3=Living Ruby Pendant", "=ds=#sr# 355", "=ds="..AL["World Drop"] };
				{ 6, "s31067", "24106", "=q3=Thick Felsteel Necklace", "=ds=#sr# 355", "=ds="..AL["World Drop"] };
				{ 7, "s58142", "43245", "=q2=Crystal Chalcedony Amulet", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 8, "s58141", "43244", "=q2=Crystal Citrine Necklace", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 9, "s40514", "32508", "=q3=Necklace of the Deep", "=ds=#sr# 340", "=ds="..AL["Trainer"] };
				{ 10, "s31051", "24077", "=q2=Thick Adamantite Necklace", "=ds=#sr# 335", "=ds="..AL["Trainer"] };
				{ 11, "s26915", "21792", "=q3=Necklace of the Diamond Tower", "=ds=#sr# 305", "=ds="..AL["Vendor"]..": "..ALIL["Winterspring"] };
				{ 12, "s26911", "21791", "=q3=Living Emerald Pendant", "=ds=#sr# 290", "=ds="..AL["Trainer"] };
				{ 13, "s26908", "21790", "=q2=Sapphire Pendant of Winter Night", "=ds=#sr# 280", "=ds="..AL["Trainer"] };
				{ 14, "s26897", "21766", "=q3=Opal Necklace of Impact", "=ds=#sr# 250", "=ds="..AL["Vendor"] };
				{ 15, "s26883", "21764", "=q2=Ruby Pendant of Fire", "=ds=#sr# 235", "=ds="..AL["Trainer"] };
				{ 16, "s26876", "21755", "=q2=Aquamarine Pendant of the Warrior", "=ds=#sr# 220", "=ds="..AL["Trainer"] };
				{ 17, "s63743", "45627", "=q3=Amulet of Truesight", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 18, "s25622", "20967", "=q2=Citrine Pendant of Golden Healing", "=ds=#sr# 190", "=ds="..AL["World Drop"] };
				{ 19, "s25618", "20966", "=q2=Jade Pendant of Blasting", "=ds=#sr# 160", "=ds="..AL["World Drop"] };
				{ 20, "s25320", "20831", "=q2=Heavy Golden Necklace of Battle", "=ds=#sr# 150", "=ds="..AL["Vendor"] };
				{ 21, "s25610", "20950", "=q2=Pendant of the Agate Shield", "=ds=#sr# 120", "=ds="..AL["Trainer"] };
				{ 22, "s25339", "20830", "=q2=Amulet of the Moon", "=ds=#sr# 110", "=ds="..AL["Vendor"] };
				{ 23, "s25498", "20909", "=q2=Barbaric Iron Collar", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 24, "s38175", "31154", "=q2=Bronze Torc", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 25, "s36523", "30419", "=q2=Brilliant Necklace", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 26, "s26927", "21933", "=q2=Thick Bronze Necklace", "=ds=#sr# 50", "=ds="..AL["Trainer"] };
				{ 27, "s26928", "21934", "=q2=Ornate Tigerseye Necklace", "=ds=#sr# 30", "=ds="..AL["Trainer"] };
				{ 28, "s32178", "25438", "=q2=Malachite Pendant", "=ds=#sr# 20", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Neck"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelRing"] = {
		["Normal"] = {
			{
				{ 1, "s122668", "83801", "=q3=Band of Blood", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 2, "s122664", "83796", "=q3=Heart of the Earth", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 3, "s122667", "83800", "=q3=Lionsfall Ring", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 4, "s122666", "83799", "=q3=Lord's Signet", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 5, "s122665", "83798", "=q3=Roguestone Shadowband", "=ds=#sr# 575", "=ds="..AL["Trainer"] };
				{ 6, "s73498", "52318", "=q3=Band of Blades", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 7, "s73520", "52348", "=q3=Elementium Destroyer's Ring", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 8, "s73503", "52320", "=q3=Elementium Moebius Band", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 9, "s98921", "69852", "=q3=Punisher's Band", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 10, "s73502", "52319", "=q3=Ring of Warring Elements", "=ds=#sr# 525", "#CATAJW:5#"..AL["Vendor"] };
				{ 11, "s99540", "75068", "=q3=Vicious Amberjewel Band", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 12, "s99541", "75071", "=q3=Vicious Ruby Signet", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 13, "s99539", "75067", "=q3=Vicious Sapphire Ring", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 14, "s122661", "83793", "=q2=Ornate Band", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 15, "s73495", "52308", "=q2=Hessonite Band", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 16, "s56497", "42643", "=q4=Titanium Earthguard Ring", "=ds=#sr# 430", "#DALARANJW:6#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 17, "s56496", "42642", "=q4=Titanium Impact Band", "=ds=#sr# 430", "#DALARANJW:6#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 18, "s56498", "42644", "=q4=Titanium Spellshock Ring", "=ds=#sr# 430", "#DALARANJW:6#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 19, "s73494", "52306", "=q2=Jasper Ring", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 20, "s58954", "43582", "=q4=Titanium Frostguard Ring", "=ds=#sr# 420", "#DALARANJW:6#"..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 21, "s56197", "42340", "=q3=Dream Signet", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 22, "s58147", "43250", "=q3=Ring of Earthen Might", "=ds=#sr# 420", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 23, "s58150", "43253", "=q3=Ring of Northern Tears", "=ds=#sr# 420", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 24, "s58148", "43251", "=q3=Ring of Scarlet Shadows", "=ds=#sr# 420", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 25, "s64727", "45808", "=q3=Runed Mana Band", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 26, "s58507", "43498", "=q3=Savage Titanium Band", "=ds=#sr# 420", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 27, "s58492", "43482", "=q3=Savage Titanium Ring", "=ds=#sr# 420", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 28, "s64728", "45809", "=q3=Scarlet Signet", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 29, "s58149", "43252", "=q3=Windfire Band", "=ds=#sr# 420", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 30, "s58146", "43249", "=q2=Shadowmight Ring", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s58145", "43248", "=q2=Stoneguard Band", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
				{ 2, "s38503", "31398", "=q4=The Frozen Eye", "=ds=#sr# 375", "=ds="..ALIL["The Violet Eye"].." - "..AL["Honored"] };
				{ 3, "s38504", "31399", "=q4=The Natural Ward", "=ds=#sr# 375", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Exalted"] };
				{ 4, "s46124", "34361", "=q4=Hard Khorium Band", "=ds=#sr# 365", "=ds="..AL["Drop"]..": "..ALIL["Sunwell Plateau"] };
				{ 5, "s46122", "34362", "=q4=Loop of Forged Power", "=ds=#sr# 365", "=ds="..AL["Drop"]..": "..ALIL["Sunwell Plateau"] };
				{ 6, "s46123", "34363", "=q4=Ring of Flowing Life", "=ds=#sr# 365", "=ds="..AL["Drop"]..": "..ALIL["Sunwell Plateau"] };
				{ 7, "s31061", "24089", "=q3=Blazing Eternium Band", "=ds=#sr# 365", "=ds="..AL["World Drop"] };
				{ 8, "s31057", "24086", "=q3=Arcane Khorium Band", "=ds=#sr# 365", "=ds="..AL["Drop"]..": "..ALIL["Netherstorm"] };
				{ 9, "s31056", "24085", "=q3=Khorium Band of Leaves", "=ds=#sr# 360", "=ds="..AL["Drop"]..": "..ALIL["Blade's Edge Mountains"]};
				{ 10, "s37855", "30825", "=q3=Ring of Arcane Shielding", "=ds=#sr# 360", "=ds="..ALIL["The Sha'tar"].." - "..AL["Honored"] };
				{ 11, "s31060", "24088", "=q3=Delicate Eternium Ring", "=ds=#sr# 355", "=ds="..AL["World Drop"] };
				{ 12, "s31054", "24080", "=q3=Khorium Band of Frost", "=ds=#sr# 355", "=ds="..AL["Drop"]..": "..ALIL["The Steamvault"] };
				{ 13, "s31055", "24082", "=q3=Khorium Inferno Band", "=ds=#sr# 355", "=ds="..AtlasLoot:EJ_GetBossName("Darkweaver Syth", 541) };
				{ 14, "s58143", "43246", "=q3=Earthshadow Ring", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 15, "s58144", "43247", "=q3=Jade Ring of Slaying", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 16, "s31053", "24079", "=q3=Khorium Band of Shadows", "=ds=#sr# 350", "=ds="..AL["Drop"]..": "..ALIL["Shadowmoon Valley"] };
				{ 17, "s56193", "42336", "=q2=Bloodstone Band", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 18, "s56194", "42337", "=q2=Sun Rock Ring", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 19, "s31058", "24087", "=q3=Heavy Felsteel Ring", "=ds=#sr# 345", "=ds="..AL["World Drop"] };
				{ 20, "s31052", "24078", "=q2=Heavy Adamantite Ring", "=ds=#sr# 335", "=ds="..AL["Trainer"] };
				{ 21, "s41415", "32774", "=q3=The Black Pearl", "=ds=#sr# 330", "=ds="..AL["Trainer"] };
				{ 22, "s41414", "32772", "=q3=Brilliant Pearl Band", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 23, "s31050", "24076", "=q2=Azure Moonstone Ring", "=ds=#sr# 320", "=ds="..AL["Trainer"] };
				{ 24, "s26916", "21779", "=q3=Band of Natural Fire", "=ds=#sr# 310", "=ds="..AL["Trainer"] };
				{ 25, "s31048", "24074", "=q2=Fel Iron Blood Ring", "=ds=#sr# 305", "=ds="..AL["Trainer"] };
				{ 26, "s31049", "24075", "=q2=Golden Draenite Ring", "=ds=#sr# 305", "=ds="..AL["Trainer"] };
				{ 27, "s34961", "29160", "=q2=Emerald Lion Ring", "=ds=#sr# 290", "=ds="..AL["Trainer"] };
				{ 28, "s26910", "21778", "=q2=Ring of Bitter Shadows", "=ds=#sr# 285", "=ds="..AL["Vendor"]..": "..ALIL["Eastern Plaguelands"] };
				{ 29, "s34960", "29159", "=q2=Glowing Thorium Band", "=ds=#sr# 280", "=ds="..AL["Trainer"] };
				{ 30, "s26907", "21775", "=q2=Onslaught Ring", "=ds=#sr# 280", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s26903", "21768", "=q3=Sapphire Signet", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 2, "s36526", "30422", "=q2=Diamond Focus Ring", "=ds=#sr# 265", "=ds="..AL["Trainer"] };
				{ 3, "s26902", "21767", "=q2=Simple Opal Ring", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
				{ 4, "s26896", "21753", "=q3=Gem Studded Band", "=ds=#sr# 250", "=ds="..AL["World Drop"] };
				{ 5, "s26887", "21754", "=q2=The Aquamarine Ward", "=ds=#sr# 245", "=ds="..AL["World Drop"] };
				{ 6, "s26885", "21765", "=q2=Truesilver Healing Ring", "=ds=#sr# 240", "=ds="..AL["Trainer"] };
				{ 7, "s36525", "30421", "=q2=Red Ring of Destruction", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
				{ 8, "s26874", "20964", "=q3=Aquamarine Signet", "=ds=#sr# 210", "=ds="..AL["Trainer"] };
				{ 9, "s34959", "29158", "=q3=Truesilver Commander's Ring", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 10, "s34955", "29157", "=q3=Golden Ring of Power", "=ds=#sr# 180", "=ds="..AL["Trainer"] };
				{ 11, "s25621", "20961", "=q2=Citrine Ring of Rapid Healing", "=ds=#sr# 180", "=ds="..AL["Trainer"] };
				{ 12, "s25620", "20960", "=q2=Engraved Truesilver Ring", "=ds=#sr# 170", "=ds="..AL["Trainer"] };
				{ 13, "s25619", "20959", "=q2=The Jade Eye", "=ds=#sr# 170", "=ds="..AL["Vendor"] };
				{ 14, "s25617", "20958", "=q2=Blazing Citrine Ring", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 15, "s25613", "20955", "=q2=Golden Dragon Ring", "=ds=#sr# 135", "=ds="..AL["Trainer"] };
				{ 16, "s25323", "20833", "=q2=Wicked Moonstone Ring", "=ds=#sr# 125", "=ds="..AL["Vendor"] };
				{ 17, "s36524", "30420", "=q2=Heavy Jade Ring", "=ds=#sr# 105", "=ds="..AL["Trainer"] };
				{ 18, "s25318", "20828", "=q2=Ring of Twilight Shadows", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 19, "s25305", "20826", "=q3=Heavy Silver Ring", "=ds=#sr# 90", "=ds="..AL["Trainer"] };
				{ 20, "s25317", "20827", "=q2=Ring of Silver Might", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 21, "s25287", "20823", "=q2=Gloom Band", "=ds=#sr# 70", "=ds="..AL["Trainer"] };
				{ 22, "s37818", "30804", "=q3=Bronze Band of Force", "=ds=#sr# 65", "=ds="..AL["Trainer"] };
				{ 23, "s25284", "20820", "=q2=Simple Pearl Ring", "=ds=#sr# 60", "=ds="..AL["Trainer"] };
				{ 24, "s25280", "20818", "=q2=Elegant Silver Ring", "=ds=#sr# 50", "=ds="..AL["Trainer"] };
				{ 25, "s25490", "20907", "=q2=Solid Bronze Ring", "=ds=#sr# 50", "=ds="..AL["Trainer"] };
				{ 26, "s25283", "20821", "=q2=Inlaid Malachite Ring", "=ds=#sr# 30", "=ds="..AL["Trainer"] };
				{ 27, "s32179", "25439", "=q2=Tigerseye Band", "=ds=#sr# 20", "=ds="..AL["Trainer"] };
				{ 28, "s26926", "21932", "=q2=Heavy Copper Ring", "=ds=#sr# 5", "=ds="..AL["Trainer"] };
				{ 29, "s25493", "20906", "=q2=Braided Copper Ring", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
				{ 30, "s26925", "21931", "=q2=Woven Copper Ring", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Ring"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelTrinket"] = {
		["Normal"] = {
			{
				{ 1, "s73640", "52199", "=q3=Figurine - Demon Panther", "=ds=#sr# 475", "=ds=#QUESTID:25047#" };
				{ 2, "s73643", "52354", "=q3=Figurine - Dream Owl", "=ds=#sr# 475", "=ds=#QUESTID:28777#" };
				{ 3, "s73641", "52352", "=q3=Figurine - Earthen Guardian", "=ds=#sr# 475", "=ds=#QUESTID:28776#" };
				{ 4, "s73642", "52353", "=q3=Figurine - Jeweled Serpent", "=ds=#sr# 475", "=ds=#QUESTID:28775#" };
				{ 5, "s73639", "52351", "=q3=Figurine - King of Boars", "=ds=#sr# 475", "=ds=#QUESTID:28778#" };
				{ 7, "s56203", "42418", "=q3=Figurine - Emerald Boar", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 8, "s59759", "44063", "=q3=Figurine - Monarch Crab", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 9, "s56199", "42341", "=q3=Figurine - Ruby Hare", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 10, "s56202", "42413", "=q3=Figurine - Sapphire Owl", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 11, "s56201", "42395", "=q3=Figurine - Twilight Serpent", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 16, "s46777", "35700", "=q4=Figurine - Crimson Serpent", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 17, "s46775", "35693", "=q4=Figurine - Empyrean Tortoise", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 18, "s46776", "35694", "=q4=Figurine - Khorium Boar", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 19, "s46779", "35703", "=q4=Figurine - Seaspray Albatross", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{ 20, "s46778", "35702", "=q4=Figurine - Shadowsong Panther", "=ds=#sr# 375", "=ds="..ALIL["Shattered Sun Offensive"].." - "..AL["Revered"] };
				{
					{ 22, "s31080", "24125", "=q3=Figurine - Dawnstone Crab", "=ds=#sr# 370", "=ds="..ALIL["Thrallmar"].." - "..AL["Revered"] };
					{ 22, "s31080", "24125", "=q3=Figurine - Dawnstone Crab", "=ds=#sr# 370", "=ds="..ALIL["Honor Hold"].." - "..AL["Revered"] };
				};
				{ 23, "s31079", "24124", "=q3=Figurine - Felsteel Boar", "=ds=#sr# 370", "=ds="..ALIL["Lower City"].." - "..AL["Revered"] };
				{ 24, "s31081", "24126", "=q3=Figurine - Living Ruby Serpent", "=ds=#sr# 370", "=ds="..ALIL["Keepers of Time"].." - "..AL["Revered"] };
				{ 25, "s31083", "24128", "=q3=Figurine - Nightseye Panther", "=ds=#sr# 370", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Revered"] };
				{ 26, "s31082", "24127", "=q3=Figurine - Talasite Owl", "=ds=#sr# 370", "=ds="..ALIL["The Sha'tar"].." - "..AL["Revered"] };
			};
			{
				{ 1, "s26912", "21784", "=q3=Figurine - Black Diamond Crab", "=ds=#sr# 300", "=ds="..AtlasLoot:EJ_GetBossName("Quartermaster Zigris", 393) };
				{ 2, "s26914", "21789", "=q3=Figurine - Dark Iron Scorpid", "=ds=#sr# 300", "=ds="..AtlasLoot:EJ_GetBossName("Golem Lord Argelmach", 379) };
				{ 4, "s26909", "21777", "=q2=Figurine - Emerald Owl", "=ds=#sr# 285", "=ds="..AL["World Drop"] };
				{ 5, "s26900", "21769", "=q2=Figurine - Ruby Serpent", "=ds=#sr# 260", "=ds="..AL["World Drop"] };
				{ 6, "s26882", "21763", "=q2=Figurine - Truesilver Boar", "=ds=#sr# 235", "=ds="..AL["World Drop"] };
				{
					{ 7, "s26881", "21760", "=q2=Figurine - Truesilver Crab", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Northern Stranglethorn"] };
					{ 7, "s26881", "21760", "=q2=Figurine - Truesilver Crab", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Dustwallow Marsh"] };
				};
				{
					{ 8, "s26875", "21758", "=q2=Figurine - Black Pearl Panther", "=ds=#sr# 215", "=ds="..AL["Vendor"]..": "..ALIL["Swamp of Sorrows"] };
					{ 8, "s26875", "21758", "=q2=Figurine - Black Pearl Panther", "=ds=#sr# 215", "=ds="..AL["Vendor"]..": "..ALIL["Dustwallow Marsh"] };
				};
				{ 9, "s26873", "21756", "=q2=Figurine - Golden Hare", "=ds=#sr# 200", "=ds="..AL["World Drop"] };
				{ 10, "s26872", "21748", "=q2=Figurine - Jade Owl", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Trinket"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

	AtlasLoot_Data["JewelMisc"] = {
		["Normal"] = {
			{
				{ 1, "s131686", "90401", "=q3=Primordial Ruby", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 2, "s131759", "90406", "=q3=Secrets of the Stone", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 3, "s131691", "90399", "=q3=Imperial Amethyst", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 4, "s131690", "90400", "=q3=Vermilion Onyx", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 5, "s131688", "90397", "=q3=Wild Jade", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 6, "s131593", "90395", "=q3=River's Heart", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 7, "s131695", "90398", "=q3=Sun's Radiance", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 8, "s122663", "83795", "=q1=Scrying Roguestone", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 9, "s73623", "52489", "=q3=Rhinestone Sunglasses", "=ds=#sr# 525", "=ds="..AL["World Drop"] };
				{ 10, "s73478", "52304", "=q3=Fire Prism", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 11, "s140060", "76132", "=q3=Primal Diamond", "=ds=#sr# 500", "=ds="..AL["World Drop"] };
				{ 12, "s140050", "95469", "=q3=Serpent's Heart", "=ds=#sr# 500", "=ds="..AL["World Drop"] };
				{ 13, "s73621", "52493", "=q3=The Perforator", "=ds=#sr# 490", "=ds="..AL["Trainer"] };
				{ 14, "s73627", "52487", "=q3=Jeweler's Amber Monocle", "=ds=#sr# 460", "=ds="..AL["World Drop"] };
				{ 15, "s73620", "52492", "=q2=Carnelian Spikes", "=ds=#sr# 460", "=ds="..AL["Trainer"] };
				{ 16, "s73626", "52486", "=q3=Jeweler's Sapphire Monocle", "=ds=#sr# 455", "=ds="..AL["World Drop"] };
				{ 17, "s73625", "52485", "=q3=Jeweler's Ruby Monocle", "=ds=#sr# 450", "=ds="..AL["World Drop"] };
				{ 18, "s73622", "52490", "=q1=Stardust", "=ds=#sr# 435", "=ds="..AL["Trainer"] };
				{ 19, "s62242", "44943", "=q3=Icy Prism", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 20, "s31078", "24123", "=q4=Circlet of Arcane Might", "=ds=#sr# 370", "=ds="..ALIL["Old Hillsbrad Foothills"] };
				{ 21, "s31077", "24122", "=q4=Coronet of the Verdant Flame", "=ds=#sr# 370", "=ds="..ALIL["The Botanica"] };
				{ 22, "s41418", "32776", "=q3=Crown of the Sea Witch", "=ds=#sr# 365", "=ds="..AL["Trainer"] };
				{ 23, "s47280", "35945", "=q3=Brilliant Glass", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 24, "s56208", "42421", "=q2=Shadow Jade Focusing Lens", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 25, "s56206", "42420", "=q2=Shadow Crystal Focusing Lens", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 26, "s56205", "41367", "=q2=Dark Jade Focusing Lens", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 27, "s38068", "31079", "=q3=Mercurial Adamantite", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 28, "s26906", "21774", "=q3=Emerald Crown of Destruction", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Silithus"] };
				{ 29, "s26878", "20969", "=q3=Ruby Crown of Restoration", "=ds=#sr# 225", "=ds="..AL["Vendor"]..": "..ALIL["Arathi Highlands"] };
				{ 30, "s26880", "21752", "=q1=Thorium Setting", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s32809", "25883", "=q1=Dense Stone Statue", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 2, "s32808", "25882", "=q1=Solid Stone Statue", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 3, "s25615", "20963", "=q1=Mithril Filigree", "=ds=#sr# 150", "=ds="..AL["Trainer"]};
				{ 4, "s25612", "20954", "=q2=Heavy Iron Knuckles", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 5, "s25321", "20832", "=q3=Moonsoul Crown", "=ds=#sr# 120", "=ds="..AL["Trainer"]};
				{ 6, "s32807", "25881", "=q1=Heavy Stone Statue", "=ds=#sr# 110", "=ds="..AL["Trainer"]};
				{ 7, "s25278", "20817", "=q1=Bronze Setting", "=ds=#sr# 50", "=ds="..AL["Trainer"]};
				{ 8, "s32801", "25880", "=q1=Coarse Stone Statue", "=ds=#sr# 50", "=ds="..AL["Trainer"]};
				{ 9, "s25255", "20816", "=q1=Delicate Copper Wire", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 10, "s32259", "25498", "=q1=Rough Stone Statue", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = JEWELCRAFTING..": "..BabbleInventory["Miscellaneous"],
			module = moduleName, menu = "JEWELCRAFTINGMENU"
		};
	};

		----------------------
		--- Leatherworking ---
		----------------------

	AtlasLoot_Data["LeatherLeatherArmorOld"] = {
		["Normal"] = {
			{
				{ 1, "s23709", "19162", "=q4=Corehound Belt", "=ds=#sr# 300"};
				{ 2, "s22927", "18510", "=q4=Hide of the Wild", "=ds=#sr# 300"};
				{ 3, "s23707", "19149", "=q4=Lava Belt", "=ds=#sr# 300"};
				{ 4, "s23710", "19163", "=q4=Molten Belt", "=ds=#sr# 300"};
				{ 5, "s20854", "16983", "=q4=Molten Helm", "=ds=#sr# 300"};
				{ 6, "s28221", "22663", "=q4=Polar Bracers", "=ds=#sr# 300"};
				{ 7, "s28220", "22662", "=q4=Polar Gloves", "=ds=#sr# 300"};
				{ 8, "s28219", "22661", "=q4=Polar Tunic", "=ds=#sr# 300"};
				{ 9, "s24124", "19688", "=q3=Blood Tiger Breastplate", "=ds=#sr# 300"};
				{ 10, "s24125", "19689", "=q3=Blood Tiger Shoulders", "=ds=#sr# 300"};
				{ 11, "s28474", "22761", "=q3=Bramblewood Belt", "=ds=#sr# 300"};
				{ 12, "s28473", "22760", "=q3=Bramblewood Boots", "=ds=#sr# 300"};
				{ 13, "s28472", "22759", "=q3=Bramblewood Helm", "=ds=#sr# 300"};
				{ 14, "s19097", "15062", "=q3=Devilsaur Leggings", "=ds=#sr# 300"};
				{ 15, "s22921", "18504", "=q3=Girdle of Insight", "=ds=#sr# 300"};
				{ 16, "s23706", "19058", "=q3=Golden Mantle of the Dawn", "=ds=#sr# 300"};
				{ 17, "s19095", "15059", "=q3=Living Breastplate", "=ds=#sr# 300"};
				{ 18, "s22922", "18506", "=q3=Mongoose Boots", "=ds=#sr# 300"};
				{ 19, "s24123", "19687", "=q3=Primal Batskin Bracers", "=ds=#sr# 300"};
				{ 20, "s24122", "19686", "=q3=Primal Batskin Gloves", "=ds=#sr# 300"};
				{ 21, "s24121", "19685", "=q3=Primal Batskin Jerkin", "=ds=#sr# 300"};
				{ 22, "s26279", "21278", "=q3=Stormshroud Gloves", "=ds=#sr# 300"};
				{ 23, "s23704", "19049", "=q3=Timbermaw Brawlers", "=ds=#sr# 300"};
				{ 24, "s19104", "15068", "=q2=Frostsaber Tunic", "=ds=#sr# 300"};
				{ 25, "s19102", "15090", "=q2=Runic Leather Armor", "=ds=#sr# 300"};
				{ 26, "s19091", "15095", "=q2=Runic Leather Pants", "=ds=#sr# 300"};
				{ 27, "s19103", "15096", "=q2=Runic Leather Shoulders", "=ds=#sr# 300"};
				{ 28, "s19101", "15055", "=q2=Volcanic Shoulders", "=ds=#sr# 300"};
				{ 29, "s19098", "15085", "=q2=Wicked Leather Armor", "=ds=#sr# 300"};
				{ 30, "s19092", "15088", "=q2=Wicked Leather Belt", "=ds=#sr# 300"};
			};
			{
				{ 1, "s20853", "16982", "=q4=Corehound Boots", "=ds=#sr# 295"};
				{ 2, "s19090", "15058", "=q3=Stormshroud Shoulders", "=ds=#sr# 295"};
				{ 3, "s19087", "15070", "=q2=Frostsaber Gloves", "=ds=#sr# 295"};
				{ 4, "s23705", "19052", "=q3=Dawn Treaders", "=ds=#sr# 290"};
				{ 5, "s19084", "15063", "=q3=Devilsaur Gauntlets", "=ds=#sr# 290"};
				{ 6, "s19086", "15066", "=q3=Ironfeather Breastplate", "=ds=#sr# 290"};
				{ 7, "s23703", "19044", "=q3=Might of the Timbermaw", "=ds=#sr# 290"};
				{ 8, "s19081", "15075", "=q2=Chimeric Vest", "=ds=#sr# 290"};
				{ 9, "s19082", "15094", "=q2=Runic Leather Headband", "=ds=#sr# 290"};
				{ 10, "s19083", "15087", "=q2=Wicked Leather Pants", "=ds=#sr# 290"};
				{ 11, "s19078", "15060", "=q3=Living Leggings", "=ds=#sr# 285"};
				{ 12, "s19079", "15056", "=q3=Stormshroud Armor", "=ds=#sr# 285"};
				{ 13, "s19080", "15065", "=q3=Warbear Woolies", "=ds=#sr# 285"};
				{ 14, "s19074", "15069", "=q2=Frostsaber Leggings", "=ds=#sr# 285"};
				{ 15, "s19076", "15053", "=q2=Volcanic Breastplate", "=ds=#sr# 285"};
				{ 16, "s44953", "34086", "=q1=Winter Boots", "=ds=#sr# 285", "=ds="..AL["Feast of Winter Veil"]};
				{ 17, "s19073", "15072", "=q2=Chimeric Leggings", "=ds=#sr# 280", "=ds="..AL["World Drop"]};
				{ 18, "s19072", "15093", "=q2=Runic Leather Belt", "=ds=#sr# 280", "=ds="..AL["Trainer"]};
				{ 19, "s19071", "15086", "=q2=Wicked Leather Headband", "=ds=#sr# 280", "=ds="..AL["Trainer"]};
				{ 20, "s19067", "15057", "=q3=Stormshroud Pants", "=ds=#sr# 275", "=ds="..AL["Vendor"]};
				{ 21, "s19068", "15064", "=q3=Warbear Harness", "=ds=#sr# 275", "=ds="..AL["Vendor"]};
				{ 22, "s19063", "15073", "=q2=Chimeric Boots", "=ds=#sr# 275", "=ds="..AL["World Drop"]};
				{ 23, "s19065", "15092", "=q2=Runic Leather Bracers", "=ds=#sr# 275", "=ds="..AL["Trainer"]};
				{ 24, "s19066", "15071", "=q2=Frostsaber Boots", "=ds=#sr# 275", "=ds="..AL["Vendor"]};
				{ 25, "s19062", "15067", "=q3=Ironfeather Shoulders", "=ds=#sr# 270", "=ds="..AL["Vendor"]};
				{ 26, "s19061", "15061", "=q3=Living Shoulders", "=ds=#sr# 270", "=ds="..AL["Vendor"]};
				{ 27, "s19055", "15091", "=q2=Runic Leather Gauntlets", "=ds=#sr# 270", "=ds="..AL["Trainer"]};
				{ 28, "s19059", "15054", "=q2=Volcanic Leggings", "=ds=#sr# 270", "=ds="..AL["Drop"]};
				{ 29, "s19053", "15074", "=q2=Chimeric Gloves", "=ds=#sr# 265", "=ds=???"};--pattern removed with Cataclysm
				{ 30, "s19052", "15084", "=q2=Wicked Leather Bracers", "=ds=#sr# 265", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s36074", "29964", "=q3=Blackstorm Leggings", "=ds=#sr# 260", "=ds="..AL["Trainer"]};
				{ 2, "s36075", "29970", "=q3=Wildfeather Leggings", "=ds=#sr# 260", "=ds="..AL["Trainer"]};
				{ 3, "s19049", "15083", "=q2=Wicked Leather Gauntlets", "=ds=#sr# 260", "=ds="..AL["Vendor"]};
				{ 4, "s10647", "8349", "=q3=Feathered Breastplate", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{ 5, "s10632", "8348", "=q3=Helm of Fire", "=ds=#sr# 250", "=ds="..AL["Trainer"]};
				{
					{ 6, "s10572", "8212", "=q2=Wild Leather Leggings", "=ds=#sr# 250", "=ds=#QUESTID:2859#"};
					{ 6, "s10572", "8212", "=q2=Wild Leather Leggings", "=ds=#sr# 250", "=ds=#QUESTID:2852#"};
				};
				{
					{ 7, "s10566", "8213", "=q2=Wild Leather Boots", "=ds=#sr# 245", "=ds=#QUESTID:2858#"};
					{ 7, "s10566", "8213", "=q2=Wild Leather Boots", "=ds=#sr# 245", "=ds=#QUESTID:2851#"};
				};
				{ 8, "s10560", "8202", "=q2=Big Voodoo Pants", "=ds=#sr# 240", "=ds="..AL["World Drop"]};
				{ 9, "s10558", "8197", "=q2=Nightscape Boots", "=ds=#sr# 235", "=ds="..AL["Trainer"]};
				{ 10, "s10630", "8346", "=q3=Gauntlets of the Sea", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 11, "s10548", "8193", "=q2=Nightscape Pants", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 12, "s10621", "8345", "=q3=Wolfshead Helm", "=ds=#sr# 225"};
				{
					{ 13, "s10546", "8214", "=q2=Wild Leather Helmet", "=ds=#sr# 225", "=ds=#QUESTID:2857#"};
					{ 13, "s10546", "8214", "=q2=Wild Leather Helmet", "=ds=#sr# 225", "=ds=#QUESTID:2850#"};
				};
				{
					{ 14, "s10544", "8211", "=q2=Wild Leather Vest", "=ds=#sr# 225", "=ds=#QUESTID:2856#"};
					{ 14, "s10544", "8211", "=q2=Wild Leather Vest", "=ds=#sr# 225", "=ds=#QUESTID:2849#"};
				};
				{ 15, "s10531", "8201", "=q2=Big Voodoo Mask", "=ds=#sr# 220", "=ds="..AL["World Drop"]};
				{
					{ 16, "s10529", "8210", "=q2=Wild Leather Shoulders", "=ds=#sr# 220", "=ds=#QUESTID:2855#"};
					{ 16, "s10529", "8210", "=q2=Wild Leather Shoulders", "=ds=#sr# 220", "=ds=#QUESTID:2848#"};
				};
				{ 17, "s10520", "8200", "=q2=Big Voodoo Robe", "=ds=#sr# 215", "=ds="..AL["World Drop"]};
				{ 18, "s10516", "8192", "=q2=Nightscape Shoulders", "=ds=#sr# 210", "=ds="..AL["Vendor"]};
				{ 19, "s10507", "8176", "=q2=Nightscape Headband", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 20, "s10499", "8175", "=q2=Nightscape Tunic", "=ds=#sr# 205", "=ds="..AL["Trainer"]};
				{ 21, "s10490", "8174", "=q3=Comfortable Leather Hat", "=ds=#sr# 200", "=ds="..AL["World Drop"]};
				{ 22, "s3779", "4264", "=q2=Barbaric Belt", "=ds=#sr# 200", "=ds="..AL["World Drop"]};
				{ 23, "s9207", "7390", "=q2=Dusky Boots", "=ds=#sr# 200", "=ds="..AL["World Drop"]};
				{ 24, "s22711", "18238", "=q3=Shadowskin Gloves", "=ds=#sr# 200", "=ds="..AL["Vendor"]};
				{ 25, "s9208", "7391", "=q2=Swift Boots", "=ds=#sr# 200", "=ds="..AL["World Drop"]};
				{ 26, "s9206", "7387", "=q2=Dusky Belt", "=ds=#sr# 195", "=ds="..AL["Trainer"]};
				{ 27, "s3777", "4260", "=q2=Guardian Leather Bracers", "=ds=#sr# 195", "=ds="..AL["World Drop"]};
				{ 28, "s21943", "17721", "=q2=Gloves of the Greatfather", "=ds=#sr# 190", "=ds="..AL["Feast of Winter Veil"]};
				{ 29, "s9202", "7386", "=q2=Green Whelp Bracers", "=ds=#sr# 190", "=ds="..AL["Vendor"]};
				{ 30, "s6705", "5783", "=q2=Murloc Scale Bracers", "=ds=#sr# 190", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, "s6661", "5739", "=q1=Barbaric Harness", "=ds=#sr# 190", "=ds="..AL["Trainer"]};
				{ 2, "s7156", "5966", "=q1=Guardian Gloves", "=ds=#sr# 190", "=ds="..AL["Trainer"]};
				{ 3, "s3778", "4262", "=q3=Gem-studded Leather Belt", "=ds=#sr# 185", "=ds="..AL["Vendor"]};
				{ 4, "s9201", "7378", "=q2=Dusky Bracers", "=ds=#sr# 185", "=ds="..AL["Trainer"]};
				{ 5, "s3776", "4259", "=q2=Green Leather Bracers", "=ds=#sr# 180", "=ds="..AL["Trainer"]};
				{ 6, "s7151", "5964", "=q2=Barbaric Shoulders", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 7, "s9196", "7374", "=q2=Dusky Leather Armor", "=ds=#sr# 175", "=ds="..AL["Trainer"]};
				{ 8, "s9197", "7375", "=q2=Green Whelp Armor", "=ds=#sr# 175", "=ds="..AL["World Drop"]};
				{ 9, "s3773", "4256", "=q2=Guardian Armor", "=ds=#sr# 175", "=ds="..AL["World Drop"]};
				{ 10, "s7149", "5963", "=q2=Barbaric Leggings", "=ds=#sr# 170", "=ds="..AL["Vendor"]};
				{ 11, "s3775", "4258", "=q2=Guardian Belt", "=ds=#sr# 170", "=ds="..AL["World Drop"]};
				{ 12, "s6704", "5782", "=q2=Thick Murloc Armor", "=ds=#sr# 170", "=ds="..AL["Vendor"]};
				{ 13, "s9195", "7373", "=q2=Dusky Leather Leggings", "=ds=#sr# 165", "=ds="..AL["World Drop"]};
				{ 14, "s4097", "4456", "=q2=Raptor Hide Belt", "=ds=#sr# 165", "=ds="..AL["Vendor"]};
				{ 15, "s4096", "4455", "=q2=Raptor Hide Harness", "=ds=#sr# 165", "=ds="..AL["Vendor"]};
				{ 16, "s3774", "4257", "=q2=Green Leather Belt", "=ds=#sr# 160", "=ds="..AL["Trainer"]};
				{ 17, "s7147", "5962", "=q2=Guardian Pants", "=ds=#sr# 160", "=ds="..AL["Trainer"]};
				{ 18, "s23399", "18948", "=q3=Barbaric Bracers", "=ds=#sr# 155", "=ds="..AL["Vendor"]};
				{ 19, "s3772", "4255", "=q2=Green Leather Armor", "=ds=#sr# 155", "=ds="..AL["Vendor"]};
				{ 20, "s3771", "4254", "=q2=Barbaric Gloves", "=ds=#sr# 150", "=ds="..AL["World Drop"]};
				{ 21, "s9149", "7359", "=q2=Heavy Earthen Gloves", "=ds=#sr# 145", "=ds="..AL["World Drop"]};
				{ 22, "s3764", "4247", "=q2=Hillman's Leather Gloves", "=ds=#sr# 145", "=ds="..AL["Trainer"]};
				{ 23, "s3769", "4252", "=q2=Dark Leather Shoulders", "=ds=#sr# 140", "=ds="..AL["World Drop"]};
				{ 24, "s9148", "7358", "=q2=Pilferer's Gloves", "=ds=#sr# 140", "=ds="..AL["World Drop"]};
				{ 25, "s3770", "4253", "=q3=Toughened Leather Gloves", "=ds=#sr# 135", "=ds="..AL["Trainer"]};
				{ 26, "s9147", "7352", "=q2=Earthen Leather Shoulders", "=ds=#sr# 135", "=ds="..AL["Vendor"]};
				{ 27, "s9146", "7349", "=q2=Herbalist's Gloves", "=ds=#sr# 135", "=ds="..AL["Vendor"]};
				{ 28, "s3768", "4251", "=q2=Hillman's Shoulders", "=ds=#sr# 130", "=ds="..AL["Trainer"]};
				{ 29, "s9145", "7348", "=q3=Fletcher's Gloves", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
				{ 30, "s3766", "4249", "=q2=Dark Leather Belt", "=ds=#sr# 125", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s2166", "2314", "=q3=Toughened Leather Armor", "=ds=#sr# 120", "=ds="..AL["Trainer"]};
				{ 2, "s3765", "4248", "=q2=Dark Leather Gloves", "=ds=#sr# 120", "=ds="..AL["World Drop"]};
				{ 3, "s3767", "4250", "=q2=Hillman's Belt", "=ds=#sr# 120", "=ds="..AL["World Drop"]};
				{ 4, "s9074", "7285", "=q2=Nimble Leather Gloves", "=ds=#sr# 120", "=ds="..AL["Trainer"]};
				{ 5, "s9072", "7284", "=q2=Red Whelp Gloves", "=ds=#sr# 120", "=ds="..AL["Vendor"]};
				{ 6, "s7955", "6468", "=q3=Deviate Scale Belt", "=ds=#sr# 115", "=ds="..BabbleInventory["Quest"]};--quest was removed with Cataclysm
				{ 7, "s7135", "5961", "=q2=Dark Leather Pants", "=ds=#sr# 115", "=ds="..AL["Trainer"]};
				{ 8, "s7954", "6467", "=q2=Deviate Scale Gloves", "=ds=#sr# 105", "=ds="..AL["Vendor"]};
				{ 9, "s7133", "5958", "=q2=Fine Leather Pants", "=ds=#sr# 105", "=ds="..AL["World Drop"]};
				{ 10, "s24940", "20575", "=q2=Black Whelp Tunic", "=ds=#sr# 100", "=ds="..AL["Vendor"]};
				{ 11, "s2167", "2315", "=q2=Dark Leather Boots", "=ds=#sr# 100", "=ds="..AL["Trainer"]};
				{ 12, "s2169", "2317", "=q2=Dark Leather Tunic", "=ds=#sr# 100", "=ds="..AL["World Drop"]};
				{ 13, "s3762", "4244", "=q2=Hillman's Leather Vest", "=ds=#sr# 100", "=ds="..AL["World Drop"]};
				{ 14, "s9068", "7282", "=q2=Light Leather Pants", "=ds=#sr# 95", "=ds="..AL["Trainer"]};
				{ 15, "s6703", "5781", "=q2=Murloc Scale Breastplate", "=ds=#sr# 95", "=ds="..AL["Vendor"]};
				{ 16, "s2158", "2307", "=q2=Fine Leather Boots", "=ds=#sr# 90", "=ds="..AL["World Drop"]};
				{ 17, "s8322", "6709", "=q2=Moonglow Vest", "=ds=#sr# 90", "=ds=#QUESTID:1582#"};
				{ 18, "s6702", "5780", "=q2=Murloc Scale Belt", "=ds=#sr# 90", "=ds="..AL["Vendor"]};
				{ 19, "s3761", "4243", "=q2=Fine Leather Tunic", "=ds=#sr# 85", "=ds="..AL["Trainer"]};
				{ 20, "s3763", "4246", "=q2=Fine Leather Belt", "=ds=#sr# 80", "=ds="..AL["Trainer"]};
				{ 21, "s3759", "4242", "=q2=Embossed Leather Pants", "=ds=#sr# 75", "=ds="..AL["Trainer"]};
				{ 22, "s2164", "2312", "=q2=Fine Leather Gloves", "=ds=#sr# 75", "=ds="..AL["World Drop"]};
				{ 23, "s9065", "7281", "=q2=Light Leather Bracers", "=ds=#sr# 70", "=ds="..AL["Trainer"]};
				{ 24, "s2163", "2311", "=q2=White Leather Jerkin", "=ds=#sr# 60", "=ds="..AL["World Drop"]};
				{ 25, "s2161", "2309", "=q2=Embossed Leather Boots", "=ds=#sr# 55", "=ds="..AL["Trainer"]};
				{ 26, "s3756", "4239", "=q2=Embossed Leather Gloves", "=ds=#sr# 55", "=ds="..AL["Trainer"]};
				{ 27, "s2160", "2300", "=q2=Embossed Leather Vest", "=ds=#sr# 40", "=ds="..AL["Trainer"]};
				{ 28, "s9064", "7280", "=q2=Rugged Leather Pants", "=ds=#sr# 35", "=ds="..AL["World Drop"]};
				{ 29, "s3753", "4237", "=q1=Handstitched Leather Belt", "=ds=#sr# 25", "=ds="..AL["Trainer"]};
				{ 30, "s2153", "2303", "=q1=Handstitched Leather Pants", "=ds=#sr# 15", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s2149", "2302", "=q1=Handstitched Leather Boots", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 2, "s9059", "7277", "=q1=Handstitched Leather Bracers", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
				{ 3, "s7126", "5957", "=q1=Handstitched Leather Vest", "=ds=#sr# 1", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Leather Armor"].." - "..AL["Classic WoW"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherLeatherArmorBC"] = {
		["Normal"] = {
			{
				{ 1, "s36351", "30040", "=q4=Belt of Deep Shadow", "=ds=#sr# 375"};
				{ 2, "s36349", "30042", "=q4=Belt of Natural Power", "=ds=#sr# 375"};
				{ 3, "s36355", "30041", "=q4=Boots of Natural Grace", "=ds=#sr# 375"};
				{ 4, "s36357", "30039", "=q4=Boots of Utter Darkness", "=ds=#sr# 375"};
				{ 5, "s41156", "32582", "=q4=Bracers of Renewed Life", "=ds=#sr# 375"};
				{ 6, "s35590", "29526", "=q4=Primalstrike Belt", "=ds=#sr# 375"};
				{ 7, "s35591", "29527", "=q4=Primalstrike Bracers", "=ds=#sr# 375"};
				{ 8, "s35589", "29525", "=q4=Primalstrike Vest", "=ds=#sr# 375"};
				{ 9, "s40006", "32393", "=q4=Redeemed Soul Cinch", "=ds=#sr# 375"};
				{ 10, "s40005", "32396", "=q4=Redeemed Soul Legguards", "=ds=#sr# 375"};
				{ 11, "s40003", "32394", "=q4=Redeemed Soul Moccasins", "=ds=#sr# 375"};
				{ 12, "s40004", "32395", "=q4=Redeemed Soul Wristguards", "=ds=#sr# 375"};
				{ 13, "s41157", "32583", "=q4=Shoulderpads of Renewed Life", "=ds=#sr# 375"};
				{ 14, "s41158", "32580", "=q4=Swiftstrike Bracers", "=ds=#sr# 375"};
				{ 15, "s41160", "32581", "=q4=Swiftstrike Shoulders", "=ds=#sr# 375"};
				{ 16, "s35587", "29524", "=q4=Windhawk Belt", "=ds=#sr# 375"};
				{ 17, "s35588", "29523", "=q4=Windhawk Bracers", "=ds=#sr# 375"};
				{ 18, "s35585", "29522", "=q4=Windhawk Hauberk", "=ds=#sr# 375"};
				{ 19, "s46138", "34369", "=q4=Carapace of Sun and Shadow", "=ds=#sr# 365"};
				{ 20, "s35559", "29503", "=q4=Cobrascale Gloves", "=ds=#sr# 365"};
				{ 21, "s35558", "29502", "=q4=Cobrascale Hood", "=ds=#sr# 365"};
				{ 22, "s46134", "34370", "=q4=Gloves of Immortal Dusk", "=ds=#sr# 365"};
				{ 23, "s35562", "29506", "=q4=Gloves of the Living Touch", "=ds=#sr# 365"};
				{ 24, "s35561", "29505", "=q4=Hood of Primal Life", "=ds=#sr# 365"};
				{ 25, "s46136", "34371", "=q4=Leather Chestguard of the Sun", "=ds=#sr# 365"};
				{ 26, "s46132", "34372", "=q4=Leather Gauntlets of the Sun", "=ds=#sr# 365"};
				{ 27, "s42731", "33204", "=q4=Shadowprowler's Chestguard", "=ds=#sr# 365"};
				{ 28, "s35560", "29504", "=q4=Windscale Hood", "=ds=#sr# 365"};
				{ 29, "s35563", "29507", "=q4=Windslayer Wraps", "=ds=#sr# 365"};
				{ 30, "s32495", "25689", "=q3=Heavy Clefthoof Vest", "=ds=#sr# 360"};
			};
			{
				{ 1, "s32497", "25691", "=q3=Heavy Clefthoof Boots", "=ds=#sr# 355"};
				{ 2, "s32496", "25690", "=q3=Heavy Clefthoof Leggings", "=ds=#sr# 355"};
				{ 3, "s35537", "29500", "=q3=Blastguard Belt", "=ds=#sr# 350"};
				{ 4, "s35536", "29499", "=q3=Blastguard Boots", "=ds=#sr# 350"};
				{ 5, "s35535", "29498", "=q3=Blastguard Pants", "=ds=#sr# 350"};
				{ 6, "s35534", "29497", "=q3=Enchanted Clefthoof Boots", "=ds=#sr# 350"};
				{ 7, "s35533", "29496", "=q3=Enchanted Clefthoof Gloves", "=ds=#sr# 350"};
				{ 8, "s35532", "29495", "=q3=Enchanted Clefthoof Leggings", "=ds=#sr# 350"};
				{ 9, "s32493", "25686", "=q3=Fel Leather Boots", "=ds=#sr# 350"};
				{ 10, "s32494", "25687", "=q3=Fel Leather Leggings", "=ds=#sr# 350"};
				{ 11, "s32489", "25682", "=q3=Stylin' Jungle Hat", "=ds=#sr# 350"};
				{ 12, "s32485", "25680", "=q3=Stylin' Purple Hat", "=ds=#sr# 350"};
				{ 13, "s32490", "25685", "=q3=Fel Leather Gloves", "=ds=#sr# 340"};
				{ 14, "s36078", "29974", "=q3=Living Crystal Breastplate", "=ds=#sr# 330"};
				{ 15, "s36077", "29973", "=q3=Primalstorm Breastplate", "=ds=#sr# 330"};
				{ 16, "s32473", "25671", "=q2=Thick Draenic Vest", "=ds=#sr# 330"};
				{ 17, "s32481", "25676", "=q2=Wild Draenish Vest", "=ds=#sr# 330"};
				{ 18, "s32472", "25668", "=q2=Thick Draenic Boots", "=ds=#sr# 320"};
				{ 19, "s32480", "25675", "=q2=Wild Draenish Leggings", "=ds=#sr# 320"};
				{ 20, "s32471", "25670", "=q2=Thick Draenic Pants", "=ds=#sr# 315"};
				{ 21, "s32479", "25674", "=q2=Wild Draenish Gloves", "=ds=#sr# 310"};
				{ 22, "s32470", "25669", "=q2=Thick Draenic Gloves", "=ds=#sr# 300"};
				{ 23, "s32478", "25673", "=q2=Wild Draenish Boots", "=ds=#sr# 300"};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Leather Armor"].." - "..AL["Burning Crusade"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherLeatherArmorWrath"] = {
		["Normal"] = {
			{
				{ 1, "s70556", "49899", "=q4=Bladeborn Leggings", "=ds="..AL["Vendor"]..""};
				{ 2, "s70555", "49894", "=q4=Blessed Cenarion Boots", "=ds="..AL["Vendor"]..""};
				{ 3, "s70557", "49895", "=q4=Footpads of Impending Death", "=ds="..AL["Vendor"]..""};
				{ 4, "s70554", "49898", "=q4=Legwraps of Unleashed Nature", "=ds="..AL["Vendor"]..""};
				{ 5, "s67142", "47600", "=q4=Knightbane Carapace", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 6, "s67086", "47599", "=q4=Knightbane Carapace", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 7, "s67084", "47602", "=q4=Lunar Eclipse Chestguard", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 8, "s67140", "47601", "=q4=Lunar Eclipse Chestguard", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 9, "s67087", "47581", "=q4=Bracers of Swift Death", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 10, "s67139", "47582", "=q4=Bracers of Swift Death", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 11, "s67085", "47583", "=q4=Moonshadow Armguards", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 12, "s67141", "47584", "=q4=Moonshadow Armguards", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 13, "s63200", "45556", "=q4=Belt of Arctic Life", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 14, "s63201", "45565", "=q4=Boots of Wintry Endurance", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 15, "s63198", "45555", "=q4=Death-warmed Belt", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 16, "s63199", "45564", "=q4=Footpads of Silence", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 17, "s60760", "43495", "=q4=Earthgiving Legguards", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 18, "s60761", "43502", "=q4=Earthgiving Boots", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 19, "s60758", "43481", "=q4=Trollwoven Spaulders", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 20, "s60759", "43484", "=q4=Trollwoven Girdle", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 21, "s60996", "43590", "=q4=Polar Vest", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 22, "s60997", "43591", "=q4=Polar Cord", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 23, "s60998", "43592", "=q4=Polar Boots", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 24, "s62176", "44930", "=q4=Windripper Boots", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 25, "s62177", "44931", "=q4=Windripper Leggings", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 26, "s60697", "43260", "=q3=Eviscerator's Facemask", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 27, "s60702", "43433", "=q3=Eviscerator's Shoulderpads", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 28, "s60703", "43434", "=q3=Eviscerator's Chestguard", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 29, "s60704", "43435", "=q3=Eviscerator's Bindings", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 30, "s60705", "43436", "=q3=Eviscerator's Gauntlets", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
			};
			{
				{ 1, "s60706", "43437", "=q3=Eviscerator's Waistguard", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 2, "s60711", "43438", "=q3=Eviscerator's Legguards", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 3, "s60712", "43439", "=q3=Eviscerator's Treads", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 4, "s60715", "43261", "=q3=Overcast Headguard", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 5, "s60716", "43262", "=q3=Overcast Spaulders", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 6, "s60718", "43263", "=q3=Overcast Chestguard", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 7, "s60720", "43264", "=q3=Overcast Bracers", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 8, "s60721", "43265", "=q3=Overcast Handwraps", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 9, "s60723", "43266", "=q3=Overcast Belt", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 10, "s60725", "43271", "=q3=Overcast Leggings", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 11, "s60727", "43273", "=q3=Overcast Boots", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 12, "s60669", "43257", "=q3=Wildscale Breastplate", "=ds="..AL["Trainer"]};
				{ 13, "s60660", "42731", "=q3=Leggings of Visceral Strikes", "=ds="..AL["Trainer"]};
				{ 14, "s60671", "43258", "=q3=Purehorn Spaulders", "=ds="..AL["Trainer"]};
				{ 15, "s60665", "43255", "=q3=Seafoam Gauntlets", "=ds="..AL["Trainer"]};
				{ 16, "s60666", "43256", "=q3=Jormscale Footpads", "=ds="..AL["Trainer"]};
				{ 17, "s51568", "38590", "=q3=Black Chitinguard Boots", "=ds="..AL["Trainer"]};
				{ 18, "s60620", "44442", "=q3=Bugsquashers", "=ds="..AL["Trainer"]};
				{ 19, "s51570", "38592", "=q3=Dark Arctic Chestpiece", "=ds="..AL["Trainer"]};
				{ 20, "s51569", "38591", "=q3=Dark Arctic Leggings", "=ds="..AL["Trainer"]};
				{ 21, "s60613", "44441", "=q3=Dark Iceborne Chestguard", "=ds="..AL["Trainer"]};
				{ 22, "s60611", "44440", "=q3=Dark Iceborne Leggings", "=ds="..AL["Trainer"]};
				{ 23, "s51572", "38437", "=q2=Arctic Helm", "=ds="..AL["Trainer"]};
				{ 24, "s50946", "38402", "=q2=Arctic Shoulderpads", "=ds="..AL["Trainer"]};
				{ 25, "s50944", "38400", "=q2=Arctic Chestpiece", "=ds="..AL["Trainer"]};
				{ 26, "s51571", "38433", "=q2=Arctic Wristguards", "=ds="..AL["Trainer"]};
				{ 27, "s50947", "38403", "=q2=Arctic Gloves", "=ds="..AL["Trainer"]};
				{ 28, "s50949", "38405", "=q2=Arctic Belt", "=ds="..AL["Trainer"]};
				{ 29, "s50945", "38401", "=q2=Arctic Leggings", "=ds="..AL["Trainer"]};
				{ 30, "s50948", "38404", "=q2=Arctic Boots", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s60608", "38438", "=q2=Iceborne Helm", "=ds="..AL["Trainer"]};
				{ 2, "s50940", "38411", "=q2=Iceborne Shoulderpads", "=ds="..AL["Trainer"]};
				{ 3, "s50938", "38408", "=q2=Iceborne Chestguard", "=ds="..AL["Trainer"]};
				{ 4, "s60607", "38434", "=q2=Iceborne Wristguards", "=ds="..AL["Trainer"]};
				{ 5, "s50941", "38409", "=q2=Iceborne Gloves", "=ds="..AL["Trainer"]};
				{ 6, "s50943", "38406", "=q2=Iceborne Belt", "=ds="..AL["Trainer"]};
				{ 7, "s50939", "38410", "=q2=Iceborne Leggings", "=ds="..AL["Trainer"]};
				{ 8, "s50942", "38407", "=q2=Iceborne Boots", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Leather Armor"].." - "..AL["Wrath of the Lich King"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};
	
	AtlasLoot_Data["LeatherLeatherArmorCata"] = {
		["Normal"] = {
			{
				{ 1, "s101940", "71994", "=q4=Bladeshadow Wristguards", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 2, "s101937", "71995", "=q4=Bracers of Flowing Serenity", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 3, "s101935", "71985", "=q4=Bladeshadow Leggings", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 4, "s101933", "71986", "=q4=Leggings of Nature's Champion", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 5, "s99446", "69942", "=q4=Clutches of Evil", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 6, "s99447", "69943", "=q4=Heavenly Gloves of the Moon", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 7, "s99458", "69952", "=q4=Ethereal Footfalls", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 8, "s99457", "69951", "=q4=Treads of the Craft", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 9, "s78488", "56562", "=q4=Assassin's Chestplate", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 10, "s78461", "56537", "=q4=Belt of Nefarious Whispers", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 11, "s78487", "56561", "=q4=Chestguard of Nature's Fury", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 12, "s78460", "56536", "=q4=Lightning Lash", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 13, "s78481", "75103", "=q3=Vicious Leather Chest", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 14, "s78482", "75112", "=q3=Vicious Leather Legs", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 15, "s78480", "75111", "=q3=Vicious Wyrmhide Helm", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 16, "s78479", "75080", "=q3=Vicious Wyrmhide Legs", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 17, "s78468", "75127", "=q3=Vicious Leather Belt", "=ds=#sr# 520", "=ds="..AL["Vendor"] };
				{ 18, "s78469", "75105", "=q3=Vicious Leather Helm", "=ds=#sr# 520", "=ds="..AL["Vendor"] };
				{ 19, "s78467", "75107", "=q3=Vicious Wyrmhide Chest", "=ds=#sr# 520", "=ds="..AL["Vendor"] };
				{ 20, "s78464", "75099", "=q3=Vicious Wyrmhide Shoulders", "=ds=#sr# 520", "=ds="..AL["Vendor"] };
				{ 21, "s78454", "75130", "=q3=Vicious Leather Boots", "=ds=#sr# 515", "=ds="..AL["Vendor"] };
				{ 22, "s78455", "75113", "=q3=Vicious Leather Shoulders", "=ds=#sr# 515", "=ds="..AL["Vendor"] };
				{ 23, "s78453", "75101", "=q3=Vicious Wyrmhide Boots", "=ds=#sr# 515", "=ds="..AL["Vendor"] };
				{ 24, "s78452", "75109", "=q3=Vicious Wyrmhide Gloves", "=ds=#sr# 515", "=ds="..AL["Vendor"] };
				{ 25, "s78446", "75131", "=q3=Vicious Leather Bracers", "=ds=#sr# 510", "=ds="..AL["Vendor"] };
				{ 26, "s78447", "75104", "=q3=Vicious Leather Gloves", "=ds=#sr# 510", "=ds="..AL["Vendor"] };
				{ 27, "s78445", "75117", "=q3=Vicious Wyrmhide Belt", "=ds=#sr# 510", "=ds="..AL["Vendor"] };
				{ 28, "s78444", "75106", "=q3=Vicious Wyrmhide Bracers", "=ds=#sr# 510", "=ds="..AL["Vendor"] };
				{ 29, "s78424", "56505", "=q2=Darkbrand Helm", "=ds=#sr# 490", "=ds="..AL["Trainer"] };
				{ 30, "s78433", "56513", "=q3=Darkbrand Leggings", "=ds=#sr# 485", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s78428", "56509", "=q2=Darkbrand Chestguard", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 2, "s78399", "56484", "=q3=Darkbrand Gloves", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 3, "s78411", "56495", "=q2=Darkbrand Shoulders", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 4, "s78407", "56491", "=q2=Darkbrand Boots", "=ds=#sr# 470", "=ds="..AL["Trainer"] };
				{ 5, "s78416", "56499", "=q2=Darkbrand Belt", "=ds=#sr# 455", "=ds="..AL["Trainer"] };
				{ 6, "s78398", "56483", "=q2=Darkbrand Bracers", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Leather Armor"].." - "..AL["Cataclysm"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherLeatherArmorMoP"] = {
		["Normal"] = {
			{
				{ 1, "s142961", "98609", "=q4=Pennyroyal Belt", "=ds=#s10#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 2, "s142965", "98613", "=q4=Snow Lily Belt", "=ds=#s10#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 3, "s142952", "98600", "=q4=Pennyroyal Leggings", "=ds=#s11#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 4, "s142956", "98604", "=q4=Snow Lily Britches", "=ds=#s11#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 5, "s124638", "85788", "=q4=Chestguard of Nemeses", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 6, "s124640", "85829", "=q4=Nightfire Robe", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 7, "s124641", "85827", "=q4=Liferuned Leather Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 8, "s124639", "85828", "=q4=Murderer's Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 9, "s124619", "85823", "=q4=Greyshadow Chestguard", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 10, "s124621", "85850", "=q4=Wildblood Vest", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 11, "s124620", "85824", "=q4=Greyshadow Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 12, "s124622", "85849", "=q4=Wildblood Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 13, "s143106", "98806", "=q3=Crafted Malevolent Gladiator's Wyrmhide Helm", "=ds=#s1#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 14, "s143109", "98809", "=q3=Crafted Malevolent Gladiator's Wyrmhide Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 15, "s143108", "98808", "=q3=Crafted Malevolent Gladiator's Wyrmhide Robes", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 16, "s143105", "98805", "=q3=Crafted Malevolent Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 17, "s143107", "98807", "=q3=Crafted Malevolent Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 18, "s143090", "98790", "=q3=Crafted Malevolent Gladiator's Dragonhide Helm", "=ds=#s1#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 19, "s143093", "98793", "=q3=Crafted Malevolent Gladiator's Dragonhide Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 20, "s143092", "98792", "=q3=Crafted Malevolent Gladiator's Dragonhide Robes", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 21, "s143089", "98789", "=q3=Crafted Malevolent Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 22, "s143091", "98791", "=q3=Crafted Malevolent Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 23, "s143098", "98798", "=q3=Crafted Malevolent Gladiator's Kodohide Helm", "=ds=#s1#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 24, "s143101", "98801", "=q3=Crafted Malevolent Gladiator's Kodohide Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 25, "s143100", "98800", "=q3=Crafted Malevolent Gladiator's Kodohide Robes", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 26, "s143097", "98797", "=q3=Crafted Malevolent Gladiator's Kodohide Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 27, "s143099", "98799", "=q3=Crafted Malevolent Gladiator's Kodohide Legguards", "=ds=#s11#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 28, "s143119", "98839", "=q3=Crafted Malevolent Gladiator's Copperskin Helm", "=ds=#s1#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 29, "s143121", "98841", "=q3=Crafted Malevolent Gladiator's Copperskin Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 30, "s143122", "98842", "=q3=Crafted Malevolent Gladiator's Copperskin Tunic", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
			};
			{
				{ 1, "s143118", "98838", "=q3=Crafted Malevolent Gladiator's Copperskin Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 2, "s143120", "98840", "=q3=Crafted Malevolent Gladiator's Copperskin Legguards", "=ds=#s11#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 3, "s143114", "98834", "=q3=Crafted Malevolent Gladiator's Ironskin Helm", "=ds=#s1#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 4, "s143116", "98836", "=q3=Crafted Malevolent Gladiator's Ironskin Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 5, "s143117", "98837", "=q3=Crafted Malevolent Gladiator's Ironskin Tunic", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 6, "s143113", "98833", "=q3=Crafted Malevolent Gladiator's Ironskin Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 7, "s143115", "98835", "=q3=Crafted Malevolent Gladiator's Ironskin Legguards", "=ds=#s11#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 8, "s143128", "98886", "=q3=Crafted Malevolent Gladiator's Leather Helm", "=ds=#s1#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 9, "s143130", "98888", "=q3=Crafted Malevolent Gladiator's Leather Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 10, "s143126", "98884", "=q3=Crafted Malevolent Gladiator's Leather Tunic", "=ds=#s5#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 11, "s143127", "98885", "=q3=Crafted Malevolent Gladiator's Leather Gloves", "=ds=#s9#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 12, "s143129", "98887", "=q3=Crafted Malevolent Gladiator's Leather Legguards", "=ds=#s11#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 13, "s143112", "98832", "=q3=Crafted Malevolent Gladiator's Armwraps of Accuracy", "=ds=#s8#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 14, "s143125", "98883", "=q3=Crafted Malevolent Gladiator's Armwraps of Alacrity", "=ds=#s8#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 15, "s143096", "98796", "=q3=Crafted Malevolent Gladiator's Bindings of Meditation", "=ds=#s8#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 16, "s143104", "98804", "=q3=Crafted Malevolent Gladiator's Bindings of Prowess", "=ds=#s8#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 17, "s143102", "98802", "=q3=Crafted Malevolent Gladiator's Belt of Cruelty", "=ds=#s10#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 18, "s143094", "98794", "=q3=Crafted Malevolent Gladiator's Belt of Meditation", "=ds=#s10#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 19, "s143123", "98881", "=q3=Crafted Malevolent Gladiator's Waistband of Accuracy", "=ds=#s10#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 20, "s143110", "98830", "=q3=Crafted Malevolent Gladiator's Waistband of Cruelty", "=ds=#s10#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 21, "s143111", "98831", "=q3=Crafted Malevolent Gladiator's Boots of Alacrity", "=ds=#s12#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 22, "s143124", "98882", "=q3=Crafted Malevolent Gladiator's Boots of Cruelty", "=ds=#s12#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 23, "s143103", "98803", "=q3=Crafted Malevolent Gladiator's Footguards of Alacrity", "=ds=#s12#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 24, "s143095", "98795", "=q3=Crafted Malevolent Gladiator's Footguards of Meditation", "=ds=#s12#, #a2# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 25, "s124603", "85802", "=q3=Contender's Leather Helm", "=ds=#s1#, #a2# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 26, "s124605", "85800", "=q3=Contender's Leather Chestguard", "=ds=#s5#, #a2# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 27, "s124587", "85818", "=q3=Contender's Wyrmhide Helm", "=ds=#s1#, #a2# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 28, "s124589", "85816", "=q3=Contender's Wyrmhide Chestguard", "=ds=#s5#, #a2# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 29, "s124604", "85804", "=q3=Contender's Leather Shoulders", "=ds=#s3#, #a2# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 30, "s124588", "85820", "=q3=Contender's Wyrmhide Shoulders", "=ds=#s3#, #a2# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, "s124606", "85801", "=q3=Contender's Leather Gloves", "=ds=#s9#, #a2# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 2, "s124610", "85797", "=q3=Contender's Leather Belt", "=ds=#s10#, #a2# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 3, "s124607", "85803", "=q3=Contender's Leather Leggings", "=ds=#s11#, #a2# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 4, "s124609", "85798", "=q3=Contender's Leather Boots", "=ds=#s12#, #a2# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 5, "s124590", "85817", "=q3=Contender's Wyrmhide Gloves", "=ds=#s9#, #a2# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 6, "s124594", "85813", "=q3=Contender's Wyrmhide Belt", "=ds=#s10#, #a2# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 7, "s124591", "85819", "=q3=Contender's Wyrmhide Leggings", "=ds=#s11#, #a2# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 8, "s124593", "85814", "=q3=Contender's Wyrmhide Boots", "=ds=#s12#, #a2# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 9, "s124573", "85835", "=q2=Misthide Chestguard", "=ds=#s5#, #a2# / =q1=#sk# 560", "=ds="..AL["Trainer"]};
				{ 10, "s124608", "85799", "=q3=Contender's Leather Bracers", "=ds=#s8#, #a2# / =q1=#sk# 555", "=ds="..AL["Vendor"]};
				{ 11, "s124592", "85815", "=q3=Contender's Wyrmhide Bracers", "=ds=#s8#, #a2# / =q1=#sk# 555", "=ds="..AL["Vendor"]};
				{ 12, "s124571", "85837", "=q2=Misthide Helm", "=ds=#s1#, #a2# / =q1=#sk# 555", "=ds="..AL["Trainer"]};
				{ 13, "s124575", "85838", "=q2=Misthide Leggings", "=ds=#s11#, #a2# / =q1=#sk# 550", "=ds="..AL["Trainer"]};
				{ 14, "s124574", "85836", "=q2=Misthide Gloves", "=ds=#s9#, #a2# / =q1=#sk# 545", "=ds="..AL["Trainer"]};
				{ 15, "s124572", "85839", "=q2=Misthide Shoulders", "=ds=#s3#, #a2# / =q1=#sk# 540", "=ds="..AL["Trainer"]};
				{ 16, "s124578", "85832", "=q2=Misthide Belt", "=ds=#s10#, #a2# / =q1=#sk# 535", "=ds="..AL["Trainer"]};
				{ 17, "s124576", "85834", "=q2=Misthide Bracers", "=ds=#s8#, #a2# / =q1=#sk# 530", "=ds="..AL["Trainer"]};
				{ 18, "s124577", "85833", "=q2=Misthide Boots", "=ds=#s12#, #a2# / =q1=#sk# 525", "=ds="..AL["Trainer"]};
				{ 19, "s138590", "94270", "=q4=Quilen Hide Helm", "=ds=#s1#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 20, "s138594", "94274", "=q4=Spirit Keeper Helm", "=ds=#s1#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 21, "s138589", "94269", "=q4=Quilen Hide Boots", "=ds=#s12#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 22, "s138593", "94273", "=q4=Spirit Keeper Footguards", "=ds=#s12#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 23, "s137826", "93476", "=q3=Crafted Dreadful Gladiator's Wyrmhide Helm", "=ds=#s1#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 24, "s137829", "93479", "=q3=Crafted Dreadful Gladiator's Wyrmhide Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 25, "s137828", "93478", "=q3=Crafted Dreadful Gladiator's Wyrmhide Robes", "=ds=#s5#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 26, "s137825", "93475", "=q3=Crafted Dreadful Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 27, "s137827", "93477", "=q3=Crafted Dreadful Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 28, "s137810", "93459", "=q3=Crafted Dreadful Gladiator's Dragonhide Helm", "=ds=#s1#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 29, "s137813", "93462", "=q3=Crafted Dreadful Gladiator's Dragonhide Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 30, "s137812", "93461", "=q3=Crafted Dreadful Gladiator's Dragonhide Robes", "=ds=#s5#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
			};
			{
				{ 1, "s137809", "93458", "=q3=Crafted Dreadful Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 2, "s137811", "93460", "=q3=Crafted Dreadful Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 3, "s137818", "93467", "=q3=Crafted Dreadful Gladiator's Kodohide Helm", "=ds=#s1#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 4, "s137821", "93470", "=q3=Crafted Dreadful Gladiator's Kodohide Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 5, "s137820", "93469", "=q3=Crafted Dreadful Gladiator's Kodohide Robes", "=ds=#s5#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 6, "s137817", "93466", "=q3=Crafted Dreadful Gladiator's Kodohide Gloves", "=ds=#s9#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 7, "s137819", "93468", "=q3=Crafted Dreadful Gladiator's Kodohide Legguards", "=ds=#s11#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 8, "s137839", "93519", "=q3=Crafted Dreadful Gladiator's Copperskin Helm", "=ds=#s1#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 9, "s137841", "93523", "=q3=Crafted Dreadful Gladiator's Copperskin Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 10, "s137842", "93525", "=q3=Crafted Dreadful Gladiator's Copperskin Tunic", "=ds=#s5#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 11, "s137838", "93517", "=q3=Crafted Dreadful Gladiator's Copperskin Gloves", "=ds=#s9#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 12, "s137840", "93521", "=q3=Crafted Dreadful Gladiator's Copperskin Legguards", "=ds=#s11#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 13, "s137834", "93509", "=q3=Crafted Dreadful Gladiator's Ironskin Helm", "=ds=#s1#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 14, "s137836", "93513", "=q3=Crafted Dreadful Gladiator's Ironskin Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 15, "s137837", "93515", "=q3=Crafted Dreadful Gladiator's Ironskin Tunic", "=ds=#s5#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 16, "s137833", "93507", "=q3=Crafted Dreadful Gladiator's Ironskin Gloves", "=ds=#s9#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 17, "s137835", "93511", "=q3=Crafted Dreadful Gladiator's Ironskin Legguards", "=ds=#s11#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 18, "s137848", "93571", "=q3=Crafted Dreadful Gladiator's Leather Helm", "=ds=#s1#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 19, "s137850", "93573", "=q3=Crafted Dreadful Gladiator's Leather Spaulders", "=ds=#s3#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 20, "s137846", "93569", "=q3=Crafted Dreadful Gladiator's Leather Tunic", "=ds=#s5#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 21, "s137847", "93570", "=q3=Crafted Dreadful Gladiator's Leather Gloves", "=ds=#s9#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 22, "s137849", "93572", "=q3=Crafted Dreadful Gladiator's Leather Legguards", "=ds=#s11#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 23, "s137832", "93506", "=q3=Crafted Dreadful Gladiator's Armwraps of Accuracy", "=ds=#s8#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 24, "s137845", "93568", "=q3=Crafted Dreadful Gladiator's Armwraps of Alacrity", "=ds=#s8#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 25, "s137816", "93506", "=q3=Crafted Dreadful Gladiator's Bindings of Meditation", "=ds=#s8#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 26, "s137824", "93474", "=q3=Crafted Dreadful Gladiator's Bindings of Prowess", "=ds=#s8#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 27, "s137822", "93472", "=q3=Crafted Dreadful Gladiator's Belt of Cruelty", "=ds=#s10#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 28, "s137814", "93463", "=q3=Crafted Dreadful Gladiator's Belt of Meditation", "=ds=#s10#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 29, "s137843", "93566", "=q3=Crafted Dreadful Gladiator's Waistband of Accuracy", "=ds=#s10#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 30, "s137830", "93504", "=q3=Crafted Dreadful Gladiator's Waistband of Cruelty", "=ds=#s10#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
			};
			{
				{ 1, "s137831", "93505", "=q3=Crafted Dreadful Gladiator's Boots of Alacrity", "=ds=#s12#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 2, "s137844", "93567", "=q3=Crafted Dreadful Gladiator's Boots of Cruelty", "=ds=#s12#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 3, "s137823", "93473", "=q3=Crafted Dreadful Gladiator's Leather Footguards of Alacrity", "=ds=#s12#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 4, "s137815", "93464", "=q3=Crafted Dreadful Gladiator's Leather Footguards of Meditation", "=ds=#s12#, #a2# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};

			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Leather Armor"].." - "..AL["Mists of Pandaria"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherMailArmorOld"] = {
		["Normal"] = {
			{
				{ 1, "s28224", "22665", "=q4=Icy Scale Bracers", "=ds=#sr# 300"};
				{ 2, "s28222", "22664", "=q4=Icy Scale Breastplate", "=ds=#sr# 300"};
				{ 3, "s28223", "22666", "=q4=Icy Scale Gauntlets", "=ds=#sr# 300"};
				{ 4, "s24703", "20380", "=q4=Dreamscale Breastplate", "=ds=#sr# 300"};
				{ 5, "s23708", "19157", "=q4=Chromatic Gauntlets", "=ds=#sr# 300"};
				{ 6, "s20855", "16984", "=q4=Black Dragonscale Boots", "=ds=#sr# 300"};
				{ 7, "s22923", "18508", "=q3=Swift Flight Bracers", "=ds=#sr# 300"};
				{ 8, "s24849", "20476", "=q3=Sandstalker Bracers", "=ds=#sr# 300"};
				{ 9, "s24851", "20478", "=q3=Sandstalker Breastplate", "=ds=#sr# 300"};
				{ 10, "s24850", "20477", "=q3=Sandstalker Gauntlets", "=ds=#sr# 300"};
				{ 11, "s24846", "20481", "=q3=Spitfire Bracers", "=ds=#sr# 300"};
				{ 12, "s24848", "20479", "=q3=Spitfire Breastplate", "=ds=#sr# 300"};
				{ 13, "s24847", "20480", "=q3=Spitfire Gauntlets", "=ds=#sr# 300"};
				{ 14, "s19054", "15047", "=q3=Red Dragonscale Breastplate", "=ds=#sr# 300"};
				{ 15, "s24654", "20295", "=q3=Blue Dragonscale Leggings", "=ds=#sr# 300"};
				{ 16, "s19107", "15052", "=q3=Black Dragonscale Leggings", "=ds=#sr# 300"};
				{ 17, "s19094", "15051", "=q3=Black Dragonscale Shoulders", "=ds=#sr# 300"};
				{ 18, "s19100", "15081", "=q2=Heavy Scorpid Shoulders", "=ds=#sr# 300"};
				{ 19, "s19089", "15049", "=q3=Blue Dragonscale Shoulders", "=ds=#sr# 295"};
				{ 20, "s19088", "15080", "=q2=Heavy Scorpid Helm", "=ds=#sr# 295"};
				{ 21, "s19085", "15050", "=q3=Black Dragonscale Breastplate", "=ds=#sr# 290"};
				{ 22, "s19075", "15079", "=q2=Heavy Scorpid Leggings", "=ds=#sr# 285"};
				{ 23, "s19077", "15048", "=q3=Blue Dragonscale Breastplate", "=ds=#sr# 285"};
				{ 24, "s24655", "20296", "=q3=Green Dragonscale Gauntlets", "=ds=#sr# 280", "=ds="..AL["Trainer"]};
				{ 25, "s19070", "15082", "=q2=Heavy Scorpid Belt", "=ds=#sr# 280", "=ds="..AL["World Drop"]};
				{ 26, "s19064", "15078", "=q2=Heavy Scorpid Gauntlets", "=ds=#sr# 275", "=ds="..AL["Drop"]};
				{ 27, "s19060", "15046", "=q3=Green Dragonscale Leggings", "=ds=#sr# 270", "=ds="..AL["Drop"]};
				{ 28, "s19051", "15076", "=q2=Heavy Scorpid Vest", "=ds=#sr# 265", "=ds="..AL["Drop"]};
				{ 29, "s36076", "29971", "=q3=Dragonstrike Leggings", "=ds=#sr# 260", "=ds="..AL["Trainer"]};
				{ 30, "s19050", "15045", "=q3=Green Dragonscale Breastplate", "=ds=#sr# 260", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, "s10650", "8367", "=q3=Dragonscale Breastplate", "=ds=#sr# 255", "=ds="..AL["Trainer"]};
				{ 2, "s19048", "15077", "=q2=Heavy Scorpid Bracers", "=ds=#sr# 255", "=ds="..AL["Vendor"]};
				{ 3, "s10570", "8208", "=q2=Tough Scorpid Helm", "=ds=#sr# 250", "=ds="..AL["Drop"]};
				{ 4, "s10568", "8206", "=q2=Tough Scorpid Leggings", "=ds=#sr# 245", "=ds="..AL["Drop"]};
				{ 5, "s10564", "8207", "=q2=Tough Scorpid Shoulders", "=ds=#sr# 240", "=ds="..AL["Drop"]};
				{ 6, "s10554", "8209", "=q2=Tough Scorpid Boots", "=ds=#sr# 235", "=ds="..AL["Drop"]};
				{ 7, "s10556", "8185", "=q2=Turtle Scale Leggings", "=ds=#sr# 235", "=ds="..AL["Trainer"]};
				{ 8, "s10552", "8191", "=q2=Turtle Scale Helm", "=ds=#sr# 230", "=ds="..AL["Trainer"]};
				{ 9, "s10619", "8347", "=q3=Dragonscale Gauntlets", "=ds=#sr# 225", "=ds="..AL["Trainer"]};
				{ 10, "s10542", "8204", "=q2=Tough Scorpid Gloves", "=ds=#sr# 225", "=ds="..AL["Drop"]};
				{ 11, "s10533", "8205", "=q2=Tough Scorpid Bracers", "=ds=#sr# 220", "=ds="..AL["Drop"]};
				{ 12, "s10525", "8203", "=q2=Tough Scorpid Breastplate", "=ds=#sr# 220", "=ds="..AL["Drop"]};
				{ 13, "s10518", "8198", "=q2=Turtle Scale Bracers", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 14, "s10511", "8189", "=q2=Turtle Scale Breastplate", "=ds=#sr# 210", "=ds="..AL["Trainer"]};
				{ 15, "s10509", "8187", "=q2=Turtle Scale Gloves", "=ds=#sr# 205", "=ds="..AL["World Drop"]};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Mail Armor"].." - "..AL["Classic WoW"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherMailArmorBC"] = {
		["Normal"] = {
			{
				{ 1, "s40002", "32397", "=q4=Waistguard of Shackled Souls", "=ds=#sr# 375"};
				{ 2, "s41162", "32575", "=q4=Shoulders of Lightning Reflexes", "=ds=#sr# 375"};
				{ 3, "s35582", "29520", "=q4=Netherstrike Belt", "=ds=#sr# 375"};
				{ 4, "s35584", "29521", "=q4=Netherstrike Bracers", "=ds=#sr# 375"};
				{ 5, "s35580", "29519", "=q4=Netherstrike Breastplate", "=ds=#sr# 375"};
				{ 6, "s36353", "30044", "=q4=Monsoon Belt", "=ds=#sr# 375"};
				{ 7, "s52733", "32399", "=q4=Bracers of Shackled Souls", "=ds="..AL["Vendor"]..""};
				{ 8, "s35576", "29516", "=q4=Ebon Netherscale Belt", "=ds=#sr# 375"};
				{ 9, "s35577", "29517", "=q4=Ebon Netherscale Bracers", "=ds=#sr# 375"};
				{ 10, "s35575", "29515", "=q4=Ebon Netherscale Breastplate", "=ds=#sr# 375"};
				{ 11, "s40001", "32400", "=q4=Greaves of Shackled Souls", "=ds=#sr# 375"};
				{ 12, "s36359", "30043", "=q4=Hurricane Boots", "=ds=#sr# 375"};
				{ 13, "s41163", "32577", "=q4=Living Earth Bindings", "=ds=#sr# 375"};
				{ 14, "s41164", "32579", "=q4=Living Earth Shoulders", "=ds=#sr# 375"};
				{ 15, "s39997", "32398", "=q4=Boots of Shackled Souls", "=ds=#sr# 375"};
				{ 16, "s36358", "30045", "=q4=Boots of the Crimson Hawk", "=ds=#sr# 375"};
				{ 17, "s36352", "30046", "=q4=Belt of the Black Eagle", "=ds=#sr# 375"};
				{ 18, "s41161", "32574", "=q4=Bindings of Lightning Reflexes", "=ds=#sr# 375"};
				{ 19, "s46139", "34375", "=q4=Sun-Drenched Scale Chestguard", "=ds=#sr# 365"};
				{ 20, "s46135", "34376", "=q4=Sun-Drenched Scale Gloves", "=ds=#sr# 365"};
				{ 21, "s46137", "34373", "=q4=Embrace of the Phoenix", "=ds=#sr# 365"};
				{ 22, "s46133", "34374", "=q4=Fletcher's Gloves of the Phoenix", "=ds=#sr# 365"};
				{ 23, "s35568", "29509", "=q4=Windstrike Gloves", "=ds=#sr# 365"};
				{ 24, "s35574", "29514", "=q4=Thick Netherscale Breastplate", "=ds=#sr# 365"};
				{ 25, "s35564", "29508", "=q4=Living Dragonscale Helm", "=ds=#sr# 365"};
				{ 26, "s35573", "29511", "=q4=Netherdrake Gloves", "=ds=#sr# 365"};
				{ 27, "s35572", "29510", "=q4=Netherdrake Helm", "=ds=#sr# 365"};
				{ 28, "s35567", "29512", "=q4=Earthen Netherscale Boots", "=ds=#sr# 365"};
				{ 29, "s32499", "25697", "=q3=Felstalker Bracer", "=ds=#sr# 360"};
				{ 30, "s32500", "25696", "=q3=Felstalker Breastplate", "=ds=#sr# 360"};
			};
			{
				{ 1, "s32487", "25681", "=q3=Stylin' Adventure Hat", "=ds=#sr# 350"};
				{ 2, "s32488", "25683", "=q3=Stylin' Crimson Hat", "=ds=#sr# 350"};
				{ 3, "s32498", "25695", "=q3=Felstalker Belt", "=ds=#sr# 350"};
				{ 4, "s35531", "29494", "=q3=Flamescale Belt", "=ds=#sr# 350"};
				{ 5, "s35528", "29493", "=q3=Flamescale Boots", "=ds=#sr# 350"};
				{ 6, "s35529", "29492", "=q3=Flamescale Leggings", "=ds=#sr# 350"};
				{ 7, "s32503", "25693", "=q3=Netherfury Boots", "=ds=#sr# 350"};
				{ 8, "s35527", "29491", "=q3=Enchanted Felscale Boots", "=ds=#sr# 350"};
				{ 9, "s35526", "29490", "=q3=Enchanted Felscale Gloves", "=ds=#sr# 350"};
				{ 10, "s35525", "29489", "=q3=Enchanted Felscale Leggings", "=ds=#sr# 350"};
				{ 11, "s32501", "25694", "=q3=Netherfury Belt", "=ds=#sr# 340"};
				{ 12, "s32502", "25692", "=q3=Netherfury Leggings", "=ds=#sr# 340"};
				{ 13, "s36079", "29975", "=q3=Golden Dragonstrike Breastplate", "=ds=#sr# 330"};
				{ 14, "s32465", "25657", "=q2=Felscale Breastplate", "=ds=#sr# 335"};
				{ 15, "s32469", "25659", "=q2=Scaled Draenic Boots", "=ds=#sr# 335"};
				{ 16, "s32468", "25660", "=q2=Scaled Draenic Vest", "=ds=#sr# 325"};
				{ 17, "s32464", "25656", "=q2=Felscale Pants", "=ds=#sr# 320"};
				{ 18, "s32467", "25661", "=q2=Scaled Draenic Gloves", "=ds=#sr# 310"};
				{ 19, "s32463", "25655", "=q2=Felscale Boots", "=ds=#sr# 310"};
				{ 20, "s32466", "25662", "=q2=Scaled Draenic Pants", "=ds=#sr# 300"};
				{ 21, "s32462", "25654", "=q2=Felscale Gloves", "=ds=#sr# 300"};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Mail Armor"].." - "..AL["Burning Crusade"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherMailArmorWrath"] = {
		["Normal"] = {
			{
				{ 1, "s70560", "49901", "=q4=Draconic Bonesplinter Legguards", "=ds="..AL["Vendor"]..""};
				{ 2, "s70559", "49896", "=q4=Earthsoul Boots", "=ds="..AL["Vendor"]..""};
				{ 3, "s70558", "49900", "=q4=Lightning-Infused Leggings", "=ds="..AL["Vendor"]..""};
				{ 4, "s70561", "49897", "=q4=Rock-Steady Treads", "=ds="..AL["Vendor"]..""};
				{ 5, "s67138", "47596", "=q4=Crusader's Dragonscale Breastplate", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 6, "s67082", "47595", "=q4=Crusader's Dragonscale Breastplate", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 7, "s67080", "47597", "=q4=Ensorcelled Nerubian Breastplate", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 8, "s67136", "47598", "=q4=Ensorcelled Nerubian Breastplate", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 9, "s67137", "47580", "=q4=Black Chitin Bracers", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 10, "s67081", "47579", "=q4=Black Chitin Bracers", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 11, "s67083", "47576", "=q4=Crusader's Dragonscale Bracers", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 12, "s67143", "47577", "=q4=Crusader's Dragonscale Bracers", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 13, "s63194", "45553", "=q4=Belt of Dragons", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 14, "s63196", "45554", "=q4=Blue Belt of Chaos", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 15, "s63195", "45562", "=q4=Boots of Living Scale", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 16, "s63197", "45563", "=q4=Lightning Grounded Boots", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 17, "s60755", "43459", "=q4=Giantmaim Bracers", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 18, "s60754", "43458", "=q4=Giantmaim Legguards", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 19, "s60756", "43461", "=q4=Revenant's Breastplate", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 20, "s60757", "43469", "=q4=Revenant's Treads", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 21, "s60999", "43593", "=q4=Icy Scale Chestguard", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 22, "s61000", "43594", "=q4=Icy Scale Belt", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 23, "s61002", "43595", "=q4=Icy Scale Boots", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 24, "s60728", "43447", "=q3=Swiftarrow Helm", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 25, "s60729", "43449", "=q3=Swiftarrow Shoulderguards", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 26, "s60730", "43445", "=q3=Swiftarrow Hauberk", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 27, "s60731", "43444", "=q3=Swiftarrow Bracers", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 28, "s60732", "43446", "=q3=Swiftarrow Gauntlets", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 29, "s60734", "43442", "=q3=Swiftarrow Belt", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 30, "s60735", "43448", "=q3=Swiftarrow Leggings", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
			};
			{
				{ 1, "s60737", "43443", "=q3=Swiftarrow Boots", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 2, "s60743", "43455", "=q3=Stormhide Crown", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 3, "s60746", "43457", "=q3=Stormhide Shoulders", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 4, "s60747", "43453", "=q3=Stormhide Hauberk", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 5, "s60748", "43452", "=q3=Stormhide Wristguards", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 6, "s60749", "43454", "=q3=Stormhide Grips", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 7, "s60750", "43450", "=q3=Stormhide Belt", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 8, "s60751", "43456", "=q3=Stormhide Legguards", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 9, "s60752", "43451", "=q3=Stormhide Stompers", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"]};
				{ 10, "s60649", "43129", "=q3=Razorstrike Breastplate", "=ds="..AL["Trainer"]};
				{ 11, "s60655", "43132", "=q3=Nightshock Hood", "=ds="..AL["Trainer"]};
				{ 12, "s60651", "43130", "=q3=Virulent Spaulders", "=ds="..AL["Trainer"]};
				{ 13, "s60658", "43133", "=q3=Nightshock Girdle", "=ds="..AL["Trainer"]};
				{ 14, "s60652", "43131", "=q3=Eaglebane Bracers", "=ds="..AL["Trainer"]};
				{ 15, "s60605", "44438", "=q3=Dragonstompers", "=ds="..AL["Trainer"]};
				{ 16, "s60630", "44445", "=q3=Scaled Icewalkers", "=ds="..AL["Trainer"]};
				{ 17, "s60604", "44437", "=q3=Dark Frostscale Breastplate", "=ds="..AL["Trainer"]};
				{ 18, "s60601", "44436", "=q3=Dark Frostscale Leggings", "=ds="..AL["Trainer"]};
				{ 19, "s60629", "44444", "=q3=Dark Nerubian Chestpiece", "=ds="..AL["Trainer"]};
				{ 20, "s60627", "44443", "=q3=Dark Nerubian Leggings", "=ds="..AL["Trainer"]};
				{ 21, "s60600", "38440", "=q2=Frostscale Helm", "=ds="..AL["Trainer"]};
				{ 22, "s50952", "38424", "=q2=Frostscale Shoulders", "=ds="..AL["Trainer"]};
				{ 23, "s50950", "38414", "=q2=Frostscale Chestguard", "=ds="..AL["Trainer"]};
				{ 24, "s60599", "38436", "=q2=Frostscale Bracers", "=ds="..AL["Trainer"]};
				{ 25, "s50953", "38415", "=q2=Frostscale Gloves", "=ds="..AL["Trainer"]};
				{ 26, "s50955", "38412", "=q2=Frostscale Belt", "=ds="..AL["Trainer"]};
				{ 27, "s50951", "38416", "=q2=Frostscale Leggings", "=ds="..AL["Trainer"]};
				{ 28, "s50954", "38413", "=q2=Frostscale Boots", "=ds="..AL["Trainer"]};
				{ 29, "s60624", "38439", "=q2=Nerubian Helm", "=ds="..AL["Trainer"]};
				{ 30, "s50958", "38417", "=q2=Nerubian Shoulders", "=ds="..AL["Trainer"]};
			};
			{
				{ 1, "s50956", "38420", "=q2=Nerubian Chestguard", "=ds="..AL["Trainer"]};
				{ 2, "s60622", "38435", "=q2=Nerubian Bracers", "=ds="..AL["Trainer"]};
				{ 3, "s50959", "38421", "=q2=Nerubian Gloves", "=ds="..AL["Trainer"]};
				{ 4, "s50961", "38418", "=q2=Nerubian Belt", "=ds="..AL["Trainer"]};
				{ 5, "s50957", "38422", "=q2=Nerubian Legguards", "=ds="..AL["Trainer"]};
				{ 6, "s50960", "38419", "=q2=Nerubian Boots", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Mail Armor"].." - "..AL["Wrath of the Lich King"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherMailArmorCata"] = {
		["Normal"] = {
			{
				{ 1, "s101941", "71996", "=q4=Bracers of the Hunter-Killer", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 2, "s101939", "71997", "=q4=Thundering Deathscale Wristguards", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 3, "s101936", "71987", "=q4=Rended Earth Leggings", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 4, "s101934", "71988", "=q4=Deathscale Leggings of the Storm", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 5, "s99443", "69939", "=q4=Dragonfire Gloves", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 6, "s99445", "69941", "=q4=Gloves of Unforgiving Flame", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 7, "s99455", "69949", "=q4=Earthen Scale Sabatons", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 8, "s99456", "69950", "=q4=Footwraps of Quenched Fire", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 9, "s78463", "56539", "=q4=Corded Viper Belt", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 10, "s78490", "56564", "=q4=Dragonkiller Tunic", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 11, "s78462", "56538", "=q4=Stormleather Sash", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 12, "s78489", "56563", "=q4=Twilight Scale Chestguard", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 13, "s78486", "75115", "=q3=Vicious Dragonscale Chest", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 14, "s78485", "75108", "=q3=Vicious Dragonscale Legs", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 15, "s78483", "75084", "=q3=Vicious Charscale Chest", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 16, "s78484", "75090", "=q3=Vicious Charscale Helm", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 17, "s78473", "75100", "=q3=Vicious Dragonscale Belt", "=ds=#sr# 520", "=ds="..AL["Vendor"] };
				{ 18, "s78474", "75102", "=q3=Vicious Dragonscale Helm", "=ds=#sr# 520", "=ds="..AL["Vendor"] };
				{ 19, "s78471", "75097", "=q3=Vicious Charscale Legs", "=ds=#sr# 520", "=ds="..AL["Vendor"] };
				{ 20, "s78470", "75061", "=q3=Vicious Charscale Shoulders", "=ds=#sr# 520", "=ds="..AL["Vendor"] };
				{ 21, "s78458", "75110", "=q3=Vicious Dragonscale Boots", "=ds=#sr# 515", "=ds="..AL["Vendor"] };
				{ 22, "s78459", "75081", "=q3=Vicious Dragonscale Gloves", "=ds=#sr# 515", "=ds="..AL["Vendor"] };
				{ 23, "s78457", "75083", "=q3=Vicious Charscale Belt", "=ds=#sr# 515", "=ds="..AL["Vendor"] };
				{ 24, "s78456", "75092", "=q3=Vicious Charscale Boots", "=ds=#sr# 515", "=ds="..AL["Vendor"] };
				{ 25, "s78450", "75114", "=q3=Vicious Dragonscale Bracers", "=ds=#sr# 510", "=ds="..AL["Vendor"] };
				{ 26, "s78451", "75116", "=q3=Vicious Dragonscale Shoulders", "=ds=#sr# 510", "=ds="..AL["Vendor"] };
				{ 27, "s78448", "75094", "=q3=Vicious Charscale Bracers", "=ds=#sr# 510", "=ds="..AL["Vendor"] };
				{ 28, "s78449", "75085", "=q3=Vicious Charscale Gloves", "=ds=#sr# 510", "=ds="..AL["Vendor"] };
				{ 29, "s78423", "56504", "=q3=Tsunami Chestguard", "=ds=#sr# 490", "=ds="..AL["Trainer"] };
				{ 30, "s78432", "56512", "=q2=Tsunami Helm", "=ds=#sr# 485", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s78427", "56508", "=q2=Tsunami Leggings", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 2, "s78406", "56490", "=q2=Tsunami Gloves", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 3, "s78396", "56482", "=q2=Tsunami Belt", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 4, "s78388", "56481", "=q2=Tsunami Bracers", "=ds=#sr# 460", "=ds="..AL["Trainer"] };
				{ 5, "s78415", "56498", "=q3=Tsunami Shoulders", "=ds=#sr# 455", "=ds="..AL["Trainer"] };
				{ 6, "s78410", "56494", "=q2=Tsunami Boots", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Mail Armor"].." - "..AL["Cataclysm"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherMailArmorMoP"] = {
		["Normal"] = {
			{
				{ 1, "s142966", "98614", "=q4=Gorge Stalker Belt", "=ds=#s10#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 2, "s142962", "98610", "=q4=Krasari Prowler Belt", "=ds=#s10#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 3, "s142957", "98605", "=q4=Gorge Stalker Legplates", "=ds=#s11#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 4, "s142953", "98601", "=q4=Krasari Prowler Britches", "=ds=#s11#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 5, "s124644", "85830", "=q4=Raiment of Blood and Bone", "=ds=#s5#, #a3# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 6, "s124642", "85840", "=q4=Stormbreaker Chestguard", "=ds=#s5#, #a3# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 7, "s124643", "85821", "=q4=Fists of Lightning", "=ds=#s9#, #a3# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 8, "s124645", "85831", "=q4=Raven Lord's Gloves", "=ds=#s9#, #a3# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 9, "s124625", "85787", "=q4=Chestguard of Earthen Harmony", "=ds=#s5#, #a3# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 10, "s124623", "85826", "=q4=Lifekeeper's Robe", "=ds=#s5#, #a3# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 11, "s124626", "85822", "=q4=Gloves of Earthen Harmony", "=ds=#s9#, #a3# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 12, "s124624", "85825", "=q4=Lifekeeper's Gloves", "=ds=#s9#, #a3# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 13, "s143139", "98822", "=q3=Crafted Malevolent Gladiator's Chain Helm", "=ds=#s1#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 14, "s143141", "98824", "=q3=Crafted Malevolent Gladiator's Chain Spaulders", "=ds=#s3#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 15, "s143137", "98820", "=q3=Crafted Malevolent Gladiator's Chain Armor", "=ds=#s5#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 16, "s143138", "98821", "=q3=Crafted Malevolent Gladiator's Chain Gauntlets", "=ds=#s9#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 17, "s143140", "98823", "=q3=Crafted Malevolent Gladiator's Chain Leggings", "=ds=#s11#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 18, "s143160", "98907", "=q3=Crafted Malevolent Gladiator's Mail Helm", "=ds=#s1#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 19, "s143162", "98909", "=q3=Crafted Malevolent Gladiator's Mail Spaulders", "=ds=#s3#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 20, "s143158", "98905", "=q3=Crafted Malevolent Gladiator's Mail Armor", "=ds=#s5#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 21, "s143159", "98906", "=q3=Crafted Malevolent Gladiator's Mail Gauntlets", "=ds=#s9#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 22, "s143161", "98908", "=q3=Crafted Malevolent Gladiator's Mail Leggings", "=ds=#s11#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 23, "s143154", "98901", "=q3=Crafted Malevolent Gladiator's Linked Helm", "=ds=#s1#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 24, "s143156", "98903", "=q3=Crafted Malevolent Gladiator's Linked Spaulders", "=ds=#s3#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 25, "s143152", "98899", "=q3=Crafted Malevolent Gladiator's Linked Armor", "=ds=#s5#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 26, "s143153", "98900", "=q3=Crafted Malevolent Gladiator's Linked Gauntlets", "=ds=#s9#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 27, "s143155", "98902", "=q3=Crafted Malevolent Gladiator's Linked Leggings", "=ds=#s11#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 28, "s143149", "98896", "=q3=Crafted Malevolent Gladiator's Ringmail Helm", "=ds=#s1#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 29, "s143151", "98898", "=q3=Crafted Malevolent Gladiator's Ringmail Spaulders", "=ds=#s3#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 30, "s143147", "98894", "=q3=Crafted Malevolent Gladiator's Ringmail Armor", "=ds=#s5#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
			};
			{
				{ 1, "s143148", "98895", "=q3=Crafted Malevolent Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 2, "s143150", "98897", "=q3=Crafted Malevolent Gladiator's Ringmail Leggings", "=ds=#s11#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 3, "s143146", "98893", "=q3=Crafted Malevolent Gladiator's Armbands of Meditation", "=ds=#s8#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 4, "s143145", "98892", "=q3=Crafted Malevolent Gladiator's Armbands of Prowess", "=ds=#s8#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 5, "s143136", "98819", "=q3=Crafted Malevolent Gladiator's Wristguards of Accuracy", "=ds=#s8#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 6, "s143135", "98818", "=q3=Crafted Malevolent Gladiator's Wristguards of Alacrity", "=ds=#s8#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 7, "s143132", "98815", "=q3=Crafted Malevolent Gladiator's Links of Accuracy", "=ds=#s10#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 8, "s143131", "98814", "=q3=Crafted Malevolent Gladiator's Links of Cruelty", "=ds=#s10#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 9, "s143157", "98904", "=q3=Crafted Malevolent Gladiator's Waistguard of Cruelty", "=ds=#s10#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 10, "s143142", "98889", "=q3=Crafted Malevolent Gladiator's Waistguard of Meditation", "=ds=#s10#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 11, "s143143", "98890", "=q3=Crafted Malevolent Gladiator's Footguards of Alacrity", "=ds=#s12#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 12, "s143144", "98891", "=q3=Crafted Malevolent Gladiator's Footguards of Meditation", "=ds=#s12#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 13, "s143134", "98817", "=q3=Crafted Malevolent Gladiator's Sabatons of Alacrity", "=ds=#s12#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 14, "s143133", "98816", "=q3=Crafted Malevolent Gladiator's Sabatons of Cruelty", "=ds=#s12#, #a3# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(142976)};
				{ 15, "s124611", "85794", "=q3=Contender's Dragonscale Helm", "=ds=#s1#, #a3# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 16, "s124613", "85792", "=q3=Contender's Dragonscale Chestguard", "=ds=#s5#, #a3# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 17, "s124595", "85810", "=q3=Contender's Scale Helm", "=ds=#s1#, #a3# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 18, "s124597", "85808", "=q3=Contender's Scale Chestguard", "=ds=#s5#, #a3# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 19, "s124612", "85796", "=q3=Contender's Dragonscale Shoulders", "=ds=#s3#, #a3# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 20, "s124596", "85812", "=q3=Contender's Scale Shoulders", "=ds=#s3#, #a3# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 21, "s124614", "85793", "=q3=Contender's Dragonscale Gloves", "=ds=#s9#, #a3# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 22, "s124618", "85789", "=q3=Contender's Dragonscale Belt", "=ds=#s10#, #a3# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 23, "s124615", "85795", "=q3=Contender's Dragonscale Leggings", "=ds=#s11#, #a3# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 24, "s124617", "85790", "=q3=Contender's Dragonscale Boots", "=ds=#s12#, #a3# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 25, "s124598", "85809", "=q3=Contender's Scale Gloves", "=ds=#s9#, #a3# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 26, "s124602", "85805", "=q3=Contender's Scale Belt", "=ds=#s10#, #a3# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 27, "s124599", "85811", "=q3=Contender's Scale Leggings", "=ds=#s11#, #a3# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 28, "s124601", "85806", "=q3=Contender's Scale Boots", "=ds=#s12#, #a3# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 29, "s124583", "85847", "=q2=Stormscale Leggings", "=ds=#s11#, #a3# / =q1=#sk# 560", "=ds="..AL["Trainer"]};
				{ 30, "s124616", "85791", "=q3=Contender's Dragonscale Bracers", "=ds=#s8#, #a3# / =q1=#sk# 555", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, "s124600", "85807", "=q3=Contender's Scale Bracers", "=ds=#s8#, #a3# / =q1=#sk# 555", "=ds="..AL["Vendor"]};
				{ 2, "s124581", "85844", "=q2=Stormscale Chestguard", "=ds=#s5#, #a3# / =q1=#sk# 555", "=ds="..AL["Trainer"]};
				{ 3, "s124579", "85846", "=q2=Stormscale Helm", "=ds=#s1#, #a3# / =q1=#sk# 550", "=ds="..AL["Trainer"]};
				{ 4, "s124580", "85848", "=q2=Stormscale Shoulders", "=ds=#s3#, #a3# / =q1=#sk# 545", "=ds="..AL["Trainer"]};
				{ 5, "s124582", "85845", "=q2=Stormscale Gloves", "=ds=#s9#, #a3# / =q1=#sk# 540", "=ds="..AL["Trainer"]};
				{ 6, "s124585", "85842", "=q2=Stormscale Boots", "=ds=#s12#, #a3# / =q1=#sk# 535", "=ds="..AL["Trainer"]};
				{ 7, "s124586", "85841", "=q2=Stormscale Belt", "=ds=#s10#, #a3# / =q1=#sk# 530", "=ds="..AL["Trainer"]};
				{ 8, "s124584", "85843", "=q2=Stormscale Bracers", "=ds=#s8#, #a3# / =q1=#sk# 525", "=ds="..AL["Trainer"]};
				{ 9, "s138596", "94276", "=q4=Cloud Serpent Helm", "=ds=#s1#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 10, "s138592", "94272", "=q4=Dreadrunner Helm", "=ds=#s1#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 11, "s138595", "94275", "=q4=Cloud Serpent Sabatons", "=ds=#s12#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 12, "s138591", "94271", "=q4=Dreadrunner Sabatons", "=ds=#s12#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 13, "s137859", "93496", "=q3=Crafted Dreadful Gladiator's Chain Helm", "=ds=#s1#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 14, "s137861", "93498", "=q3=Crafted Dreadful Gladiator's Chain Spaulders", "=ds=#s3#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 15, "s137857", "93494", "=q3=Crafted Dreadful Gladiator's Chain Armor", "=ds=#s5#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 16, "s137858", "93495", "=q3=Crafted Dreadful Gladiator's Chain Gauntlets", "=ds=#s9#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 17, "s137860", "93497", "=q3=Crafted Dreadful Gladiator's Chain Leggings", "=ds=#s11#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 18, "s137880", "93592", "=q3=Crafted Dreadful Gladiator's Mail Helm", "=ds=#s1#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 19, "s137882", "93594", "=q3=Crafted Dreadful Gladiator's Mail Spaulders", "=ds=#s3#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 20, "s137878", "93590", "=q3=Crafted Dreadful Gladiator's Mail Armor", "=ds=#s5#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 21, "s137879", "93591", "=q3=Crafted Dreadful Gladiator's Mail Gauntlets", "=ds=#s9#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 22, "s137881", "93593", "=q3=Crafted Dreadful Gladiator's Mail Leggings", "=ds=#s11#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 23, "s137874", "93586", "=q3=Crafted Dreadful Gladiator's Linked Helm", "=ds=#s1#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 24, "s137876", "93588", "=q3=Crafted Dreadful Gladiator's Linked Spaulders", "=ds=#s3#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 25, "s137872", "93584", "=q3=Crafted Dreadful Gladiator's Linked Armor", "=ds=#s5#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 26, "s137873", "93585", "=q3=Crafted Dreadful Gladiator's Linked Gauntlets", "=ds=#s9#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 27, "s137875", "93587", "=q3=Crafted Dreadful Gladiator's Linked Leggings", "=ds=#s11#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 28, "s137869", "93581", "=q3=Crafted Dreadful Gladiator's Ringmail Helm", "=ds=#s1#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 29, "s137871", "93583", "=q3=Crafted Dreadful Gladiator's Ringmail Spaulders", "=ds=#s3#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 30, "s137867", "93579", "=q3=Crafted Dreadful Gladiator's Ringmail Armor", "=ds=#s5#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
			};
			{
				{ 1, "s137868", "93580", "=q3=Crafted Dreadful Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 2, "s137870", "93582", "=q3=Crafted Dreadful Gladiator's Ringmail Leggings", "=ds=#s11#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 3, "s137866", "93578", "=q3=Crafted Dreadful Gladiator's Armbands of Meditation", "=ds=#s8#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 4, "s137865", "93577", "=q3=Crafted Dreadful Gladiator's Armbands of Prowess", "=ds=#s8#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 5, "s137856", "93493", "=q3=Crafted Dreadful Gladiator's Wristguards of Accuracy", "=ds=#s8#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 6, "s137855", "93492", "=q3=Crafted Dreadful Gladiator's Wristguards of Alacrity", "=ds=#s8#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 7, "s137852", "93489", "=q3=Crafted Dreadful Gladiator's Links of Accuracy", "=ds=#s10#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 8, "s137851", "93488", "=q3=Crafted Dreadful Gladiator's Links of Cruelty", "=ds=#s10#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 9, "s137877", "93589", "=q3=Crafted Dreadful Gladiator's Waistguard of Cruelty", "=ds=#s10#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 10, "s137862", "93574", "=q3=Crafted Dreadful Gladiator's Waistguard of Meditation", "=ds=#s10#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 11, "s137863", "93575", "=q3=Crafted Dreadful Gladiator's Mail Footguards of Alacrity", "=ds=#s12#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 12, "s137864", "93576", "=q3=Crafted Dreadful Gladiator's Mail Footguards of Meditation", "=ds=#s12#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 13, "s137854", "93491", "=q3=Crafted Dreadful Gladiator's Sabatons of Alacrity", "=ds=#s12#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
				{ 14, "s137853", "93490", "=q3=Crafted Dreadful Gladiator's Sabatons of Cruelty", "=ds=#s12#, #a3# / =q1=#sk# 500", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140041)};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Mail Armor"].." - "..AL["Mists of Pandaria"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherCloaks"] = {
		["Normal"] = {
			{
				{ 1, "s124637", "85852", "=q3=Quick Strike Cloak", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 2, "s124635", "85851", "=q2=Cloak of the Mists", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 3, "s124636", "85853", "=q3=Stormscale Drape", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 4, "s78475", "56549", "=q3=Razor-Edged Cloak", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 5, "s78476", "56548", "=q3=Twilight Dragonscale Cloak", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 6, "s99536", "75076", "=q3=Vicious Fur Cloak", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 7, "s99535", "75077", "=q3=Vicious Hide Cloak", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 8, "s78438", "56518", "=q3=Cloak of Beasts", "=ds=#sr# 495", "=ds="..AL["Trainer"] };
				{ 9, "s78439", "56519", "=q3=Cloak of War", "=ds=#sr# 495", "=ds="..AL["Trainer"] };
				{ 10, "s78405", "56489", "=q2=Hardened Scale Cloak", "=ds=#sr# 470", "=ds="..AL["Trainer"] };
				{ 11, "s78380", "56480", "=q2=Savage Cloak", "=ds=#sr# 460", "=ds="..AL["Trainer"] };
				{ 12, "s60637", "43566", "=q4=Ice Striker's Cloak", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 13, "s55199", "41238", "=q3=Cloak of Tormented Skies", "=ds=#sr# 395", "=ds="..AL["Trainer"] };
				{ 14, "s60631", "38441", "=q3=Cloak of Harsh Winds", "=ds=#sr# 380", "=ds="..AL["Trainer"] };	
				{ 15, "s42546", "33122", "=q4=Cloak of Darkness", "=ds=#sr# 360", "=ds="..ALIL["The Violet Eye"].." - "..AL["Exalted"] };
				{ 16, "s22926", "18509", "=q4=Chromatic Cloak", "=ds=#sr# 300", "=ds="..ALIL["Dire Maul"] };
				{ 17, "s22928", "18511", "=q4=Shifting Cloak", "=ds=#sr# 300", "=ds="..ALIL["Dire Maul"] };
				{
					{ 18, "s19093", "15138", "=q3=Onyxia Scale Cloak", "=ds=#sr# 300", "=ds=#QUESTID:7493#" };
					{ 18, "s19093", "15138", "=q3=Onyxia Scale Cloak", "=ds=#sr# 300", "=ds=#QUESTID:7497#" };
				};
				{
					{ 19, "s10574", "8215", "=q2=Wild Leather Cloak", "=ds=#sr# 250", "=ds=#QUESTID:2860#" };
					{ 19, "s10574", "8215", "=q2=Wild Leather Cloak", "=ds=#sr# 250", "=ds=#QUESTID:2853#" };
				};
				{ 20, "s10562", "8216", "=q2=Big Voodoo Cloak", "=ds=#sr# 240", "=ds="..AL["World Drop"] };
				{ 21, "s7153", "5965", "=q2=Guardian Cloak", "=ds=#sr# 185", "=ds="..AL["World Drop"] };
				{ 22, "s9198", "7377", "=q2=Frost Leather Cloak", "=ds=#sr# 180", "=ds="..AL["Trainer"] };
				{ 23, "s3760", "3719", "=q2=Hillman's Cloak", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 24, "s2168", "2316", "=q2=Dark Leather Cloak", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 25, "s9070", "7283", "=q2=Black Whelp Cloak", "=ds=#sr# 100", "=ds="..AL["Vendor"]..": "..ALIL["Redridge Mountains"] };
				{ 26, "s7953", "6466", "=q2=Deviate Scale Cloak", "=ds=#sr# 90", "=ds="..AL["Vendor"]..": "..ALIL["Northern Barrens"] };
				{ 27, "s2159", "2308", "=q2=Fine Leather Cloak", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
				{ 28, "s2162", "2310", "=q2=Embossed Leather Cloak", "=ds=#sr# 60", "=ds="..AL["Trainer"] };
				{ 29, "s9058", "7276", "=q1=Handstitched Leather Cloak", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Cloaks"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherItemEnhancement"] = {
		["Normal"] = {
			{
				{ 1, "s124127", "83765", "=q3=Angerhide Leg Armor", "=ds=#sr# 575", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"] };
				{ 2, "s124128", "83763", "=q3=Ironscale Leg Armor", "=ds=#sr# 575", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"] };
				{ 3, "s124129", "83764", "=q3=Shadowleather Leg Armor", "=ds=#sr# 575", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"] };
				{ 4, "s124125", "85570", "=q2=Toughened Leg Armor", "=ds=#sr# 555", "=ds="..AL["Trainer"] };
				{ 5, "s124124", "85569", "=q2=Sha-Touched Leg Armor", "=ds=#sr# 545", "=ds="..AL["Trainer"] };
				{ 6, "s124126", "85568", "=q2=Brutal Leg Armor", "=ds=#sr# 535", "=ds="..AL["Trainer"] };
				{ 7, "s124628", "85559", "=q1=Sha Armor Kit", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 9, "s78478", "56551", "=q4=Charscale Leg Armor", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 10, "s78477", "56550", "=q4=Dragonscale Leg Armor", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 11, "s101599", "71720", "=q4=Drakehide Leg Armor", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 12, "s85008", "Trade_LeatherWorking", "=ds=Draconic Embossment - Agility", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 13, "s85010", "Trade_LeatherWorking", "=ds=Draconic Embossment - Intellect", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 14, "s85007", "Trade_LeatherWorking", "=ds=Draconic Embossment - Stamina", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 15, "s85009", "Trade_LeatherWorking", "=ds=Draconic Embossment - Strength", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 16, "s78437", "56517", "=q2=Heavy Savage Armor Kit", "=ds=#sr# 485", "=ds="..AL["Trainer"] };
				{ 17, "s78420", "56503", "=q3=Twilight Leg Armor", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 18, "s78419", "56502", "=q3=Scorched Leg Armor", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 19, "s78379", "56477", "=q1=Savage Armor Kit", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 21, "s62448", "44963", "=q4=Earthen Leg Armor", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 22, "s50965", "38373", "=q4=Frosthide Leg Armor", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 23, "s50967", "38374", "=q4=Icescale Leg Armor", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 24, "s50964", "38371", "=q3=Jormungar Leg Armor", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 25, "s57683", "Trade_LeatherWorking", "=ds=Fur Lining - Attack Power", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 26, "s57691", "Trade_LeatherWorking", "=ds=Fur Lining - Spell Power", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 27, "s57690", "Trade_LeatherWorking", "=ds=Fur Lining - Stamina", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 28, "s50966", "38372", "=q3=Nerubian Leg Armor", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 29, "s60584", "Trade_LeatherWorking", "=ds=Nerubian Leg Reinforcements", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 30, "s50963", "38376", "=q2=Heavy Borean Armor Kit", "=ds=#sr# 395", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s35557", "29536", "=q4=Nethercleft Leg Armor", "=ds=#sr# 365", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Exalted"] };
				{
					{ 2, "s35554", "29535", "=q4=Nethercobra Leg Armor", "=ds=#sr# 365", "=ds="..ALIL["Thrallmar"].." - "..AL["Exalted"] };
					{ 2, "s35554", "29535", "=q4=Nethercobra Leg Armor", "=ds=#sr# 365", "=ds="..ALIL["Honor Hold"].." - "..AL["Exalted"] };
				};
				{ 3, "s44770", "34207", "=q2=Glove Reinforcements", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 4, "s50962", "38375", "=q1=Borean Armor Kit", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 5, "s44970", "34330", "=q1=Heavy Knothide Armor Kit", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 6, "s35555", "29534", "=q3=Clefthide Leg Armor", "=ds=#sr# 335", "=ds="..ALIL["Cenarion Expedition"].." - "..AL["Honored"] };
				{
					{ 7, "s35549", "29533", "=q3=Cobrahide Leg Armor", "=ds=#sr# 335", "=ds="..ALIL["Thrallmar"].." - "..AL["Honored"] };
					{ 7, "s35549", "29533", "=q3=Cobrahide Leg Armor", "=ds=#sr# 335", "=ds="..ALIL["Honor Hold"].." - "..AL["Honored"] };
				};
				{ 8, "s32458", "25652", "=q1=Magister's Armor Kit", "=ds=#sr# 325", "=ds="..ALIL["The Scryers"].." - "..AL["Revered"] };
				{ 9, "s32457", "25651", "=q1=Vindicator's Armor Kit", "=ds=#sr# 325", "=ds="..ALIL["The Aldor"].." - "..AL["Revered"] };
				{ 16, "s22727", "18251", "=q3=Core Armor Kit", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Molten Core"] };
				{ 17, "s32456", "25650", "=q1=Knothide Armor Kit", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 18, "s19058", "15564", "=q1=Rugged Armor Kit", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 19, "s10487", "8173", "=q1=Thick Armor Kit", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 20, "s3780", "4265", "=q1=Heavy Armor Kit", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 21, "s2165", "2313", "=q1=Medium Armor Kit", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 22, "s2152", "2304", "=q1=Light Armor Kit", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Item Enhancements"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherDrumsBagsMisc"] = {
		["Normal"] = {
			{
				{ 1, "s146613", "102351", "=q2=Drums of Rage", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 2, "s140185", "95536", "=q3=Magnificent Hide Pack", "=ds=#sr# 595", "=ds="..AL["Discovery"]..": "..GetSpellInfo(140040)};
				{ 3, "s100583", "70136", "=q3=Royal Scribe's Satchel", "=ds=#sr# 510", "=ds="..ALIL["Molten Front"]};
				{ 4, "s100586", "70137", "=q3=Triple-Reinforced Mining Bag", "=ds=#sr# 500", "=ds="..ALIL["Molten Front"]};
				{ 5, "s69386", "49633", "=q1=Drums of Forgotten Kings", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 6, "s69388", "49634", "=q1=Drums of the Wild", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 7, "s50971", "38347", "=q3=Mammoth Mining Bag", "=ds=#sr# 415", "=ds="..ALIL["The Sons of Hodir"].." - "..AL["Honored"] };
				{ 8, "s60643", "44446", "=q3=Pack of Endless Pockets", "=ds=#sr# 415", "=ds="..AL["Trainer"] };
				{ 9, "s50970", "38399", "=q3=Trapper's Traveling Pack", "=ds=#sr# 415", "=ds="..ALIL["The Kalu'ak"].." - "..AL["Revered"] };
				{ 10, "s35538", "29532", "=q2=Drums of Panic", "=ds=#sr# 370", "=ds="..ALIL["Keepers of Time"].." - "..AL["Honored"] };
				{ 11, "s35543", "29529", "=q3=Drums of Battle", "=ds=#sr# 365", "=ds="..ALIL["The Sha'tar"].." - "..AL["Honored"] };
				{ 12, "s44359", "34105", "=q3=Quiver of a Thousand Feathers", "=ds=#sr# 360" };
				{ 16, "s45117", "34490", "=q3=Bag of Many Hides", "=ds=#sr# 350", "=ds="..AL["Drop"]..": "..ALIL["Terokkar Forest"] };
				{ 17, "s32461", "25653", "=q3=Riding Crop", "=ds=#sr# 350", "=ds="..AL["Vendor"]..": "..ALIL["Old Hillsbrad Foothills"] };
				{
					{ 18, "s35539", "29531", "=q2=Drums of Restoration", "=ds=#sr# 350", "=ds="..ALIL["The Mag'har"].." - "..AL["Honored"] };
					{ 18, "s35539", "29531", "=q2=Drums of Restoration", "=ds=#sr# 350", "=ds="..ALIL["Kurenai"].." - "..AL["Honored"] };
				};
				{
					{ 19, "s35544", "29530", "=q2=Drums of Speed", "=ds=#sr# 345", "=ds="..ALIL["The Mag'har"].." - "..AL["Honored"] };
					{ 19, "s35544", "29530", "=q2=Drums of Speed", "=ds=#sr# 345", "=ds="..ALIL["Kurenai"].." - "..AL["Honored"] };
				};
				{ 20, "s35540", "29528", "=q2=Drums of War", "=ds=#sr# 340", "=ds="..AL["Trainer"] };
				{
					{ 21, "s35530", "29540", "=q2=Reinforced Mining Bag", "=ds=#sr# 325", "=ds="..ALIL["The Mag'har"].." - "..AL["Honored"] };
					{ 21, "s35530", "29540", "=q2=Reinforced Mining Bag", "=ds=#sr# 325", "=ds="..ALIL["Kurenai"].." - "..AL["Honored"] };
				};
				{ 22, "s45100", "34482", "=q2=Leatherworker's Satchel", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{
					{ 23, "s32482", "25679", "=q1=Comfortable Insoles", "=ds=#sr# 300", "=ds="..AL["Vendor"].." - "..ALIL["Silvermoon City"] };
					{ 23, "s32482", "25679", "=q1=Comfortable Insoles", "=ds=#sr# 300", "=ds="..AL["Vendor"].." - "..ALIL["The Exodar"] };
				};
				{
					{ 24, "s44953", "34086", "=q1=Winter Boots", "=ds=#sr# 285", "=ds="..AL["Feast of Winter Veil"].." "..AL["Vendor"]..": "..ALIL["Orgrimmar"] };
					{ 24, "s44953", "34086", "=q1=Winter Boots", "=ds=#sr# 285", "=ds="..AL["Feast of Winter Veil"].." "..AL["Vendor"]..": "..ALIL["Ironforge"] };
				};
				{ 25, "s22815", "18258", "=q2=Gordok Ogre Suit", "=ds=#sr# 275", "=ds="..AL["Old Quest Reward"] };
				{
					{ 26, "s23190", "18662", "=q1=Heavy Leather Ball", "=ds=#sr# 150", "=ds="..AL["Vendor"]..": "..ALIL["Orgrimmar"] };
					{ 26, "s23190", "18662", "=q1=Heavy Leather Ball", "=ds=#sr# 150", "=ds="..AL["Vendor"]..": "..ALIL["Ironforge"] };
				};
				{
					{ 27, "s5244", "5081", "=q1=Kodo Hide Bag", "=ds=#sr# 40", "=ds=#QUESTID:769#" };
					{ 27, "", "", "", "" };
				};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Drums, Bags and Misc."],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherLeather"] = {
		["Normal"] = {
			{
				{ 1, "s146923", "98617", "=q3=Accelerated Hardened Magnificent Hide", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 2, "s142976", "98617", "=q3=Hardened Magnificent Hide", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 3, "s131865", "72163", "=q3=Magnificent Hide", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 4, "s140040", "72163", "=q3=Magnificence of Leather", "=ds=#sr# 500", "=ds="..AL["World Drop"] };
				{ 5, "s140041", "72163", "=q3=Magnificence of Scales", "=ds=#sr# 500", "=ds="..AL["World Drop"] };
				{ 6, "s124627", "72120", "=q1=Exotic Leather", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 7, "s78436", "56516", "=q1=Heavy Savage Leather", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 8, "s84950", "52976", "=q1=Savage Leather", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 9, "s50936", "38425", "=q1=Heavy Borean Leather", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
				{ 10, "s64661", "33568", "=q1=Borean Leather", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 11, "s32455", "23793", "=q1=Heavy Knothide Leather", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 16, "s32454", "21887", "=q1=Knothide Leather", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 17, "s19047", "15407", "=q1=Cured Rugged Hide", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 18, "s22331", "8170", "=q1=Rugged Leather", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 19, "s10482", "8172", "=q1=Cured Thick Hide", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 20, "s20650", "4304", "=q1=Thick Leather", "=ds=#sr# 200", "=ds="..AL["Trainer"] };
				{ 21, "s3818", "4236", "=q1=Cured Heavy Hide", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 22, "s20649", "4234", "=q1=Heavy Leather", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 23, "s3817", "4233", "=q1=Cured Medium Hide", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 24, "s20648", "2319", "=q1=Medium Leather", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 25, "s3816", "4231", "=q1=Cured Light Hide", "=ds=#sr# 35", "=ds="..AL["Trainer"] };
				{ 26, "s2881", "2318", "=q1=Light Leather", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = LEATHERWORKING..": "..BabbleInventory["Leather"],
			module = moduleName, menu = "LEATHERWORKINGMENU"
		};
	};

	AtlasLoot_Data["LeatherSpecializations"] = {
		["Normal"] = {
			{
				-- Dragonscale LW
				{ 1, 0, "INV_Box_01", "=q6="..DRAGONSCALE, "" };
				{
					{ 2, "s35576", "29516", "=q4=Ebon Netherscale Belt", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Badlands"] };
					{ 2, "s35576", "29516", "=q4=Ebon Netherscale Belt", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Azshara"] };
				};
				{
					{ 3, "s35577", "29517", "=q4=Ebon Netherscale Bracers", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Badlands"] };
					{ 3, "s35577", "29517", "=q4=Ebon Netherscale Bracers", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Azshara"] };
				};
				{
					{ 4, "s35575", "29515", "=q4=Ebon Netherscale Breastplate", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Badlands"] };
					{ 4, "s35575", "29515", "=q4=Ebon Netherscale Breastplate", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Azshara"] };
				};
				{
					{ 5, "s35582", "29520", "=q4=Netherstrike Belt", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Badlands"] };
					{ 5, "s35582", "29520", "=q4=Netherstrike Belt", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Azshara"] };
				};
				{
					{ 17, "s35584", "29521", "=q4=Netherstrike Bracers", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Badlands"] };
					{ 17, "s35584", "29521", "=q4=Netherstrike Bracers", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Azshara"] };
				};
				{
					{ 18, "s35580", "29519", "=q4=Netherstrike Breastplate", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Badlands"] };
					{ 18, "s35580", "29519", "=q4=Netherstrike Breastplate", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Azshara"] };
				};
				{ 19, "s36079", "29975", "=q3=Golden Dragonstrike Breastplate", "=ds=#sr# 330", "=ds="..AL["Trainer"] };
				{ 20, "s36076", "29971", "=q3=Dragonstrike Leggings", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
				-- Elemental LW
				{ 7, 0, "INV_Box_01", "=q6="..ELEMENTAL, "" };
				{
					{ 8, "s35590", "29526", "=q4=Primalstrike Belt", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Thunder Bluff"] };
					{ 8, "s35590", "29526", "=q4=Primalstrike Belt", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Stormwind City"] };
				};
				{
					{ 9, "s35591", "29527", "=q4=Primalstrike Bracers", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Thunder Bluff"] };
					{ 9, "s35591", "29527", "=q4=Primalstrike Bracers", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Stormwind City"] };
				};
				{
					{ 10, "s35589", "29525", "=q4=Primalstrike Vest", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Thunder Bluff"] };
					{ 10, "s35589", "29525", "=q4=Primalstrike Vest", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Stormwind"] };
				};
				{ 23, "s36077", "29973", "=q3=Primalstorm Breastplate", "=ds=#sr# 330", "=ds="..AL["Trainer"] };
				{ 24, "s36074", "29964", "=q3=Blackstorm Leggings", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
				-- Tribal LW
				{ 12, 0, "INV_Box_01", "=q6="..TRIBAL, "" };
				{
					{ 13, "s35587", "29524", "=q4=Windhawk Belt", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Northern Stranglethorn"] };
					{ 13, "s35587", "29524", "=q4=Windhawk Belt", "=ds=#sr# 375", "=ds="..AL["Trainer"].." "..AL["No Longer Available"] };
				};
				{
					{ 14, "s35588", "29523", "=q4=Windhawk Bracers", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Northern Stranglethorn"] };
					{ 14, "s35588", "29523", "=q4=Windhawk Bracers", "=ds=#sr# 375", "=ds="..AL["Trainer"].." "..AL["No Longer Available"] };
				};
				{
					{ 15, "s35585", "29522", "=q4=Windhawk Hauberk", "=ds=#sr# 375", "=ds="..AL["Trainer"]..": "..ALIL["Northern Stranglethorn"] };
					{ 15, "s35585", "29522", "=q4=Windhawk Hauberk", "=ds=#sr# 375", "=ds="..AL["Trainer"].." "..AL["No Longer Available"] };
				};
				{ 28, "s36078", "29974", "=q3=Living Crystal Breastplate", "=ds=#sr# 330", "=ds="..AL["Trainer"] };
				{ 29, "s36075", "29970", "=q3=Wildfeather Leggings", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Specializations"],
			module = moduleName, menu = "LEATHERWORKINGMENU",
		};
	};

	AtlasLoot_Data["LeatherworkingCataVendor"] = {
		["Normal"] = {
			{
				{ 1, 67095, "", "=q1=Pattern: Assassin's Chestplate", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 2, 67070, "", "=q1=Pattern: Belt of Nefarious Whispers", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 4, 67094, "", "=q1=Pattern: Chestguard of Nature's Fury", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 5, 67068, "", "=q1=Pattern: Lightning Lash", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 7, 67082, "", "=q1=Pattern: Razor-Edged Cloak", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 8, 67083, "", "=q1=Pattern: Twilight Dragonscale Cloak", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 16, 67100, "", "=q1=Pattern: Dragonkiller Tunic", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 17, 67073, "", "=q1=Pattern: Corded Viper Belt", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 19, 67096, "", "=q1=Pattern: Twilight Scale Chestguard", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 20, 67072, "", "=q1=Pattern: Stormleather Sash", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 22, 67084, "", "=q1=Pattern: Charscale Leg Armor", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 23, 68193, "", "=q1=Pattern: Dragonscale Leg Armor", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 24, 71721, "", "=q1=Pattern: Drakehide Leg Armor", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 25, 52980, "", "=q3=Pristine Hide", "=ds=#e8#", "10 #heavysavageleather#" };
			};
			{
				{ 1, 67081, "", "=q1=Pattern: Vicious Dragonscale Helm", "=ds=#p7# (520)", "10 #heavysavageleather#" };
				{ 2, 67055, "", "=q1=Pattern: Vicious Dragonscale Shoulders", "=ds=#p7# (510)", "10 #heavysavageleather#" };
				{ 3, 67093, "", "=q1=Pattern: Vicious Dragonscale Chest", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 4, 67054, "", "=q1=Pattern: Vicious Dragonscale Bracers", "=ds=#p7# (510)", "10 #heavysavageleather#" };
				{ 5, 67066, "", "=q1=Pattern: Vicious Dragonscale Gloves", "=ds=#p7# (515)", "10 #heavysavageleather#" };
				{ 6, 67080, "", "=q1=Pattern: Vicious Dragonscale Belt", "=ds=#p7# (520)", "10 #heavysavageleather#" };
				{ 7, 67092, "", "=q1=Pattern: Vicious Dragonscale Legs", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 8, 67065, "", "=q1=Pattern: Vicious Dragonscale Boots", "=ds=#p7# (515)", "10 #heavysavageleather#" };
				{ 16, 67077, "", "=q1=Pattern: Vicious Leather Helm", "=ds=#p7# (520)", "10 #heavysavageleather#" };
				{ 17, 67062, "", "=q1=Pattern: Vicious Leather Shoulders", "=ds=#p7# (515)", "10 #heavysavageleather#" };
				{ 18, 67087, "", "=q1=Pattern: Vicious Leather Chest", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 19, 67046, "", "=q1=Pattern: Vicious Leather Bracers", "=ds=#p7# (510)", "10 #heavysavageleather#" };
				{ 20, 67048, "", "=q1=Pattern: Vicious Leather Gloves", "=ds=#p7# (510)", "10 #heavysavageleather#" };
				{ 21, 67076, "", "=q1=Pattern: Vicious Leather Belt", "=ds=#p7# (520)", "10 #heavysavageleather#" };
				{ 22, 67060, "", "=q1=Pattern: Vicious Leather Boots", "=ds=#p7# (515)", "10 #heavysavageleather#" };
				{ 23, 67089, "", "=q1=Pattern: Vicious Leather Legs", "=ds=#p7# (525)", "10 #heavysavageleather#" };
			};
			{
				{ 1, 67091, "", "=q1=Pattern: Vicious Charscale Helm", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 2, 67078, "", "=q1=Pattern: Vicious Charscale Shoulders", "=ds=#p7# (520)", "10 #heavysavageleather#" };
				{ 3, 67090, "", "=q1=Pattern: Vicious Charscale Chest", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 4, 67049, "", "=q1=Pattern: Vicious Charscale Bracers", "=ds=#p7# (510)", "10 #heavysavageleather#" };
				{ 5, 67053, "", "=q1=Pattern: Vicious Charscale Gloves", "=ds=#p7# (510)", "10 #heavysavageleather#" };
				{ 6, 67064, "", "=q1=Pattern: Vicious Charscale Belt", "=ds=#p7# (515)", "10 #heavysavageleather#" };
				{ 7, 67079, "", "=q1=Pattern: Vicious Charscale Legs", "=ds=#p7# (520)", "10 #heavysavageleather#" };
				{ 8, 67063, "", "=q1=Pattern: Vicious Charscale Boots", "=ds=#p7# (515)", "10 #heavysavageleather#" };
				{ 16, 67086, "", "=q1=Pattern: Vicious Wyrmhide Helm", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 17, 67074, "", "=q1=Pattern: Vicious Wyrmhide Shoulders", "=ds=#p7# (520)", "10 #heavysavageleather#" };
				{ 18, 67075, "", "=q1=Pattern: Vicious Wyrmhide Chest", "=ds=#p7# (520)", "10 #heavysavageleather#" };
				{ 19, 67042, "", "=q1=Pattern: Vicious Wyrmhide Bracers", "=ds=#p7# (510)", "10 #heavysavageleather#" };
				{ 20, 67056, "", "=q1=Pattern: Vicious Wyrmhide Gloves", "=ds=#p7# (515)", "10 #heavysavageleather#" };
				{ 21, 67044, "", "=q1=Pattern: Vicious Wyrmhide Belt", "=ds=#p7# (510)", "10 #heavysavageleather#" };
				{ 22, 67085, "", "=q1=Pattern: Vicious Wyrmhide Legs", "=ds=#p7# (525)", "10 #heavysavageleather#" };
				{ 23, 67058, "", "=q1=Pattern: Vicious Wyrmhide Boots", "=ds=#p7# (515)", "10 #heavysavageleather#" };
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Cataclysm Vendor Sold Patterns"],
			module = moduleName, menu = "LEATHERWORKINGMENU",
		};
	};

	AtlasLoot_Data["LeatherworkingMoPVendor"] = {
		["Normal"] = {
			{
				{ 1, 86253, "", "=q1=Pattern: Contender's Leather Helm", "=ds=#p7# (590)", "#SPIRITOFHARMONY:1#"};
				{ 2, 86255, "", "=q1=Pattern: Contender's Leather Shoulders", "=ds=#p7# (575)", "#SPIRITOFHARMONY:1#"};
				{ 3, 86251, "", "=q1=Pattern: Contender's Leather Chestguard", "=ds=#p7# (590)", "#SPIRITOFHARMONY:1#"};
				{ 4, 86250, "", "=q1=Pattern: Contender's Leather Bracers", "=ds=#p7# (555)", "#SPIRITOFHARMONY:1#"};
				{ 5, 86252, "", "=q1=Pattern: Contender's Leather Gloves", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 6, 86248, "", "=q1=Pattern: Contender's Leather Belt", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 7, 86254, "", "=q1=Pattern: Contender's Leather Leggings", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 8, 86249, "", "=q1=Pattern: Contender's Leather Boots", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 16, 86269, "", "=q1=Pattern: Contender's Wyrmhide Helm", "=ds=#p7# (590)", "#SPIRITOFHARMONY:1#"};
				{ 17, 86271, "", "=q1=Pattern: Contender's Wyrmhide Shoulders", "=ds=#p7# (575)", "#SPIRITOFHARMONY:1#"};
				{ 18, 86267, "", "=q1=Pattern: Contender's Wyrmhide Chestguard", "=ds=#p7# (590)", "#SPIRITOFHARMONY:1#"};
				{ 19, 86266, "", "=q1=Pattern: Contender's Wyrmhide Bracers", "=ds=#p7# (555)", "#SPIRITOFHARMONY:1#"};
				{ 20, 86268, "", "=q1=Pattern: Contender's Wyrmhide Gloves", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 21, 86264, "", "=q1=Pattern: Contender's Wyrmhide Belt", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 22, 86270, "", "=q1=Pattern: Contender's Wyrmhide Leggings", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 23, 86265, "", "=q1=Pattern: Contender's Wyrmhide Boots", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
			};
			{
				{ 1, 86245, "", "=q1=Pattern: Contender's Dragonscale Helm", "=ds=#p7# (590)", "#SPIRITOFHARMONY:1#"};
				{ 2, 86247, "", "=q1=Pattern: Contender's Dragonscale Shoulders", "=ds=#p7# (575)", "#SPIRITOFHARMONY:1#"};
				{ 3, 86241, "", "=q1=Pattern: Contender's Dragonscale Chestguard", "=ds=#p7# (590)", "#SPIRITOFHARMONY:1#"};
				{ 4, 86242, "", "=q1=Pattern: Contender's Dragonscale Bracers", "=ds=#p7# (555)", "#SPIRITOFHARMONY:1#"};
				{ 5, 86244, "", "=q1=Pattern: Contender's Dragonscale Gloves", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 6, 86240, "", "=q1=Pattern: Contender's Dragonscale Belt", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 7, 86246, "", "=q1=Pattern: Contender's Dragonscale Leggings", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 8, 86241, "", "=q1=Pattern: Contender's Dragonscale Boots", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 16, 86261, "", "=q1=Pattern: Contender's Scale Helm", "=ds=#p7# (590)", "#SPIRITOFHARMONY:1#"};
				{ 17, 86263, "", "=q1=Pattern: Contender's Scale Shoulders", "=ds=#p7# (575)", "#SPIRITOFHARMONY:1#"};
				{ 18, 86259, "", "=q1=Pattern: Contender's Scale Chestguard", "=ds=#p7# (590)", "#SPIRITOFHARMONY:1#"};
				{ 19, 86258, "", "=q1=Pattern: Contender's Scale Bracers", "=ds=#p7# (555)", "#SPIRITOFHARMONY:1#"};
				{ 20, 86260, "", "=q1=Pattern: Contender's Scale Gloves", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 21, 86256, "", "=q1=Pattern: Contender's Scale Belt", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 22, 86259, "", "=q1=Pattern: Contender's Scale Leggings", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
				{ 23, 86257, "", "=q1=Pattern: Contender's Scale Boots", "=ds=#p7# (565)", "#SPIRITOFHARMONY:1#"};
			};
		};
		info = {
			name = LEATHERWORKING..": "..AL["Mists of Pandaria Vendor Sold Patterns"],
			module = moduleName, menu = "LEATHERWORKINGMENU",
		};
	};

		--------------
		--- Mining ---
		--------------

	AtlasLoot_Data["Mining"] = {
		["Normal"] = {
			{
				{ 1, "s102167", "72095", "=q2=Trillium Bar", "=ds=#sr# 600", "=ds="..AL["Trainer"] };
				{ 2, "s102165", "72096", "=q1=Smelt Ghost Iron", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 3, "s74529", "51950", "=q2=Smelt Pyrium", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 4, "s74537", "53039", "=q1=Smelt Hardened Elementium", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 5, "s74530", "52186", "=q1=Smelt Elementium", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 6, "s84038", "54849", "=q1=Smelt Obsidium", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 7, "s55208", "37663", "=q2=Smelt Titansteel", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 8, "s55211", "41163", "=q2=Smelt Titanium", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 9, "s49258", "36913", "=q1=Smelt Saronite", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 10, "s49252", "36916", "=q1=Smelt Cobalt", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 11, "s46353", "35128", "=q2=Smelt Hardened Khorium", "=ds=#sr# 375", "=ds="..AL["Drop"]..": "..ALIL["Sunwell Plateau"] };
				{ 12, "s29686", "23573", "=q1=Smelt Hardened Adamantite", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 13, "s29361", "23449", "=q2=Smelt Khorium", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 14, "s29360", "23448", "=q2=Smelt Felsteel", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 15, "s29359", "23447", "=q2=Smelt Eternium", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 16, "s29358", "23446", "=q1=Smelt Adamantite", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 17, "s29356", "23445", "=q1=Smelt Fel Iron", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 18, "s35751", "22574", "=q1=Fire Sunder", "=ds=#sr# 300", "=ds="..AL["Trainer"], amount = 10 };
				{ 19, "s35750", "22573", "=q1=Earth Shatter", "=ds=#sr# 300", "=ds="..AL["Trainer"], amount = 10 };
				{ 20, "s22967", "17771", "=q5=Smelt Enchanted Elementium", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Blackwing Lair"] };
				{ 21, "s70524", "12655", "=q1=Enchanted Thorium", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 22, "s14891", "11371", "=q1=Smelt Dark Iron", "=ds=#sr# 230", "=ds=#QUESTID:4083#"};
				{ 23, "s16153", "12359", "=q1=Smelt Thorium", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
				{ 24, "s10098", "6037", "=q2=Smelt Truesilver", "=ds=#sr# 165", "=ds="..AL["Trainer"] };
				{ 25, "s10097", "3860", "=q1=Smelt Mithril", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 26, "s3569", "3859", "=q1=Smelt Steel", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 27, "s3308", "3577", "=q2=Smelt Gold", "=ds=#sr# 115", "=ds="..AL["Trainer"] };
				{ 28, "s3307", "3575", "=q1=Smelt Iron", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 29, "s2658", "2842", "=q2=Smelt Silver", "=ds=#sr# 65", "=ds="..AL["Trainer"] };
				{ 30, "s2659", "2841", "=q1=Smelt Bronze", "=ds=#sr# 50", "=ds="..AL["Trainer"], amount = 2 };
			};
			{
				{ 1, "s3304", "3576", "=q1=Smelt Tin", "=ds=#sr# 50", "=ds="..AL["Trainer"] };
				{ 2, "s2657", "2840", "=q1=Smelt Copper", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = MINING,
			module = moduleName, menu = "CRAFTINGMENU",
		};
	};

		-----------------
		--- Tailoring ---
		-----------------

	AtlasLoot_Data["TailoringArmorOld"] = {
		["Normal"] = {
			{
				{ 1, "s22866", "18405", "=q4=Belt of the Archmage", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Dire Maul"]};
				{ 2, "s20849", "16979", "=q4=Flarecore Gloves", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Blackrock Depths"]};
				{ 3, "s23667", "19165", "=q4=Flarecore Leggings", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Blackrock Depths"]};
				{ 4, "s20848", "16980", "=q4=Flarecore Mantle", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Blackrock Depths"]};
				{ 5, "s23666", "19156", "=q4=Flarecore Robe", "=ds=#sr# 300", "=ds="..AL["Vendor"]..": "..ALIL["Blackrock Depths"]};
				{ 6, "s22759", "18263", "=q4=Flarecore Wraps", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Molten Core"]};
				{ 7, "s28208", "22658", "=q4=Glacial Cloak", "=ds=#sr# 300"};
				{ 8, "s28205", "22654", "=q4=Glacial Gloves", "=ds=#sr# 300"};
				{ 9, "s28207", "22652", "=q4=Glacial Vest", "=ds=#sr# 300"};
				{ 10, "s28209", "22655", "=q4=Glacial Wrists", "=ds=#sr# 300"};
				{ 11, "s18454", "14146", "=q4=Gloves of Spell Mastery", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 12, "s18457", "14152", "=q4=Robe of the Archmage", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Lower Blackrock Spire"]};
				{ 13, "s18458", "14153", "=q4=Robe of the Void", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Scholomance"]};
				{ 14, "s18456", "14154", "=q4=Truefaith Vestments", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Stratholme"]};
				{ 15, "s23665", "19059", "=q3=Argent Shoulders", "=ds=#sr# 300", "=ds="..ALIL["Argent Dawn"].." - "..AL["Revered"]};
				{ 16, "s24093", "19684", "=q3=Bloodvine Boots", "=ds=#sr# 300", "=ds="..AL["No Longer Available"]};
				{ 17, "s24092", "19683", "=q3=Bloodvine Leggings", "=ds=#sr# 300", "=ds="..AL["No Longer Available"]};
				{ 18, "s24091", "19682", "=q3=Bloodvine Vest", "=ds=#sr# 300", "=ds="..AL["No Longer Available"]};
				{ 19, "s22870", "18413", "=q3=Cloak of Warding", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 20, "s22867", "18407", "=q3=Felcloth Gloves", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 21, "s28210", "22660", "=q3=Gaea's Embrace", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Revered"]};
				{ 22, "s22868", "18408", "=q3=Inferno Gloves", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 23, "s23663", "19050", "=q3=Mantle of the Timbermaw", "=ds=#sr# 300", "=ds="..ALIL["Timbermaw Hold"].." - "..AL["Revered"]};
				{ 24, "s18452", "14140", "=q3=Mooncloth Circlet", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 25, "s22869", "18409", "=q3=Mooncloth Gloves", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 26, "s22902", "18486", "=q3=Mooncloth Robe", "=ds=#sr# 300", "=ds="..AL["Vendor"]};
				{ 27, "s18448", "14139", "=q3=Mooncloth Shoulders", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 28, "s18447", "14138", "=q3=Mooncloth Vest", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 29, "s24902", "20539", "=q3=Runed Stygian Belt", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 30, "s24903", "20537", "=q3=Runed Stygian Boots", "=ds=#sr# 300", "=ds="..AL["Drop"]};
			};
			{
				{ 1, "s24901", "20538", "=q3=Runed Stygian Leggings", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 2, "s28481", "22757", "=q3=Sylvan Crown", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Honored"]};
				{ 3, "s28482", "22758", "=q3=Sylvan Shoulders", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Friendly"]};
				{ 4, "s28480", "22756", "=q3=Sylvan Vest", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Revered"]};
				{ 5, "s19435", "15802", "=q3=Mooncloth Boots", "=ds=#sr# 290", "=ds=#QUESTID:6032#"};
				{ 6, "s23664", "19056", "=q3=Argent Boots", "=ds=#sr# 290", "=ds="..ALIL["Argent Dawn"].." - "..AL["Honored"]};
				{ 7, "s18440", "14137", "=q3=Mooncloth Leggings", "=ds=#sr# 290", "=ds="..AL["Drop"]};
				{ 8, "s23662", "19047", "=q3=Wisdom of the Timbermaw", "=ds=#sr# 290", "=ds="..ALIL["Timbermaw Hold"].." - "..AL["Honored"]};
				{ 9, "s18436", "14136", "=q3=Robe of Winter Night", "=ds=#sr# 285", "=ds="..AL["Drop"]};
				{ 10, "s18422", "14134", "=q3=Cloak of Fire", "=ds=#sr# 275", "=ds="..AL["Drop"]..": "..AL["Blackrock Mountain"]};
				{ 11, "s12092", "10041", "=q3=Dreamweave Circlet", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 12, "s12067", "10019", "=q3=Dreamweave Gloves", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 13, "s12070", "10021", "=q3=Dreamweave Vest", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 14, "s3862", "4327", "=q3=Icy Cloak", "=ds=#sr# 200", "=ds="..AL["Vendor"] };
				{ 15, "s8770", "7054", "=q3=Robe of Power", "=ds=#sr# 190", "=ds="..AL["Trainer"] };
				{ 16, "s63742", "45626", "=q3=Spidersilk Drape", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 17, "s3855", "4320", "=q3=Spidersilk Boots", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 18, "s18451", "14106", "=q2=Felcloth Robe", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 19, "s18453", "14112", "=q2=Felcloth Shoulders", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 20, "s18449", "13867", "=q2=Runecloth Shoulders", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 21, "s18446", "14128", "=q2=Wizardweave Robe", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 22, "s18450", "14130", "=q2=Wizardweave Turban", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 23, "s18439", "14104", "=q2=Brightcloth Pants", "=ds=#sr# 290", "=ds="..AL["Drop"] };
				{ 24, "s18442", "14111", "=q2=Felcloth Hood", "=ds=#sr# 290", "=ds="..AL["Trainer"] };
				{ 25, "s18441", "14144", "=q2=Ghostweave Pants", "=ds=#sr# 290", "=ds="..AL["Trainer"] };
				{ 26, "s18444", "13866", "=q2=Runecloth Headband", "=ds=#sr# 295", "=ds="..AL["Trainer"] };
				{ 27, "s18437", "14108", "=q2=Felcloth Boots", "=ds=#sr# 285", "=ds="..AL["Trainer"] };
				{ 28, "s18438", "13865", "=q2=Runecloth Pants", "=ds=#sr# 285", "=ds="..AL["Trainer"] };
				{ 29, "s18434", "14045", "=q2=Cindercloth Pants", "=ds=#sr# 280", "=ds="..AL["Drop"]..": "..ALIL["Burning Steppes"]};
				{ 30, "s18424", "13871", "=q2=Frostweave Pants", "=ds=#sr# 280", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s18423", "13864", "=q2=Runecloth Boots", "=ds=#sr# 280", "=ds="..AL["Trainer"] };
				{ 2, "s18420", "14103", "=q2=Brightcloth Cloak", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 3, "s18418", "14044", "=q2=Cindercloth Cloak", "=ds=#sr# 275", "=ds="..AL["Drop"]..": "..ALIL["Burning Steppes"]};
				{ 4, "s18419", "14107", "=q2=Felcloth Pants", "=ds=#sr# 275", "=ds="..AL["Vendor"] };
				{ 5, "s18416", "14141", "=q2=Ghostweave Vest", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 6, "s22813", "18258", "=q2=Gordok Ogre Suit", "=ds=#sr# 275", "=ds=#QUESTID:27119#"};
				{ 7, "s18417", "13863", "=q2=Runecloth Gloves", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 8, "s18421", "14132", "=q2=Wizardweave Leggings", "=ds=#sr# 275", "=ds="..AL["Trainer"] };
				{ 9, "s18415", "14101", "=q2=Brightcloth Gloves", "=ds=#sr# 270", "=ds="..AL["Trainer"] };
				{ 10, "s18414", "14100", "=q2=Brightcloth Robe", "=ds=#sr# 270", "=ds="..AL["Trainer"] };
				{ 11, "s18412", "14043", "=q2=Cindercloth Gloves", "=ds=#sr# 270", "=ds="..AL["Drop"]..": "..ALIL["Searing Gorge"]};
				{ 12, "s18413", "14142", "=q2=Ghostweave Gloves", "=ds=#sr# 270", "=ds="..AL["Trainer"] };
				{ 13, "s18411", "13870", "=q2=Frostweave Gloves", "=ds=#sr# 265", "=ds="..AL["Trainer"] };
				{ 14, "s18410", "14143", "=q2=Ghostweave Belt", "=ds=#sr# 265", "=ds="..AL["Trainer"] };
				{ 15, "s18409", "13860", "=q2=Runecloth Cloak", "=ds=#sr# 265", "=ds="..AL["Trainer"] };
				{ 16, "s18408", "14042", "=q2=Cindercloth Vest", "=ds=#sr# 260", "=ds="..AL["Drop"]..": "..ALIL["Searing Gorge"]};
				{ 17, "s18406", "13858", "=q2=Runecloth Robe", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
				{ 18, "s18407", "13857", "=q2=Runecloth Tunic", "=ds=#sr# 260", "=ds="..AL["Trainer"] };
				{ 19, "s18404", "13868", "=q2=Frostweave Robe", "=ds=#sr# 255", "=ds="..AL["Drop"] };
				{ 20, "s18403", "13869", "=q2=Frostweave Tunic", "=ds=#sr# 255", "=ds="..AL["Trainer"] };
				{ 21, "s18402", "13856", "=q2=Runecloth Belt", "=ds=#sr# 255", "=ds="..AL["Trainer"] };
				{ 22, "s12088", "10044", "=q2=Cindercloth Boots", "=ds=#sr# 245", "=ds="..AL["Trainer"] };
				{ 23, "s12086", "10025", "=q2=Shadoweave Mask", "=ds=#sr# 245"};
				{ 24, "s12081", "10030", "=q2=Admiral's Hat", "=ds=#sr# 240", "=ds="..AL["Vendor"]..": "..ALIL["The Cape of Stranglethorn"]};
				{ 25, "s12084", "10033", "=q2=Red Mageweave Headband", "=ds=#sr# 240", "=ds="..AL["Drop"] };
				{ 26, "s12082", "10031", "=q2=Shadoweave Boots", "=ds=#sr# 240", "=ds="..AL["Trainer"] };
				{ 27, "s12078", "10029", "=q2=Red Mageweave Shoulders", "=ds=#sr# 235", "=ds="..AL["Drop"] };
				{ 28, "s12076", "10028", "=q2=Shadoweave Shoulders", "=ds=#sr# 235", "=ds="..AL["Trainer"] };
				{ 29, "s12073", "10026", "=q2=Black Mageweave Boots", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
				{ 30, "s12072", "10024", "=q2=Black Mageweave Headband", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s12074", "10027", "=q2=Black Mageweave Shoulders", "=ds=#sr# 230", "=ds="..AL["Trainer"] };
				{ 2, "s12069", "10042", "=q2=Cindercloth Robe", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 3, "s12066", "10018", "=q2=Red Mageweave Gloves", "=ds=#sr# 225", "=ds="..AL["Drop"] };
				{ 4, "s12071", "10023", "=q2=Shadoweave Gloves", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 5, "s12059", "10008", "=q2=White Bandit Mask", "=ds=#sr# 215", "=ds="..AL["Drop"] };
				{ 6, "s12053", "10003", "=q2=Black Mageweave Gloves", "=ds=#sr# 215", "=ds="..AL["Trainer"] };
				{ 7, "s12060", "10009", "=q2=Red Mageweave Pants", "=ds=#sr# 215", "=ds="..AL["Drop"] };
				{ 8, "s12056", "10007", "=q2=Red Mageweave Vest", "=ds=#sr# 215", "=ds="..AL["Drop"] };
				{ 9, "s12055", "10004", "=q2=Shadoweave Robe", "=ds=#sr# 215", "=ds="..AL["Trainer"] };
				{ 10, "s12050", "10001", "=q2=Black Mageweave Robe", "=ds=#sr# 210", "=ds="..AL["Trainer"] };
				{ 11, "s8804", "7064", "=q2=Crimson Silk Gloves", "=ds=#sr# 210", "=ds="..AL["Trainer"] };
				{ 12, "s12052", "10002", "=q2=Shadoweave Pants", "=ds=#sr# 210", "=ds="..AL["Trainer"] };
				{ 13, "s12049", "9999", "=q2=Black Mageweave Leggings", "=ds=#sr# 205", "=ds="..AL["Trainer"] };
				{ 14, "s12048", "9998", "=q2=Black Mageweave Vest", "=ds=#sr# 205", "=ds="..AL["Trainer"] };
				{ 15, "s8802", "7063", "=q2=Crimson Silk Robe", "=ds=#sr# 205", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 16, "s3864", "4329", "=q2=Star Belt", "=ds=#sr# 200", "=ds="..AL["Drop"] };
				{ 17, "s8797", "7061", "=q2=Earthen Silk Belt", "=ds=#sr# 195", "=ds="..AL["Drop"] };
				{ 18, "s8795", "7060", "=q2=Azure Shoulders", "=ds=#sr# 190", "=ds="..AL["Drop"] };
				{ 19, "s8793", "7059", "=q2=Crimson Silk Shoulders", "=ds=#sr# 190", "=ds="..AL["Drop"] };
				{ 20, "s3861", "4326", "=q2=Long Silken Cloak", "=ds=#sr# 185", "=ds="..AL["Trainer"] };
				{ 21, "s3863", "4328", "=q2=Spider Belt", "=ds=#sr# 180", "=ds="..AL["Drop"] };
				{ 22, "s8789", "7056", "=q2=Crimson Silk Cloak", "=ds=#sr# 180", "=ds="..AL["Vendor"]..": "..ALIL["The Cape of Stranglethorn"]};
				{ 23, "s8774", "7057", "=q2=Green Silken Shoulders", "=ds=#sr# 180", "=ds="..AL["Trainer"] };
				{ 24, "s8766", "7052", "=q2=Azure Silk Belt", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 25, "s8786", "7053", "=q2=Azure Silk Cloak", "=ds=#sr# 175", "=ds="..AL["Vendor"]..": "..ALIL["Arathi Highlands"]};
				{ 26, "s3860", "4325", "=q2=Boots of the Enchanter", "=ds=#sr# 175", "=ds="..AL["Drop"] };
				{ 27, "s8772", "7055", "=q2=Crimson Silk Belt", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 28, "s8764", "7051", "=q2=Earthen Vest", "=ds=#sr# 170", "=ds="..AL["Trainer"] };
				{ 29, "s3858", "4323", "=q2=Shadow Hood", "=ds=#sr# 170", "=ds="..AL["Drop"] };
				{ 30, "s3857", "4322", "=q2=Enchanter's Cowl", "=ds=#sr# 165", "=ds="..AL["Vendor"]..": "..ALIL["The Cape of Stranglethorn"]};
			};
			{
				{ 1, "s8784", "7065", "=q2=Green Silk Armor", "=ds=#sr# 165", "=ds="..AL["Drop"] };
				{ 2, "s3859", "4324", "=q2=Azure Silk Vest", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 3, "s6692", "5770", "=q2=Robes of Arcana", "=ds=#sr# 150", "=ds="..AL["Drop"]..": "..ALIL["Thousand Needles"]};
				{ 4, "s8782", "7049", "=q2=Truefaith Gloves", "=ds=#sr# 150", "=ds="..AL["Drop"] };
				{ 5, "s3854", "4319", "=q2=Azure Silk Gloves", "=ds=#sr# 145", "=ds="..AL["Vendor"] };
				{ 6, "s8780", "7047", "=q2=Hands of Darkness", "=ds=#sr# 145", "=ds="..AL["Drop"] };
				{ 7, "s8758", "7046", "=q2=Azure Silk Pants", "=ds=#sr# 140", "=ds="..AL["Trainer"] };
				{ 8, "s3856", "4321", "=q2=Spider Silk Slippers", "=ds=#sr# 140", "=ds="..AL["Drop"] };
				{ 9, "s6690", "5766", "=q2=Lesser Wizard's Robe", "=ds=#sr# 135", "=ds="..AL["Trainer"] };
				{ 10, "s3852", "4318", "=q2=Gloves of Meditation", "=ds=#sr# 130", "=ds="..AL["Trainer"] };
				{ 11, "s3868", "4331", "=q2=Phoenix Gloves", "=ds=#sr# 125", "=ds="..AL["Drop"] };
				{ 12, "s3851", "4317", "=q2=Phoenix Pants", "=ds=#sr# 125", "=ds="..AL["Drop"] };
				{ 13, "s12047", "10048", "=q2=Colorful Kilt", "=ds=#sr# 120", "=ds="..AL["Drop"] };
				{ 14, "s7643", "6264", "=q2=Greater Adept's Robe", "=ds=#sr# 115", "=ds="..AL["Vendor"] };
				{ 15, "s3850", "4316", "=q2=Heavy Woolen Pants", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 16, "s2403", "2585", "=q2=Gray Woolen Robe", "=ds=#sr# 105", "=ds="..AL["Drop"] };
				{ 17, "s7639", "6263", "=q2=Blue Overalls", "=ds=#sr# 100", "=ds="..AL["Vendor"] };
				{ 18, "s3844", "4311", "=q2=Heavy Woolen Cloak", "=ds=#sr# 100", "=ds="..AL["Drop"] };
				{ 19, "s3847", "4313", "=q2=Red Woolen Boots", "=ds=#sr# 95", "=ds="..AL["Drop"] };
				{ 20, "s2401", "2583", "=q2=Woolen Boots", "=ds=#sr# 95", "=ds="..AL["Trainer"] };
				{ 21, "s6521", "5542", "=q2=Pearl-clasped Cloak", "=ds=#sr# 90", "=ds="..AL["Trainer"] };
				{ 22, "s3843", "4310", "=q2=Heavy Woolen Gloves", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
				{ 23, "s3845", "4312", "=q2=Soft-soled Linen Boots", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 24, "s2395", "2578", "=q2=Barbaric Linen Vest", "=ds=#sr# 70", "=ds="..AL["Trainer"] };
				{ 25, "s7633", "6242", "=q2=Blue Linen Robe", "=ds=#sr# 70", "=ds="..AL["Vendor"] };
				{ 26, "s3842", "4309", "=q2=Handstitched Linen Britches", "=ds=#sr# 70", "=ds="..AL["Trainer"] };
				{ 27, "s7630", "6240", "=q2=Blue Linen Vest", "=ds=#sr# 55", "=ds="..AL["Vendor"] };
				{ 28, "s7629", "6239", "=q2=Red Linen Vest", "=ds=#sr# 55", "=ds="..AL["Drop"] };
				{ 29, "s2389", "2572", "=q2=Red Linen Robe", "=ds=#sr# 40", "=ds="..AL["Drop"] };
				{ 30, "s7623", "6238", "=q2=Brown Linen Robe", "=ds=#sr# 30", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s7624", "6241", "=q2=White Linen Robe", "=ds=#sr# 30", "=ds="..AL["Trainer"] };
				{ 2, "s49677", "6836", "=q1=Dress Shoes", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 3, "s50644", "38277", "=q1=Haliscan Jacket", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 4, "s50647", "38278", "=q1=Haliscan Pantaloons", "=ds=#sr# 245", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 5, "s26403", "21154", "=q1=Festival Dress", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Moonglade"]};
				{ 6, "s26407", "21542", "=q1=Festive Red Pant Suit", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Moonglade"]};
				{ 7, "s12093", "10036", "=q1=Tuxedo Jacket", "=ds=#sr# 250", "=ds="..AL["Vendor"] };
				{ 8, "s44950", "34087", "=q1=Green Winter Clothes", "=ds=#sr# 250", "=ds="..AL["Vendor"] };
				{ 9, "s44958", "34085", "=q1=Red Winter Clothes", "=ds=#sr# 250", "=ds="..AL["Vendor"] };
				{ 10, "s12091", "10040", "=q1=White Wedding Dress", "=ds=#sr# 250", "=ds="..AL["Vendor"] };
				{ 11, "s12089", "10035", "=q1=Tuxedo Pants", "=ds=#sr# 245", "=ds="..AL["Vendor"] };
				{ 12, "s12077", "10053", "=q1=Simple Black Dress", "=ds=#sr# 235", "=ds="..AL["Trainer"] };
				{ 13, "s8799", "7062", "=q1=Crimson Silk Pantaloons", "=ds=#sr# 195", "=ds="..AL["Trainer"] };
				{ 14, "s8791", "7058", "=q1=Crimson Silk Vest", "=ds=#sr# 185", "=ds="..AL["Trainer"] };
				{ 15, "s8762", "7050", "=q1=Silk Headband", "=ds=#sr# 160", "=ds="..AL["Trainer"] };
				{ 16, "s8760", "7048", "=q1=Azure Silk Hood", "=ds=#sr# 145", "=ds="..AL["Trainer"] };
				{ 17, "s3849", "4315", "=q1=Reinforced Woolen Shoulders", "=ds=#sr# 120", "=ds="..AL["Drop"] };
				{ 18, "s3848", "4314", "=q1=Double-stitched Woolen Shoulders", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 19, "s8467", "6787", "=q1=White Woolen Dress", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 20, "s2399", "2582", "=q1=Green Woolen Vest", "=ds=#sr# 85", "=ds="..AL["Trainer"] };
				{ 21, "s12046", "10047", "=q1=Simple Kilt", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 22, "s2402", "2584", "=q1=Woolen Cape", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 23, "s2386", "2569", "=q1=Linen Boots", "=ds=#sr# 65", "=ds="..AL["Trainer"] };
				{ 24, "s3841", "4308", "=q1=Green Linen Bracers", "=ds=#sr# 60", "=ds="..AL["Trainer"] };
				{ 25, "s2397", "2580", "=q1=Reinforced Linen Cape", "=ds=#sr# 60", "=ds="..AL["Trainer"] };
				{ 26, "s8465", "6786", "=q1=Simple Dress", "=ds=#sr# 40", "=ds="..AL["Trainer"] };
				{ 27, "s3840", "4307", "=q1=Heavy Linen Gloves", "=ds=#sr# 35", "=ds="..AL["Trainer"] };
				{ 28, "s3914", "4343", "=q1=Brown Linen Pants", "=ds=#sr# 30", "=ds="..AL["Trainer"] };
				{ 29, "s12045", "10046", "=q1=Simple Linen Boots", "=ds=#sr# 20", "=ds="..AL["Trainer"] };
				{ 30, "s8776", "7026", "=q1=Linen Belt", "=ds=#sr# 15", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s2385", "2568", "=q1=Brown Linen Vest", "=ds=#sr# 10", "=ds="..AL["Trainer"] };
				{ 2, "s2387", "2570", "=q1=Linen Cloak", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
				{ 3, "s12044", "10045", "=q1=Simple Linen Pants", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = TAILORING..": "..BabbleInventory["Armor"].." - "..AL["Classic WoW"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringArmorBC"] = {
		["Normal"] = {
			{
				{ 1, "s31456", "24267", "=q4=Battlecast Hood", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 2, "s31453", "24263", "=q4=Battlecast Pants", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 3, "s36315", "30038", "=q4=Belt of Blasting", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 4, "s36316", "30036", "=q4=Belt of the Long Road", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 5, "s36317", "30037", "=q4=Boots of Blasting", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 6, "s36318", "30035", "=q4=Boots of the Long Road", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 7, "s41205", "32586", "=q4=Bracers of Nimble Thought", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 8, "s26758", "21871", "=q4=Frozen Shadoweave Robe", "=ds=#sr# 375", "=ds="..AL["Vendor"] };
				{ 9, "s41206", "32587", "=q4=Mantle of Nimble Thought", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 10, "s40060", "32420", "=q4=Night's End", "=ds=#sr# 375", "=ds="..ALIL["Ashtongue Deathsworn"].." - "..AL["Honored"]};
				{ 11, "s26762", "21875", "=q4=Primal Mooncloth Robe", "=ds=#sr# 375", "=ds="..AL["Vendor"] };
				{ 12, "s26781", "21865", "=q4=Soulcloth Vest", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 13, "s40021", "32392", "=q4=Soulguard Bracers", "=ds=#sr# 375", "=ds="..ALIL["Ashtongue Deathsworn"].." - "..AL["Friendly"]};
				{ 14, "s40024", "32390", "=q4=Soulguard Girdle", "=ds=#sr# 375", "=ds="..ALIL["Ashtongue Deathsworn"].." - "..AL["Friendly"]};
				{ 15, "s40023", "32389", "=q4=Soulguard Leggings", "=ds=#sr# 375", "=ds="..ALIL["Ashtongue Deathsworn"].." - "..AL["Honored"]};
				{ 16, "s40020", "32391", "=q4=Soulguard Slippers", "=ds=#sr# 375", "=ds="..ALIL["Ashtongue Deathsworn"].." - "..AL["Honored"]};
				{ 17, "s26754", "21848", "=q4=Spellfire Robe", "=ds=#sr# 375", "=ds="..AL["Vendor"] };
				{ 18, "s31455", "24266", "=q4=Spellstrike Hood", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 19, "s31452", "24262", "=q4=Spellstrike Pants", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 20, "s41208", "32585", "=q4=Swiftheal Mantle", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 21, "s41207", "32584", "=q4=Swiftheal Wraps", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 22, "s31454", "24264", "=q4=Whitemend Hood", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 23, "s31451", "24261", "=q4=Whitemend Pants", "=ds=#sr# 375", "=ds="..AL["Drop"] };
				{ 24, "s31444", "24257", "=q4=Black Belt of Knowledge", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 25, "s26757", "21870", "=q4=Frozen Shadoweave Boots", "=ds=#sr# 365", "=ds="..AL["Vendor"] };
				{ 26, "s31443", "24256", "=q4=Girdle of Ruination", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 27, "s46129", "34367", "=q4=Hands of Eternal Light", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 28, "s31450", "24260", "=q4=Manaweave Cloak", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 29, "s26761", "21874", "=q4=Primal Mooncloth Shoulders", "=ds=#sr# 365", "=ds="..AL["Vendor"] };
				{ 30, "s31448", "24258", "=q4=Resolute Cape", "=ds=#sr# 365", "=ds="..AL["Drop"] };
			};
			{
				{ 1, "s46131", "34365", "=q4=Robe of Eternal Light", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 2, "s26780", "21864", "=q4=Soulcloth Shoulders", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 3, "s26753", "21847", "=q4=Spellfire Gloves", "=ds=#sr# 365", "=ds="..AL["Vendor"] };
				{ 4, "s46128", "34366", "=q4=Sunfire Handwraps", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 5, "s46130", "34364", "=q4=Sunfire Robe", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 6, "s31442", "24255", "=q4=Unyielding Girdle", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 7, "s31449", "24259", "=q4=Vengeance Wrap", "=ds=#sr# 365", "=ds="..AL["Drop"] };
				{ 8, "s26756", "21869", "=q4=Frozen Shadoweave Shoulders", "=ds=#sr# 355", "=ds="..AL["Vendor"] };
				{ 9, "s26760", "21873", "=q4=Primal Mooncloth Belt", "=ds=#sr# 355", "=ds="..AL["Vendor"] };
				{ 10, "s26779", "21863", "=q4=Soulcloth Gloves", "=ds=#sr# 355", "=ds="..AL["Vendor"] };
				{ 11, "s26752", "21846", "=q4=Spellfire Belt", "=ds=#sr# 355", "=ds="..AL["Vendor"] };
				{ 12, "s26784", "21868", "=q3=Arcanoweave Robe", "=ds=#sr# 370", "=ds="..AL["Drop"] };
				{ 13, "s37884", "30839", "=q3=Flameheart Vest", "=ds=#sr# 370", "=ds="..ALIL["The Aldor"].." - "..AL["Exalted"]};
				{ 14, "s26783", "21867", "=q3=Arcanoweave Boots", "=ds=#sr# 360", "=ds="..AL["Drop"] };
				{ 15, "s37883", "30838", "=q3=Flameheart Gloves", "=ds=#sr# 360", "=ds="..ALIL["The Aldor"].." - "..AL["Honored"]};
				{ 16, "s26777", "21861", "=q3=Imbued Netherweave Robe", "=ds=#sr# 360", "=ds="..AL["Vendor"] };
				{ 17, "s26778", "21862", "=q3=Imbued Netherweave Tunic", "=ds=#sr# 360", "=ds="..AL["Vendor"] };
				{ 18, "s26782", "21866", "=q3=Arcanoweave Bracers", "=ds=#sr# 350", "=ds="..AL["Drop"] };
				{ 19, "s31437", "24251", "=q3=Blackstrike Bracers", "=ds=#sr# 350", "=ds="..AL["Drop"] };
				{ 20, "s31435", "24250", "=q3=Bracers of Havok", "=ds=#sr# 350", "=ds="..AL["Drop"] };
				{ 21, "s37873", "30831", "=q3=Cloak of Arcane Evasion", "=ds=#sr# 350", "=ds="..ALIL["Lower City"].." - "..AL["Honored"]};
				{ 22, "s31440", "24253", "=q3=Cloak of Eternity", "=ds=#sr# 350", "=ds="..AL["Drop"] };
				{ 23, "s31438", "24252", "=q3=Cloak of the Black Void", "=ds=#sr# 350", "=ds="..AL["Drop"] };
				{ 24, "s37882", "30837", "=q3=Flameheart Bracers", "=ds=#sr# 350", "=ds="..ALIL["The Aldor"].." - "..AL["Friendly"]};
				{ 25, "s26776", "21860", "=q3=Imbued Netherweave Boots", "=ds=#sr# 350", "=ds="..AL["Vendor"]..": "..ALIL["Zangarmarsh"]};
				{ 26, "s31434", "24249", "=q3=Unyielding Bracers", "=ds=#sr# 350", "=ds="..AL["Drop"] };
				{ 27, "s31441", "24254", "=q3=White Remedy Cape", "=ds=#sr# 350", "=ds="..AL["Drop"] };
				{ 28, "s26775", "21859", "=q3=Imbued Netherweave Pants", "=ds=#sr# 340", "=ds="..AL["Vendor"]..": "..ALIL["Zangarmarsh"]};
				{ 29, "s26774", "21855", "=q2=Netherweave Tunic", "=ds=#sr# 345", "=ds="..AL["Vendor"] };
				{ 30, "s26773", "21854", "=q2=Netherweave Robe", "=ds=#sr# 340", "=ds="..AL["Vendor"] };
			};
			{
				{ 1, "s26772", "21853", "=q2=Netherweave Boots", "=ds=#sr# 335", "=ds="..AL["Trainer"] };
				{ 2, "s26771", "21852", "=q2=Netherweave Pants", "=ds=#sr# 325", "=ds="..AL["Trainer"] };
				{ 3, "s26770", "21851", "=q2=Netherweave Gloves", "=ds=#sr# 320", "=ds="..AL["Trainer"] };
				{ 4, "s26765", "21850", "=q2=Netherweave Belt", "=ds=#sr# 310", "=ds="..AL["Trainer"] };
				{ 5, "s26764", "21849", "=q2=Netherweave Bracers", "=ds=#sr# 310", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = TAILORING..": "..BabbleInventory["Armor"].." - "..AL["Burning Crusade"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringArmorWotLK"] = {
		["Normal"] = {
			{
				{ 1, "s70551", "49890", "=q4=Deathfrost Boots", "=ds=#sr# 450", "=ds="..AL["Vendor"]..""};
				{ 2, "s70550", "49891", "=q4=Leggings of Woven Death", "=ds=#sr# 450", "=ds="..AL["Vendor"]..""};
				{ 3, "s70552", "49892", "=q4=Lightweave Leggings", "=ds=#sr# 450", "=ds="..AL["Vendor"]..""};
				{ 4, "s70553", "49893", "=q4=Sandals of Consecration", "=ds=#sr# 450", "=ds="..AL["Vendor"]..""};
				{ 5, "s67066", "47603", "=q4=Merlin's Robe", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 6, "s67146", "47604", "=q4=Merlin's Robe", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 7, "s67064", "47605", "=q4=Royal Moonshroud Robe", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 8, "s67144", "47606", "=q4=Royal Moonshroud Robe", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 9, "s67145", "47586", "=q4=Bejeweled Wizard's Bracers", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 10, "s67079", "47585", "=q4=Bejeweled Wizard's Bracers", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 11, "s67065", "47587", "=q4=Royal Moonshroud Bracers", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 12, "s67147", "47588", "=q4=Royal Moonshroud Bracers", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Trial of the Crusader"]};
				{ 13, "s63205", "45558", "=q4=Cord of the White Dawn", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 14, "s63203", "45557", "=q4=Sash of Ancient Power", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 15, "s63206", "45567", "=q4=Savior's Slippers", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 16, "s63204", "45566", "=q4=Spellslinger's Slippers", "=ds=#sr# 450", "=ds="..AL["Drop"]..": "..ALIL["Ulduar"]};
				{ 17, "s56017", "41610", "=q4=Deathchill Cloak", "=ds=#sr# 420", "=ds="..AL["Achievement"] };
				{ 18, "s56016", "41609", "=q4=Wispcloak", "=ds=#sr# 415", "=ds="..AL["Achievement"] };
				{ 19, "s56026", "42101", "=q4=Ebonweave Robe", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 20, "s56024", "42100", "=q4=Moonshroud Robe", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 21, "s56028", "42102", "=q4=Spellweave Robe", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 22, "s56027", "42111", "=q4=Ebonweave Gloves", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 23, "s56025", "42103", "=q4=Moonshroud Gloves", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 24, "s56029", "42113", "=q4=Spellweave Gloves", "=ds=#sr# 440", "=ds="..AL["Trainer"] };
				{ 25, "s60993", "43583", "=q4=Glacial Robe", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 26, "s60994", "43585", "=q4=Glacial Slippers", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 27, "s60990", "43584", "=q4=Glacial Waistband", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 28, "s56021", "42093", "=q3=Frostmoon Pants", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 29, "s56018", "41984", "=q3=Hat of Wintry Doom", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 30, "s56023", "42096", "=q3=Aurora Slippers", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s56020", "41986", "=q3=Deep Frozen Cord", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 2, "s59585", "43970", "=q3=Frostsavage Boots", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 3, "s59589", "43971", "=q3=Frostsavage Cowl", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 4, "s59586", "41516", "=q3=Frostsavage Gloves", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 5, "s59588", "43975", "=q3=Frostsavage Leggings", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 6, "s59587", "43972", "=q3=Frostsavage Robe", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 7, "s59584", "43973", "=q3=Frostsavage Shoulders", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 8, "s56022", "42095", "=q3=Light Blessed Mittens", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 9, "s56019", "41985", "=q3=Silky Iceshard Boots", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 10, "s55941", "41554", "=q3=Black Duskweave Robe", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 11, "s55925", "41553", "=q3=Black Duskweave Leggings", "=ds=#sr# 415", "=ds="..AL["Trainer"] };
				{ 12, "s55943", "41555", "=q3=Black Duskweave Wristwraps", "=ds=#sr# 415", "=ds="..AL["Trainer"] };
				{ 13, "s64730", "45810", "=q3=Cloak of Crimson Snow", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 14, "s64729", "45811", "=q3=Frostguard Drape", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 15, "s59582", "43969", "=q3=Frostsavage Belt", "=ds=#sr# 415", "=ds="..AL["Trainer"] };
				{ 16, "s59583", "43974", "=q3=Frostsavage Bracers", "=ds=#sr# 415", "=ds="..AL["Trainer"] };
				{ 17, "s56015", "41608", "=q3=Cloak of Frozen Spirits", "=ds=#sr# 395", "=ds="..AL["Trainer"] };
				{ 18, "s56014", "41607", "=q3=Cloak of the Moon", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
				{ 19, "s55911", "41525", "=q3=Mystic Frostwoven Robe", "=ds=#sr# 390", "=ds="..AL["Trainer"] };
				{ 20, "s55910", "41523", "=q3=Mystic Frostwoven Shoulders", "=ds=#sr# 385", "=ds="..AL["Trainer"] };
				{ 21, "s55913", "41528", "=q3=Mystic Frostwoven Wriststraps", "=ds=#sr# 385", "=ds="..AL["Trainer"] };
				{ 22, "s55923", "41550", "=q2=Duskweave Shoulders", "=ds=#sr# 410", "=ds="..AL["Trainer"] };
				{ 23, "s55924", "41544", "=q2=Duskweave Boots", "=ds=#sr# 410", "=ds="..AL["Trainer"] };
				{ 24, "s55921", "41549", "=q2=Duskweave Robe", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 25, "s55922", "41545", "=q2=Duskweave Gloves", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 26, "s55920", "41551", "=q2=Duskweave Wriststraps", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 27, "s55914", "41543", "=q2=Duskweave Belt", "=ds=#sr# 395", "=ds="..AL["Trainer"] };
				{ 28, "s55919", "41546", "=q2=Duskweave Cowl", "=ds=#sr# 395", "=ds="..AL["Trainer"] };
				{ 29, "s55901", "41548", "=q2=Duskweave Leggings", "=ds=#sr# 395", "=ds="..AL["Trainer"] };
				{ 30, "s55907", "41521", "=q2=Frostwoven Cowl", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s56030", "41519", "=q2=Frostwoven Leggings", "=ds=#sr# 380", "=ds="..AL["Trainer"] };
				{ 2, "s55906", "41520", "=q2=Frostwoven Boots", "=ds=#sr# 375", "=ds="..AL["Trainer"] };
				{ 3, "s55908", "41522", "=q2=Frostwoven Belt", "=ds=#sr# 370", "=ds="..AL["Trainer"] };
				{ 4, "s55904", "44211", "=q2=Frostwoven Gloves", "=ds=#sr# 360", "=ds="..AL["Trainer"] };
				{ 5, "s55903", "41515", "=q2=Frostwoven Robe", "=ds=#sr# 360", "=ds="..AL["Trainer"] };
				{ 6, "s55902", "41513", "=q2=Frostwoven Shoulders", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 7, "s56031", "41512", "=q2=Frostwoven Wriststraps", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = TAILORING..": "..BabbleInventory["Armor"].." - "..AL["Wrath of the Lich King"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringArmorCata"] = {
		["Normal"] = {
			{
				{ 1, "s101923", "71989", "=q4=Bracers of Unconquered Power", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 2, "s101922", "71990", "=q4=Dreamwraps of the Light", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 3, "s101921", "71980", "=q4=Lavaquake Legwraps", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 4, "s101920", "71981", "=q4=World Mender's Pants", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Dragon Soul"]};
				{ 5, "s99449", "69945", "=q4=Don Tayo's Inferno Mittens", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 6, "s99448", "69944", "=q4=Grips of Altered Reality", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 7, "s99460", "69954", "=q4=Boots of the Black Flame", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 8, "s99459", "69953", "=q4=Endless Dream Walkers", "=ds=#sr# 525", "=ds="..AL["Drop"]..": "..ALIL["Firelands"]};
				{ 9, "s75301", "54506", "=q4=Flame-Ascended Pantaloons", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 10, "s75298", "54504", "=q4=Belt of the Depths", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 11, "s75300", "54505", "=q4=Breeches of Mended Nightmares", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 12, "s75299", "54503", "=q4=Dreamless Belt", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 13, "s75307", "75072", "=q3=Vicious Embersilk Pants", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 14, "s75306", "75073", "=q3=Vicious Embersilk Cowl", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 15, "s75305", "75093", "=q3=Vicious Embersilk Robe", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 16, "s75304", "75062", "=q3=Vicious Fireweave Cowl", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 17, "s75303", "75088", "=q3=Vicious Fireweave Robe", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 18, "s75302", "75082", "=q3=Vicious Fireweave Pants", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 19, "s75297", "75095", "=q3=Vicious Embersilk Boots", "=ds=#sr# 520", "=ds="..AL["Trainer"] };
				{ 20, "s75296", "75063", "=q3=Vicious Fireweave Gloves", "=ds=#sr# 520", "=ds="..AL["Trainer"] };
				{ 21, "s134585", "92726", "=q3=Bipsi's Gloves", "=ds=#sr# 515", "=ds="..AL["Trainer"] };
				{ 22, "s75294", "75087", "=q3=Vicious Fireweave Boots", "=ds=#sr# 515", "=ds="..AL["Trainer"] };
				{ 23, "s75295", "75070", "=q3=Vicious Embersilk Gloves", "=ds=#sr# 515", "=ds="..AL["Trainer"] }; 
				{ 24, "s75292", "75091", "=q3=Vicious Fireweave Shoulders", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 25, "s75269", "75086", "=q3=Vicious Fireweave Belt", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 26, "s75293", "75096", "=q3=Vicious Embersilk Belt", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 27, "s75291", "75064", "=q3=Vicious Embersilk Shoulders", "=ds=#sr# 505", "=ds="..AL["Trainer"] };
				{ 28, "s75270", "75098", "=q3=Vicious Embersilk Bracers", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 29, "s75290", "75089", "=q3=Vicious Fireweave Bracers", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 30, "s99537", "75065", "=q3=Vicious Embersilk Cape", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s75266", "54485", "=q3=Spiritmend Cowl", "=ds=#sr# 485", "=ds="..AL["Trainer"] };
				{ 2, "s75267", "54486", "=q2=Spiritmend Robe", "=ds=#sr# 485", "=ds="..AL["Trainer"] };
				{ 3, "s75263", "54483", "=q2=Spiritmend Leggings", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 4, "s75262", "54484", "=q2=Spiritmend Gloves", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 5, "s75261", "54482", "=q2=Spiritmend Boots", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 6, "s75260", "54479", "=q3=Spiritmend Shoulders", "=ds=#sr# 475", "=ds="..AL["Trainer"] };
				{ 7, "s75259", "54480", "=q2=Spiritmend Bracers", "=ds=#sr# 470", "=ds="..AL["Trainer"] };
				{ 8, "s75258", "54481", "=q2=Spiritmend Belt", "=ds=#sr# 470", "=ds="..AL["Trainer"] };
				{ 9, "s75256", "54476", "=q2=Deathsilk Cowl", "=ds=#sr# 465", "=ds="..AL["Trainer"] };
				{ 10, "s75257", "54475", "=q3=Deathsilk Robe", "=ds=#sr# 465", "=ds="..AL["Trainer"] };
				{ 11, "s75253", "54478", "=q3=Deathsilk Gloves", "=ds=#sr# 460", "=ds="..AL["Trainer"] };
				{ 12, "s75254", "54472", "=q2=Deathsilk Leggings", "=ds=#sr# 460", "=ds="..AL["Trainer"] };
				{ 13, "s75251", "54474", "=q2=Deathsilk Shoulders", "=ds=#sr# 455", "=ds="..AL["Trainer"] };
				{ 14, "s75252", "54477", "=q2=Deathsilk Boots", "=ds=#sr# 445", "=ds="..AL["Trainer"] };
				{ 15, "s75249", "54473", "=q2=Deathsilk Bracers", "=ds=#sr# 445", "=ds="..AL["Trainer"] };
				{ 16, "s75248", "54471", "=q2=Deathsilk Belt", "=ds=#sr# 445", "=ds="..AL["Trainer"] };
				{ 17, "s75288", "54441", "=q1=Black Embersilk Gown", "=ds=#sr# 500", "=ds="..AL["Vendor"]};
			};
		};
		info = {
			name = TAILORING..": " ..BabbleInventory["Armor"].." - "..AL["Cataclysm"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringArmorMoP"] = {
		["Normal"] = {
			{
				{ 1, "s142964", "98612", "=q4=Belt of the Night Sky", "=ds=#s10#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 2, "s142960", "98608", "=q4=White Cloud Belt", "=ds=#s10#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 3, "s142955", "98603", "=q4=Leggings of the Night Sky", "=ds=#s11#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 4, "s142951", "98599", "=q4=White Cloud Leggings", "=ds=#s11#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 5, "s125560", "86312", "=q4=Legacy of the Emperor", "=ds=#s5#, #a1# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 6, "s125558", "86311", "=q4=Robe of Eternal Rule", "=ds=#s5#, #a1# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 7, "s125559", "86313", "=q4=Imperial Silk Gloves", "=ds=#s9#, #a1# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 8, "s125561", "86314", "=q4=Touch of the Light", "=ds=#s9#, #a1# / =q1=#sk# 600", "=ds="..AL["Drop"]..": "..string.format(AL["Tier %d"], 14).." "..AL["Raid"]};
				{ 9, "s125549", "82439", "=q4=Robes of Creation", "=ds=#s5#, #a1# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 10, "s125547", "82437", "=q4=Spelltwister's Grand Robe", "=ds=#s5#, #a1# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 11, "s125550", "82440", "=q4=Gloves of Creation", "=ds=#s9#, #a1# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 12, "s125548", "82438", "=q4=Spelltwister's Gloves", "=ds=#s9#, #a1# / =q1=#sk# 600", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"]};
				{ 13, "s143068", "98826", "=q3=Crafted Malevolent Gladiator's Silk Cowl", "=ds=#s1#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 14, "s143071", "98829", "=q3=Crafted Malevolent Gladiator's Silk Amice", "=ds=#s3#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 15, "s143070", "98828", "=q3=Crafted Malevolent Gladiator's Silk Robe", "=ds=#s5#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 16, "s143067", "98825", "=q3=Crafted Malevolent Gladiator's Silk Handguards", "=ds=#s9#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 17, "s143069", "98827", "=q3=Crafted Malevolent Gladiator's Silk Trousers", "=ds=#s11#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 18, "s143078", "98871", "=q3=Crafted Malevolent Gladiator's Satin Hood", "=ds=#s1#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 19, "s143081", "98874", "=q3=Crafted Malevolent Gladiator's Satin Mantle", "=ds=#s3#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 20, "s143080", "98873", "=q3=Crafted Malevolent Gladiator's Satin Robe", "=ds=#s5#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 21, "s143077", "98870", "=q3=Crafted Malevolent Gladiator's Satin Gloves", "=ds=#s9#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 22, "s143079", "98872", "=q3=Crafted Malevolent Gladiator's Satin Leggings", "=ds=#s11#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 23, "s143073", "98866", "=q3=Crafted Malevolent Gladiator's Mooncloth Helm", "=ds=#s1#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 24, "s143076", "98869", "=q3=Crafted Malevolent Gladiator's Mooncloth Mantle", "=ds=#s3#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 25, "s143075", "98868", "=q3=Crafted Malevolent Gladiator's Mooncloth Robe", "=ds=#s5#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 26, "s143072", "98865", "=q3=Crafted Malevolent Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 27, "s143074", "98867", "=q3=Crafted Malevolent Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 28, "s143085", "98922", "=q3=Crafted Malevolent Gladiator's Felweave Cowl", "=ds=#s1#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 29, "s143088", "98925", "=q3=Crafted Malevolent Gladiator's Felweave Amice", "=ds=#s3#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 30, "s143087", "98924", "=q3=Crafted Malevolent Gladiator's Felweave Raiment", "=ds=#s5#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
			};
			{
				{ 1, "s143084", "98921", "=q3=Crafted Malevolent Gladiator's Felweave Handguards", "=ds=#s9#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 2, "s143086", "98923", "=q3=Crafted Malevolent Gladiator's Felweave Trousers", "=ds=#s11#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 3, "s143053", "98756", "=q3=Crafted Malevolent Gladiator's Cape of Cruelty", "=ds=#s4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 4, "s143054", "98757", "=q3=Crafted Malevolent Gladiator's Cape of Prowess", "=ds=#s4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 5, "s143082", "98913", "=q3=Crafted Malevolent Gladiator's Cloak of Alacrity", "=ds=#s4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 6, "s143083", "98914", "=q3=Crafted Malevolent Gladiator's Cloak of Prowess", "=ds=#s4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 7, "s143064", "98772", "=q3=Crafted Malevolent Gladiator's Drape of Cruelty", "=ds=#s4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 8, "s143066", "98774", "=q3=Crafted Malevolent Gladiator's Drape of Meditation", "=ds=#s4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 9, "s143065", "98773", "=q3=Crafted Malevolent Gladiator's Drape of Prowess", "=ds=#s4# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 10, "s143061", "98769", "=q3=Crafted Malevolent Gladiator's Cuffs of Accuracy", "=ds=#s8#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 11, "s143063", "98771", "=q3=Crafted Malevolent Gladiator's Cuffs of Meditation", "=ds=#s8#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 12, "s143062", "98770", "=q3=Crafted Malevolent Gladiator's Cuffs of Prowess", "=ds=#s8#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 13, "s143056", "98764", "=q3=Crafted Malevolent Gladiator's Cord of Accuracy", "=ds=#s10#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 14, "s143055", "98763", "=q3=Crafted Malevolent Gladiator's Cord of Cruelty", "=ds=#s10#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 15, "s143057", "98765", "=q3=Crafted Malevolent Gladiator's Cord of Meditation", "=ds=#s10#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 16, "s143059", "98767", "=q3=Crafted Malevolent Gladiator's Treads of Alacrity", "=ds=#s12#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 17, "s143058", "98766", "=q3=Crafted Malevolent Gladiator's Treads of Cruelty", "=ds=#s12#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 18, "s143060", "98768", "=q3=Crafted Malevolent Gladiator's Treads of Meditation", "=ds=#s12#, #a1# / =q1=#sk# 600", "=ds="..AL["Discovery"]..": "..GetSpellInfo(143011)};
				{ 19, "s125539", "82429", "=q3=Contender's Satin Cowl", "=ds=#s1#, #a1# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 20, "s125541", "82431", "=q3=Contender's Satin Raiment", "=ds=#s5#, #a1# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 21, "s125531", "82421", "=q3=Contender's Silk Cowl", "=ds=#s1#, #a1# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 22, "s125533", "82423", "=q3=Contender's Silk Raiment", "=ds=#s5#, #a1# / =q1=#sk# 590", "=ds="..AL["Vendor"]};
				{ 23, "s125540", "82430", "=q3=Contender's Satin Amice", "=ds=#s3#, #a1# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 24, "s125532", "82422", "=q3=Contender's Silk Amice", "=ds=#s3#, #a1# / =q1=#sk# 575", "=ds="..AL["Vendor"]};
				{ 25, "s125542", "82432", "=q3=Contender's Satin Handwraps", "=ds=#s9#, #a1# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 26, "s125546", "82436", "=q3=Contender's Satin Belt", "=ds=#s10#, #a1# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 27, "s125543", "82433", "=q3=Contender's Satin Pants", "=ds=#s11#, #a1# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 28, "s125545", "82435", "=q3=Contender's Satin Footwraps", "=ds=#s12#, #a1# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 29, "s125534", "82424", "=q3=Contender's Silk Handwraps", "=ds=#s9#, #a1# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 30, "s125538", "82428", "=q3=Contender's Silk Belt", "=ds=#s10#, #a1# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
			};
			{
				{ 1, "s125535", "82425", "=q3=Contender's Silk Pants", "=ds=#s11#, #a1# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 2, "s125537", "82427", "=q3=Contender's Silk Footwraps", "=ds=#s12#, #a1# / =q1=#sk# 565", "=ds="..AL["Vendor"]};
				{ 3, "s125544", "82434", "=q3=Contender's Satin Cuffs", "=ds=#s8#, #a1# / =q1=#sk# 555", "=ds="..AL["Vendor"]};
				{ 4, "s125536", "82426", "=q3=Contender's Silk Cuffs", "=ds=#s8#, #a1# / =q1=#sk# 555", "=ds="..AL["Vendor"]};
				{ 5, "s125523", "82397", "=q2=Windwool Hood", "=ds=#s1#, #a1# / =q1=#sk# 555", "=ds="..AL["Trainer"]};
				{ 6, "s125525", "82399", "=q2=Windwool Tunic", "=ds=#s5#, #a1# / =q1=#sk# 555", "=ds="..AL["Trainer"]};
				{ 7, "s138598", "94278", "=q4=Falling Blossom Cowl", "=ds=#s1#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 8, "s138600", "94280", "=q4=Falling Blossom Hood", "=ds=#s1#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 9, "s138599", "94279", "=q4=Falling Blossom Sandals", "=ds=#s12#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 10, "s138597", "94277", "=q4=Falling Blossom Treads", "=ds=#s12#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 11, "s137922", "93500", "=q3=Crafted Dreadful Gladiator's Silk Cowl", "=ds=#s1#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 12, "s137925", "93503", "=q3=Crafted Dreadful Gladiator's Silk Amice", "=ds=#s3#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 13, "s137924", "93502", "=q3=Crafted Dreadful Gladiator's Silk Robe", "=ds=#s5#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 14, "s137921", "93499", "=q3=Crafted Dreadful Gladiator's Silk Handguards", "=ds=#s9#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 15, "s137923", "93501", "=q3=Crafted Dreadful Gladiator's Silk Trousers", "=ds=#s11#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 16, "s137932", "93556", "=q3=Crafted Dreadful Gladiator's Satin Hood", "=ds=#s1#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 17, "s137935", "93559", "=q3=Crafted Dreadful Gladiator's Satin Mantle", "=ds=#s3#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 18, "s137934", "93558", "=q3=Crafted Dreadful Gladiator's Satin Robe", "=ds=#s5#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 19, "s137931", "93555", "=q3=Crafted Dreadful Gladiator's Satin Gloves", "=ds=#s9#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 20, "s137933", "93557", "=q3=Crafted Dreadful Gladiator's Satin Leggings", "=ds=#s11#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 21, "s137927", "93551", "=q3=Crafted Dreadful Gladiator's Mooncloth Helm", "=ds=#s1#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 22, "s137930", "93554", "=q3=Crafted Dreadful Gladiator's Mooncloth Mantle", "=ds=#s3#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 23, "s137929", "93553", "=q3=Crafted Dreadful Gladiator's Mooncloth Robe", "=ds=#s5#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 24, "s137926", "93555", "=q3=Crafted Dreadful Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 25, "s137928", "93552", "=q3=Crafted Dreadful Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 26, "s137939", "93616", "=q3=Crafted Dreadful Gladiator's Felweave Cowl", "=ds=#s1#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 27, "s137942", "93619", "=q3=Crafted Dreadful Gladiator's Felweave Amice", "=ds=#s3#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 28, "s137941", "93618", "=q3=Crafted Dreadful Gladiator's Felweave Raiment", "=ds=#s5#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 29, "s137938", "93615", "=q3=Crafted Dreadful Gladiator's Felweave Handguards", "=ds=#s9#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 30, "s137940", "93617", "=q3=Crafted Dreadful Gladiator's Felweave Trousers", "=ds=#s11#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
			};
			{
				{ 1, "s137907", "93420", "=q3=Crafted Dreadful Gladiator's Cape of Cruelty", "=ds=#s4# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 2, "s137908", "93421", "=q3=Crafted Dreadful Gladiator's Cape of Prowess", "=ds=#s4# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 3, "s137936", "93607", "=q3=Crafted Dreadful Gladiator's Cloak of Alacrity", "=ds=#s4# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 4, "s137937", "93608", "=q3=Crafted Dreadful Gladiator's Cloak of Prowess", "=ds=#s4# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 5, "s137918", "93437", "=q3=Crafted Dreadful Gladiator's Drape of Cruelty", "=ds=#s4# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 6, "s137920", "93439", "=q3=Crafted Dreadful Gladiator's Drape of Meditation", "=ds=#s4# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 7, "s137919", "93438", "=q3=Crafted Dreadful Gladiator's Drape of Prowess", "=ds=#s4# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 8, "s137915", "93434", "=q3=Crafted Dreadful Gladiator's Cuffs of Accuracy", "=ds=#s8#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 9, "s137917", "93436", "=q3=Crafted Dreadful Gladiator's Cuffs of Meditation", "=ds=#s8#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 10, "s137916", "93435", "=q3=Crafted Dreadful Gladiator's Cuffs of Prowess", "=ds=#s8#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 11, "s137910", "93429", "=q3=Crafted Dreadful Gladiator's Cord of Accuracy", "=ds=#s10#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 12, "s137909", "93428", "=q3=Crafted Dreadful Gladiator's Cord of Cruelty", "=ds=#s10#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 13, "s137911", "93430", "=q3=Crafted Dreadful Gladiator's Cord of Meditation", "=ds=#s10#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 14, "s137913", "93432", "=q3=Crafted Dreadful Gladiator's Treads of Alacrity", "=ds=#s12#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 15, "s137912", "93431", "=q3=Crafted Dreadful Gladiator's Treads of Cruelty", "=ds=#s12#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 16, "s137914", "93433", "=q3=Crafted Dreadful Gladiator's Treads of Meditation", "=ds=#s12#, #a1# / =q1=#sk# 550", "=ds="..AL["Discovery"]..": "..GetSpellInfo(125557)};
				{ 17, "s125527", "82401", "=q2=Windwool Pants", "=ds=#s11#, #a1# / =q1=#sk# 545", "=ds="..AL["Trainer"]};
				{ 18, "s125529", "82403", "=q2=Windwool Boots", "=ds=#s12#, #a1# / =q1=#sk# 545", "=ds="..AL["Trainer"]};
				{ 19, "s125524", "82398", "=q2=Windwool Shoulders", "=ds=#s3#, #a1# / =q1=#sk# 535", "=ds="..AL["Trainer"]};
				{ 20, "s125530", "82404", "=q2=Windwool Belt", "=ds=#s10#, #a1# / =q1=#sk# 535", "=ds="..AL["Trainer"]};
				{ 21, "s125528", "82402", "=q2=Windwool Bracers", "=ds=#s8#, #a1# / =q1=#sk# 525", "=ds="..AL["Trainer"]};
				{ 22, "s125526", "82400", "=q2=Windwool Gloves", "=ds=#s9#, #a1# / =q1=#sk# 525", "=ds="..AL["Trainer"]};
			};
		};
		info = {
			name = TAILORING..": " ..BabbleInventory["Armor"].." - "..AL["Mists of Pandaria"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringBags"] = {
		["Normal"] = {
			{
				{ 1, "s125556", "82446", "=q4=Royal Satchel", "=ds=#sr# 600", "=ds="..ALIL["The August Celestials"].." - "..AL["Exalted"] };
				{ 2, "s75308", "54444", "=q3=Illusionary Bag", "=ds=#sr# 525", "=ds="..AL["Vendor"]};
				{ 3, "s100585", "70138", "=q3=Luxurious Silk Gem Bag", "=ds=#sr# 515", "=ds="..ALIL["Molten Front"]};
				{ 4, "s75268", "54446", "=q2=Hyjal Expedition Bag", "=ds=#sr# 490", "=ds="..AL["Trainer"] };
				{ 5, "s75264", "54443", "=q2=Embersilk Bag", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 6, "s75265", "54445", "=q3=Otherworldly Bag", "=ds=#sr# 480", "=ds="..AL["Trainer"] };
				{ 7, "s56007", "41599", "=q2=Frostweave Bag", "=ds=#sr# 410", "=ds="..AL["Trainer"] };
				{ 8, "s56005", "41600", "=q3=Glacial Bag", "=ds=#sr# 445", "=ds="..ALIL["The Sons of Hodir"].." - "..AL["Exalted"] };
				{ 9, "s56006", "41598", "=q3=Mysterious Bag", "=ds=#sr# 440", "=ds="..ALIL["The Wyrmrest Accord"].." - "..AL["Revered"] };
				{ 10, "s56004", "41597", "=q3=Abyssal Bag", "=ds=#sr# 435", "=ds="..ALIL["Knights of the Ebon Blade"].." - "..AL["Revered"] };
				{ 11, "s63924", "45773", "=q3=Emerald Bag", "=ds=#sr# 435", "=ds="..ALIL["The Kalu'ak"].." - "..AL["Revered"] };
				{ 12, "s26759", "21872", "=q3=Ebon Shadowbag",  "=ds=#sr# 375", "=ds="..AL["Vendor"] };
				{ 13, "s50194", "38225", "=q3=Mycah's Botanical Bag", "=ds=#sr# 375", "=ds="..ALIL["Sporeggar"].." - "..AL["Revered"] };
				{ 14, "s26763", "21876", "=q3=Primal Mooncloth Bag", "=ds=#sr# 375", "=ds="..AL["Vendor"] };
				{ 15, "s26755", "21858", "=q3=Spellfire Bag", "=ds=#sr# 375", "=ds="..AL["Vendor"] };
				{ 16, "s31459", "24270", "=q2=Bag of Jewels", "=ds=#sr# 340", "=ds="..AL["Vendor"] };
				{ 17, "s26749", "21843", "=q2=Imbued Netherweave Bag", "=ds=#sr# 340", "=ds="..AL["Vendor"] };
				{ 18, "s26746", "21841", "=q2=Netherweave Bag", "=ds=#sr# 315", "=ds="..AL["Trainer"] };
				{ 19, "s26087", "21342", "=q4=Core Felcloth Bag", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Molten Core"] };
				{ 20, "s18455", "14156", "=q3=Bottomless Bag", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 21, "s27660", "22249", "=q2=Big Bag of Enchantment", "=ds=#sr# 300", "=ds="..AL["Drop"]..": "..ALIL["Dire Maul"] };
				{ 22, "s18445", "14155", "=q2=Mooncloth Bag", "=ds=#sr# 300", "=ds="..AL["Drop"]};
				{ 23, "s27725", "22252", "=q2=Satchel of Cenarius", "=ds=#sr# 300", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Revered"] };
				{ 24, "s26086", "21341", "=q3=Felcloth Bag", "=ds=#sr# 280", "=ds="..AL["Drop"]..": "..ALIL["Scholomance"] };
				{ 25, "s27659", "22248", "=q2=Enchanted Runecloth Bag", "=ds=#sr# 275", "=ds="..AL["Vendor"]..": "..ALIL["Silithus"]};
				{ 26, "s27724", "22251", "=q2=Cenarion Herb Bag", "=ds=#sr# 275", "=ds="..ALIL["Cenarion Circle"].." - "..AL["Friendly"] };
				{ 27, "s26085", "21340", "=q2=Soul Pouch", "=ds=#sr# 260", "=ds="..AL["Vendor"]..": "..ALIL["Tanaris"]};
				{ 28, "s27658", "22246", "=q2=Enchanted Mageweave Pouch", "=ds=#sr# 225", "=ds="..AL["Vendor"]..""};
				{ 29, "s18405", "14046", "=q1=Runecloth Bag", "=ds=#sr# 260", "=ds="..AL["Vendor"]..": "..ALIL["Winterspring"]};
				{ 30, "s12079", "10051", "=q1=Red Mageweave Bag", "=ds=#sr# 235", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s12065", "10050", "=q1=Mageweave Bag", "=ds=#sr# 225", "=ds="..AL["Trainer"] };
				{ 2, "s6695", "5765", "=q1=Black Silk Pack", "=ds=#sr# 185", "=ds="..AL["Drop"]};
				{ 3, "s6693", "5764", "=q1=Green Silk Pack", "=ds=#sr# 175", "=ds="..AL["Drop"]};
				{ 4, "s3813", "4245", "=q1=Small Silk Pack", "=ds=#sr# 150", "=ds="..AL["Trainer"] };
				{ 5, "s6688", "5763", "=q1=Red Woolen Bag", "=ds=#sr# 115", "=ds="..AL["Vendor"] };
				{ 6, "s3758", "4241", "=q1=Green Woolen Bag", "=ds=#sr# 95", "=ds="..AL["Drop"]};
				{ 7, "s3757", "4240", "=q1=Woolen Bag", "=ds=#sr# 80", "=ds="..AL["Trainer"] };
				{ 8, "s6686", "5762", "=q1=Red Linen Bag", "=ds=#sr# 70", "=ds="..AL["Vendor"] };
				{ 9, "s3755", "4238", "=q1=Linen Bag", "=ds=#sr# 45", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = TAILORING..": "..AL["Bags"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringItemEnhancement"] = {
		["Normal"] = {
			{
				{ 1, "s125482", "INV_Misc_Thread_01", "=ds=Darkglow Embroidery - Rank 3", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 2, "s75175", "INV_Misc_Thread_01", "=ds=Darkglow Embroidery - Rank 2", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 3, "s55769", "INV_Misc_Thread_01", "=ds=Darkglow Embroidery - Rank 1", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 4, "s125481", "INV_Misc_Thread_01", "=ds=Lightweave Embroidery - Rank 3", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 5, "s75172", "INV_Misc_Thread_01", "=ds=Lightweave Embroidery - Rank 2", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 6, "s55642", "INV_Misc_Thread_01", "=ds=Lightweave Embroidery - Rank 1", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 7, "s125483", "INV_Misc_Thread_01", "=ds=Swordguard Embroidery - Rank 3", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 8, "s75178", "INV_Misc_Thread_01", "=ds=Swordguard Embroidery - Rank 2", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 9, "s55777", "INV_Misc_Thread_01", "=ds=Swordguard Embroidery - Rank 1", "=ds=#sr# 420", "=ds="..AL["Trainer"] };
				{ 10, "s125496", "Spell_Nature_AstralRecalGroup", "=ds=Master's Spellthread - Rank 3", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 11, "s75154", "Spell_Nature_AstralRecalGroup", "=ds=Master's Spellthread - Rank 2", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 12, "s56034", "Spell_Nature_AstralRecalGroup", "=ds=Master's Spellthread - Rank 1", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 13, "s125497", "Spell_Nature_AstralRecalGroup", "=ds=Sanctified Spellthread - Rank 3", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 14, "s75155", "Spell_Nature_AstralRecalGroup", "=ds=Sanctified Spellthread - Rank 2", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 15, "s56039", "Spell_Nature_AstralRecalGroup", "=ds=Sanctified Spellthread - Rank 1", "=ds=#sr# 405", "=ds="..AL["Trainer"] };
				{ 16, "s125555", "82445", "=q3=Greater Cerulean Spellthread", "=ds=#sr# 575", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"] };
				{ 17, "s125554", "82444", "=q3=Greater Pearlescent Spellthread", "=ds=#sr# 575", "=ds="..ALIL["Golden Lotus"].." - "..AL["Honored"] };
				{ 18, "s125553", "82443", "=q2=Cerulean Spellthread", "=ds=#sr# 540", "=ds="..AL["Trainer"] };
				{ 19, "s125552", "82442", "=q2=Pearlescent Spellthread", "=ds=#sr# 530", "=ds="..AL["Trainer"] };
				{ 21, "s75309", "54448", "=q4=Powerful Enchanted Spellthread", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 22, "s75310", "54450", "=q4=Powerful Ghostly Spellthread", "=ds=#sr# 525", "=ds="..AL["Vendor"] };
				{ 23, "s75255", "54449", "=q3=Ghostly Spellthread", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 24, "s75250", "54447", "=q3=Enchanted Spellthread", "=ds=#sr# 450", "=ds="..AL["Trainer"] };
				{ 25, "s56009", "41602", "=q4=Brilliant Spellthread", "=ds=#sr# 430", "=ds="..ALIL["Argent Crusade"].." - "..AL["Exalted"] };
				{ 26, "s56011", "41604", "=q4=Sapphire Spellthread", "=ds=#sr# 430", "=ds="..ALIL["Kirin Tor"].." - "..AL["Exalted"] };
				{ 27, "s56010", "41603", "=q3=Azure Spellthread", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 28, "s56008", "41601", "=q3=Shining Spellthread", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
			};
			{
				{ 1, "s31433", "24276", "=q4=Golden Spellthread", "=ds=#sr# 375", "=ds="..ALIL["The Aldor"].." - "..AL["Exalted"] };
				{ 2, "s31432", "24274", "=q4=Runic Spellthread", "=ds=#sr# 375", "=ds="..ALIL["The Scryers"].." - "..AL["Exalted"] };
				{ 3, "s31430", "24273", "=q3=Mystic Spellthread", "=ds=#sr# 335", "=ds="..ALIL["The Scryers"].." - "..AL["Honored"] };
				{ 4, "s31431", "24275", "=q3=Silver Spellthread", "=ds=#sr# 335", "=ds="..ALIL["The Aldor"].." - "..AL["Honored"] };
			};
		};
		info = {
			name = TAILORING..": "..AL["Item Enhancements"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringMisc"] = {
		["Normal"] = {
			{
				{ 1, "s75597", "54797", "=q4=Frosty Flying Carpet", "=ds=#sr# 425", "=ds="..AL["Vendor"]..": "..ALIL["Dalaran"] };
				{ 2, "s60971", "44558", "=q4=Magnificent Flying Carpet", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 3, "s60969", "44554", "=q3=Flying Carpet", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 5, "s75247", "54442", "=q1=Embersilk Net", "=ds=#sr# 425", "=ds="..AL["Trainer"], amount = 3 };
				{ 6, "s55898", "41509", "=q1=Frostweave Net", "=ds=#sr# 360", "=ds="..AL["Trainer"], amount = 5 };
				{ 7, "s31460", "24268", "=q1=Netherweave Net", "=ds=#sr# 300", "=ds="..AL["Trainer"], amount = 2 };
				{ 16, "s125557", "90900", "=q3=Imperial Moth", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 17, "s125557", "90902", "=q2=Imperial Silkworm", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = TAILORING..": "..BabbleInventory["Miscellaneous"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringCloth"] = {
		["Normal"] = {
			{
				{ 1, "s146925", "98619", "=q3=Accelerated Celestial Cloth", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 2, "s143011", "98619", "=q3=Celestial Cloth", "=ds=#sr# 600", "=ds="..AL["Drop"]..": "..ALIL["Pandaria"]};
				{ 3, "s130325", "82447", "=q3=Song of Harmony", "=ds=#sr# 560", "=ds="..AL["Trainer"] };
				{ 4, "s125557", "92960", "=q3=Imperial Silk", "=ds=#sr# 550", "=ds="..AL["Trainer"] };
				{ 5, "s94743", "54440", "=q3=Dream of Destruction", "=ds=#sr# 525", "=ds="..AL["Trainer"] };
				{ 6, "s75141", "54440", "=q3=Dream of Skywall", "=ds=#sr# 515", "=ds="..AL["Trainer"] };
				{ 7, "s75145", "54440", "=q3=Dream of Ragnaros", "=ds=#sr# 510", "=ds="..AL["Trainer"] };
				{ 8, "s75142", "54440", "=q3=Dream of Deepholm", "=ds=#sr# 505", "=ds="..AL["Trainer"] };
				{ 9, "s75144", "54440", "=q3=Dream of Hyjal", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 10, "s75146", "54440", "=q3=Dream of Azshara", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 11, "s56002", "41593", "=q3=Ebonweave", "=ds=#sr# 415", "=ds="..AL["Trainer"] };
				{ 12, "s56001", "41594", "=q3=Moonshroud", "=ds=#sr# 415", "=ds="..AL["Trainer"] };
				{ 13, "s56003", "41595", "=q3=Spellweave", "=ds=#sr# 415", "=ds="..AL["Trainer"] };
				{ 14, "s26751", "21845", "=q3=Primal Mooncloth", "=ds=#sr# 350", "=ds="..AL["Vendor"] };
				{ 15, "s36686", "24272", "=q3=Shadowcloth", "=ds=#sr# 350", "=ds="..AL["Vendor"] };
				{ 16, "s31373", "24271", "=q3=Spellcloth", "=ds=#sr# 350", "=ds="..AL["Vendor"] };
				{ 17, "s18560", "14342", "=q1=Mooncloth", "=ds=#sr# 250", "=ds="..AL["Vendor"]..": "..ALIL["Winterspring"]};
				{ 18, "s125551", "82441", "=q1=Bolt of Windwool Cloth", "=ds=#sr# 500", "=ds="..AL["Trainer"] };
				{ 19, "s74964", "53643", "=q1=Bolt of Embersilk Cloth", "=ds=#sr# 425", "=ds="..AL["Trainer"] };
				{ 20, "s55900", "41511", "=q2=Bolt of Imbued Frostweave", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 21, "s55899", "41510", "=q1=Bolt of Frostweave", "=ds=#sr# 350", "=ds="..AL["Trainer"] };
				{ 22, "s26750", "21844", "=q1=Bolt of Soulcloth", "=ds=#sr# 345", "=ds="..AL["Vendor"] };
				{ 23, "s26747", "21842", "=q2=Bolt of Imbued Netherweave", "=ds=#sr# 325", "=ds="..AL["Vendor"] };
				{ 24, "s26745", "21840", "=q1=Bolt of Netherweave", "=ds=#sr# 300", "=ds="..AL["Trainer"] };
				{ 25, "s18401", "14048", "=q1=Bolt of Runecloth", "=ds=#sr# 250", "=ds="..AL["Trainer"] };
				{ 26, "s3865", "4339", "=q1=Bolt of Mageweave", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 27, "s3839", "4305", "=q1=Bolt of Silk Cloth", "=ds=#sr# 125", "=ds="..AL["Trainer"] };
				{ 28, "s2964", "2997", "=q1=Bolt of Woolen Cloth", "=ds=#sr# 75", "=ds="..AL["Trainer"] };
				{ 29, "s2963", "2996", "=q1=Bolt of Linen Cloth", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = TAILORING..": "..BabbleInventory["Cloth"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringShirts"] = {
		["Normal"] = {
			{
				{ 1, "s55994", "41249", "=q1=Blue Lumberjack Shirt", "=ds=#sr# 400", "=ds="..AL["Drop"] };
				{ 2, "s55998", "41253", "=q1=Blue Workman's Shirt", "=ds=#sr# 400", "=ds="..AL["Drop"] };
				{ 3, "s55996", "41250", "=q1=Green Lumberjack Shirt", "=ds=#sr# 400", "=ds="..AL["Drop"] };
				{ 4, "s56000", "41255", "=q1=Green Workman's Shirt", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 5, "s55993", "41248", "=q1=Red Lumberjack Shirt", "=ds=#sr# 400", "=ds="..AL["Drop"] };
				{ 6, "s55997", "41252", "=q1=Red Workman's Shirt", "=ds=#sr# 400", "=ds="..AL["Drop"] };
				{ 7, "s55999", "41254", "=q1=Rustic Workman's Shirt", "=ds=#sr# 400", "=ds="..AL["Drop"] };
				{ 8, "s55995", "41251", "=q1=Yellow Lumberjack Shirt", "=ds=#sr# 400", "=ds="..AL["Trainer"] };
				{ 9, "s12085", "10034", "=q1=Tuxedo Shirt", "=ds=#sr# 240", "=ds="..AL["Vendor"] };
				{ 10, "s12080", "10055", "=q1=Pink Mageweave Shirt", "=ds=#sr# 235", "=ds="..AL["Vendor"] };
				{ 11, "s12075", "10054", "=q1=Lavender Mageweave Shirt", "=ds=#sr# 230", "=ds="..AL["Vendor"] };
				{ 12, "s12064", "10052", "=q1=Orange Martial Shirt", "=ds=#sr# 220", "=ds="..AL["Vendor"] };
				{ 13, "s12061", "10056", "=q1=Orange Mageweave Shirt", "=ds=#sr# 215", "=ds="..AL["Trainer"] };
				{ 14, "s3873", "4336", "=q1=Black Swashbuckler's Shirt", "=ds=#sr# 200", "=ds="..AL["Vendor"]..": "..ALIL["The Cape of Stranglethorn"] };
				{ 15, "s21945", "17723", "=q1=Green Holiday Shirt", "=ds=#sr# 190", "=ds=#QUESTID:6984#"};
				{ 16, "s3872", "4335", "=q1=Rich Purple Silk Shirt", "=ds=#sr# 185", "=ds="..AL["Drop"] };
				{ 17, "s8489", "6796", "=q1=Red Swashbuckler's Shirt", "=ds=#sr# 175", "=ds="..AL["Trainer"] };
				{ 18, "s3871", "4334", "=q1=Formal White Shirt", "=ds=#sr# 170", "=ds="..AL["Trainer"] };
				{ 19, "s8483", "6795", "=q1=White Swashbuckler's Shirt", "=ds=#sr# 160", "=ds="..AL["Trainer"] };
				{ 20, "s3870", "4333", "=q1=Dark Silk Shirt", "=ds=#sr# 155", "=ds="..AL["Vendor"] };
				{ 21, "s3869", "4332", "=q1=Bright Yellow Shirt", "=ds=#sr# 135", "=ds="..AL["Trainer"] };
				{ 22, "s7892", "6384", "=q1=Stylish Blue Shirt", "=ds=#sr# 120", "=ds="..AL["Drop"] };
				{ 23, "s7893", "6385", "=q1=Stylish Green Shirt", "=ds=#sr# 120", "=ds="..AL["Drop"] };
				{ 24, "s3866", "4330", "=q1=Stylish Red Shirt", "=ds=#sr# 110", "=ds="..AL["Trainer"] };
				{ 25, "s2406", "2587", "=q1=Gray Woolen Shirt", "=ds=#sr# 100", "=ds="..AL["Trainer"] };
				{ 26, "s2396", "2579", "=q1=Green Linen Shirt", "=ds=#sr# 70", "=ds="..AL["Trainer"] };
				{ 27, "s2394", "2577", "=q1=Blue Linen Shirt", "=ds=#sr# 40", "=ds="..AL["Trainer"] };
				{ 28, "s2392", "2575", "=q1=Red Linen Shirt", "=ds=#sr# 40", "=ds="..AL["Trainer"] };
				{ 29, "s2393", "2576", "=q1=White Linen Shirt", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
				{ 30, "s3915", "4344", "=q1=Brown Linen Shirt", "=ds=#sr# 1", "=ds="..AL["Trainer"] };
			};
		};
		info = {
			name = TAILORING..": "..AL["Shirts"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["Mooncloth"] = {
		["Normal"] = {
			{
				{ 1, "s26760", "21873", "=q4=Primal Mooncloth Belt", "=ds=#sr# 355", "=ds="..AL["Vendor"] };
				{ 2, "s26761", "21874", "=q4=Primal Mooncloth Shoulders", "=ds=#sr# 365", "=ds="..AL["Vendor"] };
				{ 3, "s26762", "21875", "=q4=Primal Mooncloth Robe", "=ds=#sr# 375", "=ds="..AL["Vendor"] };
			};
		};
		info = {
			name = MOONCLOTH,
			module = moduleName, menu = "TAILORINGMENU", instance = "Tailoring",
		};
	};

	AtlasLoot_Data["Shadoweave"] = {
		["Normal"] = {
			{
				{ 1, "s26756", "21869", "=q4=Frozen Shadoweave Shoulders", "=ds=#sr# 355", "=ds="..AL["Vendor"] };
				{ 2, "s26757", "21870", "=q4=Frozen Shadoweave Boots", "=ds=#sr# 365", "=ds="..AL["Vendor"] };
				{ 3, "s26758", "21871", "=q4=Frozen Shadoweave Robe", "=ds=#sr# 375", "=ds="..AL["Vendor"] };
			};
		};
		info = {
			name = SHADOWEAVE,
			module = moduleName, menu = "TAILORINGMENU", instance = "Tailoring",
		};
	};

	AtlasLoot_Data["Spellfire"] = {
		["Normal"] = {
			{
				{ 1, "s26752", "21846", "=q4=Spellfire Belt", "=ds=#sr# 355", "=ds="..AL["Vendor"] };
				{ 2, "s26753", "21847", "=q4=Spellfire Gloves", "=ds=#sr# 365", "=ds="..AL["Vendor"] };
				{ 3, "s26754", "21848", "=q4=Spellfire Robe", "=ds=#sr# 375", "=ds="..AL["Vendor"] };
			};
		};
		info = {
			name = SPELLFIRE,
			module = moduleName, menu = "TAILORINGMENU", instance = "Tailoring",
		};
	};

	AtlasLoot_Data["TailoringCataVendor"] = {
		["Normal"] = {
			{
				{ 1, 54601, "", "=q3=Pattern: Belt of the Depths", "=ds=#p8# (525)", "1 #dreamcloth#" };
				{ 2, 54604, "", "=q3=Pattern: Flame-Ascended Pantaloons", "=ds=#p8# (525)", "1 #dreamcloth#" };
				{ 4, 54603, "", "=q3=Pattern: Breeches of Mended Nightmares", "=ds=#p8# (525)", "1 #dreamcloth#" };
				{ 5, 54602, "", "=q3=Pattern: Dreamless Belt", "=ds=#p8# (525)", "1 #dreamcloth#" };
				{ 7, 54599, "", "=q3=Pattern: Powerful Enchanted Spellthread", "=ds=#p8# (525)", "8 #embersilkbolt#" };
				{ 8, 54600, "", "=q3=Pattern: Powerful Ghostly Spellthread", "=ds=#p8# (525)", "8 #embersilkbolt#" };
				{ 10, 68199, "", "=q3=Pattern: Black Embersilk Gown", "=ds=#p8# (500)", "8 #embersilkbolt#" };
				{ 11, 54605, "", "=q3=Pattern: Illusionary Bag", "=ds=#p8# (525)", "1 #dreamcloth#" };
				{ 16, 54593, "", "=q3=Pattern: Vicious Embersilk Cowl", "=ds=#p8# (525)", "8 #embersilkbolt#" };
				{ 17, 54595, "", "=q3=Pattern: Vicious Embersilk Robe", "=ds=#p8# (525)", "8 #embersilkbolt#" };
				{ 18, 54594, "", "=q3=Pattern: Vicious Embersilk Pants", "=ds=#p8# (525)", "8 #embersilkbolt#" };
				{ 20, 54596, "", "=q3=Pattern: Vicious Fireweave Cowl", "=ds=#p8# (525)", "8 #embersilkbolt#" };
				{ 21, 54598, "", "=q3=Pattern: Vicious Fireweave Robe", "=ds=#p8# (525)", "8 #embersilkbolt#" };
				{ 22, 54597, "", "=q3=Pattern: Vicious Fireweave Pants", "=ds=#p8# (525)", "8 #embersilkbolt#" };
			};
		};
		info = {
			name = TAILORING..": "..AL["Cataclysm Vendor Sold Patterns"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	AtlasLoot_Data["TailoringMoPVendor"] = {
		["Normal"] = {
			{
				{ 1, 86360, "", "=q1=Pattern: Contender's Satin Cowl", "=ds=#p8# (590)", "#SPIRITOFHARMONY:1#"};
				{ 2, 86361, "", "=q1=Pattern: Contender's Satin Amice", "=ds=#p8# (575)", "#SPIRITOFHARMONY:1#"};
				{ 3, 86362, "", "=q1=Pattern: Contender's Satin Raiment", "=ds=#p8# (590)", "#SPIRITOFHARMONY:1#"};
				{ 4, 86365, "", "=q1=Pattern: Contender's Satin Cuffs", "=ds=#p8# (555)", "#SPIRITOFHARMONY:1#"};
				{ 5, 86363, "", "=q1=Pattern: Contender's Satin Handwraps", "=ds=#p8# (565)", "#SPIRITOFHARMONY:1#"};
				{ 6, 86367, "", "=q1=Pattern: Contender's Satin Belt", "=ds=#p8# (565)", "#SPIRITOFHARMONY:1#"};
				{ 7, 86364, "", "=q1=Pattern: Contender's Satin Pants", "=ds=#p8# (565)", "#SPIRITOFHARMONY:1#"};
				{ 8, 86366, "", "=q1=Pattern: Contender's Satin Footwraps", "=ds=#p8# (565)", "#SPIRITOFHARMONY:1#"};
				{ 16, 86352, "", "=q1=Pattern: Contender's Silk Cowl", "=ds=#p8# (590)", "#SPIRITOFHARMONY:1#"};
				{ 17, 86353, "", "=q1=Pattern: Contender's Silk Amice", "=ds=#p8# (575)", "#SPIRITOFHARMONY:1#"};
				{ 18, 86354, "", "=q1=Pattern: Contender's Silk Raiment", "=ds=#p8# (590)", "#SPIRITOFHARMONY:1#"};
				{ 19, 86357, "", "=q1=Pattern: Contender's Silk Cuffs", "=ds=#p8# (555)", "#SPIRITOFHARMONY:1#"};
				{ 20, 86355, "", "=q1=Pattern: Contender's Silk Handwraps", "=ds=#p8# (565)", "#SPIRITOFHARMONY:1#"};
				{ 21, 86359, "", "=q1=Pattern: Contender's Silk Belt", "=ds=#p8# (565)", "#SPIRITOFHARMONY:1#"};
				{ 22, 86356, "", "=q1=Pattern: Contender's Silk Pants", "=ds=#p8# (565)", "#SPIRITOFHARMONY:1#"};
				{ 23, 86358, "", "=q1=Pattern: Contender's Silk Footwraps", "=ds=#p8# (565)", "#SPIRITOFHARMONY:1#"};
			};
		};
		info = {
			name = TAILORING..": "..AL["Mists of Pandaria Vendor Sold Patterns"],
			module = moduleName, menu = "TAILORINGMENU",
		};
	};

	-----------------------
	--- Profession Sets ---
	-----------------------

		-------------------------------
		--- Blacksmithing Mail Sets ---
		-------------------------------

	AtlasLoot_Data["BlacksmithingMailBloodsoulEmbrace"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6="..BabbleItemSet["Bloodsoul Embrace"], ""};
				{ 2, 19691, "", "=q3=Bloodsoul Shoulders", "=ds=#s3#, #a3#"};
				{ 3, 19690, "", "=q3=Bloodsoul Breastplate", "=ds=#s5#, #a3#"};
				{ 4, 19692, "", "=q3=Bloodsoul Gauntlets", "=ds=#s9#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Bloodsoul Embrace"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingMail",
		};
	};

	AtlasLoot_Data["BlacksmithingMailFelIronChain"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6="..BabbleItemSet["Fel Iron Chain"], ""};
				{ 2, 23493, "", "=q2=Fel Iron Chain Coif", "=ds=#s1#, #a3#"};
				{ 3, 23490, "", "=q2=Fel Iron Chain Tunic", "=ds=#s5#, #a3#"};
				{ 4, 23494, "", "=q2=Fel Iron Chain Bracers", "=ds=#s8#, #a3#"};
				{ 5, 23491, "", "=q2=Fel Iron Chain Gloves", "=ds=#s9#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Fel Iron Chain"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingMail",
		};
	};

		--------------------------------
		--- Blacksmithing Plate Sets ---
		--------------------------------

	AtlasLoot_Data["BlacksmithingPlateImperialPlate"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp1#", ""};
				{ 2, 12427, "", "=q2=Imperial Plate Helm", "=ds=#s1#, #a4#"};
				{ 3, 12428, "", "=q2=Imperial Plate Shoulders", "=ds=#s3#, #a4#"};
				{ 4, 12422, "", "=q2=Imperial Plate Chest", "=ds=#s5#, #a4#"};
				{ 5, 12425, "", "=q2=Imperial Plate Bracers", "=ds=#s8#, #a4#"};
				{ 6, 12424, "", "=q2=Imperial Plate Belt", "=ds=#s10#, #a4#"};
				{ 7, 12429, "", "=q2=Imperial Plate Leggings", "=ds=#s11#, #a4#"};
				{ 8, 12426, "", "=q2=Imperial Plate Boots", "=ds=#s12#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Imperial Plate"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateTheDarksoul"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp2#", ""};
				{ 2, 19695, "", "=q3=Darksoul Shoulders", "=ds=#s3#, #a4#"};
				{ 3, 19693, "", "=q3=Darksoul Breastplate", "=ds=#s5#, #a4#"};
				{ 4, 19694, "", "=q3=Darksoul Leggings", "=ds=#s11#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["The Darksoul"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateFelIronPlate"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp3#", ""};
				{ 2, 23489, "", "=q2=Fel Iron Breastplate", "=ds=#s5#, #a4#"};
				{ 3, 23482, "", "=q2=Fel Iron Plate Gloves", "=ds=#s9#, #a4#"};
				{ 4, 23484, "", "=q2=Fel Iron Plate Belt", "=ds=#s10#, #a4#"};
				{ 5, 23488, "", "=q2=Fel Iron Plate Pants", "=ds=#s11#, #a4#"};
				{ 6, 23487, "", "=q2=Fel Iron Plate Boots", "=ds=#s12#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Fel Iron Plate"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateAdamantiteB"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp4#", ""};
				{ 2, 23507, "", "=q3=Adamantite Breastplate", "=ds=#s5#, #a4#"};
				{ 3, 23506, "", "=q3=Adamantite Plate Bracers", "=ds=#s8#, #a4#"};
				{ 4, 23508, "", "=q3=Adamantite Plate Gloves", "=ds=#s9#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Adamantite Battlegear"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateFlameG"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp5#", "=q1=#j11#"};
				{ 2, 23516, "", "=q3=Flamebane Helm", "=ds=#s1#, #a4#"};
				{ 3, 23513, "", "=q3=Flamebane Breastplate", "=ds=#s5#, #a4#"};
				{ 4, 23515, "", "=q3=Flamebane Bracers", "=ds=#s8#, #a4#"};
				{ 5, 23514, "", "=q3=Flamebane Gloves", "=ds=#s9#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Flame Guard"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateEnchantedAdaman"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp6#", "=q1=#j12#"};
				{ 2, 23509, "", "=q3=Enchanted Adamantite Breastplate", "=ds=#s5#, #a4#"};
				{ 3, 23510, "", "=q3=Enchanted Adamantite Belt", "=ds=#s10#, #a4#"};
				{ 4, 23512, "", "=q3=Enchanted Adamantite Leggings", "=ds=#s11#, #a4#"};
				{ 5, 23511, "", "=q3=Enchanted Adamantite Boots", "=ds=#s12#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Enchanted Adamantite Armor"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateKhoriumWard"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp7#", ""};
				{ 2, 23524, "", "=q3=Khorium Belt", "=ds=#s10#, #a4#"};
				{ 3, 23523, "", "=q3=Khorium Pants", "=ds=#s11#, #a4#"};
				{ 4, 23525, "", "=q3=Khorium Boots", "=ds=#s12#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Khorium Ward"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateFaithFelsteel"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp8#", ""};
				{ 2, 23519, "", "=q3=Felsteel Helm", "=ds=#s1#, #a4#"};
				{ 3, 23517, "", "=q3=Felsteel Gloves", "=ds=#s9#, #a4#"};
				{ 4, 23518, "", "=q3=Felsteel Leggings", "=ds=#s11#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Faith in Felsteel"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateBurningRage"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp9#", ""};
				{ 2, 23521, "", "=q3=Ragesteel Helm", "=ds=#s1#, #a4#"};
				{ 3, 33173, "", "=q3=Ragesteel Shoulders", "=ds=#s3#, #a4#"};
				{ 4, 23522, "", "=q3=Ragesteel Breastplate", "=ds=#s5#, #a4#"};
				{ 5, 23520, "", "=q3=Ragesteel Gloves", "=ds=#s9#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Burning Rage"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};
	
	AtlasLoot_Data["BlacksmithingPlateOrnateSaroniteBattlegear"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp10#", ""};
				{ 2, 42728, "", "=q3=Ornate Saronite Skullshield", "=ds=#s1#, #a4#"};
				{ 3, 42727, "", "=q3=Ornate Saronite Pauldrons", "=ds=#s3#, #a4#"};
				{ 4, 42725, "", "=q3=Ornate Saronite Hauberk", "=ds=#s5#, #a4#"};
				{ 5, 42723, "", "=q3=Ornate Saronite Bracers", "=ds=#s8#, #a4#"};
				{ 6, 42724, "", "=q3=Ornate Saronite Gauntlets", "=ds=#s9#, #a4#"};
				{ 7, 42729, "", "=q3=Ornate Saronite Waistguard", "=ds=#s10#, #a4#"};
				{ 8, 42726, "", "=q3=Ornate Saronite Legplates", "=ds=#s11#, #a4#"};
				{ 9, 42730, "", "=q3=Ornate Saronite Walkers", "=ds=#s12#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Ornate Saronite Battlegear"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

	AtlasLoot_Data["BlacksmithingPlateSavageSaroniteBattlegear"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Hammer_20", "=q6=#craftbp11#", ""};
				{ 2, 41350, "", "=q3=Savage Saronite Skullshield", "=ds=#s1#, #a4#"};
				{ 3, 41351, "", "=q3=Savage Saronite Pauldrons", "=ds=#s3#, #a4#"};
				{ 4, 41353, "", "=q3=Savage Saronite Hauberk", "=ds=#s5#, #a4#"};
				{ 5, 41354, "", "=q3=Savage Saronite Bracers", "=ds=#s8#, #a4#"};
				{ 6, 41349, "", "=q3=Savage Saronite Gauntlets", "=ds=#s9#, #a4#"};
				{ 7, 41352, "", "=q3=Savage Saronite Waistguard", "=ds=#s10#, #a4#"};
				{ 8, 41347, "", "=q3=Savage Saronite Legplates", "=ds=#s11#, #a4#"};
				{ 9, 41348, "", "=q3=Savage Saronite Walkers", "=ds=#s12#, #a4#"};
			};
		};
		info = {
			name = BabbleItemSet["Savage Saronite Battlegear"],
			module = moduleName, menu = "CRAFTSET", instance = "BlacksmithingPlate",
		};
	};

		-----------------------------------
		--- Leatherworking Leather Sets ---
		-----------------------------------

	AtlasLoot_Data["LeatherworkingLeatherVolcanicArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl1#", "=q1=#j11#"};
				{ 2, 15055, "", "=q2=Volcanic Shoulders", "=ds=#s3#, #a2#"};
				{ 3, 15053, "", "=q2=Volcanic Breastplate", "=ds=#s5#, #a2#"};
				{ 4, 15054, "", "=q2=Volcanic Leggings", "=ds=#s11#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Volcanic Armor"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherIronfeatherArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl2#", ""};
				{ 2, 15067, "", "=q3=Ironfeather Shoulders", "=ds=#s3#, #a2#"};
				{ 3, 15066, "", "=q3=Ironfeather Breastplate", "=ds=#s5#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Ironfeather Armor"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherStormshroudArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl3#", ""};
				{ 2, 15058, "", "=q3=Stormshroud Shoulders", "=ds=#s3#, #a2#"};
				{ 3, 15056, "", "=q3=Stormshroud Armor", "=ds=#s5#, #a2#"};
				{ 4, 21278, "", "=q3=Stormshroud Gloves", "=ds=#s9#, #a2#"};
				{ 5, 15057, "", "=q3=Stormshroud Pants", "=ds=#s11#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Stormshroud Armor"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherDevilsaurArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl4#", ""};
				{ 2, 15063, "", "=q3=Devilsaur Gauntlets", "=ds=#s9#, #a2#"};
				{ 3, 15062, "", "=q3=Devilsaur Leggings", "=ds=#s11#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Devilsaur Armor"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherBloodTigerH"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl5#", ""};
				{ 2, 19689, "", "=q3=Blood Tiger Shoulders", "=ds=#s3#, #a2#"};
				{ 3, 19688, "", "=q3=Blood Tiger Breastplate", "=ds=#s5#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Blood Tiger Harness"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherPrimalBatskin"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl6#", ""};
				{ 2, 19685, "", "=q3=Primal Batskin Jerkin", "=ds=#s5#, #a2#"};
				{ 3, 19687, "", "=q3=Primal Batskin Bracers", "=ds=#s8#, #a2#"};
				{ 4, 19686, "", "=q3=Primal Batskin Gloves", "=ds=#s9#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Primal Batskin"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherWildDraenishA"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl7#", ""};
				{ 2, 25676, "", "=q2=Wild Draenish Vest", "=ds=#s5#, #a2#"};
				{ 3, 25674, "", "=q2=Wild Draenish Gloves", "=ds=#s9#, #a2#"};
				{ 4, 25675, "", "=q2=Wild Draenish Leggings", "=ds=#s11#, #a2#"};
				{ 5, 25673, "", "=q2=Wild Draenish Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Wild Draenish Armor"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherThickDraenicA"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl8#", ""};
				{ 2, 25671, "", "=q2=Thick Draenic Vest", "=ds=#s5#, #a2#"};
				{ 3, 25669, "", "=q2=Thick Draenic Gloves", "=ds=#s9#, #a2#"};
				{ 4, 25670, "", "=q2=Thick Draenic Pants", "=ds=#s11#, #a2#"};
				{ 5, 25668, "", "=q2=Thick Draenic Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Thick Draenic Armor"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherFelSkin"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl9#", ""};
				{ 2, 25685, "", "=q3=Fel Leather Gloves", "=ds=#s9#, #a2#"};
				{ 3, 25687, "", "=q3=Fel Leather Leggings", "=ds=#s11#, #a2#"};
				{ 4, 25686, "", "=q3=Fel Leather Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Fel Skin"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherSClefthoof"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl10#", ""};
				{ 2, 25689, "", "=q3=Heavy Clefthoof Vest", "=ds=#s5#, #a2#"};
				{ 3, 25690, "", "=q3=Heavy Clefthoof Leggings", "=ds=#s11#, #a2#"};
				{ 4, 25691, "", "=q3=Heavy Clefthoof Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Strength of the Clefthoof"],
			module = moduleName, menu = "CRAFTSET2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherPrimalIntent"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwe1#", "=q1=#p11#"};
				{ 2, 29525, "", "=q4=Primalstrike Vest", "=ds=#s5#, #a2#"};
				{ 3, 29527, "", "=q4=Primalstrike Bracers", "=ds=#s8#, #a2#"};
				{ 4, 29526, "", "=q4=Primalstrike Belt", "=ds=#s10#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Primal Intent"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherWindhawkArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwt1#", "=q1=#p10#"};
				{ 2, 29522, "", "=q4=Windhawk Hauberk", "=ds=#s5#, #a2#"};
				{ 3, 29523, "", "=q4=Windhawk Bracers", "=ds=#s8#, #a2#"};
				{ 4, 29524, "", "=q4=Windhawk Belt", "=ds=#s10#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Windhawk Armor"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherBoreanEmbrace"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl11#", ""};
				{ 2, 38437, "", "=q2=Arctic Helm", "=ds=#s1#, #a2#"};
				{ 3, 38402, "", "=q2=Arctic Shoulderpads", "=ds=#s3#, #a2#"};
				{ 4, 38400, "", "=q2=Arctic Chestpiece", "=ds=#s5#, #a2#"};
				{ 5, 38433, "", "=q2=Arctic Wristguards", "=ds=#s8#, #a2#"};
				{ 6, 38403, "", "=q2=Arctic Gloves", "=ds=#s9#, #a2#"};
				{ 7, 38405, "", "=q2=Arctic Belt", "=ds=#s10#, #a2#"};
				{ 8, 38401, "", "=q2=Arctic Leggings", "=ds=#s11#, #a2#"};
				{ 9, 38404, "", "=q2=Arctic Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Borean Embrace"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherIceborneEmbrace"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl12#", ""};
				{ 2, 38438, "", "=q2=Iceborne Helm", "=ds=#s1#, #a2#"};
				{ 3, 38411, "", "=q2=Iceborne Shoulderpads", "=ds=#s3#, #a2#"};
				{ 4, 38408, "", "=q2=Iceborne Chestguard", "=ds=#s5#, #a2#"};
				{ 5, 38434, "", "=q2=Iceborne Wristguards", "=ds=#s8#, #a2#"};
				{ 6, 38409, "", "=q2=Iceborne Gloves", "=ds=#s9#, #a2#"};
				{ 7, 38406, "", "=q2=Iceborne Belt", "=ds=#s10#, #a2#"};
				{ 8, 38410, "", "=q2=Iceborne Leggings", "=ds=#s11#, #a2#"};
				{ 9, 38407, "", "=q2=Iceborne Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Iceborne Embrace"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherEvisceratorBattlegear"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl13#", ""};
				{ 2, 43260, "", "=q3=Eviscerator's Facemask", "=ds=#s1#, #a2#"};
				{ 3, 43433, "", "=q3=Eviscerator's Shoulderpads", "=ds=#s3#, #a2#"};
				{ 4, 43434, "", "=q3=Eviscerator's Chestguard", "=ds=#s5#, #a2#"};
				{ 5, 43435, "", "=q3=Eviscerator's Bindings", "=ds=#s8#, #a2#"};
				{ 6, 43436, "", "=q3=Eviscerator's Gauntlets", "=ds=#s9#, #a2#"};
				{ 7, 43437, "", "=q3=Eviscerator's Waistguard", "=ds=#s10#, #a2#"};
				{ 8, 43438, "", "=q3=Eviscerator's Legguards", "=ds=#s11#, #a2#"};
				{ 9, 43439, "", "=q3=Eviscerator's Treads", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Eviscerator's Battlegear"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

	AtlasLoot_Data["LeatherworkingLeatherOvercasterBattlegear"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwl14#", ""};
				{ 2, 43261, "", "=q3=Overcast Headguard", "=ds=#s1#, #a2#"};
				{ 3, 43262, "", "=q3=Overcast Spaulders", "=ds=#s3#, #a2#"};
				{ 4, 43263, "", "=q3=Overcast Chestguard", "=ds=#s5#, #a2#"};
				{ 5, 43264, "", "=q3=Overcast Bracers", "=ds=#s8#, #a2#"};
				{ 6, 43265, "", "=q3=Overcast Handwraps", "=ds=#s9#, #a2#"};
				{ 7, 43266, "", "=q3=Overcast Belt", "=ds=#s10#, #a2#"};
				{ 8, 43271, "", "=q3=Overcast Leggings", "=ds=#s11#, #a2#"};
				{ 9, 43273, "", "=q3=Overcast Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = BabbleItemSet["Overcaster Battlegear"],
			module = moduleName, menu = "CRAFTSET#2", instance = "LeatherworkingLeather",
		};
	};

		--------------------------------
		--- Leatherworking Mail Sets ---
		--------------------------------

	AtlasLoot_Data["LeatherworkingMailGreenDragonM"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm1#", "=q1=#j13#"};
				{ 2, 15045, "", "=q3=Green Dragonscale Breastplate", "=ds=#s5#, #a3#"};
				{ 3, 20296, "", "=q3=Green Dragonscale Gauntlets", "=ds=#s9#, #a3#"};
				{ 4, 15046, "", "=q3=Green Dragonscale Leggings", "=ds=#s11#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Green Dragon Mail"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailBlueDragonM"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm2#", "=q1=#j12#"};
				{ 2, 15049, "", "=q3=Blue Dragonscale Shoulders", "=ds=#s3#, #a3#"};
				{ 3, 15048, "", "=q3=Blue Dragonscale Breastplate", "=ds=#s5#, #a3#"};
				{ 4, 20295, "", "=q3=Blue Dragonscale Leggings", "=ds=#s11#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Blue Dragon Mail"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailBlackDragonM"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm3#", "=q1=#j11#"};
				{ 2, 15051, "", "=q3=Black Dragonscale Shoulders", "=ds=#s3#, #a3#"};
				{ 3, 15050, "", "=q3=Black Dragonscale Breastplate", "=ds=#s5#, #a3#"};
				{ 4, 15052, "", "=q3=Black Dragonscale Leggings", "=ds=#s11#, #a3#"};
				{ 5, 16984, "", "=q4=Black Dragonscale Boots", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Black Dragon Mail"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailScaledDraenicA"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm4#", ""};
				{ 2, 25660, "", "=q2=Scaled Draenic Vest", "=ds=#s5#, #a3#"};
				{ 3, 25661, "", "=q2=Scaled Draenic Gloves", "=ds=#s9#, #a3#"};
				{ 4, 25662, "", "=q2=Scaled Draenic Pants", "=ds=#s11#, #a3#"};
				{ 5, 25659, "", "=q2=Scaled Draenic Boots", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Scaled Draenic Armor"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailFelscaleArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm5#", ""};
				{ 2, 25657, "", "=q2=Felscale Breastplate", "=ds=#s5#, #a3#"};
				{ 3, 25654, "", "=q2=Felscale Gloves", "=ds=#s9#, #a3#"};
				{ 4, 25656, "", "=q2=Felscale Pants", "=ds=#s11#, #a3#"};
				{ 5, 25655, "", "=q2=Felscale Boots", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Felscale Armor"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailFelstalkerArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm6#", ""};
				{ 2, 25696, "", "=q3=Felstalker Breastplate", "=ds=#s5#, #a3#"};
				{ 3, 25697, "", "=q3=Felstalker Bracers", "=ds=#s8#, #a3#"};
				{ 4, 25695, "", "=q3=Felstalker Belt", "=ds=#s10#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Felstalker Armor"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailNetherFury"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm7#", ""};
				{ 2, 25694, "", "=q3=Netherfury Belt", "=ds=#s10#, #a3#"};
				{ 3, 25692, "", "=q3=Netherfury Leggings", "=ds=#s11#, #a3#"};
				{ 4, 25693, "", "=q3=Netherfury Boots", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Fury of the Nether"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailNetherscaleArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwd1#", "=q1=#p9#"};
				{ 2, 29515, "", "=q4=Ebon Netherscale Breastplate", "=ds=#s5#, #a3#"};
				{ 3, 29517, "", "=q4=Ebon Netherscale Bracers", "=ds=#s8#, #a3#"};
				{ 4, 29516, "", "=q4=Ebon Netherscale Belt", "=ds=#s10#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Netherscale Armor"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailNetherstrikeArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwd2#", "=q1=#p9#"};
				{ 2, 29519, "", "=q4=Netherstrike Breastplate", "=ds=#s5#, #a3#"};
				{ 3, 29521, "", "=q4=Netherstrike Bracers", "=ds=#s8#, #a3#"};
				{ 4, 29520, "", "=q4=Netherstrike Belt", "=ds=#s10#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Netherstrike Armor"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailFrostscaleBinding"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm8#", ""};
				{ 2, 38440, "", "=q2=Frostscale Helm", "=ds=#s1#, #a3#"};
				{ 3, 38424, "", "=q2=Frostscale Shoulders", "=ds=#s3#, #a3#"};
				{ 4, 38414, "", "=q2=Frostscale Chestguard", "=ds=#s5#, #a3#"};
				{ 5, 38436, "", "=q2=Frostscale Bracers", "=ds=#s8#, #a3#"};
				{ 6, 38415, "", "=q2=Frostscale Gloves", "=ds=#s9#, #a3#"};
				{ 7, 38412, "", "=q2=Frostscale Belt", "=ds=#s10#, #a3#"};
				{ 8, 38416, "", "=q2=Frostscale Leggings", "=ds=#s11#, #a3#"};
				{ 9, 38413, "", "=q2=Frostscale Boots", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Frostscale Binding"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailNerubianHive"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm9#", ""};
				{ 2, 38439, "", "=q2=Nerubian Helm", "=ds=#s1#, #a3#"};
				{ 3, 38417, "", "=q2=Nerubian Shoulders", "=ds=#s3#, #a3#"};
				{ 4, 38420, "", "=q2=Nerubian Chestguard", "=ds=#s5#, #a3#"};
				{ 5, 38435, "", "=q2=Nerubian Bracers", "=ds=#s8#, #a3#"};
				{ 6, 38421, "", "=q2=Nerubian Gloves", "=ds=#s9#, #a3#"};
				{ 7, 38418, "", "=q2=Nerubian Belt", "=ds=#s10#, #a3#"};
				{ 8, 38422, "", "=q2=Nerubian Legguards", "=ds=#s11#, #a3#"};
				{ 9, 38419, "", "=q2=Nerubian Boots", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Nerubian Hive"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailStormhideBattlegear"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm10#", ""};
				{ 2, 43455, "", "=q3=Stormhide Crown", "=ds=#s1#, #a3#"};
				{ 3, 43457, "", "=q3=Stormhide Shoulders", "=ds=#s3#, #a3#"};
				{ 4, 43453, "", "=q3=Stormhide Hauberk", "=ds=#s5#, #a3#"};
				{ 5, 43452, "", "=q3=Stormhide Wristguards", "=ds=#s8#, #a3#"};
				{ 6, 43454, "", "=q3=Stormhide Grips", "=ds=#s9#, #a3#"};
				{ 7, 43450, "", "=q3=Stormhide Belt", "=ds=#s10#, #a3#"};
				{ 8, 43456, "", "=q3=Stormhide Legguards", "=ds=#s11#, #a3#"};
				{ 9, 43451, "", "=q3=Stormhide Stompers", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Stormhide Battlegear"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

	AtlasLoot_Data["LeatherworkingMailSwiftarrowBattlefear"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#craftlwm11#", ""};
				{ 2, 43447, "", "=q3=Swiftarrow Helm", "=ds=#s1#, #a3#"};
				{ 3, 43449, "", "=q3=Swiftarrow Shoulderguards", "=ds=#s3#, #a3#"};
				{ 4, 43445, "", "=q3=Swiftarrow Hauberk", "=ds=#s5#, #a3#"};
				{ 5, 43444, "", "=q3=Swiftarrow Bracers", "=ds=#s8#, #a3#"};
				{ 6, 43446, "", "=q3=Swiftarrow Gauntlets", "=ds=#s9#, #a3#"};
				{ 7, 43442, "", "=q3=Swiftarrow Belt", "=ds=#s10#, #a3#"};
				{ 8, 43448, "", "=q3=Swiftarrow Leggings", "=ds=#s11#, #a3#"};
				{ 9, 43443, "", "=q3=Swiftarrow Boots", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = BabbleItemSet["Swiftarrow Battlegear"],
			module = moduleName, menu = "CRAFTSET#3", instance = "LeatherworkingMail",
		};
	};

		----------------------
		--- Tailoring Sets ---
		----------------------

	AtlasLoot_Data["TailoringBloodvineG"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt1#", ""};
				{ 2, 19682, "", "=q3=Bloodvine Vest", "=ds=#s5#, #a1#"};
				{ 3, 19683, "", "=q3=Bloodvine Leggings", "=ds=#s11#, #a1#"};
				{ 4, 19684, "", "=q3=Bloodvine Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Bloodvine Garb"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringNeatherVest"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt2#", ""};
				{ 2, 21855, "", "=q2=Netherweave Tunic", "=ds=#s5#, #a1#"};
				{ 3, 21854, "", "=q2=Netherweave Robe", "=ds=#s5#, #a1#"};
				{ 4, 21849, "", "=q2=Netherweave Bracers", "=ds=#s8#, #a1#"};
				{ 5, 21851, "", "=q2=Netherweave Gloves", "=ds=#s9#, #a1##"};
				{ 6, 21850, "", "=q2=Netherweave Belt", "=ds=#s10#, #a1#"};
				{ 7, 21852, "", "=q2=Netherweave Pants", "=ds=#s11#, #a1#"};
				{ 8, 21853, "", "=q2=Netherweave Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Netherweave Vestments"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringImbuedNeather"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt3#", ""};
				{ 2, 21862, "", "=q3=Imbued Netherweave Tunic", "=ds=#s5#, #a1#"};
				{ 3, 21861, "", "=q3=Imbued Netherweave Robe", "=ds=#s5#, #a1#"};
				{ 4, 21859, "", "=q3=Imbued Netherweave Pants", "=ds=#s11#, #a1#"};
				{ 5, 21860, "", "=q3=Imbued Netherweave Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Imbued Netherweave"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringArcanoVest"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt4#", "=q1=#j12#"};
				{ 2, 21868, "", "=q3=Arcanoweave Robe", "=ds=#s5#, #a1#"};
				{ 3, 21866, "", "=q3=Arcanoweave Bracers", "=ds=#s8#, #a1#"};
				{ 4, 21867, "", "=q3=Arcanoweave Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Arcanoweave Vestments"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringTheUnyielding"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt5#", ""};
				{ 2, 24249, "", "=q3=Unyielding Bracers", "=ds=#s8#, #a1#"};
				{ 3, 24255, "", "=q4=Unyielding Girdle", "=ds=#s10#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["The Unyielding"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringWhitemendWis"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt6#", ""};
				{ 2, 24264, "", "=q4=Whitemend Hood", "=ds=#s1#, #a1#"};
				{ 3, 24261, "", "=q4=Whitemend Pants", "=ds=#s11#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Whitemend Wisdom"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringSpellstrikeInfu"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt7#", ""};
				{ 2, 24266, "", "=q4=Spellstrike Hood", "=ds=#s1#, #a1#"};
				{ 3, 24262, "", "=q4=Spellstrike Pants", "=ds=#s11#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Spellstrike Infusion"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringBattlecastG"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt8#", ""};
				{ 2, 24267, "", "=q4=Battlecast Hood", "=ds=#s1#, #a1#"};
				{ 3, 24263, "", "=q4=Battlecast Pants", "=ds=#s11#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Battlecast Garb"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringSoulclothEm"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt9#", "=q1=#j12#"};
				{ 2, 21864, "", "=q4=Soulcloth Shoulders", "=ds=#s3#, #a1#"};
				{ 3, 21865, "", "=q4=Soulcloth Vest", "=ds=#s5#, #a1#"};
				{ 4, 21863, "", "=q4=Soulcloth Gloves", "=ds=#s9#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Soulcloth Embrace"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringPrimalMoon"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#crafttm1#", "=q1=#p19#"};
				{ 2, 21874, "", "=q4=Primal Mooncloth Shoulders", "=ds=#s3#, #a1#"};
				{ 3, 21875, "", "=q4=Primal Mooncloth Robe", "=ds=#s5#, #a1#"};
				{ 4, 21873, "", "=q4=Primal Mooncloth Belt", "=ds=#s10#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Primal Mooncloth"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringShadowEmbrace"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#crafttsh1#", "=q1=#p20#"};
				{ 2, 21869, "", "=q4=Frozen Shadoweave Shoulders", "=ds=#s3#, #a1#"};
				{ 3, 21871, "", "=q4=Frozen Shadoweave Vest", "=ds=#s5#, #a1#"};
				{ 4, 21870, "", "=q4=Frozen Shadoweave Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Shadow's Embrace"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringSpellfireWrath"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#crafttsf1#", "=q1=#p21#"};
				{ 2, 21848, "", "=q4=Spellfire Robe", "=ds=#s5#, #a1#"};
				{ 3, 21847, "", "=q4=Spellfire Gloves", "=ds=#s9#, #a1#"};
				{ 4, 21846, "", "=q4=Spellfire Belt", "=ds=#s10#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Wrath of Spellfire"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringFrostwovenPower"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt10#", ""};
				{ 2, 41521, "", "=q2=Frostwoven Cowl", "=ds=#s1#, #a1#"};
				{ 3, 41513, "", "=q2=Frostwoven Shoulders", "=ds=#s3#, #a1#"};
				{ 4, 41515, "", "=q2=Frostwoven Robe", "=ds=#s5#, #a1#"};
				{ 5, 41512, "", "=q2=Frostwoven Wristwraps", "=ds=#s8#, #a1#"};
				{ 6, 44211, "", "=q2=Frostwoven Gloves", "=ds=#s9#, #a1#"};
				{ 7, 41522, "", "=q2=Frostwoven Belt", "=ds=#s10#, #a1#"};
				{ 8, 41519, "", "=q2=Frostwoven Leggings", "=ds=#s11#, #a1#"};
				{ 9, 41520, "", "=q2=Frostwoven Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Frostwoven Power"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringDuskweaver"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt11#", ""};
				{ 2, 41546, "", "=q2=Duskweave Cowl", "=ds=#s1#, #a1#"};
				{ 3, 41550, "", "=q2=Duskweave Shoulders", "=ds=#s3#, #a1#"};
				{ 4, 41549, "", "=q2=Duskweave Robe", "=ds=#s5#, #a1#"};
				{ 5, 41551, "", "=q2=Duskweave Wristwraps", "=ds=#s8#, #a1#"};
				{ 6, 41545, "", "=q2=Duskweave Gloves", "=ds=#s9#, #a1#"};
				{ 7, 41543, "", "=q2=Duskweave Belt", "=ds=#s10#, #a1#"};
				{ 8, 41548, "", "=q2=Duskweave Leggings", "=ds=#s11#, #a1#"};
				{ 9, 41544, "", "=q2=Duskweave Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Duskweaver"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	AtlasLoot_Data["TailoringFrostsavageBattlegear"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Fabric_Linen_02", "=q6=#craftt12#", ""};
				{ 2, 43971, "", "=q3=Frostsavage Cowl", "=ds=#s1#, #a1#"};
				{ 3, 43973, "", "=q3=Frostsavage Shoulders", "=ds=#s3#, #a1#"};
				{ 4, 43972, "", "=q3=Frostsavage Robe", "=ds=#s5#, #a1#"};
				{ 5, 43974, "", "=q3=Frostsavage Bracers", "=ds=#s8#, #a1#"};
				{ 6, 41516, "", "=q3=Frostsavage Gloves", "=ds=#s9#, #a1#"};
				{ 7, 43969, "", "=q3=Frostsavage Belt", "=ds=#s10#, #a1#"};
				{ 8, 43975, "", "=q3=Frostsavage Leggings", "=ds=#s11#, #a1#"};
				{ 9, 43970, "", "=q3=Frostsavage Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = BabbleItemSet["Frostsavage Battlegear"],
			module = moduleName, menu = "CRAFTSET#4", instance = "TailoringSets",
		};
	};

	-------------
	--- Other ---
	-------------

		----------------------------
		--- Crafted Epic Weapons ---
		----------------------------

	AtlasLoot_Data["CraftedWeapons"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#p2#", "=q1="..AL["Level 90"]};
				{ 2, 94591, "", "=q4=Blazefury, Reborn", "=ds=#h1#, #w10#"};
				{ 3, 94580, "", "=q4=Bloodmoon, Reborn", "=ds=#h2#, #w1#"};
				{ 4, 94585, "", "=q4=Dragonstrike, Reborn", "=ds=#h1#, #w6#"};
				{ 5, 94592, "", "=q4=Lionheart Executioner, Reborn", "=ds=#h2#, #w10#"};
				{ 6, 94586, "", "=q4=Stormherald, Reborn", "=ds=#h2#, #w6#"};
				{ 7, 94579, "", "=q4=Wicked Edge of the Planes, Reborn", "=ds=#h1#, #w1#"};
				{ 8, 94577, "", "=q4=Black Planar Edge, Reborn", "=ds=#h1#, #w1#"};
				{ 9, 94589, "", "=q4=Blazeguard, Reborn", "=ds=#h1#, #w10#"};
				{ 10, 94583, "", "=q4=Deep Thunder, Reborn", "=ds=#h2#, #w6#"};
				{ 11, 94584, "", "=q4=Dragonmaw, Reborn", "=ds=#h1#, #w6#"};
				{ 12, 94590, "", "=q4=Lionheart Champion, Reborn", "=ds=#h2#, #w10#"};
				{ 13, 94578, "", "=q4=Mooncleaver, Reborn", "=ds=#h2#, #w1#"};
				{ 16, 0, "INV_Box_01", "=q6=#p2#", "=q1="..AL["Level 85"]};
				{ 17, 70155, "", "=q4=Brainsplinter", "=ds=#h1#, #w4#"};
				{ 18, 70158, "", "=q4=Elementium-Edged Scalper", "=ds=#h1#, #w1#"};
				{ 19, 70157, "", "=q4=Lightforged Elementium Hammer", "=ds=#h1#, #w6#"};
				{ 20, 70164, "", "=q4=Masterwork Elementium Deathblade", "=ds=#h2#, #w10#"};
				{ 21, 70156, "", "=q4=Masterwork Elementium Spellblade", "=ds=#h1#, #w4#"};
				{ 22, 70162, "", "=q4=Pyrium Spellward", "=ds=#h1#, #w10#"};
				{ 23, 70163, "", "=q4=Unbreakable Guardian", "=ds=#h1#, #w10#"};
				{ 24, 70165, "", "=q4=Witch-Hunter's Harvester", "=ds=#h2#, #w7#"};
				{ 25, 55069, "", "=q4=Elementium Earthguard", "=ds=#w8#"};
				{ 26, 55070, "", "=q4=Elementium Stormshield", "=ds=#w8#"};
				{ 28, 0, "INV_Box_01", "=q6=#p5#", "=q1="..AL["Level 85"]};
				{ 29, 71077, "", "=q4=Extreme-Impact Hole Puncher", "=ds=#w5#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6=#p2#", "=q1="..AL["Level 80"]};
				{ 2, 45085, "", "=q4=Titansteel Spellblade", "=ds=#h1#, #w4#"};
				{ 3, 42435, "", "=q4=Titansteel Shanker", "=ds=#h1#, #w4#"};
				{ 4, 41383, "", "=q4=Titansteel Bonecrusher", "=ds=#h1#, #w6#"};
				{ 5, 41384, "", "=q4=Titansteel Guardian", "=ds=#h1#, #w6#"};
				{ 6, 41257, "", "=q4=Titansteel Destroyer", "=ds=#h2#, #w6#"};
				{ 7, 42508, "", "=q4=Titansteel Shield Wall", "=ds=#w8#"};
				{ 9, 0, "INV_Box_01", "=q6=#p5#", "=q1="..AL["Level 80"]};
				{ 10, 41168, "", "=q4=Armor Plated Combat Shotgun", "=ds=#w5#"};
				{ 11, 44504, "", "=q4=Nesingwary 4000", "=ds=#w5#"};
				{ 16, 0, "INV_Box_01", "=q6=#p2#", "=q1="..AL["Level 70"]};
				{ 17, 23554, "", "=q4=Eternium Runed Blade", "=ds=#h1#, #w4#"};
				{ 18, 23555, "", "=q4=Dirge", "=ds=#h1#, #w4#"};
				{ 19, 23540, "", "=q4=Felsteel Longblade", "=ds=#h1#, #w10#"};
				{ 20, 23541, "", "=q4=Khorium Champion", "=ds=#h2#, #w10#"};
				{ 21, 23542, "", "=q4=Fel Edged Battleaxe", "=ds=#h1#, #w1#"};
				{ 22, 23543, "", "=q4=Felsteel Reaper", "=ds=#h2#, #w1#"};
				{ 23, 23556, "", "=q4=Hand of Eternity", "=ds=#h1#, #w6#"};
				{ 24, 23544, "", "=q4=Runic Hammer", "=ds=#h1#, #w6#"};
				{ 25, 23546, "", "=q4=Fel Hardened Maul", "=ds=#h2#, #w6#"};
				{ 26, 32854, "", "=q4=Hammer of Righteous Might", "=ds=#h2#, #w6#"};
				{ 28, 0, "INV_Box_01", "=q6=#p5#", "=q1="..AL["Level 70"]};
				{ 29, 32756, "", "=q4=Gyro-Balanced Khorium Destroyer", "=ds=#w5#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6=#p15#", "=q1="..AL["Level 70"]};
				{ 2, 28425, "", "=q4=Fireguard", "=ds=#h1#, #w10#"};
				{ 3, 28426, "", "=q4=Blazeguard", "=ds=#h1#, #w10#"};
				{ 4, 28427, "", "=q4=Blazefury", "=ds=#h1#, #w10#"};
				{ 5, 28428, "", "=q4=Lionheart Blade", "=ds=#h2#, #w10#"};
				{ 6, 28429, "", "=q4=Lionheart Champion", "=ds=#h2#, #w10#"};
				{ 7, 28430, "", "=q4=Lionheart Executioner", "=ds=#h2#, #w10#"};
				{ 9, 0, "INV_Box_01", "=q6=#p14#", "=q1="..AL["Level 70"]};
				{ 10, 28431, "", "=q4=The Planar Edge", "=ds=#h1#, #w1#"};
				{ 11, 28432, "", "=q4=Black Planar Edge", "=ds=#h1#, #w1#"};
				{ 12, 28433, "", "=q4=Wicked Edge of the Planes", "=ds=#h1#, #w1#"};
				{ 13, 28434, "", "=q4=Lunar Crescent", "=ds=#h2#, #w1#"};
				{ 14, 28435, "", "=q4=Mooncleaver", "=ds=#h2#, #w1#"};
				{ 15, 28436, "", "=q4=Bloodmoon", "=ds=#h2#, #w1#"};
				{ 16, 0, "INV_Box_01", "=q6=#p22#", "=q1="..AL["Level 70"]};
				{ 17, 28437, "", "=q4=Drakefist Hammer", "=ds=#h1#, #w6#"};
				{ 18, 28438, "", "=q4=Dragonmaw", "=ds=#h1#, #w6#"};
				{ 19, 28439, "", "=q4=Dragonstrike", "=ds=#h1#, #w6#"};
				{ 20, 28440, "", "=q4=Thunder", "=ds=#h2#, #w6#"};
				{ 21, 28441, "", "=q4=Deep Thunder", "=ds=#h2#, #w6#"};
				{ 22, 28442, "", "=q4=Stormherald", "=ds=#h2#, #w6#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6=#p2#", "=q1="..AL["Level 60"]};
				{ 2, 19166, "", "=q4=Black Amnesty", "=ds=#h1#, #w4#"};
				{ 3, 22383, "", "=q4=Sageblade", "=ds=#h1#, #w10#"};
				{ 4, 19168, "", "=q4=Blackguard", "=ds=#h1#, #w10#"};
				{ 5, 19169, "", "=q4=Nightfall", "=ds=#h2#, #w1#"};
				{ 6, 19170, "", "=q4=Ebon Hand", "=ds=#h1#, #w6#"};
				{ 7, 22384, "", "=q4=Persuader", "=ds=#h1#, #w6#"};
				{ 8, 17193, "", "=q4=Sulfuron Hammer", "=ds=#h2#, #w6#"};
				{ 9, 19167, "", "=q4=Blackfury", "=ds=#w7#"};
				{ 10, 22198, "", "=q4=Jagged Obsidian Shield", "=ds=#w8#"};
				{ 12, 0, "INV_Box_01", "=q6=#p5#", "=q1="..AL["Level 60"]};
				{ 13, 18282, "", "=q4=Core Marksman Rifle", "=ds=#w5#"};
				{ 14, 18168, "", "=q4=Force Reactive Disk", "=ds=#w8#"};
			};
		};
		info = {
			name = AL["Crafted Epic Weapons"],
			module = moduleName, menu = "CRAFTINGMENU",
		};
	};

	--------------------------------
	--- Daily Profession Rewards ---
	--------------------------------

		---------------------
		--- Cooking Daily ---
		---------------------

	AtlasLoot_Data["CookingDaily"] = {
		["Normal"] = {
			{
				{ 1, 86425, "", "=q3=Cooking School Bell", "=ds=#sr# (450)", "#IRONPAW:50#"};
				{ 2, 86559, "", "=q7=Frying Pan", "=ds=#h1#", "#IRONPAW:50#"};
				{ 3, 86558, "", "=q7=Rolling Pin", "=ds=#s15#", "#IRONPAW:50#"};
				{ 4, 86468, "", "=q7=Apron", "=ds=#s7#", "#IRONPAW:50#"};
				{ 5, 75017, "", "=q2=Recipe: Great Pandaren Banquet", "=ds=#sr# (600)", "#IRONPAW:10#"};
				{ 6, 75013, "", "=q2=Recipe: Pandaren Banquet", "=ds=#sr# (600)", "#IRONPAW:10#"};
				{ 7, 92748, "", "=q1=Portable Refrigerator", "=ds=#e1#", "#IRONPAW:10#"};
				{ 8, 88801, "", "=q1=Flippable Table", "=ds=", "#IRONPAW:40#"};
				{ 9, 74853, "", "=q1=100 Year Soy Sauce", "=ds=#e8#", "#IRONPAW:1#"};
				{ 10, 74661, "", "=q1=Black Pepper", "=ds=#e8#", "#IRONPAW:1#"};
				{ 11, 74662, "", "=q1=Rice Flour", "=ds=#e8#", "#IRONPAW:1#"};
				{ 13, 0, "inv_misc_bag_10_blue", "=q6="..BabbleInventory["Fish"], ""};
				{ 14, 87723, "", "=q1=Sack of Emperor Salmon", "=ds=#e21#", "#IRONPAW:1#"};
				{ 15, 87722, "", "=q1=Sack of Giant Mantis Shrimp", "=ds=#e21#", "#IRONPAW:1#"};
				{ 16, 87729, "", "=q1=Sack of Golden Carp", "=ds=#e21#", "#IRONPAW:1#"};
				{ 17, 87721, "", "=q1=Sack of Jade Lungfish", "=ds=#e21#", "#IRONPAW:1#"};
				{ 18, 87726, "", "=q1=Sack of Jewel Danio", "=ds=#e21#", "#IRONPAW:1#"};
				{ 19, 87728, "", "=q1=Sack of Krasarang Paddlefish", "=ds=#e21#", "#IRONPAW:1#"};
				{ 20, 87724, "", "=q1=Sack of Redbelly Mandarin", "=ds=#e21#", "#IRONPAW:1#"};
				{ 21, 87727, "", "=q1=Sack of Reef Octopus", "=ds=#e21#", "#IRONPAW:1#"};
				{ 22, 87725, "", "=q1=Sack of Tiger Gourami", "=ds=#e21#", "#IRONPAW:1#"};
				{ 24, 0, "inv_misc_bag_10_red", "=q6="..BabbleInventory["Meat"], ""};
				{ 25, 87730, "", "=q1=Sack of Crocolisk Belly", "=ds=#e30#", "#IRONPAW:1#"};
				{ 26, 87702, "", "=q1=Sack of Mushan Ribs", "=ds=#e30#", "#IRONPAW:1#"};
				{ 27, 87704, "", "=q1=Sack of Raw Crab Meat", "=ds=#e30#", "#IRONPAW:1#"};
				{ 28, 87701, "", "=q1=Sack of Raw Tiger Steaks", "=ds=#e30#", "#IRONPAW:1#"};
				{ 29, 87703, "", "=q1=Sack of Raw Turtle Meat", "=ds=#e30#", "#IRONPAW:1#"};
				{ 30, 87705, "", "=q1=Sack of Wildfowl Breasts", "=ds=#e30#", "#IRONPAW:1#"};
				extraText = ": "..ALIL["Valley of the Four Winds"];
			};
			{
				{ 1, 0, "inv_misc_bag_10_green", "=q6="..AL["Vegetables"], ""};
				{ 2, 87706, "", "=q1=Sack of Green Cabbages", "=ds=#e31#", "#IRONPAW:1#"};
				{ 3, 87713, "", "=q1=Sack of Jade Squash", "=ds=#e31#", "#IRONPAW:1#"};
				{ 4, 87707, "", "=q1=Sack of Juicycrunch Carrots", "=ds=#e31#", "#IRONPAW:1#"};
				{ 5, 87708, "", "=q1=Sack of Mogu Pumpkins", "=ds=#e31#", "#IRONPAW:1#"};
				{ 6, 87715, "", "=q1=Sack of Pink Turnips", "=ds=#e31#", "#IRONPAW:1#"};
				{ 7, 87710, "", "=q1=Sack of Red Blossom Leeks", "=ds=#e31#", "#IRONPAW:1#"};
				{ 8, 87709, "", "=q1=Sack of Scallions", "=ds=#e31#", "#IRONPAW:1#"};
				{ 9, 87714, "", "=q1=Sack of Striped Melons", "=ds=#e31#", "#IRONPAW:1#"};
				{ 10, 87716, "", "=q1=Sack of White Turnips", "=ds=#e31#", "#IRONPAW:1#"};
				{ 11, 87712, "", "=q1=Sack of Witchberries", "=ds=#e31#", "#IRONPAW:1#"};
				extraText = ": "..ALIL["Valley of the Four Winds"];
			};
			{
				{ 1, 65411, "", "=q2=Recipe: Broiled Mountain Trout", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 2, 65408, "", "=q2=Recipe: Feathered Lure", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 3, 65415, "", "=q2=Recipe: Highland Spirits", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 4, 65407, "", "=q2=Recipe: Lavascale Fillet", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 5, 65412, "", "=q2=Recipe: Lightly Fried Lurker", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 6, 65416, "", "=q2=Recipe: Lurker Lunch", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 7, 65410, "", "=q2=Recipe: Salted Eye", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 8, 65413, "", "=q2=Recipe: Seasoned Crab", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 9, 65414, "", "=q2=Recipe: Starfire Espresso", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 10, 65406, "", "=q2=Recipe: Whitecrest Gumbo", "=ds=#sr# (450)", "#EPICUREAN:3#"};
				{ 11, 65418, "", "=q2=Recipe: Hearty Seafood Soup", "=ds=#sr# (475)", "#EPICUREAN:3#"};
				{ 12, 65417, "", "=q2=Recipe: Pickled Guppy", "=ds=#sr# (475)", "#EPICUREAN:3#"};
				{ 13, 65419, "", "=q2=Recipe: Tender Baked Turtle", "=ds=#sr# (475)", "#EPICUREAN:3#"};
				{ 14, 65426, "", "=q2=Recipe: Baked Rockfish", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 15, 65427, "", "=q2=Recipe: Basilisk Liverdog", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 16, 65429, "", "=q2=Recipe: Beer-Basted Crocolisk", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 17, 65424, "", "=q2=Recipe: Blackbelly Sushi", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 18, 65430, "", "=q2=Recipe: Crocolisk Au Gratin", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 19, 65422, "", "=q2=Recipe: Delicious Sagefish Tail", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 20, 65423, "", "=q2=Recipe: Fish Fry", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 21, 65428, "", "=q2=Recipe: Grilled Dragon", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 22, 65409, "", "=q2=Recipe: Lavascale Minestrone", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 23, 65420, "", "=q2=Recipe: Mushroom Sauce Mudfish", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 24, 68688, "", "=q2=Recipe: Scalding Murglesnout", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 25, 65421, "", "=q2=Recipe: Severed Sagefish Head", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				{ 26, 65425, "", "=q2=Recipe: Skewered Eel", "=ds=#sr# (500)", "#EPICUREAN:3#"};
				extraText = ": "..ALIL["Stormwind City"].." / "..ALIL["Orgrimmar"];
			};
			{
				{ 1, 65431, "", "=q2=Recipe: Chocolate Cookie", "=ds=#sr# (505)", "#EPICUREAN:3#"};
				{ 2, 65432, "", "=q2=Recipe: Fortune Cookie", "=ds=#sr# (525)", "#EPICUREAN:5#"};
				{ 3, 65433, "", "=q2=Recipe: South Island Iced Tea", "=ds=#sr# (525)", "#EPICUREAN:5#"};
				{ 4, 65513, "", "=q1=Crate of Tasty Meat", "=ds=#e30#", "#EPICUREAN:2#"};
				{ 5, 68689, "", "=q1=Imported Supplies", "=ds=#e8#", "#EPICUREAN:1#"};
				extraText = ": "..ALIL["Stormwind City"].." / "..ALIL["Orgrimmar"];
			};
			{
				{ 1, 46349, "", "=q3=Chef's Hat", "=ds=#s1#", "#EPICUREAN:100#"};
				{ 2, 43035, "", "=q2=Recipe: Blackened Dragonfin", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 3, 43032, "", "=q2=Recipe: Blackened Worg Steak", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 4, 43029, "", "=q2=Recipe: Critter Bites", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 5, 43033, "", "=q2=Recipe: Cuttlesteak", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 6, 43036, "", "=q2=Recipe: Dragonfin Filet", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 7, 43024, "", "=q2=Recipe: Firecracker Salmon", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 8, 43030, "", "=q2=Recipe: Hearty Rhino", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 9, 43026, "", "=q2=Recipe: Imperial Manta Steak", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 10, 43018, "", "=q2=Recipe: Mega Mammoth Meal", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 11, 43022, "", "=q2=Recipe: Mighty Rhino Dogs", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 12, 43023, "", "=q2=Recipe: Poached Northern Sculpin", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 13, 43028, "", "=q2=Recipe: Rhinolicious Wormsteak", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 14, 43031, "", "=q2=Recipe: Snapper Extreme", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 15, 43034, "", "=q2=Recipe: Spiced Mammoth Treats", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 16, 43020, "", "=q2=Recipe: Spiced Worm Burger", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 17, 43025, "", "=q2=Recipe: Spicy Blue Nettlefish", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 18, 43027, "", "=q2=Recipe: Spicy Fried Herring", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 19, 43019, "", "=q2=Recipe: Tender Shoveltusk Steak", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 20, 43037, "", "=q2=Recipe: Tracker Snacks", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 21, 43021, "", "=q2=Recipe: Very Burnt Worg", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 22, 44954, "", "=q2=Recipe: Worg Tartare", "=ds=#sr# (400)", "#EPICUREAN:3#"};
				{ 23, 43505, "", "=q2=Recipe: Gigantic Feast", "=ds=#sr# (425)", "#EPICUREAN:3#"};
				{ 24, 43506, "", "=q2=Recipe: Small Feast", "=ds=#sr# (425)", "#EPICUREAN:3#"};
				{ 25, 43017, "", "=q2=Recipe: Fish Feast", "=ds=#sr# (450)", "#EPICUREAN:5#"};
				{ 26, 43007, "", "=q1=Northern Spices", "=ds=#e8#", "#EPICUREAN:1#"};
				extraText = ": "..ALIL["Dalaran"];
			};
			{				
				{ 1, 0, "inv_misc_bag_11", "=q6="..ALIL["Small Spice Bag"], ""};
				{ 2, 33925, "", "=q3=Recipe: Delicious Chocolate Cake", "=ds=#sr# (1)", ""};
				{ 3, 33871, "", "=q3=Recipe: Stormchops", "=ds=#sr# (300)", ""};
				{ 4, 44228, "", "=q1=Baby Spice", "=ds=#m20#", ""};
				{ 5, 43007, "", "=q1=Northern Spices", "=ds=#e8#"};
				{ 6, 44114, "", "=q1=Old Spices", "=ds=#m20#", ""};
				extraText = ": "..ALIL["Dalaran"];
			};
			{
				{ 2, 33870, "", "=q2=Recipe: Skullfish Soup", "=ds=#sr# (325)", "", ""};
				{ 3, 33873, "", "=q2=Recipe: Spicy Hot Talbuk", "=ds=#sr# (325)", "", ""};
				{ 4, 33869, "", "=q2=Recipe: Broiled Bloodfin", "=ds=#sr# (300)", "", ""};
				{ 5, 33875, "", "=q2=Recipe: Kibler's Bits", "=ds=#sr# (300)", "", ""};
				{ 17, 33871, "", "=q3=Recipe: Stormchops", "=ds=#sr# (300)", "", ""};
				{ 18, 33925, "", "=q3=Recipe: Delicious Chocolate Cake", "=ds=#sr# (1)", "", ""};
				extraText = ": "..ALIL["Shattrath City"];
			};
		};
		info = {
			name = AL["Cooking Daily"],
			module = moduleName, menu = "COOKINGDAILYMENU",
		};
	}

		---------------------
		--- Fishing Daily ---
		---------------------

	AtlasLoot_Data["FishingDaily"] = {
		["Normal"] = {
			{
				{ 1, 45862, "", "=q4=Bold Stormjewel", "=ds=#e7#", "", ""};
				{ 2, 45882, "", "=q4=Brilliant Stormjewel", "=ds=#e7#", "", ""};
				{ 3, 45879, "", "=q4=Delicate Stormjewel", "=ds=#e7#", "", ""};
				{ 4, 45987, "", "=q4=Rigid Stormjewel", "=ds=#e7#", "", ""};
				{ 5, 45880, "", "=q4=Solid Stormjewel", "=ds=#e7#", "", ""};
				{ 6, 45881, "", "=q4=Sparkling Stormjewel", "=ds=#e7#", "", ""};
				{ 8, 33820, "", "=q3=Weather-Beaten Fishing Hat", "=ds=#s1#, #a1#", "", ""};
				{ 9, 45991, "", "=q3=Bone Fishing Pole", "=ds=#e20#", "", ""};
				{ 10, 45992, "", "=q3=Jeweled Fishing Pole", "=ds=#e20#", "", ""};
				{ 11, 44983, "", "=q3=Strand Crawler", "=ds=#e13#", "", ""};
				{ 12, 36784, "", "=q3=Siren's Tear", "=ds=#e7#", "", ""};
				{ 13, 45986, "", "=q3=Tiny Titanium Lockbox", "=ds=", "", ""};
				{ 16, 34834, "", "=q2=Recipe: Captain Rumsey's Lager", "=ds=#sr# (100)", "", ""};
				{ 17, 19971, "", "=q2=High Test Eternium Fishing Line", "=ds=#p24# #e17#", "", ""};
				{ 19, 45998, "", "=q1=Battered Jungle Hat", "=ds=#s1#", "", ""};
				{ 20, 45861, "", "=q1=Diamond-Tipped Cane", "=ds=#h2#", "", ""};
				{ 21, 46006, "", "=q1=Glow Worm", "=ds=#e24#", "", ""};
				{ 22, 45984, "", "=q1=Unusual Compass", "=ds=", "", ""};
				{ 23, 40195, "", "=q1=Pygmy Oil", "=ds=#e2#", "", ""};
				{ 24, 8827, "", "=q1=Elixir of Water Walking", "=ds=#e2#", "", ""};
				{ 25, 46004, "", "=q1=Sealed Vial of Poison", "=ds=#m2#", "", ""};
				{ 26, 48679, "", "=q1=Waterlogged Recipe", "=ds=#m2# #sr# (350)", "", ""};
				extraText = ": "..ALIL["Dalaran"];
			};
			{
				{ 1, 34837, "", "=q4=The 2 Ring", "=ds=#s13#", "", ""};
				{ 3, 33820, "", "=q3=Weather-Beaten Fishing Hat", "=ds=#s1#, #a1#", "", ""};
				{ 4, 35350, "", "=q3=Chuck's Bucket", "=ds=#e13#", "", ""};
				{ 5, 33818, "", "=q3=Muckbreath's Bucket", "=ds=#e13#", "", ""};
				{ 6, 35349, "", "=q3=Snarly's Bucket", "=ds=#e13#", "", ""};
				{ 7, 33816, "", "=q3=Toothy's Bucket", "=ds=#e13#", "", ""};
				{ 8, 34831, "", "=q3=Eye of the Sea", "=ds=#e7#", "", ""};
				{ 10, 34834, "", "=q2=Recipe: Captain Rumsey's Lager", "=ds=#sr# (100)", "", ""};
				{ 11, 34836, "", "=q2=Spun Truesilver Fishing Line", "=ds=#p24# #e17#", "", ""};
				{ 16, 34827, "", "=q1=Noble's Monocle", "=ds=#s1#", "", ""};
				{ 17, 34828, "", "=q1=Antique Silver Cufflinks", "=ds=#s8#", "", ""};
				{ 18, 34826, "", "=q1=Gold Wedding Band", "=ds=#s13#", "", ""};
				{ 19, 34829, "", "=q1=Ornate Drinking Stein", "=ds=#s15#", "", ""};
				{ 20, 34859, "", "=q1=Razor Sharp Fillet Knife", "=ds=#h1#, #w4#", "", ""};
				{ 21, 34109, "", "=q1=Weather-Beaten Journal", "=ds=#e10#", "", ""};
				{ 22, 8827, "", "=q1=Elixir of Water Walking", "=ds=#e2#", "", ""};
				{ 23, 34861, "", "=q1=Sharpened Fish Hook", "=ds=#e24#", "", ""};
				extraText = ": "..ALIL["Terokkar Forest"];
			};
		};
		info = {
			name = AL["Fishing Daily"],
			module = moduleName, menu = "FISHINGDAILYMENU",
		};
	}

		---------------------------
		--- Jewelcrafting Daily ---
		---------------------------

	AtlasLoot_Data["JewelcraftingDailyRed"] = {
		["Normal"] = {
			{
				{ 1, 41576, "", "=q3=Design: Bold Scarlet Ruby", "=ds=#p12# (390)"};
				{ 2, 41577, "", "=q3=Design: Delicate Scarlet Ruby", "=ds=#p12# (390)"};
				{ 3, 41578, "", "=q3=Design: Flashing Scarlet Ruby", "=ds=#p12# (390)"};
				{ 4, 46917, "", "=q3=Design: Bold Cardinal Ruby", "=ds=#p12# (450)"};
				{ 5, 46916, "", "=q3=Design: Brilliant Cardinal Ruby", "=ds=#p12# (450)"}; --v1
				{ 6, 46930, "", "=q3=Design: Brilliant Cardinal Ruby", "=ds=#p12# (450)"}; --v2
				{ 7, 46918, "", "=q3=Design: Delicate Cardinal Ruby", "=ds=#p12# (450)"}; --v1
				{ 8, 46919, "", "=q3=Design: Delicate Cardinal Ruby", "=ds=#p12# (450)"}; --v2
				{ 9, 46923, "", "=q3=Design: Flashing Cardinal Ruby", "=ds=#p12# (450)"};
				{ 10, 46920, "", "=q3=Design: Precise Cardinal Ruby", "=ds=#p12# (450)"};
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}

	AtlasLoot_Data["JewelcraftingDailyYellow"] = {
		["Normal"] = {
			{
				{ 1, 41579, "", "=q3=Design: Quick Autumn's Glow", "=ds=#p12# (390)"};
				{ 2, 41719, "", "=q3=Design: Subtle Autumn's Glow", "=ds=#p12# (390)"}; --v1
				{ 3, 41791, "", "=q3=Design: Subtle Autumn's Glow", "=ds=#p12# (390)"}; --v2
				{ 4, 46932, "", "=q3=Design: Mystic King's Amber", "=ds=#p12# (450)"};
				{ 5, 46933, "", "=q3=Design: Quick King's Amber", "=ds=#p12# (450)"};
				{ 6, 46929, "", "=q3=Design: Smooth King's Amber", "=ds=#p12# (450)"}; --v1
				{ 7, 46921, "", "=q3=Design: Smooth King's Amber", "=ds=#p12# (450)"}; --v2
				{ 8, 46931, "", "=q3=Design: Subtle King's Amber", "=ds=#p12# (450)"}; --v1
				{ 9, 46922, "", "=q3=Design: Subtle King's Amber", "=ds=#p12# (450)"}; --v2
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}

	AtlasLoot_Data["JewelcraftingDailyOrange"] = {
		["Normal"] = {
			{
				{ 1, 41686, "", "=q3=Design: Potent Monarch Topaz", "=ds=#p12# (390)"};
				{ 2, 41690, "", "=q3=Design: Reckless Monarch Topaz", "=ds=#p12# (390)"}; --v1
				{ 3, 41689, "", "=q3=Design: Reckless Monarch Topaz", "=ds=#p12# (390)"}; --v2
				{ 4, 47015, "", "=q3=Design: Champion's Ametrine", "=ds=#p12# (450)"};
				{ 5, 46949, "", "=q3=Design: Deadly Ametrine", "=ds=#p12# (450)"}; --v1
				{ 6, 47011, "", "=q3=Design: Deadly Ametrine", "=ds=#p12# (450)"}; --v2
				{ 7, 47020, "", "=q3=Design: Deft Ametrine", "=ds=#p12# (450)"}; --v1
				{ 8, 47023, "", "=q3=Design: Deft Ametrine", "=ds=#p12# (450)"}; --v2
				{ 9, 47019, "", "=q3=Design: Fierce Ametrine", "=ds=#p12# (450)"};
				{ 10, 46948, "", "=q3=Design: Inscribed Ametrine", "=ds=#p12# (450)"};
				{ 11, 47021, "", "=q3=Design: Lucent Ametrine", "=ds=#p12# (450)"}; --v1
				{ 12, 47016, "", "=q3=Design: Lucent Ametrine", "=ds=#p12# (450)"}; --v2
				{ 13, 46950, "", "=q3=Design: Potent Ametrine", "=ds=#p12# (450)"};
				{ 14, 47007, "", "=q3=Design: Reckless Ametrine", "=ds=#p12# (450)"};
				{ 15, 47022, "", "=q3=Design: Resolute Ametrine", "=ds=#p12# (450)"};
				{ 16, 47018, "", "=q3=Design: Resplendent Ametrine", "=ds=#p12# (450)"};
				{ 17, 47017, "", "=q3=Design: Stalwart Ametrine", "=ds=#p12# (450)"}; --v1
				{ 18, 47012, "", "=q3=Design: Stalwart Ametrine", "=ds=#p12# (450)"}; --v2
				{ 19, 41687, "", "=q3=Design: Deft Monarch Topaz", "=ds=#p12# (390)"}; --v1
				{ 20, 41792, "", "=q3=Design: Deft Monarch Topaz", "=ds=#p12# (390)"}; --v2
				{ 21, 46952, "", "=q3=Design: Willful Ametrine", "=ds=#p12# (450)"};
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}

	AtlasLoot_Data["JewelcraftingDailyGreen"] = {
		["Normal"] = {
			{
				{ 1, 41692, "", "=q3=Design: Energized Forest Emerald", "=ds=#p12# (390)"}; --v1
				{ 2, 41694, "", "=q3=Design: Energized Forest Emerald", "=ds=#p12# (390)"}; --v2
				{ 3, 41693, "", "=q3=Design: Forceful Forest Emerald", "=ds=#p12# (390)"};
				{ 4, 46912, "", "=q3=Design: Energized Eye of Zul", "=ds=#p12# (450)"}; --v1
				{ 5, 46910, "", "=q3=Design: Energized Eye of Zul", "=ds=#p12# (450)"}; --v2
				{ 6, 46904, "", "=q3=Design: Forceful Eye of Zul", "=ds=#p12# (450)"};
				{ 7, 46901, "", "=q3=Design: Jagged Eye of Zul", "=ds=#p12# (450)"}; --v1
				{ 8, 46944, "", "=q3=Design: Jagged Eye of Zul", "=ds=#p12# (450)"}; --v2
				{ 9, 46905, "", "=q3=Design: Misty Eye of Zul", "=ds=#p12# (450)"}; --v1
				{ 10, 46906, "", "=q3=Design: Misty Eye of Zul", "=ds=#p12# (450)"}; --v2
				{ 11, 46911, "", "=q3=Design: Radiant Eye of Zul", "=ds=#p12# (450)"}; --v1
				{ 12, 46908, "", "=q3=Design: Radiant Eye of Zul", "=ds=#p12# (450)"}; --v2
				{ 13, 46913, "", "=q3=Design: Shattered Eye of Zul", "=ds=#p12# (450)"};
				{ 14, 46898, "", "=q3=Design: Steady Eye of Zul", "=ds=#p12# (450)"};
				{ 15, 46915, "", "=q3=Design: Turbid Eye of Zul", "=ds=#p12# (450)"}; --v1
				{ 16, 46914, "", "=q3=Design: Turbid Eye of Zul", "=ds=#p12# (450)"}; --v2
				{ 17, 41698, "", "=q3=Design: Nimble Forest Emerald", "=ds=#p12# (390)"};
				{ 18, 41703, "", "=q3=Design: Regal Forest Emerald", "=ds=#p12# (390)"}; --v1
				{ 19, 41697, "", "=q3=Design: Regal Forest Emerald", "=ds=#p12# (390)"}; --v2
				{ 20, 41696, "", "=q3=Design: Lightning Forest Emerald", "=ds=#p12# (390)"}; --v1
				{ 21, 41782, "", "=q3=Design: Lightning Forest Emerald", "=ds=#p12# (390)"}; --v2
				{ 22, 41702, "", "=q3=Design: Jagged Forest Emerald", "=ds=#p12# (390)"}; --v1
				{ 23, 41723, "", "=q3=Design: Jagged Forest Emerald", "=ds=#p12# (390)"}; --v2
				{ 24, 46897, "", "=q3=Design: Regal Eye of Zul", "=ds=#p12# (450)"}; --v1
				{ 25, 46940, "", "=q3=Design: Regal Eye of Zul", "=ds=#p12# (450)"}; --v2
				{ 26, 46899, "", "=q3=Design: Nimble Eye of Zul", "=ds=#p12# (450)"};
				{ 27, 46909, "", "=q3=Design: Lightning Eye of Zul", "=ds=#p12# (450)"}; --v1
				{ 28, 46907, "", "=q3=Design: Lightning Eye of Zul", "=ds=#p12# (450)"}; --v2
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}

	AtlasLoot_Data["JewelcraftingDailyPurple"] = {
		["Normal"] = {
			{
				{ 1, 46941, "", "=q3=Design: Defender's Dreadstone", "=ds=#p12# (450)"};
				{ 2, 46942, "", "=q3=Design: Guardian's Dreadstone", "=ds=#p12# (450)"};
				{ 3, 46943, "", "=q3=Design: Mysterious Dreadstone", "=ds=#p12# (450)"};
				{ 4, 46937, "", "=q3=Design: Purified Dreadstone", "=ds=#p12# (450)"}; --v1
				{ 5, 46903, "", "=q3=Design: Purified Dreadstone", "=ds=#p12# (450)"}; --v2
				{ 6, 46947, "", "=q3=Design: Purified Dreadstone", "=ds=#p12# (450)"}; --v3
				{ 7, 46900, "", "=q3=Design: Purified Dreadstone", "=ds=#p12# (450)"}; --v4
				{ 8, 46939, "", "=q3=Design: Purified Dreadstone", "=ds=#p12# (450)"}; --v5
				{ 9, 46938, "", "=q3=Design: Shifting Dreadstone", "=ds=#p12# (450)"};
				{ 10, 46935, "", "=q3=Design: Sovereign Dreadstone", "=ds=#p12# (450)"};
				{ 11, 41582, "", "=q3=Design: Glinting Twilight Opal", "=ds=#p12# (390)"}; --v1
				{ 12, 41796, "", "=q3=Design: Glinting Twilight Opal", "=ds=#p12# (390)"}; --v2
				{ 13, 41785, "", "=q3=Design: Glinting Twilight Opal", "=ds=#p12# (390)"}; --v3
				{ 14, 41688, "", "=q3=Design: Veiled Twilight Opal", "=ds=#p12# (390)"};
				{ 15, 41747, "", "=q3=Design: Shifting Twilight Opal", "=ds=#p12# (390)"};
				{ 16, 46902, "", "=q3=Design: Timeless Dreadstone", "=ds=#p12# (450)"}; --v1
				{ 17, 46936, "", "=q3=Design: Timeless Dreadstone", "=ds=#p12# (450)"}; --v2
				{ 18, 46951, "", "=q3=Design: Veiled Dreadstone", "=ds=#p12# (390)"};
				{ 19, 46953, "", "=q3=Design: Etched Dreadstone", "=ds=#p12# (450)"};
				{ 20, 46956, "", "=q3=Design: Glinting Dreadstone", "=ds=#p12# (450)"}; --v1
				{ 21, 46946, "", "=q3=Design: Glinting Dreadstone", "=ds=#p12# (450)"}; --v2
				{ 22, 46945, "", "=q3=Design: Glinting Dreadstone", "=ds=#p12# (450)"}; --v3
				{ 23, 47008, "", "=q3=Design: Glinting Dreadstone", "=ds=#p12# (450)"}; --v4
				{ 24, 47010, "", "=q3=Design: Accurate Dreadstone", "=ds=#p12# (450)"};
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}


	AtlasLoot_Data["JewelcraftingDailyBlue"] = {
		["Normal"] = {
			{
				{ 1, 41580, "", "=q3=Design: Rigid Sky Sapphire", "=ds=#p12# (390)"};
				{ 2, 42138, "", "=q3=Design: Solid Sky Sapphire", "=ds=#p12# (390)"};
				{ 3, 46928, "", "=q3=Design: Rigid Majestic Zircon", "=ds=#p12# (450)"};
				{ 4, 46924, "", "=q3=Design: Solid Majestic Zircon", "=ds=#p12# (450)"};
				{ 5, 46925, "", "=q3=Design: Sparkling Majestic Zircon", "=ds=#p12# (450)"}; --v1
				{ 6, 46927, "", "=q3=Design: Sparkling Majestic Zircon", "=ds=#p12# (450)"}; --v2
				{ 7, 46926, "", "=q3=Design: Stormy Majestic Zircon", "=ds=#p12# (450)"};
				{ 8, 41581, "", "=q3=Design: Sparkling Sky Sapphire", "=ds=#p12# (420)"};
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}

	AtlasLoot_Data["JewelcraftingDailyMeta"] = {
		["Normal"] = {
			{
				{ 1, 41704, "", "=q3=Design: Chaotic Skyflare Diamond", "=ds=#p12# (420)"};
				{ 2, 41706, "", "=q3=Design: Ember Skyflare Diamond", "=ds=#p12# (420)"};
				{ 3, 41708, "", "=q3=Design: Insightful Earthsiege Diamond", "=ds=#p12# (420)"};
				{ 4, 41709, "", "=q3=Design: Invigorating Earthsiege Diamond", "=ds=#p12# (420)"};
				{ 5, 41710, "", "=q3=Design: Relentless Earthsiege Diamond", "=ds=#p12# (420)"};
				{ 6, 41707, "", "=q3=Design: Revitalizing Skyflare Diamond", "=ds=#p12# (420)"};
				{ 7, 41711, "", "=q3=Design: Trenchant Earthsiege Diamond", "=ds=#p12# (420)"};
				{ 8, 41705, "", "=q3=Design: Shielded Skyflare Diamond", "=ds=#p12# (420)"};
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}

	AtlasLoot_Data["JewelcraftingDailyDragonEye"] = {
		["Normal"] = {
			{
				{ 1, 42298, "", "=q3=Design: Bold Dragon's Eye", "=ds=#p12# (370)"};
				{ 2, 42300, "", "=q3=Design: Brilliant Dragon's Eye", "=ds=#p12# (370)"}; --v1
				{ 3, 42309, "", "=q3=Design: Brilliant Dragon's Eye", "=ds=#p12# (370)"}; --v2
				{ 4, 42301, "", "=q3=Design: Delicate Dragon's Eye", "=ds=#p12# (370)"}; --v1
				{ 5, 42299, "", "=q3=Design: Delicate Dragon's Eye", "=ds=#p12# (370)"}; --v2
				{ 6, 42302, "", "=q3=Design: Flashing Dragon's Eye", "=ds=#p12# (370)"};
				{ 7, 42305, "", "=q3=Design: Mystic Dragon's Eye", "=ds=#p12# (370)"};
				{ 8, 42306, "", "=q3=Design: Precise Dragon's Eye", "=ds=#p12# (370)"};
				{ 9, 42307, "", "=q3=Design: Quick Dragon's Eye", "=ds=#p12# (370)"};
				{ 10, 42308, "", "=q3=Design: Rigid Dragon's Eye", "=ds=#p12# (370)"};
				{ 11, 42310, "", "=q3=Design: Smooth Dragon's Eye", "=ds=#p12# (370)"}; --v1
				{ 12, 42303, "", "=q3=Design: Smooth Dragon's Eye", "=ds=#p12# (370)"}; --v2
				{ 13, 42311, "", "=q3=Design: Solid Dragon's Eye", "=ds=#p12# (370)"};
				{ 14, 42312, "", "=q3=Design: Sparkling Dragon's Eye", "=ds=#p12# (370)"}; --v1
				{ 15, 42304, "", "=q3=Design: Sparkling Dragon's Eye", "=ds=#p12# (370)"}; --v2
				{ 16, 42313, "", "=q3=Design: Stormy Dragon's Eye", "=ds=#p12# (370)"};
				{ 17, 42314, "", "=q3=Design: Subtle Dragon's Eye", "=ds=#p12# (370)"}; --v1
				{ 18, 42315, "", "=q3=Design: Subtle Dragon's Eye", "=ds=#p12# (370)"}; --v2
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}

	AtlasLoot_Data["JewelcraftingDailyNeckRing"] = {
		["Normal"] = {
			{
				{ 1, 42652, "", "=q4=Design: Titanium Earthguard Chain", "=ds=#p12# (420)"};
				{ 2, 42649, "", "=q4=Design: Titanium Earthguard Ring", "=ds=#p12# (420)"};
				{ 3, 42648, "", "=q4=Design: Titanium Impact Band", "=ds=#p12# (420)"};
				{ 4, 42651, "", "=q4=Design: Titanium Impact Choker", "=ds=#p12# (420)"};
				{ 5, 42653, "", "=q4=Design: Titanium Spellshock Necklace", "=ds=#p12# (420)"};
				{ 6, 42650, "", "=q4=Design: Titanium Spellshock Ring", "=ds=#p12# (420)"};
				{ 7, 43497, "", "=q3=Design: Savage Titanium Band", "=ds=#p12# (420)"};
				{ 8, 43485, "", "=q3=Design: Savage Titanium Ring", "=ds=#p12# (420)"};
				{ 9, 43318, "", "=q3=Design: Ring of Scarlet Shadows", "=ds=#p12# (420)"};
				{ 10, 43319, "", "=q3=Design: Windfire Band", "=ds=#p12# (420)"};
				{ 11, 43317, "", "=q3=Design: Ring of Earthen Might", "=ds=#p12# (420)"};
				{ 12, 43320, "", "=q3=Design: Ring of Northern Tears", "=ds=#p12# (420)"};
				{ 13, 43597, "", "=q4=Design: Titanium Frostguard Ring", "=ds=#p12# (420)"};
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}

	AtlasLoot_Data["JewelcraftingDailyRemoved"] = {
		["Normal"] = {
			{
				{ 1, 47010, "", "=q3=Design: Accurate Ametrine", "=ds=#p12# (450)"};
				{ 2, 46952, "", "=q3=Design: Durable Ametrine", "=ds=#p12# (450)"};
				{ 3, 47016, "", "=q3=Design: Empowered Ametrine", "=ds=#p12# (450)"};
				{ 4, 46953, "", "=q3=Design: Etched Ametrine", "=ds=#p12# (450)"};
				{ 5, 47012, "", "=q3=Design: Glimmering Ametrine", "=ds=#p12# (450)"};
				{ 6, 47008, "", "=q3=Design: Glinting Ametrine", "=ds=#p12# (450)"};
				{ 7, 46947, "", "=q3=Design: Luminous Ametrine", "=ds=#p12# (450)"};
				{ 8, 46956, "", "=q3=Design: Pristine Ametrine", "=ds=#p12# (450)"};
				{ 9, 47023, "", "=q3=Design: Stark Ametrine", "=ds=#p12# (450)"};
				{ 10, 46951, "", "=q3=Design: Veiled Ametrine", "=ds=#p12# (450)"};
				{ 11, 47011, "", "=q3=Design: Wicked Ametrine", "=ds=#p12# (450)"};
				{ 12, 41582, "", "=q3=Design: Glinting Monarch Topaz", "=ds=#p12# (390)"};
				{ 13, 41689, "", "=q3=Design: Luminous Monarch Topaz", "=ds=#p12# (390)"};
				{ 14, 41687, "", "=q3=Design: Stark Monarch Topaz", "=ds=#p12# (390)"};
				{ 15, 41688, "", "=q3=Design: Veiled Monarch Topaz", "=ds=#p12# (390)"};
				{ 16, 46900, "", "=q3=Design: Dazzling Eye of Zul", "=ds=#p12# (450)"};
				{ 17, 46897, "", "=q3=Design: Enduring Eye of Zul", "=ds=#p12# (450)"};
				{ 18, 46910, "", "=q3=Design: Intricate Eye of Zul", "=ds=#p12# (450)"};
				{ 19, 46914, "", "=q3=Design: Opaque Eye of Zul", "=ds=#p12# (450)"};
				{ 20, 46903, "", "=q3=Design: Seer's Eye of Zul", "=ds=#p12# (450)"};
				{ 21, 46907, "", "=q3=Design: Shining Eye of Zul", "=ds=#p12# (450)"};
				{ 22, 46909, "", "=q3=Design: Lambent Eye of Zul", "=ds=#p12# (450)"};
				{ 23, 46906, "", "=q3=Design: Sundered Eye of Zul", "=ds=#p12# (450)"};
				{ 24, 46908, "", "=q3=Design: Tense Eye of Zul", "=ds=#p12# (450)"};
				{ 25, 46902, "", "=q3=Design: Timeless Eye of Zul", "=ds=#p12# (450)"};
				{ 26, 46899, "", "=q3=Design: Vivid Eye of Zul", "=ds=#p12# (450)"};
				{ 27, 41697, "", "=q3=Design: Enduring Forest Emerald", "=ds=#p12# (390)"};
				{ 28, 41694, "", "=q3=Design: Intricate Forest Emerald", "=ds=#p12# (390)"};
				{ 29, 41696, "", "=q3=Design: Lambent Forest Emerald", "=ds=#p12# (390)"};
				{ 30, 41699, "", "=q3=Design: Seer's Forest Emerald", "=ds=#p12# (390)"};
			};
			{
				{ 1, 41698, "", "=q3=Design: Vivid Forest Emerald", "=ds=#p12# (390)"};
				{ 2, 46934, "", "=q3=Design: Balanced Dreadstone", "=ds=#p12# (450)"};
				{ 3, 46936, "", "=q3=Design: Glowing Dreadstone", "=ds=#p12# (450)"};
				{ 4, 46945, "", "=q3=Design: Infused Dreadstone", "=ds=#p12# (450)"};
				{ 5, 46944, "", "=q3=Design: Puissant Dreadstone", "=ds=#p12# (450)"};
				{ 6, 46940, "", "=q3=Design: Regal Dreadstone", "=ds=#p12# (450)"};
				{ 7, 46939, "", "=q3=Design: Royal Dreadstone", "=ds=#p12# (450)"};
				{ 8, 46946, "", "=q3=Design: Tenuous Dreadstone", "=ds=#p12# (450)"};
				{ 9, 41702, "", "=q3=Design: Puissant Twilight Opal", "=ds=#p12# (390)"};
				{ 10, 41703, "", "=q3=Design: Regal Twilight Opal", "=ds=#p12# (390)"};
				{ 11, 41701, "", "=q3=Design: Royal Twilight Opal", "=ds=#p12# (390)"};
				{ 12, 46927, "", "=q3=Design: Lustrous Majestic Zircon", "=ds=#p12# (450)"};
				{ 13, 41581, "", "=q3=Design: Lustrous Sky Sapphire", "=ds=#p12# (390)"};
				{ 14, 41705, "", "=q3=Design: Effulgent Skyflare Diamond", "=ds=#p12# (420)"};
				{ 15, 42299, "", "=q3=Design: Bright Dragon's Eye", "=ds=#p12# (370)"};
				{ 16, 42303, "", "=q3=Design: Fractured Dragon's Eye", "=ds=#p12# (370)"};
				{ 17, 42304, "", "=q3=Design: Lustrous Dragon's Eye", "=ds=#p12# (370)"};
				{ 18, 42309, "", "=q3=Design: Runed Dragon's Eye", "=ds=#p12# (370)"};
				{ 19, 42315, "", "=q3=Design: Thick Dragon's Eye", "=ds=#p12# (370)"};
			};
		};
		info = {
			name = AL["Jewelcrafting Daily"],
			module = moduleName, menu = "JEWELCRAFTINGDAILYMENU",
		};
	}