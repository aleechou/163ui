if GetLocale() ~= "zhTW" then return end

DBM_CORE_NEED_SUPPORT				= "你是否擁有良好的程式開發或語言能力? 如果是的話, DBM團隊真的需要你的幫助以保持成為WOW裡最佳的首領模組。觀看 www.deadlybossmods.com 或發送郵件到 tandanu@deadlybossmods.com 或 nitram@deadlybossmods.com 來加入團隊。"
DBM_HOW_TO_USE_MOD					= "歡迎使用黑手之鄉DBM-語音版。在聊天頻道輸入 /dbm 打開設定開始設定。你可以載入特定區域後為任何首領設定你喜歡的特別設置。DBM會在第一次啟動時嘗試掃描你的職業天賦，但有些選項你可能想打開。"

DBM_FORUMS_MESSAGE					= "發現BUG或錯誤? 希望有新的警告，計時器或是特別功能? \n |HDBM:論壇|h|cff3588ffhttp://bbs.ngacn.cc/read.php?tid=5397726&page=1|r (你可以點擊複製網址)"
DBM_FORUMS_COPY_URL_DIALOG			= "拜訪我們的討論與支援論壇\r"

DBM_CORE_LOAD_MOD_ERROR				= "載入%s模組時發生錯誤：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功載入%s模組。輸入/dbm或/dbm help有更多選項。"
DBM_CORE_LOAD_MOD_COMBAT			= "延遲載入'%s'直到離開戰鬥"
DBM_CORE_LOAD_GUI_ERROR				= "無法載入圖形介面：%s"
DBM_CORE_LOAD_GUI_COMBAT			= "圖形介面不能在戰鬥中初始化。圖形介面將在戰鬥後自動讀取，這樣就能夠在戰鬥中使用。"
DBM_CORE_BAD_LOAD					= "DBM偵測到你的此副本的模組在戰鬥中讀取失敗。一旦脫離戰鬥，請立即輸入/consoel reloadui重新載入。"

DBM_CORE_LOOT_SPEC_REMINDER			= "你目前的專精為:%s。而你目前的拾取選擇為:%s。"

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM偵測到你同時開啟BigWigs和DBM的團隊圖示。請關閉其中之一的團隊圖示功能以免與你的隊伍隊長產生衝突。"

DBM_CORE_COMBAT_STARTED				= "%s開戰。祝好運與盡興! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "開戰%s已進行的戰鬥。祝好運與盡興! :)"
DBM_CORE_SCENARIO_STARTED			= "%s開始。祝好運與盡興! :)"
DBM_CORE_BOSS_DOWN					= "擊敗%s，經過%s!"
DBM_CORE_BOSS_DOWN_I				= "擊敗%s!你已勝利了%d次。"
DBM_CORE_BOSS_DOWN_L				= "擊敗%s!本次經過%s，上次經過%s，最快紀錄為%s。你總共戰勝了%d次。"
DBM_CORE_BOSS_DOWN_NR				= "擊敗%s!經過%s! 這是一個新記錄! (舊紀錄為%s) 你總共戰勝了%d次。"
DBM_CORE_SCENARIO_COMPLETE			= "%s完成!經過%s!"
DBM_CORE_SCENARIO_COMPLETE_L		= "%s完成!本次經過%s，上次經過%s，最快紀錄為%s。你總共完成了%d次。"
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s完成!經過%s! 這是一個新記錄! (舊紀錄為%s) 你總共完成了%d次。"
DBM_CORE_COMBAT_ENDED_AT			= "%s(%s)的戰鬥經過%s結束。"
DBM_CORE_COMBAT_ENDED_AT_LONG		= "%s(%s)的戰鬥經過%s結束。你在這個難度總共滅團了%d次。"
DBM_CORE_SCENARIO_ENDED_AT			= "%s結束!經過%s!"
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s結束!本次經過%s，你已有共%d次未完成的嘗試在這個難度裡。"
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s的戰鬥在%s前開始，恢復計時器中..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Transcriptor開始記錄."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Transcriptor結束紀錄."

DBM_CORE_TIMER_FORMAT_SECS			= "%d秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分鐘"
DBM_CORE_TIMER_FORMAT				= "%d分%d秒"

DBM_CORE_MIN						= "分"
DBM_CORE_MIN_FMT					= "%d分"
DBM_CORE_SEC						= "秒"
DBM_CORE_SEC_FMT					= "%d秒"

DBM_CORE_GENERIC_WARNING_OTHERS		= "和另外一個"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "和另外%d個"
DBM_CORE_GENERIC_WARNING_BERSERK	= "%s%s後狂暴"
DBM_CORE_GENERIC_TIMER_BERSERK		= "狂暴"
DBM_CORE_OPTION_TIMER_BERSERK			= "計時器：$spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "戰鬥開始"
DBM_CORE_OPTION_TIMER_COMBAT			= "計時器：戰鬥開始"
DBM_CORE_OPTION_HEALTH_FRAME		= "顯示首領血量框架"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "計時器"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "警告"
DBM_CORE_OPTION_CATEGORY_SPECWARNINGS	= "特別警告"
DBM_CORE_OPTION_CATEGORY_SOUND			= "語音版額外選項"
DBM_CORE_OPTION_CATEGORY_MISC			= "其它"

DBM_CORE_AUTO_RESPONDED						= "已自動回覆密語。"
DBM_CORE_STATUS_WHISPER						= "%s：%s，%d/%d存活。"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s正在與%s交戰（當前%s，%d/%d存活）"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s已經擊敗%s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s已經擊敗%s! 他們總共已擊殺了%d次。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s在%s還有%s時滅團了。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s在%s還有%s時滅團了。他們在這個難度總共滅團了%d次。"
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s忙碌於%s(%d/%d存活)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s已經完成%s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s已經完成%s!他們總共有%d次勝利。"
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s未完成%s。"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s未完成%s。他們在這個難度總共未完成%d次。"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - 版本檢測"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s：%s(r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) & %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s：尚未安裝任何團隊首領模組"
DBM_CORE_VERSIONCHECK_FOOTER			= "團隊中有%d玩家正在使用DBM / %d玩家正在使用Bigwigs"
DBM_CORE_YOUR_VERSION_OUTDATED			= "你的 Deadly Boss Mod 已經過期。請到 www.deadlybossmods.com 下載最新版本。"
DBM_CORE_OUTDATED_PVP_MODS			= "你的DBM-PvP模組已經過期而且如果不使用請移除,或是更新最新的獨立包. 這些模組不在包含在DBM-Core下載. 尋找最新的PVP模組在http://www.deadlybossmods.com"
--DBM_BIG_WIGS (Same as English locales)
--DBM_BIG_WIGS_ALPHA (Same as English locales)

DBM_CORE_UPDATEREMINDER_HEADER			= "你的Deadly Boss Mod已經過期。\n你可以在此網址下載到新版本%s(r%d)："
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "你的alpha版本Deadly Boss Mods已經過期。\n 你至少落後%d個測試版本。建議DBM使用者使用最新的alpha或最新的穩定版本。過期的alpha版本可能會有低落或未完成的功能。"
DBM_CORE_UPDATEREMINDER_FOOTER			= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製下載網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_NOTAGAIN		= "當有新版本時顯示彈出提示"
DBM_CORE_UPDATEREMINDER_DISABLE			= "警告: 你的DBM版本已大幅度的過期(%d修訂版)，已被禁用了除非更新至最新版本。這是為了確保舊而不相容的程式碼不會對你而團隊夥伴造成低落的遊戲體驗。"
DBM_CORE_UPDATEREMINDER_HOTFIX			= "你的DBM版本會在這首領戰鬥有不準確的計時器或警告。這問題已被修正在下次正式版更新或可以更新至最新的alpha版本立即修正此問題。"

DBM_CORE_MOVABLE_BAR				= "拖動我!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h向你發送了一個倒數計時：'%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[取消該計時]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[忽略來自%1$s的計時]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在該次遊戲連結中忽略來自%s的計時？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <時間（秒）> <文字>"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+左鍵或右鍵點擊即可移動，Alt+Shift+點擊即可拖放"

DBM_CORE_RANGECHECK_HEADER			= "距離監視（%d碼）"
DBM_CORE_RANGECHECK_SETRANGE		= "設置距離"
DBM_CORE_RANGECHECK_SOUNDS			= "音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "當一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "當多於一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_0			= "沒有音效"
DBM_CORE_RANGECHECK_SOUND_1			= "預設音效"
DBM_CORE_RANGECHECK_SOUND_2			= "蜂鳴聲"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d碼"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "框架"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "顯示雷達框架"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "顯示文字框"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "兩者都顯示"
DBM_CORE_RANGERADAR_HEADER			= "距離雷達(%d碼)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d玩家在範圍內"

DBM_CORE_INFOFRAME_SHOW_SELF		= "總是顯示你的能量"

DBM_LFG_INVITE						= "地城準備確認"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/dbm version：進行團隊範圍內的版本檢測（也可使用：ver）。",
--	"/dbm version2: 進行團隊範圍內的版本檢測及密語通知已過期的成員（也可使用: ver2）。",
	"/dbm unlock：顯示一個可移動的計時器（也可使用：move）。",
	"/dbm timer <x> <文字>：開始一個以<文字>為名稱的時間為<x>秒的計時器。",
	"/dbm broadcast timer <x> <文字>：向團隊廣播一個以<文字>為名稱，時間為<x>秒的計時器（需要團隊隊長或助理權限）。",
	"/dbm break <分鐘>: 開始休息計時器<分鐘>。向所有團隊成員發送一個DBM休息計時器（需要團隊隊長或助理權限）。",
	"/dbm pull <秒數>: 開始備戰計時器<秒數>。向所有團隊成員發送一個DBM備戰計時器（需要團隊隊長或助理權限）。",
	"/dbm arrow: 顯示DBM箭頭, 輸入 /dbm arrow help 獲得更多訊息。",
	"/dbm lockout: 向團隊成員請求他們當前的團隊副本鎖定訊息(鎖定訊息、副本id) (需要團隊隊長或助理權限)。",
	"/dbm lag: 進行團隊範圍內的網路延遲檢測。",
	"/dbm help：顯示可用命令的說明。"
}

DBM_ERROR_NO_PERMISSION				= "無權進行此操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "關閉血量框架"

DBM_CORE_UNKNOWN					= "未知"
DBM_CORE_LEFT						= "左"
DBM_CORE_RIGHT						= "右"
DBM_CORE_BACK						= "後"
DBM_CORE_FRONT						= "前"

DBM_CORE_SETTO						= "設置為："
DBM_CORE_SETWISP					= "的觀察目標設置為你，請協助檢查是否正確。"
DBM_CORE_WRONGSET					= "|cFFFF0000你輸入了錯誤的內容："

DBM_CORE_BREAK_START				= "現在開始休息-你有%s分鐘!"
DBM_CORE_BREAK_MIN					= "%s分鐘後休息時間結束!"
DBM_CORE_BREAK_SEC					= "%s秒後休息時間結束!"
DBM_CORE_TIMER_BREAK				= "休息時間!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "休息時間已經結束"

DBM_CORE_TIMER_PULL					= "戰鬥準備"
DBM_CORE_ANNOUNCE_PULL				= "%d秒後拉怪  (%s)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "拉怪囉!"
DBM_CORE_ANNOUNCE_PULL_CANCEL		= "取消了戰鬥準備倒計時"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL 		= "成就：最速勝利"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target					= "%s:>%%s<",
	targetcount				= "%s (%%d):>%%s<",
	spell					= "%s",
	ends 					= "%s 結束",
	fades					= "%s 消散",
	adds					= "%s 剩餘：%%d",
	cast					= "正在施放 %s: %.1f 秒",
	soon					= "%s 即將到來",
	prewarn					= "%2$s後 %1$s",
	phase					= "第%s階段",
	prephase				= "第%s階段 即將到來",
	count					= "%s (%%d)",
	stack					= "%s: >%%s< (%%d)",
}

local prewarnOption				= "預先警告：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target					= "警告：$spell:%s的目標",
	targetcount				= "警告：$spell:%s的目標",
	spell					= "警告：$spell:%s",
	ends 					= "警告：$spell:%s結束",
	fades					= "警告：$spell:%s消散",
	adds					= "警告：$spell:%s剩餘數量",
	cast					= "警告：$spell:%s的施放",
	soon					= prewarnOption,
	prewarn					= prewarnOption,
	phase					= "警告：第%s階段",
	prephase				= "預先警告：第%s階段",
	count					= "警告：$spell:%s",
	stack					= "警告：$spell:%s疊加層數",
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell					= "%s!",
	ends					= "%s 結束",
	fades					= "%s 消失",
	soon					= "%s 即将到来",
	prewarn					= "%2$s後 %1$s",
	dispel					= ">%%s<中了%s - 快驅散",
	interrupt				= "%s - 快打斷>%%s< !",
	you						= "你中了%s",
	target					= ">%%s<中了%s",
	close					= "你附近的>%%s<中了%s",
	move					= "%s - 快移動",
	reflect					= "%s - 停止攻擊",
	run						= "%s - 快躲開",
	cast					= "%s - 停止施法",
	count 					= "%s! (%%d)",
	stack 					= "你疊加了%%d層%s",
	switch					= ">%s< - 轉換目標!"
}

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell					= "特別警告：$spell:%s",
	ends					= "特別警告：$spell:%s結束",
	fades					= "特別警告：$spell:%s消失",
	soon					= "特別警告：$spell:%s即将到来",
	prewarn					= "特別警告：%d秒後$spell:%s",
	dispel					= "特別警告：需要驅散/竊取$spell:%s時",
	reflect 				= "特別警告：$spell:%s需要停止攻擊時",--Spell Reflect
	interrupt				= "特別警告：需要打斷$spell:%s時",
	you						= "特別警告：當你中了$spell:%s時",
	target					= "特別警告：當有人中了$spell:%s時",
	close					= "特別警告：當你附近有人中了$spell:%s時",
	move					= "特別警告：當你需要躲開$spell:%s時",
	run						= "特別警告：當你需要遠離$spell:%s時",
	cast					= "特別警告：$spell:%s的施放",
	count 					= "特別警告：$spell:%s",
	stack					= "特別警告：當疊加了>=%d層$spell:%s時",
	switch 					= "特別警告：針對$spell:%s轉換目標"
}

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target					= "%s:>%%s<",
	cast					= "%s",
	active					= "%s結束",
	fades					= "%s消散",
	cd						= "%s冷卻",
	cdcount					= "%s冷卻 (%%d)",
	cdsource				= "%s冷卻: >%%s<",
	next 					= "下一次%s",
	nextcount 				= "下一次%s (%%d)",
	nextsource				= "下一次%s: >%%s<",
	achievement 			= "%s"
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target					= "計時器：$spell:%s減益效果持續時間",
	cast					= "計時器：$spell:%s施法時間",
	active					= "計時器：$spell:%s持續時間",
	fades					= "計時器：$spell:%s何時從玩家身上消失",
	cd						= "計時器：$spell:%s冷卻時間",
	cdcount					= "計時器：$spell:%s冷卻時間",
	cdsource				= "計時器：$spell:%s冷卻時間",
	next					= "計時器：下一次$spell:%s",
	nextcount				= "計時器：下一次$spell:%s",
	nextsource				= "計時器：下一次$spell:%s",
	achievement				= "計時器：成就%s"
}


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "為$spell:%s的目標設置團隊標記"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "為$spell:%s設置團隊標記"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "語音警告：當你中了$spell:%s時"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "倒計時：$spell:%s的冷卻時間"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2		= "倒計時：$spell:%s的消散時間"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "正計時：$spell:%s的持續時間"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "自動喊話：當你中了$spell:%s時"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "" .. UnitName("player") .. "中了%s!"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "距離監視(%s)：$spell:%s"
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT		= "距離監視(%s)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT		= "資訊框：$spell:%s"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT		= "當首領開打時撥放準備檢查的音效(即使沒有選定目標)"

-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "可拖動的特別警告"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "特別警告"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "在此區域中不支援%d碼的距離檢查。\n已支援的距離有10，11，15及28碼。"

DBM_ARROW_MOVABLE					= "可移動箭頭"
DBM_ARROW_NO_RAIDGROUP				= "DBM箭頭僅可在副本中調試。"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 用法:",
	"/dbm arrow <x> <y>  建立一個箭頭在特定的位置(0 < x/y < 100)",
	"/dbm arrow <玩家>  建立並箭頭指向你的隊伍或團隊中特定的玩家",
	"/dbm arrow hide  隱藏箭頭",
	"/dbm arrow move  可移動箭頭"
}

DBM_SPEED_KILL_TIMER_TEXT	= "勝利紀錄"
DBM_SPEED_KILL_TIMER_OPTION			= "計時器：最快勝利"
DBM_SPEED_CLEAR_TIMER_TEXT	= "最佳紀錄"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s想要查看你的副本ID和進度鎖定情況。\n你想發送該訊息給%s嗎? 在你的當前進程（除非你下線）他可以一直查閱該訊息。"
DBM_ERROR_NO_RAID					= "你必須在一個團隊中才可以使用這個功能。"
DBM_INSTANCE_INFO_REQUESTED			= "查看團隊成員的副本鎖定訊息。\n請注意，隊員們將會被詢問是否願意發送資料給你，因此可能需要等待一段時間才能獲得全部的回覆。"
DBM_INSTANCE_INFO_STATUS_UPDATE		= "從%d個玩家獲得訊息，來自%d個DBM用戶：%d人發送了資料, %d人拒絕回傳資料。繼續為更多回覆等待%d秒..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "已獲得全部團隊成員的回傳資料"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "發送者:%s 結果類型:%s 副本名:%s 副本ID:%s 難度:%d 大小:%d 進度:%s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s(%d), 難度%d:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, 進度%d:%s"
DBM_INSTANCE_INFO_STATS_DENIED		= "拒絕回傳數據:%s"
DBM_INSTANCE_INFO_STATS_AWAY		= "離開:%s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "沒有安裝最新版本的DBM:%s"
DBM_INSTANCE_INFO_RESULTS			= "副本ID掃描結果。注意如果團隊中有不同語言版本的魔獸客戶端，那麼同一副本可能會出現不止一次。"
DBM_INSTANCE_INFO_SHOW_RESULTS		= "回复請求的玩家: %s\n|HDBM:showRaidIdResults|h|cff3588ff[查看結果]|r|h"

DBM_CORE_LAG_CHECKING				= "延遲檢測--五秒後反饋結果..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - 延遲檢測"
DBM_CORE_LAG_ENTRY					= "%s：世界延時[%d毫秒] / 本地延時[%d毫秒]"
DBM_CORE_LAG_FOOTER					= "未反饋此次檢測的團員:%s"

DBM_CORE_SOUNDVER					= "語音增強版"

DBM_CORE_GUILDAD_HEADER_GENERIC		= "黑手之鄉簡介"
DBM_CORE_GUILDAD_GENERIC			= "        黑手之鄉成立于2007年10月17日，前身是國服三區雷斧堡壘的聯盟公會盟誓的二團。團長一直是阿爾貝裏希（在台服改名爲Aberich）。\n\n        2010年1月，黑手的骨幹十多名玩家一起轉戰台服pve服務器眾星之子，看重的就是這個服務器良好的pve氛圍，希望能在台服繼續我們的夢想。4.2國服同步後，由于團隊已經一部分本土化，亦對台服良好的玩家素質，服務器良好的raid氛圍表示滿意，團隊留在了台服並准備一直留下去。\n\n        建會以來，團隊一直保持了比較強的開荒強度，鍛煉了團隊，也收集了很多優秀的宅男。公會現有25人團隊一支，從3.3至今所有版本25人H模式當前版本皆全通。5.1版本25人團排名臺服第八，並轉服至世界之樹，5.3版本用25人模式拿下萊公首殺！\n\n        公會活動時間：開荒期間周四五六 周一二三(也就是除了周日都有活動)，farm期間周五周六周一周二(或者更少)，晚上7:40開組，8:00開打，12:00左右結束(平時有的時候早點，不到12點就結束，周五周六到12：00左右)。"
DBM_CORE_GUILDAD_FOOTER_GENERIC		= "|h|cff3588ff重點招募\n術士             鳥德             奶僧\n具體要求加QQ談   聯系QQ:313082736 注明wow和自己的職業|r|h"

DBM_CORE_SOUNDGRIL_NAME_YIKE		= "夏一可"
DBM_CORE_SOUNDGRIL_TEXT_YIKE		= "    夏一可，又名可可超人，女，真名不詳，《我叫MT》中法師和美屢的配音，魔獸世界知名解說，部落控。2009年進入西南科技大學。高三時因參加唱響艾澤拉斯而成名。"

DBM_CORE_SOUNDGRIL_NAME_YUN			= "芷小芸"
DBM_CORE_SOUNDGRIL_TEXT_YUN			= "    芷小芸，來自中國台灣省的魔獸世界美女玩家，現為台服世界之樹《黑手之鄉》公會人類死亡騎士。"

DBM_CORE_SOUNDGRIL_NAME_SST			= "Iceoven"
DBM_CORE_SOUNDGRIL_TEXT_SST			= "    All Voice generated via VoiceRss TTS (Text To Speech), API by Iceoven (Worgen Mage from Ancient Ones @ US-Dath'Remar)."