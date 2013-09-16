-- $Id: AtlasLoot_Loader.lua 4017 2012-11-28 22:25:55Z lag123 $
--[[
Atlasloot Enhanced
Author Hegarol
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)

Functions:
]]
AtlasLoot = LibStub("AceAddon-3.0"):NewAddon("AtlasLoot")

AtlasLootLoaderDB = {}

--Instance required libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

--List with Modules
AtlasLoot.Modules = {
	{"AtlasLootClassicWoW", "AtlasLoot_ClassicWoW", false, "", AL["Classic WoW"] },
	{"AtlasLootBurningCrusade", "AtlasLoot_BurningCrusade", false, "", AL["Burning Crusade"] },
	{"AtlasLootWotLK", "AtlasLoot_WrathoftheLichKing", false, "", AL["Wrath of the Lich King"] },
	{"AtlasLootCataclysm", "AtlasLoot_Cataclysm", false, "", AL["Cataclysm"] },
	{"AtlasLootMoP", "AtlasLoot_MistsofPandaria", false, "", AL["Mists of Pandaria"] },
	{"AtlasLootCrafting", "AtlasLoot_Crafting", false, ""},
	{"AtlasLootWorldEvents", "AtlasLoot_WorldEvents", false, ""},
}

local allLoaded = false
local spamProtect = {}


function AtlasLoot:OnInitialize()
	--[===[@debug@ 
	if self.OnLoaderLoad then
		self:OnLoaderLoad()
		allLoaded = true
	end
	--@end-debug@]===]
	
	-- Warning if AtlasLootFu is enabled
	local _, _, _, enabled, _, reason = GetAddOnInfo("AtlasLootFu")
	if enabled or reason == "DISABLED" then
		DisableAddOn("AtlasLootFu")
		StaticPopupDialogs["ATLASLOOT_FU_ERROR"] = {
			text = AL["AtlasLootFu is no longer in use.\nDelete it from your AddOns folder"],
			button1 = OKAY,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
		StaticPopup_Show("ATLASLOOT_FU_ERROR")
	end
	
	if not AtlasLootLoaderDB.MiniMapButton then
		AtlasLootLoaderDB.MiniMapButton = {
			hide = false,
		}
	end
	
	-- Bindings
	BINDING_HEADER_ATLASLOOT_TITLE = AL["AtlasLoot"]
	BINDING_NAME_ATLASLOOT_TOGGLE = AL["Toggle AtlasLoot"]
	
	-- Slash /al 
	self:CreateSlash()
	-- Options
	self:OptionsInitialize()
	-- MiniMap Button
	self:MiniMapButtonInitialize()
	
	-- Atlas loader
	if AtlasFrame then
		local loaded = false
		local function onShow(...)
			if not loaded then
				loaded = true
				AtlasLoot:LoadModule("AtlasLoot")
				AtlasFrame:Hide()
				AtlasFrame:Show()
			end
		end
		AtlasFrame:HookScript("OnShow", onShow)
	end
end

--- Loads a AtlasLoot module
-- @param module AtlasLootClassicWoW, AtlasLootBurningCrusade, AtlasLootWotLK, AtlasLootCataclysm, AtlasLootCrafting, AtlasLootWorldEvents, all
-- @usage AtlasLoot:LoadModule(module)
function AtlasLoot:LoadModule(module)
	if not module or type(module) ~= "string" then return end
	if allLoaded then return true end
	local loadedRET,reasonRET = true, ""
	if module == "AtlasLoot" or not IsAddOnLoaded("AtlasLoot") then
		if not IsAddOnLoaded(module) then
			LoadAddOn("AtlasLoot")
		end
		return loadedRET, reasonRET
	end
	
	for k,v in ipairs(self.Modules) do
		if not self.Modules[k][3] then
			if v[1] == module or module == "all" then
				local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v[2])
				if reason == "DISABLED" then
					if self.Modules[k][4] == "" then
						self:Print(string.format(AL["Module \"%s\" is disabled."], v[2]))
						self.Modules[k][4] = reason
						loadedRET = false
						reasonRET = reason
					end
				elseif reason == "MISSING" then
					if self.Modules[k][4] == "" then
						self:Print(string.format(AL["Module \"%s\" is missing."], v[2]))
						self.Modules[k][4] = reason
						loadedRET = false
						reasonRET = reason
					end
				else
					self.Modules[k][4] = ""
					if not IsAddOnLoaded(v[2]) then
						LoadAddOn(v[2])
						self.Modules[k][3] = true
					end
				end
			end
		end
	end
	if module == "all" then
		allLoaded = true
	else
		local checkVal = false
		for k,v in ipairs(self.Modules) do
			if v[3] == true then
				checkVal = true
			else
				checkVal = false
				break
			end
		end
		if checkVal == true then
			allLoaded = true
		end
	end
	if allLoaded then
		AtlasLoot_InstanceList_Loader = nil
		collectgarbage("collect")
		loadedRET = true
		reasonRET = nil
	end
	return loadedRET,reasonRET
end

local slashCalled = false
-- This only loads the AtlasLoot Core
-- After first call this function is replaced
function AtlasLoot:SlashCommand(msg)
	if slashCalled then
		slashCalled = false
	else
		self:LoadModule("AtlasLoot")
		self:SlashCommand(msg)
		slashCalled = true
	end
end

-- Create the Slashs /al and /atlasloot
function AtlasLoot:CreateSlash()
	--Enable the use of /al or /atlasloot to open the loot browser
	SLASH_ATLASLOOT1 = "/atlasloot";
	SLASH_ATLASLOOT2 = "/al";
	SlashCmdList["ATLASLOOT"] = function(msg)
		self:SlashCommand(msg);
	end
end

--- Check a dataID and loads module if needed
function AtlasLoot:CheckDataID(dataID)
	if AtlasLoot_Data and AtlasLoot_Data[dataID] then
		return true 
	elseif AtlasLoot_InstanceList_Loader and AtlasLoot_InstanceList_Loader[dataID] then
		return self:LoadModule(AtlasLoot_ModuleList_Loader[ AtlasLoot_InstanceList_Loader[dataID] ] )
	else
		local tLocation = self:GetTableLoaction(dataID)
		if tLocation and AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]["Info"][2] then
			if type(AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]["Info"][2]) == "table" then
				for k,v in ipairs(AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]["Info"][2]) do
					self:LoadModule(v)
				end
				return true
			else
				return self:LoadModule(AtlasLoot_LootTableRegister[tLocation[1]][tLocation[2]]["Info"][2])
			end
		else
			return false, "MISSING"
		end
		return false, "MISSING"
	end
end

function AtlasLoot:CheckModule(module)
	if allLoaded then return true end
	for k,v in ipairs(self.Modules) do
		if v[1] == module or v[2] == module then
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v[2])
			if IsAddOnLoaded(v[2]) then
				return true
			else
				return reason
			end
		end
	end
end

--[===[@debug@ 
function AtlasLoot:CheckModule(module)
	return true
end
function AtlasLoot:LoadModule(module)
	return true
end
--@end-debug@]===]