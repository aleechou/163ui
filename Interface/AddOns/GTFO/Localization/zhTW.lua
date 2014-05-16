﻿--------------------------------------------------------------------------
-- zhTW.lua 
--------------------------------------------------------------------------
--[[
GTFO Traditional Chinese Localization
Translators: wowuicn, lsjyzjl, xazhaoyang, Andyca, BNSSNB
]]--

if (GetLocale() == "zhTW") then

GTFOLocal = 
{
	Active_Off = "插件暫停",
	Active_On = "插件恢復",
	AlertType_Fail = "犯錯",
	AlertType_FriendlyFire = "友方攻擊",
	AlertType_High = "高",
	AlertType_Low = "低",
	ClosePopup_Message = "你可以稍後輸入：%s 來設定GTFO。",
	Group_None = "無",
	Group_NotInGroup = "你不一個隊伍或團隊中.",
	Group_PartyMembers = "其中有 %d 位 / 全隊： %d 位隊伍成員使用了本插件。",
	Group_RaidMembers = "其中有 %d 位 / 全隊： %d 位團員使用了本插件。",
	Help_Intro = "v%s (|cFFFFFFFF命令列表|r)",
	Help_Options = "顯示選項",
	Help_Suspend = "暫停/恢復插件",
	Help_Suspended = "該插件目前是暫停狀態.",
	Help_TestFail = "播放一個測試音效 (犯錯警報)",
	Help_TestFriendlyFire = "測試播放一個音效 (友方攻擊)",
	Help_TestHigh = "播放一個測試音效 (高傷害)",
	Help_TestLow = "播放一個測試音效 (低傷害)",
	Help_Version = "顯示團隊中，其他正在使用這個插件的成員",
	Loading_Loaded = "v%s 載入完成.",
	Loading_LoadedSuspended = "v%s 載入完成. (|cFFFF1111暫停|r)",
	Loading_LoadedWithPowerAuras = "v%s 與 Power Auras 同時載入完成.",
	Loading_NewDatabase = "v%s: 發現新的數據庫版本, 重設為預設.",
	Loading_OutOfDate = "v%s 發現一個新的版本下載!  |cFFFFFFFF請盡快更新.|r",
	LoadingPopup_Message = "你的GTFO設定已被重置為預設值。你是否想要立即設定GTFO？",
	Loading_PowerAurasOutOfDate = "你的 |cFFFFFFFFPower Auras Classic|r 版本已過期!  GTFO & Power Auras 將無法同時載入。",
	Recount_Environmental = "環境",
	Recount_Name = "GTFO 警報",
	Skada_AlertList = "GTFO 警報類型",
	Skada_Category = "警報",
	Skada_SpellList = "GTFO 法術",
	TestSound_Fail = "測試播放一個(犯錯警報)音效。",
	TestSound_FailMuted = "測試播放一個(犯錯警報)音效. [|cFFFF4444靜音|r]",
	TestSound_FriendlyFire = "測試播放一個(友方攻擊)音效.",
	TestSound_FriendlyFireMuted = "測試播放一個(友方攻擊)音效. [|cFFFF4444靜音|r]",
	TestSound_High = "測試播放一個(高傷害)音效.",
	TestSound_HighMuted = "測試播放一個(高傷害)音效. [|cFFFF4444靜音|r]",
	TestSound_Low = "測試播放一個(低傷害)音效.",
	TestSound_LowMuted = "測試播放一個(低傷害)音效. [|cFFFF4444靜音|r]",
	UI_Enabled = "啟用",
	UI_EnabledDescription = "啟用 GTFO 插件.",
	UI_Fail = "犯錯警報音效",
	UI_FailDescription = "當你應該走位卻沒走位時，播放GTFO警報音效 -- 希望下次能改善!",
	UI_FriendlyFire = "友方攻擊音效",
	UI_FriendlyFireDescription = "當你的站位受到友方攻擊時(如燃燒、爆炸等)，啟用GTFO警告音效。你們其中之一最好離開!",
	UI_HighDamage = "團隊/高傷害音效",
	UI_HighDamageDescription = "當你位於會受到高傷害的位置時，立即啟用播放GTFO強烈的警告音效。",
	UI_LowDamage = "PvP/環境/低傷害音效",
	UI_LowDamageDescription = "當你還在考慮或是沒離開低傷害區時，啟動GTFO低傷害音效。",
	UI_Test = "測試",
	UI_TestDescription = "測試音效.",
	UI_TestMode = "實驗/測試模式",
	UI_TestModeDescription = "啟用未測試的/未驗證的警報。(Beta/PTR)",
	UI_TestModeDescription2 = "如有任何問題，請回報到 |cFF44FFFF%s@%s.%s|r",
	UI_Trivial = "低等級警報",
	UI_TrivialDescription = "啟用低等級的副本警報.",
	UI_Unmute = "當靜音時播放音效",
	UI_UnmuteDescription = "如果你關閉了主音量，GTFO將暫時開啟音量來播放GTFO的警報。",
	UI_UnmuteDescription2 = "這個設定需要主音量高於 0%.",
	UI_Volume = "GTFO 音量",
	UI_VolumeDescription = "設置警報音效的音量.",
	UI_VolumeLoud = "4: 大聲",
	UI_VolumeLouder = "5: 大聲",
	UI_VolumeMax = "最大",
	UI_VolumeMin = "最小",
	UI_VolumeNormal = "3: 一般 (推薦)",
	UI_VolumeQuiet = "1: 安靜",
	UI_VolumeSoft = "2: 柔和",
	-- 4.12
	UI_SpecialAlerts = "特殊警報",
	UI_SpecialAlertsHeader = "啟用特殊警報",
	-- 4.12.3
	Version_On = "版本更新提醒啟用",
	Version_Off = "版本更新提醒關閉",
	-- 4.19
	UI_TrivialSlider = "最低 % 百分比血量",
	UI_TrivialDescription2 = "設置一個最低百分比血量 % ，在低於設定數值時提示你.",
}



end