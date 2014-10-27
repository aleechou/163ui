local _G = _G
local AtlasLoot = _G.AtlasLoot
local TooltipScan = {}
AtlasLoot.TooltipScan = TooltipScan

-- lua
local match, find = string.match, string.find
local pairs, tab_remove = pairs, table.remove

-- WoW
local GetSpellLink = GetSpellLink

local cache = {}
setmetatable(cache, {__mode = "kv"})

local AtlasLootScanTooltip = CreateFrame("GAMETOOLTIP", "AtlasLootScanTooltip", nil, "GameTooltipTemplate")
AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")

function TooltipScan.GetTradeskillLink(tradeskillID)
	if not tradeskillID then return end
	if cache[tradeskillID] then 
		return cache[tradeskillID][1], cache[tradeskillID][2] 
	end
	local TradeskillLink = nil
	local TradeskillName = nil
	AtlasLootScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	AtlasLootScanTooltip:ClearLines()
	AtlasLootScanTooltip:SetHyperlink("enchant:"..tradeskillID)
	AtlasLootScanTooltip:Show()
	local text = _G["AtlasLootScanTooltipTextLeft1"]:GetText()
	if text and find(text, ":") then
		TradeskillLink = "|cffffd000|Henchant:"..tradeskillID.."|h["..text.."]|h|r"
		TradeskillName = match(text, "(%w+):")
	else
		TradeskillLink = GetSpellLink(tradeskillID)
	end
	AtlasLootScanTooltip:Hide()
	cache[tradeskillID] = {TradeskillLink, TradeskillName}
	return TradeskillLink, TradeskillName
end

local AtlasLootQueryTooltip = CreateFrame("GAMETOOLTIP", "AtlasLootQueryTooltip", nil, "GameTooltipTemplate")
AtlasLootQueryTooltip:SetOwner(UIParent, "ANCHOR_NONE")

local queryList = {}
local queryCacheMT = {__mode = "kv"}
local queryCache = { "quest" }
for i = 1, #queryCache do
	queryCache[ queryCache[i] ] = setmetatable({}, queryCacheMT)
end

local function SetNextQuery()
	local nextQuery = next(queryList)
	if nextQuery then
		queryList[ nextQuery ] = nil
		nextQuery[1](nextQuery[2], nextQuery[3], nextQuery[4])
	end
end

local function OnTooltipSetQuest(self)
	queryCache.quest[self.questID] = _G["AtlasLootQueryTooltipTextLeft1"]:GetText()
	self.onGetFunc(queryCache.quest[self.questID], self.arg1)
	self.onGetFunc = nil
	self.questID = nil
	self.arg1 = nil
	AtlasLootQueryTooltip:SetScript("OnTooltipSetQuest", nil)
	SetNextQuery()
end

-- /dump AtlasLoot.TooltipScan.GetQuestName(5090, print)
function TooltipScan.GetQuestName(questID, onGetFunc, arg1)
	if not questID then return end
	if queryCache.quest[questID] then 
		onGetFunc( queryCache.quest[questID], arg1 )
	end
	if AtlasLootQueryTooltip.onGetFunc then
		queryList[#queryList+1] = {TooltipScan.GetQuestName, questID, onGetFunc}
		return 
	end
	AtlasLootQueryTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	AtlasLootQueryTooltip:ClearLines()
	AtlasLootQueryTooltip.onGetFunc = onGetFunc
	AtlasLootQueryTooltip.questID = questID
	AtlasLootQueryTooltip.arg1 = arg1
	AtlasLootQueryTooltip:SetScript("OnTooltipSetQuest", OnTooltipSetQuest)
	AtlasLootQueryTooltip:SetHyperlink("quest:"..questID)
end