-- $Id: CompareFrame.lua 4213 2013-05-22 11:24:37Z lag123 $
local _
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

local FRAME_NAME = "AtlasLootCompareFrame"
-- Formatierte liste für scroll frame
local OPEN_MAINFILTER_LIST = {}
-- Speichert Main buttons (NAMEN) (ipairs)
local LIST_MAINFILTERS = {}
-- Speichert Sub liste (NAMEN)
local LIST_SUBFILTERS = {}
local LIST_SUBSUBFILTERS = {}
-- Speichert liste aller items
local LIST_ITEMS = {}
-- Speicher Item details (von AtlasLoot tabelle)
local ITEM_DEATAIL = {}
-- Wieviel statussort aufeinmal angezeigt werden können
local ITEM_LIST_MAX_SORTS = 8
-- Anzahl an items in Wishlist
local NUM_ITEMS_IN_WISHLIST = 0

local lootTableTypes = AtlasLoot.lootTableTypes

local NUM_MAINFILTERS_TO_DISPLAY = 15
local NUM_ITEMS_TO_DISPLAY = 8

local NUM_ITEMS_IN_LIST = 0

-- Liste der Slots
-- Zahlen bestimmen position beim sortieren
local SLOT_LIST = {
	["INVTYPE_AMMO"] = 0,
	["INVTYPE_HEAD"] = 1,
	["INVTYPE_NECK"] = 2,
	["INVTYPE_SHOULDER"] = 3,
	["INVTYPE_BODY"] = 4,
	["INVTYPE_CHEST"] = 5,
	["INVTYPE_ROBE"] = 6,
	["INVTYPE_WAIST"] = 7,
	["INVTYPE_LEGS"] = 8,
	["INVTYPE_FEET"] = 9,
	["INVTYPE_WRIST"] = 10,
	["INVTYPE_HAND"] = 11,
	["INVTYPE_FINGER"] = 12,
	["INVTYPE_TRINKET"] = 13,
	["INVTYPE_CLOAK"] = 14,
	["INVTYPE_WEAPON"] = 15,
	["INVTYPE_SHIELD"] = 16,
	["INVTYPE_2HWEAPON"] = 17,
	["INVTYPE_WEAPONMAINHAND"] = 18,
	["INVTYPE_WEAPONOFFHAND"] = 19,
	["INVTYPE_HOLDABLE"] = 20,
	["INVTYPE_RANGED"] = 21,
	["INVTYPE_THROWN"] = 22,
	["INVTYPE_RANGEDRIGHT"] = 23,
	["INVTYPE_RELIC"] = 24,
	["INVTYPE_TABARD"] = 25,
	["INVTYPE_BAG"] = 26,
	["INVTYPE_QUIVER"] = 27,
}

-- Um platz zu sparen auch abkürzungen speichern
--for k,v in pairs(GetItemStats("item:56319")) do print(k.." = "..v) end
local STATS_LIST = {
	["ITEMLVL"] = { AL["iLvl"], AL["ItemLvl"] },
	
	["STRENGTH"] = { AL["str"], AL["Strength"] },
 	["AGILITY"] = { AL["agi"], AL["Agility"] },
	["STAMINA"] = { AL["sta"], AL["Stamina"] },
	["INTELLECT"] = { AL["int"], AL["Intellect"] },
	["SPIRIT"] = { AL["spi"], AL["Spirit"] },
	
	["CRIT_RATING"] = { AL["Crit"], AL["Crit Rating"] },
	["DODGE_RATING"] = { AL["Dodge"], AL["Dodge Rating"] },
	["EXPERTISE_RATING"] = { AL["Exp"], AL["Expertise Rating"] },
	["HIT_RATING"] = { AL["Hit"], AL["Hit Rating"] },
	["HASTE_RATING"] = { AL["Haste"], AL["Haste Rating"] },
	["MASTERY_RATING"] = { AL["Mast"], AL["Mastery Rating"] },
	["PARRY_RATING"] = { AL["Parry"], AL["Parry Rating"] },
	["SPELL_POWER"] = { AL["Spell"], AL["Spell Power"] },
	["RESILIENCE_RATING"] = { AL["Resi"], AL["Resilience Rating"] },
	
	["BASE"] = { "base", AL["Base Stats"] },
	["EXTRA"] = { "extra", AL["Extra Stats"] },
}

local SORT_FUNC = {
	--["none"] = ipairs,
	["name"] = function(self, sortBy, tab, revert)
		local a = {}
		for k,v in ipairs(tab) do 
			if type(v) == "string" then
				a[k] = { v, GetItemInfo(tonumber(ITEM_DEATAIL[v][3])) or "" } 
			else
				a[k] = { v, GetItemInfo(v) or "" } 
			end
		end
		if revert then
			table.sort(a, function(x,y) return (x[2] > y[2]) end)
		else
			table.sort(a, function(x,y) return (x[2] < y[2]) end)
		end

		local i = 0
		return function()
			i = i + 1
			return a[i], i
		end
	end,
	["rarity"] = function(self, sortBy, tab, revert)
		local a = {}
		for k,v in ipairs(tab) do 
			if type(v) == "string" then
				a[k] = { v, select(3, GetItemInfo(tonumber(ITEM_DEATAIL[v][3]))) } 
			else
				a[k] = { v, select(3, GetItemInfo(v)) } 
			end
		end
		if revert then
			table.sort(a, function(x,y) return (x[2] > y[2]) end)
		else
			table.sort(a, function(x,y) return (x[2] < y[2]) end)
		end

		local i = 0
		return function()
			i = i + 1
			return a[i], i
		end
	end,
	["slot"] = function(self, sortBy, tab, revert)
		local a = {}
		local slotInfo
		for k,v in ipairs(tab) do 
			if type(v) == "string" then
				slotInfo = select(9, GetItemInfo(ITEM_DEATAIL[v][3])) 
			else
				slotInfo = select(9, GetItemInfo(v)) 
			end
			if not slotInfo or slotInfo == "" then
				slotInfo = 0
			else
				slotInfo = SLOT_LIST[slotInfo]
			end
			
			a[k] = { v, slotInfo or "" } 
		end
		if revert then
			table.sort(a, function(x,y) return (x[2] > y[2]) end)
		else
			table.sort(a, function(x,y) return (x[2] < y[2]) end)
		end

		local i = 0
		return function()
			i = i + 1
			return a[i], i
		end
	end,
	["ITEMLVL"] = function(self, sortBy, tab, revert)
		local a = {}
		local itemLvl
		for k,v in ipairs(tab) do 
			if type(v) == "string" then
				itemLvl = select(4, GetItemInfo(ITEM_DEATAIL[v][3])) 
				a[k] = { v, itemLvl or 0 } 
			else
				itemLvl = select(4, GetItemInfo(v)) 
				a[k] = { v, itemLvl or 0 } 
			end
		end
		if revert then
			table.sort(a, function(x,y) return (x[2] > y[2]) end)
		else
			table.sort(a, function(x,y) return (x[2] < y[2]) end)
		end

		local i = 0
		return function()
			i = i + 1
			return a[i], i
		end
	end,
	["stats"] = function(self, sortBy, tab, revert)
		local a = {}
		for k,v in ipairs(tab) do 
			if type(v) == "string" then
				a[k] = { v, GetItemStats(select(2, GetItemInfo(tonumber(ITEM_DEATAIL[v][3]))),nil)["ITEM_MOD_"..sortBy.."_SHORT"] or 0 } 
			else
				a[k] = { v, GetItemStats(select(2, GetItemInfo(v)),nil)["ITEM_MOD_"..sortBy.."_SHORT"] or 0 } 
			end
		end
		if revert then
			table.sort(a, function(x,y) return (x[2] > y[2]) end)
		else
			table.sort(a, function(x,y) return (x[2] < y[2]) end)
		end

		local i = 0
		return function()
			i = i + 1
			return a[i], i
		end	
	end,
}
for k,v in pairs(STATS_LIST) do
	if k ~= "ITEMLVL" then
		SORT_FUNC[k] = SORT_FUNC["stats"]
	end
end

local STATS_SORT_LIST = {
	["BASE"] = {
		"ITEMLVL",
		"STAMINA",
		"AGILITY",	
		"STRENGTH",
		"INTELLECT",
		"SPIRIT",
	},
	["EXTRA"] = {		
		"CRIT_RATING",
		"DODGE_RATING",	
		"EXPERTISE_RATING",
		"HIT_RATING",
		"HASTE_RATING",
		"MASTERY_RATING",
		"PARRY_RATING",
		"SPELL_POWER",	
		"RESILIENCE_RATING",
	},
	--[[
	["DRUID"] = { "STAMINA", "AGILITY", "INTELLECT", "SPIRIT" },
	["MAGE"] = { "STAMINA", "INTELLECT", "SPIRIT" },
	["PALADIN"] = { "STAMINA", "STRENGTH", "INTELLECT", "SPIRIT" },
	["PRIEST"] = { "STAMINA", "INTELLECT", "SPIRIT" },
	["ROGUE"] = { "STAMINA", "AGILITY", "INTELLECT", "SPIRIT", "STRENGTH", "HASTE_RATING", "PARRY_RATING", "SPELL_POWER" },
	["HUNTER"] = { "STAMINA", "AGILITY" },
	["SHAMAN"] = { "STAMINA", "AGILITY", "INTELLECT", "SPIRIT" },
	["WARLOCK"] = { "STAMINA", "INTELLECT", "SPIRIT" },
	["WARRIOR"] = { "STAMINA", "STRENGTH", "AGILITY" },
	["DEATHKNIGHT"] = { "STAMINA", "STRENGTH", "AGILITY" },
	]]--
}

local CURRENT_SORT = {"none", false}
local CURRENT_SHOWN = nil
local CURRENT_ITEM_LIST_TYPE
-- #####################################################
-- Options
StaticPopupDialogs["ATLASLOOT_COMPAREFRAME_ITEMSTATSERROR"] = {
			preferredIndex = 3,
			text = string.format(AL["You cant set more then %d item stats."], NUM_ITEMS_TO_DISPLAY),
			button1 = OKAY,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
		
local getOptions
do
 	local function getOpt(info)
		return AtlasLoot.db.profile.CompareFrame[info[#info]]
	end
	
	local function setOpt(info, value)
		AtlasLoot.db.profile.CompareFrame[info[#info]] = value
		return AtlasLoot.db.profile.CompareFrame[info[#info]]
	end
	
	local function getColorOpt(info)
		return AtlasLoot.db.profile.CompareFrame.statsColor[info[#info]].r, AtlasLoot.db.profile.CompareFrame.statsColor[info[#info]].g, AtlasLoot.db.profile.CompareFrame.statsColor[info[#info]].b
	end
	
	local function setColorOpt(info, r, g, b)
		AtlasLoot.db.profile.CompareFrame.statsColor[info[#info]] = { r = r, g = g, b = b }
		AtlasLoot:CompareFrame_UpdateColors()
		return AtlasLoot.db.profile.CompareFrame.statsColor[info[#info]].r, AtlasLoot.db.profile.CompareFrame.statsColor[info[#info]].g, AtlasLoot.db.profile.CompareFrame.statsColor[info[#info]].b
	end
	
 	local function getStatOpt(info)
		return AtlasLoot.db.profile.CompareFrame.ownSortLists[ tonumber(info[#info-1]) ][ info[#info] ]
	end
	
	local function setStatOpt(info, value)
		local count
		if value then
			count = 1
		else
			count = 0
		end
		for k,v in pairs(AtlasLoot.db.profile.CompareFrame.ownSortLists[ tonumber(info[#info-1]) ]) do
			if k and v == true and k ~= "sortListName" then
				count = count + 1
			end
		end
		if count > ITEM_LIST_MAX_SORTS then 
			StaticPopup_Show("ATLASLOOT_COMPAREFRAME_ITEMSTATSERROR")
			return 
		end
		
		AtlasLoot.db.profile.CompareFrame.ownSortLists[ tonumber(info[#info-1]) ][info[#info] ] = value
		return AtlasLoot.db.profile.CompareFrame.ownSortLists[ tonumber(info[#info-1]) ][ info[#info] ]
	end
	
	
	local function addStatsList()
		table.insert(AtlasLoot.db.profile.CompareFrame.ownSortLists, {sortListName = "Stats Sort List NEW"})
		AtlasLoot:RefreshModuleOptions()
	end

	local options
	function getOptions()
		if not options then
			options = {
				type = "group",
				name = "CompareFrame",
				order = 600,
				childGroups = "tab",
				args = {}
			}
		end
		
		local orderNumber = 35
		wipe(options.args)
		options.args.showBaseSort = {
			type = "toggle",
			name = AL["Show \"Base Stats list\""],
			get = getOpt,
 			set = setOpt,
			order = 10,
			width = "full",
		}
		options.args.showExtraSort = {
			type = "toggle",
			name = AL["Show \"Extra Stats list\""],
			get = getOpt,
			set = setOpt,
			order = 20,
			width = "full",
		}
		options.args.setupClass = {
			type = "execute",
			name = AL["Add Stats list"],
			--desc = ,
			func = addStatsList,
			order = 30,
		}
		
		options.args.statsColor = {
			type = "group",
			name = AL["Stats color"],
			--desc = ,
			order = 31,
			args = {},
		}
		
		for mainStat, mainStatTab in pairs(STATS_SORT_LIST) do
			if mainStat ~= "SAVED" then 
				orderNumber = orderNumber + 1
				options.args.statsColor.args[mainStat] = { type = "header", name = STATS_LIST[mainStat][2], order = orderNumber }
				for _,stat in ipairs(mainStatTab) do
					orderNumber = orderNumber + 1
					options.args.statsColor.args[stat] = {
						type = "color",
						name = STATS_LIST[stat][2],
						--desc = ,
						--func = addStatsList,
						get = getColorOpt,
						set = setColorOpt,
						order = orderNumber,
					}		
				end
			end
		end
		
		for k,v in ipairs(AtlasLoot.db.profile.CompareFrame.ownSortLists) do
			options.args[tostring(k)] = {
				type = "group",
				name = AtlasLoot.db.profile.CompareFrame.ownSortLists[k].sortListName,
				--desc = ,
				order = orderNumber+k,
				args = {
					sortListName = {
						type = "input",
						name = AL["Stats list name:"],
						--desc = format("Replace 'QuickLook %d' with a new name.", k),
						order = 10,
						get = function(info)
							return AtlasLoot.db.profile.CompareFrame.ownSortLists[k].sortListName
						end,
						set = function(info, value)
							if value:trim() == "" then
								AtlasLoot.db.profile.CompareFrame.ownSortLists[k].sortListName = nil
							else
								AtlasLoot.db.profile.CompareFrame.ownSortLists[k].sortListName = value
							end
							return AtlasLoot.db.profile.CompareFrame.ownSortLists[k].sortListName
						end,
					},
					delete = {
						type = "execute",
						name = AL["Delete Stats list"],
						order = 20,
						confirm = true,
						confirmText = string.format(AL["Are you sure you want to delete Sort list |cff1eff00%s|r?"], AtlasLoot.db.profile.CompareFrame.ownSortLists[k].sortListName),
						func = function(self)
							table.remove(AtlasLoot.db.profile.CompareFrame.ownSortLists, k)
						end,
					},
				},
			}
			local subIndex = 30
			
			for mainStat, mainStatTab in pairs(STATS_SORT_LIST) do
				if mainStat ~= "SAVED" then 
					subIndex = subIndex + 1
					-- Überschrift
					options.args[tostring(k)].args[mainStat] = { type = "header", name = STATS_LIST[mainStat][2], order = subIndex }
					for _,stat in ipairs(mainStatTab) do
						subIndex = subIndex + 1
						options.args[tostring(k)].args[stat] = {
							type = "toggle",
							name = STATS_LIST[stat][2],
							get = getStatOpt,
							set = setStatOpt,
							order = subIndex,
						}
					end
				end
			end
		end
		
		return options
	end
	
end

-- Options
-- #####################################################

--/run AtlasLoot:CompareFrame_Create() AtlasLoot:CompareFrame_LoadInstance("BlackrockCaverns")
function AtlasLoot:CompareFrame_LoadInstance(ini)
	if not ini then return end
	CURRENT_SHOWN = "INI"
	CURRENT_ITEM_LIST_TYPE = "compareframe"
	if not AtlasLoot.CompareFrame then AtlasLoot:CompareFrame_Create() end
	local bossTable, infoTable
	for k,v in pairs(AtlasLoot_LootTableRegister) do
		if v[ini] and v[ini]["Bosses"] then
			bossTable = v[ini]["Bosses"]
			infoTable = v[ini]["Info"]
		end
	end
	LIST_MAINFILTERS = {}
	LIST_SUBFILTERS = {}
	LIST_SUBSUBFILTERS = {}
	LIST_ITEMS = {}
	ITEM_DEATAIL = {}
	NUM_ITEMS_IN_LIST = 0
	
	if bossTable then
		local i = 1
		LIST_MAINFILTERS[i] = infoTable[1]
		LIST_SUBFILTERS[i] = {}
		LIST_SUBSUBFILTERS[i] = {}
		LIST_ITEMS[i] = {}
		for _,boss in ipairs(bossTable) do
			local dataID, instancePage = self:FormatDataID(boss[1])
			if dataID and AtlasLoot_Data[dataID] and not boss.hide then
				local j = #LIST_SUBFILTERS[i] + 1
				LIST_SUBFILTERS[i][j] = AtlasLoot:GetTableInfo(dataID)
				LIST_SUBSUBFILTERS[i][j] = {}
				LIST_ITEMS[i][j] = {}
				for _,ltType in ipairs(lootTableTypes) do
					if AtlasLoot_Data[dataID][ltType] then
						local typNum = #LIST_SUBSUBFILTERS[i][j] + 1
						if ltType == "Normal" then
							LIST_SUBSUBFILTERS[i][j][ typNum ] = AL["Normal"]
						else	
							LIST_SUBSUBFILTERS[i][j][ typNum ] = AtlasLoot:GetLocInstanceType(ltType)
						end
						LIST_ITEMS[i][j][ typNum ] = {}
						for _,v in ipairs(AtlasLoot_Data[dataID][ltType]) do
							if ltType == "Normal" and AtlasLoot:CheckHeroic(v) then
								LIST_ITEMS[i][j][ 2 ] = {}
								LIST_SUBSUBFILTERS[i][j][ 2 ] = AtlasLoot:GetLocInstanceType("Heroic")
								local heroicNum = AtlasLoot:CheckHeroic(v)
								for iNum=1,heroicNum do
									local item = v[iNum]
									if item[2] and item[2] ~= 0 and type(item[2]) == "number" then
										LIST_ITEMS[i][j][ typNum ][ #LIST_ITEMS[i][j][ typNum ] + 1 ] = item[2]
										ITEM_DEATAIL[item[2]] = item
										-- dataId speichern
										ITEM_DEATAIL[item[2]].dataID = dataID
										-- heroic, normal, ...
										ITEM_DEATAIL[item[2]].tableType = ltType
										
										if ltType == "Normal" then
											ITEM_DEATAIL[item[2]].location = string.format("%s - %s", infoTable[1] or "?", LIST_SUBFILTERS[i][j] or "?")
										else
											ITEM_DEATAIL[item[2]].location = string.format("%s - %s ( %s )", infoTable[1] or "?", LIST_SUBFILTERS[i][j] or "?", LIST_SUBSUBFILTERS[i][j][ typNum ] or "?")
										end
										
										NUM_ITEMS_IN_LIST = NUM_ITEMS_IN_LIST + 1
									end
								end
								for iNum=heroicNum,#v do
									local item = v[iNum]
									if item[2] and item[2] ~= 0 and type(item[2]) == "number" then
										LIST_ITEMS[i][j][ 2 ][ #LIST_ITEMS[i][j][ 2 ] + 1 ] = item[2]
										ITEM_DEATAIL[item[2]] = item
										-- dataId speichern
										ITEM_DEATAIL[item[2]].dataID = dataID
										-- heroic, normal, ...
										ITEM_DEATAIL[item[2]].tableType = "Heroic"
										
										ITEM_DEATAIL[item[2]].location = string.format("%s - %s ( %s )", infoTable[1] or "?", LIST_SUBFILTERS[i][j] or "?", AtlasLoot:GetLocInstanceType("Heroic") or "?")

										NUM_ITEMS_IN_LIST = NUM_ITEMS_IN_LIST + 1
									end
								end
							else
								for _,item in ipairs(v) do
									if item[2] and item[2] ~= 0 and type(item[2]) == "number" then
										LIST_ITEMS[i][j][ typNum ][ #LIST_ITEMS[i][j][ typNum ] + 1 ] = item[2]
										ITEM_DEATAIL[item[2]] = item
										-- dataId speichern
										ITEM_DEATAIL[item[2]].dataID = dataID
										-- heroic, normal, ...
										ITEM_DEATAIL[item[2]].tableType = ltType
										NUM_ITEMS_IN_LIST = NUM_ITEMS_IN_LIST + 1
									end
								end
							end
						end
					end
				end
			end
		end
	end
	AtlasLoot:CompareFrame_UpdateMainFilterScrollFrame()
	AtlasLoot.CompareFrame.NumItems:SetText(string.format(AL["%d items"], NUM_ITEMS_IN_LIST))
	AtlasLoot.CompareFrame:Show()
	AtlasLoot:CompareFrame_Filter_OnClick(AtlasLoot.CompareFrame.MainFilterButtons[1])
	
	if infoTable.EncounterJournalID then
		AtlasLoot.CompareFrame.EncounterJournal.info = { infoTable.EncounterJournalID, nil }
		AtlasLoot:EncounterJournal_ButtonsRefresh()
	end
end
--[[
										{
											0, -- [1]
											56442, -- [2]
											"", -- [3]
											"=q3=Cursed Skardyn Vest", -- [4]
											"=ds=#s5#, #a2#", -- [5]
											"GBUmbriss#Heroic", -- [6]
										}, -- [1]
]]--
function AtlasLoot:CompareFrame_Clear()
	LIST_MAINFILTERS = {}
	LIST_SUBFILTERS = {}
	LIST_SUBSUBFILTERS = {}
	LIST_ITEMS = {}
	ITEM_DEATAIL = {}
	NUM_ITEMS_IN_LIST = 0
	
	CURRENT_ITEM_LIST_TYPE = nil
	CURRENT_SHOWN = nil
	
	AtlasLoot:CompareFrame_UpdateMainFilterScrollFrame()
	AtlasLoot.CompareFrame.NumItems:SetText(string.format(AL["%d items"], NUM_ITEMS_IN_LIST))
	AtlasLoot.CompareFrame:Show()
	AtlasLoot:CompareFrame_Filter_OnClick(AtlasLoot.CompareFrame.MainFilterButtons[1])	

	AtlasLoot.CompareFrame.EncounterJournal.info = nil
	AtlasLoot:EncounterJournal_ButtonsRefresh()
end

function AtlasLoot:CompareFrame_CompleteTable(itemCache, allName)
	if itemCache then
		allName = allName or AL["All"]
		local iniIndex = {}
		local i,j,typNum = 0,0,0
		local iAll,jAll,typNumAll = 1,0,1
		
		LIST_MAINFILTERS[1] = allName
		LIST_SUBFILTERS[1] = {}
		LIST_ITEMS[1] = {}
		LIST_SUBSUBFILTERS[1] = {}
		iniIndex["all"] = 1
		
		table.sort(itemCache, function(x,y) return (x[3] < y[3]) end)
		for k,v in ipairs(itemCache) do
			if not iniIndex[v[3]] then
				i = #LIST_MAINFILTERS + 1
				iniIndex[v[3]] = i
				LIST_MAINFILTERS[i] = v[3]
				LIST_SUBFILTERS[i] = {}
				LIST_SUBSUBFILTERS[i] = {}
				LIST_ITEMS[i] = {}
			end
			i = iniIndex[v[3]]
			if not iniIndex[v[1]] then
				if not LIST_SUBFILTERS[i] then LIST_SUBFILTERS[i] = {} end
				if not LIST_SUBSUBFILTERS[i] then LIST_SUBSUBFILTERS[i] = {} end
				if not LIST_ITEMS[i] then LIST_ITEMS[i] = {} end
				j = #LIST_SUBFILTERS[i] + 1
				iniIndex[v[1]] = j
				LIST_SUBFILTERS[i][j] = AtlasLoot:GetTableInfo(v[1])
				LIST_SUBSUBFILTERS[i][j] = {}
				LIST_ITEMS[i][j] = {}
			end
			j = iniIndex[v[1]]
			if not iniIndex[v[1]..v[2]] then
				if not LIST_SUBSUBFILTERS[i][j] then LIST_SUBSUBFILTERS[i][j] = {} end
				if not LIST_ITEMS[i][j] then LIST_ITEMS[i][j] = {} end
				typNum = #LIST_SUBSUBFILTERS[i][j] + 1
				iniIndex[v[1]..v[2]] = typNum
				if v[2] == "Normal" then
					LIST_SUBSUBFILTERS[i][j][ typNum ] = AL["Normal"]
				else	
					LIST_SUBSUBFILTERS[i][j][ typNum ] = AtlasLoot:GetLocInstanceType(v[2])
				end
				LIST_ITEMS[i][j][ typNum ] = {}
			end
			typNum = iniIndex[v[1]..v[2]]
			
			if not iniIndex["all"..v[2]] then
				jAll = #LIST_SUBFILTERS[iAll] + 1
				iniIndex["all"..v[2]] = jAll
				if v[2] == "Normal" then
					LIST_SUBFILTERS[iAll][jAll] = AL["Normal"]
				else	
					LIST_SUBFILTERS[iAll][jAll] = AtlasLoot:GetLocInstanceType(v[2])
				end
				LIST_ITEMS[iAll][jAll] = {}
				LIST_ITEMS[iAll][jAll][typNumAll] = {}
				LIST_SUBSUBFILTERS[iAll][jAll] = {}
				LIST_SUBSUBFILTERS[iAll][jAll][typNumAll] = ""
			end
			jAll = iniIndex["all"..v[2]]
			
			LIST_ITEMS[i][j][ typNum ][ #LIST_ITEMS[i][j][ typNum ] + 1 ] = v.item[2]
			ITEM_DEATAIL[v.item[2]] = v.item
			-- dataId speichern
			ITEM_DEATAIL[v.item[2]].dataID = v[1]
			-- heroic, normal, ...
			ITEM_DEATAIL[v.item[2]].tableType = v[2]
			-- location
			if v[2]== "Normal" then
				ITEM_DEATAIL[v.item[2]].location = string.format("%s - %s", v[3] or "?", AtlasLoot:GetTableInfo(v[1] or "?"))
				--ITEM_DEATAIL[item[2]].location = v[3].." - "..AtlasLoot:GetTableInfo(v[1])
			else
				ITEM_DEATAIL[v.item[2]].location = string.format("%s - %s ( %s )", v[3] or "?", AtlasLoot:GetTableInfo(v[1]) or "?", AtlasLoot:GetLocInstanceType(v[2]) or "?")
				--ITEM_DEATAIL[item[2]].location = v[3].." - "..AtlasLoot:GetTableInfo(v[1]).." ( "..LIST_SUBSUBFILTERS[i][j][ v.tableType ].." )"
			end
			
			LIST_ITEMS[iAll][jAll][typNumAll][ #LIST_ITEMS[iAll][jAll][typNumAll] + 1 ] = v.item[2]
			
			NUM_ITEMS_IN_LIST = NUM_ITEMS_IN_LIST + 1
		end
		-- Update item count
		local count = 0
		for iniNum,ini in ipairs(LIST_MAINFILTERS) do
			count = 0
			for bossNum,boss in ipairs(LIST_ITEMS[iniNum]) do
				for typeNum, ltType in ipairs(boss) do
					count = count + #ltType
				end
			end
			LIST_MAINFILTERS[iniNum] = string.format("%s (%d)", ini, count)
		end
		
		--AtlasLoot:CompareFrame_CleanUpTable()
		AtlasLoot:CompareFrame_UpdateMainFilterScrollFrame()
		AtlasLoot.CompareFrame.NumItems:SetText(string.format(AL["%d items"], NUM_ITEMS_IN_LIST))
		AtlasLoot.CompareFrame:Show()
		AtlasLoot:CompareFrame_Filter_OnClick(AtlasLoot.CompareFrame.MainFilterButtons[1])	
		itemCache = nil
	end
end

-- #####################################################
-- Search

function AtlasLoot:CompareFrame_Search(text, modulesToSearch)
	if not text then 
		AtlasLoot:CompareFrame_Clear()
		return 
	end
	AtlasLoot.CompareFrame.SearchFrame.SearchBox:SetText(text)
	if not AtlasLoot.CompareFrame then AtlasLoot:CompareFrame_Create() end
	modulesToSearch = modulesToSearch or "all"
	
	text = strtrim(text);
	if text == "" then return end
	CURRENT_SHOWN = "SEARCH"
	CURRENT_ITEM_LIST_TYPE = "compareframe"

	AtlasLoot.db.profile.LastSearch = text
	--/run AtlasLoot:CompareFrame_Search("test", {"AtlasLootCataclysm"})

	local searchModules = {}
	if modulesToSearch == "all" then
		AtlasLoot:LoadModule("all")
	elseif modulesToSearch == "save" then
		--AtlasLoot.db.profile.SearchModule
		if AtlasLoot.Modules then
			for k,v in ipairs(AtlasLoot.Modules) do
				if AtlasLoot.db.profile.SearchModule[ v[1] ] then
					searchModules[v[1]] = true
					AtlasLoot:LoadModule(v[1])
				end
			end
		end
	elseif type(modulesToSearch) == "table" then
		for k,v in pairs(modulesToSearch) do
			if type(k) == "string" and v == true then
				searchModules[k] = true
				AtlasLoot:LoadModule(k)
			elseif type(k) == "number" and type(v) == "string" then
				searchModules[v] = true
				AtlasLoot:LoadModule(v)
			end
		end
	end
	
	LIST_MAINFILTERS = {}
	LIST_SUBFILTERS = {}
	LIST_SUBSUBFILTERS = {}
	LIST_ITEMS = {}
	ITEM_DEATAIL = {}
	NUM_ITEMS_IN_LIST = 0
	
	local textNew = string.lower(text);
	text = gsub(text, "-", "")
	
	local itemName, found, itemCache, heroicCheckNumber, iniName = nil, false, {}, nil, nil
	for dataID, data in pairs(AtlasLoot_Data) do
		if ( data and data.info and data.info.module and searchModules[data.info.module] ) or modulesToSearch == "all" then
			-- Heroic, Normal, ...
			for _,tableType in ipairs(lootTableTypes) do
				-- Nicht auf ignore und exestiert data = AtlasLoot_Data[dataID]
				if data[tableType] and not AtlasLoot.IgnoreList[dataID] then
					-- ItemListe durchsuchen
					for _,itemTable in ipairs(data[tableType]) do
						for itemNum,item in ipairs(itemTable) do
							-- Sicher gehn ob eintrag 2 itemID und nicht spell
							if type(item[2]) == "number" and item[2] > 0 then
								itemName = GetItemInfo(item[2]);
								if not itemName then 
									itemName = gsub(item[4], "=q%d=", "") 
								end
								-- entferne - wegen such problemen -.-
								itemName = gsub(itemName, "-", "")
								-- durchsuchen
								found = string.find(string.lower(itemName), textNew)
								-- wenn gefunden
								if found then
									_, iniName = AtlasLoot:GetTableInfo(dataID)
									heroicCheckNumber = AtlasLoot:CheckHeroic(itemTable)
									if heroicCheckNumber and heroicCheckNumber < itemNum then
										tableType = "Heroic"
									end
									table.insert(itemCache, { dataID, tableType, iniName, item = item })
									-- sicherstellen, dass nächstes item wirklich neu durchsucht wird
									found = false
								end	
							end
						end
					end
				end
			end
		end
	end

	
	if #itemCache <= 0 then
		DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..WHITE..AL["No match found for"].." \""..text.."\".");
	else
		AtlasLoot:CompareFrame_CompleteTable(itemCache)
	end

	itemCache = nil
	collectgarbage("collect")
	
end

-- Search
-- #####################################################

-- ###########################################
-- Wishlist
StaticPopupDialogs["ATLASLOOT_COMPAREFRAME_WLITEMERROR"] = {
	text = AL["AtlasLoot has detected some corrupted items on your Wishlist. You can now run an automatic check to fix it. Please be aware that this could take a few moments."],
	button1 = AL["OK"],
	button2 = AL["Cancel"],
	OnAccept = function()
		if lastWishList then
			AtlasLoot:Wishlist_FixWishlist(lastWishList)
			AtlasLoot:OpenWishlist(lastWishList)
		end
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};
		
local function GetItemPrice(dataID, tableType, itemID )
	if not itemID then return end
	if tableType and dataID and AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID][tableType] then
		for tabIndex, tab in ipairs(AtlasLoot_Data[dataID][tableType]) do
			for itemIndex, item in ipairs(tab) do
				if tonumber(item[2]) == itemID or tonumber(item[3]) == itemID then
					return item[6]
				end
			end
		end
	end
	return nil
end

function AtlasLoot:CompareFrame_LoadWishList(itemTab, wishlistID, wishlistName, refresh)
	if refresh then
		if refresh ~= CURRENT_SHOWN then
			return
		end
	else
		CURRENT_SHOWN = wishlistID
	end

	if not itemTab or #itemTab <= 0 then 
		AtlasLoot:CompareFrame_Clear()
		return 
	end
	lastWishList = wishlistID
	CURRENT_ITEM_LIST_TYPE = "wishlist"
	LIST_MAINFILTERS = {}
	LIST_SUBFILTERS = {}
	LIST_SUBSUBFILTERS = {}
	LIST_ITEMS = {}
	NUM_ITEMS_IN_LIST = 0
	local itemCache = {}
	
	--[[{ 0, itemID, spellID, itemName, extraText, dataID }
	{
											0, -- [1]
											56442, -- [2]
											"", -- [3]
											"=q3=Cursed Skardyn Vest", -- [4]
											"=ds=#s5#, #a2#", -- [5]
											"GBUmbriss#Heroic", -- [6]
										}]]--
	--{ 2, 58155, "", "=q3=Cowl of Pleasant Gloom", "=ds=#s1#, #a1#", "#JUSTICE:2200#" },
	
	local tableType, dataID, iniName
	for itemNum,item in ipairs(itemTab) do
		if type(item[3]) == "number" then
			dataID = AtlasLoot:FormatDataID(item[6])
			tableType = AtlasLoot:GetLootTableTypeFromDataID(item[6])
			_, iniName = AtlasLoot:GetTableInfo(dataID)
			
			if dataID and tableType and iniName then
				table.insert(itemCache, { dataID, tableType, iniName, item = { 0, "s"..item[3], item[2], item[4], item[5], GetItemPrice(dataID,tableType,item[2])} })
			else
				StaticPopup_Show("ATLASLOOT_COMPAREFRAME_WLITEMERROR")
				return
				-- Verbugtes item
				--table.remove(itemTab, itemNum)
				--return AtlasLoot:CompareFrame_LoadWishList(itemTab, wishlistID, wishlistName, refresh)
			end 	
		else
			dataID = AtlasLoot:FormatDataID(item[6])
			tableType = AtlasLoot:GetLootTableTypeFromDataID(item[6])
			_, iniName = AtlasLoot:GetTableInfo(dataID)
			
			if dataID and tableType and iniName then
				table.insert(itemCache, { dataID, tableType, iniName, item = { 0, item[2], "", item[4], item[5], GetItemPrice(dataID,tableType,item[2])} })
			else
				StaticPopup_Show("ATLASLOOT_COMPAREFRAME_WLITEMERROR")
				return
				-- Verbugtes item
				--table.remove(itemTab, itemNum)
				--return AtlasLoot:CompareFrame_LoadWishList(itemTab, wishlistID, wishlistName, refresh)
			end 
		end
	end
	local frameWasShown = AtlasLoot.CompareFrame:IsShown()
	AtlasLoot:CompareFrame_CompleteTable(itemCache, wishlistName)
	if refresh and frameWasShown then
		
	elseif refresh and not frameWasShown then
		AtlasLoot.CompareFrame:Hide()
	end	
	AtlasLoot.CompareFrame.EncounterJournal.info = nil
	AtlasLoot:EncounterJournal_ButtonsRefresh()
end	

--function AtlasLoot:CompareFrame_WishlistSelect_UpdateList()
	
--end
-- Wishlist
-- ############################################

-- #####################################################
-- Itemlist Sort
local function SortItems(itemTable, sortBy, revert)
	local itemIDs = {}
	local k,v
	if sortBy == "none" then
		return itemTable
	end
	for v,k in SORT_FUNC[sortBy](SORT_FUNC, sortBy, itemTable, revert) do
		itemIDs[k] = v[1]
	end
	return itemIDs
end
-- Itemlist Sort
-- #####################################################

-- #####################################################
-- Main(Sub) Filter

local function MainFilterButton_SetType(button, type, text, isLast)
	local normalText = _G[button:GetName().."NormalText"];
	local normalTexture = _G[button:GetName().."NormalTexture"];
	local line = _G[button:GetName().."Lines"];
	if ( type == "main" ) then
		button:SetText(text);
		normalText:SetPoint("LEFT", button, "LEFT", 4, 0);
		normalTexture:SetAlpha(1.0);	
		line:Hide();
	elseif ( type == "sub" ) then
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
		normalText:SetPoint("LEFT", button, "LEFT", 12, 0);
		normalTexture:SetAlpha(0.4);
		line:Hide();
	elseif ( type == "subsub" ) then
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
		normalText:SetPoint("LEFT", button, "LEFT", 20, 0);
		normalTexture:SetAlpha(0.0);	
		if ( isLast ) then
			line:SetTexCoord(0.4375, 0.875, 0, 0.625);
		else
			line:SetTexCoord(0, 0.4375, 0, 0.625);
		end
		line:Show();
	end
	button.type = type; 
end

function AtlasLoot:CompareFrame_UpdateMainFilterScrollFrame()
	AtlasLoot:CompareFrame_UpdateMainFilterList()

	FauxScrollFrame_Update(AtlasLootCompareFrame_ScrollFrameMainFilter, getn(OPEN_MAINFILTER_LIST), 15, 20);
end

function AtlasLoot:CompareFrame_UpdateMainFilterList()
	OPEN_MAINFILTER_LIST = {}
	
	for i=1, getn(LIST_MAINFILTERS) do
		if ( AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClass and AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClass == LIST_MAINFILTERS[i] ) then
			tinsert(OPEN_MAINFILTER_LIST, {LIST_MAINFILTERS[i], "main", i, 1});
			AtlasLoot:CompareFrame_UpdateSubFilterList(i);
		else
			tinsert(OPEN_MAINFILTER_LIST, {LIST_MAINFILTERS[i], "main", i, nil});
		end
	end
	
	-- Display the list of open filters
	local button, index, info, isLast;
	local offset = FauxScrollFrame_GetOffset(AtlasLootCompareFrame_ScrollFrameMainFilter);
	index = offset;
	for i=1, NUM_MAINFILTERS_TO_DISPLAY do
		button = _G[FRAME_NAME.."MainFilterButton"..i];
		if ( getn(OPEN_MAINFILTER_LIST) > NUM_MAINFILTERS_TO_DISPLAY ) then
			button:SetWidth(136);
		else
			button:SetWidth(156);
		end

		index = index + 1;
		if ( index <= getn(OPEN_MAINFILTER_LIST) ) then
			info = OPEN_MAINFILTER_LIST[index];
			while ((info[2] == "invtype") and (not info[6])) do
				index = index + 1
				if ( index <= getn(OPEN_MAINFILTER_LIST) ) then
					info = OPEN_MAINFILTER_LIST[index];
				else
					info = nil;
					button:Hide();
					break;
				end
			end

			if ( info ) then
				MainFilterButton_SetType(button, info[2], info[1], info[5]);
				button.index = info[3];
				if ( info[4] ) then
					button:LockHighlight();
				else
					button:UnlockHighlight();
				end
				button:Show();
			end
		else
			button:Hide();
		end
	end
end

function AtlasLoot:CompareFrame_UpdateSubFilterList(index)
	local subClass;
	for i=1, #LIST_SUBFILTERS[index] do
		subClass = HIGHLIGHT_FONT_COLOR_CODE..LIST_SUBFILTERS[index][i]..FONT_COLOR_CODE_CLOSE; 
		if ( AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass and AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass == subClass ) then
			tinsert(OPEN_MAINFILTER_LIST, {LIST_SUBFILTERS[index][i], "sub", i, 1});
			if LIST_SUBSUBFILTERS[index][i] and #LIST_SUBSUBFILTERS[index][i] > 1 then
				AtlasLoot:CompareFrame_UpdateSubSubFilterList(index, i);
			end
		else
			tinsert(OPEN_MAINFILTER_LIST, {LIST_SUBFILTERS[index][i], "sub", i, nil});
		end
	end
end

function AtlasLoot:CompareFrame_UpdateSubSubFilterList(index, subIndex)
	local invType, isLast, idx;
	for i=1, #LIST_SUBSUBFILTERS[index][subIndex] do
-- each type has 2 args: token name(i), display in list(i+1)
		idx = i
		invType = HIGHLIGHT_FONT_COLOR_CODE..LIST_SUBSUBFILTERS[index][subIndex][i]..FONT_COLOR_CODE_CLOSE; 
		if ( (i + 1) == LIST_SUBSUBFILTERS[index][subIndex][i] ) then
			isLast = 1;
		end

		if ( AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex and AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex == idx ) then
			tinsert(OPEN_MAINFILTER_LIST, {invType, "subsub", idx, 1, isLast, LIST_SUBSUBFILTERS[index][subIndex][i] } );
		else
			tinsert(OPEN_MAINFILTER_LIST, {invType, "subsub", idx, nil, isLast, LIST_SUBSUBFILTERS[index][subIndex][i] } );
		end
	end
end

function AtlasLoot:CompareFrame_Filter_OnClick(self, button)
	if ( self.type == "main" ) then
		if ( AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClass == self:GetText() ) then
			AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClass = nil;
			AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex = nil;
		else
			AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClass = self:GetText();
			AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex = self.index;
		end
		AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass = nil;
		AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = nil;
		AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtype = nil;
		AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = nil;
	elseif ( self.type == "sub" ) then
		if ( AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass == self:GetText() ) then
			AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass = nil;
			AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = nil;
		else
			AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass = self:GetText();
			AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = self.index;
		end
		AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtype = nil;
		AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = nil;
	elseif ( self.type == "subsub" ) then
		AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtype = self:GetText();
		AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = self.index;
	end
	AtlasLoot:CompareFrame_UpdateItemListScrollFrame("RESORT", true)
	AtlasLoot:CompareFrame_UpdateMainFilterScrollFrame()
end

function AtlasLoot:CompareFrame_Filter_OnEnter(self, button)
	if self:GetText() then
		--GameTooltip:Hide()
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 5);
		GameTooltip:AddLine(self:GetText())
		GameTooltip:Show()	
	end
end

-- Main Filter
-- #####################################################

-- #####################################################
-- ItemList

function AtlasLoot:CompareFrame_RemoveItemFromList(itemID, listID)
	if not listID or listID == CURRENT_SHOWN then
		if itemID and ITEM_DEATAIL[itemID] then
			ITEM_DEATAIL[itemID] = "REMOVED"
			NUM_ITEMS_IN_LIST = NUM_ITEMS_IN_LIST - 1
			if NUM_ITEMS_IN_LIST == 0 then 
				AtlasLoot:CompareFrame_Clear()
			else
				AtlasLoot:CompareFrame_CleanUpTable()
				AtlasLoot.CompareFrame.NumItems:SetText(string.format(AL["%d items"], NUM_ITEMS_IN_LIST))
			end
		end
	end
end

function AtlasLoot:CompareFrame_CleanUpTable()
	-- alle items und spalten die gemarkt sind entfernen 
	local mainNum, subNum, subsubNum, itemNum, item, k, v
	local remove = {}
		
	for mainNum in ipairs(LIST_MAINFILTERS) do
		for subNum in ipairs(LIST_SUBFILTERS[mainNum]) do
			for subsubNum in ipairs(LIST_SUBSUBFILTERS[mainNum][subNum]) do
				for itemNum, itemID in ipairs(LIST_ITEMS[mainNum][subNum][subsubNum]) do
					if ITEM_DEATAIL[itemID] == "REMOVED" then
						--table.remove(LIST_ITEMS[mainNum][subNum][subsubNum], itemNum)
						table.insert(remove, {mainNum, subNum, subsubNum, itemNum })
					end
				end
			end
		end
	end
	--local curMainFilter = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex
	--local curSubFilter = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex
	--local curSubSubFilter = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex
	for k,v in ipairs(remove) do
		if #v == 4 then
			table.remove(LIST_ITEMS[v[1]][v[2]][v[3]], v[4])
			if #LIST_ITEMS[v[1]][v[2]][v[3]] <= 0 then
				
				table.remove(LIST_ITEMS[v[1]][v[2]], v[3])
				table.remove(LIST_SUBSUBFILTERS[v[1]][v[2]], v[3])
			end
			if #LIST_ITEMS[v[1]][v[2]] <= 0 then
				table.remove(LIST_ITEMS[v[1]], v[2])
				table.remove(LIST_SUBFILTERS[v[1]], v[2])
				table.remove(LIST_SUBSUBFILTERS[v[1]], v[2])
			end
			if #LIST_ITEMS[v[1]] <= 0 then
				table.remove(LIST_MAINFILTERS, v[1])
			end
			
			if AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex == v[1] and not LIST_ITEMS[v[1]] then
				if ( v[1] - 1 ) > 0 and #LIST_ITEMS[v[1] - 1] then
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex = v[1] - 1
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = nil
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = nil
				else
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex = nil
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = nil
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = nil
				end
			elseif AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex == v[2] and not LIST_ITEMS[v[1]][v[2]] then
				if ( v[2] - 1 ) > 0 and #LIST_ITEMS[v[1]][v[2]-1] then
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex = v[1]
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = v[2] - 1
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = nil
				else
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex = v[1]
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = nil
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = nil
				end
			elseif AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex == v[3] and not LIST_ITEMS[v[1]][v[2]][v[3]] then
				if ( v[3] - 1 ) > 0 and #LIST_ITEMS[v[1]][v[2]][v[3]-1] then
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex = v[1]
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = v[2]
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = v[3] - 1
				else
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex = v[1]
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex = v[2]
					AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex = nil
				end
			end
		end
	end
	if #LIST_ITEMS <= 0 then
			return AtlasLoot:CompareFrame_Clear()	
	end
	AtlasLoot:CompareFrame_UpdateMainFilterScrollFrame()
	AtlasLoot:CompareFrame_UpdateItemListScrollFrame("RESORT", true)
end

local lastListInfo = {}
local saved_ItemList = {}
function AtlasLoot:CompareFrame_UpdateItemListScrollFrame(sortBy, refresh)
	sortBy = sortBy or "none"
	if sortBy ~= "SKIP" and sortBy ~= "RESORT" then
		if CURRENT_SORT[1] == sortBy then
			CURRENT_SORT[2] = not CURRENT_SORT[2]
		else
			CURRENT_SORT[1] = sortBy
			CURRENT_SORT[2] = false
		end
	end
	
	local offset = FauxScrollFrame_GetOffset(AtlasLootCompareFrame_ScrollFrameItemFrame)
	local index, button;
	local curMainFilter = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClassIndex
	local curSubFilter = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclassIndex
	local curSubSubFilter = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtypeIndex
	local numItems = 0
	local itemSave = {}
	local itemIDs_temp = nil
	
	if refresh or ( AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClass and lastListInfo[1] ~= AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClass ) or ( AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass and lastListInfo[2] ~= AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass ) or ( AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtype and lastListInfo[3] ~= AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtype ) then
		lastListInfo[1] = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedClass
		lastListInfo[2] = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedSubclass
		lastListInfo[3] = AtlasLootCompareFrame_ScrollFrameMainFilter.selectedInvtype
		itemIDs_temp = {}
		
		if curMainFilter then
			if curSubFilter then
				if curSubSubFilter then
				if AtlasLoot:FilterGetEnabled() then
					for k,v in ipairs(LIST_ITEMS[curMainFilter][curSubFilter][curSubSubFilter]) do
						if ITEM_DEATAIL[v] ~= "REMOVED" and AtlasLoot:FilterItemByItemTable(ITEM_DEATAIL[v]) then
							itemIDs_temp[#itemIDs_temp + 1] = v
						end
					end
				else
					for k,v in ipairs(LIST_ITEMS[curMainFilter][curSubFilter][curSubSubFilter]) do
						if ITEM_DEATAIL[v] ~= "REMOVED" then
							itemIDs_temp[#itemIDs_temp + 1] = v
						end
					end
					--itemIDs_temp = LIST_ITEMS[curMainFilter][curSubFilter][curSubSubFilter]
				end
				else
					for k,v in ipairs(LIST_ITEMS[curMainFilter][curSubFilter]) do
						for _,item in ipairs(v) do
							if ITEM_DEATAIL[item] ~= "REMOVED" then
								if not itemSave[item] and ( ( AtlasLoot:FilterGetEnabled() and AtlasLoot:FilterItemByItemTable(ITEM_DEATAIL[item]) ) or not AtlasLoot:FilterGetEnabled() ) then
									itemSave[item] = true
									AtlasLootTooltip:SetHyperlink("item:"..item..":0:0:0:0:0:0:0")
									itemIDs_temp[#itemIDs_temp+1] = item
								end
							end
						end
					end
				end
			else
				if not LIST_ITEMS[curMainFilter] then
					return AtlasLoot:CompareFrame_Clear()
				end
				for k,v in  ipairs(LIST_ITEMS[curMainFilter]) do
					for _,itemList in ipairs(v) do
						for _,item in ipairs(itemList) do
							if ITEM_DEATAIL[item] ~= "REMOVED" then
								if not itemSave[item] and ( ( AtlasLoot:FilterGetEnabled() and AtlasLoot:FilterItemByItemTable(ITEM_DEATAIL[item]) ) or not AtlasLoot:FilterGetEnabled() ) then
									itemSave[item] = true
									AtlasLootTooltip:SetHyperlink("item:"..item..":0:0:0:0:0:0:0")
									itemIDs_temp[#itemIDs_temp+1] = item
								end
							end
						end
					end
				end
			end
			itemSave = nil
		end
		for i=1,8 do
			_G[FRAME_NAME.."_ScrollFrameItemFrame_Item"..i]:Hide()
		end
	end
	if sortBy ~= "SKIP" or sortBy == "RESORT" then
		--wipe(saved_ItemList)
		if itemIDs_temp then
			saved_ItemList = SortItems(itemIDs_temp, CURRENT_SORT[1],CURRENT_SORT[2])
		else
			saved_ItemList = SortItems(saved_ItemList, CURRENT_SORT[1],CURRENT_SORT[2])
		end
		AtlasLoot:CFSortButton_UpdateArrows()
	end
	
	numItems = #saved_ItemList
	
	if numItems > 0 then
		for i=1,NUM_ITEMS_TO_DISPLAY do
				index = offset + i
				button = _G[FRAME_NAME.."_ScrollFrameItemFrame_Item"..i];
				button = button
				
			if i <= numItems then
				button:Show();
				
				buttonName = FRAME_NAME.."_ScrollFrameItemFrame_Item"..i
				
				if CURRENT_ITEM_LIST_TYPE and ITEM_DEATAIL and saved_ItemList and saved_ItemList[index] and ITEM_DEATAIL[saved_ItemList[index]] then
					button.par:SetItemType({CURRENT_ITEM_LIST_TYPE, ITEM_DEATAIL[saved_ItemList[index]].dataID, ITEM_DEATAIL[saved_ItemList[index]].tableType, CURRENT_SHOWN})
				else
					button.par:SetItemType({CURRENT_ITEM_LIST_TYPE, nil, nil, CURRENT_SHOWN})
				end
				
				-- Resize button if there isn't a scrollbar
				buttonHighlight = _G[FRAME_NAME.."_ScrollFrameItemFrame_Item"..i.."_Highlight"];
				if ( numItems < NUM_ITEMS_TO_DISPLAY ) or ( numItems == NUM_ITEMS_TO_DISPLAY and numItems <= NUM_ITEMS_TO_DISPLAY ) then
					button:SetWidth(625);
					buttonHighlight:SetWidth(589);
					AtlasLoot:CompareFrame_SetStatsSortListWidth(625)
				else
					button:SetWidth(597);
					buttonHighlight:SetWidth(562);
					AtlasLoot:CompareFrame_SetStatsSortListWidth(597)
				end
				--ITEM_DEATAIL		
				--AltasLootItemButton:SetItem(itemID, itemName, extraText, itemTexture, itemPrice, itemDroprate)
				--AltasLootItemButton:SetSpell(spellID, itemID, spellName, extraText, spellTexture, itemPrice)
				--{ 2, 58155, "", "=q3=Cowl of Pleasant Gloom", "=ds=#s1#, #a1#", "#JUSTICE:2200#" },
				if ITEM_DEATAIL[saved_ItemList[index]] then
					if type(saved_ItemList[index]) == "string" then
						local _,_,spellID = string.find(ITEM_DEATAIL[saved_ItemList[index]][2], "s(%d+)")
						if spellID then
							button.par:SetSpell(tonumber(spellID), tonumber(ITEM_DEATAIL[saved_ItemList[index]][3]), ITEM_DEATAIL[saved_ItemList[index]][4], ITEM_DEATAIL[saved_ItemList[index]][5], nil, ITEM_DEATAIL[saved_ItemList[index]][6])
						end
					else
--
						button.par:SetItem(saved_ItemList[index], ITEM_DEATAIL[saved_ItemList[index]][4], ITEM_DEATAIL[saved_ItemList[index]][5], nil, ITEM_DEATAIL[saved_ItemList[index]][6], nil, ITEM_DEATAIL[saved_ItemList[index]].location)
					end
				else
					button.par:SetItem(saved_ItemList[index])
				end
				--dataID tableType{CURRENT_ITEM_LIST_TYPE, ITEM_DEATAIL[saved_ItemList[index]].dataID, ITEM_DEATAIL[saved_ItemList[index]].tableType}
				--button.par:SetItemType({CURRENT_ITEM_LIST_TYPE, ITEM_DEATAIL[saved_ItemList[index]].dataID, ITEM_DEATAIL[saved_ItemList[index]].tableType})
			else
				button.par:Clear()
				button:Hide()
			end
		end
	else
		AtlasLoot:CompareFrame_SetStatsSortListWidth(625)
	end
	
	FauxScrollFrame_Update(AtlasLootCompareFrame_ScrollFrameItemFrame, numItems, NUM_ITEMS_TO_DISPLAY, 37);
end

-- ItemList
-- #####################################################

local function onVerticalScrollMainFilter(self, offset)
	FauxScrollFrame_OnVerticalScroll(self, offset, 20, AtlasLoot.CompareFrame_UpdateMainFilterScrollFrame)
end

local function onVerticalScrollItemFrame(self, offset)
	FauxScrollFrame_OnVerticalScroll(self, offset, 37, function() AtlasLoot:CompareFrame_UpdateItemListScrollFrame("SKIP") end)
end

local function onEnterSortButton(self)
	if self.SortType and STATS_LIST[self.SortType] then
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 5);
		GameTooltip:AddLine(STATS_LIST[self.SortType][2]);
		GameTooltip:Show();
	end
end

local function onLeaveSortButton(self)
	if(GameTooltip:IsVisible()) then
		GameTooltip:Hide();
	end
end

-- SortButton functions
function AtlasLoot:CFSortButton_UpdateArrows()
	for k,v in ipairs(AtlasLoot.CompareFrame.SortButtons) do
		if v.SortType == CURRENT_SORT[1] then
			if CURRENT_SORT[2] then
				_G[v:GetName().."Arrow"]:Show();
				_G[v:GetName().."Arrow"]:SetTexCoord(0, 0.5625, 1.0, 0);
			else
				_G[v:GetName().."Arrow"]:Show();
				_G[v:GetName().."Arrow"]:SetTexCoord(0, 0.5625, 0, 1.0);
			end
		else
			-- hide sort arrows for non-primary column
			_G[v:GetName().."Arrow"]:Hide();
		end
	end
end

function AtlasLoot:CFSortButtonOnClick(self)
	AtlasLoot:CompareFrame_UpdateItemListScrollFrame(self.SortType)
end

function AtlasLoot:CompareFrame_UpdateColors()
	for k in ipairs(AtlasLoot.CompareFrame.ItemButtons) do
		AtlasLoot.CompareFrame.ItemButtons[k]:UpdateStatsColor()
	end
	for i=3,#AtlasLoot.CompareFrame.SortButtons do
		if AtlasLoot.CompareFrame.SortButtons[i] and AtlasLoot.CompareFrame.SortButtons[i].SortType then
			if AtlasLoot.db.profile.CompareFrame.statsColor[ AtlasLoot.CompareFrame.SortButtons[i].SortType ] then
				local db = AtlasLoot.db.profile.CompareFrame.statsColor[ AtlasLoot.CompareFrame.SortButtons[i].SortType ]
				AtlasLoot.CompareFrame.SortButtons[i].font:SetTextColor(db.r, db.g, db.b)
			end
		end
	end
end

-- #####################################################
-- Stats sort list

function AtlasLoot:CompareFrame_SetStatsSortList(sortList)
	if not sortList or type(sortList) == "string" then
		AtlasLoot.db.profile.CompareFrame.lastSortType = sortList or "BASE"
		sortList = AtlasLoot:CompareFrame_GetStatsSortList()
	end
	
	
	for i=3,#AtlasLoot.CompareFrame.SortButtons do
		AtlasLoot.CompareFrame.SortButtons[i].SortType = nil
		AtlasLoot.CompareFrame.SortButtons[i]:Hide()
	end
	
	for k,v in ipairs(sortList) do
		if AtlasLoot.CompareFrame.SortButtons[k+2] then
			AtlasLoot.CompareFrame.SortButtons[k+2].SortType = v
			AtlasLoot.CompareFrame.SortButtons[k+2]:SetText(STATS_LIST[v][1])
			AtlasLoot.CompareFrame.SortButtons[k+2]:Show()
		else
			AtlasLoot.CompareFrame.SortButtons[k+2] = CreateFrame("BUTTON", FRAME_NAME.."SortButton_"..k, AtlasLoot.CompareFrame, "AtlasLootCFSortButtonTemplate")
			AtlasLoot.CompareFrame.SortButtons[k+2]:SetPoint("LEFT", AtlasLoot.CompareFrame.SortButtons[k+2-1], "RIGHT", -2, 0)
			AtlasLoot.CompareFrame.SortButtons[k+2]:SetWidth(100)
			AtlasLoot.CompareFrame.SortButtons[k+2]:SetHeight(19)
			AtlasLoot.CompareFrame.SortButtons[k+2]:SetText(STATS_LIST[v][1])
			AtlasLoot.CompareFrame.SortButtons[k+2]:SetScript("OnEnter", onEnterSortButton)
			AtlasLoot.CompareFrame.SortButtons[k+2]:SetScript("OnLeave", onLeaveSortButton)
			AtlasLoot.CompareFrame.SortButtons[k+2].SortType = v	
			AtlasLoot.CompareFrame.SortButtons[k+2].font = _G[FRAME_NAME.."SortButton_"..k.."Text"]
		end
	end
	
	for k in ipairs(AtlasLoot.CompareFrame.ItemButtons) do
		AtlasLoot.CompareFrame.ItemButtons[k]:UpdateStatsList(sortList, true)
	end
	AtlasLoot:CompareFrame_SetStatsSortListWidth(true)
	AtlasLoot:CFSortButton_UpdateArrows()
	
end

function AtlasLoot:CompareFrame_GetStatsSortList()
	if STATS_SORT_LIST[ AtlasLoot.db.profile.CompareFrame.lastSortType ] then
		return STATS_SORT_LIST[ AtlasLoot.db.profile.CompareFrame.lastSortType ]
	elseif AtlasLoot.db.profile.CompareFrame.ownSortLists[ AtlasLoot.db.profile.CompareFrame.lastSortType ] then
		if STATS_SORT_LIST["SAVED"] then
			wipe(STATS_SORT_LIST["SAVED"])
		else
			STATS_SORT_LIST["SAVED"] = {}
		end
		for k,v in pairs(AtlasLoot.db.profile.CompareFrame.ownSortLists[ AtlasLoot.db.profile.CompareFrame.lastSortType ]) do
			if k and v == true and k ~= "sortListName" then
				table.insert(STATS_SORT_LIST["SAVED"], k)
			end
		end
		return STATS_SORT_LIST["SAVED"]
	else
		return STATS_SORT_LIST["BASE"]
	end
end

function AtlasLoot:CompareFrame_StatsListDropDownRefresh()
	UIDropDownMenu_Initialize(_G["AtlasLootCompareFrameSearch_StatsListDropDown"], AtlasLoot.CompareFrame_StatsListInitialize)
	UIDropDownMenu_SetSelectedValue(_G["AtlasLootCompareFrameSearch_StatsListDropDown"], AtlasLoot.db.profile.CompareFrame.lastSortType)
	UIDropDownMenu_SetWidth(_G["AtlasLootCompareFrameSearch_StatsListDropDown"], 190)
end
-- AtlasLootCompareFrameSearch_StatsListDropDown
function AtlasLoot.CompareFrame_StatsListInitialize(self)
	local info = self.info
	wipe(info)	
	
	if AtlasLoot.db.profile.CompareFrame.showBaseSort then
		info.text = AL["Base Stats list"]
		info.value = "BASE"
		info.func = AtlasLoot.CompareFrame_StatsList_OnClick
		info.checked = nil
		UIDropDownMenu_AddButton(info)		
	end
	if AtlasLoot.db.profile.CompareFrame.showExtraSort then
		info.text = AL["Extra Stats list"]
		info.value = "EXTRA"
		info.func = AtlasLoot.CompareFrame_StatsList_OnClick
		info.checked = nil
		UIDropDownMenu_AddButton(info)
	end	
	
	for k,v in ipairs(AtlasLoot.db.profile.CompareFrame.ownSortLists) do
		if v.sortListName then
			info.text = v.sortListName
			info.value = k
			info.func = AtlasLoot.CompareFrame_StatsList_OnClick
			info.checked = nil
			UIDropDownMenu_AddButton(info)
		end
	end

			
	info.text         = ""
	info.func         = nil
	info.checked      = nil
	info.notCheckable = 1
	info.notCheckable = true
	info.isTitle = true
	info.justifyH	  = "CENTER"
	UIDropDownMenu_AddButton(info)
	
	info.text         = "|cffff0000"..CLOSE
	info.func         = function() CloseDropDownMenus() end
	info.checked      = nil
	info.notCheckable = 1
	info.isTitle	  = false
	info.disabled	  = false
	info.justifyH	  = "CENTER"
	UIDropDownMenu_AddButton(info)
end

function AtlasLoot.CompareFrame_StatsList_OnClick(self)
	if not self.value then return end
    AtlasLoot.db.profile.CompareFrame.lastSortType = self.value
	AtlasLoot:CompareFrame_StatsListDropDownRefresh()
	AtlasLoot:CompareFrame_SetStatsSortList(AtlasLoot:CompareFrame_GetStatsSortList())
end

-- Stats sort list
-- #####################################################
		
local curWidthSortButtons = 0	
function AtlasLoot:CompareFrame_SetStatsSortListWidth(width)
	-- true = refresh
	if width == true then
		width = curWidthSortButtons
		curWidthSortButtons = 0
	end
	if width == curWidthSortButtons then
		-- Do nothing
	elseif width == 597 then
		AtlasLoot.CompareFrame.SortButtons[1]:SetWidth(111.5-12.5)
		AtlasLoot.CompareFrame.SortButtons[2]:SetWidth(111.5-12.5)
		local statsSort = #AtlasLoot:CompareFrame_GetStatsSortList()
		local fixVaule = (409 + (statsSort*2)) / statsSort --417 / statsSort
		for i=3, statsSort+2 do
			AtlasLoot.CompareFrame.SortButtons[i]:SetWidth(fixVaule)
		end
		curWidthSortButtons = width
	elseif width == 625 then
		AtlasLoot.CompareFrame.SortButtons[1]:SetWidth(111.5)
		AtlasLoot.CompareFrame.SortButtons[2]:SetWidth(111.5)
		local statsSort = #AtlasLoot:CompareFrame_GetStatsSortList()
		local fixVaule = (413 + (statsSort*2)) / statsSort --421 / statsSort
		for i=3, statsSort+2 do
			AtlasLoot.CompareFrame.SortButtons[i]:SetWidth(fixVaule)
		end
		curWidthSortButtons = width
	end
end

function AtlasLoot:CompareFrame_Create()
	if self.CompareFrame then return end
	local frameName = "AtlasLootCompareFrame"
	AtlasLoot.CompareFrame = CreateFrame("Frame",FRAME_NAME)

	local Frame = AtlasLoot.CompareFrame
	Frame:ClearAllPoints()
	Frame:SetParent(UIParent)
	Frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
	--Frame:SetFrameStrata("HIGH")
	Frame:SetWidth(832)
	Frame:SetHeight(447)
	Frame:SetMovable(true)
	Frame:EnableMouse(true)
	Frame:RegisterForDrag("LeftButton")
	Frame:RegisterForDrag("LeftButton", "RightButton")
	Frame:SetScript("OnMouseDown", Frame.StartMoving)
	Frame:SetScript("OnMouseUp", Frame.StopMovingOrSizing)
	Frame:SetToplevel(true)
	Frame:SetClampedToScreen(true)
	
	Frame.Layers = {}
	
	Frame.Layers[1] = Frame:CreateTexture(nil, "BACKGROUND")
	Frame.Layers[1]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 8, -7)	
	Frame.Layers[1]:SetWidth(60)
	Frame.Layers[1]:SetHeight(60)
	Frame.Layers[1]:SetTexture("Interface\\Icons\\INV_Box_01")
	SetPortraitToTexture(Frame.Layers[1],"Interface\\Icons\\INV_Box_01")
	
	Frame.Layers[2] = Frame:CreateTexture(nil, "ARTWORK")
	Frame.Layers[2]:SetPoint("TOPLEFT", Frame, "TOPLEFT")	
	Frame.Layers[2]:SetWidth(256)
	Frame.Layers[2]:SetHeight(256)
	Frame.Layers[2]:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopLeft")
	
	Frame.Layers[3] = Frame:CreateTexture(nil, "ARTWORK")
	Frame.Layers[3]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 256, 0)	
	Frame.Layers[3]:SetWidth(320)
	Frame.Layers[3]:SetHeight(256)
	Frame.Layers[3]:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top")
	
	Frame.Layers[4] = Frame:CreateTexture(nil, "ARTWORK")
	Frame.Layers[4]:SetPoint("TOPLEFT", Frame.Layers[3], "TOPRIGHT")	
	Frame.Layers[4]:SetWidth(256)
	Frame.Layers[4]:SetHeight(256)
	Frame.Layers[4]:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight")
	
	Frame.Layers[5] = Frame:CreateTexture(nil, "ARTWORK")
	Frame.Layers[5]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 0, -256)	
	Frame.Layers[5]:SetWidth(256)
	Frame.Layers[5]:SetHeight(256)
	Frame.Layers[5]:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotLeft")
	
	Frame.Layers[6] = Frame:CreateTexture(nil, "ARTWORK")
	Frame.Layers[6]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 256, -256)	
	Frame.Layers[6]:SetWidth(320)
	Frame.Layers[6]:SetHeight(256)
	Frame.Layers[6]:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Bot")
	
	Frame.Layers[7] = Frame:CreateTexture(nil, "ARTWORK")
	Frame.Layers[7]:SetPoint("TOPLEFT", Frame.Layers[6], "TOPRIGHT")	
	Frame.Layers[7]:SetWidth(256)
	Frame.Layers[7]:SetHeight(256)
	Frame.Layers[7]:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotRight")
	
	Frame.CloseButton = CreateFrame("Button", FRAME_NAME.."_CloseButton", Frame, "UIPanelCloseButton")
	Frame.CloseButton:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", 3, -8)
		
	Frame.Title = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	Frame.Title:SetPoint("TOP", Frame, "TOP", 0, -18)
	Frame.Title:SetJustifyH("CENTER")
	Frame.Title:SetText(AL["AtlasLoot"].." "..AL["Compare Frame"])
	
	Frame.NumItems = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	Frame.NumItems:SetPoint("TOPLEFT", Frame, "TOPLEFT", 25, -415)
	Frame.NumItems:SetWidth(150)
	Frame.NumItems:SetHeight(10)
	Frame.NumItems:SetJustifyH("LEFT")
	Frame.NumItems:SetText(string.format(AL["%d items"], NUM_ITEMS_IN_LIST))
	
	-- ###########################################
	-- Scroll frame Main Filter
	Frame.MainFilterButtons = {}
	
	Frame.ScrollFrameMainFilter = CreateFrame("ScrollFrame", FRAME_NAME.."_ScrollFrameMainFilter", Frame, "FauxScrollFrameTemplate")
	Frame.ScrollFrameMainFilter:SetPoint("TOPRIGHT", Frame, "TOPLEFT", 158, -105)	
	Frame.ScrollFrameMainFilter:SetWidth(160)
	Frame.ScrollFrameMainFilter:SetHeight(305)
	Frame.ScrollFrameMainFilter:SetScript("OnVerticalScroll", onVerticalScrollMainFilter)
	--Frame.ScrollFrameMainFilter:SetScript("OnShow", onUpdate)
	
	Frame.Layers[8] = Frame.ScrollFrameMainFilter:CreateTexture(nil, "ARTWORK")
	Frame.Layers[8]:SetPoint("TOPLEFT", Frame.ScrollFrameMainFilter, "TOPRIGHT", -2, 5)	
	Frame.Layers[8]:SetWidth(31)
	Frame.Layers[8]:SetHeight(256)
	Frame.Layers[8]:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	Frame.Layers[8]:SetTexCoord(0, 0.484375, 0, 1.0)
	
	Frame.Layers[9] = Frame.ScrollFrameMainFilter:CreateTexture(nil, "ARTWORK")
	Frame.Layers[9]:SetPoint("BOTTOMLEFT", Frame.ScrollFrameMainFilter, "BOTTOMRIGHT", -2, -2)	
	Frame.Layers[9]:SetWidth(31)
	Frame.Layers[9]:SetHeight(106)
	Frame.Layers[9]:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	Frame.Layers[9]:SetTexCoord(0.515625, 1.0, 0, 0.4140625)

	
	for i=1,15 do
		Frame.MainFilterButtons[i] = CreateFrame("BUTTON", FRAME_NAME.."MainFilterButton"..i, Frame, "AtlasLootCFMainFilterButtonTemplate")
		if i == 1 then
			Frame.MainFilterButtons[i]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 23, -105)
		else
			Frame.MainFilterButtons[i]:SetPoint("TOPLEFT", Frame.MainFilterButtons[i - 1], "BOTTOMLEFT", 0, 0)
		end
	end
	-- Scroll frame Main Filter
	-- ###########################################
	
	-- ###########################################
	-- Sort Buttons
	local locClass,englishClass = UnitClass("player")
	local sortMaxLength = 645
	local sortCurLenght = 0
	
	Frame.SortButtons = {}
	
	-- Name
	Frame.SortButtons[1] = CreateFrame("BUTTON", FRAME_NAME.."SortButton_Name", Frame, "AtlasLootCFSortButtonTemplate")
	Frame.SortButtons[1]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 186, -82)
	Frame.SortButtons[1]:SetWidth(110.5)
	Frame.SortButtons[1]:SetHeight(19)
	Frame.SortButtons[1]:SetText(AL["Name"])
	Frame.SortButtons[1].SortType = "name"
	sortMaxLength = sortMaxLength - 111.5
	
	-- RARITY
	Frame.SortButtons[2] = CreateFrame("BUTTON", FRAME_NAME.."SortButton_Rarity", Frame, "AtlasLootCFSortButtonTemplate")
	Frame.SortButtons[2]:SetPoint("LEFT", Frame.SortButtons[1], "RIGHT", -2, 0)
	Frame.SortButtons[2]:SetWidth(110.5)
	Frame.SortButtons[2]:SetHeight(19)
	Frame.SortButtons[2]:SetText(AL["Slot"])
	Frame.SortButtons[2].SortType = "slot"
	sortMaxLength = sortMaxLength - 111.5
	
	-- Item level
	--Frame.SortButtons[3] = CreateFrame("BUTTON", FRAME_NAME.."SortButton_ItemLvl", Frame, "AtlasLootCFSortButtonTemplate")
	--Frame.SortButtons[3]:SetPoint("LEFT", Frame.SortButtons[2], "RIGHT", -2, 0)
	--Frame.SortButtons[3]:SetWidth(65)
	--Frame.SortButtons[3]:SetHeight(19)
	--Frame.SortButtons[3]:SetText(AL["ItemLvl"])
	--Frame.SortButtons[3].SortType = "itemlvl"
	--sortMaxLength = sortMaxLength - 65
	
	sortCurLenght = sortMaxLength / #AtlasLoot:CompareFrame_GetStatsSortList()
	for k,v in ipairs(AtlasLoot:CompareFrame_GetStatsSortList()) do
		Frame.SortButtons[k+2] = CreateFrame("BUTTON", FRAME_NAME.."SortButton_"..k, Frame, "AtlasLootCFSortButtonTemplate")
		Frame.SortButtons[k+2]:SetPoint("LEFT", Frame.SortButtons[k+2-1], "RIGHT", -2, 0)
		Frame.SortButtons[k+2]:SetWidth(sortCurLenght)
		Frame.SortButtons[k+2]:SetHeight(19)
		Frame.SortButtons[k+2]:SetText(STATS_LIST[v][1])
		Frame.SortButtons[k+2]:SetScript("OnEnter", onEnterSortButton)
		Frame.SortButtons[k+2]:SetScript("OnLeave", onLeaveSortButton)
		Frame.SortButtons[k+2].SortType = v
		Frame.SortButtons[k+2].font = _G[FRAME_NAME.."SortButton_"..k.."Text"]
	end
	-- Sort Buttons
	-- ###########################################
	
	-- ###########################################
	-- Search
	Frame["SearchFrame"] = {}
	local SearchFrame = Frame["SearchFrame"]
	
	SearchFrame.SearchTitle = Frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	SearchFrame.SearchTitle:SetPoint("TOPLEFt", Frame, "TOPLEFT", 80, -41)
	SearchFrame.SearchTitle:SetJustifyH("LEFT")
	SearchFrame.SearchTitle:SetText(AL["Search"])
		
	SearchFrame.SearchBox = CreateFrame("EditBox", "AtlasLootCompareFrameSearch_Box", Frame, "InputBoxTemplate")
	SearchFrame.SearchBox:SetPoint("TOPLEFT", SearchFrame.SearchTitle, "BOTTOMLEFT", 3, -2)
	SearchFrame.SearchBox:SetWidth(140)
	SearchFrame.SearchBox:SetHeight(16)
	SearchFrame.SearchBox:SetAutoFocus(false)
	SearchFrame.SearchBox:SetTextInsets(0, 8, 0, 0)
	SearchFrame.SearchBox:SetMaxLetters(100)
	SearchFrame.SearchBox:SetScript("OnEnterPressed",function(self) 
							AtlasLoot:CompareFrame_Search(SearchFrame.SearchBox:GetText(), "save")
							SearchFrame.SearchBox:ClearFocus()
						end)
	
	SearchFrame.Search = CreateFrame("Button","AtlasLootCompareFrameSearch_SearchButton",Frame,"UIPanelButtonTemplate")
	SearchFrame.Search:SetText(AL["Search"])
	SearchFrame.Search:SetWidth(69)
	SearchFrame.Search:SetHeight(20)
	SearchFrame.Search:SetPoint("LEFT", SearchFrame.SearchBox, "RIGHT", 0, 0)
	SearchFrame.Search:SetScript("OnClick",function() 
							AtlasLoot:CompareFrame_Search(SearchFrame.SearchBox:GetText(), "save")
							SearchFrame.SearchBox:ClearFocus()
						end)
						
	SearchFrame.Clear = CreateFrame("Button","AtlasLootCompareFrameSearch_ClearButton",Frame,"UIPanelButtonTemplate")
	SearchFrame.Clear:SetText(AL["Clear"])
	SearchFrame.Clear:SetWidth(80)
	SearchFrame.Clear:SetHeight(22)
	SearchFrame.Clear:SetPoint("TOPLEFT", Frame, "TOPLEFT", 78, -75)
	SearchFrame.Clear:SetScript("OnClick",function() 
							SearchFrame.SearchBox:SetText("")
							SearchFrame.SearchBox:ClearFocus()
						end)
						
	SearchFrame.SearchSelectModule = AtlasLoot:CreateSearchModuleDropDown(Frame, {"LEFT", SearchFrame.Search, "RIGHT", 0, 0}, "AtlasLootCompareFrameSearch_SelectModuel")
	-- Search
	-- ###########################################
	
	-- ###########################################
	-- StatsList DropDown
	Frame.StatsListSelect = CreateFrame("Frame", "AtlasLootCompareFrameSearch_StatsListDropDown", Frame, "UIDropDownMenuTemplate")
	Frame.StatsListSelect:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", 0, -50)
	Frame.StatsListSelect.info = {}
	
	Frame.StatsListSelect.Text = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	Frame.StatsListSelect.Text:SetPoint("BOTTOMLEFT", Frame.StatsListSelect, "TOPLEFT", 21, 0)
	Frame.StatsListSelect.Text:SetText(AL["Select Stats list"])
		
	-- StatsList DropDown
	-- ###########################################	
	
	
	-- ###########################################
	-- Filter
	Frame.Filter = CreateFrame("CheckButton", "AtlasLootCompareFrameSearch_FilterCheck", Frame, "OptionsCheckButtonTemplate")
	Frame.Filter:SetPoint("TOPLEFT", Frame, "TOPLEFT", 180, -408)
	_G[Frame.Filter:GetName().."Text"]:SetText(AL["Filter"])
	Frame.Filter:SetScript("OnShow", function(this)
		this:SetFrameLevel( (this:GetParent()):GetFrameLevel() + 1 )
		if AtlasLoot:FilterGetEnabled() then
			this:SetChecked(true)
		else
			this:SetChecked(false)
		end
	end)
	Frame.Filter:SetScript("OnClick", function(self, button)
		AtlasLoot.FilterButtonOnClick(self, button)
		AtlasLoot:CompareFrame_UpdateItemListScrollFrame(nil, true)
	end)
	Frame.Filter:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(AL["|cffFF0000Shift+Click: |cffFFFFFFOpen filter configuration"])
		GameTooltip:Show()
	end)
	Frame.Filter:SetScript("OnLeave", function() GameTooltip:Hide() end)	
	Frame.Filter:Show()

	-- Filter
	-- ############################################
	
	-- ############################################
	-- 3er button Leiste#
	Frame.Close2 = CreateFrame("Button","AtlasLootCompareFrame_CloseButton2",Frame,"UIPanelButtonTemplate")
	Frame.Close2:SetText(CLOSE)
	Frame.Close2:SetWidth(80)
	Frame.Close2:SetHeight(22)
	Frame.Close2:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -7, 15)
	Frame.Close2:SetScript("OnClick",function(self) 
		HideUIPanel(self:GetParent())
	end)
	
	-- 3er button Leiste
	-- ############################################

	-- ###########################################
	-- Item Frame
	Frame.ItemButtons = {}
	
	Frame.ScrollFrameItemFrame = CreateFrame("ScrollFrame", FRAME_NAME.."_ScrollFrameItemFrame", Frame, "FauxScrollFrameTemplate")
	Frame.ScrollFrameItemFrame:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -39, -105)	
	Frame.ScrollFrameItemFrame:SetWidth(605)
	Frame.ScrollFrameItemFrame:SetHeight(306)
	Frame.ScrollFrameItemFrame:SetScript("OnVerticalScroll", onVerticalScrollItemFrame)
	--Frame.ScrollFrameItemFrame:SetScript("OnShow", onUpdate)
	
	Frame.Layers[10] = Frame.ScrollFrameItemFrame:CreateTexture(nil, "ARTWORK")
	Frame.Layers[10]:SetPoint("TOPLEFT", Frame.ScrollFrameItemFrame, "TOPRIGHT", -2, 5)	
	Frame.Layers[10]:SetWidth(31)
	Frame.Layers[10]:SetHeight(256)
	Frame.Layers[10]:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	Frame.Layers[10]:SetTexCoord(0, 0.484375, 0, 1.0)
	
	Frame.Layers[11] = Frame.ScrollFrameItemFrame:CreateTexture(nil, "ARTWORK")
	Frame.Layers[11]:SetPoint("BOTTOMLEFT", Frame.ScrollFrameItemFrame, "BOTTOMRIGHT", -2, -2)	
	Frame.Layers[11]:SetWidth(31)
	Frame.Layers[11]:SetHeight(106)
	Frame.Layers[11]:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
	Frame.Layers[11]:SetTexCoord(0.515625, 1.0, 0, 0.4140625)
	
	for i=1,8 do
		Frame.ItemButtons[i] = AtlasLoot:CreateCompareFrameItemButton(Frame, {"TOPLEFT", Frame, "TOPLEFT", 195, -110}, FRAME_NAME.."_ScrollFrameItemFrame_Item"..i, AtlasLoot:CompareFrame_GetStatsSortList())--createItemButton(FRAME_NAME.."_ScrollFrameItemFrame_Item"..i, Frame)
		if i == 1 then
			Frame.ItemButtons[i].Frame:SetPoint("TOPLEFT", Frame, "TOPLEFT", 195, -110)
		else
			Frame.ItemButtons[i].Frame:SetPoint("TOPLEFT", Frame.ItemButtons[i-1].Frame, "BOTTOMLEFT", 0, 0)
		end
		Frame.ItemButtons[i].Frame:Hide()
	end
	-- Item Frame
	-- ###########################################
	
	AtlasLoot:CompareFrame_UpdateItemListScrollFrame()
	AtlasLoot:CompareFrame_UpdateMainFilterScrollFrame()
	AtlasLoot:CompareFrame_StatsListDropDownRefresh()
	AtlasLoot:CompareFrame_UpdateColors()
	tinsert(UISpecialFrames, FRAME_NAME)
	
	Frame:Hide()
	
	AtlasLoot:RegisterModuleOptions("CompareFrame", getOptions, AL["Compare Frame"])
end
