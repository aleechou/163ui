local AtlasLoot = _G.AtlasLoot
local Loader = {}
AtlasLoot.Loader = Loader
local AL = AtlasLoot.Locales

local LoaderQueue = {}
local LoaderQueueSaves = {}
local ModuleList = {}
local LoadModuleSpam = {}

-- lua
local type = type
local pairs = pairs
local str_find, str_format = string.find, string.format
local tbl_insert, tbl_remove = table.insert, table.remove

-- WoW
local GetNumAddOns, GetAddOnInfo, IsAddOnLoaded, GetAddOnMetadata = GetNumAddOns, GetAddOnInfo, IsAddOnLoaded, GetAddOnMetadata


-- A list of officiel AtlasLoot modules
local ATLASLOOT_MODULE_LIST = {
	{
		addonName = "AtlasLoot_WarlordsofDraenor",
		name = AL["Warlords of Draenor"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_MistsofPandaria",
		name = AL["Mists of Pandaria"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_Cataclysm",
		name = AL["Cataclysm"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_WrathoftheLichKing",
		name = AL["Wrath of the Lich King"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_BurningCrusade",
		name = AL["Burning Crusade"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_Classic",
		name = AL["Classic"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_Collections",
		name = AL["Collections"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_Crafting",
		name = AL["Crafting"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_Factions",
		name = AL["Factions"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_PvP",
		name = AL["PvP"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_WorldEvents",
		name = AL["World Events"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	--[[
	{
		addonName = "AtlasLoot_Achievements",
		name = AL["Achievements"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	{
		addonName = "AtlasLoot_Map",
		name = AL["Map"],
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
	},
	--]]
}
local ATLASLOOT_MODULE_LIST_NAMES = {}
for i = 1, #ATLASLOOT_MODULE_LIST do
	ATLASLOOT_MODULE_LIST_NAMES[ATLASLOOT_MODULE_LIST[i].addonName] = i
end

local LoaderFrame = CreateFrame("FRAME")
LoaderFrame:RegisterEvent("ADDON_LOADED")
local function LoaderEvents(frame, event, arg1)
	if event == "ADDON_LOADED" then
		if ModuleList[arg1] then
			ModuleList[arg1].loaded = true
			collectgarbage("collect")
		end
		if LoaderQueue[arg1] then
			if type(LoaderQueue[arg1]) == "function" then
				LoaderQueue[arg1](arg1)
			elseif type(LoaderQueue[arg1]) == "table" then
				for i = 1, #LoaderQueue[arg1] do
					if type(LoaderQueue[arg1][i]) == "function" then
						LoaderQueue[arg1][i](arg1)
					end
				end
			end
			LoaderQueue[arg1] = nil
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		for k,v in pairs(LoaderQueue) do
			Loader:LoadModule(k)
		end
		LoaderFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
		wipe(LoadModuleSpam)
	end
end
LoaderFrame:SetScript("OnEvent", LoaderEvents)

function Loader.Init()
	-- Check addonlist for AtlasLoot modules
	local tmp
	local playerName = UnitName("player")
	for i=1,GetNumAddOns() do
		tmp = {GetAddOnInfo(i)}
		if tmp[1] and str_find(tmp[1], "AtlasLoot_") then
			ModuleList[tmp[1]] = {
				index = i,
				enabled = GetAddOnEnableState(playerName, i) == 0 and false or true, --tmp[4], -- 0 = Disabled on char, 1 = Enabled only on some chars (including this), 2 = enabled on all chars
				loaded = IsAddOnLoaded(i),
				standardModule = ATLASLOOT_MODULE_LIST_NAMES[tmp[1]],
				
				moduleName = GetAddOnMetadata(tmp[1], "X-AtlasLoot-ModuleName") or tmp[1],
				lootModule = GetAddOnMetadata(tmp[1], "X-AtlasLoot-LootModule"),
			}
		end
	end
end
AtlasLoot:AddInitFunc(Loader.Init)

--- Loads a module for AtlasLoot
-- @param	moduleName		<string> name of the module
-- @param	onLoadFunction	<function> function that is called after the module is finish loaded
-- @param	oneFunction		<bool> true if only this function should be called after load WARNING: clears all other functions from queue
function Loader:LoadModule(moduleName, onLoadFunction, oneFunction)
	if not moduleName or not ModuleList[moduleName] then return end
	if self:IsModuleLoaded(moduleName) then 
		if onLoadFunction then
			onLoadFunction(moduleName)
		end
		return true
	end
	if not LoaderQueue[moduleName] then LoaderQueue[moduleName] = {} end
	if onLoadFunction and not oneFunction then
		tbl_insert(LoaderQueue[moduleName], onLoadFunction)
	elseif onLoadFunction and oneFunction and oneFunction ~= true then
		if LoaderQueueSaves[oneFunction] and LoaderQueue[ LoaderQueueSaves[oneFunction] ] then
			tbl_remove(LoaderQueue[ LoaderQueueSaves[oneFunction] ], LoaderQueue[LoaderQueueSaves[oneFunction]][oneFunction])
			LoaderQueue[LoaderQueueSaves[oneFunction]][oneFunction] = nil
			if #LoaderQueue[LoaderQueueSaves[oneFunction]] == 0 then
				LoaderQueue[LoaderQueueSaves[oneFunction]] = nil
			end
		end
		if LoaderQueue[moduleName][oneFunction] then
			LoaderQueue[moduleName][ LoaderQueue[moduleName][oneFunction] ] = onLoadFunction
		else
			LoaderQueue[moduleName][oneFunction] = #LoaderQueue[moduleName]+1
			LoaderQueue[moduleName][ LoaderQueue[moduleName][oneFunction] ] = onLoadFunction
		end
		LoaderQueueSaves[oneFunction] = moduleName
	elseif onLoadFunction and oneFunction then
		LoaderQueue[moduleName] = onLoadFunction
	end
	if InCombatLockdown() then
		-- in combat must waite with load 
		if LoadModuleSpam[moduleName] and (GetTime() - LoadModuleSpam[moduleName]) > 5 then
			AtlasLoot:Print(str_format(AL["%s will finish loading after combat."], moduleName))
			LoadModuleSpam[moduleName] = GetTime()
		elseif not LoadModuleSpam[moduleName] then
			LoadModuleSpam[moduleName] = GetTime()
		end
		LoaderFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		return "InCombat"
	else
		LoadAddOn(moduleName)
	end
end

function Loader:IsModuleLoaded(moduleName)
	if not moduleName or not ModuleList[moduleName] then return end
	return IsAddOnLoaded(moduleName)
end

function Loader:GetLootModuleList()
	local data = {}
	-- AtlasLoot modules
	data.module = {}
	local moduleTable
	for i = 1, #ATLASLOOT_MODULE_LIST do
		moduleTable = ATLASLOOT_MODULE_LIST[i]
		if moduleTable.addonName and ModuleList[moduleTable.addonName] and ModuleList[moduleTable.addonName].lootModule == "1" and ModuleList[moduleTable.addonName].enabled then
			tbl_insert(data.module , {
				addonName = moduleTable.addonName,
				name = moduleTable.name,
				tt_title = moduleTable.tt_title,
				tt_text = moduleTable.tt_text,
			})
		end
	end
	-- custom modules
	data.custom = {}
	for addonName, addonTable in pairs(ModuleList) do
		if not addonTable.standardModule and addonTable.enabled and addonTable.lootModule == "1" then
			tbl_insert(data.custom , {
				addonName = addonName,
				name = addonTable.moduleName or UNKNOWN,
			})
		end
	end
	return data
end