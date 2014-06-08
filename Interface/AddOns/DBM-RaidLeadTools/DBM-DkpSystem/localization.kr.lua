if GetLocale() ~= "koKR" then return end

local L = DBM_DKP_System_Translations

L.Local_TimeReached 		= "새로운 시간 기반 이벤트를 만들었습니다."
L.Local_NoRaidPresent		= "DKP 추적기를 사용하기 전에 공격대에 먼저 참여해주세요."
L.Local_RaidSaved			= "현재 레이드를 정상적으로 종료하였습니다."

L.AcceptDKPValue			= "DKP"

L.AreaHistory				= "이벤트 기록"
L.History_Line				= "[%s][%s]: %s (%d)" 		-- [date][zone] Hogger (playercount)

L.LocalError_AddItemNoRaid	= "레이드가 진행중이지 않으므로, 이 아이템을 저장할 수가 없습니다."

-- GUI
L.TabCategory_DKPSystem		= "DKP System"
L.AreaGeneral				= "DKP System 일반 설정"
L.Enable					= "DKP System 사용하기"
L.Enable_StarEvent			= "레이드 시작 이벤트 만들기"
L.Enable_TimeEvents			= "시간 기반 이벤트 만들기(예 : 시간당 1 이벤트)"
L.Enable_BossEvents			= "보스 킬 이벤트 만들기"
L.Enable_SB_Users			= "대기 중인 공격대원도 공격대 멤버로 간주하기"
L.Enable_5ppl_tracking		= "5인 던전에서 DKP 추적 허용"

L.BossPoints				= "보스 킬 포인트"
L.TimePoints				= "시간 포인트(예 : 시간당 10 DKP)"
L.StartPoints				= "레이드 시작 포인트"

L.BossDescription			= "보스 킬 이벤트 설명 (%s 는 보스의 이름)"
L.TimeDescription			= "시간 이벤트 설명"
L.StartDescription			= "레이드 시작 이벤트 설명"

L.TimeToCount				= "X 분 마다"

L.AreaManageRaid			= "레이드 또는 이벤트 만들기"
L.Button_StartDKPTracking	= "DKP 추적 시작"
L.Button_StopDKPTracking	= "DKP 추적 중지"

L.CustomPoint				= "이벤트 포인트"
L.CustomDescription			= "현재 이벤트에 대한 설명"
L.CustomDefault				= "업적 달성, 빠른 진행 기념, 보너스 포인트 등등.."
L.Button_CreateEvent		= "특별 이벤트 만들기"
L.Button_ResetHistory		= "기록 초기화"
L.Local_NoInformation		= "이벤트의 이름과 포인트를 지정해주세요."
L.Local_EventCreated		= "이벤트가 성공적으로 만들어졌습니다."
L.Local_StartRaid			= "새로운 레이드가 시작됐습니다."
L.Local_Debug_NoRaid		= "플레이어가 없으므로 이벤트를 만들수 없습니다! 이벤트를 수동으로 만들어주세요."

L.AllPlayers				= "모든 플레이어"

L.TabCategory_History		= "레이드 기록"
