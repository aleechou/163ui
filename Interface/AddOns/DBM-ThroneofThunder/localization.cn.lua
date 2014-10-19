-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 3/2/2013

if GetLocale() ~= "zhCN" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	SpecWarnJSA			= ">>> 注意减伤 <<<"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	SpecWarnJSA			= "特殊警告：注意减伤",
	SoundWOPIonM		= "语音警告：$spell:138732 7秒时提示（不选则结束前提示）",
	dr1					= "减伤提示:$spell:137313 1/3-1 [开始时提示]",
	dr2					= "减伤提示:$spell:137313 1/3-2 [五秒时提示]",
	dr3					= "减伤提示:$spell:137313 2/4-1",
	dr4					= "减伤提示:$spell:137313 2/4-2",
	RangeFrame		= "距离监视"
})


--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds	= "%s",
	SpecWarnJSA		= ">>> 注意减伤 <<<",
	warnOrbofControl		= "支配宝珠掉落",
	specWarnOrbofControl		= ">>支配宝珠掉落<<"
})

L:SetTimerLocalization({
	timerDoor		= "下一个部族大门",
	timerAdds		= "下一次%s"
})

L:SetOptionLocalization({
	warnAdds		= "警报：新的敌人加入战斗",
	warnOrbofControl		= "警告：$journal:7092掉落",
	specWarnOrbofControl		= "特别警告：$journal:7092掉落",
	InfoFrame			= "信息框：$spell:137458",	
	SoundWOP			= "语音警告：重要技能",
	SpecWarnJSA			= "特殊警告：注意减伤",
	ccsoon				= "语音警告：即将$spell:136767(当你是首领目标时无视此选项)",
	ddyls				= "语音警告：打断$spell:136797",
	dr1					= "减伤提示：$spell:136817 1",
	dr2					= "减伤提示：$spell:136817 2",
	dr3					= "减伤提示：$spell:136817 3",
	dr4					= "减伤提示：$spell:136817 4",
	SoundDB				= "语音警告：$spell:136741",
	SoundOrb			= "语音警告：$journal:7092",
	optQS				= "DEBUFF驱散链",
	noQS				= "不提示",
	QS1					= "顺序1",
	QS2					= "顺序2",
	QS3					= "顺序3",
	allQS				= "总是提示",
	RangeFrame			= "距离监视：熊门5码",
	SoundWSP			= "语音警告：$journal:7866接近20码内（请焦点锁定你的灵魂）",
	dispsetHex			= "当设定的角色中了混乱诅咒时提示你帮忙驱散",
	timerDoor		= "计时条：下一个部族大门阶段",
	timerAdds		= "计时条：下一次小怪"
})

L:SetMiscLocalization({
	newForces		= "之门中涌出",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "开始拍打他的尾巴"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnDDL 	= ">> 下一次 到你断 <<",
	specWarnPossessed		= "%s %s - 快转火!"
})

L:SetOptionLocalization({
	SoundWOP		= "语音警告：重要技能",
	SoundLs			= "倒计时：$spell:136521",	
	SoundHs			= "语音预警：$spell:136990",
	Soundspirit		= "倒计时：女祭司的各种魂灵",
	dr1			= "减伤提示：$spell:137166 1",
	dr2			= "减伤提示：$spell:137166 2",
	dr3			= "减伤提示：$spell:137166 3",
	InfoFrame		= "信息框：$spell:136442",
	helpcold		= "监视此人的体温：在体温流失前3秒给予提示",
	HudMAP			= "高级定位监视(HUD)：$spell:136992",
	HudMAP2			= "高级定位监视(HUD)：$spell:136922",
	optDD			= "沙王打断链",
	nodd			= "我不打断",
	DD1				= "打断1",
	DD2				= "打断2",
	DD3				= "打断3",
	optOC			= "当灵魂碎片叠加几层时提示你传递",
	five			= "5层",
	ten				= "10层",
	none			= "从不提示",
	specWarnDDL 	= "特殊警告：下一次到你打断",
	warnPossessed		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	warnSandBolt		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	PHealthFrame		= "为$spell:136442消散显示剩余血量框(需要首领血量框架开启)",
	RangeFrame			= "距离监视",
	SetIconOnBitingCold	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136992),
	SetIconOnFrostBite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136922)
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s由>%s<使用（%d次剩余）",
	specWarnCrystalShell	= "快去获得%s"
})

L:SetOptionLocalization({
	warnKickShell			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	SoundWOP				= "语音警告：重要技能",	
	SoundAE					= "倒计时：$spell:133939",
	SoundXG					= "语音警告：$journal:7129",	
	dr1						= "减伤提示:$spell:134920 1/4",
	dr2						= "减伤提示:$spell:134920 2/4",
	dr3						= "减伤提示:$spell:134920 3/4",
	dr4						= "减伤提示:$spell:134920 4/4",
	specWarnCrystalShell	= "特殊警报：当没有$spell:137633效果时",
	InfoFrame				= "信息框：没有$spell:137633效果的团员",
	warnsj					= "特别功能：获取水晶警报使用战术方式",
	ClearIconOnTurtles		= "为$journal:7129取消团队标记",
	SetIconOnTurtles		= "为$journal:7129设置团队标记"
})

L:SetMiscLocalization({
	WrongDebuff		= "没有%s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD			= "下一次吐息"
})

L:SetWarningLocalization({
	SpecWarnJSA			= ">>> 注意交减伤 <<<"
})
	
L:SetOptionLocalization({
	SoundWOP		= "语音警告：重要技能",
	timerBreaths			= "计时器：下一次吐息",
	SoundXL			= "语音警告：$spell:140138",
	HudMAP			= "高级定位监视(HUD)：$spell:139822",
	HudMAP2			= "高级定位监视(HUD)：$spell:139889",
	dr1				= "减伤提示:$spell:139458 1",
	dr2				= "减伤提示:$spell:139458 2",
	dr3				= "减伤提示:$spell:139458 3",
	dr4				= "减伤提示:$spell:139458 4",
	dr5				= "减伤提示:$spell:139458 5",
	dr6				= "减伤提示:$spell:139458 6",
	dr7				= "减伤提示:$spell:139458 7",
	dr8				= "减伤提示:$spell:139458 8",
	InfoFrame		= "资讯框：$journal:7006",
	SpecWarnJSA			= "特殊警告：注意减伤",
	SetIconOnCinders		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(139822),
	SetIconOnTorrentofIce	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(139889)
})

L:SetMiscLocalization({
	rampageEnds		= "墨格瑞拉的怒火平息了",
	Behind			= "迷雾中: "
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%s %s (%d)",
	specWarnFlock	= "%s %s (%d)"
})

L:SetTimerLocalization({
	timerFlockCD	= "第%d波: %s"
})

L:SetOptionLocalization({
	SoundWOP		= "语音警告：重要技能",
	HudMAP			= "高级定位监视(HUD)：标注出可能的$spell:138923落点(不包括对你的)",
	HudMAPMe		= "同时标注出可能对你发射的$spell:138923(不建议)",
	warnFlock		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	timerFlockCD	= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	add1			= "第一波$journal:7348(下)",
	add2			= "第二波$journal:7348(下)",
	add3			= "第三波$journal:7348(下)",
	add4			= "第四波$journal:7348(上)",
	add5			= "第四波$journal:7348(下)",
	add6			= "第五波$journal:7348(上)",
	add7			= "第五波$journal:7348(下)",
	add8			= "第六波$journal:7348(上)",
	add9			= "第七波$journal:7348(上)",
	add10			= "第七波$journal:7348(下)",
	add11			= "第八波$journal:7348(上)",
	add12			= "第八波$journal:7348(下)",
	add13			= "第九波$journal:7348(上)",
	add14			= "第九波$journal:7348(下)",
	add15			= "第十波$journal:7348(上)",
	add16			= "第十波$journal:7348(下)",
	add17			= "第十一波$journal:7348(上)",
	add18			= "第十一波$journal:7348(下)",
	add19			= "第十二波$journal:7348(上)",
	add20			= "第十二波$journal:7348(下)",
	add21			= "第十三波$journal:7348(上)",
	add22			= "第十三波$journal:7348(下)",
	add23			= "第十四波$journal:7348(上)",
	add24			= "第十四波$journal:7348(下)",
	add25			= "第十五波$journal:7348(上)",
	add26			= "第十五波$journal:7348(下)",
	add27			= "第十六波$journal:7348(上)",
	add28			= "第十六波$journal:7348(下)",
	add29			= "第十七波$journal:7348(上)",
	add30			= "第十七波$journal:7348(下)",
	add31			= "第十八波$journal:7348(上)",
	add32			= "第十八波$journal:7348(下)",
	add33			= "第十九波$journal:7348(上)",
	add34			= "第十九波$journal:7348(下)",
	add35			= "第二十波$journal:7348(上)",
	add36			= "第二十波$journal:7348(下)",
	dr1				= "减伤提示：$spell:134380 1",
	dr2				= "减伤提示：$spell:134380 2",
	dr3				= "减伤提示：$spell:134380 3",
	dr4				= "减伤提示：$spell:134380 4",
	dr5				= "减伤提示：$spell:134380 5",
	dr6				= "减伤提示：$spell:134380 6",
	dr7				= "减伤提示：$spell:134380 7",
	RangeFrame		= "距离监视(8码)：$spell:138923"
})

L:SetMiscLocalization({
	eggsHatch		= "某个鸟巢中的蛋开始孵化了",
	Upper			= "上层",
	Lower			= "下层",
	UpperAndLower	= "上下都有",
	eggsHatchL		= "下层某个鸟巢中的蛋开始孵化了",
	eggsHatchU		= "上层某个鸟巢中的蛋开始孵化了",
	U				= "上方",
	L				= "下方",
	UAndL			= "上方 & 下方",
	TrippleD		= "三个 (2下1上)",
	TrippleU		= "三个 (2上1下)"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "射线 - |cffff0000红光|r : >%s<, |cff0000ff蓝光|r : >%s<",
	warnBeamHeroic				= "射线 - |cffff0000红光|r : >%s<, |cff0000ff蓝光|r : >%s<, |cffffff00黄光|r : >%s<",
	specWarnBlueBeam			= "你中了蓝光射线 - 避免移动!!",
	warnAddsLeft				= "雾兽剩余: %d",
	specWarnFogRevealed			= "照出%s了!",
	specWarnHold				= "黑暗寄生(%d秒)--快开自保技能",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	SoundWOP					= "语音警告：重要技能",
	specWarnBlueBeam			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(139202),
	warnBeam					= "提示射线目标",
	optDD						= "三元光分担策略",
	DXsound						= "高级定位监视(HUD)：$spell:133795",
	InfoFrame					= "信息框：$spell:133597 (若同时监视$spell:133795 则优先显示$spell:133795层数)",
	InfoFrameLife				= "信息框：$spell:133795层数",
	Sayam						= "特殊功能：被吸血时喊出层数(内容可在下方自定义)",
	nodd						= "不分担",
	DD1							= "A:红黄蓝",
	DD2							= "B:黄蓝红",
	DD3							= "C:蓝红黄",
	HDD1						= "H-A:红红红",
	HDD2						= "H-B:蓝蓝黄",
	HDD3						= "H-C:黄黄蓝",
	HudMAP						= "高级定位监视(HUD)：三元光分担",
	warnAddsLeft				= "警告：雾兽剩余数量",
	specWarnFogRevealed			= "特别警告：雾兽被照出",
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam					= "DBM箭头：$journal:6882的转动方向",
	soundhold					= "黑暗寄生经过多少秒时提示你开自保(30-剩几秒驱散-自保持续时间)",
	sounddisp					= "黑暗寄生剩多少秒时如果还存在则提示你帮忙驱散(治疗)",
	specWarnHold				= "特别警告：黑暗寄生开自保",
	xx1							= "当你被吸血一层时喊话",
	xx2							= "当你被吸血两层时喊话",
	xx3							= "当你被吸血超过三层时喊话(DBM会自动在结尾為你显示层数)",
	lifeA						= "当你被吸血两层时密语此目标挡线",
	lifeB						= "当你被吸血两层时密语此目标挡线",
	SetIconRays					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej6891"),
	SetIconLifeDrain			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(133795),
	SetIconOnParasite			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(133597),
	SetParticle				= "开战后自动将投影材质调為低(离开战斗后恢復设定)"


})

L:SetMiscLocalization({
	Eye		= "魔眼",
	xx1noset 	= "11111111吸我了",
	xx2noset 	= "22222层了 快帮我挡 快帮我挡",
	xx3noset 	= "我要被吸死了------",
	dx		= "帮我挡线!!"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount				= "变异 : %d/5 有益 & %d 有害"
})

L:SetOptionLocalization({
	SoundWOP		= "语音警告：重要技能",
	HudMAPF			= "高级定位监视(HUD)：$spell:136248",
	warnDebuffCount		= "警告:当你获得了有害状态",
	InfoFrame		= "资讯框：首领当前的$journal:6949技能",
	RangeFrame		= "显示距离框架(2码/5码)",
	SetIconOnBigOozes	= "为$journal:6969自动标记"
})

L:SetMiscLocalization({
	BossSpellInfo 	= "进化技能分析表",
	AE1				= "献祭光环",
	AE2				= "靠近分担 (15s)",
	tar5			= "五码分散 (3s)",
	tar1			= "病原体点名 (30s)",
	speed			= "速度提升50%",
	tar2			= "2码手雷 (10s)",
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s：>%s<、>%s<交换",
	SpecWarnJSA			= ">>> 注意减伤 <<<"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	SoundCQ				= "语音警告：$spell:136954时提示你帮忙吃球",
	Mob					= "----战术警报：击杀小怪----",
	dr					= "----减伤提示：$spell:139867----",
	dr1					= "$spell:139867 1",
	dr2					= "$spell:139867 2",
	dr3					= "$spell:139867 3",
	dr4					= "$spell:139867 4",
	dr5					= "$spell:139867 5",
	dr6					= "$spell:139867 6",
	dr7					= "$spell:139867 7",
	dr8					= "$spell:139867 8",
	dr9					= "$spell:139867 9",
	dr10				= "$spell:139867 10",
	MobA				= "第一波小怪",
	MobB				= "第二波小怪",
	MobC				= "第三波小怪",
	SpecWarnJSA			= "特殊警告：注意减伤",
	RangeFrame			= "显示距离框架(8码)",
	warnMatterSwapped	= "警报：$spell:138618交换的目标",
	SetIconOnFont           = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(138707)
})

L:SetMiscLocalization({
	Pull		= "宝珠爆炸了！"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s / %s ",
	SpecWarnJSA		= ">>注意减伤<<"
})

L:SetOptionLocalization({
	warnDeadZone	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	SetIconOnLightningStorm	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136192),
	SoundWOP		= "语音警告：重要技能",
	SoundARAT		= "语音警告：报出$spell:137231的攻击方位",
	SpecWarnJSA		= "特殊警告：注意减伤",
	ReapetAP		= "特殊功能：若你中了$spell:136192则不停呼救",
	HudMAP			= "高级定位监视(HUD)：$spell:136192",
	HudLight		= "高级定位监视(HUD)：闪电阶段结束后标出$spell:136193",
	dr1			= "减伤提示：$spell:136146 1",
	dr2			= "减伤提示：$spell:136146 2",
	dr3			= "减伤提示：$spell:136146 3",
	dr4			= "减伤提示：$spell:136146 4",
	dr5			= "减伤提示：$spell:136146 5",
	dr6			= "减伤提示：$spell:136146 6",
	dr7			= "减伤提示：$spell:136146 7",
	dispsetLight		= "下列角色被电击时提示你[若设定了则不会再提示其他角色]",
	dispsetLight1		= "角色A",
	dispsetLight2		= "角色B",		
	RangeFrame		= "距离监视（动态，当存在多名团员过近时显示）",
	InfoFrame		= "信息框：$spell:136193"
})

L:SetMiscLocalization({
	Helpme			= "拉我一把 ~~~"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight		= "黑夜阶段",
	warnDay			= "白天阶段",
	warnDusk		= "黄昏阶段"
})

L:SetTimerLocalization({
	timerDayCD		= "白天阶段",
	timerDuskCD		= "黄昏阶段",
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	HudMAP				= "高级定位监视(HUD)：$journal:7651星座辅助线",
	InfoFrame			= "信息框：下一次开星座时间（下方自行输入）",
	drAchoose			= "----减伤提示：黑夜阶段----",
	drA1				= "$spell:136752 1",
	drA2				= "$spell:136752 2",
	drA3				= "$spell:136752 3",
	drA4				= "$spell:136752 4",
	drA5				= "$spell:136752 5",
	drA6				= "$spell:136752 6",
	drA7				= "$spell:136752 7",
	drA8				= "$spell:136752 8",
	drBchoose			= "----减伤提示：白天阶段----",
	drC1				= "$spell:137491 1",
	drC2				= "$spell:137491 2",
	drC3				= "$spell:137491 3",
	drCchoose			= "----减伤提示：黄昏阶段----",
	drB1				= "$spell:136752 1",
	drB2				= "$spell:136752 2",
	drB3				= "$spell:136752 3",
	drD1				= "$spell:137491 1",
	drD2				= "$spell:137491 2",
	drE1				= "$spell:137531 1",
	drE2				= "$spell:137531 2",
	XNA					= "第一次玄牛时间(秒)",
	QLA					= "第一次青龙时间(秒)",
	BHA					= "第一次白虎时间(秒)",
	HHA					= "第一次红鹤时间(秒)",
	XNB					= "第二次玄牛时间(秒)",
	QLB					= "第二次青龙时间(秒)",
	BHB					= "第二次白虎时间(秒)",
	HHB					= "第二次红鹤时间(秒)",
	warnNight		= "警告：黑夜阶段",
	warnDay			= "警告：白天阶段",
	warnDusk		= "警告：黄昏阶段",
	timerDayCD		= "计时器：白天阶段",
	timerDuskCD		= "计时器：黄昏阶段",
	RangeFrame		= "距离监视（8码）"
})

L:SetMiscLocalization({
	DuskPhase		= "露琳！将你的力量借给我！",
	XN1				= "玄牛(1)",
	QL1				= "青龙(1)",
	BH1				= "白虎(1)",
	HH1				= "红鹤(1)",
	XN2				= "玄牛(2)",
	QL2				= "青龙(2)",
	BH2				= "白虎(2)",
	HH2				= "红鹤(2)",
	NextTT			= "下一个星座",
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "充能阶段即将到来",
	warnDiffusionChainSpread	= "%s 传导至 >%s<",
})

L:SetOptionLocalization({
	SoundWOP		= "语音警告：重要技能",
	specWarnIntermissionSoon	= "特别警告：充能阶段即将到来",
	RangeFrameLB	= "距离监视：当闪电球存在时切换到3码(英雄模式)",
	warnDiffusionChainSpread	= "警告：$spell:135991 传导的目标",
	cancelhud		= "当玩家白字说不需要分担时变换HUD标誌(输入监视关键字 例如:单吃)",
	drpendp2		= "----减伤提示：第二阶段----",
	drpend1			= "$spell:135695 1",
	drpend2			= "$spell:135695 2",
	drpend3			= "$spell:135695 3",
	drpend4			= "$spell:135695 4",
	drpend5			= "$spell:135695 5",
	drpendp3		= "----减伤提示：第三阶段强风----",
	drend1			= "$spell:136869 1",
	drend2			= "$spell:136869 2",
	drend3			= "$spell:136869 3",
	drend4			= "$spell:136869 4",
	drend5			= "$spell:136869 5",
	drend6			= "$spell:136869 6",
	drpendp3b		= "----减伤提示：第三阶段雷击----",
	drendb1			= "$spell:135095 1",
	drendb2			= "$spell:135095 2",
	drendb3			= "$spell:135095 3",
	drendb4			= "$spell:135095 4",
	drendb5			= "$spell:135095 5",
	drendb6			= "$spell:135095 6",
	optDD			= "盾反提示[不计算P1和转阶段]",
	nodd			= "我不开",
	DD1				= "单数盾反A",
	DD2				= "双数盾反B",
	HudMAP			= "高级定位监视(HUD)：$spell:135695",
	HudMAP2			= "高级定位监视(HUD)：$spell:136295",
	RangeFrame		= "距离监视",--For two different spells
	StaticShockArrow	= "DBM箭头：$spell:135695",
	OverchargeArrow		= "DBM箭头：$spell:136295",
	SetIconOnOvercharge	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136295),
	SetIconOnStaticShock= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(135695)
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

L:SetTimerLocalization({
	timerAnima		= "下一次心能爆炸",
	specWarnVitarun	= "准备生命传递！快就位!"
})

L:SetOptionLocalization({
	SoundWOP		= "语音警告：重要技能",
	SoundStrike		= "为$spell:138295倒数3秒",
	specWarnVitarun	= "特别警告：生命传递跑位",
	optDD			= "生命跑位策略",
	nodd			= "正常循环成员(下方设定编号)",
	DD1				= "替补1",
	DD2				= "替补2",
	DD3				= "替补3",
	DD4				= "替补4",
	DD5				= "替补5",
	lightnumber		= "正常循环成员编号(不会分配编号为0的团员)",
	lastnumber		= "总共安排了多少正常循环成员[必须填写 非常重要]",
	HudMAPAnima		= "高级定位监视(HUD)：$spell:138295爆炸",
	HudMAP			= "高級定位監視(HUD)：$spell:138297",
	timerAnima		= "计时器：下一次$spell:138295爆炸",
	SetIconOnUnstableVita	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(138297),
	SetIconOnUnstableAnima	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(138288)
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name =	"雷电王座小怪"
})

L:SetOptionLocalization({
	SoundWOP		= "语音警告：重要技能",
	HudMAP			= "高级定位监视(HUD)：$spell:139322",
	RangeFrame		= "距离监视(10码)"--For 3 different spells
})

