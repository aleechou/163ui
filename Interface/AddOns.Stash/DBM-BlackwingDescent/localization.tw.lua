if GetLocale() ~= "zhTW" then return end

local L

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization(169)

L:SetWarningLocalization({
	SpecWarnActivated		= "轉換目標到 %s!",
	specWarnGenerator		= "發電機 - 拉開%s!"
})

L:SetTimerLocalization({
	timerShadowConductorCast	= "眾影體",
	timerArcaneLockout		= "秘法殲滅者鎖定",
	timerArcaneBlowbackCast		= "秘法逆爆",
	timerNefAblity			= "奈法技能冷卻"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	timerShadowConductorCast	= "為$spell:92048的施放顯示計時器",
	timerArcaneLockout		= "為$spell:79710法術鎖定顯示計時器",
	timerArcaneBlowbackCast		= "為$spell:91879的施放顯示計時器",

	timerNefAblity			= "為困難模式奈法技能冷卻顯示計時器",
	SpecWarnActivated		= "當新首領啟動時顯示特別警告",
	specWarnGenerator		= "當首領獲得$spell:79629時顯示特別警告",
	AcquiringTargetIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "為最新激活的王設定標記"
})

L:SetMiscLocalization({
	YellTargetLock			= "覆體之影! 遠離我!"
})

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization(170)

L:SetWarningLocalization({
	SpecWarnInferno			= "熾炎骸骨傀儡 即將到來 (~4秒)"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SpecWarnInferno			= "為$spell:92154顯示預先特別警告 (~4秒)",
	RangeFrame			= "第2階段時顯示距離框 (5碼)"
})

L:SetMiscLocalization({
	Slump				= "%s往前撲倒，露出他的鉗子!",
	HeadExposed			= "%s被釘在尖刺上，露出了他的頭!",
	YellPhase2			= "真難想像!看來你真有機會打敗我的蟲子!也許我可幫忙...扭轉戰局。"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization(171)

L:SetWarningLocalization({
	SpecWarnFiend		= "討人厭的惡魔 出現!"
})

L:SetTimerLocalization({
	TimerFiend		= "討人厭的惡魔"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SpecWarnFiend		= "當討人厭的惡魔出現時顯示特別警告",
	TimerFiend		= "為下一次討人厭的惡魔出現顯示計時器",
	InfoFrame			= "在資訊框架顯示$journal:3072",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	NefAdd				= "亞特拉米德，英雄們就在那!",
	Airphase			= "沒錯，逃吧!每一步都會讓你的心跳加速。跳得轟隆作響...震耳欲聾。你逃不掉的!"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization(172)

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	RangeFrame			= "顯示距離框 (6碼)",
	SetIconOnSlime			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame			= "為血量(低於1萬血)顯示資訊框架"
})

L:SetMiscLocalization({
	HealthInfo			= "血量資訊"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization(173)

L:SetWarningLocalization({
	WarnPhase			= "%s階段"
})

L:SetTimerLocalization({
	TimerPhase			= "下一階段"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	WarnPhase			= "為哪個階段即將到來顯示警告",
	TimerPhase			= "為下一階段顯示計時器",
	RangeFrame			= "藍色階段時顯示距離框 (6碼)",
	SetTextures			= "自動在黑暗階段停用投影材質<br/>(離開黑暗階段後回到啟用)",
	FlashFreezeIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77699),
	BitingChillIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed				= "紅色|r瓶子到鍋子裡!",
	YellBlue			= "藍色|r瓶子到鍋子裡!",
	YellGreen			= "綠色|r瓶子到鍋子裡!",
	YellDark			= "黑暗|r魔法到熔爐中!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization(174)

L:SetWarningLocalization({
	OnyTailSwipe			= "尾部鞭擊 (奧妮克希亞)",
	NefTailSwipe			= "尾部鞭擊 (奈法利安)",
	SpecWarnElectrocute		= "電擊 (%d)",
	OnyBreath			= "暗影焰息 (奧妮克希亞)",
	NefBreath			= "暗影焰息 (奈法利安)",
	specWarnShadowblazeSoon	= "%s",
	warnShadowblazeSoon		= "%s"
})

L:SetTimerLocalization({
	timerNefLanding			= "奈法利安降落",
	OnySwipeTimer			= "尾部鞭擊冷卻 (奧妮)",
	NefSwipeTimer			= "尾部鞭擊冷卻 (奈法)",
	OnyBreathTimer			= "暗影焰息冷卻 (奧妮)",
	NefBreathTimer			= "暗影焰息冷卻 (奈法)"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SoundHelp = "當你的焦點目標中了$spell:79339時播放警告語音(輔助斷法)",
	SpecWarnElectrocute		= "为$spell:81198显示特别警告",
	OnyTailSwipe			= "為奧妮克希亞的$spell:77827顯示警告",
	NefTailSwipe			= "為奈法利安的$spell:77827顯示警告",
	OnyBreath			= "為奧妮克希亞的$spell:77826顯示警告",
	NefBreath			= "為奈法利安的$spell:77826顯示警告",
	specWarnCinderMove		= "當你中了$spell:79339需要跑開時顯示特別警告(爆炸前5秒)",
	warnShadowblazeSoon		= "顯示$spell:81031的5秒倒計時(只有當計時器與喊話同步後才顯示)",
	specWarnShadowblazeSoon	= "顯示$spell:81031的預先特別警告<br/>(初始5秒前警告，喊話同步後會精確到1秒)",
	timerNefLanding			= "為奈法利安降落地面顯示計時器",
	OnySwipeTimer			= "為奧妮克希亞的$spell:77827的冷卻時間顯示計時器",
	NefSwipeTimer			= "為奈法利安的$spell:77827的冷卻時間顯示計時器",
	OnyBreathTimer			= "為奧妮克希亞的$spell:77826的冷卻時間顯示計時器",
	NefBreathTimer			= "為奈法利安的$spell:77826的冷卻時間顯示計時器",
	InfoFrame			= "為$journal:3284顯示資訊框架",
	SetWater			= "進入戰鬥後自動停用水體細節(離開戰鬥後啟用)",
	TankArrow			= "為風箏復生的白骨戰士的人顯示DBM箭頭<br/>(設計為只有一個風箏坦)",--npc 41918
	SetIconOnCinder			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame			= "為$spell:79339顯示距離框 (10碼)(智能甄別顯示)"
})

L:SetMiscLocalization({
	NefAoe				= "響起了電流霹啪作響的聲音!",
	YellPhase2 			= "詛咒你們，凡人!如此冷酷地漠視他人的所有物必須受到嚴厲的懲罰!",
	YellPhase3			= "我本來只想略盡地主之誼，但是你們就是不肯痛快的受死!是時候拋下一切的虛偽...殺光你們就好!",
	YellShadowBlaze			= "化為灰燼吧!",
	ShadowBlazeExact		= "暗影炎落地 剩餘 %d 秒",
	ShadowBlazeEstimate		= "即將 暗影炎(約5秒)"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "黑翼陷窟小怪"
})
