------------------------------------------------------------
-- Localization.lua
--
-- Abin
-- 2011/2/20
------------------------------------------------------------

local _, addon = ...

addon.L = {
	["mount"] = "Mount",
	["force ground mount"] = "Summon ground mount",
	["vendors mount"] = "Summon vendors mount",
	["ground"] = "Ground",
	["fly"] = "Fly",
	["vendors"] = "Vendors",
	["swim"] = "Swim",
	["taq"] = "Ahn'Qiraj",
	["desc"] = "Select your prefered mounts, it summons a random one if multiple mounts are selected.",
	["select all"] = "Select All",
	["clear all"] = "Clear All",
	["invert select"] = "Invert Select",
}

if GetLocale() == "zhCN" then
	addon.L = {
		["mount"] = "坐骑",
		["force ground mount"] = "召唤地面坐骑",
		["vendors mount"] = "召唤商贩坐骑",
		["ground"] = "地面",
		["fly"] = "飞行",
		["vendors"] = "商贩",
		["swim"] = "游泳",
		["taq"] = "安其拉",
		["desc"] = "选择你希望使用的坐骑，如果选择了多个坐骑则从中随机召唤。",
		["select all"] = "全部选择",
		["clear all"] = "全部取消",
		["invert select"] = "反向选择",
	}

elseif GetLocale() == "zhTW" then
	addon.L = {
		["mount"] = "坐騎",
		["force ground mount"] = "召喚地面坐騎",
		["vendors mount"] = "召喚商販坐騎",
		["ground"] = "地面",
		["vendors"] = "商販",
		["fly"] = "飛行",
		["swim"] = "游泳",
		["taq"] = "安其拉",
		["desc"] = "選擇你希望使用的坐騎，如果選擇了多個坐騎則從中隨機召喚。",
		["select all"] = "全部選擇",
		["clear all"] = "全部取消",
		["invert select"] = "反向選擇",
	}
end