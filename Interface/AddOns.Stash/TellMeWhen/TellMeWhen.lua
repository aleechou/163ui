﻿-- ---------------------------------
-- TellMeWhen
-- Originally by Nephthys of Hyjal <lieandswell@yahoo.com>

-- Other contributions by:
--		Sweetmms of Blackrock, Oozebull of Twisting Nether, Oodyboo of Mug'thol,
--		Banjankri of Blackrock, Predeter of Proudmoore, Xenyr of Aszune

-- Currently maintained by
-- Cybeloras of Aerie Peak/Detheroc/Mal'Ganis
-- ---------------------------------


-- ---------------------------------
-- ADDON GLOBALS AND LOCALS
-- ---------------------------------

TELLMEWHEN_VERSION = "6.2.6"

TELLMEWHEN_VERSION_MINOR = ""
local projectVersion = "6.2.6" -- comes out like "6.2.2-21-g4e91cee"
if strmatch(projectVersion, "%-%d+%-") then
	TELLMEWHEN_VERSION_MINOR = (" r%d (%s)"):format(strmatch(projectVersion, "%-(%d+)%-(.*)"))
end

TELLMEWHEN_VERSION_FULL = TELLMEWHEN_VERSION .. TELLMEWHEN_VERSION_MINOR
TELLMEWHEN_VERSIONNUMBER = 62602 -- NEVER DECREASE THIS NUMBER (duh?).  IT IS ALSO ONLY INTERNAL (for versioning of)

if TELLMEWHEN_VERSIONNUMBER > 63000 or TELLMEWHEN_VERSIONNUMBER < 62000 then
	-- safety check because i accidentally made the version number 414069 once
	return error("YOU SCREWED UP THE VERSION NUMBER OR DIDNT CHANGE THE SAFETY LIMITS")
end 

TELLMEWHEN_MAXROWS = 20

-- Put required libs here: (If they fail to load, they will make all of TMW fail to load)
local AceDB = LibStub("AceDB-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TellMeWhen", true)

_G.TMW = LibStub("AceAddon-3.0"):NewAddon(CreateFrame("Frame", "TMW", UIParent), "TellMeWhen", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0", "AceComm-3.0", "AceSerializer-3.0")
_G.TellMeWhen = _G.TMW
local TMW = _G.TMW

local DogTag = LibStub("LibDogTag-3.0", true)

--L = setmetatable({}, {__index = function() return ("| ! "):rep(12) end}) -- stress testing for text widths
TMW.L = L


-- GLOBALS: LibStub
-- GLOBALS: TellMeWhenDB, TellMeWhen_Settings
-- GLOBALS: TELLMEWHEN_VERSION, TELLMEWHEN_VERSION_MINOR, TELLMEWHEN_VERSION_FULL, TELLMEWHEN_VERSIONNUMBER, TELLMEWHEN_MAXROWS
-- GLOBALS: UIDROPDOWNMENU_MENU_LEVEL, UIDropDownMenu_AddButton, UIDropDownMenu_CreateInfo
-- GLOBALS: UIParent, CreateFrame, collectgarbage, geterrorhandler 

---------- Upvalues ----------
local GetSpellCooldown, GetSpellInfo, GetSpellTexture =
	  GetSpellCooldown, GetSpellInfo, GetSpellTexture
local GetItemInfo, GetInventoryItemID, GetItemIcon =
	  GetItemInfo, GetInventoryItemID, GetItemIcon
local GetTalentInfo =
	  GetTalentInfo
local UnitPower, UnitClass, UnitName, UnitAura =
	  UnitPower, UnitClass, UnitName, UnitAura
local IsInGuild =
	  IsInGuild
local GetAddOnInfo, IsAddOnLoaded, LoadAddOn, EnableAddOn =
	  GetAddOnInfo, IsAddOnLoaded, LoadAddOn, EnableAddOn
local tonumber, tostring, type, pairs, ipairs, tinsert, tremove, sort, select, wipe, rawget, rawset, assert, pcall, error, getmetatable, setmetatable, loadstring, unpack, debugstack =
	  tonumber, tostring, type, pairs, ipairs, tinsert, tremove, sort, select, wipe, rawget, rawset, assert, pcall, error, getmetatable, setmetatable, loadstring, unpack, debugstack
local strfind, strmatch, format, gsub, gmatch, strsub, strtrim, strsplit, strlower, strrep, strchar, strconcat, max, ceil, floor, random =
	  strfind, strmatch, format, gsub, gmatch, strsub, strtrim, strsplit, strlower, strrep, strchar, strconcat, max, ceil, floor, random
local _G, coroutine, table, GetTime, CopyTable =
	  _G, coroutine, table, GetTime, CopyTable
local tostringall = tostringall

---------- Locals ----------
local Locked
local UPD_INTV = 0.06	--this is a default, local because i use it in onupdate functions
local GCD = 0
local LastUpdate = 0

local time = GetTime() TMW.time = time

local clientVersion = select(4, GetBuildInfo())
local addonVersion = tonumber(GetAddOnMetadata("TellMeWhen", "X-Interface"))

local _, pclass = UnitClass("Player")







---------------------------------
-- Important Tables
---------------------------------

TMW.Types = setmetatable({}, {
	__index = function(t, k)
		-- if no type exists, then use the fallback (default) type
		return rawget(t, "")
	end
})
TMW.OrderedTypes = {}

TMW.Views = setmetatable({}, {
	__index = function(t, k)
		return rawget(t, "icon")
	end
})
TMW.OrderedViews = {}

TMW.EventList = {}

TMW.COMMON = {}

TMW.CONST = {
	CHAT_TYPE_INSTANCE_CHAT = "INSTANCE_CHAT"
}

TMW.IconsToUpdate, TMW.GroupsToUpdate = {}, {}
local IconsToUpdate = TMW.IconsToUpdate
local GroupsToUpdate = TMW.GroupsToUpdate





---------------------------------
-- Default Settings
---------------------------------

TMW.Defaults = {
	global = {
		HelpSettings = {
		},
		HasImported			= false,
		VersionWarning		= true,
		AllowCombatConfig	= false,
	},
	locale = {
		WpnEnchDurs	= {
			["*"] = 0,
		},
	},
	profile = {
	--	Version			= 	TELLMEWHEN_VERSIONNUMBER,  -- DO NOT DEFINE VERSION AS A DEFAULT, OTHERWISE WE CANT TRACK IF A USER HAS AN OLD VERSION BECAUSE IT WILL ALWAYS DEFAULT TO THE LATEST
		Locked			= 	false,
		NumGroups		=	1,
		Interval		=	UPD_INTV,
		EffThreshold	=	15,
		TextureName		= 	"Blizzard",
		SoundChannel	=	"SFX",
		ReceiveComm		=	true,
		WarnInvalids	=	false,
		CheckOrder		=	-1,
		--SUG_atBeginning	=	true,
		ColorNames		=	true,
		--AlwaysSubLinks	=	false,
		ColorMSQ	 	= false,
		OnlyMSQ		 	= false,
		ColorGCD		= true,

		Colors = {
			["**"] = {
				CBC = 	{r=0,	g=1,	b=0,	Override = false,	a=1,	},	-- cooldown bar complete
				CBS = 	{r=1,	g=0,	b=0,	Override = false,	a=1,	},	-- cooldown bar start
				CBM = 	{r=1,	g=1,	b=0,	Override = false,	a=1,	},	-- cooldown bar middle

				OOR	=	{r=0.5,	g=0.5,	b=0.5,	Override = false,			},	-- out of range
				OOM	=	{r=0.5,	g=0.5,	b=0.5,	Override = false,			},	-- out of mana
				OORM=	{r=0.5,	g=0.5,	b=0.5,	Override = false,			},	-- out of range and mana

				CTA	=	{r=1,	g=1,	b=1,	Override = false,			},	-- counting with timer always
				COA	=	{r=0.5,	g=0.5,	b=0.5,	Override = false,			},	-- counting withOUT timer always
				CTS	=	{r=1,	g=1,	b=1,	Override = false,			},	-- counting with timer somtimes
				COS	=	{r=1,	g=1,	b=1,	Override = false,			},	-- counting withOUT timer somtimes

				NA	=	{r=1,	g=1,	b=1,	Override = false,			},	-- not counting always
				NS	=	{r=1,	g=1,	b=1,	Override = false,			},	-- not counting somtimes
			},
		},
		Groups 		= 	{
			[1] = {
				Enabled			= true,
			},
			["**"] = {
				Enabled			= false,
				OnlyInCombat	= false,
				Locked			= false,
				View			= "icon",
				Name			= "",
				Strata			= "MEDIUM",
				Scale			= 2.0,
				Level			= 10,
				Rows			= 1,
				Columns			= 4,
				CheckOrder		= -1,
				PrimarySpec		= true,
				SecondarySpec	= true,
				Tree1 			= true,
				Tree2 			= true,
				Tree3 			= true,
				Tree4 			= true,
				SettingsPerView	= {
					["**"] = {
					}
				},
				Icons = {
					["**"] = {
						ShowWhen				= 0x2, -- bit order: x, x, alpha, unalpha
						Enabled					= false,
						Name					= "",
						Type					= "",
						Alpha					= 1,
						UnAlpha					= 1,
						Icons					= {
							[1]					= "",
						},
						SettingsPerView			= {
							["**"] = {
							}
						},
					},
				},
			},
		},
	},
}

TMW.Group_Defaults 	 = TMW.Defaults.profile.Groups["**"]
TMW.Icon_Defaults 	 = TMW.Group_Defaults.Icons["**"]

function TMW:RegisterDatabaseDefaults(defaults)
	assert(type(defaults) == "table", "arg1 to RegisterProfileDefaults must be a table")
	
	if TMW.InitializedDatabase then
		error("Defaults are being registered too late. They need to be registered before the database is initialized.", 2)
	end
	
	-- Copy the defaults into the main defaults table.
	TMW:MergeDefaultsTables(defaults, TMW.Defaults)
end

function TMW:MergeDefaultsTables(src, dest)
	--src and dest must have congruent data structure, otherwise shit will blow up.
	-- There are no safety checks to prevent this.
	
	for k in pairs(src) do
		local src_type, dest_type = type(src[k]), type(dest[k])
		if dest[k] and dest_type == "table" and src_type == "table" then
			TMW:MergeDefaultsTables(src[k], dest[k])
			
		elseif dest_type ~= "nil" and src[k] ~= dest[k] then
			error(("Mismatch in merging db default tables! Setting Key: %q; Source: %q (%s); Destination: %q (%s)")
				:format(k, tostring(src[k]), src_type, tostring(dest[k]), dest_type), 3)
			
		else
			dest[k] = src[k]
		end
	end
	
	return dest -- not really needed, but what the hell why not
end





---------------------------------
-- Equivalencies & Dispel Types
---------------------------------

TMW.BE = {
	--Most of these are thanks to Malazee @ US-Dalaran's chart: http://forums.wow-petopia.com/download/file.php?mode=view&id=4979 and spreadsheet https://spreadsheets.google.com/ccc?key=0Aox2ZHZE6e_SdHhTc0tZam05QVJDU0lONnp0ZVgzdkE&hl=en#gid=18
	--Major credit to Wowhead (http://www.wowhead.com/guide=1100) for MoP spells
	--Also credit to Damien of Icy Veins (http://www.icy-veins.com/forums/topic/512-mists-of-pandaria-raid-buffs-and-debuffs/) for some MoP spells
	--Many more new spells/corrections were provided by Catok of Curse

	--NOTE: any id prefixed with "_" will have its localized name substituted in instead of being forced to match as an ID
	debuffs = {
		ReducedArmor		= "113746",
		PhysicalDmgTaken	= "81326;35290;50518;57386;55749",
		SpellDamageTaken	= "93068;_1490;34889;24844;116202",
		ReducedPhysicalDone = "115798;50256;24423",
		ReducedCastingSpeed = "31589;73975;5761;109466;50274;90314;126402;58604",
		ReducedHealing		= "115804",
		Stunned				= "_1833;_408;_91800;_113801;5211;_56;9005;22570;19577;24394;56626;44572;_853;64044;96201;_20549;46968;132168;_30283;_7922;50519;91797;_89766;54786;105593;120086;117418;115001;_131402;108194;117526;105771;_122242;113953;118905;119392;119381;118271",
		Incapacitated		= "20066;1776;_6770;115078",
		Rooted				= "_339;_122;_64695;_19387;33395;_4167;54706;50245;90327;16979;45334;_87194;63685;102359;_128405;116706;123407;115197",
		Disarmed			= "_51722;_676;64058;50541;91644;117368",
		Silenced			= "_47476;_78675;_34490;_55021;_15487;_1330;_24259;_18498;_25046;31935;31117;102051;116709;142895",
		Shatterable			= "122;33395;_44572;_82691", -- by algus2
		Disoriented			= "_19503;31661;_2094;_51514;90337;88625;105421;99",
		Slowed				= "_116;_120;_13810;_5116;_8056;_3600;_1715;_12323;116095;_20170;_115180;45524;_18223;_15407;_3409;26679;_58180;61391;44614;_7302;_8034;_63529;_15571;_7321;_7992;123586;47960;129923", -- by algus2 
		Feared				= "_5782;5246;_8122;10326;1513;111397;_5484;_6789;_87204;20511;112928;113004;113792;113056",
		Bleeding			= "_1822;_1079;9007;33745;1943;_703;_115767;89775;_11977;106830;77758",
		
		-- EXISTING WAS CHECKED, DIDN'T LOOK FOR NEW (mists of pandaria)  ONES YET:
		CrowdControl		= "_118;2637;33786;113506;_1499;_19503;_19386;20066;10326;_9484;_6770;_2094;_51514;76780;_710;_5782;_6358;_605;_82691;115078", -- originally by calico0 of Curse
		
	},
	buffs = {
		IncreasedMastery	= "19740;116956;93435;127830",
		IncreasedSP			= "1459;61316;77747;109773;126309",
		IncreasedAP			= "57330;19506;6673",
		IncreasedPhysHaste  = "55610;113742;30809;128432;128433",
		IncreasedStats		= "1126;_117666;20217;90363",
		BonusStamina		= "21562;109773;469;90364",
		IncreasedSpellHaste = "24907;15473;51470;49868;135678",
		IncreasedCrit		= "24932;1459;61316;97229;24604;90309;126373;126309;116781",
		
		-- From l337g0g0 of Curse:
		DamageShield		= "_17;_11426;116849;115295;114908;110913;108416;112048;86273;114214;47753;65148;108008;1463;108366;119839;_6229;115635;77535;145441",
		
		-- EXISTING WAS CHECKED, DIDN'T LOOK FOR NEW (mists of pandaria) ONES YET:
		ImmuneToStun		= "642;45438;19574;48792;1022;33786;710;46924;19263;6615",
		ImmuneToMagicCC		= "642;45438;48707;19574;33786;710;46924;19263;31224;8178;23920;49039",
		BurstHaste			= "2825;32182;80353;90355;146555",
		BurstManaRegen		= "29166;16191;64901",
		DefensiveBuffs		= "48707;30823;33206;47585;871;48792;498;22812;61336;5277;74001;47788;19263;6940;31850;31224;42650;86657;118038;115176;115308;120954;115295;51271",
		MiscHelpfulBuffs	= "96267;10060;23920;68992;54428;2983;1850;29166;16689;53271;1044;31821;45182",
		DamageBuffs			= "1719;12292;50334;5217;3045;77801;34692;31884;51713;49016;12472;57933;86700;51271;_107574;114050;114051",
	},
	casts = {
		--prefixing with _ doesnt really matter here since casts only match by name,
		-- but it may prevent confusion if people try and use these as buff/debuff equivs
		Heals				= "50464;5185;8936;740;2050;2060;2061;32546;596;64843;635;82326;19750;331;77472;8004;1064;73920;124682;115175;116694",
		PvPSpells			= "33786;339;20484;1513;982;64901;_605;5782;5484;10326;51514;118;12051;20066",
		Tier11Interrupts	= "_83703;_82752;_82636;_83070;_79710;_77896;_77569;_80734;_82411",
		Tier12Interrupts	= "_97202;_100094",
	},
}

TMW.DS = {
	Magic 	= "Interface\\Icons\\spell_fire_immolation",
	Curse 	= "Interface\\Icons\\spell_shadow_curseofsargeras",
	Disease = "Interface\\Icons\\spell_nature_nullifydisease",
	Poison 	= "Interface\\Icons\\spell_nature_corrosivebreath",
	Enraged = "Interface\\Icons\\ability_druid_challangingroar",
}

function TMW:ProcessEquivalencies()
	for dispeltype, icon in pairs(TMW.DS) do
	--	SpellTexturesMetaIndex[dispeltype] = icon
		TMW.SpellTexturesMetaIndex[strlower(dispeltype)] = icon
	end
	
	TMW:Fire("TMW_EQUIVS_PROCESSING")
	
	TMW:UnregisterAllCallbacks("TMW_EQUIVS_PROCESSING")
	TMW.ProcessEquivalencies = nil

	-- TMW.OldBE is used by TellMeWhen_Options.lua to create some tables to allow reverse-lookups
	-- of equavalancies for things like the suggestion list.
	TMW.OldBE = CopyTable(TMW.BE)
	
	for category, b in pairs(TMW.OldBE) do
		for equiv, str in pairs(b) do
		
			-- remove underscores from TMW.OldBE's entries
			b[equiv] = gsub(str, "_", "")

			-- turn all IDs prefixed with "_" into their localized name.
			-- When defining equavalancies, dont put a _ on every single one,
			-- but do use it for spells that do not have any other spells with the same name and different effects.
			
			while strfind(str, "_") do
				local idWithUnderscore = strmatch(str, "_%d+")
				local idWithoutUnderscore = tonumber(strmatch(str, "_(%d+)"))
				
				if idWithUnderscore then
					local name, _, tex = GetSpellInfo(idWithoutUnderscore)
					
					-- name will be nil if the ID isn't a valid spell (possibly the spell was removed in a patch).
					if name then
						-- this will insert the spell name into the table of spells for capitalization restoration.
						TMW:LowerNames(name) 
						
						-- replace the underscored spellID with the name substitution
						str = gsub(str, idWithUnderscore, name, 1)
						
						-- map the spell's name and ID to its texture for the spell texture cache
						TMW.SpellTexturesMetaIndex[idWithoutUnderscore] = tex
						TMW.SpellTexturesMetaIndex[TMW.strlowerCache[name]] = tex

					else
						
						if clientVersion >= addonVersion then -- only warn for newer clients using older versions
							TMW:Debug("Invalid spellID found: %s (%s - %s)!",
							idWithoutUnderscore, category, equiv)
						end
						
						-- substitute it back in without the underscore to prevent recusion
						str = gsub(str, idWithUnderscore, idWithoutUnderscore, 1)
					end
				end
			end
			TMW.BE[category][equiv] = str
		end
	end
end





---------------------------------
-- Global Cooldown Data
---------------------------------

TMW.GCDSpells = {
	ROGUE		= 1752,		-- sinister strike
	PRIEST		= 585,		-- smite
	DRUID		= 5176,		-- wrath
	WARRIOR		= 5308,		-- execute
	MAGE		= 44614,	-- frostfire bolt
	WARLOCK		= 686,		-- shadow bolt
	PALADIN		= 105361,	-- seal of command
	SHAMAN		= 403,		-- lightning bolt
	HUNTER		= 3044,		-- arcane shot
	DEATHKNIGHT = 47541,	-- death coil
	MONK		= 100780,	-- jab
}

local GCDSpell = TMW.GCDSpells[pclass]
TMW.GCDSpell = GCDSpell
TMW.GCD = 0

function TMW.OnGCD(d)
	if d == 0.001 then
		-- A cd of 0.001 is Blizzard's terrible way of indicating that something's cooldown hasn't started,
		-- but is still unusable, and has a cooldown pending. It should not be considered a GCD.
		return false
	elseif d <= 1 then
		-- A cd of 1 (or less) is always a GCD (or at least isn't worth showing)
		return true
	elseif GCD > 1.7 then
		-- Weed out a cooldown on the GCD spell that might be an interupt (counterspell, mind freeze, etc)
		return false
	else
		-- If the duration passed in is the same as the GCD spell,
		-- and the duration isnt zero, then it is a GCD
		return GCD == d and d > 0 
	end
end





---------------------------------
-- Caches
---------------------------------


TMW.strlowerCache = setmetatable(
{}, {
	__mode = "kv",
	__index = function(t, i)
		if not i then return end
		local o
		if type(i) == "number" then
			o = i
		else
			o = strlower(i)
		end
		t[i] = o
		return o
	end,
	__call = function(t, i)
		return t[i]
	end,
}) local strlowerCache = TMW.strlowerCache

TMW.SpellTexturesMetaIndex = {}
TMW.SpellTexturesBase = {
	--hack for pvp tinkets
	[42292] = "Interface\\Icons\\inv_jewelry_trinketpvp_0" .. (UnitFactionGroup("player") == "Horde" and "2" or "1"),
	[strlowerCache[GetSpellInfo(42292)]] = "Interface\\Icons\\inv_jewelry_trinketpvp_0" .. (UnitFactionGroup("player") == "Horde" and "2" or "1"),
}
local SpellTexturesMetaIndex = TMW.SpellTexturesMetaIndex
TMW.SpellTextures = setmetatable(
	CopyTable(TMW.SpellTexturesBase),
	{
		__index = function(t, name)
			if not name then return end

			
			local tex =
				rawget(t, strlowerCache[name]) or -- rawget the strlower because hardcoded entries (talents, mainly) are put into the table as lowercase
				GetSpellTexture(name) or
				SpellTexturesMetaIndex[name] or
				rawget(SpellTexturesMetaIndex, strlowerCache[name])


			t[name] = tex
			return tex
		end,
		__call = function(t, i)
			return t[i]
		end,
	}
) local SpellTextures = TMW.SpellTextures

TMW.isNumber = setmetatable(
{}, {
	__mode = "kv",
	__index = function(t, i)
		if not i then return false end
		local o = tonumber(i) or false
		t[i] = o
		return o
end})

TMW.isString = setmetatable(
{}, {
	__mode = "kv",
	__index = function(t, s)
		if s == nil then
			return false
		else
			local o = type(s) == "string"
			t[s] = o
			return o
		end
end})





---------------------------------
-- Function Caching
---------------------------------

function TMW:MakeFunctionCached(obj, method)
	local func
	if type(obj) == "table" and type(method) == "string" then
		func = obj[method]
	elseif type(obj) == "function" then
		func = obj
	else
		error("Usage: TMW:MakeFunctionCached(object/function [, method])")
	end

	local cache = {}
	local wrapper = function(...)
		-- tostringall is a Blizzard function defined in UIParent.lua
		local cachestring = strconcat(tostringall(...))
		--local cachestring = TMW:Serialize(...)
		
		if cache[cachestring] then
			return cache[cachestring]
		end

		local arg1, arg2 = func(...)
		if arg2 ~= nil then
			error("Cannot cache functions with more than 1 return arg")
		end

		cache[cachestring] = arg1

		return arg1
	end

	if type(obj) == "table" then
		obj[method] = wrapper
	end

	return wrapper, cache
end

function TMW:MakeSingleArgFunctionCached(obj, method)
	-- MakeSingleArgFunctionCached is MUCH more efficient than MakeFunctionCached
	-- and should be used whenever there is only 1 input arg
	local func
	if type(obj) == "table" and type(method) == "string" then
		func = obj[method]
	elseif type(obj) == "function" then
		func = obj
	else
		error("Usage: TMW:MakeFunctionCached(object/function [, method])", 2)
	end

	local cache = {}
	local wrapper = function(arg1In, arg2In)
		if arg2In ~= nil then
			error("Cannot MakeSingleArgFunctionCached functions with more than 1 arg", 2)
		end
		
		if cache[arg1In] then
			return cache[arg1In]
		end

		local arg1Out, arg2Out = func(arg1In)
		if arg2Out ~= nil then
			error("Cannot cache functions with more than 1 return arg", 2)
		end

		cache[arg1In] = arg1Out

		return arg1Out
	end

	if type(obj) == "table" then
		obj[method] = wrapper
	end

	return wrapper
end





---------------------------------
-- Table Utilities
---------------------------------

function TMW.tContains(table, item, returnNum)
	local firstkey
	local num = 0
	for k, v in pairs(table) do
		if v == item then
			if not returnNum then
				-- Return only the key of the first match
				return k
			else
				num = num + 1
				firstkey = firstkey or k
			end
		end
	end

	-- Return the key of the first match and also the total number of matches
	return firstkey, num
end local tContains = TMW.tContains

function TMW.tDeleteItem(table, item, onlyOne)
	local i = 1
	local removed
	while table[i] do
		if item == table[i] then
			tremove(table, i)
			if onlyOne then
				return true
			end
			removed = true
		else
			i = i + 1
		end
	end

	return removed
end local tDeleteItem = TMW.tDeleteItem

function TMW.tRemoveDuplicates(table)

	local offs = 0

	-- Start at the end of the table so that we don't remove duplicates from the beginning
	for k = #table, 1, -1 do

		-- offs is adjusted each time something is removed so that we don't waste time
		-- searching for nil values when the table is shifted by a duplicate removal
		k = k + offs

		-- If we have reached the beginning of the table, we are done.
		if k <= 0 then
			return table
		end
		
		-- item is the value being searched for
		local item = table[k]

		-- prevIndex tracks the last index where the searched-for value was found
		local prevIndex

		-- Once again start the iteration from the end because we don't want to have to 
		-- deal with index shifting when we remove a value
		for i = #table, 1, -1 do
			if table[i] == item then

				-- We found a match. If there has already been another match, remove that match 
				-- and record this match as being the first one (closes to index 0) in the table.
				if prevIndex then
					tremove(table, prevIndex)
					offs = offs - 1
				end

				-- Queue this match for removal should we find another match closer to the beginning.
				prevIndex = i
			end
		end
	end

	-- Done. Return the table for ease-of-use.
	return table
end

function TMW.OrderSort(a, b)
	if a.Order then
		return a.Order < b.Order
	else
		return a.order < b.order
	end
end
function TMW:SortOrderedTables(parentTable)
	sort(parentTable, TMW.OrderSort)
	return parentTable
end

function TMW:CopyWithMetatable(source)
	-- This is basically deepcopy without recursion prevention
	
	local dest = {}
	for k, v in pairs(source) do
		if type(v) == "table" then
			dest[k] = TMW:CopyWithMetatable(v)
		else
			dest[k] = v
		end
	end
	return setmetatable(dest, getmetatable(source))
end

function TMW:CopyTableInPlaceWithMeta(src, dest, allowUnmatchedSourceTables)
	--src and dest must have congruent data structure, otherwise shit will blow up. There are no safety checks to prevent this.
	local metatemp = getmetatable(src) -- lets not go overwriting random metatables
	setmetatable(src, getmetatable(dest))
	for k in pairs(src) do
		if type(dest[k]) == "table" and type(src[k]) == "table" then
			TMW:CopyTableInPlaceWithMeta(src[k], dest[k], allowUnmatchedSourceTables)
		elseif allowUnmatchedSourceTables and type(dest[k]) ~= "table" and type(src[k]) == "table" then
			dest[k] = {}
			TMW:CopyTableInPlaceWithMeta(src[k], dest[k], allowUnmatchedSourceTables)
		elseif type(src[k]) ~= "table" then
			dest[k] = src[k]
		end
	end
	setmetatable(src, metatemp) -- restore the old metatable
	return dest -- not really needed, but what the hell why not
end





---------------------------------
-- Output & Errors
---------------------------------

TMW.Print = TMW.Print or _G.print
TMW.Warn = setmetatable(
{}, {
	__call = function(tbl, text)
		if tbl[text] then
			return
		elseif TMW.Warned then
			TMW:Print(text)
			tbl[text] = true
		elseif not TMW.tContains(tbl, text) then
			tinsert(tbl, text)
		end
end})

function TMW:DoInitialWarn()
	for k, v in ipairs(TMW.Warn) do
		TMW:Print(v)
		TMW.Warn[k] = true
	end
	
	TMW.Warned = true
	TMW.DoInitialWarn = TMW.NULLFUNC
end

function TMW.print(...)
	if TMW.debug or not TMW.Initialized then
		local prefix = "|cffff0000TMW"
		-- GLOBALS: linenum
		if linenum then
		--	prefix = prefix..format(" %4.0f", linenum(3))
			prefix = format("|cffff0000 %s", linenum(3, 1))
		end
		prefix = prefix..":|r "
		local func = TMW.debug and TMW.debug.print or _G.print
		if ... == TMW then
			prefix = "s" .. prefix
			func(prefix, select(2,...))
		else
			func(prefix, ...)
		end
	end
	return ...
end
local print = TMW.print

function TMW:Debug(...)
	if TMW.debug or not TMW.Initialized then
		TMW.print(format(...))
	end
end

function TMW:Error(text, ...)
	text = text or ""
	local success, result = pcall(format, text, ...)
	if success then
		text = result
	end
	geterrorhandler()("TellMeWhen: " .. text)
end

function TMW:Assert(statement, text, ...)
	if not statement then
		text = text or "Assertion Failed!"
		local success, result = pcall(format, text, ...)
		if success then
			text = result
		end
		geterrorhandler()("TellMeWhen: " .. text)
	end
end

function TMW:ValidateType(argN, methodName, var, reqType, errLvl)
	local varType = type(var)
	
	local isGood, foundMatch = true, false
	for _, reqType in TMW:Vararg(strsplit(";", reqType)) do
		local negate = reqType:sub(1, 1) == "!"
		local reqType = negate and reqType:sub(2) or reqType
		reqType = reqType:trim(" ")
		
		if reqType == "frame" and varType == "table" and type(var[0]) == "userdata" then
			varType = "frame"
		end
		
		if negate then
			if varType == reqType then
				isGood = false
				break
			else
				foundMatch = true
			end
		else
			if varType == reqType then
				foundMatch = true
			end
		end
	end
	
	if not isGood or not foundMatch then
		error(("Bad argument #%s to %q. %s expected, got %s"):format(argN, methodName, reqType, varType), 3 + (errLvl or 0))
	end
end





---------------------------------
-- Misc. Utilities
---------------------------------

function TMW.get(value, ...)
	local type = type(value)
	if type == "function" then
		return value(...)
	elseif type == "table" then
		return value[...]
	else
		return value
	end
end

function TMW.NULLFUNC()
	-- Do nothing
end

function TMW.oneUpString(string)
	if string:find("%d+") then
		local num = tonumber(string:match("(%d+)"))
		if num then
			string = string:gsub(("(%d+)"), num + 1, 1)
			return string
		end
	end
	return string .. " 2"
end

TMW.CompareFuncs = {
	-- actually more efficient than a big elseif chain.
	["=="] = function(a, b) return a == b  end,
	["~="] = function(a, b) return a ~= b end,
	[">="] = function(a, b) return a >= b end,
	["<="] = function(a, b) return a <= b  end,
	["<"] = function(a, b) return a < b  end,
	[">"] = function(a, b) return a > b end,
}

do	-- TMW.safecall
	--[[
		xpcall safecall implementation
	]]
	local xpcall = xpcall

	local function errorhandler(err)
		return geterrorhandler()(err)
	end

	local function CreateDispatcher(argCount)
		local code = [[
			local xpcall, eh = ...
			local method, ARGS
			local function call() return method(ARGS) end
		
			local function dispatch(func, ...)
				method = func
				if not method then return end
				ARGS = ...
				return xpcall(call, eh)
			end
		
			return dispatch
		]]
		
		local ARGS = {}
		for i = 1, argCount do ARGS[i] = "arg"..i end
		ARGS = table.concat(ARGS, ", ")
		code = code:gsub("ARGS", ARGS)
		return assert(loadstring(code, "safecall Dispatcher["..argCount.."]"))(xpcall, errorhandler)
	end

	local Dispatchers = setmetatable({}, {__index=function(self, argCount)
		local dispatcher = CreateDispatcher(argCount)
		rawset(self, argCount, dispatcher)
		return dispatcher
	end})
	Dispatchers[0] = function(func)
		return xpcall(func, errorhandler)
	end

	function TMW.safecall(func, ...)
		-- I don't check if func is a function here because i hope that whoever calls it
		-- is smart enough not to do stupid shit. If they arent, they will figure it out when it errors.
		--  if type(func) == "function" then
			return Dispatchers[select('#', ...)](func, ...)
		-- end
	end
end
local safecall = TMW.safecall

local chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz=_"
function TMW.generateGUID(length)
	assert(length and length >= 9, "GUID length must be at least 9")

    local ret = format("%.12o", _G.time())
    
    local time = debugprofilestop() / 1000
    
    local decimalSeconds = format("%.9f", time - floor(time)):gsub("0%.", "")
    
    ret = ret .. format("%.10o", decimalSeconds)
    
    
    while #ret < length * 2 do
        ret = ret .. random(0, 7)
    end
    
    local ret2 = ""

    for segment in ret:sub(1, length*2):gmatch("..") do
        local value = tonumber(segment, 8) + 1
        ret2 = ret2 .. chars:sub(value, value)
    end

    return ret2
end





---------------------------------
-- Iterator Functions
---------------------------------

do -- InNLengthTable
	local states = {}
	local function getstate(k, t)
		local state = wipe(tremove(states) or {})

		state.k = k
		state.t = t

		return state
	end

	local function iter(state)
		state.k = state.k + 1

		if state.k > (state.t.n or #state.t) then -- #t enables iteration over tables that have not yet been upgraded with an n key (i.e. imported data from old versions)
			tinsert(states, state)
			return
		end
	--	return state.t[state.k], state.k --OLD, STUPID IMPLEMENTATION
		return state.k, state.t[state.k]
	end

	function TMW:InNLengthTable(arg)
		if arg then
			return iter, getstate(0, arg)
		else
			error("Bag argument #1 to 'TMW:InNLengthTable(arg)'. Expected table, got nil.", 2)
		end
	end
end

do -- InIconSettings
	local states = {}
	local function getstate(cg, ci, mg, mi)
		local state = wipe(tremove(states) or {})

		state.cg = cg	-- Current Group
		state.ci = ci	-- Current Icon
		state.mg = mg	-- Max Group
		state.mi = mi	-- Max Icon

		return state
	end

	local function iter(state)
		local ci = state.ci
		ci = ci + 1	-- at least increment the icon
		while true do
			if ci <= state.mi and state.cg <= state.mg and TMW.db.profile.Groups[state.cg].Icons and not rawget(TMW.db.profile.Groups[state.cg].Icons, ci) then
				--if there is another icon and the group is valid but the icon settings dont exist, move to the next icon
				ci = ci + 1
			elseif state.cg <= state.mg and ci > state.mi then
				-- if there is another group and the icon exceeds the max, move to the first icon of the next group
				state.cg = state.cg + 1
				ci = 1
			elseif state.cg > state.mg then
				-- if there isnt another group, then stop
				tinsert(states, state)
				return
			else
				-- we finally found something valid, so use it
				break
			end
		end
		state.ci = ci
		return TMW.db.profile.Groups[state.cg].Icons[ci], state.cg, ci -- ics, groupID, iconID
	end

	function TMW:InIconSettings(groupID)
		-- current icon (the second param here) is incremented at the beginning of the iterator call,
		-- so it should be passed in as 0, not 1
		return iter, getstate(groupID or 1, 0, groupID or TMW.db.profile.NumGroups, TELLMEWHEN_MAXROWS*TELLMEWHEN_MAXROWS)
	end
end

do -- InGroupSettings
	local states = {}
	local function getstate(cg, mg)
		local state = wipe(tremove(states) or {})

		state.cg = cg
		state.mg = mg

		return state
	end

	local function iter(state)
		state.cg = state.cg + 1
		if state.cg > state.mg then
			tinsert(states, state)
			return
		end
		return TMW.db.profile.Groups[state.cg], state.cg -- setting table, groupID
	end

	function TMW:InGroupSettings()
		return iter, getstate(0, TMW.db.profile.NumGroups)
	end
end

do -- InIcons
	local states = {}
	local function getstate(cg, ci, mg, mi)
		local state = wipe(tremove(states) or {})

		state.cg = cg
		state.ci = ci
		state.mg = mg
		state.mi = mi

		return state
	end

	local function iter(state)
		state.ci = state.ci + 1
		while true do
			if state.ci <= state.mi and TMW[state.cg] and not TMW[state.cg][state.ci] then
				state.ci = state.ci + 1
			elseif state.cg < state.mg and (state.ci > state.mi or not TMW[state.cg]) then
				state.cg = state.cg + 1
				state.ci = 1
			elseif state.cg > state.mg then
				tinsert(states, state)
				return
			else
				break
			end
		end
		return TMW[state.cg] and TMW[state.cg][state.ci], state.cg, state.ci -- icon, groupID, iconID
	end

	function TMW:InIcons(groupID)
		return iter, getstate(groupID or 1, 0, groupID or TMW.db.profile.NumGroups, TELLMEWHEN_MAXROWS*TELLMEWHEN_MAXROWS)
	end
end

do -- InGroups
	local states = {}
	local function getstate(cg, mg)
		local state = wipe(tremove(states) or {})

		state.cg = cg
		state.mg = mg

		return state
	end

	local function iter(state)
		local cg = state.cg + 1
		state.cg = cg
		if cg > state.mg then
			tinsert(states, state)
			return
		end
		return TMW[cg], cg -- group, groupID
	end

	function TMW:InGroups()
		return iter, getstate(0, TMW.db.profile.NumGroups)
	end
end

do -- vararg
	local states = {}
	local function getstate(...)
		local state = wipe(tremove(states) or {})

		state.i = 0
		state.l = select("#", ...)

		for n = 1, state.l do
			state[n] = select(n, ...)
		end

		return state
	end

	local function iter(state)
		local i = state.i
		i = i + 1
		if i > state.l then
			tinsert(states, state)
			return
		end
		state.i = i

		return i, state[i], state.l
	end

	function TMW:Vararg(...)
		return iter, getstate(...)
	end
end

do -- ordered pairs

	local tables = {}
	local unused = {}

	local sortByValues, reverse
	local function sorter(a, b)
		if sortByValues then
			local val_a, val_b = sortByValues[a], sortByValues[b]
			if val_a ~= val_b then
				a, b = val_a, val_b
			end
		end
		local ta, tb = type(a), type(b)
		if ta ~= tb then
			if reverse then
				return ta > tb
			end
			return ta < tb
		elseif ta == "number" or ta == "string" then
			if reverse then
				return a > b
			end
			return a < b
		elseif ta == "boolean" then
			if reverse then
				return b == true
			end
			return a == true
		else
			if reverse then
				return tostring(a) > tostring(b)
			end
			return tostring(a) < tostring(b)
		end
	end

	local function next(t, state)
		local orderedIndex = tables[t]
		
		if state == nil then
			local key = orderedIndex[1]
			return key, t[key]
		end

		local key
		for i = 1, #orderedIndex do
			if orderedIndex[i] == state then
				key = orderedIndex[i+1]
				break
			end
		end

		if key then
			return key, t[key]
		end

		unused[#unused+1] = wipe(orderedIndex)
		tables[t] = nil
		return
	end

	function TMW:OrderedPairs(t, func, rev)
		local orderedIndex = tremove(unused) or {}
		for key in pairs(t) do
			orderedIndex[#orderedIndex + 1] = key
		end
		reverse = rev
		if func == "values" then
			func = sorter
			sortByValues = t
		else
			sortByValues = nil
		end
		sort(orderedIndex, func or sorter)
		tables[t] = orderedIndex

		return next, t
	end
end






---------------------------------
-- Callback lib
---------------------------------

do -- Callback Lib
	-- because quite frankly, i hate the way CallbackHandler-1.0 works.
	local callbackregistry = {}
	local firingsInProgress = 0
	TMW.callbackregistry=callbackregistry
	
	function removeNils(table)
		local numNils = 0
		
		for i = 1, table.n do
			local v = table[i]
			if v == nil then
				numNils = numNils + 1
			else
				table[i - numNils] = v
			end
		end
		
		for i = table.n - numNils + 1, table.n do
			table[i] = nil
		end
		
		table.n = #table
	end
	
	function TMW:RegisterCallback(event, func, arg1)
		TMW:ValidateType("2 (event)", "TMW:RegisterCallback(event, func, arg1)", event, "string")
		TMW:ValidateType("3 (func)", "TMW:RegisterCallback(event, func, arg1)", func, "function;table")
		TMW:ValidateType("4 (arg1)", "TMW:RegisterCallback(event, func, arg1)", arg1, "!boolean")
		
		if not event:find("^TMW_") then
			-- All TMW events must begin with TMW_
			error("TMW events must begin with 'TMW_'", 2)
		end
		
		
		local funcsForEvent
		if callbackregistry[event] then
			funcsForEvent = callbackregistry[event]
		else
			funcsForEvent = {}
			callbackregistry[event] = funcsForEvent
		end
		
		if type(func) == "table" then
			local object = func
			func = object[arg1 or event]
			arg1 = object
		end
		arg1 = arg1 or true
		
		if type(func) ~= "function" then
			error("Couldn't find the function to register as a callback.", 2)
		end
		

		local args
		for i = 1, #funcsForEvent do
			local tbl = funcsForEvent[i]
			if tbl.func == func then
				args = tbl
				local found
				for i = 1, args.n do
					if args[i] == arg1 then
						found = true
						break
					end
				end
				if not found then
					args.n = args.n + 1
					args[args.n] = arg1
				end
				break
			end
		end
		if not args then
			args = {func = func, n = 1, arg1}
			funcsForEvent[#funcsForEvent + 1] = args
		end
	end

	function TMW:UnregisterCallback(event, func, arg1)
		if type(func) == "table" then
			local object = func
			func = object[arg1 or event]
			arg1 = object
		end
		arg1 = arg1 or true

		local funcs = callbackregistry[event]
		if funcs then
			for t = 1, #funcs do
				local tbl = funcs[t]
				if tbl and tbl.func == func then
					for i = 1, tbl.n do
						if tbl[i] == arg1 then
							tbl[i] = nil
						end
					end
					
					if firingsInProgress == 0 then
						removeNils(tbl)
						if tbl.n == 0 then
							wipe(tbl)
							tremove(funcs, t)
						end
					end
					
					break
				end
			end
		end
	end
	
	function TMW:UnregisterAllCallbacks(event)
		
		local funcs = callbackregistry[event]
		if funcs then
			for k, v in pairs(funcs) do
				wipe(v)
			end
			wipe(funcs)
			callbackregistry[event] = nil
		end
	end
	
	function TMW:Fire(event, ...)
		local funcs = callbackregistry[event]

		if funcs then
			local oldFiringsInProgress = firingsInProgress
			firingsInProgress = firingsInProgress + 1
			
			local funcsNeedsFix
			for t = 1, #funcs do
				local tbl = funcs[t]
				local method = tbl and tbl.func
				
				if method then
					local tblNeedsFix
					
					for index = 1, tbl.n do
						local arg1 = tbl[index]
						
						if arg1 == nil then
							tblNeedsFix = true
						elseif arg1 ~= true then
							safecall(method, arg1, event, ...)
						else
							safecall(method, event, ...)
						end
					end
					
					if tblNeedsFix then
						removeNils(tbl)
						if tbl.n == 0 then
							funcsNeedsFix = true
						end
					end
				end
			end
			
			if funcsNeedsFix then
				for t = #funcs, 1, -1 do
					if funcs[t].n == 0 then
						wipe(funcs[t])
						tremove(funcs, t)
					end
				end
				if #funcs == 0 then
					callbackregistry[event] = nil
				end
			end
			
			firingsInProgress = oldFiringsInProgress
		end
	end
end




---------------------------------
-- Tooltips
---------------------------------

local function TTOnEnter(self)
	if  (not self.__ttshowchecker or TMW.get(self[self.__ttshowchecker], self))
	and (self.__title or self.__text)
	then
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:AddLine(TMW.get(self.__title, self), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, false)
		GameTooltip:AddLine(TMW.get(self.__text, self), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, not self.__noWrapTooltipText)
		GameTooltip:Show()
	end
end
local function TTOnLeave(self)
	GameTooltip:Hide()
end

function TMW:TT(f, title, text, actualtitle, actualtext, showchecker)
	-- setting actualtitle or actualtext true cause it to use exactly what is passed in for title or text as the text in the tooltip
	-- if these variables arent set, then it will attempt to see if the string is a global variable (e.g. "MAXIMUM")
	-- if they arent set and it isnt a global, then it must be a TMW localized string, so use that
	
	TMW:ValidateType(2, "TMW:TT()", f, "frame")
	
	if title then
		f.__title = (actualtitle and title) or _G[title] or L[title]
	else
		f.__title = title
	end

	if text then
		f.__text = (actualtext and text) or _G[text] or L[text]
	else
		f.__text = text
	end
	
	f.__ttshowchecker = showchecker

	if not f.__ttHooked then
		f.__ttHooked = 1
		f:HookScript("OnEnter", TTOnEnter)
		f:HookScript("OnLeave", TTOnLeave)
	else
		if not f:GetScript("OnEnter") then
			f:HookScript("OnEnter", TTOnEnter)
		end
		if not f:GetScript("OnLeave") then
			f:HookScript("OnLeave", TTOnLeave)
		end
	end
end

function TMW:TT_Update(f)
	if f:IsMouseOver() and f:IsVisible() then
		f:GetScript("OnLeave")(f)
		if not f.IsEnabled or f:IsEnabled() or f:GetMotionScriptsWhileDisabled() then
			f:GetScript("OnEnter")(f)
		end
	end
end










-- -------------------------------------------------------------------------------------------------
-- |                                                                                               |
-- |                                       MAIN ADDON FUNCTIONS                                    |
-- |                                                                                               |
-- -------------------------------------------------------------------------------------------------








---------------------------------
-- Initialization
---------------------------------

-- ADDON ENTRY POINT: EVERYTHING STARTS FROM HERE!
function TMW:OnInitialize()
	-- if the file IS required for gross functionality
	if not TMW.Classes then
		-- this also includes upgrading from older than 3.0 (pre-Ace3 DB settings)
		-- GLOBALS: StaticPopupDialogs, StaticPopup_Show, EXIT_GAME, CANCEL, ForceQuit
		StaticPopupDialogs["TMW_RESTARTNEEDED"] = {
			text = L["ERROR_MISSINGFILE"], 
			button1 = EXIT_GAME,
			button2 = CANCEL,
			OnAccept = ForceQuit,
			timeout = 0,
			showAlert = true,
			whileDead = true,
			preferredIndex = 3, -- http://forums.wowace.com/showthread.php?p=320956
		}
		StaticPopup_Show("TMW_RESTARTNEEDED", TELLMEWHEN_VERSION_FULL, "TellMeWhen/Components/Core/Class.lua") -- arg3 could also be L["ERROR_MISSINGFILE_REQFILE"]
		return

	-- if the file is NOT required for gross functionality
	elseif not TMW.Classes.Item then
		StaticPopupDialogs["TMW_RESTARTNEEDED"] = {
			text = L["ERROR_MISSINGFILE_NOREQ"], 
			button1 = EXIT_GAME,
			button2 = CANCEL,
			OnAccept = ForceQuit,
			timeout = 0,
			showAlert = true,
			whileDead = true,
			preferredIndex = 3, -- http://forums.wowace.com/showthread.php?p=320956
		}
		StaticPopup_Show("TMW_RESTARTNEEDED", TELLMEWHEN_VERSION_FULL, "TellMeWhen/Components/Core/Common/Item.lua") -- arg3 could also be L["ERROR_MISSINGFILE_REQFILE"]
	end
	
	--------------- Events/OnUpdate ---------------
	TMW:SetScript("OnUpdate", TMW.OnUpdate)

	TMW:RegisterEvent("PLAYER_LOGIN")

	TMW:ProcessEquivalencies()
	
	TMW.OnInitialize = nil
end

function TMW:Initialize()
	-- Everything in this function is either database initialization
	-- or other initialization processes that depend on the database being initialized.
	
	-- This all used to be handled in the OnInitialize method, but with the advent of 
	-- fully modular icon modules and types, we need to be able to handle default settings
	-- and setting upgrades from 3rd-party addons that load after TMW, and this isn't possible
	-- if upgrades and database initialization are done before those addons have a chance to load.
	
	
	TMW.Initialize = TMW.NULLFUNC
	TMW.Initialized = true
	
	TMW:InitializeDatabase()
	

	-- DEFAULT_ICON_SETTINGS is used for comparisons against a blank icon setup,
	-- most commonly used to see if the user has configured an icon at all.
	TMW.DEFAULT_ICON_SETTINGS = TMW.db.profile.Groups[0].Icons[0]
	TMW.db.profile.Groups[0] = nil
	
	
	--------------- Communications ---------------
	
	-- Channel TMW is used for sharing data.
	-- ReceiveComm is a setting that allows users to disable receiving shared data.
	if TMW.db.profile.ReceiveComm then
		TMW:RegisterComm("TMW")
	end
	
	-- Channel TMWV is used for version notifications.
	TMW:RegisterComm("TMWV")
	
	TMW:Fire("TMW_INITIALIZE")
	TMW:UnregisterAllCallbacks("TMW_INITIALIZE")
	
	TMW.InitializedFully = true
end

function TMW:InitializeDatabase()
	
	TMW.InitializeDatabase = nil
	
	TMW.InitializedDatabase = true
	
	TMW:Fire("TMW_DB_INITIALIZING")
	TMW:UnregisterAllCallbacks("TMW_DB_INITIALIZING")
	
	--------------- Database ---------------
	if type(TellMeWhenDB) ~= "table" then
		-- TellMeWhenDB might not exist if this is a fresh install
		-- or if the user is upgrading from a really old version that uses TellMeWhen_Settings.
		TellMeWhenDB = {Version = TELLMEWHEN_VERSIONNUMBER}
	end
	

	-- This will very rarely actually set anything.
	-- TellMeWhenDB.Version is set when then DB is first created,
	-- but, if this setting doesn't yet exist then the user has a really old version
	-- from before TellMeWhenDB.Version existed, so set it to 0 so we make sure to do all of the upgrades here
	TellMeWhenDB.Version = TellMeWhenDB.Version or 0
	
	-- Handle upgrades that need to be done before defaults are added to the database.
	-- Primary purpose of this is to properly upgrade settings if a default has changed.
	TMW:RawUpgrade()
	
	-- Initialize the database
	TMW.db = AceDB:New("TellMeWhenDB", TMW.Defaults)
	
	if TellMeWhen_Settings then
		for k, v in pairs(TellMeWhen_Settings) do
			TMW.db.profile[k] = v
		end
		TMW.db = AceDB:New("TellMeWhenDB", TMW.Defaults)
		TMW.db.profile.Version = TellMeWhen_Settings.Version
		TellMeWhen_Settings = nil
	end
	
	TMW.db.RegisterCallback(TMW, "OnProfileChanged",	"OnProfile")
	TMW.db.RegisterCallback(TMW, "OnProfileCopied",		"OnProfile")
	TMW.db.RegisterCallback(TMW, "OnProfileReset",		"OnProfile")
	TMW.db.RegisterCallback(TMW, "OnNewProfile",		"OnProfile")
	
	-- Handle normal upgrades after the database has been initialized.
	TMW:UpgradeGlobal()
	TMW:UpgradeProfile()
	
	TMW:Fire("TMW_DB_INITIALIZED")
	TMW:UnregisterAllCallbacks("TMW_DB_INITIALIZED")
end

function TMW:PLAYER_LOGIN()
	TMW:UnregisterEvent("PLAYER_LOGIN")
	TMW.PLAYER_LOGIN = nil
	
	TMW:RegisterEvent("PLAYER_ENTERING_WORLD")
	TMW:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	TMW:RegisterEvent("PLAYER_TALENT_UPDATE", "PLAYER_SPECIALIZATION_CHANGED")
	TMW:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "PLAYER_SPECIALIZATION_CHANGED")
	
	-- Yeah,  I do it twice. Masque is a heap of broken shit and doesn't work unless its done twice.
	-- Especially when logging in while in combat with the Allow Config in Combat option disabled
	TMW:Update()
	TMW:Update()
end





---------------------------------
-- Upgrade Functions
---------------------------------

TMW.UpgradeTable = {}
TMW.UpgradeTableByVersions = {}

function TMW:GetBaseUpgrades()			-- upgrade functions
	return {
		[62304] = {
			profile = function(self)
				for k, v in pairs(TMW.db.profile.Colors) do
					if not (
						(v.CBC.r == 0 and v.CBC.g == 1 and v.CBC.b == 0 and 
						 v.CBS.r == 1 and v.CBS.g == 0 and v.CBS.b == 0)  
					or	(v.CBC.r == 1 and v.CBC.g == 0 and v.CBC.b == 0 and 
						 v.CBS.r == 0 and v.CBS.g == 1 and v.CBS.b == 0))
					then
						v.CBM.r = (v.CBC.r + v.CBS.r) / 2
						v.CBM.g = (v.CBC.g + v.CBS.g) / 2
						v.CBM.b = (v.CBC.b + v.CBS.b) / 2
					end

					v.CBM.a = (v.CBC.a + v.CBS.a) / 2

					if v.CBC.Override and v.CBS.Override then
						v.CBM.Override = true
					end
				end
			end
		},
		[62216] = {
			global = function(self)
				if type(TMW.db.global.WpnEnchDurs) == "table" then
					for k, v in pairs(TMW.db.global.WpnEnchDurs) do
						TMW.db.locale.WpnEnchDurs[k] = max(TMW.db.locale.WpnEnchDurs[k] or 0, v)
					end
					TMW.db.global.WpnEnchDurs = nil
				end
			end
		},
		[60027] = {
			icon = function(self, ics)
				ics.Name = ics.Name:gsub("IncreasedSPsix", "IncreasedSP")
				ics.Name = ics.Name:gsub("IncreasedSPten", "IncreasedSP")
			end,
		},
		[60012] = {
			global = function(self)
				TMW.db.global.HelpSettings.HasChangedUnit = nil
			end,
		},
		[60008] = {
			icon = function(self, ics)
				if ics.ShowWhen == "alpha" or ics.ShowWhen == nil then
					ics.ShowWhen = 0x2
				elseif ics.ShowWhen == "unalpha" then
					ics.ShowWhen = 0x1
				elseif ics.ShowWhen == "always" then
					ics.ShowWhen = 0x3
				end
			end,
		},
		[51023] = {
			icon = function(self, ics)
				ics.InvertBars = nil
			end,
		},
		[51006] = {
			profile = function(self)
				if TMW.db.profile.MasterSound then
					TMW.db.profile.SoundChannel = "Master"
				else
					TMW.db.profile.SoundChannel = "SFX"
				end
				TMW.db.profile.MasterSound = nil
			end,
		},
		[51002] = {
			translations = {
				t = "['target':Name]",
				f = "['focus':Name]",
				m = "['mouseover':Name]",
				u = "[Unit:Name]",
				p = "[PreviousUnit:Name]",
				s = "[Spell]",
				k = "[Stacks]",
				d = "[Duration:TMWFormatDuration]",
				o = "[Source:Name]",
				e = "[Destination:Name]",
				x = "[Extra]",
			},
			translateString = function(self, string)
				for originalLetter, translation in pairs(self.translations) do
					string = string:gsub("%%[" .. originalLetter .. originalLetter:upper() .. "]", translation)
				end
				return string
			end,
		},
		[50028] = {
			icon = function(self, ics)
				local Events = ics.Events
				
				-- dont use InNLengthTable here
				--(we need to make sure to do it to everything, not just events that are currently valid. Just in case...)
				for _, eventSettings in ipairs(Events) do
					local eventData = TMW.EventList[eventSettings.Event]
					if eventData and eventData.applyDefaultsToSetting then
						eventData.applyDefaultsToSetting(eventSettings)
					end
				end
			end,
		},
		[48025] = {
			icon = function(self, ics)
				ics.Name = gsub(ics.Name, "(CrowdControl)", "%1; " .. GetSpellInfo(339))
			end,
		},
		[47002] = {
			map = {
				CBS = "CDSTColor",
				CBC = "CDCOColor",
				OOR = "OORColor",
				OOM = "OOMColor",
				OORM = "OORColor",

				-- i didn't upgrade these 2 because they suck
				--PRESENTColor =	{r=1, g=1, b=1, a=1},
				--ABSENTColor	 =	{r=1, g=0.35, b=0.35, a=1},
			},
			
			profile = function(self)
				for newKey, oldKey in pairs(self.map) do
					local old = TMW.db.profile[oldKey]
					local new = TMW.db.profile.Colors.GLOBAL[newKey]

					if old then
						for k, v in pairs(old) do
							new[k] = v
						end

						TMW.db.profile[oldKey] = nil
					end
				end

			end,
		},
		[46605] = {
			-- Added 8-10-12 (Noticed CooldownType cluttering up old upgrades; this setting isn't used anymore.)
			icon = function(self, ics)
				ics.CooldownType = nil
			end,
		},
		[46604] = {
			icon = function(self, ics)
				if ics.CooldownType == "multistate" and ics.Type == "cooldown" then
					ics.Type = "multistate"
					ics.CooldownType = TMW.Icon_Defaults.CooldownType
				end
			end,
		},
		[46418] = {
			global = function(self)
				TMW.db.global.HelpSettings.ResetCount = nil
			end,
		},
		[46202] = {
			icon = function(self, ics)
				if ics.CooldownType == "item" and ics.Type == "cooldown" then
					ics.Type = "item"
					ics.CooldownType = TMW.Icon_Defaults.CooldownType
				end
			end,
		},
		[45605] = {
			global = function(self)
				if TMW.db.global.SeenNewDurSyntax then
					TMW.db.global.HelpSettings.NewDurSyntax = TMW.db.global.SeenNewDurSyntax
					TMW.db.global.SeenNewDurSyntax = nil
				end
			end,
		},
		--[[[45402] = {
			group = function(self, gs)
				gs.OnlyInCombat = false
			end,
		},]]
		[45008] = {
			group = function(self, gs)
				-- Desc: Transfers stack text settings from the old gs.Font table to the new gs.Fonts.Count table
				if gs.Font then
					gs.Fonts = gs.Fonts or {}
					gs.Fonts.Count = gs.Fonts.Count or {}
					for k, v in pairs(gs.Font) do
						gs.Fonts.Count[k] = v
						gs.Font[k] = nil
					end
				end
			end,
		},
		[44009] = {
			profile = function(self)
				TMW.db.profile.WpnEnchDurs = nil

				TMW.db.profile.HasImported = nil
			end,
		},
		[44003] = {
			icon = function(self, ics)
				if ics.Type == "unitcooldown" or ics.Type == "icd" then
					local duration = ics.ICDDuration or 45 -- 45 was the old default
					ics.Name = TMW:CleanString(gsub(ics.Name..";", ";", ": "..duration.."; "))
					ics.ICDDuration = nil
				end
			end,
		},
		[44002] = {
			icon = function(self, ics)
				if ics.Type == "autoshot" then
					ics.Type = "cooldown"
					ics.CooldownType = "spell"
					ics.Name = 75
				end
			end,
		},
		[43002] = {
			WhenChecks = {
				cooldown = "CooldownShowWhen",
				buff = "BuffShowWhen",
				reactive = "CooldownShowWhen",
				wpnenchant = "BuffShowWhen",
				totem = "BuffShowWhen",
				unitcooldown = "CooldownShowWhen",
				dr = "CooldownShowWhen",
				icd = "CooldownShowWhen",
				cast = "BuffShowWhen",
			},
			Defaults = {
				CooldownShowWhen	= "usable",
				BuffShowWhen		= "present",
			},
			Conversions = {
				usable		= "alpha",
				present		= "alpha",
				unusable	= "unalpha",
				absent		= "unalpha",
				always		= "always",
			},
			
			icon = function(self, ics)
				local setting = self.WhenChecks[ics.Type]
				if setting then
					ics.ShowWhen = self.Conversions[ics[setting] or self.Defaults[setting]] or ics[setting] or self.Defaults[setting]
				end
				ics.CooldownShowWhen = nil
				ics.BuffShowWhen = nil
			end,
		},
		[43001] = {
			profile = function(self)
				-- at first glance, this should be a group upgrade,
				-- but it is actually a profile upgrade.
				-- we dont want to do it to individual groups that have been imported
				-- because TMW.db.profile.Font wont exist at that point.
				-- we only want to do it to groups that exist in whatever profile is being upgraded
				if TMW.db.profile.Font then
					for gs in TMW:InGroupSettings() do
						gs.Font = gs.Font or {}
						for k, v in pairs(TMW.db.profile.Font) do
							gs.Font[k] = v
						end
					end
					TMW.db.profile.Font = nil
				end
			end,
		},
		[41301] = {
			stances = {
				{class = "WARRIOR", 	id = 2457}, 	-- Battle Stance
				{class = "WARRIOR", 	id = 71}, 		-- Defensive Stance
				{class = "WARRIOR", 	id = 2458}, 	-- Berserker Stance

				{class = "DRUID", 		id = 5487}, 	-- Bear Form
				{class = "DRUID", 		id = 768}, 		-- Cat Form
				{class = "DRUID", 		id = 1066}, 	-- Aquatic Form
				{class = "DRUID", 		id = 783}, 		-- Travel Form
				{class = "DRUID", 		id = 24858}, 	-- Moonkin Form
				{class = "DRUID", 		id = 33891}, 	-- Tree of Life
				{class = "DRUID", 		id = 33943}, 	-- Flight Form
				{class = "DRUID", 		id = 40120}, 	-- Swift Flight Form

				{class = "PRIEST", 		id = 15473}, 	-- Shadowform

				{class = "ROGUE", 		id = 1784}, 	-- Stealth

				{class = "HUNTER", 		id = 82661}, 	-- Aspect of the Fox
				{class = "HUNTER", 		id = 13165}, 	-- Aspect of the Hawk
				{class = "HUNTER", 		id = 5118}, 	-- Aspect of the Cheetah
				{class = "HUNTER", 		id = 13159}, 	-- Aspect of the Pack
				{class = "HUNTER", 		id = 20043}, 	-- Aspect of the Wild

				{class = "DEATHKNIGHT", id = 48263}, 	-- Blood Presence
				{class = "DEATHKNIGHT", id = 48266}, 	-- Frost Presence
				{class = "DEATHKNIGHT", id = 48265}, 	-- Unholy Presence

				{class = "PALADIN", 	id = 19746}, 	-- Concentration Aura
				{class = "PALADIN", 	id = 32223}, 	-- Crusader Aura
				{class = "PALADIN", 	id = 465}, 		-- Devotion Aura
				{class = "PALADIN", 	id = 19891}, 	-- Resistance Aura
				{class = "PALADIN", 	id = 7294}, 	-- Retribution Aura

				{class = "WARLOCK", 	id = 47241}, 	-- Metamorphosis
			},
	
			setupcsn = function(self)
				self.CSN = {
					[0]	= NONE,
				}

				for _, stanceData in ipairs(self.stances) do
					if stanceData.class == pclass then
						local stanceName = GetSpellInfo(stanceData.id)
						tinsert(self.CSN, stanceName)
					end
				end

				for i, stanceName in pairs(self.CSN) do
					self.CSN[stanceName] = i
				end

			end,

			group = function(self, gs)
				if not self.CSN then
					self:setupcsn()
				end
				
				local Conditions = gs.Conditions

				if gs.NotInVehicle then
					local condition = Conditions[#Conditions + 1]
					condition.Type = "VEHICLE"
					condition.Level = 1
					gs.NotInVehicle = nil
				end
				if gs.Stance then
					local nume = {}
					local numd = {}
					for id = 0, #self.CSN do
						local sn = self.CSN[id]
						local en = gs.Stance[sn]
						if en == false then
							tinsert(numd, id)
						elseif en == nil or en == true then
							tinsert(nume, id)
						end
					end
					if #nume ~= 0 then
						local start = #Conditions + 1
						if #nume <= ceil(#self.CSN/2) then

							for _, value in ipairs(nume) do
								local condition = Conditions[#Conditions + 1]
								condition.Type = "STANCE"
								condition.Operator = "=="
								condition.Level = value
								condition.AndOr = "OR"
							end
							Conditions[start].AndOr = "AND"
							if #Conditions > #nume then
								Conditions[start].PrtsBefore = 1
								Conditions[#Conditions].PrtsAfter = 1
							end
						elseif #numd > 0 then

							for _, value in ipairs(numd) do
								local condition = Conditions[#Conditions + 1]
								condition.Type = "STANCE"
								condition.Operator = "~="
								condition.Level = value
								condition.AndOr = "AND"
							end
							if #Conditions > #numd then
								Conditions[start].PrtsBefore = 1
								Conditions[#Conditions].PrtsAfter = 1
							end
						end
					end
					gs.Stance = nil
				end
			end,
		},
		[40124] = {
			profile = function(self)
				TMW.db.profile.Revision = nil-- unused
			end,
		},
		[40111] = {
			icon = function(self, ics)
				ics.Unit = TMW:CleanString((ics.Unit .. ";"):	-- it wont change things at the end of the unit string without a character after the unit at the end
				gsub("raid[^%d]", "raid1-25;"):
				gsub("party[^%d]", "party1-4;"):
				gsub("arena[^%d]", "arena1-5;"):
				gsub("boss[^%d]", "boss1-4;"):
				gsub("maintank[^%d]", "maintank1-5;"):
				gsub("mainassist[^%d]", "mainassist1-5;"))
			end,
		},
		[40080] = {
			group = function(self, gs)
				if gs.Stance and (gs.Stance[L["NONE"]] == false or gs.Stance[L["CASTERFORM"]] == false) then
					gs.Stance[L["NONE"]] = nil
					gs.Stance[L["CASTERFORM"]] = nil
					-- GLOBALS: NONE
					gs.Stance[NONE] = false
				end
			end,
		},
		[40060] = {
			profile = function(self)
				TMW.db.profile.Texture = nil --now i get the texture from LSM the right way instead of saving the texture path
			end,
		},
		[40010] = {
			icon = function(self, ics)
				if ics.Type == "multistatecd" then
					ics.Type = "cooldown"
					ics.CooldownType = "multistate"
				end
			end,
		},
		[40001] = {
			profile = function(self)
				TMW.db.profile.Spacing = nil
			end,
		},
		[40000] = {
			profile = function(self)
				TMW.db.profile.Locked = false
			end,
			group = function(self, gs)
				gs.Spacing = TMW.db.profile.Spacing or 0
			end,
			icon = function(self, ics)
				if ics.Type == "icd" then
					ics.CooldownShowWhen = ics.ICDShowWhen or "usable"
					ics.ICDShowWhen = nil
				end
			end,
		},
		[30000] = {
			profile = function(self)
				TMW.db.profile.NumGroups = 10
				TMW.db.profile.Condensed = nil
				TMW.db.profile.NumCondits = nil
				TMW.db.profile.DSN = nil
				TMW.db.profile.UNUSEColor = nil
				TMW.db.profile.USEColor = nil
				
				if TMW.db.profile.Font and TMW.db.profile.Font.Outline == "THICK" then
					TMW.db.profile.Font.Outline = "THICKOUTLINE"
				end
			end,
			
			stances = {
				{class = "WARRIOR", 	id = 2457}, 	-- Battle Stance
				{class = "WARRIOR", 	id = 71}, 		-- Defensive Stance
				{class = "WARRIOR", 	id = 2458}, 	-- Berserker Stance

				{class = "DRUID", 		id = 5487}, 	-- Bear Form
				{class = "DRUID", 		id = 768}, 		-- Cat Form
				{class = "DRUID", 		id = 1066}, 	-- Aquatic Form
				{class = "DRUID", 		id = 783}, 		-- Travel Form
				{class = "DRUID", 		id = 24858}, 	-- Moonkin Form
				{class = "DRUID", 		id = 33891}, 	-- Tree of Life
				{class = "DRUID", 		id = 33943}, 	-- Flight Form
				{class = "DRUID", 		id = 40120}, 	-- Swift Flight Form

				{class = "PRIEST", 		id = 15473}, 	-- Shadowform

				{class = "ROGUE", 		id = 1784}, 	-- Stealth

				{class = "HUNTER", 		id = 82661}, 	-- Aspect of the Fox
				{class = "HUNTER", 		id = 13165}, 	-- Aspect of the Hawk
				{class = "HUNTER", 		id = 5118}, 	-- Aspect of the Cheetah
				{class = "HUNTER", 		id = 13159}, 	-- Aspect of the Pack
				{class = "HUNTER", 		id = 20043}, 	-- Aspect of the Wild

				{class = "DEATHKNIGHT", id = 48263}, 	-- Blood Presence
				{class = "DEATHKNIGHT", id = 48266}, 	-- Frost Presence
				{class = "DEATHKNIGHT", id = 48265}, 	-- Unholy Presence

				{class = "PALADIN", 	id = 19746}, 	-- Concentration Aura
				{class = "PALADIN", 	id = 32223}, 	-- Crusader Aura
				{class = "PALADIN", 	id = 465}, 		-- Devotion Aura
				{class = "PALADIN", 	id = 19891}, 	-- Resistance Aura
				{class = "PALADIN", 	id = 7294}, 	-- Retribution Aura

				{class = "WARLOCK", 	id = 47241}, 	-- Metamorphosis
			},
	
			setupcsn = function(self)
				self.CSN = {
					[0]	= NONE,
				}

				for _, stanceData in ipairs(self.stances) do
					if stanceData.class == pclass then
						local stanceName = GetSpellInfo(stanceData.id)
						tinsert(self.CSN, stanceName)
					end
				end

				for i, stanceName in pairs(self.CSN) do
					self.CSN[stanceName] = i
				end

			end,

			group = function(self, gs)
				gs.LBFGroup = nil
				
				if not self.CSN then
					self:setupcsn()
				end
				
				if gs.Stance then
					for k, v in pairs(gs.Stance) do
						if self.CSN[k] then
							if v then -- everything switched in this version
								gs.Stance[self.CSN[k]] = false
							else
								gs.Stance[self.CSN[k]] = true
							end
							gs.Stance[k] = nil
						end
					end
				end
			end,
			iconSettingsToClear = {
				OORColor = true,
				OOMColor = true,
				Color = true,
				ColorOverride = true,
				UnColor = true,
				DurationAndCD = true,
				Shapeshift = true, -- i used this one during some initial testing for shapeshifts
				UnitReact = true,
			},
			icon = function(self, ics, groupID, iconID)
				for k in pairs(self.iconSettingsToClear) do
					ics[k] = nil
				end

				-- this is part of the old CondenseSettings (but modified slightly),
				-- just to get rid of values that are defined in the saved variables that dont need to be
				-- (basically, they were set automatically on accident, most of them in early versions)
				local nondefault = 0
				local n = 0
				for s, v in pairs(ics) do
					if (type(v) ~= "table" and v ~= TMW.Icon_Defaults[s]) or (type(v) == "table" and #v ~= 0) then
						nondefault = nondefault + 1
						if (s == "Enabled") or (s == "ShowTimerText") then
							n = n+1
						end
					end
				end
				if n == nondefault then
					TMW.db.profile.Groups[groupID].Icons[iconID] = nil
				end
			end,
		},
		[24000] = {
			icon = function(self, ics)
				ics.Name = gsub(ics.Name, "StunnedOrIncapacitated", "Stunned;Incapacitated")
				
				-- Changed in 60027 to "IncreasedSP" instead of "IncreasedSPsix;IncreasedSPten"
				--ics.Name = gsub(ics.Name, "IncreasedSPboth", "IncreasedSPsix;IncreasedSPten")
				ics.Name = gsub(ics.Name, "IncreasedSPboth", "IncreasedSP")
				
				
				if ics.Type == "darksim" then
					ics.Type = "multistatecd"
					ics.Name = "77606"
				end
			end,
		},
		[22100] = {
			icon = function(self, ics)
				if ics.UnitReact and ics.UnitReact ~= 0 then
					local condition = ics.Conditions[#ics.Conditions + 1]
					condition.Type = "REACT"
					condition.Level = ics.UnitReact
					condition.Unit = "target"
				end
			end,
		},
		[21200] = {
			icon = function(self, ics)
				if ics.WpnEnchantType == "thrown" then
					ics.WpnEnchantType = "RangedSlot"
				elseif ics.WpnEnchantType == "offhand" then
					ics.WpnEnchantType = "SecondaryHandSlot"
				elseif ics.WpnEnchantType == "mainhand" then --idk why this would happen, but you never know
					ics.WpnEnchantType = "MainHandSlot"
				end
			end,
		},
		[15400] = {
			icon = function(self, ics)
				if ics.Alpha == 0.01 then ics.Alpha = 1 end
			end,
		},
		[15300] = {
			icon = function(self, ics)
				if ics.Alpha > 1 then
					ics.Alpha = (ics.Alpha / 100)
				else
					ics.Alpha = 1
				end
			end,
		},
		[12000] = {
			profile = function(self)
				TMW.db.profile.Spec = nil
			end,
		},

	}
end

function TMW:RegisterUpgrade(version, data)
	assert(not data.Version, "Upgrade data cannot store a value with key 'Version' because it is a reserved key.")
	
	if TMW.HaveUpgradedOnce then
		error("Upgrades are being registered too late. They need to be registered before any upgrades occur.", 2)
	end
	
	local upgradeSet = TMW.UpgradeTableByVersions[version]
	if upgradeSet then
		-- An upgrade set already exists for this version, so we need to merge the two.
		for k, v in pairs(data) do
			if upgradeSet[k] ~= nil then
				if type(v) == "function" then
					-- If we already have a function with the same key (E.g. 'icon' or 'group')
					-- then hook the existing function so that both run
					hooksecurefunc(upgradeSet, k, v)
				else
					-- If we already have data with the same key (some kind of helper data for the upgrade)
					-- then raise an error because there will certainly be conflicts.
					error(("A value with key %q already exists for upgrades for version %d. Please choose a different key to store it in to prevent conflicts.")
					:format(k, version), 2)
				end
			else
				-- There was nothing already in place, so just stick it in the upgrade set as-is.
				upgradeSet[k] = v
			end
		end
	else
		-- An upgrade set doesn't exist for this version,
		-- so just use the table that was passed in and process it as a new upgrade set.
		data.Version = version
		TMW.UpgradeTableByVersions[version] = data
		tinsert(TMW.UpgradeTable, data)
	end
end

function TMW.UpgradeTableSorter(a, b)
	if a.priority or b.priority then
		if a.priority and b.priority then
			return a.priority < b.priority
		else
			return a.priority
		end
	end
	return a.Version < b.Version
end
function TMW:SortUpgradeTable()
	sort(TMW.UpgradeTable, TMW.UpgradeTableSorter)
end

function TMW:GetUpgradeTable()	
	if TMW.GetBaseUpgrades then		
		for version, data in pairs(TMW:GetBaseUpgrades()) do
			TMW:RegisterUpgrade(version, data)
		end
		
		TMW.GetBaseUpgrades = nil
	end
	
	TMW:SortUpgradeTable()
	
	return TMW.UpgradeTable
end


function TMW:DoUpgrade(type, version, ...)
	assert(_G.type(type) == "string")
	assert(_G.type(version) == "number")
	
	-- upgrade the actual requested setting
	for k, v in ipairs(TMW:GetUpgradeTable()) do
		if v.Version > version then
			if v[type] then
				v[type](v, ...)
			end
		end
	end
	
	TMW:Fire("TMW_UPGRADE_REQUESTED", type, version, ...)

	-- delegate out to sub-types
	if type == "global" then
		-- delegate to locale
		for locale, ls in pairs(TMW.db.locale) do
			TMW:DoUpgrade("locale", version, ls, locale)
		end
	
		--All Global Upgrades Complete
		TellMeWhenDB.Version = TELLMEWHEN_VERSIONNUMBER
	elseif type == "profile" then
		-- delegate to groups
		for gs, groupID in TMW:InGroupSettings() do
			TMW:DoUpgrade("group", version, gs, groupID)
		end
		
		--All Profile Upgrades Complete
		TMW.db.profile.Version = TELLMEWHEN_VERSIONNUMBER
	elseif type == "group" then
		local gs, groupID = ...
		
		-- delegate to icons
		for ics, groupID, iconID in TMW:InIconSettings(groupID) do
			TMW:DoUpgrade("icon", version, ics, groupID, iconID)
		end
	end
	
	TMW.HaveUpgradedOnce = true
end


function TMW:RawUpgrade()

	TMW.RawUpgrade = nil
	
	if TellMeWhenDB.Version == 414069 then
		 -- Well, that was a mighty fine fail that this happened.
		TellMeWhenDB.Version = 41409
	end


	-- Begin DB upgrades that need to be done before defaults are added.
	-- Upgrades here should always do everything needed to every single profile,
	-- and remember to check if a table exists before iterating/indexing it.

	if TellMeWhenDB.profiles then
		if TellMeWhenDB.Version < 41402 then
			for _, p in pairs(TellMeWhenDB.profiles) do
				if p.Groups then
					for _, gs in pairs(p.Groups) do
						if gs.Point then
							gs.Point.point = gs.Point.point or "TOPLEFT"
							gs.Point.relativePoint = gs.Point.relativePoint or "TOPLEFT"
						end
					end
				end
			end
		end
		if TellMeWhenDB.Version < 41410 then
			for _, p in pairs(TellMeWhenDB.profiles) do
				if p.Version == 414069 then
					p.Version = 41409
				end
				if type(p.Version) == "string" then
					local v = gsub(p.Version, "[^%d]", "") -- remove decimals
					v = v..strrep("0", 5-#v)	-- append zeroes to create a 5 digit number
					p.Version = tonumber(v)
				end
				if type(p.Version) == "number" and p.Version < 41401 and not p.NumGroups then -- 41401 is intended here, i already did a crapper version of this upgrade
					p.NumGroups = 10
				end
			end
		end
		
		if TellMeWhenDB.Version < 46407 then
			local HelpSettings = TellMeWhenDB.global and TellMeWhenDB.global.HelpSettings

			if HelpSettings then
				HelpSettings.ICON_DURS_FIRSTSEE = HelpSettings.NewDurSyntax
				HelpSettings.NewDurSyntax = nil

				HelpSettings.ICON_POCKETWATCH_FIRSTSEE = HelpSettings.PocketWatch
				HelpSettings.PocketWatch = nil
			end
		end
	end
	
	TMW:Fire("TMW_DB_PRE_DEFAULT_UPGRADES")
	TMW:UnregisterAllCallbacks("TMW_DB_PRE_DEFAULT_UPGRADES")
end

function TMW:UpgradeGlobal()
	if TellMeWhenDB.Version < TELLMEWHEN_VERSIONNUMBER then
		TMW:DoUpgrade("global", TellMeWhenDB.Version, TMW.db.global)
	end

	-- This isn't needed anymore
	TMW.UpgradeGlobal = nil
end

function TMW:UpgradeProfile()
	-- Set the version for the current profile to the current version if it is a new profile.
	TMW.db.profile.Version = TMW.db.profile.Version or TELLMEWHEN_VERSIONNUMBER
	
	if type(TMW.db.profile.Version) == "string" then
		local v = gsub(TMW.db.profile.Version, "[^%d]", "") -- remove decimals
		v = v..strrep("0", 5-#v)	-- append zeroes to create a 5 digit number
		TMW.db.profile.Version = tonumber(v)
	end
	
	if TellMeWhenDB.Version < TELLMEWHEN_VERSIONNUMBER then
		TMW:DoUpgrade("global", TellMeWhenDB.Version, TMW.db.global)
	end
	
	if TMW.db.profile.Version < TELLMEWHEN_VERSIONNUMBER then
		TMW:DoUpgrade("profile", TMW.db.profile.Version, TMW.db.profile)
	end
end





---------------------------------
-- Update Functions
---------------------------------

do	-- TMW:OnUpdate()

	local updateInProgress, shouldSafeUpdate
	local start
	local inCombatLockdown = 1

	-- Limit in milliseconds for each OnUpdate cycle.
	local CoroutineLimit = 50

	TMW:RegisterEvent("UNIT_FLAGS", function(event, unit)
		if unit == "player" then
			inCombatLockdown = InCombatLockdown()
		end
	end)

	local function checkYield()
		if inCombatLockdown and debugprofilestop() - start > CoroutineLimit then
			coroutine.yield()

			TMW:Debug("OnUpdate yielded early at %s", time)
		end
	end

	-- This is the main update engine of TMW.
	local function OnUpdate()
		while true do
			time = GetTime()
			TMW.time = time

			if updateInProgress then
				-- If the previous update cycle didn't finish (updateInProgress is still true)
				-- then we should enable safecalling icon updates in order to prevent catastrophic failure of the whole addon
				-- if only one icon or icon type is malfunctioning.
				if not shouldSafeUpdate then
					TMW:Debug("Update error detected. Switching to safe update mode!")
				end
				shouldSafeUpdate = true
			end
			updateInProgress = true
			
			TMW:Fire("TMW_ONUPDATE_PRE", time, Locked)
			
			if LastUpdate <= time - UPD_INTV then
				LastUpdate = time
				_, GCD=GetSpellCooldown(GCDSpell)
				TMW.GCD = GCD

				TMW:Fire("TMW_ONUPDATE_TIMECONSTRAINED_PRE", time, Locked)
				
				if Locked then
					for i = 1, #GroupsToUpdate do
						-- GroupsToUpdate only contains groups with conditions
						local group = GroupsToUpdate[i]
						local ConditionObject = group.ConditionObject
						if ConditionObject and (ConditionObject.UpdateNeeded or ConditionObject.NextUpdateTime < time) then
							ConditionObject:Check()
							checkYield()
						end
					end
			
					if shouldSafeUpdate then
						for i = 1, #IconsToUpdate do
							local icon = IconsToUpdate[i]
							safecall(icon.Update, icon)
							checkYield()
						end
					else
						for i = 1, #IconsToUpdate do
							--local icon = IconsToUpdate[i]
							IconsToUpdate[i]:Update()
							checkYield()
						end
					end
				end

				TMW:Fire("TMW_ONUPDATE_TIMECONSTRAINED_POST", time, Locked)
			end

			updateInProgress = nil
			
			checkYield()

			TMW:Fire("TMW_ONUPDATE_POST", time, Locked)

			coroutine.yield()
		end
	end

	
	local Coroutine
	function TMW:OnUpdate()
		start = debugprofilestop()

		if not Coroutine or coroutine.status(Coroutine) == "dead" then
			if Coroutine then
				TMW:Debug("Rebirthed OnUpdate coroutine at %s", time)
			end

			Coroutine = coroutine.create(OnUpdate)
		end

		coroutine.resume(Coroutine)
	end
end


function TMW:UpdateNormally()
	TMW:Initialize()
	
	if not TMW.InitializedFully then
		return
	end
	
	if not TMW:CheckCanDoLockedAction() then
		return
	end
	
	time = GetTime()
	TMW.time = time
	LastUpdate = 0

	Locked = TMW.db.profile.Locked
	TMW.Locked = Locked
	
	if not Locked then
		TMW:LoadOptions()
	end
	
	wipe(SpellTextures)
	SpellTextures = TMW:CopyTableInPlaceWithMeta(TMW.SpellTexturesBase, SpellTextures)
	
	-- Add a very small amount so that we don't call the same icon multiple times
	-- in the same frame if the interval has been set 0.
	UPD_INTV = TMW.db.profile.Interval + 0.001
	TMW.UPD_INTV = UPD_INTV
	
	TMW:Fire("TMW_GLOBAL_UPDATE") -- the placement of this matters. Must be after options load, but before icons are updated

	for key, Type in pairs(TMW.Types) do
		Type:UpdateColors(true)
	end

	for groupID = 1, max(TMW.db.profile.NumGroups, #TMW) do
		-- cant use TMW.InGroups() because groups wont exist yet on the first call of this, so they would never be able to exists
		-- even if it shouldn't be setup (i.e. it has been deleted or the user changed profiles)
		local group = TMW[groupID] or TMW.Classes.Group:New("Frame", "TellMeWhen_Group" .. groupID, TMW, "TellMeWhen_GroupTemplate", groupID)
		TMW.safecall(group.Setup, group)
	end

	if not Locked then
		TMW:DoValidityCheck()
	end

	TMW:ScheduleTimer("DoInitialWarn", 3)

	TMW:Fire("TMW_GLOBAL_UPDATE_POST")
end

do -- TMW:UpdateViaCoroutine()

-- Blizzard's execution cap in combat is 200ms.
-- We will be extra safe and go for 100ms.
-- But actually, we will use 50ms, because somehow we are still getting extremely rare 'script ran too long' errors
local COROUTINE_MAX_TIME_PER_FRAME = 50

local NumCoroutinesQueued = 0
local CoroutineStartTime
local UpdateCoroutine

local safecall_safe = TMW.safecall

local function safecall_coroutine(func, ...)
	return true, func(...)
end

local function CheckCoroutineTermination()
	if UpdateCoroutine and debugprofilestop() - CoroutineStartTime > COROUTINE_MAX_TIME_PER_FRAME then
		coroutine.yield(UpdateCoroutine)
	end
end

local function OnUpdateDuringCoroutine(self)
	-- This is an OnUpdate script, but don't be too concerned with performance because it is only used
	-- when lock toggling in combat. Safety of the code (don't let it error!) is far more important than performance here.
	time = GetTime()
	TMW.time = time
	
	CoroutineStartTime = debugprofilestop()
	
	if not IsAddOnLoaded("TellMeWhen_Options") then
		error("TellMeWhen_Options was not loaded before a coroutine update happened. It is supposed to load before PLAYER_ENTERING_WORLD if the AllowCombatConfig setting is enabled!")
	end
	
	if NumCoroutinesQueued == 0 then
		TMW.safecall = safecall_safe
		safecall = safecall_safe
		
		--TMW:Print(L["SAFESETUP_COMPLETE"])
		TMW:Fire("TMW_SAFESETUP_COMPLETE")
		
		TMW:SetScript("OnUpdate", TMW.OnUpdate)
	else
		-- Yielding a coroutine inside a pcall/xpcall isn't permitted,
		-- so we will just have to temporarily throw all error protection out the window.
		TMW.safecall = safecall_coroutine
		safecall = safecall_coroutine
		
		if not UpdateCoroutine then
			UpdateCoroutine = coroutine.create(TMW.UpdateNormally)
			CheckCoroutineTermination() -- Make sure we haven't already exceeded this frame's threshold (from loading options, creating the coroutine, etc.)
		end
		
		TMW:RegisterCallback("TMW_ICON_SETUP_POST", CheckCoroutineTermination)
		TMW:RegisterCallback("TMW_GROUP_SETUP_POST", CheckCoroutineTermination)

		
		if coroutine.status(UpdateCoroutine) == "dead" then
			UpdateCoroutine = nil
			NumCoroutinesQueued = NumCoroutinesQueued - 1
		else
			local success, err = coroutine.resume(UpdateCoroutine)
			if not success then
				--TMW:Printf(L["SAFESETUP_FAILED"], err)
				TMW:Fire("TMW_SAFESETUP_COMPLETE")
				TMW:Error(err)
			end
		end
		
		TMW:UnregisterCallback("TMW_ICON_SETUP_POST", CheckCoroutineTermination)
		TMW:UnregisterCallback("TMW_GROUP_SETUP_POST", CheckCoroutineTermination)
	end
end

function TMW:UpdateViaCoroutine()
	if NumCoroutinesQueued == 0 then
		--TMW:Print(L["SAFESETUP_TRIGGERED"])
		TMW:Fire("TMW_SAFESETUP_TRIGGERED")
		TMW:SetScript("OnUpdate", OnUpdateDuringCoroutine)
	end
	NumCoroutinesQueued = NumCoroutinesQueued + 1
end

TMW:RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if TMW.InitializedFully then
		TMW.Update = TMW.UpdateNormally
	end
end)
TMW:RegisterEvent("PLAYER_REGEN_DISABLED", function()
	if TMW.InitializedFully then
		if TMW.ALLOW_LOCKDOWN_CONFIG then
			TMW.Update = TMW.UpdateViaCoroutine
		elseif not TMW.Locked then
			TMW:LockToggle()
		end
	end
end)

do
	-- Auto-loads options if AllowCombatConfig is enabled.
	local hasRan
	TMW:RegisterCallback("TMW_GLOBAL_UPDATE", function()
		if hasRan then
			return
		end
		hasRan = true
		if TMW.db.global.AllowCombatConfig then
			TMW.ALLOW_LOCKDOWN_CONFIG = true
			TMW:LoadOptions()
		end
	end)
end
end

-- TMW:Update() sets up all groups, icons, and anything else.
TMW.Update = TMW.UpdateNormally


local updateHandler
function TMW:ScheduledUpdateHandler()
	if TMW:CheckCanDoLockedAction(false) then
		TMW:Update()
	else
		-- We can't update now. Try again in 5 seconds.
		TMW:ScheduleUpdate(5)
	end
end

function TMW:ScheduleUpdate(delay)
	TMW:CancelTimer(updateHandler, 1)
	updateHandler = TMW:ScheduleTimer("ScheduledUpdateHandler", delay or 1)
end

function TMW:PLAYER_SPECIALIZATION_CHANGED()
	TMW:ScheduleUpdate(.2)
	--TMW:Update()
	
	if not TMW.AddedTalentsToTextures then
		for talent = 1, MAX_NUM_TALENTS do
			local name, tex = GetTalentInfo(talent)
			local lower = name and strlowerCache[name]
			
			if lower then
				SpellTexturesMetaIndex[lower] = tex
			end
		end
		
		TMW.AddedTalentsToTextures = 1
	end
end

function TMW:OnProfile(event, arg2, arg3)

	for icon in TMW:InIcons() do
		icon:SetInfo("texture", "")
	end
	
	TMW:UpgradeProfile()

	TMW:Update()
	
	if event == "OnProfileChanged" then
		TMW:Printf(L["PROFILE_LOADED"], arg3)
	end
	
	TMW:Fire("TMW_ON_PROFILE", event, arg2, arg3)
end





---------------------------------
-- Configuration
---------------------------------

function TMW:CheckCanDoLockedAction(message)
	if InCombatLockdown() and not TMW.ALLOW_LOCKDOWN_CONFIG then
		if message ~= false then
			TMW:Print(message or L["ERROR_ACTION_DENIED_IN_LOCKDOWN"])
		end
		return false
	end
	return true
end

function TMW:LockToggle()
	if not TMW:CheckCanDoLockedAction(L["ERROR_NO_LOCKTOGGLE_IN_LOCKDOWN"]) then
		return
	end
	
	for k, v in pairs(TMW.Warn) do
		-- reset warnings so they can happen again
		if type(k) == "string" then
			TMW.Warn[k] = nil
		end
	end
	TMW.db.profile.Locked = not TMW.db.profile.Locked

	TMW:Fire("TMW_LOCK_TOGGLED", TMW.db.profile.Locked)

	PlaySound("igCharacterInfoTab")
	TMW:Update()
end

function TMW:SlashCommand(str)
	if not TMW.InitializedFully then
		TMW:Print(L["ERROR_NOTINITIALIZED_NO_ACTION"])
		return
	end
	
	local cmd, arg2, arg3 = TMW:GetArgs(str, 3)
	cmd = strlower(cmd or "")

	if cmd == L["CMD_ENABLE"]:lower() or cmd == "enable" then
		cmd = "enable"
	elseif cmd == L["CMD_DISABLE"]:lower() or cmd == "disable" then
		cmd = "disable"
	elseif cmd == L["CMD_TOGGLE"]:lower() or cmd == "toggle" then
		cmd = "toggle"
	elseif cmd == L["CMD_PROFILE"]:lower() or cmd == "profile" then
		cmd = "profile"
	elseif cmd == L["CMD_OPTIONS"]:lower() or cmd == "options" then
		cmd = "options"
	end

	if cmd == "options" then
		if TMW:CheckCanDoLockedAction() then
			TMW:LoadOptions()
			LibStub("AceConfigDialog-3.0"):Open("TMW Options")
		end
	elseif cmd == "profile" then
		if TMW.db.profiles[arg2] then
			TMW.db:SetProfile(arg2)
		else
			TMW:Printf(L["CMD_PROFILE_INVALIDPROFILE"], arg2)
			if not arg2:find(" ") then
				TMW:Print(L["CMD_PROFILE_INVALIDPROFILE_SPACES"])
			end
		end
	elseif cmd == "enable" or cmd == "disable" or cmd == "toggle" then
		local groupID, iconID = tonumber(arg2), tonumber(arg3)

		local group = groupID and groupID <= TMW.db.profile.NumGroups and TMW[groupID]
		local icon = iconID and group and group[iconID]
		local obj = icon or group
		if obj then
			if cmd == "enable" then
				obj:GetSettings().Enabled = true
			elseif cmd == "disable" then
				obj:GetSettings().Enabled = false
			elseif cmd == "toggle" then
				obj:GetSettings().Enabled = not obj:GetSettings().Enabled
			end
			obj:Setup() -- obj is an icon or a group
		end

	else
		TMW:LockToggle()
	end
end
TMW:RegisterChatCommand("tmw", "SlashCommand")
TMW:RegisterChatCommand("tellmewhen", "SlashCommand")

function TMW:LoadOptions(recursed)
	if IsAddOnLoaded("TellMeWhen_Options") then
		return true
	end
	if not TMW.InitializedFully then
		TMW:Print(L["ERROR_NOTINITIALIZED_NO_LOAD"])
		return 
	end
	TMW:Print(L["LOADINGOPT"])
	local loaded, reason = LoadAddOn("TellMeWhen_Options")
	if not loaded then
		if reason == "DISABLED" and not recursed then -- prevent accidental recursion
			TMW:Print(L["ENABLINGOPT"])
			EnableAddOn("TellMeWhen_Options")
			TMW:LoadOptions(1)
		else
			local err = L["LOADERROR"] .. _G["ADDON_"..reason]
			TMW:Print(err)
			TMW:Error(err) -- non breaking error
		end
	else
		-- GLOBALS: INTERFACEOPTIONS_ADDONCATEGORIES, InterfaceAddOnsList_Update
		for k, v in pairs(INTERFACEOPTIONS_ADDONCATEGORIES) do
			if v.name == "TellMeWhen" and not v.obj then
				tremove(INTERFACEOPTIONS_ADDONCATEGORIES, k)
				InterfaceAddOnsList_Update()
				break
			end
		end
		TMW:CompileOptions()
		collectgarbage()
	end
end





---------------------------------
-- Version Warnings
---------------------------------

function TMW:PLAYER_ENTERING_WORLD()
	-- Don't send version broadcast messages in developer mode.
	if not TMW.debug then
		local versionCommString = "M:" .. TELLMEWHEN_VERSION .. "^m:" .. TELLMEWHEN_VERSION_MINOR .. "^R:" .. TELLMEWHEN_VERSIONNUMBER .. "^"
		
		if IsInGuild() then
			TMW:SendCommMessage("TMWV", versionCommString, "GUILD")
		end
		if IsInRaid(LE_PARTY_CATEGORY_HOME) then
			TMW:SendCommMessage("TMWV", versionCommString, "RAID")
		end
		if IsInGroup() then
			TMW:SendCommMessage("TMWV", versionCommString, "PARTY")
		end
		if IsInInstance() then
			TMW:SendCommMessage("TMWV", versionCommString, TMW.CONST.CHAT_TYPE_INSTANCE_CHAT)
		end
	end
end

function TMW:OnCommReceived(prefix, text, channel, who)
	if prefix == "TMWV" and strsub(text, 1, 1) == "M" and not TMW.VersionWarned and TMW.db.global.VersionWarning then
		local major, minor, revision = strmatch(text, "M:(.*)%^m:(.*)%^R:(.*)%^")
		revision = tonumber(revision)
		
		TMW:Debug("%s has v%s%s (%s)", who, major, minor, revision)
		
		if
			not (revision and major and minor)
			or revision <= TELLMEWHEN_VERSIONNUMBER
			or revision == 414069
			or (who == "Cybeloras" and not TMW.debug)
			or minor ~= "" and TELLMEWHEN_VERSION_MINOR == ""
		then
			-- If some of the data is missing (i dont know why it would be),
			-- or if the notified revision is less than the currently installed revision,
			-- or if the notified revision is 414069 (the time I fucked up the version number),
			-- or if the notification is from me (Cybeloras),
			-- or if the notification is from an alpha version and the installed version is not an alpha version,
			-- then don't notify.
			return
		end
		
		TMW.VersionWarned = true
		TMW:Printf(L["NEWVERSION"], major .. minor)
		
	-- Handles data transmission (icons, groups, profiles, etc)
	elseif prefix == "TMW" and TMW.db.profile.ReceiveComm then
		TMW.Received = TMW.Received or {}
		TMW.Received[text] = who or true

		if who then
			TMW.DoPulseReceivedComm = true
			if TMW.db.global.HasImported then
				TMW:Printf(L["MESSAGERECIEVE_SHORT"], who)
			else
				TMW:Printf(L["MESSAGERECIEVE"], who)
			end
		end
	end
end











-- -------------------------------------------------------------------------------------------------
-- |                                                                                               |
-- |                            SPECIALIZED UTILITY AND HELPER FUNCTIONS                           |
-- |                                                                                               |
-- -------------------------------------------------------------------------------------------------









---------------------------------
-- Icon/Group Helper Functions
---------------------------------

TMW.ValidityCheckQueue = {}

function TMW:QueueValidityCheck(icon, groupID, iconID, g, i)
	if not TMW.db.profile.WarnInvalids then return end

	local str = icon .. "^" .. groupID .. "^" .. (iconID or "nil") .. "^" .. g .. "^" .. i

	TMW.ValidityCheckQueue[str] = 1
end

function TMW:DoValidityCheck()
	for str in pairs(TMW.ValidityCheckQueue) do
		local icon, groupID, iconID, g, i = strsplit("^", str)
		icon = _G[icon]
		if not (icon and icon:IsValid()) then
			if iconID ~= "nil" then
				TMW.Warn(format(L["CONDITIONORMETA_CHECKINGINVALID"], groupID, iconID, g, i))
			else
				TMW.Warn(format(L["CONDITIONORMETA_CHECKINGINVALID_GROUP"], groupID, g, i))
			end
		end
	end
	wipe(TMW.ValidityCheckQueue)
end

function TMW:GetGroupName(name, groupID, short)
	name = tonumber(name) or name
	groupID = tonumber(groupID) or groupID
	
	if name and name == groupID and type(groupID) == "number" then
		name = TMW.db.profile.Groups[groupID].Name
	end
	if (not name) or name == "" then
		if short then return groupID end
		return format(L["fGROUP"], groupID)
	end
	if short then return name .. " (" .. groupID .. ")" end
	return name .. " (" .. format(L["fGROUP"], groupID) .. ")"
end





---------------------------------
-- WoW API Helpers
---------------------------------

do	-- TMW.SpellHasNoMana(spell)
	local jab = GetSpellInfo(100780)
	function TMW.SpellHasNoMana(spell)
		local name, _, _, cost, _, powerType = GetSpellInfo(spell)
		
		if name == jab then
			-- Jab is broken and doesnt report having a cost while in tiger stance 
			-- (and maybe other stances) (see ticket #730)
			local _, nomana = IsUsableSpell(spell)
			return nomana
		elseif powerType then
			local power = UnitPower("player", powerType)
			if power < cost then
				return 1
			end
		end
	end
end

-- Override for easy backwards/forwards compatibility
TMW.UnitAura = _G.UnitAura




---------------------------------
-- Generic String Utilities
---------------------------------

local mult = {
	1,						-- seconds per second
	60,						-- seconds per minute
	60*60,					-- seconds per hour
	60*60*24,				-- seconds per day
	60*60*24*365.242199,	-- seconds per year
}
function TMW.toSeconds(str)
	-- converts a string (e.g. "1:45:37") into the number of seconds that it represents (eg. 6337)
	str = ":" .. str:trim(": ") -- a colon is needed at the beginning so that gmatch will catch the first unit of time in the string (minutes, hours, etc)
	local _, numcolon = str:gsub(":", ":") -- count the number of colons in the string so that we can keep track of what multiplier we are on (since we start with the highest unit of time)
	local seconds = 0
	
	for num in str:gmatch(":([0-9%.]*)") do -- iterate over all units of time and their value
		if tonumber(num) and mult[numcolon] then -- make sure that it is valid (there is a number and it isnt a unit of time higher than a year)
			seconds = seconds + mult[numcolon]*num -- multiply the number of units by the number of seconds in that unit and add the appropriate amount of time to the running count
		end
		numcolon = numcolon - 1 -- decrease the current unit of time that is being worked with (even if it was an invalid unit and failed the above check)
	end
	
	return seconds
end

local function replace(text, find, rep)
	-- using this allows for the replacement of ";	   " to "; " in one external call
	assert(not strfind(rep, find), "RECURSION DETECTED: FIND=".. find.. " REP=".. rep)
	while strfind(text, find) do
		text = gsub(text, find, rep)
	end
	return text
end
function TMW:CleanString(text)
	local frame
	if type(text) == "table" and text.GetText then
		frame = text
		text = text:GetText()
	end
	if not text then error("No text to clean!") end
	text = strtrim(text, "; \t\r\n")-- remove all leading and trailing semicolons, spaces, tabs, and newlines
	text = replace(text, "[^:] ;", "; ") -- remove all spaces before semicolons
	text = replace(text, "; ", ";") -- remove all spaces after semicolons
	text = replace(text, ";;", ";") -- remove all double semicolons
	text = replace(text, " :", ":") -- remove all single spaces before colons
	text = replace(text, ":  ", ": ") -- remove all double spaces after colons (DONT REMOVE ALL DOUBLE SPACES EVERYWHERE, SOME SPELLS HAVE TYPO'd NAMES WITH 2 SPACES!)
	text = gsub(text, ";", "; ") -- add spaces after all semicolons. Never used to do this, but it just looks so much better (DONT USE replace!).
	if frame then
		frame:SetText(text)
	end
	return text
end

function TMW:SplitNames(input)
	input = TMW:CleanString(input)
	local tbl = { strsplit(";", input) }
	if #tbl == 1 and tbl[1] == "" then
		tbl[1] = nil
	end

	for a, b in ipairs(tbl) do
		local new = strtrim(b) --remove spaces from the beginning and end of each name
		tbl[a] = tonumber(new) or new -- turn it into a number if it is one
	end
	return tbl
end

function TMW:IsStringInSemicolonList(list, strtofind)
	strtofind = tostring(strtofind)

	for i, str in TMW:Vararg(strsplit(";", list)) do
		if strtofind == str then
			return true
		end
	end
end

function TMW:FormatSeconds(seconds, skipSmall, keepTrailing)
	local y =  seconds / 31556926
	local d = (seconds % 31556926) / 86400
	local h = (seconds % 31556926  % 86400) / 3600
	local m = (seconds % 31556926  % 86400  % 3600) / 60
	local s = (seconds % 31556926  % 86400  % 3600  % 60)

	local ns
	if skipSmall then
		ns = format("%d", s)
	else
		ns = format("%.1f", s)
		if not keepTrailing then
			ns = tonumber(ns)
		end
	end
	if s < 10 and seconds >= 60 then
		ns = "0" .. ns
	end

	if y >= 1 then return format("%d:%d:%02d:%02d:%s", y, d, h, m, ns) end
	if d >= 1 then return format("%d:%02d:%02d:%s", d, h, m, ns) end
	if h >= 1 then return format("%d:%02d:%s", h, m, ns) end
	if m >= 1 then return format("%d:%s", m, ns) end

	return ns
end





---------------------------------
-- Spell & Texture Helpers
---------------------------------

local loweredbackup = {}
function TMW:LowerNames(str)
	-- Converts a string, or all values of a table, to lowercase. Numbers are kept as numbers.
	
	if type(str) == "table" then -- Handle a table with recursion
		for k, v in pairs(str) do
			str[k] = TMW:LowerNames(v)
		end
		return str
	end

	-- Dispel types retain their capitalization. Restore it here.
	for ds in pairs(TMW.DS) do
		if strlower(ds) == strlower(str) then
			return ds
		end
	end

	local ret = tonumber(str) or strlower(str)
	if type(ret) == "string" then
		if loweredbackup[ret] then
			-- Dont replace names that are proper case with names that arent.
			-- Generally, assume that strings with more capitals after non-letters are more proper than ones with less
			local _, oldcount = gsub(loweredbackup[ret], "[^%a]%u", "%1")
			local _, newcount = gsub(str, "[^%a]%u", "%1")

			-- Check the first letter of each string for a capital
			if strfind(loweredbackup[ret], "^%u") then
				oldcount = oldcount + 1
			end
			if strfind(str, "^%u") then
				newcount = newcount + 1
			end

			-- The new string has more than the old, so use it instead
			if newcount > oldcount then
				loweredbackup[ret] = str
			end
		else
			-- There wasn't a string before, so set the base
			loweredbackup[ret] = str
		end
	end

	return ret
end

function TMW:RestoreCase(str)
	if type(str) == "number" then
		return str
	elseif loweredbackup[str] then
		return loweredbackup[str], str
	else
		for original, lowered in pairs(strlowerCache) do
			if lowered == str then
				return original, str
			end
		end
		return str
	end
end

function TMW:EquivToTable(name)
	-- This function checks to see if a string is a valid equivalency.
	-- If it is, all the spells that it represents will be put into an array and returned.
	-- If it isn't, nil will be returned.

	-- Everything in this function is handled as lowercase to prevent issues with user input capitalization.
	-- DONT use TMW:LowerNames() here, because the input is not the output
	name = strlower(name) 

	-- See if the string being checked has a duration attached to it
	-- (It really shouldn't because there is currently no point in doing so,
	-- But a user did try this and made a bug report, so I fixed it anyway
	local eqname, duration = strmatch(name, "(.-):([%d:%s%.]*)$") 

	-- If there was a duration, then replace the old name with the actual name without the duration attached
	name = eqname or name 

	local names

	-- Iterate over all of TMW.BE's sub-categories ('buffs', 'debuffs', 'casts', etc)
	for k, v in pairs(TMW.BE) do
		-- Iterate over each equivalency in the category
		for equiv, str in pairs(v) do
			if strlower(equiv) == name then
				-- We found a matching equivalency, so stop searching.
				names = str
				break
			end
		end
		if names then break end
	end

	-- If we didnt find an equivalency string then get out
	if not names then return end

	-- Split the string into a table of spells.
	local tbl = { strsplit(";", names) }

	-- For each spell in the equivalency:
	for a, b in pairs(tbl) do
		-- Take off trailing spaces
		local new = strtrim(b) 

		-- Make sure it is a number if it can be
		new = tonumber(new) or new 

		-- Tack on the duration that should be applied to all spells if there was a duration
		if duration then 
			new = new .. ":" .. duration
		end

		-- Done. Stick the new value in the return table.
		tbl[a] = new
	end

	return tbl
end
TMW:MakeFunctionCached(TMW, "EquivToTable")

function TMW:GetSpellNames(icon, setting, firstOnly, toname, hash, keepDurations, allowRenaming)
	local buffNames = TMW:SplitNames(setting) -- Get a table of everything

	--INSERT EQUIVALENCIES
	 --start at the end of the table, that way we dont have to worry
	 --about increasing the key of buffNames to work with every time we insert something
	local k = #buffNames
	while k > 0 do
		local eqtt = TMW:EquivToTable(buffNames[k]) -- Get the table form of the equivalency string
		if eqtt then
			local n = k	--point to start inserting the values at
			tremove(buffNames, k)	--take the actual equavalancey itself out, because it isnt an actual spell name or anything
			for z, x in ipairs(eqtt) do
				tinsert(buffNames, n, x)	--put the names into the main table
				n = n + 1	--increment the point of insertion
			end
		else
			k = k - 1	--there is no equivalency to insert, so move backwards one key towards zero to the next key
		end
	end

	-- REMOVE DUPLICATES
	TMW.tRemoveDuplicates(buffNames)

	-- REMOVE SPELL DURATIONS (FOR UNIT COOLDOWNS/ICDs)
	if not keepDurations then
		for k, buffName in pairs(buffNames) do
			if strfind(buffName, ":[%d:%s%.]*$") then
				local new = strmatch(buffName, "(.-):[%d:%s%.]*$")
				buffNames[k] = tonumber(new) or new -- Turn it into a number if it is one
			end
		end
	end
	if icon then
		buffNames = TMW:LowerNames(buffNames)
	end

	-- Remove invalid SpellIDs.
	local k = #buffNames
	while k > 0 do
		local v = buffNames[k]
		if type(v) == "number" and v >= 2^31 then
			-- Invalid spellID. Remove it to prevent integer overflow errors.
			tremove(buffNames, k)
			TMW.Warn(L["ERROR_INVALID_SPELLID"]:format(tostring(icon or "<UNKNOWN ICON>"), v))
		else
			-- The entry was valid, so move backwards towards the beginning.
			k = k - 1
		end
	end
	
	if hash then
		local hash = {}
		for k, v in ipairs(buffNames) do
			if toname and (allowRenaming or tonumber(v)) then
				v = GetSpellInfo(v or "") or v -- Turn the value into a name if needed
			end

			v = TMW:LowerNames(v)
			hash[v] = k -- Put the final value in the table as well (may or may not be the same as the original value. Value should be NameArrray's key, for use with the duration table.
		end
		return hash
	end
	if toname then
		if firstOnly then
			-- Turn the first value into a name and return it
			local ret = buffNames[1] or ""
			if (allowRenaming or tonumber(ret)) then
				ret = GetSpellInfo(ret) or ret 
			end
			if icon then ret = TMW:LowerNames(ret) end
			return ret
		else
			-- Convert everything to a name
			for k, v in ipairs(buffNames) do
				if (allowRenaming or tonumber(v)) then
					buffNames[k] = GetSpellInfo(v or "") or v 
				end
			end
			if icon then TMW:LowerNames(buffNames) end
			return buffNames
		end
	end
	if firstOnly then
		local ret = buffNames[1] or ""
		return ret
	end
	return buffNames
end
do    -- TMW:GetSpellNames() cache management
	-- We need to wipe the cache on every TMW_GLOBAL_UPDATE because of issues with
	-- spells that replace other spells in different specs, like Corruption/Immolate.
	-- TMW_GLOBAL_UPDATE might fire a little too often for this, but it is a surefire way to prevent issues that should
	-- hold up through out all future game updates because TMW_GLOBAL_UPDATE should always react to any changes in spec/talents/etc
	
	local _, cache = TMW:MakeFunctionCached(TMW, "GetSpellNames")
	TMW:RegisterCallback("TMW_GLOBAL_UPDATE", function()
		wipe(cache)
	end)
end

function TMW:GetSpellDurations(icon, setting)
	local NameArray = TMW:GetSpellNames(icon, setting, nil, nil, nil, 1)
	local DurationArray = CopyTable(NameArray)

	-- EXTRACT SPELL DURATIONS
	for k, buffName in pairs(NameArray) do
		DurationArray[k] = strmatch(buffName, ".-:([%d:%s%.]*)$")
		if not DurationArray[k] then
			DurationArray[k] = 0
		else
			DurationArray[k] = tonumber( TMW.toSeconds(DurationArray[k]:trim(" :;.")) )
		end
	end

	return DurationArray
end
TMW:MakeFunctionCached(TMW, "GetSpellDurations")


--TMW.TestTex = TMW:CreateTexture()
function TMW:GetTexturePathFromSetting(setting)
	setting = tonumber(setting) or setting
		
	if setting and setting ~= "" then
		-- See http://us.battle.net/wow/en/forum/topic/5977979895#1 for the resoning behind this stupid shit right here.
		if SpellTextures[setting] then
			return SpellTextures[setting]
		end
		if strfind(setting, "[\\/]") then -- if there is a slash in it, then it is probably a full path
			return setting:gsub("/", "\\")
		else
			-- if there isn't a slash in it, then it is probably be a wow icon in interface\icons.
			-- it still might be a file in wow's root directory, but fuck, there is no way to tell for sure
			return "Interface\\Icons\\" .. setting
		end
		
		--[[
		-- Pre-MOP code for testing valid textures.
		-- Kept here in a comment for ease of restoring it should it ever start working again.
		
		TMW.TestTex:SetTexture(SpellTextures[setting])
		if not TMW.TestTex:GetTexture() then
			TMW.TestTex:SetTexture(setting)
		end
		if not TMW.TestTex:GetTexture() then
			TMW.TestTex:SetTexture("Interface\\Icons\\" .. setting)
		end
		return TMW.TestTex:GetTexture()
		]]
			
	end
end





---------------------------------
-- DogTag Helpers & Global Tags
---------------------------------

local DogTagEventHandler = function(event, icon)
	DogTag:FireEvent(event, icon.group.ID, icon.ID)
end

function TMW:CreateDogTagEventString(...)
	local eventString = ""
	for i, dataProcessorName in TMW:Vararg(...) do
		local Processor = TMW.Classes.IconDataProcessor.ProcessorsByName[dataProcessorName]
		TMW:RegisterCallback(Processor.changedEvent, DogTagEventHandler)
		if i > 1 then
			eventString = eventString .. ";"
		end
		eventString = eventString .. Processor.changedEvent .. "#$group#$icon"
	end
	return eventString
end
if not DogTag then
	TMW.CreateDogTagEventString = TMW.NULLFUNC
end

if DogTag then
	DogTag:AddTag("TMW", "TMWFormatDuration", {
		code = TMW:MakeSingleArgFunctionCached(function(seconds)
			return TMW:FormatSeconds(seconds, seconds == 0 or seconds > 10, true)
		end),
		arg = {
			'seconds', 'number', '@req',
		},
		ret = "string",
		static = true,
		doc = L["DT_DOC_TMWFormatDuration"],
		example = '[0.54:TMWFormatDuration] => "0.5"; [20:TMWFormatDuration] => "20"; [80:TMWFormatDuration] => "1:20"; [10000:TMWFormatDuration] => "2:46:40"',
		category = L["TEXTMANIP"]
	})

	DogTag:AddTag("TMW", "gsub", {
		code = gsub,
		arg = {
			'value', 'string', '@req',
			'pattern', 'string', '@req',
			'replacement', 'string', '@req',
			'num', 'number;nil', 'nil',
		},
		ret = "string;nil",
		static = true,
		doc = L["DT_DOC_gsub"],
		example = '["Cybeloras - Aerie Peak":gsub(" ?%-.*", "")] => "Cybeloras"',
		category = L["TEXTMANIP"],
	})

	DogTag:AddTag("TMW", "strfind", {
		code = strfind,
		arg = {
			'value', 'string', '@req',
			'pattern', 'string', '@req',
			'init', 'number', 0,
			'plain', 'boolean', false,
		},
		ret = "number;nil",
		static = true,
		doc = L["DT_DOC_strfind"],
		example = '["Cybeloras - Aerie Peak":strfind("%-")] => "11"',
		category = L["TEXTMANIP"],
	})
end

