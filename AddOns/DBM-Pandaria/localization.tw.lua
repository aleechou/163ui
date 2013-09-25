if GetLocale() ~= "zhTW" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能",
	RangeFrame			= "距離監視：$spell:119622",
	HudMAP				= "高級定位監視(HUD)：$spell:119622",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(119622)
})

L:SetMiscLocalization({
	Pull				= "沒錯...沒錯!釋放你的怒火!試著擊敗我!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能"
})

L:SetMiscLocalization({
	Pull				= "把他們的屍體帶給我!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能",
	RangeFrame			= "距離監視：$spell:137511"
})

L:SetMiscLocalization({
	Pull				= "你們竟敢打擾我們的準備工作!贊達拉這次不會再被阻止了!"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	RangeFrame			= "距離監視(10碼)：$spell:136340"
})

L:SetMiscLocalization({
	Pull				= "你感覺到冷風吹過了嗎?"
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	HudMAP					= "高級定位監視(HUD)：$spell:144473",
	SetIconOnBeacon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144473),
	BeaconArrow				= "DBM箭頭：$spell:144473"
})

L:SetMiscLocalization({
	Pull					= "那我們就開始吧。",
	Victory					= "你的希望閃耀，尤其在團結後更是燦爛。即使在最黑暗的地方，它也會照亮你的路途。"
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(11, 144532)
})

L:SetMiscLocalization({
	Pull					= "試煉開始!",
	Wave1					= "別讓你們的判斷被困境蒙蔽!",
	Wave2					= "傾聽你們內心的聲音，找出真相!",
	Victory					= "你們的智慧幫你們度過了考驗。希望智慧能在黑暗中照亮你們的道路。"
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能"
})

L:SetMiscLocalization({
	Pull					= "我們拭目以待。",
	Victory					= "雖然被難以想像的敵人包圍，你的堅毅會讓你堅持下去。在未來要記得這一點。",
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all
})


---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(3, 144642)
})

L:SetMiscLocalization({
	Pull					= "哈哈!試煉開始吧!",
	Victory					= "你很強，比你認知的還要強大。帶著這個信念迎接前方的黑暗，讓它保護你。"
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能",
	HudMAP					= "高級定位監視(HUD)：$spell:144689",
	SetIconOnBurningSoul	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144689),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(8, 144689)
})

L:SetMiscLocalization({
	Pull					= "你將代替我永恆地燃燒!"
})