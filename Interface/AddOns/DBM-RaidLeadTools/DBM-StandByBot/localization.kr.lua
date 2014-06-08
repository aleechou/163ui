if GetLocale() ~= "koKR" then return end

local L = DBM_StandbyBot_Translations

L.InRaidGroup			= "대기하기 전에 먼저 공격대를 떠나야 합니다."
L.LeftRaidGroup 		= "당신은 공격대를 떠났습니다. 포인트를 받고 싶으시다면 \"!sb\" 라고 저에게 귓속말 하는 것을 잊지 마세요!"
L.AddedSBUser			= "대기자 명단에 들어갔습니다. 대기자 명단에서 제외되거나 레이드에 다시 합류 할때까지 기다려 주세요."
L.UserIsAllreadySB		= "이미 대기 중입니다. 대기자 명단에서 삭제를 원하시면 \"!sb off\" 라고 다시 귓속말 해주세요."
L.NotStandby			= "대기자 명단에 당신 이름이 없습니다. \"!sb\" 라고 다시 귓속말 해주세요."
L.NoLongerStandby		= "당신은 이제 대기자가 아닙니다. %d시간 %d분 동안 대기하셨습니다. 고생하셨습니다."

L.PostStandybyList		= "현재 대기자 명단:"

L.Local_AddedPlayer		= "[SB]: %s 님이 대기자 명단에 추가되었습니다."
L.Local_RemovedPlayer	= "[SB]: %s 님은 이제 대기자가 아닙니다."
L.Local_CantRemove		= "해당 플레이어를 삭제할 수 없습니다."
L.Local_CleanList		= "대기자 명단이 삭제되었습니다 (%s 의 요청)"

L.Current_StandbyTime	= "%s 부터 대기한 시간:"
L.DateTimeFormat		= "%c"

L.History_OnJoin		= "[%s]: %s 대기 시작"
L.History_OnLeave		= "[%s]: %s 대기 종료 (%s 분 경과)"
L.SB_History_Saved		= "대기자 목록이 ID %s 로 저장되었습니다."
L.SB_History_NotSaved	= "대기자 명단이 없습니다 --> 대기자 목록 저장 실패"

L.SB_History_Line		= "[ID=%d] %s 레이드 : %d 명 참여"


-- GUI
L.TabCategory_Standby	= "Standby-Bot"
L.AreaGeneral			= "Standby-Bot 일반 설정"
L.Enable				= "Standby-bot 사용 (!sb)"
L.SendWhispers			= "공격대를 떠난 공격대원에게 정보 귓속말 보내기"
L.AreaStandbyHistory	= "대기 기록"
L.NoHistoryAvailable	= "대기자 목록이 기록된 레이드가 없습니다."

L.Button_ResetHistory	= "초기화"
L.SB_Documentation		= [[Standby 모듈은 공격대장에게 공격대가 가득 찼거나 유사한 사유로 인해 현재 레이드를 할 수 없는 플레이어를 관리하는데 도움을 줍니다. 아래 나열된 모든 명령어는 길드 대화로 사용 가능합니다.

!sb               - 대기자 명단 출력
!sb times         - 현재 대기 시간 보기
!sb add <nick>    - <nick>을 대기자에 추가
!sb del <nick>    - <nick>을 대기자에서 삭제
!sb save          - 현재 상태 저장
!sb reset         - 대기자 목록 삭제
!sb history [id]  - 대기자 기록 보기

대기자는 이 모드를 실행중인 플레이어에게 반드시 '!sb' 라고 귓속말을 보내야 합니다. 확인 메세지가 대기자에게 보내질 것입니다. 대기를 종료하려면 '!sb off'라고 귓속말을 하면 됩니다.
]]

L.Button_ShowClients	= "버전 확인"
L.Local_NoRaid			= "이 기능을 사용하기 위해서는 공격대에 참여 해야 합니다."
L.Local_Version			= "%s: %s"	-- Lacrosa: r123	(please don't translate this line)




