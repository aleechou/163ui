-- -------------------------------------------------------------------------- --
-- BattlegroundTargets by kunda                                               --
-- -------------------------------------------------------------------------- --
--                                                                            --
-- BattlegroundTargets is a World of Warcraft AddOn.                          --
-- BattlegroundTargets is a 'Enemy Unit Frame' for battlegrounds.             --
-- BattlegroundTargets is not a 'real' (Enemy) Unit Frame.                    --
-- BattlegroundTargets simply generates buttons with target macros.           --
--                                                                            --
-- Features:                                                                  --
-- # Shows all battleground enemies with role, class and name.                --
--   - Left-click : set target                                                --
--   - Right-click: set focus                                                 --
-- # Independent settings for '10v10', '15v15' and '40v40'.                   --
-- # Specialization                                                           --
-- # Target                                                                   --
-- # Main Assist Target                                                       --
-- # Focus                                                                    --
-- # Enemy (Flag/Orb/Cart) Carrier                                            --
-- # Target Count                                                             --
-- # Health                                                                   --
-- # Range Check                                                              --
--                                                                            --
-- -------------------------------------------------------------------------- --
--                                                                            --
-- These events are always registered:                                        --
-- - PLAYER_REGEN_DISABLED                                                    --
-- - PLAYER_REGEN_ENABLED                                                     --
-- - ZONE_CHANGED_NEW_AREA (to determine if current zone is a battleground)   --
-- - PLAYER_LEVEL_UP (only registered if playerLevel < maxLevel)              --
--                                                                            --
-- In Battleground:                                                           --
-- # If enabled: ------------------------------------------------------------ --
--   - UPDATE_BATTLEFIELD_SCORE                                               --
--   - PLAYER_DEAD                                                            --
--   - PLAYER_UNGHOST                                                         --
--   - PLAYER_ALIVE                                                           --
--                                                                            --
-- # Range Check: --------------------------------------- VERY HIGH CPU USAGE --
--   - Events:                                                                --
--        1) Combat Log: --- COMBAT_LOG_EVENT_UNFILTERED                      --
--        2) Class: -------- PLAYER_TARGET_CHANGED                            --
--                         - UNIT_HEALTH_FREQUENT                             --
--                         - UPDATE_MOUSEOVER_UNIT                            --
--                         - UNIT_TARGET                                      --
--      3/4) Mix: ---------- COMBAT_LOG_EVENT_UNFILTERED                      --
--                         - PLAYER_TARGET_CHANGED                            --
--                         - UNIT_HEALTH_FREQUENT                             --
--                         - UPDATE_MOUSEOVER_UNIT                            --
--                         - UNIT_TARGET                                      --
--   - The data to determine the distance to an enemy is not always available.--
--     This is restricted by the WoW API.                                     --
--   - This feature is a compromise between CPU usage (FPS), lag/network      --
--     bandwidth (no SendAdd0nMessage), fast and easy visual recognition and  --
--     suitable data.                                                         --
--                                                                            --
-- # Health: ------------------------------------------------- HIGH CPU USAGE --
--   - Events:             - UNIT_TARGET                                      --
--                         - UNIT_HEALTH_FREQUENT                             --
--                         - UPDATE_MOUSEOVER_UNIT                            --
--   - The health from an enemy is not always available.                      --
--     This is restricted by the WoW API.                                     --
--   - A raidmember/raidpet MUST target(focus/mouseover) an enemy OR          --
--     you/yourpet MUST target/focus/mouseover an enemy to get the health.    --
--                                                                            --
-- # Target Count: ------------------------------------ HIGH MEDIUM CPU USAGE --
--   - Event:              - UNIT_TARGET                                      --
--                                                                            --
-- # Main Assist Target: ------------------------------- LOW MEDIUM CPU USAGE --
--   - Events:             - GROUP_ROSTER_UPDATE                              --
--                         - UNIT_TARGET                                      --
--                                                                            --
-- # Leader: ------------------------------------------- LOW MEDIUM CPU USAGE --
--   - Event:              - UNIT_TARGET                                      --
--                                                                            --
-- # Level: (only registered if playerLevel < maxLevel) ------- LOW CPU USAGE --
--   - Event:              - UNIT_TARGET                                      --
--                                                                            --
-- # Target: -------------------------------------------------- LOW CPU USAGE --
--   - Event:              - PLAYER_TARGET_CHANGED                            --
--                                                                            --
-- # Focus: --------------------------------------------------- LOW CPU USAGE --
--   - Event:              - PLAYER_FOCUS_CHANGED                             --
--                                                                            --
-- # Enemy Carrier: -------------------------------------- VERY LOW CPU USAGE --
--   - Events:             - CHAT_MSG_BG_SYSTEM_HORDE                         --
--                         - CHAT_MSG_BG_SYSTEM_ALLIANCE                      --
--                         - CHAT_MSG_BG_SYSTEM_NEUTRAL                       --
--                         - CHAT_MSG_RAID_BOSS_EMOTE                         --
--   Carrier detection in case of ReloadUI or mid-battle-joins: (temporarily  --
--   registered until each enemy is scanned)                                  --
--                         - UNIT_TARGET                                      --
--                         - UPDATE_MOUSEOVER_UNIT                            --
--                         - PLAYER_TARGET_CHANGED                            --
--                                                                            --
-- # No SendAdd0nMessage(): ------------------------------------------------- --
--   This AddOn does not use/need SendAdd0nMessage(). SendAdd0nMessage()      --
--   increases the available data by transmitting information to other        --
--   players. This has certain pros and cons. I may include (opt-in) such     --
--   functionality in some future release. maybe. dontknow.                   --
--                                                                            --
-- -------------------------------------------------------------------------- --
--                                                                            --
-- slash commands: /bgt - /bgtargets - /battlegroundtargets                   --
--                                                                            --
-- -------------------------------------------------------------------------- --
--                                                                            --
-- Thanks to all who helped with the localization.                            --
--                                                                            --
-- -------------------------------------------------------------------------- --

local _G = _G
local pairs = pairs
local type = type
local unpack = unpack
local band = bit.band
local math_min = math.min
local math_max = math.max
local floor = math.floor
local random = math.random
local strfind = string.find
local strmatch = string.match
local tostring = tostring
local format = string.format
local tinsert = table.insert
local table_sort = table.sort
local wipe = table.wipe
local CheckInteractDistance = CheckInteractDistance
local CreateFrame = CreateFrame
local GetBattlefieldArenaFaction = GetBattlefieldArenaFaction
local GetBattlefieldScore = GetBattlefieldScore
local GetBattlefieldStatus = GetBattlefieldStatus
local GetBattlegroundInfo = GetBattlegroundInfo
local GetClassInfoByID = GetClassInfoByID
local GetNumBattlefieldScores = GetNumBattlefieldScores
local GetNumBattlegroundTypes = GetNumBattlegroundTypes
local GetNumGroupMembers = GetNumGroupMembers
local GetNumSpecializationsForClassID = GetNumSpecializationsForClassID
local GetMaxBattlefieldID = GetMaxBattlefieldID
local GetRaidRosterInfo = GetRaidRosterInfo
local GetRealZoneText = GetRealZoneText
local GetSpecializationInfoForClassID = GetSpecializationInfoForClassID
local GetSpecializationRoleByID = GetSpecializationRoleByID
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local InCombatLockdown = InCombatLockdown
local IsActiveBattlefieldArena = IsActiveBattlefieldArena
local IsInInstance = IsInInstance
local IsRatedBattleground = IsRatedBattleground
local IsSpellInRange = IsSpellInRange
local IsSpellKnown = IsSpellKnown
local RequestBattlefieldScoreData = RequestBattlefieldScoreData
local SetBattlefieldScoreFaction = SetBattlefieldScoreFaction
local UnitBuff = UnitBuff
local UnitClass = UnitClass
local UnitDebuff = UnitDebuff
local UnitFactionGroup = UnitFactionGroup
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsGroupLeader = UnitIsGroupLeader
local UnitLevel = UnitLevel
local UnitName = UnitName

-- -------------------------------------------------------------------------- --

BattlegroundTargets_Options = {
	["ButtonRangeDisplay"] = {
		[40] = 7,
		[10] = 1,
		[15] = 1,
	},
	["ButtonSortBy"] = {
		[40] = 1,
		[10] = 1,
		[15] = 1,
	},
	["ButtonFocusPosition"] = {
		[40] = 55,
		[10] = 70,
		[15] = 70,
	},
	["ButtonShowHealthBar"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["ButtonShowRealm"] = {
		[40] = false,
		[10] = true,
		[15] = true,
	},
	["LayoutTH"] = {
		[40] = 24,
		[10] = 18,
		[15] = 18,
	},
	["ButtonFlagPosition"] = {
		[40] = 100,
		[10] = 60,
		[15] = 60,
	},
	["ButtonAssistPosition"] = {
		[40] = 70,
		[10] = 100,
		[15] = 100,
	},
	["ButtonTargetPosition"] = {
		[40] = 85,
		[10] = 100,
		[15] = 100,
	},
	["LayoutSpace"] = {
		[40] = 0,
		[10] = 0,
		[15] = 0,
	},
	["ButtonFocusScale"] = {
		[40] = 1,
		[10] = 1,
		[15] = 1,
	},
	["version"] = 21,
	["ButtonShowAssist"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["pos"] = {
		["BattlegroundTargets_MainFrame"] = {
			["y"] = 248.2100434730843,
			["x"] = 41.00002113165699,
			["point"] = "LEFT",
			["s"] = 1,
		},
	},
	["ButtonRangeCheck"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["ButtonAssistScale"] = {
		[40] = 1,
		[10] = 1.2,
		[15] = 1.2,
	},
	["EnableBracket"] = {
		[40] = true,
		[10] = true,
		[15] = true,
	},
	["LayoutButtonSpace"] = {
		[40] = 0,
		[10] = 0,
		[15] = 0,
	},
	["ButtonShowRole"] = {
		[40] = true,
		[10] = true,
		[15] = true,
	},
	["IndependentPositioning"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["ButtonScale"] = {
		[40] = 1,
		[10] = 1,
		[15] = 1,
	},
	["ButtonHeight"] = {
		[40] = 16,
		[10] = 20,
		[15] = 20,
	},
	["ButtonWidth"] = {
		[40] = 100,
		[10] = 175,
		[15] = 175,
	},
	["ButtonShowHealthText"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["ButtonFontNumberSize"] = {
		[40] = 10,
		[10] = 10,
		[15] = 10,
	},
	["ButtonFontNameSize"] = {
		[40] = 10,
		[10] = 12,
		[15] = 12,
	},
	["ButtonFontNameStyle"] = {
		[40] = 10,
		[10] = 10,
		[15] = 10,
	},
	["ButtonSortDetail"] = {
		[40] = 3,
		[10] = 3,
		[15] = 3,
	},
	["ButtonTypeRangeCheck"] = {
		[40] = 2,
		[10] = 2,
		[15] = 2,
	},
	["ButtonShowTarget"] = {
		[40] = true,
		[10] = true,
		[15] = true,
	},
	["ButtonFontNumberStyle"] = {
		[40] = 1,
		[10] = 1,
		[15] = 1,
	},
	["ButtonShowTargetCount"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["ButtonClassIcon"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["SummaryScaleRole"] = {
		[40] = 0.5,
		[10] = 0.6,
		[15] = 0.6,
	},
	["ButtonTargetScale"] = {
		[40] = 1,
		[10] = 1.5,
		[15] = 1.5,
	},
	["ButtonShowSpec"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["ButtonShowFlag"] = {
		[40] = false,
		[10] = true,
		[15] = true,
	},
	["ButtonShowFocus"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["Summary"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["ButtonFlagScale"] = {
		[40] = 1,
		[10] = 1.2,
		[15] = 1.2,
	},
	["MinimapButtonPos"] = -90,
	["ButtonShowLeader"] = {
		[40] = false,
		[10] = false,
		[15] = false,
	},
	["MinimapButton"] = false,
	["FirstRun"] = true,
} -- SavedVariable options table
local BattlegroundTargets = CreateFrame("Frame") -- container

local _, prg = ...
local L if not prg.L then return end for k, v in pairs(prg.L) do if type(v) ~= "string" then prg.L[k] = tostring(k) end end
      L   = prg.L   -- localization L[
local FLG = prg.FLG -- carrier strings
local RNA = prg.RNA -- bg race names
local BGN = prg.BGN -- localized battleground names

local GVAR = {}     -- UI Widgets
local TEMPLATE = {} -- Templates
local OPT = {}      -- local SavedVariable table (BattlegroundTargets_Options.Button*)

local AddonIcon = "Interface\\AddOns\\BattlegroundTargets\\BattlegroundTargets-texture-button"

local locale = GetLocale()

local inWorld
local inBattleground
local inCombat
local isConfig

local reCheckBG
local reCheckScore
local reSizeCheck = 0
local reSetLayout
local rePosMain

local isTarget = 0
local hasFlag
local isDeadUpdateStop
local isLeader
local isAssistName
local isAssistUnitId
local rangeSpellName, rangeMin, rangeMax -- for class-spell based range check
local flagDebuff = 0
local flags = 0
local isFlagBG = 0
local flagCHK
local flagflag

-- THROTTLE (reduce CPU usage) | FORCE UPDATE (precise results) | WARNING | MISC
local range_SPELL_Frequency     = 0.2       -- T rangecheck: [class-spell]: in second per enemy (variable: ENEMY_Name2Range[enemyname]) 
local range_CL_Throttle         = 0         -- T rangecheck: [combatlog] C.ombatLogRangeCheck()
local range_CL_Frequency        = 3         -- T rangecheck: [combatlog] 50/50 or 66/33 or 75/25 (%Yes/%No) => 64/36 = 36% combatlog messages filtered (36% vs overhead: two variables, one addition, one number comparison and if filtered one math.random)
local range_CL_DisplayThrottle  = GetTime() -- T rangecheck: [combatlog] display update
local range_CL_DisplayFrequency = 0.25      -- T rangecheck: [combatlog] display update
local range_DisappearTime       = 8         -- M rangecheck: display update - clears range display if an enemy was not seen for 8 seconds
local leaderThrottle  = 0                   -- T leader: C.heckUnitTarget()
local leaderFrequency = 5                   -- T leader: if isLeader is true then pause 5 times(events) until next check
local assistUpdate    = GetTime()           -- F assist: C.heckUnitTarget()
local assistFrequency = 0.5                 -- F assist: immediate assist target check (brute force)
local targetCountUpdate    = GetTime()      -- F targetcount: C.heckUnitTarget()
local targetCountFrequency = 30             -- F targetcount: a complete raid/raidtarget check every 30 seconds (brute force)
local scoreLastUpdate = GetTime()           -- W scoreupdate: B.attlefieldScoreUpdate()
local scoreWarning    = 60                  -- W scoreupdate: inCombat-warning icon
local scoreFrequency  = 1                   -- T scoreupdate
local scoreCount      = 0                   -- T scoreupdate

local playerLevel = UnitLevel("player") -- LVLCHK
local isLowLevel
local maxLevel = 90

local playerName = UnitName("player")
local _, playerClassEN = UnitClass("player")

local playerTargetName, playerTargetRealm
local playerFocusName, playerFocusRealm
local playerAssistTargetName, playerAssistTargetRealm

local playerFactionDEF   = 0 -- player faction (DEFAULT)
local oppositeFactionDEF = 0 -- opposite faction (DEFAULT)
local playerFactionBG    = 0 -- player faction (in battleground)
local oppositeFactionBG  = 0 -- opposite faction (in battleground)
local oppositeFactionREAL    -- real opposite faction

--local eventTest = {} -- TEST event order

local ENEMY_Data = {}           -- key = numerical | all ENEMY data
local ENEMY_Names = {}          -- key = enemyName | value = count
local ENEMY_Name4Flag = {}      -- key = enemyName without realm | value = button number
local ENEMY_Name2Button = {}    -- key = enemyName               | value = button number
local ENEMY_Name2Percent = {}   -- key = enemyName | value = health in percent
local ENEMY_Name2Range = {}     -- key = enemyName | value = time of last contact
local ENEMY_Name2Level = {}     -- key = enemyName | value = level
local ENEMY_FirstFlagCheck = {} -- key = enemyName | value = 1
local FRIEND_Data = {}          -- key = numerical | all FRIEND data TEST TODO
local FRIEND_Names = {}         -- key = friendName | value = 1
local TARGET_Names = {}         -- key = friendName | value = enemyName
local SPELL_Range = {}          -- key = spellId | value = maxRange

local ENEMY_Roles = {0,0,0,0}
local FRIEND_Roles = {0,0,0,0}

local healthBarWidth = 0.01
local currentSize = 10
local testSize = 10
local testData = {
	Loaded         = nil, -- testData.Loaded
	IconTarget     = 2,   -- testData.IconTarget
	IconFocus      = 5,   -- testData.IconFocus
	CarrierDisplay = "flag", -- testData.CarrierDisplay
	IconFlag       = {button = 3, txt = nil}, -- testData.IconFlag
	IconOrb        = {[121164] = {button = 2,   orbval = nil},  -- testData.IconOrb -- Blue
	                  [121175] = {button = 4,   orbval = nil},  -- testData.IconOrb -- Puprle
	                  [121176] = {button = 7,   orbval = nil},  -- testData.IconOrb -- Green
	                  [121177] = {button = nil, orbval = nil}}, -- testData.IconOrb -- Orange
	IconAssi       = 4,   -- testData.IconAssi
	Health         = {},  -- testData.Health
	Range          = {},  -- testData.Range
	Leader         = 4,   -- testData.Leader
}

local bgMaps = {}
local bgInfo = {[10]={},[15]={},[40]={}}
local function BuildBattlegroundMapTable()
	for i = 1, GetNumBattlegroundTypes() do
		local localizedName, _, _, _, bgID, _, _, _, gameType, icon = GetBattlegroundInfo(i) --print(i, GetBattlegroundInfo(i))
		    if bgID ==   1 then bgInfo[40][1] = localizedName bgMaps[localizedName] = {bgSize = 40, flagBG = 0, gameType = gameType, icon = icon} -- Alterac Valley
		elseif bgID ==   2 then bgInfo[10][1] = localizedName bgMaps[localizedName] = {bgSize = 10, flagBG = 1, gameType = gameType, icon = icon} -- Warsong Gulch
		elseif bgID ==   3 then bgInfo[15][1] = localizedName bgMaps[localizedName] = {bgSize = 15, flagBG = 0, gameType = gameType, icon = icon} -- Arathi Basin
		elseif bgID ==   7 then bgInfo[15][2] = localizedName bgMaps[localizedName] = {bgSize = 15, flagBG = 2, gameType = gameType, icon = icon} -- Eye of the Storm
		elseif bgID ==   9 then bgInfo[15][3] = localizedName bgMaps[localizedName] = {bgSize = 15, flagBG = 0, gameType = gameType, icon = icon} -- Strand of the Ancients
		elseif bgID ==  30 then bgInfo[40][2] = localizedName bgMaps[localizedName] = {bgSize = 40, flagBG = 0, gameType = gameType, icon = icon} -- Isle of Conquest
		elseif bgID == 108 then bgInfo[10][2] = localizedName bgMaps[localizedName] = {bgSize = 10, flagBG = 3, gameType = gameType, icon = icon} -- Twin Peaks
		elseif bgID == 120 then bgInfo[10][3] = localizedName bgMaps[localizedName] = {bgSize = 10, flagBG = 0, gameType = gameType, icon = icon} -- The Battle for Gilneas
		elseif bgID == 699 then bgInfo[10][4] = localizedName bgMaps[localizedName] = {bgSize = 10, flagBG = 5, gameType = gameType, icon = icon} -- Temple of Kotmogu
		elseif bgID == 708 then bgInfo[10][5] = localizedName bgMaps[localizedName] = {bgSize = 10, flagBG = 0, gameType = gameType, icon = icon} -- Silvershard Mines
		elseif bgID == 754 then bgInfo[15][4] = localizedName bgMaps[localizedName] = {bgSize = 15, flagBG = 4, gameType = gameType, icon = icon} -- Deepwind Gorge
		end
	end
end

local flagIDs = {
	 [23333] = 1, -- Horde Flag         Warsong Gulch & Twin Peaks
	 [23335] = 1, -- Alliance Flag      Warsong Gulch & Twin Peaks
	 [34976] = 1, -- Netherstorm Flag   Eye of the Storm
	[100196] = 1, -- Netherstorm Flag?  Eye of the Storm
	[140876] = 1, -- Alliance Mine Cart Deepwind Gorge
	[141210] = 1, -- Horde Mine Cart    Deepwind Gorge
}

local debuffIDs = {
	[46392] = 1, -- Focused Assault
	[46393] = 1, -- Brutal Assault
}

local hasOrb = {Green={name=nil,orbval=nil},Blue={name=nil,orbval=nil},Purple={name=nil,orbval=nil},Orange={name=nil,orbval=nil}}

local orbIDs = {
	[121164] = {color = "Blue",   texture = "Interface\\MiniMap\\TempleofKotmogu_ball_cyan"},   -- |cFF01DFD__7__Blue|r   |cFF01DFD7Blue|r
	[121175] = {color = "Purple", texture = "Interface\\MiniMap\\TempleofKotmogu_ball_purple"}, -- |cFFBF00F__F__Purple|r |cFFBF00FFPurple|r
	[121176] = {color = "Green",  texture = "Interface\\MiniMap\\TempleofKotmogu_ball_green"},  -- |cFF01DF0__1__Green|r  |cFF01DF01Green|r
	[121177] = {color = "Orange", texture = "Interface\\MiniMap\\TempleofKotmogu_ball_orange"}, -- |cFFFF800__0__Orange|r |cFFFF8000Orange|r
}

local orbColIDs = {
	["Blue"]   = 121164,-- code = {0.0039, 0.8745, 0.8431}
	["Purple"] = 121175,-- code = {0.7490, 0     , 1     }
	["Green"]  = 121176,-- code = {0.0039, 0.8745, 0.0039}
	["Orange"] = 121177,-- code = {1     , 0.5019, 0     }
}

local function orbData(str)
	local colorCode = strmatch(str, "^|cFF%x%x%x%x%x(%x).*|r$") -- print("colorCode:", colorCode)
	    if colorCode == "7" then return "Blue",   "Interface\\MiniMap\\TempleofKotmogu_ball_cyan"   -- |cFF01DFD__7__Blue|r   |cFF01DFD7Blue|r
	elseif colorCode == "F" then return "Purple", "Interface\\MiniMap\\TempleofKotmogu_ball_purple" -- |cFFBF00F__F__Purple|r |cFFBF00FFPurple|r
	elseif colorCode == "1" then return "Green",  "Interface\\MiniMap\\TempleofKotmogu_ball_green"  -- |cFF01DF0__1__Green|r  |cFF01DF01Green|r
	elseif colorCode == "0" then return "Orange", "Interface\\MiniMap\\TempleofKotmogu_ball_orange" -- |cFFFF800__0__Orange|r |cFFFF8000Orange|r
	end
	return "Unknown", nil
end

local sortBy = {
	L["Role"].." / "..L["Class"].."* / "..L["Name"], -- 1
	L["Role"].." / "..L["Name"], -- 2
	L["Class"].."* / "..L["Role"].." / "..L["Name"], -- 3
	L["Class"].."* / "..L["Name"], -- 4
	L["Name"], -- 5
}

local sortDetail = {
	"*"..L["Class"].." ("..locale..")", -- 1
	"*"..L["Class"].." (english)", -- 2
	"*"..L["Class"].." (Blizzard)", -- 3
}

local fontStyles = {
	{font = "Fonts\\2002.ttf",         name = "2002 - |cffa070ddLatin-1|r  |cff68ccefkoKR|r  |cffff7c0aruRU|r"}, -- 1
	{font = "Fonts\\2002B.ttf",        name = "2002 Bold - |cffa070ddLatin-1|r  |cff68ccefkoKR|r  |cffff7c0aruRU|r"}, -- 2
	{font = "Fonts\\ARIALN.TTF",       name = "Arial Narrow - |cffa070ddLatin|r  |cffff7c0aruRU|r"}, -- 3
	{font = "Fonts\\ARHei.ttf",        name = "AR CrystalzcuheiGBK Demibold - |cffff7c0aruRU|r  |cffc69b6dzhCN|r  |cffc41e3azhTW|r"}, -- 4
	{font = "Fonts\\bHEI00M.ttf",      name = "AR Heiti2 Medium B5 - |cffff7c0aruRU|r  |cffc41e3azhTW|r"}, -- 5
	{font = "Fonts\\bHEI01B.ttf",      name = "AR Heiti2 Bold B5 - |cffff7c0aruRU|r  |cffc41e3azhTW|r"}, -- 6
	{font = "Fonts\\bKAI00M.ttf",      name = "AR Kaiti Medium B5 - |cffff7c0aruRU|r  |cffc41e3azhTW|r"}, -- 7
	{font = "Fonts\\bLEI00D.ttf",      name = "AR Leisu Demi B5 - |cffff7c0aruRU|r  |cffc41e3azhTW|r"}, -- 8
	{font = "Fonts\\ARKai_C.ttf",      name = "AR ZhongkaiGBK Medium C - |cffff7c0aruRU|r  |cffc69b6dzhCN|r  |cffc41e3azhTW|r"}, -- 9
	{font = "Fonts\\ARKai_T.ttf",      name = "AR ZhongkaiGBK Medium T - |cffff7c0aruRU|r  |cffc69b6dzhCN|r  |cffc41e3azhTW|r"}, -- 10
	{font = "Fonts\\FRIZQT__.TTF",     name = "Friz Quadrata TT - |cffa070ddLatin-1|r"}, -- 11
	{font = "Fonts\\FRIZQT___CYR.TTF", name = "Friz Quadrata TT Cyr - |cffff7c0aruRU|r"}, -- 12
	{font = "Fonts\\MORPHEUS.TTF",     name = "Morpheus - |cffa070ddLatin-1|r"}, -- 13
	{font = "Fonts\\MORPHEUS_CYR.TTF", name = "Morpheus Cyr - |cffa070ddLatin-1|r  |cffff7c0aruRU|r"}, -- 14
	{font = "Fonts\\NIM_____.ttf",     name = "Nimrod MT - |cffa070ddLatin|r  |cffff7c0aruRU|r"}, -- 15
	{font = "Fonts\\SKURRI.TTF",       name = "Skurri - |cffa070ddLatin-1|r"}, -- 16
	{font = "Fonts\\SKURRI_CYR.TTF",   name = "Skurri Cyr - |cffa070ddLatin-1|r  |cffff7c0aruRU|r"}, -- 17
	{font = "Fonts\\K_Pagetext.TTF",   name = "YDIMokM - |cffa070ddLatin-1|r  |cff68ccefkoKR|r  |cffff7c0aruRU|r"}, -- 18
	{font = "Fonts\\K_Damage.TTF",     name = "YDIWingsM - |cff68ccefkoKR|r  |cffff7c0aruRU|r"}, -- 19
}

  local defaultFont = 1
--    if locale == "deDE" then defaultFont =  1
--elseif locale == "enGB" then defaultFont =  1 -> enUS
--elseif locale == "enUS" then defaultFont =  1
--elseif locale == "esES" then defaultFont =  1
--elseif locale == "esMX" then defaultFont =  1
--elseif locale == "frFR" then defaultFont =  1
--elseif locale == "itIT" then defaultFont =  1
--elseif locale == "koKR" then defaultFont =  1 -- 2002.ttf (same as defined in FontStyleOverrides.xml/Fonts.xml)
--elseif locale == "ptBR" then defaultFont =  1
--elseif locale == "ptPT" then defaultFont =  1 -> ptBR
      if locale == "ruRU" then defaultFont = 12 -- FRIZQT___CYR.TTF (same as defined in FontStyleOverrides.xml/Fonts.xml)
  elseif locale == "zhCN" then defaultFont = 10 -- ARKai_T.ttf (same as defined in FontStyleOverrides.xml/Fonts.xml)
  elseif locale == "zhTW" then defaultFont = 10 -- ARKai_T.ttf (same as defined in FontStyleOverrides.xml/Fonts.xml)
--elseif locale == "enCN" then defaultFont = 10 -> zhCN
--elseif locale == "enTW" then defaultFont = 10 -> zhTW
  end

local fontPath = fontStyles[defaultFont].font

local classcolors = {}
for class, color in pairs(RAID_CLASS_COLORS) do -- Constants.lua
	classcolors[class] = {r = color.r, g = color.g, b = color.b}
end
classcolors["ZZZFAILURE"] = {r = 0.4, g = 0.4, b = 0.4}

-- texture: Interface\\WorldStateFrame\\Icons-Classes
-- role   : 1 = HEALER | 2 = TANK | 3 = DAMAGER | 4 = UNKNOWN
local classes = {
	DEATHKNIGHT = {coords = {0.2578125,  0.4921875,  0.5078125,  0.7421875 }}, -- ( 66/256, 126/256, 130/256, 190/256)
	DRUID       = {coords = {0.74609375, 0.98046875, 0.0078125,  0.2421875 }}, -- (191/256, 251/256,   2/256,  62/256)
	HUNTER      = {coords = {0.0078125,  0.2421875,  0.26171875, 0.49609375}}, -- (  2/256,  62/256,  67/256, 127/256)
	MAGE        = {coords = {0.25,       0.484375,   0.01171875, 0.24609375}}, -- ( 64/256, 124/256,   3/256,  63/256)
	MONK        = {coords = {0.5,        0.734375,   0.51171875, 0.74609375}}, -- (128/256, 188/256, 131/256, 191/256)
	PALADIN     = {coords = {0.0078125,  0.2421875,  0.51171875, 0.74609375}}, -- (  2/256,  62/256, 131/256, 191/256)
	PRIEST      = {coords = {0.5,        0.734375,   0.265625,   0.5       }}, -- (128/256, 188/256,  68/256, 128/256)
	ROGUE       = {coords = {0.50390625, 0.73828125, 0.01171875, 0.24609375}}, -- (129/256, 189/256,   3/256,  63/256)
	SHAMAN      = {coords = {0.25390625, 0.48828125, 0.2578125,  0.4921875 }}, -- ( 65/256, 125/256,  66/256, 126/256)
	WARLOCK     = {coords = {0.75,       0.984375,   0.2578125,  0.4921875 }}, -- (192/256, 252/256,  66/256, 126/256)
	WARRIOR     = {coords = {0.0078125,  0.2421875,  0.0078125,  0.2421875 }}, -- (  2/256,  62/256,   2/256,  62/256)
	ZZZFAILURE  = {coords = {0, 0, 0, 0},
	               spec   = {{role = 4, icon = nil, specName = ""},   -- 1 unknown
	                         {role = 4, icon = nil, specName = ""},   -- 2 unknown
	                         {role = 4, icon = nil, specName = ""},   -- 3 unknown
	                         {role = 4, icon = nil, specName = ""},   -- 4 unknown
	                         {role = 4, icon = nil, specName = ""}}}, -- 5 unknown
}

for classID = 1, MAX_CLASSES do
	local _, classTag = GetClassInfoByID(classID)
	local numTabs = GetNumSpecializationsForClassID(classID)
	--print("#", classTag, "| numTabs =", numTabs, "| classID =", classID) -- TEST
	classes[classTag].spec = {}
	for i = 1, 5 do -- 5 means: maximum numTabs (3 or 4) or MAX_TALENT_TABS (=4) + 1 for unknown spec = 5
		if i <= numTabs then
			local id, name, _, icon = GetSpecializationInfoForClassID(classID, i)
			local role = GetSpecializationRoleByID(id)
			--print("#", role, id, name, icon) -- TEST
			if     role == "DAMAGER" then classes[classTag].spec[i] = {role = 3, icon = icon, specName = name} -- DAMAGER: total = 23
			elseif role == "HEALER"  then classes[classTag].spec[i] = {role = 1, icon = icon, specName = name} -- HEALER : total =  6
			elseif role == "TANK"    then classes[classTag].spec[i] = {role = 2, icon = icon, specName = name} -- TANK   : total =  5
			end
		else
			classes[classTag].spec[i] = {role = 4, icon = nil, specName = ""}
		end
	end
end

local class_LocaSort = {}
FillLocalizedClassList(class_LocaSort, false) -- Constants.lua

local class_BlizzSort = {}
for i = 1, #CLASS_SORT_ORDER do -- Constants.lua
	class_BlizzSort[ CLASS_SORT_ORDER[i] ] = i
end

local class_IntegerSort = { -- .cid .blizz .eng .loc
	{cid = "DEATHKNIGHT", blizz = class_BlizzSort.DEATHKNIGHT or  2, eng = "Death Knight", loc = class_LocaSort.DEATHKNIGHT or "Death Knight"}, -- 1
	{cid = "DRUID",       blizz = class_BlizzSort.DRUID       or  7, eng = "Druid",        loc = class_LocaSort.DRUID or "Druid"},              -- 2
	{cid = "HUNTER",      blizz = class_BlizzSort.HUNTER      or 11, eng = "Hunter",       loc = class_LocaSort.HUNTER or "Hunter"},            -- 3
	{cid = "MAGE",        blizz = class_BlizzSort.MAGE        or  9, eng = "Mage",         loc = class_LocaSort.MAGE or "Mage"},                -- 4
	{cid = "MONK",        blizz = class_BlizzSort.MONK        or  4, eng = "Monk",         loc = class_LocaSort.MONK or "Monk"},                -- 5
	{cid = "PALADIN",     blizz = class_BlizzSort.PALADIN     or  3, eng = "Paladin",      loc = class_LocaSort.PALADIN or "Paladin"},          -- 6
	{cid = "PRIEST",      blizz = class_BlizzSort.PRIEST      or  5, eng = "Priest",       loc = class_LocaSort.PRIEST or "Priest"},            -- 7
	{cid = "ROGUE",       blizz = class_BlizzSort.ROGUE       or  8, eng = "Rogue",        loc = class_LocaSort.ROGUE or "Rogue"},              -- 8
	{cid = "SHAMAN",      blizz = class_BlizzSort.SHAMAN      or  6, eng = "Shaman",       loc = class_LocaSort.SHAMAN or "Shaman"},            -- 9
	{cid = "WARLOCK",     blizz = class_BlizzSort.WARLOCK     or 10, eng = "Warlock",      loc = class_LocaSort.WARLOCK or "Warlock"},          -- 10
	{cid = "WARRIOR",     blizz = class_BlizzSort.WARRIOR     or  1, eng = "Warrior",      loc = class_LocaSort.WARRIOR or "Warrior"},          -- 11
}

local ranges = {
	DEATHKNIGHT =  47541, -- Death Coil        (30yd/m) - Lvl 55
	DRUID       =   5176, -- Wrath             (40yd/m) - Lvl  1
	HUNTER      =     75, -- Auto Shot         (40yd/m) - Lvl  1
	MAGE        =  44614, -- Frostfire Bolt    (40yd/m) - Lvl  1
	MONK        = 115546, -- Provoke           (40yd/m) - Lvl 14 MON14
	PALADIN     =  20271, -- Judgment          (30yd/m) - Lvl  3
	PRIEST      =    589, -- Shadow Word: Pain (40yd/m) - Lvl  4
	ROGUE       =   6770, -- Sap               (10yd/m) - Lvl 12 ROG12
	SHAMAN      =    403, -- Lightning Bolt    (30yd/m) - Lvl  1
	WARLOCK     =    686, -- Shadow Bolt       (40yd/m) - Lvl  1
	WARRIOR     =    100, -- Charge          (8-25yd/m) - Lvl  3
}
--for k, v in pairs(ranges) do local name, _, _, _, _, _, _, min, max = GetSpellInfo(v) print(k, v, name, min, max) end -- TEST
--print("IsSpellKnown", ranges[playerClassEN], "|", IsSpellKnown(ranges[playerClassEN]))

local rangeTypeName = {
	"1) CombatLog |cffffff790-73|r", -- 1 1) combatlog
	"2) ...",                        -- 2 2) class-spell based
	"3) ...",                        -- 3 3) mix 1 class-spell based + combatlog (range: 0-45)
	"4) ...",                        -- 4 4) mix 2 class-spell based + combatlog (range: class-spell dependent)
}

local rangeDisplay = { -- RANGE_DISP_LAY
	"STD 100",      --  1 STD Standard (with 'block')
	"STD 50 |TInterface\\Glues\\CharacterSelect\\Glues-AddOn-Icons:0:0:0:0:64:16:48:64:0:16|t", --  2
	"STD 10",       --  3
	"STD 100 mono", --  4
	"STD 50 mono",  --  5
	"STD 10 mono",  --  6
	"X 10",         --  7 X (without 'block')
	"X 100 mono",   --  8
	"X 50 mono",    --  9
	"X 10 mono",    -- 10
}

local Textures = {}
Textures.Path          = "Interface\\AddOns\\BattlegroundTargets\\BattlegroundTargets-texture-icons"
Textures.SliderKnob    = {0.296875, 0.46875,  0.015625, 0.28125}  -- {19/64, 30/64,  1/64, 18/64},
Textures.SliderBG_Lnor = {0.296875, 0.375,    0.421875, 0.515625} -- {19/64, 24/64, 27/64, 33/64},
Textures.SliderBG_Mnor = {0.390625, 0.40625,  0.421875, 0.515625} -- {25/64, 26/64, 27/64, 33/64},
Textures.SliderBG_Rnor = {0.40625,  0.484375, 0.421875, 0.515625} -- {26/64, 31/64, 27/64, 33/64},
Textures.SliderBG_Ldis = {0.296875, 0.375,    0.296875, 0.390625} -- {19/64, 24/64, 19/64, 25/64},
Textures.SliderBG_Mdis = {0.390625, 0.40625,  0.296875, 0.390625} -- {25/64, 26/64, 19/64, 25/64},
Textures.SliderBG_Rdis = {0.40625,  0.484375, 0.296875, 0.390625} -- {26/64, 31/64, 19/64, 25/64},
Textures.Expand        = {0.015625, 0.28125,  0.015625, 0.28125}  -- { 1/64, 18/64,  1/64, 18/64},
Textures.Collapse      = {0.28125,  0.28125,  0.28125,  0.015625, 0.015625, 0.28125,  0.015625, 0.015625}
Textures.Close         = {0.015625, 0.28125,  0.296875, 0.5625}   -- { 1/64, 18/64, 19/64, 36/64},
Textures.RoleIcon      ={{0.5,      0.75,     0.25,     0.5},     -- {32/64, 48/64, 16/64, 32/64},  -- 1 HEALER
                         {0.75,     1,        0,        0.25},    -- {48/64, 64/64,  0/64, 16/64},  -- 2 TANK
                         {0.5,      0.75,     0,        0.25},    -- {32/64, 48/64,  0/64, 16/64},  -- 3 DAMAGER
                         {0.75,     1,        0.25,     0.5}}     -- {48/64, 64/64, 16/64, 32/64}}, -- 4 UNKNOWN
Textures.l40_18        = {coords = {0.5625,   0.640625, 0.578125, 0.796875}, width = 10, height = 28} -- {36/64, 41/64, 37/64, 51/64}, width =  5*2, height = 14*2},
Textures.l40_24        = {coords = {0.421875, 0.5625,   0.578125, 0.734375}, width = 18, height = 20} -- {27/64, 36/64, 37/64, 47/64}, width =  9*2, height = 10*2},
Textures.l40_42        = {coords = {0.21875,  0.421875, 0.578125, 0.6875},   width = 26, height = 14} -- {14/64, 27/64, 37/64, 44/64}, width = 13*2, height =  7*2},
Textures.l40_81        = {coords = {0,        0.21875,  0.578125, 0.65625},  width = 28, height = 10} -- { 0/64, 14/64, 37/64, 42/64}, width = 14*2, height =  5*2},
Textures.UpdateWarning = {0,        0.546875, 0.734375, 0.984375} -- { 0/64, 35/64, 47/64, 63/64},

local raidUnitID = {}
for i = 1, 40 do
	raidUnitID["raid"..i] = 1
	raidUnitID["raidpet"..i] = 1
end
local playerUnitID = {
	target = 1,
	pettarget = 1,
	focus = 1,
	mouseover = 1,
}
local sumPos = {0, 45, 90, 135, 180, 225, 270, 315, 360} -- SUMPOSi
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function Print(...)
	print("|cffffff7fBattlegroundTargets:|r", ...)
end

local function NOOP() end

local function Desaturation(texture, desaturation)
	local shaderSupported = texture:SetDesaturated(desaturation)
	if not shaderSupported then
		if desaturation then
			texture:SetVertexColor(0.5, 0.5, 0.5)
		else
			texture:SetVertexColor(1.0, 1.0, 1.0)
		end
	end
end

local function ClassHexColor(class)
	local hex
	if classcolors[class] then
		hex = format("%.2x%.2x%.2x", classcolors[class].r*255, classcolors[class].g*255, classcolors[class].b*255)
	end
	return hex or "cccccc"
end

local function Range_Display(state, GVAR_TargetButton, display) -- RANGE_DISP_LAY
	if state then
		GVAR_TargetButton.Background:SetAlpha(1)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(1)
		GVAR_TargetButton.RangeTexture:SetAlpha(1)
		GVAR_TargetButton.HealthBar:SetAlpha(1)
		GVAR_TargetButton.RoleTexture:SetAlpha(1)
		GVAR_TargetButton.SpecTexture:SetAlpha(1)
		GVAR_TargetButton.ClassTexture:SetAlpha(1)
		GVAR_TargetButton.ClassColorBackground:SetTexture(GVAR_TargetButton.colR5, GVAR_TargetButton.colG5, GVAR_TargetButton.colB5, 1)
		GVAR_TargetButton.HealthBar:SetTexture(GVAR_TargetButton.colR, GVAR_TargetButton.colG, GVAR_TargetButton.colB, 1)
	elseif display == 1 then -- STD 100
		GVAR_TargetButton.Background:SetAlpha(1)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(1)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(1)
		GVAR_TargetButton.RoleTexture:SetAlpha(1)
		GVAR_TargetButton.SpecTexture:SetAlpha(1)
		GVAR_TargetButton.ClassTexture:SetAlpha(1)
	elseif display == 2 then -- STD 50
		GVAR_TargetButton.Background:SetAlpha(0.5)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(0.1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(0.5)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(0.5)
		GVAR_TargetButton.RoleTexture:SetAlpha(0.5)
		GVAR_TargetButton.SpecTexture:SetAlpha(0.5)
		GVAR_TargetButton.ClassTexture:SetAlpha(0.5)
	elseif display == 3 then -- STD 10
		GVAR_TargetButton.Background:SetAlpha(0.3)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(0.1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(0.25)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(0.1)
		GVAR_TargetButton.RoleTexture:SetAlpha(0.25)
		GVAR_TargetButton.SpecTexture:SetAlpha(0.25)
		GVAR_TargetButton.ClassTexture:SetAlpha(0.25)
 	elseif display == 4 then -- STD 100 mono
		GVAR_TargetButton.Background:SetAlpha(1)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(1)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(1)
		GVAR_TargetButton.RoleTexture:SetAlpha(1)
		GVAR_TargetButton.SpecTexture:SetAlpha(1)
		GVAR_TargetButton.ClassTexture:SetAlpha(1)
		GVAR_TargetButton.ClassColorBackground:SetTexture(0.2, 0.2, 0.2, 1)
		GVAR_TargetButton.HealthBar:SetTexture(0.4, 0.4, 0.4, 1)
 	elseif display == 5 then -- STD 50 mono
		GVAR_TargetButton.Background:SetAlpha(0.5)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(0.1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(0.5)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(0.5)
		GVAR_TargetButton.RoleTexture:SetAlpha(0.5)
		GVAR_TargetButton.SpecTexture:SetAlpha(0.5)
		GVAR_TargetButton.ClassTexture:SetAlpha(0.5)
		GVAR_TargetButton.ClassColorBackground:SetTexture(0.2, 0.2, 0.2, 1)
		GVAR_TargetButton.HealthBar:SetTexture(0.4, 0.4, 0.4, 1)
	elseif display == 6 then -- STD 10 mono
		GVAR_TargetButton.Background:SetAlpha(0.3)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(0.1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(0.25)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(0.1)
		GVAR_TargetButton.RoleTexture:SetAlpha(0.25)
		GVAR_TargetButton.SpecTexture:SetAlpha(0.25)
		GVAR_TargetButton.ClassTexture:SetAlpha(0.25)
		GVAR_TargetButton.ClassColorBackground:SetTexture(0.2, 0.2, 0.2, 1)
		GVAR_TargetButton.HealthBar:SetTexture(0.4, 0.4, 0.4, 1)
	elseif display == 7 then -- X 10
		GVAR_TargetButton.Background:SetAlpha(0.3)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(0.1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(0.25)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(0.1)
		GVAR_TargetButton.RoleTexture:SetAlpha(0.25)
		GVAR_TargetButton.SpecTexture:SetAlpha(0.25)
		GVAR_TargetButton.ClassTexture:SetAlpha(0.25)
 	elseif display == 8 then -- X 100 mono
		GVAR_TargetButton.Background:SetAlpha(1)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(1)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(1)
		GVAR_TargetButton.RoleTexture:SetAlpha(1)
		GVAR_TargetButton.SpecTexture:SetAlpha(1)
		GVAR_TargetButton.ClassTexture:SetAlpha(1)
		GVAR_TargetButton.ClassColorBackground:SetTexture(0.2, 0.2, 0.2, 1)
		GVAR_TargetButton.HealthBar:SetTexture(0.4, 0.4, 0.4, 1)
 	elseif display == 9 then -- X 50 mono
		GVAR_TargetButton.Background:SetAlpha(0.5)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(0.1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(0.5)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(0.5)
		GVAR_TargetButton.RoleTexture:SetAlpha(0.5)
		GVAR_TargetButton.SpecTexture:SetAlpha(0.5)
		GVAR_TargetButton.ClassTexture:SetAlpha(0.5)
		GVAR_TargetButton.ClassColorBackground:SetTexture(0.2, 0.2, 0.2, 1)
		GVAR_TargetButton.HealthBar:SetTexture(0.4, 0.4, 0.4, 1)
	else--if display == 10 then -- X 10 mono
		GVAR_TargetButton.Background:SetAlpha(0.3)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(0.1)
		GVAR_TargetButton.ClassColorBackground:SetAlpha(0.25)
		GVAR_TargetButton.RangeTexture:SetAlpha(0)
		GVAR_TargetButton.HealthBar:SetAlpha(0.1)
		GVAR_TargetButton.RoleTexture:SetAlpha(0.25)
		GVAR_TargetButton.SpecTexture:SetAlpha(0.25)
		GVAR_TargetButton.ClassTexture:SetAlpha(0.25)
		GVAR_TargetButton.ClassColorBackground:SetTexture(0.2, 0.2, 0.2, 1)
		GVAR_TargetButton.HealthBar:SetTexture(0.4, 0.4, 0.4, 1)
	end
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
TEMPLATE.BorderTRBL = function(frame) -- TRBL = Top-Right-Bottom-Left
	frame.FrameBorder = frame:CreateTexture(nil, "BORDER")
	frame.FrameBorder:SetPoint("TOPLEFT", 1, -1)
	frame.FrameBorder:SetPoint("BOTTOMRIGHT", -1, 1)
	frame.FrameBorder:SetTexture(0, 0, 0, 1)
	frame.FrameBackground = frame:CreateTexture(nil, "BACKGROUND")
	frame.FrameBackground:SetPoint("TOPLEFT", 0, 0)
	frame.FrameBackground:SetPoint("BOTTOMRIGHT", 0, 0)
	frame.FrameBackground:SetTexture(0.8, 0.2, 0.2, 1)
end
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
TEMPLATE.ButtonColor = {
	{normal = {0.38, 0   , 0   , 1}, border = {0.73, 0.26, 0.21, 1}, font = "GameFontNormal"     }, -- 1 red
	{normal = {0   , 0   , 0.5 , 1}, border = {0.43, 0.32, 0.68, 1}, font = "GameFontNormalSmall"}, -- 2 blue
	{normal = {0   , 0.2 , 0   , 1}, border = {0.24, 0.46, 0.21, 1}, font = "GameFontNormalSmall"}, -- 3 green
	{normal = {0.38, 0   , 0   , 1}, border = {0.73, 0.26, 0.21, 1}, font = "GameFontNormalSmall"}, -- 4 red
	{normal = {0.11, 0.11, 0.11, 1}, border = {0.44, 0.44, 0.44, 1}, font = "GameFontNormalSmall"}, -- 5 dark grey
}

TEMPLATE.DisableTextButton = function(button)
	button.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	button.Border:SetTexture(0.4, 0.4, 0.4, 1)
	button:EnableMouse(false)
	button:Disable()
end

TEMPLATE.EnableTextButton = function(button)
	button.Text:SetTextColor(button.r, button.g, button.b, 1)
	button.Border:SetTexture(unpack(TEMPLATE.ButtonColor[button.action].border))
	button:EnableMouse(true)
	button:Enable()
end

TEMPLATE.TextButton = function(button, text, action)
	button.Background = button:CreateTexture(nil, "BORDER")
	button.Background:SetPoint("TOPLEFT", 1, -1)
	button.Background:SetPoint("BOTTOMRIGHT", -1, 1)
	button.Background:SetTexture(0, 0, 0, 1)

	button.Border = button:CreateTexture(nil, "BACKGROUND")
	button.Border:SetPoint("TOPLEFT", 0, 0)
	button.Border:SetPoint("BOTTOMRIGHT", 0, 0)
	button.Border:SetTexture(unpack(TEMPLATE.ButtonColor[action].border))

	button.Normal = button:CreateTexture(nil, "ARTWORK")
	button.Normal:SetPoint("TOPLEFT", 2, -2)
	button.Normal:SetPoint("BOTTOMRIGHT", -2, 2)
	button.Normal:SetTexture(unpack(TEMPLATE.ButtonColor[action].normal))
	button:SetNormalTexture(button.Normal)

	button.Disabled = button:CreateTexture(nil, "OVERLAY")
	button.Disabled:SetPoint("TOPLEFT", 3, -3)
	button.Disabled:SetPoint("BOTTOMRIGHT", -3, 3)
	button.Disabled:SetTexture(0.6, 0.6, 0.6, 0.2)
	button:SetDisabledTexture(button.Disabled)

	button.Highlight = button:CreateTexture(nil, "OVERLAY")
	button.Highlight:SetPoint("TOPLEFT", 3, -3)
	button.Highlight:SetPoint("BOTTOMRIGHT", -3, 3)
	button.Highlight:SetTexture(0.6, 0.6, 0.6, 0.2)
	button:SetHighlightTexture(button.Highlight)

	button.Text = button:CreateFontString(nil, "OVERLAY", TEMPLATE.ButtonColor[action].font)
	button.Text:SetPoint("CENTER", 0, 0)
	button.Text:SetJustifyH("CENTER")
	button.Text:SetTextColor(1, 0.82, 0, 1)
	button.Text:SetText(text)

	button:SetScript("OnMouseDown", function(self) self.Text:SetPoint("CENTER", 1, -1) end)
	button:SetScript("OnMouseUp", function(self) self.Text:SetPoint("CENTER", 0, 0) end)

	button.action = action
	button.r, button.g, button.b = button.Text:GetTextColor()
end
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--TEMPLATE.DisableIconButton = function(button)
--	button.Border:SetTexture(0.4, 0.4, 0.4, 1)
--	button:Disable()
--end

--TEMPLATE.EnableIconButton = function(button)
--	button.Border:SetTexture(0.8, 0.2, 0.2, 1)
--	button:Enable()
--end

TEMPLATE.IconButton = function(button, cut)
	button.Back = button:CreateTexture(nil, "BORDER")
	button.Back:SetPoint("TOPLEFT", 1, -1)
	button.Back:SetPoint("BOTTOMRIGHT", -1, 1)
	button.Back:SetTexture(0, 0, 0, 1)

	button.Border = button:CreateTexture(nil, "BACKGROUND")
	button.Border:SetPoint("TOPLEFT", 0, 0)
	button.Border:SetPoint("BOTTOMRIGHT", 0, 0)
	button.Border:SetTexture(0.8, 0.2, 0.2, 1)

	button.Highlight = button:CreateTexture(nil, "OVERLAY")
	button.Highlight:SetPoint("TOPLEFT", 3, -3)
	button.Highlight:SetPoint("BOTTOMRIGHT", -3, 3)
	button.Highlight:SetTexture(0.6, 0.6, 0.6, 0.2)
	button:SetHighlightTexture(button.Highlight)

	button.Normal = button:CreateTexture(nil, "ARTWORK")
	button.Normal:SetPoint("TOPLEFT", 3, -3)
	button.Normal:SetPoint("BOTTOMRIGHT", -3, 3)
	button.Normal:SetTexture(Textures.Path)
	button.Normal:SetTexCoord(unpack(Textures.Close))
	button:SetNormalTexture(button.Normal)

	button.Push = button:CreateTexture(nil, "ARTWORK")
	button.Push:SetPoint("TOPLEFT", 4, -4)
	button.Push:SetPoint("BOTTOMRIGHT", -4, 4)
	button.Push:SetTexture(Textures.Path)
	button.Push:SetTexCoord(unpack(Textures.Close))
	button:SetPushedTexture(button.Push)

	button.Disabled = button:CreateTexture(nil, "ARTWORK")
	button.Disabled:SetPoint("TOPLEFT", 3, -3)
	button.Disabled:SetPoint("BOTTOMRIGHT", -3, 3)
	button.Disabled:SetTexture(Textures.Path)
	button.Disabled:SetTexCoord(unpack(Textures.Close))
	button:SetDisabledTexture(button.Disabled)
	Desaturation(button.Disabled, true)
end
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
TEMPLATE.DisableCheckButton = function(button)
	if button.Text then
		button.Text:SetTextColor(0.5, 0.5, 0.5)
	elseif button.Icon then
		Desaturation(button.Icon, true)
	end
	button.Border:SetTexture(0.4, 0.4, 0.4, 1)
	button:Disable()
end

TEMPLATE.EnableCheckButton = function(button)
	if button.Text then
		button.Text:SetTextColor(1, 1, 1)
	elseif button.Icon then
		Desaturation(button.Icon, false)
	end
	button.Border:SetTexture(0.8, 0.2, 0.2, 1)
	button:Enable()
end

TEMPLATE.CheckButton = function(button, size, space, text, icon)
	button.Border = button:CreateTexture(nil, "BACKGROUND")
	button.Border:SetWidth( size )
	button.Border:SetHeight( size )
	button.Border:SetPoint("LEFT", 0, 0)
	button.Border:SetTexture(0.4, 0.4, 0.4, 1)

	button.Background = button:CreateTexture(nil, "BORDER")
	button.Background:SetPoint("TOPLEFT", button.Border, "TOPLEFT", 1, -1)
	button.Background:SetPoint("BOTTOMRIGHT", button.Border, "BOTTOMRIGHT", -1, 1)
	button.Background:SetTexture(0, 0, 0, 1)

	button.Normal = button:CreateTexture(nil, "ARTWORK")
	button.Normal:SetPoint("TOPLEFT", button.Border, "TOPLEFT", 1, -1)
	button.Normal:SetPoint("BOTTOMRIGHT", button.Border, "BOTTOMRIGHT", -1, 1)
	button.Normal:SetTexture(0, 0, 0, 1)
	button:SetNormalTexture(button.Normal)

	button.Push = button:CreateTexture(nil, "ARTWORK")
	button.Push:SetPoint("TOPLEFT", button.Border, "TOPLEFT", 4, -4)
	button.Push:SetPoint("BOTTOMRIGHT", button.Border, "BOTTOMRIGHT", -4, 4)
	button.Push:SetTexture(0.4, 0.4, 0.4, 0.5)
	button:SetPushedTexture(button.Push)

	button.Disabled = button:CreateTexture(nil, "ARTWORK")
	button.Disabled:SetPoint("TOPLEFT", button.Border, "TOPLEFT", 3, -3)
	button.Disabled:SetPoint("BOTTOMRIGHT", button.Border, "BOTTOMRIGHT", -3, 3)
	button.Disabled:SetTexture(0.4, 0.4, 0.4, 0.5)
	button:SetDisabledTexture(button.Disabled)

	button.Checked = button:CreateTexture(nil, "ARTWORK")
	button.Checked:SetWidth( size )
	button.Checked:SetHeight( size )
	button.Checked:SetPoint("LEFT", 0, 0)
	button.Checked:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
	button:SetCheckedTexture(button.Checked)

	if icon then
		button.Icon = button:CreateTexture(nil, "BORDER")
		button.Icon:SetWidth(Textures[icon].width)
		button.Icon:SetHeight(Textures[icon].height)
		button.Icon:SetPoint("LEFT", button.Normal, "RIGHT", space, 0)
		button.Icon:SetTexture(Textures.Path)
		button.Icon:SetTexCoord(unpack(Textures[icon].coords))
		button:SetWidth(size + space + Textures[icon].width + space)
		button:SetHeight(size)
	else
		button.Text = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		button.Text:SetHeight( size )
		button.Text:SetPoint("LEFT", button.Normal, "RIGHT", space, 0)
		button.Text:SetJustifyH("LEFT")
		button.Text:SetText(text)
		button.Text:SetTextColor(1, 1, 1, 1)
		button:SetWidth(size + space + button.Text:GetStringWidth() + space)
		button:SetHeight(size)
	end

	button.Highlight = button:CreateTexture(nil, "OVERLAY")
	button.Highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
	button.Highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
	button.Highlight:SetTexture(1, 1, 1, 0.15) -- COPYHL
	button.Highlight:Hide()

	button:SetScript("OnEnter", function() button.Highlight:Show() end)
	button:SetScript("OnLeave", function() button.Highlight:Hide() end)
end
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
TEMPLATE.SetTabButton = function(button, show)
	if show then
		button.TextureBottom:SetTexture(0, 0, 0, 1)
		button.TextureBorder:SetTexture(0.8, 0.2, 0.2, 1)
		button.show = true
	else
		button.TextureBottom:SetTexture(0.8, 0.2, 0.2, 1)
		button.TextureBorder:SetTexture(0.4, 0.4, 0.4, 0.4)
		button.show = false
	end
end

TEMPLATE.DisableTabButton = function(button)
	if button.TabText then
		button.TabText:SetTextColor(0.5, 0.5, 0.5, 1)
	elseif button.TabTexture then
		Desaturation(button.TabTexture, true)
	end
	button:Disable()
end

TEMPLATE.EnableTabButton = function(button, active)
	if button.TabText then
		if button.monotext then
			button.TabText:SetTextColor(1, 0.82, 0, 1)
		elseif active then
			button.TabText:SetTextColor(0, 0.75, 0, 1)
		else
			button.TabText:SetTextColor(1, 0, 0, 1)
		end
	elseif button.TabTexture then
		Desaturation(button.TabTexture, false)
	end
	button:Enable()
end

TEMPLATE.TabButton = function(button, text, active, monotext)
	button.monotext = monotext
	button.Texture = button:CreateTexture(nil, "BORDER")
	button.Texture:SetPoint("TOPLEFT", 1, -1)
	button.Texture:SetPoint("BOTTOMRIGHT", -1, 1)
	button.Texture:SetTexture(0, 0, 0, 1)

	button.TextureBorder = button:CreateTexture(nil, "BACKGROUND")
	button.TextureBorder:SetPoint("TOPLEFT", 0, 0)
	button.TextureBorder:SetPoint("BOTTOMRIGHT", -1, 1)
	button.TextureBorder:SetPoint("TOPRIGHT" ,0, 0)
	button.TextureBorder:SetPoint("BOTTOMLEFT" ,1, 1)
	button.TextureBorder:SetTexture(0.8, 0.2, 0.2, 1)

	button.TextureBottom = button:CreateTexture(nil, "ARTWORK")
	button.TextureBottom:SetPoint("TOPLEFT", button, "BOTTOMLEFT" ,1, 2)
	button.TextureBottom:SetPoint("BOTTOMLEFT" ,1, 1)
	button.TextureBottom:SetPoint("TOPRIGHT", button, "BOTTOMRIGHT" ,-1, 2)
	button.TextureBottom:SetPoint("BOTTOMRIGHT" ,-1, 1)
	button.TextureBottom:SetTexture(0.8, 0.2, 0.2, 1)

	button.TextureHighlight = button:CreateTexture(nil, "ARTWORK")
	button.TextureHighlight:SetPoint("TOPLEFT", 3, -3)
	button.TextureHighlight:SetPoint("BOTTOMRIGHT", -3, 3)
	button.TextureHighlight:SetTexture(1, 1, 1, 0.1)
	button:SetHighlightTexture(button.TextureHighlight)

	if text then
		button.TabText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		button.TabText:SetText(text)
		button.TabText:SetWidth( button.TabText:GetStringWidth()+10 )
		button.TabText:SetHeight(12)
		button.TabText:SetPoint("CENTER", button, "CENTER", 0, 0)
		button.TabText:SetJustifyH("CENTER")
		if monotext then
			button.TabText:SetTextColor(1, 0.82, 0, 1)
		elseif active then
			button.TabText:SetTextColor(0, 0.75, 0, 1)
		else
			button.TabText:SetTextColor(1, 0, 0, 1)
		end
	else
		button.TabTexture = button:CreateTexture(nil, "OVERLAY")
		button.TabTexture:SetPoint("CENTER", 0, 0)
		button.TabTexture:SetWidth(17)
		button.TabTexture:SetHeight(17)
		button.TabTexture:SetTexture(AddonIcon)
	end
	
	button:SetScript("OnEnter", function() if not button.show then button.TextureBorder:SetTexture(0.4, 0.4, 0.4, 0.8) end end)
	button:SetScript("OnLeave", function() if not button.show then button.TextureBorder:SetTexture(0.4, 0.4, 0.4, 0.4) end end)
end
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
TEMPLATE.DisableSlider = function(slider)
	slider.textMin:SetTextColor(0.5, 0.5, 0.5, 1)
	slider.textMax:SetTextColor(0.5, 0.5, 0.5, 1)
	slider.sliderBGL:SetTexCoord(unpack(Textures.SliderBG_Ldis))
	slider.sliderBGM:SetTexCoord(unpack(Textures.SliderBG_Mdis))
	slider.sliderBGR:SetTexCoord(unpack(Textures.SliderBG_Rdis))
	slider.thumb:SetTexCoord(0, 0, 0, 0)
	slider.Background:SetTexture(0, 0, 0, 0)
	slider:SetScript("OnEnter", NOOP)
	slider:SetScript("OnLeave", NOOP)
	slider:Disable()
end

TEMPLATE.EnableSlider = function(slider)
	slider.textMin:SetTextColor(0.8, 0.8, 0.8, 1)
	slider.textMax:SetTextColor(0.8, 0.8, 0.8, 1)
	slider.sliderBGL:SetTexCoord(unpack(Textures.SliderBG_Lnor))
	slider.sliderBGM:SetTexCoord(unpack(Textures.SliderBG_Mnor))
	slider.sliderBGR:SetTexCoord(unpack(Textures.SliderBG_Rnor))
	slider.thumb:SetTexCoord(unpack(Textures.SliderKnob))
	slider:SetScript("OnEnter", function() slider.Background:SetTexture(1, 1, 1, 0.15) end) -- COPYHL
	slider:SetScript("OnLeave", function() slider.Background:SetTexture(0, 0, 0, 0) end)
	slider:Enable()
end

TEMPLATE.Slider = function(slider, width, step, minVal, maxVal, curVal, func, measure)
	slider:SetWidth(width)
	slider:SetHeight(16)
	slider:SetValueStep(step) 
	slider:SetMinMaxValues(minVal, maxVal)
	slider:SetValue(curVal)
	slider:SetOrientation("HORIZONTAL")

	slider.Background = slider:CreateTexture(nil, "BACKGROUND")
	slider.Background:SetWidth(width)
	slider.Background:SetHeight(16)
	slider.Background:SetPoint("LEFT", 0, 0)
	slider.Background:SetTexture(0, 0, 0, 0)

	slider.textMin = slider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	slider.textMin:SetPoint("TOP", slider, "BOTTOM", 0, -1)
	slider.textMin:SetPoint("LEFT", slider, "LEFT", 0, 0)
	slider.textMin:SetJustifyH("CENTER")
	slider.textMin:SetTextColor(0.8, 0.8, 0.8, 1)
	if measure == "%" then
		slider.textMin:SetText(minVal.."%")
	elseif measure == "K" then
		slider.textMin:SetText((minVal/1000).."k")
	elseif measure == "H" then
		slider.textMin:SetText((minVal/100))
	elseif measure == "px" then
		slider.textMin:SetText(minVal.."px")
	elseif measure == "blank" then
		slider.textMin:SetText("")
	else
		slider.textMin:SetText(minVal)
	end
	slider.textMax = slider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	slider.textMax:SetPoint("TOP", slider, "BOTTOM", 0, -1)
	slider.textMax:SetPoint("RIGHT", slider, "RIGHT", 0, 0)
	slider.textMax:SetJustifyH("CENTER")
	slider.textMax:SetTextColor(0.8, 0.8, 0.8, 1)
	if measure == "%" then
		slider.textMax:SetText(maxVal.."%")
	elseif measure == "K" then
		slider.textMax:SetText((maxVal/1000).."k")
	elseif measure == "H" then
		slider.textMax:SetText((maxVal/100))
	elseif measure == "px" then
		slider.textMax:SetText(maxVal.."px")
	elseif measure == "blank" then
		slider.textMax:SetText("")
	else
		slider.textMax:SetText(maxVal)
	end

	slider.sliderBGL = slider:CreateTexture(nil, "BACKGROUND")
	slider.sliderBGL:SetWidth(5)
	slider.sliderBGL:SetHeight(6)
	slider.sliderBGL:SetPoint("LEFT", slider, "LEFT", 0, 0)
	slider.sliderBGL:SetTexture(Textures.Path)
	slider.sliderBGL:SetTexCoord(unpack(Textures.SliderBG_Lnor))
	slider.sliderBGM = slider:CreateTexture(nil, "BACKGROUND")
	slider.sliderBGM:SetWidth(width-5-5)
	slider.sliderBGM:SetHeight(6)
	slider.sliderBGM:SetPoint("LEFT", slider.sliderBGL, "RIGHT", 0, 0)
	slider.sliderBGM:SetTexture(Textures.Path)
	slider.sliderBGM:SetTexCoord(unpack(Textures.SliderBG_Mnor))
	slider.sliderBGR = slider:CreateTexture(nil, "BACKGROUND")
	slider.sliderBGR:SetWidth(5)
	slider.sliderBGR:SetHeight(6)
	slider.sliderBGR:SetPoint("LEFT", slider.sliderBGM, "RIGHT", 0, 0)
	slider.sliderBGR:SetTexture(Textures.Path)
	slider.sliderBGR:SetTexCoord(unpack(Textures.SliderBG_Rnor))

	slider.thumb = slider:CreateTexture(nil, "BORDER")
	slider.thumb:SetWidth(11)
	slider.thumb:SetHeight(17)
	slider.thumb:SetTexture(Textures.Path)
	slider.thumb:SetTexCoord(unpack(Textures.SliderKnob))
	slider:SetThumbTexture(slider.thumb)

	slider:SetScript("OnValueChanged", function(self, value)
		if not slider:IsEnabled() then return end
		if func then
			func(self, value)
		end
	end)

	slider:SetScript("OnEnter", function() slider.Background:SetTexture(1, 1, 1, 0.15) end) -- COPYHL
	slider:SetScript("OnLeave", function() slider.Background:SetTexture(0, 0, 0, 0) end)
end
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
TEMPLATE.DisablePullDownMenu = function(button)
	button.PullDownMenu:Hide()
	button.PullDownButtonBorder:SetTexture(0.4, 0.4, 0.4, 1)
	button:Disable()
end

TEMPLATE.EnablePullDownMenu = function(button)
	button.PullDownButtonBorder:SetTexture(0.8, 0.2, 0.2, 1)
	button:Enable()
end

TEMPLATE.PullDownMenu = function(button, contentName, buttonText, pulldownWidth, contentNum, func, buttonOnEnterFunc, buttonOnLeaveFunc)
	local sizeOffset = 5
	local sizeBarHeight = 14

	button.PullDownButtonBG = button:CreateTexture(nil, "BORDER")
	button.PullDownButtonBG:SetPoint("TOPLEFT", 1, -1)
	button.PullDownButtonBG:SetPoint("BOTTOMRIGHT", -1, 1)
	button.PullDownButtonBG:SetTexture(0, 0, 0, 1)

	button.PullDownButtonBorder = button:CreateTexture(nil, "BACKGROUND")
	button.PullDownButtonBorder:SetPoint("TOPLEFT", 0, 0)
	button.PullDownButtonBorder:SetPoint("BOTTOMRIGHT", 0, 0)
	button.PullDownButtonBorder:SetTexture(0.4, 0.4, 0.4, 1)

	button.PullDownButtonExpand = button:CreateTexture(nil, "OVERLAY")
	button.PullDownButtonExpand:SetHeight(14)
	button.PullDownButtonExpand:SetWidth(14)
	button.PullDownButtonExpand:SetPoint("RIGHT", button, "RIGHT", -2, 0)
	button.PullDownButtonExpand:SetTexture(Textures.Path)
	button.PullDownButtonExpand:SetTexCoord(unpack(Textures.Expand))
	button:SetNormalTexture(button.PullDownButtonExpand)

	button.PullDownButtonDisabled = button:CreateTexture(nil, "OVERLAY")
	button.PullDownButtonDisabled:SetPoint("TOPLEFT", 3, -3)
	button.PullDownButtonDisabled:SetPoint("BOTTOMRIGHT", -3, 3)
	button.PullDownButtonDisabled:SetTexture(0.6, 0.6, 0.6, 0.2)
	button:SetDisabledTexture(button.PullDownButtonDisabled)

	button.PullDownButtonHighlight = button:CreateTexture(nil, "OVERLAY")
	button.PullDownButtonHighlight:SetPoint("TOPLEFT", 1, -1)
	button.PullDownButtonHighlight:SetPoint("BOTTOMRIGHT", -1, 1)
	button.PullDownButtonHighlight:SetTexture(1, 1, 1, 0.15) -- COPYHL
	button:SetHighlightTexture(button.PullDownButtonHighlight)

	button.PullDownButtonText = button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	button.PullDownButtonText:SetHeight(sizeBarHeight)
	button.PullDownButtonText:SetPoint("LEFT", sizeOffset+2, 0)
	button.PullDownButtonText:SetJustifyH("LEFT")
	button.PullDownButtonText:SetText(buttonText)
	button.PullDownButtonText:SetTextColor(1, 1, 0.49, 1)

	button.PullDownMenu = CreateFrame("Frame", nil, button)
	TEMPLATE.BorderTRBL(button.PullDownMenu)
	button.PullDownMenu:EnableMouse(true)
	button.PullDownMenu:SetToplevel(true)
	button.PullDownMenu:SetHeight(sizeOffset+(contentNum*sizeBarHeight)+sizeOffset)
	button.PullDownMenu:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, 1)
	button.PullDownMenu:Hide()

	local function OnLeave()
		if not button:IsMouseOver() and not button.PullDownMenu:IsMouseOver() then
			button.PullDownMenu:Hide()
			button.PullDownButtonExpand:SetTexCoord(unpack(Textures.Expand))
		end
	end

	local autoWidth = 0
	for i = 1, contentNum do
		if not button.PullDownMenu.Button then button.PullDownMenu.Button = {} end
		button.PullDownMenu.Button[i] = CreateFrame("Button", nil, button.PullDownMenu)
		button.PullDownMenu.Button[i]:SetHeight(sizeBarHeight)
		button.PullDownMenu.Button[i]:SetFrameLevel( button.PullDownMenu:GetFrameLevel() + 5 )
		if i == 1 then
			button.PullDownMenu.Button[i]:SetPoint("TOPLEFT", button.PullDownMenu, "TOPLEFT", sizeOffset, -sizeOffset)
		else
			button.PullDownMenu.Button[i]:SetPoint("TOPLEFT", button.PullDownMenu.Button[(i-1)], "BOTTOMLEFT", 0, 0)
		end

		button.PullDownMenu.Button[i].Text = button.PullDownMenu.Button[i]:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		button.PullDownMenu.Button[i].Text:SetHeight(sizeBarHeight)
		button.PullDownMenu.Button[i].Text:SetPoint("LEFT", 2, 0)
		button.PullDownMenu.Button[i].Text:SetJustifyH("LEFT")
		button.PullDownMenu.Button[i].Text:SetTextColor(1, 1, 1, 1)

		if buttonOnEnterFunc and buttonOnLeaveFunc then
			button.PullDownMenu.Button[i]:SetScript("OnEnter", function(self) buttonOnEnterFunc(self, button) end)
			button.PullDownMenu.Button[i]:SetScript("OnLeave", function(self) buttonOnLeaveFunc(self, button) OnLeave() end)
		else
			button.PullDownMenu.Button[i]:SetScript("OnLeave", OnLeave)
		end
		button.PullDownMenu.Button[i]:SetScript("OnClick", function()
			button.value1 = button.PullDownMenu.Button[i].value1
			button.PullDownButtonText:SetText( button.PullDownMenu.Button[i].Text:GetText() )
			button.PullDownMenu:Hide()
			button.PullDownButtonExpand:SetTexCoord(unpack(Textures.Expand))
			if func then
				func(button.value1) -- PDFUNC
			end
		end)

		button.PullDownMenu.Button[i].Highlight = button.PullDownMenu.Button[i]:CreateTexture(nil, "ARTWORK")
		button.PullDownMenu.Button[i].Highlight:SetPoint("TOPLEFT", 0, 0)
		button.PullDownMenu.Button[i].Highlight:SetPoint("BOTTOMRIGHT", 0, 0)
		button.PullDownMenu.Button[i].Highlight:SetTexture(1, 1, 1, 0.2)
		button.PullDownMenu.Button[i]:SetHighlightTexture(button.PullDownMenu.Button[i].Highlight)

		if contentName == "SortBy" then
			button.PullDownMenu.Button[i].Text:SetText(sortBy[i])
			button.PullDownMenu.Button[i].value1 = i
		elseif contentName == "SortDetail" then
			button.PullDownMenu.Button[i].Text:SetText(sortDetail[i])
			button.PullDownMenu.Button[i].value1 = i	
		elseif contentName == "RangeType" then
			button.PullDownMenu.Button[i].Text:SetText(rangeTypeName[i])
			button.PullDownMenu.Button[i].value1 = i
		elseif contentName == "RangeDisplay" then
			button.PullDownMenu.Button[i].Text:SetText(rangeDisplay[i])
			button.PullDownMenu.Button[i].value1 = i
		elseif contentName == "FontStyle" then
			button.PullDownMenu.Button[i].Text:SetText(fontStyles[i].name)
			button.PullDownMenu.Button[i].value1 = i
		elseif contentName == "FontStyleNumber" then
			local fontname = strmatch(fontStyles[i].name, "(.*) %- .*")
			button.PullDownMenu.Button[i].Text:SetText(fontname)
			button.PullDownMenu.Button[i].value1 = i
		end
		button.PullDownMenu.Button[i]:Show()

		if pulldownWidth <= 0 then
			local w = button.PullDownMenu.Button[i].Text:GetStringWidth()+15+18
			if w > autoWidth then
				autoWidth = w
			end
		end
	end

	--  < 0 : auto, but max width n
	-- == 0 : auto
	--  > 0 : fixed width n
	local newWidth = pulldownWidth
	if pulldownWidth < 0 then
		if autoWidth < -pulldownWidth then
			newWidth = autoWidth
		else
			newWidth = -pulldownWidth
		end
	elseif pulldownWidth == 0 then
		newWidth = autoWidth
	end

	button.PullDownButtonText:SetWidth(newWidth-sizeOffset-sizeOffset)
	button.PullDownMenu:SetWidth(newWidth)
	for i = 1, contentNum do
		button.PullDownMenu.Button[i]:SetWidth(newWidth-sizeOffset-sizeOffset)
		button.PullDownMenu.Button[i].Text:SetWidth(newWidth-sizeOffset-sizeOffset)
	end
	button:SetWidth(newWidth)

	button.PullDownMenu:SetScript("OnLeave", OnLeave)
	button.PullDownMenu:SetScript("OnHide", function(self) self:Hide() end) -- for esc close

	button:SetScript("OnLeave", OnLeave)
	button:SetScript("OnClick", function()
		if button.PullDownMenu:IsShown() then
			button.PullDownMenu:Hide()
			button.PullDownButtonExpand:SetTexCoord(unpack(Textures.Expand))
		else
			button.PullDownMenu:Show()
			button.PullDownButtonExpand:SetTexCoord(unpack(Textures.Collapse))
		end
	end)
end
-- -----------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:InitOptions()
	SlashCmdList["BATTLEGROUNDTARGETS"] = function()
		BattlegroundTargets:Frame_Toggle(GVAR.OptionsFrame)
	end
	SLASH_BATTLEGROUNDTARGETS1 = "/bgt"
	SLASH_BATTLEGROUNDTARGETS2 = "/bgtargets"
	SLASH_BATTLEGROUNDTARGETS3 = "/battlegroundtargets"

	if type(BattlegroundTargets_Options.version) ~= "number" then
		BattlegroundTargets_Options.version = 22
	end

	if BattlegroundTargets_Options.version < 15 then
		wipe(BattlegroundTargets_Options)
		Print("Option reset.")
		BattlegroundTargets_Options.version = 22
	end

	if BattlegroundTargets_Options.version == 15 then -- realm logic switch
		if BattlegroundTargets_Options.ButtonHideRealm then
			BattlegroundTargets_Options.ButtonShowRealm = {}
			if BattlegroundTargets_Options.ButtonHideRealm[10] == true then BattlegroundTargets_Options.ButtonShowRealm[10] = false else BattlegroundTargets_Options.ButtonShowRealm[10] = true end
			if BattlegroundTargets_Options.ButtonHideRealm[15] == true then BattlegroundTargets_Options.ButtonShowRealm[15] = false else BattlegroundTargets_Options.ButtonShowRealm[15] = true end
			if BattlegroundTargets_Options.ButtonHideRealm[40] == true then BattlegroundTargets_Options.ButtonShowRealm[40] = false else BattlegroundTargets_Options.ButtonShowRealm[40] = true end
			BattlegroundTargets_Options.ButtonHideRealm = nil
		end
		BattlegroundTargets_Options.version = 16
	end

	if BattlegroundTargets_Options.version == 16 then -- font update
		BattlegroundTargets_Options.ButtonFontNameSize = {}
		BattlegroundTargets_Options.ButtonFontNameStyle = {}
		if type(BattlegroundTargets_Options.ButtonFontSize) == "table" then
			if type(BattlegroundTargets_Options.ButtonFontSize[10]) == "number" then BattlegroundTargets_Options.ButtonFontNameSize[10] = BattlegroundTargets_Options.ButtonFontSize[10] end
			if type(BattlegroundTargets_Options.ButtonFontSize[15]) == "number" then BattlegroundTargets_Options.ButtonFontNameSize[15] = BattlegroundTargets_Options.ButtonFontSize[15] end
			if type(BattlegroundTargets_Options.ButtonFontSize[40]) == "number" then BattlegroundTargets_Options.ButtonFontNameSize[40] = BattlegroundTargets_Options.ButtonFontSize[40] end
		end
		if type(BattlegroundTargets_Options.ButtonFontStyle) == "table" then
			if type(BattlegroundTargets_Options.ButtonFontStyle[10]) == "number" then BattlegroundTargets_Options.ButtonFontNameStyle[10] = BattlegroundTargets_Options.ButtonFontStyle[10] end
			if type(BattlegroundTargets_Options.ButtonFontStyle[15]) == "number" then BattlegroundTargets_Options.ButtonFontNameStyle[15] = BattlegroundTargets_Options.ButtonFontStyle[15] end
			if type(BattlegroundTargets_Options.ButtonFontStyle[40]) == "number" then BattlegroundTargets_Options.ButtonFontNameStyle[40] = BattlegroundTargets_Options.ButtonFontStyle[40] end
		end
		BattlegroundTargets_Options.ButtonFontSize = nil
		BattlegroundTargets_Options.ButtonFontStyle = nil
		BattlegroundTargets_Options.version = 17
	end

	if BattlegroundTargets_Options.version == 17 then -- reset font number size
		if type(BattlegroundTargets_Options.ButtonFontNumberSize) == "table" then
			Print("'Text: Number' size reset.")
		end
		BattlegroundTargets_Options.ButtonFontNumberSize = {}
		if type(BattlegroundTargets_Options.ButtonFontNameSize) == "table" then
			if type(BattlegroundTargets_Options.ButtonFontNameSize[10]) == "number" then BattlegroundTargets_Options.ButtonFontNumberSize[10] = BattlegroundTargets_Options.ButtonFontNameSize[10] end
			if type(BattlegroundTargets_Options.ButtonFontNameSize[15]) == "number" then BattlegroundTargets_Options.ButtonFontNumberSize[15] = BattlegroundTargets_Options.ButtonFontNameSize[15] end
			if type(BattlegroundTargets_Options.ButtonFontNameSize[40]) == "number" then BattlegroundTargets_Options.ButtonFontNumberSize[40] = BattlegroundTargets_Options.ButtonFontNameSize[40] end
		end
		BattlegroundTargets_Options.version = 18
	end

	if BattlegroundTargets_Options.version == 18 then -- range display remap
		if type(BattlegroundTargets_Options.ButtonRangeDisplay) == "table" then
			for i = 1, 3 do
				local size = 10
				    if i == 2 then size = 15
				elseif i == 3 then size = 40 end
				local num = BattlegroundTargets_Options.ButtonRangeDisplay[size]
				if type(num) == "number" then
					    if num == 2 then BattlegroundTargets_Options.ButtonRangeDisplay[size] = 4
					elseif num == 3 then BattlegroundTargets_Options.ButtonRangeDisplay[size] = 2
					elseif num == 4 then BattlegroundTargets_Options.ButtonRangeDisplay[size] = 5
					elseif num == 5 then BattlegroundTargets_Options.ButtonRangeDisplay[size] = 3
					elseif num == 7 then BattlegroundTargets_Options.ButtonRangeDisplay[size] = 8
					elseif num == 8 then BattlegroundTargets_Options.ButtonRangeDisplay[size] = 9
					elseif num == 9 then BattlegroundTargets_Options.ButtonRangeDisplay[size] = 7 end
				end
			end
		end
		BattlegroundTargets_Options.version = 19
	end

	if BattlegroundTargets_Options.version == 19 then
		BattlegroundTargets_Options.TargetIcon = nil
		BattlegroundTargets_Options.version = 20
	end

	if BattlegroundTargets_Options.version == 20 then
		BattlegroundTargets_Options.ButtonShowGuildGroup = nil
		BattlegroundTargets_Options.ButtonGuildGroupPosition = nil
		BattlegroundTargets_Options.SummaryScaleGuildGroup = nil
		BattlegroundTargets_Options.version = 21
	end

	if BattlegroundTargets_Options.version == 21 then -- summary positioning
		local s = ""
		if type(BattlegroundTargets_Options.LayoutTH) == "table" and type(BattlegroundTargets_Options.Summary) == "table" then
			if BattlegroundTargets_Options.Summary[10] and BattlegroundTargets_Options.LayoutTH[10] == 81 then s = s..".10v10." end
			if BattlegroundTargets_Options.Summary[15] and BattlegroundTargets_Options.LayoutTH[15] == 81 then s = s..".15v15." end
			if BattlegroundTargets_Options.Summary[40] and BattlegroundTargets_Options.LayoutTH[40] == 81 then s = s..".40v40." end
		end
		if s ~= "" then
			Print(s.. ": Summary position changed.")
		end
		if type(BattlegroundTargets_Options.Summary) == "table" then
			BattlegroundTargets_Options.SummaryToggle = {}
			if BattlegroundTargets_Options.Summary[10] == true then BattlegroundTargets_Options.SummaryToggle[10] = true else BattlegroundTargets_Options.SummaryToggle[10] = false end
			if BattlegroundTargets_Options.Summary[15] == true then BattlegroundTargets_Options.SummaryToggle[15] = true else BattlegroundTargets_Options.SummaryToggle[15] = false end
			if BattlegroundTargets_Options.Summary[40] == true then BattlegroundTargets_Options.SummaryToggle[40] = true else BattlegroundTargets_Options.SummaryToggle[40] = false end
		end
		if type(BattlegroundTargets_Options.SummaryScaleRole) == "table" then
			BattlegroundTargets_Options.SummaryScale = {}
			if type(BattlegroundTargets_Options.SummaryScaleRole[10]) == "number" then BattlegroundTargets_Options.SummaryScale[10] = BattlegroundTargets_Options.SummaryScaleRole[10] end
			if type(BattlegroundTargets_Options.SummaryScaleRole[15]) == "number" then BattlegroundTargets_Options.SummaryScale[15] = BattlegroundTargets_Options.SummaryScaleRole[15] end
			if type(BattlegroundTargets_Options.SummaryScaleRole[40]) == "number" then BattlegroundTargets_Options.SummaryScale[40] = BattlegroundTargets_Options.SummaryScaleRole[40] end
		end
		BattlegroundTargets_Options.Summary = nil
		BattlegroundTargets_Options.SummaryScaleRole = nil
		BattlegroundTargets_Options.LayoutButtonSpace = nil
		BattlegroundTargets_Options.version = 22
	end

	if type(BattlegroundTargets_Options.pos)                          ~= "table"   then BattlegroundTargets_Options.pos                          = {}    end
	if type(BattlegroundTargets_Options.MinimapButton)                ~= "boolean" then BattlegroundTargets_Options.MinimapButton                = false end
	if type(BattlegroundTargets_Options.MinimapButtonPos)             ~= "number"  then BattlegroundTargets_Options.MinimapButtonPos             = -90   end

	if type(BattlegroundTargets_Options.EnableBracket)                ~= "table"   then BattlegroundTargets_Options.EnableBracket                = {}    end
	if type(BattlegroundTargets_Options.EnableBracket[10])            ~= "boolean" then BattlegroundTargets_Options.EnableBracket[10]            = false end
	if type(BattlegroundTargets_Options.EnableBracket[15])            ~= "boolean" then BattlegroundTargets_Options.EnableBracket[15]            = false end
	if type(BattlegroundTargets_Options.EnableBracket[40])            ~= "boolean" then BattlegroundTargets_Options.EnableBracket[40]            = false end

	if type(BattlegroundTargets_Options.IndependentPositioning)       ~= "table"   then BattlegroundTargets_Options.IndependentPositioning       = {}    end
	if type(BattlegroundTargets_Options.IndependentPositioning[10])   ~= "boolean" then BattlegroundTargets_Options.IndependentPositioning[10]   = false end
	if type(BattlegroundTargets_Options.IndependentPositioning[15])   ~= "boolean" then BattlegroundTargets_Options.IndependentPositioning[15]   = false end
	if type(BattlegroundTargets_Options.IndependentPositioning[40])   ~= "boolean" then BattlegroundTargets_Options.IndependentPositioning[40]   = false end

	if type(BattlegroundTargets_Options.LayoutTH)                     ~= "table"   then BattlegroundTargets_Options.LayoutTH                     = {}    end
	if type(BattlegroundTargets_Options.LayoutTH[10])                 ~= "number"  then BattlegroundTargets_Options.LayoutTH[10]                 = 18    end
	if type(BattlegroundTargets_Options.LayoutTH[15])                 ~= "number"  then BattlegroundTargets_Options.LayoutTH[15]                 = 18    end
	if type(BattlegroundTargets_Options.LayoutTH[40])                 ~= "number"  then BattlegroundTargets_Options.LayoutTH[40]                 = 24    end
	if type(BattlegroundTargets_Options.LayoutSpace)                  ~= "table"   then BattlegroundTargets_Options.LayoutSpace                  = {}    end
	if type(BattlegroundTargets_Options.LayoutSpace[10])              ~= "number"  then BattlegroundTargets_Options.LayoutSpace[10]              = 0     end
	if type(BattlegroundTargets_Options.LayoutSpace[15])              ~= "number"  then BattlegroundTargets_Options.LayoutSpace[15]              = 0     end
	if type(BattlegroundTargets_Options.LayoutSpace[40])              ~= "number"  then BattlegroundTargets_Options.LayoutSpace[40]              = 0     end

	if type(BattlegroundTargets_Options.SummaryToggle)                ~= "table"   then BattlegroundTargets_Options.SummaryToggle                = {}    end
	if type(BattlegroundTargets_Options.SummaryToggle[10])            ~= "boolean" then BattlegroundTargets_Options.SummaryToggle[10]            = false end
	if type(BattlegroundTargets_Options.SummaryToggle[15])            ~= "boolean" then BattlegroundTargets_Options.SummaryToggle[15]            = false end
	if type(BattlegroundTargets_Options.SummaryToggle[40])            ~= "boolean" then BattlegroundTargets_Options.SummaryToggle[40]            = false end
	if type(BattlegroundTargets_Options.SummaryScale)                 ~= "table"   then BattlegroundTargets_Options.SummaryScale                 = {}    end
	if type(BattlegroundTargets_Options.SummaryScale[10])             ~= "number"  then BattlegroundTargets_Options.SummaryScale[10]             = 0.6   end
	if type(BattlegroundTargets_Options.SummaryScale[15])             ~= "number"  then BattlegroundTargets_Options.SummaryScale[15]             = 0.6   end
	if type(BattlegroundTargets_Options.SummaryScale[40])             ~= "number"  then BattlegroundTargets_Options.SummaryScale[40]             = 0.5   end
	if type(BattlegroundTargets_Options.SummaryPos)                   ~= "table"   then BattlegroundTargets_Options.SummaryPos                   = {}    end
	if type(BattlegroundTargets_Options.SummaryPos[10])               ~= "number"  then BattlegroundTargets_Options.SummaryPos[10]               = 1     end
	if type(BattlegroundTargets_Options.SummaryPos[15])               ~= "number"  then BattlegroundTargets_Options.SummaryPos[15]               = 1     end
	if type(BattlegroundTargets_Options.SummaryPos[40])               ~= "number"  then BattlegroundTargets_Options.SummaryPos[40]               = 1     end

	if type(BattlegroundTargets_Options.ButtonShowRole)               ~= "table"   then BattlegroundTargets_Options.ButtonShowRole               = {}    end
	if type(BattlegroundTargets_Options.ButtonShowSpec)               ~= "table"   then BattlegroundTargets_Options.ButtonShowSpec               = {}    end
	if type(BattlegroundTargets_Options.ButtonClassIcon)              ~= "table"   then BattlegroundTargets_Options.ButtonClassIcon              = {}    end
	if type(BattlegroundTargets_Options.ButtonShowRealm)              ~= "table"   then BattlegroundTargets_Options.ButtonShowRealm              = {}    end
	if type(BattlegroundTargets_Options.ButtonShowLeader)             ~= "table"   then BattlegroundTargets_Options.ButtonShowLeader             = {}    end
	if type(BattlegroundTargets_Options.ButtonShowTarget)             ~= "table"   then BattlegroundTargets_Options.ButtonShowTarget             = {}    end
	if type(BattlegroundTargets_Options.ButtonTargetScale)            ~= "table"   then BattlegroundTargets_Options.ButtonTargetScale            = {}    end
	if type(BattlegroundTargets_Options.ButtonTargetPosition)         ~= "table"   then BattlegroundTargets_Options.ButtonTargetPosition         = {}    end
	if type(BattlegroundTargets_Options.ButtonShowAssist)             ~= "table"   then BattlegroundTargets_Options.ButtonShowAssist             = {}    end
	if type(BattlegroundTargets_Options.ButtonAssistScale)            ~= "table"   then BattlegroundTargets_Options.ButtonAssistScale            = {}    end
	if type(BattlegroundTargets_Options.ButtonAssistPosition)         ~= "table"   then BattlegroundTargets_Options.ButtonAssistPosition         = {}    end
	if type(BattlegroundTargets_Options.ButtonShowFocus)              ~= "table"   then BattlegroundTargets_Options.ButtonShowFocus              = {}    end
	if type(BattlegroundTargets_Options.ButtonFocusScale)             ~= "table"   then BattlegroundTargets_Options.ButtonFocusScale             = {}    end
	if type(BattlegroundTargets_Options.ButtonFocusPosition)          ~= "table"   then BattlegroundTargets_Options.ButtonFocusPosition          = {}    end
	if type(BattlegroundTargets_Options.ButtonShowFlag)               ~= "table"   then BattlegroundTargets_Options.ButtonShowFlag               = {}    end
	if type(BattlegroundTargets_Options.ButtonFlagScale)              ~= "table"   then BattlegroundTargets_Options.ButtonFlagScale              = {}    end
	if type(BattlegroundTargets_Options.ButtonFlagPosition)           ~= "table"   then BattlegroundTargets_Options.ButtonFlagPosition           = {}    end
	if type(BattlegroundTargets_Options.ButtonShowTargetCount)        ~= "table"   then BattlegroundTargets_Options.ButtonShowTargetCount        = {}    end
	if type(BattlegroundTargets_Options.ButtonShowHealthBar)          ~= "table"   then BattlegroundTargets_Options.ButtonShowHealthBar          = {}    end
	if type(BattlegroundTargets_Options.ButtonShowHealthText)         ~= "table"   then BattlegroundTargets_Options.ButtonShowHealthText         = {}    end
	if type(BattlegroundTargets_Options.ButtonRangeCheck)             ~= "table"   then BattlegroundTargets_Options.ButtonRangeCheck             = {}    end
	if type(BattlegroundTargets_Options.ButtonTypeRangeCheck)         ~= "table"   then BattlegroundTargets_Options.ButtonTypeRangeCheck         = {}    end
	if type(BattlegroundTargets_Options.ButtonRangeDisplay)           ~= "table"   then BattlegroundTargets_Options.ButtonRangeDisplay           = {}    end
	if type(BattlegroundTargets_Options.ButtonSortBy)                 ~= "table"   then BattlegroundTargets_Options.ButtonSortBy                 = {}    end
	if type(BattlegroundTargets_Options.ButtonSortDetail)             ~= "table"   then BattlegroundTargets_Options.ButtonSortDetail             = {}    end
	if type(BattlegroundTargets_Options.ButtonFontNameSize)           ~= "table"   then BattlegroundTargets_Options.ButtonFontNameSize           = {}    end
	if type(BattlegroundTargets_Options.ButtonFontNameStyle)          ~= "table"   then BattlegroundTargets_Options.ButtonFontNameStyle          = {}    end
	if type(BattlegroundTargets_Options.ButtonFontNumberSize)         ~= "table"   then BattlegroundTargets_Options.ButtonFontNumberSize         = {}    end
	if type(BattlegroundTargets_Options.ButtonFontNumberStyle)        ~= "table"   then BattlegroundTargets_Options.ButtonFontNumberStyle        = {}    end
	if type(BattlegroundTargets_Options.ButtonScale)                  ~= "table"   then BattlegroundTargets_Options.ButtonScale                  = {}    end
	if type(BattlegroundTargets_Options.ButtonWidth)                  ~= "table"   then BattlegroundTargets_Options.ButtonWidth                  = {}    end
	if type(BattlegroundTargets_Options.ButtonHeight)                 ~= "table"   then BattlegroundTargets_Options.ButtonHeight                 = {}    end

	if type(BattlegroundTargets_Options.ButtonShowRole[10])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowRole[10]           = true  end
	if type(BattlegroundTargets_Options.ButtonShowSpec[10])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowSpec[10]           = false end
	if type(BattlegroundTargets_Options.ButtonClassIcon[10])          ~= "boolean" then BattlegroundTargets_Options.ButtonClassIcon[10]          = false end
	if type(BattlegroundTargets_Options.ButtonShowRealm[10])          ~= "boolean" then BattlegroundTargets_Options.ButtonShowRealm[10]          = true  end
	if type(BattlegroundTargets_Options.ButtonShowLeader[10])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowLeader[10]         = false end
	if type(BattlegroundTargets_Options.ButtonShowTarget[10])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowTarget[10]         = true  end
	if type(BattlegroundTargets_Options.ButtonTargetScale[10])        ~= "number"  then BattlegroundTargets_Options.ButtonTargetScale[10]        = 1.5   end
	if type(BattlegroundTargets_Options.ButtonTargetPosition[10])     ~= "number"  then BattlegroundTargets_Options.ButtonTargetPosition[10]     = 100   end
	if type(BattlegroundTargets_Options.ButtonShowAssist[10])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowAssist[10]         = false end
	if type(BattlegroundTargets_Options.ButtonAssistScale[10])        ~= "number"  then BattlegroundTargets_Options.ButtonAssistScale[10]        = 1.2   end
	if type(BattlegroundTargets_Options.ButtonAssistPosition[10])     ~= "number"  then BattlegroundTargets_Options.ButtonAssistPosition[10]     = 100   end
	if type(BattlegroundTargets_Options.ButtonShowFocus[10])          ~= "boolean" then BattlegroundTargets_Options.ButtonShowFocus[10]          = false end
	if type(BattlegroundTargets_Options.ButtonFocusScale[10])         ~= "number"  then BattlegroundTargets_Options.ButtonFocusScale[10]         = 1     end
	if type(BattlegroundTargets_Options.ButtonFocusPosition[10])      ~= "number"  then BattlegroundTargets_Options.ButtonFocusPosition[10]      = 70    end
	if type(BattlegroundTargets_Options.ButtonShowFlag[10])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowFlag[10]           = true  end
	if type(BattlegroundTargets_Options.ButtonFlagScale[10])          ~= "number"  then BattlegroundTargets_Options.ButtonFlagScale[10]          = 1.2   end
	if type(BattlegroundTargets_Options.ButtonFlagPosition[10])       ~= "number"  then BattlegroundTargets_Options.ButtonFlagPosition[10]       = 60    end
	if type(BattlegroundTargets_Options.ButtonShowTargetCount[10])    ~= "boolean" then BattlegroundTargets_Options.ButtonShowTargetCount[10]    = false end
	if type(BattlegroundTargets_Options.ButtonShowHealthBar[10])      ~= "boolean" then BattlegroundTargets_Options.ButtonShowHealthBar[10]      = false end
	if type(BattlegroundTargets_Options.ButtonShowHealthText[10])     ~= "boolean" then BattlegroundTargets_Options.ButtonShowHealthText[10]     = false end
	if type(BattlegroundTargets_Options.ButtonRangeCheck[10])         ~= "boolean" then BattlegroundTargets_Options.ButtonRangeCheck[10]         = false end
	if type(BattlegroundTargets_Options.ButtonTypeRangeCheck[10])     ~= "number"  then BattlegroundTargets_Options.ButtonTypeRangeCheck[10]     = 2     end
	if type(BattlegroundTargets_Options.ButtonRangeDisplay[10])       ~= "number"  then BattlegroundTargets_Options.ButtonRangeDisplay[10]       = 1     end
	if type(BattlegroundTargets_Options.ButtonSortBy[10])             ~= "number"  then BattlegroundTargets_Options.ButtonSortBy[10]             = 1     end
	if type(BattlegroundTargets_Options.ButtonSortDetail[10])         ~= "number"  then BattlegroundTargets_Options.ButtonSortDetail[10]         = 3     end
	if type(BattlegroundTargets_Options.ButtonFontNameSize[10])       ~= "number"  then BattlegroundTargets_Options.ButtonFontNameSize[10]       = 12    end
	if type(BattlegroundTargets_Options.ButtonFontNameStyle[10])      ~= "number"  then BattlegroundTargets_Options.ButtonFontNameStyle[10]      = defaultFont end
	if type(BattlegroundTargets_Options.ButtonFontNumberSize[10])     ~= "number"  then BattlegroundTargets_Options.ButtonFontNumberSize[10]     = 10    end
	if type(BattlegroundTargets_Options.ButtonFontNumberStyle[10])    ~= "number"  then BattlegroundTargets_Options.ButtonFontNumberStyle[10]    = 1     end
	if type(BattlegroundTargets_Options.ButtonScale[10])              ~= "number"  then BattlegroundTargets_Options.ButtonScale[10]              = 1     end
	if type(BattlegroundTargets_Options.ButtonWidth[10])              ~= "number"  then BattlegroundTargets_Options.ButtonWidth[10]              = 175   end
	if type(BattlegroundTargets_Options.ButtonHeight[10])             ~= "number"  then BattlegroundTargets_Options.ButtonHeight[10]             = 20    end

	if type(BattlegroundTargets_Options.ButtonShowRole[15])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowRole[15]           = true  end
	if type(BattlegroundTargets_Options.ButtonShowSpec[15])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowSpec[15]           = false end
	if type(BattlegroundTargets_Options.ButtonClassIcon[15])          ~= "boolean" then BattlegroundTargets_Options.ButtonClassIcon[15]          = false end
	if type(BattlegroundTargets_Options.ButtonShowRealm[15])          ~= "boolean" then BattlegroundTargets_Options.ButtonShowRealm[15]          = true  end
	if type(BattlegroundTargets_Options.ButtonShowLeader[15])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowLeader[15]         = false end
	if type(BattlegroundTargets_Options.ButtonShowTarget[15])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowTarget[15]         = true  end
	if type(BattlegroundTargets_Options.ButtonTargetScale[15])        ~= "number"  then BattlegroundTargets_Options.ButtonTargetScale[15]        = 1.5   end
	if type(BattlegroundTargets_Options.ButtonTargetPosition[15])     ~= "number"  then BattlegroundTargets_Options.ButtonTargetPosition[15]     = 100   end
	if type(BattlegroundTargets_Options.ButtonShowAssist[15])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowAssist[15]         = false end
	if type(BattlegroundTargets_Options.ButtonAssistScale[15])        ~= "number"  then BattlegroundTargets_Options.ButtonAssistScale[15]        = 1.2   end
	if type(BattlegroundTargets_Options.ButtonAssistPosition[15])     ~= "number"  then BattlegroundTargets_Options.ButtonAssistPosition[15]     = 100   end
	if type(BattlegroundTargets_Options.ButtonShowFocus[15])          ~= "boolean" then BattlegroundTargets_Options.ButtonShowFocus[15]          = false end
	if type(BattlegroundTargets_Options.ButtonFocusScale[15])         ~= "number"  then BattlegroundTargets_Options.ButtonFocusScale[15]         = 1     end
	if type(BattlegroundTargets_Options.ButtonFocusPosition[15])      ~= "number"  then BattlegroundTargets_Options.ButtonFocusPosition[15]      = 70    end
	if type(BattlegroundTargets_Options.ButtonShowFlag[15])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowFlag[15]           = true  end
	if type(BattlegroundTargets_Options.ButtonFlagScale[15])          ~= "number"  then BattlegroundTargets_Options.ButtonFlagScale[15]          = 1.2   end
	if type(BattlegroundTargets_Options.ButtonFlagPosition[15])       ~= "number"  then BattlegroundTargets_Options.ButtonFlagPosition[15]       = 60    end
	if type(BattlegroundTargets_Options.ButtonShowTargetCount[15])    ~= "boolean" then BattlegroundTargets_Options.ButtonShowTargetCount[15]    = false end
	if type(BattlegroundTargets_Options.ButtonShowHealthBar[15])      ~= "boolean" then BattlegroundTargets_Options.ButtonShowHealthBar[15]      = false end
	if type(BattlegroundTargets_Options.ButtonShowHealthText[15])     ~= "boolean" then BattlegroundTargets_Options.ButtonShowHealthText[15]     = false end
	if type(BattlegroundTargets_Options.ButtonRangeCheck[15])         ~= "boolean" then BattlegroundTargets_Options.ButtonRangeCheck[15]         = false end
	if type(BattlegroundTargets_Options.ButtonTypeRangeCheck[15])     ~= "number"  then BattlegroundTargets_Options.ButtonTypeRangeCheck[15]     = 2     end
	if type(BattlegroundTargets_Options.ButtonRangeDisplay[15])       ~= "number"  then BattlegroundTargets_Options.ButtonRangeDisplay[15]       = 1     end
	if type(BattlegroundTargets_Options.ButtonSortBy[15])             ~= "number"  then BattlegroundTargets_Options.ButtonSortBy[15]             = 1     end
	if type(BattlegroundTargets_Options.ButtonSortDetail[15])         ~= "number"  then BattlegroundTargets_Options.ButtonSortDetail[15]         = 3     end
	if type(BattlegroundTargets_Options.ButtonFontNameSize[15])       ~= "number"  then BattlegroundTargets_Options.ButtonFontNameSize[15]       = 12    end
	if type(BattlegroundTargets_Options.ButtonFontNameStyle[15])      ~= "number"  then BattlegroundTargets_Options.ButtonFontNameStyle[15]      = defaultFont end
	if type(BattlegroundTargets_Options.ButtonFontNumberSize[15])     ~= "number"  then BattlegroundTargets_Options.ButtonFontNumberSize[15]     = 10    end
	if type(BattlegroundTargets_Options.ButtonFontNumberStyle[15])    ~= "number"  then BattlegroundTargets_Options.ButtonFontNumberStyle[15]    = 1     end
	if type(BattlegroundTargets_Options.ButtonScale[15])              ~= "number"  then BattlegroundTargets_Options.ButtonScale[15]              = 1     end
	if type(BattlegroundTargets_Options.ButtonWidth[15])              ~= "number"  then BattlegroundTargets_Options.ButtonWidth[15]              = 175   end
	if type(BattlegroundTargets_Options.ButtonHeight[15])             ~= "number"  then BattlegroundTargets_Options.ButtonHeight[15]             = 20    end

	if type(BattlegroundTargets_Options.ButtonShowRole[40])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowRole[40]           = true  end
	if type(BattlegroundTargets_Options.ButtonShowSpec[40])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowSpec[40]           = false end
	if type(BattlegroundTargets_Options.ButtonClassIcon[40])          ~= "boolean" then BattlegroundTargets_Options.ButtonClassIcon[40]          = false end
	if type(BattlegroundTargets_Options.ButtonShowRealm[40])          ~= "boolean" then BattlegroundTargets_Options.ButtonShowRealm[40]          = false end
	if type(BattlegroundTargets_Options.ButtonShowLeader[40])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowLeader[40]         = false end
	if type(BattlegroundTargets_Options.ButtonShowTarget[40])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowTarget[40]         = true  end
	if type(BattlegroundTargets_Options.ButtonTargetScale[40])        ~= "number"  then BattlegroundTargets_Options.ButtonTargetScale[40]        = 1     end
	if type(BattlegroundTargets_Options.ButtonTargetPosition[40])     ~= "number"  then BattlegroundTargets_Options.ButtonTargetPosition[40]     = 85    end
	if type(BattlegroundTargets_Options.ButtonShowAssist[40])         ~= "boolean" then BattlegroundTargets_Options.ButtonShowAssist[40]         = false end
	if type(BattlegroundTargets_Options.ButtonAssistScale[40])        ~= "number"  then BattlegroundTargets_Options.ButtonAssistScale[40]        = 1     end
	if type(BattlegroundTargets_Options.ButtonAssistPosition[40])     ~= "number"  then BattlegroundTargets_Options.ButtonAssistPosition[40]     = 70    end
	if type(BattlegroundTargets_Options.ButtonShowFocus[40])          ~= "boolean" then BattlegroundTargets_Options.ButtonShowFocus[40]          = false end
	if type(BattlegroundTargets_Options.ButtonFocusScale[40])         ~= "number"  then BattlegroundTargets_Options.ButtonFocusScale[40]         = 1     end
	if type(BattlegroundTargets_Options.ButtonFocusPosition[40])      ~= "number"  then BattlegroundTargets_Options.ButtonFocusPosition[40]      = 55    end
	if type(BattlegroundTargets_Options.ButtonShowFlag[40])           ~= "boolean" then BattlegroundTargets_Options.ButtonShowFlag[40]           = false end
	if type(BattlegroundTargets_Options.ButtonFlagScale[40])          ~= "number"  then BattlegroundTargets_Options.ButtonFlagScale[40]          = 1     end
	if type(BattlegroundTargets_Options.ButtonFlagPosition[40])       ~= "number"  then BattlegroundTargets_Options.ButtonFlagPosition[40]       = 100   end
	if type(BattlegroundTargets_Options.ButtonShowTargetCount[40])    ~= "boolean" then BattlegroundTargets_Options.ButtonShowTargetCount[40]    = false end
	if type(BattlegroundTargets_Options.ButtonShowHealthBar[40])      ~= "boolean" then BattlegroundTargets_Options.ButtonShowHealthBar[40]      = false end
	if type(BattlegroundTargets_Options.ButtonShowHealthText[40])     ~= "boolean" then BattlegroundTargets_Options.ButtonShowHealthText[40]     = false end
	if type(BattlegroundTargets_Options.ButtonRangeCheck[40])         ~= "boolean" then BattlegroundTargets_Options.ButtonRangeCheck[40]         = false end
	if type(BattlegroundTargets_Options.ButtonTypeRangeCheck[40])     ~= "number"  then BattlegroundTargets_Options.ButtonTypeRangeCheck[40]     = 2     end
	if type(BattlegroundTargets_Options.ButtonRangeDisplay[40])       ~= "number"  then BattlegroundTargets_Options.ButtonRangeDisplay[40]       = 7     end
	if type(BattlegroundTargets_Options.ButtonSortBy[40])             ~= "number"  then BattlegroundTargets_Options.ButtonSortBy[40]             = 1     end
	if type(BattlegroundTargets_Options.ButtonSortDetail[40])         ~= "number"  then BattlegroundTargets_Options.ButtonSortDetail[40]         = 3     end
	if type(BattlegroundTargets_Options.ButtonFontNameSize[40])       ~= "number"  then BattlegroundTargets_Options.ButtonFontNameSize[40]       = 10    end
	if type(BattlegroundTargets_Options.ButtonFontNameStyle[40])      ~= "number"  then BattlegroundTargets_Options.ButtonFontNameStyle[40]      = defaultFont end
	if type(BattlegroundTargets_Options.ButtonFontNumberSize[40])     ~= "number"  then BattlegroundTargets_Options.ButtonFontNumberSize[40]     = 10    end
	if type(BattlegroundTargets_Options.ButtonFontNumberStyle[40])    ~= "number"  then BattlegroundTargets_Options.ButtonFontNumberStyle[40]    = 1     end
	if type(BattlegroundTargets_Options.ButtonScale[40])              ~= "number"  then BattlegroundTargets_Options.ButtonScale[40]              = 1     end
	if type(BattlegroundTargets_Options.ButtonWidth[40])              ~= "number"  then BattlegroundTargets_Options.ButtonWidth[40]              = 100   end
	if type(BattlegroundTargets_Options.ButtonHeight[40])             ~= "number"  then BattlegroundTargets_Options.ButtonHeight[40]             = 16    end

	local BTO = BattlegroundTargets_Options

	OPT.ButtonShowRole           = {[10] = BTO.ButtonShowRole[10]          , [15] = BTO.ButtonShowRole[15]          , [40] = BTO.ButtonShowRole[40]          }
	OPT.ButtonShowSpec           = {[10] = BTO.ButtonShowSpec[10]          , [15] = BTO.ButtonShowSpec[15]          , [40] = BTO.ButtonShowSpec[40]          }
	OPT.ButtonClassIcon          = {[10] = BTO.ButtonClassIcon[10]         , [15] = BTO.ButtonClassIcon[15]         , [40] = BTO.ButtonClassIcon[40]         }
	OPT.ButtonShowRealm          = {[10] = BTO.ButtonShowRealm[10]         , [15] = BTO.ButtonShowRealm[15]         , [40] = BTO.ButtonShowRealm[40]         }
	OPT.ButtonShowLeader         = {[10] = BTO.ButtonShowLeader[10]        , [15] = BTO.ButtonShowLeader[15]        , [40] = BTO.ButtonShowLeader[40]        }
	OPT.ButtonShowTarget         = {[10] = BTO.ButtonShowTarget[10]        , [15] = BTO.ButtonShowTarget[15]        , [40] = BTO.ButtonShowTarget[40]        }
	OPT.ButtonTargetScale        = {[10] = BTO.ButtonTargetScale[10]       , [15] = BTO.ButtonTargetScale[15]       , [40] = BTO.ButtonTargetScale[40]       }
	OPT.ButtonTargetPosition     = {[10] = BTO.ButtonTargetPosition[10]    , [15] = BTO.ButtonTargetPosition[15]    , [40] = BTO.ButtonTargetPosition[40]    }
	OPT.ButtonShowAssist         = {[10] = BTO.ButtonShowAssist[10]        , [15] = BTO.ButtonShowAssist[15]        , [40] = BTO.ButtonShowAssist[40]        }
	OPT.ButtonAssistScale        = {[10] = BTO.ButtonAssistScale[10]       , [15] = BTO.ButtonAssistScale[15]       , [40] = BTO.ButtonAssistScale[40]       }
	OPT.ButtonAssistPosition     = {[10] = BTO.ButtonAssistPosition[10]    , [15] = BTO.ButtonAssistPosition[15]    , [40] = BTO.ButtonAssistPosition[40]    }
	OPT.ButtonShowFocus          = {[10] = BTO.ButtonShowFocus[10]         , [15] = BTO.ButtonShowFocus[15]         , [40] = BTO.ButtonShowFocus[40]         }
	OPT.ButtonFocusScale         = {[10] = BTO.ButtonFocusScale[10]        , [15] = BTO.ButtonFocusScale[15]        , [40] = BTO.ButtonFocusScale[40]        }
	OPT.ButtonFocusPosition      = {[10] = BTO.ButtonFocusPosition[10]     , [15] = BTO.ButtonFocusPosition[15]     , [40] = BTO.ButtonFocusPosition[40]     }
	OPT.ButtonShowFlag           = {[10] = BTO.ButtonShowFlag[10]          , [15] = BTO.ButtonShowFlag[15]          , [40] = BTO.ButtonShowFlag[40]          }
	OPT.ButtonFlagScale          = {[10] = BTO.ButtonFlagScale[10]         , [15] = BTO.ButtonFlagScale[15]         , [40] = BTO.ButtonFlagScale[40]         }
	OPT.ButtonFlagPosition       = {[10] = BTO.ButtonFlagPosition[10]      , [15] = BTO.ButtonFlagPosition[15]      , [40] = BTO.ButtonFlagPosition[40]      }
	OPT.ButtonShowTargetCount    = {[10] = BTO.ButtonShowTargetCount[10]   , [15] = BTO.ButtonShowTargetCount[15]   , [40] = BTO.ButtonShowTargetCount[40]   }
	OPT.ButtonShowHealthBar      = {[10] = BTO.ButtonShowHealthBar[10]     , [15] = BTO.ButtonShowHealthBar[15]     , [40] = BTO.ButtonShowHealthBar[40]     }
	OPT.ButtonShowHealthText     = {[10] = BTO.ButtonShowHealthText[10]    , [15] = BTO.ButtonShowHealthText[15]    , [40] = BTO.ButtonShowHealthText[40]    }
	OPT.ButtonRangeCheck         = {[10] = BTO.ButtonRangeCheck[10]        , [15] = BTO.ButtonRangeCheck[15]        , [40] = BTO.ButtonRangeCheck[40]        }
	OPT.ButtonTypeRangeCheck     = {[10] = BTO.ButtonTypeRangeCheck[10]    , [15] = BTO.ButtonTypeRangeCheck[15]    , [40] = BTO.ButtonTypeRangeCheck[40]    }
	OPT.ButtonRangeDisplay       = {[10] = BTO.ButtonRangeDisplay[10]      , [15] = BTO.ButtonRangeDisplay[15]      , [40] = BTO.ButtonRangeDisplay[40]      }
	OPT.ButtonSortBy             = {[10] = BTO.ButtonSortBy[10]            , [15] = BTO.ButtonSortBy[15]            , [40] = BTO.ButtonSortBy[40]            }
	OPT.ButtonSortDetail         = {[10] = BTO.ButtonSortDetail[10]        , [15] = BTO.ButtonSortDetail[15]        , [40] = BTO.ButtonSortDetail[40]        }
	OPT.ButtonFontNameSize       = {[10] = BTO.ButtonFontNameSize[10]      , [15] = BTO.ButtonFontNameSize[15]      , [40] = BTO.ButtonFontNameSize[40]      }
	OPT.ButtonFontNameStyle      = {[10] = BTO.ButtonFontNameStyle[10]     , [15] = BTO.ButtonFontNameStyle[15]     , [40] = BTO.ButtonFontNameStyle[40]     }
	OPT.ButtonFontNumberSize     = {[10] = BTO.ButtonFontNumberSize[10]    , [15] = BTO.ButtonFontNumberSize[15]    , [40] = BTO.ButtonFontNumberSize[40]    }
	OPT.ButtonFontNumberStyle    = {[10] = BTO.ButtonFontNumberStyle[10]   , [15] = BTO.ButtonFontNumberStyle[15]   , [40] = BTO.ButtonFontNumberStyle[40]   }
	OPT.ButtonScale              = {[10] = BTO.ButtonScale[10]             , [15] = BTO.ButtonScale[15]             , [40] = BTO.ButtonScale[40]             }
	OPT.ButtonWidth              = {[10] = BTO.ButtonWidth[10]             , [15] = BTO.ButtonWidth[15]             , [40] = BTO.ButtonWidth[40]             }
	OPT.ButtonHeight             = {[10] = BTO.ButtonHeight[10]            , [15] = BTO.ButtonHeight[15]            , [40] = BTO.ButtonHeight[40]            }
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:LDBcheck()
	if LibStub and LibStub:GetLibrary("CallbackHandler-1.0", true) and LibStub:GetLibrary("LibDataBroker-1.1", true) then
		LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("BattlegroundTargets", {
			type = "launcher",
			icon = AddonIcon,
			OnClick = function(self, button)
				BattlegroundTargets:Frame_Toggle(GVAR.OptionsFrame)
			end,
		})
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CreateInterfaceOptions()
	GVAR.InterfaceOptions = CreateFrame("Frame", "BattlegroundTargets_InterfaceOptions")
	GVAR.InterfaceOptions.name = "BattlegroundTargets"

	GVAR.InterfaceOptions.Title = GVAR.InterfaceOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	GVAR.InterfaceOptions.Title:SetText("BattlegroundTargets")
	GVAR.InterfaceOptions.Title:SetJustifyH("LEFT")
	GVAR.InterfaceOptions.Title:SetJustifyV("TOP")
	GVAR.InterfaceOptions.Title:SetPoint("TOPLEFT", 16, -16)

	GVAR.InterfaceOptions.CONFIG = CreateFrame("Button", nil, GVAR.InterfaceOptions)
	TEMPLATE.TextButton(GVAR.InterfaceOptions.CONFIG, L["Open Configuration"], 1)
	GVAR.InterfaceOptions.CONFIG:SetWidth(180)
	GVAR.InterfaceOptions.CONFIG:SetHeight(22)
	GVAR.InterfaceOptions.CONFIG:SetPoint("TOPLEFT", GVAR.InterfaceOptions.Title, "BOTTOMLEFT", 0, -10)
	GVAR.InterfaceOptions.CONFIG:SetScript("OnClick", function()
		InterfaceOptionsFrame_Show()
		HideUIPanel(GameMenuFrame)
		BattlegroundTargets:Frame_Toggle(GVAR.OptionsFrame)
	end)

	GVAR.InterfaceOptions.SlashCommandText = GVAR.InterfaceOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.InterfaceOptions.SlashCommandText:SetText("/bgt - /bgtargets - /battlegroundtargets")
	GVAR.InterfaceOptions.SlashCommandText:SetNonSpaceWrap(true)
	GVAR.InterfaceOptions.SlashCommandText:SetPoint("LEFT", GVAR.InterfaceOptions.CONFIG, "RIGHT", 10, 0)
	GVAR.InterfaceOptions.SlashCommandText:SetTextColor(1, 1, 0.49, 1)

	InterfaceOptions_AddCategory(GVAR.InterfaceOptions)
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CreateFrames()
	GVAR.MainFrame = CreateFrame("Frame", "BattlegroundTargets_MainFrame", UIParent)
	GVAR.MainFrame:EnableMouse(true)
	GVAR.MainFrame:SetMovable(true)
	GVAR.MainFrame:SetResizable(true)
	GVAR.MainFrame:SetToplevel(true)
	GVAR.MainFrame:SetClampedToScreen(true)
	GVAR.MainFrame:SetWidth(0.001)
	GVAR.MainFrame:SetHeight(0.001)
	GVAR.MainFrame:Hide()



	local function OnEnter(self)
		self.HighlightT:SetTexture(1, 1, 0.49, 1)
		self.HighlightR:SetTexture(1, 1, 0.49, 1)
		self.HighlightB:SetTexture(1, 1, 0.49, 1)
		self.HighlightL:SetTexture(1, 1, 0.49, 1)
	end
	local function OnLeave(self)
		if isTarget == self.buttonNum then
			self.HighlightT:SetTexture(0.5, 0.5, 0.5, 1)
			self.HighlightR:SetTexture(0.5, 0.5, 0.5, 1)
			self.HighlightB:SetTexture(0.5, 0.5, 0.5, 1)
			self.HighlightL:SetTexture(0.5, 0.5, 0.5, 1)
		else
			self.HighlightT:SetTexture(0, 0, 0, 1)
			self.HighlightR:SetTexture(0, 0, 0, 1)
			self.HighlightB:SetTexture(0, 0, 0, 1)
			self.HighlightL:SetTexture(0, 0, 0, 1)
		end
	end

	GVAR.TargetButton = {}
	for i = 1, 40 do
		GVAR.TargetButton[i] = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate")

		local GVAR_TargetButton = GVAR.TargetButton[i]

		if i == 1 then
			GVAR_TargetButton:SetPoint("TOPLEFT", GVAR.MainFrame, "BOTTOMLEFT", 0, 0)
		else
			GVAR_TargetButton:SetPoint("TOPLEFT", GVAR.TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
		end
		GVAR_TargetButton:Hide()

		GVAR_TargetButton.colR  = 0
		GVAR_TargetButton.colG  = 0
		GVAR_TargetButton.colB  = 0
		GVAR_TargetButton.colR5 = 0
		GVAR_TargetButton.colG5 = 0
		GVAR_TargetButton.colB5 = 0

		GVAR_TargetButton.HighlightT = GVAR_TargetButton:CreateTexture(nil, "BACKGROUND")
		GVAR_TargetButton.HighlightT:SetHeight(1)
		GVAR_TargetButton.HighlightT:SetPoint("TOP", 0, 0)
		GVAR_TargetButton.HighlightT:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightR = GVAR_TargetButton:CreateTexture(nil, "BACKGROUND")
		GVAR_TargetButton.HighlightR:SetWidth(1)
		GVAR_TargetButton.HighlightR:SetPoint("RIGHT", 0, 0)
		GVAR_TargetButton.HighlightR:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightB = GVAR_TargetButton:CreateTexture(nil, "BACKGROUND")
		GVAR_TargetButton.HighlightB:SetHeight(1)
		GVAR_TargetButton.HighlightB:SetPoint("BOTTOM", 0, 0)
		GVAR_TargetButton.HighlightB:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightL = GVAR_TargetButton:CreateTexture(nil, "BACKGROUND")
		GVAR_TargetButton.HighlightL:SetWidth(1)
		GVAR_TargetButton.HighlightL:SetPoint("LEFT", 0, 0)
		GVAR_TargetButton.HighlightL:SetTexture(0, 0, 0, 1)

		GVAR_TargetButton.Background = GVAR_TargetButton:CreateTexture(nil, "BACKGROUND")
		GVAR_TargetButton.Background:SetPoint("TOPLEFT", 1, -1)
		GVAR_TargetButton.Background:SetTexture(0, 0, 0, 1)

		GVAR_TargetButton.RangeTexture = GVAR_TargetButton:CreateTexture(nil, "BORDER")
		GVAR_TargetButton.RangeTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
		GVAR_TargetButton.RangeTexture:SetTexture(0, 0, 0, 0)

		GVAR_TargetButton.RoleTexture = GVAR_TargetButton:CreateTexture(nil, "BORDER")
		GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
		GVAR_TargetButton.RoleTexture:SetTexture(Textures.Path)
		GVAR_TargetButton.RoleTexture:SetTexCoord(0, 0, 0, 0)

		GVAR_TargetButton.SpecTexture = GVAR_TargetButton:CreateTexture(nil, "BORDER")
		GVAR_TargetButton.SpecTexture:SetPoint("LEFT", GVAR_TargetButton.RoleTexture, "RIGHT", 0, 0)
		GVAR_TargetButton.SpecTexture:SetTexCoord(0.07812501, 0.92187499, 0.07812501, 0.92187499)--(5/64, 59/64, 5/64, 59/64)
		GVAR_TargetButton.SpecTexture:SetTexture(nil)

		GVAR_TargetButton.ClassTexture = GVAR_TargetButton:CreateTexture(nil, "BORDER")
		GVAR_TargetButton.ClassTexture:SetPoint("LEFT", GVAR_TargetButton.SpecTexture, "RIGHT", 0, 0)
		GVAR_TargetButton.ClassTexture:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
		GVAR_TargetButton.ClassTexture:SetTexCoord(0, 0, 0, 0)

		GVAR_TargetButton.LeaderTexture = GVAR_TargetButton:CreateTexture(nil, "ARTWORK")
		GVAR_TargetButton.LeaderTexture:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
		GVAR_TargetButton.LeaderTexture:SetAlpha(0)

		GVAR_TargetButton.ClassColorBackground = GVAR_TargetButton:CreateTexture(nil, "BORDER")
		GVAR_TargetButton.ClassColorBackground:SetTexture(0, 0, 0, 0)

		GVAR_TargetButton.HealthBar = GVAR_TargetButton:CreateTexture(nil, "ARTWORK")
		GVAR_TargetButton.HealthBar:SetPoint("LEFT", GVAR_TargetButton.ClassColorBackground, "LEFT", 0, 0)
		GVAR_TargetButton.HealthBar:SetTexture(0, 0, 0, 0)

		GVAR_TargetButton.HealthTextButton = CreateFrame("Button", nil, GVAR_TargetButton) -- xBUT
		GVAR_TargetButton.HealthText = GVAR_TargetButton.HealthTextButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		GVAR_TargetButton.HealthText:SetWidth(100)
		GVAR_TargetButton.HealthText:SetPoint("RIGHT", GVAR_TargetButton.ClassColorBackground, "RIGHT", 0, 0)
		GVAR_TargetButton.HealthText:SetJustifyH("RIGHT")
		GVAR_TargetButton.HealthText:SetShadowOffset(0, 0)
		GVAR_TargetButton.HealthText:SetShadowColor(0, 0, 0, 0)
		GVAR_TargetButton.HealthText:SetTextColor(1, 1, 1, 1)
		GVAR_TargetButton.HealthText:SetAlpha(0.6)

		GVAR_TargetButton.Name = GVAR_TargetButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		GVAR_TargetButton.Name:SetJustifyH("LEFT")
		GVAR_TargetButton.Name:SetShadowOffset(0, 0)
		GVAR_TargetButton.Name:SetShadowColor(0, 0, 0, 0)
		GVAR_TargetButton.Name:SetTextColor(0, 0, 0, 1)

		GVAR_TargetButton.TargetCountBackground = GVAR_TargetButton:CreateTexture(nil, "ARTWORK")
		GVAR_TargetButton.TargetCountBackground:SetWidth(20)
		GVAR_TargetButton.TargetCountBackground:SetPoint("RIGHT", GVAR_TargetButton, "RIGHT", -1, 0)
		GVAR_TargetButton.TargetCountBackground:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.TargetCountBackground:SetAlpha(1)

		GVAR_TargetButton.TargetCount = GVAR_TargetButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		GVAR_TargetButton.TargetCount:SetWidth(20)
		GVAR_TargetButton.TargetCount:SetPoint("CENTER", GVAR_TargetButton.TargetCountBackground, "CENTER", 0, 0)
		GVAR_TargetButton.TargetCount:SetJustifyH("CENTER")
		GVAR_TargetButton.TargetCount:SetShadowOffset(0, 0)
		GVAR_TargetButton.TargetCount:SetShadowColor(0, 0, 0, 0)
		GVAR_TargetButton.TargetCount:SetTextColor(1, 1, 1, 1)

		GVAR_TargetButton.TargetTextureButton = CreateFrame("Button", nil, GVAR_TargetButton) -- xBUT
		GVAR_TargetButton.TargetTexture = GVAR_TargetButton.TargetTextureButton:CreateTexture(nil, "OVERLAY")
		GVAR_TargetButton.TargetTexture:SetTexture("Interface\\Minimap\\Tracking\\Target")
		GVAR_TargetButton.TargetTexture:SetAlpha(0)

		GVAR_TargetButton.FocusTextureButton = CreateFrame("Button", nil, GVAR_TargetButton) -- xBUT
		GVAR_TargetButton.FocusTexture = GVAR_TargetButton.FocusTextureButton:CreateTexture(nil, "OVERLAY")
		GVAR_TargetButton.FocusTexture:SetTexture("Interface\\Minimap\\Tracking\\Focus")
		GVAR_TargetButton.FocusTexture:SetAlpha(0)

		GVAR_TargetButton.FlagTextureButton = CreateFrame("Button", nil, GVAR_TargetButton) -- xBUT
		GVAR_TargetButton.FlagTexture = GVAR_TargetButton.FlagTextureButton:CreateTexture(nil, "OVERLAY")
		GVAR_TargetButton.FlagTexture:SetTexture(Textures.flagTexture)
		GVAR_TargetButton.FlagTexture:SetAlpha(0)

		GVAR_TargetButton.FlagDebuffButton = CreateFrame("Button", nil, GVAR_TargetButton) -- xBUT
		GVAR_TargetButton.FlagDebuff = GVAR_TargetButton.FlagDebuffButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		GVAR_TargetButton.FlagDebuff:SetWidth(50)
		GVAR_TargetButton.FlagDebuff:SetPoint("CENTER", GVAR_TargetButton.FlagTexture, "CENTER", 0, 0)
		GVAR_TargetButton.FlagDebuff:SetJustifyH("CENTER")
		GVAR_TargetButton.FlagDebuff:SetJustifyV("MIDDLE")
		GVAR_TargetButton.FlagDebuff:SetShadowOffset(0, 0)
		GVAR_TargetButton.FlagDebuff:SetShadowColor(0, 0, 0, 0)
		GVAR_TargetButton.FlagDebuff:SetTextColor(1, 1, 1, 1)
		GVAR_TargetButton.OrbDebuff = GVAR_TargetButton.FlagDebuffButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		GVAR_TargetButton.OrbDebuff:SetWidth(50)
		GVAR_TargetButton.OrbDebuff:SetPoint("TOP", GVAR_TargetButton, "TOP", 0, 0)
		GVAR_TargetButton.OrbDebuff:SetPoint("LEFT", GVAR_TargetButton.FlagDebuff, "LEFT", 0, 0)
		GVAR_TargetButton.OrbDebuff:SetJustifyH("CENTER")
		GVAR_TargetButton.OrbDebuff:SetJustifyV("TOP")
		GVAR_TargetButton.OrbDebuff:SetShadowOffset(0, 0)
		GVAR_TargetButton.OrbDebuff:SetShadowColor(0, 0, 0, 0)
		GVAR_TargetButton.OrbDebuff:SetTextColor(1, 1, 1, 1)
		GVAR_TargetButton.OrbCornerTL = GVAR_TargetButton.FlagDebuffButton:CreateTexture(nil, "OVERLAY")
		GVAR_TargetButton.OrbCornerTL:SetPoint("LEFT", GVAR_TargetButton.FlagTexture, "LEFT", 0, 0)
		GVAR_TargetButton.OrbCornerTL:SetPoint("TOP", GVAR_TargetButton, "TOP", 0, -2)
		GVAR_TargetButton.OrbCornerTL:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.OrbCornerTR = GVAR_TargetButton.FlagDebuffButton:CreateTexture(nil, "OVERLAY")
		GVAR_TargetButton.OrbCornerTR:SetPoint("RIGHT", GVAR_TargetButton.FlagTexture, "RIGHT", 0, 0)
		GVAR_TargetButton.OrbCornerTR:SetPoint("TOP", GVAR_TargetButton, "TOP", 0, -2)
		GVAR_TargetButton.OrbCornerTR:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.OrbCornerBL = GVAR_TargetButton.FlagDebuffButton:CreateTexture(nil, "OVERLAY")
		GVAR_TargetButton.OrbCornerBL:SetPoint("LEFT", GVAR_TargetButton.FlagTexture, "LEFT", 0, 0)
		GVAR_TargetButton.OrbCornerBL:SetPoint("BOTTOM", GVAR_TargetButton, "BOTTOM", 0, 2)
		GVAR_TargetButton.OrbCornerBL:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.OrbCornerBR = GVAR_TargetButton.FlagDebuffButton:CreateTexture(nil, "OVERLAY")
		GVAR_TargetButton.OrbCornerBR:SetPoint("RIGHT", GVAR_TargetButton.FlagTexture, "RIGHT", 0, 0)
		GVAR_TargetButton.OrbCornerBR:SetPoint("BOTTOM", GVAR_TargetButton, "BOTTOM", 0, 2)
		GVAR_TargetButton.OrbCornerBR:SetTexture(0, 0, 0, 1)

		GVAR_TargetButton.AssistTextureButton = CreateFrame("Button", nil, GVAR_TargetButton) -- xBUT
		GVAR_TargetButton.AssistTexture = GVAR_TargetButton.AssistTextureButton:CreateTexture(nil, "OVERLAY")
		GVAR_TargetButton.AssistTexture:SetTexCoord(0.07812501, 0.92187499, 0.07812501, 0.92187499)--(5/64, 59/64, 5/64, 59/64)
		GVAR_TargetButton.AssistTexture:SetTexture("Interface\\Icons\\Ability_Hunter_SniperShot")
		GVAR_TargetButton.AssistTexture:SetAlpha(0)

		GVAR_TargetButton:RegisterForClicks("AnyUp")
		GVAR_TargetButton:SetAttribute("type1", "macro")
		GVAR_TargetButton:SetAttribute("type2", "macro")
		GVAR_TargetButton:SetAttribute("macrotext1", "")
		GVAR_TargetButton:SetAttribute("macrotext2", "")
		GVAR_TargetButton:SetScript("OnEnter", OnEnter)
		GVAR_TargetButton:SetScript("OnLeave", OnLeave)
	end



	GVAR.ScoreUpdateTexture = GVAR.TargetButton[1]:CreateTexture(nil, "OVERLAY")
	GVAR.ScoreUpdateTexture:SetSize(30.45, 13.92) -- (26.25*1.16, 12*1.16)
	GVAR.ScoreUpdateTexture:SetPoint("BOTTOMLEFT", GVAR.TargetButton[1], "TOPLEFT", 1, 1)
	GVAR.ScoreUpdateTexture:SetTexture(Textures.Path)
	GVAR.ScoreUpdateTexture:SetTexCoord(unpack(Textures.UpdateWarning))

	GVAR.IsGhostTexture = GVAR.TargetButton[1]:CreateTexture(nil, "OVERLAY")
	GVAR.IsGhostTexture:SetSize(24, 24)
	GVAR.IsGhostTexture:SetPoint("LEFT", GVAR.ScoreUpdateTexture, "RIGHT", 0, 0)
	GVAR.IsGhostTexture:SetTexture("Interface\\WorldStateFrame\\SkullBones")
	GVAR.IsGhostTexture:SetTexCoord(0, 0.5, 0, 0.5)
	GVAR.IsGhostTexture:Hide()



	GVAR.MonoblockAnchor = CreateFrame("Frame", nil, GVAR.TargetButton[1]) -- SUMPOSi
	GVAR.MonoblockAnchor:SetPoint("TOPLEFT", GVAR.TargetButton[1], "TOPLEFT", 0, 0)



	GVAR.Summary = CreateFrame("Frame", nil, GVAR.TargetButton[1]) -- SUMMARY
	GVAR.Summary:SetToplevel(true)
	GVAR.Summary:SetSize(140, 60)

	GVAR.Summary.Healer = GVAR.Summary:CreateTexture(nil, "ARTWORK")
	GVAR.Summary.Healer:SetSize(20, 20)
	GVAR.Summary.Healer:SetPoint("TOPLEFT", GVAR.Summary, "TOPLEFT", 60, 0)
	GVAR.Summary.Healer:SetTexture(Textures.Path)
	GVAR.Summary.Healer:SetTexCoord(unpack(Textures.RoleIcon[1]))
	GVAR.Summary.Tank = GVAR.Summary:CreateTexture(nil, "ARTWORK")
	GVAR.Summary.Tank:SetSize(20, 20)
	GVAR.Summary.Tank:SetPoint("TOP", GVAR.Summary.Healer, "BOTTOM", 0, 0)
	GVAR.Summary.Tank:SetTexture(Textures.Path)
	GVAR.Summary.Tank:SetTexCoord(unpack(Textures.RoleIcon[2]))
	GVAR.Summary.Damage = GVAR.Summary:CreateTexture(nil, "ARTWORK")
	GVAR.Summary.Damage:SetSize(20, 20)
	GVAR.Summary.Damage:SetPoint("TOP", GVAR.Summary.Tank, "BOTTOM", 0, 0)
	GVAR.Summary.Damage:SetTexture(Textures.Path)
	GVAR.Summary.Damage:SetTexCoord(unpack(Textures.RoleIcon[3]))

	local function FontTemplate(button)
		button:SetSize(60, 20)
		button:SetJustifyH("CENTER")
		button:SetFont(fontPath, 20, "OUTLINE")
		button:SetShadowOffset(0, 0)
		button:SetShadowColor(0, 0, 0, 0)
		button:SetTextColor(1, 1, 1, 1)
	end

	             GVAR.Summary.HealerFriend = GVAR.Summary:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	             GVAR.Summary.HealerFriend:SetPoint("RIGHT", GVAR.Summary.Healer, "LEFT", 15, 0)
	FontTemplate(GVAR.Summary.HealerFriend)
	             GVAR.Summary.HealerEnemy = GVAR.Summary:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	             GVAR.Summary.HealerEnemy:SetPoint("LEFT", GVAR.Summary.Healer, "RIGHT", -15, 0)
	FontTemplate(GVAR.Summary.HealerEnemy)
	             GVAR.Summary.TankFriend = GVAR.Summary:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	             GVAR.Summary.TankFriend:SetPoint("RIGHT", GVAR.Summary.Tank, "LEFT", 15, 0)
	FontTemplate(GVAR.Summary.TankFriend)
	             GVAR.Summary.TankEnemy = GVAR.Summary:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	             GVAR.Summary.TankEnemy:SetPoint("LEFT", GVAR.Summary.Tank, "RIGHT", -15, 0)
	FontTemplate(GVAR.Summary.TankEnemy)
	             GVAR.Summary.DamageFriend = GVAR.Summary:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	             GVAR.Summary.DamageFriend:SetPoint("RIGHT", GVAR.Summary.Damage, "LEFT", 15, 0)
	FontTemplate(GVAR.Summary.DamageFriend)
	             GVAR.Summary.DamageEnemy = GVAR.Summary:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	             GVAR.Summary.DamageEnemy:SetPoint("LEFT", GVAR.Summary.Damage, "RIGHT", -15, 0)
	FontTemplate(GVAR.Summary.DamageEnemy)

	GVAR.Summary.Logo1 = GVAR.Summary:CreateTexture(nil, "BACKGROUND")
	GVAR.Summary.Logo1:SetSize(60, 60)
	GVAR.Summary.Logo1:SetPoint("RIGHT", GVAR.Summary.Tank, "LEFT", 0, 0)
	GVAR.Summary.Logo2 = GVAR.Summary:CreateTexture(nil, "BACKGROUND")
	GVAR.Summary.Logo2:SetSize(60, 60)
	GVAR.Summary.Logo2:SetPoint("LEFT", GVAR.Summary.Tank, "RIGHT", 0, 0)

	if playerFactionDEF == 0 then -- summary_flag_texture
		GVAR.Summary.Logo1:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")
		GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")
	elseif playerFactionDEF == 1 then
		GVAR.Summary.Logo1:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")
		GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")
	else
		GVAR.Summary.Logo1:SetTexture("Interface\\Timer\\Panda-Logo")
		GVAR.Summary.Logo2:SetTexture("Interface\\Timer\\Panda-Logo")
	end



	-- main frame mover
	local function onEnterFunc()
		if inCombat or InCombatLockdown() then return end
		GVAR.MainFrameMoverTTxt:SetTextColor(1, 1, 1, 1)
		GVAR.MainFrameMoverBTxt:SetTextColor(1, 1, 1, 1)
	end
	local function onLeaveFunc()
		GVAR.MainFrameMoverTTxt:SetTextColor(0.3, 0.3, 0.3, 1)
		GVAR.MainFrameMoverBTxt:SetTextColor(0.3, 0.3, 0.3, 1)
	end
	local function onMouseDownFunc()
		if inCombat or InCombatLockdown() then return end
		GVAR.MainFrame.isMoving = true
		GVAR.MainFrame:StartMoving()
	end
	local function onMouseUpFunc()
		if not GVAR.MainFrame.isMoving then return end
		GVAR.MainFrame.isMoving = nil
		GVAR.MainFrame:StopMovingOrSizing()
		if inCombat or InCombatLockdown() then
			rePosMain = true
			return
		end
		rePosMain = nil
		BattlegroundTargets:Frame_SavePosition("BattlegroundTargets_MainFrame")
	end

	GVAR.MainFrameMoverFrame = CreateFrame("Frame", nil, GVAR.MainFrame)
	GVAR.MainFrameMoverFrame:SetPoint("CENTER", GVAR.MonoblockAnchor, "CENTER", 0, 0)
	GVAR.MainFrameMoverT = CreateFrame("Button", nil, GVAR.MainFrameMoverFrame)
	TEMPLATE.BorderTRBL(GVAR.MainFrameMoverT)
	GVAR.MainFrameMoverT:SetWidth(200)
	GVAR.MainFrameMoverT:SetHeight(25)
	GVAR.MainFrameMoverT:SetPoint("BOTTOM", GVAR.MonoblockAnchor, "TOP", 0, 75)
	GVAR.MainFrameMoverT:SetScript("OnEnter", onEnterFunc)
	GVAR.MainFrameMoverT:SetScript("OnLeave", onLeaveFunc)
	GVAR.MainFrameMoverT:SetScript("OnMouseDown", onMouseDownFunc)
	GVAR.MainFrameMoverT:SetScript("OnMouseUp", onMouseUpFunc)
	GVAR.MainFrameMoverTTexture = GVAR.MainFrameMoverT:CreateTexture(nil, "BACKGROUND")
	GVAR.MainFrameMoverTTexture:SetAllPoints(GVAR.MainFrameMoverT)
	GVAR.MainFrameMoverTTexture:SetTexture(1, 1, 1, 0.2)
	GVAR.MainFrameMoverTTxt = GVAR.MainFrameMoverT:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.MainFrameMoverTTxt:SetAllPoints(GVAR.MainFrameMoverT)
	GVAR.MainFrameMoverTTxt:SetText(L["click & move"])
	GVAR.MainFrameMoverTTxt:SetTextColor(0.3, 0.3, 0.3, 1)
	GVAR.MainFrameMoverB = CreateFrame("Button", nil, GVAR.MainFrameMoverFrame)
	TEMPLATE.BorderTRBL(GVAR.MainFrameMoverB)
	GVAR.MainFrameMoverB:SetWidth(200)
	GVAR.MainFrameMoverB:SetHeight(25)
	GVAR.MainFrameMoverB:SetPoint("TOP", GVAR.MonoblockAnchor, "BOTTOM", 0, -75)
	GVAR.MainFrameMoverB:SetScript("OnEnter", onEnterFunc)
	GVAR.MainFrameMoverB:SetScript("OnLeave", onLeaveFunc)
	GVAR.MainFrameMoverB:SetScript("OnMouseDown", onMouseDownFunc)
	GVAR.MainFrameMoverB:SetScript("OnMouseUp", onMouseUpFunc)
	GVAR.MainFrameMoverBTexture = GVAR.MainFrameMoverB:CreateTexture(nil, "BACKGROUND")
	GVAR.MainFrameMoverBTexture:SetAllPoints(GVAR.MainFrameMoverB)
	GVAR.MainFrameMoverBTexture:SetTexture(1, 1, 1, 0.2)
	GVAR.MainFrameMoverBTxt = GVAR.MainFrameMoverB:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.MainFrameMoverBTxt:SetAllPoints(GVAR.MainFrameMoverB)
	GVAR.MainFrameMoverBTxt:SetText(L["click & move"])
	GVAR.MainFrameMoverBTxt:SetTextColor(0.3, 0.3, 0.3, 1)
	-- main frame mover

	BattlegroundTargets:SetupMonoblockPosition()
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CreateOptionsFrame()
	BattlegroundTargets:DefaultShuffle()

	local heightBase = 58 -- 10+16+10+22
	local heightBracket = 568
	-- 10+16 +8+1+8+                              43 -- top enable
	-- 16+10 + 16 +                               42 -- layout -> summary
	-- 8+1+8 + 24 +                               41 -- copy button
	-- 8+1+8 + 16+10 + 16+10 + 16 +               85 -- 1. row role -> targetcount
	-- 8+1+8 + 16+10 + 16+10 + 16+10 + 16        111 -- 2. target -> targetassist
	-- 8+1+8 + 16+10 + 16 +                       59 -- 3. health -> range
	-- 8+1+8 + 16 +                               33 -- 4. sort
	-- 8+1+8 + 16+10 + 16 +                       59 -- 5. fonts
	-- 8+1+8 + 16+10 + 16+10 + 16 + 10            95 -- 6. scale -> height
	local heightTotal = heightBase + heightBracket + 30 + 10

	-- ####################################################################################################
	-- xMx OptionsFrame
	GVAR.OptionsFrame = CreateFrame("Frame", "BattlegroundTargets_OptionsFrame", UIParent)
	TEMPLATE.BorderTRBL(GVAR.OptionsFrame)
	GVAR.OptionsFrame:EnableMouse(true)
	GVAR.OptionsFrame:SetMovable(true)
	GVAR.OptionsFrame:SetToplevel(true)
	GVAR.OptionsFrame:SetClampedToScreen(true)
	-- BOOM GVAR.OptionsFrame:SetClampRectInsets()
	-- BOOM GVAR.OptionsFrame:SetWidth()
	GVAR.OptionsFrame:SetHeight(heightTotal)
	GVAR.OptionsFrame:Hide()
	GVAR.OptionsFrame:SetScript("OnShow", function() BattlegroundTargets:OptionsFrameShow() end)
	GVAR.OptionsFrame:SetScript("OnHide", function() BattlegroundTargets:OptionsFrameHide() end)
	GVAR.OptionsFrame:SetScript("OnMouseWheel", NOOP)

	-- close
	GVAR.OptionsFrame.CloseConfig = CreateFrame("Button", nil, GVAR.OptionsFrame)
	TEMPLATE.TextButton(GVAR.OptionsFrame.CloseConfig, L["Close Configuration"], 1)
	GVAR.OptionsFrame.CloseConfig:SetPoint("BOTTOM", GVAR.OptionsFrame, "BOTTOM", 0, 10)
	GVAR.OptionsFrame.CloseConfig:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	-- BOOM GVAR.OptionsFrame.CloseConfig:SetWidth()
	GVAR.OptionsFrame.CloseConfig:SetHeight(30)
	GVAR.OptionsFrame.CloseConfig:SetScript("OnClick", function() GVAR.OptionsFrame:Hide() end)
	-- ###
	-- ####################################################################################################



	-- ####################################################################################################
	-- xMx Base
	GVAR.OptionsFrame.Base = CreateFrame("Frame", nil, GVAR.OptionsFrame)
	TEMPLATE.BorderTRBL(GVAR.OptionsFrame.Base)
	-- BOOM GVAR.OptionsFrame.Base:SetWidth()
	GVAR.OptionsFrame.Base:SetHeight(heightBase)
	GVAR.OptionsFrame.Base:SetPoint("TOPLEFT", GVAR.OptionsFrame, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.Base:EnableMouse(true)

	GVAR.OptionsFrame.Title = GVAR.OptionsFrame.Base:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	-- BOOM GVAR.OptionsFrame.Title:SetWidth()
	GVAR.OptionsFrame.Title:SetPoint("TOPLEFT", GVAR.OptionsFrame.Base, "TOPLEFT", 0, -10)
	GVAR.OptionsFrame.Title:SetJustifyH("CENTER")
	GVAR.OptionsFrame.Title:SetText("BattlegroundTargets")

	-- tabs
	GVAR.OptionsFrame.TabGeneral = CreateFrame("Button", nil, GVAR.OptionsFrame.Base)
	TEMPLATE.TabButton(GVAR.OptionsFrame.TabGeneral, L["Options"], nil, "monotext")
	-- BOOM GVAR.OptionsFrame.TabGeneral:SetWidth()
	GVAR.OptionsFrame.TabGeneral:SetHeight(22)
	-- BOOM GVAR.OptionsFrame.TabGeneral:SetPoint()
	GVAR.OptionsFrame.TabGeneral:SetScript("OnClick", function()
		if GVAR.OptionsFrame.ConfigGeneral:IsShown() then
			TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
			GVAR.OptionsFrame.ConfigGeneral:Hide()
			GVAR.OptionsFrame.ConfigBrackets:Show()
			GVAR.OptionsFrame["TabRaidSize"..testSize].TextureBottom:SetTexture(0, 0, 0, 1)
		else
			TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, true)
			GVAR.OptionsFrame.ConfigGeneral:Show()
			GVAR.OptionsFrame.ConfigBrackets:Hide()
			GVAR.OptionsFrame["TabRaidSize"..testSize].TextureBottom:SetTexture(0.8, 0.2, 0.2, 1)
		end
	end)

	GVAR.OptionsFrame.TabRaidSize10 = CreateFrame("Button", nil, GVAR.OptionsFrame.Base)
	TEMPLATE.TabButton(GVAR.OptionsFrame.TabRaidSize10, L["10v10"], BattlegroundTargets_Options.EnableBracket[10])
	-- BOOM GVAR.OptionsFrame.TabRaidSize10:SetWidth()
	GVAR.OptionsFrame.TabRaidSize10:SetHeight(22)
	-- BOOM GVAR.OptionsFrame.TabRaidSize10:SetPoint()
	GVAR.OptionsFrame.TabRaidSize10:SetScript("OnClick", function()
		GVAR.OptionsFrame.ConfigGeneral:Hide()
		GVAR.OptionsFrame.ConfigBrackets:Show()
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, true)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, nil)
		if testSize == 10 then return end
		testSize = 10
		BattlegroundTargets:CheckForEnabledBracket(testSize)
		if BattlegroundTargets_Options.EnableBracket[testSize] then
			BattlegroundTargets:EnableConfigMode()
		else
			BattlegroundTargets:DisableConfigMode()
		end
	end)

	GVAR.OptionsFrame.TabRaidSize15 = CreateFrame("Button", nil, GVAR.OptionsFrame.Base)
	TEMPLATE.TabButton(GVAR.OptionsFrame.TabRaidSize15, L["15v15"], BattlegroundTargets_Options.EnableBracket[15])
	-- BOOM GVAR.OptionsFrame.TabRaidSize15:SetWidth()
	GVAR.OptionsFrame.TabRaidSize15:SetHeight(22)
	-- BOOM GVAR.OptionsFrame.TabRaidSize15:SetPoint()
	GVAR.OptionsFrame.TabRaidSize15:SetScript("OnClick", function()
		GVAR.OptionsFrame.ConfigGeneral:Hide()
		GVAR.OptionsFrame.ConfigBrackets:Show()
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, true)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, nil)
		if testSize == 15 then return end
		testSize = 15
		BattlegroundTargets:CheckForEnabledBracket(testSize)
		if BattlegroundTargets_Options.EnableBracket[testSize] then
			BattlegroundTargets:EnableConfigMode()
		else
			BattlegroundTargets:DisableConfigMode()
		end
	end)

	GVAR.OptionsFrame.TabRaidSize40 = CreateFrame("Button", nil, GVAR.OptionsFrame.Base)
	TEMPLATE.TabButton(GVAR.OptionsFrame.TabRaidSize40, L["40v40"], BattlegroundTargets_Options.EnableBracket[40])
	-- BOOM GVAR.OptionsFrame.TabRaidSize40:SetWidth()
	GVAR.OptionsFrame.TabRaidSize40:SetHeight(22)
	-- BOOM GVAR.OptionsFrame.TabRaidSize40:SetPoint()
	GVAR.OptionsFrame.TabRaidSize40:SetScript("OnClick", function()
		GVAR.OptionsFrame.ConfigGeneral:Hide()
		GVAR.OptionsFrame.ConfigBrackets:Show()
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, true)
		if testSize == 40 then return end
		testSize = 40
		BattlegroundTargets:CheckForEnabledBracket(testSize)
		if BattlegroundTargets_Options.EnableBracket[testSize] then
			BattlegroundTargets:EnableConfigMode()
		else
			BattlegroundTargets:DisableConfigMode()
		end
	end)

	if testSize == 10 then
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, true)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, nil)
	elseif testSize == 15 then
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, true)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, nil)
	elseif testSize == 40 then
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, true)
	end
	-- ###
	-- ####################################################################################################



	-- ####################################################################################################
	-- xMx ConfigBrackets
	GVAR.OptionsFrame.ConfigBrackets = CreateFrame("Frame", nil, GVAR.OptionsFrame)
	-- BOOM GVAR.OptionsFrame.ConfigBrackets:SetWidth()
	GVAR.OptionsFrame.ConfigBrackets:SetHeight(heightBracket)
	GVAR.OptionsFrame.ConfigBrackets:SetPoint("TOPLEFT", GVAR.OptionsFrame.Base, "BOTTOMLEFT", 0, 1)
	GVAR.OptionsFrame.ConfigBrackets:Hide()

	-- enable bracket
	GVAR.OptionsFrame.EnableBracket = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.EnableBracket, 16, 4, L["Enable"])
	GVAR.OptionsFrame.EnableBracket:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.EnableBracket:SetPoint("TOP", GVAR.OptionsFrame.Base, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.EnableBracket:SetChecked(BattlegroundTargets_Options.EnableBracket[currentSize])
	GVAR.OptionsFrame.EnableBracket:SetScript("OnClick", function()
		BattlegroundTargets_Options.EnableBracket[currentSize] = not BattlegroundTargets_Options.EnableBracket[currentSize]
		GVAR.OptionsFrame.EnableBracket:SetChecked(BattlegroundTargets_Options.EnableBracket[currentSize])
		BattlegroundTargets:CheckForEnabledBracket(currentSize)
		if BattlegroundTargets_Options.EnableBracket[currentSize] then
			BattlegroundTargets:EnableConfigMode()
		else
			BattlegroundTargets:DisableConfigMode()
		end
	end)

	-- independent positioning
	GVAR.OptionsFrame.IndependentPos = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.IndependentPos, 16, 4, L["Independent Positioning"])
	GVAR.OptionsFrame.IndependentPos:SetPoint("LEFT", GVAR.OptionsFrame.EnableBracket, "RIGHT", 50, 0)
	GVAR.OptionsFrame.IndependentPos:SetChecked(BattlegroundTargets_Options.IndependentPositioning[currentSize])
	GVAR.OptionsFrame.IndependentPos:SetScript("OnClick", function()
		BattlegroundTargets_Options.IndependentPositioning[currentSize] = not BattlegroundTargets_Options.IndependentPositioning[currentSize]
		GVAR.OptionsFrame.IndependentPos:SetChecked(BattlegroundTargets_Options.IndependentPositioning[currentSize])
		if not BattlegroundTargets_Options.IndependentPositioning[currentSize] then
			BattlegroundTargets_Options.pos["BattlegroundTargets_MainFrame"..currentSize] = nil -- NEW 50200-3 or newer
			BattlegroundTargets_Options.pos["BattlegroundTargets_MainFrame"..currentSize] = nil -- NEW 50200-3 or newer
			BattlegroundTargets_Options.pos["BattlegroundTargets_MainFrame"..currentSize.."_posX"] = nil -- OLD pre50200-3
			BattlegroundTargets_Options.pos["BattlegroundTargets_MainFrame"..currentSize.."_posY"] = nil -- OLD pre50200-3
			if inCombat or InCombatLockdown() then
				reCheckBG = true
				return
			end
			BattlegroundTargets:Frame_SetupPosition("BattlegroundTargets_MainFrame")
		end
	end)



	-- DUMMY
	GVAR.OptionsFrame.Dummy1 = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "ARTWORK")
	-- BOOM GVAR.OptionsFrame.Dummy1:SetWidth()
	GVAR.OptionsFrame.Dummy1:SetHeight(1)
	GVAR.OptionsFrame.Dummy1:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Dummy1:SetPoint("TOP", GVAR.OptionsFrame.IndependentPos, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.Dummy1:SetTexture(0.8, 0.2, 0.2, 1)



	-- layout
	GVAR.OptionsFrame.LayoutTHText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.LayoutTHText:SetHeight(16)
	GVAR.OptionsFrame.LayoutTHText:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 26, 0)
	GVAR.OptionsFrame.LayoutTHText:SetPoint("TOP", GVAR.OptionsFrame.Dummy1, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.LayoutTHText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.LayoutTHText:SetText(L["Layout"]..":")
	GVAR.OptionsFrame.LayoutTHText:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.LayoutTHText.Background = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "BACKGROUND")
	GVAR.OptionsFrame.LayoutTHText.Background:SetPoint("TOPLEFT", GVAR.OptionsFrame.LayoutTHText, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.LayoutTHText.Background:SetPoint("BOTTOMRIGHT", GVAR.OptionsFrame.LayoutTHText, "BOTTOMRIGHT", 0, 0)
	GVAR.OptionsFrame.LayoutTHText.Background:SetTexture(0, 0, 0, 0)

	GVAR.OptionsFrame.LayoutTHx18 = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.LayoutTHx18, 16, 4, nil, "l40_18")
	GVAR.OptionsFrame.LayoutTHx18:SetPoint("LEFT", GVAR.OptionsFrame.LayoutTHText, "RIGHT", 10, 0)
	GVAR.OptionsFrame.LayoutTHx18:SetScript("OnClick", function()
		BattlegroundTargets_Options.LayoutTH[currentSize] = 18
		GVAR.OptionsFrame.LayoutTHx18:SetChecked(true)
		GVAR.OptionsFrame.LayoutTHx24:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx42:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx81:SetChecked(false)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.LayoutSpace)
		BattlegroundTargets:SetupLayout()
	end)
	GVAR.OptionsFrame.LayoutTHx24 = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.LayoutTHx24, 16, 4, nil, "l40_24")
	GVAR.OptionsFrame.LayoutTHx24:SetPoint("LEFT", GVAR.OptionsFrame.LayoutTHx18, "RIGHT", 0, 0)
	GVAR.OptionsFrame.LayoutTHx24:SetScript("OnClick", function()
		BattlegroundTargets_Options.LayoutTH[currentSize] = 24
		GVAR.OptionsFrame.LayoutTHx18:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx24:SetChecked(true)
		GVAR.OptionsFrame.LayoutTHx42:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx81:SetChecked(false)
		TEMPLATE.EnableSlider(GVAR.OptionsFrame.LayoutSpace)
		BattlegroundTargets:SetupLayout()
	end)
	GVAR.OptionsFrame.LayoutTHx42 = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.LayoutTHx42, 16, 4, nil, "l40_42")
	GVAR.OptionsFrame.LayoutTHx42:SetPoint("LEFT", GVAR.OptionsFrame.LayoutTHx24, "RIGHT", 0, 0)
	GVAR.OptionsFrame.LayoutTHx42:SetScript("OnClick", function()
		BattlegroundTargets_Options.LayoutTH[currentSize] = 42
		GVAR.OptionsFrame.LayoutTHx18:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx24:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx42:SetChecked(true)
		GVAR.OptionsFrame.LayoutTHx81:SetChecked(false)
		TEMPLATE.EnableSlider(GVAR.OptionsFrame.LayoutSpace)
		BattlegroundTargets:SetupLayout()
	end)
	GVAR.OptionsFrame.LayoutTHx81 = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.LayoutTHx81, 16, 4, nil, "l40_81")
	GVAR.OptionsFrame.LayoutTHx81:SetPoint("LEFT", GVAR.OptionsFrame.LayoutTHx42, "RIGHT", 0, 0)
	GVAR.OptionsFrame.LayoutTHx81:SetScript("OnClick", function()
		BattlegroundTargets_Options.LayoutTH[currentSize] = 81
		GVAR.OptionsFrame.LayoutTHx18:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx24:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx42:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx81:SetChecked(true)
		TEMPLATE.EnableSlider(GVAR.OptionsFrame.LayoutSpace)
		BattlegroundTargets:SetupLayout()
	end)
	GVAR.OptionsFrame.LayoutSpace = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.LayoutSpaceText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.LayoutSpace, 85, 1, 0, 20, BattlegroundTargets_Options.LayoutSpace[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.LayoutSpace[currentSize] then return end
		BattlegroundTargets_Options.LayoutSpace[currentSize] = value
		GVAR.OptionsFrame.LayoutSpaceText:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.LayoutSpace:SetPoint("LEFT", GVAR.OptionsFrame.LayoutTHx81, "RIGHT", 0, 0)
	GVAR.OptionsFrame.LayoutSpaceText:SetHeight(20)
	GVAR.OptionsFrame.LayoutSpaceText:SetPoint("LEFT", GVAR.OptionsFrame.LayoutSpace, "RIGHT", 5, 0)
	GVAR.OptionsFrame.LayoutSpaceText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.LayoutSpaceText:SetText(BattlegroundTargets_Options.LayoutSpace[currentSize])
	GVAR.OptionsFrame.LayoutSpaceText:SetTextColor(1, 1, 0.49, 1)
	local layoutW = GVAR.OptionsFrame.LayoutTHText:GetStringWidth() + 10 +
	                GVAR.OptionsFrame.LayoutTHx18:GetWidth() + 0 +
	                GVAR.OptionsFrame.LayoutTHx24:GetWidth() + 0 +
	                GVAR.OptionsFrame.LayoutTHx42:GetWidth() + 0 +
	                GVAR.OptionsFrame.LayoutTHx81:GetWidth() + 0 +
	                GVAR.OptionsFrame.LayoutSpace:GetWidth() + 50

	local function ConfigFontNumberOptionCheck(size)
		if BattlegroundTargets_Options.SummaryToggle[size] or
		   OPT.ButtonShowFlag[size] or
		   OPT.ButtonShowHealthText[size] or
		   OPT.ButtonShowTargetCount[size]
		then
			TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.FontNumberPullDown)
			GVAR.OptionsFrame.FontNumberTitle:SetTextColor(1, 1, 1, 1)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.FontNumberSlider)
		else
			TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.FontNumberPullDown)
			GVAR.OptionsFrame.FontNumberTitle:SetTextColor(0.5, 0.5, 0.5, 1)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FontNumberSlider)
		end
	end

	-- summary
	GVAR.OptionsFrame.SummaryText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.SummaryText:SetHeight(16)
	GVAR.OptionsFrame.SummaryText:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 26, 0)
	GVAR.OptionsFrame.SummaryText:SetPoint("TOP", GVAR.OptionsFrame.LayoutTHText, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.SummaryText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.SummaryText:SetText(L["Summary"]..":")
	GVAR.OptionsFrame.SummaryText:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.SummaryText.Background = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "BACKGROUND")
	GVAR.OptionsFrame.SummaryText.Background:SetPoint("TOPLEFT", GVAR.OptionsFrame.SummaryText, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.SummaryText.Background:SetPoint("BOTTOMRIGHT", GVAR.OptionsFrame.SummaryText, "BOTTOMRIGHT", 0, 0)
	GVAR.OptionsFrame.SummaryText.Background:SetTexture(0, 0, 0, 0)

	GVAR.OptionsFrame.SummaryToggle = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets) -- SUMMARY
	TEMPLATE.CheckButton(GVAR.OptionsFrame.SummaryToggle, 16, 0, "")
	GVAR.OptionsFrame.SummaryToggle:SetPoint("LEFT", GVAR.OptionsFrame.SummaryText, "RIGHT", 10, 0)
	GVAR.OptionsFrame.SummaryToggle:SetChecked(BattlegroundTargets_Options.SummaryToggle[currentSize])
	TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.SummaryToggle)
	GVAR.OptionsFrame.SummaryToggle:SetScript("OnClick", function()
		BattlegroundTargets_Options.SummaryToggle[currentSize] = not BattlegroundTargets_Options.SummaryToggle[currentSize]
		if BattlegroundTargets_Options.SummaryToggle[currentSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.SummaryScale)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.SummaryPosition)
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryScale)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryPosition)
		end
		ConfigFontNumberOptionCheck(currentSize)
		BattlegroundTargets:EnableConfigMode()
	end)

	GVAR.OptionsFrame.SummaryScale = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.SummaryScaleText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.SummaryScale, 85, 5, 40, 150, BattlegroundTargets_Options.SummaryScale[currentSize],
	function(self, value)
		local nvalue = value/100
		if nvalue == BattlegroundTargets_Options.SummaryScale[currentSize] then return end
		BattlegroundTargets_Options.SummaryScale[currentSize] = nvalue
		GVAR.OptionsFrame.SummaryScaleText:SetText(value.."%")
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.SummaryScale:SetPoint("LEFT", GVAR.OptionsFrame.SummaryToggle, "RIGHT", 10, 0)
	GVAR.OptionsFrame.SummaryScaleText:SetHeight(16)
	GVAR.OptionsFrame.SummaryScaleText:SetPoint("LEFT", GVAR.OptionsFrame.SummaryScale, "RIGHT", 5, 0)
	GVAR.OptionsFrame.SummaryScaleText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.SummaryScaleText:SetText((BattlegroundTargets_Options.SummaryScale[currentSize]*100).."%")
	GVAR.OptionsFrame.SummaryScaleText:SetTextColor(1, 1, 0.49, 1)

	GVAR.OptionsFrame.SummaryPosition = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets) -- SUMPOSi
	GVAR.OptionsFrame.SummaryPositionText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.SummaryPosition, 85, 1, 1, 9, BattlegroundTargets_Options.SummaryPos[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.SummaryPos[currentSize] then return end
		BattlegroundTargets_Options.SummaryPos[currentSize] = value
		GVAR.OptionsFrame.SummaryPositionText:SetText(sumPos[ value ])
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.SummaryPosition:SetPoint("LEFT", GVAR.OptionsFrame.SummaryScale, "RIGHT", 50, 0)
	GVAR.OptionsFrame.SummaryPositionText:SetHeight(20)
	GVAR.OptionsFrame.SummaryPositionText:SetWidth(50)
	GVAR.OptionsFrame.SummaryPositionText:SetPoint("LEFT", GVAR.OptionsFrame.SummaryPosition, "RIGHT", 5, 0)
	GVAR.OptionsFrame.SummaryPositionText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.SummaryPositionText:SetText(sumPos[ BattlegroundTargets_Options.SummaryPos[currentSize] ])
	GVAR.OptionsFrame.SummaryPositionText:SetTextColor(1, 1, 0.49, 1)

	if BattlegroundTargets_Options.SummaryToggle[currentSize] then
		TEMPLATE.EnableSlider(GVAR.OptionsFrame.SummaryScale)
		TEMPLATE.EnableSlider(GVAR.OptionsFrame.SummaryPosition)
	else
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryScale)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryPosition)
	end
	local summaryW = GVAR.OptionsFrame.SummaryText:GetStringWidth() + 10 +
	                 GVAR.OptionsFrame.SummaryToggle:GetWidth() + 10 +
	                 GVAR.OptionsFrame.SummaryScale:GetWidth() + 10 +
	                 GVAR.OptionsFrame.SummaryPosition:GetWidth() + 50



	-- DUMMY
	GVAR.OptionsFrame.Dummy2 = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "ARTWORK")
	-- BOOM GVAR.OptionsFrame.Dummy2:SetWidth()
	GVAR.OptionsFrame.Dummy2:SetHeight(1)
	GVAR.OptionsFrame.Dummy2:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Dummy2:SetPoint("TOP", GVAR.OptionsFrame.SummaryToggle, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.Dummy2:SetTexture(0.73, 0.26, 0.21, 0.5)



	-- copy settings
	GVAR.OptionsFrame.CopySettings = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.TextButton(GVAR.OptionsFrame.CopySettings, format(L["Copy this settings to %s"], "|cffffffff"..L["15v15"].."|r"), 4)
	-- BOOM GVAR.OptionsFrame.CopySettings:SetPoint()
	GVAR.OptionsFrame.CopySettings:SetPoint("TOP", GVAR.OptionsFrame.Dummy2, "BOTTOM", 0, -8)
	-- BOOM GVAR.OptionsFrame.CopySettings:SetWidth()
	GVAR.OptionsFrame.CopySettings:SetHeight(24)
	GVAR.OptionsFrame.CopySettings:SetScript("OnClick", function() BattlegroundTargets:CopySettings(currentSize) end)
	GVAR.OptionsFrame.CopySettings:SetScript("OnEnter", function()
		GVAR.OptionsFrame.LayoutTHText.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.LayoutTHx18.Highlight:Show()
		GVAR.OptionsFrame.LayoutTHx24.Highlight:Show()
		GVAR.OptionsFrame.LayoutTHx42.Highlight:Show()
		GVAR.OptionsFrame.LayoutTHx81.Highlight:Show()
		GVAR.OptionsFrame.LayoutSpace.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.SummaryText.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.SummaryToggle.Highlight:Show()
		GVAR.OptionsFrame.SummaryScale.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.SummaryPosition.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL ----------
		GVAR.OptionsFrame.ShowRole.Highlight:Show()
		GVAR.OptionsFrame.ShowSpec.Highlight:Show()
		GVAR.OptionsFrame.ClassIcon.Highlight:Show()
		GVAR.OptionsFrame.ShowLeader.Highlight:Show()
		GVAR.OptionsFrame.ShowRealm.Highlight:Show()
		GVAR.OptionsFrame.ShowTargetCount.Highlight:Show()----------
		GVAR.OptionsFrame.ShowTargetIndicator.Highlight:Show()
		GVAR.OptionsFrame.TargetScaleSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.TargetPositionSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.ShowFocusIndicator.Highlight:Show()
		GVAR.OptionsFrame.FocusScaleSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.FocusPositionSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.ShowFlag.Highlight:Show()
		GVAR.OptionsFrame.FlagScaleSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.FlagPositionSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.ShowAssist.Highlight:Show()
		GVAR.OptionsFrame.AssistScaleSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.AssistPositionSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL ----------
		GVAR.OptionsFrame.ShowHealthBar.Highlight:Show()
		GVAR.OptionsFrame.ShowHealthText.Highlight:Show()
		GVAR.OptionsFrame.RangeCheck.Highlight:Show()
		GVAR.OptionsFrame.RangeCheckTypePullDown:LockHighlight()
		GVAR.OptionsFrame.RangeDisplayPullDown:LockHighlight()
		GVAR.OptionsFrame.SortByTitle.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.SortByPullDown:LockHighlight()
		GVAR.OptionsFrame.SortDetailPullDown:LockHighlight()----------
		GVAR.OptionsFrame.FontNameTitle.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.FontNamePullDown:LockHighlight()
		GVAR.OptionsFrame.FontNameSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.FontNumberTitle.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.FontNumberPullDown:LockHighlight()
		GVAR.OptionsFrame.FontNumberSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.ScaleTitle.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.ScaleSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.WidthTitle.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.WidthSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.HeightTitle.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
		GVAR.OptionsFrame.HeightSlider.Background:SetTexture(1, 1, 1, 0.15) -- COPYHL
	end)
	GVAR.OptionsFrame.CopySettings:SetScript("OnLeave", function()
		GVAR.OptionsFrame.LayoutTHText.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.LayoutTHx18.Highlight:Hide()
		GVAR.OptionsFrame.LayoutTHx24.Highlight:Hide()
		GVAR.OptionsFrame.LayoutTHx42.Highlight:Hide()
		GVAR.OptionsFrame.LayoutTHx81.Highlight:Hide()
		GVAR.OptionsFrame.LayoutSpace.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.SummaryText.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.SummaryToggle.Highlight:Hide()
		GVAR.OptionsFrame.SummaryScale.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.SummaryPosition.Background:SetTexture(0, 0, 0, 0)----------
		GVAR.OptionsFrame.ShowRole.Highlight:Hide()
		GVAR.OptionsFrame.ShowSpec.Highlight:Hide()
		GVAR.OptionsFrame.ClassIcon.Highlight:Hide()
		GVAR.OptionsFrame.ShowLeader.Highlight:Hide()
		GVAR.OptionsFrame.ShowRealm.Highlight:Hide()
		GVAR.OptionsFrame.ShowTargetCount.Highlight:Hide()----------
		GVAR.OptionsFrame.ShowTargetIndicator.Highlight:Hide()
		GVAR.OptionsFrame.TargetScaleSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.TargetPositionSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.ShowFocusIndicator.Highlight:Hide()
		GVAR.OptionsFrame.FocusScaleSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.FocusPositionSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.ShowFlag.Highlight:Hide()
		GVAR.OptionsFrame.FlagScaleSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.FlagPositionSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.ShowAssist.Highlight:Hide()
		GVAR.OptionsFrame.AssistScaleSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.AssistPositionSlider.Background:SetTexture(0, 0, 0, 0)----------
		GVAR.OptionsFrame.ShowHealthBar.Highlight:Hide()
		GVAR.OptionsFrame.ShowHealthText.Highlight:Hide()
		GVAR.OptionsFrame.RangeCheck.Highlight:Hide()
		GVAR.OptionsFrame.RangeCheckTypePullDown:UnlockHighlight()
		GVAR.OptionsFrame.RangeDisplayPullDown:UnlockHighlight()
		GVAR.OptionsFrame.SortByTitle.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.SortByPullDown:UnlockHighlight()
		GVAR.OptionsFrame.SortDetailPullDown:UnlockHighlight()----------
		GVAR.OptionsFrame.FontNameTitle.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.FontNamePullDown:UnlockHighlight()
		GVAR.OptionsFrame.FontNameSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.FontNumberTitle.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.FontNumberPullDown:UnlockHighlight()
		GVAR.OptionsFrame.FontNumberSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.ScaleTitle.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.ScaleSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.WidthTitle.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.WidthSlider.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.HeightTitle.Background:SetTexture(0, 0, 0, 0)
		GVAR.OptionsFrame.HeightSlider.Background:SetTexture(0, 0, 0, 0)
	end)



	-- DUMMY
	GVAR.OptionsFrame.Dummy3 = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "ARTWORK")
	-- BOOM GVAR.OptionsFrame.Dummy3:SetWidth()
	GVAR.OptionsFrame.Dummy3:SetHeight(1)
	GVAR.OptionsFrame.Dummy3:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Dummy3:SetPoint("TOP", GVAR.OptionsFrame.CopySettings, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.Dummy3:SetTexture(0.73, 0.26, 0.21, 0.5)



	-- show role
	GVAR.OptionsFrame.ShowRole = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowRole, 16, 4, L["Role"])
	GVAR.OptionsFrame.ShowRole:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ShowRole:SetPoint("TOP", GVAR.OptionsFrame.Dummy3, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.ShowRole:SetChecked(OPT.ButtonShowRole[currentSize])
	GVAR.OptionsFrame.ShowRole:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowRole[currentSize] = not BattlegroundTargets_Options.ButtonShowRole[currentSize]
		                        OPT.ButtonShowRole[currentSize] = not                         OPT.ButtonShowRole[currentSize]
		GVAR.OptionsFrame.ShowRole:SetChecked(OPT.ButtonShowRole[currentSize])
		BattlegroundTargets:EnableConfigMode()
	end)

	-- show spec
	GVAR.OptionsFrame.ShowSpec = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowSpec, 16, 4, L["Specialization"])
	--GVAR.OptionsFrame.ShowSpec:SetPoint()
	GVAR.OptionsFrame.ShowSpec:SetChecked(OPT.ButtonShowSpec[currentSize])
	GVAR.OptionsFrame.ShowSpec:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowSpec[currentSize] = not BattlegroundTargets_Options.ButtonShowSpec[currentSize]
		                        OPT.ButtonShowSpec[currentSize] = not                         OPT.ButtonShowSpec[currentSize]
		GVAR.OptionsFrame.ShowSpec:SetChecked(OPT.ButtonShowSpec[currentSize])
		BattlegroundTargets:EnableConfigMode()
	end)

	-- class icon
	GVAR.OptionsFrame.ClassIcon = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ClassIcon, 16, 4, L["Class Icon"])
	--GVAR.OptionsFrame.ClassIcon:SetPoint()
	GVAR.OptionsFrame.ClassIcon:SetChecked(OPT.ButtonClassIcon[currentSize])
	GVAR.OptionsFrame.ClassIcon:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonClassIcon[currentSize] = not BattlegroundTargets_Options.ButtonClassIcon[currentSize]
		                        OPT.ButtonClassIcon[currentSize] = not                         OPT.ButtonClassIcon[currentSize]
		GVAR.OptionsFrame.ClassIcon:SetChecked(OPT.ButtonClassIcon[currentSize])
		BattlegroundTargets:EnableConfigMode()
	end)

	-- show realm
	GVAR.OptionsFrame.ShowRealm = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowRealm, 16, 4, L["Realm"])
	GVAR.OptionsFrame.ShowRealm:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ShowRealm:SetPoint("TOP", GVAR.OptionsFrame.ShowRole, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.ShowRealm:SetChecked(OPT.ButtonShowRealm[currentSize])
	GVAR.OptionsFrame.ShowRealm:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowRealm[currentSize] = not BattlegroundTargets_Options.ButtonShowRealm[currentSize]
		                        OPT.ButtonShowRealm[currentSize] = not                         OPT.ButtonShowRealm[currentSize]
		GVAR.OptionsFrame.ShowRealm:SetChecked(OPT.ButtonShowRealm[currentSize])
		BattlegroundTargets:EnableConfigMode()
	end)

	-- show leader
	GVAR.OptionsFrame.ShowLeader = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowLeader, 16, 4, L["Leader"])
	--GVAR.OptionsFrame.ShowLeader:SetPoint()
	GVAR.OptionsFrame.ShowLeader:SetChecked(OPT.ButtonShowLeader[currentSize])
	GVAR.OptionsFrame.ShowLeader:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowLeader[currentSize] = not BattlegroundTargets_Options.ButtonShowLeader[currentSize]
		                        OPT.ButtonShowLeader[currentSize] = not                         OPT.ButtonShowLeader[currentSize]
		GVAR.OptionsFrame.ShowLeader:SetChecked(OPT.ButtonShowLeader[currentSize])
		BattlegroundTargets:EnableConfigMode()
	end)

	-- show targetcount
	GVAR.OptionsFrame.ShowTargetCount = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowTargetCount, 16, 4, L["Target Count"])
	GVAR.OptionsFrame.ShowTargetCount:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ShowTargetCount:SetPoint("TOP", GVAR.OptionsFrame.ShowRealm, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.ShowTargetCount:SetChecked(OPT.ButtonShowTargetCount[currentSize])
	GVAR.OptionsFrame.ShowTargetCount:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowTargetCount[currentSize] = not BattlegroundTargets_Options.ButtonShowTargetCount[currentSize]
		                        OPT.ButtonShowTargetCount[currentSize] = not                         OPT.ButtonShowTargetCount[currentSize]
		GVAR.OptionsFrame.ShowTargetCount:SetChecked(OPT.ButtonShowTargetCount[currentSize])
		ConfigFontNumberOptionCheck(currentSize)
		BattlegroundTargets:EnableConfigMode()
	end)

	local eq, sw = 0, 0
	sw = GVAR.OptionsFrame.ShowRole:GetWidth() if sw > eq then eq = sw end
	sw = GVAR.OptionsFrame.ShowRealm:GetWidth() if sw > eq then eq = sw end
	sw = GVAR.OptionsFrame.ShowTargetCount:GetWidth() if sw > eq then eq = sw end
	GVAR.OptionsFrame.ShowLeader:SetPoint("LEFT", GVAR.OptionsFrame.ShowRealm, "LEFT", eq+50, 0)
	GVAR.OptionsFrame.ShowSpec:SetPoint("LEFT", GVAR.OptionsFrame.ShowRole, "LEFT", eq+50, 0)
	GVAR.OptionsFrame.ClassIcon:SetPoint("LEFT", GVAR.OptionsFrame.ShowSpec, "LEFT", GVAR.OptionsFrame.ShowSpec:GetWidth()+50, 0)

	local generalIconW = 10 + eq + 50 + GVAR.OptionsFrame.ShowSpec:GetWidth() + 50 + GVAR.OptionsFrame.ClassIcon:GetWidth() + 10



	-- DUMMY
	GVAR.OptionsFrame.Dummy4 = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "ARTWORK")
	-- BOOM GVAR.OptionsFrame.Dummy4:SetWidth()
	GVAR.OptionsFrame.Dummy4:SetHeight(1)
	GVAR.OptionsFrame.Dummy4:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Dummy4:SetPoint("TOP", GVAR.OptionsFrame.ShowTargetCount, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.Dummy4:SetTexture(0.73, 0.26, 0.21, 0.5)



	-- ----- icons ----------------------------------------
	local equalTextWidthIcons = 0
	-- show target indicator
	GVAR.OptionsFrame.ShowTargetIndicator = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowTargetIndicator, 16, 4, L["Target"])
	GVAR.OptionsFrame.ShowTargetIndicator:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ShowTargetIndicator:SetPoint("TOP", GVAR.OptionsFrame.Dummy4, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.ShowTargetIndicator:SetChecked(OPT.ButtonShowTarget[currentSize])
	GVAR.OptionsFrame.ShowTargetIndicator:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowTarget[currentSize] = not BattlegroundTargets_Options.ButtonShowTarget[currentSize]
		                        OPT.ButtonShowTarget[currentSize] = not                         OPT.ButtonShowTarget[currentSize]
		GVAR.OptionsFrame.ShowTargetIndicator:SetChecked(OPT.ButtonShowTarget[currentSize])
		if OPT.ButtonShowTarget[currentSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.TargetScaleSlider)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.TargetPositionSlider)
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.TargetScaleSlider)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.TargetPositionSlider)
		end
		BattlegroundTargets:EnableConfigMode()
	end)
	local iw = GVAR.OptionsFrame.ShowTargetIndicator:GetWidth()
	if iw > equalTextWidthIcons then
		equalTextWidthIcons = iw
	end

	-- target indicator scale
	GVAR.OptionsFrame.TargetScaleSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.TargetScaleSliderText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.TargetScaleSlider, 85, 10, 100, 200, OPT.ButtonTargetScale[currentSize]*100,
	function(self, value)
		local nvalue = value/100
		if nvalue == BattlegroundTargets_Options.ButtonTargetScale[currentSize] then return end
		BattlegroundTargets_Options.ButtonTargetScale[currentSize] = nvalue
		                        OPT.ButtonTargetScale[currentSize] = nvalue
		GVAR.OptionsFrame.TargetScaleSliderText:SetText(value.."%")
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.TargetScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ShowTargetIndicator, "RIGHT", 10, 0)
	GVAR.OptionsFrame.TargetScaleSliderText:SetHeight(20)
	GVAR.OptionsFrame.TargetScaleSliderText:SetPoint("LEFT", GVAR.OptionsFrame.TargetScaleSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.TargetScaleSliderText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.TargetScaleSliderText:SetText((OPT.ButtonTargetScale[currentSize]*100).."%")
	GVAR.OptionsFrame.TargetScaleSliderText:SetTextColor(1, 1, 0.49, 1)

	-- target indicator position
	GVAR.OptionsFrame.TargetPositionSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.TargetPositionSliderText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.TargetPositionSlider, 85, 5, 0, 100, OPT.ButtonTargetPosition[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.ButtonTargetPosition[currentSize] then return end
		BattlegroundTargets_Options.ButtonTargetPosition[currentSize] = value
		                        OPT.ButtonTargetPosition[currentSize] = value
		GVAR.OptionsFrame.TargetPositionSliderText:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.TargetPositionSlider:SetPoint("LEFT", GVAR.OptionsFrame.TargetScaleSlider, "RIGHT", 50, 0)
	GVAR.OptionsFrame.TargetPositionSliderText:SetHeight(20)
	GVAR.OptionsFrame.TargetPositionSliderText:SetPoint("LEFT", GVAR.OptionsFrame.TargetPositionSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.TargetPositionSliderText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.TargetPositionSliderText:SetText(OPT.ButtonTargetPosition[currentSize])
	GVAR.OptionsFrame.TargetPositionSliderText:SetTextColor(1, 1, 0.49, 1)

	-- show focus indicator
	GVAR.OptionsFrame.ShowFocusIndicator = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowFocusIndicator, 16, 4, L["Focus"])
	GVAR.OptionsFrame.ShowFocusIndicator:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ShowFocusIndicator:SetPoint("TOP", GVAR.OptionsFrame.ShowTargetIndicator, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.ShowFocusIndicator:SetChecked(OPT.ButtonShowFocus[currentSize])
	GVAR.OptionsFrame.ShowFocusIndicator:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowFocus[currentSize] = not BattlegroundTargets_Options.ButtonShowFocus[currentSize]
		                        OPT.ButtonShowFocus[currentSize] = not                         OPT.ButtonShowFocus[currentSize]
		GVAR.OptionsFrame.ShowFocusIndicator:SetChecked(OPT.ButtonShowFocus[currentSize])
		if OPT.ButtonShowFocus[currentSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.FocusScaleSlider)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.FocusPositionSlider)
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FocusScaleSlider)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FocusPositionSlider)
		end
		BattlegroundTargets:EnableConfigMode()
	end)
	local iw = GVAR.OptionsFrame.ShowFocusIndicator:GetWidth()
	if iw > equalTextWidthIcons then
		equalTextWidthIcons = iw
	end

	-- focus indicator scale
	GVAR.OptionsFrame.FocusScaleSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.FocusScaleSliderText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.FocusScaleSlider, 85, 10, 100, 200, OPT.ButtonFocusScale[currentSize]*100,
	function(self, value)
		local nvalue = value/100
		if nvalue == BattlegroundTargets_Options.ButtonFocusScale[currentSize] then return end
		BattlegroundTargets_Options.ButtonFocusScale[currentSize] = nvalue
		                        OPT.ButtonFocusScale[currentSize] = nvalue
		GVAR.OptionsFrame.FocusScaleSliderText:SetText(value.."%")
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.FocusScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ShowFocusIndicator, "RIGHT", 10, 0)
	GVAR.OptionsFrame.FocusScaleSliderText:SetHeight(20)
	GVAR.OptionsFrame.FocusScaleSliderText:SetPoint("LEFT", GVAR.OptionsFrame.FocusScaleSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.FocusScaleSliderText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.FocusScaleSliderText:SetText((OPT.ButtonFocusScale[currentSize]*100).."%")
	GVAR.OptionsFrame.FocusScaleSliderText:SetTextColor(1, 1, 0.49, 1)

	-- focus indicator position
	GVAR.OptionsFrame.FocusPositionSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.FocusPositionSliderText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.FocusPositionSlider, 85, 5, 0, 100, OPT.ButtonFocusPosition[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.ButtonFocusPosition[currentSize] then return end
		BattlegroundTargets_Options.ButtonFocusPosition[currentSize] = value
		                        OPT.ButtonFocusPosition[currentSize] = value
		GVAR.OptionsFrame.FocusPositionSliderText:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.FocusPositionSlider:SetPoint("LEFT", GVAR.OptionsFrame.FocusScaleSlider, "RIGHT", 50, 0)
	GVAR.OptionsFrame.FocusPositionSliderText:SetHeight(20)
	GVAR.OptionsFrame.FocusPositionSliderText:SetPoint("LEFT", GVAR.OptionsFrame.FocusPositionSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.FocusPositionSliderText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.FocusPositionSliderText:SetText(OPT.ButtonFocusPosition[currentSize])
	GVAR.OptionsFrame.FocusPositionSliderText:SetTextColor(1, 1, 0.49, 1)

	-- flag/orb
	GVAR.OptionsFrame.ShowFlag = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowFlag, 16, 4, L["Flag"])
	GVAR.OptionsFrame.ShowFlag:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ShowFlag:SetPoint("TOP", GVAR.OptionsFrame.ShowFocusIndicator, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.ShowFlag:SetChecked(OPT.ButtonShowFlag[currentSize])
	TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowFlag)
	GVAR.OptionsFrame.ShowFlag:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowFlag[currentSize] = not BattlegroundTargets_Options.ButtonShowFlag[currentSize]
		                        OPT.ButtonShowFlag[currentSize] = not                         OPT.ButtonShowFlag[currentSize]
		if OPT.ButtonShowFlag[currentSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.FlagScaleSlider)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.FlagPositionSlider)
			GVAR.OptionsFrame.CarrierSwitchEnableFunc()
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagScaleSlider)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagPositionSlider)
			GVAR.OptionsFrame.CarrierSwitchDisableFunc()
		end
		ConfigFontNumberOptionCheck(currentSize)
		BattlegroundTargets:EnableConfigMode()
	end)

	-- flag
	GVAR.OptionsFrame.CarrierSwitchFlag = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.CarrierSwitchFlag:SetWidth(32)
	GVAR.OptionsFrame.CarrierSwitchFlag:SetHeight(32)
	GVAR.OptionsFrame.CarrierSwitchFlag:SetPoint("LEFT", GVAR.OptionsFrame.ShowFlag, "RIGHT", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchFlag.BG = GVAR.OptionsFrame.CarrierSwitchFlag:CreateTexture(nil, "BORDER")
	GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetWidth(27)
	GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetHeight(27)
	GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
	GVAR.OptionsFrame.CarrierSwitchFlag.Texture = GVAR.OptionsFrame.CarrierSwitchFlag:CreateTexture(nil, "OVERLAY")
	GVAR.OptionsFrame.CarrierSwitchFlag.Texture:SetWidth(30)
	GVAR.OptionsFrame.CarrierSwitchFlag.Texture:SetHeight(30)
	GVAR.OptionsFrame.CarrierSwitchFlag.Texture:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchFlag.Texture:SetTexture(Textures.flagTexture)
	GVAR.OptionsFrame.CarrierSwitchFlag:SetScript("OnEnter", function(self)
		if testData.CarrierDisplay == "flag" then return end
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = testData.CarrierDisplay
		testData.CarrierDisplay = "flag"
		BattlegroundTargets:EnableConfigMode()
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0.12, 0.12, 0.12, 1)
	end)
	GVAR.OptionsFrame.CarrierSwitchFlag:SetScript("OnLeave", function(self)
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay ~= testData.CarrierDisplay then
			testData.CarrierDisplay = GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay
			BattlegroundTargets:EnableConfigMode()
		end
		if testData.CarrierDisplay == "flag" then return end
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
	end)
	GVAR.OptionsFrame.CarrierSwitchFlag:SetScript("OnMouseDown", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "flag" then return end
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetSize(25,25)
		GVAR.OptionsFrame.CarrierSwitchFlag.Texture:SetSize(28,28)
	end)
	GVAR.OptionsFrame.CarrierSwitchFlag:SetScript("OnMouseUp", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "flag" then return end
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetSize(27,27)
		GVAR.OptionsFrame.CarrierSwitchFlag.Texture:SetSize(30,30)
	end)
	GVAR.OptionsFrame.CarrierSwitchFlag:SetScript("OnClick", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "flag" then return end
		testData.CarrierDisplay = "flag"
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = "flag"
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0.12, 0.12, 0.12, 1)
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
		BattlegroundTargets:EnableConfigMode()
	end)
	-- flag

	-- orb
	GVAR.OptionsFrame.CarrierSwitchOrb = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.CarrierSwitchOrb:SetWidth(32)
	GVAR.OptionsFrame.CarrierSwitchOrb:SetHeight(32)
	GVAR.OptionsFrame.CarrierSwitchOrb:SetPoint("LEFT", GVAR.OptionsFrame.CarrierSwitchFlag, "RIGHT", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchOrb.BG = GVAR.OptionsFrame.CarrierSwitchOrb:CreateTexture(nil, "BORDER")
	GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetWidth(27)
	GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetHeight(27)
	GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
	GVAR.OptionsFrame.CarrierSwitchOrb.Texture = GVAR.OptionsFrame.CarrierSwitchOrb:CreateTexture(nil, "OVERLAY")
	GVAR.OptionsFrame.CarrierSwitchOrb.Texture:SetWidth(30)
	GVAR.OptionsFrame.CarrierSwitchOrb.Texture:SetHeight(30)
	GVAR.OptionsFrame.CarrierSwitchOrb.Texture:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchOrb.Texture:SetTexture("Interface\\MiniMap\\TempleofKotmogu_ball_orange")
	GVAR.OptionsFrame.CarrierSwitchOrb:SetScript("OnEnter", function(self)
		if testData.CarrierDisplay == "orb" then return end
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = testData.CarrierDisplay
		testData.CarrierDisplay = "orb"
		BattlegroundTargets:EnableConfigMode()
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0.12, 0.12, 0.12, 1)
	end)
	GVAR.OptionsFrame.CarrierSwitchOrb:SetScript("OnLeave", function(self)
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay ~= testData.CarrierDisplay then
			testData.CarrierDisplay = GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay
			BattlegroundTargets:EnableConfigMode()
		end
		if testData.CarrierDisplay == "orb" then return end
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
	end)
	GVAR.OptionsFrame.CarrierSwitchOrb:SetScript("OnMouseDown", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "orb" then return end
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetSize(25,25)
		GVAR.OptionsFrame.CarrierSwitchOrb.Texture:SetSize(28,28)
	end)
	GVAR.OptionsFrame.CarrierSwitchOrb:SetScript("OnMouseUp", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "orb" then return end
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetSize(27,27)
		GVAR.OptionsFrame.CarrierSwitchOrb.Texture:SetSize(30,30)
	end)
	GVAR.OptionsFrame.CarrierSwitchOrb:SetScript("OnClick", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "orb" then return end
		testData.CarrierDisplay = "orb"
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = "orb"
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0.12, 0.12, 0.12, 1)
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
		BattlegroundTargets:EnableConfigMode()
	end)
	-- orb

	-- cart
	GVAR.OptionsFrame.CarrierSwitchCart = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.CarrierSwitchCart:SetWidth(32)
	GVAR.OptionsFrame.CarrierSwitchCart:SetHeight(32)
	GVAR.OptionsFrame.CarrierSwitchCart:SetPoint("LEFT", GVAR.OptionsFrame.CarrierSwitchOrb, "RIGHT", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchCart.BG = GVAR.OptionsFrame.CarrierSwitchCart:CreateTexture(nil, "BORDER")
	GVAR.OptionsFrame.CarrierSwitchCart.BG:SetWidth(27)
	GVAR.OptionsFrame.CarrierSwitchCart.BG:SetHeight(27)
	GVAR.OptionsFrame.CarrierSwitchCart.BG:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
	GVAR.OptionsFrame.CarrierSwitchCart.Texture = GVAR.OptionsFrame.CarrierSwitchCart:CreateTexture(nil, "OVERLAY")
	GVAR.OptionsFrame.CarrierSwitchCart.Texture:SetWidth(30)
	GVAR.OptionsFrame.CarrierSwitchCart.Texture:SetHeight(30)
	GVAR.OptionsFrame.CarrierSwitchCart.Texture:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.CarrierSwitchCart.Texture:SetTexture(Textures.cartTexture)
	GVAR.OptionsFrame.CarrierSwitchCart:SetScript("OnEnter", function(self)
		if testData.CarrierDisplay == "cart" then return end
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = testData.CarrierDisplay
		testData.CarrierDisplay = "cart"
		BattlegroundTargets:EnableConfigMode()
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0.12, 0.12, 0.12, 1)
	end)
	GVAR.OptionsFrame.CarrierSwitchCart:SetScript("OnLeave", function(self)
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay ~= testData.CarrierDisplay then
			testData.CarrierDisplay = GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay
			BattlegroundTargets:EnableConfigMode()
		end
		if testData.CarrierDisplay == "cart" then return end
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
	end)
	GVAR.OptionsFrame.CarrierSwitchCart:SetScript("OnMouseDown", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "cart" then return end
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetSize(25,25)
		GVAR.OptionsFrame.CarrierSwitchCart.Texture:SetSize(28,28)
	end)
	GVAR.OptionsFrame.CarrierSwitchCart:SetScript("OnMouseUp", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "cart" then return end
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetSize(27,27)
		GVAR.OptionsFrame.CarrierSwitchCart.Texture:SetSize(30,30)
	end)
	GVAR.OptionsFrame.CarrierSwitchCart:SetScript("OnClick", function()
		if GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay == "cart" then return end
		testData.CarrierDisplay = "cart"
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = "cart"
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0.12, 0.12, 0.12, 1)
		BattlegroundTargets:EnableConfigMode()
	end)
	-- cart

	if testData.CarrierDisplay == "flag" then
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = "flag"
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0.12, 0.12, 0.12, 1)
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
	elseif testData.CarrierDisplay == "orb" then
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = "orb"
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0.12, 0.12, 0.12, 1)
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
	elseif testData.CarrierDisplay == "cart" then
		GVAR.OptionsFrame.CarrierSwitchFlag.isDisplay = "cart"
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0.12, 0.12, 0.12, 1)
	end

	GVAR.OptionsFrame.CarrierSwitchEnableFunc = function()
		GVAR.OptionsFrame.CarrierSwitchFlag:EnableMouse(true)
		GVAR.OptionsFrame.CarrierSwitchOrb:EnableMouse(true)
		GVAR.OptionsFrame.CarrierSwitchCart:EnableMouse(true)
		GVAR.OptionsFrame.CarrierSwitchFlag:Enable()
		GVAR.OptionsFrame.CarrierSwitchOrb:Enable()
		GVAR.OptionsFrame.CarrierSwitchCart:Enable()
		Desaturation(GVAR.OptionsFrame.CarrierSwitchFlag.Texture, false)
		Desaturation(GVAR.OptionsFrame.CarrierSwitchOrb.Texture, false)
		Desaturation(GVAR.OptionsFrame.CarrierSwitchCart.Texture, false)
		if testData.CarrierDisplay == "flag" then
			GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0.12, 0.12, 0.12, 1)
			GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
			GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
		elseif testData.CarrierDisplay == "orb" then
			GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
			GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0.12, 0.12, 0.12, 1)
			GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
		elseif testData.CarrierDisplay == "cart" then
			GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
			GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
			GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0.12, 0.12, 0.12, 1)
		end
	end

	GVAR.OptionsFrame.CarrierSwitchDisableFunc = function()
		GVAR.OptionsFrame.CarrierSwitchFlag:EnableMouse(false)
		GVAR.OptionsFrame.CarrierSwitchOrb:EnableMouse(false)
		GVAR.OptionsFrame.CarrierSwitchCart:EnableMouse(false)
		GVAR.OptionsFrame.CarrierSwitchFlag:Disable()
		GVAR.OptionsFrame.CarrierSwitchOrb:Disable()
		GVAR.OptionsFrame.CarrierSwitchCart:Disable()
		Desaturation(GVAR.OptionsFrame.CarrierSwitchFlag.Texture, true)
		Desaturation(GVAR.OptionsFrame.CarrierSwitchOrb.Texture, true)
		Desaturation(GVAR.OptionsFrame.CarrierSwitchCart.Texture, true)
		GVAR.OptionsFrame.CarrierSwitchFlag.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchOrb.BG:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.CarrierSwitchCart.BG:SetTexture(0, 0, 0, 1)
	end

	local iw = GVAR.OptionsFrame.ShowFlag:GetWidth() + 32 + 32 + 32
	if iw > equalTextWidthIcons then
		equalTextWidthIcons = iw
	end

	-- flag scale
	GVAR.OptionsFrame.FlagScaleSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.FlagScaleSliderText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.FlagScaleSlider, 85, 10, 100, 200, OPT.ButtonFlagScale[currentSize]*100,
	function(self, value)
		local nvalue = value/100
		if nvalue == BattlegroundTargets_Options.ButtonFlagScale[currentSize] then return end
		BattlegroundTargets_Options.ButtonFlagScale[currentSize] = nvalue
		                        OPT.ButtonFlagScale[currentSize] = nvalue
		GVAR.OptionsFrame.FlagScaleSliderText:SetText(value.."%")
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.FlagScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ShowFlag, "RIGHT", 10, 0)
	GVAR.OptionsFrame.FlagScaleSliderText:SetHeight(20)
	GVAR.OptionsFrame.FlagScaleSliderText:SetPoint("LEFT", GVAR.OptionsFrame.FlagScaleSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.FlagScaleSliderText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.FlagScaleSliderText:SetText((OPT.ButtonFlagScale[currentSize]*100).."%")
	GVAR.OptionsFrame.FlagScaleSliderText:SetTextColor(1, 1, 0.49, 1)

	-- flag position
	GVAR.OptionsFrame.FlagPositionSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.FlagPositionSliderText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.FlagPositionSlider, 85, 5, 0, 100, OPT.ButtonFlagPosition[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.ButtonFlagPosition[currentSize] then return end
		BattlegroundTargets_Options.ButtonFlagPosition[currentSize] = value
		                        OPT.ButtonFlagPosition[currentSize] = value
		GVAR.OptionsFrame.FlagPositionSliderText:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.FlagPositionSlider:SetPoint("LEFT", GVAR.OptionsFrame.FlagScaleSlider, "RIGHT", 50, 0)
	GVAR.OptionsFrame.FlagPositionSliderText:SetHeight(20)
	GVAR.OptionsFrame.FlagPositionSliderText:SetPoint("LEFT", GVAR.OptionsFrame.FlagPositionSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.FlagPositionSliderText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.FlagPositionSliderText:SetText(OPT.ButtonFlagPosition[currentSize])
	GVAR.OptionsFrame.FlagPositionSliderText:SetTextColor(1, 1, 0.49, 1)

	-- show assist
	GVAR.OptionsFrame.ShowAssist = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowAssist, 16, 4, L["Main Assist Target"])
	GVAR.OptionsFrame.ShowAssist:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ShowAssist:SetPoint("TOP", GVAR.OptionsFrame.ShowFlag, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.ShowAssist:SetChecked(OPT.ButtonShowAssist[currentSize])
	TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowAssist)
	GVAR.OptionsFrame.ShowAssist:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowAssist[currentSize] = not BattlegroundTargets_Options.ButtonShowAssist[currentSize]
		                        OPT.ButtonShowAssist[currentSize] = not                         OPT.ButtonShowAssist[currentSize]
		if OPT.ButtonShowAssist[currentSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.AssistScaleSlider)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.AssistPositionSlider)
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.AssistScaleSlider)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.AssistPositionSlider)
		end
		BattlegroundTargets:EnableConfigMode()
	end)
	local iw = GVAR.OptionsFrame.ShowAssist:GetWidth()
	if iw > equalTextWidthIcons then
		equalTextWidthIcons = iw
	end

	-- assist scale
	GVAR.OptionsFrame.AssistScaleSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.AssistScaleSliderText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.AssistScaleSlider, 85, 10, 100, 200, OPT.ButtonAssistScale[currentSize]*100,
	function(self, value)
		local nvalue = value/100
		if nvalue == BattlegroundTargets_Options.ButtonAssistScale[currentSize] then return end
		BattlegroundTargets_Options.ButtonAssistScale[currentSize] = nvalue
		                        OPT.ButtonAssistScale[currentSize] = nvalue
		GVAR.OptionsFrame.AssistScaleSliderText:SetText(value.."%")
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.AssistScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ShowAssist, "RIGHT", 10, 0)
	GVAR.OptionsFrame.AssistScaleSliderText:SetHeight(20)
	GVAR.OptionsFrame.AssistScaleSliderText:SetPoint("LEFT", GVAR.OptionsFrame.AssistScaleSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.AssistScaleSliderText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.AssistScaleSliderText:SetText((OPT.ButtonAssistScale[currentSize]*100).."%")
	GVAR.OptionsFrame.AssistScaleSliderText:SetTextColor(1, 1, 0.49, 1)

	-- assist position
	GVAR.OptionsFrame.AssistPositionSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.AssistPositionSliderText = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TEMPLATE.Slider(GVAR.OptionsFrame.AssistPositionSlider, 85, 5, 0, 100, OPT.ButtonAssistPosition[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.ButtonAssistPosition[currentSize] then return end
		BattlegroundTargets_Options.ButtonAssistPosition[currentSize] = value
		                        OPT.ButtonAssistPosition[currentSize] = value
		GVAR.OptionsFrame.AssistPositionSliderText:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.AssistPositionSlider:SetPoint("LEFT", GVAR.OptionsFrame.AssistScaleSlider, "RIGHT", 50, 0)
	GVAR.OptionsFrame.AssistPositionSliderText:SetHeight(20)
	GVAR.OptionsFrame.AssistPositionSliderText:SetPoint("LEFT", GVAR.OptionsFrame.AssistPositionSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.AssistPositionSliderText:SetJustifyH("LEFT")
	GVAR.OptionsFrame.AssistPositionSliderText:SetText(OPT.ButtonAssistPosition[currentSize])
	GVAR.OptionsFrame.AssistPositionSliderText:SetTextColor(1, 1, 0.49, 1)


	GVAR.OptionsFrame.TargetScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ShowTargetIndicator, "LEFT", equalTextWidthIcons+10, 0)
	GVAR.OptionsFrame.FocusScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ShowFocusIndicator, "LEFT", equalTextWidthIcons+10, 0)
	GVAR.OptionsFrame.FlagScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ShowFlag, "LEFT", equalTextWidthIcons+10, 0)
	GVAR.OptionsFrame.AssistScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ShowAssist, "LEFT", equalTextWidthIcons+10, 0)
	local iconW = 10 + equalTextWidthIcons + 10 + GVAR.OptionsFrame.TargetScaleSlider:GetWidth() + 50 + GVAR.OptionsFrame.TargetPositionSlider:GetWidth() + 50
	-- ----- icons ----------------------------------------



	-- DUMMY
	GVAR.OptionsFrame.Dummy5 = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "ARTWORK")
	-- BOOM GVAR.OptionsFrame.Dummy5:SetWidth()
	GVAR.OptionsFrame.Dummy5:SetHeight(1)
	GVAR.OptionsFrame.Dummy5:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Dummy5:SetPoint("TOP", GVAR.OptionsFrame.ShowAssist, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.Dummy5:SetTexture(0.73, 0.26, 0.21, 0.5)



	-- health bar
	GVAR.OptionsFrame.ShowHealthBar = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowHealthBar, 16, 4, L["Health Bar"])
	GVAR.OptionsFrame.ShowHealthBar:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ShowHealthBar:SetPoint("TOP", GVAR.OptionsFrame.Dummy5, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.ShowHealthBar:SetChecked(OPT.ButtonShowHealthBar[currentSize])
	GVAR.OptionsFrame.ShowHealthBar:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowHealthBar[currentSize] = not BattlegroundTargets_Options.ButtonShowHealthBar[currentSize]
		                        OPT.ButtonShowHealthBar[currentSize] = not                         OPT.ButtonShowHealthBar[currentSize]
		GVAR.OptionsFrame.ShowHealthBar:SetChecked(OPT.ButtonShowHealthBar[currentSize])
		BattlegroundTargets:EnableConfigMode()
	end)

	-- health percent
	GVAR.OptionsFrame.ShowHealthText = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.ShowHealthText, 16, 4, L["Percent"])
	GVAR.OptionsFrame.ShowHealthText:SetPoint("LEFT", GVAR.OptionsFrame.ShowHealthBar.Text, "RIGHT", 20, 0)
	GVAR.OptionsFrame.ShowHealthText:SetChecked(OPT.ButtonShowHealthText[currentSize])
	GVAR.OptionsFrame.ShowHealthText:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonShowHealthText[currentSize] = not BattlegroundTargets_Options.ButtonShowHealthText[currentSize]
		                        OPT.ButtonShowHealthText[currentSize] = not                         OPT.ButtonShowHealthText[currentSize]
		GVAR.OptionsFrame.ShowHealthText:SetChecked(OPT.ButtonShowHealthText[currentSize])
		ConfigFontNumberOptionCheck(currentSize)
		BattlegroundTargets:EnableConfigMode()
	end)



	-- ----- range check ----------------------------------------
	local rangeW = 0
		----- text
		local minRange, maxRange
		if ranges[playerClassEN] then
			local _, _, _, _, _, _, _, minR, maxR = GetSpellInfo(ranges[playerClassEN])
			minRange = minR
			maxRange = maxR
		end
		minRange = minRange or "?"
		maxRange = maxRange or "?"
		rangeTypeName[2] = "2) "..L["Class"].." |cffffff79"..minRange.."-"..maxRange.."|r"
		rangeTypeName[3] = "3) "..L["Mix"].."1 |cffffff79"..minRange.."-"..maxRange.." + 0-45|r"
		rangeTypeName[4] = "4) "..L["Mix"].."2 |cffffff79"..minRange.."-"..maxRange.." + "..minRange.."-"..maxRange.."|r"
		local buttonName = rangeTypeName[1]
		if OPT.ButtonTypeRangeCheck[currentSize] == 2 then
			buttonName = rangeTypeName[2]
		elseif OPT.ButtonTypeRangeCheck[currentSize] == 3 then
			buttonName = rangeTypeName[3]
		elseif OPT.ButtonTypeRangeCheck[currentSize] == 4 then
			buttonName = rangeTypeName[4]
		end
		local rangeInfoTxt = ""
		rangeInfoTxt = rangeInfoTxt..rangeTypeName[1]..":\n"
		rangeInfoTxt = rangeInfoTxt.."   |cffffffff"..L["This option uses the CombatLog to check range."].."|r\n\n"
		rangeInfoTxt = rangeInfoTxt..rangeTypeName[2]..":\n"
		rangeInfoTxt = rangeInfoTxt.."   |cffffffff"..L["This option uses a pre-defined spell to check range:"].."|r\n"
		table_sort(class_IntegerSort, function(a, b) return a.loc < b.loc end)
		local playerMClass = "?"
		for i = 1, #class_IntegerSort do
			local classEN = class_IntegerSort[i].cid
			local name, _, _, _, _, _, _, minRange, maxRange = GetSpellInfo(ranges[classEN])
			local classStr = "|cff"..ClassHexColor(classEN)..class_IntegerSort[i].loc.."|r   "..(minRange or "?").."-"..(maxRange or "?").."   |cffffffff"..(name or UNKNOWN).."|r   |cffbbbbbb(spell ID = "..ranges[classEN]..")|r"
			if classEN == playerClassEN then
				playerMClass = "|cff"..ClassHexColor(classEN)..class_IntegerSort[i].loc.."|r"
				rangeInfoTxt = rangeInfoTxt..">>> "..classStr.." <<<"
			else
				rangeInfoTxt = rangeInfoTxt.."     "..classStr
			end
			rangeInfoTxt = rangeInfoTxt.."\n"
		end
		rangeInfoTxt = rangeInfoTxt.."\n"..rangeTypeName[3]..":\n"
		rangeInfoTxt = rangeInfoTxt.."   |cffffffff"..L["Class"]..":|r |cffffff79"..minRange.."-"..maxRange.."|r "..playerMClass.."\n"
		rangeInfoTxt = rangeInfoTxt.."   |cffffffffCombatLog:|r |cffffff790-45|r |cffaaaaaa("..L["if you are attacked only"]..")|r\n"
		rangeInfoTxt = rangeInfoTxt.."\n"..rangeTypeName[4]..":\n"
		rangeInfoTxt = rangeInfoTxt.."   |cffffffff"..L["Class"]..":|r |cffffff79"..minRange.."-"..maxRange.."|r "..playerMClass.."\n"
		rangeInfoTxt = rangeInfoTxt.."   |cffffffffCombatLog|r |cffaaaaaa"..L["(class dependent)"]..":|r |cffffff79"..minRange.."-"..maxRange.."|r "..playerMClass.." |cffaaaaaa("..L["if you are attacked only"]..")|r\n"
		rangeInfoTxt = rangeInfoTxt.."\n"
		rangeInfoTxt = rangeInfoTxt.."|TInterface\\DialogFrame\\UI-Dialog-Icon-AlertNew:28:32:0:0:64:64:0:64:0:56|t"
		rangeInfoTxt = rangeInfoTxt.."|cffffff00 "..L["Disable this option if you have CPU/FPS problems in combat."].." |r"
		----- text
	-- range check
	GVAR.OptionsFrame.RangeCheck = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.RangeCheck, 16, 4, L["Range"])
	GVAR.OptionsFrame.RangeCheck:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.RangeCheck:SetPoint("TOP", GVAR.OptionsFrame.ShowHealthBar, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.RangeCheck:SetChecked(OPT.ButtonRangeCheck[currentSize])
	GVAR.OptionsFrame.RangeCheck:SetScript("OnClick", function()
		BattlegroundTargets_Options.ButtonRangeCheck[currentSize] = not BattlegroundTargets_Options.ButtonRangeCheck[currentSize]
		                        OPT.ButtonRangeCheck[currentSize] = not                         OPT.ButtonRangeCheck[currentSize]
		GVAR.OptionsFrame.RangeCheck:SetChecked(OPT.ButtonRangeCheck[currentSize])
		if OPT.ButtonRangeCheck[currentSize] then
			TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.RangeCheckTypePullDown)
			GVAR.OptionsFrame.RangeCheckInfo:Enable() Desaturation(GVAR.OptionsFrame.RangeCheckInfo.Texture, false)
			TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.RangeDisplayPullDown)
		else
			TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.RangeCheckTypePullDown)
			GVAR.OptionsFrame.RangeCheckInfo:Disable() Desaturation(GVAR.OptionsFrame.RangeCheckInfo.Texture, true)
			TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.RangeDisplayPullDown)
		end
		BattlegroundTargets:EnableConfigMode()
	end)
	rangeW = rangeW + 10 + GVAR.OptionsFrame.RangeCheck:GetWidth()

	-- range check info
	GVAR.OptionsFrame.RangeCheckInfo = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.RangeCheckInfo:SetWidth(16)
	GVAR.OptionsFrame.RangeCheckInfo:SetHeight(16)
	GVAR.OptionsFrame.RangeCheckInfo:SetPoint("LEFT", GVAR.OptionsFrame.RangeCheck, "RIGHT", 10, 0)
	GVAR.OptionsFrame.RangeCheckInfo.Texture = GVAR.OptionsFrame.RangeCheckInfo:CreateTexture(nil, "ARTWORK")
	GVAR.OptionsFrame.RangeCheckInfo.Texture:SetWidth(16)
	GVAR.OptionsFrame.RangeCheckInfo.Texture:SetHeight(16)
	GVAR.OptionsFrame.RangeCheckInfo.Texture:SetPoint("LEFT", 0, 0)
	GVAR.OptionsFrame.RangeCheckInfo.Texture:SetTexture("Interface\\FriendsFrame\\InformationIcon")
	GVAR.OptionsFrame.RangeCheckInfo.TextFrame = CreateFrame("Frame", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.BorderTRBL(GVAR.OptionsFrame.RangeCheckInfo.TextFrame)
	GVAR.OptionsFrame.RangeCheckInfo.TextFrame:SetToplevel(true)
	GVAR.OptionsFrame.RangeCheckInfo.TextFrame:SetPoint("BOTTOM", GVAR.OptionsFrame.RangeCheckInfo.Texture, "TOP", 0, 0)
	GVAR.OptionsFrame.RangeCheckInfo.TextFrame:Hide()
	GVAR.OptionsFrame.RangeCheckInfo.Text = GVAR.OptionsFrame.RangeCheckInfo.TextFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.RangeCheckInfo.Text:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.RangeCheckInfo.Text:SetJustifyH("LEFT")
	GVAR.OptionsFrame.RangeCheckInfo.Text:SetText(rangeInfoTxt)
	GVAR.OptionsFrame.RangeCheckInfo.Text:SetTextColor(1, 1, 0.49, 1)
	GVAR.OptionsFrame.RangeCheckInfo:SetScript("OnEnter", function() GVAR.OptionsFrame.RangeCheckInfo.TextFrame:Show() end)
	GVAR.OptionsFrame.RangeCheckInfo:SetScript("OnLeave", function() GVAR.OptionsFrame.RangeCheckInfo.TextFrame:Hide() end)
	rangeW = rangeW + 10 + 16
		-----
		local txtWidth = GVAR.OptionsFrame.RangeCheckInfo.Text:GetStringWidth()
		local txtHeight = GVAR.OptionsFrame.RangeCheckInfo.Text:GetStringHeight()
		GVAR.OptionsFrame.RangeCheckInfo.TextFrame:SetWidth(txtWidth+30)
		GVAR.OptionsFrame.RangeCheckInfo.TextFrame:SetHeight(txtHeight+30)
		GVAR.OptionsFrame.RangeCheckInfo.Text:SetWidth(txtWidth+10)
		GVAR.OptionsFrame.RangeCheckInfo.Text:SetHeight(txtHeight+10)
		-----

	-- range type
	GVAR.OptionsFrame.RangeCheckTypePullDown = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.PullDownMenu(
		GVAR.OptionsFrame.RangeCheckTypePullDown,
		"RangeType",
		buttonName,
		-200,
		4,
		function(value) -- PDFUNC
			BattlegroundTargets_Options.ButtonTypeRangeCheck[currentSize] = value
			                        OPT.ButtonTypeRangeCheck[currentSize] = value
		end
	)
	GVAR.OptionsFrame.RangeCheckTypePullDown:SetPoint("LEFT", GVAR.OptionsFrame.RangeCheckInfo, "RIGHT", 10, 0)
	GVAR.OptionsFrame.RangeCheckTypePullDown:SetHeight(18)
	TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.RangeCheckTypePullDown)
	rangeW = rangeW + 10 + GVAR.OptionsFrame.RangeCheckTypePullDown:GetWidth()

	-- range alpha
	GVAR.OptionsFrame.RangeDisplayPullDown = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.PullDownMenu(
		GVAR.OptionsFrame.RangeDisplayPullDown,
		"RangeDisplay",
		rangeDisplay[ BattlegroundTargets_Options.ButtonRangeDisplay[currentSize] ],
		0,
		#rangeDisplay,
		function(value) -- PDFUNC
			BattlegroundTargets_Options.ButtonRangeDisplay[currentSize] = value
			                        OPT.ButtonRangeDisplay[currentSize] = value
			BattlegroundTargets:EnableConfigMode()
		end,
		function(self, button) -- TODO check - potential bug port
			GVAR.OptionsFrame.RangeDisplayPullDown.spookval = OPT.ButtonRangeDisplay[currentSize]
			BattlegroundTargets_Options.ButtonRangeDisplay[currentSize] = self.value1
			                        OPT.ButtonRangeDisplay[currentSize] = self.value1
			BattlegroundTargets:EnableConfigMode()
		end,
		function(self, button) -- TODO check - potential bug port
			BattlegroundTargets_Options.ButtonRangeDisplay[currentSize] = GVAR.OptionsFrame.RangeDisplayPullDown.spookval or self.value1
			                        OPT.ButtonRangeDisplay[currentSize] = GVAR.OptionsFrame.RangeDisplayPullDown.spookval or self.value1
			BattlegroundTargets:EnableConfigMode()
		end
	)
	GVAR.OptionsFrame.RangeDisplayPullDown:SetPoint("LEFT", GVAR.OptionsFrame.RangeCheckTypePullDown, "RIGHT", 10, 0)
	GVAR.OptionsFrame.RangeDisplayPullDown:SetHeight(18)
	TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.RangeDisplayPullDown)
	rangeW = rangeW + 10 + GVAR.OptionsFrame.RangeDisplayPullDown:GetWidth() + 10
	-- ----- range check ----------------------------------------



	-- DUMMY
	GVAR.OptionsFrame.Dummy6 = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "ARTWORK")
	-- BOOM GVAR.OptionsFrame.Dummy6:SetWidth()
	GVAR.OptionsFrame.Dummy6:SetHeight(1)
	GVAR.OptionsFrame.Dummy6:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Dummy6:SetPoint("TOP", GVAR.OptionsFrame.RangeCheck, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.Dummy6:SetTexture(0.73, 0.26, 0.21, 0.5)



	-- sort by
	local sortW = 0
	GVAR.OptionsFrame.SortByTitle = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.SortByTitle:SetHeight(16)
	GVAR.OptionsFrame.SortByTitle:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.SortByTitle:SetPoint("TOP", GVAR.OptionsFrame.Dummy6, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.SortByTitle:SetJustifyH("LEFT")
	GVAR.OptionsFrame.SortByTitle:SetText(L["Sort By"]..":")
	GVAR.OptionsFrame.SortByTitle:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.SortByTitle.Background = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "BACKGROUND")
	GVAR.OptionsFrame.SortByTitle.Background:SetPoint("TOPLEFT", GVAR.OptionsFrame.SortByTitle, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.SortByTitle.Background:SetPoint("BOTTOMRIGHT", GVAR.OptionsFrame.SortByTitle, "BOTTOMRIGHT", 0, 0)
	GVAR.OptionsFrame.SortByTitle.Background:SetTexture(0, 0, 0, 0)
	sortW = sortW + 10 + GVAR.OptionsFrame.SortByTitle:GetStringWidth()

	GVAR.OptionsFrame.SortByPullDown = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.PullDownMenu(
		GVAR.OptionsFrame.SortByPullDown,
		"SortBy",
		sortBy[ OPT.ButtonSortBy[currentSize] ],
		0,
		#sortBy,
		function(value) -- PDFUNC
			BattlegroundTargets_Options.ButtonSortBy[currentSize] = value
			                        OPT.ButtonSortBy[currentSize] = value
			BattlegroundTargets:EnableConfigMode()
		end,
		function(self, button) -- TODO check - potential bug port
			GVAR.OptionsFrame.SortByPullDown.spookval = OPT.ButtonSortBy[currentSize]
			BattlegroundTargets_Options.ButtonSortBy[currentSize] = self.value1
			                        OPT.ButtonSortBy[currentSize] = self.value1
			BattlegroundTargets:EnableConfigMode()
		end,
		function(self, button) -- TODO check - potential bug port
			BattlegroundTargets_Options.ButtonSortBy[currentSize] = GVAR.OptionsFrame.SortByPullDown.spookval or self.value1
			                        OPT.ButtonSortBy[currentSize] = GVAR.OptionsFrame.SortByPullDown.spookval or self.value1
			BattlegroundTargets:EnableConfigMode()
		end
	)
	GVAR.OptionsFrame.SortByPullDown:SetPoint("LEFT", GVAR.OptionsFrame.SortByTitle, "RIGHT", 10, 0)
	GVAR.OptionsFrame.SortByPullDown:SetHeight(18)
	TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.SortByPullDown)
	sortW = sortW + 10 + GVAR.OptionsFrame.SortByPullDown:GetWidth()

	-- sort detail
	GVAR.OptionsFrame.SortDetailPullDown = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.PullDownMenu(
		GVAR.OptionsFrame.SortDetailPullDown,
		"SortDetail",
		sortBy[ OPT.ButtonSortDetail[currentSize] ],
		0,
		#sortDetail,
		function(value) -- PDFUNC
			BattlegroundTargets_Options.ButtonSortDetail[currentSize] = value
			                        OPT.ButtonSortDetail[currentSize] = value
			BattlegroundTargets:EnableConfigMode()
		end,
		function(self, button) -- TODO check - potential bug port
			GVAR.OptionsFrame.SortDetailPullDown.spookval = OPT.ButtonSortDetail[currentSize]
			BattlegroundTargets_Options.ButtonSortDetail[currentSize] = self.value1
			                        OPT.ButtonSortDetail[currentSize] = self.value1
			BattlegroundTargets:EnableConfigMode()
		end,
		function(self, button) -- TODO check - potential bug port
			BattlegroundTargets_Options.ButtonSortDetail[currentSize] = GVAR.OptionsFrame.SortDetailPullDown.spookval or self.value1
			                        OPT.ButtonSortDetail[currentSize] = GVAR.OptionsFrame.SortDetailPullDown.spookval or self.value1
			BattlegroundTargets:EnableConfigMode()
		end
	)
	GVAR.OptionsFrame.SortDetailPullDown:SetPoint("LEFT", GVAR.OptionsFrame.SortByPullDown, "RIGHT", 10, 0)
	GVAR.OptionsFrame.SortDetailPullDown:SetHeight(18)
	TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.SortDetailPullDown)
	sortW = sortW + 10 + GVAR.OptionsFrame.SortDetailPullDown:GetWidth()

	-- sort info
		----- text
		local infoTxt1 = sortDetail[1]..":\n"
		table_sort(class_IntegerSort, function(a, b) return a.loc < b.loc end)
		for i = 1, #class_IntegerSort do
			infoTxt1 = infoTxt1.." |cff"..ClassHexColor(class_IntegerSort[i].cid)..class_IntegerSort[i].loc.."|r"
			if i <= #class_IntegerSort then
				infoTxt1 = infoTxt1.."\n"
			end
		end
		local infoTxt2 = sortDetail[2]..":\n"
		table_sort(class_IntegerSort, function(a, b) return a.eng < b.eng end)
		for i = 1, #class_IntegerSort do
			infoTxt2 = infoTxt2.." |cff"..ClassHexColor(class_IntegerSort[i].cid)..class_IntegerSort[i].eng.." ("..class_IntegerSort[i].loc..")|r"
			if i <= #class_IntegerSort then
				infoTxt2 = infoTxt2.."\n"
			end
		end
		local infoTxt3 = sortDetail[3]..":\n"
		table_sort(class_IntegerSort, function(a, b) return a.blizz < b.blizz end)
		for i = 1, #class_IntegerSort do
			infoTxt3 = infoTxt3.." |cff"..ClassHexColor(class_IntegerSort[i].cid)..class_IntegerSort[i].loc.."|r"
			if i <= #class_IntegerSort then
				infoTxt3 = infoTxt3.."\n"
			end
		end
		----- text
	GVAR.OptionsFrame.SortInfo = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.SortInfo:SetWidth(16)
	GVAR.OptionsFrame.SortInfo:SetHeight(16)
	GVAR.OptionsFrame.SortInfo:SetPoint("LEFT", GVAR.OptionsFrame.SortDetailPullDown, "RIGHT", 10, 0)
	GVAR.OptionsFrame.SortInfo.Texture = GVAR.OptionsFrame.SortInfo:CreateTexture(nil, "ARTWORK")
	GVAR.OptionsFrame.SortInfo.Texture:SetWidth(16)
	GVAR.OptionsFrame.SortInfo.Texture:SetHeight(16)
	GVAR.OptionsFrame.SortInfo.Texture:SetPoint("LEFT", 0, 0)
	GVAR.OptionsFrame.SortInfo.Texture:SetTexture("Interface\\FriendsFrame\\InformationIcon")
	GVAR.OptionsFrame.SortInfo.TextFrame = CreateFrame("Frame", nil, GVAR.OptionsFrame.SortInfo)
	TEMPLATE.BorderTRBL(GVAR.OptionsFrame.SortInfo.TextFrame)
	GVAR.OptionsFrame.SortInfo.TextFrame:SetToplevel(true)
	GVAR.OptionsFrame.SortInfo.TextFrame:SetPoint("BOTTOM", GVAR.OptionsFrame.SortInfo.Texture, "TOP", 0, 0)
	GVAR.OptionsFrame.SortInfo.TextFrame:Hide()
	GVAR.OptionsFrame.SortInfo.Text1 = GVAR.OptionsFrame.SortInfo.TextFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.SortInfo.Text1:SetPoint("TOPLEFT", GVAR.OptionsFrame.SortInfo.TextFrame, "TOPLEFT", 10, -10)
	GVAR.OptionsFrame.SortInfo.Text1:SetJustifyH("LEFT")
	GVAR.OptionsFrame.SortInfo.Text1:SetText(infoTxt1)
	GVAR.OptionsFrame.SortInfo.Text1:SetTextColor(1, 1, 0.49, 1)
	GVAR.OptionsFrame.SortInfo.Text2 = GVAR.OptionsFrame.SortInfo.TextFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.SortInfo.Text2:SetPoint("LEFT", GVAR.OptionsFrame.SortInfo.Text1, "RIGHT", 0, 0)
	GVAR.OptionsFrame.SortInfo.Text2:SetJustifyH("LEFT")
	GVAR.OptionsFrame.SortInfo.Text2:SetText(infoTxt2)
	GVAR.OptionsFrame.SortInfo.Text2:SetTextColor(1, 1, 0.49, 1)
	GVAR.OptionsFrame.SortInfo.Text3 = GVAR.OptionsFrame.SortInfo.TextFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.SortInfo.Text3:SetPoint("LEFT", GVAR.OptionsFrame.SortInfo.Text2, "RIGHT", 0, 0)
	GVAR.OptionsFrame.SortInfo.Text3:SetJustifyH("LEFT")
	GVAR.OptionsFrame.SortInfo.Text3:SetText(infoTxt3)
	GVAR.OptionsFrame.SortInfo.Text3:SetTextColor(1, 1, 0.49, 1)
	GVAR.OptionsFrame.SortInfo:SetScript("OnEnter", function() GVAR.OptionsFrame.SortInfo.TextFrame:Show() end)
	GVAR.OptionsFrame.SortInfo:SetScript("OnLeave", function() GVAR.OptionsFrame.SortInfo.TextFrame:Hide() end)
		-----
		local txtWidth1 = GVAR.OptionsFrame.SortInfo.Text1:GetStringWidth()
		local txtWidth2 = GVAR.OptionsFrame.SortInfo.Text2:GetStringWidth()
		local txtWidth3 = GVAR.OptionsFrame.SortInfo.Text3:GetStringWidth()
		GVAR.OptionsFrame.SortInfo.Text1:SetWidth(txtWidth1+10)
		GVAR.OptionsFrame.SortInfo.Text2:SetWidth(txtWidth2+10)
		GVAR.OptionsFrame.SortInfo.Text3:SetWidth(txtWidth3+10)
		GVAR.OptionsFrame.SortInfo.TextFrame:SetWidth(10+ txtWidth1+10 + txtWidth2+10 + txtWidth3+10 +10)
		local txtHeight = GVAR.OptionsFrame.SortInfo.Text1:GetStringHeight()
		GVAR.OptionsFrame.SortInfo.Text1:SetHeight(txtHeight+10)
		GVAR.OptionsFrame.SortInfo.Text2:SetHeight(txtHeight+10)
		GVAR.OptionsFrame.SortInfo.Text3:SetHeight(txtHeight+10)
		GVAR.OptionsFrame.SortInfo.TextFrame:SetHeight(10+ txtHeight+10 +10)
		-----
	sortW = sortW + 10 + 16 +10



	-- DUMMY
	GVAR.OptionsFrame.Dummy7 = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "ARTWORK")
	-- BOOM GVAR.OptionsFrame.Dummy7:SetWidth()
	GVAR.OptionsFrame.Dummy7:SetHeight(1)
	GVAR.OptionsFrame.Dummy7:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Dummy7:SetPoint("TOP", GVAR.OptionsFrame.SortByTitle, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.Dummy7:SetTexture(0.73, 0.26, 0.21, 0.5)



	-- font name
	GVAR.OptionsFrame.FontNameTitle = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.FontNameTitle:SetHeight(16)
	GVAR.OptionsFrame.FontNameTitle:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.FontNameTitle:SetPoint("TOP", GVAR.OptionsFrame.Dummy7, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.FontNameTitle:SetJustifyH("LEFT")
	GVAR.OptionsFrame.FontNameTitle:SetText(L["Text"]..": "..L["Name"])
	GVAR.OptionsFrame.FontNameTitle:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.FontNameTitle.Background = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "BACKGROUND")
	GVAR.OptionsFrame.FontNameTitle.Background:SetPoint("TOPLEFT", GVAR.OptionsFrame.FontNameTitle, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.FontNameTitle.Background:SetPoint("BOTTOMRIGHT", GVAR.OptionsFrame.FontNameTitle, "BOTTOMRIGHT", 0, 0)
	GVAR.OptionsFrame.FontNameTitle.Background:SetTexture(0, 0, 0, 0)

	-- font name size
	GVAR.OptionsFrame.FontNameSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.Slider(GVAR.OptionsFrame.FontNameSlider, 80, 1, 5, 20, OPT.ButtonFontNameSize[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.ButtonFontNameSize[currentSize] then return end
		BattlegroundTargets_Options.ButtonFontNameSize[currentSize] = value
		                        OPT.ButtonFontNameSize[currentSize] = value
		GVAR.OptionsFrame.FontNameValue:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.FontNameSlider:SetPoint("LEFT", GVAR.OptionsFrame.FontNameTitle, "RIGHT", 10, 0)

	GVAR.OptionsFrame.FontNameValue = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.FontNameValue:SetHeight(20)
	GVAR.OptionsFrame.FontNameValue:SetPoint("LEFT", GVAR.OptionsFrame.FontNameSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.FontNameValue:SetJustifyH("LEFT")
	GVAR.OptionsFrame.FontNameValue:SetText(OPT.ButtonFontNameSize[currentSize])
	GVAR.OptionsFrame.FontNameValue:SetTextColor(1, 1, 0.49, 1)

	-- font name style
	GVAR.OptionsFrame.FontNamePullDown = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.PullDownMenu(
		GVAR.OptionsFrame.FontNamePullDown,
		"FontStyle",
		fontStyles[ OPT.ButtonFontNameStyle[currentSize] ].name,
		0,
		#fontStyles,
		function(value) -- PDFUNC
			BattlegroundTargets_Options.ButtonFontNameStyle[currentSize] = value
			                        OPT.ButtonFontNameStyle[currentSize] = value
			BattlegroundTargets:EnableConfigMode()
		end,
		function(self, button)
			BattlegroundTargets:LocalizedFontNameTest(true, self.value1)
		end,
		function(self, button)
			BattlegroundTargets:LocalizedFontNameTest(false, true)
		end
	)
	GVAR.OptionsFrame.FontNamePullDown:SetPoint("LEFT", GVAR.OptionsFrame.FontNameSlider, "RIGHT", 30, 0)
	GVAR.OptionsFrame.FontNamePullDown:SetHeight(18)
	TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.FontNamePullDown)

	GVAR.OptionsFrame.FontNameInfo = GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.FontNameInfo:SetHeight(16)
	GVAR.OptionsFrame.FontNameInfo:SetPoint("TOP", GVAR.OptionsFrame.FontNamePullDown.PullDownMenu, "BOTTOM", 0, -2)
	GVAR.OptionsFrame.FontNameInfo:SetJustifyH("CENTER")
	GVAR.OptionsFrame.FontNameInfo:SetText(CTRL_KEY_TEXT.." "..SHIFT_KEY_TEXT.." "..ALT_KEY)
	GVAR.OptionsFrame.FontNameInfo:SetTextColor(0.5, 0.5, 0.5, 1)

	GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:SetPropagateKeyboardInput(true)
	GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:SetScript("OnKeyDown", function(self, key)
		if key == "LSHIFT" or key == "RSHIFT" or key == "LCTRL" or key == "RCTRL" or key == "LALT" or key == "RALT" then
			GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:SetPropagateKeyboardInput(false)
			BattlegroundTargets:LocalizedFontNameTest(false, false)
		end
	end)
	GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:SetScript("OnKeyUp", function(self, key)
		GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:SetPropagateKeyboardInput(true)
		BattlegroundTargets:LocalizedFontNameTest(true, false)
	end)

	local oldOnEnter = GVAR.OptionsFrame.FontNamePullDown:GetScript("OnEnter")
	local oldOnLeave = GVAR.OptionsFrame.FontNamePullDown:GetScript("OnLeave")
	GVAR.OptionsFrame.FontNamePullDown:SetScript("OnEnter", function(self)
		BattlegroundTargets:LocalizedFontNameTest(true)
		if oldOnEnter then oldOnEnter() end
	end)
	GVAR.OptionsFrame.FontNamePullDown:SetScript("OnLeave", function(self)
		BattlegroundTargets:LocalizedFontNameTest(false, true)
		if oldOnLeave then oldOnLeave() end
	end)	
	local oldOnEnter = GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:GetScript("OnEnter")
	local oldOnLeave = GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:GetScript("OnLeave")
	GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:SetScript("OnEnter", function(self)
		BattlegroundTargets:LocalizedFontNameTest(true)
		if oldOnEnter then oldOnEnter() end
	end)
	GVAR.OptionsFrame.FontNamePullDown.PullDownMenu:SetScript("OnLeave", function(self)
		BattlegroundTargets:LocalizedFontNameTest(false, true)
		if oldOnLeave then oldOnLeave() end
	end)

	-- font number
	GVAR.OptionsFrame.FontNumberTitle = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.FontNumberTitle:SetHeight(16)
	GVAR.OptionsFrame.FontNumberTitle:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.FontNumberTitle:SetPoint("TOP", GVAR.OptionsFrame.FontNameSlider, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.FontNumberTitle:SetJustifyH("LEFT")
	GVAR.OptionsFrame.FontNumberTitle:SetText(L["Text"]..": "..L["Number"])
	GVAR.OptionsFrame.FontNumberTitle:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.FontNumberTitle.Background = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "BACKGROUND")
	GVAR.OptionsFrame.FontNumberTitle.Background:SetPoint("TOPLEFT", GVAR.OptionsFrame.FontNumberTitle, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.FontNumberTitle.Background:SetPoint("BOTTOMRIGHT", GVAR.OptionsFrame.FontNumberTitle, "BOTTOMRIGHT", 0, 0)
	GVAR.OptionsFrame.FontNumberTitle.Background:SetTexture(0, 0, 0, 0)

	-- font number size
	GVAR.OptionsFrame.FontNumberSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.Slider(GVAR.OptionsFrame.FontNumberSlider, 80, 1, 5, 20, OPT.ButtonFontNumberSize[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.ButtonFontNumberSize[currentSize] then return end
		BattlegroundTargets_Options.ButtonFontNumberSize[currentSize] = value
		                        OPT.ButtonFontNumberSize[currentSize] = value
		GVAR.OptionsFrame.FontNumberValue:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.FontNumberSlider:SetPoint("LEFT", GVAR.OptionsFrame.FontNumberTitle, "RIGHT", 10, 0)

	GVAR.OptionsFrame.FontNumberValue = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.FontNumberValue:SetHeight(20)
	GVAR.OptionsFrame.FontNumberValue:SetPoint("LEFT", GVAR.OptionsFrame.FontNumberSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.FontNumberValue:SetJustifyH("LEFT")
	GVAR.OptionsFrame.FontNumberValue:SetText(OPT.ButtonFontNumberSize[currentSize])
	GVAR.OptionsFrame.FontNumberValue:SetTextColor(1, 1, 0.49, 1)

	-- font number style
	GVAR.OptionsFrame.FontNumberPullDown = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.PullDownMenu(
		GVAR.OptionsFrame.FontNumberPullDown,
		"FontStyleNumber",
		strmatch(fontStyles[ OPT.ButtonFontNumberStyle[currentSize] ].name, "(.*) %- .*"),
		0,
		#fontStyles,
		function(value) -- PDFUNC
			BattlegroundTargets_Options.ButtonFontNumberStyle[currentSize] = value
			                        OPT.ButtonFontNumberStyle[currentSize] = value
			BattlegroundTargets:EnableConfigMode()
		end,
		function(self, button)
			BattlegroundTargets:LocalizedFontNumberTest(true, self.value1)
		end,
		function(self, button)
			BattlegroundTargets:LocalizedFontNumberTest(false)
		end
	)
	GVAR.OptionsFrame.FontNumberPullDown:SetPoint("LEFT", GVAR.OptionsFrame.FontNumberSlider, "RIGHT", 30, 0)
	GVAR.OptionsFrame.FontNumberPullDown:SetHeight(18)
	TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.FontNumberPullDown)

	local oldOnLeave = GVAR.OptionsFrame.FontNumberPullDown:GetScript("OnLeave")
	GVAR.OptionsFrame.FontNumberPullDown:SetScript("OnLeave", function(self)
		BattlegroundTargets:LocalizedFontNumberTest(false)
		if oldOnLeave then oldOnLeave() end
	end)	
	local oldOnLeave = GVAR.OptionsFrame.FontNumberPullDown.PullDownMenu:GetScript("OnLeave")
	GVAR.OptionsFrame.FontNumberPullDown.PullDownMenu:SetScript("OnLeave", function(self)
		BattlegroundTargets:LocalizedFontNumberTest(false)
		if oldOnLeave then oldOnLeave() end
	end)

	local eq, sw = 0, 0
	sw = GVAR.OptionsFrame.FontNameTitle:GetStringWidth() if sw > eq then eq = sw end
	sw = GVAR.OptionsFrame.FontNumberTitle:GetStringWidth() if sw > eq then eq = sw end
	GVAR.OptionsFrame.FontNameSlider:SetPoint("LEFT", GVAR.OptionsFrame.FontNameTitle, "LEFT", eq+10, 0)
	GVAR.OptionsFrame.FontNumberSlider:SetPoint("LEFT", GVAR.OptionsFrame.FontNumberTitle, "LEFT", eq+10, 0)

	local fontstyleW = 10+ eq+10 + GVAR.OptionsFrame.FontNameSlider:GetWidth() + 30 + GVAR.OptionsFrame.FontNamePullDown:GetWidth() + 10



	-- DUMMY
	GVAR.OptionsFrame.Dummy8 = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "ARTWORK")
	-- BOOM GVAR.OptionsFrame.Dummy8:SetWidth()
	GVAR.OptionsFrame.Dummy8:SetHeight(1)
	GVAR.OptionsFrame.Dummy8:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Dummy8:SetPoint("TOP", GVAR.OptionsFrame.FontNumberSlider, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.Dummy8:SetTexture(0.73, 0.26, 0.21, 0.5)



	-- scale
	GVAR.OptionsFrame.ScaleTitle = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.ScaleSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.ScaleValue = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.ScaleTitle:SetHeight(16)
	GVAR.OptionsFrame.ScaleTitle:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.ScaleTitle:SetPoint("TOP", GVAR.OptionsFrame.Dummy8, "BOTTOM", 0, -8)
	GVAR.OptionsFrame.ScaleTitle:SetJustifyH("LEFT")
	GVAR.OptionsFrame.ScaleTitle:SetText(L["Scale"]..":")
	GVAR.OptionsFrame.ScaleTitle:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.ScaleTitle.Background = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "BACKGROUND")
	GVAR.OptionsFrame.ScaleTitle.Background:SetPoint("TOPLEFT", GVAR.OptionsFrame.ScaleTitle, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.ScaleTitle.Background:SetPoint("BOTTOMRIGHT", GVAR.OptionsFrame.ScaleTitle, "BOTTOMRIGHT", 0, 0)
	GVAR.OptionsFrame.ScaleTitle.Background:SetTexture(0, 0, 0, 0)
	TEMPLATE.Slider(GVAR.OptionsFrame.ScaleSlider, 180, 5, 50, 200, OPT.ButtonScale[currentSize]*100,
	function(self, value)
		local nvalue = value/100
		if nvalue == BattlegroundTargets_Options.ButtonScale[currentSize] then return end
		BattlegroundTargets_Options.ButtonScale[currentSize] = nvalue
		                        OPT.ButtonScale[currentSize] = nvalue
		GVAR.OptionsFrame.ScaleValue:SetText(value.."%")
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.ScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ScaleTitle, "RIGHT", 20, 0)
	GVAR.OptionsFrame.ScaleValue:SetHeight(20)
	GVAR.OptionsFrame.ScaleValue:SetPoint("LEFT", GVAR.OptionsFrame.ScaleSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.ScaleValue:SetJustifyH("LEFT")
	GVAR.OptionsFrame.ScaleValue:SetText((OPT.ButtonScale[currentSize]*100).."%")
	GVAR.OptionsFrame.ScaleValue:SetTextColor(1, 1, 0.49, 1)

	-- width
	GVAR.OptionsFrame.WidthTitle = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.WidthSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.WidthValue = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.WidthTitle:SetHeight(16)
	GVAR.OptionsFrame.WidthTitle:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.WidthTitle:SetPoint("TOP", GVAR.OptionsFrame.ScaleSlider, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.WidthTitle:SetJustifyH("LEFT")
	GVAR.OptionsFrame.WidthTitle:SetText(L["Width"]..":")
	GVAR.OptionsFrame.WidthTitle:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.WidthTitle.Background = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "BACKGROUND")
	GVAR.OptionsFrame.WidthTitle.Background:SetPoint("TOPLEFT", GVAR.OptionsFrame.WidthTitle, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.WidthTitle.Background:SetPoint("BOTTOMRIGHT", GVAR.OptionsFrame.WidthTitle, "BOTTOMRIGHT", 0, 0)
	GVAR.OptionsFrame.WidthTitle.Background:SetTexture(0, 0, 0, 0)
	TEMPLATE.Slider(GVAR.OptionsFrame.WidthSlider, 180, 5, 50, 300, OPT.ButtonWidth[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.ButtonWidth[currentSize] then return end
		BattlegroundTargets_Options.ButtonWidth[currentSize] = value
		                        OPT.ButtonWidth[currentSize] = value
		GVAR.OptionsFrame.WidthValue:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.WidthSlider:SetPoint("LEFT", GVAR.OptionsFrame.WidthTitle, "RIGHT", 20, 0)
	GVAR.OptionsFrame.WidthValue:SetHeight(20)
	GVAR.OptionsFrame.WidthValue:SetPoint("LEFT", GVAR.OptionsFrame.WidthSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.WidthValue:SetJustifyH("LEFT")
	GVAR.OptionsFrame.WidthValue:SetText(OPT.ButtonWidth[currentSize])
	GVAR.OptionsFrame.WidthValue:SetTextColor(1, 1, 0.49, 1)

	-- height
	GVAR.OptionsFrame.HeightTitle = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.HeightSlider = CreateFrame("Slider", nil, GVAR.OptionsFrame.ConfigBrackets)
	GVAR.OptionsFrame.HeightValue = GVAR.OptionsFrame.ConfigBrackets:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.HeightTitle:SetHeight(16)
	GVAR.OptionsFrame.HeightTitle:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.HeightTitle:SetPoint("TOP", GVAR.OptionsFrame.WidthTitle, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.HeightTitle:SetJustifyH("LEFT")
	GVAR.OptionsFrame.HeightTitle:SetText(L["Height"]..":")
	GVAR.OptionsFrame.HeightTitle:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.HeightTitle.Background = GVAR.OptionsFrame.ConfigBrackets:CreateTexture(nil, "BACKGROUND")
	GVAR.OptionsFrame.HeightTitle.Background:SetPoint("TOPLEFT", GVAR.OptionsFrame.HeightTitle, "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.HeightTitle.Background:SetPoint("BOTTOMRIGHT", GVAR.OptionsFrame.HeightTitle, "BOTTOMRIGHT", 0, 0)
	GVAR.OptionsFrame.HeightTitle.Background:SetTexture(0, 0, 0, 0)
	TEMPLATE.Slider(GVAR.OptionsFrame.HeightSlider, 180, 1, 10, 30, OPT.ButtonHeight[currentSize],
	function(self, value)
		if value == BattlegroundTargets_Options.ButtonHeight[currentSize] then return end
		BattlegroundTargets_Options.ButtonHeight[currentSize] = value
		                        OPT.ButtonHeight[currentSize] = value
		GVAR.OptionsFrame.HeightValue:SetText(value)
		BattlegroundTargets:EnableConfigMode()
	end,
	"blank")
	GVAR.OptionsFrame.HeightSlider:SetPoint("LEFT", GVAR.OptionsFrame.HeightTitle, "RIGHT", 20, 0)
	GVAR.OptionsFrame.HeightValue:SetHeight(20)
	GVAR.OptionsFrame.HeightValue:SetPoint("LEFT", GVAR.OptionsFrame.HeightSlider, "RIGHT", 5, 0)
	GVAR.OptionsFrame.HeightValue:SetJustifyH("LEFT")
	GVAR.OptionsFrame.HeightValue:SetText(OPT.ButtonHeight[currentSize])
	GVAR.OptionsFrame.HeightValue:SetTextColor(1, 1, 0.49, 1)

	local equalTextWidthSliders, sw = 0, 0
	sw = GVAR.OptionsFrame.ScaleTitle:GetStringWidth() if sw > equalTextWidthSliders then equalTextWidthSliders = sw end
	sw = GVAR.OptionsFrame.WidthTitle:GetStringWidth() if sw > equalTextWidthSliders then equalTextWidthSliders = sw end
	sw = GVAR.OptionsFrame.HeightTitle:GetStringWidth() if sw > equalTextWidthSliders then equalTextWidthSliders = sw end
	GVAR.OptionsFrame.ScaleSlider:SetPoint("LEFT", GVAR.OptionsFrame.ScaleTitle, "LEFT", equalTextWidthSliders+10, 0)
	GVAR.OptionsFrame.WidthSlider:SetPoint("LEFT", GVAR.OptionsFrame.WidthTitle, "LEFT", equalTextWidthSliders+10, 0)
	GVAR.OptionsFrame.HeightSlider:SetPoint("LEFT", GVAR.OptionsFrame.HeightTitle, "LEFT", equalTextWidthSliders+10, 0)

	-- testshuffler
	GVAR.OptionsFrame.TestShuffler = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
	BattlegroundTargets.shuffleStyle = true
	GVAR.OptionsFrame.TestShuffler:SetPoint("BOTTOM", GVAR.OptionsFrame.HeightSlider, "BOTTOM", 0, 0)
	GVAR.OptionsFrame.TestShuffler:SetPoint("RIGHT", GVAR.OptionsFrame, "RIGHT", -10, 0)
	GVAR.OptionsFrame.TestShuffler:SetWidth(32)
	GVAR.OptionsFrame.TestShuffler:SetHeight(32)
	GVAR.OptionsFrame.TestShuffler:Hide()
	GVAR.OptionsFrame.TestShuffler:SetScript("OnClick", function() BattlegroundTargets:ShufflerFunc("OnClick") end)
	GVAR.OptionsFrame.TestShuffler:SetScript("OnEnter", function() BattlegroundTargets:ShufflerFunc("OnEnter") end)
	GVAR.OptionsFrame.TestShuffler:SetScript("OnLeave", function() BattlegroundTargets:ShufflerFunc("OnLeave") end)
	GVAR.OptionsFrame.TestShuffler:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then BattlegroundTargets:ShufflerFunc("OnMouseDown") end
	end)
	GVAR.OptionsFrame.TestShuffler.Texture = GVAR.OptionsFrame.TestShuffler:CreateTexture(nil, "ARTWORK")
	GVAR.OptionsFrame.TestShuffler.Texture:SetWidth(32)
	GVAR.OptionsFrame.TestShuffler.Texture:SetHeight(32)
	GVAR.OptionsFrame.TestShuffler.Texture:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.TestShuffler.Texture:SetTexture("Interface\\Icons\\INV_Sigil_Thorim")
	GVAR.OptionsFrame.TestShuffler:SetNormalTexture(GVAR.OptionsFrame.TestShuffler.Texture)
	GVAR.OptionsFrame.TestShuffler.TextureHighlight = GVAR.OptionsFrame.TestShuffler:CreateTexture(nil, "OVERLAY")
	GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetWidth(32)
	GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetHeight(32)
	GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetPoint("CENTER", 0, 0)
	GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
	GVAR.OptionsFrame.TestShuffler:SetHighlightTexture(GVAR.OptionsFrame.TestShuffler.TextureHighlight)

	-- bg information
	local numButtons = 0
	local x = 0 for i = 1, #bgInfo[10] do x = x + 1 end numButtons = x
	      x = 0 for i = 1, #bgInfo[15] do x = x + 1 end if x > numButtons then numButtons = x end
	      x = 0 for i = 1, #bgInfo[40] do x = x + 1 end if x > numButtons then numButtons = x end

	GVAR.OptionsFrame.ConfigBrackets.BGinformation = {}
	for i = 1, numButtons do
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i] = CreateFrame("Button", nil, GVAR.OptionsFrame.ConfigBrackets)
		if i == 1 then
			GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:SetPoint("TOPRIGHT", GVAR.OptionsFrame.ConfigBrackets, "TOPRIGHT", -10, -10)
		else
			GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:SetPoint("TOP", GVAR.OptionsFrame.ConfigBrackets.BGinformation[i-1], "BOTTOM", 0, 0)
		end
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:SetWidth(42)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:SetHeight(42)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Background = GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:CreateTexture(nil, "BACKGROUND")
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Background:SetWidth(42)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Background:SetHeight(42)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Background:SetPoint("TOPRIGHT", 0, 0)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Background:SetTexture(0, 0, 0, 1)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureBorder = GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:CreateTexture(nil, "ARTWORK")
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureBorder:SetWidth(48)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureBorder:SetHeight(48)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureBorder:SetPoint("BOTTOMRIGHT", 8, 2)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureBorder:SetTexture("Interface\\PVPFrame\\SilverIconBorder")
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Texture = GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:CreateTexture(nil, "BORDER")
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Texture:SetWidth(32)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Texture:SetHeight(32)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Texture:SetPoint("TOPRIGHT", 0, 0)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureHighlight = GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:CreateTexture(nil, "OVERLAY")
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureHighlight:SetWidth(32)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureHighlight:SetHeight(32)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureHighlight:SetPoint("TOPRIGHT", 0, 0)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureHighlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:SetHighlightTexture(GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].TextureHighlight)

		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:SetScript("OnEnter", function(self)
			local bgName = self.bginfo
			GVAR.OptionsFrame.ConfigBrackets.BGdata.Texture:SetTexture(bgMaps[bgName].icon)
			GVAR.OptionsFrame.ConfigBrackets.BGdata.Title:SetText(bgName)
			GVAR.OptionsFrame.ConfigBrackets.BGdata.GameType:SetText(bgMaps[bgName].gameType)
			GVAR.OptionsFrame.ConfigBrackets.BGdata:Show()
		end)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:SetScript("OnLeave", function()
			GVAR.OptionsFrame.ConfigBrackets.BGdata:Hide()
		end)
	end

	GVAR.OptionsFrame.ConfigBrackets.BGdata = CreateFrame("Frame", nil, GVAR.OptionsFrame.ConfigBrackets)
	TEMPLATE.BorderTRBL(GVAR.OptionsFrame.ConfigBrackets.BGdata)
	GVAR.OptionsFrame.ConfigBrackets.BGdata:SetWidth(250)
	GVAR.OptionsFrame.ConfigBrackets.BGdata:SetHeight(150)
	GVAR.OptionsFrame.ConfigBrackets.BGdata:SetPoint("TOPRIGHT", GVAR.OptionsFrame.ConfigBrackets.BGinformation[1], "TOPLEFT", 0, 0)
	GVAR.OptionsFrame.ConfigBrackets.BGdata:SetToplevel(true)
	GVAR.OptionsFrame.ConfigBrackets.BGdata:Hide()
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Title = GVAR.OptionsFrame.ConfigBrackets.BGdata:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Title:SetWidth(300)
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Title:SetPoint("TOP", GVAR.OptionsFrame.ConfigBrackets.BGdata, "TOP", 0, -5)
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Title:SetJustifyH("CENTER")
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Title:SetTextColor(1, 1, 0, 1)
	GVAR.OptionsFrame.ConfigBrackets.BGdata.GameType = GVAR.OptionsFrame.ConfigBrackets.BGdata:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.ConfigBrackets.BGdata.GameType:SetWidth(300)
	GVAR.OptionsFrame.ConfigBrackets.BGdata.GameType:SetPoint("TOP", GVAR.OptionsFrame.ConfigBrackets.BGdata.Title, "BOTTOM", 0, -5)
	GVAR.OptionsFrame.ConfigBrackets.BGdata.GameType:SetJustifyH("CENTER")
	GVAR.OptionsFrame.ConfigBrackets.BGdata.GameType:SetTextColor(1, 1, 1, 1)
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Texture = GVAR.OptionsFrame.ConfigBrackets.BGdata:CreateTexture(nil, "ARTWORK")
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Texture:SetWidth(100)
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Texture:SetHeight(100)
	GVAR.OptionsFrame.ConfigBrackets.BGdata.Texture:SetPoint("TOP", GVAR.OptionsFrame.ConfigBrackets.BGdata.GameType, "BOTTOM", 0, -5)

	    if currentSize == 10 then BattlegroundTargets:BGInfo(10)
	elseif currentSize == 15 then BattlegroundTargets:BGInfo(15)
	elseif currentSize == 40 then BattlegroundTargets:BGInfo(40) end
	-- ###
	-- ####################################################################################################



	-- ####################################################################################################
	-- xMx ConfigGeneral
	GVAR.OptionsFrame.ConfigGeneral = CreateFrame("Frame", nil, GVAR.OptionsFrame)
	-- BOOM GVAR.OptionsFrame.ConfigGeneral:SetWidth()
	GVAR.OptionsFrame.ConfigGeneral:SetHeight(heightBracket)
	GVAR.OptionsFrame.ConfigGeneral:SetPoint("TOPLEFT", GVAR.OptionsFrame.Base, "BOTTOMLEFT", 0, 1)
	GVAR.OptionsFrame.ConfigGeneral:Hide()

	GVAR.OptionsFrame.GeneralTitle = GVAR.OptionsFrame.ConfigGeneral:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	GVAR.OptionsFrame.GeneralTitle:SetHeight(20)
	GVAR.OptionsFrame.GeneralTitle:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.GeneralTitle:SetPoint("TOPLEFT", GVAR.OptionsFrame.ConfigGeneral, "TOPLEFT", 10, -10)
	GVAR.OptionsFrame.GeneralTitle:SetJustifyH("LEFT")
	GVAR.OptionsFrame.GeneralTitle:SetText(L["General Settings"]..":")

	-- minimap button
	GVAR.OptionsFrame.Minimap = CreateFrame("CheckButton", nil, GVAR.OptionsFrame.ConfigGeneral)
	TEMPLATE.CheckButton(GVAR.OptionsFrame.Minimap, 16, 4, L["Show Minimap-Button"])
	GVAR.OptionsFrame.Minimap:SetPoint("LEFT", GVAR.OptionsFrame, "LEFT", 10, 0)
	GVAR.OptionsFrame.Minimap:SetPoint("TOP", GVAR.OptionsFrame.GeneralTitle, "BOTTOM", 0, -10)
	GVAR.OptionsFrame.Minimap:SetChecked(BattlegroundTargets_Options.MinimapButton)
	TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.Minimap)
	GVAR.OptionsFrame.Minimap:SetScript("OnClick", function()
		BattlegroundTargets_Options.MinimapButton = not BattlegroundTargets_Options.MinimapButton
		BattlegroundTargets:CreateMinimapButton()
	end)
	-- ###
	-- ####################################################################################################



	-- ####################################################################################################
	-- xMx Mover
	GVAR.OptionsFrame.MoverTop = CreateFrame("Frame", nil, GVAR.OptionsFrame)
	TEMPLATE.BorderTRBL(GVAR.OptionsFrame.MoverTop)
	-- BOOM GVAR.OptionsFrame.MoverTop:SetWidth()
	GVAR.OptionsFrame.MoverTop:SetHeight(20)
	GVAR.OptionsFrame.MoverTop:SetPoint("BOTTOM", GVAR.OptionsFrame, "TOP", 0, -1)
	GVAR.OptionsFrame.MoverTop:EnableMouse(true)
	GVAR.OptionsFrame.MoverTop:EnableMouseWheel(true)
	GVAR.OptionsFrame.MoverTop:SetScript("OnMouseWheel", NOOP)
	GVAR.OptionsFrame.MoverTopText = GVAR.OptionsFrame.MoverTop:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.MoverTopText:SetPoint("CENTER", GVAR.OptionsFrame.MoverTop, "CENTER", 0, 0)
	GVAR.OptionsFrame.MoverTopText:SetJustifyH("CENTER")
	GVAR.OptionsFrame.MoverTopText:SetTextColor(0.3, 0.3, 0.3, 1)
	GVAR.OptionsFrame.MoverTopText:SetText(L["click & move"])

	GVAR.OptionsFrame.Close = CreateFrame("Button", nil, GVAR.OptionsFrame.MoverTop)
	TEMPLATE.IconButton(GVAR.OptionsFrame.Close, 1)
	GVAR.OptionsFrame.Close:SetWidth(20)
	GVAR.OptionsFrame.Close:SetHeight(20)
	GVAR.OptionsFrame.Close:SetPoint("RIGHT", GVAR.OptionsFrame.MoverTop, "RIGHT", 0, 0)
	GVAR.OptionsFrame.Close:SetScript("OnClick", function() GVAR.OptionsFrame:Hide() end)

	GVAR.OptionsFrame.MoverBottom = CreateFrame("Frame", nil, GVAR.OptionsFrame)
	TEMPLATE.BorderTRBL(GVAR.OptionsFrame.MoverBottom)
	-- BOOM GVAR.OptionsFrame.MoverBottom:SetWidth()
	GVAR.OptionsFrame.MoverBottom:SetHeight(20)
	GVAR.OptionsFrame.MoverBottom:SetPoint("TOP", GVAR.OptionsFrame, "BOTTOM", 0, 1)
	GVAR.OptionsFrame.MoverBottom:EnableMouse(true)
	GVAR.OptionsFrame.MoverBottom:EnableMouseWheel(true)
	GVAR.OptionsFrame.MoverBottom:SetScript("OnMouseWheel", NOOP)
	GVAR.OptionsFrame.MoverBottomText = GVAR.OptionsFrame.MoverBottom:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	GVAR.OptionsFrame.MoverBottomText:SetPoint("CENTER", GVAR.OptionsFrame.MoverBottom, "CENTER", 0, 0)
	GVAR.OptionsFrame.MoverBottomText:SetJustifyH("CENTER")
	GVAR.OptionsFrame.MoverBottomText:SetTextColor(0.3, 0.3, 0.3, 1)
	GVAR.OptionsFrame.MoverBottomText:SetText(L["click & move"])

	GVAR.OptionsFrame.MoverTop:SetScript("OnEnter", function() GVAR.OptionsFrame.MoverTopText:SetTextColor(1, 1, 1, 1) end)
	GVAR.OptionsFrame.MoverTop:SetScript("OnLeave", function() GVAR.OptionsFrame.MoverTopText:SetTextColor(0.3, 0.3, 0.3, 1) end)
	GVAR.OptionsFrame.MoverTop:SetScript("OnMouseDown", function() GVAR.OptionsFrame:StartMoving() end)
	GVAR.OptionsFrame.MoverTop:SetScript("OnMouseUp", function() GVAR.OptionsFrame:StopMovingOrSizing() BattlegroundTargets:Frame_SavePosition("BattlegroundTargets_OptionsFrame") end)

	GVAR.OptionsFrame.MoverBottom:SetScript("OnEnter", function() GVAR.OptionsFrame.MoverBottomText:SetTextColor(1, 1, 1, 1) end)
	GVAR.OptionsFrame.MoverBottom:SetScript("OnLeave", function() GVAR.OptionsFrame.MoverBottomText:SetTextColor(0.3, 0.3, 0.3, 1) end)
	GVAR.OptionsFrame.MoverBottom:SetScript("OnMouseDown", function() GVAR.OptionsFrame:StartMoving() end)
	GVAR.OptionsFrame.MoverBottom:SetScript("OnMouseUp", function() GVAR.OptionsFrame:StopMovingOrSizing() BattlegroundTargets:Frame_SavePosition("BattlegroundTargets_OptionsFrame") end)
	-- ###
	-- ####################################################################################################



	-- ####################################################################################################
	-- xMx width BOOM
	local frameWidth = 400
	if layoutW > frameWidth then frameWidth = layoutW end
	if summaryW > frameWidth then frameWidth = summaryW end
	if generalIconW > frameWidth then frameWidth = generalIconW end
	if iconW > frameWidth then frameWidth = iconW end
	if rangeW > frameWidth then frameWidth = rangeW end
	if sortW > frameWidth then frameWidth = sortW end
	if fontstyleW > frameWidth then frameWidth = fontstyleW end
	if frameWidth < 400 then frameWidth = 400 end
	if frameWidth > 650 then frameWidth = 650 end
	-- OptionsFrame
	GVAR.OptionsFrame:SetClampRectInsets((frameWidth-50)/2, -((frameWidth-50)/2), -(heightTotal-35), heightTotal-35)
	GVAR.OptionsFrame:SetWidth(frameWidth)
	GVAR.OptionsFrame.CloseConfig:SetWidth(frameWidth-20)
	-- Base
	GVAR.OptionsFrame.Base:SetWidth(frameWidth)
	GVAR.OptionsFrame.Title:SetWidth(frameWidth)
	local spacer = 10
	local tabWidth1 = GVAR.OptionsFrame.TabGeneral.TabText:GetStringWidth() + 20
	local tabWidth2 = floor( (frameWidth-tabWidth1-tabWidth1-(6*spacer)) / 3 )
	GVAR.OptionsFrame.TabGeneral:SetWidth(tabWidth1)
	GVAR.OptionsFrame.TabRaidSize10:SetWidth(tabWidth2)
	GVAR.OptionsFrame.TabRaidSize15:SetWidth(tabWidth2)
	GVAR.OptionsFrame.TabRaidSize40:SetWidth(tabWidth2)
	GVAR.OptionsFrame.TabGeneral:SetPoint("BOTTOMLEFT", GVAR.OptionsFrame.Base, "BOTTOMLEFT", spacer, -1)
	GVAR.OptionsFrame.TabRaidSize10:SetPoint("BOTTOMLEFT", GVAR.OptionsFrame.Base, "BOTTOMLEFT", spacer+tabWidth1+spacer, -1)
	GVAR.OptionsFrame.TabRaidSize15:SetPoint("BOTTOMLEFT", GVAR.OptionsFrame.Base, "BOTTOMLEFT", spacer+tabWidth1+spacer+((tabWidth2+spacer)*1), -1)
	GVAR.OptionsFrame.TabRaidSize40:SetPoint("BOTTOMLEFT", GVAR.OptionsFrame.Base, "BOTTOMLEFT", spacer+tabWidth1+spacer+((tabWidth2+spacer)*2), -1)
	GVAR.OptionsFrame.Dummy1:SetWidth(frameWidth-20) -- DUMMY
	GVAR.OptionsFrame.Dummy2:SetWidth(frameWidth-20)
	GVAR.OptionsFrame.Dummy3:SetWidth(frameWidth-20)
	GVAR.OptionsFrame.Dummy4:SetWidth(frameWidth-20)
	GVAR.OptionsFrame.Dummy5:SetWidth(frameWidth-20)
	GVAR.OptionsFrame.Dummy6:SetWidth(frameWidth-20)
	GVAR.OptionsFrame.Dummy7:SetWidth(frameWidth-20)
	GVAR.OptionsFrame.Dummy8:SetWidth(frameWidth-20)
	local w1 = frameWidth/2
	local w2 = GVAR.OptionsFrame.CopySettings.Text:GetStringWidth() + 60
	if w2 > w1 then
		w1 = w2
	end
	GVAR.OptionsFrame.CopySettings:SetWidth(w1)
	-- ConfigBrackets
	GVAR.OptionsFrame.ConfigBrackets:SetWidth(frameWidth)
	-- ConfigGeneral
	GVAR.OptionsFrame.ConfigGeneral:SetWidth(frameWidth)
	-- Mover
	GVAR.OptionsFrame.MoverTop:SetWidth(frameWidth)
	GVAR.OptionsFrame.MoverBottom:SetWidth(frameWidth)
	-- ###
	-- ####################################################################################################
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:BGInfo(bracketSize)
	local i = 1
	while GVAR.OptionsFrame.ConfigBrackets.BGinformation[i] do
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:Hide()
		i = i + 1
	end
	for i = 1, #bgInfo[bracketSize] do
		local bgName = bgInfo[bracketSize][i]
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].Texture:SetTexture(bgMaps[bgName].icon)
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i].bginfo = bgName
		GVAR.OptionsFrame.ConfigBrackets.BGinformation[i]:Show()
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:SetOptions()
	local BattlegroundTargets_Options = BattlegroundTargets_Options
	GVAR.OptionsFrame.EnableBracket:SetChecked(BattlegroundTargets_Options.EnableBracket[currentSize])
	GVAR.OptionsFrame.IndependentPos:SetChecked(BattlegroundTargets_Options.IndependentPositioning[currentSize])

	if currentSize == 10 then
		GVAR.OptionsFrame.CopySettings.Text:SetText(format(L["Copy this settings to %s"], "|cffffffff"..L["15v15"].."|r"))
	elseif currentSize == 15 then
		GVAR.OptionsFrame.CopySettings.Text:SetText(format(L["Copy this settings to %s"], "|cffffffff"..L["10v10"].."|r"))
	end

	local LayoutTH = BattlegroundTargets_Options.LayoutTH[currentSize]
	if LayoutTH == 18 then
		GVAR.OptionsFrame.LayoutTHx18:SetChecked(true)
		GVAR.OptionsFrame.LayoutTHx24:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx42:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx81:SetChecked(false)
	elseif LayoutTH == 24 then
		GVAR.OptionsFrame.LayoutTHx18:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx24:SetChecked(true)
		GVAR.OptionsFrame.LayoutTHx42:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx81:SetChecked(false)
	elseif LayoutTH == 42 then
		GVAR.OptionsFrame.LayoutTHx18:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx24:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx42:SetChecked(true)
		GVAR.OptionsFrame.LayoutTHx81:SetChecked(false)
	elseif LayoutTH == 81 then
		GVAR.OptionsFrame.LayoutTHx18:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx24:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx42:SetChecked(false)
		GVAR.OptionsFrame.LayoutTHx81:SetChecked(true)
	end
	GVAR.OptionsFrame.LayoutSpace:SetValue(BattlegroundTargets_Options.LayoutSpace[currentSize])
	GVAR.OptionsFrame.LayoutSpaceText:SetText(BattlegroundTargets_Options.LayoutSpace[currentSize])

	GVAR.OptionsFrame.SummaryToggle:SetChecked(BattlegroundTargets_Options.SummaryToggle[currentSize])
	GVAR.OptionsFrame.SummaryScale:SetValue(BattlegroundTargets_Options.SummaryScale[currentSize]*100)
	GVAR.OptionsFrame.SummaryScaleText:SetText((BattlegroundTargets_Options.SummaryScale[currentSize]*100).."%")
	GVAR.OptionsFrame.SummaryPosition:SetValue(BattlegroundTargets_Options.SummaryPos[currentSize])
	GVAR.OptionsFrame.SummaryPositionText:SetText(sumPos[ BattlegroundTargets_Options.SummaryPos[currentSize] ])

	GVAR.OptionsFrame.ShowRole:SetChecked(OPT.ButtonShowRole[currentSize])
	GVAR.OptionsFrame.ShowSpec:SetChecked(OPT.ButtonShowSpec[currentSize])
	GVAR.OptionsFrame.ClassIcon:SetChecked(OPT.ButtonClassIcon[currentSize])
	GVAR.OptionsFrame.ShowLeader:SetChecked(OPT.ButtonShowLeader[currentSize])
	GVAR.OptionsFrame.ShowRealm:SetChecked(OPT.ButtonShowRealm[currentSize])

	GVAR.OptionsFrame.ShowTargetIndicator:SetChecked(OPT.ButtonShowTarget[currentSize])
	GVAR.OptionsFrame.TargetScaleSlider:SetValue(OPT.ButtonTargetScale[currentSize]*100)
	GVAR.OptionsFrame.TargetScaleSliderText:SetText((OPT.ButtonTargetScale[currentSize]*100).."%")
	GVAR.OptionsFrame.TargetPositionSlider:SetValue(OPT.ButtonTargetPosition[currentSize])
	GVAR.OptionsFrame.TargetPositionSliderText:SetText(OPT.ButtonTargetPosition[currentSize])

	GVAR.OptionsFrame.ShowFocusIndicator:SetChecked(OPT.ButtonShowFocus[currentSize])
	GVAR.OptionsFrame.FocusScaleSlider:SetValue(OPT.ButtonFocusScale[currentSize]*100)
	GVAR.OptionsFrame.FocusScaleSliderText:SetText((OPT.ButtonFocusScale[currentSize]*100).."%")
	GVAR.OptionsFrame.FocusPositionSlider:SetValue(OPT.ButtonFocusPosition[currentSize])
	GVAR.OptionsFrame.FocusPositionSliderText:SetText(OPT.ButtonFocusPosition[currentSize])

	GVAR.OptionsFrame.ShowFlag:SetChecked(OPT.ButtonShowFlag[currentSize])
	GVAR.OptionsFrame.FlagScaleSlider:SetValue(OPT.ButtonFlagScale[currentSize]*100)
	GVAR.OptionsFrame.FlagScaleSliderText:SetText((OPT.ButtonFlagScale[currentSize]*100).."%")
	GVAR.OptionsFrame.FlagPositionSlider:SetValue(OPT.ButtonFlagPosition[currentSize])
	GVAR.OptionsFrame.FlagPositionSliderText:SetText(OPT.ButtonFlagPosition[currentSize])

	GVAR.OptionsFrame.ShowAssist:SetChecked(OPT.ButtonShowAssist[currentSize])
	GVAR.OptionsFrame.AssistScaleSlider:SetValue(OPT.ButtonAssistScale[currentSize]*100)
	GVAR.OptionsFrame.AssistScaleSliderText:SetText((OPT.ButtonAssistScale[currentSize]*100).."%")
	GVAR.OptionsFrame.AssistPositionSlider:SetValue(OPT.ButtonAssistPosition[currentSize])
	GVAR.OptionsFrame.AssistPositionSliderText:SetText(OPT.ButtonAssistPosition[currentSize])

	GVAR.OptionsFrame.ShowTargetCount:SetChecked(OPT.ButtonShowTargetCount[currentSize])

	GVAR.OptionsFrame.ShowHealthBar:SetChecked(OPT.ButtonShowHealthBar[currentSize])
	GVAR.OptionsFrame.ShowHealthText:SetChecked(OPT.ButtonShowHealthText[currentSize])

	GVAR.OptionsFrame.RangeCheck:SetChecked(OPT.ButtonRangeCheck[currentSize])
	GVAR.OptionsFrame.RangeCheckTypePullDown.PullDownButtonText:SetText(rangeTypeName[ OPT.ButtonTypeRangeCheck[currentSize] ])
	GVAR.OptionsFrame.RangeDisplayPullDown.PullDownButtonText:SetText(rangeDisplay[ OPT.ButtonRangeDisplay[currentSize] ])

	GVAR.OptionsFrame.SortByPullDown.PullDownButtonText:SetText(sortBy[ OPT.ButtonSortBy[currentSize] ])
	GVAR.OptionsFrame.SortDetailPullDown.PullDownButtonText:SetText(sortDetail[ OPT.ButtonSortDetail[currentSize] ])
	local ButtonSortBy = OPT.ButtonSortBy[currentSize]
	if ButtonSortBy == 1 or ButtonSortBy == 3 or ButtonSortBy == 4 then
		GVAR.OptionsFrame.SortDetailPullDown:Show()
		GVAR.OptionsFrame.SortInfo:Show()
	else
		GVAR.OptionsFrame.SortDetailPullDown:Hide()
		GVAR.OptionsFrame.SortInfo:Hide()
	end

	GVAR.OptionsFrame.FontNamePullDown.PullDownButtonText:SetText(fontStyles[ OPT.ButtonFontNameStyle[currentSize] ].name)
	GVAR.OptionsFrame.FontNameSlider:SetValue(OPT.ButtonFontNameSize[currentSize])
	GVAR.OptionsFrame.FontNameValue:SetText(OPT.ButtonFontNameSize[currentSize])
	GVAR.OptionsFrame.FontNumberPullDown.PullDownButtonText:SetText(strmatch(fontStyles[ OPT.ButtonFontNumberStyle[currentSize] ].name, "(.*) %- .*"))
	GVAR.OptionsFrame.FontNumberSlider:SetValue(OPT.ButtonFontNumberSize[currentSize])
	GVAR.OptionsFrame.FontNumberValue:SetText(OPT.ButtonFontNumberSize[currentSize])

	GVAR.OptionsFrame.ScaleSlider:SetValue(OPT.ButtonScale[currentSize]*100)
	GVAR.OptionsFrame.ScaleValue:SetText((OPT.ButtonScale[currentSize]*100).."%")

	GVAR.OptionsFrame.WidthSlider:SetValue(OPT.ButtonWidth[currentSize])
	GVAR.OptionsFrame.WidthValue:SetText(OPT.ButtonWidth[currentSize])

	GVAR.OptionsFrame.HeightSlider:SetValue(OPT.ButtonHeight[currentSize])
	GVAR.OptionsFrame.HeightValue:SetText(OPT.ButtonHeight[currentSize])
end

function BattlegroundTargets:CheckForEnabledBracket(bracketSize)
	if BattlegroundTargets_Options.EnableBracket[bracketSize] then
		if bracketSize == 10 then
			GVAR.OptionsFrame.TabRaidSize10.TabText:SetTextColor(0, 0.75, 0, 1)
		elseif bracketSize == 15 then
			GVAR.OptionsFrame.TabRaidSize15.TabText:SetTextColor(0, 0.75, 0, 1)
		elseif bracketSize == 40 then
			GVAR.OptionsFrame.TabRaidSize40.TabText:SetTextColor(0, 0.75, 0, 1)
		end

		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.IndependentPos)

		GVAR.OptionsFrame.LayoutTHText:SetTextColor(1, 1, 1, 1)
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.LayoutTHx18)
		if bracketSize == 10 or bracketSize == 15 then
			TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx24)
			TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx42)
		else
			TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.LayoutTHx24)
			TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.LayoutTHx42)
		end
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.LayoutTHx81)
		if BattlegroundTargets_Options.LayoutTH[bracketSize] == 18 then
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.LayoutSpace)
		else
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.LayoutSpace)
		end

		GVAR.OptionsFrame.SummaryText:SetTextColor(1, 1, 1, 1)
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.SummaryToggle)
		if BattlegroundTargets_Options.SummaryToggle[bracketSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.SummaryScale)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.SummaryPosition)
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryScale)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryPosition)
		end

		if bracketSize == 40 then
 			GVAR.OptionsFrame.CopySettings:Hide()
		else
			GVAR.OptionsFrame.CopySettings:Show()
			TEMPLATE.EnableTextButton(GVAR.OptionsFrame.CopySettings)
		end

		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowRole)
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowSpec)
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ClassIcon)
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowLeader)
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowRealm)

		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowTargetIndicator)
		if OPT.ButtonShowTarget[bracketSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.TargetScaleSlider)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.TargetPositionSlider)
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.TargetScaleSlider)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.TargetPositionSlider)
		end
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowFocusIndicator)
		if OPT.ButtonShowFocus[bracketSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.FocusScaleSlider)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.FocusPositionSlider)
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FocusScaleSlider)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FocusPositionSlider)
		end
		if bracketSize == 40 then
			TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowFlag)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagScaleSlider)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagPositionSlider)
			GVAR.OptionsFrame.CarrierSwitchDisableFunc()
		else
			TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowFlag)
			if OPT.ButtonShowFlag[bracketSize] then
				TEMPLATE.EnableSlider(GVAR.OptionsFrame.FlagScaleSlider)
				TEMPLATE.EnableSlider(GVAR.OptionsFrame.FlagPositionSlider)
				GVAR.OptionsFrame.CarrierSwitchEnableFunc()
			else
				TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagScaleSlider)
				TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagPositionSlider)
				GVAR.OptionsFrame.CarrierSwitchDisableFunc()
			end
		end
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowAssist)
		if OPT.ButtonShowAssist[bracketSize] then
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.AssistScaleSlider)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.AssistPositionSlider)
		else
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.AssistScaleSlider)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.AssistPositionSlider)
		end

		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowTargetCount)

		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowHealthBar)
		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.ShowHealthText)

		TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.RangeCheck)
		if OPT.ButtonRangeCheck[bracketSize] then
			TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.RangeCheckTypePullDown)
			GVAR.OptionsFrame.RangeCheckInfo:Enable() Desaturation(GVAR.OptionsFrame.RangeCheckInfo.Texture, false)
			TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.RangeDisplayPullDown)
		else
			TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.RangeCheckTypePullDown)
			GVAR.OptionsFrame.RangeCheckInfo:Disable() Desaturation(GVAR.OptionsFrame.RangeCheckInfo.Texture, true)
			TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.RangeDisplayPullDown)
		end

		TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.SortByPullDown)
		GVAR.OptionsFrame.SortByTitle:SetTextColor(1, 1, 1, 1)
		TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.SortDetailPullDown)
		GVAR.OptionsFrame.SortInfo:Enable() Desaturation(GVAR.OptionsFrame.SortInfo.Texture, false)

		TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.FontNamePullDown)
		GVAR.OptionsFrame.FontNameTitle:SetTextColor(1, 1, 1, 1)
		TEMPLATE.EnableSlider(GVAR.OptionsFrame.FontNameSlider)
		if BattlegroundTargets_Options.SummaryToggle[bracketSize] or
		   OPT.ButtonShowFlag[bracketSize] or
		   OPT.ButtonShowHealthText[bracketSize] or
		   OPT.ButtonShowTargetCount[bracketSize]
		then
			TEMPLATE.EnablePullDownMenu(GVAR.OptionsFrame.FontNumberPullDown)
			GVAR.OptionsFrame.FontNumberTitle:SetTextColor(1, 1, 1, 1)
			TEMPLATE.EnableSlider(GVAR.OptionsFrame.FontNumberSlider)
		else
			TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.FontNumberPullDown)
			GVAR.OptionsFrame.FontNumberTitle:SetTextColor(0.5, 0.5, 0.5, 1)
			TEMPLATE.DisableSlider(GVAR.OptionsFrame.FontNumberSlider)
		end

		TEMPLATE.EnableSlider(GVAR.OptionsFrame.ScaleSlider)
		GVAR.OptionsFrame.ScaleTitle:SetTextColor(1, 1, 1, 1)
		TEMPLATE.EnableSlider(GVAR.OptionsFrame.WidthSlider)
		GVAR.OptionsFrame.WidthTitle:SetTextColor(1, 1, 1, 1)
		TEMPLATE.EnableSlider(GVAR.OptionsFrame.HeightSlider)
		GVAR.OptionsFrame.HeightTitle:SetTextColor(1, 1, 1, 1)
		GVAR.OptionsFrame.TestShuffler:Show()
	else
		if bracketSize == 10 then
			GVAR.OptionsFrame.TabRaidSize10.TabText:SetTextColor(1, 0, 0, 1)
		elseif bracketSize == 15 then
			GVAR.OptionsFrame.TabRaidSize15.TabText:SetTextColor(1, 0, 0, 1)
		elseif bracketSize == 40 then
			GVAR.OptionsFrame.TabRaidSize40.TabText:SetTextColor(1, 0, 0, 1)
		end

		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.IndependentPos)

		GVAR.OptionsFrame.LayoutTHText:SetTextColor(0.5, 0.5, 0.5, 1)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx18)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx24)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx42)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx81)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.LayoutSpace)

		GVAR.OptionsFrame.SummaryText:SetTextColor(0.5, 0.5, 0.5, 1)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.SummaryToggle)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryScale)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryPosition)

		if bracketSize == 40 then
 			GVAR.OptionsFrame.CopySettings:Hide()
		else
			GVAR.OptionsFrame.CopySettings:Show()
			TEMPLATE.DisableTextButton(GVAR.OptionsFrame.CopySettings)
		end

		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowRole)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowSpec)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ClassIcon)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowLeader)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowRealm)

		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowTargetIndicator)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.TargetScaleSlider)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.TargetPositionSlider)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowFocusIndicator)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.FocusScaleSlider)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.FocusPositionSlider)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowFlag)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagScaleSlider)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagPositionSlider)
		GVAR.OptionsFrame.CarrierSwitchDisableFunc()
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowAssist)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.AssistScaleSlider)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.AssistPositionSlider)

		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowTargetCount)

		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowHealthBar)
		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowHealthText)

		TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.RangeCheck)
		TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.RangeCheckTypePullDown)
		GVAR.OptionsFrame.RangeCheckInfo:Disable() Desaturation(GVAR.OptionsFrame.RangeCheckInfo.Texture, true)
		TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.RangeDisplayPullDown)

		TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.SortByPullDown)
		GVAR.OptionsFrame.SortByTitle:SetTextColor(0.5, 0.5, 0.5, 1)
		TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.SortDetailPullDown)
		GVAR.OptionsFrame.SortInfo:Disable() Desaturation(GVAR.OptionsFrame.SortInfo.Texture, true)

		TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.FontNamePullDown)
		GVAR.OptionsFrame.FontNameTitle:SetTextColor(0.5, 0.5, 0.5, 1)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.FontNameSlider)
		TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.FontNumberPullDown)
		GVAR.OptionsFrame.FontNumberTitle:SetTextColor(0.5, 0.5, 0.5, 1)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.FontNumberSlider)

		TEMPLATE.DisableSlider(GVAR.OptionsFrame.ScaleSlider)
		GVAR.OptionsFrame.ScaleTitle:SetTextColor(0.5, 0.5, 0.5, 1)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.WidthSlider)
		GVAR.OptionsFrame.WidthTitle:SetTextColor(0.5, 0.5, 0.5, 1)
		TEMPLATE.DisableSlider(GVAR.OptionsFrame.HeightSlider)
		GVAR.OptionsFrame.HeightTitle:SetTextColor(0.5, 0.5, 0.5, 1)
		GVAR.OptionsFrame.TestShuffler:Hide()
	end
	    if bracketSize == 10 then BattlegroundTargets:BGInfo(10)
	elseif bracketSize == 15 then BattlegroundTargets:BGInfo(15)
	elseif bracketSize == 40 then BattlegroundTargets:BGInfo(40) end
end

function BattlegroundTargets:DisableInsecureConfigWidges()
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.Minimap)

	TEMPLATE.DisableTabButton(GVAR.OptionsFrame.TabGeneral)
	TEMPLATE.DisableTabButton(GVAR.OptionsFrame.TabRaidSize10)
	TEMPLATE.DisableTabButton(GVAR.OptionsFrame.TabRaidSize15)
	TEMPLATE.DisableTabButton(GVAR.OptionsFrame.TabRaidSize40)

	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.EnableBracket)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.IndependentPos)

	TEMPLATE.DisableTextButton(GVAR.OptionsFrame.CopySettings)

	GVAR.OptionsFrame.LayoutTHText:SetTextColor(0.5, 0.5, 0.5, 1)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx18)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx24)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx42)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.LayoutTHx81)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.LayoutSpace)

	GVAR.OptionsFrame.SummaryText:SetTextColor(0.5, 0.5, 0.5, 1)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.SummaryToggle)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryScale)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.SummaryPosition)

	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowRole)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowSpec)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ClassIcon)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowLeader)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowRealm)

	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowTargetIndicator)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.TargetScaleSlider)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.TargetPositionSlider)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowFocusIndicator)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.FocusScaleSlider)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.FocusPositionSlider)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowFlag)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagScaleSlider)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.FlagPositionSlider)
	GVAR.OptionsFrame.CarrierSwitchDisableFunc()
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowAssist)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.AssistScaleSlider)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.AssistPositionSlider)

	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowTargetCount)

	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowHealthBar)
	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.ShowHealthText)

	TEMPLATE.DisableCheckButton(GVAR.OptionsFrame.RangeCheck)
	TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.RangeCheckTypePullDown)
	GVAR.OptionsFrame.RangeCheckInfo:Disable() Desaturation(GVAR.OptionsFrame.RangeCheckInfo.Texture, true)
	TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.RangeDisplayPullDown)

	TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.SortByPullDown)
	GVAR.OptionsFrame.SortByTitle:SetTextColor(0.5, 0.5, 0.5, 1)
	TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.SortDetailPullDown)
	GVAR.OptionsFrame.SortInfo:Disable() Desaturation(GVAR.OptionsFrame.SortInfo.Texture, true)

	TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.FontNamePullDown)
	GVAR.OptionsFrame.FontNameTitle:SetTextColor(0.5, 0.5, 0.5, 1)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.FontNameSlider)
	TEMPLATE.DisablePullDownMenu(GVAR.OptionsFrame.FontNumberPullDown)
	GVAR.OptionsFrame.FontNumberTitle:SetTextColor(0.5, 0.5, 0.5, 1)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.FontNumberSlider)

	TEMPLATE.DisableSlider(GVAR.OptionsFrame.ScaleSlider)
	GVAR.OptionsFrame.ScaleTitle:SetTextColor(0.5, 0.5, 0.5, 1)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.WidthSlider)
	GVAR.OptionsFrame.WidthTitle:SetTextColor(0.5, 0.5, 0.5, 1)
	TEMPLATE.DisableSlider(GVAR.OptionsFrame.HeightSlider)
	GVAR.OptionsFrame.HeightTitle:SetTextColor(0.5, 0.5, 0.5, 1)
	GVAR.OptionsFrame.TestShuffler:Hide()
end

function BattlegroundTargets:EnableInsecureConfigWidges()
	TEMPLATE.EnableTabButton(GVAR.OptionsFrame.TabGeneral, true)
	TEMPLATE.EnableTabButton(GVAR.OptionsFrame.TabRaidSize10, BattlegroundTargets_Options.EnableBracket[10])
	TEMPLATE.EnableTabButton(GVAR.OptionsFrame.TabRaidSize15, BattlegroundTargets_Options.EnableBracket[15])
	TEMPLATE.EnableTabButton(GVAR.OptionsFrame.TabRaidSize40, BattlegroundTargets_Options.EnableBracket[40])

	TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.EnableBracket)
	TEMPLATE.EnableCheckButton(GVAR.OptionsFrame.Minimap)

	BattlegroundTargets:CheckForEnabledBracket(testSize)
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CreateMinimapButton()
	if not BattlegroundTargets_Options.MinimapButton then
		if BattlegroundTargets_MinimapButton then
			BattlegroundTargets_MinimapButton:Hide()
		end
		return
	else
		if BattlegroundTargets_MinimapButton then
			BattlegroundTargets_MinimapButton:Show()
			return
		end
	end

	local function MoveMinimapButton()
		local xpos
		local ypos
		local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
		if minimapShape == "SQUARE" then
			xpos = 110 * cos(BattlegroundTargets_Options.MinimapButtonPos or 0)
			ypos = 110 * sin(BattlegroundTargets_Options.MinimapButtonPos or 0)
			xpos = math.max(-82, math.min(xpos, 84))
			ypos = math.max(-86, math.min(ypos, 82))
		else
			xpos = 80 * cos(BattlegroundTargets_Options.MinimapButtonPos or 0)
			ypos = 80 * sin(BattlegroundTargets_Options.MinimapButtonPos or 0)
		end
		BattlegroundTargets_MinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 54-xpos, ypos-54)
	end

	local function DragMinimapButton()
		local xpos, ypos = GetCursorPosition()
		local xmin, ymin = Minimap:GetLeft() or 400, Minimap:GetBottom() or 400
		local scale = Minimap:GetEffectiveScale()
		xpos = xmin-xpos/scale+70
		ypos = ypos/scale-ymin-70
		BattlegroundTargets_Options.MinimapButtonPos = math.deg(math.atan2(ypos, xpos))
		MoveMinimapButton()
	end

	local MinimapButton = CreateFrame("Button", "BattlegroundTargets_MinimapButton", Minimap)
	MinimapButton:EnableMouse(true)
	MinimapButton:SetMovable(true)
	MinimapButton:SetToplevel(true)
	MinimapButton:SetWidth(32)
	MinimapButton:SetHeight(32)
	MinimapButton:SetPoint("TOPLEFT")
	MinimapButton:SetFrameStrata("MEDIUM")
	MinimapButton:RegisterForClicks("AnyUp")
	MinimapButton:RegisterForDrag("LeftButton")

	local texture = MinimapButton:CreateTexture(nil, "ARTWORK")
	texture:SetWidth(54)
	texture:SetHeight(54)
	texture:SetPoint("TOPLEFT")
	texture:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

	local texture = MinimapButton:CreateTexture(nil, "BACKGROUND")
	texture:SetWidth(24)
	texture:SetHeight(24)
	texture:SetPoint("TOPLEFT", 2, -4)
	texture:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

	local NormalTexture = MinimapButton:CreateTexture(nil, "ARTWORK")
	NormalTexture:SetWidth(12)
	NormalTexture:SetHeight(14)
	NormalTexture:SetPoint("TOPLEFT", 10.5, -8.5)
	NormalTexture:SetTexture(AddonIcon)
	NormalTexture:SetTexCoord(2/16, 14/16, 1/16, 15/16)
	MinimapButton:SetNormalTexture(NormalTexture)

	local PushedTexture = MinimapButton:CreateTexture(nil, "ARTWORK")
	PushedTexture:SetWidth(10)
	PushedTexture:SetHeight(12)
	PushedTexture:SetPoint("TOPLEFT", 11.5, -9.5)
	PushedTexture:SetTexture(AddonIcon)
	PushedTexture:SetTexCoord(2/16, 14/16, 1/16, 15/16)
	MinimapButton:SetPushedTexture(PushedTexture)

	local HighlightTexture = MinimapButton:CreateTexture(nil, "ARTWORK")
	HighlightTexture:SetPoint("TOPLEFT", 0, 0)
	HighlightTexture:SetPoint("BOTTOMRIGHT", 0, 0)
	HighlightTexture:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	MinimapButton:SetHighlightTexture(HighlightTexture)

	MinimapButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine("BattlegroundTargets", 1, 0.82, 0, 1)
		GameTooltip:Show()
	end)
	MinimapButton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	MinimapButton:SetScript("OnClick", function(self, button) BattlegroundTargets:Frame_Toggle(GVAR.OptionsFrame) end)
	MinimapButton:SetScript("OnDragStart", function(self) self:LockHighlight() self:SetScript("OnUpdate", DragMinimapButton) end)
	MinimapButton:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) self:UnlockHighlight() end)

	MoveMinimapButton()
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:SetupLayout()
	if inCombat or InCombatLockdown() then
		reCheckBG = true
		return
	end

	local LayoutTH    = BattlegroundTargets_Options.LayoutTH[currentSize]
	local LayoutSpace = BattlegroundTargets_Options.LayoutSpace[currentSize]
	local GVAR_TargetButton = GVAR.TargetButton

	if currentSize == 10 then
		for i = 1, currentSize do
			if LayoutTH == 81 then
				if i == 6 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[1], "TOPRIGHT", LayoutSpace, 0)
				elseif i > 1 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
				end
			elseif LayoutTH == 18 then
				if i > 1 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
				end
			end
		end
	elseif currentSize == 15 then
		for i = 1, currentSize do
			if LayoutTH == 81 then
				if i == 6 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[1], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 11 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[6], "TOPRIGHT", LayoutSpace, 0)
				elseif i > 1 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
				end
			elseif LayoutTH == 18 then
				if i > 1 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
				end
			end
		end
	elseif currentSize == 40 then
		for i = 1, currentSize do
			if LayoutTH == 81 then
				if i == 6 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[1], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 11 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[6], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 16 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[11], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 21 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[16], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 26 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[21], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 31 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[26], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 36 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[31], "TOPRIGHT", LayoutSpace, 0)
				elseif i > 1 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
				end
			elseif LayoutTH == 42 then
				if i == 11 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[1], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 21 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[11], "TOPRIGHT", LayoutSpace, 0)
				elseif i == 31 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[21], "TOPRIGHT", LayoutSpace, 0)
				elseif i > 1 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
				end
			elseif LayoutTH == 24 then
				if i == 21 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[1], "TOPRIGHT", LayoutSpace, 0)
				elseif i > 1 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
				end
			elseif LayoutTH == 18 then
				if i > 1 then
					GVAR_TargetButton[i]:SetPoint("TOPLEFT", GVAR_TargetButton[(i-1)], "BOTTOMLEFT", 0, 0)
				end
			end
		end
	end
	BattlegroundTargets:SetupMonoblockPosition()
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:SetupMonoblockPosition() -- SUMPOSi
	local BattlegroundTargets_Options = BattlegroundTargets_Options
	local LayoutTH     = BattlegroundTargets_Options.LayoutTH[currentSize]
	local LayoutSpace  = BattlegroundTargets_Options.LayoutSpace[currentSize]
	local ButtonWidth  = BattlegroundTargets_Options.ButtonWidth[currentSize]
	local ButtonHeight = BattlegroundTargets_Options.ButtonHeight[currentSize]
	local ButtonScale  = BattlegroundTargets_Options.ButtonScale[currentSize]

	local totalWidth, totalHeight
	if currentSize == 10 then
		    if LayoutTH == 18 then totalWidth =    ButtonWidth                    totalHeight = 10*ButtonHeight
		elseif LayoutTH == 81 then totalWidth = (2*ButtonWidth) +    LayoutSpace  totalHeight =  5*ButtonHeight
		end
	elseif currentSize == 15 then
		    if LayoutTH == 18 then totalWidth =    ButtonWidth                    totalHeight = 15*ButtonHeight
		elseif LayoutTH == 81 then totalWidth = (3*ButtonWidth) + (2*LayoutSpace) totalHeight =  5*ButtonHeight
		end
	elseif currentSize == 40 then
		    if LayoutTH == 18 then totalWidth =    ButtonWidth                    totalHeight = 40*ButtonHeight
		elseif LayoutTH == 24 then totalWidth = (2*ButtonWidth) + (1*LayoutSpace) totalHeight = 20*ButtonHeight
		elseif LayoutTH == 42 then totalWidth = (4*ButtonWidth) + (3*LayoutSpace) totalHeight = 10*ButtonHeight
		elseif LayoutTH == 81 then totalWidth = (8*ButtonWidth) + (7*LayoutSpace) totalHeight =  5*ButtonHeight
		end
	end

	if inBattleground and isDeadUpdateStop then
		GVAR.IsGhostTexture:Show()
	end

	GVAR.MainFrame:SetClampRectInsets(0, totalWidth*ButtonScale, 0, -(totalHeight*ButtonScale))
	GVAR.MonoblockAnchor:SetSize(totalWidth, totalHeight)
	GVAR.MainFrameMoverFrame:SetSize(totalWidth, totalHeight)

	if BattlegroundTargets_Options.SummaryToggle[currentSize] then -- SUMMARY
		local SummaryPos = BattlegroundTargets_Options.SummaryPos[currentSize]
		local a1, a2, x, y
		    if SummaryPos == 1 then a1="TOP"         a2="BOTTOM"      x=  0 y=-10 --   0
		elseif SummaryPos == 2 then a1="TOPRIGHT"    a2="BOTTOMLEFT"  x=-10 y=-10 --  45
		elseif SummaryPos == 3 then a1="RIGHT"       a2="LEFT"        x=-10 y=  0 --  90
		elseif SummaryPos == 4 then a1="BOTTOMRIGHT" a2="TOPLEFT"     x=-10 y= 10 -- 135
		elseif SummaryPos == 5 then a1="BOTTOM"      a2="TOP"         x=  0 y= 10 -- 180
		elseif SummaryPos == 6 then a1="BOTTOMLEFT"  a2="TOPRIGHT"    x= 10 y= 10 -- 225
		elseif SummaryPos == 7 then a1="LEFT"        a2="RIGHT"       x= 10 y=  0 -- 270
		elseif SummaryPos == 8 then a1="TOPLEFT"     a2="BOTTOMRIGHT" x= 10 y=-10 -- 315
		elseif SummaryPos == 9 then a1="TOP"         a2="BOTTOM"      x=  0 y=-10 -- 360 => indie pos TODO
		else                        a1="TOP"         a2="BOTTOM"      x=  0 y=-10
		end

		GVAR.Summary:ClearAllPoints()
		GVAR.Summary:SetPoint(a1, GVAR.MonoblockAnchor, a2, x, y)
		GVAR.Summary:SetScale(BattlegroundTargets_Options.SummaryScale[currentSize])
		GVAR.Summary:Show()
	else
		GVAR.Summary:Hide()
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:SetupButtonLayout()
	if inCombat or InCombatLockdown() then
		reSetLayout = true
		return
	end

	BattlegroundTargets:SetupLayout()

	local ButtonScale              = OPT.ButtonScale[currentSize]
	local ButtonWidth              = OPT.ButtonWidth[currentSize]
	local ButtonHeight             = OPT.ButtonHeight[currentSize]
	local ButtonFontNameSize       = OPT.ButtonFontNameSize[currentSize]
	local fButtonFontNameStyle     = fontStyles[ OPT.ButtonFontNameStyle[currentSize] ].font
	local ButtonFontNumberSize     = OPT.ButtonFontNumberSize[currentSize]
	local fButtonFontNumberStyle   = fontStyles[ OPT.ButtonFontNumberStyle[currentSize] ].font
	local ButtonShowRole           = OPT.ButtonShowRole[currentSize]
	local ButtonShowSpec           = OPT.ButtonShowSpec[currentSize]
	local ButtonClassIcon          = OPT.ButtonClassIcon[currentSize]
	local ButtonShowTargetCount    = OPT.ButtonShowTargetCount[currentSize]
	local ButtonShowTarget         = OPT.ButtonShowTarget[currentSize]
	local ButtonTargetScale        = OPT.ButtonTargetScale[currentSize]
	local ButtonTargetPosition     = OPT.ButtonTargetPosition[currentSize]
	local ButtonShowFocus          = OPT.ButtonShowFocus[currentSize]
	local ButtonFocusScale         = OPT.ButtonFocusScale[currentSize]
	local ButtonFocusPosition      = OPT.ButtonFocusPosition[currentSize]
	local ButtonShowFlag           = OPT.ButtonShowFlag[currentSize]
	local ButtonFlagScale          = OPT.ButtonFlagScale[currentSize]
	local ButtonFlagPosition       = OPT.ButtonFlagPosition[currentSize]
	local ButtonShowAssist         = OPT.ButtonShowAssist[currentSize]
	local ButtonAssistScale        = OPT.ButtonAssistScale[currentSize]
	local ButtonAssistPosition     = OPT.ButtonAssistPosition[currentSize]
	local ButtonRangeCheck         = OPT.ButtonRangeCheck[currentSize]
	local ButtonRangeDisplay       = OPT.ButtonRangeDisplay[currentSize]

	local ButtonWidth_2  = ButtonWidth-2
	local ButtonHeight_2 = ButtonHeight-2

	local backfallFontSize = ButtonFontNameSize
	if ButtonHeight < ButtonFontNameSize then
		backfallFontSize = ButtonHeight
	end

	local withIconWidth
	local iconNum = 0
	if ButtonShowRole and ButtonShowSpec and ButtonClassIcon then
		iconNum = 3
	elseif (ButtonShowRole and ButtonShowSpec) or (ButtonShowRole and ButtonClassIcon) or (ButtonShowSpec and ButtonClassIcon) then
		iconNum = 2
	elseif ButtonShowRole or ButtonShowSpec or ButtonClassIcon then
		iconNum = 1
	end
	if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
		withIconWidth = (ButtonWidth - ( (ButtonHeight_2*iconNum) + (ButtonHeight_2/2) ) ) - 2
	else
		withIconWidth = (ButtonWidth - (ButtonHeight_2*iconNum)) - 2
	end

	for i = 1, currentSize do
		local GVAR_TargetButton = GVAR.TargetButton[i]

		local lvl = GVAR_TargetButton:GetFrameLevel()
		GVAR_TargetButton.HealthTextButton:SetFrameLevel(lvl+1) -- xBUT
		GVAR_TargetButton.TargetTextureButton:SetFrameLevel(lvl+2)
		GVAR_TargetButton.AssistTextureButton:SetFrameLevel(lvl+3)
		GVAR_TargetButton.FocusTextureButton:SetFrameLevel(lvl+4)
		GVAR_TargetButton.FlagTextureButton:SetFrameLevel(lvl+5)
		GVAR_TargetButton.FlagDebuffButton:SetFrameLevel(lvl+6)

		GVAR_TargetButton:SetScale(ButtonScale)

		GVAR_TargetButton:SetSize(ButtonWidth, ButtonHeight)
		GVAR_TargetButton.HighlightT:SetWidth(ButtonWidth)
		GVAR_TargetButton.HighlightR:SetHeight(ButtonHeight)
		GVAR_TargetButton.HighlightB:SetWidth(ButtonWidth)
		GVAR_TargetButton.HighlightL:SetHeight(ButtonHeight)
		GVAR_TargetButton.Background:SetSize(ButtonWidth_2, ButtonHeight_2)

		if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
			GVAR_TargetButton.RangeTexture:Show()
			GVAR_TargetButton.RangeTexture:SetSize(ButtonHeight_2/2, ButtonHeight_2)
		else
			GVAR_TargetButton.RangeTexture:Hide()
		end
		GVAR_TargetButton.RoleTexture:SetSize(ButtonHeight_2, ButtonHeight_2)
		GVAR_TargetButton.SpecTexture:SetSize(ButtonHeight_2, ButtonHeight_2)
		GVAR_TargetButton.ClassTexture:SetSize(ButtonHeight_2, ButtonHeight_2)

		GVAR_TargetButton.LeaderTexture:SetSize(ButtonHeight_2/1.5, ButtonHeight_2/1.5)
		GVAR_TargetButton.LeaderTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", -(ButtonHeight_2/1.5)/2, 0)

		GVAR_TargetButton.ClassColorBackground:SetHeight(ButtonHeight_2)
		GVAR_TargetButton.HealthBar:SetHeight(ButtonHeight_2)

		if ButtonShowRole and ButtonShowSpec and ButtonClassIcon then
			GVAR_TargetButton.RoleTexture:Show()
			GVAR_TargetButton.SpecTexture:Show()
			GVAR_TargetButton.ClassTexture:Show()

			if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
				GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
			else
				GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
			end
			GVAR_TargetButton.SpecTexture:SetPoint("LEFT", GVAR_TargetButton.RoleTexture, "RIGHT", 0, 0)
			GVAR_TargetButton.ClassTexture:SetPoint("LEFT", GVAR_TargetButton.SpecTexture, "RIGHT", 0, 0)
			GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton.ClassTexture, "RIGHT", 0, 0)
		elseif ButtonShowRole and ButtonShowSpec then
			GVAR_TargetButton.RoleTexture:Show()
			GVAR_TargetButton.SpecTexture:Show()
			GVAR_TargetButton.ClassTexture:Hide()

			if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
				GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
			else
				GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
			end
			GVAR_TargetButton.SpecTexture:SetPoint("LEFT", GVAR_TargetButton.RoleTexture, "RIGHT", 0, 0)
			GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton.SpecTexture, "RIGHT", 0, 0)
		elseif ButtonShowRole and ButtonClassIcon then
			GVAR_TargetButton.RoleTexture:Show()
			GVAR_TargetButton.SpecTexture:Hide()
			GVAR_TargetButton.ClassTexture:Show()

			if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
				GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
			else
				GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
			end
			GVAR_TargetButton.ClassTexture:SetPoint("LEFT", GVAR_TargetButton.RoleTexture, "RIGHT", 0, 0)
			GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton.ClassTexture, "RIGHT", 0, 0)
		elseif ButtonShowSpec and ButtonClassIcon then
			GVAR_TargetButton.RoleTexture:Hide()
			GVAR_TargetButton.SpecTexture:Show()
			GVAR_TargetButton.ClassTexture:Show()

			if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
				GVAR_TargetButton.SpecTexture:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
			else
				GVAR_TargetButton.SpecTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
			end
			GVAR_TargetButton.ClassTexture:SetPoint("LEFT", GVAR_TargetButton.SpecTexture, "RIGHT", 0, 0)
			GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton.ClassTexture, "RIGHT", 0, 0)
		elseif ButtonShowRole then
			GVAR_TargetButton.RoleTexture:Show()
			GVAR_TargetButton.SpecTexture:Hide()
			GVAR_TargetButton.ClassTexture:Hide()

			if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
				GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
			else
				GVAR_TargetButton.RoleTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
			end

			GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton.RoleTexture, "RIGHT", 0, 0)
		elseif ButtonShowSpec then
			GVAR_TargetButton.RoleTexture:Hide()
			GVAR_TargetButton.SpecTexture:Show()
			GVAR_TargetButton.ClassTexture:Hide()

			if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
				GVAR_TargetButton.SpecTexture:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
			else
				GVAR_TargetButton.SpecTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
			end

			GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton.SpecTexture, "RIGHT", 0, 0)
		elseif ButtonClassIcon then
			GVAR_TargetButton.RoleTexture:Hide()
			GVAR_TargetButton.SpecTexture:Hide()
			GVAR_TargetButton.ClassTexture:Show()

			if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
				GVAR_TargetButton.ClassTexture:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
			else
				GVAR_TargetButton.ClassTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
			end

			GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton.ClassTexture, "RIGHT", 0, 0)
		else
			GVAR_TargetButton.RoleTexture:Hide()
			GVAR_TargetButton.SpecTexture:Hide()
			GVAR_TargetButton.ClassTexture:Hide()

			if ButtonRangeCheck and ButtonRangeDisplay < 7 then -- RANGE_DISP_LAY
				GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton.RangeTexture, "RIGHT", 0, 0)
			else
				GVAR_TargetButton.ClassColorBackground:SetPoint("LEFT", GVAR_TargetButton, "LEFT", 1, 0)
			end
		end

		GVAR_TargetButton.Name:SetFont(fButtonFontNameStyle, ButtonFontNameSize, "")
		GVAR_TargetButton.Name:SetHeight(backfallFontSize)

		GVAR_TargetButton.HealthText:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize, "OUTLINE")
		GVAR_TargetButton.HealthText:SetHeight(backfallFontSize)

		if ButtonShowTargetCount then
			healthBarWidth = withIconWidth-20
			GVAR_TargetButton.ClassColorBackground:SetWidth(withIconWidth-20)
			GVAR_TargetButton.HealthBar:SetWidth(withIconWidth-20)
			GVAR_TargetButton.Name:SetPoint("LEFT", GVAR_TargetButton.ClassColorBackground, "LEFT", 2, 0)
			GVAR_TargetButton.Name:SetWidth(withIconWidth-20-2)
			GVAR_TargetButton.TargetCountBackground:SetHeight(ButtonHeight_2)
			GVAR_TargetButton.TargetCountBackground:Show()
			GVAR_TargetButton.TargetCount:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize, "")
			GVAR_TargetButton.TargetCount:SetHeight(backfallFontSize)
			GVAR_TargetButton.TargetCount:SetText("")
			GVAR_TargetButton.TargetCount:Show()
		else
			healthBarWidth = withIconWidth
			GVAR_TargetButton.ClassColorBackground:SetWidth(withIconWidth)
			GVAR_TargetButton.HealthBar:SetWidth(withIconWidth)
			GVAR_TargetButton.Name:SetPoint("LEFT", GVAR_TargetButton.ClassColorBackground, "LEFT", 2, 0)
			GVAR_TargetButton.Name:SetWidth(withIconWidth-2)
			GVAR_TargetButton.TargetCountBackground:Hide()
			GVAR_TargetButton.TargetCount:Hide()
		end

		if ButtonShowTarget then
			local quad = ButtonHeight_2 * ButtonTargetScale
			local leftPos = -quad
			GVAR_TargetButton.TargetTexture:SetSize(quad, quad)
			if ButtonTargetPosition >= 100 then
				leftPos = ButtonWidth
			elseif ButtonTargetPosition > 0 then
				leftPos = ( (quad + ButtonWidth) * (ButtonTargetPosition/100) ) - quad
			end
			GVAR_TargetButton.TargetTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", leftPos, 0)
			GVAR_TargetButton.TargetTexture:Show()
		else
			GVAR_TargetButton.TargetTexture:Hide()
		end

		if ButtonShowFocus then
			local quad = ButtonHeight_2 * ButtonFocusScale
			local leftPos = -quad
			GVAR_TargetButton.FocusTexture:SetSize(quad, quad)
			if ButtonFocusPosition >= 100 then
				leftPos = ButtonWidth
			elseif ButtonFocusPosition > 0 then
				leftPos = ( (quad + ButtonWidth) * (ButtonFocusPosition/100) ) - quad
			end
			GVAR_TargetButton.FocusTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", leftPos, 0)
			GVAR_TargetButton.FocusTexture:Show()
		else
			GVAR_TargetButton.FocusTexture:Hide()
		end

		if ButtonShowFlag then
			local quad = ButtonHeight_2 * ButtonFlagScale
			local leftPos = -quad
			GVAR_TargetButton.FlagTexture:SetSize(quad, quad)
			if ButtonFlagPosition >= 100 then
				leftPos = ButtonWidth
			elseif ButtonFlagPosition > 0 then
				leftPos = ( (quad + ButtonWidth) * (ButtonFlagPosition/100) ) - quad
			end
			GVAR_TargetButton.FlagTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", leftPos, 0)
			GVAR_TargetButton.FlagTexture:Show()
			GVAR_TargetButton.FlagDebuff:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize, "OUTLINE")
			GVAR_TargetButton.FlagDebuff:SetHeight(backfallFontSize)
			GVAR_TargetButton.FlagDebuff:Show()
			GVAR_TargetButton.OrbDebuff:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize-2, "OUTLINE")
			GVAR_TargetButton.OrbDebuff:SetHeight(backfallFontSize)
			GVAR_TargetButton.OrbDebuff:Show()
			local size = ButtonHeight_2/4
			GVAR_TargetButton.OrbCornerTL:SetSize(size, size)
			GVAR_TargetButton.OrbCornerTR:SetSize(size, size)
			GVAR_TargetButton.OrbCornerBL:SetSize(size, size)
			GVAR_TargetButton.OrbCornerBR:SetSize(size, size)
			GVAR_TargetButton.OrbCornerTL:Show()
			GVAR_TargetButton.OrbCornerTR:Show()
			GVAR_TargetButton.OrbCornerBL:Show()
			GVAR_TargetButton.OrbCornerBR:Show()
		else
			GVAR_TargetButton.FlagTexture:Hide()
			GVAR_TargetButton.FlagDebuff:Hide()
			GVAR_TargetButton.OrbDebuff:Hide()
			GVAR_TargetButton.OrbCornerTL:Hide()
			GVAR_TargetButton.OrbCornerTR:Hide()
			GVAR_TargetButton.OrbCornerBL:Hide()
			GVAR_TargetButton.OrbCornerBR:Hide()
		end

		if ButtonShowAssist then
			local quad = ButtonHeight_2 * ButtonAssistScale
			local leftPos = -quad
			GVAR_TargetButton.AssistTexture:SetSize(quad, quad)
			if ButtonAssistPosition >= 100 then
				leftPos = ButtonWidth
			elseif ButtonAssistPosition > 0 then
				leftPos = ( (quad + ButtonWidth) * (ButtonAssistPosition/100) ) - quad
			end
			GVAR_TargetButton.AssistTexture:SetPoint("LEFT", GVAR_TargetButton, "LEFT", leftPos, 0)
			GVAR_TargetButton.AssistTexture:Show()
		else
			GVAR_TargetButton.AssistTexture:Hide()
		end
	end

	if BattlegroundTargets_Options.SummaryToggle[currentSize] then
		GVAR.Summary.HealerFriend:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize*2, "OUTLINE")
		GVAR.Summary.HealerEnemy:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize*2, "OUTLINE")
		GVAR.Summary.TankFriend:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize*2, "OUTLINE")
		GVAR.Summary.TankEnemy:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize*2, "OUTLINE")
		GVAR.Summary.DamageFriend:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize*2, "OUTLINE")
		GVAR.Summary.DamageEnemy:SetFont(fButtonFontNumberStyle, ButtonFontNumberSize*2, "OUTLINE")
	end

	reSetLayout = false
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:Frame_Toggle(frame, show)
	if show then
		frame:Show()
	else
		if frame:IsShown() then
			frame:Hide()
		else
			frame:Show()
		end
	end
end

function BattlegroundTargets:Frame_SetupPosition(frameName)
	if frameName == "BattlegroundTargets_MainFrame" then
		-- NEW 50200-3 or newer
		if BattlegroundTargets_Options.IndependentPositioning[currentSize] and BattlegroundTargets_Options.pos[frameName..currentSize] then
			local x = BattlegroundTargets_Options.pos[frameName..currentSize].x or 0
			local y = BattlegroundTargets_Options.pos[frameName..currentSize].y or 0
			local point = BattlegroundTargets_Options.pos[frameName..currentSize].point or "CENTER"
			local s = BattlegroundTargets_Options.pos[frameName..currentSize].s or 1
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint(point, UIParent, point, x/s, y/s)
		-- NEW 50200-3 or newer
		elseif BattlegroundTargets_Options.pos[frameName] then
			local x = BattlegroundTargets_Options.pos[frameName].x or 0
			local y = BattlegroundTargets_Options.pos[frameName].y or 0
			local point = BattlegroundTargets_Options.pos[frameName].point or "CENTER"
			local s = BattlegroundTargets_Options.pos[frameName].s or 1
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint(point, UIParent, point, x/s, y/s)
		-- OLD pre50200-3
		elseif BattlegroundTargets_Options.IndependentPositioning[currentSize] and BattlegroundTargets_Options.pos[frameName..currentSize.."_posX"] then
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", BattlegroundTargets_Options.pos[frameName..currentSize.."_posX"], BattlegroundTargets_Options.pos[frameName..currentSize.."_posY"])
			BattlegroundTargets_Options.pos[frameName..currentSize.."_posX"] = nil
			BattlegroundTargets_Options.pos[frameName..currentSize.."_posY"] = nil
			BattlegroundTargets:Frame_SavePosition(frameName) --> save NEW pos
		-- OLD pre50200-3
		elseif BattlegroundTargets_Options.pos[frameName.."_posX"] then
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", BattlegroundTargets_Options.pos[frameName.."_posX"], BattlegroundTargets_Options.pos[frameName.."_posY"])
			BattlegroundTargets_Options.pos[frameName.."_posX"] = nil
			BattlegroundTargets_Options.pos[frameName.."_posY"] = nil
			BattlegroundTargets:Frame_SavePosition(frameName) --> save NEW pos
		-- default pos
		else
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint("TOPRIGHT", GVAR.OptionsFrame, "TOPLEFT", -80, 19)
			local X = _G[frameName]:GetLeft()
			local Y = _G[frameName]:GetTop()
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", X, Y)
		end
	elseif frameName == "BattlegroundTargets_OptionsFrame" then
		-- NEW 50200-3 or newer
		if BattlegroundTargets_Options.pos[frameName] then
			local x = BattlegroundTargets_Options.pos[frameName].x or 0
			local y = BattlegroundTargets_Options.pos[frameName].y or 0
			local point = BattlegroundTargets_Options.pos[frameName].point or "CENTER"
			local s = BattlegroundTargets_Options.pos[frameName].s or 1
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint(point, UIParent, point, x/s, y/s)
		-- OLD pre50200-3
		elseif BattlegroundTargets_Options.pos[frameName.."_posX"] then
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", BattlegroundTargets_Options.pos[frameName.."_posX"], BattlegroundTargets_Options.pos[frameName.."_posY"])
			BattlegroundTargets_Options.pos[frameName.."_posX"] = nil
			BattlegroundTargets_Options.pos[frameName.."_posY"] = nil
			BattlegroundTargets:Frame_SavePosition(frameName) --> save NEW pos
		-- default pos
		else
			_G[frameName]:ClearAllPoints()
			_G[frameName]:SetPoint("CENTER", UIParent, "CENTER", 0, 50)
		end
	end
end

function BattlegroundTargets:Frame_SavePosition(frameName)
	-- from LibWindow-1.1
	local frame = _G[frameName]
	local s = frame:GetScale()
	local left, top = frame:GetLeft()*s, frame:GetTop()*s
	local right, bottom = frame:GetRight()*s, frame:GetBottom()*s
	local pwidth, pheight = UIParent:GetWidth(), UIParent:GetHeight()
	local x, y, point
	if left < (pwidth-right) and left < abs((left+right)/2 - pwidth/2) then
		x = left
		point = "LEFT"
	elseif (pwidth-right) < abs((left+right)/2 - pwidth/2) then
		x = right-pwidth
		point = "RIGHT"
	else
		x = (left+right)/2 - pwidth/2
		point = ""
	end
	if bottom < (pheight-top) and bottom < abs((bottom+top)/2 - pheight/2) then
		y = bottom
		point = "BOTTOM"..point
	elseif (pheight-top) < abs((bottom+top)/2 - pheight/2) then
		y = top-pheight
		point = "TOP"..point
	else
		y = (bottom+top)/2 - pheight/2
	end
	if point == "" then
		point = "CENTER"
	end
	-- ------------------

	local varName = frameName
	if frameName == "BattlegroundTargets_MainFrame" and BattlegroundTargets_Options.IndependentPositioning[currentSize] then
		varName = frameName..currentSize
	end
	--print("varName:", varName, "x:", x, "y:", y, "point:", point, "scale:", s)
	BattlegroundTargets_Options.pos[varName] = {}
	BattlegroundTargets_Options.pos[varName].x = x
	BattlegroundTargets_Options.pos[varName].y = y
	BattlegroundTargets_Options.pos[varName].point = point
	BattlegroundTargets_Options.pos[varName].s = s

	_G[frameName]:ClearAllPoints()
	_G[frameName]:SetPoint(point, UIParent, point, x/s, y/s)
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:OptionsFrameHide()
	PlaySound("igQuestListClose")
	isConfig = false
	BattlegroundTargets:EventRegister()
	testData.Loaded = false
	TEMPLATE.EnableTextButton(GVAR.InterfaceOptions.CONFIG)
	BattlegroundTargets:DisableConfigMode()
end

function BattlegroundTargets:OptionsFrameShow()
	PlaySound("igQuestListOpen")
	isConfig = true
	BattlegroundTargets:UnregisterEvent("UPDATE_BATTLEFIELD_SCORE")
	BattlegroundTargets:UnregisterEvent("GROUP_ROSTER_UPDATE")
	BattlegroundTargets:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	BattlegroundTargets:UnregisterEvent("UNIT_HEALTH_FREQUENT")
	BattlegroundTargets:UnregisterEvent("UNIT_TARGET")
	BattlegroundTargets:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	BattlegroundTargets:UnregisterEvent("PLAYER_TARGET_CHANGED")
	BattlegroundTargets:UnregisterEvent("PLAYER_FOCUS_CHANGED")
	TEMPLATE.DisableTextButton(GVAR.InterfaceOptions.CONFIG)
	BattlegroundTargets:Frame_SetupPosition("BattlegroundTargets_OptionsFrame")
	GVAR.OptionsFrame:StartMoving()
	GVAR.OptionsFrame:StopMovingOrSizing()

	if inBattleground then
		testSize = currentSize
	end

	GVAR.OptionsFrame.ConfigGeneral:Hide()
	GVAR.OptionsFrame.ConfigBrackets:Show()

	if testSize == 10 then
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, true)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, nil)
	elseif testSize == 15 then
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, true)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, nil)
	elseif testSize == 40 then
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabGeneral, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, true)
	end

	if inCombat or InCombatLockdown() then
		BattlegroundTargets:DisableInsecureConfigWidges()
	else
		BattlegroundTargets:EnableInsecureConfigWidges()
	end

	if BattlegroundTargets_Options.EnableBracket[testSize] then
		BattlegroundTargets:EnableConfigMode()
	else
		BattlegroundTargets:DisableConfigMode()
	end
end
-- ---------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:LocalizedFontNameTest(show, font)
	if show then
		if font then
			local f = fontStyles[font].font
			local s = OPT.ButtonFontNameSize[currentSize]
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				GVAR_TargetButton[i].Name:SetFont(f, s, "")
			end
		end
		if IsModifierKeyDown() then return end
		GVAR.TargetButton[1].Name:SetText(L["Test_abc_"])
		GVAR.TargetButton[2].Name:SetText(L["Test_koKR_"])
		GVAR.TargetButton[3].Name:SetText(L["Test_ruRU_"])
		GVAR.TargetButton[4].Name:SetText(L["Test_zhCN_"])
		GVAR.TargetButton[5].Name:SetText(L["Test_zhTW_"])
		GVAR.TargetButton[6].Name:SetText(L["Test_Latin1_"])
		GVAR.TargetButton[7].Name:SetText(L["Test_Latin2_"])
		GVAR.TargetButton[8].Name:SetText(L["Test_Latin3_"])
		GVAR.TargetButton[9].Name:SetText(L["Test_Latin4_"])
		GVAR.TargetButton[10].Name:SetText(L["Test_Latin5_"])
	else
		if font then
			local f = fontStyles[ OPT.ButtonFontNameStyle[currentSize] ].font
			local s = OPT.ButtonFontNameSize[currentSize]
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				GVAR_TargetButton[i].Name:SetFont(f, s, "")
			end
		end
		if isLowLevel then
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, 10 do
				GVAR_TargetButton[i].Name:SetText(playerLevel.." "..GVAR_TargetButton[i].name4button)
			end
		else
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, 10 do
				GVAR_TargetButton[i].Name:SetText(GVAR_TargetButton[i].name4button)
			end
		end
	end
end

function BattlegroundTargets:LocalizedFontNumberTest(show, font)
	if show then
		local f = fontStyles[font].font
		local s = OPT.ButtonFontNumberSize[currentSize]
		for i = 1, currentSize do
			local GVAR_TargetButton = GVAR.TargetButton[i]
			GVAR_TargetButton.HealthText:SetFont(f, s, "OUTLINE")
			GVAR_TargetButton.TargetCount:SetFont(f, s, "")
			GVAR_TargetButton.FlagDebuff:SetFont(f, s, "OUTLINE")
			GVAR_TargetButton.OrbDebuff:SetFont(f, s-2, "OUTLINE")
		end
		GVAR.Summary.HealerFriend:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.HealerEnemy:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.TankFriend:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.TankEnemy:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.DamageFriend:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.DamageEnemy:SetFont(f, s*2, "OUTLINE")
	else
		local f = fontStyles[ OPT.ButtonFontNumberStyle[currentSize] ].font
		local s = OPT.ButtonFontNumberSize[currentSize]
		for i = 1, currentSize do
			local GVAR_TargetButton = GVAR.TargetButton[i]
			GVAR_TargetButton.HealthText:SetFont(f, s, "OUTLINE")
			GVAR_TargetButton.TargetCount:SetFont(f, s, "")
			GVAR_TargetButton.FlagDebuff:SetFont(f, s, "OUTLINE")
			GVAR_TargetButton.OrbDebuff:SetFont(f, s-2, "OUTLINE")
		end
		GVAR.Summary.HealerFriend:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.HealerEnemy:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.TankFriend:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.TankEnemy:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.DamageFriend:SetFont(f, s*2, "OUTLINE")
		GVAR.Summary.DamageEnemy:SetFont(f, s*2, "OUTLINE")
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:EnableConfigMode()
	if inCombat or InCombatLockdown() then
		reCheckBG = true
		return
	end

	if not testData.Loaded then
		wipe(ENEMY_Data)

		ENEMY_Data[1]  = {name = L["Target"].."_Aa-servername", classToken = "DRUID",       talentSpec = classes["DRUID"      ].spec[3].specName}
		ENEMY_Data[2]  = {name = L["Target"].."_Bb-servername", classToken = "PRIEST",      talentSpec = classes["PRIEST"     ].spec[3].specName}
		ENEMY_Data[3]  = {name = L["Target"].."_Cc-servername", classToken = "MONK",        talentSpec = classes["MONK"       ].spec[2].specName}
		ENEMY_Data[4]  = {name = L["Target"].."_Dd-servername", classToken = "HUNTER",      talentSpec = classes["HUNTER"     ].spec[3].specName}
		ENEMY_Data[5]  = {name = L["Target"].."_Ee-servername", classToken = "WARRIOR",     talentSpec = classes["WARRIOR"    ].spec[3].specName}
		ENEMY_Data[6]  = {name = L["Target"].."_Ff-servername", classToken = "ROGUE",       talentSpec = classes["ROGUE"      ].spec[2].specName}
		ENEMY_Data[7]  = {name = L["Target"].."_Gg-servername", classToken = "SHAMAN",      talentSpec = classes["SHAMAN"     ].spec[3].specName}
		ENEMY_Data[8]  = {name = L["Target"].."_Hh-servername", classToken = "PALADIN",     talentSpec = classes["PALADIN"    ].spec[3].specName}
		ENEMY_Data[9]  = {name = L["Target"].."_Ii-servername", classToken = "MAGE",        talentSpec = classes["MAGE"       ].spec[3].specName}
		ENEMY_Data[10] = {name = L["Target"].."_Jj-servername", classToken = "DEATHKNIGHT", talentSpec = classes["DEATHKNIGHT"].spec[2].specName}
		ENEMY_Data[11] = {name = L["Target"].."_Kk-servername", classToken = "DRUID",       talentSpec = classes["DRUID"      ].spec[1].specName}
		ENEMY_Data[12] = {name = L["Target"].."_Ll-servername", classToken = "DEATHKNIGHT", talentSpec = classes["DEATHKNIGHT"].spec[3].specName}
		ENEMY_Data[13] = {name = L["Target"].."_Mm-servername", classToken = "PALADIN",     talentSpec = classes["PALADIN"    ].spec[3].specName}
		ENEMY_Data[14] = {name = L["Target"].."_Nn-servername", classToken = "MAGE",        talentSpec = classes["MAGE"       ].spec[1].specName}
		ENEMY_Data[15] = {name = L["Target"].."_Oo-servername", classToken = "SHAMAN",      talentSpec = classes["SHAMAN"     ].spec[2].specName}
		ENEMY_Data[16] = {name = L["Target"].."_Pp-servername", classToken = "ROGUE",       talentSpec = classes["ROGUE"      ].spec[1].specName}
		ENEMY_Data[17] = {name = L["Target"].."_Qq-servername", classToken = "WARLOCK",     talentSpec = classes["WARLOCK"    ].spec[2].specName}
		ENEMY_Data[18] = {name = L["Target"].."_Rr-servername", classToken = "PRIEST",      talentSpec = classes["PRIEST"     ].spec[3].specName}
		ENEMY_Data[19] = {name = L["Target"].."_Ss-servername", classToken = "WARRIOR",     talentSpec = classes["WARRIOR"    ].spec[1].specName}
		ENEMY_Data[20] = {name = L["Target"].."_Tt-servername", classToken = "DRUID",       talentSpec = classes["DRUID"      ].spec[2].specName}
		ENEMY_Data[21] = {name = L["Target"].."_Uu-servername", classToken = "PRIEST",      talentSpec = classes["PRIEST"     ].spec[3].specName}
		ENEMY_Data[22] = {name = L["Target"].."_Vv-servername", classToken = "MONK",        talentSpec = classes["MONK"       ].spec[1].specName}
		ENEMY_Data[23] = {name = L["Target"].."_Ww-servername", classToken = "SHAMAN",      talentSpec = classes["SHAMAN"     ].spec[1].specName}
		ENEMY_Data[24] = {name = L["Target"].."_Xx-servername", classToken = "HUNTER",      talentSpec = classes["HUNTER"     ].spec[2].specName}
		ENEMY_Data[25] = {name = L["Target"].."_Yy-servername", classToken = "SHAMAN",      talentSpec = classes["SHAMAN"     ].spec[2].specName}
		ENEMY_Data[26] = {name = L["Target"].."_Zz-servername", classToken = "WARLOCK",     talentSpec = classes["WARLOCK"    ].spec[3].specName}
		ENEMY_Data[27] = {name = L["Target"].."_Ab-servername", classToken = "PRIEST",      talentSpec = classes["PRIEST"     ].spec[2].specName}
		ENEMY_Data[28] = {name = L["Target"].."_Cd-servername", classToken = "MONK",        talentSpec = classes["MONK"       ].spec[3].specName}
		ENEMY_Data[29] = {name = L["Target"].."_Ef-servername", classToken = "ROGUE",       talentSpec = classes["ROGUE"      ].spec[3].specName}
		ENEMY_Data[30] = {name = L["Target"].."_Gh-servername", classToken = "DRUID",       talentSpec = classes["DRUID"      ].spec[4].specName}
		ENEMY_Data[31] = {name = L["Target"].."_Ij-servername", classToken = "HUNTER",      talentSpec = classes["HUNTER"     ].spec[3].specName}
		ENEMY_Data[32] = {name = L["Target"].."_Kl-servername", classToken = "WARRIOR",     talentSpec = classes["WARRIOR"    ].spec[2].specName}
		ENEMY_Data[33] = {name = L["Target"].."_Mn-servername", classToken = "PALADIN",     talentSpec = classes["PALADIN"    ].spec[1].specName}
		ENEMY_Data[34] = {name = L["Target"].."_Op-servername", classToken = "MAGE",        talentSpec = classes["MAGE"       ].spec[3].specName}
		ENEMY_Data[35] = {name = L["Target"].."_Qr-servername", classToken = "DEATHKNIGHT", talentSpec = classes["DEATHKNIGHT"].spec[3].specName}
		ENEMY_Data[36] = {name = L["Target"].."_St-servername", classToken = "MAGE",        talentSpec = classes["MAGE"       ].spec[2].specName}
		ENEMY_Data[37] = {name = L["Target"].."_Uv-servername", classToken = "HUNTER",      talentSpec = classes["HUNTER"     ].spec[2].specName}
		ENEMY_Data[38] = {name = L["Target"].."_Wx-servername", classToken = "WARLOCK",     talentSpec = classes["WARLOCK"    ].spec[1].specName}
		ENEMY_Data[39] = {name = L["Target"].."_Yz-servername", classToken = "WARLOCK",     talentSpec = classes["WARLOCK"    ].spec[2].specName}
		ENEMY_Data[40] = {name = L["Target"].."_Zx-servername", classToken = "ROGUE",       talentSpec = nil}

		for i = 1, 40 do
			local role = 4
			local spec = 5
			
			local talentSpec = ENEMY_Data[i].talentSpec
			local classToken = ENEMY_Data[i].classToken
			
			if talentSpec and classToken then
				local token = classes[classToken]
				if token then
					if token.spec[1] and talentSpec == token.spec[1].specName then
						role = classes[classToken].spec[1].role
						spec = 1
					elseif token.spec[2] and talentSpec == token.spec[2].specName then
						role = classes[classToken].spec[2].role
						spec = 2
					elseif token.spec[3] and talentSpec == token.spec[3].specName then
						role = classes[classToken].spec[3].role
						spec = 3
					elseif token.spec[4] and talentSpec == token.spec[4].specName then
						role = classes[classToken].spec[4].role
						spec = 4
					end
				end
			end
			ENEMY_Data[i].specNum = spec
			ENEMY_Data[i].talentSpec = role
		end

		testData.Loaded = true
	end

	currentSize = testSize
	BattlegroundTargets:SetOptions()

	BattlegroundTargets:Frame_SetupPosition("BattlegroundTargets_MainFrame")
	GVAR.MainFrame:EnableMouse(true)
	GVAR.MainFrame:SetAlpha(1)
	GVAR.MainFrame:Show() -- POSiCHK
	GVAR.MainFrameMoverFrame:Show()
	GVAR.ScoreUpdateTexture:Show()
	GVAR.IsGhostTexture:Show()

	BattlegroundTargets:ShufflerFunc("ShuffleCheck")
	BattlegroundTargets:SetupButtonLayout()
	BattlegroundTargets:MainDataUpdate()
	BattlegroundTargets:SetConfigButtonValues()

	for i = 1, 40 do
		if i < currentSize+1 then
			GVAR.TargetButton[i]:Show()
		else
			GVAR.TargetButton[i]:Hide()
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:DisableConfigMode()
	if inCombat or InCombatLockdown() then
		reCheckBG = true
		return
	end

	currentSize = testSize
	BattlegroundTargets:SetOptions()

	GVAR.MainFrame:Hide()
	for i = 1, 40 do
		GVAR.TargetButton[i]:Hide()
	end

	if isConfig then return end

	local curTime = GetTime()
	scoreFrequency = 0 -- immediate score update
	targetCountUpdate = curTime - targetCountFrequency

	BattlegroundTargets:BattlefieldCheck()
	if not inBattleground then return end
	if not BattlegroundTargets_Options.EnableBracket[currentSize] then return end

	BattlegroundTargets:CheckIfPlayerIsGhost()

	if OPT.ButtonShowTarget[currentSize] then
		BattlegroundTargets:CheckPlayerTarget()
	end
	if OPT.ButtonShowAssist[currentSize] then
		BattlegroundTargets:CheckAssist()
	end
	if OPT.ButtonShowFocus[currentSize] then
		BattlegroundTargets:CheckPlayerFocus()
	end
	if OPT.ButtonRangeCheck[currentSize] then
		BattlegroundTargets:UpdateRange(curTime)
	end

	if OPT.ButtonShowFlag[currentSize] then
		if isFlagBG == 1 or isFlagBG == 2 or isFlagBG == 3 or isFlagBG == 4 then
			if hasFlag then
				local Name2Button = ENEMY_Name2Button[hasFlag]
				if Name2Button then
					local GVAR_TargetButton = GVAR.TargetButton[Name2Button]
					if GVAR_TargetButton then
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
					end
				end
			end
		elseif isFlagBG == 5 then
			for k, v in pairs(hasOrb) do
				if v.name then
					local Name2Button = ENEMY_Name2Button[v.name]
					if Name2Button then
						local GVAR_TargetButton = GVAR.TargetButton[Name2Button]
						if GVAR_TargetButton then
							GVAR.TargetButton[Name2Button].orbColor = k
							GVAR_TargetButton.FlagTexture:SetAlpha(1)
							GVAR_TargetButton.FlagTexture:SetTexture(orbIDs[ orbColIDs[k] ].texture)
							BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton, v.orbval)
							BattlegroundTargets:SetOrbCorner(GVAR_TargetButton, k)
						end
					end
				end
			end
		end
	else
		BattlegroundTargets:CheckFlagCarrierEND()
	end

	if OPT.ButtonShowLeader[currentSize] then
		if isLeader then
			local Name2Button = ENEMY_Name2Button[isLeader]
			if Name2Button then
				local GVAR_TargetButton = GVAR.TargetButton[Name2Button]
				if GVAR_TargetButton then
					GVAR_TargetButton.LeaderTexture:SetAlpha(0.75)
				end
			end
		end
	end
	
	if curTime - scoreLastUpdate >= scoreWarning then
		GVAR.ScoreUpdateTexture:Show()
	else
		GVAR.ScoreUpdateTexture:Hide()
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:SetConfigButtonValues()
	local ButtonShowHealthBar   = OPT.ButtonShowHealthBar[currentSize]
	local ButtonShowHealthText  = OPT.ButtonShowHealthText[currentSize]
	local ButtonRangeCheck      = OPT.ButtonRangeCheck[currentSize]
	local ButtonRangeDisplay    = OPT.ButtonRangeDisplay[currentSize]

	for i = 1, currentSize do
		local GVAR_TargetButton = GVAR.TargetButton[i]

		-- target, targetcount, focus, flag, assist, leader
		GVAR_TargetButton.TargetTexture:SetAlpha(0)
		GVAR_TargetButton.HighlightT:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightR:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightB:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightL:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.TargetCount:SetText("0")
		GVAR_TargetButton.FocusTexture:SetAlpha(0)
		GVAR_TargetButton.FlagTexture:SetAlpha(0)
		GVAR_TargetButton.FlagDebuff:SetText("")
		GVAR_TargetButton.OrbDebuff:SetText("")
		GVAR_TargetButton.OrbCornerTL:SetAlpha(0)
		GVAR_TargetButton.OrbCornerTR:SetAlpha(0)
		GVAR_TargetButton.OrbCornerBL:SetAlpha(0)
		GVAR_TargetButton.OrbCornerBR:SetAlpha(0)
		GVAR_TargetButton.AssistTexture:SetAlpha(0)
		GVAR_TargetButton.LeaderTexture:SetAlpha(0)

		-- health
		if ButtonShowHealthBar then
			local width = healthBarWidth * (testData.Health[i] / 100)
			width = math_max(0.01, width)
			width = math_min(healthBarWidth, width)
			GVAR_TargetButton.HealthBar:SetWidth(width)
		else
			GVAR_TargetButton.HealthBar:SetWidth(healthBarWidth)
		end
		if ButtonShowHealthText then
			GVAR_TargetButton.HealthText:SetText(testData.Health[i])
		else
			GVAR_TargetButton.HealthText:SetText("")
		end

		-- range
		if ButtonRangeCheck then
			if testData.Range[i] < 40 then
				Range_Display(true, GVAR_TargetButton)
			else
				Range_Display(false, GVAR_TargetButton, ButtonRangeDisplay)
			end
		else
			Range_Display(true, GVAR_TargetButton)
		end
	end

	-- leader, target, focus, flag, assist
	isTarget = 0
	if OPT.ButtonShowTarget[currentSize] then
		local GVAR_TargetButton = GVAR.TargetButton[testData.IconTarget]
		GVAR_TargetButton.TargetTexture:SetAlpha(1)
		GVAR_TargetButton.HighlightT:SetTexture(0.5, 0.5, 0.5, 1)
		GVAR_TargetButton.HighlightR:SetTexture(0.5, 0.5, 0.5, 1)
		GVAR_TargetButton.HighlightB:SetTexture(0.5, 0.5, 0.5, 1)
		GVAR_TargetButton.HighlightL:SetTexture(0.5, 0.5, 0.5, 1)
		isTarget = testData.IconTarget
	end
	if OPT.ButtonShowFocus[currentSize] then
		GVAR.TargetButton[testData.IconFocus].FocusTexture:SetAlpha(1)
	end
	if OPT.ButtonShowFlag[currentSize] then
		if currentSize == 10 or currentSize == 15 then
			if testData.CarrierDisplay == "flag" then
				local quad = (OPT.ButtonHeight[currentSize]-2) * OPT.ButtonFlagScale[currentSize]
				GVAR.TargetButton[testData.IconFlag.button].FlagTexture:SetSize(quad, quad)
				GVAR.TargetButton[testData.IconFlag.button].FlagTexture:SetTexture(Textures.flagTexture)
				GVAR.TargetButton[testData.IconFlag.button].FlagTexture:SetTexCoord(0.15625001, 0.84374999, 0.15625001, 0.84374999)--(5/32, 27/32, 5/32, 27/32)
				GVAR.TargetButton[testData.IconFlag.button].FlagTexture:SetAlpha(1)
				GVAR.TargetButton[testData.IconFlag.button].FlagDebuff:SetText(testData.IconFlag.txt)
			elseif testData.CarrierDisplay == "orb" then
				local quad = (OPT.ButtonHeight[currentSize]-2) * OPT.ButtonFlagScale[currentSize] * 1.3
				for k, v in pairs(testData.IconOrb) do
					if v.button then
						GVAR.TargetButton[v.button].FlagTexture:SetSize(quad, quad)
						GVAR.TargetButton[v.button].FlagTexture:SetTexture(orbIDs[ k ].texture)
						GVAR.TargetButton[v.button].FlagTexture:SetTexCoord(0.0625, 0.9375, 0.0625, 0.9375)--(2/32, 30/32, 2/32, 30/32)
						GVAR.TargetButton[v.button].FlagTexture:SetAlpha(1)
						BattlegroundTargets:SetOrbDebuff(GVAR.TargetButton[v.button], v.orbval)
						BattlegroundTargets:SetOrbCorner(GVAR.TargetButton[v.button], orbIDs[k].color)
					end
				end
			elseif testData.CarrierDisplay == "cart" then
				local quad = (OPT.ButtonHeight[currentSize]-2) * OPT.ButtonFlagScale[currentSize] * 1.1
				GVAR.TargetButton[testData.IconFlag.button].FlagTexture:SetSize(quad, quad)
				GVAR.TargetButton[testData.IconFlag.button].FlagTexture:SetTexture(Textures.cartTexture)
				GVAR.TargetButton[testData.IconFlag.button].FlagTexture:SetTexCoord(0.09375, 0.90625, 0.09375, 0.90625)--(3/32, 29/32, 3/32, 29/32)
				GVAR.TargetButton[testData.IconFlag.button].FlagTexture:SetAlpha(1)
				GVAR.TargetButton[testData.IconFlag.button].FlagDebuff:SetText("")
			end
		end
	end
	if OPT.ButtonShowAssist[currentSize] then
		GVAR.TargetButton[testData.IconAssi].AssistTexture:SetAlpha(1)
	end
	if OPT.ButtonShowLeader[currentSize] then
		GVAR.TargetButton[testData.Leader].LeaderTexture:SetAlpha(0.75)
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:ClearConfigButtonValues(GVAR_TargetButton, clearRange)
	GVAR_TargetButton.colR  = 0
	GVAR_TargetButton.colG  = 0
	GVAR_TargetButton.colB  = 0
	GVAR_TargetButton.colR5 = 0
	GVAR_TargetButton.colG5 = 0
	GVAR_TargetButton.colB5 = 0

	-- target, targetcount, focus, flag, assist, leader
	GVAR_TargetButton.TargetTexture:SetAlpha(0)
	GVAR_TargetButton.HighlightT:SetTexture(0, 0, 0, 1)
	GVAR_TargetButton.HighlightR:SetTexture(0, 0, 0, 1)
	GVAR_TargetButton.HighlightB:SetTexture(0, 0, 0, 1)
	GVAR_TargetButton.HighlightL:SetTexture(0, 0, 0, 1)
	GVAR_TargetButton.TargetCount:SetText("")
	GVAR_TargetButton.FocusTexture:SetAlpha(0)
	GVAR_TargetButton.FlagTexture:SetAlpha(0)
	GVAR_TargetButton.FlagDebuff:SetText("")
	GVAR_TargetButton.OrbDebuff:SetText("")
	GVAR_TargetButton.OrbCornerTL:SetAlpha(0)
	GVAR_TargetButton.OrbCornerTR:SetAlpha(0)
	GVAR_TargetButton.OrbCornerBL:SetAlpha(0)
	GVAR_TargetButton.OrbCornerBR:SetAlpha(0)
	GVAR_TargetButton.AssistTexture:SetAlpha(0)
	GVAR_TargetButton.LeaderTexture:SetAlpha(0)

	-- health
	GVAR_TargetButton.HealthBar:SetTexture(0, 0, 0, 0)
	GVAR_TargetButton.HealthBar:SetWidth(healthBarWidth)
	GVAR_TargetButton.HealthText:SetText("")

	-- range
	GVAR_TargetButton.RangeTexture:SetTexture(0, 0, 0, 0)

	-- basics
	GVAR_TargetButton.Name:SetText("")
	GVAR_TargetButton.RoleTexture:SetTexCoord(0, 0, 0, 0)
	GVAR_TargetButton.SpecTexture:SetTexture(nil)
	GVAR_TargetButton.ClassTexture:SetTexCoord(0, 0, 0, 0)
	GVAR_TargetButton.ClassColorBackground:SetTexture(0, 0, 0, 0)
	
	if clearRange then
		if OPT.ButtonRangeCheck[currentSize] then
			Range_Display(false, GVAR_TargetButton, OPT.ButtonRangeDisplay[currentSize])
		else
			Range_Display(true, GVAR_TargetButton)
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:DefaultShuffle()
	-- health range
	for i = 1, 40 do
		testData.Health[i] = random(0,100)
		testData.Range[i] = random(0,100)
	end
	-- target focus assi leader
	testData.IconTarget = random(1,10)
	testData.IconFocus = random(1,10)
	testData.IconAssi = random(1,10)
	testData.Leader = random(1,10)
	-- flag
	testData.IconFlag.button = random(1,10)
	testData.IconFlag.txt = random(1,10)
	-- orb
	local count = 1
	for k, v in pairs(testData.IconOrb) do
		if count == 1 then            --    10   20   30   40   50   60   70   80   90  100  100  100  100  100  100  100  100  100  100  100 - Increases damage done by x%.
		   v.button = random(1,10)    --    -5  -10  -15  -20  -25  -30  -35  -40  -45  -50  -55  -60  -65  -70  -75  -80  -85  -90  -95 -100 - Reduces healing received by x%.
		   v.orbval = random(1,20)*30 --->  30   60   90  120  150  180  210  240  270  300  330  360  390  420  450  480  510  540  570  600 - Increases damage taken by x%.
		   count = 2
		else
			v.button = nil
			v.orbval = nil
			if random(0,100) > 50 then
				local b = random(1,10)
				local numExists
				for k2, v2 in pairs(testData.IconOrb) do
					if v2.button == b then
						numExists = true
						break
					end
				end
				if not numExists then
					v.button = b
					v.orbval = random(1,20)*30
				end
			end
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:ShufflerFunc(what)
	if what == "OnLeave" then
		GVAR.OptionsFrame:SetScript("OnUpdate", nil)
		GVAR.OptionsFrame.TestShuffler.Texture:SetSize(32, 32)
		GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetSize(32, 32)
	elseif what == "OnEnter" then
		BattlegroundTargets.elapsed = 1
		BattlegroundTargets.progBit = true
		if not BattlegroundTargets.progNum then BattlegroundTargets.progNum = 0 end
		if not BattlegroundTargets.progMod then BattlegroundTargets.progMod = 0 end
		GVAR.OptionsFrame:SetScript("OnUpdate", function(self, elap)
			if inCombat then GVAR.OptionsFrame:SetScript("OnUpdate", nil) return end
			BattlegroundTargets.elapsed = BattlegroundTargets.elapsed + elap
			if BattlegroundTargets.elapsed < 0.4 then return end
			BattlegroundTargets.elapsed = 0
			BattlegroundTargets:Shuffle(BattlegroundTargets.shuffleStyle)
		end)
	elseif what == "OnClick" then
		GVAR.OptionsFrame.TestShuffler.Texture:SetSize(32, 32)
		GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetSize(32, 32)
		BattlegroundTargets.shuffleStyle = not BattlegroundTargets.shuffleStyle
		if BattlegroundTargets.shuffleStyle then
			GVAR.OptionsFrame.TestShuffler.Texture:SetTexture("Interface\\Icons\\INV_Sigil_Thorim")
		else
			GVAR.OptionsFrame.TestShuffler.Texture:SetTexture("Interface\\Icons\\INV_Sigil_Mimiron")
		end
	elseif what == "OnMouseDown" then
		GVAR.OptionsFrame.TestShuffler.Texture:SetSize(30, 30)
		GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetSize(30, 30)
	elseif what == "ShuffleCheck" then
		if OPT.ButtonShowTarget[currentSize] or
		   OPT.ButtonShowFlag[currentSize] or
		   OPT.ButtonShowHealthBar[currentSize] or
		   OPT.ButtonShowHealthText[currentSize] or
		   OPT.ButtonShowFocus[currentSize] or
		   OPT.ButtonShowAssist[currentSize] or
		   OPT.ButtonShowLeader[currentSize] or
		   OPT.ButtonRangeCheck[currentSize]
		then
			GVAR.OptionsFrame.TestShuffler:Show()
		else
			GVAR.OptionsFrame.TestShuffler:Hide()
		end
	end
end

function BattlegroundTargets:Shuffle(shuffleStyle)
	BattlegroundTargets.progBit = not BattlegroundTargets.progBit
	if BattlegroundTargets.progBit then
		GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetAlpha(0)
	else
		GVAR.OptionsFrame.TestShuffler.TextureHighlight:SetAlpha(0.5)
	end	

	if shuffleStyle then
		BattlegroundTargets:DefaultShuffle()
	else
		if BattlegroundTargets.progMod == 0 then
			BattlegroundTargets.progNum = BattlegroundTargets.progNum + 1
		else
			BattlegroundTargets.progNum = BattlegroundTargets.progNum - 1
		end
		if BattlegroundTargets.progNum >= 10 then
			BattlegroundTargets.progNum = 10
			BattlegroundTargets.progMod = 1
		elseif BattlegroundTargets.progNum <= 1 then
			BattlegroundTargets.progNum = 1
			BattlegroundTargets.progMod = 0
		end
		testData.IconTarget = BattlegroundTargets.progNum
		testData.IconFocus = BattlegroundTargets.progNum
		testData.IconAssi = BattlegroundTargets.progNum
		testData.Leader = BattlegroundTargets.progNum

		testData.IconFlag.button  = BattlegroundTargets.progNum
		testData.IconFlag.txt  = BattlegroundTargets.progNum

		local num = BattlegroundTargets.progNum * 60 -- * 2 * 30
		for k, v in pairs(testData.IconOrb) do
			if v.button then
				v.button = BattlegroundTargets.progNum
				v.orbval = num
			end
		end

		local num = BattlegroundTargets.progNum * 10
		for i = 1, 40 do
			testData.Health[i] = num
			testData.Range[i] = 100
		end
		testData.Range[BattlegroundTargets.progNum] = 30
	end

	BattlegroundTargets:SetConfigButtonValues()
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CopySettings(sourceSize)
	local destinationSize = 10
	if sourceSize == 10 then
		destinationSize = 15
	end

	BattlegroundTargets_Options.LayoutTH[destinationSize]                 = BattlegroundTargets_Options.LayoutTH[sourceSize]
	BattlegroundTargets_Options.LayoutSpace[destinationSize]              = BattlegroundTargets_Options.LayoutSpace[sourceSize]

	BattlegroundTargets_Options.SummaryToggle[destinationSize]            = BattlegroundTargets_Options.SummaryToggle[sourceSize]
	BattlegroundTargets_Options.SummaryScale[destinationSize]             = BattlegroundTargets_Options.SummaryScale[sourceSize]
	BattlegroundTargets_Options.SummaryPos[destinationSize]               = BattlegroundTargets_Options.SummaryPos[sourceSize]

	BattlegroundTargets_Options.ButtonShowRole[destinationSize]           = BattlegroundTargets_Options.ButtonShowRole[sourceSize]
	                        OPT.ButtonShowRole[destinationSize]           =                         OPT.ButtonShowRole[sourceSize]
	BattlegroundTargets_Options.ButtonShowSpec[destinationSize]           = BattlegroundTargets_Options.ButtonShowSpec[sourceSize]
	                        OPT.ButtonShowSpec[destinationSize]           =                         OPT.ButtonShowSpec[sourceSize]
	BattlegroundTargets_Options.ButtonClassIcon[destinationSize]          = BattlegroundTargets_Options.ButtonClassIcon[sourceSize]
	                        OPT.ButtonClassIcon[destinationSize]          =                         OPT.ButtonClassIcon[sourceSize]
	BattlegroundTargets_Options.ButtonShowLeader[destinationSize]         = BattlegroundTargets_Options.ButtonShowLeader[sourceSize]
	                        OPT.ButtonShowLeader[destinationSize]         =                         OPT.ButtonShowLeader[sourceSize]
	BattlegroundTargets_Options.ButtonShowRealm[destinationSize]          = BattlegroundTargets_Options.ButtonShowRealm[sourceSize]
	                        OPT.ButtonShowRealm[destinationSize]          =                         OPT.ButtonShowRealm[sourceSize]
	BattlegroundTargets_Options.ButtonShowTarget[destinationSize]         = BattlegroundTargets_Options.ButtonShowTarget[sourceSize]
	                        OPT.ButtonShowTarget[destinationSize]         =                         OPT.ButtonShowTarget[sourceSize]
	BattlegroundTargets_Options.ButtonTargetScale[destinationSize]        = BattlegroundTargets_Options.ButtonTargetScale[sourceSize]
	                        OPT.ButtonTargetScale[destinationSize]        =                         OPT.ButtonTargetScale[sourceSize]
	BattlegroundTargets_Options.ButtonTargetPosition[destinationSize]     = BattlegroundTargets_Options.ButtonTargetPosition[sourceSize]
	                        OPT.ButtonTargetPosition[destinationSize]     =                         OPT.ButtonTargetPosition[sourceSize]
	BattlegroundTargets_Options.ButtonShowTargetCount[destinationSize]    = BattlegroundTargets_Options.ButtonShowTargetCount[sourceSize]
	                        OPT.ButtonShowTargetCount[destinationSize]    =                         OPT.ButtonShowTargetCount[sourceSize]
	BattlegroundTargets_Options.ButtonShowFocus[destinationSize]          = BattlegroundTargets_Options.ButtonShowFocus[sourceSize]
	                        OPT.ButtonShowFocus[destinationSize]          =                         OPT.ButtonShowFocus[sourceSize]
	BattlegroundTargets_Options.ButtonFocusScale[destinationSize]         = BattlegroundTargets_Options.ButtonFocusScale[sourceSize]
	                        OPT.ButtonFocusScale[destinationSize]         =                         OPT.ButtonFocusScale[sourceSize]
	BattlegroundTargets_Options.ButtonFocusPosition[destinationSize]      = BattlegroundTargets_Options.ButtonFocusPosition[sourceSize]
	                        OPT.ButtonFocusPosition[destinationSize]      =                         OPT.ButtonFocusPosition[sourceSize]
	BattlegroundTargets_Options.ButtonShowFlag[destinationSize]           = BattlegroundTargets_Options.ButtonShowFlag[sourceSize]
	                        OPT.ButtonShowFlag[destinationSize]           =                         OPT.ButtonShowFlag[sourceSize]
	BattlegroundTargets_Options.ButtonFlagScale[destinationSize]          = BattlegroundTargets_Options.ButtonFlagScale[sourceSize]
	                        OPT.ButtonFlagScale[destinationSize]          =                         OPT.ButtonFlagScale[sourceSize]
	BattlegroundTargets_Options.ButtonFlagPosition[destinationSize]       = BattlegroundTargets_Options.ButtonFlagPosition[sourceSize]
	                        OPT.ButtonFlagPosition[destinationSize]       =                         OPT.ButtonFlagPosition[sourceSize]
	BattlegroundTargets_Options.ButtonShowAssist[destinationSize]         = BattlegroundTargets_Options.ButtonShowAssist[sourceSize]
	                        OPT.ButtonShowAssist[destinationSize]         =                         OPT.ButtonShowAssist[sourceSize]
	BattlegroundTargets_Options.ButtonAssistScale[destinationSize]        = BattlegroundTargets_Options.ButtonAssistScale[sourceSize]
	                        OPT.ButtonAssistScale[destinationSize]        =                         OPT.ButtonAssistScale[sourceSize]
	BattlegroundTargets_Options.ButtonAssistPosition[destinationSize]     = BattlegroundTargets_Options.ButtonAssistPosition[sourceSize]
	                        OPT.ButtonAssistPosition[destinationSize]     =                         OPT.ButtonAssistPosition[sourceSize]
	BattlegroundTargets_Options.ButtonShowHealthBar[destinationSize]      = BattlegroundTargets_Options.ButtonShowHealthBar[sourceSize]
	                        OPT.ButtonShowHealthBar[destinationSize]      =                         OPT.ButtonShowHealthBar[sourceSize]
	BattlegroundTargets_Options.ButtonShowHealthText[destinationSize]     = BattlegroundTargets_Options.ButtonShowHealthText[sourceSize]
	                        OPT.ButtonShowHealthText[destinationSize]     =                         OPT.ButtonShowHealthText[sourceSize]
	BattlegroundTargets_Options.ButtonRangeCheck[destinationSize]         = BattlegroundTargets_Options.ButtonRangeCheck[sourceSize]
	                        OPT.ButtonRangeCheck[destinationSize]         =                         OPT.ButtonRangeCheck[sourceSize]
	BattlegroundTargets_Options.ButtonTypeRangeCheck[destinationSize]     = BattlegroundTargets_Options.ButtonTypeRangeCheck[sourceSize]
	                        OPT.ButtonTypeRangeCheck[destinationSize]     =                         OPT.ButtonTypeRangeCheck[sourceSize]
	BattlegroundTargets_Options.ButtonRangeDisplay[destinationSize]       = BattlegroundTargets_Options.ButtonRangeDisplay[sourceSize]
	                        OPT.ButtonRangeDisplay[destinationSize]       =                         OPT.ButtonRangeDisplay[sourceSize]
	BattlegroundTargets_Options.ButtonSortBy[destinationSize]             = BattlegroundTargets_Options.ButtonSortBy[sourceSize]
	                        OPT.ButtonSortBy[destinationSize]             =                         OPT.ButtonSortBy[sourceSize]
	BattlegroundTargets_Options.ButtonSortDetail[destinationSize]         = BattlegroundTargets_Options.ButtonSortDetail[sourceSize]
	                        OPT.ButtonSortDetail[destinationSize]         =                         OPT.ButtonSortDetail[sourceSize]
	BattlegroundTargets_Options.ButtonFontNameStyle[destinationSize]      = BattlegroundTargets_Options.ButtonFontNameStyle[sourceSize]
	                        OPT.ButtonFontNameStyle[destinationSize]      =                         OPT.ButtonFontNameStyle[sourceSize]
	BattlegroundTargets_Options.ButtonFontNameSize[destinationSize]       = BattlegroundTargets_Options.ButtonFontNameSize[sourceSize]
	                        OPT.ButtonFontNameSize[destinationSize]       =                         OPT.ButtonFontNameSize[sourceSize]
	BattlegroundTargets_Options.ButtonFontNumberStyle[destinationSize]    = BattlegroundTargets_Options.ButtonFontNumberStyle[sourceSize]
	                        OPT.ButtonFontNumberStyle[destinationSize]    =                         OPT.ButtonFontNumberStyle[sourceSize]
	BattlegroundTargets_Options.ButtonFontNumberSize[destinationSize]     = BattlegroundTargets_Options.ButtonFontNumberSize[sourceSize]
	                        OPT.ButtonFontNumberSize[destinationSize]     =                         OPT.ButtonFontNumberSize[sourceSize]
	BattlegroundTargets_Options.ButtonScale[destinationSize]              = BattlegroundTargets_Options.ButtonScale[sourceSize]
	                        OPT.ButtonScale[destinationSize]              =                         OPT.ButtonScale[sourceSize]
	BattlegroundTargets_Options.ButtonWidth[destinationSize]              = BattlegroundTargets_Options.ButtonWidth[sourceSize]
	                        OPT.ButtonWidth[destinationSize]              =                         OPT.ButtonWidth[sourceSize]
	BattlegroundTargets_Options.ButtonHeight[destinationSize]             = BattlegroundTargets_Options.ButtonHeight[sourceSize]
	                        OPT.ButtonHeight[destinationSize]             =                         OPT.ButtonHeight[sourceSize]

	if destinationSize == 10 then
		testSize = 10
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, true)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, nil)
		BattlegroundTargets:CheckForEnabledBracket(testSize)
		if BattlegroundTargets_Options.EnableBracket[testSize] then
			BattlegroundTargets:EnableConfigMode()
		else
			BattlegroundTargets:DisableConfigMode()
		end
	else
		testSize = 15
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize10, nil)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize15, true)
		TEMPLATE.SetTabButton(GVAR.OptionsFrame.TabRaidSize40, nil)
		BattlegroundTargets:CheckForEnabledBracket(testSize)
		if BattlegroundTargets_Options.EnableBracket[testSize] then
			BattlegroundTargets:EnableConfigMode()
		else
			BattlegroundTargets:DisableConfigMode()
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function sortfunc13(a, b) -- role / class / name | 13
	if a.talentSpec == b.talentSpec then
		if class_BlizzSort[ a.classToken ] == class_BlizzSort[ b.classToken ] then
			if a.name < b.name then return true end
		elseif class_BlizzSort[ a.classToken ] < class_BlizzSort[ b.classToken ] then return true end
	elseif a.talentSpec < b.talentSpec then return true end
end
local function sortfunc11(a, b) -- role / class / name | 11
	if a.talentSpec == b.talentSpec then
		if class_LocaSort[ a.classToken ] == class_LocaSort[ b.classToken ] then
			if a.name < b.name then return true end
		elseif class_LocaSort[ a.classToken ] < class_LocaSort[ b.classToken ] then return true end
	elseif a.talentSpec < b.talentSpec then return true end
end
local function sortfunc12(a, b) -- role / class / name | 12
	if a.talentSpec == b.talentSpec then
		if a.classToken == b.classToken then
			if a.name < b.name then return true end
		elseif a.classToken < b.classToken then return true end
	elseif a.talentSpec < b.talentSpec then return true end
end
local function sortfunc2(a, b) -- role / name | 2
	if a.talentSpec == b.talentSpec then
		if a.name < b.name then return true end
	elseif a.talentSpec < b.talentSpec then return true end
end
local function sortfunc33(a, b) -- class / role / name | 33
	if class_BlizzSort[ a.classToken ] == class_BlizzSort[ b.classToken ] then
		if a.talentSpec == b.talentSpec then
			if a.name < b.name then return true end
		elseif a.talentSpec < b.talentSpec then return true end
	elseif class_BlizzSort[ a.classToken ] < class_BlizzSort[ b.classToken ] then return true end
end
local function sortfunc31(a, b) -- class / role / name | 31
	if class_LocaSort[ a.classToken ] == class_LocaSort[ b.classToken ] then
		if a.talentSpec == b.talentSpec then
			if a.name < b.name then return true end
		elseif a.talentSpec < b.talentSpec then return true end
	elseif class_LocaSort[ a.classToken ] < class_LocaSort[ b.classToken ] then return true end
end
local function sortfunc32(a, b) -- class / role / name | 32
	if a.classToken == b.classToken then
		if a.talentSpec == b.talentSpec then
			if a.name < b.name then return true end
		elseif a.talentSpec < b.talentSpec then return true end
	elseif a.classToken < b.classToken then return true end
end
local function sortfunc43(a, b) -- class / name | 43
	if class_BlizzSort[ a.classToken ] == class_BlizzSort[ b.classToken ] then
		if a.name < b.name then return true end
	elseif class_BlizzSort[ a.classToken ] < class_BlizzSort[ b.classToken ] then return true end
end
local function sortfunc41(a, b) -- class / name | 41
	if class_LocaSort[ a.classToken ] == class_LocaSort[ b.classToken ] then
		if a.name < b.name then return true end
	elseif class_LocaSort[ a.classToken ] < class_LocaSort[ b.classToken ] then return true end
end
local function sortfunc42(a, b) -- class / name | 42
	if a.classToken == b.classToken then
		if a.name < b.name then return true end
	elseif a.classToken < b.classToken then return true end
end
local function sortfunc5(a, b) -- name | 5
	if a.name < b.name then return true end
end

function BattlegroundTargets:MainDataUpdate()
	local ButtonSortBy = OPT.ButtonSortBy[currentSize]
	local ButtonSortDetail = OPT.ButtonSortDetail[currentSize]
	if ButtonSortBy == 1 then
		if ButtonSortDetail == 3 then
			table_sort(ENEMY_Data, sortfunc13) -- role / class / name | 13
		elseif ButtonSortDetail == 1 then
			table_sort(ENEMY_Data, sortfunc11) -- role / class / name | 11
		else
			table_sort(ENEMY_Data, sortfunc12) -- role / class / name | 12
		end
	elseif ButtonSortBy == 2 then
		table_sort(ENEMY_Data, sortfunc2) -- role / name | 2
	elseif ButtonSortBy == 3 then
		if ButtonSortDetail == 3 then
			table_sort(ENEMY_Data, sortfunc33) -- class / role / name | 33
		elseif ButtonSortDetail == 1 then
			table_sort(ENEMY_Data, sortfunc31) -- class / role / name | 31
		else
			table_sort(ENEMY_Data, sortfunc32) -- class / role / name | 32
		end
	elseif ButtonSortBy == 4 then
		if ButtonSortDetail == 3 then
			table_sort(ENEMY_Data, sortfunc43) -- class / name | 43
		elseif ButtonSortDetail == 1 then
			table_sort(ENEMY_Data, sortfunc41) -- class / name | 41
		else
			table_sort(ENEMY_Data, sortfunc42) -- class / name | 42
		end
	else
		table_sort(ENEMY_Data, sortfunc5) -- name | 5
	end

	local ButtonShowSpec        = OPT.ButtonShowSpec[currentSize]
	local ButtonClassIcon       = OPT.ButtonClassIcon[currentSize]
	local ButtonShowLeader      = OPT.ButtonShowLeader[currentSize]
	local ButtonShowRealm       = OPT.ButtonShowRealm[currentSize]
	local ButtonShowTargetCount = OPT.ButtonShowTargetCount[currentSize]
	local ButtonShowHealthBar   = OPT.ButtonShowHealthBar[currentSize]
	local ButtonShowHealthText  = OPT.ButtonShowHealthText[currentSize]
	local ButtonShowTarget      = OPT.ButtonShowTarget[currentSize]
	local ButtonShowFocus       = OPT.ButtonShowFocus[currentSize]
	local ButtonShowFlag        = OPT.ButtonShowFlag[currentSize]
	local ButtonShowAssist      = OPT.ButtonShowAssist[currentSize]
	local ButtonRangeCheck      = OPT.ButtonRangeCheck[currentSize]

	wipe(ENEMY_Name2Button)
	wipe(ENEMY_Name4Flag)
	for i = 1, currentSize do
		if ENEMY_Data[i] then
			local GVAR_TargetButton = GVAR.TargetButton[i]

			local qname       = ENEMY_Data[i].name
			local qclassToken = ENEMY_Data[i].classToken
			local qspecNum    = ENEMY_Data[i].specNum
			local qtalentSpec = ENEMY_Data[i].talentSpec

			ENEMY_Name2Button[qname] = i
			GVAR_TargetButton.buttonNum = i

			local colR = classcolors[qclassToken].r
			local colG = classcolors[qclassToken].g
			local colB = classcolors[qclassToken].b
			GVAR_TargetButton.colR  = colR
			GVAR_TargetButton.colG  = colG
			GVAR_TargetButton.colB  = colB
			GVAR_TargetButton.colR5 = colR*0.5
			GVAR_TargetButton.colG5 = colG*0.5
			GVAR_TargetButton.colB5 = colB*0.5
			GVAR_TargetButton.ClassColorBackground:SetTexture(GVAR_TargetButton.colR5, GVAR_TargetButton.colG5, GVAR_TargetButton.colB5, 1)
			GVAR_TargetButton.HealthBar:SetTexture(colR, colG, colB, 1)

			GVAR_TargetButton.RoleTexture:SetTexCoord(Textures.RoleIcon[qtalentSpec][1], Textures.RoleIcon[qtalentSpec][2], Textures.RoleIcon[qtalentSpec][3], Textures.RoleIcon[qtalentSpec][4])

			local onlyname = qname
			if ButtonShowFlag or not ButtonShowRealm then
				if strfind(qname, "-", 1, true) then
					onlyname = strmatch(qname, "(.-)%-(.*)$")
				end
				ENEMY_Name4Flag[onlyname] = i
			end

			if not ButtonShowRealm then
				GVAR_TargetButton.name4button = onlyname
				if isLowLevel and ENEMY_Name2Level[qname] then
					GVAR_TargetButton.Name:SetText(ENEMY_Name2Level[qname].." "..onlyname)
				else
					GVAR_TargetButton.Name:SetText(onlyname)
				end
			else
				GVAR_TargetButton.name4button = qname
				if isLowLevel and ENEMY_Name2Level[qname] then
					GVAR_TargetButton.Name:SetText(ENEMY_Name2Level[qname].." "..qname)
				else
					GVAR_TargetButton.Name:SetText(qname)
				end
			end

			if not inCombat or not InCombatLockdown() then
				GVAR_TargetButton:SetAttribute("macrotext1", "/targetexact "..qname)
				GVAR_TargetButton:SetAttribute("macrotext2", "/targetexact "..qname.."\n/focus\n/targetlasttarget")
			end

			if ButtonRangeCheck then
				GVAR_TargetButton.RangeTexture:SetTexture(colR, colG, colB, 1)
			end

			if ButtonShowSpec then
				GVAR_TargetButton.SpecTexture:SetTexture(classes[qclassToken].spec[qspecNum].icon)
			end

			if ButtonClassIcon then
				GVAR_TargetButton.ClassTexture:SetTexCoord(classes[qclassToken].coords[1], classes[qclassToken].coords[2], classes[qclassToken].coords[3], classes[qclassToken].coords[4])
			end

			local nameE = ENEMY_Names[qname]
			local percentE = ENEMY_Name2Percent[qname]

			if ButtonShowTargetCount then
				if nameE then
					GVAR_TargetButton.TargetCount:SetText(nameE)
				else
					GVAR_TargetButton.TargetCount:SetText("0")
				end
			end

			if nameE and percentE then
				if ButtonShowHealthBar then
					local width = healthBarWidth * (percentE / 100)
					width = math_max(0.01, width)
					width = math_min(healthBarWidth, width)
					GVAR_TargetButton.HealthBar:SetWidth(width)
				end
				if ButtonShowHealthText then
					GVAR_TargetButton.HealthText:SetText(percentE)
				end
			end

			if ButtonShowTarget and playerTargetName then
				if qname == playerTargetName then
					GVAR_TargetButton.HighlightT:SetTexture(0.5, 0.5, 0.5, 1)
					GVAR_TargetButton.HighlightR:SetTexture(0.5, 0.5, 0.5, 1)
					GVAR_TargetButton.HighlightB:SetTexture(0.5, 0.5, 0.5, 1)
					GVAR_TargetButton.HighlightL:SetTexture(0.5, 0.5, 0.5, 1)
					GVAR_TargetButton.TargetTexture:SetAlpha(1)
				else
					GVAR_TargetButton.HighlightT:SetTexture(0, 0, 0, 1)
					GVAR_TargetButton.HighlightR:SetTexture(0, 0, 0, 1)
					GVAR_TargetButton.HighlightB:SetTexture(0, 0, 0, 1)
					GVAR_TargetButton.HighlightL:SetTexture(0, 0, 0, 1)
					GVAR_TargetButton.TargetTexture:SetAlpha(0)
				end
			end

			if ButtonShowFocus and playerFocusName then
				if qname == playerFocusName then
					GVAR_TargetButton.FocusTexture:SetAlpha(1)
				else
					GVAR_TargetButton.FocusTexture:SetAlpha(0)
				end
			end

			if ButtonShowFlag then
				if qname == hasFlag then
					GVAR_TargetButton.FlagTexture:SetAlpha(1)
					BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
				elseif qname == hasOrb.Blue.name then
					GVAR_TargetButton.FlagTexture:SetAlpha(1)
					GVAR_TargetButton.FlagTexture:SetTexture("Interface\\MiniMap\\TempleofKotmogu_ball_cyan")
					BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton, hasOrb.Blue.orbval)
					GVAR_TargetButton.OrbCornerTL:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerTR:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerBL:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerBR:SetAlpha(1)
				elseif qname == hasOrb.Purple.name then
					GVAR_TargetButton.FlagTexture:SetAlpha(1)
					GVAR_TargetButton.FlagTexture:SetTexture("Interface\\MiniMap\\TempleofKotmogu_ball_purple")
					BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton, hasOrb.Purple.orbval)
					GVAR_TargetButton.OrbCornerTL:SetAlpha(1)
					GVAR_TargetButton.OrbCornerTR:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerBL:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerBR:SetAlpha(0.15)
				elseif qname == hasOrb.Green.name then
					GVAR_TargetButton.FlagTexture:SetAlpha(1)
					GVAR_TargetButton.FlagTexture:SetTexture("Interface\\MiniMap\\TempleofKotmogu_ball_green")
					BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton, hasOrb.Green.orbval)
					GVAR_TargetButton.OrbCornerTL:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerTR:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerBL:SetAlpha(1)
					GVAR_TargetButton.OrbCornerBR:SetAlpha(0.15)
				elseif qname == hasOrb.Orange.name then
					GVAR_TargetButton.FlagTexture:SetAlpha(1)
					GVAR_TargetButton.FlagTexture:SetTexture("Interface\\MiniMap\\TempleofKotmogu_ball_orange")
					BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton, hasOrb.Orange.orbval)
					GVAR_TargetButton.OrbCornerTL:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerTR:SetAlpha(1)
					GVAR_TargetButton.OrbCornerBL:SetAlpha(0.15)
					GVAR_TargetButton.OrbCornerBR:SetAlpha(0.15)
				else
					GVAR_TargetButton.FlagTexture:SetAlpha(0)
					GVAR_TargetButton.FlagDebuff:SetText("")
					GVAR_TargetButton.OrbDebuff:SetText("")
					GVAR_TargetButton.OrbCornerTL:SetAlpha(0)
					GVAR_TargetButton.OrbCornerTR:SetAlpha(0)
					GVAR_TargetButton.OrbCornerBL:SetAlpha(0)
					GVAR_TargetButton.OrbCornerBR:SetAlpha(0)
				end
			end

			if ButtonShowAssist and playerAssistTargetName then
				if qname == playerAssistTargetName then
					GVAR_TargetButton.AssistTexture:SetAlpha(1)
				else
					GVAR_TargetButton.AssistTexture:SetAlpha(0)
				end
			end

			if ButtonShowLeader and isLeader then
				if qname == isLeader then
					GVAR_TargetButton.LeaderTexture:SetAlpha(0.75)
				else
					GVAR_TargetButton.LeaderTexture:SetAlpha(0)
				end
			end

		else
			local GVAR_TargetButton = GVAR.TargetButton[i]
			BattlegroundTargets:ClearConfigButtonValues(GVAR_TargetButton)
			if not inCombat or not InCombatLockdown() then
				GVAR_TargetButton:SetAttribute("macrotext1", "")
				GVAR_TargetButton:SetAttribute("macrotext2", "")
			end
		end
	end

	if isConfig then
		if BattlegroundTargets_Options.SummaryToggle[currentSize] then
			FRIEND_Roles = {0,0,0,0}
			ENEMY_Roles = {0,0,0,0}
			for i = 1, currentSize do
				if ENEMY_Data[i] then
					local role = ENEMY_Data[i].talentSpec
					ENEMY_Roles[role] = ENEMY_Roles[role] + 1
				end
			end
			GVAR.Summary.HealerFriend:SetText(FRIEND_Roles[1]) -- HEALER  FRIEND
			GVAR.Summary.TankFriend:SetText(FRIEND_Roles[2])   -- TANK    FRIEND
			GVAR.Summary.DamageFriend:SetText(FRIEND_Roles[3]) -- DAMAGER FRIEND
			GVAR.Summary.HealerEnemy:SetText(ENEMY_Roles[1])   -- HEALER  ENEMY
			GVAR.Summary.TankEnemy:SetText(ENEMY_Roles[2])     -- TANK    ENEMY
			GVAR.Summary.DamageEnemy:SetText(ENEMY_Roles[3])   -- DAMAGER ENEMY
		end
		if isLowLevel then -- LVLCHK
			for i = 1, currentSize do
				local GVAR_TargetButton = GVAR.TargetButton[i]
				GVAR_TargetButton.Name:SetText(playerLevel.." "..GVAR_TargetButton.name4button)
			end
		end
		return
	end

	if ButtonRangeCheck then
		local curTime = GetTime()
		if range_CL_DisplayThrottle + range_CL_DisplayFrequency > curTime then return end
		range_CL_DisplayThrottle = curTime
		BattlegroundTargets:UpdateRange(curTime)
	end

	-- SUMMARY
	if BattlegroundTargets_Options.SummaryToggle[currentSize] then
		GVAR.Summary.HealerFriend:SetText(FRIEND_Roles[1]) -- HEALER  FRIEND
		GVAR.Summary.TankFriend:SetText(FRIEND_Roles[2])   -- TANK    FRIEND
		GVAR.Summary.DamageFriend:SetText(FRIEND_Roles[3]) -- DAMAGER FRIEND
		GVAR.Summary.HealerEnemy:SetText(ENEMY_Roles[1])   -- HEALER  ENEMY
		GVAR.Summary.TankEnemy:SetText(ENEMY_Roles[2])     -- TANK    ENEMY
		GVAR.Summary.DamageEnemy:SetText(ENEMY_Roles[3])   -- DAMAGER ENEMY
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:BattlefieldScoreUpdate()
	local curTime = GetTime()
	local diff = curTime - scoreLastUpdate
	if diff < scoreFrequency then return end
	if scoreCount > 50 then -- 0-10 updates: 1 second | 11-50 updates: 2 seconds | 51+ updates: 5 seconds
		scoreFrequency = 5
	elseif scoreCount > 10 then
		scoreFrequency = 2
		scoreCount = scoreCount + 1
	else
		scoreCount = scoreCount + 1
	end

	if inCombat or InCombatLockdown() then
		if reCheckBG or diff >= scoreWarning then
			GVAR.ScoreUpdateTexture:Show()
		else
			GVAR.ScoreUpdateTexture:Hide()
		end
		reCheckScore = true
		return
	end

	local wssf = WorldStateScoreFrame
	if wssf and wssf:IsShown() and wssf.selectedTab and wssf.selectedTab > 1 then
		return
	end

	reCheckScore = nil
	scoreLastUpdate = curTime
	GVAR.ScoreUpdateTexture:Hide()

	wipe(ENEMY_Data)
	wipe(FRIEND_Data)
	wipe(FRIEND_Names)
	ENEMY_Roles = {0,0,0,0} -- SUMMARY
	FRIEND_Roles = {0,0,0,0}

	local numScore = GetNumBattlefieldScores()

	if not oppositeFactionREAL then
		for index = 1, numScore do
			local _, _, _, _, _, faction, race = GetBattlefieldScore(index)
			if race and faction == oppositeFactionBG then
				local n = RNA[race]
				if n == 0 then -- summary_flag_texture
					GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")
					oppositeFactionREAL = 0
					break
				elseif n == 1 then
					GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")
					oppositeFactionREAL = 1
					break
				end
			end
		end
	end

	for index = 1, numScore do
		local name, _, _, _, _, faction, _, _, classToken, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(index)
		if not name then break end
		if faction == oppositeFactionBG then

			local role = 4
			local spec = 5
			local class = "ZZZFAILURE"
			if classToken then
				local token = classes[classToken]
				if token then
					if talentSpec then
						if token.spec[1] and talentSpec == token.spec[1].specName then
							role = classes[classToken].spec[1].role
							spec = 1
						elseif token.spec[2] and talentSpec == token.spec[2].specName then
							role = classes[classToken].spec[2].role
							spec = 2
						elseif token.spec[3] and talentSpec == token.spec[3].specName then
							role = classes[classToken].spec[3].role
							spec = 3
						elseif token.spec[4] and talentSpec == token.spec[4].specName then
							role = classes[classToken].spec[4].role
							spec = 4
						end
					end
					class = classToken
				end
			end

			tinsert(ENEMY_Data, {
				name = name,
				classToken = class,
				specNum = spec,
				talentSpec = role,
			})

			ENEMY_Roles[role] = ENEMY_Roles[role] + 1 -- SUMMARY
			if not ENEMY_Names[name] then
				ENEMY_Names[name] = 0
			end

		elseif faction == playerFactionBG then

			local role = 4
			local spec = 5
			local class = "ZZZFAILURE"
			if classToken then
				local token = classes[classToken]
				if token then
					if talentSpec then
						if token.spec[1] and talentSpec == token.spec[1].specName then
							role = classes[classToken].spec[1].role
							spec = 1
						elseif token.spec[2] and talentSpec == token.spec[2].specName then
							role = classes[classToken].spec[2].role
							spec = 2
						elseif token.spec[3] and talentSpec == token.spec[3].specName then
							role = classes[classToken].spec[3].role
							spec = 3
						elseif token.spec[4] and talentSpec == token.spec[4].specName then
							role = classes[classToken].spec[4].role
							spec = 4
						end
					end
					class = classToken
				end
			end

			tinsert(FRIEND_Data, {
				name = name,
				classToken = class,
				specNum = spec,
				talentSpec = role,
			})

			FRIEND_Roles[role] = FRIEND_Roles[role] + 1 -- SUMMARY
			FRIEND_Names[name] = 1

		end
	end

	if ENEMY_Data[1] then
		if BattlegroundTargets.TrackFaction then -- BG_FACTION_CHK
			for i = 1, #ENEMY_Data do
				if ENEMY_Data[i].name == playerName then
					BattlegroundTargets.ForceDefaultFaction = true
					break
				end
			end
			BattlegroundTargets.TrackFaction = nil
			if BattlegroundTargets.ForceDefaultFaction then
				BattlegroundTargets:BattlefieldCheck()
				return
			end
		end

		BattlegroundTargets:MainDataUpdate()

		if not flagflag and isFlagBG > 0 then
			if OPT.ButtonShowFlag[currentSize] then
				BattlegroundTargets:CheckFlagCarrierSTART()
			end
		end
	end

	if reSizeCheck >= 10 then return end

	local queueStatus, queueMapName, bgName
	for i=1, GetMaxBattlefieldID() do
		queueStatus, queueMapName = GetBattlefieldStatus(i)
		if queueStatus == "active" then
			bgName = queueMapName
			break
		end
	end

	if bgMaps[bgName] then
		BattlegroundTargets:BattlefieldCheck()
	elseif BGN[bgName] then
		BattlegroundTargets:BattlefieldCheck()
	else
		local zone = GetRealZoneText()
		if bgMaps[zone] then
			BattlegroundTargets:BattlefieldCheck()
		elseif BGN[zone] then
			BattlegroundTargets:BattlefieldCheck()
		else
			reSizeCheck = reSizeCheck + 1
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:BattlefieldCheck()
	if not inWorld then return end
	local _, instanceType = IsInInstance()
	if instanceType == "pvp" then
		BattlegroundTargets:IsBattleground()
	else
		BattlegroundTargets:IsNotBattleground()
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:IsBattleground()
	inBattleground = true

	local queueStatus, queueMapName, bgName
	for i=1, GetMaxBattlefieldID() do
		queueStatus, queueMapName = GetBattlefieldStatus(i) --print(i, GetBattlefieldStatus(i))
		if queueStatus == "active" then
			bgName = queueMapName
			break
		end
	end

	if bgMaps[bgName] then
		reSizeCheck = 10
		currentSize = bgMaps[bgName].bgSize
		isFlagBG    = bgMaps[bgName].flagBG
	elseif BGN[bgName] then
		reSizeCheck = 10
		for k in pairs(bgMaps) do
			if k == BGN[bgName] then
				currentSize = bgMaps[k].bgSize
				isFlagBG    = bgMaps[k].flagBG
				break
			end
		end
	else
		local zone = GetRealZoneText()
		if bgMaps[zone] then
			reSizeCheck = 10
			currentSize = bgMaps[zone].bgSize
			isFlagBG    = bgMaps[zone].flagBG
		elseif BGN[zone] then
			reSizeCheck = 10
			for k in pairs(bgMaps) do
				if k == BGN[zone] then
					currentSize = bgMaps[k].bgSize
					isFlagBG    = bgMaps[k].flagBG
					break
				end
			end
		else
			if reSizeCheck == 10 then
				Print("ERROR", "unknown battleground name", locale, bgName, zone)
			end
			reSizeCheck = reSizeCheck + 1
			currentSize = 10
			isFlagBG    = 0
		end
	end

	if IsRatedBattleground() then
		currentSize = 10
	end

	-- ---------- BG_FACTION_CHK
	-- GetBattlefieldArenaFaction() can return a wrong value which results
	-- in a bgt frame that shows your group instead of the enemy group.
	-- Workaround: If the factions differs we track until GetBattlefieldScore()
	-- has collected the enemy data. If playerName is in that enemy data we have
	-- found the bug.
	if BattlegroundTargets.ForceDefaultFaction then
		if playerFactionDEF == 0 then
			playerFactionBG   = 0 -- Horde
			oppositeFactionBG = 1 -- Alliance
		else--if playerFactionDEF == 1 then
			playerFactionBG   = 1 -- Alliance
			oppositeFactionBG = 0 -- Horde
		end
		oppositeFactionREAL = nil -- reset real faction
	elseif not IsActiveBattlefieldArena() then
		local faction = GetBattlefieldArenaFaction()
		if faction == 0 then
			playerFactionBG   = 0 -- Horde
			oppositeFactionBG = 1 -- Alliance
		elseif faction == 1 then
			playerFactionBG   = 1 -- Alliance
			oppositeFactionBG = 0 -- Horde
		else
			Print("ERROR", "unknown battleground faction", locale, faction)
		end
		if playerFactionDEF ~= playerFactionBG then
			BattlegroundTargets.TrackFaction = true
		end
	end
	-- ----------

	if playerLevel >= maxLevel then -- LVLCHK
		isLowLevel = nil
	else
		isLowLevel = true
	end

	if inCombat or InCombatLockdown() then
		reCheckBG = true
	else
		reCheckBG = false

		if BattlegroundTargets_Options.EnableBracket[currentSize] then

			BattlegroundTargets:Frame_SetupPosition("BattlegroundTargets_MainFrame")
			GVAR.MainFrame:EnableMouse(false)
			GVAR.MainFrame:SetAlpha(0)
			GVAR.MainFrame:Show() -- POSiCHK
			GVAR.MainFrameMoverFrame:Hide()
			GVAR.ScoreUpdateTexture:Hide()
			GVAR.IsGhostTexture:Hide()

			for i = 1, 40 do
				local GVAR_TargetButton = GVAR.TargetButton[i]
				if i < currentSize+1 then
					BattlegroundTargets:ClearConfigButtonValues(GVAR_TargetButton, 1)
					GVAR_TargetButton:Show()
				else
					GVAR_TargetButton:Hide()
				end
			end
			BattlegroundTargets:SetupButtonLayout()

			if BattlegroundTargets_Options.SummaryToggle[currentSize] then
				GVAR.Summary.HealerFriend:SetText("0")
				GVAR.Summary.TankFriend:SetText("0")
				GVAR.Summary.DamageFriend:SetText("0")
				GVAR.Summary.HealerEnemy:SetText("0")
				GVAR.Summary.TankEnemy:SetText("0")
				GVAR.Summary.DamageEnemy:SetText("0")
			end

			if OPT.ButtonShowFlag[currentSize] then
				-- flag
				if isFlagBG == 1 or isFlagBG == 2 or isFlagBG == 3 then
					local flagIcon -- setup_flag_texture
					if playerFactionBG ~= playerFactionDEF then
						flagIcon = "Interface\\WorldStateFrame\\ColumnIcon-FlagCapture2" -- neutral_flag
					elseif playerFactionDEF == 0 then
						if isFlagBG == 2 then
							flagIcon = "Interface\\WorldStateFrame\\AllianceFlag"
						else
							flagIcon = "Interface\\WorldStateFrame\\HordeFlag"
						end
					else
						if isFlagBG == 2 then
							flagIcon = "Interface\\WorldStateFrame\\HordeFlag"
						else
							flagIcon = "Interface\\WorldStateFrame\\AllianceFlag"
						end
					end
					local quad = (OPT.ButtonHeight[currentSize]-2) * OPT.ButtonFlagScale[currentSize]
					for i = 1, currentSize do
						GVAR.TargetButton[i].FlagTexture:SetSize(quad, quad)
						GVAR.TargetButton[i].FlagTexture:SetTexture(flagIcon)
						GVAR.TargetButton[i].FlagTexture:SetTexCoord(0.15625001, 0.84374999, 0.15625001, 0.84374999)--(5/32, 27/32, 5/32, 27/32)
						GVAR.TargetButton[i].orbDebuffUpdate = nil
					end
				-- cart
				elseif isFlagBG == 4 then
					local flagIcon -- setup_flag_texture
					if playerFactionBG ~= playerFactionDEF then
						flagIcon = "Interface\\Minimap\\Vehicle-SilvershardMines-MineCart" -- neutral_flag
					elseif playerFactionDEF == 0 then
						flagIcon = "Interface\\Minimap\\Vehicle-SilvershardMines-MineCartRed"
					else
						flagIcon = "Interface\\Minimap\\Vehicle-SilvershardMines-MineCartBlue"
					end
					local quad = (OPT.ButtonHeight[currentSize]-2) * OPT.ButtonFlagScale[currentSize] * 1.1
					for i = 1, currentSize do
						GVAR.TargetButton[i].FlagTexture:SetSize(quad, quad)
						GVAR.TargetButton[i].FlagTexture:SetTexture(flagIcon)
						GVAR.TargetButton[i].FlagTexture:SetTexCoord(0.09375, 0.90625, 0.09375, 0.90625)--(3/32, 29/32, 3/32, 29/32)
						GVAR.TargetButton[i].orbDebuffUpdate = nil
					end
				-- orb
				elseif isFlagBG == 5 then
					local quad = (OPT.ButtonHeight[currentSize]-2) * OPT.ButtonFlagScale[currentSize] * 1.3
					local curTime = GetTime() - 2.1
					for i = 1, currentSize do
						GVAR.TargetButton[i].FlagTexture:SetSize(quad, quad)
						GVAR.TargetButton[i].FlagTexture:SetTexCoord(0.0625, 0.9375, 0.0625, 0.9375)--(2/32, 30/32, 2/32, 30/32)
						GVAR.TargetButton[i].orbDebuffUpdate = curTime
					end
				end
			end

		else

			GVAR.MainFrame:Hide()
			for i = 1, 40 do
				GVAR.TargetButton[i]:Hide()
			end

		end

	end

	BattlegroundTargets:EventUnregister()
	BattlegroundTargets:EventRegister("showerror")

	if BattlegroundTargets_Options.EnableBracket[currentSize] then
		BattlegroundTargets:BattlefieldScoreRequest()
		local elapsed = 0
		GVAR.MainFrame:SetScript("OnUpdate", function(self, elap)
			elapsed = elapsed + elap
			if elapsed < scoreFrequency then return end
			elapsed = 0
			BattlegroundTargets:BattlefieldScoreRequest()
		end)
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:IsNotBattleground()
	if not inBattleground and not reCheckBG then return end

	--for k, v in pairs(eventTest) do print(k, v) end -- TEST

	inBattleground = false
	reSizeCheck = 0
	oppositeFactionREAL = nil
	flagDebuff = 0
	flags = 0
	isFlagBG = 0
	flagCHK = nil
	flagflag = nil
	isLeader = nil
	hasFlag = nil
	hasOrb = {Green={name=nil,orbval=nil},Blue={name=nil,orbval=nil},Purple={name=nil,orbval=nil},Orange={name=nil,orbval=nil}}
	reCheckBG = nil
	reCheckScore = nil
	scoreFrequency = 1
	scoreCount = 0

	BattlegroundTargets.ForceDefaultFaction = nil
	BattlegroundTargets.TrackFaction = nil

	if isLowLevel then -- LVLCHK
		BattlegroundTargets:CheckPlayerLevel()
	end
	BattlegroundTargets:EventUnregister()

	if not isConfig then
		wipe(ENEMY_Data)
	end
	wipe(FRIEND_Data)

	wipe(ENEMY_Names)
	wipe(ENEMY_Name4Flag)
	wipe(ENEMY_Name2Button)
	wipe(ENEMY_Name2Percent)
	wipe(ENEMY_Name2Range)
	wipe(ENEMY_Name2Level)
	wipe(TARGET_Names)

	GVAR.MainFrame:SetScript("OnUpdate", nil)

	if inCombat or InCombatLockdown() then
		reCheckBG = true
	else
		reCheckBG = false

		if playerFactionDEF == 0 then -- summary_flag_texture
			GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")
		elseif playerFactionDEF == 1 then
			GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")
		else
			GVAR.Summary.Logo2:SetTexture("Interface\\Timer\\Panda-Logo")
		end
		GVAR.MainFrame:Hide()
		for i = 1, 40 do
			GVAR.TargetButton[i]:Hide()
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckPlayerTarget()
	playerTargetName, playerTargetRealm = UnitName("target")
	if playerTargetRealm and playerTargetRealm ~= "" then
		playerTargetName = playerTargetName.."-"..playerTargetRealm
	end

	for i = 1, currentSize do
		local GVAR_TargetButton = GVAR.TargetButton[i]
		GVAR_TargetButton.TargetTexture:SetAlpha(0)
		GVAR_TargetButton.HighlightT:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightR:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightB:SetTexture(0, 0, 0, 1)
		GVAR_TargetButton.HighlightL:SetTexture(0, 0, 0, 1)
	end
	isTarget = 0

	if not playerTargetName then return end
	local targetButton = ENEMY_Name2Button[playerTargetName]
	if not targetButton then return end
	local GVAR_TargetButton = GVAR.TargetButton[targetButton]
	if not GVAR_TargetButton then return end

	-- target
	if OPT.ButtonShowTarget[currentSize] then
		GVAR_TargetButton.TargetTexture:SetAlpha(1)
		GVAR_TargetButton.HighlightT:SetTexture(0.5, 0.5, 0.5, 1)
		GVAR_TargetButton.HighlightR:SetTexture(0.5, 0.5, 0.5, 1)
		GVAR_TargetButton.HighlightB:SetTexture(0.5, 0.5, 0.5, 1)
		GVAR_TargetButton.HighlightL:SetTexture(0.5, 0.5, 0.5, 1)
		isTarget = targetButton
	end

	if isDeadUpdateStop then return end
	BattlegroundTargets:CheckUnitTarget("player", playerTargetName)
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckAssist()
	isAssistUnitId = nil
	isAssistName = nil
	for i = 1, GetNumGroupMembers() do
		local name, _, _, _, _, _, _, _, _, role = GetRaidRosterInfo(i)
		if name and role and role == "MAINASSIST" then
			isAssistName = name
			isAssistUnitId = "raid"..i.."target"
			break
		end
	end

	local GVAR_TargetButton = GVAR.TargetButton
	for i = 1, currentSize do
		GVAR_TargetButton[i].AssistTexture:SetAlpha(0)
	end

	if not isAssistName then return end

	playerAssistTargetName, playerAssistTargetRealm = UnitName(isAssistUnitId)
	if playerAssistTargetRealm and playerAssistTargetRealm ~= "" then
		playerAssistTargetName = playerAssistTargetName.."-"..playerAssistTargetRealm
	end

	if not playerAssistTargetName then return end
	local assistButton = ENEMY_Name2Button[playerAssistTargetName]
	if not assistButton then return end
	if not GVAR_TargetButton[assistButton] then return end

	-- assist_
	GVAR_TargetButton[assistButton].AssistTexture:SetAlpha(1)
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckPlayerFocus()
	playerFocusName, playerFocusRealm = UnitName("focus")
	if playerFocusRealm and playerFocusRealm ~= "" then
		playerFocusName = playerFocusName.."-"..playerFocusRealm
	end

	local GVAR_TargetButton = GVAR.TargetButton
	for i = 1, currentSize do
		GVAR_TargetButton[i].FocusTexture:SetAlpha(0)
	end

	if not playerFocusName then return end
	local focusButton = ENEMY_Name2Button[playerFocusName]
	if not focusButton then return end
	local GVAR_TargetButton = GVAR_TargetButton[focusButton]
	if not GVAR_TargetButton then return end

	-- focus
	GVAR_TargetButton.FocusTexture:SetAlpha(1)

	-- class_range (Check Player Focus)
	if rangeSpellName and OPT.ButtonTypeRangeCheck[currentSize] >= 2 then
		local curTime = GetTime()
		local Name2Range = ENEMY_Name2Range[playerFocusName]
		if Name2Range then
			if Name2Range + range_SPELL_Frequency > curTime then return end -- ATTENTION
		end
		if IsSpellInRange(rangeSpellName, "focus") == 1 then
			ENEMY_Name2Range[playerFocusName] = curTime
			Range_Display(true, GVAR_TargetButton)
		else
			ENEMY_Name2Range[playerFocusName] = nil
			Range_Display(false, GVAR_TargetButton, OPT.ButtonRangeDisplay[currentSize])
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckUnitTarget(unitID, unitName)
	local friendName, friendRealm, enemyID, enemyName, enemyRealm
	if not unitName then
		enemyID = unitID.."target"
		friendName, friendRealm = UnitName(unitID)
		if friendRealm and friendRealm ~= "" then
			friendName = friendName.."-"..friendRealm
		end
		enemyName, enemyRealm = UnitName(enemyID)
		if enemyRealm and enemyRealm ~= "" then
			enemyName = enemyName.."-"..enemyRealm
		end
	else -- "player"
		enemyID = "target"
		friendName = playerName
		enemyName = unitName
	end

	local curTime = GetTime()
	local OPT = OPT

	-- target count
	if OPT.ButtonShowTargetCount[currentSize] then
		if curTime > targetCountUpdate + targetCountFrequency then
			targetCountUpdate = curTime
			wipe(TARGET_Names)
			for num = 1, GetNumGroupMembers() do
				local uID = "raid"..num
				local fName, fRealm = UnitName(uID)
				if fName then
					if fRealm and fRealm ~= "" then
						fName = fName.."-"..fRealm
					end
					local eName, eRealm = UnitName(uID.."target")
					if eName then
						if eRealm and eRealm ~= "" then
							eName = eName.."-"..eRealm
						end
						if ENEMY_Names[eName] then
							TARGET_Names[fName] = eName
						end
					end
				end
			end
		elseif friendName then
			if ENEMY_Names[enemyName] then
				TARGET_Names[friendName] = enemyName
			else
				TARGET_Names[friendName] = nil
			end
		end
		for eName in pairs(ENEMY_Names) do
			ENEMY_Names[eName] = 0
		end
		for _, eName in pairs(TARGET_Names) do
			if ENEMY_Names[eName] then
				ENEMY_Names[eName] = ENEMY_Names[eName] + 1
			end
		end
		local TargetButton = GVAR.TargetButton
		for i = 1, currentSize do
			if ENEMY_Data[i] then
				local count = ENEMY_Names[ ENEMY_Data[i].name ]
				if count then
					TargetButton[i].TargetCount:SetText(count)
				end
			else
				TargetButton[i].TargetCount:SetText("")
			end
		end
	end

	if not ENEMY_Names[enemyName] then return end

	-- FLAGSPY
	if flagCHK and isFlagBG > 0 then
		if OPT.ButtonShowFlag[currentSize] then
			BattlegroundTargets:CheckFlagCarrierCHECK(enemyID, enemyName)
		end
	end

	-- real opposite faction check
	-- NOTE: The Pandaren race name is the same on Alliance and Horde side, and so it's not possible
	--       to get the real opposite faction with GetBattlefieldScore() if all enemies are Pandaren.
	--       This check covers such a rare case...but it will only work if the option 'Target' is enabled...
	if not oppositeFactionREAL then -- summary_flag_texture
		local factionGroup = UnitFactionGroup(enemyID)
		if factionGroup == "Horde" then
			GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")
			oppositeFactionREAL = 0
		elseif factionGroup == "Alliance" then
			GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")
			oppositeFactionREAL = 1
		end
	end

	-- health
	if OPT.ButtonShowHealthBar[currentSize] or OPT.ButtonShowHealthText[currentSize] then
		BattlegroundTargets:CheckUnitHealth(enemyID, enemyName, 1)
	end

	local GVAR_TargetButton, enemyButton
	if enemyName then
		enemyButton = ENEMY_Name2Button[enemyName]
		if enemyButton then
			GVAR_TargetButton = GVAR.TargetButton[enemyButton]
		end
	end
	if not GVAR_TargetButton then return end

	-- assist_
	if isAssistName and OPT.ButtonShowAssist[currentSize] then
		if curTime > assistUpdate + assistFrequency then
			assistUpdate = curTime
			playerAssistTargetName, playerAssistTargetRealm = UnitName(isAssistUnitId)
			if playerAssistTargetRealm and playerAssistTargetRealm ~= "" then
				playerAssistTargetName = playerAssistTargetName.."-"..playerAssistTargetRealm
			end
			local TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				TargetButton[i].AssistTexture:SetAlpha(0)
			end
			if playerAssistTargetName then
				local assistButton = ENEMY_Name2Button[playerAssistTargetName]
				if assistButton then
					local button = GVAR.TargetButton[assistButton]
					if button then
						button.AssistTexture:SetAlpha(1)
					end
				end
			end
		elseif friendName and isAssistName == friendName then
			local TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				TargetButton[i].AssistTexture:SetAlpha(0)
			end
			playerAssistTargetName = enemyName 
			GVAR_TargetButton.AssistTexture:SetAlpha(1)
		end
	end

	-- leader
	if OPT.ButtonShowLeader[currentSize] then
		if isLeader then
			leaderThrottle = leaderThrottle + 1
			if leaderThrottle > leaderFrequency then
				leaderThrottle = 0
				if UnitIsGroupLeader(enemyID) then
					if isLeader ~= enemyName then
						isLeader = enemyName
						local TargetButton = GVAR.TargetButton
						for i = 1, currentSize do
							TargetButton[i].LeaderTexture:SetAlpha(0)
						end
						GVAR_TargetButton.LeaderTexture:SetAlpha(0.75)
					end
				else
					GVAR_TargetButton.LeaderTexture:SetAlpha(0)
				end
			end
		else
			if UnitIsGroupLeader(enemyID) then
				isLeader = enemyName
				local TargetButton = GVAR.TargetButton
				for i = 1, currentSize do
					TargetButton[i].LeaderTexture:SetAlpha(0)
				end
				GVAR_TargetButton.LeaderTexture:SetAlpha(0.75)
			else
				GVAR_TargetButton.LeaderTexture:SetAlpha(0)
			end
		end
	end

	-- carrier_orb
	if isFlagBG == 5 and GVAR_TargetButton.orbColor and OPT.ButtonShowFlag[currentSize] then
		if curTime > GVAR_TargetButton.orbDebuffUpdate + 2 then -- max. 1 update in 2 seconds per button
			GVAR.TargetButton[enemyButton].orbDebuffUpdate = curTime
			BattlegroundTargets:OrbDebuffCheck(enemyID, enemyName, enemyButton)
		end
	end

	-- level
	if isLowLevel then -- LVLCHK
		local level = UnitLevel(enemyID) or 0
		if level > 0 then
			ENEMY_Name2Level[enemyName] = level
			GVAR_TargetButton.Name:SetText(level.." "..GVAR_TargetButton.name4button)
		end
	end

	-- class_range (Check Unit Target)
	if rangeSpellName and OPT.ButtonTypeRangeCheck[currentSize] >= 2 then
		local Name2Range = ENEMY_Name2Range[enemyName]
		if Name2Range then
			if Name2Range + range_SPELL_Frequency > curTime then return end -- ATTENTION
		end
		if IsSpellInRange(rangeSpellName, enemyID) == 1 then
			ENEMY_Name2Range[enemyName] = curTime
			Range_Display(true, GVAR_TargetButton)
		else
			ENEMY_Name2Range[enemyName] = nil
			Range_Display(false, GVAR_TargetButton, OPT.ButtonRangeDisplay[currentSize])
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckUnitHealth(unitID, unitName, healthonly)
	local targetID, targetName, targetRealm
	if not unitName then
		if raidUnitID[unitID] then
			targetID = unitID.."target"
		elseif playerUnitID[unitID] then
			targetID = unitID
		else
			return
		end
		targetName, targetRealm = UnitName(targetID)
		if targetRealm and targetRealm ~= "" then
			targetName = targetName.."-"..targetRealm
		end
	else
		targetID = unitID
		targetName = unitName
	end

	if not targetName then return end
	local targetButton = ENEMY_Name2Button[targetName]
	if not targetButton then return end
	local GVAR_TargetButton = GVAR.TargetButton[targetButton]
	if not GVAR_TargetButton then return end

	-- health
	local ButtonShowHealthBar  = OPT.ButtonShowHealthBar[currentSize]
	local ButtonShowHealthText = OPT.ButtonShowHealthText[currentSize]
	if ButtonShowHealthBar or ButtonShowHealthText then
		local maxHealth = UnitHealthMax(targetID)
		if maxHealth then
			local health = UnitHealth(targetID)
			if health then
				local width = 0.01
				local percent = 0
				if maxHealth > 0 and health > 0 then
					local hvalue = maxHealth / health
					width = healthBarWidth / hvalue
					width = math_max(0.01, width)
					width = math_min(healthBarWidth, width)
					percent = floor( (100/hvalue) + 0.5 )
					percent = math_max(0, percent)
					percent = math_min(100, percent)
				end
				ENEMY_Name2Percent[targetName] = percent
				if ButtonShowHealthBar then
					GVAR_TargetButton.HealthBar:SetWidth(width)
				end
				if ButtonShowHealthText then
					GVAR_TargetButton.HealthText:SetText(percent)
				end
			end
		end
	end

	if healthonly then return end

	-- FLAGSPY -- carrier_orb
	if isFlagBG > 0 and OPT.ButtonShowFlag[currentSize] then
		if flagCHK then
			BattlegroundTargets:CheckFlagCarrierCHECK(targetID, targetName)
		end
		if isFlagBG == 5 and GVAR_TargetButton.orbColor then
			local curTime = GetTime()
			if curTime > GVAR_TargetButton.orbDebuffUpdate + 2 then -- max. 1 update in 2 seconds per button
				GVAR.TargetButton[targetButton].orbDebuffUpdate = curTime
				BattlegroundTargets:OrbDebuffCheck(targetID, targetName, targetButton)
			end
		end
	end

	-- class_range (Check Unit Health)
	if rangeSpellName and OPT.ButtonTypeRangeCheck[currentSize] >= 2 then
		local curTime = GetTime()
		local Name2Range = ENEMY_Name2Range[targetName]
		if Name2Range then
			if Name2Range + range_SPELL_Frequency > curTime then return end -- ATTENTION
		end
		if IsSpellInRange(rangeSpellName, targetID) == 1 then
			ENEMY_Name2Range[targetName] = curTime
			Range_Display(true, GVAR_TargetButton)
		else
			ENEMY_Name2Range[targetName] = nil
			Range_Display(false, GVAR_TargetButton, OPT.ButtonRangeDisplay[currentSize])
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckFlagCarrierCHECK(unit, targetName) -- FLAGSPY
	if not ENEMY_FirstFlagCheck[targetName] then return end

	if isFlagBG == 1 or isFlagBG == 2 or isFlagBG == 3 then

		-- enemy buff & debuff check
		for i = 1, 40 do
			local _, _, _, _, _, _, _, _, _, _, spellId = UnitBuff(unit, i)
			if not spellId then break end
			if flagIDs[spellId] then
				hasFlag = targetName
				flagDebuff = 0
				flags = flags + 1

				for j = 1, 40 do
					local _, _, _, count, _, _, _, _, _, _, spellId = UnitDebuff(unit, j)
					if not spellId then break end
					if debuffIDs[spellId] then
						flagDebuff = count
						break
					end
				end

				local GVAR_TargetButton = GVAR.TargetButton
				for j = 1, currentSize do
					GVAR_TargetButton[j].FlagTexture:SetAlpha(0)
					GVAR_TargetButton[j].FlagDebuff:SetText("")
				end
				local button = ENEMY_Name2Button[targetName]
				if button then
					local GVAR_TargetButton = GVAR.TargetButton[button]
					if GVAR_TargetButton then
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
					end
				end

				BattlegroundTargets:CheckFlagCarrierEND()
				return
			end
		end

	elseif isFlagBG == 4 then

		-- enemy buff check
		for i = 1, 40 do
			local _, _, _, _, _, _, _, _, _, _, spellId = UnitBuff(unit, i)
			if not spellId then break end
			if flagIDs[spellId] then
				hasFlag = targetName

				local GVAR_TargetButton = GVAR.TargetButton
				for j = 1, currentSize do
					GVAR_TargetButton[j].FlagTexture:SetAlpha(0)
					GVAR_TargetButton[j].FlagDebuff:SetText("")
				end
				local button = ENEMY_Name2Button[targetName]
				if button then
					local GVAR_TargetButton = GVAR.TargetButton[button]
					if GVAR_TargetButton then
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						GVAR_TargetButton.FlagDebuff:SetText("")
					end
				end

				BattlegroundTargets:CheckFlagCarrierEND()
				return
			end
		end

	elseif isFlagBG == 5 then

		-- enemy debuff check
		if flags >= 4 then
			BattlegroundTargets:CheckFlagCarrierEND()
			return
		end
		for i = 1, 40 do
			local _, _, _, _, _, _, _, _, _, _, spellId, _, _, _, _, val2 = UnitDebuff(unit, i)
			if not spellId then break end
			if orbIDs[spellId] then
				flags = flags + 1 -- FLAG_TOK_CHK

				local button = ENEMY_Name2Button[targetName]
				if button then
					local GVAR_TargetButton = GVAR.TargetButton[button]
					if GVAR_TargetButton then
						local oID = orbIDs[spellId]
						hasOrb[ oID.color ].name = targetName
						hasOrb[ oID.color ].orbval = val2
						GVAR.TargetButton[button].orbColor = oID.color
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						GVAR_TargetButton.FlagTexture:SetTexture(oID.texture)
						BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton, val2)
						BattlegroundTargets:SetOrbCorner(GVAR_TargetButton, oID.color)
					end
				end

				if flags >= 4 then
					BattlegroundTargets:CheckFlagCarrierEND()
					return
				end
				break
			end
		end

	end

	ENEMY_FirstFlagCheck[targetName] = nil

	local x
	for k in pairs(ENEMY_FirstFlagCheck) do
		x = true
		break
	end
	if not x then
		BattlegroundTargets:CheckFlagCarrierEND()
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckFlagCarrierSTART() -- FLAGSPY
	flagCHK = true
	flagflag = true

	wipe(ENEMY_FirstFlagCheck)
	for i = 1, #ENEMY_Data do
		ENEMY_FirstFlagCheck[ENEMY_Data[i].name] = 1
	end

	if isFlagBG == 1 or isFlagBG == 2 or isFlagBG == 3 then

		-- friend buff & debuff check
		local function chk()
			for num = 1, GetNumGroupMembers() do
				local unitID = "raid"..num
				for i = 1, 40 do
					local _, _, _, _, _, _, _, _, _, _, spellId = UnitBuff(unitID, i)
					if not spellId then break end
					if flagIDs[spellId] then
						flagDebuff = 0
						flags = 1
						for j = 1, 40 do
							local _, _, _, count, _, _, _, _, _, _, spellId = UnitDebuff(unitID, j)
							if not spellId then break end
							if debuffIDs[spellId] then
								flagDebuff = count
								return
							end
						end
						return
					end
				end
			end
		end
		chk()

	elseif isFlagBG == 5 then

		-- friend debuff check
		for num = 1, GetNumGroupMembers() do
			for i = 1, 40 do
				local _, _, _, _, _, _, _, _, _, _, spellId = UnitDebuff("raid"..num, i)
				if not spellId then break end
				if orbIDs[spellId] then
					flags = flags + 1 -- FLAG_TOK_CHK
					break
				end
			end
		end
		if flags >= 4 then
			BattlegroundTargets:CheckFlagCarrierEND()
			return
		end

	end

	BattlegroundTargets:RegisterEvent("UNIT_TARGET")
	BattlegroundTargets:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	BattlegroundTargets:RegisterEvent("PLAYER_TARGET_CHANGED")
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckFlagCarrierEND() -- FLAGSPY
	flagCHK = nil
	flagflag = true
	wipe(ENEMY_FirstFlagCheck)
	if not OPT.ButtonShowHealthBar[currentSize] and
	   not OPT.ButtonShowHealthText[currentSize] and
	   not OPT.ButtonShowTargetCount[currentSize] and
	   not OPT.ButtonShowAssist[currentSize] and
	   not OPT.ButtonShowLeader[currentSize] and
	   (not OPT.ButtonRangeCheck[currentSize] or OPT.ButtonTypeRangeCheck[currentSize] < 2) and
	   not isLowLevel -- LVLCHK
	then
		BattlegroundTargets:UnregisterEvent("UNIT_TARGET")
	end
	if not OPT.ButtonShowHealthBar[currentSize] and
	   not OPT.ButtonShowHealthText[currentSize] and
	   (not OPT.ButtonRangeCheck[currentSize] or OPT.ButtonTypeRangeCheck[currentSize] < 2)
	then
		BattlegroundTargets:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	end
	if not OPT.ButtonShowTarget[currentSize] and
	   (not OPT.ButtonRangeCheck[currentSize] or OPT.ButtonTypeRangeCheck[currentSize] < 2)
	then
		BattlegroundTargets:UnregisterEvent("PLAYER_TARGET_CHANGED")
	end
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
	if flagDebuff > 0 then
		GVAR_TargetButton.FlagDebuff:SetText(flagDebuff)
	else
		GVAR_TargetButton.FlagDebuff:SetText("")
	end
end

function BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton, value)
	if value and value > 0 then
		GVAR_TargetButton.OrbDebuff:SetText(value)
	else
		GVAR_TargetButton.OrbDebuff:SetText("")
	end
end

function BattlegroundTargets:SetOrbCorner(GVAR_TargetButton, color)
	if color == "Blue" then
		GVAR_TargetButton.OrbCornerTL:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerTR:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerBL:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerBR:SetAlpha(1)
	elseif color == "Purple" then
		GVAR_TargetButton.OrbCornerTL:SetAlpha(1)
		GVAR_TargetButton.OrbCornerTR:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerBL:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerBR:SetAlpha(0.15)
	elseif color == "Green" then
		GVAR_TargetButton.OrbCornerTL:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerTR:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerBL:SetAlpha(1)
		GVAR_TargetButton.OrbCornerBR:SetAlpha(0.15)
	elseif color == "Orange" then
		GVAR_TargetButton.OrbCornerTL:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerTR:SetAlpha(1)
		GVAR_TargetButton.OrbCornerBL:SetAlpha(0.15)
		GVAR_TargetButton.OrbCornerBR:SetAlpha(0.15)
	end
end

function BattlegroundTargets:FlagDebuffCheck(message)
	--print("F.lagDebuffCheck", message) -- TEST
	if message == FLG["WSG_TP_STRING_FLAG_DEBUFF1"] or message == FLG["WSG_TP_STRING_FLAG_DEBUFF2"] then -- Warsong Gulch & Twin Peaks
		flagDebuff = flagDebuff + 1
		if hasFlag then
			local Name2Button = ENEMY_Name2Button[hasFlag]
			if Name2Button then
				local GVAR_TargetButton = GVAR.TargetButton[Name2Button]
				if GVAR_TargetButton then
					BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
				end
			end
		end
	end
end

function BattlegroundTargets:OrbDebuffCheck(enemyID, enemyName, buttonNum)
	for i = 1, 40 do
		local _, _, _, _, _, _, _, _, _, _, spellId, _, _, _, _, val2 = UnitDebuff(enemyID, i) -- print(enemyID, enemyName, i, UnitDebuff(enemyID, i))
		if not spellId then return end
		if orbIDs[spellId] then
			local hasflg
			for k, v in pairs(hasOrb) do
				if v.name == enemyName then
					hasflg = true
					break
				end
			end
			if not hasflg then
				flags = flags + 1 -- FLAG_TOK_CHK
			end

			local oID = orbIDs[spellId]
			hasOrb[ oID.color ].name = enemyName
			hasOrb[ oID.color ].orbval = val2
			GVAR.TargetButton[buttonNum].orbColor = oID.color
			GVAR.TargetButton[buttonNum].FlagTexture:SetAlpha(1)
			GVAR.TargetButton[buttonNum].FlagTexture:SetTexture(oID.texture)
			BattlegroundTargets:SetOrbDebuff(GVAR.TargetButton[buttonNum], val2)
			BattlegroundTargets:SetOrbCorner(GVAR.TargetButton[buttonNum], oID.color)

			if flagCHK and flags >= 4 then
				BattlegroundTargets:CheckFlagCarrierEND()
			end
			return
		end
	end
end

function BattlegroundTargets:OrbReturnCheck(message)
	--print("O.rbReturnCheck", message) -- TEST
	local orbColor = strmatch(message, FLG["TOK_PATTERN_RETURNED"]) -- Temple of Kotmogu: orb was returned
	if orbColor then
		local color = orbData(orbColor)
		wipe(hasOrb[color])
		flags = flags - 1 -- FLAG_TOK_CHK
		if flags < 0 then
			flags = 0
		end
		local GVAR_TargetButton = GVAR.TargetButton
		for i = 1, currentSize do
			if GVAR_TargetButton[i].orbColor == color then
				GVAR.TargetButton[i].orbColor = nil
				GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
				GVAR_TargetButton[i].OrbDebuff:SetText("")
				GVAR_TargetButton[i].OrbCornerTL:SetAlpha(0)
				GVAR_TargetButton[i].OrbCornerTR:SetAlpha(0)
				GVAR_TargetButton[i].OrbCornerBL:SetAlpha(0)
				GVAR_TargetButton[i].OrbCornerBR:SetAlpha(0)
				break
			end
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CarrierCheck(message, messageFaction)
	--print("C.arrierCheck", isFlagBG, "#", message, "#", messageFaction) -- TEST
	if isFlagBG == 1 or isFlagBG == 3 then
		BattlegroundTargets:Carrier_WSG_TP(message, messageFaction)
	elseif isFlagBG == 2 then
		BattlegroundTargets:Carrier_EOTS(message, messageFaction)
	elseif isFlagBG == 4 then
		BattlegroundTargets:Carrier_DG(message, messageFaction)
	elseif isFlagBG == 5 then
		BattlegroundTargets:Carrier_TOK(message, messageFaction)
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- Warsong Gulch & Twin Peaks ------------------------------------------------------------------------------------------
function BattlegroundTargets:Carrier_WSG_TP(message, messageFaction)
	if messageFaction == playerFactionBG then
		-- -------------------------------------------------------------------------
		local fc = strmatch(message, FLG["WSG_TP_PATTERN_PICKED1"]) or -- Warsong Gulch & Twin Peaks: flag was picked
		           strmatch(message, FLG["WSG_TP_PATTERN_PICKED2"])    -- Warsong Gulch & Twin Peaks: flag was picked
		if fc then
			flags = flags + 1
		-- -------------------------------------------------------------------------
		elseif strmatch(message, FLG["WSG_TP_MATCH_CAPTURED"]) then -- Warsong Gulch & Twin Peaks: flag was captured
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
				GVAR_TargetButton[i].FlagDebuff:SetText("")
			end
			hasFlag = nil
			flagDebuff = 0
			flags = 0
			if flagCHK then
				BattlegroundTargets:CheckFlagCarrierEND()
			end
		-- -------------------------------------------------------------------------
		elseif strmatch(message, FLG["WSG_TP_MATCH_DROPPED"]) then -- Warsong Gulch & Twin Peaks: flag was dropped
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
				GVAR_TargetButton[i].FlagDebuff:SetText("")
			end
			hasFlag = nil
			flags = flags - 1
			if flags <= 0 then
				flagDebuff = 0
				flags = 0
			end
		end
		-- -------------------------------------------------------------------------
	else
		-- -------------------------------------------------------------------------
		local efc = strmatch(message, FLG["WSG_TP_PATTERN_PICKED1"]) or -- Warsong Gulch & Twin Peaks: flag was picked
		            strmatch(message, FLG["WSG_TP_PATTERN_PICKED2"])    -- Warsong Gulch & Twin Peaks: flag was picked
		if efc then
			flags = flags + 1
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
				GVAR_TargetButton[i].FlagDebuff:SetText("")
			end
			if flagCHK then
				BattlegroundTargets:CheckFlagCarrierEND()
			end
			-- 1.) check for name-server
			for fullname, fullnameButton in pairs(ENEMY_Name2Button) do -- ENEMY_Name2Button and ENEMY_Name4Flag have same buttonID
				if fullname == efc then
					local GVAR_TargetButton = GVAR.TargetButton[fullnameButton]
					if GVAR_TargetButton then
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
						hasFlag = fullname
						return
					end
				end
			end
			-- 2.) check for name only
			for name, button in pairs(ENEMY_Name4Flag) do
				if name == efc then
					local GVAR_TargetButton = GVAR.TargetButton[button]
					if GVAR_TargetButton then
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
						for fullname, fullnameButton in pairs(ENEMY_Name2Button) do -- ENEMY_Name2Button and ENEMY_Name4Flag have same buttonID
							if button == fullnameButton then
								hasFlag = fullname
								return
							end
						end
					end
					return
				end
			end
			-- ---
		-- -------------------------------------------------------------------------
		elseif strmatch(message, FLG["WSG_TP_MATCH_CAPTURED"]) then -- Warsong Gulch & Twin Peaks: flag was captured
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
				GVAR_TargetButton[i].FlagDebuff:SetText("")
			end
			hasFlag = nil
			flagDebuff = 0
			flags = 0
			if flagCHK then
				BattlegroundTargets:CheckFlagCarrierEND()
			end
		-- -------------------------------------------------------------------------
		elseif strmatch(message, FLG["WSG_TP_MATCH_DROPPED"]) then -- Warsong Gulch & Twin Peaks: flag was dropped
			flags = flags - 1
			if flags <= 0 then
				flagDebuff = 0
				flags = 0
			end
		end
		-- -----------------------------------------------------------------------------------------------------------------
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- Eye of the Storm ----------------------------------------------------------------------------------------------------
function BattlegroundTargets:Carrier_EOTS(message, messageFaction)
	-- ---------------------------------------------------------------------------
	if message == FLG["EOTS_STRING_CAPTURED_BY_ALLIANCE"] or -- Eye of the Storm: flag was captured
	   message == FLG["EOTS_STRING_CAPTURED_BY_HORDE"] or    -- Eye of the Storm: flag was captured
	   message == FLG["EOTS_STRING_DROPPED"]                 -- Eye of the Storm: flag was dropped
	then
		local GVAR_TargetButton = GVAR.TargetButton
		for i = 1, currentSize do
			GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
			GVAR_TargetButton[i].FlagDebuff:SetText("")
		end
		hasFlag = nil
		if flagCHK then
			BattlegroundTargets:CheckFlagCarrierEND()
		end
		return
	end
	-- ---------------------------------------------------------------------------
	if messageFaction ~= playerFactionBG then
		-- -------------------------------------------------------------------------
		local efc = strmatch(message, FLG["EOTS_PATTERN_PICKED"]) -- Eye of the Storm: flag was picked
		if efc then
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
				GVAR_TargetButton[i].FlagDebuff:SetText("")
			end
			if flagCHK then
				BattlegroundTargets:CheckFlagCarrierEND()
			end
			-- 1.) check for name-server
			for fullname, fullnameButton in pairs(ENEMY_Name2Button) do -- ENEMY_Name2Button and ENEMY_Name4Flag have same buttonID
				if fullname == efc then
					local GVAR_TargetButton = GVAR.TargetButton[fullnameButton]
					if GVAR_TargetButton then
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
						hasFlag = fullname
						return
					end
				end
			end
			-- 2.) check for name only
			for name, button in pairs(ENEMY_Name4Flag) do
				if name == efc then
					local GVAR_TargetButton = GVAR.TargetButton[button]
					if GVAR_TargetButton then
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						BattlegroundTargets:SetFlagDebuff(GVAR_TargetButton)
						for fullname, fullnameButton in pairs(ENEMY_Name2Button) do -- ENEMY_Name2Button and ENEMY_Name4Flag have same buttonID
							if button == fullnameButton then
								hasFlag = fullname
								return
							end
						end
					end
					return
				end
			end
			-- ---
		end
		-- -------------------------------------------------------------------------
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- Deepwind Gorge ------------------------------------------------------------------------------------------------------
function BattlegroundTargets:Carrier_DG(message, messageFaction)
	if messageFaction ~= playerFactionBG then
		-- -------------------------------------------------------------------------
		if strmatch(message, FLG["DG_PATTERN_DROPPED"]) or -- Deepwind Gorge: cart dropped
		   strmatch(message, FLG["DG_PATTERN_STOLEN"])     -- Deepwind Gorge: gold stolen
		then
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
				GVAR_TargetButton[i].FlagDebuff:SetText("")
			end
			hasFlag = nil
			if flagCHK then
				BattlegroundTargets:CheckFlagCarrierEND()
			end
		else
		-- -------------------------------------------------------------------------
			local efc = strmatch(message, FLG["DG_PATTERN_TAKEN"]) or -- Deepwind Gorge: cart taken
			            strmatch(message, FLG["DG_PATTERN_PICKED"])   -- Deepwind Gorge: cart picked
			if efc then
				local GVAR_TargetButton = GVAR.TargetButton
				for i = 1, currentSize do
					GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
					GVAR_TargetButton[i].FlagDebuff:SetText("")
				end
				if flagCHK then
					BattlegroundTargets:CheckFlagCarrierEND()
				end
				-- 1.) check for name-server
				for fullname, fullnameButton in pairs(ENEMY_Name2Button) do -- ENEMY_Name2Button and ENEMY_Name4Flag have same buttonID
					if fullname == efc then
						local GVAR_TargetButton = GVAR.TargetButton[fullnameButton]
						if GVAR_TargetButton then
							GVAR_TargetButton.FlagTexture:SetAlpha(1)
							GVAR_TargetButton.FlagDebuff:SetText("")
							hasFlag = fullname
							return
						end
					end
				end
				-- 2.) check for name only
				for name, button in pairs(ENEMY_Name4Flag) do
					if name == efc then
						local GVAR_TargetButton = GVAR.TargetButton[button]
						if GVAR_TargetButton then
							GVAR_TargetButton.FlagTexture:SetAlpha(1)
							GVAR_TargetButton.FlagDebuff:SetText("")
							for fullname, fullnameButton in pairs(ENEMY_Name2Button) do -- ENEMY_Name2Button and ENEMY_Name4Flag have same buttonID
								if button == fullnameButton then
									hasFlag = fullname
									return
								end
							end
						end
						return
					end
				end
				-- ---
			end
		-- -------------------------------------------------------------------------
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- Temple of Kotmogu ---------------------------------------------------------------------------------------------------
function BattlegroundTargets:Carrier_TOK(message, messageFaction)
	if messageFaction == playerFactionBG then
		-- -------------------------------------------------------------------------
		local orbCarrier, orbColor = strmatch(message, FLG["TOK_PATTERN_TAKEN"]) -- Temple of Kotmogu: orb was taken
		if orbCarrier and orbColor then
			local color = orbData(orbColor)
			--print("taken friend", orbCarrier, orbColor, color)
			wipe(hasOrb[color])
			flags = flags + 1 -- FLAG_TOK_CHK
			if flagCHK and flags >= 4 then
				BattlegroundTargets:CheckFlagCarrierEND()
			end
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				if GVAR_TargetButton[i].orbColor == color then
					GVAR.TargetButton[i].orbColor = nil
					GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
					GVAR_TargetButton[i].OrbDebuff:SetText("")
					GVAR_TargetButton[i].OrbCornerTL:SetAlpha(0)
					GVAR_TargetButton[i].OrbCornerTR:SetAlpha(0)
					GVAR_TargetButton[i].OrbCornerBL:SetAlpha(0)
					GVAR_TargetButton[i].OrbCornerBR:SetAlpha(0)
					break
				end
			end
		end
		-- -------------------------------------------------------------------------
	else
		-- -------------------------------------------------------------------------
		local orbCarrier, orbColor = strmatch(message, FLG["TOK_PATTERN_TAKEN"]) -- Temple of Kotmogu: orb was taken
		if orbCarrier and orbColor then
			local color, texture = orbData(orbColor)
			--print("taken enemy", orbCarrier, orbColor, color)
			wipe(hasOrb[color])
			flags = flags + 1 -- FLAG_TOK_CHK
			if flagCHK and flags >= 4 then
				BattlegroundTargets:CheckFlagCarrierEND()
			end
			local GVAR_TargetButton = GVAR.TargetButton
			for i = 1, currentSize do
				if GVAR_TargetButton[i].orbColor == color then
					GVAR.TargetButton[i].orbColor = nil
					GVAR_TargetButton[i].FlagTexture:SetAlpha(0)
					GVAR_TargetButton[i].OrbDebuff:SetText("")
					GVAR_TargetButton[i].OrbCornerTL:SetAlpha(0)
					GVAR_TargetButton[i].OrbCornerTR:SetAlpha(0)
					GVAR_TargetButton[i].OrbCornerBL:SetAlpha(0)
					GVAR_TargetButton[i].OrbCornerBR:SetAlpha(0)
					break
				end
			end
			-- 1.) check for name-server
			for fullname, fullnameButton in pairs(ENEMY_Name2Button) do -- ENEMY_Name2Button and ENEMY_Name4Flag have same buttonID
				if fullname == orbCarrier then
					local GVAR_TargetButton = GVAR.TargetButton[fullnameButton]
					if GVAR_TargetButton then
						GVAR.TargetButton[fullnameButton].orbColor = color
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						GVAR_TargetButton.FlagTexture:SetTexture(texture)
						BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton)
						BattlegroundTargets:SetOrbCorner(GVAR_TargetButton, color)
						hasOrb[color].name = fullname
						return
					end
				end
			end
			-- 2.) check for name only
			for name, button in pairs(ENEMY_Name4Flag) do
				if name == orbCarrier then
					local GVAR_TargetButton = GVAR.TargetButton[button]
					if GVAR_TargetButton then
						GVAR.TargetButton[button].orbColor = color
						GVAR_TargetButton.FlagTexture:SetAlpha(1)
						GVAR_TargetButton.FlagTexture:SetTexture(texture)
						BattlegroundTargets:SetOrbDebuff(GVAR_TargetButton)
						BattlegroundTargets:SetOrbCorner(GVAR_TargetButton, color)
						for fullname, fullnameButton in pairs(ENEMY_Name2Button) do -- ENEMY_Name2Button and ENEMY_Name4Flag have same buttonID
							if button == fullnameButton then
								hasOrb[color].name = fullname
								return
							end
						end
					end
					return
				end
			end
			-- ---
		end
		-- -------------------------------------------------------------------------
	end
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
local function CombatLogRangeCheck(sourceName, destName, spellId)
	if not SPELL_Range[spellId] then
		local _, _, _, _, _, _, _, _, maxRange = GetSpellInfo(spellId)
		if not maxRange then return end
		SPELL_Range[spellId] = maxRange
	end

	if OPT.ButtonTypeRangeCheck[currentSize] == 4 then

		if SPELL_Range[spellId] > rangeMax then return end
		if SPELL_Range[spellId] < rangeMin then return end

		-- enemy attack player
		if ENEMY_Names[sourceName] then
			if destName == playerName then

				if ENEMY_Name2Percent[sourceName] == 0 then
					ENEMY_Name2Range[sourceName] = nil
					local sourceButton = ENEMY_Name2Button[sourceName]
					if sourceButton then
						local GVAR_TargetButton = GVAR.TargetButton[sourceButton]
						if GVAR_TargetButton then
							Range_Display(false, GVAR_TargetButton, OPT.ButtonRangeDisplay[currentSize])
						end
					end
					return
				end

				local curTime = GetTime()
				ENEMY_Name2Range[sourceName] = curTime
				local sourceButton = ENEMY_Name2Button[sourceName]
				if sourceButton then
					local GVAR_TargetButton = GVAR.TargetButton[sourceButton]
					if GVAR_TargetButton then
						Range_Display(true, GVAR_TargetButton)
					end
				end
				if range_CL_DisplayThrottle + range_CL_DisplayFrequency > curTime then return end
				range_CL_DisplayThrottle = curTime
				BattlegroundTargets:UpdateRange(curTime)
			end
		end

	elseif OPT.ButtonTypeRangeCheck[currentSize] == 3 then

		if SPELL_Range[spellId] > 45 then return end

		-- enemy attack player
		if ENEMY_Names[sourceName] then
			if destName == playerName then

				if ENEMY_Name2Percent[sourceName] == 0 then
					ENEMY_Name2Range[sourceName] = nil
					local sourceButton = ENEMY_Name2Button[sourceName]
					if sourceButton then
						local GVAR_TargetButton = GVAR.TargetButton[sourceButton]
						if GVAR_TargetButton then
							Range_Display(false, GVAR_TargetButton, OPT.ButtonRangeDisplay[currentSize])
						end
					end
					return
				end

				local curTime = GetTime()
				ENEMY_Name2Range[sourceName] = curTime
				local sourceButton = ENEMY_Name2Button[sourceName]
				if sourceButton then
					local GVAR_TargetButton = GVAR.TargetButton[sourceButton]
					if GVAR_TargetButton then
						Range_Display(true, GVAR_TargetButton)
					end
				end
				if range_CL_DisplayThrottle + range_CL_DisplayFrequency > curTime then return end
				range_CL_DisplayThrottle = curTime
				BattlegroundTargets:UpdateRange(curTime)
			end
		end

	else--if OPT.ButtonTypeRangeCheck[currentSize] == 1 then

		if SPELL_Range[spellId] > 45 then return end

		-- enemy attack friend
		if ENEMY_Names[sourceName] then
			if destName == playerName then
				ENEMY_Name2Range[sourceName] = GetTime()
				local sourceButton = ENEMY_Name2Button[sourceName]
				if sourceButton then
					local GVAR_TargetButton = GVAR.TargetButton[sourceButton]
					if GVAR_TargetButton then
						Range_Display(true, GVAR_TargetButton)
					end
				end
			elseif FRIEND_Names[destName] then
				local curTime = GetTime()
				if CheckInteractDistance(destName, 1) then -- 1:Inspect=28
					ENEMY_Name2Range[sourceName] = curTime
				end
				if range_CL_DisplayThrottle + range_CL_DisplayFrequency > curTime then return end
				range_CL_DisplayThrottle = curTime
				BattlegroundTargets:UpdateRange(curTime)
			end
		-- friend attack enemy
		elseif ENEMY_Names[destName] then
			if sourceName == playerName then
				ENEMY_Name2Range[destName] = GetTime()
				local destButton = ENEMY_Name2Button[destName]
				if destButton then
					local GVAR_TargetButton = GVAR.TargetButton[destButton]
					if GVAR_TargetButton then
						Range_Display(true, GVAR_TargetButton)
					end
				end
			elseif FRIEND_Names[sourceName] then
				local curTime = GetTime()
				if CheckInteractDistance(sourceName, 1) then -- 1:Inspect=28
					ENEMY_Name2Range[destName] = curTime
				end
				if range_CL_DisplayThrottle + range_CL_DisplayFrequency > curTime then return end
				range_CL_DisplayThrottle = curTime
				BattlegroundTargets:UpdateRange(curTime)
			end
		end

	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:UpdateRange(curTime)
	if isDeadUpdateStop then
		BattlegroundTargets:ClearRangeData()
		return
	end

	local ButtonRangeDisplay = OPT.ButtonRangeDisplay[currentSize]
	for i = 1, currentSize do
		Range_Display(false, GVAR.TargetButton[i], ButtonRangeDisplay)
	end

	for name, timeStamp in pairs(ENEMY_Name2Range) do
		local button = ENEMY_Name2Button[name]
		if not button then
			ENEMY_Name2Range[name] = nil
		elseif ENEMY_Name2Percent[name] == 0 then
			ENEMY_Name2Range[name] = nil
		elseif timeStamp + range_DisappearTime < curTime then
			ENEMY_Name2Range[name] = nil
		else
			local GVAR_TargetButton = GVAR.TargetButton[button]
			if GVAR_TargetButton then
				Range_Display(true, GVAR_TargetButton)
			end
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:ClearRangeData()
	if OPT.ButtonRangeCheck[currentSize] then
		wipe(ENEMY_Name2Range)
		local ButtonRangeDisplay = OPT.ButtonRangeDisplay[currentSize]
		for i = 1, currentSize do
			Range_Display(false, GVAR.TargetButton[i], ButtonRangeDisplay)
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckPlayerLevel() -- LVLCHK
	if playerLevel == maxLevel then
		isLowLevel = nil
		BattlegroundTargets:UnregisterEvent("PLAYER_LEVEL_UP")
	elseif playerLevel < maxLevel then
		isLowLevel = true
		BattlegroundTargets:RegisterEvent("PLAYER_LEVEL_UP")
	else--if playerLevel > maxLevel then
		isLowLevel = nil
		BattlegroundTargets:UnregisterEvent("PLAYER_LEVEL_UP")
		Print("ERROR", "wrong level", locale, playerLevel, maxLevel)
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckFaction()
	local faction = UnitFactionGroup("player")
	if faction == "Horde" then
		playerFactionDEF   = 0 -- Horde
		oppositeFactionDEF = 1 -- Alliance
		BattlegroundTargets:UnregisterEvent("NEUTRAL_FACTION_SELECT_RESULT")
	elseif faction == "Alliance" then
		playerFactionDEF   = 1 -- Alliance
		oppositeFactionDEF = 0 -- Horde
		BattlegroundTargets:UnregisterEvent("NEUTRAL_FACTION_SELECT_RESULT")
	elseif faction == "Neutral" then
		playerFactionDEF   = 2 -- Pandaren
		oppositeFactionDEF = 2 -- Pandaren
		BattlegroundTargets:RegisterEvent("NEUTRAL_FACTION_SELECT_RESULT")
	else
		Print("ERROR", "unknown faction", locale, faction)
		playerFactionDEF   = 1 -- Dummy
		oppositeFactionDEF = 0 -- Dummy
	end
	playerFactionBG   = playerFactionDEF
	oppositeFactionBG = oppositeFactionDEF

	if playerFactionDEF == 0 then -- setup_flag_texture
		Textures.flagTexture = "Interface\\WorldStateFrame\\HordeFlag"
		Textures.cartTexture = "Interface\\Minimap\\Vehicle-SilvershardMines-MineCartRed"
		if GVAR.Summary and GVAR.Summary.Logo1 then -- summary_flag_texture
			GVAR.Summary.Logo1:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")
			GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")
		end
	elseif playerFactionDEF == 1 then
		Textures.flagTexture = "Interface\\WorldStateFrame\\AllianceFlag"
		Textures.cartTexture = "Interface\\Minimap\\Vehicle-SilvershardMines-MineCartBlue"
		if GVAR.Summary and GVAR.Summary.Logo1 then -- summary_flag_texture
			GVAR.Summary.Logo1:SetTexture("Interface\\FriendsFrame\\PlusManz-Alliance")
			GVAR.Summary.Logo2:SetTexture("Interface\\FriendsFrame\\PlusManz-Horde")
		end
	else
		Textures.flagTexture = "Interface\\WorldStateFrame\\ColumnIcon-FlagCapture2" -- neutral_flag
		Textures.cartTexture = "Interface\\Minimap\\Vehicle-SilvershardMines-MineCart" -- neutral_flag
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:CheckIfPlayerIsGhost(state)
	if not inBattleground then return end
	if not state and UnitIsGhost("player") then
		isDeadUpdateStop = true
		BattlegroundTargets:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		BattlegroundTargets:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		BattlegroundTargets:UnregisterEvent("UNIT_TARGET")
		BattlegroundTargets:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		BattlegroundTargets:UnregisterEvent("PLAYER_TARGET_CHANGED")
		BattlegroundTargets:UnregisterEvent("PLAYER_FOCUS_CHANGED")
		BattlegroundTargets:ClearRangeData()
		GVAR.IsGhostTexture:Show()
	else
		isDeadUpdateStop = false
		if not isConfig then
			GVAR.IsGhostTexture:Hide()
			BattlegroundTargets:EventRegister()
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:BattlefieldScoreRequest()
	local wssf = WorldStateScoreFrame
	if wssf and wssf:IsShown() then
		return
	end
	SetBattlefieldScoreFaction()
	RequestBattlefieldScoreData()
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
function BattlegroundTargets:EventRegister(showerror)
	if not inBattleground then return end
	if not BattlegroundTargets_Options.EnableBracket[currentSize] then return end

	BattlegroundTargets:RegisterEvent("PLAYER_DEAD")
	BattlegroundTargets:RegisterEvent("PLAYER_UNGHOST")
	BattlegroundTargets:RegisterEvent("PLAYER_ALIVE")

	if isLowLevel then -- LVLCHK
		BattlegroundTargets:RegisterEvent("UNIT_TARGET")
	end

	if OPT.ButtonShowHealthBar[currentSize] or OPT.ButtonShowHealthText[currentSize] then
		BattlegroundTargets:RegisterEvent("UNIT_TARGET")
		BattlegroundTargets:RegisterEvent("UNIT_HEALTH_FREQUENT")
		BattlegroundTargets:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	end

	if OPT.ButtonShowTargetCount[currentSize] then
		BattlegroundTargets:RegisterEvent("UNIT_TARGET")
	end

	if OPT.ButtonShowTarget[currentSize] then
		BattlegroundTargets:RegisterEvent("PLAYER_TARGET_CHANGED")
	end

	if OPT.ButtonShowFocus[currentSize] then
		BattlegroundTargets:RegisterEvent("PLAYER_FOCUS_CHANGED")
	end

	if OPT.ButtonShowFlag[currentSize] then
		if isFlagBG > 0 then
			BattlegroundTargets:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
			BattlegroundTargets:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
			BattlegroundTargets:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
			if isFlagBG == 5 then
				BattlegroundTargets:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
			end
		end
	end

	if OPT.ButtonShowAssist[currentSize] then
		BattlegroundTargets:RegisterEvent("GROUP_ROSTER_UPDATE")
		BattlegroundTargets:RegisterEvent("UNIT_TARGET")
	end

	if OPT.ButtonShowLeader[currentSize] then
		BattlegroundTargets:RegisterEvent("UNIT_TARGET")
	end

	rangeSpellName = nil
	rangeMin = nil
	rangeMax = nil
	if OPT.ButtonRangeCheck[currentSize] then
		if OPT.ButtonTypeRangeCheck[currentSize] == 1 then
			BattlegroundTargets:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		elseif OPT.ButtonTypeRangeCheck[currentSize] >= 2 then

			if ranges[playerClassEN] then
				if IsSpellKnown(ranges[playerClassEN]) then
					local SpellName, _, _, _, _, _, _, Min, Max = GetSpellInfo(ranges[playerClassEN])
					rangeSpellName = SpellName
					rangeMin = Min
					rangeMax = Max
					if not rangeSpellName then
						if showerror then Print("ERROR", "unknown spell name (rangecheck)", locale, playerClassEN, "id:", ranges[playerClassEN]) end
					elseif (not rangeMin or not rangeMax) or (rangeMin <= 0 and rangeMax <= 0) then
						if showerror then Print("ERROR", "spell min/max fail (rangecheck)", locale, rangeSpellName, rangeMin, rangeMax) end
					else
						BattlegroundTargets:RegisterEvent("UNIT_HEALTH_FREQUENT")
						BattlegroundTargets:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
						BattlegroundTargets:RegisterEvent("PLAYER_TARGET_CHANGED")
						BattlegroundTargets:RegisterEvent("UNIT_TARGET")
						if OPT.ButtonTypeRangeCheck[currentSize] >= 3 then
							BattlegroundTargets:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
						end
					end
				elseif playerClassEN == "MONK" and playerLevel < 14 then -- MON14
					if showerror then Print("WARNING", playerClassEN, "Required level for class-spell based rangecheck is 14.") end
				elseif playerClassEN == "ROGUE" and playerLevel < 12 then -- ROG12
					if showerror then Print("WARNING", playerClassEN, "Required level for class-spell based rangecheck is 12.") end
				else
					if showerror then Print("ERROR", "unknown spell (rangecheck)", locale, playerClassEN, "id:", ranges[playerClassEN]) end
				end
			else
				if showerror then Print("ERROR", "unknown class (rangecheck)", locale, playerClassEN) end
			end

		end
	end

	BattlegroundTargets:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")
end

function BattlegroundTargets:EventUnregister()
	BattlegroundTargets:UnregisterEvent("PLAYER_DEAD")
	BattlegroundTargets:UnregisterEvent("PLAYER_UNGHOST")
	BattlegroundTargets:UnregisterEvent("PLAYER_ALIVE")
	BattlegroundTargets:UnregisterEvent("UNIT_HEALTH_FREQUENT")
	BattlegroundTargets:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	BattlegroundTargets:UnregisterEvent("UNIT_TARGET")
	BattlegroundTargets:UnregisterEvent("PLAYER_TARGET_CHANGED")
	BattlegroundTargets:UnregisterEvent("PLAYER_FOCUS_CHANGED")
	BattlegroundTargets:UnregisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
	BattlegroundTargets:UnregisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
	BattlegroundTargets:UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
	BattlegroundTargets:UnregisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	BattlegroundTargets:UnregisterEvent("GROUP_ROSTER_UPDATE")
	BattlegroundTargets:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	BattlegroundTargets:UnregisterEvent("UPDATE_BATTLEFIELD_SCORE")
end
-- ---------------------------------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------
local function OnEvent(self, event, ...)
	--if not eventTest[event] then eventTest[event] = 1 else eventTest[event] = eventTest[event] + 1 end -- TEST
	--if isConfig then print("###", isConfig, event) elseif event ~= "COMBAT_LOG_EVENT_UNFILTERED" then print("***", isConfig, event) end
	if event == "PLAYER_REGEN_DISABLED" then
		inCombat = true
		if isConfig then
			if not inWorld then return end
			BattlegroundTargets:DisableInsecureConfigWidges()
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		inCombat = false
		if reCheckBG then
			if not inWorld then return end
			BattlegroundTargets:BattlefieldCheck()
		end
		if reCheckScore then
			if not inWorld then return end
			BattlegroundTargets:BattlefieldScoreRequest()
		end
		if rePosMain then
			rePosMain = nil
			if GVAR.MainFrame:IsShown() then
				BattlegroundTargets:Frame_SavePosition("BattlegroundTargets_MainFrame")
			end
		end
		if reSetLayout then
			if not inWorld then return end
			BattlegroundTargets:SetupButtonLayout()
		end
		if isConfig then
			if not inWorld then return end
			BattlegroundTargets:EnableInsecureConfigWidges()
			if BattlegroundTargets_Options.EnableBracket[currentSize] then
				BattlegroundTargets:EnableConfigMode()
			else
				BattlegroundTargets:DisableConfigMode()
			end
		end

	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, _, _, _, sourceName, sourceFlags, _, _, destName, destFlags, _, spellId = ...
		if sourceName == destName then return end
		if not spellId then return end
		if not sourceFlags or band(sourceFlags, 0x00000400) == 0 then return end
		if not destFlags or band(destFlags, 0x00000400) == 0 then return end
		range_CL_Throttle = range_CL_Throttle + 1
		if range_CL_Throttle > range_CL_Frequency then
			range_CL_Throttle = 0
			range_CL_Frequency = random(1,3)
			return
		end
		CombatLogRangeCheck(sourceName, destName, spellId)

	elseif event == "UNIT_HEALTH_FREQUENT" then
		local arg1 = ...
		BattlegroundTargets:CheckUnitHealth(arg1)
	elseif event == "UNIT_TARGET" then
		local arg1 = ...
		if not raidUnitID[arg1] then return end
		BattlegroundTargets:CheckUnitTarget(arg1)
	elseif event == "UPDATE_MOUSEOVER_UNIT" then
		BattlegroundTargets:CheckUnitHealth("mouseover")
	elseif event == "PLAYER_TARGET_CHANGED" then
		BattlegroundTargets:CheckPlayerTarget()
	elseif event == "PLAYER_FOCUS_CHANGED" then
		BattlegroundTargets:CheckPlayerFocus()

	elseif event == "UPDATE_BATTLEFIELD_SCORE" then
		BattlegroundTargets:BattlefieldScoreUpdate()

	elseif event == "GROUP_ROSTER_UPDATE" then
		BattlegroundTargets:CheckAssist()

	elseif event == "CHAT_MSG_BG_SYSTEM_HORDE" then
		local arg1 = ...
		BattlegroundTargets:CarrierCheck(arg1, 0)
	elseif event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" then
		local arg1 = ...
		BattlegroundTargets:CarrierCheck(arg1, 1)
	elseif event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then
		local arg1 = ...
		BattlegroundTargets:FlagDebuffCheck(arg1)
	elseif event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		local arg1 = ...
		BattlegroundTargets:OrbReturnCheck(arg1)

	elseif event == "PLAYER_DEAD" then
		BattlegroundTargets:CheckIfPlayerIsGhost(true)
	elseif event == "PLAYER_UNGHOST" then
		BattlegroundTargets:CheckIfPlayerIsGhost(true)
	elseif event == "PLAYER_ALIVE" then
		BattlegroundTargets:CheckIfPlayerIsGhost()

	elseif event == "ZONE_CHANGED_NEW_AREA" then
		if isConfig then return end
		BattlegroundTargets:BattlefieldCheck()

	elseif event == "PLAYER_LEVEL_UP" then -- LVLCHK
		local arg1 = ...
		if arg1 then
			playerLevel = arg1
			BattlegroundTargets:CheckPlayerLevel()
		end

	elseif event == "NEUTRAL_FACTION_SELECT_RESULT" then
		BattlegroundTargets:CheckFaction()

	elseif event == "PLAYER_LOGIN" then
		BuildBattlegroundMapTable()
		BattlegroundTargets:CheckFaction()
		BattlegroundTargets:InitOptions()
		BattlegroundTargets:CreateInterfaceOptions()
		BattlegroundTargets:LDBcheck()
		BattlegroundTargets:CreateFrames()
		BattlegroundTargets:CreateOptionsFrame()
		tinsert(UISpecialFrames, "BattlegroundTargets_OptionsFrame")
		BattlegroundTargets:UnregisterEvent("PLAYER_LOGIN")
	elseif event == "PLAYER_ENTERING_WORLD" then
		inWorld = true
		BattlegroundTargets:CheckPlayerLevel() -- LVLCHK
		BattlegroundTargets:BattlefieldCheck()
		if BattlegroundTargets_Options.EnableBracket[currentSize] then
			BattlegroundTargets:CheckIfPlayerIsGhost()
		end
		BattlegroundTargets:CreateMinimapButton()
		if not BattlegroundTargets_Options.FirstRun then
			BattlegroundTargets:Frame_Toggle(GVAR.OptionsFrame)
			BattlegroundTargets_Options.FirstRun = true
		end
		BattlegroundTargets:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

BattlegroundTargets:RegisterEvent("PLAYER_REGEN_DISABLED")
BattlegroundTargets:RegisterEvent("PLAYER_REGEN_ENABLED")
BattlegroundTargets:RegisterEvent("ZONE_CHANGED_NEW_AREA")
BattlegroundTargets:RegisterEvent("PLAYER_LOGIN")
BattlegroundTargets:RegisterEvent("PLAYER_ENTERING_WORLD")
BattlegroundTargets:SetScript("OnEvent", OnEvent)