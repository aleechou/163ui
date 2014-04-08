-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 11/14/2012

if GetLocale() ~= "zhCN" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetOptionLocalization({
	specwarnPlatform	= "特别警告：当战斗露台改变时",
	ArrowOnAttenuation	= "DBM箭头：当$spell:127834出现时指示移动的方向",
	specwarnExhale		= "特别警告：$spell:122761",
	specwarnExhaleB		= "特别警告：$spell:122761的预先警告",
	specwarnAttenuationL	= "特别警告：左旋音波",
	specwarnAttenuationR	= "特别警告：右旋音波",
	specwarnDR				= "特别警告：注意开减伤",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740),
	SoundWOP			= "语音警告：重要技能",
	HudMAP				= "高级定位监视(HUD)：$spell:122761目标的位置",
	HudMAP2				= "高级定位监视(HUD)：$spell:122740的位置",
	optarrowRTI			= "<力与魄>出现前，显示箭头指向以下标记的玩家",
	none				= "不显示箭头",
	arrow1				= "星星",
	arrow2				= "大饼",
	arrow3				= "菱形",
	arrow4				= "三角",
	arrow5				= "月亮",
	arrow6				= "方块",
	arrow7				= "叉叉",
	optDR				= "P1阶段<力与魄>减伤",
	noDR				= "不关我事",
	DR1					= "P1第一次",
	DR2					= "P1第二次",
	DR3					= "P1第三次",
	DR4					= "P1第四次",
	DR5					= "P1第五次",
	optDRT				= "P2阶段<力与魄>减伤",
	noDRT				= "不关我事",
	DRT1				= "P2第一次",
	DRT2				= "P2第二次",
	DRT3				= "P2第三次",
	DRT4				= "P2第四次",
	DRT5				= "P2第五次"
})

L:SetMiscLocalization({
	Platform	= "%s朝他其中一个平台飞去了！",
	Defeat		= "我们不会向黑暗虚空的绝望屈服。如果女皇要我们去死，我们便照做。"
})

L:SetWarningLocalization({
	specwarnPlatform	= "作战区改变!",
	specwarnAttenuationL	= "← ← ←左左左",
	specwarnAttenuationR	= "右右右→ → →",
	specwarnExhale		= "吐气[%d] : %s",
	specwarnDR			= ">>本轮你开减伤<<",
	specwarnExhaleB		= "即将 >>%d层<< 吐气"
})

------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetWarningLocalization({
	SpecWarnOverwhelmingAssaultOther 		= "%s 被压制 (%d层)",
	SpecWarnJSA								= ">>>注意开减伤<<<"
})

L:SetOptionLocalization({
	UnseenStrikeArrow	= "DBM箭头：$spell:122949的目标",
	InfoFrame			= "资讯框：$spell:123474",
	RangeFrame			= "距离监视(8码)：$spell:123175",
	SpecWarnOverwhelmingAssaultOther = "特别警告：$spell:123474的层数",
	HudMAP				= "高级定位监视(HUD)：$spell:122949的位置",
	SoundWOP			= "语音警告：重要技能",
	SpecWarnJSA			= "特殊警告：注意开减伤",
	unseenjs1			= "减伤提示：无影击1",
	unseenjs2			= "减伤提示：无影击2",
	unseenjs3			= "减伤提示：无影击3",
	unseenjs4			= "减伤提示：无影击4",
	unseenjs5			= "减伤提示：无影击5",
	unseenjs6			= "减伤提示：无影击6",
	unseenjs7			= "减伤提示：无影击7",
	unseenjs8			= "减伤提示：无影击8",
	unseenjs9			= "减伤提示：无影击9"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "远离紫圈!",
	specWarnPungencyOtherFix = "%s 敏感 (%d)",
	specwarnCrushH	= "重碾 (%d)",
	SpecWarnJSA		= "5秒后重碾 >>注意减伤<<",
	specWarnFLM		= ">%s<信息素, 准备接手!"
})

L:SetOptionLocalization({
	specwarnUnder		= "特别警告：你在BOSS下方",
	PheromonesIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835),
	InfoFrame			= "资讯框：$spell:123081层数监视",
	optTankMode			= "特别警告：费洛蒙换坦策略",
	two					= "二坦模式 (30层敏感以上提示)",
	three				= "三坦模式 (20层敏感以上提示)",
	SoundWOP			= "语音警告：重要技能",
	SoundZN				= "语音警告：碾碎倒计时(英雄模式)",
	specWarnPungencyOtherFix = "特别警告：当别人的$spell:123081达到设定层数时",
	HudMAP				= "高级定位监视(HUD)：$spell:122835的位置",
	SoundFS				= "坦克倒计时：$spell:122735",
	SpecWarnJSA			= "特殊警告：注意开减伤",
	specWarnFLM			= "特殊警告：准备接手信息素",
	optFLM				= "信息素传递提示:输入上一个信息素传递者的名字",
	unseenjs1			= "减伤提示：重碾1",
	unseenjs2			= "减伤提示：重碾2",
	unseenjs3			= "减伤提示：重碾3",
	unseenjs4			= "减伤提示：重碾4",
	unseenjs5			= "减伤提示：重碾5",
	unseenjs6			= "减伤提示：重碾6",
	unseenjs7			= "减伤提示：重碾7",
	unseenjs8			= "减伤提示：重碾8",
	unseenjs9			= "减伤提示：重碾9"
})

L:SetMiscLocalization({
	UnderHim	= "在它下方",
	Heroicrush	= "他的对手",
	Ptwostart	= "巨型盔甲开始碎裂了"
})
----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetWarningLocalization({
	specWarnQuickeningX = "%s - 快驱散!",
	specWarnBH			= "给 >> %s <<保护!"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	SoundDS				= "语音警告：为控制结束倒数10秒",
	specWarnBH			= "特殊警告：当需要给冲锋保护时",
	InfoFrame			= "资讯框：$spell:122149层数监视",
	optQS				= "加速驱散链",
	noQS				= "不提示",
	QS1					= "顺序1",
	QS2					= "顺序2",
	QS3					= "顺序3",
	allQS				= "总是提示",
	optBH				= "冲锋保护链",
	noBH				= "不提示",
	BH1					= "顺序1",
	BH2					= "顺序2",
	BH3					= "顺序3",
	BH4					= "顺序4",
	allBH				= "总是提示",
	SoundJR				= "语音警告：当你没有残渣时提示救琥珀",
	specWarnQuickeningX	= "特殊警告：当需要驱散/窃取$spell:122149时",
	APArrow				= "DBM箭头：$spell:121881的位置",
	NearAP				= "特殊功能：$spell:121881在你20码范围内才播放语音(仅影响语音)",
	ReapetAP			= "特殊功能：若你的$spell:121881在5秒内无人打破则不停呼救",
	HudMAP				= "高级定位监视(HUD)：$spell:121885的位置",
	optHud				= "高级定位监视(HUD)：风之炸弹的位置",
	auto				= "当你中了炸弹时显示",
	always				= "总是显示",
	none				= "不显示",
	RangeFrame			= "距离监视(3码)：$spell:121881",
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Helpme				= "救我 ~~~",
	Reinforcements		= "风领主梅尔加拉克调遣援兵了！"
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s：>%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1：打断/减益目标，2：打断自己，3：回复生命/意志，4：离开构造体",
	warnAmberExplosion			= "%s 正在施放 %s",
	warnInterruptsAvailable		= "可打断 %s: >%s<",
	warnWillPower				= "当前意志：%s",
	specwarnHupo				= "转化(%d): %s",
	specwarnOOYou				= ">>有软泥追你<<",
	specwarnOOYouD				= ">>追你的软泥死掉了<<",
	specwarnWillPower			= "意志低下！- 还剩5秒",
	specwarnAmberExplosionYou	= "打断 >你自己的< %s！",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s：打断 %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s：打断 %s!"--Amber Montrosity
})

L:SetTimerLocalization({
	timerAmberExplosionAMCD		= "下一次%s：琥珀畸怪"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	SoundADD					= "语音警告：为被软泥追逐播放蜂鸣音",
	warnReshapeLife				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(122784, GetSpellInfo(122784)),
	warnReshapeLifeTutor		= "当变为变异构造体时显示技能及其作用",
	warnAmberExplosion			= "警报：$spell:122398正在施放，并警报来源",
	warnInterruptsAvailable		= "警报：可使用$spell:122402打断琥珀打击的成员",
	warnWillPower				= "警报：当前意志剩余75、50、25、10以及5点时",
	specwarnHupo				= "特殊警报：变异构造体",
	specwarnWillPower			= "特殊警报：在变异构造体中意志低下时",
	specwarnOOYou				= "特殊警告：有软泥追你",
	specwarnOOYouD				= "特殊警告：追你的软泥死掉了",
	specwarnAmberExplosionYou	= "特殊警报：打断自己的$spell:122398",
	specwarnAmberExplosionAM	= "特殊警报：打断琥珀畸怪的$spell:122402",
	specwarnAmberExplosionOther	= "特殊警报：打断变异构造体的$spell:122398",
	timerAmberExplosionAMCD		= "计时条：琥珀畸怪的下一次$spell:122402",
	AdvInfoFrame				= "信息框：意志值与首领$spell:123059",
	FixNameplates				= "在变为变异构造体后自动关闭影响战斗的姓名板\n（战斗结束后会自动恢复原始设置）",
	optInfoFrame				= "<能量与动摇>信息框",
	noIF						= "不监视",
	IF1							= "主要监视能量(DPS)",
	IF2							= "主要监视动摇(TANK)"
})

L:SetMiscLocalization({
	WillPower					= "意志"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "琥珀陷阱：%d/5",
	warnDr				= "%s：%s (%d秒)",
	specWarnjs			= ">>减伤：%s<<",
	specWarnTT			= "战栗图腾 <第%d轮> <%d秒>"
})

L:SetOptionLocalization({
	warnAmberTrap		= "警报：$spell:125826的生成，并提示进度", -- maybe bad translation.
	InfoFrame			= "信息框：受$spell:125390效果影响的玩家",
	InfoYB				= "信息框：音波能量监视(团队中必须有人做焦点)",
	SoundWOP			= "语音警告：重要技能",
	SoundYB				= "语音警告：為音波爆炸倒数",
	HudMAP				= "高级定位监视(HUD)：自己的$spell:124863",
	HudMAPOther			= "高级定位监视(HUD)：其他人的$spell:124863",
	HudMAP2				= "高级定位监视(HUD)：$spell:124821的位置",
	RangeFrame			= "距离监视（5码）：$spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097),
	specWarnTT			= "特别警告：准备开战栗图腾",
	SendPos				= "主控：分配$spell:124863跑位(需要队长)",
	AcceptPos			= "被控：接收并显示$spell:124863跑位(需要队长开主控)",
	optDR				= "战栗图腾链(123311231223-loop)",
	DR1					= "萨满A",
	DR2					= "萨满B",
	DR3					= "萨满C",
	noDR				= "没我事",
	warnDr				= "警告：减伤提示",
	specWarnjs			= "特别警告：减伤提示",
	optjs				= "<黑手之城>@世界之树 公会专用减伤提示模块",
	optjs2				= "<黑手之城>@世界之树 公会专用减伤提示模块(B)",
	non					= "老子谁的减伤都不看",
	non2				= "老子谁的减伤都不看",
	shaman1				= "苦逼萨满A",
	shaman2				= "苦逼萨满B",
	pal1				= "大影帝骑士A",
	pal2				= "大影帝骑士B",
	pal3				= "大影帝骑士C",
	dk					= "死骑士",
	warrior1			= "大天堂高阶信仰战A",
	warrior2			= "大天堂高阶信仰战B",
	druid				= "毫无存在感的乳德",
	priest1				= "牧师A",
	priest2				= "牧师B",
	priest3				= "牧师C",
	priest4				= "黑牧",
})

L:SetMiscLocalization({
	PlayerDebuffs		= "凝视",
	YellPhase3			= "别找借口了，女皇！消灭这些傻瓜，否则我会亲手杀了你！"

})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name =	"恐惧之心杂兵"
})

L:SetOptionLocalization({
	UnseenStrikeArrow	= "DBM箭头：$spell:122949"
})