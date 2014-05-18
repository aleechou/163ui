-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 2/25/2012

if GetLocale() ~= "zhCN" then return end

local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L= DBM:GetModLocalization(105)

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L= DBM:GetModLocalization(106)

L:SetWarningLocalization({
	WarnAdd		= "小怪被释放了"
})

L:SetOptionLocalization({
	WarnAdd		= "当一只小怪失去$spell:75608时警告"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L= DBM:GetModLocalization(107)

L:SetTimerLocalization({
	TimerSuperheated 	= "过热护甲（%d）"
})

L:SetOptionLocalization({
	TimerSuperheated	= "为$spell:75846显示持续时间计时条"
})

------------
-- Beauty --
------------
L= DBM:GetModLocalization(108)

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L= DBM:GetModLocalization(109)

L:SetOptionLocalization({
	SetIconOnBoss	= "施放$spell:76200后标记首领本体"
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L= DBM:GetModLocalization(89)

-----------------------
-- Helix Gearbreaker --
-----------------------
L= DBM:GetModLocalization(90)

---------------------
-- Foe Reaper 5000 --
---------------------
L= DBM:GetModLocalization(91)

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L= DBM:GetModLocalization(92)

----------------------
-- "Captain" Cookie --
----------------------
L= DBM:GetModLocalization(93)

----------------------
-- Vanessa VanCleef --
----------------------
L= DBM:GetModLocalization(95)

L:SetTimerLocalization({
	achievementGauntlet	= "坚定的范克里夫复仇者"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

L:SetOptionLocalization{
	PingBlitz	= "当乌比斯将军即将迅猛突袭你时点击小地图"
}

L:SetMiscLocalization{
	Blitz		= "盯住了|cFFFF0000(%S+)"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Shadowburner --
-------------------------
L= DBM:GetModLocalization(133)

L:SetMiscLocalization{
	ValionaYell	= "巨龙，听从我的命令！接住我！",	-- Yell when Valiona is incoming
	Add			= "%s开始施放"
}

------------
-- Erudax --
------------
L= DBM:GetModLocalization(134)

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L= DBM:GetModLocalization(124)

---------------------
-- Earthrager Ptah --
---------------------
L= DBM:GetModLocalization(125)

L:SetMiscLocalization{
	Kill		= "塔赫……不复存在了……"
}

--------------
-- Anraphet --
--------------
L= DBM:GetModLocalization(126)

L:SetTimerLocalization({
	achievementGauntlet	= "超越光速"
})

L:SetMiscLocalization({
	Brann				= "好啊，我们走！只需要在门禁系统中输入最终登录序列……然后……"
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "分裂 即将到来"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "为分裂显示预先警告"
})

-------------
-- Ammunae --
------------- 
L= DBM:GetModLocalization(128)

-------------
-- Setesh  --
------------- 
L= DBM:GetModLocalization(129)

----------
-- Rajh --
----------
L= DBM:GetModLocalization(130)

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

--------------
-- Lockmaw --
--------------
L= DBM:GetModLocalization(118)

L:SetOptionLocalization{
	RangeFrame	= "显示距离框 (5码)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "奥弗"		-- he is fightable after Lockmaw :o
})

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

L:SetOptionLocalization{
	BossHealthAdds	= "在首领血量框架显示小怪血量"
}

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

L:SetWarningLocalization{
	specWarnPhase2Soon	= "5秒后进入第2阶段"
}

L:SetTimerLocalization({
	timerPhase2 		= "第2阶段开始"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "当第2阶段即将到来(5秒)时显示特别警告",
	timerPhase2 		= "为第2阶段开始显示计时条"
}

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L= DBM:GetModLocalization(96)

-----------------------
-- Baron Silverlaine --
-----------------------
L= DBM:GetModLocalization(97)

--------------------------
-- Commander Springvale --
--------------------------
L= DBM:GetModLocalization(98)

L:SetTimerLocalization({
	TimerAdds		= "下批小怪"
})

L:SetOptionLocalization{
	TimerAdds		= "为下一批小怪显示计时条"
}

L:SetMiscLocalization{
	YellAdds		= "击退入侵者！"
}

-----------------
-- Lord Walden --
-----------------
L= DBM:GetModLocalization(99)

L:SetWarningLocalization{
	specWarnCoagulant	= "绿色混合剂 - 持续移动！",	-- Green light
	specWarnRedMix		= "红色混合剂 - 不要移动！"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "为红/绿色移动方式显示特别警告"
}

------------------
-- Lord Godfrey --
------------------
L= DBM:GetModLocalization(100)

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L= DBM:GetModLocalization(110)

L:SetWarningLocalization({
	WarnEmerge		= "出现",
	WarnSubmerge	= "钻地"
})

L:SetTimerLocalization({
	TimerEmerge		= "下一次出现",
	TimerSubmerge	= "下一次钻地"
})

L:SetOptionLocalization({
	WarnEmerge		= "为钻出地面显示警告",
	WarnSubmerge	= "为钻进地里显示警告",
	TimerEmerge		= "为钻出地面显示计时条",
	TimerSubmerge	= "为钻进地里显示计时条",
	CrystalArrow	= "当你附近的人中了$spell:81634时显示DBM箭头",
	RangeFrame		= "显示距离框 (5码)"
})

--------------
-- Slabhide --
-------------- 
L= DBM:GetModLocalization(111)

L:SetWarningLocalization({
	WarnAirphase			= "空中阶段",
	WarnGroundphase			= "地面阶段",
	specWarnCrystalStorm	= "水晶风暴 - 寻找掩护"
})

L:SetTimerLocalization({
	TimerAirphase			= "下一次空中阶段",
	TimerGroundphase		= "下一次地面阶段"
})

L:SetOptionLocalization({
	WarnAirphase			= "当岩皮升空时显示警告",
	WarnGroundphase			= "当岩皮降落时显示警告",
	TimerAirphase			= "为下一次空中阶段显示计时条",
	TimerGroundphase		= "为下一次地上阶段显示计时条",
	specWarnCrystalStorm	= "为$spell:92265显示特别警告"
})

-----------
-- Ozruk --
----------- 
L= DBM:GetModLocalization(112)

-------------------------
-- High Priestess Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "%s收回了他的旋风之盾！"
}

--------------
-- Altairus --
-------------- 
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

L:SetOptionLocalization({
	SpecWarnStaticCling	= "为$spell:87618显示特别警告"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "跳！"
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------ 
L= DBM:GetModLocalization(101)

-----======-----------
-- Commander Ulthok --
---------------------- 
L= DBM:GetModLocalization(102)

-------------------------
-- Erunak Stonespeaker --
-------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------ 
L= DBM:GetModLocalization(104)

L:SetTimerLocalization{
	TimerPhase		= "第二阶段"
}

L:SetOptionLocalization{
	TimerPhase		= "为第二阶段显示计时条"
}

----------------
--  Zul'Aman  --
----------------
--  Akil'zon --
---------------
L= DBM:GetModLocalization(186)

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97300),
	RangeFrame	= "显示距离框(10码)",
	StormArrow	= "为$spell:97300显示DBM箭头",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

---------------
--  Nalorakk --
---------------
L= DBM:GetModLocalization(187)

L:SetWarningLocalization{
	WarnBear		= "熊形态",
	WarnBearSoon	= "5秒后熊形态",
	WarnNormal		= "人形态",
	WarnNormalSoon	= "5秒后人形态"
}

L:SetTimerLocalization{
	TimerBear		= "熊形态",
	TimerNormal		= "人形态"
}

L:SetOptionLocalization{
	WarnBear		= "为熊形态显示警告",
	WarnBearSoon	= "为熊形态显示预先警告",
	WarnNormal		= "为人形态显示警告",
	WarnNormalSoon	= "为人形态显示预先警告",
	TimerBear		= "为熊形态显示计时条",
	TimerNormal		= "为人形态显示计时条",
	InfoFrame		= "在信息框显示中了$spell:42402的玩家"
}

L:SetMiscLocalization{
	YellBear 		= "你们召唤野兽？你马上就要大大的后悔了！",
	YellNormal		= "纳洛拉克，变形，出发！",
	PlayerDebuffs	= "刚被冲锋过"
}

---------------
--  Jan'alai --
---------------
L= DBM:GetModLocalization(188)

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "烧死你们！",
	YellHatchAll= "现在，让我来告诉你们什么叫……数量优势。",
	YellAdds	= "孵化者呢？快去孵蛋！"
}

--------------
--  Halazzi --
--------------
L= DBM:GetModLocalization(189)

L:SetWarningLocalization{
	WarnSpirit	= "灵魂阶段",
	WarnNormal	= "普通阶段"
}

L:SetOptionLocalization{
	WarnSpirit	= "为灵魂阶段显示警告",
	WarnNormal	= "为普通阶段显示警告"
}

L:SetMiscLocalization{
	YellSpirit	= "狂野的灵魂与我同在……",
	YellNormal	= "灵魂，到我这里来！"
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L= DBM:GetModLocalization(190)

L:SetTimerLocalization{
	TimerSiphon	= "%s：%s"
}

L:SetOptionLocalization{
	TimerSiphon	= "为$spell:43501显示计时条"
}

L:SetMiscLocalization{
	YellPull	= "阴影将会降临在你们头上……"
}

-------------
-- Daakara --
-------------
L= DBM:GetModLocalization(191)

L:SetTimerLocalization{
	timerNextForm	= "下一次转换形态"
}

L:SetOptionLocalization{
	timerNextForm	= "为转换形态显示计时条",
	InfoFrame		= "在信息框显示中了$spell:42402的玩家",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "刚被冲锋过"
}

-----------------
--  Zul'Gurub  --
-----------------
-- High Priest Venoxis --
-------------------------
L= DBM:GetModLocalization(175)

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow			= "当你中了$spell:96477时显示DBM箭头"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L= DBM:GetModLocalization(176)

L:SetWarningLocalization{
	WarnRevive		= "剩余%d个灵魂",
	SpecWarnOhgan	= "奥根复活了！" -- check this, i'm not good at English
}

L:SetOptionLocalization{
	WarnRevive		= "通告还剩余多少救赎的灵魂",
	SpecWarnOhgan	= "当奥根复活的时候显示警告", -- check this, i'm not good at English
	SetIconOnOhgan	= "当奥根复活时自动为其添加标记" 
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
L= DBM:GetModLocalization(177)

---------------
-- Hazza'rah --
---------------
L= DBM:GetModLocalization(178)

--------------
-- Renataki --
--------------
L= DBM:GetModLocalization(179)

---------------
-- Wushoolay --
---------------
L= DBM:GetModLocalization(180)

----------------------------
-- High Priestess Kilnara --
----------------------------
L= DBM:GetModLocalization(181)

L:SetMiscLocalization{
	WaveAgony	= "感受我的痛楚！"
}

------------
-- Zanzil --
------------
L= DBM:GetModLocalization(184)

L:SetWarningLocalization{
	SpecWarnToxic	= "去点绿锅"
}

L:SetOptionLocalization{
	SpecWarnToxic	= "当你没有$spell:96328时显示特别警告",
	InfoFrame		= "在信息框显示没有$spell:96328的玩家",
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "没有点绿锅"
}

----------------------------
-- Jindo --
----------------------------
L= DBM:GetModLocalization(185)

L:SetWarningLocalization{
	WarnBarrierDown	= "哈卡之链被破坏 - 剩余 %d/3"
}

L:SetOptionLocalization{
	WarnBarrierDown	= "当哈卡之链被破坏时显示警告",
	BodySlamIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97198)
}

L:SetMiscLocalization{
	Kill			= "你太放肆了，金度，你竟敢把远远凌驾于你的力量当作儿戏。难道你忘了我是谁？难道你忘了我能做什么？"
}

----------------
--  End Time  --
-------------------
-- Echo of Baine --
-------------------
L= DBM:GetModLocalization(340)

-------------------
-- Echo of Jaina --
-------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "炙焰之核爆炸"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "为$spell:101927显示计时条"
}

----------------------
-- Echo of Sylvanas --
----------------------
L= DBM:GetModLocalization(323)

---------------------
-- Echo of Tyrande --
---------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "你根本不明白你究竟干了什么。阿曼苏尔……我……看到……的……"
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L= DBM:GetModLocalization(290)

L:SetMiscLocalization{
	Pull		= "没有凡人能从我手中逃脱！"
}

-------------
-- Azshara --
-------------
L= DBM:GetModLocalization(291)

L:SetWarningLocalization{
	WarnAdds	= "新的小怪即将出现"
}

L:SetTimerLocalization{
	TimerAdds	= "下一批小怪"
}

L:SetOptionLocalization{
	WarnAdds	= "新的小怪激活时显示警告",
	TimerAdds	= "为下一批小怪激活显示计时条"
}

L:SetMiscLocalization{
	Kill		= "够了！我虽然好客，但现在必须要去处理更重要的事情了。"
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L= DBM:GetModLocalization(292)

L:SetTimerLocalization{
	TimerTyrandeHelp	= "泰兰德需要帮助"
}

L:SetOptionLocalization{
	TimerTyrandeHelp	= "为泰兰德需要帮助显示计时条"
}

L:SetMiscLocalization{
	Kill		= "玛法里奥，他成功了！传送门崩溃了！"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L= DBM:GetModLocalization(322)

L:SetTimerLocalization{
	TimerCombatStart	= "战斗开始"
}

L:SetOptionLocalization{
	TimerCombatStart	= "为战斗开始显示计时条"
}

L:SetMiscLocalization{
	Event		= "现身吧！",
	Pull		= "暮光大军出现在峡谷上方的悬崖边。"
}

----------------------
-- Asira Dawnslayer --
----------------------
L= DBM:GetModLocalization(342)

L:SetMiscLocalization{
	Pull		= "……解决了那东西，你和这群乌合之众就是我的下一个目标。唔，我还以为你们根本到不了这儿！"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L= DBM:GetModLocalization(341)

L:SetTimerLocalization{
	TimerCombatStart	= "战斗开始"
}

L:SetOptionLocalization{
	TimerCombatStart	= "为战斗开始显示计时条"
}

L:SetMiscLocalization{
	Event		= "萨满，你会把巨龙之魂交给我。"
}

--------------------
--  World Bosses  --
-------------------------
-- Akma'hat --
-------------------------
L = DBM:GetModLocalization("Akmahat")

L:SetGeneralLocalization{
	name = "阿卡玛哈特"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "加尔（大地的裂变）"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "厄运尤拉克"
}

L:SetOptionLocalization{
	SetIconOnMC	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(93621)
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "魔布斯"
}

-------------
-- Xariona --
-------------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "埃克萨妮奥娜"
}
