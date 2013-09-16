------------------------------------------------------------
-- Localization.lua
--
-- Abin
-- 2010/8/27
------------------------------------------------------------

-- Default(English)
IDQUERY_LOCALE = {
	["desc"] = "Specify search type and item/spell name to search for matched records, wildcard(*) supported in name texts.",
	["searching"] = "Searching......",
	["records"] = "Found %d records.",
    ["stop records"] = "Search stoped at %d%%, Found %d records.",
	["stop"] = "Stop",
	["too many"] = "|cffff0000Too many matched records, please change the name text.|r",
	["invalid text"] = "|cffff0000Invalid name text.|r",
}

if GetLocale() == "zhCN" then
	-- 简体中文
	IDQUERY_LOCALE = {
		["desc"] = "先选择类型，然后输入名称或ID来搜寻数据，名称中可使用*通配符，第一次搜索物品可能数据不全。",
		["searching"] = "正在搜寻......",
		["records"] = "共找到%d条记录。",
        ["stop records"] = "搜索中止在%d%%, 找到%d条记录。",
		["stop"] = "停止",
		["too many"] = "|cffff0000符合条件的记录过多，请更改名称字符。|r",
		["invalid text"] = "|cffff0000无效的名称字符。|r",
	}
elseif GetLocale() == "zhTW" then
	-- 繁體中文
	IDQUERY_LOCALE = {
		["desc"] = "輸入搜尋種類和物品/技能名稱來搜尋符合條件的記錄，通配符(*)可使用於名稱字符中。",
		["searching"] = "正在搜尋......",
		["records"] = "共找到%d條記錄。",
        ["stop records"] = "搜索中止在%d%%, 找到%d條記錄。",
		["stop"] = "停止",
		["too many"] = "|cffff0000符合條件的記錄過多，請更改名稱字符。|r",
		["invalid text"] = "|cffff0000無效的名稱字符。|r",
	}
end