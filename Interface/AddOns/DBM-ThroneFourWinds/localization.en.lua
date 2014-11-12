local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "Hurricane/Zephyr/Sleet Storm Active",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Special Abilities Active!",
	warnSpecialSoon		= "Special Abilities in 10 seconds!"
})

L:SetTimerLocalization({
	timerSpecial		= "Special Abilities CD",
	timerSpecialActive	= "Special Abilities Active"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	SoundWest = "Play Warning Sound for Western Boss",
	SoundEast = "Play Warning Sound for Eastern Boss",
	warnSpecial			= "Show warning when Hurricane/Zephyr/Sleet Storm are cast",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial		= "Show special warning when special abilities are cast",
	timerSpecial		= "Show timer for special abilities cooldown",
	timerSpecialActive	= "Show timer for special abilities duration",
	warnSpecialSoon		= "Show pre-warning 10 seconds before special abilities",
	OnlyWarnforMyTarget	= "Only show warnings/timers for current &amp; focus targets<br/>(Hides the rest. THIS INCLUDES PULL)"
})

L:SetMiscLocalization({
	gatherstrength	= "begins to gather strength"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetWarningLocalization({
	warnMovingPosition		= "Move To: %s"
})

L:SetTimerLocalization({
	TimerFeedback 	= "Feedback (%d)"
})

L:SetOptionLocalization({
	SoundWOP = "Play Extra Warning Sound",
	warnMovingPosition	= "Show anti-cloud moving position during phase 3",
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Show timer for $spell:87904 duration",
	RangeFrame		= "Show range frame (20) when affected by $spell:89668"
})

L:SetMiscLocalization({
	Cloudone      = "Top Head",
	Cloudtwo			= "Neck Shoulder",
	Cloudthree		= "Above Orb",
	Cloudfour		= "Under Orb",
	Cloudfive		= "Above Bottom Dark Cloud",
	Cloudsix		= "Center Bottom Dark Cloud"
})
