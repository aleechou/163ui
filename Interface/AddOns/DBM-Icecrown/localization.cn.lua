-- author: callmejames @《凤凰之翼》 一区藏宝海湾

if GetLocale() ~= "zhCN" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name 				= "堡垒大门小怪"
}

L:SetWarningLocalization{
	SpecWarnTrap			= "触发陷阱! - 缚亡守卫被释放了"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	SpecWarnTrap			= "当触发陷阱时显示特别警告",
	SetIconOnDarkReckoning		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1			= "那里是谁？",
	WarderTrap2			= "我醒了!",
	WarderTrap3			= "有人闯进了主人的房间！"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name 				= "天灾工厂小怪"
}

L:SetWarningLocalization{
	WarnMortalWound			= "%s: >%s< (%s)",
	SpecWarnTrap			= "触发陷阱! - 愤怒的斩肉者 到来"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	SpecWarnTrap			= "当触发陷阱时显示特别警告",
	WarnMortalWound			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "快点，我们会在背后伏击他们！",
	FleshreaperTrap2		= "你逃不出我们的手心！",
	FleshreaperTrap3		= "这里有活人？！"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name 				= "血色厅堂小怪"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name 				= "霜翼大厅小怪"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent		= "大厅内攻击开始！"
}

L:SetTimerLocalization{
	GosaTimer			= "时间剩余"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent		= "为辛达苟萨前大厅内的攻击显示特别提示",
	GosaTimer			= "为辛达苟萨前大厅内的攻击显示持续时间计时"
}

L:SetMiscLocalization{
	SindragosaEvent			= "绝不能让他们靠近冰霜女王。快，阻止他们！"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name 				= "玛洛加尔领主"
}

L:SetTimerLocalization{
	AchievementBoned		= "白骨贯体计时"
}

L:SetWarningLocalization{
	WarnImpale			= ">%s< 被穿刺了"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	WarnImpale			= "提示$spell:69062的目标",
	AchievementBoned		= "为成就：白骨贯体显示计时",
	SetIconOnImpale			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name 				= "亡语者女士"
}

L:SetTimerLocalization{
	TimerAdds			= "新的小怪"
}

L:SetWarningLocalization{
	WarnReanimating			= "小怪复活",
	WarnTouchInsignificance		= "%s: >%s< (%s)",
	WarnAddsSoon			= "新的小怪 即将到来",
	SpecWarnVengefulShade		= "你被怨毒之影盯上了 - 快跑开"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	WarnAddsSoon			= "为新的小怪出现显示预先警告",
	WarnReanimating			= "当小怪复活时显示警告",
	TimerAdds			= "为新的小怪显示计时",
	SpecWarnVengefulShade		= "当你被怨毒之影盯上时显示特别警告",
	ShieldHealthFrame		= "为$spell:70842显示首领血量框架",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),	
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull			= "是谁在打扰我？你们竟敢擅闯这神圣的地方？这里将会是你们的埋骨之地！",
	YellReanimatedFanatic		= "来吧，为纯粹的形态欢喜吧！",
	ShieldPercent			= "法力屏障",
	Fanatic1			= "教派狂热者",
	Fanatic2			= "畸形的狂热者",
	Fanatic3			= "被复活的狂热者"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name 				= "炮舰战斗"
}

L:SetWarningLocalization{
	WarnBattleFury			= "%s (%d)",
	WarnAddsSoon			= "新的小怪 即将到来"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	WarnBattleFury			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "战斗之怒"),
	TimerCombatStart		= "为战斗开始显示计时",
	WarnAddsSoon			= "为新的小怪出现显示预先警告",
	TimerAdds			= "为新的小怪显示计时"
}

L:SetTimerLocalization{
	TimerCombatStart		= "战斗开始",
	TimerAdds			= "新的小怪"
}

L:SetMiscLocalization{
	PullAlliance			= "启动引擎！小伙子们，向命运之战前进！",
	KillAlliance			= "我早就警告过你，恶棍！兄弟姐妹们，前进！",
	PullHorde			= "来吧！部落忠诚勇敢的儿女们！今天是部落仇敌灭亡的日子！LOK'TAR OGAR！",
	KillHorde			= "联盟不行了。向巫妖王进攻！",
	AddsAlliance			= "将士们，给我进攻！",
	AddsHorde			= "将士们，给我进攻！",
	MageAlliance	= "我们的船体受损了，赶快叫个战斗法师来轰掉那些大炮！",
	MageHorde		= "我们的船体受伤了，赶快叫个法师来干掉那些大炮！"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name 				= "死亡使者萨鲁法尔"
}

L:SetWarningLocalization{
	WarnFrenzySoon			= "狂乱 即将到来",
}

L:SetTimerLocalization{
	TimerCombatStart		= "战斗开始"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	TimerCombatStart		= "为战斗开始显示计时",
	WarnFrenzySoon			= "为狂乱显示预先警告(大约33%)",
	BoilingBloodIcons		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame			= "显示距离框(12码)",
	RunePowerFrame			= "显示首领血量及$spell:72371条",
	BeastIcons			= "为血兽设置标记"
}

L:SetMiscLocalization{
	RunePower			= "鲜血能量",
	PullAlliance			= "你每消灭一名部落士兵，或是杀死一只联盟狗。巫妖王的军力就会增长一分。瓦格里正在把你们的阵亡者变为天灾战士。",
	PullHorde			= "库卡隆，行动！勇士们，提高警惕。天灾军团已经……"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name 				= "烂肠"
}

L:SetWarningLocalization{
	InhaledBlight			= "凋零呼吸: >%d<",
	WarnGastricBloat		= "%s: >%s< (%s)"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	InhaledBlight			= "为$spell:71912显示警告",
	RangeFrame			= "显示距离框(8码)",
	WarnGastricBloat		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "unknown"),
	SetIconOnGasSpore		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons		= "发送$spell:69279目标设置的标记到团队频道\n(需开启团队广播及助理权限)",
	AchievementCheck		= "发送'勤通风，多喝水'成就失败信息到团队频道\n(需助理权限)"
}

L:SetMiscLocalization{
	SporeSet			= "毒气孢子{rt%d}: %s",
	AchievementFailed		= ">> 成就失败: %s中了%d层孢子 <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name 				= "腐面"
}

L:SetWarningLocalization{
	WarnOozeSpawn			= "小软泥怪 出现了",
	WarnUnstableOoze		= "%s: >%s< (%s)",
	SpecWarnLittleOoze		= "你被小软泥怪盯上了 - 快跑"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "下一次 软泥洪流"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	NextPoisonSlimePipes		= "为下一次软泥洪流显示计时",
	WarnOozeSpawn			= "为小软泥的出现显示警告",
	SpecWarnLittleOoze		= "当你被小软泥怪盯上时显示特别警告",
	RangeFrame			= "显示距离框(8码)",
	WarnUnstableOoze		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow			= "为大软泥怪坦克显示DBM箭头 (测试中)"
}

L:SetMiscLocalization{
	YellSlimePipes1			= "好消息！各位！我修好了毒性软泥管道！",
	YellSlimePipes2			= "重大喜讯！各位！软泥又开始流动啦！"
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name 				= "普崔塞德教授"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "第2阶段 即将到来",
	WarnPhase3Soon			= "第3阶段 即将到来",
	WarnMutatedPlague		= "%s: >%s< (%s)",
	SpecWarnMalleableGoo		= "你中了可延展黏液 - 快躲开",
	SpecWarnMalleableGooNear	= "你附近有人中了可延展黏液 - 小心",
	SpecWarnUnboundPlague		= "转移肆虐毒疫",
	SpecWarnNextPlageSelf		= "肆虐毒疫下次转移到你身上，准备好!"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	WarnPhase2Soon			= "为第2阶段显示预先警告(大约83%)",
	WarnPhase3Soon			= "为第3阶段显示预先警告(大约38%)",
	SpecWarnMalleableGoo		= "当你是$spell:72295的目标之一时显示特别警告",
	SpecWarnMalleableGooNear	= "当你附近有人成为$spell:72295目标之一时显示特别警告",
	WarnMutatedPlague		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon		= "为中$spell:72295的目标之一设置标记",
	NextUnboundPlagueTargetIcon	= "为下一个$spell:72856的目标设置标记",
	YellOnMalleableGoo		= "当你中了$spell:72295时大喊",
	YellOnUnbound			= "当你中了$spell:72856时大喊",
	YellOnUnboundUrgent			= "当你中的$spell:72856已经持续太久需要立刻传递时大喊",
	GooArrow			= "当你附近的人中了$spell:72295时显示DBM箭头",
	SpecWarnUnboundPlague		= "为$spell:72856的转移显示特别警告",
	SpecWarnNextPlageSelf		= "当你是下一个$spell:72856的目标时显示特别警告",
	BypassLatencyCheck		= "不对$spell:72295使用同步延迟查询\n(建议遇到报警有误才启用本项)"
}

L:SetMiscLocalization{
	YellPull			= "喜讯，各位！我想我已经研制出一种能够毁灭艾泽拉斯的药剂了！",
	YellMalleable			= "我中了可延展黏液！",
	YellUnbound			= "我中了肆虐毒疫！",
	YellUnboundUrgent			= "快传走我的肆虐毒疫！"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name 				= "鲜血王子议会"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "转换目标到: %s",
	WarnTargetSwitchSoon		= "转换目标 即将到来",
	SpecWarnVortex			= "你中了震荡涡流 - 快躲开",
	SpecWarnVortexNear		= "你附近的人中了震荡涡流 - 小心"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "转换目标"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	WarnTargetSwitch		= "为转换目标显示警告",
	WarnTargetSwitchSoon		= "为转换目标显示预先警告",
	TimerTargetSwitch		= "为转换目标显示冷却计时",
	SpecWarnVortex			= "当你中了$spell:72037时显示特别警告",
	SpecWarnVortexNear		= "当你附近的人中了$spell:72037时显示特别警告",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "设置标记在可攻击的王子身上(骷髅)",
	RangeFrame			= "显示距离框(12码)",
	VortexArrow			= "当你附近的人中了$spell:72037时显示DBM箭头",
	BypassLatencyCheck		= "不对$spell:72037使用同步延迟查询\n(建议遇到报警有误才启用本项)"
}

L:SetMiscLocalization{
	Keleseth			= "凯雷塞斯王子",
	Taldaram			= "塔达拉姆王子",
	Valanar				= "瓦拉纳王子",
	EmpoweredFlames			= "强能烈焰飞快地冲向(%S+)！"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name 				= "鲜血女王兰娜瑟尔"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame			= "显示距离框(8码)",
	YellOnFrenzy			= "当你$spell:71474时大喊"
}

L:SetMiscLocalization{
	SwarmingShadows			= "蜂拥的阴影在(%S+)的四周积聚！",
	YellFrenzy			= "我该去咬人啦!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name 				= "踏梦者瓦莉瑟瑞娅"
}

L:SetWarningLocalization{
	WarnCorrosion			= "%s: >%s< (%d)",
	WarnPortalOpen			= "传送门开启"
}

L:SetTimerLocalization{
	TimerPortalsOpen		= "传送门开启",
	TimerBlazingSkeleton		= "下一次 灼热骷髅",
	TimerAbom			= "下一次 贪食的憎恶"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	SetIconOnBlazingSkeleton	= "为灼热骷髅设置标记(骷髅)",
	WarnPortalOpen			= "当梦魇之门开启时显示警告",
	TimerPortalsOpen		= "当梦魇之门开启时显示计时",
	TimerBlazingSkeleton		= "为下一次灼热骷髅出现显示计时",
	TimerAbom			= "为下一次贪食的憎恶出现显示计时",
	WarnCorrosion			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull			= "入侵者闯入了内室。加紧毁掉那条绿龙！留下龙筋龙骨用来复生！",
	YellKill			= "我获得了新生！伊瑟拉的恩泽赐予我消灭邪恶的力量！",
	YellPortals			= "我打开了进入梦境的传送门。英雄们，救赎就在其中……",
	YellPhase2			= "我的力量回来了。坚持，英雄们！"
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name 				= "辛达苟萨"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "下一次 空中阶段",
	TimerNextGroundphase		= "下一次 地上阶段",
	AchievementMystic		= "秘法打击叠加"
}

L:SetWarningLocalization{
	WarnPhase2soon			= "第2阶段 即将到来",
	WarnAirphase			= "空中阶段",
	WarnGroundphaseSoon		= "辛达苟萨 即将落地",
	WarnInstability			= "动荡: >%d<",
	WarnChilledtotheBone		= "寒霜刺骨: >%d<",
	WarnMysticBuffet		= "秘法打击: >%d<"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	WarnAirphase			= "提示空中阶段",
	WarnGroundphaseSoon		= "为地上阶段显示预先警告",
	WarnPhase2soon			= "为第2阶段显示预先警告 (大约38%)",
	TimerNextAirphase		= "为下一次 空中阶段显示计时",
	TimerNextGroundphase		= "为下一次 地上阶段显示计时",
	WarnInstability			= "为你的$spell:69766堆叠显示警告",
	WarnChilledtotheBone		= "为你的$spell:70106堆叠显示警告",
	WarnMysticBuffet		= "为你的$spell:70128堆叠显示警告",
	AnnounceFrostBeaconIcons	= "空中阶段发布$spell:70126的标记站位图到团队警告频道(需要权限)",
	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase		= "空中阶段前清除所有标记",
	AchievementCheck		= "公布'极限'成就警告到团队频道\n(需助理权限)",
	RangeFrame			= "显示距离框(普通10码, 困难20码)"
}

L:SetMiscLocalization{
	YellAirphase			= "你们的入侵结束了！无人可以生还！",
	YellPhase2			= "绝望吧，体会主人那无穷无尽的力量吧！",
	YellAirphaseDem			= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem			= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet			= "冰霜道标{rt%d}: %s",
	BeaconIconChatNormal1			= "- {rt8} - {rt7} - {rt6} -",
	BeaconIconChatNormal2			= "--- {rt5} - {rt4} ---",
	BeaconIconChatHeroic1			= "- {rt8} - {rt6} - {rt4} -",
	BeaconIconChatHeroic2			= "- {rt7} - {rt5} - {rt3} -",
	AchievementWarning		= "警告: %s中了5层秘法打击",
	AchievementFailed		= ">> 成就失败: %s中了%d层秘法打击 <<",
	YellPull			= "你们这些蠢货胆敢闯入这里。诺森德的冰风将卷走你们的灵魂！"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name 				= "巫妖王"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "第2阶段转换 即将到来",
	WarnPhase3Soon			= "第3阶段转换 即将到来",
	ValkyrWarning			= ">%s< 被抓住了!",
	SpecWarnYouAreValkd		= "你被抓住了",
	SpecWarnDefileCast		= "你中了污染 - 快躲开",
	SpecWarnDefileNear		= "你附近的人中了污染 - 小心",
	SpecWarnTrapNear		= "你附近的人中了暗影陷阱 - 小心",
	specWarnInfest      = "寄生 %d",
	specWarnSoulreaper      = "灵魂收割 %d",
	WarnNecroticPlagueJump		= "死疽跳到>%s<身上",
	SpecWarnPALGrabbed		= "治疗骑士 %s 被抓住了",
	SpecWarnPRIGrabbed		= "治疗牧师 %s 被抓住了",
	SpecWarnValkyrLow		= "瓦格里血量低于55%"
}

L:SetTimerLocalization{
	TimerCombatStart		= "战斗开始",
	TimerRoleplay			= "剧情阶段",
	PhaseTransition			= "转换阶段",
	TimerVileSpiritMove		= "邪恶灵魂开始攻击",
	TimerInfestCD      = "寄生 %d",
	TimerSoulreaperCD      = "灵魂收割 %d",
	TimerNecroticPlagueCleanse 	= "驱散死疽"
}

L:SetOptionLocalization{
	SoundWOP = "为重要技能播放额外的警告语音",
	TimerCombatStart		= "为战斗开始显示计时",
	TimerRoleplay			= "为剧情事件显示计时",
	WarnNecroticPlagueJump		= "提示$spell:73912跳跃后的目标",
	TimerNecroticPlagueCleanse	= "为驱散第一次堆叠前的死疽显示计时",
	PhaseTransition			= "为转换阶段显示计时",
	TimerVileSpiritMove		= "为邪恶灵魂开始移动攻击显示计时",
	TimerInfestCD      = "为下一次$spell:73779显示计时",
	TimerSoulreaperCD      = "为下一次$spell:73797显示计时",
	WarnPhase2Soon			= "为转换第2阶段显示预先警告(大约73%)",
	WarnPhase3Soon			= "为转换第3阶段显示预先警告(大约43%)",
	ValkyrWarning			= "提示谁被瓦格里影卫抓住了",
	SpecWarnYouAreValkd		= "当你被瓦格里影卫抓住时显示特别警告",
	SpecWarnHealerGrabbed		= "当治疗骑士或牧师被瓦格里影卫抓住时显示特别警告",
	SpecWarnDefileCast		= "当你中了$spell:72762时显示特别警告",
	SpecWarnDefileNear		= "当你附近的人中了$spell:72762时显示特别警告",
	SpecWarnTrapNear		= "当你附近的人中了$spell:73539时显示特别警告",
	specWarnInfest      = "为$spell:73779显示特别警告",
	specWarnSoulreaper      = "为$spell:73797显示特别警告",
	YellOnDefile			= "当你中了$spell:72762时大喊",
	YellOnRagingSpirit			= "当你中了$spell:69200时大喊",
	YellOnTrap			= "当你中了$spell:73539时大喊",
	DefileIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	HarvestSoulIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),
	ValkyrIcon			= "为瓦格里影卫设置标记",
	DefileArrow			= "当你附近的人中了$spell:72762时显示DBM箭头",
	TrapArrow			= "当你附近的人中了$spell:73539时显示DBM箭头",
	LKBugWorkaround			= "不对污染/暗影陷阱使用同步延迟查询\n(预设开启直至一个错误同步发生)",
	AnnounceValkGrabs		= "提示被瓦格里影卫抓住的目标到团队频道\n(需开启团队广播及助理权限)",
	SpecWarnValkyrLow		= "当瓦格里血量低于55%时显示特别警告",
	AnnouncePlagueStack		= "提示$spell:73912层数到团队频道(10层, 10层后每5层提示一次)\n(需开启助理权限)"
}

L:SetMiscLocalization{
	LKPull				= "怎么，自诩正义的圣光终于来了？我是不是该丢下霜之哀伤，恳求您的宽恕呢，弗丁？",
	YellDefile			= "我中了污染!",
	YellRagingSpirit		= "我中了狂怒的鬼魂!",
	YellTrap			= "我中了暗影陷阱!",
	YellValk				= "我被瓦格里抓了!",
	LKRoleplay			= "真的是正义在驱使你吗？我很好奇……",
	PlagueWhisper			= "你受到了",
	ValkGrabbedIcon			= "瓦格里影卫{rt%d}抓住了 %s",
	ValkGrabbed			= "瓦格里影卫抓住了 %s",
	PlagueStackWarning		= "警告: %s中了%d层死疽",
	AchievementCompleted		= ">> 成就成功: %s中了%d层死疽 <<"
}
