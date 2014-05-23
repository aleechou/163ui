﻿if GetLocale() ~= "koKR" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s : %s (%s)",
	warnEcho			= "메아리 생성",
	warnEchoDown		= "메아리 처치",
	specwarnAttenuation	= "%s : %s (%s)",
	specwarnPlatform	= "단상 이동!"
})

L:SetOptionLocalization({
	warnEcho			= "메아리 생성 알림 보기",
	warnEchoDown		= "메아리 처치 알림 보기",
	specwarnPlatform	= "단상 이동 특수 경고 보기",
	ArrowOnAttenuation	= "$spell:127834 활성화 중에 이동해야 될 방향을 DBM 화살표로 보기"
})

L:SetMiscLocalization({
	Platform			= "황실 장로 조르로크가 단상으로 날아갑니다!",
	Defeat				= "우리는 어두운 공허의 절망에 지지 않으리라. 우리가 죽는 것이 그분의 뜻이라면, 그대로 따르리라."
})

------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "보라색 원 바깥으로 나가세요!"
})

L:SetOptionLocalization({
	specwarnUnder	= "가랄론의 보라색 원 안에 있을때 특수 경고 보기",
	countdownCrush	= DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(122774).."(영웅 난이도만)"
})

L:SetMiscLocalization({
	UnderHim	= "있는 것을 감지하고",
	Phase2		= "장갑이 갈라지면서 쪼개지기"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s : >%s< (%d)",
	warnReshapeLifeTutor		= "1: 대상 차단/중첩 생성, 2: 본인 차단, 3: 체력/의지력 회복(주로 3단계에서 사용), 4: 피조물에서 탈출(1,2단계에서 사용)",
	warnAmberExplosion			= "주문시전 %2$s : >%1$s<",
	warnAmberExplosionAM		= "호박석 괴수가 호박석 폭발 시전 중 - 지금 차단!",--personal warning.
	warnInterruptsAvailable		= "%s의 호박석 폭발 차단 가능: >%s<",
	warnWillPower				= "현재 의지력 : %s",
	specwarnWillPower			= "의지력 낮음 - 피조물에서 탈출하거나 바닥을 드세요!",
	specwarnAmberExplosionYou	= "당신에게 %s 사용 - 2번으로 차단!",
	specwarnAmberExplosionAM	= "%s 시전: %s - 1번으로 차단!",
	specwarnAmberExplosionOther	= "%s 시전: %s - 1번으로 차단!"
})

L:SetTimerLocalization({
	timerDestabalize			= "불안정화 (%2$d) : %1$s",
	timerAmberExplosionAMCD		= "폭발 가능: 호박석 괴수"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "돌연변이 피조물 탑승시 피조물 능력 설명 보기",
	warnAmberExplosion			= "$spell:122398 시전 알림 보기(당신 포함)",
	warnAmberExplosionAM		= "호박석 괴수가 $spell:122402 을 시전할 때 개인 차단 알림 보기",
	warnInterruptsAvailable		= "누가 $spell:122402 을 차단할 수 있는지 알림 보기",
	warnWillPower				= "의지력이 80, 50, 30, 10, 4 일때 알림 보기",
	specwarnWillPower			= "피조물 탑승 도중 의지력이 낮을 때 특수 경고 보기",
	specwarnAmberExplosionYou	= "당신의 피조물이 $spell:122402 을 시전할때 차단 특수 경고 보기",
	specwarnAmberExplosionAM	= "호박석 괴수가 $spell:122402 을 시전할때 차단 특수 경고 보기",
	specwarnAmberExplosionOther	= "탑승자가 없는 피조물이 $spell:122398 을 시전할때 차단 특수 경고 보기",
	timerAmberExplosionAMCD		= "호박석 괴수의 다음 $spell:122402 바 보기",
	InfoFrame					= "의지력 정보를 정보 창으로 보기",
	FixNameplates				= "피조물 탑승시 이름표 겹침 기능 끄기<br/>(전투 종료 후 원래대로 복구됨)"
})

L:SetMiscLocalization({
	WillPower					= "의지력"
})

------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "호박석 덪 생성중 (%d/5)"
})

L:SetOptionLocalization({
	warnAmberTrap		= "$spell:125826 생성 과정 알림 보기", 
	InfoFrame			= "$spell:125390 대상을 정보 창으로 보기"
})

L:SetMiscLocalization({
	PlayerDebuffs		= "시선 집중 대상",
	YellPhase3			= "변명은 이제 지겹다, 여제! 당장 이 멍청이들을 쓸어버리지 않으면 내가 몸소 널 죽이겠다!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name =	"공포의 심장: 일반구간"
})

L:SetOptionLocalization({
	UnseenStrikeArrow	= "$spell:122949 대상이 정해진 경우 DBM 화살표 보기"
})
