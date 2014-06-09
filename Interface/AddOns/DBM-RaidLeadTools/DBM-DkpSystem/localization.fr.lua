if GetLocale() ~= "frFR" then return end

local L = DBM_DKP_System_Translations

-- Initial translation by Sasmira
-- Last update: 01/12/2011 (by Sasmira)

L.Local_TimeReached 		= "Un nouvel événement RAID basé sur le temps a été crée"
L.Local_NoRaidPresent		= "Merci de joindre un groupe RAID avant de lancer la traque des DKP"
L.Local_RaidSaved		= "A conclu avec succès le RAID en cours"

L.AcceptDKPValue		= "DKP"

L.AreaHistory			= "Evénement Historique"
L.History_Line			= "[%s][%s]: %s (%d)" 		-- [date][zone] Hogger (playercount)

L.LocalError_AddItemNoRaid	= "Il n'y a aucun RAID en cours pour sauvegarder cet objet"

-- GUI
L.TabCategory_DKPSystem	= "Système DKP"
L.AreaGeneral			= "Options du Système DKP"
L.Enable				= "Activer le Système DKP lors de la traque des événements RAID"
L.Enable_StarEvent		= "Créer un événement lors du départ du RAID"
L.Enable_TimeEvents		= "Créer un événement basé sur le temps (e.g. 1 event par heure)"
L.Enable_BossEvents		= "Créer un événement lors de la mort d'un Boss"
L.Enable_SB_Users		= "Compter les joueurs en veille parmi les membres du RAID"
L.Enable_5ppl_tracking		= "Activer la traque au DKP en Instance à 5"

L.BossPoints			= "Points par boss tué"
L.TimePoints			= "Points par événement en temps (e.g. 10 DKP par heure)"
L.StartPoints			= "Points au départ du raid"

L.BossDescription		= "Description pour les boss tués (%s est le nom du boss)"
L.TimeDescription		= "Description des événements en temps"
L.StartDescription		= "Description au départ du raid"

L.TimeToCount			= "toutes les X min"

L.AreaManageRaid		= "Démarrer un nouveau raid ou événement"
L.Button_StartDKPTracking	= "Démarrage de la traque au DKP"
L.Button_StopDKPTracking	= "Arrêt de la traque au DKP"

L.CustomPoint			= "Points à donner"
L.CustomDescription		= "Description pour cet événement"
L.CustomDefault			= "Bien joué, rapide, extra dkp"
L.Button_CreateEvent		= "Créer un événement spécial"
L.Button_ResetHistory		= "RaZ Historique"
L.Local_NoInformation		= "Merci de spécifier les points et nom de cet événement"
L.Local_EventCreated		= "Votre événement a été crée avec succès"
L.Local_StartRaid			= "Démarrer un nouveau raid"
L.Local_Debug_NoRaid		= "Il n'y a pas de joueurs, L'événement n'a pas été crée! Merci de créer l'événement à la main!"

L.AllPlayers				= "Tous les joueurs"

L.TabCategory_History		= "Historique de Raid"

-- PLEASE NEVER ADD THIS LINES OUTSIDE OF THE EN TRANSLATION, ADDON WILL BE BROKEN
L.DateFormat			= "%m/%d/%y %H:%M:%S"	-- DO NOT PASTE TO TRANSLATE, ONLY IN EN FILE!!!
L.Local_Version			= "%s: %s"		-- DO NOT PASTE TO TRANSLATE, ONLY IN EN FILE!!

