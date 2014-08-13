local addonName = ...
local VERSION = GetAddOnMetadata(addonName, "Version")
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")
if not L then return end 
L["Helm"] = "头部"
L["Neck"] = "颈部"
L["Shoulders"] = "肩部"
L["Chest"] = "胸部"
L["Belt"] = "腰部"
L["Legs"] = "腿部"
L["Boots"] = "脚部"
L["Bracers"] = "手腕"
L["Gloves"] = "手部"
L["Ring 1"] = "手指 1"
L["Ring 2"] = "手指 2"
L["Trinket 1"] = "饰品 1"
L["Trinket 2"] = "饰品 2"
L["Cloak"] = "背部"
L["Main Hand"] = "主手"
L["Off Hand"] = "副手"
L["Equipped Average Item Level Tooltip"] = "Equipped Average Item Level Tooltip"
L["Version "] = "版本 "
L[" by Isoloedlk of US-Khaz Modan"] = " 由 US-Khaz Modan 的 Isoloedlk 制作"
L["Show Specialization"] = "显示天赋树"
L["Show Item List"] = "显示物品列表"
L["Decimal Places"] = "小数点位置"
L["Inspect Request Delay"] = "查看请求延迟"
L['Name'] = '名字';
L['Specialization'] = '专精';
L['Equipped iLvl'] = '已装备物品等级';
L["You are not in a group."] = "你不在一个队伍中.";
L["You are in PvP."] = "你在 PvP 中.";
L["None"] = "无";
L["Unknown"] = "未知";
L["Group Item Levels:"] = "队伍物品等级:";
L["ilvl(s): Loading..."] = "物品等级: 载入中...";
L["ilvl(s): "] = "物品等级: ";
L["A newer version is available.  Visit http://www.wowinterface.com to download the latest version."] = "新版本可用.  访问://www.wowinterface.com 下载最新版本."
L["Spec:"] = "专精:";
L["iLvl:"] = "物品等级:";
L["PVP:"] = "PVP:";
L["None/Not Scanned"] = "无/未扫描";