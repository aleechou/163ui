if GetLocale() ~= "ruRU" then return end

local L = DBM_AutoInvite_Translations

L.TabCategory_AutoInvite 	= "Инструмент авто-приглашения"
L.AreaGeneral 			 	= "Основные настройки авто-приглашения"
L.AllowGuildMates 		 	= "Разрешить авто-приглашения от участников гильдии"
L.AllowFriends 			 	= "Разрешить авто-приглашения от друзей"
L.AllowOthers 			 	= "Разрешить авто-приглашения от любого"
L.Activate 			 	 	= "Включить авто-приглашения по ключевому слову"
L.KeyWord 			 	 	= "Ключевое слово шепота для приглашения"
L.InviteFailed 		 		= "Не могу пригласить игрока %s"
L.ConvertRaid 			 	= "Конвертация группы в рейд"
L.WhisperMsg_RaidIsFull 	= "К сожалению, я не могу пригласить вас. Рейд полон."
L.WhisperMsg_NotLeader 		= "К сожалению, я не могу пригласить вас. Я не лидер группы/рейда."
L.WarnMsg_NoRaid		 	= "Пожалуйста создайте рейдовую группу перед использованием массового приглашения"
L.WarnMsg_NotLead		 	= "Извините, вы должны быть лидером или помощником/наводчиком"
L.WarnMsg_InviteIncoming	= "<DBM> Скоро будет произведено массовое приглашение! Пожалуйста, покиньте ваши группы."
L.Button_AOE_Invite		 	= "Массовое приглашение участников гильдии"
L.AOEbyGuildRank		 	= "Пригласить всех игроков этого звания или выше"

-- RaidInvite Options
L.AreaRaidOptions		 	= "Настройки рейда"
L.PromoteEveryone		 	= "Повысить всех игроков (не рекомендуется)"
L.PromoteGuildRank		 	= "Повысить по званию в гильдии"
L.PromoteByNameList		 	= "Авто-повышение следующих игроков (разделение пропуском)"

L.DontPromoteAnyRank		= "Не производить авто-повышение по званию в гильдии"

L.Button_ResetSettings		= "сброс настроек"


