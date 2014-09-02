if GetLocale() ~= "koKR" then return end

local L = DBM_BidBot_Translations

L.Prefix = "[BidBot]: "

L.Whisper_Queue 			= "다른 경매가 진행 중입니다. 당신의 요청은 예약 되었습니다."
L.Whisper_Bid_OK 			= "당신은 %d DKP로 입찰하였습니다."
L.Whisper_Bid_DEL			= "당신이 입찰이 취소되었습니다!"
L.Whisper_Bid_DEL_failed	= "공개 경매에서는 입찰을 취소할 수 없습니다."
L.Whisper_InUse 			= "<취소>"
L.Message_StartRaidWarn		= "%s 경매를 진행합니다 - [%s] 에게 귓말하세요!"
L.Message_StartBidding		= "지금부터 %s 경매를 진행합니다. [%s] 에게 귓말하세요! 최저 DKP: %d"
L.Message_DoBidding			= "%s 경매 종료까지 남은 시간: %d 초"
L.Message_ItemGoesTo		= "%1$s 경매에서 %2$s 님이 %3$d DKP 로 낙찰되었습니다!"
L.Message_NoBidMade			= "%s 입찰 없음."
L.Message_Biddings			= "%d. %s 입찰가 : %d DKP"
L.Message_BiddingsVisible	= "%d 명이 현재 아이템에 입찰하였습니다."
L.Message_BidPubMessage		= "새로운 경매: %s 입찰가 : %d DKP"
L.Disenchant				= "마력추출"

L.PopUpAcceptDKP			= "%s 경매를 저장합니다. 마력추출인 경우 0 DKP를 입력해 주세요."


-- GUI
L.TabCategory_BidBot	 	= "BidBot (DKP)"
L.TabCategory_History	 	= "아이템 기록"
L.AreaGeneral 				= "BidBot 일반 설정"
L.AreaItemHistory			= "아이템 기록"
L.Enable					= "Bidbot 사용 (!bid [item])"
L.ShowinRaidWarn			= "공격대 경보로 아이템 보이기"
L.ChatChannel				= "경매 진행에 사용할 채널"
L.Local						= "나 자신만 보기"
L.Guild						= "길드"
L.Raid						= "공격대"
L.Party						= "파티"
L.Officer					= "길드 관리자"
L.Error_ChanNotFound		= "알 수 없는 채널: %s"
L.MinBid					= "최소 입찰가"
L.Duration					= "경매 진행 시간 (기본값: 30초)"
L.OutputBids				= "경매 최고 입찰자 출력 (기본값: 3명)"
L.PublicBids				= "공개 경매 진행하기 (입찰에 채널 사용)"
L.PayWhatYouBid				= "입찰가 대로 지불하기, (설정하지 않으면 2등 입찰가 + 1)"
L.NoHistoryAvailable		= "아이템 기록이 없습니다."

L.Button_ShowClients		= "버전 확인"
L.Button_ResetClient		= "초기화"
L.Local_NoRaid				= "이 기능을 사용하기 위해서는 공격대에 참여 해야 합니다."
