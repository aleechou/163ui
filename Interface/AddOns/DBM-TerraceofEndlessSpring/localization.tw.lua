if GetLocale() ~= "zhTW" then return end
local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "小怪處理 - %s組",
	specWarnYourGroup	= "快去打小怪! 到你了!",
	specWarnYourEnd		= ">>小怪結束<<",
	specWarnDDL 	= ">> 下一次 到你斷 <<",
	SpecWarnJSA		= "%s﹪ >>注意減傷<<",
})

L:SetOptionLocalization({
	warnGroupOrder		= "警告：小怪處理組",
	specWarnYourGroup	= "特殊警告：到你處理小怪",
	specWarnYourEnd		= "特殊警告：本輪處理小怪已經結束",
	RangeFrame			= "距離監視(8碼)：$spell:111850(智能)",
	HudMAP				= "高級定位監視(HUD)：$spell:111850的位置",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436),
	SoundDW				= "語音警告：$spell:117283的驅散",
	SoundSDQ			= "語音警告：$spell:117436的驅散",
	SoundWater			= "語音警告：$spell:117309時提示拉開BOSS(坦克)",
	SoundWOP			= "語音警告：重要技能",
	optDD4				= "使用四人打斷鏈(不選則前3人循環)",
	opthelpDD			= "語音警告：當$spell:118077出現時提示你幫忙打斷第一次$spell:118312",
	specWarnDDL 		= "特殊警告：下一次到你打斷",
	optDD				= "水王打斷鏈",
	nodd				= "我不打斷",
	DD1					= "打斷1",
	DD2					= "打斷2",
	DD3					= "打斷3",
	DD4					= "打斷4",
	optMob				= "選擇您的處理組編號",
	Mob1				= "小怪處理組1",
	Mob2				= "小怪處理組2",
	Mob3				= "小怪處理組3",
	Mob4				= "小怪處理組4",
	Mob5				= "小怪處理組5",
	noMob				= "不提示",
	optMobSet			= "小怪處理策略(支持4或5組循環,若跳組請用數字0填充)",
	warndr9				= "減傷提示：三階段水王90%血",
	warndr8				= "減傷提示：三階段水王80%血",
	warndr7				= "減傷提示：三階段水王70%血",
	warndr6				= "減傷提示：三階段水王60%血",
	warndr5				= "減傷提示：三階段水王50%血",
	warndr4				= "減傷提示：三階段水王40%血",
	warndr3				= "減傷提示：三階段水王30%血",
	warndr2				= "減傷提示：三階段水王20%血",
	warndr1				= "減傷提示：三階段水王10%血",
	SpecWarnJSA			= "特別警告：注意開減傷",
	helpdispset			= "輸入一個重點關注的團員,當其被點名閃電牢籠時會提示你幫忙驅散"
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetWarningLocalization({
	SpecWarnJSA				= ">>> 第%d波小怪  注意減傷 <<<"
})

L:SetOptionLocalization({
	SoundWOP					= "語音警告：重要技能",
	SoundGH						= "語音警告：$journal:6551刷新及計數",
	SoundHX						= "語音警告：為$spell:122752倒數",
	SoundMY						= "語音警告：為$spell:122770倒數(若開啟此項,建議關閉暗影之息倒數)",
	WarnJK						= "語音警告：$spell:123011的預先警告",
	SpecWarnJSA					= "特別警告：注意開減傷",
	unseenjs1					= "減傷提示：$journal:6320 1",
	unseenjs2					= "減傷提示：$journal:6320 2",
	unseenjs3					= "減傷提示：$journal:6320 3",
	unseenjs4					= "減傷提示：$journal:6320 4",
	unseenjs5					= "減傷提示：$journal:6320 5",
	unseenjs6					= "減傷提示：$journal:6320 6",
	lod1						= "吃球額外提示：$journal:6551 1",
	lod2						= "吃球額外提示：$journal:6551 2",
	lod3						= "吃球額外提示：$journal:6551 3",
	lod4						= "吃球額外提示：$journal:6551 4",
	lod5						= "吃球額外提示：$journal:6551 5",
	lod6						= "吃球額外提示：$journal:6551 6",
	lod7						= "吃球額外提示：$journal:6551 7",
	lod8						= "吃球額外提示：$journal:6551 8",
	lod9						= "吃球額外提示：$journal:6551 9",
	lod10						= "吃球額外提示：$journal:6551 10",
	lod11						= "吃球額外提示：$journal:6551 11",
	HudMAP						= "高級定位監視(HUD)：$spell:122770的位置(僅10人)",
	optDS						= "\"恐怖陰影\"疊加幾層時，開始報警",
	six							= "6層",
	nine						= "9層",
	twelve						= "12層",
	fifteen						= "15層",
	none						= "不報警",
	optTS						= "神牧天使警告",
	TS1							= "第一次火息",
	TS2							= "第二次火息",
	TS3							= "第三次火息",
	noms						= "不提示",
})

L:SetMiscLocalization{
	Victory	= "謝謝你，陌生人。我重獲自由了。"
}


-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s 結束",
	SpecWarnJSA				= ">>> 注意減傷 <<<",
	warnHideProgress		= "擊中：%s，傷害：%s，時間：%s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "下一次特殊技能(%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "警告：當$spell:123244結束時",
	warnHideProgress		= "當$spell:123244結束後顯示統計",
	timerSpecialCD			= "計時器：下一次特殊技能",
	HudMAP					= "高級定位監視(HUD)：超過5層的$spell:123705攜帶者",
	InfoFrame				= "資訊框：首領的$spell:123712",
	SpecWarnJSA				= "特殊警告：注意減傷",
	unseenjs1				= "減傷提示:滾開1",
	unseenjs2				= "減傷提示:滾開2",
	unseenjs3				= "減傷提示:滾開3",
	unseenjs4				= "減傷提示:滾開4",
	unseenjs5				= "減傷提示:滾開5",
	SoundWOP				= "語音警告：重要技能",
	SetIconOnGuardfix		= "為$journal:6224設置團隊標記",
	RangeFrame				= "距離監視(3碼)：$spell:123121(與坦克距離)",
	GWHealthFrame			= "生命監視：移除$spell:123461還需要的傷害"
})

L:SetMiscLocalization{
	Victory	= "我...啊..喔!我曾經...?我是不是...?這一切...都太...模糊了。"--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	specWarnyinmo		= "隱沒 > %d <",
	specWarnfuxian		= "浮現! 畏懼之子 %d - %d",
	specWarnzyg			= "光之勇士 (>%s< → 你)",
	specWarnweisuo		= "恐懼畏縮 > %d <",
	specWarningpreHud	= "恐懼畏縮 即將來臨",
	MoveWarningLeft		= "← ← 向左一格",
	MoveWarningRight	= "向右一格 → →",
	MoveWarningBack		= "→ → 回原位 ← ←"
})

L:SetTimerLocalization({
	timerSpecialCD			= "下一次P2特殊技能",
	timerSpoHudCD			= "下一次 恐懼畏縮 或 水魄",
	timerSpoStrCD			= "下一次 水魄 或 嚴厲襲擊",
	timerHudStrCD			= "下一次 恐懼畏縮 或 嚴厲襲擊"
})

L:SetOptionLocalization({
	SoundDD				= "語音警告：$spell:131996",
	SoundWOP			= "語音警告：重要技能",
	InfoFrameTankMode	= "資訊框顯示首領攻擊計數器取代$spell:120629",
	RangeFrame			= "距離監視（2碼）：$spell:119519",
	pscount				= "語音警告：為恐怖噴散報數",
	HudMAP				= "高級定位監視(HUD)：$spell:120519",
	InfoFrame			= "資訊框：$spell:120629和$journal:6107數量",
	timerSpecialCD		= "計時器：下一次P2特殊技能",
	specWarnyinmo		= "特殊警告：$spell:120455",
	specWarnfuxian		= "特殊警告：$spell:120458",
	specWarnweisuo		= "特殊警告：$spell:120629",
	specWarnzyg			= "特殊警告：$spell:120268",
	specWarningpreHud	= "特殊警告：即將$spell:120629",
	MoveWarningLeft		= "特殊警告：向左一格",
	MoveWarningRight	= "特殊警告：向右一格",
	MoveWarningBack		= "特殊警告：回原位",
	ShaAssist			= "特殊功能：啟用恐怖噴散方向指示圖(輸入/sha可進行細節調整)",
	ShaStarMode			= "恐怖噴散指示使用星辰跑位模式(硬吃一擊以減少跑位)",
	timerSpoHudCD		= "計時器：下一次$spell:120629或$spell:120519",
	timerSpoStrCD		= "計時器：下一次$spell:120519或$spell:120672",
	timerHudStrCD		= "計時器：下一次$spell:120629或$spell:120672",
	SoundWSCOUNT		= "語音警告：為$spell:120629播放1~4循環的計數語音",
	unseenjs1			= "減傷提示：$spell:120629 1/4",
	unseenjs2			= "減傷提示：$spell:120629 2/4",
	unseenjs3			= "減傷提示：$spell:120629 3/4",
	unseenjs4			= "減傷提示：$spell:120629 4/4",
	SetIconOnWS			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(120629)
})

L:SetMiscLocalization({
	sanlian				= "三連",
	liulian				= "六連"
})