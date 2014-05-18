if GetLocale() ~= "zhCN"  then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCrystal = "下一次克卓莫召唤水晶",
	KohcromStomp = "下一次克卓莫践踏"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	KohcromWarning	= "显示$journal:4262的技能警告",
	KohcromCrystal = "为下一次$journal:4262的$spell:103639显示计时条",
	KohcromStomp = "为下一次$journal:4262的$spell:103414显示计时条",
	OnlyMorchok		= "仅显示莫卓克的技能报警和计时条",
	OnlyKohcrom		= "仅显示克卓莫的技能报警和计时条",
	RangeFrame		= "为成就显示距离框(5码)"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetTimerLocalization({
	timerPhaseTwo		= "第二阶段"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	timerPhaseTwo		= "为第二阶段强制开始显示计时条(随机团队模式)",
	CustomRangeFrame	= "距离框设定(英雄模式)",
	Never				= "不显示",
	Normal				= "普通距离框显示",
	DynamicPhase2		= "二阶段减益过滤",
	DynamicAlways		= "全时段减益过滤",
	DisruptingShadowsIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(103434)
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s 吸收了 %s"
})

L:SetTimerLocalization({
	timerOozesReach		= "软泥接触Boss"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	warnOozesHit		= "警告boss吞噬了何种软泥",
	timerOozesReach		= "显示软泥接触boss的计时",
	RangeFrame			= "为$spell:104898显示距离框(4码)",
	ColorPGDB				= "紫-绿-黑-蓝 组合(英雄模式)",
	ColorGRBD				= "绿-红-蓝-黑 组合(英雄模式)",
	ColorGYDR				= "绿-黄-黑-红 组合(英雄模式)",
	ColorBPGY				= "蓝-紫-绿-黄 组合(英雄模式)",
	ColorBDPY				= "蓝-黑-紫-黄 组合(英雄模式)",
	ColorPRYD				= "紫-红-黄-黑 组合(英雄模式)",
	KGreen				= "杀绿",
	KBlack				= "杀黑",
	KBlue				= "杀蓝",
	KYellow				= "杀黄",
	KPurple				= "杀紫",
	oozesArrow		= "为目标软泥的出现位置显示DBM箭头"
})

L:SetMiscLocalization({
	Black			= "|cFF424242黑|r",
	Purple			= "|cFF9932CD紫|r",
	Red				= "|cFFFF0404红|r",
	Green			= "|cFF088A08绿|r",
	Blue			= "|cFF0080FF蓝|r",
	Yellow			= "|cFFFFA901黄|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: %d 剩余",
	warnFrostTombCast		= "%s 在八秒后",
	specWarnLightningPhase		= "闪电阶段",
	specWarnFrozenPhase		= "冰霜阶段"
})

L:SetTimerLocalization({
	TimerSpecial			= "第一次冰/电阶段"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	WarnPillars				= "警告还剩余多少$journal:3919或$journal:4069",
	TimerSpecial			= "为第一次冰/电阶段显示计时条",
	RangeFrame				= "为电阶段显示距离框(10码)",
	AnnounceFrostTombIcons	= "为$spell:104451的目标发布图标至团队频道\n(需要团队队长)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	specWarnLightningPhase		= "为闪电阶段显示特别警告",
	specWarnFrozenPhase		= "为冰霜阶段显示特别警告",
	SetIconOnLance		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105316),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnShatteringIce		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105289),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	DispelYell        = "当你中了$spell:109325并进入$spell:110317时大喊治疗驱散",
	SetBubbles				= "当$spell:104451时自动禁用对话泡泡"
})

L:SetMiscLocalization({
	YellIceLance   = "帮我挡线!!!",
	YellDispel   = "驱散我",
	TombIconSet				= "寒冰之墓标记{rt%d}设置于 %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "5秒后%s(%d)"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "boss激活"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	holditHoT1 = "暮光审判 1 施放时播放语音提醒你开启减伤技能",
	holditHoT2 = "暮光审判 2 施放时播放语音提醒你开启减伤技能",
	holditHoT3 = "暮光审判 3 施放时播放语音提醒你开启减伤技能",
	holditHoT4 = "暮光审判 4 施放时播放语音提醒你开启减伤技能",
	holditHoT5 = "暮光审判 5 施放时播放语音提醒你开启减伤技能",
	holditHoT6 = "暮光审判 6 施放时播放语音提醒你开启减伤技能",
	holditHoT7 = "暮光审判 7 施放时播放语音提醒你开启减伤技能",
	SpecWarnHoTN		= "暮光审判前5秒显示特别警告(每3轮重置)",
	Never				= "不警告",
	One					= "第一组(1、4、7轮)",
	Two					= "第二组(2、5轮)",
	Three				= "第三组(3、6轮)",
	TimerCombatStart	= "为boss落地显示计时条"
})

L:SetMiscLocalization({
	Pull				= "一股破坏平衡的力量正在接近。它的混乱灼烧着我的心智！"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "暮光精英！"
})

L:SetTimerLocalization({
	TimerCombatStart	= "战斗开始",
	TimerAdd	= "下一次暮光精英"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	SetIconOnConsumingShroud		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(110214),
	SetIconOnShockwave		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108046),
	TimerCombatStart	= "为战斗开始时间显示计时条",
	TimerAdd	= "为下一次暮光精英出现显示计时条",
	SpecWarnElites		= "为暮光精英出现显示特别警告",
	SetTextures			= "一阶段禁用投影材质(二阶段自动开启)",
	holditslaught1 = "暮光杀戮 1 施放时播放语音提醒你开启减伤技能",
	holditslaught2 = "暮光杀戮 2 施放时播放语音提醒你开启减伤技能",
	holditslaught3 = "暮光杀戮 3 施放时播放语音提醒你开启减伤技能",
	holditslaught4 = "暮光杀戮 4 施放时播放语音提醒你开启减伤技能",
	holditslaught5 = "暮光杀戮 5 施放时播放语音提醒你开启减伤技能"
})

L:SetMiscLocalization({
	SapperEmote			= "暮光工兵",
	GorionaRetreat			= "痛苦地尖叫并退入了云海的漩涡中。",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnAmaLowHP			= "停止攻击！融合体还需吸收%d个血！",
	SpecWarnTendril			= "即将倾斜, 你还未被固定!"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	SpecWarnAmaLowHP			= "当融合体血量过低且未吸满9个血时显示特别警告",
	SpecWarnTendril			= "当你没有$spell:105563减益时显示特别警告",
	InfoFrame				= "在信息框显示地面残留的残渣数量",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105490),
	SetIconOnDeath		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(106199),
	SetIconOnEarth		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(106200),
	ShowShieldInfo			= "为$spell:105479显示血量条"
})

L:SetMiscLocalization({
	Pull		= "看那些装甲！他正在解体！摧毁那些装甲，我们就能给他最后一击！",
	BloodCount	= "残渣数量",
	PlasmaTarget	= "灼热血浆: %s",
	DRoll		= "开始向左侧翻滚",
	DRollR		= "开始向右侧翻滚",
	DLevels			= "保持平衡"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetTimerLocalization({
	TimerMutant  = "下一次 变异的腐蚀"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	TimerMutant	= "为下一次变异的腐蚀出现显示计时条",
	RangeFrame			= "为$spell:108649显示自动减益过滤的距离框(英雄模式)",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649),
	SetIconOnCrush	= "为每个平台$spell:106385的固定2个目标设定标记(10人模式)"
})

L:SetMiscLocalization({
	Pull				= "你们什么都没做到。我要撕碎你们的世界。"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"巨龙之魂小怪"
})

L:SetWarningLocalization({
	DrakesLeft			= "暮光飞龙剩余: %d"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s"--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "警告还剩余多少暮光飞龙未出现",
	TimerDrakes			= "为暮光飞龙$spell:109904显示计时条"
})

L:SetMiscLocalization({
	EoEEvent			= "这没有用，巨龙之魂的力量太强大了。",--Partial
	UltraxionTrash		= "重逢真令我高兴，阿莱克斯塔萨。分开之后，我可是一直很忙。",
	UltraxionTrashEnded = "这些龙崽子，这些实验，只为一个崇高的目标。你很快就会看到我最伟大的研究成果。"
})

