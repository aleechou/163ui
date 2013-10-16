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
	SoundPZD				= "語音警告：当$spell:143579叠加超过三层时提示注意停手",
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
	InfoFrame				= "信息框：首领血量监视",
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
	optDD					= "武僧分身打断提示",
	alldd					= "总是提示(如果你选他為目标或焦点)",
	DD1						= "打断1",
	DD2						= "打断2",
	DD3						= "打断3",
	nodd					= "不提示",
	SetIconOnStrike			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(143962),
	RangeFrame			= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(5, 143423)--For heroic. Need to chage smart range frame?
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
	nameset					= "诺鲁什内场监视",
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
	nameset		= "迦拉卡斯",
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
	SoundTL					= "语音警告：$spell:144330的十秒预警(即使不是你的$spell:144330也会报警，这是一个為治疗者製作的提示)",
	dr						= "减伤提示[警报会在撞击前4秒提示]",
	dr1						= "$spell:143973 1/6",
	dr2						= "$spell:143973 2/6",
	dr3						= "$spell:143973 3/6",
	dr4						= "$spell:143973 4/6",
	dr5						= "$spell:143973 5/6",
	dr6						= "$spell:143973 6/6",
	SoundEle				= "特殊：啟用[元素萨满]技能提示",
	SoundEnh				= "特殊：啟用[增强萨满]技能提示",
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
	SoundDS					= "语音警告：驱散$spell:143475",
	SoundIFS				= "语音警告：打断$journal:7923",
	SoundISM				= "语音警告：打断$journal:7925",
	InfoFrame				= "信息框：怒气监视器",
	SetIconOnAdds			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej7920"),
	warnDefensiveStanceSoon			= "预先警告：$spell:143593 (5秒前)"
})

L:SetMiscLocalization({
	newForces1				= "战士们，快过来！",
	newForces2				= "守住大门！",
	newForces3				= "重新整队！",
	newForces4				= "库卡隆，支援我！",
	newForces5				= "下一队，冲上去！",
	allForces				= "库卡隆，听我的命令，杀了他们！",
	Handslipped1			= "不好意思，手滑打了下BOSS",
	Handslipped2			= "哎呀，手又滑了",
	Handslipped3			= "难道我这只手是肥皂做的?",
	Handslipped4			= "请斩断我这只罪恶之手吧！我居然完全忘了要停手！"
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	Malhelper				= "===特殊：开啟亚煞极之息辅助图示 (/mal)===",
	MalhelperSend			= "===辅助图示：启用手动修正模式===",
	LTshow					= "长效特别警告：显示护盾吸收量",
	dr						= "减伤提示：$spell:142986 (爆炸前提示)",
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
	HudMAP					= "高级定位监视(HUD)：$spell:142913",
	SetIconOnDisplacedEnergy= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(142913),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("8/5")
})

MHExRTL.panelbossmodsmalkorokdanger ="! 危险 !"
MHExRTL.sendnote ="开啟手动修改图示，左键选择，右键取消，你的修改会被同步给全团，请谨慎使用！！！"

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	LTZD					= "长效特别警告：你中了$spell:145987",
	RangeFrame	= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(10, 145987),
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

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	SoundPX					= "倒计时：$spell:143343",
	specWarnDevotion		= "特殊警告：$spell:31821",
	LTRange					= "长效特别警告：P1$spell:143343层数/P2首领距离",
	optDD					= "毒血驱散链",
	DD1						= "驱散1",
	DD2						= "驱散2",
	DD3						= "驱散3",
	nodd					= "我不驱散",
	RangeFrame				= "距离监视(10码)：动态",
	dr						= "减伤提示：$spell:143343 (此顺序每次转阶段都会重置)",
	dr1						= "$spell:143343 1",
	dr2						= "$spell:143343 2",
	dr3						= "$spell:143343 3",
	dr4						= "$spell:143343 4",
	dr5						= "$spell:143343 5",
	dr6						= "$spell:143343 6",
	dr7						= "$spell:143343 7",
	dr8						= "$spell:143343 8",
	dr9						= "$spell:143343 9",
	dr10					= "$spell:143343 10",
	dr11					= "$spell:143343 11",
	dr12					= "$spell:143343 12",
	dr13					= "$spell:143343 13",
	dr14					= "$spell:143343 14",
	dr15					= "$spell:143343 15",
	dr16					= "$spell:143343 16",
	dr17					= "$spell:143343 17",
	dr18					= "$spell:143343 18",
	dr19					= "$spell:143343 19",
	dr20					= "$spell:143343 20",
	dr21					= "$spell:143343 21",
	dr22					= "$spell:143343 22",
	dr23					= "$spell:143343 23",
	dr24					= "$spell:143343 24",
	dr25					= "$spell:143343 25",
	dr26					= "$spell:143343 26",
	dr27					= "$spell:143343 27",
	dr28					= "$spell:143343 28",
	dr29					= "$spell:143343 29",
	dr30					= "$spell:143343 30",
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
	SoundDL					= "语音警告：地雷清理提示",
	LTFD					= "长效特别警告：显示$spell:143266和$spell:143828震动图标提示",
	SoundCZ					= "语音警告：伐木机$spell:145444AOE预警",
	InfoFrame				= "信息框：$journal:8202",
	optCS					= "传送带启动提示",
	CSA						= "传送带一组",
	CSB						= "传送带二组",
	CSALL					= "总是提示",
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
	nodd					= "不提示",
	SetIconOnShaman			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej8294"),
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
