if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial				= "궁극의 힘", --Hurricane/Zephyr/Sleet Storm Active",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "궁극의 힘!",
	warnSpecialSoon			= "10초 후 궁극의 힘"
})

L:SetTimerLocalization({
	timerSpecial			= "다음 궁극의 힘",
	timerSpecialActive		= "궁극의 힘 종료"
})

L:SetOptionLocalization({
	warnSpecial				= "궁극의 힘 알림 보기", -- Show warning when Hurricane/Zephyr/Sleet Storm are cast",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "궁극의 힘 특수 경고 보기",
	timerSpecial			= "다음 궁극의 힘 바 보기",
	timerSpecialActive		= "궁극의 힘 유지시간 바 보기",
	warnSpecialSoon			= "궁국의 힘 이전에 알림 보기(~10초 전)",
	OnlyWarnforMyTarget		= "대상/주시대상으로 선택한 우두머리에 관련된 알림/바만 보기<br/>(선택한 우두머리외 다른 알림/바는 숨김)"
})

L:SetMiscLocalization({
	gatherstrength			= "힘을 모으기 시작합니다!"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetTimerLocalization({
	TimerFeedback 		= "역순환 (%d)"
})

L:SetOptionLocalization({
	TimerFeedback		= "$spell:87904 유지시간 바 보기",
	RangeFrame			= "$spell:89668 대상이 된 경우 거리 창 보기(20m)"
})
