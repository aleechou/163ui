local MAJOR_VERSION = "LibDogTag-Stats-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 9 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Stats_MINOR_VERSION then
	_G.DogTag_Stats_MINOR_VERSION = MINOR_VERSION
end

if GetLocale() == "zhCN" then

DogTag_Stats_funcs[#DogTag_Stats_funcs+1] = function(DogTag_Stats, DogTag)
	local L = DogTag_Stats.L
	
	L["Defense"] = "防御"
L["Melee"] = "近战"
L["PvP"] = "PvP"
L["Ranged"] = "远程"
L["Regen"] = "回复"
L["Returns your Agility"] = "返回你的敏捷"
L["Returns your armor value."] = "返回你的护甲值."
L["Returns your block amount percentage."] = "返回你的格挡值的伤害减免百分比."
L["Returns your block chance."] = "返回你的格挡几率."
L["Returns your bonus spell damage amount."] = "返回你的法术能量的伤害值。指定法术类别后返回的可能是空值、无效值，下面为具体数字所代表的类别：2神圣，3火焰，4自然，5冰霜，6暗影，7奥术。"
L["Returns your bonus spell healing amount."] = "返回你的法术能量的治疗值"
L["Returns your damage increase percentage from PvP power."] = "返回你从PVP强度获得的伤害提高百分比"
L["Returns your damage or healing increase percentage from PvP power (whichever is greater)."] = "返回你从PVP强度获得的伤害或治疗提高百分比(返回较大的数值)"
L["Returns your damage reduction percentage from resilience."] = "返回你的韧性等级百分比"
L["Returns your dodge chance."] = "返回你的闪躲几率."
L["Returns your energy regeneration or focus regeneration rate (per second)."] = "返回你的能量、集中值回复速度（每秒）"
L["Returns your healing increase percentage from PvP power."] = "返回你从PVP强度获得的治疗提高百分比"
L["Returns your in-combat mana regen (mana per second)."] = "返回你在战斗状态的法力回复(每秒回复魔法值)"
L["Returns your Intellect"] = "返回你的智力"
L["Returns your Mastery effect percentage"] = "返回你的精通效果百分比"
L["Returns your melee Attack Power"] = "返回你的近战攻击强度"
L["Returns your melee crit chance"] = "返回你的近战爆击率"
L["Returns your melee expertise"] = "返回你的近战熟练值"
L["Returns your melee haste percentage"] = "返回你的近战急速百分比"
L["Returns your melee hit percentage increase."] = "返回你的近战命中几率百分比"
L["Returns your normal attack (white hit) miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"] = "返回你的普通攻击（白字）未命中几率，你可以指定一个数字来针对那些等级比你高的敌对单位（允许的最大等级差距为3）"
L["Returns your out-of-combat mana regen (mana per second)."] = "返回你在非战斗状态的法力回复(每秒回复魔法值)"
L["Returns your parry chance."] = "返回你的招架几率."
L["Returns your percentage of damage reduction from armor. Pass in a level as a parameter to calculate damage reduction against that level enemy."] = "返回你从护甲获得的伤害减免百分比，可以指定等级计算针对该等级敌对目标的伤害减免。"
L["Returns your PvP power rating."] = "返回你的PVP强度等级"
L["Returns your ranged attack power"] = "返回你的远程攻击强度"
L["Returns your ranged crit chance"] = "返回你的远程爆击率"
L["Returns your ranged expertise"] = "返回你的远程熟练值"
L["Returns your ranged haste percentage"] = "返回你的远程急速百分比"
L["Returns your ranged hit percentage increase."] = "返回你的远程命中几率百分比"
L["Returns your ranged miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"] = "返回你的远程攻击未命中几率，你可以指定一个数字来针对那些等级比你高的敌对单位（允许的最大等级差距为3）"
L["Returns your resilience rating."] = "返回你的韧性等级"
L["Returns your special attack (yellow hit) miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"] = "返回你的技能攻击（黄字）未命中几率，你可以指定一个数字针对那些等级比你高的敌对单位（允许的最大等级差距为3）"
L["Returns your spell crit chance."] = "返回你的法术爆击率。指定法术类别后返回的可能是空值、无效值，下面为具体数字所代表的类别：2神圣，3火焰，4自然，5冰霜，6暗影，7奥术。"
L["Returns your spell haste percentage."] = "返回你的法术急速百分比"
L["Returns your spell hit percentage increase."] = "返回你的法术命中几率百分比"
L["Returns your spell miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"] = "返回你的法术未命中几率，你可以指定一个数字来针对那些等级比你高的敌对单位（允许的最大等级差距为3）"
L["Returns your Spirit"] = "返回你的精神"
L["Returns your Stamina"] = "返回你的耐力"
L["Returns your Strength"] = "返回你的力量"
L["Spell"] = "法术"
L["Stats"] = "属性"

end

end