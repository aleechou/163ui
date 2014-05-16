﻿--------------------------------------------------------------------------
-- zhCN.lua 
--------------------------------------------------------------------------
--[[
GTFO Simplified Chinese Localization
Translator: wowuicn, xazhaoyang, lsjyzjl
]]--

if (GetLocale() == "zhCN") then

GTFOLocal = 
{
	Active_Off = "插件暂停",
	Active_On = "插件恢复",
	AlertType_Fail = "犯错",
	AlertType_FriendlyFire = "友方攻击",
	AlertType_High = "高",
	AlertType_Low = "低",
	ClosePopup_Message = "你可以稍后输入: %s 来配置GTFO.",
	Group_None = "无",
	Group_NotInGroup = "你不一个小队或团队中.",
	Group_PartyMembers = "%d 超过 %d 位小队成员使用了本插件.",
	Group_RaidMembers = "%d 超过 %d 位团员使用了本插件.",
	Help_Intro = "v%s (|cFFFFFFFF命令列表|r)",
	Help_Options = "显示选项",
	Help_Suspend = "暂停/恢复插件",
	Help_Suspended = "该插件目前是暂停状态.",
	Help_TestFail = "播放一个测试音效 (犯错警报)",
	Help_TestFriendlyFire = "测试播放一个音效 (友方攻击)",
	Help_TestHigh = "播放一个测试音效 (高伤害)",
	Help_TestLow = "播放一个测试音效 (低伤害)",
	Help_Version = "显示其他团队中正在使用这个插件的人员",
	LoadingPopup_Message = "你的GTFO设置已被重置为默认。你是否想要立即配置GTFO？",
	Loading_Loaded = "v%s 载入完成.",
	Loading_LoadedSuspended = "v%s 载入完成. (|cFFFF1111暂停|r)",
	Loading_LoadedWithPowerAuras = "v%s 与 Power Auras 同时载入完成.",
	Loading_NewDatabase = "v%s: 发现新的数据库版本, 重设为预设.",
	Loading_OutOfDate = "v%s 发现一个新的版本下载!  |cFFFFFFFF请尽快更新.|r",
	Loading_PowerAurasOutOfDate = "你的 |cFFFFFFFFPower Auras Classic|r 版本已过期!  GTFO & Power Auras 将无法同时加载.",
	Recount_Environmental = "环境",
	Recount_Name = "GTFO 警报",
	Skada_AlertList = "GTFO 警报类型",
	Skada_Category = "警报",
	Skada_SpellList = "GTFO 法术",
	TestSound_Fail = "测试播放一个(犯错警报)音效.",
	TestSound_FailMuted = "测试播放一个(犯错警报)音效. [|cFFFF4444静音|r]",
	TestSound_FriendlyFire = "测试播放一个(友方攻击)音效.",
	TestSound_FriendlyFireMuted = "测试播放一个(友方攻击)音效. [|cFFFF4444静音|r]",
	TestSound_High = "测试播放一个(高伤害)音效.",
	TestSound_HighMuted = "测试播放一个(高伤害)音效. [|cFFFF4444静音|r]",
	TestSound_Low = "测试播放一个(低伤害)音效.",
	TestSound_LowMuted = "测试播放一个(低伤害)音效. [|cFFFF4444静音|r]",
	UI_Enabled = "启用",
	UI_EnabledDescription = "启用 GTFO 插件.",
	UI_Fail = "犯错警报 音效",
	UI_FailDescription = "当错误移动时 GTFO 警报音效!",
	UI_FriendlyFire = "友方攻击音效",
	UI_FriendlyFireDescription = "当你的站位受到友方攻击时，启用 GTFO 警告音效!",
	UI_HighDamage = "团队/高伤害 音效",
	UI_HighDamageDescription = "当你于团队中处在一个高伤害站位时，立即启用这个警报音效.",
	UI_LowDamage = "PvP/环境/低伤害 音效",
	UI_LowDamageDescription = "当你在低危险环境/PVP环境的站位时，发出GTFO-boop音效",
	UI_Test = "测试",
	UI_TestDescription = "测试这个音效.",
	UI_TestMode = "实验/测试 模式",
	UI_TestModeDescription = "激活未测试的/未验证的警报.(Beta/PTR)",
	UI_TestModeDescription2 = "请报告任何问题到 |cFF44FFFF%s@%s.%s|r",
	UI_Trivial = "低等级报警",
	UI_TrivialDescription = "启用低等级的副本警报.",
	UI_Unmute = "当静音时播放音效",
	UI_UnmuteDescription = "如果你禁音了主音效，GTFO将临时开启来播放 GTFO 警报音效.",
	UI_UnmuteDescription2 = "这个设定需要主音量高于 0%.",
	UI_Volume = "GTFO 音量",
	UI_VolumeDescription = "设置警报音效的音量.",
	UI_VolumeLoud = "4: 高声",
	UI_VolumeLouder = "5: 洪亮",
	UI_VolumeMax = "最大",
	UI_VolumeMin = "最小",
	UI_VolumeNormal = "3: 默认 (推荐)",
	UI_VolumeQuiet = "1: 安静",
	UI_VolumeSoft = "2: 柔和",
	-- 4.12
	UI_SpecialAlerts = "特殊警报",
	UI_SpecialAlertsHeader = "启用特殊警报",
	-- 4.12.3
	Version_On = "版本更新提醒启用",
	Version_Off = "版本更新提醒关闭",
	-- 4.19
	UI_TrivialSlider = "最低 % 百分比血量",
	UI_TrivialDescription2 = "设置一个最低百分比血量 % ，在低于设定数值时提示你.",
}



end