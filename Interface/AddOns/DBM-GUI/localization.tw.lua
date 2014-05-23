﻿if GetLocale() ~= "zhTW" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame		 = "Deadly Boss Mods"

L.TranslationByPrefix		= ""
L.TranslationBy 			= "黑手歡迎您的加入"
L.Website					= "拜訪我們的討論與支援論壇:|cFF73C2FBhttp://bbs.ngacn.cc/read.php?tid=5397726&page=1|r"
L.WebsiteButton				= "了解黑手"
L.SoundMM					= "|cFFC3C2FB[查看配音介紹]|r"

L.Checkinstance				= "檢查進度"
L.Checkver					= "檢查版本"

L.OTabBosses	= "首領模組"
L.OTabOptions	= "選項"

L.TabCategory_Options		= "綜合設置"
L.TabCategory_MOP	 		= "潘達利亞之謎"
L.TabCategory_CATA	 		= "浩劫與重生"
L.TabCategory_WOTLK 		= "巫妖王之怒"
L.TabCategory_BC 			= "燃燒的遠征"
L.TabCategory_CLASSIC		= "經典魔獸世界"
L.TabCategory_PVP 			= "PvP"
L.TabCategory_OTHER			= "其它"

L.BossModLoaded				= "%s狀態"
L.BossModLoad_now 			= [[該模組尚未載入。
當你進入相應副本時其會自動載入。
你也可以點擊該按鈕手動載入該模組。]]

L.PosX						= 'X座標'
L.PosY						= 'Y座標'

L.MoveMe 					= '移動'
L.Button_OK 				= '確定'
L.Button_Cancel 			= '取消'
L.Button_LoadMod 			= '載入模組'
L.Mod_Enabled				= "啟用首領模組"
L.Mod_Reset					= "恢復默認設置"
L.Reset 					= "重置"

L.Enable  					= "啟用"
L.Disable					= "禁用"

L.NoSound					= "靜音"

L.IconsInUse				= "此模組已使用的標記"


-- Tab: Boss Statistics
L.BossStatistics			= "首領狀態"
L.Statistic_Kills			= "勝利："
L.Statistic_Wipes			= "失敗："
L.Statistic_Incompletes		= "未完成："
L.Statistic_BestKill		= "最快記錄："

-- Tab: General Core Options
L.General 					= "DBM核心綜合設置"
L.EnableDBM 				= "啟用DBM"
L.EnableMiniMapIcon			= "顯示小地圖圖示"
L.SetPlayerRole				= "自動設定玩家角色(建議啟用)"
L.UseMasterVolume			= "使用主要聲音頻道來播放音效檔。"
L.LFDEnhance				= "允許關閉音效後播放團隊確認音"
L.AutologBosses				= "自動使用暴雪戰鬥日誌記錄首領戰鬥"
L.AdvancedAutologBosses		= "自動使用Transcriptor紀錄首領戰鬥"
L.LogOnlyRaidBosses			= "只記錄團隊首領的戰鬥(除了隨機團隊/隨機隊伍/隨機事件)"
L.Latency_Text				= "設定最高延遲同步門檻:%d"
-- Tab: General Timer Options
L.TimerGeneral 				= "DBM計時器綜合設置"
L.SKT_Enabled				= "總是顯示最速勝利計時器(覆蓋首領特定的選項)"
L.ChallengeTimerOptions			= "設置挑戰模式最佳紀錄計時器"
L.ChallengeTimerPersonal	= "個人"
L.ChallengeTimerGuild		= "公會"
L.ChallengeTimerRealm		= "伺服器"

L.ModelOptions				= "3D模型預覽選項"
L.EnableModels				= "在首領選項中啟用3D模型預覽"
L.ModelSoundOptions			= "為模型預覽設置聲音"
L.ModelSoundShort			= "短"
L.ModelSoundLong			= "長"

L.Button_RangeFrame			= "顯示/隱藏距離監視器"
L.Button_RangeRadar			= "顯示/隱藏距離雷達"
L.Button_InfoFrame			= "顯示/隱藏訊息框架"
L.Button_TestBars			= "測試計時條"

L.PizzaTimer_Headline		= '建立一個計時條'
L.PizzaTimer_Title			= '名稱（如“Pizza計時器”）'
L.PizzaTimer_Hours 			= "時"
L.PizzaTimer_Mins 			= "分"
L.PizzaTimer_Secs 			= "秒"
L.PizzaTimer_ButtonStart 	= "開始計時"
L.PizzaTimer_BroadCast		= "向團隊廣播"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "團隊警告"
L.RaidWarning_Header		= "團隊警告選項"
L.RaidWarnColors 			= "團隊警告顏色"
L.RaidWarnColor_1 			= "顏色1"
L.RaidWarnColor_2 			= "顏色2"
L.RaidWarnColor_3			= "顏色3"
L.RaidWarnColor_4 			= "顏色4"
L.InfoRaidWarning			= [[你可以對團隊警告的顏色及其位置進行設定。
在這裡會顯示例如“玩家X受到了Y效果的影響”之類的資訊。]]
L.ColorResetted 			= "該顏色設置已重置"
L.ShowWarningsInChat 		= "在聊天視窗中顯示警告"
L.ShowChatTime			 	= "聊天視窗警告信息前添加時間標籤"
L.ShowFakedRaidWarnings 	= "以偽裝團隊警告資訊的方式顯示警告內容"
L.WarningIconLeft 			= "左側顯示圖示"
L.WarningIconRight 			= "右側顯示圖示"
L.WarningIconChat 			= "在聊天視窗顯示圖示"
L.ShowCountdownText			= "顯示倒數文字"
L.RaidWarnMessage 			= "感謝您使用Deadly Boss Mods"
L.BarWhileMove 				= "可移動的團隊警告"
L.RaidWarnSound				= "發出團隊警告時播放音效"
L.CountdownVoice			= "設置語音包"
L.CountdownVoice2			= "設置次要的倒數計時聲音"
L.SpecialWarnSound			= "設定只作用於你或你的角色天賦的特別警告的音效"
L.SpecialWarnSound2			= "設定作用於全團的特別警告的音效"
L.SpecialWarnSound3			= "設定作用於毀滅性技能的特別警告的音效"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "綜合訊息"
L.CoreMessages				= "核心訊息選項"
L.ShowLoadMessage 			= "在聊天視窗顯示模組載入訊息"
L.ShowPizzaMessage 			= "在聊天視窗顯示計時器廣播訊息"
L.CombatMessages			= "戰鬥訊息選項"
L.ShowEngageMessage 		= "在聊天視窗顯示開戰訊息"
L.ShowKillMessage 			= "在聊天視窗顯示戰勝訊息"
L.ShowWipeMessage 			= "在聊天視窗顯示滅團訊息"
L.ShowRecoveryMessage 		= "在聊天視窗顯示計時器恢復訊息"
L.WhisperMessages			= "密語訊息選項"
L.AutoRespond 				= "啟用戰鬥中自動密語回覆"
L.EnableStatus 				= "回覆'status'的密語"
L.WhisperStats 				= "在密語回應中加入戰勝/滅團狀態"

-- Tab: Barsetup
L.BarSetup   				= "計時條樣式"
L.BarTexture 				= "計時條材質"
L.BarStartColor				= "開始顏色"
L.BarEndColor 				= "結束顏色"
L.ExpandUpwards				= "計時條向上延伸"
L.Bar_Font					= "計時條使用的字型"
L.Bar_FontSize				= "字型大小"
L.Slider_BarOffSetX 		= "X偏移:%d"
L.Slider_BarOffSetY 		= "Y偏移:%d"
L.Slider_BarWidth 			= "寬度:%d"
L.Slider_BarScale 			= "尺寸:%0.2f"
L.AreaTitle_BarSetup		= "計時條綜合設置"
L.AreaTitle_BarSetupSmall 	= "小型計時條設置"
L.AreaTitle_BarSetupHuge	= "大型計時條設置"
L.BarIconLeft 				= "左側顯示圖示"
L.BarIconRight 				= "右側顯示圖示"
L.EnableHugeBar 			= "開啟大型計時條（2號計時條）"
L.FillUpBars				= "填滿計時條"
L.ClickThrough				= "禁用鼠標事件（允許你點擊穿透計時條）"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "特別警告"
L.Area_SpecWarn				= "特別警告選項"
L.SpecWarn_Enabled			= "為首領的技能顯示特別警告"
L.SpecWarn_FlashFrame		= "特別警告屏幕邊緣泛光"
L.SpecWarn_ShakeFrame		= "為毀滅性技能閃爍屏幕"
L.SpecWarn_AdSound			= "啓用特別警告高級聲音選項（需要UI重載）"
L.SpecWarn_Font				= "特別警告使用的字型"
L.SpecWarn_FontSize			= "字型大小: %d"
L.SpecWarn_FontColor		= "字型顏色"
L.SpecWarn_FontType			= "選擇字型"
L.SpecWarn_FlashColor		= "泛光顏色 (%d)"
L.SpecWarn_FlashDur			= "泛光持續時間: %0.1f"
L.SpecWarn_FlashAlpha		= "泛光透明度: %0.1f"
L.SpecWarn_DemoButton		= "顯示範例"
L.SpecWarn_MoveMe			= "設定位置"
L.SpecWarn_ResetMe			= "重置為預設值"

L.Panel_LTSpecWarnFrame		= "長效特別警告"
L.Area_LTSpecWarn			= "長效特別警告選項"
L.LTSpecWarn_Enabled		= "啟用長效特別警告"
L.LTSpecWarn_Font			= "長效特別警告使用的字型"
L.TestWarningEnd			= "範例只存在五秒，但真實的長效特別警告會長時間的存在於你的屏幕上直到觸發取消事件"

-- Tab: HealthFrame
L.Panel_HPFrame				= "血量框架"
L.Area_HPFrame				= "血量框架選項"
L.HP_Enabled				= "總是顯示血量框架 (覆蓋首領特定的選項)"
L.HP_GrowUpwards			= "血量框架向上延伸"
L.HP_ShowDemo				= "顯示血量框架"
L.BarWidth					= "寬度:%d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "整體及垃圾過濾"
L.Area_SpamFilter				= "垃圾過濾選項"
L.StripServerName				= "隱藏警告和計時器的玩家伺服器名稱"
L.SpamBlockBossWhispers			= "當戰鬥時過濾 &lt;DBM&gt; 密語警告"
L.BlockVersionUpdateNotice		= "禁用彈出的更新通知"
L.ShowBigBrotherOnCombatStart	= "戰鬥開始時顯示BigBrother(檢查團隊 增益/精煉UI)"
L.BigBrotherAnnounceToRaid		= "通告BigBrother的結果給團隊"

L.Area_SpamFilter_Outgoing		= "整體過濾選項"
L.SpamBlockNoShowAnnounce		= "不顯示提示或播放警告音效"
L.SpamBlockNoSendWhisper		= "不發送密語給其他玩家"
L.SpamBlockNoSetIcon			= "不設置標記在目標上"
L.SpamBlockNoRangeFrame			= "不顯示距離框架"
L.SpamBlockNoInfoFrame			= "不顯示訊息框架"

L.Area_PullTimer				= "開怪計時器過濾選項"
L.DontShowPTNoID				= "不顯示不同區域的倒計時"
L.DontShowPT					= "不要顯示開怪倒數計時條"
L.DontShowPTText			= "不要顯示開怪倒數文字"
L.DontPlayPTCountdown			= "不要使用開怪倒數音效"
L.DontShowPTCountdownText		= "不要顯示開怪倒數动画"
L.PT_Threshold					= "不顯示高於%d秒的倒數动画"

L.Panel_HideBlizzard				= "隱藏暴雪框架"
L.Area_HideBlizzard				= "隱藏暴雪框架選項"
L.HideBossEmoteFrame				= "首領戰中隱藏團隊首領表情框體"
L.HideWatchFrame				= "首領戰中隱藏任務追蹤框體"
L.SpamBlockSayYell				= "隱藏聊天窗口中的使用聊天泡泡的警報信息"
L.DisableCinematics				= "禁用遊戲中的過場動畫"
L.AfterFirst					= "在每次動畫播放一次之後"
L.Always						= "總是"

-- Misc
L.FontHeight	= 18