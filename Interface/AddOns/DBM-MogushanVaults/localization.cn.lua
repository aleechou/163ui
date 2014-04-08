-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 1/4/2013

if GetLocale() ~= "zhCN" then return end
local L

------------
-- The Stone Guard --
------------
L= DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon	= "%s: 7秒后可施放",
	specWarnMySD				= "你拉的BOSS点了全团石化",
	specWarnBreakJasperChains	= "扯断红玉锁链！"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	InfoFrame			= "信息框：过载能量监视器",
	AInfoFrame			= "信息框：简化过载监视器(不要和上边重选)",
	specWarnMySD		= "特殊警报：当你拉的首領点了石化时(坦克)",
	SpecWarnOverloadSoon	= "特殊警报：过载预警",
	specWarnBreakJasperChains	= "特殊警报：可扯断$spell:130395",
	ArrowOnJasperChains			= "DBM箭头：当你受到$spell:130395效果影响时"
})

L:SetMiscLocalization({
	Overload	= "%s要超载了!",
	SDNOT		= "[未石化]",
	SDBLUE		= "[|cFFFFA500石化|r:|cFF0080FF蓝|r]",
	SDGREEN		= "[|cFFFFA500石化|r:|cFF088A08绿|r]",
	SDRED		= "[|cFFFFA500石化|r:|cFFFF0404红|r]",
	SDPURPLE	= "[|cFFFFA500石化|r:|cFF9932CD紫|r]",
	NEXTR		= "|cFFFFA500下次超载|r:|cFFFF0404红色|r",
	NEXTG		= "|cFFFFA500下次超载|r:|cFF088A08绿色|r",
	NEXTB		= "|cFFFFA500下次超载|r:|cFF0080FF蓝色|r",
	NEXTP		= "|cFFFFA500下次超载|r:|cFF9932CD紫色|r"
})


------------
-- Feng the Accursed --
------------
L= DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "第 %d 阶段",
	specWarnDrawFlame = "牵引火焰 > %d <",
	specWarnArcaneVelocity = "秘法动能 > %d <",
	specWarnEpicenter = "远离地震 > %d <",
	specWarnSiphoningShield = "远离盾牌 > %d <"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	InfoFrame			= "资讯框：坦克减益状态层数监视",
	HudMAP				= "高级定位监视(HUD)：$spell:116784的位置",
	HudMAP2				= "高级定位监视(HUD)：$spell:116417",
	HudMAP3				= "高级定位监视(HUD)：$spell:115817",
	WarnPhase			= "警告：阶段转换",
	specWarnDrawFlame 	= "特殊警告：$spell:116711",
	specWarnArcaneVelocity 	= "特殊警告：$spell:116364",
	specWarnEpicenter 	= "特殊警告：$spell:116018",
	specWarnSiphoningShield = "特殊警告：$spell:117203",
	RangeFrame	= "距离监视（8码）：应对奥术阶段",
	SetIconOnWS	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116784),
	SetIconOnAR	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(116417)
})

L:SetMiscLocalization({
	Fire		= "噢，至高的神！借我之手融化他们的血肉吧！",
	Arcane		= "噢，上古的贤者！赐予我魔法的智慧吧！",
	Nature		= "噢，伟大的神灵！赐予我大地的力量！",
	Shadow		= "先烈的英灵！用你的盾保护我吧！"
})


-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L= DBM:GetModLocalization(682)

L:SetWarningLocalization({
	specWarninTT 	= ">> 注意进内场 <<",
	SpecWarnjs		= "<%s> → %s"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	SoundTT				= "语音警告：$spell:116174",
	countTT				= "\"灵魂图腾\"循环计数语音",
	countnone				= "不播放计数语音",
	count3				= "按1~3循环计数",
	count4				= "按1~4循环计数",
	specWarninTT		= "特殊警告：当需要进入内场时显示文字警告",
	GoTotemAdmin		= "主控：分配跨界(仅英雄模式有效,仅能由队长开啟)",
	GoTotemClient		= "被控：接收跨界警告(仅英雄模式有效,需存在主控)",
	optAdminTT			= "主控选项：分配几名DPS入场(此项不包括治疗,总是分配一名治疗入场)",
	send1				= "一人",
	send2				= "二人(10人模式推荐)",
	send3				= "三人(10人模式推荐)",
	send4				= "四人",
	IgnoreTT1			= "主控选项：忽略分配图腾1",
	IgnoreTT2			= "主控选项：忽略分配图腾2",
	IgnoreTT3			= "主控选项：忽略分配图腾3",
	IgnoreTT4			= "主控选项：忽略分配图腾4",
	IgnoreTT5			= "主控选项：忽略分配图腾5",
	IgnoreTT6			= "主控选项：忽略分配图腾6",
	IgnoreTT7			= "主控选项：忽略分配图腾7",
	IgnoreTT8			= "主控选项：忽略分配图腾8",
	IgnoreTT9			= "主控选项：忽略分配图腾9",
	IgnoreTT10			= "主控选项：忽略分配图腾10",
	IgnoreTT11			= "主控选项：忽略分配图腾11",
	IgnoreTT12			= "主控选项：忽略分配图腾12",
	IgnoreTT13			= "主控选项：忽略分配图腾13",
	IgnoreTT14			= "主控选项：忽略分配图腾14",
	IgnoreTT15			= "主控选项：忽略分配图腾15",
	IgnoreTT16			= "主控选项：忽略分配图腾16",
	IgnoreTT17			= "主控选项：忽略分配图腾17",
	SpecWarnjs			= "特殊警告：减伤链",
	SetIconOnVoodoo		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122151),
	InfoFrame			= "资讯框：$spell:116161的玩家 (标注\"治疗\"需团员选择角色类型)",
	optjs				= "<黑手之城>@世界之树 公会专用减伤提示模块",
	non					= "老子谁的减伤都不看",
	druid				= "乳德的减伤",
	priest				= "戒律的减伤",
	paltank				= "坦骑的减伤",
	palheal				= "乳骑的减伤",
	warrior1			= "战神A的减伤",
	warrior2			= "战神B的减伤",
	monktank			= "坦僧的减伤",
	paldps1				= "惩戒A的减伤",
	paldps2				= "惩戒B的减伤",
	optindex			= "被控选项：DPS入场优先级(不影响治疗,总是分配魔法最低治疗入场)",
	noidex				= "我不想进",
	index1				= "序列1(最高优先级)",
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
	Pull		= "死亡时间到！"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	specWarnDDL 	= ">> 下一次 到你断 <<",
	specWarnQBH		= "下一刀歼灭 去背后!",
	specWarnQBHT	= "下一刀是歼灭!",
	specWarnDSoon	= "三秒后 >>护盾<<",
	DarknessSoon	= "黑暗护盾 %d秒"
})

L:SetOptionLocalization({
	RangeFrame			= "距离监视(8码)",
	SoundWOP			= "语音警告：重要技能",
	SoundDSA			= "语音警告：為各种护盾提前预警",
	InfoFrame			= "资讯框：$spell:118303的目标",
	HudMAP				= "高级定位监视(HUD)：$spell:118047的位置",
	HudMAP2				= "高级定位监视(HUD)：$spell:118303的目标",
	SoundCT				= "语音警告：$spell:117833的打断",
	DarknessSoon		= "黑暗护盾即将到来",
	optDD				= "打断链",
	nodd				= "我不打断",
	DD1					= "打断1",
	DD2					= "打断2",
	DD3					= "打断3",
	DD4					= "打断4",
	optKZ				= "盗王控制链",
	noKZ				= "我不控制",
	KZ1					= "控制1",
	KZ2					= "控制2",
	specWarnDDL 		= "特殊警告：下一次到你打断",
	specWarnQBH			= "特殊警告：下一刀歼灭",
	specWarnQBHT		= "特殊警告：下一刀歼灭(坦克)",
	specWarnDSoon		= "特殊警告：护盾即将到来"
})


------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor		= "中场即将消失!",
	specWarnCharge				= "聚焦能量 [%d] - 转换目标",
	specwarnYB					= "本轮>>分担横扫千军<<!",
	specWarnProtector			= "星穹保卫者 [%d] - 转换目标"
})

L:SetTimerLocalization({
	timerDespawnFloor			= "中场消失!"
})

L:SetOptionLocalization({
	SoundWOP					= "语音警告：重要技能",
	SoundCC						= "语音警告：$spell:117949的驱散",
	SoundDD						= "语音警告：為消掉$spell:117878播放额外音效",
	optDBPull					= "语音警告：為正在坦$journal:6178的坦克播放$spell:117960警告",
	specWarnDespawnFloor		= "特殊警告：中场地板消失前",
	specWarnCharge				= "特殊警告：聚焦能量",
	specWarnProtector			= "特殊警告：$journal:6178",
	specwarnYB					= "特殊警告：本轮需要分担横扫千军",
	timerDespawnFloor			= "计时器：中场地板消失",
	InfoFrame					= "资讯框：$spell:117878层数最高的5名团员",
	SetIconOnDestabilized		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(132226),
	optOC						= "\"能量超载\"叠加几层时，开始报警(每三层报警一次)",
	six							= "6层",
	nine						= "9层",
	twelve						= "12层",
	fifteen						= "15层",
	none						= "不报警",
	optPos						= "DBM箭头：\"聚焦能量\"出现前指向\"以太焦镜\"(入口起逆时针)",
	nonepos						= "不显示",
	posA 						= "1号位",
	posB 						= "2号位",
	posC 						= "3号位",
	posD						= "4号位",
	posE 						= "5号位",
	posF 						= "6号位",
	optYB						= "第一轮<横扫千军>分担",
	noYB						= "没我事",
	YB1							= "第一次",
	YB2							= "第二次",
	YB3							= "第三次",
	YB4							= "第四次",
	YB5							= "第五次",
	optYBT						= "第二轮<横扫千军>分担",
	noYBT						= "没我事",
	YBT1						= "第一次",
	YBT2						= "第二次",
	YBT3						= "第三次",
	YBT4						= "第四次",
	YBT5						= "第五次"
})

L:SetMiscLocalization({
	Floor				= "能量涡流减弱了"
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
	InfoFrame			= "资讯框：$spell:116525的目标",
	ArrowOnCombo	= "DBM箭头：$journal:5673阶段\n注：该功能正常工作的前提是坦克在Boss面前而其他人在Boss身后。",
	SoundWOP			= "语音警告：重要技能",
	SoundADD1A			= "预先语音警告：$spell:ej5678 (5秒前)",
	SoundADD1			= "语音警告：$spell:ej5678",
	SoundADD2A			= "预先语音警告：$spell:ej5676 (8秒前)",
	SoundADD2			= "语音警告：$spell:ej5676",
	SoundADD3A			= "预先语音警告：$spell:ej5677 (8秒前)",
	SoundADD3			= "语音警告：$spell:ej5677",
	ragebomb1			= "英雄模式：爆破第3组",
	ragebomb2			= "英雄模式：爆破第6组",
	ragebomb3			= "英雄模式：爆破第9组",
	ragebomb4			= "英雄模式：爆破第12组",
	ragebomb5			= "英雄模式：爆破第15组",
	specWarnBomb		= "特殊警告：本轮需要爆破小怪",
	specWarnKZ			= "特殊警告：本轮需要控制小怪",
	optKZ				= "轻甲兵控制链",
	kza					= "第一组",
	kzb					= "第二组",
	kzc					= "第三组",
	nokz				= "我不控制",
	optBY				= "语音警告：仅提示此首领的毁灭风暴",
	tarfoc				= "当前目标和专注目标",
	Janxi				= "剑曦(左侧傀儡)",
	Qinxi				= "秦希(右侧傀儡)",
	none				= "这个傢伙很懒,谁的提示都不想听"
})

L:SetMiscLocalization({
	Pull		= "机器开始嗡嗡作响了！到下层去！",--Emote
	Rage		= "皇帝之怒响彻群山。",--Yell
	Strength	= "皇帝的力量出现在壁龛中！",--Emote
	Courage		= "皇帝的勇气出现在壁龛中！",--Emote
	Boss		= "两个巨型构造体出现在大型的壁龛中！"--Emote
})

