if GetLocale() ~= "zhTW" then return end
local L

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SetIconOnFixate   = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99559),
	RangeFrame			= "顯示距離框(10碼)"
})

L:SetMiscLocalization({
	EmoteSpinners 	= "燼網紡織者從上方垂盪下來!",
	EmoteSpiderlings 	= "小蜘蛛從牠們的巢穴中被驚動了!"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音"
})

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase		= "階段 %d",
	WarnNewInitiate		= "熾炎猛禽學徒 (%s) 出現"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "階段 %d",
	TimerHatchEggs		= "下次熔岩蛋孵化",
	timerNextInitiate	= "下次熾炎猛禽學徒 (位置-%s)",
	TimerCombatStart	= "戰鬥開始"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	TimerCombatStart	= "為戰鬥開始顯示計時器",
	WarnPhase		= "為每次轉換階段顯示警告",
	WarnNewInitiate		= "為新的熾炎爪擊啟動顯示警告",
	timerNextInitiate	= "為下次熾炎猛禽學徒出現顯示計時器",
	TimerPhaseChange	= "為下次階段轉換顯示計時器",
	TimerHatchEggs		= "為下次熔岩蛋孵化顯示計時器",
	InfoFrame		= "在資訊框架顯示$spell:98734"
})

L:SetMiscLocalization({
	YellPull		= "我現在有新的主人了，凡人!",
	YellPhase2		= "這片天空屬於我。",
	FullPower		= "spell:99925",--This is in the emote, shouldn't need localizing, just msg:find
	LavaWorms		= "熾炎熔岩蟲從地上鑽了出來!",--Might use this one day if i feel it needs a warning for something. Or maybe pre warning for something else (like transition soon)
	East			= "東面",
	West			= "西面",
	Both			= "兩側"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	InfoFrame			= "在資訊框架顯示$spell:99937的堆疊層數",
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99947),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
	warnStrike	= "%s (%d)",
	SpecWarnHealerTouched	= "補師 %s 感染折磨! 注意幫補和自保!"
})

L:SetTimerLocalization({
	timerStrike			= "下一次 %s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "下一次 強化刀刃"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SpecWarnHealerTouched	= "當補師被傳染折磨後顯示特別警告",
	ResetShardsinThrees	= "每3波(25人)/2波(10人)碎片出現後重置$spell:99259計數",
	warnStrike			= "為虐殺打擊或煉獄攻擊顯示警告",
	timerStrike			= "為下一次虐殺打擊或煉獄攻擊顯示計時器",
	TimerBladeActive	= "為當前強化的刀刃顯示持續時間計時器",
	TimerBladeNext		= "為下一次虐殺之刃或煉獄刀刃顯示計時器",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	SetIconOnTorment	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99256),
	ArrowOnCountdown	= "當你中了$spell:99516時顯示DBM箭頭",
	InfoFrame		= "在資訊框架顯示活力火花(補師)/受到折磨(其他職業)的堆疊層數",
	RangeFrame			= "為$spell:99257顯示距離框(5碼)"
})

L:SetMiscLocalization({
	VitalSpark		= GetSpellInfo(99262).." 層數"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetTimerLocalization({
	timerNextSpecial	= "下一次 %s (%d)"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	timerNextSpecial			= "為下一次變身特別技能顯示計時器",
	RangeFrameSeeds				= "為$spell:98450顯示距離框(12碼)",
	RangeFrameCat				= "為$spell:98374顯示距離框(10碼)",
	LeapArrow					= "當$spell:98476在你附近時顯示DBM箭頭",
	InfoFrame			= "在資訊框架顯示燃燒之球的堆疊層數",
	IconOnLeapingFlames			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(98476)
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnRageRagnarosSoon	= "5秒後 %s 於 %s",--Spellname on targetname
	warnSplittingBlow		= "%s 在 %s",--Spellname in Location
	warnEngulfingFlame		= "%s 在 %s",--Spellname in Location
	warnEmpoweredSulf		= "5秒後 %s"--The spell has a 5 second channel, but tooltip doesn't reflect it so cannot auto localize
})

L:SetTimerLocalization({
	timerRageRagnaros		= "%s 於 %s",--Spellname on targetname
	TimerPhaseSons		= "轉換階段結束"
})

L:SetOptionLocalization({
	SoundWOP = "為重要技能播放額外的警告語音",
	SoundBB = "為泡泡隊員播放懼焰和云爆的警告語音",
	warnRageRagnarosSoon		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn:format(101109, GetSpellInfo(101109)),
	warnSplittingBlow	= "為$spell:98951的落點位置顯示報警",
	warnEngulfingFlame	= "為$spell:99171的落點位置顯示報警",
	warnEmpoweredSulf			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(100604, GetSpellInfo(100604)),
	timerRageRagnaros			= DBM_CORE_AUTO_TIMER_OPTIONS.cast:format(101109, GetSpellInfo(101109)),
	TimerPhaseSons		= "為\"烈焰之子階段\"顯示持續時間計時器",
	RangeFrame			= "顯示距離監視框",
	InfoHealthFrame		= "在資訊框架顯示生命值(小於100k血量)",
	MeteorFrame			= "在資訊框架顯示$spell:99849的目標",
	AggroFrame			= "在資訊框架顯示沒有被$journal:2647攻擊的隊員",
	BlazingHeatIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100460)
})

L:SetMiscLocalization({
	East				= "右側位置",
	West				= "左側位置",
	Middle				= "中間位置",
	North				= "近戰位置",
	South				= "遠程位置",
	HealthInfo			= "血量不足100k",
	HasNoAggro			= "非熔火元素目標",
	MeteorTargets		= "隕石目標!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "夠了!我將結束這一切。",--More reliable then adds method.
	TransitionEnded2	= "薩弗拉斯將終結你。",--More reliable then adds method.
	TransitionEnded3	= "跪下吧，凡人們!一切都將結束。",
	Defeat			= "太早了!...你們來的太早了...",
	Phase4				= "太早了..."
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "火源之界小怪"
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "沃坎努斯"
})

L:SetWarningLocalization({
	warnRootsDispel		=	 "悶燒之根!注意!等踐踏完畢再驅散!"
})

L:SetTimerLocalization({
	timerStaffTransition	= "轉換階段結束"
})

L:SetOptionLocalization({
	warnRootsDispel		=	 "為$spell:100146顯示報警",
	timerStaffTransition	= "為轉換階段持續時間顯示計時器"
})

L:SetMiscLocalization({
	StaffEvent			= "諾達希爾木枝對於%S+的碰觸產生了劇烈的反應!",--Reg expression pull match
	StaffTrees			= "燃燒的樹人從地面冒出來協助保衛者!",--Might add a spec warning for this later.
	StaffTransition		= "受折磨的保衛者身上的火焰熄滅了!"
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "塞瑞納爾"
})
