if GetLocale() ~= "frFR" then return end

local L = DBM_BidBot_Translations

-- Initial translation by Sasmira
-- Last update: 01/19/2011 (by Sasmira)

L.Prefix = "[BidBot]: "

L.Whisper_Queue 			= "Une autre action est en cours d'excécution. Votre Objet a été mis en queue."
L.Whisper_Bid_OK 			= "Votre enchère de %d DKP a été acceptée."
L.Whisper_Bid_DEL			= "Votre enchère a été supprimée !"
L.Whisper_Bid_DEL_failed		= "Vous ne pouvez pas supprimer les enchères lorsque le mode Enchère est ouvert"
L.Whisper_InUse 				= "<supprime moi>"
L.Message_StartRaidWarn		= "Enchère maintenant pour %s - whisper à [%s]!"
L.Message_StartBidding			= "Merci de faire maintenant votre enchère pour %s par whispe [%s]! Proposition la plus basse possible: %d"
L.Message_DoBidding			= "Temps restant pour %s: %d secondes."
L.Message_ItemGoesTo			= "%2$s gagne %1$s pour %3$d DKP!"
L.Message_NoBidMade			= "Il n'y a pas d'enchère pour %s."
L.Message_Biddings			= "%d. %s enchère %d DKP."
L.Message_BiddingsVisible		= "%d  enchères de joueur pour cet objet."
L.Message_BidPubMessage		= "Nouvelle enchère: %s enchères %d DKP"
L.Disenchant				= "Désenchantement"

L.PopUpAcceptDKP			= "Sauvegarder l'enchère pour %s. Pour le désenchantement merci de taper 0 DKP."


-- GUI
L.TabCategory_BidBot	 		= "BidBot (DKP)"
L.TabCategory_History	 		= "Historique des objets"
L.AreaGeneral 				= "Options Générales"
L.AreaItemHistory			= "Historique des objets"
L.Enable					= "Activer Bidbot (!bid [item])"
L.ShowinRaidWarn			= "Afficher l'objet en alerte RAID"
L.ChatChannel				= "Utiliser le Chat pour la sortie"
L.Local					= "Sortie locale seulement"
L.Guild					= "Utiliser le Chat: Guilde"
L.Raid					= "Utiliser le Chat: Raid"
L.Party					= "Utiliser le Chat: Groupe"
L.Officer					= "Utiliser le Chat: Officier"
L.Error_ChanNotFound			= "Canal inconnu pour: %s"
L.MinBid					= "Enchère Minimale"
L.Duration					= "Temps pour enchérir en sec(défaut 30)"
L.OutputBids				= "Combien d'enchère pour la sortie (défaut top 3)"
L.PublicBids					= "Poster les enchères sur le chat pour les enchères publics"
L.PayWhatYouBid				= "Payer le prix de l'enchère, (sinon deuxième offre + 1)"
L.NoHistoryAvailable			= "Pas d'historique valable"

L.Button_ShowClients			= "Voir clients"
L.Button_ResetClient			= "Reset bidbot"
L.Local_NoRaid				= "Vous devez être dans un groupe RAID pour utiliser cette fonction"

-- PLEASE NEVER ADD THIS LINES OUTSIDE OF THE EN TRANSLATION, ADDON WILL BE BROKEN
L.DateFormat				= "%m/%d/%y %H:%M:%S"	-- DO NOT PASTE TO TRANSLATE, ONLY IN EN FILE!!!
L.Local_Version				= "%s: %s"		-- DO NOT PASTE TO TRANSLATE, ONLY IN EN FILE!!!

