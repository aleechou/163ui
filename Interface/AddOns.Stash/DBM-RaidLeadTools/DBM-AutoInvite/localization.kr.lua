--    * koKR: BlueNyx(bluenyx@gmail.com)/nBlueWiz(everfinale@gmail.com)
if GetLocale() ~= "koKR" then return end

local L = DBM_AutoInvite_Translations

L.TabCategory_AutoInvite 	= "자동 초대"
L.AreaGeneral 				= "일반 설정"
L.AllowGuildMates 			= "길드원을 자동 초대"
L.AllowFriends 				= "친구를 자동 초대"
L.AllowOthers 				= "모든 사람을 자동 초대"
L.Activate 					= "특정 단어로 된 귓속말을 받을 때 자동 초대"
L.KeyWord 					= "자동 초대를 위한 귓속말 단어"
L.InviteFailed 				= "%s 님을 초대 할 수 없습니다."
L.ConvertRaid 				= "공격대 구성"
L.WhisperMsg_RaidIsFull		= "죄송합니다. 공격대 인원이 꽉차서 당신을 초대할 수 없습니다."
L.WhisperMsg_NotLeader 		= "죄송합니다. 저에게 초대 권한이 없어서 당신을 초대할 수 없습니다."
L.WarnMsg_NoRaid			= "전체 초대를 하기전에 먼저 공격대를 구성해 주세요."
L.WarnMsg_NotLead			= "공격대 초대 권한이 없습니다."
L.WarnMsg_InviteIncoming	= "<DBM> 전체 초대 중입니다! 현재 파티를 탈퇴해주세요."
L.Button_AOE_Invite			= "전체 초대"
L.AOEbyGuildRank			= "지정된 등급 이하의 모든 길드원 초대"

-- RaidInvite Options
L.AreaRaidOptions			= "공격대 승급 설정"
L.PromoteEveryone			= "공격대 초대시 자동 승급 (권장하지 않음)"
L.PromoteGuildRank			= "길드 등급에 따른 자동 승급"
L.PromoteByNameList			= "다음 목록의 공격대원은 자동으로 승급 (띄어쓰기로 구분)"

L.DontPromoteAnyRank		= "사용하지 않음"

L.Button_ResetSettings		= "초기화"