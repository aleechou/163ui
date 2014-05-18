if GetLocale() ~= "zhTW"  then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCrystal = "下一次寇魔召喚水晶",
	KohcromStomp = "下一次寇魔踐踏"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	KohcromWarning	= "顯示$journal:4262的技能警告",
	KohcromCrystal = "為下一次$journal:4262的$spell:103639顯示計時器",
	KohcromStomp = "為下一次$journal:4262的$spell:103414顯示計時器",
	OnlyMorchok		= "僅顯示魔寇的技能報警和計時器",
	OnlyKohcrom		= "僅顯示寇魔的技能報警和計時器",
	RangeFrame		= "為成就顯示距離框(5碼)"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetTimerLocalization({
	timerPhaseTwo		= "第二階段"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	timerPhaseTwo		= "為第二阶段強制開始顯示計時器(隨機團隊模式)",
	CustomRangeFrame	= "距離框設定(英雄模式)",
	Never				= "不顯示",
	Normal				= "普通距離框顯示",
	DynamicPhase2		= "二階段減益過濾",
	DynamicAlways		= "全時段減益過濾",
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
	timerOozesReach		= "軟泥接觸到王"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	warnOozesHit		= "警告王吞噬了何種軟泥",
	timerOozesReach		= "顯示軟泥接觸到王的計時",
	RangeFrame			= "為$spell:104898顯示距離框(4碼)",
	ColorPGDB				= "紫-綠-黑-藍 組合(英雄模式)",
	ColorGRBD				= "綠-紅-藍-黑 組合(英雄模式)",
	ColorGYDR				= "綠-黃-黑-紅 組合(英雄模式)",
	ColorBPGY				= "藍-紫-綠-黃 組合(英雄模式)",
	ColorBDPY				= "藍-黑-紫-黃 組合(英雄模式)",
	ColorPRYD				= "紫-紅-黃-黑 組合(英雄模式)",
	KGreen				= "殺綠",
	KBlack				= "殺黑",
	KBlue				= "殺藍",
	KYellow				= "殺黃",
	KPurple				= "殺紫",
	oozesArrow		= "為目標軟泥的出現位置顯示DBM箭頭"
})

L:SetMiscLocalization({
	Black			= "|cFF424242黑|r",
	Purple			= "|cFF9932CD紫|r",
	Red				= "|cFFFF0404紅|r",
	Green			= "|cFF088A08綠|r",
	Blue			= "|cFF0080FF藍|r",
	Yellow			= "|cFFFFA901黃|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: %d 剩餘",
	warnFrostTombCast		= "%s 在八秒後",
	specWarnLightningPhase		= "閃電階段",
	specWarnFrozenPhase		= "冰霜階段"
})

L:SetTimerLocalization({
	TimerSpecial			= "第一次冰/電階段"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	WarnPillars				= "警告還剩餘多少$journal:3919或$journal:4069",
	TimerSpecial			= "為第一次冰/電階段顯示計時器",
	RangeFrame				= "為電階段顯示距離框(10碼)",
	AnnounceFrostTombIcons	= "為$spell:104451的目標發佈圖示至團隊頻道\n(需要團隊隊長)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	specWarnLightningPhase		= "為閃電階段顯示特別警告",
	specWarnFrozenPhase		= "為冰霜階段顯示特別警告",
	SetIconOnLance		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105316),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnShatteringIce		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105289),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	DispelYell        = "當你中了$spell:109325並進入$spell:110317時大喊補師驅散",
	SetBubbles				= "當$spell:104451時自動禁用對話泡泡"
})

L:SetMiscLocalization({
	YellIceLance   = "幫我擋線!!!",
	YellDispel   = "驅散我",
	TombIconSet				= "寒冰之墓標記{rt%d}設置於 %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "5秒後%s(%d)"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "王激活"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	holditHoT1 = "暮光之時 1 施放時播放語音提醒你開啟減傷技能",
	holditHoT2 = "暮光之時 2 施放時播放語音提醒你開啟減傷技能",
	holditHoT3 = "暮光之時 3 施放時播放語音提醒你開啟減傷技能",
	holditHoT4 = "暮光之時 4 施放時播放語音提醒你開啟減傷技能",
	holditHoT5 = "暮光之時 5 施放時播放語音提醒你開啟減傷技能",
	holditHoT6 = "暮光之時 6 施放時播放語音提醒你開啟減傷技能",
	holditHoT7 = "暮光之時 7 施放時播放語音提醒你開啟減傷技能",
	SpecWarnHoTN		= "暮光審判前5秒顯示特別警告(每3輪重置)",
	Never				= "不警告",
	One					= "第一組(1、4、7次)",
	Two					= "第二組(2、5次)",
	Three				= "第三組(3、6次)",
	TimerCombatStart	= "為王降落地面顯示計時器"
})

L:SetMiscLocalization({
	Pull				= "我感到平衡被一股強大的波動干擾。如此混沌在燃燒我的心靈!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "暮光精英!"
})

L:SetTimerLocalization({
	TimerCombatStart	= "戰鬥開始",
	TimerAdd	= "下一次精英暮光"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SetIconOnConsumingShroud		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(110214),
	SetIconOnShockwave		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108046),
	TimerCombatStart	= "為戰鬥開始時間顯示計時器",
	TimerAdd	= "為下一次精英暮光出現顯示計時器",
	SpecWarnElites		= "為暮光精英出現顯示特別警告",
	SetTextures			= "一階段禁用投影材質(二階段自動開啟)",
	holditslaught1 = "暮光突襲 1 施放時播放語音提醒你開啟減傷技能",
	holditslaught2 = "暮光突襲 2 施放時播放語音提醒你開啟減傷技能",
	holditslaught3 = "暮光突襲 3 施放時播放語音提醒你開啟減傷技能",
	holditslaught4 = "暮光突襲 4 施放時播放語音提醒你開啟減傷技能",
	holditslaught5 = "暮光突襲 5 施放時播放語音提醒你開啟減傷技能"
})

L:SetMiscLocalization({
	SapperEmote			= "一頭龍急速飛來，載送一名暮光工兵降落到甲板上!",
	GorionaRetreat			= "痛苦嘶吼，躲入旋繞的雲裡。",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnAmaLowHP			= "停止攻擊!融合體還需吸收%d血液!",
	SpecWarnTendril			= "即將傾斜, 你還未被固定!"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SpecWarnAmaLowHP			= "當融合體血量過低且未吸滿9個血時顯示特別警告",
	SpecWarnTendril			= "當你沒有$spell:105563減益時顯示特別警告",
	InfoFrame				= "在資訊框顯示地面殘留的殘渣數量",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105490),
	SetIconOnDeath		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(106199),
	SetIconOnEarth		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(106200),
	ShowShieldInfo			= "為$spell:105479顯示血量條"
})

L:SetMiscLocalization({
	Pull		= "他的護甲!他正在崩壞!破壞他的護甲，我們就有機會打贏他了!",
	BloodCount	= "殘渣數量",
	PlasmaTarget	= "燃燒血漿: %s",
	DRoll		= "他準備往左",
	DRollR		= "他準備往右",
	DLevels			= "回復平衡"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetTimerLocalization({
	TimerMutant  = "下一次 突變腐化"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	TimerMutant	= "為下一次突變腐化出現顯示計時器",
	RangeFrame			= "為$spell:108649顯示自動減益過濾的距離框(英雄模式)",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649),
	SetIconOnCrush	= "為每個平臺$spell:106385的固定2個目標設定標記(10人模式)"
})

L:SetMiscLocalization({
	Pull				= "你們都徒勞無功。我會撕裂你們的世界。"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"巨龍之魂小怪"
})

L:SetWarningLocalization({
	DrakesLeft			= "暮光飛龍剩餘: %d"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s"--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "警告還剩餘多少暮光飛龍未出現",
	TimerDrakes			= "為暮光飛龍$spell:109904顯示計時器"
})

L:SetMiscLocalization({
	EoEEvent			= "沒有用，巨龍之魂的力量太強了。",--Partial
	UltraxionTrash		= "很高興又見到你，雅立史卓莎。我離開這段時間忙得很。",
	UltraxionTrashEnded = "這些幼龍、實驗品，只不過是實現更偉大目標的手段罷了。你會看到研究的龍蛋有什麼成果。"
})

