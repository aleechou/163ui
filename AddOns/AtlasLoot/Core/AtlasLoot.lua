-- $Id: AtlasLoot.lua 4250 2013-09-10 09:49:18Z lag123 $
--[[
Atlasloot Enhanced
Author Hegarol
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)
]]
local addonname = ...
local AtlasLoot = _G.AtlasLoot

--Instance required libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

--Establish version number and compatible version of Atlas
local VERSION_MAJOR = "7";
local VERSION_MINOR = "07";
local VERSION_BOSSES = "00";
ATLASLOOT_VERSION = "|cffFF8400AtlasLoot Enhanced v"..VERSION_MAJOR.."."..VERSION_MINOR.."."..VERSION_BOSSES.."|r";
ATLASLOOT_VERSION_NUM = VERSION_MAJOR.."."..VERSION_MINOR.."."..VERSION_BOSSES

--Now allows for multiple compatible Atlas versions.  Always put the newest first
ATLASLOOT_MIN_ATLAS = "1.25.0"
ATLASLOOT_CURRENT_ATLAS = {"1.26.0"};
ATLASLOOT_PREVIEW_ATLAS = {"1.26.1", "1.26.2"};

--ATLASLOOT_POSITION = AL["Position:"];
ATLASLOOT_DEBUGMESSAGES = false;

--Standard indent to line text up with Atlas text
ATLASLOOT_INDENT = "   ";

--Variable to cap debug spam
ATLASLOOT_DEBUGSHOWN = false;

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

--Establish number of boss lines in the Atlas frame for scrolling
local ATLAS_LOOT_BOSS_LINES	= 25;

--Flag so that error messages do not spam
local ATLASLOOT_POPUPSHOWN = false;

--Variables to hold hooked Atlas functions
Hooked_Atlas_Refresh = nil;
Hooked_Atlas_OnShow = nil;
Hooked_AtlasScrollBar_Update = nil;

-- The AtlasLoot tooltip
AtlasLootTooltip = nil

--The error loottable
AtlasLoot_Data["ErrorPage"] = {["Normal"] = {{}};info = {name = "ErrorPage"};};

-- Saves the pFrame positions
local pFrameRegister = {}

AtlasLoot.IgnoreList = {
	["FormatedList"] = true,
}

AtlasLoot.imagePath = "Interface\\AddOns\\"..addonname.."\\Images\\"
--AtlasLootCharDB={};
local AtlasLootDBDefaults = {
	profile = {
		SavedTooltips = {},
		LootTableType = "Normal",
		--SafeLinks = true,
		DefaultTT = true,
		DropRate = true,
		EquipCompare = false,
		Opaque = false,
		ItemIDs = false,
		MiniMapButton = {
			hide = false,
		},
		HidePanel = false,
		AtlasLootVersion = nil,
		AtlasNaggedVersion = "",
		AutoQuery = false,
		LoadAllLoDStartup = false,
		PartialMatching = true,
		CraftingLink = 1,
		MinimapButtonAngle = 240,
		MinimapButtonRadius = 75,
		LootBrowserScale = 1.0,
		LootBrowserAlpha = 1.0,
		LootBrowserAlphaOnLeave = false,
		SearchModule = {
			["*"] = true,
		},
		CompareFrame = {
			showBaseSort = true,
			showExtraSort = true,
			lastSortType = "BASE",
			ownSortLists = {
				["*"] = {
					["*"] = false,
				}
			},
			statsColor = {
				["*"] = { r = 1.0, g = 1.0, b = 1.0 }
			},
		},
		AtlasType = "Release",
		modules = { ["*"] = true },
		sortFuncs = { ["*"] = { ["*"] = false },},
		QuickLooks = { ["*"] = { locked = false, lootPage = nil, lootPageType = nil, customName = nil, useInstanceName = false, useBossName = false }},
		NumQuickLooks = 4,
		EnableQuickLook = true,
		ShowUnusedQuickLooks = true,
		LastSearch = "",
		ShowLootTablePrice = true,
		ShowPriceAndDesc = false,
		UseGameTooltip = false,
		ShowBossTooltip = true,
		LastMinAtlasVersion = 0,
		EnableMouseOverDesc = true,
		CurrentUpgradeLvl = 0,
		BonusRollEnabled = true,
		ShowBonusRollInfoInTT = true,
		ShowThunderforged = false,
	}
}

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
	preferredIndex = 3,
	text = AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."],
	button1 = AL["Setup"],
	OnAccept = function()
		AtlasLoot:OptionsToggle()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

--Popup Box for an old version of Atlas
StaticPopupDialogs["ATLASLOOT_OLD_ATLAS"] = {
	preferredIndex = 3,
	text = AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("]..ATLASLOOT_CURRENT_ATLAS[1].."/"..ATLASLOOT_PREVIEW_ATLAS[1]..AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."],
	button1 = AL["OK"],
	OnAccept = function()
		AtlasLoot:Print(BLUE..AL["AtlasLoot"]..": "..RED..AL["Incompatible Atlas Detected"]);
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

--Popup Box for the bug with saved variables >.<
StaticPopupDialogs["ATLASLOOT_SAVED_VARIABLES"] = {
	preferredIndex = 3,
	text = "AtlasLoot should now work fine with Patch 4.2. If you still got problems please delete the file AtlasLoot.lua in your WoW folder: WTF/Account/AccountName/SavedVariables while logged out of the game.",
	button1 = AL["OK"],
	OnAccept = function()

	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

AtlasLoot.lootTableTypes = {"Normal", "Heroic", "25Man", "25ManHeroic", "RaidFinder", "Flexible"}

local function CopyTable(t)
	local new = {}
	local i, v = next(t, nil)
	while i do
		if type(v)=="table" then 
			v=CopyTable(v)
		end 
		new[i] = v
		i, v = next(t, i)
	end
	return new
end

local loadFrame = CreateFrame("FRAME")
loadFrame:SetScript("OnLoad", AtlasLoot.OnLoaderLoad)
-----------------------------
-- Core functions
-----------------------------
local loaded = false
-- Initialize all things like Gui, slash commands, saved variables
function AtlasLoot:OnLoaderLoad()
	if loaded then return end
	if AtlasLootDB and AtlasLootDB["namespaces"] and AtlasLootDB["namespaces"]["DefaultFrame"] then
		for k,v in pairs(AtlasLootDB["namespaces"]["DefaultFrame"]) do
			if v["point"] then
				v["point"] = nil
			end
		end
	end
	if AtlasLootDB and not AtlasLootDB.showWarning then
		StaticPopup_Show("ATLASLOOT_SAVED_VARIABLES")
		AtlasLootDB.showWarning = true
	end
	
    self.db = LibStub("AceDB-3.0"):New("AtlasLootDB")
    self.db:RegisterDefaults(AtlasLootDBDefaults);
	self.chardb = LibStub("AceDB-3.0"):New("AtlasLootCharDB")
    self.chardb:RegisterDefaults(AtlasLootDBDefaults);
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")

	-- Setup the AtlasLootTooltip
	self:SetupTooltip()
	-- This loads the Gui
	self:CreateAtlasInfoFrame()
	self:CreateAtlasLootPanel()
	self:CreateItemFrame()
	-- Options loader
	self:ReplaceOptions()
	-- Atlas 
	self:AtlasInitialize()
	-- QuickLook
	self:QuickLookInitialize()
	-- devtools
	if self.DevToolsInitialize then
		self:DevToolsInitialize()
	end
	self:CompareFrame_Create()
	self:EncounterJournal_Initialize()
	self:BonusRoll_Initialize()


	--#########
	-- Default Frame -- 40301 --
	--#########
	if((AtlasLootCharDB.AtlasLootVersion == nil) or (tonumber(AtlasLootCharDB.AtlasLootVersion) < tonumber(VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES))) then
		AtlasLootCharDB.AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
		--AtlasLootCharDB.AutoQuery = false;
	end

	--If EquipCompare is available, use it
	if((EquipCompare_RegisterTooltip) and (self.db.profile.EquipCompare == true)) then
		EquipCompare_RegisterTooltip(AtlasLootTooltip)
	end

	--if (self.db.profile.LoadAllLoDStartup == true) then
		--AtlasLoot:LoadModule("all")
	--end
	collectgarbage("collect")
    if LibStub:GetLibrary("LibAboutPanel", true) then
    	LibStub("LibAboutPanel").new(AL["AtlasLoot"], "AtlasLoot");
	end    
   	loaded = true
   	if AtlasLootDB then
		AtlasLootDB.showWarning = true
	end
end

do
	local refreshProfile = {}
	
	function AtlasLoot:RegisterOnProfileChanged(func)
		refreshProfile[#refreshProfile + 1] = func
	end

	function AtlasLoot:OnProfileChanged(event, database, newProfileKey)
	   self:RefreshAtlasLootPanel()
	   for k,v in ipairs(refreshProfile) do
	   		v()
	   end
	end

end
-- Only a simple print function 
function AtlasLoot:Print(...)
	DEFAULT_CHAT_FRAME:AddMessage(...)
end

-- Slash commands
do
	local slashCommand = {}
	-- msg - takes the argument for the /atlasloot command so that the appropriate action can be performed
	-- If someone types /atlasloot, bring up the options box
	function AtlasLoot:SlashCommand(msg, ...)
		msg = string.lower(msg)
		local saveMsg = msg
		msg = string.split(" ", msg) or msg
		if msg == AL["reset"] then
			self:Reset("frames");
		elseif msg == AL["options"] then
			self:OptionsToggle();
		elseif slashCommand[msg] then
			slashCommand[msg](self, string.split(" ", saveMsg))
		else
			if AtlasLootDefaultFrame then
				AtlasLootDefaultFrame:Show()
			elseif AtlasFrame then
				AtlasFrame:Show()
			end
			if msg == "secret" then
				AtlasLoot:ShowSecretPage()
			end
		end
	end
	
	function AtlasLoot:RegisterSlashCommand(com, func)
		slashCommand[string.lower(com)] = func
	end
end

-- Reset functions "/al reset"
do
	local resetFunctions = {
		quicklooks = {
			function()
				for i = 1,AtlasLoot.db.profile.NumQuickLooks do
					AtlasLoot.db.profile.QuickLooks[i].lootPage = nil
				end
				AtlasLoot:RefreshAtlasLootPanel()
			end
		},
		
	}

	--- Adds a reset function 
	-- /al reset <com>
	-- @param func the reset function
	-- @param ... the commands "/al reset <com>"
	-- @usage AtlasLoot:AddResetCommand(com, func)
	function AtlasLoot:AddResetCommand(func, ...)
		if type(func) == "function" then
			for i=1,select("#",...) do
				if not resetFunctions[select(i,...)] then resetFunctions[select(i,...)] = {} end
				resetFunctions[select(i,...)][#resetFunctions[select(i,...)]+1] = func
			end
		end
	end

	-- Resets: frames/quicklooks/wishlist/all
	function AtlasLoot:Reset(data)
		if data == "all" then
			for _,funcTab in pairs(resetFunctions) do
				for _,func in ipairs(funcTab) do
					func()
				end
			end
		elseif resetFunctions[data] then
			for _,func in ipairs(resetFunctions[data]) do
				func()
			end
		end
	end
end
-----------------------------
-- LootTable related functions
-----------------------------

function AtlasLoot:CreateSelectBossLineButton(parent, point, name)
	parent = parent or UIParent
	if not point or type(point) ~= "table" then point = {"TOPLEFT", parent, "TOPLEFT", 0, 0} end
	if not name or name == "" then
		--error("AtlasLoot:CreateItemButton: Enter a name.", 2)
		return
	end

	local bossLineButton = {}
	
	bossLineButton = CreateFrame("Button", name, parent)
	--bossLineButton:SetFrameStrata("HIGH")
	bossLineButton:SetWidth(336)
	bossLineButton:SetHeight(15)
	bossLineButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	bossLineButton:SetPoint(point[1], point[2], point[3], point[4], point[5])
	
	bossLineButton.Text = bossLineButton:CreateFontString(name.."_Text","OVERLAY","GameFontNormal")
	bossLineButton.Text:SetPoint("LEFT", bossLineButton, "LEFT")
	bossLineButton.Text:SetJustifyH("LEFT")
	bossLineButton.Text:SetText("")
	bossLineButton.Text:SetWidth(320)
	bossLineButton.Text:SetHeight(15)
	
	bossLineButton.Loot = bossLineButton:CreateTexture(name.."_Loot","OVERLAY")
	bossLineButton.Loot:SetPoint("RIGHT", bossLineButton, "RIGHT")
	bossLineButton.Loot:SetTexture(AtlasLoot.imagePath.."silver")
	bossLineButton.Loot:SetHeight(16)
	bossLineButton.Loot:SetWidth(16)
	bossLineButton.Loot:Hide()
	
	bossLineButton.Selected = bossLineButton:CreateTexture(name.."_Selected","OVERLAY")
	bossLineButton.Selected:SetPoint("RIGHT", bossLineButton, "RIGHT")
	bossLineButton.Selected:SetTexture(AtlasLoot.imagePath.."gold")
	bossLineButton.Selected:SetHeight(16)
	bossLineButton.Selected:SetWidth(16)
	bossLineButton.Selected:Hide()

	bossLineButton:Hide()
	
	return bossLineButton
end

--- Gets the location of dataID in TableRegister
-- @param dataID the name of the AtlasLootTable
-- @usage tLocation = AtlasLoot:GetTableLoaction(dataID)
-- @return table with the location of the dataID in the TableRegister (AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]] or nil
function AtlasLoot:GetTableLoaction(dataID)
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID].info and AtlasLoot_Data[dataID].info.instance then
		local instance = AtlasLoot_Data[dataID].info.instance
		for ini,iniTab in pairs(AtlasLoot_LootTableRegister) do
			if iniTab[instance] then
				return {ini, instance}
			end
		end
	else
		for ini,iniTab in pairs(AtlasLoot_LootTableRegister) do
			if iniTab[dataID] then
				return {ini, dataID}
			end
		end
	end
	
	return nil
end

--- Gets the table register table
-- See TableRegister\loottables.lua for more infos
-- @param dataID the name of the AtlasLootTable
-- @usage tableRegister = AtlasLoot:GetTableRegister(dataID)
-- @return Table register table
function AtlasLoot:GetTableRegister(dataID)
	if not dataID or type(dataID) ~= "string" then
		--error("AtlasLoot:GetTableRegister: Enter a available dataID <string>", 2)
		return
	end
	
	local lootTable
	local instancePage, tLocation
	
	dataID, instancePage = self:FormatDataID(dataID)
	tLocation = self:GetTableLoaction(dataID)
	
	if tLocation then
		lootTable = AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]
		if lootTable then 
			
			if type(lootTable) == "string" then
				if AtlasLoot_LootTableRegister[tLocation[1]][lootTable] then
					lootTable = AtlasLoot_LootTableRegister[tLocation[1]][lootTable]
				else
					--error("AtlasLoot:GetTableRegister: No entry found for "..lootTable, 2)
					return nil
				end
			end
		
			if not lootTable["Bosses"] then
				lootTable["Bosses"] = {}
				if lootTable["Info"].sortOrder then
					for _,tab in ipairs(lootTable["Info"].sortOrder) do
						if lootTable[tab] then
							for _,ini in ipairs(lootTable[tab]) do
								if not ini.hide then
									lootTable["Bosses"][#lootTable["Bosses"]+1] = CopyTable(ini)
								end
							end
						end
					end
				end
			end
			
			return lootTable
		end
	end
	
	return nil
end

--- Gets Loot and Info table for Atlas
-- self function is only used from Atlas, AtlasLoot need self too get the location of the LootTable
-- It not returns the Loottables itself, its only returns a infotable with all needed infos.
-- See TableRegister\loottables.lua for more infos
-- @param zoneID name of the instanceTable in Atlas
-- @usage LootTable, InfoTable = AtlasLoot:GetBossTableZoneID(zoneID)
-- @return Loottable info ( the ["Bosses"] table ) or nil
-- @return Infotable ( the ["Info"] table ) or nil
function AtlasLoot:GetBossTableZoneID(zoneID)
	local LootTable, InfoTable = "", ""
	local tLocation = self:GetTableLoaction(zoneID)
	if tLocation then
		LootTable = AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]
		InfoTable = AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]
		if type(LootTable) == "string" then
			if AtlasLoot_LootTableRegister[tLocation[1]][LootTable][tLocation[2]] then
				LootTable = AtlasLoot_LootTableRegister[tLocation[1]][LootTable][tLocation[2]]
			end
			if AtlasLoot_LootTableRegister[tLocation[1]][InfoTable]["Info"] then
				InfoTable = AtlasLoot_LootTableRegister[tLocation[1]][InfoTable]["Info"]
			end
		else
			LootTable = AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]["Bosses"]
			InfoTable = AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]["Info"]
		end
		
		if LootTable and not LootTable["Bosses"] then
			LootTable["Bosses"] = {}
			if InfoTable.sortOrder then
				for _,tab in ipairs(InfoTable.sortOrder) do
					if LootTable[tab] then
						for _,ini in ipairs(LootTable[tab]) do
							if not ini.hide then
								LootTable["Bosses"][#LootTable["Bosses"]+1] = CopyTable(ini)
							end
						end
					end
				end
			end
		end

		return LootTable, InfoTable
	else
		return nil,nil
	end
end

--- Gets a localized instance Type
-- @param instanceType "Normal", Heroic", "25Man", "25ManHeroic"
-- @return localized instance Type
function AtlasLoot:GetLocInstanceType(instanceType)
	if instanceType then
		if instanceType == "Normal" then
			instanceType = ""
		elseif instanceType == "Heroic" then
			instanceType = AL["Heroic"]
		elseif instanceType == "25Man" then
			instanceType = AL["25 Man"]
		elseif instanceType == "25ManHeroic" then
			instanceType = AL["25 Man Heroic"]
		elseif instanceType == "RaidFinder" then
			instanceType = AL["Raid Finder"]
		elseif instanceType == "Flexible" then
			instanceType = AL["Flexible"]
		else
			instanceType = nil
		end
	else
		instanceType = _G["UNKNOWN"]
	end
	return instanceType
end
	
--- Get boss name and instance name
-- Gets localized boss name and instance name from the loottable data
-- @param dataID the name of the AtlasLootTable
-- @param addInstanceName false\nil if no instance name behind the boss name is needed
-- @param addInstanceType false\nil if no instance type behind the boss name is needed
-- @param addPageNumber false\nil if no pagenumber behind the boss name is needed
-- @param isThunderforged false\nil if not thunderforged 
-- @usage local bossName, instanceName = AtlasLoot:GetTableInfo(dataID, addInstanceName, addInstanceType, addPageNumber)
-- @return localized boss name or table name
-- @return localized instance name
function AtlasLoot:GetTableInfo(dataID, addInstanceName, addInstanceType, addPageNumber, isThunderforged)
	if not dataID or type(dataID) ~= "string" then
		--error("AtlasLoot:GetTableInfo: Enter a available dataID <string>", 2)
		return
	end
	
	local bossName, instanceName, menuID
	local instancePage, tableRegister, instanceType
	local oriDataID = dataID
	
	dataID, instancePage = self:FormatDataID(dataID)
	tableRegister = self:GetTableRegister(dataID)
	instanceType = AtlasLoot:GetLootTableType(oriDataID)
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID].info and AtlasLoot_Data[dataID].info.menu then
		menuID = AtlasLoot_Data[dataID].info.menu
	end
	
	if tableRegister and tableRegister["Info"] and tableRegister["Info"][1] then
		instanceName = tableRegister["Info"][1]
	elseif menuID and AtlasLoot_Data[menuID] and AtlasLoot_Data[menuID].info and AtlasLoot_Data[menuID].info.name then
		instanceName = AtlasLoot_Data[menuID].info.name
	else
		instanceName = _G["UNKNOWN"]
	end
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID].info and AtlasLoot_Data[dataID].info.name then
		bossName = AtlasLoot_Data[dataID].info.name
		if bossName == "trash" then
			bossName = AL["Trash Mobs"]
		end
		if AtlasLoot_Data[dataID][instanceType] and AtlasLoot_Data[dataID][instanceType][instancePage] and AtlasLoot_Data[dataID][instanceType][instancePage].extraText then
			bossName = bossName..AtlasLoot_Data[dataID][instanceType][instancePage].extraText
		end
	else
		bossName = dataID
	end
	local instanceTypeOld = instanceType
	instanceType = self:GetLocInstanceType(instanceType)
	if isThunderforged then
		local name = _G[self.ItemFrame.Thunderforged:GetName().."Text"]:GetText()
		if instanceType == "" then
			instanceType = name
		else
			instanceType = instanceType.." "..name
		end
	end
	
	if addInstanceName and not addInstanceType and instanceName and instanceType ~= "" then
		bossName = bossName.." ("..instanceName..")"
	elseif addInstanceType and not addInstanceName and instanceType and instanceType ~= "" then
		bossName = bossName.." ("..instanceType..")"
	elseif addInstanceType and addInstanceName and instanceType and instanceName and instanceType ~= "" then
		bossName = bossName.." ("..instanceName.."-"..instanceType..")"
	end
	--GREY
	if addPageNumber and AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID][instanceTypeOld] then
		local maxPages = #AtlasLoot_Data[dataID][instanceTypeOld]
		if maxPages > 1 then
			bossName = bossName.." "..GREY.."["..instancePage.."/"..maxPages.."]"
		end
	end
	
	return bossName, instanceName
end

--- Format the dataID
-- Formats the dataID and filters out the pagenumber ( lootPage#pageNum )
-- @param dataID the name of the AtlasLootTable
-- @usage local dataID, instancePage = AtlasLoot:GetTableIndexFromDataID(dataID)
-- @return dataID
-- @return instancePage number
function AtlasLoot:FormatDataID(dataID)
	if not dataID or type(dataID) ~= "string" then
		--error("AtlasLoot:FormatDataID: Enter a available dataID <string>", 2)
		return
	end

	dataID = gsub(dataID, "#25ManHeroic", "")
	dataID = gsub(dataID, "#25Man", "")

	local _,_,instanceTableIndex = string.find(dataID, "#(%d+)")
	local last = string.find(dataID, "#last")
	
	--dataID = gsub(dataID, "#(%d+)", "")
	--dataID = gsub(dataID, "#last", "")
	dataID = gsub(dataID, "#(.+)", "")
	if string.find(dataID, "MENU") or (AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID].info and AtlasLoot_Data[dataID].info.menu) then
		if AtlasLoot_Data[dataID].info.Modules then
			for k,v in ipairs(AtlasLoot_Data[dataID].info.Modules) do
				self:LoadModule(v)
			end
		else
			--self:LoadModule("all")
		end
	end
	local dataIDLoaded = AtlasLoot:CheckDataID(dataID)
	if not dataIDLoaded then
		return 
	end
	
	if last then
		local lootTableType = AtlasLoot:GetLootTableType(dataID)
		instanceTableIndex = #AtlasLoot_Data[dataID][lootTableType]
	end
	instanceTableIndex = instanceTableIndex or 1
	return dataID, tonumber(instanceTableIndex)
end

-- Heroic check
do
	local lootTableTypes = AtlasLoot.lootTableTypes
	local lootTableTypesCheck = {
		["Normal"] = { "Heroic", "25Man", "25ManHeroic", "RaidFinder", "Flexible" },
		["Heroic"] = { "Normal", "25ManHeroic", "25Man", "RaidFinder", "Flexible" },
		["25Man"] = { "25ManHeroic", "Normal", "Heroic", "RaidFinder", "Flexible" },
		["25ManHeroic"] = { "25Man", "Heroic", "Normal", "RaidFinder", "Flexible" },
		["RaidFinder"] = { "Normal", "Heroic", "25Man", "25ManHeroic", "Flexible" },
		["Flexible"] = { "Normal", "Heroic", "25Man", "25ManHeroic", "RaidFinder" },
	}
	
	function AtlasLoot:GetLootTableTypeFromDataID(dataID)
		if dataID then
			for k,v in ipairs(lootTableTypes) do
				if string.match(dataID, "#"..v) then
					--local _,_,newLootTableType = string.match(dataID, "#"..v)
					return v
				end
			end
			return "Normal"
		end
	end

	--- Gets the current LootTableType
	-- @param dataID the name of the AtlasLootTable
	-- @usage local lootTableType = AtlasLoot:GetLootTableType(dataID)
	-- @return lootTableType: "Normal", "Heroic", "25Man", "25ManHeroic"
	function AtlasLoot:GetLootTableType(dataID)
		if not self.db.profile.LootTableType then
			self.db.profile.LootTableType = "Normal"
		end
		local lootTableType = self.db.profile.LootTableType
		local factionAdd = ""
		if AtlasLoot:GetEnglishFaction() == "Horde" then
			factionAdd = "_H"
		else
			factionAdd = "_A"
		end
		-- dataID#savedTableType
		for k,v in ipairs(lootTableTypes) do
			if dataID and string.match(dataID, "#"..v) then
				--local _,_,newLootTableType = string.match(dataID, "#"..v)
				lootTableType = v
			end
		end
		if dataID then
			dataID = self:FormatDataID(dataID)
		end
		if dataID and AtlasLoot_Data[dataID] then
			-- Faction specific items
			if not AtlasLoot_Data[dataID].factionCheck then
				for k,v in ipairs(lootTableTypes) do
					if AtlasLoot_Data[dataID][v..factionAdd] then
						for page in ipairs(AtlasLoot_Data[dataID][v..factionAdd]) do
							if AtlasLoot_Data[dataID][v..factionAdd][page].merge and AtlasLoot_Data[dataID][v][page] then
								-- Merge tables here
								local saveTab = {}
								-- First check all entry (maybe we must override some items)
								for index,tab in ipairs(AtlasLoot_Data[dataID][v][page]) do
									saveTab[tab[1]] = index
								end
								-- Now merge
								for index,tab in ipairs(AtlasLoot_Data[dataID][v..factionAdd][page]) do
									if saveTab[tab[1]] then
										-- Replace a item if it already exists
										AtlasLoot_Data[dataID][v][page][saveTab[tab[1]]] = tab
									else
										table.insert(AtlasLoot_Data[dataID][v][page], tab)
									end
								end
							else
								if not AtlasLoot_Data[dataID][v] then AtlasLoot_Data[dataID][v] = {} end
								AtlasLoot_Data[dataID][v][page] = AtlasLoot_Data[dataID][v..factionAdd][page]
							end
						end
						-- remove old pointers to the tables
						AtlasLoot_Data[dataID][v..factionAdd] = nil
					end
				end
				AtlasLoot_Data[dataID].factionCheck = true
			end

			if AtlasLoot_Data[dataID][lootTableType] then
				return lootTableType
			else
				for k,v in ipairs(lootTableTypesCheck[lootTableType]) do
					if v and type(v) == "string" then
						if AtlasLoot_Data[dataID][v] then
							return v
						end
					end
				end
			end
		else
			return lootTableType
		end
	end

	--- Sets the current LootTableType
	-- @param lootTableType "Normal", "Heroic", "25Man", "25ManHeroic"
	-- @param dataID the name of the AtlasLootTable
	-- @usage AtlasLoot:SetLootTableType(lootTableType)
	function AtlasLoot:SetLootTableType(lootTableType, dataID)
		for k,v in ipairs(lootTableTypes) do
			if v == lootTableType then
				self.db.profile.LootTableType = lootTableType
				if dataID then
					self:ShowLootPage(dataID)
				end
				return
			end
		end 
		--error("AtlasLoot:SetLootTableType: "..lootTableType.." is not a available lootTableType", 2 )
	end
end

-- table format
do
	local tableFormatFunctions = {}

	--- Adds a Table format function 
	-- @param name name of the format function
	-- @param func 
	-- @param save a function that returns if the format function is enabled or disabled
	-- @usage AtlasLoot:AddTableFormatFunction(name, func, save)
	function AtlasLoot:AddTableFormatFunction(name, func, save)
		if not name or not func or type(func) ~= "function" then return end
		if save and type(save) ~= "function" then return end
		
		if not tableFormatFunctions[name] then
			tableFormatFunctions[name] = { func, save }
		end

	end

	--- Gets the Table format function
	-- @param name name of the format function
	-- @usage formatFunction = AtlasLoot:GetTableFormatFunction(name)
	-- @return Table format function
	function AtlasLoot:GetTableFormatFunction(name)
		if not name or not tableFormatFunctions[name] then return end
		return tableFormatFunctions[name][1]
	end
	
	--- Formats the loottable
	-- @param loottable a atlasloot loottable
	-- @usage newLoottable = AtlasLoot:FormatLootTable(loottable)
	-- @return Formated tooltip
	function AtlasLoot:FormatLootTable(dataID, loottable)
		for k,v in pairs(tableFormatFunctions) do
			if v[2] and v[2]() then
				loottable = v[1](v, loottable)
			end
		end
		return loottable
	end
end

-- Tooltip Add for itemButtons
do
	local toolTipAdds = {}

	--- Adds a extra text to a ToolTip
	-- @param name name of the ToolTip function
	-- @param func the called function on ToolTipSet
	-- @param save a function that returns if the tooltipadd is enabled or disabled
	-- @usage AtlasLoot:AddToolTipTextFunc(name, func, save)
	function AtlasLoot:AddToolTipTextFunc(name, func, save)
		if not name or not func or not save or type(func) ~= "function" or type(save) ~= "function" then return end
		if not toolTipAdds[name] then
			toolTipAdds[name] = { func, save }
		end
	end

	--- Gets the ToolTip Text function
	-- @param name name of the ToolTip function
	-- @usage AtlasLoot:GetToolTipTextFunc(name)
	-- @return ToolTip function
	function AtlasLoot:GetToolTipTextFunc(name)
		if not name or not toolTipAdds[name] then return end
		return toolTipAdds[name][1]
	end
	
	
	--- Adds the text to the given tooltip
	-- @param tooltip the tooltip 
	-- @param infoTab the infotable { spellID, itemID, itemName, extraText, itemTexture, itemPrice, itemDroprate }
	-- @usage AtlasLoot:AddTextToTooltip(tooltip, infoTab)
	function AtlasLoot:AddTextToTooltip(tooltip, infoTab)
		if not tooltip or not infoTab then return end
		for k,v in pairs(toolTipAdds) do
			if v[2]() then
				tooltip:AddLine(v[1](infoTab))
			end
		end
	end
end

--- Returns the loottable
-- @param dataID the name of the AtlasLootTable
-- @usage lootTable = AtlasLoot:GetLootPageFromDataID(dataID)
-- @return a link to the loottable
function AtlasLoot:GetLootPageFromDataID(dataID)
	if not dataID or type(dataID) ~= "string" then
		--error("AtlasLoot:GetLootPageFromDataID: Enter a available dataID <string>", 2)
		return
	end
	local instancePage, lootTableType, lootTable
	local dataIDOri = dataID
	dataID, instancePage = self:FormatDataID(dataID)
	lootTableType = self:GetLootTableType(dataIDOri) or "Normal"
	if not AtlasLoot_Data[dataID] or not AtlasLoot_Data[dataID][lootTableType] or not AtlasLoot_Data[dataID][lootTableType][instancePage] then
		print(string.format("AtlasLoot_Data[\"%s\"][\"%s\"][%s] not found. (%s)", dataID or "nil", lootTableType or "nil", instancePage or "nil", dataIDOri or "nil"))
		return
	end
	lootTable = AtlasLoot_Data[dataID][lootTableType][instancePage]
	for k,v in ipairs(lootTable) do
		if type(v[1]) == "table" or type(v[2]) == "table" then
			if AtlasLoot:GetEnglishFaction() == "Horde" then
				if v[1] then
					lootTable[k] = v[1]
				else
					lootTable[k] = nil
				end
			elseif AtlasLoot:GetEnglishFaction() == "Alliance" then
				if v[2] then
					lootTable[k] = v[2]
				else
					lootTable[k] = nil
				end
			else
				lootTable[k] = nil
			end
		end
	end
	lootTable = self:FormatLootTable(dataID, lootTable)
	if type(lootTable) == "string" then
		AtlasLoot:ShowLootPage(lootTable)
		return
	end
	return lootTable
end

--- Gets next and previous loot page
-- @param dataID the name of the AtlasLootTable
-- @param curPage the current loot table page
-- @usage local nextPage, prevPage = AtlasLoot:GetNextPrevPage(dataID, curPage)
-- @return the next page (dataID)
-- @return the previous page (dataID)
function AtlasLoot:GetNextPrevPage(dataID, curPage)
	if not dataID or type(dataID) ~= "string" then
		--error("AtlasLoot:GetNextPrevPage: Enter a available dataID <string>", 2)
		return
	end
	
	local nextPage, prevPage
	local bossesPos
	local instancePage, lootTableType, tableRegister, tablePages
	
	dataID, instancePage = self:FormatDataID(dataID)
	lootTableType = self:GetLootTableType(dataID)
	tableRegister = self:GetTableRegister(dataID)
	
	if not curPage then
		curPage = instancePage
	end
	
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID][lootTableType] then
	
		tablePages = #AtlasLoot_Data[dataID][lootTableType]
		
		if tablePages > 1 then
			if tablePages ~= curPage then
				if curPage > 1 then
					nextPage = curPage + 1
					prevPage = curPage - 1
				else
					nextPage = curPage + 1
				end
			else
				if curPage > 1 then
					prevPage = curPage - 1
				end
			end
		end
		
		if tableRegister then
			for k,v in ipairs(tableRegister["Bosses"]) do
				if v[1] == dataID then
					bossesPos = k
				end
			end
		end

		if bossesPos then
			if not prevPage then
				if bossesPos > 1 then
					for i=1,bossesPos do
						if tableRegister["Bosses"][bossesPos-i] and AtlasLoot_Data[tableRegister["Bosses"][bossesPos-i][1]] and not tableRegister["Bosses"][bossesPos-i].hide then
							if not AtlasLoot_Data[tableRegister["Bosses"][bossesPos-i][1]].info.NextPrevDisable then
								prevPage = tableRegister["Bosses"][bossesPos-i][1]
								prevPage = prevPage.."#last"
								break
							end
						end
					end
				end
			end
			
			if not nextPage then
				if bossesPos ~= #tableRegister["Bosses"] then
					for i=bossesPos+1, #tableRegister["Bosses"] do
						if tableRegister["Bosses"][i] and AtlasLoot_Data[tableRegister["Bosses"][i][1]] and not tableRegister["Bosses"][i].hide then
							if not AtlasLoot_Data[tableRegister["Bosses"][i][1]].info.NextPrevDisable then
								nextPage = tableRegister["Bosses"][i][1]
								break
							end
						end
					end
				end
			end
		end

		
		if nextPage and type(nextPage) == "number" then
			nextPage = dataID.."#"..nextPage
		end
		if prevPage and type(prevPage) == "number" then
			prevPage = dataID.."#"..prevPage
		end	
	end
	
	return nextPage, prevPage
end

--- Shows the Loot page
-- @param dataID the name of the AtlasLootTable
-- @param pFrame Sets the itemButton Position. Nil will call AtlasLoot:GetItemInfoFrame()  ( this use frame:SetPoint(...) )
-- @usage AtlasLoot:ShowLootPage(dataID, pFrame)
function AtlasLoot:ShowLootPage(dataID, pFrame)
	if not dataID then
		--self:Print("No dataID!")
		return
	end
	
	if not pFrame or pFrame == "" then
		pFrame = AtlasLoot:GetItemInfoFrame()
	end
	self:SetItemInfoFrame(pFrame)
	
	local instancePage, nextPage, prevPage, lootTableType, bossName, moduleName
	local saveDataID = dataID
	
	dataID, instancePage = self:FormatDataID(dataID)
	nextPage, prevPage = self:GetNextPrevPage(dataID, instancePage)
	lootTableType = self:GetLootTableType(saveDataID)
	
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID].info and AtlasLoot_Data[dataID].info.module then
		moduleName = AtlasLoot_Data[dataID].info.module
	end
	
	if self.ItemFrame.dataID == "FormatedList" and dataID ~= "FormatedList" then
		wipe(AtlasLoot_Data["FormatedList"]["Normal"])
		collectgarbage("collect")
	end
	
	self:ClearLootPage()
	self:SetItemTable(self:GetLootPageFromDataID(saveDataID))
	
	self.ItemFrame.dataID = saveDataID
	self.ItemFrame.lootTableType = lootTableType
	
	if nextPage then
		self.ItemFrame.Next.lootpage = nextPage
		self.ItemFrame.Next:Show()
	end
	if prevPage then
		self.ItemFrame.Prev.lootpage = prevPage
		self.ItemFrame.Prev:Show()
	end
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID].info and AtlasLoot_Data[dataID].info.menu then
		self.ItemFrame.Back.lootpage = AtlasLoot_Data[dataID].info.menu
		self.ItemFrame.Back:Show()
	end
	
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID].info then
		if AtlasLoot_Data[dataID].info.instance == "ThroneofThunder" then
			_G[self.ItemFrame.Thunderforged:GetName().."Text"]:SetText(AL["Thunderforged"])
		elseif AtlasLoot_Data[dataID].info.instance == "SiegeofOrgrimmar" then
			_G[self.ItemFrame.Thunderforged:GetName().."Text"]:SetText(AL["Warforged"])
		end
	end

	
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID]["RaidFinder"] and lootTableType ~= "RaidFinder" then
		self.ItemFrame.RaidFinder:Show()
		self.ItemFrame.RaidFinder:SetChecked(false)
		self.ItemFrame.RaidFinder:Enable()
	end
	if AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID]["Flexible"] and lootTableType ~= "Flexible" then
		self.ItemFrame.Flexible:Show()
		self.ItemFrame.Flexible:SetChecked(false)
		self.ItemFrame.Flexible:Enable()
	end
	
	if lootTableType == "RaidFinder" and AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID]["RaidFinder"] then
		self.ItemFrame.RaidFinder:Show()
		self.ItemFrame.RaidFinder:SetChecked(true)
		self.ItemFrame.RaidFinder:Enable()
		if AtlasLoot_Data[dataID]["Heroic"] then
			self.ItemFrame.Heroic:Show()
			self.ItemFrame.Heroic:SetChecked(false)
			self.ItemFrame.Heroic:Enable()
		end --"Flexible"
	elseif lootTableType == "Flexible" and AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID]["Flexible"] then
		self.ItemFrame.Flexible:Show()
		self.ItemFrame.Flexible:SetChecked(true)
		self.ItemFrame.Flexible:Enable()
		if AtlasLoot_Data[dataID]["Heroic"] then
			self.ItemFrame.Heroic:Show()
			self.ItemFrame.Heroic:SetChecked(false)
			self.ItemFrame.Heroic:Enable()
		end
	elseif lootTableType == "Heroic" and AtlasLoot_Data[dataID]["Heroic"] then
		self.ItemFrame.Heroic:Show()
		self.ItemFrame.Heroic:SetChecked(true)
		if AtlasLoot_Data[dataID]["Normal"] then
			self.ItemFrame.Heroic:Enable()
		else
			self.ItemFrame.Heroic:Disable()
		end
	elseif lootTableType == "25ManHeroic" and AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID]["25ManHeroic"] then
		self.ItemFrame.Heroic:Show()
		self.ItemFrame.Heroic:SetChecked(true)
		if AtlasLoot_Data[dataID]["25Man"] then
			self.ItemFrame.Heroic:Enable()
		else
			self.ItemFrame.Heroic:Disable()
		end
	elseif lootTableType == "Normal" and AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID]["Normal"] then
		if AtlasLoot_Data[dataID]["Heroic"] then
			self.ItemFrame.Heroic:Show()
			self.ItemFrame.Heroic:SetChecked(false)
			self.ItemFrame.Heroic:Enable()
		end
	elseif lootTableType == "25Man" and AtlasLoot_Data[dataID] and AtlasLoot_Data[dataID]["25Man"] then
		if AtlasLoot_Data[dataID]["25ManHeroic"] then
			self.ItemFrame.Heroic:Show()
			self.ItemFrame.Heroic:SetChecked(false)
			self.ItemFrame.Heroic:Enable()
		end
	end
	
	if lootTableType == "RaidFinder" or lootTableType == "Flexible" then
		-- do nothing
	elseif ( lootTableType == "Normal" or lootTableType == "Heroic" ) and AtlasLoot_Data[dataID] and ( AtlasLoot_Data[dataID]["25Man"] or AtlasLoot_Data[dataID]["25ManHeroic"] ) then
		self.ItemFrame.Switch:SetText(AL["Show 25 Man Loot"])
		self.ItemFrame.Switch:Show()
	elseif ( lootTableType == "25Man" or lootTableType == "25ManHeroic" ) and AtlasLoot_Data[dataID] and ( AtlasLoot_Data[dataID]["Normal"] or AtlasLoot_Data[dataID]["Heroic"] ) then
		self.ItemFrame.Switch:SetText(AL["Show 10 Man Loot"])
		self.ItemFrame.Switch:Show()
	elseif self.ItemFrame.Switch.changePoint and AtlasLoot_Data[dataID] then
		if AtlasLoot.db.profile.ShowLootTablePrice then
			if AtlasLoot_Data[dataID].info.switchText and AtlasLoot_Data[dataID].info.switchText[1] then
				self.ItemFrame.Switch:SetText(AtlasLoot_Data[dataID].info.switchText[1])
			else
				if moduleName == "AtlasLootCrafting" then
					self.ItemFrame.Switch:SetText(AL["Skill"])
				else
					self.ItemFrame.Switch:SetText(AL["Show Slot"])
				end
			end
		else
			if AtlasLoot_Data[dataID].info.switchText and AtlasLoot_Data[dataID].info.switchText[2] then
				self.ItemFrame.Switch:SetText(AtlasLoot_Data[dataID].info.switchText[2])
			else
				if moduleName == "AtlasLootCrafting" then
					self.ItemFrame.Switch:SetText(AL["Location"])
				else
					self.ItemFrame.Switch:SetText(AL["Show Price"])
				end
			end
		end
		self.ItemFrame.Switch:Show()
	end
	
	AtlasLoot.ItemFrame.EncounterJournal.info = dataID
	AtlasLoot:EncounterJournal_ButtonsRefresh()
	if AtlasLoot:BonusLoot_GetDataIdInfo(dataID) then
		AtlasLoot.ItemFrame.BonusRoll:Show()
		AtlasLoot.CanShowBonusRoll = true
	else
		AtlasLoot.ItemFrame.BonusRoll:Hide()
		AtlasLoot.CanShowBonusRoll = false
	end
	AtlasLoot:ItemFrame_IconList_Refresh()
	
	if self.ThunderforgeAviable then
		self.ItemFrame.Thunderforged:Show()
		self.ItemFrame.Thunderforged:SetChecked(self.db.profile.ShowThunderforged)
		bossName = self:GetTableInfo(saveDataID, false, true, true, self.db.profile.ShowThunderforged)
	else
		self.ItemFrame.Thunderforged:Hide()
		bossName = self:GetTableInfo(saveDataID, false, true, true)
	end
	self.ItemFrame.BossName:SetText(bossName)
	
	
	if string.find(dataID, "SortedTable") then
		self.ItemFrame.QuickLooks:Hide()
		self.ItemFrame.QuickLooksName:Hide()
	else
		self:SetEnableQuickLook(self:GetEnableQuickLook())
	end
end

-- Table format (wishlist, filter, ...)
do
	local lootTableTypes = {"Normal", "Heroic", "25Man", "25ManHeroic"}

	local function SortTable(t, f)
		local a = {}
		for k in pairs(t) do a[#a + 1] = k end
		table.sort(a, f)
		local i = 0
		return function()
			i = i + 1
			return a[i], t[a[i]]
		end
	end

	function AtlasLoot:CreateFormatedLootPage(itemTable)
		if not itemTable or type(itemTable) ~= "table" then return end
		local itemCache = {}
		if not AtlasLoot_Data["FormatedList"] then
			AtlasLoot_Data["FormatedList"] = {
				["Normal"] = {},
				["Info"] = {
					name = "",
				},
			}
		else
			wipe(AtlasLoot_Data["FormatedList"]["Normal"])
			AtlasLoot_Data["FormatedList"]["Info"].name = ""
		end
		
		for _,item in ipairs(itemTable) do
			if type(item) == "table" then
				if item[6] then
					if not itemCache[item[6]] then
						itemCache[item[6]] = {}
					end
					if not itemCache[item[6]][item[7]] then
						itemCache[item[6]][item[7]] = {}
					end
					table.insert( itemCache[item[6]][item[7]], { item[1], item[2], item[3], item[4], item[5], item[6], item[7] } )
				end
			end
		end
		
		local itemCount = 1
		local pageCount = 1
		local bossName, instanceName, spellID, itemID
		for instance, instanceTab in SortTable(itemCache) do
			for _,iniType in ipairs(lootTableTypes) do
				if instanceTab[iniType] then
					if not AtlasLoot_Data["FormatedList"]["Normal"][pageCount] then AtlasLoot_Data["FormatedList"]["Normal"][pageCount] = {} end
					if ( #AtlasLoot_Data["FormatedList"]["Normal"][pageCount] >= 30 ) or ( #AtlasLoot_Data["FormatedList"]["Normal"][pageCount] + #instanceTab[iniType] + 2 >= 30 ) then
						pageCount = pageCount + 1
						itemCount = 1
						if not AtlasLoot_Data["FormatedList"]["Normal"][pageCount] then AtlasLoot_Data["FormatedList"]["Normal"][pageCount] = {} end
					end
					
					bossName, instanceName = AtlasLoot:GetTableInfo(instance)
					if itemCount ~= 1 and itemCount ~= 16 then itemCount = itemCount + 1 end
					table.insert( AtlasLoot_Data["FormatedList"]["Normal"][pageCount], { itemCount, instance, "INV_Box_01", "=q6="..bossName.." ("..iniType..")", "=q5="..instanceName } )
					itemCount = itemCount + 1
					
					for _,item in ipairs(instanceTab[iniType]) do
						if not AtlasLoot_Data["FormatedList"]["Normal"][pageCount] then AtlasLoot_Data["FormatedList"]["Normal"][pageCount] = {} end
						if ( #AtlasLoot_Data["FormatedList"]["Normal"][pageCount] >= 30 ) then
							pageCount = pageCount + 1
							itemCount = 1
							if not AtlasLoot_Data["FormatedList"]["Normal"][pageCount] then AtlasLoot_Data["FormatedList"]["Normal"][pageCount] = {} end
						end
						
						spellID = item[2]
						itemID = ""
						if item[2] and item[2] ~= "" and item[2] > 0 and item[3] ~= "" then
							spellID = "s"..item[2]
							itemID = item[3]
						end
						
						table.insert( AtlasLoot_Data["FormatedList"]["Normal"][pageCount], { itemCount, spellID, itemID, item[4], item[5] } )
						--spellID, itemID, itemName, extraText, dataID, lootTableType
						itemCount = itemCount + 1
					end
				end
			end
		end
		AtlasLoot:ShowLootPage("FormatedList")
		itemCache = nil
	end
end
-----------------------------
-- pFrame (ItemInfoFrame)
-----------------------------
-- Register pFrame
do
	local function hideOtherFramesOnShow(self)
		for k,v in pairs(pFrameRegister) do
			if k ~= self.AtlasLootRegisterName and v[2] then
				_G[v[2]]:Hide()
			end
		end
	end

	local function setHideOtherFramesOnShow(name, pFrame)
		if pFrame and pFrame[2] then
			local frame = _G[pFrame[2]]
			if frame then
				frame.AtlasLootRegisterName = name
				frame:HookScript("OnShow", hideOtherFramesOnShow)
			end
		end
	end
	--- Registers a pFrame for ItemFrame
	-- Register a new Frame Position for the AtlasLoot ItemFrame
	-- @param name the name of the pFrame
	-- @param pFrame Sets the itemButton Position. self use frame:SetPoint(...)
	-- @usage AtlasLoot:RegisterPFrame("Atlas", { "TOPLEFT", "AtlasFrame", "TOPLEFT", "18", "-84" })
	function AtlasLoot:RegisterPFrame(name, pFrame)
		if not name or not pFrame or type(pFrame) ~= "table" then return end
		if _G[pFrame[2]] then
			pFrameRegister[name] = pFrame
			setHideOtherFramesOnShow(name, pFrame)
		end
	end
end

--- Set the Position of the ItemFrame
-- @param pFrame can be a string with the name from a registered pFrame ( AtlasLoot:RegisterPFrame ) or a table
-- @usage
-- AtlasLoot:RegisterPFrame("Atlas", { "TOPLEFT", "AtlasFrame", "TOPLEFT", "18", "-84" })
-- AtlasLoot:SetItemInfoFrame("Atlas")
-- @usage AtlasLoot:SetItemInfoFrame({ "TOPLEFT", "AtlasFrame", "TOPLEFT", "18", "-84" })
function AtlasLoot:SetItemInfoFrame(pFrame)
	if not AtlasLootItemsFrame then AtlasLoot:CreateItemFrame() end
	if pFrame and type(pFrame) == "table" then
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(pFrame[2]);
		AtlasLootItemsFrame:SetPoint(pFrame[1], pFrame[2], pFrame[3], pFrame[4], pFrame[5]);
	elseif pFrame and type(pFrame) == "string" then
		if pFrameRegister[pFrame] then
			pFrame = pFrameRegister[pFrame]
			if _G[pFrame[2]] then
				AtlasLootItemsFrame:ClearAllPoints();
				AtlasLootItemsFrame:SetParent(pFrame[2]);
				AtlasLootItemsFrame:SetPoint(pFrame[1], pFrame[2], pFrame[3], pFrame[4], pFrame[5]);
			else
				self:SetItemInfoFrame()
			end
		end
	elseif ( AtlasFrame ) then
		--If no pFrame is specified and Atlas is installed, anchor in Atlas
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(AtlasFrame);
		AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
	else
		--Last resort, dump the items frame in the middle of the screen
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(UIParent);
		AtlasLootItemsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	end
	AtlasLootItemsFrame:Show();
end

--- Gets current parent of ItemFrame
-- Only works if the frame is registered with AtlasLoot:RegisterPFrame
-- @usage local pFrame = AtlasLoot:GetItemInfoFrame()
-- @return pFrame
function AtlasLoot:GetItemInfoFrame()
	for k,v in pairs(pFrameRegister) do
		if k and _G[v[2]]:IsShown() then
			return k
		end
	end
end

-- Module Enabler
function AtlasLoot:GetModuleEnabled(module)
	return self.db.profile.modules[module]
end

function AtlasLoot:SetModuleEnabled(module, value)
	local old = self.db.profile.modules[module]
	self.db.profile.modules[module] = value
	if old ~= value then
		if value then
			self:EnableModule(module)
		else
			self:DisableModule(module)
		end
	end
end

--- Gets item equip infos and format it
-- self creats a string that contains infos about the item (Amortype, Weapon,...)
-- @param itemID The item ID
-- @return item equip-info string
-- @usage local itemEquipInfo = AtlasLoot:GetItemEquipInfo(12345)
function AtlasLoot:GetItemEquipInfo(itemID)
	if not itemID or itemID == "" or type(itemID) ~= "number" then return "" end
	local _, _, _, _, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(itemID)
	if not itemType or not itemEquipLoc then return "" end
	local tempText = ""
	if _G[itemEquipLoc] then
		if itemType == ENCHSLOT_WEAPON then
			tempText = itemSubType..', '..itemType
		else
			tempText = _G[itemEquipLoc]..', '..itemSubType
		end
	elseif itemSubType and string.find(itemSubType, MONEY) then
		tempText = MONEY
	end
	return tempText
end

-- AtlasLoot:GetEnchantLink()
do
	local AtlasLootScanTooltip = CreateFrame("GAMETOOLTIP","AtlasLootScanTooltip",nil,"GameTooltipTemplate")
	AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	
	--- Gets a enchant link
	-- self creats a chatlink for tradeskill links
	-- @param enchantID 
	-- @return the enchant link
	-- @usage local enchantLink = AtlasLoot:GetEnchantLink(12345)
	function AtlasLoot:GetEnchantLink(enchantID)
		if not enchantID then return end
		local EnchantLink = nil
		AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		AtlasLootScanTooltip:ClearLines();
		AtlasLootScanTooltip:SetHyperlink("enchant:"..enchantID);
		AtlasLootScanTooltip:Show()
		local tooltipline = _G["AtlasLootScanTooltipTextLeft1"]
		local text = tooltipline:GetText()
		if text and string.find(text, ":") then
			EnchantLink = "|cffffd000|Henchant:"..enchantID.."|h["..text.."]|h|r"
		else
			EnchantLink = GetSpellLink(enchantID)
		end
		AtlasLootScanTooltip:Hide()
		return EnchantLink
	end

	--- Gets the max-lvl from a Heirloom
	-- @param itemID 
	function AtlasLoot:GetHeirloomMaxLvl(itemID)
		if not itemID then return end
		local maxLvl = 85
		local _,itemLink,itemRarity = GetItemInfo(itemID)
		if itemRarity ~= 7 then return end
		AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		AtlasLootScanTooltip:ClearLines()
		AtlasLootScanTooltip:SetHyperlink(itemLink)
		AtlasLootScanTooltip:Show()
		local tooltipline = _G["AtlasLootScanTooltipTextLeft1"]
		for i = 1,AtlasLootScanTooltip:NumLines() do
			tooltipline = _G["AtlasLootScanTooltipTextLeft"..i]:GetText()
			if string.match(tooltipline, ITEM_LEVEL_RANGE) then
				maxLvl = tonumber(string.match(tooltipline, "%d%d"))
				break
			end
		end
		AtlasLootScanTooltip:Hide()
		return maxLvl
	end
	
	--/script DEFAULT_CHAT_FRAME:AddMessage("\124cffffff00\124Hquest:5090:50\124h[A Call to Arms: The Plaguelands!]\124h\124r");
	function AtlasLoot:GetQuestName(questID)
		if not questID then return end
		local questName
		AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		AtlasLootScanTooltip:ClearLines();
		AtlasLootScanTooltip:SetHyperlink("quest:"..questID);
		AtlasLootScanTooltip:Show()
		
		--local lastTime = GetTime()
		--while not questName or questName == "" do
			questName = _G["AtlasLootScanTooltipTextLeft1"]:GetText()
			--if (GetTime() - lastTime) > 0.05 then
				--break
			--end
		--end
		
		AtlasLootScanTooltip:Hide()
		
		return questName or "", questLink
	end
end

function AtlasLoot:CheckHeroic(itemTable)
	local checkName = {
		"|cffFF0000"..AL["Heroic Mode"],
		"=q6=#j3#",
	}
	
	if itemTable then
		for itemNum,item in ipairs(itemTable) do
			for k,v in ipairs(checkName) do
				if item[4] == v then
					return itemNum
				end
			end
		end
	else
		for itemNum,item in ipairs(AtlasLoot.ItemFrame.ItemButtons) do
			for k,v in ipairs(checkName) do
				if item.Frame.Name:GetText() == v then
					return itemNum
				end
			end
		end
	end
end

--- Returns a MapName by ID
-- This function only replace nil with a "error" string
-- @param id MapId ( http://www.wowpedia.org/MapID )
function AtlasLoot:GetMapNameByID(id)
	if not id then 
		return "NIL Map ID"
	end
	local name = GetMapNameByID(id)
	if name then 
		return name
	else
		return "No MapName found for ID "..id
	end
end

--- Pandas are bad in start zones :/
-- Returns Alliance if no faction is found or the char is Neutral
function AtlasLoot:GetEnglishFaction()
	local englishFaction = UnitFactionGroup("player")
	return not englishFaction or englishFaction == "Neutral" and "Alliance" or englishFaction
end
-- Hihi :)
function AtlasLoot:ShowSecretPage()
	if not AtlasLoot_Data["SECRET_PAGE"] then 
		AtlasLoot_Data["SECRET_PAGE"] = {
			["Normal"] = {
				{
					{ 1, 0, "INV_Box_01", "=q6=GM", ""};
					{ 2, 12064};
					{ 3, 2586};
					{ 4, 11508};
					{ 6, 0, "INV_Box_01", "=q6=Artifact", ""};
					{ 7, 36942};
					{ 8, 33475};
					{ 9, 18582};
					{ 10, 18583};
					{ 11, 18584};
					{ 12, 12947};
					{ 13, 32824};
					{ 14, 80237};
					{ 16, 0, "INV_Box_01", "=q6=Legendary", ""};
					{ 17, 80211};
					{ 18, 43651};
					{ 19, 22736};
					{ 20, 25596};
					{ 21, 17142};
					{ 22, 77497};
					{ 23, 13262};
					{ 24, 81418};
				};
			};
			info = {
				name = "Secret",
				module = "NON"
			};
		}
	end
	
	AtlasLoot:ShowLootPage("SECRET_PAGE")
end