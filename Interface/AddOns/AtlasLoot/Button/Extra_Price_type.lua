local AtlasLoot = _G.AtlasLoot
local Price = AtlasLoot.Button:AddExtraType("Price")
local AL = AtlasLoot.Locales

local type = type
local str_split = string.split

local FIRST_RUN = true
local ITEMS_NOT_FOUND = true

local STRING_SPLIT_OR = "-"
local STRING_DELIMITER_OR = "|r; "
local STRING_SPLIT_AND = ":"
local STRING_DELIMITER_AND = "|r & "
local STRING_DELIMITER_END = ""
local STRING_TABLE = "table"
local STRING_RED = "|cffff0000"
local STRING_GREEN = "|cff1eff00"

local PRICE_INFO = {
	["apexis"] = { currencyID = 823 },
	["artifactfragment"] = { currencyID = 944 },
	["brewfest"] = { itemID = 37829 },
	["champseal"] = { currencyID = 241 },
	["conquest"] = { currencyID = 390 },
	["darkmoon"] = { currencyID = 515 },
	["eldercharm"] = { currencyID = 697 },
	["honor"] = { currencyID = 392 },
	["money"] = { func = GetCoinTextureString },
	["timelesscoin"] = { currencyID = 777 },
	["tolbarad"] = { currencyID = 391 },
	["trickytreat"] = { itemID = 33226 },
}

local Cache = {}
setmetatable(Cache, {__mode = "kv"})

local function SetContentInfo(frame, typ, value, delimiter)
	value = value or 0
	delimiter = delimiter or STRING_DELIMITER_END
	
	if PRICE_INFO[typ] then
		if PRICE_INFO[typ].func then
			frame:AddText(PRICE_INFO[typ].func(value)..delimiter)
		elseif PRICE_INFO[typ].icon then
			frame:AddIcon(PRICE_INFO[typ].icon, 12)
			frame:AddText(value..delimiter)
		elseif PRICE_INFO[typ].currencyID then
			local name, currentAmount, texture = GetCurrencyInfo(PRICE_INFO[typ].currencyID) --name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity
			frame:AddIcon(texture, 12)
			frame:AddText(currentAmount >= tonumber(value) and STRING_GREEN..value..delimiter or STRING_RED..value..delimiter)
		elseif PRICE_INFO[typ].itemID then
			PRICE_INFO[typ].icon = GetItemIcon(PRICE_INFO[typ].itemID)
			SetContentInfo(frame, typ, value, delimiter)
		end
	elseif tonumber(typ) then
		frame:AddIcon(GetItemIcon(typ), 12)
		frame:AddText(value..delimiter)
	end
end

function Price.OnSet(mainButton, descFrame)
	if FIRST_RUN then
		for k,v in pairs(PRICE_INFO) do
			if v.itemID then 
				local itemName = GetItemInfo(v.itemID)
				v.icon = GetItemIcon(v.itemID)
				v.name = itemName
			end
		end
		FIRST_RUN = false
	end
	local typeVal = mainButton.__atlaslootinfo.extraType[2]
	local info
	if Cache[typeVal] then
		info = Cache[typeVal]
	else
		info = { str_split(STRING_SPLIT_OR, typeVal) }
		if info[2] then
			for i = 1, #info do
				info[i] = { str_split(STRING_SPLIT_AND, info[i]) }
			end
		else
			info = { str_split(STRING_SPLIT_AND, info[1]) }
		end
		Cache[typeVal] = info
	end
	
	if type(info[1]) == STRING_TABLE then
		for i = 1, #info do
			for j = 1, #info[i], 2 do
				SetContentInfo(descFrame, info[i][j], info[i][j+1], j+1 == #info[i] and (#info == i and STRING_DELIMITER_END or STRING_DELIMITER_OR) or STRING_DELIMITER_AND)
			end
		end
	else
		for i = 1, #info, 2 do
			SetContentInfo(descFrame, info[i], info[i+1], i+1 == #info and STRING_DELIMITER_END or STRING_DELIMITER_AND)
		end
	end
	
	descFrame.info = info
end
