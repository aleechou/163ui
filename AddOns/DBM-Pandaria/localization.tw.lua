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
	Pull					= "Then let us begin.",
	Victory					= "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places."
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
	Pull					= "The trial begins!",
	Wave1					= "Do not let your judgement be clouded in trying times!",
	Wave2					= "Listen to your inner voice, and seek out the truth!",
	Victory					= "Your wisdom has seen you through this trial. May it ever light your way out of dark places."
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetOptionLocalization({
	SoundWOP				= "語音警告：重要技能"
})

L:SetMiscLocalization({
	Pull					= "We shall see.",
--	Victory					= "",
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
	Pull					= "Ha ha! The trial commences",
	Victory					= "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you."
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