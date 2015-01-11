if GetLocale() ~= "koKR" then return end
local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L= DBM:GetModLocalization(156)

L:SetOptionLocalization({
	ShowDrakeHealth		= "풀려난 용의 체력 바 보기(우두머리 체력 바 필요)"
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L= DBM:GetModLocalization(157)

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "$spell:86788이 활성화 중일때도 $spell:86369 경고 보기",
	TwilightBlastArrow		= "$spell:86369 대상이 가까이 있을 경우 DBM 화살표 보기",
	RangeFrame				= "거리 창 보기(10m)",
	BlackoutShieldFrame		= "우두머리 체력 바 사용시 $spell:86788 치유량 바 함께 보기"
})

L:SetMiscLocalization{
	Trigger1				= "들이쉽니다!",
	BlackoutTarget			= "의식 상실: %s"
}

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L= DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow			= "%s 체력 30%% 이하 - 곧 다음 단계!",
	SpecWarnGrounded		= "접지 받으세요!",
	SpecWarnSearingWinds	= "소용돌이 치는 바람 받으세요!"
})

L:SetTimerLocalization({
	timerTransition			= "다음 단계"
})

L:SetOptionLocalization({
	specWarnBossLow			= "우두머리의 체력이 30% 이하로 내려갈 경우 특수 경고 보기",
	SpecWarnGrounded		= "$spell:83581 효과가 없을 경우 특수 경고 보기(~10초 전)",
	SpecWarnSearingWinds	= "$spell:83500 효과가 없을 경우 특수 경고 보기(~10초 전)",
	timerTransition			= "다음 단계 바 보기",
	RangeFrame				= "필요시 거리 창 보기",
	yellScrewed				= "$spell:83099 와 $spell:92307 대상이 동시에 된 경우 대화로 알리기",
	InfoFrame				= "$spell:83581 또는 $spell:83500 없는 대상을 정보 창으로 보기"
})

L:SetMiscLocalization({
	Quake			= "발밑의 땅이 불길하게 우르릉거립니다...",
	Thundershock	= "주변의 공기가 에너지로 진동합니다...",
	Switch			= "우리가 상대하겠다!",--"We will handle them!" comes 3 seconds after this one
	Phase3			= "꽤나 인상적이었다만...",--"BEHOLD YOUR DOOM!" is about 13 seconds after	
	Kill			= "이럴 수가...",
	blizzHatesMe	= "봉화랑 벼락 막대 같이 걸렸어요! 비켜주세요!",
	WrongDebuff		= "%s 없음"
})

----------------
--  Cho'gall  --
----------------
L= DBM:GetModLocalization(167)

L:SetOptionLocalization({
	CorruptingCrashArrow	= "$spell:81685 대상이 가까이 있을 경우 DBM 화살표 보기",
	InfoFrame				= "$journal:3165 정보를 정보 창으로 보기",
	RangeFrame				= "$spell:82235 대상이 된 경우 거리 창(5m) 보기",
	SetIconOnCreature		= "어둠에 물든 창조물에 전술 목표 아이콘 설정"
})

----------------
--  Sinestra  --
----------------
L= DBM:GetModLocalization(168)

L:SetWarningLocalization({
	WarnOrbSoon			= "%d초 후 구슬!",
	SpecWarnOrbs		= "곧 구슬! 조심하세요!",
	warnWrackJump		= "%s 전이 : >%s<",
	warnAggro			= "위협 수준 획득(구슬 예상 대상) : >%s<",
	SpecWarnAggroOnYou	= "위협 수준 획득함! 구슬 조심하세요!"
})

L:SetTimerLocalization({
	TimerEggWeakening 	= "황혼 껍질 사라짐",
	TimerEggWeaken		= "황혼 껍질 재생성",
	TimerOrbs			= "구슬 가능"
})	

L:SetOptionLocalization({
	WarnOrbSoon			= "구슬 예상 초읽기 알림 보기(5초 전부터, 1초 마다)(부정확함)",
	warnWrackJump		= "$spell:89421 전이 알림 보기",
	warnAggro			= "구슬 생성 예상시 위협 수준이 있는 대상 알림 보기",
	SpecWarnAggroOnYou	= "구슬 생성 예상시 위협 수준이 있는 경우 특수 경고 보기(구슬 예상 대상)",
	SpecWarnOrbs		= "구슬 생성 예상 특수 경고 보기(부정확함)",
	TimerEggWeakening  	= "$spell:87654 사라짐 바 보기",
	TimerEggWeaken		= "$spell:87654 재생성 바 보기",
	TimerOrbs			= "구슬 대기시간 바 보기(부정확함)",
	SetIconOnOrbs		= "구슬 생성 예상시 위협 수준이 있는 대상에게 전술 목표 아이콘 설정",
	OrbsCountdown		= "구슬 생성 이전에 초읽기 소리 듣기",
	InfoFrame			= "위협 수준 획득(구슬 예상 대상)을 정보 창으로 보기"
})

L:SetMiscLocalization({
	YellDragon		= "얘들아, 먹어치워라",
	YellEgg			= "이게 약해지는 걸로 보이느냐? 멍청한 놈!",
	HasAggro		= "위협 수준 있음"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"황혼의 요새: 일반구간"
})
