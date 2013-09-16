local MAJOR_VERSION = "LibDogTag-Stats-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 9 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Stats_MINOR_VERSION then
	_G.DogTag_Stats_MINOR_VERSION = MINOR_VERSION
end

if GetLocale() == "zhTW" then

DogTag_Stats_funcs[#DogTag_Stats_funcs+1] = function(DogTag_Stats, DogTag)
	local L = DogTag_Stats.L
	
	L["Defense"] = "防御"
L["Melee"] = "近戰"
L["PvP"] = "PvP"
L["Ranged"] = "遠程"
L["Regen"] = "恢復"
L["Returns your Agility"] = "返回你的敏捷"
L["Returns your armor value."] = "返回你的護甲值."
L["Returns your block amount percentage."] = "返回你的格擋值的傷害減免百分比."
L["Returns your block chance."] = "返回你的格擋機率."
L["Returns your bonus spell damage amount."] = "返回你的法術能量的傷害值。指定法術類別後返回的可能是空值、無效值，下面為具體數字所代表的類別：2神聖，3火焰，4自然，5冰霜，6暗影，7秘法。"
L["Returns your bonus spell healing amount."] = "返回你的法術能量的治療值"
L["Returns your damage increase percentage from PvP power."] = "返回你從PVP強度獲得的傷害提高百分比"
L["Returns your damage or healing increase percentage from PvP power (whichever is greater)."] = "返回你從PVP強度獲得的傷害或治療提高百分比(返回較大的數值)"
L["Returns your damage reduction percentage from resilience."] = "返回你的韌性等級百分比"
L["Returns your dodge chance."] = "返回你的閃躲機率."
L["Returns your energy regeneration or focus regeneration rate (per second)."] = "返回你的能量、集中值恢復速度（每秒）"
L["Returns your healing increase percentage from PvP power."] = "返回你從PVP強度獲得的治療提高百分比"
L["Returns your in-combat mana regen (mana per second)."] = "返回你在戰斗狀態的法力恢復(每秒恢復魔法值)"
L["Returns your Intellect"] = "返回你的智力"
L["Returns your Mastery effect percentage"] = "返回你的精通效果百分比"
L["Returns your melee Attack Power"] = "返回你的近戰攻擊強度"
L["Returns your melee crit chance"] = "返回你的近戰致命一擊機率"
L["Returns your melee expertise"] = "返回你的近戰熟練值"
L["Returns your melee haste percentage"] = "返回你的近戰加速百分比"
L["Returns your melee hit percentage increase."] = "返回你的近戰命中機率百分比"
L["Returns your normal attack (white hit) miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"] = "返回你的普通攻擊（白字）未命中機率，你可以指定一個數字來針對那些等級比你高的敵對單位（允許的最大等級差距為3）"
L["Returns your out-of-combat mana regen (mana per second)."] = "返回你在非戰斗狀態的法力恢復(每秒恢復魔法值)"
L["Returns your parry chance."] = "返回你的招架機率."
L["Returns your percentage of damage reduction from armor. Pass in a level as a parameter to calculate damage reduction against that level enemy."] = "返回你從護甲獲得的傷害減免百分比，可以指定等級計算針對該等級敵對單位的傷害減免。"
L["Returns your PvP power rating."] = "返回你的PVP強度等級"
L["Returns your ranged attack power"] = "返回你的遠程攻擊強度"
L["Returns your ranged crit chance"] = "返回你的遠程致命一擊機率"
L["Returns your ranged expertise"] = "返回你的遠程熟練值"
L["Returns your ranged haste percentage"] = "返回你的遠程加速百分比"
L["Returns your ranged hit percentage increase."] = "返回你的遠程命中機率百分比"
L["Returns your ranged miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"] = "返回你的遠程攻擊未命中機率，你可以指定一個數字來針對那些等級比你高的敵對單位（允許的最大等級差距為3）"
L["Returns your resilience rating."] = "返回你的韌性等級"
L["Returns your special attack (yellow hit) miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"] = "返回你的技能攻擊未命中機率，你可以指定一個數字來針對那些等級比你高的敵對單位（允許的最大等級差距為3）"
L["Returns your spell crit chance."] = "返回你的法術致命一擊機率。指定法術類別後返回的可能是空值、無效值，下面為具體數字所代表的類別：2神聖，3火焰，4自然，5冰霜，6暗影，7秘法。"
L["Returns your spell haste percentage."] = "返回你的法術加速百分比"
L["Returns your spell hit percentage increase."] = "返回你的法術命中機率百分比"
L["Returns your spell miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"] = "返回你的法術未命中機率，你可以指定一個數字來針對那些等級比你高的敵對單位（允許的最大等級差距為3）"
L["Returns your Spirit"] = "返回你的精神"
L["Returns your Stamina"] = "返回你的耐力"
L["Returns your Strength"] = "返回你的力量"
L["Spell"] = "法術"
L["Stats"] = "屬性"

end

end