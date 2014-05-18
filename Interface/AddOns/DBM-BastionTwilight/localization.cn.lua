if GetLocale() ~= "zhCN" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization(156)

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	ShowDrakeHealth		= "显示已被释放的小龙血量\n(需要先开启首领血量)"
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization(157)

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	TBwarnWhileBlackout	= "当$spell:86788生效时显示$spell:86369警告",
	TwilightBlastArrow	= "当你附近的人中了$spell:86369时显示DBM箭头",
	RangeFrame		= "显示距离框 (10码)",
	BlackoutShieldFrame	= "为$spell:86788显示首领血量及血量条",
	BlackoutIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86788),
	EngulfingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1		= "深呼吸",
	BlackoutTarget		= "眩晕: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow		= "%s血量低于30%% - 即将进入下一阶段!",
	SpecWarnGrounded	= "快找重力井(融入大地)",
	SpecWarnSearingWinds	= "快找旋风(旋风上抛)"
})

L:SetTimerLocalization({
	timerTransition		= "阶段转换"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	specWarnBossLow		= "当首领血量低于30%时显示特别警告",
	SpecWarnGrounded	= "当你缺少$spell:83581时显示特别警告(大约施放前10秒)",
	SpecWarnSearingWinds	= "当你缺少$spell:83500时显示特别警告(大约施放前10秒)",
	timerTransition		= "显示阶段转换计时条",
	RangeFrame		= "当需要时自动显示距离框",
	yellScrewed				= "当你同时中了$spell:83099和$spell:92307时大喊",
	InfoFrame				= "在信息框显示没有$spell:83581和$spell:83500的队员",
	HeartIceIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "你脚下的地面发出不祥的“隆隆”声……",
	Thundershock		= "周围的空气因为充斥着强大的能量而发出“噼啪”声……",
	Switch			= "停止你的愚行！",
	Phase3			= "令人印象深刻……",
	Kill			= "这不可能……",
	blizzHatesMe	= "我同时中了道标和闪电魔棒! 躲开躲开!",--Very bad situation.
	WrongDebuff	= "没有 %s"
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization(167)

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	CorruptingCrashArrow	= "当你附近的人中了$spell:81685时显示DBM箭头",
	InfoFrame		= "在信息框显示$journal:3165",
	RangeFrame		= "为$journal:3165显示距离框 (5码)",
	SetIconOnWorship	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCrash		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(81685),
	SetIconOnCreature	= "设定标记到黑暗的造物"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization(168)

L:SetWarningLocalization({
	WarnFlameBreath		= "烈焰吐息 (%d)",
	WarnOrbSoon		= "%d秒后 暮光宝珠!",
	SpecWarnOrbs		= "即将 暮光宝珠!",
	warnWrackJump		= "%s 转移至 >%s<",
	warnAggro			= "%s 获得仇恨(可能是宝珠目标)",
	SpecWarnAggroOnYou	= "你获得了仇恨! 注意宝珠!",
	SpecWarnDispel		= "距离上次毁灭已经过%d秒 - 快驱散!"
})

L:SetTimerLocalization({
	TimerFlameBreath			= "下一次 烈焰吐息 (%d)",
	TimerEggWeakening	= "暮光外壳移除", 
	TimerEggWeaken		= "暮光外壳生成",
	TimerOrbs			= "宝珠 冷却"
})	

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	SoundDIS = "为驱散$spell:89421播放警告语音",
	SoundPAL1 = "当需要给奇数次第一个中$spell:89421的队员$spell:6940的时候播放提醒语音",
	SoundPAL2 = "当需要给偶数次第一个中$spell:89421的队员$spell:6940的时候播放提醒语音",
	SoundMAura = "当第三次$spell:90125快要施放前提醒奶骑开启$spell:31821",
	WarnFlameBreath		= "为$spell:90125显示报警",
	WarnOrbSoon		= "为暮光宝珠显示预先报警(倒计时5秒,预估时间)",
	warnWrackJump		= "为$spell:89421转移至其它目标显示报警",
	warnAggro			= "当宝珠出现时警告获得仇恨的玩家(很可能是宝珠目标)",
	SpecWarnAggroOnYou	= "宝珠出现时如果你获得仇恨就显示特别警告(很可能是宝珠目标)",
	SpecWarnOrbs		= "为宝珠出现显示特别警告(预估时间)",
	SpecWarnDispel		= "为驱散$spell:89421显示特别警告(25人22-18-14或10人20-12-12-12)", 
	TimerFlameBreath			= "为下次$spell:90125显示计时条",
	TimerEggWeakening	= "为$spell:87654的移除状态显示计时条",
	TimerEggWeaken		= "为$spell:87654的生成状态显示计时条",
	TimerOrbs			= "为下次宝珠出现显示计时条(预估时间)",
	SetIconOnOrbs		= "当宝珠出现时为获得仇恨的玩家设置标记(很可能是宝珠目标)",
	OrbsCountdown		= "为宝珠出现播放倒计时音效",
	InfoFrame			= "在信息框显示获得仇恨的队员"
})

L:SetMiscLocalization({
	YellDragon		= "吃吧，孩子们！尽情享用他们肥美的躯壳吧！",
	YellEgg			= "你以为就这么简单？愚蠢！",
	HasAggro			= "获得仇恨"
})

--------------------------
--  The Bastion of Twilight Trash  --
--------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"暮光堡垒小怪"
})
