if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	SoundPZ					= "語音警告：当$spell:117878叠加超过三层时提示注意停手",
	InfoFrame				= "信息框：显示击杀和净化的软泥怪数量",
	dr						= "减伤提示[警报会在第一个软泥怪撞击到本体时提示]",
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
	kill					= "击杀",
	clean					= "净化",
	Victory					= "啊，你成功了。泉水再一次变得纯净了！"
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
	SoundWOP				= "语音警告：重要技能",
	SoundBD					= "语音警告：驱散$spell:143434",
	dr1						= "减伤提示：$spell:143491 1/4",
	dr2						= "减伤提示：$spell:143491 2/4",
	dr3						= "减伤提示：$spell:143491 3/4",
	dr4						= "减伤提示：$spell:143491 4/4",
	BaneGridCount			= "特殊：为$spell:143434啟用GRID编号支持(提示位置等更多相关选项请在GRID中设置。扩散出现的状态不会显示编号)",
	optOC					= "当苦痛印记叠加多少层时提示传递",
	imm						= "立刻提示",
	five					= "5层",
	ten						= "10层",
	fift					= "15层",
	twty					= "20层",
	none					= "从不提示",
})

L:SetMiscLocalization({
	DBM_GridBaneCount		= "DBM编号-暗言术:蛊",
	BaneRaidFrameCount		= "编号顺序使用暴雪团队框架的排序",
	optBaneGridCount		= "闪动显示编号:",
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetWarningLocalization({
	specWarnTestIn			= "队友入场：%s",
	specWarnTestOut			= "队友出场：%s"
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	InfoFrame				= "信息框：$journal:8252",
	InfoFrame2				= "信息框：$spell:144452中的队友",
	specWarnTestIn			= "特别警告：你监视的队友入场",
	specWarnTestOut			= "特别警告：你监视的队友出场",
	prevplayer				= "输入一个队友名，在他入场和离场时都会通知你"
})

L:SetMiscLocalization({
	wasteOfTime				= "很好，我会制造一个空间来隔离你们的腐蚀。"
})
------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	SoundQS					= "额外驱散提示：当你带有$spell:144359时技能一旦冷却即提示驱散",
	HudMAPBP				= "高级定位监视(HUD)：$spell:144911",
	HudMAPCP				= "高级定位监视(HUD)：$spell:144574",
	HudMAPAoP				= "高級定位監視(HUD)：$spell:146817",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(5, 146817),
	SetIconOnMark			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144351),
	InfoFrame				= "信息框： $journal:8255",
	dr1						= "减伤提示：$spell:144400 1/3",
	dr2						= "减伤提示：$spell:144400 2/3",
	dr3						= "减伤提示：$spell:144400 3/3",
})

L:SetMiscLocalization({
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
	timerAddsCD		= "下一波小怪",
	timerTowerCD	= "下一个塔楼攻破"
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",	
	SoundZQ					= "语音警告：$spell:147328",
	SoundTT					= "语音警告：$spell:146753",
	timerAddsCD				= "计时器：下一波小怪",
	timerTowerCD			= "计时器：下一个塔楼攻破",
	FixateIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(147068),
	InfoFrame				= "信息框：下一波$journal:8427",
	flamecount				= "减伤提示：第二阶段时第几个火球提示减伤"
})

L:SetMiscLocalization({
	newForces1	= "Here they come!",--Jaina's line, horde may not be same
	newForces2	= "龙喉氏族，前进！",
	newForces3	= "为了地狱咆哮！",
	newForces4	= "下一队，前进！",
	tower		= "塔楼的大门被攻破了！",--The door barring the South/North Tower has been breached!
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
	SoundWOP				= "语音警告：重要技能",
	timerAssaultModeCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej8177"),
	timerSiegeModeCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej8178"),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(6, 144154),
	dr						= "减伤提示：$spell:144485 [此顺序每次强攻阶段都会重置]",
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
	SoundWOP				= "语音警告：重要技能",
	dr						= "减伤提示[警报会在撞击前4秒提示]",
	dr1						= "$spell:143973 1/6",
	dr2						= "$spell:143973 2/6",
	dr3						= "$spell:143973 3/6",
	dr4						= "$spell:143973 4/6",
	dr5						= "$spell:143973 5/6",
	dr6						= "$spell:143973 6/6",
	SetIconOnToxicMists		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144089),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(4, 143990)
})

L:SetMiscLocalization({
	PrisonYell		= "%s 的囚牢即将结束 (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "%d秒后 防御姿态"
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	SoundTT					= "语音警告：$spell:143474",
	InfoFrame				= "信息框：怒气监视器",
	warnDefensiveStanceSoon			= "预先警告：$spell:143593 (5秒前)"
})

L:SetMiscLocalization({
	newForces1				= "战士们，快过来！",
	newForces2				= "守住大门！",
	newForces3				= "Rally the forces!",
	newForces4				= "库卡隆，支援我！",
	newForces5				= "下一队，冲上去！",
	allForces				= "All Kor'kron... under my command... kill them... NOW!"
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	HudMAP					= "高级定位监视(HUD)：$spell:142913",
})

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	Filterarea				= "其他：使用更严格的方式判定所在区域"
})

L:SetMiscLocalization({
	Module1					= "1号模组准备完毕，可以系统重置。",
	Victory					= "2号模组准备完毕，可以系统重置。"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetWarningLocalization({
	specWarnDevotion		= "%s 开启了虔诚光环"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	SoundPX					= "倒计时：$spell:143343",
	specWarnDevotion		= "特殊警告：$spell:31821",
	RangeFrame				= "距离监视(10码)：动态",
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
	SoundWOP				= "语音警告：重要技能",
	SoundFMD				= "语音警告：$spell:144208前提示伐木机快打",
	InfoFrame				= "信息框：$journal:8202",
	optCS					= "传送带启动提示",
	CSA						= "传送带一组",
	CSB						= "传送带二组",
	none					= "我不去",
	optCSKILL1				= "击杀提示：第1轮",
	optCSKILL2				= "第2轮",
	optCSKILL3				= "第3轮",
	optCSKILL4				= "第4轮",
	optCSKILL5				= "第5轮",
	optCSKILL6				= "第6轮",
	optCSKILL7				= "第7轮",
	optCSKILL8				= "第8轮",
	optCSKILL9				= "第9轮",
	optCSKILL10				= "第10轮",
	optCSKILL11				= "第11轮",
	optCSKILL12				= "第12轮",
	optCSKILL13				= "第13轮",
	optCSKILL14				= "第14轮",
	optCSKILL15				= "第15轮",
	killdl					= "地雷",
	killfd					= "飞弹",
	killjg					= "激光",
	killdc					= "电磁铁",
	killnone				= "未设置"
})

L:SetMiscLocalization({
	newWeapons				= "未完成的武器从装配流水线上传送出来了。",
	newShredder				= "一台自动伐木机正在靠近！"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "易伤：%s - 避免接怪!",
	specWarnCriteriaLinked			= "连线 - %s!"
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	InfoFrame				= "信息框：英杰技能提示",
	HudMAP					= "高级定位监视(HUD)：$spell:142726 / $spell:142727",
	HudMAPMZ				= "高级定位监视(HUD)：$journal:8073",
	warnToxicCatalyst			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej8036"),
	specWarnToxicInjection			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(142528),
	specWarnToxicCatalyst			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format("ej8036"),
	specWarnActivatedVulnerable		= "特别警告：新出现的英杰对你有易伤",
	specWarnCriteriaLinked			= "特别警告：你是$spell:144095连线的目标",
	SetIconOnAim				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(142948),
	yellToxicCatalyst			= DBM_CORE_AUTO_YELL_OPTION_TEXT:format("ej8036"),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("6/5")
})

L:SetMiscLocalization({
	one						= "一",
	two						= "二",
	three					= "三",
	four					= "四",
	five					= "五",
	BossSpellInfo			= "首領技能分析",
	LF						= "掠风者",
	LFspell					= "凿击/旋风",
	DX						= "毒心者",
	DXspell					= "毒素技能",
	CZ						= "操纵者",
	CZspell					= "吃人虫",
	ZZ						= "至尊者",
	ZZspell					= "盾击/琥珀",
	MC						= "明澈者",
	MCspell					= "火线",
	BS						= "暴食蝗",
	BSspell					= "黄水/冲锋",
	MX						= "觅血者",
	MXspell					= "软泥",
	QG						= "切割者",
	QGspell					= "寄生虫/蝎子",
	CQ						= "虫群卫士",
	CQspell					= "分担音波",
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	SoundGC					= "语音警告：$journal:8298相关提示",
	optDD					= "先祖治疗链打断提示",
	alldd					= "总是提示(如果你选他為目标或焦点)",
	DD1						= "单数提示",
	DD2						= "双数提示",
	nodd					= "不提示"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"奥格瑞玛杂兵"
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
})
