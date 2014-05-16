-- $Id: constants.en.lua 4266 2013-09-16 21:21:07Z Dynaletik $
--[[
constants.en.lua
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.

The AL["text"] = true; shortcut can ONLY be used for English (the root translation).

Before adding a new string, check first if it can be acquired from GetItemInfo, GetSpellInfo or GetAchievementCriteriaInfo.
Also check if it should be added instead to one of the Babble libraries we use.
]]

	-- Table holding all loot tables is initialised here as it loads early
	AtlasLoot_Data = {};
	AtlasLoot_TableNames = {};

	-- Create the library instance
	local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

	local AL = AceLocale:NewLocale("AtlasLoot", "enUS", true);

-- Register translations
if AL then

	-- #########
	-- UI things
	-- #########
	-- compare frame
	AL["Compare Frame"] = true;
	AL["Show in Compare Frame"] = true;
	AL["Name"] = true;
	AL["ItemLvl"] = true;
	AL["Normal"] = true;
	AL["%d items"] = true;
	AL["All"] = true;
	AL["Stats"] = true;
	AL["Show \"Base Stats list\""] = true;
	AL["Show \"Extra Stats list\""] = true;
	AL["Base Stats list"] = true;
	AL["Extra Stats list"] = true;	
	AL["Add Stats list"] = true;
	AL["Are you sure you want to delete Sort list |cff1eff00%s|r?"] = true;
	AL["Delete Stats list"] = true;
	AL["Stats color"] = true;
	AL["Stats list name:"] = true;
	AL["Select Stats list"] = true;
	AL["You cant set more then %d item stats."] = true;
	AL["Slot"] = true;
	AL["AtlasLoot has detected some corrupted items on your Wishlist. You can now run an automatic check to fix it. Please be aware that this could take a few moments."] = true;
	AL["BonusRoll:"] = true;
	AL["|cffFF0000Shift+Click: |cffFFFFFFOpen filter configuration"] = true;

	-- Stats short
	AL["iLvl"] = true;	-- Item lvl
	AL["str"] = true;	-- Strength
	AL["agi"] = true;	-- Agility
	AL["sta"] = true;	-- Stamina
	AL["int"] = true;	-- Intellect
	AL["spi"] = true;	-- Spirit
	AL["Crit"] = true;	-- Crit Rating
	AL["Dodge"] = true;	-- Dodge Rating
	AL["Exp"] = true;	-- Expertise Rating
	AL["Hit"] = true;	-- Hit Rating
	AL["Haste"] = true;	-- Haste Rating
	AL["Parry"] = true;	-- Parry Rating
	AL["Spell"] = true;	-- Spell Power
	AL["Resi"] = true;	-- Resilience Rating
	AL["Mast"] = true;	-- Mastery

	-- Stats
	AL["Resilience Rating"] = true;
	AL["Base Stats"] = true;
	AL["Extra Stats"] = true;

	-- Loader
	AL["Load AtlasLoot"] = true;
	AL["Module \"%s\" is disabled."] = true;
	AL["Module \"%s\" is missing."] = true;

	-- MiniMap-Button
	AL["|cffFF0000Click: |cffFFFFFFOpen AtlasLoot\n|cffFF0000Shift+Click: |cffFFFFFFOpen AtlasLoot-Options "] = true;

	-- AtlasLootFu 
	AL["AtlasLootFu is no longer in use.\nDelete it from your AddOns folder"] = true;

	-- Atlas Incompatible
	AL["Please note that AtlasLoot v%s is only compatible with Atlas v%s. AtlasLoot detected that you have an older Atlas version installed and thus Atlas integration was disabled."] = true;

	-- Options
	AL["Options"] = true;
	AL["Load Loot Modules at Startup"] = true;
	AL["Toggle Minimap Button"] = true;
	AL["Toggles the display of the minimap icon"] = true;
	AL["Show itemIDs"] = true;
	AL["Show Droprates"] = true;
	AL["Safe Chat Links"] = true;
	AL["Comparison Tooltips"] = true;
	AL["Show Boss Tooltip"] = true;
	AL["Show Comparison Tooltips"] = true;
	AL["Opaque"] = true;
	AL["Make Loot Table Opaque"] = true;
	AL["Treat Crafted Items:"] = true;
	AL["As Crafting Spells"] = true;
	AL["As Items"] = true;
	AL["Reset"] = true;
	AL["Reset Frames"] = true;
	AL["Profiles"] = true;
	AL["Item Buttons"] = true;
	AL["Loot Table"] = true;
	AL["Enable mouse on item descriptions"] = true;
	AL["Upgrade Level:"] = true;
	AL["Show BonusRoll info"] = true;
	AL["Shows if a item is available with bonus roll or raid finder loot."] = true;

	-- Default Frame
	AL["Default Frame"] = true;
	AL["Scale:"] = true;
	AL["Alpha:"] = true;
	AL["Only change alpha on leave frame"] = true;

	-- Bindings
	AL["Toggle AtlasLoot"] = true;

	-- Help
	AL["Help"] = true;
	AL["AtlasLoot Help"] = true;
	AL["For further help, see our website and forums: "] = true;
	AL["How to open the standalone Loot Browser:"] = true;
	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = true;
	AL["How to view an 'unsafe' item:"] = true;
	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = true;
	AL["How to view an item in the Dressing Room:"] = true;
	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = true;
	AL["How to link an item to someone else:"] = true;
	AL["Shift+Left Click the item like you would for any other in-game item"] = true;
	AL["How to add an item to the wishlist:"] = true;
	AL["Alt+Left Click any item to add it to the wishlist."] = true;
	AL["How to delete an item from the wishlist:"] = true;
	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = true;
	AL["What else does the wishlist do?"] = true;
	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = true;
	AL["HELP!! I have broken the mod somehow!"] = true;
	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = true;

	-- LootButtons
	-- Tooltips
	AL["ItemID:"] = true;
	AL["Drop Rate: "] = true;
	AL["DKP"] = true;
	AL["Priority:"] = true;
	AL["Show price and slot if possible"] = true;
	AL["Show wishlist items in bosses tooltip"] = true;
	AL["Use GameTooltip"] = true;
	AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"] = true;
	AL["%d / %d ( Bank: %d )"] = true;
	-- Unsafe Item
	AL["Item Unavailable"] = true;
	AL["|cff0070ddItemID: %d |r\nThis item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world.\n\nYou can right-click to attempt to query the server.  You may be disconnected."] = true;
	-- Heriloom Config Window
	AL["Heirloom preview"] = true;
	AL["Change level:"] = true;
	AL["Shift + Right Click to select character level"] = true;	

	-- LootTableSort
	AL["Sort by Instance"] = true;
	AL["Sort loottable by Instance"] = true;
	AL["Sort by Boss"] = true;
	AL["Sort loottable by Boss"] = true;
	AL["Item Name"] = true;
	AL["Item Slot"] = true;
	AL["Item Quality"] = true;

	-- Wishlist
	AL["Wishlist"] = true;
	AL["Wishlists"] = true;
	AL["Own"] = true;
	AL["Other"] = true;
	AL["Shared"] = true;
	AL["Wishlist name:"] = true;
	AL["Delete"] = true;
	AL["Share"] = true;
	AL["Send Wishlist (%s) to"] = true;
	AL["Send"] = true;
	AL[" added to the WishList."] = true;
	AL[" already in the WishList!"] = true;
	AL[" deleted from the WishList."] = true;
	AL["Are you sure you want to delete Wishlist |cff1eff00%s|r?"] = true;
	AL["default"] = true;
	AL[" |cff999999<default>"] = true;
	AL["Use as default wishlist"] = true;
	AL["Add Wishlist"] = true;
	AL["Always use default Wishlist"] = true;
	AL["Save wishlists at character DB"] = true;
	AL["Saves the wishlists only for |cff1eff00%s-%s|r.\n Other characters cant view the wishlists, but the memory usage is reduced."] = true;
	AL["Table Sort"] = true;
	AL["Table Sort:"] = true;
	AL["Item Sort:"] = true;
	AL["Show own wishlists"] = true;
	AL["Show all wishlists"] = true;

	-- Filter
	AL["Filter"] = true;
	AL["Select All Loot"] = true;
	AL["Apply Filter:"] = true;
	AL["Melee weapons"] = true;
	AL["Ranged weapons"] = true;
	AL["Other"] = true;
	AL["Itemslot"] = true;
	AL["Shift + Click on the Filter button opens the config page."] = true;

	-- Panel
	AL["Hide Panel"] = true;
	AL["Toggle AL Panel"] = true;
	AL["Buttons"] = true;

	-- Buttons
	AL["Collections"] = true;
	AL["Crafting"] = true;
	AL["Factions"] = true;
	AL["Load Modules"] = true;
	AL["PvP Rewards"] = true;
	AL["World Events"] = true;

	-- QuickLooks
	AL["QuickLook"] = true;
	AL["QuickLooks"] = true;
	AL["Number of QuickLooks:"] = true;
	AL["Add to QuickLooks:"] = true;
	AL["Reset Quicklooks"] = true;
	AL["Assign this loot table\n to QuickLook"] = true;
	AL["Show unused QuickLooks in the Panel"] = true;
	AL["Shows unused QuickLooks as grey buttons in the AtlasLoot Panel"] = true;
	-- Single options
	AL["unused"] = true;
	AL["QuickLook name:"] = true;
	AL["Use Boss name"] = true;
	AL["Use Instance name"] = true;
	AL["Delete"] = true;
	AL["Lock"] = true;
	AL["Enable"] = true;

	-- Query Server / Query all
	AL["Query Server"] = true;
	AL["Queries the server for all items \non this page. The items will be \nrefreshed when you next mouse \nover them."] = true;

	-- Atlas
	AL["Click boss name to view loot."] = true;

	-- LootTable
	-- title
	AL["Heroic"] = true;
	AL["25 Man"] = true;
	AL["25 Man Heroic"] = true;
	-- buttons
	AL["Show 10 Man Loot"] = true;
	AL["Show 25 Man Loot"] = true;
	AL["Show Slot"] = true;
	AL["Show Price"] = true;
	AL["Skill"] = true;
	AL["Location"] = true;

	-- #######################################
	-- UI things END
	-- #######################################

	-- Text strings for UI objects
	AL["AtlasLoot"] = true;
	AL["Select Loot Table"] = true;
	AL["Select Sub-Table"] = true;
	AL["Various Locations"] = true;
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = true;
	AL["Back"] = true;
	AL["Level 60"] = true;
	AL["Level 70"] = true;
	AL["Level 80"] = true;
	AL["Level 85"] = true;
	AL["Level 90"] = true;
	AL["|cffff0000(unsafe)"] = true;
	AL["Misc"] = true;
	AL["Rewards"] = true;
	AL["Choose Table ..."] = true;
	AL["Unknown"] = true;
	AL["Reset Wishlist"] = true;
	AL["Select a Loot Table..."] = true;
	AL["OR"] = true;
	AL["FuBar Options"] = true;
	AL["Attach to Minimap"] = true;
	AL["Hide FuBar Plugin"] = true;
	AL["Show FuBar Plugin"] = true;
	AL["Position:"] = true;
	AL["Left"] = true;
	AL["Center"] = true;
	AL["Right"] = true;
	AL["Hide Text"] = true;
	AL["Hide Icon"] = true;
	AL["Minimap Button Options"] = true;

	-- Text for Options Panel
	AL["Atlasloot Options"] = true;
	AL["Default Tooltips"] = true;
	AL["Lootlink Tooltips"] = true;
	AL["|cff9d9d9dLootlink Tooltips|r"] = true;
	AL["ItemSync Tooltips"] = true;
	AL["|cff9d9d9dItemSync Tooltips|r"] = true;
	AL["Use EquipCompare"] = true;
	AL["|cff9d9d9dUse EquipCompare|r"] = true;
	AL["Show itemIDs at all times"] = true;
	AL["Hide AtlasLoot Panel"] = true;
	AL["Show Basic Minimap Button"] = true;
	AL["|cff9d9d9dShow Basic Minimap Button|r"] = true;
	AL["Set Minimap Button Position"] = true;
	AL["Notify on LoD Module Load"] = true;
	AL["Loot Browser Scale: "] = true;
	AL["Button Position: "] = true;
	AL["Button Radius: "] = true;
	AL["Done"] = true;
	AL["FuBar Toggle"] = true;
	AL["Search Result: %s"] = true;
	AL["Search on"] = true;
	AL["All modules"] = true;
	AL["If checked, AtlasLoot will load and search across all the modules."] = true;
	AL["Search options"] = true;
	AL["Partial matching"] = true;
	AL["If checked, AtlasLoot search item names for a partial match."] = true;
	AL["You don't have any module selected to search on!"] = true;
	AL["Panel"] = true;

	-- Slash commands
	AL["reset"] = true;
	AL["options"] = true;
	AL["Reset complete!"] = true;

	-- AtlasLoot Panel - Search
	AL["Clear"] = true;
	AL["Last Result"] = true;
	AL["Search"] = true;

	-- Crafting Menu
	AL["Crafting Daily Quests"] = true;
	AL["Cooking Daily"] = true;
	AL["Fishing Daily"] = true;
	AL["Jewelcrafting Daily"] = true;
	AL["Crafted Sets"] = true;
	AL["Crafted Epic Weapons"] = true;
	AL["Dragon's Eye"] = true;
	AL["Chimera's Eye"] = true;
	AL["Serpent's Eye"] = true;

	-- Sets/Collections Menu
	AL["Sets"] = true;
	AL["Set"] = true;
	AL["Justice Points"] = true;
	AL["Valor Points"] = true;
	AL["BoE World Epics"] = true;
	AL["Legendary Items"] = true;
	AL["Misc Sets"] = true;
	AL["Tier Sets"] = true;
	AL["Tier 1/2 Set"] = true;
	AL["Tier 1/2/3 Set"] = true;
	AL["Tier 3 Set"] = true;
	AL["Tier 4/5/6 Set"] = true;
	AL["Tier 7/8 Set"] = true;
	AL["Tier 9 Set"] = true;
	AL["Tier 10 Set"] = true;
	AL["Tier 11/12 Set"] = true;
	AL["Tier 13 Set"] = true;
	AL["Tier 14 Set"] = true;
	AL["Tier 15 Set"] = true;
	AL["Tier 16 Set"] = true;
	AL["TCG Items"] = true; -- Trading Card Game Items
	AL["Rare Mobs"] = true;
	AL["Grand Marshal"] = true;
	AL["Gladiator"] = true;
	AL["Vengeful"] = true;
	AL["Merciless"] = true;
	AL["Brutal"] = true;
	AL["Wrathful"] = true;
	AL["Cataclysmic"] = true;
	AL["ilvl %d"] = true; -- usage: string.format(AL["ilvl %d"], 522)

	-- PvP Menu
	AL["Arathi Basin Sets"] = true;
	AL["PvP Accessories"] = true;
	AL["PvP Armor Sets"] = true;
	AL["PvP Weapons"] = true;
	AL["PvP Non-Set Epics"] = true;
	AL["PvP Reputation Sets"] = true;
	AL["PvP Misc"] = true;
	AL["PVP Gems/Enchants/Jewelcrafting Designs"] = true;
	AL["PvP Trinkets"] = true;

	-- World Events
	AL["Abyssal Council"] = true;
	AL["Argent Tournament"] = true;
	AL["Bash'ir Landing Skyguard Raid"] = true;
	AL["Brewfest"] = true;
	AL["Children's Week"] = true;
	AL["Day of the Dead"] = true;
	AL["Ethereum Prison"] = true;
	AL["Feast of Winter Veil"] = true;
	AL["Gurubashi Arena Booty Run"] = true;
	AL["Hallow's End"] = true;
	AL["Harvest Festival"] = true;
	AL["Love is in the Air"] = true;
	AL["Lunar Festival"] = true;
	AL["Midsummer Fire Festival"] = true;
	AL["Noblegarden"] = true;
	AL["Pilgrim's Bounty"] = true;
	AL["Skettis"] = true;
	AL["Stranglethorn Fishing Extravaganza"] = true;
	AL["Kalu'ak Fishing Derby"] = true;
	AL["Fishing Contests"] = true;

	-- World Events	Menu Names
	AL["Special Rewards"] = true; 			-- Brewfest, Feast of Winter Veil
	AL["Brew of the Month Club"] = true; 	-- Brewfest
	AL["Food and Drinks"] = true; 			-- Brewfest
	AL["Gifts & Presents"] = true; 			-- Feast of Winter Veil
	AL["Playable Race Masks"] = true; 		-- Hallow's End
	AL["Non-Playable Race Masks"] = true; 	-- Hallow's End
	AL["Schematics & Patterns"] = true; 	-- Lunar Festival
	AL["Toys"] = true; 						-- Darkmoon Faire

	-- Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = true;
	AL["|cffff0000Right-Click|r View Options"] = true;
	AL["|cffff0000Shift-Click|r View Options"] = true;
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = true;
	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = true;

	-- Default Frame
	AL["Select Module"] = true;
	AL["Select Instance"] = true;

	-- Wishlist
	AL["Close"] = true;
	AL["Own Wishlists"] = true;
	AL["Other Wishlists"] = true;
	AL["Shared Wishlists"] = true;
	AL["Mark items in loot tables"] = true;
	AL["Mark items from own Wishlist"] = true;
	AL["Mark items from all Wishlists"] = true;
	AL["Enable Wishlist Sharing"] = true;
	AL["Auto reject in combat"] = true;
	AL["Edit Wishlist"] = true;
	AL["Show More Icons"] = true;
	AL["Edit"] = true;
	AL["Show all Wishlists"] = true;
	AL["Show own Wishlists"] = true;
	AL["Show shared Wishlists"] = true;
	AL["You must wait "] = true;
	AL[" seconds before you can send a new Wishlist to "] = true;
	AL["Cancel"] = true;
	AL["Delete Wishlist %s?"] = true;
	AL["%s sends you a Wishlist. Accept?"] = true;
	AL[" tried to send you a Wishlist. Rejected because you are in combat."] = true;
	AL[" rejects your Wishlist."] = true;
	AL["You can't send Wishlists to yourself"] = true;
	AL["Please set a default Wishlist."] = true;
	AL["Set as default Wishlist"] = true;

	-- Misc Inventory related words
	AL["Scope"] = true;
	AL["Darkmoon Faire Card"] = true;
	AL["Banner"] = true;
	AL["Set"] = true;
	AL["Token"] = true;
	AL["Combat Pet"] = true;
	AL["Fireworks"] = true;
	AL["Transformation Item"] = true;
	AL["Keys"] = true;

	-- Extra inventory stuff
	AL["Cloak"] = true;

	-- Alchemy
	AL["Battle Elixirs"] = true;
	AL["Cauldron"] = true;
	AL["Cauldrons"] = true;
	AL["Guardian Elixirs"] = true;
	AL["Oils"] = true;
	AL["Other Elixirs"] = true;
	AL["Potions"] = true;
	AL["Transmutes"] = true;
	AL["Flasks"] = true;

	-- Blacksmithing
	AL["Armor Enhancements"] = true;
	AL["Weapon Enhancements"] = true;
	AL["Cataclysm Vendor Sold Plans"] = true;
	AL["Mists of Pandaria Vendor Sold Plans"] = true;
	AL["Training Projects"] = true;

	-- Cooking
	AL["Banquets/Feasts"] = true;

	-- Enchanting
	AL["Enchant Boots"] = true;
	AL["Enchant Bracer"] = true;
	AL["Enchant Chest"] = true;
	AL["Enchant Cloak"] = true;
	AL["Enchant Gloves"] = true;
	AL["Enchant Ring"] = true;
	AL["Enchant Shield & Off-Hand"] = true;
	AL["Enchant 2H Weapon"] = true;
	AL["Enchant Weapon"] = true;
	AL["Cataclysm Vendor Sold Formulas"] = true;

	-- Engineering
	AL["Tinker"] = true;

	-- Fishing
	AL["Fish Weapons"] = true;
	AL["Fishing Gear"] = true;
	AL["Fishing Lines"] = true;

	-- Inscription
	AL["Major Glyph"] = true;
	AL["Minor Glyph"] = true;
	AL["Runescrolls"] = true;
	AL["Recall"] = true;
	AL["Scrolls"] = true;
	AL["Off-Hand Items"] = true;
	AL["Shoulder Enchants"] = true;
	AL["Reagents"] = true;

	-- Leatherworking
	AL["Leather Armor"] = true;
	AL["Mail Armor"] = true;
	AL["Cloaks"] = true;
	AL["Item Enhancements"] = true;
	AL["Drums, Bags and Misc."] = true;

	-- Tailoring
	AL["Shirts"] = true;
	AL["Bags"] = true;
	AL["Cataclysm Vendor Sold Patterns"] = true;
	AL["Mists of Pandaria Vendor Sold Patterns"] = true;

	-- Labels for loot descriptions
	AL["Classes:"] = true;
	AL["This Item Begins a Quest"] = true;
	AL["Quest Item"] = true;
	AL["Old Quest Item"] = true;
	AL["Quest Reward"] = true;
	AL["Old Quest Reward"] = true;
	AL["Shared"] = true;
	AL["Right Half"] = true;
	AL["Left Half"] = true;
	AL["Currency"] = true;
	AL["Used to summon boss"] = true;
	AL["Tradable for sunmote + item above"] = true;
	AL["Card Game Item"] = true;
	AL["Skill Required:"] = true;
	AL["Rating:"] = true; -- Shorthand for 'Required Rating' for the personal/team ratings
	AL["Random Heroic Reward"] = true;
	AL["Fishing Daily Reward"] = true;
	AL["Collector's Edition"] = true;
	AL["Daily Reward"] = true;
	AL["No Longer Available"] = true;
	AL["Shared Boss Loot"] = true;
	AL["Shared Zone Loot"] = true;
	AL["Black Market Auction House"] = true;

	-- Minor Labels for loot table descriptions
	AL["Classic WoW"] = true;
	AL["Burning Crusade"] = true;
	AL["Wrath of the Lich King"] = true;
	AL["Cataclysm"] = true;
	AL["Mists of Pandaria"] = true;
	AL["Entrance"] = true;
	AL["Dungeon Set 1"] = true;
	AL["Dungeon Set 2"] = true;
	AL["Dungeon Set 1/2"] = true;
	AL["Replica"] = true;
	AL["Dungeon Set 3"] = true;
	AL["Dungeon Set 4"] = true;
	AL["Tier %d"] = true; -- usage: string.format(AL["Tier %d"], 1)
	AL["Challenge Mode Armor Sets"] = true;
	AL["10 Man"] = true;
	AL["10/25 Man"] = true;
	AL["Epic Set"] = true;
	AL["Rare Set"] = true;
	AL["Season %d"] = true; -- usage: string.format(AL["Season %d"], 6)
	AL["Fire"] = true;
	AL["Water"] = true;
	AL["Wind"] = true;
	AL["Earth"] = true;
	AL["Master Angler"] = true;
	AL["Fire Resistance Gear"] = true;
	AL["Arcane Resistance Gear"] = true;
	AL["Nature Resistance Gear"] = true;
	AL["Frost Resistance Gear"] = true;
	AL["Shadow Resistance Gear"] = true;

	-- Labels for loot table sections
	AL["Additional Heroic Loot"] = true;
	AL["Heroic Mode"] = true;
	AL["Normal Mode"] = true;
	AL["Hard Mode"] = true;
	AL["Bonus Loot"] = true;
	AL["Arena Reward"] = true;
	AL["Achievement Reward"] = true;
	AL["Phase 1"] = true;
	AL["Phase 2"] = true;
	AL["Phase 3"] = true;
	AL["First Prize"] = true;
	AL["Rare Fish Rewards"] = true;
	AL["Rare Fish"] = true;
	AL["Weapons"] = true;
	AL["Accessories"] = true;
	AL["Rare"] = true;
	AL["Specializations"] = true;
	AL["Flexible"] = true;
	AL["Raid Finder"] = true;
	AL["Thunderforged"] = true;
	AL["Warforged"] = true;
	AL["Pandaria World Bosses"] = true;
	AL["Elite"] = true;
	AL["Vegetables"] = true;

	-- Loot Table Names
	AL["Level %s"] = true; -- usage: string.format(AL["Level %s"], "85-89")
	AL["Summon"] = true;
	AL["Random"] = true;

	-- Profession descriptions
	AL["Buff"] = true;
	AL["Agility"] = true;
	AL["Attributes"] = true;
	AL["Intellect"] = true;
	AL["Strength"] = true;
	AL["Spirit"] = true;
	AL["Stamina"] = true;
	AL["Spell Power"] = true;
	AL["Attack Power"] = true;
	AL["Spell/Attack Power"] = true;
	AL["Hit Rating"] = true;
	AL["Crit Rating"] = true;
	AL["Haste Rating"] = true;
	AL["Dodge Rating"] = true;
	AL["Expertise Rating"] = true;
	AL["Mastery Rating"] = true;
	AL["Parry Rating"] = true;
	AL["Other Ratings"] = true;
	AL["Ratings"] = true;
	AL["Damage Absorption"] = true;
	AL["Health / Second"] = true;
	AL["Mana / Second"] = true;
	AL["Tracking"] = true;
	AL["Emotions"] = true;
	AL["Alcohol"] = true;
	AL["Health"] = true;
	AL["Mana"] = true;
	AL["Health and Mana"] = true;
	AL["Other Buffs"] = true;
	AL["Other"] = true;
	AL["Standard Buffs"] = true;
	AL["Food without Buffs"] = true;
	AL["Special"] = true;
	AL["Feasts"] = true;
	AL["Speed"] = true;
	AL["Oil"] = true; -- Used in categorizing Enchating Misc, ex: Superior Wizard Oil, Wizard Oil
	AL["Culture"] = true;
	AL["Description"] = true;
	AL["Draenei"] = true;
	AL["Dwarf"] = true;
	AL["Fossil"] = true;
	AL["Mantid"] = true;
	AL["Mogu"] = true;
	AL["Nerubian"] = true;
	AL["Night Elf"] = true;
	AL["Orc"] = true;
	AL["Pandaren"] = true;
	AL["Tol'vir"] = true;
	AL["Troll"] = true;
	AL["Vrykul"] = true;
	AL["Stats"] = true;
	AL["Resilience"] = true;
	AL["Professions"] = true;
	AL["Damage"] = true;
	AL["Proc"] = true;

	-- Extra Text in Boss lists
	AL["AQ20 Class Sets"] = true;
	AL["AQ Enchants"] = true;
	AL["AQ40 Class Sets"] = true;
	AL["AQ Opening Quest Chain"] = true;
	AL["Tribute Run"] = true;
	AL["Dire Maul Books"] = true;
	AL["Random Boss Loot"] = true;
	AL["Formula/Patterns/Plans"] = true;
	AL["BRD Blacksmithing Plans"] = true;
	AL["Patterns/Plans"] = true;

	-- General titles
	AL["Achievement"] = true;
	AL["Dungeon"] = true;
	AL["Outdoor"] = true;
	AL["Promotional"] = true;
	AL["PvP"] = true;
	AL["Raid"] = true;

	-- Companions
	AL["Achievement Companions"] = true;
	AL["Faction Companions"] = true;
	AL["Card Game Companions"] = true;
	AL["Companion Accessories"] = true;
	AL["Blizzard Store"] = true;
	AL["Crafted Companions"] = true;
	AL["Dungeon/Raid"] = true;
	AL["Faction"] = true;
	AL["Merchant Sold Companions"] = true;
	AL["Pets"] = true;
	AL["Promotional Companions"] = true;
	AL["Quest Reward Companions"] = true;
	AL["Rare Companions"] = true;
	AL["Unobtainable Companions"] = true;
	AL["New Companions"] = true;
	--- Drop Locations
	AL["Bogflare Needler"] = true;
	AL["Deviate Ravager/Deviate Guardian"] = true;
	AL["Gundrak Raptor"] = true;
	AL["Noxious Whelp"] = true;

	-- Mounts
	AL["Alliance Mounts"] = true;
	AL["Horde Mounts"] = true;
	AL["Flying Mounts"] = true;
	AL["Card Game Mounts"] = true;
	AL["Crafted Mounts"] = true;
	AL["Event Mounts"] = true;
	AL["Neutral Faction Mounts"] = true;
	AL["PvP Mounts"] = true;
	AL["Alliance PvP Mounts"] = true;
	AL["Horde PvP Mounts"] = true;
	AL["Halaa PvP Mounts"] = true;
	AL["Promotional Mounts"] = true;
	AL["Rare Mounts"] = true;
	AL["Unobtainable Mounts"] = true;
	AL["New Mounts"] = true;
	AL["Mount Collecting"] = true;

	-- Tabards
	AL["Achievement & Quest Reward Tabards"] = true;
	AL["Alliance Tabards"] = true;
	AL["Card Game Tabards"] = true;
	AL["Horde Tabards"] = true;
	AL["Neutral Faction Tabards"] = true;
	AL["PvP Tabards"] = true;
	AL["Unobtainable Tabards"] = true;

	-- Transformation Items
	AL["Transformation Items"] = true;
	AL["Additional Effects Transformation Items"] = true;
	AL["Consumable Transformation Items"] = true;
	AL["Non-consumed Transformation Items"] = true;

	-- Heirloom and BoA Items
	AL["Heirloom"] = true;
	AL["PvP Heirlooms"] = true;
	AL["Bind on Account"] = true;
	AL["Bind on Account Armor"] = true;
	AL["Bind on Account Weapons"] = true;

	-- Darkmoon Faire
	AL["Darkmoon Faire Rewards"] = true;
	AL["Low Level Decks"] = true;
	AL["Level 60 & 70 Trinkets"] = true;
	AL["Trinkets"] = true;

	-- Card Game Decks and descriptions
	AL["Loot Card Items"] = true;
	AL["UDE Items"] = true;

	-- First set
	AL["Heroes of Azeroth"] = true;
	AL["Landro Longshot"] = true;
	AL["Thunderhead Hippogryph"] = true;
	AL["Saltwater Snapjaw"] = true;

	-- Second set
	AL["Through The Dark Portal"] = true;
	AL["King Mukla"] = true;
	AL["Rest and Relaxation"] = true;
	AL["Fortune Telling"] = true;

	-- Third set
	AL["Fires of Outland"] = true;
	AL["Spectral Tiger"] = true;
	AL["Gone Fishin'"] = true;
	AL["Goblin Gumbo"] = true;

	-- Fourth set
	AL["March of the Legion"] = true;
	AL["Kiting"] = true;
	AL["Robotic Homing Chicken"] = true;
	AL["Paper Airplane"] = true;

	-- Fifth set
	AL["Servants of the Betrayer"] = true;
	AL["X-51 Nether-Rocket"] = true;
	AL["Personal Weather Machine"] = true;
	AL["Papa Hummel's Old-fashioned Pet Biscuit"] = true;

	-- Sixth set
	AL["Hunt for Illidan"] = true;
	AL["The Footsteps of Illidan"] = true;
	AL["Disco Inferno!"] = true;
	AL["Ethereal Plunderer"] = true;

	-- Seventh set
	AL["Drums of War"] = true;
	AL["The Red Bearon"] = true;
	AL["Owned!"] = true;
	AL["Slashdance"] = true;

	-- Eighth set
	AL["Blood of Gladiators"] = true;
	AL["Sandbox Tiger"] = true;
	AL["Center of Attention"] = true;
	AL["Foam Sword Rack"] = true;

	-- Ninth set
	AL["Fields of Honor"] = true;
	AL["Path of Cenarius"] = true;
	AL["Pinata"] = true;
	AL["El Pollo Grande"] = true;

	-- Tenth set
	AL["Scourgewar"] = true;
	AL["Tiny"] = true;
	AL["Tuskarr Kite"] = true;
	AL["Spectral Kitten"] = true;

	-- Eleventh set
	AL["Wrathgate"] = true;
	AL["Statue Generator"] = true;
	AL["Landro's Gift"] = true;
	AL["Blazing Hippogryph"] = true;

	-- Twelvth set
	AL["Icecrown"] = true;
	AL["Wooly White Rhino"] = true;
	AL["Ethereal Portal"] = true;
	AL["Paint Bomb"] = true;

	-- Thirtheenth set
	AL["Worldbreaker"] = true;
	AL["Mottled Drake"] = true;
	AL["Grim Campfire"] = true;
	AL["Landro's Lil' XT"] = true;

	-- Fourteenth set
	AL["War of the Elements"] = true;

	-- Fifteenth set
	AL["Twilight of the Dragons"] = true;

	-- Seventeenth set
	AL["Crown of Heaven"] = true;

	-- Eighteenth set
	AL["Tomb of the Forgotten"] = true;

	-- Nineteenth set
	AL["War of the Ancients"] = true;

	-- Twentieth set
	AL["Betrayal of the Guardian"] = true;

	-- Battleground Brackets
	AL["Old PvP Rewards"] = true;
	AL["BG/Open PvP Rewards"] = true;
	AL["Misc. Rewards"] = true;
	AL["Level %s Rewards"] = true; -- usage: string.format(AL["Level %s Rewards"], "60")

	-- Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = true;
	AL["Path of the Invoker"] = true;
	AL["Path of the Protector"] = true;

	-- Violet Eye Paths
	AL["Path of the Violet Protector"] = true;
	AL["Path of the Violet Mage"] = true;
	AL["Path of the Violet Assassin"] = true;
	AL["Path of the Violet Restorer"] = true;

	-- Ashen Verdict Paths
	AL["Path of Courage"] = true;
	AL["Path of Destruction"] = true;
	AL["Path of Vengeance"] = true;
	AL["Path of Wisdom"] = true;

	-- AQ Opening Event
	AL["Red Scepter Shard"] = true;
	AL["Blue Scepter Shard"] = true;
	AL["Green Scepter Shard"] = true;
	AL["Scepter of the Shifting Sands"] = true;

	-- World PvP
	AL["Hellfire Fortifications"] = true;
	AL["Twin Spire Ruins"] = true;
	AL["Spirit Towers"] = true;
	AL["Halaa"] = true;
	AL["Venture Bay"] = true;

	-- Karazhan Opera Event Headings
	AL["Wizard of Oz"] = true;
	AL["Red Riding Hood"] = true;

	-- Karazhan Animal Boss Types
	AL["Spider"] = true;
	AL["Darkhound"] = true;
	AL["Bat"] = true;

	-- AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = true;
	AL["Qiraji Martial Drape"] = true;
	AL["Qiraji Magisterial Ring"] = true;
	AL["Qiraji Ceremonial Ring"] = true;
	AL["Qiraji Regal Drape"] = true;
	AL["Qiraji Spiked Hilt"] = true;

	-- AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = true;
	AL["Qiraji Bindings of Command"] = true;
	AL["Vek'nilash's Circlet"] = true;
	AL["Vek'lor's Diadem"] = true;
	AL["Ouro's Intact Hide"] = true;
	AL["Skin of the Great Sandworm"] = true;
	AL["Husk of the Old God"] = true;
	AL["Carapace of the Old God"] = true;

	-- Faction related strings
	AL["Neutral"] = true;
	AL["Friendly"] = true;
	AL["Honored"] = true;
	AL["Revered"] = true;
	AL["Exalted"] = true;
	AL["Best Friend"] = true;
	AL["Rank %d"] = true; -- usage: string.format(AL["Rank %d"], 1)
	AL["Winterfin Retreat"] = true;

	-- Recipe origin strings
	AL["Crafted"] = true;
	AL["Discovery"] = true;
	AL["Drop"] = true;
	AL["Fished From"] = true;
	AL["Trainer"] = true;
	AL["Vendor"] = true;	
	AL["World Drop"] = true;

	-- Specs
	AL["Tanking"] = true;
	AL["DPS"] = true;

	-- NPCs missing from BabbleBoss
	AL["Trash Mobs"] = true;
	--- Classic WoW
	AL["Dungeon Set 2 Summonable"] = true;
	AL["Theldren"] = true; --- If still in game needs to be moved to BabbleBoss
	AL["Sothos and Jarien"] = true; --- If still in game needs to be moved to BabbleBoss
	AL["Druid of the Fang"] = true;
	AL["Defias Strip Miner"] = true;
	AL["Defias Overseer/Taskmaster"] = true;
	AL["Scarlet Trainee"] = true; --- mob removed from game
	AL["Shadowforge Flame Keeper"] = true;
	AL["Crimson Sorcerer"] = true; --- mob removed from game. Formula: Enchant 2H Weapon - Major Intellect drops now from Risen Sorcerer
	AL["Thuzadin Shadowcaster"] = true;
	AL["Crimson Inquisitor"] = true; --- mob removed from game. Schematic: Voice Amplification Modulator and Schematic: Ultra-Flash Shadow Reflector drops now from Risen Inquisitor
	AL["Crimson Battle Mage"] = true; --- mob removed from game?
	AL["Ghoul Ravener"] = true;
	AL["Spectral Citizen"] = true;
	AL["Scholomance Adept"] = true; --- Drops Formula: Enchant 2H Weapon - Major Spirit along with Scholomance Acolyte and needs to be added back to trash loot of Scholomance.
	AL["Scholomance Dark Summoner"] = true; --- mob might have been removed. No idea where we used this.
	AL["Blackhand Elite"] = true;
	AL["Firebrand Pyromancer"] = true;
	AL["Firebrand Invoker"] = true;
	AL["Firebrand Grunt"] = true;
	AL["Firebrand Legionnaire"] = true;
	AL["Spirestone Warlord"] = true;
	AL["Spirestone Mystic"] = true;
	AL["Anvilrage Captain"] = true;
	AL["Anvilrage Marshal"] = true;
	AL["Doomforge Arcanasmith"] = true;
	AL["Weapon Technician"] = true;
	AL["Doomforge Craftsman"] = true;
	AL["Murk Worm"] = true;  --- mob removed from game
	AL["Scarshield Quartermaster"] = true;
	AL["Knot Thimblejack"] = true; --- Might not give any items anymore, needs to be checked.
	AL["Shen'dralar Provisioner"] = true;
	AL["The Nameles Prophet"] = true;
	AL["Rajaxx's Captains"] = true;
	AL["Razorfen Spearhide"] = true;
	AL["Felsteed"] = true; --- NPC name is Fel Steed. Drops Eerie Stable Lantern in SFK.
	AL["Master Elemental Shaper Krixix"] = true; --- Needs to be added to BabbleBoss
	AL["Rotted One"] = true;
	AL["Tex Vortacoil"] = true;
	AL["Sprinkle Noggenfogger"] = true;
	--- Burning Crusade
	AL["Avatar of the Martyred"] = true; --- Needs to be moved to BabbleBoss
	AL["Nexus Stalker"] = true;
	AL["Auchenai Monk"] = true;
	AL["Cabal Fanatic"] = true;
	AL["Unchained Doombringer"] = true;
	AL["Aether-tech Assistant"] = true;
	AL["Aether-tech Adept"] = true;
	AL["Aether-tech Master"] = true;
	AL["Thomas Yance"] = true;
	AL["Raging Skeleton"] = true;
	AL["Ethereal Priest"] = true;
	AL["Sethekk Ravenguard"] = true;
	AL["Time-Lost Shadowmage"] = true;
	AL["Coilfang Sorceress"] = true;
	AL["Coilfang Oracle"] = true;
	AL["Shattered Hand Centurion"] = true;
	AL["Eredar Deathbringer"] = true;
	AL["Arcatraz Sentinel"] = true;
	AL["Gargantuan Abyssal"] = true;
	AL["Sunseeker Botanist"] = true;
	AL["Sunseeker Astromage"] = true;
	AL["Durnholde Rifleman"] = true;
	AL["Rift Keeper/Rift Lord"] = true;
	AL["Don Carlos"] = true; --- Needs to be moved to BabbleBoss
	AL["Aged Dalaran Wizard"] = true;
	AL["Shattered Hand Executioner"] = true;
	AL["Servant's Quarter Animal Bosses"] = true;
	AL["Wyrmcult Provisioner"] = true;
	--- Wrath of the Lich King
	AL["Olut Alegut"] = true;
	AL["Rork Sharpchin"] = true;
	--- Cataclysm
	AL["Zen'Vorka"] = true;
	AL["Ayla Shadowstorm"] = true;
	AL["Damek Bloombeard"] = true;
	AL["Varlan Highbough"] = true;
	AL["Firestone Vendor"] = true;
	AL["Baradin Fox"] = true;
	--- Mists of Pandaria
	AL["Uncle Bigpocket"] = true;
	AL["Auntie Stormstout"] = true;
	AL["Luo Luo"] = true;
	AL["Meng Meng"] = true;
	AL["Moonfang"] = true;
	AL["Ongrom Black Tooth"] = true;
	AL["Proveditor Grantley"] = true;
	AL["Scary Sprite"] = true;
	--- World Events
	AL["Crimson Templar"] = true;  --- mob removed from game?
	AL["Azure Templar"] = true;  --- mob removed from game?
	AL["Hoary Templar"] = true;  --- mob removed from game?
	AL["Earthen Templar"] = true;  --- mob removed from game?
	AL["The Duke of Cynders"] = true;  --- mob removed from game?
	AL["The Duke of Fathoms"] = true;  --- mob removed from game?
	AL["The Duke of Zephyrs"] = true;  --- mob removed from game?
	AL["The Duke of Shards"] = true;  --- mob removed from game?
	AL["Templars"] = true;  --- mob removed from game?
	AL["Dukes"] = true;  --- mob removed from game?
	AL["High Council"] = true;  --- mob removed from game?
	AL["Smokywood Pastures Vendor"] = true;
	AL["Bash'ir Landing Stasis Chambers"] = true;
	AL["Battle Pet Trainer"] = true;

	-- Zone related strings
	AL["Azeroth"] = true;
	AL["Blackrock Mountain"] = true;
	AL["Caverns of Time"] = true;
	AL["Crusader's Square"] = true;
	AL["Darkmoon Island"] = true;
	AL["East"] = true;
	AL["Halfhill Farm"] = true;
	AL["North"] = true;
	AL["The Gauntlet"] = true;
	AL["Trial of the Grand Crusader"] = true;
	AL["West"] = true;

	-- Shortcuts for Bossname files
	AL["Avatar"] = true; -- Avatar of the Martyred

	-- Chests, etc
	AL["Father Flame"] = true; --- If still in game, should be used in IngameLocales
	AL["The Grim Guzzler"] = true;
	AL["The Secret Safe"] = true;
	AL["The Vault"] = true;
	AL["Ogre Tannin Basket"] = true;
	AL["Unfinished Painting"] = true;
	AL["Felvine Shard"] = true; --- If still in game, should be used in IngameLocales
	AL["Gift of Adoration"] = true; --- If still in game, should be used in IngameLocales
	AL["Treat Bag"] = true; --- If still in game, should be used in IngameLocales
	AL["The Cache of Madness"] = true;
	AL["Timed Reward Chest"] = true;
	AL["Timed Reward Chest 1"] = true;
	AL["Timed Reward Chest 2"] = true;
	AL["Timed Reward Chest 3"] = true;
	AL["The Talon King's Coffer"] = true;
	AL["Krom Stoutarm's Chest"] = true;
	AL["Garrett Family Chest"] = true;
	AL["Reinforced Fel Iron Chest"] = true;
	AL["DM North Tribute Chest"] = true;
	AL["The Saga of Terokk"] = true; --- If still in game, should be used in IngameLocales
	AL["First Fragment Guardian"] = true;
	AL["Second Fragment Guardian"] = true;
	AL["Third Fragment Guardian"] = true;
	AL["Overcharged Manacell"] = true; --- If still in game, should be used in IngameLocales
	AL["Shellfish Trap"] = true;
	AL["Fishing Pools"] = true;
	AL["Timeless Chest"] = true;

	-- Blizzard Promotions
	AL["Annual Pass"] = true;
	AL["Scroll of Resurrection"] = true;
	AL["Recruit-A-Friend"] = true;

	-- Error Messages and warnings
	AL["AtlasLoot Error!"] = true;
	AL["WishList Full!"] = true;
	AL["No match found for"] = true;
	AL[" is safe."] = true;
	AL["Server queried for "] = true;
	AL[".  Right click on any other item to refresh the loot page."] = true;

	-- Incomplete Table Registry error message
	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = true;

	-- LoD Module disabled or missing
	AL[" is unavailable, the following load on demand module is required: "] = true;

	-- LoD Module load sequence could not be completed
	AL["Status of the following module could not be determined: "] = true;

	-- LoD Module required has loaded, but loot table is missing
	AL[" could not be accessed, the following module may be out of date: "] = true;

	-- LoD module not defined
	AL["Loot module returned as nil!"] = true;

	-- LoD module loaded successfully
	AL["sucessfully loaded."] = true;

	-- Need a big dataset for searching
	AL["Loading available tables for searching"] = true;

	-- All Available modules loaded
	AL["All Available Modules Loaded"] = true;

	-- First time user
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = true;
	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = true;
	AL["Setup"] = true;

	-- Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = true;
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = true;
	AL["OK"] = true;
	AL["Incompatible Atlas Detected"] = true;

	-- Unsafe item tooltip
	AL["Unsafe Item"] = true;
	AL["This item is not available on your server or your battlegroup yet."] = true;
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = true;
end