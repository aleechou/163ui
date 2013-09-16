if GetLocale() ~= "zhTW" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "七秒後：%s",
	specWarnMySD				= "你拉的王點了全團石化",
	specWarnBreakJasperChains	= "拉斷晶紅鎖鏈!"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能",
	InfoFrame			= "信息框：超載能量監視器",
	AInfoFrame			= "信息框：簡化超載監視器(不要和上邊重選)",
	SpecWarnOverloadSoon	= "特殊警報：即將超載",
	specWarnMySD		= "特殊警報：你拉的王點了石化時(坦克)",
	specWarnBreakJasperChains	= "特殊警報：當安全時拉斷$spell:130395",
	ArrowOnJasperChains			= "DBM箭頭：當你獲得$spell:130395時"
})

L:SetMiscLocalization({
	Overload	= "%s要超載了!",
	SDNOT		= "[未石化]",
	SDBLUE		= "[|cFFFFA500石化|r:|cFF0080FF藍|r]",
	SDGREEN		= "[|cFFFFA500石化|r:|cFF088A08綠|r]",
	SDRED		= "[|cFFFFA500石化|r:|cFFFF0404紅|r]",
	SDPURPLE	= "[|cFFFFA500石化|r:|cFF9932CD紫|r]",
	NEXTR		= "|cFFFFA500下次超載|r:|cFFFF0404紅色|r",
	NEXTG		= "|cFFFFA500下次超載|r:|cFF088A08綠色|r",
	NEXTB		= "|cFFFFA500下次超載|r:|cFF0080FF藍色|r",
	NEXTP		= "|cFFFFA500下次超載|r:|cFF9932CD紫色|r"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "第 %d 階段",
	specWarnDrawFlame = "牽引火焰 > %d <",
	specWarnArcaneVelocity = "秘法動能 > %d <",
	specWarnEpicenter = "遠離地震 > %d <",
	specWarnSiphoningShield = "遠離盾牌 > %d <"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能",
	InfoFrame			= "資訊框：坦克減益狀態層數監視",
	HudMAP				= "高級定位監視(HUD)：$spell:116784的位置",
	HudMAP2				= "高級定位監視(HUD)：$spell:116417",
	HudMAP3				= "高級定位監視(HUD)：$spell:115817",
	WarnPhase			= "警告：階段轉換",
	specWarnDrawFlame 	= "特殊警告：$spell:116711",
	specWarnArcaneVelocity 	= "特殊警告：$spell:116364",
	specWarnEpicenter 	= "特殊警告：$spell:116018",
	specWarnSiphoningShield = "特殊警告：$spell:117203",
	RangeFrame	= "距離監視：祕法階段(8碼)",
	SetIconOnWS	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116784),
	SetIconOnAR	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116417)
})

L:SetMiscLocalization({
	Fire		= "噢，至高的神啊!藉由我來融化他們的血肉吧!",
	Arcane		= "噢，上古的賢者!賜予我秘法的智慧!",
	Nature		= "噢，偉大的靈魂!賜予我大地之力!",--I did not log this one, text is probably not right
	Shadow		= "英雄之靈!以盾護我之身!"
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetWarningLocalization({
	specWarninTT 	= ">> 注意進內場 <<",
	SpecWarnjs		= "<%s> → %s"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能",
	SoundTT				= "語音警告：$spell:116174",
	countTT				= "\"靈魂圖騰\"循環計數語音",
	countnone			= "不播放計數語音",
	count3				= "按1~3循環計數",
	count4				= "按1~4循環計數",
	specWarninTT		= "特殊警告：當需要進入內場時顯示文字警告",
	GoTotemAdmin		= "主控：分配跨界(僅英雄模式有效,僅能由隊長開啟)",
	GoTotemClient		= "被控：接收跨界警告(僅英雄模式有效,需存在主控)",
	optAdminTT			= "主控選項：分配幾名DPS入場(此項不包括治療,總是分配一名治療入場)",
	send1				= "一人",
	send2				= "二人(10人模式推薦)",
	send3				= "三人(25人模式推薦)",
	send4				= "四人",
	IgnoreTT1			= "主控選項：忽略分配圖騰1",
	IgnoreTT2			= "主控選項：忽略分配圖騰2",
	IgnoreTT3			= "主控選項：忽略分配圖騰3",
	IgnoreTT4			= "主控選項：忽略分配圖騰4",
	IgnoreTT5			= "主控選項：忽略分配圖騰5",
	IgnoreTT6			= "主控選項：忽略分配圖騰6",
	IgnoreTT7			= "主控選項：忽略分配圖騰7",
	IgnoreTT8			= "主控選項：忽略分配圖騰8",
	IgnoreTT9			= "主控選項：忽略分配圖騰9",
	IgnoreTT10			= "主控選項：忽略分配圖騰10",
	IgnoreTT11			= "主控選項：忽略分配圖騰11",
	IgnoreTT12			= "主控選項：忽略分配圖騰12",
	IgnoreTT13			= "主控選項：忽略分配圖騰13",
	IgnoreTT14			= "主控選項：忽略分配圖騰14",
	IgnoreTT15			= "主控選項：忽略分配圖騰15",
	IgnoreTT16			= "主控選項：忽略分配圖騰16",
	IgnoreTT17			= "主控選項：忽略分配圖騰17",
	SpecWarnjs			= "特殊警告：減傷鏈",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151),
	InfoFrame			= "資訊框：$spell:116161的玩家 (標注\"治療\"需團員選擇角色類型)",
	optjs				= "<黑手之城>@世界之樹 公會專用減傷提示模塊",
	non					= "老子誰的減傷都不看",
	druid				= "乳德的減傷",
	priest				= "戒律的減傷",
	paltank				= "坦騎的減傷",
	palheal				= "乳騎的減傷",
	warrior1			= "戰神A的減傷",
	warrior2			= "戰神B的減傷",
	monktank			= "坦僧的減傷",
	paldps1				= "懲戒A的減傷",
	paldps2				= "懲戒B的減傷",
	optindex			= "被控選項：DPS入場優先級(不影響治療,總是分配魔法最低治療入場)",
	noidex				= "我不想進",
	index1				= "序列1(最高優先級)",
	index2				= "序列2",
	index3				= "序列3",
	index4				= "序列4",
	index5				= "序列5",
	index6				= "序列6",
	index7				= "序列7",
	index8				= "序列8",
	index9				= "序列9"
})

L:SetMiscLocalization({
	Pull		= "受死吧，你們!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	specWarnDDL 	= ">> 下一次 到你斷 <<",
	specWarnQBH		= "下一刀殲滅 去背後!",
	specWarnQBHT	= "下一刀是殲滅!",
	specWarnDSoon	= "三秒後 >>護盾<<",
	DarknessSoon	= "黑暗護盾 %d秒"
})

L:SetOptionLocalization({
	RangeFrame			= "距離監視(8碼)",
	SoundWOP			= "語音警告：重要技能",
	SoundDSA			= "語音警告：為各種護盾提前預警",
	InfoFrame			= "資訊框：$spell:118303的目標",
	HudMAP				= "高級定位監視(HUD)：$spell:118047的位置",
	HudMAP2				= "高級定位監視(HUD)：$spell:118303的目標",
	DarknessSoon		= "黑暗護盾即將到來",
	SoundCT				= "語音警告：$spell:117833的打斷",
	optDD				= "近戰打斷鏈",
	nodd				= "我不打斷",
	DD1					= "打斷1",
	DD2					= "打斷2",
	DD3					= "打斷3",
	DD4					= "打斷4",
	optKZ				= "盜王控制鏈",
	noKZ				= "我不控制",
	KZ1					= "控制1",
	KZ2					= "控制2",
	specWarnDDL 		= "特殊警告：下一次到你打斷",
	specWarnQBH			= "特殊警告：下一刀殲滅",
	specWarnQBHT		= "特殊警告：下一刀是殲滅(坦克)",
	specWarnDSoon		= "特殊警告：護盾即將到來"
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "中場即將消失!",
	specWarnCharge				= "能量電荷 [%d] - 轉換目標",
	specwarnYB					= "本輪>>分擔異變<<!",
	specWarnProtector			= "星穹保衛者 [%d] - 轉換目標"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "中場消失!"
})

L:SetOptionLocalization({
	SoundWOP					= "語音警告：重要技能",
	SoundCC						= "語音警告：$spell:117949的驅散",
	SoundDD						= "語音警告：為消掉$spell:117878播放額外音效",
	optDBPull					= "語音警告：為正在坦$journal:6178的坦克播放$spell:117960警告",
	specWarnDespawnFloor		= "特殊警告：中場地板消失前",
	specWarnCharge				= "特殊警告：能量電荷",
	specWarnProtector			= "特殊警告：$journal:6178",
	specwarnYB					= "特殊警告：本輪需要分擔異變",
	timerDespawnFloor			= "計時器：中場地板消失",
	InfoFrame					= "資訊框：$spell:117878層數最高的5名團員",
	SetIconOnDestabilized		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(132226),
	optOC						= "\"超載\"疊加幾層時，開始報警(每三層報警一次)",
	six							= "6層",
	nine						= "9層",
	twelve						= "12層",
	fifteen						= "15層",
	none						= "不報警",
	optPos						= "DBM箭頭：\"能量電荷\"出現前指向\"至高天核\"(入口起逆時針)",
	nonepos						= "不顯示",
	posA 						= "1號位",
	posB 						= "2號位",
	posC 						= "3號位",
	posD						= "4號位",
	posE 						= "5號位",
	posF 						= "6號位",
	optYB						= "第一輪<異變>分擔",
	noYB						= "沒我事",
	YB1							= "第一次",
	YB2							= "第二次",
	YB3							= "第三次",
	YB4							= "第四次",
	YB5							= "第五次",
	optYBT						= "第二輪<異變>分擔",
	noYBT						= "沒我事",
	YBT1						= "第一次",
	YBT2						= "第二次",
	YBT3						= "第三次",
	YBT4						= "第四次",
	YBT5						= "第五次"
})

L:SetMiscLocalization({
	Floor				= "能量漩渦的能量正在降低!"
})
------------
-- Will of the Emperor --
------------
L= DBM:GetModLocalization(677)

L:SetWarningLocalization({
	specWarnBomb				= "小怪(%d) >> 爆破 <<",
	specWarnKZ					= "小怪(%d) >> 控制 <<",
})

L:SetOptionLocalization({
	InfoFrame			= "資訊框：$spell:116525的目標",
	ArrowOnCombo	= "為$journal:5673顯示DBM箭頭\n注:這是假設坦克在前方而其他人在後方",
	SoundWOP			= "語音警告：重要技能",
	SoundADD1A			= "預先語音警告：$spell:ej5678 (5秒前)",
	SoundADD1			= "語音警告：$spell:ej5678",
	SoundADD2A			= "預先語音警告：$spell:ej5676 (8秒前)",
	SoundADD2			= "語音警告：$spell:ej5676",
	SoundADD3A			= "預先語音警告：$spell:ej5677 (8秒前)",
	SoundADD3			= "語音警告：$spell:ej5677",
	ragebomb1			= "英雄模式：爆破第3組",
	ragebomb2			= "英雄模式：爆破第6組",
	ragebomb3			= "英雄模式：爆破第9組",
	ragebomb4			= "英雄模式：爆破第12組",
	ragebomb5			= "英雄模式：爆破第15組",
	specWarnBomb		= "特殊警告：本輪需要爆破小怪",
	specWarnKZ			= "特殊警告：本輪需要控制小怪",
	optKZ				= "輕甲兵控制鏈",
	kza					= "第一輪",
	kzb					= "第二輪",
	kzc					= "第三輪",
	nokz				= "我不控制",
	optBY				= "語音警告：僅提示此首領的毀滅連擊",
	tarfoc				= "當前目標和專注目標",
	Janxi				= "臻璽(左側傀儡)",
	Qinxi				= "秦璽(右側傀儡)",
	none				= "這個傢伙很懶,誰的提示都不想聽"
})

L:SetMiscLocalization({
	Pull		= "這台機器啟動了!到下一層去!",--Emote
	Rage		= "大帝之怒響徹群山。",--Yell
	Strength	= "帝王之力出現在壁龕裡!",--Emote
	Courage		= "帝王之勇出現在壁龕裡!",--Emote
	Boss		= "兩個泰坦魁儡出現在大壁龕裡!"--Emote
})

