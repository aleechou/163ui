if GetLocale() ~= "zhTW" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization(156)

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	ShowDrakeHealth		= "顯示已被釋放的小龍血量\n(需要先開啟首領血量)"
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization(157)

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	TBwarnWhileBlackout	= "當$spell:86788生效時顯示$spell:86369警告",
	TwilightBlastArrow	= "當你附近的人中了$spell:86369時顯示DBM箭頭",
	RangeFrame		= "顯示距離框 (10碼)",
	BlackoutShieldFrame	= "為$spell:86788顯示首領血量及血量條",
	BlackoutIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86788),
	EngulfingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1		= "深呼吸",
	BlackoutTarget		= "昏天暗地: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow		= "%s血量低於30%% - 即將進入下一階段!",
	SpecWarnGrounded	= "拿取禁錮增益",
	SpecWarnSearingWinds	= "拿取旋風增益"
})

L:SetTimerLocalization({
	timerTransition		= "階段轉換"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	specWarnBossLow		= "當首領血量低於30%時顯示特別警告",
	SpecWarnGrounded	= "當你缺少$spell:83581時顯示特別警告(大約施放前10秒)",
	SpecWarnSearingWinds	= "當你缺少$spell:83500時顯示特別警告(大約施放前10秒)",
	timerTransition		= "顯示階段轉換計時器",
	RangeFrame		= "當需要時自動顯示距離框",
	yellScrewed				= "當你同時中了$spell:83099和$spell:92307時大喊",
	InfoFrame				= "在資訊框架顯示沒有$spell:83581和$spell:83500的隊員",
	HeartIceIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "你腳下的地面開始不祥地震動起來....",
	Thundershock		= "四周的空氣爆出能量霹啪作響聲音....",
	Switch			= "我們會解決他們!",
	Phase3			= "見證你的滅亡!",
	Kill			= "不可能...",
	blizzHatesMe	= "我同時中了信標和避雷針! 躲開躲開!",--Very bad situation.
	WrongDebuff	= "沒有 %s"
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization(167)

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	CorruptingCrashArrow	= "當你附近的人中了$spell:81685時顯示DBM箭頭",
	InfoFrame		= "為$journal:3165顯示資訊框架",
	RangeFrame		= "為$journal:3165顯示距離框 (5碼)",
	SetIconOnWorship	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCrash		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(81685),
	SetIconOnCreature	= "設定標記到暗色觸鬚"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization(168)

L:SetWarningLocalization({
	WarnFlameBreath		= "火息術 (%d)",
	WarnOrbSoon		= "%d秒後 暮光寶珠!",
	SpecWarnOrbs		= "即將 暮光寶珠!",
	warnWrackJump		= "%s 轉移至 >%s<",
	warnAggro			= "%s 獲得仇恨(可能是寶珠目標)",
	SpecWarnAggroOnYou	= "你獲得了仇恨! 注意寶珠!",
	SpecWarnDispel		= "距離上次毀壞已經過%d秒 - 快驅散!"
})

L:SetTimerLocalization({
	TimerFlameBreath			= "下一次 火息術 (%d)",
	TimerEggWeakening	= "暮光殼甲移除", 
	TimerEggWeaken		= "暮光殼甲生成",
	TimerOrbs			= "寶珠 冷卻"
})	

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SoundDIS = "為驅散$spell:89421播放警告語音",
	SoundPAL1 = "當需要給奇數次第一個中$spell:89421的隊員$spell:6940的時候播放提醒語音",
	SoundPAL2 = "當需要給偶數次第一個中$spell:89421的隊員$spell:6940的時候播放提醒語音",
	SoundMAura = "當第三次$spell:90125快要施放前提醒補騎開啟$spell:31821",
	WarnFlameBreath		= "為$spell:90125顯示報警",
	WarnOrbSoon		= "為暮光寶珠顯示預先報警(倒計時5秒,預估時間)",
	warnWrackJump		= "為$spell:89421轉移至其他目標顯示報警",
	warnAggro			= "當寶珠出現時警告獲得仇恨的玩家(很可能是寶珠目標)",
	SpecWarnAggroOnYou	= "寶珠出現時如果你獲得仇恨就顯示特別警告(很可能是寶珠目標)",
	SpecWarnOrbs		= "為寶珠出現顯示特別警告(預估時間)",
	SpecWarnDispel		= "為驅散$spell:89421顯示特別警告(25人22-18-14或10人20-12-12-12)", 
	TimerFlameBreath			= "為下次$spell:90125顯示計時器",
	TimerEggWeakening	= "為$spell:87654的移除狀態顯示計時器",
	TimerEggWeaken		= "為$spell:87654的生成狀態顯示計時器",
	TimerOrbs			= "為下次寶珠出現顯示計時器(預估時間)",
	SetIconOnOrbs		= "當寶珠出現時為獲得仇恨的玩家設置標記(很可能是寶珠目標)",
	OrbsCountdown		= "為寶珠出現播放倒計時音效",
	InfoFrame			= "在資訊框架顯示獲得仇恨的隊員"
})

L:SetMiscLocalization({
	YellDragon		= "吃吧，孩子們!好好享用他們肥嫩的軀殼吧!",
	YellEgg			= "你以為這樣就佔了上風?愚蠢!",
	HasAggro			= "獲得仇恨"
})

--------------------------
--  The Bastion of Twilight Trash  --
--------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"暮光堡壘小怪"
})
