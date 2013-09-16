RATING_SUMMARY_TOTAL_AVOID = "Tot.Avoid"

--stat category in short
RATING_SUMMARY_MELEE_CRIT = "M.CR:"
RATING_SUMMARY_SPELL_CRIT = "S.CR:"
RATING_SUMMARY_MANA_REGEN = "MP/5:"


RATING_SUMMARY_ITEM_LEVEL_TITLE = "Avg item level"
RATING_SUMMARY_ITEM_LEVEL_FORMAT = "%2d * %3.0f lvl"
RATING_SUMMARY_ITEM_QUANLITY_NAME = {
    [7] = _G["ITEM_QUALITY7_DESC"],
    [6] = _G["ITEM_QUALITY6_DESC"],
    [5] = _G["ITEM_QUALITY5_DESC"],
    [4] = _G["ITEM_QUALITY4_DESC"],
    [3] = _G["ITEM_QUALITY3_DESC"],
    [2] = _G["ITEM_QUALITY2_DESC"],
}
RATING_SUMMARY_OTHER = "Other"

if(GetLocale()=="zhCN" or GetLocale()=="zhTW") then
    --RATING_SUMMARY_ANNOUNCE = "|cffFFCC66RatingSummary|r-裝備屬性統計,|cffFFCC66Warbaby|r@|cffFF00FF聖光之願<冰封十字軍>|r"
    RATING_SUMMARY_TOTAL_AVOID = "免伤"

    --stat category in short
    RATING_SUMMARY_MELEE_CRIT = "物爆:"
    RATING_SUMMARY_SPELL_CRIT = "法爆:"
    RATING_SUMMARY_MANA_REGEN = "回蓝:"


    RATING_SUMMARY_ITEM_LEVEL_TITLE = "装备等级"
    RATING_SUMMARY_ITEM_LEVEL_SHORT = "装等"
    RATING_SUMMARY_ITEM_LEVEL_FORMAT = "%2d 件 %3.0f 级"
    RATING_SUMMARY_ITEM_QUANLITY_NAME = {
        [7] = "金色",
        [6] = "红色",
        [5] = "橙色",
        [4] = "紫色",
        [3] = "蓝色",
        [2] = "绿色",
    }
    RATING_SUMMARY_OTHER = "其他"
end

--[[
function a(start)
	local i;
	for i=start,start do
		ChatFrame1:AddMessage(i.."         ".."|cff9d9d9d|Hitem:39:"..i..":0:0:0:0:0:0:1|h[新兵束褲]|h|r");
	end
end

function b()
	local t = {3232, 3296, 3788, 3247, 3826, 3238, 3244}
	local i;
	for _, i in pairs(t) do
		a(i);
	end
end
]]