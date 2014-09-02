if GetLocale() ~= "frFR" then return end

local L = DBM_StandbyBot_Translations

-- Initial translation by Sasmira
-- Last update: 01/19/2011 (by Sasmira)

L.InRaidGroup		= "Désolé mais vous avez quitté le groupe RAID avant d'aller en Attente."
L.LeftRaidGroup 		= "Vous avez quitté votre groupe RAID. N'oubliez pas de me whisper \"!sb\" Si vous n'êtes pas en Attente."
L.AddedSBUser		= "Vous êtes maintenant en Attente. Merci de rester disponible jusqu'à que nous ayons besoin de vous ou que vous soyez supprimer de la liste SB."
L.UserIsAllreadySB	= "Désolé, vous êtes déjà en attente. Supprimez vous vous même de la liste en me whispant \"!sb off\"."
L.NotStandby		= "Désolé, nous n'êtes actuellement pas enregistré comme membre en Attente. Merci de me whisper \"!sb\"."
L.NoLongerStandby	= "Vous n'êtes plus en Attente. Vous etiez en attente depuis %d heures et %d minutes."

L.PostStandybyList	= "Actuellement en Attente:"

L.Local_AddedPlayer	= "[SB]: %s est en Attente."
L.Local_RemovedPlayer	= "[SB]: %s n'est plus en Attente."
L.Local_CantRemove	= "Désolé, nous ne pouvez pas supprimer de joueur."
L.Local_CleanList		= "La liste SB a été effacée (requête faite par %s)"

L.Current_StandbyTime	= "Temps d'Attente à partir de %s:"
L.DateTimeFormat	= "%c"

L.History_OnJoin		= "[%s]: %s est maintenant en SB"
L.History_OnLeave	= "[%s]: %s quitte SB après %s min"
L.SB_History_Saved	= "La liste d'attente a été sauvegardée avec ID %s."
L.SB_History_NotSaved	= "Aucun joueur était en Attente --> pas d'historique sauvegardé"

L.SB_History_Line	= "[ID=%d] Raid à %s avec %d membres"


-- GUI
L.TabCategory_Standby	= "Standby-Bot"
L.AreaGeneral			= "Options de Standby-Bot"
L.Enable				= "Activer standby-bot (!sb)"
L.SendWhispers			= "Envoyer les infos en whisper des Raidleave aux joueurs"
L.AreaStandbyHistory		= "Historique des Attentes"
L.NoHistoryAvailable		= "Il n'y a aucun RAID de sauvegardé avec des joueurs en attentes"

L.Button_ResetHistory		= "Reset"
L.SB_Documentation	= [[This standby module allows raid leaders to manage players who currently can't raid because of a full raid or something like this. All listed commands can be used in the guildchat. 

!sb               - shows a list of standby players
!sb times         - shows the current standby times
!sb add <nick>    - adds a player to standby
!sb del <nick>    - removes a player from standby
!sb save          - saves the current status
!sb reset         - clears the standby list
!sb history [id]  - shows the standby history

Players who want to be standby have to whisper '!sb' to the player who is running this mod. A confirmation will be send to that player. To get off the standby-list they have to whisper '!sb off'.
]]

L.Button_ShowClients		= "Voir clients"
L.Local_NoRaid			= "Vous devez être dans un groupe RAID pour utiliser cette fonction"
L.Local_Version			= "%s: %s"	-- Lacrosa: r123	(please don't translate this line)




