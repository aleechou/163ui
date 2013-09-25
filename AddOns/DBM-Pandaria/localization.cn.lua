-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 3/2/2013

if GetLocale() ~= "zhCN" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	RangeFrame			= "距离监视（动态）：$spell:119622",
	HudMAP				= "高级定位监视(HUD)：$spell:119622",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(119622)
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能",
	RangeFrame			= "距离监视：$spell:137511"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	RangeFrame			= "距离监视（10码）：$spell:136340"
})


---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	HudMAP					= "高级定位监视(HUD)：$spell:144473",
	SetIconOnBeacon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144473),
	BeaconArrow				= "DBM箭头：$spell:144473"
})

L:SetMiscLocalization({
	Victory					= "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places."
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(11, 144532)
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能"
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(3, 144642)
})

L:SetMiscLocalization({
	Victory					= "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you."
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

L:SetOptionLocalization({
	SoundWOP				= "语音警告：重要技能",
	HudMAP					= "高级定位监视(HUD)：$spell:144689",
	SetIconOnBurningSoul	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144689),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(8, 144689)
})

L:SetMiscLocalization({
	Pull					= "你將代替我永恆地燃燒!"
})