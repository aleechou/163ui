local AtlasLoot = _G.AtlasLoot
local ItemDB = {}
AtlasLoot.ItemDB = ItemDB
local AL = AtlasLoot.Locales

-- lua
local assert, setmetatable, rawset = assert, setmetatable, rawset
local select = select
local pairs = pairs
local match, str_split, format = string.match, string.split, string.format

local STRING_TYPE = "string"
local BOSS_LINK_FORMAT = "%s:%s:%s"

-- Saves all the items ;)
ItemDB.Storage = {}

-- Functions for a item database
ItemDB.Proto = {}
ItemDB.ContentProto = {}

-- List of content from addons
local contentList = {}

-- the metatable  
ItemDB.contentMt = {
	__index = ItemDB.ContentProto
}
ItemDB.mt = {
	__newindex = function(t, k, v)
		t.__atlaslootdata.contentCount = t.__atlaslootdata.contentCount + 1
		setmetatable(v, ItemDB.contentMt)
		contentList[t.__atlaslootdata.addonName][t.__atlaslootdata.contentCount] = k
		contentList[t.__atlaslootdata.addonName][k] = t.__atlaslootdata.contentCount
		v.__atlaslootdata = t.__atlaslootdata
		rawset(t, k, v)
		
	end
}

--- Adds/Gets the table for a item database
-- @param	addonName		<string> full name of the addon folder (eg "AtlasLoot_MistsofPandaria")
-- @param	tierID			<number> the tier id of the EJ
function ItemDB:Add(addonName, tierID)
	if not ItemDB.Storage[addonName] then
		ItemDB.Storage[addonName] = {}
		for k,v in pairs(ItemDB.Proto) do
			ItemDB.Storage[addonName][k] = v
		end
		ItemDB.Storage[addonName].__atlaslootdata = {
			addonName = addonName,
			contentCount = 0,
			tierID = tierID
		}
		setmetatable(ItemDB.Storage[addonName], ItemDB.mt)
		contentList[addonName] = {}
	end
	return ItemDB.Storage[addonName]
end

function ItemDB:Get(addonName)
	assert(ItemDB.Storage[addonName], addonName.." not found!")
	return ItemDB.Storage[addonName]
end

function ItemDB:GetDifficulty(addonName, contentName, boss, dif)
	dif = dif or 1
	local diffs = ItemDB.Storage[addonName]:GetDifficultys()
	-- first try to get the next lower difficulty
	-- if nothing found get higher one or try again with lowest difficulty
	local count = dif
	local numDiffs = #diffs
	while true do
		if count == 0 then
			count = dif + 1
		elseif count > numDiffs then
			--error(dif.." (dif) not found! -> "..boss)
			return ItemDB:GetDifficulty(addonName, contentName, boss, 1)
		end
		if ItemDB.Storage[addonName][contentName].items[boss][count] then
			return count
		end
		if count > dif then
			count = count + 1
		else
			count = count - 1
		end
	end
end

local function getItemTableType(addonName, contentName, boss, dif)
	local tab = ItemDB.Storage[addonName]
	local typ = nil
	
	if tab[contentName].items[boss][dif].__linkedInfo then
		local newData = tab[contentName].items[boss][dif].__linkedInfo
		addonName, contentName, boss, dif = newData[1], newData[2], newData[3], newData[4]
		tab = ItemDB.Storage[addonName]
	end
	
	if tab[contentName].items[boss][dif].TableType then
		typ = tab:GetItemTableType(tab[contentName].items[boss][dif].TableType)
	elseif tab[contentName].items[boss].TableType then
		typ = tab:GetItemTableType(tab[contentName].items[boss].TableType)
	elseif tab[contentName].items.TableType then
		typ = tab:GetItemTableType(tab[contentName].items.TableType)
	elseif tab[contentName].TableType then
		typ = tab:GetItemTableType(tab[contentName].TableType)
	else
		typ = tab:GetItemTableType(1)
	end
	
	typ.extra = ItemDB.Storage[addonName]:GetAllExtraItemTableType()
	
	return typ
end



local function getItemsFromDiff(curBossTab, iniTab)
	-- first cache all positions that allready set
	local tmp = {}
	for i = 1, #curBossTab do
		tmp[ curBossTab[i][1] ] = true
	end
	-- now copy all items from the other difficulty
	local bossTab = iniTab[ curBossTab.GetItemsFromDiff ]
	if bossTab.GetItemsFromDiff then
		getItemsFromDiff(bossTab, iniTab)
	end
	for i = 1, #bossTab do
		if not tmp[ bossTab[i][1] ] then
			curBossTab[ #curBossTab+1 ] = bossTab[i]
		end
	end
	curBossTab.GetItemsFromDiff = nil
end

local currentModuleLoadingInfo = nil
local function loadItemsFromOtherModule(moduleLoader, loadString, contentTable, curContentName, curBossID, curAddonName, curDiff)
	if loadString then
		currentModuleLoadingInfo = {loadString, contentTable, curContentName, curBossID, curAddonName, curDiff}
	elseif currentModuleLoadingInfo then
		loadString, contentTable, curContentName, curBossID, curAddonName, curDiff = currentModuleLoadingInfo[1], currentModuleLoadingInfo[2], currentModuleLoadingInfo[3], currentModuleLoadingInfo[4], currentModuleLoadingInfo[5], currentModuleLoadingInfo[6]
	else
		return
	end
	
	local addonName, contentName, bossID, shortDiff = str_split(":", loadString)
	if (moduleLoader and moduleLoader ~= addonName) then 
		return
	end
	bossID = tonumber(bossID)
	
	local loadState = AtlasLoot.Loader:LoadModule(addonName, nil, "itemDB")
	if loadState == "InCombat" or loadState == "DISABLED" or loadState == "MISSING" then
		AtlasLoot.Loader:LoadModule(addonName, loadItemsFromOtherModule, "itemDB")
		return addonName, loadState
	elseif contentName and ItemDB.Storage[addonName] then
		-- get name of diff
		local newDif = ItemDB.Storage[curAddonName]:GetDifficultyUName(curDiff)
		-- get new diff ID
		if newDif or shortDiff then
			newDif = ItemDB.Storage[addonName]:GetDifficultyByName(shortDiff or newDif)
		else
			newDif = ItemDB.Storage[curAddonName]:GetDifficultyUName(curDiff) or ItemDB.Storage[curAddonName]:GetDifficultyName(curDiff)
			newDif = ItemDB.Storage[addonName]:GetDifficultyByName(newDif)
		end
		--contentTable[curDiff] = setmetatable({__linkedInfo = {addonName, contentName, bossID, newDif}}, { __index =ItemDB.Storage[addonName][contentName].items[bossID][newDif]})
		contentTable[curContentName].items[curBossID][curDiff] = ItemDB.Storage[addonName][contentName].items[bossID][newDif]
		if not contentTable[curContentName].items[curBossID][curDiff] then
			error("Linked Loottable not found contentName:"..(curContentName or "nil").." bossID:"..(curBossID or "nil").." dif:"..(curDiff or "nil"))
		end
		contentTable[curContentName].items[curBossID][curDiff].__linkedInfo = {addonName, contentName, bossID, newDif}
		currentModuleLoadingInfo = nil
	elseif ItemDB.Storage[addonName] then
		-- getBossID by name
		local bossID = contentTable[curContentName]:GetNameForItemTable(curBossID)
		for i=1, #ItemDB.Storage[addonName][curContentName].items do
			--print(ItemDB.Storage[addonName][curContentName]:GetNameForItemTable(i), bossID)
			if ItemDB.Storage[addonName][curContentName]:GetNameForItemTable(i) == bossID then
				bossID = i
				break
			end
		end
		if type(bossID) ~= "number" then
			error("No boss found for ID:"..curBossID.." name:"..bossID.." module:"..addonName.." contentName:"..curContentName)
		end
		loadString = format(BOSS_LINK_FORMAT, addonName, curContentName, bossID)
		currentModuleLoadingInfo = { loadString, contentTable, curContentName, curBossID, curAddonName, curDiff }
		loadItemsFromOtherModule()
	end
end

function ItemDB:GetItemTable(addonName, contentName, boss, dif)
	assert(addonName and ItemDB.Storage[addonName], addonName.." (addonName) not found!")
	assert(contentName and ItemDB.Storage[addonName][contentName], contentName.." (contentName) not found!")
	assert(boss and ItemDB.Storage[addonName][contentName].items[boss], boss.." (boss) not found!")
	local addonNameRETVALUE, addon
	if ItemDB.Storage[addonName][contentName].items[boss].link then
		return ItemDB:GetItemTable(ItemDB.Storage[addonName][contentName].items[boss].link[1], ItemDB.Storage[addonName][contentName].items[boss].link[2], ItemDB.Storage[addonName][contentName].items[boss].link[3], dif)
	end
	if type(dif) == STRING_TYPE then
		dif = ItemDB.Storage[addonName]:GetDifficultyByName(dif)
	end
	if not ItemDB.Storage[addonName][contentName].items[boss][dif] then
		dif = ItemDB:GetDifficulty(addonName, contentName, boss, dif)
	end
	currentModuleLoadingInfo = nil
	
	if ItemDB.Storage[addonName][contentName].items[boss][dif] then
		local bossDiff = ItemDB.Storage[addonName][contentName].items[boss][dif]
		-- get the items table from a string
		if type(bossDiff) == STRING_TYPE then
			local notLoadedAddonName, reason = loadItemsFromOtherModule(nil, bossDiff, ItemDB.Storage[addonName], contentName, boss, addonName, dif)
			if notLoadedAddonName then
				return notLoadedAddonName, reason, ItemDB.Storage[addonName]:GetDifficultyData(dif)
			end
		-- get the items table from a other difficulty
		elseif type(bossDiff) == "number" then
			ItemDB.Storage[addonName][contentName].items[boss][dif] = ItemDB.Storage[addonName][contentName].items[boss][ bossDiff ]
		-- get items from another difficulty
		elseif bossDiff.GetItemsFromDiff then
			getItemsFromDiff(bossDiff, ItemDB.Storage[addonName][contentName].items[boss])
		end
	end
	
	--assert(dif and ItemDB.Storage[addonName][contentName].items[boss][dif], dif.." (dif) not found!")
	return ItemDB.Storage[addonName][contentName].items[boss][dif], getItemTableType(addonName, contentName, boss, dif), ItemDB.Storage[addonName]:GetDifficultyData(dif)
end

function ItemDB:GetModuleList(addonName)
	assert(contentList[addonName], addonName.." not found.")
	return contentList[addonName]
end


-- ##################################################
--	TableProto
-- ##################################################

--[[
	like Heroic, Normal, 25Man
]]
local difficultys = {}

function ItemDB.Proto:AddDifficulty(dif, uniqueName, preset, difficultyID, tierID)
	assert(dif, "No 'dif' given.")
	
	if not difficultys[self.__atlaslootdata.addonName] then 
		difficultys[self.__atlaslootdata.addonName] = {
			counter = 0,
			names = {},
			uniqueNames = {},
			data = {}
		}
	end
	local diffTab = difficultys[self.__atlaslootdata.addonName]
	
	if not diffTab.uniqueNames[uniqueName] or not diffTab.names[dif] then
		diffTab.counter = diffTab.counter + 1
		diffTab.names[dif] = diffTab.counter
		if uniqueName then
			diffTab.uniqueNames[uniqueName] = diffTab.counter
		end
		diffTab.data[diffTab.counter] = {
			name = dif,
			uniqueName = uniqueName,
			preset = preset,
			difficultyID = difficultyID,
			tierID = tierID or ItemDB.Storage[self.__atlaslootdata.addonName].__atlaslootdata.tierID,
		}
	end
	return diffTab.uniqueNames[uniqueName] or diffTab.names[dif]
end

function ItemDB.Proto:GetTierID(dif)
	return (dif and difficultys[self.__atlaslootdata.addonName].data[dif]) and difficultys[self.__atlaslootdata.addonName].data[dif].tierID or nil
end

function ItemDB.Proto:GetDifficultyByName(dif)
	return dif and ( difficultys[self.__atlaslootdata.addonName].uniqueNames[dif] or difficultys[self.__atlaslootdata.addonName].names[dif] ) or nil
end

function ItemDB.Proto:GetDifficultyName(dif)
	return (dif and difficultys[self.__atlaslootdata.addonName].data[dif]) and difficultys[self.__atlaslootdata.addonName].data[dif].name or nil
end

function ItemDB.Proto:GetDifficultyByID(id)
	for i = 1, #difficultys[self.__atlaslootdata.addonName].data do
		if difficultys[self.__atlaslootdata.addonName].data[i].difficultyID == id then
			return i
		end
	end
end

function ItemDB.Proto:GetDifficultyUName(dif)
	return (dif and difficultys[self.__atlaslootdata.addonName].data[dif]) and difficultys[self.__atlaslootdata.addonName].data[dif].uniqueName or nil
end

function ItemDB.Proto:GetDifficultyID(dif)
	return (dif and difficultys[self.__atlaslootdata.addonName].data[dif]) and difficultys[self.__atlaslootdata.addonName].data[dif].difficultyID or nil
end

function ItemDB.Proto:GetDifficultyData(difID)
	return difficultys[self.__atlaslootdata.addonName].data[difID]
end

function ItemDB.Proto:GetDifficultys()
	return difficultys[self.__atlaslootdata.addonName].data
end

--[[
	New box for the dropdown menus
]]
local content_types = {}

function ItemDB.Proto:AddContentType(typ, color)
	assert(typ, "No 'typ' given.")
	if not content_types[self.__atlaslootdata.addonName] then content_types[self.__atlaslootdata.addonName] = {} end
	if not content_types[self.__atlaslootdata.addonName][typ] then
		content_types[self.__atlaslootdata.addonName][ #content_types[self.__atlaslootdata.addonName] + 1 ] = {typ, color or ATLASLOOT_UNKNOWN_COLOR}
		--table.insert(content_types[self.__atlaslootdata.addonName], {typ, color or ATLASLOOT_UNKNOWN_COLOR})
		content_types[self.__atlaslootdata.addonName][typ] = #content_types[self.__atlaslootdata.addonName]
	end
	return content_types[self.__atlaslootdata.addonName][typ]
end

function ItemDB.Proto:GetContentTypes()
	return content_types[self.__atlaslootdata.addonName]
end

local iTable_types = {}

function ItemDB.Proto:AddItemTableType(...)
	local tab = AtlasLoot.Button:CreateFormatTable({...})
	if not iTable_types[self.__atlaslootdata.addonName] then iTable_types[self.__atlaslootdata.addonName] = {} end
	iTable_types[self.__atlaslootdata.addonName][#iTable_types[self.__atlaslootdata.addonName]+1] = tab
	return #iTable_types[self.__atlaslootdata.addonName]
end

function ItemDB.Proto:GetItemTableType(index)
	return iTable_types[self.__atlaslootdata.addonName] and iTable_types[self.__atlaslootdata.addonName][index] or nil
end

local extra_iTable_types = {}

function ItemDB.Proto:AddExtraItemTableType(typ)
	if not extra_iTable_types[self.__atlaslootdata.addonName] then extra_iTable_types[self.__atlaslootdata.addonName] = {} end
	extra_iTable_types[self.__atlaslootdata.addonName][#extra_iTable_types[self.__atlaslootdata.addonName]+1] = typ
	return #extra_iTable_types[self.__atlaslootdata.addonName] + 100
end

function ItemDB.Proto:GetExtraItemTableType(index)
	return extra_iTable_types[self.__atlaslootdata.addonName] and ( extra_iTable_types[self.__atlaslootdata.addonName][index] or extra_iTable_types[self.__atlaslootdata.addonName][index+100] ) or nil
end

function ItemDB.Proto:GetAllExtraItemTableType(index)
	return extra_iTable_types[self.__atlaslootdata.addonName]
end

function ItemDB.Proto:CheckForLink(dataID, boss, load)
	assert(dataID, self[dataID], "dataID not found - "..dataID)
	assert(boss, self[dataID].items[boss], "boss not found - "..boss)
	if self[dataID].items[boss].link then
		local link = self[dataID].items[boss].link
		if AtlasLoot.Loader:IsModuleLoaded(link[1]) then
			assert(ItemDB.Storage[link[1]], "module "..link[1].." not found")
			assert(ItemDB.Storage[link[1]][link[2]], "dataID "..link[2].." not found in module "..link[1])
			assert(ItemDB.Storage[link[1]][link[2]].items[link[3]], "boss "..link[3].." not found in dataID "..link[2]..", module "..link[1])
			self[dataID].items[boss] = ItemDB.Storage[link[1]][link[2]].items[link[3]]
		elseif load then
			local combat = AtlasLoot.Loader:LoadModule(self[dataID].items[boss].link[1], function() self:CheckForLink(dataID, boss) end, true)
			if combat then
				print"InCombat :("
			end
		end
	end
end

function ItemDB.Proto:GetDifficulty(dataID, boss, dif)
	return ItemDB:GetDifficulty(self.__atlaslootdata.addonName, dataID, boss, dif)
end
-- ##################################################
--	ContentProto
-- ##################################################
--- Get the content Type
-- @return ContentName, ContentIndex
function ItemDB.ContentProto:GetContentType()
	if not self.ContentType then 
		error("ContentType not set for <"..self.__atlaslootdata.addonName.." / "..self.name..">")
		return nil
	end
	assert(content_types[self.__atlaslootdata.addonName][self.ContentType], self.ContentType.." not found!")
	return content_types[self.__atlaslootdata.addonName][self.ContentType][1], self.ContentType, content_types[self.__atlaslootdata.addonName][self.ContentType][2]
end

function ItemDB.ContentProto:GetName()
	if self.name then
		return self.name
	elseif self.EncounterJournalID then
		return EJ_GetInstanceInfo(self.EncounterJournalID)
	elseif self.MapID then
		return GetMapNameByID(self.MapID)
	elseif self.FactionID then
		return GetFactionInfoByID(self.FactionID) --or "Faction "..self.FactionID
	else
		return UNKNOWN
	end
end

function ItemDB.ContentProto:GetInfo()
	if self.info then
		return self.info
	elseif self.EncounterJournalID then
		return select(2, EJ_GetInstanceInfo(self.EncounterJournalID))
	elseif self.FactionID then
		return select(2, GetFactionInfoByID(self.FactionID))
	end
end

function ItemDB.ContentProto:GetNameForItemTable(index)
	assert(self.items, "items table not found.")
	assert(index and self.items[index], "index not found.")
	if self.items[index].name then
		return self.items[index].name
	elseif self.items[index].EncounterJournalID then
		return AtlasLoot.EncounterJournal:GetBossName(self.items[index].EncounterJournalID)
	elseif self.items[index].FactionID then
		return GetFactionInfoByID(self.items[index].FactionID) --or "Faction "..self.items[index].FactionID
	else
		return UNKNOWN
	end
end