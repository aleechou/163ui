if GetLocale() ~= "koKR" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"
})

L:SetTimerLocalization({
	KohcromCD		= "크초르모 시전: %s"
})

L:SetOptionLocalization({
	KohcromWarning	= "$journal:4262가 사용한 주문 알림 보기(영웅 난이도)",
	KohcromCD		= "$journal:4262가 사용할 주문 바 보기(영웅 난이도)",
	RangeFrame		= "거리 창 보기(5m, 업적 용도)"
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
	ShadowYell			= "$spell:103434 대상이 된 경우 대화로 알리기(영웅 난이도)",
	CustomRangeFrame	= "교란의 그림자 관련 거리 창 설정(영웅 난이도)",
	Never				= "거리 창 사용안함",
	Normal				= "일반 거리 창",
	DynamicPhase2		= "고라스의 검은 피 도중에만 숨기기 사용",
	DynamicAlways		= "항상 약화효과 숨기기 사용"
})

L:SetMiscLocalization({
	voidYell	= "굴카와스 언고브 느조스."
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "핏방울 흡수 (%s) : %s"
})

L:SetTimerLocalization({
	timerOozesActive	= "핏방울 공격 가능",
	timerOozesReach		= "핏방울 도착"
})

L:SetOptionLocalization({
	warnOozesHit		= "흡수된 핏방울 알림 보기",
	timerOozesActive	= "핏방울 공격 가능 바 보기",
	timerOozesReach		= "핏방울 도착 바 보기",
	RangeFrame			= "$spell:104898 활성화 중에 거리 창 보기(4m)(일반 난이도 이상)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242검정|r",
	Purple			= "|cFF9932CD보라|r",
	Red				= "|cFFFF0404빨강|r",
	Green			= "|cFF088A08초록|r",
	Blue			= "|cFF0080FF파랑|r",
	Yellow			= "|cFFFFA901노랑|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s : %d 남음",
	warnFrostTombCast		= "8초 후 %s"
})

L:SetTimerLocalization({
	TimerSpecial			= "다음 번개/얼음"
})

L:SetOptionLocalization({
	WarnPillars				= "$journal:3919 또는 $journal:4069 남은횟수 알림 보기",
	TimerSpecial			= "다음 $spell:105256 또는 $spell:105465 바 보기",
	RangeFrame				= "$spell:105269(3m), $journal:4327(10m) 대상이 된 경우 거리 창 보기",
	AnnounceFrostTombIcons	= "$spell:104451 대상을 공격대 대화로 알리기(승급 권한 필요)",
	SpecialCount			= "$spell:105256 또는 $spell:105465 이전에 소리 듣기",
	SetBubbles				= "$spell:104451이 가능할 때 대화 말풍선을 숨김<br/>(전투 종료 후 원상태로 복구됨)"
})

L:SetMiscLocalization({
	TombIconSet				= "얼음 무덤 아이콘 : {rt%d} %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "5초 후 %s! (%d)"
})

L:SetTimerLocalization({
	TimerCombatStart	= "울트락시온 활성화"
})

L:SetOptionLocalization({
	TimerCombatStart	= "울트락시온 활성화 바 보기",
	ResetHoTCounter		= "황혼의 시간 횟수 재시작 설정",
	Never				= "사용 안함",
	ResetDynamic		= "일반 2회, 영웅 3회 단위로 재시작",
	Reset3Always		= "난이도 구분 없이 3회 단위로 재시작",
	SpecWarnHoTN		= "황혼의 시간 5초 전 특수 경고 설정(횟수 재시작 설정 필요)",
	One					= "횟수가 1일때 보기(또는 1, 4, 7 일때)",
	Two					= "횟수가 2일때 보기(또는 2, 5 일때)",
	Three				= "횟수가 3일때 보기(또는 3, 6 일때)"
})

L:SetMiscLocalization({
	Pull				= "엄청난 무언가가 느껴진다. 조화롭지 못한 그의 혼돈이 내 정신을 어지럽히는구나!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "황혼의 정예병!"
})

L:SetTimerLocalization({
	TimerCombatStart	= "전투 시작",
	TimerAdd			= "다음 정예병"
})

L:SetOptionLocalization({
	TimerCombatStart	= "전투 시작 바 보기",
	TimerAdd			= "다음 황혼의 정예병 등장 바 보기",
	SpecWarnElites		= "황혼의 정예병 등장시 특수 경고 보기",
	SetTextures			= "1 단계 진행 도중 텍스쳐 투영 효과 끄기<br/>(2 단계에서 다시 활성화 됩니다.)"
})

L:SetMiscLocalization({
	SapperEmote			= "비룡이 빠르게 날아와 황혼의 폭파병을 갑판에 떨어뜨립니다!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095",
	GorionaRetreat		= "%s|1이;가; 고통에 울부짖으며, 소용돌이치는 구름 속으로 달아납니다."
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	warnSealArmor			= "%s",
	SpecWarnTendril			= "등에 달라 붙으세요!"
})

L:SetOptionLocalization({
	SpecWarnTendril			= "$spell:105563 효과가 없을 경우 특수 경고 보기",
	InfoFrame				= "$spell:105563 없는 대상을 정보 창으로 보기",
	ShowShieldInfo			= "$spell:105479 흡수량 바 보기(우두머리 체력 바 설정 무시)"
})

L:SetMiscLocalization({
	Pull			= "저 갑옷! 놈의 갑옷이 벗겨지는군! 갑옷을 뜯어내면 놈을 쓰러뜨릴 기회가 생길 거요!",
	NoDebuff		= "%s 없음",
	PlasmaTarget	= "이글거리는 혈장: %s",
	DRoll			= "회전하려고",
	DLevels			= "수평으로 균형을"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetOptionLocalization({
	RangeFrame			= "$spell:108649 효과에 맞추어 거리 창 보기(영웅 난이도)"
})

L:SetMiscLocalization({
	Pull				= "넌 아무것도 못 했다. 내가 이 세상을 조각내주마."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"용의 영혼: 일반구간"
})

L:SetWarningLocalization({
	DrakesLeft			= "황혼의 습격자 : %d 남음"
})

L:SetTimerLocalization({
	timerRoleplay		= "이벤트 진행",
	TimerDrakes			= "%s"
})

L:SetOptionLocalization({
	DrakesLeft			= "황혼의 습격자 남은횟수 알림 보기",
	TimerDrakes			= "$spell:109904까지 남은시간 바 보기"
})

L:SetMiscLocalization({
	firstRP				= "티탄을 찬양하라. 그들이 돌아왔다!",
	UltraxionTrash		= "다시 만나 반갑군, 알렉스트라자. 난 떠나 있는 동안 좀 바쁘게 지냈다.",
	UltraxionTrashEnded	= "가련한 녀석들, 이 실험은 위대한 결말을 위한 희생이었다. 알 연구의 결과물을 직접 확인해라."
})