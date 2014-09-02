if GetLocale() ~= "ruRU" then return end

local L = DBM_DKP_System_Translations

L.Local_TimeReached 		= "Создано новое событие рейда основанное по времени"
L.Local_NoRaidPresent		= "Пожылуйста вступите в группу рейда перед началом отслеживания DKP"
L.Local_RaidSaved			= "Текущий рейд успешно закрыт"

L.AcceptDKPValue			= "DKP"

L.AreaHistory				= "История событий"
L.History_Line				= "[%s][%s]: %s (%d)" 		-- [date][zone] Hogger (playercount)

L.LocalError_AddItemNoRaid	= "Нет запущенного рейда для сохранения данного предмета"

-- GUI
L.TabCategory_DKPSystem		= "Система DKP"
L.AreaGeneral				= "Основные настройки системы DKP"
L.Enable					= "Включить систему DKP для отслеживания событий рейда"
L.Enable_StarEvent			= "Создать событие при создании рейда"
L.Enable_TimeEvents			= "Создать событие полагаясь на время (пример: 1 событие в час)"
L.Enable_BossEvents			= "Создать событие при убийстве босса"
L.Enable_SB_Users			= "Количество игроков в резерве"
L.Enable_5ppl_tracking		= "Включить отслеживание DKP в подземельях на 5чел"

L.BossPoints				= "Очков за убийство босса"
L.TimePoints				= "Очков за время события (пример: 10 DKP в час)"
L.StartPoints				= "Очков в начале рейда"

L.BossDescription			= "Описание для убийства босса (%s название босса)"
L.TimeDescription			= "Описание события по времени"
L.StartDescription			= "Описание начала рейда"

L.TimeToCount				= "каждые X мин"

L.AreaManageRaid			= "Начать новое событие или рейд"
L.Button_StartDKPTracking	= "Начать отслеживание DKP"
L.Button_StopDKPTracking	= "остановить отслеживание DKP"

L.CustomPoint				= "Присуждаемые очки"
L.CustomDescription			= "Описание данного события"
L.CustomDefault				= "хорошо сыграли, быстрый заход, призовые dkp"
L.Button_CreateEvent		= "Создать особое событие"
L.Button_ResetHistory		= "Сброс истории"
L.Local_NoInformation		= "Пожалуйста, укажите название данного события и очки"
L.Local_EventCreated		= "Ваше событие успешно создано"
L.Local_StartRaid			= "Начат новый рейд"
L.Local_Debug_NoRaid		= "Событие НЕ создано, нету игроков! Пожалуйста, создайте событие вручную!"

L.AllPlayers				= "все игроки"

L.TabCategory_History		= "История рейда"

-- PLEASE NEVER ADD THIS LINES OUTSIDE OF THE EN TRANSLATION, ADDON WILL BE BROKEN
L.DateFormat				= "%m/%d/%y %H:%M:%S"	-- DO NOT PASTE TO TRANSLATE, ONLY IN EN FILE!!!
L.Local_Version				= "%s: %s"		-- DO NOT PASTE TO TRANSLATE, ONLY IN EN FILE!!

