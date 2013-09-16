-- $Id: Filter.lua 4206 2013-05-06 22:44:00Z lag123 $
--[[
Atlasloot Enhanced
Author Hegarol
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)
]]
local _
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")

local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local MODULENAME = "Filter"
local Filter = AtlasLoot:NewModule(MODULENAME)

local db
local dbDefaults = {
	profile = {
		enable = false,
		-- FilterAds
		filterSlots = {
			['*'] = {
				['*'] = true,
			},
		},
	},
}

local FilterTableNames = {
	["Armor"] = BabbleInventory["Armor"],
	["WeaponsMeele"] = AL["Melee weapons"],
	["WeaponsMeeleTwoHand"] = BabbleInventory["Two-Hand"],--.." "..AL["Melee weapons:"],
	["WeaponsRanged"] = AL["Ranged weapons"],
	["Other"] = AL["Other"],
	["ItemSlot"] = AL["Itemslot"],
	["Stats"] = AL["Stats"],
}

local FilterSort = {"Armor", "Other", "ItemSlot", "WeaponsMeele", "WeaponsMeeleTwoHand", "WeaponsRanged", "Stats"}
local FilterTable = {
	["Armor"] = {
		"#a1#",				-- Cloth
		"#a2#",				-- Leather
		"#a3#",				-- Mail
		"#a4#",				-- Plate
	},		
		
	["WeaponsMeele"] = {
		"#s15#",			-- Held in Off-Hand
		"#w4#",				-- Dagger
		"#w6#",				-- Mace
		"#w9#",				-- Staff	
		"#w1#",				-- Axe
		"#w7#",				-- Polearm
		"#w8#",				-- Shield
		"#w10#",			-- Sword
		"#w13#",			-- Fist Weapon
	},
		
	["WeaponsMeeleTwoHand"] = {
		"#w6#",				-- Mace
		"#w1#",				-- Axe
		"#w10#",			-- Sword
	},
		
	["WeaponsRanged"] = {
		"#w12#",			-- Wand
		"#w2#",				-- Bow
		"#w3#",				-- Crossbow
		"#w5#",				-- Gun
		-- "#w11#",			-- Thrown 	--REMOVED
	},
	
	["Other"] = {
		"#s13#",			-- Ring
		"#s14#",			-- Trinket
		"#s2#",				-- Neck
		"#s4#",				-- Back
		-- "#s16#",			-- Relic 	--REMOVED
	},

	["ItemSlot"] = {
		"#s1#", 			-- Head
		"#s2#", 			-- Neck
		"#s3#", 			-- Shoulder
		"#s4#", 			-- Back
		"#s5#",  			-- Chest
		"#s6#", 			-- Shirt
		"#s7#", 			-- Tabard
		"#s8#", 			-- Wrist
		"#s9#", 			-- Hands
		"#s10#", 			-- Waist
		"#s11#",			-- Legs
		"#s12#", 			-- Feet
	},
	["Stats"] = {
		"STAMINA",
		"AGILITY",	
		"STRENGTH",
		"INTELLECT",
		"SPIRIT",		
		"CRIT_RATING",
		"DODGE_RATING",	
		"EXPERTISE_RATING",
		"HIT_RATING",
		"HASTE_RATING",
		"PARRY_RATING",
		"SPELL_POWER",
		"MASTERY_RATING",
		"RESILIENCE_RATING",
	},
}
local FilterTableNamesSlots = {
	["STRENGTH"] = AL["Strength"],
 	["AGILITY"] = AL["Agility"],
	["STAMINA"] = AL["Stamina"],
	["INTELLECT"] = AL["Intellect"],
	["SPIRIT"] = AL["Spirit"],
	["CRIT_RATING"] = AL["Crit Rating"],
	["DODGE_RATING"] = AL["Dodge Rating"],
	["EXPERTISE_RATING"] = AL["Expertise Rating"],
	["HIT_RATING"] = AL["Hit Rating"],
	["HASTE_RATING"] = AL["Haste Rating"],
	["PARRY_RATING"] = AL["Parry Rating"],
	["SPELL_POWER"] = AL["Spell Power"],
	["RESILIENCE_RATING"] = AL["Resilience Rating"],
	["MASTERY_RATING"] = AL["Mastery Rating"],
}

local ClassHides = {
	["DRUID"] = {
		["Armor"] = {false,true,false,false},
		["WeaponsMeele"] = {true,true,true,true,false,true,false,false,false},
		["WeaponsMeeleTwoHand"] = {true,false,false},
		["WeaponsRanged"] = {false,false,false,false,false},
		["Other"] = {true,true,true,true,true},
		["Stats"] = {true,true,false,true,true,true,false,true,true,true,false,true,true,true}
	},
	["MAGE"] = {
		["Armor"] = {true,false,false,false},
		["WeaponsMeele"] = {true,true,false,true,false,false,false,true,false},
		["WeaponsMeeleTwoHand"] = {false,false,false},
		["WeaponsRanged"] = {true,false,false,false,false},
		["Other"] = {true,true,true,true,false},
		["Stats"] = {true,false,false,true,true,true,false,false,true,true,false,true,true,true}
	},
	["PALADIN"] = {
		["Armor"] = {false,false,false,true},
		["WeaponsMeele"] = {true,false,true,false,true,true,true,true,false},
		["WeaponsMeeleTwoHand"] = {true,false,true},
		["WeaponsRanged"] = {false,false,false,false,false},
		["Other"] = {true,true,true,true,true},
		["Stats"] = {true,false,true,true,true,true,true,true,true,true,true,true,true,true}
	},
	["PRIEST"] = {
		["Armor"] = {true,false,false,false},
		["WeaponsMeele"] = {true,true,true,true,false,false,false,false,false},
		["WeaponsMeeleTwoHand"] = {false,false,false},
		["WeaponsRanged"] = {true,false,false,false,false},
		["Other"] = {true,true,true,true,false},
		["Stats"] = {true,false,false,true,true,true,false,false,true,true,false,true,true,true}
	},
	["ROGUE"] = {
		["Armor"] = {false,true,false,false},
		["WeaponsMeele"] = {true,true,true,false,true,false,false,true,true},
		["WeaponsMeeleTwoHand"] = {false,false,false},
		["WeaponsRanged"] = {false,true,true,true,true},
		["Other"] = {true,true,true,true,false},
		["Stats"] = {true,true,false,false,false,true,true,true,true,true,true,false,true,true}
	},
	["HUNTER"] = {
		["Armor"] = {false,false,true,false},
		["WeaponsMeele"] = {false,true,false,true,true,true,false,true,true},
		["WeaponsMeeleTwoHand"] = {false,true,true},
		["WeaponsRanged"] = {false,true,true,true,false},
		["Other"] = {true,true,true,true,false},
		["Stats"] = {true,true,false,false,false,true,false,false,true,true,false,false,true,true}
	},
	["SHAMAN"] = {
		["Armor"] = {false,false,true,false},
		["WeaponsMeele"] = {true,true,true,true,true,false,true,false,true},
		["WeaponsMeeleTwoHand"] = {true,true,false},
		["WeaponsRanged"] = {false,false,false,false,false},
		["Other"] = {true,true,true,true,true},
		["Stats"] = {true,true,false,true,true,true,false,true,true,true,false,true,true,true}
	},
	["WARLOCK"] = {
		["Armor"] = {true,false,false,false},
		["WeaponsMeele"] = {true,true,false,true,false,false,false,true,false},
		["WeaponsMeeleTwoHand"] = {false,false,false},
		["WeaponsRanged"] = {true,false,false,false,false},
		["Other"] = {true,true,true,true,false},
		["Stats"] = {true,false,false,true,false,true,false,false,true,true,false,true,true,true}
	},
	["WARRIOR"] = {
		["Armor"] = {false,false,false,true},
		["WeaponsMeele"] = {true,true,true,true,true,true,true,true,true},
		["WeaponsMeeleTwoHand"] = {true,true,true},
		["WeaponsRanged"] = {false,true,true,true,true},
		["Other"] = {true,true,true,true,false},
		["Stats"] = {true,false,true,false,false,true,true,true,true,true,true,false,true,true}
	},
	["DEATHKNIGHT"] = {
		["Armor"] = {false,false,false,true},
		["WeaponsMeele"] = {true,false,true,false,true,true,false,true,false},
		["WeaponsMeeleTwoHand"] = {true,true,true},
		["WeaponsRanged"] = {false,false,false,false,false},
		["Other"] = {true,true,true,true,true},
		["Stats"] = {true,false,true,false,false,true,true,true,true,true,true,false,true,true}
	}
}

local getOptions
do
	local locClass,englishClass = UnitClass("player")
	
	local function SortTable(t, slot)
		if slot == "WeaponsMeele" or slot == "WeaponsRanged" or slot == "WeaponsMeeleTwoHand" then
			local a,b = {}, {}
			for m,n in ipairs(t) do a[#a + 1] = FilterTableNamesSlots[n];b[FilterTableNamesSlots[n]] = m end
			table.sort(a)
			local i = 0
			return function()
				i = i + 1
				return b[a[i]], t[b[a[i]]]
			end
		else
			return ipairs(t)
		end
	end

 	local function getOpt(info)
		return db.filterSlots[info[#info-1]][info[#info]]
	end
	
	local function setOpt(info, value)
		db.filterSlots[info[#info-1]][info[#info]] = value
		return db.filterSlots[info[#info-1]][info[#info]]
	end
	
	local function getTwoHandOpt(info)
		local dbEntry = gsub(info[#info], "2Hand", "")
		return db.filterSlots["WeaponsMeeleTwoHand"][dbEntry]
	end
	
	local function setTwoHandOpt(info, value)
		local dbEntry = gsub(info[#info], "2Hand", "")
		db.filterSlots["WeaponsMeeleTwoHand"][dbEntry] = value
		return db.filterSlots["WeaponsMeeleTwoHand"][dbEntry]
	end
	
	
	local function setupClassTable()
		for tabName,tab in pairs(FilterTable) do
			for slotNum,slot in ipairs(tab) do
				if ClassHides[englishClass] and ClassHides[englishClass][tabName] then
					if ClassHides[englishClass][tabName][slotNum] == false then
						db.filterSlots[tabName][slot] = false
					else
						db.filterSlots[tabName][slot] = true
					end
				end
			end
		end
	end
	
	local function setupAll()
		for tabName,tab in pairs(FilterTable) do
			for _,slot in ipairs(tab) do
				db.filterSlots[tabName][slot] = true
			end
		end
	end

	local options
	function getOptions()
		if not options then
			options = {
				type = "group",
				name = MODULENAME,
				order = 600,
				childGroups = "tab",
				args = {
					toggle = {
						type = "toggle",
						name = AL["Enable"],
						get = function()
							return AtlasLoot:GetModuleEnabled(MODULENAME)
						end,
						set = function(info, v)
							AtlasLoot:SetModuleEnabled(MODULENAME, v)
						end,
						order = 10,
						width = "full",
					},
					clickInfo = {
						type = "description",
						name = "|cff999999"..AL["Shift + Click on the Filter button opens the config page."],
						order = 20,
					},

					setupClass = {
						type = "execute",
						name = AL["Apply Filter:"].." "..locClass,
						--desc = ,
						func = setupClassTable,
						order = 30,
					},
					setupAll = {
						type = "execute",
						name = AL["Select All Loot"],
						--desc = ,
						func = setupAll,
						order = 40,
					},
					
				},
			}
			
			local orderNumber = 50
			local tab, i
			for _,tabName in pairs(FilterSort) do
				tab = FilterTable[tabName]
				i = 1
				if tabName == "WeaponsMeeleTwoHand" then
					i = 100
					options.args["WeaponsMeele"].args.nllockb = {
						type = "description",
						name = "",
						order = i - 1,
						width = "full",
					}
					for smallOrder,slot in SortTable(tab, tabName) do
						options.args["WeaponsMeele"].args[slot.."2Hand"] = {
							type = "toggle",
							name = FilterTableNames[tabName].." "..FilterTableNamesSlots[slot],
							--desc = ,
							order = i,
							get = getTwoHandOpt,
							set = setTwoHandOpt,
						}
						i = i + 1
					end
				else
					options.args[tabName] = {
						type = "group",
						name = FilterTableNames[tabName],
						--desc = ,
						order = orderNumber,
						args = {},
					}
					for smallOrder,slot in SortTable(tab, tabName) do
						options.args[tabName].args[slot] = {
							type = "toggle",
							name = FilterTableNamesSlots[slot],
							--desc = ,
							order = i,
							get = getOpt,
							set = setOpt,
						}
						i = i + 1
					end
				end
				orderNumber = orderNumber + 1
			end
		end
		return options
	end
	
end

local function getEnabledStatus()
	return db.enable
end
	
	
function Filter:OnInitialize()
	if not AtlasLoot.db then AtlasLoot:OnLoaderLoad() end
	self.db = AtlasLoot.db:RegisterNamespace(MODULENAME, dbDefaults)
	db = self.db.profile
	AtlasLoot:RegisterModuleOptions(MODULENAME, getOptions, AL["Filter"])
	self:SetEnabledState(AtlasLoot:GetModuleEnabled(MODULENAME))
	
	AtlasLoot:AddTableFormatFunction(MODULENAME, self.FilterBySlot, getEnabledStatus)
	AtlasLoot:RegisterOnProfileChanged(self.OnProfileChanged)
	
	for _, filterTable in pairs(FilterTable) do
		for _, slot in ipairs(filterTable) do
			for _,v in ipairs(AtlasLoot_TextParsing) do
				if filterTable == "Stats" then
					break
				else
					if slot == v[1] then
						FilterTableNamesSlots[slot] = v[2]
					end
				end
			end
		end
	end
	
end

function Filter:OnProfileChanged()
	db = Filter.db.profile
end

function Filter:OnEnable()
	if AtlasLoot.ItemFrame.Filter then
		AtlasLoot.ItemFrame.Filter:Show()
	else
		AtlasLoot.ItemFrame.Filter = CreateFrame("CheckButton", "AtlasLootFilterCheck", AtlasLoot.ItemFrame, "OptionsCheckButtonTemplate")
		AtlasLoot.ItemFrame.Filter:SetPoint("BOTTOM", AtlasLoot.ItemFrame, "BOTTOM", 85, 27)
		_G[AtlasLoot.ItemFrame.Filter:GetName().."Text"]:SetText(AL["Filter"])
		AtlasLoot.ItemFrame.Filter:SetScript("OnShow", function(this)
			this:SetFrameLevel( (this:GetParent()):GetFrameLevel() + 1 )
			if db.enable then
				this:SetChecked(true)
			else
				this:SetChecked(false)
			end
		end)
		AtlasLoot.ItemFrame.Filter:SetScript("OnClick", Filter.FilterButtonOnClick)	
		AtlasLoot.ItemFrame.Filter:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(AL["|cffFF0000Shift+Click: |cffFFFFFFOpen filter configuration"])
			GameTooltip:Show()
		end)
		AtlasLoot.ItemFrame.Filter:SetScript("OnLeave", function() GameTooltip:Hide() end)
		AtlasLoot.ItemFrame.Filter:Show()
	end
end

function Filter:OnDisable()
	if AtlasLoot.ItemFrame.Filter then AtlasLoot.ItemFrame.Filter:Hide() end
	db.enable = false
end

--- Filters the loot table
-- @param lootTable the loottable to filter
-- @usage local filteredLootTabel = AtlasLoot:FilterBySlot(lootTable)
-- @return the filtered loot tabel
function Filter:FilterBySlot(lootTable)
	if AtlasLoot_Data["FilterList"] then
		wipe(AtlasLoot_Data["FilterList"])
	else
		AtlasLoot_Data["FilterList"] = {}
	end
	if not lootTable or type(lootTable) ~= "table" then
		return
	end
	
	local newItemPos
	local oldItemPos = 0
	local curItemPos
	local count = 0
	local leatherworking = GetSpellInfo(2108)
	local posSet = false
	local stats, itemLink
	
	local xgo, extraText, countOld, Slotname
	for _,v in ipairs(lootTable) do
	
		if type(v[2]) == "string" then 
			return lootTable 
		end
		xgo = true
		extraText = v[5] --AtlasLoot_FixText(v[5])
		_, itemLink = GetItemInfo(v[2])
		if itemLink then
			stats = GetItemStats(itemLink)
		else
			stats = nil
		end
		oldItemPos = oldItemPos or 0
		curItemPos = v[1]
		if not newItemPos then
			newItemPos = curItemPos
		else
			newItemPos = curItemPos - count
		end
		countOld = curItemPos - count

		if (extraText and extraText ~= "") or stats then
			for _,k in ipairs(FilterSort) do
				if type(FilterTable[k]) == "table" then
					for i,j in ipairs(FilterTable[k]) do
						if k == "Stats" then
							if stats and stats["ITEM_MOD_"..j.."_SHORT"] and not db.filterSlots[k][j] then
								xgo = false
							end
						else
							Slotname = j or "nil"
							extraText = extraText or "nil"
							if (k ~= "WeaponsMeeleTwoHand" and not strfind(extraText, "#h2#") and strfind(extraText, Slotname) and db.filterSlots[k][j] == false) then
								xgo = false
							elseif k == "WeaponsMeeleTwoHand" and strfind(extraText, "#h2#") and strfind(extraText, Slotname) and db.filterSlots[k][j] == false then
								xgo = false
							end
						end
					end
				end
			end
		end
		
		-- Sort the items
		if xgo == true then
			local tabNumSet = #AtlasLoot_Data["FilterList"] + 1
			if not posSet then
				if curItemPos == 16 and countOld > 0 then
					newItemPos = 16
					count = 0
				elseif curItemPos == 16 and extraText and strfind(extraText, "#e15#") then	-- Token
					newItemPos = 16
					count = 0
				elseif newItemPos < 16 and v[4] and strfind(v[4], AL["Hard Mode"]) then
					newItemPos = 16
					count = 0
				elseif curItemPos == 16 and xitemTexture == "INV_Box_01" then
					newItemPos = 16	
					count = 0
				elseif count > 0 and curItemPos >= 16 and oldItemPos ~= 16 then
					newItemPos = 16	
					count = curItemPos - newItemPos
				end
			end
			if newItemPos == 16 then posSet = true end
			--count = 0
			oldItemPos = newItemPos
			AtlasLoot_Data["FilterList"][tabNumSet] = { newItemPos, v[2], v[3], v[4], v[5], v[6], v[7], v[8], tf=v.tf }
		else
			count = count + 1
		end
			
	end
	
	return AtlasLoot_Data["FilterList"]
end

-- OnClick the filter button
function Filter:FilterButtonOnClick(arg1)
	if arg1 == "LeftButton" and IsShiftKeyDown() then
		AtlasLoot:OpenModuleOptions(MODULENAME)
		self:SetChecked(db.enable)
	else
		local dataID = AtlasLoot.ItemFrame.dataID
		AtlasLoot_Data["FilterList"] = nil
		if db.enable then
			db.enable = false
		else
			db.enable = true
		end
		AtlasLoot:ShowLootPage(dataID)
	end
end


local itemLink, stats, extraText
function AtlasLoot:FilterItemByItemTable(itemTable)
	if not itemTable or type(itemTable) ~= "table" then return end
	
	if type(itemTable[2]) == "string" then
		_, itemLink = GetItemInfo(tonumber(itemTable[3]))
	else
		_, itemLink = GetItemInfo(tonumber(itemTable[2]))
	end
	if not itemLink then return true end
	stats = GetItemStats(itemLink)
	extraText = itemTable[5]
	
	if extraText and extraText ~= "" or stats then
		local Slotname
		for _,k in ipairs(FilterSort) do
			if type(FilterTable[k]) == "table" then
				for i,j in ipairs(FilterTable[k]) do
					if k == "Stats" then
						if stats and stats["ITEM_MOD_"..j.."_SHORT"] and not db.filterSlots[k][j] then
							return false
						end
					else
						Slotname = j
						if (k ~= "WeaponsMeeleTwoHand" and not strfind(extraText, "#h2#") and strfind(extraText, Slotname) and db.filterSlots[k][j] == false) then
							return false
						elseif k == "WeaponsMeeleTwoHand" and strfind(extraText, "#h2#") and strfind(extraText, Slotname) and db.filterSlots[k][j] == false then
							return false
						end
					end
				end
			end
		end
	end
	
	return true
end


function AtlasLoot:FilterGetEnabled()
	return db.enable
end	
	
function AtlasLoot:FilterButtonOnClick(arg1)
	if arg1 == "LeftButton" and IsShiftKeyDown() then
		AtlasLoot:OpenModuleOptions(MODULENAME)
		self:SetChecked(db.enable)
	else
		if db.enable then
			db.enable = false
		else
			db.enable = true
		end
	end
end