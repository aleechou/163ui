if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",	
	SoundPZD				= "語音警告：當$spell:143579疊加超過三層時提示注意停手",
	InfoFrame				= "資訊框：顯示擊殺和淨化的軟泥怪數量",
	dr						= "減傷提示[警報會在第一個軟泥怪撞擊到本體時提示]",
	dr1						= "$spell:143469 1",
	dr2						= "$spell:143469 2",
	dr3						= "$spell:143469 3",
	dr4						= "$spell:143469 4",
	dr5						= "$spell:143469 5",
	dr6						= "$spell:143469 6",
	dr7						= "$spell:143469 7",
	dr8						= "$spell:143469 8",
})

L:SetMiscLocalization({
	kill					= "擊殺",
	clean					= "淨化",
	Victory			= "啊，你成功了!水又再次純淨了。"
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	InfoFrame				= "資訊框：首領血量監視",
	SoundBD					= "語音警告：驅散$spell:143434",
	dr1						= "減傷提示：$spell:143491 1/4",
	dr2						= "減傷提示：$spell:143491 2/4",
	dr3						= "減傷提示：$spell:143491 3/4",
	dr4						= "減傷提示：$spell:143491 4/4",
	BaneGridCount			= "特殊：爲$spell:143434啟用GRID編號支持(提示位置等更多相關選項請在GRID中設置。擴散出現的状态不會顯示編號)",
	optOC					= "當苦痛印記疊加多少層時提示傳遞",
	imm						= "立刻提示",
	five					= "5層",
	ten						= "10層",
	fift					= "15層",
	twty					= "20層",
	none					= "從不提示",
	optDD					= "武僧分身打斷提示",
	alldd					= "總是提示(如果你選他為目標或焦點)",
	DD1						= "打斷1",
	DD2						= "打斷2",
	DD3						= "打斷3",
	nodd					= "不提示",
	SetIconOnStrike			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(143962),
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(5, 143423)--For heroic. Need to chage smart range frame?
})

L:SetMiscLocalization({
	DBM_GridBaneCount		= "DBM編號-暗言術:蠱",
	BaneRaidFrameCount		= "編號順序使用暴雪團隊框架的排序",
	optBaneGridCount		= "閃動顯示編號:",
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetWarningLocalization({
	specWarnTestIn			= "隊友入場：%s",
	specWarnTestOut			= "隊友出場：%s"
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	InfoFrame				= "資訊框：$journal:8252",
	InfoFrame2				= "資訊框：$spell:144452中的隊友",
	specWarnTestIn			= "特別警告：你監視的隊友入場",
	specWarnTestOut			= "特別警告：你監視的隊友出場",
	prevplayer				= "輸入一個隊友名，在他入場和離場時都會通知你"
})

L:SetMiscLocalization({
	wasteOfTime			= "很好，我會創造一個力場隔離你們的腐化。"
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	SoundQS					= "額外驅散提示：當你帶有$spell:144359時技能一旦冷卻即提示驅散",
	HudMAPBP				= "高級定位監視(HUD)：$spell:144911",
	HudMAPCP				= "高級定位監視(HUD)：$spell:144574",
	HudMAPAoP				= "高級定位監視(HUD)：$spell:146817",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(5, 146817),
	SetIconOnMark			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144351),
	InfoFrame				= "資訊框：$journal:8255",
	dr1						= "減傷提示：$spell:144400 1/3",
	dr2						= "減傷提示：$spell:144400 2/3",
	dr3						= "減傷提示：$spell:144400 3/3",
})

L:SetMiscLocalization({
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
	timerAddsCD		= "下一波小兵",
	timerTowerCD	= "下一個塔樓攻破"
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	SoundZQ					= "語音警告：$spell:147328",
	SoundTT					= "語音警告：$spell:146753",
	timerAddsCD				= "計時器：下一波小怪",
	timerTowerCD			= "計時器：下一個塔樓攻破",
	FixateIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(147068),
	InfoFrame				= "資訊框：下一波$journal:8427",
	flamecount				= "減傷提示：第二階段時第幾個火球提示減傷"
})

L:SetMiscLocalization({
	Pull		= "龍喉氏族，奪回碼頭，把他們推進海裡!以地獄吼及正統部落之名!",
	newForces1	= "他們來了!",
	newForces1H	= "趕快把她弄下來，讓我用手掐死她。",
	newForces2	= "龍喉氏族，前進!",
	newForces3	= "為了地獄吼!",
	newForces4	= "下一隊，前進!",
	tower		= "的門已經遭到破壞!"
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	timerAssaultModeCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej8177"),
	timerSiegeModeCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej8178"),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(6, 144154),
	dr						= "減傷提示：$spell:144485 [此順序每次攻城階段都會重置]",
	dr1						= "$spell:144485 1",
	dr2						= "$spell:144485 2",
	dr3						= "$spell:144485 3",
	dr4						= "$spell:144485 4",
	dr5						= "$spell:144485 5",
	dr6						= "$spell:144485 6"
})

L:SetMiscLocalization({
})

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	dr						= "減傷提示[警報會在撞擊前4秒提示]",
	dr1						= "$spell:143973 1/6",
	dr2						= "$spell:143973 2/6",
	dr3						= "$spell:143973 3/6",
	dr4						= "$spell:143973 4/6",
	dr5						= "$spell:143973 5/6",
	dr6						= "$spell:143973 6/6",
	SoundEle				= "特殊：啟用[元素薩滿]技能提示",
	SoundEnh				= "特殊：啟用[增強薩滿]技能提示",
	SetIconOnToxicMists		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144089),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(4, 143990)
})

L:SetMiscLocalization({
	PrisonYell		= "%s 的囚牢即將結束 (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "%d秒後 防禦姿態"
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	SoundDS					= "語音警告：驅散$spell:143475",
	SoundIFS				= "語音警告：打斷$journal:7923",
	SoundISM				= "語音警告：打斷$journal:7925",
	InfoFrame				= "資訊框：怒氣監視器",
	SetIconOnAdds			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej7920"),
	warnDefensiveStanceSoon			= "預先警告：$spell:143593 (5秒前)"
})

L:SetMiscLocalization({
	newForces1				= "戰士們，快點過來!",
	newForces2				= "守住大門!",
	newForces3				= "重整部隊!",
	newForces4				= "柯爾克隆，來我身邊!",
	newForces5				= "下一隊，來前線!",
	allForces				= "所有科爾克隆...聽我號令...殺死他們!",
	Handslipped1			= "不好意思，手滑打了下BOSS",
	Handslipped2			= "哎呀，手又滑了",
	Handslipped3			= "難道我這隻手是肥皂做的?",
	Handslipped4			= "請斬斷我這隻罪惡之手吧！我居然完全忘了要停手！"
})


-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	Malhelper				= "===特殊：開啟亞煞極之息輔助圖示 (/mal)===",
	MalhelperSend			= "===輔助圖示：啟用手動修正模式===",
	dr						= "減傷提示：$spell:142986 (爆炸前提示)",
	dr1						= "$spell:142986 1",
	dr2						= "$spell:142986 2",
	dr3						= "$spell:142986 3",
	dr4						= "$spell:142986 4",
	dr5						= "$spell:142986 5",
	dr6						= "$spell:142986 6",
	dr7						= "$spell:142986 7",
	dr8						= "$spell:142986 8",
	dr9						= "$spell:142986 9",
	dr10					= "$spell:142986 10",
	dr11					= "$spell:142986 11",
	dr12					= "$spell:142986 12",
	HudMAP					= "高級定位監視(HUD)：$spell:142913",
	SetIconOnDisplacedEnergy= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(142913),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("8/5")
})

MHExRTL.panelbossmodsmalkorokdanger ="! 危險 !"
MHExRTL.sendnote ="開啟手動修改圖示，左鍵選擇，右鍵取消，你的修改會被同步給全團，請謹慎使用！！！"

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	RangeFrame	= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 145987),
	Filterarea				= "其他：使用更嚴格的方式判定所在區域"
})

L:SetMiscLocalization({
	Module1 = "模組一號已準備好系統重置。",
	Victory	= "模組二號已準備好系統重置。"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetWarningLocalization({
	specWarnDevotion		= "%s 開啓了虔誠光環"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	SoundPX					= "倒计时：$spell:143343",
	specWarnDevotion		= "特別警告：$spell:31821",
	RangeFrame				= "距離監視(10碼)：動態",
	FixateIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(143445)
})

L:SetMiscLocalization({
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	SoundFMD				= "語音警告：$spell:144208前提示伐木機快打",
	InfoFrame				= "資訊框：$journal:8202",
	optCS					= "傳送帶啟動提示",
	CSA						= "傳送帶一組",
	CSB						= "傳送帶二組",
	none					= "我不去",
	optCSKILL1				= "擊殺提示：第1輪",
	optCSKILL2				= "第2輪",
	optCSKILL3				= "第3輪",
	optCSKILL4				= "第4輪",
	optCSKILL5				= "第5輪",
	optCSKILL6				= "第6輪",
	optCSKILL7				= "第7輪",
	optCSKILL8				= "第8輪",
	optCSKILL9				= "第9輪",
	optCSKILL10				= "第10輪",
	optCSKILL11				= "第11輪",
	optCSKILL12				= "第12輪",
	optCSKILL13				= "第13輪",
	optCSKILL14				= "第14輪",
	optCSKILL15				= "第15輪",
	killdl					= "地雷",
	killfd					= "飛彈",
	killjg					= "激光",
	killdc					= "電磁鐵",
	killnone				= "未設置"
})

L:SetMiscLocalization({
	newWeapons				= "尚未完成的武器開始從生產線上掉落。",
	newShredder				= "有個自動化伐木機靠近了!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "易傷：%s - 避免接怪!",
	specWarnCriteriaLinked			= "連線 - %s!"
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	InfoFrame				= "資訊框：英傑技能提示",
	HudMAP					= "高級定位監視(HUD)：$spell:142726 / $spell:142727",
	HudMAPMZ				= "高級定位監視(HUD)：$journal:8073",
	warnToxicCatalyst			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej8036"),
	specWarnToxicInjection			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(142528),
	specWarnToxicCatalyst			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format("ej8036"),
	specWarnActivatedVulnerable		= "特別警告：新激活的英傑對你有易傷",
	specWarnCriteriaLinked			= "特别警告：你是$spell:144095連線的目標",
	SetIconOnAim				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(142948),
	yellToxicCatalyst			= DBM_CORE_AUTO_YELL_OPTION_TEXT:format("ej8036"),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("6/5")
})

L:SetMiscLocalization({
	one					= "一",
	two					= "二",
	three				= "三",
	four				= "四",
	five				= "五",
	BossSpellInfo		= "首領技能分析",
	LF					= "奪風者",
	LFspell				= "鑿擊/躲紅圈",
	DX					= "毒心者",
	DXspell				= "毒素技能",
	CZ					= "操縱者",
	CZspell				= "吃人蟲連線",
	ZZ					= "至高者",
	ZZspell				= "盾擊/琥珀",
	MC					= "思緒者",
	MCspell				= "火線",
	BS					= "暴虐蝗",
	BSspell				= "丟黃水/衝鋒",
	MX					= "覓血者",
	MXspell				= "打軟泥",
	QG					= "開膛手",
	QGspell				= "寄生蟲/蠍子",
	CQ					= "蟲群衛士",
	CQspell				= "分擔音波",
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	SoundGC					= "語音警告：$journal:8298相關提示",
	optDD					= "先祖治療鏈打斷提示",
	alldd					= "總是提示(如果你選他為目標或焦點)",
	DD1						= "單數提示",
	DD2						= "雙數提示",
	nodd					= "不提示",
	SetIconOnShaman			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej8294"),
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"奧格瑪雜兵"
})

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
})
