-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 2/25/2012

if GetLocale() ~= "zhCN" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "飓风/微风/暴雨启动",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "特别技能启动!",
	warnSpecialSoon			= "10秒后 特别技能启动!"
})

L:SetTimerLocalization({
	timerSpecial			= "特别技能冷却",
	timerSpecialActive		= "特别技能启动"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	SoundWest = "为西风首领播放额外的警告语音",
	SoundEast = "为东风首领播放额外的警告语音",
	warnSpecial			= "当飓风/微风/暴雨施放时显示警告",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "当特别技能施放时显示特别警告",
	timerSpecial			= "为特别技能冷却显示计时条",
	timerSpecialActive		= "为特别技能持续时间显示计时条",
	warnSpecialSoon			= "特别技能施放前10秒显示预先警告",
	OnlyWarnforMyTarget		= "只显示当前或焦点目标相关的警告\n(隐藏所有其它，这包括进入战斗)"
})

L:SetMiscLocalization({
	gatherstrength			= "开始从剩下的风领主身上获得力量！"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetWarningLocalization({
	warnMovingPosition		= "快速集合至：%s"
})

L:SetTimerLocalization({
	TimerFeedback 			= "回馈 (%d)"
})

L:SetOptionLocalization({
	SoundWOP = "为重要技能播放额外的警告语音",
	warnMovingPosition	= "当三阶段云层出现时提醒玩家应该移动的对应首领身体的位置",
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback			= "为$spell:87904的持续时间显示计时条",
	RangeFrame		= "当中了$spell:89668时显示距离框(20码)"
})

L:SetMiscLocalization({
	Cloudone      = "头部顶端",
	Cloudtwo			= "脖子双肩",
	Cloudthree		= "胸部宝珠上方",
	Cloudfour		= "胸部宝珠下方",
	Cloudfive		= "底部深色云层上方",
	Cloudsix		= "底部深色云层中间"
})
