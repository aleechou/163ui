
---##留名：上官晓雾##--

--~ 	local L = LibStub("AceLocale-3.0"):NewLocale("PetJournalEnhanced", "enUS",true)
--~ 	if not L then return end
--~ 		L["Pet Battle"] = true
--~ 		L["Zone"] = true
--~ 		L["Sort Options"]= true
--~ 		L["Filter pets by current zone"]= true
--~ 		L["Sort Order:"]= true
--~ 		L["Alphabetical"]= true
--~ 		L["Pet Highest Stat"]= true
--~ 		L["AddedtoPetJournal"]= true
--~ 		L["Sort Direction:"]= true
--~ 		L["Sort Ascending"]= true
--~ 		L["Sort Descending"]= true

--~ 		L["Unique Pets"]= true
--~ 		L["Show unique pet count"]= true
--~ 		L["Show pets specialization"]= true
--~ 		L["Color pet borders"]= true
--~ 		L["Color pet names"]= true

--~ 		L["Can Battle"]= true
--~ 		L["Can't Battle"]= true
--~ 		L["Can Trade"]= true
--~ 		L["Can't Trade"]= true
--~ 		L["Reset Filters"]= true
--~ 		L["Zone Filter"]= true
--~ 		L["Quality"]= true
--~ 		L["Specialization"]= true
--~ 		L["Unknown Zone"]= true
--~ 		L["Unknown"]=true
--~ 		L["Sort favorites to the top"]= true

--~ 		L["Balanced"]= true
--~ 		L["Fast"]= true
--~ 		L["Resilient"]= true
--~ 		L["Powerful"]= true

--~ 		L["Level"]= true

--~ 		L["Pet Type"]= true
--~ 		L["Rarity"]= true
--~ 		L["Pet Highest Stat"]= true

local L = LibStub("AceLocale-3.0"):NewLocale("PetJournalEnhanced", "zhCN")
if(L) then
		L["Pet Battle"] = "宠物对战"
		L["Zones"] = "地区"
		L["Sorting"]="排序"
		L["Filter pets by current zone"]="显示本地宠物"
		L["Sort Order:"]="排序方式:"
		L["Alphabetical"]="按名字排序(null)"
		L["Pet Highest Stat"]="宠物属性"
		L["AddedtoPetJournal"]="收藏顺序"
		L["Sort Direction:"]="排序方向:"
		L["Sort Ascending"]="正序"
		L["Sort Descending"]="逆序"

		L["Unique Pets"]="独特宠物"
		L["Show unique pet count"]="显示独特宠物数量"
		L["Show pets specialization"]="显示专精"
		L["Color pet borders"]="边框着色"
		L["Color pet names"]="名字着色"

		L["Can Battle"]="可对战"
		L["Can't Battle"]="不可对战"
		L["Can Trade"]="可交易"
		L["Can't Trade"]="不可交易"
		L["Reset Filters"]="重置过滤"
		L["Zone Filter"]="位置过滤"
		L["Quality"]="品质"
		L["Specialization"]=SPECIALIZATION
		L["Unknown Zone"]="未知区域"
		L["Unknown"]="未知"
		L["Sort favorites to the top"]="置顶收藏宠物"

		L["Balanced"]="平衡"
		L["Fast"]="速度"
		L["Resilient"]="生命"
		L["Powerful"]="强度"

		L["Level"]="等级"
		L["Display Breed Info"]="显示种类信息(测试)"
		L["Display Extroplated Pet Stats"]="显示满级数据"
		L["Quantity"]="数量"
		L["Breed"]="种类"

		L["Pet Type"]=TYPE
		L["Rarity"]=RARITY
		L["Pet Highest Stat"]=SPECIALIZATION.."排序"
    return
end

local L = LibStub("AceLocale-3.0"):NewLocale("PetJournalEnhanced", "zhTW")
if(L) then
		L["Pet Battle"] = "寵物對戰"
		L["Zones"] = "區域"
		L["Sorting"]="排序"
		L["Filter pets by current zone"]="顯示本地寵物"
		L["Sort Order:"]="排序方式:"
		L["Alphabetical"]="按名字排序(null)"
		L["Pet Highest Stat"]="寵物屬性"
		L["AddedtoPetJournal"]="收藏順序"
		L["Sort Direction:"]="排序方向:"
		L["Sort Ascending"]="正序"
		L["Sort Descending"]="逆序"

		L["Unique Pets"]="獨特寵物"
		L["Show unique pet count"]="顯示獨特寵物數量"
		L["Show pets specialization"]="顯示專精"
		L["Color pet borders"]="邊框著色"
		L["Color pet names"]="名字著色"

		L["Can Battle"]="可對戰"
		L["Can't Battle"]="不可對戰"
		L["Can Trade"]="可交易"
		L["Can't Trade"]="不可交易"
		L["Reset Filters"]="重置過濾"
		L["Zone Filter"]="位置過濾"
		L["Quality"]="品質"
		L["Specialization"]=SPECIALIZATION
		L["Unknown Zone"]="未知區域"
		L["Unknown"]="未知"
		L["Sort favorites to the top"]="置頂收藏寵物"

		L["Balanced"]="平衡"
		L["Fast"]="速度"
		L["Resilient"]="生命"
		L["Powerful"]="強度"

		L["Level"]="等級"
		L["Display Breed Info"]="顯示Breed信息(測試)"
		L["Display Extroplated Pet Stats"]="顯示滿級數據"
		L["Quantity"]="數量"
		L["Breed"]="種類"

		L["Pet Type"]=TYPE
		L["Rarity"]=RARITY
		L["Pet Highest Stat"]=SPECIALIZATION.."排序"
    return
end

