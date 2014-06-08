if GetLocale() ~= "ruRU" then return end

local L = DBM_BidBot_Translations

L.Prefix = "[BidBot]: "

L.Whisper_Queue 			= "Запущен другой аукцион. Ваш предмет добавлен в очередь."
L.Whisper_Bid_OK 			= "Ваша ставка в размере %d DKP принята."
L.Whisper_Bid_DEL			= "Ваша ставка удалена!"
L.Whisper_Bid_DEL_failed	= "Вы не можете удалить ставки в режиме открытых торгов"
L.Whisper_InUse 			= "<удалить меня>"
L.Message_StartRaidWarn		= "Ставка на %s - шепнуть: |3-2([%s])!"
L.Message_StartBidding		= "Пожалуйста сделайте ставку на %s, шепнув: |3-2([%s])! Минимальная возможная ставка: %d"
L.Message_DoBidding			= "Остаток времени для %s: %d сек."
L.Message_ItemGoesTo		= "%2$s выигрывает %1$s, за %3$d DKP!"
L.Message_NoBidMade			= "Нет ставки для %s."
L.Message_Biddings			= "%d. %s ставка %d DKP."
L.Message_BiddingsVisible	= "%d игроков сделали ставки на данный предмет."
L.Message_BidPubMessage		= "Новая ставка: %s ставок %d DKP"
L.Disenchant				= "Распыление"

L.PopUpAcceptDKP			= "Сохранить ставку для %s. Для распыление введите значение DKP = 0."


-- GUI
L.TabCategory_BidBot	 	= "BidBot (DKP)"
L.TabCategory_History	 	= "История предмета"
L.AreaGeneral 				= "Основные настройки BidBot"
L.AreaItemHistory			= "История предмета"
L.Enable					= "Включить Bidbot (!bid [item])"
L.ShowinRaidWarn			= "Показать предмет в Объявлении рейду"
L.ChatChannel				= "Использовать чат для вывода"
L.Local						= "только локальный вывод"
L.Guild						= "использовать чат гильдии"
L.Raid						= "использовать чат рейда"
L.Party						= "использовать чат группы"
L.Officer					= "использовать чат офицеров"
L.Error_ChanNotFound		= "неизвестный канал: %s"
L.MinBid					= "Минимальная ставка"
L.Duration					= "Время для ставок в сек (по умолчанию 30)"
L.OutputBids				= "Вывод наивысших ставок (по умолчанию 3)"
L.PublicBids				= "Вывод ставок в чат публичных торгов"
L.PayWhatYouBid				= "Оплата ставки, (иначе вторая ставка + 1)"
L.NoHistoryAvailable		= "История недоступна"

L.Button_ShowClients		= "Показ клиентов"
L.Button_ResetClient		= "сброс bidbot"
L.Local_NoRaid				= "Чтобы использовать эту функцию вы должны быть в рейд группе"

-- PLEASE NEVER ADD THIS LINES OUTSIDE OF THE EN TRANSLATION, ADDON WILL BE BROKEN
L.DateFormat				= "%m/%d/%y %H:%M:%S"	-- DO NOT PASTE TO TRANSLATE, ONLY IN EN FILE!!!
L.Local_Version				= "%s: %s"		-- DO NOT PASTE TO TRANSLATE, ONLY IN EN FILE!!!

