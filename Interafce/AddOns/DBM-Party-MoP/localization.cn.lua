-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 1/4/2013

if GetLocale() ~= "zhCN" then return end
local L

-----------------------
-- <<<Temple of the Jade Serpent>>> --
-----------------------
-----------------------
-- Wise Mari --
-----------------------
L= DBM:GetModLocalization(672)

L:SetOptionLocalization({
	SetIconOnAdds	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej5616"),
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Lorewalker Stonestep --
-----------------------
L= DBM:GetModLocalization(664)

L:SetWarningLocalization({
	SpecWarnIntensity	= "%s -> %s (%d)"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	SpecWarnIntensity	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS["stack"]:format(6, 113315)
})

-----------------------
-- Liu Flameheart --
-----------------------
L= DBM:GetModLocalization(658)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Sha of Doubt --
-----------------------
L= DBM:GetModLocalization(335)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- <<<Stormstout Brewery>>> --
-----------------------
-----------------------
-- Ook-Ook --
-----------------------
L= DBM:GetModLocalization(668)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Hoptallus --
-----------------------
L= DBM:GetModLocalization(669)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

L:SetMiscLocalization({
	Tuzi				= "跳跳大王大声呼喊！兔妖来了！"
})

-----------------------
-- Yan Zhu the Uncasked --
-----------------------
L= DBM:GetModLocalization(670)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	SpecWarnFizzyBubbles	= "特别警告：缺少$spell:114459",
	RangeFrame				= "距离监视(10码)：$spell:106546"
})

L:SetWarningLocalization({
	SpecWarnFizzyBubbles	= "去拿泡泡飞起来!"
})

-----------------------
-- <<<Shado-Pan Monastery>>> --
-----------------------
-----------------------
-- Gu Cloudstrike --
-----------------------
L= DBM:GetModLocalization(673)

L:SetWarningLocalization({
	warnStaticField	= "%s"
})

L:SetOptionLocalization({
	warnStaticField	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(106923),
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Snowdrift --
-----------------------
L= DBM:GetModLocalization(657)

L:SetWarningLocalization({
	warnRemainingNovice	= "学徒剩余: %d"
})

L:SetOptionLocalization({
	warnRemainingNovice	= "警报：学徒剩余数量",
	SoundWOP			= "语音警告：重要技能"
})

L:SetMiscLocalization({
	NovicesPulled	= "是你们！这么多年了，是你们又让煞再次苏醒！",
	NovicesDefeated = "你们只是击败了我最年轻的学徒而已。接下来是我的两位得意门生。",
--	Defeat			= "I am bested.  Give me a moment and we will venture forth together to face the Sha."
})

-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	InfoFrame			= "信息框：$journal:5827"
})

L:SetMiscLocalization({
	Kill		= "只要你们心中的暴虐不除……我……就会……回来的……",
})

-----------------------
-- <<<The Gate of the Setting Sun>>> --
-----------------------
---------------------
-- Kiptilak --
---------------------
L= DBM:GetModLocalization(655)

L:SetOptionLocalization({
	IconOnSabotage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(107268),
	SoundWOP			= "语音警告：重要技能"
})

-------------
-- Gadok --
-------------
L= DBM:GetModLocalization(675)

L:SetMiscLocalization({
	StaffingRun		= "突袭者加杜卡准备发动一次扫射！"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Rimok --
-----------------------
L= DBM:GetModLocalization(676)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------------
-- Raigonn --
-----------------------------
L= DBM:GetModLocalization(649)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

L:SetMiscLocalization({
	Kkxka		= "科里克提克虫群使者",
	Kkxkb		= "科里克提克捍卫者",
	Kkxkc		= "科里克提克吞噬者"
})

-----------------------
-- <<<Mogu'Shan Palace>>> --
-----------------------
-----------------------
-- Trial of Kings --
-----------------------
L= DBM:GetModLocalization(708)

L:SetMiscLocalization({
	Pull		= "废物！你们信誓旦旦地表忠心，却连这些低等生物都赶不出我的宫殿。",
	Kuai		= "格尔桑氏族会向王上和其他像你们这样利欲熏心的骗子证明，我们才是王上真正的拥护者！",
	Ming		= "哈飒克氏族会向所有人证明，我们才是血统最纯正的魔古！",
	Haiyan		= "克尔格西氏族会让你知道，为什么只有强者才配站在我们国王的身边！",
	Defeat		= "谁让外人闯进大厅的？只有哈飒克或克尔格西氏族才会干出这种叛逆的行径！"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Gekkan --
-----------------------
L= DBM:GetModLocalization(690)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Weaponmaster Xin --
-----------------------
L= DBM:GetModLocalization(698)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- <<<Siege of Niuzao Temple>>> --
-----------------------
-----------------------
-- Jinbak --
-----------------------
L= DBM:GetModLocalization(693)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Vo'jak --
-----------------------
L= DBM:GetModLocalization(738)

L:SetTimerLocalization({
	TimerWave	= "开始进攻: %s"
})

L:SetOptionLocalization({
	TimerWave	= "计时器：下一波小怪",
	SoundWOP	= "语音警告：重要技能"
})

L:SetMiscLocalization({
	WaveStart		= "蠢货！竟敢正面挑战强大的螳螂妖？你会死得很快的。",
	Mob			= "加入了战斗。"
})

-----------------------
-- Pavalak --
-----------------------
L= DBM:GetModLocalization(692)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Neronok --
-----------------------
L= DBM:GetModLocalization(727)

L:SetMiscLocalization({
	Fly		= "飞到桥的另一端去了！"
})

L:SetWarningLocalization({
	specWarnFly	= "快去另一边!",
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	specWarnFly			= "特别警告：当首领飞到桥的另一头时"
})

-----------------------
-- <<<Scholomance>>> --
-----------------------
-----------------------
-- Instructor Chillheart --
-----------------------
L= DBM:GetModLocalization(659)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Jandice Barov --
-----------------------
L= DBM:GetModLocalization(663)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Rattlegore --
-----------------------
L= DBM:GetModLocalization(665)

L:SetWarningLocalization({
	SpecWarnGetBoned	= "快去拿骨甲!",
})

L:SetOptionLocalization({
	SpecWarnGetBoned	= "特别警告：缺少$spell:113996",
	InfoFrame			= "信息框： 缺少$spell:113996的团队成员",
	SoundWOP			= "语音警告：重要技能"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "未获得骨甲"
})

-----------------------
-- Lillian Voss --
-----------------------
L= DBM:GetModLocalization(666)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

L:SetMiscLocalization({
	Kill	= "什么？！"
})

-----------------------
-- Darkmaster Gandling --
-----------------------
L= DBM:GetModLocalization(684)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- <<<Scarlet Halls>>> --
-----------------------
-----------------------
-- Braun --
-----------------------
L= DBM:GetModLocalization(660)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Harlan --
-----------------------
L= DBM:GetModLocalization(654)

L:SetMiscLocalization({
	Call		= "武器大师哈兰召唤了两名同伴加入战斗！"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Flameweaver Koegler --
-----------------------
L= DBM:GetModLocalization(656)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- <<<Scarlet Cathedral>>> --
-----------------------
-----------------------
-- Thalnos Soulrender --
-----------------------
L= DBM:GetModLocalization(688)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-----------------------
-- Korlof --
-----------------------
L= DBM:GetModLocalization(671)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	KickArrow	= "DBM箭头：$spell:114487接近你时",
})

-----------------------
-- Durand/High Inquisitor Whitemane --
-----------------------
L= DBM:GetModLocalization(674)


L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})