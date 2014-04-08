if GetLocale() ~= "zhTW" then return end
local L

-----------------------
-- Brawlers --
-----------------------
L= DBM:GetModLocalization("Brawlers")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:基本設置"
})

L:SetWarningLocalization({
	warnQueuePosition	= "你的排名順位為:%d",
	specWarnYourNext	= "你是下一位!",
	specWarnYourTurn	= "輪到你上場了!"
})

L:SetOptionLocalization({
	warnQueuePosition	= "提示你目前的順位",
	specWarnYourNext	= "當你下一個上場時顯示特別警告",
	specWarnYourTurn	= "輪到你上時顯示特別警告",
	SpectatorMode		= "當旁觀戰鬥時顯示警告/計時器(旁觀者不會顯示個人的特別警告訊息)",
	SpeakOutQueue		= "當順位更新數出你的順位"
})

L:SetMiscLocalization({
	Bizmo			= "畢茲摩",--Alliance
	Bazzelflange	= "老闆貝索佛蘭吉",--Horde
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "第1階",
	Rank2			= "第2階",
	Rank3			= "第3階",
	Rank4			= "第4階",
	Rank5			= "第5階",
	Rank6			= "第6階",
	Rank7			= "第7階",
	Rank8			= "第8階",
	Rank9			= "第9階",
	Rank10			= "第10階",
	Proboskus		= "嗚，真不妙... 抱歉啦，看來要跟你打的就是普羅伯斯庫!",--Alliance
	Proboskus2		= "哈哈哈!你的運氣真的有夠背的!是普羅伯斯庫!哈哈哈哈，我出二十五金賭你會被火燒死!"--Horde
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 1"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 2"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 3"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "在真正的吞齧怪上設置圖示(骷髏)",
	SoundWOP			= "語音警告：重要技能"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 4"
})

L:SetOptionLocalization({
	SetIconOnDominika	= "在真正的幻術師多明妮卡上設置圖示(骷髏)",
	SoundWOP			= "語音警告：重要技能"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 5"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 6"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 7"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能"
})

------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 8"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能"
})


------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部: Rank 9"
})

L:SetOptionLocalization({
	SoundWOP			= "語音警告：重要技能"
})

-------------
-- Rares 1 --
-------------
L= DBM:GetModLocalization("BrawlRare1")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:挑戰卡 1"
})

L:SetOptionLocalization({
	ArrowOnBoxing			= "DBM箭頭：$spell:140868 / $spell:140862 / $spell:140886",
	SoundWOP			= "語音警告：重要技能"
})

-------------
-- Rares 2 --
-------------
L= DBM:GetModLocalization("BrawlRare2")

L:SetGeneralLocalization({
	name = "鬥陣俱樂部:挑戰卡 2"
})

L:SetWarningLocalization({
	specWarnRPS			= "使用 %s!"
})

L:SetOptionLocalization({
	specWarnRPS			= "特别警告： $spell:141206",
	SpeakOutStrikes			= "語音警告： $spell:141190 的堆疊層數",
	SoundWOP			= "語音警告：重要技能"
})

L:SetMiscLocalization({
	rock			= "石頭",
	paper			= "布",
	scissors		= "剪刀"
})