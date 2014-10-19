﻿if GetLocale() ~= "zhTW" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s即將到來 - 離開導電水池!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "為$spell:137313施放前或$spell:138732效果消失前顯示特別警告"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "控獸寶珠掉落",
	specWarnOrbofControl	= "控獸寶珠掉落!"
})

L:SetTimerLocalization({
	timerDoor		= "下一個部族的門",
	timerAdds		= "下一波%s"
})

L:SetOptionLocalization({
	warnAdds				= "提示新的小怪跳下",
	warnOrbofControl		= "提示$journal:7092掉落",
	specWarnOrbofControl	= "為$journal:7092掉落顯示特別警告",
	timerDoor				= "為下一個部族的門顯示計時器",
	timerAdds				= "為下一次小怪跳下顯示計時器",
	SetIconOnAdds			= "為台上跳下的小怪設置團隊圖示"
})

L:SetMiscLocalization({
	newForces		= "的門蜂擁而出!",
	chargeTarget	= "用力拍動尾巴!"
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s在%s - 快換目標"
})

L:SetOptionLocalization({
	PHealthFrame		= "為$spell:136442退去前顯示剩餘血量框架(需要首領血量框架開啟)",
	AnnounceCooldowns	= "為團隊冷卻數出$spell:137166施放(數到3)"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s被>%s<使用(還剩餘%d)",
	specWarnCrystalShell	= "取得%s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "當你沒有$spell:137633減益並且血量大於90%時顯示特別警告",
	InfoFrame				= "為玩家沒有$spell:137633顯示訊息框架",
	ClearIconOnTurtles		= "當$journal:7129中了$spell:133971清除團隊圖示",
	AnnounceCooldowns		= "為團隊冷卻數出$spell:134920施放"
})

L:SetMiscLocalization({
	WrongDebuff	= "沒有%s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD	= "下一次吐息"
})

L:SetOptionLocalization({
	timerBreaths			= "為下一次吐息顯示計時器",
	AnnounceCooldowns		= "為團隊冷卻數出暴怒施放",
	Never					= "絕不",
	Every					= "每次(連續)",
	EveryTwo				= "數到2",
	EveryThree				= "數到3",
	EveryTwoExcludeDiff		= "數到2(除了祕法散射)",
	EveryThreeExcludeDiff	= "數到3(除了祕法散射)"
})

L:SetMiscLocalization({
	rampageEnds	= "梅賈拉的怒氣平息了。"
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s %s %s",
	specWarnFlock		= "%s %s %s",
	specWarnBigBird		= "巢穴守護者:%s",
	specWarnBigBirdSoon	= "巢穴守護者即將出現:%s"
})

L:SetTimerLocalization({
	timerFlockCD	= "蛋巢(%d):%s"
})

L:SetOptionLocalization({
	ShowNestArrows	= "為蛋巢孵化顯示DBM箭頭",
	Never			= "從不",
	Northeast		= "藍 - 上層&下層 東北",
	Southeast		= "綠 - 上層&下層 東南",
	Southwest		= "紫 - 下層 西南 & 上層 西南(25)或上層 中間(10)",
	West			= "紅 - 下層 西 & 上層 中間(只有25)",
	Northwest		= "黃 - 下層 & 上層 西北(只有25)",
	Guardians		= "巢穴守護者"
})

L:SetMiscLocalization({
	eggsHatch		= "巢裡的蛋開始孵化了!",
	Upper			= "上層",
	Lower			= "下層",
	UpperAndLower	= "上層和下層",
	TrippleD		= "三個巢(下層x2)",
	TrippleU		= "三個巢(上層x2)",
	NorthEast		= "|cff0000ff東北|r",--Blue
	SouthEast		= "|cFF088A08東南|r",--Green
	SouthWest		= "|cFF9932CD西南|r",--Purple
	West			= "|cffff0000西邊|r",--Red
	NorthWest		= "|cffffff00西北|r",--Yellow
	Middle10		= "|cFF9932CD中間|r",--Purple (Middle is upper southwest on 10 man/LFR)
	Middle25		= "|cffff0000中間|r"--Red (Middle is upper west on 25 man)
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "|cffff0000紅|r:>%s<,|cff0000ff藍|r:>%s<",
	warnBeamHeroic				= "|cffff0000紅|r:>%s<,|cff0000ff藍|r:>%s<,|cffffff00黃|r:>%s<",
	warnAddsLeft				= "霧獸還剩餘:%d",
	specWarnBlueBeam			= "你中了藍光射線 - 避免移動!!",
	specWarnFogRevealed			= "照出%s了!",
	specWarnDisintegrationBeam	= "%s(%s)"
})

L:SetOptionLocalization({
	warnBeam				= "提示射線目標",
	warnAddsLeft			= "提示還剩餘多少霧獸",
	specWarnFogRevealed		= "為照出霧獸顯示特別警告",
	ArrowOnBeam				= "為$journal:6882指示DBM箭頭移動方向",
	InfoFrame				= "為$spell:133795堆疊顯示訊息框架",
	SetParticle				= "開戰後自動將投影材質調為低(離開戰鬥後恢復設定)"
})

L:SetMiscLocalization({
	LifeYell		= "%s中了生命吸取(%d層)"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount		= "突變:%d/5有益和%d有害"
})

L:SetOptionLocalization({
	warnDebuffCount		= "當你吃池水時顯示減益計算警告",
	SetIconOnBigOoze	= "為$journal:6969設定團隊圖示"
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s:>%s<和>%s<交換"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "提示目標被$spell:138618交換"
})

L:SetMiscLocalization({
	Pull	= "血靈球體爆炸了!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s:%s跟%s開盾"
})

L:SetOptionLocalization({
	RangeFrame		= "顯示動態距離框架(當太多人太接近時會動態顯示)",
	InfoFrame		= "為玩家有$spell:136193顯示訊息框架"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight	= "黑夜階段",
	warnDay		= "白天階段",
	warnDusk	= "黃昏階段"
})

L:SetTimerLocalization({
	timerDayCD	= "白天階段",
	timerDuskCD	= "黃昏階段"
})

L:SetMiscLocalization({
	DuskPhase	= "盧凜!借本宮力量!"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "超級充能導雷管階段即將到來",
	warnDiffusionChainSpread	= "%s擴散在>%s<"
})

L:SetTimerLocalization({
	timerConduitCD				= "第一次導管技能冷卻"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "在超級充能導雷管階段前顯示預先特別警告",
	warnDiffusionChainSpread	= "提示$spell:135991擴散的目標",
	timerConduitCD				= "為第一次導管技能冷卻顯示計時器",
	StaticShockArrow			= "當某人中了$spell:135695顯示DBM箭頭",
	OverchargeArrow				= "當某人中了$spell:136295顯示DBM箭頭"
})

L:SetMiscLocalization({
	StaticYell		= "%s中了靜電震擊(%d)"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump	= "動盪生命傳到你身上!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump	= "當$spell:138297傳遞你身上時顯示特別警告",
	SetIconsOnVita			= "為中了$spell:138297和離他最遠的玩家設置團隊圖示"
})

L:SetMiscLocalization({
	Defeat					= "慢著!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name  	="雷霆王座小怪"
})