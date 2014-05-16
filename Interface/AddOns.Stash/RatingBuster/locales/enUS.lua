--[[
Name: RatingBuster enUS locale
Revision: $Revision: 350 $
Translated by:
- Whitetooth (hotdogee [at] gmail [dot] com)
]]

local L = LibStub("AceLocale-3.0"):NewLocale("RatingBuster", "enUS", true)
if not L then return end
-- This file is coded in UTF-8
-- If you don't have a editor that can save in UTF-8, I recommend NotePad++ or Ultraedit
----
-- To translate AceLocale strings, replace true with the translation string
-- Before: L["Show Item ID"] = true,
-- After:  L["Show Item ID"] = "顯示物品編號",
---------------
-- Waterfall --
---------------
L["RatingBuster Options"] = true
L["Enabled"] = true
L["Suspend/resume this addon"] = true
---------------------------
-- Slash Command Options --
---------------------------
L["Always"] = true
L["ALT Key"] = true
L["CTRL Key"] = true
L["SHIFT Key"] = true
L["Never"] = true
L["General Settings"] = true
L["Profiles"] = true
-- /rb win
L["Options Window"] = true
L["Shows the Options Window"] = true
-- /rb hidebzcomp
L["Hide Blizzard Item Comparisons"] = true
L["Disable Blizzard stat change summary when using the built-in comparison tooltip"] = true
-- /rb statmod
L["Enable Stat Mods"] = true
L["Enable support for Stat Mods"] = true
-- /rb subtract_equip
L["Enable Subtract Equipped Stats"] = true
L["Enable for more accurate calculation of Mana Regen from Intellect and Spirit, and diminishing stats like Dodge, Parry, Resilience"] = true
-- /rb enable_reforge_ui
L["Enable integration with Blizzard Reforging UI"] = true
L["Add rating information to the Blizzard Reforging UI"] = true
-- /rb usereqlv
L["Use Required Level"] = true
L["Calculate using the required level if you are below the required level"] = true
-- /rb level
L["Set Level"] = true
L["Set the level used in calculations (0 = your level)"] = true
-- /rb ilvlid
L["Item Level and ID"] = true
L["Settings for Item Level and Item ID"] = true
-- /rb ilvlid coloritemlevel
L["Colorize Item Level"] = true
L["Customize the color of the Item Level text"] = true
-- /rb ilvlid itemlevelall
L["Show Item Level on all items"] = true
L["Display the Item Level on all items instead of just on equippable items"] = true
-- /rb ilvlid itemid
L["Show Item ID"] = true
L["Display the Item ID on all items"] = true
---------------------------------------------------------------------------
-- /rb rating
L["Rating"] = true
L["Options for Rating display"] = true
-- /rb rating show
L["Show Rating Conversions"] = true
L["Select when to show rating conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = true
-- /rb rating spell
L["Show Spell Hit/Haste"] = true
L["Show Spell Hit/Haste from Hit/Haste Rating"] = true
-- /rb rating physical
L["Show Physical Hit/Haste"] = true
L["Show Physical Hit/Haste from Hit/Haste Rating"] = true
-- /rb rating detail
L["Show Detailed Conversions Text"] = true
L["Show detailed text for Resilience and Expertise conversions"] = true
-- /rb rating exp
L["Expertise Breakdown"] = true
L["Convert Expertise into Dodge Neglect and Parry Neglect"] = true
---------------------------------------------------------------------------
-- /rb rating color
L["Change Text Color"] = true
L["Changes the color of added text"] = true
-- /rb rating color pick
L["Pick Color"] = true
L["Pick a color"] = true
-- /rb rating color enable
L["Enable Color"] = true
L["Enable colored text"] = true
---------------------------------------------------------------------------
-- /rb stat
L["Stat Breakdown"] = true
L["Changes the display of base stats"] = true
-- /rb stat show
L["Show Base Stat Conversions"] = true
L["Select when to show base stat conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = true
---------------------------------------------------------------------------
-- /rb stat str
L["Strength"] = true
L["Changes the display of Strength"] = true
-- /rb stat str ap
L["Show Attack Power"] = true
L["Show Attack Power from Strength"] = true
-- /rb stat str block
L["Show Block Value"] = true
L["Show Block Value from Strength"] = true
-- /rb stat str dmg
L["Show Spell Damage"] = true
L["Show Spell Damage from Strength"] = true
-- /rb stat str heal
L["Show Healing"] = true
L["Show Healing from Strength"] = true
-- /rb stat str parryrating
L["Show Parry Rating"] = true
L["Show Parry Rating from Strength"] = true
-- /rb stat str parry
L["Show Parry"] = true
L["Show Parry from Strength"] = true
---------------------------------------------------------------------------
-- /rb stat agi
L["Agility"] = true
L["Changes the display of Agility"] = true
-- /rb stat agi crit
L["Show Crit"] = true
L["Show Crit chance from Agility"] = true
-- /rb stat agi dodge
L["Show Dodge"] = true
L["Show Dodge chance from Agility"] = true
-- /rb stat agi ap
L["Show Attack Power"] = true
L["Show Attack Power from Agility"] = true
-- /rb stat agi rap
L["Show Ranged Attack Power"] = true
L["Show Ranged Attack Power from Agility"] = true
-- /rb stat agi dmg
L["Show Spell Damage"] = true
L["Show Spell Damage from Agility"] = true
-- /rb stat agi heal
L["Show Healing"] = true
L["Show Healing from Agility"] = true
---------------------------------------------------------------------------
-- /rb stat sta
L["Stamina"] = true
L["Changes the display of Stamina"] = true
-- /rb stat sta hp
L["Show Health"] = true
L["Show Health from Stamina"] = true
-- /rb stat sta dmg
L["Show Spell Damage"] = true
L["Show Spell Damage from Stamina"] = true
-- /rb stat sta heal
L["Show Healing"] = true
L["Show Healing from Stamina"] = true
-- /rb stat sta ap
L["Show Attack Power"] = true
L["Show Attack Power from Stamina"] = true
---------------------------------------------------------------------------
-- /rb stat int
L["Intellect"] = true
L["Changes the display of Intellect"] = true
-- /rb stat int spellcrit
L["Show Spell Crit"] = true
L["Show Spell Crit chance from Intellect"] = true
-- /rb stat int mp
L["Show Mana"] = true
L["Show Mana from Intellect"] = true
-- /rb stat int dmg
L["Show Spell Damage"] = true
L["Show Spell Damage from Intellect"] = true
-- /rb stat int heal
L["Show Healing"] = true
L["Show Healing from Intellect"] = true
-- /rb stat int mp5
L["Show Combat Mana Regen"] = true
L["Show Mana Regen while in combat from Intellect"] = true
-- /rb stat int mp5oc
L["Show Normal Mana Regen"] = true
L["Show Mana Regen while not in combat from Intellect"] = true
-- /rb stat int rap
L["Show Ranged Attack Power"] = true
L["Show Ranged Attack Power from Intellect"] = true
-- /rb stat int ap
L["Show Attack Power"] = true
L["Show Attack Power from Intellect"] = true
---------------------------------------------------------------------------
-- /rb stat spi
L["Spirit"] = true
L["Changes the display of Spirit"] = true
-- /rb stat spi mp5
L["Show Combat Mana Regen"] = true
L["Show Mana Regen while in combat from Spirit"] = true
-- /rb stat spi mp5oc
L["Show Normal Mana Regen"] = true
L["Show Mana Regen while not in combat from Spirit"] = true
-- /rb stat spi hp5
L["Show Normal Health Regen"] = true
L["Show Health Regen while not in combat from Spirit"] = true
-- /rb stat spi dmg
L["Show Spell Damage"] = true
L["Show Spell Damage from Spirit"] = true
-- /rb stat spi heal
L["Show Healing"] = true
L["Show Healing from Spirit"] = true
-- /rb stat spi spellcrit
L["Show Spell Crit"] = true
L["Show Spell Crit chance from Spirit"] = true
-- /rb stat spi spellhitrating
L["Show Spell Hit Rating"] = true
L["Show Spell Hit Rating from Spirit"] = true
-- /rb stat spi spellhit
L["Show Spell Hit"] = true
L["Show Spell Hit from Spirit"] = true
---------------------------------------------------------------------------
-- /rb stat armor
L["Armor"] = true
L["Changes the display of Armor"] = true
-- /rb stat armor ap
L["Show Attack Power"] = true
L["Show Attack Power from Armor"] = true
---------------------------------------------------------------------------
-- /rb sum
L["Stat Summary"] = true
L["Options for stat summary"] = true
-- /rb sum show
L["Show Stat Summary"] = true
L["Select when to show stat summary in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = true
-- /rb sum ignore
L["Ignore Settings"] = true
L["Ignore stuff when calculating the stat summary"] = true
-- /rb sum ignore unused
L["Ignore Undesirable Items"] = true
L["Hide stat summary for undesirable items"] = true
-- /rb sum ignore quality
L["Minimum Item Quality"] = true
L["Show stat summary only for selected quality items and up"] = true
-- /rb sum ignore armor
L["Armor Types"] = true
L["Select armor types you want to ignore"] = true
-- /rb sum ignore armor cloth
L["Ignore Cloth"] = true
L["Hide stat summary for all cloth armor"] = true
-- /rb sum ignore armor leather
L["Ignore Leather"] = true
L["Hide stat summary for all leather armor"] = true
-- /rb sum ignore armor mail
L["Ignore Mail"] = true
L["Hide stat summary for all mail armor"] = true
-- /rb sum ignore armor plate
L["Ignore Plate"] = true
L["Hide stat summary for all plate armor"] = true
-- /rb sum ignore equipped
L["Ignore Equipped Items"] = true
L["Hide stat summary for equipped items"] = true
-- /rb sum ignore enchant
L["Ignore Enchants"] = true
L["Ignore enchants on items when calculating the stat summary"] = true
-- /rb sum ignore gem
L["Ignore Gems"] = true
L["Ignore gems on items when calculating the stat summary"] = true
-- /rb sum ignore prismaticSocket
L["Ignore Prismatic Sockets"] = true
L["Ignore gems in prismatic sockets when calculating the stat summary"] = true
-- /rb sum diffstyle
L["Display Style For Diff Value"] = true
L["Display diff values in the main tooltip or only in compare tooltips"] = true
-- /rb sum space
L["Add Empty Line"] = true
L["Add a empty line before or after stat summary"] = true
-- /rb sum space before
L["Add Before Summary"] = true
L["Add a empty line before stat summary"] = true
-- /rb sum space after
L["Add After Summary"] = true
L["Add a empty line after stat summary"] = true
-- /rb sum icon
L["Show Icon"] = true
L["Show the sigma icon before summary listing"] = true
-- /rb sum title
L["Show Title Text"] = true
L["Show the title text before summary listing"] = true
-- /rb sum showzerostat
L["Show Zero Value Stats"] = true
L["Show zero value stats in summary for consistancy"] = true
-- /rb sum calcsum
L["Calculate Stat Sum"] = true
L["Calculate the total stats for the item"] = true
-- /rb sum calcdiff
L["Calculate Stat Diff"] = true
L["Calculate the stat difference for the item and equipped items"] = true
-- /rb sum sort
L["Sort StatSummary Alphabetically"] = true
L["Enable to sort StatSummary alphabetically, disable to sort according to stat type(basic, physical, spell, tank)"] = true
-- /rb sum avoidhasblock
L["Include Block Chance In Avoidance Summary"] = true
L["Enable to include block chance in Avoidance summary, Disable for only dodge, parry, miss"] = true
---------------------------------------------------------------------------
-- /rb sum basic
L["Stat - Basic"] = true
L["Choose basic stats for summary"] = true
-- /rb sum basic hp
L["Sum Health"] = true
L["Health <- Health, Stamina"] = true
-- /rb sum basic mp
L["Sum Mana"] = true
L["Mana <- Mana, Intellect"] = true
-- /rb sum basic mp5
L["Sum Combat Mana Regen"] = true
L["Combat Mana Regen <- Mana Regen, Spirit"] = true
-- /rb sum basic mp5oc
L["Sum Normal Mana Regen"] = true
L["Normal Mana Regen <- Spirit"] = true
-- /rb sum basic hp5
L["Sum Combat Health Regen"] = true
L["Combat Health Regen <- Health Regen"] = true
-- /rb sum basic hp5oc
L["Sum Normal Health Regen"] = true
L["Normal Health Regen <- Spirit"] = true
-- /rb sum basic str
L["Sum Strength"] = true
L["Strength Summary"] = true
-- /rb sum basic agi
L["Sum Agility"] = true
L["Agility Summary"] = true
-- /rb sum basic sta
L["Sum Stamina"] = true
L["Stamina Summary"] = true
-- /rb sum basic int
L["Sum Intellect"] = true
L["Intellect Summary"] = true
-- /rb sum basic spi
L["Sum Spirit"] = true
L["Spirit Summary"] = true
-- /rb sum basic mastery
L["Sum Mastery"] = true
L["Mastery Summary"] = true
-- /rb sum basic masteryrating
L["Sum Mastery Rating"] = true
L["Mastery Rating Summary"] = true
---------------------------------------------------------------------------
-- /rb sum physical
L["Stat - Physical"] = true
L["Choose physical damage stats for summary"] = true
-- /rb sum physical ap
L["Sum Attack Power"] = true
L["Attack Power <- Attack Power, Strength, Agility"] = true
-- /rb sum physical rap
L["Sum Ranged Attack Power"] = true
L["Ranged Attack Power <- Ranged Attack Power, Intellect, Attack Power, Strength, Agility"] = true
-- /rb sum physical hit
L["Sum Hit Chance"] = true
L["Hit Chance <- Hit Rating"] = true
-- /rb sum physical hitrating
L["Sum Hit Rating"] = true
L["Hit Rating Summary"] = true
-- /rb sum physical crit
L["Sum Crit Chance"] = true
L["Crit Chance <- Crit Rating, Agility"] = true
-- /rb sum physical critrating
L["Sum Crit Rating"] = true
L["Crit Rating Summary"] = true
-- /rb sum physical haste
L["Sum Haste"] = true
L["Haste <- Haste Rating"] = true
-- /rb sum physical hasterating
L["Sum Haste Rating"] = true
L["Haste Rating Summary"] = true
-- /rb sum physical rangedhit
L["Sum Ranged Hit Chance"] = true
L["Ranged Hit Chance <- Hit Rating, Ranged Hit Rating"] = true
-- /rb sum physical rangedhitrating
L["Sum Ranged Hit Rating"] = true
L["Ranged Hit Rating Summary"] = true
-- /rb sum physical rangedcrit
L["Sum Ranged Crit Chance"] = true
L["Ranged Crit Chance <- Crit Rating, Agility, Ranged Crit Rating"] = true
-- /rb sum physical rangedcritrating
L["Sum Ranged Crit Rating"] = true
L["Ranged Crit Rating Summary"] = true
-- /rb sum physical rangedhaste
L["Sum Ranged Haste"] = true
L["Ranged Haste <- Haste Rating, Ranged Haste Rating"] = true
-- /rb sum physical rangedhasterating
L["Sum Ranged Haste Rating"] = true
L["Ranged Haste Rating Summary"] = true
-- /rb sum physical maxdamage
L["Sum Weapon Max Damage"] = true
L["Weapon Max Damage Summary"] = true
-- /rb sum physical weapondps
--L["Sum Weapon DPS"] = true
--L["Weapon DPS Summary"] = true
-- /rb sum physical wpn
L["Sum Weapon Skill"] = true
L["Weapon Skill <- Weapon Skill Rating"] = true
-- /rb sum physical exp
L["Sum Expertise"] = true
L["Expertise <- Expertise Rating"] = true
-- /rb sum physical exprating
L["Sum Expertise Rating"] = true
L["Expertise Rating Summary"] = true
---------------------------------------------------------------------------
-- /rb sum spell
L["Stat - Spell"] = true
L["Choose spell damage and healing stats for summary"] = true
-- /rb sum spell power
L["Sum Spell Power"] = true
L["Spell Power <- Spell Power, Intellect, Agility, Strength"] = true
-- /rb sum spell dmg
L["Sum Spell Damage"] = true
L["Spell Damage <- Spell Damage, Intellect, Spirit, Stamina"] = true
-- /rb sum spell dmgholy
L["Sum Holy Spell Damage"] = true
L["Holy Spell Damage <- Holy Spell Damage, Spell Damage, Intellect, Spirit"] = true
-- /rb sum spell dmgarcane
L["Sum Arcane Spell Damage"] = true
L["Arcane Spell Damage <- Arcane Spell Damage, Spell Damage, Intellect"] = true
-- /rb sum spell dmgfire
L["Sum Fire Spell Damage"] = true
L["Fire Spell Damage <- Fire Spell Damage, Spell Damage, Intellect, Stamina"] = true
-- /rb sum spell dmgnature
L["Sum Nature Spell Damage"] = true
L["Nature Spell Damage <- Nature Spell Damage, Spell Damage, Intellect"] = true
-- /rb sum spell dmgfrost
L["Sum Frost Spell Damage"] = true
L["Frost Spell Damage <- Frost Spell Damage, Spell Damage, Intellect"] = true
-- /rb sum spell dmgshadow
L["Sum Shadow Spell Damage"] = true
L["Shadow Spell Damage <- Shadow Spell Damage, Spell Damage, Intellect, Spirit, Stamina"] = true
-- /rb sum spell heal
L["Sum Healing"] = true
L["Healing <- Healing, Intellect, Spirit, Agility, Strength"] = true
-- /rb sum spell crit
L["Sum Spell Crit Chance"] = true
L["Spell Crit Chance <- Spell Crit Rating, Intellect"] = true
-- /rb sum spell hit
L["Sum Spell Hit Chance"] = true
L["Spell Hit Chance <- Spell Hit Rating"] = true
-- /rb sum spell haste
L["Sum Spell Haste"] = true
L["Spell Haste <- Spell Haste Rating"] = true
-- /rb sum spell pen
L["Sum Penetration"] = true
L["Spell Penetration Summary"] = true
-- /rb sum spell hitrating
L["Sum Spell Hit Rating"] = true
L["Spell Hit Rating Summary"] = true
-- /rb sum spell critrating
L["Sum Spell Crit Rating"] = true
L["Spell Crit Rating Summary"] = true
-- /rb sum spell hasterating
L["Sum Spell Haste Rating"] = true
L["Spell Haste Rating Summary"] = true
---------------------------------------------------------------------------
-- /rb sum tank
L["Stat - Tank"] = true
L["Choose tank stats for summary"] = true
-- /rb sum tank armor
L["Sum Armor"] = true
L["Armor <- Armor from items and bonuses"] = true
-- /rb sum tank dodge
L["Sum Dodge Chance"] = true
L["Dodge Chance <- Dodge Rating, Agility"] = true
-- /rb sum tank parry
L["Sum Parry Chance"] = true
L["Parry Chance <- Parry Rating"] = true
-- /rb sum tank block
L["Sum Block Chance"] = true
L["Block Chance <- Block Rating"] = true
-- /rb sum tank neglectdodge
L["Sum Dodge Neglect"] = true
L["Dodge Neglect <- Expertise"] = true
-- /rb sum tank neglectparry
L["Sum Parry Neglect"] = true
L["Parry Neglect <- Expertise"] = true
-- /rb sum tank resarcane
L["Sum Arcane Resistance"] = true
L["Arcane Resistance Summary"] = true
-- /rb sum tank resfire
L["Sum Fire Resistance"] = true
L["Fire Resistance Summary"] = true
-- /rb sum tank resnature
L["Sum Nature Resistance"] = true
L["Nature Resistance Summary"] = true
-- /rb sum tank resfrost
L["Sum Frost Resistance"] = true
L["Frost Resistance Summary"] = true
-- /rb sum tank resshadow
L["Sum Shadow Resistance"] = true
L["Shadow Resistance Summary"] = true
-- /rb sum tank dodgerating
L["Sum Dodge Rating"] = true
L["Dodge Rating Summary"] = true
-- /rb sum tank parryrating
L["Sum Parry Rating"] = true
L["Parry Rating Summary"] = true
-- /rb sum tank blockrating
L["Sum Block Rating"] = true
L["Block Rating Summary"] = true
-- /rb sum tank res
L["Sum Resilience"] = true
L["Resilience Summary"] = true
-- /rb sum tank tp
L["Sum TankPoints"] = true
L["TankPoints <- Health, Total Reduction"] = true
-- /rb sum tank tr
L["Sum Total Reduction"] = true
L["Total Reduction <- Armor, Dodge, Parry, Block, MobMiss, MobCrit, MobCrush, DamageTakenMods"] = true
-- /rb sum tank avoid
L["Sum Avoidance"] = true
L["Avoidance <- Dodge, Parry, MobMiss, Block(Optional)"] = true
---------------------------------------------------------------------------
-- /rb sum gemset
L["Gem Set"] = true
L["Select a gem set to configure"] = true
L["Default Gem Set 1"] = true
L["Default Gem Set 2"] = true
L["Default Gem Set 3"] = true
-- /rb sum gem
L["Auto fill empty gem slots"] = true
-- /rb sum gem red
L["Red Socket"] = EMPTY_SOCKET_RED
L["ItemID or Link of the gem you would like to auto fill"] = true
L["<ItemID|Link>"] = true
L["|cffffff7f%s|r is now set to |cffffff7f[%s]|r"] = true
L["Invalid input: %s. ItemID or ItemLink required."] = true
L["Queried server for Gem: %s. Try again in 5 secs."] = true
-- /rb sum gem yellow
L["Yellow Socket"] = EMPTY_SOCKET_YELLOW
-- /rb sum gem blue
L["Blue Socket"] = EMPTY_SOCKET_BLUE
-- /rb sum gem meta
L["Meta Socket"] = EMPTY_SOCKET_META
-- /rb sum gem2
L["Second set of default gems which can be toggled with a modifier key"] = true
L["Can't use the same modifier as Gem Set 3"] = true
-- /rb sum gem2 key
L["Toggle Key"] = true
L["Use this key to toggle alternate gems"] = true
-- /rb sum gem3
L["Third set of default gems which can be toggled with a modifier key"] = true
L["Can't use the same modifier as Gem Set 2"] = true

-----------------------
-- Item Level and ID --
-----------------------
L["ItemLevel: "] = true
L["ItemID: "] = true
-----------------------
-- Matching Patterns --
-----------------------
-- Items to check --
--------------------
-- [Potent Ornate Topaz]
-- +6 Spell Damage, +5 Spell Crit Rating
--------------------
-- ZG enchant
-- +10 Defense Rating/+10 Stamina/+15 Block Value
--------------------
-- [Glinting Flam Spessarite]
-- +3 Hit Rating and +3 Agility
--------------------
-- ItemID: 22589
-- [Atiesh, Greatstaff of the Guardian] warlock version
-- Equip: Increases the spell critical strike rating of all party members within 30 yards by 28.
--------------------
-- [Brilliant Wizard Oil]
-- Use: While applied to target weapon it increases spell damage by up to 36 and increases spell critical strike rating by 14 . Lasts for 30 minutes.
----------------------------------------------------------------------------------------------------
-- I redesigned the tooltip scanner using a more locale friendly, 2 pass matching matching algorithm.
--
-- The first pass searches for the rating number, the patterns are read from L["numberPatterns"] here,
-- " by (%d+)" will match strings like: "Increases defense rating by 16."
-- "%+(%d+)" will match strings like: "+10 Defense Rating"
-- You can add additional patterns if needed, its not limited to 2 patterns.
-- The separators are a table of strings used to break up a line into multiple lines what will be parsed seperately.
-- For example "+3 Hit Rating, +5 Spell Crit Rating" will be split into "+3 Hit Rating" and " +5 Spell Crit Rating"
--
-- The second pass searches for the rating name, the names are read from L["statList"] here,
-- It will look through the table in order, so you can put common strings at the begining to speed up the search,
-- and longer strings should be listed first, like "spell critical strike" should be listed before "critical strike",
-- this way "spell critical strike" does get matched by "critical strike".
-- Strings need to be in lower case letters, because string.lower is called on lookup
--
-- IMPORTANT: there may not exist a one-to-one correspondence, meaning you can't just translate this file,
-- but will need to go in game and find out what needs to be put in here.
-- For example, in english I found 3 different strings that maps to CR_CRIT_MELEE: "critical strike", "critical hit" and "crit".
-- You will need to find out every string that represents CR_CRIT_MELEE, and so on.
-- In other languages there may be 5 different strings that should all map to CR_CRIT_MELEE.
-- so please check in game that you have all strings, and not translate directly off this table.
--
-- Tip1: When doing localizations, I recommend you set debugging to true in RatingBuster.lua
-- Find RatingBuster:SetDebugging(false) and change it to RatingBuster:SetDebugging(true)
-- or you can type /rb debug to enable it in game
--
-- Tip2: The strings are passed into string.find, so you should escape the magic characters ^$()%.[]*+-? with a %
L["numberPatterns"] = {
	{pattern = " by (%d+)", addInfo = "AfterNumber", space = " ", },
	{pattern = "([%+%-]%d+)[^%%]", addInfo = "AfterStat", space = " ", },
	--{pattern = "grant.-(%d+)", addInfo = "AfterNumber",}, -- for "grant you xx stat" type pattern, ex: Quel'Serrar ID:18348, Assassination Armor set
	--{pattern = "add.-(%d+)", addInfo = "AfterNumber",}, -- for "add xx stat" type pattern, ex: Adamantite Sharpening Stone ID:23529
	-- Added [^%%] so that it doesn't match strings like "Increases healing by up to 10% of your total Intellect." [Whitemend Pants] ID:24261
	-- Added [^|] so that it doesn't match enchant strings (JewelTips)
	{pattern = "(%d+)([^%d+%%|]+)", addInfo = "AfterStat", space = " ", }, -- [發光的暗影卓奈石] +6法術傷害及5耐力
}
L["separators"] = {
	"/", " and ", "%. ", " for ", "&", ":",
	-- Fix for [Mirror of Truth]
	-- Equip: Chance on melee and ranged critical strike to increase your attack power by 1000 for 10 secs.
	-- 1000 was falsely detected detected as ranged critical strike
	"increase your",
}
--[[ Rating ID
CR_WEAPON_SKILL = 1;
CR_DEFENSE_SKILL = 2;
CR_DODGE = 3;
CR_PARRY = 4;
CR_BLOCK = 5;
CR_HIT_MELEE = 6;
CR_HIT_RANGED = 7;
CR_HIT_SPELL = 8;
CR_CRIT_MELEE = 9;
CR_CRIT_RANGED = 10;
CR_CRIT_SPELL = 11;
CR_HIT_TAKEN_MELEE = 12;
CR_HIT_TAKEN_RANGED = 13;
CR_HIT_TAKEN_SPELL = 14;
COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15;
COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16;
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
--
SPELL_STAT1_NAME = "Strength"
SPELL_STAT2_NAME = "Agility"
SPELL_STAT3_NAME = "Stamina"
SPELL_STAT4_NAME = "Intellect"
SPELL_STAT5_NAME = "Spirit"
--]]
L["statList"] = {
--Ive included the ex  They are formatted in the Blizzard globals as
--"Increases your mastery by %s."  The gsum strips any 
--gsub(ITEM_MOD_CRIT_RATING,"%s[%+%-]?%%.%.?","")

--Stats
	{pattern = string.lower(ARMOR), id = ARMOR},
	{pattern = string.lower(SPELL_STAT1_NAME), id = SPELL_STAT1_NAME}, -- Strength
	{pattern = string.lower(SPELL_STAT2_NAME), id = SPELL_STAT2_NAME}, -- Agility
	{pattern = string.lower(SPELL_STAT3_NAME), id = SPELL_STAT3_NAME}, -- Stamina
	{pattern = string.lower(SPELL_STAT4_NAME), id = SPELL_STAT4_NAME}, -- Intellect
	{pattern = string.lower(SPELL_STAT5_NAME), id = SPELL_STAT5_NAME}, -- Spirit

	{pattern = string.lower(ITEM_MOD_STRENGTH_SHORT), id = SPELL_STAT1_NAME}, -- Strength
	{pattern = string.lower(ITEM_MOD_AGILITY_SHORT), id = SPELL_STAT2_NAME}, -- Agility
	{pattern = string.lower(ITEM_MOD_STAMINA_SHORT), id = SPELL_STAT3_NAME}, -- Stamina
	{pattern = string.lower(ITEM_MOD_INTELLECT_SHORT), id = SPELL_STAT4_NAME}, -- Intellect
	{pattern = string.lower(ITEM_MOD_SPIRIT_SHORT), id = SPELL_STAT5_NAME}, -- Spirit
--Dodge
	{pattern = string.lower(STAT_DODGE), id = CR_DODGE},
	{pattern = string.lower(ITEM_MOD_DODGE_RATING_SHORT), id = CR_DODGE},
	{pattern = string.lower(gsub(ITEM_MOD_DODGE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_DODGE}, 
--Parry
	{pattern = string.lower(STAT_PARRY), id = CR_PARRY},
	{pattern = string.lower(ITEM_MOD_PARRY_RATING_SHORT), id = CR_PARRY},
	{pattern = string.lower(gsub(ITEM_MOD_PARRY_RATING,"%s[%+%-]?%%.%.?","")), id = CR_PARRY},
--Block
	{pattern = string.lower(STAT_BLOCK), id = CR_BLOCK}, -- block enchant: "+10 Shield Block"
	{pattern = string.lower(ITEM_MOD_BLOCK_VALUE_SHORT), id = CR_BLOCK}, -- block enchant: "+10 Shield Block"
	{pattern = string.lower(gsub(ITEM_MOD_BLOCK_VALUE,"%s[%+%-]?%%.%.?","")), id = CR_BLOCK}, 
--Hit
	{pattern = string.lower(ITEM_MOD_HIT_RATING_SHORT), id = CR_HIT_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_MELEE}, 
	
	{pattern = string.lower(ITEM_MOD_HIT_MELEE_RATING_SHORT), id = CR_HIT_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_MELEE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_MELEE}, 
	
	{pattern = string.lower(ITEM_MOD_HIT_RANGED_RATING_SHORT), id = CR_HIT_RANGED},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_RANGED_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_RANGED}, 
	
	{pattern = string.lower(ITEM_MOD_HIT_SPELL_RATING_SHORT), id = CR_HIT_SPELL},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_SPELL_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_SPELL}, 
--Crit
	{pattern = string.lower(ITEM_MOD_CRIT_RATING_SHORT), id = CR_CRIT_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_CRIT_RATING,"%s[%+%-]?%%.%.?","")), id = CR_CRIT_MELEE},
	
	{pattern = string.lower(ITEM_MOD_CRIT_MELEE_RATING_SHORT), id = CR_CRIT_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_CRIT_MELEE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_CRIT_MELEE},
	
	{pattern = string.lower(ITEM_MOD_CRIT_RANGED_RATING_SHORT), id = CR_CRIT_RANGED},
	{pattern = string.lower(gsub(ITEM_MOD_CRIT_RANGED_RATING,"%s[%+%-]?%%.%.?","")), id = CR_CRIT_RANGED},
	
	{pattern = string.lower(ITEM_MOD_CRIT_SPELL_RATING_SHORT), id = CR_CRIT_SPELL},
	{pattern = string.lower(gsub(ITEM_MOD_CRIT_SPELL_RATING,"%s[%+%-]?%%.%.?","")), id = CR_CRIT_SPELL},
--Haste
	{pattern = string.lower(ITEM_MOD_HASTE_RATING_SHORT), id = CR_HASTE_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HASTE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HASTE_MELEE},

	{pattern = string.lower(ITEM_MOD_HASTE_MELEE_RATING_SHORT), id = CR_HASTE_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HASTE_MELEE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HASTE_MELEE},
	
	{pattern = string.lower(ITEM_MOD_HASTE_RANGED_RATING_SHORT), id = CR_HASTE_RANGED},
	{pattern = string.lower(gsub(ITEM_MOD_HASTE_RANGED_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HASTE_RANGED},
	
	{pattern = string.lower(ITEM_MOD_HASTE_SPELL_RATING_SHORT), id = CR_HASTE_SPELL},
	{pattern = string.lower(gsub(ITEM_MOD_HASTE_SPELL_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HASTE_SPELL}, 
--Expertise
	{pattern = string.lower(ITEM_MOD_EXPERTISE_RATING_SHORT), id = CR_EXPERTISE},
	{pattern = string.lower(gsub(ITEM_MOD_EXPERTISE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_EXPERTISE},
--Mastery
	{pattern = string.lower(ITEM_MOD_MASTERY_RATING_SHORT), id = CR_MASTERY},
	{pattern = string.lower(gsub(ITEM_MOD_MASTERY_RATING,"%s[%+%-]?%%.%.?","")), id = CR_MASTERY},
--Spell Power
	{pattern = string.lower(ITEM_MOD_SPELL_POWER_SHORT), id = SPELL_POWER},
	{pattern = string.lower(gsub(ITEM_MOD_SPELL_POWER,"%s[%+%-]?%%.%.?","")), id = SPELL_POWER}, 

	{pattern = string.lower(ITEM_MOD_SPELL_DAMAGE_DONE_SHORT), id = SPELL_DMG},
	{pattern = string.lower(gsub(ITEM_MOD_SPELL_DAMAGE_DONE,"%s[%+%-]?%%.%.?","")), id = SPELL_DMG}, 
--PVP Power
	{pattern = string.lower(ITEM_MOD_PVP_POWER_SHORT), id = CR_PVP_POWER}, 
	{pattern = string.lower(gsub(ITEM_MOD_PVP_POWER,"%s[%+%-]?%%.%.?","")), id = CR_PVP_POWER},
--PVP Resil
	{pattern = string.lower(ITEM_MOD_RESILIENCE_RATING_SHORT), id = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN},
	{pattern = string.lower(gsub(ITEM_MOD_RESILIENCE_RATING,"%s[%+%-]?%%.%.?","")), id = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN},
--Hit Taken
	{pattern = string.lower(ITEM_MOD_HIT_TAKEN_RATING_SHORT), id = CR_HIT_TAKEN_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_TAKEN_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_TAKEN_MELEE},
	
	{pattern = string.lower(ITEM_MOD_HIT_TAKEN_MELEE_RATING_SHORT), id = CR_HIT_TAKEN_MELEE},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_TAKEN_MELEE_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_TAKEN_MELEE},
	
	{pattern = string.lower(ITEM_MOD_HIT_TAKEN_RANGED_RATING_SHORT), id = CR_HIT_TAKEN_RANGED},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_TAKEN_RANGED_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_TAKEN_RANGED},
	
	{pattern = string.lower(ITEM_MOD_HIT_TAKEN_SPELL_RATING_SHORT), id = CR_HIT_TAKEN_SPELL},
	{pattern = string.lower(gsub(ITEM_MOD_HIT_TAKEN_SPELL_RATING,"%s[%+%-]?%%.%.?","")), id = CR_HIT_TAKEN_SPELL},
--Misc
	{pattern = string.lower(STAT_CATEGORY_DEFENSE), id = CR_DEFENSE_SKILL},
	{pattern = string.lower(SKILL), id = CR_WEAPON_SKILL},
	{pattern = string.lower(ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT), id = CR_ARMOR_PENETRATION},
}
-------------------------
-- Added info patterns --
-------------------------
-- $value will be replaced with the number
-- EX: "$value% Crit" -> "+1.34% Crit"
-- EX: "Crit $value%" -> "Crit +1.34%"
L["$value% Crit"] = true
L["$value% Spell Crit"] = true
L["$value% Dodge"] = true
L["$value HP"] = true
L["$value MP"] = true
L["$value AP"] = true
L["$value SP"] = true
L["$value RAP"] = true
L["$value Pwr"] = true
L["$value Heal"] = true
L["$value Armor"] = true
L["$value Block"] = true
L["$value MP5"] = true
L["$value MP5(OC)"] = true
L["$value HP5"] = true
L["$value to be Dodged/Parried"] = true
L["$value to be Crit"] = true
L["$value Crit Dmg Taken"] = true
L["$value DOT Dmg Taken"] = true
L["$value PVP Dmg Taken"] = true
L["$value Parry"] = true
-- for hit rating showing both physical and spell conversions
-- (+1.21%, S+0.98%)
-- (+1.21%, +0.98% S)
L["$value Spell"] = true
L["$value Spell Hit"] = true

------------------
-- Stat Summary --
------------------
L["Stat Summary"] = true


