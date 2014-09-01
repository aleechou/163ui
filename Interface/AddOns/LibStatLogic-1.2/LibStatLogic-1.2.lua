local print
local DEBUG = false
do
    local _print = _G.print
    print = function(...)
        if(DEBUG and DEBUG_MODE) then return _print(...) end
    end
end

--[[
Name: LibStatLogic-1.2
Description: A Library for stat conversion, calculation and summarization.
Revision: $Revision: 191 $
Author: Whitetooth
Email: hotdogee [at] gmail [dot] com
WoW 5.0 Contribuiter: Gathirer
Last Update: $Date: 2012-12-01 11:46:50 +0000 (Sat, 01 Dec 2012) $
Website:
Documentation:
SVN: $URL $
Dependencies: UTF8
License: LGPL v3
Features:
  StatConversion -
    Ratings -> Effect
    Str -> AP, Block
    Agi -> Crit, Dodge, AP, RAP, Armor
    Sta -> Health, SpellDmg(Talent)
    Int -> SpellCrit
    Spi -> MP5
    and more!
  StatMods - Get stat mods from talents and buffs for every class
  BaseStats - for all classes and levels
  ItemStatParser - Fast multi level indexing algorithm instead of calling strfind for every stat

Debug:
  /sldebug

  /slwarning
	Allows libstatlogic to show warnings if an item is not recognized.
	This is a compromise between nothing and full /sldebug mode
]]

local MAJOR = "LibStatLogic-1.2";
local MINOR = "$Revision: 191 $";

local StatLogic = LibStub:NewLibrary(MAJOR, MINOR)
if not StatLogic then return end

-- For Mikk's findglobals script
local _G = _G
local tostring,tonumber,gsub,select,next,pairs,ipairs,type,unpack,strsub,strlen =
       tostring,tonumber,gsub,select,next,pairs,ipairs,type,unpack,strsub,strlen
local ceil,floor = 
       ceil,floor
local CR_DEFENSE_SKILL, CR_DODGE, CR_PARRY = 
       CR_DEFENSE_SKILL, CR_DODGE, CR_PARRY
local GetCombatRating, GetCombatRatingBonus, GetParryChance, GetDodgeChance =
       GetCombatRating, GetCombatRatingBonus, GetParryChance, GetDodgeChance
local UnitBuff, UnitDebuff, GetItemInfo, GetItemGem, GetTime = 
       UnitBuff, UnitDebuff, GetItemInfo, GetItemGem, GetTime
-- GLOBALS: error, print, setmetatable, getmetatable, debugstack
-- GLOBALS: ItemRefTooltip, UIParent, ShowUIPanel
-- GLOBALS: DEFAULT_CHAT_FRAME
       
----------------------
-- Version Checking --
----------------------
StatLogic.Major = MAJOR;
StatLogic.Minor = MINOR;
local wowBuildNo = tonumber((select(2, GetBuildInfo()))); --e.g. "5.0.4", "16016", "Aug 21 2012", 50001
StatLogic.wowBuildNo = wowBuildNo --e.g. 16016
local toc = tonumber((select(4, GetBuildInfo()))); --e.g. 50001
StatLogic.ItemsNotRecognized = {}; --list of all text that we were unable to parse

--[[
	Version		Build
	==========  =====
	4.0.1		13164
	4.0.1a		13205
				13221
	4.0.3		13287
	4.0.3a		13329
	4.0.6		13596  --
	4.0.6a		13623  --The Shattering/Cataclysm
	4.1.0		13914  --Rise of the Zandalari
	4.1.0a		14007  --Rise of the Zandalari
	4.2.0		14333  --Rage of the Firelands
	4.2.0a		14480  --Rage of the Firelands
	4.2.2		14545  --Rage of the Firelands
	4.3.0		15005  --Hour of Twilight
	4.3.0a		15055  --Hour of Twilight
	4.3.2		15211  --Hour of Twilight
	4.3.3		15354  --Hour of Twilight
	4.3.4		15595  --Hour of Twilight	GetBuildInfo() -> "4.3.4", "15595", "Apr 10 2012", 40300
	
	--Mists of Pandaria Beta
	5.0.4		15929  --Mists of Pandaria Beta	GetBuildInfo() -> "5.0.4", "15929", "Jul 31 2012", 50001
	5.0.4		15952  --Mists of Pandaria Beta	GetBuildInfo() -> "5.0.4", "15952", "Aug 5 2012",  50001
	5.0.4		15961  --Mista of Pandaria Beta	GetBuildInfo() -> "5.0.4", "15961", "Aug 7 2012",  50001
	5.0.4		15983  --Mists of Pandaria Beta	GetBuildInfo() -> "5.0.4", "15983", "Aug 14 2012", 50001
	
	--Mists of Pandaria 
	5.0.4		16016  --Mists of Pandaria	GetBuildInfo() -> "5.0.4", "16016", "Aug 21 2012",  50001  Released to live 8/28/2012
	5.0.5		16048  --Mists of Panderia  GetBuildInfo() -> "5.0.5", "16048", "Sep 5 2012",   50001  Released to live 9/11/2012
	5.0.5a		16057  --Mists of Panderia  GetBuildInfo() -> "5.0.5", "16057", "Sep 10 2012",  50001  Released to live 9/11/2012
	5.0.5b		16135  --Mists of Panearia  GetBuildInfo() -> "5.0.5", "16135", "Oct 8 2012",   50001  Released to live 10/10/2012
	5.1.0		16309  --Landfall           GetBuildInfo() -> "5.1.0", "16309", "Nov 13 2012",  50100  Released to live 11/27/2012
	5.1.0a		16357  --Landfall           GetBuildInfo() -> "5.1.0", "16357", "Dec 3 2012",   50100  Released to live 12/11/2012
	5.2.0       16709  --The Thunder King   GetBuildInfo() -> "5.2.0", "16709", "Mar 14 2013",  50200  Released to live 3/12/2013
	5.2.0		16826  --The Thunder King   GetBuildInfo() -> "5.2.0", "16826", "Apr 8 2013",   50200
	5.3.0		16977  --Escalation			GetBuildInfo() -> "5.3.0", "16977", "May 20 2013",  50300
	5.3.0		17116  --Escalation			GetBuildInfo() -> "5.3.0", "17116", "Jun 21 2013",  50300

--]]

-- Our localization information
local L = nil;

-------------------
-- Set Debugging --
-------------------
-- local DEBUG = false
function ToggleDebug()
	DEBUG = not DEBUG
  	if DEBUG then
		print(ORANGE_FONT_COLOR_CODE.."LibStatLogic"..FONT_COLOR_CODE_CLOSE..": Debugging enabled");
	else
		print(ORANGE_FONT_COLOR_CODE.."LibStatLogic"..FONT_COLOR_CODE_CLOSE..": Debugging disabled");
	end;
end
SlashCmdList["STATLOGIC_DEBUG"] = ToggleDebug;
SLASH_STATLOGIC_DEBUG1 = "/sldebug"


--Show warnings by default for enUS for few weeks after each launch - until we've caught everything.
--Once the warnings have settled down, they can be disabled
local ItemNotRecognizedWarningDefault = (GetLocale() == "enUS") and false;
--Note: We won't show warnings, by default, for any other locales, because their translations are 
--      so broken and far behind that the game will never be usable for anyone besides enUS.
if (BNConnected()) then
	local _, battleTag = BNGetInfo();
	if battleTag == "Pauladin#1741" then --us developers need to see warnings - otherwise we'd have no idea things are broken
		print("Greetings Professor Falken");
		ItemNotRecognizedWarningDefault = true;
	end;
end

local _itemNotRecognizedWarning = ItemNotRecognizedWarningDefault;
function ToggleWarnings()
	_itemNotRecognizedWarning = not _itemNotRecognizedWarning;
	if _itemNotRecognizedWarning then
		print(ORANGE_FONT_COLOR_CODE.."LibStatLogic"..FONT_COLOR_CODE_CLOSE..": Warnings "..GREEN_FONT_COLOR_CODE.."enabled"..FONT_COLOR_CODE_CLOSE ..". A warning will be displayed if an item's attribute is not recognized");
	else
		print(ORANGE_FONT_COLOR_CODE.."LibStatLogic"..GRAY_FONT_COLOR_CODE..": Warnings disabled");
	end;
end;
SlashCmdList["STATLOGIC_WARNING"] = ToggleWarnings
SLASH_STATLOGIC_WARNING1 = "/slwarning"



local function DumpLocaleInfo()
	local blueColorCode = "|cff88ccff";

	print(string.format(ORANGE_FONT_COLOR_CODE.."LibStatLogic"..FONT_COLOR_CODE_CLOSE.." version %s.%s", StatLogic.Major, StatLogic.Minor));
	print(string.format("   "..blueColorCode.."GetLocale()"..FONT_COLOR_CODE_CLOSE.."=\"%s\"", GetLocale() ));
	print(string.format("   "..blueColorCode.."L.LOCALE_STHOUSAND"..FONT_COLOR_CODE_CLOSE.."=\"%s\" "..LIGHTYELLOW_FONT_COLOR_CODE.."Character used to separate groups of digits e.g. \",\"", L.LOCALE_STHOUSAND));
	print(string.format("   "..blueColorCode.."L.LOCALE_SDECIMAL"..FONT_COLOR_CODE_CLOSE.."=\"%s\" "..LIGHTYELLOW_FONT_COLOR_CODE.."Character(s) used for the decimal separator  e.g. \".\"", L.LOCALE_SDECIMAL));
	
	print(string.format("   "..blueColorCode.."L.patNumber"..FONT_COLOR_CODE_CLOSE.."=\"%s\" "..LIGHTYELLOW_FONT_COLOR_CODE.."regular expression to find a localized number e.g. \%d+[,\%d]*", L.patNumber));
	print(string.format("   "..blueColorCode.."L.patDecimal"..FONT_COLOR_CODE_CLOSE.."=\"%s\" "..LIGHTYELLOW_FONT_COLOR_CODE.."regex to find a localized decimal number e.g. \%d+[,\%d]*.?\%d", L.patDecimal));
end;

local function AnalyzeItem(itemString)
	StatLogic:SetTip("item:"..itemString)
end;

local function DumpUnrecognizedItems()
	print("The following item attributes have not been recognized by LibStatLogic");
	print("Each time an item is unrecognized the game takes a performance penalty");
	
	for k, v in pairs(StatLogic.ItemsNotRecognized) do
		print(v.."   "..k);
	end

end;

local function ParseText(text)
	local t = {};
	StatLogic:ParseLine(t, text);
	
--	DevTools_Dump(t);
	for k, v in pairs(t) do
		print(string.format("[\"%s\"] = %s", k, v));
	end;
end;

local function PrintCommandHelp()
	print(ORANGE_FONT_COLOR_CODE.."LibStatLogic"..FONT_COLOR_CODE_CLOSE..": Arguments to /tp:");
	print("   "..LIGHTYELLOW_FONT_COLOR_CODE.."debug"..FONT_COLOR_CODE_CLOSE.." - toggle debugging message");
	print("   "..LIGHTYELLOW_FONT_COLOR_CODE.."warning"..FONT_COLOR_CODE_CLOSE.." - toggle display of warning messages of unknown item text");
	print("   "..LIGHTYELLOW_FONT_COLOR_CODE.."locale"..FONT_COLOR_CODE_CLOSE.." - display core localization info used by LibStatLogic");
	print("   "..LIGHTYELLOW_FONT_COLOR_CODE.."analyze [itemID]"..FONT_COLOR_CODE_CLOSE.." - analyze the tooltip of the specified ItemID");
	print("   "..LIGHTYELLOW_FONT_COLOR_CODE.."unrecognized"..FONT_COLOR_CODE_CLOSE.." - dump the list of all unrecognized items");
	print("   "..LIGHTYELLOW_FONT_COLOR_CODE.."parse [text]"..FONT_COLOR_CODE_CLOSE.." - parse a line of text for stats");
end;

SlashCmdList["STATLOGIC_SLASHCMD"] = function(msg)
	local command, rest = msg:match("^(%S*)%s*(.-)$")

	if (command == "debug") then
		ToggleDebug();
	elseif (command == "warning") or (command == "warnings") then
		ToggleWarnings();
	elseif (command == "analyze") or (command == "settip") then
		AnalyzeItem(rest);
	elseif (command == "unrecognized") or (command == "unrecog") then
		DumpUnrecognizedItems();
	elseif (command == "parse") or (command == "text") or (command == "parseline") then
		ParseText(rest);
	elseif (command == "?") or (command == "help") or (command == "") then
		PrintCommandHelp();
	elseif (command == "locale") or (command == "dumplocaleinfo") then
		DumpLocaleInfo();
	else
		print("/sl "..msg.."   huh?");
	end;
end;
SLASH_STATLOGIC_SLASHCMD1 = "/sl";
	


-----------------
-- Debug Tools --
-----------------
local function debugPrint(text)
	if DEBUG == true then
		print(text)
	end
end

--5.0.4 (build 16016) GetPrimaryTalentTree() removed and replaced with GetSpecialization()
--Create a compatibility function for pre-Mists
local GetSpecializationBase = GetSpecialization;
local function GetSpecialization(isInspect, isPet)
--	local spec;
	if (wowBuildNo >= 16016) then --v5.0.4
		return GetSpecializationBase(isInspect, isPet);
	else
		return GetPrimaryTalentTree(isInspect, isPet);
	end;
	
	--print(spec);
	--return spec;
end;

--[[---------------------------------
  :SetTip(item)
-------------------------------------
Notes:
  * This is a debugging tool for localizers
  * Displays item in ItemRefTooltip
  * item:
  :;itemId : number - The numeric ID of the item. ie. 12345
  :;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
  :::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
  :;"itemName" : string - The Name of the Item, ex: "Hearthstone"
  :::The item must have been equiped, in your bags or in your bank once in this session for this to work.
  :;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
  number or string - itemId or "itemString" or "itemName" or "itemLink"
Returns:
  None
Example:
  StatLogic:SetTip("item:3185:0:0:0:0:0:1957")
-----------------------------------]]
function StatLogic:SetTip(item)
	local name, link, _, _, reqLv, _, _, _, itemType = GetItemInfo(item)
	if not link then
		DEFAULT_CHAT_FRAME:AddMessage("|c00ff0000Item not in local cache. Run '/item itemid' to quary server(requires Sniff addon).|r")
		return
	end
	ItemRefTooltip:ClearLines()
	ShowUIPanel(ItemRefTooltip)
	if ( not ItemRefTooltip:IsShown() ) then
		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
	end
	ItemRefTooltip:SetHyperlink(link)
end

-------------------------
-- Localization Tables --
-------------------------
--[[
Localization tips
1. Enable debugging in game with /sldebug
2. There are often ItemIDs in comments for you to check if the items works correctly in game
3. Use the addon Sniff(http://www.wowinterface.com/downloads/info6259/) to get a link in game from an ItemID, Usage: /item 19316
4. Atlas + AtlasLoot is also a good source of items to check
5. Red colored text output from debug means that line does not have a match
6. Building your own ItemStrings(ex: "item:28484:1503:0:2946:2945:0:0:0"): http://www.wowwiki.com/ItemString
   linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId
7. Getting a visual on your ItemString:
   a. Display the ItemRefTooltip by clicking on a link in chat
   b. /dump StatLogic:SetTip("item:23344:2746")
6. Testing Enchants:
   a. Obtain the enchantId from wowhead.
      EX: Find the enchantId for [Golden Spellthread]:
      Find the spell page for the enchant: http://www.wowhead.com/?spell=31370
      Under Spell Details, look for "Enchant Item Permanent (2746)"
      2746 is the enchantId
   b. We need an item to attach the enchant, I like to use [Scout's Pants] ID:23344. (/item 23344 if you don't have it in your cache)
      ItemString: "item:23344:2746"
   c. /dump StatLogic:GetSum("item:23344:2746")
--]]
--[[
-- Item Stat Scanning Procedure
-- Trim spaces using strtrim(text)
-- Strip color codes
-- 1. Fast Exclude - Exclude obvious lines that do not need to be checked
--    Exclude a string by matching the whole string, these strings are indexed in L.Exclude.
--    Exclude a string by looking at the first X chars, these strings are indexed in L.Exclude.
--    Exclude lines starting with '"'. (Flavor text)
--    Exclude lines that are not white and green and normal (normal for Frozen Wrath bonus)
-- 2. Whole Text Lookup - Mainly used for enchants or stuff without numbers
--    Whole strings are indexed in L.WholeTextLookup
-- 3. Single Plus Stat Check - "+10 Spirit"
--    String is matched with pattern L.SinglePlusStatCheck, 2 captures are returned.
--    If a match is found, the non-number capture is looked up in L.StatIDLookup.
-- 4. Single Equip Stat Check - "Equip: Increases attack power by 81."
--    String is matched with pattern L.SingleEquipStatCheck, 2 captures are returned.
--    If a match is found, the non-number capture is looked up in L.StatIDLookup.
-- 5. Pre Scan - Short list of patterns that will be checked before going into Deep Scan.
-- 6. Deep Scan - When all the above checks fail, we will use the Deep Scan, this is slow but only about 10% of the lines need it.
--    Strip leading "Equip: ", "Socket Bonus: ".
--    Strip trailing ".".
--    Separate the string using L.DeepScanSeparators.
--    Check if the separated strings are found in L.WholeTextLookup.
--    Try to match each separated string to patterns in L.DeepScanPatterns in order, patterns in L.DeepScanPatterns should have less inclusive patterns listed first and more inclusive patterns listed last.
--    If no match then separate the string using L.DeepScanWordSeparators, then check again.
--]]
--[[DEBUG stuff, no need to translate
textTable = {
  "Spell Damage +6 and Spell Hit Rating +5",
  "+3 Stamina, +4 Critical Strike Rating",
  "+26 Healing Spells & 2% Reduced Threat",
  "+3 Stamina/+4 Critical Strike Rating",
  "Socket Bonus: 2 mana per 5 sec.",
  "Equip: Increases damage and healing done by magical spells and effects by up to 150.",
  "Equip: Increases the spell critical strike rating of all party members within 30 yards by 28.",
  "Equip: Increases damage and healing done by magical spells and effects of all party members within 30 yards by up to 33.",
  "Equip: Increases healing done by magical spells and effects of all party members within 30 yards by up to 62.",
  "Equip: Increases your spell damage by up to 120 and your healing by up to 300.",
  "Equip: Restores 11 mana per 5 seconds to all party members within 30 yards.",
  "Equip: Increases healing done by spells and effects by up to 300.",
  "Equip: Increases attack power by 420 in Cat, Bear, Dire Bear, and Moonkin forms only.",
  "+10 Defense Rating/+10 Stamina/+15 Block Value", -- ZG Enchant
  "+26 Attack Power and +14 Critical Strike Rating", -- Swift Windfire Diamond ID:28556
  "+26 Healing Spells & 2% Reduced Threat", -- Bracing Earthstorm Diamond ID:25897
  "+6 Spell Damage, +5 Spell Crit Rating", -- Potent Ornate Topaz ID: 28123
  ----
  "Critical Rating +6 and Dodge Rating +5", -- Assassin's Fire Opal ID:30565
  "Healing +11 and 2 mana per 5 sec.", -- Royal Tanzanite ID: 30603
}
--]]
--local PatternLocale = {};
--local DisplayLocale = {};

local locale = GetLocale(); --BlizzardAPI  e.g. "enUS"
local noPatternLocale --flag is set if we have no matching PatternLocale, and are falling back to enUS
L = PatternLocale[locale]
if not L then
	noPatternLocale = true;
	L = PatternLocale.enUS;
	
	print(ORANGE_FONT_COLOR_CODE.."LibStatLogic"..FONT_COLOR_CODE_CLOSE..": Unknown locale "..locale..". Falling back to enUS."..FONT_COLOR_CODE_CLOSE);
	assert(L, "No PatternLocale information loaded!");
end

--[[
	You DON'T want to start with the enUS Pattern Locale table, and copy locale specific values into it.
	It is NOT correct to "fallback" to an enUS pattern entry when one does not exist in the current (non enUS) locale.
	That is because every entry in the enUS locale table is not valid for other locales. 
	This means you will attempt to match english patterns against German text.
	At best these patterns will never match.
	At worst these patterns will match the wrong things.
	
	But what we DO want is to use the language neutral entries (GlobalStrings.lua constants) automatically in all locales.
--]]
-- First, copy Exclude entries.
for k, v in pairs(PatternLocale.neutral.NeutralExclude) do
	L.Exclude[k] = v
end

-- Second, copy StatIDLookup entries that can be used like they are.
for k, v in pairs(PatternLocale.neutral.NeutralStatIDLookup) do
	L.StatIDLookup[k] = v
end

-- Third, copy StatIDLookup entries that contain placeholders and therefore must be processed first.
-- The implementation of this is language specific.
L.ProcessNeutralStatIDLookupPlaceholders(PatternLocale.neutral.NeutralStatIDLookupWithPlaceholders, L.StatIDLookup)


-- Setup any values from current DisplayLocale into enUSDisplayLocale, since that's the gold version
local function SetupDisplayLocale(locale, enUS)
	for k in pairs(enUS) do
		--If the k-th item is a table, the recursively call SetupDisplayLocale
		if type(enUS[k]) == "table" and type(locale[k]) == "table" then
			SetupDisplayLocale(locale[k], enUS[k])
		elseif locale[k] then
			enUS[k] = locale[k]
		end
	end
end

--copy DisplayLocale[locale] items into enUS
if DisplayLocale[locale] then
	SetupDisplayLocale(DisplayLocale[locale], DisplayLocale.enUS)
end
local D = DisplayLocale.enUS;


--Dispose of the unused global variables
PatternLocale = nil; 
DisplayLocale = nil;

local function EscapeRegularExpression(pattern)
	-- "." ==> "%."
	local s = string.gsub(pattern, "%.", "%%%.");

	return s;
end;

function string.replace(s, oldValue, newValue)
	oldValue = EscapeRegularExpression(oldValue);
	newValue = EscapeRegularExpression(newValue);

	return string.gsub(s, oldValue, newValue);
end;

--[[
	20120805
	With Mista of Panderia (5.0.1), item stat numbers are now given as localized numbers. e.g.:
		Before: "2632 Armor"
		After:  "2,632 Armor"
		
	This means that regular expressions of (%d+) to find a number, e.g.:
		String: 2632 Armor
		Find:   ^(%d+) Armor$
		
	Will no longer work. All references to (%d+) need to be replaced with (%d+[,%d]*)
	
		String: 2,632 Armor
		Find:   ^(%d+[,%d]*) Armor$
		
	For this purpose there are 4 localization (L) entries
		L.LOCALE_STHOUSAND  The current locale's thousand's separator (e.g. enUS: ","  deDE: "." )
		L.LOCALE_SDECIMAL   The current locale's decimal separator (e.g. enUS: "."   deDE: "," )
		L.patNumber         The regular expression to find an Integer number (e.g. 1.234.567)
		L.patDecimal        The regular expression to find a Decimal number  (e.g. 1.234.567,80)

	The problem then is to remove the comma and parse the remaining number.	
	
	lua's tonumber(string) will not handle commas:
	
		tonumber("123")    -> 123
		tonumber("123.45") -> 123.45
		tonumber("1,234")  -> nil
	
	So we need to first remove the commas:
	
		string.gsub("1,234", ",", "") -> "1234"
		
	But, we also have to handle the nonsense part that in Germany, number's are *displayed* as:
			1.234,56
			
	but Lua's tonumber() funtion, even on deDE client, can only understand:
			1234.56
			
	e.g.
			/dump tonumber("5.50")
			5.5
			/dump tonumber("5,50")
			nil
			/dump tonumber("1,234.56")
			nil
			/dump tonumber("1.234,56")
			nil

			/dump GetLocale()
			"deDE"	
			
	So we have to replace the DecimalSeparator with a period.
--]]
function CNumberEx(value, base, localization)
	--[[
	if (value == nil) then
		error("Cannot convert nil to a number", 2);
	end;
	--]]
	assert(localization, "CNumberEx: Argument localization is nil");
	
	local t = type(value);
	if (t == "string") then
		--print("Stripping thousands \""..(localization.LOCALE_STHOUSAND).."\"");
		
		--strip out potential thousand's separators
		assert(localization.LOCALE_STHOUSAND);
		local s = string.replace(value, localization.LOCALE_STHOUSAND, ""); --You can't use %p; it fails with numbers like 1,234.5 (Unit Testing)
		
		--print("New string: \""..s.."\"");
		
		--convert any decimal markers into a "." (period)
		assert(localization.LOCALE_SDECIMAL);
		if (localization.LOCALE_SDECIMAL ~= ".") then
			s = string.replace(s, localization.LOCALE_SDECIMAL, "."); --You can't use %p, it fails with numbers like 1,234.5 (Unit Testing)
		end;
		
		--print("decimal's fixed: \""..s.."\"");
		
		local n = tonumber(s, base);
		return n;
		--if n then
		--	return n;
		--else
		--	error(string.format("Could not convert value \"%s\" to a number.", value), 2);
		--end;
	else
		local n = tonumber(value, base);
		return n;
		--if n then
		--	return n;
		--else
		--	error(string.format("Could not convert value \"%s\" to a number.", value), 2);
		--end;
	end;
end;

function CNumber(value, base)
	return CNumberEx(value, base, L);
end;

--Create a tonumber function inside our localization table that is the same as CNumber
L["tonumber"] = CNumber;
--[[	
	["tonumber"] = function(s)
		local n = tonumber(s);
		if n then
			return n;
		else
			--strip thousands separators
			return tonumber((gsub(s, LOCALE_STHOUSAND, "")));
		end
	end,
--]]	

-- Add all lower case strings to ["StatIDLookup"]
local strutf8lower = string.utf8lower
local temp = {}
for k, v in pairs(L.StatIDLookup) do
	temp[strutf8lower(k)] = v
end
for k, v in pairs(temp) do
	L.StatIDLookup[k] = v
end
temp = nil

--[[---------------------------------
  :GetStatNameFromID(stat)
-------------------------------------
Notes:
  * Returns localized names for stat
Arguments:
  string - "StatID". ex: "DODGE", "DODGE_RATING"
Returns:
  ; "longName" : string - The full name for stat.
  ; "shortName" : string - The short name for stat.
Example:
  local longName, shortName = StatLogic:GetStatNameFromID("FIRE_RES") -- "Fire Resistance", "FR"
-----------------------------------]]
function StatLogic:GetStatNameFromID(stat)
	local name = D.StatIDToName[stat]
	if not name then return end
	return unpack(name)
end


-----------
-- Cache --
-----------
local cache = {}
setmetatable(cache, {__mode = "kv"}) -- weak table to enable garbage collection


--------------
-- Activate --
--------------
-- When a newer version is registered
local tip = StatLogic.tip
if not tip then
	-- Create a custom tooltip for scanning
	tip = CreateFrame("GameTooltip", MAJOR.."Tooltip", nil, "GameTooltipTemplate")
	StatLogic.tip = tip
	tip:SetOwner(UIParent, "ANCHOR_NONE")
	for i = 1, 40 do
		tip[i] = _G[MAJOR.."TooltipTextLeft"..i]
		if not tip[i] then
			tip[i] = tip:CreateFontString()
			tip:AddFontStrings(tip[i], tip:CreateFontString())
			_G[MAJOR.."TooltipTextLeft"..i] = tip[i]
		end
	end
elseif not _G[MAJOR.."TooltipTextLeft40"] then
	for i = 1, 40 do
		_G[MAJOR.."TooltipTextLeft"..i] = tip[i]
	end
end
local tipMiner = StatLogic.tipMiner
if not tipMiner then
	-- Create a custom tooltip for data mining
	tipMiner = CreateFrame("GameTooltip", MAJOR.."MinerTooltip", nil, "GameTooltipTemplate")
	StatLogic.tipMiner = tipMiner
	tipMiner:SetOwner(UIParent, "ANCHOR_NONE")
	for i = 1, 40 do
		tipMiner[i] = _G[MAJOR.."MinerTooltipTextLeft"..i]
		if not tipMiner[i] then
			tipMiner[i] = tipMiner:CreateFontString()
			tipMiner:AddFontStrings(tipMiner[i], tipMiner:CreateFontString())
			_G[MAJOR.."MinerTooltipTextLeft"..i] = tipMiner[i]
		end
	end
elseif not _G[MAJOR.."MinerTooltipTextLeft40"] then
	for i = 1, 40 do
		_G[MAJOR.."MinerTooltipTextLeft"..i] = tipMiner[i]
	end
end
local StatLogicMinerTooltipTextLeft5 = _G[MAJOR.."MinerTooltipTextLeft5"]
local StatLogicMinerTooltipTextLeft6 = _G[MAJOR.."MinerTooltipTextLeft6"]

---------------------
-- Local Variables --
---------------------
-- Player info
local _, playerClass, playerClassID = UnitClass("player"); --localizedClassName, className, classID
local _, playerRace = UnitRace("player");

-- Localize globals
local tonumber = L.tonumber; --Use the localized version of tonumber from localization table L
local _G = getfenv(0)
local strfind = strfind
local strsub = strsub
local strupper = strupper
local strmatch = strmatch
local strtrim = strtrim
local strsplit = strsplit
local strjoin = strjoin
local gmatch = gmatch
local gsub = gsub
local wipe = wipe
local pairs = pairs
local ipairs = ipairs
local type = type
local unpack = unpack
local strutf8lower = string.utf8lower
local strutf8sub = string.utf8sub
local GetInventoryItemLink = GetInventoryItemLink
local IsUsableSpell = IsUsableSpell
local UnitLevel = UnitLevel
local UnitStat = UnitStat
local GetShapeshiftForm = GetShapeshiftForm
local GetShapeshiftFormInfo = GetShapeshiftFormInfo
local GetTalentInfo = GetTalentInfo
local GetInventoryItemID = GetInventoryItemID
local GetSpellInfo = GetSpellInfo
local GetCVarBool = GetCVarBool

-- Cached GetItemInfo
local GetItemInfoCached = setmetatable({}, { __index = function(self, n)
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemSellValue = GetItemInfo(n)
		if itemName then
			-- store in cache only if it exists in the local cache
			self[n] = {itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemSellValue}
			return self[n] -- return result
		end
	end })
local GetItemInfo = function(item)
	local info = GetItemInfoCached[item]
	if info then
		return unpack(info)
	end
end
StatLogic.GetItemInfo = GetItemInfo

-- taken from lua programming gems
local function memoize(f)
	local mem = {} -- memoizing table
	return function(x)
		if not mem[x] then
			mem[x] = f(x)
		end
		return mem[x]
	end
end
local loadstring = memoize(loadstring)

---------------
-- Lua Tools --
---------------
-- metatable for stat tables
local statTableMetatable = {
	__add = function(op1, op2)
		if type(op2) == "table" then
			for k, v in pairs(op2) do
				if type(v) == "number" then
					op1[k] = (op1[k] or 0) + v
					if op1[k] == 0 then
						op1[k] = nil
					end
				end
			end
		end
		return op1
	end,
	__sub = function(op1, op2)
		if type(op2) == "table" then
			for k, v in pairs(op2) do
				if type(v) == "number" then
					op1[k] = (op1[k] or 0) - v
					if op1[k] == 0 then
						op1[k] = nil
					end
				elseif k == "itemType" then
					local i = 1
					while op1["diffItemType"..i] do
						i = i + 1
					end
					op1["diffItemType"..i] = op2.itemType
				end
			end
		end
		return op1
	end,
}

-- Table pool borrowed from Tablet-2.0 (ckknight) --
local pool = {}

-- Delete table and return to pool
local function del(t)
	if t then
		for k in pairs(t) do
			t[k] = nil
		end
		setmetatable(t, nil)
		pool[t] = true
	end
end

local function delMulti(t)
	if t then
		for k in pairs(t) do
			if type(t[k]) == "table" then
				del(t[k])
			else
				t[k] = nil
			end
		end
		setmetatable(t, nil)
		pool[t] = true
	end
end

-- Copy table
local function copy(parent)
	local t = next(pool) or {}
	pool[t] = nil
	if parent then
		for k,v in pairs(parent) do
			t[k] = v
		end
		setmetatable(t, getmetatable(parent))
	end
	return t
end

-- New table
local function new(...)
	local t = next(pool) or {}
	pool[t] = nil

	for i = 1, select('#', ...), 2 do
		local k = select(i, ...)
		if k then
			t[k] = select(i+1, ...)
		else
			break
		end
	end
	return t
end

-- New stat table
local function newStatTable(...)
	local t = next(pool) or {}
	pool[t] = nil
	setmetatable(t, statTableMetatable)

	for i = 1, select('#', ...), 2 do
		local k = select(i, ...)
		if k then
			t[k] = select(i+1, ...)
		else
			break
		end
	end
	return t
end

StatLogic.StatTable = {}
StatLogic.StatTable.new = newStatTable
StatLogic.StatTable.del = del
StatLogic.StatTable.copy = copy

-- End of Table pool --

-- deletes the contents of a table, then returns itself
local function clearTable(t)
	if t then
		for k in pairs(t) do
			if type(t[k]) == "table" then
				del(t[k]) -- child tables get put into the pool
			else
				t[k] = nil
			end
		end
		setmetatable(t, nil)
	end
	return t
end

-- copyTable
local function copyTable(to, from)
	if not clearTable(to) then
		to = new()
	end
	for k,v in pairs(from) do
		if type(k) == "table" then
			k = copyTable(new(), k)
		end
		if type(v) == "table" then
			v = copyTable(new(), v)
		end
		to[k] = v
	end
	setmetatable(to, getmetatable(from))
	return to
end

-- Taken from AceLibrary
function StatLogic:argCheck(arg, num, kind, kind2, kind3, kind4, kind5)
	if type(num) ~= "number" then
		return error(string.format("Bad argument #3 to `argCheck' (number expected, got %s)", type(num)), 2);
	elseif type(kind) ~= "string" then
		return error(string.format("Bad argument #4 to `argCheck' (string expected, got %s)", type(kind)), 2);
	end
	arg = type(arg)
	if arg ~= kind and arg ~= kind2 and arg ~= kind3 and arg ~= kind4 and arg ~= kind5 then
		local stack = debugstack()
		local func = stack:match("`argCheck'.-([`<].-['>])")
		if not func then
			func = stack:match("([`<].-['>])")
		end
		if kind5 then
			return error(string.format("Bad argument #%s to %s (%s, %s, %s, %s, or %s expected, got %s)", tonumber(num) or 0/0, func, kind, kind2, kind3, kind4, kind5, arg), 2);
		elseif kind4 then
			return error(string.format("Bad argument #%s to %s (%s, %s, %s, or %s expected, got %s)", tonumber(num) or 0/0, func, kind, kind2, kind3, kind4, arg), 2);
		elseif kind3 then
			return error(string.format("Bad argument #%s to %s (%s, %s, or %s expected, got %s)", tonumber(num) or 0/0, func, kind, kind2, kind3, arg), 2);
		elseif kind2 then
			return error(string.format("Bad argument #%s to %s (%s or %s expected, got %s)", tonumber(num) or 0/0, func, kind, kind2, arg), 2);
		else
			return error(string.format("Bad argument #%s to %s (%s expected, got %s)", tonumber(num) or 0/0, func, kind, arg), 2);
		end
	end
end

--Starting with 5.0.4, Blizzard's UnitClass() function now also returns a "classID" number.
--But since they don't define the constants themselves, and we've always used numeric constants
--we'll adopt their numbers, and define the matching constants
local CLASSID_WARRIOR = 1;
local CLASSID_PALADIN = 2;
local CLASSID_HUNTER = 3;
local CLASSID_ROGUE = 4;
local CLASSID_PRIEST = 5;
local CLASSID_DEATHKNIGHT = 6;
local CLASSID_SHAMAN = 7;
local CLASSID_MAGE = 8;
local CLASSID_WARLOCK = 9;
local CLASSID_MONK = 10;
local CLASSID_DRUID = 11;
local CLASSID_MAX = CLASSID_DRUID; --the highest valid classID

local CR_PVP_POWER = 27; --copied from Constants.lua until Mists launches
local CR_MAX = CR_PVP_POWER; --Maximum possible CombatRating constant. Some code checks for passed combat rating value being too high.

--[[---------------------------------
  :GetClassIdOrName(class)
-------------------------------------
Notes:
  * Converts ClassID to and from "ClassName"
  * class:
  :{| class="wikitable"
  !ClassID!!"ClassName"
  |-
  |1||"WARRIOR"
  |-
  |2||"PALADIN"
  |-
  |3||"HUNTER"
  |-
  |4||"ROGUE"
  |-
  |5||"PRIEST"
  |-
  |6||"DEATHKNIGHT"
  |-
  |7||"SHAMAN"
  |-
  |8||"MAGE"
  |-
  |9||"WARLOCK"
  |-
  |10||"MONK"
  |-
  |11||"DRUID"
  |}
Arguments:
  number or string - ClassID or "ClassName"
Returns:
  None
Example:
  StatLogic:GetClassIdOrName("WARRIOR") -- 1
  StatLogic:GetClassIdOrName(10) -- "DRUID"
-----------------------------------]]
local ClassNameToID = {
	"WARRIOR", --1
	"PALADIN", --2
	"HUNTER",  --3
	"ROGUE",   --4
	"PRIEST",  --5
	"DEATHKNIGHT", --6
	"SHAMAN", --7
	"MAGE", --8
	"WARLOCK", --9
	"MONK", --10
	"DRUID", --11
	["WARRIOR"] = 1,
	["PALADIN"] = 2,
	["HUNTER"] = 3,
	["ROGUE"] = 4,
	["PRIEST"] = 5,
	["DEATHKNIGHT"] = 6,
	["SHAMAN"] = 7,
	["MAGE"] = 8,
	["WARLOCK"] = 9,
	["MONK"] = 10,
	["DRUID"] = 11,
}

function StatLogic:GetClassIdOrName(class)
  return ClassNameToID[class]
end

--[[ Interface\FrameXML\PaperDollFrame.lua
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
COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15; formerly CR_CRIT_TAKEN_MELEE
COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16;  formerly CR_CRIT_TAKEN_RANGED
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
CR_ARMOR_PENETRATION = 25;
CR_MASTERY = 26;
CR_PVP_POWER = 27;
--]]

--这些常量在 6.0 beta 内测时被取消了 
CR_WEAPON_SKILL = 1
CR_HIT_TAKEN_MELEE = 12
CR_HIT_TAKEN_RANGED = 13
CR_HIT_TAKEN_SPELL = 14
COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16 
CR_CRIT_TAKEN_SPELL = 17
CR_WEAPON_SKILL_MAINHAND = 21
CR_WEAPON_SKILL_OFFHAND = 22


local RatingNameToID = {
	[CR_WEAPON_SKILL] = "WEAPON_RATING",
	[CR_DEFENSE_SKILL] = "DEFENSE_RATING",
	[CR_DODGE] = "DODGE_RATING",
	[CR_PARRY] = "PARRY_RATING",
	[CR_BLOCK] = "BLOCK_RATING",
	[CR_HIT_MELEE] = "MELEE_HIT_RATING",
	[CR_HIT_RANGED] = "RANGED_HIT_RATING",
	[CR_HIT_SPELL] = "SPELL_HIT_RATING",
	[CR_CRIT_MELEE] = "MELEE_CRIT_RATING",
	[CR_CRIT_RANGED] = "RANGED_CRIT_RATING",
	[CR_CRIT_SPELL] = "SPELL_CRIT_RATING",
	[CR_HIT_TAKEN_MELEE] = "MELEE_HIT_AVOID_RATING",
	[CR_HIT_TAKEN_RANGED] = "RANGED_HIT_AVOID_RATING",
	[CR_HIT_TAKEN_SPELL] = "SPELL_HIT_AVOID_RATING",
	[COMBAT_RATING_RESILIENCE_CRIT_TAKEN] = "MELEE_CRIT_AVOID_RATING", --"PvP Resilience" = damage reduction from players. Both combat ratings (melee and ranged) return same value.
	[COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN] = "RANGED_CRIT_AVOID_RATING", --"PvP Resilience" = damage reduction from players. Both combat ratings (melee and ranged) return same value.
	[CR_CRIT_TAKEN_SPELL] = "SPELL_CRIT_AVOID_RATING",
	[CR_HASTE_MELEE] = "MELEE_HASTE_RATING",
	[CR_HASTE_RANGED] = "RANGED_HASTE_RATING",
	[CR_HASTE_SPELL] = "SPELL_HASTE_RATING",
	[CR_WEAPON_SKILL_MAINHAND] = "MAINHAND_WEAPON_RATING",
	[CR_WEAPON_SKILL_OFFHAND] = "OFFHAND_WEAPON_RATING",
	[CR_WEAPON_SKILL_RANGED] = "RANGED_WEAPON_RATING",
	[CR_EXPERTISE] = "EXPERTISE_RATING",
	[CR_ARMOR_PENETRATION] = "ARMOR_PENETRATION_RATING",
	[CR_MASTERY] = "MASTERY_RATING",
	[CR_PVP_POWER] = "PVP_POWER", --27;
	["DEFENSE_RATING"] = CR_DEFENSE_SKILL,
	["DODGE_RATING"] = CR_DODGE,
	["PARRY_RATING"] = CR_PARRY,
	["BLOCK_RATING"] = CR_BLOCK,
	["MELEE_HIT_RATING"] = CR_HIT_MELEE,
	["RANGED_HIT_RATING"] = CR_HIT_RANGED,
	["SPELL_HIT_RATING"] = CR_HIT_SPELL,
	["MELEE_CRIT_RATING"] = CR_CRIT_MELEE,
	["RANGED_CRIT_RATING"] = CR_CRIT_RANGED,
	["SPELL_CRIT_RATING"] = CR_CRIT_SPELL,
	["MELEE_HIT_AVOID_RATING"] = CR_HIT_TAKEN_MELEE,
	["RANGED_HIT_AVOID_RATING"] = CR_HIT_TAKEN_RANGED,
	["SPELL_HIT_AVOID_RATING"] = CR_HIT_TAKEN_SPELL,
	["MELEE_CRIT_AVOID_RATING"] = COMBAT_RATING_RESILIENCE_CRIT_TAKEN,
	["RANGED_CRIT_AVOID_RATING"] = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN,
	["SPELL_CRIT_AVOID_RATING"] = CR_CRIT_TAKEN_SPELL,
	["RESILIENCE_RATING"] = COMBAT_RATING_RESILIENCE_CRIT_TAKEN,
	["MELEE_HASTE_RATING"] = CR_HASTE_MELEE,
	["RANGED_HASTE_RATING"] = CR_HASTE_RANGED,
	["SPELL_HASTE_RATING"] = CR_HASTE_SPELL,
	["DAGGER_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["SWORD_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_SWORD_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["AXE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_AXE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["MACE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["2H_MACE_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["GUN_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["CROSSBOW_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["BOW_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["FERAL_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["FIST_WEAPON_RATING"] = CR_WEAPON_SKILL,
	["WEAPON_RATING"] = CR_WEAPON_SKILL,
	["MAINHAND_WEAPON_RATING"] = CR_WEAPON_SKILL_MAINHAND,
	["OFFHAND_WEAPON_RATING"] = CR_WEAPON_SKILL_OFFHAND,
	["RANGED_WEAPON_RATING"] = CR_WEAPON_SKILL_RANGED,
	["EXPERTISE_RATING"] = CR_EXPERTISE,
	["ARMOR_PENETRATION_RATING"] = CR_ARMOR_PENETRATION,
	["MASTERY_RATING"] = CR_MASTERY, --26
	["PVP_POWER"] = CR_PVP_POWER, --27
}

--[[---------------------------------
  :GetRatingIdOrName(rating)
-------------------------------------
Notes:
  * Converts RatingID to and from "StatID"
  * rating:
  :;RatingID : number - As defined in PaperDollFrame.lua of Blizzard default ui
  :;"StatID" : string - The the key values of the DisplayLocale table in StatLogic
  :{| class="wikitable"
  !RatingID!!"StatID"
  |-
  |CR_WEAPON_SKILL||"WEAPON_RATING"
  |-
  |CR_DEFENSE_SKILL||"DEFENSE_RATING"
  |-
  |CR_DODGE||"DODGE_RATING"
  |-
  |CR_PARRY||"PARRY_RATING"
  |-
  |CR_BLOCK||"BLOCK_RATING"
  |-
  |CR_HIT_MELEE||"MELEE_HIT_RATING"
  |-
  |CR_HIT_RANGED||"RANGED_HIT_RATING"
  |-
  |CR_HIT_SPELL||"SPELL_HIT_RATING"
  |-
  |CR_CRIT_MELEE||"MELEE_CRIT_RATING"
  |-
  |CR_CRIT_RANGED||"RANGED_CRIT_RATING"
  |-
  |CR_CRIT_SPELL||"SPELL_CRIT_RATING"
  |-
  |CR_HIT_TAKEN_MELEE||"MELEE_HIT_AVOID_RATING"
  |-
  |CR_HIT_TAKEN_RANGED||"RANGED_HIT_AVOID_RATING"
  |-
  |CR_HIT_TAKEN_SPELL||"SPELL_HIT_AVOID_RATING"
  |-
  |COMBAT_RATING_RESILIENCE_CRIT_TAKEN||"MELEE_CRIT_AVOID_RATING"
  |-
  |COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN||"RANGED_CRIT_AVOID_RATING"
  |-
  |CR_CRIT_TAKEN_SPELL||"SPELL_CRIT_AVOID_RATING"
  |-
  |CR_HASTE_MELEE||"MELEE_HASTE_RATING"
  |-
  |CR_HASTE_RANGED||"RANGED_HASTE_RATING"
  |-
  |CR_HASTE_SPELL||"SPELL_HASTE_RATING"
  |-
  |CR_WEAPON_SKILL_MAINHAND||"MAINHAND_WEAPON_RATING"
  |-
  |CR_WEAPON_SKILL_OFFHAND||"OFFHAND_WEAPON_RATING"
  |-
  |CR_WEAPON_SKILL_RANGED||"RANGED_WEAPON_RATING"
  |-
  |CR_EXPERTISE||"EXPERTISE_RATING"
  |-
  |CR_ARMOR_PENETRATION||"ARMOR_PENETRATION_RATING"
  |}
Arguments:
  number or string - RatingID or "StatID"
Returns:
  None
Example:
  StatLogic:GetRatingIdOrStatId("CR_WEAPON_SKILL") -- 1
  StatLogic:GetRatingIdOrStatId("DEFENSE_RATING") -- 2
  StatLogic:GetRatingIdOrStatId("DODGE_RATING") -- 3
  StatLogic:GetRatingIdOrStatId(CR_PARRY) -- "PARRY_RATING"
-----------------------------------]]
function StatLogic:GetRatingIdOrStatId(rating)
	return RatingNameToID[rating]
end

local RatingIDToConvertedStat = {
	"WEAPON_SKILL",			--CR_WEAPON_SKILL	1
	"DEFENSE",				--CR_DEFENSE_SKILL	2
	"DODGE",				--CR_DODGE	3
	"PARRY",				--CR_PARRY	4
	"BLOCK",				--CR_BLOCK	5
	"MELEE_HIT",			--CR_HIT_MELEE	6
	"RANGED_HIT",			--CR_HIT_RANGED	7
	"SPELL_HIT",			--CR_HIT_SPELL	8
	"MELEE_CRIT",			--CR_CRIT_MELEE	9
	"RANGED_CRIT",			--CR_CRIT_RANGED	10
	"SPELL_CRIT",			--CR_CRIT_SPELL	11
	"MELEE_HIT_AVOID",		--CR_HIT_TAKEN_MELEE	12
	"RANGED_HIT_AVOID",		--CR_HIT_TAKEN_RANGED	13
	"SPELL_HIT_AVOID",		--CR_HIT_TAKEN_SPELL	14
	"MELEE_CRIT_AVOID",		--COMBAT_RATING_RESILIENCE_CRIT_TAKEN	15
	"PLAYER_DAMAGE_TAKEN",	--COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN	16
	"SPELL_CRIT_AVOID",		--CR_CRIT_TAKEN_SPELL	18
	"MELEE_HASTE",			--CR_HASTE_MELEE	18
	"RANGED_HASTE",			--CR_HASTE_RANGED	19
	"SPELL_HASTE",			--CR_HASTE_SPELL	20
	"WEAPON_SKILL",			--CR_WEAPON_SKILL_MAINHAND	21
	"WEAPON_SKILL",			--CR_WEAPON_SKILL_OFFHAND	22
	"WEAPON_SKILL",			--CR_WEAPON_SKILL_RANGED	23
	"EXPERTISE",			--CR_EXPERTISE	24
	"ARMOR_PENETRATION",	--CR_ARMOR_PENETRATION	25
	"MASTERY",				--CR_MASTERY	26
	"PVP_POWER",			--CR_PVP_POWER	27
}


----------------
-- Stat Tools --
----------------
local function StripGlobalStrings(text)
	-- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	text = gsub(text, "%%%%", "%%") -- "%%" -> "%"
	text = gsub(text, " ?%%%d?%.?%d?%$?[cdsgf]", "") -- delete "%d", "%s", "%c", "%g", "%2$d", "%.2f" and a space in front of it if found
	-- So StripGlobalStrings(ITEM_SOCKET_BONUS) = "Socket Bonus:"
	return text
end

local function GetStanceIcon()
	local currentStance = GetShapeshiftForm()
	if currentStance ~= 0 then
		return GetShapeshiftFormInfo(currentStance)
	end
end
StatLogic.GetStanceIcon = GetStanceIcon

local function PlayerHasAura(aura)
	return UnitBuff("player", aura or "") or UnitDebuff("player", aura or "")
end
StatLogic.PlayerHasAura = PlayerHasAura


local function GetPlayerAuraRankStack(buff)
	--name, rank, icon, stack, debuffType, duration, expirationTime, isMine, isStealable = UnitAura("player", buff)
	local name, rank, _, stack = UnitBuff("player", buff)
	if not name then -- if not a buff, check for debuff
		name, rank, _, stack = UnitDebuff("player", buff)
	end
	if name then
		if not stack or stack == 0 then
			stack = 1
		end
		return tonumber(strmatch(rank, "(%d+)") or 1), stack
	end
end
StatLogic.GetPlayerAuraRankStack = GetPlayerAuraRankStack

--[[
	20120812 - Removed, as defense no longer exists in the game
local function GetTotalDefense(unit)
	local base, modifier = UnitDefense(unit);
	return base + modifier
end
--]]

local function PlayerHasGlyph(glyph, talentGroup)
	for i = 1, 9 do
		local _, _, _, glyphSpellID = GetGlyphSocketInfo(i, talentGroup)
		if glyphSpellID == glyph then
			return true
		end
	end
end
StatLogic.PlayerHasGlyph = PlayerHasGlyph

---------------
-- Item Sets --
---------------
local SetToItem  = {
	-- SetID comes from ItemSet.dbc
	[571] = {24264, 24261}, -- Whitemend Wisdom - Increases spell power by 10% of your total Intellect.
	[552] = {21848, 21847, 21846}, -- Wrath of Spellfire - Increases spell power by 7% of your total Intellect.
}
-- Build ItemToSet from SetToItem
local ItemToSet = {}
for set, items in pairs(SetToItem) do
	for _, item in pairs(items) do
		ItemToSet[item] = set
	end
end

-- Create a frame
local ItemSetFrame = StatLogic.ItemSetFrame
if not ItemSetFrame then
	ItemSetFrame = CreateFrame("Frame", "StatLogicItemSetFrame")
	StatLogic.ItemSetFrame = ItemSetFrame
else
	ItemSetFrame:UnregisterAllEvents()
end

--[[
PlayerItemSets = {
  [844] = 4,
}
--]]
local PlayerItemSets = {}
-- API
function StatLogic:PlayerHasItemSet(itemset)
	return PlayerItemSets[itemset]
end
-- Don't set any scripts if the class doesn't have any sets to check
if table.maxn(ItemToSet) ~= 0 then
	local WatchInventoryID = {
		(GetInventorySlotInfo("HeadSlot")),
		(GetInventorySlotInfo("ShoulderSlot")),
		(GetInventorySlotInfo("ChestSlot")),
		(GetInventorySlotInfo("HandsSlot")),
		(GetInventorySlotInfo("LegsSlot")),
	}
	local function UpdatePlayerItemSets()
		wipe(PlayerItemSets)
		for _, slot in pairs(WatchInventoryID) do
			local set = ItemToSet[GetInventoryItemID('player', slot)]
			if set then
				PlayerItemSets[set] = (PlayerItemSets[set] or 0) + 1
			end
		end
	end
	-- we will schedule this since PLAYER_EQUIPMENT_CHANGED fires multiple times when you switch whole sets
	ItemSetFrame:SetScript("OnUpdate", function(self, elapsed)
		if self.updateTime and (GetTime() >= self.updateTime) then
			self.updateTime = nil
			UpdatePlayerItemSets()
		end
	end)
	ItemSetFrame:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
	ItemSetFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	function ItemSetFrame:PLAYER_EQUIPMENT_CHANGED()
		self.updateTime = GetTime() + 0.1 -- 0.1 sec delay
	end
	-- Initialize on PLAYER_LOGIN
	if (IsLoggedIn()) then -- LOD
		UpdatePlayerItemSets()
	else
		ItemSetFrame:RegisterEvent("PLAYER_LOGIN")
		function ItemSetFrame:PLAYER_LOGIN()
			UpdatePlayerItemSets()
		end
	end
end

--================================--
-- Armor Specialization Detection --
--================================--
--Returns the kind of armor that the class must have equipped in order to get the Armor Specialization bonus
local ArmorSpecClasses = {
	["WARRIOR"] =     L["Plate"],
	["PALADIN"] =     L["Plate"],
	["HUNTER"]  =     L["Mail"],
	["ROGUE"]   =     L["Leather"],
	--["PRIEST"] =    nil, --Priests don't get armor specialization since they can only *wear* cloth
	["DEATHKNIGHT"] = L["Plate"],
	["SHAMAN"] =      L["Mail"],
	--["MAGE"] =      nil, --Mage's don't get armor specialization since they can only *wear* cloth
	--["WARLOCK"] =   nil, --Mage's don't get armor specialization since they can only *wear* cloth
	["MONK"] =        L["Leather"], --20120809: Sure, add Monks. Cloth->Leather
	["DRUID"] =       L["Leather"],
}

-- Create a frame
local ArmorSpecFrame = StatLogic.ArmorSpecFrame;
if not ArmorSpecFrame then
	ArmorSpecFrame = CreateFrame("Frame", "StatLogicItemSetFrame")
	StatLogic.ArmorSpecFrame = ArmorSpecFrame
else
	ArmorSpecFrame:UnregisterAllEvents()
end

-- ArmorSpecActive =
-- nil: You have an empty or non-spec armor slot
-- 0: Appropreate armor in all slots but unspeced
-- 1, 2, 3: Appropreate armor in all slots, then its your GetSpecialization()
local ArmorSpecActive = nil;
local playerArmorType = ArmorSpecClasses[playerClass];
-- Don't set any scripts if cloth class
if playerArmorType then
	-- All 8 slots needs to have something equipped in order to receive the bonus
	local WatchInventoryID = {
		(GetInventorySlotInfo("HeadSlot")),
		(GetInventorySlotInfo("ShoulderSlot")),
		(GetInventorySlotInfo("ChestSlot")),
		(GetInventorySlotInfo("WristSlot")),
		(GetInventorySlotInfo("HandsSlot")),
		(GetInventorySlotInfo("WaistSlot")),
		(GetInventorySlotInfo("LegsSlot")),
		(GetInventorySlotInfo("FeetSlot")),
	}
	local function UpdateArmorSpecActive()
		ArmorSpecActive = nil
		for _, slot in pairs(WatchInventoryID) do
			local item = GetInventoryItemID('player', slot)
			if not item then return end
			if (select(7, GetItemInfo(item))) ~= playerArmorType then return end
		end
		-- all pass
		ArmorSpecActive = GetSpecialization() or 0  --5.0.1  GetPrimaryTalentTree replace with GetSpecialization
		--debugPrint(ArmorSpecActive);
	end
	-- we will schedule this since PLAYER_EQUIPMENT_CHANGED fires multiple times when you switch whole sets
	ArmorSpecFrame:SetScript("OnUpdate", function(self, elapsed)
		if self.updateTime and (GetTime() >= self.updateTime) then
			self.updateTime = nil
			UpdateArmorSpecActive()
		end
	end)
	ArmorSpecFrame:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
	ArmorSpecFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	ArmorSpecFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
	function ArmorSpecFrame:PLAYER_EQUIPMENT_CHANGED()
		self.updateTime = GetTime() + 0.1 -- 0.1 sec delay
	end
	function ArmorSpecFrame:PLAYER_TALENT_UPDATE()
		self.updateTime = GetTime() + 0.1 -- 0.1 sec delay
	end
	-- Initialize on PLAYER_LOGIN
	if (IsLoggedIn()) then -- LOD
		UpdateArmorSpecActive()
	else
		ArmorSpecFrame:RegisterEvent("PLAYER_LOGIN")
		function ArmorSpecFrame:PLAYER_LOGIN()
			UpdateArmorSpecActive()
		end
	end
end

--============--
-- Base Stats --
--============--
--[[
local RaceClassStatBase = {
  -- The Human Spirit - Increase Spirit by 5%
  Human = { --{20, 20, 20, 20, 21}
    WARRIOR = { --{3, 0, 2, 0, 0}
      {23, 20, 22, 20, 22}
    },
    PALADIN = { --{2, 0, 2, 0, 1}
      {22, 20, 22, 20, 23}
    },
    ROGUE = { --{1, 3, 1, 0, 0}
      {21, 23, 21, 20, 22}
    },
    PRIEST = { --{0, 0, 0, 2, 3}
      {20, 20, 20, 22, 25}
    },
    MAGE = { --{0, 0, 0, 3, 2}
      {20, 20, 20, 23, 24}
    },
    WARLOCK = { --{0, 0, 1, 2, 2}
      {20, 20, 21, 22, 24}
    },
  },
  Dwarf = { --{22, 16, 23, 19, 19}
    WARRIOR = {
      {25, 16, 25, 19, 19}
    },
    PALADIN = {
      {24, 16, 25, 19, 20}
    },
    HUNTER = { --{0, 3, 1, 0, 1}
      {22, 19, 24, 19, 20}
    },
    ROGUE = {
      {23, 19, 24, 19, 19}
    },
    PRIEST = {
      {22, 16, 23, 21, 22}
    },
  },
  NightElf = { --{17, 25, 19, 20, 20}
    WARRIOR = {--{3, 0, 2, 0, 0}
      {20, 25, 21, 20, 20}
    },
    HUNTER = {
      {17, 28, 20, 20, 21}
    },
    ROGUE = {
      {18, 28, 20, 20, 20}
    },
    PRIEST = {
      {17, 25, 19, 22, 23}
    },
    DRUID = { --{1, 0, 0, 2, 2}
      {18, 25, 19, 22, 22}
    },
  },
  -- Expansive Mind - Increase Intelligence by 5%
  Gnome = { --{15, 23, 19, 24, 20}
    WARRIOR = {--{3, 0, 2, 0, 0}
      {18, 23, 21, 24, 20}
    },
    ROGUE = {
      {, , , , }
    },
    MAGE = {
      {, , , , }
    },
    WARLOCK = {
      {, , , , }
    },
  },
  Draenei = { --{21, 17, 19, 21, 22}
    WARRIOR = { --{3, 0, 2, 0, 0}
      {24, 17, 21, 21, 22}
    },
    PALADIN = { --{2, 0, 2, 0, 1}
      {23, 17, 21, 21, 23}
    },
    HUNTER = { --{0, 3, 1, 0, 1}
      {21, 20, 20, 21, 23}
    },
    PRIEST = { --{0, 0, 0, 2, 3}
      {21, 17, 19, 23, 25}
    },
    SHAMAN = { --{1, 0, 1, 1, 2}
      {26, 15, 23, 16, 24}
    },
    MAGE = { --{0, 0, 0, 3, 2}
      {21, 17, 19, 24, 24}
    },
  },
  Orc = { --{23, 17, 22, 17, 23}
    WARRIOR = {--{3, 0, 2, 0, 0}
      {26, 17, 24, 17, 23}
    },
    HUNTER = { --{0, 3, 1, 0, 1}
      {23, 20, 23, 17, 24}
    },
    ROGUE = { --{1, 3, 1, 0, 0}
      {, , , , }
    },
    SHAMAN = { --{1, 0, 1, 1, 2}
      {24, 17, 23, 18, 25}
    },
    WARLOCK = { --{0, 0, 1, 2, 2}
      {, , , , }
    },
  },
  Scourge = { --{19, 18, 21, 18, 25}
    WARRIOR = {--{3, 0, 2, 0, 0}
      {22, 18, 23, 18, 25}
    },
    ROGUE = {
      {, , , , }
    },
    PRIEST = {
      {, , , , }
    },
    MAGE = {
      {, , , , }
    },
    WARLOCK = {
      {, , , , }
    },
  },
  Tauren = { --{25, 15, 22, 15, 22}
    WARRIOR = {--{3, 0, 2, 0, 0}
      {28, 15, 24, 15, 22}
    },
    HUNTER = { --{0, 3, 1, 0, 1}
      {, , , , }
    },
    SHAMAN = {
      {, , , , }
    },
    DRUID = { --{1, 0, 0, 2, 2}
      {26, 15, 22, 17, 24}
    },
  },
  Troll = { --{21, 22, 21, 16, 21}
    WARRIOR = {--{3, 0, 2, 0, 0}
      {24, 22, 23, 16, 21}
    },
    HUNTER = { --{0, 3, 1, 0, 1}
      {, , , , }
    },
    ROGUE = {
      {, , , , }
    },
    PRIEST = {
      {, , , , }
    },
    SHAMAN = {
      {, , , , }
    },
    MAGE = {
      {, , , , }
    },
  },
  BloodElf = { --{17, 22, 18, 24, 19}
    PALADIN = {--{2, 0, 2, 0, 1}
      {24, 16, 25, 19, 20}
    },
    HUNTER = { --{0, 3, 1, 0, 1}
      {21, 25, 22, 16, 22}
    },
    ROGUE = {
      {, , , , }
    },
    PRIEST = {
      {, , , , }
    },
    MAGE = {
      {, , , , }
    },
    WARLOCK = {
      {, , , , }
    },
  },
}
--]]
--[[
20120810 There's not even any reference to this variable
local RaceBaseStat = {
	["Human"] = {20, 20, 20, 20, 21},
	["Dwarf"] = {22, 16, 23, 19, 19},
	["NightElf"] = {17, 25, 19, 20, 20},
	["Gnome"] = {15, 23, 19, 24, 20},
	["Draenei"] = {21, 17, 19, 21, 22},
	["Orc"] = {23, 17, 22, 17, 23},
	["Scourge"] = {19, 18, 21, 18, 25},
	["Tauren"] = {25, 15, 22, 15, 22},
	["Troll"] = {21, 22, 21, 16, 21},
	["BloodElf"] = {17, 22, 18, 24, 19},
}
--]]
--[[
20120810: There's not even any reference to this variable
local ClassBonusStat = {
	["DRUID"] = {1, 0, 0, 2, 2},
	["HUNTER"] = {0, 3, 1, 0, 1},
	["MAGE"] = {0, 0, 0, 3, 2},
	["PALADIN"] = {2, 0, 2, 0, 1},
	["PRIEST"] = {0, 0, 0, 2, 3},
	["ROGUE"] = {1, 3, 1, 0, 0},
	["SHAMAN"] = {1, 0, 1, 1, 2},
	["WARLOCK"] = {0, 0, 1, 2, 2},
	["WARRIOR"] = {3, 0, 2, 0, 0},
}
--]]
--[[
20120810: There's not even any references to this variable
local ClassBaseHealth = {
	["WARRIOR"] = 40,
	["PALADIN"] = 38,
	["HUNTER"] = 46,
	["ROGUE"] = 45,
	["PRIEST"] = 52,
	--20120809: Nobody ever added Death Knight. Is this variable even used for anything?
	["SHAMAN"] = 47,
	["MAGE"] = 52,
	["WARLOCK"] = 43,
--  ["MONK"] = 42, --Come up with real monk class base value
	["DRUID"] = 54,
}
--]]
--[[
20120810: There's not even any reference to this variable
local ClassBaseMana = {
	["WARRIOR"] = 0,
	["PALADIN"] = 80,
	["HUNTER"] = 85,
	["ROGUE"] = 0,
	["PRIEST"] = 130,
	--20120809: Nobody ever added Death Knight. Is this variable even used for anything?
	["SHAMAN"] = 75,
	["MAGE"] = 120,
	["WARLOCK"] = 110,
--	["MONK"] = 0, --Come up with real monk class base mana
	["DRUID"] = 70,
}
--]]
--http://wowvault.ign.com/View.php?view=Stats.List&category_select_id=9

--==================================--
-- Stat Mods from Talents and Buffs --
--==================================--
--[[ Aura mods from Thottbot
Apply Aura: Mod Total Stat % (All stats)
Apply Aura: Mod Total Stat % (Strength)
Apply Aura: Mod Total Stat % (Agility)
Apply Aura: Mod Total Stat % (Stamina)
Apply Aura: Mod Total Stat % (Intellect)
Apply Aura: Mod Total Stat % (Spirit)
Apply Aura: Mod Max Health %
Apply Aura: Reduces Attacker Chance to Hit with Melee
Apply Aura: Reduces Attacker Chance to Hit with Ranged
Apply Aura: Reduces Attacker Chance to Hit with Spells (Spells)
Apply Aura: Reduces Attacker Chance to Crit with Melee
Apply Aura: Reduces Attacker Chance to Crit with Ranged
Apply Aura: Reduces Attacker Critical Hit Damage with Melee by %
Apply Aura: Reduces Attacker Critical Hit Damage with Ranged by %
Apply Aura: Mod Dmg % (Spells)
Apply Aura: Mod Dmg % Taken (Fire, Frost)
Apply Aura: Mod Dmg % Taken (Spells)
Apply Aura: Mod Dmg % Taken (All)
Apply Aura: Mod Dmg % Taken (Physical)
Apply Aura: Mod Base Resistance % (Physical)
Apply Aura: Mod Block Percent
Apply Aura: Mod Parry Percent
Apply Aura: Mod Dodge Percent
Apply Aura: Mod Shield Block %
Apply Aura: Mod Detect
Apply Aura: Mod Skill Talent (Defense)
--]]
--[[ StatModAuras, mods not in use are commented out for now
"MOD_STR",
"MOD_AGI",
"MOD_STA",
"MOD_INT",
"MOD_SPI",
"MOD_HEALTH",
"MOD_MANA",
"MOD_ARMOR",
"MOD_BLOCK_VALUE",
--"MOD_DMG", school,
"MOD_DMG_TAKEN", school,
--"MOD_CRIT_DAMAGE", school,
"MOD_CRIT_DAMAGE_TAKEN", school,
--"MOD_THREAT", school,

"ADD_DODGE", -- Used in StatLogic:GetDodgePerAgi()
--"ADD_PARRY",
--"ADD_BLOCK",
--"ADD_STEALTH_DETECT",
--"ADD_STEALTH",
--"ADD_DEFENSE",
--"ADD_THREAT", school,
"ADD_HIT_TAKEN", school,
"ADD_CRIT_TAKEN", school,

--Talents
"ADD_AP_MOD_STA" -- Hunter: Hunter vs. Wild
"ADD_AP_MOD_ARMOR" -- Death Knight: Bladed Armor
"ADD_AP_MOD_INT" -- Shaman: Mental Dexterity
"ADD_PARRY_RATING_MOD_STR" -- Death Knight: Forceful Deflection - Passive
"ADD_PARRY_MOD_STR" --Warrior, Rogue, Death Knight, Paladin
"ADD_SPELL_CRIT_RATING_MOD_SPI" -- Mage: Molten Armor - 3.1.0
"ADD_COMBAT_MANA_REGEN_MOD_INT"
"ADD_RANGED_AP_MOD_INT"
"ADD_ARMOR_MOD_INT"
"ADD_SPELL_DMG_MOD_STR" -- Paladin: Touched by the Light
"ADD_SPELL_DMG_MOD_STA"
"ADD_SPELL_DMG_MOD_INT"
"ADD_SPELL_DMG_MOD_SPI"
"ADD_SPELL_DMG_MOD_AP" -- Shaman: Mental Quickness, Paladin: Sheath of Light
"ADD_HEAL_MOD_STR" -- Paladin: Touched by the Light
"ADD_HEAL_MOD_AGI"
"ADD_HEAL_MOD_STA"
"ADD_HEAL_MOD_INT"
"ADD_HEAL_MOD_SPI"
"ADD_HEAL_MOD_AP" -- Shaman: Mental Quickness
"ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"
"MOD_AP"
"MOD_RANGED_AP"
"MOD_SPELL_PWR"
"MOD_HEAL"

--"ADD_CAST_TIME"
--"MOD_CAST_TIME"
--"ADD_MANA_COST"
--"MOD_MANA_COST"
--"ADD_RAGE_COST"
--"MOD_RAGE_COST"
--"ADD_ENERGY_COST"
--"MOD_ENERGY_COST"
--"ADD_COOLDOWN"
--"MOD_COOLDOWN"
--]]

local StatModInfo = {
  ------------------------------------------------------------------------------
  -- initialValue: sets the initial value for the stat mod
  -- if initialValue == 0, inter-mod operations are done with addition,
  -- if initialValue == 1, inter-mod operations are done with multiplication,
  ------------------------------------------------------------------------------
  -- finalAdjust: added to the final result before returning,
  -- so we can adjust the return value to be used in addition or multiplication
  -- for addition: initialValue + finalAdjust = 0
  -- for multiplication: initialValue + finalAdjust = 1
  ------------------------------------------------------------------------------
  -- school: school arg is required for these mods
  ------------------------------------------------------------------------------
	["ADD_CRIT_TAKEN"] = {
		initialValue = 0,
		finalAdjust = 0,
		school = true,
	},
	["ADD_HIT_TAKEN"] = {
		initialValue = 0,
		finalAdjust = 0,
		school = true,
	},
	["ADD_DODGE"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_BLOCK_REDUCTION"] = { -- Meta Gems
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_AP_MOD_INT"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_AP_MOD_STA"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_AP_MOD_ARMOR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_PARRY_RATING_MOD_STR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_PARRY_MOD_STR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_CRIT_RATING_MOD_SPI"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_HIT_RATING_MOD_SPI"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_RANGED_AP_MOD_INT"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_ARMOR_MOD_INT"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_AP"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_STR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_STA"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_INT"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_SPI"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_PET_STA"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_PET_INT"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_SPELL_DMG_MOD_MANA"] = { -- Improved Mana Gem
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEAL_MOD_AP"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEAL_MOD_STR"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEAL_MOD_AGI"] = { -- Nurturing Instinct
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEAL_MOD_STA"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEAL_MOD_INT"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEAL_MOD_SPI"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_HEAL_MOD_MANA"] = { -- Improved Mana Gem
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_COMBAT_MANA_REGEN_MOD_INT"] = { -- deprecated
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_COMBAT_MANA_REGEN_MOD_MANA"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"] = {
		initialValue = 0,
		finalAdjust = 0,
	},
	["ADD_PET_STA_MOD_STA"] = {
		initialValue = 1,
		finalAdjust = -1,
	},
	["ADD_PET_INT_MOD_INT"] = {
		initialValue = 1,
		finalAdjust = -1,
	},
	["MOD_CRIT_DAMAGE_TAKEN"] = {
		initialValue = 0,
		finalAdjust = 1,
		school = true,
	},
	["MOD_DMG_TAKEN"] = {
		initialValue = 0,
		finalAdjust = 1,
		school = true,
	},
	["MOD_CRIT_DAMAGE"] = {
		initialValue = 0,
		finalAdjust = 1,
		school = true,
	},
	["MOD_DMG"] = {
		initialValue = 0,
		finalAdjust = 1,
		school = true,
	},
	["MOD_ARMOR"] = {
		initialValue = 1,
		finalAdjust = 0,
	},

	["MOD_HEALTH"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_MANA"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_STR"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_AGI"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_STA"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_INT"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_SPI"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_BLOCK_VALUE"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_AP"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_CRIT"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_RANGED_AP"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_SPELL_PWR"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_HEAL"] = {
		initialValue = 0,
		finalAdjust = 1,
	},
	["MOD_MELEE_HASTE"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_SPELL_HASTE"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
	["MOD_MASTERY"] = {
		initialValue = 1,
		finalAdjust = 0,
	},
}
StatLogic.StatModInfo = StatModInfo -- so other addons can use this directly

StatLogic.SpellSchools = {
	"MELEE",
	"RANGED",
	"HOLY",
	"FIRE",
	"NATURE",
	"FROST",
	"SHADOW",
	"ARCANE",
}

------------------
-- StatModTable --
------------------
--[[ How to add a glyph support?
1. Go to the glyph item on wowhead.
2. Click on the green Use: TEXT on the "tooltip" to go to a spell page.
3. Click on "See also" tab for a spell with a gear icon, the spell id for this page is what you put in here.
--]]
--[[ How can I get aura data?
1. /dump UnitAura("player",1)
--]]
local StatModTable = {}
StatLogic.StatModTable = StatModTable -- so other addons can use this directly

--Druid Updated to 5.0.4 
if playerClass == "DRUID" then
	StatModTable["DRUID"] = {

		-- 5.0.4: Nurturing Instinct (SpellID 33873) Increases your nature spell power by 100% of your Agility.
		["ADD_HEAL_MOD_AGI"] = {
			{-- Druid: Nurturing Instinct
				["known"] = 33873,
				["rank"] = { 1, },
			},
		},
		-- Healers: Meditation
		-- Allows 50% of your mana regeneration from Spirit to continue while in combat.
		-- 5.0.4: Druid specialization SpellID 85101
		["ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"] = {
			{--Meditation: Druid Specialization Talent
				["known"] = 85101, 
				["rank"] = {0.50, },
			},
		},

		["ADD_DODGE"] = {
		},
		-- Druid: Glyph of Barkskin
		-- 4.0.1: Reduces the chance you'll be critically hit by melee attacks by 25% while Barkskin is active.
		-- Druid: Thick Hide (Rank 3) - 2,11
		-- 4.0.1: Increases your Armor contribution from cloth and leather items by 4/7/10%, increases armor while in Bear Form by an additional 11/22/33%, and reduces the chance you'll be critically hit by melee attacks by 2/4/6%.
		["ADD_CRIT_TAKEN"] = {
			{-- Glyph of Barkskin
				["MELEE"] = true,
				["rank"] = { -0.25, },
				["buff"] = 22812,        -- ["Barkskin"],
				["glyph"] = 63057,
			},
			{-- Thick Hide
				["MELEE"] = true,
				["rank"] = { -0.06, },
				["known"] = 16931,
			},
		},
		-- Increases your spell hit rating by an additional amount equal to  your Spirit.
		["ADD_SPELL_HIT_RATING_MOD_SPI"] = {
		  {-- Druid: Balance of Power 
			["known"] = 33596,
			["rank"] = { 1,},
		  },
		},

		-- Druid: Barkskin - Buff
		-- 4.0.1: All damage taken is reduced by 20%.
		-- Druid: Moonkin Form - Buff: All damage reduced by 15%.
		["MOD_DMG_TAKEN"] = {
		  {-- Barkskin
			["MELEE"] = true,
			["RANGED"] = true,
			["HOLY"] = true,
			["FIRE"] = true,
			["NATURE"] = true,
			["FROST"] = true,
			["SHADOW"] = true,
			["ARCANE"] = true,
			["rank"] = { -0.2, },
			["buff"] = 22812,        -- ["Barkskin"],
		  },

		  {-- Moonkin Form - Buff
			["MELEE"] = true,
			["RANGED"] = true,
			["HOLY"] = true,
			["FIRE"] = true,
			["NATURE"] = true,
			["FROST"] = true,
			["SHADOW"] = true,
			["ARCANE"] = true,
			["rank"] = {
			  -0.15,
			},
			["buff"] = 24858,        -- ["Moonkin Form"],
		  },
		},
		-- Druid: Bear Form - Buff: Increases armor contribution from cloth and leather items by 320%, and Stamina by 20%. 
		-- Druid: Tree of Life : Armor increased by 120%.
		["MOD_ARMOR"] = {
		--The bouns armor from Mastery is added else where
		{-- Bear Form
			["rank"] = { 1.2 },
			["buff"] = 5487,        -- "Bear Form" without Thick Hide ability 
			["condition"] = "GetSpecialization() ~= 3"
		  },
		  {-- Thick Hide
			["rank"] = { 3.3 },
			["buff"] = 5487,        -- ["Bear Form"],
			["known"] = 16931,
		  },
		  {--Tree of Life
			["rank"] = {
			  1.2,
			},
			["buff"] = 33891,        -- ["Tree of Life"],
		  },
		},

		["MOD_MANA"] = {
		},

		--Leather Specialization: Increases your primary attribute by 5% while wearing Leather in all armor slots.		-- 4.0.1: Increases your Intellect by 2/4/6%. In addition, while in Bear Form your Stamina is increased by 3/7/10% and while in Cat Form your attack power is increased by 3/7/10%.
		-- Druid: Bear Form - Buff: Increases armor contribution from cloth and leather items by 320%, and Stamina by 20%. 
		["MOD_STA"] = {
		  {-- Bear Form
			["rank"] = {0.20,},
			["buff"] = 5487,        -- ["Bear Form"],
		  },
		  {-- Leather Specialization(STA) - Guardian
			["rank"] = {0.05,},
			["armorspec"] = 3,
			["known"] = 86096,
			["buff"] = 5487,        -- ["Bear Form"],
		  },
		},
		--Leather Specialization: Increases your primary attribute by 5% while wearing Leather in all armor slots.
		["MOD_AGI"] = {
		  {-- Leather Specialization (AGI) -Feral
			["rank"] = {0.05,},
			["armorspec"] = 2,
			["known"] = 86097,
		  },
		},
		-- Druid: Leather Specialization: Increases your primary attribute by 5% while wearing Leather in all armor slots.  
		["MOD_INT"] = {
		  {-- Leather Specialization (INT) - Balance
			["rank"] = {
			  0.05,
			},
			["known"] = 86104,
			["armorspec"] = 1,
		  },
		  {-- Leather Specialization (INT) - Resto
			["rank"] = {
			  0.05,
			},
			["known"] = 86093,
			["armorspec"] = 4,
		  },
		},
}
--Death Knights have been updated to Mists
elseif playerClass == "DEATHKNIGHT" then
	StatModTable["DEATHKNIGHT"] = {

	["MOD_MELEE_HASTE"] = {
		{-- Icy Talons
			["rank"] = {0.2,},
			["known"] = 50887,
		},
		{-- Unholy Presence with  Improved Unholy Presence
        ["rank"] = { .2,},
        ["stance"] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
	   ["condition"] = "GetSpecialization() == 3"
      },
	 {-- Unholy Presence 
        ["rank"] = { .2,},
        ["stance"] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
	   ["condition"] = "GetSpecialization() ~= 3"
      },
    },

    	["ADD_DODGE"] = {
	{-- Veteran of the Third War
        ["rank"] = {0.02,},
        ["known"] = 50029, -- ["Veteran of the Third War"]
      },
	},
	-- 5.0.4: Strength adds to Parry %, with bonus strength suffering diminishing returns
	["ADD_PARRY_MOD_STR"] = {
		{
			["known"] = 82246, --SpellID 82246: Parry (Death Knight)
			["rank"] = {1}, 
		},
	},

    ["ADD_CRIT_TAKEN"] = {
      {-- Improved Blood Presence
        ["MELEE"] = true,
        ["rank"] = { -0.06, },
	   ["known"] = 50371,
	   ["buff"] = 48263,
        --["stance"] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
      },
    },

    ["MOD_DMG_TAKEN"] = {
      {-- Icebound Fortitude
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.20,},
        ["buff"] = 48792,-- ["Icebound Fortitude"],
      },
      {-- Sanguine Fortitude
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.30, },
        ["buff"] = 48792,        -- ["Icebound Fortitude"],
      },
      {-- Bone Shield
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.20,},
        ["buff"] = 49222,        -- ["Bone Shield"],
      },
      {-- Anti-Magic Shell
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.75,},
        ["buff"] = 48707,        -- ["Anti-Magic Shell"],
      },
      {-- Blood Presence
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.1,},
        --["stance"] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
	   ["buff"] = 48263,
      },

      {-- Rune of Spellshattering
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.04,},
        ["slot"] = 16, -- main hand slot
        ["enchant"] = 3367,
      },
      {-- Rune of Spellbreaking
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.02,},
        ["slot"] = 16, -- main hand slot
        ["enchant"] = 3595,
      },
      {-- Rune of Spellbreaking
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.02,},
        ["slot"] = 17, -- off hand slot
        ["enchant"] = 3595,
      },
       {-- Will of the Necropolis
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.25,},
        ["buff"] = 81164,        -- ["Will of the Necropolis"],
      },
    },

    ["MOD_ARMOR"] = {
      {-- Blood Presence
        ["rank"] = { 55, },
	   ["buff"] = 48263,
        --["stance"] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
      },
    },

    ["MOD_HEALTH"] = {
      {-- Vampiric Blood
        ["rank"] = {0.15,},
        ["buff"] = 55233,        -- ["Vampiric Blood"],
        ["condition"] = "not LibStub('LibStatLogic-1.2').PlayerHasGlyph(58676)", -- ["Glyph of Vampiric Blood"]
      },
    },

    ["MOD_STA"] = {
      {-- Plate Specialization
        ["rank"] = {0.05,},
        ["known"] = 86524,
        ["armorspec"] = 1,
      },
      {-- Blood Presence
        ["rank"] = {0.25,},
	   ["buff"] = 48263,
        --["stance"] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
      },
      {-- Veteran of the Third War
        ["rank"] = {0.09,},
        ["known"] = 50029, -- ["Veteran of the Third War"]
      },
      {-- Rune of the Stoneskin Gargoyle
        ["rank"] = {0.02,},
        ["slot"] = 16, -- main hand slot
        ["enchant"] = 3847,
      },
      {-- Rune of the Nerubian Carapace
        ["rank"] = {0.01,},
        ["slot"] = 16, -- main hand slot
        ["enchant"] = 3883,
      },
      {-- Rune of the Nerubian Carapace
        ["rank"] = {0.01,},
        ["slot"] = 17, -- off hand slot
        ["enchant"] = 3883,
      },
    },

    ["MOD_STR"] = {
      {-- Plate Specialization
        ["rank"] = {0.05,},
        ["known"] = 86524,
        ["armorspec"] = 2,
      },
      {-- Plate Specialization
        ["rank"] = {0.05,},
        ["known"] = 86524,
        ["armorspec"] = 3,
      },
      {-- Unholy Might
        ["rank"] = {0.15,},
        ["known"] = 91107, -- ["Unholy Might"]
      },
      {-- Pillar of Frost
        ["rank"] = {0.2,},
        ["buff"] = 51271,        -- ["Pillar of Frost"],
      },	
      {-- Unholy Strength
        ["rank"] = {0.15,},
        ["buff"] = 53365,-- ["Unholy Strength"],
      },
	},
}

  --Hunter Info Updated for Mists
elseif playerClass == "HUNTER" then
	StatModTable["HUNTER"] = {
		-- Hunter: Deterrence - Buff: 19263 : All damage redcuced by 30%
		--		Glyph of Deterrance:  Increase deterrance by 20%
		--		Glyph of Mirrored Blades 100% chance to deflect spells.
		["ADD_HIT_TAKEN"] = {
			{-- Deterrence
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {-.3,},
				["buff"] = 19263,
			},
			{-- Glyph of Deterrence
				["MELEE"] = true,
				["RANGED"] = true,
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {-.2,},
				["buff"] = 19263, -- Deterrence
				["glyph"] = 56850
			},
			{-- Glyph of Mirrored Blades
				["HOLY"] = true,
				["FIRE"] = true,
				["NATURE"] = true,
				["FROST"] = true,
				["SHADOW"] = true,
				["ARCANE"] = true,
				["rank"] = {1},
				["buff"] = 19263, -- Deterrence
				["glyph"] = 83495
			},
		},
        ["MOD_RANGED_AP"] = {
	  {-- Aspect of the Hawk
        ["rank"] = {0.1,},
        ["buff"] = 13165,
      },
    },
    -- Hunter: Mail Specialization: Increases your Agility by 5% while wearing Mail in all armor slots
    ["MOD_AGI"] = {
      {-- Mail Specialization
        ["rank"] = {0.05,},
        ["known"] = 86538,
      },
    },
  }

--Mage Info Updated to Mists
elseif playerClass == "MAGE" then
	StatModTable["MAGE"] = {
    -- Mage: Wizardry - Passive: 89744
    -- 4.0.1: Increases your Intellect by 5%
    ["MOD_INT"] = {
      {-- Wizardry
        ["rank"] = {0.05,},
        ["known"] = 89744, -- ["Wizardry"]
      },
    },
    ["MOD_CRIT"] = {
      {-- Arcane Brilliance
        ["rank"] = {0.05,},
        ["buff"] = 30482,
        ["group"] = D["5% Crit Chance"],
      },
	},
    ["MOD_SPELL_HASTE"] = {
      {-- Frost ARmor
        ["rank"] = {0.05,},
        ["buff"] = 7302,
        ["group"] = D["5% Spell Haste"],
      },
	},
    ["MOD_DMG_TAKEN"] = {
      {-- Molten Armor
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["rank"] = {-0.06,},
        ["buff"] = 30482,
      },
    },
  }

elseif playerClass == "PALADIN" then
	StatModTable["PALADIN"] = {
    -- Paladin: Holy Insight - Allows 50% of your mana regeneration from Spirit to continue while in combat.
    ["ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"] = {
		{-- Holy Insight
			["rank"] = { 0.50, },
			["known"] = 112859,
		},
	},

	["ADD_DODGE"] = {
	{-- Sanctuary
        ["rank"] = { 0.02,}, --Sancuary adds +2% Dodge Chance
        ["known"] = 105805,
      },
	 },

    ["ADD_CRIT_TAKEN"] = {
      {-- Guarded by the light
        ["MELEE"] = true,
        --["tab"] = 3,
        --["num"] = 10,
        ["rank"] = { -0.06,},
        ["known"] = 53592,
      },
    },

	-- 5.0.4: Strength adds to Parry %, with bonus strength suffering diminishing returns
	["ADD_PARRY_MOD_STR"] = {
		{
			["known"] = 82242, --SpellID 82242: Parry (Paladin)
			["rank"] = {1}, 
		},
	},
    -- Paladin: sword of Light - Passive Increases your spell power by an amount equal to 50% of your attack power
    ["ADD_SPELL_DMG_MOD_AP"] = {
		{-- Sword of Light
			["rank"] = { 0.5, },
			["known"] =53503,
		},
	},
	-- Paladin: guarded by the Light - assive Increases your spell power by an amount equal to 50% of your attack power
	["ADD_HEAL_MOD_AP"] = {
		{-- guarded by the Light 
			["rank"] = { 0.5, },
			["known"] = 53592,
		},
	},
	-- Paladin: Sanctuary - 
	-- 5.0.4: Sanctuary is a passive protection spell ID: 105805
	["MOD_DMG_TAKEN"] = {
		{	-- Sanctuary Decreases damage taken by 15%, increases armor value from items by 10%, and increases your chance to dodge by 2%.
			["MELEE"] = true,
			["RANGED"] = true,
			["HOLY"] = true,
			["FIRE"] = true,
			["NATURE"] = true,
			["FROST"] = true,
			["SHADOW"] = true,
			["ARCANE"] = true,
			["rank"] = { -0.15, }, 
			["known"] = 105805,
		},
		{	-- Ardent Defender - Reduces all magic damage taken by 20% for 6 seconds
			["MELEE"] = true,
			["RANGED"] = true,
			["HOLY"] = true,
			["FIRE"] = true,
			["NATURE"] = true,
			["FROST"] = true,
			["SHADOW"] = true,
			["ARCANE"] = true,
			["rank"] = { -0.2, },
			["buff"] = 31850,
		},
	},
	-- Paladin: Sanctuary, Protection Passive
	["MOD_ARMOR"] = {
		{	--Sanctuary: Decreases damage taken by 15%, increases armor value from items by 10%, and increases your chance to dodge by 2%.
			["known"] = 105805,	
			["rank"] = { 0.10 },
		},
	},
	["MOD_BLOCK_VALUE"] =  {		
		{	-- Guarded by the Light - Increases your total Stamina by 15% and your block chance by 10%. Reduces the chance you will be critically hit by melee attacks by 6%.
			["rank"] = { 0.10, },
			["known"] = 53592,
		},
	},
	--20120915: i think armor specializations still exist, although i cannot find any spell or passive for it
	-- Paladin: Plate Specialization - Passive: 86525
	-- 4.0.1: Increases your primary attribute by 5% while wearing Plate in all armor slots. Holy specialization grants Intellect, Protection specialization grants Stamina, and Retribution specialization grants Strength.
	-- Paladin: Touched by the Light - Passive: 53592
	-- 4.0.1: Increases your total Stamina by 15%, increases your spell hit by 6%, and increases your spell power by an amount equal to 60% of your Strength.
	-- 5.0.5: Touched by the Light changed to Guarded by the Light,but is still SpellID 53592

	["MOD_STA"] = {
		{	-- Plate Specialization - It might still exist, but there's no spell, or buff, or passive for it. 
			-- And i'm seeing an extra 14% boost to stamina (on top of the 14% provided by Guarded by the Light)
			-- So i'll guess that this 14% is coming from the, now invisible, now 14% (up from 5%), protection plate specialization
			["rank"] = { 0.05, }, --0.14  Guarded by the Light might add the missing stamina
			--["known"] = 86102,
			["armorspec"] = 2,
		},
		{	-- Guarded by the Light - Increases your total Stamina by 15%
			-- 9/20/2012 - i know it says 15%, but (with Plate Specialization disabled by wearing a cloth piece), i'm seeing 25% boost on Stamina
			-- It might be a bug, and Guarded by the light is actually 25% while the spell lists 15%.
			-- Or perhaps there's another hidden 0.08695652173913 rank buff.
			-- Which is more likely, single 0.25 buff, or a 0.15 and a 1.08695652173913 buff?
			-- But to avoid having someone change "Guarded by the Light" back to 15% on me,
			-- i'll just ADD the hidden protection buff
			["rank"] = { 0.15, },
			["known"] = 53592,
		},
		{	--Unknown protection paladin buff (Or bug in Guarded by the Light) that causes Guarded by the Light to act as 25%
			--0.15 * 1.08695652173913000 = 0.25
			--9/20/2012: This actually is being experienced. In order to calculate stamina changes correctly
			--You need to involve something more than 5% Plate Specialization and 15% Guarded by the light.
			--If you equip cloth (to nullify Plate Specialization),
			-- and you equip an item with +541 Stamina, you'll end up gaining 676 Stamina
			-- 9381 + 541 = 10057 (an increase of 676)
			-- 676/541 = 1.25
			-- There really is this hidden effect that needs to be modelled in order for stamina
			-- to come out right.
			-- Don't remove this buff until either
			-- a) the effect goes away
			-- b) Blizzard announces that Guarded by the Light actually is 25%
			["rank"] = { 0.08695652173913, },
			["known"] = 53592,
		}
	},
	-- Paladin: Plate Specialization - Passive: 86525
	-- 4.0.1: Increases your primary attribute by 5% while wearing Plate in all armor slots. Holy specialization grants Intellect, Protection specialization grants Stamina, and Retribution specialization grants Strength.
	["MOD_INT"] = {
		{-- Plate Specialization
			["rank"] = { 0.05, },
			--["known"] = 86525,
			["armorspec"] = 1,
		},
	},

	["MOD_STR"] = {
		{-- Plate Specialization
			["rank"] = { 0.05, },
			--["known"] = 86525,
			["armorspec"] = 3,
		},
	},
	}
 --Priest Has been updated to Mists stats
elseif playerClass == "PRIEST" then
	StatModTable["PRIEST"] = {
    -- Healers: Meditation
	-- 5.0.4: TODO: There are no more talents; removing tab/num.
    ["ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"] = {
		{-- Meditation (Discipline)
			["rank"] = {0.5,},
			["known"] = 95860,
		},
		{-- Meditation (Holy)
			["rank"] = {0.5,},
			["known"] = 95861,
		},
	},

	["MOD_SPELL_PWR"] = {
		{	-- Inner Fire
			["rank"] = {0.1,},
			["buff"] = 588,
		},
	},

	-- Priest: Spiritual Precision
	-- 5.0.4:: Grants you spell hit rating equal to 100% of any Spirit gained from items or effects.
	["ADD_SPELL_HIT_RATING_MOD_SPI"] = {
		{-- Spiritual Precision
			["spellid"] = 47573,
			["rank"] = {1,},
		},
	},

	-- Priest: Inner Fire - Buff: 588
	-- 4.0.1: Increases armor from items by 60% and spell power by 1080.
	-- Priest: Glyph of Inner Fire - Glyph: 55686 - Buff: 588
	-- 4.0.1: Increases the armor from your Inner Fire spell by 50%.
	["MOD_ARMOR"] = {
		{-- Inner Fire
			["rank"] = {0.6,},
			["buff"] = 588,
		},
		{-- Glyph of Inner Fire
			["rank"] = {0.1875,}, -- 1.9/1.6=1.1875},
			["buff"] = 588, 
			["glyph"] = 42402,
		},
	},
    -- Priest: Dispersion - Buff
    -- 4.0.1: Reduces all damage by 90%
    -- Priest: Shadowform - Buff
    -- 4.0.1: All damage you take reduced by 15%.
    ["MOD_DMG_TAKEN"] = {
		{	-- Shadowform
			["HOLY"] = true,
			["FIRE"] = true,
			["NATURE"] = true,
			["FROST"] = true,
			["SHADOW"] = true,
			["ARCANE"] = true,
			["rank"] = {-0.15,},
			["buff"] = 15473,
		},
		{	-- Dispersion
			["MELEE"] = true,
			["RANGED"] = true,
			["HOLY"] = true,
			["FIRE"] = true,
			["NATURE"] = true,
			["FROST"] = true,
			["SHADOW"] = true,
			["ARCANE"] = true,
			["rank"] = {-0.9,},
			["buff"] = 65544,
		},
		{-- Glyph of Fade
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.10,},
        ["buff"] = 586,        -- ["Fade"],
        ["glyph"] = 42398,        -- ["Glyph of Fade"],
      },
       {-- Glyph of Inner Sanctum
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.06,},
        ["buff"] = 14771,        -- ["Inner Sanctum"],
	   ["glyph"] = 42400,
      },
    },

    -- Priest: Mysticism - Passive: 89745
    -- 4.0.1: Increases your Intellect by 5%
    ["MOD_INT"] = {
      {-- Mysticism
        ["rank"] = {0.05,},
        ["known"] = 89745,
      },
    },
  }

  --Rogue has been updated to Mist values
elseif playerClass == "ROGUE" then
	StatModTable["ROGUE"] = {
    -- Rogue: Evasion - Buff: 5277
    -- 4.0.1: Dodge chance increased by 50% and chance ranged attacks hit you reduced by 25%.
    ["ADD_DODGE"] = {
      {-- Evasion
        ["rank"] = {50,},
        ["buff"] = 5277, -- ["Evasion"],
      },
    },

    ["MOD_DMG_TAKEN"] = {
      {-- Cloak of Shadows
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-1,},
        ["buff"] = 31224,        -- ["Cloak of Shadows"],
      },
      {-- Glyph of Cloak of Shadows
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["rank"] = {-0.4,},
        ["buff"] = 31224,        -- ["Cloak of Shadows"],
        ["glyph"] = 63269,  -- ["Glyph of Cloak of Shadows"],
      },
      {-- Cheating Death
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.8,},
        ["buff"] = 45182,-- ["Cheating Death"],
      },
    },
    -- Rogue: Leather Specialization - Passive: 86531
    -- 4.0.1: Increases your Agility by 5% while wearing Leather in all armor slots.
    -- Rogue: Sinister Calling - Passive: 31220
    -- 4.0.6: Increases your total Agility by 30%
    ["MOD_AGI"] = {
      {-- Leather Specialization
        ["rank"] = {0.05,},
        ["known"] = 86092,
      },
      {-- Sinister Calling
        ["rank"] = {0.3,},
        ["known"] = 31220,
      },
    },
  }
--Shaman has been updated to Mists
elseif playerClass == "SHAMAN" then
	StatModTable["SHAMAN"] = {
    -- Druid: Elemental Precision 
    -- 4.0.1: Grants you spell hit rating equal 100% of any Spirit 
    ["ADD_SPELL_HIT_RATING_MOD_SPI"] = {
      {
        ["known"] = 30674,
        ["rank"] = {1,},
      },
    },
    -- Healers: Meditation
    -- 4.0.1: Allows 50% of your mana regeneration from Spirit to continue while in combat.
    ["ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"] = {
      {
        ["rank"] = {0.50,},
        ["known"] = 95862,
      },
    },
    -- Shaman: Mental Quickness - Passive: 30814
    -- 4.0.1: Increases your spell power by an amount equal to 55% of your attack power
    ["ADD_SPELL_DMG_MOD_AP"] = {
      {-- Mental Quickness
        ["rank"] = {0.55,},
        ["known"] = 30814,
      },
    },

    -- Shaman: Shamanistic Rage : All damage taken reduced by 30%.

    ["MOD_DMG_TAKEN"] = {
      {-- Shamanistic Rage
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.3,},
        ["buff"] = 30823,-- ["Shamanistic Rage"],
      },
    },
    -- Shaman: Toughness - Rank 3/3 - 2,8
    -- 4.0.1: Increases your Stamina by 3/7/10%
	-- 5.0.4: TODO: There are no more talents; removing tab/num.
    ["MOD_STA"] = {
    },
    -- Shaman: Mail Specialization - Passive: 86529
    -- 4.0.1: Increases your primary attribute by 5% while wearing Mail in all armor slots. Elemental specialization grants Intellect, Enhancement specialization grants Agility, and Restoration specialization grants Intellect.
    ["MOD_AGI"] = {
      {-- Mail Specialization - Enhance
        ["rank"] = {0.05,},
        ["known"] = 86529,
        ["armorspec"] = 2,
      },
    },
    -- Shaman: Mail Specialization - Passive: 86529
    -- 4.0.1: Increases your primary attribute by 5% while wearing Mail in all armor slots. Elemental specialization grants Intellect, Enhancement specialization grants Agility, and Restoration specialization grants Intellect.
    ["MOD_INT"] = {
      {-- Mail Specialization - Elemental
        ["rank"] = {0.05,},
        ["known"] = 86108,
        ["armorspec"] = 1,
      },
      {-- Mail Specialization - Restoration
        ["rank"] = {0.05,},
        ["known"] = 86100,
        ["armorspec"] = 3,
      },
    },
  }
elseif playerClass == "WARLOCK" then
	StatModTable["WARLOCK"] = {
    -- Warlock: Metamorphosis - Buff: 47241
    -- 4.0.1: Armor contribution from items increased by 600%. Chance to be critically hit by melee reduced by 6%.
    ["ADD_CRIT_TAKEN"] = {
      {-- Metamorphosis
        ["MELEE"] = true,
        ["rank"] = {
          -0.06,
        },
        ["buff"] = 47241,
      },
    },
    -- Warlock: Metamorphosis - Buff: 47241
    -- 4.0.1: Armor contribution from items increased by 600%. Chance to be critically hit by melee reduced by 6%.
    ["MOD_ARMOR"] = {
      {-- Metamorphosis
        ["rank"] = {
          6,
        },
        ["buff"] = 47241,
      },
    },
    -- 3.3.0 Imp stam total 233: pet base 118, player base 90, pet sta from player sta 0.75, pet kings 1.1, fel vitality 1.15
    -- /dump floor((118+floor(90*0.75))*1.1)*1.05 = 233.45 match
    -- /dump (118+floor(9f0*0.75))*1.1*1.05 = 224.025 wrong
	-- 5.0.3: Changed Mark of the Wild SpellID from 79061 to 1126
    ["ADD_PET_STA_MOD_STA"] = {
      { -- Base
        ["rank"] = {
          0.65,
        },
        ["condition"] = "UnitExists('pet')",
      },
      { -- Blessings on pet: floor() * 1.05
        ["rank"] = {
          0.05,
        }, -- BoK, MotW, EotSS
        ["condition"] = "UnitBuff('pet', GetSpellInfo(20217)) or UnitBuff('pet', GetSpellInfo(1126)) or UnitBuff('pet', GetSpellInfo(90363))",
      },
    },
    ["ADD_PET_INT_MOD_INT"] = {
      { -- Base
        ["rank"] = {
          0.5,
        },
        ["condition"] = "UnitExists('pet')",
      },
      { -- Blessings on pet: floor() * 1.05
        ["rank"] = {
          0.05,
        }, -- BoK, MotW, EotSS
        ["condition"] = "UnitBuff('pet', GetSpellInfo(20217)) or UnitBuff('pet', GetSpellInfo(1126)) or UnitBuff('pet', GetSpellInfo(90363))",
      },
    },
    -- Warlock: Soul Link - Buff: 25228
    -- 4.0.1: 20% of damage taken by master is taken by the demon instead.
    -- Warlock: Glyph of Soul Link - Buff: 25228 - Glyph: 63312
    -- 4.0.1: Increases the percentage of damage shared via your Soul Link by an additional 5%.
    ["MOD_DMG_TAKEN"] = {
      {-- Soul Link
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          -0.2,
        },
        ["buff"] = 25228,        -- ["Soul Link"],
      },
      {-- Glyph of Soul Link
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          -0.05,
        },
        ["buff"] = 25228,        -- ["Soul Link"],
        ["glyph"] = 63312,  -- ["Glyph of Soul Link"],
      },
    },
    -- Warlock: Demonic Embrace - Rank 3/3 - 2,1
    --          Increases your total Stamina by 4/7/10%.
	-- 5.0.4: TODO: There are no more talents; removing tab/num.
    ["MOD_STA"] = {
      {
        --["tab"] = 2,
        --["num"] = 1,
        ["rank"] = {
          0.04, 0.07, 0.1,
        },
      },
    },
    -- Warlock: Nethermancy - Passive: 86091
    -- 4.0.1: Increases your Intellect by 5%
    ["MOD_INT"] = {
      {-- Nethermancy
        ["rank"] = {
          0.05,
        },
        ["known"] = 86091,
      },
    },
  }
elseif playerClass == "WARRIOR" then
	StatModTable["WARRIOR"] = {
    -- Tanks: Forceful Deflection - Passive
	-- Apply Aura: Mod Combat Rating by % of Stat (8) Value: 27	
    --        Increases your Parry Rating by 25% of your total Strength.
    -- 4.2.0: Increases your Parry Rating by 27% of your total Strength.
	-- 5.0.4: Forceful deflection spell is invisible, but strength still contributes to Parry 
	--        But Strength contributes to Parry%, not Parry Rating. 
	--        Bonus strength also suffers diminishing returns.
	--[[
    ["ADD_PARRY_RATING_MOD_STR"] = {
		{
			--todo: only apply this if they're in "protection" spec
			["rank"] = { 1.08847381108549, }
		},
		{
			["spellid"] = 49410,
			["rank"] = { 0.25, },
			["old"] = 14333, -- 4.2.0
		},
		{
			["spellid"] = 49410,
			["rank"] = { 0.27, },
			["old"] = 14333, -- 4.2.0
		},
    },
	--]]
	-- 5.0.4: Strength adds to Parry %, with bonus strength suffering diminishing returns
	["ADD_PARRY_MOD_STR"] = {
		{
			["known"] = 3127, --SpellID 3127: Parry (Warrior)
			["rank"] = {1}, 
		},
	},
    -- Warrior: Bastion of Defense - Rank 2/2 - 3,10 - Stance: "Interface\\Icons\\Ability_Warrior_DefensiveStance"
    -- 4.0.1: Reduces the chance you'll be critically hit by melee attacks by 3/6% while in Defensive Stance.
	-- 5.0.4: TODO: There are no more talents; removing tab/num.
    ["ADD_CRIT_TAKEN"] = {
      {-- Bastion of Defense
        ["MELEE"] = true,
        --["tab"] = 3,
        --["num"] = 10,
        ["rank"] = {
          -0.03, -0.06,
        },
        ["stance"] = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
      },
    },
    -- Warrior: Shield Wall - Buff: 871
    -- 4.0.1: All damage taken reduced by 40%
    -- Warrior: Glyph of Shield Wall - Buff: 871 - Glyph: 63329
    -- 4.0.1: Shield Wall now reduces damage taken by 60%
    -- Warrior: Defensive Stance - Stance: "Interface\\Icons\\Ability_Warrior_DefensiveStance"
    -- 4.0.1: Decreases damage taken by 10%
    -- Warrior: Battle Stance - Stance: "Interface\\Icons\\Ability_Warrior_OffensiveStance"
    -- 4.0.1: Decreases damage taken by 5%
    -- Warrior: Death Wish - Buff: 12292
    -- 4.0.1: Increases all damage taken by 5%.
    -- Warrior: Glyph of Death Wish - Buff: 12292 - Glyph: 94374
    -- 4.0.1: Death Wish no longer increases damage taken.
    -- Warrior: Recklessness - Buff: 1719
    -- 4.0.1: All damage taken is increased by 20%.
    -- Warrior: Shield Mastery - Rank 3/3 - 3,5 - Spell Block - Buff: 97954
    -- 4.0.1: Magic damage reduced by 7/14/20%.
	-- 5.0.4: TODO: There are no more talents; removing tab/num.
    ["MOD_DMG_TAKEN"] = {
      {-- Shield Wall
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          -0.4,
        },
        ["buff"] = 871,        -- ["Shield Wall"],
      },
      {-- Glyph of Shield Wall
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          -0.2,
        },
        ["buff"] = 871,        -- ["Shield Wall"],
        ["glyph"] = 63329, -- Glyph of Shield Wall,
      },
      {-- Defensive Stance
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          -0.1,
        },
        ["stance"] = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
      },
      {-- Battle Stance
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          -0.05,
        },
        ["stance"] = "Interface\\Icons\\Ability_Warrior_OffensiveStance",
      },
      {-- Death Wish
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          0.05,
        },
        ["buff"] = 12292,        -- ["Death Wish"],
      },
      {-- Glyph of Death Wish
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          -0.05,
        },
        ["buff"] = 12292,        -- ["Death Wish"],
        ["glyph"] = 94374,        -- Glyph of Death Wish
      },
      {-- Recklessness
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {
          0.2,
        },
        ["buff"] = 1719,        -- ["Recklessness"],
      },
      {-- Shield Mastery
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        --["tab"] = 3,
        --["num"] = 5,
        ["rank"] = {
          -0.07, -0.14, -0.2,
        },
        ["buff"] = 97954,        -- ["Spell Block"],
        ["new"] = 13914, -- 4.1.0
      },
    },
    -- Warrior: Last Stand - Buff: 12976
    -- 4.0.1: Health increased by 30% of maximum.
    ["MOD_HEALTH"] = {
      {-- Last Stand
        ["rank"] = {
          0.3,
        },
        ["buff"] = 12975,        -- ["Last Stand"],
      },
    },
    -- Warrior: Toughness - Rank 3/3 - 3,2
    -- 4.0.1: Increases your armor value from items by 3/6/10%.
	-- 5.0.4: TODO: There are no more talents; removing tab/num.
    ["MOD_ARMOR"] = {
      {-- Toughness
        --["tab"] = 3,
        --["num"] = 2,
        ["rank"] = {
          0.03, 0.06, 0.1,
        },
      },
    },
    -- Warrior: Plate Specialization - Passive: 86526
    -- 4.0.1: Increases your primary attribute by 5% while wearing Plate in all armor slots. Arms specialization grants Strength, Fury specialization grants Strength, and Protection specialization grants Stamina.
    -- Warrior: Sentinel - Passive: 29144
    -- 4.0.1: Increases your total Stamina by 15%
    ["MOD_STA"] = {
      {-- Plate Specialization
        ["rank"] = {
          0.05,
        },
        ["known"] = 86526,
        ["armorspec"] = 3,
      },
      {-- Sentinel
        ["rank"] = {
          0.15,
        },
        ["known"] = 29144,
      },
    },
    -- Warrior: Plate Specialization - Passive: 86526
    -- 4.0.1: Increases your primary attribute by 5% while wearing Plate in all armor slots. Arms specialization grants Strength, Fury specialization grants Strength, and Protection specialization grants Stamina.
    ["MOD_STA"] = {
      {-- Plate Specialization
        ["rank"] = {
          0.05,
        },
        ["known"] = 86526,
        ["armorspec"] = 1,
      },
      {-- Plate Specialization
        ["rank"] = {
          0.05,
        },
        ["known"] = 86526,
        ["armorspec"] = 2,
      },
    },
  }
elseif playerClass == "MONK" then
	print("TODO: LibStatLogic:Building StatModTable. Player is MONK; i have no idea what stats that means for their stats. Someone needs to figure out all their talents, what they do, and add them to LibStatLogc's StatModTable");

	StatModTable["MONK"] = {
		--20120810: TODO: Add all the stuff a monk gets that affects tankpoints 
		--(Well, not *just* tankpoints. But TankPoints is all i care about; i don't use RatingBuster)
		
    -- Healers: Mana Meditation: Allows 50% of your mana regeneration from Spirit to continue while you are in combat.
    ["ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"] = {
		{
			["rank"] = {0.5,},
			["known"] = 121278,
		}
	},
	}
else
	print("A new "..playerClass.." class was added to the game! :D i have no idea what their stats are. :(  Adding empty entry to LibStatLogic's StatModTable");
	StatModTable[playerClass] = {
		--A new class was added to the game! (e.g. today it's MONK. Who 
	}
end

--StatModTable Updated to Mists
StatModTable["ALL"] = {
	--Return to fix mod mastery as ammt varies per level
	["MOD_MASTERY"] = {
		{-- Blessing Of Might
			--["rank"] = {0.1,},
			["buff"] = 19740,
		},
		{-- Grace of Air
			--["rank"] = {0.1,},
			["buff"] = 116956,
		},
		{-- Roar of Courage : Hunter Pet - Cat
			--["rank"] = {0.1,},
			["buff"] = 116956,
		},
		{-- Spirit Beast Blessing : Hunter Pet - Spirit Beast
			--["rank"] = {0.1,},
			["buff"] = 128997,
		},	 
	},
	["MOD_CRIT"] = {
		{-- Arcane Brilliance
			["rank"] = {0.05,},
			["buff"] = 79058,        -- ["Arcane Brilliance"],
			["group"] = D["5% Crit Chance"],
		},
		{-- Dalaran Brilliance
			["rank"] = {0.05,},
			["buff"] = 61316,
			["group"] = D["5% Crit Chance"],
		},
		{--  Leader of the Pack - Feral Druid
			["rank"] = {0.05,},
			["buff"] = 17007,
			["group"] = D["5% Crit Chance"],
		},
		{--  Legacy of the White Tiger - windwalker druid
			["rank"] = {0.05,},
			["buff"] = 116781,
			["group"] = D["5% Crit Chance"],
		},
	},
	["MOD_MELEE_HASTE"] = {
		{-- Unholy Aura : Frost & Uhnoly Death Knight
			["rank"] = {0.1,},
			["buff"] = 55610,
			["group"] = D["10% Melee/Ranged Attack Speed"],
		},
		{-- Unleashed Rage - Enchace Shaman 
			["rank"] = {0.1,},
			["buff"] = 30809,
			["group"] = D["10% Melee/Ranged Attack Speed"],
		},
		{-- Swiftblade's Cunning  : Rogue
			["rank"] = {0.1,},
			["buff"] = 113742,
			["group"] = D["10% Melee/Ranged Attack Speed"],
		},
		{--  Cackling Howl : Hunter Pet - Hyena
			["rank"] = {0.1,},
			["buff"] = 128432,
			["group"] = D["10% Melee/Ranged Attack Speed"],
		},
		{--  Serpent's Swiftness: Hunter Pet - Serpent
			["rank"] = {0.1,},
			["buff"] = 128433,
			["group"] = D["10% Melee/Ranged Attack Speed"],
		}
	},

    ["MOD_SPELL_HASTE"] = {
      {-- Moonkin Aura - Druid
        ["rank"] = {0.05,},
        ["buff"] = 24907,
        ["group"] = D["5% Spell Haste"],
      },
      {-- Mind Quickening - Hunter Pet - Sporebat
        ["rank"] = {0.05,},
        ["buff"] = 49868,
        ["group"] = D["5% Spell Haste"],
      },
	       {-- Elemental Oath - Elemental Shaman
        ["rank"] = {0.05,},
        ["buff"] = 51470,
        ["group"] = D["5% Spell Haste"],
      },
	 	       {-- ShadowForm - Shadow Priest
        ["rank"] = {0.05,},
        ["buff"] = 15473,
        ["group"] = D["5% Spell Haste"],
      },
    },
    -- ICC: Chill of the Throne
    --      Chance to dodge reduced by 20%.
    -- 4.0.1: Removed
    ["ADD_DODGE"] = {
      {
        ["rank"] = {-20,},
        ["buff"] = 69127,        -- ["Chill of the Throne"],
      },
    },
    -- Replenishment - Buff
    -- 4.0.1: Replenishes 1% of maximum mana per 10 sec.
    -- 4.0.1: Shadow Priest, Frost Mage, Survival Hunter, Destro Lock, Ret Paladin
    ["ADD_COMBAT_MANA_REGEN_MOD_MANA"] = {
      {
        ["rank"] = {0.005,},
        ["buff"] = 57669,        -- ["Replenishment"],
      },
    },

    ["MOD_DMG_TAKEN"] = {
      {-- Stoneform : Dwarf Racial
        ["rank"] = {-0.1,},
        ["buff"] = 65116,
      },
      {-- Pain Suppression
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.4,},
        ["buff"] = 33206, 
      },
      {-- Anti-Magic Zone
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.75,},
        ["buff"] = 50461, 
      },
      {-- Effulgent Skyflare Diamond
        ["HOLY"] = true,
        ["FIRE"] = true,
        ["NATURE"] = true,
        ["FROST"] = true,
        ["SHADOW"] = true,
        ["ARCANE"] = true,
        ["rank"] = {-0.02,},
        ["meta"] = 41377,
      },
    },

    ["MOD_SPELL_PWR"] = {
      {--  Dark Intent
        ["rank"] = {0.1,},
        ["buff"] = 109773, 
        ["group"] = D["Spell Power Multiplier"],
      },
      {-- Burning Wrath
        ["rank"] = {0.1,},
        ["buff"] = 77747, -- ["Burning Wrath"],
        ["group"] = D["Spell Power Multiplier"],
      },

      {-- Arcane Brilliance
        ["rank"] = {0.1,},
        ["buff"] = 79058,        -- ["Arcane Brilliance"],
        ["group"] = D["Spell Power Multiplier"],
      },
      {-- Dalaran Brilliance
        ["rank"] = {0.1,},
        ["buff"] = 61316,
        ["group"] = D["Spell Power Multiplier"],
      },
    },
    -- Night Elf : Quickness - Racial
    -- 4.0.1: Reduces the chance that melee and ranged attackers will hit you by 2%.
    ["ADD_HIT_TAKEN"] = {
      {
        ["MELEE"] = true,
        ["RANGED"] = true,
        ["rank"] = {-0.02,},
        ["race"] = "NightElf",
      },
    },
    -- MetaGem: Eternal Earthsiege Diamond - Meta: 41396
    -- 4.0.1: +1% Shield Block Value
    -- MetaGem: Eternal Earthstorm Diamond - Meta: 35501
    -- 4.0.1: +1% Shield Block Value
    -- MetaGem: Eternal Shadowspirit Diamond - Meta: 52293
    -- 4.0.1: +5% Shield Block Value
    ["ADD_BLOCK_REDUCTION"] = {
      {-- Eternal Earthsiege Diamond
        ["rank"] = {0.01,},
        ["meta"] = 41396,
      },
      {-- Eternal Earthstorm Diamond
        ["rank"] = {0.01,},
        ["meta"] = 35501,
      },
      {-- Eternal Shadowspirit Diamond
        ["rank"] = {0.05,},
        ["meta"] = 52293,
      },
    },
    -- MetaGem: Austere Earthsiege Diamond - Meta: 41380
    -- 4.0.1: 2% Increased Armor Value from Items
    -- MetaGem: Austere Shadowspirit Diamond - Meta: 52294
    -- 4.0.1: 2% Increased Armor Value from Items
    ["MOD_ARMOR"] = {
      {-- Austere Earthsiege Diamond
        ["rank"] = {0.02,},
        ["meta"] = 41380,
      },
      {-- Austere Shadowspirit Diamond
        ["rank"] = {0.02,},
        ["meta"] = 52294,
      },
    },

    ["MOD_AP"] = {
          {-- Horn of Winter - Death Knight
        ["rank"] = {0.1,},
        ["buff"] = 57330, 
        ["group"] = D["Attack Power Multiplier"],
      },
      {-- Trueshot Aura - Hunter
        ["rank"] = {0.1,},
        ["buff"] = 19506,
        ["group"] = D["Attack Power Multiplier"],
      },
      {-- Unleashed Rage - Shaman
        ["rank"] = {0.1,},
        ["buff"] = 30809,
        ["group"] = D["Attack Power Multiplier"],
      },
    },
    -- Gnome: Expansive Mind - Racial
    -- 4.0.1: Mana pool increased by 5%.
    -- MetaGem: Ember Skyfire Diamond - Meta: 35503
    -- 4.0.1: +2% Maximum Mana
    -- MetaGem: Ember Skyflare Diamond - Meta: 41333
    -- 4.0.1: +2% Maximum Mana
    -- MetaGem: Beaming Earthsiege Diamond - Meta: 41389
    -- 4.0.1: +2% Mana
    -- MetaGem: Ember Shadowspirit Diamond - Meta: 52296
    -- 4.0.1: +2% Maximum Mana
    ["MOD_MANA"] = {
      {-- Expansive Mind
        ["rank"] = {
          0.05,
        },
        ["race"] = "Gnome",
      },
      {-- Beaming Earthsiege Diamond
        ["rank"] = {
          0.02,
        },
        ["meta"] = 41389,
      },
      {-- Ember Skyfire Diamond
        ["rank"] = {
          0.02,
        },
        ["meta"] = 35503,
      },
      {-- Ember Skyflare Diamond
        ["rank"] = {
          0.02,
        },
        ["meta"] = 41333,
      },
      {-- Ember Shadowspirit Diamond
        ["rank"] = {
          0.02,
        },
        ["meta"] = 52296,
      },
    },

    ["MOD_STR"] = {
      {-- Blessing of Kings - paladin
        ["rank"] = {0.05,},
        ["buff"] = 20217, 
        ["group"] = D["Stat Multiplier"],
      },
      {-- Mark of the Wild - Druid
        ["rank"] = {0.05,},
        ["buff"] = 1126, 
        ["group"] = D["Stat Multiplier"],
      },
      {-- Embrace of the Shale Spider - Hunter Pet - Shale Spider
        ["rank"] = {0.05,},
        ["buff"] = 90363,
        ["group"] = D["Stat Multiplier"],
      },
      {-- Legacy of the Emperor - Monk
        ["rank"] = {0.05,},
        ["buff"] = 115921,
        ["group"] = D["Stat Multiplier"],
      },
    },

    ["MOD_AGI"] = {
      {-- Blessing of Kings - paladin
        ["rank"] = {0.05,},
        ["buff"] = 20217, 
        ["group"] = D["Stat Multiplier"],
      },
      {-- Mark of the Wild - Druid
        ["rank"] = {0.05,},
        ["buff"] = 1126, 
        ["group"] = D["Stat Multiplier"],
      },
      {-- Embrace of the Shale Spider - Hunter Pet - Shale Spider
        ["rank"] = {0.05,},
        ["buff"] = 90363,
        ["group"] = D["Stat Multiplier"],
      },
      {-- Legacy of the Emperor - Monk
        ["rank"] = {0.05,},
        ["buff"] = 115921,
        ["group"] = D["Stat Multiplier"],
      },
    },

    ["MOD_STA"] = {
      {-- Power Word: Fortitude -  Priest
        ["rank"] = {0.1,},
        ["buff"] = 21562, 
        ["group"] = D["Stat Multiplier"],
      },
      {-- Blood Pact - Warlock Imp
        ["rank"] = {0.1,},
        ["buff"] = 103127,
        ["group"] = D["Stat Multiplier"],
      },
      {-- Commanding Shout - Warior
        ["rank"] = {0.1,},
        ["buff"] = 469,
        ["group"] = D["Stat Multiplier"],
      },
	      {-- Qiraji Fortitude - Hunter pet - silithid
        ["rank"] = {0.1,},
        ["buff"] = 90364,
        ["group"] = D["Stat Multiplier"],
      },
    },
    ["MOD_INT"] = {
      {-- Blessing of Kings - paladin
        ["rank"] = {0.05,},
        ["buff"] = 20217, 
        ["group"] = D["Stat Multiplier"],
      },
      {-- Mark of the Wild - Druid
        ["rank"] = {0.05,},
        ["buff"] = 1126, 
        ["group"] = D["Stat Multiplier"],
      },
      {-- Embrace of the Shale Spider - Hunter Pet - Shale Spider
        ["rank"] = {0.05,},
        ["buff"] = 90363,
        ["group"] = D["Stat Multiplier"],
      },
      {-- Legacy of the Emperor - Monk
        ["rank"] = {0.05,},
        ["buff"] = 115921,
        ["group"] = D["Stat Multiplier"],
      },
    },

    ["MOD_SPI"] = {
      {-- Mana Tide : Shaman
        ["rank"] = {3.5,},
        ["buff"] = 16191, 
      },
      {-- The Human Spirit
        ["rank"] = {0.03,},
        ["race"] = "Human",
      },
    },
  }

-- Generate buff names
for class, tables in pairs(StatModTable) do
	for modName, mods in pairs(tables) do
		for key, mod in pairs(mods) do
			if mod.buff then
				mod.buffName = GetSpellInfo(mod.buff) or "nil"
			end
			if mod.buff2 then
				mod.buff2Name = GetSpellInfo(mod.buff2) or "nil"
			end
		end
	end
end

local function IsMetaGemActive(item)
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return end
	else
		return
	end
	-- Check if item is in local cache
	local name, link, _, _, _, _, itemSubType = GetItemInfo(item)
	if not name or itemSubType ~= META_GEM then return end
	-- Start parsing
	tip:ClearLines() -- this is required or SetX won't work the second time its called
	tip:SetHyperlink(link)
	if not strfind(tip[3]:GetText(), "|cff808080") then
		-- Metagem requirements satisfied, check if metagem is equipped
		local headLink = GetInventoryItemLink("player", 1)
		if not headLink then return end
		local gemId = StatLogic:GetGemID(item)
		if not gemId then return end
		if strfind(headLink, ":"..gemId..":") then
			return true
		end
	end
end
StatLogic.IsMetaGemActive = IsMetaGemActive

local function SlotHasEnchant(enchantId, slotId)
	-- Check args
	if type(enchantId) ~= "number" then return end
	if (type(slotId) ~= "number") and (type(slotId) ~= "nil") then return end
	-- If slot is specified
	if type(slotId) == "number" then
		local slotLink = GetInventoryItemLink("player", slotId)
		if not slotLink then return end
		if strfind(slotLink, ":"..enchantId..":") then
			return 1
		end
	else
		-- check all slots 1 to 18 if slotId is nil
		local count = 0
		for slotId = 1, 18 do
			local slotLink = GetInventoryItemLink("player", slotId)
			if slotLink and strfind(slotLink, ":"..enchantId..":") then
				count = count + 1
			end
		end
		if count ~= 0 then
			return count
		end
	end
end
StatLogic.SlotHasEnchant = SlotHasEnchant

--[[---------------------------------
  :GetStatMod(stat, school)
-------------------------------------
Notes:
  * Calculates various stat mod values from talents and buffs.
  * initialValue: sets the initial value for the stat mod.
  ::if initialValue == 0, inter-mod operations are done with addition,
  ::if initialValue == 1, inter-mod operations are done with multiplication,
  * finalAdjust: added to the final result before returning, so we can adjust the return value to be used in addition or multiplication.
  :: for addition: initialValue + finalAdjust = 0
  :: for multiplication: initialValue + finalAdjust = 1
  * stat:
  :{| class="wikitable"
  !"StatMod"!!Initial value!!Final adjust!!schoo required
  |-
  |"ADD_CRIT_TAKEN"||0||0||Yes
  |-
  |"ADD_HIT_TAKEN"||0||0||Yes
  |-
  |"ADD_DODGE"||0||0||No
  |-
  |"ADD_AP_MOD_INT"||0||0||No
  |-
  |"ADD_AP_MOD_STA"||0||0||No
  |-
  |"ADD_AP_MOD_ARMOR"||0||0||No
  |-
  |"ADD_PARRY_RATING_MOD_STR"||0||0||No
  |-
  |"ADD_COMBAT_MANA_REGEN_MOD_INT"||0||0||No
  |-
  |"ADD_RANGED_AP_MOD_INT"||0||0||No
  |-
  |"ADD_ARMOR_MOD_INT"||0||0||No
  |-
  |"ADD_SPELL_DMG_MOD_AP"||0||0||No
  |-
  |"ADD_SPELL_DMG_MOD_STA"||0||0||No
  |-
  |"ADD_SPELL_DMG_MOD_INT"||0||0||No
  |-
  |"ADD_SPELL_DMG_MOD_SPI"||0||0||No
  |-
  |"ADD_HEAL_MOD_AP"||0||0||No
  |-
  |"ADD_HEAL_MOD_STR"||0||0||No
  |-
  |"ADD_HEAL_MOD_AGI"||0||0||No
  |-
  |"ADD_HEAL_MOD_STA"||0||0||No
  |-
  |"ADD_HEAL_MOD_INT"||0||0||No
  |-
  |"ADD_HEAL_MOD_SPI"||0||0||No
  |-
  |"ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"||0||0||No
  |-
  |"MOD_CRIT_DAMAGE_TAKEN"||0||1||Yes
  |-
  |"MOD_DMG_TAKEN"||0||1||Yes
  |-
  |"MOD_CRIT_DAMAGE"||0||1||Yes
  |-
  |"MOD_DMG"||0||1||Yes
  |-
  |"MOD_ARMOR"||1||0||No
  |-
  |"MOD_HEALTH"||1||0||No
  |-
  |"MOD_MANA"||1||0||No
  |-
  |"MOD_STR"||0||1||No
  |-
  |"MOD_AGI"||0||1||No
  |-
  |"MOD_STA"||0||1||No
  |-
  |"MOD_INT"||0||1||No
  |-
  |"MOD_SPI"||0||1||No
  |-
  |"MOD_BLOCK_VALUE"||0||1||No
  |-
  |"MOD_AP"||0||1||No
  |-
  |"MOD_RANGED_AP"||0||1||No
  |-
  |"MOD_SPELL_PWR"||0||1||No
  |-
  |"MOD_HEAL"||0||1||No
  |}
Arguments:
  string - The type of stat mod you want to get
  [optional] string - Certain stat mods require an extra school argument
  [optional] string - Target spec to check
  [optional] string - modTable to check, "CLASS", "ALL", "BOTH"(default)
Returns:
  None
Example:
  StatLogic:GetStatMod("MOD_INT")
-----------------------------------]]
local buffGroup = {}
function StatLogic:GetStatMod(stat, school, talentGroup, modTable)
	local statModInfo = StatModInfo[stat]
  
    --Check that it wasn't an invalid stat
    if (statModInfo == nil) then
        local sError = "StatLogic:GetStatMod() Invalid stat mod requested \""..stat.."\""
        print(sError)
        error(sError)
    end
	
    local mod = statModInfo.initialValue
    -- if school is required for this statMod but not given
    if statModInfo.school and not school then
        --print("school is required for this stat, but none given. Returning finalAdjust value")
        return mod + statModInfo.finalAdjust 
    end
    -- disable for 4.0.1 until we get talent/buffs data implemented
    --if toc >= 40000 then return mod + statModInfo.finalAdjust end
    wipe(buffGroup)
  
	if not modTable then modTable = "BOTH" end
    
    -- Class specific mods
    if type(StatModTable[playerClass][stat]) == "table" and modTable ~= "ALL" then
    
        for _, case in ipairs(StatModTable[playerClass][stat]) do

            local ok = true

            if school and not case[school] then ok = nil end
            
            if ok and case.newtoc and toc < case.newtoc then ok = nil end
            if ok and case.oldtoc and toc >= case.oldtoc then ok = nil end
            if ok and case.new and wowBuildNo < case.new then ok = nil end
            if ok and case.old and wowBuildNo >= case.old then ok = nil end
            if ok and case.condition and not loadstring("return "..case.condition)() then ok = nil end
            if ok and case.buffName and not PlayerHasAura(case.buffName) then ok = nil end
            if ok and case.buff2Name and not PlayerHasAura(case.buff2Name) then ok = nil end
            if ok and case.stance and case.stance ~= GetStanceIcon() then ok = nil end
            if ok and case.glyph and not PlayerHasGlyph(case.glyph, talentGroup) then ok = nil end
            if ok and case.enchant and not SlotHasEnchant(case.enchant, case.slot) then ok = nil end
            if ok and case.itemset and ((not PlayerItemSets[case.itemset[1]]) or PlayerItemSets[case.itemset[1]] < case.itemset[2]) then ok = nil end
            if ok and case.armorspec and case.armorspec ~= ArmorSpecActive then ok = nil end
            if ok and case.known and not IsSpellKnown(case.known) then ok = nil end

	--if ok then
--		print(string.format("GetStatMod(%s) %s - OK", stat, case.rank[1]));
--	else
		--print(string.format("GetStatMod(%s) %s - not OK", stat, case.rank[1]));
	--end;

            if ok then
                local r, _
                local s = 1
                -- if talent field
                if case.tab and case.num then
                    _, _, _, _, r = GetTalentInfo(case.tab, case.num, nil, nil, talentGroup)
                    if case.buffName and case.buffStack then
                        _, s = GetPlayerAuraRankStack(case.buffName) -- Gets buff stack count, but use talent as rank
                    end
                elseif case.buffName then
					-- no talent but buff is given
                    r, s = GetPlayerAuraRankStack(case.buffName)
                    if not case.buffStack then
                        s = 1
                    end
                    -- no talent but all other given conditions are statisfied
                else--if case.condition or case.stance then
                    r = 1
                end
                if r and case.rank[r] then
                    if statModInfo.initialValue == 0 and not case.mul then
                        if not case.group then
                            mod = mod + case.rank[r] * s
                        elseif not buffGroup[case.group] then -- this mod is part of a group, but not seen before
                            mod = mod + case.rank[r] * s
                            buffGroup[case.group] = case.rank[r] * s
                        elseif (case.rank[r] * s) > buffGroup[case.group] then -- seen before and this one is better, do upgrade
                            mod = mod + case.rank[r] * s - buffGroup[case.group]
                            buffGroup[case.group] = case.rank[r] * s
                        else 
							-- seen before but not better, do nothing
                        end
                    else
                        if not case.group then
                            mod = mod * (case.rank[r] * s + 1)
                        elseif not buffGroup[case.group] then -- this mod is part of a group, but not seen before
                            mod = mod * (case.rank[r] * s + 1)
                            buffGroup[case.group] = (case.rank[r] * s + 1)
                        elseif (case.rank[r] * s + 1) > buffGroup[case.group] then -- seen before and this one is better, do upgrade
                            mod = mod * (case.rank[r] * s + 1) / buffGroup[case.group]
                            buffGroup[case.group] = (case.rank[r] * s + 1)
                        else 
							-- seen before but not better, do nothing
                        end
                    end
                end
            end
        end
    end
    
    -- Non class specific mods
    if type(StatModTable["ALL"][stat]) == "table" and modTable ~= "CLASS"  then
        for _, case in ipairs(StatModTable["ALL"][stat]) do
            local ok = true
            if school and not case[school] then ok = nil end
            if ok and case.newtoc and toc < case.newtoc then ok = nil end
            if ok and case.oldtoc and toc >= case.oldtoc then ok = nil end
            if ok and case.new and wowBuildNo < case.new then ok = nil end
            if ok and case.old and wowBuildNo >= case.old then ok = nil end
            if ok and case.condition and not loadstring("return "..case.condition)() then ok = nil end
            if ok and case.buffName and not PlayerHasAura(case.buffName) then ok = nil end
            if ok and case.stance and case.stance ~= GetStanceIcon() then ok = nil end
            if ok and case.race and case.race ~= playerRace then ok = nil end
            if ok and case.meta and not IsMetaGemActive(case.meta) then ok = nil end
            if ok then
                local r, _
                local s = 1
                -- if talent field
                if case.tab and case.num then
                    _, _, _, _, r = GetTalentInfo(case.tab, case.num, nil, nil, talentGroup)
                    if case.buffName and case.buffStack then
                        _, s = GetPlayerAuraRankStack(case.buffName) -- Gets buff rank and stack count
                    end
                    -- no talent but buff is given
                elseif case.buffName then
                    r, s = GetPlayerAuraRankStack(case.buffName)
                    if not case.buffStack then
                        s = 1
                    end
                    -- no talent but all other given conditions are statisfied
                else--if case.condition or case.stance then
                    r = 1
                end
                if r and case.rank[r] then
                    if statModInfo.initialValue == 0 then
                        if not case.group then
                            mod = mod + case.rank[r] * s
                        elseif not buffGroup[case.group] then -- this mod is part of a group, but not seen before
                            mod = mod + case.rank[r] * s
                            buffGroup[case.group] = case.rank[r] * s
                        elseif (case.rank[r] * s) > buffGroup[case.group] then -- seen before and this one is better, do upgrade
                            mod = mod + case.rank[r] * s - buffGroup[case.group]
                            buffGroup[case.group] = case.rank[r] * s
                        else -- seen before but not better, do nothing
                        end
                    else
                        if not case.group then
                            mod = mod * (case.rank[r] * s + 1)
                        elseif not buffGroup[case.group] then -- this mod is part of a group, but not seen before
                            mod = mod * (case.rank[r] * s + 1)
                            buffGroup[case.group] = (case.rank[r] * s + 1)
                        elseif (case.rank[r] * s + 1) > buffGroup[case.group] then -- seen before and this one is better, do upgrade
                            mod = mod * (case.rank[r] * s + 1) / buffGroup[case.group]
                            buffGroup[case.group] = (case.rank[r] * s + 1)
                        else -- seen before but not better, do nothing
                        end
                    end
                end
            end
        end
    end

    return mod + statModInfo.finalAdjust
end

--=====================================--
-- Avoidance stats diminishing returns --
--=====================================--
-- Formula reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
--[[---------------------------------
This includes
1. Dodge from Dodge Rating, Agility.
2. Parry from Parry Rating.
3. Chance to be missed from level difference.

The following is the result of hours of work gathering data from beta servers and then spending even more time running 
multiple regression analysis on the data.

1. DR for Dodge, Parry, Missed are calculated separately.
2. Base avoidances are not affected by DR, (ex: Dodge from base Agility)
3. Death Knight's Parry from base Strength is affected by DR, base for parry is 5%.
4. Direct avoidance gains from talents and spells(ex: Evasion) are not affected by DR.
5. Indirect avoidance gains from talents and spells(ex: +Agility from Kings) are affected by DR
6. c and k values depend on class but does not change with level.

7. The DR formula:

1/x' = 1/c+k/x

x' is the diminished stat before converting to IEEE754.
x is the stat before diminishing returns.
c is the cap of the stat, and changes with class.
k is is a value that changes with class.
-----------------------------------]]
-- The following K, C_p, C_d are calculated by Whitetooth (hotdogee [at] gmail [dot] com)
--A per-class diminishing returns 
--Updated To Mists from values on http://elitistjerks.com/f15/t29453-combat_ratings_level_85_cataclysm/p40/
--Values on EJ, quoting Theck of Sacred Duty are out of date.
--http://sacredduty.net/2012/09/14/avoidance-diminishing-returns-in-mop-followup/
--"A few days ago, Pauladin, who has taken over the LibStatLogic and TankPoints addons..."
--Pauladin, that's me.
--Current 201209220
local K = {
	0.956, -- 1: WARRIOR  20120913 - we're (Theck@SacredDuty and i) are confident this is exactly 0.956 for warriors
	0.886, -- 2: PALADIN  20120913 - we're (Theck@SecredDuty and i) are pretty sure this is exactly 0.886 for Paladins
	0.988, -- 3: HUNTER
	0.988, -- 4: ROGUE
	0.983, -- 5: PRIEST
	0.956, -- 6: DEATHKNIGHT 9/28/2012: Confirmed, it is 0.956 - the warrior value.  --It's likely that DeathKnight value matches either the exact Paladin value (0.886) or the exact warrior value (0.956), and is likely *not* 0.885
	0.988, -- 7: SHAMAN
	0.983, -- 8: MAGE
	0.983, -- 9: WARLOCK
	1.422, --10: MONK  10/14/2012: confirmed
	1.222, --11: DRUID Updated
}

--[[
	C_p - Parry cap constant. In the limit of diminishing returns; Parry% will not be able to exceed C_p
	
	With Mists only five classes can parry:
		--SpellID: 3127   Parry (Warrior)
		--SpellID: 82245  Parry (Rogue)
		--SpellID: 82246  Parry (Death Knight)
		--SpellID: 82242  Parry (Paladin)
		--SpellID: 116812 Parry (Monk)

	9/19/2012: Updated To Mists from values on http://elitistjerks.com/f15/t29453-combat_ratings_level_85_cataclysm/p40/
	
	9/20/2012: Values on EJ, quoting Theck of Sacred Duty are out of date.
		http://sacredduty.net/2012/09/14/avoidance-diminishing-returns-in-mop-followup/
		"A few days ago, Pauladin, who has taken over the LibStatLogic and TankPoints addons..."
		--Signed: Pauladin

--Current: 9/20/2012
--]]
local C_p = {
	237.1859113309,			-- 1: WARRIOR     SpellID 3127.  9/21/2012: 237.1859113309 is the parry cap for Warriors and Paladins
	237.1859113309,			-- 2: PALADIN	  SpellID 82242. 9/21/2012: 237.1859113309 is the parry cap for Warriors and Paladins
	0,						-- 3: HUNTER        Hunters cannot parry
	1/0.006870,				-- 4: ROGUE       SpellID 82245. value not yet known for 5.0.4
	0,						-- 5: PRIEST        Priests cannot parry
	235.5,	-- 6: DEATHKNIGHT SpellID 82246 Updated & Tested with 5.0.4
	0,						-- 7: SHAMAN        Shamans cannot parry
	0,						-- 8: MAGE          Mages cannot parry
	0,						-- 9: WARLOCK       Warlocks cannot parry
	50.27624309392237416,	--10: MONK        SpellID 116812. Updated for 5.0.4
	1/0.0152366,			--11: DRUID         Druids cannot parry
}


--[[
	C_d - Dodge cap constant

	9/19/2012  Updated To Mists from values on http://elitistjerks.com/f15/t29453-combat_ratings_level_85_cataclysm/p40/

	Values on EJ, quoting Theck of Sacred Duty are out of date.
	http://sacredduty.net/2012/09/14/avoidance-diminishing-returns-in-mop-followup/
		"A few days ago, Pauladin, who has taken over the LibStatLogic and TankPoints addons..."
	-signed, Pauladin

	Current 201209220
	--]]
local C_d = {
	90.64250,			    -- 1: WARRIOR  20120914: 90.64250 according to latest estimates
	66.56745,			    -- 2: PALADIN  20120914: 66.56745  
	1/0.006870,			    -- 3: HUNTER
	1/0.006870,			    -- 4: ROGUE
	1/0.006650,			    -- 5: PRIEST
	90.6424636103365,	    -- 6: DEATHKNIGHT 9/28/2012: It's not 65ish, it's 90ish.  --Updated & Tested Works
	1/0.006870,			    -- 7: SHAMAN
	1/0.006650,			    -- 8: MAGE
	1/0.006650,			    -- 9: WARLOCK
	501.25,					--10: MONK  10/14/2012: Dodge cap is 501.25 (AgilityPerDodge=951.159294889489, k=1.422)
	150.370955843361,		--11: DRUID 9/26/2012: added the more decimal places.  1/0.0066533599467731 = 150.3  
}

--C_b - Block Chance % cap constant
local C_b = {
	150.375950272321,	-- 1: WARRIOR  20120916: 150.375950272321 is the block cap for warriors
	150.375950272321,	-- 2: PALADIN  20120914: 150.375950272321
	145.560407569141,	-- 3: HUNTER
	145.560407569141,	-- 4: ROGUE
	150.375939849624,	-- 5: PRIEST
	65.6314400850583,	-- 6: DEATHKNIGHT
	145.560407569141,	-- 7: SHAMAN
	150.375939849624,	-- 8: MAGE
	150.375939849624,	-- 9: WARLOCK
	125,				--10: MONK  20120809: added Monk entry. TODO: come up with a real number for "C_b".
	116.890707188778,	--11: DRUID
}


--C_m - Melee hit avoid cap constant
--[[
	I've done extensive tests that show the miss cap is 16% for warriors.
	Because the only tank I have with 150 pieces of epic gear required for the tests is a warrior,
	Until someone that has the will and gear to preform the tests for other classes, I'm going to assume the cap is the same(which most likely isn't)
--]]
local C_m = {
	16,	-- 1: WARRIOR
	16,	-- 2: PALADIN
	16,	-- 3: HUNTER
	16,	-- 4: ROGUE
	16,	-- 5: PRIEST
	16,	-- 6: DEATHKNIGHT
	16,	-- 7: SHAMAN
	16,	-- 8: MAGE
	16,	-- 9: WARLOCK
	16,	--10: MONK  20120809: added Monk entry. TODO: come up with a real number for "C_d". i just typed in 0.008 since it looks averageish. i don't even know what "C_d" is supposed to represent.
	16,	--11: DRUID
}

local BaseBlock = {
	13,	-- 1: WARRIOR
	13,	-- 2: PALADIN  20120914: 13%
	13,	-- 3: HUNTER
	13,	-- 4: ROGUE
	13,	-- 5: PRIEST
	13,	-- 6: DEATHKNIGHT
	13,	-- 7: SHAMAN
	13,	-- 8: MAGE
	13,	-- 9: WARLOCK
	13,	--10: MONK
	13,	--11: DRUID
}

--Agility per Dodge Chance
local Q_d = {
	10000,				-- 1: WARRIOR  9/26/2012: Assumed to be exactly 10,000 for warriors
	10000,				-- 2: PALADIN  9/26/2012: Assumed to be exactly 10,000 for paladins
	10000,				-- 3: HUNTER   For lack of a better number we'll say 10k
	10000,				-- 4: ROGUE   For lack of a better number we'll say 10k
	10000,				-- 5: PRIEST   For lack of a better number we'll say 10k
	10000,				-- 6: DEATHKNIGHT   For lack of a better number we'll say 10k
	10000,				-- 7: SHAMAN   For lack of a better number we'll say 10k
	10000,				-- 8: MAGE   For lack of a better number we'll say 10k
	10000,				-- 9: WARLOCK   For lack of a better number we'll say 10k
	10000,				--10: MONK   For lack of a better number we'll say 10k
	243.614509289585,	--11: DRUID  9/26/2012  From regression of agility values
}
--[[
	Returns your 
--]]
function StatLogic:GetMissedChanceBeforeDR()
	--[[
	20120812 Your base chance to miss a mob used to be 5% starting at mobs your own level (see PaperDollFrame.lua):
			BASE_MISS_CHANCE_PHYSICAL = {
				[0] = 5.0;   mob your own level        |==========
				[1] = 5.5;   mob +1 level above you    |===========
				[2] = 6.0;   mob +2 levels above you   |============
				[3] = 8.0;   mob +3 levels above you   |================
			};
			
	With 5.0.4 (Mists of Panderia), the base chance is now 3%:
			BASE_MISS_CHANCE_PHYSICAL = {
				[0] = 3.0;   |======
				[1] = 4.5;   |=========
				[2] = 6.0;   |============
				[3] = 7.5;   |===============
			};			

	Defense, and all the math that went along with it, was removed in cataclysm.
	Defense was used to be a complicated method to essentially work out that i am more likely
	to miss mobs that are higher level than me.	
	In fact, in Cataclysm the scale was non-linear.
	In Mists it does look linear (over the +0..+3 range), but your chance to be missed still depends on
	how many levels above you the attacker is, not your defense.
	--]]
			
	--local baseDefense, additionalDefense = UnitDefense("player"); --400, 0 for level 85
	--local defenseFromDefenseRating = floor(self:GetEffectFromRating(GetCombatRating(CR_DEFENSE_SKILL), CR_DEFENSE_SKILL)); --GetCombatRating(CR_DEFENSE_SKILL) always returns zero
	--local modMissed = defenseFromDefenseRating * 0.04
	--local drFreeMissed = 5 + (baseDefense + additionalDefense - defenseFromDefenseRating) * 0.04
	--return modMissed, drFreeMissed
	return BASE_MISS_CHANCE_PHYSICAL[0], BASE_MISS_CHANCE_PHYSICAL[0]
end

--[[---------------------------------
  :GetDodgeChanceBeforeDR()
-------------------------------------
Notes:
  * Calculates your current Dodge% before diminishing returns.
  * Dodge% = modDodge + drFreeDodge
  * drFreeDodge includes:
  ** Base dodge
  ** Dodge from base agility
  ** Dodge modifier from base defense
  ** Dodge modifers from talents or spells
  * modDodge includes
  ** Dodge from dodge rating
  ** Dodge from additional defense
  ** Dodge from additional dodge
Arguments:
  None
Returns:
  ; modDodge : number - The part that is affected by diminishing returns.
  ; drFreeDodge : number - The part that isn't affected by diminishing returns.
Example:
  local modDodge, drFreeDodge = StatLogic:GetDodgeChanceBeforeDR()
	8.8917, 5.0257
	which when added gives 13.9174. 
	Then then has to suffer DR down to 13.
-----------------------------------]]
local BaseDodge
function StatLogic:GetDodgeChanceBeforeDR()

	--UseGetDodgeChance to do all the heavy lifting
	
	local dodgeRating = GetCombatRating(CR_DODGE);
	local agility = UnitStat("player", 2); --2=Strength
	local class = ClassNameToID[playerClass];
	
	local dodgeChance, dodgeBeforeDR, freeDodge = StatLogic:GetDodgeChance(dodgeRating, agility, class);

	return dodgeBeforeDR-freeDodge, freeDodge;

	--[[
	local class = ClassNameToID[playerClass];

	-- drFreeDodge
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 2); -- 2 = Agility
	local baseAgi = stat - posBuff - negBuff;
	local dodgePerAgi = self:GetDodgePerAgi();
  
	--local drFreeDodge = BaseDodge[class] + dodgePerAgi * baseAgi
	--			+ self:GetStatMod("ADD_DODGE") + (baseDefense - UnitLevel("player") * 5) * 0.04
	-- modDodge
	local dodgeFromDodgeRating = self:GetEffectFromRating(GetCombatRating(CR_DODGE), CR_DODGE, UnitLevel("player"));
	--local dodgeFromDefenceRating = floor(self:GetEffectFromRating(GetCombatRating(CR_DEFENSE_SKILL), CR_DEFENSE_SKILL)) * 0.04;
	local dodgeFromAdditionalAgi = dodgePerAgi * (effectiveStat - baseAgi);
	local modDodge = dodgeFromDodgeRating + dodgeFromAdditionalAgi;

	local drFreeDodge = GetDodgeChance() - self:GetAvoidanceAfterDR("DODGE", modDodge, class);

	return modDodge, drFreeDodge
	--]]
end


--[[---------------------------------
  :GetParryChanceBeforeDR()
-------------------------------------
Notes:
  * Calculates your current Parry% before diminishing returns.
  * Parry% = modParry + drFreeParry
  * drFreeParry includes:
  ** Base parry
  ** Parry from base agility
  ** Parry modifers from talents or spells
  * modParry includes
  ** Parry from parry rating
  ** Parry from additional parry
Arguments:
  None
Returns:
  ; modParry : number - The part that is affected by diminishing returns.
  ; drFreeParry : number - The part that isn't affected by diminishing returns.
Example:
  local modParry, drFreeParry = StatLogic:GetParryChanceBeforeDR()
-----------------------------------]]
function StatLogic:GetParryChanceBeforeDR()

	--UseGetParryChance to do all the heavy lifting
	local parryRating = GetCombatRating(CR_PARRY);
	local strength = UnitStat("player", 1); --1=Strength
	local class = ClassNameToID[playerClass];
	
	local parryChance, parryBeforeDR, freeParry = StatLogic:GetParryChance(parryRating, strength, class);

	return parryBeforeDR-freeParry, freeParry;
	
	--[[	
	local parryFromParryRating = self:GetEffectFromRating(GetCombatRating(CR_PARRY), CR_PARRY)
	local modParry = parryFromParryRating;

	-- drFreeParry
	local drFreeParry = GetParryChance() - self:GetAvoidanceAfterDR("PARRY", modParry, class)

	return modParry, drFreeParry;
	--]]
end

--[[---------------------------------
  :GetAvoidanceAfterDR(avoidanceType, avoidanceBeforeDR[, class])
-------------------------------------
Notes:
  * Avoidance DR formula and k, C_p, C_d constants derived by Whitetooth (hotdogee [at] gmail [dot] com)
  * avoidanceBeforeDR is the part that is affected by diminishing returns.
  * See :GetClassIdOrName(class) for valid class values.
  * Calculates the avoidance after diminishing returns, this includes:
  *# Dodge from Dodge Rating, Agility.
  *# Parry from Parry Rating.
  *# Chance to be missed.
  * The DR formula: 1/x' = 1/c+k/x
  ** x' is the diminished stat before converting to IEEE754.
  ** x is the stat before diminishing returns.
  ** c is the cap of the stat, and changes with class.
  ** k is is a value that changes with class.
  * Formula details:
  *# DR for Dodge, Parry, Missed are calculated separately.
  *# Base avoidances are not affected by DR, (ex: Dodge from base Agility)
  *# Death Knight's Parry from base Strength is affected by DR, base for parry is 5%.
  *# Direct avoidance gains from talents and spells(ex: Evasion) are not affected by DR.
  *# Indirect avoidance gains from talents and spells(ex: +Agility from Kings) are affected by DR
  *# c and k values depend on class but does not change with level.
  :{| class="wikitable"
  ! !!k!!C_p!!1/C_p!!C_d!!1/C_d
  |-
  |Warrior||0.9560||47.003525||0.021275||88.129021||0.011347
  |-
  |Paladin||0.9560||47.003525||0.021275||88.129021||0.011347
  |-
  |Hunter||0.9880||145.560408||0.006870||145.560408||0.006870
  |-
  |Rogue||0.9880||145.560408||0.006870||145.560408||0.006870
  |-
  |Priest||0.9530||0||0||150.375940||0.006650
  |-
  |Deathknight||0.9560||47.003525||0.021275||88.129021||0.011347
  |-
  |Shaman||0.9880||145.560408||0.006870||145.560408||0.006870
  |-
  |Mage||0.9530||0||0||150.375940||0.006650
  |-
  |Warlock||0.9530||0||0||150.375940||0.006650
  |-
  |Monk|| ? || ? || ? || ? || ?
  |-
  |Druid||0.9720||0||0||116.890707||0.008555
  |}
Arguments:
  string - "DODGE", "PARRY", "MELEE_HIT_AVOID"(NYI)
  number - amount of avoidance before diminishing returns in percentages.
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; avoidanceAfterDR : number - avoidance after diminishing returns in percentages.
Example:
  local modParry, drFreeParry = StatLogic:GetParryChanceBeforeDR()
  local modParryAfterDR = StatLogic:GetAvoidanceAfterDR("PARRY", modParry)
  local parry = modParryAfterDR + drFreeParry

  local modParryAfterDR = StatLogic:GetAvoidanceAfterDR("PARRY", modParry, "WARRIOR")
  local parry = modParryAfterDR + drFreeParry
-----------------------------------]]
function StatLogic:GetAvoidanceAfterDR(avoidanceType, avoidanceBeforeDR, class)

	-- argCheck for invalid input
	self:argCheck(avoidanceType, 2, "string")
	self:argCheck(avoidanceBeforeDR, 3, "number")
	self:argCheck(class, 4, "nil", "string", "number")

	--[[
		20120810 - Strange quirk in LUA
			1/0 is +INF (division by zero)
		but
			1 / ( 1/0) is 0

		Some users are experiencing division by zero error
		Lets avoid the division by zero altogether.
	--]]
	if (avoidanceBeforeDR == 0) then
		return 0;
	end;
	
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > CLASSID_MAX then
		-- if class is invalid input, default to player class
		class = ClassNameToID[playerClass]
	end

	local C = C_d; --assume they want "DODGE"
	if avoidanceType == "PARRY" then
		C = C_p
	elseif avoidanceType == "MELEE_HIT_AVOID" then
		C = C_m
	end
	
	if (class == CLASSID_MONK) then --MONK
		--print("TODO: LibStatLogic:GetAvoidanceAfterDR - table C_dodge[], C_parry[], C_meleeHitAvoid[] and K[] need to have their MONK values updated");
	end;
	
	assert(C[class], string.format('C[%s] is nil', class or "nil"));
	assert(K[class], string.format('K[%s] is nil', class or "nil"));
	
--	print("avoidanceType: "..avoidanceType);
--	print("avoidanceBeforeDR: "..avoidanceBeforeDR);
--	print("class: "..class);
	
--	print("C[class]: "..C[class]);
--	print("K[class]: "..K[class]);

	--The formula is: value = DRValue/(DRValue/Cap + k)
	--But we've seen them applying rounding to the denominator first
	
	local diminishingFactor = 1/(avoidanceBeforeDR/C[class] + K[class]);
	
	return avoidanceBeforeDR / diminishingFactor;
	
	--return 1 / (1 / C[class] + K[class] / avoidanceBeforeDR)
end

--[[---------------------------------
  :GetAvoidanceGainAfterDR(avoidanceType, gainBeforeDR)
-------------------------------------
Notes:
  * Calculates the avoidance gain after diminishing returns with player's current stats.
Arguments:
  string - "DODGE", "PARRY", "MELEE_HIT_AVOID"(NYI)
  number - Avoidance gain before diminishing returns in percentages.
Returns:
  ; gainAfterDR : number - Avoidance gain after diminishing returns in percentages.
Example:
  -- How much dodge will I gain with +30 Agi after DR?
  local gainAfterDR = StatLogic:GetAvoidanceGainAfterDR("DODGE", 30*StatLogic:GetDodgePerAgi())
  -- How much dodge will I gain with +20 Parry Rating after DR?
  local gainAfterDR = StatLogic:GetAvoidanceGainAfterDR("PARRY", StatLogic:GetEffectFromRating(20, CR_PARRY))
-----------------------------------]]
function StatLogic:GetAvoidanceGainAfterDR(avoidanceType, gainBeforeDR)
	-- argCheck for invalid input
	self:argCheck(gainBeforeDR, 2, "number")
	local class = ClassNameToID[playerClass]

	if avoidanceType == "PARRY" then
		local modAvoidance, drFreeAvoidance = self:GetParryChanceBeforeDR();
		local newAvoidanceChance = self:GetAvoidanceAfterDR(avoidanceType, modAvoidance + gainBeforeDR) + drFreeAvoidance;
		if newAvoidanceChance < 0 then newAvoidanceChance = 0 end;
		return newAvoidanceChance - GetParryChance();
	elseif avoidanceType == "DODGE" then
		local modAvoidance, drFreeAvoidance = self:GetDodgeChanceBeforeDR();
		local newAvoidanceChance = self:GetAvoidanceAfterDR(avoidanceType, modAvoidance + gainBeforeDR) + drFreeAvoidance;
		if newAvoidanceChance < 0 then newAvoidanceChance = 0 end; -- because GetDodgeChance() is 0 when negative
		return newAvoidanceChance - GetDodgeChance();
	elseif avoidanceType == "MELEE_HIT_AVOID" then
		local modAvoidance = self:GetMissedChanceBeforeDR();
		return self:GetAvoidanceAfterDR(avoidanceType, modAvoidance + gainBeforeDR) - self:GetAvoidanceAfterDR(avoidanceType, modAvoidance);
	end
end

local function toSingle(value)
	--perform 15-bit rounding
	return floor(value*32768 + 0.5) / 32768;
end;

--[[
	parryChance, parryBeforeDR, freeParry = StatLogic:GetParryChance([parryRating], [strength], [classId]);
	
	params
		parryRating (number, optional): The players Parry Rating. If nil will use the current player's Parry Rating
		strength (number, optional): The player's Strength. If nil will use the current player's Strength
		classId (number, string, optiona): The player's classId number or ClassName string. If empty will use the current player's class

	returns
		parryChance (number): the player's Parry Chance, a percentage number (e.g. 37.5432)
		parryBeforeDR (number): the player's Parry Chance before diminishing returns, a percentage number (e.g. 38.8832)
		freeParry (number): the portion of Parry Chance that does not suffer diminishing returns (e.g 5.01)
							Is a combination of base Parry Chance, as well as Parry Chance from base Strength
--]]
function StatLogic:GetParryChance(parryRating, strength, class)
--[[
	Thanks to Thack for figuring out how Strength affects Parry.
		http://sacredduty.net/2012/07/06/avoidance-diminishing-returns-in-mop-part-3/
		
	drParry = (totalStr-baseStr)/Qs + parryRating/Rp           ;the amount of Parry that is affected by diminishing returns (dr)

	totalParry = baseParry + baseStr/Qs + drParry/(drParry/Cp + k)
												
	Where 
		baseParry: is your per-race base Parry amount
		baseStr:   is your Strength befor any +Strength (varies per race)
		preParry:  is your Parry from Parry Rating, before diminishing returns (=GetCombatRatingBonus(CR_PARRY), parryRating/Pc )
		Cp:        is a constant for Parry
		k:         is a constant
		Qs:        is a constant that converts Strength to Parry Chance (varies by level)
		
	The important points are:
		- if you're naked, =GetParryChance() returns the sum from (baseParry + baseStr/Q)
		- Parry from base Strength doesn't suffer diminishing returns
		- Parry from bonus Strength does suffer diminishing returns
		- Parry from Parry Rating does suffer diminishing returns
		
	baseParry
		HUMAN = 3%
		
	baseStrength   UnitStat("player", 1)[1]-[3]
		HUMAN = 164 
		
	Diminishing returns formulas has a strange effect that low parry values are boosted.
		Any pre-parry value (parryFromStrength + parryFromRating) above:
			
					Cp-Cp*k
					
		is diminshed, while values under that are increased.
		For level 85 paladin that works out to:
					Cp - Cp*k
					= Cp*(1-k)
					= 237.164919575071 * (1-0.88598405026478)
					= 237.164919575071 * (0.11401594973522)
					= 27.04058354922878897736270062
					
		Which means it can help to think of Cp as an upper-bound, and k defines the transition point on that curve
--]]
	--if Parry Rating is nil, then get the player's current Parry Rating
	if (parryRating == nil) then
		parryRating = GetCombatRating(CR_PARRY);
	end;

	--if strength is nil, then get the player's current Strength
	if (strength == nil) then
		strength = UnitStat("player", 1); --1=Strength
	end;

	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > CLASSID_MAX then
		-- if class is invalid input, default to player class
		class = ClassNameToID[playerClass]
	end;

	local baseParry = 3; --e.g. 3%, Humans have base parry of 3%
	
	--SpellID: 3127   Parry (Warrior)
	--SpellID: 82245  Parry (Rogue)
	--SpellID: 82246  Parry (Death Knight)
	--SpellID: 82242  Parry (Paladin)
	--SpellID: 116812 Parry (Monk)
	
	local base, stat, posBuff, negBuff = UnitStat("player", 1); --1=Strength
	local baseStr = stat-posBuff+negBuff; --e.g. 5125, 5125, 4953, 0
	
	local k = K[class];    --(varies by class) diminishing returns constant, e.g. exactly 0.886 for Paladin
	local Cp = C_p[class]; --(varies by class) parry cap constant (e.g. 237.164919575071)
	
	--local QsL85 = 243.605345852; --conversion factor of Strength to Parry%. E.g. 243.6 Strength --> +1% Parry (before DR)
	--local QsL86 = 319.31752794619; --conversion factor of Strengh to Parry%. 
	--local QsL87 = nil;
	--local QsL88 = 551.672074504046;
	--local QsL89 = nil;
	--local QsL90 = 951.158596; --conversion factor of Strength to Parry for Paladins and warriors (exact, given by Ghostcrawler: http://us.battle.net/wow/en/forum/topic/5889309137?page=90#1785)
	local Qs = StatLogic:GetStrPerParry();
	
	local Qsi;
	if (Qs ~= 0) then
		Qsi = 1/Qs;
	else
		Qsi = 0;
	end;
	
	--local Pc = 265.078336847015; --Parry% from Parry Rating, before diminishing returns

	local freeParry = baseParry + baseStr*Qsi;
	local bonusParry = toSingle((strength-baseStr)*Qsi + StatLogic:GetEffectFromRating(parryRating, CR_PARRY));

	local parryBeforeDR = freeParry + bonusParry; --combination of free Parry, Parry from Parry Rating, and Parry from bonus Strength

	--print(string.format("Cp = %s, k=%s, Q=%s, strength=%s, baseStr=%s, parryRating=%s, freeParry=%s, bonusParry=%s, parryBeforeDR=%s", 
	--		Cp, k, Q, strength, baseStr, parryRating, freeParry, bonusParry, parryBeforeDR));
	
	local parryChance;
	if (bonusParry ~= 0) then
		parryChance = freeParry + bonusParry/(bonusParry/Cp + k);
	else
		parryChance = freeParry;
	end;

	return parryChance, parryBeforeDR, freeParry;
end;

--[[
	dodgeChance, dodgeBeforeDR, freeDodge = StatLogic:GetDodgeChance([dodgeRating], [agility], [classId]);
	
	params
		dodgeRating (number, optional): The players Dodge Rating. If nil will use the current player's Dodge Rating
		agility (number, optional): The player's Agility. If nil will use the current player's Agility
		classId (number, string, optiona): The player's classId number or ClassName string. If empty will use the current player's class

	returns
		dodgeChance (number): the player's Dodge Chance, a percentage number (e.g. 37.5432)
		dodgeBeforeDR (number): the player's Dodge Chance before diminishing returns, a percentage number (e.g. 38.8832)
		freeDodge (number): the portion of Dodge Chance that does not suffer diminishing returns (e.g 5.01)
							Is a combination of base Dodge Chance, as well as Dodge Chance from base Agility
--]]
function StatLogic:GetDodgeChance(dodgeRating, agility, class)
--[[
	Thanks to Thack for figuring out how Agility affects Dodge.
		http://sacredduty.net/2012/07/06/avoidance-diminishing-returns-in-mop-part-3/
		
	drDodge = bonusAgi/Qd + dodgeRating/265.078336847015		;the amount of dodge affected by diminishing returns (dr)
		
	totalDodge = baseDodge + baseAgi/Qd + drDodge/(drDodge/Cd + k)
												
	Where 
		baseDodge: is your per-race base Dodge amount
		baseAgi:   is your Agility befor any +Agility (varies per race) (e.g. 97)
		preDodge:  is your Dodge from Dodge Rating, before diminishing returns (=GetCombatRatingBonus(CR_DODGE), dodgeRating/Pd )
		Cd:        is a Dodge cap constant (e.g. 66.552213340240500)
		k:         is a constant (e.g. 0.886000000000000)
		Qd:        is a constant that converts Agility to Dodge Chance (10000.00000000000000)
		
	The important points are:
		- if you're naked, =GetDodgeChance() returns the sum from (baseDodge + baseStr/Qd)
		- Dodge from base Agility doesn't suffer diminishing returns
		- Dodge from bonus Agility does suffer diminishing returns
		- Dodge from Dodge Rating does suffer diminishing returns
		
	baseDodge
		HUMAN = 5%
		
	baseAgi   UnitStat("player", 1)[1]-[3]
		HUMAN = 97 
		
	Diminishing returns formulas has a strange effect that low Dodge values are boosted.
		Any pre-Dodge value (dodgeFromAgility + dodgeFromRating) above:
			
					Cd-Cd*k
					
		is diminshed, while values under that are increased.
		For level 85 paladin that works out to:
					Cd - Cd*k
					= Cd*(1-k)
					= 66.552213340240500 * (1-0.88598405026478)
					= 66.552213340240500 * (0.11401594973522)
					= 7.5880138109684988
					
		Which means it can help to think of Cd as an upper-bound, and k defines the transition point on that curve
--]]
	--if Dodge Rating is nil, then get the player's current Dodge Rating
	if (dodgeRating == nil) then
		dodgeRating = GetCombatRating(CR_DODGE);
	end;

	--if Agility is nil, then get the player's current Agility
	if (agility == nil) then
		agility = UnitStat("player", 2); --2=Agility
	end;

	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > CLASSID_MAX then
		-- if class is invalid input, default to player class
		class = ClassNameToID[playerClass]
	end;

	local baseDodge = StatLogic:GetBaseDodge(class); --e.g. 5%, Humans have base dodge of 5%

	local baseAgi;
	local base, stat, posBuff, negBuff = UnitStat("player", 2); --1=Agility
	local baseAgi = stat-posBuff+negBuff; --e.g. 5125, 5125, 4953, 0
	
	local Cd = C_d[class]; --dodge cap constant (e.g. 66.56745)
	local k = K[class]; --diminishing returns constant, e.g. 0.886 for Paladin
	local Qd = Q_d[class]; --conversion factor of Agility to Dodge Chance %. E.g. 10000 Agility --> +1% Dodge (before DR)
	
	--local Dc = 265.078336847015; --Dodge Chance % from Dodge Rating, before diminishing returns (same value as for Parry)

	local freeDodge = baseDodge + baseAgi/Qd + (StatLogic:GetStatMod("ADD_DODGE") or 0)*100;
	local bonusDodge = toSingle((agility-baseAgi)/Qd + StatLogic:GetEffectFromRating(dodgeRating, CR_DODGE));
	
	local dodgeBeforeDR = freeDodge + bonusDodge; --combination of free Dodge, Dodge from Dodge Rating, and Dodge from bonus Agility

	--print(string.format("Cp = %s, k=%s, Q=%s, strength=%s, baseStr=%s, dodgeRating=%s, freeDodge=%s, bonusDodge=%s, dodgeBeforeDR=%s", 
		--	Cp, k, Q, strength, baseStr, dodgeRating, freeDodge, bonusDodge, dodgeBeforeDR));
	
	local dodgeChance;
	if (bonusDodge ~= 0) then
		dodgeChance = freeDodge + bonusDodge/(bonusDodge/Cd + k);
	else
		dodgeChance = freeDodge;
	end;

	return dodgeChance, dodgeBeforeDR, freeDodge;
end;

--[[
	blockChance, blockBeforeDR, freeBlock = StatLogic:GetBlockChance([mastery], [classId]);
	
	params
		mastery (number, optional): The players Mastery. If nil will use the current player's Mastery
		classId (number, string, optiona): The player's classId number or ClassName string. If empty will use the current player's class

	returns
		blockChance (number): the player's Block Chance, a percentage number (e.g. 37.5432)
		blockBeforeDR (number): the player's Block Chance before diminishing returns, a percentage number (e.g. 38.8832)
		freeBlock (number): the portion of Block Chance that does not suffer diminishing returns (e.g 5.01)
							Is a combination of base Block Chance, as well as Block Chance from Mastery
--]]
function StatLogic:GetBlockChance(mastery, class)
--[[
	Thanks to Thack for figuring out how Agility affects Block.
			http://sacredduty.net/2012/07/06/avoidance-diminishing-returns-in-mop-part-3/
		
	drBlock = mastery = baseMastery + masteryRating/179.280042052667      ;the amount of block affected by diminishing returns (dr)
	
	Blizzard, probably unknowningly, performs diminishing returns from on Block from Mastery in a fixed Decimal type.
	The type has only 8 bits of decimal precision (i.e. 1/128).
	In order simulate this, and get accurate numbers, we also need to perform a 0.5 round up in the 8th binary decimal point
	
	drBlock = floor(drBlock*128 + 0.5)/128;
		
	totalBlock = baseBlock + drBlock/(drBlock/Cd + k)
												
	Where 
		baseBlock: is your per-race base Block amount
		Cd:        is a Block cap constant (e.g. 66.552213340240500)
		k:         is a constant (e.g. 0.886000000000000)
		
	The important points are:
		- if you're naked, =GetBlockChance() returns the sum from (baseBlock + baseStr/Qd)
		- Block from base Agility doesn't suffer diminishing returns
		- Block from bonus Agility does suffer diminishing returns
		- Block from Block Rating does suffer diminishing returns
		
	baseMastery
		HUMAN = 8%		
		
	baseBlock
		HUMAN = 13%
		
	Diminishing returns formulas has a strange effect that low Block values are boosted.
		Any pre-Block value (blockFromAgility + blockFromRating) above:
			
					Cd-Cd*k
					
		is diminshed, while values under that are increased.
		For level 85 paladin that works out to:
					Cd - Cd*k
					= Cd*(1-k)
					= 66.552213340240500 * (1-0.88598405026478)
					= 66.552213340240500 * (0.11401594973522)
					= 7.5880138109684988
					
		Which means it can help to think of Cd as an upper-bound, and k defines the transition point on that curve
--]]
	--if Mastery  is nil, then get the player's current Mastery 
	if (mastery == nil) then
		mastery = GetMastery();
	end;
	
	--print(string.format("LSL:GetBlockChance: mastery=%s", mastery));
	
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > CLASSID_MAX then
		-- if class is invalid input, default to player class
		class = ClassNameToID[playerClass]
	end;

	local baseBlock = BaseBlock[class]; --e.g. 13%, Humans have base block of 13%

	local Cb = C_b[class]; --block cap constant (e.g. 150.375950272321)
	local k = K[class]; --diminishing returns constant, e.g. 0.886 for Paladin
	
	--local Rm = 179.280042052667; --Mastery % from Mastery Rating

	local freeBlock = baseBlock;
	local bonusBlock = mastery;  -- = baseMastery + masteryRating/Mc;

	local blockBeforeDR = freeBlock + bonusBlock; --combination of free Block, Block from Mastery (from Mastery Rating)

	--20120914 Blizzard is storing intermediate Mastery in a fixed precision 8-bit fraction Decimal.
	--We need to round our bonusBlock to the 1/128
	bonusBlock = floor(bonusBlock*128 + 0.5) / 128;
	
--	print(string.format("Cb = %s, k=%s, freeBlock=%s, bonusBlock=%s, blockBeforeDR=%s", 
			--Cb, k, freeBlock, bonusBlock, blockBeforeDR));
	
	local blockChance;
	if (bonusBlock ~= 0) then
		blockChance = freeBlock + bonusBlock/(bonusBlock/Cb + k);
	else
		blockChance = freeBlock;
	end;
	
	--print(string.format("After DR: Cb = %s, k=%s, freeBlock=%s, bonusBlock=%s, blockBeforeDR=%s, blockChance=%s", 
			--Cb, k, freeBlock, bonusBlock, blockBeforeDR, blockChance));

	return blockChance, blockBeforeDR, freeBlock;
end;


function StatLogic:GetResilienceEffectAfterDR(damageReductionBeforeDR)
	-- argCheck for invalid input
	self:argCheck(damageReductionBeforeDR, 2, "number")
	return 100 - 100 * 0.99 ^ damageReductionBeforeDR
end

function StatLogic:GetResilienceEffectGainAfterDR(resAfter, resBefore)
	-- argCheck for invalid input
	self:argCheck(resAfter, 2, "number")
	self:argCheck(resBefore, 2, "nil", "number")
	local resCurrent = GetCombatRating(16)
	local drBefore
	if resBefore then
		drBefore = self:GetResilienceEffectAfterDR(self:GetEffectFromRating(resCurrent + resBefore, COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN))
	else
		drBefore = GetCombatRatingBonus(16)
	end
	return self:GetResilienceEffectAfterDR(self:GetEffectFromRating(resCurrent + resAfter, COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)) - drBefore
end


--=================--
-- Stat Conversion --
--=================--
--[[---------------------------------
  :GetReductionFromArmor(armor, attackerLevel)
-------------------------------------
Notes:
  * Calculates the damage reduction from armor for given attacker level.
Arguments:
  [optional] number - Armor value. Default: player's armor value
  [optional] number - Attacker level. Default: player's level
Returns:
  ; damageRecudtion : number - Damage reduction value from 0 to 1. (not percentage)
Example:
  local damageRecudtion = StatLogic:GetReductionFromArmor(35000, 80) -- 0.69676006569452
-----------------------------------]]
function StatLogic:GetReductionFromArmor(armor, attackerLevel)
	self:argCheck(armor, 2, "nil", "number");
	self:argCheck(attackerLevel, 3, "nil", "number");
	if not armor then
		armor = select(2, UnitArmor("player"));
	end
	if not attackerLevel then
		attackerLevel = UnitLevel("player");
	end

	--Taken from PaperDollFrame.lua from Mists Beta (20120805 v5.0.4)
	--function PaperDollFrame_GetArmorReduction(armor, attackerLevel)  
	local levelModifier = attackerLevel;
	if ( levelModifier > 85 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier-59)) + (20 * (levelModifier - 80)) + (22 * (levelModifier - 85));
	elseif ( levelModifier > 80 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier - 59)) + (20 * (levelModifier - 80));
	elseif ( levelModifier > 59 ) then
		levelModifier = levelModifier + (4.5 * (levelModifier - 59));
	end
  	local temp = armor/(85*levelModifier + 400);
	local armorReduction = temp/(1+temp);
  
	-- caps at 0.75
	if armorReduction > 0.75 then
		armorReduction = 0.75
	end
	if armorReduction < 0 then
		armorReduction = 0
	end
	return armorReduction;
end

--[[---------------------------------
  :GetEffectFromDefense(defense, attackerLevel)
-------------------------------------
Notes:
  * Calculates the effective avoidance% from defense (before diminishing returns) for given attacker level
Arguments:
  [optional] string - Total defense value. Default: player's armor value
  [optional] number - Attacker level. Default: player's level
Returns:
  ; effect : number - 0.04% per effective defense.
Example:
  local effect = StatLogic:GetEffectFromDefense(415, 83) -- 0
-----------------------------------]]
--[[
	20120812 - Removed, as Defense was removed 2 years ago
	function StatLogic:GetEffectFromDefense(defense, attackerLevel)
	print("LibStatLogic:GetEffectFromDefense - Defense was removed from the game 2 years ago");
	
	self:argCheck(defense, 2, "nil", "number")
	self:argCheck(attackerLevel, 3, "nil", "number")
	if not defense then
		local base, add = UnitDefense("player")
		defense = base + add
	end
	if not attackerLevel then
		attackerLevel = UnitLevel("player")
	end
	return (defense - attackerLevel * 5) * 0.04
end
--]]

-- Build Mastery tables
-- MasterySpells[class][specIndex]
local MasterySpells = {
	{	--1. WARRIOR: 
		{ 76838}, --Arms(Damage)      Mastery: Strikes of Opportunity
		{ 76856}, --Fury(Damage)      Mastery: Unshackled Fury
		{ 76857}, --Protection(Tank)  Mastery: Critical Block
	}, 
	{	--2. Paladin
		{ 76669}, --Holy(Healer)         Mastery: Illuminated Healing
		{ 76671}, --Protection(Tank)     Mastery: Divine Bulwark
		{ 76672}, --Retribution(Damage)  Mastery: Hand of Light
	}, 
	{	--3. Hunter
		{ 76657}, --"Master of Beasts", 
		{ 76659}, --"Wild Quiver", 
		{ 76658}, --"Essence of the Viper"
	}, 
	{	--4. Rogue
		{ 76803}, 
		{ 76806}, 
		{ 76808},
	},
	{	--5. Priest
		{ 77484},
		{ 77485}, 
		{ 77486},
	},
	{	--6. Death Knight
		{ 77513},
		{ 77514},
		{ 77515},
	},
	{	--7. Shaman (verified 5.0.4, 16016)
		{ 77222}, --Elemental(Damage)    Mastery: Elemental Overload 
		{ 77223}, --Enhancement(Damage)  Mastery: Enhanced Elements
		{ 77226}, --Restoration(Healer)  Mastery: Deep Healing
	}, 
	{	--8. Mage
		{ 76547},
		{ 76595},
		{ 76613},
	},
	{
		--9. Warlock
		{ 77215},
		{ 77219},
		{ 77220},
	},
	{	--10. Monk
		{117906}, --Brewmaster: "Mastery: Elusive Brawler"      (Tank)
		{117907}, --Mistweaver: "Mastery: Gift of the Serpent"  (Healer)
		{115636}, --Windwalker: "Mastery: Combo Breaker"        (Damage)
	}, 
	{	--11. Druid (verified 5.0.4, build 15961)
		{77492}, --Balance(Damage)
		{77493}, --Feral(Damage)
		{77494}, --Guardian(Tank)
		{77495}, --Restoration(Healer)   
	},
}
StatLogic.MasterySpells = MasterySpells

-- MasteryEffect[class][specIndex]
local MasteryEffect = {
	{{1.00 }, {1.00}, {1.00,1.00}    }, --WARRIOR (1) (Strikes of Opportunity 2%, Unshackled Fury 4.70%, Block Chance 1.5% & Critical Block Chance 1.5%)
	{{1.00 }, {1.00}, {1.00}         }, --PALADIN (2) (Illuminated Healing 1%, Divine Bulwark 2.25%, Hand of Light 1%)
	{{1.00 }, {1.00}, {1.00}         }, --HUNTER (3)
	{{1.00 }, {1.00}, {1.00}         }, --ROGUE (4)
	{{1.00 }, {1.00}, {1.00}         }, --PRIEST (5)
	{{1.00 }, {1.00}, {1.00}         }, --DEATHKNIGHT (6)
	{{1.00 }, {1.00}, {1.00}         }, --SHAMAN (7)
	{{1.00 }, {1.00}, {1.00}         }, --MAGE (8)
	{{1.00 }, {1.00}, {1.00}         }, --WARLOCK (9)
	{{1.00 }, {1.00}, {1.00}         }, --MONK (10)
	{{1.00 }, {1.00}, {1.00}, {1.00} }, --DRUID (11)  Balance (Damage), Feral (Damage), Guardian (Tank), Restoration (Healer) 
}
if wowBuildNo < 16016 then --Patch 5.0.4 (Aug 21 2012)
	--Pre Mists of Panderia
	MasteryEffect = {
		{{2   }, {4.70}, {1.5,1.5}      }, --WARRIOR (1) (Strikes of Opportunity 2%, Unshackled Fury 4.70%, Block Chance 1.5% & Critical Block Chance 1.5%)
		{{1   }, {2.25}, {1   }         }, --PALADIN (2) (Illuminated Healing 1%, Divine Bulwark 2.25%, Hand of Light 1%)
		{{1.7 }, {2   }, {1   }         }, --HUNTER (3)
		{{3.5 }, {2   }, {2.5 }         }, --ROGUE (4)
		{{2.5 }, {1.25}, {4.3 }         }, --PRIEST (5)
		{{6.25}, {2   }, {4   }         }, --DEATHKNIGHT (6)
		{{2   }, {2.5 }, {2.5 }         }, --SHAMAN (7)
		{{1.5 }, {2.5 }, {2.5 }         }, --MAGE (8)
		{{1.63}, {1.5 }, {1.25}         }, --WARLOCK (9)
		{{1   }, {1   }, {1   }         }, --MONK (10)
		{{1.5 }, {4   }, {3.1 }, {1.25} }, --DRUID (11)  Balance (Damage), Feral (Damage), Guardian (Tank), Restoration (Healer) 
	}
end
StatLogic.MasteryEffect = MasteryEffect
-- Parse spell tooltip text and populate MasteryEffect, run this if mastery values change
-- function MakeMasteryEffect()
  -- for class, specs in ipairs(MasterySpells) do
    -- MasteryEffect[class] = {}
    -- print(strsub(ClassNameToID[class], 1, 1)..strsub(strlower(ClassNameToID[class]), 2))
    -- for spec, spellids in ipairs(specs) do
      -- MasteryEffect[class][spec] = {}
      -- for i, spellid in ipairs(spellids) do
        -- tipMiner:ClearLines() -- this is required or SetX won't work the second time its called
        -- tipMiner:AddSpellByID(spellid)
        -- print((GetSpellInfo(spellid)))
        -- print("Spec: "..(select(2, GetTalentTabInfo(spec))))
        -- print("SpellId: "..spellid)
        -- local descText = _G[MAJOR.."MinerTooltipTextLeft2"]:GetText()
        -- if not descText:find("([%.%d]+)%%") then
          -- descText = _G[MAJOR.."MinerTooltipTextLeft3"]:GetText()
          -- print(_G[MAJOR.."MinerTooltipTextLeft3"]:GetText() or "nil")
        -- else
          -- print(_G[MAJOR.."MinerTooltipTextLeft2"]:GetText() or "nil")
        -- end
        -- local effects = {}
        -- for e in descText:gmatch("([%.%d]+)%%") do
          -- tinsert(effects, tonumber(e))
        -- end
        -- if #effects == 2 then
          -- tinsert(MasteryEffect[class][spec], effects[2])
        -- elseif #effects == 3 then
          -- tinsert(MasteryEffect[class][spec], effects[3])
        -- elseif #effects == 4 then
          -- tinsert(MasteryEffect[class][spec], effects[3])
          -- tinsert(MasteryEffect[class][spec], effects[4])
        -- end
        -- --print(_G[MAJOR.."MinerTooltipTextLeft1"]:GetText() or "nil")
        -- --print(_G[MAJOR.."MinerTooltipTextLeft2"]:GetText() or "nil")
        -- --print(_G[MAJOR.."MinerTooltipTextLeft3"]:GetText() or "nil")
        -- --print("---------")
      -- end
    -- end
  -- end
  -- return MasteryEffect
-- end

--[[---------------------------------
  :GetEffectFromMastery(mastery[, specIndex][, class])
-------------------------------------
Notes:
  * Calculates the effect in percentage from mastery for given spec and class
Arguments:
  number - mastery value.
  [optional] number - talent spec to use. Default: player's talent spec
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
            1=first, 2=second, 3=third, 4=forth (e.g. Druid: 1=Balance, 2=Feral, 3=Guardian, 4=Restoration)
Returns:
  ; effect : number - 0.04% per effective defense.
Example:
  local effect = StatLogic:GetEffectFromMastery(415) -- 0
-----------------------------------]]
function StatLogic:GetEffectFromMastery(mastery, specIndex, class)
	--[[
		20120811  5.0.4 (build 15961) Mists of Panderia
		
		In Cataclysm the supplied "mastery" value is akin to Mists's "Mastery %" value. e.g.:

		Cataclysm
		=========
			Mastery 21.14 (8.00+13.14)
			Divine Bulwark
			Increases your chance to block melee attacks by 47%.
			Each point of Mastery increases block chance by an additional 2.25%
			Mastery rating 2356 (+13.14 mastery)
			
		So that calling GetEffectFromMastery(21.14) = 47.565 (i.e. 47%)
	
		In Mists on Panderia, Mastery has become a percentage itself:

		Mists of Panderia
		=================		
			Mastery 18.04% (8.00% + 10.04%)
			Mastery: Divine Bulwark
			Increases the damage reduction of your Shield of the Righteous by 18%,
				adds 18% to your Bastion of Glory, 
				and increases your chance to block melee attacks by 18%.
			Mastery 2290 (+10.04 mastery).
			
		So "Mastery Rating" now converts to a "Mastery %".
		And that "Mastery Percentage" now applies directly to whatever spell; one-to-one.
		
		There is no longer any notion of:
				"Each point of Mastery increases damage by an additional 2.5%".
				
		That means that in essence this function can be replaced with:
			return mastery;
			
		because a Mastery of 18.04% has an effect of 18.04:
		
			GetEffectFromMastery(18.04) = 18.04 (i.e. 18.04%)
				
		But i will keep the "MasteryEffect" table, filling it with all 1.0 factors.
		
		There is still the notion of having to convert "Mastery Rating" into "Mastery Percentage", 
		and subject to diminishing returns:
		
			GetEffectFromRating(2356, CR_MASTERY) = 13.141453 (4.3.4 build 15595)
	--]] 

	--TODO: convert this function to simply:
	--return 1.0, 1.0, 1.0;
	
	self:argCheck(mastery, 2, "number")
	self:argCheck(specIndex, 3, "nil", "number")

	if type(specIndex) ~= "number" or specIndex < 1 or specIndex > 4 then
	    specIndex = GetSpecialization(); --5.0.3 GetPrimaryTalentTree replaced with GetSpecialization
	    if not specIndex then return 0 end
	end
	
	-- argCheck for invalid input
	self:argCheck(class, 4, "nil", "string", "number")
	
	-- if class is a class string, convert to class id
	if type(class) == "string" then
	    class = ClassNameToID[strupper(class)] or ClassNameToID[playerClass]
	elseif type(class) ~= "number" or (class < 1) or (class > CLASSID_MAX) then
		-- if class is invalid input, default to player class
	    class = ClassNameToID[playerClass]
	end
	return 
			mastery *  MasteryEffect[class][specIndex][1], 
			mastery * (MasteryEffect[class][specIndex][2] or 0),
			mastery * (MasteryEffect[class][specIndex][3] or 0)  --some classes have even 3 effects
end


--[[---------------------------------
  :GetEffectFromRating(rating, id[, level][, class])
-------------------------------------
Notes:
  * Combat Rating formula and constants derived by Whitetooth (hotdogee [at] gmail [dot] com)
  * Calculates the stat effects from ratings for any level.
  * id: Rating ID as definded in PaperDollFrame.lua
  ::CR_WEAPON_SKILL = 1
  ::CR_DEFENSE_SKILL = 2
  ::CR_DODGE = 3
  ::CR_PARRY = 4
  ::CR_BLOCK = 5
  ::CR_HIT_MELEE = 6
  ::CR_HIT_RANGED = 7
  ::CR_HIT_SPELL = 8
  ::CR_CRIT_MELEE = 9
  ::CR_CRIT_RANGED = 10
  ::CR_CRIT_SPELL = 11
  ::CR_HIT_TAKEN_MELEE = 12
  ::CR_HIT_TAKEN_RANGED = 13
  ::CR_HIT_TAKEN_SPELL = 14
  ::COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15
  ::COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16   --formerly CR_CRIT_TAKEN_RANGED
  ::CR_CRIT_TAKEN_SPELL = 17
  ::CR_HASTE_MELEE = 18
  ::CR_HASTE_RANGED = 19
  ::CR_HASTE_SPELL = 20
  ::CR_WEAPON_SKILL_MAINHAND = 21
  ::CR_WEAPON_SKILL_OFFHAND = 22
  ::CR_WEAPON_SKILL_RANGED = 23
  ::CR_EXPERTISE = 24
  ::CR_ARMOR_PENETRATION = 25
  * The Combat Rating formula:
  ** Percentage = Rating / RatingBase / H
  *** Level 1 to 10:  H = 2/52
  *** Level 10 to 60: H = (level-8)/52
  *** Level 60 to 70: H = 82/(262-3*level)
  *** Level 70 to 80: H = (82/52)*(131/63)^((level-70)/10)
  ::{| class="wikitable"
  !RatingID!!RatingBase
  |-
  |CR_WEAPON_SKILL||2.5
  |-
  |CR_DEFENSE_SKILL||1.5
  |-
  |CR_DODGE||12
  |-
  |CR_PARRY||15
  |-
  |CR_BLOCK||5
  |-
  |CR_HIT_MELEE||10
  |-
  |CR_HIT_RANGED||10
  |-
  |CR_HIT_SPELL||8
  |-
  |CR_CRIT_MELEE||14
  |-
  |CR_CRIT_RANGED||14
  |-
  |CR_CRIT_SPELL||14
  |-
  |CR_HIT_TAKEN_MELEE||10
  |-
  |CR_HIT_TAKEN_RANGED||10
  |-
  |CR_HIT_TAKEN_SPELL||8
  |-
  |COMBAT_RATING_RESILIENCE_CRIT_TAKEN||25
  |-
  |COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN||25   --formerly CR_CRIT_TAKEN_RANGED
  |-
  |CR_CRIT_TAKEN_SPELL||25
  |-
  |CR_HASTE_MELEE||10
  |-
  |CR_HASTE_RANGED||10
  |-
  |CR_HASTE_SPELL||10
  |-
  |CR_WEAPON_SKILL_MAINHAND||2.5
  |-
  |CR_WEAPON_SKILL_OFFHAND||2.5
  |-
  |CR_WEAPON_SKILL_RANGED||2.5
  |-
  |CR_EXPERTISE||2.5
  |-
  |CR_ARMOR_PENETRATION||4.69512176513672
  |}
  * Parry Rating, Defense Rating, Block Rating and Resilience: Low-level players will now convert these ratings into their corresponding defensive stats at the same rate as level 34 players.
Arguments:
  number - Rating value
  number - Rating ID as defined in PaperDollFrame.lua
  [optional] number - Level used in calculations. Default: player's level
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; effect : number - Effect value
  ; effect name : string - Stat ID of converted effect, ex: "DODGE", "PARRY"
Example:
  StatLogic:GetEffectFromRating(10, CR_DODGE)
  StatLogic:GetEffectFromRating(10, CR_DODGE, 70)
-----------------------------------]]

--[[ Rating ID as definded in PaperDollFrame.lua
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
COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15; --renamed to resilience in 4.0.1   CR_CRIT_TAKEN_MELEE = 15;
COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16; -- renamed to resilience in 4.0.1   CR_CRIT_TAKEN_RANGED = 16;
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
CR_ARMOR_PENETRATION = 25;
CR_MASTERY = 26;
CR_PVP_POWER = 27
--]]

-- Level 60 rating base
local RatingBase
RatingBase = {
	[CR_WEAPON_SKILL] = 2.5,
	[CR_DEFENSE_SKILL] = 1.5, --TODO: Remove Defense, since defense was removed
	[CR_DODGE] = 20.7, --9/30/2012  The value was increased by 1.5.  (bounds: 20.61 - 20.76)
	[CR_PARRY] = 20.7, --9/30/2012  The value was increased by 1.5
	[CR_BLOCK] = 6.9,
	[CR_HIT_MELEE] = 8, --If H[85] is to be valid for melee, then L60 base rating needs to be 8.000000017.   Old value: 9.37931,  
	[CR_HIT_RANGED] = 8, --If H[85] is to be valid for hit ranged, then L60 base rating needs to be 8. Old value: 9.37931,
	[CR_HIT_SPELL] = 8,
	[CR_CRIT_MELEE] = 14, --confirmed Level 60 DK.   100->7.14%,138->9.86%  20120709  5.0.4  10016  
	[CR_CRIT_RANGED] = 14,
	[CR_CRIT_SPELL] = 14,
	[CR_HIT_TAKEN_MELEE] = 10, -- hit avoidance
	[CR_HIT_TAKEN_RANGED] = 10,
	[CR_HIT_TAKEN_SPELL] = 8,
	[COMBAT_RATING_RESILIENCE_CRIT_TAKEN] = 0, --resilience no longer reduces crits taken
	[COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN] = 7.96417713165283,
	[CR_CRIT_TAKEN_SPELL] = 28.75,
	[CR_HASTE_MELEE] = 10, -- changed in 2.2.   Confirmed 21120905 with level 60 paladin. 10
	[CR_HASTE_RANGED] = 10, -- changed in 2.2
	[CR_HASTE_SPELL] = 10, -- changed in 2.2
	[CR_WEAPON_SKILL_MAINHAND] = 2.5,
	[CR_WEAPON_SKILL_OFFHAND] = 2.5,
	[CR_WEAPON_SKILL_RANGED] = 2.5,
	[CR_EXPERTISE] = 8.00000, --8, to five decimal places.  Verified 20120905  5.0.4  16016. Level 60 Warrior  14 -> 1.75%
	[CR_ARMOR_PENETRATION] = 4.69512176513672 / 1.1, -- still manually calculated cause its still 4.69 in dbc
	[CR_MASTERY] = 14, --Verified 20120905  5.0.4  16016.
	[CR_PVP_POWER] = 14.69, --TODO: Figure out the base "PVP Power" for a level 60. Just because i typed in 14.69 doesn't mean it really is 14.69. It just means i like 69.
}
--if wowBuildNo < 13914 then
	--legacy values that nobody on earth uses anymore
	--RatingBase[COMBAT_RATING_RESILIENCE_CRIT_TAKEN] = 9.58333301544189;
	--RatingBase[COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN] = 9.58333301544189;
--end
local Level34Ratings
Level34Ratings = {
	[CR_DEFENSE_SKILL] = true, --TODO: Remove defense, since defense was removed
	[CR_DODGE] = true,
	[CR_PARRY] = true,
	[CR_BLOCK] = true,
	[COMBAT_RATING_RESILIENCE_CRIT_TAKEN] = true,
	[COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN] = true,
	[CR_CRIT_TAKEN_SPELL] = true,
}

-- 80-85 H data - Combat ratings adjustment factors; we start with level 60 values, then divide by these constants
local H = {
  [80] = 3.2789989471436,
  [81] = 4.3056015014648,
  [82] = 5.6539749145508,
  [83] = 7.4275451660156,
  [84] = 9.7527236938477,
  [85] = 12.8057174456713, --old value: 12.8057169037337  --1744 gives better residuals in mastery than 16903
  [86] = 16.1835749821923, --9/29/2012: Updated for Mists from real data
  [87] = 21.6065102063036, --TODO: power-law extension of 80-86. Figure out real level 87 value
  [88] = 28.2578178037443, --TODO: power-law extension of 80-86. Figure out real level 88 value
  [89] = 36.9566514631615, --TODO: power-law extension of 80-86. Figure out real level 89 value
  [90] = 48.3333177690963, --TODO: power-law extension of 80-86. Figure out real level 906 value
  [91] = 63.2121557034754, --TODO: power-law extension of 80-86.
  [92] = 82.6712672150821, --TODO: power-law extension of 80-86.
  [93] = 108.120635135557, --TODO: power-law extension of 80-86.
  [94] = 141.404288768221, --TODO: power-law extension of 80-86.
  [95] = 184.933919940236, --TODO: power-law extension of 80-86.
  [96] = 241.863631169775, --TODO: power-law extension of 80-86.
  [97] = 316.318477981397, --TODO: power-law extension of 80-86.
  [98] = 413.693365259341, --TODO: power-law extension of 80-86.
  [99] = 541.043955293887, --TODO: power-law extension of 80-86.
  [100] = 707.59791222792, --TODO: power-law extension of 80-86.
}
-- 80-90 H data for resilience - Combat ratings adjustment factors for resiliance; we start with level 60 combat rating values, then divide by these constants
--TODO: Add combat rating resilience adjustment factors for level 86-90
local H_Resilience = {
	[80] = 3.278999106, --80-85 data values are linear - is actual data?
	[81] = 4.092896174,
	[82] = 5.108814708,
	[83] = 6.376899732,
	[84] = 7.959742271,
	[85] = 9.935470247,
	[86] = 10.74056827, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[87] = 12.05916767, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[88] = 13.37776707, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[89] = 14.69636647, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[90] = 16.01496587, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
    [91] = 17.33356527, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[92] = 18.65216467, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[93] = 19.97076407, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[94] = 21.28936347, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[95] = 22.60796288, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[96] = 23.92656228, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[97] = 25.24516168, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[98] = 26.56376108, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[99] = 27.88236048, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
	[100] = 29.20095988, --Linear extension if 80-05 TODO: figure out adjustment factor for level 86
}

--[[This is a set of direct observation values, which are normally obtained in LibStatLogic
	by taking Level 60 Combat Rating conversion factors (RatingBase),
	and using a formula to convert up and down:
	
	Level 70-79:
	    combatEffect = rating/RatingBase/((82/52)*(131/63)^((level-70)/10));
	Level 60-69
	    combatEffect = rating/RatingBase/(82/(262-3*level));
	Level 10-59:
	    combatEffect = rating/RatingBase/((level-8)/52);
	Level 1-9
	    combatEffect = rating/RatingBase/(2/52);
	
	For people over Level 80, we use two sets of hard-coded scaling factors (H and H_Resilience)
	rather than trying to come up with a fancier formula
	But with Mists of Pandaria (5.0.4), the single "H" multiplier is not the same for Dodge and Parry.
	That means we have to change
			- H
			- H_Resilience
	to
			- H
			- H_Avoidance
			- H_Resilience

	Level 80-100:
		combatEffect = rating/RatingBase/H;
	Level 70-79:
	    combatEffect = rating/RatingBase/((82/52)*(131/63)^((level-70)/10));
	Level 60-69
	    combatEffect = rating/RatingBase/(82/(262-3*level));
	Level 10-59:
	    combatEffect = rating/RatingBase/((level-8)/52);
	Level 1-9
	    combatEffect = rating/RatingBase/(2/52);
		
Except i don't know all the intermediate Parry Rating -> Parry chance conversions set.
	So this table is born; to contain all the experimentally determined constants.
	Later we can either come up with a curve fitting formula, or a true underlying formula
--]]
local combatRatingBonus = {
	[60] = {
		[CR_MASTERY] = RatingBase[CR_MASTERY], --14.000
		[CR_EXPERTISE] = RatingBase[CR_EXPERTISE],
		[CR_DODGE] = RatingBase[CR_DODGE], --20.7
		[CR_PARRY] = RatingBase[CR_PARRY], --20.7
		--[CR_BLOCK] we don't include CR_BLOCK because Block Rating was removed from the game in 5.0.4 (nobody has block rating anymore)
	},
	[85] = {
		--9/20/2012: Dodge and Parry from a single regression of 760 data points. Intercept===0 (0 rating gives 0 bonus)
		[CR_PARRY] =       265.0783373415960, --Rating / Parry %  Varies by level.  Comes from a linear regression of Dodge Rating vs Dodge %. Has a zero intercept.
		[CR_DODGE] =       265.0783373415960, --Rating / Dodge %  Varies by level. Comes from a linear regression of Dodge Rating vs Dodge %. Has a zero intercept.
		[CR_MASTERY] =     179.2800442393960, --Rating / Mastery %   updated 9/22/2012
		[CR_CRIT_MELEE] =  179.2800411044490,
			[CR_CRIT_SPELL] =  179.2800411044490,
			[CR_CRIT_RANGED] =  179.2800411044490,
		[CR_HASTE_MELEE] = 128.057165021941,
			[CR_HASTE_SPELL] = 128.057165021941,
			[CR_HASTE_RANGED] = 128.057165021941,
		[CR_EXPERTISE] =   102.445737393460, --102.4 Rating / Expertise % (i.e. 0.00976126508962818 Expertise% per Rating)
		[CR_HIT_MELEE] =   102.4457395653704, --H[85]*8 = 12.8057174456713*8
			[CR_HIT_SPELL] =   102.4457395653704, --H[85]*8 = 12.8057174456713*8
			[CR_HIT_RANGED] =  102.4457395653704, --H[85]*8 = 12.8057174456713*8
	},
	[86] = {
		--comes from linear regressions of Rating -> Bonus
		[CR_PARRY] =       335.000000, --Parry Rating / Parry Chance %
		[CR_DODGE] =       335.000000, --Dodge Rating / Dodge Chance %
		[CR_MASTERY] =     228.000000, --Mastery Rating / Mastery
		[CR_CRIT_MELEE] =  228.000000, --Crit Rating / Crit Chance %
			[CR_CRIT_SPELL] = 228, 
			[CR_CRIT_RANGED] = 228, 
		[CR_HASTE_MELEE] = 162.000000,
			[CR_HASTE_SPELL] = 162,
			[CR_HASTE_RANGED] = 162,
		[CR_EXPERTISE] =   130.000000,
		[CR_HIT_MELEE] =   130.000000, --Hit Rating / Hit Chance %
			[CR_HIT_SPELL] =   130, --Hit Rating / Hit Chance %
			[CR_HIT_RANGED] =  130, --Hit Rating / Hit Chance %
	},
	[87] = {
		--comes from linear regressions of Rating -> Bonus
		[CR_PARRY] =       430.00000, --Parry Rating / Parry Chance %
		[CR_DODGE] =       430.00000, --Dodge Rating / Dodge Chance %
		[CR_MASTERY] =     290.00000, --Mastery Rating / Mastery
		[CR_CRIT_MELEE] =  290.00000, --Crit Rating / Crit Chance %
			[CR_CRIT_SPELL] = 290, 
			[CR_CRIT_RANGED] = 290, 
		[CR_HASTE_MELEE] = 208.000000,
			[CR_HASTE_SPELL] = 208,
			[CR_HASTE_RANGED] = 208,
		[CR_EXPERTISE] =   166.000000,
		[CR_HIT_MELEE] =   166.000000, --Hit Rating / Hit Chance %
			[CR_HIT_SPELL] =   166, --Hit Rating / Hit Chance %
			[CR_HIT_RANGED] =  166, --Hit Rating / Hit Chance %
	},
	[88] = {
		--comes from linear regressions of Rating -> Bonus
		[CR_PARRY] =       545.00000, --Parry Rating / Parry Chance %
		[CR_DODGE] =       545.00000, --Dodge Rating / Dodge Chance %
		[CR_MASTERY] =     370.00000, --Mastery Rating / Mastery
		[CR_CRIT_MELEE] =  370.00000, --Crit Rating / Crit Chance %
			[CR_CRIT_SPELL] = 370, 
			[CR_CRIT_RANGED] = 370, 
		[CR_HASTE_MELEE] = 264.00000,
			[CR_HASTE_SPELL] = 264,
			[CR_HASTE_RANGED] = 264,
		[CR_EXPERTISE] =   211.00000,
		[CR_HIT_MELEE] =   211.00000, --Hit Rating / Hit Chance %
			[CR_HIT_SPELL] =   211, --Hit Rating / Hit Chance %
			[CR_HIT_RANGED] =  211, --Hit Rating / Hit Chance %
	},
	[89] = {
		--comes from linear regressions of Rating -> Bonus
		[CR_PARRY] =       700.00000, --Parry Rating / Parry Chance %
		[CR_DODGE] =       700.00000, --Dodge Rating / Dodge Chance %
		[CR_MASTERY] =     470.00000, --Mastery Rating / Mastery
		[CR_CRIT_MELEE] =  470.00000, --Crit Rating / Crit Chance %
			[CR_CRIT_SPELL] = 470, 
			[CR_CRIT_RANGED] = 470, 
		[CR_HASTE_MELEE] = 336.00000,
			[CR_HASTE_SPELL] = 336,
			[CR_HASTE_RANGED] = 336,
		[CR_EXPERTISE] =   269.00000,
		[CR_HIT_MELEE] =   269.00000, --Hit Rating / Hit Chance %
			[CR_HIT_SPELL] =   269, --Hit Rating / Hit Chance %
			[CR_HIT_RANGED] =  269, --Hit Rating / Hit Chance %
	},	
	[90] = {
		--comes from linear regressions of Rating -> Bonus
		[CR_PARRY] =       885.00000, --Parry Rating / Parry Chance %
		[CR_DODGE] =       885.00000, --Dodge Rating / Dodge Chance %
		[CR_MASTERY] =     600.00000, --Mastery Rating / Mastery   10/6/2012
		[CR_CRIT_MELEE] =  600.00000, --Crit Rating / Crit Chance %
			[CR_CRIT_SPELL] = 600,   --10/6/2012  From a level 90 hunter, but i assume it's the same per class
			[CR_CRIT_RANGED] = 600, 
		[CR_HASTE_MELEE] = 425, --425, but not enough data for accurate value
			[CR_HASTE_SPELL] = 425,
			[CR_HASTE_RANGED] = 425,
		[CR_EXPERTISE] =   340.00000,
		[CR_HIT_MELEE] =   340.00000, --Hit Rating / Hit Chance %
			[CR_HIT_SPELL] =   340.00000, --Hit Rating / Hit Chance %
			[CR_HIT_RANGED] =  340.00000, --Hit Rating / Hit Chance %
	},

}

--[[
3.1.0
- Armor Penetration Rating: All classes now receive 25% more benefit from Armor Penetration Rating.
--]]

-- Formula reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
-- Percentage = Rating / RatingBase / H
--
-- Level 1 to 10:  H = 2/52
-- Level 10 to 60: H = (level-8)/52
-- Level 60 to 70: H = 82/(262-3*level)
-- Level 70 to 80: H = (82/52)*(131/63)^((level-70)/10)
--
--  Parry Rating, Defense Rating, Block Rating and Resilience: Low-level players
--   will now convert these ratings into their corresponding defensive
--   stats at the same rate as level 34 players.
--  Dodge Rating too

--- Calculates a combat rating's effect on its corresponding stat.
-- For a given combat rating value, this function will calculate the resulting effect on the
-- corresponding combat stat. 
-- @usage GetEffectFromRating(rating, id, [level, [class]])
-- @param rating (number) Combat rating value, e.g. 871
-- @param id (number) The Combat Rating ID to calculate the stat effect of. e.g. CR_PARRY
--    Can be one of the following values (defined in FrameXML\PaperDollFrame.lua):
--       CR_WEAPON_SKILL = 1;
--       CR_DEFENSE_SKILL = 2;
--       CR_DODGE = 3;
--       CR_PARRY = 4;
--       CR_BLOCK = 5;
--       CR_HIT_MELEE = 6;
--       CR_HIT_RANGED = 7;
--       CR_HIT_SPELL = 8;
--       CR_CRIT_MELEE = 9;
--       CR_CRIT_RANGED = 10;
--       CR_CRIT_SPELL = 11;
--       CR_HIT_TAKEN_MELEE = 12;
--       CR_HIT_TAKEN_RANGED = 13;
--       CR_HIT_TAKEN_SPELL = 14;
--       COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15;
--       COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16;
--       CR_CRIT_TAKEN_SPELL = 17;
--       CR_HASTE_MELEE = 18;
--       CR_HASTE_RANGED = 19;
--       CR_HASTE_SPELL = 20;
--       CR_WEAPON_SKILL_MAINHAND = 21;
--       CR_WEAPON_SKILL_OFFHAND = 22;
--       CR_WEAPON_SKILL_RANGED = 23;
--       CR_EXPERTISE = 24;
--       CR_ARMOR_PENETRATION = 25;
--       CR_MASTERY = 26;
--       CR_PVP_POWER = 27;
-- @param level [optional] number - The level of the player being calculated. e.g. CR_PARRY
--        If omitted, the player's current level will be used, i.e. UnitLevel("player")
-- @param class [optional] number - A constant indicating the class of the player being calculated.
--        If omitted, the player's current class will be used. Can be one of the following values:
--            WARRIOR = 1
--            PALADIN = 2
--            HUNTER = 3
--            ROGUE = 4
--            PRIEST = 5
--            DEATHKNIGHT = 6
--            SHAMAN = 7
--            MAGE = 8
--            WARLOCK = 9
--            MONK = 10
--            DRUID = 11
-- @return Returns effect, effectName
--     effect : number - Effect value as a percentage e.g. 6.47162208
--     effectName : string - Stat ID of converted effect, e.g. "PARRY"
--
-- Example - Get the effect of 871 Parry Rating on Parry for a level 84 Paladin:
--        6.47162208, "PARRY" = GetEffectFromRating(871, CR_PARRY, 84, 2)
function StatLogic:GetEffectFromRating(rating, id, level, class)
	self:argCheck(rating, 1, "number", "string");
	self:argCheck(id, 2, "number", "string");
	self:argCheck(level, 3, "nil", "number");
	self:argCheck(class, 4, "nil", "number", "string");

	-- if id is stringID then convert to numberID
	if type(id) == "string" and RatingNameToID[id] then
		id = RatingNameToID[id]
	end
  
	-- check for invalid input
	if type(rating) ~= "number" or (id < 1) or (id > CR_MAX) then return 0 end
  
	-- defaults to player level if not given
	level = level or UnitLevel("player")
  
	-- argCheck for invalid input
	self:argCheck(class, 5, "nil", "string", "number")
  
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
	    class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
	    class = ClassNameToID[playerClass]
	end
  
	--2.4.3  Parry Rating and Block Rating: Low-level players
	--   will now convert these ratings into their corresponding defensive
	--   stats at the same rate as level 34 players.
	if level < 34 and Level34Ratings[id] then
	    level = 34
	end
  
	--debugPrint(string.format("rating=%d, id=%d", rating, id));
	--debugPrint(string.format("RatingBase=%d", RatingBase[id]));
	--debugPrint(string.format("H[level %d]=%d", H[level]));
  
	local combatUnitRatingBase = RatingBase[id];
	
	--Resilience no longer affects crits taken; so the rating base is zero.
	--But i don't want the division by zero.
	if ((combatUnitRatingBase == 0) and (id == COMBAT_RATING_RESILIENCE_CRIT_TAKEN)) then
		return 0, RatingIDToConvertedStat[id]; --e.g. 0, "adslfkjasd;lfjas"
	end;
	
	assert(combatUnitRatingBase ~= nil, string.format('RatingBase[id=%d] is nil', id));
	assert(combatUnitRatingBase ~= 0, string.format('RatingBase[id=%d] is 0', id));	
	
	local ratingPerBonus = nil;
	
	if (level > 85) then
		if (combatRatingBonus[level]) then
			ratingPerBonus = combatRatingBonus[level][id];
		end;
		
		if (not ratingPerBonus) then
			local hvalue;
			if id == COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN then --16 = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN
				hvalue = H_Resilience[level];
				assert(hvalue ~= nil, string.format("H_Resilience[level=%d] is nil", level));
				assert(hvalue ~= 0, string.format("H_Resilience[level=%d] is zero", level));
			else
				hvalue = H[level];
				assert(hvalue ~= nil, string.format("H[level=%d] is nil", level));
				assert(hvalue ~= 0, string.format("H[level=%d] is zero", level));
			end

			--print(string.format("combatUnitRatingBase[%s] = %s", RatingNameToID[id], combatUnitRatingBase));
			--print(string.format("hvalue = %s", hvalue));
			ratingPerBonus = combatUnitRatingBase*hvalue;
		end;
		
		--print(string.format("ratingPerBonus[%s] = %s", RatingNameToID[id], ratingPerBonus));
	elseif (level >= 80) then
		local hvalue;
	    if id == COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN then --16 = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN
			hvalue = H_Resilience[level];
			assert(hvalue ~= nil, string.format("H_Resilience[level=%d] is nil", level));
			assert(hvalue ~= 0, string.format("H_Resilience[level=%d] is zero", level));
		else
			hvalue = H[level];
			assert(hvalue ~= nil, string.format("H[level=%d] is nil", level));
			assert(hvalue ~= 0, string.format("H[level=%d] is zero", level));
		end

		ratingPerBonus = combatUnitRatingBase*hvalue;
	elseif level >= 70 then
	    ratingPerBonus = combatUnitRatingBase*((82/52)*(131/63)^((level-70)/10));
	elseif level >= 60 then
	    ratingPerBonus = combatUnitRatingBase*(82/(262-3*level));
	elseif level >= 10 then
	    ratingPerBonus = combatUnitRatingBase*((level-8)/52);
	else
	    ratingPerBonus = combatUnitRatingBase*(2/52);
	end
	
	local combatEffect = rating / ratingPerBonus;
	
	return combatEffect, RatingIDToConvertedStat[id]; --e.g. 6.47162208, "PARRY"
end


--[[---------------------------------
  :GetAPPerStr([class])
-------------------------------------
Notes:
  * Returns the attack power per strength for given class.
  * Player level does not effect attack power per strength.
Arguments:
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; ap : number - Attack power per strength
  ; statid : string - "AP"
Example:
  local ap, statid = StatLogic:GetAPPerStr()
  local ap, statid = StatLogic:GetAPPerStr("WARRIOR")
-----------------------------------]]

local APPerStr = {
	2, --WARRIOR
	2, --PALADIN
	1, --HUNTER
	1, --ROGUE
	2, --PRIEST
	2, --DEATHKNIGHT
	1, --SHAMAN
	2, --MAGE
	2, --WARLOCK
	1, --MONK   TODO: 20120811: Figure out Monk's Attack Power per Strength. (Does AP/Str even vary by class anymore?)
	1, --DRUID
}
if wowBuildNo < 14333 then --4.2.0
	APPerStr[ClassNameToID["DRUID"]] = 1; -- pre 4.2.0 druid's were 2 Attack Power per Strength
end

function StatLogic:GetAPPerStr(class)
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		-- if class is invalid input, default to player class
		class = ClassNameToID[playerClass]
	end
	
	return APPerStr[class], "AP"
end


--[[---------------------------------
  :GetAPFromStr(str, [class])
-------------------------------------
Description:
  * Calculates the attack power from strength for given class.
Arguments:
  number - Strength
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; ap : number - Attack power
  ; statid : string - "AP"
Examples:
  local ap = StatLogic:GetAPFromStr(1) -- GetAPPerStr
  local ap = StatLogic:GetAPFromStr(10)
  local ap = StatLogic:GetAPFromStr(10, "WARRIOR")
-----------------------------------]]
function StatLogic:GetAPFromStr(str, class)
	-- argCheck for invalid input
	self:argCheck(str, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 11 then
		class = ClassNameToID[playerClass]
	end
	
	-- Calculate
	return str * APPerStr[class], "AP"
end


--[[---------------------------------
  :GetAPPerAgi([class])
-------------------------------------
Notes:
  * Gets the attack power per agility for given class.
  * Player level does not effect attack power per agility.
  * Will check for Cat Form.
Arguments:
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; ap : number - Attack power per agility
  ; statid : string - "AP"
Example:
  local apPerAgi = StatLogic:GetAPPerAgi()
  local apPerAgi = StatLogic:GetAPPerAgi("ROGUE")
-----------------------------------]]

local APPerAgi = {
	0, --WARRIOR
	0, --PALADIN
	1, --HUNTER
	2, --ROGUE
	0, --PRIEST
	0, --DEATHKNIGHT
	2, --SHAMAN
	0, --MAGE
	0, --WARLOCK
	2, --MONK  20121108: "I did some informal testing on my monk (lvl90), and it does appear that 1 agil = 2 attack pwr, at least for WindWalker." 20121107: "likely be changed to 2 to fall in like with other classes"  20120811: Figure out Monk's AP per AGI (do they even have any? Does AP/Agi ever vary by class anymore?)
	0, --DRUID
}

function StatLogic:GetAPPerAgi(class)
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
		-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
  
	-- Check druid cat/bear form
	--11 = DRUID = ClassNameToID["DRUID"]
	if (class == 11) and (PlayerHasAura((GetSpellInfo(768))) or PlayerHasAura((GetSpellInfo(5487)))) then
		if toc >= 40000 then
			return 2
		else
			return 1
		end
	end
	return APPerAgi[class], "AP"
end


--[[---------------------------------
  :GetAPFromAgi(agi, [class])
-------------------------------------
Notes:
  * Calculates the attack power from agility for given class.
Arguments:
  number - Agility
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; ap : number - Attack power
  ; statid : string - "AP"
Example:
  local ap = StatLogic:GetAPFromAgi(1) -- GetAPPerAgi
  local ap = StatLogic:GetAPFromAgi(10)
  local ap = StatLogic:GetAPFromAgi(10, "WARRIOR")
-----------------------------------]]

function StatLogic:GetAPFromAgi(agi, class)
	-- argCheck for invalid input
	self:argCheck(agi, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
		-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- Calculate
	return agi * APPerAgi[class], "AP"
end


--[[---------------------------------
  :GetRAPPerAgi([class])
-------------------------------------
Notes:
  * Gets the ranged attack power per agility for given class.
  * Player level does not effect ranged attack power per agility.
Arguments:
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; rap : number - Ranged attack power per agility
  ; statid : string - "RANGED_AP"
Example:
  local rapPerAgi = StatLogic:GetRAPPerAgi()
  local rapPerAgi = StatLogic:GetRAPPerAgi("HUNTER")
-----------------------------------]]

local RAPPerAgi = {
	1,	--Warrior
	0,	--Paladin
	2,	--Hunter
	1,	--Rogue
	0,	--Priest
	0,	--Death Knight
	0,	--Shaman
	0,	--Mage
	0,	--Warlock
	0,	--Monk
	0,	--Druid
}

function StatLogic:GetRAPPerAgi(class)
  -- argCheck for invalid input
  self:argCheck(class, 2, "nil", "string", "number")
  -- if class is a class string, convert to class id
  if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
    class = ClassNameToID[strupper(class)]
  -- if class is invalid input, default to player class
  elseif type(class) ~= "number" or class < 1 or class > 10 then
    class = ClassNameToID[playerClass]
  end
  return RAPPerAgi[class], "RANGED_AP"
end


--[[---------------------------------
  :GetRAPFromAgi(agi, [class])
-------------------------------------
Notes:
  * Calculates the ranged attack power from agility for given class.
Arguments:
  number - Agility
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; rap : number - Ranged attack power
  ; statid : string - "RANGED_AP"
Example:
  local rap = StatLogic:GetRAPFromAgi(1) -- GetRAPPerAgi
  local rap = StatLogic:GetRAPFromAgi(10)
  local rap = StatLogic:GetRAPFromAgi(10, "WARRIOR")
-----------------------------------]]

function StatLogic:GetRAPFromAgi(agi, class)
  -- argCheck for invalid input
  self:argCheck(agi, 2, "number")
  self:argCheck(class, 3, "nil", "string", "number")
  -- if class is a class string, convert to class id
  if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
    class = ClassNameToID[strupper(class)]
  -- if class is invalid input, default to player class
  elseif type(class) ~= "number" or class < 1 or class > 10 then
    class = ClassNameToID[playerClass]
  end
  -- Calculate
  return agi * RAPPerAgi[class], "RANGED_AP"
end


--[[---------------------------------
  :GetBaseDodge([class])
-------------------------------------
Notes:
  * BaseDodge values derived by Whitetooth (hotdogee [at] gmail [dot] com)
  * Gets the base dodge percentage for given class.
  * Base dodge is the amount of dodge you have with 0 Agility, independent of level.
Arguments:
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; dodge : number - Base dodge in percentages
  ; statid : string - "DODGE"
Example:
  local baseDodge = StatLogic:GetBaseDodge()
  local baseDodge = StatLogic:GetBaseDodge("WARRIOR")
-----------------------------------]]
-- local BaseDodge declared at StatLogic:GetDodgeChanceBeforeDR()
-- Numbers derived by Whitetooth (hotdogee [at] gmail [dot] com)
BaseDodge = {
	5,					--Warrior
	3,					--Paladin  //It's 3% for paladin. Protection passive Sanctuary adds 2%, giving 5% total
	-5.4499989748001,	--Hunter
	-0.590,				--Rogue
	3.1830,				--Priest
	5,					--Death Knight
	1.6750,				--Shaman
	3.4575,				--Mage
	2.0350,				--Warlock
	0,					--Monk  TODO: Get real base value for Monk (i only put zero because it's not unreasonable)
	3,					--Druid. 9/26/2012  Base Dodge Chance of 3%, with +0.3489% from base agility
}

function StatLogic:GetBaseDodge(class)
	-- argCheck for invalid input
	self:argCheck(class, 2, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
		-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	return BaseDodge[class], "DODGE"
end

--[[---------------------------------
  :GetDodgePerAgi()
-------------------------------------
Arguments:
  None
Returns:
  ; dodge : number - Dodge percentage per agility
  ; statid : string - "DODGE"
Notes:
  * Formula by Whitetooth (hotdogee [at] gmail [dot] com)
  * Calculates the dodge percentage per agility for your current class and level.
  * Only works for your currect class and current level, does not support class and level args.
  * Calculations got a bit more complicated with the introduction of the avoidance DR in WotLK, these are the values we know or can be calculated easily:
  ** D'=Total Dodge% after DR
  ** D_r=Dodge from Defense and Dodge Rating before DR
  ** D_b=Dodge unaffected by DR (BaseDodge + Dodge from talent/buffs + Lower then normal defense correction)
  ** A=Total Agility
  ** A_b=Base Agility (This is what you have with no gear on)
  ** A_g=Total Agility - Base Agility
  ** Let d be the Dodge/Agi value we are going to calculate.

  x' =    x
        -------
		x/c + k

  # x'=D'-D_b-A_b*d
  # x=A_g*d+D_r

  # 1/(D'-D_b-A_b*d)=1/C_d+k/(A_g*d+D_r)=(A_g*d+D_r+C_d*k)/(C_d*A_g*d+C_d*D_r)

  # C_d*A_g*d+C_d*D_r=[(D'-D_b)-A_b*d]*[Ag*d+(D_r+C_d*k)]

  # After rearranging the terms, we get an equation of type a*d^2+b*d+c where
  # a=-A_g*A_b
  # b=A_g(D'-D_b)-A_b(D_r+C_d*k)-C_dA_g
  # c=(D'-D_b)(D_r+C_d*k)-C_d*D_r
  ** Dodge/Agi=(-b-(b^2-4ac)^0.5)/(2a)
Example:
  local dodge, statid = StatLogic:GetDodgePerAgi()
-----------------------------------]]

local DodgePerAgiStatic = {
	1/10000,	--"WARRIOR" 1         10000 Agility per Dodge
	1/10000,	--"PALADIN" 2         10000 Agility per Dodge
	0.0133266,	--"HUNTER" 3
	0.0240537,	--"ROGUE" 4
	0.0192366,	--"PRIEST" 5
	1/10000,	--"DEATHKNIGHT" 6     10000 Agility per Dodge
	0.0192366,	--"SHAMAN" 7
	0.0195253,	--"MAGE" 8
	0.0192366,	--"WARLOCK" 9
	0,			--"MONK" 10: TODO: Get *real* dodge/agi static (i just put in zero because it's not unreasonable)
	1/299.25,	--"DRUID" 11  *l85 Mists Valuse
}


local ZeroDodgePerAgiClasses = {
	["WARRIOR"] = false,
	["PALADIN"] = false,
	["DEATHKNIGHT"] = false,
}

local ModAgiClasses = {
	["DRUID"] = true,
	["HUNTER"] = true,
	["ROGUE"] = true,
	["SHAMAN"] = true,
}
local BoK = GetSpellInfo(20217);

function StatLogic:GetDodgePerAgi()
	local level = UnitLevel("player");
	local class = ClassNameToID[playerClass];
	if level >= 80 and DodgePerAgiStatic[class] then
		return DodgePerAgiStatic[class], "DODGE";
	end
	if ZeroDodgePerAgiClasses[playerClass] then
		return 0, "DODGE";
	end

	-- Collect data
	local D_dr = GetDodgeChance();
	local dodgeFromDodgeRating = GetCombatRatingBonus(CR_DODGE);
	--local baseDefense, modDefense = level * 5, 0
	--local dodgeFromModDefense = modDefense * 0.04
	local D_r = dodgeFromDodgeRating; -- + dodgeFromModDefense
	local D_b = BaseDodge[class] + self:GetStatMod("ADD_DODGE"); -- + (baseDefense - level * 5) * 0.04
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 2) -- 2 = Agility

	-- Talents that modify AGI will not add to posBuff, so we need to calculate baseAgi
	-- But Kings added Agi will add to posBuff, so we need to check for Kings
	local modAgi = 1
	if ModAgiClasses[playerClass] then
		modAgi = self:GetStatMod("MOD_AGI", nil, nil, "CLASS")
	end
	local A = effectiveStat
	local A_b = ceil((stat - posBuff - negBuff) / modAgi)
	local A_g = A - A_b
	local C = C_d[class]
	local k = K[class]
	-- Solve a*x^2+b*x+c
	local a = -A_g*A_b
	local b = A_g*(D_dr-D_b)-A_b*(D_r+C*k)-C*A_g
	local c = (D_dr-D_b)*(D_r+C*k)-C*D_r
	--RatingBuster:Print(a, b, c, D_b, D_r, A_b, A_g, C, k)
	local dodgePerAgi = (-b-(b^2-4*a*c)^0.5)/(2*a)
	if a == 0 then
		dodgePerAgi = -c / b
	end
	--return dodgePerAgi
	--return floor(dodgePerAgi*10000+0.5)/10000, "DODGE"
	return dodgePerAgi, "DODGE"
end

--[[---------------------------------
  :GetDodgeFromAgi(agi)
-------------------------------------
Notes:
  * Calculates the dodge chance from agility for your current class and level.
  * Only works for your currect class and current level, does not support class and level args.
Arguments:
  number - Agility
Returns:
  ; dodge : number - Dodge percentage
  ; statid : string - "DODGE"
Example:
  local dodge = StatLogic:GetDodgeFromAgi(1) -- GetDodgePerAgi
  local dodge = StatLogic:GetDodgeFromAgi(10)
-----------------------------------]]

function StatLogic:GetDodgeFromAgi(agi)
  -- argCheck for invalid input
  self:argCheck(agi, 2, "number")
  -- Calculate
  return agi * self:GetDodgePerAgi(), "DODGE"
end


--[[---------------------------------
  :GetCritFromAgi(agi, [class], [level])
-------------------------------------
Notes:
  * CritPerAgi values reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
  * Calculates the melee/ranged crit chance from agility for given class and level.
Arguments:
  number - Agility
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
  [optional] number - Level used in calculations. Default: player's level
Returns:
  ; crit : number - Melee/ranged crit percentage
  ; statid : string - "MELEE_CRIT"
Example:
  local crit = StatLogic:GetCritFromAgi(1) -- GetCritPerAgi
  local crit = StatLogic:GetCritFromAgi(10)
  local crit = StatLogic:GetCritFromAgi(10, "WARRIOR")
  local crit = StatLogic:GetCritFromAgi(10, nil, 70)
  local crit = StatLogic:GetCritFromAgi(10, "WARRIOR", 70)
-----------------------------------]]

-- Numbers reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
local CritPerAgi = {
	--TODO: Add monk values; since i'm too sure they're not zero
	--10/6/2012: L90 Hunter Agility per Crit Chance: 1259.51809
	--       WARRIOR,    PALADIN,    HUNTER,      ROGUE,      PRIEST,     DEATHKNIGHT, SHAMAN,     MAGE,       WARLOCK,    MONK,       DRUID
	[1] =	{    4.0000002,    4.5998160,      3.5211268,     2.2340927, 10.9679188,4.0000002,9.6246391,12.9366106,8.4104289,4.5998160,7.9223609, },
	[2] =	{    4.2000044,    4.8297979,      3.5281581,     2.3312306, 10.9679188,4.2000044,9.6246391,12.9366106,8.4104289,4.8297979,7.9223609, },
	[3] =	{    4.2000044,    4.8297979,      3.6890294,     2.4283632, 10.9679188,4.2000044,10.1058701,12.9366106,8.8309578,4.8297979,8.3184987, },
	[4] =	{    4.3999947,    5.0598067,      3.9527252,     2.6226343, 11.5163192,4.3999947,10.1058701,13.5834499,8.8309578,5.0598067,8.3184987, },
	[5] =	{    4.6000067,    5.0598067,      4.1151418,     2.7197637, 11.5163192,4.6000067,10.5871081,13.5834499,8.8309578,5.0598067,8.7145969, },
	[6] =	{    4.8000079,    5.2898018,      4.2783309,     2.8169014, 11.5163192,4.8000079,10.5871081,13.5834499,9.2514640,5.2898018,8.7145969, },
	[7] =	{    4.8000079,    5.2898018,      4.4423319,     3.0111683, 11.5163192,4.8000079,10.5871081,13.5834499,9.2514640,5.2898018,9.1107042, },
	[8] =	{    4.9999998,    5.5197691,      4.6071274,     3.1083026, 12.0647054,4.9999998,11.0683381,13.5834499,9.2514640,5.5197691,9.1107042, },
	[9] =	{    5.1999917,    5.5197691,      4.8747910,     3.2054365, 12.0647054,5.1999917,11.0683381,13.5834499,9.6720217,5.5197691,9.5068791, },
	[10] =	{    5.1999917,    5.7497700,      5.0412373,     3.3997068, 12.0647054,5.1999917,11.5495713,14.2302772,9.6720217,5.7497700,10.2990642, },
	[11] =	{    5.4000054,    5.7497700,      5.4126320,     3.7882519, 12.0647054,5.4000054,11.5495713,14.2302772,10.0925181,5.7497700,10.6951872, },
	[12] =	{    5.6000134,    5.9797522,      5.9889926,     4.1767778, 12.6131080,5.6000134,12.0307988,14.2302772,10.0925181,5.9797522,10.6951872, },
	[13] =	{    5.9999880,    6.4397306,      6.4641659,     4.6624611, 12.6131080,5.9999880,12.0307988,14.2302772,10.0925181,6.4397306,11.0913070, },
	[14] =	{    6.2000120,    6.4397306,      6.9402032,     5.0509897, 12.6131080,6.2000120,12.5120272,14.2302772,10.4289533,6.4397306,11.0913070, },
	[15] =	{    6.4000000,    6.8997399,      7.5191927,     5.6338028, 12.6131080,6.4000000,12.9932565,14.8771003,10.5987218,6.8997399,11.8835413, },
	[16] =	{    6.6000066,    6.8997399,      7.8949031,     6.0223550, 13.1614968,6.6000066,13.4744921,14.8771003,10.7706972,6.8997399,11.8835413, },
	[17] =	{    6.7999918,    7.1297186,      8.3736665,     6.4108733, 13.1614968,6.7999918,13.4744921,14.8771003,10.9449066,7.1297186,12.2796569, },
	[18] =	{    7.1999942,    7.5896720,      8.9553583,     6.8965517, 13.1614968,7.1999942,13.9557213,14.8771003,11.1213799,7.5896720,12.6757814, },
	[19] =	{    7.4000074,    7.5896720,      9.4359207,     7.3821986, 13.7098985,7.4000074,13.9557213,14.8771003,11.3001501,7.5896720,12.6757814, },
	[20] =	{    7.8000078,    8.0496502,     10.0194578,     7.8678825, 13.7098985,7.8000078,14.9181812,15.5239247,11.4812408,8.0496502,14.2602496, },
	[21] =  {    7.8000078,    8.2796536,     10.3998428,     8.3535908, 13.7098985,7.8000078,14.9181812,15.5239247,11.6646778,8.2796536,14.2602496, },
	[22] =  {    8.0000000,    8.2796536,     10.9853291,     8.7420993, 13.7098985,8.0000000,15.3994225,15.5239247,11.8505176,8.2796536,14.6563740, },
	[23] =  {    8.3999731,    8.7396544,     11.4697182,     9.2278163, 14.2582976,8.3999731,15.3994225,15.5239247,12.0387648,8.7396544,15.0524880, },
	[24] =  {    8.6000052,    8.9696557,     12.0571557,     9.6163093, 14.2582976,8.6000052,15.8806537,16.1707633,12.2294539,8.9696557,15.0524880, },
	[25] =  {    9.0000090,    9.1996320,     12.5435418,    10.1991278, 14.2582976,9.0000090,16.3618990,16.1707633,12.4226226,9.1996320,15.8447217, },
	[26] =  {    9.1999706,    9.4296033,     13.0309459,    10.6847995, 14.8066986,9.1999706,16.8431265,16.1707633,12.6183125,9.4296033,15.8447217, },
	[27] =  {    9.3999981,    9.6595958,     13.6214358,    11.0733387, 14.8066986,9.3999981,16.8431265,16.1707633,12.8165364,9.6595958,16.2408321, },
	[28] =  {    9.7999824,    9.8896317,     14.1109203,    11.5590099, 14.8066986,9.7999824,17.3243570,16.1707633,13.0173417,9.8896317,16.6369697, },
	[29] =  {   10.0000000,    10.1195934,    14.7035038,    12.0446809, 15.3550864,10.0000000,17.3243570,16.8176047,13.2207629,10.1195934,16.6369697, },
	[30] =  {   10.4000050,    10.5795812,    15.2971627,    12.6274903, 15.3550864,10.4000050,18.2868178,16.8176047,13.4268198,10.5795812,18.2214415, },
	[31] =  {   10.6000025,    10.8095721,    15.6877756,    13.0160201, 15.3550864,10.6000025,18.2868178,16.8176047,13.6355517,10.8095721,18.6175362, },
	[32] =  {   10.7999991,    10.8095721,    16.2836216,    13.5017086, 15.9034849,10.7999991,18.7680290,16.8176047,13.8470017,10.8095721,18.6175362, },
	[33] =  {   11.2000018,    11.2695484,    16.8805716,    13.9873638, 15.9034849,11.2000018,19.2492782,17.4644119,14.0612169,11.2695484,19.0136841, },
	[34] =  {   11.3999998,    11.4995400,    17.3765871,    14.4730367, 15.9034849,11.3999998,19.2492782,17.4644119,14.2781876,11.4995400,19.4097872, },
	[35] =  {   11.7999948,    11.9595194,    17.9758153,    15.0558421, 16.4518873,11.7999948,20.2117382,17.4644119,14.4980065,11.9595194,19.8059022, },
	[36] =  {   12.0000048,    12.1895177,    18.4741464,    15.5415371, 16.4518873,12.0000048,20.6929660,18.1112502,14.7206680,12.1895177,20.2020202, },
	[37] =  {   12.2000020,    12.1895177,    19.0756694,    15.9300607, 16.4518873,12.2000020,20.6929660,18.1112502,14.9462309,12.1895177,20.5981285, },
	[38] =  {   12.5999967,    12.6495013,    19.6784153,    16.4157250, 17.0002686,12.5999967,21.1741937,18.1112502,15.1747141,12.6495013,20.5981285, },
	[39] =  {   12.8000000,    12.8794777,    20.2823300,    16.9013989, 17.0002686,12.8000000,21.1741937,18.1112502,15.4061603,12.8794777,20.9942455, },
	[40] =  {   13.1999958,    13.3394695,    20.7854402,    17.4842292, 17.0002686,13.1999958,22.1366763,18.7581012,15.6406406,13.3394695,22.5787150, },
	[41] =  {   13.6000022,    13.5694600,    21.2897773,    17.9699040, 17.5486624,13.6000022,22.6178844,18.7581012,15.8781574,13.5694600,22.9748265, },
	[42] =  {   13.7999939,    13.5694600,    21.8974106,    18.4555645, 17.5486624,13.7999939,22.6178844,18.7581012,16.1187630,13.5694600,22.9748265, },
	[43] =  {   14.2000071,    14.0294366,    22.5063018,    18.9412235, 18.0970581,14.2000071,23.0991160,18.7581012,16.3624880,14.0294366,23.3709840, },
	[44] =  {   14.4000092,    14.2594362,    23.1164700,    19.5240429, 18.0970581,14.4000092,23.5803453,19.4049285,16.6093919,14.2594362,23.7670826, },
	[45] =  {   14.7999929,    14.7194112,    23.7279449,    20.1068478, 18.0970581,14.7999929,24.0615977,19.4049285,16.8595114,14.7194112,24.5593440, },
	[46] =  {   14.9999925,    14.9494037,    24.2386636,    20.5925294, 18.6454457,14.9999925,24.5428285,19.4049285,17.1128851,14.9494037,24.9554545, },
	[47] =  {   15.3999917,    15.1793900,    24.8528092,    21.0781917, 18.6454457,15.3999917,25.0240857,20.0517335,17.3695245,15.1793900,24.9554545, },
	[48] =  {   15.8000098,    15.6393687,    25.5703466,    21.5638538, 19.1938580,15.8000098,25.5053242,20.0517335,17.6295330,15.6393687,25.3515628, },
	[49] =  {   16.0000000,    15.8693634,    26.1871966,    22.0495497, 19.1938580,16.0000000,25.5053242,20.0517335,17.8928967,15.8693634,25.7476473, },
	[50] =  {   16.4000026,    16.3293566,    26.8054115,    22.7294940, 19.1938580,16.4000026,26.4677702,20.6985770,18.1596964,16.3293566,27.3321125, },
	[51] =  {   16.8000027,    16.5593346,    27.3230016,    23.2151604, 19.7422452,16.8000027,26.9490205,20.6985770,18.4299524,16.5593346,27.7282520, },
	[52] =  {   17.0000085,    16.7893408,    27.9440448,    23.7008385, 19.7422452,17.0000085,27.4302517,20.6985770,18.7037550,16.7893408,28.1244111, },
	[53] =  {   17.3999892,    17.2493199,    28.5665315,    24.2836328, 20.2906432,17.3999892,27.4302517,21.3454006,18.9810948,17.2493199,28.5204991, },
	[54] =  {   17.7999922,    17.4793089,    29.2925269,    24.7693356, 20.2906432,17.7999922,27.9114426,21.3454006,19.2620330,17.4793089,28.5204991, },
	[55] =  {   18.1999851,    17.9392791,    29.9179948,    25.3521412, 20.8390641,18.1999851,28.8739450,21.3454006,19.5466353,17.9392791,29.3127050, },
	[56] =  {   18.4000088,    18.1692649,    30.4428831,    25.9348879, 20.8390641,18.4000088,29.3551266,21.9922323,19.8349337,18.1692649,29.7088532, },
	[57] =  {   18.7999962,    18.3992640,    31.1733331,    26.4205679, 21.3874464,18.7999962,29.8364070,21.9922323,20.1269609,18.3992640,30.1049761, },
	[58] =  {   19.2000123,    18.8592422,    31.8033788,    27.0033808, 21.3874464,19.2000123,29.8364070,21.9922323,20.4227927,18.8592422,30.5011026, },
	[59] =  {   19.6000031,    19.0892518,    32.5369376,    27.4890662, 21.9358377,19.6000031,30.3176379,22.6390832,20.7224681,19.0892518,30.8971927, },
	[60] =  {   20.0000000,    19.5492338,    33.1700262,    28.1690141, 21.9358377,20.0000000,31.2801071,22.6390832,21.0260723,19.5492338,32.4816641, },
	[61] =  {   21.0000210,    20.2391867,    33.7027151,    29.9097622, 22.4763549,21.0000210,32.2321748,22.6390832,21.3336064,20.2391867,33.4620507, },
	[62] =  {   22.0000220,    20.6991768,    34.4410730,    31.0776163, 22.4288165,22.0000220,32.8914910,22.6390832,21.6451153,20.6991768,33.8970411, },
	[63] =  {   22.9999793,    21.1591400,    35.1810416,    32.6371822, 22.5908037,22.9999793,34.0671395,23.2859232,21.9606947,21.1591400,35.0921520, },
	[64] =  {   23.9999808,    21.8491361,    35.8207244,    33.7873223, 23.0167078,23.9999808,35.1090311,23.2859232,22.2803988,21.8491361,35.8285532, },
	[65] =  {   25.0000000,    22.3091287,    36.5640071,    34.9463399, 23.4087877,25.0000000,35.6250957,23.2859232,22.6042338,22.3091287,36.5222092, },
	[66] =  {   26.0000260,    22.7690850,    37.1050630,    36.1340864, 23.7655575,26.0000260,36.5759096,23.9327203,22.9322558,22.7690850,37.1712666, },
	[67] =  {   27.0000270,    23.4590347,    37.8518328,    37.2996542, 24.0854745,27.0000270,37.4783094,23.9327203,23.2645787,23.4590347,37.7737654, },
	[68] =  {   27.9999888,    23.9190388,    38.6003513,    38.1870324, 24.1927485,27.9999888,38.3413531,23.9327203,23.6012150,23.9190388,38.8005960, },
	[69] =  {   28.9999652,    24.3790058,    39.3507132,    39.0480095, 24.2846354,28.9999652,39.1840317,24.5795665,23.9421749,24.3790058,39.4118180, },
	[70] =  {   30.0000300,    24.8389813,    40.0030402,    40.0019201, 24.9090198,30.0000300,40.0059209,24.5795665,24.2876434,24.8389813,40.0030402, },
	[71] =  {   32.2000006,    26.9089187,    43.0414834,    43.0305560, 26.8713908,32.2000006,43.0446330,26.5200638,26.0723560,26.9089187,43.0414834, },
	[72] =  {   34.8000390,    28.9788715,    46.3106612,    46.3331912, 29.0649514,34.8000390,46.3138784,28.4605139,28.1749665,28.9788715,46.3106612, },
	[73] =  {   37.3999551,    31.0487652,    49.8278448,    49.8300794, 31.2585961,37.3999551,49.8315693,30.4010507,30.2775238,31.0487652,49.8278448, },
	[74] =  {   40.2000354,    33.5786816,    53.6124038,    53.6181530, 33.4522002,40.2000354,53.6164281,32.9883848,32.3801691,33.5786816,53.6124038, },
	[75] =  {   43.2000899,    36.1085133,    57.6844315,    57.6980775, 36.1941163,43.2000899,57.6887576,35.5756677,34.9032830,36.1085133,57.6844315, },
	[76] =  {   46.6000596,    38.8684614,    62.0659264,    62.0690083, 38.9361097,46.6000596,62.0701641,38.1629865,37.8469620,38.8684614,62.0659264, },
	[77] =  {   50.2000472,    41.8583430,    66.7797470,    66.8283914, 41.6781282,50.2000472,66.7846529,41.3970683,40.7905203,41.8583430,66.7797470, },
	[78] =  {   54.0000540,    44.8482783,    71.8519849,    71.8793577, 44.9684771,54.0000540,71.8571480,43.9844647,43.7342010,44.8482783,71.8519849, },
	[79] =  {   57.9999304,    48.2979792,    77.3090274,    77.3191891, 48.2588217,57.9999304,77.3150045,47.8654407,47.0984971,48.2979792,77.3090274, },
	[80] =  {   62.4001597,    51.9780237,    83.1808351,    83.1469456, 52.0977145,62.4001597,83.1870627,51.0996648,50.4624887,51.9780237,83.1808351, },
	[81] =  {   82.0001476,    68.3074107,   109.2237251,   109.1792450, 68.4083431,81.9363191,109.2315994,67.2703055,66.2615875,68.3074107,109.2237251, },
	[82] =  {  107.6000034,    89.6965565,   143.4290148,   143.3706145, 89.8319245,107.5962987,143.4393015,87.9693163,87.0125124,89.6965565,143.4290148, },
	[83] =  {  141.3999157,   117.7552551,   188.4207888,   188.3437801, 118.0108098,141.3477508,188.4342807,115.7826852,114.3071387,117.7552551,188.4207888, },
	[84] =  {  185.6000356,   154.5537723,   247.4053365,   247.3043822, 154.9539554,185.5962465,247.4230885,152.0052533,150.0908800,154.5537723,247.4053365, },
	[85] =  {  243.6000185,   203.0819720,   324.8535723,   324.7206591, 203.4604554,243.6955950,324.8767905,199.8704839,197.0754010,203.0819720,324.8535723, },
	[86] =  {  520.3996669,   433.5329030,   425.9817559,   693.5389908, 434.5521071,520.3996669,693.8758517,426.2610934,420.9143944,433.5329030,693.8228948, },
	[87] =  {  741.2019331,   617.5240989,   558.5915374,   987.6640757, 618.8425170,741.2019331,988.1422925,606.7261663,599.4197617,617.5240989,988.0641846, },
	[88] =  { 1055.5983659,   879.2522839,   732.4832609,  1406.5093252, 881.2746757,1055.5983659,1407.1822582,864.1623243,853.6210605,879.2522839,1407.0832571, },
	[89] =  { 1503.1942879,  1252.0659087,   960.5081560,  2003.0045068, 28.5000157,1503.1942879,960.5081560,1230.9207287,30.3333637,1252.0659087,960.5081560, },
	[90] =  { 2140.8233607,  1783.1351081,  1259.5180900,  2852.4159963, 28.9999652,2140.8233607,1259.5180900,1752.9098303,30.9999659,1783.1351081,1259.5180900, },
	[91] =  { 3048.5945979,  2539.2955994,  1651.6109823,  4062.2334159, 28.9999652,3048.5945979,1651.6109823,2496.7542195,31.3333271,2539.2955994,1651.6109823, },
	[92] =  { 4341.4083529,  3616.3749458,  2165.7639207,  5785.0283466, 29.5000044,4341.4083529,2165.7639207,3554.9235691,31.6667142,3616.3749458,2165.7639207, },
	[93] =  { 6182.7624583,  5149.8609538,  2839.9746735,  8237.9108658, 30.0000300,6182.7624583,2839.9746735,5062.7784528,32.0000000,5149.8609538,2839.9746735, },
	[94] =  { 8804.3669660,  7334.0667400,  3724.0698623, 11731.5814172, 30.4999863,8804.3669660,3724.0698623,7210.3251857,32.3333700,7334.0667400,3724.0698623, },
	[95] =  {12537.6128385, 10443.8642298,  4883.3873306, 16708.4377611, 30.4999863,12537.6128385,4883.3873306,10267.9946606,33.0000330,10443.8642298,4883.3873306, },
	[96] =  {17857.1428571, 14874.3120631,  6403.6048469, 23792.5291458, 30.9999659,17857.1428571,6403.6048469,14622.0207633,33.3333333,14874.3120631,6403.6048469, },
	[97] =  {25425.8835495, 21181.9529761,  8397.0720033, 33886.8180278, 31.5000315,25425.8835495,8397.0720033,20824.6563932,33.6666330,21181.9529761,8397.0720033, },
	[98] =  {36205.6480811, 30165.9125189, 11011.1132581, 48262.5482625, 32.0000000,36205.6480811,11011.1132581,29655.9905101,34.3333494,30165.9125189,11011.1132581, },
	[99] =  {51572.9757607, 42955.3264605, 14438.9157475, 68728.5223368, 32.5000325,51572.9757607,14438.9157475,42229.7297297,34.6666112,42955.3264605,14438.9157475, },
	[100] = {73421.4390602, 61162.0795107, 18933.8065170, 97847.3581213, 32.5000325,73421.4390602,18933.8065170,60132.2910403,35.3333168,61162.0795107,18933.8065170, },
}
function StatLogic:GetCritFromAgi(agi, class, level)
	--[[
		10/6/2012 Pauladin
			i was looking into a L90 Hunter complaining that his Crit Chance from Agility.
			After he uploaded values, i realized a few things:
				- Critical Chance does not suffer diminishing returns
				- Crit Chance starts off inheriently negative, and you have to claw your way back up to 0%
				
			The Crit Chance formula for this Level 90 Hunter was:
			
			critChance = baseCrit + critRating/critRatingPerCrit + agility/agilityPerCrit
			
			where
				baseCrit = -1.53
				critRatingPerCrit = 600
				agilityPerCrit (Qa) = 1259.51809
				
			If critChance is negative, then return 0:
			
			critChance = max(baseCrit + critRating/H + agility/Qa, 0);
			
			Now, i updated the level 90 hunter AgilityPerCrit entry to 1259.51809, 
			and the Level 90 CritRatingPerCrit value to 600.
			But there's no place in LibStatLogic that has this notion of a *negative* base crit chance.
			That means that it probably falls to RatingBuster to get the calculation right.
			On the other hand, it might not even matter. Since Crit Chance doesn't suffer diminishing returns, 
			people only care about the differential amount gained or lost. And that value won't get stupid unless
			they're near the 1.53%.
	--]]

	-- argCheck for invalid input
	self:argCheck(agi, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	self:argCheck(level, 4, "nil", "number")

	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		-- if class is invalid input, default to player class
		class = ClassNameToID[playerClass]
	end
  
	-- if level is invalid input, default to player level
	if type(level) ~= "number" or level < 1 or level > 100 then
		level = UnitLevel("player")
	end

	-- Calculate
	local agilityPerCrit = CritPerAgi[level][class];
	if (agilityPerCrit) then
		return agi/agilityPerCrit, "MELEE_CRIT";
	else
		return 0,  "MELEE_CRIT";
	end;
end

--[[---------------------------------
  :GetHealthFromSta(sta, [level])
-------------------------------------
Notes:
  * Up to level 80 each point of stamina grants 10 health.
  * For each level beyond 80, stamina grants an additional 8% health per point. 
			Level     HP/Sta  Additional Increase
			========  ======  ==========================================
            80        10.0    0.00   (confirmed 10.0 12/12/2010, 4.0.3)
            81        10.8    0.08
            82        11.6    0.12   (confirmed 11.6 12/11/2010, 4.0.3)
            83        12.4    0.24   (confirmed 12.4 12/12/2010, 4.0.3)
            84        13.2    0.32
            85        14.0    0.40
			86        14?     0.40?  Assume for now that it levels at 14 Health/Stamina
Arguments:
  number - Stamina
  [optional] number - Level used in calculations. Default: player's level
Returns:
  ; health : number - Health
  ; statid : string - "HEALTH"
Example:
  local health = StatLogic:GetHealthFromSta(1) -- GetHealthPerSta
  local health = StatLogic:GetHealthFromSta(10)
-----------------------------------]]
function StatLogic:GetHealthFromSta(sta, level)
	-- argCheck for invalid input
	self:argCheck(sta, 2, "number")
	self:argCheck(level, 3, "nil", "number")
	-- if level is invalid input, default to player level
	if type(level) ~= "number" or level < 1 or level > 100 then
		level = UnitLevel("player")
	end
	local mod;
	if level > 85 then
		mod = 14; --we don't know if it says at 14 Health per Stamina above level 85, but it's a good starting point
	elseif level > 80 then
		mod = 10 + (level - 80) * 0.8;
	else
		mod = 10;
	end
	-- Calculate
	return sta * mod, "HEALTH"
end

--[[
  :GetStrPerParry()
-------------------------------------
Arguments:
  None
Returns:
  ; parry : number - Parry percentage per Strength (before diminishing returns)
  ; statid : string - "PARRY"
Example:
  local parry, statid = StatLogic:GetStrPerParry()
-----------------------------------]]
function StatLogic:GetStrPerParry()
--[[
	We know some values, but Parry/Str varies by level:
	
		QsL85 = 243.605345852; --conversion factor of Strength to Parry%. E.g. 243.6 Strength --> +1% Parry (before DR)
		QsL86 = 319.31752794619; --conversion factor of Strengh to Parry%. 
		QsL87 = 
		QsL88 = 
		QsL89 = 
		QsL90 = 951.158596; --conversion factor of Strength to Parry for Paladins and warriors (exact, given by Ghostcrawler: http://us.battle.net/wow/en/forum/topic/5889309137?page=90#1785)
		
	The problem is that we don't know other levels, other classes, or *if* it even varies by class.
	So we'll follow the rouge of GetDogePerAgi, and using the player's current stats,
	try to dig out and reverse engineer a value.
--]]	

	--[[Only five classes *can* even parry
			--SpellID: 3127   Parry (Warrior)
			--SpellID: 82242  Parry (Paladin)
			--SpellID: 82245  Parry (Rogue)
			--SpellID: 82246  Parry (Death Knight)
			--SpellID: 116812 Parry (Monk)
	--]]

	if not (IsSpellKnown(3127) or IsSpellKnown(82242) or IsSpellKnown(82245) or IsSpellKnown(82246) or IsSpellKnown(116812)) then
		return 0, "PARRY";
	end;

	--[[
	q = -b +- sqrt( b^2 - 4ac)
	    -----------------------
		         2a

	--]]
	
	local str, _, posBuff = UnitStat("player", 1); --1=Strength
	
	local p = 3; --Base Parry (e.g. 3%)
	local R = GetCombatRatingBonus(CR_PARRY); --Parry Rating Bonus (e.g. 13.73% Parry from Parry Rating)
	local P = GetParryChance(); --Parry Chance, after diminishing returns (e.g. 27.18% Parry Chance)
	local s = str-posBuff; --Base Strength
	local S = posBuff; --Bonus Strength
	local C = C_p[playerClassID]; --Parry Cap. e.g. 237.1859113309
	local k = K[playerClassID]; --diminishing returns constant. e.g. 0.886 for Paladins
	
	--print(string.format("p=%s, R=%s, P=%s, s=%s, S=%s, C=%s, k=%s", p, R, P, s, S, C, k));
	
	local a = C*k*p-C*k*P+C*R+p*R-P*R;
	
	--print(string.format("a=%s", a));
	
	local Qs = 
			(
				-((C*k*s+C*S+p*S-P*S+R*s)^2 - 4*s*S*a)^0.5 - C*k*s-C*S-p*S+P*S-R*s
			)
			/
			(2*a)
			
	
	--print(string.format("GetStrPerParry: Qs = %s", Qs));
	return Qs, "PARRY";
end;


function StatLogic:GetAgiPerDodge()
--[[
	We know some values, but Parry/Str varies by level:
	
		QsL85 = 243.605345852; --conversion factor of Strength to Parry%. E.g. 243.6 Strength --> +1% Parry (before DR)
		QsL86 = 319.31752794619; --conversion factor of Strengh to Parry%. 
		QsL87 = 
		QsL88 = 
		QsL89 = 
		QsL90 = 951.158596; --conversion factor of Strength to Parry for Paladins and warriors (exact, given by Ghostcrawler: http://us.battle.net/wow/en/forum/topic/5889309137?page=90#1785)
		
	The problem is that we don't know other levels, other classes, or *if* it even varies by class.
	So we'll follow the rouge of GetDogePerAgi, and using the player's current stats,
	try to dig out and reverse engineer a value.
--]]	

	--[[Only five classes *can* even parry
			--SpellID: 3127   Parry (Warrior)
			--SpellID: 82242  Parry (Paladin)
			--SpellID: 82245  Parry (Rogue)
			--SpellID: 82246  Parry (Death Knight)
			--SpellID: 116812 Parry (Monk)
	--]]

	if not (IsSpellKnown(3127) or IsSpellKnown(82242) or IsSpellKnown(82245) or IsSpellKnown(82246) or IsSpellKnown(116812)) then
		return 0, "PARRY";
	end;

	--[[
	q = -b +- sqrt( b^2 - 4ac)
	    -----------------------
		         2a

	--]]
	
	local agi, _, posBuff = UnitStat("player", 2); --2=Agility
	
	local d = StatLogic:GetBaseDodge() + StatLogic:GetStatMod("ADD_DODGE")*100; --Base Dodge (e.g. 3%)   if my level 90 Human Retribution Paladin has 3.0104999542236% dodge chance the base amount cannot be 5%
	local R = GetCombatRatingBonus(CR_DODGE); --Dodge Rating Bonus (e.g. 13.73% Dodge from Dodge Rating)
	local D = GetDodgeChance(); --Dodge Chance, after diminishing returns (e.g. 27.18% Dodge Chance)
	local a = agi-posBuff; --Base Agility
	local A = posBuff; --Bonus Agility
	local C = C_d[playerClassID]; --Dodge Cap. e.g. 66.56745
	local k = K[playerClassID]; --diminishing returns constant, e.g. 0.886 for Paladins
	
	--print(string.format("d=%s, R=%s, D=%s, a=%s, A=%s, C=%s, k=%s", d, R, D, a, A, C, k));
	
	local factor1 = C*k*d-C*k*D+C*R+d*R-D*R;
	
	--print(string.format("factor1=%s", factor1));
	
	local Qa = 
			(
				-((C*k*a+C*A+d*A-D*A+R*a)^2 - 4*a*A*factor1)^0.5 - C*k*a-C*A-d*A+D*A-R*a
			)
			/
			(2*factor1)
			
	
	--print(string.format("GetAgilityPerDodge: Qa = %s", Qa));
	return Qa, "DODGE";
end;


--[[---------------------------------
  :GetSpellCritFromInt(int, [class], [level])
-------------------------------------
Notes:
  * SpellCritPerInt values reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
  * Calculates the spell crit chance from intellect for given class and level.
Arguments:
  number - Intellect
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
  [optional] number - Level used in calculations. Default: player's level
Returns:
  ; spellcrit : number - Spell crit percentage
  ; statid : string - "SPELL_CRIT"
Example:
  local spellCrit = StatLogic:GetSpellCritFromInt(1) -- GetSpellCritPerInt
  local spellCrit = StatLogic:GetSpellCritFromInt(10)
  local spellCrit = StatLogic:GetSpellCritFromInt(10, "MAGE")
  local spellCrit = StatLogic:GetSpellCritFromInt(10, nil, 70)
  local spellCrit = StatLogic:GetSpellCritFromInt(10, "MAGE", 70)
-----------------------------------]]

--[[
	Supposedly the Intellect per 1% Spell Crit Chance is the same across all classes.
	This doesn't appear true for everything up to level 70. After level 70 they're all the same.
--]]
-- Numbers reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
local SpellCritPerInt = {
  --       WARRIOR,PALADIN,    HUNTER,     ROGUE, PRIEST,     DEATHKNIGHT, SHAMAN,     MAGE,       WARLOCK,    MONK,       DRUID
	[1] =  { 0,    12.0156203,     14.3061516, 0,     5.8471668,  0,           7.5026634,6.1087355,6.6666667,12.0156203,6.9874366, }, 
	[2] =  { 0,    12.6164021,     15.0214657, 0,     6.1129552,  0,           7.8599668,6.3530787,6.9697096,12.6164021,7.3050821, }, 
	[3] =  { 0,    12.6164021,     15.0214657, 0,     6.3787308,  0,           8.2171969,6.5974380,7.2727273,12.6164021,7.6227071, }, 
	[4] =  { 0,    13.2171807,     15.7367556, 0,     6.6445178,  0,           8.2171969,7.0861176,7.5757576,13.2171807,7.9402890, }, 
	[5] =  { 0,    13.2171807,     15.7367556, 0,     7.1760721,  0,           8.5744909,7.3304647,7.8787927,13.2171807,8.2579111, }, 
	[6] =  { 0,    13.8179567,     16.4520767, 0,     7.4418605,  0,           8.9317613,7.5748394,8.1818331,13.8179567,8.5755203, }, 
	[7] =  { 0,    14.4187374,     16.4520767, 0,     7.7076637,  0,           9.2890185,7.8191585,8.4848588,14.4187374,8.8931576, }, 
	[8] =  { 0,    14.4187374,     17.1673820, 0,     7.9734007,  0,           9.6462722,8.0635407,8.7878868,14.4187374,8.8931576, }, 
	[9] =  { 0,    15.0195254,     17.1673820, 0,     8.2391998,  0,           10.0035713,8.5521983,9.0909091,15.0195254,9.2107323, }, 
	[10] = { 0,    15.0195254,     17.8826896, 0,     8.7707758,  0,           10.0035713,8.7965439,9.3939052,15.0195254,10.1635725, }, 
	[11] = { 0,    15.6203139,     17.8826896, 0,     9.5680961,  0,           10.7181136,9.5296181,10.3030328,15.6203139,10.7987979, }, 
	[12] = { 0,    16.2211001,     18.5980078, 0,     10.6312292, 0,           11.4326480,10.7513703,11.2121199,16.2211001,11.7516270, }, 
	[13] = { 0,    16.8218765,     20.0286008, 0,     11.4285714, 0,           12.5044703,11.4844185,12.1212121,16.8218765,12.3868462, }, 
	[14] = { 0,    17.4226348,     20.0286008, 0,     12.7574778, 0,           13.2190153,13.6835595,13.0303007,17.4226348,13.3396830, }, 
	[15] = { 0,    18.6242283,     21.4592275, 0,     13.8205921, 0,           14.2908181,14.9053066,13.9393999,18.6242283,14.6101216, }, 
	[16] = { 0,    18.6242283,     21.4592275, 0,     14.6179383, 0,           15.0053494,15.6383659,14.5454545,18.6242283,15.2453666, }, 
	[17] = { 0,    19.2250017,     22.1745224, 0,     15.9468523, 0,           15.7199090,16.6157670,15.7575853,19.2250017,16.1981881, }, 
	[18] = { 0,    20.4265472,     23.6051705, 0,     16.7441923, 0,           16.7917089,17.5931513,16.6666667,20.4265472,16.8334015, }, 
	[19] = { 0,    20.4265472,     23.6051705, 0,     17.8073142, 0,           17.5062672,18.5705504,17.5757427,20.4265472,17.7862519, }, 
	[20] = { 0,    21.6281217,     25.0357385, 0,     19.1362289, 0,           18.5780716,19.7922996,18.4848350,21.6281217,19.3742880, }, 
	[21] = { 0,    22.2288909,     25.7510951, 0,     19.9335416, 0,           19.2926169,20.5253673,19.3939394,22.2288909,20.0095245, }, 
	[22] = { 0,    22.8296950,     25.7510951, 0,     21.2624811, 0,           20.0071626,21.7471201,20.3030432,22.8296950,20.9623830, }, 
	[23] = { 0,    23.4304526,     27.1816687, 0,     22.0598130, 0,           21.0789470,22.4801444,21.2121019,23.4304526,21.5975724, }, 
	[24] = { 0,    24.0312406,     27.8969598, 0,     23.3886944, 0,           21.7935195,23.7019059,22.4242397,24.0312406,22.8680150, }, 
	[25] = { 0,    25.2327723,     28.6123033, 0,     24.4518506, 0,           22.8652960,24.6792926,23.3333567,25.2327723,23.8208671, }, 
	[26] = { 0,    25.8335852,     29.3275773, 0,     25.5149556, 0,           23.5798449,25.6566828,23.9393664,25.8335852,24.4560964, }, 
	[27] = { 0,    25.8335852,     30.0429313, 0,     26.5780731, 0,           24.2943700,26.8784690,25.1515380,25.8335852,25.4088926, }, 
	[28] = { 0,    27.0351376,     30.7582524, 0,     27.6411843, 0,           25.3662249,29.5662921,26.0606013,27.0351376,26.0441761, }, 
	[29] = { 0,    27.6359134,     31.4735606, 0,     28.7042884, 0,           26.0807198,30.7879878,27.2727025,27.6359134,27.3145682, }, 
	[30] = { 0,    28.8374749,     32.9041535, 0,     30.0331867, 0,           27.1525894,32.0097310,28.1817951,28.8374749,28.9026530, }, 
	[31] = { 0,    29.4382591,     33.6194347, 0,     31.0963645, 0,           28.2243497,32.7428702,28.7879137,29.4382591,29.5379090, }, 
	[32] = { 0,    30.0390508,     33.6194347, 0,     32.1595112, 0,           28.9388695,33.9646224,30.0000300,30.0390508,30.8082862, }, 
	[33] = { 0,    30.6397894,     35.0500866, 0,     33.2225914, 0,           30.0107438,34.9419440,30.9091302,30.6397894,31.4435745, }, 
	[34] = { 0,    31.2406278,     35.7653791, 0,     34.5515042, 0,           30.7252700,35.9194112,32.1211868,31.2406278,32.3964286, }, 
	[35] = { 0,    32.4421475,     37.1960156, 0,     35.6145649, 0,           31.7971090,37.1411699,33.0303351,32.4421475,33.6668597, }, 
	[36] = { 0,    33.0429955,     37.9112422, 0,     36.6777311, 0,           32.8688958,38.1184722,33.9393775,33.0429955,34.3020224, }, 
	[37] = { 0,    33.6437530,     37.9112422, 0,     38.0066284, 0,           33.5834179,39.3401864,35.1514853,33.6437530,35.2548396, }, 
	[38] = { 0,    34.8452696,     39.3418889, 0,     39.0698256, 0,           34.6551981,40.3177035,36.0605962,34.8452696,36.2077456, }, 
	[39] = { 0,    35.4460352,     40.0572017, 0,     40.1329202, 0,           35.3698090,41.5394521,37.2726832,35.4460352,37.1604925, }, 
	[40] = { 0,    36.6476221,     41.4879229, 0,     41.4617764, 0,           36.7987989,42.5168260,38.1817835,36.6476221,39.0661625, }, 
	[41] = { 0,    37.2483871,     42.2031745, 0,     42.5249622, 0,           37.5134580,43.4941457,39.0909020,37.2483871,39.7014451, }, 
	[42] = { 0,    37.8492540,     42.2031745, 0,     43.8538789, 0,           38.2279071,46.4263330,40.3030792,37.8492540,40.9718523, }, 
	[43] = { 0,    39.0507543,     43.6338249, 0,     44.9169710, 0,           39.2996797,47.4036994,41.2121312,39.0507543,41.6070299, }, 
	[44] = { 0,    39.0507543,     44.3490447, 0,     46.2457685, 0,           40.3715800,48.6255975,42.4242938,39.0507543,42.8776016, }, 
	[45] = { 0,    40.2523014,     45.7795805, 0,     47.5746446, 0,           41.4433904,49.8472183,43.6363002,40.2523014,43.8304288, }, 
	[46] = { 0,    40.8531778,     46.4949762, 0,     48.6378957, 0,           42.5151992,50.8246296,44.5454140,40.8531778,44.7832045, }, 
	[47] = { 0,    42.0546205,     47.2103410, 0,     49.9667721, 0,           43.2297836,52.0464671,45.4545455,42.0546205,45.7360299, }, 
	[48] = { 0,    43.2561499,     48.6409713, 0,     51.0297810, 0,           44.3014983,53.2682750,46.6666044,43.2561499,46.6888283, }, 
	[49] = { 0,    43.8569562,     49.3561490, 0,     52.3587622, 0,           45.3732860,54.4899738,47.8787327,43.8569562,47.9593305, }, 
	[50] = { 0,    45.0586438,     50.7869437, 0,     53.6878161, 0,           46.4450926,55.7115479,49.0908377,45.0586438,49.5473846, }, 
	[51] = { 0,    45.6593901,     51.5020575, 0,     54.7507200, 0,           47.5169992,56.6890210,50.0000000,45.6593901,50.5002045, }, 
	[52] = { 0,    46.2601020,     52.2174124, 0,     56.0795882, 0,           48.2315888,57.9109214,51.2121926,46.2601020,51.7705529, }, 
	[53] = { 0,    47.4617458,     53.6480687, 0,     57.1428571, 0,           49.6605700,58.8883065,52.4243647,47.4617458,52.4059575, }, 
	[54] = { 0,    48.0625967,     54.3634851, 0,     58.4716676, 0,           50.3750422,60.3544010,53.6362710,48.0625967,53.6762890, }, 
	[55] = { 0,    49.2639959,     55.7939196, 0,     60.0665537, 0,           51.8043453,61.5759755,54.8486178,49.2639959,54.9468664, }, 
	[56] = { 0,    49.8648662,     56.5093071, 0,     61.1295519, 0,           52.5188017,64.7525804,55.7575217,49.8648662,55.8996490, }, 
	[57] = { 0,    50.4655446,     57.2246066, 0,     62.4586212, 0,           53.5905681,66.2185876,56.9696693,50.4655446,56.8524225, }, 
	[58] = { 0,    52.2679044,     58.6551546, 0,     63.5215052, 0,           55.0197246,67.1961725,58.1818182,52.2679044,57.8051389, }, 
	[59] = { 0,    52.8686531,     59.3704359, 0,     65.1164608, 0,           55.7342147,68.6619839,59.3940618,52.8686531,59.0758179, }, 
	[60] = { 0,    54.0704213,     60.8009923, 0,     66.4451827, 0,           57.1634360,69.8841321,60.6060606,54.0704213,60.9815592, }, 
	[61] = { 0,    63.0819308,     63.6419757, 0,     67.5082698, 0,           61.0135572,69.8841321,62.8705433,63.0819308,61.9057052, }, 
	[62] = { 0,    64.8845056,     64.9485607, 0,     69.1027696, 0,           63.0819308,69.8841321,64.9232607,64.8845056,63.8630776, }, 
	[63] = { 0,    67.2875061,     66.8016059, 0,     70.1660831, 0,           65.7946680,69.8841321,67.7410396,67.2875061,66.5588413, }, 
	[64] = { 0,    69.0898790,     69.3433188, 0,     71.7607211, 0,           68.1486731,70.1281943,70.0069307,69.0898790,68.6275855, }, 
	[65] = { 0,    71.4929151,     71.0812886, 0,     73.0897981, 0,           70.3012408,70.3724815,72.2079010,71.4929151,70.6334407, }, 
	[66] = { 0,    73.2955128,     72.7272727, 0,     74.4186047, 0,           72.5305172,72.5715737,74.3417042,73.2955128,72.8241951, }, 
	[67] = { 0,    74.4967743,     74.9928757, 0,     75.7472466, 0,           74.6937556,74.7708274,76.7618770,74.4967743,74.9462261, }, 
	[68] = { 0,    76.2991844,     76.7029983, 0,     77.0766373, 0,           76.4888556,76.2369444,78.5330035,76.2991844,76.5767146, }, 
	[69] = { 0,    78.1018135,     78.3735912, 0,     78.6713974, 0,           78.2564464,77.9471830,79.2631696,78.1018135,78.3036302, }, 
	[70] = { 0,    79.9041151,     80.0000000, 0,     80.0000000, 0,           80.0000000,79.9021997,80.0000000,79.9041151,80.0000000, }, 
	--After level 70 values are all identical across all classes - for those that have Intellect (or Spells for that matter)
	[71] =     86.0111470 , 
	[72] =     92.6080273 , 
	[73] =     99.4500413 , 
	[74] =    107.0250150 , 
	[75] =    115.0885722 , 
	[76] =    123.8851882 , 
	[77] =    133.4148053 , 
	[78] =    143.4331293 , 
	[79] =    154.4289449 , 
	[80] =    166.1576703 , 
	[81] =    218.1791207 , 
	[82] =    286.5050396 , 
	[83] =    376.3784862 , 
	[84] =    494.2029988 , 
	[85] =    648.9082119 , 
	[86] =    852.106500920076 , --interpolated
	[87] =   1118.971808926230 , --interpolated
	[88] =   1469.414806505600 , --interpolated
	[89] =   1929.610608912350 , --interpolated
	[90] =   2533.66 , --http://blog.askmrrobot.com/2012/08/changes-for-patch-5-0-4/
	[91] =   3327.516450660250 , --extrapolated
	[92] =   4369.638182558990 , --extrapolated
	[93] =   5738.134770960710 , --extrapolated
	[94] =   7535.221287000430 , --extrapolated
	[95] =   9895.124828962150 , --extrapolated
	[96] =  12994.110146394900 , --extrapolated
	[97] =  17063.645119710200 , --extrapolated
	[98] =  22407.689444759000 , --extrapolated
	[99] =  29425.397840276500 , --extrapolated
	[100] = 38640.933514948700 , --extrapolated
}

function StatLogic:GetSpellCritFromInt(int, class, level)
	-- argCheck for invalid input
	self:argCheck(int, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	self:argCheck(level, 4, "nil", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- if level is invalid input, default to player level
	if type(level) ~= "number" or level < 1 or level > 100 then
		level = UnitLevel("player")
	end

	-- Calculate
	local intellectPerSpellCrit;
	
	if (level > 70) then
		intellectPerSpellCrit = SpellCritPerInt[level] or 0
	else
		intellectPerSpellCrit = SpellCritPerInt[level][class] or 0;
	end;
	
	if (intellectPerSpellCrit == 0) then
		return 0, "SPELL_CRIT";
	end;
	
	return int / intellectPerSpellCrit, "SPELL_CRIT"
end


local BaseManaRegenPerSpi
--[[---------------------------------
  :GetNormalManaRegenFromSpi(spi)
-------------------------------------
*Updated For Mists
Notes:
Mists Formual for  Mana Regen = Total Mana *0.02 +(1.1287*SPI)
  * Formula and BASE_REGEN values derived by Whitetooth (hotdogee [at] gmail [dot] com)
  * Calculates the mana regen per 5 seconds from spirit when out of 5 second rule for given spirit
  * Player class level int is no longer a parameter

Arguments:
  number - Spirit
Returns:
  ; mp5o5sr : number - Mana regen per 5 seconds when out of 5 second rule
  ; statid : string - "MANA_REGEN"
Example:
  local mp5o5sr = StatLogic:GetNormalManaRegenFromSpi(1) -- GetNormalManaRegenPerSpi
-----------------------------------]]

function StatLogic:GetNormalManaRegenFromSpi(spi,...)
	-- argCheck for invalid input
	self:argCheck(spi, 2, "number")

	local maxmana = UnitManaMax("player");
	-- Calculate
	--return (0.001 + spi * BaseManaRegenPerSpi[level] * (int ^ 0.5)) * 5, "MANA_REGEN"
	return (1.1287*spi), "MANA_REGEN" --*Meditation) 
end



--[[---------------------------------
  :GetHealthRegenFromSpi(spi, [class])
-------------------------------------
Notes:
  * HealthRegenPerSpi values derived by Whitetooth (hotdogee [at] gmail [dot] com)
  * Calculates the health regen per 5 seconds when out of combat from spirit for given class.
  * Player level does not effect health regen per spirit.
Arguments:
  number - Spirit
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; hp5oc : number - Health regen per 5 seconds when out of combat
  ; statid : string - "HEALTH_REGEN"
Example:
  local hp5oc = StatLogic:GetHealthRegenFromSpi(1) -- GetHealthRegenPerSpi
  local hp5oc = StatLogic:GetHealthRegenFromSpi(10)
  local hp5oc = StatLogic:GetHealthRegenFromSpi(10, "MAGE")
-----------------------------------]]

-- Numbers reverse engineered by Whitetooth (hotdogee [at] gmail [dot] com)
-- 4.0.1.12803: Removed Health Regen from Spirit
local HealthRegenPerSpi = {
	0, --Warrior
	0, --Paladin
	0, --Hunter
	0, --Rogue
	0, --Priest
	0, --Death Knight
	0, --Shaman
	0, --Mage
	0, --Warlock
	0, --Monk
	0, --Druid
	--["WARRIOR"] = 0.5,
	--["PALADIN"] = 0.125,
	--["HUNTER"] = 0.125,
	--["ROGUE"] = 0.333333,
	--["PRIEST"] = 0.041667,
	--["DEATHKNIGHT"] = 0.5,
	--["SHAMAN"] = 0.071429,
	--["MAGE"] = 0.041667,
	--["WARLOCK"] = 0.045455,
	--["DRUID"] = 0.0625,
}

function StatLogic:GetHealthRegenFromSpi(spi, class)
	-- argCheck for invalid input
	self:argCheck(spi, 2, "number")
	self:argCheck(class, 3, "nil", "string", "number")
	-- if class is a class string, convert to class id
	if type(class) == "string" and ClassNameToID[strupper(class)] ~= nil then
		class = ClassNameToID[strupper(class)]
	-- if class is invalid input, default to player class
	elseif type(class) ~= "number" or class < 1 or class > 10 then
		class = ClassNameToID[playerClass]
	end
	-- Calculate
	return spi * HealthRegenPerSpi[class] * 5, "HEALTH_REGEN"
end


----------
-- Gems --
----------

--[[---------------------------------
  :RemoveEnchant(link)
-------------------------------------
Notes:
  * Remove item's enchants.
Arguments:
  string - "itemlink"
Returns:
  ; link : number - The modified link
Example:
  local link = StatLogic:RemoveEnchant("Hitem:31052:425:525:525:525:525:0:0")
  "|cffa335ee|Hitem:47468:0:2968:0:0:0:0:-2055313024:80:147|h[Cry of the Val'kyr]|h|r",
-----------------------------------]]
function StatLogic:RemoveEnchant(link)
	-- check link
	if not strfind(link, "item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+") then
		return link
	end
	local linkType, itemId, enchantId, rest = strsplit(":", link, 4)
	return strjoin(":", linkType, itemId, 0, rest)
end

--[[---------------------------------
  :RemoveGem(link)
-------------------------------------
Notes:
  * Remove item's gems.
Arguments:
  string - "itemlink"
Returns:
  ; link : number - The modified link
Example:
  local link = StatLogic:RemoveGem("Hitem:31052:425:525:525:525:525:0:0")
-----------------------------------]]
function StatLogic:RemoveGem(link)
	-- check link
	if not strfind(link, "item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+") then
		return link
	end
	local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, rest = strsplit(":", link, 8)
	if reforging then
	else
	end
	return strjoin(":", linkType, itemId, enchantId, 0, 0, 0, 0, rest)
end

--[[---------------------------------
  :RemoveExtraSocketGem(link)
-------------------------------------
Notes:
  * Remove gems socketed in Prismatic Sockets, this includes Eternal Belt Buckles and Blacksmith only Bracer Socket and Glove Socket.
Arguments:
  string - "itemlink"
Returns:
  ; link : number - The modified link
Example:
  local link = StatLogic:RemoveExtraSocketGem("Hitem:31052:425:525:525:525:525:0:0")
-----------------------------------]]
local itemStatsTable = {}
local GetExtraSocketGemLoc = setmetatable({}, { __index = function(self, n)
	-- We are here because what we want is not in cache
	-- Get last gem location
	local lastGemLoc = 0
	local _, _, _, jewelId1, jewelId2, jewelId3, jewelId4 = strsplit(":", n)
	if jewelId4 ~= "0" then
		lastGemLoc = 4
	elseif jewelId3 ~= "0" then
		lastGemLoc = 3
	elseif jewelId2 ~= "0" then
		lastGemLoc = 2
	elseif jewelId1 ~= "0" then
		lastGemLoc = 1
	end
	if lastGemLoc == 0 then
		self[n] = 0
		return 0
	end
	-- Get number of sockets
	wipe(itemStatsTable)
	GetItemStats(n, itemStatsTable)
	--RatingBuster:Print(itemStatsTable)
	local numSockets = (itemStatsTable["EMPTY_SOCKET_RED"] or 0) + (itemStatsTable["EMPTY_SOCKET_YELLOW"] or 0) + (itemStatsTable["EMPTY_SOCKET_BLUE"] or 0)
	if numSockets < lastGemLoc then
		self[n] = lastGemLoc
		return lastGemLoc
	else
		self[n] = 0
		return 0
	end
end })

local extraSocketLoc = {
	["INVTYPE_WAIST"] = true,
	["INVTYPE_WRIST"] = true,
	["INVTYPE_HAND"] = true,
}
function StatLogic:RemoveExtraSocketGem(link)
	-- check link
	if not strfind(link, "item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+") then
		return link
	end
	-- check only belt, bracer and gloves
	local _, _, _, _, _, _, _, _, itemType = GetItemInfo(link)
	if not extraSocketLoc[itemType] then return link end
	-- Get current gem count
	local extraGemLoc = GetExtraSocketGemLoc[link]
	if extraGemLoc == 0 then return link end
	local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, rest = strsplit(":", link, 8)
	if extraGemLoc == 1 then
		jewelId1 = "0"
	elseif extraGemLoc == 2 then
		jewelId2 = "0"
	elseif extraGemLoc == 3 then
		jewelId3 = "0"
	elseif extraGemLoc == 4 then
		jewelId4 = "0"
	end
	return strjoin(":", linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, rest)
end


--[[---------------------------------
  :RemoveEnchantGem(link)
-------------------------------------
Notes:
  * Remove item's gems and enchants.
Arguments:
  string - "itemlink"
Returns:
  ; link : number - The modified link
Example:
  local link = StatLogic:RemoveEnchantGem("Hitem:31052:425:525:525:525:525:0:0")
-----------------------------------]]
function StatLogic:RemoveEnchantGem(link)
  -- check link
  if not strfind(link, "item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+") then
    return link
  end
  local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, rest = strsplit(":", link, 8)
  return strjoin(":", linkType, itemId, 0, 0, 0, 0, 0, rest)
end

--[[---------------------------------
  :ModEnchantGem(link, enc, gem1, gem2, gem3, gem4)
-------------------------------------
Notes:
  * Add/Replace item's enchants or gems with given enchants or gems.
Arguments:
  string - "itemlink"
  [optional] number or string - enchantID to replace the current enchant. Default: no change
  [optional] number or string - gemID to replace the first gem. Default: no change
  [optional] number or string - gemID to replace the second gem. Default: no change
  [optional] number or string - gemID to replace the third gem. Default: no change
  [optional] number or string - gemID to replace the fourth gem. Default: no change
Returns:
  ; link : number - The modified link
Example:
  local link = StatLogic:ModEnchantGem("Hitem:31052:0:0:0:0:0:0:0", 1394)
-----------------------------------]]
function StatLogic:ModEnchantGem(link, enc, gem1, gem2, gem3, gem4)
  -- check link
  if not strfind(link, "item:%d+") then
    return
  end
  local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, rest = strsplit(":", link, 8)
  return strjoin(":", linkType, itemId, enc or enchantId or 0, gem1 or jewelId1 or 0, gem2 or jewelId2 or 0, gem3 or jewelId3 or 0, gem4 or jewelId4 or 0, rest)
end

--[[---------------------------------
  :BuildGemmedTooltip(item, red, yellow, blue, meta)
-------------------------------------
Notes:
  * Returns a modified link with all empty sockets replaced with the specified gems, sockets already gemmed will remain.
  * item:
  :;tooltip : table - The tooltip showing the item
  :;itemId : number - The numeric ID of the item. ie. 12345
  :;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
  :::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
  :;"itemName" : string - The Name of the Item, ex: "Hearthstone"
  :::The item must have been equiped, in your bags or in your bank once in this session for this to work.
  :;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
  number or string or table - tooltip or itemId or "itemString" or "itemName" or "itemLink"
  number or string - gemID to replace a red socket
  number or string - gemID to replace a yellow socket
  number or string - gemID to replace a blue socket
  number or string - gemID to replace a meta socket
Returns:
  ; link : string - modified item link
Example:
  local link = StatLogic:BuildGemmedTooltip(28619, 3119, 3119, 3119, 3119)
  StatLogic:SetTip("item:28619")
  StatLogic:SetTip(StatLogic:BuildGemmedTooltip(28619, 3119, 3119, 3119, 3119))
-----------------------------------]]
local EmptySocketLookup = {
	[EMPTY_SOCKET_RED] = 0, -- EMPTY_SOCKET_RED = "Red Socket";
	[EMPTY_SOCKET_YELLOW] = 0, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
	[EMPTY_SOCKET_BLUE] = 0, -- EMPTY_SOCKET_BLUE = "Blue Socket";
	[EMPTY_SOCKET_META] = 0, -- EMPTY_SOCKET_META = "Meta Socket";
}
function StatLogic:BuildGemmedTooltip(item, red, yellow, blue, meta)
  local _
  -- Check item
  if (type(item) == "string") or (type(item) == "number") then
  elseif type(item) == "table" and type(item.GetItem) == "function" then
    -- Get the link
    _, item = item:GetItem()
    if type(item) ~= "string" then return item end
  else
    return item
  end
  -- Check if item is in local cache
  local name, link, _, _, reqLv, _, _, _, itemType = GetItemInfo(item)
  if not name then return item end

  -- Check gemID
  if not red or not tonumber(red) then red = 0 end
  if not yellow or not tonumber(yellow) then yellow = 0 end
  if not blue or not tonumber(blue) then blue = 0 end
  if not meta or not tonumber(meta) then meta = 0 end
  if red == 0 and yellow == 0 and blue == 0 and meta == 0 then return link end -- nothing to modify
  -- Fill EmptySocketLookup
  EmptySocketLookup[EMPTY_SOCKET_RED] = red
  EmptySocketLookup[EMPTY_SOCKET_YELLOW] = yellow
  EmptySocketLookup[EMPTY_SOCKET_BLUE] = blue
  EmptySocketLookup[EMPTY_SOCKET_META] = meta

  -- Build socket list
  local socketList = {}
  -- Get a link without any socketed gems
  local cleanLink = link:match("(item:%d+)")
  -- Start parsing
  tip:ClearLines() -- this is required or SetX won't work the second time its called
  tip:SetHyperlink(link)
  for i = 2, tip:NumLines() do
    local text = tip[i]:GetText()
    -- DEBUG
    if not text then
      print(i, tip:NumLines(), link)
    end
    -- Trim spaces
    text = strtrim(text)
    -- Strip color codes
    if strsub(text, -2) == "|r" then
      text = strsub(text, 1, -3)
    end
    if strfind(strsub(text, 1, 10), "|c%x%x%x%x%x%x%x%x") then
      text = strsub(text, 11)
    end
    local socketFound = EmptySocketLookup[text]
    if socketFound then
      socketList[#socketList+1] = socketFound
    end
  end
  -- If there are no sockets
  if #socketList == 0 then return link end
  -- link breakdown
  local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, rest = strsplit(":", link, 8)
  if socketList[1] and (not jewelId1 or jewelId1 == "0") then jewelId1 = socketList[1] end
  if socketList[2] and (not jewelId2 or jewelId2 == "0") then jewelId2 = socketList[2] end
  if socketList[3] and (not jewelId3 or jewelId3 == "0") then jewelId3 = socketList[3] end
  if socketList[4] and (not jewelId4 or jewelId4 == "0") then jewelId4 = socketList[4] end
  return strjoin(":", linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, rest)
end

--[[---------------------------------
  :GetGemID(item)
-------------------------------------
Notes:
  * Returns the gemID and gemText of a gem for use in links
  * item:
  :;tooltip : table - The tooltip showing the item
  :;itemId : number - The numeric ID of the item. ie. 12345
  :;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
  :::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
  :;"itemName" : string - The Name of the Item, ex: "Hearthstone"
  :::The item must have been equiped, in your bags or in your bank once in this session for this to work.
  :;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
  number or string or table - Gem, tooltip or itemId or "itemString" or "itemName" or "itemLink"
Returns:
  ; gemID or false : number or bool - The gemID of this gem, false if invalid input
  ; gemText : string - The text shown in the tooltip when socketed in an item
Example:
  local gemID, gemText = StatLogic:GetGemID(28363)
-----------------------------------]]
-- SetTip("item:3185:0:2946")
function StatLogic:GetGemID(item)
  local t = GetTime()
  -- Check item
  if (type(item) == "string") or (type(item) == "number") then
	-- We have link
  elseif type(item) == "table" and type(item.GetItem) == "function" then
    -- We were given a tooltip - get the link
    _, item = item:GetItem()
    if type(item) ~= "string" then return false end
  else
    return false
  end
  -- Check if item is in local cache
  local name, link = GetItemInfo(item)
  if not name then
    if tonumber(item) then
      -- Query server for item
      tipMiner:ClearLines()
      tipMiner:SetHyperlink("item:"..item)
    else
      item = item:match("item:(%d+)")
      if item then
        -- Query server for item
        tipMiner:ClearLines()
        tipMiner:SetHyperlink("item:"..item)
      else
        return false
      end
    end
    return
  end
  local itemID = strmatch(link, "item:(%d+)")
  local itemIDPattern=format("item:%d:", itemID)    -- for testing against gem itemlinks that we find
  local gemScanLink = "item:6948:0:0:0:%d:%d"
  

  -- Method 1: Try to find the gem already in our gear. Provides a layer of safety for future expansions (and might avoid unnecessary disconnects from scanning)
  for i=INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
    local eqLink = GetInventoryItemLink("player", i)
    local gemIDs = { strmatch(eqLink or "", "item:[-0-9]+:[-0-9]+:([-0-9]+):([-0-9]+):([-0-9]+):") }    -- yah garbage. this is a manual operation; it matters not.
    for i=1, #gemIDs do
		local gemID = gemIDs[i]
        local gemName, gemLink = GetItemGem(eqLink, i)
        if gemLink and gemLink:match(itemIDPattern) then
          tipMiner:ClearLines() -- this is required or SetX won't work the second time its called
          tipMiner:SetHyperlink(gemScanLink:format(gemID, gemID))
          if GetCVarBool("colorblindMode") then
            return gemID, StatLogicMinerTooltipTextLeft6:GetText(), GetTime()-t
          else
            return gemID, StatLogicMinerTooltipTextLeft5:GetText(), GetTime()-t
          end
        end
    end
  end
  
  
  -- Method 2: Fallback scanner if we didn't find the gem in our gear. This will fail if gemIDs go higher than our assumed maximum
  if not GetItemInfo(6948) then -- Hearthstone
    -- Query server for Hearthstone
    tipMiner:ClearLines()
    tipMiner:SetHyperlink("item:6948")
    return
  end
  local gemID
  -- Start GemID scan
  for gemID = 5000, 1, -1 do    -- THIS NUMBER MAY NEED TO BE INCREASED IN NEW EXPANSIONS
    local itemLink = gemScanLink:format(gemID, gemID)
    local _, gem1Link = GetItemGem(itemLink, 3)
    if gem1Link and gem1Link:match(itemIDPattern) then
      tipMiner:ClearLines() -- this is required or SetX won't work the second time its called
      tipMiner:SetHyperlink(itemLink)
      if GetCVarBool("colorblindMode") then
        return gemID, StatLogicMinerTooltipTextLeft6:GetText(), GetTime()-t
      else
        return gemID, StatLogicMinerTooltipTextLeft5:GetText(), GetTime()-t
      end
    end
  end
end

-- will sometimes disconnect
-- StatLogic:GetEnchantID("+10 All Stats")
--[[
function StatLogic:GetEnchantID(spell)
  -- Check item
  if not ((type(spell) == "string") or (type(spell) == "number")) then
    return
  end
  local spellName = spell
  if type(spell) == "number" then
    spellName = GetSpellInfo(spell)
  end
  if not GetItemInfo(6948) then -- Hearthstone
    -- Query server for Hearthstone
    tipMiner:ClearLines()
    tipMiner:SetHyperlink("item:6948")
    return
  end
  local scanLink = "item:6948:%d:%d:%d:%d:%d"
  local id
  -- Start EnchantID scan
  for id = 4300, 5, -5 do
    local itemLink = scanLink:format(id, id-1, id-2, id-3, id-4)
    tipMiner:ClearLines() -- this is required or SetX won't work the second time its called
    tipMiner:SetHyperlink(itemLink)
    if StatLogicMinerTooltipTextLeft4:GetText() == spellName then
      return id, StatLogicMinerTooltipTextLeft4:GetText()
    elseif StatLogicMinerTooltipTextLeft5:GetText() and strfind(StatLogicMinerTooltipTextLeft5:GetText(), spellName) then
      return id, StatLogicMinerTooltipTextLeft5:GetText()
    elseif StatLogicMinerTooltipTextLeft6:GetText() and strfind(StatLogicMinerTooltipTextLeft6:GetText(), spellName) then
      return id, StatLogicMinerTooltipTextLeft6:GetText()
    elseif StatLogicMinerTooltipTextLeft7:GetText() and strfind(StatLogicMinerTooltipTextLeft7:GetText(), spellName) then
      return id, StatLogicMinerTooltipTextLeft7:GetText()
    elseif StatLogicMinerTooltipTextLeft8:GetText() == spellName then
      return id, StatLogicMinerTooltipTextLeft8:GetText()
    end
  end
end
--]]

-- ================== --
-- Stat Summarization --
-- ================== --
--[[---------------------------------
  :GetSum(item, [table])
-------------------------------------
Notes:
  * Calculates the sum of all stats for a specified item.
  * item:
  :;tooltip : table - The tooltip showing the item
  :;itemId : number - The numeric ID of the item. ie. 12345
  :;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
  :::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
  :;"itemName" : string - The Name of the Item, ex: "Hearthstone"
  :::The item must have been equiped, in your bags or in your bank once in this session for this to work.
  :;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
  number or string or table - tooltip or itemId or "itemString" or "itemName" or "itemLink"
  table - The sum of stat values are writen to this table if provided
Returns:
  ; sumTable : table - The table with stat sum values
  :{
  ::    ["itemType"] = itemType,
  ::    ["STAT_ID1"] = value,
  ::    ["STAT_ID2"] = value,
  :}
Example:
  StatLogic:GetSum(21417) -- [Ring of Unspoken Names]
  StatLogic:GetSum("item:28040:2717")
  StatLogic:GetSum("item:19019:117") -- TF
  StatLogic:GetSum("item:3185:0:0:0:0:0:1957") -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
  StatLogic:GetSum(24396)
  SetTip("item:3185:0:0:0:0:0:1957")
  -- [Deadly Fire Opal] ID:30582 - Attack Power +8 and Critical Rating +5
  -- [Gnomeregan Auto-Blocker 600] ID:29387
  StatLogic:GetSum("item:30538:3011:2739:2739:2739:0") -- [Midnight Legguards] with enchant and gems
  StatLogic:GetSum("item:30538:3011:2739:2739:2739:0") -- [Midnight Legguards] with enchant and gems
-----------------------------------]]
--[[
0 = Poor
1 = Common
2 = Uncommon
3 = Rare
4 = Epic
5 = Legendary
6 = Artifact
7 = Heirloom
--]]
-- baseArmorTable[rarity][equipLoc][armorType][ilvl] = armorValue
-- Not interested in lower level items
local baseArmorTable = {
  [4] = {
    ["INVTYPE_CLOAK"] = {
      [L["Cloth"]] = {
        [200] = 404, -- Cloak of Armed Strife ID:39225
        [213] = 428, -- Cloak of the Shadowed Sun ID:40252
        [264] = 556, -- Sentinel's Winter Cloak ID:50466
      },
    },
    ["INVTYPE_LEGS"] = {
      [L["Plate"]] = {
        [226] = 2088, -- Saronite Plated Legguards ID:45267
      },
    },
  },
  [3] = {
    ["INVTYPE_CLOAK"] = {
      [L["Cloth"]] = {
        [167] = 312, -- Cloak of Tormented Skies ID:41238
        [187] = 364, -- Flowing Cloak of Command ID:37084
      },
    },
  },
}
local bonusArmorItemEquipLoc = {
	["INVTYPE_WEAPON"] = true,
	["INVTYPE_2HWEAPON"] = true,
	["INVTYPE_WEAPONMAINHAND"] = true,
	["INVTYPE_WEAPONOFFHAND"] = true,
	["INVTYPE_HOLDABLE"] = true,
	["INVTYPE_RANGED"] = true,
	["INVTYPE_THROWN"] = true,
	["INVTYPE_RANGEDRIGHT"] = true,
	["INVTYPE_NECK"] = true,
	["INVTYPE_FINGER"] = true,
	["INVTYPE_TRINKET"] = true,
}

function StatLogic:GetSum(item, table)
	-- Locale check
	if noPatternLocale then return end
	-- Clear table values
	clearTable(table)
	local _
	
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then -- common case first
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return end
	else
		return table
	end
	-- Check if item is in local cache
	local name, link, rarity , ilvl, reqLv, _, armorType, _, itemType = GetItemInfo(item)
	if not name then return table end

	-- Initialize table
	table = table or new()
	setmetatable(table, statTableMetatable)

	-- Get data from cache if available
	if cache[link] then
		copyTable(table, cache[link])
		return table
	end

	-- Set metadata
	table.itemType = itemType
	table.link = link

	-- Start parsing
	tip:ClearLines() -- this is required or SetX won't work the second time its called
	tip:SetHyperlink(link)
	debugPrint("Item being analysed: "..link)
	for i = 2, tip:NumLines() do
		local text = tip[i]:GetText();
		local r, g, b = tip[i]:GetTextColor()

		--debugPrint(string.format("    Line %d: %s", i, text));
		StatLogic:ParseLine(table, text, r,g,b);
	end --for each line in the tooltip

	-- Tooltip scanning done, do post processing
	--[[ 3.0.8
		Bonus Armor: The mechanics for items with bonus armor on them has
		changed (any cloth, leather, mail, or plate items with extra armor,
		or any other items with any armor). Bonus armor beyond the base
		armor of an item will no longer be multiplied by any talents or by
		the bonuses of Bear Form, Dire Bear Form, or Frost Presence.
	--]]
	if bonusArmorItemEquipLoc[itemType] and table["ARMOR"] then
		-- Convert "ARMOR" to "ARMOR_BONUS"
		table["ARMOR_BONUS"] = (table["ARMOR_BONUS"] or 0) + table["ARMOR"]
		table["ARMOR"] = nil
	end
	cache[link] = copy(table)
	return table
end

--[[
	found, excluded = ParseLine(table, text, r,g,b)
	
Parses a line of tooltip text, stores the Stats it finds in table.

Paramters
	table - a table where stats will be added to
	text - a line of text from an item's tooltip (e.g. "+285 Strength")
	r,g,b - the color of the tooltip line (useful for deciding if a line should be ignored)

Returns
	found (Boolean) - returns true if the text was matched by a pattern, false if it was unrecognized
	excluded (Boolean) - returns true if the text was excluded by a pattern, false if it was kept or unrecognized
	
This function is the core of LibStatLogic. It tries to pick apart a tooltip lime, and figure out what it means.
In order to do this it uses its library of localized "Patterns", each pattern describing a possible meaning of the line.
--]]
function StatLogic:ParseLine(table, text, r,g,b)
	assert(table, "StatLogic:ParseLine - table cannot be nil");
	assert(text, "StatLogic:ParseLine - text cannot be nil");
	
	--local excluded = true; --we'll assume everything was excluded, in case there are multiple stats on one line.

		-- Trim spaces
		text = strtrim(text)
		-- Strip color codes
		if strsub(text, -2) == "|r" then
			text = strsub(text, 1, -3)
		end
		if strfind(strsub(text, 1, 10), "|c%x%x%x%x%x%x%x%x") then
			text = strsub(text, 11)
		end
		
		--If a color was not specified, then force a color that won't be ignored
		if (r == nil) then r = 1; end;
		if (g == nil) then g = 1; end;
		if (b == nil) then b = 1; end;

		-----------------------
		-- Whole Text Lookup --
		-----------------------
		-- Mainly used for enchants or stuff without numbers:
		-- "Mithril Spurs"
		local found
		local idTable = L.WholeTextLookup[text]
		if idTable == false then
			found = true
			debugPrint("|cffadadad".."   WholeText Exclude: "..text)
		elseif idTable then
			found = true
			for id, value in pairs(L.WholeTextLookup[text]) do
				-- sum stat
				table[id] = (table[id] or 0) + CNumber(value);
				debugPrint("|cffff5959".."   WholeText: ".."|cffffc259"..text..", ".."|cffffff59"..tostring(id).."="..tostring(value))
			end
		end
		
		-- Fast Exclude --
		-- Exclude obvious strings that do not need to be checked, also exclude lines that are not white and green and normal (normal for Frozen Wrath bonus)
		-- Note: LUA has no "continue" statement; so we have to indent everything one extra needless level
		if not (found or L.Exclude[text] or StatLogic.ItemsNotRecognized[text] or L.Exclude[strutf8sub(text, 1, L.ExcludeLen)] or strsub(text, 1, 1) == '"' or g < 0.8 or (b < 0.99 and b > 0.1)) then
			--debugPrint(text.." = ")
			-- Strip enchant time
			-- ITEM_ENCHANT_TIME_LEFT_DAYS = "%s (%d day)";
			-- ITEM_ENCHANT_TIME_LEFT_DAYS_P1 = "%s (%d days)";
			-- ITEM_ENCHANT_TIME_LEFT_HOURS = "%s (%d hour)";
			-- ITEM_ENCHANT_TIME_LEFT_HOURS_P1 = "%s (%d hrs)";
			-- ITEM_ENCHANT_TIME_LEFT_MIN = "%s (%d min)"; -- Enchantment name, followed by the time left in minutes
			-- ITEM_ENCHANT_TIME_LEFT_SEC = "%s (%d sec)"; -- Enchantment name, followed by the time left in seconds
			--[[ 
			Seems temp enchants such as mana oil can't be seen from item links, so commented out
			if strfind(text, "%)") then
				debugPrint("test")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_DAYS, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_DAYS_P1, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_HOURS, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_HOURS_P1, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_MIN, "%%s ", ""), "%%", "%%%%"), "")
				text = gsub(text, gsub(gsub(ITEM_ENCHANT_TIME_LEFT_SEC, "%%s ", ""), "%%", "%%%%"), "")
			end
			--]]

			----------------------------
			-- Single Plus Stat Check --
			----------------------------
			-- depending on locale, L.SinglePlusStatCheck may be
			-- +19 Stamina = "^%+(%d+) ([%a ]+%a)$"
			-- Stamina +19 = "^([%a ]+%a) %+(%d+)$"
			-- +19 耐力 = "^%+(%d+) (.-)$"
			if not found then
				--With 5.1 adding reforge stats, we have to use captures 2 and 3, rather than 1 and 2.
				--local _, _, value, statText = strfind(strutf8lower(text), L.SinglePlusStatCheck)
				local firstMatch, value, statText = strmatch(strutf8lower(text), L.SinglePlusStatCheck);
				
				-- But because not all locales are using an updated SinglePlusStatCheck pattern yet we should do some compatibility check.
				if not statText then
					statText = value
					value = firstMatch
				end
				
				--print(strutf8lower(text))
				--print (L.SinglePlusStatCheck)
				--print(statText)
				if value then
					if tonumber(statText) then
						value, statText = statText, value
					end
					--print(statText)
					local idTable = L.StatIDLookup[statText]
					--print(L.StatIDLookup[SPELL_STATALL])
					if idTable == false then
						found = true
						debugPrint("|cffadadad".."   SinglePlus Exclude: "..text)
					elseif idTable then
						found = true
						local debugText = "|cffff5959".."   SinglePlus: ".."|cffffc259"..text
						local nValue = CNumber(value);
						for _, id in ipairs(idTable) do
							--debugPrint("  '"..value.."', '"..id.."'")
							-- sum stat
							table[id] = (table[id] or 0) + nValue;
							debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
						end
						debugPrint(debugText)
					else
						-- pattern match but not found in L.StatIDLookup, keep looking
						debugPrint("  SinglePlusStatCheck Lookup Fail: |cffffd4d4'"..statText.."'")
					end
				end
			end
			
			-----------------------------
			-- Single Equip Stat Check --
			-----------------------------
			-- depending on locale, L.SingleEquipStatCheck may be
			-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.$"
			if not found then
				local _, _, statText1, value, statText2 = strfind(text, L.SingleEquipStatCheck)
				if value then
					local statText = statText1..statText2
					local idTable = L.StatIDLookup[strutf8lower(statText)]
					if idTable == false then
						--We're excluding it because the value is *false*
						found = true
						debugPrint("|cffadadad".."   SingleEquip Exclude: "..text);
						return true, true; --found, excluded
					elseif idTable then
						found = true
						local debugText = "|cffff5959".."   SingleEquip: ".."|cffffc259"..text
						
						--Check that value is a valid number (e.g. 5,50 Schaden pro Sekunde)
						local nValue = CNumber(value);
						if nValue == nil then
							error(string.format("SingleEquip: Cannot convert value \"%s\" to a number. Line \"%s\"", value, text));
						end;
						
						for _, id in ipairs(idTable) do
							--debugPrint("  '"..value.."', '"..id.."'")
							-- sum stat
							table[id] = (table[id] or 0) + nValue;
							debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
						end
						debugPrint(debugText)
					else
						-- pattern match but not found in L.StatIDLookup, keep looking
						debugPrint("   SingleEquipStatCheck Lookup Fail: |cffffd4d4'"..statText.."'")
					end
				end
			end
			
			-- PreScan for special cases, that will fit wrongly into DeepScan
			-- PreScan also has exclude patterns
			-- This is where base armor gets scanned, check text color for bonus armor
			if not found then
				for pattern, id in pairs(L.PreScanPatterns) do
					local value
					found, _, value = strfind(text, pattern)
					if found then
						--found = true
						if id ~= false then
							local debugText = "|cffff5959".."   PreScan: ".."|cffffc259"..text
							--debugPrint("  '"..value.."' = '"..id.."'")
							-- check text color for bonus armor
							if id == "ARMOR" and r == 0 and b == 0 and
									baseArmorTable[rarity] and baseArmorTable[rarity][itemType] and
									baseArmorTable[rarity][itemType][armorType] and baseArmorTable[rarity][itemType][armorType][ilvl] and
									tonumber(value) > baseArmorTable[rarity][itemType][armorType][ilvl] then
								table["ARMOR"] = (table["ARMOR"] or 0) + baseArmorTable[rarity][itemType][armorType][ilvl]
								table["ARMOR_BONUS"] = (table["ARMOR_BONUS"] or 0) + CNumber(value) - baseArmorTable[rarity][itemType][armorType][ilvl]
								debugText = debugText..", ".."|cffffff59ARMOR="..baseArmorTable[rarity][itemType][armorType][ilvl]..", ARMOR_BONUS="..(CNumber(value) - baseArmorTable[rarity][itemType][armorType][ilvl])
							else
								-- sum stat
								table[id] = (table[id] or 0) + CNumber(value)
								debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
							end
							debugPrint(debugText);
							return true, false; --found, not excluded
						else
							debugPrint("|cffadadad".."   PreScan Exclude: "..text.."  ("..pattern..")");
							return true, true; --found, excluded
						end
						break; --not called, but just in case
					end
				end
			end
		
			--------------
			-- DeepScan --
			--------------
			--[[
			-- Strip trailing "."
			["."] = ".",
			["DeepScanSeparators"] = {
				"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
				" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
				", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
				"%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
			},
			["DeepScanWordSeparators"] = {
				" and ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
			},
			["DeepScanPatterns"] = {
				"^(.-) by u?p? ?t?o? ?(%d+) ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
				"^(.-) ?%+(%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
				"^(.-) ?([%d%.]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
			},
			--]]
			if not found then
				-- Get a local copy
				local text = text
				-- Strip leading "Equip: ", "Socket Bonus: "
				text = gsub(text, _G.ITEM_SPELL_TRIGGER_ONEQUIP, "") -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
				text = gsub(text, StripGlobalStrings(_G.ITEM_SOCKET_BONUS), "") -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
				-- Trim spaces
				text = strtrim(text)
				-- Strip trailing "."
				if strutf8sub(text, -1) == L["."] then
					text = strutf8sub(text, 1, -2)
				end

				-- Replace separators with @
				for _, sep in ipairs(L.DeepScanSeparators) do
					if strfind(text, sep) then
						-- if there is a capture, for deDE
						if strsub(sep, 1, 1) == "(" then
							text = gsub(text, sep, "%1@")
						else
							text = gsub(text, sep, "@")
						end
					end
				end
				
				-- Split text using @
				text = {strsplit("@", text)}
				for i, text in ipairs(text) do
					-- Trim spaces
					text = strtrim(text)
					-- Strip color codes
					if strsub(text, -2) == "|r" then
						text = strsub(text, 1, -3)
					end
					if strfind(strsub(text, 1, 10), "|c%x%x%x%x%x%x%x%x") then
						text = strsub(text, 11)
					end
					-- Strip trailing "."
					if strutf8sub(text, -1) == L["."] then
						text = strutf8sub(text, 1, -2)
					end
					debugPrint("|cff008080".."S"..i..": ".."'"..text.."'")
					
					-- Whole Text Lookup
					local foundWholeText = false
					local idTable = L.WholeTextLookup[text]
					if idTable == false then
						foundWholeText = true
						found = true
						debugPrint("|cffadadad".."  DeepScan WholeText Exclude: "..text)
					elseif idTable then
						foundWholeText = true
						found = true
						for id, value in pairs(L.WholeTextLookup[text]) do
							-- sum stat
							table[id] = (table[id] or 0) + CNumber(value);
							debugPrint("|cffff5959".."  DeepScan WholeText: ".."|cffffc259"..text..", ".."|cffffff59"..tostring(id).."="..tostring(value))
						end
						elseif L.Exclude[text] or L.Exclude[strutf8sub(text, 1, L.ExcludeLen)] then
							foundWholeText = true
							found = true
							debugPrint("|cffadadad".."  DeepScan Exclude: "..text)
							-- pattern match but not found in L.WholeTextLookup, keep looking
						end
						-- Scan DualStatPatterns
						if not foundWholeText then
							for pattern, dualStat in pairs(L.DualStatPatterns) do
								local lowered = strutf8lower(text)
								local _, dEnd, value1, value2 = strfind(lowered, pattern)
								if value1 and value2 then
									foundWholeText = true
									found = true
									local nValue1 = CNumber(value1);
									local nValue2 = CNumber(value2);
									local debugText = "|cffff5959".."  DeepScan DualStat: ".."|cffffc259"..text
									for _, id in ipairs(dualStat[1]) do
										--debugPrint("  '"..value.."', '"..id.."'")
										-- sum stat
										table[id] = (table[id] or 0) + nValue1;
										debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value1)
									end
									for _, id in ipairs(dualStat[2]) do
										--debugPrint("  '"..value.."', '"..id.."'")
										-- sum stat
										table[id] = (table[id] or 0) + nValue2;
										debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value2)
									end
									debugPrint(debugText)
									if dEnd ~= strlen(lowered) then
										foundWholeText = false
										text = strsub(text, dEnd + 1)
									end
									break
								end
							end
						end
						local foundDeepScan1 = false
						if not foundWholeText then
							local lowered = strutf8lower(text)
							-- Pattern scan
							for _, pattern in ipairs(L.DeepScanPatterns) do -- try all patterns in order
								local _, _, statText1, value, statText2 = strfind(lowered, pattern)
								if value then
									local statText = statText1..statText2
									local idTable = L.StatIDLookup[statText]
									if idTable == false then
										foundDeepScan1 = true
										found = true
										debugPrint("|cffadadad".."  DeepScan Exclude: "..text)
										break -- break out of pattern loop and go to the next separated text
									elseif idTable then
										foundDeepScan1 = true
										found = true
										local nValue = CNumber(value);
										local debugText = "|cffff5959".."  DeepScan: ".."|cffffc259"..text
										for _, id in ipairs(idTable) do
											--debugPrint("  '"..value.."', '"..id.."'")
											-- sum stat
											table[id] = (table[id] or 0) + nValue;
											debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
										end
										debugPrint(debugText)
										break -- break out of pattern loop and go to the next separated text
									else
										-- Not matching pattern
									end
								end
							end
						end
						-- If still not found, use the word separators to split the text
						if not foundWholeText and not foundDeepScan1 then
						-- Replace separators with @
						for _, sep in ipairs(L.DeepScanWordSeparators) do
							if strfind(text, sep) then
								text = gsub(text, sep, "@")
							end
						end
						-- Split text using @
						text = {strsplit("@", text)}
						for j, text in ipairs(text) do
							-- Trim spaces
							text = strtrim(text)
							-- Strip color codes
							if strsub(text, -2) == "|r" then
								text = strsub(text, 1, -3)
							end
							if strfind(strsub(text, 1, 10), "|c%x%x%x%x%x%x%x%x") then
								text = strsub(text, 11)
							end
							-- Strip trailing "."
							if strutf8sub(text, -1) == L["."] then
								text = strutf8sub(text, 1, -2)
							end
							debugPrint("|cff008080".."S"..i.."-"..j..": ".."'"..text.."'")
							-- Whole Text Lookup
							local foundWholeText = false
							local idTable = L.WholeTextLookup[text]
							if idTable == false then
								foundWholeText = true
								found = true
								debugPrint("|cffadadad".."  DeepScan2 WholeText Exclude: "..text)
							elseif idTable then
								foundWholeText = true
								found = true
								for id, value in pairs(L.WholeTextLookup[text]) do
									-- sum stat
									table[id] = (table[id] or 0) + value
									debugPrint("|cffff5959".."  DeepScan2 WholeText: ".."|cffffc259"..text..", ".."|cffffff59"..tostring(id).."="..tostring(value))
								end
							else
								-- pattern match but not found in L.WholeTextLookup, keep looking
							end
							
							-- Scan DualStatPatterns
							if not foundWholeText then
								for pattern, dualStat in pairs(L.DualStatPatterns) do
									local lowered = strutf8lower(text)
									local _, _, value1, value2 = strfind(lowered, pattern)
									if value1 and value2 then
										foundWholeText = true
										found = true
										local debugText = "|cffff5959".."  DeepScan2 DualStat: ".."|cffffc259"..text
										
										local nValue1 = CNumber(value1);
										local nValue2 = CNumber(value2);
										
										for _, id in ipairs(dualStat[1]) do
											--debugPrint("  '"..value.."', '"..id.."'")
											-- sum stat
											table[id] = (table[id] or 0) + nValue1;
											debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value1)
										end
										for _, id in ipairs(dualStat[2]) do
											--debugPrint("  '"..value.."', '"..id.."'")
											-- sum stat
											table[id] = (table[id] or 0) + nValue2;
											debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value2)
										end
										debugPrint(debugText)
										break
									end
								end
							end
							local foundDeepScan2 = false
							if not foundWholeText then
								local lowered = strutf8lower(text)
								-- Pattern scan
								for _, pattern in ipairs(L.DeepScanPatterns) do
									local _, _, statText1, value, statText2 = strfind(lowered, pattern)
									if value then
										local statText;

										--[[
											e.g. Inscription of the Earth Prince (SpellID 86402)
									
											Tearing apart an double enchant line, e.g.:
												Enchanted: +195 Stamina and +25 Dodge
											the deep scan will split it into:
												Enchanted: +300 Stamina
												+120 Strength
											and then further into process the first line into
												Enchanted:Stamina

											Strip off the word "Enchanted:" from statText1 if it actually is "Enchanted:"
										
											The first thing to do is get the string "Enchanted:" from the localized globalstring 
												ENCHANTED_TOOLTIP_LINE = "Enchanted: %s"
										--]]
										local SEnchantedTooltipPrefix = ENCHANTED_TOOLTIP_LINE:gsub("(%%s)", ""):lower():trim(); --"Enchanted:"
										if (statText1 == SEnchantedTooltipPrefix) then
											statText = statText2;
										else
											statText = statText1..statText2;
										end;
											
										local idTable = L.StatIDLookup[statText]
										--print(statText.."/"..pattern)
										if idTable == false then
											foundDeepScan2 = true
											found = true
											debugPrint("|cffadadad".."  DeepScan2 Exclude: "..text.." (Pattern: "..pattern..")")
											break
										elseif idTable then
											foundDeepScan2 = true
											found = true
											local nValue = CNumber(value);
											
											local debugText = "|cffff5959".."  DeepScan2: ".."|cffffc259"..text
											for _, id in ipairs(idTable) do
												--debugPrint("  '"..value.."', '"..id.."'")
												-- sum stat
												table[id] = (table[id] or 0) + nValue;
												debugText = debugText..", ".."|cffffff59"..tostring(id).."="..tostring(value)
											end
											debugPrint(debugText.." (Pattern: "..pattern..")");
											break
										else
											-- pattern match but not found in L.StatIDLookup, keep looking
											debugPrint("  DeepScan2 Lookup Fail: |cffffd4d4'"..statText.."'|r, pattern = |cff72ff59'"..pattern.."'")
										end
									end
								end -- for
							end
							if not foundWholeText and not foundDeepScan2 then
								debugPrint("  DeepScan2 Fail: |cffff0000'"..text.."'")
							end
						end
					end -- if not foundWholeText and not foundDeepScan1 then
				end
			end
	
			if not found then
				--We now use ItemsNotRecognized as a "learned" list of items to exclude.
				--local notFoundCount = (StatLogic.ItemsNotRecognized[text] or 0) +1;
				StatLogic.ItemsNotRecognized[text] = false; --notFoundCount;
	
				if (_itemNotRecognizedWarning) or DEBUG then
					local s = ORANGE_FONT_COLOR_CODE.."LibStatLogic"..FONT_COLOR_CODE_CLOSE..": No Match for \""..RED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE.."\"";
					
					--If warnings were enabled by default (i.e. they have no idea how to turn them off), tell them how to turn them off
					if ItemNotRecognizedWarningDefault == true then
						s = s.." Warnings can be disabled by typing"..YELLOW_FONT_COLOR_CODE.." /slwarning"..FONT_COLOR_CODE_CLOSE;
					end;
					
					print(s);
				end;
				
				--print("LibStatLogic: No match for |cffff0000'"..text.."' on "..link);
				-- if DEBUG and RatingBuster then
				--		RatingBuster.db.profile.test = text
				--	end
				return false, false; --not found, not excluded
			end
			
			return true, false; --found, not excluded
		else
			--line was fast excluded
			--debugPrint("   Excluded: "..text); --it's helpful when debugging to see if an item's property was ignored - even if it is spammy
			return true, true; --found, excluded
		end
end

function StatLogic:GetFinalArmor(item, text)
	-- Locale check
	if noPatternLocale then return end
	local _
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then -- common case first
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return end
	else
		return
	end
	-- Check if item is in local cache
	local name, _, rarity , ilvl, _, _, armorType, _, itemType = GetItemInfo(item)
	if not name then return end

	for pattern, id in pairs(L.PreScanPatterns) do
		if id == "ARMOR" or id == "ARMOR_BONUS" then
			local found, _, value = strfind(text, pattern)
			if found then
				local armor = 0
				local bonus_armor = 0
				if id == "ARMOR" and baseArmorTable[rarity] and baseArmorTable[rarity][itemType] and
						baseArmorTable[rarity][itemType][armorType] and baseArmorTable[rarity][itemType][armorType][ilvl] and
						tonumber(value) > baseArmorTable[rarity][itemType][armorType][ilvl] then
					armor = baseArmorTable[rarity][itemType][armorType][ilvl]
					bonus_armor = tonumber(value) - baseArmorTable[rarity][itemType][armorType][ilvl]
				else
					armor = tonumber(value)
				end
				if bonusArmorItemEquipLoc[itemType] then
					bonus_armor = bonus_armor + armor
					armor = 0
				end
				return armor * self:GetStatMod("MOD_ARMOR") + bonus_armor
			end
		end
	end
end

--[[---------------------------------
  :GetDiffID(item, [ignoreEnchant], [ignoreGem], [red], [yellow], [blue], [meta], [ignorePris])
-------------------------------------
Notes:
  * Returns a unique identification string of the diff calculation, the identification string is made up of links concatenated together, can be used for cache indexing
  * item:
  :;tooltip : table - The tooltip showing the item
  :;itemId : number - The numeric ID of the item. e.g. 12345
  :;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
  :::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
  :;"itemName" : string - The Name of the Item, ex: "Hearthstone"
  :::The item must have been equiped, in your bags or in your bank once in this session for this to work.
  :;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
  number or string or table - tooltip or itemId or "itemString" or "itemName" or "itemLink"
  boolean - Ignore enchants when calculating the id if true
  boolean - Ignore gems when calculating the id if true
  number or string - gemID to replace a red socket
  number or string - gemID to replace a yellow socket
  number or string - gemID to replace a blue socket
  number or string - gemID to replace a meta socket
  boolean - Ignore prismatic sockets when calculating the id if true
Returns:
  ; id : string - a unique identification string of the diff calculation, for use as cache key
  ; link : string - link of main item
  ; linkDiff1 : string - link of compare item 1
  ; linkDiff2 : string - link of compare item 2
Example:
  StatLogic:GetDiffID(21417) -- Ring of Unspoken Names
  StatLogic:GetDiffID("item:18832:2564:0:0:0:0:0:0", true, true) -- Brutality Blade with +15 agi enchant
  http://www.wowwiki.com/EnchantId
-----------------------------------]]

local getSlotID = {
	INVTYPE_AMMO           = 0,-- No longer in game
	INVTYPE_GUNPROJECTILE  = 0,-- No longer in game
	INVTYPE_BOWPROJECTILE  = 0,-- No longer in game
	INVTYPE_HEAD           = GetInventorySlotInfo("HeadSlot"),
	INVTYPE_NECK           = GetInventorySlotInfo("NeckSlot"),
	INVTYPE_SHOULDER       = GetInventorySlotInfo("ShoulderSlot"),
	INVTYPE_BODY           = GetInventorySlotInfo("ShirtSlot"),
	INVTYPE_CHEST          = GetInventorySlotInfo("ChestSlot"),
	INVTYPE_ROBE           = GetInventorySlotInfo("ChestSlot"),
	INVTYPE_WAIST          = GetInventorySlotInfo("WaistSlot"),
	INVTYPE_LEGS           = GetInventorySlotInfo("LegsSlot"),
	INVTYPE_FEET           = GetInventorySlotInfo("FeetSlot"),
	INVTYPE_WRIST          = GetInventorySlotInfo("WristSlot"),
	INVTYPE_HAND           = GetInventorySlotInfo("HandsSlot"),
	INVTYPE_FINGER         = {GetInventorySlotInfo("Finger0Slot"), GetInventorySlotInfo("Finger1Slot"),},
	INVTYPE_TRINKET        = {GetInventorySlotInfo("Trinket0Slot"), GetInventorySlotInfo("Trinket1Slot")},
	INVTYPE_CLOAK          = GetInventorySlotInfo("BackSlot"),
	INVTYPE_WEAPON         = {GetInventorySlotInfo("MainHandSlot"),GetInventorySlotInfo("SecondaryHandSlot"),},
	INVTYPE_2HWEAPON       = GetInventorySlotInfo("MainHandSlot")+GetInventorySlotInfo("SecondaryHandSlot"),
	INVTYPE_WEAPONMAINHAND = GetInventorySlotInfo("MainHandSlot"),
	INVTYPE_WEAPONOFFHAND  = GetInventorySlotInfo("SecondaryHandSlot"),
	INVTYPE_SHIELD         = GetInventorySlotInfo("SecondaryHandSlot"),
	INVTYPE_HOLDABLE       = GetInventorySlotInfo("SecondaryHandSlot"),
	INVTYPE_RANGED         = GetInventorySlotInfo("MainHandSlot"),
	INVTYPE_RANGEDRIGHT    = GetInventorySlotInfo("MainHandSlot"),
	INVTYPE_RELIC          = 0,-- No longer in game
	INVTYPE_GUN            = GetInventorySlotInfo("MainHandSlot"),
	INVTYPE_CROSSBOW       = GetInventorySlotInfo("MainHandSlot"),
	INVTYPE_WAND           = GetInventorySlotInfo("MainHandSlot"),
	INVTYPE_THROWN         = 0, -- No longer in game
	INVTYPE_TABARD         = GetInventorySlotInfo("TabardSlot"),
}

local function HasTitanGrip(talentGroup)
	--Updated to 5.0.5 
	if playerClass == "WARRIOR" then
		if  (GetSpecialization() == 2) and IsSpellKnown(46917) then  --Fury spec and knows Titan Grip
			return true
		else
			return false
		end
	end
end

function StatLogic:GetDiffID(item, ignoreEnchant, ignoreGem, red, yellow, blue, meta, ignorePris)
	local _, name, itemType, link, linkDiff1, linkDiff2
	-- Check item
	if (type(item) == "string") or (type(item) == "number") then
	elseif type(item) == "table" and type(item.GetItem) == "function" then
		-- Get the link
		_, item = item:GetItem()
		if type(item) ~= "string" then return end
	else
		return
	end
	-- Check if item is in local cache
	name, link, _, _, _, _, _, _, itemType = GetItemInfo(item)
	if not name then return end
	-- Get equip location slot id for use in GetInventoryItemLink
	local slotID = getSlotID[itemType]
	-- Don't do bags
	if not slotID then return end

	-- 1h weapon, check if player can dual wield, check for 2h equipped
	if itemType == "INVTYPE_WEAPON" then
		linkDiff1 = GetInventoryItemLink("player", 16) or "NOITEM"
		-- If player can Dual Wield, calculate offhand difference
		if IsUsableSpell(GetSpellInfo(674)) then        -- ["Dual Wield"]
			local _, _, _, _, _, _, _, _, eqItemType = GetItemInfo(linkDiff1)
			-- If 2h is equipped, copy diff1 to diff2
			if eqItemType == "INVTYPE_2HWEAPON" and not HasTitanGrip() then
				linkDiff2 = linkDiff1
			else
				linkDiff2 = GetInventoryItemLink("player", 17) or "NOITEM"
			end
		end
	-- Ring or trinket
	elseif type(slotID) == "table" then
		-- Get slot link
		linkDiff1 = GetInventoryItemLink("player", slotID[1]) or "NOITEM"
		linkDiff2 = GetInventoryItemLink("player", slotID[2]) or "NOITEM"
		-- 2h weapon, so we calculate the difference with equipped main hand and off hand
	elseif itemType == "INVTYPE_2HWEAPON" then
		linkDiff1 = GetInventoryItemLink("player", 16) or "NOITEM"
		linkDiff2= GetInventoryItemLink("player", 17) or "NOITEM"
		-- Off hand slot, check if we have 2h equipped
	elseif slotID == 17 then
		linkDiff1 = GetInventoryItemLink("player", 16) or "NOITEM"
		-- If 2h is equipped
		local _, _, _, _, _, _, _, _, eqItemType = GetItemInfo(linkDiff1)
		if eqItemType ~= "INVTYPE_2HWEAPON" then
			linkDiff1 = GetInventoryItemLink("player", 17) or "NOITEM"
		end
		-- Single slot item
	else
		linkDiff1 = GetInventoryItemLink("player", slotID) or "NOITEM"
	end

	-- Ignore Enchants
	if ignoreEnchant then
		link = self:RemoveEnchant(link)
		linkDiff1 = self:RemoveEnchant(linkDiff1)
		if linkDiff2 then
			linkDiff2 = self:RemoveEnchant(linkDiff2)
		end
	end
	if ignorePris then
		link = self:RemoveExtraSocketGem(link)
		linkDiff1 = self:RemoveExtraSocketGem(linkDiff1)
		if linkDiff2 then
			linkDiff2 = self:RemoveExtraSocketGem(linkDiff2)
		end
	end
	
	-- Ignore Gems
	if ignoreGem then
		link = self:RemoveGem(link)
		linkDiff1 = self:RemoveGem(linkDiff1)
		if linkDiff2 then
			linkDiff2 = self:RemoveGem(linkDiff2)
		end
	else
		link = self:BuildGemmedTooltip(link, red, yellow, blue, meta)
		linkDiff1 = self:BuildGemmedTooltip(linkDiff1, red, yellow, blue, meta)
		if linkDiff2 then
			linkDiff2 = self:BuildGemmedTooltip(linkDiff2, red, yellow, blue, meta)
		end
	end

	-- Build ID string
	local id = link..linkDiff1
	if linkDiff2 then
		id = id..linkDiff2
	end

	return id, link, linkDiff1, linkDiff2
end


--[[---------------------------------
  :GetDiff(item, [diff1], [diff2], [ignoreEnchant], [ignoreGem], [red], [yellow], [blue], [meta], [ignorePris])
-------------------------------------
Notes:
  * Calculates the stat diffrence from the specified item and your currently equipped items.
  * item:
  :;tooltip : table - The tooltip showing the item
  :;itemId : number - The numeric ID of the item. ie. 12345
  :;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
  :::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
  :;"itemName" : string - The Name of the Item, ex: "Hearthstone"
  :::The item must have been equiped, in your bags or in your bank once in this session for this to work.
  :;"itemLink" : string - The itemLink, when Shift-Clicking items.
Arguments:
  number or string or table - tooltip or itemId or "itemString" or "itemName" or "itemLink"
  table - Stat difference of item and equipped item 1 are writen to this table if provided
  table - Stat difference of item and equipped item 2 are writen to this table if provided
  boolean - Ignore enchants when calculating stat diffrences
  boolean - Ignore gems when calculating stat diffrences
  number or string - gemID to replace a red socket
  number or string - gemID to replace a yellow socket
  number or string - gemID to replace a blue socket
  number or string - gemID to replace a meta socket
  boolean - Ignore prismatic sockets when calculating the id if true
Returns:
  ; diff1 : table - The table with stat diff values for item 1
  :{
  ::    ["STAT_ID1"] = value,
  ::    ["STAT_ID2"] = value,
  :}
  ; diff2 : table - The table with stat diff values for item 2
  :{
  ::    ["STAT_ID1"] = value,
  ::    ["STAT_ID2"] = value,
  :}
Example:
  StatLogic:GetDiff(21417, {}) -- Ring of Unspoken Names
  StatLogic:GetDiff(21452) -- Staff of the Ruins
-----------------------------------]]

-- TODO 2.1.0: Use SetHyperlinkCompareItem in StatLogic:GetDiff
function StatLogic:GetDiff(item, diff1, diff2, ignoreEnchant, ignoreGem, red, yellow, blue, meta, ignorePris)
    debugPrint("StatLogic:GetDiff");
    --debugPrint("    item="..item)

	-- Locale check
	if noPatternLocale then return end

	-- Get DiffID
	local id, link, linkDiff1, linkDiff2 = self:GetDiffID(item, ignoreEnchant, ignoreGem, red, yellow, blue, meta, ignorePris)
	if not id then return end

	-- Clear Tables
	clearTable(diff1)
	clearTable(diff2)

	-- Get diff data from cache if available
	if cache[id..1] then
		copyTable(diff1, cache[id..1])
		if cache[id..2] then
			copyTable(diff2, cache[id..2])
		end
		return diff1, diff2
	end

	-- Get item sum, results are written into diff1 table
	local itemSum = self:GetSum(link)
	if not itemSum then return end
	local itemType = itemSum.itemType

	if itemType == "INVTYPE_2HWEAPON" and not HasTitanGrip() then
		local equippedSum1, equippedSum2
		-- Get main hand item sum
		if linkDiff1 == "NOITEM" then
			equippedSum1 = newStatTable()
		else
			equippedSum1 = self:GetSum(linkDiff1)
		end
		-- Get off hand item sum
		if linkDiff2 == "NOITEM" then
			equippedSum2 = newStatTable()
		else
			equippedSum2 = self:GetSum(linkDiff2)
		end
		-- Calculate diff
		diff1 = copyTable(diff1, itemSum) - equippedSum1 - equippedSum2
		-- Return table to pool
		del(equippedSum1)
		del(equippedSum2)
	else
		local equippedSum
		-- Get equipped item 1 sum
		if linkDiff1 == "NOITEM" then
			equippedSum = newStatTable()
		else
			equippedSum = self:GetSum(linkDiff1)
		end
		-- Calculate item 1 diff
		diff1 = copyTable(diff1, itemSum) - equippedSum
		-- Clean up
		del(equippedSum)
		equippedSum = nil
		-- Check if item has a second equip slot
		if linkDiff2 then -- If so
			-- Get equipped item 2 sum
			if linkDiff2 == "NOITEM" then
				equippedSum = newStatTable()
			else
				equippedSum = self:GetSum(linkDiff2)
			end
			-- Calculate item 2 diff
			diff2 = copyTable(diff2, itemSum) - equippedSum
			-- Clean up
			del(equippedSum)
		end
	end
	-- Return itemSum table to pool
	del(itemSum)
	-- Write cache
	copyTable(cache[id..1], diff1)
	if diff2 then
		copyTable(cache[id..2], diff2)
	end
	-- return tables
	return diff1, diff2
end


-----------
-- DEBUG --
-----------
-- StatLogic:Bench(1000)
---------
-- self:GetSum(link, table)
-- 1000 times: 0.6 sec without cache
-- 1000 times: 0.012 sec with cache
---------
-- ItemBonusLib:ScanItemLink(link)
-- 1000 times: 1.58 sec
---------
-- LibItemBonus:ScanItem(link, true)
-- 1000 times: 0.72 sec without cache
-- 1000 times: 0.009 sec with cache
---------
--[[
LoadAddOn("LibItemBonus-2.0")
local LibItemBonus = LibStub("LibItemBonus-2.0")
-- #NODOC
function StatLogic:Bench(k)
  DEFAULT_CHAT_FRAME:AddMessage("test")
  local t = GetTime()
  local link = GetInventoryItemLink("player", 12)
  local table = {}
  --local GetItemInfo = _G["GetItemInfo"]
  for i = 1, k do
    ---------------------------------------------------------------------------
    --self:SplitDoJoin("+24 Agility/+4 Stamina, +4 Dodge and +4 Spell Crit/+5 Spirit", {"/", " and ", ","})
    ---------------------------------------------------------------------------
    self:GetSum(link)
    --LibItemBonus:ScanItemLink(link)
    ---------------------------------------------------------------------------
    --ItemRefTooltip:SetScript("OnTooltipSetItem", function(frame, ...) RatingBuster:Print("OnTooltipSetItem") end)
    ---------------------------------------------------------------------------
    --GetItemInfo(link)
  end
  DEFAULT_CHAT_FRAME:AddMessage(GetTime() - t)
  t = GetTime()
  for i = 1, k do
    LibItemBonus:ScanItem(link, true)
  end
  DEFAULT_CHAT_FRAME:AddMessage(GetTime() - t)
  --return GetTime() - t1
end
--]]
--[[
-- #NODOC
function StatLogic:PatternTest()
  patternTable = {
    "(%a[%a ]+%a) ?%d* ?%a* by u?p? ?t?o? ?(%d+) ?a?n?d? ?", -- xxx xxx by 22 (scan first)
    "(%a[%a ]+) %+(%d+) ?a?n?d? ?", -- xxx xxx +22 (scan 2ed)
    "(%d+) ([%a ]+) ?a?n?d? ?", -- 22 xxx xxx (scan last)
  }
  textTable = {
    "Spell Damage +6 and Spell Hit Rating +5",
    "+3 Stamina, +4 Critical Strike Rating",
    "+26 Healing Spells & 2% Reduced Threat",
    "+3 Stamina/+4 Critical Strike Rating",
    "Socket Bonus: 2 mana per 5 sec.",
    "Equip: Increases damage and healing done by magical spells and effects by up to 150.",
    "Equip: Increases the spell critical strike rating of all party members within 30 yards by 28.",
    "Equip: Increases damage and healing done by magical spells and effects of all party members within 30 yards by up to 33.",
    "Equip: Increases healing done by magical spells and effects of all party members within 30 yards by up to 62.",
    "Equip: Increases your spell damage by up to 120 and your healing by up to 300.",
    "Equip: Restores 11 mana per 5 seconds to all party members within 30 yards.",
    "Equip: Increases healing done by spells and effects by up to 300.",
    "Equip: Increases attack power by 420 in Cat, Bear, Dire Bear, and Moonkin forms only.",
  }
  for _, text in ipairs(textTable) do
    DEFAULT_CHAT_FRAME:AddMessage(text.." = ")
    for _, pattern in ipairs(patternTable) do
      local found
      for k, v in gmatch(text, pattern) do
        found = true
        DEFAULT_CHAT_FRAME:AddMessage("  '"..k.."', '"..v.."'")
      end
      if found then
        DEFAULT_CHAT_FRAME:AddMessage("  using: "..pattern)
        DEFAULT_CHAT_FRAME:AddMessage("----------------------------")
        break
      end
    end
  end
end
--]]

-- for debugging
_G.StatLogic = StatLogic

----------------------
-- API doc template --
----------------------
--[[---------------------------------
  :SetTip(item)
-------------------------------------
Notes:
  * This is a debugging tool for localizers
  * Displays item in ItemRefTooltip
  * item:
  :;itemId : number - The numeric ID of the item. ie. 12345
  :;"itemString" : string - The full item ID in string format, e.g. "item:12345:0:0:0:0:0:0:0".
  :::Also supports partial itemStrings, by filling up any missing ":x" value with ":0", e.g. "item:12345:0:0:0"
  :;"itemName" : string - The Name of the Item, ex: "Hearthstone"
  :::The item must have been equiped, in your bags or in your bank once in this session for this to work.
  :;"itemLink" : string - The itemLink, when Shift-Clicking items.
  * Converts ClassID to and from "ClassName"
  * class:
  :{| class="wikitable"
  !ClassID!!"ClassName"
  |-
  |1||"WARRIOR"
  |-
  |2||"PALADIN"
  |-
  |3||"HUNTER"
  |-
  |4||"ROGUE"
  |-
  |5||"PRIEST"
  |-
  |6||"DEATHKNIGHT"
  |-
  |7||"SHAMAN"
  |-
  |8||"MAGE"
  |-
  |9||"WARLOCK"
  |-
  |10||"DRUID"
  |}
Arguments:
  number or string - itemId or "itemString" or "itemName" or "itemLink"
  [optional] string - Armor value. Default: player's armor value
  [optional] number - Attacker level. Default: player's level
  [optional] string or number - ClassID or "ClassName". Default: PlayerClass<br>See :GetClassIdOrName(class) for valid class values.
Returns:
  ; modParry : number - The part that is affected by diminishing returns.
  ; drFreeParry : number - The part that isn't affected by diminishing returns.
Example:
  StatLogic:SetTip("item:3185:0:0:0:0:0:1957")
-----------------------------------]]


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
if (WoWUnit) then

local function checkEquals(expected, actual, message)
	--print("LibStatLogic:checkEquals");
	--print("1-->expected: "..(expected or "nil"));
	--print("1-->actual: "..(actual or "nil"));
	--print("1-->message: "..(message or "nil"));
	
	return WoWUnit.CheckEquals(expected, actual, message);
end;

local LibStatLogicTests = {

	mocks = {
		UnitName = function(arg)
			return "Soandso";
		end;
	};
	
	setUp = function()
		return {};
	end;
	tearDown = function()
		-- no tear down required
	end;
	
	testExample = function()
		assert(UnitName("player") == "Soandso", "Expected player name to be 'Soandso'");
	end;
	
	--testFailure = function()
	--	assert(UnitName("player") == "Feithar", "Expected player name to be 'Feithar'");
	--end;
	
	testToNumber = function()
		checkEquals(1, tonumber("1"));
		checkEquals(12, tonumber("12"));
		checkEquals(123, tonumber("123"));
		checkEquals(1234, tonumber("1234"));
		checkEquals(12345, tonumber("12345"));
		checkEquals(123456, tonumber("123456"));
		checkEquals(1234567, tonumber("1234567"));
		checkEquals(12345678, tonumber("12345678"));
		checkEquals(123456789, tonumber("123456789"));
		checkEquals(1234567890, tonumber("1234567890"));
		checkEquals(12345678901, tonumber("12345678901"));
		checkEquals(123456789012, tonumber("123456789012"));
	end;

	testCNumber = function()
		--[[
			Check our localization aware StringToNumber function, CNumber, works
		--]]
		local s = "1234";
		local n = CNumber(s);
		checkEquals(1234, n, s);
		
		s = "1,234";
		n = CNumber(s);
		checkEquals(1234, n, s);
		
		s = "1,234,567";
		n = CNumber(s);
		checkEquals(1234567, n, s);
	end;
	
	testCNumberTrillions = function()
		local s = "1,234,567,890";
		local n = CNumber(s);
		checkEquals(1234567890, n, s);
	end;
	
	testLocalizationToNumber = function()
		--[[
			We replace the localization aware tonumber funtion with our CNumber implementation.
			Make sure L.tonumber(string) works as expected with DigitGroupingSeparators, and DecimalMarkSeparator
		--]]
		local s = "1234";
		local n = L.tonumber(s);
		checkEquals(1234, n, s);
	
		s = "1,234";
		n = L.tonumber(s);
		checkEquals(1234, n, s);
		
		s = "1,234,567,890";
		n = L.tonumber(s);
		checkEquals(1234567890, n, s);
		
		s = "1,234.5678";
		n = L.tonumber(s);
		checkEquals(1234.5678, n, s);
	
	end;
	
	testIntegerPattern = function()
		--[[
			A basic test/example of LUA's pseudo-regular expression system.
			Strictly speaking it is not RegEx, and they don't pretend it is. They call it pattern matching.
		--]]
		local _, _, value = strfind("1,234 Armor", "^(%d+[,%d]*) Armor$");
		
		checkEquals("1,234", value);
	end;

	testIntegerNumberPattern = function()
		--[[
			L.patNumber is the localized pattern for finding a number.
			In this case a "number" is a whole number; no decimals. 
			For decimals use L.patDecimal, which is a decimal number localized pattern
		--]]
		local s = "Something before 1,234,567,890 something after";
		local pattern = "("..(L.patNumber)..")";
		local _, _, value = strfind(s, pattern);
		--print("value = "..(value or "nil"));
		
		checkEquals("1,234,567,890", value, "string from string: "..s..", Pattern: "..pattern);	
		checkEquals(1234567890, CNumber(value), "Number from string: "..s..", Pattern: "..pattern);
	end;
	
	testDecimalNumberPattern = function()
		--[[
			L.patDecimal is the localized pattern for finding a decimal number
			In this case a "decimal" number can have a fractional part.
			For whole numbers only use L.patNumber, which is an integer number localized pattern
		--]]
		local s = "Something before 1,234,567,890.123456 something after";
		local _, _, value = strfind(s, "("..L.patDecimal..")");
		checkEquals("1,234,567,890.123456", value);	
		checkEquals(1234567890.123456, CNumber(value));
	end;		
	
	testSinglePlusStatCheck = function()
		-- depending on locale, it may be
		-- +19 Stamina = "^%+(patNumber) (.-)%.?$"
		-- Stamina +19 = "^(.-) %+(patNumber)%.?$"
		-- +19 耐力 = "^%+(patNumber) (.-)%.?$"
		-- Some have a "." at the end of string like:
		-- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec. "
		local text = "+1,234 Stamina";
		
		local _, value, statText, reforgedFrom = string.match(strutf8lower(text), L.SinglePlusStatCheck);
		
		checkEquals("+1,234", value, L.SinglePlusStatCheck);
		checkEquals("stamina", statText, L.SinglePlusStatCheck);
		checkEquals(1234, CNumber(value), L.SinglePlusStatCheck);

		text = "+6 mana every 5 sec."
		local _, value, statText, reforgedFrom = string.match(strutf8lower(text), L.SinglePlusStatCheck);
		
		checkEquals("+6", value, text);
		checkEquals("mana every 5 sec", statText, text);
		checkEquals(6, CNumber(value), text);
	end;

	testSingleEquipStatCheck = function()
		-- "^Equip: (.-) by u?p? ?t?o? ?("..patNumber..") ?(.-)%.?$"
		--Equip: Increases your dodge by 172.
		
		local text = "Equip: Increases your dodge by 172.";
	
		local _, _, stat, value = strfind(text, L.SingleEquipStatCheck);
		checkEquals("Increases your dodge", stat);
		checkEquals("172", value);
		checkEquals(172, CNumber(value));
		
		local text = "Equip: Increases your dodge by 1,172.";
		local _, _, stat, value = strfind(text, L.SingleEquipStatCheck);
		checkEquals("Increases your dodge", stat);
		checkEquals("1,172", value);
		checkEquals(1172, CNumber(value));
	end;
	
	testGetAvoidanceAfterDR = function()
			--[[
				avoidanceAfterDR = GetAvoidanceAfterDR(avoidanceType, avoidanceBeforeDR[, class])		
				
				avoidanceType: 	"DODGE", "PARRY", "MELEE_HIT_AVOID"
				avoidanceBeforeDR: let's use 0, since that's what http://www.wowace.com/addons/libstatlogic-1-2/tickets/16-division-by-zero-on-ptr-4-3/ is experiencing
				class: was "6" a guy said
			--]]
			local n;
			
			n = StatLogic:GetAvoidanceAfterDR("DODGE", 0, CLASSID_DEATHKNIGHT);
			n = StatLogic:GetAvoidanceAfterDR("PARRY", 0, CLASSID_DEATHKNIGHT);
			n = StatLogic:GetAvoidanceAfterDR("MELEE_HIT_AVOID", 0, CLASSID_DEATHKNIGHT);
	end;

	testGetAvoidanceAfterDR_DivisionByZerosForAllClasses = function()
			--[[
				avoidanceAfterDR = GetAvoidanceAfterDR(avoidanceType, avoidanceBeforeDR[, class])		
				
				avoidanceType: 	"DODGE", "PARRY", "MELEE_HIT_AVOID"
				avoidanceBeforeDR: let's use 0, since that's what http://www.wowace.com/addons/libstatlogic-1-2/tickets/16-division-by-zero-on-ptr-4-3/ is experiencing
				class: iterate all classes
			--]]
			local n;
			
			local classID;
			for classID = CLASSID_WARRIOR, CLASSID_MAX do
				StatLogic:GetAvoidanceAfterDR("DODGE", 0, CLASSID_DEATHKNIGHT);
				StatLogic:GetAvoidanceAfterDR("PARRY", 0, CLASSID_DEATHKNIGHT);
				StatLogic:GetAvoidanceAfterDR("MELEE_HIT_AVOID", 0, CLASSID_DEATHKNIGHT);
			end;
	end;
	
	testGetEffectFromRating_DivisionByZero = function()
		--[[function StatLogic:GetEffectFromRating(rating, id, level, class)
		--]]

		local rating = 500; --a nice rount, non-zero, number to test with

		StatLogic:GetEffectFromRating(rating, CR_PARRY, 86, CLASSID_DEATHKNIGHT); 
		
		StatLogic:GetEffectFromRating(rating, COMBAT_RATING_RESILIENCE_CRIT_TAKEN, 86, CLASSID_DEATHKNIGHT); 
		
		local nCombatRatingID;
		for nCombatRatingID = 1, CR_MAX do
			StatLogic:GetEffectFromRating(rating, nCombatRatingID, 86, CLASSID_DEATHKNIGHT); 
		end;
	
	end;
	
	
	testGetReductionFromArmor = function()
		--StatLogic:GetReductionFromArmor(armor, attackerLevel)
		local dr; --damageReduction
		dr = StatLogic:GetReductionFromArmor(0, 85);
		checkEquals(dr, 0);
		
		dr = StatLogic:GetReductionFromArmor(1000000, 90);
		checkEquals(dr, 0.75); --a million armor probably enough to now, and forever, hit the 75% cap
	end;
	
	testGetEffectFromRating_TakesCombatRatingIDorString = function()
		local rating = 600;
		local effectByNumber = StatLogic:GetEffectFromRating(rating, CR_PARRY, 85, CLASSID_DEATHKNIGHT); 
		local effectByName = StatLogic:GetEffectFromRating(rating, "PARRY_RATING", 85, CLASSID_DEATHKNIGHT);

		--print(string.format("Effect by Number: %s", effectByNumber));
		--print(string.format("Effect by Name: %s", effectByName));
		
		assert(math.abs(effectByNumber - effectByName) < 0.0001, "GetEffectFromRating should be same whether by CR_PARRY or \"PARRY_RATING\"");
	end;
	
	testProcessWeaponDamage = function()
		local damagePattern = "^%+?"..L.patDecimal.." %- ("..L.patDecimal..") .-Damage$";
		
		local text = "2,397 - 4,454 Damage";

		--local patNumber = "%d+[,%d]*";
		--/dump strfind("2,397 - 4,454 Damage", "^%+?%d+[,%d]* %- (%d+[,%d]*) .-Damage$")
		
		local _, _, maxDamage = strfind(text, damagePattern);
		checkEquals(4454, CNumber(maxDamage));
		
		--Bloodied Arcanite Reaper  ("763.04 - 1,144 Damage")   Decimal points in first number
		text = "763.04 - 1,144 Damage";
		_, _, maxDamage = strfind(text, damagePattern);
		checkEquals(1144, CNumber(maxDamage));
		
		--Balanced Heartseeker  ("221.34 - 411.06 Damage")  Decimal points in both numbers
		text = "221.34 - 411.06 Damage";
		_, _, maxDamage = strfind(text, damagePattern);
		checkEquals(411.06, CNumber(maxDamage));
	end;
	
	testCNumberAndToNumberAreSame = function()
		local text = "1,234,567.891";
		
		local n = CNumber(text);
		checkEquals(1234567.891, n);
		
		n = L.tonumber(text);
		checkEquals(1234567.891, n);
		
		n = tonumber(text);
		checkEquals(1234567.891, n);
	end;
	
	testMatchTheOnChanceProcEquipItems = function()
		--LibStatLogic cannot handle any "chance of" proc items.
		--PreScan sips these with a regex, which i'm test here.
		local pattern = "^Equip: .- (have a chance to) .-";

		local text;
	
		text = "Equip: Your melee attacks have a chance to cause you to summon a Tentacle of the Old Ones to fight by your side for 12 sec.";
		local _, _, value = strfind(text, pattern);
		checkEquals("have a chance to", value);

		text = "Equip: Your melee attacks have a chance to trigger a whirlwind attack dealing 8029 to 12044 physical damage to all targets within 10 yards.";
		_, _, value = strfind(text, pattern);
		checkEquals("have a chance to", value);

		text = "Equip: When you heal you have a chance to gain 2904 haste rating for 20 sec.";
		_, _, value = strfind(text, pattern);
		checkEquals("have a chance to", value);

		text = "Equip: Your spells have a chance to grant you 1,962 haste for 10 sec and 392 haste to up to 3 allies within 20 yards.";
		_, _, value = strfind(text, pattern);
		checkEquals("have a chance to", value);
	end;
	
	testConvertCommaToPeriod = function()
		local LOCALE_SDECIMAL = ",";

		local s = "1234,56";
		
		s = string.gsub(s, LOCALE_SDECIMAL, "%.");
		checkEquals("1234.56", s);
	end;
	
	testCNumberDeDE = function()
		local n;
		local text;
		
		local L = {};
		L.LOCALE_STHOUSAND = ".";
		L.LOCALE_SDECIMAL = ",";

		text = "5.50";
		n = CNumberEx(text, nil, L);
		--checkEquals(nil, n, text)
		checkEquals(550, n, text); --5.50  ==> 550

		text = "5,50";
		n = CNumberEx(text, nil, L);
		checkEquals(5.50, n, text);

		text = "2,345.50";
		n = CNumberEx(text, nil, L);
		checkEquals(2.3455, n, text); -- 2,345.50  ==>  2,34550  ==>  2.3455

		text = "2.345,50";
		n = CNumberEx(text, nil, L);
		checkEquals(2345.50, n, text);
	end;
	
	testGetSpellCritFromInt = function()
		local int = 1000;
		local classId;
		local level; 
		
		for classId = CLASSID_WARRIOR, CLASSID_MAX do
			for level = 1, 100 do		
				StatLogic:GetSpellCritFromInt(int, classId, level);
			end;
		end;
	end;

	testGetParryChance = function()
		local parryChance, parryBeforeDR, freeParry = StatLogic:GetParryChance(1000, 1000);
		
		local expectedParryChance = GetParryChance();
		parryChance = StatLogic:GetParryChance();
		
		local epsilon = 0.0001;  --four decimal places
		--local epsilon = 0.00001;  --five decimal places
		if (math.abs(parryChance-expectedParryChance) > epsilon) then	
			checkEquals(expectedParryChance, parryChance, "GetParryChance() does not match player (to within 4 decimal places).");		
		end;
	end;
	
	testGetDodgeChance = function()
		local dodgeChance, dodgeBeforeDR, freeDodge = StatLogic:GetDodgeChance(1000, 1000);
		
		local expectedDodgeChance = GetDodgeChance();
		dodgeChance = StatLogic:GetDodgeChance();

		local epsilon = 0.0001;  --four decimal places
		--local epsilon = 0.00001;  --five decimal places
		if (math.abs(dodgeChance-expectedDodgeChance) > epsilon) then	
			checkEquals(expectedDodgeChance, dodgeChance, "GetDodgeChance() does not match player (to withing 4 decimal places).");		
		end;
	end;
	
	testGetBlockChance = function()
		local blockChance, blockChanceBeforeDR, freeBlock = StatLogic:GetBlockChance(1000);
		
		blockChance = StatLogic:GetBlockChance();
		local expectedBlockChance = GetBlockChance();
		
		print(string.format("Block Chance. Expected: %.7f%%. Calculated: %.7f%%", expectedBlockChance, blockChance));
			
		local epsilon = 0.0001; --four decimal places
		if (math.abs(blockChance-expectedBlockChance) > epsilon) then
			checkEquals(expectedBonus, bonus, "Calculated Block Chance didn't match actual Block Chance (to within 4 decimal places)");
		end;
	
	end;
	
	testGetEffectFromRatingMatchesCurrentPlayer = function()
		local bonus, expectedBonus;
		
		local nCombatRatingID;
		for nCombatRatingID = 1, CR_MAX do
			bonus = StatLogic:GetEffectFromRating(GetCombatRating(nCombatRatingID), nCombatRatingID);
			expectedBonus = GetCombatRatingBonus(nCombatRatingID);
			
			--print(string.format("Combat rating %s. Expected: %.7f%%. Calculated: %.7f%%", 
					--StatLogic:GetRatingIdOrStatId(nCombatRatingID), expectedBonus, bonus));
			
			if (math.abs(bonus-expectedBonus) > 0.00001) then
				checkEquals(expectedBonus, bonus, string.format("Calculated combat bonus didn't match actual combat bonus for %s (to within 5 decimal places)", 
						StatLogic:GetRatingIdOrStatId(nCombatRatingID)));
			end;
		end;
	end;
	
	testGetRatingPerBonusMatchesCurrentPlayer = function()
		local bonus, expectedBonus;
		
		local nCombatRatingID;
		local combatRating;
		for nCombatRatingID = 1, CR_MAX do
			combatRating = GetCombatRating(nCombatRatingID);
			expectedBonus = GetCombatRatingBonus(nCombatRatingID);
			
			if (combatRating > 0) and (expectedBonus > 0) then
				--some ratings no longer exist, or i don't have, so i can't test them all
				bonus = StatLogic:GetEffectFromRating(combatRating, nCombatRatingID);

				bonus = combatRating/bonus; --rating per bonus%
				expectedBonus = combatRating/expectedBonus; --rating per bonus% (expected)

				--print(string.format("Rating %s. Expected: %.5f. Calculated: %.5f", 
						--StatLogic:GetRatingIdOrStatId(nCombatRatingID), expectedBonus, bonus));
			
				--Five should work all the time, but Single-precision math rounding issues causes the errors to get too high when we get large values
				--local epsilon = 0.00001; --five decimal places (recommended)
				local epsilon = 0.0001;  --four decimal places
				
				if (math.abs(bonus-expectedBonus) > epsilon) then
					checkEquals(expectedBonus, bonus, string.format("Calculated rating per bonus didn't match actual %s (to within 5 decimal places)", 
							StatLogic:GetRatingIdOrStatId(nCombatRatingID)));
				end;
			end;
		end;
	end;

	testParseLineEnUS = function()
		local locale = GetLocale();
		if (locale ~= "enUS") then
			print("Locale is "..locale..". Can only test enUS");
			return;
		end;

		local table;
		local found, excluded;

		local function dumper(t)
			for key, value in pairs(t) do
				print(string.format("table[%s] = %s", key, value));
			end;
		end;
		
		--***************
		--*** Ignored tester
		--***************
		local function testExcluded(text)
			--print(string.format("Test excluded: \"%s\"", text));
			
			table = {};
			found, excluded = StatLogic:ParseLine(table, text);
			
			if (found == false) then dumper(table); end;
			checkEquals(true, found, "Exclude text \""..text.."\"  wasn't found");
			if (excluded == false) then dumper(table); end;
			checkEquals(true, excluded, "Exclude text \""..text.."\"  was found but not excluded");
		end;
		
		---*** Found tester
		local function testStats(text, stat1, value1, stat2, value2, stat3, value3, stat4, value4)
			--print(string.format("Test stats: \"%s\"", text));
			table = {};
			found, excluded = StatLogic:ParseLine(table, text);
			
			if (found == false) then dumper(table); end;
			checkEquals(true, found, "Text \""..text.."\"  wasn't found");
			if (excluded) then dumper(table); end;
			checkEquals(false, excluded, "Text \""..text.."\"  was found but excluded");

			if (stat1) then
				if (table[stat1] == nil) then dumper(table); end;
				checkEquals(value1, table[stat1], "Stat1 "..stat1);
			end
			if (stat2) then
				if (table[stat2] == nil) then dumper(table); end;
				checkEquals(value2, table[stat2], "Stat2 "..stat2);
			end
			if (stat3) then
				if (table[stat3] == nil) then dumper(table); end;
				checkEquals(value3, table[stat3], "Stat3 "..stat3);
			end
			if (stat4) then
				if (table[stat4] == nil) then dumper(table); end;
				checkEquals(value4, table[stat4], "Stat4 "..stat4);
			end
		end;		

		testExcluded("Unique-Equipped: Hardhearth Ring (1)");
		testExcluded("Unique-Equipped");
		testExcluded("Requires Level 85");
		testExcluded("Item Level 410");
		testExcluded("Equip: Your melee attacks have a chance to grant 1,149 dodge for 20 sec.");
		testExcluded("Equip: Experience gained is increased by 10%.");
		testExcluded("Equip: You champion the causes of your guild. All guild reputation gains are increased by 50%.");
		testExcluded("Equip: Experience gained from killing monsters and completing quests increased by 5%.");
		testExcluded("Upgrade Level: 0/1");
		testExcluded("Upgrade Level: 0/2");
		testExcluded("Upgrade Level: 1/2");
		testExcluded("Upgrade Level: 2/2");

		testStats("+384 Strength", "STR", 384);
		testStats("+1,234 Stamina", "STA", 1234);
		testStats("+81 Stamina and +1% Shield Block Value", "STA", 81, "MOD_BLOCK_VALUE", 1);
		testStats("491.96 - 913.64 Damage", "MAX_DAMAGE", 913.64);
		testStats("(251.00 damage per second)", "DPS", 251.00);
		testStats("Equip: Increases spell power by 2,783.", "SPELL_DMG", 2783, "HEAL", 2783);
		testStats("+4% Mount Speed", "MOD_MOUNT_SPEED", 4);
		testStats("Equip: Cooking skill increased by 10.", "COOKING", 10);

		--5.1.0 Landfall, they now include the reforging
		testStats("+384 Strength (Reforged from Critical Strike)", "STR", 384);
		testStats("+1,234 Stamina (Reforged from Dodge)", "STA", 1234);
		testStats("+140 Expertise (Reforged from Parry)", "EXPERTISE_RATING", 140);
		testStats("+210 Critical Strike (Reforged from Hit Chance)", "MELEE_CRIT_RATING", 210);		
		
		--5.1 Landfall - Enchants with multiple stats
		testStats("Enchanted: +300 Stamina", "STA", 300); --e.g. Spell 104397 Enchant Chest - Superior Stamina
		testStats("Enchanted: +180 Strength", "STR", 180); --e.g. Spell=104390 Enchant Bracer - Excpetional Strength
		testStats("Enchanted: +300 Stamina and +180 Strength", "STA", 300, "STR", 180); --TODO: Find an example of an actual enchant; so i can actually test it. Or at least document it
		
		--Areko found the actual exchants to have dual effects
		testStats("Enchanted: +130 Intellect and +25 Haste", "INT", 130, "MELEE_HASTE_RATING", 25, "SPELL_HASTE_RATING", 25); --Felfire Inscription, SpellID=86403, EffectID=4196
		testStats("Enchanted: +195 Stamina and +25 Dodge", "STA", 195, "DODGE_RATING", 25); --Inscription of the Earth Prince, spellID=86402, effectID=4195
		testStats("Enchanted: +130 Strength and +25 Critical Strike", "STR", 130, "MELEE_CRIT_RATING", 25); --Lionsmane Inscription, spellID=86401, effectID=4194
		testStats("Enchanted: +130 Agility and +25 Mastery", "AGI", 130, "MASTERY_RATING", 25); --Swiftsteel Inscription, spellID=86375, effectID=4193
		testStats("Enchanted: +285 Intellect and +165 Spirit", "INT", 285, "SPI", 165); --Greater Pearlescent Spellthread, itemID=82444
		testStats("Enchanted: +285 Intellect and +165 Critical Strike", "INT", 285, "MELEE_CRIT_RATING", 165); --Greater Cerulean Spellthread, itemID=82445
		testStats("Enchanted: +285 Agility and +165 Critical Strike", "AGI", 285, "MELEE_CRIT_RATING", 165); --Shadowleather Leg Armor, itemID=83764
		testStats("Enchanted: +430 Stamina and +165 Dodge", "STA", 430, "DODGE_RATING", 165); --Ironscale Leg Armor, itemID=83763
		testStats("Enchanted: +285 Strength and +165 Critical Strike", "STR", 285, "MELEE_CRIT_RATING", 165); --Angerhide Leg Armor, itemID=83765
	end;
	
	testGetStrPerParry = function()
		local Qs = StatLogic:GetStrPerParry();
		
		print("GetStrPerParry: Qs="..(Qs or 'nil').."  (exact value 951.158596 for Warriors/Paladins at level 90");
	end;
	
	testGetAgiPerDodge = function()
		local Qa = StatLogic:GetAgiPerDodge();
		print("GetAgiPerDodge: Qa="..(Qa or 'nil').."  (theory craft is 10,000 at level 90)");
	end;	

};	

WoWUnit:AddTestSuite("lsl", LibStatLogicTests);
print("Registered ListStatLogic unit tests. Run the tests using: /wu lsl");
else
	--no WoWUnit
	--print("LibStatLogic: Could not register unit tests");
end; --if (WoWUnit)


function BOB2()
print("___");
for k, v in pairs(L["StatIDLookup"]) do
	print(k);
end
end
