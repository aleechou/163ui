if GetLocale() ~= "zhCN" then return end

local L

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization(169)

L:SetWarningLocalization({
	SpecWarnActivated		= "转换目标到 %s!",
	specWarnGenerator		= "能量发生器 - 拉开%s!"
})

L:SetTimerLocalization({
	timerShadowConductorCast	= "暗影灌注",
	timerArcaneLockout		= "奥术歼灭者锁定",
	timerArcaneBlowbackCast		= "奥术反冲",
	timerNefAblity			= "奈法技能冷却"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	timerShadowConductorCast	= "为$spell:92048的施放显示计时条",
	timerArcaneLockout		= "为$spell:79710法术锁定显示计时条",
	timerArcaneBlowbackCast		= "为$spell:91879的施放显示计时条",

	timerNefAblity			= "为困难模式奈法技能冷却显示计时条",
	SpecWarnActivated		= "当新金刚启动时显示特别警告",
	specWarnGenerator		= "当金刚获得$spell:79629时显示特别警告",
	AcquiringTargetIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "为最新激活的金刚设定标记"
})

L:SetMiscLocalization({
	YellTargetLock			= "暗影包围! 远离我!"
})

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization(170)

L:SetWarningLocalization({
	SpecWarnInferno			= "炽焰白骨结构体 即将到来 (~4秒)"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	SpecWarnInferno			= "为$spell:92154显示预先特别警告 (~4秒)",
	RangeFrame			= "第2阶段时显示距离框 (5码)"
})

L:SetMiscLocalization({
	Slump				= "%s向前倒下，暴露出他的钳子！",
	HeadExposed			= "%s将自己钉在刺上，露出了他的头！",
	YellPhase2			= "难以置信，你们竟然真要击败我的熔岩巨虫了！也许我可以帮你们……扭转局势。"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization(171)

L:SetWarningLocalization({
	SpecWarnFiend		= "喧闹恶鬼 出现!"
})

L:SetTimerLocalization({
	TimerFiend		= "喧闹恶鬼"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	SpecWarnFiend		= "当喧闹恶鬼出现时显示特别警告",
	TimerFiend		= "为下一次喧闹恶鬼出现显示计时条",
	InfoFrame			= "在信息框显示$journal:3072",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	NefAdd				= "艾卓曼德斯，那些英雄就在那边！",
	Airphase			= "对，跑吧！每跑一步你的心跳都会加快。这心跳声，洪亮如雷，震耳欲聋。你逃不掉的！"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization(172)

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	RangeFrame			= "显示距离框 (6码)",
	SetIconOnSlime			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame			= "在信息框显示低血量(低于1万血)玩家"
})

L:SetMiscLocalization({
	HealthInfo			= "血量信息"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization(173)

L:SetWarningLocalization({
	WarnPhase			= "%s阶段"
})

L:SetTimerLocalization({
	TimerPhase			= "下一阶段"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	WarnPhase			= "为各阶段即将到来显示警告",
	TimerPhase			= "为下一阶段显示计时条",
	RangeFrame			= "蓝色阶段时显示距离框 (6码)",
	SetTextures			= "自动在黑暗阶段停用材质投射\n(离开黑暗阶段后再次启用)",
	FlashFreezeIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77699),
	BitingChillIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed				= "红瓶|r扔进了大锅里！",
	YellBlue			= "蓝瓶|r扔进了大锅里！",
	YellGreen			= "绿瓶|r扔进了大锅里！",
	YellDark			= "黑暗|r魔法！"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization(174)

L:SetWarningLocalization({
	OnyTailSwipe			= "龙尾扫击 (奥妮)",
	NefTailSwipe			= "龙尾扫击 (奈法)",
	SpecWarnElectrocute		= "通电 (%d)",
	OnyBreath			= "暗影烈焰吐息 (奥妮)",
	NefBreath			= "暗影烈焰吐息 (奈法)",
	specWarnShadowblazeSoon	= "%s",
	warnShadowblazeSoon		= "%s"
})

L:SetTimerLocalization({
	timerNefLanding			= "奈法利安降落",
	OnySwipeTimer			= "龙尾扫击冷却 (奥妮)",
	NefSwipeTimer			= "龙尾扫击冷却 (奈法)",
	OnyBreathTimer			= "暗影烈焰吐息冷却 (奥妮)",
	NefBreathTimer			= "暗影烈焰吐息冷却 (奈法)"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	SoundHelp = "当你的焦点目标中了$spell:79339时播放警告语音(辅助打断)",
	SpecWarnElectrocute		= "为$spell:81198显示特别警告",
	OnyTailSwipe			= "为奥妮克希亚的$spell:77827显示警告",
	NefTailSwipe			= "为奈法利安的$spell:77827显示警告",
	OnyBreath			= "为奥妮克希亚的$spell:77826显示警告",
	NefBreath			= "为奈法利安的$spell:77826显示警告",
	specWarnCinderMove		= "当你中了$spell:79339需要跑开时显示特别警告(爆炸前5秒)",
	warnShadowblazeSoon		= "显示$spell:81031的5秒倒计时(只有当计时条与喊话同步后才显示)",
	specWarnShadowblazeSoon	= "显示$spell:81031的预先特别警告\n(初始5秒前警告，喊话同步后会精确到1秒)",
	timerNefLanding			= "为奈法利安降落地面显示计时条",
	OnySwipeTimer			= "为奥妮克希亚的$spell:77827的冷却时间显示计时条",
	NefSwipeTimer			= "为奈法利安的$spell:77827的冷却时间显示计时条",
	OnyBreathTimer			= "为奥妮克希亚的$spell:77826的冷却时间显示计时条",
	NefBreathTimer			= "为奈法利安的$spell:77826的冷却时间显示计时条",
	InfoFrame			= "在信息框显示$journal:3284",
	SetWater			= "进入战斗后自动关闭液体细节效果(离开战斗后再启用)",
	TankArrow			= "为风筝坚骨战士的玩家显示DBM箭头\n(仅适用于一个风筝坦克)",--npc 41918
	SetIconOnCinder			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame			= "为$spell:79339显示距离框 (10码)(智能区别显示)"
})

L:SetMiscLocalization({
	NefAoe				= "空气中激荡的电流噼啪作响！",
	YellPhase2 			= "诅咒你们，凡人！你们丝毫不尊重他人财产的行为必须受到严厉处罚！",
	YellPhase3			= "我一直在尝试扮演好客的主人，可你们就是不肯受死！该卸下伪装了……杀光你们！",
	YellShadowBlaze			= "血肉化为灰烬！",
	ShadowBlazeExact		= "暗影爆燃火花落地 剩余 %d 秒",
	ShadowBlazeEstimate		= "即将 暗影爆燃火花(约5秒)"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "黑翼血环小怪"
})
