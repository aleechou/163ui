-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 12/29/2012

if GetLocale() ~= "zhCN" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "搏击俱乐部：设置"
})

L:SetWarningLocalization({
	warnQueuePosition	= "你的队列号为 %d",
	specWarnYourNext	= "你是下一个!",
	specWarnYourTurn	= "该你上场了！"
})

L:SetOptionLocalization({
	warnQueuePosition	= "警报：你当前的队列号",
	specWarnYourNext	= "特殊警报：当你下一个登场时",
	specWarnYourTurn	= "特殊警报：轮到玩家登场",
	SpectatorMode		= "在观看比赛时显示警报与计时条<br/>（特殊警报不会同步给其他观众）",
	SpeakOutQueue		= "当你的队列号提升时报数"
})

L:SetMiscLocalization({
	Bizmo			= "比兹莫",
	Bazzelflange	= "Boss Bazzelflange",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "1级",
	Rank2			= "2级",
	Rank3			= "3级",
	Rank4			= "4级",
	Rank5			= "5级",
	Rank6			= "6级",
	Rank7			= "7级",
	Rank8			= "8级",
	Rank9			= "9级",
	Rank10			= "10级",
	Proboskus		= "Oh dear... I'm sorry, but it looks like you're going to have to fight Proboskus.",--Alliance
	Proboskus2		= "Ha ha ha! What bad luck you have! It's Proboskus! Ahhh ha ha ha! I've got twenty five gold that says you die in the fire!"--Horde
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "搏击俱乐部：1级"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "搏击俱乐部：2级"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "搏击俱乐部：3级"
})

L:SetOptionLocalization({
	SetIconOnBlat		= "标记真的软泥",
	SoundWOP			= "语音警告：重要技能"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "搏击俱乐部：4级"
})

L:SetOptionLocalization({
	SetIconOnBlat		= "标记真的幻术师",
	SoundWOP			= "语音警告：重要技能"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "搏击俱乐部：5级"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "搏击俱乐部：6级"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "搏击俱乐部：7级"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "搏击俱乐部：8级"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "搏击俱乐部：9级"
})

L:SetOptionLocalization({
	SoundWOP			= "语音警告：重要技能"
})

-------------
-- Rares 1 --
-------------
L= DBM:GetModLocalization("BrawlRare1")

L:SetGeneralLocalization({
	name = "搏击俱乐部: 挑战卡 1"
})

L:SetOptionLocalization({
	ArrowOnBoxing			= "DBM箭头：$spell:140868 / $spell:140862 / $spell:140886",
	SoundWOP			= "语音警告：重要技能"
})

-------------
-- Rares 2 --
-------------
L= DBM:GetModLocalization("BrawlRare2")

L:SetGeneralLocalization({
	name = "搏击俱乐部:挑战卡 2"
})

L:SetWarningLocalization({
	specWarnRPS			= "使用 %s!"
})

L:SetOptionLocalization({
	specWarnRPS			= "特别警告： $spell:141206",
	SpeakOutStrikes			= "语音警告： $spell:141190 的堆叠层数",
	SoundWOP			= "语音警告：重要技能"
})

L:SetMiscLocalization({
	rock			= "石头",
	paper			= "布",
	scissors		= "剪刀"
})
