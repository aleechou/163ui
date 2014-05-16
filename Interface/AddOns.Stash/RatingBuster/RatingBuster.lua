--[[ 
Name: RatingBuster
Description: Converts combat ratings in tooltips into normal percentages.
Revision: $Revision: 394 $
Author: Whitetooth
Email: hotdogee [at] gmail [dot] com
LastUpdate: $Date: 2012-12-02 09:17:09 +0000 (Sun, 02 Dec 2012) $
]]

---------------
-- Libraries --
---------------
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceDB = LibStub("AceDB-3.0")
local TipHooker = LibStub("LibTipHooker-1.1")
local StatLogic = LibStub("LibStatLogic-1.2")
local L = LibStub("AceLocale-3.0"):GetLocale("RatingBuster")
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()


--------------------
-- AceAddon Setup --
--------------------
-- AceAddon Initialization
RatingBuster = LibStub("AceAddon-3.0"):NewAddon("RatingBuster", "AceConsole-3.0", "AceEvent-3.0")
RatingBuster.version = "5.0.4 (r"..gsub("$Revision: 394 $", "$Revision: (%d+) %$", "%1")..")"
RatingBuster.date = gsub("$Date: 2012-12-02 09:17:09 +0000 (Sun, 02 Dec 2012) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")


-----------
-- Cache --
-----------
local cache = {}
setmetatable(cache, {__mode = "kv"}) -- weak table to enable garbage collection
local function clearCache()
	for k in pairs(cache) do
		cache[k] = nil
	end
end
--debug
--RatingBuster.cache = cache


---------------------
-- Local Variables --
---------------------
local _
local _, class = UnitClass("player")
local playerLevel = UnitLevel("player") or 80
local calcLevel
local profileDB -- Initialized in :OnInitialize()
-- Cached GetItemInfo
local GetItemInfo = StatLogic.GetItemInfo
-- Localize globals
local _G = getfenv(0)
local strfind = strfind
local strsub = strsub
local gsub = gsub
local pairs = pairs
local ipairs = ipairs
local type = type
local select = select
local tinsert = tinsert
local tremove = tremove
local tsort = table.sort
local strsplit = strsplit
local strjoin = strjoin
local unpack = unpack
local tonumber = tonumber
local UnitStat = UnitStat
local GetParryChance = GetParryChance
local GetBlockChance = GetBlockChance
local SPELL_STAT1_NAME = SPELL_STAT1_NAME
local SPELL_STAT2_NAME = SPELL_STAT2_NAME
local SPELL_STAT3_NAME = SPELL_STAT3_NAME
local SPELL_STAT4_NAME = SPELL_STAT4_NAME
local SPELL_STAT5_NAME = SPELL_STAT5_NAME
local ARMOR = ARMOR
local ITEM_LEVEL = ITEM_LEVEL

local wowBuildNo = tonumber((select(2, GetBuildInfo())))
local toc = tonumber((select(4, GetBuildInfo())))

-----------------
-- DB Defaults --
-----------------
local ProfileVersion = 1
local profileDefaults = {
  ["*"] = false,
    enableReforgeUi = true,
	hideBlizzardComparisons = true,
	colorizeItemLevel = true,
  showAllItemLevel = false,
	showItemID = false,
	itemLevelTextColor = {r = 1.0, g = 0.82,  b = 0, hex = "|cffffd100"},
	useRequiredLevel = true,
	customLevel = 0,
	textColor = {r = 1.0, g = 0.996,  b = 0.545, hex = "|cfffffe8b"},
	enableTextColor = true,
	enableStatMods = true,
	enableSubtractEquippedStats = true,
	showRatings = 0,
	ratingSpell = false,
	ratingPhysical = false,
	detailedConversionText = false,
	expBreakDown = false,
	showStats = 0,
	showSum = 0,
	sumIgnoreUnused = true,
	sumMinQuality = 2, -- uncommon
	sumIgnoreCloth = true,
	sumIgnoreLeather = true,
	sumIgnoreMail = true,
	sumIgnorePlate = true,
	sumIgnoreEquipped = false,
	sumIgnoreEnchant = true,
	sumIgnoreGems = false,
	sumIgnorePris = true,
	sumBlankLine = true,
	sumBlankLineAfter = false,
	sumShowIcon = true,
	sumShowTitle = true,
	sumDiffStyle = "main",
	sumSortAlpha = false,
	sumAvoidWithBlock = false,
	showZeroValueStat = false,
	calcDiff = true,
	calcSum = true,
  sumMastery = true,
  sumHP = true,
  sumResilience = true,
	-- Gems
	sumGemRed = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemYellow = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemBlue = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemMeta = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	-- Gems Set 2
	sumGem2Toggle = 4,
	sumGemRed2 = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemYellow2 = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemBlue2 = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemMeta2 = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	-- Gems Set 3
	sumGem3Toggle = 4,
	sumGemRed3 = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemYellow3 = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemBlue3 = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
	sumGemMeta3 = {
		itemID = nil,
		gemID = nil,
		gemText = nil,
		gemName = nil,
		gemLink = nil,
	},
}

local defaults = {}
defaults.profile = profileDefaults

-- Custom class defaults will be applied in OnNewProfile(db, profile)
local classDefaults = {}
classDefaults.profileVersion = ProfileVersion
-- Class specific defaults
if class == "DRUID" then
	classDefaults.ratingSpell = true
	classDefaults.ratingPhysical = true
	classDefaults.sumMP = true
	--classDefaults.sumFAP = true
	classDefaults.showAPFromAgi = true
	classDefaults.sumAP = true
	classDefaults.sumHit = true
	classDefaults.sumCrit = true
	classDefaults.sumHaste = true
	classDefaults.sumExpertise = true
	classDefaults.sumDodge = true
	classDefaults.sumArmor = true
	classDefaults.sumSpellPower = true
	classDefaults.sumSpellCrit = true
	classDefaults.sumSpellHaste = true
	classDefaults.sumHealing = true
	classDefaults.sumMP5 = true
	if playerLevel < 50 then -- no armor spec bonus below level 50
    classDefaults.sumIgnoreCloth = false
  end
	classDefaults.sumIgnoreLeather = false
	classDefaults.showCritFromAgi = true
	classDefaults.showDodgeFromAgi = true
	classDefaults.showSpellCritFromInt = true
	--classDefaults.showHealingFromAgi = true -- Nurturing Instinct
	classDefaults.showMP5FromSpi = true -- Meditation
	classDefaults.showSpellHitFromSpi = true -- Balance of Power
	classDefaults.showSpellPwrFromInt = true
elseif class == "HUNTER" then
	classDefaults.ratingPhysical = true
	classDefaults.sumRAP = true
	classDefaults.sumRangedHit = true
	classDefaults.sumRangedCrit = true
	classDefaults.sumRangedHaste = true
	classDefaults.showCritFromAgi = true
	if playerLevel < 50 then -- no armor spec bonus below level 50
    classDefaults.sumIgnoreLeather = false
  end
	classDefaults.sumIgnoreMail = false
elseif class == "MAGE" then
	classDefaults.ratingSpell = true
	classDefaults.sumMP = true
	classDefaults.sumSpellPower = true
	classDefaults.sumSpellHit = true
	classDefaults.sumSpellCrit = true
	classDefaults.sumSpellHaste = true
	classDefaults.sumMP5 = true
	classDefaults.showSpellCritFromInt = true
	classDefaults.showSpellPwrFromInt = true
	classDefaults.sumIgnoreCloth = false
elseif class == "PALADIN" then
	classDefaults.ratingSpell = true
	classDefaults.ratingPhysical = true
	classDefaults.sumMP = true
	classDefaults.sumAP = true
	classDefaults.sumHit = true
	classDefaults.sumCrit = true
	classDefaults.sumHaste = true
	classDefaults.sumExpertise = true
	classDefaults.sumSpellPower = true
	classDefaults.sumSpellHit = true
	classDefaults.sumSpellCrit = true
	classDefaults.sumSpellHaste = true
	classDefaults.sumMP5 = true
	classDefaults.sumDodge = true
	classDefaults.sumParry = true
	classDefaults.sumBlock = true
	classDefaults.showSpellPwrFromInt = true
	classDefaults.showSpellPwrFromStr = true -- Sheath of Light, Touched by the Light
	classDefaults.showHealingFromStr = true -- Sheath of Light, Touched by the Light
	if playerLevel < 50 then -- no armor spec bonus below level 50
    classDefaults.sumIgnoreCloth = false
    classDefaults.sumIgnoreLeather = false
    classDefaults.sumIgnoreMail = false
  end
	classDefaults.sumIgnorePlate = false
	classDefaults.showCritFromAgi = true
	classDefaults.showDodgeFromAgi = true
	classDefaults.showSpellCritFromInt = true
	classDefaults.showParryFromStr = true -- Forceful Deflection
	classDefaults.showMP5FromSpi = true -- Meditation
	classDefaults.showSpellHitFromSpi = true -- Enlightened Judgements
elseif class == "PRIEST" then
	classDefaults.ratingSpell = true
	classDefaults.sumMP = true
	classDefaults.sumSpellPower = true
	classDefaults.sumSpellHit = true
	classDefaults.sumSpellCrit = true
	classDefaults.sumSpellHaste = true
	classDefaults.sumHealing = true
	classDefaults.sumMP5 = true
	classDefaults.showSpellPwrFromInt = true
	classDefaults.showSpellCritFromInt = true
	classDefaults.showMP5FromSpi = true -- Meditation
	classDefaults.showSpellHitFromSpi = true -- Twisted Faith
	classDefaults.sumIgnoreCloth = false
elseif class == "ROGUE" then
	classDefaults.ratingPhysical = true
	classDefaults.sumAP = true
	classDefaults.sumHit = true
	classDefaults.sumCrit = true
	classDefaults.sumHaste = true
	classDefaults.sumExpertise = true
	classDefaults.showCritFromAgi = true
	classDefaults.showDodgeFromAgi = true
	classDefaults.sumIgnoreLeather = false
elseif class == "SHAMAN" then
	classDefaults.ratingSpell = true
	classDefaults.ratingPhysical = true
	classDefaults.sumMP = true
	classDefaults.sumSpellPower = true
	classDefaults.sumSpellHit = true
	classDefaults.sumSpellCrit = true
	classDefaults.sumSpellHaste = true
	classDefaults.sumHealing = true
	classDefaults.sumMP5 = true
	classDefaults.showCritFromAgi = true
	classDefaults.showSpellCritFromInt = true
	classDefaults.showSpellPwrFromStr = true -- Mental Quickness
	classDefaults.showHealingFromStr = true -- Mental Quickness
	classDefaults.showSpellPwrFromAgi = true -- Mental Quickness
	classDefaults.showHealingFromAgi = true -- Mental Quickness
	classDefaults.showSpellPwrFromInt = true
	classDefaults.showMP5FromSpi = true -- Meditation
	classDefaults.showSpellHitFromSpi = true -- Elemental Precision
	if playerLevel < 50 then -- no armor spec bonus below level 50
    classDefaults.sumIgnoreCloth = false
  end
	classDefaults.sumIgnoreLeather = false
	classDefaults.sumIgnoreMail = false
elseif class == "WARLOCK" then
	classDefaults.ratingSpell = true
	classDefaults.sumMP = true
	classDefaults.sumSpellPower = true
	classDefaults.sumSpellHit = true
	classDefaults.sumSpellCrit = true
	classDefaults.sumSpellHaste = true
	classDefaults.showSpellCritFromInt = true
	classDefaults.showSpellPwrFromInt = true
	classDefaults.sumIgnoreCloth = false
elseif class == "WARRIOR" then
	classDefaults.ratingPhysical = true
	classDefaults.sumAP = true
	classDefaults.sumHit = true
	classDefaults.sumCrit = true
	classDefaults.sumHaste = true
	classDefaults.sumExpertise = true
	classDefaults.sumDodge = true
	classDefaults.sumParry = true
	classDefaults.sumBlock = true
	classDefaults.showCritFromAgi = true
	classDefaults.showDodgeFromAgi = true
	classDefaults.showAPFromArmor = true
	if playerLevel < 40 then
		classDefaults.sumIgnoreMail = false
	end
	classDefaults.sumIgnorePlate = false
	classDefaults.showParryFromStr = true -- Forceful Deflection
elseif class == "DEATHKNIGHT" then
	classDefaults.ratingPhysical = true
	classDefaults.sumAP = true
	classDefaults.sumHit = true
	classDefaults.sumCrit = true
	classDefaults.sumHaste = true
	classDefaults.sumExpertise = true
	classDefaults.sumDodge = true
	classDefaults.sumParry = true
	classDefaults.showCritFromAgi = true
	classDefaults.showDodgeFromAgi = true
	classDefaults.sumIgnorePlate = false
	classDefaults.showParryFromStr = true -- Forceful Deflection
	classDefaults.showAPFromArmor = true -- Bladed Armor
end

---------------------------
-- Slash Command Options --
---------------------------

local function getProfileOption(info)
	return profileDB[info.arg]
end

local function setProfileOptionAndClearCache(info, value)
	profileDB[info.arg] = value
	if info.uiType == "cmd" then
		RatingBuster:Print(L["|cffffff7f%s|r is now set to |cffffff7f[%s]|r"]:format(info.option.name, tostring(value)))
	end
	clearCache()
end

local function getGem(info)
	return profileDB[info.arg].gemLink
end

local function setGem(info, value)
	local key = info.arg
	if value == "" then
		profileDB[key].itemID = nil
		profileDB[key].gemID = nil
		profileDB[key].gemName = nil
		profileDB[key].gemLink = nil
		profileDB[key].gemText = nil
		clearCache()
		return
	end
	local gemID, gemText = StatLogic:GetGemID(value)
	if gemID and gemText then
		local name, link = GetItemInfo(value)
		local itemID = link:match("item:(%d+)")
		profileDB[key].itemID = itemID
		profileDB[key].gemID = gemID
		profileDB[key].gemName = name
		profileDB[key].gemLink = link
		-- Trim spaces
		gemText = strtrim(gemText)
		-- Strip color codes
		if strsub(gemText, -2) == "|r" then
			gemText = strsub(gemText, 1, -3)
		end
		if strfind(strsub(gemText, 1, 10), "|c%x%x%x%x%x%x%x%x") then
			gemText = strsub(gemText, 11)
		end
		profileDB[key].gemText = gemText
		clearCache()
		-- Is option set by AceConfigCmd or AceConfigDialog?
		--if not debugstack():find("AceConfigCmd") then
			RatingBuster:Print(L["|cffffff7f%s|r is now set to |cffffff7f[%s]|r"]:format(info.option.name, link))
		--end
	elseif gemID == false then -- invalid input
		RatingBuster:Print(L["Invalid input: %s. ItemID or ItemLink required."]:format(value))
	else -- query sent
		RatingBuster:Print(L["Queried server for Gem: %s. Try again in 5 secs."]:format(value))
	end
end

local selectedGemSet = 1

local options = {
	type = 'group',
	get = getProfileOption,
	set = setProfileOptionAndClearCache,
	args = {
		general = {
			type = 'group',
			name = L["General Settings"],
			cmdInline = true,
			order = -1,
			args = {
				win = {
					type = "execute",
					name = L["Options Window"],
					desc = L["Shows the Options Window"],
					func = function()
						RatingBuster:ShowConfig()
					end,
					guiHidden = true,
				},
				standby = {
					type = 'toggle',
					order = 1,
					width = "double",
					name = L["Enabled"],
					desc = L["Suspend/resume this addon"],
					get = function() return RatingBuster:IsEnabled() end,
					set = function()
						if RatingBuster:IsEnabled() then
							RatingBuster:Disable()
						else
							RatingBuster:Enable()
						end
					end,
				},
				hidebzcomp = {
					type = 'toggle',
					order = 2,
					width = "double",
					name = L["Hide Blizzard Item Comparisons"],
					desc = L["Disable Blizzard stat change summary when using the built-in comparison tooltip"],
					arg = "hideBlizzardComparisons",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				statmod = {
					type = 'toggle',
					order = 3,
					width = "double",
					name = L["Enable Stat Mods"],
					desc = L["Enable support for Stat Mods"],
					arg = "enableStatMods",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				subtract_equip = {
					type = 'toggle',
					order = 4,
					width = "double",
					name = L["Enable Subtract Equipped Stats"],
					desc = L["Enable for more accurate calculation of Mana Regen from Intellect and Spirit, and diminishing stats like Dodge, Parry, Resilience"],
					arg = "enableSubtractEquippedStats",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				enable_reforge_ui = {
					type = 'toggle',
					order = 5,
					width = "double",
					name = L["Enable integration with Blizzard Reforging UI"],
					desc = L["Add rating information to the Blizzard Reforging UI"],
					arg = "enableReforgeUi",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				usereqlv = {
					type = 'toggle',
					order = 7,
					width = "double",
					name = L["Use Required Level"],
					desc = L["Calculate using the required level if you are below the required level"],
					arg = "useRequiredLevel",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				level = {
					type = 'range',
					order = 8,
					width = "double",
					name = L["Set Level"],
					desc = L["Set the level used in calculations (0 = your level)"],
					arg = "customLevel",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
					min = 0,
					max = MAX_PLAYER_LEVEL_TABLE[#MAX_PLAYER_LEVEL_TABLE] + 3, -- set to level cap + 3
					step = 1,
				},
        ilvlid = {
					type = 'group',
					order = 10,
					dialogInline = true,
					name = L["Item Level and ID"],
					desc = L["Settings for Item Level and Item ID"],
					args = {
            coloritemlevel = {
              type = 'toggle',
              order = 1,
              width = "single",
              name = L["Colorize Item Level"],
              desc = L["Customize the color of the Item Level text"],
              arg = "colorizeItemLevel",
              get = getProfileOption,
              set = setProfileOptionAndClearCache,
            },
            itemlevelall = {
              type = 'toggle',
              order = 3,
              width = "double",
              name = L["Show Item Level on all items"],
              desc = L["Display the Item Level on all items instead of just on equippable items"],
              arg = "showAllItemLevel",
              get = getProfileOption,
              set = setProfileOptionAndClearCache,
            },
            itemid = {
              type = 'toggle',
              order = 4,
              width = "single",
              name = L["Show Item ID"],
              desc = L["Display the Item ID on all items"],
              arg = "showItemID",
              get = getProfileOption,
              set = setProfileOptionAndClearCache,
            },
						pick_dialog = {
							type = 'color',
							order = 2,
							cmdHidden = true,
							dropdownHidden = true,
							name = L["Pick Color"],
							desc = L["Pick a color"],
              arg = "itemLevelTextColor",
							get = function(info)
								return profileDB[info.arg].r, profileDB[info.arg].g, profileDB[info.arg].b, 1.0
							end,
							set = function(info, r, g, b, a)
								profileDB[info.arg].r, profileDB[info.arg].g, profileDB[info.arg].b = r, g, b
								profileDB[info.arg].hex = "|cff"..string.format("%02x%02x%02x", profileDB[info.arg].r * 255, profileDB[info.arg].g * 255, profileDB[info.arg].b * 255)
								clearCache()
							end,
						},
						pick = {
							type = 'execute',
							order = 4,
							dialogHidden = true,
							name = L["Pick Color"],
							desc = L["Pick a color"],
              arg = "itemLevelTextColor",
							func = function(info)
								CloseMenus()
								ColorPickerFrame.func = function()
									profileDB[info.arg].r, profileDB[info.arg].g, profileDB[info.arg].b = ColorPickerFrame:GetColorRGB();
									profileDB[info.arg].hex = "|cff"..string.format("%02x%02x%02x", profileDB[info.arg].r * 255, profileDB[info.arg].g * 255, profileDB[info.arg].b * 255)
									--clear cache
									clearCache()
								end
								ColorPickerFrame:SetColorRGB(profileDB[info.arg].r, profileDB[info.arg].g, profileDB[info.arg].b);
								ColorPickerFrame.previousValues = {r = profileDB[info.arg].r, g = profileDB[info.arg].g, b = profileDB[info.arg].b};
								ColorPickerFrame:Show()
							end,
						},
          },
        },
			},
		},
		rating = {
			type = 'group',
			name = L["Rating"],
			desc = L["Options for Rating display"],
			args = {
				show = {
					type = 'select',
					order = 1,
					name = L["Show Rating Conversions"],
					desc = L["Select when to show rating conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."],
					values = {
						[0] = L["Always"],
						[1] = L["ALT Key"],
						[2] = L["CTRL Key"],
						[3] = L["SHIFT Key"],
						[4] = L["Never"],
					},
					arg = "showRatings",
				},
				spell = {
					type = 'toggle',
					order = 2,
					width = "full",
					name = L["Show Spell Hit/Haste"],
					desc = L["Show Spell Hit/Haste from Hit/Haste Rating"],
					arg = "ratingSpell",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				physical = {
					type = 'toggle',
					order = 3,
					width = "full",
					name = L["Show Physical Hit/Haste"],
					desc = L["Show Physical Hit/Haste from Hit/Haste Rating"],
					arg = "ratingPhysical",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				detail = {
					type = 'toggle',
					order = 4,
					width = "full",
					name = L["Show Detailed Conversions Text"],
					desc = L["Show detailed text for Resilience and Expertise conversions"],
					arg = "detailedConversionText",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				exp = {
					type = 'toggle',
					order = 7,
					width = "full",
					name = L["Expertise Breakdown"],
					desc = L["Convert Expertise into Dodge Neglect and Parry Neglect"],
					arg = "expBreakDown",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				color = {
					type = 'group',
					order = 8,
					name = L["Change Text Color"],
					desc = L["Changes the color of added text"],
					guiInline = true,
					args = {
						enable = {
							type = 'toggle',
							order = 1,
							name = L["Enable Color"],
							desc = L["Enable colored text"],
							arg = "enableTextColor",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						pick_dialog = {
							type = 'color',
							order = 2,
							cmdHidden = true,
							dropdownHidden = true,
							name = L["Pick Color"],
							desc = L["Pick a color"],
							get = function()
								return profileDB.textColor.r, profileDB.textColor.g, profileDB.textColor.b, 1.0
							end,
							set = function(info, r, g, b, a)
								profileDB.textColor.r, profileDB.textColor.g, profileDB.textColor.b = r, g, b
								profileDB.textColor.hex = "|cff"..string.format("%02x%02x%02x", profileDB.textColor.r * 255, profileDB.textColor.g * 255, profileDB.textColor.b * 255)
								clearCache()
							end,
						},
						pick = {
							type = 'execute',
							order = 2,
							dialogHidden = true,
							name = L["Pick Color"],
							desc = L["Pick a color"],
							func = function()
								CloseMenus()
								ColorPickerFrame.func = function()
									profileDB.textColor.r, profileDB.textColor.g, profileDB.textColor.b = ColorPickerFrame:GetColorRGB();
									profileDB.textColor.hex = "|cff"..string.format("%02x%02x%02x", profileDB.textColor.r * 255, profileDB.textColor.g * 255, profileDB.textColor.b * 255)
									--clear cache
									clearCache()
								end
								ColorPickerFrame:SetColorRGB(profileDB.textColor.r, profileDB.textColor.g, profileDB.textColor.b);
								ColorPickerFrame.previousValues = {r = profileDB.textColor.r, g = profileDB.textColor.g, b = profileDB.textColor.b};
								ColorPickerFrame:Show()
							end,
						},
					},
				},
			},
		},
		stat = {
			type = 'group',
			name = L["Stat Breakdown"],
			desc = L["Changes the display of base stats"],
			args = {
				show = {
					type = 'select',
					order = 1,
					name = L["Show Base Stat Conversions"],
					desc = L["Select when to show base stat conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."],
					values = {
						[0] = L["Always"],
						[1] = L["ALT Key"],
						[2] = L["CTRL Key"],
						[3] = L["SHIFT Key"],
						[4] = L["Never"],
					},
					arg = "showStats",
				},
				str = {
					type = 'group',
					order = 2,
					name = L["Strength"],
					desc = L["Changes the display of Strength"],
					args = {
						ap = {
							type = 'toggle',
							width = "full",
							name = L["Show Attack Power"],
							desc = L["Show Attack Power from Strength"],
							arg = "showAPFromStr",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				agi = {
					type = 'group',
					order = 3,
					name = L["Agility"],
					desc = L["Changes the display of Agility"],
					args = {
						crit = {
							type = 'toggle',
							width = "full",
							name = L["Show Crit"],
							desc = L["Show Crit chance from Agility"],
							arg = "showCritFromAgi",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						dodge = {
							type = 'toggle',
							width = "full",
							name = L["Show Dodge"],
							desc = L["Show Dodge chance from Agility"],
							arg = "showDodgeFromAgi",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						ap = {
							type = 'toggle',
							width = "full",
							name = L["Show Attack Power"],
							desc = L["Show Attack Power from Agility"],
							arg = "showAPFromAgi",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						rap = {
							type = 'toggle',
							width = "full",
							name = L["Show Ranged Attack Power"],
							desc = L["Show Ranged Attack Power from Agility"],
							arg = "showRAPFromAgi",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				sta = {
					type = 'group',
					order = 4,
					name = L["Stamina"],
					desc = L["Changes the display of Stamina"],
					args = {
						hp = {
							type = 'toggle',
							width = "full",
							name = L["Show Health"],
							desc = L["Show Health from Stamina"],
							arg = "showHealthFromSta",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				int = {
					type = 'group',
					order = 5,
					name = L["Intellect"],
					desc = L["Changes the display of Intellect"],
					args = {
						dmg = {
              type = 'toggle',
              width = "full",
              name = L["Show Spell Damage"],
              desc = L["Show Spell Damage from Intellect"],
              arg = "showSpellPwrFromInt",
              get = getProfileOption,
              set = setProfileOptionAndClearCache,
						},
						spellcrit = {
							type = 'toggle',
							width = "full",
							name = L["Show Spell Crit"],
							desc = L["Show Spell Crit chance from Intellect"],
							arg = "showSpellCritFromInt",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				spi = {
					type = 'group',
					order = 6,
					name = L["Spirit"],
					desc = L["Changes the display of Spirit"],
					args = {
						mp5oc = {
							type = 'toggle',
							width = "full",
							name = L["Show Normal Mana Regen"],
							desc = L["Show Mana Regen while not in combat from Spirit"],
							arg = "showMP5OCFromSpi",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
			},
		},
		sum = {
			type = 'group',
			childGroups = "tab",
			name = L["Stat Summary"],
			desc = L["Options for stat summary"],
			args = {
				show = {
					type = 'select',
					order = 1,
					name = L["Show Stat Summary"],
					desc = L["Select when to show stat summary in tooltips. Modifier keys needs to be pressed before showing the tooltips."],
					values = {
						[0] = L["Always"],
						[1] = L["ALT Key"],
						[2] = L["CTRL Key"],
						[3] = L["SHIFT Key"],
						[4] = L["Never"],
					},
					arg = "showSum",
				},
				diffstyle = {
					type = 'select',
					order = 2,
					name = L["Display Style For Diff Value"],
					desc = L["Display diff values in the main tooltip or only in compare tooltips"],
					values = {comp = "comp", main = "main"},
					arg = "sumDiffStyle",
				},
				ignore = {
					type = 'group',
					order = 3,
					dialogInline = true,
					name = L["Ignore Settings"],
					desc = L["Ignore stuff when calculating the stat summary"],
					args = {
						unused = {
							type = 'toggle',
							order = 1,
							width = "double",
							name = L["Ignore Undesirable Items"],
							desc = L["Hide stat summary for undesirable items"],
							arg = "sumIgnoreUnused",
						},
						quality = {
							type = 'select',
							order = 2,
							name = L["Minimum Item Quality"],
							desc = L["Show stat summary only for selected quality items and up"],
							values = {
								[0] = "|cff9d9d9d"..ITEM_QUALITY0_DESC.."|r",
								[1] = "|cffffffff"..ITEM_QUALITY1_DESC.."|r",
								[2] = "|cff1eff00"..ITEM_QUALITY2_DESC.."|r",
								[3] = "|cff0070dd"..ITEM_QUALITY3_DESC.."|r",
								[4] = "|cffa335ee"..ITEM_QUALITY4_DESC.."|r",
							},
							arg = "sumMinQuality",
							disabled = function() return not profileDB.sumIgnoreUnused end,
						},
						armor = {
							type = 'group',
							order = 3,
							dialogInline = true,
							name = L["Armor Types"],
							desc = L["Select armor types you want to ignore"],
							disabled = function() return not profileDB.sumIgnoreUnused end,
							args = {
								cloth = {
									type = 'toggle',
									order = 1,
									name = L["Ignore Cloth"],
									desc = L["Hide stat summary for all cloth armor"],
									arg = "sumIgnoreCloth",
								},
								leather = {
									type = 'toggle',
									order = 2,
									name = L["Ignore Leather"],
									desc = L["Hide stat summary for all leather armor"],
									arg = "sumIgnoreLeather",
								},
								mail = {
									type = 'toggle',
									order = 3,
									name = L["Ignore Mail"],
									desc = L["Hide stat summary for all mail armor"],
									arg = "sumIgnoreMail",
								},
								plate = {
									type = 'toggle',
									order = 4,
									name = L["Ignore Plate"],
									desc = L["Hide stat summary for all plate armor"],
									arg = "sumIgnorePlate",
								},
							},
						},
						equipped = {
							type = 'toggle',
							order = 5,
							width = "double",
							name = L["Ignore Equipped Items"],
							desc = L["Hide stat summary for equipped items"],
							arg = "sumIgnoreEquipped",
						},
						enchant = {
							type = 'toggle',
							order = 10,
							width = "double",
							name = L["Ignore Enchants"],
							desc = L["Ignore enchants on items when calculating the stat summary"],
							arg = "sumIgnoreEnchant",
						},
						prismaticSocket = {
							type = 'toggle',
							order = 11,
							width = "double",
							name = L["Ignore Prismatic Sockets"],
							desc = L["Ignore gems in prismatic sockets when calculating the stat summary"],
							arg = "sumIgnorePris",
						},
						gem = {
							type = 'toggle',
							order = 15,
							width = "double",
							name = L["Ignore Gems"],
							desc = L["Ignore gems on items when calculating the stat summary"],
							arg = "sumIgnoreGems",
						},
					},
				},
				space = {
					type = 'group',
					order = 4,
					dialogInline = true,
					name = L["Add Empty Line"],
					desc = L["Add a empty line before or after stat summary"],
					args = {
						before = {
							type = 'toggle',
							name = L["Add Before Summary"],
							desc = L["Add a empty line before stat summary"],
							arg = "sumBlankLine",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						after = {
							type = 'toggle',
							name = L["Add After Summary"],
							desc = L["Add a empty line after stat summary"],
							arg = "sumBlankLineAfter",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				icon = {
					type = 'toggle',
					order = 5,
					name = L["Show Icon"],
					desc = L["Show the sigma icon before summary listing"],
					arg = "sumShowIcon",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				title = {
					type = 'toggle',
					order = 6,
					name = L["Show Title Text"],
					desc = L["Show the title text before summary listing"],
					arg = "sumShowTitle",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				showzerostat = {
					type = 'toggle',
					order = 7,
					width = "double",
					name = L["Show Zero Value Stats"],
					desc = L["Show zero value stats in summary for consistancy"],
					arg = "showZeroValueStat",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				calcsum = {
					type = 'toggle',
					order = 8,
					name = L["Calculate Stat Sum"],
					desc = L["Calculate the total stats for the item"],
					arg = "calcSum",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				calcdiff = {
					type = 'toggle',
					order = 9,
					name = L["Calculate Stat Diff"],
					desc = L["Calculate the stat difference for the item and equipped items"],
					arg = "calcDiff",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				sort = {
					type = 'toggle',
					name = L["Sort StatSummary Alphabetically"],
					order = 10,
					width = "double",
					desc = L["Enable to sort StatSummary alphabetically, disable to sort according to stat type(basic, physical, spell, tank)"],
					arg = "sumSortAlpha",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				avoidhasblock = {
					type = 'toggle',
					order = 11,
					width = "full",
					name = L["Include Block Chance In Avoidance Summary"],
					desc = L["Enable to include block chance in Avoidance summary, Disable for only dodge, parry, miss"],
					arg = "sumAvoidWithBlock",
					get = getProfileOption,
					set = setProfileOptionAndClearCache,
				},
				basic = {
					type = 'group',
					dialogInline = true,
					name = L["Stat - Basic"],
					desc = L["Choose basic stats for summary"],
					args = {
						hp = {
							type = 'toggle',
							name = L["Sum Health"],
							desc = L["Health <- Health, Stamina"],
							arg = "sumHP",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						mp5 = {
							type = 'toggle',
							name = L["Sum Combat Mana Regen"],
							desc = L["Combat Mana Regen <- Mana Regen, Spirit"],
							arg = "sumMP5",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						mp5oc = {
							type = 'toggle',
							name = L["Sum Normal Mana Regen"],
							desc = L["Normal Mana Regen <- Spirit"],
							arg = "sumMP5OC",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						hp5 = {
							type = 'toggle',
							name = L["Sum Combat Health Regen"],
							desc = L["Combat Health Regen <- Health Regen"],
							arg = "sumHP5",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						str = {
							type = 'toggle',
							name = L["Sum Strength"],
							desc = L["Strength Summary"],
							arg = "sumStr",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						agi = {
							type = 'toggle',
							name = L["Sum Agility"],
							desc = L["Agility Summary"],
							arg = "sumAgi",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						sta = {
							type = 'toggle',
							name = L["Sum Stamina"],
							desc = L["Stamina Summary"],
							arg = "sumSta",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						int = {
							type = 'toggle',
							name = L["Sum Intellect"],
							desc = L["Intellect Summary"],
							arg = "sumInt",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						spi = {
							type = 'toggle',
							name = L["Sum Spirit"],
							desc = L["Spirit Summary"],
							arg = "sumSpi",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						mastery = {
							type = 'toggle',
							name = L["Sum Mastery"],
							desc = L["Mastery Summary"],
							arg = "sumMastery",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						masteryrating = {
							type = 'toggle',
							name = L["Sum Mastery Rating"],
							desc = L["Mastery Rating Summary"],
							arg = "sumMasteryRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				physical = {
					type = 'group',
					dialogInline = true,
					name = L["Stat - Physical"],
					desc = L["Choose physical damage stats for summary"],
					args = {
						ap = {
							type = 'toggle',
							name = L["Sum Attack Power"],
							desc = L["Attack Power <- Attack Power, Strength, Agility"],
							arg = "sumAP",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						rap = {
							type = 'toggle',
							name = L["Sum Ranged Attack Power"],
							desc = L["Ranged Attack Power <- Ranged Attack Power, Intellect, Attack Power, Strength, Agility"],
							arg = "sumRAP",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						hit = {
							type = 'toggle',
							name = L["Sum Hit Chance"],
							desc = L["Hit Chance <- Hit Rating"],
							arg = "sumHit",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						hitrating = {
							type = 'toggle',
							name = L["Sum Hit Rating"],
							desc = L["Hit Rating Summary"],
							arg = "sumHitRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						rangedhit = {
							type = 'toggle',
							name = L["Sum Ranged Hit Chance"],
							desc = L["Ranged Hit Chance <- Hit Rating, Ranged Hit Rating"],
							arg = "sumRangedHit",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						rangedhitrating = {
							type = 'toggle',
							name = L["Sum Ranged Hit Rating"],
							desc = L["Ranged Hit Rating Summary"],
							arg = "sumRangedHitRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						crit = {
							type = 'toggle',
							name = L["Sum Crit Chance"],
							desc = L["Crit Chance <- Crit Rating, Agility"],
							arg = "sumCrit",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						critrating = {
							type = 'toggle',
							name = L["Sum Crit Rating"],
							desc = L["Crit Rating Summary"],
							arg = "sumCritRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						rangedcrit = {
							type = 'toggle',
							name = L["Sum Ranged Crit Chance"],
							desc = L["Ranged Crit Chance <- Crit Rating, Agility, Ranged Crit Rating"],
							arg = "sumRangedCrit",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						rangedcritrating = {
							type = 'toggle',
							name = L["Sum Ranged Crit Rating"],
							desc = L["Ranged Crit Rating Summary"],
							arg = "sumRangedCritRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						haste = {
							type = 'toggle',
							name = L["Sum Haste"],
							desc = L["Haste <- Haste Rating"],
							arg = "sumHaste",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						hasterating = {
							type = 'toggle',
							name = L["Sum Haste Rating"],
							desc = L["Haste Rating Summary"],
							arg = "sumHasteRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						rangedhaste = {
							type = 'toggle',
							name = L["Sum Ranged Haste"],
							desc = L["Ranged Haste <- Haste Rating, Ranged Haste Rating"],
							arg = "sumRangedHaste",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						rangedhasterating = {
							type = 'toggle',
							name = L["Sum Ranged Haste Rating"],
							desc = L["Ranged Haste Rating Summary"],
							arg = "sumRangedHasteRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						neglectdodge = {
							type = 'toggle',
							name = L["Sum Dodge Neglect"],
							desc = L["Dodge Neglect <- Expertise"],
							arg = "sumDodgeNeglect",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						neglectparry = {
							type = 'toggle',
							name = L["Sum Parry Neglect"],
							desc = L["Parry Neglect <- Expertise"],
							arg = "sumParryNeglect",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						exp = {
							type = 'toggle',
							name = L["Sum Expertise"],
							desc = L["Expertise <- Expertise Rating"],
							arg = "sumExpertise",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						exprating = {
							type = 'toggle',
							name = L["Sum Expertise Rating"],
							desc = L["Expertise Rating Summary"],
							arg = "sumExpertiseRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						maxdamage = {
							type = 'toggle',
							name = L["Sum Weapon Max Damage"],
							desc = L["Weapon Max Damage Summary"],
							arg = "sumWeaponMaxDamage",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				spell = {
					type = 'group',
					dialogInline = true,
					name = L["Stat - Spell"],
					desc = L["Choose spell damage and healing stats for summary"],
					args = {
						power = {
							type = 'toggle',
							name = L["Sum Spell Power"],
							desc = L["Spell Power <- Spell Power, Intellect, Agility, Strength"],
							arg = "sumSpellPower",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						hit = {
							type = 'toggle',
							name = L["Sum Spell Hit Chance"],
							desc = L["Spell Hit Chance <- Spell Hit Rating"],
							arg = "sumSpellHit",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						hitrating = {
							type = 'toggle',
							name = L["Sum Spell Hit Rating"],
							desc = L["Spell Hit Rating Summary"],
							arg = "sumSpellHitRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						crit = {
							type = 'toggle',
							name = L["Sum Spell Crit Chance"],
							desc = L["Spell Crit Chance <- Spell Crit Rating, Intellect"],
							arg = "sumSpellCrit",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						critrating = {
							type = 'toggle',
							name = L["Sum Spell Crit Rating"],
							desc = L["Spell Crit Rating Summary"],
							arg = "sumSpellCritRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						haste = {
							type = 'toggle',
							name = L["Sum Spell Haste"],
							desc = L["Spell Haste <- Spell Haste Rating"],
							arg = "sumSpellHaste",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						hasterating = {
							type = 'toggle',
							name = L["Sum Spell Haste Rating"],
							desc = L["Spell Haste Rating Summary"],
							arg = "sumSpellHasteRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						pen = {
							type = 'toggle',
							name = L["Sum Penetration"],
							desc = L["Spell Penetration Summary"],
							arg = "sumPenetration",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				tank = {
					type = 'group',
					dialogInline = true,
					name = L["Stat - Tank"],
					desc = L["Choose tank stats for summary"],
					args = {
						armor = {
							type = 'toggle',
							name = L["Sum Armor"],
							desc = L["Armor <- Armor from items and bonuses"],
							arg = "sumArmor",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						dodge = {
							type = 'toggle',
							name = L["Sum Dodge Chance"],
							desc = L["Dodge Chance <- Dodge Rating, Agility"],
							arg = "sumDodge",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						dodgerating = {
							type = 'toggle',
							name = L["Sum Dodge Rating"],
							desc = L["Dodge Rating Summary"],
							arg = "sumDodgeRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						parry = {
							type = 'toggle',
							name = L["Sum Parry Chance"],
							desc = L["Parry Chance <- Parry Rating"],
							arg = "sumParry",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						parryrating = {
							type = 'toggle',
							name = L["Sum Parry Rating"],
							desc = L["Parry Rating Summary"],
							arg = "sumParryRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						block = {
							type = 'toggle',
							name = L["Sum Block Chance"],
							desc = L["Block Chance <- Block Rating"],
							arg = "sumBlock",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						blockrating = {
							type = 'toggle',
							name = L["Sum Block Rating"],
							desc = L["Block Rating Summary"],
							arg = "sumBlockRating",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						res = {
							type = 'toggle',
							name = L["Sum Resilience"],
							desc = L["Resilience Summary"],
							arg = "sumResilience",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						resarcane = {
							type = 'toggle',
							name = L["Sum Arcane Resistance"],
							desc = L["Arcane Resistance Summary"],
							arg = "sumArcaneResist",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						resfire = {
							type = 'toggle',
							name = L["Sum Fire Resistance"],
							desc = L["Fire Resistance Summary"],
							arg = "sumFireResist",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						resnature = {
							type = 'toggle',
							name = L["Sum Nature Resistance"],
							desc = L["Nature Resistance Summary"],
							arg = "sumNatureResist",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						resfrost = {
							type = 'toggle',
							name = L["Sum Frost Resistance"],
							desc = L["Frost Resistance Summary"],
							arg = "sumFrostResist",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						resshadow = {
							type = 'toggle',
							name = L["Sum Shadow Resistance"],
							desc = L["Shadow Resistance Summary"],
							arg = "sumShadowResist",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
						avoid = {
							type = 'toggle',
							name = L["Sum Avoidance"],
							desc = L["Avoidance <- Dodge, Parry, MobMiss, Block(Optional)"],
							arg = "sumAvoidance",
							get = getProfileOption,
							set = setProfileOptionAndClearCache,
						},
					},
				},
				gemset = {
					type = 'select',
					order = 12,
					cmdHidden = true,
					name = L["Gem Set"],
					desc = L["Select a gem set to configure"],
					values = {
						[1] = L["Default Gem Set 1"],
						[2] = L["Default Gem Set 2"],
						[3] = L["Default Gem Set 3"],
					},
					arg = "selectedGemSet",
					get = function() return selectedGemSet end,
					set = function(info, value) selectedGemSet = value end,
				},
				gem = {
					type = 'group',
					order = 13,
					dialogInline = true,
					hidden = function() return selectedGemSet ~= 1 end,
					name = L["Default Gem Set 1"],
					desc = L["Auto fill empty gem slots"],
					args = {
						red = {
							type = 'input',
							order = 1,
							width = "double",
							name = L["Red Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemRed",
							get = getGem,
							set = setGem,
						},
						yellow = {
							type = 'input',
							order = 2,
							width = "double",
							name = L["Yellow Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemYellow",
							get = getGem,
							set = setGem,
						},
						blue = {
							type = 'input',
							order = 3,
							width = "double",
							name = L["Blue Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemBlue",
							get = getGem,
							set = setGem,
						},
						meta = {
							type = 'input',
							order = 4,
							width = "double",
							name = L["Meta Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemMeta",
							get = getGem,
							set = setGem,
						},
					},
				},
				gem2 = {
					type = 'group',
					order = 14,
					dialogInline = true,
					hidden = function() return selectedGemSet ~= 2 end,
					name = L["Default Gem Set 2"],
					desc = L["Second set of default gems which can be toggled with a modifier key"],
					args = {
						key = {
							type = 'select',
							order = 0,
							name = L["Toggle Key"],
							desc = L["Use this key to toggle alternate gems"],
							values = {
								[1] = L["ALT Key"],
								[2] = L["CTRL Key"],
								[3] = L["SHIFT Key"],
								[4] = L["Never"],
							},
							arg = "sumGem2Toggle",
							get = function() return profileDB.sumGem2Toggle end,
							set = function(info, value)
								if value ~= 4 and value == profileDB.sumGem3Toggle then
									AceConfigRegistry:NotifyChange("RatingBuster")
									RatingBuster:Print(L["Can't use the same modifier as Gem Set 3"])
								else
									profileDB.sumGem2Toggle = value
								end
							end,
						},
						red = {
							type = 'input',
							order = 1,
							width = "double",
							name = L["Red Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemRed2",
							get = getGem,
							set = setGem,
							disabled = function() return profileDB.sumGem2Toggle == 4 end,
						},
						yellow = {
							type = 'input',
							order = 2,
							width = "double",
							name = L["Yellow Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemYellow2",
							get = getGem,
							set = setGem,
							disabled = function() return profileDB.sumGem2Toggle == 4 end,
						},
						blue = {
							type = 'input',
							order = 3,
							width = "double",
							name = L["Blue Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemBlue2",
							get = getGem,
							set = setGem,
							disabled = function() return profileDB.sumGem2Toggle == 4 end,
						},
						meta = {
							type = 'input',
							order = 4,
							width = "double",
							name = L["Meta Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemMeta2",
							get = getGem,
							set = setGem,
							disabled = function() return profileDB.sumGem2Toggle == 4 end,
						},
					},
				},
				gem3 = {
					type = 'group',
					order = 15,
					dialogInline = true,
					hidden = function() return selectedGemSet ~= 3 end,
					name = L["Default Gem Set 3"],
					desc = L["Third set of default gems which can be toggled with a modifier key"],
					args = {
						key = {
							type = 'select',
							order = 0,
							name = L["Toggle Key"],
							desc = L["Use this key to toggle alternate gems"],
							values = {
								[1] = L["ALT Key"],
								[2] = L["CTRL Key"],
								[3] = L["SHIFT Key"],
								[4] = L["Never"],
							},
							arg = "sumGem3Toggle",
							get = function() return profileDB.sumGem3Toggle end,
							set = function(info, value)
								if value ~= 4 and value == profileDB.sumGem2Toggle then
									AceConfigRegistry:NotifyChange("RatingBuster")
									RatingBuster:Print(L["Can't use the same modifier as Gem Set 2"])
								else
									profileDB.sumGem3Toggle = value
								end
							end,
						},
						red = {
							type = 'input',
							order = 1,
							width = "double",
							name = L["Red Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemRed3",
							get = getGem,
							set = setGem,
							disabled = function() return profileDB.sumGem3Toggle == 4 end,
						},
						yellow = {
							type = 'input',
							order = 2,
							width = "double",
							name = L["Yellow Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemYellow3",
							get = getGem,
							set = setGem,
							disabled = function() return profileDB.sumGem3Toggle == 4 end,
						},
						blue = {
							type = 'input',
							order = 3,
							width = "double",
							name = L["Blue Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemBlue3",
							get = getGem,
							set = setGem,
							disabled = function() return profileDB.sumGem3Toggle == 4 end,
						},
						meta = {
							type = 'input',
							order = 4,
							width = "double",
							name = L["Meta Socket"],
							desc = L["ItemID or Link of the gem you would like to auto fill"],
							usage = L["<ItemID|Link>"],
							arg = "sumGemMeta3",
							get = getGem,
							set = setGem,
							disabled = function() return profileDB.sumGem3Toggle == 4 end,
						},
					},
				},
			},
		},
	},
}

-- TankPoints support, version check
local tpSupport
local tpLocale
if TankPoints and (tonumber(strsub(TankPoints.version, 1, 3)) >= 2.9) then
	tpSupport = true
	tpLocale = LibStub("AceLocale-3.0"):GetLocale("TankPoints") --Get the localization from TankPoints
	
	options.args.sum.args.tank.args.tp = {
		type = 'toggle',
		name = L["Sum TankPoints"],
		desc = L["TankPoints <- Health, Total Reduction"],
		arg = "sumTankPoints",
		get = getProfileOption,
		set = setProfileOptionAndClearCache,
	}
	options.args.sum.args.tank.args.tr = {
		type = 'toggle',
		name = L["Sum Total Reduction"],
		desc = L["Total Reduction <- Armor, Dodge, Parry, Block, MobMiss, MobCrit, MobCrush, DamageTakenMods"],
		arg = "sumTotalReduction",
		get = getProfileOption,
		set = setProfileOptionAndClearCache,
	}
	--[[
	options.args.sum.args.tank.args.avoid = {
		type = 'toggle',
		name = L["Sum Avoidance"],
		desc = L["Avoidance <- Dodge, Parry, MobMiss"],
		arg = "sumAvoidance",
		get = getProfileOption,
		set = setProfileOptionAndClearCache,
	}
	--]]
end


-- Class specific options
-- Get StatModTable
local ClassStatModTable = StatLogic.StatModTable[class]
-- tooltip to scan buff desc
local tip = CreateFrame("GameTooltip", "RatingBusterTooltip", nil, "GameTooltipTemplate")
tip:SetOwner(WorldFrame, "ANCHOR_NONE")
for i = 1, 5 do
  tip[i] = _G["RatingBusterTooltipTextLeft"..i]
  if not tip[i] then
    tip[i] = tip:CreateFontString()
    tip:AddFontStrings(tip[i], tip:CreateFontString())
    _G["RatingBusterTooltipTextLeft"..i] = tip[i]
  end
end
local function GetStatModNameDiscList(statmod, nameList, discList)
  local r, g, b, name, _, icon, spellid
  if ClassStatModTable[statmod] then
    for _, entry in pairs(ClassStatModTable[statmod]) do
      -- version checks
      spellid = entry.spellid or entry.known or entry.buff
      if spellid and entry.newtoc and toc < entry.newtoc then spellid = nil end
      if spellid and entry.oldtoc and toc >= entry.oldtoc then spellid = nil end
      if spellid and entry.new and wowBuildNo < entry.new then spellid = nil end
      if spellid and entry.old and wowBuildNo >= entry.old then spellid = nil end
      if spellid then
        name, _, icon = GetSpellInfo(spellid)
        --print(name or 'nil', icon or 'nil')
        if name and icon then
          if not nameList then
            nameList = "|T"..icon..":25:25:-2:0|t"..name
          else
            nameList = nameList..", |T"..icon..":25:25:-2:0|t"..name
          end
          tip:ClearLines()
          tip:AddSpellByID(spellid)
          --print(tip[1]:GetText() or 'nil')
          for i = 2, 5 do
            r, g, b = tip[i]:GetTextColor()
            --print(r or 'nil', g or 'nil', b or 'nil', tip[i]:GetText() or 'nil')
            if b < 0.2 then
              if not discList then
                discList = "|T"..icon..":25:25:-2:0|t"..name.."\n|cffffcc02"..tip[i]:GetText().."|r"
              else
                discList = discList.."\n\n|T"..icon..":25:25:-2:0|t"..name.."\n|cffffcc02"..tip[i]:GetText().."|r"
              end
              break
            end
          end
        end
      end
    end
  end
  if StatLogic.StatModTable["ALL"][statmod] then
    for _, entry in pairs(StatLogic.StatModTable["ALL"][statmod]) do
      -- version checks
      spellid = entry.spellid or entry.known or entry.buff
      if spellid and entry.newtoc and toc < entry.newtoc then spellid = nil end
      if spellid and entry.oldtoc and toc >= entry.oldtoc then spellid = nil end
      if spellid and entry.new and wowBuildNo < entry.new then spellid = nil end
      if spellid and entry.old and wowBuildNo >= entry.old then spellid = nil end
      if spellid then
        name, _, icon = GetSpellInfo(spellid)
        --print(name or 'nil', icon or 'nil')
        if name and icon then
          if not nameList then
            nameList = "|T"..icon..":25:25:-2:0|t"..name
          else
            nameList = nameList..", |T"..icon..":25:25:-2:0|t"..name
          end
          tip:ClearLines()
          tip:AddSpellByID(spellid)
          for i = 2, 5 do
            r, g, b = tip[i]:GetTextColor()
            if b < 0.2 then
              if not discList then
                discList = "|T"..icon..":25:25:-2:0|t"..name.."\n|cffffcc02"..tip[i]:GetText().."|r"
              else
                discList = discList.."\n\n|T"..icon..":25:25:-2:0|t"..name.."\n|cffffcc02"..tip[i]:GetText().."|r"
              end
              break
            end
          end
        end
      end
    end
  end
  --print(nameList or 'nil', discList or 'nil')
  return nameList, discList
end

local function SetupCustomOptions()
  if ClassStatModTable then
    if ((StatLogic:GetAPPerAgi(class) > 1) and ClassStatModTable["ADD_SPELL_DMG_MOD_AP"]) or ClassStatModTable["ADD_SPELL_DMG_MOD_AGI"] then
      local nameList, discList = GetStatModNameDiscList("ADD_SPELL_DMG_MOD_AGI")
      if StatLogic:GetAPPerAgi(class) > 1 then
        nameList, discList = GetStatModNameDiscList("ADD_SPELL_DMG_MOD_AP", nameList, discList)
      end
      if nameList and discList then
        options.args.stat.args.agi.args.dmg = {
          type = 'toggle',
          width = "full",
          name = L["Show Spell Damage"].." - "..nameList,
          desc = L["Show Spell Damage from Agility"]..":\n\n"..discList,
          arg = "showSpellPwrFromAgi",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
      end
    end
    if ((StatLogic:GetAPPerAgi(class) > 1) and ClassStatModTable["ADD_HEAL_MOD_AP"]) or ClassStatModTable["ADD_HEAL_MOD_AGI"] then
      local nameList, discList = GetStatModNameDiscList("ADD_HEAL_MOD_AGI")
      if StatLogic:GetAPPerAgi(class) > 1 then
        nameList, discList = GetStatModNameDiscList("ADD_HEAL_MOD_AP", nameList, discList)
      end
      if nameList and discList then
        options.args.stat.args.agi.args.heal = {
          type = 'toggle',
          width = "full",
          name = L["Show Spell Damage"].." - "..nameList,
          desc = L["Show Spell Damage from Agility"]..":\n\n"..discList,
          arg = "showHealingFromAgi",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
      end
    end
    if ClassStatModTable["ADD_SPELL_DMG_MOD_AP"] or ClassStatModTable["ADD_SPELL_DMG_MOD_STR"] then
      local nameList, discList = GetStatModNameDiscList("ADD_SPELL_DMG_MOD_AP")
      nameList, discList = GetStatModNameDiscList("ADD_SPELL_DMG_MOD_STR", nameList, discList)
      if nameList and discList then
        options.args.stat.args.str.args.dmg = {
          type = 'toggle',
          width = "full",
          name = L["Show Spell Damage"].." - "..nameList,
          desc = L["Show Spell Damage from Strength"]..":\n\n"..discList,
          arg = "showSpellPwrFromStr",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
      end
    end
    if ClassStatModTable["ADD_HEAL_MOD_AP"] or ClassStatModTable["ADD_HEAL_MOD_STR"] then
      local nameList, discList = GetStatModNameDiscList("ADD_HEAL_MOD_AP")
      nameList, discList = GetStatModNameDiscList("ADD_HEAL_MOD_STR", nameList, discList)
      if nameList and discList then
        options.args.stat.args.str.args.heal = {
          type = 'toggle',
          width = "full",
          name = L["Show Healing"].." - "..nameList,
          desc = L["Show Healing from Strength"]..":\n\n"..discList,
          arg = "showHealingFromStr",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
      end
    end
    if ClassStatModTable["ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN"] then
      local nameList, discList = GetStatModNameDiscList("ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN")
      if nameList and discList then
        options.args.stat.args.spi.args.mp5 = {
          type = 'toggle',
          width = "full",
          name = L["Show Combat Mana Regen"].." - "..nameList,
          desc = L["Show Mana Regen while in combat from Spirit"]..":\n\n"..discList,
          arg = "showMP5FromSpi",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
      end
    end
    if ClassStatModTable["ADD_SPELL_HIT_RATING_MOD_SPI"] then
      local nameList, discList = GetStatModNameDiscList("ADD_SPELL_HIT_RATING_MOD_SPI")
      if nameList and discList then
        options.args.stat.args.spi.args.spellhitrating = {
          type = 'toggle',
          width = "full",
          name = L["Show Spell Hit Rating"].." - "..nameList,
          desc = L["Show Spell Hit Rating from Spirit"]..":\n\n"..discList,
          arg = "showSpellHitRatingFromSpi",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
        options.args.stat.args.spi.args.spellhit = {
          type = 'toggle',
          width = "full",
          name = L["Show Spell Hit"].." - "..nameList,
          desc = L["Show Spell Hit from Spirit"]..":\n\n"..discList,
          arg = "showSpellHitFromSpi",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
      end
    end
    if ClassStatModTable["ADD_PARRY_MOD_STR"] then
      local nameList, discList = GetStatModNameDiscList("ADD_PARRY_MOD_STR")
      if nameList and discList then
        options.args.stat.args.str.args.parryrating = {
          type = 'toggle',
          width = "full",
          name = L["Show Parry Rating"].." - "..nameList,
          desc = L["Show Parry Rating from Strength"]..":\n\n"..discList,
          arg = "showParryRatingFromStr",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
        options.args.stat.args.str.args.parry = {
          type = 'toggle',
          width = "full",
          name = L["Show Parry"].." - "..nameList,
          desc = L["Show Parry from Strength"]..":\n\n"..discList,
          arg = "showParryFromStr",
          get = getProfileOption,
          set = setProfileOptionAndClearCache,
        }
      end
    end
    if ClassStatModTable["ADD_AP_MOD_ARMOR"] then
      local nameList, discList = GetStatModNameDiscList("ADD_AP_MOD_ARMOR")
      if nameList and discList then
        options.args.stat.args.armor = { -- Bladed Armor (Rank 5) - 1,4
          type = 'group',
          order = 7,
          name = L["Armor"],
          desc = L["Changes the display of Armor"],
          args = {
            ap = {
              type = 'toggle',
              width = "full",
              name = L["Show Attack Power"].." - "..nameList,
              desc = L["Show Attack Power from Armor"]..":\n\n"..discList,
              arg = "showAPFromArmor",
              get = getProfileOption,
              set = setProfileOptionAndClearCache,
            },
          },
        }
      end
    end
  end
end

function RatingBuster:SetupOptions()
  -- Setup custom class options
  SetupCustomOptions()
  
	-- Inject profile options
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profile.order = -2
	
	-- Add dual-spec support
	local LibDualSpec = LibStub("LibDualSpec-1.0", true)
	if LibDualSpec then
		LibDualSpec:EnhanceDatabase(self.db, "RatingBuster")
		LibDualSpec:EnhanceOptions(options.args.profile, self.db)
	end
	
	-- Register options table
	AceConfig:RegisterOptionsTable("RatingBuster", options, {"rb", "rabu", "ratingbuster"})
	
	-- Setup Blizzard option frames
	self.optionsFrames = {}
	-- The ordering here matters, it determines the order in the Blizzard Interface Options
	self.optionsFrames.general = AceConfigDialog:AddToBlizOptions("RatingBuster", nil, nil, "general")
	self.optionsFrames.rating = AceConfigDialog:AddToBlizOptions("RatingBuster", L["Rating"], "RatingBuster", "rating")
	self.optionsFrames.stat = AceConfigDialog:AddToBlizOptions("RatingBuster", L["Stat Breakdown"], "RatingBuster", "stat")
	self.optionsFrames.sum = AceConfigDialog:AddToBlizOptions("RatingBuster", L["Stat Summary"], "RatingBuster", "sum")
	self.optionsFrames.profile = AceConfigDialog:AddToBlizOptions("RatingBuster", L["Profiles"], "RatingBuster", "profile")
	--self.optionsFrames.help = AceConfigDialog:AddToBlizOptions("RatingBuster", L["Help File"], "RatingBuster", "Help")
end

function RatingBuster:ShowConfig()
	-- Open the profiles tab before, so the menu expands
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.profile)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.general)
end

-----------
-- Tools --
-----------
-- copyTable
local function copyTable(to, from)
	if to then
		for k in pairs(to) do
			to[k] = nil
		end
		setmetatable(to, nil)
	else
		to = {}
	end
	for k,v in pairs(from) do
		if type(k) == "table" then
			k = copyTable({}, k)
		end
		if type(v) == "table" then
			v = copyTable({}, v)
		end
		to[k] = v
	end
	setmetatable(to, getmetatable(from))
	return to
end

------------------------------------
-- Hide Blizzard Item Comparisons --
------------------------------------
local function HookSetHyperlinkCompareItem(shoppingtip)
	local old = shoppingtip.SetHyperlinkCompareItem
	shoppingtip.SetHyperlinkCompareItem = function(self, link, level, shift, main, ...)
		if profileDB.hideBlizzardComparisons then
			main = nil
		end
		return old(self, link, level, shift, main, ...)
	end
end

---------
-- API --
---------
function RatingBuster:GetStatMod(stat, school, talentGroup)
  return StatLogic:GetStatMod(stat, school, talentGroup)
end
function RatingBuster:ClearCache()
  clearCache()
end

---------------------
-- Initializations --
---------------------
--[[ Loading Process Event Reference
{
ADDON_LOADED - When this addon is loaded
VARIABLES_LOADED - When all addons are loaded
PLAYER_LOGIN - Most information about the game world should now be available to the UI
}
--]]

function RatingBuster:OnProfileChanged(event, database, newProfileKey)
	-- this is called every time our profile changes (after the change)
  --print("OnProfileChanged")
	profileDB = database.profile
	clearCache()
end

function RatingBuster:OnProfileReset(event, database, newProfileKey)
	-- this is called every time our profile changes (after the change)
  --print("OnProfileReset")
  for k, v in pairs(classDefaults) do
    database.profile[k] = v
  end
	profileDB = database.profile
	clearCache()
end

function RatingBuster:OnNewProfile(event, database, newProfileKey)
	-- this is called every time our profile changes (after the change)
	--print("OnNewProfile")
  for k, v in pairs(classDefaults) do
    database.profile[k] = v
  end
	--clearCache()
end

-- OnInitialize(name) called at ADDON_LOADED
function RatingBuster:OnInitialize()
	-- Create DB
	self.db = AceDB:New("RatingBusterDB", defaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileReset")
	self.db.RegisterCallback(self, "OnNewProfile", "OnNewProfile")
	
	profileDB = self.db.profile
  
  if not profileDB.profileVersion or profileDB.profileVersion ~= ProfileVersion then
    for k, v in pairs(classDefaults) do
      profileDB[k] = v
    end
    profileDB.profileVersion = ProfileVersion
  end

	-- Hook ShoppingTooltips to enable options to Hide Blizzard Item Comparisons
	HookSetHyperlinkCompareItem(ShoppingTooltip1)
	HookSetHyperlinkCompareItem(ShoppingTooltip2)
	HookSetHyperlinkCompareItem(ShoppingTooltip3)
	HookSetHyperlinkCompareItem(ItemRefShoppingTooltip1)
	HookSetHyperlinkCompareItem(ItemRefShoppingTooltip2)
	HookSetHyperlinkCompareItem(ItemRefShoppingTooltip3)
  
	self:SetupOptions()
end

-- OnEnable() called at PLAYER_LOGIN
function RatingBuster:OnEnable()
	-- Hook item tooltips
	TipHooker:Hook(self.ProcessTooltip, "item")
	-- Initialize playerLevel
	playerLevel = UnitLevel("player")
	-- for setting a new level
	self:RegisterEvent("PLAYER_LEVEL_UP")
	-- Events that require cache clearing
	self:RegisterEvent("CHARACTER_POINTS_CHANGED", clearCache) -- talent point changed
	self:RegisterEvent("MODIFIER_STATE_CHANGED") -- modifier key press
	self:RegisterEvent("UNIT_AURA") -- fire at most once every 1 second
	self:RegisterEvent("ADDON_LOADED") -- Watch for Blizzard_ReforgingUI
end

function RatingBuster:OnDisable()
	-- Unhook item tooltips
	TipHooker:Unhook(self.ProcessTooltip, "item")
end

-- event = PLAYER_LEVEL_UP
-- arg1 = New player level
function RatingBuster:PLAYER_LEVEL_UP(event, newlevel)
	playerLevel = newlevel
	clearCache()
end

-- event = UNIT_AURA
-- arg1 = the UnitID of the entity
function RatingBuster:UNIT_AURA(event, unit)
	if unit ~= "player" then return end
	clearCache()
end
--local tooltips = {}
function RatingBuster:MODIFIER_STATE_CHANGED(event, key, state)
	-- self:Print("MODIFIER_STATE_CHANGED")
	-- for tooltip, link in pairs(tooltips) do
		-- if tooltip:IsShown() and not strfind(tooltip:GetName(), "ompar") and not strfind(tooltip:GetName(), "Shopping") then
			-- tooltip:ClearLines()
			-- ShowUIPanel(tooltip)
			-- tooltip:SetHyperlink(link)
		-- end
	-- end
	clearCache()
end

------------------
-- Reforging UI --
------------------
function RatingBuster:ADDON_LOADED(event, name)
	if name ~= "Blizzard_ReforgingUI" then return end
	--print("Blizzard_ReforgingUI Loaded")
  local reforgeToRating = {
    [13] = CR_DODGE, -- Dodge Rating
    [14] = CR_PARRY, -- Parry Rating
    [31] = CR_HIT_MELEE, -- Hit Rating
    [32] = CR_CRIT_MELEE, -- Critical Strike Rating
    [36] = CR_HASTE_MELEE, -- Haste Rating
    [37] = CR_EXPERTISE, -- Expertise Rating
    [49] = CR_MASTERY, -- Mastery Rating
  }
  
  local function FormatReforgeRating(value, stat)
    local ratingId = reforgeToRating[stat]
    if ratingId then
      local effect = StatLogic:GetEffectFromRating(value, ratingId, calcLevel)
      if ratingId == CR_HIT_MELEE or ratingId == CR_HASTE_MELEE then
        if profileDB.ratingPhysical and profileDB.ratingSpell then
          -- stat.id + 2 = SpellID
          local effectSpell = StatLogic:GetEffectFromRating(value, ratingId + 2, calcLevel)
          if effectSpell == effect then
            value = format("%d(%+.2f%%) ", value, effect)
          else
            value = format("%d(%+.2f%%, %+.2f%%)", value, effect, effectSpell)
          end
        elseif profileDB.ratingPhysical then
          value = format("%d(%+.2f%%) ", value, effect)
        elseif profileDB.ratingSpell then
          local effectSpell = StatLogic:GetEffectFromRating(value, ratingId + 2, calcLevel)
          value = format("%d(%+.2f%%) ", value, effectSpell)
        end
      else
        value = format("%d(%+.2f%%) ", value, effect)
      end
    else
      value = format("%d ", value)
    end
    return value
  end
  
  function ReforgeFrame_Update_OldStat()
	local stats = {GetReforgeItemStats()}
	local index = 1
	local statFrame
	
	for i = 1, #stats, 3 do
		statFrame = ReforgingFrame_GetStatRow(index, false);
		local name, stat, value, curValue = statFrame.info[1], statFrame.info[2], statFrame.info[3], statFrame.info[4]
		if statFrame:GetChecked() then
			statFrame.Text:SetFormattedText("%s+%s|r %s", RED_FONT_COLOR_CODE, FormatReforgeRating(curValue - value, stat), name)
		else
			statFrame.Text:SetFormattedText("+%s %s", FormatReforgeRating(curValue, stat), name)
		end
		index = index + 1
	end
  end
  
  function ReforgeFrame_Update_NewStat()
    if not ReforgingFrame.srcStat and not ReforgingFrame.srcValue then
		return
	end
	
	local stat, value = ReforgingFrame.srcStat, ReforgingFrame.srcValue
	local stats = {GetDestinationReforgeStats(stat, value)}
	
	local index = 1
	local statFrame
	
	for i = 1, #stats, 4 do
		_, statFrame = ReforgingFrame_GetStatRow(index, false)
		local name, stat, value, reforgeID = statFrame.info[1], statFrame.info[2], statFrame.info[3], statFrame.info[4]
		if statFrame:GetChecked() then
			statFrame.Text:SetFormattedText("%s+%s|r %s", GREEN_FONT_COLOR_CODE, FormatReforgeRating(value, stat), name)
		else
			statFrame.Text:SetFormattedText("+%s %s", FormatReforgeRating(value, stat), name)
		end
		index = index + 1
	end
  end
  
  -- Now for reforged items, hook ReforgingFrame_Update
  function ReforgingFrame_Update_Hook()
    if not profileDB.enableReforgeUi then
		return
	end
  
    local curReforge, icon, name = GetReforgeItemInfo()
	
	if icon then
		if curReforge == 0 then
			ReforgeFrame_Update_OldStat()
			ReforgeFrame_Update_NewStat()
		else
			local stats = {GetReforgeItemStats()}
			local bonusStat = (#stats/3) + 1
			local leftStat, rightStat
			local index = 1
			
			for i = 1, #stats, 3 do
				leftStat, rightStat = ReforgingFrame_GetStatRow(index, false)
				local name, stat, value = stats[i], stats[i + 1], stats[i + 2]
				if stat == ReforgingFrame.srcStat then
					rightStat.Text:SetFormattedText("%s+%s|r %s", GREEN_FONT_COLOR_CODE, FormatReforgeRating(value, stat), name)
					leftStat.Text:SetFormattedText("%s+%s|r %s", RED_FONT_COLOR_CODE, FormatReforgeRating(value - ReforgingFrame.srcValue, stat), name)
				else
					rightStat.Text:SetFormattedText("+%s %s", FormatReforgeRating(value, stat), name)
					leftStat.Text:SetFormattedText("+%s %s",FormatReforgeRating(value, stat),name)
				end
				index = index  +1
			end
			leftStat = ReforgingFrame_GetStatRow(bonusStat, false)
			if leftStat then
				leftStat.Text:SetFormattedText("%s+%s|r %s", GREEN_FONT_COLOR_CODE, FormatReforgeRating(ReforgingFrame.destValue, ReforgingFrame.destStat), ReforgingFrame.destName)
			end
		end
	end
  end
  hooksecurefunc("ReforgingFrame_Update", ReforgingFrame_Update_Hook)
end
--------------------------
-- Process Tooltip Core --
--------------------------
--[[
"+15 Agility"
-> "+15 Agility (+0.46% Crit)"
"+15 Crit Rating"
-> "+15 Crit Rating (+1.20%)"
"Equip: Increases your hit rating by 10."
-> "Equip: Increases your hit rating by 10 (+1.20%)."
--]]
-- Empty Sockets
local EMPTY_SOCKET_RED = EMPTY_SOCKET_RED
local EMPTY_SOCKET_YELLOW = EMPTY_SOCKET_YELLOW
local EMPTY_SOCKET_BLUE = EMPTY_SOCKET_BLUE
local EMPTY_SOCKET_META = EMPTY_SOCKET_META
local EmptySocketLookup = {
	[EMPTY_SOCKET_RED] = "sumGemRed", -- EMPTY_SOCKET_RED = "Red Socket";
	[EMPTY_SOCKET_YELLOW] = "sumGemYellow", -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
	[EMPTY_SOCKET_BLUE] = "sumGemBlue", -- EMPTY_SOCKET_BLUE = "Blue Socket";
	[EMPTY_SOCKET_META] = "sumGemMeta", -- EMPTY_SOCKET_META = "Meta Socket";
}
-- Color code (used to fix gem text color)
local currentColorCode

-- Avoidance DR calculation
local summaryFunc = {}
local equippedSum = {}
local equippedDodge, equippedParry, equippedMissed
local processedDodge, processedParry, processedMissed, processedInt, processedSpi, processedRes

-- Modifier Keys
local isModifierKeyDown = {
	[0] = function() return true end,
	[1] = IsAltKeyDown,
	[2] = IsControlKeyDown,
	[3] = IsShiftKeyDown,
}

function RatingBuster.ProcessTooltip(tooltip, name, link, ...)
	-- Check if we're in standby mode
	if not RatingBuster:IsEnabled() then return end
	--tooltips[tooltip] = link
	---------------------------
	-- Set calculation level --
	---------------------------
	calcLevel = profileDB.customLevel or 0
	if calcLevel == 0 then
		calcLevel = playerLevel
	end
	if profileDB.useRequiredLevel and link then
		local _, _, _, _, reqLevel = GetItemInfo(link)
		--RatingBuster:Print(link..", "..calcLevel)
		if reqLevel and calcLevel < reqLevel then
			calcLevel = reqLevel
		end
	end
	---------------------
	-- Tooltip Scanner --
	---------------------
	-- Get equipped item avoidances
	if profileDB.enableSubtractEquippedStats then
		local red, yellow, blue, meta
		if isModifierKeyDown[profileDB.sumGem2Toggle] and isModifierKeyDown[profileDB.sumGem2Toggle]() then
			red = profileDB.sumGemRed2.gemID
			yellow = profileDB.sumGemYellow2.gemID
			blue = profileDB.sumGemBlue2.gemID
			meta = profileDB.sumGemMeta2.gemID
		elseif isModifierKeyDown[profileDB.sumGem3Toggle] and isModifierKeyDown[profileDB.sumGem3Toggle]() then
			red = profileDB.sumGemRed3.gemID
			yellow = profileDB.sumGemYellow3.gemID
			blue = profileDB.sumGemBlue3.gemID
			meta = profileDB.sumGemMeta3.gemID
		else
			red = profileDB.sumGemRed.gemID
			yellow = profileDB.sumGemYellow.gemID
			blue = profileDB.sumGemBlue.gemID
			meta = profileDB.sumGemMeta.gemID
		end
		local _, mainlink, difflink1, difflink2 = StatLogic:GetDiffID(tooltip, profileDB.sumIgnoreEnchant, profileDB.sumIgnoreGems, red, yellow, blue, meta, profileDB.sumIgnorePris)
		StatLogic:GetSum(difflink1, equippedSum)
		equippedSum["STR"] = (equippedSum["STR"] or 0) * RatingBuster:GetStatMod("MOD_STR")
		equippedSum["AGI"] = (equippedSum["AGI"] or 0) * RatingBuster:GetStatMod("MOD_AGI")
		equippedSum["INT"] = (equippedSum["INT"] or 0) * RatingBuster:GetStatMod("MOD_INT")
		equippedSum["SPI"] = (equippedSum["SPI"] or 0) * RatingBuster:GetStatMod("MOD_SPI")
		equippedDodge = summaryFunc["DODGE_NO_DR"](equippedSum, "sum", difflink1) * -1
		equippedParry = summaryFunc["PARRY_NO_DR"](equippedSum, "sum", difflink1) * -1
		equippedMissed = summaryFunc["MELEE_HIT_AVOID_NO_DR"](equippedSum, "sum", difflink1) * -1
		processedDodge = equippedDodge
		processedParry = equippedParry
		processedMissed = equippedMissed
    processedInt = equippedSum["INT"] * -1
    processedSpi = equippedSum["SPI"] * -1
    processedRes = (equippedSum["RESILIENCE_RATING"] or 0) * -1
	else
		equippedDodge = 0
		equippedParry = 0
		equippedMissed = 0
		processedDodge = 0
		processedParry = 0
		processedMissed = 0
    processedRes = 0
	end
	
	if isModifierKeyDown[profileDB.sumGem2Toggle] and isModifierKeyDown[profileDB.sumGem2Toggle]() then
		EmptySocketLookup[EMPTY_SOCKET_RED] = "sumGemRed2"
		EmptySocketLookup[EMPTY_SOCKET_YELLOW] = "sumGemYellow2"
		EmptySocketLookup[EMPTY_SOCKET_BLUE] = "sumGemBlue2"
		EmptySocketLookup[EMPTY_SOCKET_META] = "sumGemMeta2"
	elseif isModifierKeyDown[profileDB.sumGem3Toggle] and isModifierKeyDown[profileDB.sumGem3Toggle]() then
		EmptySocketLookup[EMPTY_SOCKET_RED] = "sumGemRed3"
		EmptySocketLookup[EMPTY_SOCKET_YELLOW] = "sumGemYellow3"
		EmptySocketLookup[EMPTY_SOCKET_BLUE] = "sumGemBlue3"
		EmptySocketLookup[EMPTY_SOCKET_META] = "sumGemMeta3"
	else
		EmptySocketLookup[EMPTY_SOCKET_RED] = "sumGemRed"
		EmptySocketLookup[EMPTY_SOCKET_YELLOW] = "sumGemYellow"
		EmptySocketLookup[EMPTY_SOCKET_BLUE] = "sumGemBlue"
		EmptySocketLookup[EMPTY_SOCKET_META] = "sumGemMeta"
	end
  
	-- Loop through tooltip lines starting at line 2
  local itemLevelSet
	local tipTextLeft = tooltip:GetName().."TextLeft"
	for i = 2, tooltip:NumLines() do
		local fontString = _G[tipTextLeft..i]
		local text = fontString:GetText()
		if text then
			-- Get data from cache if available
			local cacheID = text..calcLevel
			local cacheText = cache[cacheID]
			if cacheText then
				if cacheText ~= text then
					fontString:SetText(cacheText)
				end
			elseif EmptySocketLookup[text] and profileDB[EmptySocketLookup[text]].gemText then -- Replace empty sockets with gem text
				text = profileDB[EmptySocketLookup[text]].gemText
				cache[cacheID] = text
				-- SetText
				fontString:SetText(text)
      elseif (profileDB.colorizeItemLevel or profileDB.showItemID) and link and strfind(text, ITEM_LEVEL) then
        if cache[link] then
          fontString:SetText(cache[link])
        else
          -- Get the Item ID from text string
          local _, _, level = strfind(text, "(%d+)")
          local newLine = L["ItemLevel: "]..level
          if profileDB.showItemID then
            local _, _, id = strfind(link, "item:(%d+)")
            if id then
              newLine = newLine..", "..L["ItemID: "]..id
            end
          end
          if profileDB.colorizeItemLevel then
            newLine = profileDB.itemLevelTextColor.hex..newLine.."|r"
          end
          cache[link] = newLine
          fontString:SetText(newLine)
        end
        itemLevelSet = true
			elseif strfind(text, "%d") then -- do nothing if we don't find a number
				-- Find and set color code (used to fix gem text color) pattern:|cxxxxxxxx
				currentColorCode = select(3, strfind(text, "(|c%x%x%x%x%x%x%x%x)")) or "|r"
				-- Initial pattern check, do nothing if not found
				-- Check for separators and bulid separatorTable
				local separatorTable = {}
				for _, sep in ipairs(L["separators"]) do
					if strfind(text, sep) then
						tinsert(separatorTable, sep)
					end
				end
				-- SplitDoJoin
				text = RatingBuster:SplitDoJoin(text, separatorTable, tooltip)
				cache[cacheID] = text
				-- SetText
				fontString:SetText(text)
			end
		end
	end
	----------------------------
	-- Item Level and Item ID --
	----------------------------
	if not itemLevelSet and (profileDB.showAllItemLevel or profileDB.showItemID) and link then
		if cache[link] then
			tooltip:AddLine(cache[link])
		else
			-- Get the Item ID from the link string
			local _, link, _, level = GetItemInfo(link)
			if link then
				local _, _, id = strfind(link, "item:(%d+)")
				local newLine = ""
				if level and profileDB.showAllItemLevel then
					newLine = newLine..L["ItemLevel: "]..level
				end
				if id and profileDB.showItemID then
					if newLine ~= "" then
						newLine = newLine..", "
					end
					newLine = newLine..L["ItemID: "]..id
				end
				if newLine ~= "" then
          if profileDB.colorizeItemLevel then
            newLine = profileDB.itemLevelTextColor.hex..newLine.."|r"
          end
					cache[link] = newLine
					tooltip:AddLine(newLine)
				end
			end
		end
	end
	------------------
	-- Stat Summary --
	------------------
	--[[
	----------------
	-- Base Stats --
	----------------
	-- Health - HEALTH, STA
	-- Mana - MANA
	-- Attack Power - AP, STR, AGI
	-- Ranged Attack Power - RANGED_AP, INT, AP, STR, AGI
	-- Spell Damage - SPELL_DMG, STA, INT, SPI
	-- Holy Damage - HOLY_SPELL_DMG, SPELL_DMG, INT, SPI
	-- Arcane Damage - ARCANE_SPELL_DMG, SPELL_DMG, INT
	-- Fire Damage - FIRE_SPELL_DMG, SPELL_DMG, STA, INT
	-- Nature Damage - NATURE_SPELL_DMG, SPELL_DMG, INT
	-- Frost Damage - FROST_SPELL_DMG, SPELL_DMG, INT
	-- Shadow Damage - SHADOW_SPELL_DMG, SPELL_DMG, STA, INT, SPI
	-- Healing - HEAL, STR, INT, SPI
	-- Hit Chance - MELEE_HIT_RATING, WEAPON_RATING
	-- Crit Chance - MELEE_CRIT_RATING, WEAPON_RATING, AGI
	-- Spell Hit Chance - SPELL_HIT_RATING
	-- Spell Crit Chance - SPELL_CRIT_RATING, INT
	-- Mana Regen - MANA_REG, SPI
	-- Health Regen - HEALTH_REG
	-- Mana Regen Not Casting - SPI
	-- Health Regen While Casting - SPI
	-- Armor - ARMOR, ARMOR_BONUS, AGI, INT
	-- Block Value - BLOCK_VALUE, STR
	-- Dodge Chance - DODGE_RATING, DEFENSE_RATING, AGI
	-- Parry Chance - PARRY_RATING, DEFENSE_RATING
	-- Block Chance - BLOCK_RATING, DEFENSE_RATING
	-- Hit Avoidance - DEFENSE_RATING, MELEE_HIT_AVOID_RATING
	-- Crit Avoidance - DEFENSE_RATING, RESILIENCE_RATING, MELEE_CRIT_AVOID_RATING
	-- Dodge Neglect - EXPERTISE_RATING, WEAPON_RATING
	-- Parry Neglect - EXPERTISE_RATING, WEAPON_RATING
	-- Block Neglect - WEAPON_RATING
	---------------------
	-- Composite Stats --
	---------------------
	-- Strength - STR
	-- Agility - AGI
	-- Stamina - STA
	-- Intellect - INT
	-- Spirit - SPI
	-- Defense - DEFENSE_RATING
	-- Weapon Skill - WEAPON_RATING
	-- Expertise - EXPERTISE_RATING
	--]]
	if isModifierKeyDown[profileDB.showSum] and isModifierKeyDown[profileDB.showSum]() then
		RatingBuster:StatSummary(tooltip, name, link, ...)
	end
	---------------------
	-- Repaint tooltip --
	---------------------
	tooltip:Show()
	for i = 2, tooltip:NumLines() do
		local fontString = _G[tipTextLeft..i]
		local _, relativeTo, _, xOfs, _ = fontString:GetPoint(0)
		fontString:ClearAllPoints()
		fontString:SetPoint("TOPLEFT", relativeTo, "BOTTOMLEFT", xOfs, -2)
	end
end

---------------------------------------------------------------------------------
-- Recursive algorithm that divides a string into pieces using the separators in separatorTable,
-- processes them separately, then joins them back together
---------------------------------------------------------------------------------
-- text = "+24 Agility/+4 Stamina and +4 Spell Crit/+5 Spirit"
-- separatorTable = {"/", " and ", ","}
-- RatingBuster:SplitDoJoin("+24 Agility/+4 Stamina, +4 Dodge and +4 Spell Crit/+5 Spirit", {"/", " and ", ",", "%. ", " for ", "&"})
-- RatingBuster:SplitDoJoin("+6法術傷害及5耐力", {"/", "和", ",", "。", " 持續 ", "&", "及",})
function RatingBuster:SplitDoJoin(text, separatorTable, tooltip)
	if type(separatorTable) == "table" and table.maxn(separatorTable) > 0 then
		local sep = tremove(separatorTable, 1)
		text =  gsub(text, sep, "@")
		text = {strsplit("@", text)}
		local processedText = {}
		local tempTable = {}
		for _, t in ipairs(text) do
			--self:Print(t[1])
			copyTable(tempTable, separatorTable)
			tinsert(processedText, self:SplitDoJoin(t, tempTable, tooltip))
		end
		-- Join text
		return (gsub(strjoin("@", unpack(processedText)), "@", sep))
	else
		--self:Print(cacheID)
		return self:ProcessText(text, tooltip)
	end
end



function RatingBuster:ProcessText(text, tooltip)
	--self:Print(text)
	-- Check if test has a matching pattern
	for _, num in ipairs(L["numberPatterns"]) do
		-- Convert text to lower so we don't have to worry about same ratings with different cases
		local lowerText = string.lower(text)

		local stripedText = string.gsub(lowerText,"[%,%.%%]?","") --Removes thousands seperator (.or ,) from the values
--print(stripedText)
		-- Capture the stat value
		local s, e, value, partialtext = strfind(stripedText, num.pattern)
		
		if value  and partialtext then
--print(value.."/"..partialtext)
		end
		if value then
			-- Check and switch captures if needed
			if partialtext and tonumber(partialtext) then
				value, partialtext = partialtext, value
			end
			-- Capture the stat name
			for _, stat in ipairs(L["statList"]) do
--print("//"..partialtext.."="..stat.pattern.."/")
				if (not partialtext and strfind(lowerText, stat.pattern)) or (partialtext and strfind(partialtext, stat.pattern)) then
					value = tonumber(value)
					local infoString = ""
					if type(stat.id) == "number" and stat.id >= 1 and stat.id <= 26 and isModifierKeyDown[profileDB.showRatings] and isModifierKeyDown[profileDB.showRatings]() then
						--------------------
						-- Combat Ratings --
						--------------------
						-- Calculate stat value
						local effect, strID = StatLogic:GetEffectFromRating(value, stat.id, calcLevel)
						--self:Print(reversedAmount..", "..amount..", "..v[2]..", "..RatingBuster.targetLevel)-- debug
						-- If rating is resilience, add a minus sign
						-- (d0.12%, p0.12%, b0.12%, m0.12%, c-0.12%)
						if strID == "DODGE" and profileDB.enableSubtractEquippedStats then
							infoString = format("%+.2f%%", StatLogic:GetAvoidanceGainAfterDR("DODGE", processedDodge + effect) - StatLogic:GetAvoidanceGainAfterDR("DODGE", processedDodge))
							processedDodge = processedDodge + effect
						elseif strID == "PARRY" and profileDB.enableSubtractEquippedStats then
							infoString = format("%+.2f%%", StatLogic:GetAvoidanceGainAfterDR("PARRY", processedParry + effect) - StatLogic:GetAvoidanceGainAfterDR("PARRY", processedParry))
							processedParry = processedParry + effect
						elseif strID == "EXPERTISE" and profileDB.expBreakDown then
							effect = effect * -0.25
							if profileDB.detailedConversionText then
								infoString = gsub(L["$value to be Dodged/Parried"], "$value", format("%+.2f%%%%", effect))
							else
								infoString = format("%+.2f%%", effect)
							end
						elseif strID == "MASTERY" or "EXPERTISE" then
	
								infoString = format("%+.2f%%", effect)
	
						elseif stat.id >= 15 and stat.id <= 17 then -- Resilience
              if profileDB.enableSubtractEquippedStats then
                effect = StatLogic:GetResilienceEffectGainAfterDR(processedRes + value, processedRes)
                --print(type(processedRes)..", "..processedRes..", "..processedRes + value..", "..effect)
                processedRes = processedRes + value
              end
							if profileDB.detailedConversionText then
								infoString = gsub(L["$value PVP Dmg Taken"], "$value", format("%+.2f%%%%", effect * -1))
							else
								infoString = format("%+.2f%%", -effect)
							end
						-- CR_HIT_MELEE = 6
						-- CR_CRIT_MELEE = 9
						-- CR_HASTE_MELEE = 18
						-- Crit and Haste conversions are the same for melee and haste, only hit is different
						elseif stat.id == 6 then
							if profileDB.ratingPhysical and profileDB.ratingSpell then
								-- stat.id + 2 = SpellID
								local effectSpell = StatLogic:GetEffectFromRating(value, stat.id + 2, calcLevel)
								infoString = format("%+.2f%%, ", effect)..gsub(L["$value Spell"], "$value", format("%+.2f%%%%", effectSpell))
							elseif profileDB.ratingPhysical then
								infoString = format("%+.2f%%", effect)
							elseif profileDB.ratingSpell then
								local effectSpell = StatLogic:GetEffectFromRating(value, stat.id + 2, calcLevel)
								infoString = format("%+.2f%%", effectSpell)
							end
            -- CR_HASTE_MELEE = 18
            -- shamans7, paladins2, druids10, and death knights6 now receive 30% more melee haste from Haste Rating. 
						elseif stat.id == 18 then
							if profileDB.ratingPhysical and profileDB.ratingSpell then
								-- stat.id + 2 = SpellID
                effect = effect * RatingBuster:GetStatMod("MOD_MELEE_HASTE")
								local effectSpell = StatLogic:GetEffectFromRating(value, stat.id + 2, calcLevel)
                effectSpell = effectSpell * RatingBuster:GetStatMod("MOD_SPELL_HASTE")
                if effectSpell == effect then
                  infoString = format("%+.2f%%", effect)
                else
                  infoString = format("%+.2f%%, ", effect)..gsub(L["$value Spell"], "$value", format("%+.2f%%%%", effectSpell))
                end
							elseif profileDB.ratingPhysical then
                effect = effect * RatingBuster:GetStatMod("MOD_MELEE_HASTE")
								infoString = format("%+.2f%%", effect)
							elseif profileDB.ratingSpell then
								local effectSpell = StatLogic:GetEffectFromRating(value, stat.id + 2, calcLevel)
                effectSpell = effectSpell * RatingBuster:GetStatMod("MOD_SPELL_HASTE")
								infoString = format("%+.2f%%", effectSpell)
							end
						else
							--self:Print(text..", "..tostring(effect)..", "..value..", "..stat.id..", "..calcLevel)
							-- Build info string
							infoString = format("%+.2f", effect)
							if (stat.id > 2 and stat.id < 21) or stat.id == 25 then -- if rating is a percentage
								infoString = infoString.."%"
							end
						end
					elseif stat.id == SPELL_STAT1_NAME and isModifierKeyDown[profileDB.showStats] and isModifierKeyDown[profileDB.showStats]() then
						--------------
						-- Strength --
						--------------
						local statmod = 1
						if profileDB.enableStatMods then
							statmod = RatingBuster:GetStatMod("MOD_STR")
							value = value * statmod
						end
						local infoTable = {}
						if profileDB.showAPFromStr then
							local mod = RatingBuster:GetStatMod("MOD_AP")
							local effect = value * StatLogic:GetAPPerStr(class) * mod
							if (mod ~= 1 or statmod ~= 1) and floor(abs(effect) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value AP"], "$value", format("%+.1f", effect))))
							elseif floor(abs(effect) + 0.5) > 0 then -- so we don't get +0 AP when effect < 0.5
								tinsert(infoTable, (gsub(L["$value AP"], "$value", format("%+.0f", effect))))
							end
						end
            if profileDB.showSpellPwrFromStr or profileDB.showHealingFromStr then
							local dmgmod = RatingBuster:GetStatMod("MOD_AP") * RatingBuster:GetStatMod("MOD_SPELL_PWR") * (RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_AP") + RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_STR"))
							local dmg = (value * StatLogic:GetAPPerStr(class) * RatingBuster:GetStatMod("MOD_AP") * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_AP")
								+ value * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_STR")) * RatingBuster:GetStatMod("MOD_SPELL_PWR")
							local healmod = RatingBuster:GetStatMod("MOD_AP") * RatingBuster:GetStatMod("MOD_HEAL") * (RatingBuster:GetStatMod("ADD_HEAL_MOD_AP") + RatingBuster:GetStatMod("ADD_HEAL_MOD_STR"))
							local heal = (value * StatLogic:GetAPPerStr(class) * RatingBuster:GetStatMod("MOD_AP") * RatingBuster:GetStatMod("ADD_HEAL_MOD_AP")
								+ value * RatingBuster:GetStatMod("ADD_HEAL_MOD_STR")) * RatingBuster:GetStatMod("MOD_HEAL")
              if dmg == heal then
                if (dmgmod ~= 1 or statmod ~= 1) and floor(abs(dmg) * 10 + 0.5) > 0 then
                  tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.1f", dmg))))
                elseif floor(abs(dmg) + 0.5) > 0 then
                  tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.0f", dmg))))
                end
              else
                if profileDB.showSpellPwrFromStr then
                  if (dmgmod ~= 1 or statmod ~= 1) and floor(abs(dmg) * 10 + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.1f", dmg))))
                  elseif floor(abs(dmg) + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.0f", dmg))))
                  end
                end
                if profileDB.showHealingFromStr then
                  if (healmod ~= 1 or statmod ~= 1) and floor(abs(heal) * 10 + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Heal"], "$value", format("%+.1f", heal))))
                  elseif floor(abs(heal) + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Heal"], "$value", format("%+.0f", heal))))
                  end
                end
              end
            end
						if profileDB.showParryFromStr and profileDB.showParryRatingFromStr then
							local rating = value * RatingBuster:GetStatMod("ADD_PARRY_MOD_STR")
							local effect = StatLogic:GetEffectFromRating(rating, 4, calcLevel) -- CR_PARRY = 4
							if profileDB.enableSubtractEquippedStats then
								local effectNoDR = effect
								effect = StatLogic:GetAvoidanceGainAfterDR("PARRY", processedParry + effect) - StatLogic:GetAvoidanceGainAfterDR("PARRY", processedParry)
								processedParry = processedParry + effectNoDR
							end
							if floor(abs(rating) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value Parry"], "$value", format("%+.1f(%+.2f%%%%)", rating, effect))))
							end
						elseif profileDB.showParryFromStr then
							local rating = value * RatingBuster:GetStatMod("ADD_PARRY_MOD_STR")
							local effect = StatLogic:GetEffectFromRating(rating, 4, calcLevel) -- CR_PARRY = 4
							if profileDB.enableSubtractEquippedStats then
								local effectNoDR = effect
								effect = StatLogic:GetAvoidanceGainAfterDR("PARRY", processedParry + effect) - StatLogic:GetAvoidanceGainAfterDR("PARRY", processedParry)
								processedParry = processedParry + effectNoDR
							end
							if floor(abs(effect) * 100 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value Parry"], "$value", format("%+.2f%%%%", effect))))
							end
						elseif profileDB.showParryRatingFromStr then
							local rating = value * RatingBuster:GetStatMod("ADD_PARRY_MOD_STR")
							if profileDB.enableSubtractEquippedStats then
								processedParry = processedParry + StatLogic:GetEffectFromRating(rating, 4, calcLevel)
							end
							if floor(abs(rating) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value Parry"], "$value", format("%+.1f", rating))))
							end
						elseif profileDB.enableSubtractEquippedStats and RatingBuster:GetStatMod("ADD_PARRY_MOD_STR") > 0 then
							local rating = value * RatingBuster:GetStatMod("ADD_PARRY_MOD_STR")
							local effect = StatLogic:GetEffectFromRating(rating, 4, calcLevel)
							processedParry = processedParry + effect
						end
						infoString = strjoin(", ", unpack(infoTable))
					elseif stat.id == SPELL_STAT2_NAME and isModifierKeyDown[profileDB.showStats] and isModifierKeyDown[profileDB.showStats]() then
						-------------
						-- Agility --
						-------------
						local statmod = 1
						if profileDB.enableStatMods then
							statmod = RatingBuster:GetStatMod("MOD_AGI")
							value = value * statmod
						end
						local infoTable = {}
						if profileDB.showAPFromAgi then
							local mod = RatingBuster:GetStatMod("MOD_AP")
							local effect = value * StatLogic:GetAPPerAgi(class) * mod
							if (mod ~= 1 or statmod ~= 1) and floor(abs(effect) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value AP"], "$value", format("%+.1f", effect))))
							elseif floor(abs(effect) + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value AP"], "$value", format("%+.0f", effect))))
							end
						end
						if profileDB.showRAPFromAgi then
							local mod = RatingBuster:GetStatMod("MOD_RANGED_AP")
							local effect = value * StatLogic:GetRAPPerAgi(class) * mod
							if (mod ~= 1 or statmod ~= 1) and floor(abs(effect) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value RAP"], "$value", format("%+.1f", effect))))
							elseif floor(abs(effect) + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value RAP"], "$value", format("%+.0f", effect))))
							end
						end
						if profileDB.showCritFromAgi then
							local effect = StatLogic:GetCritFromAgi(value, class, calcLevel)
							if effect > 0 then
								tinsert(infoTable, (gsub(L["$value% Crit"], "$value", format("%+.2f", effect))))
							end
						end
						if profileDB.showDodgeFromAgi and (calcLevel == playerLevel) then
							local effect = StatLogic:GetDodgeFromAgi(value)
							if profileDB.enableSubtractEquippedStats then
								local effectNoDR = effect
								effect = StatLogic:GetAvoidanceGainAfterDR("DODGE", processedDodge + effect) - StatLogic:GetAvoidanceGainAfterDR("DODGE", processedDodge)
								processedDodge = processedDodge + effectNoDR
							end
							if effect > 0 then
								tinsert(infoTable, (gsub(L["$value% Dodge"], "$value", format("%+.2f", effect))))
							end
						else
							local effect = StatLogic:GetDodgeFromAgi(value)
							processedDodge = processedDodge + effect
						end
            if profileDB.showSpellPwrFromAgi or profileDB.showHealingFromAgi then
							local dmgmod = RatingBuster:GetStatMod("MOD_AP") * RatingBuster:GetStatMod("MOD_SPELL_PWR") * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_AP")
							local dmg = value * StatLogic:GetAPPerAgi(class) * dmgmod
							local healmod = RatingBuster:GetStatMod("MOD_AP") * RatingBuster:GetStatMod("MOD_HEAL") * (RatingBuster:GetStatMod("ADD_HEAL_MOD_AP") + RatingBuster:GetStatMod("ADD_HEAL_MOD_AGI"))
							local heal = (value * StatLogic:GetAPPerAgi(class) * RatingBuster:GetStatMod("MOD_AP") * RatingBuster:GetStatMod("ADD_HEAL_MOD_AP")
								+ value * RatingBuster:GetStatMod("ADD_HEAL_MOD_AGI")) * RatingBuster:GetStatMod("MOD_HEAL")
              if dmg == heal then
                if (dmgmod ~= 1 or statmod ~= 1) and floor(abs(dmg) * 10 + 0.5) > 0 then
                  tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.1f", dmg))))
                elseif floor(abs(dmg) + 0.5) > 0 then
                  tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.0f", dmg))))
                end
              else
                if profileDB.showSpellPwrFromAgi then
                  if (dmgmod ~= 1 or statmod ~= 1) and floor(abs(dmg) * 10 + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.1f", dmg))))
                  elseif floor(abs(dmg) + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.0f", dmg))))
                  end
                end
                if profileDB.showHealingFromAgi then
                  if (healmod ~= 1 or statmod ~= 1) and floor(abs(heal) * 10 + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Heal"], "$value", format("%+.1f", heal))))
                  elseif floor(abs(heal) + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Heal"], "$value", format("%+.0f", heal))))
                  end
                end
              end
            end
						infoString = strjoin(", ", unpack(infoTable))
					elseif stat.id == SPELL_STAT3_NAME and isModifierKeyDown[profileDB.showStats] and isModifierKeyDown[profileDB.showStats]() then
						-------------
						-- Stamina --
						-------------
						local statmod = 1
						if profileDB.enableStatMods then
							statmod = RatingBuster:GetStatMod("MOD_STA")
							value = value * statmod
						end
						local infoTable = {}
						if profileDB.showHealthFromSta then
							local mod = RatingBuster:GetStatMod("MOD_HEALTH")
							local effect = StatLogic:GetHealthFromSta(value, calcLevel) * mod -- 10 Health per Sta
							if (mod ~= 1 or statmod ~= 1) and floor(abs(effect) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value HP"], "$value", format("%+.1f", effect))))
							elseif floor(abs(effect) + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value HP"], "$value", format("%+.0f", effect))))
							end
						end
						infoString = strjoin(", ", unpack(infoTable))
					elseif stat.id == SPELL_STAT4_NAME and isModifierKeyDown[profileDB.showStats] and isModifierKeyDown[profileDB.showStats]() then
						---------------
						-- Intellect --
						---------------
						local statmod = 1
						if profileDB.enableStatMods then
							statmod = RatingBuster:GetStatMod("MOD_INT")
							value = value * statmod
						end
						local infoTable = {}
						if profileDB.showSpellCritFromInt then
							local effect = StatLogic:GetSpellCritFromInt(value, class, calcLevel)
							if effect > 0 then
								tinsert(infoTable, (gsub(L["$value% Spell Crit"], "$value", format("%+.2f", effect))))
							end
						end
            if profileDB.showSpellPwrFromInt then
              local dmg = value * RatingBuster:GetStatMod("MOD_SPELL_PWR") * (1 + RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_INT"))
               + value * 15 * RatingBuster:GetStatMod("MOD_MANA") * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_MANA") -- Improved Mana Gem
              local heal = value * RatingBuster:GetStatMod("MOD_HEAL") * (1 + RatingBuster:GetStatMod("ADD_HEAL_MOD_INT"))
               + value * 15 * RatingBuster:GetStatMod("MOD_MANA") * RatingBuster:GetStatMod("ADD_HEAL_MOD_MANA") -- Improved Mana Gem
              if dmg == heal then
                if floor(abs(dmg) * 10 + 0.5) > 0 then
                  tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.1f", dmg))))
                end
              else
                if profileDB.showSpellPwrFromInt then
                  if floor(abs(dmg) * 10 + 0.5) > 0 then
                    tinsert(infoTable, (gsub(L["$value Pwr"], "$value", format("%+.1f", dmg))))
                  end
                end
              end
            end
						infoString = strjoin(", ", unpack(infoTable))
					elseif stat.id == SPELL_STAT5_NAME and isModifierKeyDown[profileDB.showStats] and isModifierKeyDown[profileDB.showStats]() then
						------------
						-- Spirit --
						------------
						local statmod = 1
						if profileDB.enableStatMods then
							statmod = RatingBuster:GetStatMod("MOD_SPI")
							value = value * statmod
						end
						local infoTable = {}
						if profileDB.showMP5FromSpi then
							local _, spi = UnitStat("player", 5)
              if profileDB.enableSubtractEquippedStats then
                spi = spi + processedSpi
                processedSpi = processedSpi + value
              end
							local effect = (StatLogic:GetNormalManaRegenFromSpi(spi + value)
               - StatLogic:GetNormalManaRegenFromSpi(spi))
               * RatingBuster:GetStatMod("ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN")
							if floor(abs(effect) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value MP5"], "$value", format("%+.1f", effect))))
							end
						end
						if profileDB.showMP5OCFromSpi then
							local _, spi = UnitStat("player", 5)
              if profileDB.enableSubtractEquippedStats then
                spi = spi + processedSpi
                processedSpi = processedSpi + value
              end
							local effect = StatLogic:GetNormalManaRegenFromSpi(spi + value)
               - StatLogic:GetNormalManaRegenFromSpi(spi)
							if floor(abs(effect) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value MP5(OC)"], "$value", format("%+.1f", effect))))
							end
						end
						if profileDB.showSpellHitFromSpi and profileDB.showSpellHitRatingFromSpi then
              local mod = RatingBuster:GetStatMod("ADD_SPELL_HIT_RATING_MOD_SPI")
							local rating = value * mod
							local effect = StatLogic:GetEffectFromRating(rating, 8, calcLevel) -- CR_HIT_SPELL = 8
							if (mod ~= 1 or statmod ~= 1) and floor(abs(rating) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value Spell Hit"], "$value", format("%+.1f(%+.2f%%%%)", rating, effect))))
							elseif floor(abs(rating) + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value Spell Hit"], "$value", format("%+.0f(%+.2f%%%%)", rating, effect))))
							end
						elseif profileDB.showSpellHitFromSpi then
							local rating = value * RatingBuster:GetStatMod("ADD_SPELL_HIT_RATING_MOD_SPI")
							local effect = StatLogic:GetEffectFromRating(rating, 8, calcLevel) -- CR_HIT_SPELL = 8
							if floor(abs(effect) * 100 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value Spell Hit"], "$value", format("%+.2f%%%%", effect))))
							end
						elseif profileDB.showSpellHitRatingFromSpi then
              local mod = RatingBuster:GetStatMod("ADD_SPELL_HIT_RATING_MOD_SPI")
							local effect = value * mod
							if (mod ~= 1 or statmod ~= 1) and floor(abs(effect) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value Spell Hit"], "$value", format("%+.1f", effect))))
							elseif floor(abs(effect) + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value Spell Hit"], "$value", format("%+.0f", effect))))
							end
						end
						infoString = strjoin(", ", unpack(infoTable))
					elseif profileDB.showAPFromArmor and stat.id == ARMOR and isModifierKeyDown[profileDB.showStats] and isModifierKeyDown[profileDB.showStats]() then
						-----------
						-- Armor --
						-----------
						local statmod = 1
						if profileDB.enableStatMods then
							local finalArmor = StatLogic:GetFinalArmor(tooltip, lowerText)
							if finalArmor then
								value = finalArmor
							end
						end
						local infoTable = {}
						--if profileDB.showAPFromArmor then
							local effect = value * RatingBuster:GetStatMod("ADD_AP_MOD_ARMOR") * RatingBuster:GetStatMod("MOD_AP")
							if floor(abs(effect) * 10 + 0.5) > 0 then
								tinsert(infoTable, (gsub(L["$value AP"], "$value", format("%+.1f", effect))))
							end
						--end
						infoString = strjoin(", ", unpack(infoTable))
					end
					if infoString ~= "" then
						-- Add parenthesis;
						infoString = "("..infoString..")"
						-- Add Color
						if profileDB.enableTextColor then
							infoString = profileDB.textColor.hex..infoString..currentColorCode
						end
						-- Build replacement string
						if num.addInfo == "AfterNumber" then -- Add after number
							infoString = gsub(infoString, "%%", "%%%%%%%%") -- sub "%" with "%%%%"
							infoString = gsub(strsub(text, s), "%d+[%p%d]*", "%0"..num.space..infoString, 1) -- sub "33" with "33 (3.33%)"
						elseif num.addInfo == "AfterPattern" then -- Add after pattern
							infoString = gsub(infoString, "%%", "%%%%") -- sub "%" with "%%%%"
							infoString = strsub(text, s, e)..num.space..infoString
						else -- Add after stat
							infoString = gsub(infoString, "%%", "%%%%")
							s, e = strfind(lowerText, stat.pattern)
							infoString = "%0"..num.space..infoString
						end
						
						-- Escape "(" and ")" since they would cause problems with gsub.
						local cleanedText = gsub(strsub(text, s), "%(", "%%(")
						cleanedText = gsub(cleanedText, "%)", "%%)")
						--RatingBuster:Print("Итоговая строка состоит из " .. text .. " в котором " .. strsub(text, s, e) .. " меняется на " .. infoString ..", в итоге " .. gsub(text, cleanedText, infoString, 1))
						--RatingBuster:Print(cleanedText)
						--RatingBuster:Print("-----------------------")
						
						-- If it ends with "%" it would cause errors. Just escaping it isn't required since we don't need to add
						-- any rating conversion info for values that are already percentages, we just return the original text.
						if strmatch(cleanedText, "%%$") then return text end
						
						-- Insert info into text
						return (gsub(text, cleanedText, infoString, 1)) -- because gsub has 2 return values, but we only want 1
					end
					return text
				end
			end
		end
	end
	return text
end


-- Color Numbers
local GREEN_FONT_COLOR_CODE = GREEN_FONT_COLOR_CODE -- "|cff20ff20" Green
local HIGHLIGHT_FONT_COLOR_CODE = HIGHLIGHT_FONT_COLOR_CODE -- "|cffffffff" White
local RED_FONT_COLOR_CODE = RED_FONT_COLOR_CODE -- "|cffffffff" White
local FONT_COLOR_CODE_CLOSE = FONT_COLOR_CODE_CLOSE -- "|r"
local function colorNum(text, num)
	if num > 0 then
		return GREEN_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE
	elseif num < 0 then
		return RED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE
	else
		return HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE
	end
end

local armorTypes = {
	[BI["Plate"]] = "sumIgnorePlate",
	[BI["Mail"]] = "sumIgnoreMail",
	[BI["Leather"]] = "sumIgnoreLeather",
	[BI["Cloth"]] = "sumIgnoreCloth",
}

-- Acts as a cache so we only need to check text color once
local canUseItemType = {
}

-- Druid: Predatory Strikes 2,10: Increases 7%/14%/20% of any attack power on your equipped weapon.
local weaponItemEquipLoc = {
	["INVTYPE_WEAPON"] = true,
	["INVTYPE_2HWEAPON"] = true,
	["INVTYPE_WEAPONMAINHAND"] = true,
	["INVTYPE_WEAPONOFFHAND"] = true,
}

local summaryCalcData = {
	-----------
	-- Basic --
	-----------
	-- Strength - STR
	{
		option = "sumStr",
		name = "STR",
		func = function(sum, sumType, link) return sum["STR"] end,
	},
	-- Agility - AGI
	{
		option = "sumAgi",
		name = "AGI",
		func = function(sum, sumType, link) return sum["AGI"] end,
	},
	-- Stamina - STA
	{
		option = "sumSta",
		name = "STA",
		func = function(sum, sumType, link) return sum["STA"] end,
	},
	-- Health - HEALTH, STA
	{
		option = "sumHP",
		name = "HEALTH",
		func = function(sum, sumType, link) return ((sum["HEALTH"] or 0) + StatLogic:GetHealthFromSta(sum["STA"], calcLevel)) * RatingBuster:GetStatMod("MOD_HEALTH") end,
	},
	-- Intellect - INT
	{
		option = "sumInt",
		name = "INT",
		func = function(sum, sumType, link) return sum["INT"] end,
	},
	-- Mana - MANA,
	{
		option = "sumMP",
		name = "MANA",
		func = function(sum, sumType, link) return ((sum["MANA"] or 0) * RatingBuster:GetStatMod("MOD_MANA")) end,
	},
	-- Spirit - SPI
	{
		option = "sumSpi",
		name = "SPI",
		func = function(sum, sumType, link) return sum["SPI"] end,
	},
	-- Health Regen - HEALTH_REG
	{
		option = "sumHP5",
		name = "COMBAT_HEALTH_REGEN",
		func = function(sum, sumType, link) return (sum["COMBAT_HEALTH_REGEN"] or 0) end,
	},
	-- Mana Regen - MANA_REG, SPI
	{
		option = "sumMP5",
		name = "COMBAT_MANA_REGEN",
		func = function(sum, sumType, link)
			local _, spi = UnitStat("player", 5)
      if profileDB.enableSubtractEquippedStats and sumType == "sum" then
        spi = spi - equippedSum["SPI"]
      end
			return (sum["COMBAT_MANA_REGEN"] or 0)
			 + (StatLogic:GetNormalManaRegenFromSpi(spi + sum["SPI"])
			 - StatLogic:GetNormalManaRegenFromSpi(spi)) * RatingBuster:GetStatMod("ADD_COMBAT_MANA_REGEN_MOD_MANA_REGEN")
			 + summaryFunc["MANA"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_COMBAT_MANA_REGEN_MOD_MANA")
		end,
	},
	-- Mana Regen while Not casting - MANA_REG, SPI
	{
		option = "sumMP5OC",
		name = "MANA_REGEN",
		func = function(sum, sumType, link)
			local _, spi = UnitStat("player", 5)
      if profileDB.enableSubtractEquippedStats and sumType == "sum" then
        spi = spi - equippedSum["SPI"]
      end
			return (sum["COMBAT_MANA_REGEN"] or 0)
			 + StatLogic:GetNormalManaRegenFromSpi(spi + sum["SPI"])
			 - StatLogic:GetNormalManaRegenFromSpi(spi)
			 + summaryFunc["MANA"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_COMBAT_MANA_REGEN_MOD_MANA")
		end,
	},
	---------------------
	-- Physical Damage --
	---------------------
	-- Attack Power - AP, STR, AGI. 
	-- "ADD_AP_MOD_ARMOR" -- Death Knight: Bladed Armor
	-- "ADD_AP_MOD_INT" -- Shaman: Mental Dexterity
	{
		option = "sumAP",
		name = "AP",
		func = function(sum, sumType, link)
			local ap = (sum["AP"] or 0) 
			 + (sum["STR"] * StatLogic:GetAPPerStr(class))
			 + (sum["AGI"] * StatLogic:GetAPPerAgi(class))
			if RatingBuster:GetStatMod("ADD_AP_MOD_ARMOR") ~= 0 then
				ap = ap + (summaryFunc["ARMOR"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_AP_MOD_ARMOR"))
			end
			if RatingBuster:GetStatMod("ADD_AP_MOD_INT") ~= 0 then
				ap = ap + (sum["INT"] * RatingBuster:GetStatMod("ADD_AP_MOD_INT"))
			end
			-- Druid: Predatory Strikes 2,10: Increases 7%/14%/20% of any attack power on your equipped weapon.
			local p = 0
			local mod = RatingBuster:GetStatMod("MOD_AP") + p
			return ap * mod
		end,
	},
	-- Ranged Attack Power - RANGED_AP, AP, AGI, INT
	{
		option = "sumRAP",
		name = "RANGED_AP",
		func = function(sum, sumType, link)
			local rap = (sum["RANGED_AP"] or 0)
			 + (sum["AP"] or 0)
			 + (sum["AGI"] * StatLogic:GetRAPPerAgi(class))
			if RatingBuster:GetStatMod("ADD_AP_MOD_ARMOR") ~= 0 then
				rap = rap + (summaryFunc["ARMOR"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_AP_MOD_ARMOR"))
			end
			if RatingBuster:GetStatMod("ADD_AP_MOD_INT") ~= 0 then
				rap = rap + (sum["INT"] * RatingBuster:GetStatMod("ADD_AP_MOD_INT"))
			end
			return rap * (RatingBuster:GetStatMod("MOD_RANGED_AP")*RatingBuster:GetStatMod("MOD_AP"))
		end,
	},
	-- Hit Chance - MELEE_HIT_RATING
	{
		option = "sumHit",
		name = "MELEE_HIT",
		func = function(sum, sumType, link)
			local s = 0
			return s + StatLogic:GetEffectFromRating((sum["MELEE_HIT_RATING"] or 0), "MELEE_HIT_RATING", calcLevel)
		end,
		ispercent = true,
	},
	-- Hit Rating - MELEE_HIT_RATING
	{
		option = "sumHitRating",
		name = "MELEE_HIT_RATING",
		func = function(sum, sumType, link) return (sum["MELEE_HIT_RATING"] or 0) end,
	},
	-- Ranged Hit Chance - RANGED_HIT_RATING
	{
		option = "sumRangedHit",
		name = "RANGED_HIT",
		func = function(sum, sumType, link)
			local s = 0
			return s + StatLogic:GetEffectFromRating((sum["RANGED_HIT_RATING"] or 0), "RANGED_HIT_RATING", calcLevel)
		end,
		ispercent = true,
	},
	-- Ranged Hit Rating - RANGED_HIT_RATING
	{
		option = "sumRangedHitRating",
		name = "RANGED_HIT_RATING",
		func = function(sum, sumType, link) return (sum["RANGED_HIT_RATING"] or 0) end,
	},
	-- Crit Chance - MELEE_CRIT_RATING, AGI
	{
		option = "sumCrit",
		name = "MELEE_CRIT",
		func = function(sum, sumType, link)
			local s = 0
			return s + StatLogic:GetEffectFromRating((sum["MELEE_CRIT_RATING"] or 0), "MELEE_CRIT_RATING", calcLevel)
					 + StatLogic:GetCritFromAgi(sum["AGI"], class, calcLevel)
		end,
		ispercent = true,
	},
	-- Crit Rating - MELEE_CRIT_RATING
	{
		option = "sumCritRating",
		name = "MELEE_CRIT_RATING",
		func = function(sum, sumType, link) return (sum["MELEE_CRIT_RATING"] or 0) end,
	},
	-- Ranged Crit Chance - RANGED_CRIT_RATING, AGI
	{
		option = "sumRangedCrit",
		name = "RANGED_CRIT",
		func = function(sum, sumType, link)
			local s = 0
			return s + StatLogic:GetEffectFromRating((sum["RANGED_CRIT_RATING"] or 0), "RANGED_CRIT_RATING", calcLevel)
					 + StatLogic:GetCritFromAgi(sum["AGI"], class, calcLevel)
		end,
		ispercent = true,
	},
	-- Ranged Crit Rating - RANGED_CRIT_RATING
	{
		option = "sumRangedCritRating",
		name = "RANGED_CRIT_RATING",
		func = function(sum, sumType, link) return (sum["RANGED_CRIT_RATING"] or 0) end,
	},
	-- Haste - MELEE_HASTE_RATING
	{
		option = "sumHaste",
		name = "MELEE_HASTE",
		func = function(sum, sumType, link) return StatLogic:GetEffectFromRating((sum["MELEE_HASTE_RATING"] or 0), "MELEE_HASTE_RATING", calcLevel) * RatingBuster:GetStatMod("MOD_MELEE_HASTE") end,
		ispercent = true,
	},
	-- Haste Rating - MELEE_HASTE_RATING
	{
		option = "sumHasteRating",
		name = "MELEE_HASTE_RATING",
		func = function(sum, sumType, link) return (sum["MELEE_HASTE_RATING"] or 0) end,
	},
	-- Ranged Haste - RANGED_HASTE_RATING
	{
		option = "sumRangedHaste",
		name = "RANGED_HASTE",
		-- Use MOD_MELEE_HASTE for ranged too because there is none for ranged and all MOD_MELEE_HASTE buffs also affect ranged.
		func = function(sum, sumType, link) return StatLogic:GetEffectFromRating((sum["RANGED_HASTE_RATING"] or 0), "RANGED_HASTE_RATING", calcLevel) * RatingBuster:GetStatMod("MOD_MELEE_HASTE") end,
		ispercent = true,
	},
	-- Ranged Haste Rating - RANGED_HASTE_RATING
	{
		option = "sumRangedHasteRating",
		name = "RANGED_HASTE_RATING",
		func = function(sum, sumType, link) return (sum["RANGED_HASTE_RATING"] or 0) end,
	},
	-- Expertise - EXPERTISE_RATING
	{
		option = "sumExpertise",
		name = "EXPERTISE",
		func = function(sum, sumType, link) return StatLogic:GetEffectFromRating((sum["EXPERTISE_RATING"] or 0), "EXPERTISE_RATING", calcLevel) end,
		ispercent = true,
	},
	-- Expertise Rating - EXPERTISE_RATING
	{
		option = "sumExpertiseRating",
		name = "EXPERTISE_RATING",
		func = function(sum, sumType, link) return (sum["EXPERTISE_RATING"] or 0) end,
	},
	-- Mastery - MASTERY_RATING
	{
		option = "sumMastery",
		name = "MASTERY",
		func = function(sum, sumType, link) return StatLogic:GetEffectFromRating((sum["MASTERY_RATING"] or 0), "MASTERY_RATING", calcLevel) end,
		ispercent = true,
	},
	-- Mastery Rating - MASTERY_RATING
	{
		option = "sumMasteryRating",
		name = "MASTERY_RATING",
		func = function(sum, sumType, link) return (sum["MASTERY_RATING"] or 0) end,
		ispercent = true,
	},
	-- Dodge Neglect - EXPERTISE_RATING
	{
		option = "sumDodgeNeglect",
		name = "DODGE_NEGLECT",
		func = function(sum, sumType, link)
			local s = StatLogic:GetEffectFromRating((sum["EXPERTISE_RATING"] or 0), "EXPERTISE_RATING", calcLevel) * 0.25
			return s
		end,
		ispercent = true,
	},
	-- Parry Neglect - EXPERTISE_RATING
	{
		option = "sumParryNeglect",
		name = "PARRY_NEGLECT",
		func = function(sum, sumType, link)
			local s = StatLogic:GetEffectFromRating((sum["EXPERTISE_RATING"] or 0), "EXPERTISE_RATING", calcLevel) * 0.25
			return s
		end,
		ispercent = true,
	},
	-- Weapon Max Damage - MAX_DAMAGE
	{
		option = "sumWeaponMaxDamage",
		name = "MAX_DAMAGE",
		func = function(sum, sumType, link) return (sum["MAX_DAMAGE"] or 0) end,
	},
	------------------------------
	-- Spell Damage and Healing --
	------------------------------
	-- Spell Power - SPELL_DMG, ADD_SPELL_DMG_MOD_STA, ADD_SPELL_DMG_MOD_INT, ADD_SPELL_DMG_MOD_SPI, ADD_SPELL_DMG_MOD_AP
	{
		option = "sumSpellPower",
		name = "SPELL_POWER",
		func = function(sum, sumType, link)
			local spellDmg = (sum["SPELL_DMG"] or 0) + sum["INT"]
			if RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_STR") ~= 0 then
				spellDmg = spellDmg + (sum["STR"] * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_STR"))
			end
			if RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_STA") ~= 0 then
				spellDmg = spellDmg + (sum["STA"] * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_STA"))
			end
			if RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_INT") ~= 0 then
				spellDmg = spellDmg + (sum["INT"] * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_INT"))
			end
			if RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_MANA") ~= 0 then
				spellDmg = spellDmg + (summaryFunc["MANA"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_MANA"))
			end
			if RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_SPI") ~= 0 then
				spellDmg = spellDmg + (sum["SPI"] * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_SPI"))
			end
			if RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_AP") ~= 0 then
				spellDmg = spellDmg + (summaryFunc["AP"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_AP"))
			end
			if RatingBuster:GetStatMod("ADD_PET_STA_MOD_STA") ~= 0 then
				spellDmg = spellDmg + (sum["STA"] * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_PET_STA") * RatingBuster:GetStatMod("ADD_PET_STA_MOD_STA"))
				spellDmg = spellDmg + (sum["INT"] * RatingBuster:GetStatMod("ADD_SPELL_DMG_MOD_PET_INT") * RatingBuster:GetStatMod("ADD_PET_INT_MOD_INT"))
			end
			return spellDmg * RatingBuster:GetStatMod("MOD_SPELL_PWR")
		end,
	},
	-- Holy Damage - HOLY_SPELL_DMG, SPELL_DMG, 
	{
		option = "sumHolyDmg",
		name = "HOLY_SPELL_DMG",
		func = function(sum, sumType, link)
			return summaryFunc["SPELL_POWER"](sum, sumType, link)
			 + ((sum["HOLY_SPELL_DMG"] or 0))
			 * RatingBuster:GetStatMod("MOD_SPELL_PWR")
		end,
	},
	-- Arcane Damage - ARCANE_SPELL_DMG, SPELL_DMG, 
	{
		option = "sumArcaneDmg",
		name = "ARCANE_SPELL_DMG",
		func = function(sum, sumType, link)
			return summaryFunc["SPELL_POWER"](sum, sumType, link)
			 + ((sum["ARCANE_SPELL_DMG"] or 0))
			 * RatingBuster:GetStatMod("MOD_SPELL_PWR")
		end,
	},
	-- Fire Damage - FIRE_SPELL_DMG, SPELL_DMG, 
	{
		option = "sumFireDmg",
		name = "FIRE_SPELL_DMG",
		func = function(sum, sumType, link)
			return summaryFunc["SPELL_POWER"](sum, sumType, link)
			 + ((sum["FIRE_SPELL_DMG"] or 0))
			 * RatingBuster:GetStatMod("MOD_SPELL_PWR")
		end,
	},
	-- Nature Damage - NATURE_SPELL_DMG, SPELL_DMG, 
	{
		option = "sumNatureDmg",
		name = "NATURE_SPELL_DMG",
		func = function(sum, sumType, link)
			return summaryFunc["SPELL_POWER"](sum, sumType, link)
			 + ((sum["NATURE_SPELL_DMG"] or 0))
			 * RatingBuster:GetStatMod("MOD_SPELL_PWR")
		end,
	},
	-- Frost Damage - FROST_SPELL_DMG, SPELL_DMG, 
	{
		option = "sumFrostDmg",
		name = "FROST_SPELL_DMG",
		func = function(sum, sumType, link)
			return summaryFunc["SPELL_POWER"](sum, sumType, link)
			 + ((sum["FROST_SPELL_DMG"] or 0))
			 * RatingBuster:GetStatMod("MOD_SPELL_PWR")
		end,
	},
	-- Shadow Damage - SHADOW_SPELL_DMG, SPELL_DMG
	{
		option = "sumShadowDmg",
		name = "SHADOW_SPELL_DMG",
		func = function(sum, sumType, link)
			return summaryFunc["SPELL_POWER"](sum, sumType, link)
			 + ((sum["SHADOW_SPELL_DMG"] or 0))
			 * RatingBuster:GetStatMod("MOD_SPELL_PWR")
		end,
	},
	-- Healing - HEAL, AGI, STR, INT, SPI
	-- "ADD_HEAL_MOD_STR" -- Paladin: Touched by the Light
	-- "ADD_HEAL_MOD_AGI" -- Druid: Nurturing Instinct
	-- "ADD_HEAL_MOD_STA"
	-- "ADD_HEAL_MOD_INT"
	-- "ADD_HEAL_MOD_SPI"
	-- "ADD_HEAL_MOD_AP" -- Shaman: Mental Quickness
	{
		option = "sumHealing",
		name = "HEAL",
		func = function(sum, sumType, link)
			local heal = (sum["HEAL"] or 0) + sum["INT"]
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_STR") ~= 0 then
				heal = heal + (sum["STR"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_STR"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_AGI") ~= 0 then
				heal = heal + (sum["AGI"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_AGI"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_STA") ~= 0 then
				heal = heal + (sum["STA"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_STA"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_INT") ~= 0 then
				heal = heal + (sum["INT"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_INT"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_MANA") ~= 0 then
				heal = heal + (summaryFunc["MANA"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_HEAL_MOD_MANA"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_SPI") ~= 0 then
				heal = heal + (sum["SPI"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_SPI"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_AP") ~= 0 then
				heal = heal + (summaryFunc["AP"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_HEAL_MOD_AP"))
			end
			return heal * RatingBuster:GetStatMod("MOD_HEAL")
		end,
	},
	-- Spell Hit Chance - SPELL_HIT_RATING
	{
		option = "sumSpellHit",
		name = "SPELL_HIT",
		func = function(sum, sumType, link)
      return StatLogic:GetEffectFromRating((sum["SPELL_HIT_RATING"] or 0) + sum["SPI"] * RatingBuster:GetStatMod("ADD_SPELL_HIT_RATING_MOD_SPI"), "SPELL_HIT_RATING", calcLevel)
    end,
		ispercent = true,
	},
	-- Spell Hit Rating - SPELL_HIT_RATING
	{
		option = "sumSpellHitRating",
		name = "SPELL_HIT_RATING",
		func = function(sum, sumType, link)
      return (sum["SPELL_HIT_RATING"] or 0) + sum["SPI"] * RatingBuster:GetStatMod("ADD_SPELL_HIT_RATING_MOD_SPI")
    end,
	},
	-- Spell Crit Chance - SPELL_CRIT_RATING, INT
	{
		option = "sumSpellCrit",
		name = "SPELL_CRIT",
		func = function(sum, sumType, link)
			return StatLogic:GetEffectFromRating((sum["SPELL_CRIT_RATING"] or 0) + sum["SPI"] * RatingBuster:GetStatMod("ADD_SPELL_CRIT_RATING_MOD_SPI"), "SPELL_CRIT_RATING", calcLevel)
			 + StatLogic:GetSpellCritFromInt(sum["INT"], class, calcLevel)
		end,
		ispercent = true,
	},
	-- Spell Crit Rating - SPELL_CRIT_RATING
	{
		option = "sumSpellCritRating",
		name = "SPELL_CRIT_RATING",
		func = function(sum, sumType, link) return (sum["SPELL_CRIT_RATING"] or 0) + sum["SPI"] * RatingBuster:GetStatMod("ADD_SPELL_CRIT_RATING_MOD_SPI") end,
	},
	-- Spell Haste - SPELL_HASTE_RATING
	{
		option = "sumSpellHaste",
		name = "SPELL_HASTE",
		func = function(sum, sumType, link) return StatLogic:GetEffectFromRating((sum["SPELL_HASTE_RATING"] or 0), "SPELL_HASTE_RATING", calcLevel) * RatingBuster:GetStatMod("MOD_SPELL_HASTE") end,
		ispercent = true,
	},
	-- Spell Haste Rating - SPELL_HASTE_RATING
	{
		option = "sumSpellHasteRating",
		name = "SPELL_HASTE_RATING",
		func = function(sum, sumType, link) return (sum["SPELL_HASTE_RATING"] or 0) end,
	},
	-- Spell Penetration - SPELLPEN
	{
		option = "sumPenetration",
		name = "SPELLPEN",
		func = function(sum, sumType, link) return (sum["SPELLPEN"] or 0) end,
	},
	----------
	-- Tank --
	----------
	-- Armor - ARMOR, ARMOR_BONUS, AGI, INT
	{
		option = "sumArmor",
		name = "ARMOR",
		func = function(sum, sumType, link)
			-- Bonus armor beyond the base armor of an item will no longer be multiplied, 
			-- this includes armor from Necks, Rings, Trinkets, Weapons
			-- Commented out because StatLogic now handles this
			-- local itemType = select(9, GetItemInfo(link))
			-- local mod = 1
			-- if not modFreeArmorItemEquipLoc[itemType] then
				-- mod = RatingBuster:GetStatMod("MOD_ARMOR")
			-- end
			
			if (IsSpellKnown(77494) and UnitBuff("player", "Bear Form")) then --work arround for druids mastry armor bouns
			return (sum["ARMOR"] or 0) * ((RatingBuster:GetStatMod("MOD_ARMOR") * (GetMasteryEffect()/100))+ RatingBuster:GetStatMod("MOD_ARMOR") )
			 + (sum["ARMOR_BONUS"] or 0)
			else
			 			return (sum["ARMOR"] or 0) * RatingBuster:GetStatMod("MOD_ARMOR")
			 + (sum["ARMOR_BONUS"] or 0)
			 end

		end,
	},
	-- Dodge Chance Before DR - DODGE_RATING, AGI
	{
		option = "sumDodgeBeforeDR",
		name = "DODGE_NO_DR",
		func = function(sum, sumType, link)
			local dodge = StatLogic:GetEffectFromRating((sum["DODGE_RATING"] or 0), "DODGE_RATING", calcLevel)
				+ StatLogic:GetDodgeFromAgi(sum["AGI"] or 0)
			return dodge
		end,
		ispercent = true,
	},
	-- Dodge Chance - DODGE_RATING, AGI
	{
		option = "sumDodge",
		name = "DODGE",
		func = function(sum, sumType, link)
			local dodge = summaryFunc["DODGE_NO_DR"](sum, sumType, link)
			if profileDB.enableSubtractEquippedStats then
				if (sumType == "diff1") or (sumType == "diff2") then
					dodge = StatLogic:GetAvoidanceGainAfterDR("DODGE", equippedDodge + dodge) - StatLogic:GetAvoidanceGainAfterDR("DODGE", equippedDodge) --dodge = StatLogic:GetAvoidanceGainAfterDR("DODGE", dodge)
				elseif sumType == "sum" then
					dodge = StatLogic:GetAvoidanceGainAfterDR("DODGE", equippedDodge + dodge) - StatLogic:GetAvoidanceGainAfterDR("DODGE", equippedDodge)
				end
			end
			return dodge
		end,
		ispercent = true,
	},
	-- Dodge Rating - DODGE_RATING
	{
		option = "sumDodgeRating",
		name = "DODGE_RATING",
		func = function(sum, sumType, link) return (sum["DODGE_RATING"] or 0) end,
	},
	-- Parry Chance Before DR - PARRY_RATING
	{
		option = "sumParryBeforeDR",
		name = "PARRY_NO_DR",
		func = function(sum, sumType, link)
			if GetParryChance() == 0 then return 0 end
			local parryRating = (sum["PARRY_RATING"] or 0)
			if RatingBuster:GetStatMod("ADD_PARRY_MOD_STR") ~= 0 then

				if(sumType == "diff1" or sumType == "diff2") then
					local str = UnitStat("player", 1)
					local newStr = (sum["STR"] or 0) + str
					parryRating = parryRating + floor(newStr * RatingBuster:GetStatMod("ADD_PARRY_MOD_STR")) - floor(str * RatingBuster:GetStatMod("ADD_PARRY_MOD_STR"))
				else
					parryRating = parryRating + (sum["STR"] or 0) * RatingBuster:GetStatMod("ADD_PARRY_MOD_STR")
				end
			end
			local parry = StatLogic:GetEffectFromRating(parryRating, "PARRY_RATING", calcLevel)
			return parry
		end,
		ispercent = true,
	},
	-- Parry Chance - PARRY_RATING
	{
		option = "sumParry",
		name = "PARRY",
		func = function(sum, sumType, link)
			local parry = summaryFunc["PARRY_NO_DR"](sum, sumType, link)
	
			if profileDB.enableSubtractEquippedStats then
				if (sumType == "diff1") or (sumType == "diff2") then
					--parry = StatLogic:GetAvoidanceGainAfterDR("PARRY", equippedParry + parry)  Old
					parry = StatLogic:GetAvoidanceGainAfterDR("PARRY", equippedParry + parry) - StatLogic:GetAvoidanceGainAfterDR("PARRY", equippedParry) --works

				elseif sumType == "sum" then
					parry = StatLogic:GetAvoidanceGainAfterDR("PARRY", equippedParry + parry) - StatLogic:GetAvoidanceGainAfterDR("PARRY", equippedParry)
				end
			end
			return parry
		end,
		ispercent = true,
	},
	-- Parry Rating - PARRY_RATING
	-- "ADD_PARRY_MOD_STR" -- Death Knight: Forceful Deflection - Passive
	{
		option = "sumParryRating",
		name = "PARRY_RATING",
		func = function(sum, sumType, link) return (sum["PARRY_RATING"] or 0)  end,
	},
	-- Block Chance - BLOCK_RATING
	{
		option = "sumBlock",
		name = "BLOCK",
		func = function(sum, sumType, link)
			if GetBlockChance() == 0 then return 0 end
      local block = StatLogic:GetEffectFromRating((sum["BLOCK_RATING"] or 0), "BLOCK_RATING", calcLevel)
      if sum["MASTERY_RATING"] then
        if class == "WARRIOR" and IsSpellKnown(CLASS_MASTERY_SPELLS[class]) and GetSpecialization() == 3 then --5.0.3 GetPrimaryTalentTree replaced with GetSpecialization
          local mastery = StatLogic:GetEffectFromRating((sum["MASTERY_RATING"] or 0), "MASTERY_RATING", calcLevel)
          block = block + StatLogic:GetEffectFromMastery(mastery, 3, class)
        elseif class == "PALADIN" and IsSpellKnown(CLASS_MASTERY_SPELLS[class]) and GetSpecialization() == 2 then --5.0.3 GetPrimaryTalentTree replaced with GetSpecialization
          local mastery = StatLogic:GetEffectFromRating((sum["MASTERY_RATING"] or 0), "MASTERY_RATING", calcLevel)
          block = block + StatLogic:GetEffectFromMastery(mastery, 2, class)
        end
      end
			return block
		end,
		ispercent = true,
	},
	-- Block Rating - BLOCK_RATING
	{
		option = "sumBlockRating",
		name = "BLOCK_RATING",
		func = function(sum, sumType, link) return (sum["BLOCK_RATING"] or 0) end,
	},
	-- Hit Avoidance Before DR - MELEE_HIT_AVOID_RATING
	{
		option = "sumHitAvoidBeforeDR",
		name = "MELEE_HIT_AVOID_NO_DR",
		func = function(sum, sumType, link) return StatLogic:GetEffectFromRating((sum["MELEE_HIT_AVOID_RATING"] or 0), "MELEE_HIT_AVOID_RATING", calcLevel) end,
		ispercent = true,
	},
	-- Hit Avoidance Before DR - MELEE_HIT_AVOID_RATING
	{
		option = "sumHitAvoid",
		name = "MELEE_HIT_AVOID",
		func = function(sum, sumType, link)
			local missed = summaryFunc["MELEE_HIT_AVOID_NO_DR"](sum, sumType, link)
			if profileDB.enableSubtractEquippedStats then
				if (sumType == "diff1") or (sumType == "diff2") then
					missed = StatLogic:GetAvoidanceGainAfterDR("MELEE_HIT_AVOID", missed)
				elseif sumType == "sum" then
					missed = StatLogic:GetAvoidanceGainAfterDR("MELEE_HIT_AVOID", equippedMissed + missed) - StatLogic:GetAvoidanceGainAfterDR("MELEE_HIT_AVOID", equippedMissed)
				end
			end
			return missed
		end,
		ispercent = true,
	},
	-- Crit Avoidance - MELEE_CRIT_AVOID_RATING
	{
		option = "sumCritAvoid",
		name = "MELEE_CRIT_AVOID",
		func = function(sum, sumType, link) return StatLogic:GetEffectFromRating((sum["MELEE_CRIT_AVOID_RATING"] or 0), "MELEE_CRIT_AVOID_RATING", calcLevel)
			 + StatLogic:GetEffectFromRating((sum["RESILIENCE_RATING"] or 0), "RESILIENCE_RATING", calcLevel) end,
		ispercent = true,
	},
	-- Resilience - RESILIENCE_RATING
	{
		option = "sumResilience",
		name = "RESILIENCE_RATING",
		func = function(sum, sumType, link) return (sum["RESILIENCE_RATING"] or 0) end,
	},
	-- Arcane Resistance - ARCANE_RES
	{
		option = "sumArcaneResist",
		name = "ARCANE_RES",
		func = function(sum, sumType, link) return (sum["ARCANE_RES"] or 0) end,
	},
	-- Fire Resistance - FIRE_RES
	{
		option = "sumFireResist",
		name = "FIRE_RES",
		func = function(sum, sumType, link) return (sum["FIRE_RES"] or 0) end,
	},
	-- Nature Resistance - NATURE_RES
	{
		option = "sumNatureResist",
		name = "NATURE_RES",
		func = function(sum, sumType, link) return (sum["NATURE_RES"] or 0) end,
	},
	-- Frost Resistance - FROST_RES
	{
		option = "sumFrostResist",
		name = "FROST_RES",
		func = function(sum, sumType, link) return (sum["FROST_RES"] or 0) end,
	},
	-- Shadow Resistance - SHADOW_RES
	{
		option = "sumShadowResist",
		name = "SHADOW_RES",
		func = function(sum, sumType, link) return (sum["SHADOW_RES"] or 0) end,
	},
	-- Avoidance - DODGE, PARRY, MELEE_HIT_AVOID, BLOCK(Optional)
	{
		option = "sumAvoidance",
		name = "AVOIDANCE",
		ispercent = true,
		func = function(sum, sumType, link)
			local dodge, parry, mobMiss, block
			dodge = summaryFunc["DODGE"](sum, sumType, link)
			parry = summaryFunc["PARRY"](sum, sumType, link)
			mobMiss = summaryFunc["MELEE_HIT_AVOID"](sum, sumType, link)
			block = 0
			if profileDB.sumAvoidWithBlock then
				block = summaryFunc["BLOCK"](sum, sumType, link)
			end
			return parry + dodge + mobMiss + block
		end,
		ispercent = true,
	},
}
if tpSupport == true then
	-- TankPoints
	tinsert(summaryCalcData, {
		option = "sumTankPoints",
		name = "TANKPOINTS",
		func = function(diffTable1, sumType)
			if sumType == "sum" then return nil end
			-- Item type
			local itemType = diffTable1.itemType
			-- Calculate current TankPoints
			local tpSource = {}
			local TP = TankPoints
			local TPTips = TankPointsTooltips
			TP:GetSourceData(tpSource, TP_MELEE)
			local tpResults = {}
			copyTable(tpResults, tpSource)
			TP:GetTankPoints(tpResults, TP_MELEE)
			-- Update if different
			if floor(TP.resultsTable.tankPoints[TP_MELEE]) ~= floor(tpResults.tankPoints[TP_MELEE]) then
				copyTable(TP.sourceTable, tpSource)
				copyTable(TP.resultsTable, tpResults)
			end
			----------------------------------------------------
			-- Calculate TP difference with 1st equipped item --
			----------------------------------------------------
			local tpTable = {}
			-- Set the forceShield arg
			local forceShield
			-- if not equipped shield and item is shield then force on
			-- if not equipped shield and item is not shield then nil
			-- if equipped shield and item is shield then nil
			-- if equipped shield and item is not shield then force off
			if ((diffTable1.diffItemType1 ~= "INVTYPE_SHIELD") and (diffTable1.diffItemType2 ~= "INVTYPE_SHIELD")) and (itemType == "INVTYPE_SHIELD") then
				forceShield = true
			elseif ((diffTable1.diffItemType1 == "INVTYPE_SHIELD") or (diffTable1.diffItemType2 == "INVTYPE_SHIELD")) and (itemType ~= "INVTYPE_SHIELD") then
				forceShield = false
			end
			-- Get the tp table
			TP:GetSourceData(tpTable, TP_MELEE, forceShield)
			-- Build changes table
			local changes = TPTips:BuildChanges({}, diffTable1)
			-- Alter tp table
			TP:AlterSourceData(tpTable, changes, forceShield)
			-- Calculate TankPoints from tpTable
			TP:GetTankPoints(tpTable, TP_MELEE, forceShield)
			-- Calculate tp difference
			local diff = floor(tpTable.tankPoints[TP_MELEE]) - floor(TP.resultsTable.tankPoints[TP_MELEE])
	
			return diff
		end,
	})
	-- Total Reduction
	tinsert(summaryCalcData, {
		option = "sumTotalReduction",
		name = "TOTALREDUCTION",
		ispercent = true,
		func = function(diffTable1, sumType)
			if sumType == "sum" then return nil end
			-- Item type
			local itemType = diffTable1.itemType
			local right
			-- Calculate current TankPoints
			local tpSource = {}
			local TP = TankPoints
			local TPTips = TankPointsTooltips
			TP:GetSourceData(tpSource, TP_MELEE)
			local tpResults = {}
			copyTable(tpResults, tpSource)
			TP:GetTankPoints(tpResults, TP_MELEE)
			-- Update if different
			if floor(TP.resultsTable.tankPoints[TP_MELEE]) ~= floor(tpResults.tankPoints[TP_MELEE]) then
				copyTable(TP.sourceTable, tpSource)
				copyTable(TP.resultsTable, tpResults)
			end
			----------------------------------------------------
			-- Calculate TP difference with 1st equipped item --
			----------------------------------------------------
			local tpTable = {}
			-- Set the forceShield arg
			local forceShield
			-- if not equipped shield and item is shield then force on
			-- if not equipped shield and item is not shield then nil
			-- if equipped shield and item is shield then nil
			-- if equipped shield and item is not shield then force off
			if ((diffTable1.diffItemType1 ~= "INVTYPE_SHIELD") and (diffTable1.diffItemType2 ~= "INVTYPE_SHIELD")) and (itemType == "INVTYPE_SHIELD") then
				forceShield = true
			elseif ((diffTable1.diffItemType1 == "INVTYPE_SHIELD") or (diffTable1.diffItemType2 == "INVTYPE_SHIELD")) and (itemType ~= "INVTYPE_SHIELD") then
				forceShield = false
			end
			-- Get the tp table
			TP:GetSourceData(tpTable, TP_MELEE, forceShield)
			-- Build changes table
			local changes = TPTips:BuildChanges({}, diffTable1)
			-- Alter tp table
			TP:AlterSourceData(tpTable, changes, forceShield)
			-- Calculate TankPoints from tpTable
			TP:GetTankPoints(tpTable, TP_MELEE, forceShield)
			-- Calculate tp difference
			local diff = tpTable.totalReduction[TP_MELEE] - TP.resultsTable.totalReduction[TP_MELEE]
			
			return diff * 100
		end,
	})
	--[[
	-- Avoidance
	tinsert(summaryCalcData, {
		option = "sumAvoidance",
		name = "AVOIDANCE",
		ispercent = true,
		func = function(diffTable1)
			-- Item type
			local itemType = diffTable1.itemType
			local right
			-- Calculate current TankPoints
			local tpSource = {}
			local TP = TankPoints
			local TPTips = TankPointsTooltips
			TP:GetSourceData(tpSource, TP_MELEE)
			local tpResults = {}
			copyTable(tpResults, tpSource)
			TP:GetTankPoints(tpResults, TP_MELEE)
			-- Update if different
			if floor(TP.resultsTable.tankPoints[TP_MELEE]) ~= floor(tpResults.tankPoints[TP_MELEE]) then
				copyTable(TP.sourceTable, tpSource)
				copyTable(TP.resultsTable, tpResults)
			end
			----------------------------------------------------
			-- Calculate TP difference with 1st equipped item --
			----------------------------------------------------
			local tpTable = {}
			-- Set the forceShield arg
			local forceShield
			-- if not equipped shield and item is shield then force on
			-- if not equipped shield and item is not shield then nil
			-- if equipped shield and item is shield then nil
			-- if equipped shield and item is not shield then force off
			if ((diffTable1.diffItemType1 ~= "INVTYPE_SHIELD") and (diffTable1.diffItemType2 ~= "INVTYPE_SHIELD")) and (itemType == "INVTYPE_SHIELD") then
				forceShield = true
			elseif ((diffTable1.diffItemType1 == "INVTYPE_SHIELD") or (diffTable1.diffItemType2 == "INVTYPE_SHIELD")) and (itemType ~= "INVTYPE_SHIELD") then
				forceShield = false
			end
			-- Get the tp table
			TP:GetSourceData(tpTable, TP_MELEE, forceShield)
			-- Build changes table
			local changes = TPTips:BuildChanges({}, diffTable1)
			-- Alter tp table
			TP:AlterSourceData(tpTable, changes, forceShield)
			-- Calculate TankPoints from tpTable
			TP:GetTankPoints(tpTable, TP_MELEE, forceShield)
			-- Calculate tp difference
			local diff = tpTable.mobMissChance + tpTable.dodgeChance + tpTable.parryChance - TP.resultsTable.mobMissChance - TP.resultsTable.dodgeChance - TP.resultsTable.parryChance
			
			return diff * 100
		end,
	})
	--]]
end

-- Build summaryFunc
for _, calcData in ipairs(summaryCalcData) do
	summaryFunc[calcData.name] = calcData.func
end


local function sumSortAlphaComp(a, b)
	return a[1] < b[1]
end

local SpellDamageHealing = {
  ["sumHolyDmg"] = true,
  ["sumArcaneDmg"] = true,
  ["sumFireDmg"] = true,
  ["sumNatureDmg"] = true,
  ["sumFrostDmg"] = true,
  ["sumShadowDmg"] = true,
  ["sumHealing"] = {
		option = "sumHealing",
		name = "HEAL",
		func = function(sum, sumType, link)
			local heal = (sum["HEAL"] or 0) + sum["INT"]
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_STR") ~= 0 then
				heal = heal + (sum["STR"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_STR"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_AGI") ~= 0 then
				heal = heal + (sum["AGI"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_AGI"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_STA") ~= 0 then
				heal = heal + (sum["STA"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_STA"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_INT") ~= 0 then
				heal = heal + (sum["INT"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_INT"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_MANA") ~= 0 then
				heal = heal + (summaryFunc["MANA"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_HEAL_MOD_MANA"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_SPI") ~= 0 then
				heal = heal + (sum["SPI"] * RatingBuster:GetStatMod("ADD_HEAL_MOD_SPI"))
			end
			if RatingBuster:GetStatMod("ADD_HEAL_MOD_AP") ~= 0 then
				heal = heal + (summaryFunc["AP"](sum, sumType, link) * RatingBuster:GetStatMod("ADD_HEAL_MOD_AP"))
			end
			return heal * RatingBuster:GetStatMod("MOD_HEAL")
		end,
	},
}

function RatingBuster:StatSummary(tooltip, name, link, ...)
	-- Hide stat summary for equipped items
	if profileDB.sumIgnoreEquipped and IsEquippedItem(link) then return end
	
	-- Show stat summary only for highest level armor type and items you can use with uncommon quality and up
	if profileDB.sumIgnoreUnused then
		local _, _, itemRarity, _, _, _, itemSubType, _, itemEquipLoc = GetItemInfo(link)
		-- Check rarity
		if not itemRarity or itemRarity < profileDB.sumMinQuality then return end
		-- Check armor type
		if armorTypes[itemSubType] and profileDB[armorTypes[itemSubType]] and itemEquipLoc ~= "INVTYPE_CLOAK" then
			--self:Print("Check armor type", itemSubType)
			return
		end
		-- Check for Red item types
		if canUseItemType[itemSubType] == false then
			return
		elseif canUseItemType[itemSubType] == nil then
			local tName = tooltip:GetName()
			if (_G[tName.."TextRight3"]:GetText() and select(2, _G[tName.."TextRight3"]:GetTextColor()) < 0.2) or
			(_G[tName.."TextRight4"]:GetText() and select(2, _G[tName.."TextRight4"]:GetTextColor()) < 0.2) or
			(_G[tName.."TextRight5"]:GetText() and select(2, _G[tName.."TextRight5"]:GetTextColor()) < 0.2) or
			select(2, _G[tName.."TextLeft3"]:GetTextColor()) < 0.2 or select(2, _G[tName.."TextLeft4"]:GetTextColor()) < 0.2 or
			select(2, _G[tName.."TextLeft5"]:GetTextColor()) < 0.2 then
				canUseItemType[itemSubType] = false
				return
			else
				canUseItemType[itemSubType] = true
			end
		end
	end
	
	-- Ignore enchants and gems on items when calculating the stat summarythen
	local red, yellow, blue, meta
	if isModifierKeyDown[profileDB.sumGem2Toggle] and isModifierKeyDown[profileDB.sumGem2Toggle]() then
		red = profileDB.sumGemRed2.gemID
		yellow = profileDB.sumGemYellow2.gemID
		blue = profileDB.sumGemBlue2.gemID
		meta = profileDB.sumGemMeta2.gemID
	elseif isModifierKeyDown[profileDB.sumGem3Toggle] and isModifierKeyDown[profileDB.sumGem3Toggle]() then
		red = profileDB.sumGemRed3.gemID
		yellow = profileDB.sumGemYellow3.gemID
		blue = profileDB.sumGemBlue3.gemID
		meta = profileDB.sumGemMeta3.gemID
	else
		red = profileDB.sumGemRed.gemID
		yellow = profileDB.sumGemYellow.gemID
		blue = profileDB.sumGemBlue.gemID
		meta = profileDB.sumGemMeta.gemID
	end
	
	if profileDB.sumIgnoreEnchant then
		link = StatLogic:RemoveEnchant(link)
	end
	if profileDB.sumIgnorePris then
		link = StatLogic:RemoveExtraSocketGem(link)
	end
	if profileDB.sumIgnoreGems then
		link = StatLogic:RemoveGem(link)
	else
		link = StatLogic:BuildGemmedTooltip(link, red, yellow, blue, meta)
	end
	
	-- Diff Display Style
	-- Main Tooltip: tooltipLevel = 0
	-- Compare Tooltip 1: tooltipLevel = 1
	-- Compare Tooltip 2: tooltipLevel = 2
	local id
	local tooltipLevel = 0
	local mainTooltip = tooltip
	-- Determine tooltipLevel and id
	if profileDB.calcDiff and (profileDB.sumDiffStyle == "comp") then
		-- Obtain main tooltip
		-- Detemine tooltip level
		if mainTooltip:GetOwner():GetObjectType() == "GameTooltip" then
			mainTooltip = mainTooltip:GetOwner()
			-- This is a comparison tooltip
			local _, level = ...
			if type(level) == "number" then
				tooltipLevel = level
			else
				tooltipLevel = 1
			end
			if mainTooltip:GetOwner():GetObjectType() == "GameTooltip" then
				mainTooltip = mainTooltip:GetOwner()
				if type(level) ~= "number" then
					tooltipLevel = 2
				end
			end
		end
		local _, mainlink = StatLogic:GetDiffID(mainTooltip, profileDB.sumIgnoreEnchant, profileDB.sumIgnoreGems, red, yellow, blue, meta, profileDB.sumIgnorePris)
		if not mainlink then return end
		-- Construct id
		if tooltipLevel > 0 then
			id = link..mainlink
		else
			id = "sum"..link
		end
	else
		id = StatLogic:GetDiffID(link, profileDB.sumIgnoreEnchant, profileDB.sumIgnoreGems, red, yellow, blue, meta, profileDB.sumIgnorePris)
		if not id then return end
	end
	
	-- Check Cache
	if cache[id] then
		if #cache[id] == 0 then return end
		-- Write Tooltip
		if profileDB.sumBlankLine then
			tooltip:AddLine(" ")
		end
		if profileDB.sumShowTitle then
			tooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..L["Stat Summary"]..FONT_COLOR_CODE_CLOSE)
			if profileDB.sumShowIcon then
				tooltip:AddTexture("Interface\\AddOns\\RatingBuster\\images\\Sigma")
			end
		end
		-- local left, right = "", ""
		-- for _, o in ipairs(cache[id]) do
			-- left = left..o[1].."\n"
			-- right = right..o[2].."\n"
		-- end
		-- left = strsub(left, 1, -3)
		-- right = strsub(right, 1, -3)
		-- tooltip:AddDoubleLine(left, right)
		for _, o in ipairs(cache[id]) do
			tooltip:AddDoubleLine(o[1], o[2])
		end
		if profileDB.sumBlankLineAfter then
			tooltip:AddLine(" ")
		end
		return
	end
	
	-------------------------
	-- Build Summary Table --
	local statData = {}
	statData.sum = StatLogic:GetSum(link)
	if not statData.sum then return end
	if not profileDB.calcSum then
		statData.sum = nil
	end
	
	-- Ignore bags
	if not StatLogic:GetDiff(link) then return end
	
	-- Get Diff Data
	if profileDB.calcDiff then
		if profileDB.sumDiffStyle == "comp" then
			if tooltipLevel > 0 then
				statData.diff1 = select(tooltipLevel, StatLogic:GetDiff(mainTooltip, nil, nil, profileDB.sumIgnoreEnchant, profileDB.sumIgnoreGems, red, yellow, blue, meta, profileDB.sumIgnorePris))
			end
		else
			statData.diff1, statData.diff2 = StatLogic:GetDiff(link, nil, nil, profileDB.sumIgnoreEnchant, profileDB.sumIgnoreGems, red, yellow, blue, meta, profileDB.sumIgnorePris)
		end
	end
	-- Apply Base Stat Mods
	for _, v in pairs(statData) do
		v["STR"] = (v["STR"] or 0)
		v["AGI"] = (v["AGI"] or 0)
		v["STA"] = (v["STA"] or 0)
		v["INT"] = (v["INT"] or 0)
		v["SPI"] = (v["SPI"] or 0)
	end
	if profileDB.enableStatMods then
		for _, v in pairs(statData) do
			v["STR"] = v["STR"] * RatingBuster:GetStatMod("MOD_STR")
			v["AGI"] = v["AGI"] * RatingBuster:GetStatMod("MOD_AGI")
			v["STA"] = v["STA"] * RatingBuster:GetStatMod("MOD_STA")
			v["INT"] = v["INT"] * RatingBuster:GetStatMod("MOD_INT")
			v["SPI"] = v["SPI"] * RatingBuster:GetStatMod("MOD_SPI")
		end
	end
	-- Summary Table
	--[[
	local statData = {
		sum = {},
		diff1 = {},
		diff2 = {},
	}
	if profileDB.sumHP then
		local d = {name = "HEALTH"}
		for k, sum in pairs(data) do
			d[k] = ((sum["HEALTH"] or 0) + (sum["STA"] * 10)) * RatingBuster:GetStatMod("MOD_HEALTH")
		end
		tinsert(summary, d)
	end
	local summaryCalcData = {
		-- Health - HEALTH, STA
		{
			name = "HEALTH",
			func = function(sum, sumType, link) return ((sum["HEALTH"] or 0) + (sum["STA"] * 10)) * RatingBuster:GetStatMod("MOD_HEALTH") end,
			ispercent = false,
		},
	}
	--]]
	local summary = {}
	for _, calcData in ipairs(summaryCalcData) do
		if profileDB[calcData.option] and not SpellDamageHealing[calcData.option] then
			local entry = {
				name = calcData.name,
				ispercent = calcData.ispercent,
			}
			for sumType, statTable in pairs(statData) do
				entry[sumType] = calcData.func(statTable, sumType, link)
			end
			tinsert(summary, entry)
		end
	end
	
	local calcSum = profileDB.calcSum
	local calcDiff = profileDB.calcDiff
	
	local showZeroValueStat = profileDB.showZeroValueStat
	------------------------
	-- Build Output Table --
	local output = {}
	for _, t in ipairs(summary) do
		local n, s, d1, d2, ispercent = t.name, t.sum, t.diff1, t.diff2, t.ispercent

		local right, left
		local skip
		if not showZeroValueStat then
			-- Don't show this line if sum, diff1, diff2 are all 0
			if (s == 0 or not s) and (d1 == 0 or not d1) and (d2 == 0 or not d2) then
				skip = true
			end
		end
		if not skip then
			if calcSum and calcDiff then
				local d = ((not s) or ((s - floor(s)) == 0)) and ((not d1) or ((d1 - floor(d1)) == 0)) and ((not d2) or ((d2 - floor(d2)) == 0))
				if s then
					if d then
						s = format("%d", s)
					elseif ispercent then
						s = format("%.2f%%", s)
					else
						s = format("%.1f", s)
					end
					if d1 then
						if d then
							d1 = colorNum(format("%+d", d1), d1)
						elseif ispercent then
							d1 = colorNum(format("%+.2f%%", d1), d1)
						else
							d1 = colorNum(format("%+.1f", d1), d1)
						end
						if d2 then
							if d then
								d2 = colorNum(format("%+d", d2), d2)
							elseif ispercent then
								d2 = colorNum(format("%+.2f%%", d2), d2)
							else
								d2 = colorNum(format("%+.1f", d2), d2)
							end
							right = format("%s (%s||%s)", s, d1, d2)
						else
							right = format("%s (%s)", s, d1)
						end
					else
						right = s
					end
				else
					if d1 then
						if d then
							d1 = colorNum(format("%+d", d1), d1)
						elseif ispercent then
							d1 = colorNum(format("%+.2f%%", d1), d1)
						else
							d1 = colorNum(format("%+.1f", d1), d1)
						end
						if d2 then
							if d then
								d2 = colorNum(format("%+d", d2), d2)
							elseif ispercent then
								d2 = colorNum(format("%+.2f%%", d2), d2)
							else
								d2 = colorNum(format("%+.1f", d2), d2)
							end
							right = format("(%s||%s)", d1, d2)
						else
							right = format("(%s)", d1)
						end
					end
				end
			elseif calcSum then
				if s then
					if (s - floor(s)) == 0 then
						s = format("%d", s)
					elseif ispercent then
						s = format("%.2f%%", s)
					else
						s = format("%.1f", s)
					end
					right = s
				end
			elseif calcDiff then
				local d = ((not d1) or (d1 - floor(d1)) == 0) and ((not d2) or ((d2 - floor(d2)) == 0))
				if d1 then
					if d then
						d1 = colorNum(format("%+d", d1), d1)
					elseif ispercent then
						d1 = colorNum(format("%+.2f%%", d1), d1)
					else
						d1 = colorNum(format("%+.1f", d1), d1)
					end
					if d2 then
						if d then
							d2 = colorNum(format("%+d", d2), d2)
						elseif ispercent then
							d2 = colorNum(format("%+.2f%%", d2), d2)
						else
							d2 = colorNum(format("%+.1f", d2), d2)
						end
						right = format("%s||%s", d1, d2)
					else
						right = d1
					end
				end
			end
			if right then
				if n == "TANKPOINTS" then
					if tpSupport then
						left = tpLocale["TankPoints"]
					else
						left = "TankPoints"
					end
				elseif n == "TOTALREDUCTION" then
					if tpSupport then
						left = tpLocale["Total Reduction"]
					else
						left = "Total Reduction"
					end
				else
					left = StatLogic:GetStatNameFromID(n)
				end
				tinsert(output, {left, right})
			end
		end
	end
	-- sort alphabetically if option enabled
	if profileDB.sumSortAlpha then
		tsort(output, sumSortAlphaComp)
	end
	-- Write cache
	cache[id] = output
	if #output == 0 then return end
	-------------------
	-- Write Tooltip --
	if profileDB.sumBlankLine then
		tooltip:AddLine(" ")
	end
	if profileDB.sumShowTitle then
		tooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..L["Stat Summary"]..FONT_COLOR_CODE_CLOSE)
		if profileDB.sumShowIcon then
			tooltip:AddTexture("Interface\\AddOns\\RatingBuster\\images\\Sigma")
		end
	end
	for _, o in ipairs(output) do
		tooltip:AddDoubleLine(o[1], o[2])
	end
	if profileDB.sumBlankLineAfter then
		tooltip:AddLine(" ")
	end
end


-- RatingBuster:Bench(1000)
---------
-- self:SplitDoJoin("+24 Agility/+4 Stamina, +4 Dodge and +4 Spell Crit/+5 Spirit", {"/", " and ", ","})
-- 1000 times: 0.16 - 0.18 without Compost
-- 1000 times: 0.22 - 0.24 with Compost
---------
-- RatingBuster.ProcessTooltip(ItemRefTooltip, link)
-- 1000 times: 0.31 sec - 0.7.6
-- 1000 times: 0.29 sec - 0.
-- 1000 times: 0.24 sec - 0.8.58.0
---------
-- strjoin 1000000 times: 0.46
-- ..      1000000 times: 0.27
--------------
function RatingBuster:Bench(k)
	local t1 = GetTime()
	local link = GetInventoryItemLink("player", 12)
	for i = 1, k, 1 do
		---------------------------------------------------------------------------
		--self:SplitDoJoin("+24 Agility/+4 Stamina, +4 Dodge and +4 Spell Crit/+5 Spirit", {"/", " and ", ","})
		---------------------------------------------------------------------------
		ItemRefTooltip:SetInventoryItem("player", 12)
		RatingBuster.ProcessTooltip(ItemRefTooltip, link)
		---------------------------------------------------------------------------
		--ItemRefTooltip:SetScript("OnTooltipSetItem", function(frame, ...) RatingBuster:Print("OnTooltipSetItem") end)
		----------------------------------------------------------------------
		--local h = strjoin("", "test", "123")
		--local h = "test".."123"
		--------------------------------------------------------------------------------
	end
	return GetTime() - t1
end

